return {
	Play413041001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 413041001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play413041002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.F08f == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "F08f")
				var_4_0.name = "F08f"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.F08f = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.F08f

				arg_1_1.bgs_.F08f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "F08f" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 2

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
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

			if 0.366666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.366666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_4_story_crete", "bgm_activity_3_4_story_crete", "bgm_activity_3_4_story_crete.awb")

				local var_4_14 = manager.audio:GetAudioName("bgm_activity_3_4_story_crete", "bgm_activity_3_4_story_crete")

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

			if 0.366666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.366666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_121_04", "se_story_121_04_crowd_loop", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_16 = 2
			local var_4_17 = 1.2

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

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_19 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(413041001).content)

				arg_1_1.text_.text = var_4_19

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_21 = 48 <= 0 and var_4_17 or var_4_17 * (utf8.len(var_4_19) / 48)

				if (48 <= 0 and var_4_17 or var_4_17 * (utf8.len(var_4_19) / 48)) > 0 and var_4_17 < var_4_21 then
					arg_1_1.talkMaxDuration = var_4_21
					var_4_16 = var_4_16 + 0.3

					if var_4_21 + var_4_16 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_21 + var_4_16
					end
				end

				arg_1_1.text_.text = var_4_19
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_22 = var_4_16 + 0.3
			local var_4_23 = math.max(var_4_17, arg_1_1.talkMaxDuration)

			if var_4_16 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_22 + var_4_23 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_22) / var_4_23

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_22 + var_4_23 and arg_1_1.time_ < var_4_22 + var_4_23 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play413041002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 413041002
		arg_9_1.duration_ = 12.53

		local var_9_0 = {
			zh = 10.433,
			ja = 12.533
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
				arg_9_0:Play413041003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 1.175

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[995].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10096")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_1 = arg_9_1:GetWordFromCfg(413041002)
				local var_12_2 = arg_9_1:FormatText(var_12_1.content)

				arg_9_1.text_.text = var_12_2

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 47 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 47)

				if (47 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 47)) > 0 and var_12_0 < var_12_4 then
					arg_9_1.talkMaxDuration = var_12_4

					if var_12_4 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_4 + 0
					end
				end

				arg_9_1.text_.text = var_12_2
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413041", "413041002", "story_v_out_413041.awb") ~= 0 then
					local var_12_5 = manager.audio:GetVoiceLength("story_v_out_413041", "413041002", "story_v_out_413041.awb") / 1000

					if var_12_5 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_5 + 0
					end

					if var_12_1.prefab_name ~= "" and arg_9_1.actors_[var_12_1.prefab_name] ~= nil then
						local var_12_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_1.prefab_name].transform, "story_v_out_413041", "413041002", "story_v_out_413041.awb")

						arg_9_1:RecordAudio("413041002", var_12_6)
						arg_9_1:RecordAudio("413041002", var_12_6)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_413041", "413041002", "story_v_out_413041.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_413041", "413041002", "story_v_out_413041.awb")
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
	Play413041003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 413041003
		arg_13_1.duration_ = 3.33

		local var_13_0 = {
			zh = 3.333,
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
				arg_13_0:Play413041004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0.175

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[1000].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10096")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_1 = arg_13_1:GetWordFromCfg(413041003)
				local var_16_2 = arg_13_1:FormatText(var_16_1.content)

				arg_13_1.text_.text = var_16_2

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 7 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 7)

				if (7 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 7)) > 0 and var_16_0 < var_16_4 then
					arg_13_1.talkMaxDuration = var_16_4

					if var_16_4 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_4 + 0
					end
				end

				arg_13_1.text_.text = var_16_2
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413041", "413041003", "story_v_out_413041.awb") ~= 0 then
					local var_16_5 = manager.audio:GetVoiceLength("story_v_out_413041", "413041003", "story_v_out_413041.awb") / 1000

					if var_16_5 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_5 + 0
					end

					if var_16_1.prefab_name ~= "" and arg_13_1.actors_[var_16_1.prefab_name] ~= nil then
						local var_16_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_1.prefab_name].transform, "story_v_out_413041", "413041003", "story_v_out_413041.awb")

						arg_13_1:RecordAudio("413041003", var_16_6)
						arg_13_1:RecordAudio("413041003", var_16_6)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_413041", "413041003", "story_v_out_413041.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_413041", "413041003", "story_v_out_413041.awb")
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
	Play413041004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 413041004
		arg_17_1.duration_ = 7.47

		local var_17_0 = {
			zh = 3.9,
			ja = 7.466
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
				arg_17_0:Play413041005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0.425

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[998].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightwoman1")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_1 = arg_17_1:GetWordFromCfg(413041004)
				local var_20_2 = arg_17_1:FormatText(var_20_1.content)

				arg_17_1.text_.text = var_20_2

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_4 = 17 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_2) / 17)

				if (17 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_2) / 17)) > 0 and var_20_0 < var_20_4 then
					arg_17_1.talkMaxDuration = var_20_4

					if var_20_4 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_4 + 0
					end
				end

				arg_17_1.text_.text = var_20_2
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413041", "413041004", "story_v_out_413041.awb") ~= 0 then
					local var_20_5 = manager.audio:GetVoiceLength("story_v_out_413041", "413041004", "story_v_out_413041.awb") / 1000

					if var_20_5 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_5 + 0
					end

					if var_20_1.prefab_name ~= "" and arg_17_1.actors_[var_20_1.prefab_name] ~= nil then
						local var_20_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_1.prefab_name].transform, "story_v_out_413041", "413041004", "story_v_out_413041.awb")

						arg_17_1:RecordAudio("413041004", var_20_6)
						arg_17_1:RecordAudio("413041004", var_20_6)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_413041", "413041004", "story_v_out_413041.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_413041", "413041004", "story_v_out_413041.awb")
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
	Play413041005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 413041005
		arg_21_1.duration_ = 6.1

		local var_21_0 = {
			zh = 3.3,
			ja = 6.1
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
				arg_21_0:Play413041006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if arg_21_1.actors_["10022"] == nil then
				local var_24_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10022")

				if not isNil(var_24_0) then
					local var_24_1 = Object.Instantiate(var_24_0, arg_21_1.canvasGo_.transform)

					var_24_1.transform:SetSiblingIndex(1)

					var_24_1.name = "10022"
					var_24_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_21_1.actors_["10022"] = var_24_1

					if arg_21_1.isInRecall_ then
						for iter_24_0, iter_24_1 in ipairs((var_24_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_24_1.color = arg_21_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_24_2 = arg_21_1.actors_["10022"].transform

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos10022 = var_24_2.localPosition
				var_24_2.localScale = Vector3.New(1, 1, 1)

				arg_21_1:CheckSpriteTmpPos("10022", 3)

				for iter_24_2 = 0, var_24_2.childCount - 1 do
					local var_24_3 = var_24_2:GetChild(iter_24_2)

					if var_24_3.name == "split_8" or not string.find(var_24_3.name, "split") then
						var_24_3.gameObject:SetActive(true)
					else
						var_24_3.gameObject:SetActive(false)
					end
				end
			end

			local var_24_4 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_4 then
				var_24_2.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos10022, Vector3.New(0, -315, -320), (arg_21_1.time_ - 0) / var_24_4)
			end

			if arg_21_1.time_ >= 0 + var_24_4 and arg_21_1.time_ < 0 + var_24_4 + arg_24_0 then
				var_24_2.localPosition = Vector3.New(0, -315, -320)
			end

			local var_24_5 = arg_21_1.actors_["10022"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_5) and arg_21_1.var_.actorSpriteComps10022 == nil then
				arg_21_1.var_.actorSpriteComps10022 = var_24_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_6 = 2

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_6 and not isNil(var_24_5) then
				if arg_21_1.var_.actorSpriteComps10022 then
					for iter_24_3, iter_24_4 in pairs(arg_21_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_24_4 then
							if arg_21_1.isInRecall_ then
								iter_24_4.color = Color.New(Mathf.Lerp(iter_24_4.color.r, arg_21_1.hightColor1.r, (arg_21_1.time_ - 0) / var_24_6), Mathf.Lerp(iter_24_4.color.g, arg_21_1.hightColor1.g, (arg_21_1.time_ - 0) / var_24_6), (Mathf.Lerp(iter_24_4.color.b, arg_21_1.hightColor1.b, (arg_21_1.time_ - 0) / var_24_6)))
							else
								local var_24_7 = Mathf.Lerp(iter_24_4.color.r, 1, (arg_21_1.time_ - 0) / var_24_6)

								iter_24_4.color = Color.New(var_24_7, var_24_7, var_24_7)
							end
						end
					end
				end
			end

			if arg_21_1.time_ >= 0 + var_24_6 and arg_21_1.time_ < 0 + var_24_6 + arg_24_0 and not isNil(var_24_5) and arg_21_1.var_.actorSpriteComps10022 then
				for iter_24_5, iter_24_6 in pairs(arg_21_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_24_6 then
						iter_24_6.color = arg_21_1.isInRecall_ and (arg_21_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_21_1.var_.actorSpriteComps10022 = nil
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				local var_24_8 = arg_21_1.actors_["10022"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_24_8 then
					arg_21_1.var_.alphaOldValue10022 = var_24_8.alpha
					arg_21_1.var_.characterEffect10022 = var_24_8
				end

				arg_21_1.var_.alphaOldValue10022 = 0
			end

			local var_24_9 = 0.5

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_9 then
				if arg_21_1.var_.characterEffect10022 then
					arg_21_1.var_.characterEffect10022.alpha = Mathf.Lerp(arg_21_1.var_.alphaOldValue10022, 1, (arg_21_1.time_ - 0) / var_24_9)
				end
			end

			if arg_21_1.time_ >= 0 + var_24_9 and arg_21_1.time_ < 0 + var_24_9 + arg_24_0 and arg_21_1.var_.characterEffect10022 then
				arg_21_1.var_.characterEffect10022.alpha = 1
			end

			local var_24_10 = 0
			local var_24_11 = 0.4

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_10 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_12 = arg_21_1:GetWordFromCfg(413041005)
				local var_24_13 = arg_21_1:FormatText(var_24_12.content)

				arg_21_1.text_.text = var_24_13

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_15 = 16 <= 0 and var_24_11 or var_24_11 * (utf8.len(var_24_13) / 16)

				if (16 <= 0 and var_24_11 or var_24_11 * (utf8.len(var_24_13) / 16)) > 0 and var_24_11 < var_24_15 then
					arg_21_1.talkMaxDuration = var_24_15

					if var_24_15 + var_24_10 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_15 + var_24_10
					end
				end

				arg_21_1.text_.text = var_24_13
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413041", "413041005", "story_v_out_413041.awb") ~= 0 then
					local var_24_16 = manager.audio:GetVoiceLength("story_v_out_413041", "413041005", "story_v_out_413041.awb") / 1000

					if var_24_16 + var_24_10 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_16 + var_24_10
					end

					if var_24_12.prefab_name ~= "" and arg_21_1.actors_[var_24_12.prefab_name] ~= nil then
						local var_24_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_12.prefab_name].transform, "story_v_out_413041", "413041005", "story_v_out_413041.awb")

						arg_21_1:RecordAudio("413041005", var_24_17)
						arg_21_1:RecordAudio("413041005", var_24_17)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_413041", "413041005", "story_v_out_413041.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_413041", "413041005", "story_v_out_413041.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_18 = math.max(var_24_11, arg_21_1.talkMaxDuration)

			if var_24_10 <= arg_21_1.time_ and arg_21_1.time_ < var_24_10 + var_24_18 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_10) / var_24_18

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_10 + var_24_18 and arg_21_1.time_ < var_24_10 + var_24_18 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_21_1:InitPlayNodeList()
	end,
	Play413041006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 413041006
		arg_25_1.duration_ = 10.3

		local var_25_0 = {
			zh = 6.933,
			ja = 10.3
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
				arg_25_0:Play413041007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos10022 = arg_25_1.actors_["10022"].transform.localPosition
				arg_25_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_25_1:CheckSpriteTmpPos("10022", 3)

				for iter_28_0 = 0, arg_25_1.actors_["10022"].transform.childCount - 1 do
					local var_28_0 = arg_25_1.actors_["10022"].transform:GetChild(iter_28_0)

					if var_28_0.name == "split_8" or not string.find(var_28_0.name, "split") then
						var_28_0.gameObject:SetActive(true)
					else
						var_28_0.gameObject:SetActive(false)
					end
				end
			end

			local var_28_1 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_1 then
				arg_25_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos10022, Vector3.New(0, -315, -320), (arg_25_1.time_ - 0) / var_28_1)
			end

			if arg_25_1.time_ >= 0 + var_28_1 and arg_25_1.time_ < 0 + var_28_1 + arg_28_0 then
				arg_25_1.actors_["10022"].transform.localPosition = Vector3.New(0, -315, -320)
			end

			local var_28_2 = arg_25_1.actors_["10022"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_2) and arg_25_1.var_.actorSpriteComps10022 == nil then
				arg_25_1.var_.actorSpriteComps10022 = var_28_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_3 = 2

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_3 and not isNil(var_28_2) then
				if arg_25_1.var_.actorSpriteComps10022 then
					for iter_28_1, iter_28_2 in pairs(arg_25_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_28_2 then
							if arg_25_1.isInRecall_ then
								iter_28_2.color = Color.New(Mathf.Lerp(iter_28_2.color.r, arg_25_1.hightColor2.r, (arg_25_1.time_ - 0) / var_28_3), Mathf.Lerp(iter_28_2.color.g, arg_25_1.hightColor2.g, (arg_25_1.time_ - 0) / var_28_3), (Mathf.Lerp(iter_28_2.color.b, arg_25_1.hightColor2.b, (arg_25_1.time_ - 0) / var_28_3)))
							else
								local var_28_4 = Mathf.Lerp(iter_28_2.color.r, 0.5, (arg_25_1.time_ - 0) / var_28_3)

								iter_28_2.color = Color.New(var_28_4, var_28_4, var_28_4)
							end
						end
					end
				end
			end

			if arg_25_1.time_ >= 0 + var_28_3 and arg_25_1.time_ < 0 + var_28_3 + arg_28_0 and not isNil(var_28_2) and arg_25_1.var_.actorSpriteComps10022 then
				for iter_28_3, iter_28_4 in pairs(arg_25_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_28_4 then
						iter_28_4.color = arg_25_1.isInRecall_ and (arg_25_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_25_1.var_.actorSpriteComps10022 = nil
			end

			local var_28_5 = 0
			local var_28_6 = 0.775

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_5 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[995].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10096")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_7 = arg_25_1:GetWordFromCfg(413041006)
				local var_28_8 = arg_25_1:FormatText(var_28_7.content)

				arg_25_1.text_.text = var_28_8

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_10 = 31 <= 0 and var_28_6 or var_28_6 * (utf8.len(var_28_8) / 31)

				if (31 <= 0 and var_28_6 or var_28_6 * (utf8.len(var_28_8) / 31)) > 0 and var_28_6 < var_28_10 then
					arg_25_1.talkMaxDuration = var_28_10

					if var_28_10 + var_28_5 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_10 + var_28_5
					end
				end

				arg_25_1.text_.text = var_28_8
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413041", "413041006", "story_v_out_413041.awb") ~= 0 then
					local var_28_11 = manager.audio:GetVoiceLength("story_v_out_413041", "413041006", "story_v_out_413041.awb") / 1000

					if var_28_11 + var_28_5 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_11 + var_28_5
					end

					if var_28_7.prefab_name ~= "" and arg_25_1.actors_[var_28_7.prefab_name] ~= nil then
						local var_28_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_7.prefab_name].transform, "story_v_out_413041", "413041006", "story_v_out_413041.awb")

						arg_25_1:RecordAudio("413041006", var_28_12)
						arg_25_1:RecordAudio("413041006", var_28_12)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_413041", "413041006", "story_v_out_413041.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_413041", "413041006", "story_v_out_413041.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_13 = math.max(var_28_6, arg_25_1.talkMaxDuration)

			if var_28_5 <= arg_25_1.time_ and arg_25_1.time_ < var_28_5 + var_28_13 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_5) / var_28_13

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_5 + var_28_13 and arg_25_1.time_ < var_28_5 + var_28_13 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_25_1:InitPlayNodeList()
	end,
	Play413041007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 413041007
		arg_29_1.duration_ = 7.3

		local var_29_0 = {
			zh = 3.633,
			ja = 7.3
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
				arg_29_0:Play413041008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(arg_29_1.actors_["10022"]) and arg_29_1.var_.actorSpriteComps10022 == nil then
				arg_29_1.var_.actorSpriteComps10022 = arg_29_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_0 = 2

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 and not isNil(arg_29_1.actors_["10022"]) then
				if arg_29_1.var_.actorSpriteComps10022 then
					for iter_32_0, iter_32_1 in pairs(arg_29_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_32_1 then
							if arg_29_1.isInRecall_ then
								iter_32_1.color = Color.New(Mathf.Lerp(iter_32_1.color.r, arg_29_1.hightColor1.r, (arg_29_1.time_ - 0) / var_32_0), Mathf.Lerp(iter_32_1.color.g, arg_29_1.hightColor1.g, (arg_29_1.time_ - 0) / var_32_0), (Mathf.Lerp(iter_32_1.color.b, arg_29_1.hightColor1.b, (arg_29_1.time_ - 0) / var_32_0)))
							else
								local var_32_1 = Mathf.Lerp(iter_32_1.color.r, 1, (arg_29_1.time_ - 0) / var_32_0)

								iter_32_1.color = Color.New(var_32_1, var_32_1, var_32_1)
							end
						end
					end
				end
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 and not isNil(arg_29_1.actors_["10022"]) and arg_29_1.var_.actorSpriteComps10022 then
				for iter_32_2, iter_32_3 in pairs(arg_29_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_32_3 then
						iter_32_3.color = arg_29_1.isInRecall_ and (arg_29_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_29_1.var_.actorSpriteComps10022 = nil
			end

			local var_32_2 = 0
			local var_32_3 = 0.525

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_2 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_4 = arg_29_1:GetWordFromCfg(413041007)
				local var_32_5 = arg_29_1:FormatText(var_32_4.content)

				arg_29_1.text_.text = var_32_5

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_7 = 21 <= 0 and var_32_3 or var_32_3 * (utf8.len(var_32_5) / 21)

				if (21 <= 0 and var_32_3 or var_32_3 * (utf8.len(var_32_5) / 21)) > 0 and var_32_3 < var_32_7 then
					arg_29_1.talkMaxDuration = var_32_7

					if var_32_7 + var_32_2 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_7 + var_32_2
					end
				end

				arg_29_1.text_.text = var_32_5
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413041", "413041007", "story_v_out_413041.awb") ~= 0 then
					local var_32_8 = manager.audio:GetVoiceLength("story_v_out_413041", "413041007", "story_v_out_413041.awb") / 1000

					if var_32_8 + var_32_2 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_8 + var_32_2
					end

					if var_32_4.prefab_name ~= "" and arg_29_1.actors_[var_32_4.prefab_name] ~= nil then
						local var_32_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_4.prefab_name].transform, "story_v_out_413041", "413041007", "story_v_out_413041.awb")

						arg_29_1:RecordAudio("413041007", var_32_9)
						arg_29_1:RecordAudio("413041007", var_32_9)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_413041", "413041007", "story_v_out_413041.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_413041", "413041007", "story_v_out_413041.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_10 = math.max(var_32_3, arg_29_1.talkMaxDuration)

			if var_32_2 <= arg_29_1.time_ and arg_29_1.time_ < var_32_2 + var_32_10 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_2) / var_32_10

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_2 + var_32_10 and arg_29_1.time_ < var_32_2 + var_32_10 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play413041008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 413041008
		arg_33_1.duration_ = 6.77

		local var_33_0 = {
			zh = 4.7,
			ja = 6.766
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
				arg_33_0:Play413041009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(arg_33_1.actors_["10022"]) and arg_33_1.var_.actorSpriteComps10022 == nil then
				arg_33_1.var_.actorSpriteComps10022 = arg_33_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_0 = 2

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 and not isNil(arg_33_1.actors_["10022"]) then
				if arg_33_1.var_.actorSpriteComps10022 then
					for iter_36_0, iter_36_1 in pairs(arg_33_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_36_1 then
							if arg_33_1.isInRecall_ then
								iter_36_1.color = Color.New(Mathf.Lerp(iter_36_1.color.r, arg_33_1.hightColor2.r, (arg_33_1.time_ - 0) / var_36_0), Mathf.Lerp(iter_36_1.color.g, arg_33_1.hightColor2.g, (arg_33_1.time_ - 0) / var_36_0), (Mathf.Lerp(iter_36_1.color.b, arg_33_1.hightColor2.b, (arg_33_1.time_ - 0) / var_36_0)))
							else
								local var_36_1 = Mathf.Lerp(iter_36_1.color.r, 0.5, (arg_33_1.time_ - 0) / var_36_0)

								iter_36_1.color = Color.New(var_36_1, var_36_1, var_36_1)
							end
						end
					end
				end
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 and not isNil(arg_33_1.actors_["10022"]) and arg_33_1.var_.actorSpriteComps10022 then
				for iter_36_2, iter_36_3 in pairs(arg_33_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_36_3 then
						iter_36_3.color = arg_33_1.isInRecall_ and (arg_33_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_33_1.var_.actorSpriteComps10022 = nil
			end

			local var_36_2 = 0
			local var_36_3 = 0.5

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_2 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[995].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10096")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_4 = arg_33_1:GetWordFromCfg(413041008)
				local var_36_5 = arg_33_1:FormatText(var_36_4.content)

				arg_33_1.text_.text = var_36_5

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_7 = 20 <= 0 and var_36_3 or var_36_3 * (utf8.len(var_36_5) / 20)

				if (20 <= 0 and var_36_3 or var_36_3 * (utf8.len(var_36_5) / 20)) > 0 and var_36_3 < var_36_7 then
					arg_33_1.talkMaxDuration = var_36_7

					if var_36_7 + var_36_2 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_7 + var_36_2
					end
				end

				arg_33_1.text_.text = var_36_5
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413041", "413041008", "story_v_out_413041.awb") ~= 0 then
					local var_36_8 = manager.audio:GetVoiceLength("story_v_out_413041", "413041008", "story_v_out_413041.awb") / 1000

					if var_36_8 + var_36_2 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_8 + var_36_2
					end

					if var_36_4.prefab_name ~= "" and arg_33_1.actors_[var_36_4.prefab_name] ~= nil then
						local var_36_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_4.prefab_name].transform, "story_v_out_413041", "413041008", "story_v_out_413041.awb")

						arg_33_1:RecordAudio("413041008", var_36_9)
						arg_33_1:RecordAudio("413041008", var_36_9)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_413041", "413041008", "story_v_out_413041.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_413041", "413041008", "story_v_out_413041.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_10 = math.max(var_36_3, arg_33_1.talkMaxDuration)

			if var_36_2 <= arg_33_1.time_ and arg_33_1.time_ < var_36_2 + var_36_10 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_2) / var_36_10

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_2 + var_36_10 and arg_33_1.time_ < var_36_2 + var_36_10 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play413041009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 413041009
		arg_37_1.duration_ = 12.6

		local var_37_0 = {
			zh = 6.266,
			ja = 12.6
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
				arg_37_0:Play413041010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0.725

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[995].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10096")

				arg_37_1.callingController_:SetSelectedState("normal")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_1 = arg_37_1:GetWordFromCfg(413041009)
				local var_40_2 = arg_37_1:FormatText(var_40_1.content)

				arg_37_1.text_.text = var_40_2

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_4 = 29 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_2) / 29)

				if (29 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_2) / 29)) > 0 and var_40_0 < var_40_4 then
					arg_37_1.talkMaxDuration = var_40_4

					if var_40_4 + 0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_4 + 0
					end
				end

				arg_37_1.text_.text = var_40_2
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413041", "413041009", "story_v_out_413041.awb") ~= 0 then
					local var_40_5 = manager.audio:GetVoiceLength("story_v_out_413041", "413041009", "story_v_out_413041.awb") / 1000

					if var_40_5 + 0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_5 + 0
					end

					if var_40_1.prefab_name ~= "" and arg_37_1.actors_[var_40_1.prefab_name] ~= nil then
						local var_40_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_1.prefab_name].transform, "story_v_out_413041", "413041009", "story_v_out_413041.awb")

						arg_37_1:RecordAudio("413041009", var_40_6)
						arg_37_1:RecordAudio("413041009", var_40_6)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_413041", "413041009", "story_v_out_413041.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_413041", "413041009", "story_v_out_413041.awb")
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
	Play413041010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 413041010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play413041011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos10022 = arg_41_1.actors_["10022"].transform.localPosition
				arg_41_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("10022", 7)

				for iter_44_0 = 0, arg_41_1.actors_["10022"].transform.childCount - 1 do
					local var_44_0 = arg_41_1.actors_["10022"].transform:GetChild(iter_44_0)

					if var_44_0.name == "" or not string.find(var_44_0.name, "split") then
						var_44_0.gameObject:SetActive(true)
					else
						var_44_0.gameObject:SetActive(false)
					end
				end
			end

			local var_44_1 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_1 then
				arg_41_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos10022, Vector3.New(0, -2000, -180), (arg_41_1.time_ - 0) / var_44_1)
			end

			if arg_41_1.time_ >= 0 + var_44_1 and arg_41_1.time_ < 0 + var_44_1 + arg_44_0 then
				arg_41_1.actors_["10022"].transform.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_44_2 = arg_41_1.actors_["10022"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_2) and arg_41_1.var_.actorSpriteComps10022 == nil then
				arg_41_1.var_.actorSpriteComps10022 = var_44_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_3 = 2

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_3 and not isNil(var_44_2) then
				if arg_41_1.var_.actorSpriteComps10022 then
					for iter_44_1, iter_44_2 in pairs(arg_41_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_44_2 then
							if arg_41_1.isInRecall_ then
								iter_44_2.color = Color.New(Mathf.Lerp(iter_44_2.color.r, arg_41_1.hightColor2.r, (arg_41_1.time_ - 0) / var_44_3), Mathf.Lerp(iter_44_2.color.g, arg_41_1.hightColor2.g, (arg_41_1.time_ - 0) / var_44_3), (Mathf.Lerp(iter_44_2.color.b, arg_41_1.hightColor2.b, (arg_41_1.time_ - 0) / var_44_3)))
							else
								local var_44_4 = Mathf.Lerp(iter_44_2.color.r, 0.5, (arg_41_1.time_ - 0) / var_44_3)

								iter_44_2.color = Color.New(var_44_4, var_44_4, var_44_4)
							end
						end
					end
				end
			end

			if arg_41_1.time_ >= 0 + var_44_3 and arg_41_1.time_ < 0 + var_44_3 + arg_44_0 and not isNil(var_44_2) and arg_41_1.var_.actorSpriteComps10022 then
				for iter_44_3, iter_44_4 in pairs(arg_41_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_44_4 then
						iter_44_4.color = arg_41_1.isInRecall_ and (arg_41_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_41_1.var_.actorSpriteComps10022 = nil
			end

			if 1.35 < arg_41_1.time_ and arg_41_1.time_ <= 1.35 + arg_44_0 then
				arg_41_1:AudioAction("stop", "effect", "se_story_121_04", "se_story_121_04_crowd_loop", "")
			end

			local var_44_6 = 0
			local var_44_7 = 1.35

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_6 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, false)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_8 = arg_41_1:FormatText(arg_41_1:GetWordFromCfg(413041010).content)

				arg_41_1.text_.text = var_44_8

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_10 = 54 <= 0 and var_44_7 or var_44_7 * (utf8.len(var_44_8) / 54)

				if (54 <= 0 and var_44_7 or var_44_7 * (utf8.len(var_44_8) / 54)) > 0 and var_44_7 < var_44_10 then
					arg_41_1.talkMaxDuration = var_44_10

					if var_44_10 + var_44_6 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_10 + var_44_6
					end
				end

				arg_41_1.text_.text = var_44_8
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_11 = math.max(var_44_7, arg_41_1.talkMaxDuration)

			if var_44_6 <= arg_41_1.time_ and arg_41_1.time_ < var_44_6 + var_44_11 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_6) / var_44_11

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_6 + var_44_11 and arg_41_1.time_ < var_44_6 + var_44_11 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_41_1:InitPlayNodeList()
	end,
	Play413041011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 413041011
		arg_45_1.duration_ = 4.23

		local var_45_0 = {
			zh = 4.066,
			ja = 4.233
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
				arg_45_0:Play413041012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if arg_45_1.actors_["10092"] == nil then
				local var_48_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10092")

				if not isNil(var_48_0) then
					local var_48_1 = Object.Instantiate(var_48_0, arg_45_1.canvasGo_.transform)

					var_48_1.transform:SetSiblingIndex(1)

					var_48_1.name = "10092"
					var_48_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_45_1.actors_["10092"] = var_48_1

					if arg_45_1.isInRecall_ then
						for iter_48_0, iter_48_1 in ipairs((var_48_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_48_1.color = arg_45_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_48_2 = arg_45_1.actors_["10092"].transform

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos10092 = var_48_2.localPosition
				var_48_2.localScale = Vector3.New(1, 1, 1)

				arg_45_1:CheckSpriteTmpPos("10092", 3)

				for iter_48_2 = 0, var_48_2.childCount - 1 do
					local var_48_3 = var_48_2:GetChild(iter_48_2)

					if var_48_3.name == "" or not string.find(var_48_3.name, "split") then
						var_48_3.gameObject:SetActive(true)
					else
						var_48_3.gameObject:SetActive(false)
					end
				end
			end

			local var_48_4 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_4 then
				var_48_2.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos10092, Vector3.New(0, -300, -295), (arg_45_1.time_ - 0) / var_48_4)
			end

			if arg_45_1.time_ >= 0 + var_48_4 and arg_45_1.time_ < 0 + var_48_4 + arg_48_0 then
				var_48_2.localPosition = Vector3.New(0, -300, -295)
			end

			local var_48_5 = arg_45_1.actors_["10092"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_5) and arg_45_1.var_.actorSpriteComps10092 == nil then
				arg_45_1.var_.actorSpriteComps10092 = var_48_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_6 = 2

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_6 and not isNil(var_48_5) then
				if arg_45_1.var_.actorSpriteComps10092 then
					for iter_48_3, iter_48_4 in pairs(arg_45_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_48_4 then
							if arg_45_1.isInRecall_ then
								iter_48_4.color = Color.New(Mathf.Lerp(iter_48_4.color.r, arg_45_1.hightColor1.r, (arg_45_1.time_ - 0) / var_48_6), Mathf.Lerp(iter_48_4.color.g, arg_45_1.hightColor1.g, (arg_45_1.time_ - 0) / var_48_6), (Mathf.Lerp(iter_48_4.color.b, arg_45_1.hightColor1.b, (arg_45_1.time_ - 0) / var_48_6)))
							else
								local var_48_7 = Mathf.Lerp(iter_48_4.color.r, 1, (arg_45_1.time_ - 0) / var_48_6)

								iter_48_4.color = Color.New(var_48_7, var_48_7, var_48_7)
							end
						end
					end
				end
			end

			if arg_45_1.time_ >= 0 + var_48_6 and arg_45_1.time_ < 0 + var_48_6 + arg_48_0 and not isNil(var_48_5) and arg_45_1.var_.actorSpriteComps10092 then
				for iter_48_5, iter_48_6 in pairs(arg_45_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_48_6 then
						iter_48_6.color = arg_45_1.isInRecall_ and (arg_45_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_45_1.var_.actorSpriteComps10092 = nil
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				local var_48_8 = arg_45_1.actors_["10092"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_48_8 then
					arg_45_1.var_.alphaOldValue10092 = var_48_8.alpha
					arg_45_1.var_.characterEffect10092 = var_48_8
				end

				arg_45_1.var_.alphaOldValue10092 = 0
			end

			local var_48_9 = 0.2

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_9 then
				if arg_45_1.var_.characterEffect10092 then
					arg_45_1.var_.characterEffect10092.alpha = Mathf.Lerp(arg_45_1.var_.alphaOldValue10092, 1, (arg_45_1.time_ - 0) / var_48_9)
				end
			end

			if arg_45_1.time_ >= 0 + var_48_9 and arg_45_1.time_ < 0 + var_48_9 + arg_48_0 and arg_45_1.var_.characterEffect10092 then
				arg_45_1.var_.characterEffect10092.alpha = 1
			end

			local var_48_10 = 0
			local var_48_11 = 0.4

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_10 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_12 = arg_45_1:GetWordFromCfg(413041011)
				local var_48_13 = arg_45_1:FormatText(var_48_12.content)

				arg_45_1.text_.text = var_48_13

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_15 = 16 <= 0 and var_48_11 or var_48_11 * (utf8.len(var_48_13) / 16)

				if (16 <= 0 and var_48_11 or var_48_11 * (utf8.len(var_48_13) / 16)) > 0 and var_48_11 < var_48_15 then
					arg_45_1.talkMaxDuration = var_48_15

					if var_48_15 + var_48_10 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_15 + var_48_10
					end
				end

				arg_45_1.text_.text = var_48_13
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413041", "413041011", "story_v_out_413041.awb") ~= 0 then
					local var_48_16 = manager.audio:GetVoiceLength("story_v_out_413041", "413041011", "story_v_out_413041.awb") / 1000

					if var_48_16 + var_48_10 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_16 + var_48_10
					end

					if var_48_12.prefab_name ~= "" and arg_45_1.actors_[var_48_12.prefab_name] ~= nil then
						local var_48_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_12.prefab_name].transform, "story_v_out_413041", "413041011", "story_v_out_413041.awb")

						arg_45_1:RecordAudio("413041011", var_48_17)
						arg_45_1:RecordAudio("413041011", var_48_17)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_413041", "413041011", "story_v_out_413041.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_413041", "413041011", "story_v_out_413041.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_18 = math.max(var_48_11, arg_45_1.talkMaxDuration)

			if var_48_10 <= arg_45_1.time_ and arg_45_1.time_ < var_48_10 + var_48_18 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_10) / var_48_18

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_10 + var_48_18 and arg_45_1.time_ < var_48_10 + var_48_18 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_45_1:InitPlayNodeList()
	end,
	Play413041012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 413041012
		arg_49_1.duration_ = 8

		local var_49_0 = {
			zh = 5.033,
			ja = 8
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
				arg_49_0:Play413041013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(arg_49_1.actors_["10092"]) and arg_49_1.var_.actorSpriteComps10092 == nil then
				arg_49_1.var_.actorSpriteComps10092 = arg_49_1.actors_["10092"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_0 = 2

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 and not isNil(arg_49_1.actors_["10092"]) then
				if arg_49_1.var_.actorSpriteComps10092 then
					for iter_52_0, iter_52_1 in pairs(arg_49_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_52_1 then
							if arg_49_1.isInRecall_ then
								iter_52_1.color = Color.New(Mathf.Lerp(iter_52_1.color.r, arg_49_1.hightColor2.r, (arg_49_1.time_ - 0) / var_52_0), Mathf.Lerp(iter_52_1.color.g, arg_49_1.hightColor2.g, (arg_49_1.time_ - 0) / var_52_0), (Mathf.Lerp(iter_52_1.color.b, arg_49_1.hightColor2.b, (arg_49_1.time_ - 0) / var_52_0)))
							else
								local var_52_1 = Mathf.Lerp(iter_52_1.color.r, 0.5, (arg_49_1.time_ - 0) / var_52_0)

								iter_52_1.color = Color.New(var_52_1, var_52_1, var_52_1)
							end
						end
					end
				end
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 and not isNil(arg_49_1.actors_["10092"]) and arg_49_1.var_.actorSpriteComps10092 then
				for iter_52_2, iter_52_3 in pairs(arg_49_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_52_3 then
						iter_52_3.color = arg_49_1.isInRecall_ and (arg_49_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_49_1.var_.actorSpriteComps10092 = nil
			end

			local var_52_2 = 0
			local var_52_3 = 0.6

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_2 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[995].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, true)
				arg_49_1.iconController_:SetSelectedState("hero")

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10096")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_4 = arg_49_1:GetWordFromCfg(413041012)
				local var_52_5 = arg_49_1:FormatText(var_52_4.content)

				arg_49_1.text_.text = var_52_5

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_7 = 24 <= 0 and var_52_3 or var_52_3 * (utf8.len(var_52_5) / 24)

				if (24 <= 0 and var_52_3 or var_52_3 * (utf8.len(var_52_5) / 24)) > 0 and var_52_3 < var_52_7 then
					arg_49_1.talkMaxDuration = var_52_7

					if var_52_7 + var_52_2 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_7 + var_52_2
					end
				end

				arg_49_1.text_.text = var_52_5
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413041", "413041012", "story_v_out_413041.awb") ~= 0 then
					local var_52_8 = manager.audio:GetVoiceLength("story_v_out_413041", "413041012", "story_v_out_413041.awb") / 1000

					if var_52_8 + var_52_2 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_8 + var_52_2
					end

					if var_52_4.prefab_name ~= "" and arg_49_1.actors_[var_52_4.prefab_name] ~= nil then
						local var_52_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_4.prefab_name].transform, "story_v_out_413041", "413041012", "story_v_out_413041.awb")

						arg_49_1:RecordAudio("413041012", var_52_9)
						arg_49_1:RecordAudio("413041012", var_52_9)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_413041", "413041012", "story_v_out_413041.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_413041", "413041012", "story_v_out_413041.awb")
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
	Play413041013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 413041013
		arg_53_1.duration_ = 7.2

		local var_53_0 = {
			zh = 4.266,
			ja = 7.2
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
				arg_53_0:Play413041014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos10092 = arg_53_1.actors_["10092"].transform.localPosition
				arg_53_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_53_1:CheckSpriteTmpPos("10092", 3)

				for iter_56_0 = 0, arg_53_1.actors_["10092"].transform.childCount - 1 do
					local var_56_0 = arg_53_1.actors_["10092"].transform:GetChild(iter_56_0)

					if var_56_0.name == "" or not string.find(var_56_0.name, "split") then
						var_56_0.gameObject:SetActive(true)
					else
						var_56_0.gameObject:SetActive(false)
					end
				end
			end

			local var_56_1 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_1 then
				arg_53_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos10092, Vector3.New(0, -300, -295), (arg_53_1.time_ - 0) / var_56_1)
			end

			if arg_53_1.time_ >= 0 + var_56_1 and arg_53_1.time_ < 0 + var_56_1 + arg_56_0 then
				arg_53_1.actors_["10092"].transform.localPosition = Vector3.New(0, -300, -295)
			end

			local var_56_2 = arg_53_1.actors_["10092"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_2) and arg_53_1.var_.actorSpriteComps10092 == nil then
				arg_53_1.var_.actorSpriteComps10092 = var_56_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_56_3 = 2

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_3 and not isNil(var_56_2) then
				if arg_53_1.var_.actorSpriteComps10092 then
					for iter_56_1, iter_56_2 in pairs(arg_53_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_56_2 then
							if arg_53_1.isInRecall_ then
								iter_56_2.color = Color.New(Mathf.Lerp(iter_56_2.color.r, arg_53_1.hightColor1.r, (arg_53_1.time_ - 0) / var_56_3), Mathf.Lerp(iter_56_2.color.g, arg_53_1.hightColor1.g, (arg_53_1.time_ - 0) / var_56_3), (Mathf.Lerp(iter_56_2.color.b, arg_53_1.hightColor1.b, (arg_53_1.time_ - 0) / var_56_3)))
							else
								local var_56_4 = Mathf.Lerp(iter_56_2.color.r, 1, (arg_53_1.time_ - 0) / var_56_3)

								iter_56_2.color = Color.New(var_56_4, var_56_4, var_56_4)
							end
						end
					end
				end
			end

			if arg_53_1.time_ >= 0 + var_56_3 and arg_53_1.time_ < 0 + var_56_3 + arg_56_0 and not isNil(var_56_2) and arg_53_1.var_.actorSpriteComps10092 then
				for iter_56_3, iter_56_4 in pairs(arg_53_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_56_4 then
						iter_56_4.color = arg_53_1.isInRecall_ and (arg_53_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_53_1.var_.actorSpriteComps10092 = nil
			end

			local var_56_5 = 0
			local var_56_6 = 0.5

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_5 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_7 = arg_53_1:GetWordFromCfg(413041013)
				local var_56_8 = arg_53_1:FormatText(var_56_7.content)

				arg_53_1.text_.text = var_56_8

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_10 = 20 <= 0 and var_56_6 or var_56_6 * (utf8.len(var_56_8) / 20)

				if (20 <= 0 and var_56_6 or var_56_6 * (utf8.len(var_56_8) / 20)) > 0 and var_56_6 < var_56_10 then
					arg_53_1.talkMaxDuration = var_56_10

					if var_56_10 + var_56_5 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_10 + var_56_5
					end
				end

				arg_53_1.text_.text = var_56_8
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413041", "413041013", "story_v_out_413041.awb") ~= 0 then
					local var_56_11 = manager.audio:GetVoiceLength("story_v_out_413041", "413041013", "story_v_out_413041.awb") / 1000

					if var_56_11 + var_56_5 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_11 + var_56_5
					end

					if var_56_7.prefab_name ~= "" and arg_53_1.actors_[var_56_7.prefab_name] ~= nil then
						local var_56_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_7.prefab_name].transform, "story_v_out_413041", "413041013", "story_v_out_413041.awb")

						arg_53_1:RecordAudio("413041013", var_56_12)
						arg_53_1:RecordAudio("413041013", var_56_12)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_413041", "413041013", "story_v_out_413041.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_413041", "413041013", "story_v_out_413041.awb")
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

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
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
	Play413041014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 413041014
		arg_57_1.duration_ = 6

		local var_57_0 = {
			zh = 5.966,
			ja = 6
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
				arg_57_0:Play413041015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(arg_57_1.actors_["10092"]) and arg_57_1.var_.actorSpriteComps10092 == nil then
				arg_57_1.var_.actorSpriteComps10092 = arg_57_1.actors_["10092"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_0 = 2

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 and not isNil(arg_57_1.actors_["10092"]) then
				if arg_57_1.var_.actorSpriteComps10092 then
					for iter_60_0, iter_60_1 in pairs(arg_57_1.var_.actorSpriteComps10092:ToTable()) do
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

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 and not isNil(arg_57_1.actors_["10092"]) and arg_57_1.var_.actorSpriteComps10092 then
				for iter_60_2, iter_60_3 in pairs(arg_57_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_60_3 then
						iter_60_3.color = arg_57_1.isInRecall_ and (arg_57_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_57_1.var_.actorSpriteComps10092 = nil
			end

			local var_60_2 = 0
			local var_60_3 = 0.675

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_2 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[995].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, true)
				arg_57_1.iconController_:SetSelectedState("hero")

				arg_57_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10096")

				arg_57_1.callingController_:SetSelectedState("normal")

				arg_57_1.keyicon_.color = Color.New(1, 1, 1)
				arg_57_1.icon_.color = Color.New(1, 1, 1)

				local var_60_4 = arg_57_1:GetWordFromCfg(413041014)
				local var_60_5 = arg_57_1:FormatText(var_60_4.content)

				arg_57_1.text_.text = var_60_5

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_7 = 27 <= 0 and var_60_3 or var_60_3 * (utf8.len(var_60_5) / 27)

				if (27 <= 0 and var_60_3 or var_60_3 * (utf8.len(var_60_5) / 27)) > 0 and var_60_3 < var_60_7 then
					arg_57_1.talkMaxDuration = var_60_7

					if var_60_7 + var_60_2 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_7 + var_60_2
					end
				end

				arg_57_1.text_.text = var_60_5
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413041", "413041014", "story_v_out_413041.awb") ~= 0 then
					local var_60_8 = manager.audio:GetVoiceLength("story_v_out_413041", "413041014", "story_v_out_413041.awb") / 1000

					if var_60_8 + var_60_2 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_8 + var_60_2
					end

					if var_60_4.prefab_name ~= "" and arg_57_1.actors_[var_60_4.prefab_name] ~= nil then
						local var_60_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_4.prefab_name].transform, "story_v_out_413041", "413041014", "story_v_out_413041.awb")

						arg_57_1:RecordAudio("413041014", var_60_9)
						arg_57_1:RecordAudio("413041014", var_60_9)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_413041", "413041014", "story_v_out_413041.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_413041", "413041014", "story_v_out_413041.awb")
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
	Play413041015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 413041015
		arg_61_1.duration_ = 10.3

		local var_61_0 = {
			zh = 10.3,
			ja = 9.2
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
				arg_61_0:Play413041016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos10092 = arg_61_1.actors_["10092"].transform.localPosition
				arg_61_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_61_1:CheckSpriteTmpPos("10092", 0)

				for iter_64_0 = 0, arg_61_1.actors_["10092"].transform.childCount - 1 do
					local var_64_0 = arg_61_1.actors_["10092"].transform:GetChild(iter_64_0)

					if var_64_0.name == "" or not string.find(var_64_0.name, "split") then
						var_64_0.gameObject:SetActive(true)
					else
						var_64_0.gameObject:SetActive(false)
					end
				end
			end

			local var_64_1 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_1 then
				arg_61_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos10092, Vector3.New(0, -5000, 0), (arg_61_1.time_ - 0) / var_64_1)
			end

			if arg_61_1.time_ >= 0 + var_64_1 and arg_61_1.time_ < 0 + var_64_1 + arg_64_0 then
				arg_61_1.actors_["10092"].transform.localPosition = Vector3.New(0, -5000, 0)
			end

			local var_64_2 = "10097"

			if arg_61_1.actors_["10097"] == nil then
				local var_64_3 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10097")

				if not isNil(var_64_3) then
					local var_64_4 = Object.Instantiate(var_64_3, arg_61_1.canvasGo_.transform)

					var_64_4.transform:SetSiblingIndex(1)

					var_64_4.name = var_64_2
					var_64_4.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_61_1.actors_[var_64_2] = var_64_4

					if arg_61_1.isInRecall_ then
						for iter_64_1, iter_64_2 in ipairs((var_64_4:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_64_2.color = arg_61_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_64_5 = arg_61_1.actors_["10097"].transform

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos10097 = var_64_5.localPosition
				var_64_5.localScale = Vector3.New(1, 1, 1)

				arg_61_1:CheckSpriteTmpPos("10097", 3)

				for iter_64_3 = 0, var_64_5.childCount - 1 do
					local var_64_6 = var_64_5:GetChild(iter_64_3)

					if var_64_6.name == "" or not string.find(var_64_6.name, "split") then
						var_64_6.gameObject:SetActive(true)
					else
						var_64_6.gameObject:SetActive(false)
					end
				end
			end

			local var_64_7 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_7 then
				var_64_5.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos10097, Vector3.New(0, -350, -180), (arg_61_1.time_ - 0) / var_64_7)
			end

			if arg_61_1.time_ >= 0 + var_64_7 and arg_61_1.time_ < 0 + var_64_7 + arg_64_0 then
				var_64_5.localPosition = Vector3.New(0, -350, -180)
			end

			local var_64_8 = arg_61_1.actors_["10092"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_8) and arg_61_1.var_.actorSpriteComps10092 == nil then
				arg_61_1.var_.actorSpriteComps10092 = var_64_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_9 = 2

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_9 and not isNil(var_64_8) then
				if arg_61_1.var_.actorSpriteComps10092 then
					for iter_64_4, iter_64_5 in pairs(arg_61_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_64_5 then
							if arg_61_1.isInRecall_ then
								iter_64_5.color = Color.New(Mathf.Lerp(iter_64_5.color.r, arg_61_1.hightColor2.r, (arg_61_1.time_ - 0) / var_64_9), Mathf.Lerp(iter_64_5.color.g, arg_61_1.hightColor2.g, (arg_61_1.time_ - 0) / var_64_9), (Mathf.Lerp(iter_64_5.color.b, arg_61_1.hightColor2.b, (arg_61_1.time_ - 0) / var_64_9)))
							else
								local var_64_10 = Mathf.Lerp(iter_64_5.color.r, 0.5, (arg_61_1.time_ - 0) / var_64_9)

								iter_64_5.color = Color.New(var_64_10, var_64_10, var_64_10)
							end
						end
					end
				end
			end

			if arg_61_1.time_ >= 0 + var_64_9 and arg_61_1.time_ < 0 + var_64_9 + arg_64_0 and not isNil(var_64_8) and arg_61_1.var_.actorSpriteComps10092 then
				for iter_64_6, iter_64_7 in pairs(arg_61_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_64_7 then
						iter_64_7.color = arg_61_1.isInRecall_ and (arg_61_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_61_1.var_.actorSpriteComps10092 = nil
			end

			local var_64_11 = arg_61_1.actors_["10097"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_11) and arg_61_1.var_.actorSpriteComps10097 == nil then
				arg_61_1.var_.actorSpriteComps10097 = var_64_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_12 = 2

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_12 and not isNil(var_64_11) then
				if arg_61_1.var_.actorSpriteComps10097 then
					for iter_64_8, iter_64_9 in pairs(arg_61_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_64_9 then
							if arg_61_1.isInRecall_ then
								iter_64_9.color = Color.New(Mathf.Lerp(iter_64_9.color.r, arg_61_1.hightColor1.r, (arg_61_1.time_ - 0) / var_64_12), Mathf.Lerp(iter_64_9.color.g, arg_61_1.hightColor1.g, (arg_61_1.time_ - 0) / var_64_12), (Mathf.Lerp(iter_64_9.color.b, arg_61_1.hightColor1.b, (arg_61_1.time_ - 0) / var_64_12)))
							else
								local var_64_13 = Mathf.Lerp(iter_64_9.color.r, 1, (arg_61_1.time_ - 0) / var_64_12)

								iter_64_9.color = Color.New(var_64_13, var_64_13, var_64_13)
							end
						end
					end
				end
			end

			if arg_61_1.time_ >= 0 + var_64_12 and arg_61_1.time_ < 0 + var_64_12 + arg_64_0 and not isNil(var_64_11) and arg_61_1.var_.actorSpriteComps10097 then
				for iter_64_10, iter_64_11 in pairs(arg_61_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_64_11 then
						iter_64_11.color = arg_61_1.isInRecall_ and (arg_61_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_61_1.var_.actorSpriteComps10097 = nil
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				local var_64_14 = arg_61_1.actors_["10097"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_64_14 then
					arg_61_1.var_.alphaOldValue10097 = var_64_14.alpha
					arg_61_1.var_.characterEffect10097 = var_64_14
				end

				arg_61_1.var_.alphaOldValue10097 = 0
			end

			local var_64_15 = 0.2

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_15 then
				if arg_61_1.var_.characterEffect10097 then
					arg_61_1.var_.characterEffect10097.alpha = Mathf.Lerp(arg_61_1.var_.alphaOldValue10097, 1, (arg_61_1.time_ - 0) / var_64_15)
				end
			end

			if arg_61_1.time_ >= 0 + var_64_15 and arg_61_1.time_ < 0 + var_64_15 + arg_64_0 and arg_61_1.var_.characterEffect10097 then
				arg_61_1.var_.characterEffect10097.alpha = 1
			end

			local var_64_16 = 0
			local var_64_17 = 0.725

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_16 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_18 = arg_61_1:GetWordFromCfg(413041015)
				local var_64_19 = arg_61_1:FormatText(var_64_18.content)

				arg_61_1.text_.text = var_64_19

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_21 = 29 <= 0 and var_64_17 or var_64_17 * (utf8.len(var_64_19) / 29)

				if (29 <= 0 and var_64_17 or var_64_17 * (utf8.len(var_64_19) / 29)) > 0 and var_64_17 < var_64_21 then
					arg_61_1.talkMaxDuration = var_64_21

					if var_64_21 + var_64_16 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_21 + var_64_16
					end
				end

				arg_61_1.text_.text = var_64_19
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413041", "413041015", "story_v_out_413041.awb") ~= 0 then
					local var_64_22 = manager.audio:GetVoiceLength("story_v_out_413041", "413041015", "story_v_out_413041.awb") / 1000

					if var_64_22 + var_64_16 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_22 + var_64_16
					end

					if var_64_18.prefab_name ~= "" and arg_61_1.actors_[var_64_18.prefab_name] ~= nil then
						local var_64_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_18.prefab_name].transform, "story_v_out_413041", "413041015", "story_v_out_413041.awb")

						arg_61_1:RecordAudio("413041015", var_64_23)
						arg_61_1:RecordAudio("413041015", var_64_23)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_413041", "413041015", "story_v_out_413041.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_413041", "413041015", "story_v_out_413041.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_24 = math.max(var_64_17, arg_61_1.talkMaxDuration)

			if var_64_16 <= arg_61_1.time_ and arg_61_1.time_ < var_64_16 + var_64_24 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_16) / var_64_24

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_16 + var_64_24 and arg_61_1.time_ < var_64_16 + var_64_24 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10097",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_61_1:InitPlayNodeList()
	end,
	Play413041016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 413041016
		arg_65_1.duration_ = 15.03

		local var_65_0 = {
			zh = 10.7,
			ja = 15.033
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
				arg_65_0:Play413041017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0.95

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_1 = arg_65_1:GetWordFromCfg(413041016)
				local var_68_2 = arg_65_1:FormatText(var_68_1.content)

				arg_65_1.text_.text = var_68_2

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_4 = 38 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_2) / 38)

				if (38 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_2) / 38)) > 0 and var_68_0 < var_68_4 then
					arg_65_1.talkMaxDuration = var_68_4

					if var_68_4 + 0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_4 + 0
					end
				end

				arg_65_1.text_.text = var_68_2
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413041", "413041016", "story_v_out_413041.awb") ~= 0 then
					local var_68_5 = manager.audio:GetVoiceLength("story_v_out_413041", "413041016", "story_v_out_413041.awb") / 1000

					if var_68_5 + 0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_5 + 0
					end

					if var_68_1.prefab_name ~= "" and arg_65_1.actors_[var_68_1.prefab_name] ~= nil then
						local var_68_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_1.prefab_name].transform, "story_v_out_413041", "413041016", "story_v_out_413041.awb")

						arg_65_1:RecordAudio("413041016", var_68_6)
						arg_65_1:RecordAudio("413041016", var_68_6)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_413041", "413041016", "story_v_out_413041.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_413041", "413041016", "story_v_out_413041.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_7 = math.max(var_68_0, arg_65_1.talkMaxDuration)

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_7 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - 0) / var_68_7

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= 0 + var_68_7 and arg_65_1.time_ < 0 + var_68_7 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play413041017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 413041017
		arg_69_1.duration_ = 4.9

		local var_69_0 = {
			zh = 2.166,
			ja = 4.9
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
				arg_69_0:Play413041018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos10097 = arg_69_1.actors_["10097"].transform.localPosition
				arg_69_1.actors_["10097"].transform.localScale = Vector3.New(1, 1, 1)

				arg_69_1:CheckSpriteTmpPos("10097", 0)

				for iter_72_0 = 0, arg_69_1.actors_["10097"].transform.childCount - 1 do
					local var_72_0 = arg_69_1.actors_["10097"].transform:GetChild(iter_72_0)

					if var_72_0.name == "" or not string.find(var_72_0.name, "split") then
						var_72_0.gameObject:SetActive(true)
					else
						var_72_0.gameObject:SetActive(false)
					end
				end
			end

			local var_72_1 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_1 then
				arg_69_1.actors_["10097"].transform.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos10097, Vector3.New(-1500, -350, -180), (arg_69_1.time_ - 0) / var_72_1)
			end

			if arg_69_1.time_ >= 0 + var_72_1 and arg_69_1.time_ < 0 + var_72_1 + arg_72_0 then
				arg_69_1.actors_["10097"].transform.localPosition = Vector3.New(-1500, -350, -180)
			end

			local var_72_2 = "10094"

			if arg_69_1.actors_["10094"] == nil then
				local var_72_3 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10094")

				if not isNil(var_72_3) then
					local var_72_4 = Object.Instantiate(var_72_3, arg_69_1.canvasGo_.transform)

					var_72_4.transform:SetSiblingIndex(1)

					var_72_4.name = var_72_2
					var_72_4.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_69_1.actors_[var_72_2] = var_72_4

					if arg_69_1.isInRecall_ then
						for iter_72_1, iter_72_2 in ipairs((var_72_4:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_72_2.color = arg_69_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_72_5 = arg_69_1.actors_["10094"].transform

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos10094 = var_72_5.localPosition
				var_72_5.localScale = Vector3.New(1, 1, 1)

				arg_69_1:CheckSpriteTmpPos("10094", 3)

				for iter_72_3 = 0, var_72_5.childCount - 1 do
					local var_72_6 = var_72_5:GetChild(iter_72_3)

					if var_72_6.name == "" or not string.find(var_72_6.name, "split") then
						var_72_6.gameObject:SetActive(true)
					else
						var_72_6.gameObject:SetActive(false)
					end
				end
			end

			local var_72_7 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_7 then
				var_72_5.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos10094, Vector3.New(0, -340, -414), (arg_69_1.time_ - 0) / var_72_7)
			end

			if arg_69_1.time_ >= 0 + var_72_7 and arg_69_1.time_ < 0 + var_72_7 + arg_72_0 then
				var_72_5.localPosition = Vector3.New(0, -340, -414)
			end

			local var_72_8 = arg_69_1.actors_["10097"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_8) and arg_69_1.var_.actorSpriteComps10097 == nil then
				arg_69_1.var_.actorSpriteComps10097 = var_72_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_72_9 = 2

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_9 and not isNil(var_72_8) then
				if arg_69_1.var_.actorSpriteComps10097 then
					for iter_72_4, iter_72_5 in pairs(arg_69_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_72_5 then
							if arg_69_1.isInRecall_ then
								iter_72_5.color = Color.New(Mathf.Lerp(iter_72_5.color.r, arg_69_1.hightColor2.r, (arg_69_1.time_ - 0) / var_72_9), Mathf.Lerp(iter_72_5.color.g, arg_69_1.hightColor2.g, (arg_69_1.time_ - 0) / var_72_9), (Mathf.Lerp(iter_72_5.color.b, arg_69_1.hightColor2.b, (arg_69_1.time_ - 0) / var_72_9)))
							else
								local var_72_10 = Mathf.Lerp(iter_72_5.color.r, 0.5, (arg_69_1.time_ - 0) / var_72_9)

								iter_72_5.color = Color.New(var_72_10, var_72_10, var_72_10)
							end
						end
					end
				end
			end

			if arg_69_1.time_ >= 0 + var_72_9 and arg_69_1.time_ < 0 + var_72_9 + arg_72_0 and not isNil(var_72_8) and arg_69_1.var_.actorSpriteComps10097 then
				for iter_72_6, iter_72_7 in pairs(arg_69_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_72_7 then
						iter_72_7.color = arg_69_1.isInRecall_ and (arg_69_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_69_1.var_.actorSpriteComps10097 = nil
			end

			local var_72_11 = arg_69_1.actors_["10094"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_11) and arg_69_1.var_.actorSpriteComps10094 == nil then
				arg_69_1.var_.actorSpriteComps10094 = var_72_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_72_12 = 2

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_12 and not isNil(var_72_11) then
				if arg_69_1.var_.actorSpriteComps10094 then
					for iter_72_8, iter_72_9 in pairs(arg_69_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_72_9 then
							if arg_69_1.isInRecall_ then
								iter_72_9.color = Color.New(Mathf.Lerp(iter_72_9.color.r, arg_69_1.hightColor1.r, (arg_69_1.time_ - 0) / var_72_12), Mathf.Lerp(iter_72_9.color.g, arg_69_1.hightColor1.g, (arg_69_1.time_ - 0) / var_72_12), (Mathf.Lerp(iter_72_9.color.b, arg_69_1.hightColor1.b, (arg_69_1.time_ - 0) / var_72_12)))
							else
								local var_72_13 = Mathf.Lerp(iter_72_9.color.r, 1, (arg_69_1.time_ - 0) / var_72_12)

								iter_72_9.color = Color.New(var_72_13, var_72_13, var_72_13)
							end
						end
					end
				end
			end

			if arg_69_1.time_ >= 0 + var_72_12 and arg_69_1.time_ < 0 + var_72_12 + arg_72_0 and not isNil(var_72_11) and arg_69_1.var_.actorSpriteComps10094 then
				for iter_72_10, iter_72_11 in pairs(arg_69_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_72_11 then
						iter_72_11.color = arg_69_1.isInRecall_ and (arg_69_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_69_1.var_.actorSpriteComps10094 = nil
			end

			local var_72_14 = 0
			local var_72_15 = 0.25

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_14 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_16 = arg_69_1:GetWordFromCfg(413041017)
				local var_72_17 = arg_69_1:FormatText(var_72_16.content)

				arg_69_1.text_.text = var_72_17

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_19 = 10 <= 0 and var_72_15 or var_72_15 * (utf8.len(var_72_17) / 10)

				if (10 <= 0 and var_72_15 or var_72_15 * (utf8.len(var_72_17) / 10)) > 0 and var_72_15 < var_72_19 then
					arg_69_1.talkMaxDuration = var_72_19

					if var_72_19 + var_72_14 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_19 + var_72_14
					end
				end

				arg_69_1.text_.text = var_72_17
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413041", "413041017", "story_v_out_413041.awb") ~= 0 then
					local var_72_20 = manager.audio:GetVoiceLength("story_v_out_413041", "413041017", "story_v_out_413041.awb") / 1000

					if var_72_20 + var_72_14 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_20 + var_72_14
					end

					if var_72_16.prefab_name ~= "" and arg_69_1.actors_[var_72_16.prefab_name] ~= nil then
						local var_72_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_16.prefab_name].transform, "story_v_out_413041", "413041017", "story_v_out_413041.awb")

						arg_69_1:RecordAudio("413041017", var_72_21)
						arg_69_1:RecordAudio("413041017", var_72_21)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_413041", "413041017", "story_v_out_413041.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_413041", "413041017", "story_v_out_413041.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_22 = math.max(var_72_15, arg_69_1.talkMaxDuration)

			if var_72_14 <= arg_69_1.time_ and arg_69_1.time_ < var_72_14 + var_72_22 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_14) / var_72_22

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_14 + var_72_22 and arg_69_1.time_ < var_72_14 + var_72_22 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10097",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10094",
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
	Play413041018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 413041018
		arg_73_1.duration_ = 7.97

		local var_73_0 = {
			zh = 7.966,
			ja = 1.999999999999
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
				arg_73_0:Play413041019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.var_.moveOldPos10094 = arg_73_1.actors_["10094"].transform.localPosition
				arg_73_1.actors_["10094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_73_1:CheckSpriteTmpPos("10094", 7)

				for iter_76_0 = 0, arg_73_1.actors_["10094"].transform.childCount - 1 do
					local var_76_0 = arg_73_1.actors_["10094"].transform:GetChild(iter_76_0)

					if var_76_0.name == "" or not string.find(var_76_0.name, "split") then
						var_76_0.gameObject:SetActive(true)
					else
						var_76_0.gameObject:SetActive(false)
					end
				end
			end

			local var_76_1 = 0.001

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_1 then
				arg_73_1.actors_["10094"].transform.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos10094, Vector3.New(0, -2000, 0), (arg_73_1.time_ - 0) / var_76_1)
			end

			if arg_73_1.time_ >= 0 + var_76_1 and arg_73_1.time_ < 0 + var_76_1 + arg_76_0 then
				arg_73_1.actors_["10094"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_76_2 = arg_73_1.actors_["10097"].transform

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.var_.moveOldPos10097 = var_76_2.localPosition
				var_76_2.localScale = Vector3.New(1, 1, 1)

				arg_73_1:CheckSpriteTmpPos("10097", 3)

				for iter_76_1 = 0, var_76_2.childCount - 1 do
					local var_76_3 = var_76_2:GetChild(iter_76_1)

					if var_76_3.name == "" or not string.find(var_76_3.name, "split") then
						var_76_3.gameObject:SetActive(true)
					else
						var_76_3.gameObject:SetActive(false)
					end
				end
			end

			local var_76_4 = 0.001

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_4 then
				var_76_2.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos10097, Vector3.New(0, -350, -180), (arg_73_1.time_ - 0) / var_76_4)
			end

			if arg_73_1.time_ >= 0 + var_76_4 and arg_73_1.time_ < 0 + var_76_4 + arg_76_0 then
				var_76_2.localPosition = Vector3.New(0, -350, -180)
			end

			local var_76_5 = arg_73_1.actors_["10094"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_5) and arg_73_1.var_.actorSpriteComps10094 == nil then
				arg_73_1.var_.actorSpriteComps10094 = var_76_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_6 = 2

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_6 and not isNil(var_76_5) then
				if arg_73_1.var_.actorSpriteComps10094 then
					for iter_76_2, iter_76_3 in pairs(arg_73_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_76_3 then
							if arg_73_1.isInRecall_ then
								iter_76_3.color = Color.New(Mathf.Lerp(iter_76_3.color.r, arg_73_1.hightColor2.r, (arg_73_1.time_ - 0) / var_76_6), Mathf.Lerp(iter_76_3.color.g, arg_73_1.hightColor2.g, (arg_73_1.time_ - 0) / var_76_6), (Mathf.Lerp(iter_76_3.color.b, arg_73_1.hightColor2.b, (arg_73_1.time_ - 0) / var_76_6)))
							else
								local var_76_7 = Mathf.Lerp(iter_76_3.color.r, 0.5, (arg_73_1.time_ - 0) / var_76_6)

								iter_76_3.color = Color.New(var_76_7, var_76_7, var_76_7)
							end
						end
					end
				end
			end

			if arg_73_1.time_ >= 0 + var_76_6 and arg_73_1.time_ < 0 + var_76_6 + arg_76_0 and not isNil(var_76_5) and arg_73_1.var_.actorSpriteComps10094 then
				for iter_76_4, iter_76_5 in pairs(arg_73_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_76_5 then
						iter_76_5.color = arg_73_1.isInRecall_ and (arg_73_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_73_1.var_.actorSpriteComps10094 = nil
			end

			local var_76_8 = arg_73_1.actors_["10097"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_8) and arg_73_1.var_.actorSpriteComps10097 == nil then
				arg_73_1.var_.actorSpriteComps10097 = var_76_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_9 = 2

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_9 and not isNil(var_76_8) then
				if arg_73_1.var_.actorSpriteComps10097 then
					for iter_76_6, iter_76_7 in pairs(arg_73_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_76_7 then
							if arg_73_1.isInRecall_ then
								iter_76_7.color = Color.New(Mathf.Lerp(iter_76_7.color.r, arg_73_1.hightColor1.r, (arg_73_1.time_ - 0) / var_76_9), Mathf.Lerp(iter_76_7.color.g, arg_73_1.hightColor1.g, (arg_73_1.time_ - 0) / var_76_9), (Mathf.Lerp(iter_76_7.color.b, arg_73_1.hightColor1.b, (arg_73_1.time_ - 0) / var_76_9)))
							else
								local var_76_10 = Mathf.Lerp(iter_76_7.color.r, 1, (arg_73_1.time_ - 0) / var_76_9)

								iter_76_7.color = Color.New(var_76_10, var_76_10, var_76_10)
							end
						end
					end
				end
			end

			if arg_73_1.time_ >= 0 + var_76_9 and arg_73_1.time_ < 0 + var_76_9 + arg_76_0 and not isNil(var_76_8) and arg_73_1.var_.actorSpriteComps10097 then
				for iter_76_8, iter_76_9 in pairs(arg_73_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_76_9 then
						iter_76_9.color = arg_73_1.isInRecall_ and (arg_73_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_73_1.var_.actorSpriteComps10097 = nil
			end

			local var_76_11 = 0
			local var_76_12 = 0.625

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_11 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_13 = arg_73_1:GetWordFromCfg(413041018)
				local var_76_14 = arg_73_1:FormatText(var_76_13.content)

				arg_73_1.text_.text = var_76_14

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_16 = 25 <= 0 and var_76_12 or var_76_12 * (utf8.len(var_76_14) / 25)

				if (25 <= 0 and var_76_12 or var_76_12 * (utf8.len(var_76_14) / 25)) > 0 and var_76_12 < var_76_16 then
					arg_73_1.talkMaxDuration = var_76_16

					if var_76_16 + var_76_11 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_16 + var_76_11
					end
				end

				arg_73_1.text_.text = var_76_14
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413041", "413041018", "story_v_out_413041.awb") ~= 0 then
					local var_76_17 = manager.audio:GetVoiceLength("story_v_out_413041", "413041018", "story_v_out_413041.awb") / 1000

					if var_76_17 + var_76_11 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_17 + var_76_11
					end

					if var_76_13.prefab_name ~= "" and arg_73_1.actors_[var_76_13.prefab_name] ~= nil then
						local var_76_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_13.prefab_name].transform, "story_v_out_413041", "413041018", "story_v_out_413041.awb")

						arg_73_1:RecordAudio("413041018", var_76_18)
						arg_73_1:RecordAudio("413041018", var_76_18)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_413041", "413041018", "story_v_out_413041.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_413041", "413041018", "story_v_out_413041.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_19 = math.max(var_76_12, arg_73_1.talkMaxDuration)

			if var_76_11 <= arg_73_1.time_ and arg_73_1.time_ < var_76_11 + var_76_19 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_11) / var_76_19

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_11 + var_76_19 and arg_73_1.time_ < var_76_11 + var_76_19 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10097",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_73_1:InitPlayNodeList()
	end,
	Play413041019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 413041019
		arg_77_1.duration_ = 4.6

		local var_77_0 = {
			zh = 4.6,
			ja = 4.366
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
				arg_77_0:Play413041020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos10097 = arg_77_1.actors_["10097"].transform.localPosition
				arg_77_1.actors_["10097"].transform.localScale = Vector3.New(1, 1, 1)

				arg_77_1:CheckSpriteTmpPos("10097", 3)

				for iter_80_0 = 0, arg_77_1.actors_["10097"].transform.childCount - 1 do
					local var_80_0 = arg_77_1.actors_["10097"].transform:GetChild(iter_80_0)

					if var_80_0.name == "" or not string.find(var_80_0.name, "split") then
						var_80_0.gameObject:SetActive(true)
					else
						var_80_0.gameObject:SetActive(false)
					end
				end
			end

			local var_80_1 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_1 then
				arg_77_1.actors_["10097"].transform.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos10097, Vector3.New(0, -350, -180), (arg_77_1.time_ - 0) / var_80_1)
			end

			if arg_77_1.time_ >= 0 + var_80_1 and arg_77_1.time_ < 0 + var_80_1 + arg_80_0 then
				arg_77_1.actors_["10097"].transform.localPosition = Vector3.New(0, -350, -180)
			end

			local var_80_2 = arg_77_1.actors_["10097"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_2) and arg_77_1.var_.actorSpriteComps10097 == nil then
				arg_77_1.var_.actorSpriteComps10097 = var_80_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_3 = 2

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_3 and not isNil(var_80_2) then
				if arg_77_1.var_.actorSpriteComps10097 then
					for iter_80_1, iter_80_2 in pairs(arg_77_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_80_2 then
							if arg_77_1.isInRecall_ then
								iter_80_2.color = Color.New(Mathf.Lerp(iter_80_2.color.r, arg_77_1.hightColor2.r, (arg_77_1.time_ - 0) / var_80_3), Mathf.Lerp(iter_80_2.color.g, arg_77_1.hightColor2.g, (arg_77_1.time_ - 0) / var_80_3), (Mathf.Lerp(iter_80_2.color.b, arg_77_1.hightColor2.b, (arg_77_1.time_ - 0) / var_80_3)))
							else
								local var_80_4 = Mathf.Lerp(iter_80_2.color.r, 0.5, (arg_77_1.time_ - 0) / var_80_3)

								iter_80_2.color = Color.New(var_80_4, var_80_4, var_80_4)
							end
						end
					end
				end
			end

			if arg_77_1.time_ >= 0 + var_80_3 and arg_77_1.time_ < 0 + var_80_3 + arg_80_0 and not isNil(var_80_2) and arg_77_1.var_.actorSpriteComps10097 then
				for iter_80_3, iter_80_4 in pairs(arg_77_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_80_4 then
						iter_80_4.color = arg_77_1.isInRecall_ and (arg_77_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_77_1.var_.actorSpriteComps10097 = nil
			end

			local var_80_5 = 0
			local var_80_6 = 0.425

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_5 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[995].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, true)
				arg_77_1.iconController_:SetSelectedState("hero")

				arg_77_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10096")

				arg_77_1.callingController_:SetSelectedState("normal")

				arg_77_1.keyicon_.color = Color.New(1, 1, 1)
				arg_77_1.icon_.color = Color.New(1, 1, 1)

				local var_80_7 = arg_77_1:GetWordFromCfg(413041019)
				local var_80_8 = arg_77_1:FormatText(var_80_7.content)

				arg_77_1.text_.text = var_80_8

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_10 = 17 <= 0 and var_80_6 or var_80_6 * (utf8.len(var_80_8) / 17)

				if (17 <= 0 and var_80_6 or var_80_6 * (utf8.len(var_80_8) / 17)) > 0 and var_80_6 < var_80_10 then
					arg_77_1.talkMaxDuration = var_80_10

					if var_80_10 + var_80_5 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_10 + var_80_5
					end
				end

				arg_77_1.text_.text = var_80_8
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413041", "413041019", "story_v_out_413041.awb") ~= 0 then
					local var_80_11 = manager.audio:GetVoiceLength("story_v_out_413041", "413041019", "story_v_out_413041.awb") / 1000

					if var_80_11 + var_80_5 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_11 + var_80_5
					end

					if var_80_7.prefab_name ~= "" and arg_77_1.actors_[var_80_7.prefab_name] ~= nil then
						local var_80_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_7.prefab_name].transform, "story_v_out_413041", "413041019", "story_v_out_413041.awb")

						arg_77_1:RecordAudio("413041019", var_80_12)
						arg_77_1:RecordAudio("413041019", var_80_12)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_413041", "413041019", "story_v_out_413041.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_413041", "413041019", "story_v_out_413041.awb")
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
				actorName = "10097",
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
	Play413041020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 413041020
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play413041021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 1.15

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, false)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_1 = arg_81_1:FormatText(arg_81_1:GetWordFromCfg(413041020).content)

				arg_81_1.text_.text = var_84_1

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_3 = 46 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_1) / 46)

				if (46 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_1) / 46)) > 0 and var_84_0 < var_84_3 then
					arg_81_1.talkMaxDuration = var_84_3

					if var_84_3 + 0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_3 + 0
					end
				end

				arg_81_1.text_.text = var_84_1
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_4 = math.max(var_84_0, arg_81_1.talkMaxDuration)

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_4 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - 0) / var_84_4

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= 0 + var_84_4 and arg_81_1.time_ < 0 + var_84_4 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play413041021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 413041021
		arg_85_1.duration_ = 6.9

		local var_85_0 = {
			zh = 5,
			ja = 6.9
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
				arg_85_0:Play413041022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos10097 = arg_85_1.actors_["10097"].transform.localPosition
				arg_85_1.actors_["10097"].transform.localScale = Vector3.New(1, 1, 1)

				arg_85_1:CheckSpriteTmpPos("10097", 3)

				for iter_88_0 = 0, arg_85_1.actors_["10097"].transform.childCount - 1 do
					local var_88_0 = arg_85_1.actors_["10097"].transform:GetChild(iter_88_0)

					if var_88_0.name == "" or not string.find(var_88_0.name, "split") then
						var_88_0.gameObject:SetActive(true)
					else
						var_88_0.gameObject:SetActive(false)
					end
				end
			end

			local var_88_1 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_1 then
				arg_85_1.actors_["10097"].transform.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos10097, Vector3.New(0, -350, -180), (arg_85_1.time_ - 0) / var_88_1)
			end

			if arg_85_1.time_ >= 0 + var_88_1 and arg_85_1.time_ < 0 + var_88_1 + arg_88_0 then
				arg_85_1.actors_["10097"].transform.localPosition = Vector3.New(0, -350, -180)
			end

			local var_88_2 = arg_85_1.actors_["10097"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_2) and arg_85_1.var_.actorSpriteComps10097 == nil then
				arg_85_1.var_.actorSpriteComps10097 = var_88_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_3 = 2

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_3 and not isNil(var_88_2) then
				if arg_85_1.var_.actorSpriteComps10097 then
					for iter_88_1, iter_88_2 in pairs(arg_85_1.var_.actorSpriteComps10097:ToTable()) do
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

			if arg_85_1.time_ >= 0 + var_88_3 and arg_85_1.time_ < 0 + var_88_3 + arg_88_0 and not isNil(var_88_2) and arg_85_1.var_.actorSpriteComps10097 then
				for iter_88_3, iter_88_4 in pairs(arg_85_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_88_4 then
						iter_88_4.color = arg_85_1.isInRecall_ and (arg_85_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_85_1.var_.actorSpriteComps10097 = nil
			end

			local var_88_5 = 0
			local var_88_6 = 0.425

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_5 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_7 = arg_85_1:GetWordFromCfg(413041021)
				local var_88_8 = arg_85_1:FormatText(var_88_7.content)

				arg_85_1.text_.text = var_88_8

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_10 = 17 <= 0 and var_88_6 or var_88_6 * (utf8.len(var_88_8) / 17)

				if (17 <= 0 and var_88_6 or var_88_6 * (utf8.len(var_88_8) / 17)) > 0 and var_88_6 < var_88_10 then
					arg_85_1.talkMaxDuration = var_88_10

					if var_88_10 + var_88_5 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_10 + var_88_5
					end
				end

				arg_85_1.text_.text = var_88_8
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413041", "413041021", "story_v_out_413041.awb") ~= 0 then
					local var_88_11 = manager.audio:GetVoiceLength("story_v_out_413041", "413041021", "story_v_out_413041.awb") / 1000

					if var_88_11 + var_88_5 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_11 + var_88_5
					end

					if var_88_7.prefab_name ~= "" and arg_85_1.actors_[var_88_7.prefab_name] ~= nil then
						local var_88_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_7.prefab_name].transform, "story_v_out_413041", "413041021", "story_v_out_413041.awb")

						arg_85_1:RecordAudio("413041021", var_88_12)
						arg_85_1:RecordAudio("413041021", var_88_12)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_413041", "413041021", "story_v_out_413041.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_413041", "413041021", "story_v_out_413041.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_13 = math.max(var_88_6, arg_85_1.talkMaxDuration)

			if var_88_5 <= arg_85_1.time_ and arg_85_1.time_ < var_88_5 + var_88_13 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_5) / var_88_13

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_5 + var_88_13 and arg_85_1.time_ < var_88_5 + var_88_13 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10097",
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
	Play413041022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 413041022
		arg_89_1.duration_ = 3.67

		local var_89_0 = {
			zh = 3.666,
			ja = 2.566
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
				arg_89_0:Play413041023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos10097 = arg_89_1.actors_["10097"].transform.localPosition
				arg_89_1.actors_["10097"].transform.localScale = Vector3.New(1, 1, 1)

				arg_89_1:CheckSpriteTmpPos("10097", 0)

				for iter_92_0 = 0, arg_89_1.actors_["10097"].transform.childCount - 1 do
					local var_92_0 = arg_89_1.actors_["10097"].transform:GetChild(iter_92_0)

					if var_92_0.name == "" or not string.find(var_92_0.name, "split") then
						var_92_0.gameObject:SetActive(true)
					else
						var_92_0.gameObject:SetActive(false)
					end
				end
			end

			local var_92_1 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_1 then
				arg_89_1.actors_["10097"].transform.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos10097, Vector3.New(-1500, -350, -180), (arg_89_1.time_ - 0) / var_92_1)
			end

			if arg_89_1.time_ >= 0 + var_92_1 and arg_89_1.time_ < 0 + var_92_1 + arg_92_0 then
				arg_89_1.actors_["10097"].transform.localPosition = Vector3.New(-1500, -350, -180)
			end

			local var_92_2 = arg_89_1.actors_["10094"].transform

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos10094 = var_92_2.localPosition
				var_92_2.localScale = Vector3.New(1, 1, 1)

				arg_89_1:CheckSpriteTmpPos("10094", 3)

				for iter_92_1 = 0, var_92_2.childCount - 1 do
					local var_92_3 = var_92_2:GetChild(iter_92_1)

					if var_92_3.name == "" or not string.find(var_92_3.name, "split") then
						var_92_3.gameObject:SetActive(true)
					else
						var_92_3.gameObject:SetActive(false)
					end
				end
			end

			local var_92_4 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_4 then
				var_92_2.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos10094, Vector3.New(0, -340, -414), (arg_89_1.time_ - 0) / var_92_4)
			end

			if arg_89_1.time_ >= 0 + var_92_4 and arg_89_1.time_ < 0 + var_92_4 + arg_92_0 then
				var_92_2.localPosition = Vector3.New(0, -340, -414)
			end

			local var_92_5 = arg_89_1.actors_["10097"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_5) and arg_89_1.var_.actorSpriteComps10097 == nil then
				arg_89_1.var_.actorSpriteComps10097 = var_92_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_92_6 = 2

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_6 and not isNil(var_92_5) then
				if arg_89_1.var_.actorSpriteComps10097 then
					for iter_92_2, iter_92_3 in pairs(arg_89_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_92_3 then
							if arg_89_1.isInRecall_ then
								iter_92_3.color = Color.New(Mathf.Lerp(iter_92_3.color.r, arg_89_1.hightColor2.r, (arg_89_1.time_ - 0) / var_92_6), Mathf.Lerp(iter_92_3.color.g, arg_89_1.hightColor2.g, (arg_89_1.time_ - 0) / var_92_6), (Mathf.Lerp(iter_92_3.color.b, arg_89_1.hightColor2.b, (arg_89_1.time_ - 0) / var_92_6)))
							else
								local var_92_7 = Mathf.Lerp(iter_92_3.color.r, 0.5, (arg_89_1.time_ - 0) / var_92_6)

								iter_92_3.color = Color.New(var_92_7, var_92_7, var_92_7)
							end
						end
					end
				end
			end

			if arg_89_1.time_ >= 0 + var_92_6 and arg_89_1.time_ < 0 + var_92_6 + arg_92_0 and not isNil(var_92_5) and arg_89_1.var_.actorSpriteComps10097 then
				for iter_92_4, iter_92_5 in pairs(arg_89_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_92_5 then
						iter_92_5.color = arg_89_1.isInRecall_ and (arg_89_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_89_1.var_.actorSpriteComps10097 = nil
			end

			local var_92_8 = arg_89_1.actors_["10094"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_8) and arg_89_1.var_.actorSpriteComps10094 == nil then
				arg_89_1.var_.actorSpriteComps10094 = var_92_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_92_9 = 2

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_9 and not isNil(var_92_8) then
				if arg_89_1.var_.actorSpriteComps10094 then
					for iter_92_6, iter_92_7 in pairs(arg_89_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_92_7 then
							if arg_89_1.isInRecall_ then
								iter_92_7.color = Color.New(Mathf.Lerp(iter_92_7.color.r, arg_89_1.hightColor1.r, (arg_89_1.time_ - 0) / var_92_9), Mathf.Lerp(iter_92_7.color.g, arg_89_1.hightColor1.g, (arg_89_1.time_ - 0) / var_92_9), (Mathf.Lerp(iter_92_7.color.b, arg_89_1.hightColor1.b, (arg_89_1.time_ - 0) / var_92_9)))
							else
								local var_92_10 = Mathf.Lerp(iter_92_7.color.r, 1, (arg_89_1.time_ - 0) / var_92_9)

								iter_92_7.color = Color.New(var_92_10, var_92_10, var_92_10)
							end
						end
					end
				end
			end

			if arg_89_1.time_ >= 0 + var_92_9 and arg_89_1.time_ < 0 + var_92_9 + arg_92_0 and not isNil(var_92_8) and arg_89_1.var_.actorSpriteComps10094 then
				for iter_92_8, iter_92_9 in pairs(arg_89_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_92_9 then
						iter_92_9.color = arg_89_1.isInRecall_ and (arg_89_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_89_1.var_.actorSpriteComps10094 = nil
			end

			local var_92_11 = 0
			local var_92_12 = 0.35

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_11 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_13 = arg_89_1:GetWordFromCfg(413041022)
				local var_92_14 = arg_89_1:FormatText(var_92_13.content)

				arg_89_1.text_.text = var_92_14

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_16 = 14 <= 0 and var_92_12 or var_92_12 * (utf8.len(var_92_14) / 14)

				if (14 <= 0 and var_92_12 or var_92_12 * (utf8.len(var_92_14) / 14)) > 0 and var_92_12 < var_92_16 then
					arg_89_1.talkMaxDuration = var_92_16

					if var_92_16 + var_92_11 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_16 + var_92_11
					end
				end

				arg_89_1.text_.text = var_92_14
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413041", "413041022", "story_v_out_413041.awb") ~= 0 then
					local var_92_17 = manager.audio:GetVoiceLength("story_v_out_413041", "413041022", "story_v_out_413041.awb") / 1000

					if var_92_17 + var_92_11 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_17 + var_92_11
					end

					if var_92_13.prefab_name ~= "" and arg_89_1.actors_[var_92_13.prefab_name] ~= nil then
						local var_92_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_13.prefab_name].transform, "story_v_out_413041", "413041022", "story_v_out_413041.awb")

						arg_89_1:RecordAudio("413041022", var_92_18)
						arg_89_1:RecordAudio("413041022", var_92_18)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_413041", "413041022", "story_v_out_413041.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_413041", "413041022", "story_v_out_413041.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_19 = math.max(var_92_12, arg_89_1.talkMaxDuration)

			if var_92_11 <= arg_89_1.time_ and arg_89_1.time_ < var_92_11 + var_92_19 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_11) / var_92_19

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_11 + var_92_19 and arg_89_1.time_ < var_92_11 + var_92_19 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10097",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10094",
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
	Play413041023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 413041023
		arg_93_1.duration_ = 6.93

		local var_93_0 = {
			zh = 5.966,
			ja = 6.933
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
				arg_93_0:Play413041024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos10094 = arg_93_1.actors_["10094"].transform.localPosition
				arg_93_1.actors_["10094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_93_1:CheckSpriteTmpPos("10094", 7)

				for iter_96_0 = 0, arg_93_1.actors_["10094"].transform.childCount - 1 do
					local var_96_0 = arg_93_1.actors_["10094"].transform:GetChild(iter_96_0)

					if var_96_0.name == "" or not string.find(var_96_0.name, "split") then
						var_96_0.gameObject:SetActive(true)
					else
						var_96_0.gameObject:SetActive(false)
					end
				end
			end

			local var_96_1 = 0.001

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_1 then
				arg_93_1.actors_["10094"].transform.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos10094, Vector3.New(0, -2000, 0), (arg_93_1.time_ - 0) / var_96_1)
			end

			if arg_93_1.time_ >= 0 + var_96_1 and arg_93_1.time_ < 0 + var_96_1 + arg_96_0 then
				arg_93_1.actors_["10094"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_96_2 = arg_93_1.actors_["10092"].transform

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos10092 = var_96_2.localPosition
				var_96_2.localScale = Vector3.New(1, 1, 1)

				arg_93_1:CheckSpriteTmpPos("10092", 3)

				for iter_96_1 = 0, var_96_2.childCount - 1 do
					local var_96_3 = var_96_2:GetChild(iter_96_1)

					if var_96_3.name == "" or not string.find(var_96_3.name, "split") then
						var_96_3.gameObject:SetActive(true)
					else
						var_96_3.gameObject:SetActive(false)
					end
				end
			end

			local var_96_4 = 0.001

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_4 then
				var_96_2.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos10092, Vector3.New(0, -300, -295), (arg_93_1.time_ - 0) / var_96_4)
			end

			if arg_93_1.time_ >= 0 + var_96_4 and arg_93_1.time_ < 0 + var_96_4 + arg_96_0 then
				var_96_2.localPosition = Vector3.New(0, -300, -295)
			end

			local var_96_5 = arg_93_1.actors_["10094"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_5) and arg_93_1.var_.actorSpriteComps10094 == nil then
				arg_93_1.var_.actorSpriteComps10094 = var_96_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_96_6 = 2

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_6 and not isNil(var_96_5) then
				if arg_93_1.var_.actorSpriteComps10094 then
					for iter_96_2, iter_96_3 in pairs(arg_93_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_96_3 then
							if arg_93_1.isInRecall_ then
								iter_96_3.color = Color.New(Mathf.Lerp(iter_96_3.color.r, arg_93_1.hightColor2.r, (arg_93_1.time_ - 0) / var_96_6), Mathf.Lerp(iter_96_3.color.g, arg_93_1.hightColor2.g, (arg_93_1.time_ - 0) / var_96_6), (Mathf.Lerp(iter_96_3.color.b, arg_93_1.hightColor2.b, (arg_93_1.time_ - 0) / var_96_6)))
							else
								local var_96_7 = Mathf.Lerp(iter_96_3.color.r, 0.5, (arg_93_1.time_ - 0) / var_96_6)

								iter_96_3.color = Color.New(var_96_7, var_96_7, var_96_7)
							end
						end
					end
				end
			end

			if arg_93_1.time_ >= 0 + var_96_6 and arg_93_1.time_ < 0 + var_96_6 + arg_96_0 and not isNil(var_96_5) and arg_93_1.var_.actorSpriteComps10094 then
				for iter_96_4, iter_96_5 in pairs(arg_93_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_96_5 then
						iter_96_5.color = arg_93_1.isInRecall_ and (arg_93_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_93_1.var_.actorSpriteComps10094 = nil
			end

			local var_96_8 = arg_93_1.actors_["10092"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_8) and arg_93_1.var_.actorSpriteComps10092 == nil then
				arg_93_1.var_.actorSpriteComps10092 = var_96_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_96_9 = 2

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_9 and not isNil(var_96_8) then
				if arg_93_1.var_.actorSpriteComps10092 then
					for iter_96_6, iter_96_7 in pairs(arg_93_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_96_7 then
							if arg_93_1.isInRecall_ then
								iter_96_7.color = Color.New(Mathf.Lerp(iter_96_7.color.r, arg_93_1.hightColor1.r, (arg_93_1.time_ - 0) / var_96_9), Mathf.Lerp(iter_96_7.color.g, arg_93_1.hightColor1.g, (arg_93_1.time_ - 0) / var_96_9), (Mathf.Lerp(iter_96_7.color.b, arg_93_1.hightColor1.b, (arg_93_1.time_ - 0) / var_96_9)))
							else
								local var_96_10 = Mathf.Lerp(iter_96_7.color.r, 1, (arg_93_1.time_ - 0) / var_96_9)

								iter_96_7.color = Color.New(var_96_10, var_96_10, var_96_10)
							end
						end
					end
				end
			end

			if arg_93_1.time_ >= 0 + var_96_9 and arg_93_1.time_ < 0 + var_96_9 + arg_96_0 and not isNil(var_96_8) and arg_93_1.var_.actorSpriteComps10092 then
				for iter_96_8, iter_96_9 in pairs(arg_93_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_96_9 then
						iter_96_9.color = arg_93_1.isInRecall_ and (arg_93_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_93_1.var_.actorSpriteComps10092 = nil
			end

			local var_96_11 = 0
			local var_96_12 = 0.775

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_11 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_13 = arg_93_1:GetWordFromCfg(413041023)
				local var_96_14 = arg_93_1:FormatText(var_96_13.content)

				arg_93_1.text_.text = var_96_14

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_16 = 31 <= 0 and var_96_12 or var_96_12 * (utf8.len(var_96_14) / 31)

				if (31 <= 0 and var_96_12 or var_96_12 * (utf8.len(var_96_14) / 31)) > 0 and var_96_12 < var_96_16 then
					arg_93_1.talkMaxDuration = var_96_16

					if var_96_16 + var_96_11 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_16 + var_96_11
					end
				end

				arg_93_1.text_.text = var_96_14
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413041", "413041023", "story_v_out_413041.awb") ~= 0 then
					local var_96_17 = manager.audio:GetVoiceLength("story_v_out_413041", "413041023", "story_v_out_413041.awb") / 1000

					if var_96_17 + var_96_11 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_17 + var_96_11
					end

					if var_96_13.prefab_name ~= "" and arg_93_1.actors_[var_96_13.prefab_name] ~= nil then
						local var_96_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_13.prefab_name].transform, "story_v_out_413041", "413041023", "story_v_out_413041.awb")

						arg_93_1:RecordAudio("413041023", var_96_18)
						arg_93_1:RecordAudio("413041023", var_96_18)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_413041", "413041023", "story_v_out_413041.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_413041", "413041023", "story_v_out_413041.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_19 = math.max(var_96_12, arg_93_1.talkMaxDuration)

			if var_96_11 <= arg_93_1.time_ and arg_93_1.time_ < var_96_11 + var_96_19 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_11) / var_96_19

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_11 + var_96_19 and arg_93_1.time_ < var_96_11 + var_96_19 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_93_1:InitPlayNodeList()
	end,
	Play413041024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 413041024
		arg_97_1.duration_ = 3.5

		local var_97_0 = {
			zh = 3.466,
			ja = 3.5
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
				arg_97_0:Play413041025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(arg_97_1.actors_["10092"]) and arg_97_1.var_.actorSpriteComps10092 == nil then
				arg_97_1.var_.actorSpriteComps10092 = arg_97_1.actors_["10092"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_100_0 = 2

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 and not isNil(arg_97_1.actors_["10092"]) then
				if arg_97_1.var_.actorSpriteComps10092 then
					for iter_100_0, iter_100_1 in pairs(arg_97_1.var_.actorSpriteComps10092:ToTable()) do
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

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 and not isNil(arg_97_1.actors_["10092"]) and arg_97_1.var_.actorSpriteComps10092 then
				for iter_100_2, iter_100_3 in pairs(arg_97_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_100_3 then
						iter_100_3.color = arg_97_1.isInRecall_ and (arg_97_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_97_1.var_.actorSpriteComps10092 = nil
			end

			local var_100_2 = 0
			local var_100_3 = 0.35

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_2 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[995].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, true)
				arg_97_1.iconController_:SetSelectedState("hero")

				arg_97_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10096")

				arg_97_1.callingController_:SetSelectedState("normal")

				arg_97_1.keyicon_.color = Color.New(1, 1, 1)
				arg_97_1.icon_.color = Color.New(1, 1, 1)

				local var_100_4 = arg_97_1:GetWordFromCfg(413041024)
				local var_100_5 = arg_97_1:FormatText(var_100_4.content)

				arg_97_1.text_.text = var_100_5

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_7 = 14 <= 0 and var_100_3 or var_100_3 * (utf8.len(var_100_5) / 14)

				if (14 <= 0 and var_100_3 or var_100_3 * (utf8.len(var_100_5) / 14)) > 0 and var_100_3 < var_100_7 then
					arg_97_1.talkMaxDuration = var_100_7

					if var_100_7 + var_100_2 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_7 + var_100_2
					end
				end

				arg_97_1.text_.text = var_100_5
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413041", "413041024", "story_v_out_413041.awb") ~= 0 then
					local var_100_8 = manager.audio:GetVoiceLength("story_v_out_413041", "413041024", "story_v_out_413041.awb") / 1000

					if var_100_8 + var_100_2 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_8 + var_100_2
					end

					if var_100_4.prefab_name ~= "" and arg_97_1.actors_[var_100_4.prefab_name] ~= nil then
						local var_100_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_4.prefab_name].transform, "story_v_out_413041", "413041024", "story_v_out_413041.awb")

						arg_97_1:RecordAudio("413041024", var_100_9)
						arg_97_1:RecordAudio("413041024", var_100_9)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_413041", "413041024", "story_v_out_413041.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_413041", "413041024", "story_v_out_413041.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_10 = math.max(var_100_3, arg_97_1.talkMaxDuration)

			if var_100_2 <= arg_97_1.time_ and arg_97_1.time_ < var_100_2 + var_100_10 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_2) / var_100_10

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_2 + var_100_10 and arg_97_1.time_ < var_100_2 + var_100_10 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play413041025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 413041025
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play413041026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0.825

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

				local var_104_1 = arg_101_1:FormatText(arg_101_1:GetWordFromCfg(413041025).content)

				arg_101_1.text_.text = var_104_1

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_3 = 33 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_1) / 33)

				if (33 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_1) / 33)) > 0 and var_104_0 < var_104_3 then
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
	Play413041026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 413041026
		arg_105_1.duration_ = 4.37

		local var_105_0 = {
			zh = 4.366,
			ja = 4.266
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
				arg_105_0:Play413041027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(arg_105_1.actors_["10092"]) and arg_105_1.var_.actorSpriteComps10092 == nil then
				arg_105_1.var_.actorSpriteComps10092 = arg_105_1.actors_["10092"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_108_0 = 2

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 and not isNil(arg_105_1.actors_["10092"]) then
				if arg_105_1.var_.actorSpriteComps10092 then
					for iter_108_0, iter_108_1 in pairs(arg_105_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_108_1 then
							if arg_105_1.isInRecall_ then
								iter_108_1.color = Color.New(Mathf.Lerp(iter_108_1.color.r, arg_105_1.hightColor1.r, (arg_105_1.time_ - 0) / var_108_0), Mathf.Lerp(iter_108_1.color.g, arg_105_1.hightColor1.g, (arg_105_1.time_ - 0) / var_108_0), (Mathf.Lerp(iter_108_1.color.b, arg_105_1.hightColor1.b, (arg_105_1.time_ - 0) / var_108_0)))
							else
								local var_108_1 = Mathf.Lerp(iter_108_1.color.r, 1, (arg_105_1.time_ - 0) / var_108_0)

								iter_108_1.color = Color.New(var_108_1, var_108_1, var_108_1)
							end
						end
					end
				end
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 and not isNil(arg_105_1.actors_["10092"]) and arg_105_1.var_.actorSpriteComps10092 then
				for iter_108_2, iter_108_3 in pairs(arg_105_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_108_3 then
						iter_108_3.color = arg_105_1.isInRecall_ and (arg_105_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_105_1.var_.actorSpriteComps10092 = nil
			end

			local var_108_2 = 0
			local var_108_3 = 0.55

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_2 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_4 = arg_105_1:GetWordFromCfg(413041026)
				local var_108_5 = arg_105_1:FormatText(var_108_4.content)

				arg_105_1.text_.text = var_108_5

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_7 = 22 <= 0 and var_108_3 or var_108_3 * (utf8.len(var_108_5) / 22)

				if (22 <= 0 and var_108_3 or var_108_3 * (utf8.len(var_108_5) / 22)) > 0 and var_108_3 < var_108_7 then
					arg_105_1.talkMaxDuration = var_108_7

					if var_108_7 + var_108_2 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_7 + var_108_2
					end
				end

				arg_105_1.text_.text = var_108_5
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413041", "413041026", "story_v_out_413041.awb") ~= 0 then
					local var_108_8 = manager.audio:GetVoiceLength("story_v_out_413041", "413041026", "story_v_out_413041.awb") / 1000

					if var_108_8 + var_108_2 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_8 + var_108_2
					end

					if var_108_4.prefab_name ~= "" and arg_105_1.actors_[var_108_4.prefab_name] ~= nil then
						local var_108_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_4.prefab_name].transform, "story_v_out_413041", "413041026", "story_v_out_413041.awb")

						arg_105_1:RecordAudio("413041026", var_108_9)
						arg_105_1:RecordAudio("413041026", var_108_9)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_413041", "413041026", "story_v_out_413041.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_413041", "413041026", "story_v_out_413041.awb")
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
	Play413041027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 413041027
		arg_109_1.duration_ = 3.6

		local var_109_0 = {
			zh = 3,
			ja = 3.6
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
				arg_109_0:Play413041028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.var_.moveOldPos10092 = arg_109_1.actors_["10092"].transform.localPosition
				arg_109_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_109_1:CheckSpriteTmpPos("10092", 4)

				for iter_112_0 = 0, arg_109_1.actors_["10092"].transform.childCount - 1 do
					local var_112_0 = arg_109_1.actors_["10092"].transform:GetChild(iter_112_0)

					if var_112_0.name == "" or not string.find(var_112_0.name, "split") then
						var_112_0.gameObject:SetActive(true)
					else
						var_112_0.gameObject:SetActive(false)
					end
				end
			end

			local var_112_1 = 0.001

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_1 then
				arg_109_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos10092, Vector3.New(390, -300, -295), (arg_109_1.time_ - 0) / var_112_1)
			end

			if arg_109_1.time_ >= 0 + var_112_1 and arg_109_1.time_ < 0 + var_112_1 + arg_112_0 then
				arg_109_1.actors_["10092"].transform.localPosition = Vector3.New(390, -300, -295)
			end

			local var_112_2 = arg_109_1.actors_["10022"].transform

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.var_.moveOldPos10022 = var_112_2.localPosition
				var_112_2.localScale = Vector3.New(1, 1, 1)

				arg_109_1:CheckSpriteTmpPos("10022", 2)

				for iter_112_1 = 0, var_112_2.childCount - 1 do
					local var_112_3 = var_112_2:GetChild(iter_112_1)

					if var_112_3.name == "" or not string.find(var_112_3.name, "split") then
						var_112_3.gameObject:SetActive(true)
					else
						var_112_3.gameObject:SetActive(false)
					end
				end
			end

			local var_112_4 = 0.001

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_4 then
				var_112_2.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos10022, Vector3.New(-390, -315, -320), (arg_109_1.time_ - 0) / var_112_4)
			end

			if arg_109_1.time_ >= 0 + var_112_4 and arg_109_1.time_ < 0 + var_112_4 + arg_112_0 then
				var_112_2.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_112_5 = arg_109_1.actors_["10092"]

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(var_112_5) and arg_109_1.var_.actorSpriteComps10092 == nil then
				arg_109_1.var_.actorSpriteComps10092 = var_112_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_112_6 = 2

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_6 and not isNil(var_112_5) then
				if arg_109_1.var_.actorSpriteComps10092 then
					for iter_112_2, iter_112_3 in pairs(arg_109_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_112_3 then
							if arg_109_1.isInRecall_ then
								iter_112_3.color = Color.New(Mathf.Lerp(iter_112_3.color.r, arg_109_1.hightColor2.r, (arg_109_1.time_ - 0) / var_112_6), Mathf.Lerp(iter_112_3.color.g, arg_109_1.hightColor2.g, (arg_109_1.time_ - 0) / var_112_6), (Mathf.Lerp(iter_112_3.color.b, arg_109_1.hightColor2.b, (arg_109_1.time_ - 0) / var_112_6)))
							else
								local var_112_7 = Mathf.Lerp(iter_112_3.color.r, 0.5, (arg_109_1.time_ - 0) / var_112_6)

								iter_112_3.color = Color.New(var_112_7, var_112_7, var_112_7)
							end
						end
					end
				end
			end

			if arg_109_1.time_ >= 0 + var_112_6 and arg_109_1.time_ < 0 + var_112_6 + arg_112_0 and not isNil(var_112_5) and arg_109_1.var_.actorSpriteComps10092 then
				for iter_112_4, iter_112_5 in pairs(arg_109_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_112_5 then
						iter_112_5.color = arg_109_1.isInRecall_ and (arg_109_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_109_1.var_.actorSpriteComps10092 = nil
			end

			local var_112_8 = arg_109_1.actors_["10022"]

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(var_112_8) and arg_109_1.var_.actorSpriteComps10022 == nil then
				arg_109_1.var_.actorSpriteComps10022 = var_112_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_112_9 = 2

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_9 and not isNil(var_112_8) then
				if arg_109_1.var_.actorSpriteComps10022 then
					for iter_112_6, iter_112_7 in pairs(arg_109_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_112_7 then
							if arg_109_1.isInRecall_ then
								iter_112_7.color = Color.New(Mathf.Lerp(iter_112_7.color.r, arg_109_1.hightColor1.r, (arg_109_1.time_ - 0) / var_112_9), Mathf.Lerp(iter_112_7.color.g, arg_109_1.hightColor1.g, (arg_109_1.time_ - 0) / var_112_9), (Mathf.Lerp(iter_112_7.color.b, arg_109_1.hightColor1.b, (arg_109_1.time_ - 0) / var_112_9)))
							else
								local var_112_10 = Mathf.Lerp(iter_112_7.color.r, 1, (arg_109_1.time_ - 0) / var_112_9)

								iter_112_7.color = Color.New(var_112_10, var_112_10, var_112_10)
							end
						end
					end
				end
			end

			if arg_109_1.time_ >= 0 + var_112_9 and arg_109_1.time_ < 0 + var_112_9 + arg_112_0 and not isNil(var_112_8) and arg_109_1.var_.actorSpriteComps10022 then
				for iter_112_8, iter_112_9 in pairs(arg_109_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_112_9 then
						iter_112_9.color = arg_109_1.isInRecall_ and (arg_109_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_109_1.var_.actorSpriteComps10022 = nil
			end

			local var_112_11 = 0
			local var_112_12 = 0.4

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_11 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_13 = arg_109_1:GetWordFromCfg(413041027)
				local var_112_14 = arg_109_1:FormatText(var_112_13.content)

				arg_109_1.text_.text = var_112_14

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_16 = 16 <= 0 and var_112_12 or var_112_12 * (utf8.len(var_112_14) / 16)

				if (16 <= 0 and var_112_12 or var_112_12 * (utf8.len(var_112_14) / 16)) > 0 and var_112_12 < var_112_16 then
					arg_109_1.talkMaxDuration = var_112_16

					if var_112_16 + var_112_11 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_16 + var_112_11
					end
				end

				arg_109_1.text_.text = var_112_14
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413041", "413041027", "story_v_out_413041.awb") ~= 0 then
					local var_112_17 = manager.audio:GetVoiceLength("story_v_out_413041", "413041027", "story_v_out_413041.awb") / 1000

					if var_112_17 + var_112_11 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_17 + var_112_11
					end

					if var_112_13.prefab_name ~= "" and arg_109_1.actors_[var_112_13.prefab_name] ~= nil then
						local var_112_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_13.prefab_name].transform, "story_v_out_413041", "413041027", "story_v_out_413041.awb")

						arg_109_1:RecordAudio("413041027", var_112_18)
						arg_109_1:RecordAudio("413041027", var_112_18)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_413041", "413041027", "story_v_out_413041.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_413041", "413041027", "story_v_out_413041.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_19 = math.max(var_112_12, arg_109_1.talkMaxDuration)

			if var_112_11 <= arg_109_1.time_ and arg_109_1.time_ < var_112_11 + var_112_19 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_11) / var_112_19

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_11 + var_112_19 and arg_109_1.time_ < var_112_11 + var_112_19 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10022",
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
	Play413041028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 413041028
		arg_113_1.duration_ = 7.77

		local var_113_0 = {
			zh = 7.666,
			ja = 7.766
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
				arg_113_0:Play413041029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(arg_113_1.actors_["10022"]) and arg_113_1.var_.actorSpriteComps10022 == nil then
				arg_113_1.var_.actorSpriteComps10022 = arg_113_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_116_0 = 2

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_0 and not isNil(arg_113_1.actors_["10022"]) then
				if arg_113_1.var_.actorSpriteComps10022 then
					for iter_116_0, iter_116_1 in pairs(arg_113_1.var_.actorSpriteComps10022:ToTable()) do
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

			if arg_113_1.time_ >= 0 + var_116_0 and arg_113_1.time_ < 0 + var_116_0 + arg_116_0 and not isNil(arg_113_1.actors_["10022"]) and arg_113_1.var_.actorSpriteComps10022 then
				for iter_116_2, iter_116_3 in pairs(arg_113_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_116_3 then
						iter_116_3.color = arg_113_1.isInRecall_ and (arg_113_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_113_1.var_.actorSpriteComps10022 = nil
			end

			local var_116_2 = arg_113_1.actors_["10092"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_2) and arg_113_1.var_.actorSpriteComps10092 == nil then
				arg_113_1.var_.actorSpriteComps10092 = var_116_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_116_3 = 2

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_3 and not isNil(var_116_2) then
				if arg_113_1.var_.actorSpriteComps10092 then
					for iter_116_4, iter_116_5 in pairs(arg_113_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_116_5 then
							if arg_113_1.isInRecall_ then
								iter_116_5.color = Color.New(Mathf.Lerp(iter_116_5.color.r, arg_113_1.hightColor1.r, (arg_113_1.time_ - 0) / var_116_3), Mathf.Lerp(iter_116_5.color.g, arg_113_1.hightColor1.g, (arg_113_1.time_ - 0) / var_116_3), (Mathf.Lerp(iter_116_5.color.b, arg_113_1.hightColor1.b, (arg_113_1.time_ - 0) / var_116_3)))
							else
								local var_116_4 = Mathf.Lerp(iter_116_5.color.r, 1, (arg_113_1.time_ - 0) / var_116_3)

								iter_116_5.color = Color.New(var_116_4, var_116_4, var_116_4)
							end
						end
					end
				end
			end

			if arg_113_1.time_ >= 0 + var_116_3 and arg_113_1.time_ < 0 + var_116_3 + arg_116_0 and not isNil(var_116_2) and arg_113_1.var_.actorSpriteComps10092 then
				for iter_116_6, iter_116_7 in pairs(arg_113_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_116_7 then
						iter_116_7.color = arg_113_1.isInRecall_ and (arg_113_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_113_1.var_.actorSpriteComps10092 = nil
			end

			local var_116_5 = 0
			local var_116_6 = 0.775

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_5 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_7 = arg_113_1:GetWordFromCfg(413041028)
				local var_116_8 = arg_113_1:FormatText(var_116_7.content)

				arg_113_1.text_.text = var_116_8

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_10 = 31 <= 0 and var_116_6 or var_116_6 * (utf8.len(var_116_8) / 31)

				if (31 <= 0 and var_116_6 or var_116_6 * (utf8.len(var_116_8) / 31)) > 0 and var_116_6 < var_116_10 then
					arg_113_1.talkMaxDuration = var_116_10

					if var_116_10 + var_116_5 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_10 + var_116_5
					end
				end

				arg_113_1.text_.text = var_116_8
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413041", "413041028", "story_v_out_413041.awb") ~= 0 then
					local var_116_11 = manager.audio:GetVoiceLength("story_v_out_413041", "413041028", "story_v_out_413041.awb") / 1000

					if var_116_11 + var_116_5 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_11 + var_116_5
					end

					if var_116_7.prefab_name ~= "" and arg_113_1.actors_[var_116_7.prefab_name] ~= nil then
						local var_116_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_7.prefab_name].transform, "story_v_out_413041", "413041028", "story_v_out_413041.awb")

						arg_113_1:RecordAudio("413041028", var_116_12)
						arg_113_1:RecordAudio("413041028", var_116_12)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_413041", "413041028", "story_v_out_413041.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_413041", "413041028", "story_v_out_413041.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_13 = math.max(var_116_6, arg_113_1.talkMaxDuration)

			if var_116_5 <= arg_113_1.time_ and arg_113_1.time_ < var_116_5 + var_116_13 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_5) / var_116_13

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_5 + var_116_13 and arg_113_1.time_ < var_116_5 + var_116_13 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play413041029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 413041029
		arg_117_1.duration_ = 5.8

		local var_117_0 = {
			zh = 3.366,
			ja = 5.8
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
				arg_117_0:Play413041030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(arg_117_1.actors_["10092"]) and arg_117_1.var_.actorSpriteComps10092 == nil then
				arg_117_1.var_.actorSpriteComps10092 = arg_117_1.actors_["10092"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_120_0 = 2

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_0 and not isNil(arg_117_1.actors_["10092"]) then
				if arg_117_1.var_.actorSpriteComps10092 then
					for iter_120_0, iter_120_1 in pairs(arg_117_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_120_1 then
							if arg_117_1.isInRecall_ then
								iter_120_1.color = Color.New(Mathf.Lerp(iter_120_1.color.r, arg_117_1.hightColor2.r, (arg_117_1.time_ - 0) / var_120_0), Mathf.Lerp(iter_120_1.color.g, arg_117_1.hightColor2.g, (arg_117_1.time_ - 0) / var_120_0), (Mathf.Lerp(iter_120_1.color.b, arg_117_1.hightColor2.b, (arg_117_1.time_ - 0) / var_120_0)))
							else
								local var_120_1 = Mathf.Lerp(iter_120_1.color.r, 0.5, (arg_117_1.time_ - 0) / var_120_0)

								iter_120_1.color = Color.New(var_120_1, var_120_1, var_120_1)
							end
						end
					end
				end
			end

			if arg_117_1.time_ >= 0 + var_120_0 and arg_117_1.time_ < 0 + var_120_0 + arg_120_0 and not isNil(arg_117_1.actors_["10092"]) and arg_117_1.var_.actorSpriteComps10092 then
				for iter_120_2, iter_120_3 in pairs(arg_117_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_120_3 then
						iter_120_3.color = arg_117_1.isInRecall_ and (arg_117_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_117_1.var_.actorSpriteComps10092 = nil
			end

			local var_120_2 = 0
			local var_120_3 = 0.4

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_2 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[998].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, true)
				arg_117_1.iconController_:SetSelectedState("hero")

				arg_117_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightwoman1")

				arg_117_1.callingController_:SetSelectedState("normal")

				arg_117_1.keyicon_.color = Color.New(1, 1, 1)
				arg_117_1.icon_.color = Color.New(1, 1, 1)

				local var_120_4 = arg_117_1:GetWordFromCfg(413041029)
				local var_120_5 = arg_117_1:FormatText(var_120_4.content)

				arg_117_1.text_.text = var_120_5

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_7 = 16 <= 0 and var_120_3 or var_120_3 * (utf8.len(var_120_5) / 16)

				if (16 <= 0 and var_120_3 or var_120_3 * (utf8.len(var_120_5) / 16)) > 0 and var_120_3 < var_120_7 then
					arg_117_1.talkMaxDuration = var_120_7

					if var_120_7 + var_120_2 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_7 + var_120_2
					end
				end

				arg_117_1.text_.text = var_120_5
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413041", "413041029", "story_v_out_413041.awb") ~= 0 then
					local var_120_8 = manager.audio:GetVoiceLength("story_v_out_413041", "413041029", "story_v_out_413041.awb") / 1000

					if var_120_8 + var_120_2 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_8 + var_120_2
					end

					if var_120_4.prefab_name ~= "" and arg_117_1.actors_[var_120_4.prefab_name] ~= nil then
						local var_120_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_4.prefab_name].transform, "story_v_out_413041", "413041029", "story_v_out_413041.awb")

						arg_117_1:RecordAudio("413041029", var_120_9)
						arg_117_1:RecordAudio("413041029", var_120_9)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_413041", "413041029", "story_v_out_413041.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_413041", "413041029", "story_v_out_413041.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_10 = math.max(var_120_3, arg_117_1.talkMaxDuration)

			if var_120_2 <= arg_117_1.time_ and arg_117_1.time_ < var_120_2 + var_120_10 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_2) / var_120_10

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_2 + var_120_10 and arg_117_1.time_ < var_120_2 + var_120_10 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play413041030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 413041030
		arg_121_1.duration_ = 13.13

		local var_121_0 = {
			zh = 7.833,
			ja = 13.133
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
				arg_121_0:Play413041031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(arg_121_1.actors_["10092"]) and arg_121_1.var_.actorSpriteComps10092 == nil then
				arg_121_1.var_.actorSpriteComps10092 = arg_121_1.actors_["10092"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_124_0 = 2

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_0 and not isNil(arg_121_1.actors_["10092"]) then
				if arg_121_1.var_.actorSpriteComps10092 then
					for iter_124_0, iter_124_1 in pairs(arg_121_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_124_1 then
							if arg_121_1.isInRecall_ then
								iter_124_1.color = Color.New(Mathf.Lerp(iter_124_1.color.r, arg_121_1.hightColor2.r, (arg_121_1.time_ - 0) / var_124_0), Mathf.Lerp(iter_124_1.color.g, arg_121_1.hightColor2.g, (arg_121_1.time_ - 0) / var_124_0), (Mathf.Lerp(iter_124_1.color.b, arg_121_1.hightColor2.b, (arg_121_1.time_ - 0) / var_124_0)))
							else
								local var_124_1 = Mathf.Lerp(iter_124_1.color.r, 0.5, (arg_121_1.time_ - 0) / var_124_0)

								iter_124_1.color = Color.New(var_124_1, var_124_1, var_124_1)
							end
						end
					end
				end
			end

			if arg_121_1.time_ >= 0 + var_124_0 and arg_121_1.time_ < 0 + var_124_0 + arg_124_0 and not isNil(arg_121_1.actors_["10092"]) and arg_121_1.var_.actorSpriteComps10092 then
				for iter_124_2, iter_124_3 in pairs(arg_121_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_124_3 then
						iter_124_3.color = arg_121_1.isInRecall_ and (arg_121_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_121_1.var_.actorSpriteComps10092 = nil
			end

			local var_124_2 = arg_121_1.actors_["10022"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_2) and arg_121_1.var_.actorSpriteComps10022 == nil then
				arg_121_1.var_.actorSpriteComps10022 = var_124_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_124_3 = 2

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_3 and not isNil(var_124_2) then
				if arg_121_1.var_.actorSpriteComps10022 then
					for iter_124_4, iter_124_5 in pairs(arg_121_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_124_5 then
							if arg_121_1.isInRecall_ then
								iter_124_5.color = Color.New(Mathf.Lerp(iter_124_5.color.r, arg_121_1.hightColor1.r, (arg_121_1.time_ - 0) / var_124_3), Mathf.Lerp(iter_124_5.color.g, arg_121_1.hightColor1.g, (arg_121_1.time_ - 0) / var_124_3), (Mathf.Lerp(iter_124_5.color.b, arg_121_1.hightColor1.b, (arg_121_1.time_ - 0) / var_124_3)))
							else
								local var_124_4 = Mathf.Lerp(iter_124_5.color.r, 1, (arg_121_1.time_ - 0) / var_124_3)

								iter_124_5.color = Color.New(var_124_4, var_124_4, var_124_4)
							end
						end
					end
				end
			end

			if arg_121_1.time_ >= 0 + var_124_3 and arg_121_1.time_ < 0 + var_124_3 + arg_124_0 and not isNil(var_124_2) and arg_121_1.var_.actorSpriteComps10022 then
				for iter_124_6, iter_124_7 in pairs(arg_121_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_124_7 then
						iter_124_7.color = arg_121_1.isInRecall_ and (arg_121_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_121_1.var_.actorSpriteComps10022 = nil
			end

			local var_124_5 = 0
			local var_124_6 = 1

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_5 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_7 = arg_121_1:GetWordFromCfg(413041030)
				local var_124_8 = arg_121_1:FormatText(var_124_7.content)

				arg_121_1.text_.text = var_124_8

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_10 = 40 <= 0 and var_124_6 or var_124_6 * (utf8.len(var_124_8) / 40)

				if (40 <= 0 and var_124_6 or var_124_6 * (utf8.len(var_124_8) / 40)) > 0 and var_124_6 < var_124_10 then
					arg_121_1.talkMaxDuration = var_124_10

					if var_124_10 + var_124_5 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_10 + var_124_5
					end
				end

				arg_121_1.text_.text = var_124_8
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413041", "413041030", "story_v_out_413041.awb") ~= 0 then
					local var_124_11 = manager.audio:GetVoiceLength("story_v_out_413041", "413041030", "story_v_out_413041.awb") / 1000

					if var_124_11 + var_124_5 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_11 + var_124_5
					end

					if var_124_7.prefab_name ~= "" and arg_121_1.actors_[var_124_7.prefab_name] ~= nil then
						local var_124_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_7.prefab_name].transform, "story_v_out_413041", "413041030", "story_v_out_413041.awb")

						arg_121_1:RecordAudio("413041030", var_124_12)
						arg_121_1:RecordAudio("413041030", var_124_12)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_413041", "413041030", "story_v_out_413041.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_413041", "413041030", "story_v_out_413041.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_13 = math.max(var_124_6, arg_121_1.talkMaxDuration)

			if var_124_5 <= arg_121_1.time_ and arg_121_1.time_ < var_124_5 + var_124_13 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_5) / var_124_13

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_5 + var_124_13 and arg_121_1.time_ < var_124_5 + var_124_13 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play413041031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 413041031
		arg_125_1.duration_ = 2.37

		local var_125_0 = {
			zh = 2.366,
			ja = 1.999999999999
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
				arg_125_0:Play413041032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(arg_125_1.actors_["10022"]) and arg_125_1.var_.actorSpriteComps10022 == nil then
				arg_125_1.var_.actorSpriteComps10022 = arg_125_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_128_0 = 2

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_0 and not isNil(arg_125_1.actors_["10022"]) then
				if arg_125_1.var_.actorSpriteComps10022 then
					for iter_128_0, iter_128_1 in pairs(arg_125_1.var_.actorSpriteComps10022:ToTable()) do
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

			if arg_125_1.time_ >= 0 + var_128_0 and arg_125_1.time_ < 0 + var_128_0 + arg_128_0 and not isNil(arg_125_1.actors_["10022"]) and arg_125_1.var_.actorSpriteComps10022 then
				for iter_128_2, iter_128_3 in pairs(arg_125_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_128_3 then
						iter_128_3.color = arg_125_1.isInRecall_ and (arg_125_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_125_1.var_.actorSpriteComps10022 = nil
			end

			local var_128_2 = 0
			local var_128_3 = 0.325

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_2 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[998].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, true)
				arg_125_1.iconController_:SetSelectedState("hero")

				arg_125_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightwoman1")

				arg_125_1.callingController_:SetSelectedState("normal")

				arg_125_1.keyicon_.color = Color.New(1, 1, 1)
				arg_125_1.icon_.color = Color.New(1, 1, 1)

				local var_128_4 = arg_125_1:GetWordFromCfg(413041031)
				local var_128_5 = arg_125_1:FormatText(var_128_4.content)

				arg_125_1.text_.text = var_128_5

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_7 = 13 <= 0 and var_128_3 or var_128_3 * (utf8.len(var_128_5) / 13)

				if (13 <= 0 and var_128_3 or var_128_3 * (utf8.len(var_128_5) / 13)) > 0 and var_128_3 < var_128_7 then
					arg_125_1.talkMaxDuration = var_128_7

					if var_128_7 + var_128_2 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_7 + var_128_2
					end
				end

				arg_125_1.text_.text = var_128_5
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413041", "413041031", "story_v_out_413041.awb") ~= 0 then
					local var_128_8 = manager.audio:GetVoiceLength("story_v_out_413041", "413041031", "story_v_out_413041.awb") / 1000

					if var_128_8 + var_128_2 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_8 + var_128_2
					end

					if var_128_4.prefab_name ~= "" and arg_125_1.actors_[var_128_4.prefab_name] ~= nil then
						local var_128_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_4.prefab_name].transform, "story_v_out_413041", "413041031", "story_v_out_413041.awb")

						arg_125_1:RecordAudio("413041031", var_128_9)
						arg_125_1:RecordAudio("413041031", var_128_9)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_413041", "413041031", "story_v_out_413041.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_413041", "413041031", "story_v_out_413041.awb")
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
	Play413041032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 413041032
		arg_129_1.duration_ = 7.13

		local var_129_0 = {
			zh = 6.1,
			ja = 7.133
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
				arg_129_0:Play413041033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.var_.moveOldPos10092 = arg_129_1.actors_["10092"].transform.localPosition
				arg_129_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_129_1:CheckSpriteTmpPos("10092", 4)

				for iter_132_0 = 0, arg_129_1.actors_["10092"].transform.childCount - 1 do
					local var_132_0 = arg_129_1.actors_["10092"].transform:GetChild(iter_132_0)

					if var_132_0.name == "split_5" or not string.find(var_132_0.name, "split") then
						var_132_0.gameObject:SetActive(true)
					else
						var_132_0.gameObject:SetActive(false)
					end
				end
			end

			local var_132_1 = 0.001

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_1 then
				arg_129_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos10092, Vector3.New(390, -300, -295), (arg_129_1.time_ - 0) / var_132_1)
			end

			if arg_129_1.time_ >= 0 + var_132_1 and arg_129_1.time_ < 0 + var_132_1 + arg_132_0 then
				arg_129_1.actors_["10092"].transform.localPosition = Vector3.New(390, -300, -295)
			end

			local var_132_2 = arg_129_1.actors_["10092"]

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(var_132_2) and arg_129_1.var_.actorSpriteComps10092 == nil then
				arg_129_1.var_.actorSpriteComps10092 = var_132_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_132_3 = 2

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_3 and not isNil(var_132_2) then
				if arg_129_1.var_.actorSpriteComps10092 then
					for iter_132_1, iter_132_2 in pairs(arg_129_1.var_.actorSpriteComps10092:ToTable()) do
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

			if arg_129_1.time_ >= 0 + var_132_3 and arg_129_1.time_ < 0 + var_132_3 + arg_132_0 and not isNil(var_132_2) and arg_129_1.var_.actorSpriteComps10092 then
				for iter_132_3, iter_132_4 in pairs(arg_129_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_132_4 then
						iter_132_4.color = arg_129_1.isInRecall_ and (arg_129_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_129_1.var_.actorSpriteComps10092 = nil
			end

			local var_132_5 = 0
			local var_132_6 = 0.7

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_5 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_7 = arg_129_1:GetWordFromCfg(413041032)
				local var_132_8 = arg_129_1:FormatText(var_132_7.content)

				arg_129_1.text_.text = var_132_8

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_10 = 28 <= 0 and var_132_6 or var_132_6 * (utf8.len(var_132_8) / 28)

				if (28 <= 0 and var_132_6 or var_132_6 * (utf8.len(var_132_8) / 28)) > 0 and var_132_6 < var_132_10 then
					arg_129_1.talkMaxDuration = var_132_10

					if var_132_10 + var_132_5 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_10 + var_132_5
					end
				end

				arg_129_1.text_.text = var_132_8
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413041", "413041032", "story_v_out_413041.awb") ~= 0 then
					local var_132_11 = manager.audio:GetVoiceLength("story_v_out_413041", "413041032", "story_v_out_413041.awb") / 1000

					if var_132_11 + var_132_5 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_11 + var_132_5
					end

					if var_132_7.prefab_name ~= "" and arg_129_1.actors_[var_132_7.prefab_name] ~= nil then
						local var_132_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_7.prefab_name].transform, "story_v_out_413041", "413041032", "story_v_out_413041.awb")

						arg_129_1:RecordAudio("413041032", var_132_12)
						arg_129_1:RecordAudio("413041032", var_132_12)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_413041", "413041032", "story_v_out_413041.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_413041", "413041032", "story_v_out_413041.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_13 = math.max(var_132_6, arg_129_1.talkMaxDuration)

			if var_132_5 <= arg_129_1.time_ and arg_129_1.time_ < var_132_5 + var_132_13 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_5) / var_132_13

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_5 + var_132_13 and arg_129_1.time_ < var_132_5 + var_132_13 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
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
	Play413041033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 413041033
		arg_133_1.duration_ = 8.23

		local var_133_0 = {
			zh = 6,
			ja = 8.233
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
				arg_133_0:Play413041034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = 0.875

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_1 = arg_133_1:GetWordFromCfg(413041033)
				local var_136_2 = arg_133_1:FormatText(var_136_1.content)

				arg_133_1.text_.text = var_136_2

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_4 = 35 <= 0 and var_136_0 or var_136_0 * (utf8.len(var_136_2) / 35)

				if (35 <= 0 and var_136_0 or var_136_0 * (utf8.len(var_136_2) / 35)) > 0 and var_136_0 < var_136_4 then
					arg_133_1.talkMaxDuration = var_136_4

					if var_136_4 + 0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_4 + 0
					end
				end

				arg_133_1.text_.text = var_136_2
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413041", "413041033", "story_v_out_413041.awb") ~= 0 then
					local var_136_5 = manager.audio:GetVoiceLength("story_v_out_413041", "413041033", "story_v_out_413041.awb") / 1000

					if var_136_5 + 0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_5 + 0
					end

					if var_136_1.prefab_name ~= "" and arg_133_1.actors_[var_136_1.prefab_name] ~= nil then
						local var_136_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_1.prefab_name].transform, "story_v_out_413041", "413041033", "story_v_out_413041.awb")

						arg_133_1:RecordAudio("413041033", var_136_6)
						arg_133_1:RecordAudio("413041033", var_136_6)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_413041", "413041033", "story_v_out_413041.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_413041", "413041033", "story_v_out_413041.awb")
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
	Play413041034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 413041034
		arg_137_1.duration_ = 11.77

		local var_137_0 = {
			zh = 6.733,
			ja = 11.766
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
				arg_137_0:Play413041035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = 0.9

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_1 = arg_137_1:GetWordFromCfg(413041034)
				local var_140_2 = arg_137_1:FormatText(var_140_1.content)

				arg_137_1.text_.text = var_140_2

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_4 = 36 <= 0 and var_140_0 or var_140_0 * (utf8.len(var_140_2) / 36)

				if (36 <= 0 and var_140_0 or var_140_0 * (utf8.len(var_140_2) / 36)) > 0 and var_140_0 < var_140_4 then
					arg_137_1.talkMaxDuration = var_140_4

					if var_140_4 + 0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_4 + 0
					end
				end

				arg_137_1.text_.text = var_140_2
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413041", "413041034", "story_v_out_413041.awb") ~= 0 then
					local var_140_5 = manager.audio:GetVoiceLength("story_v_out_413041", "413041034", "story_v_out_413041.awb") / 1000

					if var_140_5 + 0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_5 + 0
					end

					if var_140_1.prefab_name ~= "" and arg_137_1.actors_[var_140_1.prefab_name] ~= nil then
						local var_140_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_1.prefab_name].transform, "story_v_out_413041", "413041034", "story_v_out_413041.awb")

						arg_137_1:RecordAudio("413041034", var_140_6)
						arg_137_1:RecordAudio("413041034", var_140_6)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_413041", "413041034", "story_v_out_413041.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_413041", "413041034", "story_v_out_413041.awb")
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
	Play413041035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 413041035
		arg_141_1.duration_ = 5

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play413041036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.var_.moveOldPos10092 = arg_141_1.actors_["10092"].transform.localPosition
				arg_141_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_141_1:CheckSpriteTmpPos("10092", 0)

				for iter_144_0 = 0, arg_141_1.actors_["10092"].transform.childCount - 1 do
					local var_144_0 = arg_141_1.actors_["10092"].transform:GetChild(iter_144_0)

					if var_144_0.name == "" or not string.find(var_144_0.name, "split") then
						var_144_0.gameObject:SetActive(true)
					else
						var_144_0.gameObject:SetActive(false)
					end
				end
			end

			local var_144_1 = 0.001

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_1 then
				arg_141_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos10092, Vector3.New(0, -5000, 0), (arg_141_1.time_ - 0) / var_144_1)
			end

			if arg_141_1.time_ >= 0 + var_144_1 and arg_141_1.time_ < 0 + var_144_1 + arg_144_0 then
				arg_141_1.actors_["10092"].transform.localPosition = Vector3.New(0, -5000, 0)
			end

			local var_144_2 = arg_141_1.actors_["10092"]

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(var_144_2) and arg_141_1.var_.actorSpriteComps10092 == nil then
				arg_141_1.var_.actorSpriteComps10092 = var_144_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_144_3 = 0.034

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_3 and not isNil(var_144_2) then
				if arg_141_1.var_.actorSpriteComps10092 then
					for iter_144_1, iter_144_2 in pairs(arg_141_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_144_2 then
							if arg_141_1.isInRecall_ then
								iter_144_2.color = Color.New(Mathf.Lerp(iter_144_2.color.r, arg_141_1.hightColor2.r, (arg_141_1.time_ - 0) / var_144_3), Mathf.Lerp(iter_144_2.color.g, arg_141_1.hightColor2.g, (arg_141_1.time_ - 0) / var_144_3), (Mathf.Lerp(iter_144_2.color.b, arg_141_1.hightColor2.b, (arg_141_1.time_ - 0) / var_144_3)))
							else
								local var_144_4 = Mathf.Lerp(iter_144_2.color.r, 0.5, (arg_141_1.time_ - 0) / var_144_3)

								iter_144_2.color = Color.New(var_144_4, var_144_4, var_144_4)
							end
						end
					end
				end
			end

			if arg_141_1.time_ >= 0 + var_144_3 and arg_141_1.time_ < 0 + var_144_3 + arg_144_0 and not isNil(var_144_2) and arg_141_1.var_.actorSpriteComps10092 then
				for iter_144_3, iter_144_4 in pairs(arg_141_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_144_4 then
						iter_144_4.color = arg_141_1.isInRecall_ and (arg_141_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_141_1.var_.actorSpriteComps10092 = nil
			end

			local var_144_5 = arg_141_1.actors_["10022"].transform

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.var_.moveOldPos10022 = var_144_5.localPosition
				var_144_5.localScale = Vector3.New(1, 1, 1)

				arg_141_1:CheckSpriteTmpPos("10022", 0)

				for iter_144_5 = 0, var_144_5.childCount - 1 do
					local var_144_6 = var_144_5:GetChild(iter_144_5)

					if var_144_6.name == "" or not string.find(var_144_6.name, "split") then
						var_144_6.gameObject:SetActive(true)
					else
						var_144_6.gameObject:SetActive(false)
					end
				end
			end

			local var_144_7 = 0.001

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_7 then
				var_144_5.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos10022, Vector3.New(-1500, -350, -180), (arg_141_1.time_ - 0) / var_144_7)
			end

			if arg_141_1.time_ >= 0 + var_144_7 and arg_141_1.time_ < 0 + var_144_7 + arg_144_0 then
				var_144_5.localPosition = Vector3.New(-1500, -350, -180)
			end

			local var_144_8 = 0
			local var_144_9 = 0.775

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_8 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, false)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_10 = arg_141_1:FormatText(arg_141_1:GetWordFromCfg(413041035).content)

				arg_141_1.text_.text = var_144_10

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_12 = 31 <= 0 and var_144_9 or var_144_9 * (utf8.len(var_144_10) / 31)

				if (31 <= 0 and var_144_9 or var_144_9 * (utf8.len(var_144_10) / 31)) > 0 and var_144_9 < var_144_12 then
					arg_141_1.talkMaxDuration = var_144_12

					if var_144_12 + var_144_8 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_12 + var_144_8
					end
				end

				arg_141_1.text_.text = var_144_10
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)
				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_13 = math.max(var_144_9, arg_141_1.talkMaxDuration)

			if var_144_8 <= arg_141_1.time_ and arg_141_1.time_ < var_144_8 + var_144_13 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_8) / var_144_13

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_8 + var_144_13 and arg_141_1.time_ < var_144_8 + var_144_13 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_141_1:InitPlayNodeList()
	end,
	Play413041036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 413041036
		arg_145_1.duration_ = 3.73

		local var_145_0 = {
			zh = 3.733,
			ja = 3.7
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
				arg_145_0:Play413041037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if arg_145_1.actors_["10093"] == nil then
				local var_148_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10093")

				if not isNil(var_148_0) then
					local var_148_1 = Object.Instantiate(var_148_0, arg_145_1.canvasGo_.transform)

					var_148_1.transform:SetSiblingIndex(1)

					var_148_1.name = "10093"
					var_148_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_145_1.actors_["10093"] = var_148_1

					if arg_145_1.isInRecall_ then
						for iter_148_0, iter_148_1 in ipairs((var_148_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_148_1.color = arg_145_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_148_2 = arg_145_1.actors_["10093"].transform

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.var_.moveOldPos10093 = var_148_2.localPosition
				var_148_2.localScale = Vector3.New(1, 1, 1)

				arg_145_1:CheckSpriteTmpPos("10093", 3)

				for iter_148_2 = 0, var_148_2.childCount - 1 do
					local var_148_3 = var_148_2:GetChild(iter_148_2)

					if var_148_3.name == "split_4" or not string.find(var_148_3.name, "split") then
						var_148_3.gameObject:SetActive(true)
					else
						var_148_3.gameObject:SetActive(false)
					end
				end
			end

			local var_148_4 = 0.001

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_4 then
				var_148_2.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos10093, Vector3.New(0, -345, -245), (arg_145_1.time_ - 0) / var_148_4)
			end

			if arg_145_1.time_ >= 0 + var_148_4 and arg_145_1.time_ < 0 + var_148_4 + arg_148_0 then
				var_148_2.localPosition = Vector3.New(0, -345, -245)
			end

			local var_148_5 = arg_145_1.actors_["10093"]

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(var_148_5) and arg_145_1.var_.actorSpriteComps10093 == nil then
				arg_145_1.var_.actorSpriteComps10093 = var_148_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_148_6 = 2

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_6 and not isNil(var_148_5) then
				if arg_145_1.var_.actorSpriteComps10093 then
					for iter_148_3, iter_148_4 in pairs(arg_145_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_148_4 then
							if arg_145_1.isInRecall_ then
								iter_148_4.color = Color.New(Mathf.Lerp(iter_148_4.color.r, arg_145_1.hightColor1.r, (arg_145_1.time_ - 0) / var_148_6), Mathf.Lerp(iter_148_4.color.g, arg_145_1.hightColor1.g, (arg_145_1.time_ - 0) / var_148_6), (Mathf.Lerp(iter_148_4.color.b, arg_145_1.hightColor1.b, (arg_145_1.time_ - 0) / var_148_6)))
							else
								local var_148_7 = Mathf.Lerp(iter_148_4.color.r, 1, (arg_145_1.time_ - 0) / var_148_6)

								iter_148_4.color = Color.New(var_148_7, var_148_7, var_148_7)
							end
						end
					end
				end
			end

			if arg_145_1.time_ >= 0 + var_148_6 and arg_145_1.time_ < 0 + var_148_6 + arg_148_0 and not isNil(var_148_5) and arg_145_1.var_.actorSpriteComps10093 then
				for iter_148_5, iter_148_6 in pairs(arg_145_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_148_6 then
						iter_148_6.color = arg_145_1.isInRecall_ and (arg_145_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_145_1.var_.actorSpriteComps10093 = nil
			end

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				local var_148_8 = arg_145_1.actors_["10093"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_148_8 then
					arg_145_1.var_.alphaOldValue10093 = var_148_8.alpha
					arg_145_1.var_.characterEffect10093 = var_148_8
				end

				arg_145_1.var_.alphaOldValue10093 = 0
			end

			local var_148_9 = 0.2

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_9 then
				if arg_145_1.var_.characterEffect10093 then
					arg_145_1.var_.characterEffect10093.alpha = Mathf.Lerp(arg_145_1.var_.alphaOldValue10093, 1, (arg_145_1.time_ - 0) / var_148_9)
				end
			end

			if arg_145_1.time_ >= 0 + var_148_9 and arg_145_1.time_ < 0 + var_148_9 + arg_148_0 and arg_145_1.var_.characterEffect10093 then
				arg_145_1.var_.characterEffect10093.alpha = 1
			end

			local var_148_10 = 0
			local var_148_11 = 0.325

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_10 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_12 = arg_145_1:GetWordFromCfg(413041036)
				local var_148_13 = arg_145_1:FormatText(var_148_12.content)

				arg_145_1.text_.text = var_148_13

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_15 = 13 <= 0 and var_148_11 or var_148_11 * (utf8.len(var_148_13) / 13)

				if (13 <= 0 and var_148_11 or var_148_11 * (utf8.len(var_148_13) / 13)) > 0 and var_148_11 < var_148_15 then
					arg_145_1.talkMaxDuration = var_148_15

					if var_148_15 + var_148_10 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_15 + var_148_10
					end
				end

				arg_145_1.text_.text = var_148_13
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413041", "413041036", "story_v_out_413041.awb") ~= 0 then
					local var_148_16 = manager.audio:GetVoiceLength("story_v_out_413041", "413041036", "story_v_out_413041.awb") / 1000

					if var_148_16 + var_148_10 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_16 + var_148_10
					end

					if var_148_12.prefab_name ~= "" and arg_145_1.actors_[var_148_12.prefab_name] ~= nil then
						local var_148_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_12.prefab_name].transform, "story_v_out_413041", "413041036", "story_v_out_413041.awb")

						arg_145_1:RecordAudio("413041036", var_148_17)
						arg_145_1:RecordAudio("413041036", var_148_17)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_413041", "413041036", "story_v_out_413041.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_413041", "413041036", "story_v_out_413041.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_18 = math.max(var_148_11, arg_145_1.talkMaxDuration)

			if var_148_10 <= arg_145_1.time_ and arg_145_1.time_ < var_148_10 + var_148_18 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_10) / var_148_18

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_10 + var_148_18 and arg_145_1.time_ < var_148_10 + var_148_18 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_145_1:InitPlayNodeList()
	end,
	Play413041037 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 413041037
		arg_149_1.duration_ = 6.53

		local var_149_0 = {
			zh = 5.6,
			ja = 6.533
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
				arg_149_0:Play413041038(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.var_.moveOldPos10093 = arg_149_1.actors_["10093"].transform.localPosition
				arg_149_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_149_1:CheckSpriteTmpPos("10093", 0)

				for iter_152_0 = 0, arg_149_1.actors_["10093"].transform.childCount - 1 do
					local var_152_0 = arg_149_1.actors_["10093"].transform:GetChild(iter_152_0)

					if var_152_0.name == "" or not string.find(var_152_0.name, "split") then
						var_152_0.gameObject:SetActive(true)
					else
						var_152_0.gameObject:SetActive(false)
					end
				end
			end

			local var_152_1 = 0.001

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_1 then
				arg_149_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos10093, Vector3.New(-1500, -350, -180), (arg_149_1.time_ - 0) / var_152_1)
			end

			if arg_149_1.time_ >= 0 + var_152_1 and arg_149_1.time_ < 0 + var_152_1 + arg_152_0 then
				arg_149_1.actors_["10093"].transform.localPosition = Vector3.New(-1500, -350, -180)
			end

			local var_152_2 = arg_149_1.actors_["10092"].transform

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.var_.moveOldPos10092 = var_152_2.localPosition
				var_152_2.localScale = Vector3.New(1, 1, 1)

				arg_149_1:CheckSpriteTmpPos("10092", 3)

				for iter_152_1 = 0, var_152_2.childCount - 1 do
					local var_152_3 = var_152_2:GetChild(iter_152_1)

					if var_152_3.name == "" or not string.find(var_152_3.name, "split") then
						var_152_3.gameObject:SetActive(true)
					else
						var_152_3.gameObject:SetActive(false)
					end
				end
			end

			local var_152_4 = 0.001

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_4 then
				var_152_2.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos10092, Vector3.New(0, -300, -295), (arg_149_1.time_ - 0) / var_152_4)
			end

			if arg_149_1.time_ >= 0 + var_152_4 and arg_149_1.time_ < 0 + var_152_4 + arg_152_0 then
				var_152_2.localPosition = Vector3.New(0, -300, -295)
			end

			local var_152_5 = arg_149_1.actors_["10093"]

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(var_152_5) and arg_149_1.var_.actorSpriteComps10093 == nil then
				arg_149_1.var_.actorSpriteComps10093 = var_152_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_152_6 = 2

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_6 and not isNil(var_152_5) then
				if arg_149_1.var_.actorSpriteComps10093 then
					for iter_152_2, iter_152_3 in pairs(arg_149_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_152_3 then
							if arg_149_1.isInRecall_ then
								iter_152_3.color = Color.New(Mathf.Lerp(iter_152_3.color.r, arg_149_1.hightColor2.r, (arg_149_1.time_ - 0) / var_152_6), Mathf.Lerp(iter_152_3.color.g, arg_149_1.hightColor2.g, (arg_149_1.time_ - 0) / var_152_6), (Mathf.Lerp(iter_152_3.color.b, arg_149_1.hightColor2.b, (arg_149_1.time_ - 0) / var_152_6)))
							else
								local var_152_7 = Mathf.Lerp(iter_152_3.color.r, 0.5, (arg_149_1.time_ - 0) / var_152_6)

								iter_152_3.color = Color.New(var_152_7, var_152_7, var_152_7)
							end
						end
					end
				end
			end

			if arg_149_1.time_ >= 0 + var_152_6 and arg_149_1.time_ < 0 + var_152_6 + arg_152_0 and not isNil(var_152_5) and arg_149_1.var_.actorSpriteComps10093 then
				for iter_152_4, iter_152_5 in pairs(arg_149_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_152_5 then
						iter_152_5.color = arg_149_1.isInRecall_ and (arg_149_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_149_1.var_.actorSpriteComps10093 = nil
			end

			local var_152_8 = arg_149_1.actors_["10092"]

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(var_152_8) and arg_149_1.var_.actorSpriteComps10092 == nil then
				arg_149_1.var_.actorSpriteComps10092 = var_152_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_152_9 = 2

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_9 and not isNil(var_152_8) then
				if arg_149_1.var_.actorSpriteComps10092 then
					for iter_152_6, iter_152_7 in pairs(arg_149_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_152_7 then
							if arg_149_1.isInRecall_ then
								iter_152_7.color = Color.New(Mathf.Lerp(iter_152_7.color.r, arg_149_1.hightColor1.r, (arg_149_1.time_ - 0) / var_152_9), Mathf.Lerp(iter_152_7.color.g, arg_149_1.hightColor1.g, (arg_149_1.time_ - 0) / var_152_9), (Mathf.Lerp(iter_152_7.color.b, arg_149_1.hightColor1.b, (arg_149_1.time_ - 0) / var_152_9)))
							else
								local var_152_10 = Mathf.Lerp(iter_152_7.color.r, 1, (arg_149_1.time_ - 0) / var_152_9)

								iter_152_7.color = Color.New(var_152_10, var_152_10, var_152_10)
							end
						end
					end
				end
			end

			if arg_149_1.time_ >= 0 + var_152_9 and arg_149_1.time_ < 0 + var_152_9 + arg_152_0 and not isNil(var_152_8) and arg_149_1.var_.actorSpriteComps10092 then
				for iter_152_8, iter_152_9 in pairs(arg_149_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_152_9 then
						iter_152_9.color = arg_149_1.isInRecall_ and (arg_149_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_149_1.var_.actorSpriteComps10092 = nil
			end

			local var_152_11 = 0
			local var_152_12 = 0.675

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_11 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_13 = arg_149_1:GetWordFromCfg(413041037)
				local var_152_14 = arg_149_1:FormatText(var_152_13.content)

				arg_149_1.text_.text = var_152_14

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_16 = 26 <= 0 and var_152_12 or var_152_12 * (utf8.len(var_152_14) / 26)

				if (26 <= 0 and var_152_12 or var_152_12 * (utf8.len(var_152_14) / 26)) > 0 and var_152_12 < var_152_16 then
					arg_149_1.talkMaxDuration = var_152_16

					if var_152_16 + var_152_11 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_16 + var_152_11
					end
				end

				arg_149_1.text_.text = var_152_14
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413041", "413041037", "story_v_out_413041.awb") ~= 0 then
					local var_152_17 = manager.audio:GetVoiceLength("story_v_out_413041", "413041037", "story_v_out_413041.awb") / 1000

					if var_152_17 + var_152_11 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_17 + var_152_11
					end

					if var_152_13.prefab_name ~= "" and arg_149_1.actors_[var_152_13.prefab_name] ~= nil then
						local var_152_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_13.prefab_name].transform, "story_v_out_413041", "413041037", "story_v_out_413041.awb")

						arg_149_1:RecordAudio("413041037", var_152_18)
						arg_149_1:RecordAudio("413041037", var_152_18)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_413041", "413041037", "story_v_out_413041.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_413041", "413041037", "story_v_out_413041.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_19 = math.max(var_152_12, arg_149_1.talkMaxDuration)

			if var_152_11 <= arg_149_1.time_ and arg_149_1.time_ < var_152_11 + var_152_19 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_11) / var_152_19

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_11 + var_152_19 and arg_149_1.time_ < var_152_11 + var_152_19 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10092",
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
	Play413041038 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 413041038
		arg_153_1.duration_ = 3.93

		local var_153_0 = {
			zh = 3.5,
			ja = 3.933
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
				arg_153_0:Play413041039(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.var_.moveOldPos10022 = arg_153_1.actors_["10022"].transform.localPosition
				arg_153_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_153_1:CheckSpriteTmpPos("10022", 3)

				for iter_156_0 = 0, arg_153_1.actors_["10022"].transform.childCount - 1 do
					local var_156_0 = arg_153_1.actors_["10022"].transform:GetChild(iter_156_0)

					if var_156_0.name == "" or not string.find(var_156_0.name, "split") then
						var_156_0.gameObject:SetActive(true)
					else
						var_156_0.gameObject:SetActive(false)
					end
				end
			end

			local var_156_1 = 0.001

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_1 then
				arg_153_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos10022, Vector3.New(0, -315, -320), (arg_153_1.time_ - 0) / var_156_1)
			end

			if arg_153_1.time_ >= 0 + var_156_1 and arg_153_1.time_ < 0 + var_156_1 + arg_156_0 then
				arg_153_1.actors_["10022"].transform.localPosition = Vector3.New(0, -315, -320)
			end

			local var_156_2 = arg_153_1.actors_["10092"]

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(var_156_2) and arg_153_1.var_.actorSpriteComps10092 == nil then
				arg_153_1.var_.actorSpriteComps10092 = var_156_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_156_3 = 2

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_3 and not isNil(var_156_2) then
				if arg_153_1.var_.actorSpriteComps10092 then
					for iter_156_1, iter_156_2 in pairs(arg_153_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_156_2 then
							if arg_153_1.isInRecall_ then
								iter_156_2.color = Color.New(Mathf.Lerp(iter_156_2.color.r, arg_153_1.hightColor2.r, (arg_153_1.time_ - 0) / var_156_3), Mathf.Lerp(iter_156_2.color.g, arg_153_1.hightColor2.g, (arg_153_1.time_ - 0) / var_156_3), (Mathf.Lerp(iter_156_2.color.b, arg_153_1.hightColor2.b, (arg_153_1.time_ - 0) / var_156_3)))
							else
								local var_156_4 = Mathf.Lerp(iter_156_2.color.r, 0.5, (arg_153_1.time_ - 0) / var_156_3)

								iter_156_2.color = Color.New(var_156_4, var_156_4, var_156_4)
							end
						end
					end
				end
			end

			if arg_153_1.time_ >= 0 + var_156_3 and arg_153_1.time_ < 0 + var_156_3 + arg_156_0 and not isNil(var_156_2) and arg_153_1.var_.actorSpriteComps10092 then
				for iter_156_3, iter_156_4 in pairs(arg_153_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_156_4 then
						iter_156_4.color = arg_153_1.isInRecall_ and (arg_153_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_153_1.var_.actorSpriteComps10092 = nil
			end

			local var_156_5 = arg_153_1.actors_["10022"]

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(var_156_5) and arg_153_1.var_.actorSpriteComps10022 == nil then
				arg_153_1.var_.actorSpriteComps10022 = var_156_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_156_6 = 2

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_6 and not isNil(var_156_5) then
				if arg_153_1.var_.actorSpriteComps10022 then
					for iter_156_5, iter_156_6 in pairs(arg_153_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_156_6 then
							if arg_153_1.isInRecall_ then
								iter_156_6.color = Color.New(Mathf.Lerp(iter_156_6.color.r, arg_153_1.hightColor1.r, (arg_153_1.time_ - 0) / var_156_6), Mathf.Lerp(iter_156_6.color.g, arg_153_1.hightColor1.g, (arg_153_1.time_ - 0) / var_156_6), (Mathf.Lerp(iter_156_6.color.b, arg_153_1.hightColor1.b, (arg_153_1.time_ - 0) / var_156_6)))
							else
								local var_156_7 = Mathf.Lerp(iter_156_6.color.r, 1, (arg_153_1.time_ - 0) / var_156_6)

								iter_156_6.color = Color.New(var_156_7, var_156_7, var_156_7)
							end
						end
					end
				end
			end

			if arg_153_1.time_ >= 0 + var_156_6 and arg_153_1.time_ < 0 + var_156_6 + arg_156_0 and not isNil(var_156_5) and arg_153_1.var_.actorSpriteComps10022 then
				for iter_156_7, iter_156_8 in pairs(arg_153_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_156_8 then
						iter_156_8.color = arg_153_1.isInRecall_ and (arg_153_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_153_1.var_.actorSpriteComps10022 = nil
			end

			local var_156_8 = arg_153_1.actors_["10092"].transform

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.var_.moveOldPos10092 = var_156_8.localPosition
				var_156_8.localScale = Vector3.New(1, 1, 1)

				arg_153_1:CheckSpriteTmpPos("10092", 7)

				for iter_156_9 = 0, var_156_8.childCount - 1 do
					local var_156_9 = var_156_8:GetChild(iter_156_9)

					if var_156_9.name == "" or not string.find(var_156_9.name, "split") then
						var_156_9.gameObject:SetActive(true)
					else
						var_156_9.gameObject:SetActive(false)
					end
				end
			end

			local var_156_10 = 0.001

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_10 then
				var_156_8.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos10092, Vector3.New(0, -2000, 0), (arg_153_1.time_ - 0) / var_156_10)
			end

			if arg_153_1.time_ >= 0 + var_156_10 and arg_153_1.time_ < 0 + var_156_10 + arg_156_0 then
				var_156_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_156_11 = 0
			local var_156_12 = 0.3

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_11 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_13 = arg_153_1:GetWordFromCfg(413041038)
				local var_156_14 = arg_153_1:FormatText(var_156_13.content)

				arg_153_1.text_.text = var_156_14

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_16 = 12 <= 0 and var_156_12 or var_156_12 * (utf8.len(var_156_14) / 12)

				if (12 <= 0 and var_156_12 or var_156_12 * (utf8.len(var_156_14) / 12)) > 0 and var_156_12 < var_156_16 then
					arg_153_1.talkMaxDuration = var_156_16

					if var_156_16 + var_156_11 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_16 + var_156_11
					end
				end

				arg_153_1.text_.text = var_156_14
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413041", "413041038", "story_v_out_413041.awb") ~= 0 then
					local var_156_17 = manager.audio:GetVoiceLength("story_v_out_413041", "413041038", "story_v_out_413041.awb") / 1000

					if var_156_17 + var_156_11 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_17 + var_156_11
					end

					if var_156_13.prefab_name ~= "" and arg_153_1.actors_[var_156_13.prefab_name] ~= nil then
						local var_156_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_13.prefab_name].transform, "story_v_out_413041", "413041038", "story_v_out_413041.awb")

						arg_153_1:RecordAudio("413041038", var_156_18)
						arg_153_1:RecordAudio("413041038", var_156_18)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_413041", "413041038", "story_v_out_413041.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_413041", "413041038", "story_v_out_413041.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_19 = math.max(var_156_12, arg_153_1.talkMaxDuration)

			if var_156_11 <= arg_153_1.time_ and arg_153_1.time_ < var_156_11 + var_156_19 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_11) / var_156_19

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_11 + var_156_19 and arg_153_1.time_ < var_156_11 + var_156_19 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10092",
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
	Play413041039 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 413041039
		arg_157_1.duration_ = 2.83

		local var_157_0 = {
			zh = 2.833,
			ja = 2.6
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
				arg_157_0:Play413041040(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.var_.moveOldPos10092 = arg_157_1.actors_["10092"].transform.localPosition
				arg_157_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_157_1:CheckSpriteTmpPos("10092", 3)

				for iter_160_0 = 0, arg_157_1.actors_["10092"].transform.childCount - 1 do
					local var_160_0 = arg_157_1.actors_["10092"].transform:GetChild(iter_160_0)

					if var_160_0.name == "split_5" or not string.find(var_160_0.name, "split") then
						var_160_0.gameObject:SetActive(true)
					else
						var_160_0.gameObject:SetActive(false)
					end
				end
			end

			local var_160_1 = 0.001

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_1 then
				arg_157_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos10092, Vector3.New(0, -300, -295), (arg_157_1.time_ - 0) / var_160_1)
			end

			if arg_157_1.time_ >= 0 + var_160_1 and arg_157_1.time_ < 0 + var_160_1 + arg_160_0 then
				arg_157_1.actors_["10092"].transform.localPosition = Vector3.New(0, -300, -295)
			end

			local var_160_2 = arg_157_1.actors_["10092"]

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(var_160_2) and arg_157_1.var_.actorSpriteComps10092 == nil then
				arg_157_1.var_.actorSpriteComps10092 = var_160_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_160_3 = 2

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_3 and not isNil(var_160_2) then
				if arg_157_1.var_.actorSpriteComps10092 then
					for iter_160_1, iter_160_2 in pairs(arg_157_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_160_2 then
							if arg_157_1.isInRecall_ then
								iter_160_2.color = Color.New(Mathf.Lerp(iter_160_2.color.r, arg_157_1.hightColor1.r, (arg_157_1.time_ - 0) / var_160_3), Mathf.Lerp(iter_160_2.color.g, arg_157_1.hightColor1.g, (arg_157_1.time_ - 0) / var_160_3), (Mathf.Lerp(iter_160_2.color.b, arg_157_1.hightColor1.b, (arg_157_1.time_ - 0) / var_160_3)))
							else
								local var_160_4 = Mathf.Lerp(iter_160_2.color.r, 1, (arg_157_1.time_ - 0) / var_160_3)

								iter_160_2.color = Color.New(var_160_4, var_160_4, var_160_4)
							end
						end
					end
				end
			end

			if arg_157_1.time_ >= 0 + var_160_3 and arg_157_1.time_ < 0 + var_160_3 + arg_160_0 and not isNil(var_160_2) and arg_157_1.var_.actorSpriteComps10092 then
				for iter_160_3, iter_160_4 in pairs(arg_157_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_160_4 then
						iter_160_4.color = arg_157_1.isInRecall_ and (arg_157_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_157_1.var_.actorSpriteComps10092 = nil
			end

			local var_160_5 = arg_157_1.actors_["10022"]

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(var_160_5) and arg_157_1.var_.actorSpriteComps10022 == nil then
				arg_157_1.var_.actorSpriteComps10022 = var_160_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_160_6 = 2

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_6 and not isNil(var_160_5) then
				if arg_157_1.var_.actorSpriteComps10022 then
					for iter_160_5, iter_160_6 in pairs(arg_157_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_160_6 then
							if arg_157_1.isInRecall_ then
								iter_160_6.color = Color.New(Mathf.Lerp(iter_160_6.color.r, arg_157_1.hightColor2.r, (arg_157_1.time_ - 0) / var_160_6), Mathf.Lerp(iter_160_6.color.g, arg_157_1.hightColor2.g, (arg_157_1.time_ - 0) / var_160_6), (Mathf.Lerp(iter_160_6.color.b, arg_157_1.hightColor2.b, (arg_157_1.time_ - 0) / var_160_6)))
							else
								local var_160_7 = Mathf.Lerp(iter_160_6.color.r, 0.5, (arg_157_1.time_ - 0) / var_160_6)

								iter_160_6.color = Color.New(var_160_7, var_160_7, var_160_7)
							end
						end
					end
				end
			end

			if arg_157_1.time_ >= 0 + var_160_6 and arg_157_1.time_ < 0 + var_160_6 + arg_160_0 and not isNil(var_160_5) and arg_157_1.var_.actorSpriteComps10022 then
				for iter_160_7, iter_160_8 in pairs(arg_157_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_160_8 then
						iter_160_8.color = arg_157_1.isInRecall_ and (arg_157_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_157_1.var_.actorSpriteComps10022 = nil
			end

			local var_160_8 = 0
			local var_160_9 = 0.325

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_8 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_10 = arg_157_1:GetWordFromCfg(413041039)
				local var_160_11 = arg_157_1:FormatText(var_160_10.content)

				arg_157_1.text_.text = var_160_11

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_13 = 13 <= 0 and var_160_9 or var_160_9 * (utf8.len(var_160_11) / 13)

				if (13 <= 0 and var_160_9 or var_160_9 * (utf8.len(var_160_11) / 13)) > 0 and var_160_9 < var_160_13 then
					arg_157_1.talkMaxDuration = var_160_13

					if var_160_13 + var_160_8 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_13 + var_160_8
					end
				end

				arg_157_1.text_.text = var_160_11
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413041", "413041039", "story_v_out_413041.awb") ~= 0 then
					local var_160_14 = manager.audio:GetVoiceLength("story_v_out_413041", "413041039", "story_v_out_413041.awb") / 1000

					if var_160_14 + var_160_8 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_14 + var_160_8
					end

					if var_160_10.prefab_name ~= "" and arg_157_1.actors_[var_160_10.prefab_name] ~= nil then
						local var_160_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_10.prefab_name].transform, "story_v_out_413041", "413041039", "story_v_out_413041.awb")

						arg_157_1:RecordAudio("413041039", var_160_15)
						arg_157_1:RecordAudio("413041039", var_160_15)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_413041", "413041039", "story_v_out_413041.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_413041", "413041039", "story_v_out_413041.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_16 = math.max(var_160_9, arg_157_1.talkMaxDuration)

			if var_160_8 <= arg_157_1.time_ and arg_157_1.time_ < var_160_8 + var_160_16 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_8) / var_160_16

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_8 + var_160_16 and arg_157_1.time_ < var_160_8 + var_160_16 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
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
	Play413041040 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 413041040
		arg_161_1.duration_ = 6.3

		local var_161_0 = {
			zh = 3.633,
			ja = 6.3
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
				arg_161_0:Play413041041(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(arg_161_1.actors_["10092"]) and arg_161_1.var_.actorSpriteComps10092 == nil then
				arg_161_1.var_.actorSpriteComps10092 = arg_161_1.actors_["10092"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_164_0 = 2

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_0 and not isNil(arg_161_1.actors_["10092"]) then
				if arg_161_1.var_.actorSpriteComps10092 then
					for iter_164_0, iter_164_1 in pairs(arg_161_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_164_1 then
							if arg_161_1.isInRecall_ then
								iter_164_1.color = Color.New(Mathf.Lerp(iter_164_1.color.r, arg_161_1.hightColor2.r, (arg_161_1.time_ - 0) / var_164_0), Mathf.Lerp(iter_164_1.color.g, arg_161_1.hightColor2.g, (arg_161_1.time_ - 0) / var_164_0), (Mathf.Lerp(iter_164_1.color.b, arg_161_1.hightColor2.b, (arg_161_1.time_ - 0) / var_164_0)))
							else
								local var_164_1 = Mathf.Lerp(iter_164_1.color.r, 0.5, (arg_161_1.time_ - 0) / var_164_0)

								iter_164_1.color = Color.New(var_164_1, var_164_1, var_164_1)
							end
						end
					end
				end
			end

			if arg_161_1.time_ >= 0 + var_164_0 and arg_161_1.time_ < 0 + var_164_0 + arg_164_0 and not isNil(arg_161_1.actors_["10092"]) and arg_161_1.var_.actorSpriteComps10092 then
				for iter_164_2, iter_164_3 in pairs(arg_161_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_164_3 then
						iter_164_3.color = arg_161_1.isInRecall_ and (arg_161_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_161_1.var_.actorSpriteComps10092 = nil
			end

			local var_164_2 = arg_161_1.actors_["10022"]

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(var_164_2) and arg_161_1.var_.actorSpriteComps10022 == nil then
				arg_161_1.var_.actorSpriteComps10022 = var_164_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_164_3 = 2

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_3 and not isNil(var_164_2) then
				if arg_161_1.var_.actorSpriteComps10022 then
					for iter_164_4, iter_164_5 in pairs(arg_161_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_164_5 then
							if arg_161_1.isInRecall_ then
								iter_164_5.color = Color.New(Mathf.Lerp(iter_164_5.color.r, arg_161_1.hightColor1.r, (arg_161_1.time_ - 0) / var_164_3), Mathf.Lerp(iter_164_5.color.g, arg_161_1.hightColor1.g, (arg_161_1.time_ - 0) / var_164_3), (Mathf.Lerp(iter_164_5.color.b, arg_161_1.hightColor1.b, (arg_161_1.time_ - 0) / var_164_3)))
							else
								local var_164_4 = Mathf.Lerp(iter_164_5.color.r, 1, (arg_161_1.time_ - 0) / var_164_3)

								iter_164_5.color = Color.New(var_164_4, var_164_4, var_164_4)
							end
						end
					end
				end
			end

			if arg_161_1.time_ >= 0 + var_164_3 and arg_161_1.time_ < 0 + var_164_3 + arg_164_0 and not isNil(var_164_2) and arg_161_1.var_.actorSpriteComps10022 then
				for iter_164_6, iter_164_7 in pairs(arg_161_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_164_7 then
						iter_164_7.color = arg_161_1.isInRecall_ and (arg_161_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_161_1.var_.actorSpriteComps10022 = nil
			end

			local var_164_5 = arg_161_1.actors_["10092"].transform

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.var_.moveOldPos10092 = var_164_5.localPosition
				var_164_5.localScale = Vector3.New(1, 1, 1)

				arg_161_1:CheckSpriteTmpPos("10092", 4)

				for iter_164_8 = 0, var_164_5.childCount - 1 do
					local var_164_6 = var_164_5:GetChild(iter_164_8)

					if var_164_6.name == "split_5" or not string.find(var_164_6.name, "split") then
						var_164_6.gameObject:SetActive(true)
					else
						var_164_6.gameObject:SetActive(false)
					end
				end
			end

			local var_164_7 = 0.001

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_7 then
				var_164_5.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos10092, Vector3.New(390, -300, -295), (arg_161_1.time_ - 0) / var_164_7)
			end

			if arg_161_1.time_ >= 0 + var_164_7 and arg_161_1.time_ < 0 + var_164_7 + arg_164_0 then
				var_164_5.localPosition = Vector3.New(390, -300, -295)
			end

			local var_164_8 = arg_161_1.actors_["10022"].transform

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.var_.moveOldPos10022 = var_164_8.localPosition
				var_164_8.localScale = Vector3.New(1, 1, 1)

				arg_161_1:CheckSpriteTmpPos("10022", 2)

				for iter_164_9 = 0, var_164_8.childCount - 1 do
					local var_164_9 = var_164_8:GetChild(iter_164_9)

					if var_164_9.name == "" or not string.find(var_164_9.name, "split") then
						var_164_9.gameObject:SetActive(true)
					else
						var_164_9.gameObject:SetActive(false)
					end
				end
			end

			local var_164_10 = 0.001

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_10 then
				var_164_8.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos10022, Vector3.New(-390, -315, -320), (arg_161_1.time_ - 0) / var_164_10)
			end

			if arg_161_1.time_ >= 0 + var_164_10 and arg_161_1.time_ < 0 + var_164_10 + arg_164_0 then
				var_164_8.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_164_11 = 0
			local var_164_12 = 0.5

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_11 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_13 = arg_161_1:GetWordFromCfg(413041040)
				local var_164_14 = arg_161_1:FormatText(var_164_13.content)

				arg_161_1.text_.text = var_164_14

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_16 = 20 <= 0 and var_164_12 or var_164_12 * (utf8.len(var_164_14) / 20)

				if (20 <= 0 and var_164_12 or var_164_12 * (utf8.len(var_164_14) / 20)) > 0 and var_164_12 < var_164_16 then
					arg_161_1.talkMaxDuration = var_164_16

					if var_164_16 + var_164_11 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_16 + var_164_11
					end
				end

				arg_161_1.text_.text = var_164_14
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413041", "413041040", "story_v_out_413041.awb") ~= 0 then
					local var_164_17 = manager.audio:GetVoiceLength("story_v_out_413041", "413041040", "story_v_out_413041.awb") / 1000

					if var_164_17 + var_164_11 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_17 + var_164_11
					end

					if var_164_13.prefab_name ~= "" and arg_161_1.actors_[var_164_13.prefab_name] ~= nil then
						local var_164_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_13.prefab_name].transform, "story_v_out_413041", "413041040", "story_v_out_413041.awb")

						arg_161_1:RecordAudio("413041040", var_164_18)
						arg_161_1:RecordAudio("413041040", var_164_18)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_413041", "413041040", "story_v_out_413041.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_413041", "413041040", "story_v_out_413041.awb")
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
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10022",
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
	Play413041041 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 413041041
		arg_165_1.duration_ = 8.57

		local var_165_0 = {
			zh = 4.233,
			ja = 8.566
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
				arg_165_0:Play413041042(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = 0.55

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_1 = arg_165_1:GetWordFromCfg(413041041)
				local var_168_2 = arg_165_1:FormatText(var_168_1.content)

				arg_165_1.text_.text = var_168_2

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_4 = 22 <= 0 and var_168_0 or var_168_0 * (utf8.len(var_168_2) / 22)

				if (22 <= 0 and var_168_0 or var_168_0 * (utf8.len(var_168_2) / 22)) > 0 and var_168_0 < var_168_4 then
					arg_165_1.talkMaxDuration = var_168_4

					if var_168_4 + 0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_4 + 0
					end
				end

				arg_165_1.text_.text = var_168_2
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413041", "413041041", "story_v_out_413041.awb") ~= 0 then
					local var_168_5 = manager.audio:GetVoiceLength("story_v_out_413041", "413041041", "story_v_out_413041.awb") / 1000

					if var_168_5 + 0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_5 + 0
					end

					if var_168_1.prefab_name ~= "" and arg_165_1.actors_[var_168_1.prefab_name] ~= nil then
						local var_168_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_1.prefab_name].transform, "story_v_out_413041", "413041041", "story_v_out_413041.awb")

						arg_165_1:RecordAudio("413041041", var_168_6)
						arg_165_1:RecordAudio("413041041", var_168_6)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_413041", "413041041", "story_v_out_413041.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_413041", "413041041", "story_v_out_413041.awb")
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
	Play413041042 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 413041042
		arg_169_1.duration_ = 11.63

		local var_169_0 = {
			zh = 6.133,
			ja = 11.633
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
				arg_169_0:Play413041043(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = 0.7

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_1 = arg_169_1:GetWordFromCfg(413041042)
				local var_172_2 = arg_169_1:FormatText(var_172_1.content)

				arg_169_1.text_.text = var_172_2

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_4 = 28 <= 0 and var_172_0 or var_172_0 * (utf8.len(var_172_2) / 28)

				if (28 <= 0 and var_172_0 or var_172_0 * (utf8.len(var_172_2) / 28)) > 0 and var_172_0 < var_172_4 then
					arg_169_1.talkMaxDuration = var_172_4

					if var_172_4 + 0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_4 + 0
					end
				end

				arg_169_1.text_.text = var_172_2
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413041", "413041042", "story_v_out_413041.awb") ~= 0 then
					local var_172_5 = manager.audio:GetVoiceLength("story_v_out_413041", "413041042", "story_v_out_413041.awb") / 1000

					if var_172_5 + 0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_5 + 0
					end

					if var_172_1.prefab_name ~= "" and arg_169_1.actors_[var_172_1.prefab_name] ~= nil then
						local var_172_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_1.prefab_name].transform, "story_v_out_413041", "413041042", "story_v_out_413041.awb")

						arg_169_1:RecordAudio("413041042", var_172_6)
						arg_169_1:RecordAudio("413041042", var_172_6)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_413041", "413041042", "story_v_out_413041.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_413041", "413041042", "story_v_out_413041.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_7 = math.max(var_172_0, arg_169_1.talkMaxDuration)

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_7 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - 0) / var_172_7

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= 0 + var_172_7 and arg_169_1.time_ < 0 + var_172_7 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play413041043 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 413041043
		arg_173_1.duration_ = 5.6

		local var_173_0 = {
			zh = 5.6,
			ja = 5.033
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
				arg_173_0:Play413041044(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.var_.moveOldPos10092 = arg_173_1.actors_["10092"].transform.localPosition
				arg_173_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_173_1:CheckSpriteTmpPos("10092", 4)

				for iter_176_0 = 0, arg_173_1.actors_["10092"].transform.childCount - 1 do
					local var_176_0 = arg_173_1.actors_["10092"].transform:GetChild(iter_176_0)

					if var_176_0.name == "" or not string.find(var_176_0.name, "split") then
						var_176_0.gameObject:SetActive(true)
					else
						var_176_0.gameObject:SetActive(false)
					end
				end
			end

			local var_176_1 = 0.001

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_1 then
				arg_173_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos10092, Vector3.New(390, -300, -295), (arg_173_1.time_ - 0) / var_176_1)
			end

			if arg_173_1.time_ >= 0 + var_176_1 and arg_173_1.time_ < 0 + var_176_1 + arg_176_0 then
				arg_173_1.actors_["10092"].transform.localPosition = Vector3.New(390, -300, -295)
			end

			local var_176_2 = arg_173_1.actors_["10092"]

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(var_176_2) and arg_173_1.var_.actorSpriteComps10092 == nil then
				arg_173_1.var_.actorSpriteComps10092 = var_176_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_176_3 = 2

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_3 and not isNil(var_176_2) then
				if arg_173_1.var_.actorSpriteComps10092 then
					for iter_176_1, iter_176_2 in pairs(arg_173_1.var_.actorSpriteComps10092:ToTable()) do
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

			if arg_173_1.time_ >= 0 + var_176_3 and arg_173_1.time_ < 0 + var_176_3 + arg_176_0 and not isNil(var_176_2) and arg_173_1.var_.actorSpriteComps10092 then
				for iter_176_3, iter_176_4 in pairs(arg_173_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_176_4 then
						iter_176_4.color = arg_173_1.isInRecall_ and (arg_173_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_173_1.var_.actorSpriteComps10092 = nil
			end

			local var_176_5 = arg_173_1.actors_["10022"]

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(var_176_5) and arg_173_1.var_.actorSpriteComps10022 == nil then
				arg_173_1.var_.actorSpriteComps10022 = var_176_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_176_6 = 2

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_6 and not isNil(var_176_5) then
				if arg_173_1.var_.actorSpriteComps10022 then
					for iter_176_5, iter_176_6 in pairs(arg_173_1.var_.actorSpriteComps10022:ToTable()) do
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

			if arg_173_1.time_ >= 0 + var_176_6 and arg_173_1.time_ < 0 + var_176_6 + arg_176_0 and not isNil(var_176_5) and arg_173_1.var_.actorSpriteComps10022 then
				for iter_176_7, iter_176_8 in pairs(arg_173_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_176_8 then
						iter_176_8.color = arg_173_1.isInRecall_ and (arg_173_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_173_1.var_.actorSpriteComps10022 = nil
			end

			local var_176_8 = 0
			local var_176_9 = 0.675

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_8 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_10 = arg_173_1:GetWordFromCfg(413041043)
				local var_176_11 = arg_173_1:FormatText(var_176_10.content)

				arg_173_1.text_.text = var_176_11

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_13 = 27 <= 0 and var_176_9 or var_176_9 * (utf8.len(var_176_11) / 27)

				if (27 <= 0 and var_176_9 or var_176_9 * (utf8.len(var_176_11) / 27)) > 0 and var_176_9 < var_176_13 then
					arg_173_1.talkMaxDuration = var_176_13

					if var_176_13 + var_176_8 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_13 + var_176_8
					end
				end

				arg_173_1.text_.text = var_176_11
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413041", "413041043", "story_v_out_413041.awb") ~= 0 then
					local var_176_14 = manager.audio:GetVoiceLength("story_v_out_413041", "413041043", "story_v_out_413041.awb") / 1000

					if var_176_14 + var_176_8 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_14 + var_176_8
					end

					if var_176_10.prefab_name ~= "" and arg_173_1.actors_[var_176_10.prefab_name] ~= nil then
						local var_176_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_10.prefab_name].transform, "story_v_out_413041", "413041043", "story_v_out_413041.awb")

						arg_173_1:RecordAudio("413041043", var_176_15)
						arg_173_1:RecordAudio("413041043", var_176_15)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_413041", "413041043", "story_v_out_413041.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_413041", "413041043", "story_v_out_413041.awb")
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
				actorName = "10092",
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
	Play413041044 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 413041044
		arg_177_1.duration_ = 8.33

		local var_177_0 = {
			zh = 7.566,
			ja = 8.333
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
				arg_177_0:Play413041045(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.var_.moveOldPos10092 = arg_177_1.actors_["10092"].transform.localPosition
				arg_177_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_177_1:CheckSpriteTmpPos("10092", 0)

				for iter_180_0 = 0, arg_177_1.actors_["10092"].transform.childCount - 1 do
					local var_180_0 = arg_177_1.actors_["10092"].transform:GetChild(iter_180_0)

					if var_180_0.name == "" or not string.find(var_180_0.name, "split") then
						var_180_0.gameObject:SetActive(true)
					else
						var_180_0.gameObject:SetActive(false)
					end
				end
			end

			local var_180_1 = 0.001

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_1 then
				arg_177_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos10092, Vector3.New(0, -5000, 0), (arg_177_1.time_ - 0) / var_180_1)
			end

			if arg_177_1.time_ >= 0 + var_180_1 and arg_177_1.time_ < 0 + var_180_1 + arg_180_0 then
				arg_177_1.actors_["10092"].transform.localPosition = Vector3.New(0, -5000, 0)
			end

			local var_180_2 = arg_177_1.actors_["10022"].transform

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.var_.moveOldPos10022 = var_180_2.localPosition
				var_180_2.localScale = Vector3.New(1, 1, 1)

				arg_177_1:CheckSpriteTmpPos("10022", 0)

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
				var_180_2.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos10022, Vector3.New(-1500, -350, -180), (arg_177_1.time_ - 0) / var_180_4)
			end

			if arg_177_1.time_ >= 0 + var_180_4 and arg_177_1.time_ < 0 + var_180_4 + arg_180_0 then
				var_180_2.localPosition = Vector3.New(-1500, -350, -180)
			end

			local var_180_5 = arg_177_1.actors_["10093"].transform

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.var_.moveOldPos10093 = var_180_5.localPosition
				var_180_5.localScale = Vector3.New(1, 1, 1)

				arg_177_1:CheckSpriteTmpPos("10093", 3)

				for iter_180_2 = 0, var_180_5.childCount - 1 do
					local var_180_6 = var_180_5:GetChild(iter_180_2)

					if var_180_6.name == "" or not string.find(var_180_6.name, "split") then
						var_180_6.gameObject:SetActive(true)
					else
						var_180_6.gameObject:SetActive(false)
					end
				end
			end

			local var_180_7 = 0.001

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_7 then
				var_180_5.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos10093, Vector3.New(0, -345, -245), (arg_177_1.time_ - 0) / var_180_7)
			end

			if arg_177_1.time_ >= 0 + var_180_7 and arg_177_1.time_ < 0 + var_180_7 + arg_180_0 then
				var_180_5.localPosition = Vector3.New(0, -345, -245)
			end

			local var_180_8 = arg_177_1.actors_["10092"]

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(var_180_8) and arg_177_1.var_.actorSpriteComps10092 == nil then
				arg_177_1.var_.actorSpriteComps10092 = var_180_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_180_9 = 2

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_9 and not isNil(var_180_8) then
				if arg_177_1.var_.actorSpriteComps10092 then
					for iter_180_3, iter_180_4 in pairs(arg_177_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_180_4 then
							if arg_177_1.isInRecall_ then
								iter_180_4.color = Color.New(Mathf.Lerp(iter_180_4.color.r, arg_177_1.hightColor2.r, (arg_177_1.time_ - 0) / var_180_9), Mathf.Lerp(iter_180_4.color.g, arg_177_1.hightColor2.g, (arg_177_1.time_ - 0) / var_180_9), (Mathf.Lerp(iter_180_4.color.b, arg_177_1.hightColor2.b, (arg_177_1.time_ - 0) / var_180_9)))
							else
								local var_180_10 = Mathf.Lerp(iter_180_4.color.r, 0.5, (arg_177_1.time_ - 0) / var_180_9)

								iter_180_4.color = Color.New(var_180_10, var_180_10, var_180_10)
							end
						end
					end
				end
			end

			if arg_177_1.time_ >= 0 + var_180_9 and arg_177_1.time_ < 0 + var_180_9 + arg_180_0 and not isNil(var_180_8) and arg_177_1.var_.actorSpriteComps10092 then
				for iter_180_5, iter_180_6 in pairs(arg_177_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_180_6 then
						iter_180_6.color = arg_177_1.isInRecall_ and (arg_177_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_177_1.var_.actorSpriteComps10092 = nil
			end

			local var_180_11 = arg_177_1.actors_["10022"]

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(var_180_11) and arg_177_1.var_.actorSpriteComps10022 == nil then
				arg_177_1.var_.actorSpriteComps10022 = var_180_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_180_12 = 2

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_12 and not isNil(var_180_11) then
				if arg_177_1.var_.actorSpriteComps10022 then
					for iter_180_7, iter_180_8 in pairs(arg_177_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_180_8 then
							if arg_177_1.isInRecall_ then
								iter_180_8.color = Color.New(Mathf.Lerp(iter_180_8.color.r, arg_177_1.hightColor2.r, (arg_177_1.time_ - 0) / var_180_12), Mathf.Lerp(iter_180_8.color.g, arg_177_1.hightColor2.g, (arg_177_1.time_ - 0) / var_180_12), (Mathf.Lerp(iter_180_8.color.b, arg_177_1.hightColor2.b, (arg_177_1.time_ - 0) / var_180_12)))
							else
								local var_180_13 = Mathf.Lerp(iter_180_8.color.r, 0.5, (arg_177_1.time_ - 0) / var_180_12)

								iter_180_8.color = Color.New(var_180_13, var_180_13, var_180_13)
							end
						end
					end
				end
			end

			if arg_177_1.time_ >= 0 + var_180_12 and arg_177_1.time_ < 0 + var_180_12 + arg_180_0 and not isNil(var_180_11) and arg_177_1.var_.actorSpriteComps10022 then
				for iter_180_9, iter_180_10 in pairs(arg_177_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_180_10 then
						iter_180_10.color = arg_177_1.isInRecall_ and (arg_177_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_177_1.var_.actorSpriteComps10022 = nil
			end

			local var_180_14 = arg_177_1.actors_["10093"]

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(var_180_14) and arg_177_1.var_.actorSpriteComps10093 == nil then
				arg_177_1.var_.actorSpriteComps10093 = var_180_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_180_15 = 2

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_15 and not isNil(var_180_14) then
				if arg_177_1.var_.actorSpriteComps10093 then
					for iter_180_11, iter_180_12 in pairs(arg_177_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_180_12 then
							if arg_177_1.isInRecall_ then
								iter_180_12.color = Color.New(Mathf.Lerp(iter_180_12.color.r, arg_177_1.hightColor1.r, (arg_177_1.time_ - 0) / var_180_15), Mathf.Lerp(iter_180_12.color.g, arg_177_1.hightColor1.g, (arg_177_1.time_ - 0) / var_180_15), (Mathf.Lerp(iter_180_12.color.b, arg_177_1.hightColor1.b, (arg_177_1.time_ - 0) / var_180_15)))
							else
								local var_180_16 = Mathf.Lerp(iter_180_12.color.r, 1, (arg_177_1.time_ - 0) / var_180_15)

								iter_180_12.color = Color.New(var_180_16, var_180_16, var_180_16)
							end
						end
					end
				end
			end

			if arg_177_1.time_ >= 0 + var_180_15 and arg_177_1.time_ < 0 + var_180_15 + arg_180_0 and not isNil(var_180_14) and arg_177_1.var_.actorSpriteComps10093 then
				for iter_180_13, iter_180_14 in pairs(arg_177_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_180_14 then
						iter_180_14.color = arg_177_1.isInRecall_ and (arg_177_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_177_1.var_.actorSpriteComps10093 = nil
			end

			local var_180_17 = 0
			local var_180_18 = 0.875

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_17 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_19 = arg_177_1:GetWordFromCfg(413041044)
				local var_180_20 = arg_177_1:FormatText(var_180_19.content)

				arg_177_1.text_.text = var_180_20

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_22 = 35 <= 0 and var_180_18 or var_180_18 * (utf8.len(var_180_20) / 35)

				if (35 <= 0 and var_180_18 or var_180_18 * (utf8.len(var_180_20) / 35)) > 0 and var_180_18 < var_180_22 then
					arg_177_1.talkMaxDuration = var_180_22

					if var_180_22 + var_180_17 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_22 + var_180_17
					end
				end

				arg_177_1.text_.text = var_180_20
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413041", "413041044", "story_v_out_413041.awb") ~= 0 then
					local var_180_23 = manager.audio:GetVoiceLength("story_v_out_413041", "413041044", "story_v_out_413041.awb") / 1000

					if var_180_23 + var_180_17 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_23 + var_180_17
					end

					if var_180_19.prefab_name ~= "" and arg_177_1.actors_[var_180_19.prefab_name] ~= nil then
						local var_180_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_19.prefab_name].transform, "story_v_out_413041", "413041044", "story_v_out_413041.awb")

						arg_177_1:RecordAudio("413041044", var_180_24)
						arg_177_1:RecordAudio("413041044", var_180_24)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_413041", "413041044", "story_v_out_413041.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_413041", "413041044", "story_v_out_413041.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_25 = math.max(var_180_18, arg_177_1.talkMaxDuration)

			if var_180_17 <= arg_177_1.time_ and arg_177_1.time_ < var_180_17 + var_180_25 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_17) / var_180_25

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_17 + var_180_25 and arg_177_1.time_ < var_180_17 + var_180_25 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10093",
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
	Play413041045 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 413041045
		arg_181_1.duration_ = 3.67

		local var_181_0 = {
			zh = 1.999999999999,
			ja = 3.666
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
				arg_181_0:Play413041046(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.var_.moveOldPos10093 = arg_181_1.actors_["10093"].transform.localPosition
				arg_181_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_181_1:CheckSpriteTmpPos("10093", 0)

				for iter_184_0 = 0, arg_181_1.actors_["10093"].transform.childCount - 1 do
					local var_184_0 = arg_181_1.actors_["10093"].transform:GetChild(iter_184_0)

					if var_184_0.name == "" or not string.find(var_184_0.name, "split") then
						var_184_0.gameObject:SetActive(true)
					else
						var_184_0.gameObject:SetActive(false)
					end
				end
			end

			local var_184_1 = 0.001

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_1 then
				arg_181_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos10093, Vector3.New(-1500, -350, -180), (arg_181_1.time_ - 0) / var_184_1)
			end

			if arg_181_1.time_ >= 0 + var_184_1 and arg_181_1.time_ < 0 + var_184_1 + arg_184_0 then
				arg_181_1.actors_["10093"].transform.localPosition = Vector3.New(-1500, -350, -180)
			end

			local var_184_2 = arg_181_1.actors_["10022"].transform

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.var_.moveOldPos10022 = var_184_2.localPosition
				var_184_2.localScale = Vector3.New(1, 1, 1)

				arg_181_1:CheckSpriteTmpPos("10022", 3)

				for iter_184_1 = 0, var_184_2.childCount - 1 do
					local var_184_3 = var_184_2:GetChild(iter_184_1)

					if var_184_3.name == "split_3" or not string.find(var_184_3.name, "split") then
						var_184_3.gameObject:SetActive(true)
					else
						var_184_3.gameObject:SetActive(false)
					end
				end
			end

			local var_184_4 = 0.001

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_4 then
				var_184_2.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos10022, Vector3.New(0, -315, -320), (arg_181_1.time_ - 0) / var_184_4)
			end

			if arg_181_1.time_ >= 0 + var_184_4 and arg_181_1.time_ < 0 + var_184_4 + arg_184_0 then
				var_184_2.localPosition = Vector3.New(0, -315, -320)
			end

			local var_184_5 = arg_181_1.actors_["10093"]

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(var_184_5) and arg_181_1.var_.actorSpriteComps10093 == nil then
				arg_181_1.var_.actorSpriteComps10093 = var_184_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_184_6 = 2

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_6 and not isNil(var_184_5) then
				if arg_181_1.var_.actorSpriteComps10093 then
					for iter_184_2, iter_184_3 in pairs(arg_181_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_184_3 then
							if arg_181_1.isInRecall_ then
								iter_184_3.color = Color.New(Mathf.Lerp(iter_184_3.color.r, arg_181_1.hightColor2.r, (arg_181_1.time_ - 0) / var_184_6), Mathf.Lerp(iter_184_3.color.g, arg_181_1.hightColor2.g, (arg_181_1.time_ - 0) / var_184_6), (Mathf.Lerp(iter_184_3.color.b, arg_181_1.hightColor2.b, (arg_181_1.time_ - 0) / var_184_6)))
							else
								local var_184_7 = Mathf.Lerp(iter_184_3.color.r, 0.5, (arg_181_1.time_ - 0) / var_184_6)

								iter_184_3.color = Color.New(var_184_7, var_184_7, var_184_7)
							end
						end
					end
				end
			end

			if arg_181_1.time_ >= 0 + var_184_6 and arg_181_1.time_ < 0 + var_184_6 + arg_184_0 and not isNil(var_184_5) and arg_181_1.var_.actorSpriteComps10093 then
				for iter_184_4, iter_184_5 in pairs(arg_181_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_184_5 then
						iter_184_5.color = arg_181_1.isInRecall_ and (arg_181_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_181_1.var_.actorSpriteComps10093 = nil
			end

			local var_184_8 = arg_181_1.actors_["10022"]

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(var_184_8) and arg_181_1.var_.actorSpriteComps10022 == nil then
				arg_181_1.var_.actorSpriteComps10022 = var_184_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_184_9 = 2

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_9 and not isNil(var_184_8) then
				if arg_181_1.var_.actorSpriteComps10022 then
					for iter_184_6, iter_184_7 in pairs(arg_181_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_184_7 then
							if arg_181_1.isInRecall_ then
								iter_184_7.color = Color.New(Mathf.Lerp(iter_184_7.color.r, arg_181_1.hightColor1.r, (arg_181_1.time_ - 0) / var_184_9), Mathf.Lerp(iter_184_7.color.g, arg_181_1.hightColor1.g, (arg_181_1.time_ - 0) / var_184_9), (Mathf.Lerp(iter_184_7.color.b, arg_181_1.hightColor1.b, (arg_181_1.time_ - 0) / var_184_9)))
							else
								local var_184_10 = Mathf.Lerp(iter_184_7.color.r, 1, (arg_181_1.time_ - 0) / var_184_9)

								iter_184_7.color = Color.New(var_184_10, var_184_10, var_184_10)
							end
						end
					end
				end
			end

			if arg_181_1.time_ >= 0 + var_184_9 and arg_181_1.time_ < 0 + var_184_9 + arg_184_0 and not isNil(var_184_8) and arg_181_1.var_.actorSpriteComps10022 then
				for iter_184_8, iter_184_9 in pairs(arg_181_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_184_9 then
						iter_184_9.color = arg_181_1.isInRecall_ and (arg_181_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_181_1.var_.actorSpriteComps10022 = nil
			end

			local var_184_11 = 0
			local var_184_12 = 0.225

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_11 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_13 = arg_181_1:GetWordFromCfg(413041045)
				local var_184_14 = arg_181_1:FormatText(var_184_13.content)

				arg_181_1.text_.text = var_184_14

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_16 = 9 <= 0 and var_184_12 or var_184_12 * (utf8.len(var_184_14) / 9)

				if (9 <= 0 and var_184_12 or var_184_12 * (utf8.len(var_184_14) / 9)) > 0 and var_184_12 < var_184_16 then
					arg_181_1.talkMaxDuration = var_184_16

					if var_184_16 + var_184_11 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_16 + var_184_11
					end
				end

				arg_181_1.text_.text = var_184_14
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413041", "413041045", "story_v_out_413041.awb") ~= 0 then
					local var_184_17 = manager.audio:GetVoiceLength("story_v_out_413041", "413041045", "story_v_out_413041.awb") / 1000

					if var_184_17 + var_184_11 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_17 + var_184_11
					end

					if var_184_13.prefab_name ~= "" and arg_181_1.actors_[var_184_13.prefab_name] ~= nil then
						local var_184_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_13.prefab_name].transform, "story_v_out_413041", "413041045", "story_v_out_413041.awb")

						arg_181_1:RecordAudio("413041045", var_184_18)
						arg_181_1:RecordAudio("413041045", var_184_18)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_413041", "413041045", "story_v_out_413041.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_413041", "413041045", "story_v_out_413041.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_19 = math.max(var_184_12, arg_181_1.talkMaxDuration)

			if var_184_11 <= arg_181_1.time_ and arg_181_1.time_ < var_184_11 + var_184_19 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_11) / var_184_19

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_11 + var_184_19 and arg_181_1.time_ < var_184_11 + var_184_19 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10022",
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
	Play413041046 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 413041046
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play413041047(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.var_.moveOldPos10022 = arg_185_1.actors_["10022"].transform.localPosition
				arg_185_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_185_1:CheckSpriteTmpPos("10022", 7)

				for iter_188_0 = 0, arg_185_1.actors_["10022"].transform.childCount - 1 do
					local var_188_0 = arg_185_1.actors_["10022"].transform:GetChild(iter_188_0)

					if var_188_0.name == "" or not string.find(var_188_0.name, "split") then
						var_188_0.gameObject:SetActive(true)
					else
						var_188_0.gameObject:SetActive(false)
					end
				end
			end

			local var_188_1 = 0.001

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_1 then
				arg_185_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos10022, Vector3.New(0, -2000, -180), (arg_185_1.time_ - 0) / var_188_1)
			end

			if arg_185_1.time_ >= 0 + var_188_1 and arg_185_1.time_ < 0 + var_188_1 + arg_188_0 then
				arg_185_1.actors_["10022"].transform.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_188_2 = arg_185_1.actors_["10022"]

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 and not isNil(var_188_2) and arg_185_1.var_.actorSpriteComps10022 == nil then
				arg_185_1.var_.actorSpriteComps10022 = var_188_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_188_3 = 2

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_3 and not isNil(var_188_2) then
				if arg_185_1.var_.actorSpriteComps10022 then
					for iter_188_1, iter_188_2 in pairs(arg_185_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_188_2 then
							if arg_185_1.isInRecall_ then
								iter_188_2.color = Color.New(Mathf.Lerp(iter_188_2.color.r, arg_185_1.hightColor2.r, (arg_185_1.time_ - 0) / var_188_3), Mathf.Lerp(iter_188_2.color.g, arg_185_1.hightColor2.g, (arg_185_1.time_ - 0) / var_188_3), (Mathf.Lerp(iter_188_2.color.b, arg_185_1.hightColor2.b, (arg_185_1.time_ - 0) / var_188_3)))
							else
								local var_188_4 = Mathf.Lerp(iter_188_2.color.r, 0.5, (arg_185_1.time_ - 0) / var_188_3)

								iter_188_2.color = Color.New(var_188_4, var_188_4, var_188_4)
							end
						end
					end
				end
			end

			if arg_185_1.time_ >= 0 + var_188_3 and arg_185_1.time_ < 0 + var_188_3 + arg_188_0 and not isNil(var_188_2) and arg_185_1.var_.actorSpriteComps10022 then
				for iter_188_3, iter_188_4 in pairs(arg_185_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_188_4 then
						iter_188_4.color = arg_185_1.isInRecall_ and (arg_185_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_185_1.var_.actorSpriteComps10022 = nil
			end

			local var_188_5 = 0
			local var_188_6 = 1.075

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_5 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, false)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_7 = arg_185_1:FormatText(arg_185_1:GetWordFromCfg(413041046).content)

				arg_185_1.text_.text = var_188_7

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_9 = 43 <= 0 and var_188_6 or var_188_6 * (utf8.len(var_188_7) / 43)

				if (43 <= 0 and var_188_6 or var_188_6 * (utf8.len(var_188_7) / 43)) > 0 and var_188_6 < var_188_9 then
					arg_185_1.talkMaxDuration = var_188_9

					if var_188_9 + var_188_5 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_9 + var_188_5
					end
				end

				arg_185_1.text_.text = var_188_7
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_10 = math.max(var_188_6, arg_185_1.talkMaxDuration)

			if var_188_5 <= arg_185_1.time_ and arg_185_1.time_ < var_188_5 + var_188_10 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_5) / var_188_10

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_5 + var_188_10 and arg_185_1.time_ < var_188_5 + var_188_10 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
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
	Play413041047 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 413041047
		arg_189_1.duration_ = 12.03

		local var_189_0 = {
			zh = 6.7,
			ja = 12.033
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
				arg_189_0:Play413041048(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.var_.moveOldPos10092 = arg_189_1.actors_["10092"].transform.localPosition
				arg_189_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_189_1:CheckSpriteTmpPos("10092", 3)

				for iter_192_0 = 0, arg_189_1.actors_["10092"].transform.childCount - 1 do
					local var_192_0 = arg_189_1.actors_["10092"].transform:GetChild(iter_192_0)

					if var_192_0.name == "" or not string.find(var_192_0.name, "split") then
						var_192_0.gameObject:SetActive(true)
					else
						var_192_0.gameObject:SetActive(false)
					end
				end
			end

			local var_192_1 = 0.001

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_1 then
				arg_189_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos10092, Vector3.New(0, -300, -295), (arg_189_1.time_ - 0) / var_192_1)
			end

			if arg_189_1.time_ >= 0 + var_192_1 and arg_189_1.time_ < 0 + var_192_1 + arg_192_0 then
				arg_189_1.actors_["10092"].transform.localPosition = Vector3.New(0, -300, -295)
			end

			local var_192_2 = arg_189_1.actors_["10022"].transform

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.var_.moveOldPos10022 = var_192_2.localPosition
				var_192_2.localScale = Vector3.New(1, 1, 1)

				arg_189_1:CheckSpriteTmpPos("10022", 7)

				for iter_192_1 = 0, var_192_2.childCount - 1 do
					local var_192_3 = var_192_2:GetChild(iter_192_1)

					if var_192_3.name == "" or not string.find(var_192_3.name, "split") then
						var_192_3.gameObject:SetActive(true)
					else
						var_192_3.gameObject:SetActive(false)
					end
				end
			end

			local var_192_4 = 0.001

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_4 then
				var_192_2.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos10022, Vector3.New(0, -2000, -180), (arg_189_1.time_ - 0) / var_192_4)
			end

			if arg_189_1.time_ >= 0 + var_192_4 and arg_189_1.time_ < 0 + var_192_4 + arg_192_0 then
				var_192_2.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_192_5 = arg_189_1.actors_["10092"]

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(var_192_5) and arg_189_1.var_.actorSpriteComps10092 == nil then
				arg_189_1.var_.actorSpriteComps10092 = var_192_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_192_6 = 2

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_6 and not isNil(var_192_5) then
				if arg_189_1.var_.actorSpriteComps10092 then
					for iter_192_2, iter_192_3 in pairs(arg_189_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_192_3 then
							if arg_189_1.isInRecall_ then
								iter_192_3.color = Color.New(Mathf.Lerp(iter_192_3.color.r, arg_189_1.hightColor1.r, (arg_189_1.time_ - 0) / var_192_6), Mathf.Lerp(iter_192_3.color.g, arg_189_1.hightColor1.g, (arg_189_1.time_ - 0) / var_192_6), (Mathf.Lerp(iter_192_3.color.b, arg_189_1.hightColor1.b, (arg_189_1.time_ - 0) / var_192_6)))
							else
								local var_192_7 = Mathf.Lerp(iter_192_3.color.r, 1, (arg_189_1.time_ - 0) / var_192_6)

								iter_192_3.color = Color.New(var_192_7, var_192_7, var_192_7)
							end
						end
					end
				end
			end

			if arg_189_1.time_ >= 0 + var_192_6 and arg_189_1.time_ < 0 + var_192_6 + arg_192_0 and not isNil(var_192_5) and arg_189_1.var_.actorSpriteComps10092 then
				for iter_192_4, iter_192_5 in pairs(arg_189_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_192_5 then
						iter_192_5.color = arg_189_1.isInRecall_ and (arg_189_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_189_1.var_.actorSpriteComps10092 = nil
			end

			local var_192_8 = arg_189_1.actors_["10022"]

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(var_192_8) and arg_189_1.var_.actorSpriteComps10022 == nil then
				arg_189_1.var_.actorSpriteComps10022 = var_192_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_192_9 = 2

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_9 and not isNil(var_192_8) then
				if arg_189_1.var_.actorSpriteComps10022 then
					for iter_192_6, iter_192_7 in pairs(arg_189_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_192_7 then
							if arg_189_1.isInRecall_ then
								iter_192_7.color = Color.New(Mathf.Lerp(iter_192_7.color.r, arg_189_1.hightColor2.r, (arg_189_1.time_ - 0) / var_192_9), Mathf.Lerp(iter_192_7.color.g, arg_189_1.hightColor2.g, (arg_189_1.time_ - 0) / var_192_9), (Mathf.Lerp(iter_192_7.color.b, arg_189_1.hightColor2.b, (arg_189_1.time_ - 0) / var_192_9)))
							else
								local var_192_10 = Mathf.Lerp(iter_192_7.color.r, 0.5, (arg_189_1.time_ - 0) / var_192_9)

								iter_192_7.color = Color.New(var_192_10, var_192_10, var_192_10)
							end
						end
					end
				end
			end

			if arg_189_1.time_ >= 0 + var_192_9 and arg_189_1.time_ < 0 + var_192_9 + arg_192_0 and not isNil(var_192_8) and arg_189_1.var_.actorSpriteComps10022 then
				for iter_192_8, iter_192_9 in pairs(arg_189_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_192_9 then
						iter_192_9.color = arg_189_1.isInRecall_ and (arg_189_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_189_1.var_.actorSpriteComps10022 = nil
			end

			local var_192_11 = 0
			local var_192_12 = 0.8

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_11 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_13 = arg_189_1:GetWordFromCfg(413041047)
				local var_192_14 = arg_189_1:FormatText(var_192_13.content)

				arg_189_1.text_.text = var_192_14

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_16 = 32 <= 0 and var_192_12 or var_192_12 * (utf8.len(var_192_14) / 32)

				if (32 <= 0 and var_192_12 or var_192_12 * (utf8.len(var_192_14) / 32)) > 0 and var_192_12 < var_192_16 then
					arg_189_1.talkMaxDuration = var_192_16

					if var_192_16 + var_192_11 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_16 + var_192_11
					end
				end

				arg_189_1.text_.text = var_192_14
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413041", "413041047", "story_v_out_413041.awb") ~= 0 then
					local var_192_17 = manager.audio:GetVoiceLength("story_v_out_413041", "413041047", "story_v_out_413041.awb") / 1000

					if var_192_17 + var_192_11 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_17 + var_192_11
					end

					if var_192_13.prefab_name ~= "" and arg_189_1.actors_[var_192_13.prefab_name] ~= nil then
						local var_192_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_13.prefab_name].transform, "story_v_out_413041", "413041047", "story_v_out_413041.awb")

						arg_189_1:RecordAudio("413041047", var_192_18)
						arg_189_1:RecordAudio("413041047", var_192_18)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_413041", "413041047", "story_v_out_413041.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_413041", "413041047", "story_v_out_413041.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_19 = math.max(var_192_12, arg_189_1.talkMaxDuration)

			if var_192_11 <= arg_189_1.time_ and arg_189_1.time_ < var_192_11 + var_192_19 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_11) / var_192_19

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_11 + var_192_19 and arg_189_1.time_ < var_192_11 + var_192_19 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10022",
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
	Play413041048 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 413041048
		arg_193_1.duration_ = 7.3

		local var_193_0 = {
			zh = 7.3,
			ja = 5.9
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
				arg_193_0:Play413041049(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(arg_193_1.actors_["10092"]) and arg_193_1.var_.actorSpriteComps10092 == nil then
				arg_193_1.var_.actorSpriteComps10092 = arg_193_1.actors_["10092"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_196_0 = 2

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_0 and not isNil(arg_193_1.actors_["10092"]) then
				if arg_193_1.var_.actorSpriteComps10092 then
					for iter_196_0, iter_196_1 in pairs(arg_193_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_196_1 then
							if arg_193_1.isInRecall_ then
								iter_196_1.color = Color.New(Mathf.Lerp(iter_196_1.color.r, arg_193_1.hightColor2.r, (arg_193_1.time_ - 0) / var_196_0), Mathf.Lerp(iter_196_1.color.g, arg_193_1.hightColor2.g, (arg_193_1.time_ - 0) / var_196_0), (Mathf.Lerp(iter_196_1.color.b, arg_193_1.hightColor2.b, (arg_193_1.time_ - 0) / var_196_0)))
							else
								local var_196_1 = Mathf.Lerp(iter_196_1.color.r, 0.5, (arg_193_1.time_ - 0) / var_196_0)

								iter_196_1.color = Color.New(var_196_1, var_196_1, var_196_1)
							end
						end
					end
				end
			end

			if arg_193_1.time_ >= 0 + var_196_0 and arg_193_1.time_ < 0 + var_196_0 + arg_196_0 and not isNil(arg_193_1.actors_["10092"]) and arg_193_1.var_.actorSpriteComps10092 then
				for iter_196_2, iter_196_3 in pairs(arg_193_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_196_3 then
						iter_196_3.color = arg_193_1.isInRecall_ and (arg_193_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_193_1.var_.actorSpriteComps10092 = nil
			end

			local var_196_2 = 0
			local var_196_3 = 0.9

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_2 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[998].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, true)
				arg_193_1.iconController_:SetSelectedState("hero")

				arg_193_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightwoman1")

				arg_193_1.callingController_:SetSelectedState("normal")

				arg_193_1.keyicon_.color = Color.New(1, 1, 1)
				arg_193_1.icon_.color = Color.New(1, 1, 1)

				local var_196_4 = arg_193_1:GetWordFromCfg(413041048)
				local var_196_5 = arg_193_1:FormatText(var_196_4.content)

				arg_193_1.text_.text = var_196_5

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_7 = 36 <= 0 and var_196_3 or var_196_3 * (utf8.len(var_196_5) / 36)

				if (36 <= 0 and var_196_3 or var_196_3 * (utf8.len(var_196_5) / 36)) > 0 and var_196_3 < var_196_7 then
					arg_193_1.talkMaxDuration = var_196_7

					if var_196_7 + var_196_2 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_7 + var_196_2
					end
				end

				arg_193_1.text_.text = var_196_5
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413041", "413041048", "story_v_out_413041.awb") ~= 0 then
					local var_196_8 = manager.audio:GetVoiceLength("story_v_out_413041", "413041048", "story_v_out_413041.awb") / 1000

					if var_196_8 + var_196_2 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_8 + var_196_2
					end

					if var_196_4.prefab_name ~= "" and arg_193_1.actors_[var_196_4.prefab_name] ~= nil then
						local var_196_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_4.prefab_name].transform, "story_v_out_413041", "413041048", "story_v_out_413041.awb")

						arg_193_1:RecordAudio("413041048", var_196_9)
						arg_193_1:RecordAudio("413041048", var_196_9)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_413041", "413041048", "story_v_out_413041.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_413041", "413041048", "story_v_out_413041.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_10 = math.max(var_196_3, arg_193_1.talkMaxDuration)

			if var_196_2 <= arg_193_1.time_ and arg_193_1.time_ < var_196_2 + var_196_10 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_2) / var_196_10

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_2 + var_196_10 and arg_193_1.time_ < var_196_2 + var_196_10 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play413041049 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 413041049
		arg_197_1.duration_ = 14.67

		local var_197_0 = {
			zh = 10,
			ja = 14.666
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
				arg_197_0:Play413041050(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.var_.moveOldPos10092 = arg_197_1.actors_["10092"].transform.localPosition
				arg_197_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_197_1:CheckSpriteTmpPos("10092", 3)

				for iter_200_0 = 0, arg_197_1.actors_["10092"].transform.childCount - 1 do
					local var_200_0 = arg_197_1.actors_["10092"].transform:GetChild(iter_200_0)

					if var_200_0.name == "split_2" or not string.find(var_200_0.name, "split") then
						var_200_0.gameObject:SetActive(true)
					else
						var_200_0.gameObject:SetActive(false)
					end
				end
			end

			local var_200_1 = 0.001

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_1 then
				arg_197_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos10092, Vector3.New(0, -300, -295), (arg_197_1.time_ - 0) / var_200_1)
			end

			if arg_197_1.time_ >= 0 + var_200_1 and arg_197_1.time_ < 0 + var_200_1 + arg_200_0 then
				arg_197_1.actors_["10092"].transform.localPosition = Vector3.New(0, -300, -295)
			end

			local var_200_2 = arg_197_1.actors_["10092"]

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(var_200_2) and arg_197_1.var_.actorSpriteComps10092 == nil then
				arg_197_1.var_.actorSpriteComps10092 = var_200_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_200_3 = 2

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_3 and not isNil(var_200_2) then
				if arg_197_1.var_.actorSpriteComps10092 then
					for iter_200_1, iter_200_2 in pairs(arg_197_1.var_.actorSpriteComps10092:ToTable()) do
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

			if arg_197_1.time_ >= 0 + var_200_3 and arg_197_1.time_ < 0 + var_200_3 + arg_200_0 and not isNil(var_200_2) and arg_197_1.var_.actorSpriteComps10092 then
				for iter_200_3, iter_200_4 in pairs(arg_197_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_200_4 then
						iter_200_4.color = arg_197_1.isInRecall_ and (arg_197_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_197_1.var_.actorSpriteComps10092 = nil
			end

			local var_200_5 = 0
			local var_200_6 = 1.225

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_5 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_7 = arg_197_1:GetWordFromCfg(413041049)
				local var_200_8 = arg_197_1:FormatText(var_200_7.content)

				arg_197_1.text_.text = var_200_8

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_10 = 49 <= 0 and var_200_6 or var_200_6 * (utf8.len(var_200_8) / 49)

				if (49 <= 0 and var_200_6 or var_200_6 * (utf8.len(var_200_8) / 49)) > 0 and var_200_6 < var_200_10 then
					arg_197_1.talkMaxDuration = var_200_10

					if var_200_10 + var_200_5 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_10 + var_200_5
					end
				end

				arg_197_1.text_.text = var_200_8
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413041", "413041049", "story_v_out_413041.awb") ~= 0 then
					local var_200_11 = manager.audio:GetVoiceLength("story_v_out_413041", "413041049", "story_v_out_413041.awb") / 1000

					if var_200_11 + var_200_5 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_11 + var_200_5
					end

					if var_200_7.prefab_name ~= "" and arg_197_1.actors_[var_200_7.prefab_name] ~= nil then
						local var_200_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_7.prefab_name].transform, "story_v_out_413041", "413041049", "story_v_out_413041.awb")

						arg_197_1:RecordAudio("413041049", var_200_12)
						arg_197_1:RecordAudio("413041049", var_200_12)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_413041", "413041049", "story_v_out_413041.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_413041", "413041049", "story_v_out_413041.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_13 = math.max(var_200_6, arg_197_1.talkMaxDuration)

			if var_200_5 <= arg_197_1.time_ and arg_197_1.time_ < var_200_5 + var_200_13 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_5) / var_200_13

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_5 + var_200_13 and arg_197_1.time_ < var_200_5 + var_200_13 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
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
	Play413041050 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 413041050
		arg_201_1.duration_ = 5

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play413041051(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.var_.moveOldPos10092 = arg_201_1.actors_["10092"].transform.localPosition
				arg_201_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_201_1:CheckSpriteTmpPos("10092", 0)

				for iter_204_0 = 0, arg_201_1.actors_["10092"].transform.childCount - 1 do
					local var_204_0 = arg_201_1.actors_["10092"].transform:GetChild(iter_204_0)

					if var_204_0.name == "" or not string.find(var_204_0.name, "split") then
						var_204_0.gameObject:SetActive(true)
					else
						var_204_0.gameObject:SetActive(false)
					end
				end
			end

			local var_204_1 = 0.001

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_1 then
				arg_201_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos10092, Vector3.New(0, -5000, 0), (arg_201_1.time_ - 0) / var_204_1)
			end

			if arg_201_1.time_ >= 0 + var_204_1 and arg_201_1.time_ < 0 + var_204_1 + arg_204_0 then
				arg_201_1.actors_["10092"].transform.localPosition = Vector3.New(0, -5000, 0)
			end

			local var_204_2 = arg_201_1.actors_["10092"]

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 and not isNil(var_204_2) and arg_201_1.var_.actorSpriteComps10092 == nil then
				arg_201_1.var_.actorSpriteComps10092 = var_204_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_204_3 = 2

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_3 and not isNil(var_204_2) then
				if arg_201_1.var_.actorSpriteComps10092 then
					for iter_204_1, iter_204_2 in pairs(arg_201_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_204_2 then
							if arg_201_1.isInRecall_ then
								iter_204_2.color = Color.New(Mathf.Lerp(iter_204_2.color.r, arg_201_1.hightColor2.r, (arg_201_1.time_ - 0) / var_204_3), Mathf.Lerp(iter_204_2.color.g, arg_201_1.hightColor2.g, (arg_201_1.time_ - 0) / var_204_3), (Mathf.Lerp(iter_204_2.color.b, arg_201_1.hightColor2.b, (arg_201_1.time_ - 0) / var_204_3)))
							else
								local var_204_4 = Mathf.Lerp(iter_204_2.color.r, 0.5, (arg_201_1.time_ - 0) / var_204_3)

								iter_204_2.color = Color.New(var_204_4, var_204_4, var_204_4)
							end
						end
					end
				end
			end

			if arg_201_1.time_ >= 0 + var_204_3 and arg_201_1.time_ < 0 + var_204_3 + arg_204_0 and not isNil(var_204_2) and arg_201_1.var_.actorSpriteComps10092 then
				for iter_204_3, iter_204_4 in pairs(arg_201_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_204_4 then
						iter_204_4.color = arg_201_1.isInRecall_ and (arg_201_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_201_1.var_.actorSpriteComps10092 = nil
			end

			local var_204_5 = 0
			local var_204_6 = 1.425

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_5 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, false)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_7 = arg_201_1:FormatText(arg_201_1:GetWordFromCfg(413041050).content)

				arg_201_1.text_.text = var_204_7

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_9 = 50 <= 0 and var_204_6 or var_204_6 * (utf8.len(var_204_7) / 50)

				if (50 <= 0 and var_204_6 or var_204_6 * (utf8.len(var_204_7) / 50)) > 0 and var_204_6 < var_204_9 then
					arg_201_1.talkMaxDuration = var_204_9

					if var_204_9 + var_204_5 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_9 + var_204_5
					end
				end

				arg_201_1.text_.text = var_204_7
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)
				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_10 = math.max(var_204_6, arg_201_1.talkMaxDuration)

			if var_204_5 <= arg_201_1.time_ and arg_201_1.time_ < var_204_5 + var_204_10 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_5) / var_204_10

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_5 + var_204_10 and arg_201_1.time_ < var_204_5 + var_204_10 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
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
	Play413041051 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 413041051
		arg_205_1.duration_ = 9

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play413041052(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			if arg_205_1.bgs_.ST0602 == nil then
				local var_208_0 = Object.Instantiate(arg_205_1.paintGo_)

				var_208_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST0602")
				var_208_0.name = "ST0602"
				var_208_0.transform.parent = arg_205_1.stage_.transform
				var_208_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_205_1.bgs_.ST0602 = var_208_0
			end

			if 2 < arg_205_1.time_ and arg_205_1.time_ <= 2 + arg_208_0 then
				local var_208_1 = arg_205_1.bgs_.ST0602

				arg_205_1.bgs_.ST0602.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_208_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_208_2 = var_208_1:GetComponent("SpriteRenderer")

				if var_208_2 and var_208_2.sprite then
					local var_208_3 = 2 * (var_208_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_208_1.transform.localScale = Vector3.New(var_208_3 / var_208_2.sprite.bounds.size.y < var_208_3 * manager.ui.mainCameraCom_.aspect / var_208_2.sprite.bounds.size.x and var_208_3 * manager.ui.mainCameraCom_.aspect / var_208_2.sprite.bounds.size.x or var_208_3 / var_208_2.sprite.bounds.size.y, var_208_3 / var_208_2.sprite.bounds.size.y < var_208_3 * manager.ui.mainCameraCom_.aspect / var_208_2.sprite.bounds.size.x and var_208_3 * manager.ui.mainCameraCom_.aspect / var_208_2.sprite.bounds.size.x or var_208_3 / var_208_2.sprite.bounds.size.y, 0)
				end

				for iter_208_0, iter_208_1 in pairs(arg_205_1.bgs_) do
					if iter_208_0 ~= "ST0602" then
						iter_208_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_208_4 = 4

			if 4 < arg_205_1.time_ and arg_205_1.time_ <= var_208_4 + arg_208_0 then
				arg_205_1.allBtn_.enabled = false
			end

			if arg_205_1.time_ >= var_208_4 + 0.3 and arg_205_1.time_ < var_208_4 + 0.3 + arg_208_0 then
				arg_205_1.allBtn_.enabled = true
			end

			local var_208_5 = 0

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_5 + arg_208_0 then
				arg_205_1.mask_.enabled = true
				arg_205_1.mask_.raycastTarget = true

				arg_205_1:SetGaussion(false)
			end

			local var_208_6 = 2

			if var_208_5 <= arg_205_1.time_ and arg_205_1.time_ < var_208_5 + var_208_6 then
				local var_208_7 = Color.New(0, 0, 0)

				var_208_7.a = Mathf.Lerp(0, 1, (arg_205_1.time_ - var_208_5) / var_208_6)
				arg_205_1.mask_.color = var_208_7
			end

			if arg_205_1.time_ >= var_208_5 + var_208_6 and arg_205_1.time_ < var_208_5 + var_208_6 + arg_208_0 then
				local var_208_8 = Color.New(0, 0, 0)

				var_208_8.a = 1
				arg_205_1.mask_.color = var_208_8
			end

			local var_208_9 = 2

			if 2 < arg_205_1.time_ and arg_205_1.time_ <= var_208_9 + arg_208_0 then
				arg_205_1.mask_.enabled = true
				arg_205_1.mask_.raycastTarget = true

				arg_205_1:SetGaussion(false)
			end

			local var_208_10 = 2

			if var_208_9 <= arg_205_1.time_ and arg_205_1.time_ < var_208_9 + var_208_10 then
				local var_208_11 = Color.New(0, 0, 0)

				var_208_11.a = Mathf.Lerp(1, 0, (arg_205_1.time_ - var_208_9) / var_208_10)
				arg_205_1.mask_.color = var_208_11
			end

			if arg_205_1.time_ >= var_208_9 + var_208_10 and arg_205_1.time_ < var_208_9 + var_208_10 + arg_208_0 then
				local var_208_12 = Color.New(0, 0, 0)

				arg_205_1.mask_.enabled = false
				var_208_12.a = 0
				arg_205_1.mask_.color = var_208_12
			end

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1:AudioAction("play", "music", "bgm_activity_3_4_story_deckbridge", "bgm_activity_3_4_story_deckbridge", "bgm_activity_3_4_story_deckbridge.awb")

				local var_208_15 = manager.audio:GetAudioName("bgm_activity_3_4_story_deckbridge", "bgm_activity_3_4_story_deckbridge")

				if "" ~= "" then
					if arg_205_1.bgmTxt_.text ~= var_208_15 and arg_205_1.bgmTxt_.text ~= "" then
						if arg_205_1.bgmTxt2_.text ~= "" then
							arg_205_1.bgmTxt_.text = arg_205_1.bgmTxt2_.text
						end

						arg_205_1.bgmTxt2_.text = var_208_15

						arg_205_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_205_1.bgmTxt_.text = var_208_15
						arg_205_1.bgmTxt2_.text = var_208_15
					end

					if arg_205_1.bgmTimer then
						arg_205_1.bgmTimer:Stop()

						arg_205_1.bgmTimer = nil
					end

					if arg_205_1.settingData.show_music_name == 1 then
						arg_205_1.musicController:SetSelectedState("show")
						arg_205_1.musicAnimator_:Play("open", 0, 0)

						if arg_205_1.settingData.music_time ~= 0 then
							arg_205_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_205_1.settingData.music_time), function()
								if arg_205_1 == nil or isNil(arg_205_1.bgmTxt_) then
									return
								end

								arg_205_1.musicController:SetSelectedState("hide")
								arg_205_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_205_1.frameCnt_ <= 1 then
				arg_205_1.dialog_:SetActive(false)
			end

			local var_208_16 = 4
			local var_208_17 = 1.175

			if 4 < arg_205_1.time_ and arg_205_1.time_ <= var_208_16 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0

				arg_205_1.dialog_:SetActive(true)

				arg_205_1.dialogCg_.alpha = 0

				local var_208_18 = LeanTween.value(arg_205_1.dialog_, 0, 1, 0.3)

				var_208_18:setOnUpdate(LuaHelper.FloatAction(function(arg_210_0)
					arg_205_1.dialogCg_.alpha = arg_210_0
				end))
				var_208_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_205_1.dialog_)
					var_208_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_205_1.duration_ = arg_205_1.duration_ + 0.3

				SetActive(arg_205_1.leftNameGo_, false)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_19 = arg_205_1:FormatText(arg_205_1:GetWordFromCfg(413041051).content)

				arg_205_1.text_.text = var_208_19

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_21 = 47 <= 0 and var_208_17 or var_208_17 * (utf8.len(var_208_19) / 47)

				if (47 <= 0 and var_208_17 or var_208_17 * (utf8.len(var_208_19) / 47)) > 0 and var_208_17 < var_208_21 then
					arg_205_1.talkMaxDuration = var_208_21
					var_208_16 = var_208_16 + 0.3

					if var_208_21 + var_208_16 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_21 + var_208_16
					end
				end

				arg_205_1.text_.text = var_208_19
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)
				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_22 = var_208_16 + 0.3
			local var_208_23 = math.max(var_208_17, arg_205_1.talkMaxDuration)

			if var_208_16 + 0.3 <= arg_205_1.time_ and arg_205_1.time_ < var_208_22 + var_208_23 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_22) / var_208_23

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_22 + var_208_23 and arg_205_1.time_ < var_208_22 + var_208_23 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play413041052 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 413041052
		arg_212_1.duration_ = 4.63

		local var_212_0 = {
			zh = 4.633,
			ja = 4.266
		}
		local var_212_1 = manager.audio:GetLocalizationFlag()

		if var_212_0[var_212_1] ~= nil then
			arg_212_1.duration_ = var_212_0[var_212_1]
		end

		SetActive(arg_212_1.tipsGo_, false)

		function arg_212_1.onSingleLineFinish_()
			arg_212_1.onSingleLineUpdate_ = nil
			arg_212_1.onSingleLineFinish_ = nil
			arg_212_1.state_ = "waiting"
		end

		function arg_212_1.playNext_(arg_214_0)
			if arg_214_0 == 1 then
				arg_212_0:Play413041053(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 then
				arg_212_1.var_.moveOldPos10022 = arg_212_1.actors_["10022"].transform.localPosition
				arg_212_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_212_1:CheckSpriteTmpPos("10022", 2)

				for iter_215_0 = 0, arg_212_1.actors_["10022"].transform.childCount - 1 do
					local var_215_0 = arg_212_1.actors_["10022"].transform:GetChild(iter_215_0)

					if var_215_0.name == "" or not string.find(var_215_0.name, "split") then
						var_215_0.gameObject:SetActive(true)
					else
						var_215_0.gameObject:SetActive(false)
					end
				end
			end

			local var_215_1 = 0.001

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_1 then
				arg_212_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_212_1.var_.moveOldPos10022, Vector3.New(-390, -315, -320), (arg_212_1.time_ - 0) / var_215_1)
			end

			if arg_212_1.time_ >= 0 + var_215_1 and arg_212_1.time_ < 0 + var_215_1 + arg_215_0 then
				arg_212_1.actors_["10022"].transform.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_215_2 = arg_212_1.actors_["10022"]

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 and not isNil(var_215_2) and arg_212_1.var_.actorSpriteComps10022 == nil then
				arg_212_1.var_.actorSpriteComps10022 = var_215_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_215_3 = 2

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_3 and not isNil(var_215_2) then
				if arg_212_1.var_.actorSpriteComps10022 then
					for iter_215_1, iter_215_2 in pairs(arg_212_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_215_2 then
							if arg_212_1.isInRecall_ then
								iter_215_2.color = Color.New(Mathf.Lerp(iter_215_2.color.r, arg_212_1.hightColor1.r, (arg_212_1.time_ - 0) / var_215_3), Mathf.Lerp(iter_215_2.color.g, arg_212_1.hightColor1.g, (arg_212_1.time_ - 0) / var_215_3), (Mathf.Lerp(iter_215_2.color.b, arg_212_1.hightColor1.b, (arg_212_1.time_ - 0) / var_215_3)))
							else
								local var_215_4 = Mathf.Lerp(iter_215_2.color.r, 1, (arg_212_1.time_ - 0) / var_215_3)

								iter_215_2.color = Color.New(var_215_4, var_215_4, var_215_4)
							end
						end
					end
				end
			end

			if arg_212_1.time_ >= 0 + var_215_3 and arg_212_1.time_ < 0 + var_215_3 + arg_215_0 and not isNil(var_215_2) and arg_212_1.var_.actorSpriteComps10022 then
				for iter_215_3, iter_215_4 in pairs(arg_212_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_215_4 then
						iter_215_4.color = arg_212_1.isInRecall_ and (arg_212_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_212_1.var_.actorSpriteComps10022 = nil
			end

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 then
				local var_215_5 = arg_212_1.actors_["10022"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_215_5 then
					arg_212_1.var_.alphaOldValue10022 = var_215_5.alpha
					arg_212_1.var_.characterEffect10022 = var_215_5
				end

				arg_212_1.var_.alphaOldValue10022 = 0
			end

			local var_215_6 = 0.2

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_6 then
				if arg_212_1.var_.characterEffect10022 then
					arg_212_1.var_.characterEffect10022.alpha = Mathf.Lerp(arg_212_1.var_.alphaOldValue10022, 1, (arg_212_1.time_ - 0) / var_215_6)
				end
			end

			if arg_212_1.time_ >= 0 + var_215_6 and arg_212_1.time_ < 0 + var_215_6 + arg_215_0 and arg_212_1.var_.characterEffect10022 then
				arg_212_1.var_.characterEffect10022.alpha = 1
			end

			local var_215_7 = 0
			local var_215_8 = 0.325

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= var_215_7 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, true)

				arg_212_1.leftNameTxt_.text = arg_212_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_212_1.leftNameTxt_.transform)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1.leftNameTxt_.text)
				SetActive(arg_212_1.iconTrs_.gameObject, false)
				arg_212_1.callingController_:SetSelectedState("normal")

				local var_215_9 = arg_212_1:GetWordFromCfg(413041052)
				local var_215_10 = arg_212_1:FormatText(var_215_9.content)

				arg_212_1.text_.text = var_215_10

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_12 = 13 <= 0 and var_215_8 or var_215_8 * (utf8.len(var_215_10) / 13)

				if (13 <= 0 and var_215_8 or var_215_8 * (utf8.len(var_215_10) / 13)) > 0 and var_215_8 < var_215_12 then
					arg_212_1.talkMaxDuration = var_215_12

					if var_215_12 + var_215_7 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_12 + var_215_7
					end
				end

				arg_212_1.text_.text = var_215_10
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413041", "413041052", "story_v_out_413041.awb") ~= 0 then
					local var_215_13 = manager.audio:GetVoiceLength("story_v_out_413041", "413041052", "story_v_out_413041.awb") / 1000

					if var_215_13 + var_215_7 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_13 + var_215_7
					end

					if var_215_9.prefab_name ~= "" and arg_212_1.actors_[var_215_9.prefab_name] ~= nil then
						local var_215_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_212_1.actors_[var_215_9.prefab_name].transform, "story_v_out_413041", "413041052", "story_v_out_413041.awb")

						arg_212_1:RecordAudio("413041052", var_215_14)
						arg_212_1:RecordAudio("413041052", var_215_14)
					else
						arg_212_1:AudioAction("play", "voice", "story_v_out_413041", "413041052", "story_v_out_413041.awb")
					end

					arg_212_1:RecordHistoryTalkVoice("story_v_out_413041", "413041052", "story_v_out_413041.awb")
				end

				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_15 = math.max(var_215_8, arg_212_1.talkMaxDuration)

			if var_215_7 <= arg_212_1.time_ and arg_212_1.time_ < var_215_7 + var_215_15 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - var_215_7) / var_215_15

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= var_215_7 + var_215_15 and arg_212_1.time_ < var_215_7 + var_215_15 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_212_1:InitPlayNodeList()
	end,
	Play413041053 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 413041053
		arg_216_1.duration_ = 2.63

		local var_216_0 = {
			zh = 1.999999999999,
			ja = 2.633
		}
		local var_216_1 = manager.audio:GetLocalizationFlag()

		if var_216_0[var_216_1] ~= nil then
			arg_216_1.duration_ = var_216_0[var_216_1]
		end

		SetActive(arg_216_1.tipsGo_, false)

		function arg_216_1.onSingleLineFinish_()
			arg_216_1.onSingleLineUpdate_ = nil
			arg_216_1.onSingleLineFinish_ = nil
			arg_216_1.state_ = "waiting"
		end

		function arg_216_1.playNext_(arg_218_0)
			if arg_218_0 == 1 then
				arg_216_0:Play413041054(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 then
				arg_216_1.var_.moveOldPos10094 = arg_216_1.actors_["10094"].transform.localPosition
				arg_216_1.actors_["10094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_216_1:CheckSpriteTmpPos("10094", 4)

				for iter_219_0 = 0, arg_216_1.actors_["10094"].transform.childCount - 1 do
					local var_219_0 = arg_216_1.actors_["10094"].transform:GetChild(iter_219_0)

					if var_219_0.name == "" or not string.find(var_219_0.name, "split") then
						var_219_0.gameObject:SetActive(true)
					else
						var_219_0.gameObject:SetActive(false)
					end
				end
			end

			local var_219_1 = 0.001

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_1 then
				arg_216_1.actors_["10094"].transform.localPosition = Vector3.Lerp(arg_216_1.var_.moveOldPos10094, Vector3.New(390, -340, -414), (arg_216_1.time_ - 0) / var_219_1)
			end

			if arg_216_1.time_ >= 0 + var_219_1 and arg_216_1.time_ < 0 + var_219_1 + arg_219_0 then
				arg_216_1.actors_["10094"].transform.localPosition = Vector3.New(390, -340, -414)
			end

			local var_219_2 = arg_216_1.actors_["10094"]

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 and not isNil(var_219_2) and arg_216_1.var_.actorSpriteComps10094 == nil then
				arg_216_1.var_.actorSpriteComps10094 = var_219_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_219_3 = 2

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_3 and not isNil(var_219_2) then
				if arg_216_1.var_.actorSpriteComps10094 then
					for iter_219_1, iter_219_2 in pairs(arg_216_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_219_2 then
							if arg_216_1.isInRecall_ then
								iter_219_2.color = Color.New(Mathf.Lerp(iter_219_2.color.r, arg_216_1.hightColor1.r, (arg_216_1.time_ - 0) / var_219_3), Mathf.Lerp(iter_219_2.color.g, arg_216_1.hightColor1.g, (arg_216_1.time_ - 0) / var_219_3), (Mathf.Lerp(iter_219_2.color.b, arg_216_1.hightColor1.b, (arg_216_1.time_ - 0) / var_219_3)))
							else
								local var_219_4 = Mathf.Lerp(iter_219_2.color.r, 1, (arg_216_1.time_ - 0) / var_219_3)

								iter_219_2.color = Color.New(var_219_4, var_219_4, var_219_4)
							end
						end
					end
				end
			end

			if arg_216_1.time_ >= 0 + var_219_3 and arg_216_1.time_ < 0 + var_219_3 + arg_219_0 and not isNil(var_219_2) and arg_216_1.var_.actorSpriteComps10094 then
				for iter_219_3, iter_219_4 in pairs(arg_216_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_219_4 then
						iter_219_4.color = arg_216_1.isInRecall_ and (arg_216_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_216_1.var_.actorSpriteComps10094 = nil
			end

			local var_219_5 = arg_216_1.actors_["10022"]

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 and not isNil(var_219_5) and arg_216_1.var_.actorSpriteComps10022 == nil then
				arg_216_1.var_.actorSpriteComps10022 = var_219_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_219_6 = 2

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_6 and not isNil(var_219_5) then
				if arg_216_1.var_.actorSpriteComps10022 then
					for iter_219_5, iter_219_6 in pairs(arg_216_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_219_6 then
							if arg_216_1.isInRecall_ then
								iter_219_6.color = Color.New(Mathf.Lerp(iter_219_6.color.r, arg_216_1.hightColor2.r, (arg_216_1.time_ - 0) / var_219_6), Mathf.Lerp(iter_219_6.color.g, arg_216_1.hightColor2.g, (arg_216_1.time_ - 0) / var_219_6), (Mathf.Lerp(iter_219_6.color.b, arg_216_1.hightColor2.b, (arg_216_1.time_ - 0) / var_219_6)))
							else
								local var_219_7 = Mathf.Lerp(iter_219_6.color.r, 0.5, (arg_216_1.time_ - 0) / var_219_6)

								iter_219_6.color = Color.New(var_219_7, var_219_7, var_219_7)
							end
						end
					end
				end
			end

			if arg_216_1.time_ >= 0 + var_219_6 and arg_216_1.time_ < 0 + var_219_6 + arg_219_0 and not isNil(var_219_5) and arg_216_1.var_.actorSpriteComps10022 then
				for iter_219_7, iter_219_8 in pairs(arg_216_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_219_8 then
						iter_219_8.color = arg_216_1.isInRecall_ and (arg_216_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_216_1.var_.actorSpriteComps10022 = nil
			end

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 then
				local var_219_8 = arg_216_1.actors_["10094"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_219_8 then
					arg_216_1.var_.alphaOldValue10094 = var_219_8.alpha
					arg_216_1.var_.characterEffect10094 = var_219_8
				end

				arg_216_1.var_.alphaOldValue10094 = 0
			end

			local var_219_9 = 0.2

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_9 then
				if arg_216_1.var_.characterEffect10094 then
					arg_216_1.var_.characterEffect10094.alpha = Mathf.Lerp(arg_216_1.var_.alphaOldValue10094, 1, (arg_216_1.time_ - 0) / var_219_9)
				end
			end

			if arg_216_1.time_ >= 0 + var_219_9 and arg_216_1.time_ < 0 + var_219_9 + arg_219_0 and arg_216_1.var_.characterEffect10094 then
				arg_216_1.var_.characterEffect10094.alpha = 1
			end

			local var_219_10 = 0
			local var_219_11 = 0.175

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= var_219_10 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, true)

				arg_216_1.leftNameTxt_.text = arg_216_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_216_1.leftNameTxt_.transform)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1.leftNameTxt_.text)
				SetActive(arg_216_1.iconTrs_.gameObject, false)
				arg_216_1.callingController_:SetSelectedState("normal")

				local var_219_12 = arg_216_1:GetWordFromCfg(413041053)
				local var_219_13 = arg_216_1:FormatText(var_219_12.content)

				arg_216_1.text_.text = var_219_13

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_15 = 7 <= 0 and var_219_11 or var_219_11 * (utf8.len(var_219_13) / 7)

				if (7 <= 0 and var_219_11 or var_219_11 * (utf8.len(var_219_13) / 7)) > 0 and var_219_11 < var_219_15 then
					arg_216_1.talkMaxDuration = var_219_15

					if var_219_15 + var_219_10 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_15 + var_219_10
					end
				end

				arg_216_1.text_.text = var_219_13
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413041", "413041053", "story_v_out_413041.awb") ~= 0 then
					local var_219_16 = manager.audio:GetVoiceLength("story_v_out_413041", "413041053", "story_v_out_413041.awb") / 1000

					if var_219_16 + var_219_10 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_16 + var_219_10
					end

					if var_219_12.prefab_name ~= "" and arg_216_1.actors_[var_219_12.prefab_name] ~= nil then
						local var_219_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_216_1.actors_[var_219_12.prefab_name].transform, "story_v_out_413041", "413041053", "story_v_out_413041.awb")

						arg_216_1:RecordAudio("413041053", var_219_17)
						arg_216_1:RecordAudio("413041053", var_219_17)
					else
						arg_216_1:AudioAction("play", "voice", "story_v_out_413041", "413041053", "story_v_out_413041.awb")
					end

					arg_216_1:RecordHistoryTalkVoice("story_v_out_413041", "413041053", "story_v_out_413041.awb")
				end

				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_18 = math.max(var_219_11, arg_216_1.talkMaxDuration)

			if var_219_10 <= arg_216_1.time_ and arg_216_1.time_ < var_219_10 + var_219_18 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_10) / var_219_18

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_10 + var_219_18 and arg_216_1.time_ < var_219_10 + var_219_18 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_216_1:InitPlayNodeList()
	end,
	Play413041054 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 413041054
		arg_220_1.duration_ = 6.6

		local var_220_0 = {
			zh = 3.966,
			ja = 6.6
		}
		local var_220_1 = manager.audio:GetLocalizationFlag()

		if var_220_0[var_220_1] ~= nil then
			arg_220_1.duration_ = var_220_0[var_220_1]
		end

		SetActive(arg_220_1.tipsGo_, false)

		function arg_220_1.onSingleLineFinish_()
			arg_220_1.onSingleLineUpdate_ = nil
			arg_220_1.onSingleLineFinish_ = nil
			arg_220_1.state_ = "waiting"
		end

		function arg_220_1.playNext_(arg_222_0)
			if arg_222_0 == 1 then
				arg_220_0:Play413041055(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 and not isNil(arg_220_1.actors_["10094"]) and arg_220_1.var_.actorSpriteComps10094 == nil then
				arg_220_1.var_.actorSpriteComps10094 = arg_220_1.actors_["10094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_223_0 = 2

			if 0 <= arg_220_1.time_ and arg_220_1.time_ < 0 + var_223_0 and not isNil(arg_220_1.actors_["10094"]) then
				if arg_220_1.var_.actorSpriteComps10094 then
					for iter_223_0, iter_223_1 in pairs(arg_220_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_223_1 then
							if arg_220_1.isInRecall_ then
								iter_223_1.color = Color.New(Mathf.Lerp(iter_223_1.color.r, arg_220_1.hightColor2.r, (arg_220_1.time_ - 0) / var_223_0), Mathf.Lerp(iter_223_1.color.g, arg_220_1.hightColor2.g, (arg_220_1.time_ - 0) / var_223_0), (Mathf.Lerp(iter_223_1.color.b, arg_220_1.hightColor2.b, (arg_220_1.time_ - 0) / var_223_0)))
							else
								local var_223_1 = Mathf.Lerp(iter_223_1.color.r, 0.5, (arg_220_1.time_ - 0) / var_223_0)

								iter_223_1.color = Color.New(var_223_1, var_223_1, var_223_1)
							end
						end
					end
				end
			end

			if arg_220_1.time_ >= 0 + var_223_0 and arg_220_1.time_ < 0 + var_223_0 + arg_223_0 and not isNil(arg_220_1.actors_["10094"]) and arg_220_1.var_.actorSpriteComps10094 then
				for iter_223_2, iter_223_3 in pairs(arg_220_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_223_3 then
						iter_223_3.color = arg_220_1.isInRecall_ and (arg_220_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_220_1.var_.actorSpriteComps10094 = nil
			end

			local var_223_2 = arg_220_1.actors_["10022"]

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 and not isNil(var_223_2) and arg_220_1.var_.actorSpriteComps10022 == nil then
				arg_220_1.var_.actorSpriteComps10022 = var_223_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_223_3 = 2

			if 0 <= arg_220_1.time_ and arg_220_1.time_ < 0 + var_223_3 and not isNil(var_223_2) then
				if arg_220_1.var_.actorSpriteComps10022 then
					for iter_223_4, iter_223_5 in pairs(arg_220_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_223_5 then
							if arg_220_1.isInRecall_ then
								iter_223_5.color = Color.New(Mathf.Lerp(iter_223_5.color.r, arg_220_1.hightColor1.r, (arg_220_1.time_ - 0) / var_223_3), Mathf.Lerp(iter_223_5.color.g, arg_220_1.hightColor1.g, (arg_220_1.time_ - 0) / var_223_3), (Mathf.Lerp(iter_223_5.color.b, arg_220_1.hightColor1.b, (arg_220_1.time_ - 0) / var_223_3)))
							else
								local var_223_4 = Mathf.Lerp(iter_223_5.color.r, 1, (arg_220_1.time_ - 0) / var_223_3)

								iter_223_5.color = Color.New(var_223_4, var_223_4, var_223_4)
							end
						end
					end
				end
			end

			if arg_220_1.time_ >= 0 + var_223_3 and arg_220_1.time_ < 0 + var_223_3 + arg_223_0 and not isNil(var_223_2) and arg_220_1.var_.actorSpriteComps10022 then
				for iter_223_6, iter_223_7 in pairs(arg_220_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_223_7 then
						iter_223_7.color = arg_220_1.isInRecall_ and (arg_220_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_220_1.var_.actorSpriteComps10022 = nil
			end

			local var_223_5 = 0
			local var_223_6 = 0.55

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= var_223_5 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, true)

				arg_220_1.leftNameTxt_.text = arg_220_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_220_1.leftNameTxt_.transform)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1.leftNameTxt_.text)
				SetActive(arg_220_1.iconTrs_.gameObject, false)
				arg_220_1.callingController_:SetSelectedState("normal")

				local var_223_7 = arg_220_1:GetWordFromCfg(413041054)
				local var_223_8 = arg_220_1:FormatText(var_223_7.content)

				arg_220_1.text_.text = var_223_8

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_10 = 22 <= 0 and var_223_6 or var_223_6 * (utf8.len(var_223_8) / 22)

				if (22 <= 0 and var_223_6 or var_223_6 * (utf8.len(var_223_8) / 22)) > 0 and var_223_6 < var_223_10 then
					arg_220_1.talkMaxDuration = var_223_10

					if var_223_10 + var_223_5 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_10 + var_223_5
					end
				end

				arg_220_1.text_.text = var_223_8
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413041", "413041054", "story_v_out_413041.awb") ~= 0 then
					local var_223_11 = manager.audio:GetVoiceLength("story_v_out_413041", "413041054", "story_v_out_413041.awb") / 1000

					if var_223_11 + var_223_5 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_11 + var_223_5
					end

					if var_223_7.prefab_name ~= "" and arg_220_1.actors_[var_223_7.prefab_name] ~= nil then
						local var_223_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_220_1.actors_[var_223_7.prefab_name].transform, "story_v_out_413041", "413041054", "story_v_out_413041.awb")

						arg_220_1:RecordAudio("413041054", var_223_12)
						arg_220_1:RecordAudio("413041054", var_223_12)
					else
						arg_220_1:AudioAction("play", "voice", "story_v_out_413041", "413041054", "story_v_out_413041.awb")
					end

					arg_220_1:RecordHistoryTalkVoice("story_v_out_413041", "413041054", "story_v_out_413041.awb")
				end

				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_13 = math.max(var_223_6, arg_220_1.talkMaxDuration)

			if var_223_5 <= arg_220_1.time_ and arg_220_1.time_ < var_223_5 + var_223_13 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - var_223_5) / var_223_13

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= var_223_5 + var_223_13 and arg_220_1.time_ < var_223_5 + var_223_13 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {}

		arg_220_1:InitPlayNodeList()
	end,
	Play413041055 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 413041055
		arg_224_1.duration_ = 5.1

		local var_224_0 = {
			zh = 3.5,
			ja = 5.1
		}
		local var_224_1 = manager.audio:GetLocalizationFlag()

		if var_224_0[var_224_1] ~= nil then
			arg_224_1.duration_ = var_224_0[var_224_1]
		end

		SetActive(arg_224_1.tipsGo_, false)

		function arg_224_1.onSingleLineFinish_()
			arg_224_1.onSingleLineUpdate_ = nil
			arg_224_1.onSingleLineFinish_ = nil
			arg_224_1.state_ = "waiting"
		end

		function arg_224_1.playNext_(arg_226_0)
			if arg_226_0 == 1 then
				arg_224_0:Play413041056(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 and not isNil(arg_224_1.actors_["10094"]) and arg_224_1.var_.actorSpriteComps10094 == nil then
				arg_224_1.var_.actorSpriteComps10094 = arg_224_1.actors_["10094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_227_0 = 2

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_0 and not isNil(arg_224_1.actors_["10094"]) then
				if arg_224_1.var_.actorSpriteComps10094 then
					for iter_227_0, iter_227_1 in pairs(arg_224_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_227_1 then
							if arg_224_1.isInRecall_ then
								iter_227_1.color = Color.New(Mathf.Lerp(iter_227_1.color.r, arg_224_1.hightColor1.r, (arg_224_1.time_ - 0) / var_227_0), Mathf.Lerp(iter_227_1.color.g, arg_224_1.hightColor1.g, (arg_224_1.time_ - 0) / var_227_0), (Mathf.Lerp(iter_227_1.color.b, arg_224_1.hightColor1.b, (arg_224_1.time_ - 0) / var_227_0)))
							else
								local var_227_1 = Mathf.Lerp(iter_227_1.color.r, 1, (arg_224_1.time_ - 0) / var_227_0)

								iter_227_1.color = Color.New(var_227_1, var_227_1, var_227_1)
							end
						end
					end
				end
			end

			if arg_224_1.time_ >= 0 + var_227_0 and arg_224_1.time_ < 0 + var_227_0 + arg_227_0 and not isNil(arg_224_1.actors_["10094"]) and arg_224_1.var_.actorSpriteComps10094 then
				for iter_227_2, iter_227_3 in pairs(arg_224_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_227_3 then
						iter_227_3.color = arg_224_1.isInRecall_ and (arg_224_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_224_1.var_.actorSpriteComps10094 = nil
			end

			local var_227_2 = arg_224_1.actors_["10022"]

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 and not isNil(var_227_2) and arg_224_1.var_.actorSpriteComps10022 == nil then
				arg_224_1.var_.actorSpriteComps10022 = var_227_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_227_3 = 2

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_3 and not isNil(var_227_2) then
				if arg_224_1.var_.actorSpriteComps10022 then
					for iter_227_4, iter_227_5 in pairs(arg_224_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_227_5 then
							if arg_224_1.isInRecall_ then
								iter_227_5.color = Color.New(Mathf.Lerp(iter_227_5.color.r, arg_224_1.hightColor2.r, (arg_224_1.time_ - 0) / var_227_3), Mathf.Lerp(iter_227_5.color.g, arg_224_1.hightColor2.g, (arg_224_1.time_ - 0) / var_227_3), (Mathf.Lerp(iter_227_5.color.b, arg_224_1.hightColor2.b, (arg_224_1.time_ - 0) / var_227_3)))
							else
								local var_227_4 = Mathf.Lerp(iter_227_5.color.r, 0.5, (arg_224_1.time_ - 0) / var_227_3)

								iter_227_5.color = Color.New(var_227_4, var_227_4, var_227_4)
							end
						end
					end
				end
			end

			if arg_224_1.time_ >= 0 + var_227_3 and arg_224_1.time_ < 0 + var_227_3 + arg_227_0 and not isNil(var_227_2) and arg_224_1.var_.actorSpriteComps10022 then
				for iter_227_6, iter_227_7 in pairs(arg_224_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_227_7 then
						iter_227_7.color = arg_224_1.isInRecall_ and (arg_224_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_224_1.var_.actorSpriteComps10022 = nil
			end

			local var_227_5 = 0
			local var_227_6 = 0.4

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= var_227_5 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, true)

				arg_224_1.leftNameTxt_.text = arg_224_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_224_1.leftNameTxt_.transform)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1.leftNameTxt_.text)
				SetActive(arg_224_1.iconTrs_.gameObject, false)
				arg_224_1.callingController_:SetSelectedState("normal")

				local var_227_7 = arg_224_1:GetWordFromCfg(413041055)
				local var_227_8 = arg_224_1:FormatText(var_227_7.content)

				arg_224_1.text_.text = var_227_8

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_10 = 16 <= 0 and var_227_6 or var_227_6 * (utf8.len(var_227_8) / 16)

				if (16 <= 0 and var_227_6 or var_227_6 * (utf8.len(var_227_8) / 16)) > 0 and var_227_6 < var_227_10 then
					arg_224_1.talkMaxDuration = var_227_10

					if var_227_10 + var_227_5 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_10 + var_227_5
					end
				end

				arg_224_1.text_.text = var_227_8
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413041", "413041055", "story_v_out_413041.awb") ~= 0 then
					local var_227_11 = manager.audio:GetVoiceLength("story_v_out_413041", "413041055", "story_v_out_413041.awb") / 1000

					if var_227_11 + var_227_5 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_11 + var_227_5
					end

					if var_227_7.prefab_name ~= "" and arg_224_1.actors_[var_227_7.prefab_name] ~= nil then
						local var_227_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_224_1.actors_[var_227_7.prefab_name].transform, "story_v_out_413041", "413041055", "story_v_out_413041.awb")

						arg_224_1:RecordAudio("413041055", var_227_12)
						arg_224_1:RecordAudio("413041055", var_227_12)
					else
						arg_224_1:AudioAction("play", "voice", "story_v_out_413041", "413041055", "story_v_out_413041.awb")
					end

					arg_224_1:RecordHistoryTalkVoice("story_v_out_413041", "413041055", "story_v_out_413041.awb")
				end

				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_13 = math.max(var_227_6, arg_224_1.talkMaxDuration)

			if var_227_5 <= arg_224_1.time_ and arg_224_1.time_ < var_227_5 + var_227_13 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - var_227_5) / var_227_13

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= var_227_5 + var_227_13 and arg_224_1.time_ < var_227_5 + var_227_13 + arg_227_0 then
				arg_224_1.typewritter.percent = 1

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(true)
			end
		end

		arg_224_1.nodeConfigList_ = {}

		arg_224_1:InitPlayNodeList()
	end,
	Play413041056 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 413041056
		arg_228_1.duration_ = 8.83

		local var_228_0 = {
			zh = 6.833,
			ja = 8.833
		}
		local var_228_1 = manager.audio:GetLocalizationFlag()

		if var_228_0[var_228_1] ~= nil then
			arg_228_1.duration_ = var_228_0[var_228_1]
		end

		SetActive(arg_228_1.tipsGo_, false)

		function arg_228_1.onSingleLineFinish_()
			arg_228_1.onSingleLineUpdate_ = nil
			arg_228_1.onSingleLineFinish_ = nil
			arg_228_1.state_ = "waiting"
		end

		function arg_228_1.playNext_(arg_230_0)
			if arg_230_0 == 1 then
				arg_228_0:Play413041057(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 and not isNil(arg_228_1.actors_["10094"]) and arg_228_1.var_.actorSpriteComps10094 == nil then
				arg_228_1.var_.actorSpriteComps10094 = arg_228_1.actors_["10094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_231_0 = 2

			if 0 <= arg_228_1.time_ and arg_228_1.time_ < 0 + var_231_0 and not isNil(arg_228_1.actors_["10094"]) then
				if arg_228_1.var_.actorSpriteComps10094 then
					for iter_231_0, iter_231_1 in pairs(arg_228_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_231_1 then
							if arg_228_1.isInRecall_ then
								iter_231_1.color = Color.New(Mathf.Lerp(iter_231_1.color.r, arg_228_1.hightColor2.r, (arg_228_1.time_ - 0) / var_231_0), Mathf.Lerp(iter_231_1.color.g, arg_228_1.hightColor2.g, (arg_228_1.time_ - 0) / var_231_0), (Mathf.Lerp(iter_231_1.color.b, arg_228_1.hightColor2.b, (arg_228_1.time_ - 0) / var_231_0)))
							else
								local var_231_1 = Mathf.Lerp(iter_231_1.color.r, 0.5, (arg_228_1.time_ - 0) / var_231_0)

								iter_231_1.color = Color.New(var_231_1, var_231_1, var_231_1)
							end
						end
					end
				end
			end

			if arg_228_1.time_ >= 0 + var_231_0 and arg_228_1.time_ < 0 + var_231_0 + arg_231_0 and not isNil(arg_228_1.actors_["10094"]) and arg_228_1.var_.actorSpriteComps10094 then
				for iter_231_2, iter_231_3 in pairs(arg_228_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_231_3 then
						iter_231_3.color = arg_228_1.isInRecall_ and (arg_228_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_228_1.var_.actorSpriteComps10094 = nil
			end

			local var_231_2 = arg_228_1.actors_["10022"]

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 and not isNil(var_231_2) and arg_228_1.var_.actorSpriteComps10022 == nil then
				arg_228_1.var_.actorSpriteComps10022 = var_231_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_231_3 = 2

			if 0 <= arg_228_1.time_ and arg_228_1.time_ < 0 + var_231_3 and not isNil(var_231_2) then
				if arg_228_1.var_.actorSpriteComps10022 then
					for iter_231_4, iter_231_5 in pairs(arg_228_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_231_5 then
							if arg_228_1.isInRecall_ then
								iter_231_5.color = Color.New(Mathf.Lerp(iter_231_5.color.r, arg_228_1.hightColor1.r, (arg_228_1.time_ - 0) / var_231_3), Mathf.Lerp(iter_231_5.color.g, arg_228_1.hightColor1.g, (arg_228_1.time_ - 0) / var_231_3), (Mathf.Lerp(iter_231_5.color.b, arg_228_1.hightColor1.b, (arg_228_1.time_ - 0) / var_231_3)))
							else
								local var_231_4 = Mathf.Lerp(iter_231_5.color.r, 1, (arg_228_1.time_ - 0) / var_231_3)

								iter_231_5.color = Color.New(var_231_4, var_231_4, var_231_4)
							end
						end
					end
				end
			end

			if arg_228_1.time_ >= 0 + var_231_3 and arg_228_1.time_ < 0 + var_231_3 + arg_231_0 and not isNil(var_231_2) and arg_228_1.var_.actorSpriteComps10022 then
				for iter_231_6, iter_231_7 in pairs(arg_228_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_231_7 then
						iter_231_7.color = arg_228_1.isInRecall_ and (arg_228_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_228_1.var_.actorSpriteComps10022 = nil
			end

			local var_231_5 = 0
			local var_231_6 = 0.9

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= var_231_5 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, true)

				arg_228_1.leftNameTxt_.text = arg_228_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_228_1.leftNameTxt_.transform)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1.leftNameTxt_.text)
				SetActive(arg_228_1.iconTrs_.gameObject, false)
				arg_228_1.callingController_:SetSelectedState("normal")

				local var_231_7 = arg_228_1:GetWordFromCfg(413041056)
				local var_231_8 = arg_228_1:FormatText(var_231_7.content)

				arg_228_1.text_.text = var_231_8

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_10 = 36 <= 0 and var_231_6 or var_231_6 * (utf8.len(var_231_8) / 36)

				if (36 <= 0 and var_231_6 or var_231_6 * (utf8.len(var_231_8) / 36)) > 0 and var_231_6 < var_231_10 then
					arg_228_1.talkMaxDuration = var_231_10

					if var_231_10 + var_231_5 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_10 + var_231_5
					end
				end

				arg_228_1.text_.text = var_231_8
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413041", "413041056", "story_v_out_413041.awb") ~= 0 then
					local var_231_11 = manager.audio:GetVoiceLength("story_v_out_413041", "413041056", "story_v_out_413041.awb") / 1000

					if var_231_11 + var_231_5 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_11 + var_231_5
					end

					if var_231_7.prefab_name ~= "" and arg_228_1.actors_[var_231_7.prefab_name] ~= nil then
						local var_231_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_228_1.actors_[var_231_7.prefab_name].transform, "story_v_out_413041", "413041056", "story_v_out_413041.awb")

						arg_228_1:RecordAudio("413041056", var_231_12)
						arg_228_1:RecordAudio("413041056", var_231_12)
					else
						arg_228_1:AudioAction("play", "voice", "story_v_out_413041", "413041056", "story_v_out_413041.awb")
					end

					arg_228_1:RecordHistoryTalkVoice("story_v_out_413041", "413041056", "story_v_out_413041.awb")
				end

				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_13 = math.max(var_231_6, arg_228_1.talkMaxDuration)

			if var_231_5 <= arg_228_1.time_ and arg_228_1.time_ < var_231_5 + var_231_13 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - var_231_5) / var_231_13

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= var_231_5 + var_231_13 and arg_228_1.time_ < var_231_5 + var_231_13 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {}

		arg_228_1:InitPlayNodeList()
	end,
	Play413041057 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 413041057
		arg_232_1.duration_ = 11.1

		local var_232_0 = {
			zh = 8.6,
			ja = 11.1
		}
		local var_232_1 = manager.audio:GetLocalizationFlag()

		if var_232_0[var_232_1] ~= nil then
			arg_232_1.duration_ = var_232_0[var_232_1]
		end

		SetActive(arg_232_1.tipsGo_, false)

		function arg_232_1.onSingleLineFinish_()
			arg_232_1.onSingleLineUpdate_ = nil
			arg_232_1.onSingleLineFinish_ = nil
			arg_232_1.state_ = "waiting"
		end

		function arg_232_1.playNext_(arg_234_0)
			if arg_234_0 == 1 then
				arg_232_0:Play413041058(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			local var_235_0 = 0.875

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, true)

				arg_232_1.leftNameTxt_.text = arg_232_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_232_1.leftNameTxt_.transform)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1.leftNameTxt_.text)
				SetActive(arg_232_1.iconTrs_.gameObject, false)
				arg_232_1.callingController_:SetSelectedState("normal")

				local var_235_1 = arg_232_1:GetWordFromCfg(413041057)
				local var_235_2 = arg_232_1:FormatText(var_235_1.content)

				arg_232_1.text_.text = var_235_2

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_4 = 35 <= 0 and var_235_0 or var_235_0 * (utf8.len(var_235_2) / 35)

				if (35 <= 0 and var_235_0 or var_235_0 * (utf8.len(var_235_2) / 35)) > 0 and var_235_0 < var_235_4 then
					arg_232_1.talkMaxDuration = var_235_4

					if var_235_4 + 0 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_4 + 0
					end
				end

				arg_232_1.text_.text = var_235_2
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413041", "413041057", "story_v_out_413041.awb") ~= 0 then
					local var_235_5 = manager.audio:GetVoiceLength("story_v_out_413041", "413041057", "story_v_out_413041.awb") / 1000

					if var_235_5 + 0 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_5 + 0
					end

					if var_235_1.prefab_name ~= "" and arg_232_1.actors_[var_235_1.prefab_name] ~= nil then
						local var_235_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_232_1.actors_[var_235_1.prefab_name].transform, "story_v_out_413041", "413041057", "story_v_out_413041.awb")

						arg_232_1:RecordAudio("413041057", var_235_6)
						arg_232_1:RecordAudio("413041057", var_235_6)
					else
						arg_232_1:AudioAction("play", "voice", "story_v_out_413041", "413041057", "story_v_out_413041.awb")
					end

					arg_232_1:RecordHistoryTalkVoice("story_v_out_413041", "413041057", "story_v_out_413041.awb")
				end

				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_7 = math.max(var_235_0, arg_232_1.talkMaxDuration)

			if 0 <= arg_232_1.time_ and arg_232_1.time_ < 0 + var_235_7 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - 0) / var_235_7

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= 0 + var_235_7 and arg_232_1.time_ < 0 + var_235_7 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {}

		arg_232_1:InitPlayNodeList()
	end,
	Play413041058 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 413041058
		arg_236_1.duration_ = 5.77

		local var_236_0 = {
			zh = 4.1,
			ja = 5.766
		}
		local var_236_1 = manager.audio:GetLocalizationFlag()

		if var_236_0[var_236_1] ~= nil then
			arg_236_1.duration_ = var_236_0[var_236_1]
		end

		SetActive(arg_236_1.tipsGo_, false)

		function arg_236_1.onSingleLineFinish_()
			arg_236_1.onSingleLineUpdate_ = nil
			arg_236_1.onSingleLineFinish_ = nil
			arg_236_1.state_ = "waiting"
		end

		function arg_236_1.playNext_(arg_238_0)
			if arg_238_0 == 1 then
				arg_236_0:Play413041059(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 and not isNil(arg_236_1.actors_["10094"]) and arg_236_1.var_.actorSpriteComps10094 == nil then
				arg_236_1.var_.actorSpriteComps10094 = arg_236_1.actors_["10094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_239_0 = 2

			if 0 <= arg_236_1.time_ and arg_236_1.time_ < 0 + var_239_0 and not isNil(arg_236_1.actors_["10094"]) then
				if arg_236_1.var_.actorSpriteComps10094 then
					for iter_239_0, iter_239_1 in pairs(arg_236_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_239_1 then
							if arg_236_1.isInRecall_ then
								iter_239_1.color = Color.New(Mathf.Lerp(iter_239_1.color.r, arg_236_1.hightColor1.r, (arg_236_1.time_ - 0) / var_239_0), Mathf.Lerp(iter_239_1.color.g, arg_236_1.hightColor1.g, (arg_236_1.time_ - 0) / var_239_0), (Mathf.Lerp(iter_239_1.color.b, arg_236_1.hightColor1.b, (arg_236_1.time_ - 0) / var_239_0)))
							else
								local var_239_1 = Mathf.Lerp(iter_239_1.color.r, 1, (arg_236_1.time_ - 0) / var_239_0)

								iter_239_1.color = Color.New(var_239_1, var_239_1, var_239_1)
							end
						end
					end
				end
			end

			if arg_236_1.time_ >= 0 + var_239_0 and arg_236_1.time_ < 0 + var_239_0 + arg_239_0 and not isNil(arg_236_1.actors_["10094"]) and arg_236_1.var_.actorSpriteComps10094 then
				for iter_239_2, iter_239_3 in pairs(arg_236_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_239_3 then
						iter_239_3.color = arg_236_1.isInRecall_ and (arg_236_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_236_1.var_.actorSpriteComps10094 = nil
			end

			local var_239_2 = arg_236_1.actors_["10022"]

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 and not isNil(var_239_2) and arg_236_1.var_.actorSpriteComps10022 == nil then
				arg_236_1.var_.actorSpriteComps10022 = var_239_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_239_3 = 2

			if 0 <= arg_236_1.time_ and arg_236_1.time_ < 0 + var_239_3 and not isNil(var_239_2) then
				if arg_236_1.var_.actorSpriteComps10022 then
					for iter_239_4, iter_239_5 in pairs(arg_236_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_239_5 then
							if arg_236_1.isInRecall_ then
								iter_239_5.color = Color.New(Mathf.Lerp(iter_239_5.color.r, arg_236_1.hightColor2.r, (arg_236_1.time_ - 0) / var_239_3), Mathf.Lerp(iter_239_5.color.g, arg_236_1.hightColor2.g, (arg_236_1.time_ - 0) / var_239_3), (Mathf.Lerp(iter_239_5.color.b, arg_236_1.hightColor2.b, (arg_236_1.time_ - 0) / var_239_3)))
							else
								local var_239_4 = Mathf.Lerp(iter_239_5.color.r, 0.5, (arg_236_1.time_ - 0) / var_239_3)

								iter_239_5.color = Color.New(var_239_4, var_239_4, var_239_4)
							end
						end
					end
				end
			end

			if arg_236_1.time_ >= 0 + var_239_3 and arg_236_1.time_ < 0 + var_239_3 + arg_239_0 and not isNil(var_239_2) and arg_236_1.var_.actorSpriteComps10022 then
				for iter_239_6, iter_239_7 in pairs(arg_236_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_239_7 then
						iter_239_7.color = arg_236_1.isInRecall_ and (arg_236_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_236_1.var_.actorSpriteComps10022 = nil
			end

			local var_239_5 = 0
			local var_239_6 = 0.45

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= var_239_5 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, true)

				arg_236_1.leftNameTxt_.text = arg_236_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_236_1.leftNameTxt_.transform)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1.leftNameTxt_.text)
				SetActive(arg_236_1.iconTrs_.gameObject, false)
				arg_236_1.callingController_:SetSelectedState("normal")

				local var_239_7 = arg_236_1:GetWordFromCfg(413041058)
				local var_239_8 = arg_236_1:FormatText(var_239_7.content)

				arg_236_1.text_.text = var_239_8

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_10 = 18 <= 0 and var_239_6 or var_239_6 * (utf8.len(var_239_8) / 18)

				if (18 <= 0 and var_239_6 or var_239_6 * (utf8.len(var_239_8) / 18)) > 0 and var_239_6 < var_239_10 then
					arg_236_1.talkMaxDuration = var_239_10

					if var_239_10 + var_239_5 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_10 + var_239_5
					end
				end

				arg_236_1.text_.text = var_239_8
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413041", "413041058", "story_v_out_413041.awb") ~= 0 then
					local var_239_11 = manager.audio:GetVoiceLength("story_v_out_413041", "413041058", "story_v_out_413041.awb") / 1000

					if var_239_11 + var_239_5 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_11 + var_239_5
					end

					if var_239_7.prefab_name ~= "" and arg_236_1.actors_[var_239_7.prefab_name] ~= nil then
						local var_239_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_236_1.actors_[var_239_7.prefab_name].transform, "story_v_out_413041", "413041058", "story_v_out_413041.awb")

						arg_236_1:RecordAudio("413041058", var_239_12)
						arg_236_1:RecordAudio("413041058", var_239_12)
					else
						arg_236_1:AudioAction("play", "voice", "story_v_out_413041", "413041058", "story_v_out_413041.awb")
					end

					arg_236_1:RecordHistoryTalkVoice("story_v_out_413041", "413041058", "story_v_out_413041.awb")
				end

				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_13 = math.max(var_239_6, arg_236_1.talkMaxDuration)

			if var_239_5 <= arg_236_1.time_ and arg_236_1.time_ < var_239_5 + var_239_13 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - var_239_5) / var_239_13

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= var_239_5 + var_239_13 and arg_236_1.time_ < var_239_5 + var_239_13 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {}

		arg_236_1:InitPlayNodeList()
	end,
	Play413041059 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 413041059
		arg_240_1.duration_ = 15.2

		local var_240_0 = {
			zh = 4.866,
			ja = 15.2
		}
		local var_240_1 = manager.audio:GetLocalizationFlag()

		if var_240_0[var_240_1] ~= nil then
			arg_240_1.duration_ = var_240_0[var_240_1]
		end

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
		end

		function arg_240_1.playNext_(arg_242_0)
			if arg_242_0 == 1 then
				arg_240_0:Play413041060(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			local var_243_0 = 0.625

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, true)

				arg_240_1.leftNameTxt_.text = arg_240_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_240_1.leftNameTxt_.transform)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1.leftNameTxt_.text)
				SetActive(arg_240_1.iconTrs_.gameObject, false)
				arg_240_1.callingController_:SetSelectedState("normal")

				local var_243_1 = arg_240_1:GetWordFromCfg(413041059)
				local var_243_2 = arg_240_1:FormatText(var_243_1.content)

				arg_240_1.text_.text = var_243_2

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_4 = 25 <= 0 and var_243_0 or var_243_0 * (utf8.len(var_243_2) / 25)

				if (25 <= 0 and var_243_0 or var_243_0 * (utf8.len(var_243_2) / 25)) > 0 and var_243_0 < var_243_4 then
					arg_240_1.talkMaxDuration = var_243_4

					if var_243_4 + 0 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_4 + 0
					end
				end

				arg_240_1.text_.text = var_243_2
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413041", "413041059", "story_v_out_413041.awb") ~= 0 then
					local var_243_5 = manager.audio:GetVoiceLength("story_v_out_413041", "413041059", "story_v_out_413041.awb") / 1000

					if var_243_5 + 0 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_5 + 0
					end

					if var_243_1.prefab_name ~= "" and arg_240_1.actors_[var_243_1.prefab_name] ~= nil then
						local var_243_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_240_1.actors_[var_243_1.prefab_name].transform, "story_v_out_413041", "413041059", "story_v_out_413041.awb")

						arg_240_1:RecordAudio("413041059", var_243_6)
						arg_240_1:RecordAudio("413041059", var_243_6)
					else
						arg_240_1:AudioAction("play", "voice", "story_v_out_413041", "413041059", "story_v_out_413041.awb")
					end

					arg_240_1:RecordHistoryTalkVoice("story_v_out_413041", "413041059", "story_v_out_413041.awb")
				end

				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_7 = math.max(var_243_0, arg_240_1.talkMaxDuration)

			if 0 <= arg_240_1.time_ and arg_240_1.time_ < 0 + var_243_7 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - 0) / var_243_7

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= 0 + var_243_7 and arg_240_1.time_ < 0 + var_243_7 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {}

		arg_240_1:InitPlayNodeList()
	end,
	Play413041060 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 413041060
		arg_244_1.duration_ = 9.13

		local var_244_0 = {
			zh = 5.933,
			ja = 9.133
		}
		local var_244_1 = manager.audio:GetLocalizationFlag()

		if var_244_0[var_244_1] ~= nil then
			arg_244_1.duration_ = var_244_0[var_244_1]
		end

		SetActive(arg_244_1.tipsGo_, false)

		function arg_244_1.onSingleLineFinish_()
			arg_244_1.onSingleLineUpdate_ = nil
			arg_244_1.onSingleLineFinish_ = nil
			arg_244_1.state_ = "waiting"
		end

		function arg_244_1.playNext_(arg_246_0)
			if arg_246_0 == 1 then
				arg_244_0:Play413041061(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 then
				arg_244_1.var_.moveOldPos10022 = arg_244_1.actors_["10022"].transform.localPosition
				arg_244_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_244_1:CheckSpriteTmpPos("10022", 2)

				for iter_247_0 = 0, arg_244_1.actors_["10022"].transform.childCount - 1 do
					local var_247_0 = arg_244_1.actors_["10022"].transform:GetChild(iter_247_0)

					if var_247_0.name == "split_8" or not string.find(var_247_0.name, "split") then
						var_247_0.gameObject:SetActive(true)
					else
						var_247_0.gameObject:SetActive(false)
					end
				end
			end

			local var_247_1 = 0.001

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_1 then
				arg_244_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_244_1.var_.moveOldPos10022, Vector3.New(-390, -315, -320), (arg_244_1.time_ - 0) / var_247_1)
			end

			if arg_244_1.time_ >= 0 + var_247_1 and arg_244_1.time_ < 0 + var_247_1 + arg_247_0 then
				arg_244_1.actors_["10022"].transform.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_247_2 = arg_244_1.actors_["10094"]

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 and not isNil(var_247_2) and arg_244_1.var_.actorSpriteComps10094 == nil then
				arg_244_1.var_.actorSpriteComps10094 = var_247_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_247_3 = 2

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_3 and not isNil(var_247_2) then
				if arg_244_1.var_.actorSpriteComps10094 then
					for iter_247_1, iter_247_2 in pairs(arg_244_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_247_2 then
							if arg_244_1.isInRecall_ then
								iter_247_2.color = Color.New(Mathf.Lerp(iter_247_2.color.r, arg_244_1.hightColor2.r, (arg_244_1.time_ - 0) / var_247_3), Mathf.Lerp(iter_247_2.color.g, arg_244_1.hightColor2.g, (arg_244_1.time_ - 0) / var_247_3), (Mathf.Lerp(iter_247_2.color.b, arg_244_1.hightColor2.b, (arg_244_1.time_ - 0) / var_247_3)))
							else
								local var_247_4 = Mathf.Lerp(iter_247_2.color.r, 0.5, (arg_244_1.time_ - 0) / var_247_3)

								iter_247_2.color = Color.New(var_247_4, var_247_4, var_247_4)
							end
						end
					end
				end
			end

			if arg_244_1.time_ >= 0 + var_247_3 and arg_244_1.time_ < 0 + var_247_3 + arg_247_0 and not isNil(var_247_2) and arg_244_1.var_.actorSpriteComps10094 then
				for iter_247_3, iter_247_4 in pairs(arg_244_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_247_4 then
						iter_247_4.color = arg_244_1.isInRecall_ and (arg_244_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_244_1.var_.actorSpriteComps10094 = nil
			end

			local var_247_5 = arg_244_1.actors_["10022"]

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 and not isNil(var_247_5) and arg_244_1.var_.actorSpriteComps10022 == nil then
				arg_244_1.var_.actorSpriteComps10022 = var_247_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_247_6 = 2

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_6 and not isNil(var_247_5) then
				if arg_244_1.var_.actorSpriteComps10022 then
					for iter_247_5, iter_247_6 in pairs(arg_244_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_247_6 then
							if arg_244_1.isInRecall_ then
								iter_247_6.color = Color.New(Mathf.Lerp(iter_247_6.color.r, arg_244_1.hightColor1.r, (arg_244_1.time_ - 0) / var_247_6), Mathf.Lerp(iter_247_6.color.g, arg_244_1.hightColor1.g, (arg_244_1.time_ - 0) / var_247_6), (Mathf.Lerp(iter_247_6.color.b, arg_244_1.hightColor1.b, (arg_244_1.time_ - 0) / var_247_6)))
							else
								local var_247_7 = Mathf.Lerp(iter_247_6.color.r, 1, (arg_244_1.time_ - 0) / var_247_6)

								iter_247_6.color = Color.New(var_247_7, var_247_7, var_247_7)
							end
						end
					end
				end
			end

			if arg_244_1.time_ >= 0 + var_247_6 and arg_244_1.time_ < 0 + var_247_6 + arg_247_0 and not isNil(var_247_5) and arg_244_1.var_.actorSpriteComps10022 then
				for iter_247_7, iter_247_8 in pairs(arg_244_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_247_8 then
						iter_247_8.color = arg_244_1.isInRecall_ and (arg_244_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_244_1.var_.actorSpriteComps10022 = nil
			end

			local var_247_8 = 0
			local var_247_9 = 0.675

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= var_247_8 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, true)

				arg_244_1.leftNameTxt_.text = arg_244_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_244_1.leftNameTxt_.transform)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1.leftNameTxt_.text)
				SetActive(arg_244_1.iconTrs_.gameObject, false)
				arg_244_1.callingController_:SetSelectedState("normal")

				local var_247_10 = arg_244_1:GetWordFromCfg(413041060)
				local var_247_11 = arg_244_1:FormatText(var_247_10.content)

				arg_244_1.text_.text = var_247_11

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_13 = 27 <= 0 and var_247_9 or var_247_9 * (utf8.len(var_247_11) / 27)

				if (27 <= 0 and var_247_9 or var_247_9 * (utf8.len(var_247_11) / 27)) > 0 and var_247_9 < var_247_13 then
					arg_244_1.talkMaxDuration = var_247_13

					if var_247_13 + var_247_8 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_13 + var_247_8
					end
				end

				arg_244_1.text_.text = var_247_11
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413041", "413041060", "story_v_out_413041.awb") ~= 0 then
					local var_247_14 = manager.audio:GetVoiceLength("story_v_out_413041", "413041060", "story_v_out_413041.awb") / 1000

					if var_247_14 + var_247_8 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_14 + var_247_8
					end

					if var_247_10.prefab_name ~= "" and arg_244_1.actors_[var_247_10.prefab_name] ~= nil then
						local var_247_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_244_1.actors_[var_247_10.prefab_name].transform, "story_v_out_413041", "413041060", "story_v_out_413041.awb")

						arg_244_1:RecordAudio("413041060", var_247_15)
						arg_244_1:RecordAudio("413041060", var_247_15)
					else
						arg_244_1:AudioAction("play", "voice", "story_v_out_413041", "413041060", "story_v_out_413041.awb")
					end

					arg_244_1:RecordHistoryTalkVoice("story_v_out_413041", "413041060", "story_v_out_413041.awb")
				end

				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_16 = math.max(var_247_9, arg_244_1.talkMaxDuration)

			if var_247_8 <= arg_244_1.time_ and arg_244_1.time_ < var_247_8 + var_247_16 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_8) / var_247_16

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_8 + var_247_16 and arg_244_1.time_ < var_247_8 + var_247_16 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_244_1:InitPlayNodeList()
	end,
	Play413041061 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 413041061
		arg_248_1.duration_ = 11.27

		local var_248_0 = {
			zh = 7.266,
			ja = 11.266
		}
		local var_248_1 = manager.audio:GetLocalizationFlag()

		if var_248_0[var_248_1] ~= nil then
			arg_248_1.duration_ = var_248_0[var_248_1]
		end

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
		end

		function arg_248_1.playNext_(arg_250_0)
			if arg_250_0 == 1 then
				arg_248_0:Play413041062(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			local var_251_0 = 1.05

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, true)

				arg_248_1.leftNameTxt_.text = arg_248_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_248_1.leftNameTxt_.transform)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1.leftNameTxt_.text)
				SetActive(arg_248_1.iconTrs_.gameObject, false)
				arg_248_1.callingController_:SetSelectedState("normal")

				local var_251_1 = arg_248_1:GetWordFromCfg(413041061)
				local var_251_2 = arg_248_1:FormatText(var_251_1.content)

				arg_248_1.text_.text = var_251_2

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_4 = 42 <= 0 and var_251_0 or var_251_0 * (utf8.len(var_251_2) / 42)

				if (42 <= 0 and var_251_0 or var_251_0 * (utf8.len(var_251_2) / 42)) > 0 and var_251_0 < var_251_4 then
					arg_248_1.talkMaxDuration = var_251_4

					if var_251_4 + 0 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_4 + 0
					end
				end

				arg_248_1.text_.text = var_251_2
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413041", "413041061", "story_v_out_413041.awb") ~= 0 then
					local var_251_5 = manager.audio:GetVoiceLength("story_v_out_413041", "413041061", "story_v_out_413041.awb") / 1000

					if var_251_5 + 0 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_5 + 0
					end

					if var_251_1.prefab_name ~= "" and arg_248_1.actors_[var_251_1.prefab_name] ~= nil then
						local var_251_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_248_1.actors_[var_251_1.prefab_name].transform, "story_v_out_413041", "413041061", "story_v_out_413041.awb")

						arg_248_1:RecordAudio("413041061", var_251_6)
						arg_248_1:RecordAudio("413041061", var_251_6)
					else
						arg_248_1:AudioAction("play", "voice", "story_v_out_413041", "413041061", "story_v_out_413041.awb")
					end

					arg_248_1:RecordHistoryTalkVoice("story_v_out_413041", "413041061", "story_v_out_413041.awb")
				end

				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_7 = math.max(var_251_0, arg_248_1.talkMaxDuration)

			if 0 <= arg_248_1.time_ and arg_248_1.time_ < 0 + var_251_7 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - 0) / var_251_7

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= 0 + var_251_7 and arg_248_1.time_ < 0 + var_251_7 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {}

		arg_248_1:InitPlayNodeList()
	end,
	Play413041062 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 413041062
		arg_252_1.duration_ = 7.1

		local var_252_0 = {
			zh = 3.466,
			ja = 7.1
		}
		local var_252_1 = manager.audio:GetLocalizationFlag()

		if var_252_0[var_252_1] ~= nil then
			arg_252_1.duration_ = var_252_0[var_252_1]
		end

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play413041063(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 and not isNil(arg_252_1.actors_["10094"]) and arg_252_1.var_.actorSpriteComps10094 == nil then
				arg_252_1.var_.actorSpriteComps10094 = arg_252_1.actors_["10094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_255_0 = 2

			if 0 <= arg_252_1.time_ and arg_252_1.time_ < 0 + var_255_0 and not isNil(arg_252_1.actors_["10094"]) then
				if arg_252_1.var_.actorSpriteComps10094 then
					for iter_255_0, iter_255_1 in pairs(arg_252_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_255_1 then
							if arg_252_1.isInRecall_ then
								iter_255_1.color = Color.New(Mathf.Lerp(iter_255_1.color.r, arg_252_1.hightColor1.r, (arg_252_1.time_ - 0) / var_255_0), Mathf.Lerp(iter_255_1.color.g, arg_252_1.hightColor1.g, (arg_252_1.time_ - 0) / var_255_0), (Mathf.Lerp(iter_255_1.color.b, arg_252_1.hightColor1.b, (arg_252_1.time_ - 0) / var_255_0)))
							else
								local var_255_1 = Mathf.Lerp(iter_255_1.color.r, 1, (arg_252_1.time_ - 0) / var_255_0)

								iter_255_1.color = Color.New(var_255_1, var_255_1, var_255_1)
							end
						end
					end
				end
			end

			if arg_252_1.time_ >= 0 + var_255_0 and arg_252_1.time_ < 0 + var_255_0 + arg_255_0 and not isNil(arg_252_1.actors_["10094"]) and arg_252_1.var_.actorSpriteComps10094 then
				for iter_255_2, iter_255_3 in pairs(arg_252_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_255_3 then
						iter_255_3.color = arg_252_1.isInRecall_ and (arg_252_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_252_1.var_.actorSpriteComps10094 = nil
			end

			local var_255_2 = arg_252_1.actors_["10022"]

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 and not isNil(var_255_2) and arg_252_1.var_.actorSpriteComps10022 == nil then
				arg_252_1.var_.actorSpriteComps10022 = var_255_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_255_3 = 2

			if 0 <= arg_252_1.time_ and arg_252_1.time_ < 0 + var_255_3 and not isNil(var_255_2) then
				if arg_252_1.var_.actorSpriteComps10022 then
					for iter_255_4, iter_255_5 in pairs(arg_252_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_255_5 then
							if arg_252_1.isInRecall_ then
								iter_255_5.color = Color.New(Mathf.Lerp(iter_255_5.color.r, arg_252_1.hightColor2.r, (arg_252_1.time_ - 0) / var_255_3), Mathf.Lerp(iter_255_5.color.g, arg_252_1.hightColor2.g, (arg_252_1.time_ - 0) / var_255_3), (Mathf.Lerp(iter_255_5.color.b, arg_252_1.hightColor2.b, (arg_252_1.time_ - 0) / var_255_3)))
							else
								local var_255_4 = Mathf.Lerp(iter_255_5.color.r, 0.5, (arg_252_1.time_ - 0) / var_255_3)

								iter_255_5.color = Color.New(var_255_4, var_255_4, var_255_4)
							end
						end
					end
				end
			end

			if arg_252_1.time_ >= 0 + var_255_3 and arg_252_1.time_ < 0 + var_255_3 + arg_255_0 and not isNil(var_255_2) and arg_252_1.var_.actorSpriteComps10022 then
				for iter_255_6, iter_255_7 in pairs(arg_252_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_255_7 then
						iter_255_7.color = arg_252_1.isInRecall_ and (arg_252_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_252_1.var_.actorSpriteComps10022 = nil
			end

			local var_255_5 = 0
			local var_255_6 = 0.45

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= var_255_5 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, true)

				arg_252_1.leftNameTxt_.text = arg_252_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_252_1.leftNameTxt_.transform)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1.leftNameTxt_.text)
				SetActive(arg_252_1.iconTrs_.gameObject, false)
				arg_252_1.callingController_:SetSelectedState("normal")

				local var_255_7 = arg_252_1:GetWordFromCfg(413041062)
				local var_255_8 = arg_252_1:FormatText(var_255_7.content)

				arg_252_1.text_.text = var_255_8

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_10 = 18 <= 0 and var_255_6 or var_255_6 * (utf8.len(var_255_8) / 18)

				if (18 <= 0 and var_255_6 or var_255_6 * (utf8.len(var_255_8) / 18)) > 0 and var_255_6 < var_255_10 then
					arg_252_1.talkMaxDuration = var_255_10

					if var_255_10 + var_255_5 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_10 + var_255_5
					end
				end

				arg_252_1.text_.text = var_255_8
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413041", "413041062", "story_v_out_413041.awb") ~= 0 then
					local var_255_11 = manager.audio:GetVoiceLength("story_v_out_413041", "413041062", "story_v_out_413041.awb") / 1000

					if var_255_11 + var_255_5 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_11 + var_255_5
					end

					if var_255_7.prefab_name ~= "" and arg_252_1.actors_[var_255_7.prefab_name] ~= nil then
						local var_255_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_252_1.actors_[var_255_7.prefab_name].transform, "story_v_out_413041", "413041062", "story_v_out_413041.awb")

						arg_252_1:RecordAudio("413041062", var_255_12)
						arg_252_1:RecordAudio("413041062", var_255_12)
					else
						arg_252_1:AudioAction("play", "voice", "story_v_out_413041", "413041062", "story_v_out_413041.awb")
					end

					arg_252_1:RecordHistoryTalkVoice("story_v_out_413041", "413041062", "story_v_out_413041.awb")
				end

				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_13 = math.max(var_255_6, arg_252_1.talkMaxDuration)

			if var_255_5 <= arg_252_1.time_ and arg_252_1.time_ < var_255_5 + var_255_13 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_5) / var_255_13

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_5 + var_255_13 and arg_252_1.time_ < var_255_5 + var_255_13 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {}

		arg_252_1:InitPlayNodeList()
	end,
	Play413041063 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 413041063
		arg_256_1.duration_ = 8.43

		local var_256_0 = {
			zh = 6.233,
			ja = 8.433
		}
		local var_256_1 = manager.audio:GetLocalizationFlag()

		if var_256_0[var_256_1] ~= nil then
			arg_256_1.duration_ = var_256_0[var_256_1]
		end

		SetActive(arg_256_1.tipsGo_, false)

		function arg_256_1.onSingleLineFinish_()
			arg_256_1.onSingleLineUpdate_ = nil
			arg_256_1.onSingleLineFinish_ = nil
			arg_256_1.state_ = "waiting"
		end

		function arg_256_1.playNext_(arg_258_0)
			if arg_258_0 == 1 then
				arg_256_0:Play413041064(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 then
				arg_256_1.var_.moveOldPos10022 = arg_256_1.actors_["10022"].transform.localPosition
				arg_256_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_256_1:CheckSpriteTmpPos("10022", 2)

				for iter_259_0 = 0, arg_256_1.actors_["10022"].transform.childCount - 1 do
					local var_259_0 = arg_256_1.actors_["10022"].transform:GetChild(iter_259_0)

					if var_259_0.name == "split_8" or not string.find(var_259_0.name, "split") then
						var_259_0.gameObject:SetActive(true)
					else
						var_259_0.gameObject:SetActive(false)
					end
				end
			end

			local var_259_1 = 0.001

			if 0 <= arg_256_1.time_ and arg_256_1.time_ < 0 + var_259_1 then
				arg_256_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_256_1.var_.moveOldPos10022, Vector3.New(-390, -315, -320), (arg_256_1.time_ - 0) / var_259_1)
			end

			if arg_256_1.time_ >= 0 + var_259_1 and arg_256_1.time_ < 0 + var_259_1 + arg_259_0 then
				arg_256_1.actors_["10022"].transform.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_259_2 = arg_256_1.actors_["10094"]

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 and not isNil(var_259_2) and arg_256_1.var_.actorSpriteComps10094 == nil then
				arg_256_1.var_.actorSpriteComps10094 = var_259_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_259_3 = 2

			if 0 <= arg_256_1.time_ and arg_256_1.time_ < 0 + var_259_3 and not isNil(var_259_2) then
				if arg_256_1.var_.actorSpriteComps10094 then
					for iter_259_1, iter_259_2 in pairs(arg_256_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_259_2 then
							if arg_256_1.isInRecall_ then
								iter_259_2.color = Color.New(Mathf.Lerp(iter_259_2.color.r, arg_256_1.hightColor2.r, (arg_256_1.time_ - 0) / var_259_3), Mathf.Lerp(iter_259_2.color.g, arg_256_1.hightColor2.g, (arg_256_1.time_ - 0) / var_259_3), (Mathf.Lerp(iter_259_2.color.b, arg_256_1.hightColor2.b, (arg_256_1.time_ - 0) / var_259_3)))
							else
								local var_259_4 = Mathf.Lerp(iter_259_2.color.r, 0.5, (arg_256_1.time_ - 0) / var_259_3)

								iter_259_2.color = Color.New(var_259_4, var_259_4, var_259_4)
							end
						end
					end
				end
			end

			if arg_256_1.time_ >= 0 + var_259_3 and arg_256_1.time_ < 0 + var_259_3 + arg_259_0 and not isNil(var_259_2) and arg_256_1.var_.actorSpriteComps10094 then
				for iter_259_3, iter_259_4 in pairs(arg_256_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_259_4 then
						iter_259_4.color = arg_256_1.isInRecall_ and (arg_256_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_256_1.var_.actorSpriteComps10094 = nil
			end

			local var_259_5 = arg_256_1.actors_["10022"]

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 and not isNil(var_259_5) and arg_256_1.var_.actorSpriteComps10022 == nil then
				arg_256_1.var_.actorSpriteComps10022 = var_259_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_259_6 = 2

			if 0 <= arg_256_1.time_ and arg_256_1.time_ < 0 + var_259_6 and not isNil(var_259_5) then
				if arg_256_1.var_.actorSpriteComps10022 then
					for iter_259_5, iter_259_6 in pairs(arg_256_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_259_6 then
							if arg_256_1.isInRecall_ then
								iter_259_6.color = Color.New(Mathf.Lerp(iter_259_6.color.r, arg_256_1.hightColor1.r, (arg_256_1.time_ - 0) / var_259_6), Mathf.Lerp(iter_259_6.color.g, arg_256_1.hightColor1.g, (arg_256_1.time_ - 0) / var_259_6), (Mathf.Lerp(iter_259_6.color.b, arg_256_1.hightColor1.b, (arg_256_1.time_ - 0) / var_259_6)))
							else
								local var_259_7 = Mathf.Lerp(iter_259_6.color.r, 1, (arg_256_1.time_ - 0) / var_259_6)

								iter_259_6.color = Color.New(var_259_7, var_259_7, var_259_7)
							end
						end
					end
				end
			end

			if arg_256_1.time_ >= 0 + var_259_6 and arg_256_1.time_ < 0 + var_259_6 + arg_259_0 and not isNil(var_259_5) and arg_256_1.var_.actorSpriteComps10022 then
				for iter_259_7, iter_259_8 in pairs(arg_256_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_259_8 then
						iter_259_8.color = arg_256_1.isInRecall_ and (arg_256_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_256_1.var_.actorSpriteComps10022 = nil
			end

			local var_259_8 = 0
			local var_259_9 = 0.725

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= var_259_8 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, true)

				arg_256_1.leftNameTxt_.text = arg_256_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_256_1.leftNameTxt_.transform)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1.leftNameTxt_.text)
				SetActive(arg_256_1.iconTrs_.gameObject, false)
				arg_256_1.callingController_:SetSelectedState("normal")

				local var_259_10 = arg_256_1:GetWordFromCfg(413041063)
				local var_259_11 = arg_256_1:FormatText(var_259_10.content)

				arg_256_1.text_.text = var_259_11

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_13 = 29 <= 0 and var_259_9 or var_259_9 * (utf8.len(var_259_11) / 29)

				if (29 <= 0 and var_259_9 or var_259_9 * (utf8.len(var_259_11) / 29)) > 0 and var_259_9 < var_259_13 then
					arg_256_1.talkMaxDuration = var_259_13

					if var_259_13 + var_259_8 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_13 + var_259_8
					end
				end

				arg_256_1.text_.text = var_259_11
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413041", "413041063", "story_v_out_413041.awb") ~= 0 then
					local var_259_14 = manager.audio:GetVoiceLength("story_v_out_413041", "413041063", "story_v_out_413041.awb") / 1000

					if var_259_14 + var_259_8 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_14 + var_259_8
					end

					if var_259_10.prefab_name ~= "" and arg_256_1.actors_[var_259_10.prefab_name] ~= nil then
						local var_259_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_256_1.actors_[var_259_10.prefab_name].transform, "story_v_out_413041", "413041063", "story_v_out_413041.awb")

						arg_256_1:RecordAudio("413041063", var_259_15)
						arg_256_1:RecordAudio("413041063", var_259_15)
					else
						arg_256_1:AudioAction("play", "voice", "story_v_out_413041", "413041063", "story_v_out_413041.awb")
					end

					arg_256_1:RecordHistoryTalkVoice("story_v_out_413041", "413041063", "story_v_out_413041.awb")
				end

				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_16 = math.max(var_259_9, arg_256_1.talkMaxDuration)

			if var_259_8 <= arg_256_1.time_ and arg_256_1.time_ < var_259_8 + var_259_16 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - var_259_8) / var_259_16

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= var_259_8 + var_259_16 and arg_256_1.time_ < var_259_8 + var_259_16 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_256_1:InitPlayNodeList()
	end,
	Play413041064 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 413041064
		arg_260_1.duration_ = 5.97

		local var_260_0 = {
			zh = 1.999999999999,
			ja = 5.966
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
				arg_260_0:Play413041065(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 and not isNil(arg_260_1.actors_["10094"]) and arg_260_1.var_.actorSpriteComps10094 == nil then
				arg_260_1.var_.actorSpriteComps10094 = arg_260_1.actors_["10094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_263_0 = 2

			if 0 <= arg_260_1.time_ and arg_260_1.time_ < 0 + var_263_0 and not isNil(arg_260_1.actors_["10094"]) then
				if arg_260_1.var_.actorSpriteComps10094 then
					for iter_263_0, iter_263_1 in pairs(arg_260_1.var_.actorSpriteComps10094:ToTable()) do
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

			if arg_260_1.time_ >= 0 + var_263_0 and arg_260_1.time_ < 0 + var_263_0 + arg_263_0 and not isNil(arg_260_1.actors_["10094"]) and arg_260_1.var_.actorSpriteComps10094 then
				for iter_263_2, iter_263_3 in pairs(arg_260_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_263_3 then
						iter_263_3.color = arg_260_1.isInRecall_ and (arg_260_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_260_1.var_.actorSpriteComps10094 = nil
			end

			local var_263_2 = arg_260_1.actors_["10022"]

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 and not isNil(var_263_2) and arg_260_1.var_.actorSpriteComps10022 == nil then
				arg_260_1.var_.actorSpriteComps10022 = var_263_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_263_3 = 2

			if 0 <= arg_260_1.time_ and arg_260_1.time_ < 0 + var_263_3 and not isNil(var_263_2) then
				if arg_260_1.var_.actorSpriteComps10022 then
					for iter_263_4, iter_263_5 in pairs(arg_260_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_263_5 then
							if arg_260_1.isInRecall_ then
								iter_263_5.color = Color.New(Mathf.Lerp(iter_263_5.color.r, arg_260_1.hightColor2.r, (arg_260_1.time_ - 0) / var_263_3), Mathf.Lerp(iter_263_5.color.g, arg_260_1.hightColor2.g, (arg_260_1.time_ - 0) / var_263_3), (Mathf.Lerp(iter_263_5.color.b, arg_260_1.hightColor2.b, (arg_260_1.time_ - 0) / var_263_3)))
							else
								local var_263_4 = Mathf.Lerp(iter_263_5.color.r, 0.5, (arg_260_1.time_ - 0) / var_263_3)

								iter_263_5.color = Color.New(var_263_4, var_263_4, var_263_4)
							end
						end
					end
				end
			end

			if arg_260_1.time_ >= 0 + var_263_3 and arg_260_1.time_ < 0 + var_263_3 + arg_263_0 and not isNil(var_263_2) and arg_260_1.var_.actorSpriteComps10022 then
				for iter_263_6, iter_263_7 in pairs(arg_260_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_263_7 then
						iter_263_7.color = arg_260_1.isInRecall_ and (arg_260_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_260_1.var_.actorSpriteComps10022 = nil
			end

			local var_263_5 = 0
			local var_263_6 = 0.25

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= var_263_5 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0
				arg_260_1.dialogCg_.alpha = 1

				arg_260_1.dialog_:SetActive(true)
				SetActive(arg_260_1.leftNameGo_, true)

				arg_260_1.leftNameTxt_.text = arg_260_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_260_1.leftNameTxt_.transform)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1.leftNameTxt_.text)
				SetActive(arg_260_1.iconTrs_.gameObject, false)
				arg_260_1.callingController_:SetSelectedState("normal")

				local var_263_7 = arg_260_1:GetWordFromCfg(413041064)
				local var_263_8 = arg_260_1:FormatText(var_263_7.content)

				arg_260_1.text_.text = var_263_8

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_10 = 10 <= 0 and var_263_6 or var_263_6 * (utf8.len(var_263_8) / 10)

				if (10 <= 0 and var_263_6 or var_263_6 * (utf8.len(var_263_8) / 10)) > 0 and var_263_6 < var_263_10 then
					arg_260_1.talkMaxDuration = var_263_10

					if var_263_10 + var_263_5 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_10 + var_263_5
					end
				end

				arg_260_1.text_.text = var_263_8
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413041", "413041064", "story_v_out_413041.awb") ~= 0 then
					local var_263_11 = manager.audio:GetVoiceLength("story_v_out_413041", "413041064", "story_v_out_413041.awb") / 1000

					if var_263_11 + var_263_5 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_11 + var_263_5
					end

					if var_263_7.prefab_name ~= "" and arg_260_1.actors_[var_263_7.prefab_name] ~= nil then
						local var_263_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_260_1.actors_[var_263_7.prefab_name].transform, "story_v_out_413041", "413041064", "story_v_out_413041.awb")

						arg_260_1:RecordAudio("413041064", var_263_12)
						arg_260_1:RecordAudio("413041064", var_263_12)
					else
						arg_260_1:AudioAction("play", "voice", "story_v_out_413041", "413041064", "story_v_out_413041.awb")
					end

					arg_260_1:RecordHistoryTalkVoice("story_v_out_413041", "413041064", "story_v_out_413041.awb")
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

		arg_260_1.nodeConfigList_ = {}

		arg_260_1:InitPlayNodeList()
	end,
	Play413041065 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 413041065
		arg_264_1.duration_ = 6.9

		local var_264_0 = {
			zh = 4.266,
			ja = 6.9
		}
		local var_264_1 = manager.audio:GetLocalizationFlag()

		if var_264_0[var_264_1] ~= nil then
			arg_264_1.duration_ = var_264_0[var_264_1]
		end

		SetActive(arg_264_1.tipsGo_, false)

		function arg_264_1.onSingleLineFinish_()
			arg_264_1.onSingleLineUpdate_ = nil
			arg_264_1.onSingleLineFinish_ = nil
			arg_264_1.state_ = "waiting"
		end

		function arg_264_1.playNext_(arg_266_0)
			if arg_266_0 == 1 then
				arg_264_0:Play413041066(arg_264_1)
			end
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 and not isNil(arg_264_1.actors_["10094"]) and arg_264_1.var_.actorSpriteComps10094 == nil then
				arg_264_1.var_.actorSpriteComps10094 = arg_264_1.actors_["10094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_267_0 = 2

			if 0 <= arg_264_1.time_ and arg_264_1.time_ < 0 + var_267_0 and not isNil(arg_264_1.actors_["10094"]) then
				if arg_264_1.var_.actorSpriteComps10094 then
					for iter_267_0, iter_267_1 in pairs(arg_264_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_267_1 then
							if arg_264_1.isInRecall_ then
								iter_267_1.color = Color.New(Mathf.Lerp(iter_267_1.color.r, arg_264_1.hightColor2.r, (arg_264_1.time_ - 0) / var_267_0), Mathf.Lerp(iter_267_1.color.g, arg_264_1.hightColor2.g, (arg_264_1.time_ - 0) / var_267_0), (Mathf.Lerp(iter_267_1.color.b, arg_264_1.hightColor2.b, (arg_264_1.time_ - 0) / var_267_0)))
							else
								local var_267_1 = Mathf.Lerp(iter_267_1.color.r, 0.5, (arg_264_1.time_ - 0) / var_267_0)

								iter_267_1.color = Color.New(var_267_1, var_267_1, var_267_1)
							end
						end
					end
				end
			end

			if arg_264_1.time_ >= 0 + var_267_0 and arg_264_1.time_ < 0 + var_267_0 + arg_267_0 and not isNil(arg_264_1.actors_["10094"]) and arg_264_1.var_.actorSpriteComps10094 then
				for iter_267_2, iter_267_3 in pairs(arg_264_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_267_3 then
						iter_267_3.color = arg_264_1.isInRecall_ and (arg_264_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_264_1.var_.actorSpriteComps10094 = nil
			end

			local var_267_2 = arg_264_1.actors_["10022"]

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 and not isNil(var_267_2) and arg_264_1.var_.actorSpriteComps10022 == nil then
				arg_264_1.var_.actorSpriteComps10022 = var_267_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_267_3 = 2

			if 0 <= arg_264_1.time_ and arg_264_1.time_ < 0 + var_267_3 and not isNil(var_267_2) then
				if arg_264_1.var_.actorSpriteComps10022 then
					for iter_267_4, iter_267_5 in pairs(arg_264_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_267_5 then
							if arg_264_1.isInRecall_ then
								iter_267_5.color = Color.New(Mathf.Lerp(iter_267_5.color.r, arg_264_1.hightColor1.r, (arg_264_1.time_ - 0) / var_267_3), Mathf.Lerp(iter_267_5.color.g, arg_264_1.hightColor1.g, (arg_264_1.time_ - 0) / var_267_3), (Mathf.Lerp(iter_267_5.color.b, arg_264_1.hightColor1.b, (arg_264_1.time_ - 0) / var_267_3)))
							else
								local var_267_4 = Mathf.Lerp(iter_267_5.color.r, 1, (arg_264_1.time_ - 0) / var_267_3)

								iter_267_5.color = Color.New(var_267_4, var_267_4, var_267_4)
							end
						end
					end
				end
			end

			if arg_264_1.time_ >= 0 + var_267_3 and arg_264_1.time_ < 0 + var_267_3 + arg_267_0 and not isNil(var_267_2) and arg_264_1.var_.actorSpriteComps10022 then
				for iter_267_6, iter_267_7 in pairs(arg_264_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_267_7 then
						iter_267_7.color = arg_264_1.isInRecall_ and (arg_264_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_264_1.var_.actorSpriteComps10022 = nil
			end

			local var_267_5 = 0
			local var_267_6 = 0.475

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= var_267_5 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0
				arg_264_1.dialogCg_.alpha = 1

				arg_264_1.dialog_:SetActive(true)
				SetActive(arg_264_1.leftNameGo_, true)

				arg_264_1.leftNameTxt_.text = arg_264_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_264_1.leftNameTxt_.transform)

				arg_264_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_264_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_264_1:RecordName(arg_264_1.leftNameTxt_.text)
				SetActive(arg_264_1.iconTrs_.gameObject, false)
				arg_264_1.callingController_:SetSelectedState("normal")

				local var_267_7 = arg_264_1:GetWordFromCfg(413041065)
				local var_267_8 = arg_264_1:FormatText(var_267_7.content)

				arg_264_1.text_.text = var_267_8

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_10 = 19 <= 0 and var_267_6 or var_267_6 * (utf8.len(var_267_8) / 19)

				if (19 <= 0 and var_267_6 or var_267_6 * (utf8.len(var_267_8) / 19)) > 0 and var_267_6 < var_267_10 then
					arg_264_1.talkMaxDuration = var_267_10

					if var_267_10 + var_267_5 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_10 + var_267_5
					end
				end

				arg_264_1.text_.text = var_267_8
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413041", "413041065", "story_v_out_413041.awb") ~= 0 then
					local var_267_11 = manager.audio:GetVoiceLength("story_v_out_413041", "413041065", "story_v_out_413041.awb") / 1000

					if var_267_11 + var_267_5 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_11 + var_267_5
					end

					if var_267_7.prefab_name ~= "" and arg_264_1.actors_[var_267_7.prefab_name] ~= nil then
						local var_267_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_264_1.actors_[var_267_7.prefab_name].transform, "story_v_out_413041", "413041065", "story_v_out_413041.awb")

						arg_264_1:RecordAudio("413041065", var_267_12)
						arg_264_1:RecordAudio("413041065", var_267_12)
					else
						arg_264_1:AudioAction("play", "voice", "story_v_out_413041", "413041065", "story_v_out_413041.awb")
					end

					arg_264_1:RecordHistoryTalkVoice("story_v_out_413041", "413041065", "story_v_out_413041.awb")
				end

				arg_264_1:RecordContent(arg_264_1.text_.text)
			end

			local var_267_13 = math.max(var_267_6, arg_264_1.talkMaxDuration)

			if var_267_5 <= arg_264_1.time_ and arg_264_1.time_ < var_267_5 + var_267_13 then
				arg_264_1.typewritter.percent = (arg_264_1.time_ - var_267_5) / var_267_13

				arg_264_1.typewritter:SetDirty()
			end

			if arg_264_1.time_ >= var_267_5 + var_267_13 and arg_264_1.time_ < var_267_5 + var_267_13 + arg_267_0 then
				arg_264_1.typewritter.percent = 1

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(true)
			end
		end

		arg_264_1.nodeConfigList_ = {}

		arg_264_1:InitPlayNodeList()
	end,
	Play413041066 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 413041066
		arg_268_1.duration_ = 5.23

		local var_268_0 = {
			zh = 5.233,
			ja = 4.966
		}
		local var_268_1 = manager.audio:GetLocalizationFlag()

		if var_268_0[var_268_1] ~= nil then
			arg_268_1.duration_ = var_268_0[var_268_1]
		end

		SetActive(arg_268_1.tipsGo_, false)

		function arg_268_1.onSingleLineFinish_()
			arg_268_1.onSingleLineUpdate_ = nil
			arg_268_1.onSingleLineFinish_ = nil
			arg_268_1.state_ = "waiting"
		end

		function arg_268_1.playNext_(arg_270_0)
			if arg_270_0 == 1 then
				arg_268_0:Play413041067(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 then
				arg_268_1.var_.moveOldPos10094 = arg_268_1.actors_["10094"].transform.localPosition
				arg_268_1.actors_["10094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_268_1:CheckSpriteTmpPos("10094", 4)

				for iter_271_0 = 0, arg_268_1.actors_["10094"].transform.childCount - 1 do
					local var_271_0 = arg_268_1.actors_["10094"].transform:GetChild(iter_271_0)

					if var_271_0.name == "split_2" or not string.find(var_271_0.name, "split") then
						var_271_0.gameObject:SetActive(true)
					else
						var_271_0.gameObject:SetActive(false)
					end
				end
			end

			local var_271_1 = 0.001

			if 0 <= arg_268_1.time_ and arg_268_1.time_ < 0 + var_271_1 then
				arg_268_1.actors_["10094"].transform.localPosition = Vector3.Lerp(arg_268_1.var_.moveOldPos10094, Vector3.New(390, -340, -414), (arg_268_1.time_ - 0) / var_271_1)
			end

			if arg_268_1.time_ >= 0 + var_271_1 and arg_268_1.time_ < 0 + var_271_1 + arg_271_0 then
				arg_268_1.actors_["10094"].transform.localPosition = Vector3.New(390, -340, -414)
			end

			local var_271_2 = arg_268_1.actors_["10094"]

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 and not isNil(var_271_2) and arg_268_1.var_.actorSpriteComps10094 == nil then
				arg_268_1.var_.actorSpriteComps10094 = var_271_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_271_3 = 2

			if 0 <= arg_268_1.time_ and arg_268_1.time_ < 0 + var_271_3 and not isNil(var_271_2) then
				if arg_268_1.var_.actorSpriteComps10094 then
					for iter_271_1, iter_271_2 in pairs(arg_268_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_271_2 then
							if arg_268_1.isInRecall_ then
								iter_271_2.color = Color.New(Mathf.Lerp(iter_271_2.color.r, arg_268_1.hightColor1.r, (arg_268_1.time_ - 0) / var_271_3), Mathf.Lerp(iter_271_2.color.g, arg_268_1.hightColor1.g, (arg_268_1.time_ - 0) / var_271_3), (Mathf.Lerp(iter_271_2.color.b, arg_268_1.hightColor1.b, (arg_268_1.time_ - 0) / var_271_3)))
							else
								local var_271_4 = Mathf.Lerp(iter_271_2.color.r, 1, (arg_268_1.time_ - 0) / var_271_3)

								iter_271_2.color = Color.New(var_271_4, var_271_4, var_271_4)
							end
						end
					end
				end
			end

			if arg_268_1.time_ >= 0 + var_271_3 and arg_268_1.time_ < 0 + var_271_3 + arg_271_0 and not isNil(var_271_2) and arg_268_1.var_.actorSpriteComps10094 then
				for iter_271_3, iter_271_4 in pairs(arg_268_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_271_4 then
						iter_271_4.color = arg_268_1.isInRecall_ and (arg_268_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_268_1.var_.actorSpriteComps10094 = nil
			end

			local var_271_5 = arg_268_1.actors_["10022"]

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 and not isNil(var_271_5) and arg_268_1.var_.actorSpriteComps10022 == nil then
				arg_268_1.var_.actorSpriteComps10022 = var_271_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_271_6 = 2

			if 0 <= arg_268_1.time_ and arg_268_1.time_ < 0 + var_271_6 and not isNil(var_271_5) then
				if arg_268_1.var_.actorSpriteComps10022 then
					for iter_271_5, iter_271_6 in pairs(arg_268_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_271_6 then
							if arg_268_1.isInRecall_ then
								iter_271_6.color = Color.New(Mathf.Lerp(iter_271_6.color.r, arg_268_1.hightColor2.r, (arg_268_1.time_ - 0) / var_271_6), Mathf.Lerp(iter_271_6.color.g, arg_268_1.hightColor2.g, (arg_268_1.time_ - 0) / var_271_6), (Mathf.Lerp(iter_271_6.color.b, arg_268_1.hightColor2.b, (arg_268_1.time_ - 0) / var_271_6)))
							else
								local var_271_7 = Mathf.Lerp(iter_271_6.color.r, 0.5, (arg_268_1.time_ - 0) / var_271_6)

								iter_271_6.color = Color.New(var_271_7, var_271_7, var_271_7)
							end
						end
					end
				end
			end

			if arg_268_1.time_ >= 0 + var_271_6 and arg_268_1.time_ < 0 + var_271_6 + arg_271_0 and not isNil(var_271_5) and arg_268_1.var_.actorSpriteComps10022 then
				for iter_271_7, iter_271_8 in pairs(arg_268_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_271_8 then
						iter_271_8.color = arg_268_1.isInRecall_ and (arg_268_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_268_1.var_.actorSpriteComps10022 = nil
			end

			local var_271_8 = 0
			local var_271_9 = 0.6

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= var_271_8 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0
				arg_268_1.dialogCg_.alpha = 1

				arg_268_1.dialog_:SetActive(true)
				SetActive(arg_268_1.leftNameGo_, true)

				arg_268_1.leftNameTxt_.text = arg_268_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_268_1.leftNameTxt_.transform)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1.leftNameTxt_.text)
				SetActive(arg_268_1.iconTrs_.gameObject, false)
				arg_268_1.callingController_:SetSelectedState("normal")

				local var_271_10 = arg_268_1:GetWordFromCfg(413041066)
				local var_271_11 = arg_268_1:FormatText(var_271_10.content)

				arg_268_1.text_.text = var_271_11

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_13 = 24 <= 0 and var_271_9 or var_271_9 * (utf8.len(var_271_11) / 24)

				if (24 <= 0 and var_271_9 or var_271_9 * (utf8.len(var_271_11) / 24)) > 0 and var_271_9 < var_271_13 then
					arg_268_1.talkMaxDuration = var_271_13

					if var_271_13 + var_271_8 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_13 + var_271_8
					end
				end

				arg_268_1.text_.text = var_271_11
				arg_268_1.typewritter.percent = 0

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413041", "413041066", "story_v_out_413041.awb") ~= 0 then
					local var_271_14 = manager.audio:GetVoiceLength("story_v_out_413041", "413041066", "story_v_out_413041.awb") / 1000

					if var_271_14 + var_271_8 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_14 + var_271_8
					end

					if var_271_10.prefab_name ~= "" and arg_268_1.actors_[var_271_10.prefab_name] ~= nil then
						local var_271_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_268_1.actors_[var_271_10.prefab_name].transform, "story_v_out_413041", "413041066", "story_v_out_413041.awb")

						arg_268_1:RecordAudio("413041066", var_271_15)
						arg_268_1:RecordAudio("413041066", var_271_15)
					else
						arg_268_1:AudioAction("play", "voice", "story_v_out_413041", "413041066", "story_v_out_413041.awb")
					end

					arg_268_1:RecordHistoryTalkVoice("story_v_out_413041", "413041066", "story_v_out_413041.awb")
				end

				arg_268_1:RecordContent(arg_268_1.text_.text)
			end

			local var_271_16 = math.max(var_271_9, arg_268_1.talkMaxDuration)

			if var_271_8 <= arg_268_1.time_ and arg_268_1.time_ < var_271_8 + var_271_16 then
				arg_268_1.typewritter.percent = (arg_268_1.time_ - var_271_8) / var_271_16

				arg_268_1.typewritter:SetDirty()
			end

			if arg_268_1.time_ >= var_271_8 + var_271_16 and arg_268_1.time_ < var_271_8 + var_271_16 + arg_271_0 then
				arg_268_1.typewritter.percent = 1

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(true)
			end
		end

		arg_268_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_268_1:InitPlayNodeList()
	end,
	Play413041067 = function(arg_272_0, arg_272_1)
		arg_272_1.time_ = 0
		arg_272_1.frameCnt_ = 0
		arg_272_1.state_ = "playing"
		arg_272_1.curTalkId_ = 413041067
		arg_272_1.duration_ = 6.37

		local var_272_0 = {
			zh = 3.733,
			ja = 6.366
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
				arg_272_0:Play413041068(arg_272_1)
			end
		end

		function arg_272_1.onSingleLineUpdate_(arg_275_0)
			local var_275_0 = 0.35

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 then
				arg_272_1.talkMaxDuration = 0
				arg_272_1.dialogCg_.alpha = 1

				arg_272_1.dialog_:SetActive(true)
				SetActive(arg_272_1.leftNameGo_, true)

				arg_272_1.leftNameTxt_.text = arg_272_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_272_1.leftNameTxt_.transform)

				arg_272_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_272_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_272_1:RecordName(arg_272_1.leftNameTxt_.text)
				SetActive(arg_272_1.iconTrs_.gameObject, false)
				arg_272_1.callingController_:SetSelectedState("normal")

				local var_275_1 = arg_272_1:GetWordFromCfg(413041067)
				local var_275_2 = arg_272_1:FormatText(var_275_1.content)

				arg_272_1.text_.text = var_275_2

				LuaForUtil.ClearLinePrefixSymbol(arg_272_1.text_)

				local var_275_4 = 14 <= 0 and var_275_0 or var_275_0 * (utf8.len(var_275_2) / 14)

				if (14 <= 0 and var_275_0 or var_275_0 * (utf8.len(var_275_2) / 14)) > 0 and var_275_0 < var_275_4 then
					arg_272_1.talkMaxDuration = var_275_4

					if var_275_4 + 0 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_4 + 0
					end
				end

				arg_272_1.text_.text = var_275_2
				arg_272_1.typewritter.percent = 0

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413041", "413041067", "story_v_out_413041.awb") ~= 0 then
					local var_275_5 = manager.audio:GetVoiceLength("story_v_out_413041", "413041067", "story_v_out_413041.awb") / 1000

					if var_275_5 + 0 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_5 + 0
					end

					if var_275_1.prefab_name ~= "" and arg_272_1.actors_[var_275_1.prefab_name] ~= nil then
						local var_275_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_272_1.actors_[var_275_1.prefab_name].transform, "story_v_out_413041", "413041067", "story_v_out_413041.awb")

						arg_272_1:RecordAudio("413041067", var_275_6)
						arg_272_1:RecordAudio("413041067", var_275_6)
					else
						arg_272_1:AudioAction("play", "voice", "story_v_out_413041", "413041067", "story_v_out_413041.awb")
					end

					arg_272_1:RecordHistoryTalkVoice("story_v_out_413041", "413041067", "story_v_out_413041.awb")
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
	Play413041068 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 413041068
		arg_276_1.duration_ = 4.9

		local var_276_0 = {
			zh = 2.2,
			ja = 4.9
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
				arg_276_0:Play413041069(arg_276_1)
			end
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 then
				arg_276_1.var_.moveOldPos10094 = arg_276_1.actors_["10094"].transform.localPosition
				arg_276_1.actors_["10094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_276_1:CheckSpriteTmpPos("10094", 0)

				for iter_279_0 = 0, arg_276_1.actors_["10094"].transform.childCount - 1 do
					local var_279_0 = arg_276_1.actors_["10094"].transform:GetChild(iter_279_0)

					if var_279_0.name == "" or not string.find(var_279_0.name, "split") then
						var_279_0.gameObject:SetActive(true)
					else
						var_279_0.gameObject:SetActive(false)
					end
				end
			end

			local var_279_1 = 0.001

			if 0 <= arg_276_1.time_ and arg_276_1.time_ < 0 + var_279_1 then
				arg_276_1.actors_["10094"].transform.localPosition = Vector3.Lerp(arg_276_1.var_.moveOldPos10094, Vector3.New(-5000, -340, -414), (arg_276_1.time_ - 0) / var_279_1)
			end

			if arg_276_1.time_ >= 0 + var_279_1 and arg_276_1.time_ < 0 + var_279_1 + arg_279_0 then
				arg_276_1.actors_["10094"].transform.localPosition = Vector3.New(-5000, -340, -414)
			end

			local var_279_2 = arg_276_1.actors_["10022"].transform

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 then
				arg_276_1.var_.moveOldPos10022 = var_279_2.localPosition
				var_279_2.localScale = Vector3.New(1, 1, 1)

				arg_276_1:CheckSpriteTmpPos("10022", 0)

				for iter_279_1 = 0, var_279_2.childCount - 1 do
					local var_279_3 = var_279_2:GetChild(iter_279_1)

					if var_279_3.name == "" or not string.find(var_279_3.name, "split") then
						var_279_3.gameObject:SetActive(true)
					else
						var_279_3.gameObject:SetActive(false)
					end
				end
			end

			local var_279_4 = 0.001

			if 0 <= arg_276_1.time_ and arg_276_1.time_ < 0 + var_279_4 then
				var_279_2.localPosition = Vector3.Lerp(arg_276_1.var_.moveOldPos10022, Vector3.New(-1500, -350, -180), (arg_276_1.time_ - 0) / var_279_4)
			end

			if arg_276_1.time_ >= 0 + var_279_4 and arg_276_1.time_ < 0 + var_279_4 + arg_279_0 then
				var_279_2.localPosition = Vector3.New(-1500, -350, -180)
			end

			local var_279_5 = arg_276_1.actors_["10092"].transform

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 then
				arg_276_1.var_.moveOldPos10092 = var_279_5.localPosition
				var_279_5.localScale = Vector3.New(1, 1, 1)

				arg_276_1:CheckSpriteTmpPos("10092", 3)

				for iter_279_2 = 0, var_279_5.childCount - 1 do
					local var_279_6 = var_279_5:GetChild(iter_279_2)

					if var_279_6.name == "split_2" or not string.find(var_279_6.name, "split") then
						var_279_6.gameObject:SetActive(true)
					else
						var_279_6.gameObject:SetActive(false)
					end
				end
			end

			local var_279_7 = 0.001

			if 0 <= arg_276_1.time_ and arg_276_1.time_ < 0 + var_279_7 then
				var_279_5.localPosition = Vector3.Lerp(arg_276_1.var_.moveOldPos10092, Vector3.New(0, -300, -295), (arg_276_1.time_ - 0) / var_279_7)
			end

			if arg_276_1.time_ >= 0 + var_279_7 and arg_276_1.time_ < 0 + var_279_7 + arg_279_0 then
				var_279_5.localPosition = Vector3.New(0, -300, -295)
			end

			local var_279_8 = arg_276_1.actors_["10094"]

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 and not isNil(var_279_8) and arg_276_1.var_.actorSpriteComps10094 == nil then
				arg_276_1.var_.actorSpriteComps10094 = var_279_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_279_9 = 2

			if 0 <= arg_276_1.time_ and arg_276_1.time_ < 0 + var_279_9 and not isNil(var_279_8) then
				if arg_276_1.var_.actorSpriteComps10094 then
					for iter_279_3, iter_279_4 in pairs(arg_276_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_279_4 then
							if arg_276_1.isInRecall_ then
								iter_279_4.color = Color.New(Mathf.Lerp(iter_279_4.color.r, arg_276_1.hightColor2.r, (arg_276_1.time_ - 0) / var_279_9), Mathf.Lerp(iter_279_4.color.g, arg_276_1.hightColor2.g, (arg_276_1.time_ - 0) / var_279_9), (Mathf.Lerp(iter_279_4.color.b, arg_276_1.hightColor2.b, (arg_276_1.time_ - 0) / var_279_9)))
							else
								local var_279_10 = Mathf.Lerp(iter_279_4.color.r, 0.5, (arg_276_1.time_ - 0) / var_279_9)

								iter_279_4.color = Color.New(var_279_10, var_279_10, var_279_10)
							end
						end
					end
				end
			end

			if arg_276_1.time_ >= 0 + var_279_9 and arg_276_1.time_ < 0 + var_279_9 + arg_279_0 and not isNil(var_279_8) and arg_276_1.var_.actorSpriteComps10094 then
				for iter_279_5, iter_279_6 in pairs(arg_276_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_279_6 then
						iter_279_6.color = arg_276_1.isInRecall_ and (arg_276_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_276_1.var_.actorSpriteComps10094 = nil
			end

			local var_279_11 = arg_276_1.actors_["10022"]

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 and not isNil(var_279_11) and arg_276_1.var_.actorSpriteComps10022 == nil then
				arg_276_1.var_.actorSpriteComps10022 = var_279_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_279_12 = 2

			if 0 <= arg_276_1.time_ and arg_276_1.time_ < 0 + var_279_12 and not isNil(var_279_11) then
				if arg_276_1.var_.actorSpriteComps10022 then
					for iter_279_7, iter_279_8 in pairs(arg_276_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_279_8 then
							if arg_276_1.isInRecall_ then
								iter_279_8.color = Color.New(Mathf.Lerp(iter_279_8.color.r, arg_276_1.hightColor2.r, (arg_276_1.time_ - 0) / var_279_12), Mathf.Lerp(iter_279_8.color.g, arg_276_1.hightColor2.g, (arg_276_1.time_ - 0) / var_279_12), (Mathf.Lerp(iter_279_8.color.b, arg_276_1.hightColor2.b, (arg_276_1.time_ - 0) / var_279_12)))
							else
								local var_279_13 = Mathf.Lerp(iter_279_8.color.r, 0.5, (arg_276_1.time_ - 0) / var_279_12)

								iter_279_8.color = Color.New(var_279_13, var_279_13, var_279_13)
							end
						end
					end
				end
			end

			if arg_276_1.time_ >= 0 + var_279_12 and arg_276_1.time_ < 0 + var_279_12 + arg_279_0 and not isNil(var_279_11) and arg_276_1.var_.actorSpriteComps10022 then
				for iter_279_9, iter_279_10 in pairs(arg_276_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_279_10 then
						iter_279_10.color = arg_276_1.isInRecall_ and (arg_276_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_276_1.var_.actorSpriteComps10022 = nil
			end

			local var_279_14 = arg_276_1.actors_["10092"]

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 and not isNil(var_279_14) and arg_276_1.var_.actorSpriteComps10092 == nil then
				arg_276_1.var_.actorSpriteComps10092 = var_279_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_279_15 = 2

			if 0 <= arg_276_1.time_ and arg_276_1.time_ < 0 + var_279_15 and not isNil(var_279_14) then
				if arg_276_1.var_.actorSpriteComps10092 then
					for iter_279_11, iter_279_12 in pairs(arg_276_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_279_12 then
							if arg_276_1.isInRecall_ then
								iter_279_12.color = Color.New(Mathf.Lerp(iter_279_12.color.r, arg_276_1.hightColor1.r, (arg_276_1.time_ - 0) / var_279_15), Mathf.Lerp(iter_279_12.color.g, arg_276_1.hightColor1.g, (arg_276_1.time_ - 0) / var_279_15), (Mathf.Lerp(iter_279_12.color.b, arg_276_1.hightColor1.b, (arg_276_1.time_ - 0) / var_279_15)))
							else
								local var_279_16 = Mathf.Lerp(iter_279_12.color.r, 1, (arg_276_1.time_ - 0) / var_279_15)

								iter_279_12.color = Color.New(var_279_16, var_279_16, var_279_16)
							end
						end
					end
				end
			end

			if arg_276_1.time_ >= 0 + var_279_15 and arg_276_1.time_ < 0 + var_279_15 + arg_279_0 and not isNil(var_279_14) and arg_276_1.var_.actorSpriteComps10092 then
				for iter_279_13, iter_279_14 in pairs(arg_276_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_279_14 then
						iter_279_14.color = arg_276_1.isInRecall_ and (arg_276_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_276_1.var_.actorSpriteComps10092 = nil
			end

			local var_279_17 = 0
			local var_279_18 = 0.3

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= var_279_17 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0
				arg_276_1.dialogCg_.alpha = 1

				arg_276_1.dialog_:SetActive(true)
				SetActive(arg_276_1.leftNameGo_, true)

				arg_276_1.leftNameTxt_.text = arg_276_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_276_1.leftNameTxt_.transform)

				arg_276_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_276_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_276_1:RecordName(arg_276_1.leftNameTxt_.text)
				SetActive(arg_276_1.iconTrs_.gameObject, false)
				arg_276_1.callingController_:SetSelectedState("normal")

				local var_279_19 = arg_276_1:GetWordFromCfg(413041068)
				local var_279_20 = arg_276_1:FormatText(var_279_19.content)

				arg_276_1.text_.text = var_279_20

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_22 = 12 <= 0 and var_279_18 or var_279_18 * (utf8.len(var_279_20) / 12)

				if (12 <= 0 and var_279_18 or var_279_18 * (utf8.len(var_279_20) / 12)) > 0 and var_279_18 < var_279_22 then
					arg_276_1.talkMaxDuration = var_279_22

					if var_279_22 + var_279_17 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_22 + var_279_17
					end
				end

				arg_276_1.text_.text = var_279_20
				arg_276_1.typewritter.percent = 0

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413041", "413041068", "story_v_out_413041.awb") ~= 0 then
					local var_279_23 = manager.audio:GetVoiceLength("story_v_out_413041", "413041068", "story_v_out_413041.awb") / 1000

					if var_279_23 + var_279_17 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_23 + var_279_17
					end

					if var_279_19.prefab_name ~= "" and arg_276_1.actors_[var_279_19.prefab_name] ~= nil then
						local var_279_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_276_1.actors_[var_279_19.prefab_name].transform, "story_v_out_413041", "413041068", "story_v_out_413041.awb")

						arg_276_1:RecordAudio("413041068", var_279_24)
						arg_276_1:RecordAudio("413041068", var_279_24)
					else
						arg_276_1:AudioAction("play", "voice", "story_v_out_413041", "413041068", "story_v_out_413041.awb")
					end

					arg_276_1:RecordHistoryTalkVoice("story_v_out_413041", "413041068", "story_v_out_413041.awb")
				end

				arg_276_1:RecordContent(arg_276_1.text_.text)
			end

			local var_279_25 = math.max(var_279_18, arg_276_1.talkMaxDuration)

			if var_279_17 <= arg_276_1.time_ and arg_276_1.time_ < var_279_17 + var_279_25 then
				arg_276_1.typewritter.percent = (arg_276_1.time_ - var_279_17) / var_279_25

				arg_276_1.typewritter:SetDirty()
			end

			if arg_276_1.time_ >= var_279_17 + var_279_25 and arg_276_1.time_ < var_279_17 + var_279_25 + arg_279_0 then
				arg_276_1.typewritter.percent = 1

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(true)
			end
		end

		arg_276_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10092",
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
	Play413041069 = function(arg_280_0, arg_280_1)
		arg_280_1.time_ = 0
		arg_280_1.frameCnt_ = 0
		arg_280_1.state_ = "playing"
		arg_280_1.curTalkId_ = 413041069
		arg_280_1.duration_ = 6.47

		local var_280_0 = {
			zh = 2.2,
			ja = 6.466
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
				arg_280_0:Play413041070(arg_280_1)
			end
		end

		function arg_280_1.onSingleLineUpdate_(arg_283_0)
			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 then
				arg_280_1.var_.moveOldPos10094 = arg_280_1.actors_["10094"].transform.localPosition
				arg_280_1.actors_["10094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_280_1:CheckSpriteTmpPos("10094", 4)

				for iter_283_0 = 0, arg_280_1.actors_["10094"].transform.childCount - 1 do
					local var_283_0 = arg_280_1.actors_["10094"].transform:GetChild(iter_283_0)

					if var_283_0.name == "" or not string.find(var_283_0.name, "split") then
						var_283_0.gameObject:SetActive(true)
					else
						var_283_0.gameObject:SetActive(false)
					end
				end
			end

			local var_283_1 = 0.001

			if 0 <= arg_280_1.time_ and arg_280_1.time_ < 0 + var_283_1 then
				arg_280_1.actors_["10094"].transform.localPosition = Vector3.Lerp(arg_280_1.var_.moveOldPos10094, Vector3.New(390, -340, -414), (arg_280_1.time_ - 0) / var_283_1)
			end

			if arg_280_1.time_ >= 0 + var_283_1 and arg_280_1.time_ < 0 + var_283_1 + arg_283_0 then
				arg_280_1.actors_["10094"].transform.localPosition = Vector3.New(390, -340, -414)
			end

			local var_283_2 = arg_280_1.actors_["10092"].transform

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 then
				arg_280_1.var_.moveOldPos10092 = var_283_2.localPosition
				var_283_2.localScale = Vector3.New(1, 1, 1)

				arg_280_1:CheckSpriteTmpPos("10092", 2)

				for iter_283_1 = 0, var_283_2.childCount - 1 do
					local var_283_3 = var_283_2:GetChild(iter_283_1)

					if var_283_3.name == "" or not string.find(var_283_3.name, "split") then
						var_283_3.gameObject:SetActive(true)
					else
						var_283_3.gameObject:SetActive(false)
					end
				end
			end

			local var_283_4 = 0.001

			if 0 <= arg_280_1.time_ and arg_280_1.time_ < 0 + var_283_4 then
				var_283_2.localPosition = Vector3.Lerp(arg_280_1.var_.moveOldPos10092, Vector3.New(-389.49, -300, -295), (arg_280_1.time_ - 0) / var_283_4)
			end

			if arg_280_1.time_ >= 0 + var_283_4 and arg_280_1.time_ < 0 + var_283_4 + arg_283_0 then
				var_283_2.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_283_5 = arg_280_1.actors_["10094"]

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 and not isNil(var_283_5) and arg_280_1.var_.actorSpriteComps10094 == nil then
				arg_280_1.var_.actorSpriteComps10094 = var_283_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_283_6 = 2

			if 0 <= arg_280_1.time_ and arg_280_1.time_ < 0 + var_283_6 and not isNil(var_283_5) then
				if arg_280_1.var_.actorSpriteComps10094 then
					for iter_283_2, iter_283_3 in pairs(arg_280_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_283_3 then
							if arg_280_1.isInRecall_ then
								iter_283_3.color = Color.New(Mathf.Lerp(iter_283_3.color.r, arg_280_1.hightColor1.r, (arg_280_1.time_ - 0) / var_283_6), Mathf.Lerp(iter_283_3.color.g, arg_280_1.hightColor1.g, (arg_280_1.time_ - 0) / var_283_6), (Mathf.Lerp(iter_283_3.color.b, arg_280_1.hightColor1.b, (arg_280_1.time_ - 0) / var_283_6)))
							else
								local var_283_7 = Mathf.Lerp(iter_283_3.color.r, 1, (arg_280_1.time_ - 0) / var_283_6)

								iter_283_3.color = Color.New(var_283_7, var_283_7, var_283_7)
							end
						end
					end
				end
			end

			if arg_280_1.time_ >= 0 + var_283_6 and arg_280_1.time_ < 0 + var_283_6 + arg_283_0 and not isNil(var_283_5) and arg_280_1.var_.actorSpriteComps10094 then
				for iter_283_4, iter_283_5 in pairs(arg_280_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_283_5 then
						iter_283_5.color = arg_280_1.isInRecall_ and (arg_280_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_280_1.var_.actorSpriteComps10094 = nil
			end

			local var_283_8 = arg_280_1.actors_["10092"]

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 and not isNil(var_283_8) and arg_280_1.var_.actorSpriteComps10092 == nil then
				arg_280_1.var_.actorSpriteComps10092 = var_283_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_283_9 = 2

			if 0 <= arg_280_1.time_ and arg_280_1.time_ < 0 + var_283_9 and not isNil(var_283_8) then
				if arg_280_1.var_.actorSpriteComps10092 then
					for iter_283_6, iter_283_7 in pairs(arg_280_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_283_7 then
							if arg_280_1.isInRecall_ then
								iter_283_7.color = Color.New(Mathf.Lerp(iter_283_7.color.r, arg_280_1.hightColor2.r, (arg_280_1.time_ - 0) / var_283_9), Mathf.Lerp(iter_283_7.color.g, arg_280_1.hightColor2.g, (arg_280_1.time_ - 0) / var_283_9), (Mathf.Lerp(iter_283_7.color.b, arg_280_1.hightColor2.b, (arg_280_1.time_ - 0) / var_283_9)))
							else
								local var_283_10 = Mathf.Lerp(iter_283_7.color.r, 0.5, (arg_280_1.time_ - 0) / var_283_9)

								iter_283_7.color = Color.New(var_283_10, var_283_10, var_283_10)
							end
						end
					end
				end
			end

			if arg_280_1.time_ >= 0 + var_283_9 and arg_280_1.time_ < 0 + var_283_9 + arg_283_0 and not isNil(var_283_8) and arg_280_1.var_.actorSpriteComps10092 then
				for iter_283_8, iter_283_9 in pairs(arg_280_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_283_9 then
						iter_283_9.color = arg_280_1.isInRecall_ and (arg_280_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_280_1.var_.actorSpriteComps10092 = nil
			end

			local var_283_11 = 0
			local var_283_12 = 0.275

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= var_283_11 + arg_283_0 then
				arg_280_1.talkMaxDuration = 0
				arg_280_1.dialogCg_.alpha = 1

				arg_280_1.dialog_:SetActive(true)
				SetActive(arg_280_1.leftNameGo_, true)

				arg_280_1.leftNameTxt_.text = arg_280_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_280_1.leftNameTxt_.transform)

				arg_280_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_280_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_280_1:RecordName(arg_280_1.leftNameTxt_.text)
				SetActive(arg_280_1.iconTrs_.gameObject, false)
				arg_280_1.callingController_:SetSelectedState("normal")

				local var_283_13 = arg_280_1:GetWordFromCfg(413041069)
				local var_283_14 = arg_280_1:FormatText(var_283_13.content)

				arg_280_1.text_.text = var_283_14

				LuaForUtil.ClearLinePrefixSymbol(arg_280_1.text_)

				local var_283_16 = 11 <= 0 and var_283_12 or var_283_12 * (utf8.len(var_283_14) / 11)

				if (11 <= 0 and var_283_12 or var_283_12 * (utf8.len(var_283_14) / 11)) > 0 and var_283_12 < var_283_16 then
					arg_280_1.talkMaxDuration = var_283_16

					if var_283_16 + var_283_11 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_16 + var_283_11
					end
				end

				arg_280_1.text_.text = var_283_14
				arg_280_1.typewritter.percent = 0

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413041", "413041069", "story_v_out_413041.awb") ~= 0 then
					local var_283_17 = manager.audio:GetVoiceLength("story_v_out_413041", "413041069", "story_v_out_413041.awb") / 1000

					if var_283_17 + var_283_11 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_17 + var_283_11
					end

					if var_283_13.prefab_name ~= "" and arg_280_1.actors_[var_283_13.prefab_name] ~= nil then
						local var_283_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_280_1.actors_[var_283_13.prefab_name].transform, "story_v_out_413041", "413041069", "story_v_out_413041.awb")

						arg_280_1:RecordAudio("413041069", var_283_18)
						arg_280_1:RecordAudio("413041069", var_283_18)
					else
						arg_280_1:AudioAction("play", "voice", "story_v_out_413041", "413041069", "story_v_out_413041.awb")
					end

					arg_280_1:RecordHistoryTalkVoice("story_v_out_413041", "413041069", "story_v_out_413041.awb")
				end

				arg_280_1:RecordContent(arg_280_1.text_.text)
			end

			local var_283_19 = math.max(var_283_12, arg_280_1.talkMaxDuration)

			if var_283_11 <= arg_280_1.time_ and arg_280_1.time_ < var_283_11 + var_283_19 then
				arg_280_1.typewritter.percent = (arg_280_1.time_ - var_283_11) / var_283_19

				arg_280_1.typewritter:SetDirty()
			end

			if arg_280_1.time_ >= var_283_11 + var_283_19 and arg_280_1.time_ < var_283_11 + var_283_19 + arg_283_0 then
				arg_280_1.typewritter.percent = 1

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(true)
			end
		end

		arg_280_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_280_1:InitPlayNodeList()
	end,
	Play413041070 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 413041070
		arg_284_1.duration_ = 12.1

		local var_284_0 = {
			zh = 5.366,
			ja = 12.1
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
				arg_284_0:Play413041071(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 then
				arg_284_1.var_.moveOldPos10094 = arg_284_1.actors_["10094"].transform.localPosition
				arg_284_1.actors_["10094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_284_1:CheckSpriteTmpPos("10094", 4)

				for iter_287_0 = 0, arg_284_1.actors_["10094"].transform.childCount - 1 do
					local var_287_0 = arg_284_1.actors_["10094"].transform:GetChild(iter_287_0)

					if var_287_0.name == "" or not string.find(var_287_0.name, "split") then
						var_287_0.gameObject:SetActive(true)
					else
						var_287_0.gameObject:SetActive(false)
					end
				end
			end

			local var_287_1 = 0.001

			if 0 <= arg_284_1.time_ and arg_284_1.time_ < 0 + var_287_1 then
				arg_284_1.actors_["10094"].transform.localPosition = Vector3.Lerp(arg_284_1.var_.moveOldPos10094, Vector3.New(390, -340, -414), (arg_284_1.time_ - 0) / var_287_1)
			end

			if arg_284_1.time_ >= 0 + var_287_1 and arg_284_1.time_ < 0 + var_287_1 + arg_287_0 then
				arg_284_1.actors_["10094"].transform.localPosition = Vector3.New(390, -340, -414)
			end

			local var_287_2 = arg_284_1.actors_["10092"].transform

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 then
				arg_284_1.var_.moveOldPos10092 = var_287_2.localPosition
				var_287_2.localScale = Vector3.New(1, 1, 1)

				arg_284_1:CheckSpriteTmpPos("10092", 2)

				for iter_287_1 = 0, var_287_2.childCount - 1 do
					local var_287_3 = var_287_2:GetChild(iter_287_1)

					if var_287_3.name == "" or not string.find(var_287_3.name, "split") then
						var_287_3.gameObject:SetActive(true)
					else
						var_287_3.gameObject:SetActive(false)
					end
				end
			end

			local var_287_4 = 0.001

			if 0 <= arg_284_1.time_ and arg_284_1.time_ < 0 + var_287_4 then
				var_287_2.localPosition = Vector3.Lerp(arg_284_1.var_.moveOldPos10092, Vector3.New(-389.49, -300, -295), (arg_284_1.time_ - 0) / var_287_4)
			end

			if arg_284_1.time_ >= 0 + var_287_4 and arg_284_1.time_ < 0 + var_287_4 + arg_287_0 then
				var_287_2.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_287_5 = arg_284_1.actors_["10094"]

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 and not isNil(var_287_5) and arg_284_1.var_.actorSpriteComps10094 == nil then
				arg_284_1.var_.actorSpriteComps10094 = var_287_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_287_6 = 2

			if 0 <= arg_284_1.time_ and arg_284_1.time_ < 0 + var_287_6 and not isNil(var_287_5) then
				if arg_284_1.var_.actorSpriteComps10094 then
					for iter_287_2, iter_287_3 in pairs(arg_284_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_287_3 then
							if arg_284_1.isInRecall_ then
								iter_287_3.color = Color.New(Mathf.Lerp(iter_287_3.color.r, arg_284_1.hightColor2.r, (arg_284_1.time_ - 0) / var_287_6), Mathf.Lerp(iter_287_3.color.g, arg_284_1.hightColor2.g, (arg_284_1.time_ - 0) / var_287_6), (Mathf.Lerp(iter_287_3.color.b, arg_284_1.hightColor2.b, (arg_284_1.time_ - 0) / var_287_6)))
							else
								local var_287_7 = Mathf.Lerp(iter_287_3.color.r, 0.5, (arg_284_1.time_ - 0) / var_287_6)

								iter_287_3.color = Color.New(var_287_7, var_287_7, var_287_7)
							end
						end
					end
				end
			end

			if arg_284_1.time_ >= 0 + var_287_6 and arg_284_1.time_ < 0 + var_287_6 + arg_287_0 and not isNil(var_287_5) and arg_284_1.var_.actorSpriteComps10094 then
				for iter_287_4, iter_287_5 in pairs(arg_284_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_287_5 then
						iter_287_5.color = arg_284_1.isInRecall_ and (arg_284_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_284_1.var_.actorSpriteComps10094 = nil
			end

			local var_287_8 = arg_284_1.actors_["10092"]

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 and not isNil(var_287_8) and arg_284_1.var_.actorSpriteComps10092 == nil then
				arg_284_1.var_.actorSpriteComps10092 = var_287_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_287_9 = 2

			if 0 <= arg_284_1.time_ and arg_284_1.time_ < 0 + var_287_9 and not isNil(var_287_8) then
				if arg_284_1.var_.actorSpriteComps10092 then
					for iter_287_6, iter_287_7 in pairs(arg_284_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_287_7 then
							if arg_284_1.isInRecall_ then
								iter_287_7.color = Color.New(Mathf.Lerp(iter_287_7.color.r, arg_284_1.hightColor1.r, (arg_284_1.time_ - 0) / var_287_9), Mathf.Lerp(iter_287_7.color.g, arg_284_1.hightColor1.g, (arg_284_1.time_ - 0) / var_287_9), (Mathf.Lerp(iter_287_7.color.b, arg_284_1.hightColor1.b, (arg_284_1.time_ - 0) / var_287_9)))
							else
								local var_287_10 = Mathf.Lerp(iter_287_7.color.r, 1, (arg_284_1.time_ - 0) / var_287_9)

								iter_287_7.color = Color.New(var_287_10, var_287_10, var_287_10)
							end
						end
					end
				end
			end

			if arg_284_1.time_ >= 0 + var_287_9 and arg_284_1.time_ < 0 + var_287_9 + arg_287_0 and not isNil(var_287_8) and arg_284_1.var_.actorSpriteComps10092 then
				for iter_287_8, iter_287_9 in pairs(arg_284_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_287_9 then
						iter_287_9.color = arg_284_1.isInRecall_ and (arg_284_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_284_1.var_.actorSpriteComps10092 = nil
			end

			local var_287_11 = 0
			local var_287_12 = 0.65

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= var_287_11 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0
				arg_284_1.dialogCg_.alpha = 1

				arg_284_1.dialog_:SetActive(true)
				SetActive(arg_284_1.leftNameGo_, true)

				arg_284_1.leftNameTxt_.text = arg_284_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_284_1.leftNameTxt_.transform)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1.leftNameTxt_.text)
				SetActive(arg_284_1.iconTrs_.gameObject, false)
				arg_284_1.callingController_:SetSelectedState("normal")

				local var_287_13 = arg_284_1:GetWordFromCfg(413041070)
				local var_287_14 = arg_284_1:FormatText(var_287_13.content)

				arg_284_1.text_.text = var_287_14

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_16 = 26 <= 0 and var_287_12 or var_287_12 * (utf8.len(var_287_14) / 26)

				if (26 <= 0 and var_287_12 or var_287_12 * (utf8.len(var_287_14) / 26)) > 0 and var_287_12 < var_287_16 then
					arg_284_1.talkMaxDuration = var_287_16

					if var_287_16 + var_287_11 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_16 + var_287_11
					end
				end

				arg_284_1.text_.text = var_287_14
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413041", "413041070", "story_v_out_413041.awb") ~= 0 then
					local var_287_17 = manager.audio:GetVoiceLength("story_v_out_413041", "413041070", "story_v_out_413041.awb") / 1000

					if var_287_17 + var_287_11 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_17 + var_287_11
					end

					if var_287_13.prefab_name ~= "" and arg_284_1.actors_[var_287_13.prefab_name] ~= nil then
						local var_287_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_284_1.actors_[var_287_13.prefab_name].transform, "story_v_out_413041", "413041070", "story_v_out_413041.awb")

						arg_284_1:RecordAudio("413041070", var_287_18)
						arg_284_1:RecordAudio("413041070", var_287_18)
					else
						arg_284_1:AudioAction("play", "voice", "story_v_out_413041", "413041070", "story_v_out_413041.awb")
					end

					arg_284_1:RecordHistoryTalkVoice("story_v_out_413041", "413041070", "story_v_out_413041.awb")
				end

				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_19 = math.max(var_287_12, arg_284_1.talkMaxDuration)

			if var_287_11 <= arg_284_1.time_ and arg_284_1.time_ < var_287_11 + var_287_19 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - var_287_11) / var_287_19

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= var_287_11 + var_287_19 and arg_284_1.time_ < var_287_11 + var_287_19 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_284_1:InitPlayNodeList()
	end,
	Play413041071 = function(arg_288_0, arg_288_1)
		arg_288_1.time_ = 0
		arg_288_1.frameCnt_ = 0
		arg_288_1.state_ = "playing"
		arg_288_1.curTalkId_ = 413041071
		arg_288_1.duration_ = 7.7

		local var_288_0 = {
			zh = 7.2,
			ja = 7.7
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
				arg_288_0:Play413041072(arg_288_1)
			end
		end

		function arg_288_1.onSingleLineUpdate_(arg_291_0)
			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 then
				arg_288_1.var_.moveOldPos10094 = arg_288_1.actors_["10094"].transform.localPosition
				arg_288_1.actors_["10094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_288_1:CheckSpriteTmpPos("10094", 0)

				for iter_291_0 = 0, arg_288_1.actors_["10094"].transform.childCount - 1 do
					local var_291_0 = arg_288_1.actors_["10094"].transform:GetChild(iter_291_0)

					if var_291_0.name == "" or not string.find(var_291_0.name, "split") then
						var_291_0.gameObject:SetActive(true)
					else
						var_291_0.gameObject:SetActive(false)
					end
				end
			end

			local var_291_1 = 0.001

			if 0 <= arg_288_1.time_ and arg_288_1.time_ < 0 + var_291_1 then
				arg_288_1.actors_["10094"].transform.localPosition = Vector3.Lerp(arg_288_1.var_.moveOldPos10094, Vector3.New(-5000, -340, -414), (arg_288_1.time_ - 0) / var_291_1)
			end

			if arg_288_1.time_ >= 0 + var_291_1 and arg_288_1.time_ < 0 + var_291_1 + arg_291_0 then
				arg_288_1.actors_["10094"].transform.localPosition = Vector3.New(-5000, -340, -414)
			end

			local var_291_2 = arg_288_1.actors_["10092"].transform

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 then
				arg_288_1.var_.moveOldPos10092 = var_291_2.localPosition
				var_291_2.localScale = Vector3.New(1, 1, 1)

				arg_288_1:CheckSpriteTmpPos("10092", 0)

				for iter_291_1 = 0, var_291_2.childCount - 1 do
					local var_291_3 = var_291_2:GetChild(iter_291_1)

					if var_291_3.name == "" or not string.find(var_291_3.name, "split") then
						var_291_3.gameObject:SetActive(true)
					else
						var_291_3.gameObject:SetActive(false)
					end
				end
			end

			local var_291_4 = 0.001

			if 0 <= arg_288_1.time_ and arg_288_1.time_ < 0 + var_291_4 then
				var_291_2.localPosition = Vector3.Lerp(arg_288_1.var_.moveOldPos10092, Vector3.New(0, -5000, 0), (arg_288_1.time_ - 0) / var_291_4)
			end

			if arg_288_1.time_ >= 0 + var_291_4 and arg_288_1.time_ < 0 + var_291_4 + arg_291_0 then
				var_291_2.localPosition = Vector3.New(0, -5000, 0)
			end

			local var_291_5 = arg_288_1.actors_["10022"].transform

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 then
				arg_288_1.var_.moveOldPos10022 = var_291_5.localPosition
				var_291_5.localScale = Vector3.New(1, 1, 1)

				arg_288_1:CheckSpriteTmpPos("10022", 3)

				for iter_291_2 = 0, var_291_5.childCount - 1 do
					local var_291_6 = var_291_5:GetChild(iter_291_2)

					if var_291_6.name == "" or not string.find(var_291_6.name, "split") then
						var_291_6.gameObject:SetActive(true)
					else
						var_291_6.gameObject:SetActive(false)
					end
				end
			end

			local var_291_7 = 0.001

			if 0 <= arg_288_1.time_ and arg_288_1.time_ < 0 + var_291_7 then
				var_291_5.localPosition = Vector3.Lerp(arg_288_1.var_.moveOldPos10022, Vector3.New(0, -315, -320), (arg_288_1.time_ - 0) / var_291_7)
			end

			if arg_288_1.time_ >= 0 + var_291_7 and arg_288_1.time_ < 0 + var_291_7 + arg_291_0 then
				var_291_5.localPosition = Vector3.New(0, -315, -320)
			end

			local var_291_8 = arg_288_1.actors_["10094"]

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 and not isNil(var_291_8) and arg_288_1.var_.actorSpriteComps10094 == nil then
				arg_288_1.var_.actorSpriteComps10094 = var_291_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_291_9 = 2

			if 0 <= arg_288_1.time_ and arg_288_1.time_ < 0 + var_291_9 and not isNil(var_291_8) then
				if arg_288_1.var_.actorSpriteComps10094 then
					for iter_291_3, iter_291_4 in pairs(arg_288_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_291_4 then
							if arg_288_1.isInRecall_ then
								iter_291_4.color = Color.New(Mathf.Lerp(iter_291_4.color.r, arg_288_1.hightColor2.r, (arg_288_1.time_ - 0) / var_291_9), Mathf.Lerp(iter_291_4.color.g, arg_288_1.hightColor2.g, (arg_288_1.time_ - 0) / var_291_9), (Mathf.Lerp(iter_291_4.color.b, arg_288_1.hightColor2.b, (arg_288_1.time_ - 0) / var_291_9)))
							else
								local var_291_10 = Mathf.Lerp(iter_291_4.color.r, 0.5, (arg_288_1.time_ - 0) / var_291_9)

								iter_291_4.color = Color.New(var_291_10, var_291_10, var_291_10)
							end
						end
					end
				end
			end

			if arg_288_1.time_ >= 0 + var_291_9 and arg_288_1.time_ < 0 + var_291_9 + arg_291_0 and not isNil(var_291_8) and arg_288_1.var_.actorSpriteComps10094 then
				for iter_291_5, iter_291_6 in pairs(arg_288_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_291_6 then
						iter_291_6.color = arg_288_1.isInRecall_ and (arg_288_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_288_1.var_.actorSpriteComps10094 = nil
			end

			local var_291_11 = arg_288_1.actors_["10092"]

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 and not isNil(var_291_11) and arg_288_1.var_.actorSpriteComps10092 == nil then
				arg_288_1.var_.actorSpriteComps10092 = var_291_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_291_12 = 2

			if 0 <= arg_288_1.time_ and arg_288_1.time_ < 0 + var_291_12 and not isNil(var_291_11) then
				if arg_288_1.var_.actorSpriteComps10092 then
					for iter_291_7, iter_291_8 in pairs(arg_288_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_291_8 then
							if arg_288_1.isInRecall_ then
								iter_291_8.color = Color.New(Mathf.Lerp(iter_291_8.color.r, arg_288_1.hightColor2.r, (arg_288_1.time_ - 0) / var_291_12), Mathf.Lerp(iter_291_8.color.g, arg_288_1.hightColor2.g, (arg_288_1.time_ - 0) / var_291_12), (Mathf.Lerp(iter_291_8.color.b, arg_288_1.hightColor2.b, (arg_288_1.time_ - 0) / var_291_12)))
							else
								local var_291_13 = Mathf.Lerp(iter_291_8.color.r, 0.5, (arg_288_1.time_ - 0) / var_291_12)

								iter_291_8.color = Color.New(var_291_13, var_291_13, var_291_13)
							end
						end
					end
				end
			end

			if arg_288_1.time_ >= 0 + var_291_12 and arg_288_1.time_ < 0 + var_291_12 + arg_291_0 and not isNil(var_291_11) and arg_288_1.var_.actorSpriteComps10092 then
				for iter_291_9, iter_291_10 in pairs(arg_288_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_291_10 then
						iter_291_10.color = arg_288_1.isInRecall_ and (arg_288_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_288_1.var_.actorSpriteComps10092 = nil
			end

			local var_291_14 = arg_288_1.actors_["10022"]

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 and not isNil(var_291_14) and arg_288_1.var_.actorSpriteComps10022 == nil then
				arg_288_1.var_.actorSpriteComps10022 = var_291_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_291_15 = 2

			if 0 <= arg_288_1.time_ and arg_288_1.time_ < 0 + var_291_15 and not isNil(var_291_14) then
				if arg_288_1.var_.actorSpriteComps10022 then
					for iter_291_11, iter_291_12 in pairs(arg_288_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_291_12 then
							if arg_288_1.isInRecall_ then
								iter_291_12.color = Color.New(Mathf.Lerp(iter_291_12.color.r, arg_288_1.hightColor1.r, (arg_288_1.time_ - 0) / var_291_15), Mathf.Lerp(iter_291_12.color.g, arg_288_1.hightColor1.g, (arg_288_1.time_ - 0) / var_291_15), (Mathf.Lerp(iter_291_12.color.b, arg_288_1.hightColor1.b, (arg_288_1.time_ - 0) / var_291_15)))
							else
								local var_291_16 = Mathf.Lerp(iter_291_12.color.r, 1, (arg_288_1.time_ - 0) / var_291_15)

								iter_291_12.color = Color.New(var_291_16, var_291_16, var_291_16)
							end
						end
					end
				end
			end

			if arg_288_1.time_ >= 0 + var_291_15 and arg_288_1.time_ < 0 + var_291_15 + arg_291_0 and not isNil(var_291_14) and arg_288_1.var_.actorSpriteComps10022 then
				for iter_291_13, iter_291_14 in pairs(arg_288_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_291_14 then
						iter_291_14.color = arg_288_1.isInRecall_ and (arg_288_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_288_1.var_.actorSpriteComps10022 = nil
			end

			local var_291_17 = 0
			local var_291_18 = 0.775

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= var_291_17 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0
				arg_288_1.dialogCg_.alpha = 1

				arg_288_1.dialog_:SetActive(true)
				SetActive(arg_288_1.leftNameGo_, true)

				arg_288_1.leftNameTxt_.text = arg_288_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_288_1.leftNameTxt_.transform)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1.leftNameTxt_.text)
				SetActive(arg_288_1.iconTrs_.gameObject, false)
				arg_288_1.callingController_:SetSelectedState("normal")

				local var_291_19 = arg_288_1:GetWordFromCfg(413041071)
				local var_291_20 = arg_288_1:FormatText(var_291_19.content)

				arg_288_1.text_.text = var_291_20

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_22 = 31 <= 0 and var_291_18 or var_291_18 * (utf8.len(var_291_20) / 31)

				if (31 <= 0 and var_291_18 or var_291_18 * (utf8.len(var_291_20) / 31)) > 0 and var_291_18 < var_291_22 then
					arg_288_1.talkMaxDuration = var_291_22

					if var_291_22 + var_291_17 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_22 + var_291_17
					end
				end

				arg_288_1.text_.text = var_291_20
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413041", "413041071", "story_v_out_413041.awb") ~= 0 then
					local var_291_23 = manager.audio:GetVoiceLength("story_v_out_413041", "413041071", "story_v_out_413041.awb") / 1000

					if var_291_23 + var_291_17 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_23 + var_291_17
					end

					if var_291_19.prefab_name ~= "" and arg_288_1.actors_[var_291_19.prefab_name] ~= nil then
						local var_291_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_288_1.actors_[var_291_19.prefab_name].transform, "story_v_out_413041", "413041071", "story_v_out_413041.awb")

						arg_288_1:RecordAudio("413041071", var_291_24)
						arg_288_1:RecordAudio("413041071", var_291_24)
					else
						arg_288_1:AudioAction("play", "voice", "story_v_out_413041", "413041071", "story_v_out_413041.awb")
					end

					arg_288_1:RecordHistoryTalkVoice("story_v_out_413041", "413041071", "story_v_out_413041.awb")
				end

				arg_288_1:RecordContent(arg_288_1.text_.text)
			end

			local var_291_25 = math.max(var_291_18, arg_288_1.talkMaxDuration)

			if var_291_17 <= arg_288_1.time_ and arg_288_1.time_ < var_291_17 + var_291_25 then
				arg_288_1.typewritter.percent = (arg_288_1.time_ - var_291_17) / var_291_25

				arg_288_1.typewritter:SetDirty()
			end

			if arg_288_1.time_ >= var_291_17 + var_291_25 and arg_288_1.time_ < var_291_17 + var_291_25 + arg_291_0 then
				arg_288_1.typewritter.percent = 1

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(true)
			end
		end

		arg_288_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_288_1:InitPlayNodeList()
	end,
	Play413041072 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 413041072
		arg_292_1.duration_ = 6.63

		local var_292_0 = {
			zh = 6.4,
			ja = 6.633
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
				arg_292_0:Play413041073(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			local var_295_0 = 0.625

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0
				arg_292_1.dialogCg_.alpha = 1

				arg_292_1.dialog_:SetActive(true)
				SetActive(arg_292_1.leftNameGo_, true)

				arg_292_1.leftNameTxt_.text = arg_292_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_292_1.leftNameTxt_.transform)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1.leftNameTxt_.text)
				SetActive(arg_292_1.iconTrs_.gameObject, false)
				arg_292_1.callingController_:SetSelectedState("normal")

				local var_295_1 = arg_292_1:GetWordFromCfg(413041072)
				local var_295_2 = arg_292_1:FormatText(var_295_1.content)

				arg_292_1.text_.text = var_295_2

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_4 = 25 <= 0 and var_295_0 or var_295_0 * (utf8.len(var_295_2) / 25)

				if (25 <= 0 and var_295_0 or var_295_0 * (utf8.len(var_295_2) / 25)) > 0 and var_295_0 < var_295_4 then
					arg_292_1.talkMaxDuration = var_295_4

					if var_295_4 + 0 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_4 + 0
					end
				end

				arg_292_1.text_.text = var_295_2
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413041", "413041072", "story_v_out_413041.awb") ~= 0 then
					local var_295_5 = manager.audio:GetVoiceLength("story_v_out_413041", "413041072", "story_v_out_413041.awb") / 1000

					if var_295_5 + 0 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_5 + 0
					end

					if var_295_1.prefab_name ~= "" and arg_292_1.actors_[var_295_1.prefab_name] ~= nil then
						local var_295_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_292_1.actors_[var_295_1.prefab_name].transform, "story_v_out_413041", "413041072", "story_v_out_413041.awb")

						arg_292_1:RecordAudio("413041072", var_295_6)
						arg_292_1:RecordAudio("413041072", var_295_6)
					else
						arg_292_1:AudioAction("play", "voice", "story_v_out_413041", "413041072", "story_v_out_413041.awb")
					end

					arg_292_1:RecordHistoryTalkVoice("story_v_out_413041", "413041072", "story_v_out_413041.awb")
				end

				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_7 = math.max(var_295_0, arg_292_1.talkMaxDuration)

			if 0 <= arg_292_1.time_ and arg_292_1.time_ < 0 + var_295_7 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - 0) / var_295_7

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= 0 + var_295_7 and arg_292_1.time_ < 0 + var_295_7 + arg_295_0 then
				arg_292_1.typewritter.percent = 1

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(true)
			end
		end

		arg_292_1.nodeConfigList_ = {}

		arg_292_1:InitPlayNodeList()
	end,
	Play413041073 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 413041073
		arg_296_1.duration_ = 2

		local var_296_0 = {
			zh = 1.999999999999,
			ja = 2
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
				arg_296_0:Play413041074(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 then
				arg_296_1.var_.moveOldPos10094 = arg_296_1.actors_["10094"].transform.localPosition
				arg_296_1.actors_["10094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_296_1:CheckSpriteTmpPos("10094", 4)

				for iter_299_0 = 0, arg_296_1.actors_["10094"].transform.childCount - 1 do
					local var_299_0 = arg_296_1.actors_["10094"].transform:GetChild(iter_299_0)

					if var_299_0.name == "split_2" or not string.find(var_299_0.name, "split") then
						var_299_0.gameObject:SetActive(true)
					else
						var_299_0.gameObject:SetActive(false)
					end
				end
			end

			local var_299_1 = 0.001

			if 0 <= arg_296_1.time_ and arg_296_1.time_ < 0 + var_299_1 then
				arg_296_1.actors_["10094"].transform.localPosition = Vector3.Lerp(arg_296_1.var_.moveOldPos10094, Vector3.New(390, -340, -414), (arg_296_1.time_ - 0) / var_299_1)
			end

			if arg_296_1.time_ >= 0 + var_299_1 and arg_296_1.time_ < 0 + var_299_1 + arg_299_0 then
				arg_296_1.actors_["10094"].transform.localPosition = Vector3.New(390, -340, -414)
			end

			local var_299_2 = arg_296_1.actors_["10094"]

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 and not isNil(var_299_2) and arg_296_1.var_.actorSpriteComps10094 == nil then
				arg_296_1.var_.actorSpriteComps10094 = var_299_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_299_3 = 2

			if 0 <= arg_296_1.time_ and arg_296_1.time_ < 0 + var_299_3 and not isNil(var_299_2) then
				if arg_296_1.var_.actorSpriteComps10094 then
					for iter_299_1, iter_299_2 in pairs(arg_296_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_299_2 then
							if arg_296_1.isInRecall_ then
								iter_299_2.color = Color.New(Mathf.Lerp(iter_299_2.color.r, arg_296_1.hightColor1.r, (arg_296_1.time_ - 0) / var_299_3), Mathf.Lerp(iter_299_2.color.g, arg_296_1.hightColor1.g, (arg_296_1.time_ - 0) / var_299_3), (Mathf.Lerp(iter_299_2.color.b, arg_296_1.hightColor1.b, (arg_296_1.time_ - 0) / var_299_3)))
							else
								local var_299_4 = Mathf.Lerp(iter_299_2.color.r, 1, (arg_296_1.time_ - 0) / var_299_3)

								iter_299_2.color = Color.New(var_299_4, var_299_4, var_299_4)
							end
						end
					end
				end
			end

			if arg_296_1.time_ >= 0 + var_299_3 and arg_296_1.time_ < 0 + var_299_3 + arg_299_0 and not isNil(var_299_2) and arg_296_1.var_.actorSpriteComps10094 then
				for iter_299_3, iter_299_4 in pairs(arg_296_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_299_4 then
						iter_299_4.color = arg_296_1.isInRecall_ and (arg_296_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_296_1.var_.actorSpriteComps10094 = nil
			end

			local var_299_5 = arg_296_1.actors_["10022"]

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 and not isNil(var_299_5) and arg_296_1.var_.actorSpriteComps10022 == nil then
				arg_296_1.var_.actorSpriteComps10022 = var_299_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_299_6 = 2

			if 0 <= arg_296_1.time_ and arg_296_1.time_ < 0 + var_299_6 and not isNil(var_299_5) then
				if arg_296_1.var_.actorSpriteComps10022 then
					for iter_299_5, iter_299_6 in pairs(arg_296_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_299_6 then
							if arg_296_1.isInRecall_ then
								iter_299_6.color = Color.New(Mathf.Lerp(iter_299_6.color.r, arg_296_1.hightColor2.r, (arg_296_1.time_ - 0) / var_299_6), Mathf.Lerp(iter_299_6.color.g, arg_296_1.hightColor2.g, (arg_296_1.time_ - 0) / var_299_6), (Mathf.Lerp(iter_299_6.color.b, arg_296_1.hightColor2.b, (arg_296_1.time_ - 0) / var_299_6)))
							else
								local var_299_7 = Mathf.Lerp(iter_299_6.color.r, 0.5, (arg_296_1.time_ - 0) / var_299_6)

								iter_299_6.color = Color.New(var_299_7, var_299_7, var_299_7)
							end
						end
					end
				end
			end

			if arg_296_1.time_ >= 0 + var_299_6 and arg_296_1.time_ < 0 + var_299_6 + arg_299_0 and not isNil(var_299_5) and arg_296_1.var_.actorSpriteComps10022 then
				for iter_299_7, iter_299_8 in pairs(arg_296_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_299_8 then
						iter_299_8.color = arg_296_1.isInRecall_ and (arg_296_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_296_1.var_.actorSpriteComps10022 = nil
			end

			local var_299_8 = arg_296_1.actors_["10022"].transform

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 then
				arg_296_1.var_.moveOldPos10022 = var_299_8.localPosition
				var_299_8.localScale = Vector3.New(1, 1, 1)

				arg_296_1:CheckSpriteTmpPos("10022", 2)

				for iter_299_9 = 0, var_299_8.childCount - 1 do
					local var_299_9 = var_299_8:GetChild(iter_299_9)

					if var_299_9.name == "" or not string.find(var_299_9.name, "split") then
						var_299_9.gameObject:SetActive(true)
					else
						var_299_9.gameObject:SetActive(false)
					end
				end
			end

			local var_299_10 = 0.001

			if 0 <= arg_296_1.time_ and arg_296_1.time_ < 0 + var_299_10 then
				var_299_8.localPosition = Vector3.Lerp(arg_296_1.var_.moveOldPos10022, Vector3.New(-390, -315, -320), (arg_296_1.time_ - 0) / var_299_10)
			end

			if arg_296_1.time_ >= 0 + var_299_10 and arg_296_1.time_ < 0 + var_299_10 + arg_299_0 then
				var_299_8.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_299_11 = 0
			local var_299_12 = 0.075

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= var_299_11 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0
				arg_296_1.dialogCg_.alpha = 1

				arg_296_1.dialog_:SetActive(true)
				SetActive(arg_296_1.leftNameGo_, true)

				arg_296_1.leftNameTxt_.text = arg_296_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_296_1.leftNameTxt_.transform)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1.leftNameTxt_.text)
				SetActive(arg_296_1.iconTrs_.gameObject, false)
				arg_296_1.callingController_:SetSelectedState("normal")

				local var_299_13 = arg_296_1:GetWordFromCfg(413041073)
				local var_299_14 = arg_296_1:FormatText(var_299_13.content)

				arg_296_1.text_.text = var_299_14

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_16 = 3 <= 0 and var_299_12 or var_299_12 * (utf8.len(var_299_14) / 3)

				if (3 <= 0 and var_299_12 or var_299_12 * (utf8.len(var_299_14) / 3)) > 0 and var_299_12 < var_299_16 then
					arg_296_1.talkMaxDuration = var_299_16

					if var_299_16 + var_299_11 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_16 + var_299_11
					end
				end

				arg_296_1.text_.text = var_299_14
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413041", "413041073", "story_v_out_413041.awb") ~= 0 then
					local var_299_17 = manager.audio:GetVoiceLength("story_v_out_413041", "413041073", "story_v_out_413041.awb") / 1000

					if var_299_17 + var_299_11 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_17 + var_299_11
					end

					if var_299_13.prefab_name ~= "" and arg_296_1.actors_[var_299_13.prefab_name] ~= nil then
						local var_299_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_296_1.actors_[var_299_13.prefab_name].transform, "story_v_out_413041", "413041073", "story_v_out_413041.awb")

						arg_296_1:RecordAudio("413041073", var_299_18)
						arg_296_1:RecordAudio("413041073", var_299_18)
					else
						arg_296_1:AudioAction("play", "voice", "story_v_out_413041", "413041073", "story_v_out_413041.awb")
					end

					arg_296_1:RecordHistoryTalkVoice("story_v_out_413041", "413041073", "story_v_out_413041.awb")
				end

				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_19 = math.max(var_299_12, arg_296_1.talkMaxDuration)

			if var_299_11 <= arg_296_1.time_ and arg_296_1.time_ < var_299_11 + var_299_19 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - var_299_11) / var_299_19

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= var_299_11 + var_299_19 and arg_296_1.time_ < var_299_11 + var_299_19 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_296_1:InitPlayNodeList()
	end,
	Play413041074 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 413041074
		arg_300_1.duration_ = 6.63

		local var_300_0 = {
			zh = 3.2,
			ja = 6.633
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
				arg_300_0:Play413041075(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 and not isNil(arg_300_1.actors_["10094"]) and arg_300_1.var_.actorSpriteComps10094 == nil then
				arg_300_1.var_.actorSpriteComps10094 = arg_300_1.actors_["10094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_303_0 = 2

			if 0 <= arg_300_1.time_ and arg_300_1.time_ < 0 + var_303_0 and not isNil(arg_300_1.actors_["10094"]) then
				if arg_300_1.var_.actorSpriteComps10094 then
					for iter_303_0, iter_303_1 in pairs(arg_300_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_303_1 then
							if arg_300_1.isInRecall_ then
								iter_303_1.color = Color.New(Mathf.Lerp(iter_303_1.color.r, arg_300_1.hightColor2.r, (arg_300_1.time_ - 0) / var_303_0), Mathf.Lerp(iter_303_1.color.g, arg_300_1.hightColor2.g, (arg_300_1.time_ - 0) / var_303_0), (Mathf.Lerp(iter_303_1.color.b, arg_300_1.hightColor2.b, (arg_300_1.time_ - 0) / var_303_0)))
							else
								local var_303_1 = Mathf.Lerp(iter_303_1.color.r, 0.5, (arg_300_1.time_ - 0) / var_303_0)

								iter_303_1.color = Color.New(var_303_1, var_303_1, var_303_1)
							end
						end
					end
				end
			end

			if arg_300_1.time_ >= 0 + var_303_0 and arg_300_1.time_ < 0 + var_303_0 + arg_303_0 and not isNil(arg_300_1.actors_["10094"]) and arg_300_1.var_.actorSpriteComps10094 then
				for iter_303_2, iter_303_3 in pairs(arg_300_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_303_3 then
						iter_303_3.color = arg_300_1.isInRecall_ and (arg_300_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_300_1.var_.actorSpriteComps10094 = nil
			end

			local var_303_2 = arg_300_1.actors_["10022"]

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 and not isNil(var_303_2) and arg_300_1.var_.actorSpriteComps10022 == nil then
				arg_300_1.var_.actorSpriteComps10022 = var_303_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_303_3 = 2

			if 0 <= arg_300_1.time_ and arg_300_1.time_ < 0 + var_303_3 and not isNil(var_303_2) then
				if arg_300_1.var_.actorSpriteComps10022 then
					for iter_303_4, iter_303_5 in pairs(arg_300_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_303_5 then
							if arg_300_1.isInRecall_ then
								iter_303_5.color = Color.New(Mathf.Lerp(iter_303_5.color.r, arg_300_1.hightColor1.r, (arg_300_1.time_ - 0) / var_303_3), Mathf.Lerp(iter_303_5.color.g, arg_300_1.hightColor1.g, (arg_300_1.time_ - 0) / var_303_3), (Mathf.Lerp(iter_303_5.color.b, arg_300_1.hightColor1.b, (arg_300_1.time_ - 0) / var_303_3)))
							else
								local var_303_4 = Mathf.Lerp(iter_303_5.color.r, 1, (arg_300_1.time_ - 0) / var_303_3)

								iter_303_5.color = Color.New(var_303_4, var_303_4, var_303_4)
							end
						end
					end
				end
			end

			if arg_300_1.time_ >= 0 + var_303_3 and arg_300_1.time_ < 0 + var_303_3 + arg_303_0 and not isNil(var_303_2) and arg_300_1.var_.actorSpriteComps10022 then
				for iter_303_6, iter_303_7 in pairs(arg_300_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_303_7 then
						iter_303_7.color = arg_300_1.isInRecall_ and (arg_300_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_300_1.var_.actorSpriteComps10022 = nil
			end

			local var_303_5 = 0
			local var_303_6 = 0.4

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= var_303_5 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0
				arg_300_1.dialogCg_.alpha = 1

				arg_300_1.dialog_:SetActive(true)
				SetActive(arg_300_1.leftNameGo_, true)

				arg_300_1.leftNameTxt_.text = arg_300_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_300_1.leftNameTxt_.transform)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1.leftNameTxt_.text)
				SetActive(arg_300_1.iconTrs_.gameObject, false)
				arg_300_1.callingController_:SetSelectedState("normal")

				local var_303_7 = arg_300_1:GetWordFromCfg(413041074)
				local var_303_8 = arg_300_1:FormatText(var_303_7.content)

				arg_300_1.text_.text = var_303_8

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_10 = 16 <= 0 and var_303_6 or var_303_6 * (utf8.len(var_303_8) / 16)

				if (16 <= 0 and var_303_6 or var_303_6 * (utf8.len(var_303_8) / 16)) > 0 and var_303_6 < var_303_10 then
					arg_300_1.talkMaxDuration = var_303_10

					if var_303_10 + var_303_5 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_10 + var_303_5
					end
				end

				arg_300_1.text_.text = var_303_8
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413041", "413041074", "story_v_out_413041.awb") ~= 0 then
					local var_303_11 = manager.audio:GetVoiceLength("story_v_out_413041", "413041074", "story_v_out_413041.awb") / 1000

					if var_303_11 + var_303_5 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_11 + var_303_5
					end

					if var_303_7.prefab_name ~= "" and arg_300_1.actors_[var_303_7.prefab_name] ~= nil then
						local var_303_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_300_1.actors_[var_303_7.prefab_name].transform, "story_v_out_413041", "413041074", "story_v_out_413041.awb")

						arg_300_1:RecordAudio("413041074", var_303_12)
						arg_300_1:RecordAudio("413041074", var_303_12)
					else
						arg_300_1:AudioAction("play", "voice", "story_v_out_413041", "413041074", "story_v_out_413041.awb")
					end

					arg_300_1:RecordHistoryTalkVoice("story_v_out_413041", "413041074", "story_v_out_413041.awb")
				end

				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_13 = math.max(var_303_6, arg_300_1.talkMaxDuration)

			if var_303_5 <= arg_300_1.time_ and arg_300_1.time_ < var_303_5 + var_303_13 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - var_303_5) / var_303_13

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= var_303_5 + var_303_13 and arg_300_1.time_ < var_303_5 + var_303_13 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {}

		arg_300_1:InitPlayNodeList()
	end,
	Play413041075 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 413041075
		arg_304_1.duration_ = 5.87

		local var_304_0 = {
			zh = 3.966,
			ja = 5.866
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
				arg_304_0:Play413041076(arg_304_1)
			end
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			if 0 < arg_304_1.time_ and arg_304_1.time_ <= 0 + arg_307_0 then
				arg_304_1.var_.moveOldPos10094 = arg_304_1.actors_["10094"].transform.localPosition
				arg_304_1.actors_["10094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_304_1:CheckSpriteTmpPos("10094", 4)

				for iter_307_0 = 0, arg_304_1.actors_["10094"].transform.childCount - 1 do
					local var_307_0 = arg_304_1.actors_["10094"].transform:GetChild(iter_307_0)

					if var_307_0.name == "" or not string.find(var_307_0.name, "split") then
						var_307_0.gameObject:SetActive(true)
					else
						var_307_0.gameObject:SetActive(false)
					end
				end
			end

			local var_307_1 = 0.001

			if 0 <= arg_304_1.time_ and arg_304_1.time_ < 0 + var_307_1 then
				arg_304_1.actors_["10094"].transform.localPosition = Vector3.Lerp(arg_304_1.var_.moveOldPos10094, Vector3.New(390, -340, -414), (arg_304_1.time_ - 0) / var_307_1)
			end

			if arg_304_1.time_ >= 0 + var_307_1 and arg_304_1.time_ < 0 + var_307_1 + arg_307_0 then
				arg_304_1.actors_["10094"].transform.localPosition = Vector3.New(390, -340, -414)
			end

			local var_307_2 = arg_304_1.actors_["10094"]

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= 0 + arg_307_0 and not isNil(var_307_2) and arg_304_1.var_.actorSpriteComps10094 == nil then
				arg_304_1.var_.actorSpriteComps10094 = var_307_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_307_3 = 2

			if 0 <= arg_304_1.time_ and arg_304_1.time_ < 0 + var_307_3 and not isNil(var_307_2) then
				if arg_304_1.var_.actorSpriteComps10094 then
					for iter_307_1, iter_307_2 in pairs(arg_304_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_307_2 then
							if arg_304_1.isInRecall_ then
								iter_307_2.color = Color.New(Mathf.Lerp(iter_307_2.color.r, arg_304_1.hightColor1.r, (arg_304_1.time_ - 0) / var_307_3), Mathf.Lerp(iter_307_2.color.g, arg_304_1.hightColor1.g, (arg_304_1.time_ - 0) / var_307_3), (Mathf.Lerp(iter_307_2.color.b, arg_304_1.hightColor1.b, (arg_304_1.time_ - 0) / var_307_3)))
							else
								local var_307_4 = Mathf.Lerp(iter_307_2.color.r, 1, (arg_304_1.time_ - 0) / var_307_3)

								iter_307_2.color = Color.New(var_307_4, var_307_4, var_307_4)
							end
						end
					end
				end
			end

			if arg_304_1.time_ >= 0 + var_307_3 and arg_304_1.time_ < 0 + var_307_3 + arg_307_0 and not isNil(var_307_2) and arg_304_1.var_.actorSpriteComps10094 then
				for iter_307_3, iter_307_4 in pairs(arg_304_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_307_4 then
						iter_307_4.color = arg_304_1.isInRecall_ and (arg_304_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_304_1.var_.actorSpriteComps10094 = nil
			end

			local var_307_5 = arg_304_1.actors_["10022"]

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= 0 + arg_307_0 and not isNil(var_307_5) and arg_304_1.var_.actorSpriteComps10022 == nil then
				arg_304_1.var_.actorSpriteComps10022 = var_307_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_307_6 = 2

			if 0 <= arg_304_1.time_ and arg_304_1.time_ < 0 + var_307_6 and not isNil(var_307_5) then
				if arg_304_1.var_.actorSpriteComps10022 then
					for iter_307_5, iter_307_6 in pairs(arg_304_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_307_6 then
							if arg_304_1.isInRecall_ then
								iter_307_6.color = Color.New(Mathf.Lerp(iter_307_6.color.r, arg_304_1.hightColor2.r, (arg_304_1.time_ - 0) / var_307_6), Mathf.Lerp(iter_307_6.color.g, arg_304_1.hightColor2.g, (arg_304_1.time_ - 0) / var_307_6), (Mathf.Lerp(iter_307_6.color.b, arg_304_1.hightColor2.b, (arg_304_1.time_ - 0) / var_307_6)))
							else
								local var_307_7 = Mathf.Lerp(iter_307_6.color.r, 0.5, (arg_304_1.time_ - 0) / var_307_6)

								iter_307_6.color = Color.New(var_307_7, var_307_7, var_307_7)
							end
						end
					end
				end
			end

			if arg_304_1.time_ >= 0 + var_307_6 and arg_304_1.time_ < 0 + var_307_6 + arg_307_0 and not isNil(var_307_5) and arg_304_1.var_.actorSpriteComps10022 then
				for iter_307_7, iter_307_8 in pairs(arg_304_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_307_8 then
						iter_307_8.color = arg_304_1.isInRecall_ and (arg_304_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_304_1.var_.actorSpriteComps10022 = nil
			end

			local var_307_8 = 0
			local var_307_9 = 0.5

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= var_307_8 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0
				arg_304_1.dialogCg_.alpha = 1

				arg_304_1.dialog_:SetActive(true)
				SetActive(arg_304_1.leftNameGo_, true)

				arg_304_1.leftNameTxt_.text = arg_304_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_304_1.leftNameTxt_.transform)

				arg_304_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_304_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_304_1:RecordName(arg_304_1.leftNameTxt_.text)
				SetActive(arg_304_1.iconTrs_.gameObject, false)
				arg_304_1.callingController_:SetSelectedState("normal")

				local var_307_10 = arg_304_1:GetWordFromCfg(413041075)
				local var_307_11 = arg_304_1:FormatText(var_307_10.content)

				arg_304_1.text_.text = var_307_11

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_13 = 20 <= 0 and var_307_9 or var_307_9 * (utf8.len(var_307_11) / 20)

				if (20 <= 0 and var_307_9 or var_307_9 * (utf8.len(var_307_11) / 20)) > 0 and var_307_9 < var_307_13 then
					arg_304_1.talkMaxDuration = var_307_13

					if var_307_13 + var_307_8 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_13 + var_307_8
					end
				end

				arg_304_1.text_.text = var_307_11
				arg_304_1.typewritter.percent = 0

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413041", "413041075", "story_v_out_413041.awb") ~= 0 then
					local var_307_14 = manager.audio:GetVoiceLength("story_v_out_413041", "413041075", "story_v_out_413041.awb") / 1000

					if var_307_14 + var_307_8 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_14 + var_307_8
					end

					if var_307_10.prefab_name ~= "" and arg_304_1.actors_[var_307_10.prefab_name] ~= nil then
						local var_307_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_304_1.actors_[var_307_10.prefab_name].transform, "story_v_out_413041", "413041075", "story_v_out_413041.awb")

						arg_304_1:RecordAudio("413041075", var_307_15)
						arg_304_1:RecordAudio("413041075", var_307_15)
					else
						arg_304_1:AudioAction("play", "voice", "story_v_out_413041", "413041075", "story_v_out_413041.awb")
					end

					arg_304_1:RecordHistoryTalkVoice("story_v_out_413041", "413041075", "story_v_out_413041.awb")
				end

				arg_304_1:RecordContent(arg_304_1.text_.text)
			end

			local var_307_16 = math.max(var_307_9, arg_304_1.talkMaxDuration)

			if var_307_8 <= arg_304_1.time_ and arg_304_1.time_ < var_307_8 + var_307_16 then
				arg_304_1.typewritter.percent = (arg_304_1.time_ - var_307_8) / var_307_16

				arg_304_1.typewritter:SetDirty()
			end

			if arg_304_1.time_ >= var_307_8 + var_307_16 and arg_304_1.time_ < var_307_8 + var_307_16 + arg_307_0 then
				arg_304_1.typewritter.percent = 1

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(true)
			end
		end

		arg_304_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_304_1:InitPlayNodeList()
	end,
	Play413041076 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 413041076
		arg_308_1.duration_ = 4.4

		local var_308_0 = {
			zh = 2.4,
			ja = 4.4
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
				arg_308_0:Play413041077(arg_308_1)
			end
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 then
				arg_308_1.var_.moveOldPos10094 = arg_308_1.actors_["10094"].transform.localPosition
				arg_308_1.actors_["10094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_308_1:CheckSpriteTmpPos("10094", 7)

				for iter_311_0 = 0, arg_308_1.actors_["10094"].transform.childCount - 1 do
					local var_311_0 = arg_308_1.actors_["10094"].transform:GetChild(iter_311_0)

					if var_311_0.name == "" or not string.find(var_311_0.name, "split") then
						var_311_0.gameObject:SetActive(true)
					else
						var_311_0.gameObject:SetActive(false)
					end
				end
			end

			local var_311_1 = 0.001

			if 0 <= arg_308_1.time_ and arg_308_1.time_ < 0 + var_311_1 then
				arg_308_1.actors_["10094"].transform.localPosition = Vector3.Lerp(arg_308_1.var_.moveOldPos10094, Vector3.New(0, -2000, 0), (arg_308_1.time_ - 0) / var_311_1)
			end

			if arg_308_1.time_ >= 0 + var_311_1 and arg_308_1.time_ < 0 + var_311_1 + arg_311_0 then
				arg_308_1.actors_["10094"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_311_2 = arg_308_1.actors_["10022"].transform

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 then
				arg_308_1.var_.moveOldPos10022 = var_311_2.localPosition
				var_311_2.localScale = Vector3.New(1, 1, 1)

				arg_308_1:CheckSpriteTmpPos("10022", 7)

				for iter_311_1 = 0, var_311_2.childCount - 1 do
					local var_311_3 = var_311_2:GetChild(iter_311_1)

					if var_311_3.name == "" or not string.find(var_311_3.name, "split") then
						var_311_3.gameObject:SetActive(true)
					else
						var_311_3.gameObject:SetActive(false)
					end
				end
			end

			local var_311_4 = 0.001

			if 0 <= arg_308_1.time_ and arg_308_1.time_ < 0 + var_311_4 then
				var_311_2.localPosition = Vector3.Lerp(arg_308_1.var_.moveOldPos10022, Vector3.New(0, -2000, -180), (arg_308_1.time_ - 0) / var_311_4)
			end

			if arg_308_1.time_ >= 0 + var_311_4 and arg_308_1.time_ < 0 + var_311_4 + arg_311_0 then
				var_311_2.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_311_5 = arg_308_1.actors_["10092"].transform

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 then
				arg_308_1.var_.moveOldPos10092 = var_311_5.localPosition
				var_311_5.localScale = Vector3.New(1, 1, 1)

				arg_308_1:CheckSpriteTmpPos("10092", 3)

				for iter_311_2 = 0, var_311_5.childCount - 1 do
					local var_311_6 = var_311_5:GetChild(iter_311_2)

					if var_311_6.name == "split_5" or not string.find(var_311_6.name, "split") then
						var_311_6.gameObject:SetActive(true)
					else
						var_311_6.gameObject:SetActive(false)
					end
				end
			end

			local var_311_7 = 0.001

			if 0 <= arg_308_1.time_ and arg_308_1.time_ < 0 + var_311_7 then
				var_311_5.localPosition = Vector3.Lerp(arg_308_1.var_.moveOldPos10092, Vector3.New(0, -300, -295), (arg_308_1.time_ - 0) / var_311_7)
			end

			if arg_308_1.time_ >= 0 + var_311_7 and arg_308_1.time_ < 0 + var_311_7 + arg_311_0 then
				var_311_5.localPosition = Vector3.New(0, -300, -295)
			end

			local var_311_8 = arg_308_1.actors_["10094"]

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 and not isNil(var_311_8) and arg_308_1.var_.actorSpriteComps10094 == nil then
				arg_308_1.var_.actorSpriteComps10094 = var_311_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_311_9 = 2

			if 0 <= arg_308_1.time_ and arg_308_1.time_ < 0 + var_311_9 and not isNil(var_311_8) then
				if arg_308_1.var_.actorSpriteComps10094 then
					for iter_311_3, iter_311_4 in pairs(arg_308_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_311_4 then
							if arg_308_1.isInRecall_ then
								iter_311_4.color = Color.New(Mathf.Lerp(iter_311_4.color.r, arg_308_1.hightColor2.r, (arg_308_1.time_ - 0) / var_311_9), Mathf.Lerp(iter_311_4.color.g, arg_308_1.hightColor2.g, (arg_308_1.time_ - 0) / var_311_9), (Mathf.Lerp(iter_311_4.color.b, arg_308_1.hightColor2.b, (arg_308_1.time_ - 0) / var_311_9)))
							else
								local var_311_10 = Mathf.Lerp(iter_311_4.color.r, 0.5, (arg_308_1.time_ - 0) / var_311_9)

								iter_311_4.color = Color.New(var_311_10, var_311_10, var_311_10)
							end
						end
					end
				end
			end

			if arg_308_1.time_ >= 0 + var_311_9 and arg_308_1.time_ < 0 + var_311_9 + arg_311_0 and not isNil(var_311_8) and arg_308_1.var_.actorSpriteComps10094 then
				for iter_311_5, iter_311_6 in pairs(arg_308_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_311_6 then
						iter_311_6.color = arg_308_1.isInRecall_ and (arg_308_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_308_1.var_.actorSpriteComps10094 = nil
			end

			local var_311_11 = arg_308_1.actors_["10022"]

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 and not isNil(var_311_11) and arg_308_1.var_.actorSpriteComps10022 == nil then
				arg_308_1.var_.actorSpriteComps10022 = var_311_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_311_12 = 2

			if 0 <= arg_308_1.time_ and arg_308_1.time_ < 0 + var_311_12 and not isNil(var_311_11) then
				if arg_308_1.var_.actorSpriteComps10022 then
					for iter_311_7, iter_311_8 in pairs(arg_308_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_311_8 then
							if arg_308_1.isInRecall_ then
								iter_311_8.color = Color.New(Mathf.Lerp(iter_311_8.color.r, arg_308_1.hightColor2.r, (arg_308_1.time_ - 0) / var_311_12), Mathf.Lerp(iter_311_8.color.g, arg_308_1.hightColor2.g, (arg_308_1.time_ - 0) / var_311_12), (Mathf.Lerp(iter_311_8.color.b, arg_308_1.hightColor2.b, (arg_308_1.time_ - 0) / var_311_12)))
							else
								local var_311_13 = Mathf.Lerp(iter_311_8.color.r, 0.5, (arg_308_1.time_ - 0) / var_311_12)

								iter_311_8.color = Color.New(var_311_13, var_311_13, var_311_13)
							end
						end
					end
				end
			end

			if arg_308_1.time_ >= 0 + var_311_12 and arg_308_1.time_ < 0 + var_311_12 + arg_311_0 and not isNil(var_311_11) and arg_308_1.var_.actorSpriteComps10022 then
				for iter_311_9, iter_311_10 in pairs(arg_308_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_311_10 then
						iter_311_10.color = arg_308_1.isInRecall_ and (arg_308_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_308_1.var_.actorSpriteComps10022 = nil
			end

			local var_311_14 = arg_308_1.actors_["10092"]

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 and not isNil(var_311_14) and arg_308_1.var_.actorSpriteComps10092 == nil then
				arg_308_1.var_.actorSpriteComps10092 = var_311_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_311_15 = 2

			if 0 <= arg_308_1.time_ and arg_308_1.time_ < 0 + var_311_15 and not isNil(var_311_14) then
				if arg_308_1.var_.actorSpriteComps10092 then
					for iter_311_11, iter_311_12 in pairs(arg_308_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_311_12 then
							if arg_308_1.isInRecall_ then
								iter_311_12.color = Color.New(Mathf.Lerp(iter_311_12.color.r, arg_308_1.hightColor1.r, (arg_308_1.time_ - 0) / var_311_15), Mathf.Lerp(iter_311_12.color.g, arg_308_1.hightColor1.g, (arg_308_1.time_ - 0) / var_311_15), (Mathf.Lerp(iter_311_12.color.b, arg_308_1.hightColor1.b, (arg_308_1.time_ - 0) / var_311_15)))
							else
								local var_311_16 = Mathf.Lerp(iter_311_12.color.r, 1, (arg_308_1.time_ - 0) / var_311_15)

								iter_311_12.color = Color.New(var_311_16, var_311_16, var_311_16)
							end
						end
					end
				end
			end

			if arg_308_1.time_ >= 0 + var_311_15 and arg_308_1.time_ < 0 + var_311_15 + arg_311_0 and not isNil(var_311_14) and arg_308_1.var_.actorSpriteComps10092 then
				for iter_311_13, iter_311_14 in pairs(arg_308_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_311_14 then
						iter_311_14.color = arg_308_1.isInRecall_ and (arg_308_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_308_1.var_.actorSpriteComps10092 = nil
			end

			local var_311_17 = 0
			local var_311_18 = 0.325

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= var_311_17 + arg_311_0 then
				arg_308_1.talkMaxDuration = 0
				arg_308_1.dialogCg_.alpha = 1

				arg_308_1.dialog_:SetActive(true)
				SetActive(arg_308_1.leftNameGo_, true)

				arg_308_1.leftNameTxt_.text = arg_308_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_308_1.leftNameTxt_.transform)

				arg_308_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_308_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_308_1:RecordName(arg_308_1.leftNameTxt_.text)
				SetActive(arg_308_1.iconTrs_.gameObject, false)
				arg_308_1.callingController_:SetSelectedState("normal")

				local var_311_19 = arg_308_1:GetWordFromCfg(413041076)
				local var_311_20 = arg_308_1:FormatText(var_311_19.content)

				arg_308_1.text_.text = var_311_20

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_22 = 13 <= 0 and var_311_18 or var_311_18 * (utf8.len(var_311_20) / 13)

				if (13 <= 0 and var_311_18 or var_311_18 * (utf8.len(var_311_20) / 13)) > 0 and var_311_18 < var_311_22 then
					arg_308_1.talkMaxDuration = var_311_22

					if var_311_22 + var_311_17 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_22 + var_311_17
					end
				end

				arg_308_1.text_.text = var_311_20
				arg_308_1.typewritter.percent = 0

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413041", "413041076", "story_v_out_413041.awb") ~= 0 then
					local var_311_23 = manager.audio:GetVoiceLength("story_v_out_413041", "413041076", "story_v_out_413041.awb") / 1000

					if var_311_23 + var_311_17 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_23 + var_311_17
					end

					if var_311_19.prefab_name ~= "" and arg_308_1.actors_[var_311_19.prefab_name] ~= nil then
						local var_311_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_308_1.actors_[var_311_19.prefab_name].transform, "story_v_out_413041", "413041076", "story_v_out_413041.awb")

						arg_308_1:RecordAudio("413041076", var_311_24)
						arg_308_1:RecordAudio("413041076", var_311_24)
					else
						arg_308_1:AudioAction("play", "voice", "story_v_out_413041", "413041076", "story_v_out_413041.awb")
					end

					arg_308_1:RecordHistoryTalkVoice("story_v_out_413041", "413041076", "story_v_out_413041.awb")
				end

				arg_308_1:RecordContent(arg_308_1.text_.text)
			end

			local var_311_25 = math.max(var_311_18, arg_308_1.talkMaxDuration)

			if var_311_17 <= arg_308_1.time_ and arg_308_1.time_ < var_311_17 + var_311_25 then
				arg_308_1.typewritter.percent = (arg_308_1.time_ - var_311_17) / var_311_25

				arg_308_1.typewritter:SetDirty()
			end

			if arg_308_1.time_ >= var_311_17 + var_311_25 and arg_308_1.time_ < var_311_17 + var_311_25 + arg_311_0 then
				arg_308_1.typewritter.percent = 1

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(true)
			end
		end

		arg_308_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10092",
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
	Play413041077 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 413041077
		arg_312_1.duration_ = 6.4

		local var_312_0 = {
			zh = 3.033,
			ja = 6.4
		}
		local var_312_1 = manager.audio:GetLocalizationFlag()

		if var_312_0[var_312_1] ~= nil then
			arg_312_1.duration_ = var_312_0[var_312_1]
		end

		SetActive(arg_312_1.tipsGo_, false)

		function arg_312_1.onSingleLineFinish_()
			arg_312_1.onSingleLineUpdate_ = nil
			arg_312_1.onSingleLineFinish_ = nil
			arg_312_1.state_ = "waiting"
		end

		function arg_312_1.playNext_(arg_314_0)
			if arg_314_0 == 1 then
				arg_312_0:Play413041078(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 then
				arg_312_1.var_.moveOldPos10092 = arg_312_1.actors_["10092"].transform.localPosition
				arg_312_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_312_1:CheckSpriteTmpPos("10092", 0)

				for iter_315_0 = 0, arg_312_1.actors_["10092"].transform.childCount - 1 do
					local var_315_0 = arg_312_1.actors_["10092"].transform:GetChild(iter_315_0)

					if var_315_0.name == "" or not string.find(var_315_0.name, "split") then
						var_315_0.gameObject:SetActive(true)
					else
						var_315_0.gameObject:SetActive(false)
					end
				end
			end

			local var_315_1 = 0.001

			if 0 <= arg_312_1.time_ and arg_312_1.time_ < 0 + var_315_1 then
				arg_312_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_312_1.var_.moveOldPos10092, Vector3.New(0, -5000, 0), (arg_312_1.time_ - 0) / var_315_1)
			end

			if arg_312_1.time_ >= 0 + var_315_1 and arg_312_1.time_ < 0 + var_315_1 + arg_315_0 then
				arg_312_1.actors_["10092"].transform.localPosition = Vector3.New(0, -5000, 0)
			end

			local var_315_2 = arg_312_1.actors_["10022"].transform

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 then
				arg_312_1.var_.moveOldPos10022 = var_315_2.localPosition
				var_315_2.localScale = Vector3.New(1, 1, 1)

				arg_312_1:CheckSpriteTmpPos("10022", 3)

				for iter_315_1 = 0, var_315_2.childCount - 1 do
					local var_315_3 = var_315_2:GetChild(iter_315_1)

					if var_315_3.name == "" or not string.find(var_315_3.name, "split") then
						var_315_3.gameObject:SetActive(true)
					else
						var_315_3.gameObject:SetActive(false)
					end
				end
			end

			local var_315_4 = 0.001

			if 0 <= arg_312_1.time_ and arg_312_1.time_ < 0 + var_315_4 then
				var_315_2.localPosition = Vector3.Lerp(arg_312_1.var_.moveOldPos10022, Vector3.New(0, -315, -320), (arg_312_1.time_ - 0) / var_315_4)
			end

			if arg_312_1.time_ >= 0 + var_315_4 and arg_312_1.time_ < 0 + var_315_4 + arg_315_0 then
				var_315_2.localPosition = Vector3.New(0, -315, -320)
			end

			local var_315_5 = arg_312_1.actors_["10092"]

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 and not isNil(var_315_5) and arg_312_1.var_.actorSpriteComps10092 == nil then
				arg_312_1.var_.actorSpriteComps10092 = var_315_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_315_6 = 2

			if 0 <= arg_312_1.time_ and arg_312_1.time_ < 0 + var_315_6 and not isNil(var_315_5) then
				if arg_312_1.var_.actorSpriteComps10092 then
					for iter_315_2, iter_315_3 in pairs(arg_312_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_315_3 then
							if arg_312_1.isInRecall_ then
								iter_315_3.color = Color.New(Mathf.Lerp(iter_315_3.color.r, arg_312_1.hightColor2.r, (arg_312_1.time_ - 0) / var_315_6), Mathf.Lerp(iter_315_3.color.g, arg_312_1.hightColor2.g, (arg_312_1.time_ - 0) / var_315_6), (Mathf.Lerp(iter_315_3.color.b, arg_312_1.hightColor2.b, (arg_312_1.time_ - 0) / var_315_6)))
							else
								local var_315_7 = Mathf.Lerp(iter_315_3.color.r, 0.5, (arg_312_1.time_ - 0) / var_315_6)

								iter_315_3.color = Color.New(var_315_7, var_315_7, var_315_7)
							end
						end
					end
				end
			end

			if arg_312_1.time_ >= 0 + var_315_6 and arg_312_1.time_ < 0 + var_315_6 + arg_315_0 and not isNil(var_315_5) and arg_312_1.var_.actorSpriteComps10092 then
				for iter_315_4, iter_315_5 in pairs(arg_312_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_315_5 then
						iter_315_5.color = arg_312_1.isInRecall_ and (arg_312_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_312_1.var_.actorSpriteComps10092 = nil
			end

			local var_315_8 = arg_312_1.actors_["10022"]

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 and not isNil(var_315_8) and arg_312_1.var_.actorSpriteComps10022 == nil then
				arg_312_1.var_.actorSpriteComps10022 = var_315_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_315_9 = 2

			if 0 <= arg_312_1.time_ and arg_312_1.time_ < 0 + var_315_9 and not isNil(var_315_8) then
				if arg_312_1.var_.actorSpriteComps10022 then
					for iter_315_6, iter_315_7 in pairs(arg_312_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_315_7 then
							if arg_312_1.isInRecall_ then
								iter_315_7.color = Color.New(Mathf.Lerp(iter_315_7.color.r, arg_312_1.hightColor1.r, (arg_312_1.time_ - 0) / var_315_9), Mathf.Lerp(iter_315_7.color.g, arg_312_1.hightColor1.g, (arg_312_1.time_ - 0) / var_315_9), (Mathf.Lerp(iter_315_7.color.b, arg_312_1.hightColor1.b, (arg_312_1.time_ - 0) / var_315_9)))
							else
								local var_315_10 = Mathf.Lerp(iter_315_7.color.r, 1, (arg_312_1.time_ - 0) / var_315_9)

								iter_315_7.color = Color.New(var_315_10, var_315_10, var_315_10)
							end
						end
					end
				end
			end

			if arg_312_1.time_ >= 0 + var_315_9 and arg_312_1.time_ < 0 + var_315_9 + arg_315_0 and not isNil(var_315_8) and arg_312_1.var_.actorSpriteComps10022 then
				for iter_315_8, iter_315_9 in pairs(arg_312_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_315_9 then
						iter_315_9.color = arg_312_1.isInRecall_ and (arg_312_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_312_1.var_.actorSpriteComps10022 = nil
			end

			local var_315_11 = 0
			local var_315_12 = 0.4

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= var_315_11 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0
				arg_312_1.dialogCg_.alpha = 1

				arg_312_1.dialog_:SetActive(true)
				SetActive(arg_312_1.leftNameGo_, true)

				arg_312_1.leftNameTxt_.text = arg_312_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_312_1.leftNameTxt_.transform)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1.leftNameTxt_.text)
				SetActive(arg_312_1.iconTrs_.gameObject, false)
				arg_312_1.callingController_:SetSelectedState("normal")

				local var_315_13 = arg_312_1:GetWordFromCfg(413041077)
				local var_315_14 = arg_312_1:FormatText(var_315_13.content)

				arg_312_1.text_.text = var_315_14

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_16 = 16 <= 0 and var_315_12 or var_315_12 * (utf8.len(var_315_14) / 16)

				if (16 <= 0 and var_315_12 or var_315_12 * (utf8.len(var_315_14) / 16)) > 0 and var_315_12 < var_315_16 then
					arg_312_1.talkMaxDuration = var_315_16

					if var_315_16 + var_315_11 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_16 + var_315_11
					end
				end

				arg_312_1.text_.text = var_315_14
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413041", "413041077", "story_v_out_413041.awb") ~= 0 then
					local var_315_17 = manager.audio:GetVoiceLength("story_v_out_413041", "413041077", "story_v_out_413041.awb") / 1000

					if var_315_17 + var_315_11 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_17 + var_315_11
					end

					if var_315_13.prefab_name ~= "" and arg_312_1.actors_[var_315_13.prefab_name] ~= nil then
						local var_315_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_312_1.actors_[var_315_13.prefab_name].transform, "story_v_out_413041", "413041077", "story_v_out_413041.awb")

						arg_312_1:RecordAudio("413041077", var_315_18)
						arg_312_1:RecordAudio("413041077", var_315_18)
					else
						arg_312_1:AudioAction("play", "voice", "story_v_out_413041", "413041077", "story_v_out_413041.awb")
					end

					arg_312_1:RecordHistoryTalkVoice("story_v_out_413041", "413041077", "story_v_out_413041.awb")
				end

				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_19 = math.max(var_315_12, arg_312_1.talkMaxDuration)

			if var_315_11 <= arg_312_1.time_ and arg_312_1.time_ < var_315_11 + var_315_19 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - var_315_11) / var_315_19

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= var_315_11 + var_315_19 and arg_312_1.time_ < var_315_11 + var_315_19 + arg_315_0 then
				arg_312_1.typewritter.percent = 1

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(true)
			end
		end

		arg_312_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10022",
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
	Play413041078 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 413041078
		arg_316_1.duration_ = 8.03

		local var_316_0 = {
			zh = 8.033,
			ja = 7.266
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
				arg_316_0:Play413041079(arg_316_1)
			end
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			if 0 < arg_316_1.time_ and arg_316_1.time_ <= 0 + arg_319_0 then
				arg_316_1.var_.moveOldPos10092 = arg_316_1.actors_["10092"].transform.localPosition
				arg_316_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_316_1:CheckSpriteTmpPos("10092", 3)

				for iter_319_0 = 0, arg_316_1.actors_["10092"].transform.childCount - 1 do
					local var_319_0 = arg_316_1.actors_["10092"].transform:GetChild(iter_319_0)

					if var_319_0.name == "split_2" or not string.find(var_319_0.name, "split") then
						var_319_0.gameObject:SetActive(true)
					else
						var_319_0.gameObject:SetActive(false)
					end
				end
			end

			local var_319_1 = 0.001

			if 0 <= arg_316_1.time_ and arg_316_1.time_ < 0 + var_319_1 then
				arg_316_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_316_1.var_.moveOldPos10092, Vector3.New(0, -300, -295), (arg_316_1.time_ - 0) / var_319_1)
			end

			if arg_316_1.time_ >= 0 + var_319_1 and arg_316_1.time_ < 0 + var_319_1 + arg_319_0 then
				arg_316_1.actors_["10092"].transform.localPosition = Vector3.New(0, -300, -295)
			end

			local var_319_2 = arg_316_1.actors_["10022"].transform

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= 0 + arg_319_0 then
				arg_316_1.var_.moveOldPos10022 = var_319_2.localPosition
				var_319_2.localScale = Vector3.New(1, 1, 1)

				arg_316_1:CheckSpriteTmpPos("10022", 0)

				for iter_319_1 = 0, var_319_2.childCount - 1 do
					local var_319_3 = var_319_2:GetChild(iter_319_1)

					if var_319_3.name == "split_1" or not string.find(var_319_3.name, "split") then
						var_319_3.gameObject:SetActive(true)
					else
						var_319_3.gameObject:SetActive(false)
					end
				end
			end

			local var_319_4 = 0.001

			if 0 <= arg_316_1.time_ and arg_316_1.time_ < 0 + var_319_4 then
				var_319_2.localPosition = Vector3.Lerp(arg_316_1.var_.moveOldPos10022, Vector3.New(0, -5000, 0), (arg_316_1.time_ - 0) / var_319_4)
			end

			if arg_316_1.time_ >= 0 + var_319_4 and arg_316_1.time_ < 0 + var_319_4 + arg_319_0 then
				var_319_2.localPosition = Vector3.New(0, -5000, 0)
			end

			local var_319_5 = arg_316_1.actors_["10092"]

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= 0 + arg_319_0 and not isNil(var_319_5) and arg_316_1.var_.actorSpriteComps10092 == nil then
				arg_316_1.var_.actorSpriteComps10092 = var_319_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_319_6 = 2

			if 0 <= arg_316_1.time_ and arg_316_1.time_ < 0 + var_319_6 and not isNil(var_319_5) then
				if arg_316_1.var_.actorSpriteComps10092 then
					for iter_319_2, iter_319_3 in pairs(arg_316_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_319_3 then
							if arg_316_1.isInRecall_ then
								iter_319_3.color = Color.New(Mathf.Lerp(iter_319_3.color.r, arg_316_1.hightColor1.r, (arg_316_1.time_ - 0) / var_319_6), Mathf.Lerp(iter_319_3.color.g, arg_316_1.hightColor1.g, (arg_316_1.time_ - 0) / var_319_6), (Mathf.Lerp(iter_319_3.color.b, arg_316_1.hightColor1.b, (arg_316_1.time_ - 0) / var_319_6)))
							else
								local var_319_7 = Mathf.Lerp(iter_319_3.color.r, 1, (arg_316_1.time_ - 0) / var_319_6)

								iter_319_3.color = Color.New(var_319_7, var_319_7, var_319_7)
							end
						end
					end
				end
			end

			if arg_316_1.time_ >= 0 + var_319_6 and arg_316_1.time_ < 0 + var_319_6 + arg_319_0 and not isNil(var_319_5) and arg_316_1.var_.actorSpriteComps10092 then
				for iter_319_4, iter_319_5 in pairs(arg_316_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_319_5 then
						iter_319_5.color = arg_316_1.isInRecall_ and (arg_316_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_316_1.var_.actorSpriteComps10092 = nil
			end

			local var_319_8 = arg_316_1.actors_["10022"]

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= 0 + arg_319_0 and not isNil(var_319_8) and arg_316_1.var_.actorSpriteComps10022 == nil then
				arg_316_1.var_.actorSpriteComps10022 = var_319_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_319_9 = 2

			if 0 <= arg_316_1.time_ and arg_316_1.time_ < 0 + var_319_9 and not isNil(var_319_8) then
				if arg_316_1.var_.actorSpriteComps10022 then
					for iter_319_6, iter_319_7 in pairs(arg_316_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_319_7 then
							if arg_316_1.isInRecall_ then
								iter_319_7.color = Color.New(Mathf.Lerp(iter_319_7.color.r, arg_316_1.hightColor2.r, (arg_316_1.time_ - 0) / var_319_9), Mathf.Lerp(iter_319_7.color.g, arg_316_1.hightColor2.g, (arg_316_1.time_ - 0) / var_319_9), (Mathf.Lerp(iter_319_7.color.b, arg_316_1.hightColor2.b, (arg_316_1.time_ - 0) / var_319_9)))
							else
								local var_319_10 = Mathf.Lerp(iter_319_7.color.r, 0.5, (arg_316_1.time_ - 0) / var_319_9)

								iter_319_7.color = Color.New(var_319_10, var_319_10, var_319_10)
							end
						end
					end
				end
			end

			if arg_316_1.time_ >= 0 + var_319_9 and arg_316_1.time_ < 0 + var_319_9 + arg_319_0 and not isNil(var_319_8) and arg_316_1.var_.actorSpriteComps10022 then
				for iter_319_8, iter_319_9 in pairs(arg_316_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_319_9 then
						iter_319_9.color = arg_316_1.isInRecall_ and (arg_316_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_316_1.var_.actorSpriteComps10022 = nil
			end

			local var_319_11 = 0
			local var_319_12 = 0.85

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= var_319_11 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0
				arg_316_1.dialogCg_.alpha = 1

				arg_316_1.dialog_:SetActive(true)
				SetActive(arg_316_1.leftNameGo_, true)

				arg_316_1.leftNameTxt_.text = arg_316_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_316_1.leftNameTxt_.transform)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1.leftNameTxt_.text)
				SetActive(arg_316_1.iconTrs_.gameObject, false)
				arg_316_1.callingController_:SetSelectedState("normal")

				local var_319_13 = arg_316_1:GetWordFromCfg(413041078)
				local var_319_14 = arg_316_1:FormatText(var_319_13.content)

				arg_316_1.text_.text = var_319_14

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_16 = 34 <= 0 and var_319_12 or var_319_12 * (utf8.len(var_319_14) / 34)

				if (34 <= 0 and var_319_12 or var_319_12 * (utf8.len(var_319_14) / 34)) > 0 and var_319_12 < var_319_16 then
					arg_316_1.talkMaxDuration = var_319_16

					if var_319_16 + var_319_11 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_16 + var_319_11
					end
				end

				arg_316_1.text_.text = var_319_14
				arg_316_1.typewritter.percent = 0

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413041", "413041078", "story_v_out_413041.awb") ~= 0 then
					local var_319_17 = manager.audio:GetVoiceLength("story_v_out_413041", "413041078", "story_v_out_413041.awb") / 1000

					if var_319_17 + var_319_11 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_17 + var_319_11
					end

					if var_319_13.prefab_name ~= "" and arg_316_1.actors_[var_319_13.prefab_name] ~= nil then
						local var_319_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_316_1.actors_[var_319_13.prefab_name].transform, "story_v_out_413041", "413041078", "story_v_out_413041.awb")

						arg_316_1:RecordAudio("413041078", var_319_18)
						arg_316_1:RecordAudio("413041078", var_319_18)
					else
						arg_316_1:AudioAction("play", "voice", "story_v_out_413041", "413041078", "story_v_out_413041.awb")
					end

					arg_316_1:RecordHistoryTalkVoice("story_v_out_413041", "413041078", "story_v_out_413041.awb")
				end

				arg_316_1:RecordContent(arg_316_1.text_.text)
			end

			local var_319_19 = math.max(var_319_12, arg_316_1.talkMaxDuration)

			if var_319_11 <= arg_316_1.time_ and arg_316_1.time_ < var_319_11 + var_319_19 then
				arg_316_1.typewritter.percent = (arg_316_1.time_ - var_319_11) / var_319_19

				arg_316_1.typewritter:SetDirty()
			end

			if arg_316_1.time_ >= var_319_11 + var_319_19 and arg_316_1.time_ < var_319_11 + var_319_19 + arg_319_0 then
				arg_316_1.typewritter.percent = 1

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(true)
			end
		end

		arg_316_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_316_1:InitPlayNodeList()
	end,
	Play413041079 = function(arg_320_0, arg_320_1)
		arg_320_1.time_ = 0
		arg_320_1.frameCnt_ = 0
		arg_320_1.state_ = "playing"
		arg_320_1.curTalkId_ = 413041079
		arg_320_1.duration_ = 8.13

		local var_320_0 = {
			zh = 6.466,
			ja = 8.133
		}
		local var_320_1 = manager.audio:GetLocalizationFlag()

		if var_320_0[var_320_1] ~= nil then
			arg_320_1.duration_ = var_320_0[var_320_1]
		end

		SetActive(arg_320_1.tipsGo_, false)

		function arg_320_1.onSingleLineFinish_()
			arg_320_1.onSingleLineUpdate_ = nil
			arg_320_1.onSingleLineFinish_ = nil
			arg_320_1.state_ = "waiting"
		end

		function arg_320_1.playNext_(arg_322_0)
			if arg_322_0 == 1 then
				arg_320_0:Play413041080(arg_320_1)
			end
		end

		function arg_320_1.onSingleLineUpdate_(arg_323_0)
			local var_323_0 = 0.9

			if 0 < arg_320_1.time_ and arg_320_1.time_ <= 0 + arg_323_0 then
				arg_320_1.talkMaxDuration = 0
				arg_320_1.dialogCg_.alpha = 1

				arg_320_1.dialog_:SetActive(true)
				SetActive(arg_320_1.leftNameGo_, true)

				arg_320_1.leftNameTxt_.text = arg_320_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_320_1.leftNameTxt_.transform)

				arg_320_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_320_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_320_1:RecordName(arg_320_1.leftNameTxt_.text)
				SetActive(arg_320_1.iconTrs_.gameObject, false)
				arg_320_1.callingController_:SetSelectedState("normal")

				local var_323_1 = arg_320_1:GetWordFromCfg(413041079)
				local var_323_2 = arg_320_1:FormatText(var_323_1.content)

				arg_320_1.text_.text = var_323_2

				LuaForUtil.ClearLinePrefixSymbol(arg_320_1.text_)

				local var_323_4 = 36 <= 0 and var_323_0 or var_323_0 * (utf8.len(var_323_2) / 36)

				if (36 <= 0 and var_323_0 or var_323_0 * (utf8.len(var_323_2) / 36)) > 0 and var_323_0 < var_323_4 then
					arg_320_1.talkMaxDuration = var_323_4

					if var_323_4 + 0 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_4 + 0
					end
				end

				arg_320_1.text_.text = var_323_2
				arg_320_1.typewritter.percent = 0

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413041", "413041079", "story_v_out_413041.awb") ~= 0 then
					local var_323_5 = manager.audio:GetVoiceLength("story_v_out_413041", "413041079", "story_v_out_413041.awb") / 1000

					if var_323_5 + 0 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_5 + 0
					end

					if var_323_1.prefab_name ~= "" and arg_320_1.actors_[var_323_1.prefab_name] ~= nil then
						local var_323_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_320_1.actors_[var_323_1.prefab_name].transform, "story_v_out_413041", "413041079", "story_v_out_413041.awb")

						arg_320_1:RecordAudio("413041079", var_323_6)
						arg_320_1:RecordAudio("413041079", var_323_6)
					else
						arg_320_1:AudioAction("play", "voice", "story_v_out_413041", "413041079", "story_v_out_413041.awb")
					end

					arg_320_1:RecordHistoryTalkVoice("story_v_out_413041", "413041079", "story_v_out_413041.awb")
				end

				arg_320_1:RecordContent(arg_320_1.text_.text)
			end

			local var_323_7 = math.max(var_323_0, arg_320_1.talkMaxDuration)

			if 0 <= arg_320_1.time_ and arg_320_1.time_ < 0 + var_323_7 then
				arg_320_1.typewritter.percent = (arg_320_1.time_ - 0) / var_323_7

				arg_320_1.typewritter:SetDirty()
			end

			if arg_320_1.time_ >= 0 + var_323_7 and arg_320_1.time_ < 0 + var_323_7 + arg_323_0 then
				arg_320_1.typewritter.percent = 1

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(true)
			end
		end

		arg_320_1.nodeConfigList_ = {}

		arg_320_1:InitPlayNodeList()
	end,
	Play413041080 = function(arg_324_0, arg_324_1)
		arg_324_1.time_ = 0
		arg_324_1.frameCnt_ = 0
		arg_324_1.state_ = "playing"
		arg_324_1.curTalkId_ = 413041080
		arg_324_1.duration_ = 10.23

		local var_324_0 = {
			zh = 5.7,
			ja = 10.233
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
				arg_324_0:Play413041081(arg_324_1)
			end
		end

		function arg_324_1.onSingleLineUpdate_(arg_327_0)
			if 0 < arg_324_1.time_ and arg_324_1.time_ <= 0 + arg_327_0 then
				arg_324_1.var_.moveOldPos10094 = arg_324_1.actors_["10094"].transform.localPosition
				arg_324_1.actors_["10094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_324_1:CheckSpriteTmpPos("10094", 3)

				for iter_327_0 = 0, arg_324_1.actors_["10094"].transform.childCount - 1 do
					local var_327_0 = arg_324_1.actors_["10094"].transform:GetChild(iter_327_0)

					if var_327_0.name == "" or not string.find(var_327_0.name, "split") then
						var_327_0.gameObject:SetActive(true)
					else
						var_327_0.gameObject:SetActive(false)
					end
				end
			end

			local var_327_1 = 0.001

			if 0 <= arg_324_1.time_ and arg_324_1.time_ < 0 + var_327_1 then
				arg_324_1.actors_["10094"].transform.localPosition = Vector3.Lerp(arg_324_1.var_.moveOldPos10094, Vector3.New(0, -340, -414), (arg_324_1.time_ - 0) / var_327_1)
			end

			if arg_324_1.time_ >= 0 + var_327_1 and arg_324_1.time_ < 0 + var_327_1 + arg_327_0 then
				arg_324_1.actors_["10094"].transform.localPosition = Vector3.New(0, -340, -414)
			end

			local var_327_2 = arg_324_1.actors_["10092"].transform

			if 0 < arg_324_1.time_ and arg_324_1.time_ <= 0 + arg_327_0 then
				arg_324_1.var_.moveOldPos10092 = var_327_2.localPosition
				var_327_2.localScale = Vector3.New(1, 1, 1)

				arg_324_1:CheckSpriteTmpPos("10092", 0)

				for iter_327_1 = 0, var_327_2.childCount - 1 do
					local var_327_3 = var_327_2:GetChild(iter_327_1)

					if var_327_3.name == "" or not string.find(var_327_3.name, "split") then
						var_327_3.gameObject:SetActive(true)
					else
						var_327_3.gameObject:SetActive(false)
					end
				end
			end

			local var_327_4 = 0.001

			if 0 <= arg_324_1.time_ and arg_324_1.time_ < 0 + var_327_4 then
				var_327_2.localPosition = Vector3.Lerp(arg_324_1.var_.moveOldPos10092, Vector3.New(0, -5000, 0), (arg_324_1.time_ - 0) / var_327_4)
			end

			if arg_324_1.time_ >= 0 + var_327_4 and arg_324_1.time_ < 0 + var_327_4 + arg_327_0 then
				var_327_2.localPosition = Vector3.New(0, -5000, 0)
			end

			local var_327_5 = arg_324_1.actors_["10094"]

			if 0 < arg_324_1.time_ and arg_324_1.time_ <= 0 + arg_327_0 and not isNil(var_327_5) and arg_324_1.var_.actorSpriteComps10094 == nil then
				arg_324_1.var_.actorSpriteComps10094 = var_327_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_327_6 = 2

			if 0 <= arg_324_1.time_ and arg_324_1.time_ < 0 + var_327_6 and not isNil(var_327_5) then
				if arg_324_1.var_.actorSpriteComps10094 then
					for iter_327_2, iter_327_3 in pairs(arg_324_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_327_3 then
							if arg_324_1.isInRecall_ then
								iter_327_3.color = Color.New(Mathf.Lerp(iter_327_3.color.r, arg_324_1.hightColor1.r, (arg_324_1.time_ - 0) / var_327_6), Mathf.Lerp(iter_327_3.color.g, arg_324_1.hightColor1.g, (arg_324_1.time_ - 0) / var_327_6), (Mathf.Lerp(iter_327_3.color.b, arg_324_1.hightColor1.b, (arg_324_1.time_ - 0) / var_327_6)))
							else
								local var_327_7 = Mathf.Lerp(iter_327_3.color.r, 1, (arg_324_1.time_ - 0) / var_327_6)

								iter_327_3.color = Color.New(var_327_7, var_327_7, var_327_7)
							end
						end
					end
				end
			end

			if arg_324_1.time_ >= 0 + var_327_6 and arg_324_1.time_ < 0 + var_327_6 + arg_327_0 and not isNil(var_327_5) and arg_324_1.var_.actorSpriteComps10094 then
				for iter_327_4, iter_327_5 in pairs(arg_324_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_327_5 then
						iter_327_5.color = arg_324_1.isInRecall_ and (arg_324_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_324_1.var_.actorSpriteComps10094 = nil
			end

			local var_327_8 = arg_324_1.actors_["10092"]

			if 0 < arg_324_1.time_ and arg_324_1.time_ <= 0 + arg_327_0 and not isNil(var_327_8) and arg_324_1.var_.actorSpriteComps10092 == nil then
				arg_324_1.var_.actorSpriteComps10092 = var_327_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_327_9 = 2

			if 0 <= arg_324_1.time_ and arg_324_1.time_ < 0 + var_327_9 and not isNil(var_327_8) then
				if arg_324_1.var_.actorSpriteComps10092 then
					for iter_327_6, iter_327_7 in pairs(arg_324_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_327_7 then
							if arg_324_1.isInRecall_ then
								iter_327_7.color = Color.New(Mathf.Lerp(iter_327_7.color.r, arg_324_1.hightColor2.r, (arg_324_1.time_ - 0) / var_327_9), Mathf.Lerp(iter_327_7.color.g, arg_324_1.hightColor2.g, (arg_324_1.time_ - 0) / var_327_9), (Mathf.Lerp(iter_327_7.color.b, arg_324_1.hightColor2.b, (arg_324_1.time_ - 0) / var_327_9)))
							else
								local var_327_10 = Mathf.Lerp(iter_327_7.color.r, 0.5, (arg_324_1.time_ - 0) / var_327_9)

								iter_327_7.color = Color.New(var_327_10, var_327_10, var_327_10)
							end
						end
					end
				end
			end

			if arg_324_1.time_ >= 0 + var_327_9 and arg_324_1.time_ < 0 + var_327_9 + arg_327_0 and not isNil(var_327_8) and arg_324_1.var_.actorSpriteComps10092 then
				for iter_327_8, iter_327_9 in pairs(arg_324_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_327_9 then
						iter_327_9.color = arg_324_1.isInRecall_ and (arg_324_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_324_1.var_.actorSpriteComps10092 = nil
			end

			local var_327_11 = 0
			local var_327_12 = 0.675

			if 0 < arg_324_1.time_ and arg_324_1.time_ <= var_327_11 + arg_327_0 then
				arg_324_1.talkMaxDuration = 0
				arg_324_1.dialogCg_.alpha = 1

				arg_324_1.dialog_:SetActive(true)
				SetActive(arg_324_1.leftNameGo_, true)

				arg_324_1.leftNameTxt_.text = arg_324_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_324_1.leftNameTxt_.transform)

				arg_324_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_324_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_324_1:RecordName(arg_324_1.leftNameTxt_.text)
				SetActive(arg_324_1.iconTrs_.gameObject, false)
				arg_324_1.callingController_:SetSelectedState("normal")

				local var_327_13 = arg_324_1:GetWordFromCfg(413041080)
				local var_327_14 = arg_324_1:FormatText(var_327_13.content)

				arg_324_1.text_.text = var_327_14

				LuaForUtil.ClearLinePrefixSymbol(arg_324_1.text_)

				local var_327_16 = 27 <= 0 and var_327_12 or var_327_12 * (utf8.len(var_327_14) / 27)

				if (27 <= 0 and var_327_12 or var_327_12 * (utf8.len(var_327_14) / 27)) > 0 and var_327_12 < var_327_16 then
					arg_324_1.talkMaxDuration = var_327_16

					if var_327_16 + var_327_11 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_16 + var_327_11
					end
				end

				arg_324_1.text_.text = var_327_14
				arg_324_1.typewritter.percent = 0

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413041", "413041080", "story_v_out_413041.awb") ~= 0 then
					local var_327_17 = manager.audio:GetVoiceLength("story_v_out_413041", "413041080", "story_v_out_413041.awb") / 1000

					if var_327_17 + var_327_11 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_17 + var_327_11
					end

					if var_327_13.prefab_name ~= "" and arg_324_1.actors_[var_327_13.prefab_name] ~= nil then
						local var_327_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_324_1.actors_[var_327_13.prefab_name].transform, "story_v_out_413041", "413041080", "story_v_out_413041.awb")

						arg_324_1:RecordAudio("413041080", var_327_18)
						arg_324_1:RecordAudio("413041080", var_327_18)
					else
						arg_324_1:AudioAction("play", "voice", "story_v_out_413041", "413041080", "story_v_out_413041.awb")
					end

					arg_324_1:RecordHistoryTalkVoice("story_v_out_413041", "413041080", "story_v_out_413041.awb")
				end

				arg_324_1:RecordContent(arg_324_1.text_.text)
			end

			local var_327_19 = math.max(var_327_12, arg_324_1.talkMaxDuration)

			if var_327_11 <= arg_324_1.time_ and arg_324_1.time_ < var_327_11 + var_327_19 then
				arg_324_1.typewritter.percent = (arg_324_1.time_ - var_327_11) / var_327_19

				arg_324_1.typewritter:SetDirty()
			end

			if arg_324_1.time_ >= var_327_11 + var_327_19 and arg_324_1.time_ < var_327_11 + var_327_19 + arg_327_0 then
				arg_324_1.typewritter.percent = 1

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(true)
			end
		end

		arg_324_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10092",
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
	Play413041081 = function(arg_328_0, arg_328_1)
		arg_328_1.time_ = 0
		arg_328_1.frameCnt_ = 0
		arg_328_1.state_ = "playing"
		arg_328_1.curTalkId_ = 413041081
		arg_328_1.duration_ = 2

		SetActive(arg_328_1.tipsGo_, false)

		function arg_328_1.onSingleLineFinish_()
			arg_328_1.onSingleLineUpdate_ = nil
			arg_328_1.onSingleLineFinish_ = nil
			arg_328_1.state_ = "waiting"
		end

		function arg_328_1.playNext_(arg_330_0)
			if arg_330_0 == 1 then
				arg_328_0:Play413041082(arg_328_1)
			end
		end

		function arg_328_1.onSingleLineUpdate_(arg_331_0)
			if 0 < arg_328_1.time_ and arg_328_1.time_ <= 0 + arg_331_0 then
				arg_328_1.var_.moveOldPos10092 = arg_328_1.actors_["10092"].transform.localPosition
				arg_328_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_328_1:CheckSpriteTmpPos("10092", 3)

				for iter_331_0 = 0, arg_328_1.actors_["10092"].transform.childCount - 1 do
					local var_331_0 = arg_328_1.actors_["10092"].transform:GetChild(iter_331_0)

					if var_331_0.name == "" or not string.find(var_331_0.name, "split") then
						var_331_0.gameObject:SetActive(true)
					else
						var_331_0.gameObject:SetActive(false)
					end
				end
			end

			local var_331_1 = 0.001

			if 0 <= arg_328_1.time_ and arg_328_1.time_ < 0 + var_331_1 then
				arg_328_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_328_1.var_.moveOldPos10092, Vector3.New(0, -300, -295), (arg_328_1.time_ - 0) / var_331_1)
			end

			if arg_328_1.time_ >= 0 + var_331_1 and arg_328_1.time_ < 0 + var_331_1 + arg_331_0 then
				arg_328_1.actors_["10092"].transform.localPosition = Vector3.New(0, -300, -295)
			end

			local var_331_2 = arg_328_1.actors_["10094"].transform

			if 0 < arg_328_1.time_ and arg_328_1.time_ <= 0 + arg_331_0 then
				arg_328_1.var_.moveOldPos10094 = var_331_2.localPosition
				var_331_2.localScale = Vector3.New(1, 1, 1)

				arg_328_1:CheckSpriteTmpPos("10094", 0)

				for iter_331_1 = 0, var_331_2.childCount - 1 do
					local var_331_3 = var_331_2:GetChild(iter_331_1)

					if var_331_3.name == "" or not string.find(var_331_3.name, "split") then
						var_331_3.gameObject:SetActive(true)
					else
						var_331_3.gameObject:SetActive(false)
					end
				end
			end

			local var_331_4 = 0.001

			if 0 <= arg_328_1.time_ and arg_328_1.time_ < 0 + var_331_4 then
				var_331_2.localPosition = Vector3.Lerp(arg_328_1.var_.moveOldPos10094, Vector3.New(0, -5000, 0), (arg_328_1.time_ - 0) / var_331_4)
			end

			if arg_328_1.time_ >= 0 + var_331_4 and arg_328_1.time_ < 0 + var_331_4 + arg_331_0 then
				var_331_2.localPosition = Vector3.New(0, -5000, 0)
			end

			local var_331_5 = arg_328_1.actors_["10092"]

			if 0 < arg_328_1.time_ and arg_328_1.time_ <= 0 + arg_331_0 and not isNil(var_331_5) and arg_328_1.var_.actorSpriteComps10092 == nil then
				arg_328_1.var_.actorSpriteComps10092 = var_331_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_331_6 = 2

			if 0 <= arg_328_1.time_ and arg_328_1.time_ < 0 + var_331_6 and not isNil(var_331_5) then
				if arg_328_1.var_.actorSpriteComps10092 then
					for iter_331_2, iter_331_3 in pairs(arg_328_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_331_3 then
							if arg_328_1.isInRecall_ then
								iter_331_3.color = Color.New(Mathf.Lerp(iter_331_3.color.r, arg_328_1.hightColor1.r, (arg_328_1.time_ - 0) / var_331_6), Mathf.Lerp(iter_331_3.color.g, arg_328_1.hightColor1.g, (arg_328_1.time_ - 0) / var_331_6), (Mathf.Lerp(iter_331_3.color.b, arg_328_1.hightColor1.b, (arg_328_1.time_ - 0) / var_331_6)))
							else
								local var_331_7 = Mathf.Lerp(iter_331_3.color.r, 1, (arg_328_1.time_ - 0) / var_331_6)

								iter_331_3.color = Color.New(var_331_7, var_331_7, var_331_7)
							end
						end
					end
				end
			end

			if arg_328_1.time_ >= 0 + var_331_6 and arg_328_1.time_ < 0 + var_331_6 + arg_331_0 and not isNil(var_331_5) and arg_328_1.var_.actorSpriteComps10092 then
				for iter_331_4, iter_331_5 in pairs(arg_328_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_331_5 then
						iter_331_5.color = arg_328_1.isInRecall_ and (arg_328_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_328_1.var_.actorSpriteComps10092 = nil
			end

			local var_331_8 = arg_328_1.actors_["10094"]

			if 0 < arg_328_1.time_ and arg_328_1.time_ <= 0 + arg_331_0 and not isNil(var_331_8) and arg_328_1.var_.actorSpriteComps10094 == nil then
				arg_328_1.var_.actorSpriteComps10094 = var_331_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_331_9 = 2

			if 0 <= arg_328_1.time_ and arg_328_1.time_ < 0 + var_331_9 and not isNil(var_331_8) then
				if arg_328_1.var_.actorSpriteComps10094 then
					for iter_331_6, iter_331_7 in pairs(arg_328_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_331_7 then
							if arg_328_1.isInRecall_ then
								iter_331_7.color = Color.New(Mathf.Lerp(iter_331_7.color.r, arg_328_1.hightColor2.r, (arg_328_1.time_ - 0) / var_331_9), Mathf.Lerp(iter_331_7.color.g, arg_328_1.hightColor2.g, (arg_328_1.time_ - 0) / var_331_9), (Mathf.Lerp(iter_331_7.color.b, arg_328_1.hightColor2.b, (arg_328_1.time_ - 0) / var_331_9)))
							else
								local var_331_10 = Mathf.Lerp(iter_331_7.color.r, 0.5, (arg_328_1.time_ - 0) / var_331_9)

								iter_331_7.color = Color.New(var_331_10, var_331_10, var_331_10)
							end
						end
					end
				end
			end

			if arg_328_1.time_ >= 0 + var_331_9 and arg_328_1.time_ < 0 + var_331_9 + arg_331_0 and not isNil(var_331_8) and arg_328_1.var_.actorSpriteComps10094 then
				for iter_331_8, iter_331_9 in pairs(arg_328_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_331_9 then
						iter_331_9.color = arg_328_1.isInRecall_ and (arg_328_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_328_1.var_.actorSpriteComps10094 = nil
			end

			local var_331_11 = 0
			local var_331_12 = 0.125

			if 0 < arg_328_1.time_ and arg_328_1.time_ <= var_331_11 + arg_331_0 then
				arg_328_1.talkMaxDuration = 0
				arg_328_1.dialogCg_.alpha = 1

				arg_328_1.dialog_:SetActive(true)
				SetActive(arg_328_1.leftNameGo_, true)

				arg_328_1.leftNameTxt_.text = arg_328_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_328_1.leftNameTxt_.transform)

				arg_328_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_328_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_328_1:RecordName(arg_328_1.leftNameTxt_.text)
				SetActive(arg_328_1.iconTrs_.gameObject, false)
				arg_328_1.callingController_:SetSelectedState("normal")

				local var_331_13 = arg_328_1:GetWordFromCfg(413041081)
				local var_331_14 = arg_328_1:FormatText(var_331_13.content)

				arg_328_1.text_.text = var_331_14

				LuaForUtil.ClearLinePrefixSymbol(arg_328_1.text_)

				local var_331_16 = 5 <= 0 and var_331_12 or var_331_12 * (utf8.len(var_331_14) / 5)

				if (5 <= 0 and var_331_12 or var_331_12 * (utf8.len(var_331_14) / 5)) > 0 and var_331_12 < var_331_16 then
					arg_328_1.talkMaxDuration = var_331_16

					if var_331_16 + var_331_11 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_16 + var_331_11
					end
				end

				arg_328_1.text_.text = var_331_14
				arg_328_1.typewritter.percent = 0

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413041", "413041081", "story_v_out_413041.awb") ~= 0 then
					local var_331_17 = manager.audio:GetVoiceLength("story_v_out_413041", "413041081", "story_v_out_413041.awb") / 1000

					if var_331_17 + var_331_11 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_17 + var_331_11
					end

					if var_331_13.prefab_name ~= "" and arg_328_1.actors_[var_331_13.prefab_name] ~= nil then
						local var_331_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_328_1.actors_[var_331_13.prefab_name].transform, "story_v_out_413041", "413041081", "story_v_out_413041.awb")

						arg_328_1:RecordAudio("413041081", var_331_18)
						arg_328_1:RecordAudio("413041081", var_331_18)
					else
						arg_328_1:AudioAction("play", "voice", "story_v_out_413041", "413041081", "story_v_out_413041.awb")
					end

					arg_328_1:RecordHistoryTalkVoice("story_v_out_413041", "413041081", "story_v_out_413041.awb")
				end

				arg_328_1:RecordContent(arg_328_1.text_.text)
			end

			local var_331_19 = math.max(var_331_12, arg_328_1.talkMaxDuration)

			if var_331_11 <= arg_328_1.time_ and arg_328_1.time_ < var_331_11 + var_331_19 then
				arg_328_1.typewritter.percent = (arg_328_1.time_ - var_331_11) / var_331_19

				arg_328_1.typewritter:SetDirty()
			end

			if arg_328_1.time_ >= var_331_11 + var_331_19 and arg_328_1.time_ < var_331_11 + var_331_19 + arg_331_0 then
				arg_328_1.typewritter.percent = 1

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(true)
			end
		end

		arg_328_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10094",
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
	Play413041082 = function(arg_332_0, arg_332_1)
		arg_332_1.time_ = 0
		arg_332_1.frameCnt_ = 0
		arg_332_1.state_ = "playing"
		arg_332_1.curTalkId_ = 413041082
		arg_332_1.duration_ = 5

		SetActive(arg_332_1.tipsGo_, false)

		function arg_332_1.onSingleLineFinish_()
			arg_332_1.onSingleLineUpdate_ = nil
			arg_332_1.onSingleLineFinish_ = nil
			arg_332_1.state_ = "waiting"
		end

		function arg_332_1.playNext_(arg_334_0)
			if arg_334_0 == 1 then
				arg_332_0:Play413041083(arg_332_1)
			end
		end

		function arg_332_1.onSingleLineUpdate_(arg_335_0)
			if 0 < arg_332_1.time_ and arg_332_1.time_ <= 0 + arg_335_0 then
				arg_332_1.var_.moveOldPos10092 = arg_332_1.actors_["10092"].transform.localPosition
				arg_332_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_332_1:CheckSpriteTmpPos("10092", 3)

				for iter_335_0 = 0, arg_332_1.actors_["10092"].transform.childCount - 1 do
					local var_335_0 = arg_332_1.actors_["10092"].transform:GetChild(iter_335_0)

					if var_335_0.name == "" or not string.find(var_335_0.name, "split") then
						var_335_0.gameObject:SetActive(true)
					else
						var_335_0.gameObject:SetActive(false)
					end
				end
			end

			local var_335_1 = 0.001

			if 0 <= arg_332_1.time_ and arg_332_1.time_ < 0 + var_335_1 then
				arg_332_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_332_1.var_.moveOldPos10092, Vector3.New(0, -300, -295), (arg_332_1.time_ - 0) / var_335_1)
			end

			if arg_332_1.time_ >= 0 + var_335_1 and arg_332_1.time_ < 0 + var_335_1 + arg_335_0 then
				arg_332_1.actors_["10092"].transform.localPosition = Vector3.New(0, -300, -295)
			end

			local var_335_2 = arg_332_1.actors_["10092"]

			if 0 < arg_332_1.time_ and arg_332_1.time_ <= 0 + arg_335_0 and not isNil(var_335_2) and arg_332_1.var_.actorSpriteComps10092 == nil then
				arg_332_1.var_.actorSpriteComps10092 = var_335_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_335_3 = 2

			if 0 <= arg_332_1.time_ and arg_332_1.time_ < 0 + var_335_3 and not isNil(var_335_2) then
				if arg_332_1.var_.actorSpriteComps10092 then
					for iter_335_1, iter_335_2 in pairs(arg_332_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_335_2 then
							if arg_332_1.isInRecall_ then
								iter_335_2.color = Color.New(Mathf.Lerp(iter_335_2.color.r, arg_332_1.hightColor2.r, (arg_332_1.time_ - 0) / var_335_3), Mathf.Lerp(iter_335_2.color.g, arg_332_1.hightColor2.g, (arg_332_1.time_ - 0) / var_335_3), (Mathf.Lerp(iter_335_2.color.b, arg_332_1.hightColor2.b, (arg_332_1.time_ - 0) / var_335_3)))
							else
								local var_335_4 = Mathf.Lerp(iter_335_2.color.r, 0.5, (arg_332_1.time_ - 0) / var_335_3)

								iter_335_2.color = Color.New(var_335_4, var_335_4, var_335_4)
							end
						end
					end
				end
			end

			if arg_332_1.time_ >= 0 + var_335_3 and arg_332_1.time_ < 0 + var_335_3 + arg_335_0 and not isNil(var_335_2) and arg_332_1.var_.actorSpriteComps10092 then
				for iter_335_3, iter_335_4 in pairs(arg_332_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_335_4 then
						iter_335_4.color = arg_332_1.isInRecall_ and (arg_332_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_332_1.var_.actorSpriteComps10092 = nil
			end

			local var_335_5 = 0
			local var_335_6 = 1.325

			if 0 < arg_332_1.time_ and arg_332_1.time_ <= var_335_5 + arg_335_0 then
				arg_332_1.talkMaxDuration = 0
				arg_332_1.dialogCg_.alpha = 1

				arg_332_1.dialog_:SetActive(true)
				SetActive(arg_332_1.leftNameGo_, false)

				arg_332_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_332_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_332_1:RecordName(arg_332_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_332_1.iconTrs_.gameObject, false)
				arg_332_1.callingController_:SetSelectedState("normal")

				local var_335_7 = arg_332_1:FormatText(arg_332_1:GetWordFromCfg(413041082).content)

				arg_332_1.text_.text = var_335_7

				LuaForUtil.ClearLinePrefixSymbol(arg_332_1.text_)

				local var_335_9 = 53 <= 0 and var_335_6 or var_335_6 * (utf8.len(var_335_7) / 53)

				if (53 <= 0 and var_335_6 or var_335_6 * (utf8.len(var_335_7) / 53)) > 0 and var_335_6 < var_335_9 then
					arg_332_1.talkMaxDuration = var_335_9

					if var_335_9 + var_335_5 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_9 + var_335_5
					end
				end

				arg_332_1.text_.text = var_335_7
				arg_332_1.typewritter.percent = 0

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(false)
				arg_332_1:RecordContent(arg_332_1.text_.text)
			end

			local var_335_10 = math.max(var_335_6, arg_332_1.talkMaxDuration)

			if var_335_5 <= arg_332_1.time_ and arg_332_1.time_ < var_335_5 + var_335_10 then
				arg_332_1.typewritter.percent = (arg_332_1.time_ - var_335_5) / var_335_10

				arg_332_1.typewritter:SetDirty()
			end

			if arg_332_1.time_ >= var_335_5 + var_335_10 and arg_332_1.time_ < var_335_5 + var_335_10 + arg_335_0 then
				arg_332_1.typewritter.percent = 1

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(true)
			end
		end

		arg_332_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_332_1:InitPlayNodeList()
	end,
	Play413041083 = function(arg_336_0, arg_336_1)
		arg_336_1.time_ = 0
		arg_336_1.frameCnt_ = 0
		arg_336_1.state_ = "playing"
		arg_336_1.curTalkId_ = 413041083
		arg_336_1.duration_ = 15.7

		local var_336_0 = {
			zh = 7.8,
			ja = 15.7
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
				arg_336_0:Play413041084(arg_336_1)
			end
		end

		function arg_336_1.onSingleLineUpdate_(arg_339_0)
			if 0 < arg_336_1.time_ and arg_336_1.time_ <= 0 + arg_339_0 then
				arg_336_1.var_.moveOldPos10094 = arg_336_1.actors_["10094"].transform.localPosition
				arg_336_1.actors_["10094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_336_1:CheckSpriteTmpPos("10094", 2)

				for iter_339_0 = 0, arg_336_1.actors_["10094"].transform.childCount - 1 do
					local var_339_0 = arg_336_1.actors_["10094"].transform:GetChild(iter_339_0)

					if var_339_0.name == "" or not string.find(var_339_0.name, "split") then
						var_339_0.gameObject:SetActive(true)
					else
						var_339_0.gameObject:SetActive(false)
					end
				end
			end

			local var_339_1 = 0.001

			if 0 <= arg_336_1.time_ and arg_336_1.time_ < 0 + var_339_1 then
				arg_336_1.actors_["10094"].transform.localPosition = Vector3.Lerp(arg_336_1.var_.moveOldPos10094, Vector3.New(-390, -340, -414), (arg_336_1.time_ - 0) / var_339_1)
			end

			if arg_336_1.time_ >= 0 + var_339_1 and arg_336_1.time_ < 0 + var_339_1 + arg_339_0 then
				arg_336_1.actors_["10094"].transform.localPosition = Vector3.New(-390, -340, -414)
			end

			local var_339_2 = arg_336_1.actors_["10092"].transform

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= 0 + arg_339_0 then
				arg_336_1.var_.moveOldPos10092 = var_339_2.localPosition
				var_339_2.localScale = Vector3.New(1, 1, 1)

				arg_336_1:CheckSpriteTmpPos("10092", 4)

				for iter_339_1 = 0, var_339_2.childCount - 1 do
					local var_339_3 = var_339_2:GetChild(iter_339_1)

					if var_339_3.name == "" or not string.find(var_339_3.name, "split") then
						var_339_3.gameObject:SetActive(true)
					else
						var_339_3.gameObject:SetActive(false)
					end
				end
			end

			local var_339_4 = 0.001

			if 0 <= arg_336_1.time_ and arg_336_1.time_ < 0 + var_339_4 then
				var_339_2.localPosition = Vector3.Lerp(arg_336_1.var_.moveOldPos10092, Vector3.New(390, -300, -295), (arg_336_1.time_ - 0) / var_339_4)
			end

			if arg_336_1.time_ >= 0 + var_339_4 and arg_336_1.time_ < 0 + var_339_4 + arg_339_0 then
				var_339_2.localPosition = Vector3.New(390, -300, -295)
			end

			local var_339_5 = arg_336_1.actors_["10094"]

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= 0 + arg_339_0 and not isNil(var_339_5) and arg_336_1.var_.actorSpriteComps10094 == nil then
				arg_336_1.var_.actorSpriteComps10094 = var_339_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_339_6 = 2

			if 0 <= arg_336_1.time_ and arg_336_1.time_ < 0 + var_339_6 and not isNil(var_339_5) then
				if arg_336_1.var_.actorSpriteComps10094 then
					for iter_339_2, iter_339_3 in pairs(arg_336_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_339_3 then
							if arg_336_1.isInRecall_ then
								iter_339_3.color = Color.New(Mathf.Lerp(iter_339_3.color.r, arg_336_1.hightColor1.r, (arg_336_1.time_ - 0) / var_339_6), Mathf.Lerp(iter_339_3.color.g, arg_336_1.hightColor1.g, (arg_336_1.time_ - 0) / var_339_6), (Mathf.Lerp(iter_339_3.color.b, arg_336_1.hightColor1.b, (arg_336_1.time_ - 0) / var_339_6)))
							else
								local var_339_7 = Mathf.Lerp(iter_339_3.color.r, 1, (arg_336_1.time_ - 0) / var_339_6)

								iter_339_3.color = Color.New(var_339_7, var_339_7, var_339_7)
							end
						end
					end
				end
			end

			if arg_336_1.time_ >= 0 + var_339_6 and arg_336_1.time_ < 0 + var_339_6 + arg_339_0 and not isNil(var_339_5) and arg_336_1.var_.actorSpriteComps10094 then
				for iter_339_4, iter_339_5 in pairs(arg_336_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_339_5 then
						iter_339_5.color = arg_336_1.isInRecall_ and (arg_336_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_336_1.var_.actorSpriteComps10094 = nil
			end

			local var_339_8 = arg_336_1.actors_["10092"]

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= 0 + arg_339_0 and not isNil(var_339_8) and arg_336_1.var_.actorSpriteComps10092 == nil then
				arg_336_1.var_.actorSpriteComps10092 = var_339_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_339_9 = 2

			if 0 <= arg_336_1.time_ and arg_336_1.time_ < 0 + var_339_9 and not isNil(var_339_8) then
				if arg_336_1.var_.actorSpriteComps10092 then
					for iter_339_6, iter_339_7 in pairs(arg_336_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_339_7 then
							if arg_336_1.isInRecall_ then
								iter_339_7.color = Color.New(Mathf.Lerp(iter_339_7.color.r, arg_336_1.hightColor2.r, (arg_336_1.time_ - 0) / var_339_9), Mathf.Lerp(iter_339_7.color.g, arg_336_1.hightColor2.g, (arg_336_1.time_ - 0) / var_339_9), (Mathf.Lerp(iter_339_7.color.b, arg_336_1.hightColor2.b, (arg_336_1.time_ - 0) / var_339_9)))
							else
								local var_339_10 = Mathf.Lerp(iter_339_7.color.r, 0.5, (arg_336_1.time_ - 0) / var_339_9)

								iter_339_7.color = Color.New(var_339_10, var_339_10, var_339_10)
							end
						end
					end
				end
			end

			if arg_336_1.time_ >= 0 + var_339_9 and arg_336_1.time_ < 0 + var_339_9 + arg_339_0 and not isNil(var_339_8) and arg_336_1.var_.actorSpriteComps10092 then
				for iter_339_8, iter_339_9 in pairs(arg_336_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_339_9 then
						iter_339_9.color = arg_336_1.isInRecall_ and (arg_336_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_336_1.var_.actorSpriteComps10092 = nil
			end

			local var_339_11 = 0
			local var_339_12 = 0.85

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= var_339_11 + arg_339_0 then
				arg_336_1.talkMaxDuration = 0
				arg_336_1.dialogCg_.alpha = 1

				arg_336_1.dialog_:SetActive(true)
				SetActive(arg_336_1.leftNameGo_, true)

				arg_336_1.leftNameTxt_.text = arg_336_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_336_1.leftNameTxt_.transform)

				arg_336_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_336_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_336_1:RecordName(arg_336_1.leftNameTxt_.text)
				SetActive(arg_336_1.iconTrs_.gameObject, false)
				arg_336_1.callingController_:SetSelectedState("normal")

				local var_339_13 = arg_336_1:GetWordFromCfg(413041083)
				local var_339_14 = arg_336_1:FormatText(var_339_13.content)

				arg_336_1.text_.text = var_339_14

				LuaForUtil.ClearLinePrefixSymbol(arg_336_1.text_)

				local var_339_16 = 34 <= 0 and var_339_12 or var_339_12 * (utf8.len(var_339_14) / 34)

				if (34 <= 0 and var_339_12 or var_339_12 * (utf8.len(var_339_14) / 34)) > 0 and var_339_12 < var_339_16 then
					arg_336_1.talkMaxDuration = var_339_16

					if var_339_16 + var_339_11 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_16 + var_339_11
					end
				end

				arg_336_1.text_.text = var_339_14
				arg_336_1.typewritter.percent = 0

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413041", "413041083", "story_v_out_413041.awb") ~= 0 then
					local var_339_17 = manager.audio:GetVoiceLength("story_v_out_413041", "413041083", "story_v_out_413041.awb") / 1000

					if var_339_17 + var_339_11 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_17 + var_339_11
					end

					if var_339_13.prefab_name ~= "" and arg_336_1.actors_[var_339_13.prefab_name] ~= nil then
						local var_339_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_336_1.actors_[var_339_13.prefab_name].transform, "story_v_out_413041", "413041083", "story_v_out_413041.awb")

						arg_336_1:RecordAudio("413041083", var_339_18)
						arg_336_1:RecordAudio("413041083", var_339_18)
					else
						arg_336_1:AudioAction("play", "voice", "story_v_out_413041", "413041083", "story_v_out_413041.awb")
					end

					arg_336_1:RecordHistoryTalkVoice("story_v_out_413041", "413041083", "story_v_out_413041.awb")
				end

				arg_336_1:RecordContent(arg_336_1.text_.text)
			end

			local var_339_19 = math.max(var_339_12, arg_336_1.talkMaxDuration)

			if var_339_11 <= arg_336_1.time_ and arg_336_1.time_ < var_339_11 + var_339_19 then
				arg_336_1.typewritter.percent = (arg_336_1.time_ - var_339_11) / var_339_19

				arg_336_1.typewritter:SetDirty()
			end

			if arg_336_1.time_ >= var_339_11 + var_339_19 and arg_336_1.time_ < var_339_11 + var_339_19 + arg_339_0 then
				arg_336_1.typewritter.percent = 1

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(true)
			end
		end

		arg_336_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10092",
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
	Play413041084 = function(arg_340_0, arg_340_1)
		arg_340_1.time_ = 0
		arg_340_1.frameCnt_ = 0
		arg_340_1.state_ = "playing"
		arg_340_1.curTalkId_ = 413041084
		arg_340_1.duration_ = 5.57

		local var_340_0 = {
			zh = 3.633,
			ja = 5.566
		}
		local var_340_1 = manager.audio:GetLocalizationFlag()

		if var_340_0[var_340_1] ~= nil then
			arg_340_1.duration_ = var_340_0[var_340_1]
		end

		SetActive(arg_340_1.tipsGo_, false)

		function arg_340_1.onSingleLineFinish_()
			arg_340_1.onSingleLineUpdate_ = nil
			arg_340_1.onSingleLineFinish_ = nil
			arg_340_1.state_ = "waiting"
		end

		function arg_340_1.playNext_(arg_342_0)
			if arg_342_0 == 1 then
				arg_340_0:Play413041085(arg_340_1)
			end
		end

		function arg_340_1.onSingleLineUpdate_(arg_343_0)
			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 then
				arg_340_1.var_.moveOldPos10094 = arg_340_1.actors_["10094"].transform.localPosition
				arg_340_1.actors_["10094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_340_1:CheckSpriteTmpPos("10094", 2)

				for iter_343_0 = 0, arg_340_1.actors_["10094"].transform.childCount - 1 do
					local var_343_0 = arg_340_1.actors_["10094"].transform:GetChild(iter_343_0)

					if var_343_0.name == "" or not string.find(var_343_0.name, "split") then
						var_343_0.gameObject:SetActive(true)
					else
						var_343_0.gameObject:SetActive(false)
					end
				end
			end

			local var_343_1 = 0.001

			if 0 <= arg_340_1.time_ and arg_340_1.time_ < 0 + var_343_1 then
				arg_340_1.actors_["10094"].transform.localPosition = Vector3.Lerp(arg_340_1.var_.moveOldPos10094, Vector3.New(-390, -340, -414), (arg_340_1.time_ - 0) / var_343_1)
			end

			if arg_340_1.time_ >= 0 + var_343_1 and arg_340_1.time_ < 0 + var_343_1 + arg_343_0 then
				arg_340_1.actors_["10094"].transform.localPosition = Vector3.New(-390, -340, -414)
			end

			local var_343_2 = arg_340_1.actors_["10092"].transform

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 then
				arg_340_1.var_.moveOldPos10092 = var_343_2.localPosition
				var_343_2.localScale = Vector3.New(1, 1, 1)

				arg_340_1:CheckSpriteTmpPos("10092", 4)

				for iter_343_1 = 0, var_343_2.childCount - 1 do
					local var_343_3 = var_343_2:GetChild(iter_343_1)

					if var_343_3.name == "split_5" or not string.find(var_343_3.name, "split") then
						var_343_3.gameObject:SetActive(true)
					else
						var_343_3.gameObject:SetActive(false)
					end
				end
			end

			local var_343_4 = 0.001

			if 0 <= arg_340_1.time_ and arg_340_1.time_ < 0 + var_343_4 then
				var_343_2.localPosition = Vector3.Lerp(arg_340_1.var_.moveOldPos10092, Vector3.New(390, -300, -295), (arg_340_1.time_ - 0) / var_343_4)
			end

			if arg_340_1.time_ >= 0 + var_343_4 and arg_340_1.time_ < 0 + var_343_4 + arg_343_0 then
				var_343_2.localPosition = Vector3.New(390, -300, -295)
			end

			local var_343_5 = arg_340_1.actors_["10094"]

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 and not isNil(var_343_5) and arg_340_1.var_.actorSpriteComps10094 == nil then
				arg_340_1.var_.actorSpriteComps10094 = var_343_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_343_6 = 2

			if 0 <= arg_340_1.time_ and arg_340_1.time_ < 0 + var_343_6 and not isNil(var_343_5) then
				if arg_340_1.var_.actorSpriteComps10094 then
					for iter_343_2, iter_343_3 in pairs(arg_340_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_343_3 then
							if arg_340_1.isInRecall_ then
								iter_343_3.color = Color.New(Mathf.Lerp(iter_343_3.color.r, arg_340_1.hightColor2.r, (arg_340_1.time_ - 0) / var_343_6), Mathf.Lerp(iter_343_3.color.g, arg_340_1.hightColor2.g, (arg_340_1.time_ - 0) / var_343_6), (Mathf.Lerp(iter_343_3.color.b, arg_340_1.hightColor2.b, (arg_340_1.time_ - 0) / var_343_6)))
							else
								local var_343_7 = Mathf.Lerp(iter_343_3.color.r, 0.5, (arg_340_1.time_ - 0) / var_343_6)

								iter_343_3.color = Color.New(var_343_7, var_343_7, var_343_7)
							end
						end
					end
				end
			end

			if arg_340_1.time_ >= 0 + var_343_6 and arg_340_1.time_ < 0 + var_343_6 + arg_343_0 and not isNil(var_343_5) and arg_340_1.var_.actorSpriteComps10094 then
				for iter_343_4, iter_343_5 in pairs(arg_340_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_343_5 then
						iter_343_5.color = arg_340_1.isInRecall_ and (arg_340_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_340_1.var_.actorSpriteComps10094 = nil
			end

			local var_343_8 = arg_340_1.actors_["10092"]

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 and not isNil(var_343_8) and arg_340_1.var_.actorSpriteComps10092 == nil then
				arg_340_1.var_.actorSpriteComps10092 = var_343_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_343_9 = 2

			if 0 <= arg_340_1.time_ and arg_340_1.time_ < 0 + var_343_9 and not isNil(var_343_8) then
				if arg_340_1.var_.actorSpriteComps10092 then
					for iter_343_6, iter_343_7 in pairs(arg_340_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_343_7 then
							if arg_340_1.isInRecall_ then
								iter_343_7.color = Color.New(Mathf.Lerp(iter_343_7.color.r, arg_340_1.hightColor1.r, (arg_340_1.time_ - 0) / var_343_9), Mathf.Lerp(iter_343_7.color.g, arg_340_1.hightColor1.g, (arg_340_1.time_ - 0) / var_343_9), (Mathf.Lerp(iter_343_7.color.b, arg_340_1.hightColor1.b, (arg_340_1.time_ - 0) / var_343_9)))
							else
								local var_343_10 = Mathf.Lerp(iter_343_7.color.r, 1, (arg_340_1.time_ - 0) / var_343_9)

								iter_343_7.color = Color.New(var_343_10, var_343_10, var_343_10)
							end
						end
					end
				end
			end

			if arg_340_1.time_ >= 0 + var_343_9 and arg_340_1.time_ < 0 + var_343_9 + arg_343_0 and not isNil(var_343_8) and arg_340_1.var_.actorSpriteComps10092 then
				for iter_343_8, iter_343_9 in pairs(arg_340_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_343_9 then
						iter_343_9.color = arg_340_1.isInRecall_ and (arg_340_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_340_1.var_.actorSpriteComps10092 = nil
			end

			local var_343_11 = 0
			local var_343_12 = 0.525

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= var_343_11 + arg_343_0 then
				arg_340_1.talkMaxDuration = 0
				arg_340_1.dialogCg_.alpha = 1

				arg_340_1.dialog_:SetActive(true)
				SetActive(arg_340_1.leftNameGo_, true)

				arg_340_1.leftNameTxt_.text = arg_340_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_340_1.leftNameTxt_.transform)

				arg_340_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_340_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_340_1:RecordName(arg_340_1.leftNameTxt_.text)
				SetActive(arg_340_1.iconTrs_.gameObject, false)
				arg_340_1.callingController_:SetSelectedState("normal")

				local var_343_13 = arg_340_1:GetWordFromCfg(413041084)
				local var_343_14 = arg_340_1:FormatText(var_343_13.content)

				arg_340_1.text_.text = var_343_14

				LuaForUtil.ClearLinePrefixSymbol(arg_340_1.text_)

				local var_343_16 = 21 <= 0 and var_343_12 or var_343_12 * (utf8.len(var_343_14) / 21)

				if (21 <= 0 and var_343_12 or var_343_12 * (utf8.len(var_343_14) / 21)) > 0 and var_343_12 < var_343_16 then
					arg_340_1.talkMaxDuration = var_343_16

					if var_343_16 + var_343_11 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_16 + var_343_11
					end
				end

				arg_340_1.text_.text = var_343_14
				arg_340_1.typewritter.percent = 0

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413041", "413041084", "story_v_out_413041.awb") ~= 0 then
					local var_343_17 = manager.audio:GetVoiceLength("story_v_out_413041", "413041084", "story_v_out_413041.awb") / 1000

					if var_343_17 + var_343_11 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_17 + var_343_11
					end

					if var_343_13.prefab_name ~= "" and arg_340_1.actors_[var_343_13.prefab_name] ~= nil then
						local var_343_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_340_1.actors_[var_343_13.prefab_name].transform, "story_v_out_413041", "413041084", "story_v_out_413041.awb")

						arg_340_1:RecordAudio("413041084", var_343_18)
						arg_340_1:RecordAudio("413041084", var_343_18)
					else
						arg_340_1:AudioAction("play", "voice", "story_v_out_413041", "413041084", "story_v_out_413041.awb")
					end

					arg_340_1:RecordHistoryTalkVoice("story_v_out_413041", "413041084", "story_v_out_413041.awb")
				end

				arg_340_1:RecordContent(arg_340_1.text_.text)
			end

			local var_343_19 = math.max(var_343_12, arg_340_1.talkMaxDuration)

			if var_343_11 <= arg_340_1.time_ and arg_340_1.time_ < var_343_11 + var_343_19 then
				arg_340_1.typewritter.percent = (arg_340_1.time_ - var_343_11) / var_343_19

				arg_340_1.typewritter:SetDirty()
			end

			if arg_340_1.time_ >= var_343_11 + var_343_19 and arg_340_1.time_ < var_343_11 + var_343_19 + arg_343_0 then
				arg_340_1.typewritter.percent = 1

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(true)
			end
		end

		arg_340_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10092",
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
	Play413041085 = function(arg_344_0, arg_344_1)
		arg_344_1.time_ = 0
		arg_344_1.frameCnt_ = 0
		arg_344_1.state_ = "playing"
		arg_344_1.curTalkId_ = 413041085
		arg_344_1.duration_ = 12

		local var_344_0 = {
			zh = 7.866,
			ja = 12
		}
		local var_344_1 = manager.audio:GetLocalizationFlag()

		if var_344_0[var_344_1] ~= nil then
			arg_344_1.duration_ = var_344_0[var_344_1]
		end

		SetActive(arg_344_1.tipsGo_, false)

		function arg_344_1.onSingleLineFinish_()
			arg_344_1.onSingleLineUpdate_ = nil
			arg_344_1.onSingleLineFinish_ = nil
			arg_344_1.state_ = "waiting"
		end

		function arg_344_1.playNext_(arg_346_0)
			if arg_346_0 == 1 then
				arg_344_0:Play413041086(arg_344_1)
			end
		end

		function arg_344_1.onSingleLineUpdate_(arg_347_0)
			if 0 < arg_344_1.time_ and arg_344_1.time_ <= 0 + arg_347_0 then
				arg_344_1.var_.moveOldPos10094 = arg_344_1.actors_["10094"].transform.localPosition
				arg_344_1.actors_["10094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_344_1:CheckSpriteTmpPos("10094", 2)

				for iter_347_0 = 0, arg_344_1.actors_["10094"].transform.childCount - 1 do
					local var_347_0 = arg_344_1.actors_["10094"].transform:GetChild(iter_347_0)

					if var_347_0.name == "" or not string.find(var_347_0.name, "split") then
						var_347_0.gameObject:SetActive(true)
					else
						var_347_0.gameObject:SetActive(false)
					end
				end
			end

			local var_347_1 = 0.001

			if 0 <= arg_344_1.time_ and arg_344_1.time_ < 0 + var_347_1 then
				arg_344_1.actors_["10094"].transform.localPosition = Vector3.Lerp(arg_344_1.var_.moveOldPos10094, Vector3.New(-390, -340, -414), (arg_344_1.time_ - 0) / var_347_1)
			end

			if arg_344_1.time_ >= 0 + var_347_1 and arg_344_1.time_ < 0 + var_347_1 + arg_347_0 then
				arg_344_1.actors_["10094"].transform.localPosition = Vector3.New(-390, -340, -414)
			end

			local var_347_2 = arg_344_1.actors_["10094"]

			if 0 < arg_344_1.time_ and arg_344_1.time_ <= 0 + arg_347_0 and not isNil(var_347_2) and arg_344_1.var_.actorSpriteComps10094 == nil then
				arg_344_1.var_.actorSpriteComps10094 = var_347_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_347_3 = 2

			if 0 <= arg_344_1.time_ and arg_344_1.time_ < 0 + var_347_3 and not isNil(var_347_2) then
				if arg_344_1.var_.actorSpriteComps10094 then
					for iter_347_1, iter_347_2 in pairs(arg_344_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_347_2 then
							if arg_344_1.isInRecall_ then
								iter_347_2.color = Color.New(Mathf.Lerp(iter_347_2.color.r, arg_344_1.hightColor1.r, (arg_344_1.time_ - 0) / var_347_3), Mathf.Lerp(iter_347_2.color.g, arg_344_1.hightColor1.g, (arg_344_1.time_ - 0) / var_347_3), (Mathf.Lerp(iter_347_2.color.b, arg_344_1.hightColor1.b, (arg_344_1.time_ - 0) / var_347_3)))
							else
								local var_347_4 = Mathf.Lerp(iter_347_2.color.r, 1, (arg_344_1.time_ - 0) / var_347_3)

								iter_347_2.color = Color.New(var_347_4, var_347_4, var_347_4)
							end
						end
					end
				end
			end

			if arg_344_1.time_ >= 0 + var_347_3 and arg_344_1.time_ < 0 + var_347_3 + arg_347_0 and not isNil(var_347_2) and arg_344_1.var_.actorSpriteComps10094 then
				for iter_347_3, iter_347_4 in pairs(arg_344_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_347_4 then
						iter_347_4.color = arg_344_1.isInRecall_ and (arg_344_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_344_1.var_.actorSpriteComps10094 = nil
			end

			local var_347_5 = arg_344_1.actors_["10092"]

			if 0 < arg_344_1.time_ and arg_344_1.time_ <= 0 + arg_347_0 and not isNil(var_347_5) and arg_344_1.var_.actorSpriteComps10092 == nil then
				arg_344_1.var_.actorSpriteComps10092 = var_347_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_347_6 = 2

			if 0 <= arg_344_1.time_ and arg_344_1.time_ < 0 + var_347_6 and not isNil(var_347_5) then
				if arg_344_1.var_.actorSpriteComps10092 then
					for iter_347_5, iter_347_6 in pairs(arg_344_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_347_6 then
							if arg_344_1.isInRecall_ then
								iter_347_6.color = Color.New(Mathf.Lerp(iter_347_6.color.r, arg_344_1.hightColor2.r, (arg_344_1.time_ - 0) / var_347_6), Mathf.Lerp(iter_347_6.color.g, arg_344_1.hightColor2.g, (arg_344_1.time_ - 0) / var_347_6), (Mathf.Lerp(iter_347_6.color.b, arg_344_1.hightColor2.b, (arg_344_1.time_ - 0) / var_347_6)))
							else
								local var_347_7 = Mathf.Lerp(iter_347_6.color.r, 0.5, (arg_344_1.time_ - 0) / var_347_6)

								iter_347_6.color = Color.New(var_347_7, var_347_7, var_347_7)
							end
						end
					end
				end
			end

			if arg_344_1.time_ >= 0 + var_347_6 and arg_344_1.time_ < 0 + var_347_6 + arg_347_0 and not isNil(var_347_5) and arg_344_1.var_.actorSpriteComps10092 then
				for iter_347_7, iter_347_8 in pairs(arg_344_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_347_8 then
						iter_347_8.color = arg_344_1.isInRecall_ and (arg_344_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_344_1.var_.actorSpriteComps10092 = nil
			end

			local var_347_8 = 0
			local var_347_9 = 0.925

			if 0 < arg_344_1.time_ and arg_344_1.time_ <= var_347_8 + arg_347_0 then
				arg_344_1.talkMaxDuration = 0
				arg_344_1.dialogCg_.alpha = 1

				arg_344_1.dialog_:SetActive(true)
				SetActive(arg_344_1.leftNameGo_, true)

				arg_344_1.leftNameTxt_.text = arg_344_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_344_1.leftNameTxt_.transform)

				arg_344_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_344_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_344_1:RecordName(arg_344_1.leftNameTxt_.text)
				SetActive(arg_344_1.iconTrs_.gameObject, false)
				arg_344_1.callingController_:SetSelectedState("normal")

				local var_347_10 = arg_344_1:GetWordFromCfg(413041085)
				local var_347_11 = arg_344_1:FormatText(var_347_10.content)

				arg_344_1.text_.text = var_347_11

				LuaForUtil.ClearLinePrefixSymbol(arg_344_1.text_)

				local var_347_13 = 37 <= 0 and var_347_9 or var_347_9 * (utf8.len(var_347_11) / 37)

				if (37 <= 0 and var_347_9 or var_347_9 * (utf8.len(var_347_11) / 37)) > 0 and var_347_9 < var_347_13 then
					arg_344_1.talkMaxDuration = var_347_13

					if var_347_13 + var_347_8 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_13 + var_347_8
					end
				end

				arg_344_1.text_.text = var_347_11
				arg_344_1.typewritter.percent = 0

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413041", "413041085", "story_v_out_413041.awb") ~= 0 then
					local var_347_14 = manager.audio:GetVoiceLength("story_v_out_413041", "413041085", "story_v_out_413041.awb") / 1000

					if var_347_14 + var_347_8 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_14 + var_347_8
					end

					if var_347_10.prefab_name ~= "" and arg_344_1.actors_[var_347_10.prefab_name] ~= nil then
						local var_347_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_344_1.actors_[var_347_10.prefab_name].transform, "story_v_out_413041", "413041085", "story_v_out_413041.awb")

						arg_344_1:RecordAudio("413041085", var_347_15)
						arg_344_1:RecordAudio("413041085", var_347_15)
					else
						arg_344_1:AudioAction("play", "voice", "story_v_out_413041", "413041085", "story_v_out_413041.awb")
					end

					arg_344_1:RecordHistoryTalkVoice("story_v_out_413041", "413041085", "story_v_out_413041.awb")
				end

				arg_344_1:RecordContent(arg_344_1.text_.text)
			end

			local var_347_16 = math.max(var_347_9, arg_344_1.talkMaxDuration)

			if var_347_8 <= arg_344_1.time_ and arg_344_1.time_ < var_347_8 + var_347_16 then
				arg_344_1.typewritter.percent = (arg_344_1.time_ - var_347_8) / var_347_16

				arg_344_1.typewritter:SetDirty()
			end

			if arg_344_1.time_ >= var_347_8 + var_347_16 and arg_344_1.time_ < var_347_8 + var_347_16 + arg_347_0 then
				arg_344_1.typewritter.percent = 1

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(true)
			end
		end

		arg_344_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_344_1:InitPlayNodeList()
	end,
	Play413041086 = function(arg_348_0, arg_348_1)
		arg_348_1.time_ = 0
		arg_348_1.frameCnt_ = 0
		arg_348_1.state_ = "playing"
		arg_348_1.curTalkId_ = 413041086
		arg_348_1.duration_ = 13.87

		local var_348_0 = {
			zh = 8.633,
			ja = 13.866
		}
		local var_348_1 = manager.audio:GetLocalizationFlag()

		if var_348_0[var_348_1] ~= nil then
			arg_348_1.duration_ = var_348_0[var_348_1]
		end

		SetActive(arg_348_1.tipsGo_, false)

		function arg_348_1.onSingleLineFinish_()
			arg_348_1.onSingleLineUpdate_ = nil
			arg_348_1.onSingleLineFinish_ = nil
			arg_348_1.state_ = "waiting"
		end

		function arg_348_1.playNext_(arg_350_0)
			if arg_350_0 == 1 then
				arg_348_0:Play413041087(arg_348_1)
			end
		end

		function arg_348_1.onSingleLineUpdate_(arg_351_0)
			local var_351_0 = 1

			if 0 < arg_348_1.time_ and arg_348_1.time_ <= 0 + arg_351_0 then
				arg_348_1.talkMaxDuration = 0
				arg_348_1.dialogCg_.alpha = 1

				arg_348_1.dialog_:SetActive(true)
				SetActive(arg_348_1.leftNameGo_, true)

				arg_348_1.leftNameTxt_.text = arg_348_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_348_1.leftNameTxt_.transform)

				arg_348_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_348_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_348_1:RecordName(arg_348_1.leftNameTxt_.text)
				SetActive(arg_348_1.iconTrs_.gameObject, false)
				arg_348_1.callingController_:SetSelectedState("normal")

				local var_351_1 = arg_348_1:GetWordFromCfg(413041086)
				local var_351_2 = arg_348_1:FormatText(var_351_1.content)

				arg_348_1.text_.text = var_351_2

				LuaForUtil.ClearLinePrefixSymbol(arg_348_1.text_)

				local var_351_4 = 40 <= 0 and var_351_0 or var_351_0 * (utf8.len(var_351_2) / 40)

				if (40 <= 0 and var_351_0 or var_351_0 * (utf8.len(var_351_2) / 40)) > 0 and var_351_0 < var_351_4 then
					arg_348_1.talkMaxDuration = var_351_4

					if var_351_4 + 0 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_4 + 0
					end
				end

				arg_348_1.text_.text = var_351_2
				arg_348_1.typewritter.percent = 0

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413041", "413041086", "story_v_out_413041.awb") ~= 0 then
					local var_351_5 = manager.audio:GetVoiceLength("story_v_out_413041", "413041086", "story_v_out_413041.awb") / 1000

					if var_351_5 + 0 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_5 + 0
					end

					if var_351_1.prefab_name ~= "" and arg_348_1.actors_[var_351_1.prefab_name] ~= nil then
						local var_351_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_348_1.actors_[var_351_1.prefab_name].transform, "story_v_out_413041", "413041086", "story_v_out_413041.awb")

						arg_348_1:RecordAudio("413041086", var_351_6)
						arg_348_1:RecordAudio("413041086", var_351_6)
					else
						arg_348_1:AudioAction("play", "voice", "story_v_out_413041", "413041086", "story_v_out_413041.awb")
					end

					arg_348_1:RecordHistoryTalkVoice("story_v_out_413041", "413041086", "story_v_out_413041.awb")
				end

				arg_348_1:RecordContent(arg_348_1.text_.text)
			end

			local var_351_7 = math.max(var_351_0, arg_348_1.talkMaxDuration)

			if 0 <= arg_348_1.time_ and arg_348_1.time_ < 0 + var_351_7 then
				arg_348_1.typewritter.percent = (arg_348_1.time_ - 0) / var_351_7

				arg_348_1.typewritter:SetDirty()
			end

			if arg_348_1.time_ >= 0 + var_351_7 and arg_348_1.time_ < 0 + var_351_7 + arg_351_0 then
				arg_348_1.typewritter.percent = 1

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(true)
			end
		end

		arg_348_1.nodeConfigList_ = {}

		arg_348_1:InitPlayNodeList()
	end,
	Play413041087 = function(arg_352_0, arg_352_1)
		arg_352_1.time_ = 0
		arg_352_1.frameCnt_ = 0
		arg_352_1.state_ = "playing"
		arg_352_1.curTalkId_ = 413041087
		arg_352_1.duration_ = 7.9

		local var_352_0 = {
			zh = 4.4,
			ja = 7.9
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
		end

		function arg_352_1.playNext_(arg_354_0)
			if arg_354_0 == 1 then
				arg_352_0:Play413041088(arg_352_1)
			end
		end

		function arg_352_1.onSingleLineUpdate_(arg_355_0)
			if 0 < arg_352_1.time_ and arg_352_1.time_ <= 0 + arg_355_0 then
				arg_352_1.var_.moveOldPos10094 = arg_352_1.actors_["10094"].transform.localPosition
				arg_352_1.actors_["10094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_352_1:CheckSpriteTmpPos("10094", 2)

				for iter_355_0 = 0, arg_352_1.actors_["10094"].transform.childCount - 1 do
					local var_355_0 = arg_352_1.actors_["10094"].transform:GetChild(iter_355_0)

					if var_355_0.name == "" or not string.find(var_355_0.name, "split") then
						var_355_0.gameObject:SetActive(true)
					else
						var_355_0.gameObject:SetActive(false)
					end
				end
			end

			local var_355_1 = 0.001

			if 0 <= arg_352_1.time_ and arg_352_1.time_ < 0 + var_355_1 then
				arg_352_1.actors_["10094"].transform.localPosition = Vector3.Lerp(arg_352_1.var_.moveOldPos10094, Vector3.New(-390, -340, -414), (arg_352_1.time_ - 0) / var_355_1)
			end

			if arg_352_1.time_ >= 0 + var_355_1 and arg_352_1.time_ < 0 + var_355_1 + arg_355_0 then
				arg_352_1.actors_["10094"].transform.localPosition = Vector3.New(-390, -340, -414)
			end

			local var_355_2 = arg_352_1.actors_["10092"].transform

			if 0 < arg_352_1.time_ and arg_352_1.time_ <= 0 + arg_355_0 then
				arg_352_1.var_.moveOldPos10092 = var_355_2.localPosition
				var_355_2.localScale = Vector3.New(1, 1, 1)

				arg_352_1:CheckSpriteTmpPos("10092", 4)

				for iter_355_1 = 0, var_355_2.childCount - 1 do
					local var_355_3 = var_355_2:GetChild(iter_355_1)

					if var_355_3.name == "split_5" or not string.find(var_355_3.name, "split") then
						var_355_3.gameObject:SetActive(true)
					else
						var_355_3.gameObject:SetActive(false)
					end
				end
			end

			local var_355_4 = 0.001

			if 0 <= arg_352_1.time_ and arg_352_1.time_ < 0 + var_355_4 then
				var_355_2.localPosition = Vector3.Lerp(arg_352_1.var_.moveOldPos10092, Vector3.New(390, -300, -295), (arg_352_1.time_ - 0) / var_355_4)
			end

			if arg_352_1.time_ >= 0 + var_355_4 and arg_352_1.time_ < 0 + var_355_4 + arg_355_0 then
				var_355_2.localPosition = Vector3.New(390, -300, -295)
			end

			local var_355_5 = arg_352_1.actors_["10094"]

			if 0 < arg_352_1.time_ and arg_352_1.time_ <= 0 + arg_355_0 and not isNil(var_355_5) and arg_352_1.var_.actorSpriteComps10094 == nil then
				arg_352_1.var_.actorSpriteComps10094 = var_355_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_355_6 = 2

			if 0 <= arg_352_1.time_ and arg_352_1.time_ < 0 + var_355_6 and not isNil(var_355_5) then
				if arg_352_1.var_.actorSpriteComps10094 then
					for iter_355_2, iter_355_3 in pairs(arg_352_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_355_3 then
							if arg_352_1.isInRecall_ then
								iter_355_3.color = Color.New(Mathf.Lerp(iter_355_3.color.r, arg_352_1.hightColor2.r, (arg_352_1.time_ - 0) / var_355_6), Mathf.Lerp(iter_355_3.color.g, arg_352_1.hightColor2.g, (arg_352_1.time_ - 0) / var_355_6), (Mathf.Lerp(iter_355_3.color.b, arg_352_1.hightColor2.b, (arg_352_1.time_ - 0) / var_355_6)))
							else
								local var_355_7 = Mathf.Lerp(iter_355_3.color.r, 0.5, (arg_352_1.time_ - 0) / var_355_6)

								iter_355_3.color = Color.New(var_355_7, var_355_7, var_355_7)
							end
						end
					end
				end
			end

			if arg_352_1.time_ >= 0 + var_355_6 and arg_352_1.time_ < 0 + var_355_6 + arg_355_0 and not isNil(var_355_5) and arg_352_1.var_.actorSpriteComps10094 then
				for iter_355_4, iter_355_5 in pairs(arg_352_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_355_5 then
						iter_355_5.color = arg_352_1.isInRecall_ and (arg_352_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_352_1.var_.actorSpriteComps10094 = nil
			end

			local var_355_8 = arg_352_1.actors_["10092"]

			if 0 < arg_352_1.time_ and arg_352_1.time_ <= 0 + arg_355_0 and not isNil(var_355_8) and arg_352_1.var_.actorSpriteComps10092 == nil then
				arg_352_1.var_.actorSpriteComps10092 = var_355_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_355_9 = 2

			if 0 <= arg_352_1.time_ and arg_352_1.time_ < 0 + var_355_9 and not isNil(var_355_8) then
				if arg_352_1.var_.actorSpriteComps10092 then
					for iter_355_6, iter_355_7 in pairs(arg_352_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_355_7 then
							if arg_352_1.isInRecall_ then
								iter_355_7.color = Color.New(Mathf.Lerp(iter_355_7.color.r, arg_352_1.hightColor1.r, (arg_352_1.time_ - 0) / var_355_9), Mathf.Lerp(iter_355_7.color.g, arg_352_1.hightColor1.g, (arg_352_1.time_ - 0) / var_355_9), (Mathf.Lerp(iter_355_7.color.b, arg_352_1.hightColor1.b, (arg_352_1.time_ - 0) / var_355_9)))
							else
								local var_355_10 = Mathf.Lerp(iter_355_7.color.r, 1, (arg_352_1.time_ - 0) / var_355_9)

								iter_355_7.color = Color.New(var_355_10, var_355_10, var_355_10)
							end
						end
					end
				end
			end

			if arg_352_1.time_ >= 0 + var_355_9 and arg_352_1.time_ < 0 + var_355_9 + arg_355_0 and not isNil(var_355_8) and arg_352_1.var_.actorSpriteComps10092 then
				for iter_355_8, iter_355_9 in pairs(arg_352_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_355_9 then
						iter_355_9.color = arg_352_1.isInRecall_ and (arg_352_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_352_1.var_.actorSpriteComps10092 = nil
			end

			local var_355_11 = 0
			local var_355_12 = 0.575

			if 0 < arg_352_1.time_ and arg_352_1.time_ <= var_355_11 + arg_355_0 then
				arg_352_1.talkMaxDuration = 0
				arg_352_1.dialogCg_.alpha = 1

				arg_352_1.dialog_:SetActive(true)
				SetActive(arg_352_1.leftNameGo_, true)

				arg_352_1.leftNameTxt_.text = arg_352_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_352_1.leftNameTxt_.transform)

				arg_352_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_352_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_352_1:RecordName(arg_352_1.leftNameTxt_.text)
				SetActive(arg_352_1.iconTrs_.gameObject, false)
				arg_352_1.callingController_:SetSelectedState("normal")

				local var_355_13 = arg_352_1:GetWordFromCfg(413041087)
				local var_355_14 = arg_352_1:FormatText(var_355_13.content)

				arg_352_1.text_.text = var_355_14

				LuaForUtil.ClearLinePrefixSymbol(arg_352_1.text_)

				local var_355_16 = 23 <= 0 and var_355_12 or var_355_12 * (utf8.len(var_355_14) / 23)

				if (23 <= 0 and var_355_12 or var_355_12 * (utf8.len(var_355_14) / 23)) > 0 and var_355_12 < var_355_16 then
					arg_352_1.talkMaxDuration = var_355_16

					if var_355_16 + var_355_11 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_16 + var_355_11
					end
				end

				arg_352_1.text_.text = var_355_14
				arg_352_1.typewritter.percent = 0

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413041", "413041087", "story_v_out_413041.awb") ~= 0 then
					local var_355_17 = manager.audio:GetVoiceLength("story_v_out_413041", "413041087", "story_v_out_413041.awb") / 1000

					if var_355_17 + var_355_11 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_17 + var_355_11
					end

					if var_355_13.prefab_name ~= "" and arg_352_1.actors_[var_355_13.prefab_name] ~= nil then
						local var_355_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_352_1.actors_[var_355_13.prefab_name].transform, "story_v_out_413041", "413041087", "story_v_out_413041.awb")

						arg_352_1:RecordAudio("413041087", var_355_18)
						arg_352_1:RecordAudio("413041087", var_355_18)
					else
						arg_352_1:AudioAction("play", "voice", "story_v_out_413041", "413041087", "story_v_out_413041.awb")
					end

					arg_352_1:RecordHistoryTalkVoice("story_v_out_413041", "413041087", "story_v_out_413041.awb")
				end

				arg_352_1:RecordContent(arg_352_1.text_.text)
			end

			local var_355_19 = math.max(var_355_12, arg_352_1.talkMaxDuration)

			if var_355_11 <= arg_352_1.time_ and arg_352_1.time_ < var_355_11 + var_355_19 then
				arg_352_1.typewritter.percent = (arg_352_1.time_ - var_355_11) / var_355_19

				arg_352_1.typewritter:SetDirty()
			end

			if arg_352_1.time_ >= var_355_11 + var_355_19 and arg_352_1.time_ < var_355_11 + var_355_19 + arg_355_0 then
				arg_352_1.typewritter.percent = 1

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(true)
			end
		end

		arg_352_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10092",
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
	Play413041088 = function(arg_356_0, arg_356_1)
		arg_356_1.time_ = 0
		arg_356_1.frameCnt_ = 0
		arg_356_1.state_ = "playing"
		arg_356_1.curTalkId_ = 413041088
		arg_356_1.duration_ = 17.33

		local var_356_0 = {
			zh = 10.166,
			ja = 17.333
		}
		local var_356_1 = manager.audio:GetLocalizationFlag()

		if var_356_0[var_356_1] ~= nil then
			arg_356_1.duration_ = var_356_0[var_356_1]
		end

		SetActive(arg_356_1.tipsGo_, false)

		function arg_356_1.onSingleLineFinish_()
			arg_356_1.onSingleLineUpdate_ = nil
			arg_356_1.onSingleLineFinish_ = nil
			arg_356_1.state_ = "waiting"
		end

		function arg_356_1.playNext_(arg_358_0)
			if arg_358_0 == 1 then
				arg_356_0:Play413041089(arg_356_1)
			end
		end

		function arg_356_1.onSingleLineUpdate_(arg_359_0)
			if 0 < arg_356_1.time_ and arg_356_1.time_ <= 0 + arg_359_0 then
				arg_356_1.var_.moveOldPos10094 = arg_356_1.actors_["10094"].transform.localPosition
				arg_356_1.actors_["10094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_356_1:CheckSpriteTmpPos("10094", 2)

				for iter_359_0 = 0, arg_356_1.actors_["10094"].transform.childCount - 1 do
					local var_359_0 = arg_356_1.actors_["10094"].transform:GetChild(iter_359_0)

					if var_359_0.name == "" or not string.find(var_359_0.name, "split") then
						var_359_0.gameObject:SetActive(true)
					else
						var_359_0.gameObject:SetActive(false)
					end
				end
			end

			local var_359_1 = 0.001

			if 0 <= arg_356_1.time_ and arg_356_1.time_ < 0 + var_359_1 then
				arg_356_1.actors_["10094"].transform.localPosition = Vector3.Lerp(arg_356_1.var_.moveOldPos10094, Vector3.New(-390, -340, -414), (arg_356_1.time_ - 0) / var_359_1)
			end

			if arg_356_1.time_ >= 0 + var_359_1 and arg_356_1.time_ < 0 + var_359_1 + arg_359_0 then
				arg_356_1.actors_["10094"].transform.localPosition = Vector3.New(-390, -340, -414)
			end

			local var_359_2 = arg_356_1.actors_["10094"]

			if 0 < arg_356_1.time_ and arg_356_1.time_ <= 0 + arg_359_0 and not isNil(var_359_2) and arg_356_1.var_.actorSpriteComps10094 == nil then
				arg_356_1.var_.actorSpriteComps10094 = var_359_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_359_3 = 2

			if 0 <= arg_356_1.time_ and arg_356_1.time_ < 0 + var_359_3 and not isNil(var_359_2) then
				if arg_356_1.var_.actorSpriteComps10094 then
					for iter_359_1, iter_359_2 in pairs(arg_356_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_359_2 then
							if arg_356_1.isInRecall_ then
								iter_359_2.color = Color.New(Mathf.Lerp(iter_359_2.color.r, arg_356_1.hightColor1.r, (arg_356_1.time_ - 0) / var_359_3), Mathf.Lerp(iter_359_2.color.g, arg_356_1.hightColor1.g, (arg_356_1.time_ - 0) / var_359_3), (Mathf.Lerp(iter_359_2.color.b, arg_356_1.hightColor1.b, (arg_356_1.time_ - 0) / var_359_3)))
							else
								local var_359_4 = Mathf.Lerp(iter_359_2.color.r, 1, (arg_356_1.time_ - 0) / var_359_3)

								iter_359_2.color = Color.New(var_359_4, var_359_4, var_359_4)
							end
						end
					end
				end
			end

			if arg_356_1.time_ >= 0 + var_359_3 and arg_356_1.time_ < 0 + var_359_3 + arg_359_0 and not isNil(var_359_2) and arg_356_1.var_.actorSpriteComps10094 then
				for iter_359_3, iter_359_4 in pairs(arg_356_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_359_4 then
						iter_359_4.color = arg_356_1.isInRecall_ and (arg_356_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_356_1.var_.actorSpriteComps10094 = nil
			end

			local var_359_5 = arg_356_1.actors_["10092"]

			if 0 < arg_356_1.time_ and arg_356_1.time_ <= 0 + arg_359_0 and not isNil(var_359_5) and arg_356_1.var_.actorSpriteComps10092 == nil then
				arg_356_1.var_.actorSpriteComps10092 = var_359_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_359_6 = 2

			if 0 <= arg_356_1.time_ and arg_356_1.time_ < 0 + var_359_6 and not isNil(var_359_5) then
				if arg_356_1.var_.actorSpriteComps10092 then
					for iter_359_5, iter_359_6 in pairs(arg_356_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_359_6 then
							if arg_356_1.isInRecall_ then
								iter_359_6.color = Color.New(Mathf.Lerp(iter_359_6.color.r, arg_356_1.hightColor2.r, (arg_356_1.time_ - 0) / var_359_6), Mathf.Lerp(iter_359_6.color.g, arg_356_1.hightColor2.g, (arg_356_1.time_ - 0) / var_359_6), (Mathf.Lerp(iter_359_6.color.b, arg_356_1.hightColor2.b, (arg_356_1.time_ - 0) / var_359_6)))
							else
								local var_359_7 = Mathf.Lerp(iter_359_6.color.r, 0.5, (arg_356_1.time_ - 0) / var_359_6)

								iter_359_6.color = Color.New(var_359_7, var_359_7, var_359_7)
							end
						end
					end
				end
			end

			if arg_356_1.time_ >= 0 + var_359_6 and arg_356_1.time_ < 0 + var_359_6 + arg_359_0 and not isNil(var_359_5) and arg_356_1.var_.actorSpriteComps10092 then
				for iter_359_7, iter_359_8 in pairs(arg_356_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_359_8 then
						iter_359_8.color = arg_356_1.isInRecall_ and (arg_356_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_356_1.var_.actorSpriteComps10092 = nil
			end

			local var_359_8 = 0
			local var_359_9 = 1.1

			if 0 < arg_356_1.time_ and arg_356_1.time_ <= var_359_8 + arg_359_0 then
				arg_356_1.talkMaxDuration = 0
				arg_356_1.dialogCg_.alpha = 1

				arg_356_1.dialog_:SetActive(true)
				SetActive(arg_356_1.leftNameGo_, true)

				arg_356_1.leftNameTxt_.text = arg_356_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_356_1.leftNameTxt_.transform)

				arg_356_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_356_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_356_1:RecordName(arg_356_1.leftNameTxt_.text)
				SetActive(arg_356_1.iconTrs_.gameObject, false)
				arg_356_1.callingController_:SetSelectedState("normal")

				local var_359_10 = arg_356_1:GetWordFromCfg(413041088)
				local var_359_11 = arg_356_1:FormatText(var_359_10.content)

				arg_356_1.text_.text = var_359_11

				LuaForUtil.ClearLinePrefixSymbol(arg_356_1.text_)

				local var_359_13 = 44 <= 0 and var_359_9 or var_359_9 * (utf8.len(var_359_11) / 44)

				if (44 <= 0 and var_359_9 or var_359_9 * (utf8.len(var_359_11) / 44)) > 0 and var_359_9 < var_359_13 then
					arg_356_1.talkMaxDuration = var_359_13

					if var_359_13 + var_359_8 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_13 + var_359_8
					end
				end

				arg_356_1.text_.text = var_359_11
				arg_356_1.typewritter.percent = 0

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413041", "413041088", "story_v_out_413041.awb") ~= 0 then
					local var_359_14 = manager.audio:GetVoiceLength("story_v_out_413041", "413041088", "story_v_out_413041.awb") / 1000

					if var_359_14 + var_359_8 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_14 + var_359_8
					end

					if var_359_10.prefab_name ~= "" and arg_356_1.actors_[var_359_10.prefab_name] ~= nil then
						local var_359_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_356_1.actors_[var_359_10.prefab_name].transform, "story_v_out_413041", "413041088", "story_v_out_413041.awb")

						arg_356_1:RecordAudio("413041088", var_359_15)
						arg_356_1:RecordAudio("413041088", var_359_15)
					else
						arg_356_1:AudioAction("play", "voice", "story_v_out_413041", "413041088", "story_v_out_413041.awb")
					end

					arg_356_1:RecordHistoryTalkVoice("story_v_out_413041", "413041088", "story_v_out_413041.awb")
				end

				arg_356_1:RecordContent(arg_356_1.text_.text)
			end

			local var_359_16 = math.max(var_359_9, arg_356_1.talkMaxDuration)

			if var_359_8 <= arg_356_1.time_ and arg_356_1.time_ < var_359_8 + var_359_16 then
				arg_356_1.typewritter.percent = (arg_356_1.time_ - var_359_8) / var_359_16

				arg_356_1.typewritter:SetDirty()
			end

			if arg_356_1.time_ >= var_359_8 + var_359_16 and arg_356_1.time_ < var_359_8 + var_359_16 + arg_359_0 then
				arg_356_1.typewritter.percent = 1

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(true)
			end
		end

		arg_356_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_356_1:InitPlayNodeList()
	end,
	Play413041089 = function(arg_360_0, arg_360_1)
		arg_360_1.time_ = 0
		arg_360_1.frameCnt_ = 0
		arg_360_1.state_ = "playing"
		arg_360_1.curTalkId_ = 413041089
		arg_360_1.duration_ = 6.23

		local var_360_0 = {
			zh = 4.5,
			ja = 6.233
		}
		local var_360_1 = manager.audio:GetLocalizationFlag()

		if var_360_0[var_360_1] ~= nil then
			arg_360_1.duration_ = var_360_0[var_360_1]
		end

		SetActive(arg_360_1.tipsGo_, false)

		function arg_360_1.onSingleLineFinish_()
			arg_360_1.onSingleLineUpdate_ = nil
			arg_360_1.onSingleLineFinish_ = nil
			arg_360_1.state_ = "waiting"
		end

		function arg_360_1.playNext_(arg_362_0)
			if arg_362_0 == 1 then
				arg_360_0:Play413041090(arg_360_1)
			end
		end

		function arg_360_1.onSingleLineUpdate_(arg_363_0)
			if 0 < arg_360_1.time_ and arg_360_1.time_ <= 0 + arg_363_0 then
				arg_360_1.var_.moveOldPos10094 = arg_360_1.actors_["10094"].transform.localPosition
				arg_360_1.actors_["10094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_360_1:CheckSpriteTmpPos("10094", 0)

				for iter_363_0 = 0, arg_360_1.actors_["10094"].transform.childCount - 1 do
					local var_363_0 = arg_360_1.actors_["10094"].transform:GetChild(iter_363_0)

					if var_363_0.name == "" or not string.find(var_363_0.name, "split") then
						var_363_0.gameObject:SetActive(true)
					else
						var_363_0.gameObject:SetActive(false)
					end
				end
			end

			local var_363_1 = 0.001

			if 0 <= arg_360_1.time_ and arg_360_1.time_ < 0 + var_363_1 then
				arg_360_1.actors_["10094"].transform.localPosition = Vector3.Lerp(arg_360_1.var_.moveOldPos10094, Vector3.New(-5000, -340, -414), (arg_360_1.time_ - 0) / var_363_1)
			end

			if arg_360_1.time_ >= 0 + var_363_1 and arg_360_1.time_ < 0 + var_363_1 + arg_363_0 then
				arg_360_1.actors_["10094"].transform.localPosition = Vector3.New(-5000, -340, -414)
			end

			local var_363_2 = arg_360_1.actors_["10092"].transform

			if 0 < arg_360_1.time_ and arg_360_1.time_ <= 0 + arg_363_0 then
				arg_360_1.var_.moveOldPos10092 = var_363_2.localPosition
				var_363_2.localScale = Vector3.New(1, 1, 1)

				arg_360_1:CheckSpriteTmpPos("10092", 0)

				for iter_363_1 = 0, var_363_2.childCount - 1 do
					local var_363_3 = var_363_2:GetChild(iter_363_1)

					if var_363_3.name == "" or not string.find(var_363_3.name, "split") then
						var_363_3.gameObject:SetActive(true)
					else
						var_363_3.gameObject:SetActive(false)
					end
				end
			end

			local var_363_4 = 0.001

			if 0 <= arg_360_1.time_ and arg_360_1.time_ < 0 + var_363_4 then
				var_363_2.localPosition = Vector3.Lerp(arg_360_1.var_.moveOldPos10092, Vector3.New(0, -5000, 0), (arg_360_1.time_ - 0) / var_363_4)
			end

			if arg_360_1.time_ >= 0 + var_363_4 and arg_360_1.time_ < 0 + var_363_4 + arg_363_0 then
				var_363_2.localPosition = Vector3.New(0, -5000, 0)
			end

			local var_363_5 = arg_360_1.actors_["10022"].transform

			if 0 < arg_360_1.time_ and arg_360_1.time_ <= 0 + arg_363_0 then
				arg_360_1.var_.moveOldPos10022 = var_363_5.localPosition
				var_363_5.localScale = Vector3.New(1, 1, 1)

				arg_360_1:CheckSpriteTmpPos("10022", 3)

				for iter_363_2 = 0, var_363_5.childCount - 1 do
					local var_363_6 = var_363_5:GetChild(iter_363_2)

					if var_363_6.name == "split_8" or not string.find(var_363_6.name, "split") then
						var_363_6.gameObject:SetActive(true)
					else
						var_363_6.gameObject:SetActive(false)
					end
				end
			end

			local var_363_7 = 0.001

			if 0 <= arg_360_1.time_ and arg_360_1.time_ < 0 + var_363_7 then
				var_363_5.localPosition = Vector3.Lerp(arg_360_1.var_.moveOldPos10022, Vector3.New(0, -315, -320), (arg_360_1.time_ - 0) / var_363_7)
			end

			if arg_360_1.time_ >= 0 + var_363_7 and arg_360_1.time_ < 0 + var_363_7 + arg_363_0 then
				var_363_5.localPosition = Vector3.New(0, -315, -320)
			end

			local var_363_8 = arg_360_1.actors_["10094"]

			if 0 < arg_360_1.time_ and arg_360_1.time_ <= 0 + arg_363_0 and not isNil(var_363_8) and arg_360_1.var_.actorSpriteComps10094 == nil then
				arg_360_1.var_.actorSpriteComps10094 = var_363_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_363_9 = 2

			if 0 <= arg_360_1.time_ and arg_360_1.time_ < 0 + var_363_9 and not isNil(var_363_8) then
				if arg_360_1.var_.actorSpriteComps10094 then
					for iter_363_3, iter_363_4 in pairs(arg_360_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_363_4 then
							if arg_360_1.isInRecall_ then
								iter_363_4.color = Color.New(Mathf.Lerp(iter_363_4.color.r, arg_360_1.hightColor2.r, (arg_360_1.time_ - 0) / var_363_9), Mathf.Lerp(iter_363_4.color.g, arg_360_1.hightColor2.g, (arg_360_1.time_ - 0) / var_363_9), (Mathf.Lerp(iter_363_4.color.b, arg_360_1.hightColor2.b, (arg_360_1.time_ - 0) / var_363_9)))
							else
								local var_363_10 = Mathf.Lerp(iter_363_4.color.r, 0.5, (arg_360_1.time_ - 0) / var_363_9)

								iter_363_4.color = Color.New(var_363_10, var_363_10, var_363_10)
							end
						end
					end
				end
			end

			if arg_360_1.time_ >= 0 + var_363_9 and arg_360_1.time_ < 0 + var_363_9 + arg_363_0 and not isNil(var_363_8) and arg_360_1.var_.actorSpriteComps10094 then
				for iter_363_5, iter_363_6 in pairs(arg_360_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_363_6 then
						iter_363_6.color = arg_360_1.isInRecall_ and (arg_360_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_360_1.var_.actorSpriteComps10094 = nil
			end

			local var_363_11 = arg_360_1.actors_["10092"]

			if 0 < arg_360_1.time_ and arg_360_1.time_ <= 0 + arg_363_0 and not isNil(var_363_11) and arg_360_1.var_.actorSpriteComps10092 == nil then
				arg_360_1.var_.actorSpriteComps10092 = var_363_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_363_12 = 2

			if 0 <= arg_360_1.time_ and arg_360_1.time_ < 0 + var_363_12 and not isNil(var_363_11) then
				if arg_360_1.var_.actorSpriteComps10092 then
					for iter_363_7, iter_363_8 in pairs(arg_360_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_363_8 then
							if arg_360_1.isInRecall_ then
								iter_363_8.color = Color.New(Mathf.Lerp(iter_363_8.color.r, arg_360_1.hightColor2.r, (arg_360_1.time_ - 0) / var_363_12), Mathf.Lerp(iter_363_8.color.g, arg_360_1.hightColor2.g, (arg_360_1.time_ - 0) / var_363_12), (Mathf.Lerp(iter_363_8.color.b, arg_360_1.hightColor2.b, (arg_360_1.time_ - 0) / var_363_12)))
							else
								local var_363_13 = Mathf.Lerp(iter_363_8.color.r, 0.5, (arg_360_1.time_ - 0) / var_363_12)

								iter_363_8.color = Color.New(var_363_13, var_363_13, var_363_13)
							end
						end
					end
				end
			end

			if arg_360_1.time_ >= 0 + var_363_12 and arg_360_1.time_ < 0 + var_363_12 + arg_363_0 and not isNil(var_363_11) and arg_360_1.var_.actorSpriteComps10092 then
				for iter_363_9, iter_363_10 in pairs(arg_360_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_363_10 then
						iter_363_10.color = arg_360_1.isInRecall_ and (arg_360_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_360_1.var_.actorSpriteComps10092 = nil
			end

			local var_363_14 = arg_360_1.actors_["10022"]

			if 0 < arg_360_1.time_ and arg_360_1.time_ <= 0 + arg_363_0 and not isNil(var_363_14) and arg_360_1.var_.actorSpriteComps10022 == nil then
				arg_360_1.var_.actorSpriteComps10022 = var_363_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_363_15 = 2

			if 0 <= arg_360_1.time_ and arg_360_1.time_ < 0 + var_363_15 and not isNil(var_363_14) then
				if arg_360_1.var_.actorSpriteComps10022 then
					for iter_363_11, iter_363_12 in pairs(arg_360_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_363_12 then
							if arg_360_1.isInRecall_ then
								iter_363_12.color = Color.New(Mathf.Lerp(iter_363_12.color.r, arg_360_1.hightColor1.r, (arg_360_1.time_ - 0) / var_363_15), Mathf.Lerp(iter_363_12.color.g, arg_360_1.hightColor1.g, (arg_360_1.time_ - 0) / var_363_15), (Mathf.Lerp(iter_363_12.color.b, arg_360_1.hightColor1.b, (arg_360_1.time_ - 0) / var_363_15)))
							else
								local var_363_16 = Mathf.Lerp(iter_363_12.color.r, 1, (arg_360_1.time_ - 0) / var_363_15)

								iter_363_12.color = Color.New(var_363_16, var_363_16, var_363_16)
							end
						end
					end
				end
			end

			if arg_360_1.time_ >= 0 + var_363_15 and arg_360_1.time_ < 0 + var_363_15 + arg_363_0 and not isNil(var_363_14) and arg_360_1.var_.actorSpriteComps10022 then
				for iter_363_13, iter_363_14 in pairs(arg_360_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_363_14 then
						iter_363_14.color = arg_360_1.isInRecall_ and (arg_360_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_360_1.var_.actorSpriteComps10022 = nil
			end

			local var_363_17 = 0
			local var_363_18 = 0.55

			if 0 < arg_360_1.time_ and arg_360_1.time_ <= var_363_17 + arg_363_0 then
				arg_360_1.talkMaxDuration = 0
				arg_360_1.dialogCg_.alpha = 1

				arg_360_1.dialog_:SetActive(true)
				SetActive(arg_360_1.leftNameGo_, true)

				arg_360_1.leftNameTxt_.text = arg_360_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_360_1.leftNameTxt_.transform)

				arg_360_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_360_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_360_1:RecordName(arg_360_1.leftNameTxt_.text)
				SetActive(arg_360_1.iconTrs_.gameObject, false)
				arg_360_1.callingController_:SetSelectedState("normal")

				local var_363_19 = arg_360_1:GetWordFromCfg(413041089)
				local var_363_20 = arg_360_1:FormatText(var_363_19.content)

				arg_360_1.text_.text = var_363_20

				LuaForUtil.ClearLinePrefixSymbol(arg_360_1.text_)

				local var_363_22 = 22 <= 0 and var_363_18 or var_363_18 * (utf8.len(var_363_20) / 22)

				if (22 <= 0 and var_363_18 or var_363_18 * (utf8.len(var_363_20) / 22)) > 0 and var_363_18 < var_363_22 then
					arg_360_1.talkMaxDuration = var_363_22

					if var_363_22 + var_363_17 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_22 + var_363_17
					end
				end

				arg_360_1.text_.text = var_363_20
				arg_360_1.typewritter.percent = 0

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413041", "413041089", "story_v_out_413041.awb") ~= 0 then
					local var_363_23 = manager.audio:GetVoiceLength("story_v_out_413041", "413041089", "story_v_out_413041.awb") / 1000

					if var_363_23 + var_363_17 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_23 + var_363_17
					end

					if var_363_19.prefab_name ~= "" and arg_360_1.actors_[var_363_19.prefab_name] ~= nil then
						local var_363_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_360_1.actors_[var_363_19.prefab_name].transform, "story_v_out_413041", "413041089", "story_v_out_413041.awb")

						arg_360_1:RecordAudio("413041089", var_363_24)
						arg_360_1:RecordAudio("413041089", var_363_24)
					else
						arg_360_1:AudioAction("play", "voice", "story_v_out_413041", "413041089", "story_v_out_413041.awb")
					end

					arg_360_1:RecordHistoryTalkVoice("story_v_out_413041", "413041089", "story_v_out_413041.awb")
				end

				arg_360_1:RecordContent(arg_360_1.text_.text)
			end

			local var_363_25 = math.max(var_363_18, arg_360_1.talkMaxDuration)

			if var_363_17 <= arg_360_1.time_ and arg_360_1.time_ < var_363_17 + var_363_25 then
				arg_360_1.typewritter.percent = (arg_360_1.time_ - var_363_17) / var_363_25

				arg_360_1.typewritter:SetDirty()
			end

			if arg_360_1.time_ >= var_363_17 + var_363_25 and arg_360_1.time_ < var_363_17 + var_363_25 + arg_363_0 then
				arg_360_1.typewritter.percent = 1

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(true)
			end
		end

		arg_360_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_360_1:InitPlayNodeList()
	end,
	Play413041090 = function(arg_364_0, arg_364_1)
		arg_364_1.time_ = 0
		arg_364_1.frameCnt_ = 0
		arg_364_1.state_ = "playing"
		arg_364_1.curTalkId_ = 413041090
		arg_364_1.duration_ = 13.2

		local var_364_0 = {
			zh = 6.2,
			ja = 13.2
		}
		local var_364_1 = manager.audio:GetLocalizationFlag()

		if var_364_0[var_364_1] ~= nil then
			arg_364_1.duration_ = var_364_0[var_364_1]
		end

		SetActive(arg_364_1.tipsGo_, false)

		function arg_364_1.onSingleLineFinish_()
			arg_364_1.onSingleLineUpdate_ = nil
			arg_364_1.onSingleLineFinish_ = nil
			arg_364_1.state_ = "waiting"
		end

		function arg_364_1.playNext_(arg_366_0)
			if arg_366_0 == 1 then
				arg_364_0:Play413041091(arg_364_1)
			end
		end

		function arg_364_1.onSingleLineUpdate_(arg_367_0)
			if 0 < arg_364_1.time_ and arg_364_1.time_ <= 0 + arg_367_0 then
				arg_364_1.var_.moveOldPos10022 = arg_364_1.actors_["10022"].transform.localPosition
				arg_364_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_364_1:CheckSpriteTmpPos("10022", 0)

				for iter_367_0 = 0, arg_364_1.actors_["10022"].transform.childCount - 1 do
					local var_367_0 = arg_364_1.actors_["10022"].transform:GetChild(iter_367_0)

					if var_367_0.name == "" or not string.find(var_367_0.name, "split") then
						var_367_0.gameObject:SetActive(true)
					else
						var_367_0.gameObject:SetActive(false)
					end
				end
			end

			local var_367_1 = 0.001

			if 0 <= arg_364_1.time_ and arg_364_1.time_ < 0 + var_367_1 then
				arg_364_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_364_1.var_.moveOldPos10022, Vector3.New(-1500, -350, -180), (arg_364_1.time_ - 0) / var_367_1)
			end

			if arg_364_1.time_ >= 0 + var_367_1 and arg_364_1.time_ < 0 + var_367_1 + arg_367_0 then
				arg_364_1.actors_["10022"].transform.localPosition = Vector3.New(-1500, -350, -180)
			end

			local var_367_2 = arg_364_1.actors_["10094"].transform

			if 0 < arg_364_1.time_ and arg_364_1.time_ <= 0 + arg_367_0 then
				arg_364_1.var_.moveOldPos10094 = var_367_2.localPosition
				var_367_2.localScale = Vector3.New(1, 1, 1)

				arg_364_1:CheckSpriteTmpPos("10094", 3)

				for iter_367_1 = 0, var_367_2.childCount - 1 do
					local var_367_3 = var_367_2:GetChild(iter_367_1)

					if var_367_3.name == "" or not string.find(var_367_3.name, "split") then
						var_367_3.gameObject:SetActive(true)
					else
						var_367_3.gameObject:SetActive(false)
					end
				end
			end

			local var_367_4 = 0.001

			if 0 <= arg_364_1.time_ and arg_364_1.time_ < 0 + var_367_4 then
				var_367_2.localPosition = Vector3.Lerp(arg_364_1.var_.moveOldPos10094, Vector3.New(0, -340, -414), (arg_364_1.time_ - 0) / var_367_4)
			end

			if arg_364_1.time_ >= 0 + var_367_4 and arg_364_1.time_ < 0 + var_367_4 + arg_367_0 then
				var_367_2.localPosition = Vector3.New(0, -340, -414)
			end

			local var_367_5 = arg_364_1.actors_["10022"]

			if 0 < arg_364_1.time_ and arg_364_1.time_ <= 0 + arg_367_0 and not isNil(var_367_5) and arg_364_1.var_.actorSpriteComps10022 == nil then
				arg_364_1.var_.actorSpriteComps10022 = var_367_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_367_6 = 2

			if 0 <= arg_364_1.time_ and arg_364_1.time_ < 0 + var_367_6 and not isNil(var_367_5) then
				if arg_364_1.var_.actorSpriteComps10022 then
					for iter_367_2, iter_367_3 in pairs(arg_364_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_367_3 then
							if arg_364_1.isInRecall_ then
								iter_367_3.color = Color.New(Mathf.Lerp(iter_367_3.color.r, arg_364_1.hightColor2.r, (arg_364_1.time_ - 0) / var_367_6), Mathf.Lerp(iter_367_3.color.g, arg_364_1.hightColor2.g, (arg_364_1.time_ - 0) / var_367_6), (Mathf.Lerp(iter_367_3.color.b, arg_364_1.hightColor2.b, (arg_364_1.time_ - 0) / var_367_6)))
							else
								local var_367_7 = Mathf.Lerp(iter_367_3.color.r, 0.5, (arg_364_1.time_ - 0) / var_367_6)

								iter_367_3.color = Color.New(var_367_7, var_367_7, var_367_7)
							end
						end
					end
				end
			end

			if arg_364_1.time_ >= 0 + var_367_6 and arg_364_1.time_ < 0 + var_367_6 + arg_367_0 and not isNil(var_367_5) and arg_364_1.var_.actorSpriteComps10022 then
				for iter_367_4, iter_367_5 in pairs(arg_364_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_367_5 then
						iter_367_5.color = arg_364_1.isInRecall_ and (arg_364_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_364_1.var_.actorSpriteComps10022 = nil
			end

			local var_367_8 = arg_364_1.actors_["10094"]

			if 0 < arg_364_1.time_ and arg_364_1.time_ <= 0 + arg_367_0 and not isNil(var_367_8) and arg_364_1.var_.actorSpriteComps10094 == nil then
				arg_364_1.var_.actorSpriteComps10094 = var_367_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_367_9 = 2

			if 0 <= arg_364_1.time_ and arg_364_1.time_ < 0 + var_367_9 and not isNil(var_367_8) then
				if arg_364_1.var_.actorSpriteComps10094 then
					for iter_367_6, iter_367_7 in pairs(arg_364_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_367_7 then
							if arg_364_1.isInRecall_ then
								iter_367_7.color = Color.New(Mathf.Lerp(iter_367_7.color.r, arg_364_1.hightColor1.r, (arg_364_1.time_ - 0) / var_367_9), Mathf.Lerp(iter_367_7.color.g, arg_364_1.hightColor1.g, (arg_364_1.time_ - 0) / var_367_9), (Mathf.Lerp(iter_367_7.color.b, arg_364_1.hightColor1.b, (arg_364_1.time_ - 0) / var_367_9)))
							else
								local var_367_10 = Mathf.Lerp(iter_367_7.color.r, 1, (arg_364_1.time_ - 0) / var_367_9)

								iter_367_7.color = Color.New(var_367_10, var_367_10, var_367_10)
							end
						end
					end
				end
			end

			if arg_364_1.time_ >= 0 + var_367_9 and arg_364_1.time_ < 0 + var_367_9 + arg_367_0 and not isNil(var_367_8) and arg_364_1.var_.actorSpriteComps10094 then
				for iter_367_8, iter_367_9 in pairs(arg_364_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_367_9 then
						iter_367_9.color = arg_364_1.isInRecall_ and (arg_364_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_364_1.var_.actorSpriteComps10094 = nil
			end

			local var_367_11 = 0
			local var_367_12 = 0.675

			if 0 < arg_364_1.time_ and arg_364_1.time_ <= var_367_11 + arg_367_0 then
				arg_364_1.talkMaxDuration = 0
				arg_364_1.dialogCg_.alpha = 1

				arg_364_1.dialog_:SetActive(true)
				SetActive(arg_364_1.leftNameGo_, true)

				arg_364_1.leftNameTxt_.text = arg_364_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_364_1.leftNameTxt_.transform)

				arg_364_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_364_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_364_1:RecordName(arg_364_1.leftNameTxt_.text)
				SetActive(arg_364_1.iconTrs_.gameObject, false)
				arg_364_1.callingController_:SetSelectedState("normal")

				local var_367_13 = arg_364_1:GetWordFromCfg(413041090)
				local var_367_14 = arg_364_1:FormatText(var_367_13.content)

				arg_364_1.text_.text = var_367_14

				LuaForUtil.ClearLinePrefixSymbol(arg_364_1.text_)

				local var_367_16 = 27 <= 0 and var_367_12 or var_367_12 * (utf8.len(var_367_14) / 27)

				if (27 <= 0 and var_367_12 or var_367_12 * (utf8.len(var_367_14) / 27)) > 0 and var_367_12 < var_367_16 then
					arg_364_1.talkMaxDuration = var_367_16

					if var_367_16 + var_367_11 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_16 + var_367_11
					end
				end

				arg_364_1.text_.text = var_367_14
				arg_364_1.typewritter.percent = 0

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413041", "413041090", "story_v_out_413041.awb") ~= 0 then
					local var_367_17 = manager.audio:GetVoiceLength("story_v_out_413041", "413041090", "story_v_out_413041.awb") / 1000

					if var_367_17 + var_367_11 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_17 + var_367_11
					end

					if var_367_13.prefab_name ~= "" and arg_364_1.actors_[var_367_13.prefab_name] ~= nil then
						local var_367_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_364_1.actors_[var_367_13.prefab_name].transform, "story_v_out_413041", "413041090", "story_v_out_413041.awb")

						arg_364_1:RecordAudio("413041090", var_367_18)
						arg_364_1:RecordAudio("413041090", var_367_18)
					else
						arg_364_1:AudioAction("play", "voice", "story_v_out_413041", "413041090", "story_v_out_413041.awb")
					end

					arg_364_1:RecordHistoryTalkVoice("story_v_out_413041", "413041090", "story_v_out_413041.awb")
				end

				arg_364_1:RecordContent(arg_364_1.text_.text)
			end

			local var_367_19 = math.max(var_367_12, arg_364_1.talkMaxDuration)

			if var_367_11 <= arg_364_1.time_ and arg_364_1.time_ < var_367_11 + var_367_19 then
				arg_364_1.typewritter.percent = (arg_364_1.time_ - var_367_11) / var_367_19

				arg_364_1.typewritter:SetDirty()
			end

			if arg_364_1.time_ >= var_367_11 + var_367_19 and arg_364_1.time_ < var_367_11 + var_367_19 + arg_367_0 then
				arg_364_1.typewritter.percent = 1

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(true)
			end
		end

		arg_364_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_364_1:InitPlayNodeList()
	end,
	Play413041091 = function(arg_368_0, arg_368_1)
		arg_368_1.time_ = 0
		arg_368_1.frameCnt_ = 0
		arg_368_1.state_ = "playing"
		arg_368_1.curTalkId_ = 413041091
		arg_368_1.duration_ = 7.53

		local var_368_0 = {
			zh = 4.066,
			ja = 7.533
		}
		local var_368_1 = manager.audio:GetLocalizationFlag()

		if var_368_0[var_368_1] ~= nil then
			arg_368_1.duration_ = var_368_0[var_368_1]
		end

		SetActive(arg_368_1.tipsGo_, false)

		function arg_368_1.onSingleLineFinish_()
			arg_368_1.onSingleLineUpdate_ = nil
			arg_368_1.onSingleLineFinish_ = nil
			arg_368_1.state_ = "waiting"
		end

		function arg_368_1.playNext_(arg_370_0)
			if arg_370_0 == 1 then
				arg_368_0:Play413041092(arg_368_1)
			end
		end

		function arg_368_1.onSingleLineUpdate_(arg_371_0)
			local var_371_0 = 0.55

			if 0 < arg_368_1.time_ and arg_368_1.time_ <= 0 + arg_371_0 then
				arg_368_1.talkMaxDuration = 0
				arg_368_1.dialogCg_.alpha = 1

				arg_368_1.dialog_:SetActive(true)
				SetActive(arg_368_1.leftNameGo_, true)

				arg_368_1.leftNameTxt_.text = arg_368_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_368_1.leftNameTxt_.transform)

				arg_368_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_368_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_368_1:RecordName(arg_368_1.leftNameTxt_.text)
				SetActive(arg_368_1.iconTrs_.gameObject, false)
				arg_368_1.callingController_:SetSelectedState("normal")

				local var_371_1 = arg_368_1:GetWordFromCfg(413041091)
				local var_371_2 = arg_368_1:FormatText(var_371_1.content)

				arg_368_1.text_.text = var_371_2

				LuaForUtil.ClearLinePrefixSymbol(arg_368_1.text_)

				local var_371_4 = 22 <= 0 and var_371_0 or var_371_0 * (utf8.len(var_371_2) / 22)

				if (22 <= 0 and var_371_0 or var_371_0 * (utf8.len(var_371_2) / 22)) > 0 and var_371_0 < var_371_4 then
					arg_368_1.talkMaxDuration = var_371_4

					if var_371_4 + 0 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_4 + 0
					end
				end

				arg_368_1.text_.text = var_371_2
				arg_368_1.typewritter.percent = 0

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413041", "413041091", "story_v_out_413041.awb") ~= 0 then
					local var_371_5 = manager.audio:GetVoiceLength("story_v_out_413041", "413041091", "story_v_out_413041.awb") / 1000

					if var_371_5 + 0 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_5 + 0
					end

					if var_371_1.prefab_name ~= "" and arg_368_1.actors_[var_371_1.prefab_name] ~= nil then
						local var_371_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_368_1.actors_[var_371_1.prefab_name].transform, "story_v_out_413041", "413041091", "story_v_out_413041.awb")

						arg_368_1:RecordAudio("413041091", var_371_6)
						arg_368_1:RecordAudio("413041091", var_371_6)
					else
						arg_368_1:AudioAction("play", "voice", "story_v_out_413041", "413041091", "story_v_out_413041.awb")
					end

					arg_368_1:RecordHistoryTalkVoice("story_v_out_413041", "413041091", "story_v_out_413041.awb")
				end

				arg_368_1:RecordContent(arg_368_1.text_.text)
			end

			local var_371_7 = math.max(var_371_0, arg_368_1.talkMaxDuration)

			if 0 <= arg_368_1.time_ and arg_368_1.time_ < 0 + var_371_7 then
				arg_368_1.typewritter.percent = (arg_368_1.time_ - 0) / var_371_7

				arg_368_1.typewritter:SetDirty()
			end

			if arg_368_1.time_ >= 0 + var_371_7 and arg_368_1.time_ < 0 + var_371_7 + arg_371_0 then
				arg_368_1.typewritter.percent = 1

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(true)
			end
		end

		arg_368_1.nodeConfigList_ = {}

		arg_368_1:InitPlayNodeList()
	end,
	Play413041092 = function(arg_372_0, arg_372_1)
		arg_372_1.time_ = 0
		arg_372_1.frameCnt_ = 0
		arg_372_1.state_ = "playing"
		arg_372_1.curTalkId_ = 413041092
		arg_372_1.duration_ = 9

		SetActive(arg_372_1.tipsGo_, false)

		function arg_372_1.onSingleLineFinish_()
			arg_372_1.onSingleLineUpdate_ = nil
			arg_372_1.onSingleLineFinish_ = nil
			arg_372_1.state_ = "waiting"
		end

		function arg_372_1.playNext_(arg_374_0)
			if arg_374_0 == 1 then
				arg_372_0:Play413041093(arg_372_1)
			end
		end

		function arg_372_1.onSingleLineUpdate_(arg_375_0)
			if arg_372_1.bgs_.STblack == nil then
				local var_375_0 = Object.Instantiate(arg_372_1.paintGo_)

				var_375_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_375_0.name = "STblack"
				var_375_0.transform.parent = arg_372_1.stage_.transform
				var_375_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_372_1.bgs_.STblack = var_375_0
			end

			if 2 < arg_372_1.time_ and arg_372_1.time_ <= 2 + arg_375_0 then
				local var_375_1 = arg_372_1.bgs_.STblack

				arg_372_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_375_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_375_2 = var_375_1:GetComponent("SpriteRenderer")

				if var_375_2 and var_375_2.sprite then
					local var_375_3 = 2 * (var_375_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_375_1.transform.localScale = Vector3.New(var_375_3 / var_375_2.sprite.bounds.size.y < var_375_3 * manager.ui.mainCameraCom_.aspect / var_375_2.sprite.bounds.size.x and var_375_3 * manager.ui.mainCameraCom_.aspect / var_375_2.sprite.bounds.size.x or var_375_3 / var_375_2.sprite.bounds.size.y, var_375_3 / var_375_2.sprite.bounds.size.y < var_375_3 * manager.ui.mainCameraCom_.aspect / var_375_2.sprite.bounds.size.x and var_375_3 * manager.ui.mainCameraCom_.aspect / var_375_2.sprite.bounds.size.x or var_375_3 / var_375_2.sprite.bounds.size.y, 0)
				end

				for iter_375_0, iter_375_1 in pairs(arg_372_1.bgs_) do
					if iter_375_0 ~= "STblack" then
						iter_375_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_375_4 = 1.966

			if 1.966 < arg_372_1.time_ and arg_372_1.time_ <= var_375_4 + arg_375_0 then
				arg_372_1.allBtn_.enabled = false
			end

			if arg_372_1.time_ >= var_375_4 + 0.034 and arg_372_1.time_ < var_375_4 + 0.034 + arg_375_0 then
				arg_372_1.allBtn_.enabled = true
			end

			local var_375_5 = 0

			if 0 < arg_372_1.time_ and arg_372_1.time_ <= var_375_5 + arg_375_0 then
				arg_372_1.mask_.enabled = true
				arg_372_1.mask_.raycastTarget = true

				arg_372_1:SetGaussion(false)
			end

			local var_375_6 = 2

			if var_375_5 <= arg_372_1.time_ and arg_372_1.time_ < var_375_5 + var_375_6 then
				local var_375_7 = Color.New(0, 0, 0)

				var_375_7.a = Mathf.Lerp(0, 1, (arg_372_1.time_ - var_375_5) / var_375_6)
				arg_372_1.mask_.color = var_375_7
			end

			if arg_372_1.time_ >= var_375_5 + var_375_6 and arg_372_1.time_ < var_375_5 + var_375_6 + arg_375_0 then
				local var_375_8 = Color.New(0, 0, 0)

				var_375_8.a = 1
				arg_372_1.mask_.color = var_375_8
			end

			local var_375_9 = 2

			if 2 < arg_372_1.time_ and arg_372_1.time_ <= var_375_9 + arg_375_0 then
				arg_372_1.mask_.enabled = true
				arg_372_1.mask_.raycastTarget = true

				arg_372_1:SetGaussion(false)
			end

			local var_375_10 = 2

			if var_375_9 <= arg_372_1.time_ and arg_372_1.time_ < var_375_9 + var_375_10 then
				local var_375_11 = Color.New(0, 0, 0)

				var_375_11.a = Mathf.Lerp(1, 0, (arg_372_1.time_ - var_375_9) / var_375_10)
				arg_372_1.mask_.color = var_375_11
			end

			if arg_372_1.time_ >= var_375_9 + var_375_10 and arg_372_1.time_ < var_375_9 + var_375_10 + arg_375_0 then
				local var_375_12 = Color.New(0, 0, 0)

				arg_372_1.mask_.enabled = false
				var_375_12.a = 0
				arg_372_1.mask_.color = var_375_12
			end

			local var_375_13 = arg_372_1.actors_["10094"].transform

			if 1.966 < arg_372_1.time_ and arg_372_1.time_ <= 1.966 + arg_375_0 then
				arg_372_1.var_.moveOldPos10094 = var_375_13.localPosition
				var_375_13.localScale = Vector3.New(1, 1, 1)

				arg_372_1:CheckSpriteTmpPos("10094", 0)

				for iter_375_2 = 0, var_375_13.childCount - 1 do
					local var_375_14 = var_375_13:GetChild(iter_375_2)

					if var_375_14.name == "" or not string.find(var_375_14.name, "split") then
						var_375_14.gameObject:SetActive(true)
					else
						var_375_14.gameObject:SetActive(false)
					end
				end
			end

			local var_375_15 = 0.001

			if 1.966 <= arg_372_1.time_ and arg_372_1.time_ < 1.966 + var_375_15 then
				var_375_13.localPosition = Vector3.Lerp(arg_372_1.var_.moveOldPos10094, Vector3.New(-5000, -340, -414), (arg_372_1.time_ - 1.966) / var_375_15)
			end

			if arg_372_1.time_ >= 1.966 + var_375_15 and arg_372_1.time_ < 1.966 + var_375_15 + arg_375_0 then
				var_375_13.localPosition = Vector3.New(-5000, -340, -414)
			end

			local var_375_16 = arg_372_1.actors_["10094"]

			if 1.966 < arg_372_1.time_ and arg_372_1.time_ <= 1.966 + arg_375_0 and not isNil(var_375_16) and arg_372_1.var_.actorSpriteComps10094 == nil then
				arg_372_1.var_.actorSpriteComps10094 = var_375_16:GetComponentsInChildren(typeof(Image), true)
			end

			local var_375_17 = 0.034

			if 1.966 <= arg_372_1.time_ and arg_372_1.time_ < 1.966 + var_375_17 and not isNil(var_375_16) then
				if arg_372_1.var_.actorSpriteComps10094 then
					for iter_375_3, iter_375_4 in pairs(arg_372_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_375_4 then
							if arg_372_1.isInRecall_ then
								iter_375_4.color = Color.New(Mathf.Lerp(iter_375_4.color.r, arg_372_1.hightColor2.r, (arg_372_1.time_ - 1.966) / var_375_17), Mathf.Lerp(iter_375_4.color.g, arg_372_1.hightColor2.g, (arg_372_1.time_ - 1.966) / var_375_17), (Mathf.Lerp(iter_375_4.color.b, arg_372_1.hightColor2.b, (arg_372_1.time_ - 1.966) / var_375_17)))
							else
								local var_375_18 = Mathf.Lerp(iter_375_4.color.r, 0.5, (arg_372_1.time_ - 1.966) / var_375_17)

								iter_375_4.color = Color.New(var_375_18, var_375_18, var_375_18)
							end
						end
					end
				end
			end

			if arg_372_1.time_ >= 1.966 + var_375_17 and arg_372_1.time_ < 1.966 + var_375_17 + arg_375_0 and not isNil(var_375_16) and arg_372_1.var_.actorSpriteComps10094 then
				for iter_375_5, iter_375_6 in pairs(arg_372_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_375_6 then
						iter_375_6.color = arg_372_1.isInRecall_ and (arg_372_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_372_1.var_.actorSpriteComps10094 = nil
			end

			if arg_372_1.frameCnt_ <= 1 then
				arg_372_1.dialog_:SetActive(false)
			end

			local var_375_19 = 4
			local var_375_20 = 1.225

			if 4 < arg_372_1.time_ and arg_372_1.time_ <= var_375_19 + arg_375_0 then
				arg_372_1.talkMaxDuration = 0

				arg_372_1.dialog_:SetActive(true)

				arg_372_1.dialogCg_.alpha = 0

				local var_375_21 = LeanTween.value(arg_372_1.dialog_, 0, 1, 0.3)

				var_375_21:setOnUpdate(LuaHelper.FloatAction(function(arg_376_0)
					arg_372_1.dialogCg_.alpha = arg_376_0
				end))
				var_375_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_372_1.dialog_)
					var_375_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_372_1.duration_ = arg_372_1.duration_ + 0.3

				SetActive(arg_372_1.leftNameGo_, false)

				arg_372_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_372_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_372_1:RecordName(arg_372_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_372_1.iconTrs_.gameObject, false)
				arg_372_1.callingController_:SetSelectedState("normal")

				local var_375_22 = arg_372_1:FormatText(arg_372_1:GetWordFromCfg(413041092).content)

				arg_372_1.text_.text = var_375_22

				LuaForUtil.ClearLinePrefixSymbol(arg_372_1.text_)

				local var_375_24 = 49 <= 0 and var_375_20 or var_375_20 * (utf8.len(var_375_22) / 49)

				if (49 <= 0 and var_375_20 or var_375_20 * (utf8.len(var_375_22) / 49)) > 0 and var_375_20 < var_375_24 then
					arg_372_1.talkMaxDuration = var_375_24
					var_375_19 = var_375_19 + 0.3

					if var_375_24 + var_375_19 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_24 + var_375_19
					end
				end

				arg_372_1.text_.text = var_375_22
				arg_372_1.typewritter.percent = 0

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(false)
				arg_372_1:RecordContent(arg_372_1.text_.text)
			end

			local var_375_25 = var_375_19 + 0.3
			local var_375_26 = math.max(var_375_20, arg_372_1.talkMaxDuration)

			if var_375_19 + 0.3 <= arg_372_1.time_ and arg_372_1.time_ < var_375_25 + var_375_26 then
				arg_372_1.typewritter.percent = (arg_372_1.time_ - var_375_25) / var_375_26

				arg_372_1.typewritter:SetDirty()
			end

			if arg_372_1.time_ >= var_375_25 + var_375_26 and arg_372_1.time_ < var_375_25 + var_375_26 + arg_375_0 then
				arg_372_1.typewritter.percent = 1

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(true)
			end
		end

		arg_372_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_372_1:InitPlayNodeList()
	end,
	Play413041093 = function(arg_378_0, arg_378_1)
		arg_378_1.time_ = 0
		arg_378_1.frameCnt_ = 0
		arg_378_1.state_ = "playing"
		arg_378_1.curTalkId_ = 413041093
		arg_378_1.duration_ = 14.4

		local var_378_0 = {
			zh = 10.766,
			ja = 14.4
		}
		local var_378_1 = manager.audio:GetLocalizationFlag()

		if var_378_0[var_378_1] ~= nil then
			arg_378_1.duration_ = var_378_0[var_378_1]
		end

		SetActive(arg_378_1.tipsGo_, false)

		function arg_378_1.onSingleLineFinish_()
			arg_378_1.onSingleLineUpdate_ = nil
			arg_378_1.onSingleLineFinish_ = nil
			arg_378_1.state_ = "waiting"
		end

		function arg_378_1.playNext_(arg_380_0)
			if arg_380_0 == 1 then
				arg_378_0:Play413041094(arg_378_1)
			end
		end

		function arg_378_1.onSingleLineUpdate_(arg_381_0)
			if 2 < arg_378_1.time_ and arg_378_1.time_ <= 2 + arg_381_0 then
				arg_378_1.var_.moveOldPos10092 = arg_378_1.actors_["10092"].transform.localPosition
				arg_378_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_378_1:CheckSpriteTmpPos("10092", 3)

				for iter_381_0 = 0, arg_378_1.actors_["10092"].transform.childCount - 1 do
					local var_381_0 = arg_378_1.actors_["10092"].transform:GetChild(iter_381_0)

					if var_381_0.name == "" or not string.find(var_381_0.name, "split") then
						var_381_0.gameObject:SetActive(true)
					else
						var_381_0.gameObject:SetActive(false)
					end
				end
			end

			local var_381_1 = 0.001

			if 2 <= arg_378_1.time_ and arg_378_1.time_ < 2 + var_381_1 then
				arg_378_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_378_1.var_.moveOldPos10092, Vector3.New(0, -300, -295), (arg_378_1.time_ - 2) / var_381_1)
			end

			if arg_378_1.time_ >= 2 + var_381_1 and arg_378_1.time_ < 2 + var_381_1 + arg_381_0 then
				arg_378_1.actors_["10092"].transform.localPosition = Vector3.New(0, -300, -295)
			end

			local var_381_2 = arg_378_1.actors_["10092"]

			if 2 < arg_378_1.time_ and arg_378_1.time_ <= 2 + arg_381_0 and not isNil(var_381_2) and arg_378_1.var_.actorSpriteComps10092 == nil then
				arg_378_1.var_.actorSpriteComps10092 = var_381_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_381_3 = 0.1

			if 2 <= arg_378_1.time_ and arg_378_1.time_ < 2 + var_381_3 and not isNil(var_381_2) then
				if arg_378_1.var_.actorSpriteComps10092 then
					for iter_381_1, iter_381_2 in pairs(arg_378_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_381_2 then
							if arg_378_1.isInRecall_ then
								iter_381_2.color = Color.New(Mathf.Lerp(iter_381_2.color.r, arg_378_1.hightColor1.r, (arg_378_1.time_ - 2) / var_381_3), Mathf.Lerp(iter_381_2.color.g, arg_378_1.hightColor1.g, (arg_378_1.time_ - 2) / var_381_3), (Mathf.Lerp(iter_381_2.color.b, arg_378_1.hightColor1.b, (arg_378_1.time_ - 2) / var_381_3)))
							else
								local var_381_4 = Mathf.Lerp(iter_381_2.color.r, 1, (arg_378_1.time_ - 2) / var_381_3)

								iter_381_2.color = Color.New(var_381_4, var_381_4, var_381_4)
							end
						end
					end
				end
			end

			if arg_378_1.time_ >= 2 + var_381_3 and arg_378_1.time_ < 2 + var_381_3 + arg_381_0 and not isNil(var_381_2) and arg_378_1.var_.actorSpriteComps10092 then
				for iter_381_3, iter_381_4 in pairs(arg_378_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_381_4 then
						iter_381_4.color = arg_378_1.isInRecall_ and (arg_378_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_378_1.var_.actorSpriteComps10092 = nil
			end

			if 0 < arg_378_1.time_ and arg_378_1.time_ <= 0 + arg_381_0 then
				local var_381_5 = arg_378_1.bgs_.ST0602

				arg_378_1.bgs_.ST0602.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_381_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_381_6 = var_381_5:GetComponent("SpriteRenderer")

				if var_381_6 and var_381_6.sprite then
					local var_381_7 = 2 * (var_381_5.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_381_5.transform.localScale = Vector3.New(var_381_7 / var_381_6.sprite.bounds.size.y < var_381_7 * manager.ui.mainCameraCom_.aspect / var_381_6.sprite.bounds.size.x and var_381_7 * manager.ui.mainCameraCom_.aspect / var_381_6.sprite.bounds.size.x or var_381_7 / var_381_6.sprite.bounds.size.y, var_381_7 / var_381_6.sprite.bounds.size.y < var_381_7 * manager.ui.mainCameraCom_.aspect / var_381_6.sprite.bounds.size.x and var_381_7 * manager.ui.mainCameraCom_.aspect / var_381_6.sprite.bounds.size.x or var_381_7 / var_381_6.sprite.bounds.size.y, 0)
				end

				for iter_381_5, iter_381_6 in pairs(arg_378_1.bgs_) do
					if iter_381_5 ~= "ST0602" then
						iter_381_6.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_381_8 = 0

			if 0 < arg_378_1.time_ and arg_378_1.time_ <= var_381_8 + arg_381_0 then
				arg_378_1.mask_.enabled = true
				arg_378_1.mask_.raycastTarget = true

				arg_378_1:SetGaussion(false)
			end

			local var_381_9 = 2

			if var_381_8 <= arg_378_1.time_ and arg_378_1.time_ < var_381_8 + var_381_9 then
				local var_381_10 = Color.New(0, 0, 0)

				var_381_10.a = Mathf.Lerp(1, 0, (arg_378_1.time_ - var_381_8) / var_381_9)
				arg_378_1.mask_.color = var_381_10
			end

			if arg_378_1.time_ >= var_381_8 + var_381_9 and arg_378_1.time_ < var_381_8 + var_381_9 + arg_381_0 then
				local var_381_11 = Color.New(0, 0, 0)

				arg_378_1.mask_.enabled = false
				var_381_11.a = 0
				arg_378_1.mask_.color = var_381_11
			end

			if 2 < arg_378_1.time_ and arg_378_1.time_ <= 2 + arg_381_0 then
				local var_381_12 = arg_378_1.actors_["10092"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_381_12 then
					arg_378_1.var_.alphaOldValue10092 = var_381_12.alpha
					arg_378_1.var_.characterEffect10092 = var_381_12
				end

				arg_378_1.var_.alphaOldValue10092 = 0
			end

			local var_381_13 = 0.2

			if 2 <= arg_378_1.time_ and arg_378_1.time_ < 2 + var_381_13 then
				if arg_378_1.var_.characterEffect10092 then
					arg_378_1.var_.characterEffect10092.alpha = Mathf.Lerp(arg_378_1.var_.alphaOldValue10092, 1, (arg_378_1.time_ - 2) / var_381_13)
				end
			end

			if arg_378_1.time_ >= 2 + var_381_13 and arg_378_1.time_ < 2 + var_381_13 + arg_381_0 and arg_378_1.var_.characterEffect10092 then
				arg_378_1.var_.characterEffect10092.alpha = 1
			end

			if arg_378_1.frameCnt_ <= 1 then
				arg_378_1.dialog_:SetActive(false)
			end

			local var_381_14 = 2
			local var_381_15 = 0.95

			if 2 < arg_378_1.time_ and arg_378_1.time_ <= var_381_14 + arg_381_0 then
				arg_378_1.talkMaxDuration = 0

				arg_378_1.dialog_:SetActive(true)

				arg_378_1.dialogCg_.alpha = 0

				local var_381_16 = LeanTween.value(arg_378_1.dialog_, 0, 1, 0.3)

				var_381_16:setOnUpdate(LuaHelper.FloatAction(function(arg_382_0)
					arg_378_1.dialogCg_.alpha = arg_382_0
				end))
				var_381_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_378_1.dialog_)
					var_381_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_378_1.duration_ = arg_378_1.duration_ + 0.3

				SetActive(arg_378_1.leftNameGo_, true)

				arg_378_1.leftNameTxt_.text = arg_378_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_378_1.leftNameTxt_.transform)

				arg_378_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_378_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_378_1:RecordName(arg_378_1.leftNameTxt_.text)
				SetActive(arg_378_1.iconTrs_.gameObject, false)
				arg_378_1.callingController_:SetSelectedState("normal")

				local var_381_17 = arg_378_1:GetWordFromCfg(413041093)
				local var_381_18 = arg_378_1:FormatText(var_381_17.content)

				arg_378_1.text_.text = var_381_18

				LuaForUtil.ClearLinePrefixSymbol(arg_378_1.text_)

				local var_381_20 = 38 <= 0 and var_381_15 or var_381_15 * (utf8.len(var_381_18) / 38)

				if (38 <= 0 and var_381_15 or var_381_15 * (utf8.len(var_381_18) / 38)) > 0 and var_381_15 < var_381_20 then
					arg_378_1.talkMaxDuration = var_381_20
					var_381_14 = var_381_14 + 0.3

					if var_381_20 + var_381_14 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_20 + var_381_14
					end
				end

				arg_378_1.text_.text = var_381_18
				arg_378_1.typewritter.percent = 0

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413041", "413041093", "story_v_out_413041.awb") ~= 0 then
					local var_381_21 = manager.audio:GetVoiceLength("story_v_out_413041", "413041093", "story_v_out_413041.awb") / 1000

					if var_381_21 + var_381_14 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_21 + var_381_14
					end

					if var_381_17.prefab_name ~= "" and arg_378_1.actors_[var_381_17.prefab_name] ~= nil then
						local var_381_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_378_1.actors_[var_381_17.prefab_name].transform, "story_v_out_413041", "413041093", "story_v_out_413041.awb")

						arg_378_1:RecordAudio("413041093", var_381_22)
						arg_378_1:RecordAudio("413041093", var_381_22)
					else
						arg_378_1:AudioAction("play", "voice", "story_v_out_413041", "413041093", "story_v_out_413041.awb")
					end

					arg_378_1:RecordHistoryTalkVoice("story_v_out_413041", "413041093", "story_v_out_413041.awb")
				end

				arg_378_1:RecordContent(arg_378_1.text_.text)
			end

			local var_381_23 = var_381_14 + 0.3
			local var_381_24 = math.max(var_381_15, arg_378_1.talkMaxDuration)

			if var_381_14 + 0.3 <= arg_378_1.time_ and arg_378_1.time_ < var_381_23 + var_381_24 then
				arg_378_1.typewritter.percent = (arg_378_1.time_ - var_381_23) / var_381_24

				arg_378_1.typewritter:SetDirty()
			end

			if arg_378_1.time_ >= var_381_23 + var_381_24 and arg_378_1.time_ < var_381_23 + var_381_24 + arg_381_0 then
				arg_378_1.typewritter.percent = 1

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(true)
			end
		end

		arg_378_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_378_1:InitPlayNodeList()
	end,
	Play413041094 = function(arg_384_0, arg_384_1)
		arg_384_1.time_ = 0
		arg_384_1.frameCnt_ = 0
		arg_384_1.state_ = "playing"
		arg_384_1.curTalkId_ = 413041094
		arg_384_1.duration_ = 4.63

		local var_384_0 = {
			zh = 4.166,
			ja = 4.633
		}
		local var_384_1 = manager.audio:GetLocalizationFlag()

		if var_384_0[var_384_1] ~= nil then
			arg_384_1.duration_ = var_384_0[var_384_1]
		end

		SetActive(arg_384_1.tipsGo_, false)

		function arg_384_1.onSingleLineFinish_()
			arg_384_1.onSingleLineUpdate_ = nil
			arg_384_1.onSingleLineFinish_ = nil
			arg_384_1.state_ = "waiting"
		end

		function arg_384_1.playNext_(arg_386_0)
			if arg_386_0 == 1 then
				arg_384_0:Play413041095(arg_384_1)
			end
		end

		function arg_384_1.onSingleLineUpdate_(arg_387_0)
			if 0 < arg_384_1.time_ and arg_384_1.time_ <= 0 + arg_387_0 then
				arg_384_1.var_.moveOldPos10093 = arg_384_1.actors_["10093"].transform.localPosition
				arg_384_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_384_1:CheckSpriteTmpPos("10093", 2)

				for iter_387_0 = 0, arg_384_1.actors_["10093"].transform.childCount - 1 do
					local var_387_0 = arg_384_1.actors_["10093"].transform:GetChild(iter_387_0)

					if var_387_0.name == "split_4" or not string.find(var_387_0.name, "split") then
						var_387_0.gameObject:SetActive(true)
					else
						var_387_0.gameObject:SetActive(false)
					end
				end
			end

			local var_387_1 = 0.001

			if 0 <= arg_384_1.time_ and arg_384_1.time_ < 0 + var_387_1 then
				arg_384_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_384_1.var_.moveOldPos10093, Vector3.New(-390, -345, -245), (arg_384_1.time_ - 0) / var_387_1)
			end

			if arg_384_1.time_ >= 0 + var_387_1 and arg_384_1.time_ < 0 + var_387_1 + arg_387_0 then
				arg_384_1.actors_["10093"].transform.localPosition = Vector3.New(-390, -345, -245)
			end

			local var_387_2 = arg_384_1.actors_["10093"]

			if 0 < arg_384_1.time_ and arg_384_1.time_ <= 0 + arg_387_0 and not isNil(var_387_2) and arg_384_1.var_.actorSpriteComps10093 == nil then
				arg_384_1.var_.actorSpriteComps10093 = var_387_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_387_3 = 2

			if 0 <= arg_384_1.time_ and arg_384_1.time_ < 0 + var_387_3 and not isNil(var_387_2) then
				if arg_384_1.var_.actorSpriteComps10093 then
					for iter_387_1, iter_387_2 in pairs(arg_384_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_387_2 then
							if arg_384_1.isInRecall_ then
								iter_387_2.color = Color.New(Mathf.Lerp(iter_387_2.color.r, arg_384_1.hightColor1.r, (arg_384_1.time_ - 0) / var_387_3), Mathf.Lerp(iter_387_2.color.g, arg_384_1.hightColor1.g, (arg_384_1.time_ - 0) / var_387_3), (Mathf.Lerp(iter_387_2.color.b, arg_384_1.hightColor1.b, (arg_384_1.time_ - 0) / var_387_3)))
							else
								local var_387_4 = Mathf.Lerp(iter_387_2.color.r, 1, (arg_384_1.time_ - 0) / var_387_3)

								iter_387_2.color = Color.New(var_387_4, var_387_4, var_387_4)
							end
						end
					end
				end
			end

			if arg_384_1.time_ >= 0 + var_387_3 and arg_384_1.time_ < 0 + var_387_3 + arg_387_0 and not isNil(var_387_2) and arg_384_1.var_.actorSpriteComps10093 then
				for iter_387_3, iter_387_4 in pairs(arg_384_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_387_4 then
						iter_387_4.color = arg_384_1.isInRecall_ and (arg_384_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_384_1.var_.actorSpriteComps10093 = nil
			end

			local var_387_5 = arg_384_1.actors_["10092"]

			if 0 < arg_384_1.time_ and arg_384_1.time_ <= 0 + arg_387_0 and not isNil(var_387_5) and arg_384_1.var_.actorSpriteComps10092 == nil then
				arg_384_1.var_.actorSpriteComps10092 = var_387_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_387_6 = 2

			if 0 <= arg_384_1.time_ and arg_384_1.time_ < 0 + var_387_6 and not isNil(var_387_5) then
				if arg_384_1.var_.actorSpriteComps10092 then
					for iter_387_5, iter_387_6 in pairs(arg_384_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_387_6 then
							if arg_384_1.isInRecall_ then
								iter_387_6.color = Color.New(Mathf.Lerp(iter_387_6.color.r, arg_384_1.hightColor2.r, (arg_384_1.time_ - 0) / var_387_6), Mathf.Lerp(iter_387_6.color.g, arg_384_1.hightColor2.g, (arg_384_1.time_ - 0) / var_387_6), (Mathf.Lerp(iter_387_6.color.b, arg_384_1.hightColor2.b, (arg_384_1.time_ - 0) / var_387_6)))
							else
								local var_387_7 = Mathf.Lerp(iter_387_6.color.r, 0.5, (arg_384_1.time_ - 0) / var_387_6)

								iter_387_6.color = Color.New(var_387_7, var_387_7, var_387_7)
							end
						end
					end
				end
			end

			if arg_384_1.time_ >= 0 + var_387_6 and arg_384_1.time_ < 0 + var_387_6 + arg_387_0 and not isNil(var_387_5) and arg_384_1.var_.actorSpriteComps10092 then
				for iter_387_7, iter_387_8 in pairs(arg_384_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_387_8 then
						iter_387_8.color = arg_384_1.isInRecall_ and (arg_384_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_384_1.var_.actorSpriteComps10092 = nil
			end

			if 0 < arg_384_1.time_ and arg_384_1.time_ <= 0 + arg_387_0 then
				local var_387_8 = arg_384_1.actors_["10093"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_387_8 then
					arg_384_1.var_.alphaOldValue10093 = var_387_8.alpha
					arg_384_1.var_.characterEffect10093 = var_387_8
				end

				arg_384_1.var_.alphaOldValue10093 = 0
			end

			local var_387_9 = 0.5

			if 0 <= arg_384_1.time_ and arg_384_1.time_ < 0 + var_387_9 then
				if arg_384_1.var_.characterEffect10093 then
					arg_384_1.var_.characterEffect10093.alpha = Mathf.Lerp(arg_384_1.var_.alphaOldValue10093, 1, (arg_384_1.time_ - 0) / var_387_9)
				end
			end

			if arg_384_1.time_ >= 0 + var_387_9 and arg_384_1.time_ < 0 + var_387_9 + arg_387_0 and arg_384_1.var_.characterEffect10093 then
				arg_384_1.var_.characterEffect10093.alpha = 1
			end

			local var_387_10 = arg_384_1.actors_["10092"].transform

			if 0 < arg_384_1.time_ and arg_384_1.time_ <= 0 + arg_387_0 then
				arg_384_1.var_.moveOldPos10092 = var_387_10.localPosition
				var_387_10.localScale = Vector3.New(1, 1, 1)

				arg_384_1:CheckSpriteTmpPos("10092", 4)

				for iter_387_9 = 0, var_387_10.childCount - 1 do
					local var_387_11 = var_387_10:GetChild(iter_387_9)

					if var_387_11.name == "" or not string.find(var_387_11.name, "split") then
						var_387_11.gameObject:SetActive(true)
					else
						var_387_11.gameObject:SetActive(false)
					end
				end
			end

			local var_387_12 = 0.001

			if 0 <= arg_384_1.time_ and arg_384_1.time_ < 0 + var_387_12 then
				var_387_10.localPosition = Vector3.Lerp(arg_384_1.var_.moveOldPos10092, Vector3.New(390, -300, -295), (arg_384_1.time_ - 0) / var_387_12)
			end

			if arg_384_1.time_ >= 0 + var_387_12 and arg_384_1.time_ < 0 + var_387_12 + arg_387_0 then
				var_387_10.localPosition = Vector3.New(390, -300, -295)
			end

			local var_387_13 = 0
			local var_387_14 = 0.45

			if 0 < arg_384_1.time_ and arg_384_1.time_ <= var_387_13 + arg_387_0 then
				arg_384_1.talkMaxDuration = 0
				arg_384_1.dialogCg_.alpha = 1

				arg_384_1.dialog_:SetActive(true)
				SetActive(arg_384_1.leftNameGo_, true)

				arg_384_1.leftNameTxt_.text = arg_384_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_384_1.leftNameTxt_.transform)

				arg_384_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_384_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_384_1:RecordName(arg_384_1.leftNameTxt_.text)
				SetActive(arg_384_1.iconTrs_.gameObject, false)
				arg_384_1.callingController_:SetSelectedState("normal")

				local var_387_15 = arg_384_1:GetWordFromCfg(413041094)
				local var_387_16 = arg_384_1:FormatText(var_387_15.content)

				arg_384_1.text_.text = var_387_16

				LuaForUtil.ClearLinePrefixSymbol(arg_384_1.text_)

				local var_387_18 = 18 <= 0 and var_387_14 or var_387_14 * (utf8.len(var_387_16) / 18)

				if (18 <= 0 and var_387_14 or var_387_14 * (utf8.len(var_387_16) / 18)) > 0 and var_387_14 < var_387_18 then
					arg_384_1.talkMaxDuration = var_387_18

					if var_387_18 + var_387_13 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_18 + var_387_13
					end
				end

				arg_384_1.text_.text = var_387_16
				arg_384_1.typewritter.percent = 0

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413041", "413041094", "story_v_out_413041.awb") ~= 0 then
					local var_387_19 = manager.audio:GetVoiceLength("story_v_out_413041", "413041094", "story_v_out_413041.awb") / 1000

					if var_387_19 + var_387_13 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_19 + var_387_13
					end

					if var_387_15.prefab_name ~= "" and arg_384_1.actors_[var_387_15.prefab_name] ~= nil then
						local var_387_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_384_1.actors_[var_387_15.prefab_name].transform, "story_v_out_413041", "413041094", "story_v_out_413041.awb")

						arg_384_1:RecordAudio("413041094", var_387_20)
						arg_384_1:RecordAudio("413041094", var_387_20)
					else
						arg_384_1:AudioAction("play", "voice", "story_v_out_413041", "413041094", "story_v_out_413041.awb")
					end

					arg_384_1:RecordHistoryTalkVoice("story_v_out_413041", "413041094", "story_v_out_413041.awb")
				end

				arg_384_1:RecordContent(arg_384_1.text_.text)
			end

			local var_387_21 = math.max(var_387_14, arg_384_1.talkMaxDuration)

			if var_387_13 <= arg_384_1.time_ and arg_384_1.time_ < var_387_13 + var_387_21 then
				arg_384_1.typewritter.percent = (arg_384_1.time_ - var_387_13) / var_387_21

				arg_384_1.typewritter:SetDirty()
			end

			if arg_384_1.time_ >= var_387_13 + var_387_21 and arg_384_1.time_ < var_387_13 + var_387_21 + arg_387_0 then
				arg_384_1.typewritter.percent = 1

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(true)
			end
		end

		arg_384_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_384_1:InitPlayNodeList()
	end,
	Play413041095 = function(arg_388_0, arg_388_1)
		arg_388_1.time_ = 0
		arg_388_1.frameCnt_ = 0
		arg_388_1.state_ = "playing"
		arg_388_1.curTalkId_ = 413041095
		arg_388_1.duration_ = 11.77

		local var_388_0 = {
			zh = 7.466,
			ja = 11.766
		}
		local var_388_1 = manager.audio:GetLocalizationFlag()

		if var_388_0[var_388_1] ~= nil then
			arg_388_1.duration_ = var_388_0[var_388_1]
		end

		SetActive(arg_388_1.tipsGo_, false)

		function arg_388_1.onSingleLineFinish_()
			arg_388_1.onSingleLineUpdate_ = nil
			arg_388_1.onSingleLineFinish_ = nil
			arg_388_1.state_ = "waiting"
		end

		function arg_388_1.playNext_(arg_390_0)
			if arg_390_0 == 1 then
				arg_388_0:Play413041096(arg_388_1)
			end
		end

		function arg_388_1.onSingleLineUpdate_(arg_391_0)
			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 then
				arg_388_1.var_.moveOldPos10092 = arg_388_1.actors_["10092"].transform.localPosition
				arg_388_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_388_1:CheckSpriteTmpPos("10092", 4)

				for iter_391_0 = 0, arg_388_1.actors_["10092"].transform.childCount - 1 do
					local var_391_0 = arg_388_1.actors_["10092"].transform:GetChild(iter_391_0)

					if var_391_0.name == "split_5" or not string.find(var_391_0.name, "split") then
						var_391_0.gameObject:SetActive(true)
					else
						var_391_0.gameObject:SetActive(false)
					end
				end
			end

			local var_391_1 = 0.001

			if 0 <= arg_388_1.time_ and arg_388_1.time_ < 0 + var_391_1 then
				arg_388_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_388_1.var_.moveOldPos10092, Vector3.New(390, -300, -295), (arg_388_1.time_ - 0) / var_391_1)
			end

			if arg_388_1.time_ >= 0 + var_391_1 and arg_388_1.time_ < 0 + var_391_1 + arg_391_0 then
				arg_388_1.actors_["10092"].transform.localPosition = Vector3.New(390, -300, -295)
			end

			local var_391_2 = arg_388_1.actors_["10092"]

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 and not isNil(var_391_2) and arg_388_1.var_.actorSpriteComps10092 == nil then
				arg_388_1.var_.actorSpriteComps10092 = var_391_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_391_3 = 2

			if 0 <= arg_388_1.time_ and arg_388_1.time_ < 0 + var_391_3 and not isNil(var_391_2) then
				if arg_388_1.var_.actorSpriteComps10092 then
					for iter_391_1, iter_391_2 in pairs(arg_388_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_391_2 then
							if arg_388_1.isInRecall_ then
								iter_391_2.color = Color.New(Mathf.Lerp(iter_391_2.color.r, arg_388_1.hightColor1.r, (arg_388_1.time_ - 0) / var_391_3), Mathf.Lerp(iter_391_2.color.g, arg_388_1.hightColor1.g, (arg_388_1.time_ - 0) / var_391_3), (Mathf.Lerp(iter_391_2.color.b, arg_388_1.hightColor1.b, (arg_388_1.time_ - 0) / var_391_3)))
							else
								local var_391_4 = Mathf.Lerp(iter_391_2.color.r, 1, (arg_388_1.time_ - 0) / var_391_3)

								iter_391_2.color = Color.New(var_391_4, var_391_4, var_391_4)
							end
						end
					end
				end
			end

			if arg_388_1.time_ >= 0 + var_391_3 and arg_388_1.time_ < 0 + var_391_3 + arg_391_0 and not isNil(var_391_2) and arg_388_1.var_.actorSpriteComps10092 then
				for iter_391_3, iter_391_4 in pairs(arg_388_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_391_4 then
						iter_391_4.color = arg_388_1.isInRecall_ and (arg_388_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_388_1.var_.actorSpriteComps10092 = nil
			end

			local var_391_5 = arg_388_1.actors_["10093"]

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 and not isNil(var_391_5) and arg_388_1.var_.actorSpriteComps10093 == nil then
				arg_388_1.var_.actorSpriteComps10093 = var_391_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_391_6 = 2

			if 0 <= arg_388_1.time_ and arg_388_1.time_ < 0 + var_391_6 and not isNil(var_391_5) then
				if arg_388_1.var_.actorSpriteComps10093 then
					for iter_391_5, iter_391_6 in pairs(arg_388_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_391_6 then
							if arg_388_1.isInRecall_ then
								iter_391_6.color = Color.New(Mathf.Lerp(iter_391_6.color.r, arg_388_1.hightColor2.r, (arg_388_1.time_ - 0) / var_391_6), Mathf.Lerp(iter_391_6.color.g, arg_388_1.hightColor2.g, (arg_388_1.time_ - 0) / var_391_6), (Mathf.Lerp(iter_391_6.color.b, arg_388_1.hightColor2.b, (arg_388_1.time_ - 0) / var_391_6)))
							else
								local var_391_7 = Mathf.Lerp(iter_391_6.color.r, 0.5, (arg_388_1.time_ - 0) / var_391_6)

								iter_391_6.color = Color.New(var_391_7, var_391_7, var_391_7)
							end
						end
					end
				end
			end

			if arg_388_1.time_ >= 0 + var_391_6 and arg_388_1.time_ < 0 + var_391_6 + arg_391_0 and not isNil(var_391_5) and arg_388_1.var_.actorSpriteComps10093 then
				for iter_391_7, iter_391_8 in pairs(arg_388_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_391_8 then
						iter_391_8.color = arg_388_1.isInRecall_ and (arg_388_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_388_1.var_.actorSpriteComps10093 = nil
			end

			local var_391_8 = 0
			local var_391_9 = 0.925

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= var_391_8 + arg_391_0 then
				arg_388_1.talkMaxDuration = 0
				arg_388_1.dialogCg_.alpha = 1

				arg_388_1.dialog_:SetActive(true)
				SetActive(arg_388_1.leftNameGo_, true)

				arg_388_1.leftNameTxt_.text = arg_388_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_388_1.leftNameTxt_.transform)

				arg_388_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_388_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_388_1:RecordName(arg_388_1.leftNameTxt_.text)
				SetActive(arg_388_1.iconTrs_.gameObject, false)
				arg_388_1.callingController_:SetSelectedState("normal")

				local var_391_10 = arg_388_1:GetWordFromCfg(413041095)
				local var_391_11 = arg_388_1:FormatText(var_391_10.content)

				arg_388_1.text_.text = var_391_11

				LuaForUtil.ClearLinePrefixSymbol(arg_388_1.text_)

				local var_391_13 = 37 <= 0 and var_391_9 or var_391_9 * (utf8.len(var_391_11) / 37)

				if (37 <= 0 and var_391_9 or var_391_9 * (utf8.len(var_391_11) / 37)) > 0 and var_391_9 < var_391_13 then
					arg_388_1.talkMaxDuration = var_391_13

					if var_391_13 + var_391_8 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_13 + var_391_8
					end
				end

				arg_388_1.text_.text = var_391_11
				arg_388_1.typewritter.percent = 0

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413041", "413041095", "story_v_out_413041.awb") ~= 0 then
					local var_391_14 = manager.audio:GetVoiceLength("story_v_out_413041", "413041095", "story_v_out_413041.awb") / 1000

					if var_391_14 + var_391_8 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_14 + var_391_8
					end

					if var_391_10.prefab_name ~= "" and arg_388_1.actors_[var_391_10.prefab_name] ~= nil then
						local var_391_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_388_1.actors_[var_391_10.prefab_name].transform, "story_v_out_413041", "413041095", "story_v_out_413041.awb")

						arg_388_1:RecordAudio("413041095", var_391_15)
						arg_388_1:RecordAudio("413041095", var_391_15)
					else
						arg_388_1:AudioAction("play", "voice", "story_v_out_413041", "413041095", "story_v_out_413041.awb")
					end

					arg_388_1:RecordHistoryTalkVoice("story_v_out_413041", "413041095", "story_v_out_413041.awb")
				end

				arg_388_1:RecordContent(arg_388_1.text_.text)
			end

			local var_391_16 = math.max(var_391_9, arg_388_1.talkMaxDuration)

			if var_391_8 <= arg_388_1.time_ and arg_388_1.time_ < var_391_8 + var_391_16 then
				arg_388_1.typewritter.percent = (arg_388_1.time_ - var_391_8) / var_391_16

				arg_388_1.typewritter:SetDirty()
			end

			if arg_388_1.time_ >= var_391_8 + var_391_16 and arg_388_1.time_ < var_391_8 + var_391_16 + arg_391_0 then
				arg_388_1.typewritter.percent = 1

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(true)
			end
		end

		arg_388_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_388_1:InitPlayNodeList()
	end,
	Play413041096 = function(arg_392_0, arg_392_1)
		arg_392_1.time_ = 0
		arg_392_1.frameCnt_ = 0
		arg_392_1.state_ = "playing"
		arg_392_1.curTalkId_ = 413041096
		arg_392_1.duration_ = 2.03

		local var_392_0 = {
			zh = 1.999999999999,
			ja = 2.033
		}
		local var_392_1 = manager.audio:GetLocalizationFlag()

		if var_392_0[var_392_1] ~= nil then
			arg_392_1.duration_ = var_392_0[var_392_1]
		end

		SetActive(arg_392_1.tipsGo_, false)

		function arg_392_1.onSingleLineFinish_()
			arg_392_1.onSingleLineUpdate_ = nil
			arg_392_1.onSingleLineFinish_ = nil
			arg_392_1.state_ = "waiting"
		end

		function arg_392_1.playNext_(arg_394_0)
			if arg_394_0 == 1 then
				arg_392_0:Play413041097(arg_392_1)
			end
		end

		function arg_392_1.onSingleLineUpdate_(arg_395_0)
			if 0 < arg_392_1.time_ and arg_392_1.time_ <= 0 + arg_395_0 and not isNil(arg_392_1.actors_["10093"]) and arg_392_1.var_.actorSpriteComps10093 == nil then
				arg_392_1.var_.actorSpriteComps10093 = arg_392_1.actors_["10093"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_395_0 = 2

			if 0 <= arg_392_1.time_ and arg_392_1.time_ < 0 + var_395_0 and not isNil(arg_392_1.actors_["10093"]) then
				if arg_392_1.var_.actorSpriteComps10093 then
					for iter_395_0, iter_395_1 in pairs(arg_392_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_395_1 then
							if arg_392_1.isInRecall_ then
								iter_395_1.color = Color.New(Mathf.Lerp(iter_395_1.color.r, arg_392_1.hightColor1.r, (arg_392_1.time_ - 0) / var_395_0), Mathf.Lerp(iter_395_1.color.g, arg_392_1.hightColor1.g, (arg_392_1.time_ - 0) / var_395_0), (Mathf.Lerp(iter_395_1.color.b, arg_392_1.hightColor1.b, (arg_392_1.time_ - 0) / var_395_0)))
							else
								local var_395_1 = Mathf.Lerp(iter_395_1.color.r, 1, (arg_392_1.time_ - 0) / var_395_0)

								iter_395_1.color = Color.New(var_395_1, var_395_1, var_395_1)
							end
						end
					end
				end
			end

			if arg_392_1.time_ >= 0 + var_395_0 and arg_392_1.time_ < 0 + var_395_0 + arg_395_0 and not isNil(arg_392_1.actors_["10093"]) and arg_392_1.var_.actorSpriteComps10093 then
				for iter_395_2, iter_395_3 in pairs(arg_392_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_395_3 then
						iter_395_3.color = arg_392_1.isInRecall_ and (arg_392_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_392_1.var_.actorSpriteComps10093 = nil
			end

			local var_395_2 = arg_392_1.actors_["10092"]

			if 0 < arg_392_1.time_ and arg_392_1.time_ <= 0 + arg_395_0 and not isNil(var_395_2) and arg_392_1.var_.actorSpriteComps10092 == nil then
				arg_392_1.var_.actorSpriteComps10092 = var_395_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_395_3 = 2

			if 0 <= arg_392_1.time_ and arg_392_1.time_ < 0 + var_395_3 and not isNil(var_395_2) then
				if arg_392_1.var_.actorSpriteComps10092 then
					for iter_395_4, iter_395_5 in pairs(arg_392_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_395_5 then
							if arg_392_1.isInRecall_ then
								iter_395_5.color = Color.New(Mathf.Lerp(iter_395_5.color.r, arg_392_1.hightColor2.r, (arg_392_1.time_ - 0) / var_395_3), Mathf.Lerp(iter_395_5.color.g, arg_392_1.hightColor2.g, (arg_392_1.time_ - 0) / var_395_3), (Mathf.Lerp(iter_395_5.color.b, arg_392_1.hightColor2.b, (arg_392_1.time_ - 0) / var_395_3)))
							else
								local var_395_4 = Mathf.Lerp(iter_395_5.color.r, 0.5, (arg_392_1.time_ - 0) / var_395_3)

								iter_395_5.color = Color.New(var_395_4, var_395_4, var_395_4)
							end
						end
					end
				end
			end

			if arg_392_1.time_ >= 0 + var_395_3 and arg_392_1.time_ < 0 + var_395_3 + arg_395_0 and not isNil(var_395_2) and arg_392_1.var_.actorSpriteComps10092 then
				for iter_395_6, iter_395_7 in pairs(arg_392_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_395_7 then
						iter_395_7.color = arg_392_1.isInRecall_ and (arg_392_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_392_1.var_.actorSpriteComps10092 = nil
			end

			local var_395_5 = 0
			local var_395_6 = 0.175

			if 0 < arg_392_1.time_ and arg_392_1.time_ <= var_395_5 + arg_395_0 then
				arg_392_1.talkMaxDuration = 0
				arg_392_1.dialogCg_.alpha = 1

				arg_392_1.dialog_:SetActive(true)
				SetActive(arg_392_1.leftNameGo_, true)

				arg_392_1.leftNameTxt_.text = arg_392_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_392_1.leftNameTxt_.transform)

				arg_392_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_392_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_392_1:RecordName(arg_392_1.leftNameTxt_.text)
				SetActive(arg_392_1.iconTrs_.gameObject, false)
				arg_392_1.callingController_:SetSelectedState("normal")

				local var_395_7 = arg_392_1:GetWordFromCfg(413041096)
				local var_395_8 = arg_392_1:FormatText(var_395_7.content)

				arg_392_1.text_.text = var_395_8

				LuaForUtil.ClearLinePrefixSymbol(arg_392_1.text_)

				local var_395_10 = 7 <= 0 and var_395_6 or var_395_6 * (utf8.len(var_395_8) / 7)

				if (7 <= 0 and var_395_6 or var_395_6 * (utf8.len(var_395_8) / 7)) > 0 and var_395_6 < var_395_10 then
					arg_392_1.talkMaxDuration = var_395_10

					if var_395_10 + var_395_5 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_10 + var_395_5
					end
				end

				arg_392_1.text_.text = var_395_8
				arg_392_1.typewritter.percent = 0

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413041", "413041096", "story_v_out_413041.awb") ~= 0 then
					local var_395_11 = manager.audio:GetVoiceLength("story_v_out_413041", "413041096", "story_v_out_413041.awb") / 1000

					if var_395_11 + var_395_5 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_11 + var_395_5
					end

					if var_395_7.prefab_name ~= "" and arg_392_1.actors_[var_395_7.prefab_name] ~= nil then
						local var_395_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_392_1.actors_[var_395_7.prefab_name].transform, "story_v_out_413041", "413041096", "story_v_out_413041.awb")

						arg_392_1:RecordAudio("413041096", var_395_12)
						arg_392_1:RecordAudio("413041096", var_395_12)
					else
						arg_392_1:AudioAction("play", "voice", "story_v_out_413041", "413041096", "story_v_out_413041.awb")
					end

					arg_392_1:RecordHistoryTalkVoice("story_v_out_413041", "413041096", "story_v_out_413041.awb")
				end

				arg_392_1:RecordContent(arg_392_1.text_.text)
			end

			local var_395_13 = math.max(var_395_6, arg_392_1.talkMaxDuration)

			if var_395_5 <= arg_392_1.time_ and arg_392_1.time_ < var_395_5 + var_395_13 then
				arg_392_1.typewritter.percent = (arg_392_1.time_ - var_395_5) / var_395_13

				arg_392_1.typewritter:SetDirty()
			end

			if arg_392_1.time_ >= var_395_5 + var_395_13 and arg_392_1.time_ < var_395_5 + var_395_13 + arg_395_0 then
				arg_392_1.typewritter.percent = 1

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(true)
			end
		end

		arg_392_1.nodeConfigList_ = {}

		arg_392_1:InitPlayNodeList()
	end,
	Play413041097 = function(arg_396_0, arg_396_1)
		arg_396_1.time_ = 0
		arg_396_1.frameCnt_ = 0
		arg_396_1.state_ = "playing"
		arg_396_1.curTalkId_ = 413041097
		arg_396_1.duration_ = 5

		SetActive(arg_396_1.tipsGo_, false)

		function arg_396_1.onSingleLineFinish_()
			arg_396_1.onSingleLineUpdate_ = nil
			arg_396_1.onSingleLineFinish_ = nil
			arg_396_1.state_ = "waiting"
		end

		function arg_396_1.playNext_(arg_398_0)
			if arg_398_0 == 1 then
				arg_396_0:Play413041098(arg_396_1)
			end
		end

		function arg_396_1.onSingleLineUpdate_(arg_399_0)
			if 0.2 < arg_396_1.time_ and arg_396_1.time_ <= 0.2 + arg_399_0 then
				arg_396_1.var_.moveOldPos10092 = arg_396_1.actors_["10092"].transform.localPosition
				arg_396_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_396_1:CheckSpriteTmpPos("10092", 7)

				for iter_399_0 = 0, arg_396_1.actors_["10092"].transform.childCount - 1 do
					local var_399_0 = arg_396_1.actors_["10092"].transform:GetChild(iter_399_0)

					if var_399_0.name == "" or not string.find(var_399_0.name, "split") then
						var_399_0.gameObject:SetActive(true)
					else
						var_399_0.gameObject:SetActive(false)
					end
				end
			end

			local var_399_1 = 0.001

			if 0.2 <= arg_396_1.time_ and arg_396_1.time_ < 0.2 + var_399_1 then
				arg_396_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_396_1.var_.moveOldPos10092, Vector3.New(0, -2000, 0), (arg_396_1.time_ - 0.2) / var_399_1)
			end

			if arg_396_1.time_ >= 0.2 + var_399_1 and arg_396_1.time_ < 0.2 + var_399_1 + arg_399_0 then
				arg_396_1.actors_["10092"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_399_2 = arg_396_1.actors_["10093"]

			if 0 < arg_396_1.time_ and arg_396_1.time_ <= 0 + arg_399_0 and not isNil(var_399_2) and arg_396_1.var_.actorSpriteComps10093 == nil then
				arg_396_1.var_.actorSpriteComps10093 = var_399_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_399_3 = 2

			if 0 <= arg_396_1.time_ and arg_396_1.time_ < 0 + var_399_3 and not isNil(var_399_2) then
				if arg_396_1.var_.actorSpriteComps10093 then
					for iter_399_1, iter_399_2 in pairs(arg_396_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_399_2 then
							if arg_396_1.isInRecall_ then
								iter_399_2.color = Color.New(Mathf.Lerp(iter_399_2.color.r, arg_396_1.hightColor2.r, (arg_396_1.time_ - 0) / var_399_3), Mathf.Lerp(iter_399_2.color.g, arg_396_1.hightColor2.g, (arg_396_1.time_ - 0) / var_399_3), (Mathf.Lerp(iter_399_2.color.b, arg_396_1.hightColor2.b, (arg_396_1.time_ - 0) / var_399_3)))
							else
								local var_399_4 = Mathf.Lerp(iter_399_2.color.r, 0.5, (arg_396_1.time_ - 0) / var_399_3)

								iter_399_2.color = Color.New(var_399_4, var_399_4, var_399_4)
							end
						end
					end
				end
			end

			if arg_396_1.time_ >= 0 + var_399_3 and arg_396_1.time_ < 0 + var_399_3 + arg_399_0 and not isNil(var_399_2) and arg_396_1.var_.actorSpriteComps10093 then
				for iter_399_3, iter_399_4 in pairs(arg_396_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_399_4 then
						iter_399_4.color = arg_396_1.isInRecall_ and (arg_396_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_396_1.var_.actorSpriteComps10093 = nil
			end

			local var_399_5 = arg_396_1.actors_["10093"].transform

			if 0.5 < arg_396_1.time_ and arg_396_1.time_ <= 0.5 + arg_399_0 then
				arg_396_1.var_.moveOldPos10093 = var_399_5.localPosition
				var_399_5.localScale = Vector3.New(1, 1, 1)

				arg_396_1:CheckSpriteTmpPos("10093", 7)

				for iter_399_5 = 0, var_399_5.childCount - 1 do
					local var_399_6 = var_399_5:GetChild(iter_399_5)

					if var_399_6.name == "" or not string.find(var_399_6.name, "split") then
						var_399_6.gameObject:SetActive(true)
					else
						var_399_6.gameObject:SetActive(false)
					end
				end
			end

			local var_399_7 = 0.001

			if 0.5 <= arg_396_1.time_ and arg_396_1.time_ < 0.5 + var_399_7 then
				var_399_5.localPosition = Vector3.Lerp(arg_396_1.var_.moveOldPos10093, Vector3.New(0, -2000, -180), (arg_396_1.time_ - 0.5) / var_399_7)
			end

			if arg_396_1.time_ >= 0.5 + var_399_7 and arg_396_1.time_ < 0.5 + var_399_7 + arg_399_0 then
				var_399_5.localPosition = Vector3.New(0, -2000, -180)
			end

			if 0 < arg_396_1.time_ and arg_396_1.time_ <= 0 + arg_399_0 then
				local var_399_8 = arg_396_1.actors_["10092"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_399_8 then
					arg_396_1.var_.alphaOldValue10092 = var_399_8.alpha
					arg_396_1.var_.characterEffect10092 = var_399_8
				end

				arg_396_1.var_.alphaOldValue10092 = 1
			end

			local var_399_9 = 0.2

			if 0 <= arg_396_1.time_ and arg_396_1.time_ < 0 + var_399_9 then
				if arg_396_1.var_.characterEffect10092 then
					arg_396_1.var_.characterEffect10092.alpha = Mathf.Lerp(arg_396_1.var_.alphaOldValue10092, 0, (arg_396_1.time_ - 0) / var_399_9)
				end
			end

			if arg_396_1.time_ >= 0 + var_399_9 and arg_396_1.time_ < 0 + var_399_9 + arg_399_0 and arg_396_1.var_.characterEffect10092 then
				arg_396_1.var_.characterEffect10092.alpha = 0
			end

			if 0 < arg_396_1.time_ and arg_396_1.time_ <= 0 + arg_399_0 then
				local var_399_10 = arg_396_1.actors_["10093"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_399_10 then
					arg_396_1.var_.alphaOldValue10093 = var_399_10.alpha
					arg_396_1.var_.characterEffect10093 = var_399_10
				end

				arg_396_1.var_.alphaOldValue10093 = 1
			end

			local var_399_11 = 0.5

			if 0 <= arg_396_1.time_ and arg_396_1.time_ < 0 + var_399_11 then
				if arg_396_1.var_.characterEffect10093 then
					arg_396_1.var_.characterEffect10093.alpha = Mathf.Lerp(arg_396_1.var_.alphaOldValue10093, 0, (arg_396_1.time_ - 0) / var_399_11)
				end
			end

			if arg_396_1.time_ >= 0 + var_399_11 and arg_396_1.time_ < 0 + var_399_11 + arg_399_0 and arg_396_1.var_.characterEffect10093 then
				arg_396_1.var_.characterEffect10093.alpha = 0
			end

			local var_399_12 = 0
			local var_399_13 = 0.9

			if 0 < arg_396_1.time_ and arg_396_1.time_ <= var_399_12 + arg_399_0 then
				arg_396_1.talkMaxDuration = 0
				arg_396_1.dialogCg_.alpha = 1

				arg_396_1.dialog_:SetActive(true)
				SetActive(arg_396_1.leftNameGo_, false)

				arg_396_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_396_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_396_1:RecordName(arg_396_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_396_1.iconTrs_.gameObject, false)
				arg_396_1.callingController_:SetSelectedState("normal")

				local var_399_14 = arg_396_1:FormatText(arg_396_1:GetWordFromCfg(413041097).content)

				arg_396_1.text_.text = var_399_14

				LuaForUtil.ClearLinePrefixSymbol(arg_396_1.text_)

				local var_399_16 = 36 <= 0 and var_399_13 or var_399_13 * (utf8.len(var_399_14) / 36)

				if (36 <= 0 and var_399_13 or var_399_13 * (utf8.len(var_399_14) / 36)) > 0 and var_399_13 < var_399_16 then
					arg_396_1.talkMaxDuration = var_399_16

					if var_399_16 + var_399_12 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_16 + var_399_12
					end
				end

				arg_396_1.text_.text = var_399_14
				arg_396_1.typewritter.percent = 0

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(false)
				arg_396_1:RecordContent(arg_396_1.text_.text)
			end

			local var_399_17 = math.max(var_399_13, arg_396_1.talkMaxDuration)

			if var_399_12 <= arg_396_1.time_ and arg_396_1.time_ < var_399_12 + var_399_17 then
				arg_396_1.typewritter.percent = (arg_396_1.time_ - var_399_12) / var_399_17

				arg_396_1.typewritter:SetDirty()
			end

			if arg_396_1.time_ >= var_399_12 + var_399_17 and arg_396_1.time_ < var_399_12 + var_399_17 + arg_399_0 then
				arg_396_1.typewritter.percent = 1

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(true)
			end
		end

		arg_396_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_396_1:InitPlayNodeList()
	end,
	Play413041098 = function(arg_400_0, arg_400_1)
		arg_400_1.time_ = 0
		arg_400_1.frameCnt_ = 0
		arg_400_1.state_ = "playing"
		arg_400_1.curTalkId_ = 413041098
		arg_400_1.duration_ = 9.9

		local var_400_0 = {
			zh = 7.033,
			ja = 9.9
		}
		local var_400_1 = manager.audio:GetLocalizationFlag()

		if var_400_0[var_400_1] ~= nil then
			arg_400_1.duration_ = var_400_0[var_400_1]
		end

		SetActive(arg_400_1.tipsGo_, false)

		function arg_400_1.onSingleLineFinish_()
			arg_400_1.onSingleLineUpdate_ = nil
			arg_400_1.onSingleLineFinish_ = nil
			arg_400_1.state_ = "waiting"
		end

		function arg_400_1.playNext_(arg_402_0)
			if arg_402_0 == 1 then
				arg_400_0:Play413041099(arg_400_1)
			end
		end

		function arg_400_1.onSingleLineUpdate_(arg_403_0)
			if 0 < arg_400_1.time_ and arg_400_1.time_ <= 0 + arg_403_0 then
				arg_400_1.var_.moveOldPos10022 = arg_400_1.actors_["10022"].transform.localPosition
				arg_400_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_400_1:CheckSpriteTmpPos("10022", 3)

				for iter_403_0 = 0, arg_400_1.actors_["10022"].transform.childCount - 1 do
					local var_403_0 = arg_400_1.actors_["10022"].transform:GetChild(iter_403_0)

					if var_403_0.name == "" or not string.find(var_403_0.name, "split") then
						var_403_0.gameObject:SetActive(true)
					else
						var_403_0.gameObject:SetActive(false)
					end
				end
			end

			local var_403_1 = 0.001

			if 0 <= arg_400_1.time_ and arg_400_1.time_ < 0 + var_403_1 then
				arg_400_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_400_1.var_.moveOldPos10022, Vector3.New(0, -315, -320), (arg_400_1.time_ - 0) / var_403_1)
			end

			if arg_400_1.time_ >= 0 + var_403_1 and arg_400_1.time_ < 0 + var_403_1 + arg_403_0 then
				arg_400_1.actors_["10022"].transform.localPosition = Vector3.New(0, -315, -320)
			end

			local var_403_2 = arg_400_1.actors_["10022"]

			if 0 < arg_400_1.time_ and arg_400_1.time_ <= 0 + arg_403_0 and not isNil(var_403_2) and arg_400_1.var_.actorSpriteComps10022 == nil then
				arg_400_1.var_.actorSpriteComps10022 = var_403_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_403_3 = 2

			if 0 <= arg_400_1.time_ and arg_400_1.time_ < 0 + var_403_3 and not isNil(var_403_2) then
				if arg_400_1.var_.actorSpriteComps10022 then
					for iter_403_1, iter_403_2 in pairs(arg_400_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_403_2 then
							if arg_400_1.isInRecall_ then
								iter_403_2.color = Color.New(Mathf.Lerp(iter_403_2.color.r, arg_400_1.hightColor1.r, (arg_400_1.time_ - 0) / var_403_3), Mathf.Lerp(iter_403_2.color.g, arg_400_1.hightColor1.g, (arg_400_1.time_ - 0) / var_403_3), (Mathf.Lerp(iter_403_2.color.b, arg_400_1.hightColor1.b, (arg_400_1.time_ - 0) / var_403_3)))
							else
								local var_403_4 = Mathf.Lerp(iter_403_2.color.r, 1, (arg_400_1.time_ - 0) / var_403_3)

								iter_403_2.color = Color.New(var_403_4, var_403_4, var_403_4)
							end
						end
					end
				end
			end

			if arg_400_1.time_ >= 0 + var_403_3 and arg_400_1.time_ < 0 + var_403_3 + arg_403_0 and not isNil(var_403_2) and arg_400_1.var_.actorSpriteComps10022 then
				for iter_403_3, iter_403_4 in pairs(arg_400_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_403_4 then
						iter_403_4.color = arg_400_1.isInRecall_ and (arg_400_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_400_1.var_.actorSpriteComps10022 = nil
			end

			local var_403_5 = 0
			local var_403_6 = 0.75

			if 0 < arg_400_1.time_ and arg_400_1.time_ <= var_403_5 + arg_403_0 then
				arg_400_1.talkMaxDuration = 0
				arg_400_1.dialogCg_.alpha = 1

				arg_400_1.dialog_:SetActive(true)
				SetActive(arg_400_1.leftNameGo_, true)

				arg_400_1.leftNameTxt_.text = arg_400_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_400_1.leftNameTxt_.transform)

				arg_400_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_400_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_400_1:RecordName(arg_400_1.leftNameTxt_.text)
				SetActive(arg_400_1.iconTrs_.gameObject, false)
				arg_400_1.callingController_:SetSelectedState("normal")

				local var_403_7 = arg_400_1:GetWordFromCfg(413041098)
				local var_403_8 = arg_400_1:FormatText(var_403_7.content)

				arg_400_1.text_.text = var_403_8

				LuaForUtil.ClearLinePrefixSymbol(arg_400_1.text_)

				local var_403_10 = 30 <= 0 and var_403_6 or var_403_6 * (utf8.len(var_403_8) / 30)

				if (30 <= 0 and var_403_6 or var_403_6 * (utf8.len(var_403_8) / 30)) > 0 and var_403_6 < var_403_10 then
					arg_400_1.talkMaxDuration = var_403_10

					if var_403_10 + var_403_5 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_10 + var_403_5
					end
				end

				arg_400_1.text_.text = var_403_8
				arg_400_1.typewritter.percent = 0

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413041", "413041098", "story_v_out_413041.awb") ~= 0 then
					local var_403_11 = manager.audio:GetVoiceLength("story_v_out_413041", "413041098", "story_v_out_413041.awb") / 1000

					if var_403_11 + var_403_5 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_11 + var_403_5
					end

					if var_403_7.prefab_name ~= "" and arg_400_1.actors_[var_403_7.prefab_name] ~= nil then
						local var_403_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_400_1.actors_[var_403_7.prefab_name].transform, "story_v_out_413041", "413041098", "story_v_out_413041.awb")

						arg_400_1:RecordAudio("413041098", var_403_12)
						arg_400_1:RecordAudio("413041098", var_403_12)
					else
						arg_400_1:AudioAction("play", "voice", "story_v_out_413041", "413041098", "story_v_out_413041.awb")
					end

					arg_400_1:RecordHistoryTalkVoice("story_v_out_413041", "413041098", "story_v_out_413041.awb")
				end

				arg_400_1:RecordContent(arg_400_1.text_.text)
			end

			local var_403_13 = math.max(var_403_6, arg_400_1.talkMaxDuration)

			if var_403_5 <= arg_400_1.time_ and arg_400_1.time_ < var_403_5 + var_403_13 then
				arg_400_1.typewritter.percent = (arg_400_1.time_ - var_403_5) / var_403_13

				arg_400_1.typewritter:SetDirty()
			end

			if arg_400_1.time_ >= var_403_5 + var_403_13 and arg_400_1.time_ < var_403_5 + var_403_13 + arg_403_0 then
				arg_400_1.typewritter.percent = 1

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(true)
			end
		end

		arg_400_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_400_1:InitPlayNodeList()
	end,
	Play413041099 = function(arg_404_0, arg_404_1)
		arg_404_1.time_ = 0
		arg_404_1.frameCnt_ = 0
		arg_404_1.state_ = "playing"
		arg_404_1.curTalkId_ = 413041099
		arg_404_1.duration_ = 3.9

		local var_404_0 = {
			zh = 1.866,
			ja = 3.9
		}
		local var_404_1 = manager.audio:GetLocalizationFlag()

		if var_404_0[var_404_1] ~= nil then
			arg_404_1.duration_ = var_404_0[var_404_1]
		end

		SetActive(arg_404_1.tipsGo_, false)

		function arg_404_1.onSingleLineFinish_()
			arg_404_1.onSingleLineUpdate_ = nil
			arg_404_1.onSingleLineFinish_ = nil
			arg_404_1.state_ = "waiting"
		end

		function arg_404_1.playNext_(arg_406_0)
			if arg_406_0 == 1 then
				arg_404_0:Play413041100(arg_404_1)
			end
		end

		function arg_404_1.onSingleLineUpdate_(arg_407_0)
			local var_407_0 = 0.275

			if 0 < arg_404_1.time_ and arg_404_1.time_ <= 0 + arg_407_0 then
				arg_404_1.talkMaxDuration = 0
				arg_404_1.dialogCg_.alpha = 1

				arg_404_1.dialog_:SetActive(true)
				SetActive(arg_404_1.leftNameGo_, true)

				arg_404_1.leftNameTxt_.text = arg_404_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_404_1.leftNameTxt_.transform)

				arg_404_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_404_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_404_1:RecordName(arg_404_1.leftNameTxt_.text)
				SetActive(arg_404_1.iconTrs_.gameObject, false)
				arg_404_1.callingController_:SetSelectedState("normal")

				local var_407_1 = arg_404_1:GetWordFromCfg(413041099)
				local var_407_2 = arg_404_1:FormatText(var_407_1.content)

				arg_404_1.text_.text = var_407_2

				LuaForUtil.ClearLinePrefixSymbol(arg_404_1.text_)

				local var_407_4 = 11 <= 0 and var_407_0 or var_407_0 * (utf8.len(var_407_2) / 11)

				if (11 <= 0 and var_407_0 or var_407_0 * (utf8.len(var_407_2) / 11)) > 0 and var_407_0 < var_407_4 then
					arg_404_1.talkMaxDuration = var_407_4

					if var_407_4 + 0 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_4 + 0
					end
				end

				arg_404_1.text_.text = var_407_2
				arg_404_1.typewritter.percent = 0

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413041", "413041099", "story_v_out_413041.awb") ~= 0 then
					local var_407_5 = manager.audio:GetVoiceLength("story_v_out_413041", "413041099", "story_v_out_413041.awb") / 1000

					if var_407_5 + 0 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_5 + 0
					end

					if var_407_1.prefab_name ~= "" and arg_404_1.actors_[var_407_1.prefab_name] ~= nil then
						local var_407_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_404_1.actors_[var_407_1.prefab_name].transform, "story_v_out_413041", "413041099", "story_v_out_413041.awb")

						arg_404_1:RecordAudio("413041099", var_407_6)
						arg_404_1:RecordAudio("413041099", var_407_6)
					else
						arg_404_1:AudioAction("play", "voice", "story_v_out_413041", "413041099", "story_v_out_413041.awb")
					end

					arg_404_1:RecordHistoryTalkVoice("story_v_out_413041", "413041099", "story_v_out_413041.awb")
				end

				arg_404_1:RecordContent(arg_404_1.text_.text)
			end

			local var_407_7 = math.max(var_407_0, arg_404_1.talkMaxDuration)

			if 0 <= arg_404_1.time_ and arg_404_1.time_ < 0 + var_407_7 then
				arg_404_1.typewritter.percent = (arg_404_1.time_ - 0) / var_407_7

				arg_404_1.typewritter:SetDirty()
			end

			if arg_404_1.time_ >= 0 + var_407_7 and arg_404_1.time_ < 0 + var_407_7 + arg_407_0 then
				arg_404_1.typewritter.percent = 1

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(true)
			end
		end

		arg_404_1.nodeConfigList_ = {}

		arg_404_1:InitPlayNodeList()
	end,
	Play413041100 = function(arg_408_0, arg_408_1)
		arg_408_1.time_ = 0
		arg_408_1.frameCnt_ = 0
		arg_408_1.state_ = "playing"
		arg_408_1.curTalkId_ = 413041100
		arg_408_1.duration_ = 3.67

		local var_408_0 = {
			zh = 3.666,
			ja = 3.566
		}
		local var_408_1 = manager.audio:GetLocalizationFlag()

		if var_408_0[var_408_1] ~= nil then
			arg_408_1.duration_ = var_408_0[var_408_1]
		end

		SetActive(arg_408_1.tipsGo_, false)

		function arg_408_1.onSingleLineFinish_()
			arg_408_1.onSingleLineUpdate_ = nil
			arg_408_1.onSingleLineFinish_ = nil
			arg_408_1.state_ = "waiting"
		end

		function arg_408_1.playNext_(arg_410_0)
			if arg_410_0 == 1 then
				arg_408_0:Play413041101(arg_408_1)
			end
		end

		function arg_408_1.onSingleLineUpdate_(arg_411_0)
			if 0 < arg_408_1.time_ and arg_408_1.time_ <= 0 + arg_411_0 then
				arg_408_1.var_.moveOldPos10094 = arg_408_1.actors_["10094"].transform.localPosition
				arg_408_1.actors_["10094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_408_1:CheckSpriteTmpPos("10094", 4)

				for iter_411_0 = 0, arg_408_1.actors_["10094"].transform.childCount - 1 do
					local var_411_0 = arg_408_1.actors_["10094"].transform:GetChild(iter_411_0)

					if var_411_0.name == "split_1" or not string.find(var_411_0.name, "split") then
						var_411_0.gameObject:SetActive(true)
					else
						var_411_0.gameObject:SetActive(false)
					end
				end
			end

			local var_411_1 = 0.001

			if 0 <= arg_408_1.time_ and arg_408_1.time_ < 0 + var_411_1 then
				arg_408_1.actors_["10094"].transform.localPosition = Vector3.Lerp(arg_408_1.var_.moveOldPos10094, Vector3.New(390, -340, -414), (arg_408_1.time_ - 0) / var_411_1)
			end

			if arg_408_1.time_ >= 0 + var_411_1 and arg_408_1.time_ < 0 + var_411_1 + arg_411_0 then
				arg_408_1.actors_["10094"].transform.localPosition = Vector3.New(390, -340, -414)
			end

			local var_411_2 = arg_408_1.actors_["10022"].transform

			if 0 < arg_408_1.time_ and arg_408_1.time_ <= 0 + arg_411_0 then
				arg_408_1.var_.moveOldPos10022 = var_411_2.localPosition
				var_411_2.localScale = Vector3.New(1, 1, 1)

				arg_408_1:CheckSpriteTmpPos("10022", 2)

				for iter_411_1 = 0, var_411_2.childCount - 1 do
					local var_411_3 = var_411_2:GetChild(iter_411_1)

					if var_411_3.name == "" or not string.find(var_411_3.name, "split") then
						var_411_3.gameObject:SetActive(true)
					else
						var_411_3.gameObject:SetActive(false)
					end
				end
			end

			local var_411_4 = 0.001

			if 0 <= arg_408_1.time_ and arg_408_1.time_ < 0 + var_411_4 then
				var_411_2.localPosition = Vector3.Lerp(arg_408_1.var_.moveOldPos10022, Vector3.New(-390, -315, -320), (arg_408_1.time_ - 0) / var_411_4)
			end

			if arg_408_1.time_ >= 0 + var_411_4 and arg_408_1.time_ < 0 + var_411_4 + arg_411_0 then
				var_411_2.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_411_5 = arg_408_1.actors_["10094"]

			if 0 < arg_408_1.time_ and arg_408_1.time_ <= 0 + arg_411_0 and not isNil(var_411_5) and arg_408_1.var_.actorSpriteComps10094 == nil then
				arg_408_1.var_.actorSpriteComps10094 = var_411_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_411_6 = 2

			if 0 <= arg_408_1.time_ and arg_408_1.time_ < 0 + var_411_6 and not isNil(var_411_5) then
				if arg_408_1.var_.actorSpriteComps10094 then
					for iter_411_2, iter_411_3 in pairs(arg_408_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_411_3 then
							if arg_408_1.isInRecall_ then
								iter_411_3.color = Color.New(Mathf.Lerp(iter_411_3.color.r, arg_408_1.hightColor1.r, (arg_408_1.time_ - 0) / var_411_6), Mathf.Lerp(iter_411_3.color.g, arg_408_1.hightColor1.g, (arg_408_1.time_ - 0) / var_411_6), (Mathf.Lerp(iter_411_3.color.b, arg_408_1.hightColor1.b, (arg_408_1.time_ - 0) / var_411_6)))
							else
								local var_411_7 = Mathf.Lerp(iter_411_3.color.r, 1, (arg_408_1.time_ - 0) / var_411_6)

								iter_411_3.color = Color.New(var_411_7, var_411_7, var_411_7)
							end
						end
					end
				end
			end

			if arg_408_1.time_ >= 0 + var_411_6 and arg_408_1.time_ < 0 + var_411_6 + arg_411_0 and not isNil(var_411_5) and arg_408_1.var_.actorSpriteComps10094 then
				for iter_411_4, iter_411_5 in pairs(arg_408_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_411_5 then
						iter_411_5.color = arg_408_1.isInRecall_ and (arg_408_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_408_1.var_.actorSpriteComps10094 = nil
			end

			local var_411_8 = arg_408_1.actors_["10022"]

			if 0 < arg_408_1.time_ and arg_408_1.time_ <= 0 + arg_411_0 and not isNil(var_411_8) and arg_408_1.var_.actorSpriteComps10022 == nil then
				arg_408_1.var_.actorSpriteComps10022 = var_411_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_411_9 = 2

			if 0 <= arg_408_1.time_ and arg_408_1.time_ < 0 + var_411_9 and not isNil(var_411_8) then
				if arg_408_1.var_.actorSpriteComps10022 then
					for iter_411_6, iter_411_7 in pairs(arg_408_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_411_7 then
							if arg_408_1.isInRecall_ then
								iter_411_7.color = Color.New(Mathf.Lerp(iter_411_7.color.r, arg_408_1.hightColor2.r, (arg_408_1.time_ - 0) / var_411_9), Mathf.Lerp(iter_411_7.color.g, arg_408_1.hightColor2.g, (arg_408_1.time_ - 0) / var_411_9), (Mathf.Lerp(iter_411_7.color.b, arg_408_1.hightColor2.b, (arg_408_1.time_ - 0) / var_411_9)))
							else
								local var_411_10 = Mathf.Lerp(iter_411_7.color.r, 0.5, (arg_408_1.time_ - 0) / var_411_9)

								iter_411_7.color = Color.New(var_411_10, var_411_10, var_411_10)
							end
						end
					end
				end
			end

			if arg_408_1.time_ >= 0 + var_411_9 and arg_408_1.time_ < 0 + var_411_9 + arg_411_0 and not isNil(var_411_8) and arg_408_1.var_.actorSpriteComps10022 then
				for iter_411_8, iter_411_9 in pairs(arg_408_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_411_9 then
						iter_411_9.color = arg_408_1.isInRecall_ and (arg_408_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_408_1.var_.actorSpriteComps10022 = nil
			end

			local var_411_11 = 0
			local var_411_12 = 0.275

			if 0 < arg_408_1.time_ and arg_408_1.time_ <= var_411_11 + arg_411_0 then
				arg_408_1.talkMaxDuration = 0
				arg_408_1.dialogCg_.alpha = 1

				arg_408_1.dialog_:SetActive(true)
				SetActive(arg_408_1.leftNameGo_, true)

				arg_408_1.leftNameTxt_.text = arg_408_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_408_1.leftNameTxt_.transform)

				arg_408_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_408_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_408_1:RecordName(arg_408_1.leftNameTxt_.text)
				SetActive(arg_408_1.iconTrs_.gameObject, false)
				arg_408_1.callingController_:SetSelectedState("normal")

				local var_411_13 = arg_408_1:GetWordFromCfg(413041100)
				local var_411_14 = arg_408_1:FormatText(var_411_13.content)

				arg_408_1.text_.text = var_411_14

				LuaForUtil.ClearLinePrefixSymbol(arg_408_1.text_)

				local var_411_16 = 11 <= 0 and var_411_12 or var_411_12 * (utf8.len(var_411_14) / 11)

				if (11 <= 0 and var_411_12 or var_411_12 * (utf8.len(var_411_14) / 11)) > 0 and var_411_12 < var_411_16 then
					arg_408_1.talkMaxDuration = var_411_16

					if var_411_16 + var_411_11 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_16 + var_411_11
					end
				end

				arg_408_1.text_.text = var_411_14
				arg_408_1.typewritter.percent = 0

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413041", "413041100", "story_v_out_413041.awb") ~= 0 then
					local var_411_17 = manager.audio:GetVoiceLength("story_v_out_413041", "413041100", "story_v_out_413041.awb") / 1000

					if var_411_17 + var_411_11 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_17 + var_411_11
					end

					if var_411_13.prefab_name ~= "" and arg_408_1.actors_[var_411_13.prefab_name] ~= nil then
						local var_411_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_408_1.actors_[var_411_13.prefab_name].transform, "story_v_out_413041", "413041100", "story_v_out_413041.awb")

						arg_408_1:RecordAudio("413041100", var_411_18)
						arg_408_1:RecordAudio("413041100", var_411_18)
					else
						arg_408_1:AudioAction("play", "voice", "story_v_out_413041", "413041100", "story_v_out_413041.awb")
					end

					arg_408_1:RecordHistoryTalkVoice("story_v_out_413041", "413041100", "story_v_out_413041.awb")
				end

				arg_408_1:RecordContent(arg_408_1.text_.text)
			end

			local var_411_19 = math.max(var_411_12, arg_408_1.talkMaxDuration)

			if var_411_11 <= arg_408_1.time_ and arg_408_1.time_ < var_411_11 + var_411_19 then
				arg_408_1.typewritter.percent = (arg_408_1.time_ - var_411_11) / var_411_19

				arg_408_1.typewritter:SetDirty()
			end

			if arg_408_1.time_ >= var_411_11 + var_411_19 and arg_408_1.time_ < var_411_11 + var_411_19 + arg_411_0 then
				arg_408_1.typewritter.percent = 1

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(true)
			end
		end

		arg_408_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_408_1:InitPlayNodeList()
	end,
	Play413041101 = function(arg_412_0, arg_412_1)
		arg_412_1.time_ = 0
		arg_412_1.frameCnt_ = 0
		arg_412_1.state_ = "playing"
		arg_412_1.curTalkId_ = 413041101
		arg_412_1.duration_ = 9.5

		local var_412_0 = {
			zh = 7.8,
			ja = 9.5
		}
		local var_412_1 = manager.audio:GetLocalizationFlag()

		if var_412_0[var_412_1] ~= nil then
			arg_412_1.duration_ = var_412_0[var_412_1]
		end

		SetActive(arg_412_1.tipsGo_, false)

		function arg_412_1.onSingleLineFinish_()
			arg_412_1.onSingleLineUpdate_ = nil
			arg_412_1.onSingleLineFinish_ = nil
			arg_412_1.state_ = "waiting"
		end

		function arg_412_1.playNext_(arg_414_0)
			if arg_414_0 == 1 then
				arg_412_0:Play413041102(arg_412_1)
			end
		end

		function arg_412_1.onSingleLineUpdate_(arg_415_0)
			if 0 < arg_412_1.time_ and arg_412_1.time_ <= 0 + arg_415_0 then
				arg_412_1.var_.moveOldPos10022 = arg_412_1.actors_["10022"].transform.localPosition
				arg_412_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_412_1:CheckSpriteTmpPos("10022", 2)

				for iter_415_0 = 0, arg_412_1.actors_["10022"].transform.childCount - 1 do
					local var_415_0 = arg_412_1.actors_["10022"].transform:GetChild(iter_415_0)

					if var_415_0.name == "split_3" or not string.find(var_415_0.name, "split") then
						var_415_0.gameObject:SetActive(true)
					else
						var_415_0.gameObject:SetActive(false)
					end
				end
			end

			local var_415_1 = 0.001

			if 0 <= arg_412_1.time_ and arg_412_1.time_ < 0 + var_415_1 then
				arg_412_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_412_1.var_.moveOldPos10022, Vector3.New(-390, -315, -320), (arg_412_1.time_ - 0) / var_415_1)
			end

			if arg_412_1.time_ >= 0 + var_415_1 and arg_412_1.time_ < 0 + var_415_1 + arg_415_0 then
				arg_412_1.actors_["10022"].transform.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_415_2 = arg_412_1.actors_["10094"]

			if 0 < arg_412_1.time_ and arg_412_1.time_ <= 0 + arg_415_0 and not isNil(var_415_2) and arg_412_1.var_.actorSpriteComps10094 == nil then
				arg_412_1.var_.actorSpriteComps10094 = var_415_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_415_3 = 2

			if 0 <= arg_412_1.time_ and arg_412_1.time_ < 0 + var_415_3 and not isNil(var_415_2) then
				if arg_412_1.var_.actorSpriteComps10094 then
					for iter_415_1, iter_415_2 in pairs(arg_412_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_415_2 then
							if arg_412_1.isInRecall_ then
								iter_415_2.color = Color.New(Mathf.Lerp(iter_415_2.color.r, arg_412_1.hightColor2.r, (arg_412_1.time_ - 0) / var_415_3), Mathf.Lerp(iter_415_2.color.g, arg_412_1.hightColor2.g, (arg_412_1.time_ - 0) / var_415_3), (Mathf.Lerp(iter_415_2.color.b, arg_412_1.hightColor2.b, (arg_412_1.time_ - 0) / var_415_3)))
							else
								local var_415_4 = Mathf.Lerp(iter_415_2.color.r, 0.5, (arg_412_1.time_ - 0) / var_415_3)

								iter_415_2.color = Color.New(var_415_4, var_415_4, var_415_4)
							end
						end
					end
				end
			end

			if arg_412_1.time_ >= 0 + var_415_3 and arg_412_1.time_ < 0 + var_415_3 + arg_415_0 and not isNil(var_415_2) and arg_412_1.var_.actorSpriteComps10094 then
				for iter_415_3, iter_415_4 in pairs(arg_412_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_415_4 then
						iter_415_4.color = arg_412_1.isInRecall_ and (arg_412_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_412_1.var_.actorSpriteComps10094 = nil
			end

			local var_415_5 = arg_412_1.actors_["10022"]

			if 0 < arg_412_1.time_ and arg_412_1.time_ <= 0 + arg_415_0 and not isNil(var_415_5) and arg_412_1.var_.actorSpriteComps10022 == nil then
				arg_412_1.var_.actorSpriteComps10022 = var_415_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_415_6 = 2

			if 0 <= arg_412_1.time_ and arg_412_1.time_ < 0 + var_415_6 and not isNil(var_415_5) then
				if arg_412_1.var_.actorSpriteComps10022 then
					for iter_415_5, iter_415_6 in pairs(arg_412_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_415_6 then
							if arg_412_1.isInRecall_ then
								iter_415_6.color = Color.New(Mathf.Lerp(iter_415_6.color.r, arg_412_1.hightColor1.r, (arg_412_1.time_ - 0) / var_415_6), Mathf.Lerp(iter_415_6.color.g, arg_412_1.hightColor1.g, (arg_412_1.time_ - 0) / var_415_6), (Mathf.Lerp(iter_415_6.color.b, arg_412_1.hightColor1.b, (arg_412_1.time_ - 0) / var_415_6)))
							else
								local var_415_7 = Mathf.Lerp(iter_415_6.color.r, 1, (arg_412_1.time_ - 0) / var_415_6)

								iter_415_6.color = Color.New(var_415_7, var_415_7, var_415_7)
							end
						end
					end
				end
			end

			if arg_412_1.time_ >= 0 + var_415_6 and arg_412_1.time_ < 0 + var_415_6 + arg_415_0 and not isNil(var_415_5) and arg_412_1.var_.actorSpriteComps10022 then
				for iter_415_7, iter_415_8 in pairs(arg_412_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_415_8 then
						iter_415_8.color = arg_412_1.isInRecall_ and (arg_412_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_412_1.var_.actorSpriteComps10022 = nil
			end

			local var_415_8 = 0
			local var_415_9 = 0.575

			if 0 < arg_412_1.time_ and arg_412_1.time_ <= var_415_8 + arg_415_0 then
				arg_412_1.talkMaxDuration = 0
				arg_412_1.dialogCg_.alpha = 1

				arg_412_1.dialog_:SetActive(true)
				SetActive(arg_412_1.leftNameGo_, true)

				arg_412_1.leftNameTxt_.text = arg_412_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_412_1.leftNameTxt_.transform)

				arg_412_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_412_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_412_1:RecordName(arg_412_1.leftNameTxt_.text)
				SetActive(arg_412_1.iconTrs_.gameObject, false)
				arg_412_1.callingController_:SetSelectedState("normal")

				local var_415_10 = arg_412_1:GetWordFromCfg(413041101)
				local var_415_11 = arg_412_1:FormatText(var_415_10.content)

				arg_412_1.text_.text = var_415_11

				LuaForUtil.ClearLinePrefixSymbol(arg_412_1.text_)

				local var_415_13 = 23 <= 0 and var_415_9 or var_415_9 * (utf8.len(var_415_11) / 23)

				if (23 <= 0 and var_415_9 or var_415_9 * (utf8.len(var_415_11) / 23)) > 0 and var_415_9 < var_415_13 then
					arg_412_1.talkMaxDuration = var_415_13

					if var_415_13 + var_415_8 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_13 + var_415_8
					end
				end

				arg_412_1.text_.text = var_415_11
				arg_412_1.typewritter.percent = 0

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413041", "413041101", "story_v_out_413041.awb") ~= 0 then
					local var_415_14 = manager.audio:GetVoiceLength("story_v_out_413041", "413041101", "story_v_out_413041.awb") / 1000

					if var_415_14 + var_415_8 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_14 + var_415_8
					end

					if var_415_10.prefab_name ~= "" and arg_412_1.actors_[var_415_10.prefab_name] ~= nil then
						local var_415_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_412_1.actors_[var_415_10.prefab_name].transform, "story_v_out_413041", "413041101", "story_v_out_413041.awb")

						arg_412_1:RecordAudio("413041101", var_415_15)
						arg_412_1:RecordAudio("413041101", var_415_15)
					else
						arg_412_1:AudioAction("play", "voice", "story_v_out_413041", "413041101", "story_v_out_413041.awb")
					end

					arg_412_1:RecordHistoryTalkVoice("story_v_out_413041", "413041101", "story_v_out_413041.awb")
				end

				arg_412_1:RecordContent(arg_412_1.text_.text)
			end

			local var_415_16 = math.max(var_415_9, arg_412_1.talkMaxDuration)

			if var_415_8 <= arg_412_1.time_ and arg_412_1.time_ < var_415_8 + var_415_16 then
				arg_412_1.typewritter.percent = (arg_412_1.time_ - var_415_8) / var_415_16

				arg_412_1.typewritter:SetDirty()
			end

			if arg_412_1.time_ >= var_415_8 + var_415_16 and arg_412_1.time_ < var_415_8 + var_415_16 + arg_415_0 then
				arg_412_1.typewritter.percent = 1

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(true)
			end
		end

		arg_412_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_412_1:InitPlayNodeList()
	end,
	Play413041102 = function(arg_416_0, arg_416_1)
		arg_416_1.time_ = 0
		arg_416_1.frameCnt_ = 0
		arg_416_1.state_ = "playing"
		arg_416_1.curTalkId_ = 413041102
		arg_416_1.duration_ = 9.1

		local var_416_0 = {
			zh = 4.366,
			ja = 9.1
		}
		local var_416_1 = manager.audio:GetLocalizationFlag()

		if var_416_0[var_416_1] ~= nil then
			arg_416_1.duration_ = var_416_0[var_416_1]
		end

		SetActive(arg_416_1.tipsGo_, false)

		function arg_416_1.onSingleLineFinish_()
			arg_416_1.onSingleLineUpdate_ = nil
			arg_416_1.onSingleLineFinish_ = nil
			arg_416_1.state_ = "waiting"
		end

		function arg_416_1.playNext_(arg_418_0)
			if arg_418_0 == 1 then
				arg_416_0:Play413041103(arg_416_1)
			end
		end

		function arg_416_1.onSingleLineUpdate_(arg_419_0)
			local var_419_0 = 0.5

			if 0 < arg_416_1.time_ and arg_416_1.time_ <= 0 + arg_419_0 then
				arg_416_1.talkMaxDuration = 0
				arg_416_1.dialogCg_.alpha = 1

				arg_416_1.dialog_:SetActive(true)
				SetActive(arg_416_1.leftNameGo_, true)

				arg_416_1.leftNameTxt_.text = arg_416_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_416_1.leftNameTxt_.transform)

				arg_416_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_416_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_416_1:RecordName(arg_416_1.leftNameTxt_.text)
				SetActive(arg_416_1.iconTrs_.gameObject, false)
				arg_416_1.callingController_:SetSelectedState("normal")

				local var_419_1 = arg_416_1:GetWordFromCfg(413041102)
				local var_419_2 = arg_416_1:FormatText(var_419_1.content)

				arg_416_1.text_.text = var_419_2

				LuaForUtil.ClearLinePrefixSymbol(arg_416_1.text_)

				local var_419_4 = 20 <= 0 and var_419_0 or var_419_0 * (utf8.len(var_419_2) / 20)

				if (20 <= 0 and var_419_0 or var_419_0 * (utf8.len(var_419_2) / 20)) > 0 and var_419_0 < var_419_4 then
					arg_416_1.talkMaxDuration = var_419_4

					if var_419_4 + 0 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_4 + 0
					end
				end

				arg_416_1.text_.text = var_419_2
				arg_416_1.typewritter.percent = 0

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413041", "413041102", "story_v_out_413041.awb") ~= 0 then
					local var_419_5 = manager.audio:GetVoiceLength("story_v_out_413041", "413041102", "story_v_out_413041.awb") / 1000

					if var_419_5 + 0 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_5 + 0
					end

					if var_419_1.prefab_name ~= "" and arg_416_1.actors_[var_419_1.prefab_name] ~= nil then
						local var_419_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_416_1.actors_[var_419_1.prefab_name].transform, "story_v_out_413041", "413041102", "story_v_out_413041.awb")

						arg_416_1:RecordAudio("413041102", var_419_6)
						arg_416_1:RecordAudio("413041102", var_419_6)
					else
						arg_416_1:AudioAction("play", "voice", "story_v_out_413041", "413041102", "story_v_out_413041.awb")
					end

					arg_416_1:RecordHistoryTalkVoice("story_v_out_413041", "413041102", "story_v_out_413041.awb")
				end

				arg_416_1:RecordContent(arg_416_1.text_.text)
			end

			local var_419_7 = math.max(var_419_0, arg_416_1.talkMaxDuration)

			if 0 <= arg_416_1.time_ and arg_416_1.time_ < 0 + var_419_7 then
				arg_416_1.typewritter.percent = (arg_416_1.time_ - 0) / var_419_7

				arg_416_1.typewritter:SetDirty()
			end

			if arg_416_1.time_ >= 0 + var_419_7 and arg_416_1.time_ < 0 + var_419_7 + arg_419_0 then
				arg_416_1.typewritter.percent = 1

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(true)
			end
		end

		arg_416_1.nodeConfigList_ = {}

		arg_416_1:InitPlayNodeList()
	end,
	Play413041103 = function(arg_420_0, arg_420_1)
		arg_420_1.time_ = 0
		arg_420_1.frameCnt_ = 0
		arg_420_1.state_ = "playing"
		arg_420_1.curTalkId_ = 413041103
		arg_420_1.duration_ = 8.57

		local var_420_0 = {
			zh = 3.333,
			ja = 8.566
		}
		local var_420_1 = manager.audio:GetLocalizationFlag()

		if var_420_0[var_420_1] ~= nil then
			arg_420_1.duration_ = var_420_0[var_420_1]
		end

		SetActive(arg_420_1.tipsGo_, false)

		function arg_420_1.onSingleLineFinish_()
			arg_420_1.onSingleLineUpdate_ = nil
			arg_420_1.onSingleLineFinish_ = nil
			arg_420_1.state_ = "waiting"
		end

		function arg_420_1.playNext_(arg_422_0)
			if arg_422_0 == 1 then
				arg_420_0:Play413041104(arg_420_1)
			end
		end

		function arg_420_1.onSingleLineUpdate_(arg_423_0)
			if 0 < arg_420_1.time_ and arg_420_1.time_ <= 0 + arg_423_0 then
				arg_420_1.var_.moveOldPos10094 = arg_420_1.actors_["10094"].transform.localPosition
				arg_420_1.actors_["10094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_420_1:CheckSpriteTmpPos("10094", 4)

				for iter_423_0 = 0, arg_420_1.actors_["10094"].transform.childCount - 1 do
					local var_423_0 = arg_420_1.actors_["10094"].transform:GetChild(iter_423_0)

					if var_423_0.name == "" or not string.find(var_423_0.name, "split") then
						var_423_0.gameObject:SetActive(true)
					else
						var_423_0.gameObject:SetActive(false)
					end
				end
			end

			local var_423_1 = 0.001

			if 0 <= arg_420_1.time_ and arg_420_1.time_ < 0 + var_423_1 then
				arg_420_1.actors_["10094"].transform.localPosition = Vector3.Lerp(arg_420_1.var_.moveOldPos10094, Vector3.New(390, -340, -414), (arg_420_1.time_ - 0) / var_423_1)
			end

			if arg_420_1.time_ >= 0 + var_423_1 and arg_420_1.time_ < 0 + var_423_1 + arg_423_0 then
				arg_420_1.actors_["10094"].transform.localPosition = Vector3.New(390, -340, -414)
			end

			local var_423_2 = arg_420_1.actors_["10094"]

			if 0 < arg_420_1.time_ and arg_420_1.time_ <= 0 + arg_423_0 and not isNil(var_423_2) and arg_420_1.var_.actorSpriteComps10094 == nil then
				arg_420_1.var_.actorSpriteComps10094 = var_423_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_423_3 = 2

			if 0 <= arg_420_1.time_ and arg_420_1.time_ < 0 + var_423_3 and not isNil(var_423_2) then
				if arg_420_1.var_.actorSpriteComps10094 then
					for iter_423_1, iter_423_2 in pairs(arg_420_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_423_2 then
							if arg_420_1.isInRecall_ then
								iter_423_2.color = Color.New(Mathf.Lerp(iter_423_2.color.r, arg_420_1.hightColor1.r, (arg_420_1.time_ - 0) / var_423_3), Mathf.Lerp(iter_423_2.color.g, arg_420_1.hightColor1.g, (arg_420_1.time_ - 0) / var_423_3), (Mathf.Lerp(iter_423_2.color.b, arg_420_1.hightColor1.b, (arg_420_1.time_ - 0) / var_423_3)))
							else
								local var_423_4 = Mathf.Lerp(iter_423_2.color.r, 1, (arg_420_1.time_ - 0) / var_423_3)

								iter_423_2.color = Color.New(var_423_4, var_423_4, var_423_4)
							end
						end
					end
				end
			end

			if arg_420_1.time_ >= 0 + var_423_3 and arg_420_1.time_ < 0 + var_423_3 + arg_423_0 and not isNil(var_423_2) and arg_420_1.var_.actorSpriteComps10094 then
				for iter_423_3, iter_423_4 in pairs(arg_420_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_423_4 then
						iter_423_4.color = arg_420_1.isInRecall_ and (arg_420_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_420_1.var_.actorSpriteComps10094 = nil
			end

			local var_423_5 = arg_420_1.actors_["10022"]

			if 0 < arg_420_1.time_ and arg_420_1.time_ <= 0 + arg_423_0 and not isNil(var_423_5) and arg_420_1.var_.actorSpriteComps10022 == nil then
				arg_420_1.var_.actorSpriteComps10022 = var_423_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_423_6 = 2

			if 0 <= arg_420_1.time_ and arg_420_1.time_ < 0 + var_423_6 and not isNil(var_423_5) then
				if arg_420_1.var_.actorSpriteComps10022 then
					for iter_423_5, iter_423_6 in pairs(arg_420_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_423_6 then
							if arg_420_1.isInRecall_ then
								iter_423_6.color = Color.New(Mathf.Lerp(iter_423_6.color.r, arg_420_1.hightColor2.r, (arg_420_1.time_ - 0) / var_423_6), Mathf.Lerp(iter_423_6.color.g, arg_420_1.hightColor2.g, (arg_420_1.time_ - 0) / var_423_6), (Mathf.Lerp(iter_423_6.color.b, arg_420_1.hightColor2.b, (arg_420_1.time_ - 0) / var_423_6)))
							else
								local var_423_7 = Mathf.Lerp(iter_423_6.color.r, 0.5, (arg_420_1.time_ - 0) / var_423_6)

								iter_423_6.color = Color.New(var_423_7, var_423_7, var_423_7)
							end
						end
					end
				end
			end

			if arg_420_1.time_ >= 0 + var_423_6 and arg_420_1.time_ < 0 + var_423_6 + arg_423_0 and not isNil(var_423_5) and arg_420_1.var_.actorSpriteComps10022 then
				for iter_423_7, iter_423_8 in pairs(arg_420_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_423_8 then
						iter_423_8.color = arg_420_1.isInRecall_ and (arg_420_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_420_1.var_.actorSpriteComps10022 = nil
			end

			local var_423_8 = 0
			local var_423_9 = 0.375

			if 0 < arg_420_1.time_ and arg_420_1.time_ <= var_423_8 + arg_423_0 then
				arg_420_1.talkMaxDuration = 0
				arg_420_1.dialogCg_.alpha = 1

				arg_420_1.dialog_:SetActive(true)
				SetActive(arg_420_1.leftNameGo_, true)

				arg_420_1.leftNameTxt_.text = arg_420_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_420_1.leftNameTxt_.transform)

				arg_420_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_420_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_420_1:RecordName(arg_420_1.leftNameTxt_.text)
				SetActive(arg_420_1.iconTrs_.gameObject, false)
				arg_420_1.callingController_:SetSelectedState("normal")

				local var_423_10 = arg_420_1:GetWordFromCfg(413041103)
				local var_423_11 = arg_420_1:FormatText(var_423_10.content)

				arg_420_1.text_.text = var_423_11

				LuaForUtil.ClearLinePrefixSymbol(arg_420_1.text_)

				local var_423_13 = 15 <= 0 and var_423_9 or var_423_9 * (utf8.len(var_423_11) / 15)

				if (15 <= 0 and var_423_9 or var_423_9 * (utf8.len(var_423_11) / 15)) > 0 and var_423_9 < var_423_13 then
					arg_420_1.talkMaxDuration = var_423_13

					if var_423_13 + var_423_8 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_13 + var_423_8
					end
				end

				arg_420_1.text_.text = var_423_11
				arg_420_1.typewritter.percent = 0

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413041", "413041103", "story_v_out_413041.awb") ~= 0 then
					local var_423_14 = manager.audio:GetVoiceLength("story_v_out_413041", "413041103", "story_v_out_413041.awb") / 1000

					if var_423_14 + var_423_8 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_14 + var_423_8
					end

					if var_423_10.prefab_name ~= "" and arg_420_1.actors_[var_423_10.prefab_name] ~= nil then
						local var_423_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_420_1.actors_[var_423_10.prefab_name].transform, "story_v_out_413041", "413041103", "story_v_out_413041.awb")

						arg_420_1:RecordAudio("413041103", var_423_15)
						arg_420_1:RecordAudio("413041103", var_423_15)
					else
						arg_420_1:AudioAction("play", "voice", "story_v_out_413041", "413041103", "story_v_out_413041.awb")
					end

					arg_420_1:RecordHistoryTalkVoice("story_v_out_413041", "413041103", "story_v_out_413041.awb")
				end

				arg_420_1:RecordContent(arg_420_1.text_.text)
			end

			local var_423_16 = math.max(var_423_9, arg_420_1.talkMaxDuration)

			if var_423_8 <= arg_420_1.time_ and arg_420_1.time_ < var_423_8 + var_423_16 then
				arg_420_1.typewritter.percent = (arg_420_1.time_ - var_423_8) / var_423_16

				arg_420_1.typewritter:SetDirty()
			end

			if arg_420_1.time_ >= var_423_8 + var_423_16 and arg_420_1.time_ < var_423_8 + var_423_16 + arg_423_0 then
				arg_420_1.typewritter.percent = 1

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(true)
			end
		end

		arg_420_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_420_1:InitPlayNodeList()
	end,
	Play413041104 = function(arg_424_0, arg_424_1)
		arg_424_1.time_ = 0
		arg_424_1.frameCnt_ = 0
		arg_424_1.state_ = "playing"
		arg_424_1.curTalkId_ = 413041104
		arg_424_1.duration_ = 9

		local var_424_0 = {
			zh = 4.633,
			ja = 9
		}
		local var_424_1 = manager.audio:GetLocalizationFlag()

		if var_424_0[var_424_1] ~= nil then
			arg_424_1.duration_ = var_424_0[var_424_1]
		end

		SetActive(arg_424_1.tipsGo_, false)

		function arg_424_1.onSingleLineFinish_()
			arg_424_1.onSingleLineUpdate_ = nil
			arg_424_1.onSingleLineFinish_ = nil
			arg_424_1.state_ = "waiting"
		end

		function arg_424_1.playNext_(arg_426_0)
			if arg_426_0 == 1 then
				arg_424_0:Play413041105(arg_424_1)
			end
		end

		function arg_424_1.onSingleLineUpdate_(arg_427_0)
			local var_427_0 = 0.575

			if 0 < arg_424_1.time_ and arg_424_1.time_ <= 0 + arg_427_0 then
				arg_424_1.talkMaxDuration = 0
				arg_424_1.dialogCg_.alpha = 1

				arg_424_1.dialog_:SetActive(true)
				SetActive(arg_424_1.leftNameGo_, true)

				arg_424_1.leftNameTxt_.text = arg_424_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_424_1.leftNameTxt_.transform)

				arg_424_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_424_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_424_1:RecordName(arg_424_1.leftNameTxt_.text)
				SetActive(arg_424_1.iconTrs_.gameObject, false)
				arg_424_1.callingController_:SetSelectedState("normal")

				local var_427_1 = arg_424_1:GetWordFromCfg(413041104)
				local var_427_2 = arg_424_1:FormatText(var_427_1.content)

				arg_424_1.text_.text = var_427_2

				LuaForUtil.ClearLinePrefixSymbol(arg_424_1.text_)

				local var_427_4 = 23 <= 0 and var_427_0 or var_427_0 * (utf8.len(var_427_2) / 23)

				if (23 <= 0 and var_427_0 or var_427_0 * (utf8.len(var_427_2) / 23)) > 0 and var_427_0 < var_427_4 then
					arg_424_1.talkMaxDuration = var_427_4

					if var_427_4 + 0 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_4 + 0
					end
				end

				arg_424_1.text_.text = var_427_2
				arg_424_1.typewritter.percent = 0

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413041", "413041104", "story_v_out_413041.awb") ~= 0 then
					local var_427_5 = manager.audio:GetVoiceLength("story_v_out_413041", "413041104", "story_v_out_413041.awb") / 1000

					if var_427_5 + 0 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_5 + 0
					end

					if var_427_1.prefab_name ~= "" and arg_424_1.actors_[var_427_1.prefab_name] ~= nil then
						local var_427_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_424_1.actors_[var_427_1.prefab_name].transform, "story_v_out_413041", "413041104", "story_v_out_413041.awb")

						arg_424_1:RecordAudio("413041104", var_427_6)
						arg_424_1:RecordAudio("413041104", var_427_6)
					else
						arg_424_1:AudioAction("play", "voice", "story_v_out_413041", "413041104", "story_v_out_413041.awb")
					end

					arg_424_1:RecordHistoryTalkVoice("story_v_out_413041", "413041104", "story_v_out_413041.awb")
				end

				arg_424_1:RecordContent(arg_424_1.text_.text)
			end

			local var_427_7 = math.max(var_427_0, arg_424_1.talkMaxDuration)

			if 0 <= arg_424_1.time_ and arg_424_1.time_ < 0 + var_427_7 then
				arg_424_1.typewritter.percent = (arg_424_1.time_ - 0) / var_427_7

				arg_424_1.typewritter:SetDirty()
			end

			if arg_424_1.time_ >= 0 + var_427_7 and arg_424_1.time_ < 0 + var_427_7 + arg_427_0 then
				arg_424_1.typewritter.percent = 1

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(true)
			end
		end

		arg_424_1.nodeConfigList_ = {}

		arg_424_1:InitPlayNodeList()
	end,
	Play413041105 = function(arg_428_0, arg_428_1)
		arg_428_1.time_ = 0
		arg_428_1.frameCnt_ = 0
		arg_428_1.state_ = "playing"
		arg_428_1.curTalkId_ = 413041105
		arg_428_1.duration_ = 6.03

		local var_428_0 = {
			zh = 3.7,
			ja = 6.033
		}
		local var_428_1 = manager.audio:GetLocalizationFlag()

		if var_428_0[var_428_1] ~= nil then
			arg_428_1.duration_ = var_428_0[var_428_1]
		end

		SetActive(arg_428_1.tipsGo_, false)

		function arg_428_1.onSingleLineFinish_()
			arg_428_1.onSingleLineUpdate_ = nil
			arg_428_1.onSingleLineFinish_ = nil
			arg_428_1.state_ = "waiting"
		end

		function arg_428_1.playNext_(arg_430_0)
			if arg_430_0 == 1 then
				arg_428_0:Play413041106(arg_428_1)
			end
		end

		function arg_428_1.onSingleLineUpdate_(arg_431_0)
			if 0 < arg_428_1.time_ and arg_428_1.time_ <= 0 + arg_431_0 then
				arg_428_1.var_.moveOldPos10094 = arg_428_1.actors_["10094"].transform.localPosition
				arg_428_1.actors_["10094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_428_1:CheckSpriteTmpPos("10094", 4)

				for iter_431_0 = 0, arg_428_1.actors_["10094"].transform.childCount - 1 do
					local var_431_0 = arg_428_1.actors_["10094"].transform:GetChild(iter_431_0)

					if var_431_0.name == "" or not string.find(var_431_0.name, "split") then
						var_431_0.gameObject:SetActive(true)
					else
						var_431_0.gameObject:SetActive(false)
					end
				end
			end

			local var_431_1 = 0.001

			if 0 <= arg_428_1.time_ and arg_428_1.time_ < 0 + var_431_1 then
				arg_428_1.actors_["10094"].transform.localPosition = Vector3.Lerp(arg_428_1.var_.moveOldPos10094, Vector3.New(390, -340, -414), (arg_428_1.time_ - 0) / var_431_1)
			end

			if arg_428_1.time_ >= 0 + var_431_1 and arg_428_1.time_ < 0 + var_431_1 + arg_431_0 then
				arg_428_1.actors_["10094"].transform.localPosition = Vector3.New(390, -340, -414)
			end

			local var_431_2 = arg_428_1.actors_["10022"].transform

			if 0 < arg_428_1.time_ and arg_428_1.time_ <= 0 + arg_431_0 then
				arg_428_1.var_.moveOldPos10022 = var_431_2.localPosition
				var_431_2.localScale = Vector3.New(1, 1, 1)

				arg_428_1:CheckSpriteTmpPos("10022", 2)

				for iter_431_1 = 0, var_431_2.childCount - 1 do
					local var_431_3 = var_431_2:GetChild(iter_431_1)

					if var_431_3.name == "split_8" or not string.find(var_431_3.name, "split") then
						var_431_3.gameObject:SetActive(true)
					else
						var_431_3.gameObject:SetActive(false)
					end
				end
			end

			local var_431_4 = 0.001

			if 0 <= arg_428_1.time_ and arg_428_1.time_ < 0 + var_431_4 then
				var_431_2.localPosition = Vector3.Lerp(arg_428_1.var_.moveOldPos10022, Vector3.New(-390, -315, -320), (arg_428_1.time_ - 0) / var_431_4)
			end

			if arg_428_1.time_ >= 0 + var_431_4 and arg_428_1.time_ < 0 + var_431_4 + arg_431_0 then
				var_431_2.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_431_5 = arg_428_1.actors_["10094"]

			if 0 < arg_428_1.time_ and arg_428_1.time_ <= 0 + arg_431_0 and not isNil(var_431_5) and arg_428_1.var_.actorSpriteComps10094 == nil then
				arg_428_1.var_.actorSpriteComps10094 = var_431_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_431_6 = 2

			if 0 <= arg_428_1.time_ and arg_428_1.time_ < 0 + var_431_6 and not isNil(var_431_5) then
				if arg_428_1.var_.actorSpriteComps10094 then
					for iter_431_2, iter_431_3 in pairs(arg_428_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_431_3 then
							if arg_428_1.isInRecall_ then
								iter_431_3.color = Color.New(Mathf.Lerp(iter_431_3.color.r, arg_428_1.hightColor2.r, (arg_428_1.time_ - 0) / var_431_6), Mathf.Lerp(iter_431_3.color.g, arg_428_1.hightColor2.g, (arg_428_1.time_ - 0) / var_431_6), (Mathf.Lerp(iter_431_3.color.b, arg_428_1.hightColor2.b, (arg_428_1.time_ - 0) / var_431_6)))
							else
								local var_431_7 = Mathf.Lerp(iter_431_3.color.r, 0.5, (arg_428_1.time_ - 0) / var_431_6)

								iter_431_3.color = Color.New(var_431_7, var_431_7, var_431_7)
							end
						end
					end
				end
			end

			if arg_428_1.time_ >= 0 + var_431_6 and arg_428_1.time_ < 0 + var_431_6 + arg_431_0 and not isNil(var_431_5) and arg_428_1.var_.actorSpriteComps10094 then
				for iter_431_4, iter_431_5 in pairs(arg_428_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_431_5 then
						iter_431_5.color = arg_428_1.isInRecall_ and (arg_428_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_428_1.var_.actorSpriteComps10094 = nil
			end

			local var_431_8 = arg_428_1.actors_["10022"]

			if 0 < arg_428_1.time_ and arg_428_1.time_ <= 0 + arg_431_0 and not isNil(var_431_8) and arg_428_1.var_.actorSpriteComps10022 == nil then
				arg_428_1.var_.actorSpriteComps10022 = var_431_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_431_9 = 2

			if 0 <= arg_428_1.time_ and arg_428_1.time_ < 0 + var_431_9 and not isNil(var_431_8) then
				if arg_428_1.var_.actorSpriteComps10022 then
					for iter_431_6, iter_431_7 in pairs(arg_428_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_431_7 then
							if arg_428_1.isInRecall_ then
								iter_431_7.color = Color.New(Mathf.Lerp(iter_431_7.color.r, arg_428_1.hightColor1.r, (arg_428_1.time_ - 0) / var_431_9), Mathf.Lerp(iter_431_7.color.g, arg_428_1.hightColor1.g, (arg_428_1.time_ - 0) / var_431_9), (Mathf.Lerp(iter_431_7.color.b, arg_428_1.hightColor1.b, (arg_428_1.time_ - 0) / var_431_9)))
							else
								local var_431_10 = Mathf.Lerp(iter_431_7.color.r, 1, (arg_428_1.time_ - 0) / var_431_9)

								iter_431_7.color = Color.New(var_431_10, var_431_10, var_431_10)
							end
						end
					end
				end
			end

			if arg_428_1.time_ >= 0 + var_431_9 and arg_428_1.time_ < 0 + var_431_9 + arg_431_0 and not isNil(var_431_8) and arg_428_1.var_.actorSpriteComps10022 then
				for iter_431_8, iter_431_9 in pairs(arg_428_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_431_9 then
						iter_431_9.color = arg_428_1.isInRecall_ and (arg_428_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_428_1.var_.actorSpriteComps10022 = nil
			end

			local var_431_11 = 0
			local var_431_12 = 0.45

			if 0 < arg_428_1.time_ and arg_428_1.time_ <= var_431_11 + arg_431_0 then
				arg_428_1.talkMaxDuration = 0
				arg_428_1.dialogCg_.alpha = 1

				arg_428_1.dialog_:SetActive(true)
				SetActive(arg_428_1.leftNameGo_, true)

				arg_428_1.leftNameTxt_.text = arg_428_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_428_1.leftNameTxt_.transform)

				arg_428_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_428_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_428_1:RecordName(arg_428_1.leftNameTxt_.text)
				SetActive(arg_428_1.iconTrs_.gameObject, false)
				arg_428_1.callingController_:SetSelectedState("normal")

				local var_431_13 = arg_428_1:GetWordFromCfg(413041105)
				local var_431_14 = arg_428_1:FormatText(var_431_13.content)

				arg_428_1.text_.text = var_431_14

				LuaForUtil.ClearLinePrefixSymbol(arg_428_1.text_)

				local var_431_16 = 18 <= 0 and var_431_12 or var_431_12 * (utf8.len(var_431_14) / 18)

				if (18 <= 0 and var_431_12 or var_431_12 * (utf8.len(var_431_14) / 18)) > 0 and var_431_12 < var_431_16 then
					arg_428_1.talkMaxDuration = var_431_16

					if var_431_16 + var_431_11 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_16 + var_431_11
					end
				end

				arg_428_1.text_.text = var_431_14
				arg_428_1.typewritter.percent = 0

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413041", "413041105", "story_v_out_413041.awb") ~= 0 then
					local var_431_17 = manager.audio:GetVoiceLength("story_v_out_413041", "413041105", "story_v_out_413041.awb") / 1000

					if var_431_17 + var_431_11 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_17 + var_431_11
					end

					if var_431_13.prefab_name ~= "" and arg_428_1.actors_[var_431_13.prefab_name] ~= nil then
						local var_431_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_428_1.actors_[var_431_13.prefab_name].transform, "story_v_out_413041", "413041105", "story_v_out_413041.awb")

						arg_428_1:RecordAudio("413041105", var_431_18)
						arg_428_1:RecordAudio("413041105", var_431_18)
					else
						arg_428_1:AudioAction("play", "voice", "story_v_out_413041", "413041105", "story_v_out_413041.awb")
					end

					arg_428_1:RecordHistoryTalkVoice("story_v_out_413041", "413041105", "story_v_out_413041.awb")
				end

				arg_428_1:RecordContent(arg_428_1.text_.text)
			end

			local var_431_19 = math.max(var_431_12, arg_428_1.talkMaxDuration)

			if var_431_11 <= arg_428_1.time_ and arg_428_1.time_ < var_431_11 + var_431_19 then
				arg_428_1.typewritter.percent = (arg_428_1.time_ - var_431_11) / var_431_19

				arg_428_1.typewritter:SetDirty()
			end

			if arg_428_1.time_ >= var_431_11 + var_431_19 and arg_428_1.time_ < var_431_11 + var_431_19 + arg_431_0 then
				arg_428_1.typewritter.percent = 1

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(true)
			end
		end

		arg_428_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_428_1:InitPlayNodeList()
	end,
	Play413041106 = function(arg_432_0, arg_432_1)
		arg_432_1.time_ = 0
		arg_432_1.frameCnt_ = 0
		arg_432_1.state_ = "playing"
		arg_432_1.curTalkId_ = 413041106
		arg_432_1.duration_ = 9.5

		local var_432_0 = {
			zh = 6.7,
			ja = 9.5
		}
		local var_432_1 = manager.audio:GetLocalizationFlag()

		if var_432_0[var_432_1] ~= nil then
			arg_432_1.duration_ = var_432_0[var_432_1]
		end

		SetActive(arg_432_1.tipsGo_, false)

		function arg_432_1.onSingleLineFinish_()
			arg_432_1.onSingleLineUpdate_ = nil
			arg_432_1.onSingleLineFinish_ = nil
			arg_432_1.state_ = "waiting"
		end

		function arg_432_1.playNext_(arg_434_0)
			if arg_434_0 == 1 then
				arg_432_0:Play413041107(arg_432_1)
			end
		end

		function arg_432_1.onSingleLineUpdate_(arg_435_0)
			if 0 < arg_432_1.time_ and arg_432_1.time_ <= 0 + arg_435_0 and not isNil(arg_432_1.actors_["10094"]) and arg_432_1.var_.actorSpriteComps10094 == nil then
				arg_432_1.var_.actorSpriteComps10094 = arg_432_1.actors_["10094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_435_0 = 2

			if 0 <= arg_432_1.time_ and arg_432_1.time_ < 0 + var_435_0 and not isNil(arg_432_1.actors_["10094"]) then
				if arg_432_1.var_.actorSpriteComps10094 then
					for iter_435_0, iter_435_1 in pairs(arg_432_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_435_1 then
							if arg_432_1.isInRecall_ then
								iter_435_1.color = Color.New(Mathf.Lerp(iter_435_1.color.r, arg_432_1.hightColor1.r, (arg_432_1.time_ - 0) / var_435_0), Mathf.Lerp(iter_435_1.color.g, arg_432_1.hightColor1.g, (arg_432_1.time_ - 0) / var_435_0), (Mathf.Lerp(iter_435_1.color.b, arg_432_1.hightColor1.b, (arg_432_1.time_ - 0) / var_435_0)))
							else
								local var_435_1 = Mathf.Lerp(iter_435_1.color.r, 1, (arg_432_1.time_ - 0) / var_435_0)

								iter_435_1.color = Color.New(var_435_1, var_435_1, var_435_1)
							end
						end
					end
				end
			end

			if arg_432_1.time_ >= 0 + var_435_0 and arg_432_1.time_ < 0 + var_435_0 + arg_435_0 and not isNil(arg_432_1.actors_["10094"]) and arg_432_1.var_.actorSpriteComps10094 then
				for iter_435_2, iter_435_3 in pairs(arg_432_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_435_3 then
						iter_435_3.color = arg_432_1.isInRecall_ and (arg_432_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_432_1.var_.actorSpriteComps10094 = nil
			end

			local var_435_2 = arg_432_1.actors_["10022"]

			if 0 < arg_432_1.time_ and arg_432_1.time_ <= 0 + arg_435_0 and not isNil(var_435_2) and arg_432_1.var_.actorSpriteComps10022 == nil then
				arg_432_1.var_.actorSpriteComps10022 = var_435_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_435_3 = 2

			if 0 <= arg_432_1.time_ and arg_432_1.time_ < 0 + var_435_3 and not isNil(var_435_2) then
				if arg_432_1.var_.actorSpriteComps10022 then
					for iter_435_4, iter_435_5 in pairs(arg_432_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_435_5 then
							if arg_432_1.isInRecall_ then
								iter_435_5.color = Color.New(Mathf.Lerp(iter_435_5.color.r, arg_432_1.hightColor2.r, (arg_432_1.time_ - 0) / var_435_3), Mathf.Lerp(iter_435_5.color.g, arg_432_1.hightColor2.g, (arg_432_1.time_ - 0) / var_435_3), (Mathf.Lerp(iter_435_5.color.b, arg_432_1.hightColor2.b, (arg_432_1.time_ - 0) / var_435_3)))
							else
								local var_435_4 = Mathf.Lerp(iter_435_5.color.r, 0.5, (arg_432_1.time_ - 0) / var_435_3)

								iter_435_5.color = Color.New(var_435_4, var_435_4, var_435_4)
							end
						end
					end
				end
			end

			if arg_432_1.time_ >= 0 + var_435_3 and arg_432_1.time_ < 0 + var_435_3 + arg_435_0 and not isNil(var_435_2) and arg_432_1.var_.actorSpriteComps10022 then
				for iter_435_6, iter_435_7 in pairs(arg_432_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_435_7 then
						iter_435_7.color = arg_432_1.isInRecall_ and (arg_432_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_432_1.var_.actorSpriteComps10022 = nil
			end

			local var_435_5 = 0
			local var_435_6 = 0.7

			if 0 < arg_432_1.time_ and arg_432_1.time_ <= var_435_5 + arg_435_0 then
				arg_432_1.talkMaxDuration = 0
				arg_432_1.dialogCg_.alpha = 1

				arg_432_1.dialog_:SetActive(true)
				SetActive(arg_432_1.leftNameGo_, true)

				arg_432_1.leftNameTxt_.text = arg_432_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_432_1.leftNameTxt_.transform)

				arg_432_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_432_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_432_1:RecordName(arg_432_1.leftNameTxt_.text)
				SetActive(arg_432_1.iconTrs_.gameObject, false)
				arg_432_1.callingController_:SetSelectedState("normal")

				local var_435_7 = arg_432_1:GetWordFromCfg(413041106)
				local var_435_8 = arg_432_1:FormatText(var_435_7.content)

				arg_432_1.text_.text = var_435_8

				LuaForUtil.ClearLinePrefixSymbol(arg_432_1.text_)

				local var_435_10 = 28 <= 0 and var_435_6 or var_435_6 * (utf8.len(var_435_8) / 28)

				if (28 <= 0 and var_435_6 or var_435_6 * (utf8.len(var_435_8) / 28)) > 0 and var_435_6 < var_435_10 then
					arg_432_1.talkMaxDuration = var_435_10

					if var_435_10 + var_435_5 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_10 + var_435_5
					end
				end

				arg_432_1.text_.text = var_435_8
				arg_432_1.typewritter.percent = 0

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413041", "413041106", "story_v_out_413041.awb") ~= 0 then
					local var_435_11 = manager.audio:GetVoiceLength("story_v_out_413041", "413041106", "story_v_out_413041.awb") / 1000

					if var_435_11 + var_435_5 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_11 + var_435_5
					end

					if var_435_7.prefab_name ~= "" and arg_432_1.actors_[var_435_7.prefab_name] ~= nil then
						local var_435_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_432_1.actors_[var_435_7.prefab_name].transform, "story_v_out_413041", "413041106", "story_v_out_413041.awb")

						arg_432_1:RecordAudio("413041106", var_435_12)
						arg_432_1:RecordAudio("413041106", var_435_12)
					else
						arg_432_1:AudioAction("play", "voice", "story_v_out_413041", "413041106", "story_v_out_413041.awb")
					end

					arg_432_1:RecordHistoryTalkVoice("story_v_out_413041", "413041106", "story_v_out_413041.awb")
				end

				arg_432_1:RecordContent(arg_432_1.text_.text)
			end

			local var_435_13 = math.max(var_435_6, arg_432_1.talkMaxDuration)

			if var_435_5 <= arg_432_1.time_ and arg_432_1.time_ < var_435_5 + var_435_13 then
				arg_432_1.typewritter.percent = (arg_432_1.time_ - var_435_5) / var_435_13

				arg_432_1.typewritter:SetDirty()
			end

			if arg_432_1.time_ >= var_435_5 + var_435_13 and arg_432_1.time_ < var_435_5 + var_435_13 + arg_435_0 then
				arg_432_1.typewritter.percent = 1

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(true)
			end
		end

		arg_432_1.nodeConfigList_ = {}

		arg_432_1:InitPlayNodeList()
	end,
	Play413041107 = function(arg_436_0, arg_436_1)
		arg_436_1.time_ = 0
		arg_436_1.frameCnt_ = 0
		arg_436_1.state_ = "playing"
		arg_436_1.curTalkId_ = 413041107
		arg_436_1.duration_ = 5.3

		local var_436_0 = {
			zh = 2.9,
			ja = 5.3
		}
		local var_436_1 = manager.audio:GetLocalizationFlag()

		if var_436_0[var_436_1] ~= nil then
			arg_436_1.duration_ = var_436_0[var_436_1]
		end

		SetActive(arg_436_1.tipsGo_, false)

		function arg_436_1.onSingleLineFinish_()
			arg_436_1.onSingleLineUpdate_ = nil
			arg_436_1.onSingleLineFinish_ = nil
			arg_436_1.state_ = "waiting"
		end

		function arg_436_1.playNext_(arg_438_0)
			if arg_438_0 == 1 then
				arg_436_0:Play413041108(arg_436_1)
			end
		end

		function arg_436_1.onSingleLineUpdate_(arg_439_0)
			local var_439_0 = 0.375

			if 0 < arg_436_1.time_ and arg_436_1.time_ <= 0 + arg_439_0 then
				arg_436_1.talkMaxDuration = 0
				arg_436_1.dialogCg_.alpha = 1

				arg_436_1.dialog_:SetActive(true)
				SetActive(arg_436_1.leftNameGo_, true)

				arg_436_1.leftNameTxt_.text = arg_436_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_436_1.leftNameTxt_.transform)

				arg_436_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_436_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_436_1:RecordName(arg_436_1.leftNameTxt_.text)
				SetActive(arg_436_1.iconTrs_.gameObject, false)
				arg_436_1.callingController_:SetSelectedState("normal")

				local var_439_1 = arg_436_1:GetWordFromCfg(413041107)
				local var_439_2 = arg_436_1:FormatText(var_439_1.content)

				arg_436_1.text_.text = var_439_2

				LuaForUtil.ClearLinePrefixSymbol(arg_436_1.text_)

				local var_439_4 = 15 <= 0 and var_439_0 or var_439_0 * (utf8.len(var_439_2) / 15)

				if (15 <= 0 and var_439_0 or var_439_0 * (utf8.len(var_439_2) / 15)) > 0 and var_439_0 < var_439_4 then
					arg_436_1.talkMaxDuration = var_439_4

					if var_439_4 + 0 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_4 + 0
					end
				end

				arg_436_1.text_.text = var_439_2
				arg_436_1.typewritter.percent = 0

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413041", "413041107", "story_v_out_413041.awb") ~= 0 then
					local var_439_5 = manager.audio:GetVoiceLength("story_v_out_413041", "413041107", "story_v_out_413041.awb") / 1000

					if var_439_5 + 0 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_5 + 0
					end

					if var_439_1.prefab_name ~= "" and arg_436_1.actors_[var_439_1.prefab_name] ~= nil then
						local var_439_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_436_1.actors_[var_439_1.prefab_name].transform, "story_v_out_413041", "413041107", "story_v_out_413041.awb")

						arg_436_1:RecordAudio("413041107", var_439_6)
						arg_436_1:RecordAudio("413041107", var_439_6)
					else
						arg_436_1:AudioAction("play", "voice", "story_v_out_413041", "413041107", "story_v_out_413041.awb")
					end

					arg_436_1:RecordHistoryTalkVoice("story_v_out_413041", "413041107", "story_v_out_413041.awb")
				end

				arg_436_1:RecordContent(arg_436_1.text_.text)
			end

			local var_439_7 = math.max(var_439_0, arg_436_1.talkMaxDuration)

			if 0 <= arg_436_1.time_ and arg_436_1.time_ < 0 + var_439_7 then
				arg_436_1.typewritter.percent = (arg_436_1.time_ - 0) / var_439_7

				arg_436_1.typewritter:SetDirty()
			end

			if arg_436_1.time_ >= 0 + var_439_7 and arg_436_1.time_ < 0 + var_439_7 + arg_439_0 then
				arg_436_1.typewritter.percent = 1

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(true)
			end
		end

		arg_436_1.nodeConfigList_ = {}

		arg_436_1:InitPlayNodeList()
	end,
	Play413041108 = function(arg_440_0, arg_440_1)
		arg_440_1.time_ = 0
		arg_440_1.frameCnt_ = 0
		arg_440_1.state_ = "playing"
		arg_440_1.curTalkId_ = 413041108
		arg_440_1.duration_ = 4.3

		local var_440_0 = {
			zh = 3.8,
			ja = 4.3
		}
		local var_440_1 = manager.audio:GetLocalizationFlag()

		if var_440_0[var_440_1] ~= nil then
			arg_440_1.duration_ = var_440_0[var_440_1]
		end

		SetActive(arg_440_1.tipsGo_, false)

		function arg_440_1.onSingleLineFinish_()
			arg_440_1.onSingleLineUpdate_ = nil
			arg_440_1.onSingleLineFinish_ = nil
			arg_440_1.state_ = "waiting"
		end

		function arg_440_1.playNext_(arg_442_0)
			if arg_442_0 == 1 then
				arg_440_0:Play413041109(arg_440_1)
			end
		end

		function arg_440_1.onSingleLineUpdate_(arg_443_0)
			if 0 < arg_440_1.time_ and arg_440_1.time_ <= 0 + arg_443_0 then
				arg_440_1.var_.moveOldPos10094 = arg_440_1.actors_["10094"].transform.localPosition
				arg_440_1.actors_["10094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_440_1:CheckSpriteTmpPos("10094", 4)

				for iter_443_0 = 0, arg_440_1.actors_["10094"].transform.childCount - 1 do
					local var_443_0 = arg_440_1.actors_["10094"].transform:GetChild(iter_443_0)

					if var_443_0.name == "" or not string.find(var_443_0.name, "split") then
						var_443_0.gameObject:SetActive(true)
					else
						var_443_0.gameObject:SetActive(false)
					end
				end
			end

			local var_443_1 = 0.001

			if 0 <= arg_440_1.time_ and arg_440_1.time_ < 0 + var_443_1 then
				arg_440_1.actors_["10094"].transform.localPosition = Vector3.Lerp(arg_440_1.var_.moveOldPos10094, Vector3.New(390, -340, -414), (arg_440_1.time_ - 0) / var_443_1)
			end

			if arg_440_1.time_ >= 0 + var_443_1 and arg_440_1.time_ < 0 + var_443_1 + arg_443_0 then
				arg_440_1.actors_["10094"].transform.localPosition = Vector3.New(390, -340, -414)
			end

			local var_443_2 = arg_440_1.actors_["10022"].transform

			if 0 < arg_440_1.time_ and arg_440_1.time_ <= 0 + arg_443_0 then
				arg_440_1.var_.moveOldPos10022 = var_443_2.localPosition
				var_443_2.localScale = Vector3.New(1, 1, 1)

				arg_440_1:CheckSpriteTmpPos("10022", 2)

				for iter_443_1 = 0, var_443_2.childCount - 1 do
					local var_443_3 = var_443_2:GetChild(iter_443_1)

					if var_443_3.name == "" or not string.find(var_443_3.name, "split") then
						var_443_3.gameObject:SetActive(true)
					else
						var_443_3.gameObject:SetActive(false)
					end
				end
			end

			local var_443_4 = 0.001

			if 0 <= arg_440_1.time_ and arg_440_1.time_ < 0 + var_443_4 then
				var_443_2.localPosition = Vector3.Lerp(arg_440_1.var_.moveOldPos10022, Vector3.New(-390, -315, -320), (arg_440_1.time_ - 0) / var_443_4)
			end

			if arg_440_1.time_ >= 0 + var_443_4 and arg_440_1.time_ < 0 + var_443_4 + arg_443_0 then
				var_443_2.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_443_5 = arg_440_1.actors_["10094"]

			if 0 < arg_440_1.time_ and arg_440_1.time_ <= 0 + arg_443_0 and not isNil(var_443_5) and arg_440_1.var_.actorSpriteComps10094 == nil then
				arg_440_1.var_.actorSpriteComps10094 = var_443_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_443_6 = 2

			if 0 <= arg_440_1.time_ and arg_440_1.time_ < 0 + var_443_6 and not isNil(var_443_5) then
				if arg_440_1.var_.actorSpriteComps10094 then
					for iter_443_2, iter_443_3 in pairs(arg_440_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_443_3 then
							if arg_440_1.isInRecall_ then
								iter_443_3.color = Color.New(Mathf.Lerp(iter_443_3.color.r, arg_440_1.hightColor2.r, (arg_440_1.time_ - 0) / var_443_6), Mathf.Lerp(iter_443_3.color.g, arg_440_1.hightColor2.g, (arg_440_1.time_ - 0) / var_443_6), (Mathf.Lerp(iter_443_3.color.b, arg_440_1.hightColor2.b, (arg_440_1.time_ - 0) / var_443_6)))
							else
								local var_443_7 = Mathf.Lerp(iter_443_3.color.r, 0.5, (arg_440_1.time_ - 0) / var_443_6)

								iter_443_3.color = Color.New(var_443_7, var_443_7, var_443_7)
							end
						end
					end
				end
			end

			if arg_440_1.time_ >= 0 + var_443_6 and arg_440_1.time_ < 0 + var_443_6 + arg_443_0 and not isNil(var_443_5) and arg_440_1.var_.actorSpriteComps10094 then
				for iter_443_4, iter_443_5 in pairs(arg_440_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_443_5 then
						iter_443_5.color = arg_440_1.isInRecall_ and (arg_440_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_440_1.var_.actorSpriteComps10094 = nil
			end

			local var_443_8 = arg_440_1.actors_["10022"]

			if 0 < arg_440_1.time_ and arg_440_1.time_ <= 0 + arg_443_0 and not isNil(var_443_8) and arg_440_1.var_.actorSpriteComps10022 == nil then
				arg_440_1.var_.actorSpriteComps10022 = var_443_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_443_9 = 2

			if 0 <= arg_440_1.time_ and arg_440_1.time_ < 0 + var_443_9 and not isNil(var_443_8) then
				if arg_440_1.var_.actorSpriteComps10022 then
					for iter_443_6, iter_443_7 in pairs(arg_440_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_443_7 then
							if arg_440_1.isInRecall_ then
								iter_443_7.color = Color.New(Mathf.Lerp(iter_443_7.color.r, arg_440_1.hightColor1.r, (arg_440_1.time_ - 0) / var_443_9), Mathf.Lerp(iter_443_7.color.g, arg_440_1.hightColor1.g, (arg_440_1.time_ - 0) / var_443_9), (Mathf.Lerp(iter_443_7.color.b, arg_440_1.hightColor1.b, (arg_440_1.time_ - 0) / var_443_9)))
							else
								local var_443_10 = Mathf.Lerp(iter_443_7.color.r, 1, (arg_440_1.time_ - 0) / var_443_9)

								iter_443_7.color = Color.New(var_443_10, var_443_10, var_443_10)
							end
						end
					end
				end
			end

			if arg_440_1.time_ >= 0 + var_443_9 and arg_440_1.time_ < 0 + var_443_9 + arg_443_0 and not isNil(var_443_8) and arg_440_1.var_.actorSpriteComps10022 then
				for iter_443_8, iter_443_9 in pairs(arg_440_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_443_9 then
						iter_443_9.color = arg_440_1.isInRecall_ and (arg_440_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_440_1.var_.actorSpriteComps10022 = nil
			end

			local var_443_11 = 0
			local var_443_12 = 0.4

			if 0 < arg_440_1.time_ and arg_440_1.time_ <= var_443_11 + arg_443_0 then
				arg_440_1.talkMaxDuration = 0
				arg_440_1.dialogCg_.alpha = 1

				arg_440_1.dialog_:SetActive(true)
				SetActive(arg_440_1.leftNameGo_, true)

				arg_440_1.leftNameTxt_.text = arg_440_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_440_1.leftNameTxt_.transform)

				arg_440_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_440_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_440_1:RecordName(arg_440_1.leftNameTxt_.text)
				SetActive(arg_440_1.iconTrs_.gameObject, false)
				arg_440_1.callingController_:SetSelectedState("normal")

				local var_443_13 = arg_440_1:GetWordFromCfg(413041108)
				local var_443_14 = arg_440_1:FormatText(var_443_13.content)

				arg_440_1.text_.text = var_443_14

				LuaForUtil.ClearLinePrefixSymbol(arg_440_1.text_)

				local var_443_16 = 16 <= 0 and var_443_12 or var_443_12 * (utf8.len(var_443_14) / 16)

				if (16 <= 0 and var_443_12 or var_443_12 * (utf8.len(var_443_14) / 16)) > 0 and var_443_12 < var_443_16 then
					arg_440_1.talkMaxDuration = var_443_16

					if var_443_16 + var_443_11 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_16 + var_443_11
					end
				end

				arg_440_1.text_.text = var_443_14
				arg_440_1.typewritter.percent = 0

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413041", "413041108", "story_v_out_413041.awb") ~= 0 then
					local var_443_17 = manager.audio:GetVoiceLength("story_v_out_413041", "413041108", "story_v_out_413041.awb") / 1000

					if var_443_17 + var_443_11 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_17 + var_443_11
					end

					if var_443_13.prefab_name ~= "" and arg_440_1.actors_[var_443_13.prefab_name] ~= nil then
						local var_443_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_440_1.actors_[var_443_13.prefab_name].transform, "story_v_out_413041", "413041108", "story_v_out_413041.awb")

						arg_440_1:RecordAudio("413041108", var_443_18)
						arg_440_1:RecordAudio("413041108", var_443_18)
					else
						arg_440_1:AudioAction("play", "voice", "story_v_out_413041", "413041108", "story_v_out_413041.awb")
					end

					arg_440_1:RecordHistoryTalkVoice("story_v_out_413041", "413041108", "story_v_out_413041.awb")
				end

				arg_440_1:RecordContent(arg_440_1.text_.text)
			end

			local var_443_19 = math.max(var_443_12, arg_440_1.talkMaxDuration)

			if var_443_11 <= arg_440_1.time_ and arg_440_1.time_ < var_443_11 + var_443_19 then
				arg_440_1.typewritter.percent = (arg_440_1.time_ - var_443_11) / var_443_19

				arg_440_1.typewritter:SetDirty()
			end

			if arg_440_1.time_ >= var_443_11 + var_443_19 and arg_440_1.time_ < var_443_11 + var_443_19 + arg_443_0 then
				arg_440_1.typewritter.percent = 1

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(true)
			end
		end

		arg_440_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_440_1:InitPlayNodeList()
	end,
	Play413041109 = function(arg_444_0, arg_444_1)
		arg_444_1.time_ = 0
		arg_444_1.frameCnt_ = 0
		arg_444_1.state_ = "playing"
		arg_444_1.curTalkId_ = 413041109
		arg_444_1.duration_ = 11.47

		local var_444_0 = {
			zh = 7.233,
			ja = 11.466
		}
		local var_444_1 = manager.audio:GetLocalizationFlag()

		if var_444_0[var_444_1] ~= nil then
			arg_444_1.duration_ = var_444_0[var_444_1]
		end

		SetActive(arg_444_1.tipsGo_, false)

		function arg_444_1.onSingleLineFinish_()
			arg_444_1.onSingleLineUpdate_ = nil
			arg_444_1.onSingleLineFinish_ = nil
			arg_444_1.state_ = "waiting"
		end

		function arg_444_1.playNext_(arg_446_0)
			if arg_446_0 == 1 then
				arg_444_0:Play413041110(arg_444_1)
			end
		end

		function arg_444_1.onSingleLineUpdate_(arg_447_0)
			if 0 < arg_444_1.time_ and arg_444_1.time_ <= 0 + arg_447_0 and not isNil(arg_444_1.actors_["10094"]) and arg_444_1.var_.actorSpriteComps10094 == nil then
				arg_444_1.var_.actorSpriteComps10094 = arg_444_1.actors_["10094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_447_0 = 2

			if 0 <= arg_444_1.time_ and arg_444_1.time_ < 0 + var_447_0 and not isNil(arg_444_1.actors_["10094"]) then
				if arg_444_1.var_.actorSpriteComps10094 then
					for iter_447_0, iter_447_1 in pairs(arg_444_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_447_1 then
							if arg_444_1.isInRecall_ then
								iter_447_1.color = Color.New(Mathf.Lerp(iter_447_1.color.r, arg_444_1.hightColor1.r, (arg_444_1.time_ - 0) / var_447_0), Mathf.Lerp(iter_447_1.color.g, arg_444_1.hightColor1.g, (arg_444_1.time_ - 0) / var_447_0), (Mathf.Lerp(iter_447_1.color.b, arg_444_1.hightColor1.b, (arg_444_1.time_ - 0) / var_447_0)))
							else
								local var_447_1 = Mathf.Lerp(iter_447_1.color.r, 1, (arg_444_1.time_ - 0) / var_447_0)

								iter_447_1.color = Color.New(var_447_1, var_447_1, var_447_1)
							end
						end
					end
				end
			end

			if arg_444_1.time_ >= 0 + var_447_0 and arg_444_1.time_ < 0 + var_447_0 + arg_447_0 and not isNil(arg_444_1.actors_["10094"]) and arg_444_1.var_.actorSpriteComps10094 then
				for iter_447_2, iter_447_3 in pairs(arg_444_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_447_3 then
						iter_447_3.color = arg_444_1.isInRecall_ and (arg_444_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_444_1.var_.actorSpriteComps10094 = nil
			end

			local var_447_2 = arg_444_1.actors_["10022"]

			if 0 < arg_444_1.time_ and arg_444_1.time_ <= 0 + arg_447_0 and not isNil(var_447_2) and arg_444_1.var_.actorSpriteComps10022 == nil then
				arg_444_1.var_.actorSpriteComps10022 = var_447_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_447_3 = 2

			if 0 <= arg_444_1.time_ and arg_444_1.time_ < 0 + var_447_3 and not isNil(var_447_2) then
				if arg_444_1.var_.actorSpriteComps10022 then
					for iter_447_4, iter_447_5 in pairs(arg_444_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_447_5 then
							if arg_444_1.isInRecall_ then
								iter_447_5.color = Color.New(Mathf.Lerp(iter_447_5.color.r, arg_444_1.hightColor2.r, (arg_444_1.time_ - 0) / var_447_3), Mathf.Lerp(iter_447_5.color.g, arg_444_1.hightColor2.g, (arg_444_1.time_ - 0) / var_447_3), (Mathf.Lerp(iter_447_5.color.b, arg_444_1.hightColor2.b, (arg_444_1.time_ - 0) / var_447_3)))
							else
								local var_447_4 = Mathf.Lerp(iter_447_5.color.r, 0.5, (arg_444_1.time_ - 0) / var_447_3)

								iter_447_5.color = Color.New(var_447_4, var_447_4, var_447_4)
							end
						end
					end
				end
			end

			if arg_444_1.time_ >= 0 + var_447_3 and arg_444_1.time_ < 0 + var_447_3 + arg_447_0 and not isNil(var_447_2) and arg_444_1.var_.actorSpriteComps10022 then
				for iter_447_6, iter_447_7 in pairs(arg_444_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_447_7 then
						iter_447_7.color = arg_444_1.isInRecall_ and (arg_444_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_444_1.var_.actorSpriteComps10022 = nil
			end

			local var_447_5 = 0
			local var_447_6 = 0.8

			if 0 < arg_444_1.time_ and arg_444_1.time_ <= var_447_5 + arg_447_0 then
				arg_444_1.talkMaxDuration = 0
				arg_444_1.dialogCg_.alpha = 1

				arg_444_1.dialog_:SetActive(true)
				SetActive(arg_444_1.leftNameGo_, true)

				arg_444_1.leftNameTxt_.text = arg_444_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_444_1.leftNameTxt_.transform)

				arg_444_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_444_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_444_1:RecordName(arg_444_1.leftNameTxt_.text)
				SetActive(arg_444_1.iconTrs_.gameObject, false)
				arg_444_1.callingController_:SetSelectedState("normal")

				local var_447_7 = arg_444_1:GetWordFromCfg(413041109)
				local var_447_8 = arg_444_1:FormatText(var_447_7.content)

				arg_444_1.text_.text = var_447_8

				LuaForUtil.ClearLinePrefixSymbol(arg_444_1.text_)

				local var_447_10 = 32 <= 0 and var_447_6 or var_447_6 * (utf8.len(var_447_8) / 32)

				if (32 <= 0 and var_447_6 or var_447_6 * (utf8.len(var_447_8) / 32)) > 0 and var_447_6 < var_447_10 then
					arg_444_1.talkMaxDuration = var_447_10

					if var_447_10 + var_447_5 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_10 + var_447_5
					end
				end

				arg_444_1.text_.text = var_447_8
				arg_444_1.typewritter.percent = 0

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413041", "413041109", "story_v_out_413041.awb") ~= 0 then
					local var_447_11 = manager.audio:GetVoiceLength("story_v_out_413041", "413041109", "story_v_out_413041.awb") / 1000

					if var_447_11 + var_447_5 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_11 + var_447_5
					end

					if var_447_7.prefab_name ~= "" and arg_444_1.actors_[var_447_7.prefab_name] ~= nil then
						local var_447_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_444_1.actors_[var_447_7.prefab_name].transform, "story_v_out_413041", "413041109", "story_v_out_413041.awb")

						arg_444_1:RecordAudio("413041109", var_447_12)
						arg_444_1:RecordAudio("413041109", var_447_12)
					else
						arg_444_1:AudioAction("play", "voice", "story_v_out_413041", "413041109", "story_v_out_413041.awb")
					end

					arg_444_1:RecordHistoryTalkVoice("story_v_out_413041", "413041109", "story_v_out_413041.awb")
				end

				arg_444_1:RecordContent(arg_444_1.text_.text)
			end

			local var_447_13 = math.max(var_447_6, arg_444_1.talkMaxDuration)

			if var_447_5 <= arg_444_1.time_ and arg_444_1.time_ < var_447_5 + var_447_13 then
				arg_444_1.typewritter.percent = (arg_444_1.time_ - var_447_5) / var_447_13

				arg_444_1.typewritter:SetDirty()
			end

			if arg_444_1.time_ >= var_447_5 + var_447_13 and arg_444_1.time_ < var_447_5 + var_447_13 + arg_447_0 then
				arg_444_1.typewritter.percent = 1

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(true)
			end
		end

		arg_444_1.nodeConfigList_ = {}

		arg_444_1:InitPlayNodeList()
	end,
	Play413041110 = function(arg_448_0, arg_448_1)
		arg_448_1.time_ = 0
		arg_448_1.frameCnt_ = 0
		arg_448_1.state_ = "playing"
		arg_448_1.curTalkId_ = 413041110
		arg_448_1.duration_ = 4.8

		local var_448_0 = {
			zh = 3.6,
			ja = 4.8
		}
		local var_448_1 = manager.audio:GetLocalizationFlag()

		if var_448_0[var_448_1] ~= nil then
			arg_448_1.duration_ = var_448_0[var_448_1]
		end

		SetActive(arg_448_1.tipsGo_, false)

		function arg_448_1.onSingleLineFinish_()
			arg_448_1.onSingleLineUpdate_ = nil
			arg_448_1.onSingleLineFinish_ = nil
			arg_448_1.state_ = "waiting"
		end

		function arg_448_1.playNext_(arg_450_0)
			if arg_450_0 == 1 then
				arg_448_0:Play413041111(arg_448_1)
			end
		end

		function arg_448_1.onSingleLineUpdate_(arg_451_0)
			if 0 < arg_448_1.time_ and arg_448_1.time_ <= 0 + arg_451_0 then
				arg_448_1.var_.moveOldPos10022 = arg_448_1.actors_["10022"].transform.localPosition
				arg_448_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_448_1:CheckSpriteTmpPos("10022", 2)

				for iter_451_0 = 0, arg_448_1.actors_["10022"].transform.childCount - 1 do
					local var_451_0 = arg_448_1.actors_["10022"].transform:GetChild(iter_451_0)

					if var_451_0.name == "split_8" or not string.find(var_451_0.name, "split") then
						var_451_0.gameObject:SetActive(true)
					else
						var_451_0.gameObject:SetActive(false)
					end
				end
			end

			local var_451_1 = 0.001

			if 0 <= arg_448_1.time_ and arg_448_1.time_ < 0 + var_451_1 then
				arg_448_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_448_1.var_.moveOldPos10022, Vector3.New(-390, -315, -320), (arg_448_1.time_ - 0) / var_451_1)
			end

			if arg_448_1.time_ >= 0 + var_451_1 and arg_448_1.time_ < 0 + var_451_1 + arg_451_0 then
				arg_448_1.actors_["10022"].transform.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_451_2 = arg_448_1.actors_["10094"]

			if 0 < arg_448_1.time_ and arg_448_1.time_ <= 0 + arg_451_0 and not isNil(var_451_2) and arg_448_1.var_.actorSpriteComps10094 == nil then
				arg_448_1.var_.actorSpriteComps10094 = var_451_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_451_3 = 2

			if 0 <= arg_448_1.time_ and arg_448_1.time_ < 0 + var_451_3 and not isNil(var_451_2) then
				if arg_448_1.var_.actorSpriteComps10094 then
					for iter_451_1, iter_451_2 in pairs(arg_448_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_451_2 then
							if arg_448_1.isInRecall_ then
								iter_451_2.color = Color.New(Mathf.Lerp(iter_451_2.color.r, arg_448_1.hightColor2.r, (arg_448_1.time_ - 0) / var_451_3), Mathf.Lerp(iter_451_2.color.g, arg_448_1.hightColor2.g, (arg_448_1.time_ - 0) / var_451_3), (Mathf.Lerp(iter_451_2.color.b, arg_448_1.hightColor2.b, (arg_448_1.time_ - 0) / var_451_3)))
							else
								local var_451_4 = Mathf.Lerp(iter_451_2.color.r, 0.5, (arg_448_1.time_ - 0) / var_451_3)

								iter_451_2.color = Color.New(var_451_4, var_451_4, var_451_4)
							end
						end
					end
				end
			end

			if arg_448_1.time_ >= 0 + var_451_3 and arg_448_1.time_ < 0 + var_451_3 + arg_451_0 and not isNil(var_451_2) and arg_448_1.var_.actorSpriteComps10094 then
				for iter_451_3, iter_451_4 in pairs(arg_448_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_451_4 then
						iter_451_4.color = arg_448_1.isInRecall_ and (arg_448_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_448_1.var_.actorSpriteComps10094 = nil
			end

			local var_451_5 = arg_448_1.actors_["10022"]

			if 0 < arg_448_1.time_ and arg_448_1.time_ <= 0 + arg_451_0 and not isNil(var_451_5) and arg_448_1.var_.actorSpriteComps10022 == nil then
				arg_448_1.var_.actorSpriteComps10022 = var_451_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_451_6 = 2

			if 0 <= arg_448_1.time_ and arg_448_1.time_ < 0 + var_451_6 and not isNil(var_451_5) then
				if arg_448_1.var_.actorSpriteComps10022 then
					for iter_451_5, iter_451_6 in pairs(arg_448_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_451_6 then
							if arg_448_1.isInRecall_ then
								iter_451_6.color = Color.New(Mathf.Lerp(iter_451_6.color.r, arg_448_1.hightColor1.r, (arg_448_1.time_ - 0) / var_451_6), Mathf.Lerp(iter_451_6.color.g, arg_448_1.hightColor1.g, (arg_448_1.time_ - 0) / var_451_6), (Mathf.Lerp(iter_451_6.color.b, arg_448_1.hightColor1.b, (arg_448_1.time_ - 0) / var_451_6)))
							else
								local var_451_7 = Mathf.Lerp(iter_451_6.color.r, 1, (arg_448_1.time_ - 0) / var_451_6)

								iter_451_6.color = Color.New(var_451_7, var_451_7, var_451_7)
							end
						end
					end
				end
			end

			if arg_448_1.time_ >= 0 + var_451_6 and arg_448_1.time_ < 0 + var_451_6 + arg_451_0 and not isNil(var_451_5) and arg_448_1.var_.actorSpriteComps10022 then
				for iter_451_7, iter_451_8 in pairs(arg_448_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_451_8 then
						iter_451_8.color = arg_448_1.isInRecall_ and (arg_448_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_448_1.var_.actorSpriteComps10022 = nil
			end

			local var_451_8 = 0
			local var_451_9 = 0.25

			if 0 < arg_448_1.time_ and arg_448_1.time_ <= var_451_8 + arg_451_0 then
				arg_448_1.talkMaxDuration = 0
				arg_448_1.dialogCg_.alpha = 1

				arg_448_1.dialog_:SetActive(true)
				SetActive(arg_448_1.leftNameGo_, true)

				arg_448_1.leftNameTxt_.text = arg_448_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_448_1.leftNameTxt_.transform)

				arg_448_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_448_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_448_1:RecordName(arg_448_1.leftNameTxt_.text)
				SetActive(arg_448_1.iconTrs_.gameObject, false)
				arg_448_1.callingController_:SetSelectedState("normal")

				local var_451_10 = arg_448_1:GetWordFromCfg(413041110)
				local var_451_11 = arg_448_1:FormatText(var_451_10.content)

				arg_448_1.text_.text = var_451_11

				LuaForUtil.ClearLinePrefixSymbol(arg_448_1.text_)

				local var_451_13 = 10 <= 0 and var_451_9 or var_451_9 * (utf8.len(var_451_11) / 10)

				if (10 <= 0 and var_451_9 or var_451_9 * (utf8.len(var_451_11) / 10)) > 0 and var_451_9 < var_451_13 then
					arg_448_1.talkMaxDuration = var_451_13

					if var_451_13 + var_451_8 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_13 + var_451_8
					end
				end

				arg_448_1.text_.text = var_451_11
				arg_448_1.typewritter.percent = 0

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413041", "413041110", "story_v_out_413041.awb") ~= 0 then
					local var_451_14 = manager.audio:GetVoiceLength("story_v_out_413041", "413041110", "story_v_out_413041.awb") / 1000

					if var_451_14 + var_451_8 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_14 + var_451_8
					end

					if var_451_10.prefab_name ~= "" and arg_448_1.actors_[var_451_10.prefab_name] ~= nil then
						local var_451_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_448_1.actors_[var_451_10.prefab_name].transform, "story_v_out_413041", "413041110", "story_v_out_413041.awb")

						arg_448_1:RecordAudio("413041110", var_451_15)
						arg_448_1:RecordAudio("413041110", var_451_15)
					else
						arg_448_1:AudioAction("play", "voice", "story_v_out_413041", "413041110", "story_v_out_413041.awb")
					end

					arg_448_1:RecordHistoryTalkVoice("story_v_out_413041", "413041110", "story_v_out_413041.awb")
				end

				arg_448_1:RecordContent(arg_448_1.text_.text)
			end

			local var_451_16 = math.max(var_451_9, arg_448_1.talkMaxDuration)

			if var_451_8 <= arg_448_1.time_ and arg_448_1.time_ < var_451_8 + var_451_16 then
				arg_448_1.typewritter.percent = (arg_448_1.time_ - var_451_8) / var_451_16

				arg_448_1.typewritter:SetDirty()
			end

			if arg_448_1.time_ >= var_451_8 + var_451_16 and arg_448_1.time_ < var_451_8 + var_451_16 + arg_451_0 then
				arg_448_1.typewritter.percent = 1

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(true)
			end
		end

		arg_448_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_448_1:InitPlayNodeList()
	end,
	Play413041111 = function(arg_452_0, arg_452_1)
		arg_452_1.time_ = 0
		arg_452_1.frameCnt_ = 0
		arg_452_1.state_ = "playing"
		arg_452_1.curTalkId_ = 413041111
		arg_452_1.duration_ = 5

		SetActive(arg_452_1.tipsGo_, false)

		function arg_452_1.onSingleLineFinish_()
			arg_452_1.onSingleLineUpdate_ = nil
			arg_452_1.onSingleLineFinish_ = nil
			arg_452_1.state_ = "waiting"
		end

		function arg_452_1.playNext_(arg_454_0)
			if arg_454_0 == 1 then
				arg_452_0:Play413041112(arg_452_1)
			end
		end

		function arg_452_1.onSingleLineUpdate_(arg_455_0)
			if 0 < arg_452_1.time_ and arg_452_1.time_ <= 0 + arg_455_0 and not isNil(arg_452_1.actors_["10022"]) and arg_452_1.var_.actorSpriteComps10022 == nil then
				arg_452_1.var_.actorSpriteComps10022 = arg_452_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_455_0 = 2

			if 0 <= arg_452_1.time_ and arg_452_1.time_ < 0 + var_455_0 and not isNil(arg_452_1.actors_["10022"]) then
				if arg_452_1.var_.actorSpriteComps10022 then
					for iter_455_0, iter_455_1 in pairs(arg_452_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_455_1 then
							if arg_452_1.isInRecall_ then
								iter_455_1.color = Color.New(Mathf.Lerp(iter_455_1.color.r, arg_452_1.hightColor2.r, (arg_452_1.time_ - 0) / var_455_0), Mathf.Lerp(iter_455_1.color.g, arg_452_1.hightColor2.g, (arg_452_1.time_ - 0) / var_455_0), (Mathf.Lerp(iter_455_1.color.b, arg_452_1.hightColor2.b, (arg_452_1.time_ - 0) / var_455_0)))
							else
								local var_455_1 = Mathf.Lerp(iter_455_1.color.r, 0.5, (arg_452_1.time_ - 0) / var_455_0)

								iter_455_1.color = Color.New(var_455_1, var_455_1, var_455_1)
							end
						end
					end
				end
			end

			if arg_452_1.time_ >= 0 + var_455_0 and arg_452_1.time_ < 0 + var_455_0 + arg_455_0 and not isNil(arg_452_1.actors_["10022"]) and arg_452_1.var_.actorSpriteComps10022 then
				for iter_455_2, iter_455_3 in pairs(arg_452_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_455_3 then
						iter_455_3.color = arg_452_1.isInRecall_ and (arg_452_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_452_1.var_.actorSpriteComps10022 = nil
			end

			if 0.166666666666667 < arg_452_1.time_ and arg_452_1.time_ <= 0.166666666666667 + arg_455_0 then
				arg_452_1:AudioAction("play", "effect", "se_story", "se_story_alarmloop", "")
			end

			local var_455_3 = 0
			local var_455_4 = 1.2

			if 0 < arg_452_1.time_ and arg_452_1.time_ <= var_455_3 + arg_455_0 then
				arg_452_1.talkMaxDuration = 0
				arg_452_1.dialogCg_.alpha = 1

				arg_452_1.dialog_:SetActive(true)
				SetActive(arg_452_1.leftNameGo_, false)

				arg_452_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_452_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_452_1:RecordName(arg_452_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_452_1.iconTrs_.gameObject, false)
				arg_452_1.callingController_:SetSelectedState("normal")

				local var_455_5 = arg_452_1:FormatText(arg_452_1:GetWordFromCfg(413041111).content)

				arg_452_1.text_.text = var_455_5

				LuaForUtil.ClearLinePrefixSymbol(arg_452_1.text_)

				local var_455_7 = 48 <= 0 and var_455_4 or var_455_4 * (utf8.len(var_455_5) / 48)

				if (48 <= 0 and var_455_4 or var_455_4 * (utf8.len(var_455_5) / 48)) > 0 and var_455_4 < var_455_7 then
					arg_452_1.talkMaxDuration = var_455_7

					if var_455_7 + var_455_3 > arg_452_1.duration_ then
						arg_452_1.duration_ = var_455_7 + var_455_3
					end
				end

				arg_452_1.text_.text = var_455_5
				arg_452_1.typewritter.percent = 0

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(false)
				arg_452_1:RecordContent(arg_452_1.text_.text)
			end

			local var_455_8 = math.max(var_455_4, arg_452_1.talkMaxDuration)

			if var_455_3 <= arg_452_1.time_ and arg_452_1.time_ < var_455_3 + var_455_8 then
				arg_452_1.typewritter.percent = (arg_452_1.time_ - var_455_3) / var_455_8

				arg_452_1.typewritter:SetDirty()
			end

			if arg_452_1.time_ >= var_455_3 + var_455_8 and arg_452_1.time_ < var_455_3 + var_455_8 + arg_455_0 then
				arg_452_1.typewritter.percent = 1

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(true)
			end
		end

		arg_452_1.nodeConfigList_ = {}

		arg_452_1:InitPlayNodeList()
	end,
	Play413041112 = function(arg_456_0, arg_456_1)
		arg_456_1.time_ = 0
		arg_456_1.frameCnt_ = 0
		arg_456_1.state_ = "playing"
		arg_456_1.curTalkId_ = 413041112
		arg_456_1.duration_ = 2.67

		local var_456_0 = {
			zh = 1.999999999999,
			ja = 2.666
		}
		local var_456_1 = manager.audio:GetLocalizationFlag()

		if var_456_0[var_456_1] ~= nil then
			arg_456_1.duration_ = var_456_0[var_456_1]
		end

		SetActive(arg_456_1.tipsGo_, false)

		function arg_456_1.onSingleLineFinish_()
			arg_456_1.onSingleLineUpdate_ = nil
			arg_456_1.onSingleLineFinish_ = nil
			arg_456_1.state_ = "waiting"
			arg_456_1.auto_ = false
		end

		function arg_456_1.playNext_(arg_458_0)
			arg_456_1.onStoryFinished_()
		end

		function arg_456_1.onSingleLineUpdate_(arg_459_0)
			if 0 < arg_456_1.time_ and arg_456_1.time_ <= 0 + arg_459_0 then
				arg_456_1.var_.moveOldPos10022 = arg_456_1.actors_["10022"].transform.localPosition
				arg_456_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_456_1:CheckSpriteTmpPos("10022", 2)

				for iter_459_0 = 0, arg_456_1.actors_["10022"].transform.childCount - 1 do
					local var_459_0 = arg_456_1.actors_["10022"].transform:GetChild(iter_459_0)

					if var_459_0.name == "split_6" or not string.find(var_459_0.name, "split") then
						var_459_0.gameObject:SetActive(true)
					else
						var_459_0.gameObject:SetActive(false)
					end
				end
			end

			local var_459_1 = 0.001

			if 0 <= arg_456_1.time_ and arg_456_1.time_ < 0 + var_459_1 then
				arg_456_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_456_1.var_.moveOldPos10022, Vector3.New(-390, -315, -320), (arg_456_1.time_ - 0) / var_459_1)
			end

			if arg_456_1.time_ >= 0 + var_459_1 and arg_456_1.time_ < 0 + var_459_1 + arg_459_0 then
				arg_456_1.actors_["10022"].transform.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_459_2 = arg_456_1.actors_["10022"]

			if 0 < arg_456_1.time_ and arg_456_1.time_ <= 0 + arg_459_0 and not isNil(var_459_2) and arg_456_1.var_.actorSpriteComps10022 == nil then
				arg_456_1.var_.actorSpriteComps10022 = var_459_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_459_3 = 2

			if 0 <= arg_456_1.time_ and arg_456_1.time_ < 0 + var_459_3 and not isNil(var_459_2) then
				if arg_456_1.var_.actorSpriteComps10022 then
					for iter_459_1, iter_459_2 in pairs(arg_456_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_459_2 then
							if arg_456_1.isInRecall_ then
								iter_459_2.color = Color.New(Mathf.Lerp(iter_459_2.color.r, arg_456_1.hightColor1.r, (arg_456_1.time_ - 0) / var_459_3), Mathf.Lerp(iter_459_2.color.g, arg_456_1.hightColor1.g, (arg_456_1.time_ - 0) / var_459_3), (Mathf.Lerp(iter_459_2.color.b, arg_456_1.hightColor1.b, (arg_456_1.time_ - 0) / var_459_3)))
							else
								local var_459_4 = Mathf.Lerp(iter_459_2.color.r, 1, (arg_456_1.time_ - 0) / var_459_3)

								iter_459_2.color = Color.New(var_459_4, var_459_4, var_459_4)
							end
						end
					end
				end
			end

			if arg_456_1.time_ >= 0 + var_459_3 and arg_456_1.time_ < 0 + var_459_3 + arg_459_0 and not isNil(var_459_2) and arg_456_1.var_.actorSpriteComps10022 then
				for iter_459_3, iter_459_4 in pairs(arg_456_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_459_4 then
						iter_459_4.color = arg_456_1.isInRecall_ and (arg_456_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_456_1.var_.actorSpriteComps10022 = nil
			end

			local var_459_5 = 0
			local var_459_6 = 0.125

			if 0 < arg_456_1.time_ and arg_456_1.time_ <= var_459_5 + arg_459_0 then
				arg_456_1.talkMaxDuration = 0
				arg_456_1.dialogCg_.alpha = 1

				arg_456_1.dialog_:SetActive(true)
				SetActive(arg_456_1.leftNameGo_, true)

				arg_456_1.leftNameTxt_.text = arg_456_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_456_1.leftNameTxt_.transform)

				arg_456_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_456_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_456_1:RecordName(arg_456_1.leftNameTxt_.text)
				SetActive(arg_456_1.iconTrs_.gameObject, false)
				arg_456_1.callingController_:SetSelectedState("normal")

				local var_459_7 = arg_456_1:GetWordFromCfg(413041112)
				local var_459_8 = arg_456_1:FormatText(var_459_7.content)

				arg_456_1.text_.text = var_459_8

				LuaForUtil.ClearLinePrefixSymbol(arg_456_1.text_)

				local var_459_10 = 5 <= 0 and var_459_6 or var_459_6 * (utf8.len(var_459_8) / 5)

				if (5 <= 0 and var_459_6 or var_459_6 * (utf8.len(var_459_8) / 5)) > 0 and var_459_6 < var_459_10 then
					arg_456_1.talkMaxDuration = var_459_10

					if var_459_10 + var_459_5 > arg_456_1.duration_ then
						arg_456_1.duration_ = var_459_10 + var_459_5
					end
				end

				arg_456_1.text_.text = var_459_8
				arg_456_1.typewritter.percent = 0

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413041", "413041112", "story_v_out_413041.awb") ~= 0 then
					local var_459_11 = manager.audio:GetVoiceLength("story_v_out_413041", "413041112", "story_v_out_413041.awb") / 1000

					if var_459_11 + var_459_5 > arg_456_1.duration_ then
						arg_456_1.duration_ = var_459_11 + var_459_5
					end

					if var_459_7.prefab_name ~= "" and arg_456_1.actors_[var_459_7.prefab_name] ~= nil then
						local var_459_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_456_1.actors_[var_459_7.prefab_name].transform, "story_v_out_413041", "413041112", "story_v_out_413041.awb")

						arg_456_1:RecordAudio("413041112", var_459_12)
						arg_456_1:RecordAudio("413041112", var_459_12)
					else
						arg_456_1:AudioAction("play", "voice", "story_v_out_413041", "413041112", "story_v_out_413041.awb")
					end

					arg_456_1:RecordHistoryTalkVoice("story_v_out_413041", "413041112", "story_v_out_413041.awb")
				end

				arg_456_1:RecordContent(arg_456_1.text_.text)
			end

			local var_459_13 = math.max(var_459_6, arg_456_1.talkMaxDuration)

			if var_459_5 <= arg_456_1.time_ and arg_456_1.time_ < var_459_5 + var_459_13 then
				arg_456_1.typewritter.percent = (arg_456_1.time_ - var_459_5) / var_459_13

				arg_456_1.typewritter:SetDirty()
			end

			if arg_456_1.time_ >= var_459_5 + var_459_13 and arg_456_1.time_ < var_459_5 + var_459_13 + arg_459_0 then
				arg_456_1.typewritter.percent = 1

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(true)
			end
		end

		arg_456_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_456_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/F08f",
		"TextureConfig/Background/ST0602",
		"TextureConfig/Background/STblack"
	},
	voices = {
		"story_v_out_413041.awb"
	}
}
