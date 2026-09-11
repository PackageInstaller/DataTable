return {
	Play411241001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 411241001
		arg_1_1.duration_ = 4.8

		local var_1_0 = {
			zh = 3.8,
			ja = 4.8
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
				arg_1_0:Play411241002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ML0602 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ML0602")
				var_4_0.name = "ML0602"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ML0602 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ML0602

				arg_1_1.bgs_.ML0602.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ML0602" then
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

			if 0.466666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.466666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_1_6_story_story", "bgm_activity_1_6_story_story", "bgm_activity_1_6_story_story.awb")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= "" and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = ""

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = ""
						arg_1_1.bgmTxt2_.text = ""
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

			if 0.466666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.466666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_1_6_story_story", "dialog_init", "bgm_activity_1_6_story_story.awb")

				if MusicRecordCfg[95].musicName ~= "" then
					if arg_1_1.bgmTxt_.text ~= MusicRecordCfg[95].musicName and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = MusicRecordCfg[95].musicName

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = MusicRecordCfg[95].musicName
						arg_1_1.bgmTxt2_.text = MusicRecordCfg[95].musicName
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

			local var_4_14 = 2
			local var_4_15 = 0.275

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_14 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_16 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_16:setOnUpdate(LuaHelper.FloatAction(function(arg_8_0)
					arg_1_1.dialogCg_.alpha = arg_8_0
				end))
				var_4_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_17 = arg_1_1:GetWordFromCfg(411241001)
				local var_4_18 = arg_1_1:FormatText(var_4_17.content)

				arg_1_1.text_.text = var_4_18

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_20 = 11 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_18) / 11)

				if (11 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_18) / 11)) > 0 and var_4_15 < var_4_20 then
					arg_1_1.talkMaxDuration = var_4_20
					var_4_14 = var_4_14 + 0.3

					if var_4_20 + var_4_14 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_20 + var_4_14
					end
				end

				arg_1_1.text_.text = var_4_18
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411241", "411241001", "story_v_out_411241.awb") ~= 0 then
					local var_4_21 = manager.audio:GetVoiceLength("story_v_out_411241", "411241001", "story_v_out_411241.awb") / 1000

					if var_4_21 + var_4_14 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_21 + var_4_14
					end

					if var_4_17.prefab_name ~= "" and arg_1_1.actors_[var_4_17.prefab_name] ~= nil then
						local var_4_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_17.prefab_name].transform, "story_v_out_411241", "411241001", "story_v_out_411241.awb")

						arg_1_1:RecordAudio("411241001", var_4_22)
						arg_1_1:RecordAudio("411241001", var_4_22)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_411241", "411241001", "story_v_out_411241.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_411241", "411241001", "story_v_out_411241.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_23 = var_4_14 + 0.3
			local var_4_24 = math.max(var_4_15, arg_1_1.talkMaxDuration)

			if var_4_14 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_23 + var_4_24 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_23) / var_4_24

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_23 + var_4_24 and arg_1_1.time_ < var_4_23 + var_4_24 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play411241002 = function(arg_10_0, arg_10_1)
		arg_10_1.time_ = 0
		arg_10_1.frameCnt_ = 0
		arg_10_1.state_ = "playing"
		arg_10_1.curTalkId_ = 411241002
		arg_10_1.duration_ = 1.77

		local var_10_0 = {
			zh = 1.766,
			ja = 1.733
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
				arg_10_0:Play411241003(arg_10_1)
			end
		end

		function arg_10_1.onSingleLineUpdate_(arg_13_0)
			local var_13_0 = 0.05

			if 0 < arg_10_1.time_ and arg_10_1.time_ <= 0 + arg_13_0 then
				arg_10_1.talkMaxDuration = 0
				arg_10_1.dialogCg_.alpha = 1

				arg_10_1.dialog_:SetActive(true)
				SetActive(arg_10_1.leftNameGo_, true)

				arg_10_1.leftNameTxt_.text = arg_10_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_10_1.leftNameTxt_.transform)

				arg_10_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_10_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_10_1:RecordName(arg_10_1.leftNameTxt_.text)
				SetActive(arg_10_1.iconTrs_.gameObject, false)
				arg_10_1.callingController_:SetSelectedState("normal")

				local var_13_1 = arg_10_1:GetWordFromCfg(411241002)
				local var_13_2 = arg_10_1:FormatText(var_13_1.content)

				arg_10_1.text_.text = var_13_2

				LuaForUtil.ClearLinePrefixSymbol(arg_10_1.text_)

				local var_13_4 = 2 <= 0 and var_13_0 or var_13_0 * (utf8.len(var_13_2) / 2)

				if (2 <= 0 and var_13_0 or var_13_0 * (utf8.len(var_13_2) / 2)) > 0 and var_13_0 < var_13_4 then
					arg_10_1.talkMaxDuration = var_13_4

					if var_13_4 + 0 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_4 + 0
					end
				end

				arg_10_1.text_.text = var_13_2
				arg_10_1.typewritter.percent = 0

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411241", "411241002", "story_v_out_411241.awb") ~= 0 then
					local var_13_5 = manager.audio:GetVoiceLength("story_v_out_411241", "411241002", "story_v_out_411241.awb") / 1000

					if var_13_5 + 0 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_5 + 0
					end

					if var_13_1.prefab_name ~= "" and arg_10_1.actors_[var_13_1.prefab_name] ~= nil then
						local var_13_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_10_1.actors_[var_13_1.prefab_name].transform, "story_v_out_411241", "411241002", "story_v_out_411241.awb")

						arg_10_1:RecordAudio("411241002", var_13_6)
						arg_10_1:RecordAudio("411241002", var_13_6)
					else
						arg_10_1:AudioAction("play", "voice", "story_v_out_411241", "411241002", "story_v_out_411241.awb")
					end

					arg_10_1:RecordHistoryTalkVoice("story_v_out_411241", "411241002", "story_v_out_411241.awb")
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
	Play411241003 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 411241003
		arg_14_1.duration_ = 3.67

		local var_14_0 = {
			zh = 3.666,
			ja = 1.7
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
				arg_14_0:Play411241004(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			local var_17_0 = 0.2

			if 0 < arg_14_1.time_ and arg_14_1.time_ <= 0 + arg_17_0 then
				arg_14_1.talkMaxDuration = 0
				arg_14_1.dialogCg_.alpha = 1

				arg_14_1.dialog_:SetActive(true)
				SetActive(arg_14_1.leftNameGo_, true)

				arg_14_1.leftNameTxt_.text = arg_14_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_14_1.leftNameTxt_.transform)

				arg_14_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_14_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_14_1:RecordName(arg_14_1.leftNameTxt_.text)
				SetActive(arg_14_1.iconTrs_.gameObject, false)
				arg_14_1.callingController_:SetSelectedState("normal")

				local var_17_1 = arg_14_1:GetWordFromCfg(411241003)
				local var_17_2 = arg_14_1:FormatText(var_17_1.content)

				arg_14_1.text_.text = var_17_2

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.text_)

				local var_17_4 = 8 <= 0 and var_17_0 or var_17_0 * (utf8.len(var_17_2) / 8)

				if (8 <= 0 and var_17_0 or var_17_0 * (utf8.len(var_17_2) / 8)) > 0 and var_17_0 < var_17_4 then
					arg_14_1.talkMaxDuration = var_17_4

					if var_17_4 + 0 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_4 + 0
					end
				end

				arg_14_1.text_.text = var_17_2
				arg_14_1.typewritter.percent = 0

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411241", "411241003", "story_v_out_411241.awb") ~= 0 then
					local var_17_5 = manager.audio:GetVoiceLength("story_v_out_411241", "411241003", "story_v_out_411241.awb") / 1000

					if var_17_5 + 0 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_5 + 0
					end

					if var_17_1.prefab_name ~= "" and arg_14_1.actors_[var_17_1.prefab_name] ~= nil then
						local var_17_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_14_1.actors_[var_17_1.prefab_name].transform, "story_v_out_411241", "411241003", "story_v_out_411241.awb")

						arg_14_1:RecordAudio("411241003", var_17_6)
						arg_14_1:RecordAudio("411241003", var_17_6)
					else
						arg_14_1:AudioAction("play", "voice", "story_v_out_411241", "411241003", "story_v_out_411241.awb")
					end

					arg_14_1:RecordHistoryTalkVoice("story_v_out_411241", "411241003", "story_v_out_411241.awb")
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
	Play411241004 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 411241004
		arg_18_1.duration_ = 3

		local var_18_0 = {
			zh = 1.966,
			ja = 3
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
				arg_18_0:Play411241005(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			local var_21_0 = 0.15

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= 0 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0
				arg_18_1.dialogCg_.alpha = 1

				arg_18_1.dialog_:SetActive(true)
				SetActive(arg_18_1.leftNameGo_, true)

				arg_18_1.leftNameTxt_.text = arg_18_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_18_1.leftNameTxt_.transform)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1.leftNameTxt_.text)
				SetActive(arg_18_1.iconTrs_.gameObject, false)
				arg_18_1.callingController_:SetSelectedState("normal")

				local var_21_1 = arg_18_1:GetWordFromCfg(411241004)
				local var_21_2 = arg_18_1:FormatText(var_21_1.content)

				arg_18_1.text_.text = var_21_2

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_4 = 6 <= 0 and var_21_0 or var_21_0 * (utf8.len(var_21_2) / 6)

				if (6 <= 0 and var_21_0 or var_21_0 * (utf8.len(var_21_2) / 6)) > 0 and var_21_0 < var_21_4 then
					arg_18_1.talkMaxDuration = var_21_4

					if var_21_4 + 0 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_4 + 0
					end
				end

				arg_18_1.text_.text = var_21_2
				arg_18_1.typewritter.percent = 0

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411241", "411241004", "story_v_out_411241.awb") ~= 0 then
					local var_21_5 = manager.audio:GetVoiceLength("story_v_out_411241", "411241004", "story_v_out_411241.awb") / 1000

					if var_21_5 + 0 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_5 + 0
					end

					if var_21_1.prefab_name ~= "" and arg_18_1.actors_[var_21_1.prefab_name] ~= nil then
						local var_21_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_18_1.actors_[var_21_1.prefab_name].transform, "story_v_out_411241", "411241004", "story_v_out_411241.awb")

						arg_18_1:RecordAudio("411241004", var_21_6)
						arg_18_1:RecordAudio("411241004", var_21_6)
					else
						arg_18_1:AudioAction("play", "voice", "story_v_out_411241", "411241004", "story_v_out_411241.awb")
					end

					arg_18_1:RecordHistoryTalkVoice("story_v_out_411241", "411241004", "story_v_out_411241.awb")
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
	Play411241005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 411241005
		arg_22_1.duration_ = 2.1

		local var_22_0 = {
			zh = 2.1,
			ja = 1.9
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
				arg_22_0:Play411241006(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			local var_25_0 = 0.05

			if 0 < arg_22_1.time_ and arg_22_1.time_ <= 0 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0
				arg_22_1.dialogCg_.alpha = 1

				arg_22_1.dialog_:SetActive(true)
				SetActive(arg_22_1.leftNameGo_, true)

				arg_22_1.leftNameTxt_.text = arg_22_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_22_1.leftNameTxt_.transform)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1.leftNameTxt_.text)
				SetActive(arg_22_1.iconTrs_.gameObject, false)
				arg_22_1.callingController_:SetSelectedState("normal")

				local var_25_1 = arg_22_1:GetWordFromCfg(411241005)
				local var_25_2 = arg_22_1:FormatText(var_25_1.content)

				arg_22_1.text_.text = var_25_2

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_4 = 2 <= 0 and var_25_0 or var_25_0 * (utf8.len(var_25_2) / 2)

				if (2 <= 0 and var_25_0 or var_25_0 * (utf8.len(var_25_2) / 2)) > 0 and var_25_0 < var_25_4 then
					arg_22_1.talkMaxDuration = var_25_4

					if var_25_4 + 0 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_4 + 0
					end
				end

				arg_22_1.text_.text = var_25_2
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411241", "411241005", "story_v_out_411241.awb") ~= 0 then
					local var_25_5 = manager.audio:GetVoiceLength("story_v_out_411241", "411241005", "story_v_out_411241.awb") / 1000

					if var_25_5 + 0 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_5 + 0
					end

					if var_25_1.prefab_name ~= "" and arg_22_1.actors_[var_25_1.prefab_name] ~= nil then
						local var_25_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_22_1.actors_[var_25_1.prefab_name].transform, "story_v_out_411241", "411241005", "story_v_out_411241.awb")

						arg_22_1:RecordAudio("411241005", var_25_6)
						arg_22_1:RecordAudio("411241005", var_25_6)
					else
						arg_22_1:AudioAction("play", "voice", "story_v_out_411241", "411241005", "story_v_out_411241.awb")
					end

					arg_22_1:RecordHistoryTalkVoice("story_v_out_411241", "411241005", "story_v_out_411241.awb")
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
	Play411241006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 411241006
		arg_26_1.duration_ = 4.23

		local var_26_0 = {
			zh = 1.633,
			ja = 4.233
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
				arg_26_0:Play411241007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			local var_29_0 = 0.125

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= 0 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, true)

				arg_26_1.leftNameTxt_.text = arg_26_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_26_1.leftNameTxt_.transform)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1.leftNameTxt_.text)
				SetActive(arg_26_1.iconTrs_.gameObject, false)
				arg_26_1.callingController_:SetSelectedState("normal")

				local var_29_1 = arg_26_1:GetWordFromCfg(411241006)
				local var_29_2 = arg_26_1:FormatText(var_29_1.content)

				arg_26_1.text_.text = var_29_2

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_4 = 5 <= 0 and var_29_0 or var_29_0 * (utf8.len(var_29_2) / 5)

				if (5 <= 0 and var_29_0 or var_29_0 * (utf8.len(var_29_2) / 5)) > 0 and var_29_0 < var_29_4 then
					arg_26_1.talkMaxDuration = var_29_4

					if var_29_4 + 0 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_4 + 0
					end
				end

				arg_26_1.text_.text = var_29_2
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411241", "411241006", "story_v_out_411241.awb") ~= 0 then
					local var_29_5 = manager.audio:GetVoiceLength("story_v_out_411241", "411241006", "story_v_out_411241.awb") / 1000

					if var_29_5 + 0 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_5 + 0
					end

					if var_29_1.prefab_name ~= "" and arg_26_1.actors_[var_29_1.prefab_name] ~= nil then
						local var_29_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_26_1.actors_[var_29_1.prefab_name].transform, "story_v_out_411241", "411241006", "story_v_out_411241.awb")

						arg_26_1:RecordAudio("411241006", var_29_6)
						arg_26_1:RecordAudio("411241006", var_29_6)
					else
						arg_26_1:AudioAction("play", "voice", "story_v_out_411241", "411241006", "story_v_out_411241.awb")
					end

					arg_26_1:RecordHistoryTalkVoice("story_v_out_411241", "411241006", "story_v_out_411241.awb")
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
	Play411241007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 411241007
		arg_30_1.duration_ = 6.13

		local var_30_0 = {
			zh = 4.966,
			ja = 6.133
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
				arg_30_0:Play411241008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			local var_33_0 = 0.45

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, true)

				arg_30_1.leftNameTxt_.text = arg_30_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_30_1.leftNameTxt_.transform)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1.leftNameTxt_.text)
				SetActive(arg_30_1.iconTrs_.gameObject, false)
				arg_30_1.callingController_:SetSelectedState("normal")

				local var_33_1 = arg_30_1:GetWordFromCfg(411241007)
				local var_33_2 = arg_30_1:FormatText(var_33_1.content)

				arg_30_1.text_.text = var_33_2

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_4 = 18 <= 0 and var_33_0 or var_33_0 * (utf8.len(var_33_2) / 18)

				if (18 <= 0 and var_33_0 or var_33_0 * (utf8.len(var_33_2) / 18)) > 0 and var_33_0 < var_33_4 then
					arg_30_1.talkMaxDuration = var_33_4

					if var_33_4 + 0 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_4 + 0
					end
				end

				arg_30_1.text_.text = var_33_2
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411241", "411241007", "story_v_out_411241.awb") ~= 0 then
					local var_33_5 = manager.audio:GetVoiceLength("story_v_out_411241", "411241007", "story_v_out_411241.awb") / 1000

					if var_33_5 + 0 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_5 + 0
					end

					if var_33_1.prefab_name ~= "" and arg_30_1.actors_[var_33_1.prefab_name] ~= nil then
						local var_33_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_30_1.actors_[var_33_1.prefab_name].transform, "story_v_out_411241", "411241007", "story_v_out_411241.awb")

						arg_30_1:RecordAudio("411241007", var_33_6)
						arg_30_1:RecordAudio("411241007", var_33_6)
					else
						arg_30_1:AudioAction("play", "voice", "story_v_out_411241", "411241007", "story_v_out_411241.awb")
					end

					arg_30_1:RecordHistoryTalkVoice("story_v_out_411241", "411241007", "story_v_out_411241.awb")
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
	Play411241008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 411241008
		arg_34_1.duration_ = 6.83

		SetActive(arg_34_1.tipsGo_, false)

		function arg_34_1.onSingleLineFinish_()
			arg_34_1.onSingleLineUpdate_ = nil
			arg_34_1.onSingleLineFinish_ = nil
			arg_34_1.state_ = "waiting"
		end

		function arg_34_1.playNext_(arg_36_0)
			if arg_36_0 == 1 then
				arg_34_0:Play411241009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 then
				arg_34_1.var_.moveOldPosML0602 = arg_34_1.bgs_.ML0602.transform.localPosition
			end

			local var_37_0 = 0.001

			if 0 <= arg_34_1.time_ and arg_34_1.time_ < 0 + var_37_0 then
				arg_34_1.bgs_.ML0602.transform.localPosition = Vector3.Lerp(arg_34_1.var_.moveOldPosML0602, Vector3.New(0, 1, 10), (arg_34_1.time_ - 0) / var_37_0)
			end

			if arg_34_1.time_ >= 0 + var_37_0 and arg_34_1.time_ < 0 + var_37_0 + arg_37_0 then
				arg_34_1.bgs_.ML0602.transform.localPosition = Vector3.New(0, 1, 10)
			end

			local var_37_1 = arg_34_1.bgs_.ML0602.transform

			if 0.0166666666666667 < arg_34_1.time_ and arg_34_1.time_ <= 0.0166666666666667 + arg_37_0 then
				arg_34_1.var_.moveOldPosML0602 = var_37_1.localPosition
			end

			local var_37_2 = 2.31666666666667

			if 0.0166666666666667 <= arg_34_1.time_ and arg_34_1.time_ < 0.0166666666666667 + var_37_2 then
				var_37_1.localPosition = Vector3.Lerp(arg_34_1.var_.moveOldPosML0602, Vector3.New(0, 1, 8.83), (arg_34_1.time_ - 0.0166666666666667) / var_37_2)
			end

			if arg_34_1.time_ >= 0.0166666666666667 + var_37_2 and arg_34_1.time_ < 0.0166666666666667 + var_37_2 + arg_37_0 then
				var_37_1.localPosition = Vector3.New(0, 1, 8.83)
			end

			local var_37_3 = 1.83333333333333
			local var_37_4 = 1.3

			if 1.83333333333333 < arg_34_1.time_ and arg_34_1.time_ <= var_37_3 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, false)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_5 = arg_34_1:FormatText(arg_34_1:GetWordFromCfg(411241008).content)

				arg_34_1.text_.text = var_37_5

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_7 = 52 <= 0 and var_37_4 or var_37_4 * (utf8.len(var_37_5) / 52)

				if (52 <= 0 and var_37_4 or var_37_4 * (utf8.len(var_37_5) / 52)) > 0 and var_37_4 < var_37_7 then
					arg_34_1.talkMaxDuration = var_37_7

					if var_37_7 + var_37_3 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_7 + var_37_3
					end
				end

				arg_34_1.text_.text = var_37_5
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)
				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_8 = math.max(var_37_4, arg_34_1.talkMaxDuration)

			if var_37_3 <= arg_34_1.time_ and arg_34_1.time_ < var_37_3 + var_37_8 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_3) / var_37_8

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_3 + var_37_8 and arg_34_1.time_ < var_37_3 + var_37_8 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "ML0602",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "ML0602",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2.31666666666667,
				className = "StoryMoveNode",
				startTime = 0.0166666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_34_1:InitPlayNodeList()
	end,
	Play411241009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 411241009
		arg_38_1.duration_ = 7.97

		local var_38_0 = {
			zh = 7.1,
			ja = 7.966
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
				arg_38_0:Play411241010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			local var_41_0 = 0.75

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				arg_38_1.leftNameTxt_.text = arg_38_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_1 = arg_38_1:GetWordFromCfg(411241009)
				local var_41_2 = arg_38_1:FormatText(var_41_1.content)

				arg_38_1.text_.text = var_41_2

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_4 = 30 <= 0 and var_41_0 or var_41_0 * (utf8.len(var_41_2) / 30)

				if (30 <= 0 and var_41_0 or var_41_0 * (utf8.len(var_41_2) / 30)) > 0 and var_41_0 < var_41_4 then
					arg_38_1.talkMaxDuration = var_41_4

					if var_41_4 + 0 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_4 + 0
					end
				end

				arg_38_1.text_.text = var_41_2
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411241", "411241009", "story_v_out_411241.awb") ~= 0 then
					local var_41_5 = manager.audio:GetVoiceLength("story_v_out_411241", "411241009", "story_v_out_411241.awb") / 1000

					if var_41_5 + 0 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_5 + 0
					end

					if var_41_1.prefab_name ~= "" and arg_38_1.actors_[var_41_1.prefab_name] ~= nil then
						local var_41_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_38_1.actors_[var_41_1.prefab_name].transform, "story_v_out_411241", "411241009", "story_v_out_411241.awb")

						arg_38_1:RecordAudio("411241009", var_41_6)
						arg_38_1:RecordAudio("411241009", var_41_6)
					else
						arg_38_1:AudioAction("play", "voice", "story_v_out_411241", "411241009", "story_v_out_411241.awb")
					end

					arg_38_1:RecordHistoryTalkVoice("story_v_out_411241", "411241009", "story_v_out_411241.awb")
				end

				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_7 = math.max(var_41_0, arg_38_1.talkMaxDuration)

			if 0 <= arg_38_1.time_ and arg_38_1.time_ < 0 + var_41_7 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - 0) / var_41_7

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= 0 + var_41_7 and arg_38_1.time_ < 0 + var_41_7 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play411241010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 411241010
		arg_42_1.duration_ = 3.87

		local var_42_0 = {
			zh = 3.633,
			ja = 3.866
		}
		local var_42_1 = manager.audio:GetLocalizationFlag()

		if var_42_0[var_42_1] ~= nil then
			arg_42_1.duration_ = var_42_0[var_42_1]
		end

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play411241011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			local var_45_0 = 0.65

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				arg_42_1.leftNameTxt_.text = arg_42_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_1 = arg_42_1:GetWordFromCfg(411241010)
				local var_45_2 = arg_42_1:FormatText(var_45_1.content)

				arg_42_1.text_.text = var_45_2

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_4 = 26 <= 0 and var_45_0 or var_45_0 * (utf8.len(var_45_2) / 26)

				if (26 <= 0 and var_45_0 or var_45_0 * (utf8.len(var_45_2) / 26)) > 0 and var_45_0 < var_45_4 then
					arg_42_1.talkMaxDuration = var_45_4

					if var_45_4 + 0 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_4 + 0
					end
				end

				arg_42_1.text_.text = var_45_2
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411241", "411241010", "story_v_out_411241.awb") ~= 0 then
					local var_45_5 = manager.audio:GetVoiceLength("story_v_out_411241", "411241010", "story_v_out_411241.awb") / 1000

					if var_45_5 + 0 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_5 + 0
					end

					if var_45_1.prefab_name ~= "" and arg_42_1.actors_[var_45_1.prefab_name] ~= nil then
						local var_45_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_1.prefab_name].transform, "story_v_out_411241", "411241010", "story_v_out_411241.awb")

						arg_42_1:RecordAudio("411241010", var_45_6)
						arg_42_1:RecordAudio("411241010", var_45_6)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_out_411241", "411241010", "story_v_out_411241.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_out_411241", "411241010", "story_v_out_411241.awb")
				end

				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_7 = math.max(var_45_0, arg_42_1.talkMaxDuration)

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_7 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - 0) / var_45_7

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= 0 + var_45_7 and arg_42_1.time_ < 0 + var_45_7 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {}

		arg_42_1:InitPlayNodeList()
	end,
	Play411241011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 411241011
		arg_46_1.duration_ = 2.37

		local var_46_0 = {
			zh = 2.366,
			ja = 1.933
		}
		local var_46_1 = manager.audio:GetLocalizationFlag()

		if var_46_0[var_46_1] ~= nil then
			arg_46_1.duration_ = var_46_0[var_46_1]
		end

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play411241012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			local var_49_0 = 0.05

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, true)

				arg_46_1.leftNameTxt_.text = arg_46_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_46_1.leftNameTxt_.transform)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1.leftNameTxt_.text)
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_1 = arg_46_1:GetWordFromCfg(411241011)
				local var_49_2 = arg_46_1:FormatText(var_49_1.content)

				arg_46_1.text_.text = var_49_2

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_4 = 2 <= 0 and var_49_0 or var_49_0 * (utf8.len(var_49_2) / 2)

				if (2 <= 0 and var_49_0 or var_49_0 * (utf8.len(var_49_2) / 2)) > 0 and var_49_0 < var_49_4 then
					arg_46_1.talkMaxDuration = var_49_4

					if var_49_4 + 0 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_4 + 0
					end
				end

				arg_46_1.text_.text = var_49_2
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411241", "411241011", "story_v_out_411241.awb") ~= 0 then
					local var_49_5 = manager.audio:GetVoiceLength("story_v_out_411241", "411241011", "story_v_out_411241.awb") / 1000

					if var_49_5 + 0 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_5 + 0
					end

					if var_49_1.prefab_name ~= "" and arg_46_1.actors_[var_49_1.prefab_name] ~= nil then
						local var_49_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_46_1.actors_[var_49_1.prefab_name].transform, "story_v_out_411241", "411241011", "story_v_out_411241.awb")

						arg_46_1:RecordAudio("411241011", var_49_6)
						arg_46_1:RecordAudio("411241011", var_49_6)
					else
						arg_46_1:AudioAction("play", "voice", "story_v_out_411241", "411241011", "story_v_out_411241.awb")
					end

					arg_46_1:RecordHistoryTalkVoice("story_v_out_411241", "411241011", "story_v_out_411241.awb")
				end

				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_7 = math.max(var_49_0, arg_46_1.talkMaxDuration)

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_7 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - 0) / var_49_7

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= 0 + var_49_7 and arg_46_1.time_ < 0 + var_49_7 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {}

		arg_46_1:InitPlayNodeList()
	end,
	Play411241012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 411241012
		arg_50_1.duration_ = 5

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play411241013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_0 = 1.025

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, false)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_1 = arg_50_1:FormatText(arg_50_1:GetWordFromCfg(411241012).content)

				arg_50_1.text_.text = var_53_1

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_3 = 41 <= 0 and var_53_0 or var_53_0 * (utf8.len(var_53_1) / 41)

				if (41 <= 0 and var_53_0 or var_53_0 * (utf8.len(var_53_1) / 41)) > 0 and var_53_0 < var_53_3 then
					arg_50_1.talkMaxDuration = var_53_3

					if var_53_3 + 0 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_3 + 0
					end
				end

				arg_50_1.text_.text = var_53_1
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)
				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_4 = math.max(var_53_0, arg_50_1.talkMaxDuration)

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_4 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - 0) / var_53_4

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= 0 + var_53_4 and arg_50_1.time_ < 0 + var_53_4 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {}

		arg_50_1:InitPlayNodeList()
	end,
	Play411241013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 411241013
		arg_54_1.duration_ = 2.3

		local var_54_0 = {
			zh = 2.3,
			ja = 1.733
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
				arg_54_0:Play411241014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = 0.175

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				arg_54_1.leftNameTxt_.text = arg_54_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_1 = arg_54_1:GetWordFromCfg(411241013)
				local var_57_2 = arg_54_1:FormatText(var_57_1.content)

				arg_54_1.text_.text = var_57_2

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_4 = 7 <= 0 and var_57_0 or var_57_0 * (utf8.len(var_57_2) / 7)

				if (7 <= 0 and var_57_0 or var_57_0 * (utf8.len(var_57_2) / 7)) > 0 and var_57_0 < var_57_4 then
					arg_54_1.talkMaxDuration = var_57_4

					if var_57_4 + 0 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_4 + 0
					end
				end

				arg_54_1.text_.text = var_57_2
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411241", "411241013", "story_v_out_411241.awb") ~= 0 then
					local var_57_5 = manager.audio:GetVoiceLength("story_v_out_411241", "411241013", "story_v_out_411241.awb") / 1000

					if var_57_5 + 0 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_5 + 0
					end

					if var_57_1.prefab_name ~= "" and arg_54_1.actors_[var_57_1.prefab_name] ~= nil then
						local var_57_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_1.prefab_name].transform, "story_v_out_411241", "411241013", "story_v_out_411241.awb")

						arg_54_1:RecordAudio("411241013", var_57_6)
						arg_54_1:RecordAudio("411241013", var_57_6)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_411241", "411241013", "story_v_out_411241.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_411241", "411241013", "story_v_out_411241.awb")
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
	Play411241014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 411241014
		arg_58_1.duration_ = 5

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play411241015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			if arg_58_1.actors_["1095ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1095ui_story"))) then
				local var_61_0 = Object.Instantiate(Asset.Load("Char/" .. "1095ui_story"), arg_58_1.stage_.transform)

				var_61_0.name = "1095ui_story"
				var_61_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_58_1.actors_["1095ui_story"] = var_61_0

				local var_61_1 = var_61_0:GetComponentInChildren(typeof(CharacterEffect))

				var_61_1.enabled = true

				local var_61_2 = GameObjectTools.GetOrAddComponent(var_61_0, typeof(DynamicBoneHelper))

				if var_61_2 then
					var_61_2:EnableDynamicBone(false)
				end

				arg_58_1:ShowWeapon(var_61_1.transform, false)

				arg_58_1.var_["1095ui_story" .. "Animator"] = var_61_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_58_1.var_["1095ui_story" .. "Animator"].applyRootMotion = true
				arg_58_1.var_["1095ui_story" .. "LipSync"] = var_61_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_61_3 = arg_58_1.actors_["1095ui_story"].transform

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1.var_.moveOldPos1095ui_story = var_61_3.localPosition
			end

			local var_61_4 = 0.001

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_4 then
				var_61_3.localPosition = Vector3.Lerp(arg_58_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_58_1.time_ - 0) / var_61_4)
				var_61_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_61_3.position).x, (manager.ui.mainCamera.transform.position - var_61_3.position).y, (manager.ui.mainCamera.transform.position - var_61_3.position).z)
				var_61_3.localEulerAngles.z = 0
				var_61_3.localEulerAngles.x = 0
				var_61_3.localEulerAngles = var_61_3.localEulerAngles
			end

			if arg_58_1.time_ >= 0 + var_61_4 and arg_58_1.time_ < 0 + var_61_4 + arg_61_0 then
				var_61_3.localPosition = Vector3.New(0, 100, 0)
				var_61_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_61_3.position).x, (manager.ui.mainCamera.transform.position - var_61_3.position).y, (manager.ui.mainCamera.transform.position - var_61_3.position).z)
				var_61_3.localEulerAngles.z = 0
				var_61_3.localEulerAngles.x = 0
				var_61_3.localEulerAngles = var_61_3.localEulerAngles
			end

			local var_61_5 = arg_58_1.actors_["1095ui_story"]

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 and not isNil(var_61_5) and arg_58_1.var_.characterEffect1095ui_story == nil then
				arg_58_1.var_.characterEffect1095ui_story = var_61_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_6 = 0.200000002980232

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_6 and not isNil(var_61_5) then
				if arg_58_1.var_.characterEffect1095ui_story and not isNil(var_61_5) then
					arg_58_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_58_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_58_1.time_ - 0) / var_61_6)
				end
			end

			if arg_58_1.time_ >= 0 + var_61_6 and arg_58_1.time_ < 0 + var_61_6 + arg_61_0 and not isNil(var_61_5) and arg_58_1.var_.characterEffect1095ui_story then
				arg_58_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_58_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_61_7 = 0
			local var_61_8 = 0.725

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_7 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, false)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_9 = arg_58_1:FormatText(arg_58_1:GetWordFromCfg(411241014).content)

				arg_58_1.text_.text = var_61_9

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_11 = 29 <= 0 and var_61_8 or var_61_8 * (utf8.len(var_61_9) / 29)

				if (29 <= 0 and var_61_8 or var_61_8 * (utf8.len(var_61_9) / 29)) > 0 and var_61_8 < var_61_11 then
					arg_58_1.talkMaxDuration = var_61_11

					if var_61_11 + var_61_7 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_11 + var_61_7
					end
				end

				arg_58_1.text_.text = var_61_9
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)
				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_12 = math.max(var_61_8, arg_58_1.talkMaxDuration)

			if var_61_7 <= arg_58_1.time_ and arg_58_1.time_ < var_61_7 + var_61_12 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_7) / var_61_12

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_7 + var_61_12 and arg_58_1.time_ < var_61_7 + var_61_12 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {
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

		arg_58_1:InitPlayNodeList()
	end,
	Play411241015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 411241015
		arg_62_1.duration_ = 5

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play411241016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = 0.9

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, false)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_1 = arg_62_1:FormatText(arg_62_1:GetWordFromCfg(411241015).content)

				arg_62_1.text_.text = var_65_1

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_3 = 36 <= 0 and var_65_0 or var_65_0 * (utf8.len(var_65_1) / 36)

				if (36 <= 0 and var_65_0 or var_65_0 * (utf8.len(var_65_1) / 36)) > 0 and var_65_0 < var_65_3 then
					arg_62_1.talkMaxDuration = var_65_3

					if var_65_3 + 0 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_3 + 0
					end
				end

				arg_62_1.text_.text = var_65_1
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)
				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_4 = math.max(var_65_0, arg_62_1.talkMaxDuration)

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_4 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - 0) / var_65_4

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= 0 + var_65_4 and arg_62_1.time_ < 0 + var_65_4 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	Play411241016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 411241016
		arg_66_1.duration_ = 4.67

		local var_66_0 = {
			zh = 4.133,
			ja = 4.666
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
				arg_66_0:Play411241017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = 0.425

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				arg_66_1.leftNameTxt_.text = arg_66_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_1 = arg_66_1:GetWordFromCfg(411241016)
				local var_69_2 = arg_66_1:FormatText(var_69_1.content)

				arg_66_1.text_.text = var_69_2

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_4 = 17 <= 0 and var_69_0 or var_69_0 * (utf8.len(var_69_2) / 17)

				if (17 <= 0 and var_69_0 or var_69_0 * (utf8.len(var_69_2) / 17)) > 0 and var_69_0 < var_69_4 then
					arg_66_1.talkMaxDuration = var_69_4

					if var_69_4 + 0 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_4 + 0
					end
				end

				arg_66_1.text_.text = var_69_2
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411241", "411241016", "story_v_out_411241.awb") ~= 0 then
					local var_69_5 = manager.audio:GetVoiceLength("story_v_out_411241", "411241016", "story_v_out_411241.awb") / 1000

					if var_69_5 + 0 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_5 + 0
					end

					if var_69_1.prefab_name ~= "" and arg_66_1.actors_[var_69_1.prefab_name] ~= nil then
						local var_69_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_1.prefab_name].transform, "story_v_out_411241", "411241016", "story_v_out_411241.awb")

						arg_66_1:RecordAudio("411241016", var_69_6)
						arg_66_1:RecordAudio("411241016", var_69_6)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_411241", "411241016", "story_v_out_411241.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_411241", "411241016", "story_v_out_411241.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_7 = math.max(var_69_0, arg_66_1.talkMaxDuration)

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_7 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - 0) / var_69_7

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= 0 + var_69_7 and arg_66_1.time_ < 0 + var_69_7 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play411241017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 411241017
		arg_70_1.duration_ = 9

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play411241018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			if arg_70_1.bgs_.ST77a == nil then
				local var_73_0 = Object.Instantiate(arg_70_1.paintGo_)

				var_73_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST77a")
				var_73_0.name = "ST77a"
				var_73_0.transform.parent = arg_70_1.stage_.transform
				var_73_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_70_1.bgs_.ST77a = var_73_0
			end

			if 2 < arg_70_1.time_ and arg_70_1.time_ <= 2 + arg_73_0 then
				local var_73_1 = arg_70_1.bgs_.ST77a

				arg_70_1.bgs_.ST77a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_73_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_73_2 = var_73_1:GetComponent("SpriteRenderer")

				if var_73_2 and var_73_2.sprite then
					local var_73_3 = 2 * (var_73_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_73_1.transform.localScale = Vector3.New(var_73_3 / var_73_2.sprite.bounds.size.y < var_73_3 * manager.ui.mainCameraCom_.aspect / var_73_2.sprite.bounds.size.x and var_73_3 * manager.ui.mainCameraCom_.aspect / var_73_2.sprite.bounds.size.x or var_73_3 / var_73_2.sprite.bounds.size.y, var_73_3 / var_73_2.sprite.bounds.size.y < var_73_3 * manager.ui.mainCameraCom_.aspect / var_73_2.sprite.bounds.size.x and var_73_3 * manager.ui.mainCameraCom_.aspect / var_73_2.sprite.bounds.size.x or var_73_3 / var_73_2.sprite.bounds.size.y, 0)
				end

				for iter_73_0, iter_73_1 in pairs(arg_70_1.bgs_) do
					if iter_73_0 ~= "ST77a" then
						iter_73_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_73_4 = 0

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_4 + arg_73_0 then
				arg_70_1.mask_.enabled = true
				arg_70_1.mask_.raycastTarget = true

				arg_70_1:SetGaussion(false)
			end

			local var_73_5 = 2

			if var_73_4 <= arg_70_1.time_ and arg_70_1.time_ < var_73_4 + var_73_5 then
				local var_73_6 = Color.New(0, 0, 0)

				var_73_6.a = Mathf.Lerp(0, 1, (arg_70_1.time_ - var_73_4) / var_73_5)
				arg_70_1.mask_.color = var_73_6
			end

			if arg_70_1.time_ >= var_73_4 + var_73_5 and arg_70_1.time_ < var_73_4 + var_73_5 + arg_73_0 then
				local var_73_7 = Color.New(0, 0, 0)

				var_73_7.a = 1
				arg_70_1.mask_.color = var_73_7
			end

			local var_73_8 = 2

			if 2 < arg_70_1.time_ and arg_70_1.time_ <= var_73_8 + arg_73_0 then
				arg_70_1.mask_.enabled = true
				arg_70_1.mask_.raycastTarget = true

				arg_70_1:SetGaussion(false)
			end

			local var_73_9 = 2

			if var_73_8 <= arg_70_1.time_ and arg_70_1.time_ < var_73_8 + var_73_9 then
				local var_73_10 = Color.New(0, 0, 0)

				var_73_10.a = Mathf.Lerp(1, 0, (arg_70_1.time_ - var_73_8) / var_73_9)
				arg_70_1.mask_.color = var_73_10
			end

			if arg_70_1.time_ >= var_73_8 + var_73_9 and arg_70_1.time_ < var_73_8 + var_73_9 + arg_73_0 then
				local var_73_11 = Color.New(0, 0, 0)

				arg_70_1.mask_.enabled = false
				var_73_11.a = 0
				arg_70_1.mask_.color = var_73_11
			end

			if arg_70_1.frameCnt_ <= 1 then
				arg_70_1.dialog_:SetActive(false)
			end

			local var_73_12 = 4
			local var_73_13 = 0.525

			if 4 < arg_70_1.time_ and arg_70_1.time_ <= var_73_12 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0

				arg_70_1.dialog_:SetActive(true)

				arg_70_1.dialogCg_.alpha = 0

				local var_73_14 = LeanTween.value(arg_70_1.dialog_, 0, 1, 0.3)

				var_73_14:setOnUpdate(LuaHelper.FloatAction(function(arg_74_0)
					arg_70_1.dialogCg_.alpha = arg_74_0
				end))
				var_73_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_70_1.dialog_)
					var_73_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_70_1.duration_ = arg_70_1.duration_ + 0.3

				SetActive(arg_70_1.leftNameGo_, false)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_15 = arg_70_1:FormatText(arg_70_1:GetWordFromCfg(411241017).content)

				arg_70_1.text_.text = var_73_15

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_17 = 21 <= 0 and var_73_13 or var_73_13 * (utf8.len(var_73_15) / 21)

				if (21 <= 0 and var_73_13 or var_73_13 * (utf8.len(var_73_15) / 21)) > 0 and var_73_13 < var_73_17 then
					arg_70_1.talkMaxDuration = var_73_17
					var_73_12 = var_73_12 + 0.3

					if var_73_17 + var_73_12 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_17 + var_73_12
					end
				end

				arg_70_1.text_.text = var_73_15
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)
				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_18 = var_73_12 + 0.3
			local var_73_19 = math.max(var_73_13, arg_70_1.talkMaxDuration)

			if var_73_12 + 0.3 <= arg_70_1.time_ and arg_70_1.time_ < var_73_18 + var_73_19 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_18) / var_73_19

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_18 + var_73_19 and arg_70_1.time_ < var_73_18 + var_73_19 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play411241018 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 411241018
		arg_76_1.duration_ = 5

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play411241019(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = 0.575

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, false)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_1 = arg_76_1:FormatText(arg_76_1:GetWordFromCfg(411241018).content)

				arg_76_1.text_.text = var_79_1

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_3 = 23 <= 0 and var_79_0 or var_79_0 * (utf8.len(var_79_1) / 23)

				if (23 <= 0 and var_79_0 or var_79_0 * (utf8.len(var_79_1) / 23)) > 0 and var_79_0 < var_79_3 then
					arg_76_1.talkMaxDuration = var_79_3

					if var_79_3 + 0 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_3 + 0
					end
				end

				arg_76_1.text_.text = var_79_1
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)
				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_4 = math.max(var_79_0, arg_76_1.talkMaxDuration)

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_4 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - 0) / var_79_4

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= 0 + var_79_4 and arg_76_1.time_ < 0 + var_79_4 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play411241019 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 411241019
		arg_80_1.duration_ = 3.1

		local var_80_0 = {
			zh = 1.9,
			ja = 3.1
		}
		local var_80_1 = manager.audio:GetLocalizationFlag()

		if var_80_0[var_80_1] ~= nil then
			arg_80_1.duration_ = var_80_0[var_80_1]
		end

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play411241020(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = 0.15

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				arg_80_1.leftNameTxt_.text = arg_80_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, true)
				arg_80_1.iconController_:SetSelectedState("hero")

				arg_80_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10025_1")

				arg_80_1.callingController_:SetSelectedState("normal")

				arg_80_1.keyicon_.color = Color.New(1, 1, 1)
				arg_80_1.icon_.color = Color.New(1, 1, 1)

				local var_83_1 = arg_80_1:GetWordFromCfg(411241019)
				local var_83_2 = arg_80_1:FormatText(var_83_1.content)

				arg_80_1.text_.text = var_83_2

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_4 = 6 <= 0 and var_83_0 or var_83_0 * (utf8.len(var_83_2) / 6)

				if (6 <= 0 and var_83_0 or var_83_0 * (utf8.len(var_83_2) / 6)) > 0 and var_83_0 < var_83_4 then
					arg_80_1.talkMaxDuration = var_83_4

					if var_83_4 + 0 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_4 + 0
					end
				end

				arg_80_1.text_.text = var_83_2
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411241", "411241019", "story_v_out_411241.awb") ~= 0 then
					local var_83_5 = manager.audio:GetVoiceLength("story_v_out_411241", "411241019", "story_v_out_411241.awb") / 1000

					if var_83_5 + 0 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_5 + 0
					end

					if var_83_1.prefab_name ~= "" and arg_80_1.actors_[var_83_1.prefab_name] ~= nil then
						local var_83_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_1.prefab_name].transform, "story_v_out_411241", "411241019", "story_v_out_411241.awb")

						arg_80_1:RecordAudio("411241019", var_83_6)
						arg_80_1:RecordAudio("411241019", var_83_6)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_411241", "411241019", "story_v_out_411241.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_411241", "411241019", "story_v_out_411241.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_7 = math.max(var_83_0, arg_80_1.talkMaxDuration)

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_7 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - 0) / var_83_7

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= 0 + var_83_7 and arg_80_1.time_ < 0 + var_83_7 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play411241020 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 411241020
		arg_84_1.duration_ = 4.8

		local var_84_0 = {
			zh = 4.8,
			ja = 4.233
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
				arg_84_0:Play411241021(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			if arg_84_1.actors_["10058ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10058ui_story"))) then
				local var_87_0 = Object.Instantiate(Asset.Load("Char/" .. "10058ui_story"), arg_84_1.stage_.transform)

				var_87_0.name = "10058ui_story"
				var_87_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_84_1.actors_["10058ui_story"] = var_87_0

				local var_87_1 = var_87_0:GetComponentInChildren(typeof(CharacterEffect))

				var_87_1.enabled = true

				local var_87_2 = GameObjectTools.GetOrAddComponent(var_87_0, typeof(DynamicBoneHelper))

				if var_87_2 then
					var_87_2:EnableDynamicBone(false)
				end

				arg_84_1:ShowWeapon(var_87_1.transform, false)

				arg_84_1.var_["10058ui_story" .. "Animator"] = var_87_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_84_1.var_["10058ui_story" .. "Animator"].applyRootMotion = true
				arg_84_1.var_["10058ui_story" .. "LipSync"] = var_87_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_87_3 = arg_84_1.actors_["10058ui_story"].transform

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1.var_.moveOldPos10058ui_story = var_87_3.localPosition
			end

			local var_87_4 = 0.001

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_4 then
				var_87_3.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos10058ui_story, Vector3.New(0, -0.98, -6.1), (arg_84_1.time_ - 0) / var_87_4)
				var_87_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_87_3.position).x, (manager.ui.mainCamera.transform.position - var_87_3.position).y, (manager.ui.mainCamera.transform.position - var_87_3.position).z)
				var_87_3.localEulerAngles.z = 0
				var_87_3.localEulerAngles.x = 0
				var_87_3.localEulerAngles = var_87_3.localEulerAngles
			end

			if arg_84_1.time_ >= 0 + var_87_4 and arg_84_1.time_ < 0 + var_87_4 + arg_87_0 then
				var_87_3.localPosition = Vector3.New(0, -0.98, -6.1)
				var_87_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_87_3.position).x, (manager.ui.mainCamera.transform.position - var_87_3.position).y, (manager.ui.mainCamera.transform.position - var_87_3.position).z)
				var_87_3.localEulerAngles.z = 0
				var_87_3.localEulerAngles.x = 0
				var_87_3.localEulerAngles = var_87_3.localEulerAngles
			end

			local var_87_5 = arg_84_1.actors_["10058ui_story"]

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 and not isNil(var_87_5) and arg_84_1.var_.characterEffect10058ui_story == nil then
				arg_84_1.var_.characterEffect10058ui_story = var_87_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_6 = 0.200000002980232

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_6 and not isNil(var_87_5) then
				if arg_84_1.var_.characterEffect10058ui_story and not isNil(var_87_5) then
					arg_84_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_84_1.time_ >= 0 + var_87_6 and arg_84_1.time_ < 0 + var_87_6 + arg_87_0 and not isNil(var_87_5) and arg_84_1.var_.characterEffect10058ui_story then
				arg_84_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_87_8 = 0
			local var_87_9 = 0.525

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_8 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				arg_84_1.leftNameTxt_.text = arg_84_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_10 = arg_84_1:GetWordFromCfg(411241020)
				local var_87_11 = arg_84_1:FormatText(var_87_10.content)

				arg_84_1.text_.text = var_87_11

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_13 = 21 <= 0 and var_87_9 or var_87_9 * (utf8.len(var_87_11) / 21)

				if (21 <= 0 and var_87_9 or var_87_9 * (utf8.len(var_87_11) / 21)) > 0 and var_87_9 < var_87_13 then
					arg_84_1.talkMaxDuration = var_87_13

					if var_87_13 + var_87_8 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_13 + var_87_8
					end
				end

				arg_84_1.text_.text = var_87_11
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411241", "411241020", "story_v_out_411241.awb") ~= 0 then
					local var_87_14 = manager.audio:GetVoiceLength("story_v_out_411241", "411241020", "story_v_out_411241.awb") / 1000

					if var_87_14 + var_87_8 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_14 + var_87_8
					end

					if var_87_10.prefab_name ~= "" and arg_84_1.actors_[var_87_10.prefab_name] ~= nil then
						local var_87_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_10.prefab_name].transform, "story_v_out_411241", "411241020", "story_v_out_411241.awb")

						arg_84_1:RecordAudio("411241020", var_87_15)
						arg_84_1:RecordAudio("411241020", var_87_15)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_411241", "411241020", "story_v_out_411241.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_411241", "411241020", "story_v_out_411241.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_16 = math.max(var_87_9, arg_84_1.talkMaxDuration)

			if var_87_8 <= arg_84_1.time_ and arg_84_1.time_ < var_87_8 + var_87_16 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_8) / var_87_16

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_8 + var_87_16 and arg_84_1.time_ < var_87_8 + var_87_16 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
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
	Play411241021 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 411241021
		arg_88_1.duration_ = 3.3

		local var_88_0 = {
			zh = 3.066,
			ja = 3.3
		}
		local var_88_1 = manager.audio:GetLocalizationFlag()

		if var_88_0[var_88_1] ~= nil then
			arg_88_1.duration_ = var_88_0[var_88_1]
		end

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play411241022(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_91_0 = 0
			local var_91_1 = 0.4

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_0 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				arg_88_1.leftNameTxt_.text = arg_88_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_2 = arg_88_1:GetWordFromCfg(411241021)
				local var_91_3 = arg_88_1:FormatText(var_91_2.content)

				arg_88_1.text_.text = var_91_3

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_5 = 16 <= 0 and var_91_1 or var_91_1 * (utf8.len(var_91_3) / 16)

				if (16 <= 0 and var_91_1 or var_91_1 * (utf8.len(var_91_3) / 16)) > 0 and var_91_1 < var_91_5 then
					arg_88_1.talkMaxDuration = var_91_5

					if var_91_5 + var_91_0 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_5 + var_91_0
					end
				end

				arg_88_1.text_.text = var_91_3
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411241", "411241021", "story_v_out_411241.awb") ~= 0 then
					local var_91_6 = manager.audio:GetVoiceLength("story_v_out_411241", "411241021", "story_v_out_411241.awb") / 1000

					if var_91_6 + var_91_0 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_6 + var_91_0
					end

					if var_91_2.prefab_name ~= "" and arg_88_1.actors_[var_91_2.prefab_name] ~= nil then
						local var_91_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_2.prefab_name].transform, "story_v_out_411241", "411241021", "story_v_out_411241.awb")

						arg_88_1:RecordAudio("411241021", var_91_7)
						arg_88_1:RecordAudio("411241021", var_91_7)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_411241", "411241021", "story_v_out_411241.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_411241", "411241021", "story_v_out_411241.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_8 = math.max(var_91_1, arg_88_1.talkMaxDuration)

			if var_91_0 <= arg_88_1.time_ and arg_88_1.time_ < var_91_0 + var_91_8 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_0) / var_91_8

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_0 + var_91_8 and arg_88_1.time_ < var_91_0 + var_91_8 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play411241022 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 411241022
		arg_92_1.duration_ = 5

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play411241023(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1.var_.moveOldPos10058ui_story = arg_92_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_95_0 = 0.001

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_0 then
				arg_92_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos10058ui_story, Vector3.New(0, 100, 0), (arg_92_1.time_ - 0) / var_95_0)
				arg_92_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_92_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_92_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_92_1.actors_["10058ui_story"].transform.position).z)
				arg_92_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_92_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_92_1.actors_["10058ui_story"].transform.localEulerAngles = arg_92_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_92_1.time_ >= 0 + var_95_0 and arg_92_1.time_ < 0 + var_95_0 + arg_95_0 then
				arg_92_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_92_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_92_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_92_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_92_1.actors_["10058ui_story"].transform.position).z)
				arg_92_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_92_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_92_1.actors_["10058ui_story"].transform.localEulerAngles = arg_92_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_95_1 = arg_92_1.actors_["10058ui_story"]

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 and not isNil(var_95_1) and arg_92_1.var_.characterEffect10058ui_story == nil then
				arg_92_1.var_.characterEffect10058ui_story = var_95_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_2 = 0.200000002980232

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_2 and not isNil(var_95_1) then
				if arg_92_1.var_.characterEffect10058ui_story and not isNil(var_95_1) then
					arg_92_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_92_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_92_1.time_ - 0) / var_95_2)
				end
			end

			if arg_92_1.time_ >= 0 + var_95_2 and arg_92_1.time_ < 0 + var_95_2 + arg_95_0 and not isNil(var_95_1) and arg_92_1.var_.characterEffect10058ui_story then
				arg_92_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_92_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_95_3 = 0
			local var_95_4 = 0.625

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_3 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, false)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_5 = arg_92_1:FormatText(arg_92_1:GetWordFromCfg(411241022).content)

				arg_92_1.text_.text = var_95_5

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_7 = 25 <= 0 and var_95_4 or var_95_4 * (utf8.len(var_95_5) / 25)

				if (25 <= 0 and var_95_4 or var_95_4 * (utf8.len(var_95_5) / 25)) > 0 and var_95_4 < var_95_7 then
					arg_92_1.talkMaxDuration = var_95_7

					if var_95_7 + var_95_3 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_7 + var_95_3
					end
				end

				arg_92_1.text_.text = var_95_5
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)
				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_8 = math.max(var_95_4, arg_92_1.talkMaxDuration)

			if var_95_3 <= arg_92_1.time_ and arg_92_1.time_ < var_95_3 + var_95_8 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_3) / var_95_8

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_3 + var_95_8 and arg_92_1.time_ < var_95_3 + var_95_8 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_92_1:InitPlayNodeList()
	end,
	Play411241023 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 411241023
		arg_96_1.duration_ = 4.5

		local var_96_0 = {
			zh = 3.133,
			ja = 4.5
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
				arg_96_0:Play411241024(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = 0.175

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				arg_96_1.leftNameTxt_.text = arg_96_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, true)
				arg_96_1.iconController_:SetSelectedState("hero")

				arg_96_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10025_1")

				arg_96_1.callingController_:SetSelectedState("normal")

				arg_96_1.keyicon_.color = Color.New(1, 1, 1)
				arg_96_1.icon_.color = Color.New(1, 1, 1)

				local var_99_1 = arg_96_1:GetWordFromCfg(411241023)
				local var_99_2 = arg_96_1:FormatText(var_99_1.content)

				arg_96_1.text_.text = var_99_2

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_4 = 7 <= 0 and var_99_0 or var_99_0 * (utf8.len(var_99_2) / 7)

				if (7 <= 0 and var_99_0 or var_99_0 * (utf8.len(var_99_2) / 7)) > 0 and var_99_0 < var_99_4 then
					arg_96_1.talkMaxDuration = var_99_4

					if var_99_4 + 0 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_4 + 0
					end
				end

				arg_96_1.text_.text = var_99_2
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411241", "411241023", "story_v_out_411241.awb") ~= 0 then
					local var_99_5 = manager.audio:GetVoiceLength("story_v_out_411241", "411241023", "story_v_out_411241.awb") / 1000

					if var_99_5 + 0 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_5 + 0
					end

					if var_99_1.prefab_name ~= "" and arg_96_1.actors_[var_99_1.prefab_name] ~= nil then
						local var_99_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_1.prefab_name].transform, "story_v_out_411241", "411241023", "story_v_out_411241.awb")

						arg_96_1:RecordAudio("411241023", var_99_6)
						arg_96_1:RecordAudio("411241023", var_99_6)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_411241", "411241023", "story_v_out_411241.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_411241", "411241023", "story_v_out_411241.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_7 = math.max(var_99_0, arg_96_1.talkMaxDuration)

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_7 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - 0) / var_99_7

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= 0 + var_99_7 and arg_96_1.time_ < 0 + var_99_7 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play411241024 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 411241024
		arg_100_1.duration_ = 4.83

		local var_100_0 = {
			zh = 3.966,
			ja = 4.833
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
				arg_100_0:Play411241025(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1.var_.moveOldPos10058ui_story = arg_100_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_103_0 = 0.001

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_0 then
				arg_100_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPos10058ui_story, Vector3.New(0, -0.98, -6.1), (arg_100_1.time_ - 0) / var_103_0)
				arg_100_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_100_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_100_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_100_1.actors_["10058ui_story"].transform.position).z)
				arg_100_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_100_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_100_1.actors_["10058ui_story"].transform.localEulerAngles = arg_100_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_100_1.time_ >= 0 + var_103_0 and arg_100_1.time_ < 0 + var_103_0 + arg_103_0 then
				arg_100_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_100_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_100_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_100_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_100_1.actors_["10058ui_story"].transform.position).z)
				arg_100_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_100_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_100_1.actors_["10058ui_story"].transform.localEulerAngles = arg_100_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_103_1 = arg_100_1.actors_["10058ui_story"]

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 and not isNil(var_103_1) and arg_100_1.var_.characterEffect10058ui_story == nil then
				arg_100_1.var_.characterEffect10058ui_story = var_103_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_2 = 0.200000002980232

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_2 and not isNil(var_103_1) then
				if arg_100_1.var_.characterEffect10058ui_story and not isNil(var_103_1) then
					arg_100_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_100_1.time_ >= 0 + var_103_2 and arg_100_1.time_ < 0 + var_103_2 + arg_103_0 and not isNil(var_103_1) and arg_100_1.var_.characterEffect10058ui_story then
				arg_100_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action7_1")
			end

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_103_4 = 0
			local var_103_5 = 0.3

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_4 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				arg_100_1.leftNameTxt_.text = arg_100_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_6 = arg_100_1:GetWordFromCfg(411241024)
				local var_103_7 = arg_100_1:FormatText(var_103_6.content)

				arg_100_1.text_.text = var_103_7

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_9 = 12 <= 0 and var_103_5 or var_103_5 * (utf8.len(var_103_7) / 12)

				if (12 <= 0 and var_103_5 or var_103_5 * (utf8.len(var_103_7) / 12)) > 0 and var_103_5 < var_103_9 then
					arg_100_1.talkMaxDuration = var_103_9

					if var_103_9 + var_103_4 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_9 + var_103_4
					end
				end

				arg_100_1.text_.text = var_103_7
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411241", "411241024", "story_v_out_411241.awb") ~= 0 then
					local var_103_10 = manager.audio:GetVoiceLength("story_v_out_411241", "411241024", "story_v_out_411241.awb") / 1000

					if var_103_10 + var_103_4 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_10 + var_103_4
					end

					if var_103_6.prefab_name ~= "" and arg_100_1.actors_[var_103_6.prefab_name] ~= nil then
						local var_103_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_6.prefab_name].transform, "story_v_out_411241", "411241024", "story_v_out_411241.awb")

						arg_100_1:RecordAudio("411241024", var_103_11)
						arg_100_1:RecordAudio("411241024", var_103_11)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_411241", "411241024", "story_v_out_411241.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_411241", "411241024", "story_v_out_411241.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_12 = math.max(var_103_5, arg_100_1.talkMaxDuration)

			if var_103_4 <= arg_100_1.time_ and arg_100_1.time_ < var_103_4 + var_103_12 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_4) / var_103_12

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_4 + var_103_12 and arg_100_1.time_ < var_103_4 + var_103_12 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_100_1:InitPlayNodeList()
	end,
	Play411241025 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 411241025
		arg_104_1.duration_ = 5

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play411241026(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 and not isNil(arg_104_1.actors_["10058ui_story"]) and arg_104_1.var_.characterEffect10058ui_story == nil then
				arg_104_1.var_.characterEffect10058ui_story = arg_104_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_0 = 0.200000002980232

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_0 and not isNil(arg_104_1.actors_["10058ui_story"]) then
				if arg_104_1.var_.characterEffect10058ui_story and not isNil(arg_104_1.actors_["10058ui_story"]) then
					arg_104_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_104_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_104_1.time_ - 0) / var_107_0)
				end
			end

			if arg_104_1.time_ >= 0 + var_107_0 and arg_104_1.time_ < 0 + var_107_0 + arg_107_0 and not isNil(arg_104_1.actors_["10058ui_story"]) and arg_104_1.var_.characterEffect10058ui_story then
				arg_104_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_104_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_107_1 = 0
			local var_107_2 = 1.075

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_1 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, false)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_3 = arg_104_1:FormatText(arg_104_1:GetWordFromCfg(411241025).content)

				arg_104_1.text_.text = var_107_3

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_5 = 43 <= 0 and var_107_2 or var_107_2 * (utf8.len(var_107_3) / 43)

				if (43 <= 0 and var_107_2 or var_107_2 * (utf8.len(var_107_3) / 43)) > 0 and var_107_2 < var_107_5 then
					arg_104_1.talkMaxDuration = var_107_5

					if var_107_5 + var_107_1 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_5 + var_107_1
					end
				end

				arg_104_1.text_.text = var_107_3
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)
				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_6 = math.max(var_107_2, arg_104_1.talkMaxDuration)

			if var_107_1 <= arg_104_1.time_ and arg_104_1.time_ < var_107_1 + var_107_6 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_1) / var_107_6

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_1 + var_107_6 and arg_104_1.time_ < var_107_1 + var_107_6 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play411241026 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 411241026
		arg_108_1.duration_ = 5.9

		local var_108_0 = {
			zh = 5.833,
			ja = 5.9
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
				arg_108_0:Play411241027(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1.var_.moveOldPos10058ui_story = arg_108_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_111_0 = 0.001

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_0 then
				arg_108_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_108_1.var_.moveOldPos10058ui_story, Vector3.New(0, -0.98, -6.1), (arg_108_1.time_ - 0) / var_111_0)
				arg_108_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_108_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_108_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_108_1.actors_["10058ui_story"].transform.position).z)
				arg_108_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_108_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_108_1.actors_["10058ui_story"].transform.localEulerAngles = arg_108_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_108_1.time_ >= 0 + var_111_0 and arg_108_1.time_ < 0 + var_111_0 + arg_111_0 then
				arg_108_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_108_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_108_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_108_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_108_1.actors_["10058ui_story"].transform.position).z)
				arg_108_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_108_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_108_1.actors_["10058ui_story"].transform.localEulerAngles = arg_108_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_111_1 = arg_108_1.actors_["10058ui_story"]

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 and not isNil(var_111_1) and arg_108_1.var_.characterEffect10058ui_story == nil then
				arg_108_1.var_.characterEffect10058ui_story = var_111_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_2 = 0.200000002980232

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_2 and not isNil(var_111_1) then
				if arg_108_1.var_.characterEffect10058ui_story and not isNil(var_111_1) then
					arg_108_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_108_1.time_ >= 0 + var_111_2 and arg_108_1.time_ < 0 + var_111_2 + arg_111_0 and not isNil(var_111_1) and arg_108_1.var_.characterEffect10058ui_story then
				arg_108_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action7_2")
			end

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_111_4 = 0
			local var_111_5 = 0.675

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_4 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				arg_108_1.leftNameTxt_.text = arg_108_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_6 = arg_108_1:GetWordFromCfg(411241026)
				local var_111_7 = arg_108_1:FormatText(var_111_6.content)

				arg_108_1.text_.text = var_111_7

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_9 = 27 <= 0 and var_111_5 or var_111_5 * (utf8.len(var_111_7) / 27)

				if (27 <= 0 and var_111_5 or var_111_5 * (utf8.len(var_111_7) / 27)) > 0 and var_111_5 < var_111_9 then
					arg_108_1.talkMaxDuration = var_111_9

					if var_111_9 + var_111_4 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_9 + var_111_4
					end
				end

				arg_108_1.text_.text = var_111_7
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411241", "411241026", "story_v_out_411241.awb") ~= 0 then
					local var_111_10 = manager.audio:GetVoiceLength("story_v_out_411241", "411241026", "story_v_out_411241.awb") / 1000

					if var_111_10 + var_111_4 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_10 + var_111_4
					end

					if var_111_6.prefab_name ~= "" and arg_108_1.actors_[var_111_6.prefab_name] ~= nil then
						local var_111_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_6.prefab_name].transform, "story_v_out_411241", "411241026", "story_v_out_411241.awb")

						arg_108_1:RecordAudio("411241026", var_111_11)
						arg_108_1:RecordAudio("411241026", var_111_11)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_411241", "411241026", "story_v_out_411241.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_411241", "411241026", "story_v_out_411241.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_12 = math.max(var_111_5, arg_108_1.talkMaxDuration)

			if var_111_4 <= arg_108_1.time_ and arg_108_1.time_ < var_111_4 + var_111_12 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_4) / var_111_12

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_4 + var_111_12 and arg_108_1.time_ < var_111_4 + var_111_12 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_108_1:InitPlayNodeList()
	end,
	Play411241027 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 411241027
		arg_112_1.duration_ = 5

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play411241028(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 and not isNil(arg_112_1.actors_["10058ui_story"]) and arg_112_1.var_.characterEffect10058ui_story == nil then
				arg_112_1.var_.characterEffect10058ui_story = arg_112_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_0 = 0.200000002980232

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_0 and not isNil(arg_112_1.actors_["10058ui_story"]) then
				if arg_112_1.var_.characterEffect10058ui_story and not isNil(arg_112_1.actors_["10058ui_story"]) then
					arg_112_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_112_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_112_1.time_ - 0) / var_115_0)
				end
			end

			if arg_112_1.time_ >= 0 + var_115_0 and arg_112_1.time_ < 0 + var_115_0 + arg_115_0 and not isNil(arg_112_1.actors_["10058ui_story"]) and arg_112_1.var_.characterEffect10058ui_story then
				arg_112_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_112_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_115_1 = 0
			local var_115_2 = 0.675

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_1 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, false)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_3 = arg_112_1:FormatText(arg_112_1:GetWordFromCfg(411241027).content)

				arg_112_1.text_.text = var_115_3

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_5 = 27 <= 0 and var_115_2 or var_115_2 * (utf8.len(var_115_3) / 27)

				if (27 <= 0 and var_115_2 or var_115_2 * (utf8.len(var_115_3) / 27)) > 0 and var_115_2 < var_115_5 then
					arg_112_1.talkMaxDuration = var_115_5

					if var_115_5 + var_115_1 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_5 + var_115_1
					end
				end

				arg_112_1.text_.text = var_115_3
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)
				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_6 = math.max(var_115_2, arg_112_1.talkMaxDuration)

			if var_115_1 <= arg_112_1.time_ and arg_112_1.time_ < var_115_1 + var_115_6 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_1) / var_115_6

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_1 + var_115_6 and arg_112_1.time_ < var_115_1 + var_115_6 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play411241028 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 411241028
		arg_116_1.duration_ = 2.27

		local var_116_0 = {
			zh = 2.266,
			ja = 1.5
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
				arg_116_0:Play411241029(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = 0.05

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				arg_116_1.leftNameTxt_.text = arg_116_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, true)
				arg_116_1.iconController_:SetSelectedState("hero")

				arg_116_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10025_1")

				arg_116_1.callingController_:SetSelectedState("normal")

				arg_116_1.keyicon_.color = Color.New(1, 1, 1)
				arg_116_1.icon_.color = Color.New(1, 1, 1)

				local var_119_1 = arg_116_1:GetWordFromCfg(411241028)
				local var_119_2 = arg_116_1:FormatText(var_119_1.content)

				arg_116_1.text_.text = var_119_2

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_4 = 2 <= 0 and var_119_0 or var_119_0 * (utf8.len(var_119_2) / 2)

				if (2 <= 0 and var_119_0 or var_119_0 * (utf8.len(var_119_2) / 2)) > 0 and var_119_0 < var_119_4 then
					arg_116_1.talkMaxDuration = var_119_4

					if var_119_4 + 0 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_4 + 0
					end
				end

				arg_116_1.text_.text = var_119_2
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411241", "411241028", "story_v_out_411241.awb") ~= 0 then
					local var_119_5 = manager.audio:GetVoiceLength("story_v_out_411241", "411241028", "story_v_out_411241.awb") / 1000

					if var_119_5 + 0 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_5 + 0
					end

					if var_119_1.prefab_name ~= "" and arg_116_1.actors_[var_119_1.prefab_name] ~= nil then
						local var_119_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_1.prefab_name].transform, "story_v_out_411241", "411241028", "story_v_out_411241.awb")

						arg_116_1:RecordAudio("411241028", var_119_6)
						arg_116_1:RecordAudio("411241028", var_119_6)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_411241", "411241028", "story_v_out_411241.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_411241", "411241028", "story_v_out_411241.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_7 = math.max(var_119_0, arg_116_1.talkMaxDuration)

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_7 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - 0) / var_119_7

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= 0 + var_119_7 and arg_116_1.time_ < 0 + var_119_7 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play411241029 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 411241029
		arg_120_1.duration_ = 4.47

		local var_120_0 = {
			zh = 2.4,
			ja = 4.466
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
				arg_120_0:Play411241030(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 and not isNil(arg_120_1.actors_["10058ui_story"]) and arg_120_1.var_.characterEffect10058ui_story == nil then
				arg_120_1.var_.characterEffect10058ui_story = arg_120_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_0 = 0.200000002980232

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_0 and not isNil(arg_120_1.actors_["10058ui_story"]) then
				if arg_120_1.var_.characterEffect10058ui_story and not isNil(arg_120_1.actors_["10058ui_story"]) then
					arg_120_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_120_1.time_ >= 0 + var_123_0 and arg_120_1.time_ < 0 + var_123_0 + arg_123_0 and not isNil(arg_120_1.actors_["10058ui_story"]) and arg_120_1.var_.characterEffect10058ui_story then
				arg_120_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_123_2 = 0
			local var_123_3 = 0.175

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_2 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				arg_120_1.leftNameTxt_.text = arg_120_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_4 = arg_120_1:GetWordFromCfg(411241029)
				local var_123_5 = arg_120_1:FormatText(var_123_4.content)

				arg_120_1.text_.text = var_123_5

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_7 = 7 <= 0 and var_123_3 or var_123_3 * (utf8.len(var_123_5) / 7)

				if (7 <= 0 and var_123_3 or var_123_3 * (utf8.len(var_123_5) / 7)) > 0 and var_123_3 < var_123_7 then
					arg_120_1.talkMaxDuration = var_123_7

					if var_123_7 + var_123_2 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_7 + var_123_2
					end
				end

				arg_120_1.text_.text = var_123_5
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411241", "411241029", "story_v_out_411241.awb") ~= 0 then
					local var_123_8 = manager.audio:GetVoiceLength("story_v_out_411241", "411241029", "story_v_out_411241.awb") / 1000

					if var_123_8 + var_123_2 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_8 + var_123_2
					end

					if var_123_4.prefab_name ~= "" and arg_120_1.actors_[var_123_4.prefab_name] ~= nil then
						local var_123_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_4.prefab_name].transform, "story_v_out_411241", "411241029", "story_v_out_411241.awb")

						arg_120_1:RecordAudio("411241029", var_123_9)
						arg_120_1:RecordAudio("411241029", var_123_9)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_411241", "411241029", "story_v_out_411241.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_411241", "411241029", "story_v_out_411241.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_10 = math.max(var_123_3, arg_120_1.talkMaxDuration)

			if var_123_2 <= arg_120_1.time_ and arg_120_1.time_ < var_123_2 + var_123_10 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_2) / var_123_10

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_2 + var_123_10 and arg_120_1.time_ < var_123_2 + var_123_10 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play411241030 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 411241030
		arg_124_1.duration_ = 5

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play411241031(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 and not isNil(arg_124_1.actors_["10058ui_story"]) and arg_124_1.var_.characterEffect10058ui_story == nil then
				arg_124_1.var_.characterEffect10058ui_story = arg_124_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_0 = 0.200000002980232

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_0 and not isNil(arg_124_1.actors_["10058ui_story"]) then
				if arg_124_1.var_.characterEffect10058ui_story and not isNil(arg_124_1.actors_["10058ui_story"]) then
					arg_124_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_124_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_124_1.time_ - 0) / var_127_0)
				end
			end

			if arg_124_1.time_ >= 0 + var_127_0 and arg_124_1.time_ < 0 + var_127_0 + arg_127_0 and not isNil(arg_124_1.actors_["10058ui_story"]) and arg_124_1.var_.characterEffect10058ui_story then
				arg_124_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_124_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_127_1 = 0
			local var_127_2 = 0.7

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_1 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, false)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_3 = arg_124_1:FormatText(arg_124_1:GetWordFromCfg(411241030).content)

				arg_124_1.text_.text = var_127_3

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_5 = 28 <= 0 and var_127_2 or var_127_2 * (utf8.len(var_127_3) / 28)

				if (28 <= 0 and var_127_2 or var_127_2 * (utf8.len(var_127_3) / 28)) > 0 and var_127_2 < var_127_5 then
					arg_124_1.talkMaxDuration = var_127_5

					if var_127_5 + var_127_1 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_5 + var_127_1
					end
				end

				arg_124_1.text_.text = var_127_3
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)
				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_6 = math.max(var_127_2, arg_124_1.talkMaxDuration)

			if var_127_1 <= arg_124_1.time_ and arg_124_1.time_ < var_127_1 + var_127_6 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_1) / var_127_6

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_1 + var_127_6 and arg_124_1.time_ < var_127_1 + var_127_6 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play411241031 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 411241031
		arg_128_1.duration_ = 3.17

		local var_128_0 = {
			zh = 3.166,
			ja = 2.266
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
				arg_128_0:Play411241032(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = 0.075

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				arg_128_1.leftNameTxt_.text = arg_128_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, true)
				arg_128_1.iconController_:SetSelectedState("hero")

				arg_128_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10025_1")

				arg_128_1.callingController_:SetSelectedState("normal")

				arg_128_1.keyicon_.color = Color.New(1, 1, 1)
				arg_128_1.icon_.color = Color.New(1, 1, 1)

				local var_131_1 = arg_128_1:GetWordFromCfg(411241031)
				local var_131_2 = arg_128_1:FormatText(var_131_1.content)

				arg_128_1.text_.text = var_131_2

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_4 = 3 <= 0 and var_131_0 or var_131_0 * (utf8.len(var_131_2) / 3)

				if (3 <= 0 and var_131_0 or var_131_0 * (utf8.len(var_131_2) / 3)) > 0 and var_131_0 < var_131_4 then
					arg_128_1.talkMaxDuration = var_131_4

					if var_131_4 + 0 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_4 + 0
					end
				end

				arg_128_1.text_.text = var_131_2
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411241", "411241031", "story_v_out_411241.awb") ~= 0 then
					local var_131_5 = manager.audio:GetVoiceLength("story_v_out_411241", "411241031", "story_v_out_411241.awb") / 1000

					if var_131_5 + 0 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_5 + 0
					end

					if var_131_1.prefab_name ~= "" and arg_128_1.actors_[var_131_1.prefab_name] ~= nil then
						local var_131_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_1.prefab_name].transform, "story_v_out_411241", "411241031", "story_v_out_411241.awb")

						arg_128_1:RecordAudio("411241031", var_131_6)
						arg_128_1:RecordAudio("411241031", var_131_6)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_411241", "411241031", "story_v_out_411241.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_411241", "411241031", "story_v_out_411241.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_7 = math.max(var_131_0, arg_128_1.talkMaxDuration)

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_7 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - 0) / var_131_7

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= 0 + var_131_7 and arg_128_1.time_ < 0 + var_131_7 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play411241032 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 411241032
		arg_132_1.duration_ = 5

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play411241033(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = 0.8

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, false)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_1 = arg_132_1:FormatText(arg_132_1:GetWordFromCfg(411241032).content)

				arg_132_1.text_.text = var_135_1

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_3 = 64 <= 0 and var_135_0 or var_135_0 * (utf8.len(var_135_1) / 64)

				if (64 <= 0 and var_135_0 or var_135_0 * (utf8.len(var_135_1) / 64)) > 0 and var_135_0 < var_135_3 then
					arg_132_1.talkMaxDuration = var_135_3

					if var_135_3 + 0 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_3 + 0
					end
				end

				arg_132_1.text_.text = var_135_1
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)
				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_4 = math.max(var_135_0, arg_132_1.talkMaxDuration)

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_4 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - 0) / var_135_4

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= 0 + var_135_4 and arg_132_1.time_ < 0 + var_135_4 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play411241033 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 411241033
		arg_136_1.duration_ = 2

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play411241034(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1.var_.moveOldPos10058ui_story = arg_136_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_139_0 = 0.001

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_0 then
				arg_136_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos10058ui_story, Vector3.New(0, -0.98, -6.1), (arg_136_1.time_ - 0) / var_139_0)
				arg_136_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_136_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_136_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_136_1.actors_["10058ui_story"].transform.position).z)
				arg_136_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_136_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_136_1.actors_["10058ui_story"].transform.localEulerAngles = arg_136_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_136_1.time_ >= 0 + var_139_0 and arg_136_1.time_ < 0 + var_139_0 + arg_139_0 then
				arg_136_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_136_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_136_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_136_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_136_1.actors_["10058ui_story"].transform.position).z)
				arg_136_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_136_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_136_1.actors_["10058ui_story"].transform.localEulerAngles = arg_136_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_139_1 = arg_136_1.actors_["10058ui_story"]

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 and not isNil(var_139_1) and arg_136_1.var_.characterEffect10058ui_story == nil then
				arg_136_1.var_.characterEffect10058ui_story = var_139_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_2 = 0.200000002980232

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_2 and not isNil(var_139_1) then
				if arg_136_1.var_.characterEffect10058ui_story and not isNil(var_139_1) then
					arg_136_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_136_1.time_ >= 0 + var_139_2 and arg_136_1.time_ < 0 + var_139_2 + arg_139_0 and not isNil(var_139_1) and arg_136_1.var_.characterEffect10058ui_story then
				arg_136_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action4_1")
			end

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_139_4 = 0
			local var_139_5 = 0.1

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_4 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				arg_136_1.leftNameTxt_.text = arg_136_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_6 = arg_136_1:GetWordFromCfg(411241033)
				local var_139_7 = arg_136_1:FormatText(var_139_6.content)

				arg_136_1.text_.text = var_139_7

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_9 = 4 <= 0 and var_139_5 or var_139_5 * (utf8.len(var_139_7) / 4)

				if (4 <= 0 and var_139_5 or var_139_5 * (utf8.len(var_139_7) / 4)) > 0 and var_139_5 < var_139_9 then
					arg_136_1.talkMaxDuration = var_139_9

					if var_139_9 + var_139_4 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_9 + var_139_4
					end
				end

				arg_136_1.text_.text = var_139_7
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411241", "411241033", "story_v_out_411241.awb") ~= 0 then
					local var_139_10 = manager.audio:GetVoiceLength("story_v_out_411241", "411241033", "story_v_out_411241.awb") / 1000

					if var_139_10 + var_139_4 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_10 + var_139_4
					end

					if var_139_6.prefab_name ~= "" and arg_136_1.actors_[var_139_6.prefab_name] ~= nil then
						local var_139_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_6.prefab_name].transform, "story_v_out_411241", "411241033", "story_v_out_411241.awb")

						arg_136_1:RecordAudio("411241033", var_139_11)
						arg_136_1:RecordAudio("411241033", var_139_11)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_411241", "411241033", "story_v_out_411241.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_411241", "411241033", "story_v_out_411241.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_12 = math.max(var_139_5, arg_136_1.talkMaxDuration)

			if var_139_4 <= arg_136_1.time_ and arg_136_1.time_ < var_139_4 + var_139_12 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_4) / var_139_12

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_4 + var_139_12 and arg_136_1.time_ < var_139_4 + var_139_12 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_136_1:InitPlayNodeList()
	end,
	Play411241034 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 411241034
		arg_140_1.duration_ = 5

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play411241035(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 and not isNil(arg_140_1.actors_["10058ui_story"]) and arg_140_1.var_.characterEffect10058ui_story == nil then
				arg_140_1.var_.characterEffect10058ui_story = arg_140_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_0 = 0.200000002980232

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_0 and not isNil(arg_140_1.actors_["10058ui_story"]) then
				if arg_140_1.var_.characterEffect10058ui_story and not isNil(arg_140_1.actors_["10058ui_story"]) then
					arg_140_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_140_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_140_1.time_ - 0) / var_143_0)
				end
			end

			if arg_140_1.time_ >= 0 + var_143_0 and arg_140_1.time_ < 0 + var_143_0 + arg_143_0 and not isNil(arg_140_1.actors_["10058ui_story"]) and arg_140_1.var_.characterEffect10058ui_story then
				arg_140_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_140_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_143_1 = 0
			local var_143_2 = 0.95

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_1 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, false)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_3 = arg_140_1:FormatText(arg_140_1:GetWordFromCfg(411241034).content)

				arg_140_1.text_.text = var_143_3

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_5 = 38 <= 0 and var_143_2 or var_143_2 * (utf8.len(var_143_3) / 38)

				if (38 <= 0 and var_143_2 or var_143_2 * (utf8.len(var_143_3) / 38)) > 0 and var_143_2 < var_143_5 then
					arg_140_1.talkMaxDuration = var_143_5

					if var_143_5 + var_143_1 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_5 + var_143_1
					end
				end

				arg_140_1.text_.text = var_143_3
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)
				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_6 = math.max(var_143_2, arg_140_1.talkMaxDuration)

			if var_143_1 <= arg_140_1.time_ and arg_140_1.time_ < var_143_1 + var_143_6 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_1) / var_143_6

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_1 + var_143_6 and arg_140_1.time_ < var_143_1 + var_143_6 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play411241035 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 411241035
		arg_144_1.duration_ = 5.7

		local var_144_0 = {
			zh = 1.999999999999,
			ja = 5.7
		}
		local var_144_1 = manager.audio:GetLocalizationFlag()

		if var_144_0[var_144_1] ~= nil then
			arg_144_1.duration_ = var_144_0[var_144_1]
		end

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play411241036(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 and not isNil(arg_144_1.actors_["10058ui_story"]) and arg_144_1.var_.characterEffect10058ui_story == nil then
				arg_144_1.var_.characterEffect10058ui_story = arg_144_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_0 = 0.200000002980232

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_0 and not isNil(arg_144_1.actors_["10058ui_story"]) then
				if arg_144_1.var_.characterEffect10058ui_story and not isNil(arg_144_1.actors_["10058ui_story"]) then
					arg_144_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_144_1.time_ >= 0 + var_147_0 and arg_144_1.time_ < 0 + var_147_0 + arg_147_0 and not isNil(arg_144_1.actors_["10058ui_story"]) and arg_144_1.var_.characterEffect10058ui_story then
				arg_144_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action4_2")
			end

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_147_2 = 0
			local var_147_3 = 0.275

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= var_147_2 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				arg_144_1.leftNameTxt_.text = arg_144_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_4 = arg_144_1:GetWordFromCfg(411241035)
				local var_147_5 = arg_144_1:FormatText(var_147_4.content)

				arg_144_1.text_.text = var_147_5

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_7 = 11 <= 0 and var_147_3 or var_147_3 * (utf8.len(var_147_5) / 11)

				if (11 <= 0 and var_147_3 or var_147_3 * (utf8.len(var_147_5) / 11)) > 0 and var_147_3 < var_147_7 then
					arg_144_1.talkMaxDuration = var_147_7

					if var_147_7 + var_147_2 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_7 + var_147_2
					end
				end

				arg_144_1.text_.text = var_147_5
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411241", "411241035", "story_v_out_411241.awb") ~= 0 then
					local var_147_8 = manager.audio:GetVoiceLength("story_v_out_411241", "411241035", "story_v_out_411241.awb") / 1000

					if var_147_8 + var_147_2 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_8 + var_147_2
					end

					if var_147_4.prefab_name ~= "" and arg_144_1.actors_[var_147_4.prefab_name] ~= nil then
						local var_147_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_4.prefab_name].transform, "story_v_out_411241", "411241035", "story_v_out_411241.awb")

						arg_144_1:RecordAudio("411241035", var_147_9)
						arg_144_1:RecordAudio("411241035", var_147_9)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_411241", "411241035", "story_v_out_411241.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_411241", "411241035", "story_v_out_411241.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_10 = math.max(var_147_3, arg_144_1.talkMaxDuration)

			if var_147_2 <= arg_144_1.time_ and arg_144_1.time_ < var_147_2 + var_147_10 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_2) / var_147_10

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_2 + var_147_10 and arg_144_1.time_ < var_147_2 + var_147_10 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play411241036 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 411241036
		arg_148_1.duration_ = 1.5

		local var_148_0 = {
			zh = 1.5,
			ja = 1.266
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
				arg_148_0:Play411241037(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 and not isNil(arg_148_1.actors_["10058ui_story"]) and arg_148_1.var_.characterEffect10058ui_story == nil then
				arg_148_1.var_.characterEffect10058ui_story = arg_148_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_0 = 0.200000002980232

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_0 and not isNil(arg_148_1.actors_["10058ui_story"]) then
				if arg_148_1.var_.characterEffect10058ui_story and not isNil(arg_148_1.actors_["10058ui_story"]) then
					arg_148_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_148_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_148_1.time_ - 0) / var_151_0)
				end
			end

			if arg_148_1.time_ >= 0 + var_151_0 and arg_148_1.time_ < 0 + var_151_0 + arg_151_0 and not isNil(arg_148_1.actors_["10058ui_story"]) and arg_148_1.var_.characterEffect10058ui_story then
				arg_148_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_148_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_151_1 = 0
			local var_151_2 = 0.1

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= var_151_1 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				arg_148_1.leftNameTxt_.text = arg_148_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, true)
				arg_148_1.iconController_:SetSelectedState("hero")

				arg_148_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10025_1")

				arg_148_1.callingController_:SetSelectedState("normal")

				arg_148_1.keyicon_.color = Color.New(1, 1, 1)
				arg_148_1.icon_.color = Color.New(1, 1, 1)

				local var_151_3 = arg_148_1:GetWordFromCfg(411241036)
				local var_151_4 = arg_148_1:FormatText(var_151_3.content)

				arg_148_1.text_.text = var_151_4

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_6 = 4 <= 0 and var_151_2 or var_151_2 * (utf8.len(var_151_4) / 4)

				if (4 <= 0 and var_151_2 or var_151_2 * (utf8.len(var_151_4) / 4)) > 0 and var_151_2 < var_151_6 then
					arg_148_1.talkMaxDuration = var_151_6

					if var_151_6 + var_151_1 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_6 + var_151_1
					end
				end

				arg_148_1.text_.text = var_151_4
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411241", "411241036", "story_v_out_411241.awb") ~= 0 then
					local var_151_7 = manager.audio:GetVoiceLength("story_v_out_411241", "411241036", "story_v_out_411241.awb") / 1000

					if var_151_7 + var_151_1 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_7 + var_151_1
					end

					if var_151_3.prefab_name ~= "" and arg_148_1.actors_[var_151_3.prefab_name] ~= nil then
						local var_151_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_3.prefab_name].transform, "story_v_out_411241", "411241036", "story_v_out_411241.awb")

						arg_148_1:RecordAudio("411241036", var_151_8)
						arg_148_1:RecordAudio("411241036", var_151_8)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_out_411241", "411241036", "story_v_out_411241.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_out_411241", "411241036", "story_v_out_411241.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_9 = math.max(var_151_2, arg_148_1.talkMaxDuration)

			if var_151_1 <= arg_148_1.time_ and arg_148_1.time_ < var_151_1 + var_151_9 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_1) / var_151_9

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_1 + var_151_9 and arg_148_1.time_ < var_151_1 + var_151_9 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {}

		arg_148_1:InitPlayNodeList()
	end,
	Play411241037 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 411241037
		arg_152_1.duration_ = 9

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play411241038(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1.mask_.enabled = true
				arg_152_1.mask_.raycastTarget = true

				arg_152_1:SetGaussion(false)
			end

			local var_155_0 = 2

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_0 then
				local var_155_1 = Color.New(0.009433985, 0.009433985, 0.009433985)

				var_155_1.a = Mathf.Lerp(0, 1, (arg_152_1.time_ - 0) / var_155_0)
				arg_152_1.mask_.color = var_155_1
			end

			if arg_152_1.time_ >= 0 + var_155_0 and arg_152_1.time_ < 0 + var_155_0 + arg_155_0 then
				local var_155_2 = Color.New(0.009433985, 0.009433985, 0.009433985)

				var_155_2.a = 1
				arg_152_1.mask_.color = var_155_2
			end

			local var_155_3 = 2

			if 2 < arg_152_1.time_ and arg_152_1.time_ <= var_155_3 + arg_155_0 then
				arg_152_1.mask_.enabled = true
				arg_152_1.mask_.raycastTarget = true

				arg_152_1:SetGaussion(false)
			end

			local var_155_4 = 2

			if var_155_3 <= arg_152_1.time_ and arg_152_1.time_ < var_155_3 + var_155_4 then
				local var_155_5 = Color.New(0.009433985, 0.009433985, 0.009433985)

				var_155_5.a = Mathf.Lerp(1, 0, (arg_152_1.time_ - var_155_3) / var_155_4)
				arg_152_1.mask_.color = var_155_5
			end

			if arg_152_1.time_ >= var_155_3 + var_155_4 and arg_152_1.time_ < var_155_3 + var_155_4 + arg_155_0 then
				local var_155_6 = Color.New(0.009433985, 0.009433985, 0.009433985)

				arg_152_1.mask_.enabled = false
				var_155_6.a = 0
				arg_152_1.mask_.color = var_155_6
			end

			if 2 < arg_152_1.time_ and arg_152_1.time_ <= 2 + arg_155_0 then
				arg_152_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 2 < arg_152_1.time_ and arg_152_1.time_ <= 2 + arg_155_0 then
				arg_152_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_155_7 = arg_152_1.actors_["10058ui_story"].transform

			if 1.966 < arg_152_1.time_ and arg_152_1.time_ <= 1.966 + arg_155_0 then
				arg_152_1.var_.moveOldPos10058ui_story = var_155_7.localPosition
			end

			local var_155_8 = 0.001

			if 1.966 <= arg_152_1.time_ and arg_152_1.time_ < 1.966 + var_155_8 then
				var_155_7.localPosition = Vector3.Lerp(arg_152_1.var_.moveOldPos10058ui_story, Vector3.New(0, 100, 0), (arg_152_1.time_ - 1.966) / var_155_8)
				var_155_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_155_7.position).x, (manager.ui.mainCamera.transform.position - var_155_7.position).y, (manager.ui.mainCamera.transform.position - var_155_7.position).z)
				var_155_7.localEulerAngles.z = 0
				var_155_7.localEulerAngles.x = 0
				var_155_7.localEulerAngles = var_155_7.localEulerAngles
			end

			if arg_152_1.time_ >= 1.966 + var_155_8 and arg_152_1.time_ < 1.966 + var_155_8 + arg_155_0 then
				var_155_7.localPosition = Vector3.New(0, 100, 0)
				var_155_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_155_7.position).x, (manager.ui.mainCamera.transform.position - var_155_7.position).y, (manager.ui.mainCamera.transform.position - var_155_7.position).z)
				var_155_7.localEulerAngles.z = 0
				var_155_7.localEulerAngles.x = 0
				var_155_7.localEulerAngles = var_155_7.localEulerAngles
			end

			if arg_152_1.frameCnt_ <= 1 then
				arg_152_1.dialog_:SetActive(false)
			end

			local var_155_9 = 4
			local var_155_10 = 0.975

			if 4 < arg_152_1.time_ and arg_152_1.time_ <= var_155_9 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0

				arg_152_1.dialog_:SetActive(true)

				arg_152_1.dialogCg_.alpha = 0

				local var_155_11 = LeanTween.value(arg_152_1.dialog_, 0, 1, 0.3)

				var_155_11:setOnUpdate(LuaHelper.FloatAction(function(arg_156_0)
					arg_152_1.dialogCg_.alpha = arg_156_0
				end))
				var_155_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_152_1.dialog_)
					var_155_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_152_1.duration_ = arg_152_1.duration_ + 0.3

				SetActive(arg_152_1.leftNameGo_, false)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_12 = arg_152_1:FormatText(arg_152_1:GetWordFromCfg(411241037).content)

				arg_152_1.text_.text = var_155_12

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_14 = 39 <= 0 and var_155_10 or var_155_10 * (utf8.len(var_155_12) / 39)

				if (39 <= 0 and var_155_10 or var_155_10 * (utf8.len(var_155_12) / 39)) > 0 and var_155_10 < var_155_14 then
					arg_152_1.talkMaxDuration = var_155_14
					var_155_9 = var_155_9 + 0.3

					if var_155_14 + var_155_9 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_14 + var_155_9
					end
				end

				arg_152_1.text_.text = var_155_12
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)
				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_15 = var_155_9 + 0.3
			local var_155_16 = math.max(var_155_10, arg_152_1.talkMaxDuration)

			if var_155_9 + 0.3 <= arg_152_1.time_ and arg_152_1.time_ < var_155_15 + var_155_16 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_15) / var_155_16

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_15 + var_155_16 and arg_152_1.time_ < var_155_15 + var_155_16 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_152_1:InitPlayNodeList()
	end,
	Play411241038 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 411241038
		arg_158_1.duration_ = 3.17

		local var_158_0 = {
			zh = 2.633,
			ja = 3.166
		}
		local var_158_1 = manager.audio:GetLocalizationFlag()

		if var_158_0[var_158_1] ~= nil then
			arg_158_1.duration_ = var_158_0[var_158_1]
		end

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play411241039(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 and not isNil(arg_158_1.actors_["10058ui_story"]) and arg_158_1.var_.characterEffect10058ui_story == nil then
				arg_158_1.var_.characterEffect10058ui_story = arg_158_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_161_0 = 0.200000002980232

			if 0 <= arg_158_1.time_ and arg_158_1.time_ < 0 + var_161_0 and not isNil(arg_158_1.actors_["10058ui_story"]) then
				if arg_158_1.var_.characterEffect10058ui_story and not isNil(arg_158_1.actors_["10058ui_story"]) then
					arg_158_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_158_1.time_ >= 0 + var_161_0 and arg_158_1.time_ < 0 + var_161_0 + arg_161_0 and not isNil(arg_158_1.actors_["10058ui_story"]) and arg_158_1.var_.characterEffect10058ui_story then
				arg_158_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_161_2 = arg_158_1.actors_["10058ui_story"].transform

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 then
				arg_158_1.var_.moveOldPos10058ui_story = var_161_2.localPosition
			end

			local var_161_3 = 0.001

			if 0 <= arg_158_1.time_ and arg_158_1.time_ < 0 + var_161_3 then
				var_161_2.localPosition = Vector3.Lerp(arg_158_1.var_.moveOldPos10058ui_story, Vector3.New(0, -0.98, -6.1), (arg_158_1.time_ - 0) / var_161_3)
				var_161_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_161_2.position).x, (manager.ui.mainCamera.transform.position - var_161_2.position).y, (manager.ui.mainCamera.transform.position - var_161_2.position).z)
				var_161_2.localEulerAngles.z = 0
				var_161_2.localEulerAngles.x = 0
				var_161_2.localEulerAngles = var_161_2.localEulerAngles
			end

			if arg_158_1.time_ >= 0 + var_161_3 and arg_158_1.time_ < 0 + var_161_3 + arg_161_0 then
				var_161_2.localPosition = Vector3.New(0, -0.98, -6.1)
				var_161_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_161_2.position).x, (manager.ui.mainCamera.transform.position - var_161_2.position).y, (manager.ui.mainCamera.transform.position - var_161_2.position).z)
				var_161_2.localEulerAngles.z = 0
				var_161_2.localEulerAngles.x = 0
				var_161_2.localEulerAngles = var_161_2.localEulerAngles
			end

			local var_161_4 = 0
			local var_161_5 = 0.35

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= var_161_4 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, true)

				arg_158_1.leftNameTxt_.text = arg_158_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_158_1.leftNameTxt_.transform)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1.leftNameTxt_.text)
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_6 = arg_158_1:GetWordFromCfg(411241038)
				local var_161_7 = arg_158_1:FormatText(var_161_6.content)

				arg_158_1.text_.text = var_161_7

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_9 = 14 <= 0 and var_161_5 or var_161_5 * (utf8.len(var_161_7) / 14)

				if (14 <= 0 and var_161_5 or var_161_5 * (utf8.len(var_161_7) / 14)) > 0 and var_161_5 < var_161_9 then
					arg_158_1.talkMaxDuration = var_161_9

					if var_161_9 + var_161_4 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_9 + var_161_4
					end
				end

				arg_158_1.text_.text = var_161_7
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411241", "411241038", "story_v_out_411241.awb") ~= 0 then
					local var_161_10 = manager.audio:GetVoiceLength("story_v_out_411241", "411241038", "story_v_out_411241.awb") / 1000

					if var_161_10 + var_161_4 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_10 + var_161_4
					end

					if var_161_6.prefab_name ~= "" and arg_158_1.actors_[var_161_6.prefab_name] ~= nil then
						local var_161_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_158_1.actors_[var_161_6.prefab_name].transform, "story_v_out_411241", "411241038", "story_v_out_411241.awb")

						arg_158_1:RecordAudio("411241038", var_161_11)
						arg_158_1:RecordAudio("411241038", var_161_11)
					else
						arg_158_1:AudioAction("play", "voice", "story_v_out_411241", "411241038", "story_v_out_411241.awb")
					end

					arg_158_1:RecordHistoryTalkVoice("story_v_out_411241", "411241038", "story_v_out_411241.awb")
				end

				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_12 = math.max(var_161_5, arg_158_1.talkMaxDuration)

			if var_161_4 <= arg_158_1.time_ and arg_158_1.time_ < var_161_4 + var_161_12 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_4) / var_161_12

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_4 + var_161_12 and arg_158_1.time_ < var_161_4 + var_161_12 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_158_1:InitPlayNodeList()
	end,
	Play411241039 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 411241039
		arg_162_1.duration_ = 2.73

		local var_162_0 = {
			zh = 2.733,
			ja = 1.133
		}
		local var_162_1 = manager.audio:GetLocalizationFlag()

		if var_162_0[var_162_1] ~= nil then
			arg_162_1.duration_ = var_162_0[var_162_1]
		end

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play411241040(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 and not isNil(arg_162_1.actors_["10058ui_story"]) and arg_162_1.var_.characterEffect10058ui_story == nil then
				arg_162_1.var_.characterEffect10058ui_story = arg_162_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_165_0 = 0.200000002980232

			if 0 <= arg_162_1.time_ and arg_162_1.time_ < 0 + var_165_0 and not isNil(arg_162_1.actors_["10058ui_story"]) then
				if arg_162_1.var_.characterEffect10058ui_story and not isNil(arg_162_1.actors_["10058ui_story"]) then
					arg_162_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_162_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_162_1.time_ - 0) / var_165_0)
				end
			end

			if arg_162_1.time_ >= 0 + var_165_0 and arg_162_1.time_ < 0 + var_165_0 + arg_165_0 and not isNil(arg_162_1.actors_["10058ui_story"]) and arg_162_1.var_.characterEffect10058ui_story then
				arg_162_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_162_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_165_1 = 0
			local var_165_2 = 0.15

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= var_165_1 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, true)

				arg_162_1.leftNameTxt_.text = arg_162_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_162_1.leftNameTxt_.transform)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1.leftNameTxt_.text)
				SetActive(arg_162_1.iconTrs_.gameObject, true)
				arg_162_1.iconController_:SetSelectedState("hero")

				arg_162_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10025_1")

				arg_162_1.callingController_:SetSelectedState("normal")

				arg_162_1.keyicon_.color = Color.New(1, 1, 1)
				arg_162_1.icon_.color = Color.New(1, 1, 1)

				local var_165_3 = arg_162_1:GetWordFromCfg(411241039)
				local var_165_4 = arg_162_1:FormatText(var_165_3.content)

				arg_162_1.text_.text = var_165_4

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_6 = 6 <= 0 and var_165_2 or var_165_2 * (utf8.len(var_165_4) / 6)

				if (6 <= 0 and var_165_2 or var_165_2 * (utf8.len(var_165_4) / 6)) > 0 and var_165_2 < var_165_6 then
					arg_162_1.talkMaxDuration = var_165_6

					if var_165_6 + var_165_1 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_6 + var_165_1
					end
				end

				arg_162_1.text_.text = var_165_4
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411241", "411241039", "story_v_out_411241.awb") ~= 0 then
					local var_165_7 = manager.audio:GetVoiceLength("story_v_out_411241", "411241039", "story_v_out_411241.awb") / 1000

					if var_165_7 + var_165_1 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_7 + var_165_1
					end

					if var_165_3.prefab_name ~= "" and arg_162_1.actors_[var_165_3.prefab_name] ~= nil then
						local var_165_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_162_1.actors_[var_165_3.prefab_name].transform, "story_v_out_411241", "411241039", "story_v_out_411241.awb")

						arg_162_1:RecordAudio("411241039", var_165_8)
						arg_162_1:RecordAudio("411241039", var_165_8)
					else
						arg_162_1:AudioAction("play", "voice", "story_v_out_411241", "411241039", "story_v_out_411241.awb")
					end

					arg_162_1:RecordHistoryTalkVoice("story_v_out_411241", "411241039", "story_v_out_411241.awb")
				end

				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_9 = math.max(var_165_2, arg_162_1.talkMaxDuration)

			if var_165_1 <= arg_162_1.time_ and arg_162_1.time_ < var_165_1 + var_165_9 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_1) / var_165_9

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_1 + var_165_9 and arg_162_1.time_ < var_165_1 + var_165_9 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {}

		arg_162_1:InitPlayNodeList()
	end,
	Play411241040 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 411241040
		arg_166_1.duration_ = 5

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play411241041(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 then
				arg_166_1.var_.moveOldPos10058ui_story = arg_166_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_169_0 = 0.001

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_0 then
				arg_166_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_166_1.var_.moveOldPos10058ui_story, Vector3.New(0, 100, 0), (arg_166_1.time_ - 0) / var_169_0)
				arg_166_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_166_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_166_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_166_1.actors_["10058ui_story"].transform.position).z)
				arg_166_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_166_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_166_1.actors_["10058ui_story"].transform.localEulerAngles = arg_166_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_166_1.time_ >= 0 + var_169_0 and arg_166_1.time_ < 0 + var_169_0 + arg_169_0 then
				arg_166_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_166_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_166_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_166_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_166_1.actors_["10058ui_story"].transform.position).z)
				arg_166_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_166_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_166_1.actors_["10058ui_story"].transform.localEulerAngles = arg_166_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_169_1 = arg_166_1.actors_["10058ui_story"]

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 and not isNil(var_169_1) and arg_166_1.var_.characterEffect10058ui_story == nil then
				arg_166_1.var_.characterEffect10058ui_story = var_169_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_169_2 = 0.200000002980232

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_2 and not isNil(var_169_1) then
				if arg_166_1.var_.characterEffect10058ui_story and not isNil(var_169_1) then
					arg_166_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_166_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_166_1.time_ - 0) / var_169_2)
				end
			end

			if arg_166_1.time_ >= 0 + var_169_2 and arg_166_1.time_ < 0 + var_169_2 + arg_169_0 and not isNil(var_169_1) and arg_166_1.var_.characterEffect10058ui_story then
				arg_166_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_166_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_169_3 = 0
			local var_169_4 = 0.525

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= var_169_3 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, false)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_5 = arg_166_1:FormatText(arg_166_1:GetWordFromCfg(411241040).content)

				arg_166_1.text_.text = var_169_5

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_7 = 21 <= 0 and var_169_4 or var_169_4 * (utf8.len(var_169_5) / 21)

				if (21 <= 0 and var_169_4 or var_169_4 * (utf8.len(var_169_5) / 21)) > 0 and var_169_4 < var_169_7 then
					arg_166_1.talkMaxDuration = var_169_7

					if var_169_7 + var_169_3 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_7 + var_169_3
					end
				end

				arg_166_1.text_.text = var_169_5
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)
				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_8 = math.max(var_169_4, arg_166_1.talkMaxDuration)

			if var_169_3 <= arg_166_1.time_ and arg_166_1.time_ < var_169_3 + var_169_8 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_3) / var_169_8

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_3 + var_169_8 and arg_166_1.time_ < var_169_3 + var_169_8 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_166_1:InitPlayNodeList()
	end,
	Play411241041 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 411241041
		arg_170_1.duration_ = 5

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play411241042(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			local var_173_0 = 0.55

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, false)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_1 = arg_170_1:FormatText(arg_170_1:GetWordFromCfg(411241041).content)

				arg_170_1.text_.text = var_173_1

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_3 = 22 <= 0 and var_173_0 or var_173_0 * (utf8.len(var_173_1) / 22)

				if (22 <= 0 and var_173_0 or var_173_0 * (utf8.len(var_173_1) / 22)) > 0 and var_173_0 < var_173_3 then
					arg_170_1.talkMaxDuration = var_173_3

					if var_173_3 + 0 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_3 + 0
					end
				end

				arg_170_1.text_.text = var_173_1
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)
				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_4 = math.max(var_173_0, arg_170_1.talkMaxDuration)

			if 0 <= arg_170_1.time_ and arg_170_1.time_ < 0 + var_173_4 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - 0) / var_173_4

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= 0 + var_173_4 and arg_170_1.time_ < 0 + var_173_4 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {}

		arg_170_1:InitPlayNodeList()
	end,
	Play411241042 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 411241042
		arg_174_1.duration_ = 4.2

		local var_174_0 = {
			zh = 4.2,
			ja = 4.1
		}
		local var_174_1 = manager.audio:GetLocalizationFlag()

		if var_174_0[var_174_1] ~= nil then
			arg_174_1.duration_ = var_174_0[var_174_1]
		end

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play411241043(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1.var_.moveOldPos10058ui_story = arg_174_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_177_0 = 0.001

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_0 then
				arg_174_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_174_1.var_.moveOldPos10058ui_story, Vector3.New(0, -0.98, -6.1), (arg_174_1.time_ - 0) / var_177_0)
				arg_174_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_174_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_174_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_174_1.actors_["10058ui_story"].transform.position).z)
				arg_174_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_174_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_174_1.actors_["10058ui_story"].transform.localEulerAngles = arg_174_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_174_1.time_ >= 0 + var_177_0 and arg_174_1.time_ < 0 + var_177_0 + arg_177_0 then
				arg_174_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_174_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_174_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_174_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_174_1.actors_["10058ui_story"].transform.position).z)
				arg_174_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_174_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_174_1.actors_["10058ui_story"].transform.localEulerAngles = arg_174_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_177_1 = arg_174_1.actors_["10058ui_story"]

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 and not isNil(var_177_1) and arg_174_1.var_.characterEffect10058ui_story == nil then
				arg_174_1.var_.characterEffect10058ui_story = var_177_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_177_2 = 0.200000002980232

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_2 and not isNil(var_177_1) then
				if arg_174_1.var_.characterEffect10058ui_story and not isNil(var_177_1) then
					arg_174_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_174_1.time_ >= 0 + var_177_2 and arg_174_1.time_ < 0 + var_177_2 + arg_177_0 and not isNil(var_177_1) and arg_174_1.var_.characterEffect10058ui_story then
				arg_174_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action7_1")
			end

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_177_4 = 0
			local var_177_5 = 0.525

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= var_177_4 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				arg_174_1.leftNameTxt_.text = arg_174_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_6 = arg_174_1:GetWordFromCfg(411241042)
				local var_177_7 = arg_174_1:FormatText(var_177_6.content)

				arg_174_1.text_.text = var_177_7

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_9 = 21 <= 0 and var_177_5 or var_177_5 * (utf8.len(var_177_7) / 21)

				if (21 <= 0 and var_177_5 or var_177_5 * (utf8.len(var_177_7) / 21)) > 0 and var_177_5 < var_177_9 then
					arg_174_1.talkMaxDuration = var_177_9

					if var_177_9 + var_177_4 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_9 + var_177_4
					end
				end

				arg_174_1.text_.text = var_177_7
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411241", "411241042", "story_v_out_411241.awb") ~= 0 then
					local var_177_10 = manager.audio:GetVoiceLength("story_v_out_411241", "411241042", "story_v_out_411241.awb") / 1000

					if var_177_10 + var_177_4 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_10 + var_177_4
					end

					if var_177_6.prefab_name ~= "" and arg_174_1.actors_[var_177_6.prefab_name] ~= nil then
						local var_177_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_174_1.actors_[var_177_6.prefab_name].transform, "story_v_out_411241", "411241042", "story_v_out_411241.awb")

						arg_174_1:RecordAudio("411241042", var_177_11)
						arg_174_1:RecordAudio("411241042", var_177_11)
					else
						arg_174_1:AudioAction("play", "voice", "story_v_out_411241", "411241042", "story_v_out_411241.awb")
					end

					arg_174_1:RecordHistoryTalkVoice("story_v_out_411241", "411241042", "story_v_out_411241.awb")
				end

				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_12 = math.max(var_177_5, arg_174_1.talkMaxDuration)

			if var_177_4 <= arg_174_1.time_ and arg_174_1.time_ < var_177_4 + var_177_12 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_4) / var_177_12

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_4 + var_177_12 and arg_174_1.time_ < var_177_4 + var_177_12 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_174_1:InitPlayNodeList()
	end,
	Play411241043 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 411241043
		arg_178_1.duration_ = 1.63

		local var_178_0 = {
			zh = 0.999999999999,
			ja = 1.633
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
				arg_178_0:Play411241044(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 and not isNil(arg_178_1.actors_["10058ui_story"]) and arg_178_1.var_.characterEffect10058ui_story == nil then
				arg_178_1.var_.characterEffect10058ui_story = arg_178_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_181_0 = 0.200000002980232

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_0 and not isNil(arg_178_1.actors_["10058ui_story"]) then
				if arg_178_1.var_.characterEffect10058ui_story and not isNil(arg_178_1.actors_["10058ui_story"]) then
					arg_178_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_178_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_178_1.time_ - 0) / var_181_0)
				end
			end

			if arg_178_1.time_ >= 0 + var_181_0 and arg_178_1.time_ < 0 + var_181_0 + arg_181_0 and not isNil(arg_178_1.actors_["10058ui_story"]) and arg_178_1.var_.characterEffect10058ui_story then
				arg_178_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_178_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_181_1 = 0
			local var_181_2 = 0.1

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= var_181_1 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				arg_178_1.leftNameTxt_.text = arg_178_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, true)
				arg_178_1.iconController_:SetSelectedState("hero")

				arg_178_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10025_1")

				arg_178_1.callingController_:SetSelectedState("normal")

				arg_178_1.keyicon_.color = Color.New(1, 1, 1)
				arg_178_1.icon_.color = Color.New(1, 1, 1)

				local var_181_3 = arg_178_1:GetWordFromCfg(411241043)
				local var_181_4 = arg_178_1:FormatText(var_181_3.content)

				arg_178_1.text_.text = var_181_4

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_6 = 4 <= 0 and var_181_2 or var_181_2 * (utf8.len(var_181_4) / 4)

				if (4 <= 0 and var_181_2 or var_181_2 * (utf8.len(var_181_4) / 4)) > 0 and var_181_2 < var_181_6 then
					arg_178_1.talkMaxDuration = var_181_6

					if var_181_6 + var_181_1 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_6 + var_181_1
					end
				end

				arg_178_1.text_.text = var_181_4
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411241", "411241043", "story_v_out_411241.awb") ~= 0 then
					local var_181_7 = manager.audio:GetVoiceLength("story_v_out_411241", "411241043", "story_v_out_411241.awb") / 1000

					if var_181_7 + var_181_1 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_7 + var_181_1
					end

					if var_181_3.prefab_name ~= "" and arg_178_1.actors_[var_181_3.prefab_name] ~= nil then
						local var_181_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_178_1.actors_[var_181_3.prefab_name].transform, "story_v_out_411241", "411241043", "story_v_out_411241.awb")

						arg_178_1:RecordAudio("411241043", var_181_8)
						arg_178_1:RecordAudio("411241043", var_181_8)
					else
						arg_178_1:AudioAction("play", "voice", "story_v_out_411241", "411241043", "story_v_out_411241.awb")
					end

					arg_178_1:RecordHistoryTalkVoice("story_v_out_411241", "411241043", "story_v_out_411241.awb")
				end

				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_9 = math.max(var_181_2, arg_178_1.talkMaxDuration)

			if var_181_1 <= arg_178_1.time_ and arg_178_1.time_ < var_181_1 + var_181_9 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_1) / var_181_9

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_1 + var_181_9 and arg_178_1.time_ < var_181_1 + var_181_9 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {}

		arg_178_1:InitPlayNodeList()
	end,
	Play411241044 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 411241044
		arg_182_1.duration_ = 5

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play411241045(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 and not isNil(arg_182_1.actors_["10058ui_story"]) and arg_182_1.var_.characterEffect10058ui_story == nil then
				arg_182_1.var_.characterEffect10058ui_story = arg_182_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_185_0 = 0.200000002980232

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_0 and not isNil(arg_182_1.actors_["10058ui_story"]) then
				if arg_182_1.var_.characterEffect10058ui_story and not isNil(arg_182_1.actors_["10058ui_story"]) then
					arg_182_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_182_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_182_1.time_ - 0) / var_185_0)
				end
			end

			if arg_182_1.time_ >= 0 + var_185_0 and arg_182_1.time_ < 0 + var_185_0 + arg_185_0 and not isNil(arg_182_1.actors_["10058ui_story"]) and arg_182_1.var_.characterEffect10058ui_story then
				arg_182_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_182_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_185_1 = arg_182_1.actors_["10058ui_story"].transform

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1.var_.moveOldPos10058ui_story = var_185_1.localPosition
			end

			local var_185_2 = 0.001

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_2 then
				var_185_1.localPosition = Vector3.Lerp(arg_182_1.var_.moveOldPos10058ui_story, Vector3.New(0, 100, 0), (arg_182_1.time_ - 0) / var_185_2)
				var_185_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_185_1.position).x, (manager.ui.mainCamera.transform.position - var_185_1.position).y, (manager.ui.mainCamera.transform.position - var_185_1.position).z)
				var_185_1.localEulerAngles.z = 0
				var_185_1.localEulerAngles.x = 0
				var_185_1.localEulerAngles = var_185_1.localEulerAngles
			end

			if arg_182_1.time_ >= 0 + var_185_2 and arg_182_1.time_ < 0 + var_185_2 + arg_185_0 then
				var_185_1.localPosition = Vector3.New(0, 100, 0)
				var_185_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_185_1.position).x, (manager.ui.mainCamera.transform.position - var_185_1.position).y, (manager.ui.mainCamera.transform.position - var_185_1.position).z)
				var_185_1.localEulerAngles.z = 0
				var_185_1.localEulerAngles.x = 0
				var_185_1.localEulerAngles = var_185_1.localEulerAngles
			end

			local var_185_3 = 0
			local var_185_4 = 0.75

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= var_185_3 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, false)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_5 = arg_182_1:FormatText(arg_182_1:GetWordFromCfg(411241044).content)

				arg_182_1.text_.text = var_185_5

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_7 = 30 <= 0 and var_185_4 or var_185_4 * (utf8.len(var_185_5) / 30)

				if (30 <= 0 and var_185_4 or var_185_4 * (utf8.len(var_185_5) / 30)) > 0 and var_185_4 < var_185_7 then
					arg_182_1.talkMaxDuration = var_185_7

					if var_185_7 + var_185_3 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_7 + var_185_3
					end
				end

				arg_182_1.text_.text = var_185_5
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)
				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_8 = math.max(var_185_4, arg_182_1.talkMaxDuration)

			if var_185_3 <= arg_182_1.time_ and arg_182_1.time_ < var_185_3 + var_185_8 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_3) / var_185_8

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_3 + var_185_8 and arg_182_1.time_ < var_185_3 + var_185_8 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_182_1:InitPlayNodeList()
	end,
	Play411241045 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 411241045
		arg_186_1.duration_ = 2

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play411241046(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 and not isNil(arg_186_1.actors_["10058ui_story"]) and arg_186_1.var_.characterEffect10058ui_story == nil then
				arg_186_1.var_.characterEffect10058ui_story = arg_186_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_189_0 = 0.200000002980232

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_0 and not isNil(arg_186_1.actors_["10058ui_story"]) then
				if arg_186_1.var_.characterEffect10058ui_story and not isNil(arg_186_1.actors_["10058ui_story"]) then
					arg_186_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_186_1.time_ >= 0 + var_189_0 and arg_186_1.time_ < 0 + var_189_0 + arg_189_0 and not isNil(arg_186_1.actors_["10058ui_story"]) and arg_186_1.var_.characterEffect10058ui_story then
				arg_186_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action7_2")
			end

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_189_2 = arg_186_1.actors_["10058ui_story"].transform

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1.var_.moveOldPos10058ui_story = var_189_2.localPosition
			end

			local var_189_3 = 0.001

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_3 then
				var_189_2.localPosition = Vector3.Lerp(arg_186_1.var_.moveOldPos10058ui_story, Vector3.New(0, -0.98, -6.1), (arg_186_1.time_ - 0) / var_189_3)
				var_189_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_189_2.position).x, (manager.ui.mainCamera.transform.position - var_189_2.position).y, (manager.ui.mainCamera.transform.position - var_189_2.position).z)
				var_189_2.localEulerAngles.z = 0
				var_189_2.localEulerAngles.x = 0
				var_189_2.localEulerAngles = var_189_2.localEulerAngles
			end

			if arg_186_1.time_ >= 0 + var_189_3 and arg_186_1.time_ < 0 + var_189_3 + arg_189_0 then
				var_189_2.localPosition = Vector3.New(0, -0.98, -6.1)
				var_189_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_189_2.position).x, (manager.ui.mainCamera.transform.position - var_189_2.position).y, (manager.ui.mainCamera.transform.position - var_189_2.position).z)
				var_189_2.localEulerAngles.z = 0
				var_189_2.localEulerAngles.x = 0
				var_189_2.localEulerAngles = var_189_2.localEulerAngles
			end

			local var_189_4 = 0
			local var_189_5 = 0.1

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= var_189_4 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				arg_186_1.leftNameTxt_.text = arg_186_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_6 = arg_186_1:GetWordFromCfg(411241045)
				local var_189_7 = arg_186_1:FormatText(var_189_6.content)

				arg_186_1.text_.text = var_189_7

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_9 = 4 <= 0 and var_189_5 or var_189_5 * (utf8.len(var_189_7) / 4)

				if (4 <= 0 and var_189_5 or var_189_5 * (utf8.len(var_189_7) / 4)) > 0 and var_189_5 < var_189_9 then
					arg_186_1.talkMaxDuration = var_189_9

					if var_189_9 + var_189_4 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_9 + var_189_4
					end
				end

				arg_186_1.text_.text = var_189_7
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411241", "411241045", "story_v_out_411241.awb") ~= 0 then
					local var_189_10 = manager.audio:GetVoiceLength("story_v_out_411241", "411241045", "story_v_out_411241.awb") / 1000

					if var_189_10 + var_189_4 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_10 + var_189_4
					end

					if var_189_6.prefab_name ~= "" and arg_186_1.actors_[var_189_6.prefab_name] ~= nil then
						local var_189_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_186_1.actors_[var_189_6.prefab_name].transform, "story_v_out_411241", "411241045", "story_v_out_411241.awb")

						arg_186_1:RecordAudio("411241045", var_189_11)
						arg_186_1:RecordAudio("411241045", var_189_11)
					else
						arg_186_1:AudioAction("play", "voice", "story_v_out_411241", "411241045", "story_v_out_411241.awb")
					end

					arg_186_1:RecordHistoryTalkVoice("story_v_out_411241", "411241045", "story_v_out_411241.awb")
				end

				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_12 = math.max(var_189_5, arg_186_1.talkMaxDuration)

			if var_189_4 <= arg_186_1.time_ and arg_186_1.time_ < var_189_4 + var_189_12 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_4) / var_189_12

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_4 + var_189_12 and arg_186_1.time_ < var_189_4 + var_189_12 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
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
	Play411241046 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 411241046
		arg_190_1.duration_ = 5

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play411241047(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 and not isNil(arg_190_1.actors_["10058ui_story"]) and arg_190_1.var_.characterEffect10058ui_story == nil then
				arg_190_1.var_.characterEffect10058ui_story = arg_190_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_193_0 = 0.200000002980232

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_0 and not isNil(arg_190_1.actors_["10058ui_story"]) then
				if arg_190_1.var_.characterEffect10058ui_story and not isNil(arg_190_1.actors_["10058ui_story"]) then
					arg_190_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_190_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_190_1.time_ - 0) / var_193_0)
				end
			end

			if arg_190_1.time_ >= 0 + var_193_0 and arg_190_1.time_ < 0 + var_193_0 + arg_193_0 and not isNil(arg_190_1.actors_["10058ui_story"]) and arg_190_1.var_.characterEffect10058ui_story then
				arg_190_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_190_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_193_1 = 0
			local var_193_2 = 1.05

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= var_193_1 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, false)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_190_1.iconTrs_.gameObject, false)
				arg_190_1.callingController_:SetSelectedState("normal")

				local var_193_3 = arg_190_1:FormatText(arg_190_1:GetWordFromCfg(411241046).content)

				arg_190_1.text_.text = var_193_3

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_5 = 41 <= 0 and var_193_2 or var_193_2 * (utf8.len(var_193_3) / 41)

				if (41 <= 0 and var_193_2 or var_193_2 * (utf8.len(var_193_3) / 41)) > 0 and var_193_2 < var_193_5 then
					arg_190_1.talkMaxDuration = var_193_5

					if var_193_5 + var_193_1 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_5 + var_193_1
					end
				end

				arg_190_1.text_.text = var_193_3
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)
				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_6 = math.max(var_193_2, arg_190_1.talkMaxDuration)

			if var_193_1 <= arg_190_1.time_ and arg_190_1.time_ < var_193_1 + var_193_6 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_1) / var_193_6

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_1 + var_193_6 and arg_190_1.time_ < var_193_1 + var_193_6 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {}

		arg_190_1:InitPlayNodeList()
	end,
	Play411241047 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 411241047
		arg_194_1.duration_ = 2.77

		local var_194_0 = {
			zh = 2.766,
			ja = 2.4
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
				arg_194_0:Play411241048(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			local var_197_0 = 0.175

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				arg_194_1.leftNameTxt_.text = arg_194_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, true)
				arg_194_1.iconController_:SetSelectedState("hero")

				arg_194_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10025_1")

				arg_194_1.callingController_:SetSelectedState("normal")

				arg_194_1.keyicon_.color = Color.New(1, 1, 1)
				arg_194_1.icon_.color = Color.New(1, 1, 1)

				local var_197_1 = arg_194_1:GetWordFromCfg(411241047)
				local var_197_2 = arg_194_1:FormatText(var_197_1.content)

				arg_194_1.text_.text = var_197_2

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_4 = 7 <= 0 and var_197_0 or var_197_0 * (utf8.len(var_197_2) / 7)

				if (7 <= 0 and var_197_0 or var_197_0 * (utf8.len(var_197_2) / 7)) > 0 and var_197_0 < var_197_4 then
					arg_194_1.talkMaxDuration = var_197_4

					if var_197_4 + 0 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_4 + 0
					end
				end

				arg_194_1.text_.text = var_197_2
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411241", "411241047", "story_v_out_411241.awb") ~= 0 then
					local var_197_5 = manager.audio:GetVoiceLength("story_v_out_411241", "411241047", "story_v_out_411241.awb") / 1000

					if var_197_5 + 0 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_5 + 0
					end

					if var_197_1.prefab_name ~= "" and arg_194_1.actors_[var_197_1.prefab_name] ~= nil then
						local var_197_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_194_1.actors_[var_197_1.prefab_name].transform, "story_v_out_411241", "411241047", "story_v_out_411241.awb")

						arg_194_1:RecordAudio("411241047", var_197_6)
						arg_194_1:RecordAudio("411241047", var_197_6)
					else
						arg_194_1:AudioAction("play", "voice", "story_v_out_411241", "411241047", "story_v_out_411241.awb")
					end

					arg_194_1:RecordHistoryTalkVoice("story_v_out_411241", "411241047", "story_v_out_411241.awb")
				end

				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_7 = math.max(var_197_0, arg_194_1.talkMaxDuration)

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_7 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - 0) / var_197_7

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= 0 + var_197_7 and arg_194_1.time_ < 0 + var_197_7 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {}

		arg_194_1:InitPlayNodeList()
	end,
	Play411241048 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 411241048
		arg_198_1.duration_ = 2.07

		local var_198_0 = {
			zh = 1.999999999999,
			ja = 2.066
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
				arg_198_0:Play411241049(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1.var_.moveOldPos10058ui_story = arg_198_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_201_0 = 0.001

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_0 then
				arg_198_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_198_1.var_.moveOldPos10058ui_story, Vector3.New(0, -0.98, -6.1), (arg_198_1.time_ - 0) / var_201_0)
				arg_198_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_198_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_198_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_198_1.actors_["10058ui_story"].transform.position).z)
				arg_198_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_198_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_198_1.actors_["10058ui_story"].transform.localEulerAngles = arg_198_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_198_1.time_ >= 0 + var_201_0 and arg_198_1.time_ < 0 + var_201_0 + arg_201_0 then
				arg_198_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_198_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_198_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_198_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_198_1.actors_["10058ui_story"].transform.position).z)
				arg_198_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_198_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_198_1.actors_["10058ui_story"].transform.localEulerAngles = arg_198_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_201_1 = arg_198_1.actors_["10058ui_story"]

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 and not isNil(var_201_1) and arg_198_1.var_.characterEffect10058ui_story == nil then
				arg_198_1.var_.characterEffect10058ui_story = var_201_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_201_2 = 0.200000002980232

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_2 and not isNil(var_201_1) then
				if arg_198_1.var_.characterEffect10058ui_story and not isNil(var_201_1) then
					arg_198_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_198_1.time_ >= 0 + var_201_2 and arg_198_1.time_ < 0 + var_201_2 + arg_201_0 and not isNil(var_201_1) and arg_198_1.var_.characterEffect10058ui_story then
				arg_198_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_201_4 = 0
			local var_201_5 = 0.125

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= var_201_4 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, true)

				arg_198_1.leftNameTxt_.text = arg_198_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_198_1.leftNameTxt_.transform)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1.leftNameTxt_.text)
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_6 = arg_198_1:GetWordFromCfg(411241048)
				local var_201_7 = arg_198_1:FormatText(var_201_6.content)

				arg_198_1.text_.text = var_201_7

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_9 = 5 <= 0 and var_201_5 or var_201_5 * (utf8.len(var_201_7) / 5)

				if (5 <= 0 and var_201_5 or var_201_5 * (utf8.len(var_201_7) / 5)) > 0 and var_201_5 < var_201_9 then
					arg_198_1.talkMaxDuration = var_201_9

					if var_201_9 + var_201_4 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_9 + var_201_4
					end
				end

				arg_198_1.text_.text = var_201_7
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411241", "411241048", "story_v_out_411241.awb") ~= 0 then
					local var_201_10 = manager.audio:GetVoiceLength("story_v_out_411241", "411241048", "story_v_out_411241.awb") / 1000

					if var_201_10 + var_201_4 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_10 + var_201_4
					end

					if var_201_6.prefab_name ~= "" and arg_198_1.actors_[var_201_6.prefab_name] ~= nil then
						local var_201_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_198_1.actors_[var_201_6.prefab_name].transform, "story_v_out_411241", "411241048", "story_v_out_411241.awb")

						arg_198_1:RecordAudio("411241048", var_201_11)
						arg_198_1:RecordAudio("411241048", var_201_11)
					else
						arg_198_1:AudioAction("play", "voice", "story_v_out_411241", "411241048", "story_v_out_411241.awb")
					end

					arg_198_1:RecordHistoryTalkVoice("story_v_out_411241", "411241048", "story_v_out_411241.awb")
				end

				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_12 = math.max(var_201_5, arg_198_1.talkMaxDuration)

			if var_201_4 <= arg_198_1.time_ and arg_198_1.time_ < var_201_4 + var_201_12 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_4) / var_201_12

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_4 + var_201_12 and arg_198_1.time_ < var_201_4 + var_201_12 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_198_1:InitPlayNodeList()
	end,
	Play411241049 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 411241049
		arg_202_1.duration_ = 4.23

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play411241050(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 and not isNil(arg_202_1.actors_["10058ui_story"]) and arg_202_1.var_.characterEffect10058ui_story == nil then
				arg_202_1.var_.characterEffect10058ui_story = arg_202_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_205_0 = 0.200000002980232

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_0 and not isNil(arg_202_1.actors_["10058ui_story"]) then
				if arg_202_1.var_.characterEffect10058ui_story and not isNil(arg_202_1.actors_["10058ui_story"]) then
					arg_202_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_202_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_202_1.time_ - 0) / var_205_0)
				end
			end

			if arg_202_1.time_ >= 0 + var_205_0 and arg_202_1.time_ < 0 + var_205_0 + arg_205_0 and not isNil(arg_202_1.actors_["10058ui_story"]) and arg_202_1.var_.characterEffect10058ui_story then
				arg_202_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_202_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 then
				arg_202_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_205_1 = 0
			local var_205_2 = 0.3

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= var_205_1 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, true)

				arg_202_1.leftNameTxt_.text = arg_202_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, true)
				arg_202_1.iconController_:SetSelectedState("hero")

				arg_202_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10025_1")

				arg_202_1.callingController_:SetSelectedState("normal")

				arg_202_1.keyicon_.color = Color.New(1, 1, 1)
				arg_202_1.icon_.color = Color.New(1, 1, 1)

				local var_205_3 = arg_202_1:GetWordFromCfg(411241049)
				local var_205_4 = arg_202_1:FormatText(var_205_3.content)

				arg_202_1.text_.text = var_205_4

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_6 = 12 <= 0 and var_205_2 or var_205_2 * (utf8.len(var_205_4) / 12)

				if (12 <= 0 and var_205_2 or var_205_2 * (utf8.len(var_205_4) / 12)) > 0 and var_205_2 < var_205_6 then
					arg_202_1.talkMaxDuration = var_205_6

					if var_205_6 + var_205_1 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_6 + var_205_1
					end
				end

				arg_202_1.text_.text = var_205_4
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411241", "411241049", "story_v_out_411241.awb") ~= 0 then
					local var_205_7 = manager.audio:GetVoiceLength("story_v_out_411241", "411241049", "story_v_out_411241.awb") / 1000

					if var_205_7 + var_205_1 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_7 + var_205_1
					end

					if var_205_3.prefab_name ~= "" and arg_202_1.actors_[var_205_3.prefab_name] ~= nil then
						local var_205_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_202_1.actors_[var_205_3.prefab_name].transform, "story_v_out_411241", "411241049", "story_v_out_411241.awb")

						arg_202_1:RecordAudio("411241049", var_205_8)
						arg_202_1:RecordAudio("411241049", var_205_8)
					else
						arg_202_1:AudioAction("play", "voice", "story_v_out_411241", "411241049", "story_v_out_411241.awb")
					end

					arg_202_1:RecordHistoryTalkVoice("story_v_out_411241", "411241049", "story_v_out_411241.awb")
				end

				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_9 = math.max(var_205_2, arg_202_1.talkMaxDuration)

			if var_205_1 <= arg_202_1.time_ and arg_202_1.time_ < var_205_1 + var_205_9 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_1) / var_205_9

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_1 + var_205_9 and arg_202_1.time_ < var_205_1 + var_205_9 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {}

		arg_202_1:InitPlayNodeList()
	end,
	Play411241050 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 411241050
		arg_206_1.duration_ = 5

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play411241051(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_209_0 = 0
			local var_209_1 = 0.65

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= var_209_0 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, false)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_2 = arg_206_1:FormatText(arg_206_1:GetWordFromCfg(411241050).content)

				arg_206_1.text_.text = var_209_2

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_4 = 26 <= 0 and var_209_1 or var_209_1 * (utf8.len(var_209_2) / 26)

				if (26 <= 0 and var_209_1 or var_209_1 * (utf8.len(var_209_2) / 26)) > 0 and var_209_1 < var_209_4 then
					arg_206_1.talkMaxDuration = var_209_4

					if var_209_4 + var_209_0 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_4 + var_209_0
					end
				end

				arg_206_1.text_.text = var_209_2
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)
				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_5 = math.max(var_209_1, arg_206_1.talkMaxDuration)

			if var_209_0 <= arg_206_1.time_ and arg_206_1.time_ < var_209_0 + var_209_5 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_0) / var_209_5

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_0 + var_209_5 and arg_206_1.time_ < var_209_0 + var_209_5 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {}

		arg_206_1:InitPlayNodeList()
	end,
	Play411241051 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 411241051
		arg_210_1.duration_ = 6.57

		local var_210_0 = {
			zh = 3.5,
			ja = 6.566
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
				arg_210_0:Play411241052(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 and not isNil(arg_210_1.actors_["10058ui_story"]) and arg_210_1.var_.characterEffect10058ui_story == nil then
				arg_210_1.var_.characterEffect10058ui_story = arg_210_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_213_0 = 0.200000002980232

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_0 and not isNil(arg_210_1.actors_["10058ui_story"]) then
				if arg_210_1.var_.characterEffect10058ui_story and not isNil(arg_210_1.actors_["10058ui_story"]) then
					arg_210_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_210_1.time_ >= 0 + var_213_0 and arg_210_1.time_ < 0 + var_213_0 + arg_213_0 and not isNil(arg_210_1.actors_["10058ui_story"]) and arg_210_1.var_.characterEffect10058ui_story then
				arg_210_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 then
				arg_210_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_213_2 = 0
			local var_213_3 = 0.325

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= var_213_2 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, true)

				arg_210_1.leftNameTxt_.text = arg_210_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_210_1.leftNameTxt_.transform)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1.leftNameTxt_.text)
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_4 = arg_210_1:GetWordFromCfg(411241051)
				local var_213_5 = arg_210_1:FormatText(var_213_4.content)

				arg_210_1.text_.text = var_213_5

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_7 = 13 <= 0 and var_213_3 or var_213_3 * (utf8.len(var_213_5) / 13)

				if (13 <= 0 and var_213_3 or var_213_3 * (utf8.len(var_213_5) / 13)) > 0 and var_213_3 < var_213_7 then
					arg_210_1.talkMaxDuration = var_213_7

					if var_213_7 + var_213_2 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_7 + var_213_2
					end
				end

				arg_210_1.text_.text = var_213_5
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411241", "411241051", "story_v_out_411241.awb") ~= 0 then
					local var_213_8 = manager.audio:GetVoiceLength("story_v_out_411241", "411241051", "story_v_out_411241.awb") / 1000

					if var_213_8 + var_213_2 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_8 + var_213_2
					end

					if var_213_4.prefab_name ~= "" and arg_210_1.actors_[var_213_4.prefab_name] ~= nil then
						local var_213_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_210_1.actors_[var_213_4.prefab_name].transform, "story_v_out_411241", "411241051", "story_v_out_411241.awb")

						arg_210_1:RecordAudio("411241051", var_213_9)
						arg_210_1:RecordAudio("411241051", var_213_9)
					else
						arg_210_1:AudioAction("play", "voice", "story_v_out_411241", "411241051", "story_v_out_411241.awb")
					end

					arg_210_1:RecordHistoryTalkVoice("story_v_out_411241", "411241051", "story_v_out_411241.awb")
				end

				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_10 = math.max(var_213_3, arg_210_1.talkMaxDuration)

			if var_213_2 <= arg_210_1.time_ and arg_210_1.time_ < var_213_2 + var_213_10 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_2) / var_213_10

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_2 + var_213_10 and arg_210_1.time_ < var_213_2 + var_213_10 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {}

		arg_210_1:InitPlayNodeList()
	end,
	Play411241052 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 411241052
		arg_214_1.duration_ = 5.33

		local var_214_0 = {
			zh = 5.333,
			ja = 4.333
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
				arg_214_0:Play411241053(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 and not isNil(arg_214_1.actors_["10058ui_story"]) and arg_214_1.var_.characterEffect10058ui_story == nil then
				arg_214_1.var_.characterEffect10058ui_story = arg_214_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_217_0 = 0.200000002980232

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_0 and not isNil(arg_214_1.actors_["10058ui_story"]) then
				if arg_214_1.var_.characterEffect10058ui_story and not isNil(arg_214_1.actors_["10058ui_story"]) then
					arg_214_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_214_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_214_1.time_ - 0) / var_217_0)
				end
			end

			if arg_214_1.time_ >= 0 + var_217_0 and arg_214_1.time_ < 0 + var_217_0 + arg_217_0 and not isNil(arg_214_1.actors_["10058ui_story"]) and arg_214_1.var_.characterEffect10058ui_story then
				arg_214_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_214_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_217_1 = 0
			local var_217_2 = 0.3

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= var_217_1 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				arg_214_1.leftNameTxt_.text = arg_214_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, true)
				arg_214_1.iconController_:SetSelectedState("hero")

				arg_214_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10025_1")

				arg_214_1.callingController_:SetSelectedState("normal")

				arg_214_1.keyicon_.color = Color.New(1, 1, 1)
				arg_214_1.icon_.color = Color.New(1, 1, 1)

				local var_217_3 = arg_214_1:GetWordFromCfg(411241052)
				local var_217_4 = arg_214_1:FormatText(var_217_3.content)

				arg_214_1.text_.text = var_217_4

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_6 = 12 <= 0 and var_217_2 or var_217_2 * (utf8.len(var_217_4) / 12)

				if (12 <= 0 and var_217_2 or var_217_2 * (utf8.len(var_217_4) / 12)) > 0 and var_217_2 < var_217_6 then
					arg_214_1.talkMaxDuration = var_217_6

					if var_217_6 + var_217_1 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_6 + var_217_1
					end
				end

				arg_214_1.text_.text = var_217_4
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411241", "411241052", "story_v_out_411241.awb") ~= 0 then
					local var_217_7 = manager.audio:GetVoiceLength("story_v_out_411241", "411241052", "story_v_out_411241.awb") / 1000

					if var_217_7 + var_217_1 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_7 + var_217_1
					end

					if var_217_3.prefab_name ~= "" and arg_214_1.actors_[var_217_3.prefab_name] ~= nil then
						local var_217_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_214_1.actors_[var_217_3.prefab_name].transform, "story_v_out_411241", "411241052", "story_v_out_411241.awb")

						arg_214_1:RecordAudio("411241052", var_217_8)
						arg_214_1:RecordAudio("411241052", var_217_8)
					else
						arg_214_1:AudioAction("play", "voice", "story_v_out_411241", "411241052", "story_v_out_411241.awb")
					end

					arg_214_1:RecordHistoryTalkVoice("story_v_out_411241", "411241052", "story_v_out_411241.awb")
				end

				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_9 = math.max(var_217_2, arg_214_1.talkMaxDuration)

			if var_217_1 <= arg_214_1.time_ and arg_214_1.time_ < var_217_1 + var_217_9 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_1) / var_217_9

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_1 + var_217_9 and arg_214_1.time_ < var_217_1 + var_217_9 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {}

		arg_214_1:InitPlayNodeList()
	end,
	Play411241053 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 411241053
		arg_218_1.duration_ = 8.03

		local var_218_0 = {
			zh = 4.4,
			ja = 8.033
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
				arg_218_0:Play411241054(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 and not isNil(arg_218_1.actors_["10058ui_story"]) and arg_218_1.var_.characterEffect10058ui_story == nil then
				arg_218_1.var_.characterEffect10058ui_story = arg_218_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_221_0 = 0.200000002980232

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_0 and not isNil(arg_218_1.actors_["10058ui_story"]) then
				if arg_218_1.var_.characterEffect10058ui_story and not isNil(arg_218_1.actors_["10058ui_story"]) then
					arg_218_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_218_1.time_ >= 0 + var_221_0 and arg_218_1.time_ < 0 + var_221_0 + arg_221_0 and not isNil(arg_218_1.actors_["10058ui_story"]) and arg_218_1.var_.characterEffect10058ui_story then
				arg_218_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action4_1")
			end

			local var_221_2 = 0
			local var_221_3 = 0.475

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= var_221_2 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				arg_218_1.leftNameTxt_.text = arg_218_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_4 = arg_218_1:GetWordFromCfg(411241053)
				local var_221_5 = arg_218_1:FormatText(var_221_4.content)

				arg_218_1.text_.text = var_221_5

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_7 = 19 <= 0 and var_221_3 or var_221_3 * (utf8.len(var_221_5) / 19)

				if (19 <= 0 and var_221_3 or var_221_3 * (utf8.len(var_221_5) / 19)) > 0 and var_221_3 < var_221_7 then
					arg_218_1.talkMaxDuration = var_221_7

					if var_221_7 + var_221_2 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_7 + var_221_2
					end
				end

				arg_218_1.text_.text = var_221_5
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411241", "411241053", "story_v_out_411241.awb") ~= 0 then
					local var_221_8 = manager.audio:GetVoiceLength("story_v_out_411241", "411241053", "story_v_out_411241.awb") / 1000

					if var_221_8 + var_221_2 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_8 + var_221_2
					end

					if var_221_4.prefab_name ~= "" and arg_218_1.actors_[var_221_4.prefab_name] ~= nil then
						local var_221_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_218_1.actors_[var_221_4.prefab_name].transform, "story_v_out_411241", "411241053", "story_v_out_411241.awb")

						arg_218_1:RecordAudio("411241053", var_221_9)
						arg_218_1:RecordAudio("411241053", var_221_9)
					else
						arg_218_1:AudioAction("play", "voice", "story_v_out_411241", "411241053", "story_v_out_411241.awb")
					end

					arg_218_1:RecordHistoryTalkVoice("story_v_out_411241", "411241053", "story_v_out_411241.awb")
				end

				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_10 = math.max(var_221_3, arg_218_1.talkMaxDuration)

			if var_221_2 <= arg_218_1.time_ and arg_218_1.time_ < var_221_2 + var_221_10 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_2) / var_221_10

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_2 + var_221_10 and arg_218_1.time_ < var_221_2 + var_221_10 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {}

		arg_218_1:InitPlayNodeList()
	end,
	Play411241054 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 411241054
		arg_222_1.duration_ = 5

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play411241055(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 and not isNil(arg_222_1.actors_["10058ui_story"]) and arg_222_1.var_.characterEffect10058ui_story == nil then
				arg_222_1.var_.characterEffect10058ui_story = arg_222_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_225_0 = 0.200000002980232

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_0 and not isNil(arg_222_1.actors_["10058ui_story"]) then
				if arg_222_1.var_.characterEffect10058ui_story and not isNil(arg_222_1.actors_["10058ui_story"]) then
					arg_222_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_222_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_222_1.time_ - 0) / var_225_0)
				end
			end

			if arg_222_1.time_ >= 0 + var_225_0 and arg_222_1.time_ < 0 + var_225_0 + arg_225_0 and not isNil(arg_222_1.actors_["10058ui_story"]) and arg_222_1.var_.characterEffect10058ui_story then
				arg_222_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_222_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_225_1 = 0
			local var_225_2 = 0.55

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= var_225_1 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, false)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_3 = arg_222_1:FormatText(arg_222_1:GetWordFromCfg(411241054).content)

				arg_222_1.text_.text = var_225_3

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_5 = 22 <= 0 and var_225_2 or var_225_2 * (utf8.len(var_225_3) / 22)

				if (22 <= 0 and var_225_2 or var_225_2 * (utf8.len(var_225_3) / 22)) > 0 and var_225_2 < var_225_5 then
					arg_222_1.talkMaxDuration = var_225_5

					if var_225_5 + var_225_1 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_5 + var_225_1
					end
				end

				arg_222_1.text_.text = var_225_3
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)
				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_6 = math.max(var_225_2, arg_222_1.talkMaxDuration)

			if var_225_1 <= arg_222_1.time_ and arg_222_1.time_ < var_225_1 + var_225_6 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_1) / var_225_6

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_1 + var_225_6 and arg_222_1.time_ < var_225_1 + var_225_6 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {}

		arg_222_1:InitPlayNodeList()
	end,
	Play411241055 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 411241055
		arg_226_1.duration_ = 2.67

		local var_226_0 = {
			zh = 2.666,
			ja = 1.999999999999
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
				arg_226_0:Play411241056(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 then
				arg_226_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_229_0 = 0
			local var_229_1 = 0.1

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= var_229_0 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				arg_226_1.leftNameTxt_.text = arg_226_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, true)
				arg_226_1.iconController_:SetSelectedState("hero")

				arg_226_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10025_1")

				arg_226_1.callingController_:SetSelectedState("normal")

				arg_226_1.keyicon_.color = Color.New(1, 1, 1)
				arg_226_1.icon_.color = Color.New(1, 1, 1)

				local var_229_2 = arg_226_1:GetWordFromCfg(411241055)
				local var_229_3 = arg_226_1:FormatText(var_229_2.content)

				arg_226_1.text_.text = var_229_3

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_5 = 4 <= 0 and var_229_1 or var_229_1 * (utf8.len(var_229_3) / 4)

				if (4 <= 0 and var_229_1 or var_229_1 * (utf8.len(var_229_3) / 4)) > 0 and var_229_1 < var_229_5 then
					arg_226_1.talkMaxDuration = var_229_5

					if var_229_5 + var_229_0 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_5 + var_229_0
					end
				end

				arg_226_1.text_.text = var_229_3
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411241", "411241055", "story_v_out_411241.awb") ~= 0 then
					local var_229_6 = manager.audio:GetVoiceLength("story_v_out_411241", "411241055", "story_v_out_411241.awb") / 1000

					if var_229_6 + var_229_0 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_6 + var_229_0
					end

					if var_229_2.prefab_name ~= "" and arg_226_1.actors_[var_229_2.prefab_name] ~= nil then
						local var_229_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_226_1.actors_[var_229_2.prefab_name].transform, "story_v_out_411241", "411241055", "story_v_out_411241.awb")

						arg_226_1:RecordAudio("411241055", var_229_7)
						arg_226_1:RecordAudio("411241055", var_229_7)
					else
						arg_226_1:AudioAction("play", "voice", "story_v_out_411241", "411241055", "story_v_out_411241.awb")
					end

					arg_226_1:RecordHistoryTalkVoice("story_v_out_411241", "411241055", "story_v_out_411241.awb")
				end

				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_8 = math.max(var_229_1, arg_226_1.talkMaxDuration)

			if var_229_0 <= arg_226_1.time_ and arg_226_1.time_ < var_229_0 + var_229_8 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_0) / var_229_8

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_0 + var_229_8 and arg_226_1.time_ < var_229_0 + var_229_8 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {}

		arg_226_1:InitPlayNodeList()
	end,
	Play411241056 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 411241056
		arg_230_1.duration_ = 9

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play411241057(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			if 2 < arg_230_1.time_ and arg_230_1.time_ <= 2 + arg_233_0 then
				local var_233_0 = arg_230_1.bgs_.ST77a

				arg_230_1.bgs_.ST77a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_233_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_233_1 = var_233_0:GetComponent("SpriteRenderer")

				if var_233_1 and var_233_1.sprite then
					local var_233_2 = 2 * (var_233_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_233_0.transform.localScale = Vector3.New(var_233_2 / var_233_1.sprite.bounds.size.y < var_233_2 * manager.ui.mainCameraCom_.aspect / var_233_1.sprite.bounds.size.x and var_233_2 * manager.ui.mainCameraCom_.aspect / var_233_1.sprite.bounds.size.x or var_233_2 / var_233_1.sprite.bounds.size.y, var_233_2 / var_233_1.sprite.bounds.size.y < var_233_2 * manager.ui.mainCameraCom_.aspect / var_233_1.sprite.bounds.size.x and var_233_2 * manager.ui.mainCameraCom_.aspect / var_233_1.sprite.bounds.size.x or var_233_2 / var_233_1.sprite.bounds.size.y, 0)
				end

				for iter_233_0, iter_233_1 in pairs(arg_230_1.bgs_) do
					if iter_233_0 ~= "ST77a" then
						iter_233_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_233_3 = 0

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= var_233_3 + arg_233_0 then
				arg_230_1.mask_.enabled = true
				arg_230_1.mask_.raycastTarget = true

				arg_230_1:SetGaussion(false)
			end

			local var_233_4 = 2

			if var_233_3 <= arg_230_1.time_ and arg_230_1.time_ < var_233_3 + var_233_4 then
				local var_233_5 = Color.New(0, 0, 0)

				var_233_5.a = Mathf.Lerp(0, 1, (arg_230_1.time_ - var_233_3) / var_233_4)
				arg_230_1.mask_.color = var_233_5
			end

			if arg_230_1.time_ >= var_233_3 + var_233_4 and arg_230_1.time_ < var_233_3 + var_233_4 + arg_233_0 then
				local var_233_6 = Color.New(0, 0, 0)

				var_233_6.a = 1
				arg_230_1.mask_.color = var_233_6
			end

			local var_233_7 = 2

			if 2 < arg_230_1.time_ and arg_230_1.time_ <= var_233_7 + arg_233_0 then
				arg_230_1.mask_.enabled = true
				arg_230_1.mask_.raycastTarget = true

				arg_230_1:SetGaussion(false)
			end

			local var_233_8 = 2

			if var_233_7 <= arg_230_1.time_ and arg_230_1.time_ < var_233_7 + var_233_8 then
				local var_233_9 = Color.New(0, 0, 0)

				var_233_9.a = Mathf.Lerp(1, 0, (arg_230_1.time_ - var_233_7) / var_233_8)
				arg_230_1.mask_.color = var_233_9
			end

			if arg_230_1.time_ >= var_233_7 + var_233_8 and arg_230_1.time_ < var_233_7 + var_233_8 + arg_233_0 then
				local var_233_10 = Color.New(0, 0, 0)

				arg_230_1.mask_.enabled = false
				var_233_10.a = 0
				arg_230_1.mask_.color = var_233_10
			end

			local var_233_11 = arg_230_1.actors_["10058ui_story"].transform

			if 2 < arg_230_1.time_ and arg_230_1.time_ <= 2 + arg_233_0 then
				arg_230_1.var_.moveOldPos10058ui_story = var_233_11.localPosition
			end

			local var_233_12 = 0.001

			if 2 <= arg_230_1.time_ and arg_230_1.time_ < 2 + var_233_12 then
				var_233_11.localPosition = Vector3.Lerp(arg_230_1.var_.moveOldPos10058ui_story, Vector3.New(0, 100, 0), (arg_230_1.time_ - 2) / var_233_12)
				var_233_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_233_11.position).x, (manager.ui.mainCamera.transform.position - var_233_11.position).y, (manager.ui.mainCamera.transform.position - var_233_11.position).z)
				var_233_11.localEulerAngles.z = 0
				var_233_11.localEulerAngles.x = 0
				var_233_11.localEulerAngles = var_233_11.localEulerAngles
			end

			if arg_230_1.time_ >= 2 + var_233_12 and arg_230_1.time_ < 2 + var_233_12 + arg_233_0 then
				var_233_11.localPosition = Vector3.New(0, 100, 0)
				var_233_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_233_11.position).x, (manager.ui.mainCamera.transform.position - var_233_11.position).y, (manager.ui.mainCamera.transform.position - var_233_11.position).z)
				var_233_11.localEulerAngles.z = 0
				var_233_11.localEulerAngles.x = 0
				var_233_11.localEulerAngles = var_233_11.localEulerAngles
			end

			local var_233_13 = arg_230_1.actors_["10058ui_story"]

			if 2 < arg_230_1.time_ and arg_230_1.time_ <= 2 + arg_233_0 and not isNil(var_233_13) and arg_230_1.var_.characterEffect10058ui_story == nil then
				arg_230_1.var_.characterEffect10058ui_story = var_233_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_233_14 = 0.200000002980232

			if 2 <= arg_230_1.time_ and arg_230_1.time_ < 2 + var_233_14 and not isNil(var_233_13) then
				if arg_230_1.var_.characterEffect10058ui_story and not isNil(var_233_13) then
					arg_230_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_230_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_230_1.time_ - 2) / var_233_14)
				end
			end

			if arg_230_1.time_ >= 2 + var_233_14 and arg_230_1.time_ < 2 + var_233_14 + arg_233_0 and not isNil(var_233_13) and arg_230_1.var_.characterEffect10058ui_story then
				arg_230_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_230_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			if arg_230_1.frameCnt_ <= 1 then
				arg_230_1.dialog_:SetActive(false)
			end

			local var_233_15 = 4
			local var_233_16 = 0.6

			if 4 < arg_230_1.time_ and arg_230_1.time_ <= var_233_15 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0

				arg_230_1.dialog_:SetActive(true)

				arg_230_1.dialogCg_.alpha = 0

				local var_233_17 = LeanTween.value(arg_230_1.dialog_, 0, 1, 0.3)

				var_233_17:setOnUpdate(LuaHelper.FloatAction(function(arg_234_0)
					arg_230_1.dialogCg_.alpha = arg_234_0
				end))
				var_233_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_230_1.dialog_)
					var_233_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_230_1.duration_ = arg_230_1.duration_ + 0.3

				SetActive(arg_230_1.leftNameGo_, false)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_18 = arg_230_1:FormatText(arg_230_1:GetWordFromCfg(411241056).content)

				arg_230_1.text_.text = var_233_18

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_20 = 24 <= 0 and var_233_16 or var_233_16 * (utf8.len(var_233_18) / 24)

				if (24 <= 0 and var_233_16 or var_233_16 * (utf8.len(var_233_18) / 24)) > 0 and var_233_16 < var_233_20 then
					arg_230_1.talkMaxDuration = var_233_20
					var_233_15 = var_233_15 + 0.3

					if var_233_20 + var_233_15 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_20 + var_233_15
					end
				end

				arg_230_1.text_.text = var_233_18
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)
				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_21 = var_233_15 + 0.3
			local var_233_22 = math.max(var_233_16, arg_230_1.talkMaxDuration)

			if var_233_15 + 0.3 <= arg_230_1.time_ and arg_230_1.time_ < var_233_21 + var_233_22 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_21) / var_233_22

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_21 + var_233_22 and arg_230_1.time_ < var_233_21 + var_233_22 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_230_1:InitPlayNodeList()
	end,
	Play411241057 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 411241057
		arg_236_1.duration_ = 2

		SetActive(arg_236_1.tipsGo_, false)

		function arg_236_1.onSingleLineFinish_()
			arg_236_1.onSingleLineUpdate_ = nil
			arg_236_1.onSingleLineFinish_ = nil
			arg_236_1.state_ = "waiting"
		end

		function arg_236_1.playNext_(arg_238_0)
			if arg_238_0 == 1 then
				arg_236_0:Play411241058(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 then
				arg_236_1.var_.moveOldPos10058ui_story = arg_236_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_239_0 = 0.001

			if 0 <= arg_236_1.time_ and arg_236_1.time_ < 0 + var_239_0 then
				arg_236_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_236_1.var_.moveOldPos10058ui_story, Vector3.New(0, -0.98, -6.1), (arg_236_1.time_ - 0) / var_239_0)
				arg_236_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_236_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_236_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_236_1.actors_["10058ui_story"].transform.position).z)
				arg_236_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_236_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_236_1.actors_["10058ui_story"].transform.localEulerAngles = arg_236_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_236_1.time_ >= 0 + var_239_0 and arg_236_1.time_ < 0 + var_239_0 + arg_239_0 then
				arg_236_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_236_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_236_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_236_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_236_1.actors_["10058ui_story"].transform.position).z)
				arg_236_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_236_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_236_1.actors_["10058ui_story"].transform.localEulerAngles = arg_236_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_239_1 = arg_236_1.actors_["10058ui_story"]

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 and not isNil(var_239_1) and arg_236_1.var_.characterEffect10058ui_story == nil then
				arg_236_1.var_.characterEffect10058ui_story = var_239_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_239_2 = 0.200000002980232

			if 0 <= arg_236_1.time_ and arg_236_1.time_ < 0 + var_239_2 and not isNil(var_239_1) then
				if arg_236_1.var_.characterEffect10058ui_story and not isNil(var_239_1) then
					arg_236_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_236_1.time_ >= 0 + var_239_2 and arg_236_1.time_ < 0 + var_239_2 + arg_239_0 and not isNil(var_239_1) and arg_236_1.var_.characterEffect10058ui_story then
				arg_236_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 then
				arg_236_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095actionlink/1095action447")
			end

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 then
				arg_236_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_239_4 = 0
			local var_239_5 = 0.1

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= var_239_4 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, true)

				arg_236_1.leftNameTxt_.text = arg_236_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_236_1.leftNameTxt_.transform)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1.leftNameTxt_.text)
				SetActive(arg_236_1.iconTrs_.gameObject, false)
				arg_236_1.callingController_:SetSelectedState("normal")

				local var_239_6 = arg_236_1:GetWordFromCfg(411241057)
				local var_239_7 = arg_236_1:FormatText(var_239_6.content)

				arg_236_1.text_.text = var_239_7

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_9 = 4 <= 0 and var_239_5 or var_239_5 * (utf8.len(var_239_7) / 4)

				if (4 <= 0 and var_239_5 or var_239_5 * (utf8.len(var_239_7) / 4)) > 0 and var_239_5 < var_239_9 then
					arg_236_1.talkMaxDuration = var_239_9

					if var_239_9 + var_239_4 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_9 + var_239_4
					end
				end

				arg_236_1.text_.text = var_239_7
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411241", "411241057", "story_v_out_411241.awb") ~= 0 then
					local var_239_10 = manager.audio:GetVoiceLength("story_v_out_411241", "411241057", "story_v_out_411241.awb") / 1000

					if var_239_10 + var_239_4 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_10 + var_239_4
					end

					if var_239_6.prefab_name ~= "" and arg_236_1.actors_[var_239_6.prefab_name] ~= nil then
						local var_239_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_236_1.actors_[var_239_6.prefab_name].transform, "story_v_out_411241", "411241057", "story_v_out_411241.awb")

						arg_236_1:RecordAudio("411241057", var_239_11)
						arg_236_1:RecordAudio("411241057", var_239_11)
					else
						arg_236_1:AudioAction("play", "voice", "story_v_out_411241", "411241057", "story_v_out_411241.awb")
					end

					arg_236_1:RecordHistoryTalkVoice("story_v_out_411241", "411241057", "story_v_out_411241.awb")
				end

				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_12 = math.max(var_239_5, arg_236_1.talkMaxDuration)

			if var_239_4 <= arg_236_1.time_ and arg_236_1.time_ < var_239_4 + var_239_12 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - var_239_4) / var_239_12

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= var_239_4 + var_239_12 and arg_236_1.time_ < var_239_4 + var_239_12 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_236_1:InitPlayNodeList()
	end,
	Play411241058 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 411241058
		arg_240_1.duration_ = 5.83

		local var_240_0 = {
			zh = 5.833,
			ja = 5.533
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
				arg_240_0:Play411241059(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 and not isNil(arg_240_1.actors_["10058ui_story"]) and arg_240_1.var_.characterEffect10058ui_story == nil then
				arg_240_1.var_.characterEffect10058ui_story = arg_240_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_243_0 = 0.200000002980232

			if 0 <= arg_240_1.time_ and arg_240_1.time_ < 0 + var_243_0 and not isNil(arg_240_1.actors_["10058ui_story"]) then
				if arg_240_1.var_.characterEffect10058ui_story and not isNil(arg_240_1.actors_["10058ui_story"]) then
					arg_240_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_240_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_240_1.time_ - 0) / var_243_0)
				end
			end

			if arg_240_1.time_ >= 0 + var_243_0 and arg_240_1.time_ < 0 + var_243_0 + arg_243_0 and not isNil(arg_240_1.actors_["10058ui_story"]) and arg_240_1.var_.characterEffect10058ui_story then
				arg_240_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_240_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_243_1 = 0
			local var_243_2 = 0.3

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= var_243_1 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, true)

				arg_240_1.leftNameTxt_.text = arg_240_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_240_1.leftNameTxt_.transform)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1.leftNameTxt_.text)
				SetActive(arg_240_1.iconTrs_.gameObject, true)
				arg_240_1.iconController_:SetSelectedState("hero")

				arg_240_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10025_1")

				arg_240_1.callingController_:SetSelectedState("normal")

				arg_240_1.keyicon_.color = Color.New(1, 1, 1)
				arg_240_1.icon_.color = Color.New(1, 1, 1)

				local var_243_3 = arg_240_1:GetWordFromCfg(411241058)
				local var_243_4 = arg_240_1:FormatText(var_243_3.content)

				arg_240_1.text_.text = var_243_4

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_6 = 12 <= 0 and var_243_2 or var_243_2 * (utf8.len(var_243_4) / 12)

				if (12 <= 0 and var_243_2 or var_243_2 * (utf8.len(var_243_4) / 12)) > 0 and var_243_2 < var_243_6 then
					arg_240_1.talkMaxDuration = var_243_6

					if var_243_6 + var_243_1 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_6 + var_243_1
					end
				end

				arg_240_1.text_.text = var_243_4
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411241", "411241058", "story_v_out_411241.awb") ~= 0 then
					local var_243_7 = manager.audio:GetVoiceLength("story_v_out_411241", "411241058", "story_v_out_411241.awb") / 1000

					if var_243_7 + var_243_1 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_7 + var_243_1
					end

					if var_243_3.prefab_name ~= "" and arg_240_1.actors_[var_243_3.prefab_name] ~= nil then
						local var_243_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_240_1.actors_[var_243_3.prefab_name].transform, "story_v_out_411241", "411241058", "story_v_out_411241.awb")

						arg_240_1:RecordAudio("411241058", var_243_8)
						arg_240_1:RecordAudio("411241058", var_243_8)
					else
						arg_240_1:AudioAction("play", "voice", "story_v_out_411241", "411241058", "story_v_out_411241.awb")
					end

					arg_240_1:RecordHistoryTalkVoice("story_v_out_411241", "411241058", "story_v_out_411241.awb")
				end

				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_9 = math.max(var_243_2, arg_240_1.talkMaxDuration)

			if var_243_1 <= arg_240_1.time_ and arg_240_1.time_ < var_243_1 + var_243_9 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - var_243_1) / var_243_9

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= var_243_1 + var_243_9 and arg_240_1.time_ < var_243_1 + var_243_9 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {}

		arg_240_1:InitPlayNodeList()
	end,
	Play411241059 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 411241059
		arg_244_1.duration_ = 5

		SetActive(arg_244_1.tipsGo_, false)

		function arg_244_1.onSingleLineFinish_()
			arg_244_1.onSingleLineUpdate_ = nil
			arg_244_1.onSingleLineFinish_ = nil
			arg_244_1.state_ = "waiting"
		end

		function arg_244_1.playNext_(arg_246_0)
			if arg_246_0 == 1 then
				arg_244_0:Play411241060(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 then
				arg_244_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action7_2")
			end

			local var_247_0 = 0
			local var_247_1 = 0.925

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= var_247_0 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, false)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_244_1.iconTrs_.gameObject, false)
				arg_244_1.callingController_:SetSelectedState("normal")

				local var_247_2 = arg_244_1:FormatText(arg_244_1:GetWordFromCfg(411241059).content)

				arg_244_1.text_.text = var_247_2

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_4 = 37 <= 0 and var_247_1 or var_247_1 * (utf8.len(var_247_2) / 37)

				if (37 <= 0 and var_247_1 or var_247_1 * (utf8.len(var_247_2) / 37)) > 0 and var_247_1 < var_247_4 then
					arg_244_1.talkMaxDuration = var_247_4

					if var_247_4 + var_247_0 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_4 + var_247_0
					end
				end

				arg_244_1.text_.text = var_247_2
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)
				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_5 = math.max(var_247_1, arg_244_1.talkMaxDuration)

			if var_247_0 <= arg_244_1.time_ and arg_244_1.time_ < var_247_0 + var_247_5 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_0) / var_247_5

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_0 + var_247_5 and arg_244_1.time_ < var_247_0 + var_247_5 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {}

		arg_244_1:InitPlayNodeList()
	end,
	Play411241060 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 411241060
		arg_248_1.duration_ = 4.33

		local var_248_0 = {
			zh = 1.999999999999,
			ja = 4.333
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
				arg_248_0:Play411241061(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 then
				arg_248_1.var_.moveOldPos10058ui_story = arg_248_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_251_0 = 0.001

			if 0 <= arg_248_1.time_ and arg_248_1.time_ < 0 + var_251_0 then
				arg_248_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_248_1.var_.moveOldPos10058ui_story, Vector3.New(0, -0.98, -6.1), (arg_248_1.time_ - 0) / var_251_0)
				arg_248_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_248_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_248_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_248_1.actors_["10058ui_story"].transform.position).z)
				arg_248_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_248_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_248_1.actors_["10058ui_story"].transform.localEulerAngles = arg_248_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_248_1.time_ >= 0 + var_251_0 and arg_248_1.time_ < 0 + var_251_0 + arg_251_0 then
				arg_248_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_248_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_248_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_248_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_248_1.actors_["10058ui_story"].transform.position).z)
				arg_248_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_248_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_248_1.actors_["10058ui_story"].transform.localEulerAngles = arg_248_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_251_1 = arg_248_1.actors_["10058ui_story"]

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 and not isNil(var_251_1) and arg_248_1.var_.characterEffect10058ui_story == nil then
				arg_248_1.var_.characterEffect10058ui_story = var_251_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_251_2 = 0.200000002980232

			if 0 <= arg_248_1.time_ and arg_248_1.time_ < 0 + var_251_2 and not isNil(var_251_1) then
				if arg_248_1.var_.characterEffect10058ui_story and not isNil(var_251_1) then
					arg_248_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_248_1.time_ >= 0 + var_251_2 and arg_248_1.time_ < 0 + var_251_2 + arg_251_0 and not isNil(var_251_1) and arg_248_1.var_.characterEffect10058ui_story then
				arg_248_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 then
				arg_248_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_251_4 = 0
			local var_251_5 = 0.2

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= var_251_4 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, true)

				arg_248_1.leftNameTxt_.text = arg_248_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_248_1.leftNameTxt_.transform)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1.leftNameTxt_.text)
				SetActive(arg_248_1.iconTrs_.gameObject, false)
				arg_248_1.callingController_:SetSelectedState("normal")

				local var_251_6 = arg_248_1:GetWordFromCfg(411241060)
				local var_251_7 = arg_248_1:FormatText(var_251_6.content)

				arg_248_1.text_.text = var_251_7

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_9 = 8 <= 0 and var_251_5 or var_251_5 * (utf8.len(var_251_7) / 8)

				if (8 <= 0 and var_251_5 or var_251_5 * (utf8.len(var_251_7) / 8)) > 0 and var_251_5 < var_251_9 then
					arg_248_1.talkMaxDuration = var_251_9

					if var_251_9 + var_251_4 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_9 + var_251_4
					end
				end

				arg_248_1.text_.text = var_251_7
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411241", "411241060", "story_v_out_411241.awb") ~= 0 then
					local var_251_10 = manager.audio:GetVoiceLength("story_v_out_411241", "411241060", "story_v_out_411241.awb") / 1000

					if var_251_10 + var_251_4 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_10 + var_251_4
					end

					if var_251_6.prefab_name ~= "" and arg_248_1.actors_[var_251_6.prefab_name] ~= nil then
						local var_251_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_248_1.actors_[var_251_6.prefab_name].transform, "story_v_out_411241", "411241060", "story_v_out_411241.awb")

						arg_248_1:RecordAudio("411241060", var_251_11)
						arg_248_1:RecordAudio("411241060", var_251_11)
					else
						arg_248_1:AudioAction("play", "voice", "story_v_out_411241", "411241060", "story_v_out_411241.awb")
					end

					arg_248_1:RecordHistoryTalkVoice("story_v_out_411241", "411241060", "story_v_out_411241.awb")
				end

				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_12 = math.max(var_251_5, arg_248_1.talkMaxDuration)

			if var_251_4 <= arg_248_1.time_ and arg_248_1.time_ < var_251_4 + var_251_12 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - var_251_4) / var_251_12

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= var_251_4 + var_251_12 and arg_248_1.time_ < var_251_4 + var_251_12 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_248_1:InitPlayNodeList()
	end,
	Play411241061 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 411241061
		arg_252_1.duration_ = 5

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play411241062(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 and not isNil(arg_252_1.actors_["10058ui_story"]) and arg_252_1.var_.characterEffect10058ui_story == nil then
				arg_252_1.var_.characterEffect10058ui_story = arg_252_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_255_0 = 0.200000002980232

			if 0 <= arg_252_1.time_ and arg_252_1.time_ < 0 + var_255_0 and not isNil(arg_252_1.actors_["10058ui_story"]) then
				if arg_252_1.var_.characterEffect10058ui_story and not isNil(arg_252_1.actors_["10058ui_story"]) then
					arg_252_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_252_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_252_1.time_ - 0) / var_255_0)
				end
			end

			if arg_252_1.time_ >= 0 + var_255_0 and arg_252_1.time_ < 0 + var_255_0 + arg_255_0 and not isNil(arg_252_1.actors_["10058ui_story"]) and arg_252_1.var_.characterEffect10058ui_story then
				arg_252_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_252_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_255_1 = 0
			local var_255_2 = 0.525

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= var_255_1 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, false)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_252_1.iconTrs_.gameObject, false)
				arg_252_1.callingController_:SetSelectedState("normal")

				local var_255_3 = arg_252_1:FormatText(arg_252_1:GetWordFromCfg(411241061).content)

				arg_252_1.text_.text = var_255_3

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_5 = 21 <= 0 and var_255_2 or var_255_2 * (utf8.len(var_255_3) / 21)

				if (21 <= 0 and var_255_2 or var_255_2 * (utf8.len(var_255_3) / 21)) > 0 and var_255_2 < var_255_5 then
					arg_252_1.talkMaxDuration = var_255_5

					if var_255_5 + var_255_1 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_5 + var_255_1
					end
				end

				arg_252_1.text_.text = var_255_3
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)
				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_6 = math.max(var_255_2, arg_252_1.talkMaxDuration)

			if var_255_1 <= arg_252_1.time_ and arg_252_1.time_ < var_255_1 + var_255_6 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_1) / var_255_6

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_1 + var_255_6 and arg_252_1.time_ < var_255_1 + var_255_6 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {}

		arg_252_1:InitPlayNodeList()
	end,
	Play411241062 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 411241062
		arg_256_1.duration_ = 7.67

		local var_256_0 = {
			zh = 1.999999999999,
			ja = 7.666
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
				arg_256_0:Play411241063(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 and not isNil(arg_256_1.actors_["10058ui_story"]) and arg_256_1.var_.characterEffect10058ui_story == nil then
				arg_256_1.var_.characterEffect10058ui_story = arg_256_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_259_0 = 0.200000002980232

			if 0 <= arg_256_1.time_ and arg_256_1.time_ < 0 + var_259_0 and not isNil(arg_256_1.actors_["10058ui_story"]) then
				if arg_256_1.var_.characterEffect10058ui_story and not isNil(arg_256_1.actors_["10058ui_story"]) then
					arg_256_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_256_1.time_ >= 0 + var_259_0 and arg_256_1.time_ < 0 + var_259_0 + arg_259_0 and not isNil(arg_256_1.actors_["10058ui_story"]) and arg_256_1.var_.characterEffect10058ui_story then
				arg_256_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 then
				arg_256_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_259_2 = 0
			local var_259_3 = 0.15

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= var_259_2 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, true)

				arg_256_1.leftNameTxt_.text = arg_256_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_256_1.leftNameTxt_.transform)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1.leftNameTxt_.text)
				SetActive(arg_256_1.iconTrs_.gameObject, false)
				arg_256_1.callingController_:SetSelectedState("normal")

				local var_259_4 = arg_256_1:GetWordFromCfg(411241062)
				local var_259_5 = arg_256_1:FormatText(var_259_4.content)

				arg_256_1.text_.text = var_259_5

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_7 = 6 <= 0 and var_259_3 or var_259_3 * (utf8.len(var_259_5) / 6)

				if (6 <= 0 and var_259_3 or var_259_3 * (utf8.len(var_259_5) / 6)) > 0 and var_259_3 < var_259_7 then
					arg_256_1.talkMaxDuration = var_259_7

					if var_259_7 + var_259_2 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_7 + var_259_2
					end
				end

				arg_256_1.text_.text = var_259_5
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411241", "411241062", "story_v_out_411241.awb") ~= 0 then
					local var_259_8 = manager.audio:GetVoiceLength("story_v_out_411241", "411241062", "story_v_out_411241.awb") / 1000

					if var_259_8 + var_259_2 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_8 + var_259_2
					end

					if var_259_4.prefab_name ~= "" and arg_256_1.actors_[var_259_4.prefab_name] ~= nil then
						local var_259_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_256_1.actors_[var_259_4.prefab_name].transform, "story_v_out_411241", "411241062", "story_v_out_411241.awb")

						arg_256_1:RecordAudio("411241062", var_259_9)
						arg_256_1:RecordAudio("411241062", var_259_9)
					else
						arg_256_1:AudioAction("play", "voice", "story_v_out_411241", "411241062", "story_v_out_411241.awb")
					end

					arg_256_1:RecordHistoryTalkVoice("story_v_out_411241", "411241062", "story_v_out_411241.awb")
				end

				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_10 = math.max(var_259_3, arg_256_1.talkMaxDuration)

			if var_259_2 <= arg_256_1.time_ and arg_256_1.time_ < var_259_2 + var_259_10 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - var_259_2) / var_259_10

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= var_259_2 + var_259_10 and arg_256_1.time_ < var_259_2 + var_259_10 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {}

		arg_256_1:InitPlayNodeList()
	end,
	Play411241063 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 411241063
		arg_260_1.duration_ = 5

		SetActive(arg_260_1.tipsGo_, false)

		function arg_260_1.onSingleLineFinish_()
			arg_260_1.onSingleLineUpdate_ = nil
			arg_260_1.onSingleLineFinish_ = nil
			arg_260_1.state_ = "waiting"
		end

		function arg_260_1.playNext_(arg_262_0)
			if arg_262_0 == 1 then
				arg_260_0:Play411241064(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 then
				arg_260_1.var_.moveOldPos10058ui_story = arg_260_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_263_0 = 0.001

			if 0 <= arg_260_1.time_ and arg_260_1.time_ < 0 + var_263_0 then
				arg_260_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_260_1.var_.moveOldPos10058ui_story, Vector3.New(0, 100, 0), (arg_260_1.time_ - 0) / var_263_0)
				arg_260_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_260_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_260_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_260_1.actors_["10058ui_story"].transform.position).z)
				arg_260_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_260_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_260_1.actors_["10058ui_story"].transform.localEulerAngles = arg_260_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_260_1.time_ >= 0 + var_263_0 and arg_260_1.time_ < 0 + var_263_0 + arg_263_0 then
				arg_260_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_260_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_260_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_260_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_260_1.actors_["10058ui_story"].transform.position).z)
				arg_260_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_260_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_260_1.actors_["10058ui_story"].transform.localEulerAngles = arg_260_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_263_1 = arg_260_1.actors_["10058ui_story"]

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 and not isNil(var_263_1) and arg_260_1.var_.characterEffect10058ui_story == nil then
				arg_260_1.var_.characterEffect10058ui_story = var_263_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_263_2 = 0.200000002980232

			if 0 <= arg_260_1.time_ and arg_260_1.time_ < 0 + var_263_2 and not isNil(var_263_1) then
				if arg_260_1.var_.characterEffect10058ui_story and not isNil(var_263_1) then
					arg_260_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_260_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_260_1.time_ - 0) / var_263_2)
				end
			end

			if arg_260_1.time_ >= 0 + var_263_2 and arg_260_1.time_ < 0 + var_263_2 + arg_263_0 and not isNil(var_263_1) and arg_260_1.var_.characterEffect10058ui_story then
				arg_260_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_260_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_263_3 = 0
			local var_263_4 = 0.95

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= var_263_3 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0
				arg_260_1.dialogCg_.alpha = 1

				arg_260_1.dialog_:SetActive(true)
				SetActive(arg_260_1.leftNameGo_, false)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_260_1.iconTrs_.gameObject, false)
				arg_260_1.callingController_:SetSelectedState("normal")

				local var_263_5 = arg_260_1:FormatText(arg_260_1:GetWordFromCfg(411241063).content)

				arg_260_1.text_.text = var_263_5

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_7 = 38 <= 0 and var_263_4 or var_263_4 * (utf8.len(var_263_5) / 38)

				if (38 <= 0 and var_263_4 or var_263_4 * (utf8.len(var_263_5) / 38)) > 0 and var_263_4 < var_263_7 then
					arg_260_1.talkMaxDuration = var_263_7

					if var_263_7 + var_263_3 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_7 + var_263_3
					end
				end

				arg_260_1.text_.text = var_263_5
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)
				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_8 = math.max(var_263_4, arg_260_1.talkMaxDuration)

			if var_263_3 <= arg_260_1.time_ and arg_260_1.time_ < var_263_3 + var_263_8 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - var_263_3) / var_263_8

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= var_263_3 + var_263_8 and arg_260_1.time_ < var_263_3 + var_263_8 + arg_263_0 then
				arg_260_1.typewritter.percent = 1

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(true)
			end
		end

		arg_260_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_260_1:InitPlayNodeList()
	end,
	Play411241064 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 411241064
		arg_264_1.duration_ = 5

		SetActive(arg_264_1.tipsGo_, false)

		function arg_264_1.onSingleLineFinish_()
			arg_264_1.onSingleLineUpdate_ = nil
			arg_264_1.onSingleLineFinish_ = nil
			arg_264_1.state_ = "waiting"
		end

		function arg_264_1.playNext_(arg_266_0)
			if arg_266_0 == 1 then
				arg_264_0:Play411241065(arg_264_1)
			end
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 then
				arg_264_1:AudioAction("play", "effect", "se_story", "se_story_communication", "")
			end

			local var_267_1 = 0
			local var_267_2 = 0.7

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= var_267_1 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0
				arg_264_1.dialogCg_.alpha = 1

				arg_264_1.dialog_:SetActive(true)
				SetActive(arg_264_1.leftNameGo_, false)

				arg_264_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_264_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_264_1:RecordName(arg_264_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_264_1.iconTrs_.gameObject, false)
				arg_264_1.callingController_:SetSelectedState("normal")

				local var_267_3 = arg_264_1:FormatText(arg_264_1:GetWordFromCfg(411241064).content)

				arg_264_1.text_.text = var_267_3

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_5 = 28 <= 0 and var_267_2 or var_267_2 * (utf8.len(var_267_3) / 28)

				if (28 <= 0 and var_267_2 or var_267_2 * (utf8.len(var_267_3) / 28)) > 0 and var_267_2 < var_267_5 then
					arg_264_1.talkMaxDuration = var_267_5

					if var_267_5 + var_267_1 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_5 + var_267_1
					end
				end

				arg_264_1.text_.text = var_267_3
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)
				arg_264_1:RecordContent(arg_264_1.text_.text)
			end

			local var_267_6 = math.max(var_267_2, arg_264_1.talkMaxDuration)

			if var_267_1 <= arg_264_1.time_ and arg_264_1.time_ < var_267_1 + var_267_6 then
				arg_264_1.typewritter.percent = (arg_264_1.time_ - var_267_1) / var_267_6

				arg_264_1.typewritter:SetDirty()
			end

			if arg_264_1.time_ >= var_267_1 + var_267_6 and arg_264_1.time_ < var_267_1 + var_267_6 + arg_267_0 then
				arg_264_1.typewritter.percent = 1

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(true)
			end
		end

		arg_264_1.nodeConfigList_ = {}

		arg_264_1:InitPlayNodeList()
	end,
	Play411241065 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 411241065
		arg_268_1.duration_ = 5

		SetActive(arg_268_1.tipsGo_, false)

		function arg_268_1.onSingleLineFinish_()
			arg_268_1.onSingleLineUpdate_ = nil
			arg_268_1.onSingleLineFinish_ = nil
			arg_268_1.state_ = "waiting"
		end

		function arg_268_1.playNext_(arg_270_0)
			if arg_270_0 == 1 then
				arg_268_0:Play411241066(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			local var_271_0 = 0.775

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0
				arg_268_1.dialogCg_.alpha = 1

				arg_268_1.dialog_:SetActive(true)
				SetActive(arg_268_1.leftNameGo_, true)

				arg_268_1.leftNameTxt_.text = arg_268_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_268_1.leftNameTxt_.transform)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1.leftNameTxt_.text)
				SetActive(arg_268_1.iconTrs_.gameObject, true)
				arg_268_1.iconController_:SetSelectedState("hero")

				arg_268_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037")

				arg_268_1.callingController_:SetSelectedState("normal")

				arg_268_1.keyicon_.color = Color.New(1, 1, 1)
				arg_268_1.icon_.color = Color.New(1, 1, 1)

				local var_271_1 = arg_268_1:FormatText(arg_268_1:GetWordFromCfg(411241065).content)

				arg_268_1.text_.text = var_271_1

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_3 = 30 <= 0 and var_271_0 or var_271_0 * (utf8.len(var_271_1) / 30)

				if (30 <= 0 and var_271_0 or var_271_0 * (utf8.len(var_271_1) / 30)) > 0 and var_271_0 < var_271_3 then
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
	Play411241066 = function(arg_272_0, arg_272_1)
		arg_272_1.time_ = 0
		arg_272_1.frameCnt_ = 0
		arg_272_1.state_ = "playing"
		arg_272_1.curTalkId_ = 411241066
		arg_272_1.duration_ = 5

		SetActive(arg_272_1.tipsGo_, false)

		function arg_272_1.onSingleLineFinish_()
			arg_272_1.onSingleLineUpdate_ = nil
			arg_272_1.onSingleLineFinish_ = nil
			arg_272_1.state_ = "waiting"
		end

		function arg_272_1.playNext_(arg_274_0)
			if arg_274_0 == 1 then
				arg_272_0:Play411241067(arg_272_1)
			end
		end

		function arg_272_1.onSingleLineUpdate_(arg_275_0)
			local var_275_0 = 0.425

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 then
				arg_272_1.talkMaxDuration = 0
				arg_272_1.dialogCg_.alpha = 1

				arg_272_1.dialog_:SetActive(true)
				SetActive(arg_272_1.leftNameGo_, true)

				arg_272_1.leftNameTxt_.text = arg_272_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_272_1.leftNameTxt_.transform)

				arg_272_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_272_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_272_1:RecordName(arg_272_1.leftNameTxt_.text)
				SetActive(arg_272_1.iconTrs_.gameObject, true)
				arg_272_1.iconController_:SetSelectedState("hero")

				arg_272_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037")

				arg_272_1.callingController_:SetSelectedState("normal")

				arg_272_1.keyicon_.color = Color.New(1, 1, 1)
				arg_272_1.icon_.color = Color.New(1, 1, 1)

				local var_275_1 = arg_272_1:FormatText(arg_272_1:GetWordFromCfg(411241066).content)

				arg_272_1.text_.text = var_275_1

				LuaForUtil.ClearLinePrefixSymbol(arg_272_1.text_)

				local var_275_3 = 17 <= 0 and var_275_0 or var_275_0 * (utf8.len(var_275_1) / 17)

				if (17 <= 0 and var_275_0 or var_275_0 * (utf8.len(var_275_1) / 17)) > 0 and var_275_0 < var_275_3 then
					arg_272_1.talkMaxDuration = var_275_3

					if var_275_3 + 0 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_3 + 0
					end
				end

				arg_272_1.text_.text = var_275_1
				arg_272_1.typewritter.percent = 0

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(false)
				arg_272_1:RecordContent(arg_272_1.text_.text)
			end

			local var_275_4 = math.max(var_275_0, arg_272_1.talkMaxDuration)

			if 0 <= arg_272_1.time_ and arg_272_1.time_ < 0 + var_275_4 then
				arg_272_1.typewritter.percent = (arg_272_1.time_ - 0) / var_275_4

				arg_272_1.typewritter:SetDirty()
			end

			if arg_272_1.time_ >= 0 + var_275_4 and arg_272_1.time_ < 0 + var_275_4 + arg_275_0 then
				arg_272_1.typewritter.percent = 1

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(true)
			end
		end

		arg_272_1.nodeConfigList_ = {}

		arg_272_1:InitPlayNodeList()
	end,
	Play411241067 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 411241067
		arg_276_1.duration_ = 1.57

		local var_276_0 = {
			zh = 1.433,
			ja = 1.566
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
				arg_276_0:Play411241068(arg_276_1)
			end
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			local var_279_0 = 0.1

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0
				arg_276_1.dialogCg_.alpha = 1

				arg_276_1.dialog_:SetActive(true)
				SetActive(arg_276_1.leftNameGo_, true)

				arg_276_1.leftNameTxt_.text = arg_276_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_276_1.leftNameTxt_.transform)

				arg_276_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_276_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_276_1:RecordName(arg_276_1.leftNameTxt_.text)
				SetActive(arg_276_1.iconTrs_.gameObject, true)
				arg_276_1.iconController_:SetSelectedState("hero")

				arg_276_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10025_1")

				arg_276_1.callingController_:SetSelectedState("normal")

				arg_276_1.keyicon_.color = Color.New(1, 1, 1)
				arg_276_1.icon_.color = Color.New(1, 1, 1)

				local var_279_1 = arg_276_1:GetWordFromCfg(411241067)
				local var_279_2 = arg_276_1:FormatText(var_279_1.content)

				arg_276_1.text_.text = var_279_2

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_4 = 4 <= 0 and var_279_0 or var_279_0 * (utf8.len(var_279_2) / 4)

				if (4 <= 0 and var_279_0 or var_279_0 * (utf8.len(var_279_2) / 4)) > 0 and var_279_0 < var_279_4 then
					arg_276_1.talkMaxDuration = var_279_4

					if var_279_4 + 0 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_4 + 0
					end
				end

				arg_276_1.text_.text = var_279_2
				arg_276_1.typewritter.percent = 0

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411241", "411241067", "story_v_out_411241.awb") ~= 0 then
					local var_279_5 = manager.audio:GetVoiceLength("story_v_out_411241", "411241067", "story_v_out_411241.awb") / 1000

					if var_279_5 + 0 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_5 + 0
					end

					if var_279_1.prefab_name ~= "" and arg_276_1.actors_[var_279_1.prefab_name] ~= nil then
						local var_279_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_276_1.actors_[var_279_1.prefab_name].transform, "story_v_out_411241", "411241067", "story_v_out_411241.awb")

						arg_276_1:RecordAudio("411241067", var_279_6)
						arg_276_1:RecordAudio("411241067", var_279_6)
					else
						arg_276_1:AudioAction("play", "voice", "story_v_out_411241", "411241067", "story_v_out_411241.awb")
					end

					arg_276_1:RecordHistoryTalkVoice("story_v_out_411241", "411241067", "story_v_out_411241.awb")
				end

				arg_276_1:RecordContent(arg_276_1.text_.text)
			end

			local var_279_7 = math.max(var_279_0, arg_276_1.talkMaxDuration)

			if 0 <= arg_276_1.time_ and arg_276_1.time_ < 0 + var_279_7 then
				arg_276_1.typewritter.percent = (arg_276_1.time_ - 0) / var_279_7

				arg_276_1.typewritter:SetDirty()
			end

			if arg_276_1.time_ >= 0 + var_279_7 and arg_276_1.time_ < 0 + var_279_7 + arg_279_0 then
				arg_276_1.typewritter.percent = 1

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(true)
			end
		end

		arg_276_1.nodeConfigList_ = {}

		arg_276_1:InitPlayNodeList()
	end,
	Play411241068 = function(arg_280_0, arg_280_1)
		arg_280_1.time_ = 0
		arg_280_1.frameCnt_ = 0
		arg_280_1.state_ = "playing"
		arg_280_1.curTalkId_ = 411241068
		arg_280_1.duration_ = 2

		SetActive(arg_280_1.tipsGo_, false)

		function arg_280_1.onSingleLineFinish_()
			arg_280_1.onSingleLineUpdate_ = nil
			arg_280_1.onSingleLineFinish_ = nil
			arg_280_1.state_ = "waiting"
		end

		function arg_280_1.playNext_(arg_282_0)
			if arg_282_0 == 1 then
				arg_280_0:Play411241069(arg_280_1)
			end
		end

		function arg_280_1.onSingleLineUpdate_(arg_283_0)
			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 then
				arg_280_1.var_.moveOldPos10058ui_story = arg_280_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_283_0 = 0.001

			if 0 <= arg_280_1.time_ and arg_280_1.time_ < 0 + var_283_0 then
				arg_280_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_280_1.var_.moveOldPos10058ui_story, Vector3.New(0, -0.98, -6.1), (arg_280_1.time_ - 0) / var_283_0)
				arg_280_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_280_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_280_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_280_1.actors_["10058ui_story"].transform.position).z)
				arg_280_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_280_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_280_1.actors_["10058ui_story"].transform.localEulerAngles = arg_280_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_280_1.time_ >= 0 + var_283_0 and arg_280_1.time_ < 0 + var_283_0 + arg_283_0 then
				arg_280_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_280_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_280_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_280_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_280_1.actors_["10058ui_story"].transform.position).z)
				arg_280_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_280_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_280_1.actors_["10058ui_story"].transform.localEulerAngles = arg_280_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_283_1 = arg_280_1.actors_["10058ui_story"]

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 and not isNil(var_283_1) and arg_280_1.var_.characterEffect10058ui_story == nil then
				arg_280_1.var_.characterEffect10058ui_story = var_283_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_283_2 = 0.200000002980232

			if 0 <= arg_280_1.time_ and arg_280_1.time_ < 0 + var_283_2 and not isNil(var_283_1) then
				if arg_280_1.var_.characterEffect10058ui_story and not isNil(var_283_1) then
					arg_280_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_280_1.time_ >= 0 + var_283_2 and arg_280_1.time_ < 0 + var_283_2 + arg_283_0 and not isNil(var_283_1) and arg_280_1.var_.characterEffect10058ui_story then
				arg_280_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 then
				arg_280_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 then
				arg_280_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_283_4 = 0
			local var_283_5 = 0.1

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= var_283_4 + arg_283_0 then
				arg_280_1.talkMaxDuration = 0
				arg_280_1.dialogCg_.alpha = 1

				arg_280_1.dialog_:SetActive(true)
				SetActive(arg_280_1.leftNameGo_, true)

				arg_280_1.leftNameTxt_.text = arg_280_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_280_1.leftNameTxt_.transform)

				arg_280_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_280_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_280_1:RecordName(arg_280_1.leftNameTxt_.text)
				SetActive(arg_280_1.iconTrs_.gameObject, false)
				arg_280_1.callingController_:SetSelectedState("normal")

				local var_283_6 = arg_280_1:GetWordFromCfg(411241068)
				local var_283_7 = arg_280_1:FormatText(var_283_6.content)

				arg_280_1.text_.text = var_283_7

				LuaForUtil.ClearLinePrefixSymbol(arg_280_1.text_)

				local var_283_9 = 4 <= 0 and var_283_5 or var_283_5 * (utf8.len(var_283_7) / 4)

				if (4 <= 0 and var_283_5 or var_283_5 * (utf8.len(var_283_7) / 4)) > 0 and var_283_5 < var_283_9 then
					arg_280_1.talkMaxDuration = var_283_9

					if var_283_9 + var_283_4 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_9 + var_283_4
					end
				end

				arg_280_1.text_.text = var_283_7
				arg_280_1.typewritter.percent = 0

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411241", "411241068", "story_v_out_411241.awb") ~= 0 then
					local var_283_10 = manager.audio:GetVoiceLength("story_v_out_411241", "411241068", "story_v_out_411241.awb") / 1000

					if var_283_10 + var_283_4 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_10 + var_283_4
					end

					if var_283_6.prefab_name ~= "" and arg_280_1.actors_[var_283_6.prefab_name] ~= nil then
						local var_283_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_280_1.actors_[var_283_6.prefab_name].transform, "story_v_out_411241", "411241068", "story_v_out_411241.awb")

						arg_280_1:RecordAudio("411241068", var_283_11)
						arg_280_1:RecordAudio("411241068", var_283_11)
					else
						arg_280_1:AudioAction("play", "voice", "story_v_out_411241", "411241068", "story_v_out_411241.awb")
					end

					arg_280_1:RecordHistoryTalkVoice("story_v_out_411241", "411241068", "story_v_out_411241.awb")
				end

				arg_280_1:RecordContent(arg_280_1.text_.text)
			end

			local var_283_12 = math.max(var_283_5, arg_280_1.talkMaxDuration)

			if var_283_4 <= arg_280_1.time_ and arg_280_1.time_ < var_283_4 + var_283_12 then
				arg_280_1.typewritter.percent = (arg_280_1.time_ - var_283_4) / var_283_12

				arg_280_1.typewritter:SetDirty()
			end

			if arg_280_1.time_ >= var_283_4 + var_283_12 and arg_280_1.time_ < var_283_4 + var_283_12 + arg_283_0 then
				arg_280_1.typewritter.percent = 1

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(true)
			end
		end

		arg_280_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_280_1:InitPlayNodeList()
	end,
	Play411241069 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 411241069
		arg_284_1.duration_ = 3.3

		local var_284_0 = {
			zh = 2.2,
			ja = 3.3
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
				arg_284_0:Play411241070(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 and not isNil(arg_284_1.actors_["10058ui_story"]) and arg_284_1.var_.characterEffect10058ui_story == nil then
				arg_284_1.var_.characterEffect10058ui_story = arg_284_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_287_0 = 0.200000002980232

			if 0 <= arg_284_1.time_ and arg_284_1.time_ < 0 + var_287_0 and not isNil(arg_284_1.actors_["10058ui_story"]) then
				if arg_284_1.var_.characterEffect10058ui_story and not isNil(arg_284_1.actors_["10058ui_story"]) then
					arg_284_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_284_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_284_1.time_ - 0) / var_287_0)
				end
			end

			if arg_284_1.time_ >= 0 + var_287_0 and arg_284_1.time_ < 0 + var_287_0 + arg_287_0 and not isNil(arg_284_1.actors_["10058ui_story"]) and arg_284_1.var_.characterEffect10058ui_story then
				arg_284_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_284_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_287_1 = 0
			local var_287_2 = 0.175

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= var_287_1 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0
				arg_284_1.dialogCg_.alpha = 1

				arg_284_1.dialog_:SetActive(true)
				SetActive(arg_284_1.leftNameGo_, true)

				arg_284_1.leftNameTxt_.text = arg_284_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_284_1.leftNameTxt_.transform)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1.leftNameTxt_.text)
				SetActive(arg_284_1.iconTrs_.gameObject, true)
				arg_284_1.iconController_:SetSelectedState("hero")

				arg_284_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10025_1")

				arg_284_1.callingController_:SetSelectedState("normal")

				arg_284_1.keyicon_.color = Color.New(1, 1, 1)
				arg_284_1.icon_.color = Color.New(1, 1, 1)

				local var_287_3 = arg_284_1:GetWordFromCfg(411241069)
				local var_287_4 = arg_284_1:FormatText(var_287_3.content)

				arg_284_1.text_.text = var_287_4

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_6 = 7 <= 0 and var_287_2 or var_287_2 * (utf8.len(var_287_4) / 7)

				if (7 <= 0 and var_287_2 or var_287_2 * (utf8.len(var_287_4) / 7)) > 0 and var_287_2 < var_287_6 then
					arg_284_1.talkMaxDuration = var_287_6

					if var_287_6 + var_287_1 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_6 + var_287_1
					end
				end

				arg_284_1.text_.text = var_287_4
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411241", "411241069", "story_v_out_411241.awb") ~= 0 then
					local var_287_7 = manager.audio:GetVoiceLength("story_v_out_411241", "411241069", "story_v_out_411241.awb") / 1000

					if var_287_7 + var_287_1 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_7 + var_287_1
					end

					if var_287_3.prefab_name ~= "" and arg_284_1.actors_[var_287_3.prefab_name] ~= nil then
						local var_287_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_284_1.actors_[var_287_3.prefab_name].transform, "story_v_out_411241", "411241069", "story_v_out_411241.awb")

						arg_284_1:RecordAudio("411241069", var_287_8)
						arg_284_1:RecordAudio("411241069", var_287_8)
					else
						arg_284_1:AudioAction("play", "voice", "story_v_out_411241", "411241069", "story_v_out_411241.awb")
					end

					arg_284_1:RecordHistoryTalkVoice("story_v_out_411241", "411241069", "story_v_out_411241.awb")
				end

				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_9 = math.max(var_287_2, arg_284_1.talkMaxDuration)

			if var_287_1 <= arg_284_1.time_ and arg_284_1.time_ < var_287_1 + var_287_9 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - var_287_1) / var_287_9

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= var_287_1 + var_287_9 and arg_284_1.time_ < var_287_1 + var_287_9 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {}

		arg_284_1:InitPlayNodeList()
	end,
	Play411241070 = function(arg_288_0, arg_288_1)
		arg_288_1.time_ = 0
		arg_288_1.frameCnt_ = 0
		arg_288_1.state_ = "playing"
		arg_288_1.curTalkId_ = 411241070
		arg_288_1.duration_ = 5

		SetActive(arg_288_1.tipsGo_, false)

		function arg_288_1.onSingleLineFinish_()
			arg_288_1.onSingleLineUpdate_ = nil
			arg_288_1.onSingleLineFinish_ = nil
			arg_288_1.state_ = "waiting"
		end

		function arg_288_1.playNext_(arg_290_0)
			if arg_290_0 == 1 then
				arg_288_0:Play411241071(arg_288_1)
			end
		end

		function arg_288_1.onSingleLineUpdate_(arg_291_0)
			local var_291_0 = 0.6

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0
				arg_288_1.dialogCg_.alpha = 1

				arg_288_1.dialog_:SetActive(true)
				SetActive(arg_288_1.leftNameGo_, false)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_288_1.iconTrs_.gameObject, false)
				arg_288_1.callingController_:SetSelectedState("normal")

				local var_291_1 = arg_288_1:FormatText(arg_288_1:GetWordFromCfg(411241070).content)

				arg_288_1.text_.text = var_291_1

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_3 = 24 <= 0 and var_291_0 or var_291_0 * (utf8.len(var_291_1) / 24)

				if (24 <= 0 and var_291_0 or var_291_0 * (utf8.len(var_291_1) / 24)) > 0 and var_291_0 < var_291_3 then
					arg_288_1.talkMaxDuration = var_291_3

					if var_291_3 + 0 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_3 + 0
					end
				end

				arg_288_1.text_.text = var_291_1
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)
				arg_288_1:RecordContent(arg_288_1.text_.text)
			end

			local var_291_4 = math.max(var_291_0, arg_288_1.talkMaxDuration)

			if 0 <= arg_288_1.time_ and arg_288_1.time_ < 0 + var_291_4 then
				arg_288_1.typewritter.percent = (arg_288_1.time_ - 0) / var_291_4

				arg_288_1.typewritter:SetDirty()
			end

			if arg_288_1.time_ >= 0 + var_291_4 and arg_288_1.time_ < 0 + var_291_4 + arg_291_0 then
				arg_288_1.typewritter.percent = 1

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(true)
			end
		end

		arg_288_1.nodeConfigList_ = {}

		arg_288_1:InitPlayNodeList()
	end,
	Play411241071 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 411241071
		arg_292_1.duration_ = 7.6

		local var_292_0 = {
			zh = 7.6,
			ja = 5.833
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
				arg_292_0:Play411241072(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			local var_295_0 = 0.65

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0
				arg_292_1.dialogCg_.alpha = 1

				arg_292_1.dialog_:SetActive(true)
				SetActive(arg_292_1.leftNameGo_, true)

				arg_292_1.leftNameTxt_.text = arg_292_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_292_1.leftNameTxt_.transform)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1.leftNameTxt_.text)
				SetActive(arg_292_1.iconTrs_.gameObject, true)
				arg_292_1.iconController_:SetSelectedState("hero")

				arg_292_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10025_1")

				arg_292_1.callingController_:SetSelectedState("normal")

				arg_292_1.keyicon_.color = Color.New(1, 1, 1)
				arg_292_1.icon_.color = Color.New(1, 1, 1)

				local var_295_1 = arg_292_1:GetWordFromCfg(411241071)
				local var_295_2 = arg_292_1:FormatText(var_295_1.content)

				arg_292_1.text_.text = var_295_2

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_4 = 26 <= 0 and var_295_0 or var_295_0 * (utf8.len(var_295_2) / 26)

				if (26 <= 0 and var_295_0 or var_295_0 * (utf8.len(var_295_2) / 26)) > 0 and var_295_0 < var_295_4 then
					arg_292_1.talkMaxDuration = var_295_4

					if var_295_4 + 0 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_4 + 0
					end
				end

				arg_292_1.text_.text = var_295_2
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411241", "411241071", "story_v_out_411241.awb") ~= 0 then
					local var_295_5 = manager.audio:GetVoiceLength("story_v_out_411241", "411241071", "story_v_out_411241.awb") / 1000

					if var_295_5 + 0 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_5 + 0
					end

					if var_295_1.prefab_name ~= "" and arg_292_1.actors_[var_295_1.prefab_name] ~= nil then
						local var_295_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_292_1.actors_[var_295_1.prefab_name].transform, "story_v_out_411241", "411241071", "story_v_out_411241.awb")

						arg_292_1:RecordAudio("411241071", var_295_6)
						arg_292_1:RecordAudio("411241071", var_295_6)
					else
						arg_292_1:AudioAction("play", "voice", "story_v_out_411241", "411241071", "story_v_out_411241.awb")
					end

					arg_292_1:RecordHistoryTalkVoice("story_v_out_411241", "411241071", "story_v_out_411241.awb")
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
	Play411241072 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 411241072
		arg_296_1.duration_ = 5.7

		local var_296_0 = {
			zh = 5.7,
			ja = 4.733
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
				arg_296_0:Play411241073(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			local var_299_0 = 0.45

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0
				arg_296_1.dialogCg_.alpha = 1

				arg_296_1.dialog_:SetActive(true)
				SetActive(arg_296_1.leftNameGo_, true)

				arg_296_1.leftNameTxt_.text = arg_296_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_296_1.leftNameTxt_.transform)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1.leftNameTxt_.text)
				SetActive(arg_296_1.iconTrs_.gameObject, true)
				arg_296_1.iconController_:SetSelectedState("hero")

				arg_296_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10025_1")

				arg_296_1.callingController_:SetSelectedState("normal")

				arg_296_1.keyicon_.color = Color.New(1, 1, 1)
				arg_296_1.icon_.color = Color.New(1, 1, 1)

				local var_299_1 = arg_296_1:GetWordFromCfg(411241072)
				local var_299_2 = arg_296_1:FormatText(var_299_1.content)

				arg_296_1.text_.text = var_299_2

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_4 = 18 <= 0 and var_299_0 or var_299_0 * (utf8.len(var_299_2) / 18)

				if (18 <= 0 and var_299_0 or var_299_0 * (utf8.len(var_299_2) / 18)) > 0 and var_299_0 < var_299_4 then
					arg_296_1.talkMaxDuration = var_299_4

					if var_299_4 + 0 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_4 + 0
					end
				end

				arg_296_1.text_.text = var_299_2
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411241", "411241072", "story_v_out_411241.awb") ~= 0 then
					local var_299_5 = manager.audio:GetVoiceLength("story_v_out_411241", "411241072", "story_v_out_411241.awb") / 1000

					if var_299_5 + 0 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_5 + 0
					end

					if var_299_1.prefab_name ~= "" and arg_296_1.actors_[var_299_1.prefab_name] ~= nil then
						local var_299_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_296_1.actors_[var_299_1.prefab_name].transform, "story_v_out_411241", "411241072", "story_v_out_411241.awb")

						arg_296_1:RecordAudio("411241072", var_299_6)
						arg_296_1:RecordAudio("411241072", var_299_6)
					else
						arg_296_1:AudioAction("play", "voice", "story_v_out_411241", "411241072", "story_v_out_411241.awb")
					end

					arg_296_1:RecordHistoryTalkVoice("story_v_out_411241", "411241072", "story_v_out_411241.awb")
				end

				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_7 = math.max(var_299_0, arg_296_1.talkMaxDuration)

			if 0 <= arg_296_1.time_ and arg_296_1.time_ < 0 + var_299_7 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - 0) / var_299_7

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= 0 + var_299_7 and arg_296_1.time_ < 0 + var_299_7 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {}

		arg_296_1:InitPlayNodeList()
	end,
	Play411241073 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 411241073
		arg_300_1.duration_ = 5.87

		local var_300_0 = {
			zh = 3.566,
			ja = 5.866
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
				arg_300_0:Play411241074(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 then
				arg_300_1.var_.moveOldPos10058ui_story = arg_300_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_303_0 = 0.001

			if 0 <= arg_300_1.time_ and arg_300_1.time_ < 0 + var_303_0 then
				arg_300_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_300_1.var_.moveOldPos10058ui_story, Vector3.New(0, -0.98, -6.1), (arg_300_1.time_ - 0) / var_303_0)
				arg_300_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_300_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_300_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_300_1.actors_["10058ui_story"].transform.position).z)
				arg_300_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_300_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_300_1.actors_["10058ui_story"].transform.localEulerAngles = arg_300_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_300_1.time_ >= 0 + var_303_0 and arg_300_1.time_ < 0 + var_303_0 + arg_303_0 then
				arg_300_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_300_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_300_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_300_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_300_1.actors_["10058ui_story"].transform.position).z)
				arg_300_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_300_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_300_1.actors_["10058ui_story"].transform.localEulerAngles = arg_300_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_303_1 = arg_300_1.actors_["10058ui_story"]

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 and not isNil(var_303_1) and arg_300_1.var_.characterEffect10058ui_story == nil then
				arg_300_1.var_.characterEffect10058ui_story = var_303_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_303_2 = 0.200000002980232

			if 0 <= arg_300_1.time_ and arg_300_1.time_ < 0 + var_303_2 and not isNil(var_303_1) then
				if arg_300_1.var_.characterEffect10058ui_story and not isNil(var_303_1) then
					arg_300_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_300_1.time_ >= 0 + var_303_2 and arg_300_1.time_ < 0 + var_303_2 + arg_303_0 and not isNil(var_303_1) and arg_300_1.var_.characterEffect10058ui_story then
				arg_300_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 then
				arg_300_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_1")
			end

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 then
				arg_300_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_303_4 = 0
			local var_303_5 = 0.325

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= var_303_4 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0
				arg_300_1.dialogCg_.alpha = 1

				arg_300_1.dialog_:SetActive(true)
				SetActive(arg_300_1.leftNameGo_, true)

				arg_300_1.leftNameTxt_.text = arg_300_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_300_1.leftNameTxt_.transform)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1.leftNameTxt_.text)
				SetActive(arg_300_1.iconTrs_.gameObject, false)
				arg_300_1.callingController_:SetSelectedState("normal")

				local var_303_6 = arg_300_1:GetWordFromCfg(411241073)
				local var_303_7 = arg_300_1:FormatText(var_303_6.content)

				arg_300_1.text_.text = var_303_7

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_9 = 13 <= 0 and var_303_5 or var_303_5 * (utf8.len(var_303_7) / 13)

				if (13 <= 0 and var_303_5 or var_303_5 * (utf8.len(var_303_7) / 13)) > 0 and var_303_5 < var_303_9 then
					arg_300_1.talkMaxDuration = var_303_9

					if var_303_9 + var_303_4 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_9 + var_303_4
					end
				end

				arg_300_1.text_.text = var_303_7
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411241", "411241073", "story_v_out_411241.awb") ~= 0 then
					local var_303_10 = manager.audio:GetVoiceLength("story_v_out_411241", "411241073", "story_v_out_411241.awb") / 1000

					if var_303_10 + var_303_4 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_10 + var_303_4
					end

					if var_303_6.prefab_name ~= "" and arg_300_1.actors_[var_303_6.prefab_name] ~= nil then
						local var_303_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_300_1.actors_[var_303_6.prefab_name].transform, "story_v_out_411241", "411241073", "story_v_out_411241.awb")

						arg_300_1:RecordAudio("411241073", var_303_11)
						arg_300_1:RecordAudio("411241073", var_303_11)
					else
						arg_300_1:AudioAction("play", "voice", "story_v_out_411241", "411241073", "story_v_out_411241.awb")
					end

					arg_300_1:RecordHistoryTalkVoice("story_v_out_411241", "411241073", "story_v_out_411241.awb")
				end

				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_12 = math.max(var_303_5, arg_300_1.talkMaxDuration)

			if var_303_4 <= arg_300_1.time_ and arg_300_1.time_ < var_303_4 + var_303_12 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - var_303_4) / var_303_12

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= var_303_4 + var_303_12 and arg_300_1.time_ < var_303_4 + var_303_12 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
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
	Play411241074 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 411241074
		arg_304_1.duration_ = 7.1

		local var_304_0 = {
			zh = 5.333,
			ja = 7.1
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
				arg_304_0:Play411241075(arg_304_1)
			end
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			local var_307_0 = 0.65

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= 0 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0
				arg_304_1.dialogCg_.alpha = 1

				arg_304_1.dialog_:SetActive(true)
				SetActive(arg_304_1.leftNameGo_, true)

				arg_304_1.leftNameTxt_.text = arg_304_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_304_1.leftNameTxt_.transform)

				arg_304_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_304_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_304_1:RecordName(arg_304_1.leftNameTxt_.text)
				SetActive(arg_304_1.iconTrs_.gameObject, false)
				arg_304_1.callingController_:SetSelectedState("normal")

				local var_307_1 = arg_304_1:GetWordFromCfg(411241074)
				local var_307_2 = arg_304_1:FormatText(var_307_1.content)

				arg_304_1.text_.text = var_307_2

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_4 = 26 <= 0 and var_307_0 or var_307_0 * (utf8.len(var_307_2) / 26)

				if (26 <= 0 and var_307_0 or var_307_0 * (utf8.len(var_307_2) / 26)) > 0 and var_307_0 < var_307_4 then
					arg_304_1.talkMaxDuration = var_307_4

					if var_307_4 + 0 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_4 + 0
					end
				end

				arg_304_1.text_.text = var_307_2
				arg_304_1.typewritter.percent = 0

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411241", "411241074", "story_v_out_411241.awb") ~= 0 then
					local var_307_5 = manager.audio:GetVoiceLength("story_v_out_411241", "411241074", "story_v_out_411241.awb") / 1000

					if var_307_5 + 0 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_5 + 0
					end

					if var_307_1.prefab_name ~= "" and arg_304_1.actors_[var_307_1.prefab_name] ~= nil then
						local var_307_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_304_1.actors_[var_307_1.prefab_name].transform, "story_v_out_411241", "411241074", "story_v_out_411241.awb")

						arg_304_1:RecordAudio("411241074", var_307_6)
						arg_304_1:RecordAudio("411241074", var_307_6)
					else
						arg_304_1:AudioAction("play", "voice", "story_v_out_411241", "411241074", "story_v_out_411241.awb")
					end

					arg_304_1:RecordHistoryTalkVoice("story_v_out_411241", "411241074", "story_v_out_411241.awb")
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
	Play411241075 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 411241075
		arg_308_1.duration_ = 7.03

		local var_308_0 = {
			zh = 6.433,
			ja = 7.033
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
				arg_308_0:Play411241076(arg_308_1)
			end
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 then
				arg_308_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_2")
			end

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 then
				arg_308_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_311_0 = 0
			local var_311_1 = 0.7

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= var_311_0 + arg_311_0 then
				arg_308_1.talkMaxDuration = 0
				arg_308_1.dialogCg_.alpha = 1

				arg_308_1.dialog_:SetActive(true)
				SetActive(arg_308_1.leftNameGo_, true)

				arg_308_1.leftNameTxt_.text = arg_308_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_308_1.leftNameTxt_.transform)

				arg_308_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_308_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_308_1:RecordName(arg_308_1.leftNameTxt_.text)
				SetActive(arg_308_1.iconTrs_.gameObject, false)
				arg_308_1.callingController_:SetSelectedState("normal")

				local var_311_2 = arg_308_1:GetWordFromCfg(411241075)
				local var_311_3 = arg_308_1:FormatText(var_311_2.content)

				arg_308_1.text_.text = var_311_3

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_5 = 28 <= 0 and var_311_1 or var_311_1 * (utf8.len(var_311_3) / 28)

				if (28 <= 0 and var_311_1 or var_311_1 * (utf8.len(var_311_3) / 28)) > 0 and var_311_1 < var_311_5 then
					arg_308_1.talkMaxDuration = var_311_5

					if var_311_5 + var_311_0 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_5 + var_311_0
					end
				end

				arg_308_1.text_.text = var_311_3
				arg_308_1.typewritter.percent = 0

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411241", "411241075", "story_v_out_411241.awb") ~= 0 then
					local var_311_6 = manager.audio:GetVoiceLength("story_v_out_411241", "411241075", "story_v_out_411241.awb") / 1000

					if var_311_6 + var_311_0 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_6 + var_311_0
					end

					if var_311_2.prefab_name ~= "" and arg_308_1.actors_[var_311_2.prefab_name] ~= nil then
						local var_311_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_308_1.actors_[var_311_2.prefab_name].transform, "story_v_out_411241", "411241075", "story_v_out_411241.awb")

						arg_308_1:RecordAudio("411241075", var_311_7)
						arg_308_1:RecordAudio("411241075", var_311_7)
					else
						arg_308_1:AudioAction("play", "voice", "story_v_out_411241", "411241075", "story_v_out_411241.awb")
					end

					arg_308_1:RecordHistoryTalkVoice("story_v_out_411241", "411241075", "story_v_out_411241.awb")
				end

				arg_308_1:RecordContent(arg_308_1.text_.text)
			end

			local var_311_8 = math.max(var_311_1, arg_308_1.talkMaxDuration)

			if var_311_0 <= arg_308_1.time_ and arg_308_1.time_ < var_311_0 + var_311_8 then
				arg_308_1.typewritter.percent = (arg_308_1.time_ - var_311_0) / var_311_8

				arg_308_1.typewritter:SetDirty()
			end

			if arg_308_1.time_ >= var_311_0 + var_311_8 and arg_308_1.time_ < var_311_0 + var_311_8 + arg_311_0 then
				arg_308_1.typewritter.percent = 1

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(true)
			end
		end

		arg_308_1.nodeConfigList_ = {}

		arg_308_1:InitPlayNodeList()
	end,
	Play411241076 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 411241076
		arg_312_1.duration_ = 6.2

		local var_312_0 = {
			zh = 4.266,
			ja = 6.2
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
				arg_312_0:Play411241077(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 then
				arg_312_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_315_0 = 0
			local var_315_1 = 0.525

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= var_315_0 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0
				arg_312_1.dialogCg_.alpha = 1

				arg_312_1.dialog_:SetActive(true)
				SetActive(arg_312_1.leftNameGo_, true)

				arg_312_1.leftNameTxt_.text = arg_312_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_312_1.leftNameTxt_.transform)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1.leftNameTxt_.text)
				SetActive(arg_312_1.iconTrs_.gameObject, false)
				arg_312_1.callingController_:SetSelectedState("normal")

				local var_315_2 = arg_312_1:GetWordFromCfg(411241076)
				local var_315_3 = arg_312_1:FormatText(var_315_2.content)

				arg_312_1.text_.text = var_315_3

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_5 = 21 <= 0 and var_315_1 or var_315_1 * (utf8.len(var_315_3) / 21)

				if (21 <= 0 and var_315_1 or var_315_1 * (utf8.len(var_315_3) / 21)) > 0 and var_315_1 < var_315_5 then
					arg_312_1.talkMaxDuration = var_315_5

					if var_315_5 + var_315_0 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_5 + var_315_0
					end
				end

				arg_312_1.text_.text = var_315_3
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411241", "411241076", "story_v_out_411241.awb") ~= 0 then
					local var_315_6 = manager.audio:GetVoiceLength("story_v_out_411241", "411241076", "story_v_out_411241.awb") / 1000

					if var_315_6 + var_315_0 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_6 + var_315_0
					end

					if var_315_2.prefab_name ~= "" and arg_312_1.actors_[var_315_2.prefab_name] ~= nil then
						local var_315_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_312_1.actors_[var_315_2.prefab_name].transform, "story_v_out_411241", "411241076", "story_v_out_411241.awb")

						arg_312_1:RecordAudio("411241076", var_315_7)
						arg_312_1:RecordAudio("411241076", var_315_7)
					else
						arg_312_1:AudioAction("play", "voice", "story_v_out_411241", "411241076", "story_v_out_411241.awb")
					end

					arg_312_1:RecordHistoryTalkVoice("story_v_out_411241", "411241076", "story_v_out_411241.awb")
				end

				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_8 = math.max(var_315_1, arg_312_1.talkMaxDuration)

			if var_315_0 <= arg_312_1.time_ and arg_312_1.time_ < var_315_0 + var_315_8 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - var_315_0) / var_315_8

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= var_315_0 + var_315_8 and arg_312_1.time_ < var_315_0 + var_315_8 + arg_315_0 then
				arg_312_1.typewritter.percent = 1

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(true)
			end
		end

		arg_312_1.nodeConfigList_ = {}

		arg_312_1:InitPlayNodeList()
	end,
	Play411241077 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 411241077
		arg_316_1.duration_ = 3.73

		local var_316_0 = {
			zh = 2.033,
			ja = 3.733
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
				arg_316_0:Play411241078(arg_316_1)
			end
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			if 0 < arg_316_1.time_ and arg_316_1.time_ <= 0 + arg_319_0 and not isNil(arg_316_1.actors_["10058ui_story"]) and arg_316_1.var_.characterEffect10058ui_story == nil then
				arg_316_1.var_.characterEffect10058ui_story = arg_316_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_319_0 = 0.200000002980232

			if 0 <= arg_316_1.time_ and arg_316_1.time_ < 0 + var_319_0 and not isNil(arg_316_1.actors_["10058ui_story"]) then
				if arg_316_1.var_.characterEffect10058ui_story and not isNil(arg_316_1.actors_["10058ui_story"]) then
					arg_316_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_316_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_316_1.time_ - 0) / var_319_0)
				end
			end

			if arg_316_1.time_ >= 0 + var_319_0 and arg_316_1.time_ < 0 + var_319_0 + arg_319_0 and not isNil(arg_316_1.actors_["10058ui_story"]) and arg_316_1.var_.characterEffect10058ui_story then
				arg_316_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_316_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_319_1 = 0
			local var_319_2 = 0.15

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= var_319_1 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0
				arg_316_1.dialogCg_.alpha = 1

				arg_316_1.dialog_:SetActive(true)
				SetActive(arg_316_1.leftNameGo_, true)

				arg_316_1.leftNameTxt_.text = arg_316_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_316_1.leftNameTxt_.transform)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1.leftNameTxt_.text)
				SetActive(arg_316_1.iconTrs_.gameObject, true)
				arg_316_1.iconController_:SetSelectedState("hero")

				arg_316_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10025_1")

				arg_316_1.callingController_:SetSelectedState("normal")

				arg_316_1.keyicon_.color = Color.New(1, 1, 1)
				arg_316_1.icon_.color = Color.New(1, 1, 1)

				local var_319_3 = arg_316_1:GetWordFromCfg(411241077)
				local var_319_4 = arg_316_1:FormatText(var_319_3.content)

				arg_316_1.text_.text = var_319_4

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_6 = 6 <= 0 and var_319_2 or var_319_2 * (utf8.len(var_319_4) / 6)

				if (6 <= 0 and var_319_2 or var_319_2 * (utf8.len(var_319_4) / 6)) > 0 and var_319_2 < var_319_6 then
					arg_316_1.talkMaxDuration = var_319_6

					if var_319_6 + var_319_1 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_6 + var_319_1
					end
				end

				arg_316_1.text_.text = var_319_4
				arg_316_1.typewritter.percent = 0

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411241", "411241077", "story_v_out_411241.awb") ~= 0 then
					local var_319_7 = manager.audio:GetVoiceLength("story_v_out_411241", "411241077", "story_v_out_411241.awb") / 1000

					if var_319_7 + var_319_1 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_7 + var_319_1
					end

					if var_319_3.prefab_name ~= "" and arg_316_1.actors_[var_319_3.prefab_name] ~= nil then
						local var_319_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_316_1.actors_[var_319_3.prefab_name].transform, "story_v_out_411241", "411241077", "story_v_out_411241.awb")

						arg_316_1:RecordAudio("411241077", var_319_8)
						arg_316_1:RecordAudio("411241077", var_319_8)
					else
						arg_316_1:AudioAction("play", "voice", "story_v_out_411241", "411241077", "story_v_out_411241.awb")
					end

					arg_316_1:RecordHistoryTalkVoice("story_v_out_411241", "411241077", "story_v_out_411241.awb")
				end

				arg_316_1:RecordContent(arg_316_1.text_.text)
			end

			local var_319_9 = math.max(var_319_2, arg_316_1.talkMaxDuration)

			if var_319_1 <= arg_316_1.time_ and arg_316_1.time_ < var_319_1 + var_319_9 then
				arg_316_1.typewritter.percent = (arg_316_1.time_ - var_319_1) / var_319_9

				arg_316_1.typewritter:SetDirty()
			end

			if arg_316_1.time_ >= var_319_1 + var_319_9 and arg_316_1.time_ < var_319_1 + var_319_9 + arg_319_0 then
				arg_316_1.typewritter.percent = 1

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(true)
			end
		end

		arg_316_1.nodeConfigList_ = {}

		arg_316_1:InitPlayNodeList()
	end,
	Play411241078 = function(arg_320_0, arg_320_1)
		arg_320_1.time_ = 0
		arg_320_1.frameCnt_ = 0
		arg_320_1.state_ = "playing"
		arg_320_1.curTalkId_ = 411241078
		arg_320_1.duration_ = 1.9

		local var_320_0 = {
			zh = 1.9,
			ja = 1.866
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
				arg_320_0:Play411241079(arg_320_1)
			end
		end

		function arg_320_1.onSingleLineUpdate_(arg_323_0)
			local var_323_0 = 0.1

			if 0 < arg_320_1.time_ and arg_320_1.time_ <= 0 + arg_323_0 then
				arg_320_1.talkMaxDuration = 0
				arg_320_1.dialogCg_.alpha = 1

				arg_320_1.dialog_:SetActive(true)
				SetActive(arg_320_1.leftNameGo_, true)

				arg_320_1.leftNameTxt_.text = arg_320_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_320_1.leftNameTxt_.transform)

				arg_320_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_320_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_320_1:RecordName(arg_320_1.leftNameTxt_.text)
				SetActive(arg_320_1.iconTrs_.gameObject, true)
				arg_320_1.iconController_:SetSelectedState("hero")

				arg_320_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10025_1")

				arg_320_1.callingController_:SetSelectedState("normal")

				arg_320_1.keyicon_.color = Color.New(1, 1, 1)
				arg_320_1.icon_.color = Color.New(1, 1, 1)

				local var_323_1 = arg_320_1:GetWordFromCfg(411241078)
				local var_323_2 = arg_320_1:FormatText(var_323_1.content)

				arg_320_1.text_.text = var_323_2

				LuaForUtil.ClearLinePrefixSymbol(arg_320_1.text_)

				local var_323_4 = 4 <= 0 and var_323_0 or var_323_0 * (utf8.len(var_323_2) / 4)

				if (4 <= 0 and var_323_0 or var_323_0 * (utf8.len(var_323_2) / 4)) > 0 and var_323_0 < var_323_4 then
					arg_320_1.talkMaxDuration = var_323_4

					if var_323_4 + 0 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_4 + 0
					end
				end

				arg_320_1.text_.text = var_323_2
				arg_320_1.typewritter.percent = 0

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411241", "411241078", "story_v_out_411241.awb") ~= 0 then
					local var_323_5 = manager.audio:GetVoiceLength("story_v_out_411241", "411241078", "story_v_out_411241.awb") / 1000

					if var_323_5 + 0 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_5 + 0
					end

					if var_323_1.prefab_name ~= "" and arg_320_1.actors_[var_323_1.prefab_name] ~= nil then
						local var_323_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_320_1.actors_[var_323_1.prefab_name].transform, "story_v_out_411241", "411241078", "story_v_out_411241.awb")

						arg_320_1:RecordAudio("411241078", var_323_6)
						arg_320_1:RecordAudio("411241078", var_323_6)
					else
						arg_320_1:AudioAction("play", "voice", "story_v_out_411241", "411241078", "story_v_out_411241.awb")
					end

					arg_320_1:RecordHistoryTalkVoice("story_v_out_411241", "411241078", "story_v_out_411241.awb")
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
	Play411241079 = function(arg_324_0, arg_324_1)
		arg_324_1.time_ = 0
		arg_324_1.frameCnt_ = 0
		arg_324_1.state_ = "playing"
		arg_324_1.curTalkId_ = 411241079
		arg_324_1.duration_ = 5

		SetActive(arg_324_1.tipsGo_, false)

		function arg_324_1.onSingleLineFinish_()
			arg_324_1.onSingleLineUpdate_ = nil
			arg_324_1.onSingleLineFinish_ = nil
			arg_324_1.state_ = "waiting"
		end

		function arg_324_1.playNext_(arg_326_0)
			if arg_326_0 == 1 then
				arg_324_0:Play411241080(arg_324_1)
			end
		end

		function arg_324_1.onSingleLineUpdate_(arg_327_0)
			local var_327_0 = 0.575

			if 0 < arg_324_1.time_ and arg_324_1.time_ <= 0 + arg_327_0 then
				arg_324_1.talkMaxDuration = 0
				arg_324_1.dialogCg_.alpha = 1

				arg_324_1.dialog_:SetActive(true)
				SetActive(arg_324_1.leftNameGo_, false)

				arg_324_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_324_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_324_1:RecordName(arg_324_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_324_1.iconTrs_.gameObject, false)
				arg_324_1.callingController_:SetSelectedState("normal")

				local var_327_1 = arg_324_1:FormatText(arg_324_1:GetWordFromCfg(411241079).content)

				arg_324_1.text_.text = var_327_1

				LuaForUtil.ClearLinePrefixSymbol(arg_324_1.text_)

				local var_327_3 = 23 <= 0 and var_327_0 or var_327_0 * (utf8.len(var_327_1) / 23)

				if (23 <= 0 and var_327_0 or var_327_0 * (utf8.len(var_327_1) / 23)) > 0 and var_327_0 < var_327_3 then
					arg_324_1.talkMaxDuration = var_327_3

					if var_327_3 + 0 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_3 + 0
					end
				end

				arg_324_1.text_.text = var_327_1
				arg_324_1.typewritter.percent = 0

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(false)
				arg_324_1:RecordContent(arg_324_1.text_.text)
			end

			local var_327_4 = math.max(var_327_0, arg_324_1.talkMaxDuration)

			if 0 <= arg_324_1.time_ and arg_324_1.time_ < 0 + var_327_4 then
				arg_324_1.typewritter.percent = (arg_324_1.time_ - 0) / var_327_4

				arg_324_1.typewritter:SetDirty()
			end

			if arg_324_1.time_ >= 0 + var_327_4 and arg_324_1.time_ < 0 + var_327_4 + arg_327_0 then
				arg_324_1.typewritter.percent = 1

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(true)
			end
		end

		arg_324_1.nodeConfigList_ = {}

		arg_324_1:InitPlayNodeList()
	end,
	Play411241080 = function(arg_328_0, arg_328_1)
		arg_328_1.time_ = 0
		arg_328_1.frameCnt_ = 0
		arg_328_1.state_ = "playing"
		arg_328_1.curTalkId_ = 411241080
		arg_328_1.duration_ = 5.27

		local var_328_0 = {
			zh = 3.866,
			ja = 5.266
		}
		local var_328_1 = manager.audio:GetLocalizationFlag()

		if var_328_0[var_328_1] ~= nil then
			arg_328_1.duration_ = var_328_0[var_328_1]
		end

		SetActive(arg_328_1.tipsGo_, false)

		function arg_328_1.onSingleLineFinish_()
			arg_328_1.onSingleLineUpdate_ = nil
			arg_328_1.onSingleLineFinish_ = nil
			arg_328_1.state_ = "waiting"
			arg_328_1.auto_ = false
		end

		function arg_328_1.playNext_(arg_330_0)
			arg_328_1.onStoryFinished_()
		end

		function arg_328_1.onSingleLineUpdate_(arg_331_0)
			if 0 < arg_328_1.time_ and arg_328_1.time_ <= 0 + arg_331_0 then
				arg_328_1.var_.moveOldPos10058ui_story = arg_328_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_331_0 = 0.001

			if 0 <= arg_328_1.time_ and arg_328_1.time_ < 0 + var_331_0 then
				arg_328_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_328_1.var_.moveOldPos10058ui_story, Vector3.New(0, -0.98, -6.1), (arg_328_1.time_ - 0) / var_331_0)
				arg_328_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_328_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_328_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_328_1.actors_["10058ui_story"].transform.position).z)
				arg_328_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_328_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_328_1.actors_["10058ui_story"].transform.localEulerAngles = arg_328_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_328_1.time_ >= 0 + var_331_0 and arg_328_1.time_ < 0 + var_331_0 + arg_331_0 then
				arg_328_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_328_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_328_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_328_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_328_1.actors_["10058ui_story"].transform.position).z)
				arg_328_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_328_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_328_1.actors_["10058ui_story"].transform.localEulerAngles = arg_328_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_331_1 = arg_328_1.actors_["10058ui_story"]

			if 0 < arg_328_1.time_ and arg_328_1.time_ <= 0 + arg_331_0 and not isNil(var_331_1) and arg_328_1.var_.characterEffect10058ui_story == nil then
				arg_328_1.var_.characterEffect10058ui_story = var_331_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_331_2 = 0.200000002980232

			if 0 <= arg_328_1.time_ and arg_328_1.time_ < 0 + var_331_2 and not isNil(var_331_1) then
				if arg_328_1.var_.characterEffect10058ui_story and not isNil(var_331_1) then
					arg_328_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_328_1.time_ >= 0 + var_331_2 and arg_328_1.time_ < 0 + var_331_2 + arg_331_0 and not isNil(var_331_1) and arg_328_1.var_.characterEffect10058ui_story then
				arg_328_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_328_1.time_ and arg_328_1.time_ <= 0 + arg_331_0 then
				arg_328_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_328_1.time_ and arg_328_1.time_ <= 0 + arg_331_0 then
				arg_328_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_331_4 = 0
			local var_331_5 = 0.4

			if 0 < arg_328_1.time_ and arg_328_1.time_ <= var_331_4 + arg_331_0 then
				arg_328_1.talkMaxDuration = 0
				arg_328_1.dialogCg_.alpha = 1

				arg_328_1.dialog_:SetActive(true)
				SetActive(arg_328_1.leftNameGo_, true)

				arg_328_1.leftNameTxt_.text = arg_328_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_328_1.leftNameTxt_.transform)

				arg_328_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_328_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_328_1:RecordName(arg_328_1.leftNameTxt_.text)
				SetActive(arg_328_1.iconTrs_.gameObject, false)
				arg_328_1.callingController_:SetSelectedState("normal")

				local var_331_6 = arg_328_1:GetWordFromCfg(411241080)
				local var_331_7 = arg_328_1:FormatText(var_331_6.content)

				arg_328_1.text_.text = var_331_7

				LuaForUtil.ClearLinePrefixSymbol(arg_328_1.text_)

				local var_331_9 = 16 <= 0 and var_331_5 or var_331_5 * (utf8.len(var_331_7) / 16)

				if (16 <= 0 and var_331_5 or var_331_5 * (utf8.len(var_331_7) / 16)) > 0 and var_331_5 < var_331_9 then
					arg_328_1.talkMaxDuration = var_331_9

					if var_331_9 + var_331_4 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_9 + var_331_4
					end
				end

				arg_328_1.text_.text = var_331_7
				arg_328_1.typewritter.percent = 0

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411241", "411241080", "story_v_out_411241.awb") ~= 0 then
					local var_331_10 = manager.audio:GetVoiceLength("story_v_out_411241", "411241080", "story_v_out_411241.awb") / 1000

					if var_331_10 + var_331_4 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_10 + var_331_4
					end

					if var_331_6.prefab_name ~= "" and arg_328_1.actors_[var_331_6.prefab_name] ~= nil then
						local var_331_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_328_1.actors_[var_331_6.prefab_name].transform, "story_v_out_411241", "411241080", "story_v_out_411241.awb")

						arg_328_1:RecordAudio("411241080", var_331_11)
						arg_328_1:RecordAudio("411241080", var_331_11)
					else
						arg_328_1:AudioAction("play", "voice", "story_v_out_411241", "411241080", "story_v_out_411241.awb")
					end

					arg_328_1:RecordHistoryTalkVoice("story_v_out_411241", "411241080", "story_v_out_411241.awb")
				end

				arg_328_1:RecordContent(arg_328_1.text_.text)
			end

			local var_331_12 = math.max(var_331_5, arg_328_1.talkMaxDuration)

			if var_331_4 <= arg_328_1.time_ and arg_328_1.time_ < var_331_4 + var_331_12 then
				arg_328_1.typewritter.percent = (arg_328_1.time_ - var_331_4) / var_331_12

				arg_328_1.typewritter:SetDirty()
			end

			if arg_328_1.time_ >= var_331_4 + var_331_12 and arg_328_1.time_ < var_331_4 + var_331_12 + arg_331_0 then
				arg_328_1.typewritter.percent = 1

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(true)
			end
		end

		arg_328_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_328_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ML0602",
		"TextureConfig/Background/ST77a"
	},
	voices = {
		"story_v_out_411241.awb"
	}
}
