return {
	Play319671001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 319671001
		arg_1_1.duration_ = 3.77

		local var_1_0 = {
			zh = 2.866,
			ja = 3.766
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
				arg_1_0:Play319671002(arg_1_1)
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

			local var_4_6 = 1

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

			if 0.233333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 0.233333333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_0_story_northblock", "bgm_activity_3_0_story_northblock", "bgm_activity_3_0_story_northblock.awb")

				local var_4_14 = manager.audio:GetAudioName("bgm_activity_3_0_story_northblock", "bgm_activity_3_0_story_northblock")

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

			local var_4_15 = 1
			local var_4_16 = 0.175

			if 1 < arg_1_1.time_ and arg_1_1.time_ <= var_4_15 + arg_4_0 then
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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[694].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10091")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_18 = arg_1_1:GetWordFromCfg(319671001)
				local var_4_19 = arg_1_1:FormatText(var_4_18.content)

				arg_1_1.text_.text = var_4_19

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_21 = 7 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_19) / 7)

				if (7 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_19) / 7)) > 0 and var_4_16 < var_4_21 then
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

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671001", "story_v_out_319671.awb") ~= 0 then
					local var_4_22 = manager.audio:GetVoiceLength("story_v_out_319671", "319671001", "story_v_out_319671.awb") / 1000

					if var_4_22 + var_4_15 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_22 + var_4_15
					end

					if var_4_18.prefab_name ~= "" and arg_1_1.actors_[var_4_18.prefab_name] ~= nil then
						local var_4_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_18.prefab_name].transform, "story_v_out_319671", "319671001", "story_v_out_319671.awb")

						arg_1_1:RecordAudio("319671001", var_4_23)
						arg_1_1:RecordAudio("319671001", var_4_23)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_319671", "319671001", "story_v_out_319671.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_319671", "319671001", "story_v_out_319671.awb")
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
	Play319671002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 319671002
		arg_9_1.duration_ = 1.63

		local var_9_0 = {
			zh = 1.633,
			ja = 1.433
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
				arg_9_0:Play319671003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0.175

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_1 = arg_9_1:GetWordFromCfg(319671002)
				local var_12_2 = arg_9_1:FormatText(var_12_1.content)

				arg_9_1.text_.text = var_12_2

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 7 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 7)

				if (7 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 7)) > 0 and var_12_0 < var_12_4 then
					arg_9_1.talkMaxDuration = var_12_4

					if var_12_4 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_4 + 0
					end
				end

				arg_9_1.text_.text = var_12_2
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671002", "story_v_out_319671.awb") ~= 0 then
					local var_12_5 = manager.audio:GetVoiceLength("story_v_out_319671", "319671002", "story_v_out_319671.awb") / 1000

					if var_12_5 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_5 + 0
					end

					if var_12_1.prefab_name ~= "" and arg_9_1.actors_[var_12_1.prefab_name] ~= nil then
						local var_12_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_1.prefab_name].transform, "story_v_out_319671", "319671002", "story_v_out_319671.awb")

						arg_9_1:RecordAudio("319671002", var_12_6)
						arg_9_1:RecordAudio("319671002", var_12_6)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_319671", "319671002", "story_v_out_319671.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_319671", "319671002", "story_v_out_319671.awb")
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
	Play319671003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 319671003
		arg_13_1.duration_ = 2.03

		local var_13_0 = {
			zh = 1.1,
			ja = 2.033
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
				arg_13_0:Play319671004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0.075

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[694].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10091")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_1 = arg_13_1:GetWordFromCfg(319671003)
				local var_16_2 = arg_13_1:FormatText(var_16_1.content)

				arg_13_1.text_.text = var_16_2

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 3 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 3)

				if (3 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 3)) > 0 and var_16_0 < var_16_4 then
					arg_13_1.talkMaxDuration = var_16_4

					if var_16_4 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_4 + 0
					end
				end

				arg_13_1.text_.text = var_16_2
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671003", "story_v_out_319671.awb") ~= 0 then
					local var_16_5 = manager.audio:GetVoiceLength("story_v_out_319671", "319671003", "story_v_out_319671.awb") / 1000

					if var_16_5 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_5 + 0
					end

					if var_16_1.prefab_name ~= "" and arg_13_1.actors_[var_16_1.prefab_name] ~= nil then
						local var_16_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_1.prefab_name].transform, "story_v_out_319671", "319671003", "story_v_out_319671.awb")

						arg_13_1:RecordAudio("319671003", var_16_6)
						arg_13_1:RecordAudio("319671003", var_16_6)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_319671", "319671003", "story_v_out_319671.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_319671", "319671003", "story_v_out_319671.awb")
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
	Play319671004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 319671004
		arg_17_1.duration_ = 7

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play319671005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if arg_17_1.bgs_.I12g == nil then
				local var_20_0 = Object.Instantiate(arg_17_1.paintGo_)

				var_20_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I12g")
				var_20_0.name = "I12g"
				var_20_0.transform.parent = arg_17_1.stage_.transform
				var_20_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_17_1.bgs_.I12g = var_20_0
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				local var_20_1 = arg_17_1.bgs_.I12g

				arg_17_1.bgs_.I12g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_20_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_20_2 = var_20_1:GetComponent("SpriteRenderer")

				if var_20_2 and var_20_2.sprite then
					local var_20_3 = 2 * (var_20_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_20_1.transform.localScale = Vector3.New(var_20_3 / var_20_2.sprite.bounds.size.y < var_20_3 * manager.ui.mainCameraCom_.aspect / var_20_2.sprite.bounds.size.x and var_20_3 * manager.ui.mainCameraCom_.aspect / var_20_2.sprite.bounds.size.x or var_20_3 / var_20_2.sprite.bounds.size.y, var_20_3 / var_20_2.sprite.bounds.size.y < var_20_3 * manager.ui.mainCameraCom_.aspect / var_20_2.sprite.bounds.size.x and var_20_3 * manager.ui.mainCameraCom_.aspect / var_20_2.sprite.bounds.size.x or var_20_3 / var_20_2.sprite.bounds.size.y, 0)
				end

				for iter_20_0, iter_20_1 in pairs(arg_17_1.bgs_) do
					if iter_20_0 ~= "I12g" then
						iter_20_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_20_4 = 0

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_4 + arg_20_0 then
				arg_17_1.allBtn_.enabled = false
			end

			if arg_17_1.time_ >= var_20_4 + 0.3 and arg_17_1.time_ < var_20_4 + 0.3 + arg_20_0 then
				arg_17_1.allBtn_.enabled = true
			end

			local var_20_5 = 0

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_5 + arg_20_0 then
				arg_17_1.mask_.enabled = true
				arg_17_1.mask_.raycastTarget = true

				arg_17_1:SetGaussion(false)
			end

			local var_20_6 = 2

			if var_20_5 <= arg_17_1.time_ and arg_17_1.time_ < var_20_5 + var_20_6 then
				local var_20_7 = Color.New(0, 0, 0)

				var_20_7.a = Mathf.Lerp(1, 0, (arg_17_1.time_ - var_20_5) / var_20_6)
				arg_17_1.mask_.color = var_20_7
			end

			if arg_17_1.time_ >= var_20_5 + var_20_6 and arg_17_1.time_ < var_20_5 + var_20_6 + arg_20_0 then
				local var_20_8 = Color.New(0, 0, 0)

				arg_17_1.mask_.enabled = false
				var_20_8.a = 0
				arg_17_1.mask_.color = var_20_8
			end

			if arg_17_1.frameCnt_ <= 1 then
				arg_17_1.dialog_:SetActive(false)
			end

			local var_20_9 = 2
			local var_20_10 = 1.125

			if 2 < arg_17_1.time_ and arg_17_1.time_ <= var_20_9 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0

				arg_17_1.dialog_:SetActive(true)

				arg_17_1.dialogCg_.alpha = 0

				local var_20_11 = LeanTween.value(arg_17_1.dialog_, 0, 1, 0.3)

				var_20_11:setOnUpdate(LuaHelper.FloatAction(function(arg_21_0)
					arg_17_1.dialogCg_.alpha = arg_21_0
				end))
				var_20_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_17_1.dialog_)
					var_20_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_17_1.duration_ = arg_17_1.duration_ + 0.3

				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_12 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(319671004).content)

				arg_17_1.text_.text = var_20_12

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_14 = 45 <= 0 and var_20_10 or var_20_10 * (utf8.len(var_20_12) / 45)

				if (45 <= 0 and var_20_10 or var_20_10 * (utf8.len(var_20_12) / 45)) > 0 and var_20_10 < var_20_14 then
					arg_17_1.talkMaxDuration = var_20_14
					var_20_9 = var_20_9 + 0.3

					if var_20_14 + var_20_9 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_14 + var_20_9
					end
				end

				arg_17_1.text_.text = var_20_12
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_15 = var_20_9 + 0.3
			local var_20_16 = math.max(var_20_10, arg_17_1.talkMaxDuration)

			if var_20_9 + 0.3 <= arg_17_1.time_ and arg_17_1.time_ < var_20_15 + var_20_16 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_15) / var_20_16

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_15 + var_20_16 and arg_17_1.time_ < var_20_15 + var_20_16 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play319671005 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 319671005
		arg_23_1.duration_ = 5

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play319671006(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			local var_26_0 = 0.725

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, false)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_1 = arg_23_1:FormatText(arg_23_1:GetWordFromCfg(319671005).content)

				arg_23_1.text_.text = var_26_1

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_3 = 29 <= 0 and var_26_0 or var_26_0 * (utf8.len(var_26_1) / 29)

				if (29 <= 0 and var_26_0 or var_26_0 * (utf8.len(var_26_1) / 29)) > 0 and var_26_0 < var_26_3 then
					arg_23_1.talkMaxDuration = var_26_3

					if var_26_3 + 0 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_3 + 0
					end
				end

				arg_23_1.text_.text = var_26_1
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)
				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_4 = math.max(var_26_0, arg_23_1.talkMaxDuration)

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_4 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - 0) / var_26_4

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= 0 + var_26_4 and arg_23_1.time_ < 0 + var_26_4 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {}

		arg_23_1:InitPlayNodeList()
	end,
	Play319671006 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 319671006
		arg_27_1.duration_ = 4.53

		local var_27_0 = {
			zh = 1.233,
			ja = 4.533
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
				arg_27_0:Play319671007(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			local var_30_0 = 0.15

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				arg_27_1.leftNameTxt_.text = arg_27_1:FormatText(StoryNameCfg[694].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, true)
				arg_27_1.iconController_:SetSelectedState("hero")

				arg_27_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10091")

				arg_27_1.callingController_:SetSelectedState("normal")

				arg_27_1.keyicon_.color = Color.New(1, 1, 1)
				arg_27_1.icon_.color = Color.New(1, 1, 1)

				local var_30_1 = arg_27_1:GetWordFromCfg(319671006)
				local var_30_2 = arg_27_1:FormatText(var_30_1.content)

				arg_27_1.text_.text = var_30_2

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_4 = 6 <= 0 and var_30_0 or var_30_0 * (utf8.len(var_30_2) / 6)

				if (6 <= 0 and var_30_0 or var_30_0 * (utf8.len(var_30_2) / 6)) > 0 and var_30_0 < var_30_4 then
					arg_27_1.talkMaxDuration = var_30_4

					if var_30_4 + 0 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_4 + 0
					end
				end

				arg_27_1.text_.text = var_30_2
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671006", "story_v_out_319671.awb") ~= 0 then
					local var_30_5 = manager.audio:GetVoiceLength("story_v_out_319671", "319671006", "story_v_out_319671.awb") / 1000

					if var_30_5 + 0 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_5 + 0
					end

					if var_30_1.prefab_name ~= "" and arg_27_1.actors_[var_30_1.prefab_name] ~= nil then
						local var_30_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_1.prefab_name].transform, "story_v_out_319671", "319671006", "story_v_out_319671.awb")

						arg_27_1:RecordAudio("319671006", var_30_6)
						arg_27_1:RecordAudio("319671006", var_30_6)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_out_319671", "319671006", "story_v_out_319671.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_out_319671", "319671006", "story_v_out_319671.awb")
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
	Play319671007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 319671007
		arg_31_1.duration_ = 3.73

		local var_31_0 = {
			zh = 1.999999999999,
			ja = 3.733
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
				arg_31_0:Play319671008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			if arg_31_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_34_0 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_31_1.stage_.transform)

				var_34_0.name = "1084ui_story"
				var_34_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_31_1.actors_["1084ui_story"] = var_34_0

				local var_34_1 = var_34_0:GetComponentInChildren(typeof(CharacterEffect))

				var_34_1.enabled = true

				local var_34_2 = GameObjectTools.GetOrAddComponent(var_34_0, typeof(DynamicBoneHelper))

				if var_34_2 then
					var_34_2:EnableDynamicBone(false)
				end

				arg_31_1:ShowWeapon(var_34_1.transform, false)

				arg_31_1.var_["1084ui_story" .. "Animator"] = var_34_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_31_1.var_["1084ui_story" .. "Animator"].applyRootMotion = true
				arg_31_1.var_["1084ui_story" .. "LipSync"] = var_34_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_34_3 = arg_31_1.actors_["1084ui_story"].transform

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1.var_.moveOldPos1084ui_story = var_34_3.localPosition

				arg_31_1:ShowWeapon(arg_31_1.var_["1084ui_story" .. "Animator"].transform, false)
			end

			local var_34_4 = 0.001

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_4 then
				var_34_3.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_31_1.time_ - 0) / var_34_4)
				var_34_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_34_3.position).x, (manager.ui.mainCamera.transform.position - var_34_3.position).y, (manager.ui.mainCamera.transform.position - var_34_3.position).z)
				var_34_3.localEulerAngles.z = 0
				var_34_3.localEulerAngles.x = 0
				var_34_3.localEulerAngles = var_34_3.localEulerAngles
			end

			if arg_31_1.time_ >= 0 + var_34_4 and arg_31_1.time_ < 0 + var_34_4 + arg_34_0 then
				var_34_3.localPosition = Vector3.New(0, -0.97, -6)
				var_34_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_34_3.position).x, (manager.ui.mainCamera.transform.position - var_34_3.position).y, (manager.ui.mainCamera.transform.position - var_34_3.position).z)
				var_34_3.localEulerAngles.z = 0
				var_34_3.localEulerAngles.x = 0
				var_34_3.localEulerAngles = var_34_3.localEulerAngles
			end

			local var_34_5 = arg_31_1.actors_["1084ui_story"]

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 and not isNil(var_34_5) and arg_31_1.var_.characterEffect1084ui_story == nil then
				arg_31_1.var_.characterEffect1084ui_story = var_34_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_6 = 0.200000002980232

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_6 and not isNil(var_34_5) then
				if arg_31_1.var_.characterEffect1084ui_story and not isNil(var_34_5) then
					arg_31_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_31_1.time_ >= 0 + var_34_6 and arg_31_1.time_ < 0 + var_34_6 + arg_34_0 and not isNil(var_34_5) and arg_31_1.var_.characterEffect1084ui_story then
				arg_31_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_34_8 = 0
			local var_34_9 = 0.125

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_8 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				arg_31_1.leftNameTxt_.text = arg_31_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_10 = arg_31_1:GetWordFromCfg(319671007)
				local var_34_11 = arg_31_1:FormatText(var_34_10.content)

				arg_31_1.text_.text = var_34_11

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_13 = 5 <= 0 and var_34_9 or var_34_9 * (utf8.len(var_34_11) / 5)

				if (5 <= 0 and var_34_9 or var_34_9 * (utf8.len(var_34_11) / 5)) > 0 and var_34_9 < var_34_13 then
					arg_31_1.talkMaxDuration = var_34_13

					if var_34_13 + var_34_8 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_13 + var_34_8
					end
				end

				arg_31_1.text_.text = var_34_11
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671007", "story_v_out_319671.awb") ~= 0 then
					local var_34_14 = manager.audio:GetVoiceLength("story_v_out_319671", "319671007", "story_v_out_319671.awb") / 1000

					if var_34_14 + var_34_8 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_14 + var_34_8
					end

					if var_34_10.prefab_name ~= "" and arg_31_1.actors_[var_34_10.prefab_name] ~= nil then
						local var_34_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_10.prefab_name].transform, "story_v_out_319671", "319671007", "story_v_out_319671.awb")

						arg_31_1:RecordAudio("319671007", var_34_15)
						arg_31_1:RecordAudio("319671007", var_34_15)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_319671", "319671007", "story_v_out_319671.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_319671", "319671007", "story_v_out_319671.awb")
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
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_31_1:InitPlayNodeList()
	end,
	Play319671008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 319671008
		arg_35_1.duration_ = 5.7

		local var_35_0 = {
			zh = 3.466,
			ja = 5.7
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
				arg_35_0:Play319671009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 and not isNil(arg_35_1.actors_["1084ui_story"]) and arg_35_1.var_.characterEffect1084ui_story == nil then
				arg_35_1.var_.characterEffect1084ui_story = arg_35_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_0 = 0.200000002980232

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_0 and not isNil(arg_35_1.actors_["1084ui_story"]) then
				if arg_35_1.var_.characterEffect1084ui_story and not isNil(arg_35_1.actors_["1084ui_story"]) then
					arg_35_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_35_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_35_1.time_ - 0) / var_38_0)
				end
			end

			if arg_35_1.time_ >= 0 + var_38_0 and arg_35_1.time_ < 0 + var_38_0 + arg_38_0 and not isNil(arg_35_1.actors_["1084ui_story"]) and arg_35_1.var_.characterEffect1084ui_story then
				arg_35_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_35_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_38_1 = 0
			local var_38_2 = 0.4

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_1 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				arg_35_1.leftNameTxt_.text = arg_35_1:FormatText(StoryNameCfg[694].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, true)
				arg_35_1.iconController_:SetSelectedState("hero")

				arg_35_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10091")

				arg_35_1.callingController_:SetSelectedState("normal")

				arg_35_1.keyicon_.color = Color.New(1, 1, 1)
				arg_35_1.icon_.color = Color.New(1, 1, 1)

				local var_38_3 = arg_35_1:GetWordFromCfg(319671008)
				local var_38_4 = arg_35_1:FormatText(var_38_3.content)

				arg_35_1.text_.text = var_38_4

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_6 = 16 <= 0 and var_38_2 or var_38_2 * (utf8.len(var_38_4) / 16)

				if (16 <= 0 and var_38_2 or var_38_2 * (utf8.len(var_38_4) / 16)) > 0 and var_38_2 < var_38_6 then
					arg_35_1.talkMaxDuration = var_38_6

					if var_38_6 + var_38_1 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_6 + var_38_1
					end
				end

				arg_35_1.text_.text = var_38_4
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671008", "story_v_out_319671.awb") ~= 0 then
					local var_38_7 = manager.audio:GetVoiceLength("story_v_out_319671", "319671008", "story_v_out_319671.awb") / 1000

					if var_38_7 + var_38_1 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_7 + var_38_1
					end

					if var_38_3.prefab_name ~= "" and arg_35_1.actors_[var_38_3.prefab_name] ~= nil then
						local var_38_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_3.prefab_name].transform, "story_v_out_319671", "319671008", "story_v_out_319671.awb")

						arg_35_1:RecordAudio("319671008", var_38_8)
						arg_35_1:RecordAudio("319671008", var_38_8)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_out_319671", "319671008", "story_v_out_319671.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_out_319671", "319671008", "story_v_out_319671.awb")
				end

				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_9 = math.max(var_38_2, arg_35_1.talkMaxDuration)

			if var_38_1 <= arg_35_1.time_ and arg_35_1.time_ < var_38_1 + var_38_9 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_1) / var_38_9

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_1 + var_38_9 and arg_35_1.time_ < var_38_1 + var_38_9 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {}

		arg_35_1:InitPlayNodeList()
	end,
	Play319671009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 319671009
		arg_39_1.duration_ = 9.07

		local var_39_0 = {
			zh = 6.366,
			ja = 9.066
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
				arg_39_0:Play319671010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			if arg_39_1.actors_["1095ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1095ui_story"))) then
				local var_42_0 = Object.Instantiate(Asset.Load("Char/" .. "1095ui_story"), arg_39_1.stage_.transform)

				var_42_0.name = "1095ui_story"
				var_42_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_39_1.actors_["1095ui_story"] = var_42_0

				local var_42_1 = var_42_0:GetComponentInChildren(typeof(CharacterEffect))

				var_42_1.enabled = true

				local var_42_2 = GameObjectTools.GetOrAddComponent(var_42_0, typeof(DynamicBoneHelper))

				if var_42_2 then
					var_42_2:EnableDynamicBone(false)
				end

				arg_39_1:ShowWeapon(var_42_1.transform, false)

				arg_39_1.var_["1095ui_story" .. "Animator"] = var_42_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_39_1.var_["1095ui_story" .. "Animator"].applyRootMotion = true
				arg_39_1.var_["1095ui_story" .. "LipSync"] = var_42_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_42_3 = arg_39_1.actors_["1095ui_story"].transform

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1.var_.moveOldPos1095ui_story = var_42_3.localPosition
			end

			local var_42_4 = 0.001

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_4 then
				var_42_3.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_39_1.time_ - 0) / var_42_4)
				var_42_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_42_3.position).x, (manager.ui.mainCamera.transform.position - var_42_3.position).y, (manager.ui.mainCamera.transform.position - var_42_3.position).z)
				var_42_3.localEulerAngles.z = 0
				var_42_3.localEulerAngles.x = 0
				var_42_3.localEulerAngles = var_42_3.localEulerAngles
			end

			if arg_39_1.time_ >= 0 + var_42_4 and arg_39_1.time_ < 0 + var_42_4 + arg_42_0 then
				var_42_3.localPosition = Vector3.New(0, -0.98, -6.1)
				var_42_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_42_3.position).x, (manager.ui.mainCamera.transform.position - var_42_3.position).y, (manager.ui.mainCamera.transform.position - var_42_3.position).z)
				var_42_3.localEulerAngles.z = 0
				var_42_3.localEulerAngles.x = 0
				var_42_3.localEulerAngles = var_42_3.localEulerAngles
			end

			local var_42_5 = arg_39_1.actors_["1095ui_story"]

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 and not isNil(var_42_5) and arg_39_1.var_.characterEffect1095ui_story == nil then
				arg_39_1.var_.characterEffect1095ui_story = var_42_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_6 = 0.200000002980232

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_6 and not isNil(var_42_5) then
				if arg_39_1.var_.characterEffect1095ui_story and not isNil(var_42_5) then
					arg_39_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_39_1.time_ >= 0 + var_42_6 and arg_39_1.time_ < 0 + var_42_6 + arg_42_0 and not isNil(var_42_5) and arg_39_1.var_.characterEffect1095ui_story then
				arg_39_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_42_8 = arg_39_1.actors_["1084ui_story"].transform

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1.var_.moveOldPos1084ui_story = var_42_8.localPosition
			end

			local var_42_9 = 0.001

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_9 then
				var_42_8.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_39_1.time_ - 0) / var_42_9)
				var_42_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_42_8.position).x, (manager.ui.mainCamera.transform.position - var_42_8.position).y, (manager.ui.mainCamera.transform.position - var_42_8.position).z)
				var_42_8.localEulerAngles.z = 0
				var_42_8.localEulerAngles.x = 0
				var_42_8.localEulerAngles = var_42_8.localEulerAngles
			end

			if arg_39_1.time_ >= 0 + var_42_9 and arg_39_1.time_ < 0 + var_42_9 + arg_42_0 then
				var_42_8.localPosition = Vector3.New(0, 100, 0)
				var_42_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_42_8.position).x, (manager.ui.mainCamera.transform.position - var_42_8.position).y, (manager.ui.mainCamera.transform.position - var_42_8.position).z)
				var_42_8.localEulerAngles.z = 0
				var_42_8.localEulerAngles.x = 0
				var_42_8.localEulerAngles = var_42_8.localEulerAngles
			end

			local var_42_10 = arg_39_1.actors_["1084ui_story"]

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 and not isNil(var_42_10) and arg_39_1.var_.characterEffect1084ui_story == nil then
				arg_39_1.var_.characterEffect1084ui_story = var_42_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_11 = 0.200000002980232

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_11 and not isNil(var_42_10) then
				if arg_39_1.var_.characterEffect1084ui_story and not isNil(var_42_10) then
					arg_39_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_39_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_39_1.time_ - 0) / var_42_11)
				end
			end

			if arg_39_1.time_ >= 0 + var_42_11 and arg_39_1.time_ < 0 + var_42_11 + arg_42_0 and not isNil(var_42_10) and arg_39_1.var_.characterEffect1084ui_story then
				arg_39_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_39_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_42_12 = 0
			local var_42_13 = 0.75

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_12 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				arg_39_1.leftNameTxt_.text = arg_39_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_14 = arg_39_1:GetWordFromCfg(319671009)
				local var_42_15 = arg_39_1:FormatText(var_42_14.content)

				arg_39_1.text_.text = var_42_15

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_17 = 30 <= 0 and var_42_13 or var_42_13 * (utf8.len(var_42_15) / 30)

				if (30 <= 0 and var_42_13 or var_42_13 * (utf8.len(var_42_15) / 30)) > 0 and var_42_13 < var_42_17 then
					arg_39_1.talkMaxDuration = var_42_17

					if var_42_17 + var_42_12 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_17 + var_42_12
					end
				end

				arg_39_1.text_.text = var_42_15
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671009", "story_v_out_319671.awb") ~= 0 then
					local var_42_18 = manager.audio:GetVoiceLength("story_v_out_319671", "319671009", "story_v_out_319671.awb") / 1000

					if var_42_18 + var_42_12 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_18 + var_42_12
					end

					if var_42_14.prefab_name ~= "" and arg_39_1.actors_[var_42_14.prefab_name] ~= nil then
						local var_42_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_14.prefab_name].transform, "story_v_out_319671", "319671009", "story_v_out_319671.awb")

						arg_39_1:RecordAudio("319671009", var_42_19)
						arg_39_1:RecordAudio("319671009", var_42_19)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_out_319671", "319671009", "story_v_out_319671.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_out_319671", "319671009", "story_v_out_319671.awb")
				end

				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_20 = math.max(var_42_13, arg_39_1.talkMaxDuration)

			if var_42_12 <= arg_39_1.time_ and arg_39_1.time_ < var_42_12 + var_42_20 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_12) / var_42_20

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_12 + var_42_20 and arg_39_1.time_ < var_42_12 + var_42_20 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_39_1:InitPlayNodeList()
	end,
	Play319671010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 319671010
		arg_43_1.duration_ = 2

		local var_43_0 = {
			zh = 2,
			ja = 0.999999999999
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
				arg_43_0:Play319671011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(arg_43_1.actors_["1095ui_story"]) and arg_43_1.var_.characterEffect1095ui_story == nil then
				arg_43_1.var_.characterEffect1095ui_story = arg_43_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_0 = 0.200000002980232

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_0 and not isNil(arg_43_1.actors_["1095ui_story"]) then
				if arg_43_1.var_.characterEffect1095ui_story and not isNil(arg_43_1.actors_["1095ui_story"]) then
					arg_43_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_43_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_43_1.time_ - 0) / var_46_0)
				end
			end

			if arg_43_1.time_ >= 0 + var_46_0 and arg_43_1.time_ < 0 + var_46_0 + arg_46_0 and not isNil(arg_43_1.actors_["1095ui_story"]) and arg_43_1.var_.characterEffect1095ui_story then
				arg_43_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_43_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_46_1 = 0
			local var_46_2 = 0.175

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_1 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[694].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, true)
				arg_43_1.iconController_:SetSelectedState("hero")

				arg_43_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10091")

				arg_43_1.callingController_:SetSelectedState("normal")

				arg_43_1.keyicon_.color = Color.New(1, 1, 1)
				arg_43_1.icon_.color = Color.New(1, 1, 1)

				local var_46_3 = arg_43_1:GetWordFromCfg(319671010)
				local var_46_4 = arg_43_1:FormatText(var_46_3.content)

				arg_43_1.text_.text = var_46_4

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_6 = 7 <= 0 and var_46_2 or var_46_2 * (utf8.len(var_46_4) / 7)

				if (7 <= 0 and var_46_2 or var_46_2 * (utf8.len(var_46_4) / 7)) > 0 and var_46_2 < var_46_6 then
					arg_43_1.talkMaxDuration = var_46_6

					if var_46_6 + var_46_1 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_6 + var_46_1
					end
				end

				arg_43_1.text_.text = var_46_4
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671010", "story_v_out_319671.awb") ~= 0 then
					local var_46_7 = manager.audio:GetVoiceLength("story_v_out_319671", "319671010", "story_v_out_319671.awb") / 1000

					if var_46_7 + var_46_1 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_7 + var_46_1
					end

					if var_46_3.prefab_name ~= "" and arg_43_1.actors_[var_46_3.prefab_name] ~= nil then
						local var_46_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_3.prefab_name].transform, "story_v_out_319671", "319671010", "story_v_out_319671.awb")

						arg_43_1:RecordAudio("319671010", var_46_8)
						arg_43_1:RecordAudio("319671010", var_46_8)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_319671", "319671010", "story_v_out_319671.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_319671", "319671010", "story_v_out_319671.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_9 = math.max(var_46_2, arg_43_1.talkMaxDuration)

			if var_46_1 <= arg_43_1.time_ and arg_43_1.time_ < var_46_1 + var_46_9 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_1) / var_46_9

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_1 + var_46_9 and arg_43_1.time_ < var_46_1 + var_46_9 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play319671011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 319671011
		arg_47_1.duration_ = 5

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play319671012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.var_.moveOldPos1095ui_story = arg_47_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_50_0 = 0.001

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_0 then
				arg_47_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_47_1.time_ - 0) / var_50_0)
				arg_47_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_47_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["1095ui_story"].transform.position).z)
				arg_47_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_47_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_47_1.actors_["1095ui_story"].transform.localEulerAngles = arg_47_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_47_1.time_ >= 0 + var_50_0 and arg_47_1.time_ < 0 + var_50_0 + arg_50_0 then
				arg_47_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_47_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_47_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["1095ui_story"].transform.position).z)
				arg_47_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_47_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_47_1.actors_["1095ui_story"].transform.localEulerAngles = arg_47_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_50_1 = 0
			local var_50_2 = 1.175

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_1 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, false)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_3 = arg_47_1:FormatText(arg_47_1:GetWordFromCfg(319671011).content)

				arg_47_1.text_.text = var_50_3

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_5 = 47 <= 0 and var_50_2 or var_50_2 * (utf8.len(var_50_3) / 47)

				if (47 <= 0 and var_50_2 or var_50_2 * (utf8.len(var_50_3) / 47)) > 0 and var_50_2 < var_50_5 then
					arg_47_1.talkMaxDuration = var_50_5

					if var_50_5 + var_50_1 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_5 + var_50_1
					end
				end

				arg_47_1.text_.text = var_50_3
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)
				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_6 = math.max(var_50_2, arg_47_1.talkMaxDuration)

			if var_50_1 <= arg_47_1.time_ and arg_47_1.time_ < var_50_1 + var_50_6 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_1) / var_50_6

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_1 + var_50_6 and arg_47_1.time_ < var_50_1 + var_50_6 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
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
	Play319671012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 319671012
		arg_51_1.duration_ = 8.87

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play319671013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			if arg_51_1.bgs_.D10 == nil then
				local var_54_0 = Object.Instantiate(arg_51_1.paintGo_)

				var_54_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "D10")
				var_54_0.name = "D10"
				var_54_0.transform.parent = arg_51_1.stage_.transform
				var_54_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_51_1.bgs_.D10 = var_54_0
			end

			if 2 < arg_51_1.time_ and arg_51_1.time_ <= 2 + arg_54_0 then
				local var_54_1 = arg_51_1.bgs_.D10

				arg_51_1.bgs_.D10.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_54_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_54_2 = var_54_1:GetComponent("SpriteRenderer")

				if var_54_2 and var_54_2.sprite then
					local var_54_3 = 2 * (var_54_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_54_1.transform.localScale = Vector3.New(var_54_3 / var_54_2.sprite.bounds.size.y < var_54_3 * manager.ui.mainCameraCom_.aspect / var_54_2.sprite.bounds.size.x and var_54_3 * manager.ui.mainCameraCom_.aspect / var_54_2.sprite.bounds.size.x or var_54_3 / var_54_2.sprite.bounds.size.y, var_54_3 / var_54_2.sprite.bounds.size.y < var_54_3 * manager.ui.mainCameraCom_.aspect / var_54_2.sprite.bounds.size.x and var_54_3 * manager.ui.mainCameraCom_.aspect / var_54_2.sprite.bounds.size.x or var_54_3 / var_54_2.sprite.bounds.size.y, 0)
				end

				for iter_54_0, iter_54_1 in pairs(arg_51_1.bgs_) do
					if iter_54_0 ~= "D10" then
						iter_54_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_54_4 = 0

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_4 + arg_54_0 then
				arg_51_1.allBtn_.enabled = false
			end

			if arg_51_1.time_ >= var_54_4 + 0.3 and arg_51_1.time_ < var_54_4 + 0.3 + arg_54_0 then
				arg_51_1.allBtn_.enabled = true
			end

			local var_54_5 = 0

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_5 + arg_54_0 then
				arg_51_1.mask_.enabled = true
				arg_51_1.mask_.raycastTarget = true

				arg_51_1:SetGaussion(false)
			end

			local var_54_6 = 2

			if var_54_5 <= arg_51_1.time_ and arg_51_1.time_ < var_54_5 + var_54_6 then
				local var_54_7 = Color.New(0, 0, 0)

				var_54_7.a = Mathf.Lerp(0, 1, (arg_51_1.time_ - var_54_5) / var_54_6)
				arg_51_1.mask_.color = var_54_7
			end

			if arg_51_1.time_ >= var_54_5 + var_54_6 and arg_51_1.time_ < var_54_5 + var_54_6 + arg_54_0 then
				local var_54_8 = Color.New(0, 0, 0)

				var_54_8.a = 1
				arg_51_1.mask_.color = var_54_8
			end

			local var_54_9 = 2

			if 2 < arg_51_1.time_ and arg_51_1.time_ <= var_54_9 + arg_54_0 then
				arg_51_1.mask_.enabled = true
				arg_51_1.mask_.raycastTarget = true

				arg_51_1:SetGaussion(false)
			end

			local var_54_10 = 2

			if var_54_9 <= arg_51_1.time_ and arg_51_1.time_ < var_54_9 + var_54_10 then
				local var_54_11 = Color.New(0, 0, 0)

				var_54_11.a = Mathf.Lerp(1, 0, (arg_51_1.time_ - var_54_9) / var_54_10)
				arg_51_1.mask_.color = var_54_11
			end

			if arg_51_1.time_ >= var_54_9 + var_54_10 and arg_51_1.time_ < var_54_9 + var_54_10 + arg_54_0 then
				local var_54_12 = Color.New(0, 0, 0)

				arg_51_1.mask_.enabled = false
				var_54_12.a = 0
				arg_51_1.mask_.color = var_54_12
			end

			if arg_51_1.frameCnt_ <= 1 then
				arg_51_1.dialog_:SetActive(false)
			end

			local var_54_13 = 3.86666666666667
			local var_54_14 = 0.975

			if 3.86666666666667 < arg_51_1.time_ and arg_51_1.time_ <= var_54_13 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0

				arg_51_1.dialog_:SetActive(true)

				arg_51_1.dialogCg_.alpha = 0

				local var_54_15 = LeanTween.value(arg_51_1.dialog_, 0, 1, 0.3)

				var_54_15:setOnUpdate(LuaHelper.FloatAction(function(arg_55_0)
					arg_51_1.dialogCg_.alpha = arg_55_0
				end))
				var_54_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_51_1.dialog_)
					var_54_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_51_1.duration_ = arg_51_1.duration_ + 0.3

				SetActive(arg_51_1.leftNameGo_, false)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_16 = arg_51_1:FormatText(arg_51_1:GetWordFromCfg(319671012).content)

				arg_51_1.text_.text = var_54_16

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_18 = 39 <= 0 and var_54_14 or var_54_14 * (utf8.len(var_54_16) / 39)

				if (39 <= 0 and var_54_14 or var_54_14 * (utf8.len(var_54_16) / 39)) > 0 and var_54_14 < var_54_18 then
					arg_51_1.talkMaxDuration = var_54_18
					var_54_13 = var_54_13 + 0.3

					if var_54_18 + var_54_13 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_18 + var_54_13
					end
				end

				arg_51_1.text_.text = var_54_16
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)
				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_19 = var_54_13 + 0.3
			local var_54_20 = math.max(var_54_14, arg_51_1.talkMaxDuration)

			if var_54_13 + 0.3 <= arg_51_1.time_ and arg_51_1.time_ < var_54_19 + var_54_20 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_19) / var_54_20

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_19 + var_54_20 and arg_51_1.time_ < var_54_19 + var_54_20 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play319671013 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 319671013
		arg_57_1.duration_ = 5.57

		local var_57_0 = {
			zh = 4.766,
			ja = 5.566
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
				arg_57_0:Play319671014(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos1084ui_story = arg_57_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_60_0 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 then
				arg_57_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_57_1.time_ - 0) / var_60_0)
				arg_57_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1084ui_story"].transform.position).z)
				arg_57_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["1084ui_story"].transform.localEulerAngles = arg_57_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 then
				arg_57_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_57_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1084ui_story"].transform.position).z)
				arg_57_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["1084ui_story"].transform.localEulerAngles = arg_57_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_60_1 = arg_57_1.actors_["1084ui_story"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_1) and arg_57_1.var_.characterEffect1084ui_story == nil then
				arg_57_1.var_.characterEffect1084ui_story = var_60_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_2 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_2 and not isNil(var_60_1) then
				if arg_57_1.var_.characterEffect1084ui_story and not isNil(var_60_1) then
					arg_57_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= 0 + var_60_2 and arg_57_1.time_ < 0 + var_60_2 + arg_60_0 and not isNil(var_60_1) and arg_57_1.var_.characterEffect1084ui_story then
				arg_57_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_60_4 = 0
			local var_60_5 = 0.625

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_4 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_6 = arg_57_1:GetWordFromCfg(319671013)
				local var_60_7 = arg_57_1:FormatText(var_60_6.content)

				arg_57_1.text_.text = var_60_7

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_9 = 25 <= 0 and var_60_5 or var_60_5 * (utf8.len(var_60_7) / 25)

				if (25 <= 0 and var_60_5 or var_60_5 * (utf8.len(var_60_7) / 25)) > 0 and var_60_5 < var_60_9 then
					arg_57_1.talkMaxDuration = var_60_9

					if var_60_9 + var_60_4 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_9 + var_60_4
					end
				end

				arg_57_1.text_.text = var_60_7
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671013", "story_v_out_319671.awb") ~= 0 then
					local var_60_10 = manager.audio:GetVoiceLength("story_v_out_319671", "319671013", "story_v_out_319671.awb") / 1000

					if var_60_10 + var_60_4 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_10 + var_60_4
					end

					if var_60_6.prefab_name ~= "" and arg_57_1.actors_[var_60_6.prefab_name] ~= nil then
						local var_60_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_6.prefab_name].transform, "story_v_out_319671", "319671013", "story_v_out_319671.awb")

						arg_57_1:RecordAudio("319671013", var_60_11)
						arg_57_1:RecordAudio("319671013", var_60_11)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_319671", "319671013", "story_v_out_319671.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_319671", "319671013", "story_v_out_319671.awb")
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
				actorName = "1084ui_story",
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
	Play319671014 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 319671014
		arg_61_1.duration_ = 3.43

		local var_61_0 = {
			zh = 3.433,
			ja = 2.633
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
				arg_61_0:Play319671015(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(arg_61_1.actors_["1084ui_story"]) and arg_61_1.var_.characterEffect1084ui_story == nil then
				arg_61_1.var_.characterEffect1084ui_story = arg_61_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_0 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 and not isNil(arg_61_1.actors_["1084ui_story"]) then
				if arg_61_1.var_.characterEffect1084ui_story and not isNil(arg_61_1.actors_["1084ui_story"]) then
					arg_61_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_61_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_61_1.time_ - 0) / var_64_0)
				end
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 and not isNil(arg_61_1.actors_["1084ui_story"]) and arg_61_1.var_.characterEffect1084ui_story then
				arg_61_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_61_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_64_1 = arg_61_1.actors_["1095ui_story"].transform

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos1095ui_story = var_64_1.localPosition
			end

			local var_64_2 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_2 then
				var_64_1.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1095ui_story, Vector3.New(0.7, -0.98, -6.1), (arg_61_1.time_ - 0) / var_64_2)
				var_64_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_64_1.position).x, (manager.ui.mainCamera.transform.position - var_64_1.position).y, (manager.ui.mainCamera.transform.position - var_64_1.position).z)
				var_64_1.localEulerAngles.z = 0
				var_64_1.localEulerAngles.x = 0
				var_64_1.localEulerAngles = var_64_1.localEulerAngles
			end

			if arg_61_1.time_ >= 0 + var_64_2 and arg_61_1.time_ < 0 + var_64_2 + arg_64_0 then
				var_64_1.localPosition = Vector3.New(0.7, -0.98, -6.1)
				var_64_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_64_1.position).x, (manager.ui.mainCamera.transform.position - var_64_1.position).y, (manager.ui.mainCamera.transform.position - var_64_1.position).z)
				var_64_1.localEulerAngles.z = 0
				var_64_1.localEulerAngles.x = 0
				var_64_1.localEulerAngles = var_64_1.localEulerAngles
			end

			local var_64_3 = arg_61_1.actors_["1084ui_story"].transform

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos1084ui_story = var_64_3.localPosition
			end

			local var_64_4 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_4 then
				var_64_3.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_61_1.time_ - 0) / var_64_4)
				var_64_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_64_3.position).x, (manager.ui.mainCamera.transform.position - var_64_3.position).y, (manager.ui.mainCamera.transform.position - var_64_3.position).z)
				var_64_3.localEulerAngles.z = 0
				var_64_3.localEulerAngles.x = 0
				var_64_3.localEulerAngles = var_64_3.localEulerAngles
			end

			if arg_61_1.time_ >= 0 + var_64_4 and arg_61_1.time_ < 0 + var_64_4 + arg_64_0 then
				var_64_3.localPosition = Vector3.New(-0.7, -0.97, -6)
				var_64_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_64_3.position).x, (manager.ui.mainCamera.transform.position - var_64_3.position).y, (manager.ui.mainCamera.transform.position - var_64_3.position).z)
				var_64_3.localEulerAngles.z = 0
				var_64_3.localEulerAngles.x = 0
				var_64_3.localEulerAngles = var_64_3.localEulerAngles
			end

			local var_64_5 = arg_61_1.actors_["1095ui_story"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_5) and arg_61_1.var_.characterEffect1095ui_story == nil then
				arg_61_1.var_.characterEffect1095ui_story = var_64_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_6 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_6 and not isNil(var_64_5) then
				if arg_61_1.var_.characterEffect1095ui_story and not isNil(var_64_5) then
					arg_61_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= 0 + var_64_6 and arg_61_1.time_ < 0 + var_64_6 + arg_64_0 and not isNil(var_64_5) and arg_61_1.var_.characterEffect1095ui_story then
				arg_61_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action3_1")
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_64_8 = 0
			local var_64_9 = 0.425

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_8 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_10 = arg_61_1:GetWordFromCfg(319671014)
				local var_64_11 = arg_61_1:FormatText(var_64_10.content)

				arg_61_1.text_.text = var_64_11

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_13 = 17 <= 0 and var_64_9 or var_64_9 * (utf8.len(var_64_11) / 17)

				if (17 <= 0 and var_64_9 or var_64_9 * (utf8.len(var_64_11) / 17)) > 0 and var_64_9 < var_64_13 then
					arg_61_1.talkMaxDuration = var_64_13

					if var_64_13 + var_64_8 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_13 + var_64_8
					end
				end

				arg_61_1.text_.text = var_64_11
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671014", "story_v_out_319671.awb") ~= 0 then
					local var_64_14 = manager.audio:GetVoiceLength("story_v_out_319671", "319671014", "story_v_out_319671.awb") / 1000

					if var_64_14 + var_64_8 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_14 + var_64_8
					end

					if var_64_10.prefab_name ~= "" and arg_61_1.actors_[var_64_10.prefab_name] ~= nil then
						local var_64_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_10.prefab_name].transform, "story_v_out_319671", "319671014", "story_v_out_319671.awb")

						arg_61_1:RecordAudio("319671014", var_64_15)
						arg_61_1:RecordAudio("319671014", var_64_15)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_319671", "319671014", "story_v_out_319671.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_319671", "319671014", "story_v_out_319671.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_16 = math.max(var_64_9, arg_61_1.talkMaxDuration)

			if var_64_8 <= arg_61_1.time_ and arg_61_1.time_ < var_64_8 + var_64_16 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_8) / var_64_16

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_8 + var_64_16 and arg_61_1.time_ < var_64_8 + var_64_16 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_61_1:InitPlayNodeList()
	end,
	Play319671015 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 319671015
		arg_65_1.duration_ = 8.33

		local var_65_0 = {
			zh = 4.8,
			ja = 8.333
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
				arg_65_0:Play319671016(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(arg_65_1.actors_["1084ui_story"]) and arg_65_1.var_.characterEffect1084ui_story == nil then
				arg_65_1.var_.characterEffect1084ui_story = arg_65_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_0 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 and not isNil(arg_65_1.actors_["1084ui_story"]) then
				if arg_65_1.var_.characterEffect1084ui_story and not isNil(arg_65_1.actors_["1084ui_story"]) then
					arg_65_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 and not isNil(arg_65_1.actors_["1084ui_story"]) and arg_65_1.var_.characterEffect1084ui_story then
				arg_65_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_68_2 = arg_65_1.actors_["1095ui_story"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_2) and arg_65_1.var_.characterEffect1095ui_story == nil then
				arg_65_1.var_.characterEffect1095ui_story = var_68_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_3 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_3 and not isNil(var_68_2) then
				if arg_65_1.var_.characterEffect1095ui_story and not isNil(var_68_2) then
					arg_65_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_65_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_65_1.time_ - 0) / var_68_3)
				end
			end

			if arg_65_1.time_ >= 0 + var_68_3 and arg_65_1.time_ < 0 + var_68_3 + arg_68_0 and not isNil(var_68_2) and arg_65_1.var_.characterEffect1095ui_story then
				arg_65_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_65_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_68_4 = 0
			local var_68_5 = 0.5

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_4 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_6 = arg_65_1:GetWordFromCfg(319671015)
				local var_68_7 = arg_65_1:FormatText(var_68_6.content)

				arg_65_1.text_.text = var_68_7

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_9 = 20 <= 0 and var_68_5 or var_68_5 * (utf8.len(var_68_7) / 20)

				if (20 <= 0 and var_68_5 or var_68_5 * (utf8.len(var_68_7) / 20)) > 0 and var_68_5 < var_68_9 then
					arg_65_1.talkMaxDuration = var_68_9

					if var_68_9 + var_68_4 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_9 + var_68_4
					end
				end

				arg_65_1.text_.text = var_68_7
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671015", "story_v_out_319671.awb") ~= 0 then
					local var_68_10 = manager.audio:GetVoiceLength("story_v_out_319671", "319671015", "story_v_out_319671.awb") / 1000

					if var_68_10 + var_68_4 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_10 + var_68_4
					end

					if var_68_6.prefab_name ~= "" and arg_65_1.actors_[var_68_6.prefab_name] ~= nil then
						local var_68_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_6.prefab_name].transform, "story_v_out_319671", "319671015", "story_v_out_319671.awb")

						arg_65_1:RecordAudio("319671015", var_68_11)
						arg_65_1:RecordAudio("319671015", var_68_11)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_319671", "319671015", "story_v_out_319671.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_319671", "319671015", "story_v_out_319671.awb")
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

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play319671016 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 319671016
		arg_69_1.duration_ = 4.9

		local var_69_0 = {
			zh = 4.333,
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
				arg_69_0:Play319671017(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_2")
			end

			local var_72_0 = 0
			local var_72_1 = 0.55

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_2 = arg_69_1:GetWordFromCfg(319671016)
				local var_72_3 = arg_69_1:FormatText(var_72_2.content)

				arg_69_1.text_.text = var_72_3

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_5 = 22 <= 0 and var_72_1 or var_72_1 * (utf8.len(var_72_3) / 22)

				if (22 <= 0 and var_72_1 or var_72_1 * (utf8.len(var_72_3) / 22)) > 0 and var_72_1 < var_72_5 then
					arg_69_1.talkMaxDuration = var_72_5

					if var_72_5 + var_72_0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_5 + var_72_0
					end
				end

				arg_69_1.text_.text = var_72_3
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671016", "story_v_out_319671.awb") ~= 0 then
					local var_72_6 = manager.audio:GetVoiceLength("story_v_out_319671", "319671016", "story_v_out_319671.awb") / 1000

					if var_72_6 + var_72_0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_6 + var_72_0
					end

					if var_72_2.prefab_name ~= "" and arg_69_1.actors_[var_72_2.prefab_name] ~= nil then
						local var_72_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_2.prefab_name].transform, "story_v_out_319671", "319671016", "story_v_out_319671.awb")

						arg_69_1:RecordAudio("319671016", var_72_7)
						arg_69_1:RecordAudio("319671016", var_72_7)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_319671", "319671016", "story_v_out_319671.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_319671", "319671016", "story_v_out_319671.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_8 = math.max(var_72_1, arg_69_1.talkMaxDuration)

			if var_72_0 <= arg_69_1.time_ and arg_69_1.time_ < var_72_0 + var_72_8 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_0) / var_72_8

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_0 + var_72_8 and arg_69_1.time_ < var_72_0 + var_72_8 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play319671017 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 319671017
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play319671018(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(arg_73_1.actors_["1084ui_story"]) and arg_73_1.var_.characterEffect1084ui_story == nil then
				arg_73_1.var_.characterEffect1084ui_story = arg_73_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_0 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 and not isNil(arg_73_1.actors_["1084ui_story"]) then
				if arg_73_1.var_.characterEffect1084ui_story and not isNil(arg_73_1.actors_["1084ui_story"]) then
					arg_73_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_73_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_73_1.time_ - 0) / var_76_0)
				end
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 and not isNil(arg_73_1.actors_["1084ui_story"]) and arg_73_1.var_.characterEffect1084ui_story then
				arg_73_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_73_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_76_1 = 0
			local var_76_2 = 0.775

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, false)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_3 = arg_73_1:FormatText(arg_73_1:GetWordFromCfg(319671017).content)

				arg_73_1.text_.text = var_76_3

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_5 = 31 <= 0 and var_76_2 or var_76_2 * (utf8.len(var_76_3) / 31)

				if (31 <= 0 and var_76_2 or var_76_2 * (utf8.len(var_76_3) / 31)) > 0 and var_76_2 < var_76_5 then
					arg_73_1.talkMaxDuration = var_76_5

					if var_76_5 + var_76_1 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_5 + var_76_1
					end
				end

				arg_73_1.text_.text = var_76_3
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_6 = math.max(var_76_2, arg_73_1.talkMaxDuration)

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_6 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_1) / var_76_6

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_1 + var_76_6 and arg_73_1.time_ < var_76_1 + var_76_6 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play319671018 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 319671018
		arg_77_1.duration_ = 4.9

		local var_77_0 = {
			zh = 3.466,
			ja = 4.9
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
				arg_77_0:Play319671019(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(arg_77_1.actors_["1095ui_story"]) and arg_77_1.var_.characterEffect1095ui_story == nil then
				arg_77_1.var_.characterEffect1095ui_story = arg_77_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_0 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 and not isNil(arg_77_1.actors_["1095ui_story"]) then
				if arg_77_1.var_.characterEffect1095ui_story and not isNil(arg_77_1.actors_["1095ui_story"]) then
					arg_77_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 and not isNil(arg_77_1.actors_["1095ui_story"]) and arg_77_1.var_.characterEffect1095ui_story then
				arg_77_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action3_2")
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_80_2 = 0
			local var_80_3 = 0.425

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_2 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_4 = arg_77_1:GetWordFromCfg(319671018)
				local var_80_5 = arg_77_1:FormatText(var_80_4.content)

				arg_77_1.text_.text = var_80_5

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_7 = 17 <= 0 and var_80_3 or var_80_3 * (utf8.len(var_80_5) / 17)

				if (17 <= 0 and var_80_3 or var_80_3 * (utf8.len(var_80_5) / 17)) > 0 and var_80_3 < var_80_7 then
					arg_77_1.talkMaxDuration = var_80_7

					if var_80_7 + var_80_2 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_7 + var_80_2
					end
				end

				arg_77_1.text_.text = var_80_5
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671018", "story_v_out_319671.awb") ~= 0 then
					local var_80_8 = manager.audio:GetVoiceLength("story_v_out_319671", "319671018", "story_v_out_319671.awb") / 1000

					if var_80_8 + var_80_2 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_8 + var_80_2
					end

					if var_80_4.prefab_name ~= "" and arg_77_1.actors_[var_80_4.prefab_name] ~= nil then
						local var_80_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_4.prefab_name].transform, "story_v_out_319671", "319671018", "story_v_out_319671.awb")

						arg_77_1:RecordAudio("319671018", var_80_9)
						arg_77_1:RecordAudio("319671018", var_80_9)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_319671", "319671018", "story_v_out_319671.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_319671", "319671018", "story_v_out_319671.awb")
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
	Play319671019 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 319671019
		arg_81_1.duration_ = 5.33

		local var_81_0 = {
			zh = 4.833,
			ja = 5.333
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
				arg_81_0:Play319671020(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos1095ui_story = arg_81_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_84_0 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 then
				arg_81_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1095ui_story, Vector3.New(0.7, -0.98, -6.1), (arg_81_1.time_ - 0) / var_84_0)
				arg_81_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_81_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1095ui_story"].transform.position).z)
				arg_81_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_81_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_81_1.actors_["1095ui_story"].transform.localEulerAngles = arg_81_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 then
				arg_81_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0.7, -0.98, -6.1)
				arg_81_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_81_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1095ui_story"].transform.position).z)
				arg_81_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_81_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_81_1.actors_["1095ui_story"].transform.localEulerAngles = arg_81_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_84_1 = arg_81_1.actors_["1095ui_story"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_1) and arg_81_1.var_.characterEffect1095ui_story == nil then
				arg_81_1.var_.characterEffect1095ui_story = var_84_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_2 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_2 and not isNil(var_84_1) then
				if arg_81_1.var_.characterEffect1095ui_story and not isNil(var_84_1) then
					arg_81_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= 0 + var_84_2 and arg_81_1.time_ < 0 + var_84_2 + arg_84_0 and not isNil(var_84_1) and arg_81_1.var_.characterEffect1095ui_story then
				arg_81_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_84_4 = 0
			local var_84_5 = 0.625

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_4 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_6 = arg_81_1:GetWordFromCfg(319671019)
				local var_84_7 = arg_81_1:FormatText(var_84_6.content)

				arg_81_1.text_.text = var_84_7

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_9 = 25 <= 0 and var_84_5 or var_84_5 * (utf8.len(var_84_7) / 25)

				if (25 <= 0 and var_84_5 or var_84_5 * (utf8.len(var_84_7) / 25)) > 0 and var_84_5 < var_84_9 then
					arg_81_1.talkMaxDuration = var_84_9

					if var_84_9 + var_84_4 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_9 + var_84_4
					end
				end

				arg_81_1.text_.text = var_84_7
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671019", "story_v_out_319671.awb") ~= 0 then
					local var_84_10 = manager.audio:GetVoiceLength("story_v_out_319671", "319671019", "story_v_out_319671.awb") / 1000

					if var_84_10 + var_84_4 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_10 + var_84_4
					end

					if var_84_6.prefab_name ~= "" and arg_81_1.actors_[var_84_6.prefab_name] ~= nil then
						local var_84_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_6.prefab_name].transform, "story_v_out_319671", "319671019", "story_v_out_319671.awb")

						arg_81_1:RecordAudio("319671019", var_84_11)
						arg_81_1:RecordAudio("319671019", var_84_11)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_319671", "319671019", "story_v_out_319671.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_319671", "319671019", "story_v_out_319671.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_12 = math.max(var_84_5, arg_81_1.talkMaxDuration)

			if var_84_4 <= arg_81_1.time_ and arg_81_1.time_ < var_84_4 + var_84_12 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_4) / var_84_12

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_4 + var_84_12 and arg_81_1.time_ < var_84_4 + var_84_12 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
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
	Play319671020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 319671020
		arg_85_1.duration_ = 6.03

		local var_85_0 = {
			zh = 2.166,
			ja = 6.033
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
				arg_85_0:Play319671021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(arg_85_1.actors_["1095ui_story"]) and arg_85_1.var_.characterEffect1095ui_story == nil then
				arg_85_1.var_.characterEffect1095ui_story = arg_85_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_0 = 0.200000002980232

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 and not isNil(arg_85_1.actors_["1095ui_story"]) then
				if arg_85_1.var_.characterEffect1095ui_story and not isNil(arg_85_1.actors_["1095ui_story"]) then
					arg_85_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_85_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_85_1.time_ - 0) / var_88_0)
				end
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 and not isNil(arg_85_1.actors_["1095ui_story"]) and arg_85_1.var_.characterEffect1095ui_story then
				arg_85_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_85_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_88_1 = arg_85_1.actors_["1084ui_story"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_1) and arg_85_1.var_.characterEffect1084ui_story == nil then
				arg_85_1.var_.characterEffect1084ui_story = var_88_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_2 = 0.200000002980232

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_2 and not isNil(var_88_1) then
				if arg_85_1.var_.characterEffect1084ui_story and not isNil(var_88_1) then
					arg_85_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_85_1.time_ >= 0 + var_88_2 and arg_85_1.time_ < 0 + var_88_2 + arg_88_0 and not isNil(var_88_1) and arg_85_1.var_.characterEffect1084ui_story then
				arg_85_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_88_4 = 0
			local var_88_5 = 0.3

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_4 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_6 = arg_85_1:GetWordFromCfg(319671020)
				local var_88_7 = arg_85_1:FormatText(var_88_6.content)

				arg_85_1.text_.text = var_88_7

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_9 = 12 <= 0 and var_88_5 or var_88_5 * (utf8.len(var_88_7) / 12)

				if (12 <= 0 and var_88_5 or var_88_5 * (utf8.len(var_88_7) / 12)) > 0 and var_88_5 < var_88_9 then
					arg_85_1.talkMaxDuration = var_88_9

					if var_88_9 + var_88_4 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_9 + var_88_4
					end
				end

				arg_85_1.text_.text = var_88_7
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671020", "story_v_out_319671.awb") ~= 0 then
					local var_88_10 = manager.audio:GetVoiceLength("story_v_out_319671", "319671020", "story_v_out_319671.awb") / 1000

					if var_88_10 + var_88_4 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_10 + var_88_4
					end

					if var_88_6.prefab_name ~= "" and arg_85_1.actors_[var_88_6.prefab_name] ~= nil then
						local var_88_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_6.prefab_name].transform, "story_v_out_319671", "319671020", "story_v_out_319671.awb")

						arg_85_1:RecordAudio("319671020", var_88_11)
						arg_85_1:RecordAudio("319671020", var_88_11)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_319671", "319671020", "story_v_out_319671.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_319671", "319671020", "story_v_out_319671.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_12 = math.max(var_88_5, arg_85_1.talkMaxDuration)

			if var_88_4 <= arg_85_1.time_ and arg_85_1.time_ < var_88_4 + var_88_12 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_4) / var_88_12

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_4 + var_88_12 and arg_85_1.time_ < var_88_4 + var_88_12 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play319671021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 319671021
		arg_89_1.duration_ = 5.93

		local var_89_0 = {
			zh = 3.666,
			ja = 5.933
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
				arg_89_0:Play319671022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(arg_89_1.actors_["1084ui_story"]) and arg_89_1.var_.characterEffect1084ui_story == nil then
				arg_89_1.var_.characterEffect1084ui_story = arg_89_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_0 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 and not isNil(arg_89_1.actors_["1084ui_story"]) then
				if arg_89_1.var_.characterEffect1084ui_story and not isNil(arg_89_1.actors_["1084ui_story"]) then
					arg_89_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_89_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_89_1.time_ - 0) / var_92_0)
				end
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 and not isNil(arg_89_1.actors_["1084ui_story"]) and arg_89_1.var_.characterEffect1084ui_story then
				arg_89_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_89_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_92_1 = arg_89_1.actors_["1095ui_story"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_1) and arg_89_1.var_.characterEffect1095ui_story == nil then
				arg_89_1.var_.characterEffect1095ui_story = var_92_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_2 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_2 and not isNil(var_92_1) then
				if arg_89_1.var_.characterEffect1095ui_story and not isNil(var_92_1) then
					arg_89_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= 0 + var_92_2 and arg_89_1.time_ < 0 + var_92_2 + arg_92_0 and not isNil(var_92_1) and arg_89_1.var_.characterEffect1095ui_story then
				arg_89_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_92_4 = 0
			local var_92_5 = 0.375

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_4 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_6 = arg_89_1:GetWordFromCfg(319671021)
				local var_92_7 = arg_89_1:FormatText(var_92_6.content)

				arg_89_1.text_.text = var_92_7

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_9 = 15 <= 0 and var_92_5 or var_92_5 * (utf8.len(var_92_7) / 15)

				if (15 <= 0 and var_92_5 or var_92_5 * (utf8.len(var_92_7) / 15)) > 0 and var_92_5 < var_92_9 then
					arg_89_1.talkMaxDuration = var_92_9

					if var_92_9 + var_92_4 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_9 + var_92_4
					end
				end

				arg_89_1.text_.text = var_92_7
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671021", "story_v_out_319671.awb") ~= 0 then
					local var_92_10 = manager.audio:GetVoiceLength("story_v_out_319671", "319671021", "story_v_out_319671.awb") / 1000

					if var_92_10 + var_92_4 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_10 + var_92_4
					end

					if var_92_6.prefab_name ~= "" and arg_89_1.actors_[var_92_6.prefab_name] ~= nil then
						local var_92_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_6.prefab_name].transform, "story_v_out_319671", "319671021", "story_v_out_319671.awb")

						arg_89_1:RecordAudio("319671021", var_92_11)
						arg_89_1:RecordAudio("319671021", var_92_11)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_319671", "319671021", "story_v_out_319671.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_319671", "319671021", "story_v_out_319671.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_12 = math.max(var_92_5, arg_89_1.talkMaxDuration)

			if var_92_4 <= arg_89_1.time_ and arg_89_1.time_ < var_92_4 + var_92_12 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_4) / var_92_12

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_4 + var_92_12 and arg_89_1.time_ < var_92_4 + var_92_12 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play319671022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 319671022
		arg_93_1.duration_ = 2.1

		local var_93_0 = {
			zh = 1.999999999999,
			ja = 2.1
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
				arg_93_0:Play319671023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos1084ui_story = arg_93_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_96_0 = 0.001

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_0 then
				arg_93_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_93_1.time_ - 0) / var_96_0)
				arg_93_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_93_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1084ui_story"].transform.position).z)
				arg_93_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_93_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_93_1.actors_["1084ui_story"].transform.localEulerAngles = arg_93_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_93_1.time_ >= 0 + var_96_0 and arg_93_1.time_ < 0 + var_96_0 + arg_96_0 then
				arg_93_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(-0.7, -0.97, -6)
				arg_93_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_93_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1084ui_story"].transform.position).z)
				arg_93_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_93_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_93_1.actors_["1084ui_story"].transform.localEulerAngles = arg_93_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_96_1 = arg_93_1.actors_["1084ui_story"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_1) and arg_93_1.var_.characterEffect1084ui_story == nil then
				arg_93_1.var_.characterEffect1084ui_story = var_96_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_2 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_2 and not isNil(var_96_1) then
				if arg_93_1.var_.characterEffect1084ui_story and not isNil(var_96_1) then
					arg_93_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= 0 + var_96_2 and arg_93_1.time_ < 0 + var_96_2 + arg_96_0 and not isNil(var_96_1) and arg_93_1.var_.characterEffect1084ui_story then
				arg_93_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_96_4 = arg_93_1.actors_["1095ui_story"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_4) and arg_93_1.var_.characterEffect1095ui_story == nil then
				arg_93_1.var_.characterEffect1095ui_story = var_96_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_5 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_5 and not isNil(var_96_4) then
				if arg_93_1.var_.characterEffect1095ui_story and not isNil(var_96_4) then
					arg_93_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_93_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_93_1.time_ - 0) / var_96_5)
				end
			end

			if arg_93_1.time_ >= 0 + var_96_5 and arg_93_1.time_ < 0 + var_96_5 + arg_96_0 and not isNil(var_96_4) and arg_93_1.var_.characterEffect1095ui_story then
				arg_93_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_93_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_96_6 = 0
			local var_96_7 = 0.15

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_6 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_8 = arg_93_1:GetWordFromCfg(319671022)
				local var_96_9 = arg_93_1:FormatText(var_96_8.content)

				arg_93_1.text_.text = var_96_9

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_11 = 6 <= 0 and var_96_7 or var_96_7 * (utf8.len(var_96_9) / 6)

				if (6 <= 0 and var_96_7 or var_96_7 * (utf8.len(var_96_9) / 6)) > 0 and var_96_7 < var_96_11 then
					arg_93_1.talkMaxDuration = var_96_11

					if var_96_11 + var_96_6 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_11 + var_96_6
					end
				end

				arg_93_1.text_.text = var_96_9
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671022", "story_v_out_319671.awb") ~= 0 then
					local var_96_12 = manager.audio:GetVoiceLength("story_v_out_319671", "319671022", "story_v_out_319671.awb") / 1000

					if var_96_12 + var_96_6 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_12 + var_96_6
					end

					if var_96_8.prefab_name ~= "" and arg_93_1.actors_[var_96_8.prefab_name] ~= nil then
						local var_96_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_8.prefab_name].transform, "story_v_out_319671", "319671022", "story_v_out_319671.awb")

						arg_93_1:RecordAudio("319671022", var_96_13)
						arg_93_1:RecordAudio("319671022", var_96_13)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_319671", "319671022", "story_v_out_319671.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_319671", "319671022", "story_v_out_319671.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_14 = math.max(var_96_7, arg_93_1.talkMaxDuration)

			if var_96_6 <= arg_93_1.time_ and arg_93_1.time_ < var_96_6 + var_96_14 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_6) / var_96_14

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_6 + var_96_14 and arg_93_1.time_ < var_96_6 + var_96_14 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
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

		arg_93_1:InitPlayNodeList()
	end,
	Play319671023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 319671023
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play319671024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(arg_97_1.actors_["1084ui_story"]) and arg_97_1.var_.characterEffect1084ui_story == nil then
				arg_97_1.var_.characterEffect1084ui_story = arg_97_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_0 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 and not isNil(arg_97_1.actors_["1084ui_story"]) then
				if arg_97_1.var_.characterEffect1084ui_story and not isNil(arg_97_1.actors_["1084ui_story"]) then
					arg_97_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_97_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_97_1.time_ - 0) / var_100_0)
				end
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 and not isNil(arg_97_1.actors_["1084ui_story"]) and arg_97_1.var_.characterEffect1084ui_story then
				arg_97_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_97_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_100_1 = arg_97_1.actors_["1095ui_story"].transform

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos1095ui_story = var_100_1.localPosition
			end

			local var_100_2 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_2 then
				var_100_1.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_97_1.time_ - 0) / var_100_2)
				var_100_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_100_1.position).x, (manager.ui.mainCamera.transform.position - var_100_1.position).y, (manager.ui.mainCamera.transform.position - var_100_1.position).z)
				var_100_1.localEulerAngles.z = 0
				var_100_1.localEulerAngles.x = 0
				var_100_1.localEulerAngles = var_100_1.localEulerAngles
			end

			if arg_97_1.time_ >= 0 + var_100_2 and arg_97_1.time_ < 0 + var_100_2 + arg_100_0 then
				var_100_1.localPosition = Vector3.New(0, 100, 0)
				var_100_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_100_1.position).x, (manager.ui.mainCamera.transform.position - var_100_1.position).y, (manager.ui.mainCamera.transform.position - var_100_1.position).z)
				var_100_1.localEulerAngles.z = 0
				var_100_1.localEulerAngles.x = 0
				var_100_1.localEulerAngles = var_100_1.localEulerAngles
			end

			local var_100_3 = arg_97_1.actors_["1084ui_story"].transform

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos1084ui_story = var_100_3.localPosition
			end

			local var_100_4 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_4 then
				var_100_3.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_97_1.time_ - 0) / var_100_4)
				var_100_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_100_3.position).x, (manager.ui.mainCamera.transform.position - var_100_3.position).y, (manager.ui.mainCamera.transform.position - var_100_3.position).z)
				var_100_3.localEulerAngles.z = 0
				var_100_3.localEulerAngles.x = 0
				var_100_3.localEulerAngles = var_100_3.localEulerAngles
			end

			if arg_97_1.time_ >= 0 + var_100_4 and arg_97_1.time_ < 0 + var_100_4 + arg_100_0 then
				var_100_3.localPosition = Vector3.New(0, 100, 0)
				var_100_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_100_3.position).x, (manager.ui.mainCamera.transform.position - var_100_3.position).y, (manager.ui.mainCamera.transform.position - var_100_3.position).z)
				var_100_3.localEulerAngles.z = 0
				var_100_3.localEulerAngles.x = 0
				var_100_3.localEulerAngles = var_100_3.localEulerAngles
			end

			local var_100_5 = 0
			local var_100_6 = 0.9

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

				local var_100_7 = arg_97_1:FormatText(arg_97_1:GetWordFromCfg(319671023).content)

				arg_97_1.text_.text = var_100_7

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_9 = 36 <= 0 and var_100_6 or var_100_6 * (utf8.len(var_100_7) / 36)

				if (36 <= 0 and var_100_6 or var_100_6 * (utf8.len(var_100_7) / 36)) > 0 and var_100_6 < var_100_9 then
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

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_97_1:InitPlayNodeList()
	end,
	Play319671024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 319671024
		arg_101_1.duration_ = 7.4

		local var_101_0 = {
			zh = 4.7,
			ja = 7.4
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
				arg_101_0:Play319671025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(arg_101_1.actors_["1084ui_story"]) and arg_101_1.var_.characterEffect1084ui_story == nil then
				arg_101_1.var_.characterEffect1084ui_story = arg_101_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_0 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 and not isNil(arg_101_1.actors_["1084ui_story"]) then
				if arg_101_1.var_.characterEffect1084ui_story and not isNil(arg_101_1.actors_["1084ui_story"]) then
					arg_101_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_101_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_101_1.time_ - 0) / var_104_0)
				end
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 and not isNil(arg_101_1.actors_["1084ui_story"]) and arg_101_1.var_.characterEffect1084ui_story then
				arg_101_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_101_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_104_1 = arg_101_1.actors_["1095ui_story"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_1) and arg_101_1.var_.characterEffect1095ui_story == nil then
				arg_101_1.var_.characterEffect1095ui_story = var_104_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_2 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_2 and not isNil(var_104_1) then
				if arg_101_1.var_.characterEffect1095ui_story and not isNil(var_104_1) then
					arg_101_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= 0 + var_104_2 and arg_101_1.time_ < 0 + var_104_2 + arg_104_0 and not isNil(var_104_1) and arg_101_1.var_.characterEffect1095ui_story then
				arg_101_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_104_4 = arg_101_1.actors_["1095ui_story"].transform

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.var_.moveOldPos1095ui_story = var_104_4.localPosition
			end

			local var_104_5 = 0.001

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_5 then
				var_104_4.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_101_1.time_ - 0) / var_104_5)
				var_104_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_104_4.position).x, (manager.ui.mainCamera.transform.position - var_104_4.position).y, (manager.ui.mainCamera.transform.position - var_104_4.position).z)
				var_104_4.localEulerAngles.z = 0
				var_104_4.localEulerAngles.x = 0
				var_104_4.localEulerAngles = var_104_4.localEulerAngles
			end

			if arg_101_1.time_ >= 0 + var_104_5 and arg_101_1.time_ < 0 + var_104_5 + arg_104_0 then
				var_104_4.localPosition = Vector3.New(0, -0.98, -6.1)
				var_104_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_104_4.position).x, (manager.ui.mainCamera.transform.position - var_104_4.position).y, (manager.ui.mainCamera.transform.position - var_104_4.position).z)
				var_104_4.localEulerAngles.z = 0
				var_104_4.localEulerAngles.x = 0
				var_104_4.localEulerAngles = var_104_4.localEulerAngles
			end

			local var_104_6 = 0
			local var_104_7 = 0.6

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_6 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_8 = arg_101_1:GetWordFromCfg(319671024)
				local var_104_9 = arg_101_1:FormatText(var_104_8.content)

				arg_101_1.text_.text = var_104_9

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_11 = 24 <= 0 and var_104_7 or var_104_7 * (utf8.len(var_104_9) / 24)

				if (24 <= 0 and var_104_7 or var_104_7 * (utf8.len(var_104_9) / 24)) > 0 and var_104_7 < var_104_11 then
					arg_101_1.talkMaxDuration = var_104_11

					if var_104_11 + var_104_6 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_11 + var_104_6
					end
				end

				arg_101_1.text_.text = var_104_9
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671024", "story_v_out_319671.awb") ~= 0 then
					local var_104_12 = manager.audio:GetVoiceLength("story_v_out_319671", "319671024", "story_v_out_319671.awb") / 1000

					if var_104_12 + var_104_6 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_12 + var_104_6
					end

					if var_104_8.prefab_name ~= "" and arg_101_1.actors_[var_104_8.prefab_name] ~= nil then
						local var_104_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_8.prefab_name].transform, "story_v_out_319671", "319671024", "story_v_out_319671.awb")

						arg_101_1:RecordAudio("319671024", var_104_13)
						arg_101_1:RecordAudio("319671024", var_104_13)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_319671", "319671024", "story_v_out_319671.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_319671", "319671024", "story_v_out_319671.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_14 = math.max(var_104_7, arg_101_1.talkMaxDuration)

			if var_104_6 <= arg_101_1.time_ and arg_101_1.time_ < var_104_6 + var_104_14 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_6) / var_104_14

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_6 + var_104_14 and arg_101_1.time_ < var_104_6 + var_104_14 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
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
	Play319671025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 319671025
		arg_105_1.duration_ = 10.3

		local var_105_0 = {
			zh = 6.9,
			ja = 10.3
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
				arg_105_0:Play319671026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.moveOldPos1084ui_story = arg_105_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_108_0 = 0.001

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 then
				arg_105_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_105_1.time_ - 0) / var_108_0)
				arg_105_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_105_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["1084ui_story"].transform.position).z)
				arg_105_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_105_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_105_1.actors_["1084ui_story"].transform.localEulerAngles = arg_105_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 then
				arg_105_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(-0.7, -0.97, -6)
				arg_105_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_105_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["1084ui_story"].transform.position).z)
				arg_105_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_105_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_105_1.actors_["1084ui_story"].transform.localEulerAngles = arg_105_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_108_1 = arg_105_1.actors_["1084ui_story"]

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(var_108_1) and arg_105_1.var_.characterEffect1084ui_story == nil then
				arg_105_1.var_.characterEffect1084ui_story = var_108_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_2 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_2 and not isNil(var_108_1) then
				if arg_105_1.var_.characterEffect1084ui_story and not isNil(var_108_1) then
					arg_105_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= 0 + var_108_2 and arg_105_1.time_ < 0 + var_108_2 + arg_108_0 and not isNil(var_108_1) and arg_105_1.var_.characterEffect1084ui_story then
				arg_105_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_2")
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_108_4 = arg_105_1.actors_["1095ui_story"].transform

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.moveOldPos1095ui_story = var_108_4.localPosition
			end

			local var_108_5 = 0.001

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_5 then
				var_108_4.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos1095ui_story, Vector3.New(0.7, -0.98, -6.1), (arg_105_1.time_ - 0) / var_108_5)
				var_108_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_108_4.position).x, (manager.ui.mainCamera.transform.position - var_108_4.position).y, (manager.ui.mainCamera.transform.position - var_108_4.position).z)
				var_108_4.localEulerAngles.z = 0
				var_108_4.localEulerAngles.x = 0
				var_108_4.localEulerAngles = var_108_4.localEulerAngles
			end

			if arg_105_1.time_ >= 0 + var_108_5 and arg_105_1.time_ < 0 + var_108_5 + arg_108_0 then
				var_108_4.localPosition = Vector3.New(0.7, -0.98, -6.1)
				var_108_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_108_4.position).x, (manager.ui.mainCamera.transform.position - var_108_4.position).y, (manager.ui.mainCamera.transform.position - var_108_4.position).z)
				var_108_4.localEulerAngles.z = 0
				var_108_4.localEulerAngles.x = 0
				var_108_4.localEulerAngles = var_108_4.localEulerAngles
			end

			local var_108_6 = arg_105_1.actors_["1095ui_story"]

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(var_108_6) and arg_105_1.var_.characterEffect1095ui_story == nil then
				arg_105_1.var_.characterEffect1095ui_story = var_108_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_7 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_7 and not isNil(var_108_6) then
				if arg_105_1.var_.characterEffect1095ui_story and not isNil(var_108_6) then
					arg_105_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_105_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_105_1.time_ - 0) / var_108_7)
				end
			end

			if arg_105_1.time_ >= 0 + var_108_7 and arg_105_1.time_ < 0 + var_108_7 + arg_108_0 and not isNil(var_108_6) and arg_105_1.var_.characterEffect1095ui_story then
				arg_105_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_105_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_108_8 = 0
			local var_108_9 = 0.85

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_8 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_10 = arg_105_1:GetWordFromCfg(319671025)
				local var_108_11 = arg_105_1:FormatText(var_108_10.content)

				arg_105_1.text_.text = var_108_11

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_13 = 34 <= 0 and var_108_9 or var_108_9 * (utf8.len(var_108_11) / 34)

				if (34 <= 0 and var_108_9 or var_108_9 * (utf8.len(var_108_11) / 34)) > 0 and var_108_9 < var_108_13 then
					arg_105_1.talkMaxDuration = var_108_13

					if var_108_13 + var_108_8 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_13 + var_108_8
					end
				end

				arg_105_1.text_.text = var_108_11
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671025", "story_v_out_319671.awb") ~= 0 then
					local var_108_14 = manager.audio:GetVoiceLength("story_v_out_319671", "319671025", "story_v_out_319671.awb") / 1000

					if var_108_14 + var_108_8 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_14 + var_108_8
					end

					if var_108_10.prefab_name ~= "" and arg_105_1.actors_[var_108_10.prefab_name] ~= nil then
						local var_108_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_10.prefab_name].transform, "story_v_out_319671", "319671025", "story_v_out_319671.awb")

						arg_105_1:RecordAudio("319671025", var_108_15)
						arg_105_1:RecordAudio("319671025", var_108_15)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_319671", "319671025", "story_v_out_319671.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_319671", "319671025", "story_v_out_319671.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_16 = math.max(var_108_9, arg_105_1.talkMaxDuration)

			if var_108_8 <= arg_105_1.time_ and arg_105_1.time_ < var_108_8 + var_108_16 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_8) / var_108_16

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_8 + var_108_16 and arg_105_1.time_ < var_108_8 + var_108_16 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1095ui_story",
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
	Play319671026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 319671026
		arg_109_1.duration_ = 10.83

		local var_109_0 = {
			zh = 6.333,
			ja = 10.833
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
				arg_109_0:Play319671027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.var_.moveOldPos1095ui_story = arg_109_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_112_0 = 0.001

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 then
				arg_109_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1095ui_story, Vector3.New(0.7, -0.98, -6.1), (arg_109_1.time_ - 0) / var_112_0)
				arg_109_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_109_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1095ui_story"].transform.position).z)
				arg_109_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_109_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_109_1.actors_["1095ui_story"].transform.localEulerAngles = arg_109_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 then
				arg_109_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0.7, -0.98, -6.1)
				arg_109_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_109_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1095ui_story"].transform.position).z)
				arg_109_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_109_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_109_1.actors_["1095ui_story"].transform.localEulerAngles = arg_109_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_112_1 = arg_109_1.actors_["1095ui_story"]

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(var_112_1) and arg_109_1.var_.characterEffect1095ui_story == nil then
				arg_109_1.var_.characterEffect1095ui_story = var_112_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_2 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_2 and not isNil(var_112_1) then
				if arg_109_1.var_.characterEffect1095ui_story and not isNil(var_112_1) then
					arg_109_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= 0 + var_112_2 and arg_109_1.time_ < 0 + var_112_2 + arg_112_0 and not isNil(var_112_1) and arg_109_1.var_.characterEffect1095ui_story then
				arg_109_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_1")
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_112_4 = arg_109_1.actors_["1084ui_story"]

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(var_112_4) and arg_109_1.var_.characterEffect1084ui_story == nil then
				arg_109_1.var_.characterEffect1084ui_story = var_112_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_5 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_5 and not isNil(var_112_4) then
				if arg_109_1.var_.characterEffect1084ui_story and not isNil(var_112_4) then
					arg_109_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_109_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_109_1.time_ - 0) / var_112_5)
				end
			end

			if arg_109_1.time_ >= 0 + var_112_5 and arg_109_1.time_ < 0 + var_112_5 + arg_112_0 and not isNil(var_112_4) and arg_109_1.var_.characterEffect1084ui_story then
				arg_109_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_109_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_112_6 = 0
			local var_112_7 = 0.55

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_6 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_8 = arg_109_1:GetWordFromCfg(319671026)
				local var_112_9 = arg_109_1:FormatText(var_112_8.content)

				arg_109_1.text_.text = var_112_9

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_11 = 22 <= 0 and var_112_7 or var_112_7 * (utf8.len(var_112_9) / 22)

				if (22 <= 0 and var_112_7 or var_112_7 * (utf8.len(var_112_9) / 22)) > 0 and var_112_7 < var_112_11 then
					arg_109_1.talkMaxDuration = var_112_11

					if var_112_11 + var_112_6 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_11 + var_112_6
					end
				end

				arg_109_1.text_.text = var_112_9
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671026", "story_v_out_319671.awb") ~= 0 then
					local var_112_12 = manager.audio:GetVoiceLength("story_v_out_319671", "319671026", "story_v_out_319671.awb") / 1000

					if var_112_12 + var_112_6 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_12 + var_112_6
					end

					if var_112_8.prefab_name ~= "" and arg_109_1.actors_[var_112_8.prefab_name] ~= nil then
						local var_112_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_8.prefab_name].transform, "story_v_out_319671", "319671026", "story_v_out_319671.awb")

						arg_109_1:RecordAudio("319671026", var_112_13)
						arg_109_1:RecordAudio("319671026", var_112_13)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_319671", "319671026", "story_v_out_319671.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_319671", "319671026", "story_v_out_319671.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_14 = math.max(var_112_7, arg_109_1.talkMaxDuration)

			if var_112_6 <= arg_109_1.time_ and arg_109_1.time_ < var_112_6 + var_112_14 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_6) / var_112_14

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_6 + var_112_14 and arg_109_1.time_ < var_112_6 + var_112_14 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_109_1:InitPlayNodeList()
	end,
	Play319671027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 319671027
		arg_113_1.duration_ = 2.3

		local var_113_0 = {
			zh = 2.3,
			ja = 2
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
				arg_113_0:Play319671028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(arg_113_1.actors_["1095ui_story"]) and arg_113_1.var_.characterEffect1095ui_story == nil then
				arg_113_1.var_.characterEffect1095ui_story = arg_113_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_0 = 0.200000002980232

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_0 and not isNil(arg_113_1.actors_["1095ui_story"]) then
				if arg_113_1.var_.characterEffect1095ui_story and not isNil(arg_113_1.actors_["1095ui_story"]) then
					arg_113_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_113_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_113_1.time_ - 0) / var_116_0)
				end
			end

			if arg_113_1.time_ >= 0 + var_116_0 and arg_113_1.time_ < 0 + var_116_0 + arg_116_0 and not isNil(arg_113_1.actors_["1095ui_story"]) and arg_113_1.var_.characterEffect1095ui_story then
				arg_113_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_113_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_116_1 = arg_113_1.actors_["1084ui_story"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_1) and arg_113_1.var_.characterEffect1084ui_story == nil then
				arg_113_1.var_.characterEffect1084ui_story = var_116_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_2 = 0.200000002980232

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_2 and not isNil(var_116_1) then
				if arg_113_1.var_.characterEffect1084ui_story and not isNil(var_116_1) then
					arg_113_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= 0 + var_116_2 and arg_113_1.time_ < 0 + var_116_2 + arg_116_0 and not isNil(var_116_1) and arg_113_1.var_.characterEffect1084ui_story then
				arg_113_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_116_4 = 0
			local var_116_5 = 0.125

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_4 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_6 = arg_113_1:GetWordFromCfg(319671027)
				local var_116_7 = arg_113_1:FormatText(var_116_6.content)

				arg_113_1.text_.text = var_116_7

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_9 = 5 <= 0 and var_116_5 or var_116_5 * (utf8.len(var_116_7) / 5)

				if (5 <= 0 and var_116_5 or var_116_5 * (utf8.len(var_116_7) / 5)) > 0 and var_116_5 < var_116_9 then
					arg_113_1.talkMaxDuration = var_116_9

					if var_116_9 + var_116_4 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_9 + var_116_4
					end
				end

				arg_113_1.text_.text = var_116_7
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671027", "story_v_out_319671.awb") ~= 0 then
					local var_116_10 = manager.audio:GetVoiceLength("story_v_out_319671", "319671027", "story_v_out_319671.awb") / 1000

					if var_116_10 + var_116_4 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_10 + var_116_4
					end

					if var_116_6.prefab_name ~= "" and arg_113_1.actors_[var_116_6.prefab_name] ~= nil then
						local var_116_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_6.prefab_name].transform, "story_v_out_319671", "319671027", "story_v_out_319671.awb")

						arg_113_1:RecordAudio("319671027", var_116_11)
						arg_113_1:RecordAudio("319671027", var_116_11)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_319671", "319671027", "story_v_out_319671.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_319671", "319671027", "story_v_out_319671.awb")
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

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play319671028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 319671028
		arg_117_1.duration_ = 3.13

		local var_117_0 = {
			zh = 1.999999999999,
			ja = 3.133
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
				arg_117_0:Play319671029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(arg_117_1.actors_["1095ui_story"]) and arg_117_1.var_.characterEffect1095ui_story == nil then
				arg_117_1.var_.characterEffect1095ui_story = arg_117_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_0 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_0 and not isNil(arg_117_1.actors_["1095ui_story"]) then
				if arg_117_1.var_.characterEffect1095ui_story and not isNil(arg_117_1.actors_["1095ui_story"]) then
					arg_117_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_117_1.time_ >= 0 + var_120_0 and arg_117_1.time_ < 0 + var_120_0 + arg_120_0 and not isNil(arg_117_1.actors_["1095ui_story"]) and arg_117_1.var_.characterEffect1095ui_story then
				arg_117_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_120_2 = arg_117_1.actors_["1084ui_story"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_2) and arg_117_1.var_.characterEffect1084ui_story == nil then
				arg_117_1.var_.characterEffect1084ui_story = var_120_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_3 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_3 and not isNil(var_120_2) then
				if arg_117_1.var_.characterEffect1084ui_story and not isNil(var_120_2) then
					arg_117_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_117_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_117_1.time_ - 0) / var_120_3)
				end
			end

			if arg_117_1.time_ >= 0 + var_120_3 and arg_117_1.time_ < 0 + var_120_3 + arg_120_0 and not isNil(var_120_2) and arg_117_1.var_.characterEffect1084ui_story then
				arg_117_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_117_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_120_4 = 0
			local var_120_5 = 0.25

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_4 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_6 = arg_117_1:GetWordFromCfg(319671028)
				local var_120_7 = arg_117_1:FormatText(var_120_6.content)

				arg_117_1.text_.text = var_120_7

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_9 = 10 <= 0 and var_120_5 or var_120_5 * (utf8.len(var_120_7) / 10)

				if (10 <= 0 and var_120_5 or var_120_5 * (utf8.len(var_120_7) / 10)) > 0 and var_120_5 < var_120_9 then
					arg_117_1.talkMaxDuration = var_120_9

					if var_120_9 + var_120_4 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_9 + var_120_4
					end
				end

				arg_117_1.text_.text = var_120_7
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671028", "story_v_out_319671.awb") ~= 0 then
					local var_120_10 = manager.audio:GetVoiceLength("story_v_out_319671", "319671028", "story_v_out_319671.awb") / 1000

					if var_120_10 + var_120_4 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_10 + var_120_4
					end

					if var_120_6.prefab_name ~= "" and arg_117_1.actors_[var_120_6.prefab_name] ~= nil then
						local var_120_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_6.prefab_name].transform, "story_v_out_319671", "319671028", "story_v_out_319671.awb")

						arg_117_1:RecordAudio("319671028", var_120_11)
						arg_117_1:RecordAudio("319671028", var_120_11)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_319671", "319671028", "story_v_out_319671.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_319671", "319671028", "story_v_out_319671.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_12 = math.max(var_120_5, arg_117_1.talkMaxDuration)

			if var_120_4 <= arg_117_1.time_ and arg_117_1.time_ < var_120_4 + var_120_12 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_4) / var_120_12

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_4 + var_120_12 and arg_117_1.time_ < var_120_4 + var_120_12 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play319671029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 319671029
		arg_121_1.duration_ = 2

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play319671030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_2")
			end

			local var_124_0 = 0
			local var_124_1 = 0.075

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_0 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_2 = arg_121_1:GetWordFromCfg(319671029)
				local var_124_3 = arg_121_1:FormatText(var_124_2.content)

				arg_121_1.text_.text = var_124_3

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_5 = 3 <= 0 and var_124_1 or var_124_1 * (utf8.len(var_124_3) / 3)

				if (3 <= 0 and var_124_1 or var_124_1 * (utf8.len(var_124_3) / 3)) > 0 and var_124_1 < var_124_5 then
					arg_121_1.talkMaxDuration = var_124_5

					if var_124_5 + var_124_0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_5 + var_124_0
					end
				end

				arg_121_1.text_.text = var_124_3
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671029", "story_v_out_319671.awb") ~= 0 then
					local var_124_6 = manager.audio:GetVoiceLength("story_v_out_319671", "319671029", "story_v_out_319671.awb") / 1000

					if var_124_6 + var_124_0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_6 + var_124_0
					end

					if var_124_2.prefab_name ~= "" and arg_121_1.actors_[var_124_2.prefab_name] ~= nil then
						local var_124_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_2.prefab_name].transform, "story_v_out_319671", "319671029", "story_v_out_319671.awb")

						arg_121_1:RecordAudio("319671029", var_124_7)
						arg_121_1:RecordAudio("319671029", var_124_7)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_319671", "319671029", "story_v_out_319671.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_319671", "319671029", "story_v_out_319671.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_8 = math.max(var_124_1, arg_121_1.talkMaxDuration)

			if var_124_0 <= arg_121_1.time_ and arg_121_1.time_ < var_124_0 + var_124_8 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_0) / var_124_8

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_0 + var_124_8 and arg_121_1.time_ < var_124_0 + var_124_8 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play319671030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 319671030
		arg_125_1.duration_ = 8.87

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play319671031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if arg_125_1.bgs_.D11 == nil then
				local var_128_0 = Object.Instantiate(arg_125_1.paintGo_)

				var_128_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "D11")
				var_128_0.name = "D11"
				var_128_0.transform.parent = arg_125_1.stage_.transform
				var_128_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_125_1.bgs_.D11 = var_128_0
			end

			if 2 < arg_125_1.time_ and arg_125_1.time_ <= 2 + arg_128_0 then
				local var_128_1 = arg_125_1.bgs_.D11

				arg_125_1.bgs_.D11.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_128_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_128_2 = var_128_1:GetComponent("SpriteRenderer")

				if var_128_2 and var_128_2.sprite then
					local var_128_3 = 2 * (var_128_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_128_1.transform.localScale = Vector3.New(var_128_3 / var_128_2.sprite.bounds.size.y < var_128_3 * manager.ui.mainCameraCom_.aspect / var_128_2.sprite.bounds.size.x and var_128_3 * manager.ui.mainCameraCom_.aspect / var_128_2.sprite.bounds.size.x or var_128_3 / var_128_2.sprite.bounds.size.y, var_128_3 / var_128_2.sprite.bounds.size.y < var_128_3 * manager.ui.mainCameraCom_.aspect / var_128_2.sprite.bounds.size.x and var_128_3 * manager.ui.mainCameraCom_.aspect / var_128_2.sprite.bounds.size.x or var_128_3 / var_128_2.sprite.bounds.size.y, 0)
				end

				for iter_128_0, iter_128_1 in pairs(arg_125_1.bgs_) do
					if iter_128_0 ~= "D11" then
						iter_128_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_128_4 = 0

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_4 + arg_128_0 then
				arg_125_1.allBtn_.enabled = false
			end

			if arg_125_1.time_ >= var_128_4 + 0.3 and arg_125_1.time_ < var_128_4 + 0.3 + arg_128_0 then
				arg_125_1.allBtn_.enabled = true
			end

			local var_128_5 = 0

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_5 + arg_128_0 then
				arg_125_1.mask_.enabled = true
				arg_125_1.mask_.raycastTarget = true

				arg_125_1:SetGaussion(false)
			end

			local var_128_6 = 2

			if var_128_5 <= arg_125_1.time_ and arg_125_1.time_ < var_128_5 + var_128_6 then
				local var_128_7 = Color.New(0, 0, 0)

				var_128_7.a = Mathf.Lerp(0, 1, (arg_125_1.time_ - var_128_5) / var_128_6)
				arg_125_1.mask_.color = var_128_7
			end

			if arg_125_1.time_ >= var_128_5 + var_128_6 and arg_125_1.time_ < var_128_5 + var_128_6 + arg_128_0 then
				local var_128_8 = Color.New(0, 0, 0)

				var_128_8.a = 1
				arg_125_1.mask_.color = var_128_8
			end

			local var_128_9 = 2

			if 2 < arg_125_1.time_ and arg_125_1.time_ <= var_128_9 + arg_128_0 then
				arg_125_1.mask_.enabled = true
				arg_125_1.mask_.raycastTarget = true

				arg_125_1:SetGaussion(false)
			end

			local var_128_10 = 2

			if var_128_9 <= arg_125_1.time_ and arg_125_1.time_ < var_128_9 + var_128_10 then
				local var_128_11 = Color.New(0, 0, 0)

				var_128_11.a = Mathf.Lerp(1, 0, (arg_125_1.time_ - var_128_9) / var_128_10)
				arg_125_1.mask_.color = var_128_11
			end

			if arg_125_1.time_ >= var_128_9 + var_128_10 and arg_125_1.time_ < var_128_9 + var_128_10 + arg_128_0 then
				local var_128_12 = Color.New(0, 0, 0)

				arg_125_1.mask_.enabled = false
				var_128_12.a = 0
				arg_125_1.mask_.color = var_128_12
			end

			local var_128_13 = arg_125_1.actors_["1084ui_story"].transform

			if 2 < arg_125_1.time_ and arg_125_1.time_ <= 2 + arg_128_0 then
				arg_125_1.var_.moveOldPos1084ui_story = var_128_13.localPosition
			end

			local var_128_14 = 0.001

			if 2 <= arg_125_1.time_ and arg_125_1.time_ < 2 + var_128_14 then
				var_128_13.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_125_1.time_ - 2) / var_128_14)
				var_128_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_128_13.position).x, (manager.ui.mainCamera.transform.position - var_128_13.position).y, (manager.ui.mainCamera.transform.position - var_128_13.position).z)
				var_128_13.localEulerAngles.z = 0
				var_128_13.localEulerAngles.x = 0
				var_128_13.localEulerAngles = var_128_13.localEulerAngles
			end

			if arg_125_1.time_ >= 2 + var_128_14 and arg_125_1.time_ < 2 + var_128_14 + arg_128_0 then
				var_128_13.localPosition = Vector3.New(0, 100, 0)
				var_128_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_128_13.position).x, (manager.ui.mainCamera.transform.position - var_128_13.position).y, (manager.ui.mainCamera.transform.position - var_128_13.position).z)
				var_128_13.localEulerAngles.z = 0
				var_128_13.localEulerAngles.x = 0
				var_128_13.localEulerAngles = var_128_13.localEulerAngles
			end

			local var_128_15 = arg_125_1.actors_["1095ui_story"].transform

			if 2 < arg_125_1.time_ and arg_125_1.time_ <= 2 + arg_128_0 then
				arg_125_1.var_.moveOldPos1095ui_story = var_128_15.localPosition
			end

			local var_128_16 = 0.001

			if 2 <= arg_125_1.time_ and arg_125_1.time_ < 2 + var_128_16 then
				var_128_15.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_125_1.time_ - 2) / var_128_16)
				var_128_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_128_15.position).x, (manager.ui.mainCamera.transform.position - var_128_15.position).y, (manager.ui.mainCamera.transform.position - var_128_15.position).z)
				var_128_15.localEulerAngles.z = 0
				var_128_15.localEulerAngles.x = 0
				var_128_15.localEulerAngles = var_128_15.localEulerAngles
			end

			if arg_125_1.time_ >= 2 + var_128_16 and arg_125_1.time_ < 2 + var_128_16 + arg_128_0 then
				var_128_15.localPosition = Vector3.New(0, 100, 0)
				var_128_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_128_15.position).x, (manager.ui.mainCamera.transform.position - var_128_15.position).y, (manager.ui.mainCamera.transform.position - var_128_15.position).z)
				var_128_15.localEulerAngles.z = 0
				var_128_15.localEulerAngles.x = 0
				var_128_15.localEulerAngles = var_128_15.localEulerAngles
			end

			if arg_125_1.frameCnt_ <= 1 then
				arg_125_1.dialog_:SetActive(false)
			end

			local var_128_17 = 3.86666666666667
			local var_128_18 = 0.95

			if 3.86666666666667 < arg_125_1.time_ and arg_125_1.time_ <= var_128_17 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0

				arg_125_1.dialog_:SetActive(true)

				arg_125_1.dialogCg_.alpha = 0

				local var_128_19 = LeanTween.value(arg_125_1.dialog_, 0, 1, 0.3)

				var_128_19:setOnUpdate(LuaHelper.FloatAction(function(arg_129_0)
					arg_125_1.dialogCg_.alpha = arg_129_0
				end))
				var_128_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_125_1.dialog_)
					var_128_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_125_1.duration_ = arg_125_1.duration_ + 0.3

				SetActive(arg_125_1.leftNameGo_, false)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_20 = arg_125_1:FormatText(arg_125_1:GetWordFromCfg(319671030).content)

				arg_125_1.text_.text = var_128_20

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_22 = 38 <= 0 and var_128_18 or var_128_18 * (utf8.len(var_128_20) / 38)

				if (38 <= 0 and var_128_18 or var_128_18 * (utf8.len(var_128_20) / 38)) > 0 and var_128_18 < var_128_22 then
					arg_125_1.talkMaxDuration = var_128_22
					var_128_17 = var_128_17 + 0.3

					if var_128_22 + var_128_17 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_22 + var_128_17
					end
				end

				arg_125_1.text_.text = var_128_20
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_23 = var_128_17 + 0.3
			local var_128_24 = math.max(var_128_18, arg_125_1.talkMaxDuration)

			if var_128_17 + 0.3 <= arg_125_1.time_ and arg_125_1.time_ < var_128_23 + var_128_24 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_23) / var_128_24

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_23 + var_128_24 and arg_125_1.time_ < var_128_23 + var_128_24 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_125_1:InitPlayNodeList()
	end,
	Play319671031 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 319671031
		arg_131_1.duration_ = 5

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play319671032(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = 0.95

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, false)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_1 = arg_131_1:FormatText(arg_131_1:GetWordFromCfg(319671031).content)

				arg_131_1.text_.text = var_134_1

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_3 = 38 <= 0 and var_134_0 or var_134_0 * (utf8.len(var_134_1) / 38)

				if (38 <= 0 and var_134_0 or var_134_0 * (utf8.len(var_134_1) / 38)) > 0 and var_134_0 < var_134_3 then
					arg_131_1.talkMaxDuration = var_134_3

					if var_134_3 + 0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_3 + 0
					end
				end

				arg_131_1.text_.text = var_134_1
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)
				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_4 = math.max(var_134_0, arg_131_1.talkMaxDuration)

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_4 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - 0) / var_134_4

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= 0 + var_134_4 and arg_131_1.time_ < 0 + var_134_4 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play319671032 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 319671032
		arg_135_1.duration_ = 8.9

		local var_135_0 = {
			zh = 3.966,
			ja = 8.9
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
				arg_135_0:Play319671033(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = 0.5

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[660].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, true)
				arg_135_1.iconController_:SetSelectedState("hero")

				arg_135_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_135_1.callingController_:SetSelectedState("normal")

				arg_135_1.keyicon_.color = Color.New(1, 1, 1)
				arg_135_1.icon_.color = Color.New(1, 1, 1)

				local var_138_1 = arg_135_1:GetWordFromCfg(319671032)
				local var_138_2 = arg_135_1:FormatText(var_138_1.content)

				arg_135_1.text_.text = var_138_2

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_4 = 20 <= 0 and var_138_0 or var_138_0 * (utf8.len(var_138_2) / 20)

				if (20 <= 0 and var_138_0 or var_138_0 * (utf8.len(var_138_2) / 20)) > 0 and var_138_0 < var_138_4 then
					arg_135_1.talkMaxDuration = var_138_4

					if var_138_4 + 0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_4 + 0
					end
				end

				arg_135_1.text_.text = var_138_2
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671032", "story_v_out_319671.awb") ~= 0 then
					local var_138_5 = manager.audio:GetVoiceLength("story_v_out_319671", "319671032", "story_v_out_319671.awb") / 1000

					if var_138_5 + 0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_5 + 0
					end

					if var_138_1.prefab_name ~= "" and arg_135_1.actors_[var_138_1.prefab_name] ~= nil then
						local var_138_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_1.prefab_name].transform, "story_v_out_319671", "319671032", "story_v_out_319671.awb")

						arg_135_1:RecordAudio("319671032", var_138_6)
						arg_135_1:RecordAudio("319671032", var_138_6)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_319671", "319671032", "story_v_out_319671.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_319671", "319671032", "story_v_out_319671.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_7 = math.max(var_138_0, arg_135_1.talkMaxDuration)

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_7 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - 0) / var_138_7

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= 0 + var_138_7 and arg_135_1.time_ < 0 + var_138_7 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play319671033 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 319671033
		arg_139_1.duration_ = 4.43

		local var_139_0 = {
			zh = 1.999999999999,
			ja = 4.433
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
				arg_139_0:Play319671034(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.var_.moveOldPos1095ui_story = arg_139_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_142_0 = 0.001

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_0 then
				arg_139_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_139_1.time_ - 0) / var_142_0)
				arg_139_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_139_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["1095ui_story"].transform.position).z)
				arg_139_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_139_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_139_1.actors_["1095ui_story"].transform.localEulerAngles = arg_139_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_139_1.time_ >= 0 + var_142_0 and arg_139_1.time_ < 0 + var_142_0 + arg_142_0 then
				arg_139_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_139_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_139_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["1095ui_story"].transform.position).z)
				arg_139_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_139_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_139_1.actors_["1095ui_story"].transform.localEulerAngles = arg_139_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_142_1 = arg_139_1.actors_["1095ui_story"]

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(var_142_1) and arg_139_1.var_.characterEffect1095ui_story == nil then
				arg_139_1.var_.characterEffect1095ui_story = var_142_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_2 = 0.200000002980232

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_2 and not isNil(var_142_1) then
				if arg_139_1.var_.characterEffect1095ui_story and not isNil(var_142_1) then
					arg_139_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_139_1.time_ >= 0 + var_142_2 and arg_139_1.time_ < 0 + var_142_2 + arg_142_0 and not isNil(var_142_1) and arg_139_1.var_.characterEffect1095ui_story then
				arg_139_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_142_4 = 0
			local var_142_5 = 0.15

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_4 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_6 = arg_139_1:GetWordFromCfg(319671033)
				local var_142_7 = arg_139_1:FormatText(var_142_6.content)

				arg_139_1.text_.text = var_142_7

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_9 = 6 <= 0 and var_142_5 or var_142_5 * (utf8.len(var_142_7) / 6)

				if (6 <= 0 and var_142_5 or var_142_5 * (utf8.len(var_142_7) / 6)) > 0 and var_142_5 < var_142_9 then
					arg_139_1.talkMaxDuration = var_142_9

					if var_142_9 + var_142_4 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_9 + var_142_4
					end
				end

				arg_139_1.text_.text = var_142_7
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671033", "story_v_out_319671.awb") ~= 0 then
					local var_142_10 = manager.audio:GetVoiceLength("story_v_out_319671", "319671033", "story_v_out_319671.awb") / 1000

					if var_142_10 + var_142_4 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_10 + var_142_4
					end

					if var_142_6.prefab_name ~= "" and arg_139_1.actors_[var_142_6.prefab_name] ~= nil then
						local var_142_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_6.prefab_name].transform, "story_v_out_319671", "319671033", "story_v_out_319671.awb")

						arg_139_1:RecordAudio("319671033", var_142_11)
						arg_139_1:RecordAudio("319671033", var_142_11)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_319671", "319671033", "story_v_out_319671.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_319671", "319671033", "story_v_out_319671.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_12 = math.max(var_142_5, arg_139_1.talkMaxDuration)

			if var_142_4 <= arg_139_1.time_ and arg_139_1.time_ < var_142_4 + var_142_12 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_4) / var_142_12

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_4 + var_142_12 and arg_139_1.time_ < var_142_4 + var_142_12 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_139_1:InitPlayNodeList()
	end,
	Play319671034 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 319671034
		arg_143_1.duration_ = 5

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play319671035(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(arg_143_1.actors_["1095ui_story"]) and arg_143_1.var_.characterEffect1095ui_story == nil then
				arg_143_1.var_.characterEffect1095ui_story = arg_143_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_0 = 0.200000002980232

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_0 and not isNil(arg_143_1.actors_["1095ui_story"]) then
				if arg_143_1.var_.characterEffect1095ui_story and not isNil(arg_143_1.actors_["1095ui_story"]) then
					arg_143_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_143_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_143_1.time_ - 0) / var_146_0)
				end
			end

			if arg_143_1.time_ >= 0 + var_146_0 and arg_143_1.time_ < 0 + var_146_0 + arg_146_0 and not isNil(arg_143_1.actors_["1095ui_story"]) and arg_143_1.var_.characterEffect1095ui_story then
				arg_143_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_143_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_146_1 = arg_143_1.actors_["1095ui_story"].transform

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.var_.moveOldPos1095ui_story = var_146_1.localPosition
			end

			local var_146_2 = 0.001

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_2 then
				var_146_1.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_143_1.time_ - 0) / var_146_2)
				var_146_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_146_1.position).x, (manager.ui.mainCamera.transform.position - var_146_1.position).y, (manager.ui.mainCamera.transform.position - var_146_1.position).z)
				var_146_1.localEulerAngles.z = 0
				var_146_1.localEulerAngles.x = 0
				var_146_1.localEulerAngles = var_146_1.localEulerAngles
			end

			if arg_143_1.time_ >= 0 + var_146_2 and arg_143_1.time_ < 0 + var_146_2 + arg_146_0 then
				var_146_1.localPosition = Vector3.New(0, 100, 0)
				var_146_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_146_1.position).x, (manager.ui.mainCamera.transform.position - var_146_1.position).y, (manager.ui.mainCamera.transform.position - var_146_1.position).z)
				var_146_1.localEulerAngles.z = 0
				var_146_1.localEulerAngles.x = 0
				var_146_1.localEulerAngles = var_146_1.localEulerAngles
			end

			local var_146_3 = 0
			local var_146_4 = 0.775

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_3 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, false)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_5 = arg_143_1:FormatText(arg_143_1:GetWordFromCfg(319671034).content)

				arg_143_1.text_.text = var_146_5

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_7 = 31 <= 0 and var_146_4 or var_146_4 * (utf8.len(var_146_5) / 31)

				if (31 <= 0 and var_146_4 or var_146_4 * (utf8.len(var_146_5) / 31)) > 0 and var_146_4 < var_146_7 then
					arg_143_1.talkMaxDuration = var_146_7

					if var_146_7 + var_146_3 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_7 + var_146_3
					end
				end

				arg_143_1.text_.text = var_146_5
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)
				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_8 = math.max(var_146_4, arg_143_1.talkMaxDuration)

			if var_146_3 <= arg_143_1.time_ and arg_143_1.time_ < var_146_3 + var_146_8 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_3) / var_146_8

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_3 + var_146_8 and arg_143_1.time_ < var_146_3 + var_146_8 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
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
	Play319671035 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 319671035
		arg_147_1.duration_ = 5

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play319671036(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = 0.875

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, false)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_1 = arg_147_1:FormatText(arg_147_1:GetWordFromCfg(319671035).content)

				arg_147_1.text_.text = var_150_1

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_3 = 35 <= 0 and var_150_0 or var_150_0 * (utf8.len(var_150_1) / 35)

				if (35 <= 0 and var_150_0 or var_150_0 * (utf8.len(var_150_1) / 35)) > 0 and var_150_0 < var_150_3 then
					arg_147_1.talkMaxDuration = var_150_3

					if var_150_3 + 0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_3 + 0
					end
				end

				arg_147_1.text_.text = var_150_1
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)
				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_4 = math.max(var_150_0, arg_147_1.talkMaxDuration)

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_4 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - 0) / var_150_4

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= 0 + var_150_4 and arg_147_1.time_ < 0 + var_150_4 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play319671036 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 319671036
		arg_151_1.duration_ = 4.54

		local var_151_0 = {
			zh = 3.975,
			ja = 4.541
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
				arg_151_0:Play319671037(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if arg_151_1.bgs_.ST69 == nil then
				local var_154_0 = Object.Instantiate(arg_151_1.paintGo_)

				var_154_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST69")
				var_154_0.name = "ST69"
				var_154_0.transform.parent = arg_151_1.stage_.transform
				var_154_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_151_1.bgs_.ST69 = var_154_0
			end

			if 1 < arg_151_1.time_ and arg_151_1.time_ <= 1 + arg_154_0 then
				local var_154_1 = arg_151_1.bgs_.ST69

				arg_151_1.bgs_.ST69.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_154_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_154_2 = var_154_1:GetComponent("SpriteRenderer")

				if var_154_2 and var_154_2.sprite then
					local var_154_3 = 2 * (var_154_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_154_1.transform.localScale = Vector3.New(var_154_3 / var_154_2.sprite.bounds.size.y < var_154_3 * manager.ui.mainCameraCom_.aspect / var_154_2.sprite.bounds.size.x and var_154_3 * manager.ui.mainCameraCom_.aspect / var_154_2.sprite.bounds.size.x or var_154_3 / var_154_2.sprite.bounds.size.y, var_154_3 / var_154_2.sprite.bounds.size.y < var_154_3 * manager.ui.mainCameraCom_.aspect / var_154_2.sprite.bounds.size.x and var_154_3 * manager.ui.mainCameraCom_.aspect / var_154_2.sprite.bounds.size.x or var_154_3 / var_154_2.sprite.bounds.size.y, 0)
				end

				for iter_154_0, iter_154_1 in pairs(arg_151_1.bgs_) do
					if iter_154_0 ~= "ST69" then
						iter_154_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_154_4 = 0

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_4 + arg_154_0 then
				arg_151_1.allBtn_.enabled = false
			end

			if arg_151_1.time_ >= var_154_4 + 0.3 and arg_151_1.time_ < var_154_4 + 0.3 + arg_154_0 then
				arg_151_1.allBtn_.enabled = true
			end

			local var_154_5 = 0

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_5 + arg_154_0 then
				arg_151_1.mask_.enabled = true
				arg_151_1.mask_.raycastTarget = true

				arg_151_1:SetGaussion(false)
			end

			local var_154_6 = 1

			if var_154_5 <= arg_151_1.time_ and arg_151_1.time_ < var_154_5 + var_154_6 then
				local var_154_7 = Color.New(0, 0, 0)

				var_154_7.a = Mathf.Lerp(0, 1, (arg_151_1.time_ - var_154_5) / var_154_6)
				arg_151_1.mask_.color = var_154_7
			end

			if arg_151_1.time_ >= var_154_5 + var_154_6 and arg_151_1.time_ < var_154_5 + var_154_6 + arg_154_0 then
				local var_154_8 = Color.New(0, 0, 0)

				var_154_8.a = 1
				arg_151_1.mask_.color = var_154_8
			end

			local var_154_9 = 1

			if 1 < arg_151_1.time_ and arg_151_1.time_ <= var_154_9 + arg_154_0 then
				arg_151_1.mask_.enabled = true
				arg_151_1.mask_.raycastTarget = true

				arg_151_1:SetGaussion(false)
			end

			local var_154_10 = 2

			if var_154_9 <= arg_151_1.time_ and arg_151_1.time_ < var_154_9 + var_154_10 then
				local var_154_11 = Color.New(0, 0, 0)

				var_154_11.a = Mathf.Lerp(1, 0, (arg_151_1.time_ - var_154_9) / var_154_10)
				arg_151_1.mask_.color = var_154_11
			end

			if arg_151_1.time_ >= var_154_9 + var_154_10 and arg_151_1.time_ < var_154_9 + var_154_10 + arg_154_0 then
				local var_154_12 = Color.New(0, 0, 0)

				arg_151_1.mask_.enabled = false
				var_154_12.a = 0
				arg_151_1.mask_.color = var_154_12
			end

			local var_154_13 = arg_151_1.actors_["1095ui_story"].transform

			if 1 < arg_151_1.time_ and arg_151_1.time_ <= 1 + arg_154_0 then
				arg_151_1.var_.moveOldPos1095ui_story = var_154_13.localPosition
			end

			local var_154_14 = 0.001

			if 1 <= arg_151_1.time_ and arg_151_1.time_ < 1 + var_154_14 then
				var_154_13.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_151_1.time_ - 1) / var_154_14)
				var_154_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_154_13.position).x, (manager.ui.mainCamera.transform.position - var_154_13.position).y, (manager.ui.mainCamera.transform.position - var_154_13.position).z)
				var_154_13.localEulerAngles.z = 0
				var_154_13.localEulerAngles.x = 0
				var_154_13.localEulerAngles = var_154_13.localEulerAngles
			end

			if arg_151_1.time_ >= 1 + var_154_14 and arg_151_1.time_ < 1 + var_154_14 + arg_154_0 then
				var_154_13.localPosition = Vector3.New(0, 100, 0)
				var_154_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_154_13.position).x, (manager.ui.mainCamera.transform.position - var_154_13.position).y, (manager.ui.mainCamera.transform.position - var_154_13.position).z)
				var_154_13.localEulerAngles.z = 0
				var_154_13.localEulerAngles.x = 0
				var_154_13.localEulerAngles = var_154_13.localEulerAngles
			end

			local var_154_15 = arg_151_1.actors_["1095ui_story"]

			if 1 < arg_151_1.time_ and arg_151_1.time_ <= 1 + arg_154_0 and not isNil(var_154_15) and arg_151_1.var_.characterEffect1095ui_story == nil then
				arg_151_1.var_.characterEffect1095ui_story = var_154_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_16 = 0.200000002980232

			if 1 <= arg_151_1.time_ and arg_151_1.time_ < 1 + var_154_16 and not isNil(var_154_15) then
				if arg_151_1.var_.characterEffect1095ui_story and not isNil(var_154_15) then
					arg_151_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_151_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_151_1.time_ - 1) / var_154_16)
				end
			end

			if arg_151_1.time_ >= 1 + var_154_16 and arg_151_1.time_ < 1 + var_154_16 + arg_154_0 and not isNil(var_154_15) and arg_151_1.var_.characterEffect1095ui_story then
				arg_151_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_151_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_154_17 = arg_151_1.actors_["1084ui_story"].transform

			if 1 < arg_151_1.time_ and arg_151_1.time_ <= 1 + arg_154_0 then
				arg_151_1.var_.moveOldPos1084ui_story = var_154_17.localPosition
			end

			local var_154_18 = 0.001

			if 1 <= arg_151_1.time_ and arg_151_1.time_ < 1 + var_154_18 then
				var_154_17.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_151_1.time_ - 1) / var_154_18)
				var_154_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_154_17.position).x, (manager.ui.mainCamera.transform.position - var_154_17.position).y, (manager.ui.mainCamera.transform.position - var_154_17.position).z)
				var_154_17.localEulerAngles.z = 0
				var_154_17.localEulerAngles.x = 0
				var_154_17.localEulerAngles = var_154_17.localEulerAngles
			end

			if arg_151_1.time_ >= 1 + var_154_18 and arg_151_1.time_ < 1 + var_154_18 + arg_154_0 then
				var_154_17.localPosition = Vector3.New(0, 100, 0)
				var_154_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_154_17.position).x, (manager.ui.mainCamera.transform.position - var_154_17.position).y, (manager.ui.mainCamera.transform.position - var_154_17.position).z)
				var_154_17.localEulerAngles.z = 0
				var_154_17.localEulerAngles.x = 0
				var_154_17.localEulerAngles = var_154_17.localEulerAngles
			end

			local var_154_19 = arg_151_1.actors_["1084ui_story"]

			if 1 < arg_151_1.time_ and arg_151_1.time_ <= 1 + arg_154_0 and not isNil(var_154_19) and arg_151_1.var_.characterEffect1084ui_story == nil then
				arg_151_1.var_.characterEffect1084ui_story = var_154_19:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_20 = 0.200000002980232

			if 1 <= arg_151_1.time_ and arg_151_1.time_ < 1 + var_154_20 and not isNil(var_154_19) then
				if arg_151_1.var_.characterEffect1084ui_story and not isNil(var_154_19) then
					arg_151_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_151_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_151_1.time_ - 1) / var_154_20)
				end
			end

			if arg_151_1.time_ >= 1 + var_154_20 and arg_151_1.time_ < 1 + var_154_20 + arg_154_0 and not isNil(var_154_19) and arg_151_1.var_.characterEffect1084ui_story then
				arg_151_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_151_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if arg_151_1.frameCnt_ <= 1 then
				arg_151_1.dialog_:SetActive(false)
			end

			local var_154_21 = 2.875
			local var_154_22 = 0.125

			if 2.875 < arg_151_1.time_ and arg_151_1.time_ <= var_154_21 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0

				arg_151_1.dialog_:SetActive(true)

				arg_151_1.dialogCg_.alpha = 0

				local var_154_23 = LeanTween.value(arg_151_1.dialog_, 0, 1, 0.3)

				var_154_23:setOnUpdate(LuaHelper.FloatAction(function(arg_155_0)
					arg_151_1.dialogCg_.alpha = arg_155_0
				end))
				var_154_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_151_1.dialog_)
					var_154_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_151_1.duration_ = arg_151_1.duration_ + 0.3

				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[660].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, true)
				arg_151_1.iconController_:SetSelectedState("hero")

				arg_151_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_151_1.callingController_:SetSelectedState("normal")

				arg_151_1.keyicon_.color = Color.New(1, 1, 1)
				arg_151_1.icon_.color = Color.New(1, 1, 1)

				local var_154_24 = arg_151_1:GetWordFromCfg(319671036)
				local var_154_25 = arg_151_1:FormatText(var_154_24.content)

				arg_151_1.text_.text = var_154_25

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_27 = 5 <= 0 and var_154_22 or var_154_22 * (utf8.len(var_154_25) / 5)

				if (5 <= 0 and var_154_22 or var_154_22 * (utf8.len(var_154_25) / 5)) > 0 and var_154_22 < var_154_27 then
					arg_151_1.talkMaxDuration = var_154_27
					var_154_21 = var_154_21 + 0.3

					if var_154_27 + var_154_21 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_27 + var_154_21
					end
				end

				arg_151_1.text_.text = var_154_25
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671036", "story_v_out_319671.awb") ~= 0 then
					local var_154_28 = manager.audio:GetVoiceLength("story_v_out_319671", "319671036", "story_v_out_319671.awb") / 1000

					if var_154_28 + var_154_21 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_28 + var_154_21
					end

					if var_154_24.prefab_name ~= "" and arg_151_1.actors_[var_154_24.prefab_name] ~= nil then
						local var_154_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_24.prefab_name].transform, "story_v_out_319671", "319671036", "story_v_out_319671.awb")

						arg_151_1:RecordAudio("319671036", var_154_29)
						arg_151_1:RecordAudio("319671036", var_154_29)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_319671", "319671036", "story_v_out_319671.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_319671", "319671036", "story_v_out_319671.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_30 = var_154_21 + 0.3
			local var_154_31 = math.max(var_154_22, arg_151_1.talkMaxDuration)

			if var_154_21 + 0.3 <= arg_151_1.time_ and arg_151_1.time_ < var_154_30 + var_154_31 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_30) / var_154_31

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_30 + var_154_31 and arg_151_1.time_ < var_154_30 + var_154_31 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_151_1:InitPlayNodeList()
	end,
	Play319671037 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 319671037
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play319671038(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = 0.75

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, false)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_1 = arg_157_1:FormatText(arg_157_1:GetWordFromCfg(319671037).content)

				arg_157_1.text_.text = var_160_1

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_3 = 30 <= 0 and var_160_0 or var_160_0 * (utf8.len(var_160_1) / 30)

				if (30 <= 0 and var_160_0 or var_160_0 * (utf8.len(var_160_1) / 30)) > 0 and var_160_0 < var_160_3 then
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
	Play319671038 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 319671038
		arg_161_1.duration_ = 5

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play319671039(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 0.925

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, false)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_1 = arg_161_1:FormatText(arg_161_1:GetWordFromCfg(319671038).content)

				arg_161_1.text_.text = var_164_1

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_3 = 37 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_1) / 37)

				if (37 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_1) / 37)) > 0 and var_164_0 < var_164_3 then
					arg_161_1.talkMaxDuration = var_164_3

					if var_164_3 + 0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_3 + 0
					end
				end

				arg_161_1.text_.text = var_164_1
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_4 = math.max(var_164_0, arg_161_1.talkMaxDuration)

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_4 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - 0) / var_164_4

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= 0 + var_164_4 and arg_161_1.time_ < 0 + var_164_4 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play319671039 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 319671039
		arg_165_1.duration_ = 6.1

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play319671040(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_9000

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_168_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_165_1.bgmTxt_.text ~= var_168_2 and arg_165_1.bgmTxt_.text ~= "" then
						if arg_165_1.bgmTxt2_.text ~= "" then
							arg_165_1.bgmTxt_.text = arg_165_1.bgmTxt2_.text
						end

						arg_165_1.bgmTxt2_.text = var_168_2

						arg_165_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_165_1.bgmTxt_.text = var_168_2
						arg_165_1.bgmTxt2_.text = var_168_2
					end

					if arg_165_1.bgmTimer then
						arg_165_1.bgmTimer:Stop()

						arg_165_1.bgmTimer = nil
					end

					if arg_165_1.settingData.show_music_name == 1 then
						arg_165_1.musicController:SetSelectedState("show")
						arg_165_1.musicAnimator_:Play("open", 0, 0)

						if arg_165_1.settingData.music_time ~= 0 then
							arg_165_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_165_1.settingData.music_time), function()
								if arg_165_1 == nil or isNil(arg_165_1.bgmTxt_) then
									return
								end

								arg_165_1.musicController:SetSelectedState("hide")
								arg_165_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				local var_168_3 = arg_165_1.var_.effect119

				if not arg_165_1.var_.effect119 then
					var_168_3 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), manager.ui.mainCamera.transform)
					var_168_3.name = "119"
					arg_165_1.var_.effect119 = var_168_3
				else
					var_168_3.transform:SetParent(var_168_9000)
				end

				var_168_3.transform.localPosition = Vector3.New(0, 0, 0)
				var_168_3.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if arg_165_1.frameCnt_ <= 1 then
				arg_165_1.dialog_:SetActive(false)
			end

			local var_168_5 = 1.1
			local var_168_6 = 1.425

			if 1.1 < arg_165_1.time_ and arg_165_1.time_ <= var_168_5 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0

				arg_165_1.dialog_:SetActive(true)

				arg_165_1.dialogCg_.alpha = 0

				local var_168_7 = LeanTween.value(arg_165_1.dialog_, 0, 1, 0.3)

				var_168_7:setOnUpdate(LuaHelper.FloatAction(function(arg_170_0)
					arg_165_1.dialogCg_.alpha = arg_170_0
				end))
				var_168_7:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_165_1.dialog_)
					var_168_7:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_165_1.duration_ = arg_165_1.duration_ + 0.3

				SetActive(arg_165_1.leftNameGo_, false)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_8 = arg_165_1:FormatText(arg_165_1:GetWordFromCfg(319671039).content)

				arg_165_1.text_.text = var_168_8

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_10 = 57 <= 0 and var_168_6 or var_168_6 * (utf8.len(var_168_8) / 57)

				if (57 <= 0 and var_168_6 or var_168_6 * (utf8.len(var_168_8) / 57)) > 0 and var_168_6 < var_168_10 then
					arg_165_1.talkMaxDuration = var_168_10
					var_168_5 = var_168_5 + 0.3

					if var_168_10 + var_168_5 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_10 + var_168_5
					end
				end

				arg_165_1.text_.text = var_168_8
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)
				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_11 = var_168_5 + 0.3
			local var_168_12 = math.max(var_168_6, arg_165_1.talkMaxDuration)

			if var_168_5 + 0.3 <= arg_165_1.time_ and arg_165_1.time_ < var_168_11 + var_168_12 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_11) / var_168_12

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_11 + var_168_12 and arg_165_1.time_ < var_168_11 + var_168_12 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play319671040 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 319671040
		arg_172_1.duration_ = 3

		local var_172_0 = {
			zh = 2.3,
			ja = 3
		}
		local var_172_1 = manager.audio:GetLocalizationFlag()

		if var_172_0[var_172_1] ~= nil then
			arg_172_1.duration_ = var_172_0[var_172_1]
		end

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play319671041(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			if arg_172_1.actors_["10014ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10014ui_story"))) then
				local var_175_0 = Object.Instantiate(Asset.Load("Char/" .. "10014ui_story"), arg_172_1.stage_.transform)

				var_175_0.name = "10014ui_story"
				var_175_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_172_1.actors_["10014ui_story"] = var_175_0

				local var_175_1 = var_175_0:GetComponentInChildren(typeof(CharacterEffect))

				var_175_1.enabled = true

				local var_175_2 = GameObjectTools.GetOrAddComponent(var_175_0, typeof(DynamicBoneHelper))

				if var_175_2 then
					var_175_2:EnableDynamicBone(false)
				end

				arg_172_1:ShowWeapon(var_175_1.transform, false)

				arg_172_1.var_["10014ui_story" .. "Animator"] = var_175_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_172_1.var_["10014ui_story" .. "Animator"].applyRootMotion = true
				arg_172_1.var_["10014ui_story" .. "LipSync"] = var_175_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_175_3 = arg_172_1.actors_["10014ui_story"].transform

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 then
				arg_172_1.var_.moveOldPos10014ui_story = var_175_3.localPosition
			end

			local var_175_4 = 0.001

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_4 then
				var_175_3.localPosition = Vector3.Lerp(arg_172_1.var_.moveOldPos10014ui_story, Vector3.New(0, -1.06, -6.2), (arg_172_1.time_ - 0) / var_175_4)
				var_175_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_175_3.position).x, (manager.ui.mainCamera.transform.position - var_175_3.position).y, (manager.ui.mainCamera.transform.position - var_175_3.position).z)
				var_175_3.localEulerAngles.z = 0
				var_175_3.localEulerAngles.x = 0
				var_175_3.localEulerAngles = var_175_3.localEulerAngles
			end

			if arg_172_1.time_ >= 0 + var_175_4 and arg_172_1.time_ < 0 + var_175_4 + arg_175_0 then
				var_175_3.localPosition = Vector3.New(0, -1.06, -6.2)
				var_175_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_175_3.position).x, (manager.ui.mainCamera.transform.position - var_175_3.position).y, (manager.ui.mainCamera.transform.position - var_175_3.position).z)
				var_175_3.localEulerAngles.z = 0
				var_175_3.localEulerAngles.x = 0
				var_175_3.localEulerAngles = var_175_3.localEulerAngles
			end

			local var_175_5 = arg_172_1.actors_["10014ui_story"]

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 and not isNil(var_175_5) and arg_172_1.var_.characterEffect10014ui_story == nil then
				arg_172_1.var_.characterEffect10014ui_story = var_175_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_6 = 0.200000002980232

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_6 and not isNil(var_175_5) then
				if arg_172_1.var_.characterEffect10014ui_story and not isNil(var_175_5) then
					arg_172_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_172_1.time_ >= 0 + var_175_6 and arg_172_1.time_ < 0 + var_175_6 + arg_175_0 and not isNil(var_175_5) and arg_172_1.var_.characterEffect10014ui_story then
				arg_172_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 then
				arg_172_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action1_1")
			end

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 then
				arg_172_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 then
				arg_172_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_175_10 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_172_1.bgmTxt_.text ~= var_175_10 and arg_172_1.bgmTxt_.text ~= "" then
						if arg_172_1.bgmTxt2_.text ~= "" then
							arg_172_1.bgmTxt_.text = arg_172_1.bgmTxt2_.text
						end

						arg_172_1.bgmTxt2_.text = var_175_10

						arg_172_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_172_1.bgmTxt_.text = var_175_10
						arg_172_1.bgmTxt2_.text = var_175_10
					end

					if arg_172_1.bgmTimer then
						arg_172_1.bgmTimer:Stop()

						arg_172_1.bgmTimer = nil
					end

					if arg_172_1.settingData.show_music_name == 1 then
						arg_172_1.musicController:SetSelectedState("show")
						arg_172_1.musicAnimator_:Play("open", 0, 0)

						if arg_172_1.settingData.music_time ~= 0 then
							arg_172_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_172_1.settingData.music_time), function()
								if arg_172_1 == nil or isNil(arg_172_1.bgmTxt_) then
									return
								end

								arg_172_1.musicController:SetSelectedState("hide")
								arg_172_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.233333333333333 < arg_172_1.time_ and arg_172_1.time_ <= 0.233333333333333 + arg_175_0 then
				arg_172_1:AudioAction("play", "music", "bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue.awb")

				local var_175_13 = manager.audio:GetAudioName("bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue")

				if "" ~= "" then
					if arg_172_1.bgmTxt_.text ~= var_175_13 and arg_172_1.bgmTxt_.text ~= "" then
						if arg_172_1.bgmTxt2_.text ~= "" then
							arg_172_1.bgmTxt_.text = arg_172_1.bgmTxt2_.text
						end

						arg_172_1.bgmTxt2_.text = var_175_13

						arg_172_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_172_1.bgmTxt_.text = var_175_13
						arg_172_1.bgmTxt2_.text = var_175_13
					end

					if arg_172_1.bgmTimer then
						arg_172_1.bgmTimer:Stop()

						arg_172_1.bgmTimer = nil
					end

					if arg_172_1.settingData.show_music_name == 1 then
						arg_172_1.musicController:SetSelectedState("show")
						arg_172_1.musicAnimator_:Play("open", 0, 0)

						if arg_172_1.settingData.music_time ~= 0 then
							arg_172_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_172_1.settingData.music_time), function()
								if arg_172_1 == nil or isNil(arg_172_1.bgmTxt_) then
									return
								end

								arg_172_1.musicController:SetSelectedState("hide")
								arg_172_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 then
				if arg_172_1.var_.effect119 then
					Object.Destroy(arg_172_1.var_.effect119)

					arg_172_1.var_.effect119 = nil
				end
			end

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 then
				if arg_172_1.var_.characterEffect10014ui_story == nil then
					arg_172_1.var_.characterEffect10014ui_story = arg_172_1.actors_["10014ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_175_15 = arg_172_1.var_.characterEffect10014ui_story

				arg_172_1.var_.characterEffect10014ui_story.imageEffect:turnOff()

				var_175_15.interferenceEffect.enabled = true
				var_175_15.interferenceEffect.noise = 0.001
				var_175_15.interferenceEffect.simTimeScale = 1
				var_175_15.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 then
				if arg_172_1.var_.characterEffect10014ui_story == nil then
					arg_172_1.var_.characterEffect10014ui_story = arg_172_1.actors_["10014ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_172_1.var_.characterEffect10014ui_story.imageEffect:turnOn(false)
			end

			local var_175_17 = 0
			local var_175_18 = 0.225

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= var_175_17 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				arg_172_1.leftNameTxt_.text = arg_172_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_19 = arg_172_1:GetWordFromCfg(319671040)
				local var_175_20 = arg_172_1:FormatText(var_175_19.content)

				arg_172_1.text_.text = var_175_20

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_22 = 9 <= 0 and var_175_18 or var_175_18 * (utf8.len(var_175_20) / 9)

				if (9 <= 0 and var_175_18 or var_175_18 * (utf8.len(var_175_20) / 9)) > 0 and var_175_18 < var_175_22 then
					arg_172_1.talkMaxDuration = var_175_22

					if var_175_22 + var_175_17 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_22 + var_175_17
					end
				end

				arg_172_1.text_.text = var_175_20
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671040", "story_v_out_319671.awb") ~= 0 then
					local var_175_23 = manager.audio:GetVoiceLength("story_v_out_319671", "319671040", "story_v_out_319671.awb") / 1000

					if var_175_23 + var_175_17 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_23 + var_175_17
					end

					if var_175_19.prefab_name ~= "" and arg_172_1.actors_[var_175_19.prefab_name] ~= nil then
						local var_175_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_172_1.actors_[var_175_19.prefab_name].transform, "story_v_out_319671", "319671040", "story_v_out_319671.awb")

						arg_172_1:RecordAudio("319671040", var_175_24)
						arg_172_1:RecordAudio("319671040", var_175_24)
					else
						arg_172_1:AudioAction("play", "voice", "story_v_out_319671", "319671040", "story_v_out_319671.awb")
					end

					arg_172_1:RecordHistoryTalkVoice("story_v_out_319671", "319671040", "story_v_out_319671.awb")
				end

				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_25 = math.max(var_175_18, arg_172_1.talkMaxDuration)

			if var_175_17 <= arg_172_1.time_ and arg_172_1.time_ < var_175_17 + var_175_25 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_17) / var_175_25

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_17 + var_175_25 and arg_172_1.time_ < var_175_17 + var_175_25 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_172_1:InitPlayNodeList()
	end,
	Play319671041 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 319671041
		arg_178_1.duration_ = 4.9

		local var_178_0 = {
			zh = 3.066,
			ja = 4.9
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
				arg_178_0:Play319671042(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1.var_.moveOldPos1084ui_story = arg_178_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_181_0 = 0.001

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_0 then
				arg_178_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_178_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_178_1.time_ - 0) / var_181_0)
				arg_178_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_178_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_178_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_178_1.actors_["1084ui_story"].transform.position).z)
				arg_178_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_178_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_178_1.actors_["1084ui_story"].transform.localEulerAngles = arg_178_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_178_1.time_ >= 0 + var_181_0 and arg_178_1.time_ < 0 + var_181_0 + arg_181_0 then
				arg_178_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0.7, -0.97, -6)
				arg_178_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_178_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_178_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_178_1.actors_["1084ui_story"].transform.position).z)
				arg_178_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_178_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_178_1.actors_["1084ui_story"].transform.localEulerAngles = arg_178_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_181_1 = arg_178_1.actors_["1084ui_story"]

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 and not isNil(var_181_1) and arg_178_1.var_.characterEffect1084ui_story == nil then
				arg_178_1.var_.characterEffect1084ui_story = var_181_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_181_2 = 0.200000002980232

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_2 and not isNil(var_181_1) then
				if arg_178_1.var_.characterEffect1084ui_story and not isNil(var_181_1) then
					arg_178_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_178_1.time_ >= 0 + var_181_2 and arg_178_1.time_ < 0 + var_181_2 + arg_181_0 and not isNil(var_181_1) and arg_178_1.var_.characterEffect1084ui_story then
				arg_178_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_181_4 = arg_178_1.actors_["10014ui_story"].transform

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1.var_.moveOldPos10014ui_story = var_181_4.localPosition
			end

			local var_181_5 = 0.001

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_5 then
				var_181_4.localPosition = Vector3.Lerp(arg_178_1.var_.moveOldPos10014ui_story, Vector3.New(-0.7, -1.06, -6.2), (arg_178_1.time_ - 0) / var_181_5)
				var_181_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_181_4.position).x, (manager.ui.mainCamera.transform.position - var_181_4.position).y, (manager.ui.mainCamera.transform.position - var_181_4.position).z)
				var_181_4.localEulerAngles.z = 0
				var_181_4.localEulerAngles.x = 0
				var_181_4.localEulerAngles = var_181_4.localEulerAngles
			end

			if arg_178_1.time_ >= 0 + var_181_5 and arg_178_1.time_ < 0 + var_181_5 + arg_181_0 then
				var_181_4.localPosition = Vector3.New(-0.7, -1.06, -6.2)
				var_181_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_181_4.position).x, (manager.ui.mainCamera.transform.position - var_181_4.position).y, (manager.ui.mainCamera.transform.position - var_181_4.position).z)
				var_181_4.localEulerAngles.z = 0
				var_181_4.localEulerAngles.x = 0
				var_181_4.localEulerAngles = var_181_4.localEulerAngles
			end

			local var_181_6 = arg_178_1.actors_["10014ui_story"]

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 and not isNil(var_181_6) and arg_178_1.var_.characterEffect10014ui_story == nil then
				arg_178_1.var_.characterEffect10014ui_story = var_181_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_181_7 = 0.200000002980232

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_7 and not isNil(var_181_6) then
				if arg_178_1.var_.characterEffect10014ui_story and not isNil(var_181_6) then
					arg_178_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_178_1.var_.characterEffect10014ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_178_1.time_ - 0) / var_181_7)
				end
			end

			if arg_178_1.time_ >= 0 + var_181_7 and arg_178_1.time_ < 0 + var_181_7 + arg_181_0 and not isNil(var_181_6) and arg_178_1.var_.characterEffect10014ui_story then
				arg_178_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_178_1.var_.characterEffect10014ui_story.fillRatio = 0.5
			end

			local var_181_8 = 0
			local var_181_9 = 0.25

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= var_181_8 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				arg_178_1.leftNameTxt_.text = arg_178_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_10 = arg_178_1:GetWordFromCfg(319671041)
				local var_181_11 = arg_178_1:FormatText(var_181_10.content)

				arg_178_1.text_.text = var_181_11

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_13 = 10 <= 0 and var_181_9 or var_181_9 * (utf8.len(var_181_11) / 10)

				if (10 <= 0 and var_181_9 or var_181_9 * (utf8.len(var_181_11) / 10)) > 0 and var_181_9 < var_181_13 then
					arg_178_1.talkMaxDuration = var_181_13

					if var_181_13 + var_181_8 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_13 + var_181_8
					end
				end

				arg_178_1.text_.text = var_181_11
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671041", "story_v_out_319671.awb") ~= 0 then
					local var_181_14 = manager.audio:GetVoiceLength("story_v_out_319671", "319671041", "story_v_out_319671.awb") / 1000

					if var_181_14 + var_181_8 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_14 + var_181_8
					end

					if var_181_10.prefab_name ~= "" and arg_178_1.actors_[var_181_10.prefab_name] ~= nil then
						local var_181_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_178_1.actors_[var_181_10.prefab_name].transform, "story_v_out_319671", "319671041", "story_v_out_319671.awb")

						arg_178_1:RecordAudio("319671041", var_181_15)
						arg_178_1:RecordAudio("319671041", var_181_15)
					else
						arg_178_1:AudioAction("play", "voice", "story_v_out_319671", "319671041", "story_v_out_319671.awb")
					end

					arg_178_1:RecordHistoryTalkVoice("story_v_out_319671", "319671041", "story_v_out_319671.awb")
				end

				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_16 = math.max(var_181_9, arg_178_1.talkMaxDuration)

			if var_181_8 <= arg_178_1.time_ and arg_178_1.time_ < var_181_8 + var_181_16 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_8) / var_181_16

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_8 + var_181_16 and arg_178_1.time_ < var_181_8 + var_181_16 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_178_1:InitPlayNodeList()
	end,
	Play319671042 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 319671042
		arg_182_1.duration_ = 13.57

		local var_182_0 = {
			zh = 9.166,
			ja = 13.566
		}
		local var_182_1 = manager.audio:GetLocalizationFlag()

		if var_182_0[var_182_1] ~= nil then
			arg_182_1.duration_ = var_182_0[var_182_1]
		end

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play319671043(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 and not isNil(arg_182_1.actors_["1084ui_story"]) and arg_182_1.var_.characterEffect1084ui_story == nil then
				arg_182_1.var_.characterEffect1084ui_story = arg_182_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_185_0 = 0.200000002980232

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_0 and not isNil(arg_182_1.actors_["1084ui_story"]) then
				if arg_182_1.var_.characterEffect1084ui_story and not isNil(arg_182_1.actors_["1084ui_story"]) then
					arg_182_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_182_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_182_1.time_ - 0) / var_185_0)
				end
			end

			if arg_182_1.time_ >= 0 + var_185_0 and arg_182_1.time_ < 0 + var_185_0 + arg_185_0 and not isNil(arg_182_1.actors_["1084ui_story"]) and arg_182_1.var_.characterEffect1084ui_story then
				arg_182_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_182_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action1_1")
			end

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_185_1 = arg_182_1.actors_["10014ui_story"]

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 and not isNil(var_185_1) and arg_182_1.var_.characterEffect10014ui_story == nil then
				arg_182_1.var_.characterEffect10014ui_story = var_185_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_185_2 = 0.200000002980232

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_2 and not isNil(var_185_1) then
				if arg_182_1.var_.characterEffect10014ui_story and not isNil(var_185_1) then
					arg_182_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_182_1.time_ >= 0 + var_185_2 and arg_182_1.time_ < 0 + var_185_2 + arg_185_0 and not isNil(var_185_1) and arg_182_1.var_.characterEffect10014ui_story then
				arg_182_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_185_4 = 0
			local var_185_5 = 1.025

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= var_185_4 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				arg_182_1.leftNameTxt_.text = arg_182_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_6 = arg_182_1:GetWordFromCfg(319671042)
				local var_185_7 = arg_182_1:FormatText(var_185_6.content)

				arg_182_1.text_.text = var_185_7

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_9 = 41 <= 0 and var_185_5 or var_185_5 * (utf8.len(var_185_7) / 41)

				if (41 <= 0 and var_185_5 or var_185_5 * (utf8.len(var_185_7) / 41)) > 0 and var_185_5 < var_185_9 then
					arg_182_1.talkMaxDuration = var_185_9

					if var_185_9 + var_185_4 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_9 + var_185_4
					end
				end

				arg_182_1.text_.text = var_185_7
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671042", "story_v_out_319671.awb") ~= 0 then
					local var_185_10 = manager.audio:GetVoiceLength("story_v_out_319671", "319671042", "story_v_out_319671.awb") / 1000

					if var_185_10 + var_185_4 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_10 + var_185_4
					end

					if var_185_6.prefab_name ~= "" and arg_182_1.actors_[var_185_6.prefab_name] ~= nil then
						local var_185_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_182_1.actors_[var_185_6.prefab_name].transform, "story_v_out_319671", "319671042", "story_v_out_319671.awb")

						arg_182_1:RecordAudio("319671042", var_185_11)
						arg_182_1:RecordAudio("319671042", var_185_11)
					else
						arg_182_1:AudioAction("play", "voice", "story_v_out_319671", "319671042", "story_v_out_319671.awb")
					end

					arg_182_1:RecordHistoryTalkVoice("story_v_out_319671", "319671042", "story_v_out_319671.awb")
				end

				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_12 = math.max(var_185_5, arg_182_1.talkMaxDuration)

			if var_185_4 <= arg_182_1.time_ and arg_182_1.time_ < var_185_4 + var_185_12 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_4) / var_185_12

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_4 + var_185_12 and arg_182_1.time_ < var_185_4 + var_185_12 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {}

		arg_182_1:InitPlayNodeList()
	end,
	Play319671043 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 319671043
		arg_186_1.duration_ = 9.2

		local var_186_0 = {
			zh = 4.433,
			ja = 9.2
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
				arg_186_0:Play319671044(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1.var_.moveOldPos10014ui_story = arg_186_1.actors_["10014ui_story"].transform.localPosition
			end

			local var_189_0 = 0.001

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_0 then
				arg_186_1.actors_["10014ui_story"].transform.localPosition = Vector3.Lerp(arg_186_1.var_.moveOldPos10014ui_story, Vector3.New(-0.7, -1.06, -6.2), (arg_186_1.time_ - 0) / var_189_0)
				arg_186_1.actors_["10014ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_186_1.actors_["10014ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_186_1.actors_["10014ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_186_1.actors_["10014ui_story"].transform.position).z)
				arg_186_1.actors_["10014ui_story"].transform.localEulerAngles.z = 0
				arg_186_1.actors_["10014ui_story"].transform.localEulerAngles.x = 0
				arg_186_1.actors_["10014ui_story"].transform.localEulerAngles = arg_186_1.actors_["10014ui_story"].transform.localEulerAngles
			end

			if arg_186_1.time_ >= 0 + var_189_0 and arg_186_1.time_ < 0 + var_189_0 + arg_189_0 then
				arg_186_1.actors_["10014ui_story"].transform.localPosition = Vector3.New(-0.7, -1.06, -6.2)
				arg_186_1.actors_["10014ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_186_1.actors_["10014ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_186_1.actors_["10014ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_186_1.actors_["10014ui_story"].transform.position).z)
				arg_186_1.actors_["10014ui_story"].transform.localEulerAngles.z = 0
				arg_186_1.actors_["10014ui_story"].transform.localEulerAngles.x = 0
				arg_186_1.actors_["10014ui_story"].transform.localEulerAngles = arg_186_1.actors_["10014ui_story"].transform.localEulerAngles
			end

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action4_1")
			end

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_189_1 = 0
			local var_189_2 = 0.475

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= var_189_1 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				arg_186_1.leftNameTxt_.text = arg_186_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_3 = arg_186_1:GetWordFromCfg(319671043)
				local var_189_4 = arg_186_1:FormatText(var_189_3.content)

				arg_186_1.text_.text = var_189_4

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_6 = 19 <= 0 and var_189_2 or var_189_2 * (utf8.len(var_189_4) / 19)

				if (19 <= 0 and var_189_2 or var_189_2 * (utf8.len(var_189_4) / 19)) > 0 and var_189_2 < var_189_6 then
					arg_186_1.talkMaxDuration = var_189_6

					if var_189_6 + var_189_1 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_6 + var_189_1
					end
				end

				arg_186_1.text_.text = var_189_4
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671043", "story_v_out_319671.awb") ~= 0 then
					local var_189_7 = manager.audio:GetVoiceLength("story_v_out_319671", "319671043", "story_v_out_319671.awb") / 1000

					if var_189_7 + var_189_1 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_7 + var_189_1
					end

					if var_189_3.prefab_name ~= "" and arg_186_1.actors_[var_189_3.prefab_name] ~= nil then
						local var_189_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_186_1.actors_[var_189_3.prefab_name].transform, "story_v_out_319671", "319671043", "story_v_out_319671.awb")

						arg_186_1:RecordAudio("319671043", var_189_8)
						arg_186_1:RecordAudio("319671043", var_189_8)
					else
						arg_186_1:AudioAction("play", "voice", "story_v_out_319671", "319671043", "story_v_out_319671.awb")
					end

					arg_186_1:RecordHistoryTalkVoice("story_v_out_319671", "319671043", "story_v_out_319671.awb")
				end

				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_9 = math.max(var_189_2, arg_186_1.talkMaxDuration)

			if var_189_1 <= arg_186_1.time_ and arg_186_1.time_ < var_189_1 + var_189_9 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_1) / var_189_9

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_1 + var_189_9 and arg_186_1.time_ < var_189_1 + var_189_9 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_186_1:InitPlayNodeList()
	end,
	Play319671044 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 319671044
		arg_190_1.duration_ = 5.6

		local var_190_0 = {
			zh = 4.8,
			ja = 5.6
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
				arg_190_0:Play319671045(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 then
				arg_190_1.var_.moveOldPos1084ui_story = arg_190_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_193_0 = 0.001

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_0 then
				arg_190_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_190_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_190_1.time_ - 0) / var_193_0)
				arg_190_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_190_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_190_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_190_1.actors_["1084ui_story"].transform.position).z)
				arg_190_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_190_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_190_1.actors_["1084ui_story"].transform.localEulerAngles = arg_190_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_190_1.time_ >= 0 + var_193_0 and arg_190_1.time_ < 0 + var_193_0 + arg_193_0 then
				arg_190_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0.7, -0.97, -6)
				arg_190_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_190_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_190_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_190_1.actors_["1084ui_story"].transform.position).z)
				arg_190_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_190_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_190_1.actors_["1084ui_story"].transform.localEulerAngles = arg_190_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_193_1 = arg_190_1.actors_["1084ui_story"]

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 and not isNil(var_193_1) and arg_190_1.var_.characterEffect1084ui_story == nil then
				arg_190_1.var_.characterEffect1084ui_story = var_193_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_193_2 = 0.200000002980232

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_2 and not isNil(var_193_1) then
				if arg_190_1.var_.characterEffect1084ui_story and not isNil(var_193_1) then
					arg_190_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_190_1.time_ >= 0 + var_193_2 and arg_190_1.time_ < 0 + var_193_2 + arg_193_0 and not isNil(var_193_1) and arg_190_1.var_.characterEffect1084ui_story then
				arg_190_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 then
				arg_190_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_193_4 = arg_190_1.actors_["10014ui_story"]

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 and not isNil(var_193_4) and arg_190_1.var_.characterEffect10014ui_story == nil then
				arg_190_1.var_.characterEffect10014ui_story = var_193_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_193_5 = 0.200000002980232

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_5 and not isNil(var_193_4) then
				if arg_190_1.var_.characterEffect10014ui_story and not isNil(var_193_4) then
					arg_190_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_190_1.var_.characterEffect10014ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_190_1.time_ - 0) / var_193_5)
				end
			end

			if arg_190_1.time_ >= 0 + var_193_5 and arg_190_1.time_ < 0 + var_193_5 + arg_193_0 and not isNil(var_193_4) and arg_190_1.var_.characterEffect10014ui_story then
				arg_190_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_190_1.var_.characterEffect10014ui_story.fillRatio = 0.5
			end

			local var_193_6 = 0
			local var_193_7 = 0.6

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= var_193_6 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, true)

				arg_190_1.leftNameTxt_.text = arg_190_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, false)
				arg_190_1.callingController_:SetSelectedState("normal")

				local var_193_8 = arg_190_1:GetWordFromCfg(319671044)
				local var_193_9 = arg_190_1:FormatText(var_193_8.content)

				arg_190_1.text_.text = var_193_9

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_11 = 24 <= 0 and var_193_7 or var_193_7 * (utf8.len(var_193_9) / 24)

				if (24 <= 0 and var_193_7 or var_193_7 * (utf8.len(var_193_9) / 24)) > 0 and var_193_7 < var_193_11 then
					arg_190_1.talkMaxDuration = var_193_11

					if var_193_11 + var_193_6 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_11 + var_193_6
					end
				end

				arg_190_1.text_.text = var_193_9
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671044", "story_v_out_319671.awb") ~= 0 then
					local var_193_12 = manager.audio:GetVoiceLength("story_v_out_319671", "319671044", "story_v_out_319671.awb") / 1000

					if var_193_12 + var_193_6 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_12 + var_193_6
					end

					if var_193_8.prefab_name ~= "" and arg_190_1.actors_[var_193_8.prefab_name] ~= nil then
						local var_193_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_190_1.actors_[var_193_8.prefab_name].transform, "story_v_out_319671", "319671044", "story_v_out_319671.awb")

						arg_190_1:RecordAudio("319671044", var_193_13)
						arg_190_1:RecordAudio("319671044", var_193_13)
					else
						arg_190_1:AudioAction("play", "voice", "story_v_out_319671", "319671044", "story_v_out_319671.awb")
					end

					arg_190_1:RecordHistoryTalkVoice("story_v_out_319671", "319671044", "story_v_out_319671.awb")
				end

				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_14 = math.max(var_193_7, arg_190_1.talkMaxDuration)

			if var_193_6 <= arg_190_1.time_ and arg_190_1.time_ < var_193_6 + var_193_14 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_6) / var_193_14

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_6 + var_193_14 and arg_190_1.time_ < var_193_6 + var_193_14 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {
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

		arg_190_1:InitPlayNodeList()
	end,
	Play319671045 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 319671045
		arg_194_1.duration_ = 8.73

		local var_194_0 = {
			zh = 8.733,
			ja = 7.433
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
				arg_194_0:Play319671046(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 and not isNil(arg_194_1.actors_["1084ui_story"]) and arg_194_1.var_.characterEffect1084ui_story == nil then
				arg_194_1.var_.characterEffect1084ui_story = arg_194_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_197_0 = 0.200000002980232

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_0 and not isNil(arg_194_1.actors_["1084ui_story"]) then
				if arg_194_1.var_.characterEffect1084ui_story and not isNil(arg_194_1.actors_["1084ui_story"]) then
					arg_194_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_194_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_194_1.time_ - 0) / var_197_0)
				end
			end

			if arg_194_1.time_ >= 0 + var_197_0 and arg_194_1.time_ < 0 + var_197_0 + arg_197_0 and not isNil(arg_194_1.actors_["1084ui_story"]) and arg_194_1.var_.characterEffect1084ui_story then
				arg_194_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_194_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_197_1 = arg_194_1.actors_["10014ui_story"]

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 and not isNil(var_197_1) and arg_194_1.var_.characterEffect10014ui_story == nil then
				arg_194_1.var_.characterEffect10014ui_story = var_197_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_197_2 = 0.200000002980232

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_2 and not isNil(var_197_1) then
				if arg_194_1.var_.characterEffect10014ui_story and not isNil(var_197_1) then
					arg_194_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_194_1.time_ >= 0 + var_197_2 and arg_194_1.time_ < 0 + var_197_2 + arg_197_0 and not isNil(var_197_1) and arg_194_1.var_.characterEffect10014ui_story then
				arg_194_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_197_4 = 0
			local var_197_5 = 1.025

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= var_197_4 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				arg_194_1.leftNameTxt_.text = arg_194_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, false)
				arg_194_1.callingController_:SetSelectedState("normal")

				local var_197_6 = arg_194_1:GetWordFromCfg(319671045)
				local var_197_7 = arg_194_1:FormatText(var_197_6.content)

				arg_194_1.text_.text = var_197_7

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_9 = 41 <= 0 and var_197_5 or var_197_5 * (utf8.len(var_197_7) / 41)

				if (41 <= 0 and var_197_5 or var_197_5 * (utf8.len(var_197_7) / 41)) > 0 and var_197_5 < var_197_9 then
					arg_194_1.talkMaxDuration = var_197_9

					if var_197_9 + var_197_4 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_9 + var_197_4
					end
				end

				arg_194_1.text_.text = var_197_7
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671045", "story_v_out_319671.awb") ~= 0 then
					local var_197_10 = manager.audio:GetVoiceLength("story_v_out_319671", "319671045", "story_v_out_319671.awb") / 1000

					if var_197_10 + var_197_4 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_10 + var_197_4
					end

					if var_197_6.prefab_name ~= "" and arg_194_1.actors_[var_197_6.prefab_name] ~= nil then
						local var_197_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_194_1.actors_[var_197_6.prefab_name].transform, "story_v_out_319671", "319671045", "story_v_out_319671.awb")

						arg_194_1:RecordAudio("319671045", var_197_11)
						arg_194_1:RecordAudio("319671045", var_197_11)
					else
						arg_194_1:AudioAction("play", "voice", "story_v_out_319671", "319671045", "story_v_out_319671.awb")
					end

					arg_194_1:RecordHistoryTalkVoice("story_v_out_319671", "319671045", "story_v_out_319671.awb")
				end

				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_12 = math.max(var_197_5, arg_194_1.talkMaxDuration)

			if var_197_4 <= arg_194_1.time_ and arg_194_1.time_ < var_197_4 + var_197_12 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_4) / var_197_12

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_4 + var_197_12 and arg_194_1.time_ < var_197_4 + var_197_12 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {}

		arg_194_1:InitPlayNodeList()
	end,
	Play319671046 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 319671046
		arg_198_1.duration_ = 6.33

		local var_198_0 = {
			zh = 5.033,
			ja = 6.333
		}
		local var_198_1 = manager.audio:GetLocalizationFlag()

		if var_198_0[var_198_1] ~= nil then
			arg_198_1.duration_ = var_198_0[var_198_1]
		end

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play319671047(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_2")
			end

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_201_0 = arg_198_1.actors_["1084ui_story"]

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 and not isNil(var_201_0) and arg_198_1.var_.characterEffect1084ui_story == nil then
				arg_198_1.var_.characterEffect1084ui_story = var_201_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_201_1 = 0.200000002980232

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_1 and not isNil(var_201_0) then
				if arg_198_1.var_.characterEffect1084ui_story and not isNil(var_201_0) then
					arg_198_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_198_1.time_ >= 0 + var_201_1 and arg_198_1.time_ < 0 + var_201_1 + arg_201_0 and not isNil(var_201_0) and arg_198_1.var_.characterEffect1084ui_story then
				arg_198_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_201_3 = arg_198_1.actors_["10014ui_story"]

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 and not isNil(var_201_3) and arg_198_1.var_.characterEffect10014ui_story == nil then
				arg_198_1.var_.characterEffect10014ui_story = var_201_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_201_4 = 0.200000002980232

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_4 and not isNil(var_201_3) then
				if arg_198_1.var_.characterEffect10014ui_story and not isNil(var_201_3) then
					arg_198_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_198_1.var_.characterEffect10014ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_198_1.time_ - 0) / var_201_4)
				end
			end

			if arg_198_1.time_ >= 0 + var_201_4 and arg_198_1.time_ < 0 + var_201_4 + arg_201_0 and not isNil(var_201_3) and arg_198_1.var_.characterEffect10014ui_story then
				arg_198_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_198_1.var_.characterEffect10014ui_story.fillRatio = 0.5
			end

			local var_201_5 = 0
			local var_201_6 = 0.525

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= var_201_5 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, true)

				arg_198_1.leftNameTxt_.text = arg_198_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_198_1.leftNameTxt_.transform)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1.leftNameTxt_.text)
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_7 = arg_198_1:GetWordFromCfg(319671046)
				local var_201_8 = arg_198_1:FormatText(var_201_7.content)

				arg_198_1.text_.text = var_201_8

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_10 = 21 <= 0 and var_201_6 or var_201_6 * (utf8.len(var_201_8) / 21)

				if (21 <= 0 and var_201_6 or var_201_6 * (utf8.len(var_201_8) / 21)) > 0 and var_201_6 < var_201_10 then
					arg_198_1.talkMaxDuration = var_201_10

					if var_201_10 + var_201_5 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_10 + var_201_5
					end
				end

				arg_198_1.text_.text = var_201_8
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671046", "story_v_out_319671.awb") ~= 0 then
					local var_201_11 = manager.audio:GetVoiceLength("story_v_out_319671", "319671046", "story_v_out_319671.awb") / 1000

					if var_201_11 + var_201_5 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_11 + var_201_5
					end

					if var_201_7.prefab_name ~= "" and arg_198_1.actors_[var_201_7.prefab_name] ~= nil then
						local var_201_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_198_1.actors_[var_201_7.prefab_name].transform, "story_v_out_319671", "319671046", "story_v_out_319671.awb")

						arg_198_1:RecordAudio("319671046", var_201_12)
						arg_198_1:RecordAudio("319671046", var_201_12)
					else
						arg_198_1:AudioAction("play", "voice", "story_v_out_319671", "319671046", "story_v_out_319671.awb")
					end

					arg_198_1:RecordHistoryTalkVoice("story_v_out_319671", "319671046", "story_v_out_319671.awb")
				end

				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_13 = math.max(var_201_6, arg_198_1.talkMaxDuration)

			if var_201_5 <= arg_198_1.time_ and arg_198_1.time_ < var_201_5 + var_201_13 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_5) / var_201_13

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_5 + var_201_13 and arg_198_1.time_ < var_201_5 + var_201_13 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {}

		arg_198_1:InitPlayNodeList()
	end,
	Play319671047 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 319671047
		arg_202_1.duration_ = 1.8

		local var_202_0 = {
			zh = 1.8,
			ja = 0.999999999999
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
				arg_202_0:Play319671048(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 then
				arg_202_1.var_.moveOldPos10014ui_story = arg_202_1.actors_["10014ui_story"].transform.localPosition
			end

			local var_205_0 = 0.001

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_0 then
				arg_202_1.actors_["10014ui_story"].transform.localPosition = Vector3.Lerp(arg_202_1.var_.moveOldPos10014ui_story, Vector3.New(-0.7, -1.06, -6.2), (arg_202_1.time_ - 0) / var_205_0)
				arg_202_1.actors_["10014ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_202_1.actors_["10014ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_202_1.actors_["10014ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_202_1.actors_["10014ui_story"].transform.position).z)
				arg_202_1.actors_["10014ui_story"].transform.localEulerAngles.z = 0
				arg_202_1.actors_["10014ui_story"].transform.localEulerAngles.x = 0
				arg_202_1.actors_["10014ui_story"].transform.localEulerAngles = arg_202_1.actors_["10014ui_story"].transform.localEulerAngles
			end

			if arg_202_1.time_ >= 0 + var_205_0 and arg_202_1.time_ < 0 + var_205_0 + arg_205_0 then
				arg_202_1.actors_["10014ui_story"].transform.localPosition = Vector3.New(-0.7, -1.06, -6.2)
				arg_202_1.actors_["10014ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_202_1.actors_["10014ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_202_1.actors_["10014ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_202_1.actors_["10014ui_story"].transform.position).z)
				arg_202_1.actors_["10014ui_story"].transform.localEulerAngles.z = 0
				arg_202_1.actors_["10014ui_story"].transform.localEulerAngles.x = 0
				arg_202_1.actors_["10014ui_story"].transform.localEulerAngles = arg_202_1.actors_["10014ui_story"].transform.localEulerAngles
			end

			local var_205_1 = arg_202_1.actors_["1084ui_story"]

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 and not isNil(var_205_1) and arg_202_1.var_.characterEffect1084ui_story == nil then
				arg_202_1.var_.characterEffect1084ui_story = var_205_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_205_2 = 0.200000002980232

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_2 and not isNil(var_205_1) then
				if arg_202_1.var_.characterEffect1084ui_story and not isNil(var_205_1) then
					arg_202_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_202_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_202_1.time_ - 0) / var_205_2)
				end
			end

			if arg_202_1.time_ >= 0 + var_205_2 and arg_202_1.time_ < 0 + var_205_2 + arg_205_0 and not isNil(var_205_1) and arg_202_1.var_.characterEffect1084ui_story then
				arg_202_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_202_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_205_3 = arg_202_1.actors_["10014ui_story"]

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 and not isNil(var_205_3) and arg_202_1.var_.characterEffect10014ui_story == nil then
				arg_202_1.var_.characterEffect10014ui_story = var_205_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_205_4 = 0.200000002980232

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_4 and not isNil(var_205_3) then
				if arg_202_1.var_.characterEffect10014ui_story and not isNil(var_205_3) then
					arg_202_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_202_1.time_ >= 0 + var_205_4 and arg_202_1.time_ < 0 + var_205_4 + arg_205_0 and not isNil(var_205_3) and arg_202_1.var_.characterEffect10014ui_story then
				arg_202_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_205_6 = 0
			local var_205_7 = 0.075

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= var_205_6 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, true)

				arg_202_1.leftNameTxt_.text = arg_202_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, false)
				arg_202_1.callingController_:SetSelectedState("normal")

				local var_205_8 = arg_202_1:GetWordFromCfg(319671047)
				local var_205_9 = arg_202_1:FormatText(var_205_8.content)

				arg_202_1.text_.text = var_205_9

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_11 = 3 <= 0 and var_205_7 or var_205_7 * (utf8.len(var_205_9) / 3)

				if (3 <= 0 and var_205_7 or var_205_7 * (utf8.len(var_205_9) / 3)) > 0 and var_205_7 < var_205_11 then
					arg_202_1.talkMaxDuration = var_205_11

					if var_205_11 + var_205_6 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_11 + var_205_6
					end
				end

				arg_202_1.text_.text = var_205_9
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671047", "story_v_out_319671.awb") ~= 0 then
					local var_205_12 = manager.audio:GetVoiceLength("story_v_out_319671", "319671047", "story_v_out_319671.awb") / 1000

					if var_205_12 + var_205_6 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_12 + var_205_6
					end

					if var_205_8.prefab_name ~= "" and arg_202_1.actors_[var_205_8.prefab_name] ~= nil then
						local var_205_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_202_1.actors_[var_205_8.prefab_name].transform, "story_v_out_319671", "319671047", "story_v_out_319671.awb")

						arg_202_1:RecordAudio("319671047", var_205_13)
						arg_202_1:RecordAudio("319671047", var_205_13)
					else
						arg_202_1:AudioAction("play", "voice", "story_v_out_319671", "319671047", "story_v_out_319671.awb")
					end

					arg_202_1:RecordHistoryTalkVoice("story_v_out_319671", "319671047", "story_v_out_319671.awb")
				end

				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_14 = math.max(var_205_7, arg_202_1.talkMaxDuration)

			if var_205_6 <= arg_202_1.time_ and arg_202_1.time_ < var_205_6 + var_205_14 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_6) / var_205_14

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_6 + var_205_14 and arg_202_1.time_ < var_205_6 + var_205_14 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_202_1:InitPlayNodeList()
	end,
	Play319671048 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 319671048
		arg_206_1.duration_ = 7.83

		local var_206_0 = {
			zh = 6.533,
			ja = 7.833
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
				arg_206_0:Play319671049(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1.var_.moveOldPos1084ui_story = arg_206_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_209_0 = 0.001

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_0 then
				arg_206_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_206_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_206_1.time_ - 0) / var_209_0)
				arg_206_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_206_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_206_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_206_1.actors_["1084ui_story"].transform.position).z)
				arg_206_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_206_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_206_1.actors_["1084ui_story"].transform.localEulerAngles = arg_206_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_206_1.time_ >= 0 + var_209_0 and arg_206_1.time_ < 0 + var_209_0 + arg_209_0 then
				arg_206_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0.7, -0.97, -6)
				arg_206_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_206_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_206_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_206_1.actors_["1084ui_story"].transform.position).z)
				arg_206_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_206_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_206_1.actors_["1084ui_story"].transform.localEulerAngles = arg_206_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_209_1 = arg_206_1.actors_["1084ui_story"]

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 and not isNil(var_209_1) and arg_206_1.var_.characterEffect1084ui_story == nil then
				arg_206_1.var_.characterEffect1084ui_story = var_209_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_209_2 = 0.200000002980232

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_2 and not isNil(var_209_1) then
				if arg_206_1.var_.characterEffect1084ui_story and not isNil(var_209_1) then
					arg_206_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_206_1.time_ >= 0 + var_209_2 and arg_206_1.time_ < 0 + var_209_2 + arg_209_0 and not isNil(var_209_1) and arg_206_1.var_.characterEffect1084ui_story then
				arg_206_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_209_4 = arg_206_1.actors_["10014ui_story"]

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 and not isNil(var_209_4) and arg_206_1.var_.characterEffect10014ui_story == nil then
				arg_206_1.var_.characterEffect10014ui_story = var_209_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_209_5 = 0.200000002980232

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_5 and not isNil(var_209_4) then
				if arg_206_1.var_.characterEffect10014ui_story and not isNil(var_209_4) then
					arg_206_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_206_1.var_.characterEffect10014ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_206_1.time_ - 0) / var_209_5)
				end
			end

			if arg_206_1.time_ >= 0 + var_209_5 and arg_206_1.time_ < 0 + var_209_5 + arg_209_0 and not isNil(var_209_4) and arg_206_1.var_.characterEffect10014ui_story then
				arg_206_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_206_1.var_.characterEffect10014ui_story.fillRatio = 0.5
			end

			local var_209_6 = 0
			local var_209_7 = 1.1

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= var_209_6 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, true)

				arg_206_1.leftNameTxt_.text = arg_206_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_206_1.leftNameTxt_.transform)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1.leftNameTxt_.text)
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_8 = arg_206_1:GetWordFromCfg(319671048)
				local var_209_9 = arg_206_1:FormatText(var_209_8.content)

				arg_206_1.text_.text = var_209_9

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_11 = 44 <= 0 and var_209_7 or var_209_7 * (utf8.len(var_209_9) / 44)

				if (44 <= 0 and var_209_7 or var_209_7 * (utf8.len(var_209_9) / 44)) > 0 and var_209_7 < var_209_11 then
					arg_206_1.talkMaxDuration = var_209_11

					if var_209_11 + var_209_6 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_11 + var_209_6
					end
				end

				arg_206_1.text_.text = var_209_9
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671048", "story_v_out_319671.awb") ~= 0 then
					local var_209_12 = manager.audio:GetVoiceLength("story_v_out_319671", "319671048", "story_v_out_319671.awb") / 1000

					if var_209_12 + var_209_6 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_12 + var_209_6
					end

					if var_209_8.prefab_name ~= "" and arg_206_1.actors_[var_209_8.prefab_name] ~= nil then
						local var_209_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_206_1.actors_[var_209_8.prefab_name].transform, "story_v_out_319671", "319671048", "story_v_out_319671.awb")

						arg_206_1:RecordAudio("319671048", var_209_13)
						arg_206_1:RecordAudio("319671048", var_209_13)
					else
						arg_206_1:AudioAction("play", "voice", "story_v_out_319671", "319671048", "story_v_out_319671.awb")
					end

					arg_206_1:RecordHistoryTalkVoice("story_v_out_319671", "319671048", "story_v_out_319671.awb")
				end

				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_14 = math.max(var_209_7, arg_206_1.talkMaxDuration)

			if var_209_6 <= arg_206_1.time_ and arg_206_1.time_ < var_209_6 + var_209_14 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_6) / var_209_14

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_6 + var_209_14 and arg_206_1.time_ < var_209_6 + var_209_14 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {
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

		arg_206_1:InitPlayNodeList()
	end,
	Play319671049 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 319671049
		arg_210_1.duration_ = 5.27

		local var_210_0 = {
			zh = 3.8,
			ja = 5.266
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
				arg_210_0:Play319671050(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 and not isNil(arg_210_1.actors_["1084ui_story"]) and arg_210_1.var_.characterEffect1084ui_story == nil then
				arg_210_1.var_.characterEffect1084ui_story = arg_210_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_213_0 = 0.200000002980232

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_0 and not isNil(arg_210_1.actors_["1084ui_story"]) then
				if arg_210_1.var_.characterEffect1084ui_story and not isNil(arg_210_1.actors_["1084ui_story"]) then
					arg_210_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_210_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_210_1.time_ - 0) / var_213_0)
				end
			end

			if arg_210_1.time_ >= 0 + var_213_0 and arg_210_1.time_ < 0 + var_213_0 + arg_213_0 and not isNil(arg_210_1.actors_["1084ui_story"]) and arg_210_1.var_.characterEffect1084ui_story then
				arg_210_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_210_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_213_1 = arg_210_1.actors_["10014ui_story"]

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 and not isNil(var_213_1) and arg_210_1.var_.characterEffect10014ui_story == nil then
				arg_210_1.var_.characterEffect10014ui_story = var_213_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_213_2 = 0.200000002980232

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_2 and not isNil(var_213_1) then
				if arg_210_1.var_.characterEffect10014ui_story and not isNil(var_213_1) then
					arg_210_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_210_1.time_ >= 0 + var_213_2 and arg_210_1.time_ < 0 + var_213_2 + arg_213_0 and not isNil(var_213_1) and arg_210_1.var_.characterEffect10014ui_story then
				arg_210_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_213_4 = 0
			local var_213_5 = 0.475

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= var_213_4 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, true)

				arg_210_1.leftNameTxt_.text = arg_210_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_210_1.leftNameTxt_.transform)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1.leftNameTxt_.text)
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_6 = arg_210_1:GetWordFromCfg(319671049)
				local var_213_7 = arg_210_1:FormatText(var_213_6.content)

				arg_210_1.text_.text = var_213_7

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_9 = 19 <= 0 and var_213_5 or var_213_5 * (utf8.len(var_213_7) / 19)

				if (19 <= 0 and var_213_5 or var_213_5 * (utf8.len(var_213_7) / 19)) > 0 and var_213_5 < var_213_9 then
					arg_210_1.talkMaxDuration = var_213_9

					if var_213_9 + var_213_4 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_9 + var_213_4
					end
				end

				arg_210_1.text_.text = var_213_7
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671049", "story_v_out_319671.awb") ~= 0 then
					local var_213_10 = manager.audio:GetVoiceLength("story_v_out_319671", "319671049", "story_v_out_319671.awb") / 1000

					if var_213_10 + var_213_4 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_10 + var_213_4
					end

					if var_213_6.prefab_name ~= "" and arg_210_1.actors_[var_213_6.prefab_name] ~= nil then
						local var_213_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_210_1.actors_[var_213_6.prefab_name].transform, "story_v_out_319671", "319671049", "story_v_out_319671.awb")

						arg_210_1:RecordAudio("319671049", var_213_11)
						arg_210_1:RecordAudio("319671049", var_213_11)
					else
						arg_210_1:AudioAction("play", "voice", "story_v_out_319671", "319671049", "story_v_out_319671.awb")
					end

					arg_210_1:RecordHistoryTalkVoice("story_v_out_319671", "319671049", "story_v_out_319671.awb")
				end

				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_12 = math.max(var_213_5, arg_210_1.talkMaxDuration)

			if var_213_4 <= arg_210_1.time_ and arg_210_1.time_ < var_213_4 + var_213_12 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_4) / var_213_12

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_4 + var_213_12 and arg_210_1.time_ < var_213_4 + var_213_12 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {}

		arg_210_1:InitPlayNodeList()
	end,
	Play319671050 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 319671050
		arg_214_1.duration_ = 8.53

		local var_214_0 = {
			zh = 3.966,
			ja = 8.533
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
				arg_214_0:Play319671051(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 then
				arg_214_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action4_2")
			end

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 then
				arg_214_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_217_0 = 0
			local var_217_1 = 0.5

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= var_217_0 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				arg_214_1.leftNameTxt_.text = arg_214_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, false)
				arg_214_1.callingController_:SetSelectedState("normal")

				local var_217_2 = arg_214_1:GetWordFromCfg(319671050)
				local var_217_3 = arg_214_1:FormatText(var_217_2.content)

				arg_214_1.text_.text = var_217_3

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_5 = 20 <= 0 and var_217_1 or var_217_1 * (utf8.len(var_217_3) / 20)

				if (20 <= 0 and var_217_1 or var_217_1 * (utf8.len(var_217_3) / 20)) > 0 and var_217_1 < var_217_5 then
					arg_214_1.talkMaxDuration = var_217_5

					if var_217_5 + var_217_0 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_5 + var_217_0
					end
				end

				arg_214_1.text_.text = var_217_3
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671050", "story_v_out_319671.awb") ~= 0 then
					local var_217_6 = manager.audio:GetVoiceLength("story_v_out_319671", "319671050", "story_v_out_319671.awb") / 1000

					if var_217_6 + var_217_0 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_6 + var_217_0
					end

					if var_217_2.prefab_name ~= "" and arg_214_1.actors_[var_217_2.prefab_name] ~= nil then
						local var_217_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_214_1.actors_[var_217_2.prefab_name].transform, "story_v_out_319671", "319671050", "story_v_out_319671.awb")

						arg_214_1:RecordAudio("319671050", var_217_7)
						arg_214_1:RecordAudio("319671050", var_217_7)
					else
						arg_214_1:AudioAction("play", "voice", "story_v_out_319671", "319671050", "story_v_out_319671.awb")
					end

					arg_214_1:RecordHistoryTalkVoice("story_v_out_319671", "319671050", "story_v_out_319671.awb")
				end

				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_8 = math.max(var_217_1, arg_214_1.talkMaxDuration)

			if var_217_0 <= arg_214_1.time_ and arg_214_1.time_ < var_217_0 + var_217_8 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_0) / var_217_8

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_0 + var_217_8 and arg_214_1.time_ < var_217_0 + var_217_8 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {}

		arg_214_1:InitPlayNodeList()
	end,
	Play319671051 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 319671051
		arg_218_1.duration_ = 4

		local var_218_0 = {
			zh = 2.3,
			ja = 4
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
				arg_218_0:Play319671052(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 and not isNil(arg_218_1.actors_["10014ui_story"]) and arg_218_1.var_.characterEffect10014ui_story == nil then
				arg_218_1.var_.characterEffect10014ui_story = arg_218_1.actors_["10014ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_221_0 = 0.200000002980232

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_0 and not isNil(arg_218_1.actors_["10014ui_story"]) then
				if arg_218_1.var_.characterEffect10014ui_story and not isNil(arg_218_1.actors_["10014ui_story"]) then
					arg_218_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_218_1.var_.characterEffect10014ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_218_1.time_ - 0) / var_221_0)
				end
			end

			if arg_218_1.time_ >= 0 + var_221_0 and arg_218_1.time_ < 0 + var_221_0 + arg_221_0 and not isNil(arg_218_1.actors_["10014ui_story"]) and arg_218_1.var_.characterEffect10014ui_story then
				arg_218_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_218_1.var_.characterEffect10014ui_story.fillRatio = 0.5
			end

			local var_221_1 = arg_218_1.actors_["1084ui_story"]

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 and not isNil(var_221_1) and arg_218_1.var_.characterEffect1084ui_story == nil then
				arg_218_1.var_.characterEffect1084ui_story = var_221_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_221_2 = 0.200000002980232

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_2 and not isNil(var_221_1) then
				if arg_218_1.var_.characterEffect1084ui_story and not isNil(var_221_1) then
					arg_218_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_218_1.time_ >= 0 + var_221_2 and arg_218_1.time_ < 0 + var_221_2 + arg_221_0 and not isNil(var_221_1) and arg_218_1.var_.characterEffect1084ui_story then
				arg_218_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_221_4 = 0
			local var_221_5 = 0.175

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= var_221_4 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				arg_218_1.leftNameTxt_.text = arg_218_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_6 = arg_218_1:GetWordFromCfg(319671051)
				local var_221_7 = arg_218_1:FormatText(var_221_6.content)

				arg_218_1.text_.text = var_221_7

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_9 = 7 <= 0 and var_221_5 or var_221_5 * (utf8.len(var_221_7) / 7)

				if (7 <= 0 and var_221_5 or var_221_5 * (utf8.len(var_221_7) / 7)) > 0 and var_221_5 < var_221_9 then
					arg_218_1.talkMaxDuration = var_221_9

					if var_221_9 + var_221_4 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_9 + var_221_4
					end
				end

				arg_218_1.text_.text = var_221_7
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671051", "story_v_out_319671.awb") ~= 0 then
					local var_221_10 = manager.audio:GetVoiceLength("story_v_out_319671", "319671051", "story_v_out_319671.awb") / 1000

					if var_221_10 + var_221_4 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_10 + var_221_4
					end

					if var_221_6.prefab_name ~= "" and arg_218_1.actors_[var_221_6.prefab_name] ~= nil then
						local var_221_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_218_1.actors_[var_221_6.prefab_name].transform, "story_v_out_319671", "319671051", "story_v_out_319671.awb")

						arg_218_1:RecordAudio("319671051", var_221_11)
						arg_218_1:RecordAudio("319671051", var_221_11)
					else
						arg_218_1:AudioAction("play", "voice", "story_v_out_319671", "319671051", "story_v_out_319671.awb")
					end

					arg_218_1:RecordHistoryTalkVoice("story_v_out_319671", "319671051", "story_v_out_319671.awb")
				end

				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_12 = math.max(var_221_5, arg_218_1.talkMaxDuration)

			if var_221_4 <= arg_218_1.time_ and arg_218_1.time_ < var_221_4 + var_221_12 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_4) / var_221_12

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_4 + var_221_12 and arg_218_1.time_ < var_221_4 + var_221_12 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {}

		arg_218_1:InitPlayNodeList()
	end,
	Play319671052 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 319671052
		arg_222_1.duration_ = 3.27

		local var_222_0 = {
			zh = 1.999999999999,
			ja = 3.266
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
				arg_222_0:Play319671053(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1.var_.moveOldPos10014ui_story = arg_222_1.actors_["10014ui_story"].transform.localPosition
			end

			local var_225_0 = 0.001

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_0 then
				arg_222_1.actors_["10014ui_story"].transform.localPosition = Vector3.Lerp(arg_222_1.var_.moveOldPos10014ui_story, Vector3.New(-0.7, -1.06, -6.2), (arg_222_1.time_ - 0) / var_225_0)
				arg_222_1.actors_["10014ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_222_1.actors_["10014ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_222_1.actors_["10014ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_222_1.actors_["10014ui_story"].transform.position).z)
				arg_222_1.actors_["10014ui_story"].transform.localEulerAngles.z = 0
				arg_222_1.actors_["10014ui_story"].transform.localEulerAngles.x = 0
				arg_222_1.actors_["10014ui_story"].transform.localEulerAngles = arg_222_1.actors_["10014ui_story"].transform.localEulerAngles
			end

			if arg_222_1.time_ >= 0 + var_225_0 and arg_222_1.time_ < 0 + var_225_0 + arg_225_0 then
				arg_222_1.actors_["10014ui_story"].transform.localPosition = Vector3.New(-0.7, -1.06, -6.2)
				arg_222_1.actors_["10014ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_222_1.actors_["10014ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_222_1.actors_["10014ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_222_1.actors_["10014ui_story"].transform.position).z)
				arg_222_1.actors_["10014ui_story"].transform.localEulerAngles.z = 0
				arg_222_1.actors_["10014ui_story"].transform.localEulerAngles.x = 0
				arg_222_1.actors_["10014ui_story"].transform.localEulerAngles = arg_222_1.actors_["10014ui_story"].transform.localEulerAngles
			end

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action2_1")
			end

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_225_1 = arg_222_1.actors_["1084ui_story"]

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 and not isNil(var_225_1) and arg_222_1.var_.characterEffect1084ui_story == nil then
				arg_222_1.var_.characterEffect1084ui_story = var_225_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_225_2 = 0.200000002980232

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_2 and not isNil(var_225_1) then
				if arg_222_1.var_.characterEffect1084ui_story and not isNil(var_225_1) then
					arg_222_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_222_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_222_1.time_ - 0) / var_225_2)
				end
			end

			if arg_222_1.time_ >= 0 + var_225_2 and arg_222_1.time_ < 0 + var_225_2 + arg_225_0 and not isNil(var_225_1) and arg_222_1.var_.characterEffect1084ui_story then
				arg_222_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_222_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_225_3 = arg_222_1.actors_["10014ui_story"]

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 and not isNil(var_225_3) and arg_222_1.var_.characterEffect10014ui_story == nil then
				arg_222_1.var_.characterEffect10014ui_story = var_225_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_225_4 = 0.200000002980232

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_4 and not isNil(var_225_3) then
				if arg_222_1.var_.characterEffect10014ui_story and not isNil(var_225_3) then
					arg_222_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_222_1.time_ >= 0 + var_225_4 and arg_222_1.time_ < 0 + var_225_4 + arg_225_0 and not isNil(var_225_3) and arg_222_1.var_.characterEffect10014ui_story then
				arg_222_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_225_6 = 0
			local var_225_7 = 0.525

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= var_225_6 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				arg_222_1.leftNameTxt_.text = arg_222_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_8 = arg_222_1:GetWordFromCfg(319671052)
				local var_225_9 = arg_222_1:FormatText(var_225_8.content)

				arg_222_1.text_.text = var_225_9

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_11 = 21 <= 0 and var_225_7 or var_225_7 * (utf8.len(var_225_9) / 21)

				if (21 <= 0 and var_225_7 or var_225_7 * (utf8.len(var_225_9) / 21)) > 0 and var_225_7 < var_225_11 then
					arg_222_1.talkMaxDuration = var_225_11

					if var_225_11 + var_225_6 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_11 + var_225_6
					end
				end

				arg_222_1.text_.text = var_225_9
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671052", "story_v_out_319671.awb") ~= 0 then
					local var_225_12 = manager.audio:GetVoiceLength("story_v_out_319671", "319671052", "story_v_out_319671.awb") / 1000

					if var_225_12 + var_225_6 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_12 + var_225_6
					end

					if var_225_8.prefab_name ~= "" and arg_222_1.actors_[var_225_8.prefab_name] ~= nil then
						local var_225_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_222_1.actors_[var_225_8.prefab_name].transform, "story_v_out_319671", "319671052", "story_v_out_319671.awb")

						arg_222_1:RecordAudio("319671052", var_225_13)
						arg_222_1:RecordAudio("319671052", var_225_13)
					else
						arg_222_1:AudioAction("play", "voice", "story_v_out_319671", "319671052", "story_v_out_319671.awb")
					end

					arg_222_1:RecordHistoryTalkVoice("story_v_out_319671", "319671052", "story_v_out_319671.awb")
				end

				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_14 = math.max(var_225_7, arg_222_1.talkMaxDuration)

			if var_225_6 <= arg_222_1.time_ and arg_222_1.time_ < var_225_6 + var_225_14 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_6) / var_225_14

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_6 + var_225_14 and arg_222_1.time_ < var_225_6 + var_225_14 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_222_1:InitPlayNodeList()
	end,
	Play319671053 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 319671053
		arg_226_1.duration_ = 5.53

		local var_226_0 = {
			zh = 5.533,
			ja = 2.633
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
				arg_226_0:Play319671054(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 then
				arg_226_1.var_.moveOldPos1084ui_story = arg_226_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_229_0 = 0.001

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_0 then
				arg_226_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_226_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_226_1.time_ - 0) / var_229_0)
				arg_226_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_226_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_226_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_226_1.actors_["1084ui_story"].transform.position).z)
				arg_226_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_226_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_226_1.actors_["1084ui_story"].transform.localEulerAngles = arg_226_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_226_1.time_ >= 0 + var_229_0 and arg_226_1.time_ < 0 + var_229_0 + arg_229_0 then
				arg_226_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0.7, -0.97, -6)
				arg_226_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_226_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_226_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_226_1.actors_["1084ui_story"].transform.position).z)
				arg_226_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_226_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_226_1.actors_["1084ui_story"].transform.localEulerAngles = arg_226_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_229_1 = arg_226_1.actors_["1084ui_story"]

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 and not isNil(var_229_1) and arg_226_1.var_.characterEffect1084ui_story == nil then
				arg_226_1.var_.characterEffect1084ui_story = var_229_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_229_2 = 0.200000002980232

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_2 and not isNil(var_229_1) then
				if arg_226_1.var_.characterEffect1084ui_story and not isNil(var_229_1) then
					arg_226_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_226_1.time_ >= 0 + var_229_2 and arg_226_1.time_ < 0 + var_229_2 + arg_229_0 and not isNil(var_229_1) and arg_226_1.var_.characterEffect1084ui_story then
				arg_226_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 then
				arg_226_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_2")
			end

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 then
				arg_226_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_229_4 = arg_226_1.actors_["10014ui_story"]

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 and not isNil(var_229_4) and arg_226_1.var_.characterEffect10014ui_story == nil then
				arg_226_1.var_.characterEffect10014ui_story = var_229_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_229_5 = 0.200000002980232

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_5 and not isNil(var_229_4) then
				if arg_226_1.var_.characterEffect10014ui_story and not isNil(var_229_4) then
					arg_226_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_226_1.var_.characterEffect10014ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_226_1.time_ - 0) / var_229_5)
				end
			end

			if arg_226_1.time_ >= 0 + var_229_5 and arg_226_1.time_ < 0 + var_229_5 + arg_229_0 and not isNil(var_229_4) and arg_226_1.var_.characterEffect10014ui_story then
				arg_226_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_226_1.var_.characterEffect10014ui_story.fillRatio = 0.5
			end

			local var_229_6 = 0
			local var_229_7 = 0.775

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= var_229_6 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				arg_226_1.leftNameTxt_.text = arg_226_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, false)
				arg_226_1.callingController_:SetSelectedState("normal")

				local var_229_8 = arg_226_1:GetWordFromCfg(319671053)
				local var_229_9 = arg_226_1:FormatText(var_229_8.content)

				arg_226_1.text_.text = var_229_9

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_11 = 31 <= 0 and var_229_7 or var_229_7 * (utf8.len(var_229_9) / 31)

				if (31 <= 0 and var_229_7 or var_229_7 * (utf8.len(var_229_9) / 31)) > 0 and var_229_7 < var_229_11 then
					arg_226_1.talkMaxDuration = var_229_11

					if var_229_11 + var_229_6 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_11 + var_229_6
					end
				end

				arg_226_1.text_.text = var_229_9
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671053", "story_v_out_319671.awb") ~= 0 then
					local var_229_12 = manager.audio:GetVoiceLength("story_v_out_319671", "319671053", "story_v_out_319671.awb") / 1000

					if var_229_12 + var_229_6 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_12 + var_229_6
					end

					if var_229_8.prefab_name ~= "" and arg_226_1.actors_[var_229_8.prefab_name] ~= nil then
						local var_229_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_226_1.actors_[var_229_8.prefab_name].transform, "story_v_out_319671", "319671053", "story_v_out_319671.awb")

						arg_226_1:RecordAudio("319671053", var_229_13)
						arg_226_1:RecordAudio("319671053", var_229_13)
					else
						arg_226_1:AudioAction("play", "voice", "story_v_out_319671", "319671053", "story_v_out_319671.awb")
					end

					arg_226_1:RecordHistoryTalkVoice("story_v_out_319671", "319671053", "story_v_out_319671.awb")
				end

				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_14 = math.max(var_229_7, arg_226_1.talkMaxDuration)

			if var_229_6 <= arg_226_1.time_ and arg_226_1.time_ < var_229_6 + var_229_14 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_6) / var_229_14

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_6 + var_229_14 and arg_226_1.time_ < var_229_6 + var_229_14 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {
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

		arg_226_1:InitPlayNodeList()
	end,
	Play319671054 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 319671054
		arg_230_1.duration_ = 5.5

		local var_230_0 = {
			zh = 4.733,
			ja = 5.5
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
				arg_230_0:Play319671055(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 and not isNil(arg_230_1.actors_["1084ui_story"]) and arg_230_1.var_.characterEffect1084ui_story == nil then
				arg_230_1.var_.characterEffect1084ui_story = arg_230_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_233_0 = 0.200000002980232

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_0 and not isNil(arg_230_1.actors_["1084ui_story"]) then
				if arg_230_1.var_.characterEffect1084ui_story and not isNil(arg_230_1.actors_["1084ui_story"]) then
					arg_230_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_230_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_230_1.time_ - 0) / var_233_0)
				end
			end

			if arg_230_1.time_ >= 0 + var_233_0 and arg_230_1.time_ < 0 + var_233_0 + arg_233_0 and not isNil(arg_230_1.actors_["1084ui_story"]) and arg_230_1.var_.characterEffect1084ui_story then
				arg_230_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_230_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_233_1 = arg_230_1.actors_["10014ui_story"]

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 and not isNil(var_233_1) and arg_230_1.var_.characterEffect10014ui_story == nil then
				arg_230_1.var_.characterEffect10014ui_story = var_233_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_233_2 = 0.200000002980232

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_2 and not isNil(var_233_1) then
				if arg_230_1.var_.characterEffect10014ui_story and not isNil(var_233_1) then
					arg_230_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_230_1.time_ >= 0 + var_233_2 and arg_230_1.time_ < 0 + var_233_2 + arg_233_0 and not isNil(var_233_1) and arg_230_1.var_.characterEffect10014ui_story then
				arg_230_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_233_4 = 0
			local var_233_5 = 0.5

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= var_233_4 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				arg_230_1.leftNameTxt_.text = arg_230_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_6 = arg_230_1:GetWordFromCfg(319671054)
				local var_233_7 = arg_230_1:FormatText(var_233_6.content)

				arg_230_1.text_.text = var_233_7

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_9 = 20 <= 0 and var_233_5 or var_233_5 * (utf8.len(var_233_7) / 20)

				if (20 <= 0 and var_233_5 or var_233_5 * (utf8.len(var_233_7) / 20)) > 0 and var_233_5 < var_233_9 then
					arg_230_1.talkMaxDuration = var_233_9

					if var_233_9 + var_233_4 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_9 + var_233_4
					end
				end

				arg_230_1.text_.text = var_233_7
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671054", "story_v_out_319671.awb") ~= 0 then
					local var_233_10 = manager.audio:GetVoiceLength("story_v_out_319671", "319671054", "story_v_out_319671.awb") / 1000

					if var_233_10 + var_233_4 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_10 + var_233_4
					end

					if var_233_6.prefab_name ~= "" and arg_230_1.actors_[var_233_6.prefab_name] ~= nil then
						local var_233_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_230_1.actors_[var_233_6.prefab_name].transform, "story_v_out_319671", "319671054", "story_v_out_319671.awb")

						arg_230_1:RecordAudio("319671054", var_233_11)
						arg_230_1:RecordAudio("319671054", var_233_11)
					else
						arg_230_1:AudioAction("play", "voice", "story_v_out_319671", "319671054", "story_v_out_319671.awb")
					end

					arg_230_1:RecordHistoryTalkVoice("story_v_out_319671", "319671054", "story_v_out_319671.awb")
				end

				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_12 = math.max(var_233_5, arg_230_1.talkMaxDuration)

			if var_233_4 <= arg_230_1.time_ and arg_230_1.time_ < var_233_4 + var_233_12 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_4) / var_233_12

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_4 + var_233_12 and arg_230_1.time_ < var_233_4 + var_233_12 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {}

		arg_230_1:InitPlayNodeList()
	end,
	Play319671055 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 319671055
		arg_234_1.duration_ = 5

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play319671056(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 and not isNil(arg_234_1.actors_["10014ui_story"]) and arg_234_1.var_.characterEffect10014ui_story == nil then
				arg_234_1.var_.characterEffect10014ui_story = arg_234_1.actors_["10014ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_237_0 = 0.200000002980232

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_0 and not isNil(arg_234_1.actors_["10014ui_story"]) then
				if arg_234_1.var_.characterEffect10014ui_story and not isNil(arg_234_1.actors_["10014ui_story"]) then
					arg_234_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_234_1.var_.characterEffect10014ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_234_1.time_ - 0) / var_237_0)
				end
			end

			if arg_234_1.time_ >= 0 + var_237_0 and arg_234_1.time_ < 0 + var_237_0 + arg_237_0 and not isNil(arg_234_1.actors_["10014ui_story"]) and arg_234_1.var_.characterEffect10014ui_story then
				arg_234_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_234_1.var_.characterEffect10014ui_story.fillRatio = 0.5
			end

			local var_237_1 = 0
			local var_237_2 = 0.825

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= var_237_1 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, false)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_3 = arg_234_1:FormatText(arg_234_1:GetWordFromCfg(319671055).content)

				arg_234_1.text_.text = var_237_3

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_5 = 32 <= 0 and var_237_2 or var_237_2 * (utf8.len(var_237_3) / 32)

				if (32 <= 0 and var_237_2 or var_237_2 * (utf8.len(var_237_3) / 32)) > 0 and var_237_2 < var_237_5 then
					arg_234_1.talkMaxDuration = var_237_5

					if var_237_5 + var_237_1 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_5 + var_237_1
					end
				end

				arg_234_1.text_.text = var_237_3
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)
				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_6 = math.max(var_237_2, arg_234_1.talkMaxDuration)

			if var_237_1 <= arg_234_1.time_ and arg_234_1.time_ < var_237_1 + var_237_6 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_1) / var_237_6

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_1 + var_237_6 and arg_234_1.time_ < var_237_1 + var_237_6 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {}

		arg_234_1:InitPlayNodeList()
	end,
	Play319671056 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 319671056
		arg_238_1.duration_ = 14.3

		local var_238_0 = {
			zh = 12.2,
			ja = 14.3
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
				arg_238_0:Play319671057(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 and not isNil(arg_238_1.actors_["10014ui_story"]) and arg_238_1.var_.characterEffect10014ui_story == nil then
				arg_238_1.var_.characterEffect10014ui_story = arg_238_1.actors_["10014ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_241_0 = 0.200000002980232

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_0 and not isNil(arg_238_1.actors_["10014ui_story"]) then
				if arg_238_1.var_.characterEffect10014ui_story and not isNil(arg_238_1.actors_["10014ui_story"]) then
					arg_238_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_238_1.time_ >= 0 + var_241_0 and arg_238_1.time_ < 0 + var_241_0 + arg_241_0 and not isNil(arg_238_1.actors_["10014ui_story"]) and arg_238_1.var_.characterEffect10014ui_story then
				arg_238_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 then
				arg_238_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action2_2")
			end

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 then
				arg_238_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_241_2 = 0
			local var_241_3 = 1.45

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= var_241_2 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, true)

				arg_238_1.leftNameTxt_.text = arg_238_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_238_1.leftNameTxt_.transform)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1.leftNameTxt_.text)
				SetActive(arg_238_1.iconTrs_.gameObject, false)
				arg_238_1.callingController_:SetSelectedState("normal")

				local var_241_4 = arg_238_1:GetWordFromCfg(319671056)
				local var_241_5 = arg_238_1:FormatText(var_241_4.content)

				arg_238_1.text_.text = var_241_5

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_7 = 58 <= 0 and var_241_3 or var_241_3 * (utf8.len(var_241_5) / 58)

				if (58 <= 0 and var_241_3 or var_241_3 * (utf8.len(var_241_5) / 58)) > 0 and var_241_3 < var_241_7 then
					arg_238_1.talkMaxDuration = var_241_7

					if var_241_7 + var_241_2 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_7 + var_241_2
					end
				end

				arg_238_1.text_.text = var_241_5
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671056", "story_v_out_319671.awb") ~= 0 then
					local var_241_8 = manager.audio:GetVoiceLength("story_v_out_319671", "319671056", "story_v_out_319671.awb") / 1000

					if var_241_8 + var_241_2 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_8 + var_241_2
					end

					if var_241_4.prefab_name ~= "" and arg_238_1.actors_[var_241_4.prefab_name] ~= nil then
						local var_241_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_238_1.actors_[var_241_4.prefab_name].transform, "story_v_out_319671", "319671056", "story_v_out_319671.awb")

						arg_238_1:RecordAudio("319671056", var_241_9)
						arg_238_1:RecordAudio("319671056", var_241_9)
					else
						arg_238_1:AudioAction("play", "voice", "story_v_out_319671", "319671056", "story_v_out_319671.awb")
					end

					arg_238_1:RecordHistoryTalkVoice("story_v_out_319671", "319671056", "story_v_out_319671.awb")
				end

				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_10 = math.max(var_241_3, arg_238_1.talkMaxDuration)

			if var_241_2 <= arg_238_1.time_ and arg_238_1.time_ < var_241_2 + var_241_10 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_2) / var_241_10

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_2 + var_241_10 and arg_238_1.time_ < var_241_2 + var_241_10 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {}

		arg_238_1:InitPlayNodeList()
	end,
	Play319671057 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 319671057
		arg_242_1.duration_ = 3.5

		local var_242_0 = {
			zh = 3.5,
			ja = 1.999999999999
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
				arg_242_0:Play319671058(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 and not isNil(arg_242_1.actors_["10014ui_story"]) and arg_242_1.var_.characterEffect10014ui_story == nil then
				arg_242_1.var_.characterEffect10014ui_story = arg_242_1.actors_["10014ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_245_0 = 0.200000002980232

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_0 and not isNil(arg_242_1.actors_["10014ui_story"]) then
				if arg_242_1.var_.characterEffect10014ui_story and not isNil(arg_242_1.actors_["10014ui_story"]) then
					arg_242_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_242_1.var_.characterEffect10014ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_242_1.time_ - 0) / var_245_0)
				end
			end

			if arg_242_1.time_ >= 0 + var_245_0 and arg_242_1.time_ < 0 + var_245_0 + arg_245_0 and not isNil(arg_242_1.actors_["10014ui_story"]) and arg_242_1.var_.characterEffect10014ui_story then
				arg_242_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_242_1.var_.characterEffect10014ui_story.fillRatio = 0.5
			end

			local var_245_1 = arg_242_1.actors_["1084ui_story"]

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 and not isNil(var_245_1) and arg_242_1.var_.characterEffect1084ui_story == nil then
				arg_242_1.var_.characterEffect1084ui_story = var_245_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_245_2 = 0.200000002980232

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_2 and not isNil(var_245_1) then
				if arg_242_1.var_.characterEffect1084ui_story and not isNil(var_245_1) then
					arg_242_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_242_1.time_ >= 0 + var_245_2 and arg_242_1.time_ < 0 + var_245_2 + arg_245_0 and not isNil(var_245_1) and arg_242_1.var_.characterEffect1084ui_story then
				arg_242_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 then
				arg_242_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 then
				arg_242_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_245_4 = 0
			local var_245_5 = 0.4

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= var_245_4 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, true)

				arg_242_1.leftNameTxt_.text = arg_242_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_242_1.leftNameTxt_.transform)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1.leftNameTxt_.text)
				SetActive(arg_242_1.iconTrs_.gameObject, false)
				arg_242_1.callingController_:SetSelectedState("normal")

				local var_245_6 = arg_242_1:GetWordFromCfg(319671057)
				local var_245_7 = arg_242_1:FormatText(var_245_6.content)

				arg_242_1.text_.text = var_245_7

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_9 = 16 <= 0 and var_245_5 or var_245_5 * (utf8.len(var_245_7) / 16)

				if (16 <= 0 and var_245_5 or var_245_5 * (utf8.len(var_245_7) / 16)) > 0 and var_245_5 < var_245_9 then
					arg_242_1.talkMaxDuration = var_245_9

					if var_245_9 + var_245_4 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_9 + var_245_4
					end
				end

				arg_242_1.text_.text = var_245_7
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671057", "story_v_out_319671.awb") ~= 0 then
					local var_245_10 = manager.audio:GetVoiceLength("story_v_out_319671", "319671057", "story_v_out_319671.awb") / 1000

					if var_245_10 + var_245_4 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_10 + var_245_4
					end

					if var_245_6.prefab_name ~= "" and arg_242_1.actors_[var_245_6.prefab_name] ~= nil then
						local var_245_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_242_1.actors_[var_245_6.prefab_name].transform, "story_v_out_319671", "319671057", "story_v_out_319671.awb")

						arg_242_1:RecordAudio("319671057", var_245_11)
						arg_242_1:RecordAudio("319671057", var_245_11)
					else
						arg_242_1:AudioAction("play", "voice", "story_v_out_319671", "319671057", "story_v_out_319671.awb")
					end

					arg_242_1:RecordHistoryTalkVoice("story_v_out_319671", "319671057", "story_v_out_319671.awb")
				end

				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_12 = math.max(var_245_5, arg_242_1.talkMaxDuration)

			if var_245_4 <= arg_242_1.time_ and arg_242_1.time_ < var_245_4 + var_245_12 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - var_245_4) / var_245_12

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= var_245_4 + var_245_12 and arg_242_1.time_ < var_245_4 + var_245_12 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {}

		arg_242_1:InitPlayNodeList()
	end,
	Play319671058 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 319671058
		arg_246_1.duration_ = 5.33

		local var_246_0 = {
			zh = 5.333,
			ja = 2.466
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
				arg_246_0:Play319671059(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 and not isNil(arg_246_1.actors_["1084ui_story"]) and arg_246_1.var_.characterEffect1084ui_story == nil then
				arg_246_1.var_.characterEffect1084ui_story = arg_246_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_249_0 = 0.200000002980232

			if 0 <= arg_246_1.time_ and arg_246_1.time_ < 0 + var_249_0 and not isNil(arg_246_1.actors_["1084ui_story"]) then
				if arg_246_1.var_.characterEffect1084ui_story and not isNil(arg_246_1.actors_["1084ui_story"]) then
					arg_246_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_246_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_246_1.time_ - 0) / var_249_0)
				end
			end

			if arg_246_1.time_ >= 0 + var_249_0 and arg_246_1.time_ < 0 + var_249_0 + arg_249_0 and not isNil(arg_246_1.actors_["1084ui_story"]) and arg_246_1.var_.characterEffect1084ui_story then
				arg_246_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_246_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_249_1 = arg_246_1.actors_["10014ui_story"]

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 and not isNil(var_249_1) and arg_246_1.var_.characterEffect10014ui_story == nil then
				arg_246_1.var_.characterEffect10014ui_story = var_249_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_249_2 = 0.200000002980232

			if 0 <= arg_246_1.time_ and arg_246_1.time_ < 0 + var_249_2 and not isNil(var_249_1) then
				if arg_246_1.var_.characterEffect10014ui_story and not isNil(var_249_1) then
					arg_246_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_246_1.time_ >= 0 + var_249_2 and arg_246_1.time_ < 0 + var_249_2 + arg_249_0 and not isNil(var_249_1) and arg_246_1.var_.characterEffect10014ui_story then
				arg_246_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_249_4 = 0
			local var_249_5 = 0.5

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= var_249_4 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, true)

				arg_246_1.leftNameTxt_.text = arg_246_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_246_1.leftNameTxt_.transform)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1.leftNameTxt_.text)
				SetActive(arg_246_1.iconTrs_.gameObject, false)
				arg_246_1.callingController_:SetSelectedState("normal")

				local var_249_6 = arg_246_1:GetWordFromCfg(319671058)
				local var_249_7 = arg_246_1:FormatText(var_249_6.content)

				arg_246_1.text_.text = var_249_7

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_9 = 20 <= 0 and var_249_5 or var_249_5 * (utf8.len(var_249_7) / 20)

				if (20 <= 0 and var_249_5 or var_249_5 * (utf8.len(var_249_7) / 20)) > 0 and var_249_5 < var_249_9 then
					arg_246_1.talkMaxDuration = var_249_9

					if var_249_9 + var_249_4 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_9 + var_249_4
					end
				end

				arg_246_1.text_.text = var_249_7
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671058", "story_v_out_319671.awb") ~= 0 then
					local var_249_10 = manager.audio:GetVoiceLength("story_v_out_319671", "319671058", "story_v_out_319671.awb") / 1000

					if var_249_10 + var_249_4 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_10 + var_249_4
					end

					if var_249_6.prefab_name ~= "" and arg_246_1.actors_[var_249_6.prefab_name] ~= nil then
						local var_249_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_246_1.actors_[var_249_6.prefab_name].transform, "story_v_out_319671", "319671058", "story_v_out_319671.awb")

						arg_246_1:RecordAudio("319671058", var_249_11)
						arg_246_1:RecordAudio("319671058", var_249_11)
					else
						arg_246_1:AudioAction("play", "voice", "story_v_out_319671", "319671058", "story_v_out_319671.awb")
					end

					arg_246_1:RecordHistoryTalkVoice("story_v_out_319671", "319671058", "story_v_out_319671.awb")
				end

				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_12 = math.max(var_249_5, arg_246_1.talkMaxDuration)

			if var_249_4 <= arg_246_1.time_ and arg_246_1.time_ < var_249_4 + var_249_12 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - var_249_4) / var_249_12

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= var_249_4 + var_249_12 and arg_246_1.time_ < var_249_4 + var_249_12 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {}

		arg_246_1:InitPlayNodeList()
	end,
	Play319671059 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 319671059
		arg_250_1.duration_ = 16.27

		local var_250_0 = {
			zh = 12.066,
			ja = 16.266
		}
		local var_250_1 = manager.audio:GetLocalizationFlag()

		if var_250_0[var_250_1] ~= nil then
			arg_250_1.duration_ = var_250_0[var_250_1]
		end

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play319671060(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 then
				arg_250_1.var_.moveOldPos10014ui_story = arg_250_1.actors_["10014ui_story"].transform.localPosition
			end

			local var_253_0 = 0.001

			if 0 <= arg_250_1.time_ and arg_250_1.time_ < 0 + var_253_0 then
				arg_250_1.actors_["10014ui_story"].transform.localPosition = Vector3.Lerp(arg_250_1.var_.moveOldPos10014ui_story, Vector3.New(-0.7, -1.06, -6.2), (arg_250_1.time_ - 0) / var_253_0)
				arg_250_1.actors_["10014ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_250_1.actors_["10014ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_250_1.actors_["10014ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_250_1.actors_["10014ui_story"].transform.position).z)
				arg_250_1.actors_["10014ui_story"].transform.localEulerAngles.z = 0
				arg_250_1.actors_["10014ui_story"].transform.localEulerAngles.x = 0
				arg_250_1.actors_["10014ui_story"].transform.localEulerAngles = arg_250_1.actors_["10014ui_story"].transform.localEulerAngles
			end

			if arg_250_1.time_ >= 0 + var_253_0 and arg_250_1.time_ < 0 + var_253_0 + arg_253_0 then
				arg_250_1.actors_["10014ui_story"].transform.localPosition = Vector3.New(-0.7, -1.06, -6.2)
				arg_250_1.actors_["10014ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_250_1.actors_["10014ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_250_1.actors_["10014ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_250_1.actors_["10014ui_story"].transform.position).z)
				arg_250_1.actors_["10014ui_story"].transform.localEulerAngles.z = 0
				arg_250_1.actors_["10014ui_story"].transform.localEulerAngles.x = 0
				arg_250_1.actors_["10014ui_story"].transform.localEulerAngles = arg_250_1.actors_["10014ui_story"].transform.localEulerAngles
			end

			local var_253_1 = arg_250_1.actors_["10014ui_story"]

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 and not isNil(var_253_1) and arg_250_1.var_.characterEffect10014ui_story == nil then
				arg_250_1.var_.characterEffect10014ui_story = var_253_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_253_2 = 0.200000002980232

			if 0 <= arg_250_1.time_ and arg_250_1.time_ < 0 + var_253_2 and not isNil(var_253_1) then
				if arg_250_1.var_.characterEffect10014ui_story and not isNil(var_253_1) then
					arg_250_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_250_1.time_ >= 0 + var_253_2 and arg_250_1.time_ < 0 + var_253_2 + arg_253_0 and not isNil(var_253_1) and arg_250_1.var_.characterEffect10014ui_story then
				arg_250_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 then
				arg_250_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action3_1")
			end

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 then
				arg_250_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_253_4 = 0
			local var_253_5 = 1.275

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= var_253_4 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, true)

				arg_250_1.leftNameTxt_.text = arg_250_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_250_1.leftNameTxt_.transform)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1.leftNameTxt_.text)
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_6 = arg_250_1:GetWordFromCfg(319671059)
				local var_253_7 = arg_250_1:FormatText(var_253_6.content)

				arg_250_1.text_.text = var_253_7

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_9 = 51 <= 0 and var_253_5 or var_253_5 * (utf8.len(var_253_7) / 51)

				if (51 <= 0 and var_253_5 or var_253_5 * (utf8.len(var_253_7) / 51)) > 0 and var_253_5 < var_253_9 then
					arg_250_1.talkMaxDuration = var_253_9

					if var_253_9 + var_253_4 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_9 + var_253_4
					end
				end

				arg_250_1.text_.text = var_253_7
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671059", "story_v_out_319671.awb") ~= 0 then
					local var_253_10 = manager.audio:GetVoiceLength("story_v_out_319671", "319671059", "story_v_out_319671.awb") / 1000

					if var_253_10 + var_253_4 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_10 + var_253_4
					end

					if var_253_6.prefab_name ~= "" and arg_250_1.actors_[var_253_6.prefab_name] ~= nil then
						local var_253_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_250_1.actors_[var_253_6.prefab_name].transform, "story_v_out_319671", "319671059", "story_v_out_319671.awb")

						arg_250_1:RecordAudio("319671059", var_253_11)
						arg_250_1:RecordAudio("319671059", var_253_11)
					else
						arg_250_1:AudioAction("play", "voice", "story_v_out_319671", "319671059", "story_v_out_319671.awb")
					end

					arg_250_1:RecordHistoryTalkVoice("story_v_out_319671", "319671059", "story_v_out_319671.awb")
				end

				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_12 = math.max(var_253_5, arg_250_1.talkMaxDuration)

			if var_253_4 <= arg_250_1.time_ and arg_250_1.time_ < var_253_4 + var_253_12 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_4) / var_253_12

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_4 + var_253_12 and arg_250_1.time_ < var_253_4 + var_253_12 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_250_1:InitPlayNodeList()
	end,
	Play319671060 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 319671060
		arg_254_1.duration_ = 5

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play319671061(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 and not isNil(arg_254_1.actors_["10014ui_story"]) and arg_254_1.var_.characterEffect10014ui_story == nil then
				arg_254_1.var_.characterEffect10014ui_story = arg_254_1.actors_["10014ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_257_0 = 0.200000002980232

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_0 and not isNil(arg_254_1.actors_["10014ui_story"]) then
				if arg_254_1.var_.characterEffect10014ui_story and not isNil(arg_254_1.actors_["10014ui_story"]) then
					arg_254_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_254_1.var_.characterEffect10014ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_254_1.time_ - 0) / var_257_0)
				end
			end

			if arg_254_1.time_ >= 0 + var_257_0 and arg_254_1.time_ < 0 + var_257_0 + arg_257_0 and not isNil(arg_254_1.actors_["10014ui_story"]) and arg_254_1.var_.characterEffect10014ui_story then
				arg_254_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_254_1.var_.characterEffect10014ui_story.fillRatio = 0.5
			end

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 then
				arg_254_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_2")
			end

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 then
				arg_254_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_257_1 = 0
			local var_257_2 = 0.925

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= var_257_1 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, false)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_254_1.iconTrs_.gameObject, false)
				arg_254_1.callingController_:SetSelectedState("normal")

				local var_257_3 = arg_254_1:FormatText(arg_254_1:GetWordFromCfg(319671060).content)

				arg_254_1.text_.text = var_257_3

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_5 = 37 <= 0 and var_257_2 or var_257_2 * (utf8.len(var_257_3) / 37)

				if (37 <= 0 and var_257_2 or var_257_2 * (utf8.len(var_257_3) / 37)) > 0 and var_257_2 < var_257_5 then
					arg_254_1.talkMaxDuration = var_257_5

					if var_257_5 + var_257_1 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_5 + var_257_1
					end
				end

				arg_254_1.text_.text = var_257_3
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)
				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_6 = math.max(var_257_2, arg_254_1.talkMaxDuration)

			if var_257_1 <= arg_254_1.time_ and arg_254_1.time_ < var_257_1 + var_257_6 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_1) / var_257_6

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_1 + var_257_6 and arg_254_1.time_ < var_257_1 + var_257_6 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {}

		arg_254_1:InitPlayNodeList()
	end,
	Play319671061 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 319671061
		arg_258_1.duration_ = 3.23

		local var_258_0 = {
			zh = 3.233,
			ja = 2.9
		}
		local var_258_1 = manager.audio:GetLocalizationFlag()

		if var_258_0[var_258_1] ~= nil then
			arg_258_1.duration_ = var_258_0[var_258_1]
		end

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play319671062(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 then
				arg_258_1.var_.moveOldPos1084ui_story = arg_258_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_261_0 = 0.001

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_0 then
				arg_258_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_258_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_258_1.time_ - 0) / var_261_0)
				arg_258_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_258_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_258_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_258_1.actors_["1084ui_story"].transform.position).z)
				arg_258_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_258_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_258_1.actors_["1084ui_story"].transform.localEulerAngles = arg_258_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_258_1.time_ >= 0 + var_261_0 and arg_258_1.time_ < 0 + var_261_0 + arg_261_0 then
				arg_258_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0.7, -0.97, -6)
				arg_258_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_258_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_258_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_258_1.actors_["1084ui_story"].transform.position).z)
				arg_258_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_258_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_258_1.actors_["1084ui_story"].transform.localEulerAngles = arg_258_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_261_1 = arg_258_1.actors_["1084ui_story"]

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 and not isNil(var_261_1) and arg_258_1.var_.characterEffect1084ui_story == nil then
				arg_258_1.var_.characterEffect1084ui_story = var_261_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_261_2 = 0.200000002980232

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_2 and not isNil(var_261_1) then
				if arg_258_1.var_.characterEffect1084ui_story and not isNil(var_261_1) then
					arg_258_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_258_1.time_ >= 0 + var_261_2 and arg_258_1.time_ < 0 + var_261_2 + arg_261_0 and not isNil(var_261_1) and arg_258_1.var_.characterEffect1084ui_story then
				arg_258_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_261_4 = 0
			local var_261_5 = 0.3

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= var_261_4 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				arg_258_1.leftNameTxt_.text = arg_258_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, false)
				arg_258_1.callingController_:SetSelectedState("normal")

				local var_261_6 = arg_258_1:GetWordFromCfg(319671061)
				local var_261_7 = arg_258_1:FormatText(var_261_6.content)

				arg_258_1.text_.text = var_261_7

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_9 = 12 <= 0 and var_261_5 or var_261_5 * (utf8.len(var_261_7) / 12)

				if (12 <= 0 and var_261_5 or var_261_5 * (utf8.len(var_261_7) / 12)) > 0 and var_261_5 < var_261_9 then
					arg_258_1.talkMaxDuration = var_261_9

					if var_261_9 + var_261_4 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_9 + var_261_4
					end
				end

				arg_258_1.text_.text = var_261_7
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671061", "story_v_out_319671.awb") ~= 0 then
					local var_261_10 = manager.audio:GetVoiceLength("story_v_out_319671", "319671061", "story_v_out_319671.awb") / 1000

					if var_261_10 + var_261_4 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_10 + var_261_4
					end

					if var_261_6.prefab_name ~= "" and arg_258_1.actors_[var_261_6.prefab_name] ~= nil then
						local var_261_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_258_1.actors_[var_261_6.prefab_name].transform, "story_v_out_319671", "319671061", "story_v_out_319671.awb")

						arg_258_1:RecordAudio("319671061", var_261_11)
						arg_258_1:RecordAudio("319671061", var_261_11)
					else
						arg_258_1:AudioAction("play", "voice", "story_v_out_319671", "319671061", "story_v_out_319671.awb")
					end

					arg_258_1:RecordHistoryTalkVoice("story_v_out_319671", "319671061", "story_v_out_319671.awb")
				end

				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_12 = math.max(var_261_5, arg_258_1.talkMaxDuration)

			if var_261_4 <= arg_258_1.time_ and arg_258_1.time_ < var_261_4 + var_261_12 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_4) / var_261_12

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_4 + var_261_12 and arg_258_1.time_ < var_261_4 + var_261_12 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {
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

		arg_258_1:InitPlayNodeList()
	end,
	Play319671062 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 319671062
		arg_262_1.duration_ = 6

		local var_262_0 = {
			zh = 5.9,
			ja = 6
		}
		local var_262_1 = manager.audio:GetLocalizationFlag()

		if var_262_0[var_262_1] ~= nil then
			arg_262_1.duration_ = var_262_0[var_262_1]
		end

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play319671063(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 and not isNil(arg_262_1.actors_["1084ui_story"]) and arg_262_1.var_.characterEffect1084ui_story == nil then
				arg_262_1.var_.characterEffect1084ui_story = arg_262_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_265_0 = 0.200000002980232

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_0 and not isNil(arg_262_1.actors_["1084ui_story"]) then
				if arg_262_1.var_.characterEffect1084ui_story and not isNil(arg_262_1.actors_["1084ui_story"]) then
					arg_262_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_262_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_262_1.time_ - 0) / var_265_0)
				end
			end

			if arg_262_1.time_ >= 0 + var_265_0 and arg_262_1.time_ < 0 + var_265_0 + arg_265_0 and not isNil(arg_262_1.actors_["1084ui_story"]) and arg_262_1.var_.characterEffect1084ui_story then
				arg_262_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_262_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_265_1 = arg_262_1.actors_["10014ui_story"]

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 and not isNil(var_265_1) and arg_262_1.var_.characterEffect10014ui_story == nil then
				arg_262_1.var_.characterEffect10014ui_story = var_265_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_265_2 = 0.200000002980232

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_2 and not isNil(var_265_1) then
				if arg_262_1.var_.characterEffect10014ui_story and not isNil(var_265_1) then
					arg_262_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_262_1.time_ >= 0 + var_265_2 and arg_262_1.time_ < 0 + var_265_2 + arg_265_0 and not isNil(var_265_1) and arg_262_1.var_.characterEffect10014ui_story then
				arg_262_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_265_4 = 0
			local var_265_5 = 0.675

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= var_265_4 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, true)

				arg_262_1.leftNameTxt_.text = arg_262_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_262_1.leftNameTxt_.transform)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1.leftNameTxt_.text)
				SetActive(arg_262_1.iconTrs_.gameObject, false)
				arg_262_1.callingController_:SetSelectedState("normal")

				local var_265_6 = arg_262_1:GetWordFromCfg(319671062)
				local var_265_7 = arg_262_1:FormatText(var_265_6.content)

				arg_262_1.text_.text = var_265_7

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_9 = 27 <= 0 and var_265_5 or var_265_5 * (utf8.len(var_265_7) / 27)

				if (27 <= 0 and var_265_5 or var_265_5 * (utf8.len(var_265_7) / 27)) > 0 and var_265_5 < var_265_9 then
					arg_262_1.talkMaxDuration = var_265_9

					if var_265_9 + var_265_4 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_9 + var_265_4
					end
				end

				arg_262_1.text_.text = var_265_7
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671062", "story_v_out_319671.awb") ~= 0 then
					local var_265_10 = manager.audio:GetVoiceLength("story_v_out_319671", "319671062", "story_v_out_319671.awb") / 1000

					if var_265_10 + var_265_4 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_10 + var_265_4
					end

					if var_265_6.prefab_name ~= "" and arg_262_1.actors_[var_265_6.prefab_name] ~= nil then
						local var_265_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_262_1.actors_[var_265_6.prefab_name].transform, "story_v_out_319671", "319671062", "story_v_out_319671.awb")

						arg_262_1:RecordAudio("319671062", var_265_11)
						arg_262_1:RecordAudio("319671062", var_265_11)
					else
						arg_262_1:AudioAction("play", "voice", "story_v_out_319671", "319671062", "story_v_out_319671.awb")
					end

					arg_262_1:RecordHistoryTalkVoice("story_v_out_319671", "319671062", "story_v_out_319671.awb")
				end

				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_12 = math.max(var_265_5, arg_262_1.talkMaxDuration)

			if var_265_4 <= arg_262_1.time_ and arg_262_1.time_ < var_265_4 + var_265_12 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_4) / var_265_12

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_4 + var_265_12 and arg_262_1.time_ < var_265_4 + var_265_12 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {}

		arg_262_1:InitPlayNodeList()
	end,
	Play319671063 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 319671063
		arg_266_1.duration_ = 5

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play319671064(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 and not isNil(arg_266_1.actors_["10014ui_story"]) and arg_266_1.var_.characterEffect10014ui_story == nil then
				arg_266_1.var_.characterEffect10014ui_story = arg_266_1.actors_["10014ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_269_0 = 0.200000002980232

			if 0 <= arg_266_1.time_ and arg_266_1.time_ < 0 + var_269_0 and not isNil(arg_266_1.actors_["10014ui_story"]) then
				if arg_266_1.var_.characterEffect10014ui_story and not isNil(arg_266_1.actors_["10014ui_story"]) then
					arg_266_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_266_1.var_.characterEffect10014ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_266_1.time_ - 0) / var_269_0)
				end
			end

			if arg_266_1.time_ >= 0 + var_269_0 and arg_266_1.time_ < 0 + var_269_0 + arg_269_0 and not isNil(arg_266_1.actors_["10014ui_story"]) and arg_266_1.var_.characterEffect10014ui_story then
				arg_266_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_266_1.var_.characterEffect10014ui_story.fillRatio = 0.5
			end

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 then
				arg_266_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2202cva")
			end

			local var_269_1 = 0
			local var_269_2 = 1.45

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= var_269_1 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, false)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_266_1.iconTrs_.gameObject, false)
				arg_266_1.callingController_:SetSelectedState("normal")

				local var_269_3 = arg_266_1:FormatText(arg_266_1:GetWordFromCfg(319671063).content)

				arg_266_1.text_.text = var_269_3

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_5 = 58 <= 0 and var_269_2 or var_269_2 * (utf8.len(var_269_3) / 58)

				if (58 <= 0 and var_269_2 or var_269_2 * (utf8.len(var_269_3) / 58)) > 0 and var_269_2 < var_269_5 then
					arg_266_1.talkMaxDuration = var_269_5

					if var_269_5 + var_269_1 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_5 + var_269_1
					end
				end

				arg_266_1.text_.text = var_269_3
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)
				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_6 = math.max(var_269_2, arg_266_1.talkMaxDuration)

			if var_269_1 <= arg_266_1.time_ and arg_266_1.time_ < var_269_1 + var_269_6 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_1) / var_269_6

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_1 + var_269_6 and arg_266_1.time_ < var_269_1 + var_269_6 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {}

		arg_266_1:InitPlayNodeList()
	end,
	Play319671064 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 319671064
		arg_270_1.duration_ = 5.93

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play319671065(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				local var_273_0 = arg_270_1.fswbg_.transform:Find("textbox/adapt/content") or arg_270_1.fswbg_.transform:Find("textbox/content")
				local var_273_1 = arg_270_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_273_2 = var_273_0:GetComponent("RectTransform")

				var_273_0:GetComponent("Text").alignment = UnityEngine.TextAnchor.LowerCenter
				var_273_2.offsetMin = Vector2.New(0, 0)
				var_273_2.offsetMax = Vector2.New(0, 0)
			end

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				arg_270_1.fswbg_:SetActive(true)
				arg_270_1.dialog_:SetActive(false)

				arg_270_1.fswtw_.percent = 0
				arg_270_1.fswt_.text = arg_270_1:FormatText(arg_270_1:GetWordFromCfg(319671064).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.fswt_)

				arg_270_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_270_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_270_1.fswtw_:SetDirty()

				arg_270_1.typewritterCharCountI18N = 0

				SetActive(arg_270_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_270_1:ShowNextGo(false)
			end

			local var_273_3 = 0.566666666666668

			if 0.566666666666668 < arg_270_1.time_ and arg_270_1.time_ <= var_273_3 + arg_273_0 then
				arg_270_1.var_.oldValueTypewriter = arg_270_1.fswtw_.percent

				SetActive(arg_270_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_270_1:ShowNextGo(false)
			end

			local var_273_4 = 24
			local var_273_5 = 1.6
			local var_273_6, var_273_7 = arg_270_1:GetPercentByPara(arg_270_1:FormatText(arg_270_1:GetWordFromCfg(319671064).content), 1)

			if var_273_3 < arg_270_1.time_ and arg_270_1.time_ <= var_273_3 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0

				local var_273_8 = var_273_4 <= 0 and var_273_5 or var_273_5 * ((var_273_7 - arg_270_1.typewritterCharCountI18N) / var_273_4)

				if (var_273_4 <= 0 and var_273_5 or var_273_5 * ((var_273_7 - arg_270_1.typewritterCharCountI18N) / var_273_4)) > 0 and var_273_5 < var_273_8 then
					arg_270_1.talkMaxDuration = var_273_8

					if var_273_8 + var_273_3 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_8 + var_273_3
					end
				end
			end

			local var_273_9 = math.max(1.6, arg_270_1.talkMaxDuration)

			if var_273_3 <= arg_270_1.time_ and arg_270_1.time_ < var_273_3 + var_273_9 then
				arg_270_1.fswtw_.percent = Mathf.Lerp(arg_270_1.var_.oldValueTypewriter, var_273_6, (arg_270_1.time_ - var_273_3) / var_273_9)
				arg_270_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_270_1.fswtw_:SetDirty()
			end

			if arg_270_1.time_ >= var_273_3 + var_273_9 and arg_270_1.time_ < var_273_3 + var_273_9 + arg_273_0 then
				arg_270_1.fswtw_.percent = var_273_6

				arg_270_1.fswtw_:SetDirty()
				arg_270_1:ShowNextGo(true)

				arg_270_1.typewritterCharCountI18N = var_273_7
			end

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				arg_270_1.cswbg_:SetActive(true)

				local var_273_10 = arg_270_1.cswt_:GetComponent("RectTransform")

				arg_270_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_273_10.offsetMin = Vector2.New(410, 330)
				var_273_10.offsetMax = Vector2.New(-400, -175)
				arg_270_1.cswt_.text = arg_270_1:FormatText(arg_270_1:GetWordFromCfg(419038).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.cswt_)

				arg_270_1.cswt_.fontSize = 180
				arg_270_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_270_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_270_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				local var_273_11 = arg_270_1.bgs_.STblack

				arg_270_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_273_11.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_273_12 = var_273_11:GetComponent("SpriteRenderer")

				if var_273_12 and var_273_12.sprite then
					local var_273_13 = 2 * (var_273_11.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_273_11.transform.localScale = Vector3.New(var_273_13 / var_273_12.sprite.bounds.size.y < var_273_13 * manager.ui.mainCameraCom_.aspect / var_273_12.sprite.bounds.size.x and var_273_13 * manager.ui.mainCameraCom_.aspect / var_273_12.sprite.bounds.size.x or var_273_13 / var_273_12.sprite.bounds.size.y, var_273_13 / var_273_12.sprite.bounds.size.y < var_273_13 * manager.ui.mainCameraCom_.aspect / var_273_12.sprite.bounds.size.x and var_273_13 * manager.ui.mainCameraCom_.aspect / var_273_12.sprite.bounds.size.x or var_273_13 / var_273_12.sprite.bounds.size.y, 0)
				end

				for iter_273_0, iter_273_1 in pairs(arg_270_1.bgs_) do
					if iter_273_0 ~= "STblack" then
						iter_273_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_273_14 = 0

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= var_273_14 + arg_273_0 then
				arg_270_1.mask_.enabled = true
				arg_270_1.mask_.raycastTarget = true

				arg_270_1:SetGaussion(false)
			end

			local var_273_15 = 1.2

			if var_273_14 <= arg_270_1.time_ and arg_270_1.time_ < var_273_14 + var_273_15 then
				local var_273_16 = Color.New(0, 0, 0)

				var_273_16.a = Mathf.Lerp(1, 0, (arg_270_1.time_ - var_273_14) / var_273_15)
				arg_270_1.mask_.color = var_273_16
			end

			if arg_270_1.time_ >= var_273_14 + var_273_15 and arg_270_1.time_ < var_273_14 + var_273_15 + arg_273_0 then
				local var_273_17 = Color.New(0, 0, 0)

				arg_270_1.mask_.enabled = false
				var_273_17.a = 0
				arg_270_1.mask_.color = var_273_17
			end

			local var_273_18 = arg_270_1.actors_["10014ui_story"].transform

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				arg_270_1.var_.moveOldPos10014ui_story = var_273_18.localPosition
			end

			local var_273_19 = 0.001

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_19 then
				var_273_18.localPosition = Vector3.Lerp(arg_270_1.var_.moveOldPos10014ui_story, Vector3.New(0, 100, 0), (arg_270_1.time_ - 0) / var_273_19)
				var_273_18.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_273_18.position).x, (manager.ui.mainCamera.transform.position - var_273_18.position).y, (manager.ui.mainCamera.transform.position - var_273_18.position).z)
				var_273_18.localEulerAngles.z = 0
				var_273_18.localEulerAngles.x = 0
				var_273_18.localEulerAngles = var_273_18.localEulerAngles
			end

			if arg_270_1.time_ >= 0 + var_273_19 and arg_270_1.time_ < 0 + var_273_19 + arg_273_0 then
				var_273_18.localPosition = Vector3.New(0, 100, 0)
				var_273_18.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_273_18.position).x, (manager.ui.mainCamera.transform.position - var_273_18.position).y, (manager.ui.mainCamera.transform.position - var_273_18.position).z)
				var_273_18.localEulerAngles.z = 0
				var_273_18.localEulerAngles.x = 0
				var_273_18.localEulerAngles = var_273_18.localEulerAngles
			end

			local var_273_20 = arg_270_1.actors_["1084ui_story"].transform

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				arg_270_1.var_.moveOldPos1084ui_story = var_273_20.localPosition
			end

			local var_273_21 = 0.001

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_21 then
				var_273_20.localPosition = Vector3.Lerp(arg_270_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_270_1.time_ - 0) / var_273_21)
				var_273_20.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_273_20.position).x, (manager.ui.mainCamera.transform.position - var_273_20.position).y, (manager.ui.mainCamera.transform.position - var_273_20.position).z)
				var_273_20.localEulerAngles.z = 0
				var_273_20.localEulerAngles.x = 0
				var_273_20.localEulerAngles = var_273_20.localEulerAngles
			end

			if arg_270_1.time_ >= 0 + var_273_21 and arg_270_1.time_ < 0 + var_273_21 + arg_273_0 then
				var_273_20.localPosition = Vector3.New(0, 100, 0)
				var_273_20.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_273_20.position).x, (manager.ui.mainCamera.transform.position - var_273_20.position).y, (manager.ui.mainCamera.transform.position - var_273_20.position).z)
				var_273_20.localEulerAngles.z = 0
				var_273_20.localEulerAngles.x = 0
				var_273_20.localEulerAngles = var_273_20.localEulerAngles
			end

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				if arg_270_1.var_.characterEffect10014ui_story == nil then
					arg_270_1.var_.characterEffect10014ui_story = arg_270_1.actors_["10014ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_273_22 = arg_270_1.var_.characterEffect10014ui_story

				arg_270_1.var_.characterEffect10014ui_story.imageEffect:turnOff()

				var_273_22.interferenceEffect.enabled = false
				var_273_22.interferenceEffect.noise = 0.001
				var_273_22.interferenceEffect.simTimeScale = 1
				var_273_22.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				if arg_270_1.var_.characterEffect10014ui_story == nil then
					arg_270_1.var_.characterEffect10014ui_story = arg_270_1.actors_["10014ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_270_1.var_.characterEffect10014ui_story.imageEffect:turnOff()
			end

			local var_273_24 = 0.566666666666667
			local var_273_25 = manager.audio:GetVoiceLength("story_v_out_319671", "319671064", "story_v_out_319671.awb") / 1000

			if var_273_25 > 0 and 5.366 < var_273_25 and var_273_25 + var_273_24 > arg_270_1.duration_ then
				arg_270_1.duration_ = var_273_25 + var_273_24
			end

			if var_273_24 < arg_270_1.time_ and arg_270_1.time_ <= var_273_24 + arg_273_0 then
				arg_270_1:AudioAction("play", "voice", "story_v_out_319671", "319671064", "story_v_out_319671.awb")
			end
		end

		arg_270_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_270_1:InitPlayNodeList()
	end,
	Play319671065 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 319671065
		arg_274_1.duration_ = 3.23

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play319671066(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 then
				arg_274_1.fswbg_:SetActive(true)
				arg_274_1.dialog_:SetActive(false)

				arg_274_1.fswtw_.percent = 0
				arg_274_1.fswt_.text = arg_274_1:FormatText(arg_274_1:GetWordFromCfg(319671065).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.fswt_)

				arg_274_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_274_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_274_1.fswtw_:SetDirty()

				arg_274_1.typewritterCharCountI18N = 0

				SetActive(arg_274_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_274_1:ShowNextGo(false)
			end

			local var_277_0 = 0.366666666666667

			if 0.366666666666667 < arg_274_1.time_ and arg_274_1.time_ <= var_277_0 + arg_277_0 then
				arg_274_1.var_.oldValueTypewriter = arg_274_1.fswtw_.percent

				SetActive(arg_274_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_274_1:ShowNextGo(false)
			end

			local var_277_1 = 14
			local var_277_2 = 0.933333333333333
			local var_277_3, var_277_4 = arg_274_1:GetPercentByPara(arg_274_1:FormatText(arg_274_1:GetWordFromCfg(319671065).content), 1)

			if var_277_0 < arg_274_1.time_ and arg_274_1.time_ <= var_277_0 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0

				local var_277_5 = var_277_1 <= 0 and var_277_2 or var_277_2 * ((var_277_4 - arg_274_1.typewritterCharCountI18N) / var_277_1)

				if (var_277_1 <= 0 and var_277_2 or var_277_2 * ((var_277_4 - arg_274_1.typewritterCharCountI18N) / var_277_1)) > 0 and var_277_2 < var_277_5 then
					arg_274_1.talkMaxDuration = var_277_5

					if var_277_5 + var_277_0 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_5 + var_277_0
					end
				end
			end

			local var_277_6 = math.max(0.933333333333333, arg_274_1.talkMaxDuration)

			if var_277_0 <= arg_274_1.time_ and arg_274_1.time_ < var_277_0 + var_277_6 then
				arg_274_1.fswtw_.percent = Mathf.Lerp(arg_274_1.var_.oldValueTypewriter, var_277_3, (arg_274_1.time_ - var_277_0) / var_277_6)
				arg_274_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_274_1.fswtw_:SetDirty()
			end

			if arg_274_1.time_ >= var_277_0 + var_277_6 and arg_274_1.time_ < var_277_0 + var_277_6 + arg_277_0 then
				arg_274_1.fswtw_.percent = var_277_3

				arg_274_1.fswtw_:SetDirty()
				arg_274_1:ShowNextGo(true)

				arg_274_1.typewritterCharCountI18N = var_277_4
			end

			local var_277_7 = 0.3
			local var_277_8 = manager.audio:GetVoiceLength("story_v_out_319671", "319671065", "story_v_out_319671.awb") / 1000

			if var_277_8 > 0 and 2.933 < var_277_8 and var_277_8 + var_277_7 > arg_274_1.duration_ then
				arg_274_1.duration_ = var_277_8 + var_277_7
			end

			if var_277_7 < arg_274_1.time_ and arg_274_1.time_ <= var_277_7 + arg_277_0 then
				arg_274_1:AudioAction("play", "voice", "story_v_out_319671", "319671065", "story_v_out_319671.awb")
			end
		end

		arg_274_1.nodeConfigList_ = {}

		arg_274_1:InitPlayNodeList()
	end,
	Play319671066 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 319671066
		arg_278_1.duration_ = 4.7

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play319671067(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 then
				arg_278_1.fswbg_:SetActive(true)
				arg_278_1.dialog_:SetActive(false)

				arg_278_1.fswtw_.percent = 0
				arg_278_1.fswt_.text = arg_278_1:FormatText(arg_278_1:GetWordFromCfg(319671066).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.fswt_)

				arg_278_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_278_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_278_1.fswtw_:SetDirty()

				arg_278_1.typewritterCharCountI18N = 0

				SetActive(arg_278_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_278_1:ShowNextGo(false)
			end

			local var_281_0 = 0.266666666666667

			if 0.266666666666667 < arg_278_1.time_ and arg_278_1.time_ <= var_281_0 + arg_281_0 then
				arg_278_1.var_.oldValueTypewriter = arg_278_1.fswtw_.percent

				SetActive(arg_278_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_278_1:ShowNextGo(false)
			end

			local var_281_1 = 19
			local var_281_2 = 1.26666666666667
			local var_281_3, var_281_4 = arg_278_1:GetPercentByPara(arg_278_1:FormatText(arg_278_1:GetWordFromCfg(319671066).content), 1)

			if var_281_0 < arg_278_1.time_ and arg_278_1.time_ <= var_281_0 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0

				local var_281_5 = var_281_1 <= 0 and var_281_2 or var_281_2 * ((var_281_4 - arg_278_1.typewritterCharCountI18N) / var_281_1)

				if (var_281_1 <= 0 and var_281_2 or var_281_2 * ((var_281_4 - arg_278_1.typewritterCharCountI18N) / var_281_1)) > 0 and var_281_2 < var_281_5 then
					arg_278_1.talkMaxDuration = var_281_5

					if var_281_5 + var_281_0 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_5 + var_281_0
					end
				end
			end

			local var_281_6 = math.max(1.26666666666667, arg_278_1.talkMaxDuration)

			if var_281_0 <= arg_278_1.time_ and arg_278_1.time_ < var_281_0 + var_281_6 then
				arg_278_1.fswtw_.percent = Mathf.Lerp(arg_278_1.var_.oldValueTypewriter, var_281_3, (arg_278_1.time_ - var_281_0) / var_281_6)
				arg_278_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_278_1.fswtw_:SetDirty()
			end

			if arg_278_1.time_ >= var_281_0 + var_281_6 and arg_278_1.time_ < var_281_0 + var_281_6 + arg_281_0 then
				arg_278_1.fswtw_.percent = var_281_3

				arg_278_1.fswtw_:SetDirty()
				arg_278_1:ShowNextGo(true)

				arg_278_1.typewritterCharCountI18N = var_281_4
			end

			local var_281_7 = 0.266666666666667
			local var_281_8 = manager.audio:GetVoiceLength("story_v_out_319671", "319671066", "story_v_out_319671.awb") / 1000

			if var_281_8 > 0 and 4.433 < var_281_8 and var_281_8 + var_281_7 > arg_278_1.duration_ then
				arg_278_1.duration_ = var_281_8 + var_281_7
			end

			if var_281_7 < arg_278_1.time_ and arg_278_1.time_ <= var_281_7 + arg_281_0 then
				arg_278_1:AudioAction("play", "voice", "story_v_out_319671", "319671066", "story_v_out_319671.awb")
			end
		end

		arg_278_1.nodeConfigList_ = {}

		arg_278_1:InitPlayNodeList()
	end,
	Play319671067 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 319671067
		arg_282_1.duration_ = 8.27

		local var_282_0 = {
			zh = 8.26666666851441,
			ja = 7.23366666851441
		}
		local var_282_1 = manager.audio:GetLocalizationFlag()

		if var_282_0[var_282_1] ~= nil then
			arg_282_1.duration_ = var_282_0[var_282_1]
		end

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play319671068(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 then
				local var_285_0 = arg_282_1.bgs_.ST69

				arg_282_1.bgs_.ST69.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_285_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_285_1 = var_285_0:GetComponent("SpriteRenderer")

				if var_285_1 and var_285_1.sprite then
					local var_285_2 = 2 * (var_285_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_285_0.transform.localScale = Vector3.New(var_285_2 / var_285_1.sprite.bounds.size.y < var_285_2 * manager.ui.mainCameraCom_.aspect / var_285_1.sprite.bounds.size.x and var_285_2 * manager.ui.mainCameraCom_.aspect / var_285_1.sprite.bounds.size.x or var_285_2 / var_285_1.sprite.bounds.size.y, var_285_2 / var_285_1.sprite.bounds.size.y < var_285_2 * manager.ui.mainCameraCom_.aspect / var_285_1.sprite.bounds.size.x and var_285_2 * manager.ui.mainCameraCom_.aspect / var_285_1.sprite.bounds.size.x or var_285_2 / var_285_1.sprite.bounds.size.y, 0)
				end

				for iter_285_0, iter_285_1 in pairs(arg_282_1.bgs_) do
					if iter_285_0 ~= "ST69" then
						iter_285_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_285_3 = arg_282_1.actors_["10014ui_story"].transform

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 then
				arg_282_1.var_.moveOldPos10014ui_story = var_285_3.localPosition
			end

			local var_285_4 = 0.001

			if 0 <= arg_282_1.time_ and arg_282_1.time_ < 0 + var_285_4 then
				var_285_3.localPosition = Vector3.Lerp(arg_282_1.var_.moveOldPos10014ui_story, Vector3.New(0, -1.06, -6.2), (arg_282_1.time_ - 0) / var_285_4)
				var_285_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_285_3.position).x, (manager.ui.mainCamera.transform.position - var_285_3.position).y, (manager.ui.mainCamera.transform.position - var_285_3.position).z)
				var_285_3.localEulerAngles.z = 0
				var_285_3.localEulerAngles.x = 0
				var_285_3.localEulerAngles = var_285_3.localEulerAngles
			end

			if arg_282_1.time_ >= 0 + var_285_4 and arg_282_1.time_ < 0 + var_285_4 + arg_285_0 then
				var_285_3.localPosition = Vector3.New(0, -1.06, -6.2)
				var_285_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_285_3.position).x, (manager.ui.mainCamera.transform.position - var_285_3.position).y, (manager.ui.mainCamera.transform.position - var_285_3.position).z)
				var_285_3.localEulerAngles.z = 0
				var_285_3.localEulerAngles.x = 0
				var_285_3.localEulerAngles = var_285_3.localEulerAngles
			end

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 then
				arg_282_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 then
				arg_282_1.fswbg_:SetActive(false)
				arg_282_1.dialog_:SetActive(false)
				SetActive(arg_282_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_282_1:ShowNextGo(false)
			end

			if 0.0333333333333334 < arg_282_1.time_ and arg_282_1.time_ <= 0.0333333333333334 + arg_285_0 then
				arg_282_1.fswbg_:SetActive(false)
				arg_282_1.dialog_:SetActive(false)
				SetActive(arg_282_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_282_1:ShowNextGo(false)
			end

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 then
				arg_282_1.cswbg_:SetActive(false)
			end

			local var_285_5 = arg_282_1.actors_["10014ui_story"]

			if 0.0340000018477441 < arg_282_1.time_ and arg_282_1.time_ <= 0.0340000018477441 + arg_285_0 and not isNil(var_285_5) and arg_282_1.var_.characterEffect10014ui_story == nil then
				arg_282_1.var_.characterEffect10014ui_story = var_285_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_285_6 = 0.2

			if 0.0340000018477441 <= arg_282_1.time_ and arg_282_1.time_ < 0.0340000018477441 + var_285_6 and not isNil(var_285_5) then
				if arg_282_1.var_.characterEffect10014ui_story and not isNil(var_285_5) then
					arg_282_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_282_1.time_ >= 0.0340000018477441 + var_285_6 and arg_282_1.time_ < 0.0340000018477441 + var_285_6 + arg_285_0 and not isNil(var_285_5) and arg_282_1.var_.characterEffect10014ui_story then
				arg_282_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			if 0.0340000018477441 < arg_282_1.time_ and arg_282_1.time_ <= 0.0340000018477441 + arg_285_0 then
				if arg_282_1.var_.characterEffect10014ui_story == nil then
					arg_282_1.var_.characterEffect10014ui_story = arg_282_1.actors_["10014ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_285_8 = arg_282_1.var_.characterEffect10014ui_story

				arg_282_1.var_.characterEffect10014ui_story.imageEffect:turnOff()

				var_285_8.interferenceEffect.enabled = true
				var_285_8.interferenceEffect.noise = 0.001
				var_285_8.interferenceEffect.simTimeScale = 1
				var_285_8.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if 0.0340000018477441 < arg_282_1.time_ and arg_282_1.time_ <= 0.0340000018477441 + arg_285_0 then
				if arg_282_1.var_.characterEffect10014ui_story == nil then
					arg_282_1.var_.characterEffect10014ui_story = arg_282_1.actors_["10014ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_282_1.var_.characterEffect10014ui_story.imageEffect:turnOn(false)
			end

			if arg_282_1.frameCnt_ <= 1 then
				arg_282_1.dialog_:SetActive(false)
			end

			local var_285_10 = 0.300666668514411
			local var_285_11 = 0.925

			if 0.300666668514411 < arg_282_1.time_ and arg_282_1.time_ <= var_285_10 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0

				arg_282_1.dialog_:SetActive(true)

				arg_282_1.dialogCg_.alpha = 0

				local var_285_12 = LeanTween.value(arg_282_1.dialog_, 0, 1, 0.3)

				var_285_12:setOnUpdate(LuaHelper.FloatAction(function(arg_286_0)
					arg_282_1.dialogCg_.alpha = arg_286_0
				end))
				var_285_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_282_1.dialog_)
					var_285_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_282_1.duration_ = arg_282_1.duration_ + 0.3

				SetActive(arg_282_1.leftNameGo_, true)

				arg_282_1.leftNameTxt_.text = arg_282_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_282_1.leftNameTxt_.transform)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1.leftNameTxt_.text)
				SetActive(arg_282_1.iconTrs_.gameObject, false)
				arg_282_1.callingController_:SetSelectedState("normal")

				local var_285_13 = arg_282_1:GetWordFromCfg(319671067)
				local var_285_14 = arg_282_1:FormatText(var_285_13.content)

				arg_282_1.text_.text = var_285_14

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_16 = 37 <= 0 and var_285_11 or var_285_11 * (utf8.len(var_285_14) / 37)

				if (37 <= 0 and var_285_11 or var_285_11 * (utf8.len(var_285_14) / 37)) > 0 and var_285_11 < var_285_16 then
					arg_282_1.talkMaxDuration = var_285_16
					var_285_10 = var_285_10 + 0.3

					if var_285_16 + var_285_10 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_16 + var_285_10
					end
				end

				arg_282_1.text_.text = var_285_14
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671067", "story_v_out_319671.awb") ~= 0 then
					local var_285_17 = manager.audio:GetVoiceLength("story_v_out_319671", "319671067", "story_v_out_319671.awb") / 1000

					if var_285_17 + var_285_10 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_17 + var_285_10
					end

					if var_285_13.prefab_name ~= "" and arg_282_1.actors_[var_285_13.prefab_name] ~= nil then
						local var_285_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_282_1.actors_[var_285_13.prefab_name].transform, "story_v_out_319671", "319671067", "story_v_out_319671.awb")

						arg_282_1:RecordAudio("319671067", var_285_18)
						arg_282_1:RecordAudio("319671067", var_285_18)
					else
						arg_282_1:AudioAction("play", "voice", "story_v_out_319671", "319671067", "story_v_out_319671.awb")
					end

					arg_282_1:RecordHistoryTalkVoice("story_v_out_319671", "319671067", "story_v_out_319671.awb")
				end

				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_19 = var_285_10 + 0.3
			local var_285_20 = math.max(var_285_11, arg_282_1.talkMaxDuration)

			if var_285_10 + 0.3 <= arg_282_1.time_ and arg_282_1.time_ < var_285_19 + var_285_20 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - var_285_19) / var_285_20

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= var_285_19 + var_285_20 and arg_282_1.time_ < var_285_19 + var_285_20 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_282_1:InitPlayNodeList()
	end,
	Play319671068 = function(arg_288_0, arg_288_1)
		arg_288_1.time_ = 0
		arg_288_1.frameCnt_ = 0
		arg_288_1.state_ = "playing"
		arg_288_1.curTalkId_ = 319671068
		arg_288_1.duration_ = 5.93

		local var_288_0 = {
			zh = 3.333,
			ja = 5.933
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
				arg_288_0:Play319671069(arg_288_1)
			end
		end

		function arg_288_1.onSingleLineUpdate_(arg_291_0)
			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 and not isNil(arg_288_1.actors_["10014ui_story"]) and arg_288_1.var_.characterEffect10014ui_story == nil then
				arg_288_1.var_.characterEffect10014ui_story = arg_288_1.actors_["10014ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_291_0 = 0.200000002980232

			if 0 <= arg_288_1.time_ and arg_288_1.time_ < 0 + var_291_0 and not isNil(arg_288_1.actors_["10014ui_story"]) then
				if arg_288_1.var_.characterEffect10014ui_story and not isNil(arg_288_1.actors_["10014ui_story"]) then
					arg_288_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_288_1.var_.characterEffect10014ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_288_1.time_ - 0) / var_291_0)
				end
			end

			if arg_288_1.time_ >= 0 + var_291_0 and arg_288_1.time_ < 0 + var_291_0 + arg_291_0 and not isNil(arg_288_1.actors_["10014ui_story"]) and arg_288_1.var_.characterEffect10014ui_story then
				arg_288_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_288_1.var_.characterEffect10014ui_story.fillRatio = 0.5
			end

			local var_291_1 = arg_288_1.actors_["1084ui_story"]

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 and not isNil(var_291_1) and arg_288_1.var_.characterEffect1084ui_story == nil then
				arg_288_1.var_.characterEffect1084ui_story = var_291_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_291_2 = 0.200000002980232

			if 0 <= arg_288_1.time_ and arg_288_1.time_ < 0 + var_291_2 and not isNil(var_291_1) then
				if arg_288_1.var_.characterEffect1084ui_story and not isNil(var_291_1) then
					arg_288_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_288_1.time_ >= 0 + var_291_2 and arg_288_1.time_ < 0 + var_291_2 + arg_291_0 and not isNil(var_291_1) and arg_288_1.var_.characterEffect1084ui_story then
				arg_288_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_291_4 = arg_288_1.actors_["1084ui_story"].transform

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 then
				arg_288_1.var_.moveOldPos1084ui_story = var_291_4.localPosition
			end

			local var_291_5 = 0.001

			if 0 <= arg_288_1.time_ and arg_288_1.time_ < 0 + var_291_5 then
				var_291_4.localPosition = Vector3.Lerp(arg_288_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_288_1.time_ - 0) / var_291_5)
				var_291_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_291_4.position).x, (manager.ui.mainCamera.transform.position - var_291_4.position).y, (manager.ui.mainCamera.transform.position - var_291_4.position).z)
				var_291_4.localEulerAngles.z = 0
				var_291_4.localEulerAngles.x = 0
				var_291_4.localEulerAngles = var_291_4.localEulerAngles
			end

			if arg_288_1.time_ >= 0 + var_291_5 and arg_288_1.time_ < 0 + var_291_5 + arg_291_0 then
				var_291_4.localPosition = Vector3.New(0.7, -0.97, -6)
				var_291_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_291_4.position).x, (manager.ui.mainCamera.transform.position - var_291_4.position).y, (manager.ui.mainCamera.transform.position - var_291_4.position).z)
				var_291_4.localEulerAngles.z = 0
				var_291_4.localEulerAngles.x = 0
				var_291_4.localEulerAngles = var_291_4.localEulerAngles
			end

			local var_291_6 = arg_288_1.actors_["10014ui_story"].transform

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 then
				arg_288_1.var_.moveOldPos10014ui_story = var_291_6.localPosition
			end

			local var_291_7 = 0.001

			if 0 <= arg_288_1.time_ and arg_288_1.time_ < 0 + var_291_7 then
				var_291_6.localPosition = Vector3.Lerp(arg_288_1.var_.moveOldPos10014ui_story, Vector3.New(-0.7, -1.06, -6.2), (arg_288_1.time_ - 0) / var_291_7)
				var_291_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_291_6.position).x, (manager.ui.mainCamera.transform.position - var_291_6.position).y, (manager.ui.mainCamera.transform.position - var_291_6.position).z)
				var_291_6.localEulerAngles.z = 0
				var_291_6.localEulerAngles.x = 0
				var_291_6.localEulerAngles = var_291_6.localEulerAngles
			end

			if arg_288_1.time_ >= 0 + var_291_7 and arg_288_1.time_ < 0 + var_291_7 + arg_291_0 then
				var_291_6.localPosition = Vector3.New(-0.7, -1.06, -6.2)
				var_291_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_291_6.position).x, (manager.ui.mainCamera.transform.position - var_291_6.position).y, (manager.ui.mainCamera.transform.position - var_291_6.position).z)
				var_291_6.localEulerAngles.z = 0
				var_291_6.localEulerAngles.x = 0
				var_291_6.localEulerAngles = var_291_6.localEulerAngles
			end

			local var_291_8 = 0
			local var_291_9 = 0.425

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= var_291_8 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0
				arg_288_1.dialogCg_.alpha = 1

				arg_288_1.dialog_:SetActive(true)
				SetActive(arg_288_1.leftNameGo_, true)

				arg_288_1.leftNameTxt_.text = arg_288_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_288_1.leftNameTxt_.transform)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1.leftNameTxt_.text)
				SetActive(arg_288_1.iconTrs_.gameObject, false)
				arg_288_1.callingController_:SetSelectedState("normal")

				local var_291_10 = arg_288_1:GetWordFromCfg(319671068)
				local var_291_11 = arg_288_1:FormatText(var_291_10.content)

				arg_288_1.text_.text = var_291_11

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_13 = 17 <= 0 and var_291_9 or var_291_9 * (utf8.len(var_291_11) / 17)

				if (17 <= 0 and var_291_9 or var_291_9 * (utf8.len(var_291_11) / 17)) > 0 and var_291_9 < var_291_13 then
					arg_288_1.talkMaxDuration = var_291_13

					if var_291_13 + var_291_8 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_13 + var_291_8
					end
				end

				arg_288_1.text_.text = var_291_11
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671068", "story_v_out_319671.awb") ~= 0 then
					local var_291_14 = manager.audio:GetVoiceLength("story_v_out_319671", "319671068", "story_v_out_319671.awb") / 1000

					if var_291_14 + var_291_8 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_14 + var_291_8
					end

					if var_291_10.prefab_name ~= "" and arg_288_1.actors_[var_291_10.prefab_name] ~= nil then
						local var_291_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_288_1.actors_[var_291_10.prefab_name].transform, "story_v_out_319671", "319671068", "story_v_out_319671.awb")

						arg_288_1:RecordAudio("319671068", var_291_15)
						arg_288_1:RecordAudio("319671068", var_291_15)
					else
						arg_288_1:AudioAction("play", "voice", "story_v_out_319671", "319671068", "story_v_out_319671.awb")
					end

					arg_288_1:RecordHistoryTalkVoice("story_v_out_319671", "319671068", "story_v_out_319671.awb")
				end

				arg_288_1:RecordContent(arg_288_1.text_.text)
			end

			local var_291_16 = math.max(var_291_9, arg_288_1.talkMaxDuration)

			if var_291_8 <= arg_288_1.time_ and arg_288_1.time_ < var_291_8 + var_291_16 then
				arg_288_1.typewritter.percent = (arg_288_1.time_ - var_291_8) / var_291_16

				arg_288_1.typewritter:SetDirty()
			end

			if arg_288_1.time_ >= var_291_8 + var_291_16 and arg_288_1.time_ < var_291_8 + var_291_16 + arg_291_0 then
				arg_288_1.typewritter.percent = 1

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(true)
			end
		end

		arg_288_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_288_1:InitPlayNodeList()
	end,
	Play319671069 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 319671069
		arg_292_1.duration_ = 14.17

		local var_292_0 = {
			zh = 8,
			ja = 14.166
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
				arg_292_0:Play319671070(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 then
				arg_292_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_1")
			end

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 then
				arg_292_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_295_0 = 0
			local var_295_1 = 1.075

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= var_295_0 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0
				arg_292_1.dialogCg_.alpha = 1

				arg_292_1.dialog_:SetActive(true)
				SetActive(arg_292_1.leftNameGo_, true)

				arg_292_1.leftNameTxt_.text = arg_292_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_292_1.leftNameTxt_.transform)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1.leftNameTxt_.text)
				SetActive(arg_292_1.iconTrs_.gameObject, false)
				arg_292_1.callingController_:SetSelectedState("normal")

				local var_295_2 = arg_292_1:GetWordFromCfg(319671069)
				local var_295_3 = arg_292_1:FormatText(var_295_2.content)

				arg_292_1.text_.text = var_295_3

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_5 = 43 <= 0 and var_295_1 or var_295_1 * (utf8.len(var_295_3) / 43)

				if (43 <= 0 and var_295_1 or var_295_1 * (utf8.len(var_295_3) / 43)) > 0 and var_295_1 < var_295_5 then
					arg_292_1.talkMaxDuration = var_295_5

					if var_295_5 + var_295_0 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_5 + var_295_0
					end
				end

				arg_292_1.text_.text = var_295_3
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671069", "story_v_out_319671.awb") ~= 0 then
					local var_295_6 = manager.audio:GetVoiceLength("story_v_out_319671", "319671069", "story_v_out_319671.awb") / 1000

					if var_295_6 + var_295_0 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_6 + var_295_0
					end

					if var_295_2.prefab_name ~= "" and arg_292_1.actors_[var_295_2.prefab_name] ~= nil then
						local var_295_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_292_1.actors_[var_295_2.prefab_name].transform, "story_v_out_319671", "319671069", "story_v_out_319671.awb")

						arg_292_1:RecordAudio("319671069", var_295_7)
						arg_292_1:RecordAudio("319671069", var_295_7)
					else
						arg_292_1:AudioAction("play", "voice", "story_v_out_319671", "319671069", "story_v_out_319671.awb")
					end

					arg_292_1:RecordHistoryTalkVoice("story_v_out_319671", "319671069", "story_v_out_319671.awb")
				end

				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_8 = math.max(var_295_1, arg_292_1.talkMaxDuration)

			if var_295_0 <= arg_292_1.time_ and arg_292_1.time_ < var_295_0 + var_295_8 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - var_295_0) / var_295_8

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= var_295_0 + var_295_8 and arg_292_1.time_ < var_295_0 + var_295_8 + arg_295_0 then
				arg_292_1.typewritter.percent = 1

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(true)
			end
		end

		arg_292_1.nodeConfigList_ = {}

		arg_292_1:InitPlayNodeList()
	end,
	Play319671070 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 319671070
		arg_296_1.duration_ = 9.4

		local var_296_0 = {
			zh = 6.833,
			ja = 9.4
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
				arg_296_0:Play319671071(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 and not isNil(arg_296_1.actors_["1084ui_story"]) and arg_296_1.var_.characterEffect1084ui_story == nil then
				arg_296_1.var_.characterEffect1084ui_story = arg_296_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_299_0 = 0.200000002980232

			if 0 <= arg_296_1.time_ and arg_296_1.time_ < 0 + var_299_0 and not isNil(arg_296_1.actors_["1084ui_story"]) then
				if arg_296_1.var_.characterEffect1084ui_story and not isNil(arg_296_1.actors_["1084ui_story"]) then
					arg_296_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_296_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_296_1.time_ - 0) / var_299_0)
				end
			end

			if arg_296_1.time_ >= 0 + var_299_0 and arg_296_1.time_ < 0 + var_299_0 + arg_299_0 and not isNil(arg_296_1.actors_["1084ui_story"]) and arg_296_1.var_.characterEffect1084ui_story then
				arg_296_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_296_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_299_1 = arg_296_1.actors_["10014ui_story"]

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 and not isNil(var_299_1) and arg_296_1.var_.characterEffect10014ui_story == nil then
				arg_296_1.var_.characterEffect10014ui_story = var_299_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_299_2 = 0.200000002980232

			if 0 <= arg_296_1.time_ and arg_296_1.time_ < 0 + var_299_2 and not isNil(var_299_1) then
				if arg_296_1.var_.characterEffect10014ui_story and not isNil(var_299_1) then
					arg_296_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_296_1.time_ >= 0 + var_299_2 and arg_296_1.time_ < 0 + var_299_2 + arg_299_0 and not isNil(var_299_1) and arg_296_1.var_.characterEffect10014ui_story then
				arg_296_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 then
				arg_296_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action3_2")
			end

			local var_299_4 = 0
			local var_299_5 = 0.675

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= var_299_4 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0
				arg_296_1.dialogCg_.alpha = 1

				arg_296_1.dialog_:SetActive(true)
				SetActive(arg_296_1.leftNameGo_, true)

				arg_296_1.leftNameTxt_.text = arg_296_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_296_1.leftNameTxt_.transform)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1.leftNameTxt_.text)
				SetActive(arg_296_1.iconTrs_.gameObject, false)
				arg_296_1.callingController_:SetSelectedState("normal")

				local var_299_6 = arg_296_1:GetWordFromCfg(319671070)
				local var_299_7 = arg_296_1:FormatText(var_299_6.content)

				arg_296_1.text_.text = var_299_7

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_9 = 27 <= 0 and var_299_5 or var_299_5 * (utf8.len(var_299_7) / 27)

				if (27 <= 0 and var_299_5 or var_299_5 * (utf8.len(var_299_7) / 27)) > 0 and var_299_5 < var_299_9 then
					arg_296_1.talkMaxDuration = var_299_9

					if var_299_9 + var_299_4 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_9 + var_299_4
					end
				end

				arg_296_1.text_.text = var_299_7
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671070", "story_v_out_319671.awb") ~= 0 then
					local var_299_10 = manager.audio:GetVoiceLength("story_v_out_319671", "319671070", "story_v_out_319671.awb") / 1000

					if var_299_10 + var_299_4 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_10 + var_299_4
					end

					if var_299_6.prefab_name ~= "" and arg_296_1.actors_[var_299_6.prefab_name] ~= nil then
						local var_299_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_296_1.actors_[var_299_6.prefab_name].transform, "story_v_out_319671", "319671070", "story_v_out_319671.awb")

						arg_296_1:RecordAudio("319671070", var_299_11)
						arg_296_1:RecordAudio("319671070", var_299_11)
					else
						arg_296_1:AudioAction("play", "voice", "story_v_out_319671", "319671070", "story_v_out_319671.awb")
					end

					arg_296_1:RecordHistoryTalkVoice("story_v_out_319671", "319671070", "story_v_out_319671.awb")
				end

				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_12 = math.max(var_299_5, arg_296_1.talkMaxDuration)

			if var_299_4 <= arg_296_1.time_ and arg_296_1.time_ < var_299_4 + var_299_12 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - var_299_4) / var_299_12

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= var_299_4 + var_299_12 and arg_296_1.time_ < var_299_4 + var_299_12 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {}

		arg_296_1:InitPlayNodeList()
	end,
	Play319671071 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 319671071
		arg_300_1.duration_ = 2.7

		local var_300_0 = {
			zh = 2.1,
			ja = 2.7
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
				arg_300_0:Play319671072(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 then
				arg_300_1.var_.moveOldPos1084ui_story = arg_300_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_303_0 = 0.001

			if 0 <= arg_300_1.time_ and arg_300_1.time_ < 0 + var_303_0 then
				arg_300_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_300_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_300_1.time_ - 0) / var_303_0)
				arg_300_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_300_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_300_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_300_1.actors_["1084ui_story"].transform.position).z)
				arg_300_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_300_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_300_1.actors_["1084ui_story"].transform.localEulerAngles = arg_300_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_300_1.time_ >= 0 + var_303_0 and arg_300_1.time_ < 0 + var_303_0 + arg_303_0 then
				arg_300_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0.7, -0.97, -6)
				arg_300_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_300_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_300_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_300_1.actors_["1084ui_story"].transform.position).z)
				arg_300_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_300_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_300_1.actors_["1084ui_story"].transform.localEulerAngles = arg_300_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_303_1 = arg_300_1.actors_["1084ui_story"]

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 and not isNil(var_303_1) and arg_300_1.var_.characterEffect1084ui_story == nil then
				arg_300_1.var_.characterEffect1084ui_story = var_303_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_303_2 = 0.200000002980232

			if 0 <= arg_300_1.time_ and arg_300_1.time_ < 0 + var_303_2 and not isNil(var_303_1) then
				if arg_300_1.var_.characterEffect1084ui_story and not isNil(var_303_1) then
					arg_300_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_300_1.time_ >= 0 + var_303_2 and arg_300_1.time_ < 0 + var_303_2 + arg_303_0 and not isNil(var_303_1) and arg_300_1.var_.characterEffect1084ui_story then
				arg_300_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 then
				arg_300_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_2")
			end

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 then
				arg_300_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_303_4 = arg_300_1.actors_["10014ui_story"]

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 and not isNil(var_303_4) and arg_300_1.var_.characterEffect10014ui_story == nil then
				arg_300_1.var_.characterEffect10014ui_story = var_303_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_303_5 = 0.200000002980232

			if 0 <= arg_300_1.time_ and arg_300_1.time_ < 0 + var_303_5 and not isNil(var_303_4) then
				if arg_300_1.var_.characterEffect10014ui_story and not isNil(var_303_4) then
					arg_300_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_300_1.var_.characterEffect10014ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_300_1.time_ - 0) / var_303_5)
				end
			end

			if arg_300_1.time_ >= 0 + var_303_5 and arg_300_1.time_ < 0 + var_303_5 + arg_303_0 and not isNil(var_303_4) and arg_300_1.var_.characterEffect10014ui_story then
				arg_300_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_300_1.var_.characterEffect10014ui_story.fillRatio = 0.5
			end

			local var_303_6 = 0
			local var_303_7 = 0.2

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= var_303_6 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0
				arg_300_1.dialogCg_.alpha = 1

				arg_300_1.dialog_:SetActive(true)
				SetActive(arg_300_1.leftNameGo_, true)

				arg_300_1.leftNameTxt_.text = arg_300_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_300_1.leftNameTxt_.transform)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1.leftNameTxt_.text)
				SetActive(arg_300_1.iconTrs_.gameObject, false)
				arg_300_1.callingController_:SetSelectedState("normal")

				local var_303_8 = arg_300_1:GetWordFromCfg(319671071)
				local var_303_9 = arg_300_1:FormatText(var_303_8.content)

				arg_300_1.text_.text = var_303_9

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_11 = 8 <= 0 and var_303_7 or var_303_7 * (utf8.len(var_303_9) / 8)

				if (8 <= 0 and var_303_7 or var_303_7 * (utf8.len(var_303_9) / 8)) > 0 and var_303_7 < var_303_11 then
					arg_300_1.talkMaxDuration = var_303_11

					if var_303_11 + var_303_6 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_11 + var_303_6
					end
				end

				arg_300_1.text_.text = var_303_9
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671071", "story_v_out_319671.awb") ~= 0 then
					local var_303_12 = manager.audio:GetVoiceLength("story_v_out_319671", "319671071", "story_v_out_319671.awb") / 1000

					if var_303_12 + var_303_6 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_12 + var_303_6
					end

					if var_303_8.prefab_name ~= "" and arg_300_1.actors_[var_303_8.prefab_name] ~= nil then
						local var_303_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_300_1.actors_[var_303_8.prefab_name].transform, "story_v_out_319671", "319671071", "story_v_out_319671.awb")

						arg_300_1:RecordAudio("319671071", var_303_13)
						arg_300_1:RecordAudio("319671071", var_303_13)
					else
						arg_300_1:AudioAction("play", "voice", "story_v_out_319671", "319671071", "story_v_out_319671.awb")
					end

					arg_300_1:RecordHistoryTalkVoice("story_v_out_319671", "319671071", "story_v_out_319671.awb")
				end

				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_14 = math.max(var_303_7, arg_300_1.talkMaxDuration)

			if var_303_6 <= arg_300_1.time_ and arg_300_1.time_ < var_303_6 + var_303_14 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - var_303_6) / var_303_14

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= var_303_6 + var_303_14 and arg_300_1.time_ < var_303_6 + var_303_14 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {
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

		arg_300_1:InitPlayNodeList()
	end,
	Play319671072 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 319671072
		arg_304_1.duration_ = 2.6

		local var_304_0 = {
			zh = 2.3,
			ja = 2.6
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
				arg_304_0:Play319671073(arg_304_1)
			end
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			if 0 < arg_304_1.time_ and arg_304_1.time_ <= 0 + arg_307_0 and not isNil(arg_304_1.actors_["1084ui_story"]) and arg_304_1.var_.characterEffect1084ui_story == nil then
				arg_304_1.var_.characterEffect1084ui_story = arg_304_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_307_0 = 0.200000002980232

			if 0 <= arg_304_1.time_ and arg_304_1.time_ < 0 + var_307_0 and not isNil(arg_304_1.actors_["1084ui_story"]) then
				if arg_304_1.var_.characterEffect1084ui_story and not isNil(arg_304_1.actors_["1084ui_story"]) then
					arg_304_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_304_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_304_1.time_ - 0) / var_307_0)
				end
			end

			if arg_304_1.time_ >= 0 + var_307_0 and arg_304_1.time_ < 0 + var_307_0 + arg_307_0 and not isNil(arg_304_1.actors_["1084ui_story"]) and arg_304_1.var_.characterEffect1084ui_story then
				arg_304_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_304_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_307_1 = 0
			local var_307_2 = 0.175

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= var_307_1 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0
				arg_304_1.dialogCg_.alpha = 1

				arg_304_1.dialog_:SetActive(true)
				SetActive(arg_304_1.leftNameGo_, true)

				arg_304_1.leftNameTxt_.text = arg_304_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_304_1.leftNameTxt_.transform)

				arg_304_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_304_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_304_1:RecordName(arg_304_1.leftNameTxt_.text)
				SetActive(arg_304_1.iconTrs_.gameObject, false)
				arg_304_1.callingController_:SetSelectedState("normal")

				local var_307_3 = arg_304_1:GetWordFromCfg(319671072)
				local var_307_4 = arg_304_1:FormatText(var_307_3.content)

				arg_304_1.text_.text = var_307_4

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_6 = 7 <= 0 and var_307_2 or var_307_2 * (utf8.len(var_307_4) / 7)

				if (7 <= 0 and var_307_2 or var_307_2 * (utf8.len(var_307_4) / 7)) > 0 and var_307_2 < var_307_6 then
					arg_304_1.talkMaxDuration = var_307_6

					if var_307_6 + var_307_1 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_6 + var_307_1
					end
				end

				arg_304_1.text_.text = var_307_4
				arg_304_1.typewritter.percent = 0

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671072", "story_v_out_319671.awb") ~= 0 then
					local var_307_7 = manager.audio:GetVoiceLength("story_v_out_319671", "319671072", "story_v_out_319671.awb") / 1000

					if var_307_7 + var_307_1 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_7 + var_307_1
					end

					if var_307_3.prefab_name ~= "" and arg_304_1.actors_[var_307_3.prefab_name] ~= nil then
						local var_307_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_304_1.actors_[var_307_3.prefab_name].transform, "story_v_out_319671", "319671072", "story_v_out_319671.awb")

						arg_304_1:RecordAudio("319671072", var_307_8)
						arg_304_1:RecordAudio("319671072", var_307_8)
					else
						arg_304_1:AudioAction("play", "voice", "story_v_out_319671", "319671072", "story_v_out_319671.awb")
					end

					arg_304_1:RecordHistoryTalkVoice("story_v_out_319671", "319671072", "story_v_out_319671.awb")
				end

				arg_304_1:RecordContent(arg_304_1.text_.text)
			end

			local var_307_9 = math.max(var_307_2, arg_304_1.talkMaxDuration)

			if var_307_1 <= arg_304_1.time_ and arg_304_1.time_ < var_307_1 + var_307_9 then
				arg_304_1.typewritter.percent = (arg_304_1.time_ - var_307_1) / var_307_9

				arg_304_1.typewritter:SetDirty()
			end

			if arg_304_1.time_ >= var_307_1 + var_307_9 and arg_304_1.time_ < var_307_1 + var_307_9 + arg_307_0 then
				arg_304_1.typewritter.percent = 1

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(true)
			end
		end

		arg_304_1.nodeConfigList_ = {}

		arg_304_1:InitPlayNodeList()
	end,
	Play319671073 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 319671073
		arg_308_1.duration_ = 5

		SetActive(arg_308_1.tipsGo_, false)

		function arg_308_1.onSingleLineFinish_()
			arg_308_1.onSingleLineUpdate_ = nil
			arg_308_1.onSingleLineFinish_ = nil
			arg_308_1.state_ = "waiting"
		end

		function arg_308_1.playNext_(arg_310_0)
			if arg_310_0 == 1 then
				arg_308_0:Play319671074(arg_308_1)
			end
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 then
				arg_308_1.var_.moveOldPos10014ui_story = arg_308_1.actors_["10014ui_story"].transform.localPosition
			end

			local var_311_0 = 0.001

			if 0 <= arg_308_1.time_ and arg_308_1.time_ < 0 + var_311_0 then
				arg_308_1.actors_["10014ui_story"].transform.localPosition = Vector3.Lerp(arg_308_1.var_.moveOldPos10014ui_story, Vector3.New(0, 100, 0), (arg_308_1.time_ - 0) / var_311_0)
				arg_308_1.actors_["10014ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_308_1.actors_["10014ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_308_1.actors_["10014ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_308_1.actors_["10014ui_story"].transform.position).z)
				arg_308_1.actors_["10014ui_story"].transform.localEulerAngles.z = 0
				arg_308_1.actors_["10014ui_story"].transform.localEulerAngles.x = 0
				arg_308_1.actors_["10014ui_story"].transform.localEulerAngles = arg_308_1.actors_["10014ui_story"].transform.localEulerAngles
			end

			if arg_308_1.time_ >= 0 + var_311_0 and arg_308_1.time_ < 0 + var_311_0 + arg_311_0 then
				arg_308_1.actors_["10014ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_308_1.actors_["10014ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_308_1.actors_["10014ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_308_1.actors_["10014ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_308_1.actors_["10014ui_story"].transform.position).z)
				arg_308_1.actors_["10014ui_story"].transform.localEulerAngles.z = 0
				arg_308_1.actors_["10014ui_story"].transform.localEulerAngles.x = 0
				arg_308_1.actors_["10014ui_story"].transform.localEulerAngles = arg_308_1.actors_["10014ui_story"].transform.localEulerAngles
			end

			local var_311_1 = arg_308_1.actors_["10014ui_story"]

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 and not isNil(var_311_1) and arg_308_1.var_.characterEffect10014ui_story == nil then
				arg_308_1.var_.characterEffect10014ui_story = var_311_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_311_2 = 0.200000002980232

			if 0 <= arg_308_1.time_ and arg_308_1.time_ < 0 + var_311_2 and not isNil(var_311_1) then
				if arg_308_1.var_.characterEffect10014ui_story and not isNil(var_311_1) then
					arg_308_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_308_1.var_.characterEffect10014ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_308_1.time_ - 0) / var_311_2)
				end
			end

			if arg_308_1.time_ >= 0 + var_311_2 and arg_308_1.time_ < 0 + var_311_2 + arg_311_0 and not isNil(var_311_1) and arg_308_1.var_.characterEffect10014ui_story then
				arg_308_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_308_1.var_.characterEffect10014ui_story.fillRatio = 0.5
			end

			local var_311_3 = arg_308_1.actors_["1084ui_story"].transform

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 then
				arg_308_1.var_.moveOldPos1084ui_story = var_311_3.localPosition
			end

			local var_311_4 = 0.001

			if 0 <= arg_308_1.time_ and arg_308_1.time_ < 0 + var_311_4 then
				var_311_3.localPosition = Vector3.Lerp(arg_308_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_308_1.time_ - 0) / var_311_4)
				var_311_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_311_3.position).x, (manager.ui.mainCamera.transform.position - var_311_3.position).y, (manager.ui.mainCamera.transform.position - var_311_3.position).z)
				var_311_3.localEulerAngles.z = 0
				var_311_3.localEulerAngles.x = 0
				var_311_3.localEulerAngles = var_311_3.localEulerAngles
			end

			if arg_308_1.time_ >= 0 + var_311_4 and arg_308_1.time_ < 0 + var_311_4 + arg_311_0 then
				var_311_3.localPosition = Vector3.New(0, 100, 0)
				var_311_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_311_3.position).x, (manager.ui.mainCamera.transform.position - var_311_3.position).y, (manager.ui.mainCamera.transform.position - var_311_3.position).z)
				var_311_3.localEulerAngles.z = 0
				var_311_3.localEulerAngles.x = 0
				var_311_3.localEulerAngles = var_311_3.localEulerAngles
			end

			local var_311_5 = arg_308_1.actors_["1084ui_story"]

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 and not isNil(var_311_5) and arg_308_1.var_.characterEffect1084ui_story == nil then
				arg_308_1.var_.characterEffect1084ui_story = var_311_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_311_6 = 0.200000002980232

			if 0 <= arg_308_1.time_ and arg_308_1.time_ < 0 + var_311_6 and not isNil(var_311_5) then
				if arg_308_1.var_.characterEffect1084ui_story and not isNil(var_311_5) then
					arg_308_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_308_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_308_1.time_ - 0) / var_311_6)
				end
			end

			if arg_308_1.time_ >= 0 + var_311_6 and arg_308_1.time_ < 0 + var_311_6 + arg_311_0 and not isNil(var_311_5) and arg_308_1.var_.characterEffect1084ui_story then
				arg_308_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_308_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 then
				if arg_308_1.var_.characterEffect10014ui_story == nil then
					arg_308_1.var_.characterEffect10014ui_story = arg_308_1.actors_["10014ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_311_7 = arg_308_1.var_.characterEffect10014ui_story

				arg_308_1.var_.characterEffect10014ui_story.imageEffect:turnOff()

				var_311_7.interferenceEffect.enabled = false
				var_311_7.interferenceEffect.noise = 0.001
				var_311_7.interferenceEffect.simTimeScale = 1
				var_311_7.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 then
				if arg_308_1.var_.characterEffect10014ui_story == nil then
					arg_308_1.var_.characterEffect10014ui_story = arg_308_1.actors_["10014ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_308_1.var_.characterEffect10014ui_story.imageEffect:turnOff()
			end

			local var_311_9 = 0
			local var_311_10 = 0.65

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= var_311_9 + arg_311_0 then
				arg_308_1.talkMaxDuration = 0
				arg_308_1.dialogCg_.alpha = 1

				arg_308_1.dialog_:SetActive(true)
				SetActive(arg_308_1.leftNameGo_, false)

				arg_308_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_308_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_308_1:RecordName(arg_308_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_308_1.iconTrs_.gameObject, false)
				arg_308_1.callingController_:SetSelectedState("normal")

				local var_311_11 = arg_308_1:FormatText(arg_308_1:GetWordFromCfg(319671073).content)

				arg_308_1.text_.text = var_311_11

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_13 = 26 <= 0 and var_311_10 or var_311_10 * (utf8.len(var_311_11) / 26)

				if (26 <= 0 and var_311_10 or var_311_10 * (utf8.len(var_311_11) / 26)) > 0 and var_311_10 < var_311_13 then
					arg_308_1.talkMaxDuration = var_311_13

					if var_311_13 + var_311_9 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_13 + var_311_9
					end
				end

				arg_308_1.text_.text = var_311_11
				arg_308_1.typewritter.percent = 0

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(false)
				arg_308_1:RecordContent(arg_308_1.text_.text)
			end

			local var_311_14 = math.max(var_311_10, arg_308_1.talkMaxDuration)

			if var_311_9 <= arg_308_1.time_ and arg_308_1.time_ < var_311_9 + var_311_14 then
				arg_308_1.typewritter.percent = (arg_308_1.time_ - var_311_9) / var_311_14

				arg_308_1.typewritter:SetDirty()
			end

			if arg_308_1.time_ >= var_311_9 + var_311_14 and arg_308_1.time_ < var_311_9 + var_311_14 + arg_311_0 then
				arg_308_1.typewritter.percent = 1

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(true)
			end
		end

		arg_308_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_308_1:InitPlayNodeList()
	end,
	Play319671074 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 319671074
		arg_312_1.duration_ = 5

		SetActive(arg_312_1.tipsGo_, false)

		function arg_312_1.onSingleLineFinish_()
			arg_312_1.onSingleLineUpdate_ = nil
			arg_312_1.onSingleLineFinish_ = nil
			arg_312_1.state_ = "waiting"
		end

		function arg_312_1.playNext_(arg_314_0)
			if arg_314_0 == 1 then
				arg_312_0:Play319671075(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 then
				arg_312_1.var_.moveOldPos10014ui_story = arg_312_1.actors_["10014ui_story"].transform.localPosition
			end

			local var_315_0 = 0.001

			if 0 <= arg_312_1.time_ and arg_312_1.time_ < 0 + var_315_0 then
				arg_312_1.actors_["10014ui_story"].transform.localPosition = Vector3.Lerp(arg_312_1.var_.moveOldPos10014ui_story, Vector3.New(0, 100, 0), (arg_312_1.time_ - 0) / var_315_0)
				arg_312_1.actors_["10014ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_312_1.actors_["10014ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_312_1.actors_["10014ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_312_1.actors_["10014ui_story"].transform.position).z)
				arg_312_1.actors_["10014ui_story"].transform.localEulerAngles.z = 0
				arg_312_1.actors_["10014ui_story"].transform.localEulerAngles.x = 0
				arg_312_1.actors_["10014ui_story"].transform.localEulerAngles = arg_312_1.actors_["10014ui_story"].transform.localEulerAngles
			end

			if arg_312_1.time_ >= 0 + var_315_0 and arg_312_1.time_ < 0 + var_315_0 + arg_315_0 then
				arg_312_1.actors_["10014ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_312_1.actors_["10014ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_312_1.actors_["10014ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_312_1.actors_["10014ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_312_1.actors_["10014ui_story"].transform.position).z)
				arg_312_1.actors_["10014ui_story"].transform.localEulerAngles.z = 0
				arg_312_1.actors_["10014ui_story"].transform.localEulerAngles.x = 0
				arg_312_1.actors_["10014ui_story"].transform.localEulerAngles = arg_312_1.actors_["10014ui_story"].transform.localEulerAngles
			end

			local var_315_1 = arg_312_1.actors_["10014ui_story"]

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 and not isNil(var_315_1) and arg_312_1.var_.characterEffect10014ui_story == nil then
				arg_312_1.var_.characterEffect10014ui_story = var_315_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_315_2 = 0.200000002980232

			if 0 <= arg_312_1.time_ and arg_312_1.time_ < 0 + var_315_2 and not isNil(var_315_1) then
				if arg_312_1.var_.characterEffect10014ui_story and not isNil(var_315_1) then
					arg_312_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_312_1.var_.characterEffect10014ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_312_1.time_ - 0) / var_315_2)
				end
			end

			if arg_312_1.time_ >= 0 + var_315_2 and arg_312_1.time_ < 0 + var_315_2 + arg_315_0 and not isNil(var_315_1) and arg_312_1.var_.characterEffect10014ui_story then
				arg_312_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_312_1.var_.characterEffect10014ui_story.fillRatio = 0.5
			end

			local var_315_3 = arg_312_1.actors_["1084ui_story"].transform

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 then
				arg_312_1.var_.moveOldPos1084ui_story = var_315_3.localPosition
			end

			local var_315_4 = 0.001

			if 0 <= arg_312_1.time_ and arg_312_1.time_ < 0 + var_315_4 then
				var_315_3.localPosition = Vector3.Lerp(arg_312_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_312_1.time_ - 0) / var_315_4)
				var_315_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_315_3.position).x, (manager.ui.mainCamera.transform.position - var_315_3.position).y, (manager.ui.mainCamera.transform.position - var_315_3.position).z)
				var_315_3.localEulerAngles.z = 0
				var_315_3.localEulerAngles.x = 0
				var_315_3.localEulerAngles = var_315_3.localEulerAngles
			end

			if arg_312_1.time_ >= 0 + var_315_4 and arg_312_1.time_ < 0 + var_315_4 + arg_315_0 then
				var_315_3.localPosition = Vector3.New(0, 100, 0)
				var_315_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_315_3.position).x, (manager.ui.mainCamera.transform.position - var_315_3.position).y, (manager.ui.mainCamera.transform.position - var_315_3.position).z)
				var_315_3.localEulerAngles.z = 0
				var_315_3.localEulerAngles.x = 0
				var_315_3.localEulerAngles = var_315_3.localEulerAngles
			end

			local var_315_5 = arg_312_1.actors_["1084ui_story"]

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 and not isNil(var_315_5) and arg_312_1.var_.characterEffect1084ui_story == nil then
				arg_312_1.var_.characterEffect1084ui_story = var_315_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_315_6 = 0.200000002980232

			if 0 <= arg_312_1.time_ and arg_312_1.time_ < 0 + var_315_6 and not isNil(var_315_5) then
				if arg_312_1.var_.characterEffect1084ui_story and not isNil(var_315_5) then
					arg_312_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_312_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_312_1.time_ - 0) / var_315_6)
				end
			end

			if arg_312_1.time_ >= 0 + var_315_6 and arg_312_1.time_ < 0 + var_315_6 + arg_315_0 and not isNil(var_315_5) and arg_312_1.var_.characterEffect1084ui_story then
				arg_312_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_312_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_315_7 = 0
			local var_315_8 = 1.025

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= var_315_7 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0
				arg_312_1.dialogCg_.alpha = 1

				arg_312_1.dialog_:SetActive(true)
				SetActive(arg_312_1.leftNameGo_, false)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_312_1.iconTrs_.gameObject, false)
				arg_312_1.callingController_:SetSelectedState("normal")

				local var_315_9 = arg_312_1:FormatText(arg_312_1:GetWordFromCfg(319671074).content)

				arg_312_1.text_.text = var_315_9

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_11 = 41 <= 0 and var_315_8 or var_315_8 * (utf8.len(var_315_9) / 41)

				if (41 <= 0 and var_315_8 or var_315_8 * (utf8.len(var_315_9) / 41)) > 0 and var_315_8 < var_315_11 then
					arg_312_1.talkMaxDuration = var_315_11

					if var_315_11 + var_315_7 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_11 + var_315_7
					end
				end

				arg_312_1.text_.text = var_315_9
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)
				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_12 = math.max(var_315_8, arg_312_1.talkMaxDuration)

			if var_315_7 <= arg_312_1.time_ and arg_312_1.time_ < var_315_7 + var_315_12 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - var_315_7) / var_315_12

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= var_315_7 + var_315_12 and arg_312_1.time_ < var_315_7 + var_315_12 + arg_315_0 then
				arg_312_1.typewritter.percent = 1

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(true)
			end
		end

		arg_312_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_312_1:InitPlayNodeList()
	end,
	Play319671075 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 319671075
		arg_316_1.duration_ = 5.8

		local var_316_0 = {
			zh = 4.966,
			ja = 5.8
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
			arg_316_1.auto_ = false
		end

		function arg_316_1.playNext_(arg_318_0)
			arg_316_1.onStoryFinished_()
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			if arg_316_1.actors_["4040ui_story"] == nil and not isNil((Asset.Load("Char/" .. "4040ui_story"))) then
				local var_319_0 = Object.Instantiate(Asset.Load("Char/" .. "4040ui_story"), arg_316_1.stage_.transform)

				var_319_0.name = "4040ui_story"
				var_319_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_316_1.actors_["4040ui_story"] = var_319_0

				local var_319_1 = var_319_0:GetComponentInChildren(typeof(CharacterEffect))

				var_319_1.enabled = true

				local var_319_2 = GameObjectTools.GetOrAddComponent(var_319_0, typeof(DynamicBoneHelper))

				if var_319_2 then
					var_319_2:EnableDynamicBone(false)
				end

				arg_316_1:ShowWeapon(var_319_1.transform, false)

				arg_316_1.var_["4040ui_story" .. "Animator"] = var_319_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_316_1.var_["4040ui_story" .. "Animator"].applyRootMotion = true
				arg_316_1.var_["4040ui_story" .. "LipSync"] = var_319_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_319_3 = arg_316_1.actors_["4040ui_story"].transform

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= 0 + arg_319_0 then
				arg_316_1.var_.moveOldPos4040ui_story = var_319_3.localPosition
			end

			local var_319_4 = 0.001

			if 0 <= arg_316_1.time_ and arg_316_1.time_ < 0 + var_319_4 then
				var_319_3.localPosition = Vector3.Lerp(arg_316_1.var_.moveOldPos4040ui_story, Vector3.New(0, -1.55, -5.5), (arg_316_1.time_ - 0) / var_319_4)
				var_319_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_319_3.position).x, (manager.ui.mainCamera.transform.position - var_319_3.position).y, (manager.ui.mainCamera.transform.position - var_319_3.position).z)
				var_319_3.localEulerAngles.z = 0
				var_319_3.localEulerAngles.x = 0
				var_319_3.localEulerAngles = var_319_3.localEulerAngles
			end

			if arg_316_1.time_ >= 0 + var_319_4 and arg_316_1.time_ < 0 + var_319_4 + arg_319_0 then
				var_319_3.localPosition = Vector3.New(0, -1.55, -5.5)
				var_319_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_319_3.position).x, (manager.ui.mainCamera.transform.position - var_319_3.position).y, (manager.ui.mainCamera.transform.position - var_319_3.position).z)
				var_319_3.localEulerAngles.z = 0
				var_319_3.localEulerAngles.x = 0
				var_319_3.localEulerAngles = var_319_3.localEulerAngles
			end

			local var_319_5 = arg_316_1.actors_["4040ui_story"]

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= 0 + arg_319_0 and not isNil(var_319_5) and arg_316_1.var_.characterEffect4040ui_story == nil then
				arg_316_1.var_.characterEffect4040ui_story = var_319_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_319_6 = 0.200000002980232

			if 0 <= arg_316_1.time_ and arg_316_1.time_ < 0 + var_319_6 and not isNil(var_319_5) then
				if arg_316_1.var_.characterEffect4040ui_story and not isNil(var_319_5) then
					arg_316_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_316_1.time_ >= 0 + var_319_6 and arg_316_1.time_ < 0 + var_319_6 + arg_319_0 and not isNil(var_319_5) and arg_316_1.var_.characterEffect4040ui_story then
				arg_316_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= 0 + arg_319_0 then
				arg_316_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action3_1")
			end

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= 0 + arg_319_0 then
				arg_316_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_319_8 = 0
			local var_319_9 = 0.525

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= var_319_8 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0
				arg_316_1.dialogCg_.alpha = 1

				arg_316_1.dialog_:SetActive(true)
				SetActive(arg_316_1.leftNameGo_, true)

				arg_316_1.leftNameTxt_.text = arg_316_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_316_1.leftNameTxt_.transform)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1.leftNameTxt_.text)
				SetActive(arg_316_1.iconTrs_.gameObject, false)
				arg_316_1.callingController_:SetSelectedState("normal")

				local var_319_10 = arg_316_1:GetWordFromCfg(319671075)
				local var_319_11 = arg_316_1:FormatText(var_319_10.content)

				arg_316_1.text_.text = var_319_11

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_13 = 21 <= 0 and var_319_9 or var_319_9 * (utf8.len(var_319_11) / 21)

				if (21 <= 0 and var_319_9 or var_319_9 * (utf8.len(var_319_11) / 21)) > 0 and var_319_9 < var_319_13 then
					arg_316_1.talkMaxDuration = var_319_13

					if var_319_13 + var_319_8 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_13 + var_319_8
					end
				end

				arg_316_1.text_.text = var_319_11
				arg_316_1.typewritter.percent = 0

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671075", "story_v_out_319671.awb") ~= 0 then
					local var_319_14 = manager.audio:GetVoiceLength("story_v_out_319671", "319671075", "story_v_out_319671.awb") / 1000

					if var_319_14 + var_319_8 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_14 + var_319_8
					end

					if var_319_10.prefab_name ~= "" and arg_316_1.actors_[var_319_10.prefab_name] ~= nil then
						local var_319_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_316_1.actors_[var_319_10.prefab_name].transform, "story_v_out_319671", "319671075", "story_v_out_319671.awb")

						arg_316_1:RecordAudio("319671075", var_319_15)
						arg_316_1:RecordAudio("319671075", var_319_15)
					else
						arg_316_1:AudioAction("play", "voice", "story_v_out_319671", "319671075", "story_v_out_319671.awb")
					end

					arg_316_1:RecordHistoryTalkVoice("story_v_out_319671", "319671075", "story_v_out_319671.awb")
				end

				arg_316_1:RecordContent(arg_316_1.text_.text)
			end

			local var_319_16 = math.max(var_319_9, arg_316_1.talkMaxDuration)

			if var_319_8 <= arg_316_1.time_ and arg_316_1.time_ < var_319_8 + var_319_16 then
				arg_316_1.typewritter.percent = (arg_316_1.time_ - var_319_8) / var_319_16

				arg_316_1.typewritter:SetDirty()
			end

			if arg_316_1.time_ >= var_319_8 + var_319_16 and arg_316_1.time_ < var_319_8 + var_319_16 + arg_319_0 then
				arg_316_1.typewritter.percent = 1

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(true)
			end
		end

		arg_316_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_316_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/I12g",
		"TextureConfig/Background/D10",
		"TextureConfig/Background/D11",
		"TextureConfig/Background/ST69"
	},
	voices = {
		"story_v_out_319671.awb"
	}
}
