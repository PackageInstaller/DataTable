return {
	Play425121001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 425121001
		arg_1_1.duration_ = 6.67

		local var_1_0 = {
			zh = 5.633,
			ja = 6.666
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
				arg_1_0:Play425121002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST2403a == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST2403a")
				var_4_0.name = "ST2403a"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST2403a = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST2403a

				arg_1_1.bgs_.ST2403a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST2403a" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 2.05

			if 2.05 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
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

			if 0.433333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 0.433333333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_4_7_story_interrogation_3", "bgm_activity_4_7_story_interrogation_3", "bgm_activity_4_7_story_interrogation_3.awb")

				local var_4_14 = manager.audio:GetAudioName("bgm_activity_4_7_story_interrogation_3", "bgm_activity_4_7_story_interrogation_3")

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

			if 0.133333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 0.133333333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_147", "se_story_147_amb_interrogation", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_16 = 2
			local var_4_17 = 0.35

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_19 = arg_1_1:GetWordFromCfg(425121001)
				local var_4_20 = arg_1_1:FormatText(var_4_19.content)

				arg_1_1.text_.text = var_4_20

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_22 = 14 <= 0 and var_4_17 or var_4_17 * (utf8.len(var_4_20) / 14)

				if (14 <= 0 and var_4_17 or var_4_17 * (utf8.len(var_4_20) / 14)) > 0 and var_4_17 < var_4_22 then
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

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121001", "story_v_out_425121.awb") ~= 0 then
					local var_4_23 = manager.audio:GetVoiceLength("story_v_out_425121", "425121001", "story_v_out_425121.awb") / 1000

					if var_4_23 + var_4_16 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_23 + var_4_16
					end

					if var_4_19.prefab_name ~= "" and arg_1_1.actors_[var_4_19.prefab_name] ~= nil then
						local var_4_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_19.prefab_name].transform, "story_v_out_425121", "425121001", "story_v_out_425121.awb")

						arg_1_1:RecordAudio("425121001", var_4_24)
						arg_1_1:RecordAudio("425121001", var_4_24)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_425121", "425121001", "story_v_out_425121.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_425121", "425121001", "story_v_out_425121.awb")
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
	Play425121002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 425121002
		arg_9_1.duration_ = 7.73

		local var_9_0 = {
			zh = 6.666,
			ja = 7.733
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
				arg_9_0:Play425121003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0.575

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

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037_split_6")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_1 = arg_9_1:GetWordFromCfg(425121002)
				local var_12_2 = arg_9_1:FormatText(var_12_1.content)

				arg_9_1.text_.text = var_12_2

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 23 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 23)

				if (23 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 23)) > 0 and var_12_0 < var_12_4 then
					arg_9_1.talkMaxDuration = var_12_4

					if var_12_4 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_4 + 0
					end
				end

				arg_9_1.text_.text = var_12_2
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121002", "story_v_out_425121.awb") ~= 0 then
					local var_12_5 = manager.audio:GetVoiceLength("story_v_out_425121", "425121002", "story_v_out_425121.awb") / 1000

					if var_12_5 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_5 + 0
					end

					if var_12_1.prefab_name ~= "" and arg_9_1.actors_[var_12_1.prefab_name] ~= nil then
						local var_12_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_1.prefab_name].transform, "story_v_out_425121", "425121002", "story_v_out_425121.awb")

						arg_9_1:RecordAudio("425121002", var_12_6)
						arg_9_1:RecordAudio("425121002", var_12_6)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_425121", "425121002", "story_v_out_425121.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_425121", "425121002", "story_v_out_425121.awb")
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
	Play425121003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 425121003
		arg_13_1.duration_ = 4.5

		local var_13_0 = {
			zh = 4.5,
			ja = 2.9
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
				arg_13_0:Play425121004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0.525

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037_split_4")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_1 = arg_13_1:GetWordFromCfg(425121003)
				local var_16_2 = arg_13_1:FormatText(var_16_1.content)

				arg_13_1.text_.text = var_16_2

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 21 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 21)

				if (21 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 21)) > 0 and var_16_0 < var_16_4 then
					arg_13_1.talkMaxDuration = var_16_4

					if var_16_4 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_4 + 0
					end
				end

				arg_13_1.text_.text = var_16_2
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121003", "story_v_out_425121.awb") ~= 0 then
					local var_16_5 = manager.audio:GetVoiceLength("story_v_out_425121", "425121003", "story_v_out_425121.awb") / 1000

					if var_16_5 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_5 + 0
					end

					if var_16_1.prefab_name ~= "" and arg_13_1.actors_[var_16_1.prefab_name] ~= nil then
						local var_16_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_1.prefab_name].transform, "story_v_out_425121", "425121003", "story_v_out_425121.awb")

						arg_13_1:RecordAudio("425121003", var_16_6)
						arg_13_1:RecordAudio("425121003", var_16_6)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_425121", "425121003", "story_v_out_425121.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_425121", "425121003", "story_v_out_425121.awb")
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
	Play425121004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 425121004
		arg_17_1.duration_ = 2.77

		local var_17_0 = {
			zh = 1.8,
			ja = 2.766
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
				arg_17_0:Play425121005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0.125

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_1 = arg_17_1:GetWordFromCfg(425121004)
				local var_20_2 = arg_17_1:FormatText(var_20_1.content)

				arg_17_1.text_.text = var_20_2

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_4 = 5 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_2) / 5)

				if (5 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_2) / 5)) > 0 and var_20_0 < var_20_4 then
					arg_17_1.talkMaxDuration = var_20_4

					if var_20_4 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_4 + 0
					end
				end

				arg_17_1.text_.text = var_20_2
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121004", "story_v_out_425121.awb") ~= 0 then
					local var_20_5 = manager.audio:GetVoiceLength("story_v_out_425121", "425121004", "story_v_out_425121.awb") / 1000

					if var_20_5 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_5 + 0
					end

					if var_20_1.prefab_name ~= "" and arg_17_1.actors_[var_20_1.prefab_name] ~= nil then
						local var_20_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_1.prefab_name].transform, "story_v_out_425121", "425121004", "story_v_out_425121.awb")

						arg_17_1:RecordAudio("425121004", var_20_6)
						arg_17_1:RecordAudio("425121004", var_20_6)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_425121", "425121004", "story_v_out_425121.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_425121", "425121004", "story_v_out_425121.awb")
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
	Play425121005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 425121005
		arg_21_1.duration_ = 1.53

		local var_21_0 = {
			zh = 1.533,
			ja = 1.5
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
				arg_21_0:Play425121006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0.075

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

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037_split_4")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_1 = arg_21_1:GetWordFromCfg(425121005)
				local var_24_2 = arg_21_1:FormatText(var_24_1.content)

				arg_21_1.text_.text = var_24_2

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_4 = 3 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_2) / 3)

				if (3 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_2) / 3)) > 0 and var_24_0 < var_24_4 then
					arg_21_1.talkMaxDuration = var_24_4

					if var_24_4 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_4 + 0
					end
				end

				arg_21_1.text_.text = var_24_2
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121005", "story_v_out_425121.awb") ~= 0 then
					local var_24_5 = manager.audio:GetVoiceLength("story_v_out_425121", "425121005", "story_v_out_425121.awb") / 1000

					if var_24_5 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_5 + 0
					end

					if var_24_1.prefab_name ~= "" and arg_21_1.actors_[var_24_1.prefab_name] ~= nil then
						local var_24_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_1.prefab_name].transform, "story_v_out_425121", "425121005", "story_v_out_425121.awb")

						arg_21_1:RecordAudio("425121005", var_24_6)
						arg_21_1:RecordAudio("425121005", var_24_6)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_425121", "425121005", "story_v_out_425121.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_425121", "425121005", "story_v_out_425121.awb")
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
	Play425121006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 425121006
		arg_25_1.duration_ = 3.87

		local var_25_0 = {
			zh = 3.1,
			ja = 3.866
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
				arg_25_0:Play425121007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0.35

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_1 = arg_25_1:GetWordFromCfg(425121006)
				local var_28_2 = arg_25_1:FormatText(var_28_1.content)

				arg_25_1.text_.text = var_28_2

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_4 = 14 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 14)

				if (14 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 14)) > 0 and var_28_0 < var_28_4 then
					arg_25_1.talkMaxDuration = var_28_4

					if var_28_4 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_4 + 0
					end
				end

				arg_25_1.text_.text = var_28_2
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121006", "story_v_out_425121.awb") ~= 0 then
					local var_28_5 = manager.audio:GetVoiceLength("story_v_out_425121", "425121006", "story_v_out_425121.awb") / 1000

					if var_28_5 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_5 + 0
					end

					if var_28_1.prefab_name ~= "" and arg_25_1.actors_[var_28_1.prefab_name] ~= nil then
						local var_28_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_1.prefab_name].transform, "story_v_out_425121", "425121006", "story_v_out_425121.awb")

						arg_25_1:RecordAudio("425121006", var_28_6)
						arg_25_1:RecordAudio("425121006", var_28_6)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_425121", "425121006", "story_v_out_425121.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_425121", "425121006", "story_v_out_425121.awb")
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
	Play425121007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 425121007
		arg_29_1.duration_ = 7.2

		local var_29_0 = {
			zh = 7.2,
			ja = 5.7
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
				arg_29_0:Play425121008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0.55

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037_split_6")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_1 = arg_29_1:GetWordFromCfg(425121007)
				local var_32_2 = arg_29_1:FormatText(var_32_1.content)

				arg_29_1.text_.text = var_32_2

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_4 = 22 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_2) / 22)

				if (22 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_2) / 22)) > 0 and var_32_0 < var_32_4 then
					arg_29_1.talkMaxDuration = var_32_4

					if var_32_4 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_4 + 0
					end
				end

				arg_29_1.text_.text = var_32_2
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121007", "story_v_out_425121.awb") ~= 0 then
					local var_32_5 = manager.audio:GetVoiceLength("story_v_out_425121", "425121007", "story_v_out_425121.awb") / 1000

					if var_32_5 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_5 + 0
					end

					if var_32_1.prefab_name ~= "" and arg_29_1.actors_[var_32_1.prefab_name] ~= nil then
						local var_32_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_1.prefab_name].transform, "story_v_out_425121", "425121007", "story_v_out_425121.awb")

						arg_29_1:RecordAudio("425121007", var_32_6)
						arg_29_1:RecordAudio("425121007", var_32_6)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_425121", "425121007", "story_v_out_425121.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_425121", "425121007", "story_v_out_425121.awb")
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
	Play425121008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 425121008
		arg_33_1.duration_ = 3.8

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play425121009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.mask_.enabled = true
				arg_33_1.mask_.raycastTarget = true

				arg_33_1:SetGaussion(false)
			end

			local var_36_0 = 1

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 then
				local var_36_1 = Color.New(0, 0, 0)

				var_36_1.a = Mathf.Lerp(0, 1, (arg_33_1.time_ - 0) / var_36_0)
				arg_33_1.mask_.color = var_36_1
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 then
				local var_36_2 = Color.New(0, 0, 0)

				var_36_2.a = 1
				arg_33_1.mask_.color = var_36_2
			end

			local var_36_3 = 1

			if 1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_3 + arg_36_0 then
				arg_33_1.mask_.enabled = true
				arg_33_1.mask_.raycastTarget = true

				arg_33_1:SetGaussion(false)
			end

			local var_36_4 = 1

			if var_36_3 <= arg_33_1.time_ and arg_33_1.time_ < var_36_3 + var_36_4 then
				local var_36_5 = Color.New(0, 0, 0)

				var_36_5.a = Mathf.Lerp(1, 0, (arg_33_1.time_ - var_36_3) / var_36_4)
				arg_33_1.mask_.color = var_36_5
			end

			if arg_33_1.time_ >= var_36_3 + var_36_4 and arg_33_1.time_ < var_36_3 + var_36_4 + arg_36_0 then
				local var_36_6 = Color.New(0, 0, 0)

				arg_33_1.mask_.enabled = false
				var_36_6.a = 0
				arg_33_1.mask_.color = var_36_6
			end

			local var_36_7 = "STblack"

			if arg_33_1.bgs_.STblack == nil then
				local var_36_8 = Object.Instantiate(arg_33_1.paintGo_)

				var_36_8:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_36_7)
				var_36_8.name = var_36_7
				var_36_8.transform.parent = arg_33_1.stage_.transform
				var_36_8.transform.localPosition = Vector3.New(0, 100, 0)
				arg_33_1.bgs_[var_36_7] = var_36_8
			end

			if 1 < arg_33_1.time_ and arg_33_1.time_ <= 1 + arg_36_0 then
				local var_36_9 = arg_33_1.bgs_.STblack

				arg_33_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_36_9.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_36_10 = var_36_9:GetComponent("SpriteRenderer")

				if var_36_10 and var_36_10.sprite then
					local var_36_11 = 2 * (var_36_9.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_36_9.transform.localScale = Vector3.New(var_36_11 / var_36_10.sprite.bounds.size.y < var_36_11 * manager.ui.mainCameraCom_.aspect / var_36_10.sprite.bounds.size.x and var_36_11 * manager.ui.mainCameraCom_.aspect / var_36_10.sprite.bounds.size.x or var_36_11 / var_36_10.sprite.bounds.size.y, var_36_11 / var_36_10.sprite.bounds.size.y < var_36_11 * manager.ui.mainCameraCom_.aspect / var_36_10.sprite.bounds.size.x and var_36_11 * manager.ui.mainCameraCom_.aspect / var_36_10.sprite.bounds.size.x or var_36_11 / var_36_10.sprite.bounds.size.y, 0)
				end

				for iter_36_0, iter_36_1 in pairs(arg_33_1.bgs_) do
					if iter_36_0 ~= "STblack" then
						iter_36_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0.133333333333333 < arg_33_1.time_ and arg_33_1.time_ <= 0.133333333333333 + arg_36_0 then
				arg_33_1:AudioAction("play", "effect", "se_story_145", "se_story_145_gold", "")
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 419173,
				charCount = 3,
				enableLayoutChange = true,
				duration = 1,
				groupID = "10082",
				startTime = 1,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.MiddleLeft
				},
				textComProperty = {
					fontSize = 110,
					fontAssetPath = "Fonts/SourceHanSerifCN-Bold-3.0",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperCenter
				},
				effectData = {
					startAlpha = 0,
					endAlpha = 1,
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.ALPHA
				}
			},
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 425121008,
				charCount = 42,
				enableLayoutChange = true,
				duration = 2.8,
				groupID = "10081",
				startTime = 1,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.LowerLeft
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_33_1:InitPlayNodeList()
	end,
	Play425121009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 425121009
		arg_37_1.duration_ = 7.77

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play425121010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = manager.audio:GetVoiceLength("story_v_out_425121", "425121009", "story_v_out_425121.awb") / 1000

			if var_40_0 > 0 and 7.766 < var_40_0 and var_40_0 + 0 > arg_37_1.duration_ then
				arg_37_1.duration_ = var_40_0 + 0
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:AudioAction("play", "voice", "story_v_out_425121", "425121009", "story_v_out_425121.awb")
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 425121009,
				charCount = 26,
				enableLayoutChange = true,
				duration = 1.73333333333333,
				groupID = "1009",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.LowerLeft
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			},
			{
				groupID = "10081",
				duration = 0.0166666666666667,
				className = "StoryTextGroupNode",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			}
		}

		arg_37_1:InitPlayNodeList()
	end,
	Play425121010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 425121010
		arg_41_1.duration_ = 2.73

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play425121011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0.133333333333333 < arg_41_1.time_ and arg_41_1.time_ <= 0.133333333333333 + arg_44_0 then
				arg_41_1:AudioAction("play", "effect", "se_story_141", "se_story_141_amb_bass", "")
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:AudioAction("stop", "effect", "se_story_147", "se_story_147_amb_interrogation", "")
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 425121010,
				charCount = 41,
				enableLayoutChange = true,
				duration = 2.73333333333333,
				groupID = "1010",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.LowerLeft
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			},
			{
				groupID = "1009",
				duration = 0.0166666666666667,
				className = "StoryTextGroupNode",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			}
		}

		arg_41_1:InitPlayNodeList()
	end,
	Play425121011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 425121011
		arg_45_1.duration_ = 5.97

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play425121012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = manager.audio:GetVoiceLength("story_v_out_425121", "425121011", "story_v_out_425121.awb") / 1000

			if var_48_0 > 0 and 5.966 < var_48_0 and var_48_0 + 0 > arg_45_1.duration_ then
				arg_45_1.duration_ = var_48_0 + 0
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:AudioAction("play", "voice", "story_v_out_425121", "425121011", "story_v_out_425121.awb")
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				groupID = "1010",
				duration = 0.0166666666666667,
				className = "StoryTextGroupNode",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			},
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 425121011,
				charCount = 13,
				enableLayoutChange = true,
				duration = 0.866666666666667,
				groupID = "1011",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.LowerLeft
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_45_1:InitPlayNodeList()
	end,
	Play425121012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 425121012
		arg_49_1.duration_ = 3.23

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play425121013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = manager.audio:GetVoiceLength("story_v_out_425121", "425121012", "story_v_out_425121.awb") / 1000

			if var_52_0 > 0 and 3.233 < var_52_0 and var_52_0 + 0 > arg_49_1.duration_ then
				arg_49_1.duration_ = var_52_0 + 0
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:AudioAction("play", "voice", "story_v_out_425121", "425121012", "story_v_out_425121.awb")
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				groupID = "1011",
				duration = 0.0166666666666667,
				className = "StoryTextGroupNode",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			},
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 425121012,
				charCount = 17,
				enableLayoutChange = true,
				duration = 1.13333333333333,
				groupID = "1012",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.LowerLeft
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_49_1:InitPlayNodeList()
	end,
	Play425121013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 425121013
		arg_53_1.duration_ = 4.7

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play425121014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = manager.audio:GetVoiceLength("story_v_out_425121", "425121013", "story_v_out_425121.awb") / 1000

			if var_56_0 > 0 and 4.7 < var_56_0 and var_56_0 + 0 > arg_53_1.duration_ then
				arg_53_1.duration_ = var_56_0 + 0
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:AudioAction("play", "voice", "story_v_out_425121", "425121013", "story_v_out_425121.awb")
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				groupID = "1012",
				duration = 0.0166666666666667,
				className = "StoryTextGroupNode",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			},
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 425121013,
				charCount = 14,
				enableLayoutChange = true,
				duration = 0.933333333333333,
				groupID = "1013",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.LowerLeft
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_53_1:InitPlayNodeList()
	end,
	Play425121014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 425121014
		arg_57_1.duration_ = 13.97

		local var_57_0 = {
			zh = 13.966,
			ja = 13.5
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
				arg_57_0:Play425121015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.mask_.enabled = true
				arg_57_1.mask_.raycastTarget = true

				arg_57_1:SetGaussion(false)
			end

			local var_60_0 = 1

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 then
				local var_60_1 = Color.New(0, 0, 0)

				var_60_1.a = Mathf.Lerp(0, 1, (arg_57_1.time_ - 0) / var_60_0)
				arg_57_1.mask_.color = var_60_1
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 then
				local var_60_2 = Color.New(0, 0, 0)

				var_60_2.a = 1
				arg_57_1.mask_.color = var_60_2
			end

			local var_60_3 = 1

			if 1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_3 + arg_60_0 then
				arg_57_1.mask_.enabled = true
				arg_57_1.mask_.raycastTarget = true

				arg_57_1:SetGaussion(false)
			end

			local var_60_4 = 1

			if var_60_3 <= arg_57_1.time_ and arg_57_1.time_ < var_60_3 + var_60_4 then
				local var_60_5 = Color.New(0, 0, 0)

				var_60_5.a = Mathf.Lerp(1, 0, (arg_57_1.time_ - var_60_3) / var_60_4)
				arg_57_1.mask_.color = var_60_5
			end

			if arg_57_1.time_ >= var_60_3 + var_60_4 and arg_57_1.time_ < var_60_3 + var_60_4 + arg_60_0 then
				local var_60_6 = Color.New(0, 0, 0)

				arg_57_1.mask_.enabled = false
				var_60_6.a = 0
				arg_57_1.mask_.color = var_60_6
			end

			if 1 < arg_57_1.time_ and arg_57_1.time_ <= 1 + arg_60_0 then
				local var_60_7 = arg_57_1.bgs_.ST2403a

				arg_57_1.bgs_.ST2403a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_60_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_60_8 = var_60_7:GetComponent("SpriteRenderer")

				if var_60_8 and var_60_8.sprite then
					local var_60_9 = 2 * (var_60_7.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_60_7.transform.localScale = Vector3.New(var_60_9 / var_60_8.sprite.bounds.size.y < var_60_9 * manager.ui.mainCameraCom_.aspect / var_60_8.sprite.bounds.size.x and var_60_9 * manager.ui.mainCameraCom_.aspect / var_60_8.sprite.bounds.size.x or var_60_9 / var_60_8.sprite.bounds.size.y, var_60_9 / var_60_8.sprite.bounds.size.y < var_60_9 * manager.ui.mainCameraCom_.aspect / var_60_8.sprite.bounds.size.x and var_60_9 * manager.ui.mainCameraCom_.aspect / var_60_8.sprite.bounds.size.x or var_60_9 / var_60_8.sprite.bounds.size.y, 0)
				end

				for iter_60_0, iter_60_1 in pairs(arg_57_1.bgs_) do
					if iter_60_0 ~= "ST2403a" then
						iter_60_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_60_10 = 2

			if 2 < arg_57_1.time_ and arg_57_1.time_ <= var_60_10 + arg_60_0 then
				arg_57_1.allBtn_.enabled = false
			end

			if arg_57_1.time_ >= var_60_10 + 1.73333333333333 and arg_57_1.time_ < var_60_10 + 1.73333333333333 + arg_60_0 then
				arg_57_1.allBtn_.enabled = true
			end

			if arg_57_1.frameCnt_ <= 1 then
				arg_57_1.dialog_:SetActive(false)
			end

			local var_60_11 = 3.3
			local var_60_12 = 1.2

			if 3.3 < arg_57_1.time_ and arg_57_1.time_ <= var_60_11 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0

				arg_57_1.dialog_:SetActive(true)

				arg_57_1.dialogCg_.alpha = 0

				local var_60_13 = LeanTween.value(arg_57_1.dialog_, 0, 1, 0.3)

				var_60_13:setOnUpdate(LuaHelper.FloatAction(function(arg_61_0)
					arg_57_1.dialogCg_.alpha = arg_61_0
				end))
				var_60_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_57_1.dialog_)
					var_60_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_57_1.duration_ = arg_57_1.duration_ + 0.3

				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_14 = arg_57_1:GetWordFromCfg(425121014)
				local var_60_15 = arg_57_1:FormatText(var_60_14.content)

				arg_57_1.text_.text = var_60_15

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_17 = 48 <= 0 and var_60_12 or var_60_12 * (utf8.len(var_60_15) / 48)

				if (48 <= 0 and var_60_12 or var_60_12 * (utf8.len(var_60_15) / 48)) > 0 and var_60_12 < var_60_17 then
					arg_57_1.talkMaxDuration = var_60_17
					var_60_11 = var_60_11 + 0.3

					if var_60_17 + var_60_11 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_17 + var_60_11
					end
				end

				arg_57_1.text_.text = var_60_15
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121014", "story_v_out_425121.awb") ~= 0 then
					local var_60_18 = manager.audio:GetVoiceLength("story_v_out_425121", "425121014", "story_v_out_425121.awb") / 1000

					if var_60_18 + var_60_11 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_18 + var_60_11
					end

					if var_60_14.prefab_name ~= "" and arg_57_1.actors_[var_60_14.prefab_name] ~= nil then
						local var_60_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_14.prefab_name].transform, "story_v_out_425121", "425121014", "story_v_out_425121.awb")

						arg_57_1:RecordAudio("425121014", var_60_19)
						arg_57_1:RecordAudio("425121014", var_60_19)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_425121", "425121014", "story_v_out_425121.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_425121", "425121014", "story_v_out_425121.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_20 = var_60_11 + 0.3
			local var_60_21 = math.max(var_60_12, arg_57_1.talkMaxDuration)

			if var_60_11 + 0.3 <= arg_57_1.time_ and arg_57_1.time_ < var_60_20 + var_60_21 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_20) / var_60_21

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_20 + var_60_21 and arg_57_1.time_ < var_60_20 + var_60_21 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				groupID = "10082",
				duration = 0.0166666666666667,
				className = "StoryTextGroupNode",
				startTime = 1,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			},
			{
				groupID = "1013",
				duration = 0.0166666666666667,
				className = "StoryTextGroupNode",
				startTime = 1,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			}
		}

		arg_57_1:InitPlayNodeList()
	end,
	Play425121015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 425121015
		arg_63_1.duration_ = 2.17

		local var_63_0 = {
			zh = 2.166,
			ja = 1.066
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
				arg_63_0:Play425121016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = 0.075

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				arg_63_1.leftNameTxt_.text = arg_63_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, true)
				arg_63_1.iconController_:SetSelectedState("hero")

				arg_63_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037_split_5")

				arg_63_1.callingController_:SetSelectedState("normal")

				arg_63_1.keyicon_.color = Color.New(1, 1, 1)
				arg_63_1.icon_.color = Color.New(1, 1, 1)

				local var_66_1 = arg_63_1:GetWordFromCfg(425121015)
				local var_66_2 = arg_63_1:FormatText(var_66_1.content)

				arg_63_1.text_.text = var_66_2

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_4 = 3 <= 0 and var_66_0 or var_66_0 * (utf8.len(var_66_2) / 3)

				if (3 <= 0 and var_66_0 or var_66_0 * (utf8.len(var_66_2) / 3)) > 0 and var_66_0 < var_66_4 then
					arg_63_1.talkMaxDuration = var_66_4

					if var_66_4 + 0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_4 + 0
					end
				end

				arg_63_1.text_.text = var_66_2
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121015", "story_v_out_425121.awb") ~= 0 then
					local var_66_5 = manager.audio:GetVoiceLength("story_v_out_425121", "425121015", "story_v_out_425121.awb") / 1000

					if var_66_5 + 0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_5 + 0
					end

					if var_66_1.prefab_name ~= "" and arg_63_1.actors_[var_66_1.prefab_name] ~= nil then
						local var_66_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_1.prefab_name].transform, "story_v_out_425121", "425121015", "story_v_out_425121.awb")

						arg_63_1:RecordAudio("425121015", var_66_6)
						arg_63_1:RecordAudio("425121015", var_66_6)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_425121", "425121015", "story_v_out_425121.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_425121", "425121015", "story_v_out_425121.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_7 = math.max(var_66_0, arg_63_1.talkMaxDuration)

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_7 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - 0) / var_66_7

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= 0 + var_66_7 and arg_63_1.time_ < 0 + var_66_7 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play425121016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 425121016
		arg_67_1.duration_ = 9.07

		local var_67_0 = {
			zh = 6.7,
			ja = 9.066
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
				arg_67_0:Play425121017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 0.625

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_1 = arg_67_1:GetWordFromCfg(425121016)
				local var_70_2 = arg_67_1:FormatText(var_70_1.content)

				arg_67_1.text_.text = var_70_2

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_4 = 25 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_2) / 25)

				if (25 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_2) / 25)) > 0 and var_70_0 < var_70_4 then
					arg_67_1.talkMaxDuration = var_70_4

					if var_70_4 + 0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_4 + 0
					end
				end

				arg_67_1.text_.text = var_70_2
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121016", "story_v_out_425121.awb") ~= 0 then
					local var_70_5 = manager.audio:GetVoiceLength("story_v_out_425121", "425121016", "story_v_out_425121.awb") / 1000

					if var_70_5 + 0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_5 + 0
					end

					if var_70_1.prefab_name ~= "" and arg_67_1.actors_[var_70_1.prefab_name] ~= nil then
						local var_70_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_1.prefab_name].transform, "story_v_out_425121", "425121016", "story_v_out_425121.awb")

						arg_67_1:RecordAudio("425121016", var_70_6)
						arg_67_1:RecordAudio("425121016", var_70_6)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_425121", "425121016", "story_v_out_425121.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_425121", "425121016", "story_v_out_425121.awb")
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
	Play425121017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 425121017
		arg_71_1.duration_ = 4.97

		local var_71_0 = {
			zh = 3.566,
			ja = 4.966
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
				arg_71_0:Play425121018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = 0.325

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_1 = arg_71_1:GetWordFromCfg(425121017)
				local var_74_2 = arg_71_1:FormatText(var_74_1.content)

				arg_71_1.text_.text = var_74_2

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_4 = 13 <= 0 and var_74_0 or var_74_0 * (utf8.len(var_74_2) / 13)

				if (13 <= 0 and var_74_0 or var_74_0 * (utf8.len(var_74_2) / 13)) > 0 and var_74_0 < var_74_4 then
					arg_71_1.talkMaxDuration = var_74_4

					if var_74_4 + 0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_4 + 0
					end
				end

				arg_71_1.text_.text = var_74_2
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121017", "story_v_out_425121.awb") ~= 0 then
					local var_74_5 = manager.audio:GetVoiceLength("story_v_out_425121", "425121017", "story_v_out_425121.awb") / 1000

					if var_74_5 + 0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_5 + 0
					end

					if var_74_1.prefab_name ~= "" and arg_71_1.actors_[var_74_1.prefab_name] ~= nil then
						local var_74_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_1.prefab_name].transform, "story_v_out_425121", "425121017", "story_v_out_425121.awb")

						arg_71_1:RecordAudio("425121017", var_74_6)
						arg_71_1:RecordAudio("425121017", var_74_6)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_425121", "425121017", "story_v_out_425121.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_425121", "425121017", "story_v_out_425121.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_7 = math.max(var_74_0, arg_71_1.talkMaxDuration)

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_7 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - 0) / var_74_7

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= 0 + var_74_7 and arg_71_1.time_ < 0 + var_74_7 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play425121018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 425121018
		arg_75_1.duration_ = 3.63

		local var_75_0 = {
			zh = 3.633,
			ja = 2.433333333332
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
				arg_75_0:Play425121019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_9000

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1:AudioAction("play", "effect", "se_story_147", "se_story_147_electric_shock_01", "")
			end

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				local var_78_1 = arg_75_1.var_.effect10091018

				if not arg_75_1.var_.effect10091018 then
					var_78_1 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_ripple2"), manager.ui.mainCamera.transform)
					var_78_1.name = "1018"
					arg_75_1.var_.effect10091018 = var_78_1
				else
					var_78_1.transform:SetParent(var_78_9000)
				end

				var_78_1.transform.localPosition = Vector3.New(0, 0, 0)
				var_78_1.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_78_1.transform.localScale = Vector3.New(var_78_1.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_78_1.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_78_1.transform.localScale.z)
			end

			local var_78_3 = manager.ui.mainCamera.transform

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.var_.shakeOldPos = var_78_3.localPosition
			end

			local var_78_4 = 0.666666666666667

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_4 then
				local var_78_5, var_78_6 = math.modf((arg_75_1.time_ - 0) / 0.066)

				var_78_3.localPosition = Vector3.New(var_78_6 * 0.13, var_78_6 * 0.13, var_78_6 * 0.13) + arg_75_1.var_.shakeOldPos
			end

			if arg_75_1.time_ >= 0 + var_78_4 and arg_75_1.time_ < 0 + var_78_4 + arg_78_0 then
				var_78_3.localPosition = arg_75_1.var_.shakeOldPos
			end

			local var_78_7 = 0
			local var_78_8 = 0.075

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_7 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, true)
				arg_75_1.iconController_:SetSelectedState("hero")

				arg_75_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037_split_5")

				arg_75_1.callingController_:SetSelectedState("normal")

				arg_75_1.keyicon_.color = Color.New(1, 1, 1)
				arg_75_1.icon_.color = Color.New(1, 1, 1)

				local var_78_9 = arg_75_1:GetWordFromCfg(425121018)
				local var_78_10 = arg_75_1:FormatText(var_78_9.content)

				arg_75_1.text_.text = var_78_10

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_12 = 3 <= 0 and var_78_8 or var_78_8 * (utf8.len(var_78_10) / 3)

				if (3 <= 0 and var_78_8 or var_78_8 * (utf8.len(var_78_10) / 3)) > 0 and var_78_8 < var_78_12 then
					arg_75_1.talkMaxDuration = var_78_12

					if var_78_12 + var_78_7 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_12 + var_78_7
					end
				end

				arg_75_1.text_.text = var_78_10
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121018", "story_v_out_425121.awb") ~= 0 then
					local var_78_13 = manager.audio:GetVoiceLength("story_v_out_425121", "425121018", "story_v_out_425121.awb") / 1000

					if var_78_13 + var_78_7 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_13 + var_78_7
					end

					if var_78_9.prefab_name ~= "" and arg_75_1.actors_[var_78_9.prefab_name] ~= nil then
						local var_78_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_9.prefab_name].transform, "story_v_out_425121", "425121018", "story_v_out_425121.awb")

						arg_75_1:RecordAudio("425121018", var_78_14)
						arg_75_1:RecordAudio("425121018", var_78_14)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_425121", "425121018", "story_v_out_425121.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_425121", "425121018", "story_v_out_425121.awb")
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

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play425121019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 425121019
		arg_79_1.duration_ = 5

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play425121020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = 1.2

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

				local var_82_1 = arg_79_1:FormatText(arg_79_1:GetWordFromCfg(425121019).content)

				arg_79_1.text_.text = var_82_1

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_3 = 48 <= 0 and var_82_0 or var_82_0 * (utf8.len(var_82_1) / 48)

				if (48 <= 0 and var_82_0 or var_82_0 * (utf8.len(var_82_1) / 48)) > 0 and var_82_0 < var_82_3 then
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
	Play425121020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 425121020
		arg_83_1.duration_ = 4.03

		local var_83_0 = {
			zh = 3.2,
			ja = 4.033
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
				arg_83_0:Play425121021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = 0.225

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				arg_83_1.leftNameTxt_.text = arg_83_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, true)
				arg_83_1.iconController_:SetSelectedState("hero")

				arg_83_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037_split_4")

				arg_83_1.callingController_:SetSelectedState("normal")

				arg_83_1.keyicon_.color = Color.New(1, 1, 1)
				arg_83_1.icon_.color = Color.New(1, 1, 1)

				local var_86_1 = arg_83_1:GetWordFromCfg(425121020)
				local var_86_2 = arg_83_1:FormatText(var_86_1.content)

				arg_83_1.text_.text = var_86_2

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_4 = 9 <= 0 and var_86_0 or var_86_0 * (utf8.len(var_86_2) / 9)

				if (9 <= 0 and var_86_0 or var_86_0 * (utf8.len(var_86_2) / 9)) > 0 and var_86_0 < var_86_4 then
					arg_83_1.talkMaxDuration = var_86_4

					if var_86_4 + 0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_4 + 0
					end
				end

				arg_83_1.text_.text = var_86_2
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121020", "story_v_out_425121.awb") ~= 0 then
					local var_86_5 = manager.audio:GetVoiceLength("story_v_out_425121", "425121020", "story_v_out_425121.awb") / 1000

					if var_86_5 + 0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_5 + 0
					end

					if var_86_1.prefab_name ~= "" and arg_83_1.actors_[var_86_1.prefab_name] ~= nil then
						local var_86_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_1.prefab_name].transform, "story_v_out_425121", "425121020", "story_v_out_425121.awb")

						arg_83_1:RecordAudio("425121020", var_86_6)
						arg_83_1:RecordAudio("425121020", var_86_6)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_425121", "425121020", "story_v_out_425121.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_425121", "425121020", "story_v_out_425121.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_7 = math.max(var_86_0, arg_83_1.talkMaxDuration)

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_7 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - 0) / var_86_7

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= 0 + var_86_7 and arg_83_1.time_ < 0 + var_86_7 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play425121021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 425121021
		arg_87_1.duration_ = 9.7

		local var_87_0 = {
			zh = 7.733,
			ja = 9.7
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
				arg_87_0:Play425121022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = 0.675

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				arg_87_1.leftNameTxt_.text = arg_87_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_1 = arg_87_1:GetWordFromCfg(425121021)
				local var_90_2 = arg_87_1:FormatText(var_90_1.content)

				arg_87_1.text_.text = var_90_2

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_4 = 27 <= 0 and var_90_0 or var_90_0 * (utf8.len(var_90_2) / 27)

				if (27 <= 0 and var_90_0 or var_90_0 * (utf8.len(var_90_2) / 27)) > 0 and var_90_0 < var_90_4 then
					arg_87_1.talkMaxDuration = var_90_4

					if var_90_4 + 0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_4 + 0
					end
				end

				arg_87_1.text_.text = var_90_2
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121021", "story_v_out_425121.awb") ~= 0 then
					local var_90_5 = manager.audio:GetVoiceLength("story_v_out_425121", "425121021", "story_v_out_425121.awb") / 1000

					if var_90_5 + 0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_5 + 0
					end

					if var_90_1.prefab_name ~= "" and arg_87_1.actors_[var_90_1.prefab_name] ~= nil then
						local var_90_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_1.prefab_name].transform, "story_v_out_425121", "425121021", "story_v_out_425121.awb")

						arg_87_1:RecordAudio("425121021", var_90_6)
						arg_87_1:RecordAudio("425121021", var_90_6)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_425121", "425121021", "story_v_out_425121.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_425121", "425121021", "story_v_out_425121.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_7 = math.max(var_90_0, arg_87_1.talkMaxDuration)

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_7 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - 0) / var_90_7

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= 0 + var_90_7 and arg_87_1.time_ < 0 + var_90_7 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play425121022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 425121022
		arg_91_1.duration_ = 2.07

		local var_91_0 = {
			zh = 2.066,
			ja = 1.6
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
				arg_91_0:Play425121023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = 0.1

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				arg_91_1.leftNameTxt_.text = arg_91_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, true)
				arg_91_1.iconController_:SetSelectedState("hero")

				arg_91_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037_split_4")

				arg_91_1.callingController_:SetSelectedState("normal")

				arg_91_1.keyicon_.color = Color.New(1, 1, 1)
				arg_91_1.icon_.color = Color.New(1, 1, 1)

				local var_94_1 = arg_91_1:GetWordFromCfg(425121022)
				local var_94_2 = arg_91_1:FormatText(var_94_1.content)

				arg_91_1.text_.text = var_94_2

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_4 = 4 <= 0 and var_94_0 or var_94_0 * (utf8.len(var_94_2) / 4)

				if (4 <= 0 and var_94_0 or var_94_0 * (utf8.len(var_94_2) / 4)) > 0 and var_94_0 < var_94_4 then
					arg_91_1.talkMaxDuration = var_94_4

					if var_94_4 + 0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_4 + 0
					end
				end

				arg_91_1.text_.text = var_94_2
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121022", "story_v_out_425121.awb") ~= 0 then
					local var_94_5 = manager.audio:GetVoiceLength("story_v_out_425121", "425121022", "story_v_out_425121.awb") / 1000

					if var_94_5 + 0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_5 + 0
					end

					if var_94_1.prefab_name ~= "" and arg_91_1.actors_[var_94_1.prefab_name] ~= nil then
						local var_94_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_1.prefab_name].transform, "story_v_out_425121", "425121022", "story_v_out_425121.awb")

						arg_91_1:RecordAudio("425121022", var_94_6)
						arg_91_1:RecordAudio("425121022", var_94_6)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_425121", "425121022", "story_v_out_425121.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_425121", "425121022", "story_v_out_425121.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_7 = math.max(var_94_0, arg_91_1.talkMaxDuration)

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_7 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - 0) / var_94_7

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= 0 + var_94_7 and arg_91_1.time_ < 0 + var_94_7 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play425121023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 425121023
		arg_95_1.duration_ = 7.7

		local var_95_0 = {
			zh = 4.833,
			ja = 7.7
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
				arg_95_0:Play425121024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = 0.425

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				arg_95_1.leftNameTxt_.text = arg_95_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_1 = arg_95_1:GetWordFromCfg(425121023)
				local var_98_2 = arg_95_1:FormatText(var_98_1.content)

				arg_95_1.text_.text = var_98_2

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_4 = 17 <= 0 and var_98_0 or var_98_0 * (utf8.len(var_98_2) / 17)

				if (17 <= 0 and var_98_0 or var_98_0 * (utf8.len(var_98_2) / 17)) > 0 and var_98_0 < var_98_4 then
					arg_95_1.talkMaxDuration = var_98_4

					if var_98_4 + 0 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_4 + 0
					end
				end

				arg_95_1.text_.text = var_98_2
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121023", "story_v_out_425121.awb") ~= 0 then
					local var_98_5 = manager.audio:GetVoiceLength("story_v_out_425121", "425121023", "story_v_out_425121.awb") / 1000

					if var_98_5 + 0 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_5 + 0
					end

					if var_98_1.prefab_name ~= "" and arg_95_1.actors_[var_98_1.prefab_name] ~= nil then
						local var_98_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_1.prefab_name].transform, "story_v_out_425121", "425121023", "story_v_out_425121.awb")

						arg_95_1:RecordAudio("425121023", var_98_6)
						arg_95_1:RecordAudio("425121023", var_98_6)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_425121", "425121023", "story_v_out_425121.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_425121", "425121023", "story_v_out_425121.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_7 = math.max(var_98_0, arg_95_1.talkMaxDuration)

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_7 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - 0) / var_98_7

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= 0 + var_98_7 and arg_95_1.time_ < 0 + var_98_7 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play425121024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 425121024
		arg_99_1.duration_ = 11.03

		local var_99_0 = {
			zh = 9.86633366666666,
			ja = 11.0333336666667
		}
		local var_99_1 = manager.audio:GetLocalizationFlag()

		if var_99_0[var_99_1] ~= nil then
			arg_99_1.duration_ = var_99_0[var_99_1]
		end

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play425121025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			if 0.0333333333333332 < arg_99_1.time_ and arg_99_1.time_ <= 0.0333333333333332 + arg_102_0 then
				arg_99_1.mask_.enabled = true
				arg_99_1.mask_.raycastTarget = true

				arg_99_1:SetGaussion(false)
			end

			local var_102_0 = 1.2

			if 0.0333333333333332 <= arg_99_1.time_ and arg_99_1.time_ < 0.0333333333333332 + var_102_0 then
				local var_102_1 = Color.New(0, 0, 0)

				var_102_1.a = Mathf.Lerp(0, 1, (arg_99_1.time_ - 0.0333333333333332) / var_102_0)
				arg_99_1.mask_.color = var_102_1
			end

			if arg_99_1.time_ >= 0.0333333333333332 + var_102_0 and arg_99_1.time_ < 0.0333333333333332 + var_102_0 + arg_102_0 then
				local var_102_2 = Color.New(0, 0, 0)

				var_102_2.a = 1
				arg_99_1.mask_.color = var_102_2
			end

			local var_102_3 = 1.23333333333333

			if 1.23333333333333 < arg_99_1.time_ and arg_99_1.time_ <= var_102_3 + arg_102_0 then
				arg_99_1.mask_.enabled = true
				arg_99_1.mask_.raycastTarget = true

				arg_99_1:SetGaussion(false)
			end

			local var_102_4 = 1.2

			if var_102_3 <= arg_99_1.time_ and arg_99_1.time_ < var_102_3 + var_102_4 then
				local var_102_5 = Color.New(0, 0, 0)

				var_102_5.a = Mathf.Lerp(1, 0, (arg_99_1.time_ - var_102_3) / var_102_4)
				arg_99_1.mask_.color = var_102_5
			end

			if arg_99_1.time_ >= var_102_3 + var_102_4 and arg_99_1.time_ < var_102_3 + var_102_4 + arg_102_0 then
				local var_102_6 = Color.New(0, 0, 0)

				arg_99_1.mask_.enabled = false
				var_102_6.a = 0
				arg_99_1.mask_.color = var_102_6
			end

			local var_102_7 = 5.63333366666666

			if 5.63333366666666 < arg_99_1.time_ and arg_99_1.time_ <= var_102_7 + arg_102_0 then
				arg_99_1.allBtn_.enabled = false
			end

			if arg_99_1.time_ >= var_102_7 + 0.3 and arg_99_1.time_ < var_102_7 + 0.3 + arg_102_0 then
				arg_99_1.allBtn_.enabled = true
			end

			local var_102_8 = 1.23333333333333

			if 1.23333333333333 < arg_99_1.time_ and arg_99_1.time_ <= var_102_8 + arg_102_0 then
				arg_99_1.timestampController_:SetSelectedState("show")
				arg_99_1.timestampAni_:Play("in")

				arg_99_1.timeTicketbgImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "M01i")

				arg_99_1.timestampColorController_:SetSelectedState("hot")
				arg_99_1.timeColdImg_:SetAlpha(0.031)

				arg_99_1.text_timeText_.text = arg_99_1:FormatText(arg_99_1:GetWordFromCfg(501120).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_timeText_)

				arg_99_1.text_siteText_.text = arg_99_1:FormatText(arg_99_1:GetWordFromCfg(501121).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_siteText_)
			end

			if arg_99_1.time_ >= var_102_8 + 1.999999999999 and arg_99_1.time_ < var_102_8 + 1.999999999999 + arg_102_0 then
				AnimatorTools.PlayAnimationWithCallback(arg_99_1.timestampAni_, "out", function()
					arg_99_1.timestampController_:SetSelectedState("hide")
				end)
			end

			local var_102_9 = 3.23333366666666

			if 3.23333366666666 < arg_99_1.time_ and arg_99_1.time_ <= var_102_9 + arg_102_0 then
				arg_99_1.mask_.enabled = true
				arg_99_1.mask_.raycastTarget = true

				arg_99_1:SetGaussion(false)
			end

			local var_102_10 = 1.2

			if var_102_9 <= arg_99_1.time_ and arg_99_1.time_ < var_102_9 + var_102_10 then
				local var_102_11 = Color.New(0, 0, 0)

				var_102_11.a = Mathf.Lerp(0, 1, (arg_99_1.time_ - var_102_9) / var_102_10)
				arg_99_1.mask_.color = var_102_11
			end

			if arg_99_1.time_ >= var_102_9 + var_102_10 and arg_99_1.time_ < var_102_9 + var_102_10 + arg_102_0 then
				local var_102_12 = Color.New(0, 0, 0)

				var_102_12.a = 1
				arg_99_1.mask_.color = var_102_12
			end

			local var_102_13 = 4.43333366666666

			if 4.43333366666666 < arg_99_1.time_ and arg_99_1.time_ <= var_102_13 + arg_102_0 then
				arg_99_1.mask_.enabled = true
				arg_99_1.mask_.raycastTarget = true

				arg_99_1:SetGaussion(false)
			end

			local var_102_14 = 1.2

			if var_102_13 <= arg_99_1.time_ and arg_99_1.time_ < var_102_13 + var_102_14 then
				local var_102_15 = Color.New(0, 0, 0)

				var_102_15.a = Mathf.Lerp(1, 0, (arg_99_1.time_ - var_102_13) / var_102_14)
				arg_99_1.mask_.color = var_102_15
			end

			if arg_99_1.time_ >= var_102_13 + var_102_14 and arg_99_1.time_ < var_102_13 + var_102_14 + arg_102_0 then
				local var_102_16 = Color.New(0, 0, 0)

				arg_99_1.mask_.enabled = false
				var_102_16.a = 0
				arg_99_1.mask_.color = var_102_16
			end

			local var_102_17 = "M01i"

			if arg_99_1.bgs_.M01i == nil then
				local var_102_18 = Object.Instantiate(arg_99_1.paintGo_)

				var_102_18:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_102_17)
				var_102_18.name = var_102_17
				var_102_18.transform.parent = arg_99_1.stage_.transform
				var_102_18.transform.localPosition = Vector3.New(0, 100, 0)
				arg_99_1.bgs_[var_102_17] = var_102_18
			end

			if 1.23333333333333 < arg_99_1.time_ and arg_99_1.time_ <= 1.23333333333333 + arg_102_0 then
				local var_102_19 = arg_99_1.bgs_.M01i

				arg_99_1.bgs_.M01i.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_102_19.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_102_20 = var_102_19:GetComponent("SpriteRenderer")

				if var_102_20 and var_102_20.sprite then
					local var_102_21 = 2 * (var_102_19.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_102_19.transform.localScale = Vector3.New(var_102_21 / var_102_20.sprite.bounds.size.y < var_102_21 * manager.ui.mainCameraCom_.aspect / var_102_20.sprite.bounds.size.x and var_102_21 * manager.ui.mainCameraCom_.aspect / var_102_20.sprite.bounds.size.x or var_102_21 / var_102_20.sprite.bounds.size.y, var_102_21 / var_102_20.sprite.bounds.size.y < var_102_21 * manager.ui.mainCameraCom_.aspect / var_102_20.sprite.bounds.size.x and var_102_21 * manager.ui.mainCameraCom_.aspect / var_102_20.sprite.bounds.size.x or var_102_21 / var_102_20.sprite.bounds.size.y, 0)
				end

				for iter_102_0, iter_102_1 in pairs(arg_99_1.bgs_) do
					if iter_102_0 ~= "M01i" then
						iter_102_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_102_22 = "1036"

			if arg_99_1.actors_["1036"] == nil then
				local var_102_23 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1036")

				if not isNil(var_102_23) then
					local var_102_24 = Object.Instantiate(var_102_23, arg_99_1.canvasGo_.transform)

					var_102_24.transform:SetSiblingIndex(1)

					var_102_24.name = var_102_22
					var_102_24.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_99_1.actors_[var_102_22] = var_102_24

					if arg_99_1.isInRecall_ then
						for iter_102_2, iter_102_3 in ipairs((var_102_24:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_102_3.color = arg_99_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_102_25 = arg_99_1.actors_["1036"]

			if 5.43333366666666 < arg_99_1.time_ and arg_99_1.time_ <= 5.43333366666666 + arg_102_0 and not isNil(var_102_25) and arg_99_1.var_.actorSpriteComps1036 == nil then
				arg_99_1.var_.actorSpriteComps1036 = var_102_25:GetComponentsInChildren(typeof(Image), true)
			end

			local var_102_26 = 0.2

			if 5.43333366666666 <= arg_99_1.time_ and arg_99_1.time_ < 5.43333366666666 + var_102_26 and not isNil(var_102_25) then
				if arg_99_1.var_.actorSpriteComps1036 then
					for iter_102_4, iter_102_5 in pairs(arg_99_1.var_.actorSpriteComps1036:ToTable()) do
						if iter_102_5 then
							if arg_99_1.isInRecall_ then
								iter_102_5.color = Color.New(Mathf.Lerp(iter_102_5.color.r, arg_99_1.hightColor1.r, (arg_99_1.time_ - 5.43333366666666) / var_102_26), Mathf.Lerp(iter_102_5.color.g, arg_99_1.hightColor1.g, (arg_99_1.time_ - 5.43333366666666) / var_102_26), (Mathf.Lerp(iter_102_5.color.b, arg_99_1.hightColor1.b, (arg_99_1.time_ - 5.43333366666666) / var_102_26)))
							else
								local var_102_27 = Mathf.Lerp(iter_102_5.color.r, 1, (arg_99_1.time_ - 5.43333366666666) / var_102_26)

								iter_102_5.color = Color.New(var_102_27, var_102_27, var_102_27)
							end
						end
					end
				end
			end

			if arg_99_1.time_ >= 5.43333366666666 + var_102_26 and arg_99_1.time_ < 5.43333366666666 + var_102_26 + arg_102_0 and not isNil(var_102_25) and arg_99_1.var_.actorSpriteComps1036 then
				for iter_102_6, iter_102_7 in pairs(arg_99_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_102_7 then
						iter_102_7.color = arg_99_1.isInRecall_ and (arg_99_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_99_1.var_.actorSpriteComps1036 = nil
			end

			local var_102_28 = arg_99_1.actors_["1036"].transform

			if 5.43333366666666 < arg_99_1.time_ and arg_99_1.time_ <= 5.43333366666666 + arg_102_0 then
				arg_99_1.var_.moveOldPos1036 = var_102_28.localPosition
				var_102_28.localScale = Vector3.New(1, 1, 1)

				arg_99_1:CheckSpriteTmpPos("1036", 3)

				for iter_102_8 = 0, var_102_28.childCount - 1 do
					local var_102_29 = var_102_28:GetChild(iter_102_8)

					if var_102_29.name == "" or not string.find(var_102_29.name, "split") then
						var_102_29.gameObject:SetActive(true)
					else
						var_102_29.gameObject:SetActive(false)
					end
				end
			end

			local var_102_30 = 0.001

			if 5.43333366666666 <= arg_99_1.time_ and arg_99_1.time_ < 5.43333366666666 + var_102_30 then
				var_102_28.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos1036, Vector3.New(0, -388, -250), (arg_99_1.time_ - 5.43333366666666) / var_102_30)
			end

			if arg_99_1.time_ >= 5.43333366666666 + var_102_30 and arg_99_1.time_ < 5.43333366666666 + var_102_30 + arg_102_0 then
				var_102_28.localPosition = Vector3.New(0, -388, -250)
			end

			if 0.133333333333333 < arg_99_1.time_ and arg_99_1.time_ <= 0.133333333333333 + arg_102_0 then
				arg_99_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_102_33 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_99_1.bgmTxt_.text ~= var_102_33 and arg_99_1.bgmTxt_.text ~= "" then
						if arg_99_1.bgmTxt2_.text ~= "" then
							arg_99_1.bgmTxt_.text = arg_99_1.bgmTxt2_.text
						end

						arg_99_1.bgmTxt2_.text = var_102_33

						arg_99_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_99_1.bgmTxt_.text = var_102_33
						arg_99_1.bgmTxt2_.text = var_102_33
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

			if 4.06666666666667 < arg_99_1.time_ and arg_99_1.time_ <= 4.06666666666667 + arg_102_0 then
				arg_99_1:AudioAction("play", "music", "bgm_activity_4_7_story_snowy", "bgm_activity_4_7_story_snowy", "bgm_activity_4_7_story_snowy.awb")

				local var_102_36 = manager.audio:GetAudioName("bgm_activity_4_7_story_snowy", "bgm_activity_4_7_story_snowy")

				if "" ~= "" then
					if arg_99_1.bgmTxt_.text ~= var_102_36 and arg_99_1.bgmTxt_.text ~= "" then
						if arg_99_1.bgmTxt2_.text ~= "" then
							arg_99_1.bgmTxt_.text = arg_99_1.bgmTxt2_.text
						end

						arg_99_1.bgmTxt2_.text = var_102_36

						arg_99_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_99_1.bgmTxt_.text = var_102_36
						arg_99_1.bgmTxt2_.text = var_102_36
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

			if 0.133333333333333 < arg_99_1.time_ and arg_99_1.time_ <= 0.133333333333333 + arg_102_0 then
				arg_99_1:AudioAction("stop", "effect", "se_story_141", "se_story_141_amb_bass", "")
			end

			if 4.06666666666667 < arg_99_1.time_ and arg_99_1.time_ <= 4.06666666666667 + arg_102_0 then
				arg_99_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_amb_winter_loop", "")
			end

			if 1.23333333333333 < arg_99_1.time_ and arg_99_1.time_ <= 1.23333333333333 + arg_102_0 then
				if arg_99_1.var_.effect10091018 then
					Object.Destroy(arg_99_1.var_.effect10091018)

					arg_99_1.var_.effect10091018 = nil
				end
			end

			if arg_99_1.frameCnt_ <= 1 then
				arg_99_1.dialog_:SetActive(false)
			end

			local var_102_40 = 5.63333366666666
			local var_102_41 = 0.6

			if 5.63333366666666 < arg_99_1.time_ and arg_99_1.time_ <= var_102_40 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0

				arg_99_1.dialog_:SetActive(true)

				arg_99_1.dialogCg_.alpha = 0

				local var_102_42 = LeanTween.value(arg_99_1.dialog_, 0, 1, 0.3)

				var_102_42:setOnUpdate(LuaHelper.FloatAction(function(arg_106_0)
					arg_99_1.dialogCg_.alpha = arg_106_0
				end))
				var_102_42:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_99_1.dialog_)
					var_102_42:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_99_1.duration_ = arg_99_1.duration_ + 0.3

				SetActive(arg_99_1.leftNameGo_, true)

				arg_99_1.leftNameTxt_.text = arg_99_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_43 = arg_99_1:GetWordFromCfg(425121024)
				local var_102_44 = arg_99_1:FormatText(var_102_43.content)

				arg_99_1.text_.text = var_102_44

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_46 = 24 <= 0 and var_102_41 or var_102_41 * (utf8.len(var_102_44) / 24)

				if (24 <= 0 and var_102_41 or var_102_41 * (utf8.len(var_102_44) / 24)) > 0 and var_102_41 < var_102_46 then
					arg_99_1.talkMaxDuration = var_102_46
					var_102_40 = var_102_40 + 0.3

					if var_102_46 + var_102_40 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_46 + var_102_40
					end
				end

				arg_99_1.text_.text = var_102_44
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121024", "story_v_out_425121.awb") ~= 0 then
					local var_102_47 = manager.audio:GetVoiceLength("story_v_out_425121", "425121024", "story_v_out_425121.awb") / 1000

					if var_102_47 + var_102_40 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_47 + var_102_40
					end

					if var_102_43.prefab_name ~= "" and arg_99_1.actors_[var_102_43.prefab_name] ~= nil then
						local var_102_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_43.prefab_name].transform, "story_v_out_425121", "425121024", "story_v_out_425121.awb")

						arg_99_1:RecordAudio("425121024", var_102_48)
						arg_99_1:RecordAudio("425121024", var_102_48)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_425121", "425121024", "story_v_out_425121.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_425121", "425121024", "story_v_out_425121.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_49 = var_102_40 + 0.3
			local var_102_50 = math.max(var_102_41, arg_99_1.talkMaxDuration)

			if var_102_40 + 0.3 <= arg_99_1.time_ and arg_99_1.time_ < var_102_49 + var_102_50 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_49) / var_102_50

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_49 + var_102_50 and arg_99_1.time_ < var_102_49 + var_102_50 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 5.43333366666666,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_99_1:InitPlayNodeList()
	end,
	Play425121025 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 425121025
		arg_108_1.duration_ = 5

		local var_108_0 = {
			zh = 3.533,
			ja = 5
		}
		local var_108_1 = manager.audio:GetLocalizationFlag()

		if var_108_0[var_108_1] ~= nil then
			arg_108_1.duration_ = var_108_0[var_108_1]
		end

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play425121026(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 and not isNil(arg_108_1.actors_["1036"]) and arg_108_1.var_.actorSpriteComps1036 == nil then
				arg_108_1.var_.actorSpriteComps1036 = arg_108_1.actors_["1036"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_111_0 = 0.2

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_0 and not isNil(arg_108_1.actors_["1036"]) then
				if arg_108_1.var_.actorSpriteComps1036 then
					for iter_111_0, iter_111_1 in pairs(arg_108_1.var_.actorSpriteComps1036:ToTable()) do
						if iter_111_1 then
							if arg_108_1.isInRecall_ then
								iter_111_1.color = Color.New(Mathf.Lerp(iter_111_1.color.r, arg_108_1.hightColor2.r, (arg_108_1.time_ - 0) / var_111_0), Mathf.Lerp(iter_111_1.color.g, arg_108_1.hightColor2.g, (arg_108_1.time_ - 0) / var_111_0), (Mathf.Lerp(iter_111_1.color.b, arg_108_1.hightColor2.b, (arg_108_1.time_ - 0) / var_111_0)))
							else
								local var_111_1 = Mathf.Lerp(iter_111_1.color.r, 0.5, (arg_108_1.time_ - 0) / var_111_0)

								iter_111_1.color = Color.New(var_111_1, var_111_1, var_111_1)
							end
						end
					end
				end
			end

			if arg_108_1.time_ >= 0 + var_111_0 and arg_108_1.time_ < 0 + var_111_0 + arg_111_0 and not isNil(arg_108_1.actors_["1036"]) and arg_108_1.var_.actorSpriteComps1036 then
				for iter_111_2, iter_111_3 in pairs(arg_108_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_111_3 then
						iter_111_3.color = arg_108_1.isInRecall_ and (arg_108_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_108_1.var_.actorSpriteComps1036 = nil
			end

			local var_111_2 = 0
			local var_111_3 = 0.4

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_2 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				arg_108_1.leftNameTxt_.text = arg_108_1:FormatText(StoryNameCfg[1082].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, true)
				arg_108_1.iconController_:SetSelectedState("hero")

				arg_108_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officerma")

				arg_108_1.callingController_:SetSelectedState("normal")

				arg_108_1.keyicon_.color = Color.New(1, 1, 1)
				arg_108_1.icon_.color = Color.New(1, 1, 1)

				local var_111_4 = arg_108_1:GetWordFromCfg(425121025)
				local var_111_5 = arg_108_1:FormatText(var_111_4.content)

				arg_108_1.text_.text = var_111_5

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_7 = 16 <= 0 and var_111_3 or var_111_3 * (utf8.len(var_111_5) / 16)

				if (16 <= 0 and var_111_3 or var_111_3 * (utf8.len(var_111_5) / 16)) > 0 and var_111_3 < var_111_7 then
					arg_108_1.talkMaxDuration = var_111_7

					if var_111_7 + var_111_2 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_7 + var_111_2
					end
				end

				arg_108_1.text_.text = var_111_5
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121025", "story_v_out_425121.awb") ~= 0 then
					local var_111_8 = manager.audio:GetVoiceLength("story_v_out_425121", "425121025", "story_v_out_425121.awb") / 1000

					if var_111_8 + var_111_2 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_8 + var_111_2
					end

					if var_111_4.prefab_name ~= "" and arg_108_1.actors_[var_111_4.prefab_name] ~= nil then
						local var_111_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_4.prefab_name].transform, "story_v_out_425121", "425121025", "story_v_out_425121.awb")

						arg_108_1:RecordAudio("425121025", var_111_9)
						arg_108_1:RecordAudio("425121025", var_111_9)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_425121", "425121025", "story_v_out_425121.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_425121", "425121025", "story_v_out_425121.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_10 = math.max(var_111_3, arg_108_1.talkMaxDuration)

			if var_111_2 <= arg_108_1.time_ and arg_108_1.time_ < var_111_2 + var_111_10 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_2) / var_111_10

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_2 + var_111_10 and arg_108_1.time_ < var_111_2 + var_111_10 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play425121026 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 425121026
		arg_112_1.duration_ = 4.67

		local var_112_0 = {
			zh = 2.933,
			ja = 4.666
		}
		local var_112_1 = manager.audio:GetLocalizationFlag()

		if var_112_0[var_112_1] ~= nil then
			arg_112_1.duration_ = var_112_0[var_112_1]
		end

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play425121027(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 and not isNil(arg_112_1.actors_["1036"]) and arg_112_1.var_.actorSpriteComps1036 == nil then
				arg_112_1.var_.actorSpriteComps1036 = arg_112_1.actors_["1036"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_115_0 = 0.2

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_0 and not isNil(arg_112_1.actors_["1036"]) then
				if arg_112_1.var_.actorSpriteComps1036 then
					for iter_115_0, iter_115_1 in pairs(arg_112_1.var_.actorSpriteComps1036:ToTable()) do
						if iter_115_1 then
							if arg_112_1.isInRecall_ then
								iter_115_1.color = Color.New(Mathf.Lerp(iter_115_1.color.r, arg_112_1.hightColor1.r, (arg_112_1.time_ - 0) / var_115_0), Mathf.Lerp(iter_115_1.color.g, arg_112_1.hightColor1.g, (arg_112_1.time_ - 0) / var_115_0), (Mathf.Lerp(iter_115_1.color.b, arg_112_1.hightColor1.b, (arg_112_1.time_ - 0) / var_115_0)))
							else
								local var_115_1 = Mathf.Lerp(iter_115_1.color.r, 1, (arg_112_1.time_ - 0) / var_115_0)

								iter_115_1.color = Color.New(var_115_1, var_115_1, var_115_1)
							end
						end
					end
				end
			end

			if arg_112_1.time_ >= 0 + var_115_0 and arg_112_1.time_ < 0 + var_115_0 + arg_115_0 and not isNil(arg_112_1.actors_["1036"]) and arg_112_1.var_.actorSpriteComps1036 then
				for iter_115_2, iter_115_3 in pairs(arg_112_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_115_3 then
						iter_115_3.color = arg_112_1.isInRecall_ and (arg_112_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_112_1.var_.actorSpriteComps1036 = nil
			end

			local var_115_2 = arg_112_1.actors_["1036"].transform

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1.var_.moveOldPos1036 = var_115_2.localPosition
				var_115_2.localScale = Vector3.New(1, 1, 1)

				arg_112_1:CheckSpriteTmpPos("1036", 3)

				for iter_115_4 = 0, var_115_2.childCount - 1 do
					local var_115_3 = var_115_2:GetChild(iter_115_4)

					if var_115_3.name == "" or not string.find(var_115_3.name, "split") then
						var_115_3.gameObject:SetActive(true)
					else
						var_115_3.gameObject:SetActive(false)
					end
				end
			end

			local var_115_4 = 0.001

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_4 then
				var_115_2.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos1036, Vector3.New(0, -388, -250), (arg_112_1.time_ - 0) / var_115_4)
			end

			if arg_112_1.time_ >= 0 + var_115_4 and arg_112_1.time_ < 0 + var_115_4 + arg_115_0 then
				var_115_2.localPosition = Vector3.New(0, -388, -250)
			end

			local var_115_5 = 0
			local var_115_6 = 0.375

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_5 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				arg_112_1.leftNameTxt_.text = arg_112_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_7 = arg_112_1:GetWordFromCfg(425121026)
				local var_115_8 = arg_112_1:FormatText(var_115_7.content)

				arg_112_1.text_.text = var_115_8

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_10 = 15 <= 0 and var_115_6 or var_115_6 * (utf8.len(var_115_8) / 15)

				if (15 <= 0 and var_115_6 or var_115_6 * (utf8.len(var_115_8) / 15)) > 0 and var_115_6 < var_115_10 then
					arg_112_1.talkMaxDuration = var_115_10

					if var_115_10 + var_115_5 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_10 + var_115_5
					end
				end

				arg_112_1.text_.text = var_115_8
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121026", "story_v_out_425121.awb") ~= 0 then
					local var_115_11 = manager.audio:GetVoiceLength("story_v_out_425121", "425121026", "story_v_out_425121.awb") / 1000

					if var_115_11 + var_115_5 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_11 + var_115_5
					end

					if var_115_7.prefab_name ~= "" and arg_112_1.actors_[var_115_7.prefab_name] ~= nil then
						local var_115_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_7.prefab_name].transform, "story_v_out_425121", "425121026", "story_v_out_425121.awb")

						arg_112_1:RecordAudio("425121026", var_115_12)
						arg_112_1:RecordAudio("425121026", var_115_12)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_425121", "425121026", "story_v_out_425121.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_425121", "425121026", "story_v_out_425121.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_13 = math.max(var_115_6, arg_112_1.talkMaxDuration)

			if var_115_5 <= arg_112_1.time_ and arg_112_1.time_ < var_115_5 + var_115_13 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_5) / var_115_13

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_5 + var_115_13 and arg_112_1.time_ < var_115_5 + var_115_13 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_112_1:InitPlayNodeList()
	end,
	Play425121027 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 425121027
		arg_116_1.duration_ = 4.47

		local var_116_0 = {
			zh = 2.466,
			ja = 4.466
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
				arg_116_0:Play425121028(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 and not isNil(arg_116_1.actors_["1036"]) and arg_116_1.var_.actorSpriteComps1036 == nil then
				arg_116_1.var_.actorSpriteComps1036 = arg_116_1.actors_["1036"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_119_0 = 0.2

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_0 and not isNil(arg_116_1.actors_["1036"]) then
				if arg_116_1.var_.actorSpriteComps1036 then
					for iter_119_0, iter_119_1 in pairs(arg_116_1.var_.actorSpriteComps1036:ToTable()) do
						if iter_119_1 then
							if arg_116_1.isInRecall_ then
								iter_119_1.color = Color.New(Mathf.Lerp(iter_119_1.color.r, arg_116_1.hightColor2.r, (arg_116_1.time_ - 0) / var_119_0), Mathf.Lerp(iter_119_1.color.g, arg_116_1.hightColor2.g, (arg_116_1.time_ - 0) / var_119_0), (Mathf.Lerp(iter_119_1.color.b, arg_116_1.hightColor2.b, (arg_116_1.time_ - 0) / var_119_0)))
							else
								local var_119_1 = Mathf.Lerp(iter_119_1.color.r, 0.5, (arg_116_1.time_ - 0) / var_119_0)

								iter_119_1.color = Color.New(var_119_1, var_119_1, var_119_1)
							end
						end
					end
				end
			end

			if arg_116_1.time_ >= 0 + var_119_0 and arg_116_1.time_ < 0 + var_119_0 + arg_119_0 and not isNil(arg_116_1.actors_["1036"]) and arg_116_1.var_.actorSpriteComps1036 then
				for iter_119_2, iter_119_3 in pairs(arg_116_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_119_3 then
						iter_119_3.color = arg_116_1.isInRecall_ and (arg_116_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_116_1.var_.actorSpriteComps1036 = nil
			end

			local var_119_2 = 0
			local var_119_3 = 0.325

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_2 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				arg_116_1.leftNameTxt_.text = arg_116_1:FormatText(StoryNameCfg[1082].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, true)
				arg_116_1.iconController_:SetSelectedState("hero")

				arg_116_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officerma")

				arg_116_1.callingController_:SetSelectedState("normal")

				arg_116_1.keyicon_.color = Color.New(1, 1, 1)
				arg_116_1.icon_.color = Color.New(1, 1, 1)

				local var_119_4 = arg_116_1:GetWordFromCfg(425121027)
				local var_119_5 = arg_116_1:FormatText(var_119_4.content)

				arg_116_1.text_.text = var_119_5

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_7 = 13 <= 0 and var_119_3 or var_119_3 * (utf8.len(var_119_5) / 13)

				if (13 <= 0 and var_119_3 or var_119_3 * (utf8.len(var_119_5) / 13)) > 0 and var_119_3 < var_119_7 then
					arg_116_1.talkMaxDuration = var_119_7

					if var_119_7 + var_119_2 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_7 + var_119_2
					end
				end

				arg_116_1.text_.text = var_119_5
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121027", "story_v_out_425121.awb") ~= 0 then
					local var_119_8 = manager.audio:GetVoiceLength("story_v_out_425121", "425121027", "story_v_out_425121.awb") / 1000

					if var_119_8 + var_119_2 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_8 + var_119_2
					end

					if var_119_4.prefab_name ~= "" and arg_116_1.actors_[var_119_4.prefab_name] ~= nil then
						local var_119_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_4.prefab_name].transform, "story_v_out_425121", "425121027", "story_v_out_425121.awb")

						arg_116_1:RecordAudio("425121027", var_119_9)
						arg_116_1:RecordAudio("425121027", var_119_9)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_425121", "425121027", "story_v_out_425121.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_425121", "425121027", "story_v_out_425121.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_10 = math.max(var_119_3, arg_116_1.talkMaxDuration)

			if var_119_2 <= arg_116_1.time_ and arg_116_1.time_ < var_119_2 + var_119_10 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_2) / var_119_10

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_2 + var_119_10 and arg_116_1.time_ < var_119_2 + var_119_10 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play425121028 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 425121028
		arg_120_1.duration_ = 10.83

		local var_120_0 = {
			zh = 10.3,
			ja = 10.833
		}
		local var_120_1 = manager.audio:GetLocalizationFlag()

		if var_120_0[var_120_1] ~= nil then
			arg_120_1.duration_ = var_120_0[var_120_1]
		end

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play425121029(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = 1.175

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				arg_120_1.leftNameTxt_.text = arg_120_1:FormatText(StoryNameCfg[1082].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, true)
				arg_120_1.iconController_:SetSelectedState("hero")

				arg_120_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officerma")

				arg_120_1.callingController_:SetSelectedState("normal")

				arg_120_1.keyicon_.color = Color.New(1, 1, 1)
				arg_120_1.icon_.color = Color.New(1, 1, 1)

				local var_123_1 = arg_120_1:GetWordFromCfg(425121028)
				local var_123_2 = arg_120_1:FormatText(var_123_1.content)

				arg_120_1.text_.text = var_123_2

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_4 = 47 <= 0 and var_123_0 or var_123_0 * (utf8.len(var_123_2) / 47)

				if (47 <= 0 and var_123_0 or var_123_0 * (utf8.len(var_123_2) / 47)) > 0 and var_123_0 < var_123_4 then
					arg_120_1.talkMaxDuration = var_123_4

					if var_123_4 + 0 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_4 + 0
					end
				end

				arg_120_1.text_.text = var_123_2
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121028", "story_v_out_425121.awb") ~= 0 then
					local var_123_5 = manager.audio:GetVoiceLength("story_v_out_425121", "425121028", "story_v_out_425121.awb") / 1000

					if var_123_5 + 0 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_5 + 0
					end

					if var_123_1.prefab_name ~= "" and arg_120_1.actors_[var_123_1.prefab_name] ~= nil then
						local var_123_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_1.prefab_name].transform, "story_v_out_425121", "425121028", "story_v_out_425121.awb")

						arg_120_1:RecordAudio("425121028", var_123_6)
						arg_120_1:RecordAudio("425121028", var_123_6)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_425121", "425121028", "story_v_out_425121.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_425121", "425121028", "story_v_out_425121.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_7 = math.max(var_123_0, arg_120_1.talkMaxDuration)

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_7 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - 0) / var_123_7

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= 0 + var_123_7 and arg_120_1.time_ < 0 + var_123_7 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play425121029 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 425121029
		arg_124_1.duration_ = 11.67

		local var_124_0 = {
			zh = 6.4,
			ja = 11.666
		}
		local var_124_1 = manager.audio:GetLocalizationFlag()

		if var_124_0[var_124_1] ~= nil then
			arg_124_1.duration_ = var_124_0[var_124_1]
		end

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play425121030(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = 0.8

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				arg_124_1.leftNameTxt_.text = arg_124_1:FormatText(StoryNameCfg[1082].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, true)
				arg_124_1.iconController_:SetSelectedState("hero")

				arg_124_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officerma")

				arg_124_1.callingController_:SetSelectedState("normal")

				arg_124_1.keyicon_.color = Color.New(1, 1, 1)
				arg_124_1.icon_.color = Color.New(1, 1, 1)

				local var_127_1 = arg_124_1:GetWordFromCfg(425121029)
				local var_127_2 = arg_124_1:FormatText(var_127_1.content)

				arg_124_1.text_.text = var_127_2

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_4 = 32 <= 0 and var_127_0 or var_127_0 * (utf8.len(var_127_2) / 32)

				if (32 <= 0 and var_127_0 or var_127_0 * (utf8.len(var_127_2) / 32)) > 0 and var_127_0 < var_127_4 then
					arg_124_1.talkMaxDuration = var_127_4

					if var_127_4 + 0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_4 + 0
					end
				end

				arg_124_1.text_.text = var_127_2
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121029", "story_v_out_425121.awb") ~= 0 then
					local var_127_5 = manager.audio:GetVoiceLength("story_v_out_425121", "425121029", "story_v_out_425121.awb") / 1000

					if var_127_5 + 0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_5 + 0
					end

					if var_127_1.prefab_name ~= "" and arg_124_1.actors_[var_127_1.prefab_name] ~= nil then
						local var_127_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_1.prefab_name].transform, "story_v_out_425121", "425121029", "story_v_out_425121.awb")

						arg_124_1:RecordAudio("425121029", var_127_6)
						arg_124_1:RecordAudio("425121029", var_127_6)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_425121", "425121029", "story_v_out_425121.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_425121", "425121029", "story_v_out_425121.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_7 = math.max(var_127_0, arg_124_1.talkMaxDuration)

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_7 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - 0) / var_127_7

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= 0 + var_127_7 and arg_124_1.time_ < 0 + var_127_7 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play425121030 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 425121030
		arg_128_1.duration_ = 8.37

		local var_128_0 = {
			zh = 5.5,
			ja = 8.366
		}
		local var_128_1 = manager.audio:GetLocalizationFlag()

		if var_128_0[var_128_1] ~= nil then
			arg_128_1.duration_ = var_128_0[var_128_1]
		end

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play425121031(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 and not isNil(arg_128_1.actors_["1036"]) and arg_128_1.var_.actorSpriteComps1036 == nil then
				arg_128_1.var_.actorSpriteComps1036 = arg_128_1.actors_["1036"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_131_0 = 0.2

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_0 and not isNil(arg_128_1.actors_["1036"]) then
				if arg_128_1.var_.actorSpriteComps1036 then
					for iter_131_0, iter_131_1 in pairs(arg_128_1.var_.actorSpriteComps1036:ToTable()) do
						if iter_131_1 then
							if arg_128_1.isInRecall_ then
								iter_131_1.color = Color.New(Mathf.Lerp(iter_131_1.color.r, arg_128_1.hightColor1.r, (arg_128_1.time_ - 0) / var_131_0), Mathf.Lerp(iter_131_1.color.g, arg_128_1.hightColor1.g, (arg_128_1.time_ - 0) / var_131_0), (Mathf.Lerp(iter_131_1.color.b, arg_128_1.hightColor1.b, (arg_128_1.time_ - 0) / var_131_0)))
							else
								local var_131_1 = Mathf.Lerp(iter_131_1.color.r, 1, (arg_128_1.time_ - 0) / var_131_0)

								iter_131_1.color = Color.New(var_131_1, var_131_1, var_131_1)
							end
						end
					end
				end
			end

			if arg_128_1.time_ >= 0 + var_131_0 and arg_128_1.time_ < 0 + var_131_0 + arg_131_0 and not isNil(arg_128_1.actors_["1036"]) and arg_128_1.var_.actorSpriteComps1036 then
				for iter_131_2, iter_131_3 in pairs(arg_128_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_131_3 then
						iter_131_3.color = arg_128_1.isInRecall_ and (arg_128_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_128_1.var_.actorSpriteComps1036 = nil
			end

			local var_131_2 = arg_128_1.actors_["1036"].transform

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1.var_.moveOldPos1036 = var_131_2.localPosition
				var_131_2.localScale = Vector3.New(1, 1, 1)

				arg_128_1:CheckSpriteTmpPos("1036", 3)

				for iter_131_4 = 0, var_131_2.childCount - 1 do
					local var_131_3 = var_131_2:GetChild(iter_131_4)

					if var_131_3.name == "" or not string.find(var_131_3.name, "split") then
						var_131_3.gameObject:SetActive(true)
					else
						var_131_3.gameObject:SetActive(false)
					end
				end
			end

			local var_131_4 = 0.001

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_4 then
				var_131_2.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos1036, Vector3.New(0, -388, -250), (arg_128_1.time_ - 0) / var_131_4)
			end

			if arg_128_1.time_ >= 0 + var_131_4 and arg_128_1.time_ < 0 + var_131_4 + arg_131_0 then
				var_131_2.localPosition = Vector3.New(0, -388, -250)
			end

			local var_131_5 = 0
			local var_131_6 = 0.75

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_5 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				arg_128_1.leftNameTxt_.text = arg_128_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_7 = arg_128_1:GetWordFromCfg(425121030)
				local var_131_8 = arg_128_1:FormatText(var_131_7.content)

				arg_128_1.text_.text = var_131_8

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_10 = 30 <= 0 and var_131_6 or var_131_6 * (utf8.len(var_131_8) / 30)

				if (30 <= 0 and var_131_6 or var_131_6 * (utf8.len(var_131_8) / 30)) > 0 and var_131_6 < var_131_10 then
					arg_128_1.talkMaxDuration = var_131_10

					if var_131_10 + var_131_5 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_10 + var_131_5
					end
				end

				arg_128_1.text_.text = var_131_8
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121030", "story_v_out_425121.awb") ~= 0 then
					local var_131_11 = manager.audio:GetVoiceLength("story_v_out_425121", "425121030", "story_v_out_425121.awb") / 1000

					if var_131_11 + var_131_5 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_11 + var_131_5
					end

					if var_131_7.prefab_name ~= "" and arg_128_1.actors_[var_131_7.prefab_name] ~= nil then
						local var_131_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_7.prefab_name].transform, "story_v_out_425121", "425121030", "story_v_out_425121.awb")

						arg_128_1:RecordAudio("425121030", var_131_12)
						arg_128_1:RecordAudio("425121030", var_131_12)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_425121", "425121030", "story_v_out_425121.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_425121", "425121030", "story_v_out_425121.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_13 = math.max(var_131_6, arg_128_1.talkMaxDuration)

			if var_131_5 <= arg_128_1.time_ and arg_128_1.time_ < var_131_5 + var_131_13 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_5) / var_131_13

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_5 + var_131_13 and arg_128_1.time_ < var_131_5 + var_131_13 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_128_1:InitPlayNodeList()
	end,
	Play425121031 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 425121031
		arg_132_1.duration_ = 17

		local var_132_0 = {
			zh = 9.333,
			ja = 17
		}
		local var_132_1 = manager.audio:GetLocalizationFlag()

		if var_132_0[var_132_1] ~= nil then
			arg_132_1.duration_ = var_132_0[var_132_1]
		end

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play425121032(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = 1.35

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				arg_132_1.leftNameTxt_.text = arg_132_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_1 = arg_132_1:GetWordFromCfg(425121031)
				local var_135_2 = arg_132_1:FormatText(var_135_1.content)

				arg_132_1.text_.text = var_135_2

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_4 = 54 <= 0 and var_135_0 or var_135_0 * (utf8.len(var_135_2) / 54)

				if (54 <= 0 and var_135_0 or var_135_0 * (utf8.len(var_135_2) / 54)) > 0 and var_135_0 < var_135_4 then
					arg_132_1.talkMaxDuration = var_135_4

					if var_135_4 + 0 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_4 + 0
					end
				end

				arg_132_1.text_.text = var_135_2
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121031", "story_v_out_425121.awb") ~= 0 then
					local var_135_5 = manager.audio:GetVoiceLength("story_v_out_425121", "425121031", "story_v_out_425121.awb") / 1000

					if var_135_5 + 0 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_5 + 0
					end

					if var_135_1.prefab_name ~= "" and arg_132_1.actors_[var_135_1.prefab_name] ~= nil then
						local var_135_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_1.prefab_name].transform, "story_v_out_425121", "425121031", "story_v_out_425121.awb")

						arg_132_1:RecordAudio("425121031", var_135_6)
						arg_132_1:RecordAudio("425121031", var_135_6)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_425121", "425121031", "story_v_out_425121.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_425121", "425121031", "story_v_out_425121.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_7 = math.max(var_135_0, arg_132_1.talkMaxDuration)

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_7 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - 0) / var_135_7

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= 0 + var_135_7 and arg_132_1.time_ < 0 + var_135_7 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play425121032 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 425121032
		arg_136_1.duration_ = 10.37

		local var_136_0 = {
			zh = 7.533,
			ja = 10.366
		}
		local var_136_1 = manager.audio:GetLocalizationFlag()

		if var_136_0[var_136_1] ~= nil then
			arg_136_1.duration_ = var_136_0[var_136_1]
		end

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play425121033(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1.var_.moveOldPos1036 = arg_136_1.actors_["1036"].transform.localPosition
				arg_136_1.actors_["1036"].transform.localScale = Vector3.New(1, 1, 1)

				arg_136_1:CheckSpriteTmpPos("1036", 3)

				for iter_139_0 = 0, arg_136_1.actors_["1036"].transform.childCount - 1 do
					local var_139_0 = arg_136_1.actors_["1036"].transform:GetChild(iter_139_0)

					if var_139_0.name == "" or not string.find(var_139_0.name, "split") then
						var_139_0.gameObject:SetActive(true)
					else
						var_139_0.gameObject:SetActive(false)
					end
				end
			end

			local var_139_1 = 0.001

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_1 then
				arg_136_1.actors_["1036"].transform.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos1036, Vector3.New(0, -388, -250), (arg_136_1.time_ - 0) / var_139_1)
			end

			if arg_136_1.time_ >= 0 + var_139_1 and arg_136_1.time_ < 0 + var_139_1 + arg_139_0 then
				arg_136_1.actors_["1036"].transform.localPosition = Vector3.New(0, -388, -250)
			end

			local var_139_2 = 0
			local var_139_3 = 0.95

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_2 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				arg_136_1.leftNameTxt_.text = arg_136_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_4 = arg_136_1:GetWordFromCfg(425121032)
				local var_139_5 = arg_136_1:FormatText(var_139_4.content)

				arg_136_1.text_.text = var_139_5

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_7 = 38 <= 0 and var_139_3 or var_139_3 * (utf8.len(var_139_5) / 38)

				if (38 <= 0 and var_139_3 or var_139_3 * (utf8.len(var_139_5) / 38)) > 0 and var_139_3 < var_139_7 then
					arg_136_1.talkMaxDuration = var_139_7

					if var_139_7 + var_139_2 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_7 + var_139_2
					end
				end

				arg_136_1.text_.text = var_139_5
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121032", "story_v_out_425121.awb") ~= 0 then
					local var_139_8 = manager.audio:GetVoiceLength("story_v_out_425121", "425121032", "story_v_out_425121.awb") / 1000

					if var_139_8 + var_139_2 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_8 + var_139_2
					end

					if var_139_4.prefab_name ~= "" and arg_136_1.actors_[var_139_4.prefab_name] ~= nil then
						local var_139_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_4.prefab_name].transform, "story_v_out_425121", "425121032", "story_v_out_425121.awb")

						arg_136_1:RecordAudio("425121032", var_139_9)
						arg_136_1:RecordAudio("425121032", var_139_9)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_425121", "425121032", "story_v_out_425121.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_425121", "425121032", "story_v_out_425121.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_10 = math.max(var_139_3, arg_136_1.talkMaxDuration)

			if var_139_2 <= arg_136_1.time_ and arg_136_1.time_ < var_139_2 + var_139_10 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_2) / var_139_10

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_2 + var_139_10 and arg_136_1.time_ < var_139_2 + var_139_10 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_136_1:InitPlayNodeList()
	end,
	Play425121033 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 425121033
		arg_140_1.duration_ = 6.07

		local var_140_0 = {
			zh = 5.4,
			ja = 6.066
		}
		local var_140_1 = manager.audio:GetLocalizationFlag()

		if var_140_0[var_140_1] ~= nil then
			arg_140_1.duration_ = var_140_0[var_140_1]
		end

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play425121034(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 and not isNil(arg_140_1.actors_["1036"]) and arg_140_1.var_.actorSpriteComps1036 == nil then
				arg_140_1.var_.actorSpriteComps1036 = arg_140_1.actors_["1036"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_143_0 = 0.2

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_0 and not isNil(arg_140_1.actors_["1036"]) then
				if arg_140_1.var_.actorSpriteComps1036 then
					for iter_143_0, iter_143_1 in pairs(arg_140_1.var_.actorSpriteComps1036:ToTable()) do
						if iter_143_1 then
							if arg_140_1.isInRecall_ then
								iter_143_1.color = Color.New(Mathf.Lerp(iter_143_1.color.r, arg_140_1.hightColor2.r, (arg_140_1.time_ - 0) / var_143_0), Mathf.Lerp(iter_143_1.color.g, arg_140_1.hightColor2.g, (arg_140_1.time_ - 0) / var_143_0), (Mathf.Lerp(iter_143_1.color.b, arg_140_1.hightColor2.b, (arg_140_1.time_ - 0) / var_143_0)))
							else
								local var_143_1 = Mathf.Lerp(iter_143_1.color.r, 0.5, (arg_140_1.time_ - 0) / var_143_0)

								iter_143_1.color = Color.New(var_143_1, var_143_1, var_143_1)
							end
						end
					end
				end
			end

			if arg_140_1.time_ >= 0 + var_143_0 and arg_140_1.time_ < 0 + var_143_0 + arg_143_0 and not isNil(arg_140_1.actors_["1036"]) and arg_140_1.var_.actorSpriteComps1036 then
				for iter_143_2, iter_143_3 in pairs(arg_140_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_143_3 then
						iter_143_3.color = arg_140_1.isInRecall_ and (arg_140_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_140_1.var_.actorSpriteComps1036 = nil
			end

			local var_143_2 = 0
			local var_143_3 = 0.5

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_2 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				arg_140_1.leftNameTxt_.text = arg_140_1:FormatText(StoryNameCfg[1082].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, true)
				arg_140_1.iconController_:SetSelectedState("hero")

				arg_140_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officerma")

				arg_140_1.callingController_:SetSelectedState("normal")

				arg_140_1.keyicon_.color = Color.New(1, 1, 1)
				arg_140_1.icon_.color = Color.New(1, 1, 1)

				local var_143_4 = arg_140_1:GetWordFromCfg(425121033)
				local var_143_5 = arg_140_1:FormatText(var_143_4.content)

				arg_140_1.text_.text = var_143_5

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_7 = 20 <= 0 and var_143_3 or var_143_3 * (utf8.len(var_143_5) / 20)

				if (20 <= 0 and var_143_3 or var_143_3 * (utf8.len(var_143_5) / 20)) > 0 and var_143_3 < var_143_7 then
					arg_140_1.talkMaxDuration = var_143_7

					if var_143_7 + var_143_2 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_7 + var_143_2
					end
				end

				arg_140_1.text_.text = var_143_5
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121033", "story_v_out_425121.awb") ~= 0 then
					local var_143_8 = manager.audio:GetVoiceLength("story_v_out_425121", "425121033", "story_v_out_425121.awb") / 1000

					if var_143_8 + var_143_2 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_8 + var_143_2
					end

					if var_143_4.prefab_name ~= "" and arg_140_1.actors_[var_143_4.prefab_name] ~= nil then
						local var_143_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_4.prefab_name].transform, "story_v_out_425121", "425121033", "story_v_out_425121.awb")

						arg_140_1:RecordAudio("425121033", var_143_9)
						arg_140_1:RecordAudio("425121033", var_143_9)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_425121", "425121033", "story_v_out_425121.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_425121", "425121033", "story_v_out_425121.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_10 = math.max(var_143_3, arg_140_1.talkMaxDuration)

			if var_143_2 <= arg_140_1.time_ and arg_140_1.time_ < var_143_2 + var_143_10 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_2) / var_143_10

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_2 + var_143_10 and arg_140_1.time_ < var_143_2 + var_143_10 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play425121034 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 425121034
		arg_144_1.duration_ = 5

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play425121035(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1.var_.moveOldPos1036 = arg_144_1.actors_["1036"].transform.localPosition
				arg_144_1.actors_["1036"].transform.localScale = Vector3.New(1, 1, 1)

				arg_144_1:CheckSpriteTmpPos("1036", 7)

				for iter_147_0 = 0, arg_144_1.actors_["1036"].transform.childCount - 1 do
					local var_147_0 = arg_144_1.actors_["1036"].transform:GetChild(iter_147_0)

					if var_147_0.name == "" or not string.find(var_147_0.name, "split") then
						var_147_0.gameObject:SetActive(true)
					else
						var_147_0.gameObject:SetActive(false)
					end
				end
			end

			local var_147_1 = 0.001

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_1 then
				arg_144_1.actors_["1036"].transform.localPosition = Vector3.Lerp(arg_144_1.var_.moveOldPos1036, Vector3.New(0, -2000, 0), (arg_144_1.time_ - 0) / var_147_1)
			end

			if arg_144_1.time_ >= 0 + var_147_1 and arg_144_1.time_ < 0 + var_147_1 + arg_147_0 then
				arg_144_1.actors_["1036"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_147_2 = 0
			local var_147_3 = 0.6

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= var_147_2 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, false)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_4 = arg_144_1:FormatText(arg_144_1:GetWordFromCfg(425121034).content)

				arg_144_1.text_.text = var_147_4

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_6 = 24 <= 0 and var_147_3 or var_147_3 * (utf8.len(var_147_4) / 24)

				if (24 <= 0 and var_147_3 or var_147_3 * (utf8.len(var_147_4) / 24)) > 0 and var_147_3 < var_147_6 then
					arg_144_1.talkMaxDuration = var_147_6

					if var_147_6 + var_147_2 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_6 + var_147_2
					end
				end

				arg_144_1.text_.text = var_147_4
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)
				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_7 = math.max(var_147_3, arg_144_1.talkMaxDuration)

			if var_147_2 <= arg_144_1.time_ and arg_144_1.time_ < var_147_2 + var_147_7 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_2) / var_147_7

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_2 + var_147_7 and arg_144_1.time_ < var_147_2 + var_147_7 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_144_1:InitPlayNodeList()
	end,
	Play425121035 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 425121035
		arg_148_1.duration_ = 5.63

		local var_148_0 = {
			zh = 4.4,
			ja = 5.633
		}
		local var_148_1 = manager.audio:GetLocalizationFlag()

		if var_148_0[var_148_1] ~= nil then
			arg_148_1.duration_ = var_148_0[var_148_1]
		end

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play425121036(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 and not isNil(arg_148_1.actors_["1036"]) and arg_148_1.var_.actorSpriteComps1036 == nil then
				arg_148_1.var_.actorSpriteComps1036 = arg_148_1.actors_["1036"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_151_0 = 0.2

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_0 and not isNil(arg_148_1.actors_["1036"]) then
				if arg_148_1.var_.actorSpriteComps1036 then
					for iter_151_0, iter_151_1 in pairs(arg_148_1.var_.actorSpriteComps1036:ToTable()) do
						if iter_151_1 then
							if arg_148_1.isInRecall_ then
								iter_151_1.color = Color.New(Mathf.Lerp(iter_151_1.color.r, arg_148_1.hightColor1.r, (arg_148_1.time_ - 0) / var_151_0), Mathf.Lerp(iter_151_1.color.g, arg_148_1.hightColor1.g, (arg_148_1.time_ - 0) / var_151_0), (Mathf.Lerp(iter_151_1.color.b, arg_148_1.hightColor1.b, (arg_148_1.time_ - 0) / var_151_0)))
							else
								local var_151_1 = Mathf.Lerp(iter_151_1.color.r, 1, (arg_148_1.time_ - 0) / var_151_0)

								iter_151_1.color = Color.New(var_151_1, var_151_1, var_151_1)
							end
						end
					end
				end
			end

			if arg_148_1.time_ >= 0 + var_151_0 and arg_148_1.time_ < 0 + var_151_0 + arg_151_0 and not isNil(arg_148_1.actors_["1036"]) and arg_148_1.var_.actorSpriteComps1036 then
				for iter_151_2, iter_151_3 in pairs(arg_148_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_151_3 then
						iter_151_3.color = arg_148_1.isInRecall_ and (arg_148_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_148_1.var_.actorSpriteComps1036 = nil
			end

			local var_151_2 = arg_148_1.actors_["1036"].transform

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1.var_.moveOldPos1036 = var_151_2.localPosition
				var_151_2.localScale = Vector3.New(1, 1, 1)

				arg_148_1:CheckSpriteTmpPos("1036", 3)

				for iter_151_4 = 0, var_151_2.childCount - 1 do
					local var_151_3 = var_151_2:GetChild(iter_151_4)

					if var_151_3.name == "" or not string.find(var_151_3.name, "split") then
						var_151_3.gameObject:SetActive(true)
					else
						var_151_3.gameObject:SetActive(false)
					end
				end
			end

			local var_151_4 = 0.001

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_4 then
				var_151_2.localPosition = Vector3.Lerp(arg_148_1.var_.moveOldPos1036, Vector3.New(0, -388, -250), (arg_148_1.time_ - 0) / var_151_4)
			end

			if arg_148_1.time_ >= 0 + var_151_4 and arg_148_1.time_ < 0 + var_151_4 + arg_151_0 then
				var_151_2.localPosition = Vector3.New(0, -388, -250)
			end

			local var_151_5 = 0
			local var_151_6 = 0.55

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= var_151_5 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				arg_148_1.leftNameTxt_.text = arg_148_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_7 = arg_148_1:GetWordFromCfg(425121035)
				local var_151_8 = arg_148_1:FormatText(var_151_7.content)

				arg_148_1.text_.text = var_151_8

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_10 = 22 <= 0 and var_151_6 or var_151_6 * (utf8.len(var_151_8) / 22)

				if (22 <= 0 and var_151_6 or var_151_6 * (utf8.len(var_151_8) / 22)) > 0 and var_151_6 < var_151_10 then
					arg_148_1.talkMaxDuration = var_151_10

					if var_151_10 + var_151_5 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_10 + var_151_5
					end
				end

				arg_148_1.text_.text = var_151_8
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121035", "story_v_out_425121.awb") ~= 0 then
					local var_151_11 = manager.audio:GetVoiceLength("story_v_out_425121", "425121035", "story_v_out_425121.awb") / 1000

					if var_151_11 + var_151_5 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_11 + var_151_5
					end

					if var_151_7.prefab_name ~= "" and arg_148_1.actors_[var_151_7.prefab_name] ~= nil then
						local var_151_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_7.prefab_name].transform, "story_v_out_425121", "425121035", "story_v_out_425121.awb")

						arg_148_1:RecordAudio("425121035", var_151_12)
						arg_148_1:RecordAudio("425121035", var_151_12)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_out_425121", "425121035", "story_v_out_425121.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_out_425121", "425121035", "story_v_out_425121.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_13 = math.max(var_151_6, arg_148_1.talkMaxDuration)

			if var_151_5 <= arg_148_1.time_ and arg_148_1.time_ < var_151_5 + var_151_13 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_5) / var_151_13

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_5 + var_151_13 and arg_148_1.time_ < var_151_5 + var_151_13 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_148_1:InitPlayNodeList()
	end,
	Play425121036 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 425121036
		arg_152_1.duration_ = 4.43

		local var_152_0 = {
			zh = 4,
			ja = 4.433
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
				arg_152_0:Play425121037(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 and not isNil(arg_152_1.actors_["1036"]) and arg_152_1.var_.actorSpriteComps1036 == nil then
				arg_152_1.var_.actorSpriteComps1036 = arg_152_1.actors_["1036"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_155_0 = 0.2

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_0 and not isNil(arg_152_1.actors_["1036"]) then
				if arg_152_1.var_.actorSpriteComps1036 then
					for iter_155_0, iter_155_1 in pairs(arg_152_1.var_.actorSpriteComps1036:ToTable()) do
						if iter_155_1 then
							if arg_152_1.isInRecall_ then
								iter_155_1.color = Color.New(Mathf.Lerp(iter_155_1.color.r, arg_152_1.hightColor2.r, (arg_152_1.time_ - 0) / var_155_0), Mathf.Lerp(iter_155_1.color.g, arg_152_1.hightColor2.g, (arg_152_1.time_ - 0) / var_155_0), (Mathf.Lerp(iter_155_1.color.b, arg_152_1.hightColor2.b, (arg_152_1.time_ - 0) / var_155_0)))
							else
								local var_155_1 = Mathf.Lerp(iter_155_1.color.r, 0.5, (arg_152_1.time_ - 0) / var_155_0)

								iter_155_1.color = Color.New(var_155_1, var_155_1, var_155_1)
							end
						end
					end
				end
			end

			if arg_152_1.time_ >= 0 + var_155_0 and arg_152_1.time_ < 0 + var_155_0 + arg_155_0 and not isNil(arg_152_1.actors_["1036"]) and arg_152_1.var_.actorSpriteComps1036 then
				for iter_155_2, iter_155_3 in pairs(arg_152_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_155_3 then
						iter_155_3.color = arg_152_1.isInRecall_ and (arg_152_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_152_1.var_.actorSpriteComps1036 = nil
			end

			local var_155_2 = 0
			local var_155_3 = 0.35

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= var_155_2 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				arg_152_1.leftNameTxt_.text = arg_152_1:FormatText(StoryNameCfg[1082].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, true)
				arg_152_1.iconController_:SetSelectedState("hero")

				arg_152_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officerma")

				arg_152_1.callingController_:SetSelectedState("normal")

				arg_152_1.keyicon_.color = Color.New(1, 1, 1)
				arg_152_1.icon_.color = Color.New(1, 1, 1)

				local var_155_4 = arg_152_1:GetWordFromCfg(425121036)
				local var_155_5 = arg_152_1:FormatText(var_155_4.content)

				arg_152_1.text_.text = var_155_5

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_7 = 14 <= 0 and var_155_3 or var_155_3 * (utf8.len(var_155_5) / 14)

				if (14 <= 0 and var_155_3 or var_155_3 * (utf8.len(var_155_5) / 14)) > 0 and var_155_3 < var_155_7 then
					arg_152_1.talkMaxDuration = var_155_7

					if var_155_7 + var_155_2 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_7 + var_155_2
					end
				end

				arg_152_1.text_.text = var_155_5
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121036", "story_v_out_425121.awb") ~= 0 then
					local var_155_8 = manager.audio:GetVoiceLength("story_v_out_425121", "425121036", "story_v_out_425121.awb") / 1000

					if var_155_8 + var_155_2 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_8 + var_155_2
					end

					if var_155_4.prefab_name ~= "" and arg_152_1.actors_[var_155_4.prefab_name] ~= nil then
						local var_155_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_4.prefab_name].transform, "story_v_out_425121", "425121036", "story_v_out_425121.awb")

						arg_152_1:RecordAudio("425121036", var_155_9)
						arg_152_1:RecordAudio("425121036", var_155_9)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_425121", "425121036", "story_v_out_425121.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_425121", "425121036", "story_v_out_425121.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_10 = math.max(var_155_3, arg_152_1.talkMaxDuration)

			if var_155_2 <= arg_152_1.time_ and arg_152_1.time_ < var_155_2 + var_155_10 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_2) / var_155_10

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_2 + var_155_10 and arg_152_1.time_ < var_155_2 + var_155_10 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	Play425121037 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 425121037
		arg_156_1.duration_ = 5.5

		local var_156_0 = {
			zh = 5.3,
			ja = 5.5
		}
		local var_156_1 = manager.audio:GetLocalizationFlag()

		if var_156_0[var_156_1] ~= nil then
			arg_156_1.duration_ = var_156_0[var_156_1]
		end

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play425121038(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			if 2 < arg_156_1.time_ and arg_156_1.time_ <= 2 + arg_159_0 then
				local var_159_0 = arg_156_1.bgs_.M01i

				arg_156_1.bgs_.M01i.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_159_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_159_1 = var_159_0:GetComponent("SpriteRenderer")

				if var_159_1 and var_159_1.sprite then
					local var_159_2 = 2 * (var_159_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_159_0.transform.localScale = Vector3.New(var_159_2 / var_159_1.sprite.bounds.size.y < var_159_2 * manager.ui.mainCameraCom_.aspect / var_159_1.sprite.bounds.size.x and var_159_2 * manager.ui.mainCameraCom_.aspect / var_159_1.sprite.bounds.size.x or var_159_2 / var_159_1.sprite.bounds.size.y, var_159_2 / var_159_1.sprite.bounds.size.y < var_159_2 * manager.ui.mainCameraCom_.aspect / var_159_1.sprite.bounds.size.x and var_159_2 * manager.ui.mainCameraCom_.aspect / var_159_1.sprite.bounds.size.x or var_159_2 / var_159_1.sprite.bounds.size.y, 0)
				end

				for iter_159_0, iter_159_1 in pairs(arg_156_1.bgs_) do
					if iter_159_0 ~= "M01i" then
						iter_159_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_159_3 = 4

			if 4 < arg_156_1.time_ and arg_156_1.time_ <= var_159_3 + arg_159_0 then
				arg_156_1.allBtn_.enabled = false
			end

			if arg_156_1.time_ >= var_159_3 + 0.0999999999999996 and arg_156_1.time_ < var_159_3 + 0.0999999999999996 + arg_159_0 then
				arg_156_1.allBtn_.enabled = true
			end

			local var_159_4 = 0

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_4 + arg_159_0 then
				arg_156_1.mask_.enabled = true
				arg_156_1.mask_.raycastTarget = true

				arg_156_1:SetGaussion(false)
			end

			local var_159_5 = 2

			if var_159_4 <= arg_156_1.time_ and arg_156_1.time_ < var_159_4 + var_159_5 then
				local var_159_6 = Color.New(0, 0, 0)

				var_159_6.a = Mathf.Lerp(0, 1, (arg_156_1.time_ - var_159_4) / var_159_5)
				arg_156_1.mask_.color = var_159_6
			end

			if arg_156_1.time_ >= var_159_4 + var_159_5 and arg_156_1.time_ < var_159_4 + var_159_5 + arg_159_0 then
				local var_159_7 = Color.New(0, 0, 0)

				var_159_7.a = 1
				arg_156_1.mask_.color = var_159_7
			end

			local var_159_8 = 2

			if 2 < arg_156_1.time_ and arg_156_1.time_ <= var_159_8 + arg_159_0 then
				arg_156_1.mask_.enabled = true
				arg_156_1.mask_.raycastTarget = true

				arg_156_1:SetGaussion(false)
			end

			local var_159_9 = 2

			if var_159_8 <= arg_156_1.time_ and arg_156_1.time_ < var_159_8 + var_159_9 then
				local var_159_10 = Color.New(0, 0, 0)

				var_159_10.a = Mathf.Lerp(1, 0, (arg_156_1.time_ - var_159_8) / var_159_9)
				arg_156_1.mask_.color = var_159_10
			end

			if arg_156_1.time_ >= var_159_8 + var_159_9 and arg_156_1.time_ < var_159_8 + var_159_9 + arg_159_0 then
				local var_159_11 = Color.New(0, 0, 0)

				arg_156_1.mask_.enabled = false
				var_159_11.a = 0
				arg_156_1.mask_.color = var_159_11
			end

			local var_159_12 = arg_156_1.actors_["1036"].transform

			if 1.96666666666667 < arg_156_1.time_ and arg_156_1.time_ <= 1.96666666666667 + arg_159_0 then
				arg_156_1.var_.moveOldPos1036 = var_159_12.localPosition
				var_159_12.localScale = Vector3.New(1, 1, 1)

				arg_156_1:CheckSpriteTmpPos("1036", 7)

				for iter_159_2 = 0, var_159_12.childCount - 1 do
					local var_159_13 = var_159_12:GetChild(iter_159_2)

					if var_159_13.name == "" or not string.find(var_159_13.name, "split") then
						var_159_13.gameObject:SetActive(true)
					else
						var_159_13.gameObject:SetActive(false)
					end
				end
			end

			local var_159_14 = 0.001

			if 1.96666666666667 <= arg_156_1.time_ and arg_156_1.time_ < 1.96666666666667 + var_159_14 then
				var_159_12.localPosition = Vector3.Lerp(arg_156_1.var_.moveOldPos1036, Vector3.New(0, -2000, 0), (arg_156_1.time_ - 1.96666666666667) / var_159_14)
			end

			if arg_156_1.time_ >= 1.96666666666667 + var_159_14 and arg_156_1.time_ < 1.96666666666667 + var_159_14 + arg_159_0 then
				var_159_12.localPosition = Vector3.New(0, -2000, 0)
			end

			if arg_156_1.frameCnt_ <= 1 then
				arg_156_1.dialog_:SetActive(false)
			end

			local var_159_15 = 4
			local var_159_16 = 0.1

			if 4 < arg_156_1.time_ and arg_156_1.time_ <= var_159_15 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0

				arg_156_1.dialog_:SetActive(true)

				arg_156_1.dialogCg_.alpha = 0

				local var_159_17 = LeanTween.value(arg_156_1.dialog_, 0, 1, 0.3)

				var_159_17:setOnUpdate(LuaHelper.FloatAction(function(arg_160_0)
					arg_156_1.dialogCg_.alpha = arg_160_0
				end))
				var_159_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_156_1.dialog_)
					var_159_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_156_1.duration_ = arg_156_1.duration_ + 0.3

				SetActive(arg_156_1.leftNameGo_, true)

				arg_156_1.leftNameTxt_.text = arg_156_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, true)
				arg_156_1.iconController_:SetSelectedState("hero")

				arg_156_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1036")

				arg_156_1.callingController_:SetSelectedState("normal")

				arg_156_1.keyicon_.color = Color.New(1, 1, 1)
				arg_156_1.icon_.color = Color.New(1, 1, 1)

				local var_159_18 = arg_156_1:GetWordFromCfg(425121037)
				local var_159_19 = arg_156_1:FormatText(var_159_18.content)

				arg_156_1.text_.text = var_159_19

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_21 = 4 <= 0 and var_159_16 or var_159_16 * (utf8.len(var_159_19) / 4)

				if (4 <= 0 and var_159_16 or var_159_16 * (utf8.len(var_159_19) / 4)) > 0 and var_159_16 < var_159_21 then
					arg_156_1.talkMaxDuration = var_159_21
					var_159_15 = var_159_15 + 0.3

					if var_159_21 + var_159_15 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_21 + var_159_15
					end
				end

				arg_156_1.text_.text = var_159_19
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121037", "story_v_out_425121.awb") ~= 0 then
					local var_159_22 = manager.audio:GetVoiceLength("story_v_out_425121", "425121037", "story_v_out_425121.awb") / 1000

					if var_159_22 + var_159_15 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_22 + var_159_15
					end

					if var_159_18.prefab_name ~= "" and arg_156_1.actors_[var_159_18.prefab_name] ~= nil then
						local var_159_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_18.prefab_name].transform, "story_v_out_425121", "425121037", "story_v_out_425121.awb")

						arg_156_1:RecordAudio("425121037", var_159_23)
						arg_156_1:RecordAudio("425121037", var_159_23)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_425121", "425121037", "story_v_out_425121.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_425121", "425121037", "story_v_out_425121.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_24 = var_159_15 + 0.3
			local var_159_25 = math.max(var_159_16, arg_156_1.talkMaxDuration)

			if var_159_15 + 0.3 <= arg_156_1.time_ and arg_156_1.time_ < var_159_24 + var_159_25 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_24) / var_159_25

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_24 + var_159_25 and arg_156_1.time_ < var_159_24 + var_159_25 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.96666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_156_1:InitPlayNodeList()
	end,
	Play425121038 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 425121038
		arg_162_1.duration_ = 5

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play425121039(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 and not isNil(arg_162_1.actors_["1036"]) and arg_162_1.var_.actorSpriteComps1036 == nil then
				arg_162_1.var_.actorSpriteComps1036 = arg_162_1.actors_["1036"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_165_0 = 0.2

			if 0 <= arg_162_1.time_ and arg_162_1.time_ < 0 + var_165_0 and not isNil(arg_162_1.actors_["1036"]) then
				if arg_162_1.var_.actorSpriteComps1036 then
					for iter_165_0, iter_165_1 in pairs(arg_162_1.var_.actorSpriteComps1036:ToTable()) do
						if iter_165_1 then
							if arg_162_1.isInRecall_ then
								iter_165_1.color = Color.New(Mathf.Lerp(iter_165_1.color.r, arg_162_1.hightColor2.r, (arg_162_1.time_ - 0) / var_165_0), Mathf.Lerp(iter_165_1.color.g, arg_162_1.hightColor2.g, (arg_162_1.time_ - 0) / var_165_0), (Mathf.Lerp(iter_165_1.color.b, arg_162_1.hightColor2.b, (arg_162_1.time_ - 0) / var_165_0)))
							else
								local var_165_1 = Mathf.Lerp(iter_165_1.color.r, 0.5, (arg_162_1.time_ - 0) / var_165_0)

								iter_165_1.color = Color.New(var_165_1, var_165_1, var_165_1)
							end
						end
					end
				end
			end

			if arg_162_1.time_ >= 0 + var_165_0 and arg_162_1.time_ < 0 + var_165_0 + arg_165_0 and not isNil(arg_162_1.actors_["1036"]) and arg_162_1.var_.actorSpriteComps1036 then
				for iter_165_2, iter_165_3 in pairs(arg_162_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_165_3 then
						iter_165_3.color = arg_162_1.isInRecall_ and (arg_162_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_162_1.var_.actorSpriteComps1036 = nil
			end

			local var_165_2 = 0
			local var_165_3 = 0.625

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= var_165_2 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, false)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_4 = arg_162_1:FormatText(arg_162_1:GetWordFromCfg(425121038).content)

				arg_162_1.text_.text = var_165_4

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_6 = 25 <= 0 and var_165_3 or var_165_3 * (utf8.len(var_165_4) / 25)

				if (25 <= 0 and var_165_3 or var_165_3 * (utf8.len(var_165_4) / 25)) > 0 and var_165_3 < var_165_6 then
					arg_162_1.talkMaxDuration = var_165_6

					if var_165_6 + var_165_2 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_6 + var_165_2
					end
				end

				arg_162_1.text_.text = var_165_4
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)
				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_7 = math.max(var_165_3, arg_162_1.talkMaxDuration)

			if var_165_2 <= arg_162_1.time_ and arg_162_1.time_ < var_165_2 + var_165_7 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_2) / var_165_7

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_2 + var_165_7 and arg_162_1.time_ < var_165_2 + var_165_7 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {}

		arg_162_1:InitPlayNodeList()
	end,
	Play425121039 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 425121039
		arg_166_1.duration_ = 1.67

		local var_166_0 = {
			zh = 1.466,
			ja = 1.666
		}
		local var_166_1 = manager.audio:GetLocalizationFlag()

		if var_166_0[var_166_1] ~= nil then
			arg_166_1.duration_ = var_166_0[var_166_1]
		end

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play425121040(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			if arg_166_1.actors_["1137"] == nil then
				local var_169_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1137")

				if not isNil(var_169_0) then
					local var_169_1 = Object.Instantiate(var_169_0, arg_166_1.canvasGo_.transform)

					var_169_1.transform:SetSiblingIndex(1)

					var_169_1.name = "1137"
					var_169_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_166_1.actors_["1137"] = var_169_1

					if arg_166_1.isInRecall_ then
						for iter_169_0, iter_169_1 in ipairs((var_169_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_169_1.color = arg_166_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_169_2 = arg_166_1.actors_["1137"]

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 and not isNil(var_169_2) and arg_166_1.var_.actorSpriteComps1137 == nil then
				arg_166_1.var_.actorSpriteComps1137 = var_169_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_169_3 = 0.2

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_3 and not isNil(var_169_2) then
				if arg_166_1.var_.actorSpriteComps1137 then
					for iter_169_2, iter_169_3 in pairs(arg_166_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_169_3 then
							if arg_166_1.isInRecall_ then
								iter_169_3.color = Color.New(Mathf.Lerp(iter_169_3.color.r, arg_166_1.hightColor1.r, (arg_166_1.time_ - 0) / var_169_3), Mathf.Lerp(iter_169_3.color.g, arg_166_1.hightColor1.g, (arg_166_1.time_ - 0) / var_169_3), (Mathf.Lerp(iter_169_3.color.b, arg_166_1.hightColor1.b, (arg_166_1.time_ - 0) / var_169_3)))
							else
								local var_169_4 = Mathf.Lerp(iter_169_3.color.r, 1, (arg_166_1.time_ - 0) / var_169_3)

								iter_169_3.color = Color.New(var_169_4, var_169_4, var_169_4)
							end
						end
					end
				end
			end

			if arg_166_1.time_ >= 0 + var_169_3 and arg_166_1.time_ < 0 + var_169_3 + arg_169_0 and not isNil(var_169_2) and arg_166_1.var_.actorSpriteComps1137 then
				for iter_169_4, iter_169_5 in pairs(arg_166_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_169_5 then
						iter_169_5.color = arg_166_1.isInRecall_ and (arg_166_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_166_1.var_.actorSpriteComps1137 = nil
			end

			local var_169_5 = arg_166_1.actors_["1137"].transform

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 then
				arg_166_1.var_.moveOldPos1137 = var_169_5.localPosition
				var_169_5.localScale = Vector3.New(1, 1, 1)

				arg_166_1:CheckSpriteTmpPos("1137", 2)

				for iter_169_6 = 0, var_169_5.childCount - 1 do
					local var_169_6 = var_169_5:GetChild(iter_169_6)

					if var_169_6.name == "split_5" or not string.find(var_169_6.name, "split") then
						var_169_6.gameObject:SetActive(true)
					else
						var_169_6.gameObject:SetActive(false)
					end
				end
			end

			local var_169_7 = 0.001

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_7 then
				var_169_5.localPosition = Vector3.Lerp(arg_166_1.var_.moveOldPos1137, Vector3.New(-390, -425, -200), (arg_166_1.time_ - 0) / var_169_7)
			end

			if arg_166_1.time_ >= 0 + var_169_7 and arg_166_1.time_ < 0 + var_169_7 + arg_169_0 then
				var_169_5.localPosition = Vector3.New(-390, -425, -200)
			end

			local var_169_8 = 0
			local var_169_9 = 0.075

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= var_169_8 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, true)

				arg_166_1.leftNameTxt_.text = arg_166_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_10 = arg_166_1:GetWordFromCfg(425121039)
				local var_169_11 = arg_166_1:FormatText(var_169_10.content)

				arg_166_1.text_.text = var_169_11

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_13 = 3 <= 0 and var_169_9 or var_169_9 * (utf8.len(var_169_11) / 3)

				if (3 <= 0 and var_169_9 or var_169_9 * (utf8.len(var_169_11) / 3)) > 0 and var_169_9 < var_169_13 then
					arg_166_1.talkMaxDuration = var_169_13

					if var_169_13 + var_169_8 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_13 + var_169_8
					end
				end

				arg_166_1.text_.text = var_169_11
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121039", "story_v_out_425121.awb") ~= 0 then
					local var_169_14 = manager.audio:GetVoiceLength("story_v_out_425121", "425121039", "story_v_out_425121.awb") / 1000

					if var_169_14 + var_169_8 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_14 + var_169_8
					end

					if var_169_10.prefab_name ~= "" and arg_166_1.actors_[var_169_10.prefab_name] ~= nil then
						local var_169_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_166_1.actors_[var_169_10.prefab_name].transform, "story_v_out_425121", "425121039", "story_v_out_425121.awb")

						arg_166_1:RecordAudio("425121039", var_169_15)
						arg_166_1:RecordAudio("425121039", var_169_15)
					else
						arg_166_1:AudioAction("play", "voice", "story_v_out_425121", "425121039", "story_v_out_425121.awb")
					end

					arg_166_1:RecordHistoryTalkVoice("story_v_out_425121", "425121039", "story_v_out_425121.awb")
				end

				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_16 = math.max(var_169_9, arg_166_1.talkMaxDuration)

			if var_169_8 <= arg_166_1.time_ and arg_166_1.time_ < var_169_8 + var_169_16 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_8) / var_169_16

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_8 + var_169_16 and arg_166_1.time_ < var_169_8 + var_169_16 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1137",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_166_1:InitPlayNodeList()
	end,
	Play425121040 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 425121040
		arg_170_1.duration_ = 1.93

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play425121041(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 and not isNil(arg_170_1.actors_["1036"]) and arg_170_1.var_.actorSpriteComps1036 == nil then
				arg_170_1.var_.actorSpriteComps1036 = arg_170_1.actors_["1036"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_173_0 = 0.2

			if 0 <= arg_170_1.time_ and arg_170_1.time_ < 0 + var_173_0 and not isNil(arg_170_1.actors_["1036"]) then
				if arg_170_1.var_.actorSpriteComps1036 then
					for iter_173_0, iter_173_1 in pairs(arg_170_1.var_.actorSpriteComps1036:ToTable()) do
						if iter_173_1 then
							if arg_170_1.isInRecall_ then
								iter_173_1.color = Color.New(Mathf.Lerp(iter_173_1.color.r, arg_170_1.hightColor1.r, (arg_170_1.time_ - 0) / var_173_0), Mathf.Lerp(iter_173_1.color.g, arg_170_1.hightColor1.g, (arg_170_1.time_ - 0) / var_173_0), (Mathf.Lerp(iter_173_1.color.b, arg_170_1.hightColor1.b, (arg_170_1.time_ - 0) / var_173_0)))
							else
								local var_173_1 = Mathf.Lerp(iter_173_1.color.r, 1, (arg_170_1.time_ - 0) / var_173_0)

								iter_173_1.color = Color.New(var_173_1, var_173_1, var_173_1)
							end
						end
					end
				end
			end

			if arg_170_1.time_ >= 0 + var_173_0 and arg_170_1.time_ < 0 + var_173_0 + arg_173_0 and not isNil(arg_170_1.actors_["1036"]) and arg_170_1.var_.actorSpriteComps1036 then
				for iter_173_2, iter_173_3 in pairs(arg_170_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_173_3 then
						iter_173_3.color = arg_170_1.isInRecall_ and (arg_170_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_170_1.var_.actorSpriteComps1036 = nil
			end

			local var_173_2 = arg_170_1.actors_["1137"]

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 and not isNil(var_173_2) and arg_170_1.var_.actorSpriteComps1137 == nil then
				arg_170_1.var_.actorSpriteComps1137 = var_173_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_173_3 = 0.2

			if 0 <= arg_170_1.time_ and arg_170_1.time_ < 0 + var_173_3 and not isNil(var_173_2) then
				if arg_170_1.var_.actorSpriteComps1137 then
					for iter_173_4, iter_173_5 in pairs(arg_170_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_173_5 then
							if arg_170_1.isInRecall_ then
								iter_173_5.color = Color.New(Mathf.Lerp(iter_173_5.color.r, arg_170_1.hightColor2.r, (arg_170_1.time_ - 0) / var_173_3), Mathf.Lerp(iter_173_5.color.g, arg_170_1.hightColor2.g, (arg_170_1.time_ - 0) / var_173_3), (Mathf.Lerp(iter_173_5.color.b, arg_170_1.hightColor2.b, (arg_170_1.time_ - 0) / var_173_3)))
							else
								local var_173_4 = Mathf.Lerp(iter_173_5.color.r, 0.5, (arg_170_1.time_ - 0) / var_173_3)

								iter_173_5.color = Color.New(var_173_4, var_173_4, var_173_4)
							end
						end
					end
				end
			end

			if arg_170_1.time_ >= 0 + var_173_3 and arg_170_1.time_ < 0 + var_173_3 + arg_173_0 and not isNil(var_173_2) and arg_170_1.var_.actorSpriteComps1137 then
				for iter_173_6, iter_173_7 in pairs(arg_170_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_173_7 then
						iter_173_7.color = arg_170_1.isInRecall_ and (arg_170_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_170_1.var_.actorSpriteComps1137 = nil
			end

			local var_173_5 = arg_170_1.actors_["1036"].transform

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 then
				arg_170_1.var_.moveOldPos1036 = var_173_5.localPosition
				var_173_5.localScale = Vector3.New(1, 1, 1)

				arg_170_1:CheckSpriteTmpPos("1036", 4)

				for iter_173_8 = 0, var_173_5.childCount - 1 do
					local var_173_6 = var_173_5:GetChild(iter_173_8)

					if var_173_6.name == "" or not string.find(var_173_6.name, "split") then
						var_173_6.gameObject:SetActive(true)
					else
						var_173_6.gameObject:SetActive(false)
					end
				end
			end

			local var_173_7 = 0.001

			if 0 <= arg_170_1.time_ and arg_170_1.time_ < 0 + var_173_7 then
				var_173_5.localPosition = Vector3.Lerp(arg_170_1.var_.moveOldPos1036, Vector3.New(390, -388, -250), (arg_170_1.time_ - 0) / var_173_7)
			end

			if arg_170_1.time_ >= 0 + var_173_7 and arg_170_1.time_ < 0 + var_173_7 + arg_173_0 then
				var_173_5.localPosition = Vector3.New(390, -388, -250)
			end

			local var_173_8 = 0
			local var_173_9 = 0.2

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= var_173_8 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, true)

				arg_170_1.leftNameTxt_.text = arg_170_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_170_1.leftNameTxt_.transform)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1.leftNameTxt_.text)
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_10 = arg_170_1:GetWordFromCfg(425121040)
				local var_173_11 = arg_170_1:FormatText(var_173_10.content)

				arg_170_1.text_.text = var_173_11

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_13 = 8 <= 0 and var_173_9 or var_173_9 * (utf8.len(var_173_11) / 8)

				if (8 <= 0 and var_173_9 or var_173_9 * (utf8.len(var_173_11) / 8)) > 0 and var_173_9 < var_173_13 then
					arg_170_1.talkMaxDuration = var_173_13

					if var_173_13 + var_173_8 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_13 + var_173_8
					end
				end

				arg_170_1.text_.text = var_173_11
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121040", "story_v_out_425121.awb") ~= 0 then
					local var_173_14 = manager.audio:GetVoiceLength("story_v_out_425121", "425121040", "story_v_out_425121.awb") / 1000

					if var_173_14 + var_173_8 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_14 + var_173_8
					end

					if var_173_10.prefab_name ~= "" and arg_170_1.actors_[var_173_10.prefab_name] ~= nil then
						local var_173_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_170_1.actors_[var_173_10.prefab_name].transform, "story_v_out_425121", "425121040", "story_v_out_425121.awb")

						arg_170_1:RecordAudio("425121040", var_173_15)
						arg_170_1:RecordAudio("425121040", var_173_15)
					else
						arg_170_1:AudioAction("play", "voice", "story_v_out_425121", "425121040", "story_v_out_425121.awb")
					end

					arg_170_1:RecordHistoryTalkVoice("story_v_out_425121", "425121040", "story_v_out_425121.awb")
				end

				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_16 = math.max(var_173_9, arg_170_1.talkMaxDuration)

			if var_173_8 <= arg_170_1.time_ and arg_170_1.time_ < var_173_8 + var_173_16 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_8) / var_173_16

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_8 + var_173_16 and arg_170_1.time_ < var_173_8 + var_173_16 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_170_1:InitPlayNodeList()
	end,
	Play425121041 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 425121041
		arg_174_1.duration_ = 5

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play425121042(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			local var_177_9000

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1.var_.moveOldPos1036 = arg_174_1.actors_["1036"].transform.localPosition
				arg_174_1.actors_["1036"].transform.localScale = Vector3.New(1, 1, 1)

				arg_174_1:CheckSpriteTmpPos("1036", 7)

				for iter_177_0 = 0, arg_174_1.actors_["1036"].transform.childCount - 1 do
					local var_177_0 = arg_174_1.actors_["1036"].transform:GetChild(iter_177_0)

					if var_177_0.name == "" or not string.find(var_177_0.name, "split") then
						var_177_0.gameObject:SetActive(true)
					else
						var_177_0.gameObject:SetActive(false)
					end
				end
			end

			local var_177_1 = 0.001

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_1 then
				arg_174_1.actors_["1036"].transform.localPosition = Vector3.Lerp(arg_174_1.var_.moveOldPos1036, Vector3.New(0, -2000, 0), (arg_174_1.time_ - 0) / var_177_1)
			end

			if arg_174_1.time_ >= 0 + var_177_1 and arg_174_1.time_ < 0 + var_177_1 + arg_177_0 then
				arg_174_1.actors_["1036"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_177_2 = arg_174_1.actors_["1137"].transform

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1.var_.moveOldPos1137 = var_177_2.localPosition
				var_177_2.localScale = Vector3.New(1, 1, 1)

				arg_174_1:CheckSpriteTmpPos("1137", 7)

				for iter_177_1 = 0, var_177_2.childCount - 1 do
					local var_177_3 = var_177_2:GetChild(iter_177_1)

					if var_177_3.name == "" or not string.find(var_177_3.name, "split") then
						var_177_3.gameObject:SetActive(true)
					else
						var_177_3.gameObject:SetActive(false)
					end
				end
			end

			local var_177_4 = 0.001

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_4 then
				var_177_2.localPosition = Vector3.Lerp(arg_174_1.var_.moveOldPos1137, Vector3.New(0, -2000, 0), (arg_174_1.time_ - 0) / var_177_4)
			end

			if arg_174_1.time_ >= 0 + var_177_4 and arg_174_1.time_ < 0 + var_177_4 + arg_177_0 then
				var_177_2.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				local var_177_5 = arg_174_1.var_.effect1041

				if not arg_174_1.var_.effect1041 then
					var_177_5 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_redlight_keep"), manager.ui.mainCamera.transform)
					var_177_5.name = "1041"
					arg_174_1.var_.effect1041 = var_177_5
				else
					var_177_5.transform:SetParent(var_177_9000)
				end

				var_177_5.transform.localPosition = Vector3.New(0, 0, -2)
				var_177_5.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1:AudioAction("play", "effect", "se_story_147", "se_story_147_alarm", "")
			end

			local var_177_8 = 0
			local var_177_9 = 1

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= var_177_8 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, false)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_10 = arg_174_1:FormatText(arg_174_1:GetWordFromCfg(425121041).content)

				arg_174_1.text_.text = var_177_10

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_12 = 40 <= 0 and var_177_9 or var_177_9 * (utf8.len(var_177_10) / 40)

				if (40 <= 0 and var_177_9 or var_177_9 * (utf8.len(var_177_10) / 40)) > 0 and var_177_9 < var_177_12 then
					arg_174_1.talkMaxDuration = var_177_12

					if var_177_12 + var_177_8 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_12 + var_177_8
					end
				end

				arg_174_1.text_.text = var_177_10
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)
				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_13 = math.max(var_177_9, arg_174_1.talkMaxDuration)

			if var_177_8 <= arg_174_1.time_ and arg_174_1.time_ < var_177_8 + var_177_13 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_8) / var_177_13

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_8 + var_177_13 and arg_174_1.time_ < var_177_8 + var_177_13 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1137",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_174_1:InitPlayNodeList()
	end,
	Play425121042 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 425121042
		arg_178_1.duration_ = 6.23

		local var_178_0 = {
			zh = 4.866,
			ja = 6.233
		}
		local var_178_1 = manager.audio:GetLocalizationFlag()

		if var_178_0[var_178_1] ~= nil then
			arg_178_1.duration_ = var_178_0[var_178_1]
		end

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play425121043(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 and not isNil(arg_178_1.actors_["1036"]) and arg_178_1.var_.actorSpriteComps1036 == nil then
				arg_178_1.var_.actorSpriteComps1036 = arg_178_1.actors_["1036"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_181_0 = 0.2

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_0 and not isNil(arg_178_1.actors_["1036"]) then
				if arg_178_1.var_.actorSpriteComps1036 then
					for iter_181_0, iter_181_1 in pairs(arg_178_1.var_.actorSpriteComps1036:ToTable()) do
						if iter_181_1 then
							if arg_178_1.isInRecall_ then
								iter_181_1.color = Color.New(Mathf.Lerp(iter_181_1.color.r, arg_178_1.hightColor1.r, (arg_178_1.time_ - 0) / var_181_0), Mathf.Lerp(iter_181_1.color.g, arg_178_1.hightColor1.g, (arg_178_1.time_ - 0) / var_181_0), (Mathf.Lerp(iter_181_1.color.b, arg_178_1.hightColor1.b, (arg_178_1.time_ - 0) / var_181_0)))
							else
								local var_181_1 = Mathf.Lerp(iter_181_1.color.r, 1, (arg_178_1.time_ - 0) / var_181_0)

								iter_181_1.color = Color.New(var_181_1, var_181_1, var_181_1)
							end
						end
					end
				end
			end

			if arg_178_1.time_ >= 0 + var_181_0 and arg_178_1.time_ < 0 + var_181_0 + arg_181_0 and not isNil(arg_178_1.actors_["1036"]) and arg_178_1.var_.actorSpriteComps1036 then
				for iter_181_2, iter_181_3 in pairs(arg_178_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_181_3 then
						iter_181_3.color = arg_178_1.isInRecall_ and (arg_178_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_178_1.var_.actorSpriteComps1036 = nil
			end

			local var_181_2 = arg_178_1.actors_["1036"].transform

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1.var_.moveOldPos1036 = var_181_2.localPosition
				var_181_2.localScale = Vector3.New(1, 1, 1)

				arg_178_1:CheckSpriteTmpPos("1036", 3)

				for iter_181_4 = 0, var_181_2.childCount - 1 do
					local var_181_3 = var_181_2:GetChild(iter_181_4)

					if var_181_3.name == "" or not string.find(var_181_3.name, "split") then
						var_181_3.gameObject:SetActive(true)
					else
						var_181_3.gameObject:SetActive(false)
					end
				end
			end

			local var_181_4 = 0.001

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_4 then
				var_181_2.localPosition = Vector3.Lerp(arg_178_1.var_.moveOldPos1036, Vector3.New(0, -388, -250), (arg_178_1.time_ - 0) / var_181_4)
			end

			if arg_178_1.time_ >= 0 + var_181_4 and arg_178_1.time_ < 0 + var_181_4 + arg_181_0 then
				var_181_2.localPosition = Vector3.New(0, -388, -250)
			end

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				if arg_178_1.var_.effect1041 then
					Object.Destroy(arg_178_1.var_.effect1041)

					arg_178_1.var_.effect1041 = nil
				end
			end

			local var_181_6 = 0
			local var_181_7 = 0.6

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= var_181_6 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				arg_178_1.leftNameTxt_.text = arg_178_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_8 = arg_178_1:GetWordFromCfg(425121042)
				local var_181_9 = arg_178_1:FormatText(var_181_8.content)

				arg_178_1.text_.text = var_181_9

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_11 = 24 <= 0 and var_181_7 or var_181_7 * (utf8.len(var_181_9) / 24)

				if (24 <= 0 and var_181_7 or var_181_7 * (utf8.len(var_181_9) / 24)) > 0 and var_181_7 < var_181_11 then
					arg_178_1.talkMaxDuration = var_181_11

					if var_181_11 + var_181_6 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_11 + var_181_6
					end
				end

				arg_178_1.text_.text = var_181_9
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121042", "story_v_out_425121.awb") ~= 0 then
					local var_181_12 = manager.audio:GetVoiceLength("story_v_out_425121", "425121042", "story_v_out_425121.awb") / 1000

					if var_181_12 + var_181_6 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_12 + var_181_6
					end

					if var_181_8.prefab_name ~= "" and arg_178_1.actors_[var_181_8.prefab_name] ~= nil then
						local var_181_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_178_1.actors_[var_181_8.prefab_name].transform, "story_v_out_425121", "425121042", "story_v_out_425121.awb")

						arg_178_1:RecordAudio("425121042", var_181_13)
						arg_178_1:RecordAudio("425121042", var_181_13)
					else
						arg_178_1:AudioAction("play", "voice", "story_v_out_425121", "425121042", "story_v_out_425121.awb")
					end

					arg_178_1:RecordHistoryTalkVoice("story_v_out_425121", "425121042", "story_v_out_425121.awb")
				end

				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_14 = math.max(var_181_7, arg_178_1.talkMaxDuration)

			if var_181_6 <= arg_178_1.time_ and arg_178_1.time_ < var_181_6 + var_181_14 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_6) / var_181_14

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_6 + var_181_14 and arg_178_1.time_ < var_181_6 + var_181_14 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_178_1:InitPlayNodeList()
	end,
	Play425121043 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 425121043
		arg_182_1.duration_ = 5

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play425121044(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 and not isNil(arg_182_1.actors_["1036"]) and arg_182_1.var_.actorSpriteComps1036 == nil then
				arg_182_1.var_.actorSpriteComps1036 = arg_182_1.actors_["1036"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_185_0 = 0.2

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_0 and not isNil(arg_182_1.actors_["1036"]) then
				if arg_182_1.var_.actorSpriteComps1036 then
					for iter_185_0, iter_185_1 in pairs(arg_182_1.var_.actorSpriteComps1036:ToTable()) do
						if iter_185_1 then
							if arg_182_1.isInRecall_ then
								iter_185_1.color = Color.New(Mathf.Lerp(iter_185_1.color.r, arg_182_1.hightColor2.r, (arg_182_1.time_ - 0) / var_185_0), Mathf.Lerp(iter_185_1.color.g, arg_182_1.hightColor2.g, (arg_182_1.time_ - 0) / var_185_0), (Mathf.Lerp(iter_185_1.color.b, arg_182_1.hightColor2.b, (arg_182_1.time_ - 0) / var_185_0)))
							else
								local var_185_1 = Mathf.Lerp(iter_185_1.color.r, 0.5, (arg_182_1.time_ - 0) / var_185_0)

								iter_185_1.color = Color.New(var_185_1, var_185_1, var_185_1)
							end
						end
					end
				end
			end

			if arg_182_1.time_ >= 0 + var_185_0 and arg_182_1.time_ < 0 + var_185_0 + arg_185_0 and not isNil(arg_182_1.actors_["1036"]) and arg_182_1.var_.actorSpriteComps1036 then
				for iter_185_2, iter_185_3 in pairs(arg_182_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_185_3 then
						iter_185_3.color = arg_182_1.isInRecall_ and (arg_182_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_182_1.var_.actorSpriteComps1036 = nil
			end

			local var_185_2 = arg_182_1.actors_["1036"].transform

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1.var_.moveOldPos1036 = var_185_2.localPosition
				var_185_2.localScale = Vector3.New(1, 1, 1)

				arg_182_1:CheckSpriteTmpPos("1036", 7)

				for iter_185_4 = 0, var_185_2.childCount - 1 do
					local var_185_3 = var_185_2:GetChild(iter_185_4)

					if var_185_3.name == "" or not string.find(var_185_3.name, "split") then
						var_185_3.gameObject:SetActive(true)
					else
						var_185_3.gameObject:SetActive(false)
					end
				end
			end

			local var_185_4 = 0.001

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_4 then
				var_185_2.localPosition = Vector3.Lerp(arg_182_1.var_.moveOldPos1036, Vector3.New(0, -2000, 0), (arg_182_1.time_ - 0) / var_185_4)
			end

			if arg_182_1.time_ >= 0 + var_185_4 and arg_182_1.time_ < 0 + var_185_4 + arg_185_0 then
				var_185_2.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.2 < arg_182_1.time_ and arg_182_1.time_ <= 0.2 + arg_185_0 then
				arg_182_1:AudioAction("play", "effect", "se_story_134_01", "se_story_134_01_crowd", "")
			end

			local var_185_6 = 0
			local var_185_7 = 0.95

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= var_185_6 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, false)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_8 = arg_182_1:FormatText(arg_182_1:GetWordFromCfg(425121043).content)

				arg_182_1.text_.text = var_185_8

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_10 = 38 <= 0 and var_185_7 or var_185_7 * (utf8.len(var_185_8) / 38)

				if (38 <= 0 and var_185_7 or var_185_7 * (utf8.len(var_185_8) / 38)) > 0 and var_185_7 < var_185_10 then
					arg_182_1.talkMaxDuration = var_185_10

					if var_185_10 + var_185_6 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_10 + var_185_6
					end
				end

				arg_182_1.text_.text = var_185_8
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)
				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_11 = math.max(var_185_7, arg_182_1.talkMaxDuration)

			if var_185_6 <= arg_182_1.time_ and arg_182_1.time_ < var_185_6 + var_185_11 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_6) / var_185_11

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_6 + var_185_11 and arg_182_1.time_ < var_185_6 + var_185_11 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_182_1:InitPlayNodeList()
	end,
	Play425121044 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 425121044
		arg_186_1.duration_ = 6.9

		local var_186_0 = {
			zh = 5.966,
			ja = 6.9
		}
		local var_186_1 = manager.audio:GetLocalizationFlag()

		if var_186_0[var_186_1] ~= nil then
			arg_186_1.duration_ = var_186_0[var_186_1]
		end

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play425121045(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 and not isNil(arg_186_1.actors_["1036"]) and arg_186_1.var_.actorSpriteComps1036 == nil then
				arg_186_1.var_.actorSpriteComps1036 = arg_186_1.actors_["1036"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_189_0 = 0.2

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_0 and not isNil(arg_186_1.actors_["1036"]) then
				if arg_186_1.var_.actorSpriteComps1036 then
					for iter_189_0, iter_189_1 in pairs(arg_186_1.var_.actorSpriteComps1036:ToTable()) do
						if iter_189_1 then
							if arg_186_1.isInRecall_ then
								iter_189_1.color = Color.New(Mathf.Lerp(iter_189_1.color.r, arg_186_1.hightColor1.r, (arg_186_1.time_ - 0) / var_189_0), Mathf.Lerp(iter_189_1.color.g, arg_186_1.hightColor1.g, (arg_186_1.time_ - 0) / var_189_0), (Mathf.Lerp(iter_189_1.color.b, arg_186_1.hightColor1.b, (arg_186_1.time_ - 0) / var_189_0)))
							else
								local var_189_1 = Mathf.Lerp(iter_189_1.color.r, 1, (arg_186_1.time_ - 0) / var_189_0)

								iter_189_1.color = Color.New(var_189_1, var_189_1, var_189_1)
							end
						end
					end
				end
			end

			if arg_186_1.time_ >= 0 + var_189_0 and arg_186_1.time_ < 0 + var_189_0 + arg_189_0 and not isNil(arg_186_1.actors_["1036"]) and arg_186_1.var_.actorSpriteComps1036 then
				for iter_189_2, iter_189_3 in pairs(arg_186_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_189_3 then
						iter_189_3.color = arg_186_1.isInRecall_ and (arg_186_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_186_1.var_.actorSpriteComps1036 = nil
			end

			local var_189_2 = arg_186_1.actors_["1036"].transform

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1.var_.moveOldPos1036 = var_189_2.localPosition
				var_189_2.localScale = Vector3.New(1, 1, 1)

				arg_186_1:CheckSpriteTmpPos("1036", 3)

				for iter_189_4 = 0, var_189_2.childCount - 1 do
					local var_189_3 = var_189_2:GetChild(iter_189_4)

					if var_189_3.name == "" or not string.find(var_189_3.name, "split") then
						var_189_3.gameObject:SetActive(true)
					else
						var_189_3.gameObject:SetActive(false)
					end
				end
			end

			local var_189_4 = 0.001

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_4 then
				var_189_2.localPosition = Vector3.Lerp(arg_186_1.var_.moveOldPos1036, Vector3.New(0, -388, -250), (arg_186_1.time_ - 0) / var_189_4)
			end

			if arg_186_1.time_ >= 0 + var_189_4 and arg_186_1.time_ < 0 + var_189_4 + arg_189_0 then
				var_189_2.localPosition = Vector3.New(0, -388, -250)
			end

			local var_189_5 = 0
			local var_189_6 = 0.775

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= var_189_5 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				arg_186_1.leftNameTxt_.text = arg_186_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_7 = arg_186_1:GetWordFromCfg(425121044)
				local var_189_8 = arg_186_1:FormatText(var_189_7.content)

				arg_186_1.text_.text = var_189_8

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_10 = 31 <= 0 and var_189_6 or var_189_6 * (utf8.len(var_189_8) / 31)

				if (31 <= 0 and var_189_6 or var_189_6 * (utf8.len(var_189_8) / 31)) > 0 and var_189_6 < var_189_10 then
					arg_186_1.talkMaxDuration = var_189_10

					if var_189_10 + var_189_5 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_10 + var_189_5
					end
				end

				arg_186_1.text_.text = var_189_8
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121044", "story_v_out_425121.awb") ~= 0 then
					local var_189_11 = manager.audio:GetVoiceLength("story_v_out_425121", "425121044", "story_v_out_425121.awb") / 1000

					if var_189_11 + var_189_5 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_11 + var_189_5
					end

					if var_189_7.prefab_name ~= "" and arg_186_1.actors_[var_189_7.prefab_name] ~= nil then
						local var_189_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_186_1.actors_[var_189_7.prefab_name].transform, "story_v_out_425121", "425121044", "story_v_out_425121.awb")

						arg_186_1:RecordAudio("425121044", var_189_12)
						arg_186_1:RecordAudio("425121044", var_189_12)
					else
						arg_186_1:AudioAction("play", "voice", "story_v_out_425121", "425121044", "story_v_out_425121.awb")
					end

					arg_186_1:RecordHistoryTalkVoice("story_v_out_425121", "425121044", "story_v_out_425121.awb")
				end

				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_13 = math.max(var_189_6, arg_186_1.talkMaxDuration)

			if var_189_5 <= arg_186_1.time_ and arg_186_1.time_ < var_189_5 + var_189_13 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_5) / var_189_13

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_5 + var_189_13 and arg_186_1.time_ < var_189_5 + var_189_13 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_186_1:InitPlayNodeList()
	end,
	Play425121045 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 425121045
		arg_190_1.duration_ = 5.93

		local var_190_0 = {
			zh = 5.933,
			ja = 4.7
		}
		local var_190_1 = manager.audio:GetLocalizationFlag()

		if var_190_0[var_190_1] ~= nil then
			arg_190_1.duration_ = var_190_0[var_190_1]
		end

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play425121046(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			local var_193_0 = 0.725

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, true)

				arg_190_1.leftNameTxt_.text = arg_190_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, false)
				arg_190_1.callingController_:SetSelectedState("normal")

				local var_193_1 = arg_190_1:GetWordFromCfg(425121045)
				local var_193_2 = arg_190_1:FormatText(var_193_1.content)

				arg_190_1.text_.text = var_193_2

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_4 = 29 <= 0 and var_193_0 or var_193_0 * (utf8.len(var_193_2) / 29)

				if (29 <= 0 and var_193_0 or var_193_0 * (utf8.len(var_193_2) / 29)) > 0 and var_193_0 < var_193_4 then
					arg_190_1.talkMaxDuration = var_193_4

					if var_193_4 + 0 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_4 + 0
					end
				end

				arg_190_1.text_.text = var_193_2
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121045", "story_v_out_425121.awb") ~= 0 then
					local var_193_5 = manager.audio:GetVoiceLength("story_v_out_425121", "425121045", "story_v_out_425121.awb") / 1000

					if var_193_5 + 0 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_5 + 0
					end

					if var_193_1.prefab_name ~= "" and arg_190_1.actors_[var_193_1.prefab_name] ~= nil then
						local var_193_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_190_1.actors_[var_193_1.prefab_name].transform, "story_v_out_425121", "425121045", "story_v_out_425121.awb")

						arg_190_1:RecordAudio("425121045", var_193_6)
						arg_190_1:RecordAudio("425121045", var_193_6)
					else
						arg_190_1:AudioAction("play", "voice", "story_v_out_425121", "425121045", "story_v_out_425121.awb")
					end

					arg_190_1:RecordHistoryTalkVoice("story_v_out_425121", "425121045", "story_v_out_425121.awb")
				end

				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_7 = math.max(var_193_0, arg_190_1.talkMaxDuration)

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_7 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - 0) / var_193_7

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= 0 + var_193_7 and arg_190_1.time_ < 0 + var_193_7 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {}

		arg_190_1:InitPlayNodeList()
	end,
	Play425121046 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 425121046
		arg_194_1.duration_ = 9.8

		local var_194_0 = {
			zh = 8.266,
			ja = 9.8
		}
		local var_194_1 = manager.audio:GetLocalizationFlag()

		if var_194_0[var_194_1] ~= nil then
			arg_194_1.duration_ = var_194_0[var_194_1]
		end

		SetActive(arg_194_1.tipsGo_, false)

		function arg_194_1.onSingleLineFinish_()
			arg_194_1.onSingleLineUpdate_ = nil
			arg_194_1.onSingleLineFinish_ = nil
			arg_194_1.state_ = "waiting"
		end

		function arg_194_1.playNext_(arg_196_0)
			if arg_196_0 == 1 then
				arg_194_0:Play425121047(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 then
				arg_194_1.var_.moveOldPos1036 = arg_194_1.actors_["1036"].transform.localPosition
				arg_194_1.actors_["1036"].transform.localScale = Vector3.New(1, 1, 1)

				arg_194_1:CheckSpriteTmpPos("1036", 3)

				for iter_197_0 = 0, arg_194_1.actors_["1036"].transform.childCount - 1 do
					local var_197_0 = arg_194_1.actors_["1036"].transform:GetChild(iter_197_0)

					if var_197_0.name == "" or not string.find(var_197_0.name, "split") then
						var_197_0.gameObject:SetActive(true)
					else
						var_197_0.gameObject:SetActive(false)
					end
				end
			end

			local var_197_1 = 0.001

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_1 then
				arg_194_1.actors_["1036"].transform.localPosition = Vector3.Lerp(arg_194_1.var_.moveOldPos1036, Vector3.New(0, -388, -250), (arg_194_1.time_ - 0) / var_197_1)
			end

			if arg_194_1.time_ >= 0 + var_197_1 and arg_194_1.time_ < 0 + var_197_1 + arg_197_0 then
				arg_194_1.actors_["1036"].transform.localPosition = Vector3.New(0, -388, -250)
			end

			local var_197_2 = 0
			local var_197_3 = 1.125

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= var_197_2 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				arg_194_1.leftNameTxt_.text = arg_194_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, false)
				arg_194_1.callingController_:SetSelectedState("normal")

				local var_197_4 = arg_194_1:GetWordFromCfg(425121046)
				local var_197_5 = arg_194_1:FormatText(var_197_4.content)

				arg_194_1.text_.text = var_197_5

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_7 = 45 <= 0 and var_197_3 or var_197_3 * (utf8.len(var_197_5) / 45)

				if (45 <= 0 and var_197_3 or var_197_3 * (utf8.len(var_197_5) / 45)) > 0 and var_197_3 < var_197_7 then
					arg_194_1.talkMaxDuration = var_197_7

					if var_197_7 + var_197_2 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_7 + var_197_2
					end
				end

				arg_194_1.text_.text = var_197_5
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121046", "story_v_out_425121.awb") ~= 0 then
					local var_197_8 = manager.audio:GetVoiceLength("story_v_out_425121", "425121046", "story_v_out_425121.awb") / 1000

					if var_197_8 + var_197_2 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_8 + var_197_2
					end

					if var_197_4.prefab_name ~= "" and arg_194_1.actors_[var_197_4.prefab_name] ~= nil then
						local var_197_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_194_1.actors_[var_197_4.prefab_name].transform, "story_v_out_425121", "425121046", "story_v_out_425121.awb")

						arg_194_1:RecordAudio("425121046", var_197_9)
						arg_194_1:RecordAudio("425121046", var_197_9)
					else
						arg_194_1:AudioAction("play", "voice", "story_v_out_425121", "425121046", "story_v_out_425121.awb")
					end

					arg_194_1:RecordHistoryTalkVoice("story_v_out_425121", "425121046", "story_v_out_425121.awb")
				end

				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_10 = math.max(var_197_3, arg_194_1.talkMaxDuration)

			if var_197_2 <= arg_194_1.time_ and arg_194_1.time_ < var_197_2 + var_197_10 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_2) / var_197_10

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_2 + var_197_10 and arg_194_1.time_ < var_197_2 + var_197_10 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_194_1:InitPlayNodeList()
	end,
	Play425121047 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 425121047
		arg_198_1.duration_ = 5

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play425121048(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 and not isNil(arg_198_1.actors_["1036"]) and arg_198_1.var_.actorSpriteComps1036 == nil then
				arg_198_1.var_.actorSpriteComps1036 = arg_198_1.actors_["1036"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_201_0 = 0.2

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_0 and not isNil(arg_198_1.actors_["1036"]) then
				if arg_198_1.var_.actorSpriteComps1036 then
					for iter_201_0, iter_201_1 in pairs(arg_198_1.var_.actorSpriteComps1036:ToTable()) do
						if iter_201_1 then
							if arg_198_1.isInRecall_ then
								iter_201_1.color = Color.New(Mathf.Lerp(iter_201_1.color.r, arg_198_1.hightColor2.r, (arg_198_1.time_ - 0) / var_201_0), Mathf.Lerp(iter_201_1.color.g, arg_198_1.hightColor2.g, (arg_198_1.time_ - 0) / var_201_0), (Mathf.Lerp(iter_201_1.color.b, arg_198_1.hightColor2.b, (arg_198_1.time_ - 0) / var_201_0)))
							else
								local var_201_1 = Mathf.Lerp(iter_201_1.color.r, 0.5, (arg_198_1.time_ - 0) / var_201_0)

								iter_201_1.color = Color.New(var_201_1, var_201_1, var_201_1)
							end
						end
					end
				end
			end

			if arg_198_1.time_ >= 0 + var_201_0 and arg_198_1.time_ < 0 + var_201_0 + arg_201_0 and not isNil(arg_198_1.actors_["1036"]) and arg_198_1.var_.actorSpriteComps1036 then
				for iter_201_2, iter_201_3 in pairs(arg_198_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_201_3 then
						iter_201_3.color = arg_198_1.isInRecall_ and (arg_198_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_198_1.var_.actorSpriteComps1036 = nil
			end

			local var_201_2 = arg_198_1.actors_["1036"].transform

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1.var_.moveOldPos1036 = var_201_2.localPosition
				var_201_2.localScale = Vector3.New(1, 1, 1)

				arg_198_1:CheckSpriteTmpPos("1036", 7)

				for iter_201_4 = 0, var_201_2.childCount - 1 do
					local var_201_3 = var_201_2:GetChild(iter_201_4)

					if var_201_3.name == "" or not string.find(var_201_3.name, "split") then
						var_201_3.gameObject:SetActive(true)
					else
						var_201_3.gameObject:SetActive(false)
					end
				end
			end

			local var_201_4 = 0.001

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_4 then
				var_201_2.localPosition = Vector3.Lerp(arg_198_1.var_.moveOldPos1036, Vector3.New(0, -2000, 0), (arg_198_1.time_ - 0) / var_201_4)
			end

			if arg_198_1.time_ >= 0 + var_201_4 and arg_198_1.time_ < 0 + var_201_4 + arg_201_0 then
				var_201_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_201_5 = 0
			local var_201_6 = 0.75

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= var_201_5 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, false)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_7 = arg_198_1:FormatText(arg_198_1:GetWordFromCfg(425121047).content)

				arg_198_1.text_.text = var_201_7

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_9 = 30 <= 0 and var_201_6 or var_201_6 * (utf8.len(var_201_7) / 30)

				if (30 <= 0 and var_201_6 or var_201_6 * (utf8.len(var_201_7) / 30)) > 0 and var_201_6 < var_201_9 then
					arg_198_1.talkMaxDuration = var_201_9

					if var_201_9 + var_201_5 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_9 + var_201_5
					end
				end

				arg_198_1.text_.text = var_201_7
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)
				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_10 = math.max(var_201_6, arg_198_1.talkMaxDuration)

			if var_201_5 <= arg_198_1.time_ and arg_198_1.time_ < var_201_5 + var_201_10 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_5) / var_201_10

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_5 + var_201_10 and arg_198_1.time_ < var_201_5 + var_201_10 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_198_1:InitPlayNodeList()
	end,
	Play425121048 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 425121048
		arg_202_1.duration_ = 7.23

		local var_202_0 = {
			zh = 5.366,
			ja = 7.233
		}
		local var_202_1 = manager.audio:GetLocalizationFlag()

		if var_202_0[var_202_1] ~= nil then
			arg_202_1.duration_ = var_202_0[var_202_1]
		end

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play425121049(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 and not isNil(arg_202_1.actors_["1036"]) and arg_202_1.var_.actorSpriteComps1036 == nil then
				arg_202_1.var_.actorSpriteComps1036 = arg_202_1.actors_["1036"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_205_0 = 0.2

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_0 and not isNil(arg_202_1.actors_["1036"]) then
				if arg_202_1.var_.actorSpriteComps1036 then
					for iter_205_0, iter_205_1 in pairs(arg_202_1.var_.actorSpriteComps1036:ToTable()) do
						if iter_205_1 then
							if arg_202_1.isInRecall_ then
								iter_205_1.color = Color.New(Mathf.Lerp(iter_205_1.color.r, arg_202_1.hightColor1.r, (arg_202_1.time_ - 0) / var_205_0), Mathf.Lerp(iter_205_1.color.g, arg_202_1.hightColor1.g, (arg_202_1.time_ - 0) / var_205_0), (Mathf.Lerp(iter_205_1.color.b, arg_202_1.hightColor1.b, (arg_202_1.time_ - 0) / var_205_0)))
							else
								local var_205_1 = Mathf.Lerp(iter_205_1.color.r, 1, (arg_202_1.time_ - 0) / var_205_0)

								iter_205_1.color = Color.New(var_205_1, var_205_1, var_205_1)
							end
						end
					end
				end
			end

			if arg_202_1.time_ >= 0 + var_205_0 and arg_202_1.time_ < 0 + var_205_0 + arg_205_0 and not isNil(arg_202_1.actors_["1036"]) and arg_202_1.var_.actorSpriteComps1036 then
				for iter_205_2, iter_205_3 in pairs(arg_202_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_205_3 then
						iter_205_3.color = arg_202_1.isInRecall_ and (arg_202_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_202_1.var_.actorSpriteComps1036 = nil
			end

			local var_205_2 = arg_202_1.actors_["1036"].transform

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 then
				arg_202_1.var_.moveOldPos1036 = var_205_2.localPosition
				var_205_2.localScale = Vector3.New(1, 1, 1)

				arg_202_1:CheckSpriteTmpPos("1036", 2)

				for iter_205_4 = 0, var_205_2.childCount - 1 do
					local var_205_3 = var_205_2:GetChild(iter_205_4)

					if var_205_3.name == "" or not string.find(var_205_3.name, "split") then
						var_205_3.gameObject:SetActive(true)
					else
						var_205_3.gameObject:SetActive(false)
					end
				end
			end

			local var_205_4 = 0.001

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_4 then
				var_205_2.localPosition = Vector3.Lerp(arg_202_1.var_.moveOldPos1036, Vector3.New(-390, -388, -250), (arg_202_1.time_ - 0) / var_205_4)
			end

			if arg_202_1.time_ >= 0 + var_205_4 and arg_202_1.time_ < 0 + var_205_4 + arg_205_0 then
				var_205_2.localPosition = Vector3.New(-390, -388, -250)
			end

			local var_205_5 = 0
			local var_205_6 = 0.7

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= var_205_5 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, true)

				arg_202_1.leftNameTxt_.text = arg_202_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, false)
				arg_202_1.callingController_:SetSelectedState("normal")

				local var_205_7 = arg_202_1:GetWordFromCfg(425121048)
				local var_205_8 = arg_202_1:FormatText(var_205_7.content)

				arg_202_1.text_.text = var_205_8

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_10 = 28 <= 0 and var_205_6 or var_205_6 * (utf8.len(var_205_8) / 28)

				if (28 <= 0 and var_205_6 or var_205_6 * (utf8.len(var_205_8) / 28)) > 0 and var_205_6 < var_205_10 then
					arg_202_1.talkMaxDuration = var_205_10

					if var_205_10 + var_205_5 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_10 + var_205_5
					end
				end

				arg_202_1.text_.text = var_205_8
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121048", "story_v_out_425121.awb") ~= 0 then
					local var_205_11 = manager.audio:GetVoiceLength("story_v_out_425121", "425121048", "story_v_out_425121.awb") / 1000

					if var_205_11 + var_205_5 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_11 + var_205_5
					end

					if var_205_7.prefab_name ~= "" and arg_202_1.actors_[var_205_7.prefab_name] ~= nil then
						local var_205_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_202_1.actors_[var_205_7.prefab_name].transform, "story_v_out_425121", "425121048", "story_v_out_425121.awb")

						arg_202_1:RecordAudio("425121048", var_205_12)
						arg_202_1:RecordAudio("425121048", var_205_12)
					else
						arg_202_1:AudioAction("play", "voice", "story_v_out_425121", "425121048", "story_v_out_425121.awb")
					end

					arg_202_1:RecordHistoryTalkVoice("story_v_out_425121", "425121048", "story_v_out_425121.awb")
				end

				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_13 = math.max(var_205_6, arg_202_1.talkMaxDuration)

			if var_205_5 <= arg_202_1.time_ and arg_202_1.time_ < var_205_5 + var_205_13 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_5) / var_205_13

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_5 + var_205_13 and arg_202_1.time_ < var_205_5 + var_205_13 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_202_1:InitPlayNodeList()
	end,
	Play425121049 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 425121049
		arg_206_1.duration_ = 2.63

		local var_206_0 = {
			zh = 1.733,
			ja = 2.633
		}
		local var_206_1 = manager.audio:GetLocalizationFlag()

		if var_206_0[var_206_1] ~= nil then
			arg_206_1.duration_ = var_206_0[var_206_1]
		end

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play425121050(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 and not isNil(arg_206_1.actors_["1137"]) and arg_206_1.var_.actorSpriteComps1137 == nil then
				arg_206_1.var_.actorSpriteComps1137 = arg_206_1.actors_["1137"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_209_0 = 0.2

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_0 and not isNil(arg_206_1.actors_["1137"]) then
				if arg_206_1.var_.actorSpriteComps1137 then
					for iter_209_0, iter_209_1 in pairs(arg_206_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_209_1 then
							if arg_206_1.isInRecall_ then
								iter_209_1.color = Color.New(Mathf.Lerp(iter_209_1.color.r, arg_206_1.hightColor1.r, (arg_206_1.time_ - 0) / var_209_0), Mathf.Lerp(iter_209_1.color.g, arg_206_1.hightColor1.g, (arg_206_1.time_ - 0) / var_209_0), (Mathf.Lerp(iter_209_1.color.b, arg_206_1.hightColor1.b, (arg_206_1.time_ - 0) / var_209_0)))
							else
								local var_209_1 = Mathf.Lerp(iter_209_1.color.r, 1, (arg_206_1.time_ - 0) / var_209_0)

								iter_209_1.color = Color.New(var_209_1, var_209_1, var_209_1)
							end
						end
					end
				end
			end

			if arg_206_1.time_ >= 0 + var_209_0 and arg_206_1.time_ < 0 + var_209_0 + arg_209_0 and not isNil(arg_206_1.actors_["1137"]) and arg_206_1.var_.actorSpriteComps1137 then
				for iter_209_2, iter_209_3 in pairs(arg_206_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_209_3 then
						iter_209_3.color = arg_206_1.isInRecall_ and (arg_206_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_206_1.var_.actorSpriteComps1137 = nil
			end

			local var_209_2 = arg_206_1.actors_["1036"]

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 and not isNil(var_209_2) and arg_206_1.var_.actorSpriteComps1036 == nil then
				arg_206_1.var_.actorSpriteComps1036 = var_209_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_209_3 = 0.2

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_3 and not isNil(var_209_2) then
				if arg_206_1.var_.actorSpriteComps1036 then
					for iter_209_4, iter_209_5 in pairs(arg_206_1.var_.actorSpriteComps1036:ToTable()) do
						if iter_209_5 then
							if arg_206_1.isInRecall_ then
								iter_209_5.color = Color.New(Mathf.Lerp(iter_209_5.color.r, arg_206_1.hightColor2.r, (arg_206_1.time_ - 0) / var_209_3), Mathf.Lerp(iter_209_5.color.g, arg_206_1.hightColor2.g, (arg_206_1.time_ - 0) / var_209_3), (Mathf.Lerp(iter_209_5.color.b, arg_206_1.hightColor2.b, (arg_206_1.time_ - 0) / var_209_3)))
							else
								local var_209_4 = Mathf.Lerp(iter_209_5.color.r, 0.5, (arg_206_1.time_ - 0) / var_209_3)

								iter_209_5.color = Color.New(var_209_4, var_209_4, var_209_4)
							end
						end
					end
				end
			end

			if arg_206_1.time_ >= 0 + var_209_3 and arg_206_1.time_ < 0 + var_209_3 + arg_209_0 and not isNil(var_209_2) and arg_206_1.var_.actorSpriteComps1036 then
				for iter_209_6, iter_209_7 in pairs(arg_206_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_209_7 then
						iter_209_7.color = arg_206_1.isInRecall_ and (arg_206_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_206_1.var_.actorSpriteComps1036 = nil
			end

			local var_209_5 = arg_206_1.actors_["1137"].transform

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1.var_.moveOldPos1137 = var_209_5.localPosition
				var_209_5.localScale = Vector3.New(1, 1, 1)

				arg_206_1:CheckSpriteTmpPos("1137", 4)

				for iter_209_8 = 0, var_209_5.childCount - 1 do
					local var_209_6 = var_209_5:GetChild(iter_209_8)

					if var_209_6.name == "split_5" or not string.find(var_209_6.name, "split") then
						var_209_6.gameObject:SetActive(true)
					else
						var_209_6.gameObject:SetActive(false)
					end
				end
			end

			local var_209_7 = 0.001

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_7 then
				var_209_5.localPosition = Vector3.Lerp(arg_206_1.var_.moveOldPos1137, Vector3.New(390, -425, -200), (arg_206_1.time_ - 0) / var_209_7)
			end

			if arg_206_1.time_ >= 0 + var_209_7 and arg_206_1.time_ < 0 + var_209_7 + arg_209_0 then
				var_209_5.localPosition = Vector3.New(390, -425, -200)
			end

			local var_209_8 = 0
			local var_209_9 = 0.15

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= var_209_8 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, true)

				arg_206_1.leftNameTxt_.text = arg_206_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_206_1.leftNameTxt_.transform)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1.leftNameTxt_.text)
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_10 = arg_206_1:GetWordFromCfg(425121049)
				local var_209_11 = arg_206_1:FormatText(var_209_10.content)

				arg_206_1.text_.text = var_209_11

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_13 = 6 <= 0 and var_209_9 or var_209_9 * (utf8.len(var_209_11) / 6)

				if (6 <= 0 and var_209_9 or var_209_9 * (utf8.len(var_209_11) / 6)) > 0 and var_209_9 < var_209_13 then
					arg_206_1.talkMaxDuration = var_209_13

					if var_209_13 + var_209_8 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_13 + var_209_8
					end
				end

				arg_206_1.text_.text = var_209_11
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121049", "story_v_out_425121.awb") ~= 0 then
					local var_209_14 = manager.audio:GetVoiceLength("story_v_out_425121", "425121049", "story_v_out_425121.awb") / 1000

					if var_209_14 + var_209_8 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_14 + var_209_8
					end

					if var_209_10.prefab_name ~= "" and arg_206_1.actors_[var_209_10.prefab_name] ~= nil then
						local var_209_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_206_1.actors_[var_209_10.prefab_name].transform, "story_v_out_425121", "425121049", "story_v_out_425121.awb")

						arg_206_1:RecordAudio("425121049", var_209_15)
						arg_206_1:RecordAudio("425121049", var_209_15)
					else
						arg_206_1:AudioAction("play", "voice", "story_v_out_425121", "425121049", "story_v_out_425121.awb")
					end

					arg_206_1:RecordHistoryTalkVoice("story_v_out_425121", "425121049", "story_v_out_425121.awb")
				end

				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_16 = math.max(var_209_9, arg_206_1.talkMaxDuration)

			if var_209_8 <= arg_206_1.time_ and arg_206_1.time_ < var_209_8 + var_209_16 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_8) / var_209_16

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_8 + var_209_16 and arg_206_1.time_ < var_209_8 + var_209_16 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1137",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_206_1:InitPlayNodeList()
	end,
	Play425121050 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 425121050
		arg_210_1.duration_ = 6.77

		local var_210_0 = {
			zh = 6.366,
			ja = 6.766
		}
		local var_210_1 = manager.audio:GetLocalizationFlag()

		if var_210_0[var_210_1] ~= nil then
			arg_210_1.duration_ = var_210_0[var_210_1]
		end

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play425121051(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 and not isNil(arg_210_1.actors_["1036"]) and arg_210_1.var_.actorSpriteComps1036 == nil then
				arg_210_1.var_.actorSpriteComps1036 = arg_210_1.actors_["1036"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_213_0 = 0.2

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_0 and not isNil(arg_210_1.actors_["1036"]) then
				if arg_210_1.var_.actorSpriteComps1036 then
					for iter_213_0, iter_213_1 in pairs(arg_210_1.var_.actorSpriteComps1036:ToTable()) do
						if iter_213_1 then
							if arg_210_1.isInRecall_ then
								iter_213_1.color = Color.New(Mathf.Lerp(iter_213_1.color.r, arg_210_1.hightColor1.r, (arg_210_1.time_ - 0) / var_213_0), Mathf.Lerp(iter_213_1.color.g, arg_210_1.hightColor1.g, (arg_210_1.time_ - 0) / var_213_0), (Mathf.Lerp(iter_213_1.color.b, arg_210_1.hightColor1.b, (arg_210_1.time_ - 0) / var_213_0)))
							else
								local var_213_1 = Mathf.Lerp(iter_213_1.color.r, 1, (arg_210_1.time_ - 0) / var_213_0)

								iter_213_1.color = Color.New(var_213_1, var_213_1, var_213_1)
							end
						end
					end
				end
			end

			if arg_210_1.time_ >= 0 + var_213_0 and arg_210_1.time_ < 0 + var_213_0 + arg_213_0 and not isNil(arg_210_1.actors_["1036"]) and arg_210_1.var_.actorSpriteComps1036 then
				for iter_213_2, iter_213_3 in pairs(arg_210_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_213_3 then
						iter_213_3.color = arg_210_1.isInRecall_ and (arg_210_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_210_1.var_.actorSpriteComps1036 = nil
			end

			local var_213_2 = arg_210_1.actors_["1137"]

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 and not isNil(var_213_2) and arg_210_1.var_.actorSpriteComps1137 == nil then
				arg_210_1.var_.actorSpriteComps1137 = var_213_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_213_3 = 0.2

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_3 and not isNil(var_213_2) then
				if arg_210_1.var_.actorSpriteComps1137 then
					for iter_213_4, iter_213_5 in pairs(arg_210_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_213_5 then
							if arg_210_1.isInRecall_ then
								iter_213_5.color = Color.New(Mathf.Lerp(iter_213_5.color.r, arg_210_1.hightColor2.r, (arg_210_1.time_ - 0) / var_213_3), Mathf.Lerp(iter_213_5.color.g, arg_210_1.hightColor2.g, (arg_210_1.time_ - 0) / var_213_3), (Mathf.Lerp(iter_213_5.color.b, arg_210_1.hightColor2.b, (arg_210_1.time_ - 0) / var_213_3)))
							else
								local var_213_4 = Mathf.Lerp(iter_213_5.color.r, 0.5, (arg_210_1.time_ - 0) / var_213_3)

								iter_213_5.color = Color.New(var_213_4, var_213_4, var_213_4)
							end
						end
					end
				end
			end

			if arg_210_1.time_ >= 0 + var_213_3 and arg_210_1.time_ < 0 + var_213_3 + arg_213_0 and not isNil(var_213_2) and arg_210_1.var_.actorSpriteComps1137 then
				for iter_213_6, iter_213_7 in pairs(arg_210_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_213_7 then
						iter_213_7.color = arg_210_1.isInRecall_ and (arg_210_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_210_1.var_.actorSpriteComps1137 = nil
			end

			local var_213_5 = arg_210_1.actors_["1036"].transform

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 then
				arg_210_1.var_.moveOldPos1036 = var_213_5.localPosition
				var_213_5.localScale = Vector3.New(1, 1, 1)

				arg_210_1:CheckSpriteTmpPos("1036", 2)

				for iter_213_8 = 0, var_213_5.childCount - 1 do
					local var_213_6 = var_213_5:GetChild(iter_213_8)

					if var_213_6.name == "" or not string.find(var_213_6.name, "split") then
						var_213_6.gameObject:SetActive(true)
					else
						var_213_6.gameObject:SetActive(false)
					end
				end
			end

			local var_213_7 = 0.001

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_7 then
				var_213_5.localPosition = Vector3.Lerp(arg_210_1.var_.moveOldPos1036, Vector3.New(-390, -388, -250), (arg_210_1.time_ - 0) / var_213_7)
			end

			if arg_210_1.time_ >= 0 + var_213_7 and arg_210_1.time_ < 0 + var_213_7 + arg_213_0 then
				var_213_5.localPosition = Vector3.New(-390, -388, -250)
			end

			local var_213_8 = 0
			local var_213_9 = 0.85

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= var_213_8 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, true)

				arg_210_1.leftNameTxt_.text = arg_210_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_210_1.leftNameTxt_.transform)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1.leftNameTxt_.text)
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_10 = arg_210_1:GetWordFromCfg(425121050)
				local var_213_11 = arg_210_1:FormatText(var_213_10.content)

				arg_210_1.text_.text = var_213_11

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_13 = 34 <= 0 and var_213_9 or var_213_9 * (utf8.len(var_213_11) / 34)

				if (34 <= 0 and var_213_9 or var_213_9 * (utf8.len(var_213_11) / 34)) > 0 and var_213_9 < var_213_13 then
					arg_210_1.talkMaxDuration = var_213_13

					if var_213_13 + var_213_8 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_13 + var_213_8
					end
				end

				arg_210_1.text_.text = var_213_11
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121050", "story_v_out_425121.awb") ~= 0 then
					local var_213_14 = manager.audio:GetVoiceLength("story_v_out_425121", "425121050", "story_v_out_425121.awb") / 1000

					if var_213_14 + var_213_8 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_14 + var_213_8
					end

					if var_213_10.prefab_name ~= "" and arg_210_1.actors_[var_213_10.prefab_name] ~= nil then
						local var_213_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_210_1.actors_[var_213_10.prefab_name].transform, "story_v_out_425121", "425121050", "story_v_out_425121.awb")

						arg_210_1:RecordAudio("425121050", var_213_15)
						arg_210_1:RecordAudio("425121050", var_213_15)
					else
						arg_210_1:AudioAction("play", "voice", "story_v_out_425121", "425121050", "story_v_out_425121.awb")
					end

					arg_210_1:RecordHistoryTalkVoice("story_v_out_425121", "425121050", "story_v_out_425121.awb")
				end

				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_16 = math.max(var_213_9, arg_210_1.talkMaxDuration)

			if var_213_8 <= arg_210_1.time_ and arg_210_1.time_ < var_213_8 + var_213_16 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_8) / var_213_16

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_8 + var_213_16 and arg_210_1.time_ < var_213_8 + var_213_16 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_210_1:InitPlayNodeList()
	end,
	Play425121051 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 425121051
		arg_214_1.duration_ = 5.57

		local var_214_0 = {
			zh = 5.566,
			ja = 5.066
		}
		local var_214_1 = manager.audio:GetLocalizationFlag()

		if var_214_0[var_214_1] ~= nil then
			arg_214_1.duration_ = var_214_0[var_214_1]
		end

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play425121052(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 then
				arg_214_1.var_.moveOldPos1036 = arg_214_1.actors_["1036"].transform.localPosition
				arg_214_1.actors_["1036"].transform.localScale = Vector3.New(1, 1, 1)

				arg_214_1:CheckSpriteTmpPos("1036", 2)

				for iter_217_0 = 0, arg_214_1.actors_["1036"].transform.childCount - 1 do
					local var_217_0 = arg_214_1.actors_["1036"].transform:GetChild(iter_217_0)

					if var_217_0.name == "" or not string.find(var_217_0.name, "split") then
						var_217_0.gameObject:SetActive(true)
					else
						var_217_0.gameObject:SetActive(false)
					end
				end
			end

			local var_217_1 = 0.001

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_1 then
				arg_214_1.actors_["1036"].transform.localPosition = Vector3.Lerp(arg_214_1.var_.moveOldPos1036, Vector3.New(-390, -388, -250), (arg_214_1.time_ - 0) / var_217_1)
			end

			if arg_214_1.time_ >= 0 + var_217_1 and arg_214_1.time_ < 0 + var_217_1 + arg_217_0 then
				arg_214_1.actors_["1036"].transform.localPosition = Vector3.New(-390, -388, -250)
			end

			local var_217_2 = 0
			local var_217_3 = 0.55

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= var_217_2 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				arg_214_1.leftNameTxt_.text = arg_214_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, false)
				arg_214_1.callingController_:SetSelectedState("normal")

				local var_217_4 = arg_214_1:GetWordFromCfg(425121051)
				local var_217_5 = arg_214_1:FormatText(var_217_4.content)

				arg_214_1.text_.text = var_217_5

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_7 = 22 <= 0 and var_217_3 or var_217_3 * (utf8.len(var_217_5) / 22)

				if (22 <= 0 and var_217_3 or var_217_3 * (utf8.len(var_217_5) / 22)) > 0 and var_217_3 < var_217_7 then
					arg_214_1.talkMaxDuration = var_217_7

					if var_217_7 + var_217_2 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_7 + var_217_2
					end
				end

				arg_214_1.text_.text = var_217_5
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121051", "story_v_out_425121.awb") ~= 0 then
					local var_217_8 = manager.audio:GetVoiceLength("story_v_out_425121", "425121051", "story_v_out_425121.awb") / 1000

					if var_217_8 + var_217_2 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_8 + var_217_2
					end

					if var_217_4.prefab_name ~= "" and arg_214_1.actors_[var_217_4.prefab_name] ~= nil then
						local var_217_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_214_1.actors_[var_217_4.prefab_name].transform, "story_v_out_425121", "425121051", "story_v_out_425121.awb")

						arg_214_1:RecordAudio("425121051", var_217_9)
						arg_214_1:RecordAudio("425121051", var_217_9)
					else
						arg_214_1:AudioAction("play", "voice", "story_v_out_425121", "425121051", "story_v_out_425121.awb")
					end

					arg_214_1:RecordHistoryTalkVoice("story_v_out_425121", "425121051", "story_v_out_425121.awb")
				end

				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_10 = math.max(var_217_3, arg_214_1.talkMaxDuration)

			if var_217_2 <= arg_214_1.time_ and arg_214_1.time_ < var_217_2 + var_217_10 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_2) / var_217_10

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_2 + var_217_10 and arg_214_1.time_ < var_217_2 + var_217_10 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_214_1:InitPlayNodeList()
	end,
	Play425121052 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 425121052
		arg_218_1.duration_ = 1.9

		local var_218_0 = {
			zh = 1.1,
			ja = 1.9
		}
		local var_218_1 = manager.audio:GetLocalizationFlag()

		if var_218_0[var_218_1] ~= nil then
			arg_218_1.duration_ = var_218_0[var_218_1]
		end

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play425121053(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 and not isNil(arg_218_1.actors_["1137"]) and arg_218_1.var_.actorSpriteComps1137 == nil then
				arg_218_1.var_.actorSpriteComps1137 = arg_218_1.actors_["1137"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_221_0 = 0.2

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_0 and not isNil(arg_218_1.actors_["1137"]) then
				if arg_218_1.var_.actorSpriteComps1137 then
					for iter_221_0, iter_221_1 in pairs(arg_218_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_221_1 then
							if arg_218_1.isInRecall_ then
								iter_221_1.color = Color.New(Mathf.Lerp(iter_221_1.color.r, arg_218_1.hightColor1.r, (arg_218_1.time_ - 0) / var_221_0), Mathf.Lerp(iter_221_1.color.g, arg_218_1.hightColor1.g, (arg_218_1.time_ - 0) / var_221_0), (Mathf.Lerp(iter_221_1.color.b, arg_218_1.hightColor1.b, (arg_218_1.time_ - 0) / var_221_0)))
							else
								local var_221_1 = Mathf.Lerp(iter_221_1.color.r, 1, (arg_218_1.time_ - 0) / var_221_0)

								iter_221_1.color = Color.New(var_221_1, var_221_1, var_221_1)
							end
						end
					end
				end
			end

			if arg_218_1.time_ >= 0 + var_221_0 and arg_218_1.time_ < 0 + var_221_0 + arg_221_0 and not isNil(arg_218_1.actors_["1137"]) and arg_218_1.var_.actorSpriteComps1137 then
				for iter_221_2, iter_221_3 in pairs(arg_218_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_221_3 then
						iter_221_3.color = arg_218_1.isInRecall_ and (arg_218_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_218_1.var_.actorSpriteComps1137 = nil
			end

			local var_221_2 = arg_218_1.actors_["1036"]

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 and not isNil(var_221_2) and arg_218_1.var_.actorSpriteComps1036 == nil then
				arg_218_1.var_.actorSpriteComps1036 = var_221_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_221_3 = 0.2

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_3 and not isNil(var_221_2) then
				if arg_218_1.var_.actorSpriteComps1036 then
					for iter_221_4, iter_221_5 in pairs(arg_218_1.var_.actorSpriteComps1036:ToTable()) do
						if iter_221_5 then
							if arg_218_1.isInRecall_ then
								iter_221_5.color = Color.New(Mathf.Lerp(iter_221_5.color.r, arg_218_1.hightColor2.r, (arg_218_1.time_ - 0) / var_221_3), Mathf.Lerp(iter_221_5.color.g, arg_218_1.hightColor2.g, (arg_218_1.time_ - 0) / var_221_3), (Mathf.Lerp(iter_221_5.color.b, arg_218_1.hightColor2.b, (arg_218_1.time_ - 0) / var_221_3)))
							else
								local var_221_4 = Mathf.Lerp(iter_221_5.color.r, 0.5, (arg_218_1.time_ - 0) / var_221_3)

								iter_221_5.color = Color.New(var_221_4, var_221_4, var_221_4)
							end
						end
					end
				end
			end

			if arg_218_1.time_ >= 0 + var_221_3 and arg_218_1.time_ < 0 + var_221_3 + arg_221_0 and not isNil(var_221_2) and arg_218_1.var_.actorSpriteComps1036 then
				for iter_221_6, iter_221_7 in pairs(arg_218_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_221_7 then
						iter_221_7.color = arg_218_1.isInRecall_ and (arg_218_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_218_1.var_.actorSpriteComps1036 = nil
			end

			local var_221_5 = arg_218_1.actors_["1137"].transform

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1.var_.moveOldPos1137 = var_221_5.localPosition
				var_221_5.localScale = Vector3.New(1, 1, 1)

				arg_218_1:CheckSpriteTmpPos("1137", 4)

				for iter_221_8 = 0, var_221_5.childCount - 1 do
					local var_221_6 = var_221_5:GetChild(iter_221_8)

					if var_221_6.name == "split_1" then
						var_221_6:SetAsLastSibling()
						var_221_6.gameObject:SetActive(true)

						arg_218_1.var_.actorSpriteSplit1137 = var_221_6.gameObject:GetComponent(typeof(Image))

						arg_218_1.var_.actorSpriteSplit1137:SetAlpha(0)
					end
				end
			end

			local var_221_7 = 0.2

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_7 then
				var_221_5.localPosition = Vector3.Lerp(arg_218_1.var_.moveOldPos1137, Vector3.New(390, -425, -200), (arg_218_1.time_ - 0) / var_221_7)

				if arg_218_1.var_.actorSpriteSplit1137 ~= nil then
					arg_218_1.var_.actorSpriteSplit1137:SetAlpha((arg_218_1.time_ - 0) / var_221_7)
				end
			end

			if arg_218_1.time_ >= 0 + var_221_7 and arg_218_1.time_ < 0 + var_221_7 + arg_221_0 then
				var_221_5.localPosition = Vector3.New(390, -425, -200)

				if arg_218_1.var_.actorSpriteSplit1137 ~= nil then
					arg_218_1.var_.actorSpriteSplit1137:SetAlpha(1)
				end
			end

			local var_221_8 = 0
			local var_221_9 = 0.15

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= var_221_8 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				arg_218_1.leftNameTxt_.text = arg_218_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_10 = arg_218_1:GetWordFromCfg(425121052)
				local var_221_11 = arg_218_1:FormatText(var_221_10.content)

				arg_218_1.text_.text = var_221_11

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_13 = 6 <= 0 and var_221_9 or var_221_9 * (utf8.len(var_221_11) / 6)

				if (6 <= 0 and var_221_9 or var_221_9 * (utf8.len(var_221_11) / 6)) > 0 and var_221_9 < var_221_13 then
					arg_218_1.talkMaxDuration = var_221_13

					if var_221_13 + var_221_8 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_13 + var_221_8
					end
				end

				arg_218_1.text_.text = var_221_11
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121052", "story_v_out_425121.awb") ~= 0 then
					local var_221_14 = manager.audio:GetVoiceLength("story_v_out_425121", "425121052", "story_v_out_425121.awb") / 1000

					if var_221_14 + var_221_8 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_14 + var_221_8
					end

					if var_221_10.prefab_name ~= "" and arg_218_1.actors_[var_221_10.prefab_name] ~= nil then
						local var_221_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_218_1.actors_[var_221_10.prefab_name].transform, "story_v_out_425121", "425121052", "story_v_out_425121.awb")

						arg_218_1:RecordAudio("425121052", var_221_15)
						arg_218_1:RecordAudio("425121052", var_221_15)
					else
						arg_218_1:AudioAction("play", "voice", "story_v_out_425121", "425121052", "story_v_out_425121.awb")
					end

					arg_218_1:RecordHistoryTalkVoice("story_v_out_425121", "425121052", "story_v_out_425121.awb")
				end

				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_16 = math.max(var_221_9, arg_218_1.talkMaxDuration)

			if var_221_8 <= arg_218_1.time_ and arg_218_1.time_ < var_221_8 + var_221_16 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_8) / var_221_16

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_8 + var_221_16 and arg_218_1.time_ < var_221_8 + var_221_16 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1137",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.2,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_218_1:InitPlayNodeList()
	end,
	Play425121053 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 425121053
		arg_222_1.duration_ = 6.4

		local var_222_0 = {
			zh = 5.9,
			ja = 6.4
		}
		local var_222_1 = manager.audio:GetLocalizationFlag()

		if var_222_0[var_222_1] ~= nil then
			arg_222_1.duration_ = var_222_0[var_222_1]
		end

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play425121054(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 and not isNil(arg_222_1.actors_["1036"]) and arg_222_1.var_.actorSpriteComps1036 == nil then
				arg_222_1.var_.actorSpriteComps1036 = arg_222_1.actors_["1036"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_225_0 = 0.2

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_0 and not isNil(arg_222_1.actors_["1036"]) then
				if arg_222_1.var_.actorSpriteComps1036 then
					for iter_225_0, iter_225_1 in pairs(arg_222_1.var_.actorSpriteComps1036:ToTable()) do
						if iter_225_1 then
							if arg_222_1.isInRecall_ then
								iter_225_1.color = Color.New(Mathf.Lerp(iter_225_1.color.r, arg_222_1.hightColor1.r, (arg_222_1.time_ - 0) / var_225_0), Mathf.Lerp(iter_225_1.color.g, arg_222_1.hightColor1.g, (arg_222_1.time_ - 0) / var_225_0), (Mathf.Lerp(iter_225_1.color.b, arg_222_1.hightColor1.b, (arg_222_1.time_ - 0) / var_225_0)))
							else
								local var_225_1 = Mathf.Lerp(iter_225_1.color.r, 1, (arg_222_1.time_ - 0) / var_225_0)

								iter_225_1.color = Color.New(var_225_1, var_225_1, var_225_1)
							end
						end
					end
				end
			end

			if arg_222_1.time_ >= 0 + var_225_0 and arg_222_1.time_ < 0 + var_225_0 + arg_225_0 and not isNil(arg_222_1.actors_["1036"]) and arg_222_1.var_.actorSpriteComps1036 then
				for iter_225_2, iter_225_3 in pairs(arg_222_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_225_3 then
						iter_225_3.color = arg_222_1.isInRecall_ and (arg_222_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_222_1.var_.actorSpriteComps1036 = nil
			end

			local var_225_2 = arg_222_1.actors_["1137"]

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 and not isNil(var_225_2) and arg_222_1.var_.actorSpriteComps1137 == nil then
				arg_222_1.var_.actorSpriteComps1137 = var_225_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_225_3 = 0.2

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_3 and not isNil(var_225_2) then
				if arg_222_1.var_.actorSpriteComps1137 then
					for iter_225_4, iter_225_5 in pairs(arg_222_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_225_5 then
							if arg_222_1.isInRecall_ then
								iter_225_5.color = Color.New(Mathf.Lerp(iter_225_5.color.r, arg_222_1.hightColor2.r, (arg_222_1.time_ - 0) / var_225_3), Mathf.Lerp(iter_225_5.color.g, arg_222_1.hightColor2.g, (arg_222_1.time_ - 0) / var_225_3), (Mathf.Lerp(iter_225_5.color.b, arg_222_1.hightColor2.b, (arg_222_1.time_ - 0) / var_225_3)))
							else
								local var_225_4 = Mathf.Lerp(iter_225_5.color.r, 0.5, (arg_222_1.time_ - 0) / var_225_3)

								iter_225_5.color = Color.New(var_225_4, var_225_4, var_225_4)
							end
						end
					end
				end
			end

			if arg_222_1.time_ >= 0 + var_225_3 and arg_222_1.time_ < 0 + var_225_3 + arg_225_0 and not isNil(var_225_2) and arg_222_1.var_.actorSpriteComps1137 then
				for iter_225_6, iter_225_7 in pairs(arg_222_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_225_7 then
						iter_225_7.color = arg_222_1.isInRecall_ and (arg_222_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_222_1.var_.actorSpriteComps1137 = nil
			end

			local var_225_5 = arg_222_1.actors_["1036"].transform

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1.var_.moveOldPos1036 = var_225_5.localPosition
				var_225_5.localScale = Vector3.New(1, 1, 1)

				arg_222_1:CheckSpriteTmpPos("1036", 2)

				for iter_225_8 = 0, var_225_5.childCount - 1 do
					local var_225_6 = var_225_5:GetChild(iter_225_8)

					if var_225_6.name == "" or not string.find(var_225_6.name, "split") then
						var_225_6.gameObject:SetActive(true)
					else
						var_225_6.gameObject:SetActive(false)
					end
				end
			end

			local var_225_7 = 0.001

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_7 then
				var_225_5.localPosition = Vector3.Lerp(arg_222_1.var_.moveOldPos1036, Vector3.New(-390, -388, -250), (arg_222_1.time_ - 0) / var_225_7)
			end

			if arg_222_1.time_ >= 0 + var_225_7 and arg_222_1.time_ < 0 + var_225_7 + arg_225_0 then
				var_225_5.localPosition = Vector3.New(-390, -388, -250)
			end

			local var_225_8 = 0
			local var_225_9 = 0.9

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= var_225_8 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				arg_222_1.leftNameTxt_.text = arg_222_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_10 = arg_222_1:GetWordFromCfg(425121053)
				local var_225_11 = arg_222_1:FormatText(var_225_10.content)

				arg_222_1.text_.text = var_225_11

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_13 = 36 <= 0 and var_225_9 or var_225_9 * (utf8.len(var_225_11) / 36)

				if (36 <= 0 and var_225_9 or var_225_9 * (utf8.len(var_225_11) / 36)) > 0 and var_225_9 < var_225_13 then
					arg_222_1.talkMaxDuration = var_225_13

					if var_225_13 + var_225_8 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_13 + var_225_8
					end
				end

				arg_222_1.text_.text = var_225_11
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121053", "story_v_out_425121.awb") ~= 0 then
					local var_225_14 = manager.audio:GetVoiceLength("story_v_out_425121", "425121053", "story_v_out_425121.awb") / 1000

					if var_225_14 + var_225_8 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_14 + var_225_8
					end

					if var_225_10.prefab_name ~= "" and arg_222_1.actors_[var_225_10.prefab_name] ~= nil then
						local var_225_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_222_1.actors_[var_225_10.prefab_name].transform, "story_v_out_425121", "425121053", "story_v_out_425121.awb")

						arg_222_1:RecordAudio("425121053", var_225_15)
						arg_222_1:RecordAudio("425121053", var_225_15)
					else
						arg_222_1:AudioAction("play", "voice", "story_v_out_425121", "425121053", "story_v_out_425121.awb")
					end

					arg_222_1:RecordHistoryTalkVoice("story_v_out_425121", "425121053", "story_v_out_425121.awb")
				end

				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_16 = math.max(var_225_9, arg_222_1.talkMaxDuration)

			if var_225_8 <= arg_222_1.time_ and arg_222_1.time_ < var_225_8 + var_225_16 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_8) / var_225_16

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_8 + var_225_16 and arg_222_1.time_ < var_225_8 + var_225_16 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_222_1:InitPlayNodeList()
	end,
	Play425121054 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 425121054
		arg_226_1.duration_ = 1.17

		local var_226_0 = {
			zh = 1,
			ja = 1.166
		}
		local var_226_1 = manager.audio:GetLocalizationFlag()

		if var_226_0[var_226_1] ~= nil then
			arg_226_1.duration_ = var_226_0[var_226_1]
		end

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play425121055(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 and not isNil(arg_226_1.actors_["1137"]) and arg_226_1.var_.actorSpriteComps1137 == nil then
				arg_226_1.var_.actorSpriteComps1137 = arg_226_1.actors_["1137"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_229_0 = 0.2

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_0 and not isNil(arg_226_1.actors_["1137"]) then
				if arg_226_1.var_.actorSpriteComps1137 then
					for iter_229_0, iter_229_1 in pairs(arg_226_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_229_1 then
							if arg_226_1.isInRecall_ then
								iter_229_1.color = Color.New(Mathf.Lerp(iter_229_1.color.r, arg_226_1.hightColor1.r, (arg_226_1.time_ - 0) / var_229_0), Mathf.Lerp(iter_229_1.color.g, arg_226_1.hightColor1.g, (arg_226_1.time_ - 0) / var_229_0), (Mathf.Lerp(iter_229_1.color.b, arg_226_1.hightColor1.b, (arg_226_1.time_ - 0) / var_229_0)))
							else
								local var_229_1 = Mathf.Lerp(iter_229_1.color.r, 1, (arg_226_1.time_ - 0) / var_229_0)

								iter_229_1.color = Color.New(var_229_1, var_229_1, var_229_1)
							end
						end
					end
				end
			end

			if arg_226_1.time_ >= 0 + var_229_0 and arg_226_1.time_ < 0 + var_229_0 + arg_229_0 and not isNil(arg_226_1.actors_["1137"]) and arg_226_1.var_.actorSpriteComps1137 then
				for iter_229_2, iter_229_3 in pairs(arg_226_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_229_3 then
						iter_229_3.color = arg_226_1.isInRecall_ and (arg_226_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_226_1.var_.actorSpriteComps1137 = nil
			end

			local var_229_2 = arg_226_1.actors_["1036"]

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 and not isNil(var_229_2) and arg_226_1.var_.actorSpriteComps1036 == nil then
				arg_226_1.var_.actorSpriteComps1036 = var_229_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_229_3 = 0.2

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_3 and not isNil(var_229_2) then
				if arg_226_1.var_.actorSpriteComps1036 then
					for iter_229_4, iter_229_5 in pairs(arg_226_1.var_.actorSpriteComps1036:ToTable()) do
						if iter_229_5 then
							if arg_226_1.isInRecall_ then
								iter_229_5.color = Color.New(Mathf.Lerp(iter_229_5.color.r, arg_226_1.hightColor2.r, (arg_226_1.time_ - 0) / var_229_3), Mathf.Lerp(iter_229_5.color.g, arg_226_1.hightColor2.g, (arg_226_1.time_ - 0) / var_229_3), (Mathf.Lerp(iter_229_5.color.b, arg_226_1.hightColor2.b, (arg_226_1.time_ - 0) / var_229_3)))
							else
								local var_229_4 = Mathf.Lerp(iter_229_5.color.r, 0.5, (arg_226_1.time_ - 0) / var_229_3)

								iter_229_5.color = Color.New(var_229_4, var_229_4, var_229_4)
							end
						end
					end
				end
			end

			if arg_226_1.time_ >= 0 + var_229_3 and arg_226_1.time_ < 0 + var_229_3 + arg_229_0 and not isNil(var_229_2) and arg_226_1.var_.actorSpriteComps1036 then
				for iter_229_6, iter_229_7 in pairs(arg_226_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_229_7 then
						iter_229_7.color = arg_226_1.isInRecall_ and (arg_226_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_226_1.var_.actorSpriteComps1036 = nil
			end

			local var_229_5 = arg_226_1.actors_["1137"].transform

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 then
				arg_226_1.var_.moveOldPos1137 = var_229_5.localPosition
				var_229_5.localScale = Vector3.New(1, 1, 1)

				arg_226_1:CheckSpriteTmpPos("1137", 4)

				for iter_229_8 = 0, var_229_5.childCount - 1 do
					local var_229_6 = var_229_5:GetChild(iter_229_8)

					if var_229_6.name == "split_5" then
						var_229_6:SetAsLastSibling()
						var_229_6.gameObject:SetActive(true)

						arg_226_1.var_.actorSpriteSplit1137 = var_229_6.gameObject:GetComponent(typeof(Image))

						arg_226_1.var_.actorSpriteSplit1137:SetAlpha(0)
					end
				end
			end

			local var_229_7 = 0.2

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_7 then
				var_229_5.localPosition = Vector3.Lerp(arg_226_1.var_.moveOldPos1137, Vector3.New(390, -425, -200), (arg_226_1.time_ - 0) / var_229_7)

				if arg_226_1.var_.actorSpriteSplit1137 ~= nil then
					arg_226_1.var_.actorSpriteSplit1137:SetAlpha((arg_226_1.time_ - 0) / var_229_7)
				end
			end

			if arg_226_1.time_ >= 0 + var_229_7 and arg_226_1.time_ < 0 + var_229_7 + arg_229_0 then
				var_229_5.localPosition = Vector3.New(390, -425, -200)

				if arg_226_1.var_.actorSpriteSplit1137 ~= nil then
					arg_226_1.var_.actorSpriteSplit1137:SetAlpha(1)
				end
			end

			local var_229_8 = 0
			local var_229_9 = 0.1

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= var_229_8 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				arg_226_1.leftNameTxt_.text = arg_226_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, false)
				arg_226_1.callingController_:SetSelectedState("normal")

				local var_229_10 = arg_226_1:GetWordFromCfg(425121054)
				local var_229_11 = arg_226_1:FormatText(var_229_10.content)

				arg_226_1.text_.text = var_229_11

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_13 = 4 <= 0 and var_229_9 or var_229_9 * (utf8.len(var_229_11) / 4)

				if (4 <= 0 and var_229_9 or var_229_9 * (utf8.len(var_229_11) / 4)) > 0 and var_229_9 < var_229_13 then
					arg_226_1.talkMaxDuration = var_229_13

					if var_229_13 + var_229_8 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_13 + var_229_8
					end
				end

				arg_226_1.text_.text = var_229_11
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121054", "story_v_out_425121.awb") ~= 0 then
					local var_229_14 = manager.audio:GetVoiceLength("story_v_out_425121", "425121054", "story_v_out_425121.awb") / 1000

					if var_229_14 + var_229_8 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_14 + var_229_8
					end

					if var_229_10.prefab_name ~= "" and arg_226_1.actors_[var_229_10.prefab_name] ~= nil then
						local var_229_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_226_1.actors_[var_229_10.prefab_name].transform, "story_v_out_425121", "425121054", "story_v_out_425121.awb")

						arg_226_1:RecordAudio("425121054", var_229_15)
						arg_226_1:RecordAudio("425121054", var_229_15)
					else
						arg_226_1:AudioAction("play", "voice", "story_v_out_425121", "425121054", "story_v_out_425121.awb")
					end

					arg_226_1:RecordHistoryTalkVoice("story_v_out_425121", "425121054", "story_v_out_425121.awb")
				end

				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_16 = math.max(var_229_9, arg_226_1.talkMaxDuration)

			if var_229_8 <= arg_226_1.time_ and arg_226_1.time_ < var_229_8 + var_229_16 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_8) / var_229_16

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_8 + var_229_16 and arg_226_1.time_ < var_229_8 + var_229_16 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1137",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.2,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1137",
				frequency = 6,
				className = "StoryShakeNode",
				duration = 0.35,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.ACTOR_SPRITE,
				offset = Vector3.New(5, 0, 0)
			}
		}

		arg_226_1:InitPlayNodeList()
	end,
	Play425121055 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 425121055
		arg_230_1.duration_ = 12

		local var_230_0 = {
			zh = 7.266,
			ja = 12
		}
		local var_230_1 = manager.audio:GetLocalizationFlag()

		if var_230_0[var_230_1] ~= nil then
			arg_230_1.duration_ = var_230_0[var_230_1]
		end

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play425121056(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 and not isNil(arg_230_1.actors_["1036"]) and arg_230_1.var_.actorSpriteComps1036 == nil then
				arg_230_1.var_.actorSpriteComps1036 = arg_230_1.actors_["1036"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_233_0 = 0.2

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_0 and not isNil(arg_230_1.actors_["1036"]) then
				if arg_230_1.var_.actorSpriteComps1036 then
					for iter_233_0, iter_233_1 in pairs(arg_230_1.var_.actorSpriteComps1036:ToTable()) do
						if iter_233_1 then
							if arg_230_1.isInRecall_ then
								iter_233_1.color = Color.New(Mathf.Lerp(iter_233_1.color.r, arg_230_1.hightColor1.r, (arg_230_1.time_ - 0) / var_233_0), Mathf.Lerp(iter_233_1.color.g, arg_230_1.hightColor1.g, (arg_230_1.time_ - 0) / var_233_0), (Mathf.Lerp(iter_233_1.color.b, arg_230_1.hightColor1.b, (arg_230_1.time_ - 0) / var_233_0)))
							else
								local var_233_1 = Mathf.Lerp(iter_233_1.color.r, 1, (arg_230_1.time_ - 0) / var_233_0)

								iter_233_1.color = Color.New(var_233_1, var_233_1, var_233_1)
							end
						end
					end
				end
			end

			if arg_230_1.time_ >= 0 + var_233_0 and arg_230_1.time_ < 0 + var_233_0 + arg_233_0 and not isNil(arg_230_1.actors_["1036"]) and arg_230_1.var_.actorSpriteComps1036 then
				for iter_233_2, iter_233_3 in pairs(arg_230_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_233_3 then
						iter_233_3.color = arg_230_1.isInRecall_ and (arg_230_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_230_1.var_.actorSpriteComps1036 = nil
			end

			local var_233_2 = arg_230_1.actors_["1137"]

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 and not isNil(var_233_2) and arg_230_1.var_.actorSpriteComps1137 == nil then
				arg_230_1.var_.actorSpriteComps1137 = var_233_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_233_3 = 0.2

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_3 and not isNil(var_233_2) then
				if arg_230_1.var_.actorSpriteComps1137 then
					for iter_233_4, iter_233_5 in pairs(arg_230_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_233_5 then
							if arg_230_1.isInRecall_ then
								iter_233_5.color = Color.New(Mathf.Lerp(iter_233_5.color.r, arg_230_1.hightColor2.r, (arg_230_1.time_ - 0) / var_233_3), Mathf.Lerp(iter_233_5.color.g, arg_230_1.hightColor2.g, (arg_230_1.time_ - 0) / var_233_3), (Mathf.Lerp(iter_233_5.color.b, arg_230_1.hightColor2.b, (arg_230_1.time_ - 0) / var_233_3)))
							else
								local var_233_4 = Mathf.Lerp(iter_233_5.color.r, 0.5, (arg_230_1.time_ - 0) / var_233_3)

								iter_233_5.color = Color.New(var_233_4, var_233_4, var_233_4)
							end
						end
					end
				end
			end

			if arg_230_1.time_ >= 0 + var_233_3 and arg_230_1.time_ < 0 + var_233_3 + arg_233_0 and not isNil(var_233_2) and arg_230_1.var_.actorSpriteComps1137 then
				for iter_233_6, iter_233_7 in pairs(arg_230_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_233_7 then
						iter_233_7.color = arg_230_1.isInRecall_ and (arg_230_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_230_1.var_.actorSpriteComps1137 = nil
			end

			local var_233_5 = arg_230_1.actors_["1036"].transform

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 then
				arg_230_1.var_.moveOldPos1036 = var_233_5.localPosition
				var_233_5.localScale = Vector3.New(1, 1, 1)

				arg_230_1:CheckSpriteTmpPos("1036", 2)

				for iter_233_8 = 0, var_233_5.childCount - 1 do
					local var_233_6 = var_233_5:GetChild(iter_233_8)

					if var_233_6.name == "" or not string.find(var_233_6.name, "split") then
						var_233_6.gameObject:SetActive(true)
					else
						var_233_6.gameObject:SetActive(false)
					end
				end
			end

			local var_233_7 = 0.001

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_7 then
				var_233_5.localPosition = Vector3.Lerp(arg_230_1.var_.moveOldPos1036, Vector3.New(-390, -388, -250), (arg_230_1.time_ - 0) / var_233_7)
			end

			if arg_230_1.time_ >= 0 + var_233_7 and arg_230_1.time_ < 0 + var_233_7 + arg_233_0 then
				var_233_5.localPosition = Vector3.New(-390, -388, -250)
			end

			local var_233_8 = 0
			local var_233_9 = 0.925

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= var_233_8 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				arg_230_1.leftNameTxt_.text = arg_230_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_10 = arg_230_1:GetWordFromCfg(425121055)
				local var_233_11 = arg_230_1:FormatText(var_233_10.content)

				arg_230_1.text_.text = var_233_11

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_13 = 37 <= 0 and var_233_9 or var_233_9 * (utf8.len(var_233_11) / 37)

				if (37 <= 0 and var_233_9 or var_233_9 * (utf8.len(var_233_11) / 37)) > 0 and var_233_9 < var_233_13 then
					arg_230_1.talkMaxDuration = var_233_13

					if var_233_13 + var_233_8 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_13 + var_233_8
					end
				end

				arg_230_1.text_.text = var_233_11
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121055", "story_v_out_425121.awb") ~= 0 then
					local var_233_14 = manager.audio:GetVoiceLength("story_v_out_425121", "425121055", "story_v_out_425121.awb") / 1000

					if var_233_14 + var_233_8 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_14 + var_233_8
					end

					if var_233_10.prefab_name ~= "" and arg_230_1.actors_[var_233_10.prefab_name] ~= nil then
						local var_233_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_230_1.actors_[var_233_10.prefab_name].transform, "story_v_out_425121", "425121055", "story_v_out_425121.awb")

						arg_230_1:RecordAudio("425121055", var_233_15)
						arg_230_1:RecordAudio("425121055", var_233_15)
					else
						arg_230_1:AudioAction("play", "voice", "story_v_out_425121", "425121055", "story_v_out_425121.awb")
					end

					arg_230_1:RecordHistoryTalkVoice("story_v_out_425121", "425121055", "story_v_out_425121.awb")
				end

				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_16 = math.max(var_233_9, arg_230_1.talkMaxDuration)

			if var_233_8 <= arg_230_1.time_ and arg_230_1.time_ < var_233_8 + var_233_16 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_8) / var_233_16

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_8 + var_233_16 and arg_230_1.time_ < var_233_8 + var_233_16 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_230_1:InitPlayNodeList()
	end,
	Play425121056 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 425121056
		arg_234_1.duration_ = 7

		local var_234_0 = {
			zh = 4.7,
			ja = 7
		}
		local var_234_1 = manager.audio:GetLocalizationFlag()

		if var_234_0[var_234_1] ~= nil then
			arg_234_1.duration_ = var_234_0[var_234_1]
		end

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play425121057(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 and not isNil(arg_234_1.actors_["1137"]) and arg_234_1.var_.actorSpriteComps1137 == nil then
				arg_234_1.var_.actorSpriteComps1137 = arg_234_1.actors_["1137"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_237_0 = 0.2

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_0 and not isNil(arg_234_1.actors_["1137"]) then
				if arg_234_1.var_.actorSpriteComps1137 then
					for iter_237_0, iter_237_1 in pairs(arg_234_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_237_1 then
							if arg_234_1.isInRecall_ then
								iter_237_1.color = Color.New(Mathf.Lerp(iter_237_1.color.r, arg_234_1.hightColor1.r, (arg_234_1.time_ - 0) / var_237_0), Mathf.Lerp(iter_237_1.color.g, arg_234_1.hightColor1.g, (arg_234_1.time_ - 0) / var_237_0), (Mathf.Lerp(iter_237_1.color.b, arg_234_1.hightColor1.b, (arg_234_1.time_ - 0) / var_237_0)))
							else
								local var_237_1 = Mathf.Lerp(iter_237_1.color.r, 1, (arg_234_1.time_ - 0) / var_237_0)

								iter_237_1.color = Color.New(var_237_1, var_237_1, var_237_1)
							end
						end
					end
				end
			end

			if arg_234_1.time_ >= 0 + var_237_0 and arg_234_1.time_ < 0 + var_237_0 + arg_237_0 and not isNil(arg_234_1.actors_["1137"]) and arg_234_1.var_.actorSpriteComps1137 then
				for iter_237_2, iter_237_3 in pairs(arg_234_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_237_3 then
						iter_237_3.color = arg_234_1.isInRecall_ and (arg_234_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_234_1.var_.actorSpriteComps1137 = nil
			end

			local var_237_2 = arg_234_1.actors_["1036"]

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 and not isNil(var_237_2) and arg_234_1.var_.actorSpriteComps1036 == nil then
				arg_234_1.var_.actorSpriteComps1036 = var_237_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_237_3 = 0.2

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_3 and not isNil(var_237_2) then
				if arg_234_1.var_.actorSpriteComps1036 then
					for iter_237_4, iter_237_5 in pairs(arg_234_1.var_.actorSpriteComps1036:ToTable()) do
						if iter_237_5 then
							if arg_234_1.isInRecall_ then
								iter_237_5.color = Color.New(Mathf.Lerp(iter_237_5.color.r, arg_234_1.hightColor2.r, (arg_234_1.time_ - 0) / var_237_3), Mathf.Lerp(iter_237_5.color.g, arg_234_1.hightColor2.g, (arg_234_1.time_ - 0) / var_237_3), (Mathf.Lerp(iter_237_5.color.b, arg_234_1.hightColor2.b, (arg_234_1.time_ - 0) / var_237_3)))
							else
								local var_237_4 = Mathf.Lerp(iter_237_5.color.r, 0.5, (arg_234_1.time_ - 0) / var_237_3)

								iter_237_5.color = Color.New(var_237_4, var_237_4, var_237_4)
							end
						end
					end
				end
			end

			if arg_234_1.time_ >= 0 + var_237_3 and arg_234_1.time_ < 0 + var_237_3 + arg_237_0 and not isNil(var_237_2) and arg_234_1.var_.actorSpriteComps1036 then
				for iter_237_6, iter_237_7 in pairs(arg_234_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_237_7 then
						iter_237_7.color = arg_234_1.isInRecall_ and (arg_234_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_234_1.var_.actorSpriteComps1036 = nil
			end

			local var_237_5 = arg_234_1.actors_["1137"].transform

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1.var_.moveOldPos1137 = var_237_5.localPosition
				var_237_5.localScale = Vector3.New(1, 1, 1)

				arg_234_1:CheckSpriteTmpPos("1137", 4)

				for iter_237_8 = 0, var_237_5.childCount - 1 do
					local var_237_6 = var_237_5:GetChild(iter_237_8)

					if var_237_6.name == "split_6" then
						var_237_6:SetAsLastSibling()
						var_237_6.gameObject:SetActive(true)

						arg_234_1.var_.actorSpriteSplit1137 = var_237_6.gameObject:GetComponent(typeof(Image))

						arg_234_1.var_.actorSpriteSplit1137:SetAlpha(0)
					end
				end
			end

			local var_237_7 = 0.5

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_7 then
				var_237_5.localPosition = Vector3.Lerp(arg_234_1.var_.moveOldPos1137, Vector3.New(390, -425, -200), (arg_234_1.time_ - 0) / var_237_7)

				if arg_234_1.var_.actorSpriteSplit1137 ~= nil then
					arg_234_1.var_.actorSpriteSplit1137:SetAlpha((arg_234_1.time_ - 0) / var_237_7)
				end
			end

			if arg_234_1.time_ >= 0 + var_237_7 and arg_234_1.time_ < 0 + var_237_7 + arg_237_0 then
				var_237_5.localPosition = Vector3.New(390, -425, -200)

				if arg_234_1.var_.actorSpriteSplit1137 ~= nil then
					arg_234_1.var_.actorSpriteSplit1137:SetAlpha(1)
				end
			end

			local var_237_8 = 0
			local var_237_9 = 0.575

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= var_237_8 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, true)

				arg_234_1.leftNameTxt_.text = arg_234_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_10 = arg_234_1:GetWordFromCfg(425121056)
				local var_237_11 = arg_234_1:FormatText(var_237_10.content)

				arg_234_1.text_.text = var_237_11

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_13 = 23 <= 0 and var_237_9 or var_237_9 * (utf8.len(var_237_11) / 23)

				if (23 <= 0 and var_237_9 or var_237_9 * (utf8.len(var_237_11) / 23)) > 0 and var_237_9 < var_237_13 then
					arg_234_1.talkMaxDuration = var_237_13

					if var_237_13 + var_237_8 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_13 + var_237_8
					end
				end

				arg_234_1.text_.text = var_237_11
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121056", "story_v_out_425121.awb") ~= 0 then
					local var_237_14 = manager.audio:GetVoiceLength("story_v_out_425121", "425121056", "story_v_out_425121.awb") / 1000

					if var_237_14 + var_237_8 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_14 + var_237_8
					end

					if var_237_10.prefab_name ~= "" and arg_234_1.actors_[var_237_10.prefab_name] ~= nil then
						local var_237_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_234_1.actors_[var_237_10.prefab_name].transform, "story_v_out_425121", "425121056", "story_v_out_425121.awb")

						arg_234_1:RecordAudio("425121056", var_237_15)
						arg_234_1:RecordAudio("425121056", var_237_15)
					else
						arg_234_1:AudioAction("play", "voice", "story_v_out_425121", "425121056", "story_v_out_425121.awb")
					end

					arg_234_1:RecordHistoryTalkVoice("story_v_out_425121", "425121056", "story_v_out_425121.awb")
				end

				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_16 = math.max(var_237_9, arg_234_1.talkMaxDuration)

			if var_237_8 <= arg_234_1.time_ and arg_234_1.time_ < var_237_8 + var_237_16 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_8) / var_237_16

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_8 + var_237_16 and arg_234_1.time_ < var_237_8 + var_237_16 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1137",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_234_1:InitPlayNodeList()
	end,
	Play425121057 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 425121057
		arg_238_1.duration_ = 8.83

		local var_238_0 = {
			zh = 5.866,
			ja = 8.833
		}
		local var_238_1 = manager.audio:GetLocalizationFlag()

		if var_238_0[var_238_1] ~= nil then
			arg_238_1.duration_ = var_238_0[var_238_1]
		end

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play425121058(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 and not isNil(arg_238_1.actors_["1036"]) and arg_238_1.var_.actorSpriteComps1036 == nil then
				arg_238_1.var_.actorSpriteComps1036 = arg_238_1.actors_["1036"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_241_0 = 0.2

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_0 and not isNil(arg_238_1.actors_["1036"]) then
				if arg_238_1.var_.actorSpriteComps1036 then
					for iter_241_0, iter_241_1 in pairs(arg_238_1.var_.actorSpriteComps1036:ToTable()) do
						if iter_241_1 then
							if arg_238_1.isInRecall_ then
								iter_241_1.color = Color.New(Mathf.Lerp(iter_241_1.color.r, arg_238_1.hightColor1.r, (arg_238_1.time_ - 0) / var_241_0), Mathf.Lerp(iter_241_1.color.g, arg_238_1.hightColor1.g, (arg_238_1.time_ - 0) / var_241_0), (Mathf.Lerp(iter_241_1.color.b, arg_238_1.hightColor1.b, (arg_238_1.time_ - 0) / var_241_0)))
							else
								local var_241_1 = Mathf.Lerp(iter_241_1.color.r, 1, (arg_238_1.time_ - 0) / var_241_0)

								iter_241_1.color = Color.New(var_241_1, var_241_1, var_241_1)
							end
						end
					end
				end
			end

			if arg_238_1.time_ >= 0 + var_241_0 and arg_238_1.time_ < 0 + var_241_0 + arg_241_0 and not isNil(arg_238_1.actors_["1036"]) and arg_238_1.var_.actorSpriteComps1036 then
				for iter_241_2, iter_241_3 in pairs(arg_238_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_241_3 then
						iter_241_3.color = arg_238_1.isInRecall_ and (arg_238_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_238_1.var_.actorSpriteComps1036 = nil
			end

			local var_241_2 = arg_238_1.actors_["1137"]

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 and not isNil(var_241_2) and arg_238_1.var_.actorSpriteComps1137 == nil then
				arg_238_1.var_.actorSpriteComps1137 = var_241_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_241_3 = 0.2

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_3 and not isNil(var_241_2) then
				if arg_238_1.var_.actorSpriteComps1137 then
					for iter_241_4, iter_241_5 in pairs(arg_238_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_241_5 then
							if arg_238_1.isInRecall_ then
								iter_241_5.color = Color.New(Mathf.Lerp(iter_241_5.color.r, arg_238_1.hightColor2.r, (arg_238_1.time_ - 0) / var_241_3), Mathf.Lerp(iter_241_5.color.g, arg_238_1.hightColor2.g, (arg_238_1.time_ - 0) / var_241_3), (Mathf.Lerp(iter_241_5.color.b, arg_238_1.hightColor2.b, (arg_238_1.time_ - 0) / var_241_3)))
							else
								local var_241_4 = Mathf.Lerp(iter_241_5.color.r, 0.5, (arg_238_1.time_ - 0) / var_241_3)

								iter_241_5.color = Color.New(var_241_4, var_241_4, var_241_4)
							end
						end
					end
				end
			end

			if arg_238_1.time_ >= 0 + var_241_3 and arg_238_1.time_ < 0 + var_241_3 + arg_241_0 and not isNil(var_241_2) and arg_238_1.var_.actorSpriteComps1137 then
				for iter_241_6, iter_241_7 in pairs(arg_238_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_241_7 then
						iter_241_7.color = arg_238_1.isInRecall_ and (arg_238_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_238_1.var_.actorSpriteComps1137 = nil
			end

			local var_241_5 = arg_238_1.actors_["1036"].transform

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 then
				arg_238_1.var_.moveOldPos1036 = var_241_5.localPosition
				var_241_5.localScale = Vector3.New(1, 1, 1)

				arg_238_1:CheckSpriteTmpPos("1036", 2)

				for iter_241_8 = 0, var_241_5.childCount - 1 do
					local var_241_6 = var_241_5:GetChild(iter_241_8)

					if var_241_6.name == "" or not string.find(var_241_6.name, "split") then
						var_241_6.gameObject:SetActive(true)
					else
						var_241_6.gameObject:SetActive(false)
					end
				end
			end

			local var_241_7 = 0.001

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_7 then
				var_241_5.localPosition = Vector3.Lerp(arg_238_1.var_.moveOldPos1036, Vector3.New(-390, -388, -250), (arg_238_1.time_ - 0) / var_241_7)
			end

			if arg_238_1.time_ >= 0 + var_241_7 and arg_238_1.time_ < 0 + var_241_7 + arg_241_0 then
				var_241_5.localPosition = Vector3.New(-390, -388, -250)
			end

			local var_241_8 = 0
			local var_241_9 = 0.8

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= var_241_8 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, true)

				arg_238_1.leftNameTxt_.text = arg_238_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_238_1.leftNameTxt_.transform)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1.leftNameTxt_.text)
				SetActive(arg_238_1.iconTrs_.gameObject, false)
				arg_238_1.callingController_:SetSelectedState("normal")

				local var_241_10 = arg_238_1:GetWordFromCfg(425121057)
				local var_241_11 = arg_238_1:FormatText(var_241_10.content)

				arg_238_1.text_.text = var_241_11

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_13 = 32 <= 0 and var_241_9 or var_241_9 * (utf8.len(var_241_11) / 32)

				if (32 <= 0 and var_241_9 or var_241_9 * (utf8.len(var_241_11) / 32)) > 0 and var_241_9 < var_241_13 then
					arg_238_1.talkMaxDuration = var_241_13

					if var_241_13 + var_241_8 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_13 + var_241_8
					end
				end

				arg_238_1.text_.text = var_241_11
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121057", "story_v_out_425121.awb") ~= 0 then
					local var_241_14 = manager.audio:GetVoiceLength("story_v_out_425121", "425121057", "story_v_out_425121.awb") / 1000

					if var_241_14 + var_241_8 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_14 + var_241_8
					end

					if var_241_10.prefab_name ~= "" and arg_238_1.actors_[var_241_10.prefab_name] ~= nil then
						local var_241_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_238_1.actors_[var_241_10.prefab_name].transform, "story_v_out_425121", "425121057", "story_v_out_425121.awb")

						arg_238_1:RecordAudio("425121057", var_241_15)
						arg_238_1:RecordAudio("425121057", var_241_15)
					else
						arg_238_1:AudioAction("play", "voice", "story_v_out_425121", "425121057", "story_v_out_425121.awb")
					end

					arg_238_1:RecordHistoryTalkVoice("story_v_out_425121", "425121057", "story_v_out_425121.awb")
				end

				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_16 = math.max(var_241_9, arg_238_1.talkMaxDuration)

			if var_241_8 <= arg_238_1.time_ and arg_238_1.time_ < var_241_8 + var_241_16 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_8) / var_241_16

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_8 + var_241_16 and arg_238_1.time_ < var_241_8 + var_241_16 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_238_1:InitPlayNodeList()
	end,
	Play425121058 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 425121058
		arg_242_1.duration_ = 11.43

		local var_242_0 = {
			zh = 8.9,
			ja = 11.433
		}
		local var_242_1 = manager.audio:GetLocalizationFlag()

		if var_242_0[var_242_1] ~= nil then
			arg_242_1.duration_ = var_242_0[var_242_1]
		end

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play425121059(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			local var_245_0 = 1.275

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, true)

				arg_242_1.leftNameTxt_.text = arg_242_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_242_1.leftNameTxt_.transform)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1.leftNameTxt_.text)
				SetActive(arg_242_1.iconTrs_.gameObject, false)
				arg_242_1.callingController_:SetSelectedState("normal")

				local var_245_1 = arg_242_1:GetWordFromCfg(425121058)
				local var_245_2 = arg_242_1:FormatText(var_245_1.content)

				arg_242_1.text_.text = var_245_2

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_4 = 51 <= 0 and var_245_0 or var_245_0 * (utf8.len(var_245_2) / 51)

				if (51 <= 0 and var_245_0 or var_245_0 * (utf8.len(var_245_2) / 51)) > 0 and var_245_0 < var_245_4 then
					arg_242_1.talkMaxDuration = var_245_4

					if var_245_4 + 0 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_4 + 0
					end
				end

				arg_242_1.text_.text = var_245_2
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121058", "story_v_out_425121.awb") ~= 0 then
					local var_245_5 = manager.audio:GetVoiceLength("story_v_out_425121", "425121058", "story_v_out_425121.awb") / 1000

					if var_245_5 + 0 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_5 + 0
					end

					if var_245_1.prefab_name ~= "" and arg_242_1.actors_[var_245_1.prefab_name] ~= nil then
						local var_245_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_242_1.actors_[var_245_1.prefab_name].transform, "story_v_out_425121", "425121058", "story_v_out_425121.awb")

						arg_242_1:RecordAudio("425121058", var_245_6)
						arg_242_1:RecordAudio("425121058", var_245_6)
					else
						arg_242_1:AudioAction("play", "voice", "story_v_out_425121", "425121058", "story_v_out_425121.awb")
					end

					arg_242_1:RecordHistoryTalkVoice("story_v_out_425121", "425121058", "story_v_out_425121.awb")
				end

				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_7 = math.max(var_245_0, arg_242_1.talkMaxDuration)

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_7 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - 0) / var_245_7

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= 0 + var_245_7 and arg_242_1.time_ < 0 + var_245_7 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {}

		arg_242_1:InitPlayNodeList()
	end,
	Play425121059 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 425121059
		arg_246_1.duration_ = 6.1

		local var_246_0 = {
			zh = 4.166,
			ja = 6.1
		}
		local var_246_1 = manager.audio:GetLocalizationFlag()

		if var_246_0[var_246_1] ~= nil then
			arg_246_1.duration_ = var_246_0[var_246_1]
		end

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play425121060(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 then
				arg_246_1.var_.moveOldPos1036 = arg_246_1.actors_["1036"].transform.localPosition
				arg_246_1.actors_["1036"].transform.localScale = Vector3.New(1, 1, 1)

				arg_246_1:CheckSpriteTmpPos("1036", 2)

				for iter_249_0 = 0, arg_246_1.actors_["1036"].transform.childCount - 1 do
					local var_249_0 = arg_246_1.actors_["1036"].transform:GetChild(iter_249_0)

					if var_249_0.name == "" or not string.find(var_249_0.name, "split") then
						var_249_0.gameObject:SetActive(true)
					else
						var_249_0.gameObject:SetActive(false)
					end
				end
			end

			local var_249_1 = 0.001

			if 0 <= arg_246_1.time_ and arg_246_1.time_ < 0 + var_249_1 then
				arg_246_1.actors_["1036"].transform.localPosition = Vector3.Lerp(arg_246_1.var_.moveOldPos1036, Vector3.New(-390, -388, -250), (arg_246_1.time_ - 0) / var_249_1)
			end

			if arg_246_1.time_ >= 0 + var_249_1 and arg_246_1.time_ < 0 + var_249_1 + arg_249_0 then
				arg_246_1.actors_["1036"].transform.localPosition = Vector3.New(-390, -388, -250)
			end

			local var_249_2 = 0
			local var_249_3 = 0.55

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= var_249_2 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, true)

				arg_246_1.leftNameTxt_.text = arg_246_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_246_1.leftNameTxt_.transform)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1.leftNameTxt_.text)
				SetActive(arg_246_1.iconTrs_.gameObject, false)
				arg_246_1.callingController_:SetSelectedState("normal")

				local var_249_4 = arg_246_1:GetWordFromCfg(425121059)
				local var_249_5 = arg_246_1:FormatText(var_249_4.content)

				arg_246_1.text_.text = var_249_5

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_7 = 22 <= 0 and var_249_3 or var_249_3 * (utf8.len(var_249_5) / 22)

				if (22 <= 0 and var_249_3 or var_249_3 * (utf8.len(var_249_5) / 22)) > 0 and var_249_3 < var_249_7 then
					arg_246_1.talkMaxDuration = var_249_7

					if var_249_7 + var_249_2 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_7 + var_249_2
					end
				end

				arg_246_1.text_.text = var_249_5
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121059", "story_v_out_425121.awb") ~= 0 then
					local var_249_8 = manager.audio:GetVoiceLength("story_v_out_425121", "425121059", "story_v_out_425121.awb") / 1000

					if var_249_8 + var_249_2 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_8 + var_249_2
					end

					if var_249_4.prefab_name ~= "" and arg_246_1.actors_[var_249_4.prefab_name] ~= nil then
						local var_249_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_246_1.actors_[var_249_4.prefab_name].transform, "story_v_out_425121", "425121059", "story_v_out_425121.awb")

						arg_246_1:RecordAudio("425121059", var_249_9)
						arg_246_1:RecordAudio("425121059", var_249_9)
					else
						arg_246_1:AudioAction("play", "voice", "story_v_out_425121", "425121059", "story_v_out_425121.awb")
					end

					arg_246_1:RecordHistoryTalkVoice("story_v_out_425121", "425121059", "story_v_out_425121.awb")
				end

				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_10 = math.max(var_249_3, arg_246_1.talkMaxDuration)

			if var_249_2 <= arg_246_1.time_ and arg_246_1.time_ < var_249_2 + var_249_10 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - var_249_2) / var_249_10

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= var_249_2 + var_249_10 and arg_246_1.time_ < var_249_2 + var_249_10 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_246_1:InitPlayNodeList()
	end,
	Play425121060 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 425121060
		arg_250_1.duration_ = 5

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play425121061(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 and not isNil(arg_250_1.actors_["1036"]) and arg_250_1.var_.actorSpriteComps1036 == nil then
				arg_250_1.var_.actorSpriteComps1036 = arg_250_1.actors_["1036"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_253_0 = 0.2

			if 0 <= arg_250_1.time_ and arg_250_1.time_ < 0 + var_253_0 and not isNil(arg_250_1.actors_["1036"]) then
				if arg_250_1.var_.actorSpriteComps1036 then
					for iter_253_0, iter_253_1 in pairs(arg_250_1.var_.actorSpriteComps1036:ToTable()) do
						if iter_253_1 then
							if arg_250_1.isInRecall_ then
								iter_253_1.color = Color.New(Mathf.Lerp(iter_253_1.color.r, arg_250_1.hightColor2.r, (arg_250_1.time_ - 0) / var_253_0), Mathf.Lerp(iter_253_1.color.g, arg_250_1.hightColor2.g, (arg_250_1.time_ - 0) / var_253_0), (Mathf.Lerp(iter_253_1.color.b, arg_250_1.hightColor2.b, (arg_250_1.time_ - 0) / var_253_0)))
							else
								local var_253_1 = Mathf.Lerp(iter_253_1.color.r, 0.5, (arg_250_1.time_ - 0) / var_253_0)

								iter_253_1.color = Color.New(var_253_1, var_253_1, var_253_1)
							end
						end
					end
				end
			end

			if arg_250_1.time_ >= 0 + var_253_0 and arg_250_1.time_ < 0 + var_253_0 + arg_253_0 and not isNil(arg_250_1.actors_["1036"]) and arg_250_1.var_.actorSpriteComps1036 then
				for iter_253_2, iter_253_3 in pairs(arg_250_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_253_3 then
						iter_253_3.color = arg_250_1.isInRecall_ and (arg_250_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_250_1.var_.actorSpriteComps1036 = nil
			end

			local var_253_2 = arg_250_1.actors_["1036"].transform

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 then
				arg_250_1.var_.moveOldPos1036 = var_253_2.localPosition
				var_253_2.localScale = Vector3.New(1, 1, 1)

				arg_250_1:CheckSpriteTmpPos("1036", 7)

				for iter_253_4 = 0, var_253_2.childCount - 1 do
					local var_253_3 = var_253_2:GetChild(iter_253_4)

					if var_253_3.name == "" or not string.find(var_253_3.name, "split") then
						var_253_3.gameObject:SetActive(true)
					else
						var_253_3.gameObject:SetActive(false)
					end
				end
			end

			local var_253_4 = 0.001

			if 0 <= arg_250_1.time_ and arg_250_1.time_ < 0 + var_253_4 then
				var_253_2.localPosition = Vector3.Lerp(arg_250_1.var_.moveOldPos1036, Vector3.New(0, -2000, 0), (arg_250_1.time_ - 0) / var_253_4)
			end

			if arg_250_1.time_ >= 0 + var_253_4 and arg_250_1.time_ < 0 + var_253_4 + arg_253_0 then
				var_253_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_253_5 = arg_250_1.actors_["1137"].transform

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 then
				arg_250_1.var_.moveOldPos1137 = var_253_5.localPosition
				var_253_5.localScale = Vector3.New(1, 1, 1)

				arg_250_1:CheckSpriteTmpPos("1137", 7)

				for iter_253_5 = 0, var_253_5.childCount - 1 do
					local var_253_6 = var_253_5:GetChild(iter_253_5)

					if var_253_6.name == "" or not string.find(var_253_6.name, "split") then
						var_253_6.gameObject:SetActive(true)
					else
						var_253_6.gameObject:SetActive(false)
					end
				end
			end

			local var_253_7 = 0.001

			if 0 <= arg_250_1.time_ and arg_250_1.time_ < 0 + var_253_7 then
				var_253_5.localPosition = Vector3.Lerp(arg_250_1.var_.moveOldPos1137, Vector3.New(0, -2000, 0), (arg_250_1.time_ - 0) / var_253_7)
			end

			if arg_250_1.time_ >= 0 + var_253_7 and arg_250_1.time_ < 0 + var_253_7 + arg_253_0 then
				var_253_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_253_8 = 0
			local var_253_9 = 0.975

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= var_253_8 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, false)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_10 = arg_250_1:FormatText(arg_250_1:GetWordFromCfg(425121060).content)

				arg_250_1.text_.text = var_253_10

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_12 = 39 <= 0 and var_253_9 or var_253_9 * (utf8.len(var_253_10) / 39)

				if (39 <= 0 and var_253_9 or var_253_9 * (utf8.len(var_253_10) / 39)) > 0 and var_253_9 < var_253_12 then
					arg_250_1.talkMaxDuration = var_253_12

					if var_253_12 + var_253_8 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_12 + var_253_8
					end
				end

				arg_250_1.text_.text = var_253_10
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)
				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_13 = math.max(var_253_9, arg_250_1.talkMaxDuration)

			if var_253_8 <= arg_250_1.time_ and arg_250_1.time_ < var_253_8 + var_253_13 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_8) / var_253_13

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_8 + var_253_13 and arg_250_1.time_ < var_253_8 + var_253_13 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1137",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_250_1:InitPlayNodeList()
	end,
	Play425121061 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 425121061
		arg_254_1.duration_ = 8

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play425121062(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			if arg_254_1.bgs_.M01f == nil then
				local var_257_0 = Object.Instantiate(arg_254_1.paintGo_)

				var_257_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "M01f")
				var_257_0.name = "M01f"
				var_257_0.transform.parent = arg_254_1.stage_.transform
				var_257_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_254_1.bgs_.M01f = var_257_0
			end

			if 1 < arg_254_1.time_ and arg_254_1.time_ <= 1 + arg_257_0 then
				local var_257_1 = arg_254_1.bgs_.M01f

				arg_254_1.bgs_.M01f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_257_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_257_2 = var_257_1:GetComponent("SpriteRenderer")

				if var_257_2 and var_257_2.sprite then
					local var_257_3 = 2 * (var_257_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_257_1.transform.localScale = Vector3.New(var_257_3 / var_257_2.sprite.bounds.size.y < var_257_3 * manager.ui.mainCameraCom_.aspect / var_257_2.sprite.bounds.size.x and var_257_3 * manager.ui.mainCameraCom_.aspect / var_257_2.sprite.bounds.size.x or var_257_3 / var_257_2.sprite.bounds.size.y, var_257_3 / var_257_2.sprite.bounds.size.y < var_257_3 * manager.ui.mainCameraCom_.aspect / var_257_2.sprite.bounds.size.x and var_257_3 * manager.ui.mainCameraCom_.aspect / var_257_2.sprite.bounds.size.x or var_257_3 / var_257_2.sprite.bounds.size.y, 0)
				end

				for iter_257_0, iter_257_1 in pairs(arg_254_1.bgs_) do
					if iter_257_0 ~= "M01f" then
						iter_257_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_257_4 = 3

			if 3 < arg_254_1.time_ and arg_254_1.time_ <= var_257_4 + arg_257_0 then
				arg_254_1.allBtn_.enabled = false
			end

			if arg_254_1.time_ >= var_257_4 + 0.533333333333333 and arg_254_1.time_ < var_257_4 + 0.533333333333333 + arg_257_0 then
				arg_254_1.allBtn_.enabled = true
			end

			local var_257_5 = 0

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= var_257_5 + arg_257_0 then
				arg_254_1.mask_.enabled = true
				arg_254_1.mask_.raycastTarget = true

				arg_254_1:SetGaussion(false)
			end

			local var_257_6 = 1

			if var_257_5 <= arg_254_1.time_ and arg_254_1.time_ < var_257_5 + var_257_6 then
				local var_257_7 = Color.New(0, 0, 0)

				var_257_7.a = Mathf.Lerp(0, 1, (arg_254_1.time_ - var_257_5) / var_257_6)
				arg_254_1.mask_.color = var_257_7
			end

			if arg_254_1.time_ >= var_257_5 + var_257_6 and arg_254_1.time_ < var_257_5 + var_257_6 + arg_257_0 then
				local var_257_8 = Color.New(0, 0, 0)

				var_257_8.a = 1
				arg_254_1.mask_.color = var_257_8
			end

			local var_257_9 = 1

			if 1 < arg_254_1.time_ and arg_254_1.time_ <= var_257_9 + arg_257_0 then
				arg_254_1.mask_.enabled = true
				arg_254_1.mask_.raycastTarget = true

				arg_254_1:SetGaussion(false)
			end

			local var_257_10 = 2

			if var_257_9 <= arg_254_1.time_ and arg_254_1.time_ < var_257_9 + var_257_10 then
				local var_257_11 = Color.New(0, 0, 0)

				var_257_11.a = Mathf.Lerp(1, 0, (arg_254_1.time_ - var_257_9) / var_257_10)
				arg_254_1.mask_.color = var_257_11
			end

			if arg_254_1.time_ >= var_257_9 + var_257_10 and arg_254_1.time_ < var_257_9 + var_257_10 + arg_257_0 then
				local var_257_12 = Color.New(0, 0, 0)

				arg_254_1.mask_.enabled = false
				var_257_12.a = 0
				arg_254_1.mask_.color = var_257_12
			end

			if 0.133333333333333 < arg_254_1.time_ and arg_254_1.time_ <= 0.133333333333333 + arg_257_0 then
				arg_254_1:AudioAction("stop", "effect", "se_story_134_01", "se_story_134_01_crowd", "")
			end

			if arg_254_1.frameCnt_ <= 1 then
				arg_254_1.dialog_:SetActive(false)
			end

			local var_257_14 = 3
			local var_257_15 = 0.725

			if 3 < arg_254_1.time_ and arg_254_1.time_ <= var_257_14 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0

				arg_254_1.dialog_:SetActive(true)

				arg_254_1.dialogCg_.alpha = 0

				local var_257_16 = LeanTween.value(arg_254_1.dialog_, 0, 1, 0.3)

				var_257_16:setOnUpdate(LuaHelper.FloatAction(function(arg_258_0)
					arg_254_1.dialogCg_.alpha = arg_258_0
				end))
				var_257_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_254_1.dialog_)
					var_257_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_254_1.duration_ = arg_254_1.duration_ + 0.3

				SetActive(arg_254_1.leftNameGo_, false)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_254_1.iconTrs_.gameObject, false)
				arg_254_1.callingController_:SetSelectedState("normal")

				local var_257_17 = arg_254_1:FormatText(arg_254_1:GetWordFromCfg(425121061).content)

				arg_254_1.text_.text = var_257_17

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_19 = 29 <= 0 and var_257_15 or var_257_15 * (utf8.len(var_257_17) / 29)

				if (29 <= 0 and var_257_15 or var_257_15 * (utf8.len(var_257_17) / 29)) > 0 and var_257_15 < var_257_19 then
					arg_254_1.talkMaxDuration = var_257_19
					var_257_14 = var_257_14 + 0.3

					if var_257_19 + var_257_14 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_19 + var_257_14
					end
				end

				arg_254_1.text_.text = var_257_17
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)
				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_20 = var_257_14 + 0.3
			local var_257_21 = math.max(var_257_15, arg_254_1.talkMaxDuration)

			if var_257_14 + 0.3 <= arg_254_1.time_ and arg_254_1.time_ < var_257_20 + var_257_21 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_20) / var_257_21

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_20 + var_257_21 and arg_254_1.time_ < var_257_20 + var_257_21 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {}

		arg_254_1:InitPlayNodeList()
	end,
	Play425121062 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 425121062
		arg_260_1.duration_ = 5.63

		local var_260_0 = {
			zh = 4.466,
			ja = 5.633
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
				arg_260_0:Play425121063(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 and not isNil(arg_260_1.actors_["1137"]) and arg_260_1.var_.actorSpriteComps1137 == nil then
				arg_260_1.var_.actorSpriteComps1137 = arg_260_1.actors_["1137"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_263_0 = 0.2

			if 0 <= arg_260_1.time_ and arg_260_1.time_ < 0 + var_263_0 and not isNil(arg_260_1.actors_["1137"]) then
				if arg_260_1.var_.actorSpriteComps1137 then
					for iter_263_0, iter_263_1 in pairs(arg_260_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_263_1 then
							if arg_260_1.isInRecall_ then
								iter_263_1.color = Color.New(Mathf.Lerp(iter_263_1.color.r, arg_260_1.hightColor1.r, (arg_260_1.time_ - 0) / var_263_0), Mathf.Lerp(iter_263_1.color.g, arg_260_1.hightColor1.g, (arg_260_1.time_ - 0) / var_263_0), (Mathf.Lerp(iter_263_1.color.b, arg_260_1.hightColor1.b, (arg_260_1.time_ - 0) / var_263_0)))
							else
								local var_263_1 = Mathf.Lerp(iter_263_1.color.r, 1, (arg_260_1.time_ - 0) / var_263_0)

								iter_263_1.color = Color.New(var_263_1, var_263_1, var_263_1)
							end
						end
					end
				end
			end

			if arg_260_1.time_ >= 0 + var_263_0 and arg_260_1.time_ < 0 + var_263_0 + arg_263_0 and not isNil(arg_260_1.actors_["1137"]) and arg_260_1.var_.actorSpriteComps1137 then
				for iter_263_2, iter_263_3 in pairs(arg_260_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_263_3 then
						iter_263_3.color = arg_260_1.isInRecall_ and (arg_260_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_260_1.var_.actorSpriteComps1137 = nil
			end

			local var_263_2 = arg_260_1.actors_["1137"].transform

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 then
				arg_260_1.var_.moveOldPos1137 = var_263_2.localPosition
				var_263_2.localScale = Vector3.New(1, 1, 1)

				arg_260_1:CheckSpriteTmpPos("1137", 3)

				for iter_263_4 = 0, var_263_2.childCount - 1 do
					local var_263_3 = var_263_2:GetChild(iter_263_4)

					if var_263_3.name == "split_6" or not string.find(var_263_3.name, "split") then
						var_263_3.gameObject:SetActive(true)
					else
						var_263_3.gameObject:SetActive(false)
					end
				end
			end

			local var_263_4 = 0.001

			if 0 <= arg_260_1.time_ and arg_260_1.time_ < 0 + var_263_4 then
				var_263_2.localPosition = Vector3.Lerp(arg_260_1.var_.moveOldPos1137, Vector3.New(0, -425, -200), (arg_260_1.time_ - 0) / var_263_4)
			end

			if arg_260_1.time_ >= 0 + var_263_4 and arg_260_1.time_ < 0 + var_263_4 + arg_263_0 then
				var_263_2.localPosition = Vector3.New(0, -425, -200)
			end

			local var_263_5 = 0
			local var_263_6 = 0.525

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= var_263_5 + arg_263_0 then
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

				local var_263_7 = arg_260_1:GetWordFromCfg(425121062)
				local var_263_8 = arg_260_1:FormatText(var_263_7.content)

				arg_260_1.text_.text = var_263_8

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_10 = 21 <= 0 and var_263_6 or var_263_6 * (utf8.len(var_263_8) / 21)

				if (21 <= 0 and var_263_6 or var_263_6 * (utf8.len(var_263_8) / 21)) > 0 and var_263_6 < var_263_10 then
					arg_260_1.talkMaxDuration = var_263_10

					if var_263_10 + var_263_5 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_10 + var_263_5
					end
				end

				arg_260_1.text_.text = var_263_8
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121062", "story_v_out_425121.awb") ~= 0 then
					local var_263_11 = manager.audio:GetVoiceLength("story_v_out_425121", "425121062", "story_v_out_425121.awb") / 1000

					if var_263_11 + var_263_5 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_11 + var_263_5
					end

					if var_263_7.prefab_name ~= "" and arg_260_1.actors_[var_263_7.prefab_name] ~= nil then
						local var_263_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_260_1.actors_[var_263_7.prefab_name].transform, "story_v_out_425121", "425121062", "story_v_out_425121.awb")

						arg_260_1:RecordAudio("425121062", var_263_12)
						arg_260_1:RecordAudio("425121062", var_263_12)
					else
						arg_260_1:AudioAction("play", "voice", "story_v_out_425121", "425121062", "story_v_out_425121.awb")
					end

					arg_260_1:RecordHistoryTalkVoice("story_v_out_425121", "425121062", "story_v_out_425121.awb")
				end

				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_13 = math.max(var_263_6, arg_260_1.talkMaxDuration)

			if var_263_5 <= arg_260_1.time_ and arg_260_1.time_ < var_263_5 + var_263_13 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - var_263_5) / var_263_13

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= var_263_5 + var_263_13 and arg_260_1.time_ < var_263_5 + var_263_13 + arg_263_0 then
				arg_260_1.typewritter.percent = 1

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(true)
			end
		end

		arg_260_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1137",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_260_1:InitPlayNodeList()
	end,
	Play425121063 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 425121063
		arg_264_1.duration_ = 5

		SetActive(arg_264_1.tipsGo_, false)

		function arg_264_1.onSingleLineFinish_()
			arg_264_1.onSingleLineUpdate_ = nil
			arg_264_1.onSingleLineFinish_ = nil
			arg_264_1.state_ = "waiting"
		end

		function arg_264_1.playNext_(arg_266_0)
			if arg_266_0 == 1 then
				arg_264_0:Play425121064(arg_264_1)
			end
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 then
				arg_264_1.var_.moveOldPos1137 = arg_264_1.actors_["1137"].transform.localPosition
				arg_264_1.actors_["1137"].transform.localScale = Vector3.New(1, 1, 1)

				arg_264_1:CheckSpriteTmpPos("1137", 7)

				for iter_267_0 = 0, arg_264_1.actors_["1137"].transform.childCount - 1 do
					local var_267_0 = arg_264_1.actors_["1137"].transform:GetChild(iter_267_0)

					if var_267_0.name == "" or not string.find(var_267_0.name, "split") then
						var_267_0.gameObject:SetActive(true)
					else
						var_267_0.gameObject:SetActive(false)
					end
				end
			end

			local var_267_1 = 0.001

			if 0 <= arg_264_1.time_ and arg_264_1.time_ < 0 + var_267_1 then
				arg_264_1.actors_["1137"].transform.localPosition = Vector3.Lerp(arg_264_1.var_.moveOldPos1137, Vector3.New(0, -2000, 0), (arg_264_1.time_ - 0) / var_267_1)
			end

			if arg_264_1.time_ >= 0 + var_267_1 and arg_264_1.time_ < 0 + var_267_1 + arg_267_0 then
				arg_264_1.actors_["1137"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.133333333333333 < arg_264_1.time_ and arg_264_1.time_ <= 0.133333333333333 + arg_267_0 then
				arg_264_1:AudioAction("play", "effect", "se_story_144", "se_story_144_case_open", "")
			end

			local var_267_3 = 0
			local var_267_4 = 0.675

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= var_267_3 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0
				arg_264_1.dialogCg_.alpha = 1

				arg_264_1.dialog_:SetActive(true)
				SetActive(arg_264_1.leftNameGo_, false)

				arg_264_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_264_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_264_1:RecordName(arg_264_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_264_1.iconTrs_.gameObject, false)
				arg_264_1.callingController_:SetSelectedState("normal")

				local var_267_5 = arg_264_1:FormatText(arg_264_1:GetWordFromCfg(425121063).content)

				arg_264_1.text_.text = var_267_5

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_7 = 27 <= 0 and var_267_4 or var_267_4 * (utf8.len(var_267_5) / 27)

				if (27 <= 0 and var_267_4 or var_267_4 * (utf8.len(var_267_5) / 27)) > 0 and var_267_4 < var_267_7 then
					arg_264_1.talkMaxDuration = var_267_7

					if var_267_7 + var_267_3 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_7 + var_267_3
					end
				end

				arg_264_1.text_.text = var_267_5
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)
				arg_264_1:RecordContent(arg_264_1.text_.text)
			end

			local var_267_8 = math.max(var_267_4, arg_264_1.talkMaxDuration)

			if var_267_3 <= arg_264_1.time_ and arg_264_1.time_ < var_267_3 + var_267_8 then
				arg_264_1.typewritter.percent = (arg_264_1.time_ - var_267_3) / var_267_8

				arg_264_1.typewritter:SetDirty()
			end

			if arg_264_1.time_ >= var_267_3 + var_267_8 and arg_264_1.time_ < var_267_3 + var_267_8 + arg_267_0 then
				arg_264_1.typewritter.percent = 1

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(true)
			end
		end

		arg_264_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1137",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_264_1:InitPlayNodeList()
	end,
	Play425121064 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 425121064
		arg_268_1.duration_ = 5

		SetActive(arg_268_1.tipsGo_, false)

		function arg_268_1.onSingleLineFinish_()
			arg_268_1.onSingleLineUpdate_ = nil
			arg_268_1.onSingleLineFinish_ = nil
			arg_268_1.state_ = "waiting"
		end

		function arg_268_1.playNext_(arg_270_0)
			if arg_270_0 == 1 then
				arg_268_0:Play425121065(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			local var_271_0 = 1.575

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0
				arg_268_1.dialogCg_.alpha = 1

				arg_268_1.dialog_:SetActive(true)
				SetActive(arg_268_1.leftNameGo_, false)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_268_1.iconTrs_.gameObject, false)
				arg_268_1.callingController_:SetSelectedState("normal")

				local var_271_1 = arg_268_1:FormatText(arg_268_1:GetWordFromCfg(425121064).content)

				arg_268_1.text_.text = var_271_1

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_3 = 63 <= 0 and var_271_0 or var_271_0 * (utf8.len(var_271_1) / 63)

				if (63 <= 0 and var_271_0 or var_271_0 * (utf8.len(var_271_1) / 63)) > 0 and var_271_0 < var_271_3 then
					arg_268_1.talkMaxDuration = var_271_3

					if var_271_3 + 0 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_3 + 0
					end
				end

				arg_268_1.text_.text = var_271_1
				arg_268_1.typewritter.percent = 0

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(false)
				arg_268_1:RecordContent(arg_268_1.text_.text)
			end

			local var_271_4 = math.max(var_271_0, arg_268_1.talkMaxDuration)

			if 0 <= arg_268_1.time_ and arg_268_1.time_ < 0 + var_271_4 then
				arg_268_1.typewritter.percent = (arg_268_1.time_ - 0) / var_271_4

				arg_268_1.typewritter:SetDirty()
			end

			if arg_268_1.time_ >= 0 + var_271_4 and arg_268_1.time_ < 0 + var_271_4 + arg_271_0 then
				arg_268_1.typewritter.percent = 1

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(true)
			end
		end

		arg_268_1.nodeConfigList_ = {}

		arg_268_1:InitPlayNodeList()
	end,
	Play425121065 = function(arg_272_0, arg_272_1)
		arg_272_1.time_ = 0
		arg_272_1.frameCnt_ = 0
		arg_272_1.state_ = "playing"
		arg_272_1.curTalkId_ = 425121065
		arg_272_1.duration_ = 5.3

		local var_272_0 = {
			zh = 5.3,
			ja = 5
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
				arg_272_0:Play425121066(arg_272_1)
			end
		end

		function arg_272_1.onSingleLineUpdate_(arg_275_0)
			local var_275_0 = 0.475

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 then
				arg_272_1.talkMaxDuration = 0
				arg_272_1.dialogCg_.alpha = 1

				arg_272_1.dialog_:SetActive(true)
				SetActive(arg_272_1.leftNameGo_, true)

				arg_272_1.leftNameTxt_.text = arg_272_1:FormatText(StoryNameCfg[1439].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_272_1.leftNameTxt_.transform)

				arg_272_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_272_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_272_1:RecordName(arg_272_1.leftNameTxt_.text)
				SetActive(arg_272_1.iconTrs_.gameObject, true)
				arg_272_1.iconController_:SetSelectedState("hero")

				arg_272_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpaa")

				arg_272_1.callingController_:SetSelectedState("normal")

				arg_272_1.keyicon_.color = Color.New(1, 1, 1)
				arg_272_1.icon_.color = Color.New(1, 1, 1)

				local var_275_1 = arg_272_1:GetWordFromCfg(425121065)
				local var_275_2 = arg_272_1:FormatText(var_275_1.content)

				arg_272_1.text_.text = var_275_2

				LuaForUtil.ClearLinePrefixSymbol(arg_272_1.text_)

				local var_275_4 = 19 <= 0 and var_275_0 or var_275_0 * (utf8.len(var_275_2) / 19)

				if (19 <= 0 and var_275_0 or var_275_0 * (utf8.len(var_275_2) / 19)) > 0 and var_275_0 < var_275_4 then
					arg_272_1.talkMaxDuration = var_275_4

					if var_275_4 + 0 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_4 + 0
					end
				end

				arg_272_1.text_.text = var_275_2
				arg_272_1.typewritter.percent = 0

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121065", "story_v_out_425121.awb") ~= 0 then
					local var_275_5 = manager.audio:GetVoiceLength("story_v_out_425121", "425121065", "story_v_out_425121.awb") / 1000

					if var_275_5 + 0 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_5 + 0
					end

					if var_275_1.prefab_name ~= "" and arg_272_1.actors_[var_275_1.prefab_name] ~= nil then
						local var_275_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_272_1.actors_[var_275_1.prefab_name].transform, "story_v_out_425121", "425121065", "story_v_out_425121.awb")

						arg_272_1:RecordAudio("425121065", var_275_6)
						arg_272_1:RecordAudio("425121065", var_275_6)
					else
						arg_272_1:AudioAction("play", "voice", "story_v_out_425121", "425121065", "story_v_out_425121.awb")
					end

					arg_272_1:RecordHistoryTalkVoice("story_v_out_425121", "425121065", "story_v_out_425121.awb")
				end

				arg_272_1:RecordContent(arg_272_1.text_.text)
			end

			local var_275_7 = math.max(var_275_0, arg_272_1.talkMaxDuration)

			if 0 <= arg_272_1.time_ and arg_272_1.time_ < 0 + var_275_7 then
				arg_272_1.typewritter.percent = (arg_272_1.time_ - 0) / var_275_7

				arg_272_1.typewritter:SetDirty()
			end

			if arg_272_1.time_ >= 0 + var_275_7 and arg_272_1.time_ < 0 + var_275_7 + arg_275_0 then
				arg_272_1.typewritter.percent = 1

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(true)
			end
		end

		arg_272_1.nodeConfigList_ = {}

		arg_272_1:InitPlayNodeList()
	end,
	Play425121066 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 425121066
		arg_276_1.duration_ = 2.63

		local var_276_0 = {
			zh = 1.633,
			ja = 2.633
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
				arg_276_0:Play425121067(arg_276_1)
			end
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 and not isNil(arg_276_1.actors_["1137"]) and arg_276_1.var_.actorSpriteComps1137 == nil then
				arg_276_1.var_.actorSpriteComps1137 = arg_276_1.actors_["1137"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_279_0 = 0.2

			if 0 <= arg_276_1.time_ and arg_276_1.time_ < 0 + var_279_0 and not isNil(arg_276_1.actors_["1137"]) then
				if arg_276_1.var_.actorSpriteComps1137 then
					for iter_279_0, iter_279_1 in pairs(arg_276_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_279_1 then
							if arg_276_1.isInRecall_ then
								iter_279_1.color = Color.New(Mathf.Lerp(iter_279_1.color.r, arg_276_1.hightColor1.r, (arg_276_1.time_ - 0) / var_279_0), Mathf.Lerp(iter_279_1.color.g, arg_276_1.hightColor1.g, (arg_276_1.time_ - 0) / var_279_0), (Mathf.Lerp(iter_279_1.color.b, arg_276_1.hightColor1.b, (arg_276_1.time_ - 0) / var_279_0)))
							else
								local var_279_1 = Mathf.Lerp(iter_279_1.color.r, 1, (arg_276_1.time_ - 0) / var_279_0)

								iter_279_1.color = Color.New(var_279_1, var_279_1, var_279_1)
							end
						end
					end
				end
			end

			if arg_276_1.time_ >= 0 + var_279_0 and arg_276_1.time_ < 0 + var_279_0 + arg_279_0 and not isNil(arg_276_1.actors_["1137"]) and arg_276_1.var_.actorSpriteComps1137 then
				for iter_279_2, iter_279_3 in pairs(arg_276_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_279_3 then
						iter_279_3.color = arg_276_1.isInRecall_ and (arg_276_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_276_1.var_.actorSpriteComps1137 = nil
			end

			local var_279_2 = arg_276_1.actors_["1137"].transform

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 then
				arg_276_1.var_.moveOldPos1137 = var_279_2.localPosition
				var_279_2.localScale = Vector3.New(1, 1, 1)

				arg_276_1:CheckSpriteTmpPos("1137", 3)

				for iter_279_4 = 0, var_279_2.childCount - 1 do
					local var_279_3 = var_279_2:GetChild(iter_279_4)

					if var_279_3.name == "split_5" or not string.find(var_279_3.name, "split") then
						var_279_3.gameObject:SetActive(true)
					else
						var_279_3.gameObject:SetActive(false)
					end
				end
			end

			local var_279_4 = 0.001

			if 0 <= arg_276_1.time_ and arg_276_1.time_ < 0 + var_279_4 then
				var_279_2.localPosition = Vector3.Lerp(arg_276_1.var_.moveOldPos1137, Vector3.New(0, -425, -200), (arg_276_1.time_ - 0) / var_279_4)
			end

			if arg_276_1.time_ >= 0 + var_279_4 and arg_276_1.time_ < 0 + var_279_4 + arg_279_0 then
				var_279_2.localPosition = Vector3.New(0, -425, -200)
			end

			local var_279_5 = 0
			local var_279_6 = 0.15

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= var_279_5 + arg_279_0 then
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

				local var_279_7 = arg_276_1:GetWordFromCfg(425121066)
				local var_279_8 = arg_276_1:FormatText(var_279_7.content)

				arg_276_1.text_.text = var_279_8

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_10 = 6 <= 0 and var_279_6 or var_279_6 * (utf8.len(var_279_8) / 6)

				if (6 <= 0 and var_279_6 or var_279_6 * (utf8.len(var_279_8) / 6)) > 0 and var_279_6 < var_279_10 then
					arg_276_1.talkMaxDuration = var_279_10

					if var_279_10 + var_279_5 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_10 + var_279_5
					end
				end

				arg_276_1.text_.text = var_279_8
				arg_276_1.typewritter.percent = 0

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121066", "story_v_out_425121.awb") ~= 0 then
					local var_279_11 = manager.audio:GetVoiceLength("story_v_out_425121", "425121066", "story_v_out_425121.awb") / 1000

					if var_279_11 + var_279_5 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_11 + var_279_5
					end

					if var_279_7.prefab_name ~= "" and arg_276_1.actors_[var_279_7.prefab_name] ~= nil then
						local var_279_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_276_1.actors_[var_279_7.prefab_name].transform, "story_v_out_425121", "425121066", "story_v_out_425121.awb")

						arg_276_1:RecordAudio("425121066", var_279_12)
						arg_276_1:RecordAudio("425121066", var_279_12)
					else
						arg_276_1:AudioAction("play", "voice", "story_v_out_425121", "425121066", "story_v_out_425121.awb")
					end

					arg_276_1:RecordHistoryTalkVoice("story_v_out_425121", "425121066", "story_v_out_425121.awb")
				end

				arg_276_1:RecordContent(arg_276_1.text_.text)
			end

			local var_279_13 = math.max(var_279_6, arg_276_1.talkMaxDuration)

			if var_279_5 <= arg_276_1.time_ and arg_276_1.time_ < var_279_5 + var_279_13 then
				arg_276_1.typewritter.percent = (arg_276_1.time_ - var_279_5) / var_279_13

				arg_276_1.typewritter:SetDirty()
			end

			if arg_276_1.time_ >= var_279_5 + var_279_13 and arg_276_1.time_ < var_279_5 + var_279_13 + arg_279_0 then
				arg_276_1.typewritter.percent = 1

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(true)
			end
		end

		arg_276_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1137",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_276_1:InitPlayNodeList()
	end,
	Play425121067 = function(arg_280_0, arg_280_1)
		arg_280_1.time_ = 0
		arg_280_1.frameCnt_ = 0
		arg_280_1.state_ = "playing"
		arg_280_1.curTalkId_ = 425121067
		arg_280_1.duration_ = 10.97

		local var_280_0 = {
			zh = 8.7,
			ja = 10.966
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
				arg_280_0:Play425121068(arg_280_1)
			end
		end

		function arg_280_1.onSingleLineUpdate_(arg_283_0)
			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 and not isNil(arg_280_1.actors_["1137"]) and arg_280_1.var_.actorSpriteComps1137 == nil then
				arg_280_1.var_.actorSpriteComps1137 = arg_280_1.actors_["1137"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_283_0 = 0.2

			if 0 <= arg_280_1.time_ and arg_280_1.time_ < 0 + var_283_0 and not isNil(arg_280_1.actors_["1137"]) then
				if arg_280_1.var_.actorSpriteComps1137 then
					for iter_283_0, iter_283_1 in pairs(arg_280_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_283_1 then
							if arg_280_1.isInRecall_ then
								iter_283_1.color = Color.New(Mathf.Lerp(iter_283_1.color.r, arg_280_1.hightColor2.r, (arg_280_1.time_ - 0) / var_283_0), Mathf.Lerp(iter_283_1.color.g, arg_280_1.hightColor2.g, (arg_280_1.time_ - 0) / var_283_0), (Mathf.Lerp(iter_283_1.color.b, arg_280_1.hightColor2.b, (arg_280_1.time_ - 0) / var_283_0)))
							else
								local var_283_1 = Mathf.Lerp(iter_283_1.color.r, 0.5, (arg_280_1.time_ - 0) / var_283_0)

								iter_283_1.color = Color.New(var_283_1, var_283_1, var_283_1)
							end
						end
					end
				end
			end

			if arg_280_1.time_ >= 0 + var_283_0 and arg_280_1.time_ < 0 + var_283_0 + arg_283_0 and not isNil(arg_280_1.actors_["1137"]) and arg_280_1.var_.actorSpriteComps1137 then
				for iter_283_2, iter_283_3 in pairs(arg_280_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_283_3 then
						iter_283_3.color = arg_280_1.isInRecall_ and (arg_280_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_280_1.var_.actorSpriteComps1137 = nil
			end

			local var_283_2 = 0
			local var_283_3 = 0.775

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= var_283_2 + arg_283_0 then
				arg_280_1.talkMaxDuration = 0
				arg_280_1.dialogCg_.alpha = 1

				arg_280_1.dialog_:SetActive(true)
				SetActive(arg_280_1.leftNameGo_, true)

				arg_280_1.leftNameTxt_.text = arg_280_1:FormatText(StoryNameCfg[1439].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_280_1.leftNameTxt_.transform)

				arg_280_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_280_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_280_1:RecordName(arg_280_1.leftNameTxt_.text)
				SetActive(arg_280_1.iconTrs_.gameObject, true)
				arg_280_1.iconController_:SetSelectedState("hero")

				arg_280_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpaa")

				arg_280_1.callingController_:SetSelectedState("normal")

				arg_280_1.keyicon_.color = Color.New(1, 1, 1)
				arg_280_1.icon_.color = Color.New(1, 1, 1)

				local var_283_4 = arg_280_1:GetWordFromCfg(425121067)
				local var_283_5 = arg_280_1:FormatText(var_283_4.content)

				arg_280_1.text_.text = var_283_5

				LuaForUtil.ClearLinePrefixSymbol(arg_280_1.text_)

				local var_283_7 = 31 <= 0 and var_283_3 or var_283_3 * (utf8.len(var_283_5) / 31)

				if (31 <= 0 and var_283_3 or var_283_3 * (utf8.len(var_283_5) / 31)) > 0 and var_283_3 < var_283_7 then
					arg_280_1.talkMaxDuration = var_283_7

					if var_283_7 + var_283_2 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_7 + var_283_2
					end
				end

				arg_280_1.text_.text = var_283_5
				arg_280_1.typewritter.percent = 0

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121067", "story_v_out_425121.awb") ~= 0 then
					local var_283_8 = manager.audio:GetVoiceLength("story_v_out_425121", "425121067", "story_v_out_425121.awb") / 1000

					if var_283_8 + var_283_2 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_8 + var_283_2
					end

					if var_283_4.prefab_name ~= "" and arg_280_1.actors_[var_283_4.prefab_name] ~= nil then
						local var_283_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_280_1.actors_[var_283_4.prefab_name].transform, "story_v_out_425121", "425121067", "story_v_out_425121.awb")

						arg_280_1:RecordAudio("425121067", var_283_9)
						arg_280_1:RecordAudio("425121067", var_283_9)
					else
						arg_280_1:AudioAction("play", "voice", "story_v_out_425121", "425121067", "story_v_out_425121.awb")
					end

					arg_280_1:RecordHistoryTalkVoice("story_v_out_425121", "425121067", "story_v_out_425121.awb")
				end

				arg_280_1:RecordContent(arg_280_1.text_.text)
			end

			local var_283_10 = math.max(var_283_3, arg_280_1.talkMaxDuration)

			if var_283_2 <= arg_280_1.time_ and arg_280_1.time_ < var_283_2 + var_283_10 then
				arg_280_1.typewritter.percent = (arg_280_1.time_ - var_283_2) / var_283_10

				arg_280_1.typewritter:SetDirty()
			end

			if arg_280_1.time_ >= var_283_2 + var_283_10 and arg_280_1.time_ < var_283_2 + var_283_10 + arg_283_0 then
				arg_280_1.typewritter.percent = 1

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(true)
			end
		end

		arg_280_1.nodeConfigList_ = {}

		arg_280_1:InitPlayNodeList()
	end,
	Play425121068 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 425121068
		arg_284_1.duration_ = 11.1

		local var_284_0 = {
			zh = 6.666,
			ja = 11.1
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
				arg_284_0:Play425121069(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 and not isNil(arg_284_1.actors_["1137"]) and arg_284_1.var_.actorSpriteComps1137 == nil then
				arg_284_1.var_.actorSpriteComps1137 = arg_284_1.actors_["1137"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_287_0 = 0.2

			if 0 <= arg_284_1.time_ and arg_284_1.time_ < 0 + var_287_0 and not isNil(arg_284_1.actors_["1137"]) then
				if arg_284_1.var_.actorSpriteComps1137 then
					for iter_287_0, iter_287_1 in pairs(arg_284_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_287_1 then
							if arg_284_1.isInRecall_ then
								iter_287_1.color = Color.New(Mathf.Lerp(iter_287_1.color.r, arg_284_1.hightColor1.r, (arg_284_1.time_ - 0) / var_287_0), Mathf.Lerp(iter_287_1.color.g, arg_284_1.hightColor1.g, (arg_284_1.time_ - 0) / var_287_0), (Mathf.Lerp(iter_287_1.color.b, arg_284_1.hightColor1.b, (arg_284_1.time_ - 0) / var_287_0)))
							else
								local var_287_1 = Mathf.Lerp(iter_287_1.color.r, 1, (arg_284_1.time_ - 0) / var_287_0)

								iter_287_1.color = Color.New(var_287_1, var_287_1, var_287_1)
							end
						end
					end
				end
			end

			if arg_284_1.time_ >= 0 + var_287_0 and arg_284_1.time_ < 0 + var_287_0 + arg_287_0 and not isNil(arg_284_1.actors_["1137"]) and arg_284_1.var_.actorSpriteComps1137 then
				for iter_287_2, iter_287_3 in pairs(arg_284_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_287_3 then
						iter_287_3.color = arg_284_1.isInRecall_ and (arg_284_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_284_1.var_.actorSpriteComps1137 = nil
			end

			local var_287_2 = arg_284_1.actors_["1137"].transform

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 then
				arg_284_1.var_.moveOldPos1137 = var_287_2.localPosition
				var_287_2.localScale = Vector3.New(1, 1, 1)

				arg_284_1:CheckSpriteTmpPos("1137", 3)

				for iter_287_4 = 0, var_287_2.childCount - 1 do
					local var_287_3 = var_287_2:GetChild(iter_287_4)

					if var_287_3.name == "split_6" then
						var_287_3:SetAsLastSibling()
						var_287_3.gameObject:SetActive(true)

						arg_284_1.var_.actorSpriteSplit1137 = var_287_3.gameObject:GetComponent(typeof(Image))

						arg_284_1.var_.actorSpriteSplit1137:SetAlpha(0)
					end
				end
			end

			local var_287_4 = 0.2

			if 0 <= arg_284_1.time_ and arg_284_1.time_ < 0 + var_287_4 then
				var_287_2.localPosition = Vector3.Lerp(arg_284_1.var_.moveOldPos1137, Vector3.New(0, -425, -200), (arg_284_1.time_ - 0) / var_287_4)

				if arg_284_1.var_.actorSpriteSplit1137 ~= nil then
					arg_284_1.var_.actorSpriteSplit1137:SetAlpha((arg_284_1.time_ - 0) / var_287_4)
				end
			end

			if arg_284_1.time_ >= 0 + var_287_4 and arg_284_1.time_ < 0 + var_287_4 + arg_287_0 then
				var_287_2.localPosition = Vector3.New(0, -425, -200)

				if arg_284_1.var_.actorSpriteSplit1137 ~= nil then
					arg_284_1.var_.actorSpriteSplit1137:SetAlpha(1)
				end
			end

			local var_287_5 = 0
			local var_287_6 = 0.825

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= var_287_5 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0
				arg_284_1.dialogCg_.alpha = 1

				arg_284_1.dialog_:SetActive(true)
				SetActive(arg_284_1.leftNameGo_, true)

				arg_284_1.leftNameTxt_.text = arg_284_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_284_1.leftNameTxt_.transform)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1.leftNameTxt_.text)
				SetActive(arg_284_1.iconTrs_.gameObject, false)
				arg_284_1.callingController_:SetSelectedState("normal")

				local var_287_7 = arg_284_1:GetWordFromCfg(425121068)
				local var_287_8 = arg_284_1:FormatText(var_287_7.content)

				arg_284_1.text_.text = var_287_8

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_10 = 33 <= 0 and var_287_6 or var_287_6 * (utf8.len(var_287_8) / 33)

				if (33 <= 0 and var_287_6 or var_287_6 * (utf8.len(var_287_8) / 33)) > 0 and var_287_6 < var_287_10 then
					arg_284_1.talkMaxDuration = var_287_10

					if var_287_10 + var_287_5 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_10 + var_287_5
					end
				end

				arg_284_1.text_.text = var_287_8
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121068", "story_v_out_425121.awb") ~= 0 then
					local var_287_11 = manager.audio:GetVoiceLength("story_v_out_425121", "425121068", "story_v_out_425121.awb") / 1000

					if var_287_11 + var_287_5 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_11 + var_287_5
					end

					if var_287_7.prefab_name ~= "" and arg_284_1.actors_[var_287_7.prefab_name] ~= nil then
						local var_287_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_284_1.actors_[var_287_7.prefab_name].transform, "story_v_out_425121", "425121068", "story_v_out_425121.awb")

						arg_284_1:RecordAudio("425121068", var_287_12)
						arg_284_1:RecordAudio("425121068", var_287_12)
					else
						arg_284_1:AudioAction("play", "voice", "story_v_out_425121", "425121068", "story_v_out_425121.awb")
					end

					arg_284_1:RecordHistoryTalkVoice("story_v_out_425121", "425121068", "story_v_out_425121.awb")
				end

				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_13 = math.max(var_287_6, arg_284_1.talkMaxDuration)

			if var_287_5 <= arg_284_1.time_ and arg_284_1.time_ < var_287_5 + var_287_13 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - var_287_5) / var_287_13

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= var_287_5 + var_287_13 and arg_284_1.time_ < var_287_5 + var_287_13 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1137",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.2,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_284_1:InitPlayNodeList()
	end,
	Play425121069 = function(arg_288_0, arg_288_1)
		arg_288_1.time_ = 0
		arg_288_1.frameCnt_ = 0
		arg_288_1.state_ = "playing"
		arg_288_1.curTalkId_ = 425121069
		arg_288_1.duration_ = 5.13

		local var_288_0 = {
			zh = 4.1,
			ja = 5.133
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
				arg_288_0:Play425121070(arg_288_1)
			end
		end

		function arg_288_1.onSingleLineUpdate_(arg_291_0)
			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 and not isNil(arg_288_1.actors_["1137"]) and arg_288_1.var_.actorSpriteComps1137 == nil then
				arg_288_1.var_.actorSpriteComps1137 = arg_288_1.actors_["1137"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_291_0 = 0.2

			if 0 <= arg_288_1.time_ and arg_288_1.time_ < 0 + var_291_0 and not isNil(arg_288_1.actors_["1137"]) then
				if arg_288_1.var_.actorSpriteComps1137 then
					for iter_291_0, iter_291_1 in pairs(arg_288_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_291_1 then
							if arg_288_1.isInRecall_ then
								iter_291_1.color = Color.New(Mathf.Lerp(iter_291_1.color.r, arg_288_1.hightColor2.r, (arg_288_1.time_ - 0) / var_291_0), Mathf.Lerp(iter_291_1.color.g, arg_288_1.hightColor2.g, (arg_288_1.time_ - 0) / var_291_0), (Mathf.Lerp(iter_291_1.color.b, arg_288_1.hightColor2.b, (arg_288_1.time_ - 0) / var_291_0)))
							else
								local var_291_1 = Mathf.Lerp(iter_291_1.color.r, 0.5, (arg_288_1.time_ - 0) / var_291_0)

								iter_291_1.color = Color.New(var_291_1, var_291_1, var_291_1)
							end
						end
					end
				end
			end

			if arg_288_1.time_ >= 0 + var_291_0 and arg_288_1.time_ < 0 + var_291_0 + arg_291_0 and not isNil(arg_288_1.actors_["1137"]) and arg_288_1.var_.actorSpriteComps1137 then
				for iter_291_2, iter_291_3 in pairs(arg_288_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_291_3 then
						iter_291_3.color = arg_288_1.isInRecall_ and (arg_288_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_288_1.var_.actorSpriteComps1137 = nil
			end

			local var_291_2 = 0
			local var_291_3 = 0.35

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= var_291_2 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0
				arg_288_1.dialogCg_.alpha = 1

				arg_288_1.dialog_:SetActive(true)
				SetActive(arg_288_1.leftNameGo_, true)

				arg_288_1.leftNameTxt_.text = arg_288_1:FormatText(StoryNameCfg[1439].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_288_1.leftNameTxt_.transform)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1.leftNameTxt_.text)
				SetActive(arg_288_1.iconTrs_.gameObject, true)
				arg_288_1.iconController_:SetSelectedState("hero")

				arg_288_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpaa")

				arg_288_1.callingController_:SetSelectedState("normal")

				arg_288_1.keyicon_.color = Color.New(1, 1, 1)
				arg_288_1.icon_.color = Color.New(1, 1, 1)

				local var_291_4 = arg_288_1:GetWordFromCfg(425121069)
				local var_291_5 = arg_288_1:FormatText(var_291_4.content)

				arg_288_1.text_.text = var_291_5

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_7 = 14 <= 0 and var_291_3 or var_291_3 * (utf8.len(var_291_5) / 14)

				if (14 <= 0 and var_291_3 or var_291_3 * (utf8.len(var_291_5) / 14)) > 0 and var_291_3 < var_291_7 then
					arg_288_1.talkMaxDuration = var_291_7

					if var_291_7 + var_291_2 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_7 + var_291_2
					end
				end

				arg_288_1.text_.text = var_291_5
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121069", "story_v_out_425121.awb") ~= 0 then
					local var_291_8 = manager.audio:GetVoiceLength("story_v_out_425121", "425121069", "story_v_out_425121.awb") / 1000

					if var_291_8 + var_291_2 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_8 + var_291_2
					end

					if var_291_4.prefab_name ~= "" and arg_288_1.actors_[var_291_4.prefab_name] ~= nil then
						local var_291_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_288_1.actors_[var_291_4.prefab_name].transform, "story_v_out_425121", "425121069", "story_v_out_425121.awb")

						arg_288_1:RecordAudio("425121069", var_291_9)
						arg_288_1:RecordAudio("425121069", var_291_9)
					else
						arg_288_1:AudioAction("play", "voice", "story_v_out_425121", "425121069", "story_v_out_425121.awb")
					end

					arg_288_1:RecordHistoryTalkVoice("story_v_out_425121", "425121069", "story_v_out_425121.awb")
				end

				arg_288_1:RecordContent(arg_288_1.text_.text)
			end

			local var_291_10 = math.max(var_291_3, arg_288_1.talkMaxDuration)

			if var_291_2 <= arg_288_1.time_ and arg_288_1.time_ < var_291_2 + var_291_10 then
				arg_288_1.typewritter.percent = (arg_288_1.time_ - var_291_2) / var_291_10

				arg_288_1.typewritter:SetDirty()
			end

			if arg_288_1.time_ >= var_291_2 + var_291_10 and arg_288_1.time_ < var_291_2 + var_291_10 + arg_291_0 then
				arg_288_1.typewritter.percent = 1

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(true)
			end
		end

		arg_288_1.nodeConfigList_ = {}

		arg_288_1:InitPlayNodeList()
	end,
	Play425121070 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 425121070
		arg_292_1.duration_ = 1.57

		local var_292_0 = {
			zh = 1.4,
			ja = 1.566
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
				arg_292_0:Play425121071(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 and not isNil(arg_292_1.actors_["1137"]) and arg_292_1.var_.actorSpriteComps1137 == nil then
				arg_292_1.var_.actorSpriteComps1137 = arg_292_1.actors_["1137"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_295_0 = 0.2

			if 0 <= arg_292_1.time_ and arg_292_1.time_ < 0 + var_295_0 and not isNil(arg_292_1.actors_["1137"]) then
				if arg_292_1.var_.actorSpriteComps1137 then
					for iter_295_0, iter_295_1 in pairs(arg_292_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_295_1 then
							if arg_292_1.isInRecall_ then
								iter_295_1.color = Color.New(Mathf.Lerp(iter_295_1.color.r, arg_292_1.hightColor1.r, (arg_292_1.time_ - 0) / var_295_0), Mathf.Lerp(iter_295_1.color.g, arg_292_1.hightColor1.g, (arg_292_1.time_ - 0) / var_295_0), (Mathf.Lerp(iter_295_1.color.b, arg_292_1.hightColor1.b, (arg_292_1.time_ - 0) / var_295_0)))
							else
								local var_295_1 = Mathf.Lerp(iter_295_1.color.r, 1, (arg_292_1.time_ - 0) / var_295_0)

								iter_295_1.color = Color.New(var_295_1, var_295_1, var_295_1)
							end
						end
					end
				end
			end

			if arg_292_1.time_ >= 0 + var_295_0 and arg_292_1.time_ < 0 + var_295_0 + arg_295_0 and not isNil(arg_292_1.actors_["1137"]) and arg_292_1.var_.actorSpriteComps1137 then
				for iter_295_2, iter_295_3 in pairs(arg_292_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_295_3 then
						iter_295_3.color = arg_292_1.isInRecall_ and (arg_292_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_292_1.var_.actorSpriteComps1137 = nil
			end

			local var_295_2 = arg_292_1.actors_["1137"].transform

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 then
				arg_292_1.var_.moveOldPos1137 = var_295_2.localPosition
				var_295_2.localScale = Vector3.New(1, 1, 1)

				arg_292_1:CheckSpriteTmpPos("1137", 3)

				for iter_295_4 = 0, var_295_2.childCount - 1 do
					local var_295_3 = var_295_2:GetChild(iter_295_4)

					if var_295_3.name == "split_4" then
						var_295_3:SetAsLastSibling()
						var_295_3.gameObject:SetActive(true)

						arg_292_1.var_.actorSpriteSplit1137 = var_295_3.gameObject:GetComponent(typeof(Image))

						arg_292_1.var_.actorSpriteSplit1137:SetAlpha(0)
					end
				end
			end

			local var_295_4 = 0.2

			if 0 <= arg_292_1.time_ and arg_292_1.time_ < 0 + var_295_4 then
				var_295_2.localPosition = Vector3.Lerp(arg_292_1.var_.moveOldPos1137, Vector3.New(0, -425, -200), (arg_292_1.time_ - 0) / var_295_4)

				if arg_292_1.var_.actorSpriteSplit1137 ~= nil then
					arg_292_1.var_.actorSpriteSplit1137:SetAlpha((arg_292_1.time_ - 0) / var_295_4)
				end
			end

			if arg_292_1.time_ >= 0 + var_295_4 and arg_292_1.time_ < 0 + var_295_4 + arg_295_0 then
				var_295_2.localPosition = Vector3.New(0, -425, -200)

				if arg_292_1.var_.actorSpriteSplit1137 ~= nil then
					arg_292_1.var_.actorSpriteSplit1137:SetAlpha(1)
				end
			end

			local var_295_5 = 0
			local var_295_6 = 0.075

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= var_295_5 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0
				arg_292_1.dialogCg_.alpha = 1

				arg_292_1.dialog_:SetActive(true)
				SetActive(arg_292_1.leftNameGo_, true)

				arg_292_1.leftNameTxt_.text = arg_292_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_292_1.leftNameTxt_.transform)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1.leftNameTxt_.text)
				SetActive(arg_292_1.iconTrs_.gameObject, false)
				arg_292_1.callingController_:SetSelectedState("normal")

				local var_295_7 = arg_292_1:GetWordFromCfg(425121070)
				local var_295_8 = arg_292_1:FormatText(var_295_7.content)

				arg_292_1.text_.text = var_295_8

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_10 = 3 <= 0 and var_295_6 or var_295_6 * (utf8.len(var_295_8) / 3)

				if (3 <= 0 and var_295_6 or var_295_6 * (utf8.len(var_295_8) / 3)) > 0 and var_295_6 < var_295_10 then
					arg_292_1.talkMaxDuration = var_295_10

					if var_295_10 + var_295_5 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_10 + var_295_5
					end
				end

				arg_292_1.text_.text = var_295_8
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121070", "story_v_out_425121.awb") ~= 0 then
					local var_295_11 = manager.audio:GetVoiceLength("story_v_out_425121", "425121070", "story_v_out_425121.awb") / 1000

					if var_295_11 + var_295_5 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_11 + var_295_5
					end

					if var_295_7.prefab_name ~= "" and arg_292_1.actors_[var_295_7.prefab_name] ~= nil then
						local var_295_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_292_1.actors_[var_295_7.prefab_name].transform, "story_v_out_425121", "425121070", "story_v_out_425121.awb")

						arg_292_1:RecordAudio("425121070", var_295_12)
						arg_292_1:RecordAudio("425121070", var_295_12)
					else
						arg_292_1:AudioAction("play", "voice", "story_v_out_425121", "425121070", "story_v_out_425121.awb")
					end

					arg_292_1:RecordHistoryTalkVoice("story_v_out_425121", "425121070", "story_v_out_425121.awb")
				end

				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_13 = math.max(var_295_6, arg_292_1.talkMaxDuration)

			if var_295_5 <= arg_292_1.time_ and arg_292_1.time_ < var_295_5 + var_295_13 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - var_295_5) / var_295_13

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= var_295_5 + var_295_13 and arg_292_1.time_ < var_295_5 + var_295_13 + arg_295_0 then
				arg_292_1.typewritter.percent = 1

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(true)
			end
		end

		arg_292_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1137",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.2,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_292_1:InitPlayNodeList()
	end,
	Play425121071 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 425121071
		arg_296_1.duration_ = 12.1

		local var_296_0 = {
			zh = 8.233,
			ja = 12.1
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
				arg_296_0:Play425121072(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 and not isNil(arg_296_1.actors_["1137"]) and arg_296_1.var_.actorSpriteComps1137 == nil then
				arg_296_1.var_.actorSpriteComps1137 = arg_296_1.actors_["1137"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_299_0 = 0.2

			if 0 <= arg_296_1.time_ and arg_296_1.time_ < 0 + var_299_0 and not isNil(arg_296_1.actors_["1137"]) then
				if arg_296_1.var_.actorSpriteComps1137 then
					for iter_299_0, iter_299_1 in pairs(arg_296_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_299_1 then
							if arg_296_1.isInRecall_ then
								iter_299_1.color = Color.New(Mathf.Lerp(iter_299_1.color.r, arg_296_1.hightColor2.r, (arg_296_1.time_ - 0) / var_299_0), Mathf.Lerp(iter_299_1.color.g, arg_296_1.hightColor2.g, (arg_296_1.time_ - 0) / var_299_0), (Mathf.Lerp(iter_299_1.color.b, arg_296_1.hightColor2.b, (arg_296_1.time_ - 0) / var_299_0)))
							else
								local var_299_1 = Mathf.Lerp(iter_299_1.color.r, 0.5, (arg_296_1.time_ - 0) / var_299_0)

								iter_299_1.color = Color.New(var_299_1, var_299_1, var_299_1)
							end
						end
					end
				end
			end

			if arg_296_1.time_ >= 0 + var_299_0 and arg_296_1.time_ < 0 + var_299_0 + arg_299_0 and not isNil(arg_296_1.actors_["1137"]) and arg_296_1.var_.actorSpriteComps1137 then
				for iter_299_2, iter_299_3 in pairs(arg_296_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_299_3 then
						iter_299_3.color = arg_296_1.isInRecall_ and (arg_296_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_296_1.var_.actorSpriteComps1137 = nil
			end

			local var_299_2 = 0
			local var_299_3 = 0.75

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= var_299_2 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0
				arg_296_1.dialogCg_.alpha = 1

				arg_296_1.dialog_:SetActive(true)
				SetActive(arg_296_1.leftNameGo_, true)

				arg_296_1.leftNameTxt_.text = arg_296_1:FormatText(StoryNameCfg[1439].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_296_1.leftNameTxt_.transform)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1.leftNameTxt_.text)
				SetActive(arg_296_1.iconTrs_.gameObject, true)
				arg_296_1.iconController_:SetSelectedState("hero")

				arg_296_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpaa")

				arg_296_1.callingController_:SetSelectedState("normal")

				arg_296_1.keyicon_.color = Color.New(1, 1, 1)
				arg_296_1.icon_.color = Color.New(1, 1, 1)

				local var_299_4 = arg_296_1:GetWordFromCfg(425121071)
				local var_299_5 = arg_296_1:FormatText(var_299_4.content)

				arg_296_1.text_.text = var_299_5

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_7 = 30 <= 0 and var_299_3 or var_299_3 * (utf8.len(var_299_5) / 30)

				if (30 <= 0 and var_299_3 or var_299_3 * (utf8.len(var_299_5) / 30)) > 0 and var_299_3 < var_299_7 then
					arg_296_1.talkMaxDuration = var_299_7

					if var_299_7 + var_299_2 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_7 + var_299_2
					end
				end

				arg_296_1.text_.text = var_299_5
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121071", "story_v_out_425121.awb") ~= 0 then
					local var_299_8 = manager.audio:GetVoiceLength("story_v_out_425121", "425121071", "story_v_out_425121.awb") / 1000

					if var_299_8 + var_299_2 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_8 + var_299_2
					end

					if var_299_4.prefab_name ~= "" and arg_296_1.actors_[var_299_4.prefab_name] ~= nil then
						local var_299_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_296_1.actors_[var_299_4.prefab_name].transform, "story_v_out_425121", "425121071", "story_v_out_425121.awb")

						arg_296_1:RecordAudio("425121071", var_299_9)
						arg_296_1:RecordAudio("425121071", var_299_9)
					else
						arg_296_1:AudioAction("play", "voice", "story_v_out_425121", "425121071", "story_v_out_425121.awb")
					end

					arg_296_1:RecordHistoryTalkVoice("story_v_out_425121", "425121071", "story_v_out_425121.awb")
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
	Play425121072 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 425121072
		arg_300_1.duration_ = 11.37

		local var_300_0 = {
			zh = 7.7,
			ja = 11.366
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
				arg_300_0:Play425121073(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			local var_303_0 = 0.75

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0
				arg_300_1.dialogCg_.alpha = 1

				arg_300_1.dialog_:SetActive(true)
				SetActive(arg_300_1.leftNameGo_, true)

				arg_300_1.leftNameTxt_.text = arg_300_1:FormatText(StoryNameCfg[1439].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_300_1.leftNameTxt_.transform)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1.leftNameTxt_.text)
				SetActive(arg_300_1.iconTrs_.gameObject, true)
				arg_300_1.iconController_:SetSelectedState("hero")

				arg_300_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpaa")

				arg_300_1.callingController_:SetSelectedState("normal")

				arg_300_1.keyicon_.color = Color.New(1, 1, 1)
				arg_300_1.icon_.color = Color.New(1, 1, 1)

				local var_303_1 = arg_300_1:GetWordFromCfg(425121072)
				local var_303_2 = arg_300_1:FormatText(var_303_1.content)

				arg_300_1.text_.text = var_303_2

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_4 = 30 <= 0 and var_303_0 or var_303_0 * (utf8.len(var_303_2) / 30)

				if (30 <= 0 and var_303_0 or var_303_0 * (utf8.len(var_303_2) / 30)) > 0 and var_303_0 < var_303_4 then
					arg_300_1.talkMaxDuration = var_303_4

					if var_303_4 + 0 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_4 + 0
					end
				end

				arg_300_1.text_.text = var_303_2
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121072", "story_v_out_425121.awb") ~= 0 then
					local var_303_5 = manager.audio:GetVoiceLength("story_v_out_425121", "425121072", "story_v_out_425121.awb") / 1000

					if var_303_5 + 0 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_5 + 0
					end

					if var_303_1.prefab_name ~= "" and arg_300_1.actors_[var_303_1.prefab_name] ~= nil then
						local var_303_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_300_1.actors_[var_303_1.prefab_name].transform, "story_v_out_425121", "425121072", "story_v_out_425121.awb")

						arg_300_1:RecordAudio("425121072", var_303_6)
						arg_300_1:RecordAudio("425121072", var_303_6)
					else
						arg_300_1:AudioAction("play", "voice", "story_v_out_425121", "425121072", "story_v_out_425121.awb")
					end

					arg_300_1:RecordHistoryTalkVoice("story_v_out_425121", "425121072", "story_v_out_425121.awb")
				end

				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_7 = math.max(var_303_0, arg_300_1.talkMaxDuration)

			if 0 <= arg_300_1.time_ and arg_300_1.time_ < 0 + var_303_7 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - 0) / var_303_7

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= 0 + var_303_7 and arg_300_1.time_ < 0 + var_303_7 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {}

		arg_300_1:InitPlayNodeList()
	end,
	Play425121073 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 425121073
		arg_304_1.duration_ = 19.17

		local var_304_0 = {
			zh = 13.4,
			ja = 19.166
		}
		local var_304_1 = manager.audio:GetLocalizationFlag()

		if var_304_0[var_304_1] ~= nil then
			arg_304_1.duration_ = var_304_0[var_304_1]
		end

		SetActive(arg_304_1.tipsGo_, false)

		function arg_304_1.onSingleLineFinish_()
			arg_304_1.onSingleLineUpdate_ = nil
			arg_304_1.onSingleLineFinish_ = nil
			arg_304_1.state_ = "waiting"
		end

		function arg_304_1.playNext_(arg_306_0)
			if arg_306_0 == 1 then
				arg_304_0:Play425121074(arg_304_1)
			end
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			local var_307_0 = 1.2

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= 0 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0
				arg_304_1.dialogCg_.alpha = 1

				arg_304_1.dialog_:SetActive(true)
				SetActive(arg_304_1.leftNameGo_, true)

				arg_304_1.leftNameTxt_.text = arg_304_1:FormatText(StoryNameCfg[1439].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_304_1.leftNameTxt_.transform)

				arg_304_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_304_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_304_1:RecordName(arg_304_1.leftNameTxt_.text)
				SetActive(arg_304_1.iconTrs_.gameObject, true)
				arg_304_1.iconController_:SetSelectedState("hero")

				arg_304_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpaa")

				arg_304_1.callingController_:SetSelectedState("normal")

				arg_304_1.keyicon_.color = Color.New(1, 1, 1)
				arg_304_1.icon_.color = Color.New(1, 1, 1)

				local var_307_1 = arg_304_1:GetWordFromCfg(425121073)
				local var_307_2 = arg_304_1:FormatText(var_307_1.content)

				arg_304_1.text_.text = var_307_2

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_4 = 48 <= 0 and var_307_0 or var_307_0 * (utf8.len(var_307_2) / 48)

				if (48 <= 0 and var_307_0 or var_307_0 * (utf8.len(var_307_2) / 48)) > 0 and var_307_0 < var_307_4 then
					arg_304_1.talkMaxDuration = var_307_4

					if var_307_4 + 0 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_4 + 0
					end
				end

				arg_304_1.text_.text = var_307_2
				arg_304_1.typewritter.percent = 0

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121073", "story_v_out_425121.awb") ~= 0 then
					local var_307_5 = manager.audio:GetVoiceLength("story_v_out_425121", "425121073", "story_v_out_425121.awb") / 1000

					if var_307_5 + 0 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_5 + 0
					end

					if var_307_1.prefab_name ~= "" and arg_304_1.actors_[var_307_1.prefab_name] ~= nil then
						local var_307_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_304_1.actors_[var_307_1.prefab_name].transform, "story_v_out_425121", "425121073", "story_v_out_425121.awb")

						arg_304_1:RecordAudio("425121073", var_307_6)
						arg_304_1:RecordAudio("425121073", var_307_6)
					else
						arg_304_1:AudioAction("play", "voice", "story_v_out_425121", "425121073", "story_v_out_425121.awb")
					end

					arg_304_1:RecordHistoryTalkVoice("story_v_out_425121", "425121073", "story_v_out_425121.awb")
				end

				arg_304_1:RecordContent(arg_304_1.text_.text)
			end

			local var_307_7 = math.max(var_307_0, arg_304_1.talkMaxDuration)

			if 0 <= arg_304_1.time_ and arg_304_1.time_ < 0 + var_307_7 then
				arg_304_1.typewritter.percent = (arg_304_1.time_ - 0) / var_307_7

				arg_304_1.typewritter:SetDirty()
			end

			if arg_304_1.time_ >= 0 + var_307_7 and arg_304_1.time_ < 0 + var_307_7 + arg_307_0 then
				arg_304_1.typewritter.percent = 1

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(true)
			end
		end

		arg_304_1.nodeConfigList_ = {}

		arg_304_1:InitPlayNodeList()
	end,
	Play425121074 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 425121074
		arg_308_1.duration_ = 5.8

		local var_308_0 = {
			zh = 2.8,
			ja = 5.8
		}
		local var_308_1 = manager.audio:GetLocalizationFlag()

		if var_308_0[var_308_1] ~= nil then
			arg_308_1.duration_ = var_308_0[var_308_1]
		end

		SetActive(arg_308_1.tipsGo_, false)

		function arg_308_1.onSingleLineFinish_()
			arg_308_1.onSingleLineUpdate_ = nil
			arg_308_1.onSingleLineFinish_ = nil
			arg_308_1.state_ = "waiting"
		end

		function arg_308_1.playNext_(arg_310_0)
			if arg_310_0 == 1 then
				arg_308_0:Play425121075(arg_308_1)
			end
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 and not isNil(arg_308_1.actors_["1137"]) and arg_308_1.var_.actorSpriteComps1137 == nil then
				arg_308_1.var_.actorSpriteComps1137 = arg_308_1.actors_["1137"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_311_0 = 0.2

			if 0 <= arg_308_1.time_ and arg_308_1.time_ < 0 + var_311_0 and not isNil(arg_308_1.actors_["1137"]) then
				if arg_308_1.var_.actorSpriteComps1137 then
					for iter_311_0, iter_311_1 in pairs(arg_308_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_311_1 then
							if arg_308_1.isInRecall_ then
								iter_311_1.color = Color.New(Mathf.Lerp(iter_311_1.color.r, arg_308_1.hightColor1.r, (arg_308_1.time_ - 0) / var_311_0), Mathf.Lerp(iter_311_1.color.g, arg_308_1.hightColor1.g, (arg_308_1.time_ - 0) / var_311_0), (Mathf.Lerp(iter_311_1.color.b, arg_308_1.hightColor1.b, (arg_308_1.time_ - 0) / var_311_0)))
							else
								local var_311_1 = Mathf.Lerp(iter_311_1.color.r, 1, (arg_308_1.time_ - 0) / var_311_0)

								iter_311_1.color = Color.New(var_311_1, var_311_1, var_311_1)
							end
						end
					end
				end
			end

			if arg_308_1.time_ >= 0 + var_311_0 and arg_308_1.time_ < 0 + var_311_0 + arg_311_0 and not isNil(arg_308_1.actors_["1137"]) and arg_308_1.var_.actorSpriteComps1137 then
				for iter_311_2, iter_311_3 in pairs(arg_308_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_311_3 then
						iter_311_3.color = arg_308_1.isInRecall_ and (arg_308_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_308_1.var_.actorSpriteComps1137 = nil
			end

			local var_311_2 = arg_308_1.actors_["1137"].transform

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 then
				arg_308_1.var_.moveOldPos1137 = var_311_2.localPosition
				var_311_2.localScale = Vector3.New(1, 1, 1)

				arg_308_1:CheckSpriteTmpPos("1137", 3)

				for iter_311_4 = 0, var_311_2.childCount - 1 do
					local var_311_3 = var_311_2:GetChild(iter_311_4)

					if var_311_3.name == "split_4" or not string.find(var_311_3.name, "split") then
						var_311_3.gameObject:SetActive(true)
					else
						var_311_3.gameObject:SetActive(false)
					end
				end
			end

			local var_311_4 = 0.001

			if 0 <= arg_308_1.time_ and arg_308_1.time_ < 0 + var_311_4 then
				var_311_2.localPosition = Vector3.Lerp(arg_308_1.var_.moveOldPos1137, Vector3.New(0, -425, -200), (arg_308_1.time_ - 0) / var_311_4)
			end

			if arg_308_1.time_ >= 0 + var_311_4 and arg_308_1.time_ < 0 + var_311_4 + arg_311_0 then
				var_311_2.localPosition = Vector3.New(0, -425, -200)
			end

			local var_311_5 = 0
			local var_311_6 = 0.375

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= var_311_5 + arg_311_0 then
				arg_308_1.talkMaxDuration = 0
				arg_308_1.dialogCg_.alpha = 1

				arg_308_1.dialog_:SetActive(true)
				SetActive(arg_308_1.leftNameGo_, true)

				arg_308_1.leftNameTxt_.text = arg_308_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_308_1.leftNameTxt_.transform)

				arg_308_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_308_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_308_1:RecordName(arg_308_1.leftNameTxt_.text)
				SetActive(arg_308_1.iconTrs_.gameObject, false)
				arg_308_1.callingController_:SetSelectedState("normal")

				local var_311_7 = arg_308_1:GetWordFromCfg(425121074)
				local var_311_8 = arg_308_1:FormatText(var_311_7.content)

				arg_308_1.text_.text = var_311_8

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_10 = 15 <= 0 and var_311_6 or var_311_6 * (utf8.len(var_311_8) / 15)

				if (15 <= 0 and var_311_6 or var_311_6 * (utf8.len(var_311_8) / 15)) > 0 and var_311_6 < var_311_10 then
					arg_308_1.talkMaxDuration = var_311_10

					if var_311_10 + var_311_5 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_10 + var_311_5
					end
				end

				arg_308_1.text_.text = var_311_8
				arg_308_1.typewritter.percent = 0

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121074", "story_v_out_425121.awb") ~= 0 then
					local var_311_11 = manager.audio:GetVoiceLength("story_v_out_425121", "425121074", "story_v_out_425121.awb") / 1000

					if var_311_11 + var_311_5 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_11 + var_311_5
					end

					if var_311_7.prefab_name ~= "" and arg_308_1.actors_[var_311_7.prefab_name] ~= nil then
						local var_311_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_308_1.actors_[var_311_7.prefab_name].transform, "story_v_out_425121", "425121074", "story_v_out_425121.awb")

						arg_308_1:RecordAudio("425121074", var_311_12)
						arg_308_1:RecordAudio("425121074", var_311_12)
					else
						arg_308_1:AudioAction("play", "voice", "story_v_out_425121", "425121074", "story_v_out_425121.awb")
					end

					arg_308_1:RecordHistoryTalkVoice("story_v_out_425121", "425121074", "story_v_out_425121.awb")
				end

				arg_308_1:RecordContent(arg_308_1.text_.text)
			end

			local var_311_13 = math.max(var_311_6, arg_308_1.talkMaxDuration)

			if var_311_5 <= arg_308_1.time_ and arg_308_1.time_ < var_311_5 + var_311_13 then
				arg_308_1.typewritter.percent = (arg_308_1.time_ - var_311_5) / var_311_13

				arg_308_1.typewritter:SetDirty()
			end

			if arg_308_1.time_ >= var_311_5 + var_311_13 and arg_308_1.time_ < var_311_5 + var_311_13 + arg_311_0 then
				arg_308_1.typewritter.percent = 1

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(true)
			end
		end

		arg_308_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1137",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_308_1:InitPlayNodeList()
	end,
	Play425121075 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 425121075
		arg_312_1.duration_ = 5

		SetActive(arg_312_1.tipsGo_, false)

		function arg_312_1.onSingleLineFinish_()
			arg_312_1.onSingleLineUpdate_ = nil
			arg_312_1.onSingleLineFinish_ = nil
			arg_312_1.state_ = "waiting"
		end

		function arg_312_1.playNext_(arg_314_0)
			if arg_314_0 == 1 then
				arg_312_0:Play425121076(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 and not isNil(arg_312_1.actors_["1137"]) and arg_312_1.var_.actorSpriteComps1137 == nil then
				arg_312_1.var_.actorSpriteComps1137 = arg_312_1.actors_["1137"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_315_0 = 0.2

			if 0 <= arg_312_1.time_ and arg_312_1.time_ < 0 + var_315_0 and not isNil(arg_312_1.actors_["1137"]) then
				if arg_312_1.var_.actorSpriteComps1137 then
					for iter_315_0, iter_315_1 in pairs(arg_312_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_315_1 then
							if arg_312_1.isInRecall_ then
								iter_315_1.color = Color.New(Mathf.Lerp(iter_315_1.color.r, arg_312_1.hightColor2.r, (arg_312_1.time_ - 0) / var_315_0), Mathf.Lerp(iter_315_1.color.g, arg_312_1.hightColor2.g, (arg_312_1.time_ - 0) / var_315_0), (Mathf.Lerp(iter_315_1.color.b, arg_312_1.hightColor2.b, (arg_312_1.time_ - 0) / var_315_0)))
							else
								local var_315_1 = Mathf.Lerp(iter_315_1.color.r, 0.5, (arg_312_1.time_ - 0) / var_315_0)

								iter_315_1.color = Color.New(var_315_1, var_315_1, var_315_1)
							end
						end
					end
				end
			end

			if arg_312_1.time_ >= 0 + var_315_0 and arg_312_1.time_ < 0 + var_315_0 + arg_315_0 and not isNil(arg_312_1.actors_["1137"]) and arg_312_1.var_.actorSpriteComps1137 then
				for iter_315_2, iter_315_3 in pairs(arg_312_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_315_3 then
						iter_315_3.color = arg_312_1.isInRecall_ and (arg_312_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_312_1.var_.actorSpriteComps1137 = nil
			end

			local var_315_2 = arg_312_1.actors_["1137"].transform

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 then
				arg_312_1.var_.moveOldPos1137 = var_315_2.localPosition
				var_315_2.localScale = Vector3.New(1, 1, 1)

				arg_312_1:CheckSpriteTmpPos("1137", 7)

				for iter_315_4 = 0, var_315_2.childCount - 1 do
					local var_315_3 = var_315_2:GetChild(iter_315_4)

					if var_315_3.name == "" or not string.find(var_315_3.name, "split") then
						var_315_3.gameObject:SetActive(true)
					else
						var_315_3.gameObject:SetActive(false)
					end
				end
			end

			local var_315_4 = 0.001

			if 0 <= arg_312_1.time_ and arg_312_1.time_ < 0 + var_315_4 then
				var_315_2.localPosition = Vector3.Lerp(arg_312_1.var_.moveOldPos1137, Vector3.New(0, -2000, 0), (arg_312_1.time_ - 0) / var_315_4)
			end

			if arg_312_1.time_ >= 0 + var_315_4 and arg_312_1.time_ < 0 + var_315_4 + arg_315_0 then
				var_315_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_315_5 = 0
			local var_315_6 = 0.85

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= var_315_5 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0
				arg_312_1.dialogCg_.alpha = 1

				arg_312_1.dialog_:SetActive(true)
				SetActive(arg_312_1.leftNameGo_, false)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_312_1.iconTrs_.gameObject, false)
				arg_312_1.callingController_:SetSelectedState("normal")

				local var_315_7 = arg_312_1:FormatText(arg_312_1:GetWordFromCfg(425121075).content)

				arg_312_1.text_.text = var_315_7

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_9 = 34 <= 0 and var_315_6 or var_315_6 * (utf8.len(var_315_7) / 34)

				if (34 <= 0 and var_315_6 or var_315_6 * (utf8.len(var_315_7) / 34)) > 0 and var_315_6 < var_315_9 then
					arg_312_1.talkMaxDuration = var_315_9

					if var_315_9 + var_315_5 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_9 + var_315_5
					end
				end

				arg_312_1.text_.text = var_315_7
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)
				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_10 = math.max(var_315_6, arg_312_1.talkMaxDuration)

			if var_315_5 <= arg_312_1.time_ and arg_312_1.time_ < var_315_5 + var_315_10 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - var_315_5) / var_315_10

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= var_315_5 + var_315_10 and arg_312_1.time_ < var_315_5 + var_315_10 + arg_315_0 then
				arg_312_1.typewritter.percent = 1

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(true)
			end
		end

		arg_312_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1137",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_312_1:InitPlayNodeList()
	end,
	Play425121076 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 425121076
		arg_316_1.duration_ = 3.63

		local var_316_0 = {
			zh = 3.633,
			ja = 3.5
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
				arg_316_0:Play425121077(arg_316_1)
			end
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			local var_319_0 = 0.225

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= 0 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0
				arg_316_1.dialogCg_.alpha = 1

				arg_316_1.dialog_:SetActive(true)
				SetActive(arg_316_1.leftNameGo_, true)

				arg_316_1.leftNameTxt_.text = arg_316_1:FormatText(StoryNameCfg[1439].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_316_1.leftNameTxt_.transform)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1.leftNameTxt_.text)
				SetActive(arg_316_1.iconTrs_.gameObject, true)
				arg_316_1.iconController_:SetSelectedState("hero")

				arg_316_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpaa")

				arg_316_1.callingController_:SetSelectedState("normal")

				arg_316_1.keyicon_.color = Color.New(1, 1, 1)
				arg_316_1.icon_.color = Color.New(1, 1, 1)

				local var_319_1 = arg_316_1:GetWordFromCfg(425121076)
				local var_319_2 = arg_316_1:FormatText(var_319_1.content)

				arg_316_1.text_.text = var_319_2

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_4 = 9 <= 0 and var_319_0 or var_319_0 * (utf8.len(var_319_2) / 9)

				if (9 <= 0 and var_319_0 or var_319_0 * (utf8.len(var_319_2) / 9)) > 0 and var_319_0 < var_319_4 then
					arg_316_1.talkMaxDuration = var_319_4

					if var_319_4 + 0 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_4 + 0
					end
				end

				arg_316_1.text_.text = var_319_2
				arg_316_1.typewritter.percent = 0

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121076", "story_v_out_425121.awb") ~= 0 then
					local var_319_5 = manager.audio:GetVoiceLength("story_v_out_425121", "425121076", "story_v_out_425121.awb") / 1000

					if var_319_5 + 0 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_5 + 0
					end

					if var_319_1.prefab_name ~= "" and arg_316_1.actors_[var_319_1.prefab_name] ~= nil then
						local var_319_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_316_1.actors_[var_319_1.prefab_name].transform, "story_v_out_425121", "425121076", "story_v_out_425121.awb")

						arg_316_1:RecordAudio("425121076", var_319_6)
						arg_316_1:RecordAudio("425121076", var_319_6)
					else
						arg_316_1:AudioAction("play", "voice", "story_v_out_425121", "425121076", "story_v_out_425121.awb")
					end

					arg_316_1:RecordHistoryTalkVoice("story_v_out_425121", "425121076", "story_v_out_425121.awb")
				end

				arg_316_1:RecordContent(arg_316_1.text_.text)
			end

			local var_319_7 = math.max(var_319_0, arg_316_1.talkMaxDuration)

			if 0 <= arg_316_1.time_ and arg_316_1.time_ < 0 + var_319_7 then
				arg_316_1.typewritter.percent = (arg_316_1.time_ - 0) / var_319_7

				arg_316_1.typewritter:SetDirty()
			end

			if arg_316_1.time_ >= 0 + var_319_7 and arg_316_1.time_ < 0 + var_319_7 + arg_319_0 then
				arg_316_1.typewritter.percent = 1

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(true)
			end
		end

		arg_316_1.nodeConfigList_ = {}

		arg_316_1:InitPlayNodeList()
	end,
	Play425121077 = function(arg_320_0, arg_320_1)
		arg_320_1.time_ = 0
		arg_320_1.frameCnt_ = 0
		arg_320_1.state_ = "playing"
		arg_320_1.curTalkId_ = 425121077
		arg_320_1.duration_ = 5

		SetActive(arg_320_1.tipsGo_, false)

		function arg_320_1.onSingleLineFinish_()
			arg_320_1.onSingleLineUpdate_ = nil
			arg_320_1.onSingleLineFinish_ = nil
			arg_320_1.state_ = "waiting"
		end

		function arg_320_1.playNext_(arg_322_0)
			if arg_322_0 == 1 then
				arg_320_0:Play425121078(arg_320_1)
			end
		end

		function arg_320_1.onSingleLineUpdate_(arg_323_0)
			local var_323_9000

			if 0.133333333333333 < arg_320_1.time_ and arg_320_1.time_ <= 0.133333333333333 + arg_323_0 then
				arg_320_1:AudioAction("play", "effect", "se_story_122_01", "se_story_122_01_beep", "")
			end

			if 0 < arg_320_1.time_ and arg_320_1.time_ <= 0 + arg_323_0 then
				local var_323_1 = arg_320_1.var_.effect1077

				if not arg_320_1.var_.effect1077 then
					var_323_1 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_redlight_keep"), manager.ui.mainCamera.transform)
					var_323_1.name = "1077"
					arg_320_1.var_.effect1077 = var_323_1
				else
					var_323_1.transform:SetParent(var_323_9000)
				end

				var_323_1.transform.localPosition = Vector3.New(0, 0, 0)
				var_323_1.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_323_1.transform.localScale = Vector3.New(var_323_1.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_323_1.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_323_1.transform.localScale.z)
			end

			if 1.73333333333333 < arg_320_1.time_ and arg_320_1.time_ <= 1.73333333333333 + arg_323_0 then
				if arg_320_1.var_.effect1077 then
					Object.Destroy(arg_320_1.var_.effect1077)

					arg_320_1.var_.effect1077 = nil
				end
			end

			local var_323_4 = 0
			local var_323_5 = 1.05

			if 0 < arg_320_1.time_ and arg_320_1.time_ <= var_323_4 + arg_323_0 then
				arg_320_1.talkMaxDuration = 0
				arg_320_1.dialogCg_.alpha = 1

				arg_320_1.dialog_:SetActive(true)
				SetActive(arg_320_1.leftNameGo_, false)

				arg_320_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_320_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_320_1:RecordName(arg_320_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_320_1.iconTrs_.gameObject, false)
				arg_320_1.callingController_:SetSelectedState("normal")

				local var_323_6 = arg_320_1:FormatText(arg_320_1:GetWordFromCfg(425121077).content)

				arg_320_1.text_.text = var_323_6

				LuaForUtil.ClearLinePrefixSymbol(arg_320_1.text_)

				local var_323_8 = 42 <= 0 and var_323_5 or var_323_5 * (utf8.len(var_323_6) / 42)

				if (42 <= 0 and var_323_5 or var_323_5 * (utf8.len(var_323_6) / 42)) > 0 and var_323_5 < var_323_8 then
					arg_320_1.talkMaxDuration = var_323_8

					if var_323_8 + var_323_4 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_8 + var_323_4
					end
				end

				arg_320_1.text_.text = var_323_6
				arg_320_1.typewritter.percent = 0

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(false)
				arg_320_1:RecordContent(arg_320_1.text_.text)
			end

			local var_323_9 = math.max(var_323_5, arg_320_1.talkMaxDuration)

			if var_323_4 <= arg_320_1.time_ and arg_320_1.time_ < var_323_4 + var_323_9 then
				arg_320_1.typewritter.percent = (arg_320_1.time_ - var_323_4) / var_323_9

				arg_320_1.typewritter:SetDirty()
			end

			if arg_320_1.time_ >= var_323_4 + var_323_9 and arg_320_1.time_ < var_323_4 + var_323_9 + arg_323_0 then
				arg_320_1.typewritter.percent = 1

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(true)
			end
		end

		arg_320_1.nodeConfigList_ = {}

		arg_320_1:InitPlayNodeList()
	end,
	Play425121078 = function(arg_324_0, arg_324_1)
		arg_324_1.time_ = 0
		arg_324_1.frameCnt_ = 0
		arg_324_1.state_ = "playing"
		arg_324_1.curTalkId_ = 425121078
		arg_324_1.duration_ = 1.47

		local var_324_0 = {
			zh = 0.999999999999,
			ja = 1.466
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
				arg_324_0:Play425121079(arg_324_1)
			end
		end

		function arg_324_1.onSingleLineUpdate_(arg_327_0)
			if 0 < arg_324_1.time_ and arg_324_1.time_ <= 0 + arg_327_0 and not isNil(arg_324_1.actors_["1137"]) and arg_324_1.var_.actorSpriteComps1137 == nil then
				arg_324_1.var_.actorSpriteComps1137 = arg_324_1.actors_["1137"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_327_0 = 0.2

			if 0 <= arg_324_1.time_ and arg_324_1.time_ < 0 + var_327_0 and not isNil(arg_324_1.actors_["1137"]) then
				if arg_324_1.var_.actorSpriteComps1137 then
					for iter_327_0, iter_327_1 in pairs(arg_324_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_327_1 then
							if arg_324_1.isInRecall_ then
								iter_327_1.color = Color.New(Mathf.Lerp(iter_327_1.color.r, arg_324_1.hightColor1.r, (arg_324_1.time_ - 0) / var_327_0), Mathf.Lerp(iter_327_1.color.g, arg_324_1.hightColor1.g, (arg_324_1.time_ - 0) / var_327_0), (Mathf.Lerp(iter_327_1.color.b, arg_324_1.hightColor1.b, (arg_324_1.time_ - 0) / var_327_0)))
							else
								local var_327_1 = Mathf.Lerp(iter_327_1.color.r, 1, (arg_324_1.time_ - 0) / var_327_0)

								iter_327_1.color = Color.New(var_327_1, var_327_1, var_327_1)
							end
						end
					end
				end
			end

			if arg_324_1.time_ >= 0 + var_327_0 and arg_324_1.time_ < 0 + var_327_0 + arg_327_0 and not isNil(arg_324_1.actors_["1137"]) and arg_324_1.var_.actorSpriteComps1137 then
				for iter_327_2, iter_327_3 in pairs(arg_324_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_327_3 then
						iter_327_3.color = arg_324_1.isInRecall_ and (arg_324_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_324_1.var_.actorSpriteComps1137 = nil
			end

			local var_327_2 = arg_324_1.actors_["1137"].transform

			if 0 < arg_324_1.time_ and arg_324_1.time_ <= 0 + arg_327_0 then
				arg_324_1.var_.moveOldPos1137 = var_327_2.localPosition
				var_327_2.localScale = Vector3.New(1, 1, 1)

				arg_324_1:CheckSpriteTmpPos("1137", 3)

				for iter_327_4 = 0, var_327_2.childCount - 1 do
					local var_327_3 = var_327_2:GetChild(iter_327_4)

					if var_327_3.name == "split_6" or not string.find(var_327_3.name, "split") then
						var_327_3.gameObject:SetActive(true)
					else
						var_327_3.gameObject:SetActive(false)
					end
				end
			end

			local var_327_4 = 0.001

			if 0 <= arg_324_1.time_ and arg_324_1.time_ < 0 + var_327_4 then
				var_327_2.localPosition = Vector3.Lerp(arg_324_1.var_.moveOldPos1137, Vector3.New(0, -425, -200), (arg_324_1.time_ - 0) / var_327_4)
			end

			if arg_324_1.time_ >= 0 + var_327_4 and arg_324_1.time_ < 0 + var_327_4 + arg_327_0 then
				var_327_2.localPosition = Vector3.New(0, -425, -200)
			end

			if 0 < arg_324_1.time_ and arg_324_1.time_ <= 0 + arg_327_0 then
				if arg_324_1.var_.effect1077 then
					Object.Destroy(arg_324_1.var_.effect1077)

					arg_324_1.var_.effect1077 = nil
				end
			end

			local var_327_6 = 0
			local var_327_7 = 0.075

			if 0 < arg_324_1.time_ and arg_324_1.time_ <= var_327_6 + arg_327_0 then
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

				local var_327_8 = arg_324_1:GetWordFromCfg(425121078)
				local var_327_9 = arg_324_1:FormatText(var_327_8.content)

				arg_324_1.text_.text = var_327_9

				LuaForUtil.ClearLinePrefixSymbol(arg_324_1.text_)

				local var_327_11 = 3 <= 0 and var_327_7 or var_327_7 * (utf8.len(var_327_9) / 3)

				if (3 <= 0 and var_327_7 or var_327_7 * (utf8.len(var_327_9) / 3)) > 0 and var_327_7 < var_327_11 then
					arg_324_1.talkMaxDuration = var_327_11

					if var_327_11 + var_327_6 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_11 + var_327_6
					end
				end

				arg_324_1.text_.text = var_327_9
				arg_324_1.typewritter.percent = 0

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121078", "story_v_out_425121.awb") ~= 0 then
					local var_327_12 = manager.audio:GetVoiceLength("story_v_out_425121", "425121078", "story_v_out_425121.awb") / 1000

					if var_327_12 + var_327_6 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_12 + var_327_6
					end

					if var_327_8.prefab_name ~= "" and arg_324_1.actors_[var_327_8.prefab_name] ~= nil then
						local var_327_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_324_1.actors_[var_327_8.prefab_name].transform, "story_v_out_425121", "425121078", "story_v_out_425121.awb")

						arg_324_1:RecordAudio("425121078", var_327_13)
						arg_324_1:RecordAudio("425121078", var_327_13)
					else
						arg_324_1:AudioAction("play", "voice", "story_v_out_425121", "425121078", "story_v_out_425121.awb")
					end

					arg_324_1:RecordHistoryTalkVoice("story_v_out_425121", "425121078", "story_v_out_425121.awb")
				end

				arg_324_1:RecordContent(arg_324_1.text_.text)
			end

			local var_327_14 = math.max(var_327_7, arg_324_1.talkMaxDuration)

			if var_327_6 <= arg_324_1.time_ and arg_324_1.time_ < var_327_6 + var_327_14 then
				arg_324_1.typewritter.percent = (arg_324_1.time_ - var_327_6) / var_327_14

				arg_324_1.typewritter:SetDirty()
			end

			if arg_324_1.time_ >= var_327_6 + var_327_14 and arg_324_1.time_ < var_327_6 + var_327_14 + arg_327_0 then
				arg_324_1.typewritter.percent = 1

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(true)
			end
		end

		arg_324_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1137",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_324_1:InitPlayNodeList()
	end,
	Play425121079 = function(arg_328_0, arg_328_1)
		arg_328_1.time_ = 0
		arg_328_1.frameCnt_ = 0
		arg_328_1.state_ = "playing"
		arg_328_1.curTalkId_ = 425121079
		arg_328_1.duration_ = 5

		SetActive(arg_328_1.tipsGo_, false)

		function arg_328_1.onSingleLineFinish_()
			arg_328_1.onSingleLineUpdate_ = nil
			arg_328_1.onSingleLineFinish_ = nil
			arg_328_1.state_ = "waiting"
		end

		function arg_328_1.playNext_(arg_330_0)
			if arg_330_0 == 1 then
				arg_328_0:Play425121080(arg_328_1)
			end
		end

		function arg_328_1.onSingleLineUpdate_(arg_331_0)
			if 0 < arg_328_1.time_ and arg_328_1.time_ <= 0 + arg_331_0 and not isNil(arg_328_1.actors_["1137"]) and arg_328_1.var_.actorSpriteComps1137 == nil then
				arg_328_1.var_.actorSpriteComps1137 = arg_328_1.actors_["1137"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_331_0 = 0.2

			if 0 <= arg_328_1.time_ and arg_328_1.time_ < 0 + var_331_0 and not isNil(arg_328_1.actors_["1137"]) then
				if arg_328_1.var_.actorSpriteComps1137 then
					for iter_331_0, iter_331_1 in pairs(arg_328_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_331_1 then
							if arg_328_1.isInRecall_ then
								iter_331_1.color = Color.New(Mathf.Lerp(iter_331_1.color.r, arg_328_1.hightColor2.r, (arg_328_1.time_ - 0) / var_331_0), Mathf.Lerp(iter_331_1.color.g, arg_328_1.hightColor2.g, (arg_328_1.time_ - 0) / var_331_0), (Mathf.Lerp(iter_331_1.color.b, arg_328_1.hightColor2.b, (arg_328_1.time_ - 0) / var_331_0)))
							else
								local var_331_1 = Mathf.Lerp(iter_331_1.color.r, 0.5, (arg_328_1.time_ - 0) / var_331_0)

								iter_331_1.color = Color.New(var_331_1, var_331_1, var_331_1)
							end
						end
					end
				end
			end

			if arg_328_1.time_ >= 0 + var_331_0 and arg_328_1.time_ < 0 + var_331_0 + arg_331_0 and not isNil(arg_328_1.actors_["1137"]) and arg_328_1.var_.actorSpriteComps1137 then
				for iter_331_2, iter_331_3 in pairs(arg_328_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_331_3 then
						iter_331_3.color = arg_328_1.isInRecall_ and (arg_328_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_328_1.var_.actorSpriteComps1137 = nil
			end

			local var_331_2 = arg_328_1.actors_["1137"].transform

			if 0 < arg_328_1.time_ and arg_328_1.time_ <= 0 + arg_331_0 then
				arg_328_1.var_.moveOldPos1137 = var_331_2.localPosition
				var_331_2.localScale = Vector3.New(1, 1, 1)

				arg_328_1:CheckSpriteTmpPos("1137", 7)

				for iter_331_4 = 0, var_331_2.childCount - 1 do
					local var_331_3 = var_331_2:GetChild(iter_331_4)

					if var_331_3.name == "" or not string.find(var_331_3.name, "split") then
						var_331_3.gameObject:SetActive(true)
					else
						var_331_3.gameObject:SetActive(false)
					end
				end
			end

			local var_331_4 = 0.001

			if 0 <= arg_328_1.time_ and arg_328_1.time_ < 0 + var_331_4 then
				var_331_2.localPosition = Vector3.Lerp(arg_328_1.var_.moveOldPos1137, Vector3.New(0, -2000, 0), (arg_328_1.time_ - 0) / var_331_4)
			end

			if arg_328_1.time_ >= 0 + var_331_4 and arg_328_1.time_ < 0 + var_331_4 + arg_331_0 then
				var_331_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_331_5 = 0
			local var_331_6 = 0.75

			if 0 < arg_328_1.time_ and arg_328_1.time_ <= var_331_5 + arg_331_0 then
				arg_328_1.talkMaxDuration = 0
				arg_328_1.dialogCg_.alpha = 1

				arg_328_1.dialog_:SetActive(true)
				SetActive(arg_328_1.leftNameGo_, false)

				arg_328_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_328_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_328_1:RecordName(arg_328_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_328_1.iconTrs_.gameObject, false)
				arg_328_1.callingController_:SetSelectedState("normal")

				local var_331_7 = arg_328_1:FormatText(arg_328_1:GetWordFromCfg(425121079).content)

				arg_328_1.text_.text = var_331_7

				LuaForUtil.ClearLinePrefixSymbol(arg_328_1.text_)

				local var_331_9 = 30 <= 0 and var_331_6 or var_331_6 * (utf8.len(var_331_7) / 30)

				if (30 <= 0 and var_331_6 or var_331_6 * (utf8.len(var_331_7) / 30)) > 0 and var_331_6 < var_331_9 then
					arg_328_1.talkMaxDuration = var_331_9

					if var_331_9 + var_331_5 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_9 + var_331_5
					end
				end

				arg_328_1.text_.text = var_331_7
				arg_328_1.typewritter.percent = 0

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(false)
				arg_328_1:RecordContent(arg_328_1.text_.text)
			end

			local var_331_10 = math.max(var_331_6, arg_328_1.talkMaxDuration)

			if var_331_5 <= arg_328_1.time_ and arg_328_1.time_ < var_331_5 + var_331_10 then
				arg_328_1.typewritter.percent = (arg_328_1.time_ - var_331_5) / var_331_10

				arg_328_1.typewritter:SetDirty()
			end

			if arg_328_1.time_ >= var_331_5 + var_331_10 and arg_328_1.time_ < var_331_5 + var_331_10 + arg_331_0 then
				arg_328_1.typewritter.percent = 1

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(true)
			end
		end

		arg_328_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1137",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_328_1:InitPlayNodeList()
	end,
	Play425121080 = function(arg_332_0, arg_332_1)
		arg_332_1.time_ = 0
		arg_332_1.frameCnt_ = 0
		arg_332_1.state_ = "playing"
		arg_332_1.curTalkId_ = 425121080
		arg_332_1.duration_ = 6.87

		local var_332_0 = {
			zh = 4.966,
			ja = 6.866
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
				arg_332_0:Play425121081(arg_332_1)
			end
		end

		function arg_332_1.onSingleLineUpdate_(arg_335_0)
			local var_335_0 = 0.425

			if 0 < arg_332_1.time_ and arg_332_1.time_ <= 0 + arg_335_0 then
				arg_332_1.talkMaxDuration = 0
				arg_332_1.dialogCg_.alpha = 1

				arg_332_1.dialog_:SetActive(true)
				SetActive(arg_332_1.leftNameGo_, true)

				arg_332_1.leftNameTxt_.text = arg_332_1:FormatText(StoryNameCfg[1439].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_332_1.leftNameTxt_.transform)

				arg_332_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_332_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_332_1:RecordName(arg_332_1.leftNameTxt_.text)
				SetActive(arg_332_1.iconTrs_.gameObject, true)
				arg_332_1.iconController_:SetSelectedState("hero")

				arg_332_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpaa")

				arg_332_1.callingController_:SetSelectedState("normal")

				arg_332_1.keyicon_.color = Color.New(1, 1, 1)
				arg_332_1.icon_.color = Color.New(1, 1, 1)

				local var_335_1 = arg_332_1:GetWordFromCfg(425121080)
				local var_335_2 = arg_332_1:FormatText(var_335_1.content)

				arg_332_1.text_.text = var_335_2

				LuaForUtil.ClearLinePrefixSymbol(arg_332_1.text_)

				local var_335_4 = 17 <= 0 and var_335_0 or var_335_0 * (utf8.len(var_335_2) / 17)

				if (17 <= 0 and var_335_0 or var_335_0 * (utf8.len(var_335_2) / 17)) > 0 and var_335_0 < var_335_4 then
					arg_332_1.talkMaxDuration = var_335_4

					if var_335_4 + 0 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_4 + 0
					end
				end

				arg_332_1.text_.text = var_335_2
				arg_332_1.typewritter.percent = 0

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121080", "story_v_out_425121.awb") ~= 0 then
					local var_335_5 = manager.audio:GetVoiceLength("story_v_out_425121", "425121080", "story_v_out_425121.awb") / 1000

					if var_335_5 + 0 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_5 + 0
					end

					if var_335_1.prefab_name ~= "" and arg_332_1.actors_[var_335_1.prefab_name] ~= nil then
						local var_335_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_332_1.actors_[var_335_1.prefab_name].transform, "story_v_out_425121", "425121080", "story_v_out_425121.awb")

						arg_332_1:RecordAudio("425121080", var_335_6)
						arg_332_1:RecordAudio("425121080", var_335_6)
					else
						arg_332_1:AudioAction("play", "voice", "story_v_out_425121", "425121080", "story_v_out_425121.awb")
					end

					arg_332_1:RecordHistoryTalkVoice("story_v_out_425121", "425121080", "story_v_out_425121.awb")
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
	Play425121081 = function(arg_336_0, arg_336_1)
		arg_336_1.time_ = 0
		arg_336_1.frameCnt_ = 0
		arg_336_1.state_ = "playing"
		arg_336_1.curTalkId_ = 425121081
		arg_336_1.duration_ = 4.27

		local var_336_0 = {
			zh = 2.8,
			ja = 4.266
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
				arg_336_0:Play425121082(arg_336_1)
			end
		end

		function arg_336_1.onSingleLineUpdate_(arg_339_0)
			if 0 < arg_336_1.time_ and arg_336_1.time_ <= 0 + arg_339_0 and not isNil(arg_336_1.actors_["1137"]) and arg_336_1.var_.actorSpriteComps1137 == nil then
				arg_336_1.var_.actorSpriteComps1137 = arg_336_1.actors_["1137"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_339_0 = 0.2

			if 0 <= arg_336_1.time_ and arg_336_1.time_ < 0 + var_339_0 and not isNil(arg_336_1.actors_["1137"]) then
				if arg_336_1.var_.actorSpriteComps1137 then
					for iter_339_0, iter_339_1 in pairs(arg_336_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_339_1 then
							if arg_336_1.isInRecall_ then
								iter_339_1.color = Color.New(Mathf.Lerp(iter_339_1.color.r, arg_336_1.hightColor1.r, (arg_336_1.time_ - 0) / var_339_0), Mathf.Lerp(iter_339_1.color.g, arg_336_1.hightColor1.g, (arg_336_1.time_ - 0) / var_339_0), (Mathf.Lerp(iter_339_1.color.b, arg_336_1.hightColor1.b, (arg_336_1.time_ - 0) / var_339_0)))
							else
								local var_339_1 = Mathf.Lerp(iter_339_1.color.r, 1, (arg_336_1.time_ - 0) / var_339_0)

								iter_339_1.color = Color.New(var_339_1, var_339_1, var_339_1)
							end
						end
					end
				end
			end

			if arg_336_1.time_ >= 0 + var_339_0 and arg_336_1.time_ < 0 + var_339_0 + arg_339_0 and not isNil(arg_336_1.actors_["1137"]) and arg_336_1.var_.actorSpriteComps1137 then
				for iter_339_2, iter_339_3 in pairs(arg_336_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_339_3 then
						iter_339_3.color = arg_336_1.isInRecall_ and (arg_336_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_336_1.var_.actorSpriteComps1137 = nil
			end

			local var_339_2 = arg_336_1.actors_["1137"].transform

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= 0 + arg_339_0 then
				arg_336_1.var_.moveOldPos1137 = var_339_2.localPosition
				var_339_2.localScale = Vector3.New(1, 1, 1)

				arg_336_1:CheckSpriteTmpPos("1137", 3)

				for iter_339_4 = 0, var_339_2.childCount - 1 do
					local var_339_3 = var_339_2:GetChild(iter_339_4)

					if var_339_3.name == "split_6" or not string.find(var_339_3.name, "split") then
						var_339_3.gameObject:SetActive(true)
					else
						var_339_3.gameObject:SetActive(false)
					end
				end
			end

			local var_339_4 = 0.001

			if 0 <= arg_336_1.time_ and arg_336_1.time_ < 0 + var_339_4 then
				var_339_2.localPosition = Vector3.Lerp(arg_336_1.var_.moveOldPos1137, Vector3.New(0, -425, -200), (arg_336_1.time_ - 0) / var_339_4)
			end

			if arg_336_1.time_ >= 0 + var_339_4 and arg_336_1.time_ < 0 + var_339_4 + arg_339_0 then
				var_339_2.localPosition = Vector3.New(0, -425, -200)
			end

			local var_339_5 = 0
			local var_339_6 = 0.35

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= var_339_5 + arg_339_0 then
				arg_336_1.talkMaxDuration = 0
				arg_336_1.dialogCg_.alpha = 1

				arg_336_1.dialog_:SetActive(true)
				SetActive(arg_336_1.leftNameGo_, true)

				arg_336_1.leftNameTxt_.text = arg_336_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_336_1.leftNameTxt_.transform)

				arg_336_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_336_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_336_1:RecordName(arg_336_1.leftNameTxt_.text)
				SetActive(arg_336_1.iconTrs_.gameObject, false)
				arg_336_1.callingController_:SetSelectedState("normal")

				local var_339_7 = arg_336_1:GetWordFromCfg(425121081)
				local var_339_8 = arg_336_1:FormatText(var_339_7.content)

				arg_336_1.text_.text = var_339_8

				LuaForUtil.ClearLinePrefixSymbol(arg_336_1.text_)

				local var_339_10 = 14 <= 0 and var_339_6 or var_339_6 * (utf8.len(var_339_8) / 14)

				if (14 <= 0 and var_339_6 or var_339_6 * (utf8.len(var_339_8) / 14)) > 0 and var_339_6 < var_339_10 then
					arg_336_1.talkMaxDuration = var_339_10

					if var_339_10 + var_339_5 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_10 + var_339_5
					end
				end

				arg_336_1.text_.text = var_339_8
				arg_336_1.typewritter.percent = 0

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121081", "story_v_out_425121.awb") ~= 0 then
					local var_339_11 = manager.audio:GetVoiceLength("story_v_out_425121", "425121081", "story_v_out_425121.awb") / 1000

					if var_339_11 + var_339_5 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_11 + var_339_5
					end

					if var_339_7.prefab_name ~= "" and arg_336_1.actors_[var_339_7.prefab_name] ~= nil then
						local var_339_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_336_1.actors_[var_339_7.prefab_name].transform, "story_v_out_425121", "425121081", "story_v_out_425121.awb")

						arg_336_1:RecordAudio("425121081", var_339_12)
						arg_336_1:RecordAudio("425121081", var_339_12)
					else
						arg_336_1:AudioAction("play", "voice", "story_v_out_425121", "425121081", "story_v_out_425121.awb")
					end

					arg_336_1:RecordHistoryTalkVoice("story_v_out_425121", "425121081", "story_v_out_425121.awb")
				end

				arg_336_1:RecordContent(arg_336_1.text_.text)
			end

			local var_339_13 = math.max(var_339_6, arg_336_1.talkMaxDuration)

			if var_339_5 <= arg_336_1.time_ and arg_336_1.time_ < var_339_5 + var_339_13 then
				arg_336_1.typewritter.percent = (arg_336_1.time_ - var_339_5) / var_339_13

				arg_336_1.typewritter:SetDirty()
			end

			if arg_336_1.time_ >= var_339_5 + var_339_13 and arg_336_1.time_ < var_339_5 + var_339_13 + arg_339_0 then
				arg_336_1.typewritter.percent = 1

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(true)
			end
		end

		arg_336_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1137",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_336_1:InitPlayNodeList()
	end,
	Play425121082 = function(arg_340_0, arg_340_1)
		arg_340_1.time_ = 0
		arg_340_1.frameCnt_ = 0
		arg_340_1.state_ = "playing"
		arg_340_1.curTalkId_ = 425121082
		arg_340_1.duration_ = 5

		SetActive(arg_340_1.tipsGo_, false)

		function arg_340_1.onSingleLineFinish_()
			arg_340_1.onSingleLineUpdate_ = nil
			arg_340_1.onSingleLineFinish_ = nil
			arg_340_1.state_ = "waiting"
		end

		function arg_340_1.playNext_(arg_342_0)
			if arg_342_0 == 1 then
				arg_340_0:Play425121083(arg_340_1)
			end
		end

		function arg_340_1.onSingleLineUpdate_(arg_343_0)
			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 and not isNil(arg_340_1.actors_["1137"]) and arg_340_1.var_.actorSpriteComps1137 == nil then
				arg_340_1.var_.actorSpriteComps1137 = arg_340_1.actors_["1137"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_343_0 = 0.2

			if 0 <= arg_340_1.time_ and arg_340_1.time_ < 0 + var_343_0 and not isNil(arg_340_1.actors_["1137"]) then
				if arg_340_1.var_.actorSpriteComps1137 then
					for iter_343_0, iter_343_1 in pairs(arg_340_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_343_1 then
							if arg_340_1.isInRecall_ then
								iter_343_1.color = Color.New(Mathf.Lerp(iter_343_1.color.r, arg_340_1.hightColor2.r, (arg_340_1.time_ - 0) / var_343_0), Mathf.Lerp(iter_343_1.color.g, arg_340_1.hightColor2.g, (arg_340_1.time_ - 0) / var_343_0), (Mathf.Lerp(iter_343_1.color.b, arg_340_1.hightColor2.b, (arg_340_1.time_ - 0) / var_343_0)))
							else
								local var_343_1 = Mathf.Lerp(iter_343_1.color.r, 0.5, (arg_340_1.time_ - 0) / var_343_0)

								iter_343_1.color = Color.New(var_343_1, var_343_1, var_343_1)
							end
						end
					end
				end
			end

			if arg_340_1.time_ >= 0 + var_343_0 and arg_340_1.time_ < 0 + var_343_0 + arg_343_0 and not isNil(arg_340_1.actors_["1137"]) and arg_340_1.var_.actorSpriteComps1137 then
				for iter_343_2, iter_343_3 in pairs(arg_340_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_343_3 then
						iter_343_3.color = arg_340_1.isInRecall_ and (arg_340_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_340_1.var_.actorSpriteComps1137 = nil
			end

			local var_343_2 = arg_340_1.actors_["1137"].transform

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 then
				arg_340_1.var_.moveOldPos1137 = var_343_2.localPosition
				var_343_2.localScale = Vector3.New(1, 1, 1)

				arg_340_1:CheckSpriteTmpPos("1137", 7)

				for iter_343_4 = 0, var_343_2.childCount - 1 do
					local var_343_3 = var_343_2:GetChild(iter_343_4)

					if var_343_3.name == "" or not string.find(var_343_3.name, "split") then
						var_343_3.gameObject:SetActive(true)
					else
						var_343_3.gameObject:SetActive(false)
					end
				end
			end

			local var_343_4 = 0.001

			if 0 <= arg_340_1.time_ and arg_340_1.time_ < 0 + var_343_4 then
				var_343_2.localPosition = Vector3.Lerp(arg_340_1.var_.moveOldPos1137, Vector3.New(0, -2000, 0), (arg_340_1.time_ - 0) / var_343_4)
			end

			if arg_340_1.time_ >= 0 + var_343_4 and arg_340_1.time_ < 0 + var_343_4 + arg_343_0 then
				var_343_2.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.133333333333333 < arg_340_1.time_ and arg_340_1.time_ <= 0.133333333333333 + arg_343_0 then
				arg_340_1:AudioAction("play", "effect", "se_story_17", "se_story_17_door_close02", "")
			end

			local var_343_6 = 0
			local var_343_7 = 1.175

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= var_343_6 + arg_343_0 then
				arg_340_1.talkMaxDuration = 0
				arg_340_1.dialogCg_.alpha = 1

				arg_340_1.dialog_:SetActive(true)
				SetActive(arg_340_1.leftNameGo_, false)

				arg_340_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_340_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_340_1:RecordName(arg_340_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_340_1.iconTrs_.gameObject, false)
				arg_340_1.callingController_:SetSelectedState("normal")

				local var_343_8 = arg_340_1:FormatText(arg_340_1:GetWordFromCfg(425121082).content)

				arg_340_1.text_.text = var_343_8

				LuaForUtil.ClearLinePrefixSymbol(arg_340_1.text_)

				local var_343_10 = 47 <= 0 and var_343_7 or var_343_7 * (utf8.len(var_343_8) / 47)

				if (47 <= 0 and var_343_7 or var_343_7 * (utf8.len(var_343_8) / 47)) > 0 and var_343_7 < var_343_10 then
					arg_340_1.talkMaxDuration = var_343_10

					if var_343_10 + var_343_6 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_10 + var_343_6
					end
				end

				arg_340_1.text_.text = var_343_8
				arg_340_1.typewritter.percent = 0

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(false)
				arg_340_1:RecordContent(arg_340_1.text_.text)
			end

			local var_343_11 = math.max(var_343_7, arg_340_1.talkMaxDuration)

			if var_343_6 <= arg_340_1.time_ and arg_340_1.time_ < var_343_6 + var_343_11 then
				arg_340_1.typewritter.percent = (arg_340_1.time_ - var_343_6) / var_343_11

				arg_340_1.typewritter:SetDirty()
			end

			if arg_340_1.time_ >= var_343_6 + var_343_11 and arg_340_1.time_ < var_343_6 + var_343_11 + arg_343_0 then
				arg_340_1.typewritter.percent = 1

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(true)
			end
		end

		arg_340_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1137",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_340_1:InitPlayNodeList()
	end,
	Play425121083 = function(arg_344_0, arg_344_1)
		arg_344_1.time_ = 0
		arg_344_1.frameCnt_ = 0
		arg_344_1.state_ = "playing"
		arg_344_1.curTalkId_ = 425121083
		arg_344_1.duration_ = 5

		SetActive(arg_344_1.tipsGo_, false)

		function arg_344_1.onSingleLineFinish_()
			arg_344_1.onSingleLineUpdate_ = nil
			arg_344_1.onSingleLineFinish_ = nil
			arg_344_1.state_ = "waiting"
		end

		function arg_344_1.playNext_(arg_346_0)
			if arg_346_0 == 1 then
				arg_344_0:Play425121084(arg_344_1)
			end
		end

		function arg_344_1.onSingleLineUpdate_(arg_347_0)
			local var_347_0 = 0.9

			if 0 < arg_344_1.time_ and arg_344_1.time_ <= 0 + arg_347_0 then
				arg_344_1.talkMaxDuration = 0
				arg_344_1.dialogCg_.alpha = 1

				arg_344_1.dialog_:SetActive(true)
				SetActive(arg_344_1.leftNameGo_, false)

				arg_344_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_344_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_344_1:RecordName(arg_344_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_344_1.iconTrs_.gameObject, false)
				arg_344_1.callingController_:SetSelectedState("normal")

				local var_347_1 = arg_344_1:FormatText(arg_344_1:GetWordFromCfg(425121083).content)

				arg_344_1.text_.text = var_347_1

				LuaForUtil.ClearLinePrefixSymbol(arg_344_1.text_)

				local var_347_3 = 36 <= 0 and var_347_0 or var_347_0 * (utf8.len(var_347_1) / 36)

				if (36 <= 0 and var_347_0 or var_347_0 * (utf8.len(var_347_1) / 36)) > 0 and var_347_0 < var_347_3 then
					arg_344_1.talkMaxDuration = var_347_3

					if var_347_3 + 0 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_3 + 0
					end
				end

				arg_344_1.text_.text = var_347_1
				arg_344_1.typewritter.percent = 0

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(false)
				arg_344_1:RecordContent(arg_344_1.text_.text)
			end

			local var_347_4 = math.max(var_347_0, arg_344_1.talkMaxDuration)

			if 0 <= arg_344_1.time_ and arg_344_1.time_ < 0 + var_347_4 then
				arg_344_1.typewritter.percent = (arg_344_1.time_ - 0) / var_347_4

				arg_344_1.typewritter:SetDirty()
			end

			if arg_344_1.time_ >= 0 + var_347_4 and arg_344_1.time_ < 0 + var_347_4 + arg_347_0 then
				arg_344_1.typewritter.percent = 1

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(true)
			end
		end

		arg_344_1.nodeConfigList_ = {}

		arg_344_1:InitPlayNodeList()
	end,
	Play425121084 = function(arg_348_0, arg_348_1)
		arg_348_1.time_ = 0
		arg_348_1.frameCnt_ = 0
		arg_348_1.state_ = "playing"
		arg_348_1.curTalkId_ = 425121084
		arg_348_1.duration_ = 5

		SetActive(arg_348_1.tipsGo_, false)

		function arg_348_1.onSingleLineFinish_()
			arg_348_1.onSingleLineUpdate_ = nil
			arg_348_1.onSingleLineFinish_ = nil
			arg_348_1.state_ = "waiting"
		end

		function arg_348_1.playNext_(arg_350_0)
			if arg_350_0 == 1 then
				arg_348_0:Play425121085(arg_348_1)
			end
		end

		function arg_348_1.onSingleLineUpdate_(arg_351_0)
			local var_351_0 = 0.275

			if 0 < arg_348_1.time_ and arg_348_1.time_ <= 0 + arg_351_0 then
				arg_348_1.talkMaxDuration = 0
				arg_348_1.dialogCg_.alpha = 1

				arg_348_1.dialog_:SetActive(true)
				SetActive(arg_348_1.leftNameGo_, false)

				arg_348_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_348_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_348_1:RecordName(arg_348_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_348_1.iconTrs_.gameObject, false)
				arg_348_1.callingController_:SetSelectedState("normal")

				local var_351_1 = arg_348_1:FormatText(arg_348_1:GetWordFromCfg(425121084).content)

				arg_348_1.text_.text = var_351_1

				LuaForUtil.ClearLinePrefixSymbol(arg_348_1.text_)

				local var_351_3 = 11 <= 0 and var_351_0 or var_351_0 * (utf8.len(var_351_1) / 11)

				if (11 <= 0 and var_351_0 or var_351_0 * (utf8.len(var_351_1) / 11)) > 0 and var_351_0 < var_351_3 then
					arg_348_1.talkMaxDuration = var_351_3

					if var_351_3 + 0 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_3 + 0
					end
				end

				arg_348_1.text_.text = var_351_1
				arg_348_1.typewritter.percent = 0

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(false)
				arg_348_1:RecordContent(arg_348_1.text_.text)
			end

			local var_351_4 = math.max(var_351_0, arg_348_1.talkMaxDuration)

			if 0 <= arg_348_1.time_ and arg_348_1.time_ < 0 + var_351_4 then
				arg_348_1.typewritter.percent = (arg_348_1.time_ - 0) / var_351_4

				arg_348_1.typewritter:SetDirty()
			end

			if arg_348_1.time_ >= 0 + var_351_4 and arg_348_1.time_ < 0 + var_351_4 + arg_351_0 then
				arg_348_1.typewritter.percent = 1

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(true)
			end
		end

		arg_348_1.nodeConfigList_ = {}

		arg_348_1:InitPlayNodeList()
	end,
	Play425121085 = function(arg_352_0, arg_352_1)
		arg_352_1.time_ = 0
		arg_352_1.frameCnt_ = 0
		arg_352_1.state_ = "playing"
		arg_352_1.curTalkId_ = 425121085
		arg_352_1.duration_ = 5.13

		local var_352_0 = {
			zh = 5.133,
			ja = 5.066
		}
		local var_352_1 = manager.audio:GetLocalizationFlag()

		if var_352_0[var_352_1] ~= nil then
			arg_352_1.duration_ = var_352_0[var_352_1]
		end

		SetActive(arg_352_1.tipsGo_, false)

		function arg_352_1.onSingleLineFinish_()
			arg_352_1.onSingleLineUpdate_ = nil
			arg_352_1.onSingleLineFinish_ = nil
			arg_352_1.state_ = "waiting"
			arg_352_1.auto_ = false
		end

		function arg_352_1.playNext_(arg_354_0)
			arg_352_1.onStoryFinished_()
		end

		function arg_352_1.onSingleLineUpdate_(arg_355_0)
			if 0 < arg_352_1.time_ and arg_352_1.time_ <= 0 + arg_355_0 and not isNil(arg_352_1.actors_["1137"]) and arg_352_1.var_.actorSpriteComps1137 == nil then
				arg_352_1.var_.actorSpriteComps1137 = arg_352_1.actors_["1137"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_355_0 = 0.2

			if 0 <= arg_352_1.time_ and arg_352_1.time_ < 0 + var_355_0 and not isNil(arg_352_1.actors_["1137"]) then
				if arg_352_1.var_.actorSpriteComps1137 then
					for iter_355_0, iter_355_1 in pairs(arg_352_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_355_1 then
							if arg_352_1.isInRecall_ then
								iter_355_1.color = Color.New(Mathf.Lerp(iter_355_1.color.r, arg_352_1.hightColor1.r, (arg_352_1.time_ - 0) / var_355_0), Mathf.Lerp(iter_355_1.color.g, arg_352_1.hightColor1.g, (arg_352_1.time_ - 0) / var_355_0), (Mathf.Lerp(iter_355_1.color.b, arg_352_1.hightColor1.b, (arg_352_1.time_ - 0) / var_355_0)))
							else
								local var_355_1 = Mathf.Lerp(iter_355_1.color.r, 1, (arg_352_1.time_ - 0) / var_355_0)

								iter_355_1.color = Color.New(var_355_1, var_355_1, var_355_1)
							end
						end
					end
				end
			end

			if arg_352_1.time_ >= 0 + var_355_0 and arg_352_1.time_ < 0 + var_355_0 + arg_355_0 and not isNil(arg_352_1.actors_["1137"]) and arg_352_1.var_.actorSpriteComps1137 then
				for iter_355_2, iter_355_3 in pairs(arg_352_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_355_3 then
						iter_355_3.color = arg_352_1.isInRecall_ and (arg_352_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_352_1.var_.actorSpriteComps1137 = nil
			end

			local var_355_2 = arg_352_1.actors_["1137"].transform

			if 0 < arg_352_1.time_ and arg_352_1.time_ <= 0 + arg_355_0 then
				arg_352_1.var_.moveOldPos1137 = var_355_2.localPosition
				var_355_2.localScale = Vector3.New(1, 1, 1)

				arg_352_1:CheckSpriteTmpPos("1137", 3)

				for iter_355_4 = 0, var_355_2.childCount - 1 do
					local var_355_3 = var_355_2:GetChild(iter_355_4)

					if var_355_3.name == "split_6" or not string.find(var_355_3.name, "split") then
						var_355_3.gameObject:SetActive(true)
					else
						var_355_3.gameObject:SetActive(false)
					end
				end
			end

			local var_355_4 = 0.001

			if 0 <= arg_352_1.time_ and arg_352_1.time_ < 0 + var_355_4 then
				var_355_2.localPosition = Vector3.Lerp(arg_352_1.var_.moveOldPos1137, Vector3.New(0, -425, -200), (arg_352_1.time_ - 0) / var_355_4)
			end

			if arg_352_1.time_ >= 0 + var_355_4 and arg_352_1.time_ < 0 + var_355_4 + arg_355_0 then
				var_355_2.localPosition = Vector3.New(0, -425, -200)
			end

			local var_355_5 = 0

			if 0 < arg_352_1.time_ and arg_352_1.time_ <= var_355_5 + arg_355_0 then
				arg_352_1.allBtn_.enabled = false
			end

			if arg_352_1.time_ >= var_355_5 + 0.45 and arg_352_1.time_ < var_355_5 + 0.45 + arg_355_0 then
				arg_352_1.allBtn_.enabled = true
			end

			local var_355_6 = 0
			local var_355_7 = 0.45

			if 0 < arg_352_1.time_ and arg_352_1.time_ <= var_355_6 + arg_355_0 then
				arg_352_1.talkMaxDuration = 0
				arg_352_1.dialogCg_.alpha = 1

				arg_352_1.dialog_:SetActive(true)
				SetActive(arg_352_1.leftNameGo_, true)

				arg_352_1.leftNameTxt_.text = arg_352_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_352_1.leftNameTxt_.transform)

				arg_352_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_352_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_352_1:RecordName(arg_352_1.leftNameTxt_.text)
				SetActive(arg_352_1.iconTrs_.gameObject, false)
				arg_352_1.callingController_:SetSelectedState("normal")

				local var_355_8 = arg_352_1:GetWordFromCfg(425121085)
				local var_355_9 = arg_352_1:FormatText(var_355_8.content)

				arg_352_1.text_.text = var_355_9

				LuaForUtil.ClearLinePrefixSymbol(arg_352_1.text_)

				local var_355_11 = 18 <= 0 and var_355_7 or var_355_7 * (utf8.len(var_355_9) / 18)

				if (18 <= 0 and var_355_7 or var_355_7 * (utf8.len(var_355_9) / 18)) > 0 and var_355_7 < var_355_11 then
					arg_352_1.talkMaxDuration = var_355_11

					if var_355_11 + var_355_6 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_11 + var_355_6
					end
				end

				arg_352_1.text_.text = var_355_9
				arg_352_1.typewritter.percent = 0

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121085", "story_v_out_425121.awb") ~= 0 then
					local var_355_12 = manager.audio:GetVoiceLength("story_v_out_425121", "425121085", "story_v_out_425121.awb") / 1000

					if var_355_12 + var_355_6 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_12 + var_355_6
					end

					if var_355_8.prefab_name ~= "" and arg_352_1.actors_[var_355_8.prefab_name] ~= nil then
						local var_355_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_352_1.actors_[var_355_8.prefab_name].transform, "story_v_out_425121", "425121085", "story_v_out_425121.awb")

						arg_352_1:RecordAudio("425121085", var_355_13)
						arg_352_1:RecordAudio("425121085", var_355_13)
					else
						arg_352_1:AudioAction("play", "voice", "story_v_out_425121", "425121085", "story_v_out_425121.awb")
					end

					arg_352_1:RecordHistoryTalkVoice("story_v_out_425121", "425121085", "story_v_out_425121.awb")
				end

				arg_352_1:RecordContent(arg_352_1.text_.text)
			end

			local var_355_14 = math.max(var_355_7, arg_352_1.talkMaxDuration)

			if var_355_6 <= arg_352_1.time_ and arg_352_1.time_ < var_355_6 + var_355_14 then
				arg_352_1.typewritter.percent = (arg_352_1.time_ - var_355_6) / var_355_14

				arg_352_1.typewritter:SetDirty()
			end

			if arg_352_1.time_ >= var_355_6 + var_355_14 and arg_352_1.time_ < var_355_6 + var_355_14 + arg_355_0 then
				arg_352_1.typewritter.percent = 1

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(true)
			end
		end

		arg_352_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1137",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_352_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST2403a",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/M01i",
		"TextureConfig/Background/M01f"
	},
	voices = {
		"story_v_out_425121.awb"
	}
}
