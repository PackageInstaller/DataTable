return {
	Play410161001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 410161001
		arg_1_1.duration_ = 13.63

		local var_1_0 = {
			ja = 13.633,
			CriLanguages = 8.733,
			zh = 8.733
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
				arg_1_0:Play410161002(arg_1_1)
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

			if 0.3 < arg_1_1.time_ and arg_1_1.time_ <= 0.3 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_2_8_story_tara_building", "bgm_activity_2_8_story_tara_building", "bgm_activity_2_8_story_tara_building.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_activity_2_8_story_tara_building", "bgm_activity_2_8_story_tara_building")

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
				arg_1_1:AudioAction("play", "effect", "se_story_122_01", "se_story_122_01_dizzy_loop", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_15 = 2
			local var_4_16 = 0.875

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

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[596].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10059_split_2")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_18 = arg_1_1:GetWordFromCfg(410161001)
				local var_4_19 = arg_1_1:FormatText(var_4_18.content)

				arg_1_1.text_.text = var_4_19

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_21 = 35 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_19) / 35)

				if (35 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_19) / 35)) > 0 and var_4_16 < var_4_21 then
					arg_1_1.talkMaxDuration = var_4_21
					var_4_15 = var_4_15 + 0.3

					if var_4_21 + var_4_15 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_21 + var_4_15
					end
				end

				arg_1_1.text_.text = var_4_19
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161001", "story_v_out_410161.awb") ~= 0 then
					local var_4_22 = manager.audio:GetVoiceLength("story_v_out_410161", "410161001", "story_v_out_410161.awb") / 1000

					if var_4_22 + var_4_15 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_22 + var_4_15
					end

					if var_4_18.prefab_name ~= "" and arg_1_1.actors_[var_4_18.prefab_name] ~= nil then
						local var_4_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_18.prefab_name].transform, "story_v_out_410161", "410161001", "story_v_out_410161.awb")

						arg_1_1:RecordAudio("410161001", var_4_23)
						arg_1_1:RecordAudio("410161001", var_4_23)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_410161", "410161001", "story_v_out_410161.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_410161", "410161001", "story_v_out_410161.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_24 = var_4_15 + 0.3
			local var_4_25 = math.max(var_4_16, arg_1_1.talkMaxDuration)

			if var_4_15 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_24 + var_4_25 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_24) / var_4_25

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_24 + var_4_25 and arg_1_1.time_ < var_4_24 + var_4_25 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play410161002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 410161002
		arg_9_1.duration_ = 8.23

		local var_9_0 = {
			ja = 8.233,
			CriLanguages = 6.633,
			zh = 6.633
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
				arg_9_0:Play410161003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0.75

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10062")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_1 = arg_9_1:GetWordFromCfg(410161002)
				local var_12_2 = arg_9_1:FormatText(var_12_1.content)

				arg_9_1.text_.text = var_12_2

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 30 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 30)

				if (30 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 30)) > 0 and var_12_0 < var_12_4 then
					arg_9_1.talkMaxDuration = var_12_4

					if var_12_4 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_4 + 0
					end
				end

				arg_9_1.text_.text = var_12_2
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161002", "story_v_out_410161.awb") ~= 0 then
					local var_12_5 = manager.audio:GetVoiceLength("story_v_out_410161", "410161002", "story_v_out_410161.awb") / 1000

					if var_12_5 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_5 + 0
					end

					if var_12_1.prefab_name ~= "" and arg_9_1.actors_[var_12_1.prefab_name] ~= nil then
						local var_12_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_1.prefab_name].transform, "story_v_out_410161", "410161002", "story_v_out_410161.awb")

						arg_9_1:RecordAudio("410161002", var_12_6)
						arg_9_1:RecordAudio("410161002", var_12_6)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_410161", "410161002", "story_v_out_410161.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_410161", "410161002", "story_v_out_410161.awb")
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
	Play410161003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 410161003
		arg_13_1.duration_ = 8.17

		local var_13_0 = {
			ja = 8.166,
			CriLanguages = 5.433,
			zh = 5.433
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
				arg_13_0:Play410161004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0.35

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[596].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10059_split_2")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_1 = arg_13_1:GetWordFromCfg(410161003)
				local var_16_2 = arg_13_1:FormatText(var_16_1.content)

				arg_13_1.text_.text = var_16_2

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 14 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 14)

				if (14 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 14)) > 0 and var_16_0 < var_16_4 then
					arg_13_1.talkMaxDuration = var_16_4

					if var_16_4 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_4 + 0
					end
				end

				arg_13_1.text_.text = var_16_2
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161003", "story_v_out_410161.awb") ~= 0 then
					local var_16_5 = manager.audio:GetVoiceLength("story_v_out_410161", "410161003", "story_v_out_410161.awb") / 1000

					if var_16_5 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_5 + 0
					end

					if var_16_1.prefab_name ~= "" and arg_13_1.actors_[var_16_1.prefab_name] ~= nil then
						local var_16_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_1.prefab_name].transform, "story_v_out_410161", "410161003", "story_v_out_410161.awb")

						arg_13_1:RecordAudio("410161003", var_16_6)
						arg_13_1:RecordAudio("410161003", var_16_6)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_410161", "410161003", "story_v_out_410161.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_410161", "410161003", "story_v_out_410161.awb")
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
	Play410161004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 410161004
		arg_17_1.duration_ = 2.37

		local var_17_0 = {
			ja = 1.3,
			CriLanguages = 2.366,
			zh = 2.366
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
				arg_17_0:Play410161005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0.075

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1061_split_4")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_1 = arg_17_1:GetWordFromCfg(410161004)
				local var_20_2 = arg_17_1:FormatText(var_20_1.content)

				arg_17_1.text_.text = var_20_2

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_4 = 3 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_2) / 3)

				if (3 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_2) / 3)) > 0 and var_20_0 < var_20_4 then
					arg_17_1.talkMaxDuration = var_20_4

					if var_20_4 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_4 + 0
					end
				end

				arg_17_1.text_.text = var_20_2
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161004", "story_v_out_410161.awb") ~= 0 then
					local var_20_5 = manager.audio:GetVoiceLength("story_v_out_410161", "410161004", "story_v_out_410161.awb") / 1000

					if var_20_5 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_5 + 0
					end

					if var_20_1.prefab_name ~= "" and arg_17_1.actors_[var_20_1.prefab_name] ~= nil then
						local var_20_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_1.prefab_name].transform, "story_v_out_410161", "410161004", "story_v_out_410161.awb")

						arg_17_1:RecordAudio("410161004", var_20_6)
						arg_17_1:RecordAudio("410161004", var_20_6)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_410161", "410161004", "story_v_out_410161.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_410161", "410161004", "story_v_out_410161.awb")
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
	Play410161005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 410161005
		arg_21_1.duration_ = 7

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play410161006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if arg_21_1.bgs_.ST67 == nil then
				local var_24_0 = Object.Instantiate(arg_21_1.paintGo_)

				var_24_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST67")
				var_24_0.name = "ST67"
				var_24_0.transform.parent = arg_21_1.stage_.transform
				var_24_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_21_1.bgs_.ST67 = var_24_0
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				local var_24_1 = arg_21_1.bgs_.ST67

				arg_21_1.bgs_.ST67.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_24_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_24_2 = var_24_1:GetComponent("SpriteRenderer")

				if var_24_2 and var_24_2.sprite then
					local var_24_3 = 2 * (var_24_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_24_1.transform.localScale = Vector3.New(var_24_3 / var_24_2.sprite.bounds.size.y < var_24_3 * manager.ui.mainCameraCom_.aspect / var_24_2.sprite.bounds.size.x and var_24_3 * manager.ui.mainCameraCom_.aspect / var_24_2.sprite.bounds.size.x or var_24_3 / var_24_2.sprite.bounds.size.y, var_24_3 / var_24_2.sprite.bounds.size.y < var_24_3 * manager.ui.mainCameraCom_.aspect / var_24_2.sprite.bounds.size.x and var_24_3 * manager.ui.mainCameraCom_.aspect / var_24_2.sprite.bounds.size.x or var_24_3 / var_24_2.sprite.bounds.size.y, 0)
				end

				for iter_24_0, iter_24_1 in pairs(arg_21_1.bgs_) do
					if iter_24_0 ~= "ST67" then
						iter_24_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_24_4 = 0

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_4 + arg_24_0 then
				arg_21_1.mask_.enabled = true
				arg_21_1.mask_.raycastTarget = true

				arg_21_1:SetGaussion(false)
			end

			local var_24_5 = 2

			if var_24_4 <= arg_21_1.time_ and arg_21_1.time_ < var_24_4 + var_24_5 then
				local var_24_6 = Color.New(0, 0, 0)

				var_24_6.a = Mathf.Lerp(1, 0, (arg_21_1.time_ - var_24_4) / var_24_5)
				arg_21_1.mask_.color = var_24_6
			end

			if arg_21_1.time_ >= var_24_4 + var_24_5 and arg_21_1.time_ < var_24_4 + var_24_5 + arg_24_0 then
				local var_24_7 = Color.New(0, 0, 0)

				arg_21_1.mask_.enabled = false
				var_24_7.a = 0
				arg_21_1.mask_.color = var_24_7
			end

			local var_24_8 = "ST67_blur"

			if arg_21_1.bgs_.ST67_blur == nil then
				local var_24_9 = Object.Instantiate(arg_21_1.blurPaintGo_)

				var_24_9:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_24_8)
				var_24_9.name = var_24_8
				var_24_9.transform.parent = arg_21_1.stage_.transform
				var_24_9.transform.localPosition = Vector3.New(0, 100, 0)
				arg_21_1.bgs_[var_24_8] = var_24_9
			end

			local var_24_10 = 0
			local var_24_11 = arg_21_1.bgs_[var_24_8]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_10 + arg_24_0 then
				var_24_11.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_24_11.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_24_12 = var_24_11:GetComponent("SpriteRenderer")

				if var_24_12 and var_24_12.sprite then
					local var_24_13 = 2 * (var_24_11.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_24_11.transform.localScale = Vector3.New(var_24_13 / var_24_12.sprite.bounds.size.y < var_24_13 * manager.ui.mainCameraCom_.aspect / var_24_12.sprite.bounds.size.x and var_24_13 * manager.ui.mainCameraCom_.aspect / var_24_12.sprite.bounds.size.x or var_24_13 / var_24_12.sprite.bounds.size.y, var_24_13 / var_24_12.sprite.bounds.size.y < var_24_13 * manager.ui.mainCameraCom_.aspect / var_24_12.sprite.bounds.size.x and var_24_13 * manager.ui.mainCameraCom_.aspect / var_24_12.sprite.bounds.size.x or var_24_13 / var_24_12.sprite.bounds.size.y, 0)
				end
			end

			local var_24_14 = 0.2

			if var_24_10 <= arg_21_1.time_ and arg_21_1.time_ < var_24_10 + var_24_14 then
				local var_24_15 = Color.New(1, 1, 1)

				var_24_15.a = Mathf.Lerp(0, 1, (arg_21_1.time_ - var_24_10) / var_24_14)

				var_24_11:GetComponent("SpriteRenderer").material:SetColor("_Color", var_24_15)
			end

			if arg_21_1.frameCnt_ <= 1 then
				arg_21_1.dialog_:SetActive(false)
			end

			local var_24_16 = 2
			local var_24_17 = 0.975

			if 2 < arg_21_1.time_ and arg_21_1.time_ <= var_24_16 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0

				arg_21_1.dialog_:SetActive(true)

				arg_21_1.dialogCg_.alpha = 0

				local var_24_18 = LeanTween.value(arg_21_1.dialog_, 0, 1, 0.3)

				var_24_18:setOnUpdate(LuaHelper.FloatAction(function(arg_25_0)
					arg_21_1.dialogCg_.alpha = arg_25_0
				end))
				var_24_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_21_1.dialog_)
					var_24_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_21_1.duration_ = arg_21_1.duration_ + 0.3

				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_19 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(410161005).content)

				arg_21_1.text_.text = var_24_19

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_21 = 39 <= 0 and var_24_17 or var_24_17 * (utf8.len(var_24_19) / 39)

				if (39 <= 0 and var_24_17 or var_24_17 * (utf8.len(var_24_19) / 39)) > 0 and var_24_17 < var_24_21 then
					arg_21_1.talkMaxDuration = var_24_21
					var_24_16 = var_24_16 + 0.3

					if var_24_21 + var_24_16 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_21 + var_24_16
					end
				end

				arg_21_1.text_.text = var_24_19
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_22 = var_24_16 + 0.3
			local var_24_23 = math.max(var_24_17, arg_21_1.talkMaxDuration)

			if var_24_16 + 0.3 <= arg_21_1.time_ and arg_21_1.time_ < var_24_22 + var_24_23 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_22) / var_24_23

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_22 + var_24_23 and arg_21_1.time_ < var_24_22 + var_24_23 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play410161006 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 410161006
		arg_27_1.duration_ = 12.27

		local var_27_0 = {
			ja = 12.266,
			CriLanguages = 8.9,
			zh = 8.9
		}
		local var_27_1 = manager.audio:GetLocalizationFlag()

		if var_27_0[var_27_1] ~= nil then
			arg_27_1.duration_ = var_27_0[var_27_1]
		end

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play410161007(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			local var_30_0 = 1

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				arg_27_1.leftNameTxt_.text = arg_27_1:FormatText(StoryNameCfg[596].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, true)
				arg_27_1.iconController_:SetSelectedState("hero")

				arg_27_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10059_split_2")

				arg_27_1.callingController_:SetSelectedState("normal")

				arg_27_1.keyicon_.color = Color.New(1, 1, 1)
				arg_27_1.icon_.color = Color.New(1, 1, 1)

				local var_30_1 = arg_27_1:GetWordFromCfg(410161006)
				local var_30_2 = arg_27_1:FormatText(var_30_1.content)

				arg_27_1.text_.text = var_30_2

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_4 = 40 <= 0 and var_30_0 or var_30_0 * (utf8.len(var_30_2) / 40)

				if (40 <= 0 and var_30_0 or var_30_0 * (utf8.len(var_30_2) / 40)) > 0 and var_30_0 < var_30_4 then
					arg_27_1.talkMaxDuration = var_30_4

					if var_30_4 + 0 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_4 + 0
					end
				end

				arg_27_1.text_.text = var_30_2
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161006", "story_v_out_410161.awb") ~= 0 then
					local var_30_5 = manager.audio:GetVoiceLength("story_v_out_410161", "410161006", "story_v_out_410161.awb") / 1000

					if var_30_5 + 0 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_5 + 0
					end

					if var_30_1.prefab_name ~= "" and arg_27_1.actors_[var_30_1.prefab_name] ~= nil then
						local var_30_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_1.prefab_name].transform, "story_v_out_410161", "410161006", "story_v_out_410161.awb")

						arg_27_1:RecordAudio("410161006", var_30_6)
						arg_27_1:RecordAudio("410161006", var_30_6)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_out_410161", "410161006", "story_v_out_410161.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_out_410161", "410161006", "story_v_out_410161.awb")
				end

				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_7 = math.max(var_30_0, arg_27_1.talkMaxDuration)

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_7 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - 0) / var_30_7

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= 0 + var_30_7 and arg_27_1.time_ < 0 + var_30_7 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {}

		arg_27_1:InitPlayNodeList()
	end,
	Play410161007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 410161007
		arg_31_1.duration_ = 9.63

		local var_31_0 = {
			ja = 9.633,
			CriLanguages = 9.366,
			zh = 9.366
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
				arg_31_0:Play410161008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = 0.875

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				arg_31_1.leftNameTxt_.text = arg_31_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, true)
				arg_31_1.iconController_:SetSelectedState("hero")

				arg_31_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10062")

				arg_31_1.callingController_:SetSelectedState("normal")

				arg_31_1.keyicon_.color = Color.New(1, 1, 1)
				arg_31_1.icon_.color = Color.New(1, 1, 1)

				local var_34_1 = arg_31_1:GetWordFromCfg(410161007)
				local var_34_2 = arg_31_1:FormatText(var_34_1.content)

				arg_31_1.text_.text = var_34_2

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_4 = 35 <= 0 and var_34_0 or var_34_0 * (utf8.len(var_34_2) / 35)

				if (35 <= 0 and var_34_0 or var_34_0 * (utf8.len(var_34_2) / 35)) > 0 and var_34_0 < var_34_4 then
					arg_31_1.talkMaxDuration = var_34_4

					if var_34_4 + 0 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_4 + 0
					end
				end

				arg_31_1.text_.text = var_34_2
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161007", "story_v_out_410161.awb") ~= 0 then
					local var_34_5 = manager.audio:GetVoiceLength("story_v_out_410161", "410161007", "story_v_out_410161.awb") / 1000

					if var_34_5 + 0 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_5 + 0
					end

					if var_34_1.prefab_name ~= "" and arg_31_1.actors_[var_34_1.prefab_name] ~= nil then
						local var_34_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_1.prefab_name].transform, "story_v_out_410161", "410161007", "story_v_out_410161.awb")

						arg_31_1:RecordAudio("410161007", var_34_6)
						arg_31_1:RecordAudio("410161007", var_34_6)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_410161", "410161007", "story_v_out_410161.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_410161", "410161007", "story_v_out_410161.awb")
				end

				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_7 = math.max(var_34_0, arg_31_1.talkMaxDuration)

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_7 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - 0) / var_34_7

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= 0 + var_34_7 and arg_31_1.time_ < 0 + var_34_7 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {}

		arg_31_1:InitPlayNodeList()
	end,
	Play410161008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 410161008
		arg_35_1.duration_ = 9

		local var_35_0 = {
			ja = 9,
			CriLanguages = 7.533,
			zh = 7.533
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
				arg_35_0:Play410161009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = 0.725

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				arg_35_1.leftNameTxt_.text = arg_35_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, true)
				arg_35_1.iconController_:SetSelectedState("hero")

				arg_35_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10062_split_1")

				arg_35_1.callingController_:SetSelectedState("normal")

				arg_35_1.keyicon_.color = Color.New(1, 1, 1)
				arg_35_1.icon_.color = Color.New(1, 1, 1)

				local var_38_1 = arg_35_1:GetWordFromCfg(410161008)
				local var_38_2 = arg_35_1:FormatText(var_38_1.content)

				arg_35_1.text_.text = var_38_2

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_4 = 29 <= 0 and var_38_0 or var_38_0 * (utf8.len(var_38_2) / 29)

				if (29 <= 0 and var_38_0 or var_38_0 * (utf8.len(var_38_2) / 29)) > 0 and var_38_0 < var_38_4 then
					arg_35_1.talkMaxDuration = var_38_4

					if var_38_4 + 0 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_4 + 0
					end
				end

				arg_35_1.text_.text = var_38_2
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161008", "story_v_out_410161.awb") ~= 0 then
					local var_38_5 = manager.audio:GetVoiceLength("story_v_out_410161", "410161008", "story_v_out_410161.awb") / 1000

					if var_38_5 + 0 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_5 + 0
					end

					if var_38_1.prefab_name ~= "" and arg_35_1.actors_[var_38_1.prefab_name] ~= nil then
						local var_38_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_1.prefab_name].transform, "story_v_out_410161", "410161008", "story_v_out_410161.awb")

						arg_35_1:RecordAudio("410161008", var_38_6)
						arg_35_1:RecordAudio("410161008", var_38_6)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_out_410161", "410161008", "story_v_out_410161.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_out_410161", "410161008", "story_v_out_410161.awb")
				end

				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_7 = math.max(var_38_0, arg_35_1.talkMaxDuration)

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_7 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - 0) / var_38_7

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= 0 + var_38_7 and arg_35_1.time_ < 0 + var_38_7 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {}

		arg_35_1:InitPlayNodeList()
	end,
	Play410161009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 410161009
		arg_39_1.duration_ = 6.2

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play410161010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1:AudioAction("stop", "effect", "se_story_122_01", "se_story_122_01_dizzy_loop", "")
			end

			local var_42_1 = "10059"

			if arg_39_1.actors_["10059"] == nil then
				local var_42_2 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10059")

				if not isNil(var_42_2) then
					local var_42_3 = Object.Instantiate(var_42_2, arg_39_1.canvasGo_.transform)

					var_42_3.transform:SetSiblingIndex(1)

					var_42_3.name = var_42_1
					var_42_3.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_39_1.actors_[var_42_1] = var_42_3

					if arg_39_1.isInRecall_ then
						for iter_42_0, iter_42_1 in ipairs((var_42_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_42_1.color = arg_39_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_42_4 = arg_39_1.actors_["10059"]

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 and not isNil(var_42_4) and arg_39_1.var_.actorSpriteComps10059 == nil then
				arg_39_1.var_.actorSpriteComps10059 = var_42_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_42_5 = 0.034

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_5 and not isNil(var_42_4) then
				if arg_39_1.var_.actorSpriteComps10059 then
					for iter_42_2, iter_42_3 in pairs(arg_39_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_42_3 then
							if arg_39_1.isInRecall_ then
								iter_42_3.color = Color.New(Mathf.Lerp(iter_42_3.color.r, arg_39_1.hightColor2.r, (arg_39_1.time_ - 0) / var_42_5), Mathf.Lerp(iter_42_3.color.g, arg_39_1.hightColor2.g, (arg_39_1.time_ - 0) / var_42_5), (Mathf.Lerp(iter_42_3.color.b, arg_39_1.hightColor2.b, (arg_39_1.time_ - 0) / var_42_5)))
							else
								local var_42_6 = Mathf.Lerp(iter_42_3.color.r, 0.5, (arg_39_1.time_ - 0) / var_42_5)

								iter_42_3.color = Color.New(var_42_6, var_42_6, var_42_6)
							end
						end
					end
				end
			end

			if arg_39_1.time_ >= 0 + var_42_5 and arg_39_1.time_ < 0 + var_42_5 + arg_42_0 and not isNil(var_42_4) and arg_39_1.var_.actorSpriteComps10059 then
				for iter_42_4, iter_42_5 in pairs(arg_39_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_42_5 then
						iter_42_5.color = arg_39_1.isInRecall_ and (arg_39_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_39_1.var_.actorSpriteComps10059 = nil
			end

			local var_42_7 = "10062"

			if arg_39_1.actors_["10062"] == nil then
				local var_42_8 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10062")

				if not isNil(var_42_8) then
					local var_42_9 = Object.Instantiate(var_42_8, arg_39_1.canvasGo_.transform)

					var_42_9.transform:SetSiblingIndex(1)

					var_42_9.name = var_42_7
					var_42_9.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_39_1.actors_[var_42_7] = var_42_9

					if arg_39_1.isInRecall_ then
						for iter_42_6, iter_42_7 in ipairs((var_42_9:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_42_7.color = arg_39_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_42_10 = arg_39_1.actors_["10062"]

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 and not isNil(var_42_10) and arg_39_1.var_.actorSpriteComps10062 == nil then
				arg_39_1.var_.actorSpriteComps10062 = var_42_10:GetComponentsInChildren(typeof(Image), true)
			end

			local var_42_11 = 0.034

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_11 and not isNil(var_42_10) then
				if arg_39_1.var_.actorSpriteComps10062 then
					for iter_42_8, iter_42_9 in pairs(arg_39_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_42_9 then
							if arg_39_1.isInRecall_ then
								iter_42_9.color = Color.New(Mathf.Lerp(iter_42_9.color.r, arg_39_1.hightColor2.r, (arg_39_1.time_ - 0) / var_42_11), Mathf.Lerp(iter_42_9.color.g, arg_39_1.hightColor2.g, (arg_39_1.time_ - 0) / var_42_11), (Mathf.Lerp(iter_42_9.color.b, arg_39_1.hightColor2.b, (arg_39_1.time_ - 0) / var_42_11)))
							else
								local var_42_12 = Mathf.Lerp(iter_42_9.color.r, 0.5, (arg_39_1.time_ - 0) / var_42_11)

								iter_42_9.color = Color.New(var_42_12, var_42_12, var_42_12)
							end
						end
					end
				end
			end

			if arg_39_1.time_ >= 0 + var_42_11 and arg_39_1.time_ < 0 + var_42_11 + arg_42_0 and not isNil(var_42_10) and arg_39_1.var_.actorSpriteComps10062 then
				for iter_42_10, iter_42_11 in pairs(arg_39_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_42_11 then
						iter_42_11.color = arg_39_1.isInRecall_ and (arg_39_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_39_1.var_.actorSpriteComps10062 = nil
			end

			local var_42_13 = 0

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_13 + arg_42_0 then
				arg_39_1.mask_.enabled = true
				arg_39_1.mask_.raycastTarget = true

				arg_39_1:SetGaussion(false)
			end

			local var_42_14 = 1

			if var_42_13 <= arg_39_1.time_ and arg_39_1.time_ < var_42_13 + var_42_14 then
				local var_42_15 = Color.New(0, 0, 0)

				var_42_15.a = Mathf.Lerp(0, 1, (arg_39_1.time_ - var_42_13) / var_42_14)
				arg_39_1.mask_.color = var_42_15
			end

			if arg_39_1.time_ >= var_42_13 + var_42_14 and arg_39_1.time_ < var_42_13 + var_42_14 + arg_42_0 then
				local var_42_16 = Color.New(0, 0, 0)

				var_42_16.a = 1
				arg_39_1.mask_.color = var_42_16
			end

			local var_42_17 = 1

			if 1 < arg_39_1.time_ and arg_39_1.time_ <= var_42_17 + arg_42_0 then
				arg_39_1.mask_.enabled = true
				arg_39_1.mask_.raycastTarget = true

				arg_39_1:SetGaussion(false)
			end

			local var_42_18 = 1.5

			if var_42_17 <= arg_39_1.time_ and arg_39_1.time_ < var_42_17 + var_42_18 then
				local var_42_19 = Color.New(0, 0, 0)

				var_42_19.a = Mathf.Lerp(1, 0, (arg_39_1.time_ - var_42_17) / var_42_18)
				arg_39_1.mask_.color = var_42_19
			end

			if arg_39_1.time_ >= var_42_17 + var_42_18 and arg_39_1.time_ < var_42_17 + var_42_18 + arg_42_0 then
				local var_42_20 = Color.New(0, 0, 0)

				arg_39_1.mask_.enabled = false
				var_42_20.a = 0
				arg_39_1.mask_.color = var_42_20
			end

			if arg_39_1.frameCnt_ <= 1 then
				arg_39_1.dialog_:SetActive(false)
			end

			local var_42_21 = 1.2
			local var_42_22 = 0.95

			if 1.2 < arg_39_1.time_ and arg_39_1.time_ <= var_42_21 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0

				arg_39_1.dialog_:SetActive(true)

				arg_39_1.dialogCg_.alpha = 0

				local var_42_23 = LeanTween.value(arg_39_1.dialog_, 0, 1, 0.3)

				var_42_23:setOnUpdate(LuaHelper.FloatAction(function(arg_43_0)
					arg_39_1.dialogCg_.alpha = arg_43_0
				end))
				var_42_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_39_1.dialog_)
					var_42_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_39_1.duration_ = arg_39_1.duration_ + 0.3

				SetActive(arg_39_1.leftNameGo_, false)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_24 = arg_39_1:FormatText(arg_39_1:GetWordFromCfg(410161009).content)

				arg_39_1.text_.text = var_42_24

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_26 = 38 <= 0 and var_42_22 or var_42_22 * (utf8.len(var_42_24) / 38)

				if (38 <= 0 and var_42_22 or var_42_22 * (utf8.len(var_42_24) / 38)) > 0 and var_42_22 < var_42_26 then
					arg_39_1.talkMaxDuration = var_42_26
					var_42_21 = var_42_21 + 0.3

					if var_42_26 + var_42_21 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_26 + var_42_21
					end
				end

				arg_39_1.text_.text = var_42_24
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)
				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_27 = var_42_21 + 0.3
			local var_42_28 = math.max(var_42_22, arg_39_1.talkMaxDuration)

			if var_42_21 + 0.3 <= arg_39_1.time_ and arg_39_1.time_ < var_42_27 + var_42_28 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_27) / var_42_28

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_27 + var_42_28 and arg_39_1.time_ < var_42_27 + var_42_28 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play410161010 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 410161010
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play410161011(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if arg_45_1.bgs_.ST67_blur == nil then
				local var_48_0 = Object.Instantiate(arg_45_1.blurPaintGo_)

				var_48_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST67_blur")
				var_48_0.name = "ST67_blur"
				var_48_0.transform.parent = arg_45_1.stage_.transform
				var_48_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_45_1.bgs_.ST67_blur = var_48_0
			end

			local var_48_1 = 0
			local var_48_2 = arg_45_1.bgs_.ST67_blur

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 then
				var_48_2.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_48_2.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_48_3 = var_48_2:GetComponent("SpriteRenderer")

				if var_48_3 and var_48_3.sprite then
					local var_48_4 = 2 * (var_48_2.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_48_2.transform.localScale = Vector3.New(var_48_4 / var_48_3.sprite.bounds.size.y < var_48_4 * manager.ui.mainCameraCom_.aspect / var_48_3.sprite.bounds.size.x and var_48_4 * manager.ui.mainCameraCom_.aspect / var_48_3.sprite.bounds.size.x or var_48_4 / var_48_3.sprite.bounds.size.y, var_48_4 / var_48_3.sprite.bounds.size.y < var_48_4 * manager.ui.mainCameraCom_.aspect / var_48_3.sprite.bounds.size.x and var_48_4 * manager.ui.mainCameraCom_.aspect / var_48_3.sprite.bounds.size.x or var_48_4 / var_48_3.sprite.bounds.size.y, 0)
				end
			end

			local var_48_5 = 1

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_5 then
				local var_48_6 = Color.New(1, 1, 1)

				var_48_6.a = Mathf.Lerp(1, 0, (arg_45_1.time_ - var_48_1) / var_48_5)

				var_48_2:GetComponent("SpriteRenderer").material:SetColor("_Color", var_48_6)
			end

			local var_48_7 = 0
			local var_48_8 = 1.775

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_7 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, false)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_9 = arg_45_1:FormatText(arg_45_1:GetWordFromCfg(410161010).content)

				arg_45_1.text_.text = var_48_9

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_11 = 71 <= 0 and var_48_8 or var_48_8 * (utf8.len(var_48_9) / 71)

				if (71 <= 0 and var_48_8 or var_48_8 * (utf8.len(var_48_9) / 71)) > 0 and var_48_8 < var_48_11 then
					arg_45_1.talkMaxDuration = var_48_11

					if var_48_11 + var_48_7 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_11 + var_48_7
					end
				end

				arg_45_1.text_.text = var_48_9
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_12 = math.max(var_48_8, arg_45_1.talkMaxDuration)

			if var_48_7 <= arg_45_1.time_ and arg_45_1.time_ < var_48_7 + var_48_12 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_7) / var_48_12

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_7 + var_48_12 and arg_45_1.time_ < var_48_7 + var_48_12 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play410161011 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 410161011
		arg_49_1.duration_ = 4.6

		local var_49_0 = {
			ja = 4.6,
			CriLanguages = 2.133,
			zh = 2.133
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
				arg_49_0:Play410161012(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.moveOldPos10062 = arg_49_1.actors_["10062"].transform.localPosition
				arg_49_1.actors_["10062"].transform.localScale = Vector3.New(1, 1, 1)

				arg_49_1:CheckSpriteTmpPos("10062", 4)

				for iter_52_0 = 0, arg_49_1.actors_["10062"].transform.childCount - 1 do
					local var_52_0 = arg_49_1.actors_["10062"].transform:GetChild(iter_52_0)

					if var_52_0.name == "split_2" or not string.find(var_52_0.name, "split") then
						var_52_0.gameObject:SetActive(true)
					else
						var_52_0.gameObject:SetActive(false)
					end
				end
			end

			local var_52_1 = 0.001

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_1 then
				arg_49_1.actors_["10062"].transform.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos10062, Vector3.New(370, -390, -290), (arg_49_1.time_ - 0) / var_52_1)
			end

			if arg_49_1.time_ >= 0 + var_52_1 and arg_49_1.time_ < 0 + var_52_1 + arg_52_0 then
				arg_49_1.actors_["10062"].transform.localPosition = Vector3.New(370, -390, -290)
			end

			local var_52_2 = arg_49_1.actors_["10062"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_2) and arg_49_1.var_.actorSpriteComps10062 == nil then
				arg_49_1.var_.actorSpriteComps10062 = var_52_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_3 = 0.034

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_3 and not isNil(var_52_2) then
				if arg_49_1.var_.actorSpriteComps10062 then
					for iter_52_1, iter_52_2 in pairs(arg_49_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_52_2 then
							if arg_49_1.isInRecall_ then
								iter_52_2.color = Color.New(Mathf.Lerp(iter_52_2.color.r, arg_49_1.hightColor1.r, (arg_49_1.time_ - 0) / var_52_3), Mathf.Lerp(iter_52_2.color.g, arg_49_1.hightColor1.g, (arg_49_1.time_ - 0) / var_52_3), (Mathf.Lerp(iter_52_2.color.b, arg_49_1.hightColor1.b, (arg_49_1.time_ - 0) / var_52_3)))
							else
								local var_52_4 = Mathf.Lerp(iter_52_2.color.r, 1, (arg_49_1.time_ - 0) / var_52_3)

								iter_52_2.color = Color.New(var_52_4, var_52_4, var_52_4)
							end
						end
					end
				end
			end

			if arg_49_1.time_ >= 0 + var_52_3 and arg_49_1.time_ < 0 + var_52_3 + arg_52_0 and not isNil(var_52_2) and arg_49_1.var_.actorSpriteComps10062 then
				for iter_52_3, iter_52_4 in pairs(arg_49_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_52_4 then
						iter_52_4.color = arg_49_1.isInRecall_ and (arg_49_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_49_1.var_.actorSpriteComps10062 = nil
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:AudioAction("stop", "effect", "se_story_122_01", "se_story_122_01_dizzy_loop", "")
			end

			local var_52_6 = 0
			local var_52_7 = 0.125

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_6 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_8 = arg_49_1:GetWordFromCfg(410161011)
				local var_52_9 = arg_49_1:FormatText(var_52_8.content)

				arg_49_1.text_.text = var_52_9

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_11 = 5 <= 0 and var_52_7 or var_52_7 * (utf8.len(var_52_9) / 5)

				if (5 <= 0 and var_52_7 or var_52_7 * (utf8.len(var_52_9) / 5)) > 0 and var_52_7 < var_52_11 then
					arg_49_1.talkMaxDuration = var_52_11

					if var_52_11 + var_52_6 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_11 + var_52_6
					end
				end

				arg_49_1.text_.text = var_52_9
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161011", "story_v_out_410161.awb") ~= 0 then
					local var_52_12 = manager.audio:GetVoiceLength("story_v_out_410161", "410161011", "story_v_out_410161.awb") / 1000

					if var_52_12 + var_52_6 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_12 + var_52_6
					end

					if var_52_8.prefab_name ~= "" and arg_49_1.actors_[var_52_8.prefab_name] ~= nil then
						local var_52_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_8.prefab_name].transform, "story_v_out_410161", "410161011", "story_v_out_410161.awb")

						arg_49_1:RecordAudio("410161011", var_52_13)
						arg_49_1:RecordAudio("410161011", var_52_13)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_410161", "410161011", "story_v_out_410161.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_410161", "410161011", "story_v_out_410161.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_14 = math.max(var_52_7, arg_49_1.talkMaxDuration)

			if var_52_6 <= arg_49_1.time_ and arg_49_1.time_ < var_52_6 + var_52_14 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_6) / var_52_14

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_6 + var_52_14 and arg_49_1.time_ < var_52_6 + var_52_14 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_49_1:InitPlayNodeList()
	end,
	Play410161012 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 410161012
		arg_53_1.duration_ = 2.67

		local var_53_0 = {
			ja = 1.2,
			CriLanguages = 2.666,
			zh = 2.666
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
				arg_53_0:Play410161013(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if arg_53_1.actors_["1061"] == nil then
				local var_56_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1061")

				if not isNil(var_56_0) then
					local var_56_1 = Object.Instantiate(var_56_0, arg_53_1.canvasGo_.transform)

					var_56_1.transform:SetSiblingIndex(1)

					var_56_1.name = "1061"
					var_56_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_53_1.actors_["1061"] = var_56_1

					if arg_53_1.isInRecall_ then
						for iter_56_0, iter_56_1 in ipairs((var_56_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_56_1.color = arg_53_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_56_2 = arg_53_1.actors_["1061"].transform

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos1061 = var_56_2.localPosition
				var_56_2.localScale = Vector3.New(1, 1, 1)

				arg_53_1:CheckSpriteTmpPos("1061", 2)

				for iter_56_2 = 0, var_56_2.childCount - 1 do
					local var_56_3 = var_56_2:GetChild(iter_56_2)

					if var_56_3.name == "split_5" or not string.find(var_56_3.name, "split") then
						var_56_3.gameObject:SetActive(true)
					else
						var_56_3.gameObject:SetActive(false)
					end
				end
			end

			local var_56_4 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_4 then
				var_56_2.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (arg_53_1.time_ - 0) / var_56_4)
			end

			if arg_53_1.time_ >= 0 + var_56_4 and arg_53_1.time_ < 0 + var_56_4 + arg_56_0 then
				var_56_2.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_56_5 = arg_53_1.actors_["1061"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_5) and arg_53_1.var_.actorSpriteComps1061 == nil then
				arg_53_1.var_.actorSpriteComps1061 = var_56_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_56_6 = 0.034

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_6 and not isNil(var_56_5) then
				if arg_53_1.var_.actorSpriteComps1061 then
					for iter_56_3, iter_56_4 in pairs(arg_53_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_56_4 then
							if arg_53_1.isInRecall_ then
								iter_56_4.color = Color.New(Mathf.Lerp(iter_56_4.color.r, arg_53_1.hightColor1.r, (arg_53_1.time_ - 0) / var_56_6), Mathf.Lerp(iter_56_4.color.g, arg_53_1.hightColor1.g, (arg_53_1.time_ - 0) / var_56_6), (Mathf.Lerp(iter_56_4.color.b, arg_53_1.hightColor1.b, (arg_53_1.time_ - 0) / var_56_6)))
							else
								local var_56_7 = Mathf.Lerp(iter_56_4.color.r, 1, (arg_53_1.time_ - 0) / var_56_6)

								iter_56_4.color = Color.New(var_56_7, var_56_7, var_56_7)
							end
						end
					end
				end
			end

			if arg_53_1.time_ >= 0 + var_56_6 and arg_53_1.time_ < 0 + var_56_6 + arg_56_0 and not isNil(var_56_5) and arg_53_1.var_.actorSpriteComps1061 then
				for iter_56_5, iter_56_6 in pairs(arg_53_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_56_6 then
						iter_56_6.color = arg_53_1.isInRecall_ and (arg_53_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_53_1.var_.actorSpriteComps1061 = nil
			end

			local var_56_8 = arg_53_1.actors_["10062"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_8) and arg_53_1.var_.actorSpriteComps10062 == nil then
				arg_53_1.var_.actorSpriteComps10062 = var_56_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_56_9 = 0.034

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_9 and not isNil(var_56_8) then
				if arg_53_1.var_.actorSpriteComps10062 then
					for iter_56_7, iter_56_8 in pairs(arg_53_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_56_8 then
							if arg_53_1.isInRecall_ then
								iter_56_8.color = Color.New(Mathf.Lerp(iter_56_8.color.r, arg_53_1.hightColor2.r, (arg_53_1.time_ - 0) / var_56_9), Mathf.Lerp(iter_56_8.color.g, arg_53_1.hightColor2.g, (arg_53_1.time_ - 0) / var_56_9), (Mathf.Lerp(iter_56_8.color.b, arg_53_1.hightColor2.b, (arg_53_1.time_ - 0) / var_56_9)))
							else
								local var_56_10 = Mathf.Lerp(iter_56_8.color.r, 0.5, (arg_53_1.time_ - 0) / var_56_9)

								iter_56_8.color = Color.New(var_56_10, var_56_10, var_56_10)
							end
						end
					end
				end
			end

			if arg_53_1.time_ >= 0 + var_56_9 and arg_53_1.time_ < 0 + var_56_9 + arg_56_0 and not isNil(var_56_8) and arg_53_1.var_.actorSpriteComps10062 then
				for iter_56_9, iter_56_10 in pairs(arg_53_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_56_10 then
						iter_56_10.color = arg_53_1.isInRecall_ and (arg_53_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_53_1.var_.actorSpriteComps10062 = nil
			end

			local var_56_11 = 0
			local var_56_12 = 0.1

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_11 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_13 = arg_53_1:GetWordFromCfg(410161012)
				local var_56_14 = arg_53_1:FormatText(var_56_13.content)

				arg_53_1.text_.text = var_56_14

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_16 = 4 <= 0 and var_56_12 or var_56_12 * (utf8.len(var_56_14) / 4)

				if (4 <= 0 and var_56_12 or var_56_12 * (utf8.len(var_56_14) / 4)) > 0 and var_56_12 < var_56_16 then
					arg_53_1.talkMaxDuration = var_56_16

					if var_56_16 + var_56_11 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_16 + var_56_11
					end
				end

				arg_53_1.text_.text = var_56_14
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161012", "story_v_out_410161.awb") ~= 0 then
					local var_56_17 = manager.audio:GetVoiceLength("story_v_out_410161", "410161012", "story_v_out_410161.awb") / 1000

					if var_56_17 + var_56_11 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_17 + var_56_11
					end

					if var_56_13.prefab_name ~= "" and arg_53_1.actors_[var_56_13.prefab_name] ~= nil then
						local var_56_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_13.prefab_name].transform, "story_v_out_410161", "410161012", "story_v_out_410161.awb")

						arg_53_1:RecordAudio("410161012", var_56_18)
						arg_53_1:RecordAudio("410161012", var_56_18)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_410161", "410161012", "story_v_out_410161.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_410161", "410161012", "story_v_out_410161.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_19 = math.max(var_56_12, arg_53_1.talkMaxDuration)

			if var_56_11 <= arg_53_1.time_ and arg_53_1.time_ < var_56_11 + var_56_19 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_11) / var_56_19

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_11 + var_56_19 and arg_53_1.time_ < var_56_11 + var_56_19 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_53_1:InitPlayNodeList()
	end,
	Play410161013 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 410161013
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play410161014(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(arg_57_1.actors_["1061"]) and arg_57_1.var_.actorSpriteComps1061 == nil then
				arg_57_1.var_.actorSpriteComps1061 = arg_57_1.actors_["1061"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_0 = 0.034

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 and not isNil(arg_57_1.actors_["1061"]) then
				if arg_57_1.var_.actorSpriteComps1061 then
					for iter_60_0, iter_60_1 in pairs(arg_57_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_60_1 then
							if arg_57_1.isInRecall_ then
								iter_60_1.color = Color.New(Mathf.Lerp(iter_60_1.color.r, arg_57_1.hightColor2.r, (arg_57_1.time_ - 0) / var_60_0), Mathf.Lerp(iter_60_1.color.g, arg_57_1.hightColor2.g, (arg_57_1.time_ - 0) / var_60_0), (Mathf.Lerp(iter_60_1.color.b, arg_57_1.hightColor2.b, (arg_57_1.time_ - 0) / var_60_0)))
							else
								local var_60_1 = Mathf.Lerp(iter_60_1.color.r, 0.5, (arg_57_1.time_ - 0) / var_60_0)

								iter_60_1.color = Color.New(var_60_1, var_60_1, var_60_1)
							end
						end
					end
				end
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 and not isNil(arg_57_1.actors_["1061"]) and arg_57_1.var_.actorSpriteComps1061 then
				for iter_60_2, iter_60_3 in pairs(arg_57_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_60_3 then
						iter_60_3.color = arg_57_1.isInRecall_ and (arg_57_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_57_1.var_.actorSpriteComps1061 = nil
			end

			local var_60_2 = 0
			local var_60_3 = 1.35

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_2 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, false)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_4 = arg_57_1:FormatText(arg_57_1:GetWordFromCfg(410161013).content)

				arg_57_1.text_.text = var_60_4

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_6 = 54 <= 0 and var_60_3 or var_60_3 * (utf8.len(var_60_4) / 54)

				if (54 <= 0 and var_60_3 or var_60_3 * (utf8.len(var_60_4) / 54)) > 0 and var_60_3 < var_60_6 then
					arg_57_1.talkMaxDuration = var_60_6

					if var_60_6 + var_60_2 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_6 + var_60_2
					end
				end

				arg_57_1.text_.text = var_60_4
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_7 = math.max(var_60_3, arg_57_1.talkMaxDuration)

			if var_60_2 <= arg_57_1.time_ and arg_57_1.time_ < var_60_2 + var_60_7 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_2) / var_60_7

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_2 + var_60_7 and arg_57_1.time_ < var_60_2 + var_60_7 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play410161014 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 410161014
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play410161015(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 1.075

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

				local var_64_1 = arg_61_1:FormatText(arg_61_1:GetWordFromCfg(410161014).content)

				arg_61_1.text_.text = var_64_1

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_3 = 43 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_1) / 43)

				if (43 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_1) / 43)) > 0 and var_64_0 < var_64_3 then
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
	Play410161015 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 410161015
		arg_65_1.duration_ = 17.9

		local var_65_0 = {
			ja = 17.9,
			CriLanguages = 7.4,
			zh = 7.4
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
				arg_65_0:Play410161016(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos10062 = arg_65_1.actors_["10062"].transform.localPosition
				arg_65_1.actors_["10062"].transform.localScale = Vector3.New(1, 1, 1)

				arg_65_1:CheckSpriteTmpPos("10062", 4)

				for iter_68_0 = 0, arg_65_1.actors_["10062"].transform.childCount - 1 do
					local var_68_0 = arg_65_1.actors_["10062"].transform:GetChild(iter_68_0)

					if var_68_0.name == "" or not string.find(var_68_0.name, "split") then
						var_68_0.gameObject:SetActive(true)
					else
						var_68_0.gameObject:SetActive(false)
					end
				end
			end

			local var_68_1 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_1 then
				arg_65_1.actors_["10062"].transform.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos10062, Vector3.New(370, -390, -290), (arg_65_1.time_ - 0) / var_68_1)
			end

			if arg_65_1.time_ >= 0 + var_68_1 and arg_65_1.time_ < 0 + var_68_1 + arg_68_0 then
				arg_65_1.actors_["10062"].transform.localPosition = Vector3.New(370, -390, -290)
			end

			local var_68_2 = arg_65_1.actors_["10062"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_2) and arg_65_1.var_.actorSpriteComps10062 == nil then
				arg_65_1.var_.actorSpriteComps10062 = var_68_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_3 = 0.034

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_3 and not isNil(var_68_2) then
				if arg_65_1.var_.actorSpriteComps10062 then
					for iter_68_1, iter_68_2 in pairs(arg_65_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_68_2 then
							if arg_65_1.isInRecall_ then
								iter_68_2.color = Color.New(Mathf.Lerp(iter_68_2.color.r, arg_65_1.hightColor1.r, (arg_65_1.time_ - 0) / var_68_3), Mathf.Lerp(iter_68_2.color.g, arg_65_1.hightColor1.g, (arg_65_1.time_ - 0) / var_68_3), (Mathf.Lerp(iter_68_2.color.b, arg_65_1.hightColor1.b, (arg_65_1.time_ - 0) / var_68_3)))
							else
								local var_68_4 = Mathf.Lerp(iter_68_2.color.r, 1, (arg_65_1.time_ - 0) / var_68_3)

								iter_68_2.color = Color.New(var_68_4, var_68_4, var_68_4)
							end
						end
					end
				end
			end

			if arg_65_1.time_ >= 0 + var_68_3 and arg_65_1.time_ < 0 + var_68_3 + arg_68_0 and not isNil(var_68_2) and arg_65_1.var_.actorSpriteComps10062 then
				for iter_68_3, iter_68_4 in pairs(arg_65_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_68_4 then
						iter_68_4.color = arg_65_1.isInRecall_ and (arg_65_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_65_1.var_.actorSpriteComps10062 = nil
			end

			local var_68_5 = 0
			local var_68_6 = 0.775

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_5 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_7 = arg_65_1:GetWordFromCfg(410161015)
				local var_68_8 = arg_65_1:FormatText(var_68_7.content)

				arg_65_1.text_.text = var_68_8

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_10 = 31 <= 0 and var_68_6 or var_68_6 * (utf8.len(var_68_8) / 31)

				if (31 <= 0 and var_68_6 or var_68_6 * (utf8.len(var_68_8) / 31)) > 0 and var_68_6 < var_68_10 then
					arg_65_1.talkMaxDuration = var_68_10

					if var_68_10 + var_68_5 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_10 + var_68_5
					end
				end

				arg_65_1.text_.text = var_68_8
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161015", "story_v_out_410161.awb") ~= 0 then
					local var_68_11 = manager.audio:GetVoiceLength("story_v_out_410161", "410161015", "story_v_out_410161.awb") / 1000

					if var_68_11 + var_68_5 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_11 + var_68_5
					end

					if var_68_7.prefab_name ~= "" and arg_65_1.actors_[var_68_7.prefab_name] ~= nil then
						local var_68_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_7.prefab_name].transform, "story_v_out_410161", "410161015", "story_v_out_410161.awb")

						arg_65_1:RecordAudio("410161015", var_68_12)
						arg_65_1:RecordAudio("410161015", var_68_12)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_410161", "410161015", "story_v_out_410161.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_410161", "410161015", "story_v_out_410161.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_13 = math.max(var_68_6, arg_65_1.talkMaxDuration)

			if var_68_5 <= arg_65_1.time_ and arg_65_1.time_ < var_68_5 + var_68_13 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_5) / var_68_13

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_5 + var_68_13 and arg_65_1.time_ < var_68_5 + var_68_13 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_65_1:InitPlayNodeList()
	end,
	Play410161016 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 410161016
		arg_69_1.duration_ = 15.67

		local var_69_0 = {
			ja = 15.666,
			CriLanguages = 10.433,
			zh = 10.433
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
				arg_69_0:Play410161017(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos10062 = arg_69_1.actors_["10062"].transform.localPosition
				arg_69_1.actors_["10062"].transform.localScale = Vector3.New(1, 1, 1)

				arg_69_1:CheckSpriteTmpPos("10062", 4)

				for iter_72_0 = 0, arg_69_1.actors_["10062"].transform.childCount - 1 do
					local var_72_0 = arg_69_1.actors_["10062"].transform:GetChild(iter_72_0)

					if var_72_0.name == "" or not string.find(var_72_0.name, "split") then
						var_72_0.gameObject:SetActive(true)
					else
						var_72_0.gameObject:SetActive(false)
					end
				end
			end

			local var_72_1 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_1 then
				arg_69_1.actors_["10062"].transform.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos10062, Vector3.New(370, -390, -290), (arg_69_1.time_ - 0) / var_72_1)
			end

			if arg_69_1.time_ >= 0 + var_72_1 and arg_69_1.time_ < 0 + var_72_1 + arg_72_0 then
				arg_69_1.actors_["10062"].transform.localPosition = Vector3.New(370, -390, -290)
			end

			local var_72_2 = arg_69_1.actors_["10062"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_2) and arg_69_1.var_.actorSpriteComps10062 == nil then
				arg_69_1.var_.actorSpriteComps10062 = var_72_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_72_3 = 0.034

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_3 and not isNil(var_72_2) then
				if arg_69_1.var_.actorSpriteComps10062 then
					for iter_72_1, iter_72_2 in pairs(arg_69_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_72_2 then
							if arg_69_1.isInRecall_ then
								iter_72_2.color = Color.New(Mathf.Lerp(iter_72_2.color.r, arg_69_1.hightColor1.r, (arg_69_1.time_ - 0) / var_72_3), Mathf.Lerp(iter_72_2.color.g, arg_69_1.hightColor1.g, (arg_69_1.time_ - 0) / var_72_3), (Mathf.Lerp(iter_72_2.color.b, arg_69_1.hightColor1.b, (arg_69_1.time_ - 0) / var_72_3)))
							else
								local var_72_4 = Mathf.Lerp(iter_72_2.color.r, 1, (arg_69_1.time_ - 0) / var_72_3)

								iter_72_2.color = Color.New(var_72_4, var_72_4, var_72_4)
							end
						end
					end
				end
			end

			if arg_69_1.time_ >= 0 + var_72_3 and arg_69_1.time_ < 0 + var_72_3 + arg_72_0 and not isNil(var_72_2) and arg_69_1.var_.actorSpriteComps10062 then
				for iter_72_3, iter_72_4 in pairs(arg_69_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_72_4 then
						iter_72_4.color = arg_69_1.isInRecall_ and (arg_69_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_69_1.var_.actorSpriteComps10062 = nil
			end

			local var_72_5 = 0
			local var_72_6 = 1

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_5 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_7 = arg_69_1:GetWordFromCfg(410161016)
				local var_72_8 = arg_69_1:FormatText(var_72_7.content)

				arg_69_1.text_.text = var_72_8

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_10 = 40 <= 0 and var_72_6 or var_72_6 * (utf8.len(var_72_8) / 40)

				if (40 <= 0 and var_72_6 or var_72_6 * (utf8.len(var_72_8) / 40)) > 0 and var_72_6 < var_72_10 then
					arg_69_1.talkMaxDuration = var_72_10

					if var_72_10 + var_72_5 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_10 + var_72_5
					end
				end

				arg_69_1.text_.text = var_72_8
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161016", "story_v_out_410161.awb") ~= 0 then
					local var_72_11 = manager.audio:GetVoiceLength("story_v_out_410161", "410161016", "story_v_out_410161.awb") / 1000

					if var_72_11 + var_72_5 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_11 + var_72_5
					end

					if var_72_7.prefab_name ~= "" and arg_69_1.actors_[var_72_7.prefab_name] ~= nil then
						local var_72_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_7.prefab_name].transform, "story_v_out_410161", "410161016", "story_v_out_410161.awb")

						arg_69_1:RecordAudio("410161016", var_72_12)
						arg_69_1:RecordAudio("410161016", var_72_12)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_410161", "410161016", "story_v_out_410161.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_410161", "410161016", "story_v_out_410161.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_13 = math.max(var_72_6, arg_69_1.talkMaxDuration)

			if var_72_5 <= arg_69_1.time_ and arg_69_1.time_ < var_72_5 + var_72_13 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_5) / var_72_13

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_5 + var_72_13 and arg_69_1.time_ < var_72_5 + var_72_13 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_69_1:InitPlayNodeList()
	end,
	Play410161017 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 410161017
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play410161018(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(arg_73_1.actors_["10062"]) and arg_73_1.var_.actorSpriteComps10062 == nil then
				arg_73_1.var_.actorSpriteComps10062 = arg_73_1.actors_["10062"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_0 = 0.034

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 and not isNil(arg_73_1.actors_["10062"]) then
				if arg_73_1.var_.actorSpriteComps10062 then
					for iter_76_0, iter_76_1 in pairs(arg_73_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_76_1 then
							if arg_73_1.isInRecall_ then
								iter_76_1.color = Color.New(Mathf.Lerp(iter_76_1.color.r, arg_73_1.hightColor2.r, (arg_73_1.time_ - 0) / var_76_0), Mathf.Lerp(iter_76_1.color.g, arg_73_1.hightColor2.g, (arg_73_1.time_ - 0) / var_76_0), (Mathf.Lerp(iter_76_1.color.b, arg_73_1.hightColor2.b, (arg_73_1.time_ - 0) / var_76_0)))
							else
								local var_76_1 = Mathf.Lerp(iter_76_1.color.r, 0.5, (arg_73_1.time_ - 0) / var_76_0)

								iter_76_1.color = Color.New(var_76_1, var_76_1, var_76_1)
							end
						end
					end
				end
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 and not isNil(arg_73_1.actors_["10062"]) and arg_73_1.var_.actorSpriteComps10062 then
				for iter_76_2, iter_76_3 in pairs(arg_73_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_76_3 then
						iter_76_3.color = arg_73_1.isInRecall_ and (arg_73_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_73_1.var_.actorSpriteComps10062 = nil
			end

			local var_76_2 = 0
			local var_76_3 = 0.95

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

				local var_76_4 = arg_73_1:FormatText(arg_73_1:GetWordFromCfg(410161017).content)

				arg_73_1.text_.text = var_76_4

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_6 = 38 <= 0 and var_76_3 or var_76_3 * (utf8.len(var_76_4) / 38)

				if (38 <= 0 and var_76_3 or var_76_3 * (utf8.len(var_76_4) / 38)) > 0 and var_76_3 < var_76_6 then
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
	Play410161018 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 410161018
		arg_77_1.duration_ = 11.23

		local var_77_0 = {
			ja = 11.233,
			CriLanguages = 10.666,
			zh = 10.666
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
				arg_77_0:Play410161019(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos1061 = arg_77_1.actors_["1061"].transform.localPosition
				arg_77_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_77_1:CheckSpriteTmpPos("1061", 2)

				for iter_80_0 = 0, arg_77_1.actors_["1061"].transform.childCount - 1 do
					local var_80_0 = arg_77_1.actors_["1061"].transform:GetChild(iter_80_0)

					if var_80_0.name == "split_5" or not string.find(var_80_0.name, "split") then
						var_80_0.gameObject:SetActive(true)
					else
						var_80_0.gameObject:SetActive(false)
					end
				end
			end

			local var_80_1 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_1 then
				arg_77_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (arg_77_1.time_ - 0) / var_80_1)
			end

			if arg_77_1.time_ >= 0 + var_80_1 and arg_77_1.time_ < 0 + var_80_1 + arg_80_0 then
				arg_77_1.actors_["1061"].transform.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_80_2 = arg_77_1.actors_["1061"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_2) and arg_77_1.var_.actorSpriteComps1061 == nil then
				arg_77_1.var_.actorSpriteComps1061 = var_80_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_3 = 0.034

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_3 and not isNil(var_80_2) then
				if arg_77_1.var_.actorSpriteComps1061 then
					for iter_80_1, iter_80_2 in pairs(arg_77_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_80_2 then
							if arg_77_1.isInRecall_ then
								iter_80_2.color = Color.New(Mathf.Lerp(iter_80_2.color.r, arg_77_1.hightColor1.r, (arg_77_1.time_ - 0) / var_80_3), Mathf.Lerp(iter_80_2.color.g, arg_77_1.hightColor1.g, (arg_77_1.time_ - 0) / var_80_3), (Mathf.Lerp(iter_80_2.color.b, arg_77_1.hightColor1.b, (arg_77_1.time_ - 0) / var_80_3)))
							else
								local var_80_4 = Mathf.Lerp(iter_80_2.color.r, 1, (arg_77_1.time_ - 0) / var_80_3)

								iter_80_2.color = Color.New(var_80_4, var_80_4, var_80_4)
							end
						end
					end
				end
			end

			if arg_77_1.time_ >= 0 + var_80_3 and arg_77_1.time_ < 0 + var_80_3 + arg_80_0 and not isNil(var_80_2) and arg_77_1.var_.actorSpriteComps1061 then
				for iter_80_3, iter_80_4 in pairs(arg_77_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_80_4 then
						iter_80_4.color = arg_77_1.isInRecall_ and (arg_77_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_77_1.var_.actorSpriteComps1061 = nil
			end

			local var_80_5 = 0
			local var_80_6 = 0.9

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_5 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_7 = arg_77_1:GetWordFromCfg(410161018)
				local var_80_8 = arg_77_1:FormatText(var_80_7.content)

				arg_77_1.text_.text = var_80_8

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_10 = 36 <= 0 and var_80_6 or var_80_6 * (utf8.len(var_80_8) / 36)

				if (36 <= 0 and var_80_6 or var_80_6 * (utf8.len(var_80_8) / 36)) > 0 and var_80_6 < var_80_10 then
					arg_77_1.talkMaxDuration = var_80_10

					if var_80_10 + var_80_5 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_10 + var_80_5
					end
				end

				arg_77_1.text_.text = var_80_8
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161018", "story_v_out_410161.awb") ~= 0 then
					local var_80_11 = manager.audio:GetVoiceLength("story_v_out_410161", "410161018", "story_v_out_410161.awb") / 1000

					if var_80_11 + var_80_5 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_11 + var_80_5
					end

					if var_80_7.prefab_name ~= "" and arg_77_1.actors_[var_80_7.prefab_name] ~= nil then
						local var_80_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_7.prefab_name].transform, "story_v_out_410161", "410161018", "story_v_out_410161.awb")

						arg_77_1:RecordAudio("410161018", var_80_12)
						arg_77_1:RecordAudio("410161018", var_80_12)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_410161", "410161018", "story_v_out_410161.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_410161", "410161018", "story_v_out_410161.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_13 = math.max(var_80_6, arg_77_1.talkMaxDuration)

			if var_80_5 <= arg_77_1.time_ and arg_77_1.time_ < var_80_5 + var_80_13 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_5) / var_80_13

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_5 + var_80_13 and arg_77_1.time_ < var_80_5 + var_80_13 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
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
	Play410161019 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 410161019
		arg_81_1.duration_ = 22.23

		local var_81_0 = {
			ja = 22.233,
			CriLanguages = 8.3,
			zh = 8.3
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
				arg_81_0:Play410161020(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos10062 = arg_81_1.actors_["10062"].transform.localPosition
				arg_81_1.actors_["10062"].transform.localScale = Vector3.New(1, 1, 1)

				arg_81_1:CheckSpriteTmpPos("10062", 4)

				for iter_84_0 = 0, arg_81_1.actors_["10062"].transform.childCount - 1 do
					local var_84_0 = arg_81_1.actors_["10062"].transform:GetChild(iter_84_0)

					if var_84_0.name == "split_2" or not string.find(var_84_0.name, "split") then
						var_84_0.gameObject:SetActive(true)
					else
						var_84_0.gameObject:SetActive(false)
					end
				end
			end

			local var_84_1 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_1 then
				arg_81_1.actors_["10062"].transform.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos10062, Vector3.New(370, -390, -290), (arg_81_1.time_ - 0) / var_84_1)
			end

			if arg_81_1.time_ >= 0 + var_84_1 and arg_81_1.time_ < 0 + var_84_1 + arg_84_0 then
				arg_81_1.actors_["10062"].transform.localPosition = Vector3.New(370, -390, -290)
			end

			local var_84_2 = arg_81_1.actors_["10062"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_2) and arg_81_1.var_.actorSpriteComps10062 == nil then
				arg_81_1.var_.actorSpriteComps10062 = var_84_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_84_3 = 0.034

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_3 and not isNil(var_84_2) then
				if arg_81_1.var_.actorSpriteComps10062 then
					for iter_84_1, iter_84_2 in pairs(arg_81_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_84_2 then
							if arg_81_1.isInRecall_ then
								iter_84_2.color = Color.New(Mathf.Lerp(iter_84_2.color.r, arg_81_1.hightColor1.r, (arg_81_1.time_ - 0) / var_84_3), Mathf.Lerp(iter_84_2.color.g, arg_81_1.hightColor1.g, (arg_81_1.time_ - 0) / var_84_3), (Mathf.Lerp(iter_84_2.color.b, arg_81_1.hightColor1.b, (arg_81_1.time_ - 0) / var_84_3)))
							else
								local var_84_4 = Mathf.Lerp(iter_84_2.color.r, 1, (arg_81_1.time_ - 0) / var_84_3)

								iter_84_2.color = Color.New(var_84_4, var_84_4, var_84_4)
							end
						end
					end
				end
			end

			if arg_81_1.time_ >= 0 + var_84_3 and arg_81_1.time_ < 0 + var_84_3 + arg_84_0 and not isNil(var_84_2) and arg_81_1.var_.actorSpriteComps10062 then
				for iter_84_3, iter_84_4 in pairs(arg_81_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_84_4 then
						iter_84_4.color = arg_81_1.isInRecall_ and (arg_81_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_81_1.var_.actorSpriteComps10062 = nil
			end

			local var_84_5 = arg_81_1.actors_["1061"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_5) and arg_81_1.var_.actorSpriteComps1061 == nil then
				arg_81_1.var_.actorSpriteComps1061 = var_84_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_84_6 = 0.034

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_6 and not isNil(var_84_5) then
				if arg_81_1.var_.actorSpriteComps1061 then
					for iter_84_5, iter_84_6 in pairs(arg_81_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_84_6 then
							if arg_81_1.isInRecall_ then
								iter_84_6.color = Color.New(Mathf.Lerp(iter_84_6.color.r, arg_81_1.hightColor2.r, (arg_81_1.time_ - 0) / var_84_6), Mathf.Lerp(iter_84_6.color.g, arg_81_1.hightColor2.g, (arg_81_1.time_ - 0) / var_84_6), (Mathf.Lerp(iter_84_6.color.b, arg_81_1.hightColor2.b, (arg_81_1.time_ - 0) / var_84_6)))
							else
								local var_84_7 = Mathf.Lerp(iter_84_6.color.r, 0.5, (arg_81_1.time_ - 0) / var_84_6)

								iter_84_6.color = Color.New(var_84_7, var_84_7, var_84_7)
							end
						end
					end
				end
			end

			if arg_81_1.time_ >= 0 + var_84_6 and arg_81_1.time_ < 0 + var_84_6 + arg_84_0 and not isNil(var_84_5) and arg_81_1.var_.actorSpriteComps1061 then
				for iter_84_7, iter_84_8 in pairs(arg_81_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_84_8 then
						iter_84_8.color = arg_81_1.isInRecall_ and (arg_81_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_81_1.var_.actorSpriteComps1061 = nil
			end

			local var_84_8 = 0
			local var_84_9 = 0.7

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_8 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_10 = arg_81_1:GetWordFromCfg(410161019)
				local var_84_11 = arg_81_1:FormatText(var_84_10.content)

				arg_81_1.text_.text = var_84_11

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_13 = 28 <= 0 and var_84_9 or var_84_9 * (utf8.len(var_84_11) / 28)

				if (28 <= 0 and var_84_9 or var_84_9 * (utf8.len(var_84_11) / 28)) > 0 and var_84_9 < var_84_13 then
					arg_81_1.talkMaxDuration = var_84_13

					if var_84_13 + var_84_8 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_13 + var_84_8
					end
				end

				arg_81_1.text_.text = var_84_11
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161019", "story_v_out_410161.awb") ~= 0 then
					local var_84_14 = manager.audio:GetVoiceLength("story_v_out_410161", "410161019", "story_v_out_410161.awb") / 1000

					if var_84_14 + var_84_8 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_14 + var_84_8
					end

					if var_84_10.prefab_name ~= "" and arg_81_1.actors_[var_84_10.prefab_name] ~= nil then
						local var_84_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_10.prefab_name].transform, "story_v_out_410161", "410161019", "story_v_out_410161.awb")

						arg_81_1:RecordAudio("410161019", var_84_15)
						arg_81_1:RecordAudio("410161019", var_84_15)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_410161", "410161019", "story_v_out_410161.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_410161", "410161019", "story_v_out_410161.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_16 = math.max(var_84_9, arg_81_1.talkMaxDuration)

			if var_84_8 <= arg_81_1.time_ and arg_81_1.time_ < var_84_8 + var_84_16 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_8) / var_84_16

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_8 + var_84_16 and arg_81_1.time_ < var_84_8 + var_84_16 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_81_1:InitPlayNodeList()
	end,
	Play410161020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 410161020
		arg_85_1.duration_ = 13.2

		local var_85_0 = {
			ja = 13.2,
			CriLanguages = 7.1,
			zh = 7.1
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
				arg_85_0:Play410161021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos1061 = arg_85_1.actors_["1061"].transform.localPosition
				arg_85_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_85_1:CheckSpriteTmpPos("1061", 2)

				for iter_88_0 = 0, arg_85_1.actors_["1061"].transform.childCount - 1 do
					local var_88_0 = arg_85_1.actors_["1061"].transform:GetChild(iter_88_0)

					if var_88_0.name == "split_5" or not string.find(var_88_0.name, "split") then
						var_88_0.gameObject:SetActive(true)
					else
						var_88_0.gameObject:SetActive(false)
					end
				end
			end

			local var_88_1 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_1 then
				arg_85_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (arg_85_1.time_ - 0) / var_88_1)
			end

			if arg_85_1.time_ >= 0 + var_88_1 and arg_85_1.time_ < 0 + var_88_1 + arg_88_0 then
				arg_85_1.actors_["1061"].transform.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_88_2 = arg_85_1.actors_["1061"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_2) and arg_85_1.var_.actorSpriteComps1061 == nil then
				arg_85_1.var_.actorSpriteComps1061 = var_88_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_3 = 0.034

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_3 and not isNil(var_88_2) then
				if arg_85_1.var_.actorSpriteComps1061 then
					for iter_88_1, iter_88_2 in pairs(arg_85_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_88_2 then
							if arg_85_1.isInRecall_ then
								iter_88_2.color = Color.New(Mathf.Lerp(iter_88_2.color.r, arg_85_1.hightColor1.r, (arg_85_1.time_ - 0) / var_88_3), Mathf.Lerp(iter_88_2.color.g, arg_85_1.hightColor1.g, (arg_85_1.time_ - 0) / var_88_3), (Mathf.Lerp(iter_88_2.color.b, arg_85_1.hightColor1.b, (arg_85_1.time_ - 0) / var_88_3)))
							else
								local var_88_4 = Mathf.Lerp(iter_88_2.color.r, 1, (arg_85_1.time_ - 0) / var_88_3)

								iter_88_2.color = Color.New(var_88_4, var_88_4, var_88_4)
							end
						end
					end
				end
			end

			if arg_85_1.time_ >= 0 + var_88_3 and arg_85_1.time_ < 0 + var_88_3 + arg_88_0 and not isNil(var_88_2) and arg_85_1.var_.actorSpriteComps1061 then
				for iter_88_3, iter_88_4 in pairs(arg_85_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_88_4 then
						iter_88_4.color = arg_85_1.isInRecall_ and (arg_85_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_85_1.var_.actorSpriteComps1061 = nil
			end

			local var_88_5 = arg_85_1.actors_["10062"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_5) and arg_85_1.var_.actorSpriteComps10062 == nil then
				arg_85_1.var_.actorSpriteComps10062 = var_88_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_6 = 0.034

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_6 and not isNil(var_88_5) then
				if arg_85_1.var_.actorSpriteComps10062 then
					for iter_88_5, iter_88_6 in pairs(arg_85_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_88_6 then
							if arg_85_1.isInRecall_ then
								iter_88_6.color = Color.New(Mathf.Lerp(iter_88_6.color.r, arg_85_1.hightColor2.r, (arg_85_1.time_ - 0) / var_88_6), Mathf.Lerp(iter_88_6.color.g, arg_85_1.hightColor2.g, (arg_85_1.time_ - 0) / var_88_6), (Mathf.Lerp(iter_88_6.color.b, arg_85_1.hightColor2.b, (arg_85_1.time_ - 0) / var_88_6)))
							else
								local var_88_7 = Mathf.Lerp(iter_88_6.color.r, 0.5, (arg_85_1.time_ - 0) / var_88_6)

								iter_88_6.color = Color.New(var_88_7, var_88_7, var_88_7)
							end
						end
					end
				end
			end

			if arg_85_1.time_ >= 0 + var_88_6 and arg_85_1.time_ < 0 + var_88_6 + arg_88_0 and not isNil(var_88_5) and arg_85_1.var_.actorSpriteComps10062 then
				for iter_88_7, iter_88_8 in pairs(arg_85_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_88_8 then
						iter_88_8.color = arg_85_1.isInRecall_ and (arg_85_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_85_1.var_.actorSpriteComps10062 = nil
			end

			local var_88_8 = 0
			local var_88_9 = 0.75

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_8 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_10 = arg_85_1:GetWordFromCfg(410161020)
				local var_88_11 = arg_85_1:FormatText(var_88_10.content)

				arg_85_1.text_.text = var_88_11

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_13 = 30 <= 0 and var_88_9 or var_88_9 * (utf8.len(var_88_11) / 30)

				if (30 <= 0 and var_88_9 or var_88_9 * (utf8.len(var_88_11) / 30)) > 0 and var_88_9 < var_88_13 then
					arg_85_1.talkMaxDuration = var_88_13

					if var_88_13 + var_88_8 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_13 + var_88_8
					end
				end

				arg_85_1.text_.text = var_88_11
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161020", "story_v_out_410161.awb") ~= 0 then
					local var_88_14 = manager.audio:GetVoiceLength("story_v_out_410161", "410161020", "story_v_out_410161.awb") / 1000

					if var_88_14 + var_88_8 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_14 + var_88_8
					end

					if var_88_10.prefab_name ~= "" and arg_85_1.actors_[var_88_10.prefab_name] ~= nil then
						local var_88_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_10.prefab_name].transform, "story_v_out_410161", "410161020", "story_v_out_410161.awb")

						arg_85_1:RecordAudio("410161020", var_88_15)
						arg_85_1:RecordAudio("410161020", var_88_15)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_410161", "410161020", "story_v_out_410161.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_410161", "410161020", "story_v_out_410161.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_16 = math.max(var_88_9, arg_85_1.talkMaxDuration)

			if var_88_8 <= arg_85_1.time_ and arg_85_1.time_ < var_88_8 + var_88_16 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_8) / var_88_16

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_8 + var_88_16 and arg_85_1.time_ < var_88_8 + var_88_16 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_85_1:InitPlayNodeList()
	end,
	Play410161021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 410161021
		arg_89_1.duration_ = 3.07

		local var_89_0 = {
			ja = 3.066,
			CriLanguages = 1.933,
			zh = 1.933
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
				arg_89_0:Play410161022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos10062 = arg_89_1.actors_["10062"].transform.localPosition
				arg_89_1.actors_["10062"].transform.localScale = Vector3.New(1, 1, 1)

				arg_89_1:CheckSpriteTmpPos("10062", 4)

				for iter_92_0 = 0, arg_89_1.actors_["10062"].transform.childCount - 1 do
					local var_92_0 = arg_89_1.actors_["10062"].transform:GetChild(iter_92_0)

					if var_92_0.name == "split_4" or not string.find(var_92_0.name, "split") then
						var_92_0.gameObject:SetActive(true)
					else
						var_92_0.gameObject:SetActive(false)
					end
				end
			end

			local var_92_1 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_1 then
				arg_89_1.actors_["10062"].transform.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos10062, Vector3.New(370, -390, -290), (arg_89_1.time_ - 0) / var_92_1)
			end

			if arg_89_1.time_ >= 0 + var_92_1 and arg_89_1.time_ < 0 + var_92_1 + arg_92_0 then
				arg_89_1.actors_["10062"].transform.localPosition = Vector3.New(370, -390, -290)
			end

			local var_92_2 = arg_89_1.actors_["10062"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_2) and arg_89_1.var_.actorSpriteComps10062 == nil then
				arg_89_1.var_.actorSpriteComps10062 = var_92_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_92_3 = 0.034

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_3 and not isNil(var_92_2) then
				if arg_89_1.var_.actorSpriteComps10062 then
					for iter_92_1, iter_92_2 in pairs(arg_89_1.var_.actorSpriteComps10062:ToTable()) do
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

			if arg_89_1.time_ >= 0 + var_92_3 and arg_89_1.time_ < 0 + var_92_3 + arg_92_0 and not isNil(var_92_2) and arg_89_1.var_.actorSpriteComps10062 then
				for iter_92_3, iter_92_4 in pairs(arg_89_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_92_4 then
						iter_92_4.color = arg_89_1.isInRecall_ and (arg_89_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_89_1.var_.actorSpriteComps10062 = nil
			end

			local var_92_5 = arg_89_1.actors_["1061"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_5) and arg_89_1.var_.actorSpriteComps1061 == nil then
				arg_89_1.var_.actorSpriteComps1061 = var_92_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_92_6 = 0.034

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_6 and not isNil(var_92_5) then
				if arg_89_1.var_.actorSpriteComps1061 then
					for iter_92_5, iter_92_6 in pairs(arg_89_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_92_6 then
							if arg_89_1.isInRecall_ then
								iter_92_6.color = Color.New(Mathf.Lerp(iter_92_6.color.r, arg_89_1.hightColor2.r, (arg_89_1.time_ - 0) / var_92_6), Mathf.Lerp(iter_92_6.color.g, arg_89_1.hightColor2.g, (arg_89_1.time_ - 0) / var_92_6), (Mathf.Lerp(iter_92_6.color.b, arg_89_1.hightColor2.b, (arg_89_1.time_ - 0) / var_92_6)))
							else
								local var_92_7 = Mathf.Lerp(iter_92_6.color.r, 0.5, (arg_89_1.time_ - 0) / var_92_6)

								iter_92_6.color = Color.New(var_92_7, var_92_7, var_92_7)
							end
						end
					end
				end
			end

			if arg_89_1.time_ >= 0 + var_92_6 and arg_89_1.time_ < 0 + var_92_6 + arg_92_0 and not isNil(var_92_5) and arg_89_1.var_.actorSpriteComps1061 then
				for iter_92_7, iter_92_8 in pairs(arg_89_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_92_8 then
						iter_92_8.color = arg_89_1.isInRecall_ and (arg_89_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_89_1.var_.actorSpriteComps1061 = nil
			end

			local var_92_8 = 0
			local var_92_9 = 0.125

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_8 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_10 = arg_89_1:GetWordFromCfg(410161021)
				local var_92_11 = arg_89_1:FormatText(var_92_10.content)

				arg_89_1.text_.text = var_92_11

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_13 = 5 <= 0 and var_92_9 or var_92_9 * (utf8.len(var_92_11) / 5)

				if (5 <= 0 and var_92_9 or var_92_9 * (utf8.len(var_92_11) / 5)) > 0 and var_92_9 < var_92_13 then
					arg_89_1.talkMaxDuration = var_92_13

					if var_92_13 + var_92_8 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_13 + var_92_8
					end
				end

				arg_89_1.text_.text = var_92_11
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161021", "story_v_out_410161.awb") ~= 0 then
					local var_92_14 = manager.audio:GetVoiceLength("story_v_out_410161", "410161021", "story_v_out_410161.awb") / 1000

					if var_92_14 + var_92_8 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_14 + var_92_8
					end

					if var_92_10.prefab_name ~= "" and arg_89_1.actors_[var_92_10.prefab_name] ~= nil then
						local var_92_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_10.prefab_name].transform, "story_v_out_410161", "410161021", "story_v_out_410161.awb")

						arg_89_1:RecordAudio("410161021", var_92_15)
						arg_89_1:RecordAudio("410161021", var_92_15)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_410161", "410161021", "story_v_out_410161.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_410161", "410161021", "story_v_out_410161.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_16 = math.max(var_92_9, arg_89_1.talkMaxDuration)

			if var_92_8 <= arg_89_1.time_ and arg_89_1.time_ < var_92_8 + var_92_16 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_8) / var_92_16

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_8 + var_92_16 and arg_89_1.time_ < var_92_8 + var_92_16 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
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
	Play410161022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 410161022
		arg_93_1.duration_ = 6.1

		local var_93_0 = {
			ja = 6.1,
			CriLanguages = 3.7,
			zh = 3.7
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
				arg_93_0:Play410161023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(arg_93_1.actors_["10062"]) and arg_93_1.var_.actorSpriteComps10062 == nil then
				arg_93_1.var_.actorSpriteComps10062 = arg_93_1.actors_["10062"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_96_0 = 0.034

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_0 and not isNil(arg_93_1.actors_["10062"]) then
				if arg_93_1.var_.actorSpriteComps10062 then
					for iter_96_0, iter_96_1 in pairs(arg_93_1.var_.actorSpriteComps10062:ToTable()) do
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

			if arg_93_1.time_ >= 0 + var_96_0 and arg_93_1.time_ < 0 + var_96_0 + arg_96_0 and not isNil(arg_93_1.actors_["10062"]) and arg_93_1.var_.actorSpriteComps10062 then
				for iter_96_2, iter_96_3 in pairs(arg_93_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_96_3 then
						iter_96_3.color = arg_93_1.isInRecall_ and (arg_93_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_93_1.var_.actorSpriteComps10062 = nil
			end

			local var_96_2 = arg_93_1.actors_["1061"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_2) and arg_93_1.var_.actorSpriteComps1061 == nil then
				arg_93_1.var_.actorSpriteComps1061 = var_96_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_96_3 = 0.034

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_3 and not isNil(var_96_2) then
				if arg_93_1.var_.actorSpriteComps1061 then
					for iter_96_4, iter_96_5 in pairs(arg_93_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_96_5 then
							if arg_93_1.isInRecall_ then
								iter_96_5.color = Color.New(Mathf.Lerp(iter_96_5.color.r, arg_93_1.hightColor1.r, (arg_93_1.time_ - 0) / var_96_3), Mathf.Lerp(iter_96_5.color.g, arg_93_1.hightColor1.g, (arg_93_1.time_ - 0) / var_96_3), (Mathf.Lerp(iter_96_5.color.b, arg_93_1.hightColor1.b, (arg_93_1.time_ - 0) / var_96_3)))
							else
								local var_96_4 = Mathf.Lerp(iter_96_5.color.r, 1, (arg_93_1.time_ - 0) / var_96_3)

								iter_96_5.color = Color.New(var_96_4, var_96_4, var_96_4)
							end
						end
					end
				end
			end

			if arg_93_1.time_ >= 0 + var_96_3 and arg_93_1.time_ < 0 + var_96_3 + arg_96_0 and not isNil(var_96_2) and arg_93_1.var_.actorSpriteComps1061 then
				for iter_96_6, iter_96_7 in pairs(arg_93_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_96_7 then
						iter_96_7.color = arg_93_1.isInRecall_ and (arg_93_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_93_1.var_.actorSpriteComps1061 = nil
			end

			local var_96_5 = 0
			local var_96_6 = 0.425

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_5 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_7 = arg_93_1:GetWordFromCfg(410161022)
				local var_96_8 = arg_93_1:FormatText(var_96_7.content)

				arg_93_1.text_.text = var_96_8

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_10 = 17 <= 0 and var_96_6 or var_96_6 * (utf8.len(var_96_8) / 17)

				if (17 <= 0 and var_96_6 or var_96_6 * (utf8.len(var_96_8) / 17)) > 0 and var_96_6 < var_96_10 then
					arg_93_1.talkMaxDuration = var_96_10

					if var_96_10 + var_96_5 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_10 + var_96_5
					end
				end

				arg_93_1.text_.text = var_96_8
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161022", "story_v_out_410161.awb") ~= 0 then
					local var_96_11 = manager.audio:GetVoiceLength("story_v_out_410161", "410161022", "story_v_out_410161.awb") / 1000

					if var_96_11 + var_96_5 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_11 + var_96_5
					end

					if var_96_7.prefab_name ~= "" and arg_93_1.actors_[var_96_7.prefab_name] ~= nil then
						local var_96_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_7.prefab_name].transform, "story_v_out_410161", "410161022", "story_v_out_410161.awb")

						arg_93_1:RecordAudio("410161022", var_96_12)
						arg_93_1:RecordAudio("410161022", var_96_12)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_410161", "410161022", "story_v_out_410161.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_410161", "410161022", "story_v_out_410161.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_13 = math.max(var_96_6, arg_93_1.talkMaxDuration)

			if var_96_5 <= arg_93_1.time_ and arg_93_1.time_ < var_96_5 + var_96_13 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_5) / var_96_13

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_5 + var_96_13 and arg_93_1.time_ < var_96_5 + var_96_13 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play410161023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 410161023
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play410161024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(arg_97_1.actors_["1061"]) and arg_97_1.var_.actorSpriteComps1061 == nil then
				arg_97_1.var_.actorSpriteComps1061 = arg_97_1.actors_["1061"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_100_0 = 0.034

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 and not isNil(arg_97_1.actors_["1061"]) then
				if arg_97_1.var_.actorSpriteComps1061 then
					for iter_100_0, iter_100_1 in pairs(arg_97_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_100_1 then
							if arg_97_1.isInRecall_ then
								iter_100_1.color = Color.New(Mathf.Lerp(iter_100_1.color.r, arg_97_1.hightColor2.r, (arg_97_1.time_ - 0) / var_100_0), Mathf.Lerp(iter_100_1.color.g, arg_97_1.hightColor2.g, (arg_97_1.time_ - 0) / var_100_0), (Mathf.Lerp(iter_100_1.color.b, arg_97_1.hightColor2.b, (arg_97_1.time_ - 0) / var_100_0)))
							else
								local var_100_1 = Mathf.Lerp(iter_100_1.color.r, 0.5, (arg_97_1.time_ - 0) / var_100_0)

								iter_100_1.color = Color.New(var_100_1, var_100_1, var_100_1)
							end
						end
					end
				end
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 and not isNil(arg_97_1.actors_["1061"]) and arg_97_1.var_.actorSpriteComps1061 then
				for iter_100_2, iter_100_3 in pairs(arg_97_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_100_3 then
						iter_100_3.color = arg_97_1.isInRecall_ and (arg_97_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_97_1.var_.actorSpriteComps1061 = nil
			end

			local var_100_2 = arg_97_1.actors_["10062"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_2) and arg_97_1.var_.actorSpriteComps10062 == nil then
				arg_97_1.var_.actorSpriteComps10062 = var_100_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_100_3 = 0.034

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_3 and not isNil(var_100_2) then
				if arg_97_1.var_.actorSpriteComps10062 then
					for iter_100_4, iter_100_5 in pairs(arg_97_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_100_5 then
							if arg_97_1.isInRecall_ then
								iter_100_5.color = Color.New(Mathf.Lerp(iter_100_5.color.r, arg_97_1.hightColor2.r, (arg_97_1.time_ - 0) / var_100_3), Mathf.Lerp(iter_100_5.color.g, arg_97_1.hightColor2.g, (arg_97_1.time_ - 0) / var_100_3), (Mathf.Lerp(iter_100_5.color.b, arg_97_1.hightColor2.b, (arg_97_1.time_ - 0) / var_100_3)))
							else
								local var_100_4 = Mathf.Lerp(iter_100_5.color.r, 0.5, (arg_97_1.time_ - 0) / var_100_3)

								iter_100_5.color = Color.New(var_100_4, var_100_4, var_100_4)
							end
						end
					end
				end
			end

			if arg_97_1.time_ >= 0 + var_100_3 and arg_97_1.time_ < 0 + var_100_3 + arg_100_0 and not isNil(var_100_2) and arg_97_1.var_.actorSpriteComps10062 then
				for iter_100_6, iter_100_7 in pairs(arg_97_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_100_7 then
						iter_100_7.color = arg_97_1.isInRecall_ and (arg_97_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_97_1.var_.actorSpriteComps10062 = nil
			end

			local var_100_5 = 0
			local var_100_6 = 1.6

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_5 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, false)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_7 = arg_97_1:FormatText(arg_97_1:GetWordFromCfg(410161023).content)

				arg_97_1.text_.text = var_100_7

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_9 = 64 <= 0 and var_100_6 or var_100_6 * (utf8.len(var_100_7) / 64)

				if (64 <= 0 and var_100_6 or var_100_6 * (utf8.len(var_100_7) / 64)) > 0 and var_100_6 < var_100_9 then
					arg_97_1.talkMaxDuration = var_100_9

					if var_100_9 + var_100_5 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_9 + var_100_5
					end
				end

				arg_97_1.text_.text = var_100_7
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_10 = math.max(var_100_6, arg_97_1.talkMaxDuration)

			if var_100_5 <= arg_97_1.time_ and arg_97_1.time_ < var_100_5 + var_100_10 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_5) / var_100_10

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_5 + var_100_10 and arg_97_1.time_ < var_100_5 + var_100_10 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play410161024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 410161024
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play410161025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 1.475

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, false)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_1 = arg_101_1:FormatText(arg_101_1:GetWordFromCfg(410161024).content)

				arg_101_1.text_.text = var_104_1

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_3 = 59 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_1) / 59)

				if (59 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_1) / 59)) > 0 and var_104_0 < var_104_3 then
					arg_101_1.talkMaxDuration = var_104_3

					if var_104_3 + 0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_3 + 0
					end
				end

				arg_101_1.text_.text = var_104_1
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_4 = math.max(var_104_0, arg_101_1.talkMaxDuration)

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_4 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - 0) / var_104_4

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= 0 + var_104_4 and arg_101_1.time_ < 0 + var_104_4 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play410161025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 410161025
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play410161026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 1.625

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, false)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_1 = arg_105_1:FormatText(arg_105_1:GetWordFromCfg(410161025).content)

				arg_105_1.text_.text = var_108_1

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_3 = 65 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_1) / 65)

				if (65 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_1) / 65)) > 0 and var_108_0 < var_108_3 then
					arg_105_1.talkMaxDuration = var_108_3

					if var_108_3 + 0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_3 + 0
					end
				end

				arg_105_1.text_.text = var_108_1
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_4 = math.max(var_108_0, arg_105_1.talkMaxDuration)

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_4 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - 0) / var_108_4

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= 0 + var_108_4 and arg_105_1.time_ < 0 + var_108_4 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play410161026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 410161026
		arg_109_1.duration_ = 1.37

		local var_109_0 = {
			ja = 1.3,
			CriLanguages = 1.366,
			zh = 1.366
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
				arg_109_0:Play410161027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.var_.moveOldPos1061 = arg_109_1.actors_["1061"].transform.localPosition
				arg_109_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_109_1:CheckSpriteTmpPos("1061", 2)

				for iter_112_0 = 0, arg_109_1.actors_["1061"].transform.childCount - 1 do
					local var_112_0 = arg_109_1.actors_["1061"].transform:GetChild(iter_112_0)

					if var_112_0.name == "split_9" or not string.find(var_112_0.name, "split") then
						var_112_0.gameObject:SetActive(true)
					else
						var_112_0.gameObject:SetActive(false)
					end
				end
			end

			local var_112_1 = 0.001

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_1 then
				arg_109_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (arg_109_1.time_ - 0) / var_112_1)
			end

			if arg_109_1.time_ >= 0 + var_112_1 and arg_109_1.time_ < 0 + var_112_1 + arg_112_0 then
				arg_109_1.actors_["1061"].transform.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_112_2 = arg_109_1.actors_["1061"]

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(var_112_2) and arg_109_1.var_.actorSpriteComps1061 == nil then
				arg_109_1.var_.actorSpriteComps1061 = var_112_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_112_3 = 0.034

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_3 and not isNil(var_112_2) then
				if arg_109_1.var_.actorSpriteComps1061 then
					for iter_112_1, iter_112_2 in pairs(arg_109_1.var_.actorSpriteComps1061:ToTable()) do
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

			if arg_109_1.time_ >= 0 + var_112_3 and arg_109_1.time_ < 0 + var_112_3 + arg_112_0 and not isNil(var_112_2) and arg_109_1.var_.actorSpriteComps1061 then
				for iter_112_3, iter_112_4 in pairs(arg_109_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_112_4 then
						iter_112_4.color = arg_109_1.isInRecall_ and (arg_109_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_109_1.var_.actorSpriteComps1061 = nil
			end

			local var_112_5 = 0
			local var_112_6 = 0.1

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_5 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_7 = arg_109_1:GetWordFromCfg(410161026)
				local var_112_8 = arg_109_1:FormatText(var_112_7.content)

				arg_109_1.text_.text = var_112_8

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_10 = 4 <= 0 and var_112_6 or var_112_6 * (utf8.len(var_112_8) / 4)

				if (4 <= 0 and var_112_6 or var_112_6 * (utf8.len(var_112_8) / 4)) > 0 and var_112_6 < var_112_10 then
					arg_109_1.talkMaxDuration = var_112_10

					if var_112_10 + var_112_5 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_10 + var_112_5
					end
				end

				arg_109_1.text_.text = var_112_8
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161026", "story_v_out_410161.awb") ~= 0 then
					local var_112_11 = manager.audio:GetVoiceLength("story_v_out_410161", "410161026", "story_v_out_410161.awb") / 1000

					if var_112_11 + var_112_5 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_11 + var_112_5
					end

					if var_112_7.prefab_name ~= "" and arg_109_1.actors_[var_112_7.prefab_name] ~= nil then
						local var_112_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_7.prefab_name].transform, "story_v_out_410161", "410161026", "story_v_out_410161.awb")

						arg_109_1:RecordAudio("410161026", var_112_12)
						arg_109_1:RecordAudio("410161026", var_112_12)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_410161", "410161026", "story_v_out_410161.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_410161", "410161026", "story_v_out_410161.awb")
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
				actorName = "1061",
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
	Play410161027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 410161027
		arg_113_1.duration_ = 11.1

		local var_113_0 = {
			ja = 11.1,
			CriLanguages = 7,
			zh = 7
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
				arg_113_0:Play410161028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos10062 = arg_113_1.actors_["10062"].transform.localPosition
				arg_113_1.actors_["10062"].transform.localScale = Vector3.New(1, 1, 1)

				arg_113_1:CheckSpriteTmpPos("10062", 4)

				for iter_116_0 = 0, arg_113_1.actors_["10062"].transform.childCount - 1 do
					local var_116_0 = arg_113_1.actors_["10062"].transform:GetChild(iter_116_0)

					if var_116_0.name == "split_4" or not string.find(var_116_0.name, "split") then
						var_116_0.gameObject:SetActive(true)
					else
						var_116_0.gameObject:SetActive(false)
					end
				end
			end

			local var_116_1 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_1 then
				arg_113_1.actors_["10062"].transform.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos10062, Vector3.New(370, -390, -290), (arg_113_1.time_ - 0) / var_116_1)
			end

			if arg_113_1.time_ >= 0 + var_116_1 and arg_113_1.time_ < 0 + var_116_1 + arg_116_0 then
				arg_113_1.actors_["10062"].transform.localPosition = Vector3.New(370, -390, -290)
			end

			local var_116_2 = arg_113_1.actors_["10062"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_2) and arg_113_1.var_.actorSpriteComps10062 == nil then
				arg_113_1.var_.actorSpriteComps10062 = var_116_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_116_3 = 0.034

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_3 and not isNil(var_116_2) then
				if arg_113_1.var_.actorSpriteComps10062 then
					for iter_116_1, iter_116_2 in pairs(arg_113_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_116_2 then
							if arg_113_1.isInRecall_ then
								iter_116_2.color = Color.New(Mathf.Lerp(iter_116_2.color.r, arg_113_1.hightColor1.r, (arg_113_1.time_ - 0) / var_116_3), Mathf.Lerp(iter_116_2.color.g, arg_113_1.hightColor1.g, (arg_113_1.time_ - 0) / var_116_3), (Mathf.Lerp(iter_116_2.color.b, arg_113_1.hightColor1.b, (arg_113_1.time_ - 0) / var_116_3)))
							else
								local var_116_4 = Mathf.Lerp(iter_116_2.color.r, 1, (arg_113_1.time_ - 0) / var_116_3)

								iter_116_2.color = Color.New(var_116_4, var_116_4, var_116_4)
							end
						end
					end
				end
			end

			if arg_113_1.time_ >= 0 + var_116_3 and arg_113_1.time_ < 0 + var_116_3 + arg_116_0 and not isNil(var_116_2) and arg_113_1.var_.actorSpriteComps10062 then
				for iter_116_3, iter_116_4 in pairs(arg_113_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_116_4 then
						iter_116_4.color = arg_113_1.isInRecall_ and (arg_113_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_113_1.var_.actorSpriteComps10062 = nil
			end

			local var_116_5 = arg_113_1.actors_["1061"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_5) and arg_113_1.var_.actorSpriteComps1061 == nil then
				arg_113_1.var_.actorSpriteComps1061 = var_116_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_116_6 = 0.034

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_6 and not isNil(var_116_5) then
				if arg_113_1.var_.actorSpriteComps1061 then
					for iter_116_5, iter_116_6 in pairs(arg_113_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_116_6 then
							if arg_113_1.isInRecall_ then
								iter_116_6.color = Color.New(Mathf.Lerp(iter_116_6.color.r, arg_113_1.hightColor2.r, (arg_113_1.time_ - 0) / var_116_6), Mathf.Lerp(iter_116_6.color.g, arg_113_1.hightColor2.g, (arg_113_1.time_ - 0) / var_116_6), (Mathf.Lerp(iter_116_6.color.b, arg_113_1.hightColor2.b, (arg_113_1.time_ - 0) / var_116_6)))
							else
								local var_116_7 = Mathf.Lerp(iter_116_6.color.r, 0.5, (arg_113_1.time_ - 0) / var_116_6)

								iter_116_6.color = Color.New(var_116_7, var_116_7, var_116_7)
							end
						end
					end
				end
			end

			if arg_113_1.time_ >= 0 + var_116_6 and arg_113_1.time_ < 0 + var_116_6 + arg_116_0 and not isNil(var_116_5) and arg_113_1.var_.actorSpriteComps1061 then
				for iter_116_7, iter_116_8 in pairs(arg_113_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_116_8 then
						iter_116_8.color = arg_113_1.isInRecall_ and (arg_113_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_113_1.var_.actorSpriteComps1061 = nil
			end

			local var_116_8 = 0
			local var_116_9 = 0.625

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_8 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_10 = arg_113_1:GetWordFromCfg(410161027)
				local var_116_11 = arg_113_1:FormatText(var_116_10.content)

				arg_113_1.text_.text = var_116_11

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_13 = 25 <= 0 and var_116_9 or var_116_9 * (utf8.len(var_116_11) / 25)

				if (25 <= 0 and var_116_9 or var_116_9 * (utf8.len(var_116_11) / 25)) > 0 and var_116_9 < var_116_13 then
					arg_113_1.talkMaxDuration = var_116_13

					if var_116_13 + var_116_8 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_13 + var_116_8
					end
				end

				arg_113_1.text_.text = var_116_11
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161027", "story_v_out_410161.awb") ~= 0 then
					local var_116_14 = manager.audio:GetVoiceLength("story_v_out_410161", "410161027", "story_v_out_410161.awb") / 1000

					if var_116_14 + var_116_8 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_14 + var_116_8
					end

					if var_116_10.prefab_name ~= "" and arg_113_1.actors_[var_116_10.prefab_name] ~= nil then
						local var_116_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_10.prefab_name].transform, "story_v_out_410161", "410161027", "story_v_out_410161.awb")

						arg_113_1:RecordAudio("410161027", var_116_15)
						arg_113_1:RecordAudio("410161027", var_116_15)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_410161", "410161027", "story_v_out_410161.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_410161", "410161027", "story_v_out_410161.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_16 = math.max(var_116_9, arg_113_1.talkMaxDuration)

			if var_116_8 <= arg_113_1.time_ and arg_113_1.time_ < var_116_8 + var_116_16 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_8) / var_116_16

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_8 + var_116_16 and arg_113_1.time_ < var_116_8 + var_116_16 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_113_1:InitPlayNodeList()
	end,
	Play410161028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 410161028
		arg_117_1.duration_ = 13.43

		local var_117_0 = {
			ja = 13.433,
			CriLanguages = 5.333,
			zh = 5.333
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
				arg_117_0:Play410161029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.var_.moveOldPos1061 = arg_117_1.actors_["1061"].transform.localPosition
				arg_117_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_117_1:CheckSpriteTmpPos("1061", 2)

				for iter_120_0 = 0, arg_117_1.actors_["1061"].transform.childCount - 1 do
					local var_120_0 = arg_117_1.actors_["1061"].transform:GetChild(iter_120_0)

					if var_120_0.name == "split_5" or not string.find(var_120_0.name, "split") then
						var_120_0.gameObject:SetActive(true)
					else
						var_120_0.gameObject:SetActive(false)
					end
				end
			end

			local var_120_1 = 0.001

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_1 then
				arg_117_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (arg_117_1.time_ - 0) / var_120_1)
			end

			if arg_117_1.time_ >= 0 + var_120_1 and arg_117_1.time_ < 0 + var_120_1 + arg_120_0 then
				arg_117_1.actors_["1061"].transform.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_120_2 = arg_117_1.actors_["1061"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_2) and arg_117_1.var_.actorSpriteComps1061 == nil then
				arg_117_1.var_.actorSpriteComps1061 = var_120_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_120_3 = 0.034

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_3 and not isNil(var_120_2) then
				if arg_117_1.var_.actorSpriteComps1061 then
					for iter_120_1, iter_120_2 in pairs(arg_117_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_120_2 then
							if arg_117_1.isInRecall_ then
								iter_120_2.color = Color.New(Mathf.Lerp(iter_120_2.color.r, arg_117_1.hightColor1.r, (arg_117_1.time_ - 0) / var_120_3), Mathf.Lerp(iter_120_2.color.g, arg_117_1.hightColor1.g, (arg_117_1.time_ - 0) / var_120_3), (Mathf.Lerp(iter_120_2.color.b, arg_117_1.hightColor1.b, (arg_117_1.time_ - 0) / var_120_3)))
							else
								local var_120_4 = Mathf.Lerp(iter_120_2.color.r, 1, (arg_117_1.time_ - 0) / var_120_3)

								iter_120_2.color = Color.New(var_120_4, var_120_4, var_120_4)
							end
						end
					end
				end
			end

			if arg_117_1.time_ >= 0 + var_120_3 and arg_117_1.time_ < 0 + var_120_3 + arg_120_0 and not isNil(var_120_2) and arg_117_1.var_.actorSpriteComps1061 then
				for iter_120_3, iter_120_4 in pairs(arg_117_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_120_4 then
						iter_120_4.color = arg_117_1.isInRecall_ and (arg_117_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_117_1.var_.actorSpriteComps1061 = nil
			end

			local var_120_5 = arg_117_1.actors_["10062"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_5) and arg_117_1.var_.actorSpriteComps10062 == nil then
				arg_117_1.var_.actorSpriteComps10062 = var_120_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_120_6 = 0.034

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_6 and not isNil(var_120_5) then
				if arg_117_1.var_.actorSpriteComps10062 then
					for iter_120_5, iter_120_6 in pairs(arg_117_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_120_6 then
							if arg_117_1.isInRecall_ then
								iter_120_6.color = Color.New(Mathf.Lerp(iter_120_6.color.r, arg_117_1.hightColor2.r, (arg_117_1.time_ - 0) / var_120_6), Mathf.Lerp(iter_120_6.color.g, arg_117_1.hightColor2.g, (arg_117_1.time_ - 0) / var_120_6), (Mathf.Lerp(iter_120_6.color.b, arg_117_1.hightColor2.b, (arg_117_1.time_ - 0) / var_120_6)))
							else
								local var_120_7 = Mathf.Lerp(iter_120_6.color.r, 0.5, (arg_117_1.time_ - 0) / var_120_6)

								iter_120_6.color = Color.New(var_120_7, var_120_7, var_120_7)
							end
						end
					end
				end
			end

			if arg_117_1.time_ >= 0 + var_120_6 and arg_117_1.time_ < 0 + var_120_6 + arg_120_0 and not isNil(var_120_5) and arg_117_1.var_.actorSpriteComps10062 then
				for iter_120_7, iter_120_8 in pairs(arg_117_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_120_8 then
						iter_120_8.color = arg_117_1.isInRecall_ and (arg_117_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_117_1.var_.actorSpriteComps10062 = nil
			end

			local var_120_8 = 0
			local var_120_9 = 0.625

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_8 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_10 = arg_117_1:GetWordFromCfg(410161028)
				local var_120_11 = arg_117_1:FormatText(var_120_10.content)

				arg_117_1.text_.text = var_120_11

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_13 = 25 <= 0 and var_120_9 or var_120_9 * (utf8.len(var_120_11) / 25)

				if (25 <= 0 and var_120_9 or var_120_9 * (utf8.len(var_120_11) / 25)) > 0 and var_120_9 < var_120_13 then
					arg_117_1.talkMaxDuration = var_120_13

					if var_120_13 + var_120_8 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_13 + var_120_8
					end
				end

				arg_117_1.text_.text = var_120_11
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161028", "story_v_out_410161.awb") ~= 0 then
					local var_120_14 = manager.audio:GetVoiceLength("story_v_out_410161", "410161028", "story_v_out_410161.awb") / 1000

					if var_120_14 + var_120_8 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_14 + var_120_8
					end

					if var_120_10.prefab_name ~= "" and arg_117_1.actors_[var_120_10.prefab_name] ~= nil then
						local var_120_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_10.prefab_name].transform, "story_v_out_410161", "410161028", "story_v_out_410161.awb")

						arg_117_1:RecordAudio("410161028", var_120_15)
						arg_117_1:RecordAudio("410161028", var_120_15)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_410161", "410161028", "story_v_out_410161.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_410161", "410161028", "story_v_out_410161.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_16 = math.max(var_120_9, arg_117_1.talkMaxDuration)

			if var_120_8 <= arg_117_1.time_ and arg_117_1.time_ < var_120_8 + var_120_16 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_8) / var_120_16

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_8 + var_120_16 and arg_117_1.time_ < var_120_8 + var_120_16 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_117_1:InitPlayNodeList()
	end,
	Play410161029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 410161029
		arg_121_1.duration_ = 14.77

		local var_121_0 = {
			ja = 14.766,
			CriLanguages = 9.933,
			zh = 9.933
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
				arg_121_0:Play410161030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos10062 = arg_121_1.actors_["10062"].transform.localPosition
				arg_121_1.actors_["10062"].transform.localScale = Vector3.New(1, 1, 1)

				arg_121_1:CheckSpriteTmpPos("10062", 4)

				for iter_124_0 = 0, arg_121_1.actors_["10062"].transform.childCount - 1 do
					local var_124_0 = arg_121_1.actors_["10062"].transform:GetChild(iter_124_0)

					if var_124_0.name == "split_1_1" or not string.find(var_124_0.name, "split") then
						var_124_0.gameObject:SetActive(true)
					else
						var_124_0.gameObject:SetActive(false)
					end
				end
			end

			local var_124_1 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_1 then
				arg_121_1.actors_["10062"].transform.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos10062, Vector3.New(370, -390, -290), (arg_121_1.time_ - 0) / var_124_1)
			end

			if arg_121_1.time_ >= 0 + var_124_1 and arg_121_1.time_ < 0 + var_124_1 + arg_124_0 then
				arg_121_1.actors_["10062"].transform.localPosition = Vector3.New(370, -390, -290)
			end

			local var_124_2 = arg_121_1.actors_["10062"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_2) and arg_121_1.var_.actorSpriteComps10062 == nil then
				arg_121_1.var_.actorSpriteComps10062 = var_124_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_124_3 = 0.034

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_3 and not isNil(var_124_2) then
				if arg_121_1.var_.actorSpriteComps10062 then
					for iter_124_1, iter_124_2 in pairs(arg_121_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_124_2 then
							if arg_121_1.isInRecall_ then
								iter_124_2.color = Color.New(Mathf.Lerp(iter_124_2.color.r, arg_121_1.hightColor1.r, (arg_121_1.time_ - 0) / var_124_3), Mathf.Lerp(iter_124_2.color.g, arg_121_1.hightColor1.g, (arg_121_1.time_ - 0) / var_124_3), (Mathf.Lerp(iter_124_2.color.b, arg_121_1.hightColor1.b, (arg_121_1.time_ - 0) / var_124_3)))
							else
								local var_124_4 = Mathf.Lerp(iter_124_2.color.r, 1, (arg_121_1.time_ - 0) / var_124_3)

								iter_124_2.color = Color.New(var_124_4, var_124_4, var_124_4)
							end
						end
					end
				end
			end

			if arg_121_1.time_ >= 0 + var_124_3 and arg_121_1.time_ < 0 + var_124_3 + arg_124_0 and not isNil(var_124_2) and arg_121_1.var_.actorSpriteComps10062 then
				for iter_124_3, iter_124_4 in pairs(arg_121_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_124_4 then
						iter_124_4.color = arg_121_1.isInRecall_ and (arg_121_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_121_1.var_.actorSpriteComps10062 = nil
			end

			local var_124_5 = arg_121_1.actors_["1061"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_5) and arg_121_1.var_.actorSpriteComps1061 == nil then
				arg_121_1.var_.actorSpriteComps1061 = var_124_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_124_6 = 0.034

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_6 and not isNil(var_124_5) then
				if arg_121_1.var_.actorSpriteComps1061 then
					for iter_124_5, iter_124_6 in pairs(arg_121_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_124_6 then
							if arg_121_1.isInRecall_ then
								iter_124_6.color = Color.New(Mathf.Lerp(iter_124_6.color.r, arg_121_1.hightColor2.r, (arg_121_1.time_ - 0) / var_124_6), Mathf.Lerp(iter_124_6.color.g, arg_121_1.hightColor2.g, (arg_121_1.time_ - 0) / var_124_6), (Mathf.Lerp(iter_124_6.color.b, arg_121_1.hightColor2.b, (arg_121_1.time_ - 0) / var_124_6)))
							else
								local var_124_7 = Mathf.Lerp(iter_124_6.color.r, 0.5, (arg_121_1.time_ - 0) / var_124_6)

								iter_124_6.color = Color.New(var_124_7, var_124_7, var_124_7)
							end
						end
					end
				end
			end

			if arg_121_1.time_ >= 0 + var_124_6 and arg_121_1.time_ < 0 + var_124_6 + arg_124_0 and not isNil(var_124_5) and arg_121_1.var_.actorSpriteComps1061 then
				for iter_124_7, iter_124_8 in pairs(arg_121_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_124_8 then
						iter_124_8.color = arg_121_1.isInRecall_ and (arg_121_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_121_1.var_.actorSpriteComps1061 = nil
			end

			local var_124_8 = 0
			local var_124_9 = 0.825

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_8 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_10 = arg_121_1:GetWordFromCfg(410161029)
				local var_124_11 = arg_121_1:FormatText(var_124_10.content)

				arg_121_1.text_.text = var_124_11

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_13 = 33 <= 0 and var_124_9 or var_124_9 * (utf8.len(var_124_11) / 33)

				if (33 <= 0 and var_124_9 or var_124_9 * (utf8.len(var_124_11) / 33)) > 0 and var_124_9 < var_124_13 then
					arg_121_1.talkMaxDuration = var_124_13

					if var_124_13 + var_124_8 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_13 + var_124_8
					end
				end

				arg_121_1.text_.text = var_124_11
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161029", "story_v_out_410161.awb") ~= 0 then
					local var_124_14 = manager.audio:GetVoiceLength("story_v_out_410161", "410161029", "story_v_out_410161.awb") / 1000

					if var_124_14 + var_124_8 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_14 + var_124_8
					end

					if var_124_10.prefab_name ~= "" and arg_121_1.actors_[var_124_10.prefab_name] ~= nil then
						local var_124_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_10.prefab_name].transform, "story_v_out_410161", "410161029", "story_v_out_410161.awb")

						arg_121_1:RecordAudio("410161029", var_124_15)
						arg_121_1:RecordAudio("410161029", var_124_15)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_410161", "410161029", "story_v_out_410161.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_410161", "410161029", "story_v_out_410161.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_16 = math.max(var_124_9, arg_121_1.talkMaxDuration)

			if var_124_8 <= arg_121_1.time_ and arg_121_1.time_ < var_124_8 + var_124_16 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_8) / var_124_16

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_8 + var_124_16 and arg_121_1.time_ < var_124_8 + var_124_16 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_121_1:InitPlayNodeList()
	end,
	Play410161030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 410161030
		arg_125_1.duration_ = 5.83

		local var_125_0 = {
			ja = 5.833,
			CriLanguages = 3.5,
			zh = 3.5
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
				arg_125_0:Play410161031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.var_.moveOldPos1061 = arg_125_1.actors_["1061"].transform.localPosition
				arg_125_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_125_1:CheckSpriteTmpPos("1061", 2)

				for iter_128_0 = 0, arg_125_1.actors_["1061"].transform.childCount - 1 do
					local var_128_0 = arg_125_1.actors_["1061"].transform:GetChild(iter_128_0)

					if var_128_0.name == "split_5" or not string.find(var_128_0.name, "split") then
						var_128_0.gameObject:SetActive(true)
					else
						var_128_0.gameObject:SetActive(false)
					end
				end
			end

			local var_128_1 = 0.001

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_1 then
				arg_125_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (arg_125_1.time_ - 0) / var_128_1)
			end

			if arg_125_1.time_ >= 0 + var_128_1 and arg_125_1.time_ < 0 + var_128_1 + arg_128_0 then
				arg_125_1.actors_["1061"].transform.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_128_2 = arg_125_1.actors_["1061"]

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(var_128_2) and arg_125_1.var_.actorSpriteComps1061 == nil then
				arg_125_1.var_.actorSpriteComps1061 = var_128_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_128_3 = 0.034

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_3 and not isNil(var_128_2) then
				if arg_125_1.var_.actorSpriteComps1061 then
					for iter_128_1, iter_128_2 in pairs(arg_125_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_128_2 then
							if arg_125_1.isInRecall_ then
								iter_128_2.color = Color.New(Mathf.Lerp(iter_128_2.color.r, arg_125_1.hightColor1.r, (arg_125_1.time_ - 0) / var_128_3), Mathf.Lerp(iter_128_2.color.g, arg_125_1.hightColor1.g, (arg_125_1.time_ - 0) / var_128_3), (Mathf.Lerp(iter_128_2.color.b, arg_125_1.hightColor1.b, (arg_125_1.time_ - 0) / var_128_3)))
							else
								local var_128_4 = Mathf.Lerp(iter_128_2.color.r, 1, (arg_125_1.time_ - 0) / var_128_3)

								iter_128_2.color = Color.New(var_128_4, var_128_4, var_128_4)
							end
						end
					end
				end
			end

			if arg_125_1.time_ >= 0 + var_128_3 and arg_125_1.time_ < 0 + var_128_3 + arg_128_0 and not isNil(var_128_2) and arg_125_1.var_.actorSpriteComps1061 then
				for iter_128_3, iter_128_4 in pairs(arg_125_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_128_4 then
						iter_128_4.color = arg_125_1.isInRecall_ and (arg_125_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_125_1.var_.actorSpriteComps1061 = nil
			end

			local var_128_5 = arg_125_1.actors_["10062"]

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(var_128_5) and arg_125_1.var_.actorSpriteComps10062 == nil then
				arg_125_1.var_.actorSpriteComps10062 = var_128_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_128_6 = 0.034

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_6 and not isNil(var_128_5) then
				if arg_125_1.var_.actorSpriteComps10062 then
					for iter_128_5, iter_128_6 in pairs(arg_125_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_128_6 then
							if arg_125_1.isInRecall_ then
								iter_128_6.color = Color.New(Mathf.Lerp(iter_128_6.color.r, arg_125_1.hightColor2.r, (arg_125_1.time_ - 0) / var_128_6), Mathf.Lerp(iter_128_6.color.g, arg_125_1.hightColor2.g, (arg_125_1.time_ - 0) / var_128_6), (Mathf.Lerp(iter_128_6.color.b, arg_125_1.hightColor2.b, (arg_125_1.time_ - 0) / var_128_6)))
							else
								local var_128_7 = Mathf.Lerp(iter_128_6.color.r, 0.5, (arg_125_1.time_ - 0) / var_128_6)

								iter_128_6.color = Color.New(var_128_7, var_128_7, var_128_7)
							end
						end
					end
				end
			end

			if arg_125_1.time_ >= 0 + var_128_6 and arg_125_1.time_ < 0 + var_128_6 + arg_128_0 and not isNil(var_128_5) and arg_125_1.var_.actorSpriteComps10062 then
				for iter_128_7, iter_128_8 in pairs(arg_125_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_128_8 then
						iter_128_8.color = arg_125_1.isInRecall_ and (arg_125_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_125_1.var_.actorSpriteComps10062 = nil
			end

			local var_128_8 = 0
			local var_128_9 = 0.25

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_8 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_10 = arg_125_1:GetWordFromCfg(410161030)
				local var_128_11 = arg_125_1:FormatText(var_128_10.content)

				arg_125_1.text_.text = var_128_11

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_13 = 10 <= 0 and var_128_9 or var_128_9 * (utf8.len(var_128_11) / 10)

				if (10 <= 0 and var_128_9 or var_128_9 * (utf8.len(var_128_11) / 10)) > 0 and var_128_9 < var_128_13 then
					arg_125_1.talkMaxDuration = var_128_13

					if var_128_13 + var_128_8 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_13 + var_128_8
					end
				end

				arg_125_1.text_.text = var_128_11
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161030", "story_v_out_410161.awb") ~= 0 then
					local var_128_14 = manager.audio:GetVoiceLength("story_v_out_410161", "410161030", "story_v_out_410161.awb") / 1000

					if var_128_14 + var_128_8 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_14 + var_128_8
					end

					if var_128_10.prefab_name ~= "" and arg_125_1.actors_[var_128_10.prefab_name] ~= nil then
						local var_128_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_10.prefab_name].transform, "story_v_out_410161", "410161030", "story_v_out_410161.awb")

						arg_125_1:RecordAudio("410161030", var_128_15)
						arg_125_1:RecordAudio("410161030", var_128_15)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_410161", "410161030", "story_v_out_410161.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_410161", "410161030", "story_v_out_410161.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_16 = math.max(var_128_9, arg_125_1.talkMaxDuration)

			if var_128_8 <= arg_125_1.time_ and arg_125_1.time_ < var_128_8 + var_128_16 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_8) / var_128_16

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_8 + var_128_16 and arg_125_1.time_ < var_128_8 + var_128_16 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_125_1:InitPlayNodeList()
	end,
	Play410161031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 410161031
		arg_129_1.duration_ = 13.23

		local var_129_0 = {
			ja = 13.233,
			CriLanguages = 8.933,
			zh = 8.933
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
				arg_129_0:Play410161032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.var_.moveOldPos10062 = arg_129_1.actors_["10062"].transform.localPosition
				arg_129_1.actors_["10062"].transform.localScale = Vector3.New(1, 1, 1)

				arg_129_1:CheckSpriteTmpPos("10062", 4)

				for iter_132_0 = 0, arg_129_1.actors_["10062"].transform.childCount - 1 do
					local var_132_0 = arg_129_1.actors_["10062"].transform:GetChild(iter_132_0)

					if var_132_0.name == "split_1_1" or not string.find(var_132_0.name, "split") then
						var_132_0.gameObject:SetActive(true)
					else
						var_132_0.gameObject:SetActive(false)
					end
				end
			end

			local var_132_1 = 0.001

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_1 then
				arg_129_1.actors_["10062"].transform.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos10062, Vector3.New(370, -390, -290), (arg_129_1.time_ - 0) / var_132_1)
			end

			if arg_129_1.time_ >= 0 + var_132_1 and arg_129_1.time_ < 0 + var_132_1 + arg_132_0 then
				arg_129_1.actors_["10062"].transform.localPosition = Vector3.New(370, -390, -290)
			end

			local var_132_2 = arg_129_1.actors_["10062"]

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(var_132_2) and arg_129_1.var_.actorSpriteComps10062 == nil then
				arg_129_1.var_.actorSpriteComps10062 = var_132_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_132_3 = 0.034

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_3 and not isNil(var_132_2) then
				if arg_129_1.var_.actorSpriteComps10062 then
					for iter_132_1, iter_132_2 in pairs(arg_129_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_132_2 then
							if arg_129_1.isInRecall_ then
								iter_132_2.color = Color.New(Mathf.Lerp(iter_132_2.color.r, arg_129_1.hightColor1.r, (arg_129_1.time_ - 0) / var_132_3), Mathf.Lerp(iter_132_2.color.g, arg_129_1.hightColor1.g, (arg_129_1.time_ - 0) / var_132_3), (Mathf.Lerp(iter_132_2.color.b, arg_129_1.hightColor1.b, (arg_129_1.time_ - 0) / var_132_3)))
							else
								local var_132_4 = Mathf.Lerp(iter_132_2.color.r, 1, (arg_129_1.time_ - 0) / var_132_3)

								iter_132_2.color = Color.New(var_132_4, var_132_4, var_132_4)
							end
						end
					end
				end
			end

			if arg_129_1.time_ >= 0 + var_132_3 and arg_129_1.time_ < 0 + var_132_3 + arg_132_0 and not isNil(var_132_2) and arg_129_1.var_.actorSpriteComps10062 then
				for iter_132_3, iter_132_4 in pairs(arg_129_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_132_4 then
						iter_132_4.color = arg_129_1.isInRecall_ and (arg_129_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_129_1.var_.actorSpriteComps10062 = nil
			end

			local var_132_5 = arg_129_1.actors_["1061"]

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(var_132_5) and arg_129_1.var_.actorSpriteComps1061 == nil then
				arg_129_1.var_.actorSpriteComps1061 = var_132_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_132_6 = 0.034

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_6 and not isNil(var_132_5) then
				if arg_129_1.var_.actorSpriteComps1061 then
					for iter_132_5, iter_132_6 in pairs(arg_129_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_132_6 then
							if arg_129_1.isInRecall_ then
								iter_132_6.color = Color.New(Mathf.Lerp(iter_132_6.color.r, arg_129_1.hightColor2.r, (arg_129_1.time_ - 0) / var_132_6), Mathf.Lerp(iter_132_6.color.g, arg_129_1.hightColor2.g, (arg_129_1.time_ - 0) / var_132_6), (Mathf.Lerp(iter_132_6.color.b, arg_129_1.hightColor2.b, (arg_129_1.time_ - 0) / var_132_6)))
							else
								local var_132_7 = Mathf.Lerp(iter_132_6.color.r, 0.5, (arg_129_1.time_ - 0) / var_132_6)

								iter_132_6.color = Color.New(var_132_7, var_132_7, var_132_7)
							end
						end
					end
				end
			end

			if arg_129_1.time_ >= 0 + var_132_6 and arg_129_1.time_ < 0 + var_132_6 + arg_132_0 and not isNil(var_132_5) and arg_129_1.var_.actorSpriteComps1061 then
				for iter_132_7, iter_132_8 in pairs(arg_129_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_132_8 then
						iter_132_8.color = arg_129_1.isInRecall_ and (arg_129_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_129_1.var_.actorSpriteComps1061 = nil
			end

			local var_132_8 = 0
			local var_132_9 = 0.75

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_8 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_10 = arg_129_1:GetWordFromCfg(410161031)
				local var_132_11 = arg_129_1:FormatText(var_132_10.content)

				arg_129_1.text_.text = var_132_11

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_13 = 30 <= 0 and var_132_9 or var_132_9 * (utf8.len(var_132_11) / 30)

				if (30 <= 0 and var_132_9 or var_132_9 * (utf8.len(var_132_11) / 30)) > 0 and var_132_9 < var_132_13 then
					arg_129_1.talkMaxDuration = var_132_13

					if var_132_13 + var_132_8 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_13 + var_132_8
					end
				end

				arg_129_1.text_.text = var_132_11
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161031", "story_v_out_410161.awb") ~= 0 then
					local var_132_14 = manager.audio:GetVoiceLength("story_v_out_410161", "410161031", "story_v_out_410161.awb") / 1000

					if var_132_14 + var_132_8 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_14 + var_132_8
					end

					if var_132_10.prefab_name ~= "" and arg_129_1.actors_[var_132_10.prefab_name] ~= nil then
						local var_132_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_10.prefab_name].transform, "story_v_out_410161", "410161031", "story_v_out_410161.awb")

						arg_129_1:RecordAudio("410161031", var_132_15)
						arg_129_1:RecordAudio("410161031", var_132_15)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_410161", "410161031", "story_v_out_410161.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_410161", "410161031", "story_v_out_410161.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_16 = math.max(var_132_9, arg_129_1.talkMaxDuration)

			if var_132_8 <= arg_129_1.time_ and arg_129_1.time_ < var_132_8 + var_132_16 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_8) / var_132_16

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_8 + var_132_16 and arg_129_1.time_ < var_132_8 + var_132_16 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_129_1:InitPlayNodeList()
	end,
	Play410161032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 410161032
		arg_133_1.duration_ = 17

		local var_133_0 = {
			ja = 17,
			CriLanguages = 11,
			zh = 11
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
				arg_133_0:Play410161033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.var_.moveOldPos10062 = arg_133_1.actors_["10062"].transform.localPosition
				arg_133_1.actors_["10062"].transform.localScale = Vector3.New(1, 1, 1)

				arg_133_1:CheckSpriteTmpPos("10062", 4)

				for iter_136_0 = 0, arg_133_1.actors_["10062"].transform.childCount - 1 do
					local var_136_0 = arg_133_1.actors_["10062"].transform:GetChild(iter_136_0)

					if var_136_0.name == "split_1_1" or not string.find(var_136_0.name, "split") then
						var_136_0.gameObject:SetActive(true)
					else
						var_136_0.gameObject:SetActive(false)
					end
				end
			end

			local var_136_1 = 0.001

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_1 then
				arg_133_1.actors_["10062"].transform.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos10062, Vector3.New(370, -390, -290), (arg_133_1.time_ - 0) / var_136_1)
			end

			if arg_133_1.time_ >= 0 + var_136_1 and arg_133_1.time_ < 0 + var_136_1 + arg_136_0 then
				arg_133_1.actors_["10062"].transform.localPosition = Vector3.New(370, -390, -290)
			end

			local var_136_2 = arg_133_1.actors_["10062"]

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(var_136_2) and arg_133_1.var_.actorSpriteComps10062 == nil then
				arg_133_1.var_.actorSpriteComps10062 = var_136_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_136_3 = 0.034

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_3 and not isNil(var_136_2) then
				if arg_133_1.var_.actorSpriteComps10062 then
					for iter_136_1, iter_136_2 in pairs(arg_133_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_136_2 then
							if arg_133_1.isInRecall_ then
								iter_136_2.color = Color.New(Mathf.Lerp(iter_136_2.color.r, arg_133_1.hightColor1.r, (arg_133_1.time_ - 0) / var_136_3), Mathf.Lerp(iter_136_2.color.g, arg_133_1.hightColor1.g, (arg_133_1.time_ - 0) / var_136_3), (Mathf.Lerp(iter_136_2.color.b, arg_133_1.hightColor1.b, (arg_133_1.time_ - 0) / var_136_3)))
							else
								local var_136_4 = Mathf.Lerp(iter_136_2.color.r, 1, (arg_133_1.time_ - 0) / var_136_3)

								iter_136_2.color = Color.New(var_136_4, var_136_4, var_136_4)
							end
						end
					end
				end
			end

			if arg_133_1.time_ >= 0 + var_136_3 and arg_133_1.time_ < 0 + var_136_3 + arg_136_0 and not isNil(var_136_2) and arg_133_1.var_.actorSpriteComps10062 then
				for iter_136_3, iter_136_4 in pairs(arg_133_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_136_4 then
						iter_136_4.color = arg_133_1.isInRecall_ and (arg_133_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_133_1.var_.actorSpriteComps10062 = nil
			end

			local var_136_5 = arg_133_1.actors_["1061"]

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(var_136_5) and arg_133_1.var_.actorSpriteComps1061 == nil then
				arg_133_1.var_.actorSpriteComps1061 = var_136_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_136_6 = 0.034

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_6 and not isNil(var_136_5) then
				if arg_133_1.var_.actorSpriteComps1061 then
					for iter_136_5, iter_136_6 in pairs(arg_133_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_136_6 then
							if arg_133_1.isInRecall_ then
								iter_136_6.color = Color.New(Mathf.Lerp(iter_136_6.color.r, arg_133_1.hightColor2.r, (arg_133_1.time_ - 0) / var_136_6), Mathf.Lerp(iter_136_6.color.g, arg_133_1.hightColor2.g, (arg_133_1.time_ - 0) / var_136_6), (Mathf.Lerp(iter_136_6.color.b, arg_133_1.hightColor2.b, (arg_133_1.time_ - 0) / var_136_6)))
							else
								local var_136_7 = Mathf.Lerp(iter_136_6.color.r, 0.5, (arg_133_1.time_ - 0) / var_136_6)

								iter_136_6.color = Color.New(var_136_7, var_136_7, var_136_7)
							end
						end
					end
				end
			end

			if arg_133_1.time_ >= 0 + var_136_6 and arg_133_1.time_ < 0 + var_136_6 + arg_136_0 and not isNil(var_136_5) and arg_133_1.var_.actorSpriteComps1061 then
				for iter_136_7, iter_136_8 in pairs(arg_133_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_136_8 then
						iter_136_8.color = arg_133_1.isInRecall_ and (arg_133_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_133_1.var_.actorSpriteComps1061 = nil
			end

			local var_136_8 = 0
			local var_136_9 = 1.025

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_8 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_10 = arg_133_1:GetWordFromCfg(410161032)
				local var_136_11 = arg_133_1:FormatText(var_136_10.content)

				arg_133_1.text_.text = var_136_11

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_13 = 41 <= 0 and var_136_9 or var_136_9 * (utf8.len(var_136_11) / 41)

				if (41 <= 0 and var_136_9 or var_136_9 * (utf8.len(var_136_11) / 41)) > 0 and var_136_9 < var_136_13 then
					arg_133_1.talkMaxDuration = var_136_13

					if var_136_13 + var_136_8 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_13 + var_136_8
					end
				end

				arg_133_1.text_.text = var_136_11
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161032", "story_v_out_410161.awb") ~= 0 then
					local var_136_14 = manager.audio:GetVoiceLength("story_v_out_410161", "410161032", "story_v_out_410161.awb") / 1000

					if var_136_14 + var_136_8 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_14 + var_136_8
					end

					if var_136_10.prefab_name ~= "" and arg_133_1.actors_[var_136_10.prefab_name] ~= nil then
						local var_136_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_10.prefab_name].transform, "story_v_out_410161", "410161032", "story_v_out_410161.awb")

						arg_133_1:RecordAudio("410161032", var_136_15)
						arg_133_1:RecordAudio("410161032", var_136_15)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_410161", "410161032", "story_v_out_410161.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_410161", "410161032", "story_v_out_410161.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_16 = math.max(var_136_9, arg_133_1.talkMaxDuration)

			if var_136_8 <= arg_133_1.time_ and arg_133_1.time_ < var_136_8 + var_136_16 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_8) / var_136_16

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_8 + var_136_16 and arg_133_1.time_ < var_136_8 + var_136_16 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_133_1:InitPlayNodeList()
	end,
	Play410161033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 410161033
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play410161034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(arg_137_1.actors_["10062"]) and arg_137_1.var_.actorSpriteComps10062 == nil then
				arg_137_1.var_.actorSpriteComps10062 = arg_137_1.actors_["10062"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_140_0 = 0.034

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_0 and not isNil(arg_137_1.actors_["10062"]) then
				if arg_137_1.var_.actorSpriteComps10062 then
					for iter_140_0, iter_140_1 in pairs(arg_137_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_140_1 then
							if arg_137_1.isInRecall_ then
								iter_140_1.color = Color.New(Mathf.Lerp(iter_140_1.color.r, arg_137_1.hightColor2.r, (arg_137_1.time_ - 0) / var_140_0), Mathf.Lerp(iter_140_1.color.g, arg_137_1.hightColor2.g, (arg_137_1.time_ - 0) / var_140_0), (Mathf.Lerp(iter_140_1.color.b, arg_137_1.hightColor2.b, (arg_137_1.time_ - 0) / var_140_0)))
							else
								local var_140_1 = Mathf.Lerp(iter_140_1.color.r, 0.5, (arg_137_1.time_ - 0) / var_140_0)

								iter_140_1.color = Color.New(var_140_1, var_140_1, var_140_1)
							end
						end
					end
				end
			end

			if arg_137_1.time_ >= 0 + var_140_0 and arg_137_1.time_ < 0 + var_140_0 + arg_140_0 and not isNil(arg_137_1.actors_["10062"]) and arg_137_1.var_.actorSpriteComps10062 then
				for iter_140_2, iter_140_3 in pairs(arg_137_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_140_3 then
						iter_140_3.color = arg_137_1.isInRecall_ and (arg_137_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_137_1.var_.actorSpriteComps10062 = nil
			end

			local var_140_2 = arg_137_1.actors_["1061"]

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(var_140_2) and arg_137_1.var_.actorSpriteComps1061 == nil then
				arg_137_1.var_.actorSpriteComps1061 = var_140_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_140_3 = 0.034

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_3 and not isNil(var_140_2) then
				if arg_137_1.var_.actorSpriteComps1061 then
					for iter_140_4, iter_140_5 in pairs(arg_137_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_140_5 then
							if arg_137_1.isInRecall_ then
								iter_140_5.color = Color.New(Mathf.Lerp(iter_140_5.color.r, arg_137_1.hightColor2.r, (arg_137_1.time_ - 0) / var_140_3), Mathf.Lerp(iter_140_5.color.g, arg_137_1.hightColor2.g, (arg_137_1.time_ - 0) / var_140_3), (Mathf.Lerp(iter_140_5.color.b, arg_137_1.hightColor2.b, (arg_137_1.time_ - 0) / var_140_3)))
							else
								local var_140_4 = Mathf.Lerp(iter_140_5.color.r, 0.5, (arg_137_1.time_ - 0) / var_140_3)

								iter_140_5.color = Color.New(var_140_4, var_140_4, var_140_4)
							end
						end
					end
				end
			end

			if arg_137_1.time_ >= 0 + var_140_3 and arg_137_1.time_ < 0 + var_140_3 + arg_140_0 and not isNil(var_140_2) and arg_137_1.var_.actorSpriteComps1061 then
				for iter_140_6, iter_140_7 in pairs(arg_137_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_140_7 then
						iter_140_7.color = arg_137_1.isInRecall_ and (arg_137_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_137_1.var_.actorSpriteComps1061 = nil
			end

			local var_140_5 = 0
			local var_140_6 = 1.525

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_5 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, false)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_7 = arg_137_1:FormatText(arg_137_1:GetWordFromCfg(410161033).content)

				arg_137_1.text_.text = var_140_7

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_9 = 61 <= 0 and var_140_6 or var_140_6 * (utf8.len(var_140_7) / 61)

				if (61 <= 0 and var_140_6 or var_140_6 * (utf8.len(var_140_7) / 61)) > 0 and var_140_6 < var_140_9 then
					arg_137_1.talkMaxDuration = var_140_9

					if var_140_9 + var_140_5 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_9 + var_140_5
					end
				end

				arg_137_1.text_.text = var_140_7
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_10 = math.max(var_140_6, arg_137_1.talkMaxDuration)

			if var_140_5 <= arg_137_1.time_ and arg_137_1.time_ < var_140_5 + var_140_10 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_5) / var_140_10

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_5 + var_140_10 and arg_137_1.time_ < var_140_5 + var_140_10 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play410161034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 410161034
		arg_141_1.duration_ = 5

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play410161035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = 1

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, false)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_1 = arg_141_1:FormatText(arg_141_1:GetWordFromCfg(410161034).content)

				arg_141_1.text_.text = var_144_1

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_3 = 40 <= 0 and var_144_0 or var_144_0 * (utf8.len(var_144_1) / 40)

				if (40 <= 0 and var_144_0 or var_144_0 * (utf8.len(var_144_1) / 40)) > 0 and var_144_0 < var_144_3 then
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
	Play410161035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 410161035
		arg_145_1.duration_ = 5

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play410161036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = 0.375

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, false)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_1 = arg_145_1:FormatText(arg_145_1:GetWordFromCfg(410161035).content)

				arg_145_1.text_.text = var_148_1

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_3 = 15 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_1) / 15)

				if (15 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_1) / 15)) > 0 and var_148_0 < var_148_3 then
					arg_145_1.talkMaxDuration = var_148_3

					if var_148_3 + 0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_3 + 0
					end
				end

				arg_145_1.text_.text = var_148_1
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_4 = math.max(var_148_0, arg_145_1.talkMaxDuration)

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_4 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - 0) / var_148_4

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= 0 + var_148_4 and arg_145_1.time_ < 0 + var_148_4 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play410161036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 410161036
		arg_149_1.duration_ = 11.73

		local var_149_0 = {
			ja = 10.833,
			CriLanguages = 11.733,
			zh = 11.733
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
				arg_149_0:Play410161037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.var_.moveOldPos10062 = arg_149_1.actors_["10062"].transform.localPosition
				arg_149_1.actors_["10062"].transform.localScale = Vector3.New(1, 1, 1)

				arg_149_1:CheckSpriteTmpPos("10062", 4)

				for iter_152_0 = 0, arg_149_1.actors_["10062"].transform.childCount - 1 do
					local var_152_0 = arg_149_1.actors_["10062"].transform:GetChild(iter_152_0)

					if var_152_0.name == "split_2" or not string.find(var_152_0.name, "split") then
						var_152_0.gameObject:SetActive(true)
					else
						var_152_0.gameObject:SetActive(false)
					end
				end
			end

			local var_152_1 = 0.001

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_1 then
				arg_149_1.actors_["10062"].transform.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos10062, Vector3.New(370, -390, -290), (arg_149_1.time_ - 0) / var_152_1)
			end

			if arg_149_1.time_ >= 0 + var_152_1 and arg_149_1.time_ < 0 + var_152_1 + arg_152_0 then
				arg_149_1.actors_["10062"].transform.localPosition = Vector3.New(370, -390, -290)
			end

			local var_152_2 = arg_149_1.actors_["10062"]

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(var_152_2) and arg_149_1.var_.actorSpriteComps10062 == nil then
				arg_149_1.var_.actorSpriteComps10062 = var_152_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_152_3 = 0.034

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_3 and not isNil(var_152_2) then
				if arg_149_1.var_.actorSpriteComps10062 then
					for iter_152_1, iter_152_2 in pairs(arg_149_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_152_2 then
							if arg_149_1.isInRecall_ then
								iter_152_2.color = Color.New(Mathf.Lerp(iter_152_2.color.r, arg_149_1.hightColor1.r, (arg_149_1.time_ - 0) / var_152_3), Mathf.Lerp(iter_152_2.color.g, arg_149_1.hightColor1.g, (arg_149_1.time_ - 0) / var_152_3), (Mathf.Lerp(iter_152_2.color.b, arg_149_1.hightColor1.b, (arg_149_1.time_ - 0) / var_152_3)))
							else
								local var_152_4 = Mathf.Lerp(iter_152_2.color.r, 1, (arg_149_1.time_ - 0) / var_152_3)

								iter_152_2.color = Color.New(var_152_4, var_152_4, var_152_4)
							end
						end
					end
				end
			end

			if arg_149_1.time_ >= 0 + var_152_3 and arg_149_1.time_ < 0 + var_152_3 + arg_152_0 and not isNil(var_152_2) and arg_149_1.var_.actorSpriteComps10062 then
				for iter_152_3, iter_152_4 in pairs(arg_149_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_152_4 then
						iter_152_4.color = arg_149_1.isInRecall_ and (arg_149_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_149_1.var_.actorSpriteComps10062 = nil
			end

			local var_152_5 = arg_149_1.actors_["1061"]

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(var_152_5) and arg_149_1.var_.actorSpriteComps1061 == nil then
				arg_149_1.var_.actorSpriteComps1061 = var_152_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_152_6 = 0.034

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_6 and not isNil(var_152_5) then
				if arg_149_1.var_.actorSpriteComps1061 then
					for iter_152_5, iter_152_6 in pairs(arg_149_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_152_6 then
							if arg_149_1.isInRecall_ then
								iter_152_6.color = Color.New(Mathf.Lerp(iter_152_6.color.r, arg_149_1.hightColor2.r, (arg_149_1.time_ - 0) / var_152_6), Mathf.Lerp(iter_152_6.color.g, arg_149_1.hightColor2.g, (arg_149_1.time_ - 0) / var_152_6), (Mathf.Lerp(iter_152_6.color.b, arg_149_1.hightColor2.b, (arg_149_1.time_ - 0) / var_152_6)))
							else
								local var_152_7 = Mathf.Lerp(iter_152_6.color.r, 0.5, (arg_149_1.time_ - 0) / var_152_6)

								iter_152_6.color = Color.New(var_152_7, var_152_7, var_152_7)
							end
						end
					end
				end
			end

			if arg_149_1.time_ >= 0 + var_152_6 and arg_149_1.time_ < 0 + var_152_6 + arg_152_0 and not isNil(var_152_5) and arg_149_1.var_.actorSpriteComps1061 then
				for iter_152_7, iter_152_8 in pairs(arg_149_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_152_8 then
						iter_152_8.color = arg_149_1.isInRecall_ and (arg_149_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_149_1.var_.actorSpriteComps1061 = nil
			end

			local var_152_8 = 0
			local var_152_9 = 0.85

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_8 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_10 = arg_149_1:GetWordFromCfg(410161036)
				local var_152_11 = arg_149_1:FormatText(var_152_10.content)

				arg_149_1.text_.text = var_152_11

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_13 = 34 <= 0 and var_152_9 or var_152_9 * (utf8.len(var_152_11) / 34)

				if (34 <= 0 and var_152_9 or var_152_9 * (utf8.len(var_152_11) / 34)) > 0 and var_152_9 < var_152_13 then
					arg_149_1.talkMaxDuration = var_152_13

					if var_152_13 + var_152_8 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_13 + var_152_8
					end
				end

				arg_149_1.text_.text = var_152_11
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161036", "story_v_out_410161.awb") ~= 0 then
					local var_152_14 = manager.audio:GetVoiceLength("story_v_out_410161", "410161036", "story_v_out_410161.awb") / 1000

					if var_152_14 + var_152_8 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_14 + var_152_8
					end

					if var_152_10.prefab_name ~= "" and arg_149_1.actors_[var_152_10.prefab_name] ~= nil then
						local var_152_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_10.prefab_name].transform, "story_v_out_410161", "410161036", "story_v_out_410161.awb")

						arg_149_1:RecordAudio("410161036", var_152_15)
						arg_149_1:RecordAudio("410161036", var_152_15)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_410161", "410161036", "story_v_out_410161.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_410161", "410161036", "story_v_out_410161.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_16 = math.max(var_152_9, arg_149_1.talkMaxDuration)

			if var_152_8 <= arg_149_1.time_ and arg_149_1.time_ < var_152_8 + var_152_16 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_8) / var_152_16

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_8 + var_152_16 and arg_149_1.time_ < var_152_8 + var_152_16 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_149_1:InitPlayNodeList()
	end,
	Play410161037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 410161037
		arg_153_1.duration_ = 1.4

		local var_153_0 = {
			ja = 1,
			CriLanguages = 1.4,
			zh = 1.4
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
				arg_153_0:Play410161038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.var_.moveOldPos1061 = arg_153_1.actors_["1061"].transform.localPosition
				arg_153_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_153_1:CheckSpriteTmpPos("1061", 2)

				for iter_156_0 = 0, arg_153_1.actors_["1061"].transform.childCount - 1 do
					local var_156_0 = arg_153_1.actors_["1061"].transform:GetChild(iter_156_0)

					if var_156_0.name == "" or not string.find(var_156_0.name, "split") then
						var_156_0.gameObject:SetActive(true)
					else
						var_156_0.gameObject:SetActive(false)
					end
				end
			end

			local var_156_1 = 0.001

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_1 then
				arg_153_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (arg_153_1.time_ - 0) / var_156_1)
			end

			if arg_153_1.time_ >= 0 + var_156_1 and arg_153_1.time_ < 0 + var_156_1 + arg_156_0 then
				arg_153_1.actors_["1061"].transform.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_156_2 = arg_153_1.actors_["1061"]

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(var_156_2) and arg_153_1.var_.actorSpriteComps1061 == nil then
				arg_153_1.var_.actorSpriteComps1061 = var_156_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_156_3 = 0.034

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_3 and not isNil(var_156_2) then
				if arg_153_1.var_.actorSpriteComps1061 then
					for iter_156_1, iter_156_2 in pairs(arg_153_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_156_2 then
							if arg_153_1.isInRecall_ then
								iter_156_2.color = Color.New(Mathf.Lerp(iter_156_2.color.r, arg_153_1.hightColor1.r, (arg_153_1.time_ - 0) / var_156_3), Mathf.Lerp(iter_156_2.color.g, arg_153_1.hightColor1.g, (arg_153_1.time_ - 0) / var_156_3), (Mathf.Lerp(iter_156_2.color.b, arg_153_1.hightColor1.b, (arg_153_1.time_ - 0) / var_156_3)))
							else
								local var_156_4 = Mathf.Lerp(iter_156_2.color.r, 1, (arg_153_1.time_ - 0) / var_156_3)

								iter_156_2.color = Color.New(var_156_4, var_156_4, var_156_4)
							end
						end
					end
				end
			end

			if arg_153_1.time_ >= 0 + var_156_3 and arg_153_1.time_ < 0 + var_156_3 + arg_156_0 and not isNil(var_156_2) and arg_153_1.var_.actorSpriteComps1061 then
				for iter_156_3, iter_156_4 in pairs(arg_153_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_156_4 then
						iter_156_4.color = arg_153_1.isInRecall_ and (arg_153_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_153_1.var_.actorSpriteComps1061 = nil
			end

			local var_156_5 = arg_153_1.actors_["10062"]

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(var_156_5) and arg_153_1.var_.actorSpriteComps10062 == nil then
				arg_153_1.var_.actorSpriteComps10062 = var_156_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_156_6 = 0.034

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_6 and not isNil(var_156_5) then
				if arg_153_1.var_.actorSpriteComps10062 then
					for iter_156_5, iter_156_6 in pairs(arg_153_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_156_6 then
							if arg_153_1.isInRecall_ then
								iter_156_6.color = Color.New(Mathf.Lerp(iter_156_6.color.r, arg_153_1.hightColor2.r, (arg_153_1.time_ - 0) / var_156_6), Mathf.Lerp(iter_156_6.color.g, arg_153_1.hightColor2.g, (arg_153_1.time_ - 0) / var_156_6), (Mathf.Lerp(iter_156_6.color.b, arg_153_1.hightColor2.b, (arg_153_1.time_ - 0) / var_156_6)))
							else
								local var_156_7 = Mathf.Lerp(iter_156_6.color.r, 0.5, (arg_153_1.time_ - 0) / var_156_6)

								iter_156_6.color = Color.New(var_156_7, var_156_7, var_156_7)
							end
						end
					end
				end
			end

			if arg_153_1.time_ >= 0 + var_156_6 and arg_153_1.time_ < 0 + var_156_6 + arg_156_0 and not isNil(var_156_5) and arg_153_1.var_.actorSpriteComps10062 then
				for iter_156_7, iter_156_8 in pairs(arg_153_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_156_8 then
						iter_156_8.color = arg_153_1.isInRecall_ and (arg_153_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_153_1.var_.actorSpriteComps10062 = nil
			end

			local var_156_8 = 0
			local var_156_9 = 0.05

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_8 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_10 = arg_153_1:GetWordFromCfg(410161037)
				local var_156_11 = arg_153_1:FormatText(var_156_10.content)

				arg_153_1.text_.text = var_156_11

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_13 = 2 <= 0 and var_156_9 or var_156_9 * (utf8.len(var_156_11) / 2)

				if (2 <= 0 and var_156_9 or var_156_9 * (utf8.len(var_156_11) / 2)) > 0 and var_156_9 < var_156_13 then
					arg_153_1.talkMaxDuration = var_156_13

					if var_156_13 + var_156_8 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_13 + var_156_8
					end
				end

				arg_153_1.text_.text = var_156_11
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161037", "story_v_out_410161.awb") ~= 0 then
					local var_156_14 = manager.audio:GetVoiceLength("story_v_out_410161", "410161037", "story_v_out_410161.awb") / 1000

					if var_156_14 + var_156_8 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_14 + var_156_8
					end

					if var_156_10.prefab_name ~= "" and arg_153_1.actors_[var_156_10.prefab_name] ~= nil then
						local var_156_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_10.prefab_name].transform, "story_v_out_410161", "410161037", "story_v_out_410161.awb")

						arg_153_1:RecordAudio("410161037", var_156_15)
						arg_153_1:RecordAudio("410161037", var_156_15)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_410161", "410161037", "story_v_out_410161.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_410161", "410161037", "story_v_out_410161.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_16 = math.max(var_156_9, arg_153_1.talkMaxDuration)

			if var_156_8 <= arg_153_1.time_ and arg_153_1.time_ < var_156_8 + var_156_16 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_8) / var_156_16

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_8 + var_156_16 and arg_153_1.time_ < var_156_8 + var_156_16 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_153_1:InitPlayNodeList()
	end,
	Play410161038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 410161038
		arg_157_1.duration_ = 5.6

		local var_157_0 = {
			ja = 5.6,
			CriLanguages = 4.633,
			zh = 4.633
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
				arg_157_0:Play410161039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.var_.moveOldPos10059 = arg_157_1.actors_["10059"].transform.localPosition
				arg_157_1.actors_["10059"].transform.localScale = Vector3.New(1, 1, 1)

				arg_157_1:CheckSpriteTmpPos("10059", 4)

				for iter_160_0 = 0, arg_157_1.actors_["10059"].transform.childCount - 1 do
					local var_160_0 = arg_157_1.actors_["10059"].transform:GetChild(iter_160_0)

					if var_160_0.name == "split_5" or not string.find(var_160_0.name, "split") then
						var_160_0.gameObject:SetActive(true)
					else
						var_160_0.gameObject:SetActive(false)
					end
				end
			end

			local var_160_1 = 0.001

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_1 then
				arg_157_1.actors_["10059"].transform.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos10059, Vector3.New(390, -530, 35), (arg_157_1.time_ - 0) / var_160_1)
			end

			if arg_157_1.time_ >= 0 + var_160_1 and arg_157_1.time_ < 0 + var_160_1 + arg_160_0 then
				arg_157_1.actors_["10059"].transform.localPosition = Vector3.New(390, -530, 35)
			end

			local var_160_2 = arg_157_1.actors_["10062"].transform

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.var_.moveOldPos10062 = var_160_2.localPosition
				var_160_2.localScale = Vector3.New(1, 1, 1)

				arg_157_1:CheckSpriteTmpPos("10062", 7)

				for iter_160_1 = 0, var_160_2.childCount - 1 do
					local var_160_3 = var_160_2:GetChild(iter_160_1)

					if var_160_3.name == "" or not string.find(var_160_3.name, "split") then
						var_160_3.gameObject:SetActive(true)
					else
						var_160_3.gameObject:SetActive(false)
					end
				end
			end

			local var_160_4 = 0.001

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_4 then
				var_160_2.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos10062, Vector3.New(0, -2000, -290), (arg_157_1.time_ - 0) / var_160_4)
			end

			if arg_157_1.time_ >= 0 + var_160_4 and arg_157_1.time_ < 0 + var_160_4 + arg_160_0 then
				var_160_2.localPosition = Vector3.New(0, -2000, -290)
			end

			local var_160_5 = arg_157_1.actors_["10059"]

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(var_160_5) and arg_157_1.var_.actorSpriteComps10059 == nil then
				arg_157_1.var_.actorSpriteComps10059 = var_160_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_160_6 = 0.034

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_6 and not isNil(var_160_5) then
				if arg_157_1.var_.actorSpriteComps10059 then
					for iter_160_2, iter_160_3 in pairs(arg_157_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_160_3 then
							if arg_157_1.isInRecall_ then
								iter_160_3.color = Color.New(Mathf.Lerp(iter_160_3.color.r, arg_157_1.hightColor1.r, (arg_157_1.time_ - 0) / var_160_6), Mathf.Lerp(iter_160_3.color.g, arg_157_1.hightColor1.g, (arg_157_1.time_ - 0) / var_160_6), (Mathf.Lerp(iter_160_3.color.b, arg_157_1.hightColor1.b, (arg_157_1.time_ - 0) / var_160_6)))
							else
								local var_160_7 = Mathf.Lerp(iter_160_3.color.r, 1, (arg_157_1.time_ - 0) / var_160_6)

								iter_160_3.color = Color.New(var_160_7, var_160_7, var_160_7)
							end
						end
					end
				end
			end

			if arg_157_1.time_ >= 0 + var_160_6 and arg_157_1.time_ < 0 + var_160_6 + arg_160_0 and not isNil(var_160_5) and arg_157_1.var_.actorSpriteComps10059 then
				for iter_160_4, iter_160_5 in pairs(arg_157_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_160_5 then
						iter_160_5.color = arg_157_1.isInRecall_ and (arg_157_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_157_1.var_.actorSpriteComps10059 = nil
			end

			local var_160_8 = arg_157_1.actors_["10062"]

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(var_160_8) and arg_157_1.var_.actorSpriteComps10062 == nil then
				arg_157_1.var_.actorSpriteComps10062 = var_160_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_160_9 = 0.034

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_9 and not isNil(var_160_8) then
				if arg_157_1.var_.actorSpriteComps10062 then
					for iter_160_6, iter_160_7 in pairs(arg_157_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_160_7 then
							if arg_157_1.isInRecall_ then
								iter_160_7.color = Color.New(Mathf.Lerp(iter_160_7.color.r, arg_157_1.hightColor2.r, (arg_157_1.time_ - 0) / var_160_9), Mathf.Lerp(iter_160_7.color.g, arg_157_1.hightColor2.g, (arg_157_1.time_ - 0) / var_160_9), (Mathf.Lerp(iter_160_7.color.b, arg_157_1.hightColor2.b, (arg_157_1.time_ - 0) / var_160_9)))
							else
								local var_160_10 = Mathf.Lerp(iter_160_7.color.r, 0.5, (arg_157_1.time_ - 0) / var_160_9)

								iter_160_7.color = Color.New(var_160_10, var_160_10, var_160_10)
							end
						end
					end
				end
			end

			if arg_157_1.time_ >= 0 + var_160_9 and arg_157_1.time_ < 0 + var_160_9 + arg_160_0 and not isNil(var_160_8) and arg_157_1.var_.actorSpriteComps10062 then
				for iter_160_8, iter_160_9 in pairs(arg_157_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_160_9 then
						iter_160_9.color = arg_157_1.isInRecall_ and (arg_157_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_157_1.var_.actorSpriteComps10062 = nil
			end

			local var_160_11 = arg_157_1.actors_["1061"]

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(var_160_11) and arg_157_1.var_.actorSpriteComps1061 == nil then
				arg_157_1.var_.actorSpriteComps1061 = var_160_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_160_12 = 0.034

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_12 and not isNil(var_160_11) then
				if arg_157_1.var_.actorSpriteComps1061 then
					for iter_160_10, iter_160_11 in pairs(arg_157_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_160_11 then
							if arg_157_1.isInRecall_ then
								iter_160_11.color = Color.New(Mathf.Lerp(iter_160_11.color.r, arg_157_1.hightColor2.r, (arg_157_1.time_ - 0) / var_160_12), Mathf.Lerp(iter_160_11.color.g, arg_157_1.hightColor2.g, (arg_157_1.time_ - 0) / var_160_12), (Mathf.Lerp(iter_160_11.color.b, arg_157_1.hightColor2.b, (arg_157_1.time_ - 0) / var_160_12)))
							else
								local var_160_13 = Mathf.Lerp(iter_160_11.color.r, 0.5, (arg_157_1.time_ - 0) / var_160_12)

								iter_160_11.color = Color.New(var_160_13, var_160_13, var_160_13)
							end
						end
					end
				end
			end

			if arg_157_1.time_ >= 0 + var_160_12 and arg_157_1.time_ < 0 + var_160_12 + arg_160_0 and not isNil(var_160_11) and arg_157_1.var_.actorSpriteComps1061 then
				for iter_160_12, iter_160_13 in pairs(arg_157_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_160_13 then
						iter_160_13.color = arg_157_1.isInRecall_ and (arg_157_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_157_1.var_.actorSpriteComps1061 = nil
			end

			local var_160_14 = 0
			local var_160_15 = 0.45

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_14 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[596].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_16 = arg_157_1:GetWordFromCfg(410161038)
				local var_160_17 = arg_157_1:FormatText(var_160_16.content)

				arg_157_1.text_.text = var_160_17

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_19 = 18 <= 0 and var_160_15 or var_160_15 * (utf8.len(var_160_17) / 18)

				if (18 <= 0 and var_160_15 or var_160_15 * (utf8.len(var_160_17) / 18)) > 0 and var_160_15 < var_160_19 then
					arg_157_1.talkMaxDuration = var_160_19

					if var_160_19 + var_160_14 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_19 + var_160_14
					end
				end

				arg_157_1.text_.text = var_160_17
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161038", "story_v_out_410161.awb") ~= 0 then
					local var_160_20 = manager.audio:GetVoiceLength("story_v_out_410161", "410161038", "story_v_out_410161.awb") / 1000

					if var_160_20 + var_160_14 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_20 + var_160_14
					end

					if var_160_16.prefab_name ~= "" and arg_157_1.actors_[var_160_16.prefab_name] ~= nil then
						local var_160_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_16.prefab_name].transform, "story_v_out_410161", "410161038", "story_v_out_410161.awb")

						arg_157_1:RecordAudio("410161038", var_160_21)
						arg_157_1:RecordAudio("410161038", var_160_21)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_410161", "410161038", "story_v_out_410161.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_410161", "410161038", "story_v_out_410161.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_22 = math.max(var_160_15, arg_157_1.talkMaxDuration)

			if var_160_14 <= arg_157_1.time_ and arg_157_1.time_ < var_160_14 + var_160_22 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_14) / var_160_22

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_14 + var_160_22 and arg_157_1.time_ < var_160_14 + var_160_22 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10062",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_157_1:InitPlayNodeList()
	end,
	Play410161039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 410161039
		arg_161_1.duration_ = 7.9

		local var_161_0 = {
			ja = 7.9,
			CriLanguages = 2.833,
			zh = 2.833
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
				arg_161_0:Play410161040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.var_.moveOldPos10059 = arg_161_1.actors_["10059"].transform.localPosition
				arg_161_1.actors_["10059"].transform.localScale = Vector3.New(1, 1, 1)

				arg_161_1:CheckSpriteTmpPos("10059", 7)

				for iter_164_0 = 0, arg_161_1.actors_["10059"].transform.childCount - 1 do
					local var_164_0 = arg_161_1.actors_["10059"].transform:GetChild(iter_164_0)

					if var_164_0.name == "split_1" or not string.find(var_164_0.name, "split") then
						var_164_0.gameObject:SetActive(true)
					else
						var_164_0.gameObject:SetActive(false)
					end
				end
			end

			local var_164_1 = 0.001

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_1 then
				arg_161_1.actors_["10059"].transform.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos10059, Vector3.New(0, -2000, 35), (arg_161_1.time_ - 0) / var_164_1)
			end

			if arg_161_1.time_ >= 0 + var_164_1 and arg_161_1.time_ < 0 + var_164_1 + arg_164_0 then
				arg_161_1.actors_["10059"].transform.localPosition = Vector3.New(0, -2000, 35)
			end

			local var_164_2 = arg_161_1.actors_["10059"]

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(var_164_2) and arg_161_1.var_.actorSpriteComps10059 == nil then
				arg_161_1.var_.actorSpriteComps10059 = var_164_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_164_3 = 0.034

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_3 and not isNil(var_164_2) then
				if arg_161_1.var_.actorSpriteComps10059 then
					for iter_164_1, iter_164_2 in pairs(arg_161_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_164_2 then
							if arg_161_1.isInRecall_ then
								iter_164_2.color = Color.New(Mathf.Lerp(iter_164_2.color.r, arg_161_1.hightColor2.r, (arg_161_1.time_ - 0) / var_164_3), Mathf.Lerp(iter_164_2.color.g, arg_161_1.hightColor2.g, (arg_161_1.time_ - 0) / var_164_3), (Mathf.Lerp(iter_164_2.color.b, arg_161_1.hightColor2.b, (arg_161_1.time_ - 0) / var_164_3)))
							else
								local var_164_4 = Mathf.Lerp(iter_164_2.color.r, 0.5, (arg_161_1.time_ - 0) / var_164_3)

								iter_164_2.color = Color.New(var_164_4, var_164_4, var_164_4)
							end
						end
					end
				end
			end

			if arg_161_1.time_ >= 0 + var_164_3 and arg_161_1.time_ < 0 + var_164_3 + arg_164_0 and not isNil(var_164_2) and arg_161_1.var_.actorSpriteComps10059 then
				for iter_164_3, iter_164_4 in pairs(arg_161_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_164_4 then
						iter_164_4.color = arg_161_1.isInRecall_ and (arg_161_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_161_1.var_.actorSpriteComps10059 = nil
			end

			local var_164_5 = arg_161_1.actors_["10062"].transform

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.var_.moveOldPos10062 = var_164_5.localPosition
				var_164_5.localScale = Vector3.New(1, 1, 1)

				arg_161_1:CheckSpriteTmpPos("10062", 4)

				for iter_164_5 = 0, var_164_5.childCount - 1 do
					local var_164_6 = var_164_5:GetChild(iter_164_5)

					if var_164_6.name == "split_1_1" or not string.find(var_164_6.name, "split") then
						var_164_6.gameObject:SetActive(true)
					else
						var_164_6.gameObject:SetActive(false)
					end
				end
			end

			local var_164_7 = 0.001

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_7 then
				var_164_5.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos10062, Vector3.New(370, -390, -290), (arg_161_1.time_ - 0) / var_164_7)
			end

			if arg_161_1.time_ >= 0 + var_164_7 and arg_161_1.time_ < 0 + var_164_7 + arg_164_0 then
				var_164_5.localPosition = Vector3.New(370, -390, -290)
			end

			local var_164_8 = arg_161_1.actors_["10062"]

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(var_164_8) and arg_161_1.var_.actorSpriteComps10062 == nil then
				arg_161_1.var_.actorSpriteComps10062 = var_164_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_164_9 = 0.034

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_9 and not isNil(var_164_8) then
				if arg_161_1.var_.actorSpriteComps10062 then
					for iter_164_6, iter_164_7 in pairs(arg_161_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_164_7 then
							if arg_161_1.isInRecall_ then
								iter_164_7.color = Color.New(Mathf.Lerp(iter_164_7.color.r, arg_161_1.hightColor1.r, (arg_161_1.time_ - 0) / var_164_9), Mathf.Lerp(iter_164_7.color.g, arg_161_1.hightColor1.g, (arg_161_1.time_ - 0) / var_164_9), (Mathf.Lerp(iter_164_7.color.b, arg_161_1.hightColor1.b, (arg_161_1.time_ - 0) / var_164_9)))
							else
								local var_164_10 = Mathf.Lerp(iter_164_7.color.r, 1, (arg_161_1.time_ - 0) / var_164_9)

								iter_164_7.color = Color.New(var_164_10, var_164_10, var_164_10)
							end
						end
					end
				end
			end

			if arg_161_1.time_ >= 0 + var_164_9 and arg_161_1.time_ < 0 + var_164_9 + arg_164_0 and not isNil(var_164_8) and arg_161_1.var_.actorSpriteComps10062 then
				for iter_164_8, iter_164_9 in pairs(arg_161_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_164_9 then
						iter_164_9.color = arg_161_1.isInRecall_ and (arg_161_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_161_1.var_.actorSpriteComps10062 = nil
			end

			local var_164_11 = 0
			local var_164_12 = 0.175

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_11 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_13 = arg_161_1:GetWordFromCfg(410161039)
				local var_164_14 = arg_161_1:FormatText(var_164_13.content)

				arg_161_1.text_.text = var_164_14

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_16 = 7 <= 0 and var_164_12 or var_164_12 * (utf8.len(var_164_14) / 7)

				if (7 <= 0 and var_164_12 or var_164_12 * (utf8.len(var_164_14) / 7)) > 0 and var_164_12 < var_164_16 then
					arg_161_1.talkMaxDuration = var_164_16

					if var_164_16 + var_164_11 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_16 + var_164_11
					end
				end

				arg_161_1.text_.text = var_164_14
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161039", "story_v_out_410161.awb") ~= 0 then
					local var_164_17 = manager.audio:GetVoiceLength("story_v_out_410161", "410161039", "story_v_out_410161.awb") / 1000

					if var_164_17 + var_164_11 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_17 + var_164_11
					end

					if var_164_13.prefab_name ~= "" and arg_161_1.actors_[var_164_13.prefab_name] ~= nil then
						local var_164_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_13.prefab_name].transform, "story_v_out_410161", "410161039", "story_v_out_410161.awb")

						arg_161_1:RecordAudio("410161039", var_164_18)
						arg_161_1:RecordAudio("410161039", var_164_18)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_410161", "410161039", "story_v_out_410161.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_410161", "410161039", "story_v_out_410161.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_19 = math.max(var_164_12, arg_161_1.talkMaxDuration)

			if var_164_11 <= arg_161_1.time_ and arg_161_1.time_ < var_164_11 + var_164_19 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_11) / var_164_19

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_11 + var_164_19 and arg_161_1.time_ < var_164_11 + var_164_19 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10062",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_161_1:InitPlayNodeList()
	end,
	Play410161040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 410161040
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play410161041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(arg_165_1.actors_["10062"]) and arg_165_1.var_.actorSpriteComps10062 == nil then
				arg_165_1.var_.actorSpriteComps10062 = arg_165_1.actors_["10062"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_168_0 = 0.034

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_0 and not isNil(arg_165_1.actors_["10062"]) then
				if arg_165_1.var_.actorSpriteComps10062 then
					for iter_168_0, iter_168_1 in pairs(arg_165_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_168_1 then
							if arg_165_1.isInRecall_ then
								iter_168_1.color = Color.New(Mathf.Lerp(iter_168_1.color.r, arg_165_1.hightColor2.r, (arg_165_1.time_ - 0) / var_168_0), Mathf.Lerp(iter_168_1.color.g, arg_165_1.hightColor2.g, (arg_165_1.time_ - 0) / var_168_0), (Mathf.Lerp(iter_168_1.color.b, arg_165_1.hightColor2.b, (arg_165_1.time_ - 0) / var_168_0)))
							else
								local var_168_1 = Mathf.Lerp(iter_168_1.color.r, 0.5, (arg_165_1.time_ - 0) / var_168_0)

								iter_168_1.color = Color.New(var_168_1, var_168_1, var_168_1)
							end
						end
					end
				end
			end

			if arg_165_1.time_ >= 0 + var_168_0 and arg_165_1.time_ < 0 + var_168_0 + arg_168_0 and not isNil(arg_165_1.actors_["10062"]) and arg_165_1.var_.actorSpriteComps10062 then
				for iter_168_2, iter_168_3 in pairs(arg_165_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_168_3 then
						iter_168_3.color = arg_165_1.isInRecall_ and (arg_165_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_165_1.var_.actorSpriteComps10062 = nil
			end

			local var_168_2 = 0
			local var_168_3 = 0.725

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_2 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, false)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_4 = arg_165_1:FormatText(arg_165_1:GetWordFromCfg(410161040).content)

				arg_165_1.text_.text = var_168_4

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_6 = 29 <= 0 and var_168_3 or var_168_3 * (utf8.len(var_168_4) / 29)

				if (29 <= 0 and var_168_3 or var_168_3 * (utf8.len(var_168_4) / 29)) > 0 and var_168_3 < var_168_6 then
					arg_165_1.talkMaxDuration = var_168_6

					if var_168_6 + var_168_2 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_6 + var_168_2
					end
				end

				arg_165_1.text_.text = var_168_4
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)
				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_7 = math.max(var_168_3, arg_165_1.talkMaxDuration)

			if var_168_2 <= arg_165_1.time_ and arg_165_1.time_ < var_168_2 + var_168_7 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_2) / var_168_7

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_2 + var_168_7 and arg_165_1.time_ < var_168_2 + var_168_7 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play410161041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 410161041
		arg_169_1.duration_ = 9.7

		local var_169_0 = {
			ja = 9.7,
			CriLanguages = 5.9,
			zh = 5.9
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
				arg_169_0:Play410161042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.var_.moveOldPos10059 = arg_169_1.actors_["10059"].transform.localPosition
				arg_169_1.actors_["10059"].transform.localScale = Vector3.New(1, 1, 1)

				arg_169_1:CheckSpriteTmpPos("10059", 4)

				for iter_172_0 = 0, arg_169_1.actors_["10059"].transform.childCount - 1 do
					local var_172_0 = arg_169_1.actors_["10059"].transform:GetChild(iter_172_0)

					if var_172_0.name == "split_5" or not string.find(var_172_0.name, "split") then
						var_172_0.gameObject:SetActive(true)
					else
						var_172_0.gameObject:SetActive(false)
					end
				end
			end

			local var_172_1 = 0.001

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_1 then
				arg_169_1.actors_["10059"].transform.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos10059, Vector3.New(390, -530, 35), (arg_169_1.time_ - 0) / var_172_1)
			end

			if arg_169_1.time_ >= 0 + var_172_1 and arg_169_1.time_ < 0 + var_172_1 + arg_172_0 then
				arg_169_1.actors_["10059"].transform.localPosition = Vector3.New(390, -530, 35)
			end

			local var_172_2 = arg_169_1.actors_["10062"].transform

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.var_.moveOldPos10062 = var_172_2.localPosition
				var_172_2.localScale = Vector3.New(1, 1, 1)

				arg_169_1:CheckSpriteTmpPos("10062", 7)

				for iter_172_1 = 0, var_172_2.childCount - 1 do
					local var_172_3 = var_172_2:GetChild(iter_172_1)

					if var_172_3.name == "" or not string.find(var_172_3.name, "split") then
						var_172_3.gameObject:SetActive(true)
					else
						var_172_3.gameObject:SetActive(false)
					end
				end
			end

			local var_172_4 = 0.001

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_4 then
				var_172_2.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos10062, Vector3.New(0, -2000, -290), (arg_169_1.time_ - 0) / var_172_4)
			end

			if arg_169_1.time_ >= 0 + var_172_4 and arg_169_1.time_ < 0 + var_172_4 + arg_172_0 then
				var_172_2.localPosition = Vector3.New(0, -2000, -290)
			end

			local var_172_5 = arg_169_1.actors_["10059"]

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(var_172_5) and arg_169_1.var_.actorSpriteComps10059 == nil then
				arg_169_1.var_.actorSpriteComps10059 = var_172_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_172_6 = 0.034

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_6 and not isNil(var_172_5) then
				if arg_169_1.var_.actorSpriteComps10059 then
					for iter_172_2, iter_172_3 in pairs(arg_169_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_172_3 then
							if arg_169_1.isInRecall_ then
								iter_172_3.color = Color.New(Mathf.Lerp(iter_172_3.color.r, arg_169_1.hightColor1.r, (arg_169_1.time_ - 0) / var_172_6), Mathf.Lerp(iter_172_3.color.g, arg_169_1.hightColor1.g, (arg_169_1.time_ - 0) / var_172_6), (Mathf.Lerp(iter_172_3.color.b, arg_169_1.hightColor1.b, (arg_169_1.time_ - 0) / var_172_6)))
							else
								local var_172_7 = Mathf.Lerp(iter_172_3.color.r, 1, (arg_169_1.time_ - 0) / var_172_6)

								iter_172_3.color = Color.New(var_172_7, var_172_7, var_172_7)
							end
						end
					end
				end
			end

			if arg_169_1.time_ >= 0 + var_172_6 and arg_169_1.time_ < 0 + var_172_6 + arg_172_0 and not isNil(var_172_5) and arg_169_1.var_.actorSpriteComps10059 then
				for iter_172_4, iter_172_5 in pairs(arg_169_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_172_5 then
						iter_172_5.color = arg_169_1.isInRecall_ and (arg_169_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_169_1.var_.actorSpriteComps10059 = nil
			end

			local var_172_8 = arg_169_1.actors_["10062"]

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(var_172_8) and arg_169_1.var_.actorSpriteComps10062 == nil then
				arg_169_1.var_.actorSpriteComps10062 = var_172_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_172_9 = 0.034

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_9 and not isNil(var_172_8) then
				if arg_169_1.var_.actorSpriteComps10062 then
					for iter_172_6, iter_172_7 in pairs(arg_169_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_172_7 then
							if arg_169_1.isInRecall_ then
								iter_172_7.color = Color.New(Mathf.Lerp(iter_172_7.color.r, arg_169_1.hightColor2.r, (arg_169_1.time_ - 0) / var_172_9), Mathf.Lerp(iter_172_7.color.g, arg_169_1.hightColor2.g, (arg_169_1.time_ - 0) / var_172_9), (Mathf.Lerp(iter_172_7.color.b, arg_169_1.hightColor2.b, (arg_169_1.time_ - 0) / var_172_9)))
							else
								local var_172_10 = Mathf.Lerp(iter_172_7.color.r, 0.5, (arg_169_1.time_ - 0) / var_172_9)

								iter_172_7.color = Color.New(var_172_10, var_172_10, var_172_10)
							end
						end
					end
				end
			end

			if arg_169_1.time_ >= 0 + var_172_9 and arg_169_1.time_ < 0 + var_172_9 + arg_172_0 and not isNil(var_172_8) and arg_169_1.var_.actorSpriteComps10062 then
				for iter_172_8, iter_172_9 in pairs(arg_169_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_172_9 then
						iter_172_9.color = arg_169_1.isInRecall_ and (arg_169_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_169_1.var_.actorSpriteComps10062 = nil
			end

			local var_172_11 = 0
			local var_172_12 = 0.45

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_11 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[596].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_13 = arg_169_1:GetWordFromCfg(410161041)
				local var_172_14 = arg_169_1:FormatText(var_172_13.content)

				arg_169_1.text_.text = var_172_14

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_16 = 18 <= 0 and var_172_12 or var_172_12 * (utf8.len(var_172_14) / 18)

				if (18 <= 0 and var_172_12 or var_172_12 * (utf8.len(var_172_14) / 18)) > 0 and var_172_12 < var_172_16 then
					arg_169_1.talkMaxDuration = var_172_16

					if var_172_16 + var_172_11 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_16 + var_172_11
					end
				end

				arg_169_1.text_.text = var_172_14
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161041", "story_v_out_410161.awb") ~= 0 then
					local var_172_17 = manager.audio:GetVoiceLength("story_v_out_410161", "410161041", "story_v_out_410161.awb") / 1000

					if var_172_17 + var_172_11 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_17 + var_172_11
					end

					if var_172_13.prefab_name ~= "" and arg_169_1.actors_[var_172_13.prefab_name] ~= nil then
						local var_172_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_13.prefab_name].transform, "story_v_out_410161", "410161041", "story_v_out_410161.awb")

						arg_169_1:RecordAudio("410161041", var_172_18)
						arg_169_1:RecordAudio("410161041", var_172_18)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_410161", "410161041", "story_v_out_410161.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_410161", "410161041", "story_v_out_410161.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_19 = math.max(var_172_12, arg_169_1.talkMaxDuration)

			if var_172_11 <= arg_169_1.time_ and arg_169_1.time_ < var_172_11 + var_172_19 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_11) / var_172_19

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_11 + var_172_19 and arg_169_1.time_ < var_172_11 + var_172_19 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10062",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_169_1:InitPlayNodeList()
	end,
	Play410161042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 410161042
		arg_173_1.duration_ = 8.8

		local var_173_0 = {
			ja = 8.8,
			CriLanguages = 3.566,
			zh = 3.566
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
				arg_173_0:Play410161043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.var_.moveOldPos1061 = arg_173_1.actors_["1061"].transform.localPosition
				arg_173_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_173_1:CheckSpriteTmpPos("1061", 2)

				for iter_176_0 = 0, arg_173_1.actors_["1061"].transform.childCount - 1 do
					local var_176_0 = arg_173_1.actors_["1061"].transform:GetChild(iter_176_0)

					if var_176_0.name == "split_1" or not string.find(var_176_0.name, "split") then
						var_176_0.gameObject:SetActive(true)
					else
						var_176_0.gameObject:SetActive(false)
					end
				end
			end

			local var_176_1 = 0.001

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_1 then
				arg_173_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (arg_173_1.time_ - 0) / var_176_1)
			end

			if arg_173_1.time_ >= 0 + var_176_1 and arg_173_1.time_ < 0 + var_176_1 + arg_176_0 then
				arg_173_1.actors_["1061"].transform.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_176_2 = arg_173_1.actors_["1061"]

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(var_176_2) and arg_173_1.var_.actorSpriteComps1061 == nil then
				arg_173_1.var_.actorSpriteComps1061 = var_176_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_176_3 = 0.034

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_3 and not isNil(var_176_2) then
				if arg_173_1.var_.actorSpriteComps1061 then
					for iter_176_1, iter_176_2 in pairs(arg_173_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_176_2 then
							if arg_173_1.isInRecall_ then
								iter_176_2.color = Color.New(Mathf.Lerp(iter_176_2.color.r, arg_173_1.hightColor1.r, (arg_173_1.time_ - 0) / var_176_3), Mathf.Lerp(iter_176_2.color.g, arg_173_1.hightColor1.g, (arg_173_1.time_ - 0) / var_176_3), (Mathf.Lerp(iter_176_2.color.b, arg_173_1.hightColor1.b, (arg_173_1.time_ - 0) / var_176_3)))
							else
								local var_176_4 = Mathf.Lerp(iter_176_2.color.r, 1, (arg_173_1.time_ - 0) / var_176_3)

								iter_176_2.color = Color.New(var_176_4, var_176_4, var_176_4)
							end
						end
					end
				end
			end

			if arg_173_1.time_ >= 0 + var_176_3 and arg_173_1.time_ < 0 + var_176_3 + arg_176_0 and not isNil(var_176_2) and arg_173_1.var_.actorSpriteComps1061 then
				for iter_176_3, iter_176_4 in pairs(arg_173_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_176_4 then
						iter_176_4.color = arg_173_1.isInRecall_ and (arg_173_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_173_1.var_.actorSpriteComps1061 = nil
			end

			local var_176_5 = arg_173_1.actors_["10059"]

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(var_176_5) and arg_173_1.var_.actorSpriteComps10059 == nil then
				arg_173_1.var_.actorSpriteComps10059 = var_176_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_176_6 = 0.034

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_6 and not isNil(var_176_5) then
				if arg_173_1.var_.actorSpriteComps10059 then
					for iter_176_5, iter_176_6 in pairs(arg_173_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_176_6 then
							if arg_173_1.isInRecall_ then
								iter_176_6.color = Color.New(Mathf.Lerp(iter_176_6.color.r, arg_173_1.hightColor2.r, (arg_173_1.time_ - 0) / var_176_6), Mathf.Lerp(iter_176_6.color.g, arg_173_1.hightColor2.g, (arg_173_1.time_ - 0) / var_176_6), (Mathf.Lerp(iter_176_6.color.b, arg_173_1.hightColor2.b, (arg_173_1.time_ - 0) / var_176_6)))
							else
								local var_176_7 = Mathf.Lerp(iter_176_6.color.r, 0.5, (arg_173_1.time_ - 0) / var_176_6)

								iter_176_6.color = Color.New(var_176_7, var_176_7, var_176_7)
							end
						end
					end
				end
			end

			if arg_173_1.time_ >= 0 + var_176_6 and arg_173_1.time_ < 0 + var_176_6 + arg_176_0 and not isNil(var_176_5) and arg_173_1.var_.actorSpriteComps10059 then
				for iter_176_7, iter_176_8 in pairs(arg_173_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_176_8 then
						iter_176_8.color = arg_173_1.isInRecall_ and (arg_173_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_173_1.var_.actorSpriteComps10059 = nil
			end

			local var_176_8 = 0
			local var_176_9 = 0.425

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_8 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_10 = arg_173_1:GetWordFromCfg(410161042)
				local var_176_11 = arg_173_1:FormatText(var_176_10.content)

				arg_173_1.text_.text = var_176_11

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_13 = 17 <= 0 and var_176_9 or var_176_9 * (utf8.len(var_176_11) / 17)

				if (17 <= 0 and var_176_9 or var_176_9 * (utf8.len(var_176_11) / 17)) > 0 and var_176_9 < var_176_13 then
					arg_173_1.talkMaxDuration = var_176_13

					if var_176_13 + var_176_8 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_13 + var_176_8
					end
				end

				arg_173_1.text_.text = var_176_11
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161042", "story_v_out_410161.awb") ~= 0 then
					local var_176_14 = manager.audio:GetVoiceLength("story_v_out_410161", "410161042", "story_v_out_410161.awb") / 1000

					if var_176_14 + var_176_8 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_14 + var_176_8
					end

					if var_176_10.prefab_name ~= "" and arg_173_1.actors_[var_176_10.prefab_name] ~= nil then
						local var_176_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_10.prefab_name].transform, "story_v_out_410161", "410161042", "story_v_out_410161.awb")

						arg_173_1:RecordAudio("410161042", var_176_15)
						arg_173_1:RecordAudio("410161042", var_176_15)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_410161", "410161042", "story_v_out_410161.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_410161", "410161042", "story_v_out_410161.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_16 = math.max(var_176_9, arg_173_1.talkMaxDuration)

			if var_176_8 <= arg_173_1.time_ and arg_173_1.time_ < var_176_8 + var_176_16 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_8) / var_176_16

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_8 + var_176_16 and arg_173_1.time_ < var_176_8 + var_176_16 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_173_1:InitPlayNodeList()
	end,
	Play410161043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 410161043
		arg_177_1.duration_ = 11.03

		local var_177_0 = {
			ja = 11.033,
			CriLanguages = 7.3,
			zh = 7.3
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
				arg_177_0:Play410161044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.var_.moveOldPos10059 = arg_177_1.actors_["10059"].transform.localPosition
				arg_177_1.actors_["10059"].transform.localScale = Vector3.New(1, 1, 1)

				arg_177_1:CheckSpriteTmpPos("10059", 2)

				for iter_180_0 = 0, arg_177_1.actors_["10059"].transform.childCount - 1 do
					local var_180_0 = arg_177_1.actors_["10059"].transform:GetChild(iter_180_0)

					if var_180_0.name == "split_2" or not string.find(var_180_0.name, "split") then
						var_180_0.gameObject:SetActive(true)
					else
						var_180_0.gameObject:SetActive(false)
					end
				end
			end

			local var_180_1 = 0.001

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_1 then
				arg_177_1.actors_["10059"].transform.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos10059, Vector3.New(-390, -530, 35), (arg_177_1.time_ - 0) / var_180_1)
			end

			if arg_177_1.time_ >= 0 + var_180_1 and arg_177_1.time_ < 0 + var_180_1 + arg_180_0 then
				arg_177_1.actors_["10059"].transform.localPosition = Vector3.New(-390, -530, 35)
			end

			local var_180_2 = arg_177_1.actors_["1061"].transform

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.var_.moveOldPos1061 = var_180_2.localPosition
				var_180_2.localScale = Vector3.New(1, 1, 1)

				arg_177_1:CheckSpriteTmpPos("1061", 7)

				for iter_180_1 = 0, var_180_2.childCount - 1 do
					local var_180_3 = var_180_2:GetChild(iter_180_1)

					if var_180_3.name == "" or not string.find(var_180_3.name, "split") then
						var_180_3.gameObject:SetActive(true)
					else
						var_180_3.gameObject:SetActive(false)
					end
				end
			end

			local var_180_4 = 0.001

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_4 then
				var_180_2.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos1061, Vector3.New(0, -2000, 18), (arg_177_1.time_ - 0) / var_180_4)
			end

			if arg_177_1.time_ >= 0 + var_180_4 and arg_177_1.time_ < 0 + var_180_4 + arg_180_0 then
				var_180_2.localPosition = Vector3.New(0, -2000, 18)
			end

			local var_180_5 = arg_177_1.actors_["10059"]

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(var_180_5) and arg_177_1.var_.actorSpriteComps10059 == nil then
				arg_177_1.var_.actorSpriteComps10059 = var_180_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_180_6 = 0.034

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_6 and not isNil(var_180_5) then
				if arg_177_1.var_.actorSpriteComps10059 then
					for iter_180_2, iter_180_3 in pairs(arg_177_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_180_3 then
							if arg_177_1.isInRecall_ then
								iter_180_3.color = Color.New(Mathf.Lerp(iter_180_3.color.r, arg_177_1.hightColor1.r, (arg_177_1.time_ - 0) / var_180_6), Mathf.Lerp(iter_180_3.color.g, arg_177_1.hightColor1.g, (arg_177_1.time_ - 0) / var_180_6), (Mathf.Lerp(iter_180_3.color.b, arg_177_1.hightColor1.b, (arg_177_1.time_ - 0) / var_180_6)))
							else
								local var_180_7 = Mathf.Lerp(iter_180_3.color.r, 1, (arg_177_1.time_ - 0) / var_180_6)

								iter_180_3.color = Color.New(var_180_7, var_180_7, var_180_7)
							end
						end
					end
				end
			end

			if arg_177_1.time_ >= 0 + var_180_6 and arg_177_1.time_ < 0 + var_180_6 + arg_180_0 and not isNil(var_180_5) and arg_177_1.var_.actorSpriteComps10059 then
				for iter_180_4, iter_180_5 in pairs(arg_177_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_180_5 then
						iter_180_5.color = arg_177_1.isInRecall_ and (arg_177_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_177_1.var_.actorSpriteComps10059 = nil
			end

			local var_180_8 = arg_177_1.actors_["1061"]

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(var_180_8) and arg_177_1.var_.actorSpriteComps1061 == nil then
				arg_177_1.var_.actorSpriteComps1061 = var_180_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_180_9 = 0.034

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_9 and not isNil(var_180_8) then
				if arg_177_1.var_.actorSpriteComps1061 then
					for iter_180_6, iter_180_7 in pairs(arg_177_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_180_7 then
							if arg_177_1.isInRecall_ then
								iter_180_7.color = Color.New(Mathf.Lerp(iter_180_7.color.r, arg_177_1.hightColor2.r, (arg_177_1.time_ - 0) / var_180_9), Mathf.Lerp(iter_180_7.color.g, arg_177_1.hightColor2.g, (arg_177_1.time_ - 0) / var_180_9), (Mathf.Lerp(iter_180_7.color.b, arg_177_1.hightColor2.b, (arg_177_1.time_ - 0) / var_180_9)))
							else
								local var_180_10 = Mathf.Lerp(iter_180_7.color.r, 0.5, (arg_177_1.time_ - 0) / var_180_9)

								iter_180_7.color = Color.New(var_180_10, var_180_10, var_180_10)
							end
						end
					end
				end
			end

			if arg_177_1.time_ >= 0 + var_180_9 and arg_177_1.time_ < 0 + var_180_9 + arg_180_0 and not isNil(var_180_8) and arg_177_1.var_.actorSpriteComps1061 then
				for iter_180_8, iter_180_9 in pairs(arg_177_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_180_9 then
						iter_180_9.color = arg_177_1.isInRecall_ and (arg_177_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_177_1.var_.actorSpriteComps1061 = nil
			end

			local var_180_11 = 0
			local var_180_12 = 0.675

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_11 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[596].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_13 = arg_177_1:GetWordFromCfg(410161043)
				local var_180_14 = arg_177_1:FormatText(var_180_13.content)

				arg_177_1.text_.text = var_180_14

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_16 = 27 <= 0 and var_180_12 or var_180_12 * (utf8.len(var_180_14) / 27)

				if (27 <= 0 and var_180_12 or var_180_12 * (utf8.len(var_180_14) / 27)) > 0 and var_180_12 < var_180_16 then
					arg_177_1.talkMaxDuration = var_180_16

					if var_180_16 + var_180_11 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_16 + var_180_11
					end
				end

				arg_177_1.text_.text = var_180_14
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161043", "story_v_out_410161.awb") ~= 0 then
					local var_180_17 = manager.audio:GetVoiceLength("story_v_out_410161", "410161043", "story_v_out_410161.awb") / 1000

					if var_180_17 + var_180_11 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_17 + var_180_11
					end

					if var_180_13.prefab_name ~= "" and arg_177_1.actors_[var_180_13.prefab_name] ~= nil then
						local var_180_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_13.prefab_name].transform, "story_v_out_410161", "410161043", "story_v_out_410161.awb")

						arg_177_1:RecordAudio("410161043", var_180_18)
						arg_177_1:RecordAudio("410161043", var_180_18)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_410161", "410161043", "story_v_out_410161.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_410161", "410161043", "story_v_out_410161.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_19 = math.max(var_180_12, arg_177_1.talkMaxDuration)

			if var_180_11 <= arg_177_1.time_ and arg_177_1.time_ < var_180_11 + var_180_19 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_11) / var_180_19

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_11 + var_180_19 and arg_177_1.time_ < var_180_11 + var_180_19 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_177_1:InitPlayNodeList()
	end,
	Play410161044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 410161044
		arg_181_1.duration_ = 5.9

		local var_181_0 = {
			ja = 5.9,
			CriLanguages = 2.733,
			zh = 2.733
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
				arg_181_0:Play410161045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.var_.moveOldPos10062 = arg_181_1.actors_["10062"].transform.localPosition
				arg_181_1.actors_["10062"].transform.localScale = Vector3.New(1, 1, 1)

				arg_181_1:CheckSpriteTmpPos("10062", 4)

				for iter_184_0 = 0, arg_181_1.actors_["10062"].transform.childCount - 1 do
					local var_184_0 = arg_181_1.actors_["10062"].transform:GetChild(iter_184_0)

					if var_184_0.name == "" or not string.find(var_184_0.name, "split") then
						var_184_0.gameObject:SetActive(true)
					else
						var_184_0.gameObject:SetActive(false)
					end
				end
			end

			local var_184_1 = 0.001

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_1 then
				arg_181_1.actors_["10062"].transform.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos10062, Vector3.New(370, -390, -290), (arg_181_1.time_ - 0) / var_184_1)
			end

			if arg_181_1.time_ >= 0 + var_184_1 and arg_181_1.time_ < 0 + var_184_1 + arg_184_0 then
				arg_181_1.actors_["10062"].transform.localPosition = Vector3.New(370, -390, -290)
			end

			local var_184_2 = arg_181_1.actors_["10062"]

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(var_184_2) and arg_181_1.var_.actorSpriteComps10062 == nil then
				arg_181_1.var_.actorSpriteComps10062 = var_184_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_184_3 = 0.034

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_3 and not isNil(var_184_2) then
				if arg_181_1.var_.actorSpriteComps10062 then
					for iter_184_1, iter_184_2 in pairs(arg_181_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_184_2 then
							if arg_181_1.isInRecall_ then
								iter_184_2.color = Color.New(Mathf.Lerp(iter_184_2.color.r, arg_181_1.hightColor1.r, (arg_181_1.time_ - 0) / var_184_3), Mathf.Lerp(iter_184_2.color.g, arg_181_1.hightColor1.g, (arg_181_1.time_ - 0) / var_184_3), (Mathf.Lerp(iter_184_2.color.b, arg_181_1.hightColor1.b, (arg_181_1.time_ - 0) / var_184_3)))
							else
								local var_184_4 = Mathf.Lerp(iter_184_2.color.r, 1, (arg_181_1.time_ - 0) / var_184_3)

								iter_184_2.color = Color.New(var_184_4, var_184_4, var_184_4)
							end
						end
					end
				end
			end

			if arg_181_1.time_ >= 0 + var_184_3 and arg_181_1.time_ < 0 + var_184_3 + arg_184_0 and not isNil(var_184_2) and arg_181_1.var_.actorSpriteComps10062 then
				for iter_184_3, iter_184_4 in pairs(arg_181_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_184_4 then
						iter_184_4.color = arg_181_1.isInRecall_ and (arg_181_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_181_1.var_.actorSpriteComps10062 = nil
			end

			local var_184_5 = arg_181_1.actors_["10059"]

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(var_184_5) and arg_181_1.var_.actorSpriteComps10059 == nil then
				arg_181_1.var_.actorSpriteComps10059 = var_184_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_184_6 = 0.034

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_6 and not isNil(var_184_5) then
				if arg_181_1.var_.actorSpriteComps10059 then
					for iter_184_5, iter_184_6 in pairs(arg_181_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_184_6 then
							if arg_181_1.isInRecall_ then
								iter_184_6.color = Color.New(Mathf.Lerp(iter_184_6.color.r, arg_181_1.hightColor2.r, (arg_181_1.time_ - 0) / var_184_6), Mathf.Lerp(iter_184_6.color.g, arg_181_1.hightColor2.g, (arg_181_1.time_ - 0) / var_184_6), (Mathf.Lerp(iter_184_6.color.b, arg_181_1.hightColor2.b, (arg_181_1.time_ - 0) / var_184_6)))
							else
								local var_184_7 = Mathf.Lerp(iter_184_6.color.r, 0.5, (arg_181_1.time_ - 0) / var_184_6)

								iter_184_6.color = Color.New(var_184_7, var_184_7, var_184_7)
							end
						end
					end
				end
			end

			if arg_181_1.time_ >= 0 + var_184_6 and arg_181_1.time_ < 0 + var_184_6 + arg_184_0 and not isNil(var_184_5) and arg_181_1.var_.actorSpriteComps10059 then
				for iter_184_7, iter_184_8 in pairs(arg_181_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_184_8 then
						iter_184_8.color = arg_181_1.isInRecall_ and (arg_181_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_181_1.var_.actorSpriteComps10059 = nil
			end

			local var_184_8 = 0
			local var_184_9 = 0.275

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_8 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_10 = arg_181_1:GetWordFromCfg(410161044)
				local var_184_11 = arg_181_1:FormatText(var_184_10.content)

				arg_181_1.text_.text = var_184_11

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_13 = 11 <= 0 and var_184_9 or var_184_9 * (utf8.len(var_184_11) / 11)

				if (11 <= 0 and var_184_9 or var_184_9 * (utf8.len(var_184_11) / 11)) > 0 and var_184_9 < var_184_13 then
					arg_181_1.talkMaxDuration = var_184_13

					if var_184_13 + var_184_8 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_13 + var_184_8
					end
				end

				arg_181_1.text_.text = var_184_11
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161044", "story_v_out_410161.awb") ~= 0 then
					local var_184_14 = manager.audio:GetVoiceLength("story_v_out_410161", "410161044", "story_v_out_410161.awb") / 1000

					if var_184_14 + var_184_8 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_14 + var_184_8
					end

					if var_184_10.prefab_name ~= "" and arg_181_1.actors_[var_184_10.prefab_name] ~= nil then
						local var_184_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_10.prefab_name].transform, "story_v_out_410161", "410161044", "story_v_out_410161.awb")

						arg_181_1:RecordAudio("410161044", var_184_15)
						arg_181_1:RecordAudio("410161044", var_184_15)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_410161", "410161044", "story_v_out_410161.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_410161", "410161044", "story_v_out_410161.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_16 = math.max(var_184_9, arg_181_1.talkMaxDuration)

			if var_184_8 <= arg_181_1.time_ and arg_181_1.time_ < var_184_8 + var_184_16 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_8) / var_184_16

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_8 + var_184_16 and arg_181_1.time_ < var_184_8 + var_184_16 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_181_1:InitPlayNodeList()
	end,
	Play410161045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 410161045
		arg_185_1.duration_ = 6.27

		local var_185_0 = {
			ja = 6.266,
			CriLanguages = 5.433,
			zh = 5.433
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
				arg_185_0:Play410161046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.var_.moveOldPos10059 = arg_185_1.actors_["10059"].transform.localPosition
				arg_185_1.actors_["10059"].transform.localScale = Vector3.New(1, 1, 1)

				arg_185_1:CheckSpriteTmpPos("10059", 2)

				for iter_188_0 = 0, arg_185_1.actors_["10059"].transform.childCount - 1 do
					local var_188_0 = arg_185_1.actors_["10059"].transform:GetChild(iter_188_0)

					if var_188_0.name == "" or not string.find(var_188_0.name, "split") then
						var_188_0.gameObject:SetActive(true)
					else
						var_188_0.gameObject:SetActive(false)
					end
				end
			end

			local var_188_1 = 0.001

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_1 then
				arg_185_1.actors_["10059"].transform.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos10059, Vector3.New(-390, -530, 35), (arg_185_1.time_ - 0) / var_188_1)
			end

			if arg_185_1.time_ >= 0 + var_188_1 and arg_185_1.time_ < 0 + var_188_1 + arg_188_0 then
				arg_185_1.actors_["10059"].transform.localPosition = Vector3.New(-390, -530, 35)
			end

			local var_188_2 = arg_185_1.actors_["10059"]

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 and not isNil(var_188_2) and arg_185_1.var_.actorSpriteComps10059 == nil then
				arg_185_1.var_.actorSpriteComps10059 = var_188_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_188_3 = 0.034

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_3 and not isNil(var_188_2) then
				if arg_185_1.var_.actorSpriteComps10059 then
					for iter_188_1, iter_188_2 in pairs(arg_185_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_188_2 then
							if arg_185_1.isInRecall_ then
								iter_188_2.color = Color.New(Mathf.Lerp(iter_188_2.color.r, arg_185_1.hightColor1.r, (arg_185_1.time_ - 0) / var_188_3), Mathf.Lerp(iter_188_2.color.g, arg_185_1.hightColor1.g, (arg_185_1.time_ - 0) / var_188_3), (Mathf.Lerp(iter_188_2.color.b, arg_185_1.hightColor1.b, (arg_185_1.time_ - 0) / var_188_3)))
							else
								local var_188_4 = Mathf.Lerp(iter_188_2.color.r, 1, (arg_185_1.time_ - 0) / var_188_3)

								iter_188_2.color = Color.New(var_188_4, var_188_4, var_188_4)
							end
						end
					end
				end
			end

			if arg_185_1.time_ >= 0 + var_188_3 and arg_185_1.time_ < 0 + var_188_3 + arg_188_0 and not isNil(var_188_2) and arg_185_1.var_.actorSpriteComps10059 then
				for iter_188_3, iter_188_4 in pairs(arg_185_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_188_4 then
						iter_188_4.color = arg_185_1.isInRecall_ and (arg_185_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_185_1.var_.actorSpriteComps10059 = nil
			end

			local var_188_5 = arg_185_1.actors_["10062"]

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 and not isNil(var_188_5) and arg_185_1.var_.actorSpriteComps10062 == nil then
				arg_185_1.var_.actorSpriteComps10062 = var_188_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_188_6 = 0.034

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_6 and not isNil(var_188_5) then
				if arg_185_1.var_.actorSpriteComps10062 then
					for iter_188_5, iter_188_6 in pairs(arg_185_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_188_6 then
							if arg_185_1.isInRecall_ then
								iter_188_6.color = Color.New(Mathf.Lerp(iter_188_6.color.r, arg_185_1.hightColor2.r, (arg_185_1.time_ - 0) / var_188_6), Mathf.Lerp(iter_188_6.color.g, arg_185_1.hightColor2.g, (arg_185_1.time_ - 0) / var_188_6), (Mathf.Lerp(iter_188_6.color.b, arg_185_1.hightColor2.b, (arg_185_1.time_ - 0) / var_188_6)))
							else
								local var_188_7 = Mathf.Lerp(iter_188_6.color.r, 0.5, (arg_185_1.time_ - 0) / var_188_6)

								iter_188_6.color = Color.New(var_188_7, var_188_7, var_188_7)
							end
						end
					end
				end
			end

			if arg_185_1.time_ >= 0 + var_188_6 and arg_185_1.time_ < 0 + var_188_6 + arg_188_0 and not isNil(var_188_5) and arg_185_1.var_.actorSpriteComps10062 then
				for iter_188_7, iter_188_8 in pairs(arg_185_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_188_8 then
						iter_188_8.color = arg_185_1.isInRecall_ and (arg_185_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_185_1.var_.actorSpriteComps10062 = nil
			end

			local var_188_8 = 0
			local var_188_9 = 0.7

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_8 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[596].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_10 = arg_185_1:GetWordFromCfg(410161045)
				local var_188_11 = arg_185_1:FormatText(var_188_10.content)

				arg_185_1.text_.text = var_188_11

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_13 = 28 <= 0 and var_188_9 or var_188_9 * (utf8.len(var_188_11) / 28)

				if (28 <= 0 and var_188_9 or var_188_9 * (utf8.len(var_188_11) / 28)) > 0 and var_188_9 < var_188_13 then
					arg_185_1.talkMaxDuration = var_188_13

					if var_188_13 + var_188_8 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_13 + var_188_8
					end
				end

				arg_185_1.text_.text = var_188_11
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161045", "story_v_out_410161.awb") ~= 0 then
					local var_188_14 = manager.audio:GetVoiceLength("story_v_out_410161", "410161045", "story_v_out_410161.awb") / 1000

					if var_188_14 + var_188_8 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_14 + var_188_8
					end

					if var_188_10.prefab_name ~= "" and arg_185_1.actors_[var_188_10.prefab_name] ~= nil then
						local var_188_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_10.prefab_name].transform, "story_v_out_410161", "410161045", "story_v_out_410161.awb")

						arg_185_1:RecordAudio("410161045", var_188_15)
						arg_185_1:RecordAudio("410161045", var_188_15)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_410161", "410161045", "story_v_out_410161.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_410161", "410161045", "story_v_out_410161.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_16 = math.max(var_188_9, arg_185_1.talkMaxDuration)

			if var_188_8 <= arg_185_1.time_ and arg_185_1.time_ < var_188_8 + var_188_16 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_8) / var_188_16

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_8 + var_188_16 and arg_185_1.time_ < var_188_8 + var_188_16 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_185_1:InitPlayNodeList()
	end,
	Play410161046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 410161046
		arg_189_1.duration_ = 11.87

		local var_189_0 = {
			ja = 11.866,
			CriLanguages = 5.166,
			zh = 5.166
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
				arg_189_0:Play410161047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.var_.moveOldPos10059 = arg_189_1.actors_["10059"].transform.localPosition
				arg_189_1.actors_["10059"].transform.localScale = Vector3.New(1, 1, 1)

				arg_189_1:CheckSpriteTmpPos("10059", 2)

				for iter_192_0 = 0, arg_189_1.actors_["10059"].transform.childCount - 1 do
					local var_192_0 = arg_189_1.actors_["10059"].transform:GetChild(iter_192_0)

					if var_192_0.name == "" or not string.find(var_192_0.name, "split") then
						var_192_0.gameObject:SetActive(true)
					else
						var_192_0.gameObject:SetActive(false)
					end
				end
			end

			local var_192_1 = 0.001

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_1 then
				arg_189_1.actors_["10059"].transform.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos10059, Vector3.New(-390, -530, 35), (arg_189_1.time_ - 0) / var_192_1)
			end

			if arg_189_1.time_ >= 0 + var_192_1 and arg_189_1.time_ < 0 + var_192_1 + arg_192_0 then
				arg_189_1.actors_["10059"].transform.localPosition = Vector3.New(-390, -530, 35)
			end

			local var_192_2 = arg_189_1.actors_["10059"]

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(var_192_2) and arg_189_1.var_.actorSpriteComps10059 == nil then
				arg_189_1.var_.actorSpriteComps10059 = var_192_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_192_3 = 0.034

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_3 and not isNil(var_192_2) then
				if arg_189_1.var_.actorSpriteComps10059 then
					for iter_192_1, iter_192_2 in pairs(arg_189_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_192_2 then
							if arg_189_1.isInRecall_ then
								iter_192_2.color = Color.New(Mathf.Lerp(iter_192_2.color.r, arg_189_1.hightColor1.r, (arg_189_1.time_ - 0) / var_192_3), Mathf.Lerp(iter_192_2.color.g, arg_189_1.hightColor1.g, (arg_189_1.time_ - 0) / var_192_3), (Mathf.Lerp(iter_192_2.color.b, arg_189_1.hightColor1.b, (arg_189_1.time_ - 0) / var_192_3)))
							else
								local var_192_4 = Mathf.Lerp(iter_192_2.color.r, 1, (arg_189_1.time_ - 0) / var_192_3)

								iter_192_2.color = Color.New(var_192_4, var_192_4, var_192_4)
							end
						end
					end
				end
			end

			if arg_189_1.time_ >= 0 + var_192_3 and arg_189_1.time_ < 0 + var_192_3 + arg_192_0 and not isNil(var_192_2) and arg_189_1.var_.actorSpriteComps10059 then
				for iter_192_3, iter_192_4 in pairs(arg_189_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_192_4 then
						iter_192_4.color = arg_189_1.isInRecall_ and (arg_189_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_189_1.var_.actorSpriteComps10059 = nil
			end

			local var_192_5 = 0
			local var_192_6 = 0.7

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_5 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[596].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_7 = arg_189_1:GetWordFromCfg(410161046)
				local var_192_8 = arg_189_1:FormatText(var_192_7.content)

				arg_189_1.text_.text = var_192_8

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_10 = 28 <= 0 and var_192_6 or var_192_6 * (utf8.len(var_192_8) / 28)

				if (28 <= 0 and var_192_6 or var_192_6 * (utf8.len(var_192_8) / 28)) > 0 and var_192_6 < var_192_10 then
					arg_189_1.talkMaxDuration = var_192_10

					if var_192_10 + var_192_5 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_10 + var_192_5
					end
				end

				arg_189_1.text_.text = var_192_8
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161046", "story_v_out_410161.awb") ~= 0 then
					local var_192_11 = manager.audio:GetVoiceLength("story_v_out_410161", "410161046", "story_v_out_410161.awb") / 1000

					if var_192_11 + var_192_5 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_11 + var_192_5
					end

					if var_192_7.prefab_name ~= "" and arg_189_1.actors_[var_192_7.prefab_name] ~= nil then
						local var_192_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_7.prefab_name].transform, "story_v_out_410161", "410161046", "story_v_out_410161.awb")

						arg_189_1:RecordAudio("410161046", var_192_12)
						arg_189_1:RecordAudio("410161046", var_192_12)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_410161", "410161046", "story_v_out_410161.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_410161", "410161046", "story_v_out_410161.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_13 = math.max(var_192_6, arg_189_1.talkMaxDuration)

			if var_192_5 <= arg_189_1.time_ and arg_189_1.time_ < var_192_5 + var_192_13 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_5) / var_192_13

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_5 + var_192_13 and arg_189_1.time_ < var_192_5 + var_192_13 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_189_1:InitPlayNodeList()
	end,
	Play410161047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 410161047
		arg_193_1.duration_ = 5.2

		local var_193_0 = {
			ja = 5.2,
			CriLanguages = 2.733,
			zh = 2.733
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
				arg_193_0:Play410161048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.var_.moveOldPos10062 = arg_193_1.actors_["10062"].transform.localPosition
				arg_193_1.actors_["10062"].transform.localScale = Vector3.New(1, 1, 1)

				arg_193_1:CheckSpriteTmpPos("10062", 4)

				for iter_196_0 = 0, arg_193_1.actors_["10062"].transform.childCount - 1 do
					local var_196_0 = arg_193_1.actors_["10062"].transform:GetChild(iter_196_0)

					if var_196_0.name == "split_3" or not string.find(var_196_0.name, "split") then
						var_196_0.gameObject:SetActive(true)
					else
						var_196_0.gameObject:SetActive(false)
					end
				end
			end

			local var_196_1 = 0.001

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_1 then
				arg_193_1.actors_["10062"].transform.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos10062, Vector3.New(370, -390, -290), (arg_193_1.time_ - 0) / var_196_1)
			end

			if arg_193_1.time_ >= 0 + var_196_1 and arg_193_1.time_ < 0 + var_196_1 + arg_196_0 then
				arg_193_1.actors_["10062"].transform.localPosition = Vector3.New(370, -390, -290)
			end

			local var_196_2 = arg_193_1.actors_["10062"]

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(var_196_2) and arg_193_1.var_.actorSpriteComps10062 == nil then
				arg_193_1.var_.actorSpriteComps10062 = var_196_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_196_3 = 0.034

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_3 and not isNil(var_196_2) then
				if arg_193_1.var_.actorSpriteComps10062 then
					for iter_196_1, iter_196_2 in pairs(arg_193_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_196_2 then
							if arg_193_1.isInRecall_ then
								iter_196_2.color = Color.New(Mathf.Lerp(iter_196_2.color.r, arg_193_1.hightColor1.r, (arg_193_1.time_ - 0) / var_196_3), Mathf.Lerp(iter_196_2.color.g, arg_193_1.hightColor1.g, (arg_193_1.time_ - 0) / var_196_3), (Mathf.Lerp(iter_196_2.color.b, arg_193_1.hightColor1.b, (arg_193_1.time_ - 0) / var_196_3)))
							else
								local var_196_4 = Mathf.Lerp(iter_196_2.color.r, 1, (arg_193_1.time_ - 0) / var_196_3)

								iter_196_2.color = Color.New(var_196_4, var_196_4, var_196_4)
							end
						end
					end
				end
			end

			if arg_193_1.time_ >= 0 + var_196_3 and arg_193_1.time_ < 0 + var_196_3 + arg_196_0 and not isNil(var_196_2) and arg_193_1.var_.actorSpriteComps10062 then
				for iter_196_3, iter_196_4 in pairs(arg_193_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_196_4 then
						iter_196_4.color = arg_193_1.isInRecall_ and (arg_193_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_193_1.var_.actorSpriteComps10062 = nil
			end

			local var_196_5 = arg_193_1.actors_["10059"]

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(var_196_5) and arg_193_1.var_.actorSpriteComps10059 == nil then
				arg_193_1.var_.actorSpriteComps10059 = var_196_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_196_6 = 0.034

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_6 and not isNil(var_196_5) then
				if arg_193_1.var_.actorSpriteComps10059 then
					for iter_196_5, iter_196_6 in pairs(arg_193_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_196_6 then
							if arg_193_1.isInRecall_ then
								iter_196_6.color = Color.New(Mathf.Lerp(iter_196_6.color.r, arg_193_1.hightColor2.r, (arg_193_1.time_ - 0) / var_196_6), Mathf.Lerp(iter_196_6.color.g, arg_193_1.hightColor2.g, (arg_193_1.time_ - 0) / var_196_6), (Mathf.Lerp(iter_196_6.color.b, arg_193_1.hightColor2.b, (arg_193_1.time_ - 0) / var_196_6)))
							else
								local var_196_7 = Mathf.Lerp(iter_196_6.color.r, 0.5, (arg_193_1.time_ - 0) / var_196_6)

								iter_196_6.color = Color.New(var_196_7, var_196_7, var_196_7)
							end
						end
					end
				end
			end

			if arg_193_1.time_ >= 0 + var_196_6 and arg_193_1.time_ < 0 + var_196_6 + arg_196_0 and not isNil(var_196_5) and arg_193_1.var_.actorSpriteComps10059 then
				for iter_196_7, iter_196_8 in pairs(arg_193_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_196_8 then
						iter_196_8.color = arg_193_1.isInRecall_ and (arg_193_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_193_1.var_.actorSpriteComps10059 = nil
			end

			local var_196_8 = 0
			local var_196_9 = 0.25

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_8 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_10 = arg_193_1:GetWordFromCfg(410161047)
				local var_196_11 = arg_193_1:FormatText(var_196_10.content)

				arg_193_1.text_.text = var_196_11

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_13 = 10 <= 0 and var_196_9 or var_196_9 * (utf8.len(var_196_11) / 10)

				if (10 <= 0 and var_196_9 or var_196_9 * (utf8.len(var_196_11) / 10)) > 0 and var_196_9 < var_196_13 then
					arg_193_1.talkMaxDuration = var_196_13

					if var_196_13 + var_196_8 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_13 + var_196_8
					end
				end

				arg_193_1.text_.text = var_196_11
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161047", "story_v_out_410161.awb") ~= 0 then
					local var_196_14 = manager.audio:GetVoiceLength("story_v_out_410161", "410161047", "story_v_out_410161.awb") / 1000

					if var_196_14 + var_196_8 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_14 + var_196_8
					end

					if var_196_10.prefab_name ~= "" and arg_193_1.actors_[var_196_10.prefab_name] ~= nil then
						local var_196_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_10.prefab_name].transform, "story_v_out_410161", "410161047", "story_v_out_410161.awb")

						arg_193_1:RecordAudio("410161047", var_196_15)
						arg_193_1:RecordAudio("410161047", var_196_15)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_410161", "410161047", "story_v_out_410161.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_410161", "410161047", "story_v_out_410161.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_16 = math.max(var_196_9, arg_193_1.talkMaxDuration)

			if var_196_8 <= arg_193_1.time_ and arg_193_1.time_ < var_196_8 + var_196_16 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_8) / var_196_16

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_8 + var_196_16 and arg_193_1.time_ < var_196_8 + var_196_16 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
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
	Play410161048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 410161048
		arg_197_1.duration_ = 7.33

		local var_197_0 = {
			ja = 7.333,
			CriLanguages = 3.766,
			zh = 3.766
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
				arg_197_0:Play410161049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.var_.moveOldPos10059 = arg_197_1.actors_["10059"].transform.localPosition
				arg_197_1.actors_["10059"].transform.localScale = Vector3.New(1, 1, 1)

				arg_197_1:CheckSpriteTmpPos("10059", 2)

				for iter_200_0 = 0, arg_197_1.actors_["10059"].transform.childCount - 1 do
					local var_200_0 = arg_197_1.actors_["10059"].transform:GetChild(iter_200_0)

					if var_200_0.name == "split_3" or not string.find(var_200_0.name, "split") then
						var_200_0.gameObject:SetActive(true)
					else
						var_200_0.gameObject:SetActive(false)
					end
				end
			end

			local var_200_1 = 0.001

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_1 then
				arg_197_1.actors_["10059"].transform.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos10059, Vector3.New(-390, -530, 35), (arg_197_1.time_ - 0) / var_200_1)
			end

			if arg_197_1.time_ >= 0 + var_200_1 and arg_197_1.time_ < 0 + var_200_1 + arg_200_0 then
				arg_197_1.actors_["10059"].transform.localPosition = Vector3.New(-390, -530, 35)
			end

			local var_200_2 = arg_197_1.actors_["10059"]

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(var_200_2) and arg_197_1.var_.actorSpriteComps10059 == nil then
				arg_197_1.var_.actorSpriteComps10059 = var_200_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_200_3 = 0.034

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_3 and not isNil(var_200_2) then
				if arg_197_1.var_.actorSpriteComps10059 then
					for iter_200_1, iter_200_2 in pairs(arg_197_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_200_2 then
							if arg_197_1.isInRecall_ then
								iter_200_2.color = Color.New(Mathf.Lerp(iter_200_2.color.r, arg_197_1.hightColor1.r, (arg_197_1.time_ - 0) / var_200_3), Mathf.Lerp(iter_200_2.color.g, arg_197_1.hightColor1.g, (arg_197_1.time_ - 0) / var_200_3), (Mathf.Lerp(iter_200_2.color.b, arg_197_1.hightColor1.b, (arg_197_1.time_ - 0) / var_200_3)))
							else
								local var_200_4 = Mathf.Lerp(iter_200_2.color.r, 1, (arg_197_1.time_ - 0) / var_200_3)

								iter_200_2.color = Color.New(var_200_4, var_200_4, var_200_4)
							end
						end
					end
				end
			end

			if arg_197_1.time_ >= 0 + var_200_3 and arg_197_1.time_ < 0 + var_200_3 + arg_200_0 and not isNil(var_200_2) and arg_197_1.var_.actorSpriteComps10059 then
				for iter_200_3, iter_200_4 in pairs(arg_197_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_200_4 then
						iter_200_4.color = arg_197_1.isInRecall_ and (arg_197_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_197_1.var_.actorSpriteComps10059 = nil
			end

			local var_200_5 = arg_197_1.actors_["10062"]

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(var_200_5) and arg_197_1.var_.actorSpriteComps10062 == nil then
				arg_197_1.var_.actorSpriteComps10062 = var_200_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_200_6 = 0.034

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_6 and not isNil(var_200_5) then
				if arg_197_1.var_.actorSpriteComps10062 then
					for iter_200_5, iter_200_6 in pairs(arg_197_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_200_6 then
							if arg_197_1.isInRecall_ then
								iter_200_6.color = Color.New(Mathf.Lerp(iter_200_6.color.r, arg_197_1.hightColor2.r, (arg_197_1.time_ - 0) / var_200_6), Mathf.Lerp(iter_200_6.color.g, arg_197_1.hightColor2.g, (arg_197_1.time_ - 0) / var_200_6), (Mathf.Lerp(iter_200_6.color.b, arg_197_1.hightColor2.b, (arg_197_1.time_ - 0) / var_200_6)))
							else
								local var_200_7 = Mathf.Lerp(iter_200_6.color.r, 0.5, (arg_197_1.time_ - 0) / var_200_6)

								iter_200_6.color = Color.New(var_200_7, var_200_7, var_200_7)
							end
						end
					end
				end
			end

			if arg_197_1.time_ >= 0 + var_200_6 and arg_197_1.time_ < 0 + var_200_6 + arg_200_0 and not isNil(var_200_5) and arg_197_1.var_.actorSpriteComps10062 then
				for iter_200_7, iter_200_8 in pairs(arg_197_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_200_8 then
						iter_200_8.color = arg_197_1.isInRecall_ and (arg_197_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_197_1.var_.actorSpriteComps10062 = nil
			end

			local var_200_8 = 0
			local var_200_9 = 0.375

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_8 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[596].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_10 = arg_197_1:GetWordFromCfg(410161048)
				local var_200_11 = arg_197_1:FormatText(var_200_10.content)

				arg_197_1.text_.text = var_200_11

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_13 = 15 <= 0 and var_200_9 or var_200_9 * (utf8.len(var_200_11) / 15)

				if (15 <= 0 and var_200_9 or var_200_9 * (utf8.len(var_200_11) / 15)) > 0 and var_200_9 < var_200_13 then
					arg_197_1.talkMaxDuration = var_200_13

					if var_200_13 + var_200_8 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_13 + var_200_8
					end
				end

				arg_197_1.text_.text = var_200_11
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161048", "story_v_out_410161.awb") ~= 0 then
					local var_200_14 = manager.audio:GetVoiceLength("story_v_out_410161", "410161048", "story_v_out_410161.awb") / 1000

					if var_200_14 + var_200_8 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_14 + var_200_8
					end

					if var_200_10.prefab_name ~= "" and arg_197_1.actors_[var_200_10.prefab_name] ~= nil then
						local var_200_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_10.prefab_name].transform, "story_v_out_410161", "410161048", "story_v_out_410161.awb")

						arg_197_1:RecordAudio("410161048", var_200_15)
						arg_197_1:RecordAudio("410161048", var_200_15)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_410161", "410161048", "story_v_out_410161.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_410161", "410161048", "story_v_out_410161.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_16 = math.max(var_200_9, arg_197_1.talkMaxDuration)

			if var_200_8 <= arg_197_1.time_ and arg_197_1.time_ < var_200_8 + var_200_16 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_8) / var_200_16

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_8 + var_200_16 and arg_197_1.time_ < var_200_8 + var_200_16 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_197_1:InitPlayNodeList()
	end,
	Play410161049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 410161049
		arg_201_1.duration_ = 5

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play410161050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.var_.moveOldPos10062 = arg_201_1.actors_["10062"].transform.localPosition
				arg_201_1.actors_["10062"].transform.localScale = Vector3.New(1, 1, 1)

				arg_201_1:CheckSpriteTmpPos("10062", 3)

				for iter_204_0 = 0, arg_201_1.actors_["10062"].transform.childCount - 1 do
					local var_204_0 = arg_201_1.actors_["10062"].transform:GetChild(iter_204_0)

					if var_204_0.name == "" or not string.find(var_204_0.name, "split") then
						var_204_0.gameObject:SetActive(true)
					else
						var_204_0.gameObject:SetActive(false)
					end
				end
			end

			local var_204_1 = 0.001

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_1 then
				arg_201_1.actors_["10062"].transform.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos10062, Vector3.New(0, -390, -290), (arg_201_1.time_ - 0) / var_204_1)
			end

			if arg_201_1.time_ >= 0 + var_204_1 and arg_201_1.time_ < 0 + var_204_1 + arg_204_0 then
				arg_201_1.actors_["10062"].transform.localPosition = Vector3.New(0, -390, -290)
			end

			local var_204_2 = arg_201_1.actors_["10059"].transform

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.var_.moveOldPos10059 = var_204_2.localPosition
				var_204_2.localScale = Vector3.New(1, 1, 1)

				arg_201_1:CheckSpriteTmpPos("10059", 7)

				for iter_204_1 = 0, var_204_2.childCount - 1 do
					local var_204_3 = var_204_2:GetChild(iter_204_1)

					if var_204_3.name == "" or not string.find(var_204_3.name, "split") then
						var_204_3.gameObject:SetActive(true)
					else
						var_204_3.gameObject:SetActive(false)
					end
				end
			end

			local var_204_4 = 0.001

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_4 then
				var_204_2.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos10059, Vector3.New(0, -2000, 35), (arg_201_1.time_ - 0) / var_204_4)
			end

			if arg_201_1.time_ >= 0 + var_204_4 and arg_201_1.time_ < 0 + var_204_4 + arg_204_0 then
				var_204_2.localPosition = Vector3.New(0, -2000, 35)
			end

			local var_204_5 = arg_201_1.actors_["10062"]

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 and not isNil(var_204_5) and arg_201_1.var_.actorSpriteComps10062 == nil then
				arg_201_1.var_.actorSpriteComps10062 = var_204_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_204_6 = 0.034

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_6 and not isNil(var_204_5) then
				if arg_201_1.var_.actorSpriteComps10062 then
					for iter_204_2, iter_204_3 in pairs(arg_201_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_204_3 then
							if arg_201_1.isInRecall_ then
								iter_204_3.color = Color.New(Mathf.Lerp(iter_204_3.color.r, arg_201_1.hightColor2.r, (arg_201_1.time_ - 0) / var_204_6), Mathf.Lerp(iter_204_3.color.g, arg_201_1.hightColor2.g, (arg_201_1.time_ - 0) / var_204_6), (Mathf.Lerp(iter_204_3.color.b, arg_201_1.hightColor2.b, (arg_201_1.time_ - 0) / var_204_6)))
							else
								local var_204_7 = Mathf.Lerp(iter_204_3.color.r, 0.5, (arg_201_1.time_ - 0) / var_204_6)

								iter_204_3.color = Color.New(var_204_7, var_204_7, var_204_7)
							end
						end
					end
				end
			end

			if arg_201_1.time_ >= 0 + var_204_6 and arg_201_1.time_ < 0 + var_204_6 + arg_204_0 and not isNil(var_204_5) and arg_201_1.var_.actorSpriteComps10062 then
				for iter_204_4, iter_204_5 in pairs(arg_201_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_204_5 then
						iter_204_5.color = arg_201_1.isInRecall_ and (arg_201_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_201_1.var_.actorSpriteComps10062 = nil
			end

			local var_204_8 = arg_201_1.actors_["10059"]

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 and not isNil(var_204_8) and arg_201_1.var_.actorSpriteComps10059 == nil then
				arg_201_1.var_.actorSpriteComps10059 = var_204_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_204_9 = 0.034

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_9 and not isNil(var_204_8) then
				if arg_201_1.var_.actorSpriteComps10059 then
					for iter_204_6, iter_204_7 in pairs(arg_201_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_204_7 then
							if arg_201_1.isInRecall_ then
								iter_204_7.color = Color.New(Mathf.Lerp(iter_204_7.color.r, arg_201_1.hightColor2.r, (arg_201_1.time_ - 0) / var_204_9), Mathf.Lerp(iter_204_7.color.g, arg_201_1.hightColor2.g, (arg_201_1.time_ - 0) / var_204_9), (Mathf.Lerp(iter_204_7.color.b, arg_201_1.hightColor2.b, (arg_201_1.time_ - 0) / var_204_9)))
							else
								local var_204_10 = Mathf.Lerp(iter_204_7.color.r, 0.5, (arg_201_1.time_ - 0) / var_204_9)

								iter_204_7.color = Color.New(var_204_10, var_204_10, var_204_10)
							end
						end
					end
				end
			end

			if arg_201_1.time_ >= 0 + var_204_9 and arg_201_1.time_ < 0 + var_204_9 + arg_204_0 and not isNil(var_204_8) and arg_201_1.var_.actorSpriteComps10059 then
				for iter_204_8, iter_204_9 in pairs(arg_201_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_204_9 then
						iter_204_9.color = arg_201_1.isInRecall_ and (arg_201_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_201_1.var_.actorSpriteComps10059 = nil
			end

			local var_204_11 = 0
			local var_204_12 = 0.8

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_11 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, false)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_13 = arg_201_1:FormatText(arg_201_1:GetWordFromCfg(410161049).content)

				arg_201_1.text_.text = var_204_13

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_15 = 32 <= 0 and var_204_12 or var_204_12 * (utf8.len(var_204_13) / 32)

				if (32 <= 0 and var_204_12 or var_204_12 * (utf8.len(var_204_13) / 32)) > 0 and var_204_12 < var_204_15 then
					arg_201_1.talkMaxDuration = var_204_15

					if var_204_15 + var_204_11 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_15 + var_204_11
					end
				end

				arg_201_1.text_.text = var_204_13
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)
				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_16 = math.max(var_204_12, arg_201_1.talkMaxDuration)

			if var_204_11 <= arg_201_1.time_ and arg_201_1.time_ < var_204_11 + var_204_16 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_11) / var_204_16

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_11 + var_204_16 and arg_201_1.time_ < var_204_11 + var_204_16 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_201_1:InitPlayNodeList()
	end,
	Play410161050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 410161050
		arg_205_1.duration_ = 15.33

		local var_205_0 = {
			ja = 14.3,
			CriLanguages = 15.333,
			zh = 15.333
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
				arg_205_0:Play410161051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.var_.moveOldPos10062 = arg_205_1.actors_["10062"].transform.localPosition
				arg_205_1.actors_["10062"].transform.localScale = Vector3.New(1, 1, 1)

				arg_205_1:CheckSpriteTmpPos("10062", 3)

				for iter_208_0 = 0, arg_205_1.actors_["10062"].transform.childCount - 1 do
					local var_208_0 = arg_205_1.actors_["10062"].transform:GetChild(iter_208_0)

					if var_208_0.name == "split_1_1" or not string.find(var_208_0.name, "split") then
						var_208_0.gameObject:SetActive(true)
					else
						var_208_0.gameObject:SetActive(false)
					end
				end
			end

			local var_208_1 = 0.001

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_1 then
				arg_205_1.actors_["10062"].transform.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos10062, Vector3.New(0, -390, -290), (arg_205_1.time_ - 0) / var_208_1)
			end

			if arg_205_1.time_ >= 0 + var_208_1 and arg_205_1.time_ < 0 + var_208_1 + arg_208_0 then
				arg_205_1.actors_["10062"].transform.localPosition = Vector3.New(0, -390, -290)
			end

			local var_208_2 = arg_205_1.actors_["10062"]

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 and not isNil(var_208_2) and arg_205_1.var_.actorSpriteComps10062 == nil then
				arg_205_1.var_.actorSpriteComps10062 = var_208_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_208_3 = 0.034

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_3 and not isNil(var_208_2) then
				if arg_205_1.var_.actorSpriteComps10062 then
					for iter_208_1, iter_208_2 in pairs(arg_205_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_208_2 then
							if arg_205_1.isInRecall_ then
								iter_208_2.color = Color.New(Mathf.Lerp(iter_208_2.color.r, arg_205_1.hightColor1.r, (arg_205_1.time_ - 0) / var_208_3), Mathf.Lerp(iter_208_2.color.g, arg_205_1.hightColor1.g, (arg_205_1.time_ - 0) / var_208_3), (Mathf.Lerp(iter_208_2.color.b, arg_205_1.hightColor1.b, (arg_205_1.time_ - 0) / var_208_3)))
							else
								local var_208_4 = Mathf.Lerp(iter_208_2.color.r, 1, (arg_205_1.time_ - 0) / var_208_3)

								iter_208_2.color = Color.New(var_208_4, var_208_4, var_208_4)
							end
						end
					end
				end
			end

			if arg_205_1.time_ >= 0 + var_208_3 and arg_205_1.time_ < 0 + var_208_3 + arg_208_0 and not isNil(var_208_2) and arg_205_1.var_.actorSpriteComps10062 then
				for iter_208_3, iter_208_4 in pairs(arg_205_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_208_4 then
						iter_208_4.color = arg_205_1.isInRecall_ and (arg_205_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_205_1.var_.actorSpriteComps10062 = nil
			end

			local var_208_5 = 0
			local var_208_6 = 1.325

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_5 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				arg_205_1.leftNameTxt_.text = arg_205_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_7 = arg_205_1:GetWordFromCfg(410161050)
				local var_208_8 = arg_205_1:FormatText(var_208_7.content)

				arg_205_1.text_.text = var_208_8

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_10 = 53 <= 0 and var_208_6 or var_208_6 * (utf8.len(var_208_8) / 53)

				if (53 <= 0 and var_208_6 or var_208_6 * (utf8.len(var_208_8) / 53)) > 0 and var_208_6 < var_208_10 then
					arg_205_1.talkMaxDuration = var_208_10

					if var_208_10 + var_208_5 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_10 + var_208_5
					end
				end

				arg_205_1.text_.text = var_208_8
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161050", "story_v_out_410161.awb") ~= 0 then
					local var_208_11 = manager.audio:GetVoiceLength("story_v_out_410161", "410161050", "story_v_out_410161.awb") / 1000

					if var_208_11 + var_208_5 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_11 + var_208_5
					end

					if var_208_7.prefab_name ~= "" and arg_205_1.actors_[var_208_7.prefab_name] ~= nil then
						local var_208_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_7.prefab_name].transform, "story_v_out_410161", "410161050", "story_v_out_410161.awb")

						arg_205_1:RecordAudio("410161050", var_208_12)
						arg_205_1:RecordAudio("410161050", var_208_12)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_410161", "410161050", "story_v_out_410161.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_410161", "410161050", "story_v_out_410161.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_13 = math.max(var_208_6, arg_205_1.talkMaxDuration)

			if var_208_5 <= arg_205_1.time_ and arg_205_1.time_ < var_208_5 + var_208_13 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_5) / var_208_13

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_5 + var_208_13 and arg_205_1.time_ < var_208_5 + var_208_13 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
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
	Play410161051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 410161051
		arg_209_1.duration_ = 9

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play410161052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			if arg_209_1.bgs_.L04f == nil then
				local var_212_0 = Object.Instantiate(arg_209_1.paintGo_)

				var_212_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L04f")
				var_212_0.name = "L04f"
				var_212_0.transform.parent = arg_209_1.stage_.transform
				var_212_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_209_1.bgs_.L04f = var_212_0
			end

			if 2 < arg_209_1.time_ and arg_209_1.time_ <= 2 + arg_212_0 then
				local var_212_1 = arg_209_1.bgs_.L04f

				arg_209_1.bgs_.L04f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_212_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_212_2 = var_212_1:GetComponent("SpriteRenderer")

				if var_212_2 and var_212_2.sprite then
					local var_212_3 = 2 * (var_212_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_212_1.transform.localScale = Vector3.New(var_212_3 / var_212_2.sprite.bounds.size.y < var_212_3 * manager.ui.mainCameraCom_.aspect / var_212_2.sprite.bounds.size.x and var_212_3 * manager.ui.mainCameraCom_.aspect / var_212_2.sprite.bounds.size.x or var_212_3 / var_212_2.sprite.bounds.size.y, var_212_3 / var_212_2.sprite.bounds.size.y < var_212_3 * manager.ui.mainCameraCom_.aspect / var_212_2.sprite.bounds.size.x and var_212_3 * manager.ui.mainCameraCom_.aspect / var_212_2.sprite.bounds.size.x or var_212_3 / var_212_2.sprite.bounds.size.y, 0)
				end

				for iter_212_0, iter_212_1 in pairs(arg_209_1.bgs_) do
					if iter_212_0 ~= "L04f" then
						iter_212_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_212_4 = 0

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_4 + arg_212_0 then
				arg_209_1.mask_.enabled = true
				arg_209_1.mask_.raycastTarget = true

				arg_209_1:SetGaussion(false)
			end

			local var_212_5 = 2

			if var_212_4 <= arg_209_1.time_ and arg_209_1.time_ < var_212_4 + var_212_5 then
				local var_212_6 = Color.New(0, 0, 0)

				var_212_6.a = Mathf.Lerp(0, 1, (arg_209_1.time_ - var_212_4) / var_212_5)
				arg_209_1.mask_.color = var_212_6
			end

			if arg_209_1.time_ >= var_212_4 + var_212_5 and arg_209_1.time_ < var_212_4 + var_212_5 + arg_212_0 then
				local var_212_7 = Color.New(0, 0, 0)

				var_212_7.a = 1
				arg_209_1.mask_.color = var_212_7
			end

			local var_212_8 = 2

			if 2 < arg_209_1.time_ and arg_209_1.time_ <= var_212_8 + arg_212_0 then
				arg_209_1.mask_.enabled = true
				arg_209_1.mask_.raycastTarget = true

				arg_209_1:SetGaussion(false)
			end

			local var_212_9 = 2

			if var_212_8 <= arg_209_1.time_ and arg_209_1.time_ < var_212_8 + var_212_9 then
				local var_212_10 = Color.New(0, 0, 0)

				var_212_10.a = Mathf.Lerp(1, 0, (arg_209_1.time_ - var_212_8) / var_212_9)
				arg_209_1.mask_.color = var_212_10
			end

			if arg_209_1.time_ >= var_212_8 + var_212_9 and arg_209_1.time_ < var_212_8 + var_212_9 + arg_212_0 then
				local var_212_11 = Color.New(0, 0, 0)

				arg_209_1.mask_.enabled = false
				var_212_11.a = 0
				arg_209_1.mask_.color = var_212_11
			end

			local var_212_12 = arg_209_1.actors_["10062"].transform

			if 2 < arg_209_1.time_ and arg_209_1.time_ <= 2 + arg_212_0 then
				arg_209_1.var_.moveOldPos10062 = var_212_12.localPosition
				var_212_12.localScale = Vector3.New(1, 1, 1)

				arg_209_1:CheckSpriteTmpPos("10062", 7)

				for iter_212_2 = 0, var_212_12.childCount - 1 do
					local var_212_13 = var_212_12:GetChild(iter_212_2)

					if var_212_13.name == "" or not string.find(var_212_13.name, "split") then
						var_212_13.gameObject:SetActive(true)
					else
						var_212_13.gameObject:SetActive(false)
					end
				end
			end

			local var_212_14 = 0.001

			if 2 <= arg_209_1.time_ and arg_209_1.time_ < 2 + var_212_14 then
				var_212_12.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos10062, Vector3.New(0, -2000, -290), (arg_209_1.time_ - 2) / var_212_14)
			end

			if arg_209_1.time_ >= 2 + var_212_14 and arg_209_1.time_ < 2 + var_212_14 + arg_212_0 then
				var_212_12.localPosition = Vector3.New(0, -2000, -290)
			end

			local var_212_15 = arg_209_1.actors_["10062"]

			if 2 < arg_209_1.time_ and arg_209_1.time_ <= 2 + arg_212_0 and not isNil(var_212_15) and arg_209_1.var_.actorSpriteComps10062 == nil then
				arg_209_1.var_.actorSpriteComps10062 = var_212_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_212_16 = 0.034

			if 2 <= arg_209_1.time_ and arg_209_1.time_ < 2 + var_212_16 and not isNil(var_212_15) then
				if arg_209_1.var_.actorSpriteComps10062 then
					for iter_212_3, iter_212_4 in pairs(arg_209_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_212_4 then
							if arg_209_1.isInRecall_ then
								iter_212_4.color = Color.New(Mathf.Lerp(iter_212_4.color.r, arg_209_1.hightColor2.r, (arg_209_1.time_ - 2) / var_212_16), Mathf.Lerp(iter_212_4.color.g, arg_209_1.hightColor2.g, (arg_209_1.time_ - 2) / var_212_16), (Mathf.Lerp(iter_212_4.color.b, arg_209_1.hightColor2.b, (arg_209_1.time_ - 2) / var_212_16)))
							else
								local var_212_17 = Mathf.Lerp(iter_212_4.color.r, 0.5, (arg_209_1.time_ - 2) / var_212_16)

								iter_212_4.color = Color.New(var_212_17, var_212_17, var_212_17)
							end
						end
					end
				end
			end

			if arg_209_1.time_ >= 2 + var_212_16 and arg_209_1.time_ < 2 + var_212_16 + arg_212_0 and not isNil(var_212_15) and arg_209_1.var_.actorSpriteComps10062 then
				for iter_212_5, iter_212_6 in pairs(arg_209_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_212_6 then
						iter_212_6.color = arg_209_1.isInRecall_ and (arg_209_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_209_1.var_.actorSpriteComps10062 = nil
			end

			if arg_209_1.frameCnt_ <= 1 then
				arg_209_1.dialog_:SetActive(false)
			end

			local var_212_18 = 4
			local var_212_19 = 0.825

			if 4 < arg_209_1.time_ and arg_209_1.time_ <= var_212_18 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0

				arg_209_1.dialog_:SetActive(true)

				arg_209_1.dialogCg_.alpha = 0

				local var_212_20 = LeanTween.value(arg_209_1.dialog_, 0, 1, 0.3)

				var_212_20:setOnUpdate(LuaHelper.FloatAction(function(arg_213_0)
					arg_209_1.dialogCg_.alpha = arg_213_0
				end))
				var_212_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_209_1.dialog_)
					var_212_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_209_1.duration_ = arg_209_1.duration_ + 0.3

				SetActive(arg_209_1.leftNameGo_, false)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_21 = arg_209_1:FormatText(arg_209_1:GetWordFromCfg(410161051).content)

				arg_209_1.text_.text = var_212_21

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_23 = 33 <= 0 and var_212_19 or var_212_19 * (utf8.len(var_212_21) / 33)

				if (33 <= 0 and var_212_19 or var_212_19 * (utf8.len(var_212_21) / 33)) > 0 and var_212_19 < var_212_23 then
					arg_209_1.talkMaxDuration = var_212_23
					var_212_18 = var_212_18 + 0.3

					if var_212_23 + var_212_18 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_23 + var_212_18
					end
				end

				arg_209_1.text_.text = var_212_21
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)
				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_24 = var_212_18 + 0.3
			local var_212_25 = math.max(var_212_19, arg_209_1.talkMaxDuration)

			if var_212_18 + 0.3 <= arg_209_1.time_ and arg_209_1.time_ < var_212_24 + var_212_25 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_24) / var_212_25

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_24 + var_212_25 and arg_209_1.time_ < var_212_24 + var_212_25 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_209_1:InitPlayNodeList()
	end,
	Play410161052 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 410161052
		arg_215_1.duration_ = 5

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play410161053(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = 1.1

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, false)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_1 = arg_215_1:FormatText(arg_215_1:GetWordFromCfg(410161052).content)

				arg_215_1.text_.text = var_218_1

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_3 = 44 <= 0 and var_218_0 or var_218_0 * (utf8.len(var_218_1) / 44)

				if (44 <= 0 and var_218_0 or var_218_0 * (utf8.len(var_218_1) / 44)) > 0 and var_218_0 < var_218_3 then
					arg_215_1.talkMaxDuration = var_218_3

					if var_218_3 + 0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_3 + 0
					end
				end

				arg_215_1.text_.text = var_218_1
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)
				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_4 = math.max(var_218_0, arg_215_1.talkMaxDuration)

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_4 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - 0) / var_218_4

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= 0 + var_218_4 and arg_215_1.time_ < 0 + var_218_4 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play410161053 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 410161053
		arg_219_1.duration_ = 5

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play410161054(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = 1.325

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, false)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_1 = arg_219_1:FormatText(arg_219_1:GetWordFromCfg(410161053).content)

				arg_219_1.text_.text = var_222_1

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_3 = 53 <= 0 and var_222_0 or var_222_0 * (utf8.len(var_222_1) / 53)

				if (53 <= 0 and var_222_0 or var_222_0 * (utf8.len(var_222_1) / 53)) > 0 and var_222_0 < var_222_3 then
					arg_219_1.talkMaxDuration = var_222_3

					if var_222_3 + 0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_3 + 0
					end
				end

				arg_219_1.text_.text = var_222_1
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)
				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_4 = math.max(var_222_0, arg_219_1.talkMaxDuration)

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_4 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - 0) / var_222_4

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= 0 + var_222_4 and arg_219_1.time_ < 0 + var_222_4 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play410161054 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 410161054
		arg_223_1.duration_ = 2.9

		local var_223_0 = {
			ja = 1.566,
			CriLanguages = 2.9,
			zh = 2.9
		}
		local var_223_1 = manager.audio:GetLocalizationFlag()

		if var_223_0[var_223_1] ~= nil then
			arg_223_1.duration_ = var_223_0[var_223_1]
		end

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play410161055(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1.var_.moveOldPos10059 = arg_223_1.actors_["10059"].transform.localPosition
				arg_223_1.actors_["10059"].transform.localScale = Vector3.New(1, 1, 1)

				arg_223_1:CheckSpriteTmpPos("10059", 4)

				for iter_226_0 = 0, arg_223_1.actors_["10059"].transform.childCount - 1 do
					local var_226_0 = arg_223_1.actors_["10059"].transform:GetChild(iter_226_0)

					if var_226_0.name == "" or not string.find(var_226_0.name, "split") then
						var_226_0.gameObject:SetActive(true)
					else
						var_226_0.gameObject:SetActive(false)
					end
				end
			end

			local var_226_1 = 0.001

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_1 then
				arg_223_1.actors_["10059"].transform.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos10059, Vector3.New(390, -530, 35), (arg_223_1.time_ - 0) / var_226_1)
			end

			if arg_223_1.time_ >= 0 + var_226_1 and arg_223_1.time_ < 0 + var_226_1 + arg_226_0 then
				arg_223_1.actors_["10059"].transform.localPosition = Vector3.New(390, -530, 35)
			end

			local var_226_2 = arg_223_1.actors_["1061"].transform

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1.var_.moveOldPos1061 = var_226_2.localPosition
				var_226_2.localScale = Vector3.New(1, 1, 1)

				arg_223_1:CheckSpriteTmpPos("1061", 2)

				for iter_226_1 = 0, var_226_2.childCount - 1 do
					local var_226_3 = var_226_2:GetChild(iter_226_1)

					if var_226_3.name == "" or not string.find(var_226_3.name, "split") then
						var_226_3.gameObject:SetActive(true)
					else
						var_226_3.gameObject:SetActive(false)
					end
				end
			end

			local var_226_4 = 0.001

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_4 then
				var_226_2.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (arg_223_1.time_ - 0) / var_226_4)
			end

			if arg_223_1.time_ >= 0 + var_226_4 and arg_223_1.time_ < 0 + var_226_4 + arg_226_0 then
				var_226_2.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_226_5 = arg_223_1.actors_["10059"]

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 and not isNil(var_226_5) and arg_223_1.var_.actorSpriteComps10059 == nil then
				arg_223_1.var_.actorSpriteComps10059 = var_226_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_226_6 = 0.034

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_6 and not isNil(var_226_5) then
				if arg_223_1.var_.actorSpriteComps10059 then
					for iter_226_2, iter_226_3 in pairs(arg_223_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_226_3 then
							if arg_223_1.isInRecall_ then
								iter_226_3.color = Color.New(Mathf.Lerp(iter_226_3.color.r, arg_223_1.hightColor1.r, (arg_223_1.time_ - 0) / var_226_6), Mathf.Lerp(iter_226_3.color.g, arg_223_1.hightColor1.g, (arg_223_1.time_ - 0) / var_226_6), (Mathf.Lerp(iter_226_3.color.b, arg_223_1.hightColor1.b, (arg_223_1.time_ - 0) / var_226_6)))
							else
								local var_226_7 = Mathf.Lerp(iter_226_3.color.r, 1, (arg_223_1.time_ - 0) / var_226_6)

								iter_226_3.color = Color.New(var_226_7, var_226_7, var_226_7)
							end
						end
					end
				end
			end

			if arg_223_1.time_ >= 0 + var_226_6 and arg_223_1.time_ < 0 + var_226_6 + arg_226_0 and not isNil(var_226_5) and arg_223_1.var_.actorSpriteComps10059 then
				for iter_226_4, iter_226_5 in pairs(arg_223_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_226_5 then
						iter_226_5.color = arg_223_1.isInRecall_ and (arg_223_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_223_1.var_.actorSpriteComps10059 = nil
			end

			local var_226_8 = arg_223_1.actors_["1061"]

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 and not isNil(var_226_8) and arg_223_1.var_.actorSpriteComps1061 == nil then
				arg_223_1.var_.actorSpriteComps1061 = var_226_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_226_9 = 0.034

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_9 and not isNil(var_226_8) then
				if arg_223_1.var_.actorSpriteComps1061 then
					for iter_226_6, iter_226_7 in pairs(arg_223_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_226_7 then
							if arg_223_1.isInRecall_ then
								iter_226_7.color = Color.New(Mathf.Lerp(iter_226_7.color.r, arg_223_1.hightColor2.r, (arg_223_1.time_ - 0) / var_226_9), Mathf.Lerp(iter_226_7.color.g, arg_223_1.hightColor2.g, (arg_223_1.time_ - 0) / var_226_9), (Mathf.Lerp(iter_226_7.color.b, arg_223_1.hightColor2.b, (arg_223_1.time_ - 0) / var_226_9)))
							else
								local var_226_10 = Mathf.Lerp(iter_226_7.color.r, 0.5, (arg_223_1.time_ - 0) / var_226_9)

								iter_226_7.color = Color.New(var_226_10, var_226_10, var_226_10)
							end
						end
					end
				end
			end

			if arg_223_1.time_ >= 0 + var_226_9 and arg_223_1.time_ < 0 + var_226_9 + arg_226_0 and not isNil(var_226_8) and arg_223_1.var_.actorSpriteComps1061 then
				for iter_226_8, iter_226_9 in pairs(arg_223_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_226_9 then
						iter_226_9.color = arg_223_1.isInRecall_ and (arg_223_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_223_1.var_.actorSpriteComps1061 = nil
			end

			local var_226_11 = 0
			local var_226_12 = 0.325

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_11 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				arg_223_1.leftNameTxt_.text = arg_223_1:FormatText(StoryNameCfg[596].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_13 = arg_223_1:GetWordFromCfg(410161054)
				local var_226_14 = arg_223_1:FormatText(var_226_13.content)

				arg_223_1.text_.text = var_226_14

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_16 = 13 <= 0 and var_226_12 or var_226_12 * (utf8.len(var_226_14) / 13)

				if (13 <= 0 and var_226_12 or var_226_12 * (utf8.len(var_226_14) / 13)) > 0 and var_226_12 < var_226_16 then
					arg_223_1.talkMaxDuration = var_226_16

					if var_226_16 + var_226_11 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_16 + var_226_11
					end
				end

				arg_223_1.text_.text = var_226_14
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161054", "story_v_out_410161.awb") ~= 0 then
					local var_226_17 = manager.audio:GetVoiceLength("story_v_out_410161", "410161054", "story_v_out_410161.awb") / 1000

					if var_226_17 + var_226_11 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_17 + var_226_11
					end

					if var_226_13.prefab_name ~= "" and arg_223_1.actors_[var_226_13.prefab_name] ~= nil then
						local var_226_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_13.prefab_name].transform, "story_v_out_410161", "410161054", "story_v_out_410161.awb")

						arg_223_1:RecordAudio("410161054", var_226_18)
						arg_223_1:RecordAudio("410161054", var_226_18)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_410161", "410161054", "story_v_out_410161.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_410161", "410161054", "story_v_out_410161.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_19 = math.max(var_226_12, arg_223_1.talkMaxDuration)

			if var_226_11 <= arg_223_1.time_ and arg_223_1.time_ < var_226_11 + var_226_19 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_11) / var_226_19

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_11 + var_226_19 and arg_223_1.time_ < var_226_11 + var_226_19 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1061",
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
	Play410161055 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 410161055
		arg_227_1.duration_ = 9.97

		local var_227_0 = {
			ja = 9.966,
			CriLanguages = 6.033,
			zh = 6.033
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
				arg_227_0:Play410161056(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1.var_.moveOldPos1061 = arg_227_1.actors_["1061"].transform.localPosition
				arg_227_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_227_1:CheckSpriteTmpPos("1061", 2)

				for iter_230_0 = 0, arg_227_1.actors_["1061"].transform.childCount - 1 do
					local var_230_0 = arg_227_1.actors_["1061"].transform:GetChild(iter_230_0)

					if var_230_0.name == "split_5" or not string.find(var_230_0.name, "split") then
						var_230_0.gameObject:SetActive(true)
					else
						var_230_0.gameObject:SetActive(false)
					end
				end
			end

			local var_230_1 = 0.001

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_1 then
				arg_227_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_227_1.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (arg_227_1.time_ - 0) / var_230_1)
			end

			if arg_227_1.time_ >= 0 + var_230_1 and arg_227_1.time_ < 0 + var_230_1 + arg_230_0 then
				arg_227_1.actors_["1061"].transform.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_230_2 = arg_227_1.actors_["1061"]

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 and not isNil(var_230_2) and arg_227_1.var_.actorSpriteComps1061 == nil then
				arg_227_1.var_.actorSpriteComps1061 = var_230_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_230_3 = 0.034

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_3 and not isNil(var_230_2) then
				if arg_227_1.var_.actorSpriteComps1061 then
					for iter_230_1, iter_230_2 in pairs(arg_227_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_230_2 then
							if arg_227_1.isInRecall_ then
								iter_230_2.color = Color.New(Mathf.Lerp(iter_230_2.color.r, arg_227_1.hightColor1.r, (arg_227_1.time_ - 0) / var_230_3), Mathf.Lerp(iter_230_2.color.g, arg_227_1.hightColor1.g, (arg_227_1.time_ - 0) / var_230_3), (Mathf.Lerp(iter_230_2.color.b, arg_227_1.hightColor1.b, (arg_227_1.time_ - 0) / var_230_3)))
							else
								local var_230_4 = Mathf.Lerp(iter_230_2.color.r, 1, (arg_227_1.time_ - 0) / var_230_3)

								iter_230_2.color = Color.New(var_230_4, var_230_4, var_230_4)
							end
						end
					end
				end
			end

			if arg_227_1.time_ >= 0 + var_230_3 and arg_227_1.time_ < 0 + var_230_3 + arg_230_0 and not isNil(var_230_2) and arg_227_1.var_.actorSpriteComps1061 then
				for iter_230_3, iter_230_4 in pairs(arg_227_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_230_4 then
						iter_230_4.color = arg_227_1.isInRecall_ and (arg_227_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_227_1.var_.actorSpriteComps1061 = nil
			end

			local var_230_5 = arg_227_1.actors_["10059"]

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 and not isNil(var_230_5) and arg_227_1.var_.actorSpriteComps10059 == nil then
				arg_227_1.var_.actorSpriteComps10059 = var_230_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_230_6 = 0.034

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_6 and not isNil(var_230_5) then
				if arg_227_1.var_.actorSpriteComps10059 then
					for iter_230_5, iter_230_6 in pairs(arg_227_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_230_6 then
							if arg_227_1.isInRecall_ then
								iter_230_6.color = Color.New(Mathf.Lerp(iter_230_6.color.r, arg_227_1.hightColor2.r, (arg_227_1.time_ - 0) / var_230_6), Mathf.Lerp(iter_230_6.color.g, arg_227_1.hightColor2.g, (arg_227_1.time_ - 0) / var_230_6), (Mathf.Lerp(iter_230_6.color.b, arg_227_1.hightColor2.b, (arg_227_1.time_ - 0) / var_230_6)))
							else
								local var_230_7 = Mathf.Lerp(iter_230_6.color.r, 0.5, (arg_227_1.time_ - 0) / var_230_6)

								iter_230_6.color = Color.New(var_230_7, var_230_7, var_230_7)
							end
						end
					end
				end
			end

			if arg_227_1.time_ >= 0 + var_230_6 and arg_227_1.time_ < 0 + var_230_6 + arg_230_0 and not isNil(var_230_5) and arg_227_1.var_.actorSpriteComps10059 then
				for iter_230_7, iter_230_8 in pairs(arg_227_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_230_8 then
						iter_230_8.color = arg_227_1.isInRecall_ and (arg_227_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_227_1.var_.actorSpriteComps10059 = nil
			end

			local var_230_8 = 0
			local var_230_9 = 0.55

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_8 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				arg_227_1.leftNameTxt_.text = arg_227_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_10 = arg_227_1:GetWordFromCfg(410161055)
				local var_230_11 = arg_227_1:FormatText(var_230_10.content)

				arg_227_1.text_.text = var_230_11

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_13 = 22 <= 0 and var_230_9 or var_230_9 * (utf8.len(var_230_11) / 22)

				if (22 <= 0 and var_230_9 or var_230_9 * (utf8.len(var_230_11) / 22)) > 0 and var_230_9 < var_230_13 then
					arg_227_1.talkMaxDuration = var_230_13

					if var_230_13 + var_230_8 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_13 + var_230_8
					end
				end

				arg_227_1.text_.text = var_230_11
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161055", "story_v_out_410161.awb") ~= 0 then
					local var_230_14 = manager.audio:GetVoiceLength("story_v_out_410161", "410161055", "story_v_out_410161.awb") / 1000

					if var_230_14 + var_230_8 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_14 + var_230_8
					end

					if var_230_10.prefab_name ~= "" and arg_227_1.actors_[var_230_10.prefab_name] ~= nil then
						local var_230_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_10.prefab_name].transform, "story_v_out_410161", "410161055", "story_v_out_410161.awb")

						arg_227_1:RecordAudio("410161055", var_230_15)
						arg_227_1:RecordAudio("410161055", var_230_15)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_410161", "410161055", "story_v_out_410161.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_410161", "410161055", "story_v_out_410161.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_16 = math.max(var_230_9, arg_227_1.talkMaxDuration)

			if var_230_8 <= arg_227_1.time_ and arg_227_1.time_ < var_230_8 + var_230_16 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_8) / var_230_16

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_8 + var_230_16 and arg_227_1.time_ < var_230_8 + var_230_16 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_227_1:InitPlayNodeList()
	end,
	Play410161056 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 410161056
		arg_231_1.duration_ = 7.8

		local var_231_0 = {
			ja = 7.8,
			CriLanguages = 7.233,
			zh = 7.233
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
				arg_231_0:Play410161057(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1.var_.moveOldPos10059 = arg_231_1.actors_["10059"].transform.localPosition
				arg_231_1.actors_["10059"].transform.localScale = Vector3.New(1, 1, 1)

				arg_231_1:CheckSpriteTmpPos("10059", 4)

				for iter_234_0 = 0, arg_231_1.actors_["10059"].transform.childCount - 1 do
					local var_234_0 = arg_231_1.actors_["10059"].transform:GetChild(iter_234_0)

					if var_234_0.name == "" or not string.find(var_234_0.name, "split") then
						var_234_0.gameObject:SetActive(true)
					else
						var_234_0.gameObject:SetActive(false)
					end
				end
			end

			local var_234_1 = 0.001

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_1 then
				arg_231_1.actors_["10059"].transform.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos10059, Vector3.New(390, -530, 35), (arg_231_1.time_ - 0) / var_234_1)
			end

			if arg_231_1.time_ >= 0 + var_234_1 and arg_231_1.time_ < 0 + var_234_1 + arg_234_0 then
				arg_231_1.actors_["10059"].transform.localPosition = Vector3.New(390, -530, 35)
			end

			local var_234_2 = arg_231_1.actors_["10059"]

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 and not isNil(var_234_2) and arg_231_1.var_.actorSpriteComps10059 == nil then
				arg_231_1.var_.actorSpriteComps10059 = var_234_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_234_3 = 0.034

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_3 and not isNil(var_234_2) then
				if arg_231_1.var_.actorSpriteComps10059 then
					for iter_234_1, iter_234_2 in pairs(arg_231_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_234_2 then
							if arg_231_1.isInRecall_ then
								iter_234_2.color = Color.New(Mathf.Lerp(iter_234_2.color.r, arg_231_1.hightColor1.r, (arg_231_1.time_ - 0) / var_234_3), Mathf.Lerp(iter_234_2.color.g, arg_231_1.hightColor1.g, (arg_231_1.time_ - 0) / var_234_3), (Mathf.Lerp(iter_234_2.color.b, arg_231_1.hightColor1.b, (arg_231_1.time_ - 0) / var_234_3)))
							else
								local var_234_4 = Mathf.Lerp(iter_234_2.color.r, 1, (arg_231_1.time_ - 0) / var_234_3)

								iter_234_2.color = Color.New(var_234_4, var_234_4, var_234_4)
							end
						end
					end
				end
			end

			if arg_231_1.time_ >= 0 + var_234_3 and arg_231_1.time_ < 0 + var_234_3 + arg_234_0 and not isNil(var_234_2) and arg_231_1.var_.actorSpriteComps10059 then
				for iter_234_3, iter_234_4 in pairs(arg_231_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_234_4 then
						iter_234_4.color = arg_231_1.isInRecall_ and (arg_231_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_231_1.var_.actorSpriteComps10059 = nil
			end

			local var_234_5 = arg_231_1.actors_["1061"]

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 and not isNil(var_234_5) and arg_231_1.var_.actorSpriteComps1061 == nil then
				arg_231_1.var_.actorSpriteComps1061 = var_234_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_234_6 = 0.034

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_6 and not isNil(var_234_5) then
				if arg_231_1.var_.actorSpriteComps1061 then
					for iter_234_5, iter_234_6 in pairs(arg_231_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_234_6 then
							if arg_231_1.isInRecall_ then
								iter_234_6.color = Color.New(Mathf.Lerp(iter_234_6.color.r, arg_231_1.hightColor2.r, (arg_231_1.time_ - 0) / var_234_6), Mathf.Lerp(iter_234_6.color.g, arg_231_1.hightColor2.g, (arg_231_1.time_ - 0) / var_234_6), (Mathf.Lerp(iter_234_6.color.b, arg_231_1.hightColor2.b, (arg_231_1.time_ - 0) / var_234_6)))
							else
								local var_234_7 = Mathf.Lerp(iter_234_6.color.r, 0.5, (arg_231_1.time_ - 0) / var_234_6)

								iter_234_6.color = Color.New(var_234_7, var_234_7, var_234_7)
							end
						end
					end
				end
			end

			if arg_231_1.time_ >= 0 + var_234_6 and arg_231_1.time_ < 0 + var_234_6 + arg_234_0 and not isNil(var_234_5) and arg_231_1.var_.actorSpriteComps1061 then
				for iter_234_7, iter_234_8 in pairs(arg_231_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_234_8 then
						iter_234_8.color = arg_231_1.isInRecall_ and (arg_231_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_231_1.var_.actorSpriteComps1061 = nil
			end

			local var_234_8 = 0
			local var_234_9 = 0.775

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_8 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				arg_231_1.leftNameTxt_.text = arg_231_1:FormatText(StoryNameCfg[596].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_10 = arg_231_1:GetWordFromCfg(410161056)
				local var_234_11 = arg_231_1:FormatText(var_234_10.content)

				arg_231_1.text_.text = var_234_11

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_13 = 31 <= 0 and var_234_9 or var_234_9 * (utf8.len(var_234_11) / 31)

				if (31 <= 0 and var_234_9 or var_234_9 * (utf8.len(var_234_11) / 31)) > 0 and var_234_9 < var_234_13 then
					arg_231_1.talkMaxDuration = var_234_13

					if var_234_13 + var_234_8 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_13 + var_234_8
					end
				end

				arg_231_1.text_.text = var_234_11
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161056", "story_v_out_410161.awb") ~= 0 then
					local var_234_14 = manager.audio:GetVoiceLength("story_v_out_410161", "410161056", "story_v_out_410161.awb") / 1000

					if var_234_14 + var_234_8 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_14 + var_234_8
					end

					if var_234_10.prefab_name ~= "" and arg_231_1.actors_[var_234_10.prefab_name] ~= nil then
						local var_234_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_10.prefab_name].transform, "story_v_out_410161", "410161056", "story_v_out_410161.awb")

						arg_231_1:RecordAudio("410161056", var_234_15)
						arg_231_1:RecordAudio("410161056", var_234_15)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_410161", "410161056", "story_v_out_410161.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_410161", "410161056", "story_v_out_410161.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_16 = math.max(var_234_9, arg_231_1.talkMaxDuration)

			if var_234_8 <= arg_231_1.time_ and arg_231_1.time_ < var_234_8 + var_234_16 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_8) / var_234_16

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_8 + var_234_16 and arg_231_1.time_ < var_234_8 + var_234_16 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_231_1:InitPlayNodeList()
	end,
	Play410161057 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 410161057
		arg_235_1.duration_ = 8.8

		local var_235_0 = {
			ja = 7.4,
			CriLanguages = 8.8,
			zh = 8.8
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
				arg_235_0:Play410161058(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1.var_.moveOldPos10059 = arg_235_1.actors_["10059"].transform.localPosition
				arg_235_1.actors_["10059"].transform.localScale = Vector3.New(1, 1, 1)

				arg_235_1:CheckSpriteTmpPos("10059", 4)

				for iter_238_0 = 0, arg_235_1.actors_["10059"].transform.childCount - 1 do
					local var_238_0 = arg_235_1.actors_["10059"].transform:GetChild(iter_238_0)

					if var_238_0.name == "" or not string.find(var_238_0.name, "split") then
						var_238_0.gameObject:SetActive(true)
					else
						var_238_0.gameObject:SetActive(false)
					end
				end
			end

			local var_238_1 = 0.001

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_1 then
				arg_235_1.actors_["10059"].transform.localPosition = Vector3.Lerp(arg_235_1.var_.moveOldPos10059, Vector3.New(390, -530, 35), (arg_235_1.time_ - 0) / var_238_1)
			end

			if arg_235_1.time_ >= 0 + var_238_1 and arg_235_1.time_ < 0 + var_238_1 + arg_238_0 then
				arg_235_1.actors_["10059"].transform.localPosition = Vector3.New(390, -530, 35)
			end

			local var_238_2 = arg_235_1.actors_["10059"]

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 and not isNil(var_238_2) and arg_235_1.var_.actorSpriteComps10059 == nil then
				arg_235_1.var_.actorSpriteComps10059 = var_238_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_238_3 = 0.034

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_3 and not isNil(var_238_2) then
				if arg_235_1.var_.actorSpriteComps10059 then
					for iter_238_1, iter_238_2 in pairs(arg_235_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_238_2 then
							if arg_235_1.isInRecall_ then
								iter_238_2.color = Color.New(Mathf.Lerp(iter_238_2.color.r, arg_235_1.hightColor1.r, (arg_235_1.time_ - 0) / var_238_3), Mathf.Lerp(iter_238_2.color.g, arg_235_1.hightColor1.g, (arg_235_1.time_ - 0) / var_238_3), (Mathf.Lerp(iter_238_2.color.b, arg_235_1.hightColor1.b, (arg_235_1.time_ - 0) / var_238_3)))
							else
								local var_238_4 = Mathf.Lerp(iter_238_2.color.r, 1, (arg_235_1.time_ - 0) / var_238_3)

								iter_238_2.color = Color.New(var_238_4, var_238_4, var_238_4)
							end
						end
					end
				end
			end

			if arg_235_1.time_ >= 0 + var_238_3 and arg_235_1.time_ < 0 + var_238_3 + arg_238_0 and not isNil(var_238_2) and arg_235_1.var_.actorSpriteComps10059 then
				for iter_238_3, iter_238_4 in pairs(arg_235_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_238_4 then
						iter_238_4.color = arg_235_1.isInRecall_ and (arg_235_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_235_1.var_.actorSpriteComps10059 = nil
			end

			local var_238_5 = 0
			local var_238_6 = 0.95

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_5 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				arg_235_1.leftNameTxt_.text = arg_235_1:FormatText(StoryNameCfg[596].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_7 = arg_235_1:GetWordFromCfg(410161057)
				local var_238_8 = arg_235_1:FormatText(var_238_7.content)

				arg_235_1.text_.text = var_238_8

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_10 = 38 <= 0 and var_238_6 or var_238_6 * (utf8.len(var_238_8) / 38)

				if (38 <= 0 and var_238_6 or var_238_6 * (utf8.len(var_238_8) / 38)) > 0 and var_238_6 < var_238_10 then
					arg_235_1.talkMaxDuration = var_238_10

					if var_238_10 + var_238_5 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_10 + var_238_5
					end
				end

				arg_235_1.text_.text = var_238_8
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161057", "story_v_out_410161.awb") ~= 0 then
					local var_238_11 = manager.audio:GetVoiceLength("story_v_out_410161", "410161057", "story_v_out_410161.awb") / 1000

					if var_238_11 + var_238_5 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_11 + var_238_5
					end

					if var_238_7.prefab_name ~= "" and arg_235_1.actors_[var_238_7.prefab_name] ~= nil then
						local var_238_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_7.prefab_name].transform, "story_v_out_410161", "410161057", "story_v_out_410161.awb")

						arg_235_1:RecordAudio("410161057", var_238_12)
						arg_235_1:RecordAudio("410161057", var_238_12)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_410161", "410161057", "story_v_out_410161.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_410161", "410161057", "story_v_out_410161.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_13 = math.max(var_238_6, arg_235_1.talkMaxDuration)

			if var_238_5 <= arg_235_1.time_ and arg_235_1.time_ < var_238_5 + var_238_13 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_5) / var_238_13

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_5 + var_238_13 and arg_235_1.time_ < var_238_5 + var_238_13 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_235_1:InitPlayNodeList()
	end,
	Play410161058 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 410161058
		arg_239_1.duration_ = 5.33

		local var_239_0 = {
			ja = 5.333,
			CriLanguages = 2.5,
			zh = 2.5
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
				arg_239_0:Play410161059(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1.var_.moveOldPos1061 = arg_239_1.actors_["1061"].transform.localPosition
				arg_239_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_239_1:CheckSpriteTmpPos("1061", 2)

				for iter_242_0 = 0, arg_239_1.actors_["1061"].transform.childCount - 1 do
					local var_242_0 = arg_239_1.actors_["1061"].transform:GetChild(iter_242_0)

					if var_242_0.name == "split_5" or not string.find(var_242_0.name, "split") then
						var_242_0.gameObject:SetActive(true)
					else
						var_242_0.gameObject:SetActive(false)
					end
				end
			end

			local var_242_1 = 0.001

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_1 then
				arg_239_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_239_1.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (arg_239_1.time_ - 0) / var_242_1)
			end

			if arg_239_1.time_ >= 0 + var_242_1 and arg_239_1.time_ < 0 + var_242_1 + arg_242_0 then
				arg_239_1.actors_["1061"].transform.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_242_2 = arg_239_1.actors_["1061"]

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 and not isNil(var_242_2) and arg_239_1.var_.actorSpriteComps1061 == nil then
				arg_239_1.var_.actorSpriteComps1061 = var_242_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_242_3 = 0.034

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_3 and not isNil(var_242_2) then
				if arg_239_1.var_.actorSpriteComps1061 then
					for iter_242_1, iter_242_2 in pairs(arg_239_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_242_2 then
							if arg_239_1.isInRecall_ then
								iter_242_2.color = Color.New(Mathf.Lerp(iter_242_2.color.r, arg_239_1.hightColor1.r, (arg_239_1.time_ - 0) / var_242_3), Mathf.Lerp(iter_242_2.color.g, arg_239_1.hightColor1.g, (arg_239_1.time_ - 0) / var_242_3), (Mathf.Lerp(iter_242_2.color.b, arg_239_1.hightColor1.b, (arg_239_1.time_ - 0) / var_242_3)))
							else
								local var_242_4 = Mathf.Lerp(iter_242_2.color.r, 1, (arg_239_1.time_ - 0) / var_242_3)

								iter_242_2.color = Color.New(var_242_4, var_242_4, var_242_4)
							end
						end
					end
				end
			end

			if arg_239_1.time_ >= 0 + var_242_3 and arg_239_1.time_ < 0 + var_242_3 + arg_242_0 and not isNil(var_242_2) and arg_239_1.var_.actorSpriteComps1061 then
				for iter_242_3, iter_242_4 in pairs(arg_239_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_242_4 then
						iter_242_4.color = arg_239_1.isInRecall_ and (arg_239_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_239_1.var_.actorSpriteComps1061 = nil
			end

			local var_242_5 = arg_239_1.actors_["10059"]

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 and not isNil(var_242_5) and arg_239_1.var_.actorSpriteComps10059 == nil then
				arg_239_1.var_.actorSpriteComps10059 = var_242_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_242_6 = 0.034

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_6 and not isNil(var_242_5) then
				if arg_239_1.var_.actorSpriteComps10059 then
					for iter_242_5, iter_242_6 in pairs(arg_239_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_242_6 then
							if arg_239_1.isInRecall_ then
								iter_242_6.color = Color.New(Mathf.Lerp(iter_242_6.color.r, arg_239_1.hightColor2.r, (arg_239_1.time_ - 0) / var_242_6), Mathf.Lerp(iter_242_6.color.g, arg_239_1.hightColor2.g, (arg_239_1.time_ - 0) / var_242_6), (Mathf.Lerp(iter_242_6.color.b, arg_239_1.hightColor2.b, (arg_239_1.time_ - 0) / var_242_6)))
							else
								local var_242_7 = Mathf.Lerp(iter_242_6.color.r, 0.5, (arg_239_1.time_ - 0) / var_242_6)

								iter_242_6.color = Color.New(var_242_7, var_242_7, var_242_7)
							end
						end
					end
				end
			end

			if arg_239_1.time_ >= 0 + var_242_6 and arg_239_1.time_ < 0 + var_242_6 + arg_242_0 and not isNil(var_242_5) and arg_239_1.var_.actorSpriteComps10059 then
				for iter_242_7, iter_242_8 in pairs(arg_239_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_242_8 then
						iter_242_8.color = arg_239_1.isInRecall_ and (arg_239_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_239_1.var_.actorSpriteComps10059 = nil
			end

			local var_242_8 = 0
			local var_242_9 = 0.3

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_8 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				arg_239_1.leftNameTxt_.text = arg_239_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_10 = arg_239_1:GetWordFromCfg(410161058)
				local var_242_11 = arg_239_1:FormatText(var_242_10.content)

				arg_239_1.text_.text = var_242_11

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_13 = 12 <= 0 and var_242_9 or var_242_9 * (utf8.len(var_242_11) / 12)

				if (12 <= 0 and var_242_9 or var_242_9 * (utf8.len(var_242_11) / 12)) > 0 and var_242_9 < var_242_13 then
					arg_239_1.talkMaxDuration = var_242_13

					if var_242_13 + var_242_8 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_13 + var_242_8
					end
				end

				arg_239_1.text_.text = var_242_11
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161058", "story_v_out_410161.awb") ~= 0 then
					local var_242_14 = manager.audio:GetVoiceLength("story_v_out_410161", "410161058", "story_v_out_410161.awb") / 1000

					if var_242_14 + var_242_8 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_14 + var_242_8
					end

					if var_242_10.prefab_name ~= "" and arg_239_1.actors_[var_242_10.prefab_name] ~= nil then
						local var_242_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_10.prefab_name].transform, "story_v_out_410161", "410161058", "story_v_out_410161.awb")

						arg_239_1:RecordAudio("410161058", var_242_15)
						arg_239_1:RecordAudio("410161058", var_242_15)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_410161", "410161058", "story_v_out_410161.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_410161", "410161058", "story_v_out_410161.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_16 = math.max(var_242_9, arg_239_1.talkMaxDuration)

			if var_242_8 <= arg_239_1.time_ and arg_239_1.time_ < var_242_8 + var_242_16 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_8) / var_242_16

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_8 + var_242_16 and arg_239_1.time_ < var_242_8 + var_242_16 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_239_1:InitPlayNodeList()
	end,
	Play410161059 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 410161059
		arg_243_1.duration_ = 2.97

		local var_243_0 = {
			ja = 2.933,
			CriLanguages = 2.966,
			zh = 2.966
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
				arg_243_0:Play410161060(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1.var_.moveOldPos10059 = arg_243_1.actors_["10059"].transform.localPosition
				arg_243_1.actors_["10059"].transform.localScale = Vector3.New(1, 1, 1)

				arg_243_1:CheckSpriteTmpPos("10059", 4)

				for iter_246_0 = 0, arg_243_1.actors_["10059"].transform.childCount - 1 do
					local var_246_0 = arg_243_1.actors_["10059"].transform:GetChild(iter_246_0)

					if var_246_0.name == "" or not string.find(var_246_0.name, "split") then
						var_246_0.gameObject:SetActive(true)
					else
						var_246_0.gameObject:SetActive(false)
					end
				end
			end

			local var_246_1 = 0.001

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_1 then
				arg_243_1.actors_["10059"].transform.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos10059, Vector3.New(390, -530, 35), (arg_243_1.time_ - 0) / var_246_1)
			end

			if arg_243_1.time_ >= 0 + var_246_1 and arg_243_1.time_ < 0 + var_246_1 + arg_246_0 then
				arg_243_1.actors_["10059"].transform.localPosition = Vector3.New(390, -530, 35)
			end

			local var_246_2 = arg_243_1.actors_["10059"]

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 and not isNil(var_246_2) and arg_243_1.var_.actorSpriteComps10059 == nil then
				arg_243_1.var_.actorSpriteComps10059 = var_246_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_246_3 = 0.034

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_3 and not isNil(var_246_2) then
				if arg_243_1.var_.actorSpriteComps10059 then
					for iter_246_1, iter_246_2 in pairs(arg_243_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_246_2 then
							if arg_243_1.isInRecall_ then
								iter_246_2.color = Color.New(Mathf.Lerp(iter_246_2.color.r, arg_243_1.hightColor1.r, (arg_243_1.time_ - 0) / var_246_3), Mathf.Lerp(iter_246_2.color.g, arg_243_1.hightColor1.g, (arg_243_1.time_ - 0) / var_246_3), (Mathf.Lerp(iter_246_2.color.b, arg_243_1.hightColor1.b, (arg_243_1.time_ - 0) / var_246_3)))
							else
								local var_246_4 = Mathf.Lerp(iter_246_2.color.r, 1, (arg_243_1.time_ - 0) / var_246_3)

								iter_246_2.color = Color.New(var_246_4, var_246_4, var_246_4)
							end
						end
					end
				end
			end

			if arg_243_1.time_ >= 0 + var_246_3 and arg_243_1.time_ < 0 + var_246_3 + arg_246_0 and not isNil(var_246_2) and arg_243_1.var_.actorSpriteComps10059 then
				for iter_246_3, iter_246_4 in pairs(arg_243_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_246_4 then
						iter_246_4.color = arg_243_1.isInRecall_ and (arg_243_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_243_1.var_.actorSpriteComps10059 = nil
			end

			local var_246_5 = arg_243_1.actors_["1061"]

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 and not isNil(var_246_5) and arg_243_1.var_.actorSpriteComps1061 == nil then
				arg_243_1.var_.actorSpriteComps1061 = var_246_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_246_6 = 0.034

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_6 and not isNil(var_246_5) then
				if arg_243_1.var_.actorSpriteComps1061 then
					for iter_246_5, iter_246_6 in pairs(arg_243_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_246_6 then
							if arg_243_1.isInRecall_ then
								iter_246_6.color = Color.New(Mathf.Lerp(iter_246_6.color.r, arg_243_1.hightColor2.r, (arg_243_1.time_ - 0) / var_246_6), Mathf.Lerp(iter_246_6.color.g, arg_243_1.hightColor2.g, (arg_243_1.time_ - 0) / var_246_6), (Mathf.Lerp(iter_246_6.color.b, arg_243_1.hightColor2.b, (arg_243_1.time_ - 0) / var_246_6)))
							else
								local var_246_7 = Mathf.Lerp(iter_246_6.color.r, 0.5, (arg_243_1.time_ - 0) / var_246_6)

								iter_246_6.color = Color.New(var_246_7, var_246_7, var_246_7)
							end
						end
					end
				end
			end

			if arg_243_1.time_ >= 0 + var_246_6 and arg_243_1.time_ < 0 + var_246_6 + arg_246_0 and not isNil(var_246_5) and arg_243_1.var_.actorSpriteComps1061 then
				for iter_246_7, iter_246_8 in pairs(arg_243_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_246_8 then
						iter_246_8.color = arg_243_1.isInRecall_ and (arg_243_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_243_1.var_.actorSpriteComps1061 = nil
			end

			local var_246_8 = 0
			local var_246_9 = 0.25

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_8 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				arg_243_1.leftNameTxt_.text = arg_243_1:FormatText(StoryNameCfg[596].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_10 = arg_243_1:GetWordFromCfg(410161059)
				local var_246_11 = arg_243_1:FormatText(var_246_10.content)

				arg_243_1.text_.text = var_246_11

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_13 = 10 <= 0 and var_246_9 or var_246_9 * (utf8.len(var_246_11) / 10)

				if (10 <= 0 and var_246_9 or var_246_9 * (utf8.len(var_246_11) / 10)) > 0 and var_246_9 < var_246_13 then
					arg_243_1.talkMaxDuration = var_246_13

					if var_246_13 + var_246_8 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_13 + var_246_8
					end
				end

				arg_243_1.text_.text = var_246_11
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161059", "story_v_out_410161.awb") ~= 0 then
					local var_246_14 = manager.audio:GetVoiceLength("story_v_out_410161", "410161059", "story_v_out_410161.awb") / 1000

					if var_246_14 + var_246_8 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_14 + var_246_8
					end

					if var_246_10.prefab_name ~= "" and arg_243_1.actors_[var_246_10.prefab_name] ~= nil then
						local var_246_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_10.prefab_name].transform, "story_v_out_410161", "410161059", "story_v_out_410161.awb")

						arg_243_1:RecordAudio("410161059", var_246_15)
						arg_243_1:RecordAudio("410161059", var_246_15)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_410161", "410161059", "story_v_out_410161.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_410161", "410161059", "story_v_out_410161.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_16 = math.max(var_246_9, arg_243_1.talkMaxDuration)

			if var_246_8 <= arg_243_1.time_ and arg_243_1.time_ < var_246_8 + var_246_16 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_8) / var_246_16

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_8 + var_246_16 and arg_243_1.time_ < var_246_8 + var_246_16 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_243_1:InitPlayNodeList()
	end,
	Play410161060 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 410161060
		arg_247_1.duration_ = 9

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play410161061(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			if arg_247_1.bgs_.ST62 == nil then
				local var_250_0 = Object.Instantiate(arg_247_1.paintGo_)

				var_250_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST62")
				var_250_0.name = "ST62"
				var_250_0.transform.parent = arg_247_1.stage_.transform
				var_250_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_247_1.bgs_.ST62 = var_250_0
			end

			if 2 < arg_247_1.time_ and arg_247_1.time_ <= 2 + arg_250_0 then
				local var_250_1 = arg_247_1.bgs_.ST62

				arg_247_1.bgs_.ST62.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_250_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_250_2 = var_250_1:GetComponent("SpriteRenderer")

				if var_250_2 and var_250_2.sprite then
					local var_250_3 = 2 * (var_250_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_250_1.transform.localScale = Vector3.New(var_250_3 / var_250_2.sprite.bounds.size.y < var_250_3 * manager.ui.mainCameraCom_.aspect / var_250_2.sprite.bounds.size.x and var_250_3 * manager.ui.mainCameraCom_.aspect / var_250_2.sprite.bounds.size.x or var_250_3 / var_250_2.sprite.bounds.size.y, var_250_3 / var_250_2.sprite.bounds.size.y < var_250_3 * manager.ui.mainCameraCom_.aspect / var_250_2.sprite.bounds.size.x and var_250_3 * manager.ui.mainCameraCom_.aspect / var_250_2.sprite.bounds.size.x or var_250_3 / var_250_2.sprite.bounds.size.y, 0)
				end

				for iter_250_0, iter_250_1 in pairs(arg_247_1.bgs_) do
					if iter_250_0 ~= "ST62" then
						iter_250_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_250_4 = 0

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_4 + arg_250_0 then
				arg_247_1.mask_.enabled = true
				arg_247_1.mask_.raycastTarget = true

				arg_247_1:SetGaussion(false)
			end

			local var_250_5 = 2

			if var_250_4 <= arg_247_1.time_ and arg_247_1.time_ < var_250_4 + var_250_5 then
				local var_250_6 = Color.New(0, 0, 0)

				var_250_6.a = Mathf.Lerp(0, 1, (arg_247_1.time_ - var_250_4) / var_250_5)
				arg_247_1.mask_.color = var_250_6
			end

			if arg_247_1.time_ >= var_250_4 + var_250_5 and arg_247_1.time_ < var_250_4 + var_250_5 + arg_250_0 then
				local var_250_7 = Color.New(0, 0, 0)

				var_250_7.a = 1
				arg_247_1.mask_.color = var_250_7
			end

			local var_250_8 = 2

			if 2 < arg_247_1.time_ and arg_247_1.time_ <= var_250_8 + arg_250_0 then
				arg_247_1.mask_.enabled = true
				arg_247_1.mask_.raycastTarget = true

				arg_247_1:SetGaussion(false)
			end

			local var_250_9 = 2

			if var_250_8 <= arg_247_1.time_ and arg_247_1.time_ < var_250_8 + var_250_9 then
				local var_250_10 = Color.New(0, 0, 0)

				var_250_10.a = Mathf.Lerp(1, 0, (arg_247_1.time_ - var_250_8) / var_250_9)
				arg_247_1.mask_.color = var_250_10
			end

			if arg_247_1.time_ >= var_250_8 + var_250_9 and arg_247_1.time_ < var_250_8 + var_250_9 + arg_250_0 then
				local var_250_11 = Color.New(0, 0, 0)

				arg_247_1.mask_.enabled = false
				var_250_11.a = 0
				arg_247_1.mask_.color = var_250_11
			end

			local var_250_12 = arg_247_1.actors_["10059"].transform

			if 2 < arg_247_1.time_ and arg_247_1.time_ <= 2 + arg_250_0 then
				arg_247_1.var_.moveOldPos10059 = var_250_12.localPosition
				var_250_12.localScale = Vector3.New(1, 1, 1)

				arg_247_1:CheckSpriteTmpPos("10059", 7)

				for iter_250_2 = 0, var_250_12.childCount - 1 do
					local var_250_13 = var_250_12:GetChild(iter_250_2)

					if var_250_13.name == "" or not string.find(var_250_13.name, "split") then
						var_250_13.gameObject:SetActive(true)
					else
						var_250_13.gameObject:SetActive(false)
					end
				end
			end

			local var_250_14 = 0.001

			if 2 <= arg_247_1.time_ and arg_247_1.time_ < 2 + var_250_14 then
				var_250_12.localPosition = Vector3.Lerp(arg_247_1.var_.moveOldPos10059, Vector3.New(0, -2000, 35), (arg_247_1.time_ - 2) / var_250_14)
			end

			if arg_247_1.time_ >= 2 + var_250_14 and arg_247_1.time_ < 2 + var_250_14 + arg_250_0 then
				var_250_12.localPosition = Vector3.New(0, -2000, 35)
			end

			local var_250_15 = arg_247_1.actors_["1061"].transform

			if 2 < arg_247_1.time_ and arg_247_1.time_ <= 2 + arg_250_0 then
				arg_247_1.var_.moveOldPos1061 = var_250_15.localPosition
				var_250_15.localScale = Vector3.New(1, 1, 1)

				arg_247_1:CheckSpriteTmpPos("1061", 7)

				for iter_250_3 = 0, var_250_15.childCount - 1 do
					local var_250_16 = var_250_15:GetChild(iter_250_3)

					if var_250_16.name == "" or not string.find(var_250_16.name, "split") then
						var_250_16.gameObject:SetActive(true)
					else
						var_250_16.gameObject:SetActive(false)
					end
				end
			end

			local var_250_17 = 0.001

			if 2 <= arg_247_1.time_ and arg_247_1.time_ < 2 + var_250_17 then
				var_250_15.localPosition = Vector3.Lerp(arg_247_1.var_.moveOldPos1061, Vector3.New(0, -2000, 18), (arg_247_1.time_ - 2) / var_250_17)
			end

			if arg_247_1.time_ >= 2 + var_250_17 and arg_247_1.time_ < 2 + var_250_17 + arg_250_0 then
				var_250_15.localPosition = Vector3.New(0, -2000, 18)
			end

			local var_250_18 = arg_247_1.actors_["10059"]

			if 2 < arg_247_1.time_ and arg_247_1.time_ <= 2 + arg_250_0 and not isNil(var_250_18) and arg_247_1.var_.actorSpriteComps10059 == nil then
				arg_247_1.var_.actorSpriteComps10059 = var_250_18:GetComponentsInChildren(typeof(Image), true)
			end

			local var_250_19 = 0.034

			if 2 <= arg_247_1.time_ and arg_247_1.time_ < 2 + var_250_19 and not isNil(var_250_18) then
				if arg_247_1.var_.actorSpriteComps10059 then
					for iter_250_4, iter_250_5 in pairs(arg_247_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_250_5 then
							if arg_247_1.isInRecall_ then
								iter_250_5.color = Color.New(Mathf.Lerp(iter_250_5.color.r, arg_247_1.hightColor2.r, (arg_247_1.time_ - 2) / var_250_19), Mathf.Lerp(iter_250_5.color.g, arg_247_1.hightColor2.g, (arg_247_1.time_ - 2) / var_250_19), (Mathf.Lerp(iter_250_5.color.b, arg_247_1.hightColor2.b, (arg_247_1.time_ - 2) / var_250_19)))
							else
								local var_250_20 = Mathf.Lerp(iter_250_5.color.r, 0.5, (arg_247_1.time_ - 2) / var_250_19)

								iter_250_5.color = Color.New(var_250_20, var_250_20, var_250_20)
							end
						end
					end
				end
			end

			if arg_247_1.time_ >= 2 + var_250_19 and arg_247_1.time_ < 2 + var_250_19 + arg_250_0 and not isNil(var_250_18) and arg_247_1.var_.actorSpriteComps10059 then
				for iter_250_6, iter_250_7 in pairs(arg_247_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_250_7 then
						iter_250_7.color = arg_247_1.isInRecall_ and (arg_247_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_247_1.var_.actorSpriteComps10059 = nil
			end

			local var_250_21 = arg_247_1.actors_["1061"]

			if 2.00066666666667 < arg_247_1.time_ and arg_247_1.time_ <= 2.00066666666667 + arg_250_0 and not isNil(var_250_21) and arg_247_1.var_.actorSpriteComps1061 == nil then
				arg_247_1.var_.actorSpriteComps1061 = var_250_21:GetComponentsInChildren(typeof(Image), true)
			end

			local var_250_22 = 0.0333333333333332

			if 2.00066666666667 <= arg_247_1.time_ and arg_247_1.time_ < 2.00066666666667 + var_250_22 and not isNil(var_250_21) then
				if arg_247_1.var_.actorSpriteComps1061 then
					for iter_250_8, iter_250_9 in pairs(arg_247_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_250_9 then
							if arg_247_1.isInRecall_ then
								iter_250_9.color = Color.New(Mathf.Lerp(iter_250_9.color.r, arg_247_1.hightColor2.r, (arg_247_1.time_ - 2.00066666666667) / var_250_22), Mathf.Lerp(iter_250_9.color.g, arg_247_1.hightColor2.g, (arg_247_1.time_ - 2.00066666666667) / var_250_22), (Mathf.Lerp(iter_250_9.color.b, arg_247_1.hightColor2.b, (arg_247_1.time_ - 2.00066666666667) / var_250_22)))
							else
								local var_250_23 = Mathf.Lerp(iter_250_9.color.r, 0.5, (arg_247_1.time_ - 2.00066666666667) / var_250_22)

								iter_250_9.color = Color.New(var_250_23, var_250_23, var_250_23)
							end
						end
					end
				end
			end

			if arg_247_1.time_ >= 2.00066666666667 + var_250_22 and arg_247_1.time_ < 2.00066666666667 + var_250_22 + arg_250_0 and not isNil(var_250_21) and arg_247_1.var_.actorSpriteComps1061 then
				for iter_250_10, iter_250_11 in pairs(arg_247_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_250_11 then
						iter_250_11.color = arg_247_1.isInRecall_ and (arg_247_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_247_1.var_.actorSpriteComps1061 = nil
			end

			if arg_247_1.frameCnt_ <= 1 then
				arg_247_1.dialog_:SetActive(false)
			end

			local var_250_24 = 4
			local var_250_25 = 1.125

			if 4 < arg_247_1.time_ and arg_247_1.time_ <= var_250_24 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0

				arg_247_1.dialog_:SetActive(true)

				arg_247_1.dialogCg_.alpha = 0

				local var_250_26 = LeanTween.value(arg_247_1.dialog_, 0, 1, 0.3)

				var_250_26:setOnUpdate(LuaHelper.FloatAction(function(arg_251_0)
					arg_247_1.dialogCg_.alpha = arg_251_0
				end))
				var_250_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_247_1.dialog_)
					var_250_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_247_1.duration_ = arg_247_1.duration_ + 0.3

				SetActive(arg_247_1.leftNameGo_, false)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_27 = arg_247_1:FormatText(arg_247_1:GetWordFromCfg(410161060).content)

				arg_247_1.text_.text = var_250_27

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_29 = 45 <= 0 and var_250_25 or var_250_25 * (utf8.len(var_250_27) / 45)

				if (45 <= 0 and var_250_25 or var_250_25 * (utf8.len(var_250_27) / 45)) > 0 and var_250_25 < var_250_29 then
					arg_247_1.talkMaxDuration = var_250_29
					var_250_24 = var_250_24 + 0.3

					if var_250_29 + var_250_24 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_29 + var_250_24
					end
				end

				arg_247_1.text_.text = var_250_27
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)
				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_30 = var_250_24 + 0.3
			local var_250_31 = math.max(var_250_25, arg_247_1.talkMaxDuration)

			if var_250_24 + 0.3 <= arg_247_1.time_ and arg_247_1.time_ < var_250_30 + var_250_31 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_30) / var_250_31

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_30 + var_250_31 and arg_247_1.time_ < var_250_30 + var_250_31 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_247_1:InitPlayNodeList()
	end,
	Play410161061 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 410161061
		arg_253_1.duration_ = 5

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play410161062(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = 0.6

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, false)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_1 = arg_253_1:FormatText(arg_253_1:GetWordFromCfg(410161061).content)

				arg_253_1.text_.text = var_256_1

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_3 = 24 <= 0 and var_256_0 or var_256_0 * (utf8.len(var_256_1) / 24)

				if (24 <= 0 and var_256_0 or var_256_0 * (utf8.len(var_256_1) / 24)) > 0 and var_256_0 < var_256_3 then
					arg_253_1.talkMaxDuration = var_256_3

					if var_256_3 + 0 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_3 + 0
					end
				end

				arg_253_1.text_.text = var_256_1
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)
				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_4 = math.max(var_256_0, arg_253_1.talkMaxDuration)

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_4 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - 0) / var_256_4

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= 0 + var_256_4 and arg_253_1.time_ < 0 + var_256_4 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play410161062 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 410161062
		arg_257_1.duration_ = 5.4

		local var_257_0 = {
			ja = 5.4,
			CriLanguages = 2.166,
			zh = 2.166
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
				arg_257_0:Play410161063(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1.var_.moveOldPos1061 = arg_257_1.actors_["1061"].transform.localPosition
				arg_257_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_257_1:CheckSpriteTmpPos("1061", 2)

				for iter_260_0 = 0, arg_257_1.actors_["1061"].transform.childCount - 1 do
					local var_260_0 = arg_257_1.actors_["1061"].transform:GetChild(iter_260_0)

					if var_260_0.name == "" or not string.find(var_260_0.name, "split") then
						var_260_0.gameObject:SetActive(true)
					else
						var_260_0.gameObject:SetActive(false)
					end
				end
			end

			local var_260_1 = 0.001

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_1 then
				arg_257_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (arg_257_1.time_ - 0) / var_260_1)
			end

			if arg_257_1.time_ >= 0 + var_260_1 and arg_257_1.time_ < 0 + var_260_1 + arg_260_0 then
				arg_257_1.actors_["1061"].transform.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_260_2 = arg_257_1.actors_["10059"].transform

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1.var_.moveOldPos10059 = var_260_2.localPosition
				var_260_2.localScale = Vector3.New(1, 1, 1)

				arg_257_1:CheckSpriteTmpPos("10059", 4)

				for iter_260_1 = 0, var_260_2.childCount - 1 do
					local var_260_3 = var_260_2:GetChild(iter_260_1)

					if var_260_3.name == "" or not string.find(var_260_3.name, "split") then
						var_260_3.gameObject:SetActive(true)
					else
						var_260_3.gameObject:SetActive(false)
					end
				end
			end

			local var_260_4 = 0.001

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_4 then
				var_260_2.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos10059, Vector3.New(390, -530, 35), (arg_257_1.time_ - 0) / var_260_4)
			end

			if arg_257_1.time_ >= 0 + var_260_4 and arg_257_1.time_ < 0 + var_260_4 + arg_260_0 then
				var_260_2.localPosition = Vector3.New(390, -530, 35)
			end

			local var_260_5 = arg_257_1.actors_["1061"]

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 and not isNil(var_260_5) and arg_257_1.var_.actorSpriteComps1061 == nil then
				arg_257_1.var_.actorSpriteComps1061 = var_260_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_260_6 = 0.034

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_6 and not isNil(var_260_5) then
				if arg_257_1.var_.actorSpriteComps1061 then
					for iter_260_2, iter_260_3 in pairs(arg_257_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_260_3 then
							if arg_257_1.isInRecall_ then
								iter_260_3.color = Color.New(Mathf.Lerp(iter_260_3.color.r, arg_257_1.hightColor1.r, (arg_257_1.time_ - 0) / var_260_6), Mathf.Lerp(iter_260_3.color.g, arg_257_1.hightColor1.g, (arg_257_1.time_ - 0) / var_260_6), (Mathf.Lerp(iter_260_3.color.b, arg_257_1.hightColor1.b, (arg_257_1.time_ - 0) / var_260_6)))
							else
								local var_260_7 = Mathf.Lerp(iter_260_3.color.r, 1, (arg_257_1.time_ - 0) / var_260_6)

								iter_260_3.color = Color.New(var_260_7, var_260_7, var_260_7)
							end
						end
					end
				end
			end

			if arg_257_1.time_ >= 0 + var_260_6 and arg_257_1.time_ < 0 + var_260_6 + arg_260_0 and not isNil(var_260_5) and arg_257_1.var_.actorSpriteComps1061 then
				for iter_260_4, iter_260_5 in pairs(arg_257_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_260_5 then
						iter_260_5.color = arg_257_1.isInRecall_ and (arg_257_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_257_1.var_.actorSpriteComps1061 = nil
			end

			local var_260_8 = arg_257_1.actors_["10059"]

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 and not isNil(var_260_8) and arg_257_1.var_.actorSpriteComps10059 == nil then
				arg_257_1.var_.actorSpriteComps10059 = var_260_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_260_9 = 0.034

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_9 and not isNil(var_260_8) then
				if arg_257_1.var_.actorSpriteComps10059 then
					for iter_260_6, iter_260_7 in pairs(arg_257_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_260_7 then
							if arg_257_1.isInRecall_ then
								iter_260_7.color = Color.New(Mathf.Lerp(iter_260_7.color.r, arg_257_1.hightColor2.r, (arg_257_1.time_ - 0) / var_260_9), Mathf.Lerp(iter_260_7.color.g, arg_257_1.hightColor2.g, (arg_257_1.time_ - 0) / var_260_9), (Mathf.Lerp(iter_260_7.color.b, arg_257_1.hightColor2.b, (arg_257_1.time_ - 0) / var_260_9)))
							else
								local var_260_10 = Mathf.Lerp(iter_260_7.color.r, 0.5, (arg_257_1.time_ - 0) / var_260_9)

								iter_260_7.color = Color.New(var_260_10, var_260_10, var_260_10)
							end
						end
					end
				end
			end

			if arg_257_1.time_ >= 0 + var_260_9 and arg_257_1.time_ < 0 + var_260_9 + arg_260_0 and not isNil(var_260_8) and arg_257_1.var_.actorSpriteComps10059 then
				for iter_260_8, iter_260_9 in pairs(arg_257_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_260_9 then
						iter_260_9.color = arg_257_1.isInRecall_ and (arg_257_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_257_1.var_.actorSpriteComps10059 = nil
			end

			local var_260_11 = 0
			local var_260_12 = 0.275

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_11 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				arg_257_1.leftNameTxt_.text = arg_257_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_13 = arg_257_1:GetWordFromCfg(410161062)
				local var_260_14 = arg_257_1:FormatText(var_260_13.content)

				arg_257_1.text_.text = var_260_14

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_16 = 11 <= 0 and var_260_12 or var_260_12 * (utf8.len(var_260_14) / 11)

				if (11 <= 0 and var_260_12 or var_260_12 * (utf8.len(var_260_14) / 11)) > 0 and var_260_12 < var_260_16 then
					arg_257_1.talkMaxDuration = var_260_16

					if var_260_16 + var_260_11 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_16 + var_260_11
					end
				end

				arg_257_1.text_.text = var_260_14
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161062", "story_v_out_410161.awb") ~= 0 then
					local var_260_17 = manager.audio:GetVoiceLength("story_v_out_410161", "410161062", "story_v_out_410161.awb") / 1000

					if var_260_17 + var_260_11 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_17 + var_260_11
					end

					if var_260_13.prefab_name ~= "" and arg_257_1.actors_[var_260_13.prefab_name] ~= nil then
						local var_260_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_13.prefab_name].transform, "story_v_out_410161", "410161062", "story_v_out_410161.awb")

						arg_257_1:RecordAudio("410161062", var_260_18)
						arg_257_1:RecordAudio("410161062", var_260_18)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_410161", "410161062", "story_v_out_410161.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_410161", "410161062", "story_v_out_410161.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_19 = math.max(var_260_12, arg_257_1.talkMaxDuration)

			if var_260_11 <= arg_257_1.time_ and arg_257_1.time_ < var_260_11 + var_260_19 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_11) / var_260_19

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_11 + var_260_19 and arg_257_1.time_ < var_260_11 + var_260_19 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_257_1:InitPlayNodeList()
	end,
	Play410161063 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 410161063
		arg_261_1.duration_ = 1.7

		local var_261_0 = {
			ja = 1.7,
			CriLanguages = 1.466,
			zh = 1.466
		}
		local var_261_1 = manager.audio:GetLocalizationFlag()

		if var_261_0[var_261_1] ~= nil then
			arg_261_1.duration_ = var_261_0[var_261_1]
		end

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play410161064(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1.var_.moveOldPos10059 = arg_261_1.actors_["10059"].transform.localPosition
				arg_261_1.actors_["10059"].transform.localScale = Vector3.New(1, 1, 1)

				arg_261_1:CheckSpriteTmpPos("10059", 4)

				for iter_264_0 = 0, arg_261_1.actors_["10059"].transform.childCount - 1 do
					local var_264_0 = arg_261_1.actors_["10059"].transform:GetChild(iter_264_0)

					if var_264_0.name == "split_2" or not string.find(var_264_0.name, "split") then
						var_264_0.gameObject:SetActive(true)
					else
						var_264_0.gameObject:SetActive(false)
					end
				end
			end

			local var_264_1 = 0.001

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_1 then
				arg_261_1.actors_["10059"].transform.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos10059, Vector3.New(390, -530, 35), (arg_261_1.time_ - 0) / var_264_1)
			end

			if arg_261_1.time_ >= 0 + var_264_1 and arg_261_1.time_ < 0 + var_264_1 + arg_264_0 then
				arg_261_1.actors_["10059"].transform.localPosition = Vector3.New(390, -530, 35)
			end

			local var_264_2 = arg_261_1.actors_["10059"]

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 and not isNil(var_264_2) and arg_261_1.var_.actorSpriteComps10059 == nil then
				arg_261_1.var_.actorSpriteComps10059 = var_264_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_264_3 = 0.034

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_3 and not isNil(var_264_2) then
				if arg_261_1.var_.actorSpriteComps10059 then
					for iter_264_1, iter_264_2 in pairs(arg_261_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_264_2 then
							if arg_261_1.isInRecall_ then
								iter_264_2.color = Color.New(Mathf.Lerp(iter_264_2.color.r, arg_261_1.hightColor1.r, (arg_261_1.time_ - 0) / var_264_3), Mathf.Lerp(iter_264_2.color.g, arg_261_1.hightColor1.g, (arg_261_1.time_ - 0) / var_264_3), (Mathf.Lerp(iter_264_2.color.b, arg_261_1.hightColor1.b, (arg_261_1.time_ - 0) / var_264_3)))
							else
								local var_264_4 = Mathf.Lerp(iter_264_2.color.r, 1, (arg_261_1.time_ - 0) / var_264_3)

								iter_264_2.color = Color.New(var_264_4, var_264_4, var_264_4)
							end
						end
					end
				end
			end

			if arg_261_1.time_ >= 0 + var_264_3 and arg_261_1.time_ < 0 + var_264_3 + arg_264_0 and not isNil(var_264_2) and arg_261_1.var_.actorSpriteComps10059 then
				for iter_264_3, iter_264_4 in pairs(arg_261_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_264_4 then
						iter_264_4.color = arg_261_1.isInRecall_ and (arg_261_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_261_1.var_.actorSpriteComps10059 = nil
			end

			local var_264_5 = arg_261_1.actors_["1061"]

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 and not isNil(var_264_5) and arg_261_1.var_.actorSpriteComps1061 == nil then
				arg_261_1.var_.actorSpriteComps1061 = var_264_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_264_6 = 0.034

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_6 and not isNil(var_264_5) then
				if arg_261_1.var_.actorSpriteComps1061 then
					for iter_264_5, iter_264_6 in pairs(arg_261_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_264_6 then
							if arg_261_1.isInRecall_ then
								iter_264_6.color = Color.New(Mathf.Lerp(iter_264_6.color.r, arg_261_1.hightColor2.r, (arg_261_1.time_ - 0) / var_264_6), Mathf.Lerp(iter_264_6.color.g, arg_261_1.hightColor2.g, (arg_261_1.time_ - 0) / var_264_6), (Mathf.Lerp(iter_264_6.color.b, arg_261_1.hightColor2.b, (arg_261_1.time_ - 0) / var_264_6)))
							else
								local var_264_7 = Mathf.Lerp(iter_264_6.color.r, 0.5, (arg_261_1.time_ - 0) / var_264_6)

								iter_264_6.color = Color.New(var_264_7, var_264_7, var_264_7)
							end
						end
					end
				end
			end

			if arg_261_1.time_ >= 0 + var_264_6 and arg_261_1.time_ < 0 + var_264_6 + arg_264_0 and not isNil(var_264_5) and arg_261_1.var_.actorSpriteComps1061 then
				for iter_264_7, iter_264_8 in pairs(arg_261_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_264_8 then
						iter_264_8.color = arg_261_1.isInRecall_ and (arg_261_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_261_1.var_.actorSpriteComps1061 = nil
			end

			local var_264_8 = 0
			local var_264_9 = 0.125

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_8 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				arg_261_1.leftNameTxt_.text = arg_261_1:FormatText(StoryNameCfg[596].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_10 = arg_261_1:GetWordFromCfg(410161063)
				local var_264_11 = arg_261_1:FormatText(var_264_10.content)

				arg_261_1.text_.text = var_264_11

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_13 = 5 <= 0 and var_264_9 or var_264_9 * (utf8.len(var_264_11) / 5)

				if (5 <= 0 and var_264_9 or var_264_9 * (utf8.len(var_264_11) / 5)) > 0 and var_264_9 < var_264_13 then
					arg_261_1.talkMaxDuration = var_264_13

					if var_264_13 + var_264_8 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_13 + var_264_8
					end
				end

				arg_261_1.text_.text = var_264_11
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161063", "story_v_out_410161.awb") ~= 0 then
					local var_264_14 = manager.audio:GetVoiceLength("story_v_out_410161", "410161063", "story_v_out_410161.awb") / 1000

					if var_264_14 + var_264_8 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_14 + var_264_8
					end

					if var_264_10.prefab_name ~= "" and arg_261_1.actors_[var_264_10.prefab_name] ~= nil then
						local var_264_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_10.prefab_name].transform, "story_v_out_410161", "410161063", "story_v_out_410161.awb")

						arg_261_1:RecordAudio("410161063", var_264_15)
						arg_261_1:RecordAudio("410161063", var_264_15)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_410161", "410161063", "story_v_out_410161.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_410161", "410161063", "story_v_out_410161.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_16 = math.max(var_264_9, arg_261_1.talkMaxDuration)

			if var_264_8 <= arg_261_1.time_ and arg_261_1.time_ < var_264_8 + var_264_16 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_8) / var_264_16

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_8 + var_264_16 and arg_261_1.time_ < var_264_8 + var_264_16 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_261_1:InitPlayNodeList()
	end,
	Play410161064 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 410161064
		arg_265_1.duration_ = 13.1

		local var_265_0 = {
			ja = 13.1,
			CriLanguages = 4.166,
			zh = 4.166
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
				arg_265_0:Play410161065(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1.var_.moveOldPos1061 = arg_265_1.actors_["1061"].transform.localPosition
				arg_265_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_265_1:CheckSpriteTmpPos("1061", 2)

				for iter_268_0 = 0, arg_265_1.actors_["1061"].transform.childCount - 1 do
					local var_268_0 = arg_265_1.actors_["1061"].transform:GetChild(iter_268_0)

					if var_268_0.name == "" or not string.find(var_268_0.name, "split") then
						var_268_0.gameObject:SetActive(true)
					else
						var_268_0.gameObject:SetActive(false)
					end
				end
			end

			local var_268_1 = 0.001

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_1 then
				arg_265_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (arg_265_1.time_ - 0) / var_268_1)
			end

			if arg_265_1.time_ >= 0 + var_268_1 and arg_265_1.time_ < 0 + var_268_1 + arg_268_0 then
				arg_265_1.actors_["1061"].transform.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_268_2 = arg_265_1.actors_["1061"]

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 and not isNil(var_268_2) and arg_265_1.var_.actorSpriteComps1061 == nil then
				arg_265_1.var_.actorSpriteComps1061 = var_268_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_268_3 = 0.034

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_3 and not isNil(var_268_2) then
				if arg_265_1.var_.actorSpriteComps1061 then
					for iter_268_1, iter_268_2 in pairs(arg_265_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_268_2 then
							if arg_265_1.isInRecall_ then
								iter_268_2.color = Color.New(Mathf.Lerp(iter_268_2.color.r, arg_265_1.hightColor1.r, (arg_265_1.time_ - 0) / var_268_3), Mathf.Lerp(iter_268_2.color.g, arg_265_1.hightColor1.g, (arg_265_1.time_ - 0) / var_268_3), (Mathf.Lerp(iter_268_2.color.b, arg_265_1.hightColor1.b, (arg_265_1.time_ - 0) / var_268_3)))
							else
								local var_268_4 = Mathf.Lerp(iter_268_2.color.r, 1, (arg_265_1.time_ - 0) / var_268_3)

								iter_268_2.color = Color.New(var_268_4, var_268_4, var_268_4)
							end
						end
					end
				end
			end

			if arg_265_1.time_ >= 0 + var_268_3 and arg_265_1.time_ < 0 + var_268_3 + arg_268_0 and not isNil(var_268_2) and arg_265_1.var_.actorSpriteComps1061 then
				for iter_268_3, iter_268_4 in pairs(arg_265_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_268_4 then
						iter_268_4.color = arg_265_1.isInRecall_ and (arg_265_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_265_1.var_.actorSpriteComps1061 = nil
			end

			local var_268_5 = arg_265_1.actors_["10059"]

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 and not isNil(var_268_5) and arg_265_1.var_.actorSpriteComps10059 == nil then
				arg_265_1.var_.actorSpriteComps10059 = var_268_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_268_6 = 0.034

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_6 and not isNil(var_268_5) then
				if arg_265_1.var_.actorSpriteComps10059 then
					for iter_268_5, iter_268_6 in pairs(arg_265_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_268_6 then
							if arg_265_1.isInRecall_ then
								iter_268_6.color = Color.New(Mathf.Lerp(iter_268_6.color.r, arg_265_1.hightColor2.r, (arg_265_1.time_ - 0) / var_268_6), Mathf.Lerp(iter_268_6.color.g, arg_265_1.hightColor2.g, (arg_265_1.time_ - 0) / var_268_6), (Mathf.Lerp(iter_268_6.color.b, arg_265_1.hightColor2.b, (arg_265_1.time_ - 0) / var_268_6)))
							else
								local var_268_7 = Mathf.Lerp(iter_268_6.color.r, 0.5, (arg_265_1.time_ - 0) / var_268_6)

								iter_268_6.color = Color.New(var_268_7, var_268_7, var_268_7)
							end
						end
					end
				end
			end

			if arg_265_1.time_ >= 0 + var_268_6 and arg_265_1.time_ < 0 + var_268_6 + arg_268_0 and not isNil(var_268_5) and arg_265_1.var_.actorSpriteComps10059 then
				for iter_268_7, iter_268_8 in pairs(arg_265_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_268_8 then
						iter_268_8.color = arg_265_1.isInRecall_ and (arg_265_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_265_1.var_.actorSpriteComps10059 = nil
			end

			local var_268_8 = 0
			local var_268_9 = 0.525

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_8 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				arg_265_1.leftNameTxt_.text = arg_265_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_10 = arg_265_1:GetWordFromCfg(410161064)
				local var_268_11 = arg_265_1:FormatText(var_268_10.content)

				arg_265_1.text_.text = var_268_11

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_13 = 21 <= 0 and var_268_9 or var_268_9 * (utf8.len(var_268_11) / 21)

				if (21 <= 0 and var_268_9 or var_268_9 * (utf8.len(var_268_11) / 21)) > 0 and var_268_9 < var_268_13 then
					arg_265_1.talkMaxDuration = var_268_13

					if var_268_13 + var_268_8 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_13 + var_268_8
					end
				end

				arg_265_1.text_.text = var_268_11
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161064", "story_v_out_410161.awb") ~= 0 then
					local var_268_14 = manager.audio:GetVoiceLength("story_v_out_410161", "410161064", "story_v_out_410161.awb") / 1000

					if var_268_14 + var_268_8 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_14 + var_268_8
					end

					if var_268_10.prefab_name ~= "" and arg_265_1.actors_[var_268_10.prefab_name] ~= nil then
						local var_268_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_10.prefab_name].transform, "story_v_out_410161", "410161064", "story_v_out_410161.awb")

						arg_265_1:RecordAudio("410161064", var_268_15)
						arg_265_1:RecordAudio("410161064", var_268_15)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_410161", "410161064", "story_v_out_410161.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_410161", "410161064", "story_v_out_410161.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_16 = math.max(var_268_9, arg_265_1.talkMaxDuration)

			if var_268_8 <= arg_265_1.time_ and arg_265_1.time_ < var_268_8 + var_268_16 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_8) / var_268_16

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_8 + var_268_16 and arg_265_1.time_ < var_268_8 + var_268_16 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_265_1:InitPlayNodeList()
	end,
	Play410161065 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 410161065
		arg_269_1.duration_ = 2.4

		local var_269_0 = {
			ja = 2.1,
			CriLanguages = 2.4,
			zh = 2.4
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
				arg_269_0:Play410161066(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1.var_.moveOldPos10059 = arg_269_1.actors_["10059"].transform.localPosition
				arg_269_1.actors_["10059"].transform.localScale = Vector3.New(1, 1, 1)

				arg_269_1:CheckSpriteTmpPos("10059", 4)

				for iter_272_0 = 0, arg_269_1.actors_["10059"].transform.childCount - 1 do
					local var_272_0 = arg_269_1.actors_["10059"].transform:GetChild(iter_272_0)

					if var_272_0.name == "split_1" or not string.find(var_272_0.name, "split") then
						var_272_0.gameObject:SetActive(true)
					else
						var_272_0.gameObject:SetActive(false)
					end
				end
			end

			local var_272_1 = 0.001

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_1 then
				arg_269_1.actors_["10059"].transform.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos10059, Vector3.New(390, -530, 35), (arg_269_1.time_ - 0) / var_272_1)
			end

			if arg_269_1.time_ >= 0 + var_272_1 and arg_269_1.time_ < 0 + var_272_1 + arg_272_0 then
				arg_269_1.actors_["10059"].transform.localPosition = Vector3.New(390, -530, 35)
			end

			local var_272_2 = arg_269_1.actors_["10059"]

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 and not isNil(var_272_2) and arg_269_1.var_.actorSpriteComps10059 == nil then
				arg_269_1.var_.actorSpriteComps10059 = var_272_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_272_3 = 0.034

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_3 and not isNil(var_272_2) then
				if arg_269_1.var_.actorSpriteComps10059 then
					for iter_272_1, iter_272_2 in pairs(arg_269_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_272_2 then
							if arg_269_1.isInRecall_ then
								iter_272_2.color = Color.New(Mathf.Lerp(iter_272_2.color.r, arg_269_1.hightColor1.r, (arg_269_1.time_ - 0) / var_272_3), Mathf.Lerp(iter_272_2.color.g, arg_269_1.hightColor1.g, (arg_269_1.time_ - 0) / var_272_3), (Mathf.Lerp(iter_272_2.color.b, arg_269_1.hightColor1.b, (arg_269_1.time_ - 0) / var_272_3)))
							else
								local var_272_4 = Mathf.Lerp(iter_272_2.color.r, 1, (arg_269_1.time_ - 0) / var_272_3)

								iter_272_2.color = Color.New(var_272_4, var_272_4, var_272_4)
							end
						end
					end
				end
			end

			if arg_269_1.time_ >= 0 + var_272_3 and arg_269_1.time_ < 0 + var_272_3 + arg_272_0 and not isNil(var_272_2) and arg_269_1.var_.actorSpriteComps10059 then
				for iter_272_3, iter_272_4 in pairs(arg_269_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_272_4 then
						iter_272_4.color = arg_269_1.isInRecall_ and (arg_269_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_269_1.var_.actorSpriteComps10059 = nil
			end

			local var_272_5 = arg_269_1.actors_["1061"]

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 and not isNil(var_272_5) and arg_269_1.var_.actorSpriteComps1061 == nil then
				arg_269_1.var_.actorSpriteComps1061 = var_272_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_272_6 = 0.034

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_6 and not isNil(var_272_5) then
				if arg_269_1.var_.actorSpriteComps1061 then
					for iter_272_5, iter_272_6 in pairs(arg_269_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_272_6 then
							if arg_269_1.isInRecall_ then
								iter_272_6.color = Color.New(Mathf.Lerp(iter_272_6.color.r, arg_269_1.hightColor2.r, (arg_269_1.time_ - 0) / var_272_6), Mathf.Lerp(iter_272_6.color.g, arg_269_1.hightColor2.g, (arg_269_1.time_ - 0) / var_272_6), (Mathf.Lerp(iter_272_6.color.b, arg_269_1.hightColor2.b, (arg_269_1.time_ - 0) / var_272_6)))
							else
								local var_272_7 = Mathf.Lerp(iter_272_6.color.r, 0.5, (arg_269_1.time_ - 0) / var_272_6)

								iter_272_6.color = Color.New(var_272_7, var_272_7, var_272_7)
							end
						end
					end
				end
			end

			if arg_269_1.time_ >= 0 + var_272_6 and arg_269_1.time_ < 0 + var_272_6 + arg_272_0 and not isNil(var_272_5) and arg_269_1.var_.actorSpriteComps1061 then
				for iter_272_7, iter_272_8 in pairs(arg_269_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_272_8 then
						iter_272_8.color = arg_269_1.isInRecall_ and (arg_269_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_269_1.var_.actorSpriteComps1061 = nil
			end

			local var_272_8 = 0
			local var_272_9 = 0.325

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_8 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				arg_269_1.leftNameTxt_.text = arg_269_1:FormatText(StoryNameCfg[596].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_10 = arg_269_1:GetWordFromCfg(410161065)
				local var_272_11 = arg_269_1:FormatText(var_272_10.content)

				arg_269_1.text_.text = var_272_11

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_13 = 13 <= 0 and var_272_9 or var_272_9 * (utf8.len(var_272_11) / 13)

				if (13 <= 0 and var_272_9 or var_272_9 * (utf8.len(var_272_11) / 13)) > 0 and var_272_9 < var_272_13 then
					arg_269_1.talkMaxDuration = var_272_13

					if var_272_13 + var_272_8 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_13 + var_272_8
					end
				end

				arg_269_1.text_.text = var_272_11
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161065", "story_v_out_410161.awb") ~= 0 then
					local var_272_14 = manager.audio:GetVoiceLength("story_v_out_410161", "410161065", "story_v_out_410161.awb") / 1000

					if var_272_14 + var_272_8 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_14 + var_272_8
					end

					if var_272_10.prefab_name ~= "" and arg_269_1.actors_[var_272_10.prefab_name] ~= nil then
						local var_272_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_10.prefab_name].transform, "story_v_out_410161", "410161065", "story_v_out_410161.awb")

						arg_269_1:RecordAudio("410161065", var_272_15)
						arg_269_1:RecordAudio("410161065", var_272_15)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_410161", "410161065", "story_v_out_410161.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_410161", "410161065", "story_v_out_410161.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_16 = math.max(var_272_9, arg_269_1.talkMaxDuration)

			if var_272_8 <= arg_269_1.time_ and arg_269_1.time_ < var_272_8 + var_272_16 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_8) / var_272_16

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_8 + var_272_16 and arg_269_1.time_ < var_272_8 + var_272_16 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_269_1:InitPlayNodeList()
	end,
	Play410161066 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 410161066
		arg_273_1.duration_ = 5.87

		local var_273_0 = {
			ja = 4.866,
			CriLanguages = 5.866,
			zh = 5.866
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
				arg_273_0:Play410161067(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1.var_.moveOldPos1061 = arg_273_1.actors_["1061"].transform.localPosition
				arg_273_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_273_1:CheckSpriteTmpPos("1061", 2)

				for iter_276_0 = 0, arg_273_1.actors_["1061"].transform.childCount - 1 do
					local var_276_0 = arg_273_1.actors_["1061"].transform:GetChild(iter_276_0)

					if var_276_0.name == "split_5" or not string.find(var_276_0.name, "split") then
						var_276_0.gameObject:SetActive(true)
					else
						var_276_0.gameObject:SetActive(false)
					end
				end
			end

			local var_276_1 = 0.001

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_1 then
				arg_273_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (arg_273_1.time_ - 0) / var_276_1)
			end

			if arg_273_1.time_ >= 0 + var_276_1 and arg_273_1.time_ < 0 + var_276_1 + arg_276_0 then
				arg_273_1.actors_["1061"].transform.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_276_2 = arg_273_1.actors_["1061"]

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 and not isNil(var_276_2) and arg_273_1.var_.actorSpriteComps1061 == nil then
				arg_273_1.var_.actorSpriteComps1061 = var_276_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_276_3 = 0.034

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_3 and not isNil(var_276_2) then
				if arg_273_1.var_.actorSpriteComps1061 then
					for iter_276_1, iter_276_2 in pairs(arg_273_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_276_2 then
							if arg_273_1.isInRecall_ then
								iter_276_2.color = Color.New(Mathf.Lerp(iter_276_2.color.r, arg_273_1.hightColor1.r, (arg_273_1.time_ - 0) / var_276_3), Mathf.Lerp(iter_276_2.color.g, arg_273_1.hightColor1.g, (arg_273_1.time_ - 0) / var_276_3), (Mathf.Lerp(iter_276_2.color.b, arg_273_1.hightColor1.b, (arg_273_1.time_ - 0) / var_276_3)))
							else
								local var_276_4 = Mathf.Lerp(iter_276_2.color.r, 1, (arg_273_1.time_ - 0) / var_276_3)

								iter_276_2.color = Color.New(var_276_4, var_276_4, var_276_4)
							end
						end
					end
				end
			end

			if arg_273_1.time_ >= 0 + var_276_3 and arg_273_1.time_ < 0 + var_276_3 + arg_276_0 and not isNil(var_276_2) and arg_273_1.var_.actorSpriteComps1061 then
				for iter_276_3, iter_276_4 in pairs(arg_273_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_276_4 then
						iter_276_4.color = arg_273_1.isInRecall_ and (arg_273_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_273_1.var_.actorSpriteComps1061 = nil
			end

			local var_276_5 = arg_273_1.actors_["10059"]

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 and not isNil(var_276_5) and arg_273_1.var_.actorSpriteComps10059 == nil then
				arg_273_1.var_.actorSpriteComps10059 = var_276_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_276_6 = 0.034

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_6 and not isNil(var_276_5) then
				if arg_273_1.var_.actorSpriteComps10059 then
					for iter_276_5, iter_276_6 in pairs(arg_273_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_276_6 then
							if arg_273_1.isInRecall_ then
								iter_276_6.color = Color.New(Mathf.Lerp(iter_276_6.color.r, arg_273_1.hightColor2.r, (arg_273_1.time_ - 0) / var_276_6), Mathf.Lerp(iter_276_6.color.g, arg_273_1.hightColor2.g, (arg_273_1.time_ - 0) / var_276_6), (Mathf.Lerp(iter_276_6.color.b, arg_273_1.hightColor2.b, (arg_273_1.time_ - 0) / var_276_6)))
							else
								local var_276_7 = Mathf.Lerp(iter_276_6.color.r, 0.5, (arg_273_1.time_ - 0) / var_276_6)

								iter_276_6.color = Color.New(var_276_7, var_276_7, var_276_7)
							end
						end
					end
				end
			end

			if arg_273_1.time_ >= 0 + var_276_6 and arg_273_1.time_ < 0 + var_276_6 + arg_276_0 and not isNil(var_276_5) and arg_273_1.var_.actorSpriteComps10059 then
				for iter_276_7, iter_276_8 in pairs(arg_273_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_276_8 then
						iter_276_8.color = arg_273_1.isInRecall_ and (arg_273_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_273_1.var_.actorSpriteComps10059 = nil
			end

			local var_276_8 = 0
			local var_276_9 = 0.625

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_8 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				arg_273_1.leftNameTxt_.text = arg_273_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_10 = arg_273_1:GetWordFromCfg(410161066)
				local var_276_11 = arg_273_1:FormatText(var_276_10.content)

				arg_273_1.text_.text = var_276_11

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_13 = 25 <= 0 and var_276_9 or var_276_9 * (utf8.len(var_276_11) / 25)

				if (25 <= 0 and var_276_9 or var_276_9 * (utf8.len(var_276_11) / 25)) > 0 and var_276_9 < var_276_13 then
					arg_273_1.talkMaxDuration = var_276_13

					if var_276_13 + var_276_8 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_13 + var_276_8
					end
				end

				arg_273_1.text_.text = var_276_11
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161066", "story_v_out_410161.awb") ~= 0 then
					local var_276_14 = manager.audio:GetVoiceLength("story_v_out_410161", "410161066", "story_v_out_410161.awb") / 1000

					if var_276_14 + var_276_8 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_14 + var_276_8
					end

					if var_276_10.prefab_name ~= "" and arg_273_1.actors_[var_276_10.prefab_name] ~= nil then
						local var_276_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_10.prefab_name].transform, "story_v_out_410161", "410161066", "story_v_out_410161.awb")

						arg_273_1:RecordAudio("410161066", var_276_15)
						arg_273_1:RecordAudio("410161066", var_276_15)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_410161", "410161066", "story_v_out_410161.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_410161", "410161066", "story_v_out_410161.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_16 = math.max(var_276_9, arg_273_1.talkMaxDuration)

			if var_276_8 <= arg_273_1.time_ and arg_273_1.time_ < var_276_8 + var_276_16 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_8) / var_276_16

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_8 + var_276_16 and arg_273_1.time_ < var_276_8 + var_276_16 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_273_1:InitPlayNodeList()
	end,
	Play410161067 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 410161067
		arg_277_1.duration_ = 7.87

		local var_277_0 = {
			ja = 7.866,
			CriLanguages = 6.933,
			zh = 6.933
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
				arg_277_0:Play410161068(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1.var_.moveOldPos1061 = arg_277_1.actors_["1061"].transform.localPosition
				arg_277_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_277_1:CheckSpriteTmpPos("1061", 2)

				for iter_280_0 = 0, arg_277_1.actors_["1061"].transform.childCount - 1 do
					local var_280_0 = arg_277_1.actors_["1061"].transform:GetChild(iter_280_0)

					if var_280_0.name == "split_5" or not string.find(var_280_0.name, "split") then
						var_280_0.gameObject:SetActive(true)
					else
						var_280_0.gameObject:SetActive(false)
					end
				end
			end

			local var_280_1 = 0.001

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_1 then
				arg_277_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_277_1.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (arg_277_1.time_ - 0) / var_280_1)
			end

			if arg_277_1.time_ >= 0 + var_280_1 and arg_277_1.time_ < 0 + var_280_1 + arg_280_0 then
				arg_277_1.actors_["1061"].transform.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_280_2 = arg_277_1.actors_["1061"]

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 and not isNil(var_280_2) and arg_277_1.var_.actorSpriteComps1061 == nil then
				arg_277_1.var_.actorSpriteComps1061 = var_280_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_280_3 = 0.034

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_3 and not isNil(var_280_2) then
				if arg_277_1.var_.actorSpriteComps1061 then
					for iter_280_1, iter_280_2 in pairs(arg_277_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_280_2 then
							if arg_277_1.isInRecall_ then
								iter_280_2.color = Color.New(Mathf.Lerp(iter_280_2.color.r, arg_277_1.hightColor1.r, (arg_277_1.time_ - 0) / var_280_3), Mathf.Lerp(iter_280_2.color.g, arg_277_1.hightColor1.g, (arg_277_1.time_ - 0) / var_280_3), (Mathf.Lerp(iter_280_2.color.b, arg_277_1.hightColor1.b, (arg_277_1.time_ - 0) / var_280_3)))
							else
								local var_280_4 = Mathf.Lerp(iter_280_2.color.r, 1, (arg_277_1.time_ - 0) / var_280_3)

								iter_280_2.color = Color.New(var_280_4, var_280_4, var_280_4)
							end
						end
					end
				end
			end

			if arg_277_1.time_ >= 0 + var_280_3 and arg_277_1.time_ < 0 + var_280_3 + arg_280_0 and not isNil(var_280_2) and arg_277_1.var_.actorSpriteComps1061 then
				for iter_280_3, iter_280_4 in pairs(arg_277_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_280_4 then
						iter_280_4.color = arg_277_1.isInRecall_ and (arg_277_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_277_1.var_.actorSpriteComps1061 = nil
			end

			local var_280_5 = 0
			local var_280_6 = 0.8

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_5 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				arg_277_1.leftNameTxt_.text = arg_277_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_7 = arg_277_1:GetWordFromCfg(410161067)
				local var_280_8 = arg_277_1:FormatText(var_280_7.content)

				arg_277_1.text_.text = var_280_8

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_10 = 32 <= 0 and var_280_6 or var_280_6 * (utf8.len(var_280_8) / 32)

				if (32 <= 0 and var_280_6 or var_280_6 * (utf8.len(var_280_8) / 32)) > 0 and var_280_6 < var_280_10 then
					arg_277_1.talkMaxDuration = var_280_10

					if var_280_10 + var_280_5 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_10 + var_280_5
					end
				end

				arg_277_1.text_.text = var_280_8
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161067", "story_v_out_410161.awb") ~= 0 then
					local var_280_11 = manager.audio:GetVoiceLength("story_v_out_410161", "410161067", "story_v_out_410161.awb") / 1000

					if var_280_11 + var_280_5 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_11 + var_280_5
					end

					if var_280_7.prefab_name ~= "" and arg_277_1.actors_[var_280_7.prefab_name] ~= nil then
						local var_280_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_7.prefab_name].transform, "story_v_out_410161", "410161067", "story_v_out_410161.awb")

						arg_277_1:RecordAudio("410161067", var_280_12)
						arg_277_1:RecordAudio("410161067", var_280_12)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_410161", "410161067", "story_v_out_410161.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_410161", "410161067", "story_v_out_410161.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_13 = math.max(var_280_6, arg_277_1.talkMaxDuration)

			if var_280_5 <= arg_277_1.time_ and arg_277_1.time_ < var_280_5 + var_280_13 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_5) / var_280_13

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_5 + var_280_13 and arg_277_1.time_ < var_280_5 + var_280_13 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_277_1:InitPlayNodeList()
	end,
	Play410161068 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 410161068
		arg_281_1.duration_ = 7.93

		local var_281_0 = {
			ja = 7.766,
			CriLanguages = 7.933,
			zh = 7.933
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
				arg_281_0:Play410161069(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1.var_.moveOldPos10059 = arg_281_1.actors_["10059"].transform.localPosition
				arg_281_1.actors_["10059"].transform.localScale = Vector3.New(1, 1, 1)

				arg_281_1:CheckSpriteTmpPos("10059", 4)

				for iter_284_0 = 0, arg_281_1.actors_["10059"].transform.childCount - 1 do
					local var_284_0 = arg_281_1.actors_["10059"].transform:GetChild(iter_284_0)

					if var_284_0.name == "split_3" or not string.find(var_284_0.name, "split") then
						var_284_0.gameObject:SetActive(true)
					else
						var_284_0.gameObject:SetActive(false)
					end
				end
			end

			local var_284_1 = 0.001

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_1 then
				arg_281_1.actors_["10059"].transform.localPosition = Vector3.Lerp(arg_281_1.var_.moveOldPos10059, Vector3.New(390, -530, 35), (arg_281_1.time_ - 0) / var_284_1)
			end

			if arg_281_1.time_ >= 0 + var_284_1 and arg_281_1.time_ < 0 + var_284_1 + arg_284_0 then
				arg_281_1.actors_["10059"].transform.localPosition = Vector3.New(390, -530, 35)
			end

			local var_284_2 = arg_281_1.actors_["10059"]

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 and not isNil(var_284_2) and arg_281_1.var_.actorSpriteComps10059 == nil then
				arg_281_1.var_.actorSpriteComps10059 = var_284_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_284_3 = 0.034

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_3 and not isNil(var_284_2) then
				if arg_281_1.var_.actorSpriteComps10059 then
					for iter_284_1, iter_284_2 in pairs(arg_281_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_284_2 then
							if arg_281_1.isInRecall_ then
								iter_284_2.color = Color.New(Mathf.Lerp(iter_284_2.color.r, arg_281_1.hightColor1.r, (arg_281_1.time_ - 0) / var_284_3), Mathf.Lerp(iter_284_2.color.g, arg_281_1.hightColor1.g, (arg_281_1.time_ - 0) / var_284_3), (Mathf.Lerp(iter_284_2.color.b, arg_281_1.hightColor1.b, (arg_281_1.time_ - 0) / var_284_3)))
							else
								local var_284_4 = Mathf.Lerp(iter_284_2.color.r, 1, (arg_281_1.time_ - 0) / var_284_3)

								iter_284_2.color = Color.New(var_284_4, var_284_4, var_284_4)
							end
						end
					end
				end
			end

			if arg_281_1.time_ >= 0 + var_284_3 and arg_281_1.time_ < 0 + var_284_3 + arg_284_0 and not isNil(var_284_2) and arg_281_1.var_.actorSpriteComps10059 then
				for iter_284_3, iter_284_4 in pairs(arg_281_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_284_4 then
						iter_284_4.color = arg_281_1.isInRecall_ and (arg_281_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_281_1.var_.actorSpriteComps10059 = nil
			end

			local var_284_5 = arg_281_1.actors_["1061"]

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 and not isNil(var_284_5) and arg_281_1.var_.actorSpriteComps1061 == nil then
				arg_281_1.var_.actorSpriteComps1061 = var_284_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_284_6 = 0.034

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_6 and not isNil(var_284_5) then
				if arg_281_1.var_.actorSpriteComps1061 then
					for iter_284_5, iter_284_6 in pairs(arg_281_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_284_6 then
							if arg_281_1.isInRecall_ then
								iter_284_6.color = Color.New(Mathf.Lerp(iter_284_6.color.r, arg_281_1.hightColor2.r, (arg_281_1.time_ - 0) / var_284_6), Mathf.Lerp(iter_284_6.color.g, arg_281_1.hightColor2.g, (arg_281_1.time_ - 0) / var_284_6), (Mathf.Lerp(iter_284_6.color.b, arg_281_1.hightColor2.b, (arg_281_1.time_ - 0) / var_284_6)))
							else
								local var_284_7 = Mathf.Lerp(iter_284_6.color.r, 0.5, (arg_281_1.time_ - 0) / var_284_6)

								iter_284_6.color = Color.New(var_284_7, var_284_7, var_284_7)
							end
						end
					end
				end
			end

			if arg_281_1.time_ >= 0 + var_284_6 and arg_281_1.time_ < 0 + var_284_6 + arg_284_0 and not isNil(var_284_5) and arg_281_1.var_.actorSpriteComps1061 then
				for iter_284_7, iter_284_8 in pairs(arg_281_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_284_8 then
						iter_284_8.color = arg_281_1.isInRecall_ and (arg_281_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_281_1.var_.actorSpriteComps1061 = nil
			end

			local var_284_8 = 0
			local var_284_9 = 0.725

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_8 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				arg_281_1.leftNameTxt_.text = arg_281_1:FormatText(StoryNameCfg[596].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_10 = arg_281_1:GetWordFromCfg(410161068)
				local var_284_11 = arg_281_1:FormatText(var_284_10.content)

				arg_281_1.text_.text = var_284_11

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_13 = 29 <= 0 and var_284_9 or var_284_9 * (utf8.len(var_284_11) / 29)

				if (29 <= 0 and var_284_9 or var_284_9 * (utf8.len(var_284_11) / 29)) > 0 and var_284_9 < var_284_13 then
					arg_281_1.talkMaxDuration = var_284_13

					if var_284_13 + var_284_8 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_13 + var_284_8
					end
				end

				arg_281_1.text_.text = var_284_11
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161068", "story_v_out_410161.awb") ~= 0 then
					local var_284_14 = manager.audio:GetVoiceLength("story_v_out_410161", "410161068", "story_v_out_410161.awb") / 1000

					if var_284_14 + var_284_8 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_14 + var_284_8
					end

					if var_284_10.prefab_name ~= "" and arg_281_1.actors_[var_284_10.prefab_name] ~= nil then
						local var_284_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_10.prefab_name].transform, "story_v_out_410161", "410161068", "story_v_out_410161.awb")

						arg_281_1:RecordAudio("410161068", var_284_15)
						arg_281_1:RecordAudio("410161068", var_284_15)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_410161", "410161068", "story_v_out_410161.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_410161", "410161068", "story_v_out_410161.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_16 = math.max(var_284_9, arg_281_1.talkMaxDuration)

			if var_284_8 <= arg_281_1.time_ and arg_281_1.time_ < var_284_8 + var_284_16 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_8) / var_284_16

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_8 + var_284_16 and arg_281_1.time_ < var_284_8 + var_284_16 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_281_1:InitPlayNodeList()
	end,
	Play410161069 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 410161069
		arg_285_1.duration_ = 9.97

		local var_285_0 = {
			ja = 9.966,
			CriLanguages = 5.333,
			zh = 5.333
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
				arg_285_0:Play410161070(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1.var_.moveOldPos1061 = arg_285_1.actors_["1061"].transform.localPosition
				arg_285_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_285_1:CheckSpriteTmpPos("1061", 2)

				for iter_288_0 = 0, arg_285_1.actors_["1061"].transform.childCount - 1 do
					local var_288_0 = arg_285_1.actors_["1061"].transform:GetChild(iter_288_0)

					if var_288_0.name == "" or not string.find(var_288_0.name, "split") then
						var_288_0.gameObject:SetActive(true)
					else
						var_288_0.gameObject:SetActive(false)
					end
				end
			end

			local var_288_1 = 0.001

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_1 then
				arg_285_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_285_1.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (arg_285_1.time_ - 0) / var_288_1)
			end

			if arg_285_1.time_ >= 0 + var_288_1 and arg_285_1.time_ < 0 + var_288_1 + arg_288_0 then
				arg_285_1.actors_["1061"].transform.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_288_2 = arg_285_1.actors_["1061"]

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 and not isNil(var_288_2) and arg_285_1.var_.actorSpriteComps1061 == nil then
				arg_285_1.var_.actorSpriteComps1061 = var_288_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_288_3 = 0.034

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_3 and not isNil(var_288_2) then
				if arg_285_1.var_.actorSpriteComps1061 then
					for iter_288_1, iter_288_2 in pairs(arg_285_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_288_2 then
							if arg_285_1.isInRecall_ then
								iter_288_2.color = Color.New(Mathf.Lerp(iter_288_2.color.r, arg_285_1.hightColor1.r, (arg_285_1.time_ - 0) / var_288_3), Mathf.Lerp(iter_288_2.color.g, arg_285_1.hightColor1.g, (arg_285_1.time_ - 0) / var_288_3), (Mathf.Lerp(iter_288_2.color.b, arg_285_1.hightColor1.b, (arg_285_1.time_ - 0) / var_288_3)))
							else
								local var_288_4 = Mathf.Lerp(iter_288_2.color.r, 1, (arg_285_1.time_ - 0) / var_288_3)

								iter_288_2.color = Color.New(var_288_4, var_288_4, var_288_4)
							end
						end
					end
				end
			end

			if arg_285_1.time_ >= 0 + var_288_3 and arg_285_1.time_ < 0 + var_288_3 + arg_288_0 and not isNil(var_288_2) and arg_285_1.var_.actorSpriteComps1061 then
				for iter_288_3, iter_288_4 in pairs(arg_285_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_288_4 then
						iter_288_4.color = arg_285_1.isInRecall_ and (arg_285_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_285_1.var_.actorSpriteComps1061 = nil
			end

			local var_288_5 = arg_285_1.actors_["10059"]

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 and not isNil(var_288_5) and arg_285_1.var_.actorSpriteComps10059 == nil then
				arg_285_1.var_.actorSpriteComps10059 = var_288_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_288_6 = 0.034

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_6 and not isNil(var_288_5) then
				if arg_285_1.var_.actorSpriteComps10059 then
					for iter_288_5, iter_288_6 in pairs(arg_285_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_288_6 then
							if arg_285_1.isInRecall_ then
								iter_288_6.color = Color.New(Mathf.Lerp(iter_288_6.color.r, arg_285_1.hightColor2.r, (arg_285_1.time_ - 0) / var_288_6), Mathf.Lerp(iter_288_6.color.g, arg_285_1.hightColor2.g, (arg_285_1.time_ - 0) / var_288_6), (Mathf.Lerp(iter_288_6.color.b, arg_285_1.hightColor2.b, (arg_285_1.time_ - 0) / var_288_6)))
							else
								local var_288_7 = Mathf.Lerp(iter_288_6.color.r, 0.5, (arg_285_1.time_ - 0) / var_288_6)

								iter_288_6.color = Color.New(var_288_7, var_288_7, var_288_7)
							end
						end
					end
				end
			end

			if arg_285_1.time_ >= 0 + var_288_6 and arg_285_1.time_ < 0 + var_288_6 + arg_288_0 and not isNil(var_288_5) and arg_285_1.var_.actorSpriteComps10059 then
				for iter_288_7, iter_288_8 in pairs(arg_285_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_288_8 then
						iter_288_8.color = arg_285_1.isInRecall_ and (arg_285_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_285_1.var_.actorSpriteComps10059 = nil
			end

			local var_288_8 = 0
			local var_288_9 = 0.6

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_8 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				arg_285_1.leftNameTxt_.text = arg_285_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_10 = arg_285_1:GetWordFromCfg(410161069)
				local var_288_11 = arg_285_1:FormatText(var_288_10.content)

				arg_285_1.text_.text = var_288_11

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_13 = 24 <= 0 and var_288_9 or var_288_9 * (utf8.len(var_288_11) / 24)

				if (24 <= 0 and var_288_9 or var_288_9 * (utf8.len(var_288_11) / 24)) > 0 and var_288_9 < var_288_13 then
					arg_285_1.talkMaxDuration = var_288_13

					if var_288_13 + var_288_8 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_13 + var_288_8
					end
				end

				arg_285_1.text_.text = var_288_11
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161069", "story_v_out_410161.awb") ~= 0 then
					local var_288_14 = manager.audio:GetVoiceLength("story_v_out_410161", "410161069", "story_v_out_410161.awb") / 1000

					if var_288_14 + var_288_8 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_14 + var_288_8
					end

					if var_288_10.prefab_name ~= "" and arg_285_1.actors_[var_288_10.prefab_name] ~= nil then
						local var_288_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_10.prefab_name].transform, "story_v_out_410161", "410161069", "story_v_out_410161.awb")

						arg_285_1:RecordAudio("410161069", var_288_15)
						arg_285_1:RecordAudio("410161069", var_288_15)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_410161", "410161069", "story_v_out_410161.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_410161", "410161069", "story_v_out_410161.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_16 = math.max(var_288_9, arg_285_1.talkMaxDuration)

			if var_288_8 <= arg_285_1.time_ and arg_285_1.time_ < var_288_8 + var_288_16 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_8) / var_288_16

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_8 + var_288_16 and arg_285_1.time_ < var_288_8 + var_288_16 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_285_1:InitPlayNodeList()
	end,
	Play410161070 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 410161070
		arg_289_1.duration_ = 10.97

		local var_289_0 = {
			ja = 10.966,
			CriLanguages = 8.6,
			zh = 8.6
		}
		local var_289_1 = manager.audio:GetLocalizationFlag()

		if var_289_0[var_289_1] ~= nil then
			arg_289_1.duration_ = var_289_0[var_289_1]
		end

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play410161071(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1.var_.moveOldPos10059 = arg_289_1.actors_["10059"].transform.localPosition
				arg_289_1.actors_["10059"].transform.localScale = Vector3.New(1, 1, 1)

				arg_289_1:CheckSpriteTmpPos("10059", 4)

				for iter_292_0 = 0, arg_289_1.actors_["10059"].transform.childCount - 1 do
					local var_292_0 = arg_289_1.actors_["10059"].transform:GetChild(iter_292_0)

					if var_292_0.name == "split_3" or not string.find(var_292_0.name, "split") then
						var_292_0.gameObject:SetActive(true)
					else
						var_292_0.gameObject:SetActive(false)
					end
				end
			end

			local var_292_1 = 0.001

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_1 then
				arg_289_1.actors_["10059"].transform.localPosition = Vector3.Lerp(arg_289_1.var_.moveOldPos10059, Vector3.New(390, -530, 35), (arg_289_1.time_ - 0) / var_292_1)
			end

			if arg_289_1.time_ >= 0 + var_292_1 and arg_289_1.time_ < 0 + var_292_1 + arg_292_0 then
				arg_289_1.actors_["10059"].transform.localPosition = Vector3.New(390, -530, 35)
			end

			local var_292_2 = arg_289_1.actors_["10059"]

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 and not isNil(var_292_2) and arg_289_1.var_.actorSpriteComps10059 == nil then
				arg_289_1.var_.actorSpriteComps10059 = var_292_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_292_3 = 0.034

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_3 and not isNil(var_292_2) then
				if arg_289_1.var_.actorSpriteComps10059 then
					for iter_292_1, iter_292_2 in pairs(arg_289_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_292_2 then
							if arg_289_1.isInRecall_ then
								iter_292_2.color = Color.New(Mathf.Lerp(iter_292_2.color.r, arg_289_1.hightColor1.r, (arg_289_1.time_ - 0) / var_292_3), Mathf.Lerp(iter_292_2.color.g, arg_289_1.hightColor1.g, (arg_289_1.time_ - 0) / var_292_3), (Mathf.Lerp(iter_292_2.color.b, arg_289_1.hightColor1.b, (arg_289_1.time_ - 0) / var_292_3)))
							else
								local var_292_4 = Mathf.Lerp(iter_292_2.color.r, 1, (arg_289_1.time_ - 0) / var_292_3)

								iter_292_2.color = Color.New(var_292_4, var_292_4, var_292_4)
							end
						end
					end
				end
			end

			if arg_289_1.time_ >= 0 + var_292_3 and arg_289_1.time_ < 0 + var_292_3 + arg_292_0 and not isNil(var_292_2) and arg_289_1.var_.actorSpriteComps10059 then
				for iter_292_3, iter_292_4 in pairs(arg_289_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_292_4 then
						iter_292_4.color = arg_289_1.isInRecall_ and (arg_289_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_289_1.var_.actorSpriteComps10059 = nil
			end

			local var_292_5 = arg_289_1.actors_["1061"]

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 and not isNil(var_292_5) and arg_289_1.var_.actorSpriteComps1061 == nil then
				arg_289_1.var_.actorSpriteComps1061 = var_292_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_292_6 = 0.034

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_6 and not isNil(var_292_5) then
				if arg_289_1.var_.actorSpriteComps1061 then
					for iter_292_5, iter_292_6 in pairs(arg_289_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_292_6 then
							if arg_289_1.isInRecall_ then
								iter_292_6.color = Color.New(Mathf.Lerp(iter_292_6.color.r, arg_289_1.hightColor2.r, (arg_289_1.time_ - 0) / var_292_6), Mathf.Lerp(iter_292_6.color.g, arg_289_1.hightColor2.g, (arg_289_1.time_ - 0) / var_292_6), (Mathf.Lerp(iter_292_6.color.b, arg_289_1.hightColor2.b, (arg_289_1.time_ - 0) / var_292_6)))
							else
								local var_292_7 = Mathf.Lerp(iter_292_6.color.r, 0.5, (arg_289_1.time_ - 0) / var_292_6)

								iter_292_6.color = Color.New(var_292_7, var_292_7, var_292_7)
							end
						end
					end
				end
			end

			if arg_289_1.time_ >= 0 + var_292_6 and arg_289_1.time_ < 0 + var_292_6 + arg_292_0 and not isNil(var_292_5) and arg_289_1.var_.actorSpriteComps1061 then
				for iter_292_7, iter_292_8 in pairs(arg_289_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_292_8 then
						iter_292_8.color = arg_289_1.isInRecall_ and (arg_289_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_289_1.var_.actorSpriteComps1061 = nil
			end

			local var_292_8 = 0
			local var_292_9 = 0.875

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_8 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				arg_289_1.leftNameTxt_.text = arg_289_1:FormatText(StoryNameCfg[596].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_10 = arg_289_1:GetWordFromCfg(410161070)
				local var_292_11 = arg_289_1:FormatText(var_292_10.content)

				arg_289_1.text_.text = var_292_11

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_13 = 35 <= 0 and var_292_9 or var_292_9 * (utf8.len(var_292_11) / 35)

				if (35 <= 0 and var_292_9 or var_292_9 * (utf8.len(var_292_11) / 35)) > 0 and var_292_9 < var_292_13 then
					arg_289_1.talkMaxDuration = var_292_13

					if var_292_13 + var_292_8 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_13 + var_292_8
					end
				end

				arg_289_1.text_.text = var_292_11
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161070", "story_v_out_410161.awb") ~= 0 then
					local var_292_14 = manager.audio:GetVoiceLength("story_v_out_410161", "410161070", "story_v_out_410161.awb") / 1000

					if var_292_14 + var_292_8 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_14 + var_292_8
					end

					if var_292_10.prefab_name ~= "" and arg_289_1.actors_[var_292_10.prefab_name] ~= nil then
						local var_292_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_10.prefab_name].transform, "story_v_out_410161", "410161070", "story_v_out_410161.awb")

						arg_289_1:RecordAudio("410161070", var_292_15)
						arg_289_1:RecordAudio("410161070", var_292_15)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_410161", "410161070", "story_v_out_410161.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_410161", "410161070", "story_v_out_410161.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_16 = math.max(var_292_9, arg_289_1.talkMaxDuration)

			if var_292_8 <= arg_289_1.time_ and arg_289_1.time_ < var_292_8 + var_292_16 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_8) / var_292_16

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_8 + var_292_16 and arg_289_1.time_ < var_292_8 + var_292_16 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_289_1:InitPlayNodeList()
	end,
	Play410161071 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 410161071
		arg_293_1.duration_ = 11.63

		local var_293_0 = {
			ja = 11.633,
			CriLanguages = 7.466,
			zh = 7.466
		}
		local var_293_1 = manager.audio:GetLocalizationFlag()

		if var_293_0[var_293_1] ~= nil then
			arg_293_1.duration_ = var_293_0[var_293_1]
		end

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play410161072(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1.var_.moveOldPos10059 = arg_293_1.actors_["10059"].transform.localPosition
				arg_293_1.actors_["10059"].transform.localScale = Vector3.New(1, 1, 1)

				arg_293_1:CheckSpriteTmpPos("10059", 4)

				for iter_296_0 = 0, arg_293_1.actors_["10059"].transform.childCount - 1 do
					local var_296_0 = arg_293_1.actors_["10059"].transform:GetChild(iter_296_0)

					if var_296_0.name == "split_3" or not string.find(var_296_0.name, "split") then
						var_296_0.gameObject:SetActive(true)
					else
						var_296_0.gameObject:SetActive(false)
					end
				end
			end

			local var_296_1 = 0.001

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_1 then
				arg_293_1.actors_["10059"].transform.localPosition = Vector3.Lerp(arg_293_1.var_.moveOldPos10059, Vector3.New(390, -530, 35), (arg_293_1.time_ - 0) / var_296_1)
			end

			if arg_293_1.time_ >= 0 + var_296_1 and arg_293_1.time_ < 0 + var_296_1 + arg_296_0 then
				arg_293_1.actors_["10059"].transform.localPosition = Vector3.New(390, -530, 35)
			end

			local var_296_2 = arg_293_1.actors_["10059"]

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 and not isNil(var_296_2) and arg_293_1.var_.actorSpriteComps10059 == nil then
				arg_293_1.var_.actorSpriteComps10059 = var_296_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_296_3 = 0.034

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_3 and not isNil(var_296_2) then
				if arg_293_1.var_.actorSpriteComps10059 then
					for iter_296_1, iter_296_2 in pairs(arg_293_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_296_2 then
							if arg_293_1.isInRecall_ then
								iter_296_2.color = Color.New(Mathf.Lerp(iter_296_2.color.r, arg_293_1.hightColor1.r, (arg_293_1.time_ - 0) / var_296_3), Mathf.Lerp(iter_296_2.color.g, arg_293_1.hightColor1.g, (arg_293_1.time_ - 0) / var_296_3), (Mathf.Lerp(iter_296_2.color.b, arg_293_1.hightColor1.b, (arg_293_1.time_ - 0) / var_296_3)))
							else
								local var_296_4 = Mathf.Lerp(iter_296_2.color.r, 1, (arg_293_1.time_ - 0) / var_296_3)

								iter_296_2.color = Color.New(var_296_4, var_296_4, var_296_4)
							end
						end
					end
				end
			end

			if arg_293_1.time_ >= 0 + var_296_3 and arg_293_1.time_ < 0 + var_296_3 + arg_296_0 and not isNil(var_296_2) and arg_293_1.var_.actorSpriteComps10059 then
				for iter_296_3, iter_296_4 in pairs(arg_293_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_296_4 then
						iter_296_4.color = arg_293_1.isInRecall_ and (arg_293_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_293_1.var_.actorSpriteComps10059 = nil
			end

			local var_296_5 = 0
			local var_296_6 = 0.8

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_5 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				arg_293_1.leftNameTxt_.text = arg_293_1:FormatText(StoryNameCfg[596].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_7 = arg_293_1:GetWordFromCfg(410161071)
				local var_296_8 = arg_293_1:FormatText(var_296_7.content)

				arg_293_1.text_.text = var_296_8

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_10 = 32 <= 0 and var_296_6 or var_296_6 * (utf8.len(var_296_8) / 32)

				if (32 <= 0 and var_296_6 or var_296_6 * (utf8.len(var_296_8) / 32)) > 0 and var_296_6 < var_296_10 then
					arg_293_1.talkMaxDuration = var_296_10

					if var_296_10 + var_296_5 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_10 + var_296_5
					end
				end

				arg_293_1.text_.text = var_296_8
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161071", "story_v_out_410161.awb") ~= 0 then
					local var_296_11 = manager.audio:GetVoiceLength("story_v_out_410161", "410161071", "story_v_out_410161.awb") / 1000

					if var_296_11 + var_296_5 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_11 + var_296_5
					end

					if var_296_7.prefab_name ~= "" and arg_293_1.actors_[var_296_7.prefab_name] ~= nil then
						local var_296_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_7.prefab_name].transform, "story_v_out_410161", "410161071", "story_v_out_410161.awb")

						arg_293_1:RecordAudio("410161071", var_296_12)
						arg_293_1:RecordAudio("410161071", var_296_12)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_out_410161", "410161071", "story_v_out_410161.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_out_410161", "410161071", "story_v_out_410161.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_13 = math.max(var_296_6, arg_293_1.talkMaxDuration)

			if var_296_5 <= arg_293_1.time_ and arg_293_1.time_ < var_296_5 + var_296_13 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_5) / var_296_13

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_5 + var_296_13 and arg_293_1.time_ < var_296_5 + var_296_13 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_293_1:InitPlayNodeList()
	end,
	Play410161072 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 410161072
		arg_297_1.duration_ = 10.83

		local var_297_0 = {
			ja = 10.833,
			CriLanguages = 7.166,
			zh = 7.166
		}
		local var_297_1 = manager.audio:GetLocalizationFlag()

		if var_297_0[var_297_1] ~= nil then
			arg_297_1.duration_ = var_297_0[var_297_1]
		end

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play410161073(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1.var_.moveOldPos1061 = arg_297_1.actors_["1061"].transform.localPosition
				arg_297_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_297_1:CheckSpriteTmpPos("1061", 2)

				for iter_300_0 = 0, arg_297_1.actors_["1061"].transform.childCount - 1 do
					local var_300_0 = arg_297_1.actors_["1061"].transform:GetChild(iter_300_0)

					if var_300_0.name == "split_5" or not string.find(var_300_0.name, "split") then
						var_300_0.gameObject:SetActive(true)
					else
						var_300_0.gameObject:SetActive(false)
					end
				end
			end

			local var_300_1 = 0.001

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_1 then
				arg_297_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_297_1.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (arg_297_1.time_ - 0) / var_300_1)
			end

			if arg_297_1.time_ >= 0 + var_300_1 and arg_297_1.time_ < 0 + var_300_1 + arg_300_0 then
				arg_297_1.actors_["1061"].transform.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_300_2 = arg_297_1.actors_["1061"]

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 and not isNil(var_300_2) and arg_297_1.var_.actorSpriteComps1061 == nil then
				arg_297_1.var_.actorSpriteComps1061 = var_300_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_300_3 = 0.034

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_3 and not isNil(var_300_2) then
				if arg_297_1.var_.actorSpriteComps1061 then
					for iter_300_1, iter_300_2 in pairs(arg_297_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_300_2 then
							if arg_297_1.isInRecall_ then
								iter_300_2.color = Color.New(Mathf.Lerp(iter_300_2.color.r, arg_297_1.hightColor1.r, (arg_297_1.time_ - 0) / var_300_3), Mathf.Lerp(iter_300_2.color.g, arg_297_1.hightColor1.g, (arg_297_1.time_ - 0) / var_300_3), (Mathf.Lerp(iter_300_2.color.b, arg_297_1.hightColor1.b, (arg_297_1.time_ - 0) / var_300_3)))
							else
								local var_300_4 = Mathf.Lerp(iter_300_2.color.r, 1, (arg_297_1.time_ - 0) / var_300_3)

								iter_300_2.color = Color.New(var_300_4, var_300_4, var_300_4)
							end
						end
					end
				end
			end

			if arg_297_1.time_ >= 0 + var_300_3 and arg_297_1.time_ < 0 + var_300_3 + arg_300_0 and not isNil(var_300_2) and arg_297_1.var_.actorSpriteComps1061 then
				for iter_300_3, iter_300_4 in pairs(arg_297_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_300_4 then
						iter_300_4.color = arg_297_1.isInRecall_ and (arg_297_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_297_1.var_.actorSpriteComps1061 = nil
			end

			local var_300_5 = arg_297_1.actors_["10059"]

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 and not isNil(var_300_5) and arg_297_1.var_.actorSpriteComps10059 == nil then
				arg_297_1.var_.actorSpriteComps10059 = var_300_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_300_6 = 0.034

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_6 and not isNil(var_300_5) then
				if arg_297_1.var_.actorSpriteComps10059 then
					for iter_300_5, iter_300_6 in pairs(arg_297_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_300_6 then
							if arg_297_1.isInRecall_ then
								iter_300_6.color = Color.New(Mathf.Lerp(iter_300_6.color.r, arg_297_1.hightColor2.r, (arg_297_1.time_ - 0) / var_300_6), Mathf.Lerp(iter_300_6.color.g, arg_297_1.hightColor2.g, (arg_297_1.time_ - 0) / var_300_6), (Mathf.Lerp(iter_300_6.color.b, arg_297_1.hightColor2.b, (arg_297_1.time_ - 0) / var_300_6)))
							else
								local var_300_7 = Mathf.Lerp(iter_300_6.color.r, 0.5, (arg_297_1.time_ - 0) / var_300_6)

								iter_300_6.color = Color.New(var_300_7, var_300_7, var_300_7)
							end
						end
					end
				end
			end

			if arg_297_1.time_ >= 0 + var_300_6 and arg_297_1.time_ < 0 + var_300_6 + arg_300_0 and not isNil(var_300_5) and arg_297_1.var_.actorSpriteComps10059 then
				for iter_300_7, iter_300_8 in pairs(arg_297_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_300_8 then
						iter_300_8.color = arg_297_1.isInRecall_ and (arg_297_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_297_1.var_.actorSpriteComps10059 = nil
			end

			local var_300_8 = 0
			local var_300_9 = 0.8

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_8 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				arg_297_1.leftNameTxt_.text = arg_297_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_10 = arg_297_1:GetWordFromCfg(410161072)
				local var_300_11 = arg_297_1:FormatText(var_300_10.content)

				arg_297_1.text_.text = var_300_11

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_13 = 32 <= 0 and var_300_9 or var_300_9 * (utf8.len(var_300_11) / 32)

				if (32 <= 0 and var_300_9 or var_300_9 * (utf8.len(var_300_11) / 32)) > 0 and var_300_9 < var_300_13 then
					arg_297_1.talkMaxDuration = var_300_13

					if var_300_13 + var_300_8 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_13 + var_300_8
					end
				end

				arg_297_1.text_.text = var_300_11
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161072", "story_v_out_410161.awb") ~= 0 then
					local var_300_14 = manager.audio:GetVoiceLength("story_v_out_410161", "410161072", "story_v_out_410161.awb") / 1000

					if var_300_14 + var_300_8 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_14 + var_300_8
					end

					if var_300_10.prefab_name ~= "" and arg_297_1.actors_[var_300_10.prefab_name] ~= nil then
						local var_300_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_10.prefab_name].transform, "story_v_out_410161", "410161072", "story_v_out_410161.awb")

						arg_297_1:RecordAudio("410161072", var_300_15)
						arg_297_1:RecordAudio("410161072", var_300_15)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_out_410161", "410161072", "story_v_out_410161.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_out_410161", "410161072", "story_v_out_410161.awb")
				end

				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_16 = math.max(var_300_9, arg_297_1.talkMaxDuration)

			if var_300_8 <= arg_297_1.time_ and arg_297_1.time_ < var_300_8 + var_300_16 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_8) / var_300_16

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_8 + var_300_16 and arg_297_1.time_ < var_300_8 + var_300_16 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_297_1:InitPlayNodeList()
	end,
	Play410161073 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 410161073
		arg_301_1.duration_ = 13.3

		local var_301_0 = {
			ja = 13.3,
			CriLanguages = 9.566,
			zh = 9.566
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
				arg_301_0:Play410161074(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1.var_.moveOldPos10059 = arg_301_1.actors_["10059"].transform.localPosition
				arg_301_1.actors_["10059"].transform.localScale = Vector3.New(1, 1, 1)

				arg_301_1:CheckSpriteTmpPos("10059", 4)

				for iter_304_0 = 0, arg_301_1.actors_["10059"].transform.childCount - 1 do
					local var_304_0 = arg_301_1.actors_["10059"].transform:GetChild(iter_304_0)

					if var_304_0.name == "" or not string.find(var_304_0.name, "split") then
						var_304_0.gameObject:SetActive(true)
					else
						var_304_0.gameObject:SetActive(false)
					end
				end
			end

			local var_304_1 = 0.001

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_1 then
				arg_301_1.actors_["10059"].transform.localPosition = Vector3.Lerp(arg_301_1.var_.moveOldPos10059, Vector3.New(390, -530, 35), (arg_301_1.time_ - 0) / var_304_1)
			end

			if arg_301_1.time_ >= 0 + var_304_1 and arg_301_1.time_ < 0 + var_304_1 + arg_304_0 then
				arg_301_1.actors_["10059"].transform.localPosition = Vector3.New(390, -530, 35)
			end

			local var_304_2 = arg_301_1.actors_["10059"]

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 and not isNil(var_304_2) and arg_301_1.var_.actorSpriteComps10059 == nil then
				arg_301_1.var_.actorSpriteComps10059 = var_304_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_304_3 = 0.034

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_3 and not isNil(var_304_2) then
				if arg_301_1.var_.actorSpriteComps10059 then
					for iter_304_1, iter_304_2 in pairs(arg_301_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_304_2 then
							if arg_301_1.isInRecall_ then
								iter_304_2.color = Color.New(Mathf.Lerp(iter_304_2.color.r, arg_301_1.hightColor1.r, (arg_301_1.time_ - 0) / var_304_3), Mathf.Lerp(iter_304_2.color.g, arg_301_1.hightColor1.g, (arg_301_1.time_ - 0) / var_304_3), (Mathf.Lerp(iter_304_2.color.b, arg_301_1.hightColor1.b, (arg_301_1.time_ - 0) / var_304_3)))
							else
								local var_304_4 = Mathf.Lerp(iter_304_2.color.r, 1, (arg_301_1.time_ - 0) / var_304_3)

								iter_304_2.color = Color.New(var_304_4, var_304_4, var_304_4)
							end
						end
					end
				end
			end

			if arg_301_1.time_ >= 0 + var_304_3 and arg_301_1.time_ < 0 + var_304_3 + arg_304_0 and not isNil(var_304_2) and arg_301_1.var_.actorSpriteComps10059 then
				for iter_304_3, iter_304_4 in pairs(arg_301_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_304_4 then
						iter_304_4.color = arg_301_1.isInRecall_ and (arg_301_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_301_1.var_.actorSpriteComps10059 = nil
			end

			local var_304_5 = arg_301_1.actors_["1061"]

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 and not isNil(var_304_5) and arg_301_1.var_.actorSpriteComps1061 == nil then
				arg_301_1.var_.actorSpriteComps1061 = var_304_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_304_6 = 0.034

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_6 and not isNil(var_304_5) then
				if arg_301_1.var_.actorSpriteComps1061 then
					for iter_304_5, iter_304_6 in pairs(arg_301_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_304_6 then
							if arg_301_1.isInRecall_ then
								iter_304_6.color = Color.New(Mathf.Lerp(iter_304_6.color.r, arg_301_1.hightColor2.r, (arg_301_1.time_ - 0) / var_304_6), Mathf.Lerp(iter_304_6.color.g, arg_301_1.hightColor2.g, (arg_301_1.time_ - 0) / var_304_6), (Mathf.Lerp(iter_304_6.color.b, arg_301_1.hightColor2.b, (arg_301_1.time_ - 0) / var_304_6)))
							else
								local var_304_7 = Mathf.Lerp(iter_304_6.color.r, 0.5, (arg_301_1.time_ - 0) / var_304_6)

								iter_304_6.color = Color.New(var_304_7, var_304_7, var_304_7)
							end
						end
					end
				end
			end

			if arg_301_1.time_ >= 0 + var_304_6 and arg_301_1.time_ < 0 + var_304_6 + arg_304_0 and not isNil(var_304_5) and arg_301_1.var_.actorSpriteComps1061 then
				for iter_304_7, iter_304_8 in pairs(arg_301_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_304_8 then
						iter_304_8.color = arg_301_1.isInRecall_ and (arg_301_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_301_1.var_.actorSpriteComps1061 = nil
			end

			local var_304_8 = 0
			local var_304_9 = 1.025

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_8 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				arg_301_1.leftNameTxt_.text = arg_301_1:FormatText(StoryNameCfg[596].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_10 = arg_301_1:GetWordFromCfg(410161073)
				local var_304_11 = arg_301_1:FormatText(var_304_10.content)

				arg_301_1.text_.text = var_304_11

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_13 = 41 <= 0 and var_304_9 or var_304_9 * (utf8.len(var_304_11) / 41)

				if (41 <= 0 and var_304_9 or var_304_9 * (utf8.len(var_304_11) / 41)) > 0 and var_304_9 < var_304_13 then
					arg_301_1.talkMaxDuration = var_304_13

					if var_304_13 + var_304_8 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_13 + var_304_8
					end
				end

				arg_301_1.text_.text = var_304_11
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161073", "story_v_out_410161.awb") ~= 0 then
					local var_304_14 = manager.audio:GetVoiceLength("story_v_out_410161", "410161073", "story_v_out_410161.awb") / 1000

					if var_304_14 + var_304_8 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_14 + var_304_8
					end

					if var_304_10.prefab_name ~= "" and arg_301_1.actors_[var_304_10.prefab_name] ~= nil then
						local var_304_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_10.prefab_name].transform, "story_v_out_410161", "410161073", "story_v_out_410161.awb")

						arg_301_1:RecordAudio("410161073", var_304_15)
						arg_301_1:RecordAudio("410161073", var_304_15)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_out_410161", "410161073", "story_v_out_410161.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_out_410161", "410161073", "story_v_out_410161.awb")
				end

				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_16 = math.max(var_304_9, arg_301_1.talkMaxDuration)

			if var_304_8 <= arg_301_1.time_ and arg_301_1.time_ < var_304_8 + var_304_16 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_8) / var_304_16

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_8 + var_304_16 and arg_301_1.time_ < var_304_8 + var_304_16 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_301_1:InitPlayNodeList()
	end,
	Play410161074 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 410161074
		arg_305_1.duration_ = 5.4

		local var_305_0 = {
			ja = 5.4,
			CriLanguages = 2.033,
			zh = 2.033
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
				arg_305_0:Play410161075(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1.var_.moveOldPos1061 = arg_305_1.actors_["1061"].transform.localPosition
				arg_305_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_305_1:CheckSpriteTmpPos("1061", 2)

				for iter_308_0 = 0, arg_305_1.actors_["1061"].transform.childCount - 1 do
					local var_308_0 = arg_305_1.actors_["1061"].transform:GetChild(iter_308_0)

					if var_308_0.name == "" or not string.find(var_308_0.name, "split") then
						var_308_0.gameObject:SetActive(true)
					else
						var_308_0.gameObject:SetActive(false)
					end
				end
			end

			local var_308_1 = 0.001

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_1 then
				arg_305_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_305_1.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (arg_305_1.time_ - 0) / var_308_1)
			end

			if arg_305_1.time_ >= 0 + var_308_1 and arg_305_1.time_ < 0 + var_308_1 + arg_308_0 then
				arg_305_1.actors_["1061"].transform.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_308_2 = arg_305_1.actors_["1061"]

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 and not isNil(var_308_2) and arg_305_1.var_.actorSpriteComps1061 == nil then
				arg_305_1.var_.actorSpriteComps1061 = var_308_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_308_3 = 0.034

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_3 and not isNil(var_308_2) then
				if arg_305_1.var_.actorSpriteComps1061 then
					for iter_308_1, iter_308_2 in pairs(arg_305_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_308_2 then
							if arg_305_1.isInRecall_ then
								iter_308_2.color = Color.New(Mathf.Lerp(iter_308_2.color.r, arg_305_1.hightColor1.r, (arg_305_1.time_ - 0) / var_308_3), Mathf.Lerp(iter_308_2.color.g, arg_305_1.hightColor1.g, (arg_305_1.time_ - 0) / var_308_3), (Mathf.Lerp(iter_308_2.color.b, arg_305_1.hightColor1.b, (arg_305_1.time_ - 0) / var_308_3)))
							else
								local var_308_4 = Mathf.Lerp(iter_308_2.color.r, 1, (arg_305_1.time_ - 0) / var_308_3)

								iter_308_2.color = Color.New(var_308_4, var_308_4, var_308_4)
							end
						end
					end
				end
			end

			if arg_305_1.time_ >= 0 + var_308_3 and arg_305_1.time_ < 0 + var_308_3 + arg_308_0 and not isNil(var_308_2) and arg_305_1.var_.actorSpriteComps1061 then
				for iter_308_3, iter_308_4 in pairs(arg_305_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_308_4 then
						iter_308_4.color = arg_305_1.isInRecall_ and (arg_305_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_305_1.var_.actorSpriteComps1061 = nil
			end

			local var_308_5 = arg_305_1.actors_["10059"]

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 and not isNil(var_308_5) and arg_305_1.var_.actorSpriteComps10059 == nil then
				arg_305_1.var_.actorSpriteComps10059 = var_308_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_308_6 = 0.034

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_6 and not isNil(var_308_5) then
				if arg_305_1.var_.actorSpriteComps10059 then
					for iter_308_5, iter_308_6 in pairs(arg_305_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_308_6 then
							if arg_305_1.isInRecall_ then
								iter_308_6.color = Color.New(Mathf.Lerp(iter_308_6.color.r, arg_305_1.hightColor2.r, (arg_305_1.time_ - 0) / var_308_6), Mathf.Lerp(iter_308_6.color.g, arg_305_1.hightColor2.g, (arg_305_1.time_ - 0) / var_308_6), (Mathf.Lerp(iter_308_6.color.b, arg_305_1.hightColor2.b, (arg_305_1.time_ - 0) / var_308_6)))
							else
								local var_308_7 = Mathf.Lerp(iter_308_6.color.r, 0.5, (arg_305_1.time_ - 0) / var_308_6)

								iter_308_6.color = Color.New(var_308_7, var_308_7, var_308_7)
							end
						end
					end
				end
			end

			if arg_305_1.time_ >= 0 + var_308_6 and arg_305_1.time_ < 0 + var_308_6 + arg_308_0 and not isNil(var_308_5) and arg_305_1.var_.actorSpriteComps10059 then
				for iter_308_7, iter_308_8 in pairs(arg_305_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_308_8 then
						iter_308_8.color = arg_305_1.isInRecall_ and (arg_305_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_305_1.var_.actorSpriteComps10059 = nil
			end

			local var_308_8 = 0
			local var_308_9 = 0.275

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= var_308_8 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				arg_305_1.leftNameTxt_.text = arg_305_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_10 = arg_305_1:GetWordFromCfg(410161074)
				local var_308_11 = arg_305_1:FormatText(var_308_10.content)

				arg_305_1.text_.text = var_308_11

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_13 = 11 <= 0 and var_308_9 or var_308_9 * (utf8.len(var_308_11) / 11)

				if (11 <= 0 and var_308_9 or var_308_9 * (utf8.len(var_308_11) / 11)) > 0 and var_308_9 < var_308_13 then
					arg_305_1.talkMaxDuration = var_308_13

					if var_308_13 + var_308_8 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_13 + var_308_8
					end
				end

				arg_305_1.text_.text = var_308_11
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161074", "story_v_out_410161.awb") ~= 0 then
					local var_308_14 = manager.audio:GetVoiceLength("story_v_out_410161", "410161074", "story_v_out_410161.awb") / 1000

					if var_308_14 + var_308_8 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_14 + var_308_8
					end

					if var_308_10.prefab_name ~= "" and arg_305_1.actors_[var_308_10.prefab_name] ~= nil then
						local var_308_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_305_1.actors_[var_308_10.prefab_name].transform, "story_v_out_410161", "410161074", "story_v_out_410161.awb")

						arg_305_1:RecordAudio("410161074", var_308_15)
						arg_305_1:RecordAudio("410161074", var_308_15)
					else
						arg_305_1:AudioAction("play", "voice", "story_v_out_410161", "410161074", "story_v_out_410161.awb")
					end

					arg_305_1:RecordHistoryTalkVoice("story_v_out_410161", "410161074", "story_v_out_410161.awb")
				end

				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_16 = math.max(var_308_9, arg_305_1.talkMaxDuration)

			if var_308_8 <= arg_305_1.time_ and arg_305_1.time_ < var_308_8 + var_308_16 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_8) / var_308_16

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_8 + var_308_16 and arg_305_1.time_ < var_308_8 + var_308_16 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_305_1:InitPlayNodeList()
	end,
	Play410161075 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 410161075
		arg_309_1.duration_ = 4.67

		local var_309_0 = {
			ja = 4.666,
			CriLanguages = 3.2,
			zh = 3.2
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
				arg_309_0:Play410161076(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1.var_.moveOldPos1061 = arg_309_1.actors_["1061"].transform.localPosition
				arg_309_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_309_1:CheckSpriteTmpPos("1061", 2)

				for iter_312_0 = 0, arg_309_1.actors_["1061"].transform.childCount - 1 do
					local var_312_0 = arg_309_1.actors_["1061"].transform:GetChild(iter_312_0)

					if var_312_0.name == "" or not string.find(var_312_0.name, "split") then
						var_312_0.gameObject:SetActive(true)
					else
						var_312_0.gameObject:SetActive(false)
					end
				end
			end

			local var_312_1 = 0.001

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_1 then
				arg_309_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_309_1.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (arg_309_1.time_ - 0) / var_312_1)
			end

			if arg_309_1.time_ >= 0 + var_312_1 and arg_309_1.time_ < 0 + var_312_1 + arg_312_0 then
				arg_309_1.actors_["1061"].transform.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_312_2 = arg_309_1.actors_["1061"]

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 and not isNil(var_312_2) and arg_309_1.var_.actorSpriteComps1061 == nil then
				arg_309_1.var_.actorSpriteComps1061 = var_312_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_312_3 = 0.034

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_3 and not isNil(var_312_2) then
				if arg_309_1.var_.actorSpriteComps1061 then
					for iter_312_1, iter_312_2 in pairs(arg_309_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_312_2 then
							if arg_309_1.isInRecall_ then
								iter_312_2.color = Color.New(Mathf.Lerp(iter_312_2.color.r, arg_309_1.hightColor1.r, (arg_309_1.time_ - 0) / var_312_3), Mathf.Lerp(iter_312_2.color.g, arg_309_1.hightColor1.g, (arg_309_1.time_ - 0) / var_312_3), (Mathf.Lerp(iter_312_2.color.b, arg_309_1.hightColor1.b, (arg_309_1.time_ - 0) / var_312_3)))
							else
								local var_312_4 = Mathf.Lerp(iter_312_2.color.r, 1, (arg_309_1.time_ - 0) / var_312_3)

								iter_312_2.color = Color.New(var_312_4, var_312_4, var_312_4)
							end
						end
					end
				end
			end

			if arg_309_1.time_ >= 0 + var_312_3 and arg_309_1.time_ < 0 + var_312_3 + arg_312_0 and not isNil(var_312_2) and arg_309_1.var_.actorSpriteComps1061 then
				for iter_312_3, iter_312_4 in pairs(arg_309_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_312_4 then
						iter_312_4.color = arg_309_1.isInRecall_ and (arg_309_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_309_1.var_.actorSpriteComps1061 = nil
			end

			local var_312_5 = 0
			local var_312_6 = 0.3

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= var_312_5 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				arg_309_1.leftNameTxt_.text = arg_309_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_7 = arg_309_1:GetWordFromCfg(410161075)
				local var_312_8 = arg_309_1:FormatText(var_312_7.content)

				arg_309_1.text_.text = var_312_8

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_10 = 12 <= 0 and var_312_6 or var_312_6 * (utf8.len(var_312_8) / 12)

				if (12 <= 0 and var_312_6 or var_312_6 * (utf8.len(var_312_8) / 12)) > 0 and var_312_6 < var_312_10 then
					arg_309_1.talkMaxDuration = var_312_10

					if var_312_10 + var_312_5 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_10 + var_312_5
					end
				end

				arg_309_1.text_.text = var_312_8
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161075", "story_v_out_410161.awb") ~= 0 then
					local var_312_11 = manager.audio:GetVoiceLength("story_v_out_410161", "410161075", "story_v_out_410161.awb") / 1000

					if var_312_11 + var_312_5 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_11 + var_312_5
					end

					if var_312_7.prefab_name ~= "" and arg_309_1.actors_[var_312_7.prefab_name] ~= nil then
						local var_312_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_309_1.actors_[var_312_7.prefab_name].transform, "story_v_out_410161", "410161075", "story_v_out_410161.awb")

						arg_309_1:RecordAudio("410161075", var_312_12)
						arg_309_1:RecordAudio("410161075", var_312_12)
					else
						arg_309_1:AudioAction("play", "voice", "story_v_out_410161", "410161075", "story_v_out_410161.awb")
					end

					arg_309_1:RecordHistoryTalkVoice("story_v_out_410161", "410161075", "story_v_out_410161.awb")
				end

				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_13 = math.max(var_312_6, arg_309_1.talkMaxDuration)

			if var_312_5 <= arg_309_1.time_ and arg_309_1.time_ < var_312_5 + var_312_13 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_5) / var_312_13

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_5 + var_312_13 and arg_309_1.time_ < var_312_5 + var_312_13 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_309_1:InitPlayNodeList()
	end,
	Play410161076 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 410161076
		arg_313_1.duration_ = 6.93

		local var_313_0 = {
			ja = 6.933,
			CriLanguages = 6.666,
			zh = 6.666
		}
		local var_313_1 = manager.audio:GetLocalizationFlag()

		if var_313_0[var_313_1] ~= nil then
			arg_313_1.duration_ = var_313_0[var_313_1]
		end

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play410161077(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			if arg_313_1.bgs_.ST63 == nil then
				local var_316_0 = Object.Instantiate(arg_313_1.paintGo_)

				var_316_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST63")
				var_316_0.name = "ST63"
				var_316_0.transform.parent = arg_313_1.stage_.transform
				var_316_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_313_1.bgs_.ST63 = var_316_0
			end

			if 2 < arg_313_1.time_ and arg_313_1.time_ <= 2 + arg_316_0 then
				local var_316_1 = arg_313_1.bgs_.ST63

				arg_313_1.bgs_.ST63.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_316_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_316_2 = var_316_1:GetComponent("SpriteRenderer")

				if var_316_2 and var_316_2.sprite then
					local var_316_3 = 2 * (var_316_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_316_1.transform.localScale = Vector3.New(var_316_3 / var_316_2.sprite.bounds.size.y < var_316_3 * manager.ui.mainCameraCom_.aspect / var_316_2.sprite.bounds.size.x and var_316_3 * manager.ui.mainCameraCom_.aspect / var_316_2.sprite.bounds.size.x or var_316_3 / var_316_2.sprite.bounds.size.y, var_316_3 / var_316_2.sprite.bounds.size.y < var_316_3 * manager.ui.mainCameraCom_.aspect / var_316_2.sprite.bounds.size.x and var_316_3 * manager.ui.mainCameraCom_.aspect / var_316_2.sprite.bounds.size.x or var_316_3 / var_316_2.sprite.bounds.size.y, 0)
				end

				for iter_316_0, iter_316_1 in pairs(arg_313_1.bgs_) do
					if iter_316_0 ~= "ST63" then
						iter_316_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_316_4 = 0

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_4 + arg_316_0 then
				arg_313_1.mask_.enabled = true
				arg_313_1.mask_.raycastTarget = true

				arg_313_1:SetGaussion(false)
			end

			local var_316_5 = 2

			if var_316_4 <= arg_313_1.time_ and arg_313_1.time_ < var_316_4 + var_316_5 then
				local var_316_6 = Color.New(0, 0, 0)

				var_316_6.a = Mathf.Lerp(0, 1, (arg_313_1.time_ - var_316_4) / var_316_5)
				arg_313_1.mask_.color = var_316_6
			end

			if arg_313_1.time_ >= var_316_4 + var_316_5 and arg_313_1.time_ < var_316_4 + var_316_5 + arg_316_0 then
				local var_316_7 = Color.New(0, 0, 0)

				var_316_7.a = 1
				arg_313_1.mask_.color = var_316_7
			end

			local var_316_8 = 2

			if 2 < arg_313_1.time_ and arg_313_1.time_ <= var_316_8 + arg_316_0 then
				arg_313_1.mask_.enabled = true
				arg_313_1.mask_.raycastTarget = true

				arg_313_1:SetGaussion(false)
			end

			local var_316_9 = 2

			if var_316_8 <= arg_313_1.time_ and arg_313_1.time_ < var_316_8 + var_316_9 then
				local var_316_10 = Color.New(0, 0, 0)

				var_316_10.a = Mathf.Lerp(1, 0, (arg_313_1.time_ - var_316_8) / var_316_9)
				arg_313_1.mask_.color = var_316_10
			end

			if arg_313_1.time_ >= var_316_8 + var_316_9 and arg_313_1.time_ < var_316_8 + var_316_9 + arg_316_0 then
				local var_316_11 = Color.New(0, 0, 0)

				arg_313_1.mask_.enabled = false
				var_316_11.a = 0
				arg_313_1.mask_.color = var_316_11
			end

			local var_316_12 = arg_313_1.actors_["10059"].transform

			if 2 < arg_313_1.time_ and arg_313_1.time_ <= 2 + arg_316_0 then
				arg_313_1.var_.moveOldPos10059 = var_316_12.localPosition
				var_316_12.localScale = Vector3.New(1, 1, 1)

				arg_313_1:CheckSpriteTmpPos("10059", 7)

				for iter_316_2 = 0, var_316_12.childCount - 1 do
					local var_316_13 = var_316_12:GetChild(iter_316_2)

					if var_316_13.name == "" or not string.find(var_316_13.name, "split") then
						var_316_13.gameObject:SetActive(true)
					else
						var_316_13.gameObject:SetActive(false)
					end
				end
			end

			local var_316_14 = 0.001

			if 2 <= arg_313_1.time_ and arg_313_1.time_ < 2 + var_316_14 then
				var_316_12.localPosition = Vector3.Lerp(arg_313_1.var_.moveOldPos10059, Vector3.New(0, -2000, 35), (arg_313_1.time_ - 2) / var_316_14)
			end

			if arg_313_1.time_ >= 2 + var_316_14 and arg_313_1.time_ < 2 + var_316_14 + arg_316_0 then
				var_316_12.localPosition = Vector3.New(0, -2000, 35)
			end

			local var_316_15 = arg_313_1.actors_["1061"].transform

			if 2 < arg_313_1.time_ and arg_313_1.time_ <= 2 + arg_316_0 then
				arg_313_1.var_.moveOldPos1061 = var_316_15.localPosition
				var_316_15.localScale = Vector3.New(1, 1, 1)

				arg_313_1:CheckSpriteTmpPos("1061", 7)

				for iter_316_3 = 0, var_316_15.childCount - 1 do
					local var_316_16 = var_316_15:GetChild(iter_316_3)

					if var_316_16.name == "" or not string.find(var_316_16.name, "split") then
						var_316_16.gameObject:SetActive(true)
					else
						var_316_16.gameObject:SetActive(false)
					end
				end
			end

			local var_316_17 = 0.001

			if 2 <= arg_313_1.time_ and arg_313_1.time_ < 2 + var_316_17 then
				var_316_15.localPosition = Vector3.Lerp(arg_313_1.var_.moveOldPos1061, Vector3.New(0, -2000, 18), (arg_313_1.time_ - 2) / var_316_17)
			end

			if arg_313_1.time_ >= 2 + var_316_17 and arg_313_1.time_ < 2 + var_316_17 + arg_316_0 then
				var_316_15.localPosition = Vector3.New(0, -2000, 18)
			end

			local var_316_18 = arg_313_1.actors_["10059"]

			if 4 < arg_313_1.time_ and arg_313_1.time_ <= 4 + arg_316_0 and not isNil(var_316_18) and arg_313_1.var_.actorSpriteComps10059 == nil then
				arg_313_1.var_.actorSpriteComps10059 = var_316_18:GetComponentsInChildren(typeof(Image), true)
			end

			local var_316_19 = 0.034

			if 4 <= arg_313_1.time_ and arg_313_1.time_ < 4 + var_316_19 and not isNil(var_316_18) then
				if arg_313_1.var_.actorSpriteComps10059 then
					for iter_316_4, iter_316_5 in pairs(arg_313_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_316_5 then
							if arg_313_1.isInRecall_ then
								iter_316_5.color = Color.New(Mathf.Lerp(iter_316_5.color.r, arg_313_1.hightColor1.r, (arg_313_1.time_ - 4) / var_316_19), Mathf.Lerp(iter_316_5.color.g, arg_313_1.hightColor1.g, (arg_313_1.time_ - 4) / var_316_19), (Mathf.Lerp(iter_316_5.color.b, arg_313_1.hightColor1.b, (arg_313_1.time_ - 4) / var_316_19)))
							else
								local var_316_20 = Mathf.Lerp(iter_316_5.color.r, 1, (arg_313_1.time_ - 4) / var_316_19)

								iter_316_5.color = Color.New(var_316_20, var_316_20, var_316_20)
							end
						end
					end
				end
			end

			if arg_313_1.time_ >= 4 + var_316_19 and arg_313_1.time_ < 4 + var_316_19 + arg_316_0 and not isNil(var_316_18) and arg_313_1.var_.actorSpriteComps10059 then
				for iter_316_6, iter_316_7 in pairs(arg_313_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_316_7 then
						iter_316_7.color = arg_313_1.isInRecall_ and (arg_313_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_313_1.var_.actorSpriteComps10059 = nil
			end

			local var_316_21 = arg_313_1.actors_["1061"]

			if 2 < arg_313_1.time_ and arg_313_1.time_ <= 2 + arg_316_0 and not isNil(var_316_21) and arg_313_1.var_.actorSpriteComps1061 == nil then
				arg_313_1.var_.actorSpriteComps1061 = var_316_21:GetComponentsInChildren(typeof(Image), true)
			end

			local var_316_22 = 0.034

			if 2 <= arg_313_1.time_ and arg_313_1.time_ < 2 + var_316_22 and not isNil(var_316_21) then
				if arg_313_1.var_.actorSpriteComps1061 then
					for iter_316_8, iter_316_9 in pairs(arg_313_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_316_9 then
							if arg_313_1.isInRecall_ then
								iter_316_9.color = Color.New(Mathf.Lerp(iter_316_9.color.r, arg_313_1.hightColor2.r, (arg_313_1.time_ - 2) / var_316_22), Mathf.Lerp(iter_316_9.color.g, arg_313_1.hightColor2.g, (arg_313_1.time_ - 2) / var_316_22), (Mathf.Lerp(iter_316_9.color.b, arg_313_1.hightColor2.b, (arg_313_1.time_ - 2) / var_316_22)))
							else
								local var_316_23 = Mathf.Lerp(iter_316_9.color.r, 0.5, (arg_313_1.time_ - 2) / var_316_22)

								iter_316_9.color = Color.New(var_316_23, var_316_23, var_316_23)
							end
						end
					end
				end
			end

			if arg_313_1.time_ >= 2 + var_316_22 and arg_313_1.time_ < 2 + var_316_22 + arg_316_0 and not isNil(var_316_21) and arg_313_1.var_.actorSpriteComps1061 then
				for iter_316_10, iter_316_11 in pairs(arg_313_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_316_11 then
						iter_316_11.color = arg_313_1.isInRecall_ and (arg_313_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_313_1.var_.actorSpriteComps1061 = nil
			end

			local var_316_24 = arg_313_1.actors_["10059"].transform

			if 4 < arg_313_1.time_ and arg_313_1.time_ <= 4 + arg_316_0 then
				arg_313_1.var_.moveOldPos10059 = var_316_24.localPosition
				var_316_24.localScale = Vector3.New(1, 1, 1)

				arg_313_1:CheckSpriteTmpPos("10059", 3)

				for iter_316_12 = 0, var_316_24.childCount - 1 do
					local var_316_25 = var_316_24:GetChild(iter_316_12)

					if var_316_25.name == "" or not string.find(var_316_25.name, "split") then
						var_316_25.gameObject:SetActive(true)
					else
						var_316_25.gameObject:SetActive(false)
					end
				end
			end

			local var_316_26 = 0.001

			if 4 <= arg_313_1.time_ and arg_313_1.time_ < 4 + var_316_26 then
				var_316_24.localPosition = Vector3.Lerp(arg_313_1.var_.moveOldPos10059, Vector3.New(0, -530, 35), (arg_313_1.time_ - 4) / var_316_26)
			end

			if arg_313_1.time_ >= 4 + var_316_26 and arg_313_1.time_ < 4 + var_316_26 + arg_316_0 then
				var_316_24.localPosition = Vector3.New(0, -530, 35)
			end

			if arg_313_1.frameCnt_ <= 1 then
				arg_313_1.dialog_:SetActive(false)
			end

			local var_316_27 = 4
			local var_316_28 = 0.325

			if 4 < arg_313_1.time_ and arg_313_1.time_ <= var_316_27 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0

				arg_313_1.dialog_:SetActive(true)

				arg_313_1.dialogCg_.alpha = 0

				local var_316_29 = LeanTween.value(arg_313_1.dialog_, 0, 1, 0.3)

				var_316_29:setOnUpdate(LuaHelper.FloatAction(function(arg_317_0)
					arg_313_1.dialogCg_.alpha = arg_317_0
				end))
				var_316_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_313_1.dialog_)
					var_316_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_313_1.duration_ = arg_313_1.duration_ + 0.3

				SetActive(arg_313_1.leftNameGo_, true)

				arg_313_1.leftNameTxt_.text = arg_313_1:FormatText(StoryNameCfg[596].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_30 = arg_313_1:GetWordFromCfg(410161076)
				local var_316_31 = arg_313_1:FormatText(var_316_30.content)

				arg_313_1.text_.text = var_316_31

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_33 = 13 <= 0 and var_316_28 or var_316_28 * (utf8.len(var_316_31) / 13)

				if (13 <= 0 and var_316_28 or var_316_28 * (utf8.len(var_316_31) / 13)) > 0 and var_316_28 < var_316_33 then
					arg_313_1.talkMaxDuration = var_316_33
					var_316_27 = var_316_27 + 0.3

					if var_316_33 + var_316_27 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_33 + var_316_27
					end
				end

				arg_313_1.text_.text = var_316_31
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161076", "story_v_out_410161.awb") ~= 0 then
					local var_316_34 = manager.audio:GetVoiceLength("story_v_out_410161", "410161076", "story_v_out_410161.awb") / 1000

					if var_316_34 + var_316_27 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_34 + var_316_27
					end

					if var_316_30.prefab_name ~= "" and arg_313_1.actors_[var_316_30.prefab_name] ~= nil then
						local var_316_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_30.prefab_name].transform, "story_v_out_410161", "410161076", "story_v_out_410161.awb")

						arg_313_1:RecordAudio("410161076", var_316_35)
						arg_313_1:RecordAudio("410161076", var_316_35)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_out_410161", "410161076", "story_v_out_410161.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_out_410161", "410161076", "story_v_out_410161.awb")
				end

				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_36 = var_316_27 + 0.3
			local var_316_37 = math.max(var_316_28, arg_313_1.talkMaxDuration)

			if var_316_27 + 0.3 <= arg_313_1.time_ and arg_313_1.time_ < var_316_36 + var_316_37 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_36) / var_316_37

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_36 + var_316_37 and arg_313_1.time_ < var_316_36 + var_316_37 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_313_1:InitPlayNodeList()
	end,
	Play410161077 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 410161077
		arg_319_1.duration_ = 5

		SetActive(arg_319_1.tipsGo_, false)

		function arg_319_1.onSingleLineFinish_()
			arg_319_1.onSingleLineUpdate_ = nil
			arg_319_1.onSingleLineFinish_ = nil
			arg_319_1.state_ = "waiting"
		end

		function arg_319_1.playNext_(arg_321_0)
			if arg_321_0 == 1 then
				arg_319_0:Play410161078(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 and not isNil(arg_319_1.actors_["10059"]) and arg_319_1.var_.actorSpriteComps10059 == nil then
				arg_319_1.var_.actorSpriteComps10059 = arg_319_1.actors_["10059"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_322_0 = 0.034

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_0 and not isNil(arg_319_1.actors_["10059"]) then
				if arg_319_1.var_.actorSpriteComps10059 then
					for iter_322_0, iter_322_1 in pairs(arg_319_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_322_1 then
							if arg_319_1.isInRecall_ then
								iter_322_1.color = Color.New(Mathf.Lerp(iter_322_1.color.r, arg_319_1.hightColor2.r, (arg_319_1.time_ - 0) / var_322_0), Mathf.Lerp(iter_322_1.color.g, arg_319_1.hightColor2.g, (arg_319_1.time_ - 0) / var_322_0), (Mathf.Lerp(iter_322_1.color.b, arg_319_1.hightColor2.b, (arg_319_1.time_ - 0) / var_322_0)))
							else
								local var_322_1 = Mathf.Lerp(iter_322_1.color.r, 0.5, (arg_319_1.time_ - 0) / var_322_0)

								iter_322_1.color = Color.New(var_322_1, var_322_1, var_322_1)
							end
						end
					end
				end
			end

			if arg_319_1.time_ >= 0 + var_322_0 and arg_319_1.time_ < 0 + var_322_0 + arg_322_0 and not isNil(arg_319_1.actors_["10059"]) and arg_319_1.var_.actorSpriteComps10059 then
				for iter_322_2, iter_322_3 in pairs(arg_319_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_322_3 then
						iter_322_3.color = arg_319_1.isInRecall_ and (arg_319_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_319_1.var_.actorSpriteComps10059 = nil
			end

			local var_322_2 = 0
			local var_322_3 = 1.35

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= var_322_2 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, false)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_4 = arg_319_1:FormatText(arg_319_1:GetWordFromCfg(410161077).content)

				arg_319_1.text_.text = var_322_4

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_6 = 54 <= 0 and var_322_3 or var_322_3 * (utf8.len(var_322_4) / 54)

				if (54 <= 0 and var_322_3 or var_322_3 * (utf8.len(var_322_4) / 54)) > 0 and var_322_3 < var_322_6 then
					arg_319_1.talkMaxDuration = var_322_6

					if var_322_6 + var_322_2 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_6 + var_322_2
					end
				end

				arg_319_1.text_.text = var_322_4
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)
				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_7 = math.max(var_322_3, arg_319_1.talkMaxDuration)

			if var_322_2 <= arg_319_1.time_ and arg_319_1.time_ < var_322_2 + var_322_7 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_2) / var_322_7

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_2 + var_322_7 and arg_319_1.time_ < var_322_2 + var_322_7 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {}

		arg_319_1:InitPlayNodeList()
	end,
	Play410161078 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 410161078
		arg_323_1.duration_ = 15.4

		local var_323_0 = {
			ja = 15.4,
			CriLanguages = 11.2,
			zh = 11.2
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
				arg_323_0:Play410161079(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1.var_.moveOldPos10059 = arg_323_1.actors_["10059"].transform.localPosition
				arg_323_1.actors_["10059"].transform.localScale = Vector3.New(1, 1, 1)

				arg_323_1:CheckSpriteTmpPos("10059", 3)

				for iter_326_0 = 0, arg_323_1.actors_["10059"].transform.childCount - 1 do
					local var_326_0 = arg_323_1.actors_["10059"].transform:GetChild(iter_326_0)

					if var_326_0.name == "" or not string.find(var_326_0.name, "split") then
						var_326_0.gameObject:SetActive(true)
					else
						var_326_0.gameObject:SetActive(false)
					end
				end
			end

			local var_326_1 = 0.001

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_1 then
				arg_323_1.actors_["10059"].transform.localPosition = Vector3.Lerp(arg_323_1.var_.moveOldPos10059, Vector3.New(0, -530, 35), (arg_323_1.time_ - 0) / var_326_1)
			end

			if arg_323_1.time_ >= 0 + var_326_1 and arg_323_1.time_ < 0 + var_326_1 + arg_326_0 then
				arg_323_1.actors_["10059"].transform.localPosition = Vector3.New(0, -530, 35)
			end

			local var_326_2 = arg_323_1.actors_["10059"]

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 and not isNil(var_326_2) and arg_323_1.var_.actorSpriteComps10059 == nil then
				arg_323_1.var_.actorSpriteComps10059 = var_326_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_326_3 = 0.034

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_3 and not isNil(var_326_2) then
				if arg_323_1.var_.actorSpriteComps10059 then
					for iter_326_1, iter_326_2 in pairs(arg_323_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_326_2 then
							if arg_323_1.isInRecall_ then
								iter_326_2.color = Color.New(Mathf.Lerp(iter_326_2.color.r, arg_323_1.hightColor1.r, (arg_323_1.time_ - 0) / var_326_3), Mathf.Lerp(iter_326_2.color.g, arg_323_1.hightColor1.g, (arg_323_1.time_ - 0) / var_326_3), (Mathf.Lerp(iter_326_2.color.b, arg_323_1.hightColor1.b, (arg_323_1.time_ - 0) / var_326_3)))
							else
								local var_326_4 = Mathf.Lerp(iter_326_2.color.r, 1, (arg_323_1.time_ - 0) / var_326_3)

								iter_326_2.color = Color.New(var_326_4, var_326_4, var_326_4)
							end
						end
					end
				end
			end

			if arg_323_1.time_ >= 0 + var_326_3 and arg_323_1.time_ < 0 + var_326_3 + arg_326_0 and not isNil(var_326_2) and arg_323_1.var_.actorSpriteComps10059 then
				for iter_326_3, iter_326_4 in pairs(arg_323_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_326_4 then
						iter_326_4.color = arg_323_1.isInRecall_ and (arg_323_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_323_1.var_.actorSpriteComps10059 = nil
			end

			local var_326_5 = 0
			local var_326_6 = 1.25

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= var_326_5 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				arg_323_1.leftNameTxt_.text = arg_323_1:FormatText(StoryNameCfg[596].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_7 = arg_323_1:GetWordFromCfg(410161078)
				local var_326_8 = arg_323_1:FormatText(var_326_7.content)

				arg_323_1.text_.text = var_326_8

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_10 = 50 <= 0 and var_326_6 or var_326_6 * (utf8.len(var_326_8) / 50)

				if (50 <= 0 and var_326_6 or var_326_6 * (utf8.len(var_326_8) / 50)) > 0 and var_326_6 < var_326_10 then
					arg_323_1.talkMaxDuration = var_326_10

					if var_326_10 + var_326_5 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_10 + var_326_5
					end
				end

				arg_323_1.text_.text = var_326_8
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161078", "story_v_out_410161.awb") ~= 0 then
					local var_326_11 = manager.audio:GetVoiceLength("story_v_out_410161", "410161078", "story_v_out_410161.awb") / 1000

					if var_326_11 + var_326_5 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_11 + var_326_5
					end

					if var_326_7.prefab_name ~= "" and arg_323_1.actors_[var_326_7.prefab_name] ~= nil then
						local var_326_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_323_1.actors_[var_326_7.prefab_name].transform, "story_v_out_410161", "410161078", "story_v_out_410161.awb")

						arg_323_1:RecordAudio("410161078", var_326_12)
						arg_323_1:RecordAudio("410161078", var_326_12)
					else
						arg_323_1:AudioAction("play", "voice", "story_v_out_410161", "410161078", "story_v_out_410161.awb")
					end

					arg_323_1:RecordHistoryTalkVoice("story_v_out_410161", "410161078", "story_v_out_410161.awb")
				end

				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_13 = math.max(var_326_6, arg_323_1.talkMaxDuration)

			if var_326_5 <= arg_323_1.time_ and arg_323_1.time_ < var_326_5 + var_326_13 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_5) / var_326_13

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_5 + var_326_13 and arg_323_1.time_ < var_326_5 + var_326_13 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
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
	Play410161079 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 410161079
		arg_327_1.duration_ = 3.33

		local var_327_0 = {
			ja = 3.133,
			CriLanguages = 3.333,
			zh = 3.333
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
				arg_327_0:Play410161080(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 then
				arg_327_1.var_.moveOldPos10059 = arg_327_1.actors_["10059"].transform.localPosition
				arg_327_1.actors_["10059"].transform.localScale = Vector3.New(1, 1, 1)

				arg_327_1:CheckSpriteTmpPos("10059", 3)

				for iter_330_0 = 0, arg_327_1.actors_["10059"].transform.childCount - 1 do
					local var_330_0 = arg_327_1.actors_["10059"].transform:GetChild(iter_330_0)

					if var_330_0.name == "" or not string.find(var_330_0.name, "split") then
						var_330_0.gameObject:SetActive(true)
					else
						var_330_0.gameObject:SetActive(false)
					end
				end
			end

			local var_330_1 = 0.001

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_1 then
				arg_327_1.actors_["10059"].transform.localPosition = Vector3.Lerp(arg_327_1.var_.moveOldPos10059, Vector3.New(0, -530, 35), (arg_327_1.time_ - 0) / var_330_1)
			end

			if arg_327_1.time_ >= 0 + var_330_1 and arg_327_1.time_ < 0 + var_330_1 + arg_330_0 then
				arg_327_1.actors_["10059"].transform.localPosition = Vector3.New(0, -530, 35)
			end

			local var_330_2 = arg_327_1.actors_["10059"]

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 and not isNil(var_330_2) and arg_327_1.var_.actorSpriteComps10059 == nil then
				arg_327_1.var_.actorSpriteComps10059 = var_330_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_330_3 = 0.034

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_3 and not isNil(var_330_2) then
				if arg_327_1.var_.actorSpriteComps10059 then
					for iter_330_1, iter_330_2 in pairs(arg_327_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_330_2 then
							if arg_327_1.isInRecall_ then
								iter_330_2.color = Color.New(Mathf.Lerp(iter_330_2.color.r, arg_327_1.hightColor1.r, (arg_327_1.time_ - 0) / var_330_3), Mathf.Lerp(iter_330_2.color.g, arg_327_1.hightColor1.g, (arg_327_1.time_ - 0) / var_330_3), (Mathf.Lerp(iter_330_2.color.b, arg_327_1.hightColor1.b, (arg_327_1.time_ - 0) / var_330_3)))
							else
								local var_330_4 = Mathf.Lerp(iter_330_2.color.r, 1, (arg_327_1.time_ - 0) / var_330_3)

								iter_330_2.color = Color.New(var_330_4, var_330_4, var_330_4)
							end
						end
					end
				end
			end

			if arg_327_1.time_ >= 0 + var_330_3 and arg_327_1.time_ < 0 + var_330_3 + arg_330_0 and not isNil(var_330_2) and arg_327_1.var_.actorSpriteComps10059 then
				for iter_330_3, iter_330_4 in pairs(arg_327_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_330_4 then
						iter_330_4.color = arg_327_1.isInRecall_ and (arg_327_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_327_1.var_.actorSpriteComps10059 = nil
			end

			local var_330_5 = 0
			local var_330_6 = 0.275

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= var_330_5 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, true)

				arg_327_1.leftNameTxt_.text = arg_327_1:FormatText(StoryNameCfg[596].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_327_1.leftNameTxt_.transform)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1.leftNameTxt_.text)
				SetActive(arg_327_1.iconTrs_.gameObject, false)
				arg_327_1.callingController_:SetSelectedState("normal")

				local var_330_7 = arg_327_1:GetWordFromCfg(410161079)
				local var_330_8 = arg_327_1:FormatText(var_330_7.content)

				arg_327_1.text_.text = var_330_8

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_10 = 11 <= 0 and var_330_6 or var_330_6 * (utf8.len(var_330_8) / 11)

				if (11 <= 0 and var_330_6 or var_330_6 * (utf8.len(var_330_8) / 11)) > 0 and var_330_6 < var_330_10 then
					arg_327_1.talkMaxDuration = var_330_10

					if var_330_10 + var_330_5 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_10 + var_330_5
					end
				end

				arg_327_1.text_.text = var_330_8
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161079", "story_v_out_410161.awb") ~= 0 then
					local var_330_11 = manager.audio:GetVoiceLength("story_v_out_410161", "410161079", "story_v_out_410161.awb") / 1000

					if var_330_11 + var_330_5 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_11 + var_330_5
					end

					if var_330_7.prefab_name ~= "" and arg_327_1.actors_[var_330_7.prefab_name] ~= nil then
						local var_330_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_327_1.actors_[var_330_7.prefab_name].transform, "story_v_out_410161", "410161079", "story_v_out_410161.awb")

						arg_327_1:RecordAudio("410161079", var_330_12)
						arg_327_1:RecordAudio("410161079", var_330_12)
					else
						arg_327_1:AudioAction("play", "voice", "story_v_out_410161", "410161079", "story_v_out_410161.awb")
					end

					arg_327_1:RecordHistoryTalkVoice("story_v_out_410161", "410161079", "story_v_out_410161.awb")
				end

				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_13 = math.max(var_330_6, arg_327_1.talkMaxDuration)

			if var_330_5 <= arg_327_1.time_ and arg_327_1.time_ < var_330_5 + var_330_13 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_5) / var_330_13

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_5 + var_330_13 and arg_327_1.time_ < var_330_5 + var_330_13 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_327_1:InitPlayNodeList()
	end,
	Play410161080 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 410161080
		arg_331_1.duration_ = 12.57

		local var_331_0 = {
			ja = 12.566,
			CriLanguages = 4.5,
			zh = 4.5
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
				arg_331_0:Play410161081(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 then
				arg_331_1.var_.moveOldPos1061 = arg_331_1.actors_["1061"].transform.localPosition
				arg_331_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_331_1:CheckSpriteTmpPos("1061", 2)

				for iter_334_0 = 0, arg_331_1.actors_["1061"].transform.childCount - 1 do
					local var_334_0 = arg_331_1.actors_["1061"].transform:GetChild(iter_334_0)

					if var_334_0.name == "" or not string.find(var_334_0.name, "split") then
						var_334_0.gameObject:SetActive(true)
					else
						var_334_0.gameObject:SetActive(false)
					end
				end
			end

			local var_334_1 = 0.001

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_1 then
				arg_331_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_331_1.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (arg_331_1.time_ - 0) / var_334_1)
			end

			if arg_331_1.time_ >= 0 + var_334_1 and arg_331_1.time_ < 0 + var_334_1 + arg_334_0 then
				arg_331_1.actors_["1061"].transform.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_334_2 = arg_331_1.actors_["10059"].transform

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 then
				arg_331_1.var_.moveOldPos10059 = var_334_2.localPosition
				var_334_2.localScale = Vector3.New(1, 1, 1)

				arg_331_1:CheckSpriteTmpPos("10059", 4)

				for iter_334_1 = 0, var_334_2.childCount - 1 do
					local var_334_3 = var_334_2:GetChild(iter_334_1)

					if var_334_3.name == "" or not string.find(var_334_3.name, "split") then
						var_334_3.gameObject:SetActive(true)
					else
						var_334_3.gameObject:SetActive(false)
					end
				end
			end

			local var_334_4 = 0.001

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_4 then
				var_334_2.localPosition = Vector3.Lerp(arg_331_1.var_.moveOldPos10059, Vector3.New(390, -530, 35), (arg_331_1.time_ - 0) / var_334_4)
			end

			if arg_331_1.time_ >= 0 + var_334_4 and arg_331_1.time_ < 0 + var_334_4 + arg_334_0 then
				var_334_2.localPosition = Vector3.New(390, -530, 35)
			end

			local var_334_5 = arg_331_1.actors_["1061"]

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 and not isNil(var_334_5) and arg_331_1.var_.actorSpriteComps1061 == nil then
				arg_331_1.var_.actorSpriteComps1061 = var_334_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_334_6 = 0.034

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_6 and not isNil(var_334_5) then
				if arg_331_1.var_.actorSpriteComps1061 then
					for iter_334_2, iter_334_3 in pairs(arg_331_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_334_3 then
							if arg_331_1.isInRecall_ then
								iter_334_3.color = Color.New(Mathf.Lerp(iter_334_3.color.r, arg_331_1.hightColor1.r, (arg_331_1.time_ - 0) / var_334_6), Mathf.Lerp(iter_334_3.color.g, arg_331_1.hightColor1.g, (arg_331_1.time_ - 0) / var_334_6), (Mathf.Lerp(iter_334_3.color.b, arg_331_1.hightColor1.b, (arg_331_1.time_ - 0) / var_334_6)))
							else
								local var_334_7 = Mathf.Lerp(iter_334_3.color.r, 1, (arg_331_1.time_ - 0) / var_334_6)

								iter_334_3.color = Color.New(var_334_7, var_334_7, var_334_7)
							end
						end
					end
				end
			end

			if arg_331_1.time_ >= 0 + var_334_6 and arg_331_1.time_ < 0 + var_334_6 + arg_334_0 and not isNil(var_334_5) and arg_331_1.var_.actorSpriteComps1061 then
				for iter_334_4, iter_334_5 in pairs(arg_331_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_334_5 then
						iter_334_5.color = arg_331_1.isInRecall_ and (arg_331_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_331_1.var_.actorSpriteComps1061 = nil
			end

			local var_334_8 = arg_331_1.actors_["10059"]

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 and not isNil(var_334_8) and arg_331_1.var_.actorSpriteComps10059 == nil then
				arg_331_1.var_.actorSpriteComps10059 = var_334_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_334_9 = 0.034

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_9 and not isNil(var_334_8) then
				if arg_331_1.var_.actorSpriteComps10059 then
					for iter_334_6, iter_334_7 in pairs(arg_331_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_334_7 then
							if arg_331_1.isInRecall_ then
								iter_334_7.color = Color.New(Mathf.Lerp(iter_334_7.color.r, arg_331_1.hightColor2.r, (arg_331_1.time_ - 0) / var_334_9), Mathf.Lerp(iter_334_7.color.g, arg_331_1.hightColor2.g, (arg_331_1.time_ - 0) / var_334_9), (Mathf.Lerp(iter_334_7.color.b, arg_331_1.hightColor2.b, (arg_331_1.time_ - 0) / var_334_9)))
							else
								local var_334_10 = Mathf.Lerp(iter_334_7.color.r, 0.5, (arg_331_1.time_ - 0) / var_334_9)

								iter_334_7.color = Color.New(var_334_10, var_334_10, var_334_10)
							end
						end
					end
				end
			end

			if arg_331_1.time_ >= 0 + var_334_9 and arg_331_1.time_ < 0 + var_334_9 + arg_334_0 and not isNil(var_334_8) and arg_331_1.var_.actorSpriteComps10059 then
				for iter_334_8, iter_334_9 in pairs(arg_331_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_334_9 then
						iter_334_9.color = arg_331_1.isInRecall_ and (arg_331_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_331_1.var_.actorSpriteComps10059 = nil
			end

			local var_334_11 = 0
			local var_334_12 = 0.5

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= var_334_11 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, true)

				arg_331_1.leftNameTxt_.text = arg_331_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_331_1.leftNameTxt_.transform)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1.leftNameTxt_.text)
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_13 = arg_331_1:GetWordFromCfg(410161080)
				local var_334_14 = arg_331_1:FormatText(var_334_13.content)

				arg_331_1.text_.text = var_334_14

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_16 = 20 <= 0 and var_334_12 or var_334_12 * (utf8.len(var_334_14) / 20)

				if (20 <= 0 and var_334_12 or var_334_12 * (utf8.len(var_334_14) / 20)) > 0 and var_334_12 < var_334_16 then
					arg_331_1.talkMaxDuration = var_334_16

					if var_334_16 + var_334_11 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_16 + var_334_11
					end
				end

				arg_331_1.text_.text = var_334_14
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161080", "story_v_out_410161.awb") ~= 0 then
					local var_334_17 = manager.audio:GetVoiceLength("story_v_out_410161", "410161080", "story_v_out_410161.awb") / 1000

					if var_334_17 + var_334_11 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_17 + var_334_11
					end

					if var_334_13.prefab_name ~= "" and arg_331_1.actors_[var_334_13.prefab_name] ~= nil then
						local var_334_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_331_1.actors_[var_334_13.prefab_name].transform, "story_v_out_410161", "410161080", "story_v_out_410161.awb")

						arg_331_1:RecordAudio("410161080", var_334_18)
						arg_331_1:RecordAudio("410161080", var_334_18)
					else
						arg_331_1:AudioAction("play", "voice", "story_v_out_410161", "410161080", "story_v_out_410161.awb")
					end

					arg_331_1:RecordHistoryTalkVoice("story_v_out_410161", "410161080", "story_v_out_410161.awb")
				end

				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_19 = math.max(var_334_12, arg_331_1.talkMaxDuration)

			if var_334_11 <= arg_331_1.time_ and arg_331_1.time_ < var_334_11 + var_334_19 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_11) / var_334_19

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_11 + var_334_19 and arg_331_1.time_ < var_334_11 + var_334_19 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_331_1:InitPlayNodeList()
	end,
	Play410161081 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 410161081
		arg_335_1.duration_ = 9.83

		local var_335_0 = {
			ja = 9.833,
			CriLanguages = 8,
			zh = 8
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
				arg_335_0:Play410161082(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				arg_335_1.var_.moveOldPos1061 = arg_335_1.actors_["1061"].transform.localPosition
				arg_335_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_335_1:CheckSpriteTmpPos("1061", 2)

				for iter_338_0 = 0, arg_335_1.actors_["1061"].transform.childCount - 1 do
					local var_338_0 = arg_335_1.actors_["1061"].transform:GetChild(iter_338_0)

					if var_338_0.name == "" or not string.find(var_338_0.name, "split") then
						var_338_0.gameObject:SetActive(true)
					else
						var_338_0.gameObject:SetActive(false)
					end
				end
			end

			local var_338_1 = 0.001

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_1 then
				arg_335_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_335_1.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (arg_335_1.time_ - 0) / var_338_1)
			end

			if arg_335_1.time_ >= 0 + var_338_1 and arg_335_1.time_ < 0 + var_338_1 + arg_338_0 then
				arg_335_1.actors_["1061"].transform.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_338_2 = arg_335_1.actors_["1061"]

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 and not isNil(var_338_2) and arg_335_1.var_.actorSpriteComps1061 == nil then
				arg_335_1.var_.actorSpriteComps1061 = var_338_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_338_3 = 0.034

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_3 and not isNil(var_338_2) then
				if arg_335_1.var_.actorSpriteComps1061 then
					for iter_338_1, iter_338_2 in pairs(arg_335_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_338_2 then
							if arg_335_1.isInRecall_ then
								iter_338_2.color = Color.New(Mathf.Lerp(iter_338_2.color.r, arg_335_1.hightColor1.r, (arg_335_1.time_ - 0) / var_338_3), Mathf.Lerp(iter_338_2.color.g, arg_335_1.hightColor1.g, (arg_335_1.time_ - 0) / var_338_3), (Mathf.Lerp(iter_338_2.color.b, arg_335_1.hightColor1.b, (arg_335_1.time_ - 0) / var_338_3)))
							else
								local var_338_4 = Mathf.Lerp(iter_338_2.color.r, 1, (arg_335_1.time_ - 0) / var_338_3)

								iter_338_2.color = Color.New(var_338_4, var_338_4, var_338_4)
							end
						end
					end
				end
			end

			if arg_335_1.time_ >= 0 + var_338_3 and arg_335_1.time_ < 0 + var_338_3 + arg_338_0 and not isNil(var_338_2) and arg_335_1.var_.actorSpriteComps1061 then
				for iter_338_3, iter_338_4 in pairs(arg_335_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_338_4 then
						iter_338_4.color = arg_335_1.isInRecall_ and (arg_335_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_335_1.var_.actorSpriteComps1061 = nil
			end

			local var_338_5 = 0
			local var_338_6 = 0.925

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= var_338_5 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				arg_335_1.leftNameTxt_.text = arg_335_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, false)
				arg_335_1.callingController_:SetSelectedState("normal")

				local var_338_7 = arg_335_1:GetWordFromCfg(410161081)
				local var_338_8 = arg_335_1:FormatText(var_338_7.content)

				arg_335_1.text_.text = var_338_8

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_10 = 37 <= 0 and var_338_6 or var_338_6 * (utf8.len(var_338_8) / 37)

				if (37 <= 0 and var_338_6 or var_338_6 * (utf8.len(var_338_8) / 37)) > 0 and var_338_6 < var_338_10 then
					arg_335_1.talkMaxDuration = var_338_10

					if var_338_10 + var_338_5 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_10 + var_338_5
					end
				end

				arg_335_1.text_.text = var_338_8
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161081", "story_v_out_410161.awb") ~= 0 then
					local var_338_11 = manager.audio:GetVoiceLength("story_v_out_410161", "410161081", "story_v_out_410161.awb") / 1000

					if var_338_11 + var_338_5 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_11 + var_338_5
					end

					if var_338_7.prefab_name ~= "" and arg_335_1.actors_[var_338_7.prefab_name] ~= nil then
						local var_338_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_335_1.actors_[var_338_7.prefab_name].transform, "story_v_out_410161", "410161081", "story_v_out_410161.awb")

						arg_335_1:RecordAudio("410161081", var_338_12)
						arg_335_1:RecordAudio("410161081", var_338_12)
					else
						arg_335_1:AudioAction("play", "voice", "story_v_out_410161", "410161081", "story_v_out_410161.awb")
					end

					arg_335_1:RecordHistoryTalkVoice("story_v_out_410161", "410161081", "story_v_out_410161.awb")
				end

				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_13 = math.max(var_338_6, arg_335_1.talkMaxDuration)

			if var_338_5 <= arg_335_1.time_ and arg_335_1.time_ < var_338_5 + var_338_13 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - var_338_5) / var_338_13

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= var_338_5 + var_338_13 and arg_335_1.time_ < var_338_5 + var_338_13 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
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
	Play410161082 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 410161082
		arg_339_1.duration_ = 13.2

		local var_339_0 = {
			ja = 13.2,
			CriLanguages = 12.533,
			zh = 12.533
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
				arg_339_0:Play410161083(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1.var_.moveOldPos1061 = arg_339_1.actors_["1061"].transform.localPosition
				arg_339_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_339_1:CheckSpriteTmpPos("1061", 2)

				for iter_342_0 = 0, arg_339_1.actors_["1061"].transform.childCount - 1 do
					local var_342_0 = arg_339_1.actors_["1061"].transform:GetChild(iter_342_0)

					if var_342_0.name == "" or not string.find(var_342_0.name, "split") then
						var_342_0.gameObject:SetActive(true)
					else
						var_342_0.gameObject:SetActive(false)
					end
				end
			end

			local var_342_1 = 0.001

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_1 then
				arg_339_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_339_1.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (arg_339_1.time_ - 0) / var_342_1)
			end

			if arg_339_1.time_ >= 0 + var_342_1 and arg_339_1.time_ < 0 + var_342_1 + arg_342_0 then
				arg_339_1.actors_["1061"].transform.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_342_2 = arg_339_1.actors_["1061"]

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 and not isNil(var_342_2) and arg_339_1.var_.actorSpriteComps1061 == nil then
				arg_339_1.var_.actorSpriteComps1061 = var_342_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_342_3 = 0.034

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_3 and not isNil(var_342_2) then
				if arg_339_1.var_.actorSpriteComps1061 then
					for iter_342_1, iter_342_2 in pairs(arg_339_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_342_2 then
							if arg_339_1.isInRecall_ then
								iter_342_2.color = Color.New(Mathf.Lerp(iter_342_2.color.r, arg_339_1.hightColor1.r, (arg_339_1.time_ - 0) / var_342_3), Mathf.Lerp(iter_342_2.color.g, arg_339_1.hightColor1.g, (arg_339_1.time_ - 0) / var_342_3), (Mathf.Lerp(iter_342_2.color.b, arg_339_1.hightColor1.b, (arg_339_1.time_ - 0) / var_342_3)))
							else
								local var_342_4 = Mathf.Lerp(iter_342_2.color.r, 1, (arg_339_1.time_ - 0) / var_342_3)

								iter_342_2.color = Color.New(var_342_4, var_342_4, var_342_4)
							end
						end
					end
				end
			end

			if arg_339_1.time_ >= 0 + var_342_3 and arg_339_1.time_ < 0 + var_342_3 + arg_342_0 and not isNil(var_342_2) and arg_339_1.var_.actorSpriteComps1061 then
				for iter_342_3, iter_342_4 in pairs(arg_339_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_342_4 then
						iter_342_4.color = arg_339_1.isInRecall_ and (arg_339_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_339_1.var_.actorSpriteComps1061 = nil
			end

			local var_342_5 = 0
			local var_342_6 = 1.425

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= var_342_5 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				arg_339_1.leftNameTxt_.text = arg_339_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, false)
				arg_339_1.callingController_:SetSelectedState("normal")

				local var_342_7 = arg_339_1:GetWordFromCfg(410161082)
				local var_342_8 = arg_339_1:FormatText(var_342_7.content)

				arg_339_1.text_.text = var_342_8

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_10 = 57 <= 0 and var_342_6 or var_342_6 * (utf8.len(var_342_8) / 57)

				if (57 <= 0 and var_342_6 or var_342_6 * (utf8.len(var_342_8) / 57)) > 0 and var_342_6 < var_342_10 then
					arg_339_1.talkMaxDuration = var_342_10

					if var_342_10 + var_342_5 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_10 + var_342_5
					end
				end

				arg_339_1.text_.text = var_342_8
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161082", "story_v_out_410161.awb") ~= 0 then
					local var_342_11 = manager.audio:GetVoiceLength("story_v_out_410161", "410161082", "story_v_out_410161.awb") / 1000

					if var_342_11 + var_342_5 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_11 + var_342_5
					end

					if var_342_7.prefab_name ~= "" and arg_339_1.actors_[var_342_7.prefab_name] ~= nil then
						local var_342_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_339_1.actors_[var_342_7.prefab_name].transform, "story_v_out_410161", "410161082", "story_v_out_410161.awb")

						arg_339_1:RecordAudio("410161082", var_342_12)
						arg_339_1:RecordAudio("410161082", var_342_12)
					else
						arg_339_1:AudioAction("play", "voice", "story_v_out_410161", "410161082", "story_v_out_410161.awb")
					end

					arg_339_1:RecordHistoryTalkVoice("story_v_out_410161", "410161082", "story_v_out_410161.awb")
				end

				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_13 = math.max(var_342_6, arg_339_1.talkMaxDuration)

			if var_342_5 <= arg_339_1.time_ and arg_339_1.time_ < var_342_5 + var_342_13 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_5) / var_342_13

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_5 + var_342_13 and arg_339_1.time_ < var_342_5 + var_342_13 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
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
	Play410161083 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 410161083
		arg_343_1.duration_ = 6.73

		local var_343_0 = {
			ja = 6.733,
			CriLanguages = 4.466,
			zh = 4.466
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
				arg_343_0:Play410161084(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 then
				arg_343_1.var_.moveOldPos10059 = arg_343_1.actors_["10059"].transform.localPosition
				arg_343_1.actors_["10059"].transform.localScale = Vector3.New(1, 1, 1)

				arg_343_1:CheckSpriteTmpPos("10059", 4)

				for iter_346_0 = 0, arg_343_1.actors_["10059"].transform.childCount - 1 do
					local var_346_0 = arg_343_1.actors_["10059"].transform:GetChild(iter_346_0)

					if var_346_0.name == "" or not string.find(var_346_0.name, "split") then
						var_346_0.gameObject:SetActive(true)
					else
						var_346_0.gameObject:SetActive(false)
					end
				end
			end

			local var_346_1 = 0.001

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_1 then
				arg_343_1.actors_["10059"].transform.localPosition = Vector3.Lerp(arg_343_1.var_.moveOldPos10059, Vector3.New(390, -530, 35), (arg_343_1.time_ - 0) / var_346_1)
			end

			if arg_343_1.time_ >= 0 + var_346_1 and arg_343_1.time_ < 0 + var_346_1 + arg_346_0 then
				arg_343_1.actors_["10059"].transform.localPosition = Vector3.New(390, -530, 35)
			end

			local var_346_2 = arg_343_1.actors_["10059"]

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 and not isNil(var_346_2) and arg_343_1.var_.actorSpriteComps10059 == nil then
				arg_343_1.var_.actorSpriteComps10059 = var_346_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_346_3 = 0.034

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_3 and not isNil(var_346_2) then
				if arg_343_1.var_.actorSpriteComps10059 then
					for iter_346_1, iter_346_2 in pairs(arg_343_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_346_2 then
							if arg_343_1.isInRecall_ then
								iter_346_2.color = Color.New(Mathf.Lerp(iter_346_2.color.r, arg_343_1.hightColor1.r, (arg_343_1.time_ - 0) / var_346_3), Mathf.Lerp(iter_346_2.color.g, arg_343_1.hightColor1.g, (arg_343_1.time_ - 0) / var_346_3), (Mathf.Lerp(iter_346_2.color.b, arg_343_1.hightColor1.b, (arg_343_1.time_ - 0) / var_346_3)))
							else
								local var_346_4 = Mathf.Lerp(iter_346_2.color.r, 1, (arg_343_1.time_ - 0) / var_346_3)

								iter_346_2.color = Color.New(var_346_4, var_346_4, var_346_4)
							end
						end
					end
				end
			end

			if arg_343_1.time_ >= 0 + var_346_3 and arg_343_1.time_ < 0 + var_346_3 + arg_346_0 and not isNil(var_346_2) and arg_343_1.var_.actorSpriteComps10059 then
				for iter_346_3, iter_346_4 in pairs(arg_343_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_346_4 then
						iter_346_4.color = arg_343_1.isInRecall_ and (arg_343_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_343_1.var_.actorSpriteComps10059 = nil
			end

			local var_346_5 = arg_343_1.actors_["1061"]

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 and not isNil(var_346_5) and arg_343_1.var_.actorSpriteComps1061 == nil then
				arg_343_1.var_.actorSpriteComps1061 = var_346_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_346_6 = 0.034

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_6 and not isNil(var_346_5) then
				if arg_343_1.var_.actorSpriteComps1061 then
					for iter_346_5, iter_346_6 in pairs(arg_343_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_346_6 then
							if arg_343_1.isInRecall_ then
								iter_346_6.color = Color.New(Mathf.Lerp(iter_346_6.color.r, arg_343_1.hightColor2.r, (arg_343_1.time_ - 0) / var_346_6), Mathf.Lerp(iter_346_6.color.g, arg_343_1.hightColor2.g, (arg_343_1.time_ - 0) / var_346_6), (Mathf.Lerp(iter_346_6.color.b, arg_343_1.hightColor2.b, (arg_343_1.time_ - 0) / var_346_6)))
							else
								local var_346_7 = Mathf.Lerp(iter_346_6.color.r, 0.5, (arg_343_1.time_ - 0) / var_346_6)

								iter_346_6.color = Color.New(var_346_7, var_346_7, var_346_7)
							end
						end
					end
				end
			end

			if arg_343_1.time_ >= 0 + var_346_6 and arg_343_1.time_ < 0 + var_346_6 + arg_346_0 and not isNil(var_346_5) and arg_343_1.var_.actorSpriteComps1061 then
				for iter_346_7, iter_346_8 in pairs(arg_343_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_346_8 then
						iter_346_8.color = arg_343_1.isInRecall_ and (arg_343_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_343_1.var_.actorSpriteComps1061 = nil
			end

			local var_346_8 = 0
			local var_346_9 = 0.325

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= var_346_8 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, true)

				arg_343_1.leftNameTxt_.text = arg_343_1:FormatText(StoryNameCfg[596].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_343_1.leftNameTxt_.transform)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1.leftNameTxt_.text)
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_10 = arg_343_1:GetWordFromCfg(410161083)
				local var_346_11 = arg_343_1:FormatText(var_346_10.content)

				arg_343_1.text_.text = var_346_11

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_13 = 13 <= 0 and var_346_9 or var_346_9 * (utf8.len(var_346_11) / 13)

				if (13 <= 0 and var_346_9 or var_346_9 * (utf8.len(var_346_11) / 13)) > 0 and var_346_9 < var_346_13 then
					arg_343_1.talkMaxDuration = var_346_13

					if var_346_13 + var_346_8 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_13 + var_346_8
					end
				end

				arg_343_1.text_.text = var_346_11
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161083", "story_v_out_410161.awb") ~= 0 then
					local var_346_14 = manager.audio:GetVoiceLength("story_v_out_410161", "410161083", "story_v_out_410161.awb") / 1000

					if var_346_14 + var_346_8 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_14 + var_346_8
					end

					if var_346_10.prefab_name ~= "" and arg_343_1.actors_[var_346_10.prefab_name] ~= nil then
						local var_346_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_343_1.actors_[var_346_10.prefab_name].transform, "story_v_out_410161", "410161083", "story_v_out_410161.awb")

						arg_343_1:RecordAudio("410161083", var_346_15)
						arg_343_1:RecordAudio("410161083", var_346_15)
					else
						arg_343_1:AudioAction("play", "voice", "story_v_out_410161", "410161083", "story_v_out_410161.awb")
					end

					arg_343_1:RecordHistoryTalkVoice("story_v_out_410161", "410161083", "story_v_out_410161.awb")
				end

				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_16 = math.max(var_346_9, arg_343_1.talkMaxDuration)

			if var_346_8 <= arg_343_1.time_ and arg_343_1.time_ < var_346_8 + var_346_16 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_8) / var_346_16

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_8 + var_346_16 and arg_343_1.time_ < var_346_8 + var_346_16 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_343_1:InitPlayNodeList()
	end,
	Play410161084 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 410161084
		arg_347_1.duration_ = 10.97

		local var_347_0 = {
			ja = 10.966,
			CriLanguages = 8.1,
			zh = 8.1
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
				arg_347_0:Play410161085(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 then
				arg_347_1.var_.moveOldPos10059 = arg_347_1.actors_["10059"].transform.localPosition
				arg_347_1.actors_["10059"].transform.localScale = Vector3.New(1, 1, 1)

				arg_347_1:CheckSpriteTmpPos("10059", 4)

				for iter_350_0 = 0, arg_347_1.actors_["10059"].transform.childCount - 1 do
					local var_350_0 = arg_347_1.actors_["10059"].transform:GetChild(iter_350_0)

					if var_350_0.name == "" or not string.find(var_350_0.name, "split") then
						var_350_0.gameObject:SetActive(true)
					else
						var_350_0.gameObject:SetActive(false)
					end
				end
			end

			local var_350_1 = 0.001

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_1 then
				arg_347_1.actors_["10059"].transform.localPosition = Vector3.Lerp(arg_347_1.var_.moveOldPos10059, Vector3.New(390, -530, 35), (arg_347_1.time_ - 0) / var_350_1)
			end

			if arg_347_1.time_ >= 0 + var_350_1 and arg_347_1.time_ < 0 + var_350_1 + arg_350_0 then
				arg_347_1.actors_["10059"].transform.localPosition = Vector3.New(390, -530, 35)
			end

			local var_350_2 = arg_347_1.actors_["10059"]

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 and not isNil(var_350_2) and arg_347_1.var_.actorSpriteComps10059 == nil then
				arg_347_1.var_.actorSpriteComps10059 = var_350_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_350_3 = 0.034

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_3 and not isNil(var_350_2) then
				if arg_347_1.var_.actorSpriteComps10059 then
					for iter_350_1, iter_350_2 in pairs(arg_347_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_350_2 then
							if arg_347_1.isInRecall_ then
								iter_350_2.color = Color.New(Mathf.Lerp(iter_350_2.color.r, arg_347_1.hightColor1.r, (arg_347_1.time_ - 0) / var_350_3), Mathf.Lerp(iter_350_2.color.g, arg_347_1.hightColor1.g, (arg_347_1.time_ - 0) / var_350_3), (Mathf.Lerp(iter_350_2.color.b, arg_347_1.hightColor1.b, (arg_347_1.time_ - 0) / var_350_3)))
							else
								local var_350_4 = Mathf.Lerp(iter_350_2.color.r, 1, (arg_347_1.time_ - 0) / var_350_3)

								iter_350_2.color = Color.New(var_350_4, var_350_4, var_350_4)
							end
						end
					end
				end
			end

			if arg_347_1.time_ >= 0 + var_350_3 and arg_347_1.time_ < 0 + var_350_3 + arg_350_0 and not isNil(var_350_2) and arg_347_1.var_.actorSpriteComps10059 then
				for iter_350_3, iter_350_4 in pairs(arg_347_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_350_4 then
						iter_350_4.color = arg_347_1.isInRecall_ and (arg_347_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_347_1.var_.actorSpriteComps10059 = nil
			end

			local var_350_5 = 0
			local var_350_6 = 0.925

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= var_350_5 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, true)

				arg_347_1.leftNameTxt_.text = arg_347_1:FormatText(StoryNameCfg[596].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_347_1.leftNameTxt_.transform)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1.leftNameTxt_.text)
				SetActive(arg_347_1.iconTrs_.gameObject, false)
				arg_347_1.callingController_:SetSelectedState("normal")

				local var_350_7 = arg_347_1:GetWordFromCfg(410161084)
				local var_350_8 = arg_347_1:FormatText(var_350_7.content)

				arg_347_1.text_.text = var_350_8

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_10 = 37 <= 0 and var_350_6 or var_350_6 * (utf8.len(var_350_8) / 37)

				if (37 <= 0 and var_350_6 or var_350_6 * (utf8.len(var_350_8) / 37)) > 0 and var_350_6 < var_350_10 then
					arg_347_1.talkMaxDuration = var_350_10

					if var_350_10 + var_350_5 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_10 + var_350_5
					end
				end

				arg_347_1.text_.text = var_350_8
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161084", "story_v_out_410161.awb") ~= 0 then
					local var_350_11 = manager.audio:GetVoiceLength("story_v_out_410161", "410161084", "story_v_out_410161.awb") / 1000

					if var_350_11 + var_350_5 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_11 + var_350_5
					end

					if var_350_7.prefab_name ~= "" and arg_347_1.actors_[var_350_7.prefab_name] ~= nil then
						local var_350_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_347_1.actors_[var_350_7.prefab_name].transform, "story_v_out_410161", "410161084", "story_v_out_410161.awb")

						arg_347_1:RecordAudio("410161084", var_350_12)
						arg_347_1:RecordAudio("410161084", var_350_12)
					else
						arg_347_1:AudioAction("play", "voice", "story_v_out_410161", "410161084", "story_v_out_410161.awb")
					end

					arg_347_1:RecordHistoryTalkVoice("story_v_out_410161", "410161084", "story_v_out_410161.awb")
				end

				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_13 = math.max(var_350_6, arg_347_1.talkMaxDuration)

			if var_350_5 <= arg_347_1.time_ and arg_347_1.time_ < var_350_5 + var_350_13 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - var_350_5) / var_350_13

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= var_350_5 + var_350_13 and arg_347_1.time_ < var_350_5 + var_350_13 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
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
	Play410161085 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 410161085
		arg_351_1.duration_ = 7.97

		local var_351_0 = {
			ja = 7.966,
			CriLanguages = 2.966,
			zh = 2.966
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
				arg_351_0:Play410161086(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 then
				arg_351_1.var_.moveOldPos1061 = arg_351_1.actors_["1061"].transform.localPosition
				arg_351_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_351_1:CheckSpriteTmpPos("1061", 2)

				for iter_354_0 = 0, arg_351_1.actors_["1061"].transform.childCount - 1 do
					local var_354_0 = arg_351_1.actors_["1061"].transform:GetChild(iter_354_0)

					if var_354_0.name == "" or not string.find(var_354_0.name, "split") then
						var_354_0.gameObject:SetActive(true)
					else
						var_354_0.gameObject:SetActive(false)
					end
				end
			end

			local var_354_1 = 0.001

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_1 then
				arg_351_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_351_1.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (arg_351_1.time_ - 0) / var_354_1)
			end

			if arg_351_1.time_ >= 0 + var_354_1 and arg_351_1.time_ < 0 + var_354_1 + arg_354_0 then
				arg_351_1.actors_["1061"].transform.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_354_2 = arg_351_1.actors_["1061"]

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 and not isNil(var_354_2) and arg_351_1.var_.actorSpriteComps1061 == nil then
				arg_351_1.var_.actorSpriteComps1061 = var_354_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_354_3 = 0.034

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_3 and not isNil(var_354_2) then
				if arg_351_1.var_.actorSpriteComps1061 then
					for iter_354_1, iter_354_2 in pairs(arg_351_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_354_2 then
							if arg_351_1.isInRecall_ then
								iter_354_2.color = Color.New(Mathf.Lerp(iter_354_2.color.r, arg_351_1.hightColor1.r, (arg_351_1.time_ - 0) / var_354_3), Mathf.Lerp(iter_354_2.color.g, arg_351_1.hightColor1.g, (arg_351_1.time_ - 0) / var_354_3), (Mathf.Lerp(iter_354_2.color.b, arg_351_1.hightColor1.b, (arg_351_1.time_ - 0) / var_354_3)))
							else
								local var_354_4 = Mathf.Lerp(iter_354_2.color.r, 1, (arg_351_1.time_ - 0) / var_354_3)

								iter_354_2.color = Color.New(var_354_4, var_354_4, var_354_4)
							end
						end
					end
				end
			end

			if arg_351_1.time_ >= 0 + var_354_3 and arg_351_1.time_ < 0 + var_354_3 + arg_354_0 and not isNil(var_354_2) and arg_351_1.var_.actorSpriteComps1061 then
				for iter_354_3, iter_354_4 in pairs(arg_351_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_354_4 then
						iter_354_4.color = arg_351_1.isInRecall_ and (arg_351_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_351_1.var_.actorSpriteComps1061 = nil
			end

			local var_354_5 = arg_351_1.actors_["10059"]

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 and not isNil(var_354_5) and arg_351_1.var_.actorSpriteComps10059 == nil then
				arg_351_1.var_.actorSpriteComps10059 = var_354_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_354_6 = 0.034

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_6 and not isNil(var_354_5) then
				if arg_351_1.var_.actorSpriteComps10059 then
					for iter_354_5, iter_354_6 in pairs(arg_351_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_354_6 then
							if arg_351_1.isInRecall_ then
								iter_354_6.color = Color.New(Mathf.Lerp(iter_354_6.color.r, arg_351_1.hightColor2.r, (arg_351_1.time_ - 0) / var_354_6), Mathf.Lerp(iter_354_6.color.g, arg_351_1.hightColor2.g, (arg_351_1.time_ - 0) / var_354_6), (Mathf.Lerp(iter_354_6.color.b, arg_351_1.hightColor2.b, (arg_351_1.time_ - 0) / var_354_6)))
							else
								local var_354_7 = Mathf.Lerp(iter_354_6.color.r, 0.5, (arg_351_1.time_ - 0) / var_354_6)

								iter_354_6.color = Color.New(var_354_7, var_354_7, var_354_7)
							end
						end
					end
				end
			end

			if arg_351_1.time_ >= 0 + var_354_6 and arg_351_1.time_ < 0 + var_354_6 + arg_354_0 and not isNil(var_354_5) and arg_351_1.var_.actorSpriteComps10059 then
				for iter_354_7, iter_354_8 in pairs(arg_351_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_354_8 then
						iter_354_8.color = arg_351_1.isInRecall_ and (arg_351_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_351_1.var_.actorSpriteComps10059 = nil
			end

			local var_354_8 = 0
			local var_354_9 = 0.375

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= var_354_8 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, true)

				arg_351_1.leftNameTxt_.text = arg_351_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_10 = arg_351_1:GetWordFromCfg(410161085)
				local var_354_11 = arg_351_1:FormatText(var_354_10.content)

				arg_351_1.text_.text = var_354_11

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_13 = 15 <= 0 and var_354_9 or var_354_9 * (utf8.len(var_354_11) / 15)

				if (15 <= 0 and var_354_9 or var_354_9 * (utf8.len(var_354_11) / 15)) > 0 and var_354_9 < var_354_13 then
					arg_351_1.talkMaxDuration = var_354_13

					if var_354_13 + var_354_8 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_13 + var_354_8
					end
				end

				arg_351_1.text_.text = var_354_11
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161085", "story_v_out_410161.awb") ~= 0 then
					local var_354_14 = manager.audio:GetVoiceLength("story_v_out_410161", "410161085", "story_v_out_410161.awb") / 1000

					if var_354_14 + var_354_8 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_14 + var_354_8
					end

					if var_354_10.prefab_name ~= "" and arg_351_1.actors_[var_354_10.prefab_name] ~= nil then
						local var_354_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_351_1.actors_[var_354_10.prefab_name].transform, "story_v_out_410161", "410161085", "story_v_out_410161.awb")

						arg_351_1:RecordAudio("410161085", var_354_15)
						arg_351_1:RecordAudio("410161085", var_354_15)
					else
						arg_351_1:AudioAction("play", "voice", "story_v_out_410161", "410161085", "story_v_out_410161.awb")
					end

					arg_351_1:RecordHistoryTalkVoice("story_v_out_410161", "410161085", "story_v_out_410161.awb")
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

		arg_351_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_351_1:InitPlayNodeList()
	end,
	Play410161086 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 410161086
		arg_355_1.duration_ = 8.67

		local var_355_0 = {
			ja = 8.666,
			CriLanguages = 7.066,
			zh = 7.066
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
				arg_355_0:Play410161087(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 then
				arg_355_1.var_.moveOldPos10059 = arg_355_1.actors_["10059"].transform.localPosition
				arg_355_1.actors_["10059"].transform.localScale = Vector3.New(1, 1, 1)

				arg_355_1:CheckSpriteTmpPos("10059", 4)

				for iter_358_0 = 0, arg_355_1.actors_["10059"].transform.childCount - 1 do
					local var_358_0 = arg_355_1.actors_["10059"].transform:GetChild(iter_358_0)

					if var_358_0.name == "" or not string.find(var_358_0.name, "split") then
						var_358_0.gameObject:SetActive(true)
					else
						var_358_0.gameObject:SetActive(false)
					end
				end
			end

			local var_358_1 = 0.001

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_1 then
				arg_355_1.actors_["10059"].transform.localPosition = Vector3.Lerp(arg_355_1.var_.moveOldPos10059, Vector3.New(390, -530, 35), (arg_355_1.time_ - 0) / var_358_1)
			end

			if arg_355_1.time_ >= 0 + var_358_1 and arg_355_1.time_ < 0 + var_358_1 + arg_358_0 then
				arg_355_1.actors_["10059"].transform.localPosition = Vector3.New(390, -530, 35)
			end

			local var_358_2 = arg_355_1.actors_["10059"]

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 and not isNil(var_358_2) and arg_355_1.var_.actorSpriteComps10059 == nil then
				arg_355_1.var_.actorSpriteComps10059 = var_358_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_358_3 = 0.034

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_3 and not isNil(var_358_2) then
				if arg_355_1.var_.actorSpriteComps10059 then
					for iter_358_1, iter_358_2 in pairs(arg_355_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_358_2 then
							if arg_355_1.isInRecall_ then
								iter_358_2.color = Color.New(Mathf.Lerp(iter_358_2.color.r, arg_355_1.hightColor1.r, (arg_355_1.time_ - 0) / var_358_3), Mathf.Lerp(iter_358_2.color.g, arg_355_1.hightColor1.g, (arg_355_1.time_ - 0) / var_358_3), (Mathf.Lerp(iter_358_2.color.b, arg_355_1.hightColor1.b, (arg_355_1.time_ - 0) / var_358_3)))
							else
								local var_358_4 = Mathf.Lerp(iter_358_2.color.r, 1, (arg_355_1.time_ - 0) / var_358_3)

								iter_358_2.color = Color.New(var_358_4, var_358_4, var_358_4)
							end
						end
					end
				end
			end

			if arg_355_1.time_ >= 0 + var_358_3 and arg_355_1.time_ < 0 + var_358_3 + arg_358_0 and not isNil(var_358_2) and arg_355_1.var_.actorSpriteComps10059 then
				for iter_358_3, iter_358_4 in pairs(arg_355_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_358_4 then
						iter_358_4.color = arg_355_1.isInRecall_ and (arg_355_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_355_1.var_.actorSpriteComps10059 = nil
			end

			local var_358_5 = arg_355_1.actors_["1061"]

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 and not isNil(var_358_5) and arg_355_1.var_.actorSpriteComps1061 == nil then
				arg_355_1.var_.actorSpriteComps1061 = var_358_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_358_6 = 0.034

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_6 and not isNil(var_358_5) then
				if arg_355_1.var_.actorSpriteComps1061 then
					for iter_358_5, iter_358_6 in pairs(arg_355_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_358_6 then
							if arg_355_1.isInRecall_ then
								iter_358_6.color = Color.New(Mathf.Lerp(iter_358_6.color.r, arg_355_1.hightColor2.r, (arg_355_1.time_ - 0) / var_358_6), Mathf.Lerp(iter_358_6.color.g, arg_355_1.hightColor2.g, (arg_355_1.time_ - 0) / var_358_6), (Mathf.Lerp(iter_358_6.color.b, arg_355_1.hightColor2.b, (arg_355_1.time_ - 0) / var_358_6)))
							else
								local var_358_7 = Mathf.Lerp(iter_358_6.color.r, 0.5, (arg_355_1.time_ - 0) / var_358_6)

								iter_358_6.color = Color.New(var_358_7, var_358_7, var_358_7)
							end
						end
					end
				end
			end

			if arg_355_1.time_ >= 0 + var_358_6 and arg_355_1.time_ < 0 + var_358_6 + arg_358_0 and not isNil(var_358_5) and arg_355_1.var_.actorSpriteComps1061 then
				for iter_358_7, iter_358_8 in pairs(arg_355_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_358_8 then
						iter_358_8.color = arg_355_1.isInRecall_ and (arg_355_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_355_1.var_.actorSpriteComps1061 = nil
			end

			local var_358_8 = 0
			local var_358_9 = 0.925

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= var_358_8 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, true)

				arg_355_1.leftNameTxt_.text = arg_355_1:FormatText(StoryNameCfg[596].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_355_1.leftNameTxt_.transform)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1.leftNameTxt_.text)
				SetActive(arg_355_1.iconTrs_.gameObject, false)
				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_10 = arg_355_1:GetWordFromCfg(410161086)
				local var_358_11 = arg_355_1:FormatText(var_358_10.content)

				arg_355_1.text_.text = var_358_11

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_13 = 37 <= 0 and var_358_9 or var_358_9 * (utf8.len(var_358_11) / 37)

				if (37 <= 0 and var_358_9 or var_358_9 * (utf8.len(var_358_11) / 37)) > 0 and var_358_9 < var_358_13 then
					arg_355_1.talkMaxDuration = var_358_13

					if var_358_13 + var_358_8 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_13 + var_358_8
					end
				end

				arg_355_1.text_.text = var_358_11
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161086", "story_v_out_410161.awb") ~= 0 then
					local var_358_14 = manager.audio:GetVoiceLength("story_v_out_410161", "410161086", "story_v_out_410161.awb") / 1000

					if var_358_14 + var_358_8 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_14 + var_358_8
					end

					if var_358_10.prefab_name ~= "" and arg_355_1.actors_[var_358_10.prefab_name] ~= nil then
						local var_358_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_355_1.actors_[var_358_10.prefab_name].transform, "story_v_out_410161", "410161086", "story_v_out_410161.awb")

						arg_355_1:RecordAudio("410161086", var_358_15)
						arg_355_1:RecordAudio("410161086", var_358_15)
					else
						arg_355_1:AudioAction("play", "voice", "story_v_out_410161", "410161086", "story_v_out_410161.awb")
					end

					arg_355_1:RecordHistoryTalkVoice("story_v_out_410161", "410161086", "story_v_out_410161.awb")
				end

				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_16 = math.max(var_358_9, arg_355_1.talkMaxDuration)

			if var_358_8 <= arg_355_1.time_ and arg_355_1.time_ < var_358_8 + var_358_16 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_8) / var_358_16

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_8 + var_358_16 and arg_355_1.time_ < var_358_8 + var_358_16 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
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
	Play410161087 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 410161087
		arg_359_1.duration_ = 3.7

		local var_359_0 = {
			ja = 3.333,
			CriLanguages = 3.7,
			zh = 3.7
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
				arg_359_0:Play410161088(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1.var_.moveOldPos10059 = arg_359_1.actors_["10059"].transform.localPosition
				arg_359_1.actors_["10059"].transform.localScale = Vector3.New(1, 1, 1)

				arg_359_1:CheckSpriteTmpPos("10059", 4)

				for iter_362_0 = 0, arg_359_1.actors_["10059"].transform.childCount - 1 do
					local var_362_0 = arg_359_1.actors_["10059"].transform:GetChild(iter_362_0)

					if var_362_0.name == "" or not string.find(var_362_0.name, "split") then
						var_362_0.gameObject:SetActive(true)
					else
						var_362_0.gameObject:SetActive(false)
					end
				end
			end

			local var_362_1 = 0.001

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_1 then
				arg_359_1.actors_["10059"].transform.localPosition = Vector3.Lerp(arg_359_1.var_.moveOldPos10059, Vector3.New(390, -530, 35), (arg_359_1.time_ - 0) / var_362_1)
			end

			if arg_359_1.time_ >= 0 + var_362_1 and arg_359_1.time_ < 0 + var_362_1 + arg_362_0 then
				arg_359_1.actors_["10059"].transform.localPosition = Vector3.New(390, -530, 35)
			end

			local var_362_2 = arg_359_1.actors_["10059"]

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 and not isNil(var_362_2) and arg_359_1.var_.actorSpriteComps10059 == nil then
				arg_359_1.var_.actorSpriteComps10059 = var_362_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_362_3 = 0.034

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_3 and not isNil(var_362_2) then
				if arg_359_1.var_.actorSpriteComps10059 then
					for iter_362_1, iter_362_2 in pairs(arg_359_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_362_2 then
							if arg_359_1.isInRecall_ then
								iter_362_2.color = Color.New(Mathf.Lerp(iter_362_2.color.r, arg_359_1.hightColor1.r, (arg_359_1.time_ - 0) / var_362_3), Mathf.Lerp(iter_362_2.color.g, arg_359_1.hightColor1.g, (arg_359_1.time_ - 0) / var_362_3), (Mathf.Lerp(iter_362_2.color.b, arg_359_1.hightColor1.b, (arg_359_1.time_ - 0) / var_362_3)))
							else
								local var_362_4 = Mathf.Lerp(iter_362_2.color.r, 1, (arg_359_1.time_ - 0) / var_362_3)

								iter_362_2.color = Color.New(var_362_4, var_362_4, var_362_4)
							end
						end
					end
				end
			end

			if arg_359_1.time_ >= 0 + var_362_3 and arg_359_1.time_ < 0 + var_362_3 + arg_362_0 and not isNil(var_362_2) and arg_359_1.var_.actorSpriteComps10059 then
				for iter_362_3, iter_362_4 in pairs(arg_359_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_362_4 then
						iter_362_4.color = arg_359_1.isInRecall_ and (arg_359_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_359_1.var_.actorSpriteComps10059 = nil
			end

			local var_362_5 = 0
			local var_362_6 = 0.3

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= var_362_5 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, true)

				arg_359_1.leftNameTxt_.text = arg_359_1:FormatText(StoryNameCfg[596].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_359_1.leftNameTxt_.transform)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1.leftNameTxt_.text)
				SetActive(arg_359_1.iconTrs_.gameObject, false)
				arg_359_1.callingController_:SetSelectedState("normal")

				local var_362_7 = arg_359_1:GetWordFromCfg(410161087)
				local var_362_8 = arg_359_1:FormatText(var_362_7.content)

				arg_359_1.text_.text = var_362_8

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_10 = 12 <= 0 and var_362_6 or var_362_6 * (utf8.len(var_362_8) / 12)

				if (12 <= 0 and var_362_6 or var_362_6 * (utf8.len(var_362_8) / 12)) > 0 and var_362_6 < var_362_10 then
					arg_359_1.talkMaxDuration = var_362_10

					if var_362_10 + var_362_5 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_10 + var_362_5
					end
				end

				arg_359_1.text_.text = var_362_8
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161087", "story_v_out_410161.awb") ~= 0 then
					local var_362_11 = manager.audio:GetVoiceLength("story_v_out_410161", "410161087", "story_v_out_410161.awb") / 1000

					if var_362_11 + var_362_5 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_11 + var_362_5
					end

					if var_362_7.prefab_name ~= "" and arg_359_1.actors_[var_362_7.prefab_name] ~= nil then
						local var_362_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_359_1.actors_[var_362_7.prefab_name].transform, "story_v_out_410161", "410161087", "story_v_out_410161.awb")

						arg_359_1:RecordAudio("410161087", var_362_12)
						arg_359_1:RecordAudio("410161087", var_362_12)
					else
						arg_359_1:AudioAction("play", "voice", "story_v_out_410161", "410161087", "story_v_out_410161.awb")
					end

					arg_359_1:RecordHistoryTalkVoice("story_v_out_410161", "410161087", "story_v_out_410161.awb")
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
				actorName = "10059",
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
	Play410161088 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 410161088
		arg_363_1.duration_ = 5

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play410161089(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 and not isNil(arg_363_1.actors_["1061"]) and arg_363_1.var_.actorSpriteComps1061 == nil then
				arg_363_1.var_.actorSpriteComps1061 = arg_363_1.actors_["1061"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_366_0 = 0.034

			if 0 <= arg_363_1.time_ and arg_363_1.time_ < 0 + var_366_0 and not isNil(arg_363_1.actors_["1061"]) then
				if arg_363_1.var_.actorSpriteComps1061 then
					for iter_366_0, iter_366_1 in pairs(arg_363_1.var_.actorSpriteComps1061:ToTable()) do
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

			if arg_363_1.time_ >= 0 + var_366_0 and arg_363_1.time_ < 0 + var_366_0 + arg_366_0 and not isNil(arg_363_1.actors_["1061"]) and arg_363_1.var_.actorSpriteComps1061 then
				for iter_366_2, iter_366_3 in pairs(arg_363_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_366_3 then
						iter_366_3.color = arg_363_1.isInRecall_ and (arg_363_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_363_1.var_.actorSpriteComps1061 = nil
			end

			local var_366_2 = arg_363_1.actors_["10059"]

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 and not isNil(var_366_2) and arg_363_1.var_.actorSpriteComps10059 == nil then
				arg_363_1.var_.actorSpriteComps10059 = var_366_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_366_3 = 0.034

			if 0 <= arg_363_1.time_ and arg_363_1.time_ < 0 + var_366_3 and not isNil(var_366_2) then
				if arg_363_1.var_.actorSpriteComps10059 then
					for iter_366_4, iter_366_5 in pairs(arg_363_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_366_5 then
							if arg_363_1.isInRecall_ then
								iter_366_5.color = Color.New(Mathf.Lerp(iter_366_5.color.r, arg_363_1.hightColor2.r, (arg_363_1.time_ - 0) / var_366_3), Mathf.Lerp(iter_366_5.color.g, arg_363_1.hightColor2.g, (arg_363_1.time_ - 0) / var_366_3), (Mathf.Lerp(iter_366_5.color.b, arg_363_1.hightColor2.b, (arg_363_1.time_ - 0) / var_366_3)))
							else
								local var_366_4 = Mathf.Lerp(iter_366_5.color.r, 0.5, (arg_363_1.time_ - 0) / var_366_3)

								iter_366_5.color = Color.New(var_366_4, var_366_4, var_366_4)
							end
						end
					end
				end
			end

			if arg_363_1.time_ >= 0 + var_366_3 and arg_363_1.time_ < 0 + var_366_3 + arg_366_0 and not isNil(var_366_2) and arg_363_1.var_.actorSpriteComps10059 then
				for iter_366_6, iter_366_7 in pairs(arg_363_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_366_7 then
						iter_366_7.color = arg_363_1.isInRecall_ and (arg_363_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_363_1.var_.actorSpriteComps10059 = nil
			end

			local var_366_5 = 0
			local var_366_6 = 0.85

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= var_366_5 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, false)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_363_1.iconTrs_.gameObject, false)
				arg_363_1.callingController_:SetSelectedState("normal")

				local var_366_7 = arg_363_1:FormatText(arg_363_1:GetWordFromCfg(410161088).content)

				arg_363_1.text_.text = var_366_7

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_9 = 34 <= 0 and var_366_6 or var_366_6 * (utf8.len(var_366_7) / 34)

				if (34 <= 0 and var_366_6 or var_366_6 * (utf8.len(var_366_7) / 34)) > 0 and var_366_6 < var_366_9 then
					arg_363_1.talkMaxDuration = var_366_9

					if var_366_9 + var_366_5 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_9 + var_366_5
					end
				end

				arg_363_1.text_.text = var_366_7
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)
				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_10 = math.max(var_366_6, arg_363_1.talkMaxDuration)

			if var_366_5 <= arg_363_1.time_ and arg_363_1.time_ < var_366_5 + var_366_10 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - var_366_5) / var_366_10

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= var_366_5 + var_366_10 and arg_363_1.time_ < var_366_5 + var_366_10 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {}

		arg_363_1:InitPlayNodeList()
	end,
	Play410161089 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 410161089
		arg_367_1.duration_ = 5

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play410161090(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			local var_370_0 = 0.925

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

				local var_370_1 = arg_367_1:FormatText(arg_367_1:GetWordFromCfg(410161089).content)

				arg_367_1.text_.text = var_370_1

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_3 = 37 <= 0 and var_370_0 or var_370_0 * (utf8.len(var_370_1) / 37)

				if (37 <= 0 and var_370_0 or var_370_0 * (utf8.len(var_370_1) / 37)) > 0 and var_370_0 < var_370_3 then
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
	Play410161090 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 410161090
		arg_371_1.duration_ = 14.6

		local var_371_0 = {
			ja = 14.6,
			CriLanguages = 11.2,
			zh = 11.2
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
				arg_371_0:Play410161091(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 then
				arg_371_1.var_.moveOldPos10059 = arg_371_1.actors_["10059"].transform.localPosition
				arg_371_1.actors_["10059"].transform.localScale = Vector3.New(1, 1, 1)

				arg_371_1:CheckSpriteTmpPos("10059", 4)

				for iter_374_0 = 0, arg_371_1.actors_["10059"].transform.childCount - 1 do
					local var_374_0 = arg_371_1.actors_["10059"].transform:GetChild(iter_374_0)

					if var_374_0.name == "" or not string.find(var_374_0.name, "split") then
						var_374_0.gameObject:SetActive(true)
					else
						var_374_0.gameObject:SetActive(false)
					end
				end
			end

			local var_374_1 = 0.001

			if 0 <= arg_371_1.time_ and arg_371_1.time_ < 0 + var_374_1 then
				arg_371_1.actors_["10059"].transform.localPosition = Vector3.Lerp(arg_371_1.var_.moveOldPos10059, Vector3.New(390, -530, 35), (arg_371_1.time_ - 0) / var_374_1)
			end

			if arg_371_1.time_ >= 0 + var_374_1 and arg_371_1.time_ < 0 + var_374_1 + arg_374_0 then
				arg_371_1.actors_["10059"].transform.localPosition = Vector3.New(390, -530, 35)
			end

			local var_374_2 = arg_371_1.actors_["10059"]

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 and not isNil(var_374_2) and arg_371_1.var_.actorSpriteComps10059 == nil then
				arg_371_1.var_.actorSpriteComps10059 = var_374_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_374_3 = 0.034

			if 0 <= arg_371_1.time_ and arg_371_1.time_ < 0 + var_374_3 and not isNil(var_374_2) then
				if arg_371_1.var_.actorSpriteComps10059 then
					for iter_374_1, iter_374_2 in pairs(arg_371_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_374_2 then
							if arg_371_1.isInRecall_ then
								iter_374_2.color = Color.New(Mathf.Lerp(iter_374_2.color.r, arg_371_1.hightColor1.r, (arg_371_1.time_ - 0) / var_374_3), Mathf.Lerp(iter_374_2.color.g, arg_371_1.hightColor1.g, (arg_371_1.time_ - 0) / var_374_3), (Mathf.Lerp(iter_374_2.color.b, arg_371_1.hightColor1.b, (arg_371_1.time_ - 0) / var_374_3)))
							else
								local var_374_4 = Mathf.Lerp(iter_374_2.color.r, 1, (arg_371_1.time_ - 0) / var_374_3)

								iter_374_2.color = Color.New(var_374_4, var_374_4, var_374_4)
							end
						end
					end
				end
			end

			if arg_371_1.time_ >= 0 + var_374_3 and arg_371_1.time_ < 0 + var_374_3 + arg_374_0 and not isNil(var_374_2) and arg_371_1.var_.actorSpriteComps10059 then
				for iter_374_3, iter_374_4 in pairs(arg_371_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_374_4 then
						iter_374_4.color = arg_371_1.isInRecall_ and (arg_371_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_371_1.var_.actorSpriteComps10059 = nil
			end

			local var_374_5 = 0
			local var_374_6 = 1.35

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= var_374_5 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, true)

				arg_371_1.leftNameTxt_.text = arg_371_1:FormatText(StoryNameCfg[596].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_371_1.leftNameTxt_.transform)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1.leftNameTxt_.text)
				SetActive(arg_371_1.iconTrs_.gameObject, false)
				arg_371_1.callingController_:SetSelectedState("normal")

				local var_374_7 = arg_371_1:GetWordFromCfg(410161090)
				local var_374_8 = arg_371_1:FormatText(var_374_7.content)

				arg_371_1.text_.text = var_374_8

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_10 = 54 <= 0 and var_374_6 or var_374_6 * (utf8.len(var_374_8) / 54)

				if (54 <= 0 and var_374_6 or var_374_6 * (utf8.len(var_374_8) / 54)) > 0 and var_374_6 < var_374_10 then
					arg_371_1.talkMaxDuration = var_374_10

					if var_374_10 + var_374_5 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_10 + var_374_5
					end
				end

				arg_371_1.text_.text = var_374_8
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161090", "story_v_out_410161.awb") ~= 0 then
					local var_374_11 = manager.audio:GetVoiceLength("story_v_out_410161", "410161090", "story_v_out_410161.awb") / 1000

					if var_374_11 + var_374_5 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_11 + var_374_5
					end

					if var_374_7.prefab_name ~= "" and arg_371_1.actors_[var_374_7.prefab_name] ~= nil then
						local var_374_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_371_1.actors_[var_374_7.prefab_name].transform, "story_v_out_410161", "410161090", "story_v_out_410161.awb")

						arg_371_1:RecordAudio("410161090", var_374_12)
						arg_371_1:RecordAudio("410161090", var_374_12)
					else
						arg_371_1:AudioAction("play", "voice", "story_v_out_410161", "410161090", "story_v_out_410161.awb")
					end

					arg_371_1:RecordHistoryTalkVoice("story_v_out_410161", "410161090", "story_v_out_410161.awb")
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

		arg_371_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_371_1:InitPlayNodeList()
	end,
	Play410161091 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 410161091
		arg_375_1.duration_ = 7.93

		local var_375_0 = {
			ja = 7.933,
			CriLanguages = 6.633,
			zh = 6.633
		}
		local var_375_1 = manager.audio:GetLocalizationFlag()

		if var_375_0[var_375_1] ~= nil then
			arg_375_1.duration_ = var_375_0[var_375_1]
		end

		SetActive(arg_375_1.tipsGo_, false)

		function arg_375_1.onSingleLineFinish_()
			arg_375_1.onSingleLineUpdate_ = nil
			arg_375_1.onSingleLineFinish_ = nil
			arg_375_1.state_ = "waiting"
		end

		function arg_375_1.playNext_(arg_377_0)
			if arg_377_0 == 1 then
				arg_375_0:Play410161092(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1.var_.moveOldPos10059 = arg_375_1.actors_["10059"].transform.localPosition
				arg_375_1.actors_["10059"].transform.localScale = Vector3.New(1, 1, 1)

				arg_375_1:CheckSpriteTmpPos("10059", 4)

				for iter_378_0 = 0, arg_375_1.actors_["10059"].transform.childCount - 1 do
					local var_378_0 = arg_375_1.actors_["10059"].transform:GetChild(iter_378_0)

					if var_378_0.name == "" or not string.find(var_378_0.name, "split") then
						var_378_0.gameObject:SetActive(true)
					else
						var_378_0.gameObject:SetActive(false)
					end
				end
			end

			local var_378_1 = 0.001

			if 0 <= arg_375_1.time_ and arg_375_1.time_ < 0 + var_378_1 then
				arg_375_1.actors_["10059"].transform.localPosition = Vector3.Lerp(arg_375_1.var_.moveOldPos10059, Vector3.New(390, -530, 35), (arg_375_1.time_ - 0) / var_378_1)
			end

			if arg_375_1.time_ >= 0 + var_378_1 and arg_375_1.time_ < 0 + var_378_1 + arg_378_0 then
				arg_375_1.actors_["10059"].transform.localPosition = Vector3.New(390, -530, 35)
			end

			local var_378_2 = arg_375_1.actors_["10059"]

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 and not isNil(var_378_2) and arg_375_1.var_.actorSpriteComps10059 == nil then
				arg_375_1.var_.actorSpriteComps10059 = var_378_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_378_3 = 0.034

			if 0 <= arg_375_1.time_ and arg_375_1.time_ < 0 + var_378_3 and not isNil(var_378_2) then
				if arg_375_1.var_.actorSpriteComps10059 then
					for iter_378_1, iter_378_2 in pairs(arg_375_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_378_2 then
							if arg_375_1.isInRecall_ then
								iter_378_2.color = Color.New(Mathf.Lerp(iter_378_2.color.r, arg_375_1.hightColor1.r, (arg_375_1.time_ - 0) / var_378_3), Mathf.Lerp(iter_378_2.color.g, arg_375_1.hightColor1.g, (arg_375_1.time_ - 0) / var_378_3), (Mathf.Lerp(iter_378_2.color.b, arg_375_1.hightColor1.b, (arg_375_1.time_ - 0) / var_378_3)))
							else
								local var_378_4 = Mathf.Lerp(iter_378_2.color.r, 1, (arg_375_1.time_ - 0) / var_378_3)

								iter_378_2.color = Color.New(var_378_4, var_378_4, var_378_4)
							end
						end
					end
				end
			end

			if arg_375_1.time_ >= 0 + var_378_3 and arg_375_1.time_ < 0 + var_378_3 + arg_378_0 and not isNil(var_378_2) and arg_375_1.var_.actorSpriteComps10059 then
				for iter_378_3, iter_378_4 in pairs(arg_375_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_378_4 then
						iter_378_4.color = arg_375_1.isInRecall_ and (arg_375_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_375_1.var_.actorSpriteComps10059 = nil
			end

			local var_378_5 = 0
			local var_378_6 = 0.9

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= var_378_5 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, true)

				arg_375_1.leftNameTxt_.text = arg_375_1:FormatText(StoryNameCfg[596].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_375_1.leftNameTxt_.transform)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1.leftNameTxt_.text)
				SetActive(arg_375_1.iconTrs_.gameObject, false)
				arg_375_1.callingController_:SetSelectedState("normal")

				local var_378_7 = arg_375_1:GetWordFromCfg(410161091)
				local var_378_8 = arg_375_1:FormatText(var_378_7.content)

				arg_375_1.text_.text = var_378_8

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_10 = 36 <= 0 and var_378_6 or var_378_6 * (utf8.len(var_378_8) / 36)

				if (36 <= 0 and var_378_6 or var_378_6 * (utf8.len(var_378_8) / 36)) > 0 and var_378_6 < var_378_10 then
					arg_375_1.talkMaxDuration = var_378_10

					if var_378_10 + var_378_5 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_10 + var_378_5
					end
				end

				arg_375_1.text_.text = var_378_8
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161091", "story_v_out_410161.awb") ~= 0 then
					local var_378_11 = manager.audio:GetVoiceLength("story_v_out_410161", "410161091", "story_v_out_410161.awb") / 1000

					if var_378_11 + var_378_5 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_11 + var_378_5
					end

					if var_378_7.prefab_name ~= "" and arg_375_1.actors_[var_378_7.prefab_name] ~= nil then
						local var_378_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_375_1.actors_[var_378_7.prefab_name].transform, "story_v_out_410161", "410161091", "story_v_out_410161.awb")

						arg_375_1:RecordAudio("410161091", var_378_12)
						arg_375_1:RecordAudio("410161091", var_378_12)
					else
						arg_375_1:AudioAction("play", "voice", "story_v_out_410161", "410161091", "story_v_out_410161.awb")
					end

					arg_375_1:RecordHistoryTalkVoice("story_v_out_410161", "410161091", "story_v_out_410161.awb")
				end

				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_13 = math.max(var_378_6, arg_375_1.talkMaxDuration)

			if var_378_5 <= arg_375_1.time_ and arg_375_1.time_ < var_378_5 + var_378_13 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - var_378_5) / var_378_13

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= var_378_5 + var_378_13 and arg_375_1.time_ < var_378_5 + var_378_13 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
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
	Play410161092 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 410161092
		arg_379_1.duration_ = 10.1

		local var_379_0 = {
			ja = 10.1,
			CriLanguages = 9.3,
			zh = 9.3
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
				arg_379_0:Play410161093(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 then
				arg_379_1.var_.moveOldPos1061 = arg_379_1.actors_["1061"].transform.localPosition
				arg_379_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_379_1:CheckSpriteTmpPos("1061", 2)

				for iter_382_0 = 0, arg_379_1.actors_["1061"].transform.childCount - 1 do
					local var_382_0 = arg_379_1.actors_["1061"].transform:GetChild(iter_382_0)

					if var_382_0.name == "" or not string.find(var_382_0.name, "split") then
						var_382_0.gameObject:SetActive(true)
					else
						var_382_0.gameObject:SetActive(false)
					end
				end
			end

			local var_382_1 = 0.001

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_1 then
				arg_379_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_379_1.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (arg_379_1.time_ - 0) / var_382_1)
			end

			if arg_379_1.time_ >= 0 + var_382_1 and arg_379_1.time_ < 0 + var_382_1 + arg_382_0 then
				arg_379_1.actors_["1061"].transform.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_382_2 = arg_379_1.actors_["1061"]

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 and not isNil(var_382_2) and arg_379_1.var_.actorSpriteComps1061 == nil then
				arg_379_1.var_.actorSpriteComps1061 = var_382_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_382_3 = 0.034

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_3 and not isNil(var_382_2) then
				if arg_379_1.var_.actorSpriteComps1061 then
					for iter_382_1, iter_382_2 in pairs(arg_379_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_382_2 then
							if arg_379_1.isInRecall_ then
								iter_382_2.color = Color.New(Mathf.Lerp(iter_382_2.color.r, arg_379_1.hightColor1.r, (arg_379_1.time_ - 0) / var_382_3), Mathf.Lerp(iter_382_2.color.g, arg_379_1.hightColor1.g, (arg_379_1.time_ - 0) / var_382_3), (Mathf.Lerp(iter_382_2.color.b, arg_379_1.hightColor1.b, (arg_379_1.time_ - 0) / var_382_3)))
							else
								local var_382_4 = Mathf.Lerp(iter_382_2.color.r, 1, (arg_379_1.time_ - 0) / var_382_3)

								iter_382_2.color = Color.New(var_382_4, var_382_4, var_382_4)
							end
						end
					end
				end
			end

			if arg_379_1.time_ >= 0 + var_382_3 and arg_379_1.time_ < 0 + var_382_3 + arg_382_0 and not isNil(var_382_2) and arg_379_1.var_.actorSpriteComps1061 then
				for iter_382_3, iter_382_4 in pairs(arg_379_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_382_4 then
						iter_382_4.color = arg_379_1.isInRecall_ and (arg_379_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_379_1.var_.actorSpriteComps1061 = nil
			end

			local var_382_5 = arg_379_1.actors_["10059"]

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 and not isNil(var_382_5) and arg_379_1.var_.actorSpriteComps10059 == nil then
				arg_379_1.var_.actorSpriteComps10059 = var_382_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_382_6 = 0.034

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_6 and not isNil(var_382_5) then
				if arg_379_1.var_.actorSpriteComps10059 then
					for iter_382_5, iter_382_6 in pairs(arg_379_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_382_6 then
							if arg_379_1.isInRecall_ then
								iter_382_6.color = Color.New(Mathf.Lerp(iter_382_6.color.r, arg_379_1.hightColor2.r, (arg_379_1.time_ - 0) / var_382_6), Mathf.Lerp(iter_382_6.color.g, arg_379_1.hightColor2.g, (arg_379_1.time_ - 0) / var_382_6), (Mathf.Lerp(iter_382_6.color.b, arg_379_1.hightColor2.b, (arg_379_1.time_ - 0) / var_382_6)))
							else
								local var_382_7 = Mathf.Lerp(iter_382_6.color.r, 0.5, (arg_379_1.time_ - 0) / var_382_6)

								iter_382_6.color = Color.New(var_382_7, var_382_7, var_382_7)
							end
						end
					end
				end
			end

			if arg_379_1.time_ >= 0 + var_382_6 and arg_379_1.time_ < 0 + var_382_6 + arg_382_0 and not isNil(var_382_5) and arg_379_1.var_.actorSpriteComps10059 then
				for iter_382_7, iter_382_8 in pairs(arg_379_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_382_8 then
						iter_382_8.color = arg_379_1.isInRecall_ and (arg_379_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_379_1.var_.actorSpriteComps10059 = nil
			end

			local var_382_8 = 0
			local var_382_9 = 0.9

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= var_382_8 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, true)

				arg_379_1.leftNameTxt_.text = arg_379_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_379_1.leftNameTxt_.transform)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1.leftNameTxt_.text)
				SetActive(arg_379_1.iconTrs_.gameObject, false)
				arg_379_1.callingController_:SetSelectedState("normal")

				local var_382_10 = arg_379_1:GetWordFromCfg(410161092)
				local var_382_11 = arg_379_1:FormatText(var_382_10.content)

				arg_379_1.text_.text = var_382_11

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_13 = 36 <= 0 and var_382_9 or var_382_9 * (utf8.len(var_382_11) / 36)

				if (36 <= 0 and var_382_9 or var_382_9 * (utf8.len(var_382_11) / 36)) > 0 and var_382_9 < var_382_13 then
					arg_379_1.talkMaxDuration = var_382_13

					if var_382_13 + var_382_8 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_13 + var_382_8
					end
				end

				arg_379_1.text_.text = var_382_11
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161092", "story_v_out_410161.awb") ~= 0 then
					local var_382_14 = manager.audio:GetVoiceLength("story_v_out_410161", "410161092", "story_v_out_410161.awb") / 1000

					if var_382_14 + var_382_8 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_14 + var_382_8
					end

					if var_382_10.prefab_name ~= "" and arg_379_1.actors_[var_382_10.prefab_name] ~= nil then
						local var_382_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_379_1.actors_[var_382_10.prefab_name].transform, "story_v_out_410161", "410161092", "story_v_out_410161.awb")

						arg_379_1:RecordAudio("410161092", var_382_15)
						arg_379_1:RecordAudio("410161092", var_382_15)
					else
						arg_379_1:AudioAction("play", "voice", "story_v_out_410161", "410161092", "story_v_out_410161.awb")
					end

					arg_379_1:RecordHistoryTalkVoice("story_v_out_410161", "410161092", "story_v_out_410161.awb")
				end

				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_16 = math.max(var_382_9, arg_379_1.talkMaxDuration)

			if var_382_8 <= arg_379_1.time_ and arg_379_1.time_ < var_382_8 + var_382_16 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - var_382_8) / var_382_16

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= var_382_8 + var_382_16 and arg_379_1.time_ < var_382_8 + var_382_16 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
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
	Play410161093 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 410161093
		arg_383_1.duration_ = 7.73

		local var_383_0 = {
			ja = 7.733,
			CriLanguages = 6.033,
			zh = 6.033
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
				arg_383_0:Play410161094(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 then
				arg_383_1.var_.moveOldPos1061 = arg_383_1.actors_["1061"].transform.localPosition
				arg_383_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_383_1:CheckSpriteTmpPos("1061", 2)

				for iter_386_0 = 0, arg_383_1.actors_["1061"].transform.childCount - 1 do
					local var_386_0 = arg_383_1.actors_["1061"].transform:GetChild(iter_386_0)

					if var_386_0.name == "" or not string.find(var_386_0.name, "split") then
						var_386_0.gameObject:SetActive(true)
					else
						var_386_0.gameObject:SetActive(false)
					end
				end
			end

			local var_386_1 = 0.001

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_1 then
				arg_383_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_383_1.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (arg_383_1.time_ - 0) / var_386_1)
			end

			if arg_383_1.time_ >= 0 + var_386_1 and arg_383_1.time_ < 0 + var_386_1 + arg_386_0 then
				arg_383_1.actors_["1061"].transform.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_386_2 = arg_383_1.actors_["1061"]

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 and not isNil(var_386_2) and arg_383_1.var_.actorSpriteComps1061 == nil then
				arg_383_1.var_.actorSpriteComps1061 = var_386_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_386_3 = 0.034

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_3 and not isNil(var_386_2) then
				if arg_383_1.var_.actorSpriteComps1061 then
					for iter_386_1, iter_386_2 in pairs(arg_383_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_386_2 then
							if arg_383_1.isInRecall_ then
								iter_386_2.color = Color.New(Mathf.Lerp(iter_386_2.color.r, arg_383_1.hightColor1.r, (arg_383_1.time_ - 0) / var_386_3), Mathf.Lerp(iter_386_2.color.g, arg_383_1.hightColor1.g, (arg_383_1.time_ - 0) / var_386_3), (Mathf.Lerp(iter_386_2.color.b, arg_383_1.hightColor1.b, (arg_383_1.time_ - 0) / var_386_3)))
							else
								local var_386_4 = Mathf.Lerp(iter_386_2.color.r, 1, (arg_383_1.time_ - 0) / var_386_3)

								iter_386_2.color = Color.New(var_386_4, var_386_4, var_386_4)
							end
						end
					end
				end
			end

			if arg_383_1.time_ >= 0 + var_386_3 and arg_383_1.time_ < 0 + var_386_3 + arg_386_0 and not isNil(var_386_2) and arg_383_1.var_.actorSpriteComps1061 then
				for iter_386_3, iter_386_4 in pairs(arg_383_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_386_4 then
						iter_386_4.color = arg_383_1.isInRecall_ and (arg_383_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_383_1.var_.actorSpriteComps1061 = nil
			end

			local var_386_5 = 0
			local var_386_6 = 0.7

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= var_386_5 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, true)

				arg_383_1.leftNameTxt_.text = arg_383_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_383_1.leftNameTxt_.transform)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1.leftNameTxt_.text)
				SetActive(arg_383_1.iconTrs_.gameObject, false)
				arg_383_1.callingController_:SetSelectedState("normal")

				local var_386_7 = arg_383_1:GetWordFromCfg(410161093)
				local var_386_8 = arg_383_1:FormatText(var_386_7.content)

				arg_383_1.text_.text = var_386_8

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_10 = 28 <= 0 and var_386_6 or var_386_6 * (utf8.len(var_386_8) / 28)

				if (28 <= 0 and var_386_6 or var_386_6 * (utf8.len(var_386_8) / 28)) > 0 and var_386_6 < var_386_10 then
					arg_383_1.talkMaxDuration = var_386_10

					if var_386_10 + var_386_5 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_10 + var_386_5
					end
				end

				arg_383_1.text_.text = var_386_8
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161093", "story_v_out_410161.awb") ~= 0 then
					local var_386_11 = manager.audio:GetVoiceLength("story_v_out_410161", "410161093", "story_v_out_410161.awb") / 1000

					if var_386_11 + var_386_5 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_11 + var_386_5
					end

					if var_386_7.prefab_name ~= "" and arg_383_1.actors_[var_386_7.prefab_name] ~= nil then
						local var_386_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_383_1.actors_[var_386_7.prefab_name].transform, "story_v_out_410161", "410161093", "story_v_out_410161.awb")

						arg_383_1:RecordAudio("410161093", var_386_12)
						arg_383_1:RecordAudio("410161093", var_386_12)
					else
						arg_383_1:AudioAction("play", "voice", "story_v_out_410161", "410161093", "story_v_out_410161.awb")
					end

					arg_383_1:RecordHistoryTalkVoice("story_v_out_410161", "410161093", "story_v_out_410161.awb")
				end

				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_13 = math.max(var_386_6, arg_383_1.talkMaxDuration)

			if var_386_5 <= arg_383_1.time_ and arg_383_1.time_ < var_386_5 + var_386_13 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - var_386_5) / var_386_13

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= var_386_5 + var_386_13 and arg_383_1.time_ < var_386_5 + var_386_13 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_383_1:InitPlayNodeList()
	end,
	Play410161094 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 410161094
		arg_387_1.duration_ = 15.67

		local var_387_0 = {
			ja = 15.666,
			CriLanguages = 13.433,
			zh = 13.433
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
				arg_387_0:Play410161095(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 then
				arg_387_1.var_.moveOldPos1061 = arg_387_1.actors_["1061"].transform.localPosition
				arg_387_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_387_1:CheckSpriteTmpPos("1061", 2)

				for iter_390_0 = 0, arg_387_1.actors_["1061"].transform.childCount - 1 do
					local var_390_0 = arg_387_1.actors_["1061"].transform:GetChild(iter_390_0)

					if var_390_0.name == "" or not string.find(var_390_0.name, "split") then
						var_390_0.gameObject:SetActive(true)
					else
						var_390_0.gameObject:SetActive(false)
					end
				end
			end

			local var_390_1 = 0.001

			if 0 <= arg_387_1.time_ and arg_387_1.time_ < 0 + var_390_1 then
				arg_387_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_387_1.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (arg_387_1.time_ - 0) / var_390_1)
			end

			if arg_387_1.time_ >= 0 + var_390_1 and arg_387_1.time_ < 0 + var_390_1 + arg_390_0 then
				arg_387_1.actors_["1061"].transform.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_390_2 = arg_387_1.actors_["1061"]

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 and not isNil(var_390_2) and arg_387_1.var_.actorSpriteComps1061 == nil then
				arg_387_1.var_.actorSpriteComps1061 = var_390_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_390_3 = 0.034

			if 0 <= arg_387_1.time_ and arg_387_1.time_ < 0 + var_390_3 and not isNil(var_390_2) then
				if arg_387_1.var_.actorSpriteComps1061 then
					for iter_390_1, iter_390_2 in pairs(arg_387_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_390_2 then
							if arg_387_1.isInRecall_ then
								iter_390_2.color = Color.New(Mathf.Lerp(iter_390_2.color.r, arg_387_1.hightColor1.r, (arg_387_1.time_ - 0) / var_390_3), Mathf.Lerp(iter_390_2.color.g, arg_387_1.hightColor1.g, (arg_387_1.time_ - 0) / var_390_3), (Mathf.Lerp(iter_390_2.color.b, arg_387_1.hightColor1.b, (arg_387_1.time_ - 0) / var_390_3)))
							else
								local var_390_4 = Mathf.Lerp(iter_390_2.color.r, 1, (arg_387_1.time_ - 0) / var_390_3)

								iter_390_2.color = Color.New(var_390_4, var_390_4, var_390_4)
							end
						end
					end
				end
			end

			if arg_387_1.time_ >= 0 + var_390_3 and arg_387_1.time_ < 0 + var_390_3 + arg_390_0 and not isNil(var_390_2) and arg_387_1.var_.actorSpriteComps1061 then
				for iter_390_3, iter_390_4 in pairs(arg_387_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_390_4 then
						iter_390_4.color = arg_387_1.isInRecall_ and (arg_387_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_387_1.var_.actorSpriteComps1061 = nil
			end

			local var_390_5 = 0
			local var_390_6 = 1.425

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= var_390_5 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0
				arg_387_1.dialogCg_.alpha = 1

				arg_387_1.dialog_:SetActive(true)
				SetActive(arg_387_1.leftNameGo_, true)

				arg_387_1.leftNameTxt_.text = arg_387_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_387_1.leftNameTxt_.transform)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1.leftNameTxt_.text)
				SetActive(arg_387_1.iconTrs_.gameObject, false)
				arg_387_1.callingController_:SetSelectedState("normal")

				local var_390_7 = arg_387_1:GetWordFromCfg(410161094)
				local var_390_8 = arg_387_1:FormatText(var_390_7.content)

				arg_387_1.text_.text = var_390_8

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_10 = 57 <= 0 and var_390_6 or var_390_6 * (utf8.len(var_390_8) / 57)

				if (57 <= 0 and var_390_6 or var_390_6 * (utf8.len(var_390_8) / 57)) > 0 and var_390_6 < var_390_10 then
					arg_387_1.talkMaxDuration = var_390_10

					if var_390_10 + var_390_5 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_10 + var_390_5
					end
				end

				arg_387_1.text_.text = var_390_8
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161094", "story_v_out_410161.awb") ~= 0 then
					local var_390_11 = manager.audio:GetVoiceLength("story_v_out_410161", "410161094", "story_v_out_410161.awb") / 1000

					if var_390_11 + var_390_5 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_11 + var_390_5
					end

					if var_390_7.prefab_name ~= "" and arg_387_1.actors_[var_390_7.prefab_name] ~= nil then
						local var_390_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_387_1.actors_[var_390_7.prefab_name].transform, "story_v_out_410161", "410161094", "story_v_out_410161.awb")

						arg_387_1:RecordAudio("410161094", var_390_12)
						arg_387_1:RecordAudio("410161094", var_390_12)
					else
						arg_387_1:AudioAction("play", "voice", "story_v_out_410161", "410161094", "story_v_out_410161.awb")
					end

					arg_387_1:RecordHistoryTalkVoice("story_v_out_410161", "410161094", "story_v_out_410161.awb")
				end

				arg_387_1:RecordContent(arg_387_1.text_.text)
			end

			local var_390_13 = math.max(var_390_6, arg_387_1.talkMaxDuration)

			if var_390_5 <= arg_387_1.time_ and arg_387_1.time_ < var_390_5 + var_390_13 then
				arg_387_1.typewritter.percent = (arg_387_1.time_ - var_390_5) / var_390_13

				arg_387_1.typewritter:SetDirty()
			end

			if arg_387_1.time_ >= var_390_5 + var_390_13 and arg_387_1.time_ < var_390_5 + var_390_13 + arg_390_0 then
				arg_387_1.typewritter.percent = 1

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(true)
			end
		end

		arg_387_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_387_1:InitPlayNodeList()
	end,
	Play410161095 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 410161095
		arg_391_1.duration_ = 5

		SetActive(arg_391_1.tipsGo_, false)

		function arg_391_1.onSingleLineFinish_()
			arg_391_1.onSingleLineUpdate_ = nil
			arg_391_1.onSingleLineFinish_ = nil
			arg_391_1.state_ = "waiting"
		end

		function arg_391_1.playNext_(arg_393_0)
			if arg_393_0 == 1 then
				arg_391_0:Play410161096(arg_391_1)
			end
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 and not isNil(arg_391_1.actors_["1061"]) and arg_391_1.var_.actorSpriteComps1061 == nil then
				arg_391_1.var_.actorSpriteComps1061 = arg_391_1.actors_["1061"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_394_0 = 0.034

			if 0 <= arg_391_1.time_ and arg_391_1.time_ < 0 + var_394_0 and not isNil(arg_391_1.actors_["1061"]) then
				if arg_391_1.var_.actorSpriteComps1061 then
					for iter_394_0, iter_394_1 in pairs(arg_391_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_394_1 then
							if arg_391_1.isInRecall_ then
								iter_394_1.color = Color.New(Mathf.Lerp(iter_394_1.color.r, arg_391_1.hightColor2.r, (arg_391_1.time_ - 0) / var_394_0), Mathf.Lerp(iter_394_1.color.g, arg_391_1.hightColor2.g, (arg_391_1.time_ - 0) / var_394_0), (Mathf.Lerp(iter_394_1.color.b, arg_391_1.hightColor2.b, (arg_391_1.time_ - 0) / var_394_0)))
							else
								local var_394_1 = Mathf.Lerp(iter_394_1.color.r, 0.5, (arg_391_1.time_ - 0) / var_394_0)

								iter_394_1.color = Color.New(var_394_1, var_394_1, var_394_1)
							end
						end
					end
				end
			end

			if arg_391_1.time_ >= 0 + var_394_0 and arg_391_1.time_ < 0 + var_394_0 + arg_394_0 and not isNil(arg_391_1.actors_["1061"]) and arg_391_1.var_.actorSpriteComps1061 then
				for iter_394_2, iter_394_3 in pairs(arg_391_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_394_3 then
						iter_394_3.color = arg_391_1.isInRecall_ and (arg_391_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_391_1.var_.actorSpriteComps1061 = nil
			end

			local var_394_2 = arg_391_1.actors_["10059"]

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 and not isNil(var_394_2) and arg_391_1.var_.actorSpriteComps10059 == nil then
				arg_391_1.var_.actorSpriteComps10059 = var_394_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_394_3 = 0.034

			if 0 <= arg_391_1.time_ and arg_391_1.time_ < 0 + var_394_3 and not isNil(var_394_2) then
				if arg_391_1.var_.actorSpriteComps10059 then
					for iter_394_4, iter_394_5 in pairs(arg_391_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_394_5 then
							if arg_391_1.isInRecall_ then
								iter_394_5.color = Color.New(Mathf.Lerp(iter_394_5.color.r, arg_391_1.hightColor2.r, (arg_391_1.time_ - 0) / var_394_3), Mathf.Lerp(iter_394_5.color.g, arg_391_1.hightColor2.g, (arg_391_1.time_ - 0) / var_394_3), (Mathf.Lerp(iter_394_5.color.b, arg_391_1.hightColor2.b, (arg_391_1.time_ - 0) / var_394_3)))
							else
								local var_394_4 = Mathf.Lerp(iter_394_5.color.r, 0.5, (arg_391_1.time_ - 0) / var_394_3)

								iter_394_5.color = Color.New(var_394_4, var_394_4, var_394_4)
							end
						end
					end
				end
			end

			if arg_391_1.time_ >= 0 + var_394_3 and arg_391_1.time_ < 0 + var_394_3 + arg_394_0 and not isNil(var_394_2) and arg_391_1.var_.actorSpriteComps10059 then
				for iter_394_6, iter_394_7 in pairs(arg_391_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_394_7 then
						iter_394_7.color = arg_391_1.isInRecall_ and (arg_391_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_391_1.var_.actorSpriteComps10059 = nil
			end

			local var_394_5 = 0
			local var_394_6 = 1

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= var_394_5 + arg_394_0 then
				arg_391_1.talkMaxDuration = 0
				arg_391_1.dialogCg_.alpha = 1

				arg_391_1.dialog_:SetActive(true)
				SetActive(arg_391_1.leftNameGo_, false)

				arg_391_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_391_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_391_1:RecordName(arg_391_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_391_1.iconTrs_.gameObject, false)
				arg_391_1.callingController_:SetSelectedState("normal")

				local var_394_7 = arg_391_1:FormatText(arg_391_1:GetWordFromCfg(410161095).content)

				arg_391_1.text_.text = var_394_7

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_9 = 40 <= 0 and var_394_6 or var_394_6 * (utf8.len(var_394_7) / 40)

				if (40 <= 0 and var_394_6 or var_394_6 * (utf8.len(var_394_7) / 40)) > 0 and var_394_6 < var_394_9 then
					arg_391_1.talkMaxDuration = var_394_9

					if var_394_9 + var_394_5 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_9 + var_394_5
					end
				end

				arg_391_1.text_.text = var_394_7
				arg_391_1.typewritter.percent = 0

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(false)
				arg_391_1:RecordContent(arg_391_1.text_.text)
			end

			local var_394_10 = math.max(var_394_6, arg_391_1.talkMaxDuration)

			if var_394_5 <= arg_391_1.time_ and arg_391_1.time_ < var_394_5 + var_394_10 then
				arg_391_1.typewritter.percent = (arg_391_1.time_ - var_394_5) / var_394_10

				arg_391_1.typewritter:SetDirty()
			end

			if arg_391_1.time_ >= var_394_5 + var_394_10 and arg_391_1.time_ < var_394_5 + var_394_10 + arg_394_0 then
				arg_391_1.typewritter.percent = 1

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(true)
			end
		end

		arg_391_1.nodeConfigList_ = {}

		arg_391_1:InitPlayNodeList()
	end,
	Play410161096 = function(arg_395_0, arg_395_1)
		arg_395_1.time_ = 0
		arg_395_1.frameCnt_ = 0
		arg_395_1.state_ = "playing"
		arg_395_1.curTalkId_ = 410161096
		arg_395_1.duration_ = 6.77

		local var_395_0 = {
			ja = 6.766,
			CriLanguages = 3.833,
			zh = 3.833
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
				arg_395_0:Play410161097(arg_395_1)
			end
		end

		function arg_395_1.onSingleLineUpdate_(arg_398_0)
			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 then
				arg_395_1.var_.moveOldPos10059 = arg_395_1.actors_["10059"].transform.localPosition
				arg_395_1.actors_["10059"].transform.localScale = Vector3.New(1, 1, 1)

				arg_395_1:CheckSpriteTmpPos("10059", 4)

				for iter_398_0 = 0, arg_395_1.actors_["10059"].transform.childCount - 1 do
					local var_398_0 = arg_395_1.actors_["10059"].transform:GetChild(iter_398_0)

					if var_398_0.name == "" or not string.find(var_398_0.name, "split") then
						var_398_0.gameObject:SetActive(true)
					else
						var_398_0.gameObject:SetActive(false)
					end
				end
			end

			local var_398_1 = 0.001

			if 0 <= arg_395_1.time_ and arg_395_1.time_ < 0 + var_398_1 then
				arg_395_1.actors_["10059"].transform.localPosition = Vector3.Lerp(arg_395_1.var_.moveOldPos10059, Vector3.New(390, -530, 35), (arg_395_1.time_ - 0) / var_398_1)
			end

			if arg_395_1.time_ >= 0 + var_398_1 and arg_395_1.time_ < 0 + var_398_1 + arg_398_0 then
				arg_395_1.actors_["10059"].transform.localPosition = Vector3.New(390, -530, 35)
			end

			local var_398_2 = arg_395_1.actors_["10059"]

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 and not isNil(var_398_2) and arg_395_1.var_.actorSpriteComps10059 == nil then
				arg_395_1.var_.actorSpriteComps10059 = var_398_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_398_3 = 0.034

			if 0 <= arg_395_1.time_ and arg_395_1.time_ < 0 + var_398_3 and not isNil(var_398_2) then
				if arg_395_1.var_.actorSpriteComps10059 then
					for iter_398_1, iter_398_2 in pairs(arg_395_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_398_2 then
							if arg_395_1.isInRecall_ then
								iter_398_2.color = Color.New(Mathf.Lerp(iter_398_2.color.r, arg_395_1.hightColor1.r, (arg_395_1.time_ - 0) / var_398_3), Mathf.Lerp(iter_398_2.color.g, arg_395_1.hightColor1.g, (arg_395_1.time_ - 0) / var_398_3), (Mathf.Lerp(iter_398_2.color.b, arg_395_1.hightColor1.b, (arg_395_1.time_ - 0) / var_398_3)))
							else
								local var_398_4 = Mathf.Lerp(iter_398_2.color.r, 1, (arg_395_1.time_ - 0) / var_398_3)

								iter_398_2.color = Color.New(var_398_4, var_398_4, var_398_4)
							end
						end
					end
				end
			end

			if arg_395_1.time_ >= 0 + var_398_3 and arg_395_1.time_ < 0 + var_398_3 + arg_398_0 and not isNil(var_398_2) and arg_395_1.var_.actorSpriteComps10059 then
				for iter_398_3, iter_398_4 in pairs(arg_395_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_398_4 then
						iter_398_4.color = arg_395_1.isInRecall_ and (arg_395_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_395_1.var_.actorSpriteComps10059 = nil
			end

			local var_398_5 = 0
			local var_398_6 = 0.4

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= var_398_5 + arg_398_0 then
				arg_395_1.talkMaxDuration = 0
				arg_395_1.dialogCg_.alpha = 1

				arg_395_1.dialog_:SetActive(true)
				SetActive(arg_395_1.leftNameGo_, true)

				arg_395_1.leftNameTxt_.text = arg_395_1:FormatText(StoryNameCfg[596].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_395_1.leftNameTxt_.transform)

				arg_395_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_395_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_395_1:RecordName(arg_395_1.leftNameTxt_.text)
				SetActive(arg_395_1.iconTrs_.gameObject, false)
				arg_395_1.callingController_:SetSelectedState("normal")

				local var_398_7 = arg_395_1:GetWordFromCfg(410161096)
				local var_398_8 = arg_395_1:FormatText(var_398_7.content)

				arg_395_1.text_.text = var_398_8

				LuaForUtil.ClearLinePrefixSymbol(arg_395_1.text_)

				local var_398_10 = 16 <= 0 and var_398_6 or var_398_6 * (utf8.len(var_398_8) / 16)

				if (16 <= 0 and var_398_6 or var_398_6 * (utf8.len(var_398_8) / 16)) > 0 and var_398_6 < var_398_10 then
					arg_395_1.talkMaxDuration = var_398_10

					if var_398_10 + var_398_5 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_10 + var_398_5
					end
				end

				arg_395_1.text_.text = var_398_8
				arg_395_1.typewritter.percent = 0

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161096", "story_v_out_410161.awb") ~= 0 then
					local var_398_11 = manager.audio:GetVoiceLength("story_v_out_410161", "410161096", "story_v_out_410161.awb") / 1000

					if var_398_11 + var_398_5 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_11 + var_398_5
					end

					if var_398_7.prefab_name ~= "" and arg_395_1.actors_[var_398_7.prefab_name] ~= nil then
						local var_398_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_395_1.actors_[var_398_7.prefab_name].transform, "story_v_out_410161", "410161096", "story_v_out_410161.awb")

						arg_395_1:RecordAudio("410161096", var_398_12)
						arg_395_1:RecordAudio("410161096", var_398_12)
					else
						arg_395_1:AudioAction("play", "voice", "story_v_out_410161", "410161096", "story_v_out_410161.awb")
					end

					arg_395_1:RecordHistoryTalkVoice("story_v_out_410161", "410161096", "story_v_out_410161.awb")
				end

				arg_395_1:RecordContent(arg_395_1.text_.text)
			end

			local var_398_13 = math.max(var_398_6, arg_395_1.talkMaxDuration)

			if var_398_5 <= arg_395_1.time_ and arg_395_1.time_ < var_398_5 + var_398_13 then
				arg_395_1.typewritter.percent = (arg_395_1.time_ - var_398_5) / var_398_13

				arg_395_1.typewritter:SetDirty()
			end

			if arg_395_1.time_ >= var_398_5 + var_398_13 and arg_395_1.time_ < var_398_5 + var_398_13 + arg_398_0 then
				arg_395_1.typewritter.percent = 1

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(true)
			end
		end

		arg_395_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_395_1:InitPlayNodeList()
	end,
	Play410161097 = function(arg_399_0, arg_399_1)
		arg_399_1.time_ = 0
		arg_399_1.frameCnt_ = 0
		arg_399_1.state_ = "playing"
		arg_399_1.curTalkId_ = 410161097
		arg_399_1.duration_ = 10.27

		local var_399_0 = {
			ja = 10.266,
			CriLanguages = 5,
			zh = 5
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
				arg_399_0:Play410161098(arg_399_1)
			end
		end

		function arg_399_1.onSingleLineUpdate_(arg_402_0)
			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 then
				arg_399_1.var_.moveOldPos1061 = arg_399_1.actors_["1061"].transform.localPosition
				arg_399_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_399_1:CheckSpriteTmpPos("1061", 2)

				for iter_402_0 = 0, arg_399_1.actors_["1061"].transform.childCount - 1 do
					local var_402_0 = arg_399_1.actors_["1061"].transform:GetChild(iter_402_0)

					if var_402_0.name == "split_5" or not string.find(var_402_0.name, "split") then
						var_402_0.gameObject:SetActive(true)
					else
						var_402_0.gameObject:SetActive(false)
					end
				end
			end

			local var_402_1 = 0.001

			if 0 <= arg_399_1.time_ and arg_399_1.time_ < 0 + var_402_1 then
				arg_399_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_399_1.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (arg_399_1.time_ - 0) / var_402_1)
			end

			if arg_399_1.time_ >= 0 + var_402_1 and arg_399_1.time_ < 0 + var_402_1 + arg_402_0 then
				arg_399_1.actors_["1061"].transform.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_402_2 = arg_399_1.actors_["1061"]

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 and not isNil(var_402_2) and arg_399_1.var_.actorSpriteComps1061 == nil then
				arg_399_1.var_.actorSpriteComps1061 = var_402_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_402_3 = 0.034

			if 0 <= arg_399_1.time_ and arg_399_1.time_ < 0 + var_402_3 and not isNil(var_402_2) then
				if arg_399_1.var_.actorSpriteComps1061 then
					for iter_402_1, iter_402_2 in pairs(arg_399_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_402_2 then
							if arg_399_1.isInRecall_ then
								iter_402_2.color = Color.New(Mathf.Lerp(iter_402_2.color.r, arg_399_1.hightColor1.r, (arg_399_1.time_ - 0) / var_402_3), Mathf.Lerp(iter_402_2.color.g, arg_399_1.hightColor1.g, (arg_399_1.time_ - 0) / var_402_3), (Mathf.Lerp(iter_402_2.color.b, arg_399_1.hightColor1.b, (arg_399_1.time_ - 0) / var_402_3)))
							else
								local var_402_4 = Mathf.Lerp(iter_402_2.color.r, 1, (arg_399_1.time_ - 0) / var_402_3)

								iter_402_2.color = Color.New(var_402_4, var_402_4, var_402_4)
							end
						end
					end
				end
			end

			if arg_399_1.time_ >= 0 + var_402_3 and arg_399_1.time_ < 0 + var_402_3 + arg_402_0 and not isNil(var_402_2) and arg_399_1.var_.actorSpriteComps1061 then
				for iter_402_3, iter_402_4 in pairs(arg_399_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_402_4 then
						iter_402_4.color = arg_399_1.isInRecall_ and (arg_399_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_399_1.var_.actorSpriteComps1061 = nil
			end

			local var_402_5 = arg_399_1.actors_["10059"]

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 and not isNil(var_402_5) and arg_399_1.var_.actorSpriteComps10059 == nil then
				arg_399_1.var_.actorSpriteComps10059 = var_402_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_402_6 = 0.034

			if 0 <= arg_399_1.time_ and arg_399_1.time_ < 0 + var_402_6 and not isNil(var_402_5) then
				if arg_399_1.var_.actorSpriteComps10059 then
					for iter_402_5, iter_402_6 in pairs(arg_399_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_402_6 then
							if arg_399_1.isInRecall_ then
								iter_402_6.color = Color.New(Mathf.Lerp(iter_402_6.color.r, arg_399_1.hightColor2.r, (arg_399_1.time_ - 0) / var_402_6), Mathf.Lerp(iter_402_6.color.g, arg_399_1.hightColor2.g, (arg_399_1.time_ - 0) / var_402_6), (Mathf.Lerp(iter_402_6.color.b, arg_399_1.hightColor2.b, (arg_399_1.time_ - 0) / var_402_6)))
							else
								local var_402_7 = Mathf.Lerp(iter_402_6.color.r, 0.5, (arg_399_1.time_ - 0) / var_402_6)

								iter_402_6.color = Color.New(var_402_7, var_402_7, var_402_7)
							end
						end
					end
				end
			end

			if arg_399_1.time_ >= 0 + var_402_6 and arg_399_1.time_ < 0 + var_402_6 + arg_402_0 and not isNil(var_402_5) and arg_399_1.var_.actorSpriteComps10059 then
				for iter_402_7, iter_402_8 in pairs(arg_399_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_402_8 then
						iter_402_8.color = arg_399_1.isInRecall_ and (arg_399_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_399_1.var_.actorSpriteComps10059 = nil
			end

			local var_402_8 = 0
			local var_402_9 = 0.575

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= var_402_8 + arg_402_0 then
				arg_399_1.talkMaxDuration = 0
				arg_399_1.dialogCg_.alpha = 1

				arg_399_1.dialog_:SetActive(true)
				SetActive(arg_399_1.leftNameGo_, true)

				arg_399_1.leftNameTxt_.text = arg_399_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_399_1.leftNameTxt_.transform)

				arg_399_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_399_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_399_1:RecordName(arg_399_1.leftNameTxt_.text)
				SetActive(arg_399_1.iconTrs_.gameObject, false)
				arg_399_1.callingController_:SetSelectedState("normal")

				local var_402_10 = arg_399_1:GetWordFromCfg(410161097)
				local var_402_11 = arg_399_1:FormatText(var_402_10.content)

				arg_399_1.text_.text = var_402_11

				LuaForUtil.ClearLinePrefixSymbol(arg_399_1.text_)

				local var_402_13 = 23 <= 0 and var_402_9 or var_402_9 * (utf8.len(var_402_11) / 23)

				if (23 <= 0 and var_402_9 or var_402_9 * (utf8.len(var_402_11) / 23)) > 0 and var_402_9 < var_402_13 then
					arg_399_1.talkMaxDuration = var_402_13

					if var_402_13 + var_402_8 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_13 + var_402_8
					end
				end

				arg_399_1.text_.text = var_402_11
				arg_399_1.typewritter.percent = 0

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161097", "story_v_out_410161.awb") ~= 0 then
					local var_402_14 = manager.audio:GetVoiceLength("story_v_out_410161", "410161097", "story_v_out_410161.awb") / 1000

					if var_402_14 + var_402_8 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_14 + var_402_8
					end

					if var_402_10.prefab_name ~= "" and arg_399_1.actors_[var_402_10.prefab_name] ~= nil then
						local var_402_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_399_1.actors_[var_402_10.prefab_name].transform, "story_v_out_410161", "410161097", "story_v_out_410161.awb")

						arg_399_1:RecordAudio("410161097", var_402_15)
						arg_399_1:RecordAudio("410161097", var_402_15)
					else
						arg_399_1:AudioAction("play", "voice", "story_v_out_410161", "410161097", "story_v_out_410161.awb")
					end

					arg_399_1:RecordHistoryTalkVoice("story_v_out_410161", "410161097", "story_v_out_410161.awb")
				end

				arg_399_1:RecordContent(arg_399_1.text_.text)
			end

			local var_402_16 = math.max(var_402_9, arg_399_1.talkMaxDuration)

			if var_402_8 <= arg_399_1.time_ and arg_399_1.time_ < var_402_8 + var_402_16 then
				arg_399_1.typewritter.percent = (arg_399_1.time_ - var_402_8) / var_402_16

				arg_399_1.typewritter:SetDirty()
			end

			if arg_399_1.time_ >= var_402_8 + var_402_16 and arg_399_1.time_ < var_402_8 + var_402_16 + arg_402_0 then
				arg_399_1.typewritter.percent = 1

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(true)
			end
		end

		arg_399_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_399_1:InitPlayNodeList()
	end,
	Play410161098 = function(arg_403_0, arg_403_1)
		arg_403_1.time_ = 0
		arg_403_1.frameCnt_ = 0
		arg_403_1.state_ = "playing"
		arg_403_1.curTalkId_ = 410161098
		arg_403_1.duration_ = 6.87

		local var_403_0 = {
			ja = 6.866,
			CriLanguages = 3.633,
			zh = 3.633
		}
		local var_403_1 = manager.audio:GetLocalizationFlag()

		if var_403_0[var_403_1] ~= nil then
			arg_403_1.duration_ = var_403_0[var_403_1]
		end

		SetActive(arg_403_1.tipsGo_, false)

		function arg_403_1.onSingleLineFinish_()
			arg_403_1.onSingleLineUpdate_ = nil
			arg_403_1.onSingleLineFinish_ = nil
			arg_403_1.state_ = "waiting"
		end

		function arg_403_1.playNext_(arg_405_0)
			if arg_405_0 == 1 then
				arg_403_0:Play410161099(arg_403_1)
			end
		end

		function arg_403_1.onSingleLineUpdate_(arg_406_0)
			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 then
				arg_403_1.var_.moveOldPos10059 = arg_403_1.actors_["10059"].transform.localPosition
				arg_403_1.actors_["10059"].transform.localScale = Vector3.New(1, 1, 1)

				arg_403_1:CheckSpriteTmpPos("10059", 4)

				for iter_406_0 = 0, arg_403_1.actors_["10059"].transform.childCount - 1 do
					local var_406_0 = arg_403_1.actors_["10059"].transform:GetChild(iter_406_0)

					if var_406_0.name == "" or not string.find(var_406_0.name, "split") then
						var_406_0.gameObject:SetActive(true)
					else
						var_406_0.gameObject:SetActive(false)
					end
				end
			end

			local var_406_1 = 0.001

			if 0 <= arg_403_1.time_ and arg_403_1.time_ < 0 + var_406_1 then
				arg_403_1.actors_["10059"].transform.localPosition = Vector3.Lerp(arg_403_1.var_.moveOldPos10059, Vector3.New(390, -530, 35), (arg_403_1.time_ - 0) / var_406_1)
			end

			if arg_403_1.time_ >= 0 + var_406_1 and arg_403_1.time_ < 0 + var_406_1 + arg_406_0 then
				arg_403_1.actors_["10059"].transform.localPosition = Vector3.New(390, -530, 35)
			end

			local var_406_2 = arg_403_1.actors_["10059"]

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 and not isNil(var_406_2) and arg_403_1.var_.actorSpriteComps10059 == nil then
				arg_403_1.var_.actorSpriteComps10059 = var_406_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_406_3 = 0.034

			if 0 <= arg_403_1.time_ and arg_403_1.time_ < 0 + var_406_3 and not isNil(var_406_2) then
				if arg_403_1.var_.actorSpriteComps10059 then
					for iter_406_1, iter_406_2 in pairs(arg_403_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_406_2 then
							if arg_403_1.isInRecall_ then
								iter_406_2.color = Color.New(Mathf.Lerp(iter_406_2.color.r, arg_403_1.hightColor1.r, (arg_403_1.time_ - 0) / var_406_3), Mathf.Lerp(iter_406_2.color.g, arg_403_1.hightColor1.g, (arg_403_1.time_ - 0) / var_406_3), (Mathf.Lerp(iter_406_2.color.b, arg_403_1.hightColor1.b, (arg_403_1.time_ - 0) / var_406_3)))
							else
								local var_406_4 = Mathf.Lerp(iter_406_2.color.r, 1, (arg_403_1.time_ - 0) / var_406_3)

								iter_406_2.color = Color.New(var_406_4, var_406_4, var_406_4)
							end
						end
					end
				end
			end

			if arg_403_1.time_ >= 0 + var_406_3 and arg_403_1.time_ < 0 + var_406_3 + arg_406_0 and not isNil(var_406_2) and arg_403_1.var_.actorSpriteComps10059 then
				for iter_406_3, iter_406_4 in pairs(arg_403_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_406_4 then
						iter_406_4.color = arg_403_1.isInRecall_ and (arg_403_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_403_1.var_.actorSpriteComps10059 = nil
			end

			local var_406_5 = arg_403_1.actors_["1061"]

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 and not isNil(var_406_5) and arg_403_1.var_.actorSpriteComps1061 == nil then
				arg_403_1.var_.actorSpriteComps1061 = var_406_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_406_6 = 0.034

			if 0 <= arg_403_1.time_ and arg_403_1.time_ < 0 + var_406_6 and not isNil(var_406_5) then
				if arg_403_1.var_.actorSpriteComps1061 then
					for iter_406_5, iter_406_6 in pairs(arg_403_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_406_6 then
							if arg_403_1.isInRecall_ then
								iter_406_6.color = Color.New(Mathf.Lerp(iter_406_6.color.r, arg_403_1.hightColor2.r, (arg_403_1.time_ - 0) / var_406_6), Mathf.Lerp(iter_406_6.color.g, arg_403_1.hightColor2.g, (arg_403_1.time_ - 0) / var_406_6), (Mathf.Lerp(iter_406_6.color.b, arg_403_1.hightColor2.b, (arg_403_1.time_ - 0) / var_406_6)))
							else
								local var_406_7 = Mathf.Lerp(iter_406_6.color.r, 0.5, (arg_403_1.time_ - 0) / var_406_6)

								iter_406_6.color = Color.New(var_406_7, var_406_7, var_406_7)
							end
						end
					end
				end
			end

			if arg_403_1.time_ >= 0 + var_406_6 and arg_403_1.time_ < 0 + var_406_6 + arg_406_0 and not isNil(var_406_5) and arg_403_1.var_.actorSpriteComps1061 then
				for iter_406_7, iter_406_8 in pairs(arg_403_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_406_8 then
						iter_406_8.color = arg_403_1.isInRecall_ and (arg_403_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_403_1.var_.actorSpriteComps1061 = nil
			end

			local var_406_8 = 0
			local var_406_9 = 0.325

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= var_406_8 + arg_406_0 then
				arg_403_1.talkMaxDuration = 0
				arg_403_1.dialogCg_.alpha = 1

				arg_403_1.dialog_:SetActive(true)
				SetActive(arg_403_1.leftNameGo_, true)

				arg_403_1.leftNameTxt_.text = arg_403_1:FormatText(StoryNameCfg[596].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_403_1.leftNameTxt_.transform)

				arg_403_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_403_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_403_1:RecordName(arg_403_1.leftNameTxt_.text)
				SetActive(arg_403_1.iconTrs_.gameObject, false)
				arg_403_1.callingController_:SetSelectedState("normal")

				local var_406_10 = arg_403_1:GetWordFromCfg(410161098)
				local var_406_11 = arg_403_1:FormatText(var_406_10.content)

				arg_403_1.text_.text = var_406_11

				LuaForUtil.ClearLinePrefixSymbol(arg_403_1.text_)

				local var_406_13 = 13 <= 0 and var_406_9 or var_406_9 * (utf8.len(var_406_11) / 13)

				if (13 <= 0 and var_406_9 or var_406_9 * (utf8.len(var_406_11) / 13)) > 0 and var_406_9 < var_406_13 then
					arg_403_1.talkMaxDuration = var_406_13

					if var_406_13 + var_406_8 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_13 + var_406_8
					end
				end

				arg_403_1.text_.text = var_406_11
				arg_403_1.typewritter.percent = 0

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161098", "story_v_out_410161.awb") ~= 0 then
					local var_406_14 = manager.audio:GetVoiceLength("story_v_out_410161", "410161098", "story_v_out_410161.awb") / 1000

					if var_406_14 + var_406_8 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_14 + var_406_8
					end

					if var_406_10.prefab_name ~= "" and arg_403_1.actors_[var_406_10.prefab_name] ~= nil then
						local var_406_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_403_1.actors_[var_406_10.prefab_name].transform, "story_v_out_410161", "410161098", "story_v_out_410161.awb")

						arg_403_1:RecordAudio("410161098", var_406_15)
						arg_403_1:RecordAudio("410161098", var_406_15)
					else
						arg_403_1:AudioAction("play", "voice", "story_v_out_410161", "410161098", "story_v_out_410161.awb")
					end

					arg_403_1:RecordHistoryTalkVoice("story_v_out_410161", "410161098", "story_v_out_410161.awb")
				end

				arg_403_1:RecordContent(arg_403_1.text_.text)
			end

			local var_406_16 = math.max(var_406_9, arg_403_1.talkMaxDuration)

			if var_406_8 <= arg_403_1.time_ and arg_403_1.time_ < var_406_8 + var_406_16 then
				arg_403_1.typewritter.percent = (arg_403_1.time_ - var_406_8) / var_406_16

				arg_403_1.typewritter:SetDirty()
			end

			if arg_403_1.time_ >= var_406_8 + var_406_16 and arg_403_1.time_ < var_406_8 + var_406_16 + arg_406_0 then
				arg_403_1.typewritter.percent = 1

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(true)
			end
		end

		arg_403_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_403_1:InitPlayNodeList()
	end,
	Play410161099 = function(arg_407_0, arg_407_1)
		arg_407_1.time_ = 0
		arg_407_1.frameCnt_ = 0
		arg_407_1.state_ = "playing"
		arg_407_1.curTalkId_ = 410161099
		arg_407_1.duration_ = 5

		SetActive(arg_407_1.tipsGo_, false)

		function arg_407_1.onSingleLineFinish_()
			arg_407_1.onSingleLineUpdate_ = nil
			arg_407_1.onSingleLineFinish_ = nil
			arg_407_1.state_ = "waiting"
		end

		function arg_407_1.playNext_(arg_409_0)
			if arg_409_0 == 1 then
				arg_407_0:Play410161100(arg_407_1)
			end
		end

		function arg_407_1.onSingleLineUpdate_(arg_410_0)
			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 then
				arg_407_1.var_.moveOldPos1061 = arg_407_1.actors_["1061"].transform.localPosition
				arg_407_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_407_1:CheckSpriteTmpPos("1061", 7)

				for iter_410_0 = 0, arg_407_1.actors_["1061"].transform.childCount - 1 do
					local var_410_0 = arg_407_1.actors_["1061"].transform:GetChild(iter_410_0)

					if var_410_0.name == "" or not string.find(var_410_0.name, "split") then
						var_410_0.gameObject:SetActive(true)
					else
						var_410_0.gameObject:SetActive(false)
					end
				end
			end

			local var_410_1 = 0.001

			if 0 <= arg_407_1.time_ and arg_407_1.time_ < 0 + var_410_1 then
				arg_407_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_407_1.var_.moveOldPos1061, Vector3.New(0, -2000, 18), (arg_407_1.time_ - 0) / var_410_1)
			end

			if arg_407_1.time_ >= 0 + var_410_1 and arg_407_1.time_ < 0 + var_410_1 + arg_410_0 then
				arg_407_1.actors_["1061"].transform.localPosition = Vector3.New(0, -2000, 18)
			end

			local var_410_2 = arg_407_1.actors_["10059"].transform

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 then
				arg_407_1.var_.moveOldPos10059 = var_410_2.localPosition
				var_410_2.localScale = Vector3.New(1, 1, 1)

				arg_407_1:CheckSpriteTmpPos("10059", 3)

				for iter_410_1 = 0, var_410_2.childCount - 1 do
					local var_410_3 = var_410_2:GetChild(iter_410_1)

					if var_410_3.name == "" or not string.find(var_410_3.name, "split") then
						var_410_3.gameObject:SetActive(true)
					else
						var_410_3.gameObject:SetActive(false)
					end
				end
			end

			local var_410_4 = 0.001

			if 0 <= arg_407_1.time_ and arg_407_1.time_ < 0 + var_410_4 then
				var_410_2.localPosition = Vector3.Lerp(arg_407_1.var_.moveOldPos10059, Vector3.New(0, -530, 35), (arg_407_1.time_ - 0) / var_410_4)
			end

			if arg_407_1.time_ >= 0 + var_410_4 and arg_407_1.time_ < 0 + var_410_4 + arg_410_0 then
				var_410_2.localPosition = Vector3.New(0, -530, 35)
			end

			local var_410_5 = arg_407_1.actors_["1061"]

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 and not isNil(var_410_5) and arg_407_1.var_.actorSpriteComps1061 == nil then
				arg_407_1.var_.actorSpriteComps1061 = var_410_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_410_6 = 0.034

			if 0 <= arg_407_1.time_ and arg_407_1.time_ < 0 + var_410_6 and not isNil(var_410_5) then
				if arg_407_1.var_.actorSpriteComps1061 then
					for iter_410_2, iter_410_3 in pairs(arg_407_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_410_3 then
							if arg_407_1.isInRecall_ then
								iter_410_3.color = Color.New(Mathf.Lerp(iter_410_3.color.r, arg_407_1.hightColor2.r, (arg_407_1.time_ - 0) / var_410_6), Mathf.Lerp(iter_410_3.color.g, arg_407_1.hightColor2.g, (arg_407_1.time_ - 0) / var_410_6), (Mathf.Lerp(iter_410_3.color.b, arg_407_1.hightColor2.b, (arg_407_1.time_ - 0) / var_410_6)))
							else
								local var_410_7 = Mathf.Lerp(iter_410_3.color.r, 0.5, (arg_407_1.time_ - 0) / var_410_6)

								iter_410_3.color = Color.New(var_410_7, var_410_7, var_410_7)
							end
						end
					end
				end
			end

			if arg_407_1.time_ >= 0 + var_410_6 and arg_407_1.time_ < 0 + var_410_6 + arg_410_0 and not isNil(var_410_5) and arg_407_1.var_.actorSpriteComps1061 then
				for iter_410_4, iter_410_5 in pairs(arg_407_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_410_5 then
						iter_410_5.color = arg_407_1.isInRecall_ and (arg_407_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_407_1.var_.actorSpriteComps1061 = nil
			end

			local var_410_8 = arg_407_1.actors_["10059"]

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 and not isNil(var_410_8) and arg_407_1.var_.actorSpriteComps10059 == nil then
				arg_407_1.var_.actorSpriteComps10059 = var_410_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_410_9 = 0.034

			if 0 <= arg_407_1.time_ and arg_407_1.time_ < 0 + var_410_9 and not isNil(var_410_8) then
				if arg_407_1.var_.actorSpriteComps10059 then
					for iter_410_6, iter_410_7 in pairs(arg_407_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_410_7 then
							if arg_407_1.isInRecall_ then
								iter_410_7.color = Color.New(Mathf.Lerp(iter_410_7.color.r, arg_407_1.hightColor2.r, (arg_407_1.time_ - 0) / var_410_9), Mathf.Lerp(iter_410_7.color.g, arg_407_1.hightColor2.g, (arg_407_1.time_ - 0) / var_410_9), (Mathf.Lerp(iter_410_7.color.b, arg_407_1.hightColor2.b, (arg_407_1.time_ - 0) / var_410_9)))
							else
								local var_410_10 = Mathf.Lerp(iter_410_7.color.r, 0.5, (arg_407_1.time_ - 0) / var_410_9)

								iter_410_7.color = Color.New(var_410_10, var_410_10, var_410_10)
							end
						end
					end
				end
			end

			if arg_407_1.time_ >= 0 + var_410_9 and arg_407_1.time_ < 0 + var_410_9 + arg_410_0 and not isNil(var_410_8) and arg_407_1.var_.actorSpriteComps10059 then
				for iter_410_8, iter_410_9 in pairs(arg_407_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_410_9 then
						iter_410_9.color = arg_407_1.isInRecall_ and (arg_407_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_407_1.var_.actorSpriteComps10059 = nil
			end

			local var_410_11 = 0
			local var_410_12 = 0.8

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= var_410_11 + arg_410_0 then
				arg_407_1.talkMaxDuration = 0
				arg_407_1.dialogCg_.alpha = 1

				arg_407_1.dialog_:SetActive(true)
				SetActive(arg_407_1.leftNameGo_, false)

				arg_407_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_407_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_407_1:RecordName(arg_407_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_407_1.iconTrs_.gameObject, false)
				arg_407_1.callingController_:SetSelectedState("normal")

				local var_410_13 = arg_407_1:FormatText(arg_407_1:GetWordFromCfg(410161099).content)

				arg_407_1.text_.text = var_410_13

				LuaForUtil.ClearLinePrefixSymbol(arg_407_1.text_)

				local var_410_15 = 32 <= 0 and var_410_12 or var_410_12 * (utf8.len(var_410_13) / 32)

				if (32 <= 0 and var_410_12 or var_410_12 * (utf8.len(var_410_13) / 32)) > 0 and var_410_12 < var_410_15 then
					arg_407_1.talkMaxDuration = var_410_15

					if var_410_15 + var_410_11 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_15 + var_410_11
					end
				end

				arg_407_1.text_.text = var_410_13
				arg_407_1.typewritter.percent = 0

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(false)
				arg_407_1:RecordContent(arg_407_1.text_.text)
			end

			local var_410_16 = math.max(var_410_12, arg_407_1.talkMaxDuration)

			if var_410_11 <= arg_407_1.time_ and arg_407_1.time_ < var_410_11 + var_410_16 then
				arg_407_1.typewritter.percent = (arg_407_1.time_ - var_410_11) / var_410_16

				arg_407_1.typewritter:SetDirty()
			end

			if arg_407_1.time_ >= var_410_11 + var_410_16 and arg_407_1.time_ < var_410_11 + var_410_16 + arg_410_0 then
				arg_407_1.typewritter.percent = 1

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(true)
			end
		end

		arg_407_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_407_1:InitPlayNodeList()
	end,
	Play410161100 = function(arg_411_0, arg_411_1)
		arg_411_1.time_ = 0
		arg_411_1.frameCnt_ = 0
		arg_411_1.state_ = "playing"
		arg_411_1.curTalkId_ = 410161100
		arg_411_1.duration_ = 4.23

		local var_411_0 = {
			ja = 4.233,
			CriLanguages = 4,
			zh = 4
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
			arg_411_1.auto_ = false
		end

		function arg_411_1.playNext_(arg_413_0)
			arg_411_1.onStoryFinished_()
		end

		function arg_411_1.onSingleLineUpdate_(arg_414_0)
			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 then
				arg_411_1.var_.moveOldPos10059 = arg_411_1.actors_["10059"].transform.localPosition
				arg_411_1.actors_["10059"].transform.localScale = Vector3.New(1, 1, 1)

				arg_411_1:CheckSpriteTmpPos("10059", 3)

				for iter_414_0 = 0, arg_411_1.actors_["10059"].transform.childCount - 1 do
					local var_414_0 = arg_411_1.actors_["10059"].transform:GetChild(iter_414_0)

					if var_414_0.name == "" or not string.find(var_414_0.name, "split") then
						var_414_0.gameObject:SetActive(true)
					else
						var_414_0.gameObject:SetActive(false)
					end
				end
			end

			local var_414_1 = 0.001

			if 0 <= arg_411_1.time_ and arg_411_1.time_ < 0 + var_414_1 then
				arg_411_1.actors_["10059"].transform.localPosition = Vector3.Lerp(arg_411_1.var_.moveOldPos10059, Vector3.New(0, -530, 35), (arg_411_1.time_ - 0) / var_414_1)
			end

			if arg_411_1.time_ >= 0 + var_414_1 and arg_411_1.time_ < 0 + var_414_1 + arg_414_0 then
				arg_411_1.actors_["10059"].transform.localPosition = Vector3.New(0, -530, 35)
			end

			local var_414_2 = arg_411_1.actors_["10059"]

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 and not isNil(var_414_2) and arg_411_1.var_.actorSpriteComps10059 == nil then
				arg_411_1.var_.actorSpriteComps10059 = var_414_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_414_3 = 0.034

			if 0 <= arg_411_1.time_ and arg_411_1.time_ < 0 + var_414_3 and not isNil(var_414_2) then
				if arg_411_1.var_.actorSpriteComps10059 then
					for iter_414_1, iter_414_2 in pairs(arg_411_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_414_2 then
							if arg_411_1.isInRecall_ then
								iter_414_2.color = Color.New(Mathf.Lerp(iter_414_2.color.r, arg_411_1.hightColor1.r, (arg_411_1.time_ - 0) / var_414_3), Mathf.Lerp(iter_414_2.color.g, arg_411_1.hightColor1.g, (arg_411_1.time_ - 0) / var_414_3), (Mathf.Lerp(iter_414_2.color.b, arg_411_1.hightColor1.b, (arg_411_1.time_ - 0) / var_414_3)))
							else
								local var_414_4 = Mathf.Lerp(iter_414_2.color.r, 1, (arg_411_1.time_ - 0) / var_414_3)

								iter_414_2.color = Color.New(var_414_4, var_414_4, var_414_4)
							end
						end
					end
				end
			end

			if arg_411_1.time_ >= 0 + var_414_3 and arg_411_1.time_ < 0 + var_414_3 + arg_414_0 and not isNil(var_414_2) and arg_411_1.var_.actorSpriteComps10059 then
				for iter_414_3, iter_414_4 in pairs(arg_411_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_414_4 then
						iter_414_4.color = arg_411_1.isInRecall_ and (arg_411_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_411_1.var_.actorSpriteComps10059 = nil
			end

			local var_414_5 = 0
			local var_414_6 = 0.325

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= var_414_5 + arg_414_0 then
				arg_411_1.talkMaxDuration = 0
				arg_411_1.dialogCg_.alpha = 1

				arg_411_1.dialog_:SetActive(true)
				SetActive(arg_411_1.leftNameGo_, true)

				arg_411_1.leftNameTxt_.text = arg_411_1:FormatText(StoryNameCfg[596].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_411_1.leftNameTxt_.transform)

				arg_411_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_411_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_411_1:RecordName(arg_411_1.leftNameTxt_.text)
				SetActive(arg_411_1.iconTrs_.gameObject, false)
				arg_411_1.callingController_:SetSelectedState("normal")

				local var_414_7 = arg_411_1:GetWordFromCfg(410161100)
				local var_414_8 = arg_411_1:FormatText(var_414_7.content)

				arg_411_1.text_.text = var_414_8

				LuaForUtil.ClearLinePrefixSymbol(arg_411_1.text_)

				local var_414_10 = 13 <= 0 and var_414_6 or var_414_6 * (utf8.len(var_414_8) / 13)

				if (13 <= 0 and var_414_6 or var_414_6 * (utf8.len(var_414_8) / 13)) > 0 and var_414_6 < var_414_10 then
					arg_411_1.talkMaxDuration = var_414_10

					if var_414_10 + var_414_5 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_10 + var_414_5
					end
				end

				arg_411_1.text_.text = var_414_8
				arg_411_1.typewritter.percent = 0

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161100", "story_v_out_410161.awb") ~= 0 then
					local var_414_11 = manager.audio:GetVoiceLength("story_v_out_410161", "410161100", "story_v_out_410161.awb") / 1000

					if var_414_11 + var_414_5 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_11 + var_414_5
					end

					if var_414_7.prefab_name ~= "" and arg_411_1.actors_[var_414_7.prefab_name] ~= nil then
						local var_414_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_411_1.actors_[var_414_7.prefab_name].transform, "story_v_out_410161", "410161100", "story_v_out_410161.awb")

						arg_411_1:RecordAudio("410161100", var_414_12)
						arg_411_1:RecordAudio("410161100", var_414_12)
					else
						arg_411_1:AudioAction("play", "voice", "story_v_out_410161", "410161100", "story_v_out_410161.awb")
					end

					arg_411_1:RecordHistoryTalkVoice("story_v_out_410161", "410161100", "story_v_out_410161.awb")
				end

				arg_411_1:RecordContent(arg_411_1.text_.text)
			end

			local var_414_13 = math.max(var_414_6, arg_411_1.talkMaxDuration)

			if var_414_5 <= arg_411_1.time_ and arg_411_1.time_ < var_414_5 + var_414_13 then
				arg_411_1.typewritter.percent = (arg_411_1.time_ - var_414_5) / var_414_13

				arg_411_1.typewritter:SetDirty()
			end

			if arg_411_1.time_ >= var_414_5 + var_414_13 and arg_411_1.time_ < var_414_5 + var_414_13 + arg_414_0 then
				arg_411_1.typewritter.percent = 1

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(true)
			end
		end

		arg_411_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_411_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST67",
		"TextureConfig/Background/L04f",
		"TextureConfig/Background/ST62",
		"TextureConfig/Background/ST63"
	},
	voices = {
		"story_v_out_410161.awb"
	}
}
