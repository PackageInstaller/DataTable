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

			local var_4_19 = 1

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

			local var_4_30 = 0.233333333333333
			local var_4_31 = 1

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				local var_4_32 = "play"
				local var_4_33 = "music"

				arg_1_1:AudioAction(var_4_32, var_4_33, "bgm_activity_3_0_story_northblock", "bgm_activity_3_0_story_northblock", "bgm_activity_3_0_story_northblock.awb")

				local var_4_34 = ""
				local var_4_35 = manager.audio:GetAudioName("bgm_activity_3_0_story_northblock", "bgm_activity_3_0_story_northblock")

				if var_4_35 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_35 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_35

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_35
						arg_1_1.bgmTxt2_.text = var_4_35
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

			local var_4_36 = 1
			local var_4_37 = 0.175

			if var_4_36 < arg_1_1.time_ and arg_1_1.time_ <= var_4_36 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_38 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_38:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_38:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_38:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_39 = arg_1_1:FormatText(StoryNameCfg[694].name)

				arg_1_1.leftNameTxt_.text = var_4_39

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

				local var_4_40 = arg_1_1:GetWordFromCfg(319671001)
				local var_4_41 = arg_1_1:FormatText(var_4_40.content)

				arg_1_1.text_.text = var_4_41

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_42 = 7
				local var_4_43 = utf8.len(var_4_41)
				local var_4_44 = var_4_42 <= 0 and var_4_37 or var_4_37 * (var_4_43 / var_4_42)

				if var_4_44 > 0 and var_4_37 < var_4_44 then
					arg_1_1.talkMaxDuration = var_4_44
					var_4_36 = var_4_36 + 0.3

					if var_4_44 + var_4_36 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_44 + var_4_36
					end
				end

				arg_1_1.text_.text = var_4_41
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671001", "story_v_out_319671.awb") ~= 0 then
					local var_4_45 = manager.audio:GetVoiceLength("story_v_out_319671", "319671001", "story_v_out_319671.awb") / 1000

					if var_4_45 + var_4_36 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_45 + var_4_36
					end

					if var_4_40.prefab_name ~= "" and arg_1_1.actors_[var_4_40.prefab_name] ~= nil then
						local var_4_46 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_40.prefab_name].transform, "story_v_out_319671", "319671001", "story_v_out_319671.awb")

						arg_1_1:RecordAudio("319671001", var_4_46)
						arg_1_1:RecordAudio("319671001", var_4_46)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_319671", "319671001", "story_v_out_319671.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_319671", "319671001", "story_v_out_319671.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_47 = var_4_36 + 0.3
			local var_4_48 = math.max(var_4_37, arg_1_1.talkMaxDuration)

			if var_4_47 <= arg_1_1.time_ and arg_1_1.time_ < var_4_47 + var_4_48 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_47) / var_4_48

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_47 + var_4_48 and arg_1_1.time_ < var_4_47 + var_4_48 + arg_4_0 then
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
			local var_12_0 = 0
			local var_12_1 = 0.175

			if var_12_0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_2 = arg_9_1:FormatText(StoryNameCfg[6].name)

				arg_9_1.leftNameTxt_.text = var_12_2

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

				local var_12_3 = arg_9_1:GetWordFromCfg(319671002)
				local var_12_4 = arg_9_1:FormatText(var_12_3.content)

				arg_9_1.text_.text = var_12_4

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_5 = 7
				local var_12_6 = utf8.len(var_12_4)
				local var_12_7 = var_12_5 <= 0 and var_12_1 or var_12_1 * (var_12_6 / var_12_5)

				if var_12_7 > 0 and var_12_1 < var_12_7 then
					arg_9_1.talkMaxDuration = var_12_7

					if var_12_7 + var_12_0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_7 + var_12_0
					end
				end

				arg_9_1.text_.text = var_12_4
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671002", "story_v_out_319671.awb") ~= 0 then
					local var_12_8 = manager.audio:GetVoiceLength("story_v_out_319671", "319671002", "story_v_out_319671.awb") / 1000

					if var_12_8 + var_12_0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_8 + var_12_0
					end

					if var_12_3.prefab_name ~= "" and arg_9_1.actors_[var_12_3.prefab_name] ~= nil then
						local var_12_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_3.prefab_name].transform, "story_v_out_319671", "319671002", "story_v_out_319671.awb")

						arg_9_1:RecordAudio("319671002", var_12_9)
						arg_9_1:RecordAudio("319671002", var_12_9)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_319671", "319671002", "story_v_out_319671.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_319671", "319671002", "story_v_out_319671.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_10 = math.max(var_12_1, arg_9_1.talkMaxDuration)

			if var_12_0 <= arg_9_1.time_ and arg_9_1.time_ < var_12_0 + var_12_10 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_0) / var_12_10

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_0 + var_12_10 and arg_9_1.time_ < var_12_0 + var_12_10 + arg_12_0 then
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
			local var_16_0 = 0
			local var_16_1 = 0.075

			if var_16_0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_2 = arg_13_1:FormatText(StoryNameCfg[694].name)

				arg_13_1.leftNameTxt_.text = var_16_2

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

				local var_16_3 = arg_13_1:GetWordFromCfg(319671003)
				local var_16_4 = arg_13_1:FormatText(var_16_3.content)

				arg_13_1.text_.text = var_16_4

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_5 = 3
				local var_16_6 = utf8.len(var_16_4)
				local var_16_7 = var_16_5 <= 0 and var_16_1 or var_16_1 * (var_16_6 / var_16_5)

				if var_16_7 > 0 and var_16_1 < var_16_7 then
					arg_13_1.talkMaxDuration = var_16_7

					if var_16_7 + var_16_0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_7 + var_16_0
					end
				end

				arg_13_1.text_.text = var_16_4
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671003", "story_v_out_319671.awb") ~= 0 then
					local var_16_8 = manager.audio:GetVoiceLength("story_v_out_319671", "319671003", "story_v_out_319671.awb") / 1000

					if var_16_8 + var_16_0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_8 + var_16_0
					end

					if var_16_3.prefab_name ~= "" and arg_13_1.actors_[var_16_3.prefab_name] ~= nil then
						local var_16_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_3.prefab_name].transform, "story_v_out_319671", "319671003", "story_v_out_319671.awb")

						arg_13_1:RecordAudio("319671003", var_16_9)
						arg_13_1:RecordAudio("319671003", var_16_9)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_319671", "319671003", "story_v_out_319671.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_319671", "319671003", "story_v_out_319671.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_10 = math.max(var_16_1, arg_13_1.talkMaxDuration)

			if var_16_0 <= arg_13_1.time_ and arg_13_1.time_ < var_16_0 + var_16_10 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_0) / var_16_10

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_0 + var_16_10 and arg_13_1.time_ < var_16_0 + var_16_10 + arg_16_0 then
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
			local var_20_0 = "I12g"

			if arg_17_1.bgs_[var_20_0] == nil then
				local var_20_1 = Object.Instantiate(arg_17_1.paintGo_)

				var_20_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_20_0)
				var_20_1.name = var_20_0
				var_20_1.transform.parent = arg_17_1.stage_.transform
				var_20_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_17_1.bgs_[var_20_0] = var_20_1
			end

			local var_20_2 = 0

			if var_20_2 < arg_17_1.time_ and arg_17_1.time_ <= var_20_2 + arg_20_0 then
				local var_20_3 = manager.ui.mainCamera.transform.localPosition
				local var_20_4 = Vector3.New(0, 0, 10) + Vector3.New(var_20_3.x, var_20_3.y, 0)
				local var_20_5 = arg_17_1.bgs_.I12g

				var_20_5.transform.localPosition = var_20_4
				var_20_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_20_6 = var_20_5:GetComponent("SpriteRenderer")

				if var_20_6 and var_20_6.sprite then
					local var_20_7 = (var_20_5.transform.localPosition - var_20_3).z
					local var_20_8 = manager.ui.mainCameraCom_
					local var_20_9 = 2 * var_20_7 * Mathf.Tan(var_20_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_20_10 = var_20_9 * var_20_8.aspect
					local var_20_11 = var_20_6.sprite.bounds.size.x
					local var_20_12 = var_20_6.sprite.bounds.size.y
					local var_20_13 = var_20_10 / var_20_11
					local var_20_14 = var_20_9 / var_20_12
					local var_20_15 = var_20_14 < var_20_13 and var_20_13 or var_20_14

					var_20_5.transform.localScale = Vector3.New(var_20_15, var_20_15, 0)
				end

				for iter_20_0, iter_20_1 in pairs(arg_17_1.bgs_) do
					if iter_20_0 ~= "I12g" then
						iter_20_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_20_16 = 0

			if var_20_16 < arg_17_1.time_ and arg_17_1.time_ <= var_20_16 + arg_20_0 then
				arg_17_1.allBtn_.enabled = false
			end

			local var_20_17 = 0.3

			if arg_17_1.time_ >= var_20_16 + var_20_17 and arg_17_1.time_ < var_20_16 + var_20_17 + arg_20_0 then
				arg_17_1.allBtn_.enabled = true
			end

			local var_20_18 = 0

			if var_20_18 < arg_17_1.time_ and arg_17_1.time_ <= var_20_18 + arg_20_0 then
				arg_17_1.mask_.enabled = true
				arg_17_1.mask_.raycastTarget = true

				arg_17_1:SetGaussion(false)
			end

			local var_20_19 = 2

			if var_20_18 <= arg_17_1.time_ and arg_17_1.time_ < var_20_18 + var_20_19 then
				local var_20_20 = (arg_17_1.time_ - var_20_18) / var_20_19
				local var_20_21 = Color.New(0, 0, 0)

				var_20_21.a = Mathf.Lerp(1, 0, var_20_20)
				arg_17_1.mask_.color = var_20_21
			end

			if arg_17_1.time_ >= var_20_18 + var_20_19 and arg_17_1.time_ < var_20_18 + var_20_19 + arg_20_0 then
				local var_20_22 = Color.New(0, 0, 0)
				local var_20_23 = 0

				arg_17_1.mask_.enabled = false
				var_20_22.a = var_20_23
				arg_17_1.mask_.color = var_20_22
			end

			if arg_17_1.frameCnt_ <= 1 then
				arg_17_1.dialog_:SetActive(false)
			end

			local var_20_24 = 2
			local var_20_25 = 1.125

			if var_20_24 < arg_17_1.time_ and arg_17_1.time_ <= var_20_24 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0

				arg_17_1.dialog_:SetActive(true)

				arg_17_1.dialogCg_.alpha = 0

				local var_20_26 = LeanTween.value(arg_17_1.dialog_, 0, 1, 0.3)

				var_20_26:setOnUpdate(LuaHelper.FloatAction(function(arg_21_0)
					arg_17_1.dialogCg_.alpha = arg_21_0
				end))
				var_20_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_17_1.dialog_)
					var_20_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_17_1.duration_ = arg_17_1.duration_ + 0.3

				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_27 = arg_17_1:GetWordFromCfg(319671004)
				local var_20_28 = arg_17_1:FormatText(var_20_27.content)

				arg_17_1.text_.text = var_20_28

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_29 = 45
				local var_20_30 = utf8.len(var_20_28)
				local var_20_31 = var_20_29 <= 0 and var_20_25 or var_20_25 * (var_20_30 / var_20_29)

				if var_20_31 > 0 and var_20_25 < var_20_31 then
					arg_17_1.talkMaxDuration = var_20_31
					var_20_24 = var_20_24 + 0.3

					if var_20_31 + var_20_24 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_31 + var_20_24
					end
				end

				arg_17_1.text_.text = var_20_28
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_32 = var_20_24 + 0.3
			local var_20_33 = math.max(var_20_25, arg_17_1.talkMaxDuration)

			if var_20_32 <= arg_17_1.time_ and arg_17_1.time_ < var_20_32 + var_20_33 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_32) / var_20_33

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_32 + var_20_33 and arg_17_1.time_ < var_20_32 + var_20_33 + arg_20_0 then
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
			local var_26_0 = 0
			local var_26_1 = 0.725

			if var_26_0 < arg_23_1.time_ and arg_23_1.time_ <= var_26_0 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, false)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_2 = arg_23_1:GetWordFromCfg(319671005)
				local var_26_3 = arg_23_1:FormatText(var_26_2.content)

				arg_23_1.text_.text = var_26_3

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_4 = 29
				local var_26_5 = utf8.len(var_26_3)
				local var_26_6 = var_26_4 <= 0 and var_26_1 or var_26_1 * (var_26_5 / var_26_4)

				if var_26_6 > 0 and var_26_1 < var_26_6 then
					arg_23_1.talkMaxDuration = var_26_6

					if var_26_6 + var_26_0 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_6 + var_26_0
					end
				end

				arg_23_1.text_.text = var_26_3
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)
				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_7 = math.max(var_26_1, arg_23_1.talkMaxDuration)

			if var_26_0 <= arg_23_1.time_ and arg_23_1.time_ < var_26_0 + var_26_7 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_0) / var_26_7

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_0 + var_26_7 and arg_23_1.time_ < var_26_0 + var_26_7 + arg_26_0 then
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
			local var_30_0 = 0
			local var_30_1 = 0.15

			if var_30_0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_0 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				local var_30_2 = arg_27_1:FormatText(StoryNameCfg[694].name)

				arg_27_1.leftNameTxt_.text = var_30_2

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

				local var_30_3 = arg_27_1:GetWordFromCfg(319671006)
				local var_30_4 = arg_27_1:FormatText(var_30_3.content)

				arg_27_1.text_.text = var_30_4

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_5 = 6
				local var_30_6 = utf8.len(var_30_4)
				local var_30_7 = var_30_5 <= 0 and var_30_1 or var_30_1 * (var_30_6 / var_30_5)

				if var_30_7 > 0 and var_30_1 < var_30_7 then
					arg_27_1.talkMaxDuration = var_30_7

					if var_30_7 + var_30_0 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_7 + var_30_0
					end
				end

				arg_27_1.text_.text = var_30_4
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671006", "story_v_out_319671.awb") ~= 0 then
					local var_30_8 = manager.audio:GetVoiceLength("story_v_out_319671", "319671006", "story_v_out_319671.awb") / 1000

					if var_30_8 + var_30_0 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_8 + var_30_0
					end

					if var_30_3.prefab_name ~= "" and arg_27_1.actors_[var_30_3.prefab_name] ~= nil then
						local var_30_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_3.prefab_name].transform, "story_v_out_319671", "319671006", "story_v_out_319671.awb")

						arg_27_1:RecordAudio("319671006", var_30_9)
						arg_27_1:RecordAudio("319671006", var_30_9)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_out_319671", "319671006", "story_v_out_319671.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_out_319671", "319671006", "story_v_out_319671.awb")
				end

				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_10 = math.max(var_30_1, arg_27_1.talkMaxDuration)

			if var_30_0 <= arg_27_1.time_ and arg_27_1.time_ < var_30_0 + var_30_10 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_0) / var_30_10

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_0 + var_30_10 and arg_27_1.time_ < var_30_0 + var_30_10 + arg_30_0 then
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
			local var_34_0 = "1084ui_story"

			if arg_31_1.actors_[var_34_0] == nil then
				local var_34_1 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_34_1) then
					local var_34_2 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_31_1.stage_.transform)

					var_34_2.name = var_34_0
					var_34_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_31_1.actors_[var_34_0] = var_34_2

					local var_34_3 = var_34_2:GetComponentInChildren(typeof(CharacterEffect))

					var_34_3.enabled = true

					local var_34_4 = GameObjectTools.GetOrAddComponent(var_34_2, typeof(DynamicBoneHelper))

					if var_34_4 then
						var_34_4:EnableDynamicBone(false)
					end

					arg_31_1:ShowWeapon(var_34_3.transform, false)

					arg_31_1.var_[var_34_0 .. "Animator"] = var_34_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_31_1.var_[var_34_0 .. "Animator"].applyRootMotion = true
					arg_31_1.var_[var_34_0 .. "LipSync"] = var_34_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_34_5 = arg_31_1.actors_["1084ui_story"].transform
			local var_34_6 = 0

			if var_34_6 < arg_31_1.time_ and arg_31_1.time_ <= var_34_6 + arg_34_0 then
				arg_31_1.var_.moveOldPos1084ui_story = var_34_5.localPosition

				local var_34_7 = "1084ui_story"

				arg_31_1:ShowWeapon(arg_31_1.var_[var_34_7 .. "Animator"].transform, false)
			end

			local var_34_8 = 0.001

			if var_34_6 <= arg_31_1.time_ and arg_31_1.time_ < var_34_6 + var_34_8 then
				local var_34_9 = (arg_31_1.time_ - var_34_6) / var_34_8
				local var_34_10 = Vector3.New(0, -0.97, -6)

				var_34_5.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos1084ui_story, var_34_10, var_34_9)

				local var_34_11 = manager.ui.mainCamera.transform.position - var_34_5.position

				var_34_5.forward = Vector3.New(var_34_11.x, var_34_11.y, var_34_11.z)

				local var_34_12 = var_34_5.localEulerAngles

				var_34_12.z = 0
				var_34_12.x = 0
				var_34_5.localEulerAngles = var_34_12
			end

			if arg_31_1.time_ >= var_34_6 + var_34_8 and arg_31_1.time_ < var_34_6 + var_34_8 + arg_34_0 then
				var_34_5.localPosition = Vector3.New(0, -0.97, -6)

				local var_34_13 = manager.ui.mainCamera.transform.position - var_34_5.position

				var_34_5.forward = Vector3.New(var_34_13.x, var_34_13.y, var_34_13.z)

				local var_34_14 = var_34_5.localEulerAngles

				var_34_14.z = 0
				var_34_14.x = 0
				var_34_5.localEulerAngles = var_34_14
			end

			local var_34_15 = arg_31_1.actors_["1084ui_story"]
			local var_34_16 = 0

			if var_34_16 < arg_31_1.time_ and arg_31_1.time_ <= var_34_16 + arg_34_0 and not isNil(var_34_15) and arg_31_1.var_.characterEffect1084ui_story == nil then
				arg_31_1.var_.characterEffect1084ui_story = var_34_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_17 = 0.200000002980232

			if var_34_16 <= arg_31_1.time_ and arg_31_1.time_ < var_34_16 + var_34_17 and not isNil(var_34_15) then
				local var_34_18 = (arg_31_1.time_ - var_34_16) / var_34_17

				if arg_31_1.var_.characterEffect1084ui_story and not isNil(var_34_15) then
					arg_31_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_31_1.time_ >= var_34_16 + var_34_17 and arg_31_1.time_ < var_34_16 + var_34_17 + arg_34_0 and not isNil(var_34_15) and arg_31_1.var_.characterEffect1084ui_story then
				arg_31_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_34_19 = 0

			if var_34_19 < arg_31_1.time_ and arg_31_1.time_ <= var_34_19 + arg_34_0 then
				arg_31_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_34_20 = 0

			if var_34_20 < arg_31_1.time_ and arg_31_1.time_ <= var_34_20 + arg_34_0 then
				arg_31_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_34_21 = 0
			local var_34_22 = 0.125

			if var_34_21 < arg_31_1.time_ and arg_31_1.time_ <= var_34_21 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				local var_34_23 = arg_31_1:FormatText(StoryNameCfg[6].name)

				arg_31_1.leftNameTxt_.text = var_34_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_24 = arg_31_1:GetWordFromCfg(319671007)
				local var_34_25 = arg_31_1:FormatText(var_34_24.content)

				arg_31_1.text_.text = var_34_25

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_26 = 5
				local var_34_27 = utf8.len(var_34_25)
				local var_34_28 = var_34_26 <= 0 and var_34_22 or var_34_22 * (var_34_27 / var_34_26)

				if var_34_28 > 0 and var_34_22 < var_34_28 then
					arg_31_1.talkMaxDuration = var_34_28

					if var_34_28 + var_34_21 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_28 + var_34_21
					end
				end

				arg_31_1.text_.text = var_34_25
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671007", "story_v_out_319671.awb") ~= 0 then
					local var_34_29 = manager.audio:GetVoiceLength("story_v_out_319671", "319671007", "story_v_out_319671.awb") / 1000

					if var_34_29 + var_34_21 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_29 + var_34_21
					end

					if var_34_24.prefab_name ~= "" and arg_31_1.actors_[var_34_24.prefab_name] ~= nil then
						local var_34_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_24.prefab_name].transform, "story_v_out_319671", "319671007", "story_v_out_319671.awb")

						arg_31_1:RecordAudio("319671007", var_34_30)
						arg_31_1:RecordAudio("319671007", var_34_30)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_319671", "319671007", "story_v_out_319671.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_319671", "319671007", "story_v_out_319671.awb")
				end

				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_31 = math.max(var_34_22, arg_31_1.talkMaxDuration)

			if var_34_21 <= arg_31_1.time_ and arg_31_1.time_ < var_34_21 + var_34_31 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_21) / var_34_31

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_21 + var_34_31 and arg_31_1.time_ < var_34_21 + var_34_31 + arg_34_0 then
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
			local var_38_0 = arg_35_1.actors_["1084ui_story"]
			local var_38_1 = 0

			if var_38_1 < arg_35_1.time_ and arg_35_1.time_ <= var_38_1 + arg_38_0 and not isNil(var_38_0) and arg_35_1.var_.characterEffect1084ui_story == nil then
				arg_35_1.var_.characterEffect1084ui_story = var_38_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_2 = 0.200000002980232

			if var_38_1 <= arg_35_1.time_ and arg_35_1.time_ < var_38_1 + var_38_2 and not isNil(var_38_0) then
				local var_38_3 = (arg_35_1.time_ - var_38_1) / var_38_2

				if arg_35_1.var_.characterEffect1084ui_story and not isNil(var_38_0) then
					local var_38_4 = Mathf.Lerp(0, 0.5, var_38_3)

					arg_35_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_35_1.var_.characterEffect1084ui_story.fillRatio = var_38_4
				end
			end

			if arg_35_1.time_ >= var_38_1 + var_38_2 and arg_35_1.time_ < var_38_1 + var_38_2 + arg_38_0 and not isNil(var_38_0) and arg_35_1.var_.characterEffect1084ui_story then
				local var_38_5 = 0.5

				arg_35_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_35_1.var_.characterEffect1084ui_story.fillRatio = var_38_5
			end

			local var_38_6 = 0
			local var_38_7 = 0.4

			if var_38_6 < arg_35_1.time_ and arg_35_1.time_ <= var_38_6 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				local var_38_8 = arg_35_1:FormatText(StoryNameCfg[694].name)

				arg_35_1.leftNameTxt_.text = var_38_8

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

				local var_38_9 = arg_35_1:GetWordFromCfg(319671008)
				local var_38_10 = arg_35_1:FormatText(var_38_9.content)

				arg_35_1.text_.text = var_38_10

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_11 = 16
				local var_38_12 = utf8.len(var_38_10)
				local var_38_13 = var_38_11 <= 0 and var_38_7 or var_38_7 * (var_38_12 / var_38_11)

				if var_38_13 > 0 and var_38_7 < var_38_13 then
					arg_35_1.talkMaxDuration = var_38_13

					if var_38_13 + var_38_6 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_13 + var_38_6
					end
				end

				arg_35_1.text_.text = var_38_10
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671008", "story_v_out_319671.awb") ~= 0 then
					local var_38_14 = manager.audio:GetVoiceLength("story_v_out_319671", "319671008", "story_v_out_319671.awb") / 1000

					if var_38_14 + var_38_6 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_14 + var_38_6
					end

					if var_38_9.prefab_name ~= "" and arg_35_1.actors_[var_38_9.prefab_name] ~= nil then
						local var_38_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_9.prefab_name].transform, "story_v_out_319671", "319671008", "story_v_out_319671.awb")

						arg_35_1:RecordAudio("319671008", var_38_15)
						arg_35_1:RecordAudio("319671008", var_38_15)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_out_319671", "319671008", "story_v_out_319671.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_out_319671", "319671008", "story_v_out_319671.awb")
				end

				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_16 = math.max(var_38_7, arg_35_1.talkMaxDuration)

			if var_38_6 <= arg_35_1.time_ and arg_35_1.time_ < var_38_6 + var_38_16 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_6) / var_38_16

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_6 + var_38_16 and arg_35_1.time_ < var_38_6 + var_38_16 + arg_38_0 then
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
			local var_42_0 = "1095ui_story"

			if arg_39_1.actors_[var_42_0] == nil then
				local var_42_1 = Asset.Load("Char/" .. "1095ui_story")

				if not isNil(var_42_1) then
					local var_42_2 = Object.Instantiate(Asset.Load("Char/" .. "1095ui_story"), arg_39_1.stage_.transform)

					var_42_2.name = var_42_0
					var_42_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_39_1.actors_[var_42_0] = var_42_2

					local var_42_3 = var_42_2:GetComponentInChildren(typeof(CharacterEffect))

					var_42_3.enabled = true

					local var_42_4 = GameObjectTools.GetOrAddComponent(var_42_2, typeof(DynamicBoneHelper))

					if var_42_4 then
						var_42_4:EnableDynamicBone(false)
					end

					arg_39_1:ShowWeapon(var_42_3.transform, false)

					arg_39_1.var_[var_42_0 .. "Animator"] = var_42_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_39_1.var_[var_42_0 .. "Animator"].applyRootMotion = true
					arg_39_1.var_[var_42_0 .. "LipSync"] = var_42_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_42_5 = arg_39_1.actors_["1095ui_story"].transform
			local var_42_6 = 0

			if var_42_6 < arg_39_1.time_ and arg_39_1.time_ <= var_42_6 + arg_42_0 then
				arg_39_1.var_.moveOldPos1095ui_story = var_42_5.localPosition
			end

			local var_42_7 = 0.001

			if var_42_6 <= arg_39_1.time_ and arg_39_1.time_ < var_42_6 + var_42_7 then
				local var_42_8 = (arg_39_1.time_ - var_42_6) / var_42_7
				local var_42_9 = Vector3.New(0, -0.98, -6.1)

				var_42_5.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPos1095ui_story, var_42_9, var_42_8)

				local var_42_10 = manager.ui.mainCamera.transform.position - var_42_5.position

				var_42_5.forward = Vector3.New(var_42_10.x, var_42_10.y, var_42_10.z)

				local var_42_11 = var_42_5.localEulerAngles

				var_42_11.z = 0
				var_42_11.x = 0
				var_42_5.localEulerAngles = var_42_11
			end

			if arg_39_1.time_ >= var_42_6 + var_42_7 and arg_39_1.time_ < var_42_6 + var_42_7 + arg_42_0 then
				var_42_5.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_42_12 = manager.ui.mainCamera.transform.position - var_42_5.position

				var_42_5.forward = Vector3.New(var_42_12.x, var_42_12.y, var_42_12.z)

				local var_42_13 = var_42_5.localEulerAngles

				var_42_13.z = 0
				var_42_13.x = 0
				var_42_5.localEulerAngles = var_42_13
			end

			local var_42_14 = arg_39_1.actors_["1095ui_story"]
			local var_42_15 = 0

			if var_42_15 < arg_39_1.time_ and arg_39_1.time_ <= var_42_15 + arg_42_0 and not isNil(var_42_14) and arg_39_1.var_.characterEffect1095ui_story == nil then
				arg_39_1.var_.characterEffect1095ui_story = var_42_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_16 = 0.200000002980232

			if var_42_15 <= arg_39_1.time_ and arg_39_1.time_ < var_42_15 + var_42_16 and not isNil(var_42_14) then
				local var_42_17 = (arg_39_1.time_ - var_42_15) / var_42_16

				if arg_39_1.var_.characterEffect1095ui_story and not isNil(var_42_14) then
					arg_39_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_39_1.time_ >= var_42_15 + var_42_16 and arg_39_1.time_ < var_42_15 + var_42_16 + arg_42_0 and not isNil(var_42_14) and arg_39_1.var_.characterEffect1095ui_story then
				arg_39_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_42_18 = 0

			if var_42_18 < arg_39_1.time_ and arg_39_1.time_ <= var_42_18 + arg_42_0 then
				arg_39_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_42_19 = 0

			if var_42_19 < arg_39_1.time_ and arg_39_1.time_ <= var_42_19 + arg_42_0 then
				arg_39_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_42_20 = arg_39_1.actors_["1084ui_story"].transform
			local var_42_21 = 0

			if var_42_21 < arg_39_1.time_ and arg_39_1.time_ <= var_42_21 + arg_42_0 then
				arg_39_1.var_.moveOldPos1084ui_story = var_42_20.localPosition
			end

			local var_42_22 = 0.001

			if var_42_21 <= arg_39_1.time_ and arg_39_1.time_ < var_42_21 + var_42_22 then
				local var_42_23 = (arg_39_1.time_ - var_42_21) / var_42_22
				local var_42_24 = Vector3.New(0, 100, 0)

				var_42_20.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPos1084ui_story, var_42_24, var_42_23)

				local var_42_25 = manager.ui.mainCamera.transform.position - var_42_20.position

				var_42_20.forward = Vector3.New(var_42_25.x, var_42_25.y, var_42_25.z)

				local var_42_26 = var_42_20.localEulerAngles

				var_42_26.z = 0
				var_42_26.x = 0
				var_42_20.localEulerAngles = var_42_26
			end

			if arg_39_1.time_ >= var_42_21 + var_42_22 and arg_39_1.time_ < var_42_21 + var_42_22 + arg_42_0 then
				var_42_20.localPosition = Vector3.New(0, 100, 0)

				local var_42_27 = manager.ui.mainCamera.transform.position - var_42_20.position

				var_42_20.forward = Vector3.New(var_42_27.x, var_42_27.y, var_42_27.z)

				local var_42_28 = var_42_20.localEulerAngles

				var_42_28.z = 0
				var_42_28.x = 0
				var_42_20.localEulerAngles = var_42_28
			end

			local var_42_29 = arg_39_1.actors_["1084ui_story"]
			local var_42_30 = 0

			if var_42_30 < arg_39_1.time_ and arg_39_1.time_ <= var_42_30 + arg_42_0 and not isNil(var_42_29) and arg_39_1.var_.characterEffect1084ui_story == nil then
				arg_39_1.var_.characterEffect1084ui_story = var_42_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_31 = 0.200000002980232

			if var_42_30 <= arg_39_1.time_ and arg_39_1.time_ < var_42_30 + var_42_31 and not isNil(var_42_29) then
				local var_42_32 = (arg_39_1.time_ - var_42_30) / var_42_31

				if arg_39_1.var_.characterEffect1084ui_story and not isNil(var_42_29) then
					local var_42_33 = Mathf.Lerp(0, 0.5, var_42_32)

					arg_39_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_39_1.var_.characterEffect1084ui_story.fillRatio = var_42_33
				end
			end

			if arg_39_1.time_ >= var_42_30 + var_42_31 and arg_39_1.time_ < var_42_30 + var_42_31 + arg_42_0 and not isNil(var_42_29) and arg_39_1.var_.characterEffect1084ui_story then
				local var_42_34 = 0.5

				arg_39_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_39_1.var_.characterEffect1084ui_story.fillRatio = var_42_34
			end

			local var_42_35 = 0
			local var_42_36 = 0.75

			if var_42_35 < arg_39_1.time_ and arg_39_1.time_ <= var_42_35 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				local var_42_37 = arg_39_1:FormatText(StoryNameCfg[471].name)

				arg_39_1.leftNameTxt_.text = var_42_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_38 = arg_39_1:GetWordFromCfg(319671009)
				local var_42_39 = arg_39_1:FormatText(var_42_38.content)

				arg_39_1.text_.text = var_42_39

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_40 = 30
				local var_42_41 = utf8.len(var_42_39)
				local var_42_42 = var_42_40 <= 0 and var_42_36 or var_42_36 * (var_42_41 / var_42_40)

				if var_42_42 > 0 and var_42_36 < var_42_42 then
					arg_39_1.talkMaxDuration = var_42_42

					if var_42_42 + var_42_35 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_42 + var_42_35
					end
				end

				arg_39_1.text_.text = var_42_39
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671009", "story_v_out_319671.awb") ~= 0 then
					local var_42_43 = manager.audio:GetVoiceLength("story_v_out_319671", "319671009", "story_v_out_319671.awb") / 1000

					if var_42_43 + var_42_35 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_43 + var_42_35
					end

					if var_42_38.prefab_name ~= "" and arg_39_1.actors_[var_42_38.prefab_name] ~= nil then
						local var_42_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_38.prefab_name].transform, "story_v_out_319671", "319671009", "story_v_out_319671.awb")

						arg_39_1:RecordAudio("319671009", var_42_44)
						arg_39_1:RecordAudio("319671009", var_42_44)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_out_319671", "319671009", "story_v_out_319671.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_out_319671", "319671009", "story_v_out_319671.awb")
				end

				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_45 = math.max(var_42_36, arg_39_1.talkMaxDuration)

			if var_42_35 <= arg_39_1.time_ and arg_39_1.time_ < var_42_35 + var_42_45 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_35) / var_42_45

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_35 + var_42_45 and arg_39_1.time_ < var_42_35 + var_42_45 + arg_42_0 then
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
			local var_46_0 = arg_43_1.actors_["1095ui_story"]
			local var_46_1 = 0

			if var_46_1 < arg_43_1.time_ and arg_43_1.time_ <= var_46_1 + arg_46_0 and not isNil(var_46_0) and arg_43_1.var_.characterEffect1095ui_story == nil then
				arg_43_1.var_.characterEffect1095ui_story = var_46_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_2 = 0.200000002980232

			if var_46_1 <= arg_43_1.time_ and arg_43_1.time_ < var_46_1 + var_46_2 and not isNil(var_46_0) then
				local var_46_3 = (arg_43_1.time_ - var_46_1) / var_46_2

				if arg_43_1.var_.characterEffect1095ui_story and not isNil(var_46_0) then
					local var_46_4 = Mathf.Lerp(0, 0.5, var_46_3)

					arg_43_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_43_1.var_.characterEffect1095ui_story.fillRatio = var_46_4
				end
			end

			if arg_43_1.time_ >= var_46_1 + var_46_2 and arg_43_1.time_ < var_46_1 + var_46_2 + arg_46_0 and not isNil(var_46_0) and arg_43_1.var_.characterEffect1095ui_story then
				local var_46_5 = 0.5

				arg_43_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_43_1.var_.characterEffect1095ui_story.fillRatio = var_46_5
			end

			local var_46_6 = 0
			local var_46_7 = 0.175

			if var_46_6 < arg_43_1.time_ and arg_43_1.time_ <= var_46_6 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				local var_46_8 = arg_43_1:FormatText(StoryNameCfg[694].name)

				arg_43_1.leftNameTxt_.text = var_46_8

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

				local var_46_9 = arg_43_1:GetWordFromCfg(319671010)
				local var_46_10 = arg_43_1:FormatText(var_46_9.content)

				arg_43_1.text_.text = var_46_10

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_11 = 7
				local var_46_12 = utf8.len(var_46_10)
				local var_46_13 = var_46_11 <= 0 and var_46_7 or var_46_7 * (var_46_12 / var_46_11)

				if var_46_13 > 0 and var_46_7 < var_46_13 then
					arg_43_1.talkMaxDuration = var_46_13

					if var_46_13 + var_46_6 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_13 + var_46_6
					end
				end

				arg_43_1.text_.text = var_46_10
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671010", "story_v_out_319671.awb") ~= 0 then
					local var_46_14 = manager.audio:GetVoiceLength("story_v_out_319671", "319671010", "story_v_out_319671.awb") / 1000

					if var_46_14 + var_46_6 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_14 + var_46_6
					end

					if var_46_9.prefab_name ~= "" and arg_43_1.actors_[var_46_9.prefab_name] ~= nil then
						local var_46_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_9.prefab_name].transform, "story_v_out_319671", "319671010", "story_v_out_319671.awb")

						arg_43_1:RecordAudio("319671010", var_46_15)
						arg_43_1:RecordAudio("319671010", var_46_15)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_319671", "319671010", "story_v_out_319671.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_319671", "319671010", "story_v_out_319671.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_16 = math.max(var_46_7, arg_43_1.talkMaxDuration)

			if var_46_6 <= arg_43_1.time_ and arg_43_1.time_ < var_46_6 + var_46_16 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_6) / var_46_16

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_6 + var_46_16 and arg_43_1.time_ < var_46_6 + var_46_16 + arg_46_0 then
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
			local var_50_0 = arg_47_1.actors_["1095ui_story"].transform
			local var_50_1 = 0

			if var_50_1 < arg_47_1.time_ and arg_47_1.time_ <= var_50_1 + arg_50_0 then
				arg_47_1.var_.moveOldPos1095ui_story = var_50_0.localPosition
			end

			local var_50_2 = 0.001

			if var_50_1 <= arg_47_1.time_ and arg_47_1.time_ < var_50_1 + var_50_2 then
				local var_50_3 = (arg_47_1.time_ - var_50_1) / var_50_2
				local var_50_4 = Vector3.New(0, 100, 0)

				var_50_0.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos1095ui_story, var_50_4, var_50_3)

				local var_50_5 = manager.ui.mainCamera.transform.position - var_50_0.position

				var_50_0.forward = Vector3.New(var_50_5.x, var_50_5.y, var_50_5.z)

				local var_50_6 = var_50_0.localEulerAngles

				var_50_6.z = 0
				var_50_6.x = 0
				var_50_0.localEulerAngles = var_50_6
			end

			if arg_47_1.time_ >= var_50_1 + var_50_2 and arg_47_1.time_ < var_50_1 + var_50_2 + arg_50_0 then
				var_50_0.localPosition = Vector3.New(0, 100, 0)

				local var_50_7 = manager.ui.mainCamera.transform.position - var_50_0.position

				var_50_0.forward = Vector3.New(var_50_7.x, var_50_7.y, var_50_7.z)

				local var_50_8 = var_50_0.localEulerAngles

				var_50_8.z = 0
				var_50_8.x = 0
				var_50_0.localEulerAngles = var_50_8
			end

			local var_50_9 = 0
			local var_50_10 = 1.175

			if var_50_9 < arg_47_1.time_ and arg_47_1.time_ <= var_50_9 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, false)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_11 = arg_47_1:GetWordFromCfg(319671011)
				local var_50_12 = arg_47_1:FormatText(var_50_11.content)

				arg_47_1.text_.text = var_50_12

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_13 = 47
				local var_50_14 = utf8.len(var_50_12)
				local var_50_15 = var_50_13 <= 0 and var_50_10 or var_50_10 * (var_50_14 / var_50_13)

				if var_50_15 > 0 and var_50_10 < var_50_15 then
					arg_47_1.talkMaxDuration = var_50_15

					if var_50_15 + var_50_9 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_15 + var_50_9
					end
				end

				arg_47_1.text_.text = var_50_12
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)
				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_16 = math.max(var_50_10, arg_47_1.talkMaxDuration)

			if var_50_9 <= arg_47_1.time_ and arg_47_1.time_ < var_50_9 + var_50_16 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_9) / var_50_16

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_9 + var_50_16 and arg_47_1.time_ < var_50_9 + var_50_16 + arg_50_0 then
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
			local var_54_0 = "D10"

			if arg_51_1.bgs_[var_54_0] == nil then
				local var_54_1 = Object.Instantiate(arg_51_1.paintGo_)

				var_54_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_54_0)
				var_54_1.name = var_54_0
				var_54_1.transform.parent = arg_51_1.stage_.transform
				var_54_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_51_1.bgs_[var_54_0] = var_54_1
			end

			local var_54_2 = 2

			if var_54_2 < arg_51_1.time_ and arg_51_1.time_ <= var_54_2 + arg_54_0 then
				local var_54_3 = manager.ui.mainCamera.transform.localPosition
				local var_54_4 = Vector3.New(0, 0, 10) + Vector3.New(var_54_3.x, var_54_3.y, 0)
				local var_54_5 = arg_51_1.bgs_.D10

				var_54_5.transform.localPosition = var_54_4
				var_54_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_54_6 = var_54_5:GetComponent("SpriteRenderer")

				if var_54_6 and var_54_6.sprite then
					local var_54_7 = (var_54_5.transform.localPosition - var_54_3).z
					local var_54_8 = manager.ui.mainCameraCom_
					local var_54_9 = 2 * var_54_7 * Mathf.Tan(var_54_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_54_10 = var_54_9 * var_54_8.aspect
					local var_54_11 = var_54_6.sprite.bounds.size.x
					local var_54_12 = var_54_6.sprite.bounds.size.y
					local var_54_13 = var_54_10 / var_54_11
					local var_54_14 = var_54_9 / var_54_12
					local var_54_15 = var_54_14 < var_54_13 and var_54_13 or var_54_14

					var_54_5.transform.localScale = Vector3.New(var_54_15, var_54_15, 0)
				end

				for iter_54_0, iter_54_1 in pairs(arg_51_1.bgs_) do
					if iter_54_0 ~= "D10" then
						iter_54_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_54_16 = 0

			if var_54_16 < arg_51_1.time_ and arg_51_1.time_ <= var_54_16 + arg_54_0 then
				arg_51_1.allBtn_.enabled = false
			end

			local var_54_17 = 0.3

			if arg_51_1.time_ >= var_54_16 + var_54_17 and arg_51_1.time_ < var_54_16 + var_54_17 + arg_54_0 then
				arg_51_1.allBtn_.enabled = true
			end

			local var_54_18 = 0

			if var_54_18 < arg_51_1.time_ and arg_51_1.time_ <= var_54_18 + arg_54_0 then
				arg_51_1.mask_.enabled = true
				arg_51_1.mask_.raycastTarget = true

				arg_51_1:SetGaussion(false)
			end

			local var_54_19 = 2

			if var_54_18 <= arg_51_1.time_ and arg_51_1.time_ < var_54_18 + var_54_19 then
				local var_54_20 = (arg_51_1.time_ - var_54_18) / var_54_19
				local var_54_21 = Color.New(0, 0, 0)

				var_54_21.a = Mathf.Lerp(0, 1, var_54_20)
				arg_51_1.mask_.color = var_54_21
			end

			if arg_51_1.time_ >= var_54_18 + var_54_19 and arg_51_1.time_ < var_54_18 + var_54_19 + arg_54_0 then
				local var_54_22 = Color.New(0, 0, 0)

				var_54_22.a = 1
				arg_51_1.mask_.color = var_54_22
			end

			local var_54_23 = 2

			if var_54_23 < arg_51_1.time_ and arg_51_1.time_ <= var_54_23 + arg_54_0 then
				arg_51_1.mask_.enabled = true
				arg_51_1.mask_.raycastTarget = true

				arg_51_1:SetGaussion(false)
			end

			local var_54_24 = 2

			if var_54_23 <= arg_51_1.time_ and arg_51_1.time_ < var_54_23 + var_54_24 then
				local var_54_25 = (arg_51_1.time_ - var_54_23) / var_54_24
				local var_54_26 = Color.New(0, 0, 0)

				var_54_26.a = Mathf.Lerp(1, 0, var_54_25)
				arg_51_1.mask_.color = var_54_26
			end

			if arg_51_1.time_ >= var_54_23 + var_54_24 and arg_51_1.time_ < var_54_23 + var_54_24 + arg_54_0 then
				local var_54_27 = Color.New(0, 0, 0)
				local var_54_28 = 0

				arg_51_1.mask_.enabled = false
				var_54_27.a = var_54_28
				arg_51_1.mask_.color = var_54_27
			end

			if arg_51_1.frameCnt_ <= 1 then
				arg_51_1.dialog_:SetActive(false)
			end

			local var_54_29 = 3.86666666666667
			local var_54_30 = 0.975

			if var_54_29 < arg_51_1.time_ and arg_51_1.time_ <= var_54_29 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0

				arg_51_1.dialog_:SetActive(true)

				arg_51_1.dialogCg_.alpha = 0

				local var_54_31 = LeanTween.value(arg_51_1.dialog_, 0, 1, 0.3)

				var_54_31:setOnUpdate(LuaHelper.FloatAction(function(arg_55_0)
					arg_51_1.dialogCg_.alpha = arg_55_0
				end))
				var_54_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_51_1.dialog_)
					var_54_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_51_1.duration_ = arg_51_1.duration_ + 0.3

				SetActive(arg_51_1.leftNameGo_, false)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_32 = arg_51_1:GetWordFromCfg(319671012)
				local var_54_33 = arg_51_1:FormatText(var_54_32.content)

				arg_51_1.text_.text = var_54_33

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_34 = 39
				local var_54_35 = utf8.len(var_54_33)
				local var_54_36 = var_54_34 <= 0 and var_54_30 or var_54_30 * (var_54_35 / var_54_34)

				if var_54_36 > 0 and var_54_30 < var_54_36 then
					arg_51_1.talkMaxDuration = var_54_36
					var_54_29 = var_54_29 + 0.3

					if var_54_36 + var_54_29 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_36 + var_54_29
					end
				end

				arg_51_1.text_.text = var_54_33
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)
				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_37 = var_54_29 + 0.3
			local var_54_38 = math.max(var_54_30, arg_51_1.talkMaxDuration)

			if var_54_37 <= arg_51_1.time_ and arg_51_1.time_ < var_54_37 + var_54_38 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_37) / var_54_38

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_37 + var_54_38 and arg_51_1.time_ < var_54_37 + var_54_38 + arg_54_0 then
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
			local var_60_0 = arg_57_1.actors_["1084ui_story"].transform
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 then
				arg_57_1.var_.moveOldPos1084ui_story = var_60_0.localPosition
			end

			local var_60_2 = 0.001

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_2 then
				local var_60_3 = (arg_57_1.time_ - var_60_1) / var_60_2
				local var_60_4 = Vector3.New(0, -0.97, -6)

				var_60_0.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1084ui_story, var_60_4, var_60_3)

				local var_60_5 = manager.ui.mainCamera.transform.position - var_60_0.position

				var_60_0.forward = Vector3.New(var_60_5.x, var_60_5.y, var_60_5.z)

				local var_60_6 = var_60_0.localEulerAngles

				var_60_6.z = 0
				var_60_6.x = 0
				var_60_0.localEulerAngles = var_60_6
			end

			if arg_57_1.time_ >= var_60_1 + var_60_2 and arg_57_1.time_ < var_60_1 + var_60_2 + arg_60_0 then
				var_60_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_60_7 = manager.ui.mainCamera.transform.position - var_60_0.position

				var_60_0.forward = Vector3.New(var_60_7.x, var_60_7.y, var_60_7.z)

				local var_60_8 = var_60_0.localEulerAngles

				var_60_8.z = 0
				var_60_8.x = 0
				var_60_0.localEulerAngles = var_60_8
			end

			local var_60_9 = arg_57_1.actors_["1084ui_story"]
			local var_60_10 = 0

			if var_60_10 < arg_57_1.time_ and arg_57_1.time_ <= var_60_10 + arg_60_0 and not isNil(var_60_9) and arg_57_1.var_.characterEffect1084ui_story == nil then
				arg_57_1.var_.characterEffect1084ui_story = var_60_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_11 = 0.200000002980232

			if var_60_10 <= arg_57_1.time_ and arg_57_1.time_ < var_60_10 + var_60_11 and not isNil(var_60_9) then
				local var_60_12 = (arg_57_1.time_ - var_60_10) / var_60_11

				if arg_57_1.var_.characterEffect1084ui_story and not isNil(var_60_9) then
					arg_57_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= var_60_10 + var_60_11 and arg_57_1.time_ < var_60_10 + var_60_11 + arg_60_0 and not isNil(var_60_9) and arg_57_1.var_.characterEffect1084ui_story then
				arg_57_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_60_13 = 0

			if var_60_13 < arg_57_1.time_ and arg_57_1.time_ <= var_60_13 + arg_60_0 then
				arg_57_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_60_14 = 0

			if var_60_14 < arg_57_1.time_ and arg_57_1.time_ <= var_60_14 + arg_60_0 then
				arg_57_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_60_15 = 0
			local var_60_16 = 0.625

			if var_60_15 < arg_57_1.time_ and arg_57_1.time_ <= var_60_15 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_17 = arg_57_1:FormatText(StoryNameCfg[6].name)

				arg_57_1.leftNameTxt_.text = var_60_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_18 = arg_57_1:GetWordFromCfg(319671013)
				local var_60_19 = arg_57_1:FormatText(var_60_18.content)

				arg_57_1.text_.text = var_60_19

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_20 = 25
				local var_60_21 = utf8.len(var_60_19)
				local var_60_22 = var_60_20 <= 0 and var_60_16 or var_60_16 * (var_60_21 / var_60_20)

				if var_60_22 > 0 and var_60_16 < var_60_22 then
					arg_57_1.talkMaxDuration = var_60_22

					if var_60_22 + var_60_15 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_22 + var_60_15
					end
				end

				arg_57_1.text_.text = var_60_19
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671013", "story_v_out_319671.awb") ~= 0 then
					local var_60_23 = manager.audio:GetVoiceLength("story_v_out_319671", "319671013", "story_v_out_319671.awb") / 1000

					if var_60_23 + var_60_15 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_23 + var_60_15
					end

					if var_60_18.prefab_name ~= "" and arg_57_1.actors_[var_60_18.prefab_name] ~= nil then
						local var_60_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_18.prefab_name].transform, "story_v_out_319671", "319671013", "story_v_out_319671.awb")

						arg_57_1:RecordAudio("319671013", var_60_24)
						arg_57_1:RecordAudio("319671013", var_60_24)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_319671", "319671013", "story_v_out_319671.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_319671", "319671013", "story_v_out_319671.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_25 = math.max(var_60_16, arg_57_1.talkMaxDuration)

			if var_60_15 <= arg_57_1.time_ and arg_57_1.time_ < var_60_15 + var_60_25 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_15) / var_60_25

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_15 + var_60_25 and arg_57_1.time_ < var_60_15 + var_60_25 + arg_60_0 then
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
			local var_64_0 = arg_61_1.actors_["1084ui_story"]
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.characterEffect1084ui_story == nil then
				arg_61_1.var_.characterEffect1084ui_story = var_64_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_2 = 0.200000002980232

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_2 and not isNil(var_64_0) then
				local var_64_3 = (arg_61_1.time_ - var_64_1) / var_64_2

				if arg_61_1.var_.characterEffect1084ui_story and not isNil(var_64_0) then
					local var_64_4 = Mathf.Lerp(0, 0.5, var_64_3)

					arg_61_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_61_1.var_.characterEffect1084ui_story.fillRatio = var_64_4
				end
			end

			if arg_61_1.time_ >= var_64_1 + var_64_2 and arg_61_1.time_ < var_64_1 + var_64_2 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.characterEffect1084ui_story then
				local var_64_5 = 0.5

				arg_61_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_61_1.var_.characterEffect1084ui_story.fillRatio = var_64_5
			end

			local var_64_6 = arg_61_1.actors_["1095ui_story"].transform
			local var_64_7 = 0

			if var_64_7 < arg_61_1.time_ and arg_61_1.time_ <= var_64_7 + arg_64_0 then
				arg_61_1.var_.moveOldPos1095ui_story = var_64_6.localPosition
			end

			local var_64_8 = 0.001

			if var_64_7 <= arg_61_1.time_ and arg_61_1.time_ < var_64_7 + var_64_8 then
				local var_64_9 = (arg_61_1.time_ - var_64_7) / var_64_8
				local var_64_10 = Vector3.New(0.7, -0.98, -6.1)

				var_64_6.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1095ui_story, var_64_10, var_64_9)

				local var_64_11 = manager.ui.mainCamera.transform.position - var_64_6.position

				var_64_6.forward = Vector3.New(var_64_11.x, var_64_11.y, var_64_11.z)

				local var_64_12 = var_64_6.localEulerAngles

				var_64_12.z = 0
				var_64_12.x = 0
				var_64_6.localEulerAngles = var_64_12
			end

			if arg_61_1.time_ >= var_64_7 + var_64_8 and arg_61_1.time_ < var_64_7 + var_64_8 + arg_64_0 then
				var_64_6.localPosition = Vector3.New(0.7, -0.98, -6.1)

				local var_64_13 = manager.ui.mainCamera.transform.position - var_64_6.position

				var_64_6.forward = Vector3.New(var_64_13.x, var_64_13.y, var_64_13.z)

				local var_64_14 = var_64_6.localEulerAngles

				var_64_14.z = 0
				var_64_14.x = 0
				var_64_6.localEulerAngles = var_64_14
			end

			local var_64_15 = arg_61_1.actors_["1084ui_story"].transform
			local var_64_16 = 0

			if var_64_16 < arg_61_1.time_ and arg_61_1.time_ <= var_64_16 + arg_64_0 then
				arg_61_1.var_.moveOldPos1084ui_story = var_64_15.localPosition
			end

			local var_64_17 = 0.001

			if var_64_16 <= arg_61_1.time_ and arg_61_1.time_ < var_64_16 + var_64_17 then
				local var_64_18 = (arg_61_1.time_ - var_64_16) / var_64_17
				local var_64_19 = Vector3.New(-0.7, -0.97, -6)

				var_64_15.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1084ui_story, var_64_19, var_64_18)

				local var_64_20 = manager.ui.mainCamera.transform.position - var_64_15.position

				var_64_15.forward = Vector3.New(var_64_20.x, var_64_20.y, var_64_20.z)

				local var_64_21 = var_64_15.localEulerAngles

				var_64_21.z = 0
				var_64_21.x = 0
				var_64_15.localEulerAngles = var_64_21
			end

			if arg_61_1.time_ >= var_64_16 + var_64_17 and arg_61_1.time_ < var_64_16 + var_64_17 + arg_64_0 then
				var_64_15.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_64_22 = manager.ui.mainCamera.transform.position - var_64_15.position

				var_64_15.forward = Vector3.New(var_64_22.x, var_64_22.y, var_64_22.z)

				local var_64_23 = var_64_15.localEulerAngles

				var_64_23.z = 0
				var_64_23.x = 0
				var_64_15.localEulerAngles = var_64_23
			end

			local var_64_24 = arg_61_1.actors_["1095ui_story"]
			local var_64_25 = 0

			if var_64_25 < arg_61_1.time_ and arg_61_1.time_ <= var_64_25 + arg_64_0 and not isNil(var_64_24) and arg_61_1.var_.characterEffect1095ui_story == nil then
				arg_61_1.var_.characterEffect1095ui_story = var_64_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_26 = 0.200000002980232

			if var_64_25 <= arg_61_1.time_ and arg_61_1.time_ < var_64_25 + var_64_26 and not isNil(var_64_24) then
				local var_64_27 = (arg_61_1.time_ - var_64_25) / var_64_26

				if arg_61_1.var_.characterEffect1095ui_story and not isNil(var_64_24) then
					arg_61_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= var_64_25 + var_64_26 and arg_61_1.time_ < var_64_25 + var_64_26 + arg_64_0 and not isNil(var_64_24) and arg_61_1.var_.characterEffect1095ui_story then
				arg_61_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_64_28 = 0

			if var_64_28 < arg_61_1.time_ and arg_61_1.time_ <= var_64_28 + arg_64_0 then
				arg_61_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action3_1")
			end

			local var_64_29 = 0

			if var_64_29 < arg_61_1.time_ and arg_61_1.time_ <= var_64_29 + arg_64_0 then
				arg_61_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_64_30 = 0
			local var_64_31 = 0.425

			if var_64_30 < arg_61_1.time_ and arg_61_1.time_ <= var_64_30 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_32 = arg_61_1:FormatText(StoryNameCfg[471].name)

				arg_61_1.leftNameTxt_.text = var_64_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_33 = arg_61_1:GetWordFromCfg(319671014)
				local var_64_34 = arg_61_1:FormatText(var_64_33.content)

				arg_61_1.text_.text = var_64_34

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_35 = 17
				local var_64_36 = utf8.len(var_64_34)
				local var_64_37 = var_64_35 <= 0 and var_64_31 or var_64_31 * (var_64_36 / var_64_35)

				if var_64_37 > 0 and var_64_31 < var_64_37 then
					arg_61_1.talkMaxDuration = var_64_37

					if var_64_37 + var_64_30 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_37 + var_64_30
					end
				end

				arg_61_1.text_.text = var_64_34
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671014", "story_v_out_319671.awb") ~= 0 then
					local var_64_38 = manager.audio:GetVoiceLength("story_v_out_319671", "319671014", "story_v_out_319671.awb") / 1000

					if var_64_38 + var_64_30 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_38 + var_64_30
					end

					if var_64_33.prefab_name ~= "" and arg_61_1.actors_[var_64_33.prefab_name] ~= nil then
						local var_64_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_33.prefab_name].transform, "story_v_out_319671", "319671014", "story_v_out_319671.awb")

						arg_61_1:RecordAudio("319671014", var_64_39)
						arg_61_1:RecordAudio("319671014", var_64_39)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_319671", "319671014", "story_v_out_319671.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_319671", "319671014", "story_v_out_319671.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_40 = math.max(var_64_31, arg_61_1.talkMaxDuration)

			if var_64_30 <= arg_61_1.time_ and arg_61_1.time_ < var_64_30 + var_64_40 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_30) / var_64_40

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_30 + var_64_40 and arg_61_1.time_ < var_64_30 + var_64_40 + arg_64_0 then
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
			local var_68_0 = arg_65_1.actors_["1084ui_story"]
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect1084ui_story == nil then
				arg_65_1.var_.characterEffect1084ui_story = var_68_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_2 = 0.200000002980232

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 and not isNil(var_68_0) then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2

				if arg_65_1.var_.characterEffect1084ui_story and not isNil(var_68_0) then
					arg_65_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect1084ui_story then
				arg_65_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_68_4 = arg_65_1.actors_["1095ui_story"]
			local var_68_5 = 0

			if var_68_5 < arg_65_1.time_ and arg_65_1.time_ <= var_68_5 + arg_68_0 and not isNil(var_68_4) and arg_65_1.var_.characterEffect1095ui_story == nil then
				arg_65_1.var_.characterEffect1095ui_story = var_68_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_6 = 0.200000002980232

			if var_68_5 <= arg_65_1.time_ and arg_65_1.time_ < var_68_5 + var_68_6 and not isNil(var_68_4) then
				local var_68_7 = (arg_65_1.time_ - var_68_5) / var_68_6

				if arg_65_1.var_.characterEffect1095ui_story and not isNil(var_68_4) then
					local var_68_8 = Mathf.Lerp(0, 0.5, var_68_7)

					arg_65_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_65_1.var_.characterEffect1095ui_story.fillRatio = var_68_8
				end
			end

			if arg_65_1.time_ >= var_68_5 + var_68_6 and arg_65_1.time_ < var_68_5 + var_68_6 + arg_68_0 and not isNil(var_68_4) and arg_65_1.var_.characterEffect1095ui_story then
				local var_68_9 = 0.5

				arg_65_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_65_1.var_.characterEffect1095ui_story.fillRatio = var_68_9
			end

			local var_68_10 = 0
			local var_68_11 = 0.5

			if var_68_10 < arg_65_1.time_ and arg_65_1.time_ <= var_68_10 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_12 = arg_65_1:FormatText(StoryNameCfg[6].name)

				arg_65_1.leftNameTxt_.text = var_68_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_13 = arg_65_1:GetWordFromCfg(319671015)
				local var_68_14 = arg_65_1:FormatText(var_68_13.content)

				arg_65_1.text_.text = var_68_14

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_15 = 20
				local var_68_16 = utf8.len(var_68_14)
				local var_68_17 = var_68_15 <= 0 and var_68_11 or var_68_11 * (var_68_16 / var_68_15)

				if var_68_17 > 0 and var_68_11 < var_68_17 then
					arg_65_1.talkMaxDuration = var_68_17

					if var_68_17 + var_68_10 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_17 + var_68_10
					end
				end

				arg_65_1.text_.text = var_68_14
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671015", "story_v_out_319671.awb") ~= 0 then
					local var_68_18 = manager.audio:GetVoiceLength("story_v_out_319671", "319671015", "story_v_out_319671.awb") / 1000

					if var_68_18 + var_68_10 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_18 + var_68_10
					end

					if var_68_13.prefab_name ~= "" and arg_65_1.actors_[var_68_13.prefab_name] ~= nil then
						local var_68_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_13.prefab_name].transform, "story_v_out_319671", "319671015", "story_v_out_319671.awb")

						arg_65_1:RecordAudio("319671015", var_68_19)
						arg_65_1:RecordAudio("319671015", var_68_19)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_319671", "319671015", "story_v_out_319671.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_319671", "319671015", "story_v_out_319671.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_20 = math.max(var_68_11, arg_65_1.talkMaxDuration)

			if var_68_10 <= arg_65_1.time_ and arg_65_1.time_ < var_68_10 + var_68_20 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_10) / var_68_20

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_10 + var_68_20 and arg_65_1.time_ < var_68_10 + var_68_20 + arg_68_0 then
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
			local var_72_0 = 0

			if var_72_0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_0 + arg_72_0 then
				arg_69_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_2")
			end

			local var_72_1 = 0
			local var_72_2 = 0.55

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_3 = arg_69_1:FormatText(StoryNameCfg[6].name)

				arg_69_1.leftNameTxt_.text = var_72_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_4 = arg_69_1:GetWordFromCfg(319671016)
				local var_72_5 = arg_69_1:FormatText(var_72_4.content)

				arg_69_1.text_.text = var_72_5

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_6 = 22
				local var_72_7 = utf8.len(var_72_5)
				local var_72_8 = var_72_6 <= 0 and var_72_2 or var_72_2 * (var_72_7 / var_72_6)

				if var_72_8 > 0 and var_72_2 < var_72_8 then
					arg_69_1.talkMaxDuration = var_72_8

					if var_72_8 + var_72_1 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_8 + var_72_1
					end
				end

				arg_69_1.text_.text = var_72_5
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671016", "story_v_out_319671.awb") ~= 0 then
					local var_72_9 = manager.audio:GetVoiceLength("story_v_out_319671", "319671016", "story_v_out_319671.awb") / 1000

					if var_72_9 + var_72_1 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_9 + var_72_1
					end

					if var_72_4.prefab_name ~= "" and arg_69_1.actors_[var_72_4.prefab_name] ~= nil then
						local var_72_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_4.prefab_name].transform, "story_v_out_319671", "319671016", "story_v_out_319671.awb")

						arg_69_1:RecordAudio("319671016", var_72_10)
						arg_69_1:RecordAudio("319671016", var_72_10)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_319671", "319671016", "story_v_out_319671.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_319671", "319671016", "story_v_out_319671.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_11 = math.max(var_72_2, arg_69_1.talkMaxDuration)

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_11 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_1) / var_72_11

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_1 + var_72_11 and arg_69_1.time_ < var_72_1 + var_72_11 + arg_72_0 then
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
			local var_76_0 = arg_73_1.actors_["1084ui_story"]
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.characterEffect1084ui_story == nil then
				arg_73_1.var_.characterEffect1084ui_story = var_76_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_2 = 0.200000002980232

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_2 and not isNil(var_76_0) then
				local var_76_3 = (arg_73_1.time_ - var_76_1) / var_76_2

				if arg_73_1.var_.characterEffect1084ui_story and not isNil(var_76_0) then
					local var_76_4 = Mathf.Lerp(0, 0.5, var_76_3)

					arg_73_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_73_1.var_.characterEffect1084ui_story.fillRatio = var_76_4
				end
			end

			if arg_73_1.time_ >= var_76_1 + var_76_2 and arg_73_1.time_ < var_76_1 + var_76_2 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.characterEffect1084ui_story then
				local var_76_5 = 0.5

				arg_73_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_73_1.var_.characterEffect1084ui_story.fillRatio = var_76_5
			end

			local var_76_6 = 0
			local var_76_7 = 0.775

			if var_76_6 < arg_73_1.time_ and arg_73_1.time_ <= var_76_6 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, false)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_8 = arg_73_1:GetWordFromCfg(319671017)
				local var_76_9 = arg_73_1:FormatText(var_76_8.content)

				arg_73_1.text_.text = var_76_9

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_10 = 31
				local var_76_11 = utf8.len(var_76_9)
				local var_76_12 = var_76_10 <= 0 and var_76_7 or var_76_7 * (var_76_11 / var_76_10)

				if var_76_12 > 0 and var_76_7 < var_76_12 then
					arg_73_1.talkMaxDuration = var_76_12

					if var_76_12 + var_76_6 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_12 + var_76_6
					end
				end

				arg_73_1.text_.text = var_76_9
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_13 = math.max(var_76_7, arg_73_1.talkMaxDuration)

			if var_76_6 <= arg_73_1.time_ and arg_73_1.time_ < var_76_6 + var_76_13 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_6) / var_76_13

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_6 + var_76_13 and arg_73_1.time_ < var_76_6 + var_76_13 + arg_76_0 then
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
			local var_80_0 = arg_77_1.actors_["1095ui_story"]
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.characterEffect1095ui_story == nil then
				arg_77_1.var_.characterEffect1095ui_story = var_80_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_2 = 0.200000002980232

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_2 and not isNil(var_80_0) then
				local var_80_3 = (arg_77_1.time_ - var_80_1) / var_80_2

				if arg_77_1.var_.characterEffect1095ui_story and not isNil(var_80_0) then
					arg_77_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= var_80_1 + var_80_2 and arg_77_1.time_ < var_80_1 + var_80_2 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.characterEffect1095ui_story then
				arg_77_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_80_4 = 0

			if var_80_4 < arg_77_1.time_ and arg_77_1.time_ <= var_80_4 + arg_80_0 then
				arg_77_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action3_2")
			end

			local var_80_5 = 0

			if var_80_5 < arg_77_1.time_ and arg_77_1.time_ <= var_80_5 + arg_80_0 then
				arg_77_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_80_6 = 0
			local var_80_7 = 0.425

			if var_80_6 < arg_77_1.time_ and arg_77_1.time_ <= var_80_6 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_8 = arg_77_1:FormatText(StoryNameCfg[471].name)

				arg_77_1.leftNameTxt_.text = var_80_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_9 = arg_77_1:GetWordFromCfg(319671018)
				local var_80_10 = arg_77_1:FormatText(var_80_9.content)

				arg_77_1.text_.text = var_80_10

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_11 = 17
				local var_80_12 = utf8.len(var_80_10)
				local var_80_13 = var_80_11 <= 0 and var_80_7 or var_80_7 * (var_80_12 / var_80_11)

				if var_80_13 > 0 and var_80_7 < var_80_13 then
					arg_77_1.talkMaxDuration = var_80_13

					if var_80_13 + var_80_6 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_13 + var_80_6
					end
				end

				arg_77_1.text_.text = var_80_10
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671018", "story_v_out_319671.awb") ~= 0 then
					local var_80_14 = manager.audio:GetVoiceLength("story_v_out_319671", "319671018", "story_v_out_319671.awb") / 1000

					if var_80_14 + var_80_6 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_14 + var_80_6
					end

					if var_80_9.prefab_name ~= "" and arg_77_1.actors_[var_80_9.prefab_name] ~= nil then
						local var_80_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_9.prefab_name].transform, "story_v_out_319671", "319671018", "story_v_out_319671.awb")

						arg_77_1:RecordAudio("319671018", var_80_15)
						arg_77_1:RecordAudio("319671018", var_80_15)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_319671", "319671018", "story_v_out_319671.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_319671", "319671018", "story_v_out_319671.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_16 = math.max(var_80_7, arg_77_1.talkMaxDuration)

			if var_80_6 <= arg_77_1.time_ and arg_77_1.time_ < var_80_6 + var_80_16 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_6) / var_80_16

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_6 + var_80_16 and arg_77_1.time_ < var_80_6 + var_80_16 + arg_80_0 then
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
			local var_84_0 = arg_81_1.actors_["1095ui_story"].transform
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 then
				arg_81_1.var_.moveOldPos1095ui_story = var_84_0.localPosition
			end

			local var_84_2 = 0.001

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_2 then
				local var_84_3 = (arg_81_1.time_ - var_84_1) / var_84_2
				local var_84_4 = Vector3.New(0.7, -0.98, -6.1)

				var_84_0.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1095ui_story, var_84_4, var_84_3)

				local var_84_5 = manager.ui.mainCamera.transform.position - var_84_0.position

				var_84_0.forward = Vector3.New(var_84_5.x, var_84_5.y, var_84_5.z)

				local var_84_6 = var_84_0.localEulerAngles

				var_84_6.z = 0
				var_84_6.x = 0
				var_84_0.localEulerAngles = var_84_6
			end

			if arg_81_1.time_ >= var_84_1 + var_84_2 and arg_81_1.time_ < var_84_1 + var_84_2 + arg_84_0 then
				var_84_0.localPosition = Vector3.New(0.7, -0.98, -6.1)

				local var_84_7 = manager.ui.mainCamera.transform.position - var_84_0.position

				var_84_0.forward = Vector3.New(var_84_7.x, var_84_7.y, var_84_7.z)

				local var_84_8 = var_84_0.localEulerAngles

				var_84_8.z = 0
				var_84_8.x = 0
				var_84_0.localEulerAngles = var_84_8
			end

			local var_84_9 = arg_81_1.actors_["1095ui_story"]
			local var_84_10 = 0

			if var_84_10 < arg_81_1.time_ and arg_81_1.time_ <= var_84_10 + arg_84_0 and not isNil(var_84_9) and arg_81_1.var_.characterEffect1095ui_story == nil then
				arg_81_1.var_.characterEffect1095ui_story = var_84_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_11 = 0.200000002980232

			if var_84_10 <= arg_81_1.time_ and arg_81_1.time_ < var_84_10 + var_84_11 and not isNil(var_84_9) then
				local var_84_12 = (arg_81_1.time_ - var_84_10) / var_84_11

				if arg_81_1.var_.characterEffect1095ui_story and not isNil(var_84_9) then
					arg_81_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= var_84_10 + var_84_11 and arg_81_1.time_ < var_84_10 + var_84_11 + arg_84_0 and not isNil(var_84_9) and arg_81_1.var_.characterEffect1095ui_story then
				arg_81_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_84_13 = 0

			if var_84_13 < arg_81_1.time_ and arg_81_1.time_ <= var_84_13 + arg_84_0 then
				arg_81_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_84_14 = 0
			local var_84_15 = 0.625

			if var_84_14 < arg_81_1.time_ and arg_81_1.time_ <= var_84_14 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_16 = arg_81_1:FormatText(StoryNameCfg[471].name)

				arg_81_1.leftNameTxt_.text = var_84_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_17 = arg_81_1:GetWordFromCfg(319671019)
				local var_84_18 = arg_81_1:FormatText(var_84_17.content)

				arg_81_1.text_.text = var_84_18

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_19 = 25
				local var_84_20 = utf8.len(var_84_18)
				local var_84_21 = var_84_19 <= 0 and var_84_15 or var_84_15 * (var_84_20 / var_84_19)

				if var_84_21 > 0 and var_84_15 < var_84_21 then
					arg_81_1.talkMaxDuration = var_84_21

					if var_84_21 + var_84_14 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_21 + var_84_14
					end
				end

				arg_81_1.text_.text = var_84_18
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671019", "story_v_out_319671.awb") ~= 0 then
					local var_84_22 = manager.audio:GetVoiceLength("story_v_out_319671", "319671019", "story_v_out_319671.awb") / 1000

					if var_84_22 + var_84_14 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_22 + var_84_14
					end

					if var_84_17.prefab_name ~= "" and arg_81_1.actors_[var_84_17.prefab_name] ~= nil then
						local var_84_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_17.prefab_name].transform, "story_v_out_319671", "319671019", "story_v_out_319671.awb")

						arg_81_1:RecordAudio("319671019", var_84_23)
						arg_81_1:RecordAudio("319671019", var_84_23)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_319671", "319671019", "story_v_out_319671.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_319671", "319671019", "story_v_out_319671.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_24 = math.max(var_84_15, arg_81_1.talkMaxDuration)

			if var_84_14 <= arg_81_1.time_ and arg_81_1.time_ < var_84_14 + var_84_24 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_14) / var_84_24

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_14 + var_84_24 and arg_81_1.time_ < var_84_14 + var_84_24 + arg_84_0 then
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
			local var_88_0 = arg_85_1.actors_["1095ui_story"]
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.characterEffect1095ui_story == nil then
				arg_85_1.var_.characterEffect1095ui_story = var_88_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_2 = 0.200000002980232

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_2 and not isNil(var_88_0) then
				local var_88_3 = (arg_85_1.time_ - var_88_1) / var_88_2

				if arg_85_1.var_.characterEffect1095ui_story and not isNil(var_88_0) then
					local var_88_4 = Mathf.Lerp(0, 0.5, var_88_3)

					arg_85_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_85_1.var_.characterEffect1095ui_story.fillRatio = var_88_4
				end
			end

			if arg_85_1.time_ >= var_88_1 + var_88_2 and arg_85_1.time_ < var_88_1 + var_88_2 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.characterEffect1095ui_story then
				local var_88_5 = 0.5

				arg_85_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_85_1.var_.characterEffect1095ui_story.fillRatio = var_88_5
			end

			local var_88_6 = arg_85_1.actors_["1084ui_story"]
			local var_88_7 = 0

			if var_88_7 < arg_85_1.time_ and arg_85_1.time_ <= var_88_7 + arg_88_0 and not isNil(var_88_6) and arg_85_1.var_.characterEffect1084ui_story == nil then
				arg_85_1.var_.characterEffect1084ui_story = var_88_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_8 = 0.200000002980232

			if var_88_7 <= arg_85_1.time_ and arg_85_1.time_ < var_88_7 + var_88_8 and not isNil(var_88_6) then
				local var_88_9 = (arg_85_1.time_ - var_88_7) / var_88_8

				if arg_85_1.var_.characterEffect1084ui_story and not isNil(var_88_6) then
					arg_85_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_85_1.time_ >= var_88_7 + var_88_8 and arg_85_1.time_ < var_88_7 + var_88_8 + arg_88_0 and not isNil(var_88_6) and arg_85_1.var_.characterEffect1084ui_story then
				arg_85_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_88_10 = 0
			local var_88_11 = 0.3

			if var_88_10 < arg_85_1.time_ and arg_85_1.time_ <= var_88_10 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_12 = arg_85_1:FormatText(StoryNameCfg[6].name)

				arg_85_1.leftNameTxt_.text = var_88_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_13 = arg_85_1:GetWordFromCfg(319671020)
				local var_88_14 = arg_85_1:FormatText(var_88_13.content)

				arg_85_1.text_.text = var_88_14

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_15 = 12
				local var_88_16 = utf8.len(var_88_14)
				local var_88_17 = var_88_15 <= 0 and var_88_11 or var_88_11 * (var_88_16 / var_88_15)

				if var_88_17 > 0 and var_88_11 < var_88_17 then
					arg_85_1.talkMaxDuration = var_88_17

					if var_88_17 + var_88_10 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_17 + var_88_10
					end
				end

				arg_85_1.text_.text = var_88_14
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671020", "story_v_out_319671.awb") ~= 0 then
					local var_88_18 = manager.audio:GetVoiceLength("story_v_out_319671", "319671020", "story_v_out_319671.awb") / 1000

					if var_88_18 + var_88_10 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_18 + var_88_10
					end

					if var_88_13.prefab_name ~= "" and arg_85_1.actors_[var_88_13.prefab_name] ~= nil then
						local var_88_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_13.prefab_name].transform, "story_v_out_319671", "319671020", "story_v_out_319671.awb")

						arg_85_1:RecordAudio("319671020", var_88_19)
						arg_85_1:RecordAudio("319671020", var_88_19)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_319671", "319671020", "story_v_out_319671.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_319671", "319671020", "story_v_out_319671.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_20 = math.max(var_88_11, arg_85_1.talkMaxDuration)

			if var_88_10 <= arg_85_1.time_ and arg_85_1.time_ < var_88_10 + var_88_20 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_10) / var_88_20

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_10 + var_88_20 and arg_85_1.time_ < var_88_10 + var_88_20 + arg_88_0 then
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
			local var_92_0 = arg_89_1.actors_["1084ui_story"]
			local var_92_1 = 0

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.characterEffect1084ui_story == nil then
				arg_89_1.var_.characterEffect1084ui_story = var_92_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_2 = 0.200000002980232

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_2 and not isNil(var_92_0) then
				local var_92_3 = (arg_89_1.time_ - var_92_1) / var_92_2

				if arg_89_1.var_.characterEffect1084ui_story and not isNil(var_92_0) then
					local var_92_4 = Mathf.Lerp(0, 0.5, var_92_3)

					arg_89_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_89_1.var_.characterEffect1084ui_story.fillRatio = var_92_4
				end
			end

			if arg_89_1.time_ >= var_92_1 + var_92_2 and arg_89_1.time_ < var_92_1 + var_92_2 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.characterEffect1084ui_story then
				local var_92_5 = 0.5

				arg_89_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_89_1.var_.characterEffect1084ui_story.fillRatio = var_92_5
			end

			local var_92_6 = arg_89_1.actors_["1095ui_story"]
			local var_92_7 = 0

			if var_92_7 < arg_89_1.time_ and arg_89_1.time_ <= var_92_7 + arg_92_0 and not isNil(var_92_6) and arg_89_1.var_.characterEffect1095ui_story == nil then
				arg_89_1.var_.characterEffect1095ui_story = var_92_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_8 = 0.200000002980232

			if var_92_7 <= arg_89_1.time_ and arg_89_1.time_ < var_92_7 + var_92_8 and not isNil(var_92_6) then
				local var_92_9 = (arg_89_1.time_ - var_92_7) / var_92_8

				if arg_89_1.var_.characterEffect1095ui_story and not isNil(var_92_6) then
					arg_89_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= var_92_7 + var_92_8 and arg_89_1.time_ < var_92_7 + var_92_8 + arg_92_0 and not isNil(var_92_6) and arg_89_1.var_.characterEffect1095ui_story then
				arg_89_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_92_10 = 0
			local var_92_11 = 0.375

			if var_92_10 < arg_89_1.time_ and arg_89_1.time_ <= var_92_10 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_12 = arg_89_1:FormatText(StoryNameCfg[471].name)

				arg_89_1.leftNameTxt_.text = var_92_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_13 = arg_89_1:GetWordFromCfg(319671021)
				local var_92_14 = arg_89_1:FormatText(var_92_13.content)

				arg_89_1.text_.text = var_92_14

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_15 = 15
				local var_92_16 = utf8.len(var_92_14)
				local var_92_17 = var_92_15 <= 0 and var_92_11 or var_92_11 * (var_92_16 / var_92_15)

				if var_92_17 > 0 and var_92_11 < var_92_17 then
					arg_89_1.talkMaxDuration = var_92_17

					if var_92_17 + var_92_10 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_17 + var_92_10
					end
				end

				arg_89_1.text_.text = var_92_14
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671021", "story_v_out_319671.awb") ~= 0 then
					local var_92_18 = manager.audio:GetVoiceLength("story_v_out_319671", "319671021", "story_v_out_319671.awb") / 1000

					if var_92_18 + var_92_10 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_18 + var_92_10
					end

					if var_92_13.prefab_name ~= "" and arg_89_1.actors_[var_92_13.prefab_name] ~= nil then
						local var_92_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_13.prefab_name].transform, "story_v_out_319671", "319671021", "story_v_out_319671.awb")

						arg_89_1:RecordAudio("319671021", var_92_19)
						arg_89_1:RecordAudio("319671021", var_92_19)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_319671", "319671021", "story_v_out_319671.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_319671", "319671021", "story_v_out_319671.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_20 = math.max(var_92_11, arg_89_1.talkMaxDuration)

			if var_92_10 <= arg_89_1.time_ and arg_89_1.time_ < var_92_10 + var_92_20 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_10) / var_92_20

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_10 + var_92_20 and arg_89_1.time_ < var_92_10 + var_92_20 + arg_92_0 then
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
			local var_96_0 = arg_93_1.actors_["1084ui_story"].transform
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 then
				arg_93_1.var_.moveOldPos1084ui_story = var_96_0.localPosition
			end

			local var_96_2 = 0.001

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_2 then
				local var_96_3 = (arg_93_1.time_ - var_96_1) / var_96_2
				local var_96_4 = Vector3.New(-0.7, -0.97, -6)

				var_96_0.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1084ui_story, var_96_4, var_96_3)

				local var_96_5 = manager.ui.mainCamera.transform.position - var_96_0.position

				var_96_0.forward = Vector3.New(var_96_5.x, var_96_5.y, var_96_5.z)

				local var_96_6 = var_96_0.localEulerAngles

				var_96_6.z = 0
				var_96_6.x = 0
				var_96_0.localEulerAngles = var_96_6
			end

			if arg_93_1.time_ >= var_96_1 + var_96_2 and arg_93_1.time_ < var_96_1 + var_96_2 + arg_96_0 then
				var_96_0.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_96_7 = manager.ui.mainCamera.transform.position - var_96_0.position

				var_96_0.forward = Vector3.New(var_96_7.x, var_96_7.y, var_96_7.z)

				local var_96_8 = var_96_0.localEulerAngles

				var_96_8.z = 0
				var_96_8.x = 0
				var_96_0.localEulerAngles = var_96_8
			end

			local var_96_9 = arg_93_1.actors_["1084ui_story"]
			local var_96_10 = 0

			if var_96_10 < arg_93_1.time_ and arg_93_1.time_ <= var_96_10 + arg_96_0 and not isNil(var_96_9) and arg_93_1.var_.characterEffect1084ui_story == nil then
				arg_93_1.var_.characterEffect1084ui_story = var_96_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_11 = 0.200000002980232

			if var_96_10 <= arg_93_1.time_ and arg_93_1.time_ < var_96_10 + var_96_11 and not isNil(var_96_9) then
				local var_96_12 = (arg_93_1.time_ - var_96_10) / var_96_11

				if arg_93_1.var_.characterEffect1084ui_story and not isNil(var_96_9) then
					arg_93_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= var_96_10 + var_96_11 and arg_93_1.time_ < var_96_10 + var_96_11 + arg_96_0 and not isNil(var_96_9) and arg_93_1.var_.characterEffect1084ui_story then
				arg_93_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_96_13 = 0

			if var_96_13 < arg_93_1.time_ and arg_93_1.time_ <= var_96_13 + arg_96_0 then
				arg_93_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			local var_96_14 = 0

			if var_96_14 < arg_93_1.time_ and arg_93_1.time_ <= var_96_14 + arg_96_0 then
				arg_93_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_96_15 = arg_93_1.actors_["1095ui_story"]
			local var_96_16 = 0

			if var_96_16 < arg_93_1.time_ and arg_93_1.time_ <= var_96_16 + arg_96_0 and not isNil(var_96_15) and arg_93_1.var_.characterEffect1095ui_story == nil then
				arg_93_1.var_.characterEffect1095ui_story = var_96_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_17 = 0.200000002980232

			if var_96_16 <= arg_93_1.time_ and arg_93_1.time_ < var_96_16 + var_96_17 and not isNil(var_96_15) then
				local var_96_18 = (arg_93_1.time_ - var_96_16) / var_96_17

				if arg_93_1.var_.characterEffect1095ui_story and not isNil(var_96_15) then
					local var_96_19 = Mathf.Lerp(0, 0.5, var_96_18)

					arg_93_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_93_1.var_.characterEffect1095ui_story.fillRatio = var_96_19
				end
			end

			if arg_93_1.time_ >= var_96_16 + var_96_17 and arg_93_1.time_ < var_96_16 + var_96_17 + arg_96_0 and not isNil(var_96_15) and arg_93_1.var_.characterEffect1095ui_story then
				local var_96_20 = 0.5

				arg_93_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_93_1.var_.characterEffect1095ui_story.fillRatio = var_96_20
			end

			local var_96_21 = 0
			local var_96_22 = 0.15

			if var_96_21 < arg_93_1.time_ and arg_93_1.time_ <= var_96_21 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_23 = arg_93_1:FormatText(StoryNameCfg[6].name)

				arg_93_1.leftNameTxt_.text = var_96_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_24 = arg_93_1:GetWordFromCfg(319671022)
				local var_96_25 = arg_93_1:FormatText(var_96_24.content)

				arg_93_1.text_.text = var_96_25

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_26 = 6
				local var_96_27 = utf8.len(var_96_25)
				local var_96_28 = var_96_26 <= 0 and var_96_22 or var_96_22 * (var_96_27 / var_96_26)

				if var_96_28 > 0 and var_96_22 < var_96_28 then
					arg_93_1.talkMaxDuration = var_96_28

					if var_96_28 + var_96_21 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_28 + var_96_21
					end
				end

				arg_93_1.text_.text = var_96_25
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671022", "story_v_out_319671.awb") ~= 0 then
					local var_96_29 = manager.audio:GetVoiceLength("story_v_out_319671", "319671022", "story_v_out_319671.awb") / 1000

					if var_96_29 + var_96_21 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_29 + var_96_21
					end

					if var_96_24.prefab_name ~= "" and arg_93_1.actors_[var_96_24.prefab_name] ~= nil then
						local var_96_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_24.prefab_name].transform, "story_v_out_319671", "319671022", "story_v_out_319671.awb")

						arg_93_1:RecordAudio("319671022", var_96_30)
						arg_93_1:RecordAudio("319671022", var_96_30)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_319671", "319671022", "story_v_out_319671.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_319671", "319671022", "story_v_out_319671.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_31 = math.max(var_96_22, arg_93_1.talkMaxDuration)

			if var_96_21 <= arg_93_1.time_ and arg_93_1.time_ < var_96_21 + var_96_31 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_21) / var_96_31

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_21 + var_96_31 and arg_93_1.time_ < var_96_21 + var_96_31 + arg_96_0 then
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
			local var_100_0 = arg_97_1.actors_["1084ui_story"]
			local var_100_1 = 0

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.characterEffect1084ui_story == nil then
				arg_97_1.var_.characterEffect1084ui_story = var_100_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_2 = 0.200000002980232

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_2 and not isNil(var_100_0) then
				local var_100_3 = (arg_97_1.time_ - var_100_1) / var_100_2

				if arg_97_1.var_.characterEffect1084ui_story and not isNil(var_100_0) then
					local var_100_4 = Mathf.Lerp(0, 0.5, var_100_3)

					arg_97_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_97_1.var_.characterEffect1084ui_story.fillRatio = var_100_4
				end
			end

			if arg_97_1.time_ >= var_100_1 + var_100_2 and arg_97_1.time_ < var_100_1 + var_100_2 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.characterEffect1084ui_story then
				local var_100_5 = 0.5

				arg_97_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_97_1.var_.characterEffect1084ui_story.fillRatio = var_100_5
			end

			local var_100_6 = arg_97_1.actors_["1095ui_story"].transform
			local var_100_7 = 0

			if var_100_7 < arg_97_1.time_ and arg_97_1.time_ <= var_100_7 + arg_100_0 then
				arg_97_1.var_.moveOldPos1095ui_story = var_100_6.localPosition
			end

			local var_100_8 = 0.001

			if var_100_7 <= arg_97_1.time_ and arg_97_1.time_ < var_100_7 + var_100_8 then
				local var_100_9 = (arg_97_1.time_ - var_100_7) / var_100_8
				local var_100_10 = Vector3.New(0, 100, 0)

				var_100_6.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos1095ui_story, var_100_10, var_100_9)

				local var_100_11 = manager.ui.mainCamera.transform.position - var_100_6.position

				var_100_6.forward = Vector3.New(var_100_11.x, var_100_11.y, var_100_11.z)

				local var_100_12 = var_100_6.localEulerAngles

				var_100_12.z = 0
				var_100_12.x = 0
				var_100_6.localEulerAngles = var_100_12
			end

			if arg_97_1.time_ >= var_100_7 + var_100_8 and arg_97_1.time_ < var_100_7 + var_100_8 + arg_100_0 then
				var_100_6.localPosition = Vector3.New(0, 100, 0)

				local var_100_13 = manager.ui.mainCamera.transform.position - var_100_6.position

				var_100_6.forward = Vector3.New(var_100_13.x, var_100_13.y, var_100_13.z)

				local var_100_14 = var_100_6.localEulerAngles

				var_100_14.z = 0
				var_100_14.x = 0
				var_100_6.localEulerAngles = var_100_14
			end

			local var_100_15 = arg_97_1.actors_["1084ui_story"].transform
			local var_100_16 = 0

			if var_100_16 < arg_97_1.time_ and arg_97_1.time_ <= var_100_16 + arg_100_0 then
				arg_97_1.var_.moveOldPos1084ui_story = var_100_15.localPosition
			end

			local var_100_17 = 0.001

			if var_100_16 <= arg_97_1.time_ and arg_97_1.time_ < var_100_16 + var_100_17 then
				local var_100_18 = (arg_97_1.time_ - var_100_16) / var_100_17
				local var_100_19 = Vector3.New(0, 100, 0)

				var_100_15.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos1084ui_story, var_100_19, var_100_18)

				local var_100_20 = manager.ui.mainCamera.transform.position - var_100_15.position

				var_100_15.forward = Vector3.New(var_100_20.x, var_100_20.y, var_100_20.z)

				local var_100_21 = var_100_15.localEulerAngles

				var_100_21.z = 0
				var_100_21.x = 0
				var_100_15.localEulerAngles = var_100_21
			end

			if arg_97_1.time_ >= var_100_16 + var_100_17 and arg_97_1.time_ < var_100_16 + var_100_17 + arg_100_0 then
				var_100_15.localPosition = Vector3.New(0, 100, 0)

				local var_100_22 = manager.ui.mainCamera.transform.position - var_100_15.position

				var_100_15.forward = Vector3.New(var_100_22.x, var_100_22.y, var_100_22.z)

				local var_100_23 = var_100_15.localEulerAngles

				var_100_23.z = 0
				var_100_23.x = 0
				var_100_15.localEulerAngles = var_100_23
			end

			local var_100_24 = 0
			local var_100_25 = 0.9

			if var_100_24 < arg_97_1.time_ and arg_97_1.time_ <= var_100_24 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, false)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_26 = arg_97_1:GetWordFromCfg(319671023)
				local var_100_27 = arg_97_1:FormatText(var_100_26.content)

				arg_97_1.text_.text = var_100_27

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_28 = 36
				local var_100_29 = utf8.len(var_100_27)
				local var_100_30 = var_100_28 <= 0 and var_100_25 or var_100_25 * (var_100_29 / var_100_28)

				if var_100_30 > 0 and var_100_25 < var_100_30 then
					arg_97_1.talkMaxDuration = var_100_30

					if var_100_30 + var_100_24 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_30 + var_100_24
					end
				end

				arg_97_1.text_.text = var_100_27
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_31 = math.max(var_100_25, arg_97_1.talkMaxDuration)

			if var_100_24 <= arg_97_1.time_ and arg_97_1.time_ < var_100_24 + var_100_31 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_24) / var_100_31

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_24 + var_100_31 and arg_97_1.time_ < var_100_24 + var_100_31 + arg_100_0 then
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
			local var_104_0 = arg_101_1.actors_["1084ui_story"]
			local var_104_1 = 0

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 and not isNil(var_104_0) and arg_101_1.var_.characterEffect1084ui_story == nil then
				arg_101_1.var_.characterEffect1084ui_story = var_104_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_2 = 0.200000002980232

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_2 and not isNil(var_104_0) then
				local var_104_3 = (arg_101_1.time_ - var_104_1) / var_104_2

				if arg_101_1.var_.characterEffect1084ui_story and not isNil(var_104_0) then
					local var_104_4 = Mathf.Lerp(0, 0.5, var_104_3)

					arg_101_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_101_1.var_.characterEffect1084ui_story.fillRatio = var_104_4
				end
			end

			if arg_101_1.time_ >= var_104_1 + var_104_2 and arg_101_1.time_ < var_104_1 + var_104_2 + arg_104_0 and not isNil(var_104_0) and arg_101_1.var_.characterEffect1084ui_story then
				local var_104_5 = 0.5

				arg_101_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_101_1.var_.characterEffect1084ui_story.fillRatio = var_104_5
			end

			local var_104_6 = arg_101_1.actors_["1095ui_story"]
			local var_104_7 = 0

			if var_104_7 < arg_101_1.time_ and arg_101_1.time_ <= var_104_7 + arg_104_0 and not isNil(var_104_6) and arg_101_1.var_.characterEffect1095ui_story == nil then
				arg_101_1.var_.characterEffect1095ui_story = var_104_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_8 = 0.200000002980232

			if var_104_7 <= arg_101_1.time_ and arg_101_1.time_ < var_104_7 + var_104_8 and not isNil(var_104_6) then
				local var_104_9 = (arg_101_1.time_ - var_104_7) / var_104_8

				if arg_101_1.var_.characterEffect1095ui_story and not isNil(var_104_6) then
					arg_101_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= var_104_7 + var_104_8 and arg_101_1.time_ < var_104_7 + var_104_8 + arg_104_0 and not isNil(var_104_6) and arg_101_1.var_.characterEffect1095ui_story then
				arg_101_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_104_10 = arg_101_1.actors_["1095ui_story"].transform
			local var_104_11 = 0

			if var_104_11 < arg_101_1.time_ and arg_101_1.time_ <= var_104_11 + arg_104_0 then
				arg_101_1.var_.moveOldPos1095ui_story = var_104_10.localPosition
			end

			local var_104_12 = 0.001

			if var_104_11 <= arg_101_1.time_ and arg_101_1.time_ < var_104_11 + var_104_12 then
				local var_104_13 = (arg_101_1.time_ - var_104_11) / var_104_12
				local var_104_14 = Vector3.New(0, -0.98, -6.1)

				var_104_10.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1095ui_story, var_104_14, var_104_13)

				local var_104_15 = manager.ui.mainCamera.transform.position - var_104_10.position

				var_104_10.forward = Vector3.New(var_104_15.x, var_104_15.y, var_104_15.z)

				local var_104_16 = var_104_10.localEulerAngles

				var_104_16.z = 0
				var_104_16.x = 0
				var_104_10.localEulerAngles = var_104_16
			end

			if arg_101_1.time_ >= var_104_11 + var_104_12 and arg_101_1.time_ < var_104_11 + var_104_12 + arg_104_0 then
				var_104_10.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_104_17 = manager.ui.mainCamera.transform.position - var_104_10.position

				var_104_10.forward = Vector3.New(var_104_17.x, var_104_17.y, var_104_17.z)

				local var_104_18 = var_104_10.localEulerAngles

				var_104_18.z = 0
				var_104_18.x = 0
				var_104_10.localEulerAngles = var_104_18
			end

			local var_104_19 = 0
			local var_104_20 = 0.6

			if var_104_19 < arg_101_1.time_ and arg_101_1.time_ <= var_104_19 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_21 = arg_101_1:FormatText(StoryNameCfg[471].name)

				arg_101_1.leftNameTxt_.text = var_104_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_22 = arg_101_1:GetWordFromCfg(319671024)
				local var_104_23 = arg_101_1:FormatText(var_104_22.content)

				arg_101_1.text_.text = var_104_23

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_24 = 24
				local var_104_25 = utf8.len(var_104_23)
				local var_104_26 = var_104_24 <= 0 and var_104_20 or var_104_20 * (var_104_25 / var_104_24)

				if var_104_26 > 0 and var_104_20 < var_104_26 then
					arg_101_1.talkMaxDuration = var_104_26

					if var_104_26 + var_104_19 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_26 + var_104_19
					end
				end

				arg_101_1.text_.text = var_104_23
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671024", "story_v_out_319671.awb") ~= 0 then
					local var_104_27 = manager.audio:GetVoiceLength("story_v_out_319671", "319671024", "story_v_out_319671.awb") / 1000

					if var_104_27 + var_104_19 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_27 + var_104_19
					end

					if var_104_22.prefab_name ~= "" and arg_101_1.actors_[var_104_22.prefab_name] ~= nil then
						local var_104_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_22.prefab_name].transform, "story_v_out_319671", "319671024", "story_v_out_319671.awb")

						arg_101_1:RecordAudio("319671024", var_104_28)
						arg_101_1:RecordAudio("319671024", var_104_28)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_319671", "319671024", "story_v_out_319671.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_319671", "319671024", "story_v_out_319671.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_29 = math.max(var_104_20, arg_101_1.talkMaxDuration)

			if var_104_19 <= arg_101_1.time_ and arg_101_1.time_ < var_104_19 + var_104_29 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_19) / var_104_29

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_19 + var_104_29 and arg_101_1.time_ < var_104_19 + var_104_29 + arg_104_0 then
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
			local var_108_0 = arg_105_1.actors_["1084ui_story"].transform
			local var_108_1 = 0

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 then
				arg_105_1.var_.moveOldPos1084ui_story = var_108_0.localPosition
			end

			local var_108_2 = 0.001

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_2 then
				local var_108_3 = (arg_105_1.time_ - var_108_1) / var_108_2
				local var_108_4 = Vector3.New(-0.7, -0.97, -6)

				var_108_0.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos1084ui_story, var_108_4, var_108_3)

				local var_108_5 = manager.ui.mainCamera.transform.position - var_108_0.position

				var_108_0.forward = Vector3.New(var_108_5.x, var_108_5.y, var_108_5.z)

				local var_108_6 = var_108_0.localEulerAngles

				var_108_6.z = 0
				var_108_6.x = 0
				var_108_0.localEulerAngles = var_108_6
			end

			if arg_105_1.time_ >= var_108_1 + var_108_2 and arg_105_1.time_ < var_108_1 + var_108_2 + arg_108_0 then
				var_108_0.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_108_7 = manager.ui.mainCamera.transform.position - var_108_0.position

				var_108_0.forward = Vector3.New(var_108_7.x, var_108_7.y, var_108_7.z)

				local var_108_8 = var_108_0.localEulerAngles

				var_108_8.z = 0
				var_108_8.x = 0
				var_108_0.localEulerAngles = var_108_8
			end

			local var_108_9 = arg_105_1.actors_["1084ui_story"]
			local var_108_10 = 0

			if var_108_10 < arg_105_1.time_ and arg_105_1.time_ <= var_108_10 + arg_108_0 and not isNil(var_108_9) and arg_105_1.var_.characterEffect1084ui_story == nil then
				arg_105_1.var_.characterEffect1084ui_story = var_108_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_11 = 0.200000002980232

			if var_108_10 <= arg_105_1.time_ and arg_105_1.time_ < var_108_10 + var_108_11 and not isNil(var_108_9) then
				local var_108_12 = (arg_105_1.time_ - var_108_10) / var_108_11

				if arg_105_1.var_.characterEffect1084ui_story and not isNil(var_108_9) then
					arg_105_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= var_108_10 + var_108_11 and arg_105_1.time_ < var_108_10 + var_108_11 + arg_108_0 and not isNil(var_108_9) and arg_105_1.var_.characterEffect1084ui_story then
				arg_105_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_108_13 = 0

			if var_108_13 < arg_105_1.time_ and arg_105_1.time_ <= var_108_13 + arg_108_0 then
				arg_105_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_2")
			end

			local var_108_14 = 0

			if var_108_14 < arg_105_1.time_ and arg_105_1.time_ <= var_108_14 + arg_108_0 then
				arg_105_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_108_15 = arg_105_1.actors_["1095ui_story"].transform
			local var_108_16 = 0

			if var_108_16 < arg_105_1.time_ and arg_105_1.time_ <= var_108_16 + arg_108_0 then
				arg_105_1.var_.moveOldPos1095ui_story = var_108_15.localPosition
			end

			local var_108_17 = 0.001

			if var_108_16 <= arg_105_1.time_ and arg_105_1.time_ < var_108_16 + var_108_17 then
				local var_108_18 = (arg_105_1.time_ - var_108_16) / var_108_17
				local var_108_19 = Vector3.New(0.7, -0.98, -6.1)

				var_108_15.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos1095ui_story, var_108_19, var_108_18)

				local var_108_20 = manager.ui.mainCamera.transform.position - var_108_15.position

				var_108_15.forward = Vector3.New(var_108_20.x, var_108_20.y, var_108_20.z)

				local var_108_21 = var_108_15.localEulerAngles

				var_108_21.z = 0
				var_108_21.x = 0
				var_108_15.localEulerAngles = var_108_21
			end

			if arg_105_1.time_ >= var_108_16 + var_108_17 and arg_105_1.time_ < var_108_16 + var_108_17 + arg_108_0 then
				var_108_15.localPosition = Vector3.New(0.7, -0.98, -6.1)

				local var_108_22 = manager.ui.mainCamera.transform.position - var_108_15.position

				var_108_15.forward = Vector3.New(var_108_22.x, var_108_22.y, var_108_22.z)

				local var_108_23 = var_108_15.localEulerAngles

				var_108_23.z = 0
				var_108_23.x = 0
				var_108_15.localEulerAngles = var_108_23
			end

			local var_108_24 = arg_105_1.actors_["1095ui_story"]
			local var_108_25 = 0

			if var_108_25 < arg_105_1.time_ and arg_105_1.time_ <= var_108_25 + arg_108_0 and not isNil(var_108_24) and arg_105_1.var_.characterEffect1095ui_story == nil then
				arg_105_1.var_.characterEffect1095ui_story = var_108_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_26 = 0.200000002980232

			if var_108_25 <= arg_105_1.time_ and arg_105_1.time_ < var_108_25 + var_108_26 and not isNil(var_108_24) then
				local var_108_27 = (arg_105_1.time_ - var_108_25) / var_108_26

				if arg_105_1.var_.characterEffect1095ui_story and not isNil(var_108_24) then
					local var_108_28 = Mathf.Lerp(0, 0.5, var_108_27)

					arg_105_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_105_1.var_.characterEffect1095ui_story.fillRatio = var_108_28
				end
			end

			if arg_105_1.time_ >= var_108_25 + var_108_26 and arg_105_1.time_ < var_108_25 + var_108_26 + arg_108_0 and not isNil(var_108_24) and arg_105_1.var_.characterEffect1095ui_story then
				local var_108_29 = 0.5

				arg_105_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_105_1.var_.characterEffect1095ui_story.fillRatio = var_108_29
			end

			local var_108_30 = 0
			local var_108_31 = 0.85

			if var_108_30 < arg_105_1.time_ and arg_105_1.time_ <= var_108_30 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_32 = arg_105_1:FormatText(StoryNameCfg[6].name)

				arg_105_1.leftNameTxt_.text = var_108_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_33 = arg_105_1:GetWordFromCfg(319671025)
				local var_108_34 = arg_105_1:FormatText(var_108_33.content)

				arg_105_1.text_.text = var_108_34

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_35 = 34
				local var_108_36 = utf8.len(var_108_34)
				local var_108_37 = var_108_35 <= 0 and var_108_31 or var_108_31 * (var_108_36 / var_108_35)

				if var_108_37 > 0 and var_108_31 < var_108_37 then
					arg_105_1.talkMaxDuration = var_108_37

					if var_108_37 + var_108_30 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_37 + var_108_30
					end
				end

				arg_105_1.text_.text = var_108_34
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671025", "story_v_out_319671.awb") ~= 0 then
					local var_108_38 = manager.audio:GetVoiceLength("story_v_out_319671", "319671025", "story_v_out_319671.awb") / 1000

					if var_108_38 + var_108_30 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_38 + var_108_30
					end

					if var_108_33.prefab_name ~= "" and arg_105_1.actors_[var_108_33.prefab_name] ~= nil then
						local var_108_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_33.prefab_name].transform, "story_v_out_319671", "319671025", "story_v_out_319671.awb")

						arg_105_1:RecordAudio("319671025", var_108_39)
						arg_105_1:RecordAudio("319671025", var_108_39)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_319671", "319671025", "story_v_out_319671.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_319671", "319671025", "story_v_out_319671.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_40 = math.max(var_108_31, arg_105_1.talkMaxDuration)

			if var_108_30 <= arg_105_1.time_ and arg_105_1.time_ < var_108_30 + var_108_40 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_30) / var_108_40

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_30 + var_108_40 and arg_105_1.time_ < var_108_30 + var_108_40 + arg_108_0 then
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
			local var_112_0 = arg_109_1.actors_["1095ui_story"].transform
			local var_112_1 = 0

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 then
				arg_109_1.var_.moveOldPos1095ui_story = var_112_0.localPosition
			end

			local var_112_2 = 0.001

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_2 then
				local var_112_3 = (arg_109_1.time_ - var_112_1) / var_112_2
				local var_112_4 = Vector3.New(0.7, -0.98, -6.1)

				var_112_0.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1095ui_story, var_112_4, var_112_3)

				local var_112_5 = manager.ui.mainCamera.transform.position - var_112_0.position

				var_112_0.forward = Vector3.New(var_112_5.x, var_112_5.y, var_112_5.z)

				local var_112_6 = var_112_0.localEulerAngles

				var_112_6.z = 0
				var_112_6.x = 0
				var_112_0.localEulerAngles = var_112_6
			end

			if arg_109_1.time_ >= var_112_1 + var_112_2 and arg_109_1.time_ < var_112_1 + var_112_2 + arg_112_0 then
				var_112_0.localPosition = Vector3.New(0.7, -0.98, -6.1)

				local var_112_7 = manager.ui.mainCamera.transform.position - var_112_0.position

				var_112_0.forward = Vector3.New(var_112_7.x, var_112_7.y, var_112_7.z)

				local var_112_8 = var_112_0.localEulerAngles

				var_112_8.z = 0
				var_112_8.x = 0
				var_112_0.localEulerAngles = var_112_8
			end

			local var_112_9 = arg_109_1.actors_["1095ui_story"]
			local var_112_10 = 0

			if var_112_10 < arg_109_1.time_ and arg_109_1.time_ <= var_112_10 + arg_112_0 and not isNil(var_112_9) and arg_109_1.var_.characterEffect1095ui_story == nil then
				arg_109_1.var_.characterEffect1095ui_story = var_112_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_11 = 0.200000002980232

			if var_112_10 <= arg_109_1.time_ and arg_109_1.time_ < var_112_10 + var_112_11 and not isNil(var_112_9) then
				local var_112_12 = (arg_109_1.time_ - var_112_10) / var_112_11

				if arg_109_1.var_.characterEffect1095ui_story and not isNil(var_112_9) then
					arg_109_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= var_112_10 + var_112_11 and arg_109_1.time_ < var_112_10 + var_112_11 + arg_112_0 and not isNil(var_112_9) and arg_109_1.var_.characterEffect1095ui_story then
				arg_109_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_112_13 = 0

			if var_112_13 < arg_109_1.time_ and arg_109_1.time_ <= var_112_13 + arg_112_0 then
				arg_109_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_1")
			end

			local var_112_14 = 0

			if var_112_14 < arg_109_1.time_ and arg_109_1.time_ <= var_112_14 + arg_112_0 then
				arg_109_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_112_15 = arg_109_1.actors_["1084ui_story"]
			local var_112_16 = 0

			if var_112_16 < arg_109_1.time_ and arg_109_1.time_ <= var_112_16 + arg_112_0 and not isNil(var_112_15) and arg_109_1.var_.characterEffect1084ui_story == nil then
				arg_109_1.var_.characterEffect1084ui_story = var_112_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_17 = 0.200000002980232

			if var_112_16 <= arg_109_1.time_ and arg_109_1.time_ < var_112_16 + var_112_17 and not isNil(var_112_15) then
				local var_112_18 = (arg_109_1.time_ - var_112_16) / var_112_17

				if arg_109_1.var_.characterEffect1084ui_story and not isNil(var_112_15) then
					local var_112_19 = Mathf.Lerp(0, 0.5, var_112_18)

					arg_109_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_109_1.var_.characterEffect1084ui_story.fillRatio = var_112_19
				end
			end

			if arg_109_1.time_ >= var_112_16 + var_112_17 and arg_109_1.time_ < var_112_16 + var_112_17 + arg_112_0 and not isNil(var_112_15) and arg_109_1.var_.characterEffect1084ui_story then
				local var_112_20 = 0.5

				arg_109_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_109_1.var_.characterEffect1084ui_story.fillRatio = var_112_20
			end

			local var_112_21 = 0
			local var_112_22 = 0.55

			if var_112_21 < arg_109_1.time_ and arg_109_1.time_ <= var_112_21 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_23 = arg_109_1:FormatText(StoryNameCfg[471].name)

				arg_109_1.leftNameTxt_.text = var_112_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_24 = arg_109_1:GetWordFromCfg(319671026)
				local var_112_25 = arg_109_1:FormatText(var_112_24.content)

				arg_109_1.text_.text = var_112_25

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_26 = 22
				local var_112_27 = utf8.len(var_112_25)
				local var_112_28 = var_112_26 <= 0 and var_112_22 or var_112_22 * (var_112_27 / var_112_26)

				if var_112_28 > 0 and var_112_22 < var_112_28 then
					arg_109_1.talkMaxDuration = var_112_28

					if var_112_28 + var_112_21 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_28 + var_112_21
					end
				end

				arg_109_1.text_.text = var_112_25
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671026", "story_v_out_319671.awb") ~= 0 then
					local var_112_29 = manager.audio:GetVoiceLength("story_v_out_319671", "319671026", "story_v_out_319671.awb") / 1000

					if var_112_29 + var_112_21 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_29 + var_112_21
					end

					if var_112_24.prefab_name ~= "" and arg_109_1.actors_[var_112_24.prefab_name] ~= nil then
						local var_112_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_24.prefab_name].transform, "story_v_out_319671", "319671026", "story_v_out_319671.awb")

						arg_109_1:RecordAudio("319671026", var_112_30)
						arg_109_1:RecordAudio("319671026", var_112_30)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_319671", "319671026", "story_v_out_319671.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_319671", "319671026", "story_v_out_319671.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_31 = math.max(var_112_22, arg_109_1.talkMaxDuration)

			if var_112_21 <= arg_109_1.time_ and arg_109_1.time_ < var_112_21 + var_112_31 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_21) / var_112_31

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_21 + var_112_31 and arg_109_1.time_ < var_112_21 + var_112_31 + arg_112_0 then
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
			local var_116_0 = arg_113_1.actors_["1095ui_story"]
			local var_116_1 = 0

			if var_116_1 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 and not isNil(var_116_0) and arg_113_1.var_.characterEffect1095ui_story == nil then
				arg_113_1.var_.characterEffect1095ui_story = var_116_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_2 = 0.200000002980232

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_2 and not isNil(var_116_0) then
				local var_116_3 = (arg_113_1.time_ - var_116_1) / var_116_2

				if arg_113_1.var_.characterEffect1095ui_story and not isNil(var_116_0) then
					local var_116_4 = Mathf.Lerp(0, 0.5, var_116_3)

					arg_113_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_113_1.var_.characterEffect1095ui_story.fillRatio = var_116_4
				end
			end

			if arg_113_1.time_ >= var_116_1 + var_116_2 and arg_113_1.time_ < var_116_1 + var_116_2 + arg_116_0 and not isNil(var_116_0) and arg_113_1.var_.characterEffect1095ui_story then
				local var_116_5 = 0.5

				arg_113_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_113_1.var_.characterEffect1095ui_story.fillRatio = var_116_5
			end

			local var_116_6 = arg_113_1.actors_["1084ui_story"]
			local var_116_7 = 0

			if var_116_7 < arg_113_1.time_ and arg_113_1.time_ <= var_116_7 + arg_116_0 and not isNil(var_116_6) and arg_113_1.var_.characterEffect1084ui_story == nil then
				arg_113_1.var_.characterEffect1084ui_story = var_116_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_8 = 0.200000002980232

			if var_116_7 <= arg_113_1.time_ and arg_113_1.time_ < var_116_7 + var_116_8 and not isNil(var_116_6) then
				local var_116_9 = (arg_113_1.time_ - var_116_7) / var_116_8

				if arg_113_1.var_.characterEffect1084ui_story and not isNil(var_116_6) then
					arg_113_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= var_116_7 + var_116_8 and arg_113_1.time_ < var_116_7 + var_116_8 + arg_116_0 and not isNil(var_116_6) and arg_113_1.var_.characterEffect1084ui_story then
				arg_113_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_116_10 = 0
			local var_116_11 = 0.125

			if var_116_10 < arg_113_1.time_ and arg_113_1.time_ <= var_116_10 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_12 = arg_113_1:FormatText(StoryNameCfg[6].name)

				arg_113_1.leftNameTxt_.text = var_116_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_13 = arg_113_1:GetWordFromCfg(319671027)
				local var_116_14 = arg_113_1:FormatText(var_116_13.content)

				arg_113_1.text_.text = var_116_14

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_15 = 5
				local var_116_16 = utf8.len(var_116_14)
				local var_116_17 = var_116_15 <= 0 and var_116_11 or var_116_11 * (var_116_16 / var_116_15)

				if var_116_17 > 0 and var_116_11 < var_116_17 then
					arg_113_1.talkMaxDuration = var_116_17

					if var_116_17 + var_116_10 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_17 + var_116_10
					end
				end

				arg_113_1.text_.text = var_116_14
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671027", "story_v_out_319671.awb") ~= 0 then
					local var_116_18 = manager.audio:GetVoiceLength("story_v_out_319671", "319671027", "story_v_out_319671.awb") / 1000

					if var_116_18 + var_116_10 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_18 + var_116_10
					end

					if var_116_13.prefab_name ~= "" and arg_113_1.actors_[var_116_13.prefab_name] ~= nil then
						local var_116_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_13.prefab_name].transform, "story_v_out_319671", "319671027", "story_v_out_319671.awb")

						arg_113_1:RecordAudio("319671027", var_116_19)
						arg_113_1:RecordAudio("319671027", var_116_19)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_319671", "319671027", "story_v_out_319671.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_319671", "319671027", "story_v_out_319671.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_20 = math.max(var_116_11, arg_113_1.talkMaxDuration)

			if var_116_10 <= arg_113_1.time_ and arg_113_1.time_ < var_116_10 + var_116_20 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_10) / var_116_20

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_10 + var_116_20 and arg_113_1.time_ < var_116_10 + var_116_20 + arg_116_0 then
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
			local var_120_0 = arg_117_1.actors_["1095ui_story"]
			local var_120_1 = 0

			if var_120_1 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 and not isNil(var_120_0) and arg_117_1.var_.characterEffect1095ui_story == nil then
				arg_117_1.var_.characterEffect1095ui_story = var_120_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_2 = 0.200000002980232

			if var_120_1 <= arg_117_1.time_ and arg_117_1.time_ < var_120_1 + var_120_2 and not isNil(var_120_0) then
				local var_120_3 = (arg_117_1.time_ - var_120_1) / var_120_2

				if arg_117_1.var_.characterEffect1095ui_story and not isNil(var_120_0) then
					arg_117_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_117_1.time_ >= var_120_1 + var_120_2 and arg_117_1.time_ < var_120_1 + var_120_2 + arg_120_0 and not isNil(var_120_0) and arg_117_1.var_.characterEffect1095ui_story then
				arg_117_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_120_4 = arg_117_1.actors_["1084ui_story"]
			local var_120_5 = 0

			if var_120_5 < arg_117_1.time_ and arg_117_1.time_ <= var_120_5 + arg_120_0 and not isNil(var_120_4) and arg_117_1.var_.characterEffect1084ui_story == nil then
				arg_117_1.var_.characterEffect1084ui_story = var_120_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_6 = 0.200000002980232

			if var_120_5 <= arg_117_1.time_ and arg_117_1.time_ < var_120_5 + var_120_6 and not isNil(var_120_4) then
				local var_120_7 = (arg_117_1.time_ - var_120_5) / var_120_6

				if arg_117_1.var_.characterEffect1084ui_story and not isNil(var_120_4) then
					local var_120_8 = Mathf.Lerp(0, 0.5, var_120_7)

					arg_117_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_117_1.var_.characterEffect1084ui_story.fillRatio = var_120_8
				end
			end

			if arg_117_1.time_ >= var_120_5 + var_120_6 and arg_117_1.time_ < var_120_5 + var_120_6 + arg_120_0 and not isNil(var_120_4) and arg_117_1.var_.characterEffect1084ui_story then
				local var_120_9 = 0.5

				arg_117_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_117_1.var_.characterEffect1084ui_story.fillRatio = var_120_9
			end

			local var_120_10 = 0

			if var_120_10 < arg_117_1.time_ and arg_117_1.time_ <= var_120_10 + arg_120_0 then
				arg_117_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_120_11 = 0
			local var_120_12 = 0.25

			if var_120_11 < arg_117_1.time_ and arg_117_1.time_ <= var_120_11 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_13 = arg_117_1:FormatText(StoryNameCfg[471].name)

				arg_117_1.leftNameTxt_.text = var_120_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_14 = arg_117_1:GetWordFromCfg(319671028)
				local var_120_15 = arg_117_1:FormatText(var_120_14.content)

				arg_117_1.text_.text = var_120_15

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_16 = 10
				local var_120_17 = utf8.len(var_120_15)
				local var_120_18 = var_120_16 <= 0 and var_120_12 or var_120_12 * (var_120_17 / var_120_16)

				if var_120_18 > 0 and var_120_12 < var_120_18 then
					arg_117_1.talkMaxDuration = var_120_18

					if var_120_18 + var_120_11 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_18 + var_120_11
					end
				end

				arg_117_1.text_.text = var_120_15
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671028", "story_v_out_319671.awb") ~= 0 then
					local var_120_19 = manager.audio:GetVoiceLength("story_v_out_319671", "319671028", "story_v_out_319671.awb") / 1000

					if var_120_19 + var_120_11 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_19 + var_120_11
					end

					if var_120_14.prefab_name ~= "" and arg_117_1.actors_[var_120_14.prefab_name] ~= nil then
						local var_120_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_14.prefab_name].transform, "story_v_out_319671", "319671028", "story_v_out_319671.awb")

						arg_117_1:RecordAudio("319671028", var_120_20)
						arg_117_1:RecordAudio("319671028", var_120_20)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_319671", "319671028", "story_v_out_319671.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_319671", "319671028", "story_v_out_319671.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_21 = math.max(var_120_12, arg_117_1.talkMaxDuration)

			if var_120_11 <= arg_117_1.time_ and arg_117_1.time_ < var_120_11 + var_120_21 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_11) / var_120_21

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_11 + var_120_21 and arg_117_1.time_ < var_120_11 + var_120_21 + arg_120_0 then
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
			local var_124_0 = 0

			if var_124_0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_0 + arg_124_0 then
				arg_121_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_2")
			end

			local var_124_1 = 0
			local var_124_2 = 0.075

			if var_124_1 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_3 = arg_121_1:FormatText(StoryNameCfg[471].name)

				arg_121_1.leftNameTxt_.text = var_124_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_4 = arg_121_1:GetWordFromCfg(319671029)
				local var_124_5 = arg_121_1:FormatText(var_124_4.content)

				arg_121_1.text_.text = var_124_5

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_6 = 3
				local var_124_7 = utf8.len(var_124_5)
				local var_124_8 = var_124_6 <= 0 and var_124_2 or var_124_2 * (var_124_7 / var_124_6)

				if var_124_8 > 0 and var_124_2 < var_124_8 then
					arg_121_1.talkMaxDuration = var_124_8

					if var_124_8 + var_124_1 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_8 + var_124_1
					end
				end

				arg_121_1.text_.text = var_124_5
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671029", "story_v_out_319671.awb") ~= 0 then
					local var_124_9 = manager.audio:GetVoiceLength("story_v_out_319671", "319671029", "story_v_out_319671.awb") / 1000

					if var_124_9 + var_124_1 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_9 + var_124_1
					end

					if var_124_4.prefab_name ~= "" and arg_121_1.actors_[var_124_4.prefab_name] ~= nil then
						local var_124_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_4.prefab_name].transform, "story_v_out_319671", "319671029", "story_v_out_319671.awb")

						arg_121_1:RecordAudio("319671029", var_124_10)
						arg_121_1:RecordAudio("319671029", var_124_10)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_319671", "319671029", "story_v_out_319671.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_319671", "319671029", "story_v_out_319671.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_11 = math.max(var_124_2, arg_121_1.talkMaxDuration)

			if var_124_1 <= arg_121_1.time_ and arg_121_1.time_ < var_124_1 + var_124_11 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_1) / var_124_11

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_1 + var_124_11 and arg_121_1.time_ < var_124_1 + var_124_11 + arg_124_0 then
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
			local var_128_0 = "D11"

			if arg_125_1.bgs_[var_128_0] == nil then
				local var_128_1 = Object.Instantiate(arg_125_1.paintGo_)

				var_128_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_128_0)
				var_128_1.name = var_128_0
				var_128_1.transform.parent = arg_125_1.stage_.transform
				var_128_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_125_1.bgs_[var_128_0] = var_128_1
			end

			local var_128_2 = 2

			if var_128_2 < arg_125_1.time_ and arg_125_1.time_ <= var_128_2 + arg_128_0 then
				local var_128_3 = manager.ui.mainCamera.transform.localPosition
				local var_128_4 = Vector3.New(0, 0, 10) + Vector3.New(var_128_3.x, var_128_3.y, 0)
				local var_128_5 = arg_125_1.bgs_.D11

				var_128_5.transform.localPosition = var_128_4
				var_128_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_128_6 = var_128_5:GetComponent("SpriteRenderer")

				if var_128_6 and var_128_6.sprite then
					local var_128_7 = (var_128_5.transform.localPosition - var_128_3).z
					local var_128_8 = manager.ui.mainCameraCom_
					local var_128_9 = 2 * var_128_7 * Mathf.Tan(var_128_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_128_10 = var_128_9 * var_128_8.aspect
					local var_128_11 = var_128_6.sprite.bounds.size.x
					local var_128_12 = var_128_6.sprite.bounds.size.y
					local var_128_13 = var_128_10 / var_128_11
					local var_128_14 = var_128_9 / var_128_12
					local var_128_15 = var_128_14 < var_128_13 and var_128_13 or var_128_14

					var_128_5.transform.localScale = Vector3.New(var_128_15, var_128_15, 0)
				end

				for iter_128_0, iter_128_1 in pairs(arg_125_1.bgs_) do
					if iter_128_0 ~= "D11" then
						iter_128_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_128_16 = 0

			if var_128_16 < arg_125_1.time_ and arg_125_1.time_ <= var_128_16 + arg_128_0 then
				arg_125_1.allBtn_.enabled = false
			end

			local var_128_17 = 0.3

			if arg_125_1.time_ >= var_128_16 + var_128_17 and arg_125_1.time_ < var_128_16 + var_128_17 + arg_128_0 then
				arg_125_1.allBtn_.enabled = true
			end

			local var_128_18 = 0

			if var_128_18 < arg_125_1.time_ and arg_125_1.time_ <= var_128_18 + arg_128_0 then
				arg_125_1.mask_.enabled = true
				arg_125_1.mask_.raycastTarget = true

				arg_125_1:SetGaussion(false)
			end

			local var_128_19 = 2

			if var_128_18 <= arg_125_1.time_ and arg_125_1.time_ < var_128_18 + var_128_19 then
				local var_128_20 = (arg_125_1.time_ - var_128_18) / var_128_19
				local var_128_21 = Color.New(0, 0, 0)

				var_128_21.a = Mathf.Lerp(0, 1, var_128_20)
				arg_125_1.mask_.color = var_128_21
			end

			if arg_125_1.time_ >= var_128_18 + var_128_19 and arg_125_1.time_ < var_128_18 + var_128_19 + arg_128_0 then
				local var_128_22 = Color.New(0, 0, 0)

				var_128_22.a = 1
				arg_125_1.mask_.color = var_128_22
			end

			local var_128_23 = 2

			if var_128_23 < arg_125_1.time_ and arg_125_1.time_ <= var_128_23 + arg_128_0 then
				arg_125_1.mask_.enabled = true
				arg_125_1.mask_.raycastTarget = true

				arg_125_1:SetGaussion(false)
			end

			local var_128_24 = 2

			if var_128_23 <= arg_125_1.time_ and arg_125_1.time_ < var_128_23 + var_128_24 then
				local var_128_25 = (arg_125_1.time_ - var_128_23) / var_128_24
				local var_128_26 = Color.New(0, 0, 0)

				var_128_26.a = Mathf.Lerp(1, 0, var_128_25)
				arg_125_1.mask_.color = var_128_26
			end

			if arg_125_1.time_ >= var_128_23 + var_128_24 and arg_125_1.time_ < var_128_23 + var_128_24 + arg_128_0 then
				local var_128_27 = Color.New(0, 0, 0)
				local var_128_28 = 0

				arg_125_1.mask_.enabled = false
				var_128_27.a = var_128_28
				arg_125_1.mask_.color = var_128_27
			end

			local var_128_29 = arg_125_1.actors_["1084ui_story"].transform
			local var_128_30 = 2

			if var_128_30 < arg_125_1.time_ and arg_125_1.time_ <= var_128_30 + arg_128_0 then
				arg_125_1.var_.moveOldPos1084ui_story = var_128_29.localPosition
			end

			local var_128_31 = 0.001

			if var_128_30 <= arg_125_1.time_ and arg_125_1.time_ < var_128_30 + var_128_31 then
				local var_128_32 = (arg_125_1.time_ - var_128_30) / var_128_31
				local var_128_33 = Vector3.New(0, 100, 0)

				var_128_29.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1084ui_story, var_128_33, var_128_32)

				local var_128_34 = manager.ui.mainCamera.transform.position - var_128_29.position

				var_128_29.forward = Vector3.New(var_128_34.x, var_128_34.y, var_128_34.z)

				local var_128_35 = var_128_29.localEulerAngles

				var_128_35.z = 0
				var_128_35.x = 0
				var_128_29.localEulerAngles = var_128_35
			end

			if arg_125_1.time_ >= var_128_30 + var_128_31 and arg_125_1.time_ < var_128_30 + var_128_31 + arg_128_0 then
				var_128_29.localPosition = Vector3.New(0, 100, 0)

				local var_128_36 = manager.ui.mainCamera.transform.position - var_128_29.position

				var_128_29.forward = Vector3.New(var_128_36.x, var_128_36.y, var_128_36.z)

				local var_128_37 = var_128_29.localEulerAngles

				var_128_37.z = 0
				var_128_37.x = 0
				var_128_29.localEulerAngles = var_128_37
			end

			local var_128_38 = arg_125_1.actors_["1095ui_story"].transform
			local var_128_39 = 2

			if var_128_39 < arg_125_1.time_ and arg_125_1.time_ <= var_128_39 + arg_128_0 then
				arg_125_1.var_.moveOldPos1095ui_story = var_128_38.localPosition
			end

			local var_128_40 = 0.001

			if var_128_39 <= arg_125_1.time_ and arg_125_1.time_ < var_128_39 + var_128_40 then
				local var_128_41 = (arg_125_1.time_ - var_128_39) / var_128_40
				local var_128_42 = Vector3.New(0, 100, 0)

				var_128_38.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1095ui_story, var_128_42, var_128_41)

				local var_128_43 = manager.ui.mainCamera.transform.position - var_128_38.position

				var_128_38.forward = Vector3.New(var_128_43.x, var_128_43.y, var_128_43.z)

				local var_128_44 = var_128_38.localEulerAngles

				var_128_44.z = 0
				var_128_44.x = 0
				var_128_38.localEulerAngles = var_128_44
			end

			if arg_125_1.time_ >= var_128_39 + var_128_40 and arg_125_1.time_ < var_128_39 + var_128_40 + arg_128_0 then
				var_128_38.localPosition = Vector3.New(0, 100, 0)

				local var_128_45 = manager.ui.mainCamera.transform.position - var_128_38.position

				var_128_38.forward = Vector3.New(var_128_45.x, var_128_45.y, var_128_45.z)

				local var_128_46 = var_128_38.localEulerAngles

				var_128_46.z = 0
				var_128_46.x = 0
				var_128_38.localEulerAngles = var_128_46
			end

			if arg_125_1.frameCnt_ <= 1 then
				arg_125_1.dialog_:SetActive(false)
			end

			local var_128_47 = 3.86666666666667
			local var_128_48 = 0.95

			if var_128_47 < arg_125_1.time_ and arg_125_1.time_ <= var_128_47 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0

				arg_125_1.dialog_:SetActive(true)

				arg_125_1.dialogCg_.alpha = 0

				local var_128_49 = LeanTween.value(arg_125_1.dialog_, 0, 1, 0.3)

				var_128_49:setOnUpdate(LuaHelper.FloatAction(function(arg_129_0)
					arg_125_1.dialogCg_.alpha = arg_129_0
				end))
				var_128_49:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_125_1.dialog_)
					var_128_49:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_125_1.duration_ = arg_125_1.duration_ + 0.3

				SetActive(arg_125_1.leftNameGo_, false)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_50 = arg_125_1:GetWordFromCfg(319671030)
				local var_128_51 = arg_125_1:FormatText(var_128_50.content)

				arg_125_1.text_.text = var_128_51

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_52 = 38
				local var_128_53 = utf8.len(var_128_51)
				local var_128_54 = var_128_52 <= 0 and var_128_48 or var_128_48 * (var_128_53 / var_128_52)

				if var_128_54 > 0 and var_128_48 < var_128_54 then
					arg_125_1.talkMaxDuration = var_128_54
					var_128_47 = var_128_47 + 0.3

					if var_128_54 + var_128_47 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_54 + var_128_47
					end
				end

				arg_125_1.text_.text = var_128_51
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_55 = var_128_47 + 0.3
			local var_128_56 = math.max(var_128_48, arg_125_1.talkMaxDuration)

			if var_128_55 <= arg_125_1.time_ and arg_125_1.time_ < var_128_55 + var_128_56 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_55) / var_128_56

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_55 + var_128_56 and arg_125_1.time_ < var_128_55 + var_128_56 + arg_128_0 then
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
			local var_134_0 = 0
			local var_134_1 = 0.95

			if var_134_0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_0 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, false)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_2 = arg_131_1:GetWordFromCfg(319671031)
				local var_134_3 = arg_131_1:FormatText(var_134_2.content)

				arg_131_1.text_.text = var_134_3

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_4 = 38
				local var_134_5 = utf8.len(var_134_3)
				local var_134_6 = var_134_4 <= 0 and var_134_1 or var_134_1 * (var_134_5 / var_134_4)

				if var_134_6 > 0 and var_134_1 < var_134_6 then
					arg_131_1.talkMaxDuration = var_134_6

					if var_134_6 + var_134_0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_6 + var_134_0
					end
				end

				arg_131_1.text_.text = var_134_3
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)
				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_7 = math.max(var_134_1, arg_131_1.talkMaxDuration)

			if var_134_0 <= arg_131_1.time_ and arg_131_1.time_ < var_134_0 + var_134_7 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_0) / var_134_7

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_0 + var_134_7 and arg_131_1.time_ < var_134_0 + var_134_7 + arg_134_0 then
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
			local var_138_0 = 0
			local var_138_1 = 0.5

			if var_138_0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_0 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				local var_138_2 = arg_135_1:FormatText(StoryNameCfg[660].name)

				arg_135_1.leftNameTxt_.text = var_138_2

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

				local var_138_3 = arg_135_1:GetWordFromCfg(319671032)
				local var_138_4 = arg_135_1:FormatText(var_138_3.content)

				arg_135_1.text_.text = var_138_4

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_5 = 20
				local var_138_6 = utf8.len(var_138_4)
				local var_138_7 = var_138_5 <= 0 and var_138_1 or var_138_1 * (var_138_6 / var_138_5)

				if var_138_7 > 0 and var_138_1 < var_138_7 then
					arg_135_1.talkMaxDuration = var_138_7

					if var_138_7 + var_138_0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_7 + var_138_0
					end
				end

				arg_135_1.text_.text = var_138_4
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671032", "story_v_out_319671.awb") ~= 0 then
					local var_138_8 = manager.audio:GetVoiceLength("story_v_out_319671", "319671032", "story_v_out_319671.awb") / 1000

					if var_138_8 + var_138_0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_8 + var_138_0
					end

					if var_138_3.prefab_name ~= "" and arg_135_1.actors_[var_138_3.prefab_name] ~= nil then
						local var_138_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_3.prefab_name].transform, "story_v_out_319671", "319671032", "story_v_out_319671.awb")

						arg_135_1:RecordAudio("319671032", var_138_9)
						arg_135_1:RecordAudio("319671032", var_138_9)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_319671", "319671032", "story_v_out_319671.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_319671", "319671032", "story_v_out_319671.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_10 = math.max(var_138_1, arg_135_1.talkMaxDuration)

			if var_138_0 <= arg_135_1.time_ and arg_135_1.time_ < var_138_0 + var_138_10 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_0) / var_138_10

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_0 + var_138_10 and arg_135_1.time_ < var_138_0 + var_138_10 + arg_138_0 then
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
			local var_142_0 = arg_139_1.actors_["1095ui_story"].transform
			local var_142_1 = 0

			if var_142_1 < arg_139_1.time_ and arg_139_1.time_ <= var_142_1 + arg_142_0 then
				arg_139_1.var_.moveOldPos1095ui_story = var_142_0.localPosition
			end

			local var_142_2 = 0.001

			if var_142_1 <= arg_139_1.time_ and arg_139_1.time_ < var_142_1 + var_142_2 then
				local var_142_3 = (arg_139_1.time_ - var_142_1) / var_142_2
				local var_142_4 = Vector3.New(0, -0.98, -6.1)

				var_142_0.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos1095ui_story, var_142_4, var_142_3)

				local var_142_5 = manager.ui.mainCamera.transform.position - var_142_0.position

				var_142_0.forward = Vector3.New(var_142_5.x, var_142_5.y, var_142_5.z)

				local var_142_6 = var_142_0.localEulerAngles

				var_142_6.z = 0
				var_142_6.x = 0
				var_142_0.localEulerAngles = var_142_6
			end

			if arg_139_1.time_ >= var_142_1 + var_142_2 and arg_139_1.time_ < var_142_1 + var_142_2 + arg_142_0 then
				var_142_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_142_7 = manager.ui.mainCamera.transform.position - var_142_0.position

				var_142_0.forward = Vector3.New(var_142_7.x, var_142_7.y, var_142_7.z)

				local var_142_8 = var_142_0.localEulerAngles

				var_142_8.z = 0
				var_142_8.x = 0
				var_142_0.localEulerAngles = var_142_8
			end

			local var_142_9 = arg_139_1.actors_["1095ui_story"]
			local var_142_10 = 0

			if var_142_10 < arg_139_1.time_ and arg_139_1.time_ <= var_142_10 + arg_142_0 and not isNil(var_142_9) and arg_139_1.var_.characterEffect1095ui_story == nil then
				arg_139_1.var_.characterEffect1095ui_story = var_142_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_11 = 0.200000002980232

			if var_142_10 <= arg_139_1.time_ and arg_139_1.time_ < var_142_10 + var_142_11 and not isNil(var_142_9) then
				local var_142_12 = (arg_139_1.time_ - var_142_10) / var_142_11

				if arg_139_1.var_.characterEffect1095ui_story and not isNil(var_142_9) then
					arg_139_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_139_1.time_ >= var_142_10 + var_142_11 and arg_139_1.time_ < var_142_10 + var_142_11 + arg_142_0 and not isNil(var_142_9) and arg_139_1.var_.characterEffect1095ui_story then
				arg_139_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_142_13 = 0

			if var_142_13 < arg_139_1.time_ and arg_139_1.time_ <= var_142_13 + arg_142_0 then
				arg_139_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_142_14 = 0
			local var_142_15 = 0.15

			if var_142_14 < arg_139_1.time_ and arg_139_1.time_ <= var_142_14 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				local var_142_16 = arg_139_1:FormatText(StoryNameCfg[471].name)

				arg_139_1.leftNameTxt_.text = var_142_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_17 = arg_139_1:GetWordFromCfg(319671033)
				local var_142_18 = arg_139_1:FormatText(var_142_17.content)

				arg_139_1.text_.text = var_142_18

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_19 = 6
				local var_142_20 = utf8.len(var_142_18)
				local var_142_21 = var_142_19 <= 0 and var_142_15 or var_142_15 * (var_142_20 / var_142_19)

				if var_142_21 > 0 and var_142_15 < var_142_21 then
					arg_139_1.talkMaxDuration = var_142_21

					if var_142_21 + var_142_14 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_21 + var_142_14
					end
				end

				arg_139_1.text_.text = var_142_18
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671033", "story_v_out_319671.awb") ~= 0 then
					local var_142_22 = manager.audio:GetVoiceLength("story_v_out_319671", "319671033", "story_v_out_319671.awb") / 1000

					if var_142_22 + var_142_14 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_22 + var_142_14
					end

					if var_142_17.prefab_name ~= "" and arg_139_1.actors_[var_142_17.prefab_name] ~= nil then
						local var_142_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_17.prefab_name].transform, "story_v_out_319671", "319671033", "story_v_out_319671.awb")

						arg_139_1:RecordAudio("319671033", var_142_23)
						arg_139_1:RecordAudio("319671033", var_142_23)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_319671", "319671033", "story_v_out_319671.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_319671", "319671033", "story_v_out_319671.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_24 = math.max(var_142_15, arg_139_1.talkMaxDuration)

			if var_142_14 <= arg_139_1.time_ and arg_139_1.time_ < var_142_14 + var_142_24 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_14) / var_142_24

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_14 + var_142_24 and arg_139_1.time_ < var_142_14 + var_142_24 + arg_142_0 then
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
			local var_146_0 = arg_143_1.actors_["1095ui_story"]
			local var_146_1 = 0

			if var_146_1 < arg_143_1.time_ and arg_143_1.time_ <= var_146_1 + arg_146_0 and not isNil(var_146_0) and arg_143_1.var_.characterEffect1095ui_story == nil then
				arg_143_1.var_.characterEffect1095ui_story = var_146_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_2 = 0.200000002980232

			if var_146_1 <= arg_143_1.time_ and arg_143_1.time_ < var_146_1 + var_146_2 and not isNil(var_146_0) then
				local var_146_3 = (arg_143_1.time_ - var_146_1) / var_146_2

				if arg_143_1.var_.characterEffect1095ui_story and not isNil(var_146_0) then
					local var_146_4 = Mathf.Lerp(0, 0.5, var_146_3)

					arg_143_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_143_1.var_.characterEffect1095ui_story.fillRatio = var_146_4
				end
			end

			if arg_143_1.time_ >= var_146_1 + var_146_2 and arg_143_1.time_ < var_146_1 + var_146_2 + arg_146_0 and not isNil(var_146_0) and arg_143_1.var_.characterEffect1095ui_story then
				local var_146_5 = 0.5

				arg_143_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_143_1.var_.characterEffect1095ui_story.fillRatio = var_146_5
			end

			local var_146_6 = arg_143_1.actors_["1095ui_story"].transform
			local var_146_7 = 0

			if var_146_7 < arg_143_1.time_ and arg_143_1.time_ <= var_146_7 + arg_146_0 then
				arg_143_1.var_.moveOldPos1095ui_story = var_146_6.localPosition
			end

			local var_146_8 = 0.001

			if var_146_7 <= arg_143_1.time_ and arg_143_1.time_ < var_146_7 + var_146_8 then
				local var_146_9 = (arg_143_1.time_ - var_146_7) / var_146_8
				local var_146_10 = Vector3.New(0, 100, 0)

				var_146_6.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos1095ui_story, var_146_10, var_146_9)

				local var_146_11 = manager.ui.mainCamera.transform.position - var_146_6.position

				var_146_6.forward = Vector3.New(var_146_11.x, var_146_11.y, var_146_11.z)

				local var_146_12 = var_146_6.localEulerAngles

				var_146_12.z = 0
				var_146_12.x = 0
				var_146_6.localEulerAngles = var_146_12
			end

			if arg_143_1.time_ >= var_146_7 + var_146_8 and arg_143_1.time_ < var_146_7 + var_146_8 + arg_146_0 then
				var_146_6.localPosition = Vector3.New(0, 100, 0)

				local var_146_13 = manager.ui.mainCamera.transform.position - var_146_6.position

				var_146_6.forward = Vector3.New(var_146_13.x, var_146_13.y, var_146_13.z)

				local var_146_14 = var_146_6.localEulerAngles

				var_146_14.z = 0
				var_146_14.x = 0
				var_146_6.localEulerAngles = var_146_14
			end

			local var_146_15 = 0
			local var_146_16 = 0.775

			if var_146_15 < arg_143_1.time_ and arg_143_1.time_ <= var_146_15 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, false)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_17 = arg_143_1:GetWordFromCfg(319671034)
				local var_146_18 = arg_143_1:FormatText(var_146_17.content)

				arg_143_1.text_.text = var_146_18

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_19 = 31
				local var_146_20 = utf8.len(var_146_18)
				local var_146_21 = var_146_19 <= 0 and var_146_16 or var_146_16 * (var_146_20 / var_146_19)

				if var_146_21 > 0 and var_146_16 < var_146_21 then
					arg_143_1.talkMaxDuration = var_146_21

					if var_146_21 + var_146_15 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_21 + var_146_15
					end
				end

				arg_143_1.text_.text = var_146_18
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)
				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_22 = math.max(var_146_16, arg_143_1.talkMaxDuration)

			if var_146_15 <= arg_143_1.time_ and arg_143_1.time_ < var_146_15 + var_146_22 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_15) / var_146_22

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_15 + var_146_22 and arg_143_1.time_ < var_146_15 + var_146_22 + arg_146_0 then
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
			local var_150_0 = 0
			local var_150_1 = 0.875

			if var_150_0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_0 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, false)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_2 = arg_147_1:GetWordFromCfg(319671035)
				local var_150_3 = arg_147_1:FormatText(var_150_2.content)

				arg_147_1.text_.text = var_150_3

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_4 = 35
				local var_150_5 = utf8.len(var_150_3)
				local var_150_6 = var_150_4 <= 0 and var_150_1 or var_150_1 * (var_150_5 / var_150_4)

				if var_150_6 > 0 and var_150_1 < var_150_6 then
					arg_147_1.talkMaxDuration = var_150_6

					if var_150_6 + var_150_0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_6 + var_150_0
					end
				end

				arg_147_1.text_.text = var_150_3
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)
				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_7 = math.max(var_150_1, arg_147_1.talkMaxDuration)

			if var_150_0 <= arg_147_1.time_ and arg_147_1.time_ < var_150_0 + var_150_7 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_0) / var_150_7

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_0 + var_150_7 and arg_147_1.time_ < var_150_0 + var_150_7 + arg_150_0 then
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
			local var_154_0 = "ST69"

			if arg_151_1.bgs_[var_154_0] == nil then
				local var_154_1 = Object.Instantiate(arg_151_1.paintGo_)

				var_154_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_154_0)
				var_154_1.name = var_154_0
				var_154_1.transform.parent = arg_151_1.stage_.transform
				var_154_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_151_1.bgs_[var_154_0] = var_154_1
			end

			local var_154_2 = 1

			if var_154_2 < arg_151_1.time_ and arg_151_1.time_ <= var_154_2 + arg_154_0 then
				local var_154_3 = manager.ui.mainCamera.transform.localPosition
				local var_154_4 = Vector3.New(0, 0, 10) + Vector3.New(var_154_3.x, var_154_3.y, 0)
				local var_154_5 = arg_151_1.bgs_.ST69

				var_154_5.transform.localPosition = var_154_4
				var_154_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_154_6 = var_154_5:GetComponent("SpriteRenderer")

				if var_154_6 and var_154_6.sprite then
					local var_154_7 = (var_154_5.transform.localPosition - var_154_3).z
					local var_154_8 = manager.ui.mainCameraCom_
					local var_154_9 = 2 * var_154_7 * Mathf.Tan(var_154_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_154_10 = var_154_9 * var_154_8.aspect
					local var_154_11 = var_154_6.sprite.bounds.size.x
					local var_154_12 = var_154_6.sprite.bounds.size.y
					local var_154_13 = var_154_10 / var_154_11
					local var_154_14 = var_154_9 / var_154_12
					local var_154_15 = var_154_14 < var_154_13 and var_154_13 or var_154_14

					var_154_5.transform.localScale = Vector3.New(var_154_15, var_154_15, 0)
				end

				for iter_154_0, iter_154_1 in pairs(arg_151_1.bgs_) do
					if iter_154_0 ~= "ST69" then
						iter_154_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_154_16 = 0

			if var_154_16 < arg_151_1.time_ and arg_151_1.time_ <= var_154_16 + arg_154_0 then
				arg_151_1.allBtn_.enabled = false
			end

			local var_154_17 = 0.3

			if arg_151_1.time_ >= var_154_16 + var_154_17 and arg_151_1.time_ < var_154_16 + var_154_17 + arg_154_0 then
				arg_151_1.allBtn_.enabled = true
			end

			local var_154_18 = 0

			if var_154_18 < arg_151_1.time_ and arg_151_1.time_ <= var_154_18 + arg_154_0 then
				arg_151_1.mask_.enabled = true
				arg_151_1.mask_.raycastTarget = true

				arg_151_1:SetGaussion(false)
			end

			local var_154_19 = 1

			if var_154_18 <= arg_151_1.time_ and arg_151_1.time_ < var_154_18 + var_154_19 then
				local var_154_20 = (arg_151_1.time_ - var_154_18) / var_154_19
				local var_154_21 = Color.New(0, 0, 0)

				var_154_21.a = Mathf.Lerp(0, 1, var_154_20)
				arg_151_1.mask_.color = var_154_21
			end

			if arg_151_1.time_ >= var_154_18 + var_154_19 and arg_151_1.time_ < var_154_18 + var_154_19 + arg_154_0 then
				local var_154_22 = Color.New(0, 0, 0)

				var_154_22.a = 1
				arg_151_1.mask_.color = var_154_22
			end

			local var_154_23 = 1

			if var_154_23 < arg_151_1.time_ and arg_151_1.time_ <= var_154_23 + arg_154_0 then
				arg_151_1.mask_.enabled = true
				arg_151_1.mask_.raycastTarget = true

				arg_151_1:SetGaussion(false)
			end

			local var_154_24 = 2

			if var_154_23 <= arg_151_1.time_ and arg_151_1.time_ < var_154_23 + var_154_24 then
				local var_154_25 = (arg_151_1.time_ - var_154_23) / var_154_24
				local var_154_26 = Color.New(0, 0, 0)

				var_154_26.a = Mathf.Lerp(1, 0, var_154_25)
				arg_151_1.mask_.color = var_154_26
			end

			if arg_151_1.time_ >= var_154_23 + var_154_24 and arg_151_1.time_ < var_154_23 + var_154_24 + arg_154_0 then
				local var_154_27 = Color.New(0, 0, 0)
				local var_154_28 = 0

				arg_151_1.mask_.enabled = false
				var_154_27.a = var_154_28
				arg_151_1.mask_.color = var_154_27
			end

			local var_154_29 = arg_151_1.actors_["1095ui_story"].transform
			local var_154_30 = 1

			if var_154_30 < arg_151_1.time_ and arg_151_1.time_ <= var_154_30 + arg_154_0 then
				arg_151_1.var_.moveOldPos1095ui_story = var_154_29.localPosition
			end

			local var_154_31 = 0.001

			if var_154_30 <= arg_151_1.time_ and arg_151_1.time_ < var_154_30 + var_154_31 then
				local var_154_32 = (arg_151_1.time_ - var_154_30) / var_154_31
				local var_154_33 = Vector3.New(0, 100, 0)

				var_154_29.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos1095ui_story, var_154_33, var_154_32)

				local var_154_34 = manager.ui.mainCamera.transform.position - var_154_29.position

				var_154_29.forward = Vector3.New(var_154_34.x, var_154_34.y, var_154_34.z)

				local var_154_35 = var_154_29.localEulerAngles

				var_154_35.z = 0
				var_154_35.x = 0
				var_154_29.localEulerAngles = var_154_35
			end

			if arg_151_1.time_ >= var_154_30 + var_154_31 and arg_151_1.time_ < var_154_30 + var_154_31 + arg_154_0 then
				var_154_29.localPosition = Vector3.New(0, 100, 0)

				local var_154_36 = manager.ui.mainCamera.transform.position - var_154_29.position

				var_154_29.forward = Vector3.New(var_154_36.x, var_154_36.y, var_154_36.z)

				local var_154_37 = var_154_29.localEulerAngles

				var_154_37.z = 0
				var_154_37.x = 0
				var_154_29.localEulerAngles = var_154_37
			end

			local var_154_38 = arg_151_1.actors_["1095ui_story"]
			local var_154_39 = 1

			if var_154_39 < arg_151_1.time_ and arg_151_1.time_ <= var_154_39 + arg_154_0 and not isNil(var_154_38) and arg_151_1.var_.characterEffect1095ui_story == nil then
				arg_151_1.var_.characterEffect1095ui_story = var_154_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_40 = 0.200000002980232

			if var_154_39 <= arg_151_1.time_ and arg_151_1.time_ < var_154_39 + var_154_40 and not isNil(var_154_38) then
				local var_154_41 = (arg_151_1.time_ - var_154_39) / var_154_40

				if arg_151_1.var_.characterEffect1095ui_story and not isNil(var_154_38) then
					local var_154_42 = Mathf.Lerp(0, 0.5, var_154_41)

					arg_151_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_151_1.var_.characterEffect1095ui_story.fillRatio = var_154_42
				end
			end

			if arg_151_1.time_ >= var_154_39 + var_154_40 and arg_151_1.time_ < var_154_39 + var_154_40 + arg_154_0 and not isNil(var_154_38) and arg_151_1.var_.characterEffect1095ui_story then
				local var_154_43 = 0.5

				arg_151_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_151_1.var_.characterEffect1095ui_story.fillRatio = var_154_43
			end

			local var_154_44 = arg_151_1.actors_["1084ui_story"].transform
			local var_154_45 = 1

			if var_154_45 < arg_151_1.time_ and arg_151_1.time_ <= var_154_45 + arg_154_0 then
				arg_151_1.var_.moveOldPos1084ui_story = var_154_44.localPosition
			end

			local var_154_46 = 0.001

			if var_154_45 <= arg_151_1.time_ and arg_151_1.time_ < var_154_45 + var_154_46 then
				local var_154_47 = (arg_151_1.time_ - var_154_45) / var_154_46
				local var_154_48 = Vector3.New(0, 100, 0)

				var_154_44.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos1084ui_story, var_154_48, var_154_47)

				local var_154_49 = manager.ui.mainCamera.transform.position - var_154_44.position

				var_154_44.forward = Vector3.New(var_154_49.x, var_154_49.y, var_154_49.z)

				local var_154_50 = var_154_44.localEulerAngles

				var_154_50.z = 0
				var_154_50.x = 0
				var_154_44.localEulerAngles = var_154_50
			end

			if arg_151_1.time_ >= var_154_45 + var_154_46 and arg_151_1.time_ < var_154_45 + var_154_46 + arg_154_0 then
				var_154_44.localPosition = Vector3.New(0, 100, 0)

				local var_154_51 = manager.ui.mainCamera.transform.position - var_154_44.position

				var_154_44.forward = Vector3.New(var_154_51.x, var_154_51.y, var_154_51.z)

				local var_154_52 = var_154_44.localEulerAngles

				var_154_52.z = 0
				var_154_52.x = 0
				var_154_44.localEulerAngles = var_154_52
			end

			local var_154_53 = arg_151_1.actors_["1084ui_story"]
			local var_154_54 = 1

			if var_154_54 < arg_151_1.time_ and arg_151_1.time_ <= var_154_54 + arg_154_0 and not isNil(var_154_53) and arg_151_1.var_.characterEffect1084ui_story == nil then
				arg_151_1.var_.characterEffect1084ui_story = var_154_53:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_55 = 0.200000002980232

			if var_154_54 <= arg_151_1.time_ and arg_151_1.time_ < var_154_54 + var_154_55 and not isNil(var_154_53) then
				local var_154_56 = (arg_151_1.time_ - var_154_54) / var_154_55

				if arg_151_1.var_.characterEffect1084ui_story and not isNil(var_154_53) then
					local var_154_57 = Mathf.Lerp(0, 0.5, var_154_56)

					arg_151_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_151_1.var_.characterEffect1084ui_story.fillRatio = var_154_57
				end
			end

			if arg_151_1.time_ >= var_154_54 + var_154_55 and arg_151_1.time_ < var_154_54 + var_154_55 + arg_154_0 and not isNil(var_154_53) and arg_151_1.var_.characterEffect1084ui_story then
				local var_154_58 = 0.5

				arg_151_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_151_1.var_.characterEffect1084ui_story.fillRatio = var_154_58
			end

			if arg_151_1.frameCnt_ <= 1 then
				arg_151_1.dialog_:SetActive(false)
			end

			local var_154_59 = 2.875
			local var_154_60 = 0.125

			if var_154_59 < arg_151_1.time_ and arg_151_1.time_ <= var_154_59 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0

				arg_151_1.dialog_:SetActive(true)

				arg_151_1.dialogCg_.alpha = 0

				local var_154_61 = LeanTween.value(arg_151_1.dialog_, 0, 1, 0.3)

				var_154_61:setOnUpdate(LuaHelper.FloatAction(function(arg_155_0)
					arg_151_1.dialogCg_.alpha = arg_155_0
				end))
				var_154_61:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_151_1.dialog_)
					var_154_61:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_151_1.duration_ = arg_151_1.duration_ + 0.3

				SetActive(arg_151_1.leftNameGo_, true)

				local var_154_62 = arg_151_1:FormatText(StoryNameCfg[660].name)

				arg_151_1.leftNameTxt_.text = var_154_62

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

				local var_154_63 = arg_151_1:GetWordFromCfg(319671036)
				local var_154_64 = arg_151_1:FormatText(var_154_63.content)

				arg_151_1.text_.text = var_154_64

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_65 = 5
				local var_154_66 = utf8.len(var_154_64)
				local var_154_67 = var_154_65 <= 0 and var_154_60 or var_154_60 * (var_154_66 / var_154_65)

				if var_154_67 > 0 and var_154_60 < var_154_67 then
					arg_151_1.talkMaxDuration = var_154_67
					var_154_59 = var_154_59 + 0.3

					if var_154_67 + var_154_59 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_67 + var_154_59
					end
				end

				arg_151_1.text_.text = var_154_64
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671036", "story_v_out_319671.awb") ~= 0 then
					local var_154_68 = manager.audio:GetVoiceLength("story_v_out_319671", "319671036", "story_v_out_319671.awb") / 1000

					if var_154_68 + var_154_59 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_68 + var_154_59
					end

					if var_154_63.prefab_name ~= "" and arg_151_1.actors_[var_154_63.prefab_name] ~= nil then
						local var_154_69 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_63.prefab_name].transform, "story_v_out_319671", "319671036", "story_v_out_319671.awb")

						arg_151_1:RecordAudio("319671036", var_154_69)
						arg_151_1:RecordAudio("319671036", var_154_69)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_319671", "319671036", "story_v_out_319671.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_319671", "319671036", "story_v_out_319671.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_70 = var_154_59 + 0.3
			local var_154_71 = math.max(var_154_60, arg_151_1.talkMaxDuration)

			if var_154_70 <= arg_151_1.time_ and arg_151_1.time_ < var_154_70 + var_154_71 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_70) / var_154_71

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_70 + var_154_71 and arg_151_1.time_ < var_154_70 + var_154_71 + arg_154_0 then
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
			local var_160_0 = 0
			local var_160_1 = 0.75

			if var_160_0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_0 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, false)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_2 = arg_157_1:GetWordFromCfg(319671037)
				local var_160_3 = arg_157_1:FormatText(var_160_2.content)

				arg_157_1.text_.text = var_160_3

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_4 = 30
				local var_160_5 = utf8.len(var_160_3)
				local var_160_6 = var_160_4 <= 0 and var_160_1 or var_160_1 * (var_160_5 / var_160_4)

				if var_160_6 > 0 and var_160_1 < var_160_6 then
					arg_157_1.talkMaxDuration = var_160_6

					if var_160_6 + var_160_0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_6 + var_160_0
					end
				end

				arg_157_1.text_.text = var_160_3
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_7 = math.max(var_160_1, arg_157_1.talkMaxDuration)

			if var_160_0 <= arg_157_1.time_ and arg_157_1.time_ < var_160_0 + var_160_7 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_0) / var_160_7

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_0 + var_160_7 and arg_157_1.time_ < var_160_0 + var_160_7 + arg_160_0 then
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
			local var_164_0 = 0
			local var_164_1 = 0.925

			if var_164_0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, false)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_2 = arg_161_1:GetWordFromCfg(319671038)
				local var_164_3 = arg_161_1:FormatText(var_164_2.content)

				arg_161_1.text_.text = var_164_3

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_4 = 37
				local var_164_5 = utf8.len(var_164_3)
				local var_164_6 = var_164_4 <= 0 and var_164_1 or var_164_1 * (var_164_5 / var_164_4)

				if var_164_6 > 0 and var_164_1 < var_164_6 then
					arg_161_1.talkMaxDuration = var_164_6

					if var_164_6 + var_164_0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_6 + var_164_0
					end
				end

				arg_161_1.text_.text = var_164_3
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_7 = math.max(var_164_1, arg_161_1.talkMaxDuration)

			if var_164_0 <= arg_161_1.time_ and arg_161_1.time_ < var_164_0 + var_164_7 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_0) / var_164_7

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_0 + var_164_7 and arg_161_1.time_ < var_164_0 + var_164_7 + arg_164_0 then
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
			local var_168_0 = 0
			local var_168_1 = 0.2

			if var_168_0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_0 + arg_168_0 then
				local var_168_2 = "play"
				local var_168_3 = "music"

				arg_165_1:AudioAction(var_168_2, var_168_3, "ui_battle", "ui_battle_stopbgm", "")

				local var_168_4 = ""
				local var_168_5 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_168_5 ~= "" then
					if arg_165_1.bgmTxt_.text ~= var_168_5 and arg_165_1.bgmTxt_.text ~= "" then
						if arg_165_1.bgmTxt2_.text ~= "" then
							arg_165_1.bgmTxt_.text = arg_165_1.bgmTxt2_.text
						end

						arg_165_1.bgmTxt2_.text = var_168_5

						arg_165_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_165_1.bgmTxt_.text = var_168_5
						arg_165_1.bgmTxt2_.text = var_168_5
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

			local var_168_6 = manager.ui.mainCamera.transform
			local var_168_7 = 0

			if var_168_7 < arg_165_1.time_ and arg_165_1.time_ <= var_168_7 + arg_168_0 then
				local var_168_8 = arg_165_1.var_.effect119
				local var_168_9
				local var_168_10 = var_168_6

				if not var_168_8 then
					var_168_8 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), var_168_10)
					var_168_8.name = "119"
					arg_165_1.var_.effect119 = var_168_8
				else
					var_168_8.transform:SetParent(var_168_10)
				end

				var_168_8.transform.localPosition = Vector3.New(0, 0, 0)
				var_168_8.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if arg_165_1.frameCnt_ <= 1 then
				arg_165_1.dialog_:SetActive(false)
			end

			local var_168_11 = 1.1
			local var_168_12 = 1.425

			if var_168_11 < arg_165_1.time_ and arg_165_1.time_ <= var_168_11 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0

				arg_165_1.dialog_:SetActive(true)

				arg_165_1.dialogCg_.alpha = 0

				local var_168_13 = LeanTween.value(arg_165_1.dialog_, 0, 1, 0.3)

				var_168_13:setOnUpdate(LuaHelper.FloatAction(function(arg_170_0)
					arg_165_1.dialogCg_.alpha = arg_170_0
				end))
				var_168_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_165_1.dialog_)
					var_168_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_165_1.duration_ = arg_165_1.duration_ + 0.3

				SetActive(arg_165_1.leftNameGo_, false)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_14 = arg_165_1:GetWordFromCfg(319671039)
				local var_168_15 = arg_165_1:FormatText(var_168_14.content)

				arg_165_1.text_.text = var_168_15

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_16 = 57
				local var_168_17 = utf8.len(var_168_15)
				local var_168_18 = var_168_16 <= 0 and var_168_12 or var_168_12 * (var_168_17 / var_168_16)

				if var_168_18 > 0 and var_168_12 < var_168_18 then
					arg_165_1.talkMaxDuration = var_168_18
					var_168_11 = var_168_11 + 0.3

					if var_168_18 + var_168_11 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_18 + var_168_11
					end
				end

				arg_165_1.text_.text = var_168_15
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)
				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_19 = var_168_11 + 0.3
			local var_168_20 = math.max(var_168_12, arg_165_1.talkMaxDuration)

			if var_168_19 <= arg_165_1.time_ and arg_165_1.time_ < var_168_19 + var_168_20 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_19) / var_168_20

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_19 + var_168_20 and arg_165_1.time_ < var_168_19 + var_168_20 + arg_168_0 then
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
			local var_175_0 = "10014ui_story"

			if arg_172_1.actors_[var_175_0] == nil then
				local var_175_1 = Asset.Load("Char/" .. "10014ui_story")

				if not isNil(var_175_1) then
					local var_175_2 = Object.Instantiate(Asset.Load("Char/" .. "10014ui_story"), arg_172_1.stage_.transform)

					var_175_2.name = var_175_0
					var_175_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_172_1.actors_[var_175_0] = var_175_2

					local var_175_3 = var_175_2:GetComponentInChildren(typeof(CharacterEffect))

					var_175_3.enabled = true

					local var_175_4 = GameObjectTools.GetOrAddComponent(var_175_2, typeof(DynamicBoneHelper))

					if var_175_4 then
						var_175_4:EnableDynamicBone(false)
					end

					arg_172_1:ShowWeapon(var_175_3.transform, false)

					arg_172_1.var_[var_175_0 .. "Animator"] = var_175_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_172_1.var_[var_175_0 .. "Animator"].applyRootMotion = true
					arg_172_1.var_[var_175_0 .. "LipSync"] = var_175_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_175_5 = arg_172_1.actors_["10014ui_story"].transform
			local var_175_6 = 0

			if var_175_6 < arg_172_1.time_ and arg_172_1.time_ <= var_175_6 + arg_175_0 then
				arg_172_1.var_.moveOldPos10014ui_story = var_175_5.localPosition
			end

			local var_175_7 = 0.001

			if var_175_6 <= arg_172_1.time_ and arg_172_1.time_ < var_175_6 + var_175_7 then
				local var_175_8 = (arg_172_1.time_ - var_175_6) / var_175_7
				local var_175_9 = Vector3.New(0, -1.06, -6.2)

				var_175_5.localPosition = Vector3.Lerp(arg_172_1.var_.moveOldPos10014ui_story, var_175_9, var_175_8)

				local var_175_10 = manager.ui.mainCamera.transform.position - var_175_5.position

				var_175_5.forward = Vector3.New(var_175_10.x, var_175_10.y, var_175_10.z)

				local var_175_11 = var_175_5.localEulerAngles

				var_175_11.z = 0
				var_175_11.x = 0
				var_175_5.localEulerAngles = var_175_11
			end

			if arg_172_1.time_ >= var_175_6 + var_175_7 and arg_172_1.time_ < var_175_6 + var_175_7 + arg_175_0 then
				var_175_5.localPosition = Vector3.New(0, -1.06, -6.2)

				local var_175_12 = manager.ui.mainCamera.transform.position - var_175_5.position

				var_175_5.forward = Vector3.New(var_175_12.x, var_175_12.y, var_175_12.z)

				local var_175_13 = var_175_5.localEulerAngles

				var_175_13.z = 0
				var_175_13.x = 0
				var_175_5.localEulerAngles = var_175_13
			end

			local var_175_14 = arg_172_1.actors_["10014ui_story"]
			local var_175_15 = 0

			if var_175_15 < arg_172_1.time_ and arg_172_1.time_ <= var_175_15 + arg_175_0 and not isNil(var_175_14) and arg_172_1.var_.characterEffect10014ui_story == nil then
				arg_172_1.var_.characterEffect10014ui_story = var_175_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_16 = 0.200000002980232

			if var_175_15 <= arg_172_1.time_ and arg_172_1.time_ < var_175_15 + var_175_16 and not isNil(var_175_14) then
				local var_175_17 = (arg_172_1.time_ - var_175_15) / var_175_16

				if arg_172_1.var_.characterEffect10014ui_story and not isNil(var_175_14) then
					arg_172_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_172_1.time_ >= var_175_15 + var_175_16 and arg_172_1.time_ < var_175_15 + var_175_16 + arg_175_0 and not isNil(var_175_14) and arg_172_1.var_.characterEffect10014ui_story then
				arg_172_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_175_18 = 0

			if var_175_18 < arg_172_1.time_ and arg_172_1.time_ <= var_175_18 + arg_175_0 then
				arg_172_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action1_1")
			end

			local var_175_19 = 0

			if var_175_19 < arg_172_1.time_ and arg_172_1.time_ <= var_175_19 + arg_175_0 then
				arg_172_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_175_20 = 0
			local var_175_21 = 0.2

			if var_175_20 < arg_172_1.time_ and arg_172_1.time_ <= var_175_20 + arg_175_0 then
				local var_175_22 = "play"
				local var_175_23 = "music"

				arg_172_1:AudioAction(var_175_22, var_175_23, "ui_battle", "ui_battle_stopbgm", "")

				local var_175_24 = ""
				local var_175_25 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_175_25 ~= "" then
					if arg_172_1.bgmTxt_.text ~= var_175_25 and arg_172_1.bgmTxt_.text ~= "" then
						if arg_172_1.bgmTxt2_.text ~= "" then
							arg_172_1.bgmTxt_.text = arg_172_1.bgmTxt2_.text
						end

						arg_172_1.bgmTxt2_.text = var_175_25

						arg_172_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_172_1.bgmTxt_.text = var_175_25
						arg_172_1.bgmTxt2_.text = var_175_25
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

			local var_175_26 = 0.233333333333333
			local var_175_27 = 1

			if var_175_26 < arg_172_1.time_ and arg_172_1.time_ <= var_175_26 + arg_175_0 then
				local var_175_28 = "play"
				local var_175_29 = "music"

				arg_172_1:AudioAction(var_175_28, var_175_29, "bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue.awb")

				local var_175_30 = ""
				local var_175_31 = manager.audio:GetAudioName("bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue")

				if var_175_31 ~= "" then
					if arg_172_1.bgmTxt_.text ~= var_175_31 and arg_172_1.bgmTxt_.text ~= "" then
						if arg_172_1.bgmTxt2_.text ~= "" then
							arg_172_1.bgmTxt_.text = arg_172_1.bgmTxt2_.text
						end

						arg_172_1.bgmTxt2_.text = var_175_31

						arg_172_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_172_1.bgmTxt_.text = var_175_31
						arg_172_1.bgmTxt2_.text = var_175_31
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

			local var_175_32 = manager.ui.mainCamera.transform
			local var_175_33 = 0

			if var_175_33 < arg_172_1.time_ and arg_172_1.time_ <= var_175_33 + arg_175_0 then
				local var_175_34 = arg_172_1.var_.effect119

				if var_175_34 then
					Object.Destroy(var_175_34)

					arg_172_1.var_.effect119 = nil
				end
			end

			local var_175_35 = arg_172_1.actors_["10014ui_story"]
			local var_175_36 = 0

			if var_175_36 < arg_172_1.time_ and arg_172_1.time_ <= var_175_36 + arg_175_0 then
				if arg_172_1.var_.characterEffect10014ui_story == nil then
					arg_172_1.var_.characterEffect10014ui_story = var_175_35:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_175_37 = arg_172_1.var_.characterEffect10014ui_story

				var_175_37.imageEffect:turnOff()

				var_175_37.interferenceEffect.enabled = true
				var_175_37.interferenceEffect.noise = 0.001
				var_175_37.interferenceEffect.simTimeScale = 1
				var_175_37.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_175_38 = arg_172_1.actors_["10014ui_story"]
			local var_175_39 = 0
			local var_175_40 = 2

			if var_175_39 < arg_172_1.time_ and arg_172_1.time_ <= var_175_39 + arg_175_0 then
				if arg_172_1.var_.characterEffect10014ui_story == nil then
					arg_172_1.var_.characterEffect10014ui_story = var_175_38:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_172_1.var_.characterEffect10014ui_story.imageEffect:turnOn(false)
			end

			local var_175_41 = 0
			local var_175_42 = 0.225

			if var_175_41 < arg_172_1.time_ and arg_172_1.time_ <= var_175_41 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				local var_175_43 = arg_172_1:FormatText(StoryNameCfg[264].name)

				arg_172_1.leftNameTxt_.text = var_175_43

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_44 = arg_172_1:GetWordFromCfg(319671040)
				local var_175_45 = arg_172_1:FormatText(var_175_44.content)

				arg_172_1.text_.text = var_175_45

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_46 = 9
				local var_175_47 = utf8.len(var_175_45)
				local var_175_48 = var_175_46 <= 0 and var_175_42 or var_175_42 * (var_175_47 / var_175_46)

				if var_175_48 > 0 and var_175_42 < var_175_48 then
					arg_172_1.talkMaxDuration = var_175_48

					if var_175_48 + var_175_41 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_48 + var_175_41
					end
				end

				arg_172_1.text_.text = var_175_45
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671040", "story_v_out_319671.awb") ~= 0 then
					local var_175_49 = manager.audio:GetVoiceLength("story_v_out_319671", "319671040", "story_v_out_319671.awb") / 1000

					if var_175_49 + var_175_41 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_49 + var_175_41
					end

					if var_175_44.prefab_name ~= "" and arg_172_1.actors_[var_175_44.prefab_name] ~= nil then
						local var_175_50 = LuaForUtil.PlayVoiceWithCriLipsync(arg_172_1.actors_[var_175_44.prefab_name].transform, "story_v_out_319671", "319671040", "story_v_out_319671.awb")

						arg_172_1:RecordAudio("319671040", var_175_50)
						arg_172_1:RecordAudio("319671040", var_175_50)
					else
						arg_172_1:AudioAction("play", "voice", "story_v_out_319671", "319671040", "story_v_out_319671.awb")
					end

					arg_172_1:RecordHistoryTalkVoice("story_v_out_319671", "319671040", "story_v_out_319671.awb")
				end

				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_51 = math.max(var_175_42, arg_172_1.talkMaxDuration)

			if var_175_41 <= arg_172_1.time_ and arg_172_1.time_ < var_175_41 + var_175_51 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_41) / var_175_51

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_41 + var_175_51 and arg_172_1.time_ < var_175_41 + var_175_51 + arg_175_0 then
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
			local var_181_0 = arg_178_1.actors_["1084ui_story"].transform
			local var_181_1 = 0

			if var_181_1 < arg_178_1.time_ and arg_178_1.time_ <= var_181_1 + arg_181_0 then
				arg_178_1.var_.moveOldPos1084ui_story = var_181_0.localPosition
			end

			local var_181_2 = 0.001

			if var_181_1 <= arg_178_1.time_ and arg_178_1.time_ < var_181_1 + var_181_2 then
				local var_181_3 = (arg_178_1.time_ - var_181_1) / var_181_2
				local var_181_4 = Vector3.New(0.7, -0.97, -6)

				var_181_0.localPosition = Vector3.Lerp(arg_178_1.var_.moveOldPos1084ui_story, var_181_4, var_181_3)

				local var_181_5 = manager.ui.mainCamera.transform.position - var_181_0.position

				var_181_0.forward = Vector3.New(var_181_5.x, var_181_5.y, var_181_5.z)

				local var_181_6 = var_181_0.localEulerAngles

				var_181_6.z = 0
				var_181_6.x = 0
				var_181_0.localEulerAngles = var_181_6
			end

			if arg_178_1.time_ >= var_181_1 + var_181_2 and arg_178_1.time_ < var_181_1 + var_181_2 + arg_181_0 then
				var_181_0.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_181_7 = manager.ui.mainCamera.transform.position - var_181_0.position

				var_181_0.forward = Vector3.New(var_181_7.x, var_181_7.y, var_181_7.z)

				local var_181_8 = var_181_0.localEulerAngles

				var_181_8.z = 0
				var_181_8.x = 0
				var_181_0.localEulerAngles = var_181_8
			end

			local var_181_9 = arg_178_1.actors_["1084ui_story"]
			local var_181_10 = 0

			if var_181_10 < arg_178_1.time_ and arg_178_1.time_ <= var_181_10 + arg_181_0 and not isNil(var_181_9) and arg_178_1.var_.characterEffect1084ui_story == nil then
				arg_178_1.var_.characterEffect1084ui_story = var_181_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_181_11 = 0.200000002980232

			if var_181_10 <= arg_178_1.time_ and arg_178_1.time_ < var_181_10 + var_181_11 and not isNil(var_181_9) then
				local var_181_12 = (arg_178_1.time_ - var_181_10) / var_181_11

				if arg_178_1.var_.characterEffect1084ui_story and not isNil(var_181_9) then
					arg_178_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_178_1.time_ >= var_181_10 + var_181_11 and arg_178_1.time_ < var_181_10 + var_181_11 + arg_181_0 and not isNil(var_181_9) and arg_178_1.var_.characterEffect1084ui_story then
				arg_178_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_181_13 = 0

			if var_181_13 < arg_178_1.time_ and arg_178_1.time_ <= var_181_13 + arg_181_0 then
				arg_178_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_181_14 = 0

			if var_181_14 < arg_178_1.time_ and arg_178_1.time_ <= var_181_14 + arg_181_0 then
				arg_178_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_181_15 = arg_178_1.actors_["10014ui_story"].transform
			local var_181_16 = 0

			if var_181_16 < arg_178_1.time_ and arg_178_1.time_ <= var_181_16 + arg_181_0 then
				arg_178_1.var_.moveOldPos10014ui_story = var_181_15.localPosition
			end

			local var_181_17 = 0.001

			if var_181_16 <= arg_178_1.time_ and arg_178_1.time_ < var_181_16 + var_181_17 then
				local var_181_18 = (arg_178_1.time_ - var_181_16) / var_181_17
				local var_181_19 = Vector3.New(-0.7, -1.06, -6.2)

				var_181_15.localPosition = Vector3.Lerp(arg_178_1.var_.moveOldPos10014ui_story, var_181_19, var_181_18)

				local var_181_20 = manager.ui.mainCamera.transform.position - var_181_15.position

				var_181_15.forward = Vector3.New(var_181_20.x, var_181_20.y, var_181_20.z)

				local var_181_21 = var_181_15.localEulerAngles

				var_181_21.z = 0
				var_181_21.x = 0
				var_181_15.localEulerAngles = var_181_21
			end

			if arg_178_1.time_ >= var_181_16 + var_181_17 and arg_178_1.time_ < var_181_16 + var_181_17 + arg_181_0 then
				var_181_15.localPosition = Vector3.New(-0.7, -1.06, -6.2)

				local var_181_22 = manager.ui.mainCamera.transform.position - var_181_15.position

				var_181_15.forward = Vector3.New(var_181_22.x, var_181_22.y, var_181_22.z)

				local var_181_23 = var_181_15.localEulerAngles

				var_181_23.z = 0
				var_181_23.x = 0
				var_181_15.localEulerAngles = var_181_23
			end

			local var_181_24 = arg_178_1.actors_["10014ui_story"]
			local var_181_25 = 0

			if var_181_25 < arg_178_1.time_ and arg_178_1.time_ <= var_181_25 + arg_181_0 and not isNil(var_181_24) and arg_178_1.var_.characterEffect10014ui_story == nil then
				arg_178_1.var_.characterEffect10014ui_story = var_181_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_181_26 = 0.200000002980232

			if var_181_25 <= arg_178_1.time_ and arg_178_1.time_ < var_181_25 + var_181_26 and not isNil(var_181_24) then
				local var_181_27 = (arg_178_1.time_ - var_181_25) / var_181_26

				if arg_178_1.var_.characterEffect10014ui_story and not isNil(var_181_24) then
					local var_181_28 = Mathf.Lerp(0, 0.5, var_181_27)

					arg_178_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_178_1.var_.characterEffect10014ui_story.fillRatio = var_181_28
				end
			end

			if arg_178_1.time_ >= var_181_25 + var_181_26 and arg_178_1.time_ < var_181_25 + var_181_26 + arg_181_0 and not isNil(var_181_24) and arg_178_1.var_.characterEffect10014ui_story then
				local var_181_29 = 0.5

				arg_178_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_178_1.var_.characterEffect10014ui_story.fillRatio = var_181_29
			end

			local var_181_30 = 0
			local var_181_31 = 0.25

			if var_181_30 < arg_178_1.time_ and arg_178_1.time_ <= var_181_30 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				local var_181_32 = arg_178_1:FormatText(StoryNameCfg[6].name)

				arg_178_1.leftNameTxt_.text = var_181_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_33 = arg_178_1:GetWordFromCfg(319671041)
				local var_181_34 = arg_178_1:FormatText(var_181_33.content)

				arg_178_1.text_.text = var_181_34

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_35 = 10
				local var_181_36 = utf8.len(var_181_34)
				local var_181_37 = var_181_35 <= 0 and var_181_31 or var_181_31 * (var_181_36 / var_181_35)

				if var_181_37 > 0 and var_181_31 < var_181_37 then
					arg_178_1.talkMaxDuration = var_181_37

					if var_181_37 + var_181_30 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_37 + var_181_30
					end
				end

				arg_178_1.text_.text = var_181_34
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671041", "story_v_out_319671.awb") ~= 0 then
					local var_181_38 = manager.audio:GetVoiceLength("story_v_out_319671", "319671041", "story_v_out_319671.awb") / 1000

					if var_181_38 + var_181_30 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_38 + var_181_30
					end

					if var_181_33.prefab_name ~= "" and arg_178_1.actors_[var_181_33.prefab_name] ~= nil then
						local var_181_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_178_1.actors_[var_181_33.prefab_name].transform, "story_v_out_319671", "319671041", "story_v_out_319671.awb")

						arg_178_1:RecordAudio("319671041", var_181_39)
						arg_178_1:RecordAudio("319671041", var_181_39)
					else
						arg_178_1:AudioAction("play", "voice", "story_v_out_319671", "319671041", "story_v_out_319671.awb")
					end

					arg_178_1:RecordHistoryTalkVoice("story_v_out_319671", "319671041", "story_v_out_319671.awb")
				end

				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_40 = math.max(var_181_31, arg_178_1.talkMaxDuration)

			if var_181_30 <= arg_178_1.time_ and arg_178_1.time_ < var_181_30 + var_181_40 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_30) / var_181_40

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_30 + var_181_40 and arg_178_1.time_ < var_181_30 + var_181_40 + arg_181_0 then
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
			local var_185_0 = arg_182_1.actors_["1084ui_story"]
			local var_185_1 = 0

			if var_185_1 < arg_182_1.time_ and arg_182_1.time_ <= var_185_1 + arg_185_0 and not isNil(var_185_0) and arg_182_1.var_.characterEffect1084ui_story == nil then
				arg_182_1.var_.characterEffect1084ui_story = var_185_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_185_2 = 0.200000002980232

			if var_185_1 <= arg_182_1.time_ and arg_182_1.time_ < var_185_1 + var_185_2 and not isNil(var_185_0) then
				local var_185_3 = (arg_182_1.time_ - var_185_1) / var_185_2

				if arg_182_1.var_.characterEffect1084ui_story and not isNil(var_185_0) then
					local var_185_4 = Mathf.Lerp(0, 0.5, var_185_3)

					arg_182_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_182_1.var_.characterEffect1084ui_story.fillRatio = var_185_4
				end
			end

			if arg_182_1.time_ >= var_185_1 + var_185_2 and arg_182_1.time_ < var_185_1 + var_185_2 + arg_185_0 and not isNil(var_185_0) and arg_182_1.var_.characterEffect1084ui_story then
				local var_185_5 = 0.5

				arg_182_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_182_1.var_.characterEffect1084ui_story.fillRatio = var_185_5
			end

			local var_185_6 = 0

			if var_185_6 < arg_182_1.time_ and arg_182_1.time_ <= var_185_6 + arg_185_0 then
				arg_182_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action1_1")
			end

			local var_185_7 = 0

			if var_185_7 < arg_182_1.time_ and arg_182_1.time_ <= var_185_7 + arg_185_0 then
				arg_182_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_185_8 = arg_182_1.actors_["10014ui_story"]
			local var_185_9 = 0

			if var_185_9 < arg_182_1.time_ and arg_182_1.time_ <= var_185_9 + arg_185_0 and not isNil(var_185_8) and arg_182_1.var_.characterEffect10014ui_story == nil then
				arg_182_1.var_.characterEffect10014ui_story = var_185_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_185_10 = 0.200000002980232

			if var_185_9 <= arg_182_1.time_ and arg_182_1.time_ < var_185_9 + var_185_10 and not isNil(var_185_8) then
				local var_185_11 = (arg_182_1.time_ - var_185_9) / var_185_10

				if arg_182_1.var_.characterEffect10014ui_story and not isNil(var_185_8) then
					arg_182_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_182_1.time_ >= var_185_9 + var_185_10 and arg_182_1.time_ < var_185_9 + var_185_10 + arg_185_0 and not isNil(var_185_8) and arg_182_1.var_.characterEffect10014ui_story then
				arg_182_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_185_12 = 0
			local var_185_13 = 1.025

			if var_185_12 < arg_182_1.time_ and arg_182_1.time_ <= var_185_12 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				local var_185_14 = arg_182_1:FormatText(StoryNameCfg[264].name)

				arg_182_1.leftNameTxt_.text = var_185_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_15 = arg_182_1:GetWordFromCfg(319671042)
				local var_185_16 = arg_182_1:FormatText(var_185_15.content)

				arg_182_1.text_.text = var_185_16

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_17 = 41
				local var_185_18 = utf8.len(var_185_16)
				local var_185_19 = var_185_17 <= 0 and var_185_13 or var_185_13 * (var_185_18 / var_185_17)

				if var_185_19 > 0 and var_185_13 < var_185_19 then
					arg_182_1.talkMaxDuration = var_185_19

					if var_185_19 + var_185_12 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_19 + var_185_12
					end
				end

				arg_182_1.text_.text = var_185_16
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671042", "story_v_out_319671.awb") ~= 0 then
					local var_185_20 = manager.audio:GetVoiceLength("story_v_out_319671", "319671042", "story_v_out_319671.awb") / 1000

					if var_185_20 + var_185_12 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_20 + var_185_12
					end

					if var_185_15.prefab_name ~= "" and arg_182_1.actors_[var_185_15.prefab_name] ~= nil then
						local var_185_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_182_1.actors_[var_185_15.prefab_name].transform, "story_v_out_319671", "319671042", "story_v_out_319671.awb")

						arg_182_1:RecordAudio("319671042", var_185_21)
						arg_182_1:RecordAudio("319671042", var_185_21)
					else
						arg_182_1:AudioAction("play", "voice", "story_v_out_319671", "319671042", "story_v_out_319671.awb")
					end

					arg_182_1:RecordHistoryTalkVoice("story_v_out_319671", "319671042", "story_v_out_319671.awb")
				end

				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_22 = math.max(var_185_13, arg_182_1.talkMaxDuration)

			if var_185_12 <= arg_182_1.time_ and arg_182_1.time_ < var_185_12 + var_185_22 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_12) / var_185_22

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_12 + var_185_22 and arg_182_1.time_ < var_185_12 + var_185_22 + arg_185_0 then
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
			local var_189_0 = arg_186_1.actors_["10014ui_story"].transform
			local var_189_1 = 0

			if var_189_1 < arg_186_1.time_ and arg_186_1.time_ <= var_189_1 + arg_189_0 then
				arg_186_1.var_.moveOldPos10014ui_story = var_189_0.localPosition
			end

			local var_189_2 = 0.001

			if var_189_1 <= arg_186_1.time_ and arg_186_1.time_ < var_189_1 + var_189_2 then
				local var_189_3 = (arg_186_1.time_ - var_189_1) / var_189_2
				local var_189_4 = Vector3.New(-0.7, -1.06, -6.2)

				var_189_0.localPosition = Vector3.Lerp(arg_186_1.var_.moveOldPos10014ui_story, var_189_4, var_189_3)

				local var_189_5 = manager.ui.mainCamera.transform.position - var_189_0.position

				var_189_0.forward = Vector3.New(var_189_5.x, var_189_5.y, var_189_5.z)

				local var_189_6 = var_189_0.localEulerAngles

				var_189_6.z = 0
				var_189_6.x = 0
				var_189_0.localEulerAngles = var_189_6
			end

			if arg_186_1.time_ >= var_189_1 + var_189_2 and arg_186_1.time_ < var_189_1 + var_189_2 + arg_189_0 then
				var_189_0.localPosition = Vector3.New(-0.7, -1.06, -6.2)

				local var_189_7 = manager.ui.mainCamera.transform.position - var_189_0.position

				var_189_0.forward = Vector3.New(var_189_7.x, var_189_7.y, var_189_7.z)

				local var_189_8 = var_189_0.localEulerAngles

				var_189_8.z = 0
				var_189_8.x = 0
				var_189_0.localEulerAngles = var_189_8
			end

			local var_189_9 = 0

			if var_189_9 < arg_186_1.time_ and arg_186_1.time_ <= var_189_9 + arg_189_0 then
				arg_186_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action4_1")
			end

			local var_189_10 = 0

			if var_189_10 < arg_186_1.time_ and arg_186_1.time_ <= var_189_10 + arg_189_0 then
				arg_186_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_189_11 = 0
			local var_189_12 = 0.475

			if var_189_11 < arg_186_1.time_ and arg_186_1.time_ <= var_189_11 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				local var_189_13 = arg_186_1:FormatText(StoryNameCfg[264].name)

				arg_186_1.leftNameTxt_.text = var_189_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_14 = arg_186_1:GetWordFromCfg(319671043)
				local var_189_15 = arg_186_1:FormatText(var_189_14.content)

				arg_186_1.text_.text = var_189_15

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_16 = 19
				local var_189_17 = utf8.len(var_189_15)
				local var_189_18 = var_189_16 <= 0 and var_189_12 or var_189_12 * (var_189_17 / var_189_16)

				if var_189_18 > 0 and var_189_12 < var_189_18 then
					arg_186_1.talkMaxDuration = var_189_18

					if var_189_18 + var_189_11 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_18 + var_189_11
					end
				end

				arg_186_1.text_.text = var_189_15
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671043", "story_v_out_319671.awb") ~= 0 then
					local var_189_19 = manager.audio:GetVoiceLength("story_v_out_319671", "319671043", "story_v_out_319671.awb") / 1000

					if var_189_19 + var_189_11 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_19 + var_189_11
					end

					if var_189_14.prefab_name ~= "" and arg_186_1.actors_[var_189_14.prefab_name] ~= nil then
						local var_189_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_186_1.actors_[var_189_14.prefab_name].transform, "story_v_out_319671", "319671043", "story_v_out_319671.awb")

						arg_186_1:RecordAudio("319671043", var_189_20)
						arg_186_1:RecordAudio("319671043", var_189_20)
					else
						arg_186_1:AudioAction("play", "voice", "story_v_out_319671", "319671043", "story_v_out_319671.awb")
					end

					arg_186_1:RecordHistoryTalkVoice("story_v_out_319671", "319671043", "story_v_out_319671.awb")
				end

				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_21 = math.max(var_189_12, arg_186_1.talkMaxDuration)

			if var_189_11 <= arg_186_1.time_ and arg_186_1.time_ < var_189_11 + var_189_21 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_11) / var_189_21

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_11 + var_189_21 and arg_186_1.time_ < var_189_11 + var_189_21 + arg_189_0 then
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
			local var_193_0 = arg_190_1.actors_["1084ui_story"].transform
			local var_193_1 = 0

			if var_193_1 < arg_190_1.time_ and arg_190_1.time_ <= var_193_1 + arg_193_0 then
				arg_190_1.var_.moveOldPos1084ui_story = var_193_0.localPosition
			end

			local var_193_2 = 0.001

			if var_193_1 <= arg_190_1.time_ and arg_190_1.time_ < var_193_1 + var_193_2 then
				local var_193_3 = (arg_190_1.time_ - var_193_1) / var_193_2
				local var_193_4 = Vector3.New(0.7, -0.97, -6)

				var_193_0.localPosition = Vector3.Lerp(arg_190_1.var_.moveOldPos1084ui_story, var_193_4, var_193_3)

				local var_193_5 = manager.ui.mainCamera.transform.position - var_193_0.position

				var_193_0.forward = Vector3.New(var_193_5.x, var_193_5.y, var_193_5.z)

				local var_193_6 = var_193_0.localEulerAngles

				var_193_6.z = 0
				var_193_6.x = 0
				var_193_0.localEulerAngles = var_193_6
			end

			if arg_190_1.time_ >= var_193_1 + var_193_2 and arg_190_1.time_ < var_193_1 + var_193_2 + arg_193_0 then
				var_193_0.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_193_7 = manager.ui.mainCamera.transform.position - var_193_0.position

				var_193_0.forward = Vector3.New(var_193_7.x, var_193_7.y, var_193_7.z)

				local var_193_8 = var_193_0.localEulerAngles

				var_193_8.z = 0
				var_193_8.x = 0
				var_193_0.localEulerAngles = var_193_8
			end

			local var_193_9 = arg_190_1.actors_["1084ui_story"]
			local var_193_10 = 0

			if var_193_10 < arg_190_1.time_ and arg_190_1.time_ <= var_193_10 + arg_193_0 and not isNil(var_193_9) and arg_190_1.var_.characterEffect1084ui_story == nil then
				arg_190_1.var_.characterEffect1084ui_story = var_193_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_193_11 = 0.200000002980232

			if var_193_10 <= arg_190_1.time_ and arg_190_1.time_ < var_193_10 + var_193_11 and not isNil(var_193_9) then
				local var_193_12 = (arg_190_1.time_ - var_193_10) / var_193_11

				if arg_190_1.var_.characterEffect1084ui_story and not isNil(var_193_9) then
					arg_190_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_190_1.time_ >= var_193_10 + var_193_11 and arg_190_1.time_ < var_193_10 + var_193_11 + arg_193_0 and not isNil(var_193_9) and arg_190_1.var_.characterEffect1084ui_story then
				arg_190_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_193_13 = 0

			if var_193_13 < arg_190_1.time_ and arg_190_1.time_ <= var_193_13 + arg_193_0 then
				arg_190_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_193_14 = arg_190_1.actors_["10014ui_story"]
			local var_193_15 = 0

			if var_193_15 < arg_190_1.time_ and arg_190_1.time_ <= var_193_15 + arg_193_0 and not isNil(var_193_14) and arg_190_1.var_.characterEffect10014ui_story == nil then
				arg_190_1.var_.characterEffect10014ui_story = var_193_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_193_16 = 0.200000002980232

			if var_193_15 <= arg_190_1.time_ and arg_190_1.time_ < var_193_15 + var_193_16 and not isNil(var_193_14) then
				local var_193_17 = (arg_190_1.time_ - var_193_15) / var_193_16

				if arg_190_1.var_.characterEffect10014ui_story and not isNil(var_193_14) then
					local var_193_18 = Mathf.Lerp(0, 0.5, var_193_17)

					arg_190_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_190_1.var_.characterEffect10014ui_story.fillRatio = var_193_18
				end
			end

			if arg_190_1.time_ >= var_193_15 + var_193_16 and arg_190_1.time_ < var_193_15 + var_193_16 + arg_193_0 and not isNil(var_193_14) and arg_190_1.var_.characterEffect10014ui_story then
				local var_193_19 = 0.5

				arg_190_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_190_1.var_.characterEffect10014ui_story.fillRatio = var_193_19
			end

			local var_193_20 = 0
			local var_193_21 = 0.6

			if var_193_20 < arg_190_1.time_ and arg_190_1.time_ <= var_193_20 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, true)

				local var_193_22 = arg_190_1:FormatText(StoryNameCfg[6].name)

				arg_190_1.leftNameTxt_.text = var_193_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, false)
				arg_190_1.callingController_:SetSelectedState("normal")

				local var_193_23 = arg_190_1:GetWordFromCfg(319671044)
				local var_193_24 = arg_190_1:FormatText(var_193_23.content)

				arg_190_1.text_.text = var_193_24

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_25 = 24
				local var_193_26 = utf8.len(var_193_24)
				local var_193_27 = var_193_25 <= 0 and var_193_21 or var_193_21 * (var_193_26 / var_193_25)

				if var_193_27 > 0 and var_193_21 < var_193_27 then
					arg_190_1.talkMaxDuration = var_193_27

					if var_193_27 + var_193_20 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_27 + var_193_20
					end
				end

				arg_190_1.text_.text = var_193_24
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671044", "story_v_out_319671.awb") ~= 0 then
					local var_193_28 = manager.audio:GetVoiceLength("story_v_out_319671", "319671044", "story_v_out_319671.awb") / 1000

					if var_193_28 + var_193_20 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_28 + var_193_20
					end

					if var_193_23.prefab_name ~= "" and arg_190_1.actors_[var_193_23.prefab_name] ~= nil then
						local var_193_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_190_1.actors_[var_193_23.prefab_name].transform, "story_v_out_319671", "319671044", "story_v_out_319671.awb")

						arg_190_1:RecordAudio("319671044", var_193_29)
						arg_190_1:RecordAudio("319671044", var_193_29)
					else
						arg_190_1:AudioAction("play", "voice", "story_v_out_319671", "319671044", "story_v_out_319671.awb")
					end

					arg_190_1:RecordHistoryTalkVoice("story_v_out_319671", "319671044", "story_v_out_319671.awb")
				end

				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_30 = math.max(var_193_21, arg_190_1.talkMaxDuration)

			if var_193_20 <= arg_190_1.time_ and arg_190_1.time_ < var_193_20 + var_193_30 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_20) / var_193_30

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_20 + var_193_30 and arg_190_1.time_ < var_193_20 + var_193_30 + arg_193_0 then
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
			local var_197_0 = arg_194_1.actors_["1084ui_story"]
			local var_197_1 = 0

			if var_197_1 < arg_194_1.time_ and arg_194_1.time_ <= var_197_1 + arg_197_0 and not isNil(var_197_0) and arg_194_1.var_.characterEffect1084ui_story == nil then
				arg_194_1.var_.characterEffect1084ui_story = var_197_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_197_2 = 0.200000002980232

			if var_197_1 <= arg_194_1.time_ and arg_194_1.time_ < var_197_1 + var_197_2 and not isNil(var_197_0) then
				local var_197_3 = (arg_194_1.time_ - var_197_1) / var_197_2

				if arg_194_1.var_.characterEffect1084ui_story and not isNil(var_197_0) then
					local var_197_4 = Mathf.Lerp(0, 0.5, var_197_3)

					arg_194_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_194_1.var_.characterEffect1084ui_story.fillRatio = var_197_4
				end
			end

			if arg_194_1.time_ >= var_197_1 + var_197_2 and arg_194_1.time_ < var_197_1 + var_197_2 + arg_197_0 and not isNil(var_197_0) and arg_194_1.var_.characterEffect1084ui_story then
				local var_197_5 = 0.5

				arg_194_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_194_1.var_.characterEffect1084ui_story.fillRatio = var_197_5
			end

			local var_197_6 = arg_194_1.actors_["10014ui_story"]
			local var_197_7 = 0

			if var_197_7 < arg_194_1.time_ and arg_194_1.time_ <= var_197_7 + arg_197_0 and not isNil(var_197_6) and arg_194_1.var_.characterEffect10014ui_story == nil then
				arg_194_1.var_.characterEffect10014ui_story = var_197_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_197_8 = 0.200000002980232

			if var_197_7 <= arg_194_1.time_ and arg_194_1.time_ < var_197_7 + var_197_8 and not isNil(var_197_6) then
				local var_197_9 = (arg_194_1.time_ - var_197_7) / var_197_8

				if arg_194_1.var_.characterEffect10014ui_story and not isNil(var_197_6) then
					arg_194_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_194_1.time_ >= var_197_7 + var_197_8 and arg_194_1.time_ < var_197_7 + var_197_8 + arg_197_0 and not isNil(var_197_6) and arg_194_1.var_.characterEffect10014ui_story then
				arg_194_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_197_10 = 0
			local var_197_11 = 1.025

			if var_197_10 < arg_194_1.time_ and arg_194_1.time_ <= var_197_10 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				local var_197_12 = arg_194_1:FormatText(StoryNameCfg[264].name)

				arg_194_1.leftNameTxt_.text = var_197_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, false)
				arg_194_1.callingController_:SetSelectedState("normal")

				local var_197_13 = arg_194_1:GetWordFromCfg(319671045)
				local var_197_14 = arg_194_1:FormatText(var_197_13.content)

				arg_194_1.text_.text = var_197_14

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_15 = 41
				local var_197_16 = utf8.len(var_197_14)
				local var_197_17 = var_197_15 <= 0 and var_197_11 or var_197_11 * (var_197_16 / var_197_15)

				if var_197_17 > 0 and var_197_11 < var_197_17 then
					arg_194_1.talkMaxDuration = var_197_17

					if var_197_17 + var_197_10 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_17 + var_197_10
					end
				end

				arg_194_1.text_.text = var_197_14
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671045", "story_v_out_319671.awb") ~= 0 then
					local var_197_18 = manager.audio:GetVoiceLength("story_v_out_319671", "319671045", "story_v_out_319671.awb") / 1000

					if var_197_18 + var_197_10 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_18 + var_197_10
					end

					if var_197_13.prefab_name ~= "" and arg_194_1.actors_[var_197_13.prefab_name] ~= nil then
						local var_197_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_194_1.actors_[var_197_13.prefab_name].transform, "story_v_out_319671", "319671045", "story_v_out_319671.awb")

						arg_194_1:RecordAudio("319671045", var_197_19)
						arg_194_1:RecordAudio("319671045", var_197_19)
					else
						arg_194_1:AudioAction("play", "voice", "story_v_out_319671", "319671045", "story_v_out_319671.awb")
					end

					arg_194_1:RecordHistoryTalkVoice("story_v_out_319671", "319671045", "story_v_out_319671.awb")
				end

				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_20 = math.max(var_197_11, arg_194_1.talkMaxDuration)

			if var_197_10 <= arg_194_1.time_ and arg_194_1.time_ < var_197_10 + var_197_20 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_10) / var_197_20

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_10 + var_197_20 and arg_194_1.time_ < var_197_10 + var_197_20 + arg_197_0 then
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
			local var_201_0 = 0

			if var_201_0 < arg_198_1.time_ and arg_198_1.time_ <= var_201_0 + arg_201_0 then
				arg_198_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_2")
			end

			local var_201_1 = 0

			if var_201_1 < arg_198_1.time_ and arg_198_1.time_ <= var_201_1 + arg_201_0 then
				arg_198_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_201_2 = arg_198_1.actors_["1084ui_story"]
			local var_201_3 = 0

			if var_201_3 < arg_198_1.time_ and arg_198_1.time_ <= var_201_3 + arg_201_0 and not isNil(var_201_2) and arg_198_1.var_.characterEffect1084ui_story == nil then
				arg_198_1.var_.characterEffect1084ui_story = var_201_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_201_4 = 0.200000002980232

			if var_201_3 <= arg_198_1.time_ and arg_198_1.time_ < var_201_3 + var_201_4 and not isNil(var_201_2) then
				local var_201_5 = (arg_198_1.time_ - var_201_3) / var_201_4

				if arg_198_1.var_.characterEffect1084ui_story and not isNil(var_201_2) then
					arg_198_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_198_1.time_ >= var_201_3 + var_201_4 and arg_198_1.time_ < var_201_3 + var_201_4 + arg_201_0 and not isNil(var_201_2) and arg_198_1.var_.characterEffect1084ui_story then
				arg_198_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_201_6 = arg_198_1.actors_["10014ui_story"]
			local var_201_7 = 0

			if var_201_7 < arg_198_1.time_ and arg_198_1.time_ <= var_201_7 + arg_201_0 and not isNil(var_201_6) and arg_198_1.var_.characterEffect10014ui_story == nil then
				arg_198_1.var_.characterEffect10014ui_story = var_201_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_201_8 = 0.200000002980232

			if var_201_7 <= arg_198_1.time_ and arg_198_1.time_ < var_201_7 + var_201_8 and not isNil(var_201_6) then
				local var_201_9 = (arg_198_1.time_ - var_201_7) / var_201_8

				if arg_198_1.var_.characterEffect10014ui_story and not isNil(var_201_6) then
					local var_201_10 = Mathf.Lerp(0, 0.5, var_201_9)

					arg_198_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_198_1.var_.characterEffect10014ui_story.fillRatio = var_201_10
				end
			end

			if arg_198_1.time_ >= var_201_7 + var_201_8 and arg_198_1.time_ < var_201_7 + var_201_8 + arg_201_0 and not isNil(var_201_6) and arg_198_1.var_.characterEffect10014ui_story then
				local var_201_11 = 0.5

				arg_198_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_198_1.var_.characterEffect10014ui_story.fillRatio = var_201_11
			end

			local var_201_12 = 0
			local var_201_13 = 0.525

			if var_201_12 < arg_198_1.time_ and arg_198_1.time_ <= var_201_12 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, true)

				local var_201_14 = arg_198_1:FormatText(StoryNameCfg[6].name)

				arg_198_1.leftNameTxt_.text = var_201_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_198_1.leftNameTxt_.transform)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1.leftNameTxt_.text)
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_15 = arg_198_1:GetWordFromCfg(319671046)
				local var_201_16 = arg_198_1:FormatText(var_201_15.content)

				arg_198_1.text_.text = var_201_16

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_17 = 21
				local var_201_18 = utf8.len(var_201_16)
				local var_201_19 = var_201_17 <= 0 and var_201_13 or var_201_13 * (var_201_18 / var_201_17)

				if var_201_19 > 0 and var_201_13 < var_201_19 then
					arg_198_1.talkMaxDuration = var_201_19

					if var_201_19 + var_201_12 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_19 + var_201_12
					end
				end

				arg_198_1.text_.text = var_201_16
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671046", "story_v_out_319671.awb") ~= 0 then
					local var_201_20 = manager.audio:GetVoiceLength("story_v_out_319671", "319671046", "story_v_out_319671.awb") / 1000

					if var_201_20 + var_201_12 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_20 + var_201_12
					end

					if var_201_15.prefab_name ~= "" and arg_198_1.actors_[var_201_15.prefab_name] ~= nil then
						local var_201_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_198_1.actors_[var_201_15.prefab_name].transform, "story_v_out_319671", "319671046", "story_v_out_319671.awb")

						arg_198_1:RecordAudio("319671046", var_201_21)
						arg_198_1:RecordAudio("319671046", var_201_21)
					else
						arg_198_1:AudioAction("play", "voice", "story_v_out_319671", "319671046", "story_v_out_319671.awb")
					end

					arg_198_1:RecordHistoryTalkVoice("story_v_out_319671", "319671046", "story_v_out_319671.awb")
				end

				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_22 = math.max(var_201_13, arg_198_1.talkMaxDuration)

			if var_201_12 <= arg_198_1.time_ and arg_198_1.time_ < var_201_12 + var_201_22 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_12) / var_201_22

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_12 + var_201_22 and arg_198_1.time_ < var_201_12 + var_201_22 + arg_201_0 then
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
			local var_205_0 = arg_202_1.actors_["10014ui_story"].transform
			local var_205_1 = 0

			if var_205_1 < arg_202_1.time_ and arg_202_1.time_ <= var_205_1 + arg_205_0 then
				arg_202_1.var_.moveOldPos10014ui_story = var_205_0.localPosition
			end

			local var_205_2 = 0.001

			if var_205_1 <= arg_202_1.time_ and arg_202_1.time_ < var_205_1 + var_205_2 then
				local var_205_3 = (arg_202_1.time_ - var_205_1) / var_205_2
				local var_205_4 = Vector3.New(-0.7, -1.06, -6.2)

				var_205_0.localPosition = Vector3.Lerp(arg_202_1.var_.moveOldPos10014ui_story, var_205_4, var_205_3)

				local var_205_5 = manager.ui.mainCamera.transform.position - var_205_0.position

				var_205_0.forward = Vector3.New(var_205_5.x, var_205_5.y, var_205_5.z)

				local var_205_6 = var_205_0.localEulerAngles

				var_205_6.z = 0
				var_205_6.x = 0
				var_205_0.localEulerAngles = var_205_6
			end

			if arg_202_1.time_ >= var_205_1 + var_205_2 and arg_202_1.time_ < var_205_1 + var_205_2 + arg_205_0 then
				var_205_0.localPosition = Vector3.New(-0.7, -1.06, -6.2)

				local var_205_7 = manager.ui.mainCamera.transform.position - var_205_0.position

				var_205_0.forward = Vector3.New(var_205_7.x, var_205_7.y, var_205_7.z)

				local var_205_8 = var_205_0.localEulerAngles

				var_205_8.z = 0
				var_205_8.x = 0
				var_205_0.localEulerAngles = var_205_8
			end

			local var_205_9 = arg_202_1.actors_["1084ui_story"]
			local var_205_10 = 0

			if var_205_10 < arg_202_1.time_ and arg_202_1.time_ <= var_205_10 + arg_205_0 and not isNil(var_205_9) and arg_202_1.var_.characterEffect1084ui_story == nil then
				arg_202_1.var_.characterEffect1084ui_story = var_205_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_205_11 = 0.200000002980232

			if var_205_10 <= arg_202_1.time_ and arg_202_1.time_ < var_205_10 + var_205_11 and not isNil(var_205_9) then
				local var_205_12 = (arg_202_1.time_ - var_205_10) / var_205_11

				if arg_202_1.var_.characterEffect1084ui_story and not isNil(var_205_9) then
					local var_205_13 = Mathf.Lerp(0, 0.5, var_205_12)

					arg_202_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_202_1.var_.characterEffect1084ui_story.fillRatio = var_205_13
				end
			end

			if arg_202_1.time_ >= var_205_10 + var_205_11 and arg_202_1.time_ < var_205_10 + var_205_11 + arg_205_0 and not isNil(var_205_9) and arg_202_1.var_.characterEffect1084ui_story then
				local var_205_14 = 0.5

				arg_202_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_202_1.var_.characterEffect1084ui_story.fillRatio = var_205_14
			end

			local var_205_15 = arg_202_1.actors_["10014ui_story"]
			local var_205_16 = 0

			if var_205_16 < arg_202_1.time_ and arg_202_1.time_ <= var_205_16 + arg_205_0 and not isNil(var_205_15) and arg_202_1.var_.characterEffect10014ui_story == nil then
				arg_202_1.var_.characterEffect10014ui_story = var_205_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_205_17 = 0.200000002980232

			if var_205_16 <= arg_202_1.time_ and arg_202_1.time_ < var_205_16 + var_205_17 and not isNil(var_205_15) then
				local var_205_18 = (arg_202_1.time_ - var_205_16) / var_205_17

				if arg_202_1.var_.characterEffect10014ui_story and not isNil(var_205_15) then
					arg_202_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_202_1.time_ >= var_205_16 + var_205_17 and arg_202_1.time_ < var_205_16 + var_205_17 + arg_205_0 and not isNil(var_205_15) and arg_202_1.var_.characterEffect10014ui_story then
				arg_202_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_205_19 = 0
			local var_205_20 = 0.075

			if var_205_19 < arg_202_1.time_ and arg_202_1.time_ <= var_205_19 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, true)

				local var_205_21 = arg_202_1:FormatText(StoryNameCfg[264].name)

				arg_202_1.leftNameTxt_.text = var_205_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, false)
				arg_202_1.callingController_:SetSelectedState("normal")

				local var_205_22 = arg_202_1:GetWordFromCfg(319671047)
				local var_205_23 = arg_202_1:FormatText(var_205_22.content)

				arg_202_1.text_.text = var_205_23

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_24 = 3
				local var_205_25 = utf8.len(var_205_23)
				local var_205_26 = var_205_24 <= 0 and var_205_20 or var_205_20 * (var_205_25 / var_205_24)

				if var_205_26 > 0 and var_205_20 < var_205_26 then
					arg_202_1.talkMaxDuration = var_205_26

					if var_205_26 + var_205_19 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_26 + var_205_19
					end
				end

				arg_202_1.text_.text = var_205_23
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671047", "story_v_out_319671.awb") ~= 0 then
					local var_205_27 = manager.audio:GetVoiceLength("story_v_out_319671", "319671047", "story_v_out_319671.awb") / 1000

					if var_205_27 + var_205_19 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_27 + var_205_19
					end

					if var_205_22.prefab_name ~= "" and arg_202_1.actors_[var_205_22.prefab_name] ~= nil then
						local var_205_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_202_1.actors_[var_205_22.prefab_name].transform, "story_v_out_319671", "319671047", "story_v_out_319671.awb")

						arg_202_1:RecordAudio("319671047", var_205_28)
						arg_202_1:RecordAudio("319671047", var_205_28)
					else
						arg_202_1:AudioAction("play", "voice", "story_v_out_319671", "319671047", "story_v_out_319671.awb")
					end

					arg_202_1:RecordHistoryTalkVoice("story_v_out_319671", "319671047", "story_v_out_319671.awb")
				end

				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_29 = math.max(var_205_20, arg_202_1.talkMaxDuration)

			if var_205_19 <= arg_202_1.time_ and arg_202_1.time_ < var_205_19 + var_205_29 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_19) / var_205_29

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_19 + var_205_29 and arg_202_1.time_ < var_205_19 + var_205_29 + arg_205_0 then
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
			local var_209_0 = arg_206_1.actors_["1084ui_story"].transform
			local var_209_1 = 0

			if var_209_1 < arg_206_1.time_ and arg_206_1.time_ <= var_209_1 + arg_209_0 then
				arg_206_1.var_.moveOldPos1084ui_story = var_209_0.localPosition
			end

			local var_209_2 = 0.001

			if var_209_1 <= arg_206_1.time_ and arg_206_1.time_ < var_209_1 + var_209_2 then
				local var_209_3 = (arg_206_1.time_ - var_209_1) / var_209_2
				local var_209_4 = Vector3.New(0.7, -0.97, -6)

				var_209_0.localPosition = Vector3.Lerp(arg_206_1.var_.moveOldPos1084ui_story, var_209_4, var_209_3)

				local var_209_5 = manager.ui.mainCamera.transform.position - var_209_0.position

				var_209_0.forward = Vector3.New(var_209_5.x, var_209_5.y, var_209_5.z)

				local var_209_6 = var_209_0.localEulerAngles

				var_209_6.z = 0
				var_209_6.x = 0
				var_209_0.localEulerAngles = var_209_6
			end

			if arg_206_1.time_ >= var_209_1 + var_209_2 and arg_206_1.time_ < var_209_1 + var_209_2 + arg_209_0 then
				var_209_0.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_209_7 = manager.ui.mainCamera.transform.position - var_209_0.position

				var_209_0.forward = Vector3.New(var_209_7.x, var_209_7.y, var_209_7.z)

				local var_209_8 = var_209_0.localEulerAngles

				var_209_8.z = 0
				var_209_8.x = 0
				var_209_0.localEulerAngles = var_209_8
			end

			local var_209_9 = arg_206_1.actors_["1084ui_story"]
			local var_209_10 = 0

			if var_209_10 < arg_206_1.time_ and arg_206_1.time_ <= var_209_10 + arg_209_0 and not isNil(var_209_9) and arg_206_1.var_.characterEffect1084ui_story == nil then
				arg_206_1.var_.characterEffect1084ui_story = var_209_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_209_11 = 0.200000002980232

			if var_209_10 <= arg_206_1.time_ and arg_206_1.time_ < var_209_10 + var_209_11 and not isNil(var_209_9) then
				local var_209_12 = (arg_206_1.time_ - var_209_10) / var_209_11

				if arg_206_1.var_.characterEffect1084ui_story and not isNil(var_209_9) then
					arg_206_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_206_1.time_ >= var_209_10 + var_209_11 and arg_206_1.time_ < var_209_10 + var_209_11 + arg_209_0 and not isNil(var_209_9) and arg_206_1.var_.characterEffect1084ui_story then
				arg_206_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_209_13 = 0

			if var_209_13 < arg_206_1.time_ and arg_206_1.time_ <= var_209_13 + arg_209_0 then
				arg_206_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			local var_209_14 = 0

			if var_209_14 < arg_206_1.time_ and arg_206_1.time_ <= var_209_14 + arg_209_0 then
				arg_206_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_209_15 = arg_206_1.actors_["10014ui_story"]
			local var_209_16 = 0

			if var_209_16 < arg_206_1.time_ and arg_206_1.time_ <= var_209_16 + arg_209_0 and not isNil(var_209_15) and arg_206_1.var_.characterEffect10014ui_story == nil then
				arg_206_1.var_.characterEffect10014ui_story = var_209_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_209_17 = 0.200000002980232

			if var_209_16 <= arg_206_1.time_ and arg_206_1.time_ < var_209_16 + var_209_17 and not isNil(var_209_15) then
				local var_209_18 = (arg_206_1.time_ - var_209_16) / var_209_17

				if arg_206_1.var_.characterEffect10014ui_story and not isNil(var_209_15) then
					local var_209_19 = Mathf.Lerp(0, 0.5, var_209_18)

					arg_206_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_206_1.var_.characterEffect10014ui_story.fillRatio = var_209_19
				end
			end

			if arg_206_1.time_ >= var_209_16 + var_209_17 and arg_206_1.time_ < var_209_16 + var_209_17 + arg_209_0 and not isNil(var_209_15) and arg_206_1.var_.characterEffect10014ui_story then
				local var_209_20 = 0.5

				arg_206_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_206_1.var_.characterEffect10014ui_story.fillRatio = var_209_20
			end

			local var_209_21 = 0
			local var_209_22 = 1.1

			if var_209_21 < arg_206_1.time_ and arg_206_1.time_ <= var_209_21 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, true)

				local var_209_23 = arg_206_1:FormatText(StoryNameCfg[6].name)

				arg_206_1.leftNameTxt_.text = var_209_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_206_1.leftNameTxt_.transform)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1.leftNameTxt_.text)
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_24 = arg_206_1:GetWordFromCfg(319671048)
				local var_209_25 = arg_206_1:FormatText(var_209_24.content)

				arg_206_1.text_.text = var_209_25

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_26 = 44
				local var_209_27 = utf8.len(var_209_25)
				local var_209_28 = var_209_26 <= 0 and var_209_22 or var_209_22 * (var_209_27 / var_209_26)

				if var_209_28 > 0 and var_209_22 < var_209_28 then
					arg_206_1.talkMaxDuration = var_209_28

					if var_209_28 + var_209_21 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_28 + var_209_21
					end
				end

				arg_206_1.text_.text = var_209_25
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671048", "story_v_out_319671.awb") ~= 0 then
					local var_209_29 = manager.audio:GetVoiceLength("story_v_out_319671", "319671048", "story_v_out_319671.awb") / 1000

					if var_209_29 + var_209_21 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_29 + var_209_21
					end

					if var_209_24.prefab_name ~= "" and arg_206_1.actors_[var_209_24.prefab_name] ~= nil then
						local var_209_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_206_1.actors_[var_209_24.prefab_name].transform, "story_v_out_319671", "319671048", "story_v_out_319671.awb")

						arg_206_1:RecordAudio("319671048", var_209_30)
						arg_206_1:RecordAudio("319671048", var_209_30)
					else
						arg_206_1:AudioAction("play", "voice", "story_v_out_319671", "319671048", "story_v_out_319671.awb")
					end

					arg_206_1:RecordHistoryTalkVoice("story_v_out_319671", "319671048", "story_v_out_319671.awb")
				end

				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_31 = math.max(var_209_22, arg_206_1.talkMaxDuration)

			if var_209_21 <= arg_206_1.time_ and arg_206_1.time_ < var_209_21 + var_209_31 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_21) / var_209_31

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_21 + var_209_31 and arg_206_1.time_ < var_209_21 + var_209_31 + arg_209_0 then
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
			local var_213_0 = arg_210_1.actors_["1084ui_story"]
			local var_213_1 = 0

			if var_213_1 < arg_210_1.time_ and arg_210_1.time_ <= var_213_1 + arg_213_0 and not isNil(var_213_0) and arg_210_1.var_.characterEffect1084ui_story == nil then
				arg_210_1.var_.characterEffect1084ui_story = var_213_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_213_2 = 0.200000002980232

			if var_213_1 <= arg_210_1.time_ and arg_210_1.time_ < var_213_1 + var_213_2 and not isNil(var_213_0) then
				local var_213_3 = (arg_210_1.time_ - var_213_1) / var_213_2

				if arg_210_1.var_.characterEffect1084ui_story and not isNil(var_213_0) then
					local var_213_4 = Mathf.Lerp(0, 0.5, var_213_3)

					arg_210_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_210_1.var_.characterEffect1084ui_story.fillRatio = var_213_4
				end
			end

			if arg_210_1.time_ >= var_213_1 + var_213_2 and arg_210_1.time_ < var_213_1 + var_213_2 + arg_213_0 and not isNil(var_213_0) and arg_210_1.var_.characterEffect1084ui_story then
				local var_213_5 = 0.5

				arg_210_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_210_1.var_.characterEffect1084ui_story.fillRatio = var_213_5
			end

			local var_213_6 = arg_210_1.actors_["10014ui_story"]
			local var_213_7 = 0

			if var_213_7 < arg_210_1.time_ and arg_210_1.time_ <= var_213_7 + arg_213_0 and not isNil(var_213_6) and arg_210_1.var_.characterEffect10014ui_story == nil then
				arg_210_1.var_.characterEffect10014ui_story = var_213_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_213_8 = 0.200000002980232

			if var_213_7 <= arg_210_1.time_ and arg_210_1.time_ < var_213_7 + var_213_8 and not isNil(var_213_6) then
				local var_213_9 = (arg_210_1.time_ - var_213_7) / var_213_8

				if arg_210_1.var_.characterEffect10014ui_story and not isNil(var_213_6) then
					arg_210_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_210_1.time_ >= var_213_7 + var_213_8 and arg_210_1.time_ < var_213_7 + var_213_8 + arg_213_0 and not isNil(var_213_6) and arg_210_1.var_.characterEffect10014ui_story then
				arg_210_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_213_10 = 0
			local var_213_11 = 0.475

			if var_213_10 < arg_210_1.time_ and arg_210_1.time_ <= var_213_10 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, true)

				local var_213_12 = arg_210_1:FormatText(StoryNameCfg[264].name)

				arg_210_1.leftNameTxt_.text = var_213_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_210_1.leftNameTxt_.transform)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1.leftNameTxt_.text)
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_13 = arg_210_1:GetWordFromCfg(319671049)
				local var_213_14 = arg_210_1:FormatText(var_213_13.content)

				arg_210_1.text_.text = var_213_14

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_15 = 19
				local var_213_16 = utf8.len(var_213_14)
				local var_213_17 = var_213_15 <= 0 and var_213_11 or var_213_11 * (var_213_16 / var_213_15)

				if var_213_17 > 0 and var_213_11 < var_213_17 then
					arg_210_1.talkMaxDuration = var_213_17

					if var_213_17 + var_213_10 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_17 + var_213_10
					end
				end

				arg_210_1.text_.text = var_213_14
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671049", "story_v_out_319671.awb") ~= 0 then
					local var_213_18 = manager.audio:GetVoiceLength("story_v_out_319671", "319671049", "story_v_out_319671.awb") / 1000

					if var_213_18 + var_213_10 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_18 + var_213_10
					end

					if var_213_13.prefab_name ~= "" and arg_210_1.actors_[var_213_13.prefab_name] ~= nil then
						local var_213_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_210_1.actors_[var_213_13.prefab_name].transform, "story_v_out_319671", "319671049", "story_v_out_319671.awb")

						arg_210_1:RecordAudio("319671049", var_213_19)
						arg_210_1:RecordAudio("319671049", var_213_19)
					else
						arg_210_1:AudioAction("play", "voice", "story_v_out_319671", "319671049", "story_v_out_319671.awb")
					end

					arg_210_1:RecordHistoryTalkVoice("story_v_out_319671", "319671049", "story_v_out_319671.awb")
				end

				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_20 = math.max(var_213_11, arg_210_1.talkMaxDuration)

			if var_213_10 <= arg_210_1.time_ and arg_210_1.time_ < var_213_10 + var_213_20 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_10) / var_213_20

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_10 + var_213_20 and arg_210_1.time_ < var_213_10 + var_213_20 + arg_213_0 then
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
			local var_217_0 = 0

			if var_217_0 < arg_214_1.time_ and arg_214_1.time_ <= var_217_0 + arg_217_0 then
				arg_214_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action4_2")
			end

			local var_217_1 = 0

			if var_217_1 < arg_214_1.time_ and arg_214_1.time_ <= var_217_1 + arg_217_0 then
				arg_214_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_217_2 = 0
			local var_217_3 = 0.5

			if var_217_2 < arg_214_1.time_ and arg_214_1.time_ <= var_217_2 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				local var_217_4 = arg_214_1:FormatText(StoryNameCfg[264].name)

				arg_214_1.leftNameTxt_.text = var_217_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, false)
				arg_214_1.callingController_:SetSelectedState("normal")

				local var_217_5 = arg_214_1:GetWordFromCfg(319671050)
				local var_217_6 = arg_214_1:FormatText(var_217_5.content)

				arg_214_1.text_.text = var_217_6

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_7 = 20
				local var_217_8 = utf8.len(var_217_6)
				local var_217_9 = var_217_7 <= 0 and var_217_3 or var_217_3 * (var_217_8 / var_217_7)

				if var_217_9 > 0 and var_217_3 < var_217_9 then
					arg_214_1.talkMaxDuration = var_217_9

					if var_217_9 + var_217_2 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_9 + var_217_2
					end
				end

				arg_214_1.text_.text = var_217_6
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671050", "story_v_out_319671.awb") ~= 0 then
					local var_217_10 = manager.audio:GetVoiceLength("story_v_out_319671", "319671050", "story_v_out_319671.awb") / 1000

					if var_217_10 + var_217_2 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_10 + var_217_2
					end

					if var_217_5.prefab_name ~= "" and arg_214_1.actors_[var_217_5.prefab_name] ~= nil then
						local var_217_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_214_1.actors_[var_217_5.prefab_name].transform, "story_v_out_319671", "319671050", "story_v_out_319671.awb")

						arg_214_1:RecordAudio("319671050", var_217_11)
						arg_214_1:RecordAudio("319671050", var_217_11)
					else
						arg_214_1:AudioAction("play", "voice", "story_v_out_319671", "319671050", "story_v_out_319671.awb")
					end

					arg_214_1:RecordHistoryTalkVoice("story_v_out_319671", "319671050", "story_v_out_319671.awb")
				end

				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_12 = math.max(var_217_3, arg_214_1.talkMaxDuration)

			if var_217_2 <= arg_214_1.time_ and arg_214_1.time_ < var_217_2 + var_217_12 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_2) / var_217_12

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_2 + var_217_12 and arg_214_1.time_ < var_217_2 + var_217_12 + arg_217_0 then
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
			local var_221_0 = arg_218_1.actors_["10014ui_story"]
			local var_221_1 = 0

			if var_221_1 < arg_218_1.time_ and arg_218_1.time_ <= var_221_1 + arg_221_0 and not isNil(var_221_0) and arg_218_1.var_.characterEffect10014ui_story == nil then
				arg_218_1.var_.characterEffect10014ui_story = var_221_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_221_2 = 0.200000002980232

			if var_221_1 <= arg_218_1.time_ and arg_218_1.time_ < var_221_1 + var_221_2 and not isNil(var_221_0) then
				local var_221_3 = (arg_218_1.time_ - var_221_1) / var_221_2

				if arg_218_1.var_.characterEffect10014ui_story and not isNil(var_221_0) then
					local var_221_4 = Mathf.Lerp(0, 0.5, var_221_3)

					arg_218_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_218_1.var_.characterEffect10014ui_story.fillRatio = var_221_4
				end
			end

			if arg_218_1.time_ >= var_221_1 + var_221_2 and arg_218_1.time_ < var_221_1 + var_221_2 + arg_221_0 and not isNil(var_221_0) and arg_218_1.var_.characterEffect10014ui_story then
				local var_221_5 = 0.5

				arg_218_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_218_1.var_.characterEffect10014ui_story.fillRatio = var_221_5
			end

			local var_221_6 = arg_218_1.actors_["1084ui_story"]
			local var_221_7 = 0

			if var_221_7 < arg_218_1.time_ and arg_218_1.time_ <= var_221_7 + arg_221_0 and not isNil(var_221_6) and arg_218_1.var_.characterEffect1084ui_story == nil then
				arg_218_1.var_.characterEffect1084ui_story = var_221_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_221_8 = 0.200000002980232

			if var_221_7 <= arg_218_1.time_ and arg_218_1.time_ < var_221_7 + var_221_8 and not isNil(var_221_6) then
				local var_221_9 = (arg_218_1.time_ - var_221_7) / var_221_8

				if arg_218_1.var_.characterEffect1084ui_story and not isNil(var_221_6) then
					arg_218_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_218_1.time_ >= var_221_7 + var_221_8 and arg_218_1.time_ < var_221_7 + var_221_8 + arg_221_0 and not isNil(var_221_6) and arg_218_1.var_.characterEffect1084ui_story then
				arg_218_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_221_10 = 0
			local var_221_11 = 0.175

			if var_221_10 < arg_218_1.time_ and arg_218_1.time_ <= var_221_10 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				local var_221_12 = arg_218_1:FormatText(StoryNameCfg[6].name)

				arg_218_1.leftNameTxt_.text = var_221_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_13 = arg_218_1:GetWordFromCfg(319671051)
				local var_221_14 = arg_218_1:FormatText(var_221_13.content)

				arg_218_1.text_.text = var_221_14

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_15 = 7
				local var_221_16 = utf8.len(var_221_14)
				local var_221_17 = var_221_15 <= 0 and var_221_11 or var_221_11 * (var_221_16 / var_221_15)

				if var_221_17 > 0 and var_221_11 < var_221_17 then
					arg_218_1.talkMaxDuration = var_221_17

					if var_221_17 + var_221_10 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_17 + var_221_10
					end
				end

				arg_218_1.text_.text = var_221_14
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671051", "story_v_out_319671.awb") ~= 0 then
					local var_221_18 = manager.audio:GetVoiceLength("story_v_out_319671", "319671051", "story_v_out_319671.awb") / 1000

					if var_221_18 + var_221_10 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_18 + var_221_10
					end

					if var_221_13.prefab_name ~= "" and arg_218_1.actors_[var_221_13.prefab_name] ~= nil then
						local var_221_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_218_1.actors_[var_221_13.prefab_name].transform, "story_v_out_319671", "319671051", "story_v_out_319671.awb")

						arg_218_1:RecordAudio("319671051", var_221_19)
						arg_218_1:RecordAudio("319671051", var_221_19)
					else
						arg_218_1:AudioAction("play", "voice", "story_v_out_319671", "319671051", "story_v_out_319671.awb")
					end

					arg_218_1:RecordHistoryTalkVoice("story_v_out_319671", "319671051", "story_v_out_319671.awb")
				end

				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_20 = math.max(var_221_11, arg_218_1.talkMaxDuration)

			if var_221_10 <= arg_218_1.time_ and arg_218_1.time_ < var_221_10 + var_221_20 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_10) / var_221_20

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_10 + var_221_20 and arg_218_1.time_ < var_221_10 + var_221_20 + arg_221_0 then
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
			local var_225_0 = arg_222_1.actors_["10014ui_story"].transform
			local var_225_1 = 0

			if var_225_1 < arg_222_1.time_ and arg_222_1.time_ <= var_225_1 + arg_225_0 then
				arg_222_1.var_.moveOldPos10014ui_story = var_225_0.localPosition
			end

			local var_225_2 = 0.001

			if var_225_1 <= arg_222_1.time_ and arg_222_1.time_ < var_225_1 + var_225_2 then
				local var_225_3 = (arg_222_1.time_ - var_225_1) / var_225_2
				local var_225_4 = Vector3.New(-0.7, -1.06, -6.2)

				var_225_0.localPosition = Vector3.Lerp(arg_222_1.var_.moveOldPos10014ui_story, var_225_4, var_225_3)

				local var_225_5 = manager.ui.mainCamera.transform.position - var_225_0.position

				var_225_0.forward = Vector3.New(var_225_5.x, var_225_5.y, var_225_5.z)

				local var_225_6 = var_225_0.localEulerAngles

				var_225_6.z = 0
				var_225_6.x = 0
				var_225_0.localEulerAngles = var_225_6
			end

			if arg_222_1.time_ >= var_225_1 + var_225_2 and arg_222_1.time_ < var_225_1 + var_225_2 + arg_225_0 then
				var_225_0.localPosition = Vector3.New(-0.7, -1.06, -6.2)

				local var_225_7 = manager.ui.mainCamera.transform.position - var_225_0.position

				var_225_0.forward = Vector3.New(var_225_7.x, var_225_7.y, var_225_7.z)

				local var_225_8 = var_225_0.localEulerAngles

				var_225_8.z = 0
				var_225_8.x = 0
				var_225_0.localEulerAngles = var_225_8
			end

			local var_225_9 = 0

			if var_225_9 < arg_222_1.time_ and arg_222_1.time_ <= var_225_9 + arg_225_0 then
				arg_222_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action2_1")
			end

			local var_225_10 = 0

			if var_225_10 < arg_222_1.time_ and arg_222_1.time_ <= var_225_10 + arg_225_0 then
				arg_222_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_225_11 = arg_222_1.actors_["1084ui_story"]
			local var_225_12 = 0

			if var_225_12 < arg_222_1.time_ and arg_222_1.time_ <= var_225_12 + arg_225_0 and not isNil(var_225_11) and arg_222_1.var_.characterEffect1084ui_story == nil then
				arg_222_1.var_.characterEffect1084ui_story = var_225_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_225_13 = 0.200000002980232

			if var_225_12 <= arg_222_1.time_ and arg_222_1.time_ < var_225_12 + var_225_13 and not isNil(var_225_11) then
				local var_225_14 = (arg_222_1.time_ - var_225_12) / var_225_13

				if arg_222_1.var_.characterEffect1084ui_story and not isNil(var_225_11) then
					local var_225_15 = Mathf.Lerp(0, 0.5, var_225_14)

					arg_222_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_222_1.var_.characterEffect1084ui_story.fillRatio = var_225_15
				end
			end

			if arg_222_1.time_ >= var_225_12 + var_225_13 and arg_222_1.time_ < var_225_12 + var_225_13 + arg_225_0 and not isNil(var_225_11) and arg_222_1.var_.characterEffect1084ui_story then
				local var_225_16 = 0.5

				arg_222_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_222_1.var_.characterEffect1084ui_story.fillRatio = var_225_16
			end

			local var_225_17 = arg_222_1.actors_["10014ui_story"]
			local var_225_18 = 0

			if var_225_18 < arg_222_1.time_ and arg_222_1.time_ <= var_225_18 + arg_225_0 and not isNil(var_225_17) and arg_222_1.var_.characterEffect10014ui_story == nil then
				arg_222_1.var_.characterEffect10014ui_story = var_225_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_225_19 = 0.200000002980232

			if var_225_18 <= arg_222_1.time_ and arg_222_1.time_ < var_225_18 + var_225_19 and not isNil(var_225_17) then
				local var_225_20 = (arg_222_1.time_ - var_225_18) / var_225_19

				if arg_222_1.var_.characterEffect10014ui_story and not isNil(var_225_17) then
					arg_222_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_222_1.time_ >= var_225_18 + var_225_19 and arg_222_1.time_ < var_225_18 + var_225_19 + arg_225_0 and not isNil(var_225_17) and arg_222_1.var_.characterEffect10014ui_story then
				arg_222_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_225_21 = 0
			local var_225_22 = 0.525

			if var_225_21 < arg_222_1.time_ and arg_222_1.time_ <= var_225_21 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				local var_225_23 = arg_222_1:FormatText(StoryNameCfg[264].name)

				arg_222_1.leftNameTxt_.text = var_225_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_24 = arg_222_1:GetWordFromCfg(319671052)
				local var_225_25 = arg_222_1:FormatText(var_225_24.content)

				arg_222_1.text_.text = var_225_25

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_26 = 21
				local var_225_27 = utf8.len(var_225_25)
				local var_225_28 = var_225_26 <= 0 and var_225_22 or var_225_22 * (var_225_27 / var_225_26)

				if var_225_28 > 0 and var_225_22 < var_225_28 then
					arg_222_1.talkMaxDuration = var_225_28

					if var_225_28 + var_225_21 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_28 + var_225_21
					end
				end

				arg_222_1.text_.text = var_225_25
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671052", "story_v_out_319671.awb") ~= 0 then
					local var_225_29 = manager.audio:GetVoiceLength("story_v_out_319671", "319671052", "story_v_out_319671.awb") / 1000

					if var_225_29 + var_225_21 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_29 + var_225_21
					end

					if var_225_24.prefab_name ~= "" and arg_222_1.actors_[var_225_24.prefab_name] ~= nil then
						local var_225_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_222_1.actors_[var_225_24.prefab_name].transform, "story_v_out_319671", "319671052", "story_v_out_319671.awb")

						arg_222_1:RecordAudio("319671052", var_225_30)
						arg_222_1:RecordAudio("319671052", var_225_30)
					else
						arg_222_1:AudioAction("play", "voice", "story_v_out_319671", "319671052", "story_v_out_319671.awb")
					end

					arg_222_1:RecordHistoryTalkVoice("story_v_out_319671", "319671052", "story_v_out_319671.awb")
				end

				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_31 = math.max(var_225_22, arg_222_1.talkMaxDuration)

			if var_225_21 <= arg_222_1.time_ and arg_222_1.time_ < var_225_21 + var_225_31 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_21) / var_225_31

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_21 + var_225_31 and arg_222_1.time_ < var_225_21 + var_225_31 + arg_225_0 then
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
			local var_229_0 = arg_226_1.actors_["1084ui_story"].transform
			local var_229_1 = 0

			if var_229_1 < arg_226_1.time_ and arg_226_1.time_ <= var_229_1 + arg_229_0 then
				arg_226_1.var_.moveOldPos1084ui_story = var_229_0.localPosition
			end

			local var_229_2 = 0.001

			if var_229_1 <= arg_226_1.time_ and arg_226_1.time_ < var_229_1 + var_229_2 then
				local var_229_3 = (arg_226_1.time_ - var_229_1) / var_229_2
				local var_229_4 = Vector3.New(0.7, -0.97, -6)

				var_229_0.localPosition = Vector3.Lerp(arg_226_1.var_.moveOldPos1084ui_story, var_229_4, var_229_3)

				local var_229_5 = manager.ui.mainCamera.transform.position - var_229_0.position

				var_229_0.forward = Vector3.New(var_229_5.x, var_229_5.y, var_229_5.z)

				local var_229_6 = var_229_0.localEulerAngles

				var_229_6.z = 0
				var_229_6.x = 0
				var_229_0.localEulerAngles = var_229_6
			end

			if arg_226_1.time_ >= var_229_1 + var_229_2 and arg_226_1.time_ < var_229_1 + var_229_2 + arg_229_0 then
				var_229_0.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_229_7 = manager.ui.mainCamera.transform.position - var_229_0.position

				var_229_0.forward = Vector3.New(var_229_7.x, var_229_7.y, var_229_7.z)

				local var_229_8 = var_229_0.localEulerAngles

				var_229_8.z = 0
				var_229_8.x = 0
				var_229_0.localEulerAngles = var_229_8
			end

			local var_229_9 = arg_226_1.actors_["1084ui_story"]
			local var_229_10 = 0

			if var_229_10 < arg_226_1.time_ and arg_226_1.time_ <= var_229_10 + arg_229_0 and not isNil(var_229_9) and arg_226_1.var_.characterEffect1084ui_story == nil then
				arg_226_1.var_.characterEffect1084ui_story = var_229_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_229_11 = 0.200000002980232

			if var_229_10 <= arg_226_1.time_ and arg_226_1.time_ < var_229_10 + var_229_11 and not isNil(var_229_9) then
				local var_229_12 = (arg_226_1.time_ - var_229_10) / var_229_11

				if arg_226_1.var_.characterEffect1084ui_story and not isNil(var_229_9) then
					arg_226_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_226_1.time_ >= var_229_10 + var_229_11 and arg_226_1.time_ < var_229_10 + var_229_11 + arg_229_0 and not isNil(var_229_9) and arg_226_1.var_.characterEffect1084ui_story then
				arg_226_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_229_13 = 0

			if var_229_13 < arg_226_1.time_ and arg_226_1.time_ <= var_229_13 + arg_229_0 then
				arg_226_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_2")
			end

			local var_229_14 = 0

			if var_229_14 < arg_226_1.time_ and arg_226_1.time_ <= var_229_14 + arg_229_0 then
				arg_226_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_229_15 = arg_226_1.actors_["10014ui_story"]
			local var_229_16 = 0

			if var_229_16 < arg_226_1.time_ and arg_226_1.time_ <= var_229_16 + arg_229_0 and not isNil(var_229_15) and arg_226_1.var_.characterEffect10014ui_story == nil then
				arg_226_1.var_.characterEffect10014ui_story = var_229_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_229_17 = 0.200000002980232

			if var_229_16 <= arg_226_1.time_ and arg_226_1.time_ < var_229_16 + var_229_17 and not isNil(var_229_15) then
				local var_229_18 = (arg_226_1.time_ - var_229_16) / var_229_17

				if arg_226_1.var_.characterEffect10014ui_story and not isNil(var_229_15) then
					local var_229_19 = Mathf.Lerp(0, 0.5, var_229_18)

					arg_226_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_226_1.var_.characterEffect10014ui_story.fillRatio = var_229_19
				end
			end

			if arg_226_1.time_ >= var_229_16 + var_229_17 and arg_226_1.time_ < var_229_16 + var_229_17 + arg_229_0 and not isNil(var_229_15) and arg_226_1.var_.characterEffect10014ui_story then
				local var_229_20 = 0.5

				arg_226_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_226_1.var_.characterEffect10014ui_story.fillRatio = var_229_20
			end

			local var_229_21 = 0
			local var_229_22 = 0.775

			if var_229_21 < arg_226_1.time_ and arg_226_1.time_ <= var_229_21 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				local var_229_23 = arg_226_1:FormatText(StoryNameCfg[6].name)

				arg_226_1.leftNameTxt_.text = var_229_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, false)
				arg_226_1.callingController_:SetSelectedState("normal")

				local var_229_24 = arg_226_1:GetWordFromCfg(319671053)
				local var_229_25 = arg_226_1:FormatText(var_229_24.content)

				arg_226_1.text_.text = var_229_25

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_26 = 31
				local var_229_27 = utf8.len(var_229_25)
				local var_229_28 = var_229_26 <= 0 and var_229_22 or var_229_22 * (var_229_27 / var_229_26)

				if var_229_28 > 0 and var_229_22 < var_229_28 then
					arg_226_1.talkMaxDuration = var_229_28

					if var_229_28 + var_229_21 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_28 + var_229_21
					end
				end

				arg_226_1.text_.text = var_229_25
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671053", "story_v_out_319671.awb") ~= 0 then
					local var_229_29 = manager.audio:GetVoiceLength("story_v_out_319671", "319671053", "story_v_out_319671.awb") / 1000

					if var_229_29 + var_229_21 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_29 + var_229_21
					end

					if var_229_24.prefab_name ~= "" and arg_226_1.actors_[var_229_24.prefab_name] ~= nil then
						local var_229_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_226_1.actors_[var_229_24.prefab_name].transform, "story_v_out_319671", "319671053", "story_v_out_319671.awb")

						arg_226_1:RecordAudio("319671053", var_229_30)
						arg_226_1:RecordAudio("319671053", var_229_30)
					else
						arg_226_1:AudioAction("play", "voice", "story_v_out_319671", "319671053", "story_v_out_319671.awb")
					end

					arg_226_1:RecordHistoryTalkVoice("story_v_out_319671", "319671053", "story_v_out_319671.awb")
				end

				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_31 = math.max(var_229_22, arg_226_1.talkMaxDuration)

			if var_229_21 <= arg_226_1.time_ and arg_226_1.time_ < var_229_21 + var_229_31 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_21) / var_229_31

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_21 + var_229_31 and arg_226_1.time_ < var_229_21 + var_229_31 + arg_229_0 then
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
			local var_233_0 = arg_230_1.actors_["1084ui_story"]
			local var_233_1 = 0

			if var_233_1 < arg_230_1.time_ and arg_230_1.time_ <= var_233_1 + arg_233_0 and not isNil(var_233_0) and arg_230_1.var_.characterEffect1084ui_story == nil then
				arg_230_1.var_.characterEffect1084ui_story = var_233_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_233_2 = 0.200000002980232

			if var_233_1 <= arg_230_1.time_ and arg_230_1.time_ < var_233_1 + var_233_2 and not isNil(var_233_0) then
				local var_233_3 = (arg_230_1.time_ - var_233_1) / var_233_2

				if arg_230_1.var_.characterEffect1084ui_story and not isNil(var_233_0) then
					local var_233_4 = Mathf.Lerp(0, 0.5, var_233_3)

					arg_230_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_230_1.var_.characterEffect1084ui_story.fillRatio = var_233_4
				end
			end

			if arg_230_1.time_ >= var_233_1 + var_233_2 and arg_230_1.time_ < var_233_1 + var_233_2 + arg_233_0 and not isNil(var_233_0) and arg_230_1.var_.characterEffect1084ui_story then
				local var_233_5 = 0.5

				arg_230_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_230_1.var_.characterEffect1084ui_story.fillRatio = var_233_5
			end

			local var_233_6 = arg_230_1.actors_["10014ui_story"]
			local var_233_7 = 0

			if var_233_7 < arg_230_1.time_ and arg_230_1.time_ <= var_233_7 + arg_233_0 and not isNil(var_233_6) and arg_230_1.var_.characterEffect10014ui_story == nil then
				arg_230_1.var_.characterEffect10014ui_story = var_233_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_233_8 = 0.200000002980232

			if var_233_7 <= arg_230_1.time_ and arg_230_1.time_ < var_233_7 + var_233_8 and not isNil(var_233_6) then
				local var_233_9 = (arg_230_1.time_ - var_233_7) / var_233_8

				if arg_230_1.var_.characterEffect10014ui_story and not isNil(var_233_6) then
					arg_230_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_230_1.time_ >= var_233_7 + var_233_8 and arg_230_1.time_ < var_233_7 + var_233_8 + arg_233_0 and not isNil(var_233_6) and arg_230_1.var_.characterEffect10014ui_story then
				arg_230_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_233_10 = 0
			local var_233_11 = 0.5

			if var_233_10 < arg_230_1.time_ and arg_230_1.time_ <= var_233_10 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				local var_233_12 = arg_230_1:FormatText(StoryNameCfg[264].name)

				arg_230_1.leftNameTxt_.text = var_233_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_13 = arg_230_1:GetWordFromCfg(319671054)
				local var_233_14 = arg_230_1:FormatText(var_233_13.content)

				arg_230_1.text_.text = var_233_14

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_15 = 20
				local var_233_16 = utf8.len(var_233_14)
				local var_233_17 = var_233_15 <= 0 and var_233_11 or var_233_11 * (var_233_16 / var_233_15)

				if var_233_17 > 0 and var_233_11 < var_233_17 then
					arg_230_1.talkMaxDuration = var_233_17

					if var_233_17 + var_233_10 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_17 + var_233_10
					end
				end

				arg_230_1.text_.text = var_233_14
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671054", "story_v_out_319671.awb") ~= 0 then
					local var_233_18 = manager.audio:GetVoiceLength("story_v_out_319671", "319671054", "story_v_out_319671.awb") / 1000

					if var_233_18 + var_233_10 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_18 + var_233_10
					end

					if var_233_13.prefab_name ~= "" and arg_230_1.actors_[var_233_13.prefab_name] ~= nil then
						local var_233_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_230_1.actors_[var_233_13.prefab_name].transform, "story_v_out_319671", "319671054", "story_v_out_319671.awb")

						arg_230_1:RecordAudio("319671054", var_233_19)
						arg_230_1:RecordAudio("319671054", var_233_19)
					else
						arg_230_1:AudioAction("play", "voice", "story_v_out_319671", "319671054", "story_v_out_319671.awb")
					end

					arg_230_1:RecordHistoryTalkVoice("story_v_out_319671", "319671054", "story_v_out_319671.awb")
				end

				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_20 = math.max(var_233_11, arg_230_1.talkMaxDuration)

			if var_233_10 <= arg_230_1.time_ and arg_230_1.time_ < var_233_10 + var_233_20 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_10) / var_233_20

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_10 + var_233_20 and arg_230_1.time_ < var_233_10 + var_233_20 + arg_233_0 then
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
			local var_237_0 = arg_234_1.actors_["10014ui_story"]
			local var_237_1 = 0

			if var_237_1 < arg_234_1.time_ and arg_234_1.time_ <= var_237_1 + arg_237_0 and not isNil(var_237_0) and arg_234_1.var_.characterEffect10014ui_story == nil then
				arg_234_1.var_.characterEffect10014ui_story = var_237_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_237_2 = 0.200000002980232

			if var_237_1 <= arg_234_1.time_ and arg_234_1.time_ < var_237_1 + var_237_2 and not isNil(var_237_0) then
				local var_237_3 = (arg_234_1.time_ - var_237_1) / var_237_2

				if arg_234_1.var_.characterEffect10014ui_story and not isNil(var_237_0) then
					local var_237_4 = Mathf.Lerp(0, 0.5, var_237_3)

					arg_234_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_234_1.var_.characterEffect10014ui_story.fillRatio = var_237_4
				end
			end

			if arg_234_1.time_ >= var_237_1 + var_237_2 and arg_234_1.time_ < var_237_1 + var_237_2 + arg_237_0 and not isNil(var_237_0) and arg_234_1.var_.characterEffect10014ui_story then
				local var_237_5 = 0.5

				arg_234_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_234_1.var_.characterEffect10014ui_story.fillRatio = var_237_5
			end

			local var_237_6 = 0
			local var_237_7 = 0.825

			if var_237_6 < arg_234_1.time_ and arg_234_1.time_ <= var_237_6 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, false)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_8 = arg_234_1:GetWordFromCfg(319671055)
				local var_237_9 = arg_234_1:FormatText(var_237_8.content)

				arg_234_1.text_.text = var_237_9

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_10 = 32
				local var_237_11 = utf8.len(var_237_9)
				local var_237_12 = var_237_10 <= 0 and var_237_7 or var_237_7 * (var_237_11 / var_237_10)

				if var_237_12 > 0 and var_237_7 < var_237_12 then
					arg_234_1.talkMaxDuration = var_237_12

					if var_237_12 + var_237_6 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_12 + var_237_6
					end
				end

				arg_234_1.text_.text = var_237_9
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)
				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_13 = math.max(var_237_7, arg_234_1.talkMaxDuration)

			if var_237_6 <= arg_234_1.time_ and arg_234_1.time_ < var_237_6 + var_237_13 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_6) / var_237_13

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_6 + var_237_13 and arg_234_1.time_ < var_237_6 + var_237_13 + arg_237_0 then
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
			local var_241_0 = arg_238_1.actors_["10014ui_story"]
			local var_241_1 = 0

			if var_241_1 < arg_238_1.time_ and arg_238_1.time_ <= var_241_1 + arg_241_0 and not isNil(var_241_0) and arg_238_1.var_.characterEffect10014ui_story == nil then
				arg_238_1.var_.characterEffect10014ui_story = var_241_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_241_2 = 0.200000002980232

			if var_241_1 <= arg_238_1.time_ and arg_238_1.time_ < var_241_1 + var_241_2 and not isNil(var_241_0) then
				local var_241_3 = (arg_238_1.time_ - var_241_1) / var_241_2

				if arg_238_1.var_.characterEffect10014ui_story and not isNil(var_241_0) then
					arg_238_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_238_1.time_ >= var_241_1 + var_241_2 and arg_238_1.time_ < var_241_1 + var_241_2 + arg_241_0 and not isNil(var_241_0) and arg_238_1.var_.characterEffect10014ui_story then
				arg_238_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_241_4 = 0

			if var_241_4 < arg_238_1.time_ and arg_238_1.time_ <= var_241_4 + arg_241_0 then
				arg_238_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action2_2")
			end

			local var_241_5 = 0

			if var_241_5 < arg_238_1.time_ and arg_238_1.time_ <= var_241_5 + arg_241_0 then
				arg_238_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_241_6 = 0
			local var_241_7 = 1.45

			if var_241_6 < arg_238_1.time_ and arg_238_1.time_ <= var_241_6 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, true)

				local var_241_8 = arg_238_1:FormatText(StoryNameCfg[264].name)

				arg_238_1.leftNameTxt_.text = var_241_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_238_1.leftNameTxt_.transform)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1.leftNameTxt_.text)
				SetActive(arg_238_1.iconTrs_.gameObject, false)
				arg_238_1.callingController_:SetSelectedState("normal")

				local var_241_9 = arg_238_1:GetWordFromCfg(319671056)
				local var_241_10 = arg_238_1:FormatText(var_241_9.content)

				arg_238_1.text_.text = var_241_10

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_11 = 58
				local var_241_12 = utf8.len(var_241_10)
				local var_241_13 = var_241_11 <= 0 and var_241_7 or var_241_7 * (var_241_12 / var_241_11)

				if var_241_13 > 0 and var_241_7 < var_241_13 then
					arg_238_1.talkMaxDuration = var_241_13

					if var_241_13 + var_241_6 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_13 + var_241_6
					end
				end

				arg_238_1.text_.text = var_241_10
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671056", "story_v_out_319671.awb") ~= 0 then
					local var_241_14 = manager.audio:GetVoiceLength("story_v_out_319671", "319671056", "story_v_out_319671.awb") / 1000

					if var_241_14 + var_241_6 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_14 + var_241_6
					end

					if var_241_9.prefab_name ~= "" and arg_238_1.actors_[var_241_9.prefab_name] ~= nil then
						local var_241_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_238_1.actors_[var_241_9.prefab_name].transform, "story_v_out_319671", "319671056", "story_v_out_319671.awb")

						arg_238_1:RecordAudio("319671056", var_241_15)
						arg_238_1:RecordAudio("319671056", var_241_15)
					else
						arg_238_1:AudioAction("play", "voice", "story_v_out_319671", "319671056", "story_v_out_319671.awb")
					end

					arg_238_1:RecordHistoryTalkVoice("story_v_out_319671", "319671056", "story_v_out_319671.awb")
				end

				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_16 = math.max(var_241_7, arg_238_1.talkMaxDuration)

			if var_241_6 <= arg_238_1.time_ and arg_238_1.time_ < var_241_6 + var_241_16 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_6) / var_241_16

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_6 + var_241_16 and arg_238_1.time_ < var_241_6 + var_241_16 + arg_241_0 then
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
			local var_245_0 = arg_242_1.actors_["10014ui_story"]
			local var_245_1 = 0

			if var_245_1 < arg_242_1.time_ and arg_242_1.time_ <= var_245_1 + arg_245_0 and not isNil(var_245_0) and arg_242_1.var_.characterEffect10014ui_story == nil then
				arg_242_1.var_.characterEffect10014ui_story = var_245_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_245_2 = 0.200000002980232

			if var_245_1 <= arg_242_1.time_ and arg_242_1.time_ < var_245_1 + var_245_2 and not isNil(var_245_0) then
				local var_245_3 = (arg_242_1.time_ - var_245_1) / var_245_2

				if arg_242_1.var_.characterEffect10014ui_story and not isNil(var_245_0) then
					local var_245_4 = Mathf.Lerp(0, 0.5, var_245_3)

					arg_242_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_242_1.var_.characterEffect10014ui_story.fillRatio = var_245_4
				end
			end

			if arg_242_1.time_ >= var_245_1 + var_245_2 and arg_242_1.time_ < var_245_1 + var_245_2 + arg_245_0 and not isNil(var_245_0) and arg_242_1.var_.characterEffect10014ui_story then
				local var_245_5 = 0.5

				arg_242_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_242_1.var_.characterEffect10014ui_story.fillRatio = var_245_5
			end

			local var_245_6 = arg_242_1.actors_["1084ui_story"]
			local var_245_7 = 0

			if var_245_7 < arg_242_1.time_ and arg_242_1.time_ <= var_245_7 + arg_245_0 and not isNil(var_245_6) and arg_242_1.var_.characterEffect1084ui_story == nil then
				arg_242_1.var_.characterEffect1084ui_story = var_245_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_245_8 = 0.200000002980232

			if var_245_7 <= arg_242_1.time_ and arg_242_1.time_ < var_245_7 + var_245_8 and not isNil(var_245_6) then
				local var_245_9 = (arg_242_1.time_ - var_245_7) / var_245_8

				if arg_242_1.var_.characterEffect1084ui_story and not isNil(var_245_6) then
					arg_242_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_242_1.time_ >= var_245_7 + var_245_8 and arg_242_1.time_ < var_245_7 + var_245_8 + arg_245_0 and not isNil(var_245_6) and arg_242_1.var_.characterEffect1084ui_story then
				arg_242_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_245_10 = 0

			if var_245_10 < arg_242_1.time_ and arg_242_1.time_ <= var_245_10 + arg_245_0 then
				arg_242_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			local var_245_11 = 0

			if var_245_11 < arg_242_1.time_ and arg_242_1.time_ <= var_245_11 + arg_245_0 then
				arg_242_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_245_12 = 0
			local var_245_13 = 0.4

			if var_245_12 < arg_242_1.time_ and arg_242_1.time_ <= var_245_12 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, true)

				local var_245_14 = arg_242_1:FormatText(StoryNameCfg[6].name)

				arg_242_1.leftNameTxt_.text = var_245_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_242_1.leftNameTxt_.transform)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1.leftNameTxt_.text)
				SetActive(arg_242_1.iconTrs_.gameObject, false)
				arg_242_1.callingController_:SetSelectedState("normal")

				local var_245_15 = arg_242_1:GetWordFromCfg(319671057)
				local var_245_16 = arg_242_1:FormatText(var_245_15.content)

				arg_242_1.text_.text = var_245_16

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_17 = 16
				local var_245_18 = utf8.len(var_245_16)
				local var_245_19 = var_245_17 <= 0 and var_245_13 or var_245_13 * (var_245_18 / var_245_17)

				if var_245_19 > 0 and var_245_13 < var_245_19 then
					arg_242_1.talkMaxDuration = var_245_19

					if var_245_19 + var_245_12 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_19 + var_245_12
					end
				end

				arg_242_1.text_.text = var_245_16
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671057", "story_v_out_319671.awb") ~= 0 then
					local var_245_20 = manager.audio:GetVoiceLength("story_v_out_319671", "319671057", "story_v_out_319671.awb") / 1000

					if var_245_20 + var_245_12 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_20 + var_245_12
					end

					if var_245_15.prefab_name ~= "" and arg_242_1.actors_[var_245_15.prefab_name] ~= nil then
						local var_245_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_242_1.actors_[var_245_15.prefab_name].transform, "story_v_out_319671", "319671057", "story_v_out_319671.awb")

						arg_242_1:RecordAudio("319671057", var_245_21)
						arg_242_1:RecordAudio("319671057", var_245_21)
					else
						arg_242_1:AudioAction("play", "voice", "story_v_out_319671", "319671057", "story_v_out_319671.awb")
					end

					arg_242_1:RecordHistoryTalkVoice("story_v_out_319671", "319671057", "story_v_out_319671.awb")
				end

				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_22 = math.max(var_245_13, arg_242_1.talkMaxDuration)

			if var_245_12 <= arg_242_1.time_ and arg_242_1.time_ < var_245_12 + var_245_22 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - var_245_12) / var_245_22

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= var_245_12 + var_245_22 and arg_242_1.time_ < var_245_12 + var_245_22 + arg_245_0 then
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
			local var_249_0 = arg_246_1.actors_["1084ui_story"]
			local var_249_1 = 0

			if var_249_1 < arg_246_1.time_ and arg_246_1.time_ <= var_249_1 + arg_249_0 and not isNil(var_249_0) and arg_246_1.var_.characterEffect1084ui_story == nil then
				arg_246_1.var_.characterEffect1084ui_story = var_249_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_249_2 = 0.200000002980232

			if var_249_1 <= arg_246_1.time_ and arg_246_1.time_ < var_249_1 + var_249_2 and not isNil(var_249_0) then
				local var_249_3 = (arg_246_1.time_ - var_249_1) / var_249_2

				if arg_246_1.var_.characterEffect1084ui_story and not isNil(var_249_0) then
					local var_249_4 = Mathf.Lerp(0, 0.5, var_249_3)

					arg_246_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_246_1.var_.characterEffect1084ui_story.fillRatio = var_249_4
				end
			end

			if arg_246_1.time_ >= var_249_1 + var_249_2 and arg_246_1.time_ < var_249_1 + var_249_2 + arg_249_0 and not isNil(var_249_0) and arg_246_1.var_.characterEffect1084ui_story then
				local var_249_5 = 0.5

				arg_246_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_246_1.var_.characterEffect1084ui_story.fillRatio = var_249_5
			end

			local var_249_6 = arg_246_1.actors_["10014ui_story"]
			local var_249_7 = 0

			if var_249_7 < arg_246_1.time_ and arg_246_1.time_ <= var_249_7 + arg_249_0 and not isNil(var_249_6) and arg_246_1.var_.characterEffect10014ui_story == nil then
				arg_246_1.var_.characterEffect10014ui_story = var_249_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_249_8 = 0.200000002980232

			if var_249_7 <= arg_246_1.time_ and arg_246_1.time_ < var_249_7 + var_249_8 and not isNil(var_249_6) then
				local var_249_9 = (arg_246_1.time_ - var_249_7) / var_249_8

				if arg_246_1.var_.characterEffect10014ui_story and not isNil(var_249_6) then
					arg_246_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_246_1.time_ >= var_249_7 + var_249_8 and arg_246_1.time_ < var_249_7 + var_249_8 + arg_249_0 and not isNil(var_249_6) and arg_246_1.var_.characterEffect10014ui_story then
				arg_246_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_249_10 = 0
			local var_249_11 = 0.5

			if var_249_10 < arg_246_1.time_ and arg_246_1.time_ <= var_249_10 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, true)

				local var_249_12 = arg_246_1:FormatText(StoryNameCfg[264].name)

				arg_246_1.leftNameTxt_.text = var_249_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_246_1.leftNameTxt_.transform)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1.leftNameTxt_.text)
				SetActive(arg_246_1.iconTrs_.gameObject, false)
				arg_246_1.callingController_:SetSelectedState("normal")

				local var_249_13 = arg_246_1:GetWordFromCfg(319671058)
				local var_249_14 = arg_246_1:FormatText(var_249_13.content)

				arg_246_1.text_.text = var_249_14

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_15 = 20
				local var_249_16 = utf8.len(var_249_14)
				local var_249_17 = var_249_15 <= 0 and var_249_11 or var_249_11 * (var_249_16 / var_249_15)

				if var_249_17 > 0 and var_249_11 < var_249_17 then
					arg_246_1.talkMaxDuration = var_249_17

					if var_249_17 + var_249_10 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_17 + var_249_10
					end
				end

				arg_246_1.text_.text = var_249_14
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671058", "story_v_out_319671.awb") ~= 0 then
					local var_249_18 = manager.audio:GetVoiceLength("story_v_out_319671", "319671058", "story_v_out_319671.awb") / 1000

					if var_249_18 + var_249_10 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_18 + var_249_10
					end

					if var_249_13.prefab_name ~= "" and arg_246_1.actors_[var_249_13.prefab_name] ~= nil then
						local var_249_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_246_1.actors_[var_249_13.prefab_name].transform, "story_v_out_319671", "319671058", "story_v_out_319671.awb")

						arg_246_1:RecordAudio("319671058", var_249_19)
						arg_246_1:RecordAudio("319671058", var_249_19)
					else
						arg_246_1:AudioAction("play", "voice", "story_v_out_319671", "319671058", "story_v_out_319671.awb")
					end

					arg_246_1:RecordHistoryTalkVoice("story_v_out_319671", "319671058", "story_v_out_319671.awb")
				end

				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_20 = math.max(var_249_11, arg_246_1.talkMaxDuration)

			if var_249_10 <= arg_246_1.time_ and arg_246_1.time_ < var_249_10 + var_249_20 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - var_249_10) / var_249_20

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= var_249_10 + var_249_20 and arg_246_1.time_ < var_249_10 + var_249_20 + arg_249_0 then
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
			local var_253_0 = arg_250_1.actors_["10014ui_story"].transform
			local var_253_1 = 0

			if var_253_1 < arg_250_1.time_ and arg_250_1.time_ <= var_253_1 + arg_253_0 then
				arg_250_1.var_.moveOldPos10014ui_story = var_253_0.localPosition
			end

			local var_253_2 = 0.001

			if var_253_1 <= arg_250_1.time_ and arg_250_1.time_ < var_253_1 + var_253_2 then
				local var_253_3 = (arg_250_1.time_ - var_253_1) / var_253_2
				local var_253_4 = Vector3.New(-0.7, -1.06, -6.2)

				var_253_0.localPosition = Vector3.Lerp(arg_250_1.var_.moveOldPos10014ui_story, var_253_4, var_253_3)

				local var_253_5 = manager.ui.mainCamera.transform.position - var_253_0.position

				var_253_0.forward = Vector3.New(var_253_5.x, var_253_5.y, var_253_5.z)

				local var_253_6 = var_253_0.localEulerAngles

				var_253_6.z = 0
				var_253_6.x = 0
				var_253_0.localEulerAngles = var_253_6
			end

			if arg_250_1.time_ >= var_253_1 + var_253_2 and arg_250_1.time_ < var_253_1 + var_253_2 + arg_253_0 then
				var_253_0.localPosition = Vector3.New(-0.7, -1.06, -6.2)

				local var_253_7 = manager.ui.mainCamera.transform.position - var_253_0.position

				var_253_0.forward = Vector3.New(var_253_7.x, var_253_7.y, var_253_7.z)

				local var_253_8 = var_253_0.localEulerAngles

				var_253_8.z = 0
				var_253_8.x = 0
				var_253_0.localEulerAngles = var_253_8
			end

			local var_253_9 = arg_250_1.actors_["10014ui_story"]
			local var_253_10 = 0

			if var_253_10 < arg_250_1.time_ and arg_250_1.time_ <= var_253_10 + arg_253_0 and not isNil(var_253_9) and arg_250_1.var_.characterEffect10014ui_story == nil then
				arg_250_1.var_.characterEffect10014ui_story = var_253_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_253_11 = 0.200000002980232

			if var_253_10 <= arg_250_1.time_ and arg_250_1.time_ < var_253_10 + var_253_11 and not isNil(var_253_9) then
				local var_253_12 = (arg_250_1.time_ - var_253_10) / var_253_11

				if arg_250_1.var_.characterEffect10014ui_story and not isNil(var_253_9) then
					arg_250_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_250_1.time_ >= var_253_10 + var_253_11 and arg_250_1.time_ < var_253_10 + var_253_11 + arg_253_0 and not isNil(var_253_9) and arg_250_1.var_.characterEffect10014ui_story then
				arg_250_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_253_13 = 0

			if var_253_13 < arg_250_1.time_ and arg_250_1.time_ <= var_253_13 + arg_253_0 then
				arg_250_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action3_1")
			end

			local var_253_14 = 0

			if var_253_14 < arg_250_1.time_ and arg_250_1.time_ <= var_253_14 + arg_253_0 then
				arg_250_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_253_15 = 0
			local var_253_16 = 1.275

			if var_253_15 < arg_250_1.time_ and arg_250_1.time_ <= var_253_15 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, true)

				local var_253_17 = arg_250_1:FormatText(StoryNameCfg[264].name)

				arg_250_1.leftNameTxt_.text = var_253_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_250_1.leftNameTxt_.transform)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1.leftNameTxt_.text)
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_18 = arg_250_1:GetWordFromCfg(319671059)
				local var_253_19 = arg_250_1:FormatText(var_253_18.content)

				arg_250_1.text_.text = var_253_19

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_20 = 51
				local var_253_21 = utf8.len(var_253_19)
				local var_253_22 = var_253_20 <= 0 and var_253_16 or var_253_16 * (var_253_21 / var_253_20)

				if var_253_22 > 0 and var_253_16 < var_253_22 then
					arg_250_1.talkMaxDuration = var_253_22

					if var_253_22 + var_253_15 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_22 + var_253_15
					end
				end

				arg_250_1.text_.text = var_253_19
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671059", "story_v_out_319671.awb") ~= 0 then
					local var_253_23 = manager.audio:GetVoiceLength("story_v_out_319671", "319671059", "story_v_out_319671.awb") / 1000

					if var_253_23 + var_253_15 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_23 + var_253_15
					end

					if var_253_18.prefab_name ~= "" and arg_250_1.actors_[var_253_18.prefab_name] ~= nil then
						local var_253_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_250_1.actors_[var_253_18.prefab_name].transform, "story_v_out_319671", "319671059", "story_v_out_319671.awb")

						arg_250_1:RecordAudio("319671059", var_253_24)
						arg_250_1:RecordAudio("319671059", var_253_24)
					else
						arg_250_1:AudioAction("play", "voice", "story_v_out_319671", "319671059", "story_v_out_319671.awb")
					end

					arg_250_1:RecordHistoryTalkVoice("story_v_out_319671", "319671059", "story_v_out_319671.awb")
				end

				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_25 = math.max(var_253_16, arg_250_1.talkMaxDuration)

			if var_253_15 <= arg_250_1.time_ and arg_250_1.time_ < var_253_15 + var_253_25 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_15) / var_253_25

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_15 + var_253_25 and arg_250_1.time_ < var_253_15 + var_253_25 + arg_253_0 then
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
			local var_257_0 = arg_254_1.actors_["10014ui_story"]
			local var_257_1 = 0

			if var_257_1 < arg_254_1.time_ and arg_254_1.time_ <= var_257_1 + arg_257_0 and not isNil(var_257_0) and arg_254_1.var_.characterEffect10014ui_story == nil then
				arg_254_1.var_.characterEffect10014ui_story = var_257_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_257_2 = 0.200000002980232

			if var_257_1 <= arg_254_1.time_ and arg_254_1.time_ < var_257_1 + var_257_2 and not isNil(var_257_0) then
				local var_257_3 = (arg_254_1.time_ - var_257_1) / var_257_2

				if arg_254_1.var_.characterEffect10014ui_story and not isNil(var_257_0) then
					local var_257_4 = Mathf.Lerp(0, 0.5, var_257_3)

					arg_254_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_254_1.var_.characterEffect10014ui_story.fillRatio = var_257_4
				end
			end

			if arg_254_1.time_ >= var_257_1 + var_257_2 and arg_254_1.time_ < var_257_1 + var_257_2 + arg_257_0 and not isNil(var_257_0) and arg_254_1.var_.characterEffect10014ui_story then
				local var_257_5 = 0.5

				arg_254_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_254_1.var_.characterEffect10014ui_story.fillRatio = var_257_5
			end

			local var_257_6 = 0

			if var_257_6 < arg_254_1.time_ and arg_254_1.time_ <= var_257_6 + arg_257_0 then
				arg_254_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_2")
			end

			local var_257_7 = 0

			if var_257_7 < arg_254_1.time_ and arg_254_1.time_ <= var_257_7 + arg_257_0 then
				arg_254_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_257_8 = 0
			local var_257_9 = 0.925

			if var_257_8 < arg_254_1.time_ and arg_254_1.time_ <= var_257_8 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, false)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_254_1.iconTrs_.gameObject, false)
				arg_254_1.callingController_:SetSelectedState("normal")

				local var_257_10 = arg_254_1:GetWordFromCfg(319671060)
				local var_257_11 = arg_254_1:FormatText(var_257_10.content)

				arg_254_1.text_.text = var_257_11

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_12 = 37
				local var_257_13 = utf8.len(var_257_11)
				local var_257_14 = var_257_12 <= 0 and var_257_9 or var_257_9 * (var_257_13 / var_257_12)

				if var_257_14 > 0 and var_257_9 < var_257_14 then
					arg_254_1.talkMaxDuration = var_257_14

					if var_257_14 + var_257_8 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_14 + var_257_8
					end
				end

				arg_254_1.text_.text = var_257_11
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)
				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_15 = math.max(var_257_9, arg_254_1.talkMaxDuration)

			if var_257_8 <= arg_254_1.time_ and arg_254_1.time_ < var_257_8 + var_257_15 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_8) / var_257_15

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_8 + var_257_15 and arg_254_1.time_ < var_257_8 + var_257_15 + arg_257_0 then
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
			local var_261_0 = arg_258_1.actors_["1084ui_story"].transform
			local var_261_1 = 0

			if var_261_1 < arg_258_1.time_ and arg_258_1.time_ <= var_261_1 + arg_261_0 then
				arg_258_1.var_.moveOldPos1084ui_story = var_261_0.localPosition
			end

			local var_261_2 = 0.001

			if var_261_1 <= arg_258_1.time_ and arg_258_1.time_ < var_261_1 + var_261_2 then
				local var_261_3 = (arg_258_1.time_ - var_261_1) / var_261_2
				local var_261_4 = Vector3.New(0.7, -0.97, -6)

				var_261_0.localPosition = Vector3.Lerp(arg_258_1.var_.moveOldPos1084ui_story, var_261_4, var_261_3)

				local var_261_5 = manager.ui.mainCamera.transform.position - var_261_0.position

				var_261_0.forward = Vector3.New(var_261_5.x, var_261_5.y, var_261_5.z)

				local var_261_6 = var_261_0.localEulerAngles

				var_261_6.z = 0
				var_261_6.x = 0
				var_261_0.localEulerAngles = var_261_6
			end

			if arg_258_1.time_ >= var_261_1 + var_261_2 and arg_258_1.time_ < var_261_1 + var_261_2 + arg_261_0 then
				var_261_0.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_261_7 = manager.ui.mainCamera.transform.position - var_261_0.position

				var_261_0.forward = Vector3.New(var_261_7.x, var_261_7.y, var_261_7.z)

				local var_261_8 = var_261_0.localEulerAngles

				var_261_8.z = 0
				var_261_8.x = 0
				var_261_0.localEulerAngles = var_261_8
			end

			local var_261_9 = arg_258_1.actors_["1084ui_story"]
			local var_261_10 = 0

			if var_261_10 < arg_258_1.time_ and arg_258_1.time_ <= var_261_10 + arg_261_0 and not isNil(var_261_9) and arg_258_1.var_.characterEffect1084ui_story == nil then
				arg_258_1.var_.characterEffect1084ui_story = var_261_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_261_11 = 0.200000002980232

			if var_261_10 <= arg_258_1.time_ and arg_258_1.time_ < var_261_10 + var_261_11 and not isNil(var_261_9) then
				local var_261_12 = (arg_258_1.time_ - var_261_10) / var_261_11

				if arg_258_1.var_.characterEffect1084ui_story and not isNil(var_261_9) then
					arg_258_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_258_1.time_ >= var_261_10 + var_261_11 and arg_258_1.time_ < var_261_10 + var_261_11 + arg_261_0 and not isNil(var_261_9) and arg_258_1.var_.characterEffect1084ui_story then
				arg_258_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_261_13 = 0
			local var_261_14 = 0.3

			if var_261_13 < arg_258_1.time_ and arg_258_1.time_ <= var_261_13 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				local var_261_15 = arg_258_1:FormatText(StoryNameCfg[6].name)

				arg_258_1.leftNameTxt_.text = var_261_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, false)
				arg_258_1.callingController_:SetSelectedState("normal")

				local var_261_16 = arg_258_1:GetWordFromCfg(319671061)
				local var_261_17 = arg_258_1:FormatText(var_261_16.content)

				arg_258_1.text_.text = var_261_17

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_18 = 12
				local var_261_19 = utf8.len(var_261_17)
				local var_261_20 = var_261_18 <= 0 and var_261_14 or var_261_14 * (var_261_19 / var_261_18)

				if var_261_20 > 0 and var_261_14 < var_261_20 then
					arg_258_1.talkMaxDuration = var_261_20

					if var_261_20 + var_261_13 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_20 + var_261_13
					end
				end

				arg_258_1.text_.text = var_261_17
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671061", "story_v_out_319671.awb") ~= 0 then
					local var_261_21 = manager.audio:GetVoiceLength("story_v_out_319671", "319671061", "story_v_out_319671.awb") / 1000

					if var_261_21 + var_261_13 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_21 + var_261_13
					end

					if var_261_16.prefab_name ~= "" and arg_258_1.actors_[var_261_16.prefab_name] ~= nil then
						local var_261_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_258_1.actors_[var_261_16.prefab_name].transform, "story_v_out_319671", "319671061", "story_v_out_319671.awb")

						arg_258_1:RecordAudio("319671061", var_261_22)
						arg_258_1:RecordAudio("319671061", var_261_22)
					else
						arg_258_1:AudioAction("play", "voice", "story_v_out_319671", "319671061", "story_v_out_319671.awb")
					end

					arg_258_1:RecordHistoryTalkVoice("story_v_out_319671", "319671061", "story_v_out_319671.awb")
				end

				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_23 = math.max(var_261_14, arg_258_1.talkMaxDuration)

			if var_261_13 <= arg_258_1.time_ and arg_258_1.time_ < var_261_13 + var_261_23 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_13) / var_261_23

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_13 + var_261_23 and arg_258_1.time_ < var_261_13 + var_261_23 + arg_261_0 then
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
			local var_265_0 = arg_262_1.actors_["1084ui_story"]
			local var_265_1 = 0

			if var_265_1 < arg_262_1.time_ and arg_262_1.time_ <= var_265_1 + arg_265_0 and not isNil(var_265_0) and arg_262_1.var_.characterEffect1084ui_story == nil then
				arg_262_1.var_.characterEffect1084ui_story = var_265_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_265_2 = 0.200000002980232

			if var_265_1 <= arg_262_1.time_ and arg_262_1.time_ < var_265_1 + var_265_2 and not isNil(var_265_0) then
				local var_265_3 = (arg_262_1.time_ - var_265_1) / var_265_2

				if arg_262_1.var_.characterEffect1084ui_story and not isNil(var_265_0) then
					local var_265_4 = Mathf.Lerp(0, 0.5, var_265_3)

					arg_262_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_262_1.var_.characterEffect1084ui_story.fillRatio = var_265_4
				end
			end

			if arg_262_1.time_ >= var_265_1 + var_265_2 and arg_262_1.time_ < var_265_1 + var_265_2 + arg_265_0 and not isNil(var_265_0) and arg_262_1.var_.characterEffect1084ui_story then
				local var_265_5 = 0.5

				arg_262_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_262_1.var_.characterEffect1084ui_story.fillRatio = var_265_5
			end

			local var_265_6 = arg_262_1.actors_["10014ui_story"]
			local var_265_7 = 0

			if var_265_7 < arg_262_1.time_ and arg_262_1.time_ <= var_265_7 + arg_265_0 and not isNil(var_265_6) and arg_262_1.var_.characterEffect10014ui_story == nil then
				arg_262_1.var_.characterEffect10014ui_story = var_265_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_265_8 = 0.200000002980232

			if var_265_7 <= arg_262_1.time_ and arg_262_1.time_ < var_265_7 + var_265_8 and not isNil(var_265_6) then
				local var_265_9 = (arg_262_1.time_ - var_265_7) / var_265_8

				if arg_262_1.var_.characterEffect10014ui_story and not isNil(var_265_6) then
					arg_262_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_262_1.time_ >= var_265_7 + var_265_8 and arg_262_1.time_ < var_265_7 + var_265_8 + arg_265_0 and not isNil(var_265_6) and arg_262_1.var_.characterEffect10014ui_story then
				arg_262_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_265_10 = 0
			local var_265_11 = 0.675

			if var_265_10 < arg_262_1.time_ and arg_262_1.time_ <= var_265_10 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, true)

				local var_265_12 = arg_262_1:FormatText(StoryNameCfg[264].name)

				arg_262_1.leftNameTxt_.text = var_265_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_262_1.leftNameTxt_.transform)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1.leftNameTxt_.text)
				SetActive(arg_262_1.iconTrs_.gameObject, false)
				arg_262_1.callingController_:SetSelectedState("normal")

				local var_265_13 = arg_262_1:GetWordFromCfg(319671062)
				local var_265_14 = arg_262_1:FormatText(var_265_13.content)

				arg_262_1.text_.text = var_265_14

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_15 = 27
				local var_265_16 = utf8.len(var_265_14)
				local var_265_17 = var_265_15 <= 0 and var_265_11 or var_265_11 * (var_265_16 / var_265_15)

				if var_265_17 > 0 and var_265_11 < var_265_17 then
					arg_262_1.talkMaxDuration = var_265_17

					if var_265_17 + var_265_10 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_17 + var_265_10
					end
				end

				arg_262_1.text_.text = var_265_14
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671062", "story_v_out_319671.awb") ~= 0 then
					local var_265_18 = manager.audio:GetVoiceLength("story_v_out_319671", "319671062", "story_v_out_319671.awb") / 1000

					if var_265_18 + var_265_10 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_18 + var_265_10
					end

					if var_265_13.prefab_name ~= "" and arg_262_1.actors_[var_265_13.prefab_name] ~= nil then
						local var_265_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_262_1.actors_[var_265_13.prefab_name].transform, "story_v_out_319671", "319671062", "story_v_out_319671.awb")

						arg_262_1:RecordAudio("319671062", var_265_19)
						arg_262_1:RecordAudio("319671062", var_265_19)
					else
						arg_262_1:AudioAction("play", "voice", "story_v_out_319671", "319671062", "story_v_out_319671.awb")
					end

					arg_262_1:RecordHistoryTalkVoice("story_v_out_319671", "319671062", "story_v_out_319671.awb")
				end

				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_20 = math.max(var_265_11, arg_262_1.talkMaxDuration)

			if var_265_10 <= arg_262_1.time_ and arg_262_1.time_ < var_265_10 + var_265_20 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_10) / var_265_20

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_10 + var_265_20 and arg_262_1.time_ < var_265_10 + var_265_20 + arg_265_0 then
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
			local var_269_0 = arg_266_1.actors_["10014ui_story"]
			local var_269_1 = 0

			if var_269_1 < arg_266_1.time_ and arg_266_1.time_ <= var_269_1 + arg_269_0 and not isNil(var_269_0) and arg_266_1.var_.characterEffect10014ui_story == nil then
				arg_266_1.var_.characterEffect10014ui_story = var_269_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_269_2 = 0.200000002980232

			if var_269_1 <= arg_266_1.time_ and arg_266_1.time_ < var_269_1 + var_269_2 and not isNil(var_269_0) then
				local var_269_3 = (arg_266_1.time_ - var_269_1) / var_269_2

				if arg_266_1.var_.characterEffect10014ui_story and not isNil(var_269_0) then
					local var_269_4 = Mathf.Lerp(0, 0.5, var_269_3)

					arg_266_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_266_1.var_.characterEffect10014ui_story.fillRatio = var_269_4
				end
			end

			if arg_266_1.time_ >= var_269_1 + var_269_2 and arg_266_1.time_ < var_269_1 + var_269_2 + arg_269_0 and not isNil(var_269_0) and arg_266_1.var_.characterEffect10014ui_story then
				local var_269_5 = 0.5

				arg_266_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_266_1.var_.characterEffect10014ui_story.fillRatio = var_269_5
			end

			local var_269_6 = 0

			if var_269_6 < arg_266_1.time_ and arg_266_1.time_ <= var_269_6 + arg_269_0 then
				arg_266_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2202cva")
			end

			local var_269_7 = 0
			local var_269_8 = 1.45

			if var_269_7 < arg_266_1.time_ and arg_266_1.time_ <= var_269_7 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, false)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_266_1.iconTrs_.gameObject, false)
				arg_266_1.callingController_:SetSelectedState("normal")

				local var_269_9 = arg_266_1:GetWordFromCfg(319671063)
				local var_269_10 = arg_266_1:FormatText(var_269_9.content)

				arg_266_1.text_.text = var_269_10

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_11 = 58
				local var_269_12 = utf8.len(var_269_10)
				local var_269_13 = var_269_11 <= 0 and var_269_8 or var_269_8 * (var_269_12 / var_269_11)

				if var_269_13 > 0 and var_269_8 < var_269_13 then
					arg_266_1.talkMaxDuration = var_269_13

					if var_269_13 + var_269_7 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_13 + var_269_7
					end
				end

				arg_266_1.text_.text = var_269_10
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)
				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_14 = math.max(var_269_8, arg_266_1.talkMaxDuration)

			if var_269_7 <= arg_266_1.time_ and arg_266_1.time_ < var_269_7 + var_269_14 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_7) / var_269_14

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_7 + var_269_14 and arg_266_1.time_ < var_269_7 + var_269_14 + arg_269_0 then
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
			local var_273_0 = 0

			if var_273_0 < arg_270_1.time_ and arg_270_1.time_ <= var_273_0 + arg_273_0 then
				local var_273_1 = arg_270_1.fswbg_.transform:Find("textbox/adapt/content") or arg_270_1.fswbg_.transform:Find("textbox/content")
				local var_273_2 = arg_270_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_273_3 = var_273_1:GetComponent("Text")
				local var_273_4 = var_273_1:GetComponent("RectTransform")

				var_273_3.alignment = UnityEngine.TextAnchor.LowerCenter
				var_273_4.offsetMin = Vector2.New(0, 0)
				var_273_4.offsetMax = Vector2.New(0, 0)
			end

			local var_273_5 = 0

			if var_273_5 < arg_270_1.time_ and arg_270_1.time_ <= var_273_5 + arg_273_0 then
				arg_270_1.fswbg_:SetActive(true)
				arg_270_1.dialog_:SetActive(false)

				arg_270_1.fswtw_.percent = 0

				local var_273_6 = arg_270_1:GetWordFromCfg(319671064)
				local var_273_7 = arg_270_1:FormatText(var_273_6.content)

				arg_270_1.fswt_.text = var_273_7

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.fswt_)

				arg_270_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_270_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_270_1.fswtw_:SetDirty()

				arg_270_1.typewritterCharCountI18N = 0

				SetActive(arg_270_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_270_1:ShowNextGo(false)
			end

			local var_273_8 = 0.566666666666668

			if var_273_8 < arg_270_1.time_ and arg_270_1.time_ <= var_273_8 + arg_273_0 then
				arg_270_1.var_.oldValueTypewriter = arg_270_1.fswtw_.percent

				SetActive(arg_270_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_270_1:ShowNextGo(false)
			end

			local var_273_9 = 24
			local var_273_10 = 1.6
			local var_273_11 = arg_270_1:GetWordFromCfg(319671064)
			local var_273_12 = arg_270_1:FormatText(var_273_11.content)
			local var_273_13, var_273_14 = arg_270_1:GetPercentByPara(var_273_12, 1)

			if var_273_8 < arg_270_1.time_ and arg_270_1.time_ <= var_273_8 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0

				local var_273_15 = var_273_9 <= 0 and var_273_10 or var_273_10 * ((var_273_14 - arg_270_1.typewritterCharCountI18N) / var_273_9)

				if var_273_15 > 0 and var_273_10 < var_273_15 then
					arg_270_1.talkMaxDuration = var_273_15

					if var_273_15 + var_273_8 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_15 + var_273_8
					end
				end
			end

			local var_273_16 = 1.6
			local var_273_17 = math.max(var_273_16, arg_270_1.talkMaxDuration)

			if var_273_8 <= arg_270_1.time_ and arg_270_1.time_ < var_273_8 + var_273_17 then
				local var_273_18 = (arg_270_1.time_ - var_273_8) / var_273_17

				arg_270_1.fswtw_.percent = Mathf.Lerp(arg_270_1.var_.oldValueTypewriter, var_273_13, var_273_18)
				arg_270_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_270_1.fswtw_:SetDirty()
			end

			if arg_270_1.time_ >= var_273_8 + var_273_17 and arg_270_1.time_ < var_273_8 + var_273_17 + arg_273_0 then
				arg_270_1.fswtw_.percent = var_273_13

				arg_270_1.fswtw_:SetDirty()
				arg_270_1:ShowNextGo(true)

				arg_270_1.typewritterCharCountI18N = var_273_14
			end

			local var_273_19 = 0

			if var_273_19 < arg_270_1.time_ and arg_270_1.time_ <= var_273_19 + arg_273_0 then
				arg_270_1.cswbg_:SetActive(true)

				local var_273_20 = arg_270_1.cswt_:GetComponent("RectTransform")

				arg_270_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_273_20.offsetMin = Vector2.New(410, 330)
				var_273_20.offsetMax = Vector2.New(-400, -175)

				local var_273_21 = arg_270_1:GetWordFromCfg(419038)
				local var_273_22 = arg_270_1:FormatText(var_273_21.content)

				arg_270_1.cswt_.text = var_273_22

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.cswt_)

				arg_270_1.cswt_.fontSize = 180
				arg_270_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_270_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_270_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			local var_273_23 = 0

			if var_273_23 < arg_270_1.time_ and arg_270_1.time_ <= var_273_23 + arg_273_0 then
				local var_273_24 = manager.ui.mainCamera.transform.localPosition
				local var_273_25 = Vector3.New(0, 0, 10) + Vector3.New(var_273_24.x, var_273_24.y, 0)
				local var_273_26 = arg_270_1.bgs_.STblack

				var_273_26.transform.localPosition = var_273_25
				var_273_26.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_273_27 = var_273_26:GetComponent("SpriteRenderer")

				if var_273_27 and var_273_27.sprite then
					local var_273_28 = (var_273_26.transform.localPosition - var_273_24).z
					local var_273_29 = manager.ui.mainCameraCom_
					local var_273_30 = 2 * var_273_28 * Mathf.Tan(var_273_29.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_273_31 = var_273_30 * var_273_29.aspect
					local var_273_32 = var_273_27.sprite.bounds.size.x
					local var_273_33 = var_273_27.sprite.bounds.size.y
					local var_273_34 = var_273_31 / var_273_32
					local var_273_35 = var_273_30 / var_273_33
					local var_273_36 = var_273_35 < var_273_34 and var_273_34 or var_273_35

					var_273_26.transform.localScale = Vector3.New(var_273_36, var_273_36, 0)
				end

				for iter_273_0, iter_273_1 in pairs(arg_270_1.bgs_) do
					if iter_273_0 ~= "STblack" then
						iter_273_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_273_37 = 0

			if var_273_37 < arg_270_1.time_ and arg_270_1.time_ <= var_273_37 + arg_273_0 then
				arg_270_1.mask_.enabled = true
				arg_270_1.mask_.raycastTarget = true

				arg_270_1:SetGaussion(false)
			end

			local var_273_38 = 1.2

			if var_273_37 <= arg_270_1.time_ and arg_270_1.time_ < var_273_37 + var_273_38 then
				local var_273_39 = (arg_270_1.time_ - var_273_37) / var_273_38
				local var_273_40 = Color.New(0, 0, 0)

				var_273_40.a = Mathf.Lerp(1, 0, var_273_39)
				arg_270_1.mask_.color = var_273_40
			end

			if arg_270_1.time_ >= var_273_37 + var_273_38 and arg_270_1.time_ < var_273_37 + var_273_38 + arg_273_0 then
				local var_273_41 = Color.New(0, 0, 0)
				local var_273_42 = 0

				arg_270_1.mask_.enabled = false
				var_273_41.a = var_273_42
				arg_270_1.mask_.color = var_273_41
			end

			local var_273_43 = arg_270_1.actors_["10014ui_story"].transform
			local var_273_44 = 0

			if var_273_44 < arg_270_1.time_ and arg_270_1.time_ <= var_273_44 + arg_273_0 then
				arg_270_1.var_.moveOldPos10014ui_story = var_273_43.localPosition
			end

			local var_273_45 = 0.001

			if var_273_44 <= arg_270_1.time_ and arg_270_1.time_ < var_273_44 + var_273_45 then
				local var_273_46 = (arg_270_1.time_ - var_273_44) / var_273_45
				local var_273_47 = Vector3.New(0, 100, 0)

				var_273_43.localPosition = Vector3.Lerp(arg_270_1.var_.moveOldPos10014ui_story, var_273_47, var_273_46)

				local var_273_48 = manager.ui.mainCamera.transform.position - var_273_43.position

				var_273_43.forward = Vector3.New(var_273_48.x, var_273_48.y, var_273_48.z)

				local var_273_49 = var_273_43.localEulerAngles

				var_273_49.z = 0
				var_273_49.x = 0
				var_273_43.localEulerAngles = var_273_49
			end

			if arg_270_1.time_ >= var_273_44 + var_273_45 and arg_270_1.time_ < var_273_44 + var_273_45 + arg_273_0 then
				var_273_43.localPosition = Vector3.New(0, 100, 0)

				local var_273_50 = manager.ui.mainCamera.transform.position - var_273_43.position

				var_273_43.forward = Vector3.New(var_273_50.x, var_273_50.y, var_273_50.z)

				local var_273_51 = var_273_43.localEulerAngles

				var_273_51.z = 0
				var_273_51.x = 0
				var_273_43.localEulerAngles = var_273_51
			end

			local var_273_52 = arg_270_1.actors_["1084ui_story"].transform
			local var_273_53 = 0

			if var_273_53 < arg_270_1.time_ and arg_270_1.time_ <= var_273_53 + arg_273_0 then
				arg_270_1.var_.moveOldPos1084ui_story = var_273_52.localPosition
			end

			local var_273_54 = 0.001

			if var_273_53 <= arg_270_1.time_ and arg_270_1.time_ < var_273_53 + var_273_54 then
				local var_273_55 = (arg_270_1.time_ - var_273_53) / var_273_54
				local var_273_56 = Vector3.New(0, 100, 0)

				var_273_52.localPosition = Vector3.Lerp(arg_270_1.var_.moveOldPos1084ui_story, var_273_56, var_273_55)

				local var_273_57 = manager.ui.mainCamera.transform.position - var_273_52.position

				var_273_52.forward = Vector3.New(var_273_57.x, var_273_57.y, var_273_57.z)

				local var_273_58 = var_273_52.localEulerAngles

				var_273_58.z = 0
				var_273_58.x = 0
				var_273_52.localEulerAngles = var_273_58
			end

			if arg_270_1.time_ >= var_273_53 + var_273_54 and arg_270_1.time_ < var_273_53 + var_273_54 + arg_273_0 then
				var_273_52.localPosition = Vector3.New(0, 100, 0)

				local var_273_59 = manager.ui.mainCamera.transform.position - var_273_52.position

				var_273_52.forward = Vector3.New(var_273_59.x, var_273_59.y, var_273_59.z)

				local var_273_60 = var_273_52.localEulerAngles

				var_273_60.z = 0
				var_273_60.x = 0
				var_273_52.localEulerAngles = var_273_60
			end

			local var_273_61 = arg_270_1.actors_["10014ui_story"]
			local var_273_62 = 0

			if var_273_62 < arg_270_1.time_ and arg_270_1.time_ <= var_273_62 + arg_273_0 then
				if arg_270_1.var_.characterEffect10014ui_story == nil then
					arg_270_1.var_.characterEffect10014ui_story = var_273_61:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_273_63 = arg_270_1.var_.characterEffect10014ui_story

				var_273_63.imageEffect:turnOff()

				var_273_63.interferenceEffect.enabled = false
				var_273_63.interferenceEffect.noise = 0.001
				var_273_63.interferenceEffect.simTimeScale = 1
				var_273_63.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_273_64 = arg_270_1.actors_["10014ui_story"]
			local var_273_65 = 0
			local var_273_66 = 0.266666666666667

			if var_273_65 < arg_270_1.time_ and arg_270_1.time_ <= var_273_65 + arg_273_0 then
				if arg_270_1.var_.characterEffect10014ui_story == nil then
					arg_270_1.var_.characterEffect10014ui_story = var_273_64:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_270_1.var_.characterEffect10014ui_story.imageEffect:turnOff()
			end

			local var_273_67 = 0.566666666666667
			local var_273_68 = 5.366
			local var_273_69 = manager.audio:GetVoiceLength("story_v_out_319671", "319671064", "story_v_out_319671.awb") / 1000

			if var_273_69 > 0 and var_273_68 < var_273_69 and var_273_69 + var_273_67 > arg_270_1.duration_ then
				local var_273_70 = var_273_69

				arg_270_1.duration_ = var_273_69 + var_273_67
			end

			if var_273_67 < arg_270_1.time_ and arg_270_1.time_ <= var_273_67 + arg_273_0 then
				local var_273_71 = "play"
				local var_273_72 = "voice"

				arg_270_1:AudioAction(var_273_71, var_273_72, "story_v_out_319671", "319671064", "story_v_out_319671.awb")
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
			local var_277_0 = 0

			if var_277_0 < arg_274_1.time_ and arg_274_1.time_ <= var_277_0 + arg_277_0 then
				arg_274_1.fswbg_:SetActive(true)
				arg_274_1.dialog_:SetActive(false)

				arg_274_1.fswtw_.percent = 0

				local var_277_1 = arg_274_1:GetWordFromCfg(319671065)
				local var_277_2 = arg_274_1:FormatText(var_277_1.content)

				arg_274_1.fswt_.text = var_277_2

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.fswt_)

				arg_274_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_274_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_274_1.fswtw_:SetDirty()

				arg_274_1.typewritterCharCountI18N = 0

				SetActive(arg_274_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_274_1:ShowNextGo(false)
			end

			local var_277_3 = 0.366666666666667

			if var_277_3 < arg_274_1.time_ and arg_274_1.time_ <= var_277_3 + arg_277_0 then
				arg_274_1.var_.oldValueTypewriter = arg_274_1.fswtw_.percent

				SetActive(arg_274_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_274_1:ShowNextGo(false)
			end

			local var_277_4 = 14
			local var_277_5 = 0.933333333333333
			local var_277_6 = arg_274_1:GetWordFromCfg(319671065)
			local var_277_7 = arg_274_1:FormatText(var_277_6.content)
			local var_277_8, var_277_9 = arg_274_1:GetPercentByPara(var_277_7, 1)

			if var_277_3 < arg_274_1.time_ and arg_274_1.time_ <= var_277_3 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0

				local var_277_10 = var_277_4 <= 0 and var_277_5 or var_277_5 * ((var_277_9 - arg_274_1.typewritterCharCountI18N) / var_277_4)

				if var_277_10 > 0 and var_277_5 < var_277_10 then
					arg_274_1.talkMaxDuration = var_277_10

					if var_277_10 + var_277_3 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_10 + var_277_3
					end
				end
			end

			local var_277_11 = 0.933333333333333
			local var_277_12 = math.max(var_277_11, arg_274_1.talkMaxDuration)

			if var_277_3 <= arg_274_1.time_ and arg_274_1.time_ < var_277_3 + var_277_12 then
				local var_277_13 = (arg_274_1.time_ - var_277_3) / var_277_12

				arg_274_1.fswtw_.percent = Mathf.Lerp(arg_274_1.var_.oldValueTypewriter, var_277_8, var_277_13)
				arg_274_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_274_1.fswtw_:SetDirty()
			end

			if arg_274_1.time_ >= var_277_3 + var_277_12 and arg_274_1.time_ < var_277_3 + var_277_12 + arg_277_0 then
				arg_274_1.fswtw_.percent = var_277_8

				arg_274_1.fswtw_:SetDirty()
				arg_274_1:ShowNextGo(true)

				arg_274_1.typewritterCharCountI18N = var_277_9
			end

			local var_277_14 = 0.3
			local var_277_15 = 2.933
			local var_277_16 = manager.audio:GetVoiceLength("story_v_out_319671", "319671065", "story_v_out_319671.awb") / 1000

			if var_277_16 > 0 and var_277_15 < var_277_16 and var_277_16 + var_277_14 > arg_274_1.duration_ then
				local var_277_17 = var_277_16

				arg_274_1.duration_ = var_277_16 + var_277_14
			end

			if var_277_14 < arg_274_1.time_ and arg_274_1.time_ <= var_277_14 + arg_277_0 then
				local var_277_18 = "play"
				local var_277_19 = "voice"

				arg_274_1:AudioAction(var_277_18, var_277_19, "story_v_out_319671", "319671065", "story_v_out_319671.awb")
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
			local var_281_0 = 0

			if var_281_0 < arg_278_1.time_ and arg_278_1.time_ <= var_281_0 + arg_281_0 then
				arg_278_1.fswbg_:SetActive(true)
				arg_278_1.dialog_:SetActive(false)

				arg_278_1.fswtw_.percent = 0

				local var_281_1 = arg_278_1:GetWordFromCfg(319671066)
				local var_281_2 = arg_278_1:FormatText(var_281_1.content)

				arg_278_1.fswt_.text = var_281_2

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.fswt_)

				arg_278_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_278_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_278_1.fswtw_:SetDirty()

				arg_278_1.typewritterCharCountI18N = 0

				SetActive(arg_278_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_278_1:ShowNextGo(false)
			end

			local var_281_3 = 0.266666666666667

			if var_281_3 < arg_278_1.time_ and arg_278_1.time_ <= var_281_3 + arg_281_0 then
				arg_278_1.var_.oldValueTypewriter = arg_278_1.fswtw_.percent

				SetActive(arg_278_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_278_1:ShowNextGo(false)
			end

			local var_281_4 = 19
			local var_281_5 = 1.26666666666667
			local var_281_6 = arg_278_1:GetWordFromCfg(319671066)
			local var_281_7 = arg_278_1:FormatText(var_281_6.content)
			local var_281_8, var_281_9 = arg_278_1:GetPercentByPara(var_281_7, 1)

			if var_281_3 < arg_278_1.time_ and arg_278_1.time_ <= var_281_3 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0

				local var_281_10 = var_281_4 <= 0 and var_281_5 or var_281_5 * ((var_281_9 - arg_278_1.typewritterCharCountI18N) / var_281_4)

				if var_281_10 > 0 and var_281_5 < var_281_10 then
					arg_278_1.talkMaxDuration = var_281_10

					if var_281_10 + var_281_3 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_10 + var_281_3
					end
				end
			end

			local var_281_11 = 1.26666666666667
			local var_281_12 = math.max(var_281_11, arg_278_1.talkMaxDuration)

			if var_281_3 <= arg_278_1.time_ and arg_278_1.time_ < var_281_3 + var_281_12 then
				local var_281_13 = (arg_278_1.time_ - var_281_3) / var_281_12

				arg_278_1.fswtw_.percent = Mathf.Lerp(arg_278_1.var_.oldValueTypewriter, var_281_8, var_281_13)
				arg_278_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_278_1.fswtw_:SetDirty()
			end

			if arg_278_1.time_ >= var_281_3 + var_281_12 and arg_278_1.time_ < var_281_3 + var_281_12 + arg_281_0 then
				arg_278_1.fswtw_.percent = var_281_8

				arg_278_1.fswtw_:SetDirty()
				arg_278_1:ShowNextGo(true)

				arg_278_1.typewritterCharCountI18N = var_281_9
			end

			local var_281_14 = 0.266666666666667
			local var_281_15 = 4.433
			local var_281_16 = manager.audio:GetVoiceLength("story_v_out_319671", "319671066", "story_v_out_319671.awb") / 1000

			if var_281_16 > 0 and var_281_15 < var_281_16 and var_281_16 + var_281_14 > arg_278_1.duration_ then
				local var_281_17 = var_281_16

				arg_278_1.duration_ = var_281_16 + var_281_14
			end

			if var_281_14 < arg_278_1.time_ and arg_278_1.time_ <= var_281_14 + arg_281_0 then
				local var_281_18 = "play"
				local var_281_19 = "voice"

				arg_278_1:AudioAction(var_281_18, var_281_19, "story_v_out_319671", "319671066", "story_v_out_319671.awb")
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
			local var_285_0 = 0

			if var_285_0 < arg_282_1.time_ and arg_282_1.time_ <= var_285_0 + arg_285_0 then
				local var_285_1 = manager.ui.mainCamera.transform.localPosition
				local var_285_2 = Vector3.New(0, 0, 10) + Vector3.New(var_285_1.x, var_285_1.y, 0)
				local var_285_3 = arg_282_1.bgs_.ST69

				var_285_3.transform.localPosition = var_285_2
				var_285_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_285_4 = var_285_3:GetComponent("SpriteRenderer")

				if var_285_4 and var_285_4.sprite then
					local var_285_5 = (var_285_3.transform.localPosition - var_285_1).z
					local var_285_6 = manager.ui.mainCameraCom_
					local var_285_7 = 2 * var_285_5 * Mathf.Tan(var_285_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_285_8 = var_285_7 * var_285_6.aspect
					local var_285_9 = var_285_4.sprite.bounds.size.x
					local var_285_10 = var_285_4.sprite.bounds.size.y
					local var_285_11 = var_285_8 / var_285_9
					local var_285_12 = var_285_7 / var_285_10
					local var_285_13 = var_285_12 < var_285_11 and var_285_11 or var_285_12

					var_285_3.transform.localScale = Vector3.New(var_285_13, var_285_13, 0)
				end

				for iter_285_0, iter_285_1 in pairs(arg_282_1.bgs_) do
					if iter_285_0 ~= "ST69" then
						iter_285_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_285_14 = arg_282_1.actors_["10014ui_story"].transform
			local var_285_15 = 0

			if var_285_15 < arg_282_1.time_ and arg_282_1.time_ <= var_285_15 + arg_285_0 then
				arg_282_1.var_.moveOldPos10014ui_story = var_285_14.localPosition
			end

			local var_285_16 = 0.001

			if var_285_15 <= arg_282_1.time_ and arg_282_1.time_ < var_285_15 + var_285_16 then
				local var_285_17 = (arg_282_1.time_ - var_285_15) / var_285_16
				local var_285_18 = Vector3.New(0, -1.06, -6.2)

				var_285_14.localPosition = Vector3.Lerp(arg_282_1.var_.moveOldPos10014ui_story, var_285_18, var_285_17)

				local var_285_19 = manager.ui.mainCamera.transform.position - var_285_14.position

				var_285_14.forward = Vector3.New(var_285_19.x, var_285_19.y, var_285_19.z)

				local var_285_20 = var_285_14.localEulerAngles

				var_285_20.z = 0
				var_285_20.x = 0
				var_285_14.localEulerAngles = var_285_20
			end

			if arg_282_1.time_ >= var_285_15 + var_285_16 and arg_282_1.time_ < var_285_15 + var_285_16 + arg_285_0 then
				var_285_14.localPosition = Vector3.New(0, -1.06, -6.2)

				local var_285_21 = manager.ui.mainCamera.transform.position - var_285_14.position

				var_285_14.forward = Vector3.New(var_285_21.x, var_285_21.y, var_285_21.z)

				local var_285_22 = var_285_14.localEulerAngles

				var_285_22.z = 0
				var_285_22.x = 0
				var_285_14.localEulerAngles = var_285_22
			end

			local var_285_23 = 0

			if var_285_23 < arg_282_1.time_ and arg_282_1.time_ <= var_285_23 + arg_285_0 then
				arg_282_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_285_24 = 0

			if var_285_24 < arg_282_1.time_ and arg_282_1.time_ <= var_285_24 + arg_285_0 then
				arg_282_1.fswbg_:SetActive(false)
				arg_282_1.dialog_:SetActive(false)
				SetActive(arg_282_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_282_1:ShowNextGo(false)
			end

			local var_285_25 = 0.0333333333333334

			if var_285_25 < arg_282_1.time_ and arg_282_1.time_ <= var_285_25 + arg_285_0 then
				arg_282_1.fswbg_:SetActive(false)
				arg_282_1.dialog_:SetActive(false)
				SetActive(arg_282_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_282_1:ShowNextGo(false)
			end

			local var_285_26 = 0

			if var_285_26 < arg_282_1.time_ and arg_282_1.time_ <= var_285_26 + arg_285_0 then
				arg_282_1.cswbg_:SetActive(false)
			end

			local var_285_27 = arg_282_1.actors_["10014ui_story"]
			local var_285_28 = 0.0340000018477441

			if var_285_28 < arg_282_1.time_ and arg_282_1.time_ <= var_285_28 + arg_285_0 and not isNil(var_285_27) and arg_282_1.var_.characterEffect10014ui_story == nil then
				arg_282_1.var_.characterEffect10014ui_story = var_285_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_285_29 = 0.2

			if var_285_28 <= arg_282_1.time_ and arg_282_1.time_ < var_285_28 + var_285_29 and not isNil(var_285_27) then
				local var_285_30 = (arg_282_1.time_ - var_285_28) / var_285_29

				if arg_282_1.var_.characterEffect10014ui_story and not isNil(var_285_27) then
					arg_282_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_282_1.time_ >= var_285_28 + var_285_29 and arg_282_1.time_ < var_285_28 + var_285_29 + arg_285_0 and not isNil(var_285_27) and arg_282_1.var_.characterEffect10014ui_story then
				arg_282_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_285_31 = arg_282_1.actors_["10014ui_story"]
			local var_285_32 = 0.0340000018477441

			if var_285_32 < arg_282_1.time_ and arg_282_1.time_ <= var_285_32 + arg_285_0 then
				if arg_282_1.var_.characterEffect10014ui_story == nil then
					arg_282_1.var_.characterEffect10014ui_story = var_285_31:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_285_33 = arg_282_1.var_.characterEffect10014ui_story

				var_285_33.imageEffect:turnOff()

				var_285_33.interferenceEffect.enabled = true
				var_285_33.interferenceEffect.noise = 0.001
				var_285_33.interferenceEffect.simTimeScale = 1
				var_285_33.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_285_34 = arg_282_1.actors_["10014ui_story"]
			local var_285_35 = 0.0340000018477441
			local var_285_36 = 0.266666666666667

			if var_285_35 < arg_282_1.time_ and arg_282_1.time_ <= var_285_35 + arg_285_0 then
				if arg_282_1.var_.characterEffect10014ui_story == nil then
					arg_282_1.var_.characterEffect10014ui_story = var_285_34:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_282_1.var_.characterEffect10014ui_story.imageEffect:turnOn(false)
			end

			if arg_282_1.frameCnt_ <= 1 then
				arg_282_1.dialog_:SetActive(false)
			end

			local var_285_37 = 0.300666668514411
			local var_285_38 = 0.925

			if var_285_37 < arg_282_1.time_ and arg_282_1.time_ <= var_285_37 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0

				arg_282_1.dialog_:SetActive(true)

				arg_282_1.dialogCg_.alpha = 0

				local var_285_39 = LeanTween.value(arg_282_1.dialog_, 0, 1, 0.3)

				var_285_39:setOnUpdate(LuaHelper.FloatAction(function(arg_286_0)
					arg_282_1.dialogCg_.alpha = arg_286_0
				end))
				var_285_39:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_282_1.dialog_)
					var_285_39:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_282_1.duration_ = arg_282_1.duration_ + 0.3

				SetActive(arg_282_1.leftNameGo_, true)

				local var_285_40 = arg_282_1:FormatText(StoryNameCfg[264].name)

				arg_282_1.leftNameTxt_.text = var_285_40

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_282_1.leftNameTxt_.transform)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1.leftNameTxt_.text)
				SetActive(arg_282_1.iconTrs_.gameObject, false)
				arg_282_1.callingController_:SetSelectedState("normal")

				local var_285_41 = arg_282_1:GetWordFromCfg(319671067)
				local var_285_42 = arg_282_1:FormatText(var_285_41.content)

				arg_282_1.text_.text = var_285_42

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_43 = 37
				local var_285_44 = utf8.len(var_285_42)
				local var_285_45 = var_285_43 <= 0 and var_285_38 or var_285_38 * (var_285_44 / var_285_43)

				if var_285_45 > 0 and var_285_38 < var_285_45 then
					arg_282_1.talkMaxDuration = var_285_45
					var_285_37 = var_285_37 + 0.3

					if var_285_45 + var_285_37 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_45 + var_285_37
					end
				end

				arg_282_1.text_.text = var_285_42
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671067", "story_v_out_319671.awb") ~= 0 then
					local var_285_46 = manager.audio:GetVoiceLength("story_v_out_319671", "319671067", "story_v_out_319671.awb") / 1000

					if var_285_46 + var_285_37 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_46 + var_285_37
					end

					if var_285_41.prefab_name ~= "" and arg_282_1.actors_[var_285_41.prefab_name] ~= nil then
						local var_285_47 = LuaForUtil.PlayVoiceWithCriLipsync(arg_282_1.actors_[var_285_41.prefab_name].transform, "story_v_out_319671", "319671067", "story_v_out_319671.awb")

						arg_282_1:RecordAudio("319671067", var_285_47)
						arg_282_1:RecordAudio("319671067", var_285_47)
					else
						arg_282_1:AudioAction("play", "voice", "story_v_out_319671", "319671067", "story_v_out_319671.awb")
					end

					arg_282_1:RecordHistoryTalkVoice("story_v_out_319671", "319671067", "story_v_out_319671.awb")
				end

				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_48 = var_285_37 + 0.3
			local var_285_49 = math.max(var_285_38, arg_282_1.talkMaxDuration)

			if var_285_48 <= arg_282_1.time_ and arg_282_1.time_ < var_285_48 + var_285_49 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - var_285_48) / var_285_49

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= var_285_48 + var_285_49 and arg_282_1.time_ < var_285_48 + var_285_49 + arg_285_0 then
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
			local var_291_0 = arg_288_1.actors_["10014ui_story"]
			local var_291_1 = 0

			if var_291_1 < arg_288_1.time_ and arg_288_1.time_ <= var_291_1 + arg_291_0 and not isNil(var_291_0) and arg_288_1.var_.characterEffect10014ui_story == nil then
				arg_288_1.var_.characterEffect10014ui_story = var_291_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_291_2 = 0.200000002980232

			if var_291_1 <= arg_288_1.time_ and arg_288_1.time_ < var_291_1 + var_291_2 and not isNil(var_291_0) then
				local var_291_3 = (arg_288_1.time_ - var_291_1) / var_291_2

				if arg_288_1.var_.characterEffect10014ui_story and not isNil(var_291_0) then
					local var_291_4 = Mathf.Lerp(0, 0.5, var_291_3)

					arg_288_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_288_1.var_.characterEffect10014ui_story.fillRatio = var_291_4
				end
			end

			if arg_288_1.time_ >= var_291_1 + var_291_2 and arg_288_1.time_ < var_291_1 + var_291_2 + arg_291_0 and not isNil(var_291_0) and arg_288_1.var_.characterEffect10014ui_story then
				local var_291_5 = 0.5

				arg_288_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_288_1.var_.characterEffect10014ui_story.fillRatio = var_291_5
			end

			local var_291_6 = arg_288_1.actors_["1084ui_story"]
			local var_291_7 = 0

			if var_291_7 < arg_288_1.time_ and arg_288_1.time_ <= var_291_7 + arg_291_0 and not isNil(var_291_6) and arg_288_1.var_.characterEffect1084ui_story == nil then
				arg_288_1.var_.characterEffect1084ui_story = var_291_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_291_8 = 0.200000002980232

			if var_291_7 <= arg_288_1.time_ and arg_288_1.time_ < var_291_7 + var_291_8 and not isNil(var_291_6) then
				local var_291_9 = (arg_288_1.time_ - var_291_7) / var_291_8

				if arg_288_1.var_.characterEffect1084ui_story and not isNil(var_291_6) then
					arg_288_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_288_1.time_ >= var_291_7 + var_291_8 and arg_288_1.time_ < var_291_7 + var_291_8 + arg_291_0 and not isNil(var_291_6) and arg_288_1.var_.characterEffect1084ui_story then
				arg_288_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_291_10 = arg_288_1.actors_["1084ui_story"].transform
			local var_291_11 = 0

			if var_291_11 < arg_288_1.time_ and arg_288_1.time_ <= var_291_11 + arg_291_0 then
				arg_288_1.var_.moveOldPos1084ui_story = var_291_10.localPosition
			end

			local var_291_12 = 0.001

			if var_291_11 <= arg_288_1.time_ and arg_288_1.time_ < var_291_11 + var_291_12 then
				local var_291_13 = (arg_288_1.time_ - var_291_11) / var_291_12
				local var_291_14 = Vector3.New(0.7, -0.97, -6)

				var_291_10.localPosition = Vector3.Lerp(arg_288_1.var_.moveOldPos1084ui_story, var_291_14, var_291_13)

				local var_291_15 = manager.ui.mainCamera.transform.position - var_291_10.position

				var_291_10.forward = Vector3.New(var_291_15.x, var_291_15.y, var_291_15.z)

				local var_291_16 = var_291_10.localEulerAngles

				var_291_16.z = 0
				var_291_16.x = 0
				var_291_10.localEulerAngles = var_291_16
			end

			if arg_288_1.time_ >= var_291_11 + var_291_12 and arg_288_1.time_ < var_291_11 + var_291_12 + arg_291_0 then
				var_291_10.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_291_17 = manager.ui.mainCamera.transform.position - var_291_10.position

				var_291_10.forward = Vector3.New(var_291_17.x, var_291_17.y, var_291_17.z)

				local var_291_18 = var_291_10.localEulerAngles

				var_291_18.z = 0
				var_291_18.x = 0
				var_291_10.localEulerAngles = var_291_18
			end

			local var_291_19 = arg_288_1.actors_["10014ui_story"].transform
			local var_291_20 = 0

			if var_291_20 < arg_288_1.time_ and arg_288_1.time_ <= var_291_20 + arg_291_0 then
				arg_288_1.var_.moveOldPos10014ui_story = var_291_19.localPosition
			end

			local var_291_21 = 0.001

			if var_291_20 <= arg_288_1.time_ and arg_288_1.time_ < var_291_20 + var_291_21 then
				local var_291_22 = (arg_288_1.time_ - var_291_20) / var_291_21
				local var_291_23 = Vector3.New(-0.7, -1.06, -6.2)

				var_291_19.localPosition = Vector3.Lerp(arg_288_1.var_.moveOldPos10014ui_story, var_291_23, var_291_22)

				local var_291_24 = manager.ui.mainCamera.transform.position - var_291_19.position

				var_291_19.forward = Vector3.New(var_291_24.x, var_291_24.y, var_291_24.z)

				local var_291_25 = var_291_19.localEulerAngles

				var_291_25.z = 0
				var_291_25.x = 0
				var_291_19.localEulerAngles = var_291_25
			end

			if arg_288_1.time_ >= var_291_20 + var_291_21 and arg_288_1.time_ < var_291_20 + var_291_21 + arg_291_0 then
				var_291_19.localPosition = Vector3.New(-0.7, -1.06, -6.2)

				local var_291_26 = manager.ui.mainCamera.transform.position - var_291_19.position

				var_291_19.forward = Vector3.New(var_291_26.x, var_291_26.y, var_291_26.z)

				local var_291_27 = var_291_19.localEulerAngles

				var_291_27.z = 0
				var_291_27.x = 0
				var_291_19.localEulerAngles = var_291_27
			end

			local var_291_28 = 0
			local var_291_29 = 0.425

			if var_291_28 < arg_288_1.time_ and arg_288_1.time_ <= var_291_28 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0
				arg_288_1.dialogCg_.alpha = 1

				arg_288_1.dialog_:SetActive(true)
				SetActive(arg_288_1.leftNameGo_, true)

				local var_291_30 = arg_288_1:FormatText(StoryNameCfg[6].name)

				arg_288_1.leftNameTxt_.text = var_291_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_288_1.leftNameTxt_.transform)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1.leftNameTxt_.text)
				SetActive(arg_288_1.iconTrs_.gameObject, false)
				arg_288_1.callingController_:SetSelectedState("normal")

				local var_291_31 = arg_288_1:GetWordFromCfg(319671068)
				local var_291_32 = arg_288_1:FormatText(var_291_31.content)

				arg_288_1.text_.text = var_291_32

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_33 = 17
				local var_291_34 = utf8.len(var_291_32)
				local var_291_35 = var_291_33 <= 0 and var_291_29 or var_291_29 * (var_291_34 / var_291_33)

				if var_291_35 > 0 and var_291_29 < var_291_35 then
					arg_288_1.talkMaxDuration = var_291_35

					if var_291_35 + var_291_28 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_35 + var_291_28
					end
				end

				arg_288_1.text_.text = var_291_32
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671068", "story_v_out_319671.awb") ~= 0 then
					local var_291_36 = manager.audio:GetVoiceLength("story_v_out_319671", "319671068", "story_v_out_319671.awb") / 1000

					if var_291_36 + var_291_28 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_36 + var_291_28
					end

					if var_291_31.prefab_name ~= "" and arg_288_1.actors_[var_291_31.prefab_name] ~= nil then
						local var_291_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_288_1.actors_[var_291_31.prefab_name].transform, "story_v_out_319671", "319671068", "story_v_out_319671.awb")

						arg_288_1:RecordAudio("319671068", var_291_37)
						arg_288_1:RecordAudio("319671068", var_291_37)
					else
						arg_288_1:AudioAction("play", "voice", "story_v_out_319671", "319671068", "story_v_out_319671.awb")
					end

					arg_288_1:RecordHistoryTalkVoice("story_v_out_319671", "319671068", "story_v_out_319671.awb")
				end

				arg_288_1:RecordContent(arg_288_1.text_.text)
			end

			local var_291_38 = math.max(var_291_29, arg_288_1.talkMaxDuration)

			if var_291_28 <= arg_288_1.time_ and arg_288_1.time_ < var_291_28 + var_291_38 then
				arg_288_1.typewritter.percent = (arg_288_1.time_ - var_291_28) / var_291_38

				arg_288_1.typewritter:SetDirty()
			end

			if arg_288_1.time_ >= var_291_28 + var_291_38 and arg_288_1.time_ < var_291_28 + var_291_38 + arg_291_0 then
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
			local var_295_0 = 0

			if var_295_0 < arg_292_1.time_ and arg_292_1.time_ <= var_295_0 + arg_295_0 then
				arg_292_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_1")
			end

			local var_295_1 = 0

			if var_295_1 < arg_292_1.time_ and arg_292_1.time_ <= var_295_1 + arg_295_0 then
				arg_292_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_295_2 = 0
			local var_295_3 = 1.075

			if var_295_2 < arg_292_1.time_ and arg_292_1.time_ <= var_295_2 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0
				arg_292_1.dialogCg_.alpha = 1

				arg_292_1.dialog_:SetActive(true)
				SetActive(arg_292_1.leftNameGo_, true)

				local var_295_4 = arg_292_1:FormatText(StoryNameCfg[6].name)

				arg_292_1.leftNameTxt_.text = var_295_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_292_1.leftNameTxt_.transform)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1.leftNameTxt_.text)
				SetActive(arg_292_1.iconTrs_.gameObject, false)
				arg_292_1.callingController_:SetSelectedState("normal")

				local var_295_5 = arg_292_1:GetWordFromCfg(319671069)
				local var_295_6 = arg_292_1:FormatText(var_295_5.content)

				arg_292_1.text_.text = var_295_6

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_7 = 43
				local var_295_8 = utf8.len(var_295_6)
				local var_295_9 = var_295_7 <= 0 and var_295_3 or var_295_3 * (var_295_8 / var_295_7)

				if var_295_9 > 0 and var_295_3 < var_295_9 then
					arg_292_1.talkMaxDuration = var_295_9

					if var_295_9 + var_295_2 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_9 + var_295_2
					end
				end

				arg_292_1.text_.text = var_295_6
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671069", "story_v_out_319671.awb") ~= 0 then
					local var_295_10 = manager.audio:GetVoiceLength("story_v_out_319671", "319671069", "story_v_out_319671.awb") / 1000

					if var_295_10 + var_295_2 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_10 + var_295_2
					end

					if var_295_5.prefab_name ~= "" and arg_292_1.actors_[var_295_5.prefab_name] ~= nil then
						local var_295_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_292_1.actors_[var_295_5.prefab_name].transform, "story_v_out_319671", "319671069", "story_v_out_319671.awb")

						arg_292_1:RecordAudio("319671069", var_295_11)
						arg_292_1:RecordAudio("319671069", var_295_11)
					else
						arg_292_1:AudioAction("play", "voice", "story_v_out_319671", "319671069", "story_v_out_319671.awb")
					end

					arg_292_1:RecordHistoryTalkVoice("story_v_out_319671", "319671069", "story_v_out_319671.awb")
				end

				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_12 = math.max(var_295_3, arg_292_1.talkMaxDuration)

			if var_295_2 <= arg_292_1.time_ and arg_292_1.time_ < var_295_2 + var_295_12 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - var_295_2) / var_295_12

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= var_295_2 + var_295_12 and arg_292_1.time_ < var_295_2 + var_295_12 + arg_295_0 then
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
			local var_299_0 = arg_296_1.actors_["1084ui_story"]
			local var_299_1 = 0

			if var_299_1 < arg_296_1.time_ and arg_296_1.time_ <= var_299_1 + arg_299_0 and not isNil(var_299_0) and arg_296_1.var_.characterEffect1084ui_story == nil then
				arg_296_1.var_.characterEffect1084ui_story = var_299_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_299_2 = 0.200000002980232

			if var_299_1 <= arg_296_1.time_ and arg_296_1.time_ < var_299_1 + var_299_2 and not isNil(var_299_0) then
				local var_299_3 = (arg_296_1.time_ - var_299_1) / var_299_2

				if arg_296_1.var_.characterEffect1084ui_story and not isNil(var_299_0) then
					local var_299_4 = Mathf.Lerp(0, 0.5, var_299_3)

					arg_296_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_296_1.var_.characterEffect1084ui_story.fillRatio = var_299_4
				end
			end

			if arg_296_1.time_ >= var_299_1 + var_299_2 and arg_296_1.time_ < var_299_1 + var_299_2 + arg_299_0 and not isNil(var_299_0) and arg_296_1.var_.characterEffect1084ui_story then
				local var_299_5 = 0.5

				arg_296_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_296_1.var_.characterEffect1084ui_story.fillRatio = var_299_5
			end

			local var_299_6 = arg_296_1.actors_["10014ui_story"]
			local var_299_7 = 0

			if var_299_7 < arg_296_1.time_ and arg_296_1.time_ <= var_299_7 + arg_299_0 and not isNil(var_299_6) and arg_296_1.var_.characterEffect10014ui_story == nil then
				arg_296_1.var_.characterEffect10014ui_story = var_299_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_299_8 = 0.200000002980232

			if var_299_7 <= arg_296_1.time_ and arg_296_1.time_ < var_299_7 + var_299_8 and not isNil(var_299_6) then
				local var_299_9 = (arg_296_1.time_ - var_299_7) / var_299_8

				if arg_296_1.var_.characterEffect10014ui_story and not isNil(var_299_6) then
					arg_296_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_296_1.time_ >= var_299_7 + var_299_8 and arg_296_1.time_ < var_299_7 + var_299_8 + arg_299_0 and not isNil(var_299_6) and arg_296_1.var_.characterEffect10014ui_story then
				arg_296_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_299_10 = 0

			if var_299_10 < arg_296_1.time_ and arg_296_1.time_ <= var_299_10 + arg_299_0 then
				arg_296_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action3_2")
			end

			local var_299_11 = 0
			local var_299_12 = 0.675

			if var_299_11 < arg_296_1.time_ and arg_296_1.time_ <= var_299_11 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0
				arg_296_1.dialogCg_.alpha = 1

				arg_296_1.dialog_:SetActive(true)
				SetActive(arg_296_1.leftNameGo_, true)

				local var_299_13 = arg_296_1:FormatText(StoryNameCfg[264].name)

				arg_296_1.leftNameTxt_.text = var_299_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_296_1.leftNameTxt_.transform)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1.leftNameTxt_.text)
				SetActive(arg_296_1.iconTrs_.gameObject, false)
				arg_296_1.callingController_:SetSelectedState("normal")

				local var_299_14 = arg_296_1:GetWordFromCfg(319671070)
				local var_299_15 = arg_296_1:FormatText(var_299_14.content)

				arg_296_1.text_.text = var_299_15

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_16 = 27
				local var_299_17 = utf8.len(var_299_15)
				local var_299_18 = var_299_16 <= 0 and var_299_12 or var_299_12 * (var_299_17 / var_299_16)

				if var_299_18 > 0 and var_299_12 < var_299_18 then
					arg_296_1.talkMaxDuration = var_299_18

					if var_299_18 + var_299_11 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_18 + var_299_11
					end
				end

				arg_296_1.text_.text = var_299_15
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671070", "story_v_out_319671.awb") ~= 0 then
					local var_299_19 = manager.audio:GetVoiceLength("story_v_out_319671", "319671070", "story_v_out_319671.awb") / 1000

					if var_299_19 + var_299_11 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_19 + var_299_11
					end

					if var_299_14.prefab_name ~= "" and arg_296_1.actors_[var_299_14.prefab_name] ~= nil then
						local var_299_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_296_1.actors_[var_299_14.prefab_name].transform, "story_v_out_319671", "319671070", "story_v_out_319671.awb")

						arg_296_1:RecordAudio("319671070", var_299_20)
						arg_296_1:RecordAudio("319671070", var_299_20)
					else
						arg_296_1:AudioAction("play", "voice", "story_v_out_319671", "319671070", "story_v_out_319671.awb")
					end

					arg_296_1:RecordHistoryTalkVoice("story_v_out_319671", "319671070", "story_v_out_319671.awb")
				end

				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_21 = math.max(var_299_12, arg_296_1.talkMaxDuration)

			if var_299_11 <= arg_296_1.time_ and arg_296_1.time_ < var_299_11 + var_299_21 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - var_299_11) / var_299_21

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= var_299_11 + var_299_21 and arg_296_1.time_ < var_299_11 + var_299_21 + arg_299_0 then
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
			local var_303_0 = arg_300_1.actors_["1084ui_story"].transform
			local var_303_1 = 0

			if var_303_1 < arg_300_1.time_ and arg_300_1.time_ <= var_303_1 + arg_303_0 then
				arg_300_1.var_.moveOldPos1084ui_story = var_303_0.localPosition
			end

			local var_303_2 = 0.001

			if var_303_1 <= arg_300_1.time_ and arg_300_1.time_ < var_303_1 + var_303_2 then
				local var_303_3 = (arg_300_1.time_ - var_303_1) / var_303_2
				local var_303_4 = Vector3.New(0.7, -0.97, -6)

				var_303_0.localPosition = Vector3.Lerp(arg_300_1.var_.moveOldPos1084ui_story, var_303_4, var_303_3)

				local var_303_5 = manager.ui.mainCamera.transform.position - var_303_0.position

				var_303_0.forward = Vector3.New(var_303_5.x, var_303_5.y, var_303_5.z)

				local var_303_6 = var_303_0.localEulerAngles

				var_303_6.z = 0
				var_303_6.x = 0
				var_303_0.localEulerAngles = var_303_6
			end

			if arg_300_1.time_ >= var_303_1 + var_303_2 and arg_300_1.time_ < var_303_1 + var_303_2 + arg_303_0 then
				var_303_0.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_303_7 = manager.ui.mainCamera.transform.position - var_303_0.position

				var_303_0.forward = Vector3.New(var_303_7.x, var_303_7.y, var_303_7.z)

				local var_303_8 = var_303_0.localEulerAngles

				var_303_8.z = 0
				var_303_8.x = 0
				var_303_0.localEulerAngles = var_303_8
			end

			local var_303_9 = arg_300_1.actors_["1084ui_story"]
			local var_303_10 = 0

			if var_303_10 < arg_300_1.time_ and arg_300_1.time_ <= var_303_10 + arg_303_0 and not isNil(var_303_9) and arg_300_1.var_.characterEffect1084ui_story == nil then
				arg_300_1.var_.characterEffect1084ui_story = var_303_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_303_11 = 0.200000002980232

			if var_303_10 <= arg_300_1.time_ and arg_300_1.time_ < var_303_10 + var_303_11 and not isNil(var_303_9) then
				local var_303_12 = (arg_300_1.time_ - var_303_10) / var_303_11

				if arg_300_1.var_.characterEffect1084ui_story and not isNil(var_303_9) then
					arg_300_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_300_1.time_ >= var_303_10 + var_303_11 and arg_300_1.time_ < var_303_10 + var_303_11 + arg_303_0 and not isNil(var_303_9) and arg_300_1.var_.characterEffect1084ui_story then
				arg_300_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_303_13 = 0

			if var_303_13 < arg_300_1.time_ and arg_300_1.time_ <= var_303_13 + arg_303_0 then
				arg_300_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_2")
			end

			local var_303_14 = 0

			if var_303_14 < arg_300_1.time_ and arg_300_1.time_ <= var_303_14 + arg_303_0 then
				arg_300_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_303_15 = arg_300_1.actors_["10014ui_story"]
			local var_303_16 = 0

			if var_303_16 < arg_300_1.time_ and arg_300_1.time_ <= var_303_16 + arg_303_0 and not isNil(var_303_15) and arg_300_1.var_.characterEffect10014ui_story == nil then
				arg_300_1.var_.characterEffect10014ui_story = var_303_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_303_17 = 0.200000002980232

			if var_303_16 <= arg_300_1.time_ and arg_300_1.time_ < var_303_16 + var_303_17 and not isNil(var_303_15) then
				local var_303_18 = (arg_300_1.time_ - var_303_16) / var_303_17

				if arg_300_1.var_.characterEffect10014ui_story and not isNil(var_303_15) then
					local var_303_19 = Mathf.Lerp(0, 0.5, var_303_18)

					arg_300_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_300_1.var_.characterEffect10014ui_story.fillRatio = var_303_19
				end
			end

			if arg_300_1.time_ >= var_303_16 + var_303_17 and arg_300_1.time_ < var_303_16 + var_303_17 + arg_303_0 and not isNil(var_303_15) and arg_300_1.var_.characterEffect10014ui_story then
				local var_303_20 = 0.5

				arg_300_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_300_1.var_.characterEffect10014ui_story.fillRatio = var_303_20
			end

			local var_303_21 = 0
			local var_303_22 = 0.2

			if var_303_21 < arg_300_1.time_ and arg_300_1.time_ <= var_303_21 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0
				arg_300_1.dialogCg_.alpha = 1

				arg_300_1.dialog_:SetActive(true)
				SetActive(arg_300_1.leftNameGo_, true)

				local var_303_23 = arg_300_1:FormatText(StoryNameCfg[6].name)

				arg_300_1.leftNameTxt_.text = var_303_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_300_1.leftNameTxt_.transform)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1.leftNameTxt_.text)
				SetActive(arg_300_1.iconTrs_.gameObject, false)
				arg_300_1.callingController_:SetSelectedState("normal")

				local var_303_24 = arg_300_1:GetWordFromCfg(319671071)
				local var_303_25 = arg_300_1:FormatText(var_303_24.content)

				arg_300_1.text_.text = var_303_25

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_26 = 8
				local var_303_27 = utf8.len(var_303_25)
				local var_303_28 = var_303_26 <= 0 and var_303_22 or var_303_22 * (var_303_27 / var_303_26)

				if var_303_28 > 0 and var_303_22 < var_303_28 then
					arg_300_1.talkMaxDuration = var_303_28

					if var_303_28 + var_303_21 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_28 + var_303_21
					end
				end

				arg_300_1.text_.text = var_303_25
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671071", "story_v_out_319671.awb") ~= 0 then
					local var_303_29 = manager.audio:GetVoiceLength("story_v_out_319671", "319671071", "story_v_out_319671.awb") / 1000

					if var_303_29 + var_303_21 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_29 + var_303_21
					end

					if var_303_24.prefab_name ~= "" and arg_300_1.actors_[var_303_24.prefab_name] ~= nil then
						local var_303_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_300_1.actors_[var_303_24.prefab_name].transform, "story_v_out_319671", "319671071", "story_v_out_319671.awb")

						arg_300_1:RecordAudio("319671071", var_303_30)
						arg_300_1:RecordAudio("319671071", var_303_30)
					else
						arg_300_1:AudioAction("play", "voice", "story_v_out_319671", "319671071", "story_v_out_319671.awb")
					end

					arg_300_1:RecordHistoryTalkVoice("story_v_out_319671", "319671071", "story_v_out_319671.awb")
				end

				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_31 = math.max(var_303_22, arg_300_1.talkMaxDuration)

			if var_303_21 <= arg_300_1.time_ and arg_300_1.time_ < var_303_21 + var_303_31 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - var_303_21) / var_303_31

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= var_303_21 + var_303_31 and arg_300_1.time_ < var_303_21 + var_303_31 + arg_303_0 then
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
			local var_307_0 = arg_304_1.actors_["1084ui_story"]
			local var_307_1 = 0

			if var_307_1 < arg_304_1.time_ and arg_304_1.time_ <= var_307_1 + arg_307_0 and not isNil(var_307_0) and arg_304_1.var_.characterEffect1084ui_story == nil then
				arg_304_1.var_.characterEffect1084ui_story = var_307_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_307_2 = 0.200000002980232

			if var_307_1 <= arg_304_1.time_ and arg_304_1.time_ < var_307_1 + var_307_2 and not isNil(var_307_0) then
				local var_307_3 = (arg_304_1.time_ - var_307_1) / var_307_2

				if arg_304_1.var_.characterEffect1084ui_story and not isNil(var_307_0) then
					local var_307_4 = Mathf.Lerp(0, 0.5, var_307_3)

					arg_304_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_304_1.var_.characterEffect1084ui_story.fillRatio = var_307_4
				end
			end

			if arg_304_1.time_ >= var_307_1 + var_307_2 and arg_304_1.time_ < var_307_1 + var_307_2 + arg_307_0 and not isNil(var_307_0) and arg_304_1.var_.characterEffect1084ui_story then
				local var_307_5 = 0.5

				arg_304_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_304_1.var_.characterEffect1084ui_story.fillRatio = var_307_5
			end

			local var_307_6 = 0
			local var_307_7 = 0.175

			if var_307_6 < arg_304_1.time_ and arg_304_1.time_ <= var_307_6 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0
				arg_304_1.dialogCg_.alpha = 1

				arg_304_1.dialog_:SetActive(true)
				SetActive(arg_304_1.leftNameGo_, true)

				local var_307_8 = arg_304_1:FormatText(StoryNameCfg[36].name)

				arg_304_1.leftNameTxt_.text = var_307_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_304_1.leftNameTxt_.transform)

				arg_304_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_304_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_304_1:RecordName(arg_304_1.leftNameTxt_.text)
				SetActive(arg_304_1.iconTrs_.gameObject, false)
				arg_304_1.callingController_:SetSelectedState("normal")

				local var_307_9 = arg_304_1:GetWordFromCfg(319671072)
				local var_307_10 = arg_304_1:FormatText(var_307_9.content)

				arg_304_1.text_.text = var_307_10

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_11 = 7
				local var_307_12 = utf8.len(var_307_10)
				local var_307_13 = var_307_11 <= 0 and var_307_7 or var_307_7 * (var_307_12 / var_307_11)

				if var_307_13 > 0 and var_307_7 < var_307_13 then
					arg_304_1.talkMaxDuration = var_307_13

					if var_307_13 + var_307_6 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_13 + var_307_6
					end
				end

				arg_304_1.text_.text = var_307_10
				arg_304_1.typewritter.percent = 0

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671072", "story_v_out_319671.awb") ~= 0 then
					local var_307_14 = manager.audio:GetVoiceLength("story_v_out_319671", "319671072", "story_v_out_319671.awb") / 1000

					if var_307_14 + var_307_6 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_14 + var_307_6
					end

					if var_307_9.prefab_name ~= "" and arg_304_1.actors_[var_307_9.prefab_name] ~= nil then
						local var_307_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_304_1.actors_[var_307_9.prefab_name].transform, "story_v_out_319671", "319671072", "story_v_out_319671.awb")

						arg_304_1:RecordAudio("319671072", var_307_15)
						arg_304_1:RecordAudio("319671072", var_307_15)
					else
						arg_304_1:AudioAction("play", "voice", "story_v_out_319671", "319671072", "story_v_out_319671.awb")
					end

					arg_304_1:RecordHistoryTalkVoice("story_v_out_319671", "319671072", "story_v_out_319671.awb")
				end

				arg_304_1:RecordContent(arg_304_1.text_.text)
			end

			local var_307_16 = math.max(var_307_7, arg_304_1.talkMaxDuration)

			if var_307_6 <= arg_304_1.time_ and arg_304_1.time_ < var_307_6 + var_307_16 then
				arg_304_1.typewritter.percent = (arg_304_1.time_ - var_307_6) / var_307_16

				arg_304_1.typewritter:SetDirty()
			end

			if arg_304_1.time_ >= var_307_6 + var_307_16 and arg_304_1.time_ < var_307_6 + var_307_16 + arg_307_0 then
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
			local var_311_0 = arg_308_1.actors_["10014ui_story"].transform
			local var_311_1 = 0

			if var_311_1 < arg_308_1.time_ and arg_308_1.time_ <= var_311_1 + arg_311_0 then
				arg_308_1.var_.moveOldPos10014ui_story = var_311_0.localPosition
			end

			local var_311_2 = 0.001

			if var_311_1 <= arg_308_1.time_ and arg_308_1.time_ < var_311_1 + var_311_2 then
				local var_311_3 = (arg_308_1.time_ - var_311_1) / var_311_2
				local var_311_4 = Vector3.New(0, 100, 0)

				var_311_0.localPosition = Vector3.Lerp(arg_308_1.var_.moveOldPos10014ui_story, var_311_4, var_311_3)

				local var_311_5 = manager.ui.mainCamera.transform.position - var_311_0.position

				var_311_0.forward = Vector3.New(var_311_5.x, var_311_5.y, var_311_5.z)

				local var_311_6 = var_311_0.localEulerAngles

				var_311_6.z = 0
				var_311_6.x = 0
				var_311_0.localEulerAngles = var_311_6
			end

			if arg_308_1.time_ >= var_311_1 + var_311_2 and arg_308_1.time_ < var_311_1 + var_311_2 + arg_311_0 then
				var_311_0.localPosition = Vector3.New(0, 100, 0)

				local var_311_7 = manager.ui.mainCamera.transform.position - var_311_0.position

				var_311_0.forward = Vector3.New(var_311_7.x, var_311_7.y, var_311_7.z)

				local var_311_8 = var_311_0.localEulerAngles

				var_311_8.z = 0
				var_311_8.x = 0
				var_311_0.localEulerAngles = var_311_8
			end

			local var_311_9 = arg_308_1.actors_["10014ui_story"]
			local var_311_10 = 0

			if var_311_10 < arg_308_1.time_ and arg_308_1.time_ <= var_311_10 + arg_311_0 and not isNil(var_311_9) and arg_308_1.var_.characterEffect10014ui_story == nil then
				arg_308_1.var_.characterEffect10014ui_story = var_311_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_311_11 = 0.200000002980232

			if var_311_10 <= arg_308_1.time_ and arg_308_1.time_ < var_311_10 + var_311_11 and not isNil(var_311_9) then
				local var_311_12 = (arg_308_1.time_ - var_311_10) / var_311_11

				if arg_308_1.var_.characterEffect10014ui_story and not isNil(var_311_9) then
					local var_311_13 = Mathf.Lerp(0, 0.5, var_311_12)

					arg_308_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_308_1.var_.characterEffect10014ui_story.fillRatio = var_311_13
				end
			end

			if arg_308_1.time_ >= var_311_10 + var_311_11 and arg_308_1.time_ < var_311_10 + var_311_11 + arg_311_0 and not isNil(var_311_9) and arg_308_1.var_.characterEffect10014ui_story then
				local var_311_14 = 0.5

				arg_308_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_308_1.var_.characterEffect10014ui_story.fillRatio = var_311_14
			end

			local var_311_15 = arg_308_1.actors_["1084ui_story"].transform
			local var_311_16 = 0

			if var_311_16 < arg_308_1.time_ and arg_308_1.time_ <= var_311_16 + arg_311_0 then
				arg_308_1.var_.moveOldPos1084ui_story = var_311_15.localPosition
			end

			local var_311_17 = 0.001

			if var_311_16 <= arg_308_1.time_ and arg_308_1.time_ < var_311_16 + var_311_17 then
				local var_311_18 = (arg_308_1.time_ - var_311_16) / var_311_17
				local var_311_19 = Vector3.New(0, 100, 0)

				var_311_15.localPosition = Vector3.Lerp(arg_308_1.var_.moveOldPos1084ui_story, var_311_19, var_311_18)

				local var_311_20 = manager.ui.mainCamera.transform.position - var_311_15.position

				var_311_15.forward = Vector3.New(var_311_20.x, var_311_20.y, var_311_20.z)

				local var_311_21 = var_311_15.localEulerAngles

				var_311_21.z = 0
				var_311_21.x = 0
				var_311_15.localEulerAngles = var_311_21
			end

			if arg_308_1.time_ >= var_311_16 + var_311_17 and arg_308_1.time_ < var_311_16 + var_311_17 + arg_311_0 then
				var_311_15.localPosition = Vector3.New(0, 100, 0)

				local var_311_22 = manager.ui.mainCamera.transform.position - var_311_15.position

				var_311_15.forward = Vector3.New(var_311_22.x, var_311_22.y, var_311_22.z)

				local var_311_23 = var_311_15.localEulerAngles

				var_311_23.z = 0
				var_311_23.x = 0
				var_311_15.localEulerAngles = var_311_23
			end

			local var_311_24 = arg_308_1.actors_["1084ui_story"]
			local var_311_25 = 0

			if var_311_25 < arg_308_1.time_ and arg_308_1.time_ <= var_311_25 + arg_311_0 and not isNil(var_311_24) and arg_308_1.var_.characterEffect1084ui_story == nil then
				arg_308_1.var_.characterEffect1084ui_story = var_311_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_311_26 = 0.200000002980232

			if var_311_25 <= arg_308_1.time_ and arg_308_1.time_ < var_311_25 + var_311_26 and not isNil(var_311_24) then
				local var_311_27 = (arg_308_1.time_ - var_311_25) / var_311_26

				if arg_308_1.var_.characterEffect1084ui_story and not isNil(var_311_24) then
					local var_311_28 = Mathf.Lerp(0, 0.5, var_311_27)

					arg_308_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_308_1.var_.characterEffect1084ui_story.fillRatio = var_311_28
				end
			end

			if arg_308_1.time_ >= var_311_25 + var_311_26 and arg_308_1.time_ < var_311_25 + var_311_26 + arg_311_0 and not isNil(var_311_24) and arg_308_1.var_.characterEffect1084ui_story then
				local var_311_29 = 0.5

				arg_308_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_308_1.var_.characterEffect1084ui_story.fillRatio = var_311_29
			end

			local var_311_30 = arg_308_1.actors_["10014ui_story"]
			local var_311_31 = 0

			if var_311_31 < arg_308_1.time_ and arg_308_1.time_ <= var_311_31 + arg_311_0 then
				if arg_308_1.var_.characterEffect10014ui_story == nil then
					arg_308_1.var_.characterEffect10014ui_story = var_311_30:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_311_32 = arg_308_1.var_.characterEffect10014ui_story

				var_311_32.imageEffect:turnOff()

				var_311_32.interferenceEffect.enabled = false
				var_311_32.interferenceEffect.noise = 0.001
				var_311_32.interferenceEffect.simTimeScale = 1
				var_311_32.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_311_33 = arg_308_1.actors_["10014ui_story"]
			local var_311_34 = 0
			local var_311_35 = 0.266666666666667

			if var_311_34 < arg_308_1.time_ and arg_308_1.time_ <= var_311_34 + arg_311_0 then
				if arg_308_1.var_.characterEffect10014ui_story == nil then
					arg_308_1.var_.characterEffect10014ui_story = var_311_33:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_308_1.var_.characterEffect10014ui_story.imageEffect:turnOff()
			end

			local var_311_36 = 0
			local var_311_37 = 0.65

			if var_311_36 < arg_308_1.time_ and arg_308_1.time_ <= var_311_36 + arg_311_0 then
				arg_308_1.talkMaxDuration = 0
				arg_308_1.dialogCg_.alpha = 1

				arg_308_1.dialog_:SetActive(true)
				SetActive(arg_308_1.leftNameGo_, false)

				arg_308_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_308_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_308_1:RecordName(arg_308_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_308_1.iconTrs_.gameObject, false)
				arg_308_1.callingController_:SetSelectedState("normal")

				local var_311_38 = arg_308_1:GetWordFromCfg(319671073)
				local var_311_39 = arg_308_1:FormatText(var_311_38.content)

				arg_308_1.text_.text = var_311_39

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_40 = 26
				local var_311_41 = utf8.len(var_311_39)
				local var_311_42 = var_311_40 <= 0 and var_311_37 or var_311_37 * (var_311_41 / var_311_40)

				if var_311_42 > 0 and var_311_37 < var_311_42 then
					arg_308_1.talkMaxDuration = var_311_42

					if var_311_42 + var_311_36 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_42 + var_311_36
					end
				end

				arg_308_1.text_.text = var_311_39
				arg_308_1.typewritter.percent = 0

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(false)
				arg_308_1:RecordContent(arg_308_1.text_.text)
			end

			local var_311_43 = math.max(var_311_37, arg_308_1.talkMaxDuration)

			if var_311_36 <= arg_308_1.time_ and arg_308_1.time_ < var_311_36 + var_311_43 then
				arg_308_1.typewritter.percent = (arg_308_1.time_ - var_311_36) / var_311_43

				arg_308_1.typewritter:SetDirty()
			end

			if arg_308_1.time_ >= var_311_36 + var_311_43 and arg_308_1.time_ < var_311_36 + var_311_43 + arg_311_0 then
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
			local var_315_0 = arg_312_1.actors_["10014ui_story"].transform
			local var_315_1 = 0

			if var_315_1 < arg_312_1.time_ and arg_312_1.time_ <= var_315_1 + arg_315_0 then
				arg_312_1.var_.moveOldPos10014ui_story = var_315_0.localPosition
			end

			local var_315_2 = 0.001

			if var_315_1 <= arg_312_1.time_ and arg_312_1.time_ < var_315_1 + var_315_2 then
				local var_315_3 = (arg_312_1.time_ - var_315_1) / var_315_2
				local var_315_4 = Vector3.New(0, 100, 0)

				var_315_0.localPosition = Vector3.Lerp(arg_312_1.var_.moveOldPos10014ui_story, var_315_4, var_315_3)

				local var_315_5 = manager.ui.mainCamera.transform.position - var_315_0.position

				var_315_0.forward = Vector3.New(var_315_5.x, var_315_5.y, var_315_5.z)

				local var_315_6 = var_315_0.localEulerAngles

				var_315_6.z = 0
				var_315_6.x = 0
				var_315_0.localEulerAngles = var_315_6
			end

			if arg_312_1.time_ >= var_315_1 + var_315_2 and arg_312_1.time_ < var_315_1 + var_315_2 + arg_315_0 then
				var_315_0.localPosition = Vector3.New(0, 100, 0)

				local var_315_7 = manager.ui.mainCamera.transform.position - var_315_0.position

				var_315_0.forward = Vector3.New(var_315_7.x, var_315_7.y, var_315_7.z)

				local var_315_8 = var_315_0.localEulerAngles

				var_315_8.z = 0
				var_315_8.x = 0
				var_315_0.localEulerAngles = var_315_8
			end

			local var_315_9 = arg_312_1.actors_["10014ui_story"]
			local var_315_10 = 0

			if var_315_10 < arg_312_1.time_ and arg_312_1.time_ <= var_315_10 + arg_315_0 and not isNil(var_315_9) and arg_312_1.var_.characterEffect10014ui_story == nil then
				arg_312_1.var_.characterEffect10014ui_story = var_315_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_315_11 = 0.200000002980232

			if var_315_10 <= arg_312_1.time_ and arg_312_1.time_ < var_315_10 + var_315_11 and not isNil(var_315_9) then
				local var_315_12 = (arg_312_1.time_ - var_315_10) / var_315_11

				if arg_312_1.var_.characterEffect10014ui_story and not isNil(var_315_9) then
					local var_315_13 = Mathf.Lerp(0, 0.5, var_315_12)

					arg_312_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_312_1.var_.characterEffect10014ui_story.fillRatio = var_315_13
				end
			end

			if arg_312_1.time_ >= var_315_10 + var_315_11 and arg_312_1.time_ < var_315_10 + var_315_11 + arg_315_0 and not isNil(var_315_9) and arg_312_1.var_.characterEffect10014ui_story then
				local var_315_14 = 0.5

				arg_312_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_312_1.var_.characterEffect10014ui_story.fillRatio = var_315_14
			end

			local var_315_15 = arg_312_1.actors_["1084ui_story"].transform
			local var_315_16 = 0

			if var_315_16 < arg_312_1.time_ and arg_312_1.time_ <= var_315_16 + arg_315_0 then
				arg_312_1.var_.moveOldPos1084ui_story = var_315_15.localPosition
			end

			local var_315_17 = 0.001

			if var_315_16 <= arg_312_1.time_ and arg_312_1.time_ < var_315_16 + var_315_17 then
				local var_315_18 = (arg_312_1.time_ - var_315_16) / var_315_17
				local var_315_19 = Vector3.New(0, 100, 0)

				var_315_15.localPosition = Vector3.Lerp(arg_312_1.var_.moveOldPos1084ui_story, var_315_19, var_315_18)

				local var_315_20 = manager.ui.mainCamera.transform.position - var_315_15.position

				var_315_15.forward = Vector3.New(var_315_20.x, var_315_20.y, var_315_20.z)

				local var_315_21 = var_315_15.localEulerAngles

				var_315_21.z = 0
				var_315_21.x = 0
				var_315_15.localEulerAngles = var_315_21
			end

			if arg_312_1.time_ >= var_315_16 + var_315_17 and arg_312_1.time_ < var_315_16 + var_315_17 + arg_315_0 then
				var_315_15.localPosition = Vector3.New(0, 100, 0)

				local var_315_22 = manager.ui.mainCamera.transform.position - var_315_15.position

				var_315_15.forward = Vector3.New(var_315_22.x, var_315_22.y, var_315_22.z)

				local var_315_23 = var_315_15.localEulerAngles

				var_315_23.z = 0
				var_315_23.x = 0
				var_315_15.localEulerAngles = var_315_23
			end

			local var_315_24 = arg_312_1.actors_["1084ui_story"]
			local var_315_25 = 0

			if var_315_25 < arg_312_1.time_ and arg_312_1.time_ <= var_315_25 + arg_315_0 and not isNil(var_315_24) and arg_312_1.var_.characterEffect1084ui_story == nil then
				arg_312_1.var_.characterEffect1084ui_story = var_315_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_315_26 = 0.200000002980232

			if var_315_25 <= arg_312_1.time_ and arg_312_1.time_ < var_315_25 + var_315_26 and not isNil(var_315_24) then
				local var_315_27 = (arg_312_1.time_ - var_315_25) / var_315_26

				if arg_312_1.var_.characterEffect1084ui_story and not isNil(var_315_24) then
					local var_315_28 = Mathf.Lerp(0, 0.5, var_315_27)

					arg_312_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_312_1.var_.characterEffect1084ui_story.fillRatio = var_315_28
				end
			end

			if arg_312_1.time_ >= var_315_25 + var_315_26 and arg_312_1.time_ < var_315_25 + var_315_26 + arg_315_0 and not isNil(var_315_24) and arg_312_1.var_.characterEffect1084ui_story then
				local var_315_29 = 0.5

				arg_312_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_312_1.var_.characterEffect1084ui_story.fillRatio = var_315_29
			end

			local var_315_30 = 0
			local var_315_31 = 1.025

			if var_315_30 < arg_312_1.time_ and arg_312_1.time_ <= var_315_30 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0
				arg_312_1.dialogCg_.alpha = 1

				arg_312_1.dialog_:SetActive(true)
				SetActive(arg_312_1.leftNameGo_, false)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_312_1.iconTrs_.gameObject, false)
				arg_312_1.callingController_:SetSelectedState("normal")

				local var_315_32 = arg_312_1:GetWordFromCfg(319671074)
				local var_315_33 = arg_312_1:FormatText(var_315_32.content)

				arg_312_1.text_.text = var_315_33

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_34 = 41
				local var_315_35 = utf8.len(var_315_33)
				local var_315_36 = var_315_34 <= 0 and var_315_31 or var_315_31 * (var_315_35 / var_315_34)

				if var_315_36 > 0 and var_315_31 < var_315_36 then
					arg_312_1.talkMaxDuration = var_315_36

					if var_315_36 + var_315_30 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_36 + var_315_30
					end
				end

				arg_312_1.text_.text = var_315_33
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)
				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_37 = math.max(var_315_31, arg_312_1.talkMaxDuration)

			if var_315_30 <= arg_312_1.time_ and arg_312_1.time_ < var_315_30 + var_315_37 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - var_315_30) / var_315_37

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= var_315_30 + var_315_37 and arg_312_1.time_ < var_315_30 + var_315_37 + arg_315_0 then
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
			local var_319_0 = "4040ui_story"

			if arg_316_1.actors_[var_319_0] == nil then
				local var_319_1 = Asset.Load("Char/" .. "4040ui_story")

				if not isNil(var_319_1) then
					local var_319_2 = Object.Instantiate(Asset.Load("Char/" .. "4040ui_story"), arg_316_1.stage_.transform)

					var_319_2.name = var_319_0
					var_319_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_316_1.actors_[var_319_0] = var_319_2

					local var_319_3 = var_319_2:GetComponentInChildren(typeof(CharacterEffect))

					var_319_3.enabled = true

					local var_319_4 = GameObjectTools.GetOrAddComponent(var_319_2, typeof(DynamicBoneHelper))

					if var_319_4 then
						var_319_4:EnableDynamicBone(false)
					end

					arg_316_1:ShowWeapon(var_319_3.transform, false)

					arg_316_1.var_[var_319_0 .. "Animator"] = var_319_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_316_1.var_[var_319_0 .. "Animator"].applyRootMotion = true
					arg_316_1.var_[var_319_0 .. "LipSync"] = var_319_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_319_5 = arg_316_1.actors_["4040ui_story"].transform
			local var_319_6 = 0

			if var_319_6 < arg_316_1.time_ and arg_316_1.time_ <= var_319_6 + arg_319_0 then
				arg_316_1.var_.moveOldPos4040ui_story = var_319_5.localPosition
			end

			local var_319_7 = 0.001

			if var_319_6 <= arg_316_1.time_ and arg_316_1.time_ < var_319_6 + var_319_7 then
				local var_319_8 = (arg_316_1.time_ - var_319_6) / var_319_7
				local var_319_9 = Vector3.New(0, -1.55, -5.5)

				var_319_5.localPosition = Vector3.Lerp(arg_316_1.var_.moveOldPos4040ui_story, var_319_9, var_319_8)

				local var_319_10 = manager.ui.mainCamera.transform.position - var_319_5.position

				var_319_5.forward = Vector3.New(var_319_10.x, var_319_10.y, var_319_10.z)

				local var_319_11 = var_319_5.localEulerAngles

				var_319_11.z = 0
				var_319_11.x = 0
				var_319_5.localEulerAngles = var_319_11
			end

			if arg_316_1.time_ >= var_319_6 + var_319_7 and arg_316_1.time_ < var_319_6 + var_319_7 + arg_319_0 then
				var_319_5.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_319_12 = manager.ui.mainCamera.transform.position - var_319_5.position

				var_319_5.forward = Vector3.New(var_319_12.x, var_319_12.y, var_319_12.z)

				local var_319_13 = var_319_5.localEulerAngles

				var_319_13.z = 0
				var_319_13.x = 0
				var_319_5.localEulerAngles = var_319_13
			end

			local var_319_14 = arg_316_1.actors_["4040ui_story"]
			local var_319_15 = 0

			if var_319_15 < arg_316_1.time_ and arg_316_1.time_ <= var_319_15 + arg_319_0 and not isNil(var_319_14) and arg_316_1.var_.characterEffect4040ui_story == nil then
				arg_316_1.var_.characterEffect4040ui_story = var_319_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_319_16 = 0.200000002980232

			if var_319_15 <= arg_316_1.time_ and arg_316_1.time_ < var_319_15 + var_319_16 and not isNil(var_319_14) then
				local var_319_17 = (arg_316_1.time_ - var_319_15) / var_319_16

				if arg_316_1.var_.characterEffect4040ui_story and not isNil(var_319_14) then
					arg_316_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_316_1.time_ >= var_319_15 + var_319_16 and arg_316_1.time_ < var_319_15 + var_319_16 + arg_319_0 and not isNil(var_319_14) and arg_316_1.var_.characterEffect4040ui_story then
				arg_316_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_319_18 = 0

			if var_319_18 < arg_316_1.time_ and arg_316_1.time_ <= var_319_18 + arg_319_0 then
				arg_316_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action3_1")
			end

			local var_319_19 = 0

			if var_319_19 < arg_316_1.time_ and arg_316_1.time_ <= var_319_19 + arg_319_0 then
				arg_316_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_319_20 = 0
			local var_319_21 = 0.525

			if var_319_20 < arg_316_1.time_ and arg_316_1.time_ <= var_319_20 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0
				arg_316_1.dialogCg_.alpha = 1

				arg_316_1.dialog_:SetActive(true)
				SetActive(arg_316_1.leftNameGo_, true)

				local var_319_22 = arg_316_1:FormatText(StoryNameCfg[668].name)

				arg_316_1.leftNameTxt_.text = var_319_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_316_1.leftNameTxt_.transform)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1.leftNameTxt_.text)
				SetActive(arg_316_1.iconTrs_.gameObject, false)
				arg_316_1.callingController_:SetSelectedState("normal")

				local var_319_23 = arg_316_1:GetWordFromCfg(319671075)
				local var_319_24 = arg_316_1:FormatText(var_319_23.content)

				arg_316_1.text_.text = var_319_24

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_25 = 21
				local var_319_26 = utf8.len(var_319_24)
				local var_319_27 = var_319_25 <= 0 and var_319_21 or var_319_21 * (var_319_26 / var_319_25)

				if var_319_27 > 0 and var_319_21 < var_319_27 then
					arg_316_1.talkMaxDuration = var_319_27

					if var_319_27 + var_319_20 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_27 + var_319_20
					end
				end

				arg_316_1.text_.text = var_319_24
				arg_316_1.typewritter.percent = 0

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319671", "319671075", "story_v_out_319671.awb") ~= 0 then
					local var_319_28 = manager.audio:GetVoiceLength("story_v_out_319671", "319671075", "story_v_out_319671.awb") / 1000

					if var_319_28 + var_319_20 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_28 + var_319_20
					end

					if var_319_23.prefab_name ~= "" and arg_316_1.actors_[var_319_23.prefab_name] ~= nil then
						local var_319_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_316_1.actors_[var_319_23.prefab_name].transform, "story_v_out_319671", "319671075", "story_v_out_319671.awb")

						arg_316_1:RecordAudio("319671075", var_319_29)
						arg_316_1:RecordAudio("319671075", var_319_29)
					else
						arg_316_1:AudioAction("play", "voice", "story_v_out_319671", "319671075", "story_v_out_319671.awb")
					end

					arg_316_1:RecordHistoryTalkVoice("story_v_out_319671", "319671075", "story_v_out_319671.awb")
				end

				arg_316_1:RecordContent(arg_316_1.text_.text)
			end

			local var_319_30 = math.max(var_319_21, arg_316_1.talkMaxDuration)

			if var_319_20 <= arg_316_1.time_ and arg_316_1.time_ < var_319_20 + var_319_30 then
				arg_316_1.typewritter.percent = (arg_316_1.time_ - var_319_20) / var_319_30

				arg_316_1.typewritter:SetDirty()
			end

			if arg_316_1.time_ >= var_319_20 + var_319_30 and arg_316_1.time_ < var_319_20 + var_319_30 + arg_319_0 then
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
