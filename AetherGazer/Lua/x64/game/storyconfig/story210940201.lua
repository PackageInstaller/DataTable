return {
	Play1109402001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 1109402001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play1109402002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST03"

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
				if arg_1_0.sceneSettingEffect_ then
					arg_1_1.sceneSettingEffect_.enabled = false
				end

				arg_1_1.sceneSettingGo_:SetActive(true)

				local var_4_3 = manager.ui.mainCamera.transform.localPosition
				local var_4_4 = Vector3.New(0, 0, 10) + Vector3.New(var_4_3.x, var_4_3.y, 0)
				local var_4_5 = arg_1_1.bgs_.ST03

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
					if iter_4_0 ~= "ST03" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 0

			if var_4_16 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_17 = 2

			if var_4_16 <= arg_1_1.time_ and arg_1_1.time_ < var_4_16 + var_4_17 then
				local var_4_18 = (arg_1_1.time_ - var_4_16) / var_4_17
				local var_4_19 = Color.New(0, 0, 0)

				var_4_19.a = Mathf.Lerp(1, 0, var_4_18)
				arg_1_1.mask_.color = var_4_19
			end

			if arg_1_1.time_ >= var_4_16 + var_4_17 and arg_1_1.time_ < var_4_16 + var_4_17 + arg_4_0 then
				local var_4_20 = Color.New(0, 0, 0)
				local var_4_21 = 0

				arg_1_1.mask_.enabled = false
				var_4_20.a = var_4_21
				arg_1_1.mask_.color = var_4_20
			end

			local var_4_22 = 1.875
			local var_4_23 = 0.7

			if var_4_22 < arg_1_1.time_ and arg_1_1.time_ <= var_4_22 + arg_4_0 then
				local var_4_24 = "play"
				local var_4_25 = "effect"

				arg_1_1:AudioAction(var_4_24, var_4_25, "se_story_v1_environment_crowd", "se_story_v1_environment_crowd", "")
			end

			local var_4_26 = 0
			local var_4_27 = 0.2

			if var_4_26 < arg_1_1.time_ and arg_1_1.time_ <= var_4_26 + arg_4_0 then
				local var_4_28 = "play"
				local var_4_29 = "music"

				arg_1_1:AudioAction(var_4_28, var_4_29, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_30 = ""
				local var_4_31 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_31 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_31 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_31

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_31
						arg_1_1.bgmTxt2_.text = var_4_31
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

			local var_4_32 = 1.575
			local var_4_33 = 1

			if var_4_32 < arg_1_1.time_ and arg_1_1.time_ <= var_4_32 + arg_4_0 then
				local var_4_34 = "play"
				local var_4_35 = "music"

				arg_1_1:AudioAction(var_4_34, var_4_35, "bgm_side_daily05", "bgm_side_daily05", "bgm_side_daily05.awb")

				local var_4_36 = ""
				local var_4_37 = manager.audio:GetAudioName("bgm_side_daily05", "bgm_side_daily05")

				if var_4_37 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_37 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_37

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_37
						arg_1_1.bgmTxt2_.text = var_4_37
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

			local var_4_38 = 2
			local var_4_39 = 0.575

			if var_4_38 < arg_1_1.time_ and arg_1_1.time_ <= var_4_38 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_40 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_40:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_40:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_40:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_41 = arg_1_1:GetWordFromCfg(1109402001)
				local var_4_42 = arg_1_1:FormatText(var_4_41.content)

				arg_1_1.text_.text = var_4_42

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_43 = 23
				local var_4_44 = utf8.len(var_4_42)
				local var_4_45 = var_4_43 <= 0 and var_4_39 or var_4_39 * (var_4_44 / var_4_43)

				if var_4_45 > 0 and var_4_39 < var_4_45 then
					arg_1_1.talkMaxDuration = var_4_45
					var_4_38 = var_4_38 + 0.3

					if var_4_45 + var_4_38 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_45 + var_4_38
					end
				end

				arg_1_1.text_.text = var_4_42
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_46 = var_4_38 + 0.3
			local var_4_47 = math.max(var_4_39, arg_1_1.talkMaxDuration)

			if var_4_46 <= arg_1_1.time_ and arg_1_1.time_ < var_4_46 + var_4_47 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_46) / var_4_47

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_46 + var_4_47 and arg_1_1.time_ < var_4_46 + var_4_47 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play1109402002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 1109402002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play1109402003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 0.6

			if var_12_0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_2 = arg_9_1:GetWordFromCfg(1109402002)
				local var_12_3 = arg_9_1:FormatText(var_12_2.content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 24
				local var_12_5 = utf8.len(var_12_3)
				local var_12_6 = var_12_4 <= 0 and var_12_1 or var_12_1 * (var_12_5 / var_12_4)

				if var_12_6 > 0 and var_12_1 < var_12_6 then
					arg_9_1.talkMaxDuration = var_12_6

					if var_12_6 + var_12_0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_6 + var_12_0
					end
				end

				arg_9_1.text_.text = var_12_3
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_7 = math.max(var_12_1, arg_9_1.talkMaxDuration)

			if var_12_0 <= arg_9_1.time_ and arg_9_1.time_ < var_12_0 + var_12_7 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_0) / var_12_7

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_0 + var_12_7 and arg_9_1.time_ < var_12_0 + var_12_7 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play1109402003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 1109402003
		arg_13_1.duration_ = 6.4

		local var_13_0 = {
			ja = 6.4,
			ko = 5.966,
			zh = 5.966
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
				arg_13_0:Play1109402004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0
			local var_16_1 = 0.9

			if var_16_0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_2 = arg_13_1:FormatText(StoryNameCfg[23].name)

				arg_13_1.leftNameTxt_.text = var_16_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterm")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_3 = arg_13_1:GetWordFromCfg(1109402003)
				local var_16_4 = arg_13_1:FormatText(var_16_3.content)

				arg_13_1.text_.text = var_16_4

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_5 = 36
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

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402003", "story_v_side_new_1109402.awb") ~= 0 then
					local var_16_8 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402003", "story_v_side_new_1109402.awb") / 1000

					if var_16_8 + var_16_0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_8 + var_16_0
					end

					if var_16_3.prefab_name ~= "" and arg_13_1.actors_[var_16_3.prefab_name] ~= nil then
						local var_16_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_3.prefab_name].transform, "story_v_side_new_1109402", "1109402003", "story_v_side_new_1109402.awb")

						arg_13_1:RecordAudio("1109402003", var_16_9)
						arg_13_1:RecordAudio("1109402003", var_16_9)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402003", "story_v_side_new_1109402.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402003", "story_v_side_new_1109402.awb")
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
	Play1109402004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 1109402004
		arg_17_1.duration_ = 7.53

		local var_17_0 = {
			ja = 4.966,
			ko = 7.533,
			zh = 7.533
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
				arg_17_0:Play1109402005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0
			local var_20_1 = 1.1

			if var_20_0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_2 = arg_17_1:FormatText(StoryNameCfg[25].name)

				arg_17_1.leftNameTxt_.text = var_20_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterw")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_3 = arg_17_1:GetWordFromCfg(1109402004)
				local var_20_4 = arg_17_1:FormatText(var_20_3.content)

				arg_17_1.text_.text = var_20_4

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_5 = 44
				local var_20_6 = utf8.len(var_20_4)
				local var_20_7 = var_20_5 <= 0 and var_20_1 or var_20_1 * (var_20_6 / var_20_5)

				if var_20_7 > 0 and var_20_1 < var_20_7 then
					arg_17_1.talkMaxDuration = var_20_7

					if var_20_7 + var_20_0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_7 + var_20_0
					end
				end

				arg_17_1.text_.text = var_20_4
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402004", "story_v_side_new_1109402.awb") ~= 0 then
					local var_20_8 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402004", "story_v_side_new_1109402.awb") / 1000

					if var_20_8 + var_20_0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_8 + var_20_0
					end

					if var_20_3.prefab_name ~= "" and arg_17_1.actors_[var_20_3.prefab_name] ~= nil then
						local var_20_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_3.prefab_name].transform, "story_v_side_new_1109402", "1109402004", "story_v_side_new_1109402.awb")

						arg_17_1:RecordAudio("1109402004", var_20_9)
						arg_17_1:RecordAudio("1109402004", var_20_9)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402004", "story_v_side_new_1109402.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402004", "story_v_side_new_1109402.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_10 = math.max(var_20_1, arg_17_1.talkMaxDuration)

			if var_20_0 <= arg_17_1.time_ and arg_17_1.time_ < var_20_0 + var_20_10 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_0) / var_20_10

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_0 + var_20_10 and arg_17_1.time_ < var_20_0 + var_20_10 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play1109402005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 1109402005
		arg_21_1.duration_ = 5.47

		local var_21_0 = {
			ja = 5.466,
			ko = 4.833,
			zh = 4.833
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
				arg_21_0:Play1109402006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0
			local var_24_1 = 0.7

			if var_24_0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_2 = arg_21_1:FormatText(StoryNameCfg[26].name)

				arg_21_1.leftNameTxt_.text = var_24_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_studentm")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_3 = arg_21_1:GetWordFromCfg(1109402005)
				local var_24_4 = arg_21_1:FormatText(var_24_3.content)

				arg_21_1.text_.text = var_24_4

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_5 = 28
				local var_24_6 = utf8.len(var_24_4)
				local var_24_7 = var_24_5 <= 0 and var_24_1 or var_24_1 * (var_24_6 / var_24_5)

				if var_24_7 > 0 and var_24_1 < var_24_7 then
					arg_21_1.talkMaxDuration = var_24_7

					if var_24_7 + var_24_0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_7 + var_24_0
					end
				end

				arg_21_1.text_.text = var_24_4
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402005", "story_v_side_new_1109402.awb") ~= 0 then
					local var_24_8 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402005", "story_v_side_new_1109402.awb") / 1000

					if var_24_8 + var_24_0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_8 + var_24_0
					end

					if var_24_3.prefab_name ~= "" and arg_21_1.actors_[var_24_3.prefab_name] ~= nil then
						local var_24_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_3.prefab_name].transform, "story_v_side_new_1109402", "1109402005", "story_v_side_new_1109402.awb")

						arg_21_1:RecordAudio("1109402005", var_24_9)
						arg_21_1:RecordAudio("1109402005", var_24_9)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402005", "story_v_side_new_1109402.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402005", "story_v_side_new_1109402.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_10 = math.max(var_24_1, arg_21_1.talkMaxDuration)

			if var_24_0 <= arg_21_1.time_ and arg_21_1.time_ < var_24_0 + var_24_10 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_0) / var_24_10

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_0 + var_24_10 and arg_21_1.time_ < var_24_0 + var_24_10 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play1109402006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 1109402006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play1109402007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0
			local var_28_1 = 0.65

			if var_28_0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_2 = arg_25_1:FormatText(StoryNameCfg[7].name)

				arg_25_1.leftNameTxt_.text = var_28_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_3 = arg_25_1:GetWordFromCfg(1109402006)
				local var_28_4 = arg_25_1:FormatText(var_28_3.content)

				arg_25_1.text_.text = var_28_4

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_5 = 26
				local var_28_6 = utf8.len(var_28_4)
				local var_28_7 = var_28_5 <= 0 and var_28_1 or var_28_1 * (var_28_6 / var_28_5)

				if var_28_7 > 0 and var_28_1 < var_28_7 then
					arg_25_1.talkMaxDuration = var_28_7

					if var_28_7 + var_28_0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_7 + var_28_0
					end
				end

				arg_25_1.text_.text = var_28_4
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_8 = math.max(var_28_1, arg_25_1.talkMaxDuration)

			if var_28_0 <= arg_25_1.time_ and arg_25_1.time_ < var_28_0 + var_28_8 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_0) / var_28_8

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_0 + var_28_8 and arg_25_1.time_ < var_28_0 + var_28_8 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play1109402007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 1109402007
		arg_29_1.duration_ = 3.2

		local var_29_0 = {
			ja = 1.999999999999,
			ko = 3.2,
			zh = 3.2
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
				arg_29_0:Play1109402008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = "1094ui_story"

			if arg_29_1.actors_[var_32_0] == nil then
				local var_32_1 = Asset.Load("Char/" .. "1094ui_story")

				if not isNil(var_32_1) then
					local var_32_2 = Object.Instantiate(Asset.Load("Char/" .. "1094ui_story"), arg_29_1.stage_.transform)

					var_32_2.name = var_32_0
					var_32_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_29_1.actors_[var_32_0] = var_32_2

					local var_32_3 = var_32_2:GetComponentInChildren(typeof(CharacterEffect))

					var_32_3.enabled = true

					local var_32_4 = GameObjectTools.GetOrAddComponent(var_32_2, typeof(DynamicBoneHelper))

					if var_32_4 then
						var_32_4:EnableDynamicBone(false)
					end

					arg_29_1:ShowWeapon(var_32_3.transform, false)

					arg_29_1.var_[var_32_0 .. "Animator"] = var_32_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_29_1.var_[var_32_0 .. "Animator"].applyRootMotion = true
					arg_29_1.var_[var_32_0 .. "LipSync"] = var_32_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_32_5 = arg_29_1.actors_["1094ui_story"].transform
			local var_32_6 = 0

			if var_32_6 < arg_29_1.time_ and arg_29_1.time_ <= var_32_6 + arg_32_0 then
				arg_29_1.var_.moveOldPos1094ui_story = var_32_5.localPosition
			end

			local var_32_7 = 0.001

			if var_32_6 <= arg_29_1.time_ and arg_29_1.time_ < var_32_6 + var_32_7 then
				local var_32_8 = (arg_29_1.time_ - var_32_6) / var_32_7
				local var_32_9 = Vector3.New(0, -0.84, -6.1)

				var_32_5.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1094ui_story, var_32_9, var_32_8)

				local var_32_10 = manager.ui.mainCamera.transform.position - var_32_5.position

				var_32_5.forward = Vector3.New(var_32_10.x, var_32_10.y, var_32_10.z)

				local var_32_11 = var_32_5.localEulerAngles

				var_32_11.z = 0
				var_32_11.x = 0
				var_32_5.localEulerAngles = var_32_11
			end

			if arg_29_1.time_ >= var_32_6 + var_32_7 and arg_29_1.time_ < var_32_6 + var_32_7 + arg_32_0 then
				var_32_5.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_32_12 = manager.ui.mainCamera.transform.position - var_32_5.position

				var_32_5.forward = Vector3.New(var_32_12.x, var_32_12.y, var_32_12.z)

				local var_32_13 = var_32_5.localEulerAngles

				var_32_13.z = 0
				var_32_13.x = 0
				var_32_5.localEulerAngles = var_32_13
			end

			local var_32_14 = arg_29_1.actors_["1094ui_story"]
			local var_32_15 = 0

			if var_32_15 < arg_29_1.time_ and arg_29_1.time_ <= var_32_15 + arg_32_0 and not isNil(var_32_14) and arg_29_1.var_.characterEffect1094ui_story == nil then
				arg_29_1.var_.characterEffect1094ui_story = var_32_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_16 = 0.200000002980232

			if var_32_15 <= arg_29_1.time_ and arg_29_1.time_ < var_32_15 + var_32_16 and not isNil(var_32_14) then
				local var_32_17 = (arg_29_1.time_ - var_32_15) / var_32_16

				if arg_29_1.var_.characterEffect1094ui_story and not isNil(var_32_14) then
					arg_29_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= var_32_15 + var_32_16 and arg_29_1.time_ < var_32_15 + var_32_16 + arg_32_0 and not isNil(var_32_14) and arg_29_1.var_.characterEffect1094ui_story then
				arg_29_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_32_18 = 0

			if var_32_18 < arg_29_1.time_ and arg_29_1.time_ <= var_32_18 + arg_32_0 then
				arg_29_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action1_1")
			end

			local var_32_19 = 0

			if var_32_19 < arg_29_1.time_ and arg_29_1.time_ <= var_32_19 + arg_32_0 then
				arg_29_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_32_20 = 0
			local var_32_21 = 0.075

			if var_32_20 < arg_29_1.time_ and arg_29_1.time_ <= var_32_20 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_22 = arg_29_1:FormatText(StoryNameCfg[181].name)

				arg_29_1.leftNameTxt_.text = var_32_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_23 = arg_29_1:GetWordFromCfg(1109402007)
				local var_32_24 = arg_29_1:FormatText(var_32_23.content)

				arg_29_1.text_.text = var_32_24

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_25 = 3
				local var_32_26 = utf8.len(var_32_24)
				local var_32_27 = var_32_25 <= 0 and var_32_21 or var_32_21 * (var_32_26 / var_32_25)

				if var_32_27 > 0 and var_32_21 < var_32_27 then
					arg_29_1.talkMaxDuration = var_32_27

					if var_32_27 + var_32_20 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_27 + var_32_20
					end
				end

				arg_29_1.text_.text = var_32_24
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402007", "story_v_side_new_1109402.awb") ~= 0 then
					local var_32_28 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402007", "story_v_side_new_1109402.awb") / 1000

					if var_32_28 + var_32_20 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_28 + var_32_20
					end

					if var_32_23.prefab_name ~= "" and arg_29_1.actors_[var_32_23.prefab_name] ~= nil then
						local var_32_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_23.prefab_name].transform, "story_v_side_new_1109402", "1109402007", "story_v_side_new_1109402.awb")

						arg_29_1:RecordAudio("1109402007", var_32_29)
						arg_29_1:RecordAudio("1109402007", var_32_29)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402007", "story_v_side_new_1109402.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402007", "story_v_side_new_1109402.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_30 = math.max(var_32_21, arg_29_1.talkMaxDuration)

			if var_32_20 <= arg_29_1.time_ and arg_29_1.time_ < var_32_20 + var_32_30 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_20) / var_32_30

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_20 + var_32_30 and arg_29_1.time_ < var_32_20 + var_32_30 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_29_1:InitPlayNodeList()
	end,
	Play1109402008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 1109402008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play1109402009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["1094ui_story"]
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect1094ui_story == nil then
				arg_33_1.var_.characterEffect1094ui_story = var_36_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_2 = 0.200000002980232

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 and not isNil(var_36_0) then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2

				if arg_33_1.var_.characterEffect1094ui_story and not isNil(var_36_0) then
					local var_36_4 = Mathf.Lerp(0, 0.5, var_36_3)

					arg_33_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_33_1.var_.characterEffect1094ui_story.fillRatio = var_36_4
				end
			end

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect1094ui_story then
				local var_36_5 = 0.5

				arg_33_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_33_1.var_.characterEffect1094ui_story.fillRatio = var_36_5
			end

			local var_36_6 = 0
			local var_36_7 = 0.775

			if var_36_6 < arg_33_1.time_ and arg_33_1.time_ <= var_36_6 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_8 = arg_33_1:GetWordFromCfg(1109402008)
				local var_36_9 = arg_33_1:FormatText(var_36_8.content)

				arg_33_1.text_.text = var_36_9

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_10 = 31
				local var_36_11 = utf8.len(var_36_9)
				local var_36_12 = var_36_10 <= 0 and var_36_7 or var_36_7 * (var_36_11 / var_36_10)

				if var_36_12 > 0 and var_36_7 < var_36_12 then
					arg_33_1.talkMaxDuration = var_36_12

					if var_36_12 + var_36_6 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_12 + var_36_6
					end
				end

				arg_33_1.text_.text = var_36_9
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_13 = math.max(var_36_7, arg_33_1.talkMaxDuration)

			if var_36_6 <= arg_33_1.time_ and arg_33_1.time_ < var_36_6 + var_36_13 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_6) / var_36_13

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_6 + var_36_13 and arg_33_1.time_ < var_36_6 + var_36_13 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play1109402009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 1109402009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play1109402010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0
			local var_40_1 = 1.225

			if var_40_0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, false)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_2 = arg_37_1:GetWordFromCfg(1109402009)
				local var_40_3 = arg_37_1:FormatText(var_40_2.content)

				arg_37_1.text_.text = var_40_3

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_4 = 49
				local var_40_5 = utf8.len(var_40_3)
				local var_40_6 = var_40_4 <= 0 and var_40_1 or var_40_1 * (var_40_5 / var_40_4)

				if var_40_6 > 0 and var_40_1 < var_40_6 then
					arg_37_1.talkMaxDuration = var_40_6

					if var_40_6 + var_40_0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_6 + var_40_0
					end
				end

				arg_37_1.text_.text = var_40_3
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_7 = math.max(var_40_1, arg_37_1.talkMaxDuration)

			if var_40_0 <= arg_37_1.time_ and arg_37_1.time_ < var_40_0 + var_40_7 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_0) / var_40_7

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_0 + var_40_7 and arg_37_1.time_ < var_40_0 + var_40_7 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play1109402010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 1109402010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play1109402011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0
			local var_44_1 = 0.975

			if var_44_0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_2 = arg_41_1:FormatText(StoryNameCfg[7].name)

				arg_41_1.leftNameTxt_.text = var_44_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_3 = arg_41_1:GetWordFromCfg(1109402010)
				local var_44_4 = arg_41_1:FormatText(var_44_3.content)

				arg_41_1.text_.text = var_44_4

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_5 = 39
				local var_44_6 = utf8.len(var_44_4)
				local var_44_7 = var_44_5 <= 0 and var_44_1 or var_44_1 * (var_44_6 / var_44_5)

				if var_44_7 > 0 and var_44_1 < var_44_7 then
					arg_41_1.talkMaxDuration = var_44_7

					if var_44_7 + var_44_0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_7 + var_44_0
					end
				end

				arg_41_1.text_.text = var_44_4
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_8 = math.max(var_44_1, arg_41_1.talkMaxDuration)

			if var_44_0 <= arg_41_1.time_ and arg_41_1.time_ < var_44_0 + var_44_8 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_0) / var_44_8

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_0 + var_44_8 and arg_41_1.time_ < var_44_0 + var_44_8 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play1109402011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 1109402011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play1109402012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["1094ui_story"].transform
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 then
				arg_45_1.var_.moveOldPos1094ui_story = var_48_0.localPosition
			end

			local var_48_2 = 0.001

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2
				local var_48_4 = Vector3.New(0, 100, 0)

				var_48_0.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1094ui_story, var_48_4, var_48_3)

				local var_48_5 = manager.ui.mainCamera.transform.position - var_48_0.position

				var_48_0.forward = Vector3.New(var_48_5.x, var_48_5.y, var_48_5.z)

				local var_48_6 = var_48_0.localEulerAngles

				var_48_6.z = 0
				var_48_6.x = 0
				var_48_0.localEulerAngles = var_48_6
			end

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 then
				var_48_0.localPosition = Vector3.New(0, 100, 0)

				local var_48_7 = manager.ui.mainCamera.transform.position - var_48_0.position

				var_48_0.forward = Vector3.New(var_48_7.x, var_48_7.y, var_48_7.z)

				local var_48_8 = var_48_0.localEulerAngles

				var_48_8.z = 0
				var_48_8.x = 0
				var_48_0.localEulerAngles = var_48_8
			end

			local var_48_9 = arg_45_1.actors_["1094ui_story"]
			local var_48_10 = 0

			if var_48_10 < arg_45_1.time_ and arg_45_1.time_ <= var_48_10 + arg_48_0 and not isNil(var_48_9) and arg_45_1.var_.characterEffect1094ui_story == nil then
				arg_45_1.var_.characterEffect1094ui_story = var_48_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_11 = 0.200000002980232

			if var_48_10 <= arg_45_1.time_ and arg_45_1.time_ < var_48_10 + var_48_11 and not isNil(var_48_9) then
				local var_48_12 = (arg_45_1.time_ - var_48_10) / var_48_11

				if arg_45_1.var_.characterEffect1094ui_story and not isNil(var_48_9) then
					local var_48_13 = Mathf.Lerp(0, 0.5, var_48_12)

					arg_45_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_45_1.var_.characterEffect1094ui_story.fillRatio = var_48_13
				end
			end

			if arg_45_1.time_ >= var_48_10 + var_48_11 and arg_45_1.time_ < var_48_10 + var_48_11 + arg_48_0 and not isNil(var_48_9) and arg_45_1.var_.characterEffect1094ui_story then
				local var_48_14 = 0.5

				arg_45_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_45_1.var_.characterEffect1094ui_story.fillRatio = var_48_14
			end

			local var_48_15 = 0
			local var_48_16 = 0.866666666666667

			if var_48_15 < arg_45_1.time_ and arg_45_1.time_ <= var_48_15 + arg_48_0 then
				local var_48_17 = "stop"
				local var_48_18 = "effect"

				arg_45_1:AudioAction(var_48_17, var_48_18, "se_story_v1_environment_crowd", "se_story_v1_environment_crowd", "")
			end

			local var_48_19 = 0
			local var_48_20 = 0.475

			if var_48_19 < arg_45_1.time_ and arg_45_1.time_ <= var_48_19 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, false)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_21 = arg_45_1:GetWordFromCfg(1109402011)
				local var_48_22 = arg_45_1:FormatText(var_48_21.content)

				arg_45_1.text_.text = var_48_22

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_23 = 19
				local var_48_24 = utf8.len(var_48_22)
				local var_48_25 = var_48_23 <= 0 and var_48_20 or var_48_20 * (var_48_24 / var_48_23)

				if var_48_25 > 0 and var_48_20 < var_48_25 then
					arg_45_1.talkMaxDuration = var_48_25

					if var_48_25 + var_48_19 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_25 + var_48_19
					end
				end

				arg_45_1.text_.text = var_48_22
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_26 = math.max(var_48_20, arg_45_1.talkMaxDuration)

			if var_48_19 <= arg_45_1.time_ and arg_45_1.time_ < var_48_19 + var_48_26 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_19) / var_48_26

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_19 + var_48_26 and arg_45_1.time_ < var_48_19 + var_48_26 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_45_1:InitPlayNodeList()
	end,
	Play1109402012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 1109402012
		arg_49_1.duration_ = 6

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play1109402013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 2

			if var_52_0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_0 + arg_52_0 then
				local var_52_1 = manager.ui.mainCamera.transform.localPosition
				local var_52_2 = Vector3.New(0, 0, 10) + Vector3.New(var_52_1.x, var_52_1.y, 0)
				local var_52_3 = arg_49_1.bgs_.ST03

				var_52_3.transform.localPosition = var_52_2
				var_52_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_52_4 = var_52_3:GetComponent("SpriteRenderer")

				if var_52_4 and var_52_4.sprite then
					local var_52_5 = (var_52_3.transform.localPosition - var_52_1).z
					local var_52_6 = manager.ui.mainCameraCom_
					local var_52_7 = 2 * var_52_5 * Mathf.Tan(var_52_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_52_8 = var_52_7 * var_52_6.aspect
					local var_52_9 = var_52_4.sprite.bounds.size.x
					local var_52_10 = var_52_4.sprite.bounds.size.y
					local var_52_11 = var_52_8 / var_52_9
					local var_52_12 = var_52_7 / var_52_10
					local var_52_13 = var_52_12 < var_52_11 and var_52_11 or var_52_12

					var_52_3.transform.localScale = Vector3.New(var_52_13, var_52_13, 0)
				end

				for iter_52_0, iter_52_1 in pairs(arg_49_1.bgs_) do
					if iter_52_0 ~= "ST03" then
						iter_52_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_52_14 = 0

			if var_52_14 < arg_49_1.time_ and arg_49_1.time_ <= var_52_14 + arg_52_0 then
				arg_49_1.mask_.enabled = true
				arg_49_1.mask_.raycastTarget = true

				arg_49_1:SetGaussion(false)
			end

			local var_52_15 = 2

			if var_52_14 <= arg_49_1.time_ and arg_49_1.time_ < var_52_14 + var_52_15 then
				local var_52_16 = (arg_49_1.time_ - var_52_14) / var_52_15
				local var_52_17 = Color.New(0, 0, 0)

				var_52_17.a = Mathf.Lerp(0, 1, var_52_16)
				arg_49_1.mask_.color = var_52_17
			end

			if arg_49_1.time_ >= var_52_14 + var_52_15 and arg_49_1.time_ < var_52_14 + var_52_15 + arg_52_0 then
				local var_52_18 = Color.New(0, 0, 0)

				var_52_18.a = 1
				arg_49_1.mask_.color = var_52_18
			end

			local var_52_19 = 2

			if var_52_19 < arg_49_1.time_ and arg_49_1.time_ <= var_52_19 + arg_52_0 then
				arg_49_1.mask_.enabled = true
				arg_49_1.mask_.raycastTarget = true

				arg_49_1:SetGaussion(false)
			end

			local var_52_20 = 2

			if var_52_19 <= arg_49_1.time_ and arg_49_1.time_ < var_52_19 + var_52_20 then
				local var_52_21 = (arg_49_1.time_ - var_52_19) / var_52_20
				local var_52_22 = Color.New(0, 0, 0)

				var_52_22.a = Mathf.Lerp(1, 0, var_52_21)
				arg_49_1.mask_.color = var_52_22
			end

			if arg_49_1.time_ >= var_52_19 + var_52_20 and arg_49_1.time_ < var_52_19 + var_52_20 + arg_52_0 then
				local var_52_23 = Color.New(0, 0, 0)
				local var_52_24 = 0

				arg_49_1.mask_.enabled = false
				var_52_23.a = var_52_24
				arg_49_1.mask_.color = var_52_23
			end

			local var_52_25 = arg_49_1.actors_["1094ui_story"].transform
			local var_52_26 = 4

			if var_52_26 < arg_49_1.time_ and arg_49_1.time_ <= var_52_26 + arg_52_0 then
				arg_49_1.var_.moveOldPos1094ui_story = var_52_25.localPosition
			end

			local var_52_27 = 0.001

			if var_52_26 <= arg_49_1.time_ and arg_49_1.time_ < var_52_26 + var_52_27 then
				local var_52_28 = (arg_49_1.time_ - var_52_26) / var_52_27
				local var_52_29 = Vector3.New(0, -0.84, -6.1)

				var_52_25.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1094ui_story, var_52_29, var_52_28)

				local var_52_30 = manager.ui.mainCamera.transform.position - var_52_25.position

				var_52_25.forward = Vector3.New(var_52_30.x, var_52_30.y, var_52_30.z)

				local var_52_31 = var_52_25.localEulerAngles

				var_52_31.z = 0
				var_52_31.x = 0
				var_52_25.localEulerAngles = var_52_31
			end

			if arg_49_1.time_ >= var_52_26 + var_52_27 and arg_49_1.time_ < var_52_26 + var_52_27 + arg_52_0 then
				var_52_25.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_52_32 = manager.ui.mainCamera.transform.position - var_52_25.position

				var_52_25.forward = Vector3.New(var_52_32.x, var_52_32.y, var_52_32.z)

				local var_52_33 = var_52_25.localEulerAngles

				var_52_33.z = 0
				var_52_33.x = 0
				var_52_25.localEulerAngles = var_52_33
			end

			local var_52_34 = arg_49_1.actors_["1094ui_story"]
			local var_52_35 = 4

			if var_52_35 < arg_49_1.time_ and arg_49_1.time_ <= var_52_35 + arg_52_0 and not isNil(var_52_34) and arg_49_1.var_.characterEffect1094ui_story == nil then
				arg_49_1.var_.characterEffect1094ui_story = var_52_34:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_36 = 0.200000002980232

			if var_52_35 <= arg_49_1.time_ and arg_49_1.time_ < var_52_35 + var_52_36 and not isNil(var_52_34) then
				local var_52_37 = (arg_49_1.time_ - var_52_35) / var_52_36

				if arg_49_1.var_.characterEffect1094ui_story and not isNil(var_52_34) then
					arg_49_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= var_52_35 + var_52_36 and arg_49_1.time_ < var_52_35 + var_52_36 + arg_52_0 and not isNil(var_52_34) and arg_49_1.var_.characterEffect1094ui_story then
				arg_49_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_52_38 = 4

			if var_52_38 < arg_49_1.time_ and arg_49_1.time_ <= var_52_38 + arg_52_0 then
				arg_49_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action1_1")
			end

			local var_52_39 = 4

			if var_52_39 < arg_49_1.time_ and arg_49_1.time_ <= var_52_39 + arg_52_0 then
				arg_49_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if arg_49_1.frameCnt_ <= 1 then
				arg_49_1.dialog_:SetActive(false)
			end

			local var_52_40 = 4
			local var_52_41 = 0.1

			if var_52_40 < arg_49_1.time_ and arg_49_1.time_ <= var_52_40 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0

				arg_49_1.dialog_:SetActive(true)

				arg_49_1.dialogCg_.alpha = 0

				local var_52_42 = LeanTween.value(arg_49_1.dialog_, 0, 1, 0.3)

				var_52_42:setOnUpdate(LuaHelper.FloatAction(function(arg_53_0)
					arg_49_1.dialogCg_.alpha = arg_53_0
				end))
				var_52_42:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_49_1.dialog_)
					var_52_42:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_49_1.duration_ = arg_49_1.duration_ + 0.3

				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_43 = arg_49_1:FormatText(StoryNameCfg[181].name)

				arg_49_1.leftNameTxt_.text = var_52_43

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_44 = arg_49_1:GetWordFromCfg(1109402012)
				local var_52_45 = arg_49_1:FormatText(var_52_44.content)

				arg_49_1.text_.text = var_52_45

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_46 = 4
				local var_52_47 = utf8.len(var_52_45)
				local var_52_48 = var_52_46 <= 0 and var_52_41 or var_52_41 * (var_52_47 / var_52_46)

				if var_52_48 > 0 and var_52_41 < var_52_48 then
					arg_49_1.talkMaxDuration = var_52_48
					var_52_40 = var_52_40 + 0.3

					if var_52_48 + var_52_40 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_48 + var_52_40
					end
				end

				arg_49_1.text_.text = var_52_45
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402012", "story_v_side_new_1109402.awb") ~= 0 then
					local var_52_49 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402012", "story_v_side_new_1109402.awb") / 1000

					if var_52_49 + var_52_40 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_49 + var_52_40
					end

					if var_52_44.prefab_name ~= "" and arg_49_1.actors_[var_52_44.prefab_name] ~= nil then
						local var_52_50 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_44.prefab_name].transform, "story_v_side_new_1109402", "1109402012", "story_v_side_new_1109402.awb")

						arg_49_1:RecordAudio("1109402012", var_52_50)
						arg_49_1:RecordAudio("1109402012", var_52_50)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402012", "story_v_side_new_1109402.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402012", "story_v_side_new_1109402.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_51 = var_52_40 + 0.3
			local var_52_52 = math.max(var_52_41, arg_49_1.talkMaxDuration)

			if var_52_51 <= arg_49_1.time_ and arg_49_1.time_ < var_52_51 + var_52_52 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_51) / var_52_52

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_51 + var_52_52 and arg_49_1.time_ < var_52_51 + var_52_52 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_49_1:InitPlayNodeList()
	end,
	Play1109402013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 1109402013
		arg_55_1.duration_ = 5

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play1109402014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = arg_55_1.actors_["1094ui_story"]
			local var_58_1 = 0

			if var_58_1 < arg_55_1.time_ and arg_55_1.time_ <= var_58_1 + arg_58_0 and not isNil(var_58_0) and arg_55_1.var_.characterEffect1094ui_story == nil then
				arg_55_1.var_.characterEffect1094ui_story = var_58_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_2 = 0.200000002980232

			if var_58_1 <= arg_55_1.time_ and arg_55_1.time_ < var_58_1 + var_58_2 and not isNil(var_58_0) then
				local var_58_3 = (arg_55_1.time_ - var_58_1) / var_58_2

				if arg_55_1.var_.characterEffect1094ui_story and not isNil(var_58_0) then
					local var_58_4 = Mathf.Lerp(0, 0.5, var_58_3)

					arg_55_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_55_1.var_.characterEffect1094ui_story.fillRatio = var_58_4
				end
			end

			if arg_55_1.time_ >= var_58_1 + var_58_2 and arg_55_1.time_ < var_58_1 + var_58_2 + arg_58_0 and not isNil(var_58_0) and arg_55_1.var_.characterEffect1094ui_story then
				local var_58_5 = 0.5

				arg_55_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_55_1.var_.characterEffect1094ui_story.fillRatio = var_58_5
			end

			local var_58_6 = 0
			local var_58_7 = 0.075

			if var_58_6 < arg_55_1.time_ and arg_55_1.time_ <= var_58_6 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				local var_58_8 = arg_55_1:FormatText(StoryNameCfg[7].name)

				arg_55_1.leftNameTxt_.text = var_58_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, true)
				arg_55_1.iconController_:SetSelectedState("hero")

				arg_55_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_55_1.callingController_:SetSelectedState("normal")

				arg_55_1.keyicon_.color = Color.New(1, 1, 1)
				arg_55_1.icon_.color = Color.New(1, 1, 1)

				local var_58_9 = arg_55_1:GetWordFromCfg(1109402013)
				local var_58_10 = arg_55_1:FormatText(var_58_9.content)

				arg_55_1.text_.text = var_58_10

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_11 = 3
				local var_58_12 = utf8.len(var_58_10)
				local var_58_13 = var_58_11 <= 0 and var_58_7 or var_58_7 * (var_58_12 / var_58_11)

				if var_58_13 > 0 and var_58_7 < var_58_13 then
					arg_55_1.talkMaxDuration = var_58_13

					if var_58_13 + var_58_6 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_13 + var_58_6
					end
				end

				arg_55_1.text_.text = var_58_10
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)
				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_14 = math.max(var_58_7, arg_55_1.talkMaxDuration)

			if var_58_6 <= arg_55_1.time_ and arg_55_1.time_ < var_58_6 + var_58_14 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_6) / var_58_14

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_6 + var_58_14 and arg_55_1.time_ < var_58_6 + var_58_14 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play1109402014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 1109402014
		arg_59_1.duration_ = 6.6

		local var_59_0 = {
			ja = 5.566,
			ko = 6.6,
			zh = 6.6
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
				arg_59_0:Play1109402015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = arg_59_1.actors_["1094ui_story"].transform
			local var_62_1 = 0

			if var_62_1 < arg_59_1.time_ and arg_59_1.time_ <= var_62_1 + arg_62_0 then
				arg_59_1.var_.moveOldPos1094ui_story = var_62_0.localPosition
			end

			local var_62_2 = 0.001

			if var_62_1 <= arg_59_1.time_ and arg_59_1.time_ < var_62_1 + var_62_2 then
				local var_62_3 = (arg_59_1.time_ - var_62_1) / var_62_2
				local var_62_4 = Vector3.New(0, -0.84, -6.1)

				var_62_0.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos1094ui_story, var_62_4, var_62_3)

				local var_62_5 = manager.ui.mainCamera.transform.position - var_62_0.position

				var_62_0.forward = Vector3.New(var_62_5.x, var_62_5.y, var_62_5.z)

				local var_62_6 = var_62_0.localEulerAngles

				var_62_6.z = 0
				var_62_6.x = 0
				var_62_0.localEulerAngles = var_62_6
			end

			if arg_59_1.time_ >= var_62_1 + var_62_2 and arg_59_1.time_ < var_62_1 + var_62_2 + arg_62_0 then
				var_62_0.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_62_7 = manager.ui.mainCamera.transform.position - var_62_0.position

				var_62_0.forward = Vector3.New(var_62_7.x, var_62_7.y, var_62_7.z)

				local var_62_8 = var_62_0.localEulerAngles

				var_62_8.z = 0
				var_62_8.x = 0
				var_62_0.localEulerAngles = var_62_8
			end

			local var_62_9 = arg_59_1.actors_["1094ui_story"]
			local var_62_10 = 0

			if var_62_10 < arg_59_1.time_ and arg_59_1.time_ <= var_62_10 + arg_62_0 and not isNil(var_62_9) and arg_59_1.var_.characterEffect1094ui_story == nil then
				arg_59_1.var_.characterEffect1094ui_story = var_62_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_11 = 0.200000002980232

			if var_62_10 <= arg_59_1.time_ and arg_59_1.time_ < var_62_10 + var_62_11 and not isNil(var_62_9) then
				local var_62_12 = (arg_59_1.time_ - var_62_10) / var_62_11

				if arg_59_1.var_.characterEffect1094ui_story and not isNil(var_62_9) then
					arg_59_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_59_1.time_ >= var_62_10 + var_62_11 and arg_59_1.time_ < var_62_10 + var_62_11 + arg_62_0 and not isNil(var_62_9) and arg_59_1.var_.characterEffect1094ui_story then
				arg_59_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_62_13 = 0

			if var_62_13 < arg_59_1.time_ and arg_59_1.time_ <= var_62_13 + arg_62_0 then
				arg_59_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action5_1")
			end

			local var_62_14 = 0

			if var_62_14 < arg_59_1.time_ and arg_59_1.time_ <= var_62_14 + arg_62_0 then
				arg_59_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_62_15 = 0
			local var_62_16 = 0.675

			if var_62_15 < arg_59_1.time_ and arg_59_1.time_ <= var_62_15 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				local var_62_17 = arg_59_1:FormatText(StoryNameCfg[181].name)

				arg_59_1.leftNameTxt_.text = var_62_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_18 = arg_59_1:GetWordFromCfg(1109402014)
				local var_62_19 = arg_59_1:FormatText(var_62_18.content)

				arg_59_1.text_.text = var_62_19

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_20 = 27
				local var_62_21 = utf8.len(var_62_19)
				local var_62_22 = var_62_20 <= 0 and var_62_16 or var_62_16 * (var_62_21 / var_62_20)

				if var_62_22 > 0 and var_62_16 < var_62_22 then
					arg_59_1.talkMaxDuration = var_62_22

					if var_62_22 + var_62_15 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_22 + var_62_15
					end
				end

				arg_59_1.text_.text = var_62_19
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402014", "story_v_side_new_1109402.awb") ~= 0 then
					local var_62_23 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402014", "story_v_side_new_1109402.awb") / 1000

					if var_62_23 + var_62_15 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_23 + var_62_15
					end

					if var_62_18.prefab_name ~= "" and arg_59_1.actors_[var_62_18.prefab_name] ~= nil then
						local var_62_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_18.prefab_name].transform, "story_v_side_new_1109402", "1109402014", "story_v_side_new_1109402.awb")

						arg_59_1:RecordAudio("1109402014", var_62_24)
						arg_59_1:RecordAudio("1109402014", var_62_24)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402014", "story_v_side_new_1109402.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402014", "story_v_side_new_1109402.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_25 = math.max(var_62_16, arg_59_1.talkMaxDuration)

			if var_62_15 <= arg_59_1.time_ and arg_59_1.time_ < var_62_15 + var_62_25 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_15) / var_62_25

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_15 + var_62_25 and arg_59_1.time_ < var_62_15 + var_62_25 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_59_1:InitPlayNodeList()
	end,
	Play1109402015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 1109402015
		arg_63_1.duration_ = 5

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play1109402016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = arg_63_1.actors_["1094ui_story"]
			local var_66_1 = 0

			if var_66_1 < arg_63_1.time_ and arg_63_1.time_ <= var_66_1 + arg_66_0 and not isNil(var_66_0) and arg_63_1.var_.characterEffect1094ui_story == nil then
				arg_63_1.var_.characterEffect1094ui_story = var_66_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_2 = 0.200000002980232

			if var_66_1 <= arg_63_1.time_ and arg_63_1.time_ < var_66_1 + var_66_2 and not isNil(var_66_0) then
				local var_66_3 = (arg_63_1.time_ - var_66_1) / var_66_2

				if arg_63_1.var_.characterEffect1094ui_story and not isNil(var_66_0) then
					local var_66_4 = Mathf.Lerp(0, 0.5, var_66_3)

					arg_63_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_63_1.var_.characterEffect1094ui_story.fillRatio = var_66_4
				end
			end

			if arg_63_1.time_ >= var_66_1 + var_66_2 and arg_63_1.time_ < var_66_1 + var_66_2 + arg_66_0 and not isNil(var_66_0) and arg_63_1.var_.characterEffect1094ui_story then
				local var_66_5 = 0.5

				arg_63_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_63_1.var_.characterEffect1094ui_story.fillRatio = var_66_5
			end

			local var_66_6 = 0
			local var_66_7 = 0.7

			if var_66_6 < arg_63_1.time_ and arg_63_1.time_ <= var_66_6 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				local var_66_8 = arg_63_1:FormatText(StoryNameCfg[7].name)

				arg_63_1.leftNameTxt_.text = var_66_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, true)
				arg_63_1.iconController_:SetSelectedState("hero")

				arg_63_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_63_1.callingController_:SetSelectedState("normal")

				arg_63_1.keyicon_.color = Color.New(1, 1, 1)
				arg_63_1.icon_.color = Color.New(1, 1, 1)

				local var_66_9 = arg_63_1:GetWordFromCfg(1109402015)
				local var_66_10 = arg_63_1:FormatText(var_66_9.content)

				arg_63_1.text_.text = var_66_10

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_11 = 28
				local var_66_12 = utf8.len(var_66_10)
				local var_66_13 = var_66_11 <= 0 and var_66_7 or var_66_7 * (var_66_12 / var_66_11)

				if var_66_13 > 0 and var_66_7 < var_66_13 then
					arg_63_1.talkMaxDuration = var_66_13

					if var_66_13 + var_66_6 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_13 + var_66_6
					end
				end

				arg_63_1.text_.text = var_66_10
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)
				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_14 = math.max(var_66_7, arg_63_1.talkMaxDuration)

			if var_66_6 <= arg_63_1.time_ and arg_63_1.time_ < var_66_6 + var_66_14 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_6) / var_66_14

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_6 + var_66_14 and arg_63_1.time_ < var_66_6 + var_66_14 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play1109402016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 1109402016
		arg_67_1.duration_ = 5

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play1109402017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 0
			local var_70_1 = 0.85

			if var_70_0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_0 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				local var_70_2 = arg_67_1:FormatText(StoryNameCfg[7].name)

				arg_67_1.leftNameTxt_.text = var_70_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, true)
				arg_67_1.iconController_:SetSelectedState("hero")

				arg_67_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_67_1.callingController_:SetSelectedState("normal")

				arg_67_1.keyicon_.color = Color.New(1, 1, 1)
				arg_67_1.icon_.color = Color.New(1, 1, 1)

				local var_70_3 = arg_67_1:GetWordFromCfg(1109402016)
				local var_70_4 = arg_67_1:FormatText(var_70_3.content)

				arg_67_1.text_.text = var_70_4

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_5 = 34
				local var_70_6 = utf8.len(var_70_4)
				local var_70_7 = var_70_5 <= 0 and var_70_1 or var_70_1 * (var_70_6 / var_70_5)

				if var_70_7 > 0 and var_70_1 < var_70_7 then
					arg_67_1.talkMaxDuration = var_70_7

					if var_70_7 + var_70_0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_7 + var_70_0
					end
				end

				arg_67_1.text_.text = var_70_4
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)
				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_8 = math.max(var_70_1, arg_67_1.talkMaxDuration)

			if var_70_0 <= arg_67_1.time_ and arg_67_1.time_ < var_70_0 + var_70_8 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_0) / var_70_8

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_0 + var_70_8 and arg_67_1.time_ < var_70_0 + var_70_8 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play1109402017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 1109402017
		arg_71_1.duration_ = 2.7

		local var_71_0 = {
			ja = 2.7,
			ko = 1.999999999999,
			zh = 1.999999999999
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
				arg_71_0:Play1109402018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = arg_71_1.actors_["1094ui_story"].transform
			local var_74_1 = 0

			if var_74_1 < arg_71_1.time_ and arg_71_1.time_ <= var_74_1 + arg_74_0 then
				arg_71_1.var_.moveOldPos1094ui_story = var_74_0.localPosition
			end

			local var_74_2 = 0.001

			if var_74_1 <= arg_71_1.time_ and arg_71_1.time_ < var_74_1 + var_74_2 then
				local var_74_3 = (arg_71_1.time_ - var_74_1) / var_74_2
				local var_74_4 = Vector3.New(0, -0.84, -6.1)

				var_74_0.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos1094ui_story, var_74_4, var_74_3)

				local var_74_5 = manager.ui.mainCamera.transform.position - var_74_0.position

				var_74_0.forward = Vector3.New(var_74_5.x, var_74_5.y, var_74_5.z)

				local var_74_6 = var_74_0.localEulerAngles

				var_74_6.z = 0
				var_74_6.x = 0
				var_74_0.localEulerAngles = var_74_6
			end

			if arg_71_1.time_ >= var_74_1 + var_74_2 and arg_71_1.time_ < var_74_1 + var_74_2 + arg_74_0 then
				var_74_0.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_74_7 = manager.ui.mainCamera.transform.position - var_74_0.position

				var_74_0.forward = Vector3.New(var_74_7.x, var_74_7.y, var_74_7.z)

				local var_74_8 = var_74_0.localEulerAngles

				var_74_8.z = 0
				var_74_8.x = 0
				var_74_0.localEulerAngles = var_74_8
			end

			local var_74_9 = arg_71_1.actors_["1094ui_story"]
			local var_74_10 = 0

			if var_74_10 < arg_71_1.time_ and arg_71_1.time_ <= var_74_10 + arg_74_0 and not isNil(var_74_9) and arg_71_1.var_.characterEffect1094ui_story == nil then
				arg_71_1.var_.characterEffect1094ui_story = var_74_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_11 = 0.200000002980232

			if var_74_10 <= arg_71_1.time_ and arg_71_1.time_ < var_74_10 + var_74_11 and not isNil(var_74_9) then
				local var_74_12 = (arg_71_1.time_ - var_74_10) / var_74_11

				if arg_71_1.var_.characterEffect1094ui_story and not isNil(var_74_9) then
					arg_71_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_71_1.time_ >= var_74_10 + var_74_11 and arg_71_1.time_ < var_74_10 + var_74_11 + arg_74_0 and not isNil(var_74_9) and arg_71_1.var_.characterEffect1094ui_story then
				arg_71_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_74_13 = 0

			if var_74_13 < arg_71_1.time_ and arg_71_1.time_ <= var_74_13 + arg_74_0 then
				arg_71_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_74_14 = 0
			local var_74_15 = 0.275

			if var_74_14 < arg_71_1.time_ and arg_71_1.time_ <= var_74_14 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				local var_74_16 = arg_71_1:FormatText(StoryNameCfg[181].name)

				arg_71_1.leftNameTxt_.text = var_74_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_17 = arg_71_1:GetWordFromCfg(1109402017)
				local var_74_18 = arg_71_1:FormatText(var_74_17.content)

				arg_71_1.text_.text = var_74_18

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_19 = 11
				local var_74_20 = utf8.len(var_74_18)
				local var_74_21 = var_74_19 <= 0 and var_74_15 or var_74_15 * (var_74_20 / var_74_19)

				if var_74_21 > 0 and var_74_15 < var_74_21 then
					arg_71_1.talkMaxDuration = var_74_21

					if var_74_21 + var_74_14 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_21 + var_74_14
					end
				end

				arg_71_1.text_.text = var_74_18
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402017", "story_v_side_new_1109402.awb") ~= 0 then
					local var_74_22 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402017", "story_v_side_new_1109402.awb") / 1000

					if var_74_22 + var_74_14 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_22 + var_74_14
					end

					if var_74_17.prefab_name ~= "" and arg_71_1.actors_[var_74_17.prefab_name] ~= nil then
						local var_74_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_17.prefab_name].transform, "story_v_side_new_1109402", "1109402017", "story_v_side_new_1109402.awb")

						arg_71_1:RecordAudio("1109402017", var_74_23)
						arg_71_1:RecordAudio("1109402017", var_74_23)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402017", "story_v_side_new_1109402.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402017", "story_v_side_new_1109402.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_24 = math.max(var_74_15, arg_71_1.talkMaxDuration)

			if var_74_14 <= arg_71_1.time_ and arg_71_1.time_ < var_74_14 + var_74_24 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_14) / var_74_24

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_14 + var_74_24 and arg_71_1.time_ < var_74_14 + var_74_24 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_71_1:InitPlayNodeList()
	end,
	Play1109402018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 1109402018
		arg_75_1.duration_ = 5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play1109402019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = arg_75_1.actors_["1094ui_story"]
			local var_78_1 = 0

			if var_78_1 < arg_75_1.time_ and arg_75_1.time_ <= var_78_1 + arg_78_0 and not isNil(var_78_0) and arg_75_1.var_.characterEffect1094ui_story == nil then
				arg_75_1.var_.characterEffect1094ui_story = var_78_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_2 = 0.200000002980232

			if var_78_1 <= arg_75_1.time_ and arg_75_1.time_ < var_78_1 + var_78_2 and not isNil(var_78_0) then
				local var_78_3 = (arg_75_1.time_ - var_78_1) / var_78_2

				if arg_75_1.var_.characterEffect1094ui_story and not isNil(var_78_0) then
					local var_78_4 = Mathf.Lerp(0, 0.5, var_78_3)

					arg_75_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_75_1.var_.characterEffect1094ui_story.fillRatio = var_78_4
				end
			end

			if arg_75_1.time_ >= var_78_1 + var_78_2 and arg_75_1.time_ < var_78_1 + var_78_2 + arg_78_0 and not isNil(var_78_0) and arg_75_1.var_.characterEffect1094ui_story then
				local var_78_5 = 0.5

				arg_75_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_75_1.var_.characterEffect1094ui_story.fillRatio = var_78_5
			end

			local var_78_6 = 0
			local var_78_7 = 1.125

			if var_78_6 < arg_75_1.time_ and arg_75_1.time_ <= var_78_6 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				local var_78_8 = arg_75_1:FormatText(StoryNameCfg[7].name)

				arg_75_1.leftNameTxt_.text = var_78_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, true)
				arg_75_1.iconController_:SetSelectedState("hero")

				arg_75_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_75_1.callingController_:SetSelectedState("normal")

				arg_75_1.keyicon_.color = Color.New(1, 1, 1)
				arg_75_1.icon_.color = Color.New(1, 1, 1)

				local var_78_9 = arg_75_1:GetWordFromCfg(1109402018)
				local var_78_10 = arg_75_1:FormatText(var_78_9.content)

				arg_75_1.text_.text = var_78_10

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_11 = 45
				local var_78_12 = utf8.len(var_78_10)
				local var_78_13 = var_78_11 <= 0 and var_78_7 or var_78_7 * (var_78_12 / var_78_11)

				if var_78_13 > 0 and var_78_7 < var_78_13 then
					arg_75_1.talkMaxDuration = var_78_13

					if var_78_13 + var_78_6 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_13 + var_78_6
					end
				end

				arg_75_1.text_.text = var_78_10
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)
				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_14 = math.max(var_78_7, arg_75_1.talkMaxDuration)

			if var_78_6 <= arg_75_1.time_ and arg_75_1.time_ < var_78_6 + var_78_14 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_6) / var_78_14

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_6 + var_78_14 and arg_75_1.time_ < var_78_6 + var_78_14 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play1109402019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 1109402019
		arg_79_1.duration_ = 5

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play1109402020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = 0
			local var_82_1 = 0.65

			if var_82_0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_0 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, false)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_2 = arg_79_1:GetWordFromCfg(1109402019)
				local var_82_3 = arg_79_1:FormatText(var_82_2.content)

				arg_79_1.text_.text = var_82_3

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_4 = 26
				local var_82_5 = utf8.len(var_82_3)
				local var_82_6 = var_82_4 <= 0 and var_82_1 or var_82_1 * (var_82_5 / var_82_4)

				if var_82_6 > 0 and var_82_1 < var_82_6 then
					arg_79_1.talkMaxDuration = var_82_6

					if var_82_6 + var_82_0 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_6 + var_82_0
					end
				end

				arg_79_1.text_.text = var_82_3
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_7 = math.max(var_82_1, arg_79_1.talkMaxDuration)

			if var_82_0 <= arg_79_1.time_ and arg_79_1.time_ < var_82_0 + var_82_7 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_0) / var_82_7

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_0 + var_82_7 and arg_79_1.time_ < var_82_0 + var_82_7 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play1109402020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 1109402020
		arg_83_1.duration_ = 2

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play1109402021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = 0

			if var_86_0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_0 + arg_86_0 then
				arg_83_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action5_2")
			end

			local var_86_1 = 0

			if var_86_1 < arg_83_1.time_ and arg_83_1.time_ <= var_86_1 + arg_86_0 then
				arg_83_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_86_2 = arg_83_1.actors_["1094ui_story"]
			local var_86_3 = 0

			if var_86_3 < arg_83_1.time_ and arg_83_1.time_ <= var_86_3 + arg_86_0 and not isNil(var_86_2) and arg_83_1.var_.characterEffect1094ui_story == nil then
				arg_83_1.var_.characterEffect1094ui_story = var_86_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_4 = 0.2

			if var_86_3 <= arg_83_1.time_ and arg_83_1.time_ < var_86_3 + var_86_4 and not isNil(var_86_2) then
				local var_86_5 = (arg_83_1.time_ - var_86_3) / var_86_4

				if arg_83_1.var_.characterEffect1094ui_story and not isNil(var_86_2) then
					arg_83_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_83_1.time_ >= var_86_3 + var_86_4 and arg_83_1.time_ < var_86_3 + var_86_4 + arg_86_0 and not isNil(var_86_2) and arg_83_1.var_.characterEffect1094ui_story then
				arg_83_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_86_6 = 0
			local var_86_7 = 0.625

			if var_86_6 < arg_83_1.time_ and arg_83_1.time_ <= var_86_6 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, false)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_8 = arg_83_1:GetWordFromCfg(1109402020)
				local var_86_9 = arg_83_1:FormatText(var_86_8.content)

				arg_83_1.text_.text = var_86_9

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_10 = 24
				local var_86_11 = utf8.len(var_86_9)
				local var_86_12 = var_86_10 <= 0 and var_86_7 or var_86_7 * (var_86_11 / var_86_10)

				if var_86_12 > 0 and var_86_7 < var_86_12 then
					arg_83_1.talkMaxDuration = var_86_12

					if var_86_12 + var_86_6 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_12 + var_86_6
					end
				end

				arg_83_1.text_.text = var_86_9
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402020", "story_v_side_new_1109402.awb") ~= 0 then
					local var_86_13 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402020", "story_v_side_new_1109402.awb") / 1000

					if var_86_13 + var_86_6 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_13 + var_86_6
					end

					if var_86_8.prefab_name ~= "" and arg_83_1.actors_[var_86_8.prefab_name] ~= nil then
						local var_86_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_8.prefab_name].transform, "story_v_side_new_1109402", "1109402020", "story_v_side_new_1109402.awb")

						arg_83_1:RecordAudio("1109402020", var_86_14)
						arg_83_1:RecordAudio("1109402020", var_86_14)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402020", "story_v_side_new_1109402.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402020", "story_v_side_new_1109402.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_15 = math.max(var_86_7, arg_83_1.talkMaxDuration)

			if var_86_6 <= arg_83_1.time_ and arg_83_1.time_ < var_86_6 + var_86_15 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_6) / var_86_15

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_6 + var_86_15 and arg_83_1.time_ < var_86_6 + var_86_15 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play1109402021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 1109402021
		arg_87_1.duration_ = 5

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play1109402022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = 0

			if var_90_0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_0 + arg_90_0 then
				arg_87_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_90_1 = 0
			local var_90_2 = 0.5

			if var_90_1 < arg_87_1.time_ and arg_87_1.time_ <= var_90_1 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, false)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_3 = arg_87_1:GetWordFromCfg(1109402021)
				local var_90_4 = arg_87_1:FormatText(var_90_3.content)

				arg_87_1.text_.text = var_90_4

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_5 = 20
				local var_90_6 = utf8.len(var_90_4)
				local var_90_7 = var_90_5 <= 0 and var_90_2 or var_90_2 * (var_90_6 / var_90_5)

				if var_90_7 > 0 and var_90_2 < var_90_7 then
					arg_87_1.talkMaxDuration = var_90_7

					if var_90_7 + var_90_1 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_7 + var_90_1
					end
				end

				arg_87_1.text_.text = var_90_4
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)
				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_8 = math.max(var_90_2, arg_87_1.talkMaxDuration)

			if var_90_1 <= arg_87_1.time_ and arg_87_1.time_ < var_90_1 + var_90_8 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_1) / var_90_8

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_1 + var_90_8 and arg_87_1.time_ < var_90_1 + var_90_8 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play1109402022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 1109402022
		arg_91_1.duration_ = 3.37

		local var_91_0 = {
			ja = 2.7,
			ko = 3.366,
			zh = 3.366
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
				arg_91_0:Play1109402023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = arg_91_1.actors_["1094ui_story"].transform
			local var_94_1 = 0

			if var_94_1 < arg_91_1.time_ and arg_91_1.time_ <= var_94_1 + arg_94_0 then
				arg_91_1.var_.moveOldPos1094ui_story = var_94_0.localPosition
			end

			local var_94_2 = 0.001

			if var_94_1 <= arg_91_1.time_ and arg_91_1.time_ < var_94_1 + var_94_2 then
				local var_94_3 = (arg_91_1.time_ - var_94_1) / var_94_2
				local var_94_4 = Vector3.New(0, -0.84, -6.1)

				var_94_0.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos1094ui_story, var_94_4, var_94_3)

				local var_94_5 = manager.ui.mainCamera.transform.position - var_94_0.position

				var_94_0.forward = Vector3.New(var_94_5.x, var_94_5.y, var_94_5.z)

				local var_94_6 = var_94_0.localEulerAngles

				var_94_6.z = 0
				var_94_6.x = 0
				var_94_0.localEulerAngles = var_94_6
			end

			if arg_91_1.time_ >= var_94_1 + var_94_2 and arg_91_1.time_ < var_94_1 + var_94_2 + arg_94_0 then
				var_94_0.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_94_7 = manager.ui.mainCamera.transform.position - var_94_0.position

				var_94_0.forward = Vector3.New(var_94_7.x, var_94_7.y, var_94_7.z)

				local var_94_8 = var_94_0.localEulerAngles

				var_94_8.z = 0
				var_94_8.x = 0
				var_94_0.localEulerAngles = var_94_8
			end

			local var_94_9 = arg_91_1.actors_["1094ui_story"]
			local var_94_10 = 0

			if var_94_10 < arg_91_1.time_ and arg_91_1.time_ <= var_94_10 + arg_94_0 and not isNil(var_94_9) and arg_91_1.var_.characterEffect1094ui_story == nil then
				arg_91_1.var_.characterEffect1094ui_story = var_94_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_11 = 0.200000002980232

			if var_94_10 <= arg_91_1.time_ and arg_91_1.time_ < var_94_10 + var_94_11 and not isNil(var_94_9) then
				local var_94_12 = (arg_91_1.time_ - var_94_10) / var_94_11

				if arg_91_1.var_.characterEffect1094ui_story and not isNil(var_94_9) then
					arg_91_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_91_1.time_ >= var_94_10 + var_94_11 and arg_91_1.time_ < var_94_10 + var_94_11 + arg_94_0 and not isNil(var_94_9) and arg_91_1.var_.characterEffect1094ui_story then
				arg_91_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_94_13 = 0

			if var_94_13 < arg_91_1.time_ and arg_91_1.time_ <= var_94_13 + arg_94_0 then
				arg_91_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action3_1")
			end

			local var_94_14 = 0

			if var_94_14 < arg_91_1.time_ and arg_91_1.time_ <= var_94_14 + arg_94_0 then
				arg_91_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_94_15 = 0
			local var_94_16 = 0.3

			if var_94_15 < arg_91_1.time_ and arg_91_1.time_ <= var_94_15 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				local var_94_17 = arg_91_1:FormatText(StoryNameCfg[181].name)

				arg_91_1.leftNameTxt_.text = var_94_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_18 = arg_91_1:GetWordFromCfg(1109402022)
				local var_94_19 = arg_91_1:FormatText(var_94_18.content)

				arg_91_1.text_.text = var_94_19

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_20 = 12
				local var_94_21 = utf8.len(var_94_19)
				local var_94_22 = var_94_20 <= 0 and var_94_16 or var_94_16 * (var_94_21 / var_94_20)

				if var_94_22 > 0 and var_94_16 < var_94_22 then
					arg_91_1.talkMaxDuration = var_94_22

					if var_94_22 + var_94_15 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_22 + var_94_15
					end
				end

				arg_91_1.text_.text = var_94_19
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402022", "story_v_side_new_1109402.awb") ~= 0 then
					local var_94_23 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402022", "story_v_side_new_1109402.awb") / 1000

					if var_94_23 + var_94_15 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_23 + var_94_15
					end

					if var_94_18.prefab_name ~= "" and arg_91_1.actors_[var_94_18.prefab_name] ~= nil then
						local var_94_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_18.prefab_name].transform, "story_v_side_new_1109402", "1109402022", "story_v_side_new_1109402.awb")

						arg_91_1:RecordAudio("1109402022", var_94_24)
						arg_91_1:RecordAudio("1109402022", var_94_24)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402022", "story_v_side_new_1109402.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402022", "story_v_side_new_1109402.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_25 = math.max(var_94_16, arg_91_1.talkMaxDuration)

			if var_94_15 <= arg_91_1.time_ and arg_91_1.time_ < var_94_15 + var_94_25 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_15) / var_94_25

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_15 + var_94_25 and arg_91_1.time_ < var_94_15 + var_94_25 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_91_1:InitPlayNodeList()
	end,
	Play1109402023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 1109402023
		arg_95_1.duration_ = 5

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play1109402024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = arg_95_1.actors_["1094ui_story"]
			local var_98_1 = 0

			if var_98_1 < arg_95_1.time_ and arg_95_1.time_ <= var_98_1 + arg_98_0 and not isNil(var_98_0) and arg_95_1.var_.characterEffect1094ui_story == nil then
				arg_95_1.var_.characterEffect1094ui_story = var_98_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_2 = 0.200000002980232

			if var_98_1 <= arg_95_1.time_ and arg_95_1.time_ < var_98_1 + var_98_2 and not isNil(var_98_0) then
				local var_98_3 = (arg_95_1.time_ - var_98_1) / var_98_2

				if arg_95_1.var_.characterEffect1094ui_story and not isNil(var_98_0) then
					local var_98_4 = Mathf.Lerp(0, 0.5, var_98_3)

					arg_95_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_95_1.var_.characterEffect1094ui_story.fillRatio = var_98_4
				end
			end

			if arg_95_1.time_ >= var_98_1 + var_98_2 and arg_95_1.time_ < var_98_1 + var_98_2 + arg_98_0 and not isNil(var_98_0) and arg_95_1.var_.characterEffect1094ui_story then
				local var_98_5 = 0.5

				arg_95_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_95_1.var_.characterEffect1094ui_story.fillRatio = var_98_5
			end

			local var_98_6 = 0
			local var_98_7 = 0.5

			if var_98_6 < arg_95_1.time_ and arg_95_1.time_ <= var_98_6 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				local var_98_8 = arg_95_1:FormatText(StoryNameCfg[7].name)

				arg_95_1.leftNameTxt_.text = var_98_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, true)
				arg_95_1.iconController_:SetSelectedState("hero")

				arg_95_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_95_1.callingController_:SetSelectedState("normal")

				arg_95_1.keyicon_.color = Color.New(1, 1, 1)
				arg_95_1.icon_.color = Color.New(1, 1, 1)

				local var_98_9 = arg_95_1:GetWordFromCfg(1109402023)
				local var_98_10 = arg_95_1:FormatText(var_98_9.content)

				arg_95_1.text_.text = var_98_10

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_11 = 20
				local var_98_12 = utf8.len(var_98_10)
				local var_98_13 = var_98_11 <= 0 and var_98_7 or var_98_7 * (var_98_12 / var_98_11)

				if var_98_13 > 0 and var_98_7 < var_98_13 then
					arg_95_1.talkMaxDuration = var_98_13

					if var_98_13 + var_98_6 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_13 + var_98_6
					end
				end

				arg_95_1.text_.text = var_98_10
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)
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

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play1109402024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 1109402024
		arg_99_1.duration_ = 5

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play1109402025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = 0
			local var_102_1 = 0.15

			if var_102_0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_0 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				local var_102_2 = arg_99_1:FormatText(StoryNameCfg[7].name)

				arg_99_1.leftNameTxt_.text = var_102_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, true)
				arg_99_1.iconController_:SetSelectedState("hero")

				arg_99_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_99_1.callingController_:SetSelectedState("normal")

				arg_99_1.keyicon_.color = Color.New(1, 1, 1)
				arg_99_1.icon_.color = Color.New(1, 1, 1)

				local var_102_3 = arg_99_1:GetWordFromCfg(1109402024)
				local var_102_4 = arg_99_1:FormatText(var_102_3.content)

				arg_99_1.text_.text = var_102_4

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_5 = 6
				local var_102_6 = utf8.len(var_102_4)
				local var_102_7 = var_102_5 <= 0 and var_102_1 or var_102_1 * (var_102_6 / var_102_5)

				if var_102_7 > 0 and var_102_1 < var_102_7 then
					arg_99_1.talkMaxDuration = var_102_7

					if var_102_7 + var_102_0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_7 + var_102_0
					end
				end

				arg_99_1.text_.text = var_102_4
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)
				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_8 = math.max(var_102_1, arg_99_1.talkMaxDuration)

			if var_102_0 <= arg_99_1.time_ and arg_99_1.time_ < var_102_0 + var_102_8 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_0) / var_102_8

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_0 + var_102_8 and arg_99_1.time_ < var_102_0 + var_102_8 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play1109402025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 1109402025
		arg_103_1.duration_ = 5.4

		local var_103_0 = {
			ja = 4.8,
			ko = 5.4,
			zh = 5.4
		}
		local var_103_1 = manager.audio:GetLocalizationFlag()

		if var_103_0[var_103_1] ~= nil then
			arg_103_1.duration_ = var_103_0[var_103_1]
		end

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play1109402026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = arg_103_1.actors_["1094ui_story"].transform
			local var_106_1 = 0

			if var_106_1 < arg_103_1.time_ and arg_103_1.time_ <= var_106_1 + arg_106_0 then
				arg_103_1.var_.moveOldPos1094ui_story = var_106_0.localPosition
			end

			local var_106_2 = 0.001

			if var_106_1 <= arg_103_1.time_ and arg_103_1.time_ < var_106_1 + var_106_2 then
				local var_106_3 = (arg_103_1.time_ - var_106_1) / var_106_2
				local var_106_4 = Vector3.New(0, -0.84, -6.1)

				var_106_0.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPos1094ui_story, var_106_4, var_106_3)

				local var_106_5 = manager.ui.mainCamera.transform.position - var_106_0.position

				var_106_0.forward = Vector3.New(var_106_5.x, var_106_5.y, var_106_5.z)

				local var_106_6 = var_106_0.localEulerAngles

				var_106_6.z = 0
				var_106_6.x = 0
				var_106_0.localEulerAngles = var_106_6
			end

			if arg_103_1.time_ >= var_106_1 + var_106_2 and arg_103_1.time_ < var_106_1 + var_106_2 + arg_106_0 then
				var_106_0.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_106_7 = manager.ui.mainCamera.transform.position - var_106_0.position

				var_106_0.forward = Vector3.New(var_106_7.x, var_106_7.y, var_106_7.z)

				local var_106_8 = var_106_0.localEulerAngles

				var_106_8.z = 0
				var_106_8.x = 0
				var_106_0.localEulerAngles = var_106_8
			end

			local var_106_9 = arg_103_1.actors_["1094ui_story"]
			local var_106_10 = 0

			if var_106_10 < arg_103_1.time_ and arg_103_1.time_ <= var_106_10 + arg_106_0 and not isNil(var_106_9) and arg_103_1.var_.characterEffect1094ui_story == nil then
				arg_103_1.var_.characterEffect1094ui_story = var_106_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_11 = 0.200000002980232

			if var_106_10 <= arg_103_1.time_ and arg_103_1.time_ < var_106_10 + var_106_11 and not isNil(var_106_9) then
				local var_106_12 = (arg_103_1.time_ - var_106_10) / var_106_11

				if arg_103_1.var_.characterEffect1094ui_story and not isNil(var_106_9) then
					arg_103_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_103_1.time_ >= var_106_10 + var_106_11 and arg_103_1.time_ < var_106_10 + var_106_11 + arg_106_0 and not isNil(var_106_9) and arg_103_1.var_.characterEffect1094ui_story then
				arg_103_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_106_13 = 0

			if var_106_13 < arg_103_1.time_ and arg_103_1.time_ <= var_106_13 + arg_106_0 then
				arg_103_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action3_2")
			end

			local var_106_14 = 0

			if var_106_14 < arg_103_1.time_ and arg_103_1.time_ <= var_106_14 + arg_106_0 then
				arg_103_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_106_15 = 0
			local var_106_16 = 0.325

			if var_106_15 < arg_103_1.time_ and arg_103_1.time_ <= var_106_15 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				local var_106_17 = arg_103_1:FormatText(StoryNameCfg[181].name)

				arg_103_1.leftNameTxt_.text = var_106_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_18 = arg_103_1:GetWordFromCfg(1109402025)
				local var_106_19 = arg_103_1:FormatText(var_106_18.content)

				arg_103_1.text_.text = var_106_19

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_20 = 13
				local var_106_21 = utf8.len(var_106_19)
				local var_106_22 = var_106_20 <= 0 and var_106_16 or var_106_16 * (var_106_21 / var_106_20)

				if var_106_22 > 0 and var_106_16 < var_106_22 then
					arg_103_1.talkMaxDuration = var_106_22

					if var_106_22 + var_106_15 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_22 + var_106_15
					end
				end

				arg_103_1.text_.text = var_106_19
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402025", "story_v_side_new_1109402.awb") ~= 0 then
					local var_106_23 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402025", "story_v_side_new_1109402.awb") / 1000

					if var_106_23 + var_106_15 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_23 + var_106_15
					end

					if var_106_18.prefab_name ~= "" and arg_103_1.actors_[var_106_18.prefab_name] ~= nil then
						local var_106_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_18.prefab_name].transform, "story_v_side_new_1109402", "1109402025", "story_v_side_new_1109402.awb")

						arg_103_1:RecordAudio("1109402025", var_106_24)
						arg_103_1:RecordAudio("1109402025", var_106_24)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402025", "story_v_side_new_1109402.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402025", "story_v_side_new_1109402.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_25 = math.max(var_106_16, arg_103_1.talkMaxDuration)

			if var_106_15 <= arg_103_1.time_ and arg_103_1.time_ < var_106_15 + var_106_25 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_15) / var_106_25

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_15 + var_106_25 and arg_103_1.time_ < var_106_15 + var_106_25 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_103_1:InitPlayNodeList()
	end,
	Play1109402026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 1109402026
		arg_107_1.duration_ = 5

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play1109402027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = arg_107_1.actors_["1094ui_story"]
			local var_110_1 = 0

			if var_110_1 < arg_107_1.time_ and arg_107_1.time_ <= var_110_1 + arg_110_0 and not isNil(var_110_0) and arg_107_1.var_.characterEffect1094ui_story == nil then
				arg_107_1.var_.characterEffect1094ui_story = var_110_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_2 = 0.200000002980232

			if var_110_1 <= arg_107_1.time_ and arg_107_1.time_ < var_110_1 + var_110_2 and not isNil(var_110_0) then
				local var_110_3 = (arg_107_1.time_ - var_110_1) / var_110_2

				if arg_107_1.var_.characterEffect1094ui_story and not isNil(var_110_0) then
					local var_110_4 = Mathf.Lerp(0, 0.5, var_110_3)

					arg_107_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_107_1.var_.characterEffect1094ui_story.fillRatio = var_110_4
				end
			end

			if arg_107_1.time_ >= var_110_1 + var_110_2 and arg_107_1.time_ < var_110_1 + var_110_2 + arg_110_0 and not isNil(var_110_0) and arg_107_1.var_.characterEffect1094ui_story then
				local var_110_5 = 0.5

				arg_107_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_107_1.var_.characterEffect1094ui_story.fillRatio = var_110_5
			end

			local var_110_6 = 0
			local var_110_7 = 0.55

			if var_110_6 < arg_107_1.time_ and arg_107_1.time_ <= var_110_6 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, false)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_8 = arg_107_1:GetWordFromCfg(1109402026)
				local var_110_9 = arg_107_1:FormatText(var_110_8.content)

				arg_107_1.text_.text = var_110_9

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_10 = 22
				local var_110_11 = utf8.len(var_110_9)
				local var_110_12 = var_110_10 <= 0 and var_110_7 or var_110_7 * (var_110_11 / var_110_10)

				if var_110_12 > 0 and var_110_7 < var_110_12 then
					arg_107_1.talkMaxDuration = var_110_12

					if var_110_12 + var_110_6 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_12 + var_110_6
					end
				end

				arg_107_1.text_.text = var_110_9
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)
				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_13 = math.max(var_110_7, arg_107_1.talkMaxDuration)

			if var_110_6 <= arg_107_1.time_ and arg_107_1.time_ < var_110_6 + var_110_13 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_6) / var_110_13

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_6 + var_110_13 and arg_107_1.time_ < var_110_6 + var_110_13 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play1109402027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 1109402027
		arg_111_1.duration_ = 5

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play1109402028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = 0
			local var_114_1 = 0.85

			if var_114_0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_0 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, false)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_2 = arg_111_1:GetWordFromCfg(1109402027)
				local var_114_3 = arg_111_1:FormatText(var_114_2.content)

				arg_111_1.text_.text = var_114_3

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_4 = 34
				local var_114_5 = utf8.len(var_114_3)
				local var_114_6 = var_114_4 <= 0 and var_114_1 or var_114_1 * (var_114_5 / var_114_4)

				if var_114_6 > 0 and var_114_1 < var_114_6 then
					arg_111_1.talkMaxDuration = var_114_6

					if var_114_6 + var_114_0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_6 + var_114_0
					end
				end

				arg_111_1.text_.text = var_114_3
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)
				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_7 = math.max(var_114_1, arg_111_1.talkMaxDuration)

			if var_114_0 <= arg_111_1.time_ and arg_111_1.time_ < var_114_0 + var_114_7 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_0) / var_114_7

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_0 + var_114_7 and arg_111_1.time_ < var_114_0 + var_114_7 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play1109402028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 1109402028
		arg_115_1.duration_ = 4

		local var_115_0 = {
			ja = 4,
			ko = 3.833,
			zh = 3.833
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
				arg_115_0:Play1109402029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = arg_115_1.actors_["1094ui_story"].transform
			local var_118_1 = 0

			if var_118_1 < arg_115_1.time_ and arg_115_1.time_ <= var_118_1 + arg_118_0 then
				arg_115_1.var_.moveOldPos1094ui_story = var_118_0.localPosition
			end

			local var_118_2 = 0.001

			if var_118_1 <= arg_115_1.time_ and arg_115_1.time_ < var_118_1 + var_118_2 then
				local var_118_3 = (arg_115_1.time_ - var_118_1) / var_118_2
				local var_118_4 = Vector3.New(0, -0.84, -6.1)

				var_118_0.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos1094ui_story, var_118_4, var_118_3)

				local var_118_5 = manager.ui.mainCamera.transform.position - var_118_0.position

				var_118_0.forward = Vector3.New(var_118_5.x, var_118_5.y, var_118_5.z)

				local var_118_6 = var_118_0.localEulerAngles

				var_118_6.z = 0
				var_118_6.x = 0
				var_118_0.localEulerAngles = var_118_6
			end

			if arg_115_1.time_ >= var_118_1 + var_118_2 and arg_115_1.time_ < var_118_1 + var_118_2 + arg_118_0 then
				var_118_0.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_118_7 = manager.ui.mainCamera.transform.position - var_118_0.position

				var_118_0.forward = Vector3.New(var_118_7.x, var_118_7.y, var_118_7.z)

				local var_118_8 = var_118_0.localEulerAngles

				var_118_8.z = 0
				var_118_8.x = 0
				var_118_0.localEulerAngles = var_118_8
			end

			local var_118_9 = arg_115_1.actors_["1094ui_story"]
			local var_118_10 = 0

			if var_118_10 < arg_115_1.time_ and arg_115_1.time_ <= var_118_10 + arg_118_0 and not isNil(var_118_9) and arg_115_1.var_.characterEffect1094ui_story == nil then
				arg_115_1.var_.characterEffect1094ui_story = var_118_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_11 = 0.200000002980232

			if var_118_10 <= arg_115_1.time_ and arg_115_1.time_ < var_118_10 + var_118_11 and not isNil(var_118_9) then
				local var_118_12 = (arg_115_1.time_ - var_118_10) / var_118_11

				if arg_115_1.var_.characterEffect1094ui_story and not isNil(var_118_9) then
					arg_115_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_115_1.time_ >= var_118_10 + var_118_11 and arg_115_1.time_ < var_118_10 + var_118_11 + arg_118_0 and not isNil(var_118_9) and arg_115_1.var_.characterEffect1094ui_story then
				arg_115_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_118_13 = 0

			if var_118_13 < arg_115_1.time_ and arg_115_1.time_ <= var_118_13 + arg_118_0 then
				arg_115_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_118_14 = 0
			local var_118_15 = 0.25

			if var_118_14 < arg_115_1.time_ and arg_115_1.time_ <= var_118_14 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				local var_118_16 = arg_115_1:FormatText(StoryNameCfg[181].name)

				arg_115_1.leftNameTxt_.text = var_118_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_17 = arg_115_1:GetWordFromCfg(1109402028)
				local var_118_18 = arg_115_1:FormatText(var_118_17.content)

				arg_115_1.text_.text = var_118_18

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_19 = 10
				local var_118_20 = utf8.len(var_118_18)
				local var_118_21 = var_118_19 <= 0 and var_118_15 or var_118_15 * (var_118_20 / var_118_19)

				if var_118_21 > 0 and var_118_15 < var_118_21 then
					arg_115_1.talkMaxDuration = var_118_21

					if var_118_21 + var_118_14 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_21 + var_118_14
					end
				end

				arg_115_1.text_.text = var_118_18
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402028", "story_v_side_new_1109402.awb") ~= 0 then
					local var_118_22 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402028", "story_v_side_new_1109402.awb") / 1000

					if var_118_22 + var_118_14 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_22 + var_118_14
					end

					if var_118_17.prefab_name ~= "" and arg_115_1.actors_[var_118_17.prefab_name] ~= nil then
						local var_118_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_17.prefab_name].transform, "story_v_side_new_1109402", "1109402028", "story_v_side_new_1109402.awb")

						arg_115_1:RecordAudio("1109402028", var_118_23)
						arg_115_1:RecordAudio("1109402028", var_118_23)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402028", "story_v_side_new_1109402.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402028", "story_v_side_new_1109402.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_24 = math.max(var_118_15, arg_115_1.talkMaxDuration)

			if var_118_14 <= arg_115_1.time_ and arg_115_1.time_ < var_118_14 + var_118_24 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_14) / var_118_24

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_14 + var_118_24 and arg_115_1.time_ < var_118_14 + var_118_24 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_115_1:InitPlayNodeList()
	end,
	Play1109402029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 1109402029
		arg_119_1.duration_ = 5

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play1109402030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = arg_119_1.actors_["1094ui_story"]
			local var_122_1 = 0

			if var_122_1 < arg_119_1.time_ and arg_119_1.time_ <= var_122_1 + arg_122_0 and not isNil(var_122_0) and arg_119_1.var_.characterEffect1094ui_story == nil then
				arg_119_1.var_.characterEffect1094ui_story = var_122_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_2 = 0.200000002980232

			if var_122_1 <= arg_119_1.time_ and arg_119_1.time_ < var_122_1 + var_122_2 and not isNil(var_122_0) then
				local var_122_3 = (arg_119_1.time_ - var_122_1) / var_122_2

				if arg_119_1.var_.characterEffect1094ui_story and not isNil(var_122_0) then
					local var_122_4 = Mathf.Lerp(0, 0.5, var_122_3)

					arg_119_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_119_1.var_.characterEffect1094ui_story.fillRatio = var_122_4
				end
			end

			if arg_119_1.time_ >= var_122_1 + var_122_2 and arg_119_1.time_ < var_122_1 + var_122_2 + arg_122_0 and not isNil(var_122_0) and arg_119_1.var_.characterEffect1094ui_story then
				local var_122_5 = 0.5

				arg_119_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_119_1.var_.characterEffect1094ui_story.fillRatio = var_122_5
			end

			local var_122_6 = 0
			local var_122_7 = 0.225

			if var_122_6 < arg_119_1.time_ and arg_119_1.time_ <= var_122_6 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				local var_122_8 = arg_119_1:FormatText(StoryNameCfg[7].name)

				arg_119_1.leftNameTxt_.text = var_122_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, true)
				arg_119_1.iconController_:SetSelectedState("hero")

				arg_119_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_119_1.callingController_:SetSelectedState("normal")

				arg_119_1.keyicon_.color = Color.New(1, 1, 1)
				arg_119_1.icon_.color = Color.New(1, 1, 1)

				local var_122_9 = arg_119_1:GetWordFromCfg(1109402029)
				local var_122_10 = arg_119_1:FormatText(var_122_9.content)

				arg_119_1.text_.text = var_122_10

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_11 = 9
				local var_122_12 = utf8.len(var_122_10)
				local var_122_13 = var_122_11 <= 0 and var_122_7 or var_122_7 * (var_122_12 / var_122_11)

				if var_122_13 > 0 and var_122_7 < var_122_13 then
					arg_119_1.talkMaxDuration = var_122_13

					if var_122_13 + var_122_6 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_13 + var_122_6
					end
				end

				arg_119_1.text_.text = var_122_10
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)
				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_14 = math.max(var_122_7, arg_119_1.talkMaxDuration)

			if var_122_6 <= arg_119_1.time_ and arg_119_1.time_ < var_122_6 + var_122_14 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_6) / var_122_14

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_6 + var_122_14 and arg_119_1.time_ < var_122_6 + var_122_14 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play1109402030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 1109402030
		arg_123_1.duration_ = 3.1

		local var_123_0 = {
			ja = 3.1,
			ko = 1.999999999999,
			zh = 1.999999999999
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
				arg_123_0:Play1109402031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = arg_123_1.actors_["1094ui_story"].transform
			local var_126_1 = 0

			if var_126_1 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 then
				arg_123_1.var_.moveOldPos1094ui_story = var_126_0.localPosition
			end

			local var_126_2 = 0.001

			if var_126_1 <= arg_123_1.time_ and arg_123_1.time_ < var_126_1 + var_126_2 then
				local var_126_3 = (arg_123_1.time_ - var_126_1) / var_126_2
				local var_126_4 = Vector3.New(0, -0.84, -6.1)

				var_126_0.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos1094ui_story, var_126_4, var_126_3)

				local var_126_5 = manager.ui.mainCamera.transform.position - var_126_0.position

				var_126_0.forward = Vector3.New(var_126_5.x, var_126_5.y, var_126_5.z)

				local var_126_6 = var_126_0.localEulerAngles

				var_126_6.z = 0
				var_126_6.x = 0
				var_126_0.localEulerAngles = var_126_6
			end

			if arg_123_1.time_ >= var_126_1 + var_126_2 and arg_123_1.time_ < var_126_1 + var_126_2 + arg_126_0 then
				var_126_0.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_126_7 = manager.ui.mainCamera.transform.position - var_126_0.position

				var_126_0.forward = Vector3.New(var_126_7.x, var_126_7.y, var_126_7.z)

				local var_126_8 = var_126_0.localEulerAngles

				var_126_8.z = 0
				var_126_8.x = 0
				var_126_0.localEulerAngles = var_126_8
			end

			local var_126_9 = arg_123_1.actors_["1094ui_story"]
			local var_126_10 = 0

			if var_126_10 < arg_123_1.time_ and arg_123_1.time_ <= var_126_10 + arg_126_0 and not isNil(var_126_9) and arg_123_1.var_.characterEffect1094ui_story == nil then
				arg_123_1.var_.characterEffect1094ui_story = var_126_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_11 = 0.200000002980232

			if var_126_10 <= arg_123_1.time_ and arg_123_1.time_ < var_126_10 + var_126_11 and not isNil(var_126_9) then
				local var_126_12 = (arg_123_1.time_ - var_126_10) / var_126_11

				if arg_123_1.var_.characterEffect1094ui_story and not isNil(var_126_9) then
					arg_123_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_123_1.time_ >= var_126_10 + var_126_11 and arg_123_1.time_ < var_126_10 + var_126_11 + arg_126_0 and not isNil(var_126_9) and arg_123_1.var_.characterEffect1094ui_story then
				arg_123_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_126_13 = 0

			if var_126_13 < arg_123_1.time_ and arg_123_1.time_ <= var_126_13 + arg_126_0 then
				arg_123_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action4_1")
			end

			local var_126_14 = 0

			if var_126_14 < arg_123_1.time_ and arg_123_1.time_ <= var_126_14 + arg_126_0 then
				arg_123_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_126_15 = 0
			local var_126_16 = 0.125

			if var_126_15 < arg_123_1.time_ and arg_123_1.time_ <= var_126_15 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				local var_126_17 = arg_123_1:FormatText(StoryNameCfg[181].name)

				arg_123_1.leftNameTxt_.text = var_126_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_18 = arg_123_1:GetWordFromCfg(1109402030)
				local var_126_19 = arg_123_1:FormatText(var_126_18.content)

				arg_123_1.text_.text = var_126_19

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_20 = 5
				local var_126_21 = utf8.len(var_126_19)
				local var_126_22 = var_126_20 <= 0 and var_126_16 or var_126_16 * (var_126_21 / var_126_20)

				if var_126_22 > 0 and var_126_16 < var_126_22 then
					arg_123_1.talkMaxDuration = var_126_22

					if var_126_22 + var_126_15 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_22 + var_126_15
					end
				end

				arg_123_1.text_.text = var_126_19
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402030", "story_v_side_new_1109402.awb") ~= 0 then
					local var_126_23 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402030", "story_v_side_new_1109402.awb") / 1000

					if var_126_23 + var_126_15 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_23 + var_126_15
					end

					if var_126_18.prefab_name ~= "" and arg_123_1.actors_[var_126_18.prefab_name] ~= nil then
						local var_126_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_18.prefab_name].transform, "story_v_side_new_1109402", "1109402030", "story_v_side_new_1109402.awb")

						arg_123_1:RecordAudio("1109402030", var_126_24)
						arg_123_1:RecordAudio("1109402030", var_126_24)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402030", "story_v_side_new_1109402.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402030", "story_v_side_new_1109402.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_25 = math.max(var_126_16, arg_123_1.talkMaxDuration)

			if var_126_15 <= arg_123_1.time_ and arg_123_1.time_ < var_126_15 + var_126_25 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_15) / var_126_25

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_15 + var_126_25 and arg_123_1.time_ < var_126_15 + var_126_25 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_123_1:InitPlayNodeList()
	end,
	Play1109402031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 1109402031
		arg_127_1.duration_ = 5

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play1109402032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = arg_127_1.actors_["1094ui_story"]
			local var_130_1 = 0

			if var_130_1 < arg_127_1.time_ and arg_127_1.time_ <= var_130_1 + arg_130_0 and not isNil(var_130_0) and arg_127_1.var_.characterEffect1094ui_story == nil then
				arg_127_1.var_.characterEffect1094ui_story = var_130_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_2 = 0.200000002980232

			if var_130_1 <= arg_127_1.time_ and arg_127_1.time_ < var_130_1 + var_130_2 and not isNil(var_130_0) then
				local var_130_3 = (arg_127_1.time_ - var_130_1) / var_130_2

				if arg_127_1.var_.characterEffect1094ui_story and not isNil(var_130_0) then
					local var_130_4 = Mathf.Lerp(0, 0.5, var_130_3)

					arg_127_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_127_1.var_.characterEffect1094ui_story.fillRatio = var_130_4
				end
			end

			if arg_127_1.time_ >= var_130_1 + var_130_2 and arg_127_1.time_ < var_130_1 + var_130_2 + arg_130_0 and not isNil(var_130_0) and arg_127_1.var_.characterEffect1094ui_story then
				local var_130_5 = 0.5

				arg_127_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_127_1.var_.characterEffect1094ui_story.fillRatio = var_130_5
			end

			local var_130_6 = 0
			local var_130_7 = 0.4

			if var_130_6 < arg_127_1.time_ and arg_127_1.time_ <= var_130_6 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				local var_130_8 = arg_127_1:FormatText(StoryNameCfg[7].name)

				arg_127_1.leftNameTxt_.text = var_130_8

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

				local var_130_9 = arg_127_1:GetWordFromCfg(1109402031)
				local var_130_10 = arg_127_1:FormatText(var_130_9.content)

				arg_127_1.text_.text = var_130_10

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_11 = 16
				local var_130_12 = utf8.len(var_130_10)
				local var_130_13 = var_130_11 <= 0 and var_130_7 or var_130_7 * (var_130_12 / var_130_11)

				if var_130_13 > 0 and var_130_7 < var_130_13 then
					arg_127_1.talkMaxDuration = var_130_13

					if var_130_13 + var_130_6 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_13 + var_130_6
					end
				end

				arg_127_1.text_.text = var_130_10
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_14 = math.max(var_130_7, arg_127_1.talkMaxDuration)

			if var_130_6 <= arg_127_1.time_ and arg_127_1.time_ < var_130_6 + var_130_14 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_6) / var_130_14

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_6 + var_130_14 and arg_127_1.time_ < var_130_6 + var_130_14 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play1109402032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 1109402032
		arg_131_1.duration_ = 5

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play1109402033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = 0
			local var_134_1 = 0.4

			if var_134_0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_0 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				local var_134_2 = arg_131_1:FormatText(StoryNameCfg[7].name)

				arg_131_1.leftNameTxt_.text = var_134_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, true)
				arg_131_1.iconController_:SetSelectedState("hero")

				arg_131_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_131_1.callingController_:SetSelectedState("normal")

				arg_131_1.keyicon_.color = Color.New(1, 1, 1)
				arg_131_1.icon_.color = Color.New(1, 1, 1)

				local var_134_3 = arg_131_1:GetWordFromCfg(1109402032)
				local var_134_4 = arg_131_1:FormatText(var_134_3.content)

				arg_131_1.text_.text = var_134_4

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_5 = 16
				local var_134_6 = utf8.len(var_134_4)
				local var_134_7 = var_134_5 <= 0 and var_134_1 or var_134_1 * (var_134_6 / var_134_5)

				if var_134_7 > 0 and var_134_1 < var_134_7 then
					arg_131_1.talkMaxDuration = var_134_7

					if var_134_7 + var_134_0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_7 + var_134_0
					end
				end

				arg_131_1.text_.text = var_134_4
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)
				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_8 = math.max(var_134_1, arg_131_1.talkMaxDuration)

			if var_134_0 <= arg_131_1.time_ and arg_131_1.time_ < var_134_0 + var_134_8 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_0) / var_134_8

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_0 + var_134_8 and arg_131_1.time_ < var_134_0 + var_134_8 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play1109402033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 1109402033
		arg_135_1.duration_ = 5

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play1109402034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = arg_135_1.actors_["1094ui_story"].transform
			local var_138_1 = 0

			if var_138_1 < arg_135_1.time_ and arg_135_1.time_ <= var_138_1 + arg_138_0 then
				arg_135_1.var_.moveOldPos1094ui_story = var_138_0.localPosition
			end

			local var_138_2 = 0.001

			if var_138_1 <= arg_135_1.time_ and arg_135_1.time_ < var_138_1 + var_138_2 then
				local var_138_3 = (arg_135_1.time_ - var_138_1) / var_138_2
				local var_138_4 = Vector3.New(0, 100, 0)

				var_138_0.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos1094ui_story, var_138_4, var_138_3)

				local var_138_5 = manager.ui.mainCamera.transform.position - var_138_0.position

				var_138_0.forward = Vector3.New(var_138_5.x, var_138_5.y, var_138_5.z)

				local var_138_6 = var_138_0.localEulerAngles

				var_138_6.z = 0
				var_138_6.x = 0
				var_138_0.localEulerAngles = var_138_6
			end

			if arg_135_1.time_ >= var_138_1 + var_138_2 and arg_135_1.time_ < var_138_1 + var_138_2 + arg_138_0 then
				var_138_0.localPosition = Vector3.New(0, 100, 0)

				local var_138_7 = manager.ui.mainCamera.transform.position - var_138_0.position

				var_138_0.forward = Vector3.New(var_138_7.x, var_138_7.y, var_138_7.z)

				local var_138_8 = var_138_0.localEulerAngles

				var_138_8.z = 0
				var_138_8.x = 0
				var_138_0.localEulerAngles = var_138_8
			end

			local var_138_9 = 0
			local var_138_10 = 0.625

			if var_138_9 < arg_135_1.time_ and arg_135_1.time_ <= var_138_9 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, false)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_11 = arg_135_1:GetWordFromCfg(1109402033)
				local var_138_12 = arg_135_1:FormatText(var_138_11.content)

				arg_135_1.text_.text = var_138_12

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_13 = 25
				local var_138_14 = utf8.len(var_138_12)
				local var_138_15 = var_138_13 <= 0 and var_138_10 or var_138_10 * (var_138_14 / var_138_13)

				if var_138_15 > 0 and var_138_10 < var_138_15 then
					arg_135_1.talkMaxDuration = var_138_15

					if var_138_15 + var_138_9 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_15 + var_138_9
					end
				end

				arg_135_1.text_.text = var_138_12
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)
				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_16 = math.max(var_138_10, arg_135_1.talkMaxDuration)

			if var_138_9 <= arg_135_1.time_ and arg_135_1.time_ < var_138_9 + var_138_16 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_9) / var_138_16

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_9 + var_138_16 and arg_135_1.time_ < var_138_9 + var_138_16 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_135_1:InitPlayNodeList()
	end,
	Play1109402034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 1109402034
		arg_139_1.duration_ = 5

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play1109402035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = 0
			local var_142_1 = 0.175

			if var_142_0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_0 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				local var_142_2 = arg_139_1:FormatText(StoryNameCfg[7].name)

				arg_139_1.leftNameTxt_.text = var_142_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, true)
				arg_139_1.iconController_:SetSelectedState("hero")

				arg_139_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_139_1.callingController_:SetSelectedState("normal")

				arg_139_1.keyicon_.color = Color.New(1, 1, 1)
				arg_139_1.icon_.color = Color.New(1, 1, 1)

				local var_142_3 = arg_139_1:GetWordFromCfg(1109402034)
				local var_142_4 = arg_139_1:FormatText(var_142_3.content)

				arg_139_1.text_.text = var_142_4

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_5 = 7
				local var_142_6 = utf8.len(var_142_4)
				local var_142_7 = var_142_5 <= 0 and var_142_1 or var_142_1 * (var_142_6 / var_142_5)

				if var_142_7 > 0 and var_142_1 < var_142_7 then
					arg_139_1.talkMaxDuration = var_142_7

					if var_142_7 + var_142_0 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_7 + var_142_0
					end
				end

				arg_139_1.text_.text = var_142_4
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)
				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_8 = math.max(var_142_1, arg_139_1.talkMaxDuration)

			if var_142_0 <= arg_139_1.time_ and arg_139_1.time_ < var_142_0 + var_142_8 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_0) / var_142_8

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_0 + var_142_8 and arg_139_1.time_ < var_142_0 + var_142_8 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play1109402035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 1109402035
		arg_143_1.duration_ = 5

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play1109402036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = 0
			local var_146_1 = 0.6

			if var_146_0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_0 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, false)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_2 = arg_143_1:GetWordFromCfg(1109402035)
				local var_146_3 = arg_143_1:FormatText(var_146_2.content)

				arg_143_1.text_.text = var_146_3

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_4 = 24
				local var_146_5 = utf8.len(var_146_3)
				local var_146_6 = var_146_4 <= 0 and var_146_1 or var_146_1 * (var_146_5 / var_146_4)

				if var_146_6 > 0 and var_146_1 < var_146_6 then
					arg_143_1.talkMaxDuration = var_146_6

					if var_146_6 + var_146_0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_6 + var_146_0
					end
				end

				arg_143_1.text_.text = var_146_3
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)
				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_7 = math.max(var_146_1, arg_143_1.talkMaxDuration)

			if var_146_0 <= arg_143_1.time_ and arg_143_1.time_ < var_146_0 + var_146_7 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_0) / var_146_7

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_0 + var_146_7 and arg_143_1.time_ < var_146_0 + var_146_7 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play1109402036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 1109402036
		arg_147_1.duration_ = 5

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play1109402037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = 0
			local var_150_1 = 0.55

			if var_150_0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_0 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				local var_150_2 = arg_147_1:FormatText(StoryNameCfg[7].name)

				arg_147_1.leftNameTxt_.text = var_150_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, true)
				arg_147_1.iconController_:SetSelectedState("hero")

				arg_147_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_147_1.callingController_:SetSelectedState("normal")

				arg_147_1.keyicon_.color = Color.New(1, 1, 1)
				arg_147_1.icon_.color = Color.New(1, 1, 1)

				local var_150_3 = arg_147_1:GetWordFromCfg(1109402036)
				local var_150_4 = arg_147_1:FormatText(var_150_3.content)

				arg_147_1.text_.text = var_150_4

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_5 = 22
				local var_150_6 = utf8.len(var_150_4)
				local var_150_7 = var_150_5 <= 0 and var_150_1 or var_150_1 * (var_150_6 / var_150_5)

				if var_150_7 > 0 and var_150_1 < var_150_7 then
					arg_147_1.talkMaxDuration = var_150_7

					if var_150_7 + var_150_0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_7 + var_150_0
					end
				end

				arg_147_1.text_.text = var_150_4
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)
				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_8 = math.max(var_150_1, arg_147_1.talkMaxDuration)

			if var_150_0 <= arg_147_1.time_ and arg_147_1.time_ < var_150_0 + var_150_8 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_0) / var_150_8

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_0 + var_150_8 and arg_147_1.time_ < var_150_0 + var_150_8 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play1109402037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 1109402037
		arg_151_1.duration_ = 2

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play1109402038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = arg_151_1.actors_["1094ui_story"].transform
			local var_154_1 = 0

			if var_154_1 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 then
				arg_151_1.var_.moveOldPos1094ui_story = var_154_0.localPosition
			end

			local var_154_2 = 0.001

			if var_154_1 <= arg_151_1.time_ and arg_151_1.time_ < var_154_1 + var_154_2 then
				local var_154_3 = (arg_151_1.time_ - var_154_1) / var_154_2
				local var_154_4 = Vector3.New(0, -0.84, -6.1)

				var_154_0.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos1094ui_story, var_154_4, var_154_3)

				local var_154_5 = manager.ui.mainCamera.transform.position - var_154_0.position

				var_154_0.forward = Vector3.New(var_154_5.x, var_154_5.y, var_154_5.z)

				local var_154_6 = var_154_0.localEulerAngles

				var_154_6.z = 0
				var_154_6.x = 0
				var_154_0.localEulerAngles = var_154_6
			end

			if arg_151_1.time_ >= var_154_1 + var_154_2 and arg_151_1.time_ < var_154_1 + var_154_2 + arg_154_0 then
				var_154_0.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_154_7 = manager.ui.mainCamera.transform.position - var_154_0.position

				var_154_0.forward = Vector3.New(var_154_7.x, var_154_7.y, var_154_7.z)

				local var_154_8 = var_154_0.localEulerAngles

				var_154_8.z = 0
				var_154_8.x = 0
				var_154_0.localEulerAngles = var_154_8
			end

			local var_154_9 = arg_151_1.actors_["1094ui_story"]
			local var_154_10 = 0

			if var_154_10 < arg_151_1.time_ and arg_151_1.time_ <= var_154_10 + arg_154_0 and not isNil(var_154_9) and arg_151_1.var_.characterEffect1094ui_story == nil then
				arg_151_1.var_.characterEffect1094ui_story = var_154_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_11 = 0.200000002980232

			if var_154_10 <= arg_151_1.time_ and arg_151_1.time_ < var_154_10 + var_154_11 and not isNil(var_154_9) then
				local var_154_12 = (arg_151_1.time_ - var_154_10) / var_154_11

				if arg_151_1.var_.characterEffect1094ui_story and not isNil(var_154_9) then
					arg_151_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_151_1.time_ >= var_154_10 + var_154_11 and arg_151_1.time_ < var_154_10 + var_154_11 + arg_154_0 and not isNil(var_154_9) and arg_151_1.var_.characterEffect1094ui_story then
				arg_151_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_154_13 = 0

			if var_154_13 < arg_151_1.time_ and arg_151_1.time_ <= var_154_13 + arg_154_0 then
				arg_151_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action4_2")
			end

			local var_154_14 = 0

			if var_154_14 < arg_151_1.time_ and arg_151_1.time_ <= var_154_14 + arg_154_0 then
				arg_151_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_154_15 = 0
			local var_154_16 = 0.125

			if var_154_15 < arg_151_1.time_ and arg_151_1.time_ <= var_154_15 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				local var_154_17 = arg_151_1:FormatText(StoryNameCfg[181].name)

				arg_151_1.leftNameTxt_.text = var_154_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_18 = arg_151_1:GetWordFromCfg(1109402037)
				local var_154_19 = arg_151_1:FormatText(var_154_18.content)

				arg_151_1.text_.text = var_154_19

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_20 = 5
				local var_154_21 = utf8.len(var_154_19)
				local var_154_22 = var_154_20 <= 0 and var_154_16 or var_154_16 * (var_154_21 / var_154_20)

				if var_154_22 > 0 and var_154_16 < var_154_22 then
					arg_151_1.talkMaxDuration = var_154_22

					if var_154_22 + var_154_15 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_22 + var_154_15
					end
				end

				arg_151_1.text_.text = var_154_19
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402037", "story_v_side_new_1109402.awb") ~= 0 then
					local var_154_23 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402037", "story_v_side_new_1109402.awb") / 1000

					if var_154_23 + var_154_15 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_23 + var_154_15
					end

					if var_154_18.prefab_name ~= "" and arg_151_1.actors_[var_154_18.prefab_name] ~= nil then
						local var_154_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_18.prefab_name].transform, "story_v_side_new_1109402", "1109402037", "story_v_side_new_1109402.awb")

						arg_151_1:RecordAudio("1109402037", var_154_24)
						arg_151_1:RecordAudio("1109402037", var_154_24)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402037", "story_v_side_new_1109402.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402037", "story_v_side_new_1109402.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_25 = math.max(var_154_16, arg_151_1.talkMaxDuration)

			if var_154_15 <= arg_151_1.time_ and arg_151_1.time_ < var_154_15 + var_154_25 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_15) / var_154_25

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_15 + var_154_25 and arg_151_1.time_ < var_154_15 + var_154_25 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_151_1:InitPlayNodeList()
	end,
	Play1109402038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 1109402038
		arg_155_1.duration_ = 5

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play1109402039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = arg_155_1.actors_["1094ui_story"]
			local var_158_1 = 0

			if var_158_1 < arg_155_1.time_ and arg_155_1.time_ <= var_158_1 + arg_158_0 and not isNil(var_158_0) and arg_155_1.var_.characterEffect1094ui_story == nil then
				arg_155_1.var_.characterEffect1094ui_story = var_158_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_2 = 0.200000002980232

			if var_158_1 <= arg_155_1.time_ and arg_155_1.time_ < var_158_1 + var_158_2 and not isNil(var_158_0) then
				local var_158_3 = (arg_155_1.time_ - var_158_1) / var_158_2

				if arg_155_1.var_.characterEffect1094ui_story and not isNil(var_158_0) then
					local var_158_4 = Mathf.Lerp(0, 0.5, var_158_3)

					arg_155_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_155_1.var_.characterEffect1094ui_story.fillRatio = var_158_4
				end
			end

			if arg_155_1.time_ >= var_158_1 + var_158_2 and arg_155_1.time_ < var_158_1 + var_158_2 + arg_158_0 and not isNil(var_158_0) and arg_155_1.var_.characterEffect1094ui_story then
				local var_158_5 = 0.5

				arg_155_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_155_1.var_.characterEffect1094ui_story.fillRatio = var_158_5
			end

			local var_158_6 = 0
			local var_158_7 = 0.55

			if var_158_6 < arg_155_1.time_ and arg_155_1.time_ <= var_158_6 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				local var_158_8 = arg_155_1:FormatText(StoryNameCfg[7].name)

				arg_155_1.leftNameTxt_.text = var_158_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, true)
				arg_155_1.iconController_:SetSelectedState("hero")

				arg_155_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_155_1.callingController_:SetSelectedState("normal")

				arg_155_1.keyicon_.color = Color.New(1, 1, 1)
				arg_155_1.icon_.color = Color.New(1, 1, 1)

				local var_158_9 = arg_155_1:GetWordFromCfg(1109402038)
				local var_158_10 = arg_155_1:FormatText(var_158_9.content)

				arg_155_1.text_.text = var_158_10

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_11 = 22
				local var_158_12 = utf8.len(var_158_10)
				local var_158_13 = var_158_11 <= 0 and var_158_7 or var_158_7 * (var_158_12 / var_158_11)

				if var_158_13 > 0 and var_158_7 < var_158_13 then
					arg_155_1.talkMaxDuration = var_158_13

					if var_158_13 + var_158_6 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_13 + var_158_6
					end
				end

				arg_155_1.text_.text = var_158_10
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)
				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_14 = math.max(var_158_7, arg_155_1.talkMaxDuration)

			if var_158_6 <= arg_155_1.time_ and arg_155_1.time_ < var_158_6 + var_158_14 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_6) / var_158_14

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_6 + var_158_14 and arg_155_1.time_ < var_158_6 + var_158_14 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play1109402039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 1109402039
		arg_159_1.duration_ = 11

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play1109402040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = 3

			if var_162_0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_0 + arg_162_0 then
				local var_162_1 = manager.ui.mainCamera.transform.localPosition
				local var_162_2 = Vector3.New(0, 0, 10) + Vector3.New(var_162_1.x, var_162_1.y, 0)
				local var_162_3 = arg_159_1.bgs_.ST03

				var_162_3.transform.localPosition = var_162_2
				var_162_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_162_4 = var_162_3:GetComponent("SpriteRenderer")

				if var_162_4 and var_162_4.sprite then
					local var_162_5 = (var_162_3.transform.localPosition - var_162_1).z
					local var_162_6 = manager.ui.mainCameraCom_
					local var_162_7 = 2 * var_162_5 * Mathf.Tan(var_162_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_162_8 = var_162_7 * var_162_6.aspect
					local var_162_9 = var_162_4.sprite.bounds.size.x
					local var_162_10 = var_162_4.sprite.bounds.size.y
					local var_162_11 = var_162_8 / var_162_9
					local var_162_12 = var_162_7 / var_162_10
					local var_162_13 = var_162_12 < var_162_11 and var_162_11 or var_162_12

					var_162_3.transform.localScale = Vector3.New(var_162_13, var_162_13, 0)
				end

				for iter_162_0, iter_162_1 in pairs(arg_159_1.bgs_) do
					if iter_162_0 ~= "ST03" then
						iter_162_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_162_14 = 0

			if var_162_14 < arg_159_1.time_ and arg_159_1.time_ <= var_162_14 + arg_162_0 then
				arg_159_1.mask_.enabled = true
				arg_159_1.mask_.raycastTarget = true

				arg_159_1:SetGaussion(false)
			end

			local var_162_15 = 3

			if var_162_14 <= arg_159_1.time_ and arg_159_1.time_ < var_162_14 + var_162_15 then
				local var_162_16 = (arg_159_1.time_ - var_162_14) / var_162_15
				local var_162_17 = Color.New(0, 0, 0)

				var_162_17.a = Mathf.Lerp(0, 1, var_162_16)
				arg_159_1.mask_.color = var_162_17
			end

			if arg_159_1.time_ >= var_162_14 + var_162_15 and arg_159_1.time_ < var_162_14 + var_162_15 + arg_162_0 then
				local var_162_18 = Color.New(0, 0, 0)

				var_162_18.a = 1
				arg_159_1.mask_.color = var_162_18
			end

			local var_162_19 = 3

			if var_162_19 < arg_159_1.time_ and arg_159_1.time_ <= var_162_19 + arg_162_0 then
				arg_159_1.mask_.enabled = true
				arg_159_1.mask_.raycastTarget = true

				arg_159_1:SetGaussion(false)
			end

			local var_162_20 = 3

			if var_162_19 <= arg_159_1.time_ and arg_159_1.time_ < var_162_19 + var_162_20 then
				local var_162_21 = (arg_159_1.time_ - var_162_19) / var_162_20
				local var_162_22 = Color.New(0, 0, 0)

				var_162_22.a = Mathf.Lerp(1, 0, var_162_21)
				arg_159_1.mask_.color = var_162_22
			end

			if arg_159_1.time_ >= var_162_19 + var_162_20 and arg_159_1.time_ < var_162_19 + var_162_20 + arg_162_0 then
				local var_162_23 = Color.New(0, 0, 0)
				local var_162_24 = 0

				arg_159_1.mask_.enabled = false
				var_162_23.a = var_162_24
				arg_159_1.mask_.color = var_162_23
			end

			local var_162_25 = arg_159_1.actors_["1094ui_story"].transform
			local var_162_26 = 0

			if var_162_26 < arg_159_1.time_ and arg_159_1.time_ <= var_162_26 + arg_162_0 then
				arg_159_1.var_.moveOldPos1094ui_story = var_162_25.localPosition
			end

			local var_162_27 = 0.001

			if var_162_26 <= arg_159_1.time_ and arg_159_1.time_ < var_162_26 + var_162_27 then
				local var_162_28 = (arg_159_1.time_ - var_162_26) / var_162_27
				local var_162_29 = Vector3.New(0, 100, 0)

				var_162_25.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos1094ui_story, var_162_29, var_162_28)

				local var_162_30 = manager.ui.mainCamera.transform.position - var_162_25.position

				var_162_25.forward = Vector3.New(var_162_30.x, var_162_30.y, var_162_30.z)

				local var_162_31 = var_162_25.localEulerAngles

				var_162_31.z = 0
				var_162_31.x = 0
				var_162_25.localEulerAngles = var_162_31
			end

			if arg_159_1.time_ >= var_162_26 + var_162_27 and arg_159_1.time_ < var_162_26 + var_162_27 + arg_162_0 then
				var_162_25.localPosition = Vector3.New(0, 100, 0)

				local var_162_32 = manager.ui.mainCamera.transform.position - var_162_25.position

				var_162_25.forward = Vector3.New(var_162_32.x, var_162_32.y, var_162_32.z)

				local var_162_33 = var_162_25.localEulerAngles

				var_162_33.z = 0
				var_162_33.x = 0
				var_162_25.localEulerAngles = var_162_33
			end

			if arg_159_1.frameCnt_ <= 1 then
				arg_159_1.dialog_:SetActive(false)
			end

			local var_162_34 = 6
			local var_162_35 = 0.8

			if var_162_34 < arg_159_1.time_ and arg_159_1.time_ <= var_162_34 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0

				arg_159_1.dialog_:SetActive(true)

				arg_159_1.dialogCg_.alpha = 0

				local var_162_36 = LeanTween.value(arg_159_1.dialog_, 0, 1, 0.3)

				var_162_36:setOnUpdate(LuaHelper.FloatAction(function(arg_163_0)
					arg_159_1.dialogCg_.alpha = arg_163_0
				end))
				var_162_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_159_1.dialog_)
					var_162_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_159_1.duration_ = arg_159_1.duration_ + 0.3

				SetActive(arg_159_1.leftNameGo_, false)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_37 = arg_159_1:GetWordFromCfg(1109402039)
				local var_162_38 = arg_159_1:FormatText(var_162_37.content)

				arg_159_1.text_.text = var_162_38

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_39 = 25
				local var_162_40 = utf8.len(var_162_38)
				local var_162_41 = var_162_39 <= 0 and var_162_35 or var_162_35 * (var_162_40 / var_162_39)

				if var_162_41 > 0 and var_162_35 < var_162_41 then
					arg_159_1.talkMaxDuration = var_162_41
					var_162_34 = var_162_34 + 0.3

					if var_162_41 + var_162_34 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_41 + var_162_34
					end
				end

				arg_159_1.text_.text = var_162_38
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)
				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_42 = var_162_34 + 0.3
			local var_162_43 = math.max(var_162_35, arg_159_1.talkMaxDuration)

			if var_162_42 <= arg_159_1.time_ and arg_159_1.time_ < var_162_42 + var_162_43 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_42) / var_162_43

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_42 + var_162_43 and arg_159_1.time_ < var_162_42 + var_162_43 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_159_1:InitPlayNodeList()
	end,
	Play1109402040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 1109402040
		arg_165_1.duration_ = 3.43

		local var_165_0 = {
			ja = 2.733,
			ko = 3.433,
			zh = 3.433
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
				arg_165_0:Play1109402041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = arg_165_1.actors_["1094ui_story"].transform
			local var_168_1 = 0

			if var_168_1 < arg_165_1.time_ and arg_165_1.time_ <= var_168_1 + arg_168_0 then
				arg_165_1.var_.moveOldPos1094ui_story = var_168_0.localPosition
			end

			local var_168_2 = 0.001

			if var_168_1 <= arg_165_1.time_ and arg_165_1.time_ < var_168_1 + var_168_2 then
				local var_168_3 = (arg_165_1.time_ - var_168_1) / var_168_2
				local var_168_4 = Vector3.New(0, -0.84, -6.1)

				var_168_0.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos1094ui_story, var_168_4, var_168_3)

				local var_168_5 = manager.ui.mainCamera.transform.position - var_168_0.position

				var_168_0.forward = Vector3.New(var_168_5.x, var_168_5.y, var_168_5.z)

				local var_168_6 = var_168_0.localEulerAngles

				var_168_6.z = 0
				var_168_6.x = 0
				var_168_0.localEulerAngles = var_168_6
			end

			if arg_165_1.time_ >= var_168_1 + var_168_2 and arg_165_1.time_ < var_168_1 + var_168_2 + arg_168_0 then
				var_168_0.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_168_7 = manager.ui.mainCamera.transform.position - var_168_0.position

				var_168_0.forward = Vector3.New(var_168_7.x, var_168_7.y, var_168_7.z)

				local var_168_8 = var_168_0.localEulerAngles

				var_168_8.z = 0
				var_168_8.x = 0
				var_168_0.localEulerAngles = var_168_8
			end

			local var_168_9 = arg_165_1.actors_["1094ui_story"]
			local var_168_10 = 0

			if var_168_10 < arg_165_1.time_ and arg_165_1.time_ <= var_168_10 + arg_168_0 and not isNil(var_168_9) and arg_165_1.var_.characterEffect1094ui_story == nil then
				arg_165_1.var_.characterEffect1094ui_story = var_168_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_11 = 0.200000002980232

			if var_168_10 <= arg_165_1.time_ and arg_165_1.time_ < var_168_10 + var_168_11 and not isNil(var_168_9) then
				local var_168_12 = (arg_165_1.time_ - var_168_10) / var_168_11

				if arg_165_1.var_.characterEffect1094ui_story and not isNil(var_168_9) then
					arg_165_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_165_1.time_ >= var_168_10 + var_168_11 and arg_165_1.time_ < var_168_10 + var_168_11 + arg_168_0 and not isNil(var_168_9) and arg_165_1.var_.characterEffect1094ui_story then
				arg_165_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_168_13 = 0

			if var_168_13 < arg_165_1.time_ and arg_165_1.time_ <= var_168_13 + arg_168_0 then
				arg_165_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action1_1")
			end

			local var_168_14 = 0

			if var_168_14 < arg_165_1.time_ and arg_165_1.time_ <= var_168_14 + arg_168_0 then
				arg_165_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_168_15 = 0
			local var_168_16 = 0.25

			if var_168_15 < arg_165_1.time_ and arg_165_1.time_ <= var_168_15 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				local var_168_17 = arg_165_1:FormatText(StoryNameCfg[181].name)

				arg_165_1.leftNameTxt_.text = var_168_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_18 = arg_165_1:GetWordFromCfg(1109402040)
				local var_168_19 = arg_165_1:FormatText(var_168_18.content)

				arg_165_1.text_.text = var_168_19

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_20 = 10
				local var_168_21 = utf8.len(var_168_19)
				local var_168_22 = var_168_20 <= 0 and var_168_16 or var_168_16 * (var_168_21 / var_168_20)

				if var_168_22 > 0 and var_168_16 < var_168_22 then
					arg_165_1.talkMaxDuration = var_168_22

					if var_168_22 + var_168_15 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_22 + var_168_15
					end
				end

				arg_165_1.text_.text = var_168_19
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402040", "story_v_side_new_1109402.awb") ~= 0 then
					local var_168_23 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402040", "story_v_side_new_1109402.awb") / 1000

					if var_168_23 + var_168_15 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_23 + var_168_15
					end

					if var_168_18.prefab_name ~= "" and arg_165_1.actors_[var_168_18.prefab_name] ~= nil then
						local var_168_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_18.prefab_name].transform, "story_v_side_new_1109402", "1109402040", "story_v_side_new_1109402.awb")

						arg_165_1:RecordAudio("1109402040", var_168_24)
						arg_165_1:RecordAudio("1109402040", var_168_24)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402040", "story_v_side_new_1109402.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402040", "story_v_side_new_1109402.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_25 = math.max(var_168_16, arg_165_1.talkMaxDuration)

			if var_168_15 <= arg_165_1.time_ and arg_165_1.time_ < var_168_15 + var_168_25 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_15) / var_168_25

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_15 + var_168_25 and arg_165_1.time_ < var_168_15 + var_168_25 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
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
	Play1109402041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 1109402041
		arg_169_1.duration_ = 5

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play1109402042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = arg_169_1.actors_["1094ui_story"]
			local var_172_1 = 0

			if var_172_1 < arg_169_1.time_ and arg_169_1.time_ <= var_172_1 + arg_172_0 and not isNil(var_172_0) and arg_169_1.var_.characterEffect1094ui_story == nil then
				arg_169_1.var_.characterEffect1094ui_story = var_172_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_2 = 0.200000002980232

			if var_172_1 <= arg_169_1.time_ and arg_169_1.time_ < var_172_1 + var_172_2 and not isNil(var_172_0) then
				local var_172_3 = (arg_169_1.time_ - var_172_1) / var_172_2

				if arg_169_1.var_.characterEffect1094ui_story and not isNil(var_172_0) then
					local var_172_4 = Mathf.Lerp(0, 0.5, var_172_3)

					arg_169_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_169_1.var_.characterEffect1094ui_story.fillRatio = var_172_4
				end
			end

			if arg_169_1.time_ >= var_172_1 + var_172_2 and arg_169_1.time_ < var_172_1 + var_172_2 + arg_172_0 and not isNil(var_172_0) and arg_169_1.var_.characterEffect1094ui_story then
				local var_172_5 = 0.5

				arg_169_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_169_1.var_.characterEffect1094ui_story.fillRatio = var_172_5
			end

			local var_172_6 = 0
			local var_172_7 = 0.725

			if var_172_6 < arg_169_1.time_ and arg_169_1.time_ <= var_172_6 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, false)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_8 = arg_169_1:GetWordFromCfg(1109402041)
				local var_172_9 = arg_169_1:FormatText(var_172_8.content)

				arg_169_1.text_.text = var_172_9

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_10 = 32
				local var_172_11 = utf8.len(var_172_9)
				local var_172_12 = var_172_10 <= 0 and var_172_7 or var_172_7 * (var_172_11 / var_172_10)

				if var_172_12 > 0 and var_172_7 < var_172_12 then
					arg_169_1.talkMaxDuration = var_172_12

					if var_172_12 + var_172_6 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_12 + var_172_6
					end
				end

				arg_169_1.text_.text = var_172_9
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)
				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_13 = math.max(var_172_7, arg_169_1.talkMaxDuration)

			if var_172_6 <= arg_169_1.time_ and arg_169_1.time_ < var_172_6 + var_172_13 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_6) / var_172_13

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_6 + var_172_13 and arg_169_1.time_ < var_172_6 + var_172_13 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play1109402042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 1109402042
		arg_173_1.duration_ = 2.87

		local var_173_0 = {
			ja = 2.866,
			ko = 2.233,
			zh = 2.233
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
				arg_173_0:Play1109402043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = 0
			local var_176_1 = 0.225

			if var_176_0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_0 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				local var_176_2 = arg_173_1:FormatText(StoryNameCfg[36].name)

				arg_173_1.leftNameTxt_.text = var_176_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_3 = arg_173_1:GetWordFromCfg(1109402042)
				local var_176_4 = arg_173_1:FormatText(var_176_3.content)

				arg_173_1.text_.text = var_176_4

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_5 = 9
				local var_176_6 = utf8.len(var_176_4)
				local var_176_7 = var_176_5 <= 0 and var_176_1 or var_176_1 * (var_176_6 / var_176_5)

				if var_176_7 > 0 and var_176_1 < var_176_7 then
					arg_173_1.talkMaxDuration = var_176_7

					if var_176_7 + var_176_0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_7 + var_176_0
					end
				end

				arg_173_1.text_.text = var_176_4
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402042", "story_v_side_new_1109402.awb") ~= 0 then
					local var_176_8 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402042", "story_v_side_new_1109402.awb") / 1000

					if var_176_8 + var_176_0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_8 + var_176_0
					end

					if var_176_3.prefab_name ~= "" and arg_173_1.actors_[var_176_3.prefab_name] ~= nil then
						local var_176_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_3.prefab_name].transform, "story_v_side_new_1109402", "1109402042", "story_v_side_new_1109402.awb")

						arg_173_1:RecordAudio("1109402042", var_176_9)
						arg_173_1:RecordAudio("1109402042", var_176_9)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402042", "story_v_side_new_1109402.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402042", "story_v_side_new_1109402.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_10 = math.max(var_176_1, arg_173_1.talkMaxDuration)

			if var_176_0 <= arg_173_1.time_ and arg_173_1.time_ < var_176_0 + var_176_10 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_0) / var_176_10

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_0 + var_176_10 and arg_173_1.time_ < var_176_0 + var_176_10 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play1109402043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 1109402043
		arg_177_1.duration_ = 2

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play1109402044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = arg_177_1.actors_["1094ui_story"].transform
			local var_180_1 = 0

			if var_180_1 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 then
				arg_177_1.var_.moveOldPos1094ui_story = var_180_0.localPosition
			end

			local var_180_2 = 0.001

			if var_180_1 <= arg_177_1.time_ and arg_177_1.time_ < var_180_1 + var_180_2 then
				local var_180_3 = (arg_177_1.time_ - var_180_1) / var_180_2
				local var_180_4 = Vector3.New(0, -0.84, -6.1)

				var_180_0.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos1094ui_story, var_180_4, var_180_3)

				local var_180_5 = manager.ui.mainCamera.transform.position - var_180_0.position

				var_180_0.forward = Vector3.New(var_180_5.x, var_180_5.y, var_180_5.z)

				local var_180_6 = var_180_0.localEulerAngles

				var_180_6.z = 0
				var_180_6.x = 0
				var_180_0.localEulerAngles = var_180_6
			end

			if arg_177_1.time_ >= var_180_1 + var_180_2 and arg_177_1.time_ < var_180_1 + var_180_2 + arg_180_0 then
				var_180_0.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_180_7 = manager.ui.mainCamera.transform.position - var_180_0.position

				var_180_0.forward = Vector3.New(var_180_7.x, var_180_7.y, var_180_7.z)

				local var_180_8 = var_180_0.localEulerAngles

				var_180_8.z = 0
				var_180_8.x = 0
				var_180_0.localEulerAngles = var_180_8
			end

			local var_180_9 = arg_177_1.actors_["1094ui_story"]
			local var_180_10 = 0

			if var_180_10 < arg_177_1.time_ and arg_177_1.time_ <= var_180_10 + arg_180_0 and not isNil(var_180_9) and arg_177_1.var_.characterEffect1094ui_story == nil then
				arg_177_1.var_.characterEffect1094ui_story = var_180_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_11 = 0.200000002980232

			if var_180_10 <= arg_177_1.time_ and arg_177_1.time_ < var_180_10 + var_180_11 and not isNil(var_180_9) then
				local var_180_12 = (arg_177_1.time_ - var_180_10) / var_180_11

				if arg_177_1.var_.characterEffect1094ui_story and not isNil(var_180_9) then
					arg_177_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_177_1.time_ >= var_180_10 + var_180_11 and arg_177_1.time_ < var_180_10 + var_180_11 + arg_180_0 and not isNil(var_180_9) and arg_177_1.var_.characterEffect1094ui_story then
				arg_177_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_180_13 = 0

			if var_180_13 < arg_177_1.time_ and arg_177_1.time_ <= var_180_13 + arg_180_0 then
				arg_177_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action2_1")
			end

			local var_180_14 = 0

			if var_180_14 < arg_177_1.time_ and arg_177_1.time_ <= var_180_14 + arg_180_0 then
				arg_177_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_180_15 = 0
			local var_180_16 = 0.15

			if var_180_15 < arg_177_1.time_ and arg_177_1.time_ <= var_180_15 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				local var_180_17 = arg_177_1:FormatText(StoryNameCfg[181].name)

				arg_177_1.leftNameTxt_.text = var_180_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_18 = arg_177_1:GetWordFromCfg(1109402043)
				local var_180_19 = arg_177_1:FormatText(var_180_18.content)

				arg_177_1.text_.text = var_180_19

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_20 = 6
				local var_180_21 = utf8.len(var_180_19)
				local var_180_22 = var_180_20 <= 0 and var_180_16 or var_180_16 * (var_180_21 / var_180_20)

				if var_180_22 > 0 and var_180_16 < var_180_22 then
					arg_177_1.talkMaxDuration = var_180_22

					if var_180_22 + var_180_15 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_22 + var_180_15
					end
				end

				arg_177_1.text_.text = var_180_19
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402043", "story_v_side_new_1109402.awb") ~= 0 then
					local var_180_23 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402043", "story_v_side_new_1109402.awb") / 1000

					if var_180_23 + var_180_15 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_23 + var_180_15
					end

					if var_180_18.prefab_name ~= "" and arg_177_1.actors_[var_180_18.prefab_name] ~= nil then
						local var_180_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_18.prefab_name].transform, "story_v_side_new_1109402", "1109402043", "story_v_side_new_1109402.awb")

						arg_177_1:RecordAudio("1109402043", var_180_24)
						arg_177_1:RecordAudio("1109402043", var_180_24)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402043", "story_v_side_new_1109402.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402043", "story_v_side_new_1109402.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_25 = math.max(var_180_16, arg_177_1.talkMaxDuration)

			if var_180_15 <= arg_177_1.time_ and arg_177_1.time_ < var_180_15 + var_180_25 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_15) / var_180_25

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_15 + var_180_25 and arg_177_1.time_ < var_180_15 + var_180_25 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_177_1:InitPlayNodeList()
	end,
	Play1109402044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 1109402044
		arg_181_1.duration_ = 13

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play1109402045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = "I05d"

			if arg_181_1.bgs_[var_184_0] == nil then
				local var_184_1 = Object.Instantiate(arg_181_1.paintGo_)

				var_184_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_184_0)
				var_184_1.name = var_184_0
				var_184_1.transform.parent = arg_181_1.stage_.transform
				var_184_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_181_1.bgs_[var_184_0] = var_184_1
			end

			local var_184_2 = 4

			if var_184_2 < arg_181_1.time_ and arg_181_1.time_ <= var_184_2 + arg_184_0 then
				local var_184_3 = manager.ui.mainCamera.transform.localPosition
				local var_184_4 = Vector3.New(0, 0, 10) + Vector3.New(var_184_3.x, var_184_3.y, 0)
				local var_184_5 = arg_181_1.bgs_.I05d

				var_184_5.transform.localPosition = var_184_4
				var_184_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_184_6 = var_184_5:GetComponent("SpriteRenderer")

				if var_184_6 and var_184_6.sprite then
					local var_184_7 = (var_184_5.transform.localPosition - var_184_3).z
					local var_184_8 = manager.ui.mainCameraCom_
					local var_184_9 = 2 * var_184_7 * Mathf.Tan(var_184_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_184_10 = var_184_9 * var_184_8.aspect
					local var_184_11 = var_184_6.sprite.bounds.size.x
					local var_184_12 = var_184_6.sprite.bounds.size.y
					local var_184_13 = var_184_10 / var_184_11
					local var_184_14 = var_184_9 / var_184_12
					local var_184_15 = var_184_14 < var_184_13 and var_184_13 or var_184_14

					var_184_5.transform.localScale = Vector3.New(var_184_15, var_184_15, 0)
				end

				for iter_184_0, iter_184_1 in pairs(arg_181_1.bgs_) do
					if iter_184_0 ~= "I05d" then
						iter_184_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_184_16 = 0

			if var_184_16 < arg_181_1.time_ and arg_181_1.time_ <= var_184_16 + arg_184_0 then
				arg_181_1.mask_.enabled = true
				arg_181_1.mask_.raycastTarget = true

				arg_181_1:SetGaussion(false)
			end

			local var_184_17 = 4

			if var_184_16 <= arg_181_1.time_ and arg_181_1.time_ < var_184_16 + var_184_17 then
				local var_184_18 = (arg_181_1.time_ - var_184_16) / var_184_17
				local var_184_19 = Color.New(0, 0, 0)

				var_184_19.a = Mathf.Lerp(0, 1, var_184_18)
				arg_181_1.mask_.color = var_184_19
			end

			if arg_181_1.time_ >= var_184_16 + var_184_17 and arg_181_1.time_ < var_184_16 + var_184_17 + arg_184_0 then
				local var_184_20 = Color.New(0, 0, 0)

				var_184_20.a = 1
				arg_181_1.mask_.color = var_184_20
			end

			local var_184_21 = 4

			if var_184_21 < arg_181_1.time_ and arg_181_1.time_ <= var_184_21 + arg_184_0 then
				arg_181_1.mask_.enabled = true
				arg_181_1.mask_.raycastTarget = true

				arg_181_1:SetGaussion(false)
			end

			local var_184_22 = 4

			if var_184_21 <= arg_181_1.time_ and arg_181_1.time_ < var_184_21 + var_184_22 then
				local var_184_23 = (arg_181_1.time_ - var_184_21) / var_184_22
				local var_184_24 = Color.New(0, 0, 0)

				var_184_24.a = Mathf.Lerp(1, 0, var_184_23)
				arg_181_1.mask_.color = var_184_24
			end

			if arg_181_1.time_ >= var_184_21 + var_184_22 and arg_181_1.time_ < var_184_21 + var_184_22 + arg_184_0 then
				local var_184_25 = Color.New(0, 0, 0)
				local var_184_26 = 0

				arg_181_1.mask_.enabled = false
				var_184_25.a = var_184_26
				arg_181_1.mask_.color = var_184_25
			end

			local var_184_27 = arg_181_1.actors_["1094ui_story"].transform
			local var_184_28 = 0

			if var_184_28 < arg_181_1.time_ and arg_181_1.time_ <= var_184_28 + arg_184_0 then
				arg_181_1.var_.moveOldPos1094ui_story = var_184_27.localPosition
			end

			local var_184_29 = 0.001

			if var_184_28 <= arg_181_1.time_ and arg_181_1.time_ < var_184_28 + var_184_29 then
				local var_184_30 = (arg_181_1.time_ - var_184_28) / var_184_29
				local var_184_31 = Vector3.New(0, 100, 0)

				var_184_27.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos1094ui_story, var_184_31, var_184_30)

				local var_184_32 = manager.ui.mainCamera.transform.position - var_184_27.position

				var_184_27.forward = Vector3.New(var_184_32.x, var_184_32.y, var_184_32.z)

				local var_184_33 = var_184_27.localEulerAngles

				var_184_33.z = 0
				var_184_33.x = 0
				var_184_27.localEulerAngles = var_184_33
			end

			if arg_181_1.time_ >= var_184_28 + var_184_29 and arg_181_1.time_ < var_184_28 + var_184_29 + arg_184_0 then
				var_184_27.localPosition = Vector3.New(0, 100, 0)

				local var_184_34 = manager.ui.mainCamera.transform.position - var_184_27.position

				var_184_27.forward = Vector3.New(var_184_34.x, var_184_34.y, var_184_34.z)

				local var_184_35 = var_184_27.localEulerAngles

				var_184_35.z = 0
				var_184_35.x = 0
				var_184_27.localEulerAngles = var_184_35
			end

			local var_184_36 = arg_181_1.actors_["1094ui_story"]
			local var_184_37 = 0

			if var_184_37 < arg_181_1.time_ and arg_181_1.time_ <= var_184_37 + arg_184_0 and not isNil(var_184_36) and arg_181_1.var_.characterEffect1094ui_story == nil then
				arg_181_1.var_.characterEffect1094ui_story = var_184_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_38 = 0.200000002980232

			if var_184_37 <= arg_181_1.time_ and arg_181_1.time_ < var_184_37 + var_184_38 and not isNil(var_184_36) then
				local var_184_39 = (arg_181_1.time_ - var_184_37) / var_184_38

				if arg_181_1.var_.characterEffect1094ui_story and not isNil(var_184_36) then
					local var_184_40 = Mathf.Lerp(0, 0.5, var_184_39)

					arg_181_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_181_1.var_.characterEffect1094ui_story.fillRatio = var_184_40
				end
			end

			if arg_181_1.time_ >= var_184_37 + var_184_38 and arg_181_1.time_ < var_184_37 + var_184_38 + arg_184_0 and not isNil(var_184_36) and arg_181_1.var_.characterEffect1094ui_story then
				local var_184_41 = 0.5

				arg_181_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_181_1.var_.characterEffect1094ui_story.fillRatio = var_184_41
			end

			if arg_181_1.frameCnt_ <= 1 then
				arg_181_1.dialog_:SetActive(false)
			end

			local var_184_42 = 8
			local var_184_43 = 0.725

			if var_184_42 < arg_181_1.time_ and arg_181_1.time_ <= var_184_42 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0

				arg_181_1.dialog_:SetActive(true)

				arg_181_1.dialogCg_.alpha = 0

				local var_184_44 = LeanTween.value(arg_181_1.dialog_, 0, 1, 0.3)

				var_184_44:setOnUpdate(LuaHelper.FloatAction(function(arg_185_0)
					arg_181_1.dialogCg_.alpha = arg_185_0
				end))
				var_184_44:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_181_1.dialog_)
					var_184_44:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_181_1.duration_ = arg_181_1.duration_ + 0.3

				SetActive(arg_181_1.leftNameGo_, false)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_45 = arg_181_1:GetWordFromCfg(1109402044)
				local var_184_46 = arg_181_1:FormatText(var_184_45.content)

				arg_181_1.text_.text = var_184_46

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_47 = 29
				local var_184_48 = utf8.len(var_184_46)
				local var_184_49 = var_184_47 <= 0 and var_184_43 or var_184_43 * (var_184_48 / var_184_47)

				if var_184_49 > 0 and var_184_43 < var_184_49 then
					arg_181_1.talkMaxDuration = var_184_49
					var_184_42 = var_184_42 + 0.3

					if var_184_49 + var_184_42 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_49 + var_184_42
					end
				end

				arg_181_1.text_.text = var_184_46
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_50 = var_184_42 + 0.3
			local var_184_51 = math.max(var_184_43, arg_181_1.talkMaxDuration)

			if var_184_50 <= arg_181_1.time_ and arg_181_1.time_ < var_184_50 + var_184_51 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_50) / var_184_51

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_50 + var_184_51 and arg_181_1.time_ < var_184_50 + var_184_51 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_181_1:InitPlayNodeList()
	end,
	Play1109402045 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 1109402045
		arg_187_1.duration_ = 5

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play1109402046(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = 0
			local var_190_1 = 0.8

			if var_190_0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_0 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, false)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_2 = arg_187_1:GetWordFromCfg(1109402045)
				local var_190_3 = arg_187_1:FormatText(var_190_2.content)

				arg_187_1.text_.text = var_190_3

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_4 = 29
				local var_190_5 = utf8.len(var_190_3)
				local var_190_6 = var_190_4 <= 0 and var_190_1 or var_190_1 * (var_190_5 / var_190_4)

				if var_190_6 > 0 and var_190_1 < var_190_6 then
					arg_187_1.talkMaxDuration = var_190_6

					if var_190_6 + var_190_0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_6 + var_190_0
					end
				end

				arg_187_1.text_.text = var_190_3
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)
				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_7 = math.max(var_190_1, arg_187_1.talkMaxDuration)

			if var_190_0 <= arg_187_1.time_ and arg_187_1.time_ < var_190_0 + var_190_7 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_0) / var_190_7

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_0 + var_190_7 and arg_187_1.time_ < var_190_0 + var_190_7 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play1109402046 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 1109402046
		arg_191_1.duration_ = 5

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play1109402047(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = 0
			local var_194_1 = 0.775

			if var_194_0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_0 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				local var_194_2 = arg_191_1:FormatText(StoryNameCfg[7].name)

				arg_191_1.leftNameTxt_.text = var_194_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, true)
				arg_191_1.iconController_:SetSelectedState("hero")

				arg_191_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_191_1.callingController_:SetSelectedState("normal")

				arg_191_1.keyicon_.color = Color.New(1, 1, 1)
				arg_191_1.icon_.color = Color.New(1, 1, 1)

				local var_194_3 = arg_191_1:GetWordFromCfg(1109402046)
				local var_194_4 = arg_191_1:FormatText(var_194_3.content)

				arg_191_1.text_.text = var_194_4

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_5 = 31
				local var_194_6 = utf8.len(var_194_4)
				local var_194_7 = var_194_5 <= 0 and var_194_1 or var_194_1 * (var_194_6 / var_194_5)

				if var_194_7 > 0 and var_194_1 < var_194_7 then
					arg_191_1.talkMaxDuration = var_194_7

					if var_194_7 + var_194_0 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_7 + var_194_0
					end
				end

				arg_191_1.text_.text = var_194_4
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)
				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_8 = math.max(var_194_1, arg_191_1.talkMaxDuration)

			if var_194_0 <= arg_191_1.time_ and arg_191_1.time_ < var_194_0 + var_194_8 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_0) / var_194_8

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_0 + var_194_8 and arg_191_1.time_ < var_194_0 + var_194_8 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play1109402047 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 1109402047
		arg_195_1.duration_ = 5

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play1109402048(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = 0
			local var_198_1 = 1.125

			if var_198_0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_0 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, false)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_2 = arg_195_1:GetWordFromCfg(1109402047)
				local var_198_3 = arg_195_1:FormatText(var_198_2.content)

				arg_195_1.text_.text = var_198_3

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_4 = 45
				local var_198_5 = utf8.len(var_198_3)
				local var_198_6 = var_198_4 <= 0 and var_198_1 or var_198_1 * (var_198_5 / var_198_4)

				if var_198_6 > 0 and var_198_1 < var_198_6 then
					arg_195_1.talkMaxDuration = var_198_6

					if var_198_6 + var_198_0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_6 + var_198_0
					end
				end

				arg_195_1.text_.text = var_198_3
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)
				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_7 = math.max(var_198_1, arg_195_1.talkMaxDuration)

			if var_198_0 <= arg_195_1.time_ and arg_195_1.time_ < var_198_0 + var_198_7 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_0) / var_198_7

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_0 + var_198_7 and arg_195_1.time_ < var_198_0 + var_198_7 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play1109402048 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 1109402048
		arg_199_1.duration_ = 6.4

		local var_199_0 = {
			ja = 6.4,
			ko = 2.466,
			zh = 2.466
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
				arg_199_0:Play1109402049(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = 0
			local var_202_1 = 0.25

			if var_202_0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_0 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				local var_202_2 = arg_199_1:FormatText(StoryNameCfg[189].name)

				arg_199_1.leftNameTxt_.text = var_202_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, true)
				arg_199_1.iconController_:SetSelectedState("hero")

				arg_199_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vina")

				arg_199_1.callingController_:SetSelectedState("normal")

				arg_199_1.keyicon_.color = Color.New(1, 1, 1)
				arg_199_1.icon_.color = Color.New(1, 1, 1)

				local var_202_3 = arg_199_1:GetWordFromCfg(1109402048)
				local var_202_4 = arg_199_1:FormatText(var_202_3.content)

				arg_199_1.text_.text = var_202_4

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_5 = 10
				local var_202_6 = utf8.len(var_202_4)
				local var_202_7 = var_202_5 <= 0 and var_202_1 or var_202_1 * (var_202_6 / var_202_5)

				if var_202_7 > 0 and var_202_1 < var_202_7 then
					arg_199_1.talkMaxDuration = var_202_7

					if var_202_7 + var_202_0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_7 + var_202_0
					end
				end

				arg_199_1.text_.text = var_202_4
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402048", "story_v_side_new_1109402.awb") ~= 0 then
					local var_202_8 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402048", "story_v_side_new_1109402.awb") / 1000

					if var_202_8 + var_202_0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_8 + var_202_0
					end

					if var_202_3.prefab_name ~= "" and arg_199_1.actors_[var_202_3.prefab_name] ~= nil then
						local var_202_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_3.prefab_name].transform, "story_v_side_new_1109402", "1109402048", "story_v_side_new_1109402.awb")

						arg_199_1:RecordAudio("1109402048", var_202_9)
						arg_199_1:RecordAudio("1109402048", var_202_9)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402048", "story_v_side_new_1109402.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402048", "story_v_side_new_1109402.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_10 = math.max(var_202_1, arg_199_1.talkMaxDuration)

			if var_202_0 <= arg_199_1.time_ and arg_199_1.time_ < var_202_0 + var_202_10 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_0) / var_202_10

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_0 + var_202_10 and arg_199_1.time_ < var_202_0 + var_202_10 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play1109402049 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 1109402049
		arg_203_1.duration_ = 5

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play1109402050(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = 0
			local var_206_1 = 0.3

			if var_206_0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_0 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, false)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_2 = arg_203_1:GetWordFromCfg(1109402049)
				local var_206_3 = arg_203_1:FormatText(var_206_2.content)

				arg_203_1.text_.text = var_206_3

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_4 = 12
				local var_206_5 = utf8.len(var_206_3)
				local var_206_6 = var_206_4 <= 0 and var_206_1 or var_206_1 * (var_206_5 / var_206_4)

				if var_206_6 > 0 and var_206_1 < var_206_6 then
					arg_203_1.talkMaxDuration = var_206_6

					if var_206_6 + var_206_0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_6 + var_206_0
					end
				end

				arg_203_1.text_.text = var_206_3
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)
				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_7 = math.max(var_206_1, arg_203_1.talkMaxDuration)

			if var_206_0 <= arg_203_1.time_ and arg_203_1.time_ < var_206_0 + var_206_7 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_0) / var_206_7

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_0 + var_206_7 and arg_203_1.time_ < var_206_0 + var_206_7 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play1109402050 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 1109402050
		arg_207_1.duration_ = 5

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play1109402051(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = 0
			local var_210_1 = 0.55

			if var_210_0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_0 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				local var_210_2 = arg_207_1:FormatText(StoryNameCfg[7].name)

				arg_207_1.leftNameTxt_.text = var_210_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, true)
				arg_207_1.iconController_:SetSelectedState("hero")

				arg_207_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_207_1.callingController_:SetSelectedState("normal")

				arg_207_1.keyicon_.color = Color.New(1, 1, 1)
				arg_207_1.icon_.color = Color.New(1, 1, 1)

				local var_210_3 = arg_207_1:GetWordFromCfg(1109402050)
				local var_210_4 = arg_207_1:FormatText(var_210_3.content)

				arg_207_1.text_.text = var_210_4

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_5 = 22
				local var_210_6 = utf8.len(var_210_4)
				local var_210_7 = var_210_5 <= 0 and var_210_1 or var_210_1 * (var_210_6 / var_210_5)

				if var_210_7 > 0 and var_210_1 < var_210_7 then
					arg_207_1.talkMaxDuration = var_210_7

					if var_210_7 + var_210_0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_7 + var_210_0
					end
				end

				arg_207_1.text_.text = var_210_4
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)
				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_8 = math.max(var_210_1, arg_207_1.talkMaxDuration)

			if var_210_0 <= arg_207_1.time_ and arg_207_1.time_ < var_210_0 + var_210_8 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_0) / var_210_8

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_0 + var_210_8 and arg_207_1.time_ < var_210_0 + var_210_8 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play1109402051 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 1109402051
		arg_211_1.duration_ = 5

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play1109402052(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = arg_211_1.actors_["1094ui_story"].transform
			local var_214_1 = 0

			if var_214_1 < arg_211_1.time_ and arg_211_1.time_ <= var_214_1 + arg_214_0 then
				arg_211_1.var_.moveOldPos1094ui_story = var_214_0.localPosition
			end

			local var_214_2 = 0.001

			if var_214_1 <= arg_211_1.time_ and arg_211_1.time_ < var_214_1 + var_214_2 then
				local var_214_3 = (arg_211_1.time_ - var_214_1) / var_214_2
				local var_214_4 = Vector3.New(0, -0.84, -6.1)

				var_214_0.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos1094ui_story, var_214_4, var_214_3)

				local var_214_5 = manager.ui.mainCamera.transform.position - var_214_0.position

				var_214_0.forward = Vector3.New(var_214_5.x, var_214_5.y, var_214_5.z)

				local var_214_6 = var_214_0.localEulerAngles

				var_214_6.z = 0
				var_214_6.x = 0
				var_214_0.localEulerAngles = var_214_6
			end

			if arg_211_1.time_ >= var_214_1 + var_214_2 and arg_211_1.time_ < var_214_1 + var_214_2 + arg_214_0 then
				var_214_0.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_214_7 = manager.ui.mainCamera.transform.position - var_214_0.position

				var_214_0.forward = Vector3.New(var_214_7.x, var_214_7.y, var_214_7.z)

				local var_214_8 = var_214_0.localEulerAngles

				var_214_8.z = 0
				var_214_8.x = 0
				var_214_0.localEulerAngles = var_214_8
			end

			local var_214_9 = arg_211_1.actors_["1094ui_story"]
			local var_214_10 = 0

			if var_214_10 < arg_211_1.time_ and arg_211_1.time_ <= var_214_10 + arg_214_0 and not isNil(var_214_9) and arg_211_1.var_.characterEffect1094ui_story == nil then
				arg_211_1.var_.characterEffect1094ui_story = var_214_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_11 = 0.0166666666666667

			if var_214_10 <= arg_211_1.time_ and arg_211_1.time_ < var_214_10 + var_214_11 and not isNil(var_214_9) then
				local var_214_12 = (arg_211_1.time_ - var_214_10) / var_214_11

				if arg_211_1.var_.characterEffect1094ui_story and not isNil(var_214_9) then
					local var_214_13 = Mathf.Lerp(0, 0.5, var_214_12)

					arg_211_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_211_1.var_.characterEffect1094ui_story.fillRatio = var_214_13
				end
			end

			if arg_211_1.time_ >= var_214_10 + var_214_11 and arg_211_1.time_ < var_214_10 + var_214_11 + arg_214_0 and not isNil(var_214_9) and arg_211_1.var_.characterEffect1094ui_story then
				local var_214_14 = 0.5

				arg_211_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_211_1.var_.characterEffect1094ui_story.fillRatio = var_214_14
			end

			local var_214_15 = 0

			if var_214_15 < arg_211_1.time_ and arg_211_1.time_ <= var_214_15 + arg_214_0 then
				arg_211_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action1_1")
			end

			local var_214_16 = 0
			local var_214_17 = 0.9

			if var_214_16 < arg_211_1.time_ and arg_211_1.time_ <= var_214_16 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, false)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_18 = arg_211_1:GetWordFromCfg(1109402051)
				local var_214_19 = arg_211_1:FormatText(var_214_18.content)

				arg_211_1.text_.text = var_214_19

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_20 = 36
				local var_214_21 = utf8.len(var_214_19)
				local var_214_22 = var_214_20 <= 0 and var_214_17 or var_214_17 * (var_214_21 / var_214_20)

				if var_214_22 > 0 and var_214_17 < var_214_22 then
					arg_211_1.talkMaxDuration = var_214_22

					if var_214_22 + var_214_16 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_22 + var_214_16
					end
				end

				arg_211_1.text_.text = var_214_19
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)
				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_23 = math.max(var_214_17, arg_211_1.talkMaxDuration)

			if var_214_16 <= arg_211_1.time_ and arg_211_1.time_ < var_214_16 + var_214_23 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_16) / var_214_23

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_16 + var_214_23 and arg_211_1.time_ < var_214_16 + var_214_23 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_211_1:InitPlayNodeList()
	end,
	Play1109402052 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 1109402052
		arg_215_1.duration_ = 2.83

		local var_215_0 = {
			ja = 2.833,
			ko = 2.433,
			zh = 2.433
		}
		local var_215_1 = manager.audio:GetLocalizationFlag()

		if var_215_0[var_215_1] ~= nil then
			arg_215_1.duration_ = var_215_0[var_215_1]
		end

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play1109402053(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = arg_215_1.actors_["1094ui_story"]
			local var_218_1 = 0

			if var_218_1 < arg_215_1.time_ and arg_215_1.time_ <= var_218_1 + arg_218_0 and not isNil(var_218_0) and arg_215_1.var_.characterEffect1094ui_story == nil then
				arg_215_1.var_.characterEffect1094ui_story = var_218_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_2 = 0.2

			if var_218_1 <= arg_215_1.time_ and arg_215_1.time_ < var_218_1 + var_218_2 and not isNil(var_218_0) then
				local var_218_3 = (arg_215_1.time_ - var_218_1) / var_218_2

				if arg_215_1.var_.characterEffect1094ui_story and not isNil(var_218_0) then
					arg_215_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_215_1.time_ >= var_218_1 + var_218_2 and arg_215_1.time_ < var_218_1 + var_218_2 + arg_218_0 and not isNil(var_218_0) and arg_215_1.var_.characterEffect1094ui_story then
				arg_215_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_218_4 = 0

			if var_218_4 < arg_215_1.time_ and arg_215_1.time_ <= var_218_4 + arg_218_0 then
				arg_215_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_218_5 = 0
			local var_218_6 = 0.3

			if var_218_5 < arg_215_1.time_ and arg_215_1.time_ <= var_218_5 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				local var_218_7 = arg_215_1:FormatText(StoryNameCfg[181].name)

				arg_215_1.leftNameTxt_.text = var_218_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_8 = arg_215_1:GetWordFromCfg(1109402052)
				local var_218_9 = arg_215_1:FormatText(var_218_8.content)

				arg_215_1.text_.text = var_218_9

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_10 = 12
				local var_218_11 = utf8.len(var_218_9)
				local var_218_12 = var_218_10 <= 0 and var_218_6 or var_218_6 * (var_218_11 / var_218_10)

				if var_218_12 > 0 and var_218_6 < var_218_12 then
					arg_215_1.talkMaxDuration = var_218_12

					if var_218_12 + var_218_5 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_12 + var_218_5
					end
				end

				arg_215_1.text_.text = var_218_9
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402052", "story_v_side_new_1109402.awb") ~= 0 then
					local var_218_13 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402052", "story_v_side_new_1109402.awb") / 1000

					if var_218_13 + var_218_5 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_13 + var_218_5
					end

					if var_218_8.prefab_name ~= "" and arg_215_1.actors_[var_218_8.prefab_name] ~= nil then
						local var_218_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_8.prefab_name].transform, "story_v_side_new_1109402", "1109402052", "story_v_side_new_1109402.awb")

						arg_215_1:RecordAudio("1109402052", var_218_14)
						arg_215_1:RecordAudio("1109402052", var_218_14)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402052", "story_v_side_new_1109402.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402052", "story_v_side_new_1109402.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_15 = math.max(var_218_6, arg_215_1.talkMaxDuration)

			if var_218_5 <= arg_215_1.time_ and arg_215_1.time_ < var_218_5 + var_218_15 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_5) / var_218_15

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_5 + var_218_15 and arg_215_1.time_ < var_218_5 + var_218_15 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play1109402053 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 1109402053
		arg_219_1.duration_ = 8.3

		local var_219_0 = {
			ja = 8.3,
			ko = 6.366,
			zh = 6.366
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
				arg_219_0:Play1109402054(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = arg_219_1.actors_["1094ui_story"]
			local var_222_1 = 0

			if var_222_1 < arg_219_1.time_ and arg_219_1.time_ <= var_222_1 + arg_222_0 and not isNil(var_222_0) and arg_219_1.var_.characterEffect1094ui_story == nil then
				arg_219_1.var_.characterEffect1094ui_story = var_222_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_2 = 0.2

			if var_222_1 <= arg_219_1.time_ and arg_219_1.time_ < var_222_1 + var_222_2 and not isNil(var_222_0) then
				local var_222_3 = (arg_219_1.time_ - var_222_1) / var_222_2

				if arg_219_1.var_.characterEffect1094ui_story and not isNil(var_222_0) then
					local var_222_4 = Mathf.Lerp(0, 0.5, var_222_3)

					arg_219_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_219_1.var_.characterEffect1094ui_story.fillRatio = var_222_4
				end
			end

			if arg_219_1.time_ >= var_222_1 + var_222_2 and arg_219_1.time_ < var_222_1 + var_222_2 + arg_222_0 and not isNil(var_222_0) and arg_219_1.var_.characterEffect1094ui_story then
				local var_222_5 = 0.5

				arg_219_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_219_1.var_.characterEffect1094ui_story.fillRatio = var_222_5
			end

			local var_222_6 = 0
			local var_222_7 = 0.975

			if var_222_6 < arg_219_1.time_ and arg_219_1.time_ <= var_222_6 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				local var_222_8 = arg_219_1:FormatText(StoryNameCfg[189].name)

				arg_219_1.leftNameTxt_.text = var_222_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, true)
				arg_219_1.iconController_:SetSelectedState("hero")

				arg_219_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vina")

				arg_219_1.callingController_:SetSelectedState("normal")

				arg_219_1.keyicon_.color = Color.New(1, 1, 1)
				arg_219_1.icon_.color = Color.New(1, 1, 1)

				local var_222_9 = arg_219_1:GetWordFromCfg(1109402053)
				local var_222_10 = arg_219_1:FormatText(var_222_9.content)

				arg_219_1.text_.text = var_222_10

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_11 = 39
				local var_222_12 = utf8.len(var_222_10)
				local var_222_13 = var_222_11 <= 0 and var_222_7 or var_222_7 * (var_222_12 / var_222_11)

				if var_222_13 > 0 and var_222_7 < var_222_13 then
					arg_219_1.talkMaxDuration = var_222_13

					if var_222_13 + var_222_6 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_13 + var_222_6
					end
				end

				arg_219_1.text_.text = var_222_10
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402053", "story_v_side_new_1109402.awb") ~= 0 then
					local var_222_14 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402053", "story_v_side_new_1109402.awb") / 1000

					if var_222_14 + var_222_6 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_14 + var_222_6
					end

					if var_222_9.prefab_name ~= "" and arg_219_1.actors_[var_222_9.prefab_name] ~= nil then
						local var_222_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_9.prefab_name].transform, "story_v_side_new_1109402", "1109402053", "story_v_side_new_1109402.awb")

						arg_219_1:RecordAudio("1109402053", var_222_15)
						arg_219_1:RecordAudio("1109402053", var_222_15)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402053", "story_v_side_new_1109402.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402053", "story_v_side_new_1109402.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_16 = math.max(var_222_7, arg_219_1.talkMaxDuration)

			if var_222_6 <= arg_219_1.time_ and arg_219_1.time_ < var_222_6 + var_222_16 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_6) / var_222_16

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_6 + var_222_16 and arg_219_1.time_ < var_222_6 + var_222_16 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play1109402054 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 1109402054
		arg_223_1.duration_ = 5

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play1109402055(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = 0
			local var_226_1 = 0.675

			if var_226_0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_0 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				local var_226_2 = arg_223_1:FormatText(StoryNameCfg[7].name)

				arg_223_1.leftNameTxt_.text = var_226_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, true)
				arg_223_1.iconController_:SetSelectedState("hero")

				arg_223_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_223_1.callingController_:SetSelectedState("normal")

				arg_223_1.keyicon_.color = Color.New(1, 1, 1)
				arg_223_1.icon_.color = Color.New(1, 1, 1)

				local var_226_3 = arg_223_1:GetWordFromCfg(1109402054)
				local var_226_4 = arg_223_1:FormatText(var_226_3.content)

				arg_223_1.text_.text = var_226_4

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_5 = 28
				local var_226_6 = utf8.len(var_226_4)
				local var_226_7 = var_226_5 <= 0 and var_226_1 or var_226_1 * (var_226_6 / var_226_5)

				if var_226_7 > 0 and var_226_1 < var_226_7 then
					arg_223_1.talkMaxDuration = var_226_7

					if var_226_7 + var_226_0 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_7 + var_226_0
					end
				end

				arg_223_1.text_.text = var_226_4
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)
				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_8 = math.max(var_226_1, arg_223_1.talkMaxDuration)

			if var_226_0 <= arg_223_1.time_ and arg_223_1.time_ < var_226_0 + var_226_8 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_0) / var_226_8

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_0 + var_226_8 and arg_223_1.time_ < var_226_0 + var_226_8 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play1109402055 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 1109402055
		arg_227_1.duration_ = 2.6

		local var_227_0 = {
			ja = 2.6,
			ko = 1.999999999999,
			zh = 1.999999999999
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
				arg_227_0:Play1109402056(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = arg_227_1.actors_["1094ui_story"].transform
			local var_230_1 = 0

			if var_230_1 < arg_227_1.time_ and arg_227_1.time_ <= var_230_1 + arg_230_0 then
				arg_227_1.var_.moveOldPos1094ui_story = var_230_0.localPosition
			end

			local var_230_2 = 0.001

			if var_230_1 <= arg_227_1.time_ and arg_227_1.time_ < var_230_1 + var_230_2 then
				local var_230_3 = (arg_227_1.time_ - var_230_1) / var_230_2
				local var_230_4 = Vector3.New(0, -0.84, -6.1)

				var_230_0.localPosition = Vector3.Lerp(arg_227_1.var_.moveOldPos1094ui_story, var_230_4, var_230_3)

				local var_230_5 = manager.ui.mainCamera.transform.position - var_230_0.position

				var_230_0.forward = Vector3.New(var_230_5.x, var_230_5.y, var_230_5.z)

				local var_230_6 = var_230_0.localEulerAngles

				var_230_6.z = 0
				var_230_6.x = 0
				var_230_0.localEulerAngles = var_230_6
			end

			if arg_227_1.time_ >= var_230_1 + var_230_2 and arg_227_1.time_ < var_230_1 + var_230_2 + arg_230_0 then
				var_230_0.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_230_7 = manager.ui.mainCamera.transform.position - var_230_0.position

				var_230_0.forward = Vector3.New(var_230_7.x, var_230_7.y, var_230_7.z)

				local var_230_8 = var_230_0.localEulerAngles

				var_230_8.z = 0
				var_230_8.x = 0
				var_230_0.localEulerAngles = var_230_8
			end

			local var_230_9 = arg_227_1.actors_["1094ui_story"]
			local var_230_10 = 0

			if var_230_10 < arg_227_1.time_ and arg_227_1.time_ <= var_230_10 + arg_230_0 and not isNil(var_230_9) and arg_227_1.var_.characterEffect1094ui_story == nil then
				arg_227_1.var_.characterEffect1094ui_story = var_230_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_11 = 0.200000002980232

			if var_230_10 <= arg_227_1.time_ and arg_227_1.time_ < var_230_10 + var_230_11 and not isNil(var_230_9) then
				local var_230_12 = (arg_227_1.time_ - var_230_10) / var_230_11

				if arg_227_1.var_.characterEffect1094ui_story and not isNil(var_230_9) then
					arg_227_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_227_1.time_ >= var_230_10 + var_230_11 and arg_227_1.time_ < var_230_10 + var_230_11 + arg_230_0 and not isNil(var_230_9) and arg_227_1.var_.characterEffect1094ui_story then
				arg_227_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_230_13 = 0

			if var_230_13 < arg_227_1.time_ and arg_227_1.time_ <= var_230_13 + arg_230_0 then
				arg_227_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_230_14 = 0
			local var_230_15 = 0.15

			if var_230_14 < arg_227_1.time_ and arg_227_1.time_ <= var_230_14 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				local var_230_16 = arg_227_1:FormatText(StoryNameCfg[181].name)

				arg_227_1.leftNameTxt_.text = var_230_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_17 = arg_227_1:GetWordFromCfg(1109402055)
				local var_230_18 = arg_227_1:FormatText(var_230_17.content)

				arg_227_1.text_.text = var_230_18

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_19 = 6
				local var_230_20 = utf8.len(var_230_18)
				local var_230_21 = var_230_19 <= 0 and var_230_15 or var_230_15 * (var_230_20 / var_230_19)

				if var_230_21 > 0 and var_230_15 < var_230_21 then
					arg_227_1.talkMaxDuration = var_230_21

					if var_230_21 + var_230_14 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_21 + var_230_14
					end
				end

				arg_227_1.text_.text = var_230_18
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402055", "story_v_side_new_1109402.awb") ~= 0 then
					local var_230_22 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402055", "story_v_side_new_1109402.awb") / 1000

					if var_230_22 + var_230_14 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_22 + var_230_14
					end

					if var_230_17.prefab_name ~= "" and arg_227_1.actors_[var_230_17.prefab_name] ~= nil then
						local var_230_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_17.prefab_name].transform, "story_v_side_new_1109402", "1109402055", "story_v_side_new_1109402.awb")

						arg_227_1:RecordAudio("1109402055", var_230_23)
						arg_227_1:RecordAudio("1109402055", var_230_23)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402055", "story_v_side_new_1109402.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402055", "story_v_side_new_1109402.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_24 = math.max(var_230_15, arg_227_1.talkMaxDuration)

			if var_230_14 <= arg_227_1.time_ and arg_227_1.time_ < var_230_14 + var_230_24 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_14) / var_230_24

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_14 + var_230_24 and arg_227_1.time_ < var_230_14 + var_230_24 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_227_1:InitPlayNodeList()
	end,
	Play1109402056 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 1109402056
		arg_231_1.duration_ = 3.97

		local var_231_0 = {
			ja = 3.966,
			ko = 3.2,
			zh = 3.2
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
				arg_231_0:Play1109402057(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = arg_231_1.actors_["1094ui_story"].transform
			local var_234_1 = 0

			if var_234_1 < arg_231_1.time_ and arg_231_1.time_ <= var_234_1 + arg_234_0 then
				arg_231_1.var_.moveOldPos1094ui_story = var_234_0.localPosition
			end

			local var_234_2 = 0.001

			if var_234_1 <= arg_231_1.time_ and arg_231_1.time_ < var_234_1 + var_234_2 then
				local var_234_3 = (arg_231_1.time_ - var_234_1) / var_234_2
				local var_234_4 = Vector3.New(0, -0.84, -6.1)

				var_234_0.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos1094ui_story, var_234_4, var_234_3)

				local var_234_5 = manager.ui.mainCamera.transform.position - var_234_0.position

				var_234_0.forward = Vector3.New(var_234_5.x, var_234_5.y, var_234_5.z)

				local var_234_6 = var_234_0.localEulerAngles

				var_234_6.z = 0
				var_234_6.x = 0
				var_234_0.localEulerAngles = var_234_6
			end

			if arg_231_1.time_ >= var_234_1 + var_234_2 and arg_231_1.time_ < var_234_1 + var_234_2 + arg_234_0 then
				var_234_0.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_234_7 = manager.ui.mainCamera.transform.position - var_234_0.position

				var_234_0.forward = Vector3.New(var_234_7.x, var_234_7.y, var_234_7.z)

				local var_234_8 = var_234_0.localEulerAngles

				var_234_8.z = 0
				var_234_8.x = 0
				var_234_0.localEulerAngles = var_234_8
			end

			local var_234_9 = 0

			if var_234_9 < arg_231_1.time_ and arg_231_1.time_ <= var_234_9 + arg_234_0 then
				arg_231_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_234_10 = 0
			local var_234_11 = 0.25

			if var_234_10 < arg_231_1.time_ and arg_231_1.time_ <= var_234_10 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				local var_234_12 = arg_231_1:FormatText(StoryNameCfg[181].name)

				arg_231_1.leftNameTxt_.text = var_234_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_13 = arg_231_1:GetWordFromCfg(1109402056)
				local var_234_14 = arg_231_1:FormatText(var_234_13.content)

				arg_231_1.text_.text = var_234_14

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_15 = 10
				local var_234_16 = utf8.len(var_234_14)
				local var_234_17 = var_234_15 <= 0 and var_234_11 or var_234_11 * (var_234_16 / var_234_15)

				if var_234_17 > 0 and var_234_11 < var_234_17 then
					arg_231_1.talkMaxDuration = var_234_17

					if var_234_17 + var_234_10 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_17 + var_234_10
					end
				end

				arg_231_1.text_.text = var_234_14
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402056", "story_v_side_new_1109402.awb") ~= 0 then
					local var_234_18 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402056", "story_v_side_new_1109402.awb") / 1000

					if var_234_18 + var_234_10 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_18 + var_234_10
					end

					if var_234_13.prefab_name ~= "" and arg_231_1.actors_[var_234_13.prefab_name] ~= nil then
						local var_234_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_13.prefab_name].transform, "story_v_side_new_1109402", "1109402056", "story_v_side_new_1109402.awb")

						arg_231_1:RecordAudio("1109402056", var_234_19)
						arg_231_1:RecordAudio("1109402056", var_234_19)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402056", "story_v_side_new_1109402.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402056", "story_v_side_new_1109402.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_20 = math.max(var_234_11, arg_231_1.talkMaxDuration)

			if var_234_10 <= arg_231_1.time_ and arg_231_1.time_ < var_234_10 + var_234_20 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_10) / var_234_20

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_10 + var_234_20 and arg_231_1.time_ < var_234_10 + var_234_20 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_231_1:InitPlayNodeList()
	end,
	Play1109402057 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 1109402057
		arg_235_1.duration_ = 5

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play1109402058(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = arg_235_1.actors_["1094ui_story"]
			local var_238_1 = 0

			if var_238_1 < arg_235_1.time_ and arg_235_1.time_ <= var_238_1 + arg_238_0 and not isNil(var_238_0) and arg_235_1.var_.characterEffect1094ui_story == nil then
				arg_235_1.var_.characterEffect1094ui_story = var_238_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_2 = 0.200000002980232

			if var_238_1 <= arg_235_1.time_ and arg_235_1.time_ < var_238_1 + var_238_2 and not isNil(var_238_0) then
				local var_238_3 = (arg_235_1.time_ - var_238_1) / var_238_2

				if arg_235_1.var_.characterEffect1094ui_story and not isNil(var_238_0) then
					local var_238_4 = Mathf.Lerp(0, 0.5, var_238_3)

					arg_235_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_235_1.var_.characterEffect1094ui_story.fillRatio = var_238_4
				end
			end

			if arg_235_1.time_ >= var_238_1 + var_238_2 and arg_235_1.time_ < var_238_1 + var_238_2 + arg_238_0 and not isNil(var_238_0) and arg_235_1.var_.characterEffect1094ui_story then
				local var_238_5 = 0.5

				arg_235_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_235_1.var_.characterEffect1094ui_story.fillRatio = var_238_5
			end

			local var_238_6 = 0
			local var_238_7 = 0.4

			if var_238_6 < arg_235_1.time_ and arg_235_1.time_ <= var_238_6 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				local var_238_8 = arg_235_1:FormatText(StoryNameCfg[7].name)

				arg_235_1.leftNameTxt_.text = var_238_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, true)
				arg_235_1.iconController_:SetSelectedState("hero")

				arg_235_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_235_1.callingController_:SetSelectedState("normal")

				arg_235_1.keyicon_.color = Color.New(1, 1, 1)
				arg_235_1.icon_.color = Color.New(1, 1, 1)

				local var_238_9 = arg_235_1:GetWordFromCfg(1109402057)
				local var_238_10 = arg_235_1:FormatText(var_238_9.content)

				arg_235_1.text_.text = var_238_10

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_11 = 16
				local var_238_12 = utf8.len(var_238_10)
				local var_238_13 = var_238_11 <= 0 and var_238_7 or var_238_7 * (var_238_12 / var_238_11)

				if var_238_13 > 0 and var_238_7 < var_238_13 then
					arg_235_1.talkMaxDuration = var_238_13

					if var_238_13 + var_238_6 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_13 + var_238_6
					end
				end

				arg_235_1.text_.text = var_238_10
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)
				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_14 = math.max(var_238_7, arg_235_1.talkMaxDuration)

			if var_238_6 <= arg_235_1.time_ and arg_235_1.time_ < var_238_6 + var_238_14 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_6) / var_238_14

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_6 + var_238_14 and arg_235_1.time_ < var_238_6 + var_238_14 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play1109402058 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 1109402058
		arg_239_1.duration_ = 5

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play1109402059(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = 0

			if var_242_0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_0 + arg_242_0 then
				arg_239_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_242_1 = 0

			if var_242_1 < arg_239_1.time_ and arg_239_1.time_ <= var_242_1 + arg_242_0 then
				arg_239_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action3_1")
			end

			local var_242_2 = 0
			local var_242_3 = 0.55

			if var_242_2 < arg_239_1.time_ and arg_239_1.time_ <= var_242_2 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, false)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_4 = arg_239_1:GetWordFromCfg(1109402058)
				local var_242_5 = arg_239_1:FormatText(var_242_4.content)

				arg_239_1.text_.text = var_242_5

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_6 = 22
				local var_242_7 = utf8.len(var_242_5)
				local var_242_8 = var_242_6 <= 0 and var_242_3 or var_242_3 * (var_242_7 / var_242_6)

				if var_242_8 > 0 and var_242_3 < var_242_8 then
					arg_239_1.talkMaxDuration = var_242_8

					if var_242_8 + var_242_2 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_8 + var_242_2
					end
				end

				arg_239_1.text_.text = var_242_5
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)
				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_9 = math.max(var_242_3, arg_239_1.talkMaxDuration)

			if var_242_2 <= arg_239_1.time_ and arg_239_1.time_ < var_242_2 + var_242_9 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_2) / var_242_9

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_2 + var_242_9 and arg_239_1.time_ < var_242_2 + var_242_9 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play1109402059 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 1109402059
		arg_243_1.duration_ = 9

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play1109402060(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = arg_243_1.actors_["1094ui_story"].transform
			local var_246_1 = 0

			if var_246_1 < arg_243_1.time_ and arg_243_1.time_ <= var_246_1 + arg_246_0 then
				arg_243_1.var_.moveOldPos1094ui_story = var_246_0.localPosition
			end

			local var_246_2 = 0.001

			if var_246_1 <= arg_243_1.time_ and arg_243_1.time_ < var_246_1 + var_246_2 then
				local var_246_3 = (arg_243_1.time_ - var_246_1) / var_246_2
				local var_246_4 = Vector3.New(0, 100, 0)

				var_246_0.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos1094ui_story, var_246_4, var_246_3)

				local var_246_5 = manager.ui.mainCamera.transform.position - var_246_0.position

				var_246_0.forward = Vector3.New(var_246_5.x, var_246_5.y, var_246_5.z)

				local var_246_6 = var_246_0.localEulerAngles

				var_246_6.z = 0
				var_246_6.x = 0
				var_246_0.localEulerAngles = var_246_6
			end

			if arg_243_1.time_ >= var_246_1 + var_246_2 and arg_243_1.time_ < var_246_1 + var_246_2 + arg_246_0 then
				var_246_0.localPosition = Vector3.New(0, 100, 0)

				local var_246_7 = manager.ui.mainCamera.transform.position - var_246_0.position

				var_246_0.forward = Vector3.New(var_246_7.x, var_246_7.y, var_246_7.z)

				local var_246_8 = var_246_0.localEulerAngles

				var_246_8.z = 0
				var_246_8.x = 0
				var_246_0.localEulerAngles = var_246_8
			end

			local var_246_9 = arg_243_1.actors_["1094ui_story"]
			local var_246_10 = 0

			if var_246_10 < arg_243_1.time_ and arg_243_1.time_ <= var_246_10 + arg_246_0 and not isNil(var_246_9) and arg_243_1.var_.characterEffect1094ui_story == nil then
				arg_243_1.var_.characterEffect1094ui_story = var_246_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_11 = 0.200000002980232

			if var_246_10 <= arg_243_1.time_ and arg_243_1.time_ < var_246_10 + var_246_11 and not isNil(var_246_9) then
				local var_246_12 = (arg_243_1.time_ - var_246_10) / var_246_11

				if arg_243_1.var_.characterEffect1094ui_story and not isNil(var_246_9) then
					local var_246_13 = Mathf.Lerp(0, 0.5, var_246_12)

					arg_243_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_243_1.var_.characterEffect1094ui_story.fillRatio = var_246_13
				end
			end

			if arg_243_1.time_ >= var_246_10 + var_246_11 and arg_243_1.time_ < var_246_10 + var_246_11 + arg_246_0 and not isNil(var_246_9) and arg_243_1.var_.characterEffect1094ui_story then
				local var_246_14 = 0.5

				arg_243_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_243_1.var_.characterEffect1094ui_story.fillRatio = var_246_14
			end

			local var_246_15 = 4.33333333333333
			local var_246_16 = 1

			if var_246_15 < arg_243_1.time_ and arg_243_1.time_ <= var_246_15 + arg_246_0 then
				local var_246_17 = "play"
				local var_246_18 = "effect"

				arg_243_1:AudioAction(var_246_17, var_246_18, "se_story", "se_story_communication", "")
			end

			local var_246_19 = "D06_1"

			if arg_243_1.bgs_[var_246_19] == nil then
				local var_246_20 = Object.Instantiate(arg_243_1.paintGo_)

				var_246_20:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_246_19)
				var_246_20.name = var_246_19
				var_246_20.transform.parent = arg_243_1.stage_.transform
				var_246_20.transform.localPosition = Vector3.New(0, 100, 0)
				arg_243_1.bgs_[var_246_19] = var_246_20
			end

			local var_246_21 = 2

			if var_246_21 < arg_243_1.time_ and arg_243_1.time_ <= var_246_21 + arg_246_0 then
				local var_246_22 = manager.ui.mainCamera.transform.localPosition
				local var_246_23 = Vector3.New(0, 0, 10) + Vector3.New(var_246_22.x, var_246_22.y, 0)
				local var_246_24 = arg_243_1.bgs_.D06_1

				var_246_24.transform.localPosition = var_246_23
				var_246_24.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_246_25 = var_246_24:GetComponent("SpriteRenderer")

				if var_246_25 and var_246_25.sprite then
					local var_246_26 = (var_246_24.transform.localPosition - var_246_22).z
					local var_246_27 = manager.ui.mainCameraCom_
					local var_246_28 = 2 * var_246_26 * Mathf.Tan(var_246_27.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_246_29 = var_246_28 * var_246_27.aspect
					local var_246_30 = var_246_25.sprite.bounds.size.x
					local var_246_31 = var_246_25.sprite.bounds.size.y
					local var_246_32 = var_246_29 / var_246_30
					local var_246_33 = var_246_28 / var_246_31
					local var_246_34 = var_246_33 < var_246_32 and var_246_32 or var_246_33

					var_246_24.transform.localScale = Vector3.New(var_246_34, var_246_34, 0)
				end

				for iter_246_0, iter_246_1 in pairs(arg_243_1.bgs_) do
					if iter_246_0 ~= "D06_1" then
						iter_246_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_246_35 = 0

			if var_246_35 < arg_243_1.time_ and arg_243_1.time_ <= var_246_35 + arg_246_0 then
				arg_243_1.mask_.enabled = true
				arg_243_1.mask_.raycastTarget = true

				arg_243_1:SetGaussion(false)
			end

			local var_246_36 = 2

			if var_246_35 <= arg_243_1.time_ and arg_243_1.time_ < var_246_35 + var_246_36 then
				local var_246_37 = (arg_243_1.time_ - var_246_35) / var_246_36
				local var_246_38 = Color.New(0, 0, 0)

				var_246_38.a = Mathf.Lerp(0, 1, var_246_37)
				arg_243_1.mask_.color = var_246_38
			end

			if arg_243_1.time_ >= var_246_35 + var_246_36 and arg_243_1.time_ < var_246_35 + var_246_36 + arg_246_0 then
				local var_246_39 = Color.New(0, 0, 0)

				var_246_39.a = 1
				arg_243_1.mask_.color = var_246_39
			end

			local var_246_40 = 2

			if var_246_40 < arg_243_1.time_ and arg_243_1.time_ <= var_246_40 + arg_246_0 then
				arg_243_1.mask_.enabled = true
				arg_243_1.mask_.raycastTarget = true

				arg_243_1:SetGaussion(false)
			end

			local var_246_41 = 2

			if var_246_40 <= arg_243_1.time_ and arg_243_1.time_ < var_246_40 + var_246_41 then
				local var_246_42 = (arg_243_1.time_ - var_246_40) / var_246_41
				local var_246_43 = Color.New(0, 0, 0)

				var_246_43.a = Mathf.Lerp(1, 0, var_246_42)
				arg_243_1.mask_.color = var_246_43
			end

			if arg_243_1.time_ >= var_246_40 + var_246_41 and arg_243_1.time_ < var_246_40 + var_246_41 + arg_246_0 then
				local var_246_44 = Color.New(0, 0, 0)
				local var_246_45 = 0

				arg_243_1.mask_.enabled = false
				var_246_44.a = var_246_45
				arg_243_1.mask_.color = var_246_44
			end

			if arg_243_1.frameCnt_ <= 1 then
				arg_243_1.dialog_:SetActive(false)
			end

			local var_246_46 = 4
			local var_246_47 = 0.975

			if var_246_46 < arg_243_1.time_ and arg_243_1.time_ <= var_246_46 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0

				arg_243_1.dialog_:SetActive(true)

				arg_243_1.dialogCg_.alpha = 0

				local var_246_48 = LeanTween.value(arg_243_1.dialog_, 0, 1, 0.3)

				var_246_48:setOnUpdate(LuaHelper.FloatAction(function(arg_247_0)
					arg_243_1.dialogCg_.alpha = arg_247_0
				end))
				var_246_48:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_243_1.dialog_)
					var_246_48:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_243_1.duration_ = arg_243_1.duration_ + 0.3

				SetActive(arg_243_1.leftNameGo_, false)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_49 = arg_243_1:GetWordFromCfg(1109402059)
				local var_246_50 = arg_243_1:FormatText(var_246_49.content)

				arg_243_1.text_.text = var_246_50

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_51 = 37
				local var_246_52 = utf8.len(var_246_50)
				local var_246_53 = var_246_51 <= 0 and var_246_47 or var_246_47 * (var_246_52 / var_246_51)

				if var_246_53 > 0 and var_246_47 < var_246_53 then
					arg_243_1.talkMaxDuration = var_246_53
					var_246_46 = var_246_46 + 0.3

					if var_246_53 + var_246_46 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_53 + var_246_46
					end
				end

				arg_243_1.text_.text = var_246_50
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)
				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_54 = var_246_46 + 0.3
			local var_246_55 = math.max(var_246_47, arg_243_1.talkMaxDuration)

			if var_246_54 <= arg_243_1.time_ and arg_243_1.time_ < var_246_54 + var_246_55 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_54) / var_246_55

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_54 + var_246_55 and arg_243_1.time_ < var_246_54 + var_246_55 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_243_1:InitPlayNodeList()
	end,
	Play1109402060 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 1109402060
		arg_249_1.duration_ = 5

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play1109402061(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = 0
			local var_252_1 = 0.825

			if var_252_0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_0 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				local var_252_2 = arg_249_1:FormatText(StoryNameCfg[7].name)

				arg_249_1.leftNameTxt_.text = var_252_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, true)
				arg_249_1.iconController_:SetSelectedState("hero")

				arg_249_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_249_1.callingController_:SetSelectedState("normal")

				arg_249_1.keyicon_.color = Color.New(1, 1, 1)
				arg_249_1.icon_.color = Color.New(1, 1, 1)

				local var_252_3 = arg_249_1:GetWordFromCfg(1109402060)
				local var_252_4 = arg_249_1:FormatText(var_252_3.content)

				arg_249_1.text_.text = var_252_4

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_5 = 33
				local var_252_6 = utf8.len(var_252_4)
				local var_252_7 = var_252_5 <= 0 and var_252_1 or var_252_1 * (var_252_6 / var_252_5)

				if var_252_7 > 0 and var_252_1 < var_252_7 then
					arg_249_1.talkMaxDuration = var_252_7

					if var_252_7 + var_252_0 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_7 + var_252_0
					end
				end

				arg_249_1.text_.text = var_252_4
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)
				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_8 = math.max(var_252_1, arg_249_1.talkMaxDuration)

			if var_252_0 <= arg_249_1.time_ and arg_249_1.time_ < var_252_0 + var_252_8 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_0) / var_252_8

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_0 + var_252_8 and arg_249_1.time_ < var_252_0 + var_252_8 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play1109402061 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 1109402061
		arg_253_1.duration_ = 1.7

		local var_253_0 = {
			ja = 1.1,
			ko = 1.7,
			zh = 1.7
		}
		local var_253_1 = manager.audio:GetLocalizationFlag()

		if var_253_0[var_253_1] ~= nil then
			arg_253_1.duration_ = var_253_0[var_253_1]
		end

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play1109402062(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = 0
			local var_256_1 = 0.075

			if var_256_0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_0 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				local var_256_2 = arg_253_1:FormatText(StoryNameCfg[189].name)

				arg_253_1.leftNameTxt_.text = var_256_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, true)
				arg_253_1.iconController_:SetSelectedState("hero")

				arg_253_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vina")

				arg_253_1.callingController_:SetSelectedState("normal")

				arg_253_1.keyicon_.color = Color.New(1, 1, 1)
				arg_253_1.icon_.color = Color.New(1, 1, 1)

				local var_256_3 = arg_253_1:GetWordFromCfg(1109402061)
				local var_256_4 = arg_253_1:FormatText(var_256_3.content)

				arg_253_1.text_.text = var_256_4

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_5 = 3
				local var_256_6 = utf8.len(var_256_4)
				local var_256_7 = var_256_5 <= 0 and var_256_1 or var_256_1 * (var_256_6 / var_256_5)

				if var_256_7 > 0 and var_256_1 < var_256_7 then
					arg_253_1.talkMaxDuration = var_256_7

					if var_256_7 + var_256_0 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_7 + var_256_0
					end
				end

				arg_253_1.text_.text = var_256_4
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402061", "story_v_side_new_1109402.awb") ~= 0 then
					local var_256_8 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402061", "story_v_side_new_1109402.awb") / 1000

					if var_256_8 + var_256_0 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_8 + var_256_0
					end

					if var_256_3.prefab_name ~= "" and arg_253_1.actors_[var_256_3.prefab_name] ~= nil then
						local var_256_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_3.prefab_name].transform, "story_v_side_new_1109402", "1109402061", "story_v_side_new_1109402.awb")

						arg_253_1:RecordAudio("1109402061", var_256_9)
						arg_253_1:RecordAudio("1109402061", var_256_9)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402061", "story_v_side_new_1109402.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402061", "story_v_side_new_1109402.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_10 = math.max(var_256_1, arg_253_1.talkMaxDuration)

			if var_256_0 <= arg_253_1.time_ and arg_253_1.time_ < var_256_0 + var_256_10 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_0) / var_256_10

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_0 + var_256_10 and arg_253_1.time_ < var_256_0 + var_256_10 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play1109402062 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 1109402062
		arg_257_1.duration_ = 5

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play1109402063(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = 0
			local var_260_1 = 0.6

			if var_260_0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_0 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				local var_260_2 = arg_257_1:FormatText(StoryNameCfg[7].name)

				arg_257_1.leftNameTxt_.text = var_260_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, true)
				arg_257_1.iconController_:SetSelectedState("hero")

				arg_257_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_257_1.callingController_:SetSelectedState("normal")

				arg_257_1.keyicon_.color = Color.New(1, 1, 1)
				arg_257_1.icon_.color = Color.New(1, 1, 1)

				local var_260_3 = arg_257_1:GetWordFromCfg(1109402062)
				local var_260_4 = arg_257_1:FormatText(var_260_3.content)

				arg_257_1.text_.text = var_260_4

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_5 = 24
				local var_260_6 = utf8.len(var_260_4)
				local var_260_7 = var_260_5 <= 0 and var_260_1 or var_260_1 * (var_260_6 / var_260_5)

				if var_260_7 > 0 and var_260_1 < var_260_7 then
					arg_257_1.talkMaxDuration = var_260_7

					if var_260_7 + var_260_0 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_7 + var_260_0
					end
				end

				arg_257_1.text_.text = var_260_4
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)
				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_8 = math.max(var_260_1, arg_257_1.talkMaxDuration)

			if var_260_0 <= arg_257_1.time_ and arg_257_1.time_ < var_260_0 + var_260_8 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_0) / var_260_8

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_0 + var_260_8 and arg_257_1.time_ < var_260_0 + var_260_8 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play1109402063 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 1109402063
		arg_261_1.duration_ = 5

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play1109402064(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = 0
			local var_264_1 = 0.666666666666667

			if var_264_0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_0 + arg_264_0 then
				local var_264_2 = "play"
				local var_264_3 = "effect"

				arg_261_1:AudioAction(var_264_2, var_264_3, "se_story_side_1094", "se_story_1094_run", "")
			end

			local var_264_4 = 0
			local var_264_5 = 0.225

			if var_264_4 < arg_261_1.time_ and arg_261_1.time_ <= var_264_4 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, false)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_6 = arg_261_1:GetWordFromCfg(1109402063)
				local var_264_7 = arg_261_1:FormatText(var_264_6.content)

				arg_261_1.text_.text = var_264_7

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_8 = 9
				local var_264_9 = utf8.len(var_264_7)
				local var_264_10 = var_264_8 <= 0 and var_264_5 or var_264_5 * (var_264_9 / var_264_8)

				if var_264_10 > 0 and var_264_5 < var_264_10 then
					arg_261_1.talkMaxDuration = var_264_10

					if var_264_10 + var_264_4 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_10 + var_264_4
					end
				end

				arg_261_1.text_.text = var_264_7
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)
				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_11 = math.max(var_264_5, arg_261_1.talkMaxDuration)

			if var_264_4 <= arg_261_1.time_ and arg_261_1.time_ < var_264_4 + var_264_11 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_4) / var_264_11

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_4 + var_264_11 and arg_261_1.time_ < var_264_4 + var_264_11 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play1109402064 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 1109402064
		arg_265_1.duration_ = 7.2

		local var_265_0 = {
			ja = 7.2,
			ko = 3.5,
			zh = 3.5
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
				arg_265_0:Play1109402065(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = arg_265_1.actors_["1094ui_story"].transform
			local var_268_1 = 0

			if var_268_1 < arg_265_1.time_ and arg_265_1.time_ <= var_268_1 + arg_268_0 then
				arg_265_1.var_.moveOldPos1094ui_story = var_268_0.localPosition
			end

			local var_268_2 = 0.001

			if var_268_1 <= arg_265_1.time_ and arg_265_1.time_ < var_268_1 + var_268_2 then
				local var_268_3 = (arg_265_1.time_ - var_268_1) / var_268_2
				local var_268_4 = Vector3.New(0, -0.84, -6.1)

				var_268_0.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos1094ui_story, var_268_4, var_268_3)

				local var_268_5 = manager.ui.mainCamera.transform.position - var_268_0.position

				var_268_0.forward = Vector3.New(var_268_5.x, var_268_5.y, var_268_5.z)

				local var_268_6 = var_268_0.localEulerAngles

				var_268_6.z = 0
				var_268_6.x = 0
				var_268_0.localEulerAngles = var_268_6
			end

			if arg_265_1.time_ >= var_268_1 + var_268_2 and arg_265_1.time_ < var_268_1 + var_268_2 + arg_268_0 then
				var_268_0.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_268_7 = manager.ui.mainCamera.transform.position - var_268_0.position

				var_268_0.forward = Vector3.New(var_268_7.x, var_268_7.y, var_268_7.z)

				local var_268_8 = var_268_0.localEulerAngles

				var_268_8.z = 0
				var_268_8.x = 0
				var_268_0.localEulerAngles = var_268_8
			end

			local var_268_9 = arg_265_1.actors_["1094ui_story"]
			local var_268_10 = 0

			if var_268_10 < arg_265_1.time_ and arg_265_1.time_ <= var_268_10 + arg_268_0 and not isNil(var_268_9) and arg_265_1.var_.characterEffect1094ui_story == nil then
				arg_265_1.var_.characterEffect1094ui_story = var_268_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_11 = 0.200000002980232

			if var_268_10 <= arg_265_1.time_ and arg_265_1.time_ < var_268_10 + var_268_11 and not isNil(var_268_9) then
				local var_268_12 = (arg_265_1.time_ - var_268_10) / var_268_11

				if arg_265_1.var_.characterEffect1094ui_story and not isNil(var_268_9) then
					arg_265_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_265_1.time_ >= var_268_10 + var_268_11 and arg_265_1.time_ < var_268_10 + var_268_11 + arg_268_0 and not isNil(var_268_9) and arg_265_1.var_.characterEffect1094ui_story then
				arg_265_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_268_13 = 0

			if var_268_13 < arg_265_1.time_ and arg_265_1.time_ <= var_268_13 + arg_268_0 then
				arg_265_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action1_1")
			end

			local var_268_14 = 0

			if var_268_14 < arg_265_1.time_ and arg_265_1.time_ <= var_268_14 + arg_268_0 then
				arg_265_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_268_15 = 0
			local var_268_16 = 0.4

			if var_268_15 < arg_265_1.time_ and arg_265_1.time_ <= var_268_15 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				local var_268_17 = arg_265_1:FormatText(StoryNameCfg[181].name)

				arg_265_1.leftNameTxt_.text = var_268_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_18 = arg_265_1:GetWordFromCfg(1109402064)
				local var_268_19 = arg_265_1:FormatText(var_268_18.content)

				arg_265_1.text_.text = var_268_19

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_20 = 16
				local var_268_21 = utf8.len(var_268_19)
				local var_268_22 = var_268_20 <= 0 and var_268_16 or var_268_16 * (var_268_21 / var_268_20)

				if var_268_22 > 0 and var_268_16 < var_268_22 then
					arg_265_1.talkMaxDuration = var_268_22

					if var_268_22 + var_268_15 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_22 + var_268_15
					end
				end

				arg_265_1.text_.text = var_268_19
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402064", "story_v_side_new_1109402.awb") ~= 0 then
					local var_268_23 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402064", "story_v_side_new_1109402.awb") / 1000

					if var_268_23 + var_268_15 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_23 + var_268_15
					end

					if var_268_18.prefab_name ~= "" and arg_265_1.actors_[var_268_18.prefab_name] ~= nil then
						local var_268_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_18.prefab_name].transform, "story_v_side_new_1109402", "1109402064", "story_v_side_new_1109402.awb")

						arg_265_1:RecordAudio("1109402064", var_268_24)
						arg_265_1:RecordAudio("1109402064", var_268_24)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402064", "story_v_side_new_1109402.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402064", "story_v_side_new_1109402.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_25 = math.max(var_268_16, arg_265_1.talkMaxDuration)

			if var_268_15 <= arg_265_1.time_ and arg_265_1.time_ < var_268_15 + var_268_25 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_15) / var_268_25

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_15 + var_268_25 and arg_265_1.time_ < var_268_15 + var_268_25 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_265_1:InitPlayNodeList()
	end,
	Play1109402065 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 1109402065
		arg_269_1.duration_ = 0.2

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"

			SetActive(arg_269_1.choicesGo_, true)

			for iter_270_0, iter_270_1 in ipairs(arg_269_1.choices_) do
				local var_270_0 = iter_270_0 <= 1

				SetActive(iter_270_1.go, var_270_0)
			end

			arg_269_1.choices_[1].txt.text = arg_269_1:FormatText(StoryChoiceCfg[405].name)
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play1109402066(arg_269_1)
			end

			arg_269_1:RecordChoiceLog(1109402065, 405)
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = arg_269_1.actors_["1094ui_story"]
			local var_272_1 = 0

			if var_272_1 < arg_269_1.time_ and arg_269_1.time_ <= var_272_1 + arg_272_0 and not isNil(var_272_0) and arg_269_1.var_.characterEffect1094ui_story == nil then
				arg_269_1.var_.characterEffect1094ui_story = var_272_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_2 = 0.200000002980232

			if var_272_1 <= arg_269_1.time_ and arg_269_1.time_ < var_272_1 + var_272_2 and not isNil(var_272_0) then
				local var_272_3 = (arg_269_1.time_ - var_272_1) / var_272_2

				if arg_269_1.var_.characterEffect1094ui_story and not isNil(var_272_0) then
					local var_272_4 = Mathf.Lerp(0, 0.5, var_272_3)

					arg_269_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_269_1.var_.characterEffect1094ui_story.fillRatio = var_272_4
				end
			end

			if arg_269_1.time_ >= var_272_1 + var_272_2 and arg_269_1.time_ < var_272_1 + var_272_2 + arg_272_0 and not isNil(var_272_0) and arg_269_1.var_.characterEffect1094ui_story then
				local var_272_5 = 0.5

				arg_269_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_269_1.var_.characterEffect1094ui_story.fillRatio = var_272_5
			end

			local var_272_6 = 0

			if var_272_6 < arg_269_1.time_ and arg_269_1.time_ <= var_272_6 + arg_272_0 then
				arg_269_1.allBtn_.enabled = false
			end

			local var_272_7 = 0.200000002980232

			if arg_269_1.time_ >= var_272_6 + var_272_7 and arg_269_1.time_ < var_272_6 + var_272_7 + arg_272_0 then
				arg_269_1.allBtn_.enabled = true
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play1109402066 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 1109402066
		arg_273_1.duration_ = 5

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play1109402067(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = arg_273_1.actors_["1094ui_story"].transform
			local var_276_1 = 0

			if var_276_1 < arg_273_1.time_ and arg_273_1.time_ <= var_276_1 + arg_276_0 then
				arg_273_1.var_.moveOldPos1094ui_story = var_276_0.localPosition
			end

			local var_276_2 = 0.001

			if var_276_1 <= arg_273_1.time_ and arg_273_1.time_ < var_276_1 + var_276_2 then
				local var_276_3 = (arg_273_1.time_ - var_276_1) / var_276_2
				local var_276_4 = Vector3.New(0, 100, 0)

				var_276_0.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos1094ui_story, var_276_4, var_276_3)

				local var_276_5 = manager.ui.mainCamera.transform.position - var_276_0.position

				var_276_0.forward = Vector3.New(var_276_5.x, var_276_5.y, var_276_5.z)

				local var_276_6 = var_276_0.localEulerAngles

				var_276_6.z = 0
				var_276_6.x = 0
				var_276_0.localEulerAngles = var_276_6
			end

			if arg_273_1.time_ >= var_276_1 + var_276_2 and arg_273_1.time_ < var_276_1 + var_276_2 + arg_276_0 then
				var_276_0.localPosition = Vector3.New(0, 100, 0)

				local var_276_7 = manager.ui.mainCamera.transform.position - var_276_0.position

				var_276_0.forward = Vector3.New(var_276_7.x, var_276_7.y, var_276_7.z)

				local var_276_8 = var_276_0.localEulerAngles

				var_276_8.z = 0
				var_276_8.x = 0
				var_276_0.localEulerAngles = var_276_8
			end

			local var_276_9 = arg_273_1.actors_["1094ui_story"]
			local var_276_10 = 0

			if var_276_10 < arg_273_1.time_ and arg_273_1.time_ <= var_276_10 + arg_276_0 and not isNil(var_276_9) and arg_273_1.var_.characterEffect1094ui_story == nil then
				arg_273_1.var_.characterEffect1094ui_story = var_276_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_11 = 0.200000002980232

			if var_276_10 <= arg_273_1.time_ and arg_273_1.time_ < var_276_10 + var_276_11 and not isNil(var_276_9) then
				local var_276_12 = (arg_273_1.time_ - var_276_10) / var_276_11

				if arg_273_1.var_.characterEffect1094ui_story and not isNil(var_276_9) then
					local var_276_13 = Mathf.Lerp(0, 0.5, var_276_12)

					arg_273_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_273_1.var_.characterEffect1094ui_story.fillRatio = var_276_13
				end
			end

			if arg_273_1.time_ >= var_276_10 + var_276_11 and arg_273_1.time_ < var_276_10 + var_276_11 + arg_276_0 and not isNil(var_276_9) and arg_273_1.var_.characterEffect1094ui_story then
				local var_276_14 = 0.5

				arg_273_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_273_1.var_.characterEffect1094ui_story.fillRatio = var_276_14
			end

			local var_276_15 = 0
			local var_276_16 = 1

			if var_276_15 < arg_273_1.time_ and arg_273_1.time_ <= var_276_15 + arg_276_0 then
				local var_276_17 = "play"
				local var_276_18 = "effect"

				arg_273_1:AudioAction(var_276_17, var_276_18, "se_story_side_1094", "se_story_1094_run", "")
			end

			local var_276_19 = 0
			local var_276_20 = 0.225

			if var_276_19 < arg_273_1.time_ and arg_273_1.time_ <= var_276_19 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, false)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_21 = arg_273_1:GetWordFromCfg(1109402066)
				local var_276_22 = arg_273_1:FormatText(var_276_21.content)

				arg_273_1.text_.text = var_276_22

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_23 = 9
				local var_276_24 = utf8.len(var_276_22)
				local var_276_25 = var_276_23 <= 0 and var_276_20 or var_276_20 * (var_276_24 / var_276_23)

				if var_276_25 > 0 and var_276_20 < var_276_25 then
					arg_273_1.talkMaxDuration = var_276_25

					if var_276_25 + var_276_19 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_25 + var_276_19
					end
				end

				arg_273_1.text_.text = var_276_22
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)
				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_26 = math.max(var_276_20, arg_273_1.talkMaxDuration)

			if var_276_19 <= arg_273_1.time_ and arg_273_1.time_ < var_276_19 + var_276_26 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_19) / var_276_26

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_19 + var_276_26 and arg_273_1.time_ < var_276_19 + var_276_26 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_273_1:InitPlayNodeList()
	end,
	Play1109402067 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 1109402067
		arg_277_1.duration_ = 5

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play1109402068(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = 0
			local var_280_1 = 0.375

			if var_280_0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_0 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				local var_280_2 = arg_277_1:FormatText(StoryNameCfg[7].name)

				arg_277_1.leftNameTxt_.text = var_280_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, true)
				arg_277_1.iconController_:SetSelectedState("hero")

				arg_277_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_277_1.callingController_:SetSelectedState("normal")

				arg_277_1.keyicon_.color = Color.New(1, 1, 1)
				arg_277_1.icon_.color = Color.New(1, 1, 1)

				local var_280_3 = arg_277_1:GetWordFromCfg(1109402067)
				local var_280_4 = arg_277_1:FormatText(var_280_3.content)

				arg_277_1.text_.text = var_280_4

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_5 = 15
				local var_280_6 = utf8.len(var_280_4)
				local var_280_7 = var_280_5 <= 0 and var_280_1 or var_280_1 * (var_280_6 / var_280_5)

				if var_280_7 > 0 and var_280_1 < var_280_7 then
					arg_277_1.talkMaxDuration = var_280_7

					if var_280_7 + var_280_0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_7 + var_280_0
					end
				end

				arg_277_1.text_.text = var_280_4
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)
				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_8 = math.max(var_280_1, arg_277_1.talkMaxDuration)

			if var_280_0 <= arg_277_1.time_ and arg_277_1.time_ < var_280_0 + var_280_8 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_0) / var_280_8

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_0 + var_280_8 and arg_277_1.time_ < var_280_0 + var_280_8 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play1109402068 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 1109402068
		arg_281_1.duration_ = 5

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play1109402069(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = 0
			local var_284_1 = 1

			if var_284_0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_0 + arg_284_0 then
				local var_284_2 = "play"
				local var_284_3 = "effect"

				arg_281_1:AudioAction(var_284_2, var_284_3, "se_story_side_1094", "se_story_1094_run", "")
			end

			local var_284_4 = 0
			local var_284_5 = 0.325

			if var_284_4 < arg_281_1.time_ and arg_281_1.time_ <= var_284_4 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, false)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_6 = arg_281_1:GetWordFromCfg(1109402068)
				local var_284_7 = arg_281_1:FormatText(var_284_6.content)

				arg_281_1.text_.text = var_284_7

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_8 = 13
				local var_284_9 = utf8.len(var_284_7)
				local var_284_10 = var_284_8 <= 0 and var_284_5 or var_284_5 * (var_284_9 / var_284_8)

				if var_284_10 > 0 and var_284_5 < var_284_10 then
					arg_281_1.talkMaxDuration = var_284_10

					if var_284_10 + var_284_4 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_10 + var_284_4
					end
				end

				arg_281_1.text_.text = var_284_7
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)
				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_11 = math.max(var_284_5, arg_281_1.talkMaxDuration)

			if var_284_4 <= arg_281_1.time_ and arg_281_1.time_ < var_284_4 + var_284_11 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_4) / var_284_11

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_4 + var_284_11 and arg_281_1.time_ < var_284_4 + var_284_11 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play1109402069 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 1109402069
		arg_285_1.duration_ = 4.6

		local var_285_0 = {
			ja = 4.6,
			ko = 3.066,
			zh = 3.066
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
				arg_285_0:Play1109402070(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = arg_285_1.actors_["1094ui_story"].transform
			local var_288_1 = 0

			if var_288_1 < arg_285_1.time_ and arg_285_1.time_ <= var_288_1 + arg_288_0 then
				arg_285_1.var_.moveOldPos1094ui_story = var_288_0.localPosition
			end

			local var_288_2 = 0.001

			if var_288_1 <= arg_285_1.time_ and arg_285_1.time_ < var_288_1 + var_288_2 then
				local var_288_3 = (arg_285_1.time_ - var_288_1) / var_288_2
				local var_288_4 = Vector3.New(0, -0.84, -6.1)

				var_288_0.localPosition = Vector3.Lerp(arg_285_1.var_.moveOldPos1094ui_story, var_288_4, var_288_3)

				local var_288_5 = manager.ui.mainCamera.transform.position - var_288_0.position

				var_288_0.forward = Vector3.New(var_288_5.x, var_288_5.y, var_288_5.z)

				local var_288_6 = var_288_0.localEulerAngles

				var_288_6.z = 0
				var_288_6.x = 0
				var_288_0.localEulerAngles = var_288_6
			end

			if arg_285_1.time_ >= var_288_1 + var_288_2 and arg_285_1.time_ < var_288_1 + var_288_2 + arg_288_0 then
				var_288_0.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_288_7 = manager.ui.mainCamera.transform.position - var_288_0.position

				var_288_0.forward = Vector3.New(var_288_7.x, var_288_7.y, var_288_7.z)

				local var_288_8 = var_288_0.localEulerAngles

				var_288_8.z = 0
				var_288_8.x = 0
				var_288_0.localEulerAngles = var_288_8
			end

			local var_288_9 = arg_285_1.actors_["1094ui_story"]
			local var_288_10 = 0

			if var_288_10 < arg_285_1.time_ and arg_285_1.time_ <= var_288_10 + arg_288_0 and not isNil(var_288_9) and arg_285_1.var_.characterEffect1094ui_story == nil then
				arg_285_1.var_.characterEffect1094ui_story = var_288_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_11 = 0.200000002980232

			if var_288_10 <= arg_285_1.time_ and arg_285_1.time_ < var_288_10 + var_288_11 and not isNil(var_288_9) then
				local var_288_12 = (arg_285_1.time_ - var_288_10) / var_288_11

				if arg_285_1.var_.characterEffect1094ui_story and not isNil(var_288_9) then
					arg_285_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_285_1.time_ >= var_288_10 + var_288_11 and arg_285_1.time_ < var_288_10 + var_288_11 + arg_288_0 and not isNil(var_288_9) and arg_285_1.var_.characterEffect1094ui_story then
				arg_285_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_288_13 = 0

			if var_288_13 < arg_285_1.time_ and arg_285_1.time_ <= var_288_13 + arg_288_0 then
				arg_285_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action1_1")
			end

			local var_288_14 = 0

			if var_288_14 < arg_285_1.time_ and arg_285_1.time_ <= var_288_14 + arg_288_0 then
				arg_285_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_288_15 = 0
			local var_288_16 = 0.35

			if var_288_15 < arg_285_1.time_ and arg_285_1.time_ <= var_288_15 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				local var_288_17 = arg_285_1:FormatText(StoryNameCfg[181].name)

				arg_285_1.leftNameTxt_.text = var_288_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_18 = arg_285_1:GetWordFromCfg(1109402069)
				local var_288_19 = arg_285_1:FormatText(var_288_18.content)

				arg_285_1.text_.text = var_288_19

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_20 = 14
				local var_288_21 = utf8.len(var_288_19)
				local var_288_22 = var_288_20 <= 0 and var_288_16 or var_288_16 * (var_288_21 / var_288_20)

				if var_288_22 > 0 and var_288_16 < var_288_22 then
					arg_285_1.talkMaxDuration = var_288_22

					if var_288_22 + var_288_15 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_22 + var_288_15
					end
				end

				arg_285_1.text_.text = var_288_19
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402069", "story_v_side_new_1109402.awb") ~= 0 then
					local var_288_23 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402069", "story_v_side_new_1109402.awb") / 1000

					if var_288_23 + var_288_15 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_23 + var_288_15
					end

					if var_288_18.prefab_name ~= "" and arg_285_1.actors_[var_288_18.prefab_name] ~= nil then
						local var_288_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_18.prefab_name].transform, "story_v_side_new_1109402", "1109402069", "story_v_side_new_1109402.awb")

						arg_285_1:RecordAudio("1109402069", var_288_24)
						arg_285_1:RecordAudio("1109402069", var_288_24)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402069", "story_v_side_new_1109402.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402069", "story_v_side_new_1109402.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_25 = math.max(var_288_16, arg_285_1.talkMaxDuration)

			if var_288_15 <= arg_285_1.time_ and arg_285_1.time_ < var_288_15 + var_288_25 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_15) / var_288_25

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_15 + var_288_25 and arg_285_1.time_ < var_288_15 + var_288_25 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_285_1:InitPlayNodeList()
	end,
	Play1109402070 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 1109402070
		arg_289_1.duration_ = 0.2

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"

			SetActive(arg_289_1.choicesGo_, true)

			for iter_290_0, iter_290_1 in ipairs(arg_289_1.choices_) do
				local var_290_0 = iter_290_0 <= 1

				SetActive(iter_290_1.go, var_290_0)
			end

			arg_289_1.choices_[1].txt.text = arg_289_1:FormatText(StoryChoiceCfg[406].name)
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play1109402071(arg_289_1)
			end

			arg_289_1:RecordChoiceLog(1109402070, 406)
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = arg_289_1.actors_["1094ui_story"]
			local var_292_1 = 0

			if var_292_1 < arg_289_1.time_ and arg_289_1.time_ <= var_292_1 + arg_292_0 and not isNil(var_292_0) and arg_289_1.var_.characterEffect1094ui_story == nil then
				arg_289_1.var_.characterEffect1094ui_story = var_292_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_2 = 0.200000002980232

			if var_292_1 <= arg_289_1.time_ and arg_289_1.time_ < var_292_1 + var_292_2 and not isNil(var_292_0) then
				local var_292_3 = (arg_289_1.time_ - var_292_1) / var_292_2

				if arg_289_1.var_.characterEffect1094ui_story and not isNil(var_292_0) then
					local var_292_4 = Mathf.Lerp(0, 0.5, var_292_3)

					arg_289_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_289_1.var_.characterEffect1094ui_story.fillRatio = var_292_4
				end
			end

			if arg_289_1.time_ >= var_292_1 + var_292_2 and arg_289_1.time_ < var_292_1 + var_292_2 + arg_292_0 and not isNil(var_292_0) and arg_289_1.var_.characterEffect1094ui_story then
				local var_292_5 = 0.5

				arg_289_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_289_1.var_.characterEffect1094ui_story.fillRatio = var_292_5
			end

			local var_292_6 = 0

			if var_292_6 < arg_289_1.time_ and arg_289_1.time_ <= var_292_6 + arg_292_0 then
				arg_289_1.allBtn_.enabled = false
			end

			local var_292_7 = 0.200000002980232

			if arg_289_1.time_ >= var_292_6 + var_292_7 and arg_289_1.time_ < var_292_6 + var_292_7 + arg_292_0 then
				arg_289_1.allBtn_.enabled = true
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play1109402071 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 1109402071
		arg_293_1.duration_ = 5

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play1109402072(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = arg_293_1.actors_["1094ui_story"].transform
			local var_296_1 = 0

			if var_296_1 < arg_293_1.time_ and arg_293_1.time_ <= var_296_1 + arg_296_0 then
				arg_293_1.var_.moveOldPos1094ui_story = var_296_0.localPosition
			end

			local var_296_2 = 0.001

			if var_296_1 <= arg_293_1.time_ and arg_293_1.time_ < var_296_1 + var_296_2 then
				local var_296_3 = (arg_293_1.time_ - var_296_1) / var_296_2
				local var_296_4 = Vector3.New(0, 100, 0)

				var_296_0.localPosition = Vector3.Lerp(arg_293_1.var_.moveOldPos1094ui_story, var_296_4, var_296_3)

				local var_296_5 = manager.ui.mainCamera.transform.position - var_296_0.position

				var_296_0.forward = Vector3.New(var_296_5.x, var_296_5.y, var_296_5.z)

				local var_296_6 = var_296_0.localEulerAngles

				var_296_6.z = 0
				var_296_6.x = 0
				var_296_0.localEulerAngles = var_296_6
			end

			if arg_293_1.time_ >= var_296_1 + var_296_2 and arg_293_1.time_ < var_296_1 + var_296_2 + arg_296_0 then
				var_296_0.localPosition = Vector3.New(0, 100, 0)

				local var_296_7 = manager.ui.mainCamera.transform.position - var_296_0.position

				var_296_0.forward = Vector3.New(var_296_7.x, var_296_7.y, var_296_7.z)

				local var_296_8 = var_296_0.localEulerAngles

				var_296_8.z = 0
				var_296_8.x = 0
				var_296_0.localEulerAngles = var_296_8
			end

			local var_296_9 = arg_293_1.actors_["1094ui_story"]
			local var_296_10 = 0

			if var_296_10 < arg_293_1.time_ and arg_293_1.time_ <= var_296_10 + arg_296_0 and not isNil(var_296_9) and arg_293_1.var_.characterEffect1094ui_story == nil then
				arg_293_1.var_.characterEffect1094ui_story = var_296_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_11 = 0.200000002980232

			if var_296_10 <= arg_293_1.time_ and arg_293_1.time_ < var_296_10 + var_296_11 and not isNil(var_296_9) then
				local var_296_12 = (arg_293_1.time_ - var_296_10) / var_296_11

				if arg_293_1.var_.characterEffect1094ui_story and not isNil(var_296_9) then
					local var_296_13 = Mathf.Lerp(0, 0.5, var_296_12)

					arg_293_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_293_1.var_.characterEffect1094ui_story.fillRatio = var_296_13
				end
			end

			if arg_293_1.time_ >= var_296_10 + var_296_11 and arg_293_1.time_ < var_296_10 + var_296_11 + arg_296_0 and not isNil(var_296_9) and arg_293_1.var_.characterEffect1094ui_story then
				local var_296_14 = 0.5

				arg_293_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_293_1.var_.characterEffect1094ui_story.fillRatio = var_296_14
			end

			local var_296_15 = 0
			local var_296_16 = 1

			if var_296_15 < arg_293_1.time_ and arg_293_1.time_ <= var_296_15 + arg_296_0 then
				local var_296_17 = "play"
				local var_296_18 = "effect"

				arg_293_1:AudioAction(var_296_17, var_296_18, "se_story_side_1094", "se_story_1094_run", "")
			end

			local var_296_19 = 0
			local var_296_20 = 0.25

			if var_296_19 < arg_293_1.time_ and arg_293_1.time_ <= var_296_19 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, false)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_21 = arg_293_1:GetWordFromCfg(1109402071)
				local var_296_22 = arg_293_1:FormatText(var_296_21.content)

				arg_293_1.text_.text = var_296_22

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_23 = 10
				local var_296_24 = utf8.len(var_296_22)
				local var_296_25 = var_296_23 <= 0 and var_296_20 or var_296_20 * (var_296_24 / var_296_23)

				if var_296_25 > 0 and var_296_20 < var_296_25 then
					arg_293_1.talkMaxDuration = var_296_25

					if var_296_25 + var_296_19 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_25 + var_296_19
					end
				end

				arg_293_1.text_.text = var_296_22
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)
				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_26 = math.max(var_296_20, arg_293_1.talkMaxDuration)

			if var_296_19 <= arg_293_1.time_ and arg_293_1.time_ < var_296_19 + var_296_26 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_19) / var_296_26

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_19 + var_296_26 and arg_293_1.time_ < var_296_19 + var_296_26 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_293_1:InitPlayNodeList()
	end,
	Play1109402072 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 1109402072
		arg_297_1.duration_ = 5

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play1109402073(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = 0
			local var_300_1 = 0.5

			if var_300_0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_0 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				local var_300_2 = arg_297_1:FormatText(StoryNameCfg[7].name)

				arg_297_1.leftNameTxt_.text = var_300_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, true)
				arg_297_1.iconController_:SetSelectedState("hero")

				arg_297_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_297_1.callingController_:SetSelectedState("normal")

				arg_297_1.keyicon_.color = Color.New(1, 1, 1)
				arg_297_1.icon_.color = Color.New(1, 1, 1)

				local var_300_3 = arg_297_1:GetWordFromCfg(1109402072)
				local var_300_4 = arg_297_1:FormatText(var_300_3.content)

				arg_297_1.text_.text = var_300_4

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_5 = 20
				local var_300_6 = utf8.len(var_300_4)
				local var_300_7 = var_300_5 <= 0 and var_300_1 or var_300_1 * (var_300_6 / var_300_5)

				if var_300_7 > 0 and var_300_1 < var_300_7 then
					arg_297_1.talkMaxDuration = var_300_7

					if var_300_7 + var_300_0 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_7 + var_300_0
					end
				end

				arg_297_1.text_.text = var_300_4
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)
				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_8 = math.max(var_300_1, arg_297_1.talkMaxDuration)

			if var_300_0 <= arg_297_1.time_ and arg_297_1.time_ < var_300_0 + var_300_8 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_0) / var_300_8

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_0 + var_300_8 and arg_297_1.time_ < var_300_0 + var_300_8 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play1109402073 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 1109402073
		arg_301_1.duration_ = 4.23

		local var_301_0 = {
			ja = 4.233,
			ko = 3.2,
			zh = 3.2
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
				arg_301_0:Play1109402074(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = 0
			local var_304_1 = 0.225

			if var_304_0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_0 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				local var_304_2 = arg_301_1:FormatText(StoryNameCfg[189].name)

				arg_301_1.leftNameTxt_.text = var_304_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, true)
				arg_301_1.iconController_:SetSelectedState("hero")

				arg_301_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vina")

				arg_301_1.callingController_:SetSelectedState("normal")

				arg_301_1.keyicon_.color = Color.New(1, 1, 1)
				arg_301_1.icon_.color = Color.New(1, 1, 1)

				local var_304_3 = arg_301_1:GetWordFromCfg(1109402073)
				local var_304_4 = arg_301_1:FormatText(var_304_3.content)

				arg_301_1.text_.text = var_304_4

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_5 = 9
				local var_304_6 = utf8.len(var_304_4)
				local var_304_7 = var_304_5 <= 0 and var_304_1 or var_304_1 * (var_304_6 / var_304_5)

				if var_304_7 > 0 and var_304_1 < var_304_7 then
					arg_301_1.talkMaxDuration = var_304_7

					if var_304_7 + var_304_0 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_7 + var_304_0
					end
				end

				arg_301_1.text_.text = var_304_4
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402073", "story_v_side_new_1109402.awb") ~= 0 then
					local var_304_8 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402073", "story_v_side_new_1109402.awb") / 1000

					if var_304_8 + var_304_0 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_8 + var_304_0
					end

					if var_304_3.prefab_name ~= "" and arg_301_1.actors_[var_304_3.prefab_name] ~= nil then
						local var_304_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_3.prefab_name].transform, "story_v_side_new_1109402", "1109402073", "story_v_side_new_1109402.awb")

						arg_301_1:RecordAudio("1109402073", var_304_9)
						arg_301_1:RecordAudio("1109402073", var_304_9)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402073", "story_v_side_new_1109402.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402073", "story_v_side_new_1109402.awb")
				end

				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_10 = math.max(var_304_1, arg_301_1.talkMaxDuration)

			if var_304_0 <= arg_301_1.time_ and arg_301_1.time_ < var_304_0 + var_304_10 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_0) / var_304_10

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_0 + var_304_10 and arg_301_1.time_ < var_304_0 + var_304_10 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {}

		arg_301_1:InitPlayNodeList()
	end,
	Play1109402074 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 1109402074
		arg_305_1.duration_ = 5

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play1109402075(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = 0
			local var_308_1 = 0.65

			if var_308_0 < arg_305_1.time_ and arg_305_1.time_ <= var_308_0 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				local var_308_2 = arg_305_1:FormatText(StoryNameCfg[7].name)

				arg_305_1.leftNameTxt_.text = var_308_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, true)
				arg_305_1.iconController_:SetSelectedState("hero")

				arg_305_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_305_1.callingController_:SetSelectedState("normal")

				arg_305_1.keyicon_.color = Color.New(1, 1, 1)
				arg_305_1.icon_.color = Color.New(1, 1, 1)

				local var_308_3 = arg_305_1:GetWordFromCfg(1109402074)
				local var_308_4 = arg_305_1:FormatText(var_308_3.content)

				arg_305_1.text_.text = var_308_4

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_5 = 26
				local var_308_6 = utf8.len(var_308_4)
				local var_308_7 = var_308_5 <= 0 and var_308_1 or var_308_1 * (var_308_6 / var_308_5)

				if var_308_7 > 0 and var_308_1 < var_308_7 then
					arg_305_1.talkMaxDuration = var_308_7

					if var_308_7 + var_308_0 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_7 + var_308_0
					end
				end

				arg_305_1.text_.text = var_308_4
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)
				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_8 = math.max(var_308_1, arg_305_1.talkMaxDuration)

			if var_308_0 <= arg_305_1.time_ and arg_305_1.time_ < var_308_0 + var_308_8 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_0) / var_308_8

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_0 + var_308_8 and arg_305_1.time_ < var_308_0 + var_308_8 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play1109402075 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 1109402075
		arg_309_1.duration_ = 5

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play1109402076(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = 0
			local var_312_1 = 1.075

			if var_312_0 < arg_309_1.time_ and arg_309_1.time_ <= var_312_0 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, false)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_2 = arg_309_1:GetWordFromCfg(1109402075)
				local var_312_3 = arg_309_1:FormatText(var_312_2.content)

				arg_309_1.text_.text = var_312_3

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_4 = 43
				local var_312_5 = utf8.len(var_312_3)
				local var_312_6 = var_312_4 <= 0 and var_312_1 or var_312_1 * (var_312_5 / var_312_4)

				if var_312_6 > 0 and var_312_1 < var_312_6 then
					arg_309_1.talkMaxDuration = var_312_6

					if var_312_6 + var_312_0 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_6 + var_312_0
					end
				end

				arg_309_1.text_.text = var_312_3
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)
				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_7 = math.max(var_312_1, arg_309_1.talkMaxDuration)

			if var_312_0 <= arg_309_1.time_ and arg_309_1.time_ < var_312_0 + var_312_7 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_0) / var_312_7

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_0 + var_312_7 and arg_309_1.time_ < var_312_0 + var_312_7 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play1109402076 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 1109402076
		arg_313_1.duration_ = 5

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play1109402077(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			local var_316_0 = 0
			local var_316_1 = 0.85

			if var_316_0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_0 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, false)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_2 = arg_313_1:GetWordFromCfg(1109402076)
				local var_316_3 = arg_313_1:FormatText(var_316_2.content)

				arg_313_1.text_.text = var_316_3

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_4 = 34
				local var_316_5 = utf8.len(var_316_3)
				local var_316_6 = var_316_4 <= 0 and var_316_1 or var_316_1 * (var_316_5 / var_316_4)

				if var_316_6 > 0 and var_316_1 < var_316_6 then
					arg_313_1.talkMaxDuration = var_316_6

					if var_316_6 + var_316_0 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_6 + var_316_0
					end
				end

				arg_313_1.text_.text = var_316_3
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)
				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_7 = math.max(var_316_1, arg_313_1.talkMaxDuration)

			if var_316_0 <= arg_313_1.time_ and arg_313_1.time_ < var_316_0 + var_316_7 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_0) / var_316_7

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_0 + var_316_7 and arg_313_1.time_ < var_316_0 + var_316_7 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play1109402077 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 1109402077
		arg_317_1.duration_ = 5

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play1109402078(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = 0
			local var_320_1 = 0.8

			if var_320_0 < arg_317_1.time_ and arg_317_1.time_ <= var_320_0 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, false)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_2 = arg_317_1:GetWordFromCfg(1109402077)
				local var_320_3 = arg_317_1:FormatText(var_320_2.content)

				arg_317_1.text_.text = var_320_3

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_4 = 32
				local var_320_5 = utf8.len(var_320_3)
				local var_320_6 = var_320_4 <= 0 and var_320_1 or var_320_1 * (var_320_5 / var_320_4)

				if var_320_6 > 0 and var_320_1 < var_320_6 then
					arg_317_1.talkMaxDuration = var_320_6

					if var_320_6 + var_320_0 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_6 + var_320_0
					end
				end

				arg_317_1.text_.text = var_320_3
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)
				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_7 = math.max(var_320_1, arg_317_1.talkMaxDuration)

			if var_320_0 <= arg_317_1.time_ and arg_317_1.time_ < var_320_0 + var_320_7 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_0) / var_320_7

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_0 + var_320_7 and arg_317_1.time_ < var_320_0 + var_320_7 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {}

		arg_317_1:InitPlayNodeList()
	end,
	Play1109402078 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 1109402078
		arg_321_1.duration_ = 5

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play1109402079(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = 0
			local var_324_1 = 0.3

			if var_324_0 < arg_321_1.time_ and arg_321_1.time_ <= var_324_0 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				local var_324_2 = arg_321_1:FormatText(StoryNameCfg[7].name)

				arg_321_1.leftNameTxt_.text = var_324_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, true)
				arg_321_1.iconController_:SetSelectedState("hero")

				arg_321_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_321_1.callingController_:SetSelectedState("normal")

				arg_321_1.keyicon_.color = Color.New(1, 1, 1)
				arg_321_1.icon_.color = Color.New(1, 1, 1)

				local var_324_3 = arg_321_1:GetWordFromCfg(1109402078)
				local var_324_4 = arg_321_1:FormatText(var_324_3.content)

				arg_321_1.text_.text = var_324_4

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_5 = 12
				local var_324_6 = utf8.len(var_324_4)
				local var_324_7 = var_324_5 <= 0 and var_324_1 or var_324_1 * (var_324_6 / var_324_5)

				if var_324_7 > 0 and var_324_1 < var_324_7 then
					arg_321_1.talkMaxDuration = var_324_7

					if var_324_7 + var_324_0 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_7 + var_324_0
					end
				end

				arg_321_1.text_.text = var_324_4
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)
				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_8 = math.max(var_324_1, arg_321_1.talkMaxDuration)

			if var_324_0 <= arg_321_1.time_ and arg_321_1.time_ < var_324_0 + var_324_8 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_0) / var_324_8

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_0 + var_324_8 and arg_321_1.time_ < var_324_0 + var_324_8 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play1109402079 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 1109402079
		arg_325_1.duration_ = 1.73

		local var_325_0 = {
			ja = 1.566,
			ko = 1.733,
			zh = 1.733
		}
		local var_325_1 = manager.audio:GetLocalizationFlag()

		if var_325_0[var_325_1] ~= nil then
			arg_325_1.duration_ = var_325_0[var_325_1]
		end

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play1109402080(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			local var_328_0 = arg_325_1.actors_["1094ui_story"].transform
			local var_328_1 = 0

			if var_328_1 < arg_325_1.time_ and arg_325_1.time_ <= var_328_1 + arg_328_0 then
				arg_325_1.var_.moveOldPos1094ui_story = var_328_0.localPosition
			end

			local var_328_2 = 0.001

			if var_328_1 <= arg_325_1.time_ and arg_325_1.time_ < var_328_1 + var_328_2 then
				local var_328_3 = (arg_325_1.time_ - var_328_1) / var_328_2
				local var_328_4 = Vector3.New(0, -0.84, -6.1)

				var_328_0.localPosition = Vector3.Lerp(arg_325_1.var_.moveOldPos1094ui_story, var_328_4, var_328_3)

				local var_328_5 = manager.ui.mainCamera.transform.position - var_328_0.position

				var_328_0.forward = Vector3.New(var_328_5.x, var_328_5.y, var_328_5.z)

				local var_328_6 = var_328_0.localEulerAngles

				var_328_6.z = 0
				var_328_6.x = 0
				var_328_0.localEulerAngles = var_328_6
			end

			if arg_325_1.time_ >= var_328_1 + var_328_2 and arg_325_1.time_ < var_328_1 + var_328_2 + arg_328_0 then
				var_328_0.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_328_7 = manager.ui.mainCamera.transform.position - var_328_0.position

				var_328_0.forward = Vector3.New(var_328_7.x, var_328_7.y, var_328_7.z)

				local var_328_8 = var_328_0.localEulerAngles

				var_328_8.z = 0
				var_328_8.x = 0
				var_328_0.localEulerAngles = var_328_8
			end

			local var_328_9 = arg_325_1.actors_["1094ui_story"]
			local var_328_10 = 0

			if var_328_10 < arg_325_1.time_ and arg_325_1.time_ <= var_328_10 + arg_328_0 and not isNil(var_328_9) and arg_325_1.var_.characterEffect1094ui_story == nil then
				arg_325_1.var_.characterEffect1094ui_story = var_328_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_328_11 = 0.200000002980232

			if var_328_10 <= arg_325_1.time_ and arg_325_1.time_ < var_328_10 + var_328_11 and not isNil(var_328_9) then
				local var_328_12 = (arg_325_1.time_ - var_328_10) / var_328_11

				if arg_325_1.var_.characterEffect1094ui_story and not isNil(var_328_9) then
					arg_325_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_325_1.time_ >= var_328_10 + var_328_11 and arg_325_1.time_ < var_328_10 + var_328_11 + arg_328_0 and not isNil(var_328_9) and arg_325_1.var_.characterEffect1094ui_story then
				arg_325_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_328_13 = 0
			local var_328_14 = 0.125

			if var_328_13 < arg_325_1.time_ and arg_325_1.time_ <= var_328_13 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				local var_328_15 = arg_325_1:FormatText(StoryNameCfg[434].name)

				arg_325_1.leftNameTxt_.text = var_328_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_16 = arg_325_1:GetWordFromCfg(1109402079)
				local var_328_17 = arg_325_1:FormatText(var_328_16.content)

				arg_325_1.text_.text = var_328_17

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_18 = 5
				local var_328_19 = utf8.len(var_328_17)
				local var_328_20 = var_328_18 <= 0 and var_328_14 or var_328_14 * (var_328_19 / var_328_18)

				if var_328_20 > 0 and var_328_14 < var_328_20 then
					arg_325_1.talkMaxDuration = var_328_20

					if var_328_20 + var_328_13 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_20 + var_328_13
					end
				end

				arg_325_1.text_.text = var_328_17
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402079", "story_v_side_new_1109402.awb") ~= 0 then
					local var_328_21 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402079", "story_v_side_new_1109402.awb") / 1000

					if var_328_21 + var_328_13 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_21 + var_328_13
					end

					if var_328_16.prefab_name ~= "" and arg_325_1.actors_[var_328_16.prefab_name] ~= nil then
						local var_328_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_16.prefab_name].transform, "story_v_side_new_1109402", "1109402079", "story_v_side_new_1109402.awb")

						arg_325_1:RecordAudio("1109402079", var_328_22)
						arg_325_1:RecordAudio("1109402079", var_328_22)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402079", "story_v_side_new_1109402.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402079", "story_v_side_new_1109402.awb")
				end

				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_23 = math.max(var_328_14, arg_325_1.talkMaxDuration)

			if var_328_13 <= arg_325_1.time_ and arg_325_1.time_ < var_328_13 + var_328_23 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_13) / var_328_23

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_13 + var_328_23 and arg_325_1.time_ < var_328_13 + var_328_23 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_325_1:InitPlayNodeList()
	end,
	Play1109402080 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 1109402080
		arg_329_1.duration_ = 5.2

		local var_329_0 = {
			ja = 5.066,
			ko = 5.2,
			zh = 5.2
		}
		local var_329_1 = manager.audio:GetLocalizationFlag()

		if var_329_0[var_329_1] ~= nil then
			arg_329_1.duration_ = var_329_0[var_329_1]
		end

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play1109402081(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			local var_332_0 = arg_329_1.actors_["1094ui_story"].transform
			local var_332_1 = 0

			if var_332_1 < arg_329_1.time_ and arg_329_1.time_ <= var_332_1 + arg_332_0 then
				arg_329_1.var_.moveOldPos1094ui_story = var_332_0.localPosition
			end

			local var_332_2 = 0.001

			if var_332_1 <= arg_329_1.time_ and arg_329_1.time_ < var_332_1 + var_332_2 then
				local var_332_3 = (arg_329_1.time_ - var_332_1) / var_332_2
				local var_332_4 = Vector3.New(0, -0.84, -6.1)

				var_332_0.localPosition = Vector3.Lerp(arg_329_1.var_.moveOldPos1094ui_story, var_332_4, var_332_3)

				local var_332_5 = manager.ui.mainCamera.transform.position - var_332_0.position

				var_332_0.forward = Vector3.New(var_332_5.x, var_332_5.y, var_332_5.z)

				local var_332_6 = var_332_0.localEulerAngles

				var_332_6.z = 0
				var_332_6.x = 0
				var_332_0.localEulerAngles = var_332_6
			end

			if arg_329_1.time_ >= var_332_1 + var_332_2 and arg_329_1.time_ < var_332_1 + var_332_2 + arg_332_0 then
				var_332_0.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_332_7 = manager.ui.mainCamera.transform.position - var_332_0.position

				var_332_0.forward = Vector3.New(var_332_7.x, var_332_7.y, var_332_7.z)

				local var_332_8 = var_332_0.localEulerAngles

				var_332_8.z = 0
				var_332_8.x = 0
				var_332_0.localEulerAngles = var_332_8
			end

			local var_332_9 = 0

			if var_332_9 < arg_329_1.time_ and arg_329_1.time_ <= var_332_9 + arg_332_0 then
				arg_329_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action5_1")
			end

			local var_332_10 = 0

			if var_332_10 < arg_329_1.time_ and arg_329_1.time_ <= var_332_10 + arg_332_0 then
				arg_329_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_332_11 = 0
			local var_332_12 = 0.625

			if var_332_11 < arg_329_1.time_ and arg_329_1.time_ <= var_332_11 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				local var_332_13 = arg_329_1:FormatText(StoryNameCfg[181].name)

				arg_329_1.leftNameTxt_.text = var_332_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_14 = arg_329_1:GetWordFromCfg(1109402080)
				local var_332_15 = arg_329_1:FormatText(var_332_14.content)

				arg_329_1.text_.text = var_332_15

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_16 = 25
				local var_332_17 = utf8.len(var_332_15)
				local var_332_18 = var_332_16 <= 0 and var_332_12 or var_332_12 * (var_332_17 / var_332_16)

				if var_332_18 > 0 and var_332_12 < var_332_18 then
					arg_329_1.talkMaxDuration = var_332_18

					if var_332_18 + var_332_11 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_18 + var_332_11
					end
				end

				arg_329_1.text_.text = var_332_15
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402080", "story_v_side_new_1109402.awb") ~= 0 then
					local var_332_19 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402080", "story_v_side_new_1109402.awb") / 1000

					if var_332_19 + var_332_11 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_19 + var_332_11
					end

					if var_332_14.prefab_name ~= "" and arg_329_1.actors_[var_332_14.prefab_name] ~= nil then
						local var_332_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_329_1.actors_[var_332_14.prefab_name].transform, "story_v_side_new_1109402", "1109402080", "story_v_side_new_1109402.awb")

						arg_329_1:RecordAudio("1109402080", var_332_20)
						arg_329_1:RecordAudio("1109402080", var_332_20)
					else
						arg_329_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402080", "story_v_side_new_1109402.awb")
					end

					arg_329_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402080", "story_v_side_new_1109402.awb")
				end

				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_21 = math.max(var_332_12, arg_329_1.talkMaxDuration)

			if var_332_11 <= arg_329_1.time_ and arg_329_1.time_ < var_332_11 + var_332_21 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_11) / var_332_21

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_11 + var_332_21 and arg_329_1.time_ < var_332_11 + var_332_21 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_329_1:InitPlayNodeList()
	end,
	Play1109402081 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 1109402081
		arg_333_1.duration_ = 5

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play1109402082(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			local var_336_0 = arg_333_1.actors_["1094ui_story"]
			local var_336_1 = 0

			if var_336_1 < arg_333_1.time_ and arg_333_1.time_ <= var_336_1 + arg_336_0 and not isNil(var_336_0) and arg_333_1.var_.characterEffect1094ui_story == nil then
				arg_333_1.var_.characterEffect1094ui_story = var_336_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_336_2 = 0.200000002980232

			if var_336_1 <= arg_333_1.time_ and arg_333_1.time_ < var_336_1 + var_336_2 and not isNil(var_336_0) then
				local var_336_3 = (arg_333_1.time_ - var_336_1) / var_336_2

				if arg_333_1.var_.characterEffect1094ui_story and not isNil(var_336_0) then
					local var_336_4 = Mathf.Lerp(0, 0.5, var_336_3)

					arg_333_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_333_1.var_.characterEffect1094ui_story.fillRatio = var_336_4
				end
			end

			if arg_333_1.time_ >= var_336_1 + var_336_2 and arg_333_1.time_ < var_336_1 + var_336_2 + arg_336_0 and not isNil(var_336_0) and arg_333_1.var_.characterEffect1094ui_story then
				local var_336_5 = 0.5

				arg_333_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_333_1.var_.characterEffect1094ui_story.fillRatio = var_336_5
			end

			local var_336_6 = 0
			local var_336_7 = 0.8

			if var_336_6 < arg_333_1.time_ and arg_333_1.time_ <= var_336_6 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				local var_336_8 = arg_333_1:FormatText(StoryNameCfg[7].name)

				arg_333_1.leftNameTxt_.text = var_336_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, true)
				arg_333_1.iconController_:SetSelectedState("hero")

				arg_333_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_333_1.callingController_:SetSelectedState("normal")

				arg_333_1.keyicon_.color = Color.New(1, 1, 1)
				arg_333_1.icon_.color = Color.New(1, 1, 1)

				local var_336_9 = arg_333_1:GetWordFromCfg(1109402081)
				local var_336_10 = arg_333_1:FormatText(var_336_9.content)

				arg_333_1.text_.text = var_336_10

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_11 = 32
				local var_336_12 = utf8.len(var_336_10)
				local var_336_13 = var_336_11 <= 0 and var_336_7 or var_336_7 * (var_336_12 / var_336_11)

				if var_336_13 > 0 and var_336_7 < var_336_13 then
					arg_333_1.talkMaxDuration = var_336_13

					if var_336_13 + var_336_6 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_13 + var_336_6
					end
				end

				arg_333_1.text_.text = var_336_10
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)
				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_14 = math.max(var_336_7, arg_333_1.talkMaxDuration)

			if var_336_6 <= arg_333_1.time_ and arg_333_1.time_ < var_336_6 + var_336_14 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_6) / var_336_14

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_6 + var_336_14 and arg_333_1.time_ < var_336_6 + var_336_14 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {}

		arg_333_1:InitPlayNodeList()
	end,
	Play1109402082 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 1109402082
		arg_337_1.duration_ = 5

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play1109402083(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			local var_340_0 = 0
			local var_340_1 = 0.225

			if var_340_0 < arg_337_1.time_ and arg_337_1.time_ <= var_340_0 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				local var_340_2 = arg_337_1:FormatText(StoryNameCfg[7].name)

				arg_337_1.leftNameTxt_.text = var_340_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, true)
				arg_337_1.iconController_:SetSelectedState("hero")

				arg_337_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_337_1.callingController_:SetSelectedState("normal")

				arg_337_1.keyicon_.color = Color.New(1, 1, 1)
				arg_337_1.icon_.color = Color.New(1, 1, 1)

				local var_340_3 = arg_337_1:GetWordFromCfg(1109402082)
				local var_340_4 = arg_337_1:FormatText(var_340_3.content)

				arg_337_1.text_.text = var_340_4

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_5 = 9
				local var_340_6 = utf8.len(var_340_4)
				local var_340_7 = var_340_5 <= 0 and var_340_1 or var_340_1 * (var_340_6 / var_340_5)

				if var_340_7 > 0 and var_340_1 < var_340_7 then
					arg_337_1.talkMaxDuration = var_340_7

					if var_340_7 + var_340_0 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_7 + var_340_0
					end
				end

				arg_337_1.text_.text = var_340_4
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)
				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_8 = math.max(var_340_1, arg_337_1.talkMaxDuration)

			if var_340_0 <= arg_337_1.time_ and arg_337_1.time_ < var_340_0 + var_340_8 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_0) / var_340_8

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_0 + var_340_8 and arg_337_1.time_ < var_340_0 + var_340_8 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {}

		arg_337_1:InitPlayNodeList()
	end,
	Play1109402083 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 1109402083
		arg_341_1.duration_ = 2

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play1109402084(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			local var_344_0 = arg_341_1.actors_["1094ui_story"].transform
			local var_344_1 = 0

			if var_344_1 < arg_341_1.time_ and arg_341_1.time_ <= var_344_1 + arg_344_0 then
				arg_341_1.var_.moveOldPos1094ui_story = var_344_0.localPosition
			end

			local var_344_2 = 0.001

			if var_344_1 <= arg_341_1.time_ and arg_341_1.time_ < var_344_1 + var_344_2 then
				local var_344_3 = (arg_341_1.time_ - var_344_1) / var_344_2
				local var_344_4 = Vector3.New(0, -0.84, -6.1)

				var_344_0.localPosition = Vector3.Lerp(arg_341_1.var_.moveOldPos1094ui_story, var_344_4, var_344_3)

				local var_344_5 = manager.ui.mainCamera.transform.position - var_344_0.position

				var_344_0.forward = Vector3.New(var_344_5.x, var_344_5.y, var_344_5.z)

				local var_344_6 = var_344_0.localEulerAngles

				var_344_6.z = 0
				var_344_6.x = 0
				var_344_0.localEulerAngles = var_344_6
			end

			if arg_341_1.time_ >= var_344_1 + var_344_2 and arg_341_1.time_ < var_344_1 + var_344_2 + arg_344_0 then
				var_344_0.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_344_7 = manager.ui.mainCamera.transform.position - var_344_0.position

				var_344_0.forward = Vector3.New(var_344_7.x, var_344_7.y, var_344_7.z)

				local var_344_8 = var_344_0.localEulerAngles

				var_344_8.z = 0
				var_344_8.x = 0
				var_344_0.localEulerAngles = var_344_8
			end

			local var_344_9 = arg_341_1.actors_["1094ui_story"]
			local var_344_10 = 0

			if var_344_10 < arg_341_1.time_ and arg_341_1.time_ <= var_344_10 + arg_344_0 and not isNil(var_344_9) and arg_341_1.var_.characterEffect1094ui_story == nil then
				arg_341_1.var_.characterEffect1094ui_story = var_344_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_344_11 = 0.200000002980232

			if var_344_10 <= arg_341_1.time_ and arg_341_1.time_ < var_344_10 + var_344_11 and not isNil(var_344_9) then
				local var_344_12 = (arg_341_1.time_ - var_344_10) / var_344_11

				if arg_341_1.var_.characterEffect1094ui_story and not isNil(var_344_9) then
					arg_341_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_341_1.time_ >= var_344_10 + var_344_11 and arg_341_1.time_ < var_344_10 + var_344_11 + arg_344_0 and not isNil(var_344_9) and arg_341_1.var_.characterEffect1094ui_story then
				arg_341_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_344_13 = 0

			if var_344_13 < arg_341_1.time_ and arg_341_1.time_ <= var_344_13 + arg_344_0 then
				arg_341_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action5_2")
			end

			local var_344_14 = 0
			local var_344_15 = 0.1

			if var_344_14 < arg_341_1.time_ and arg_341_1.time_ <= var_344_14 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				local var_344_16 = arg_341_1:FormatText(StoryNameCfg[434].name)

				arg_341_1.leftNameTxt_.text = var_344_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_17 = arg_341_1:GetWordFromCfg(1109402083)
				local var_344_18 = arg_341_1:FormatText(var_344_17.content)

				arg_341_1.text_.text = var_344_18

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_19 = 4
				local var_344_20 = utf8.len(var_344_18)
				local var_344_21 = var_344_19 <= 0 and var_344_15 or var_344_15 * (var_344_20 / var_344_19)

				if var_344_21 > 0 and var_344_15 < var_344_21 then
					arg_341_1.talkMaxDuration = var_344_21

					if var_344_21 + var_344_14 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_21 + var_344_14
					end
				end

				arg_341_1.text_.text = var_344_18
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402083", "story_v_side_new_1109402.awb") ~= 0 then
					local var_344_22 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402083", "story_v_side_new_1109402.awb") / 1000

					if var_344_22 + var_344_14 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_22 + var_344_14
					end

					if var_344_17.prefab_name ~= "" and arg_341_1.actors_[var_344_17.prefab_name] ~= nil then
						local var_344_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_341_1.actors_[var_344_17.prefab_name].transform, "story_v_side_new_1109402", "1109402083", "story_v_side_new_1109402.awb")

						arg_341_1:RecordAudio("1109402083", var_344_23)
						arg_341_1:RecordAudio("1109402083", var_344_23)
					else
						arg_341_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402083", "story_v_side_new_1109402.awb")
					end

					arg_341_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402083", "story_v_side_new_1109402.awb")
				end

				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_24 = math.max(var_344_15, arg_341_1.talkMaxDuration)

			if var_344_14 <= arg_341_1.time_ and arg_341_1.time_ < var_344_14 + var_344_24 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_14) / var_344_24

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_14 + var_344_24 and arg_341_1.time_ < var_344_14 + var_344_24 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_341_1:InitPlayNodeList()
	end,
	Play1109402084 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 1109402084
		arg_345_1.duration_ = 5

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play1109402085(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			local var_348_0 = arg_345_1.actors_["1094ui_story"]
			local var_348_1 = 0

			if var_348_1 < arg_345_1.time_ and arg_345_1.time_ <= var_348_1 + arg_348_0 and not isNil(var_348_0) and arg_345_1.var_.characterEffect1094ui_story == nil then
				arg_345_1.var_.characterEffect1094ui_story = var_348_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_348_2 = 0.200000002980232

			if var_348_1 <= arg_345_1.time_ and arg_345_1.time_ < var_348_1 + var_348_2 and not isNil(var_348_0) then
				local var_348_3 = (arg_345_1.time_ - var_348_1) / var_348_2

				if arg_345_1.var_.characterEffect1094ui_story and not isNil(var_348_0) then
					local var_348_4 = Mathf.Lerp(0, 0.5, var_348_3)

					arg_345_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_345_1.var_.characterEffect1094ui_story.fillRatio = var_348_4
				end
			end

			if arg_345_1.time_ >= var_348_1 + var_348_2 and arg_345_1.time_ < var_348_1 + var_348_2 + arg_348_0 and not isNil(var_348_0) and arg_345_1.var_.characterEffect1094ui_story then
				local var_348_5 = 0.5

				arg_345_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_345_1.var_.characterEffect1094ui_story.fillRatio = var_348_5
			end

			local var_348_6 = 0
			local var_348_7 = 0.25

			if var_348_6 < arg_345_1.time_ and arg_345_1.time_ <= var_348_6 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, false)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_8 = arg_345_1:GetWordFromCfg(1109402084)
				local var_348_9 = arg_345_1:FormatText(var_348_8.content)

				arg_345_1.text_.text = var_348_9

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_10 = 10
				local var_348_11 = utf8.len(var_348_9)
				local var_348_12 = var_348_10 <= 0 and var_348_7 or var_348_7 * (var_348_11 / var_348_10)

				if var_348_12 > 0 and var_348_7 < var_348_12 then
					arg_345_1.talkMaxDuration = var_348_12

					if var_348_12 + var_348_6 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_12 + var_348_6
					end
				end

				arg_345_1.text_.text = var_348_9
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)
				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_13 = math.max(var_348_7, arg_345_1.talkMaxDuration)

			if var_348_6 <= arg_345_1.time_ and arg_345_1.time_ < var_348_6 + var_348_13 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_6) / var_348_13

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_6 + var_348_13 and arg_345_1.time_ < var_348_6 + var_348_13 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {}

		arg_345_1:InitPlayNodeList()
	end,
	Play1109402085 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 1109402085
		arg_349_1.duration_ = 5

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play1109402086(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			local var_352_0 = 0
			local var_352_1 = 0.575

			if var_352_0 < arg_349_1.time_ and arg_349_1.time_ <= var_352_0 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, true)

				local var_352_2 = arg_349_1:FormatText(StoryNameCfg[7].name)

				arg_349_1.leftNameTxt_.text = var_352_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_349_1.leftNameTxt_.transform)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1.leftNameTxt_.text)
				SetActive(arg_349_1.iconTrs_.gameObject, true)
				arg_349_1.iconController_:SetSelectedState("hero")

				arg_349_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_349_1.callingController_:SetSelectedState("normal")

				arg_349_1.keyicon_.color = Color.New(1, 1, 1)
				arg_349_1.icon_.color = Color.New(1, 1, 1)

				local var_352_3 = arg_349_1:GetWordFromCfg(1109402085)
				local var_352_4 = arg_349_1:FormatText(var_352_3.content)

				arg_349_1.text_.text = var_352_4

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_5 = 23
				local var_352_6 = utf8.len(var_352_4)
				local var_352_7 = var_352_5 <= 0 and var_352_1 or var_352_1 * (var_352_6 / var_352_5)

				if var_352_7 > 0 and var_352_1 < var_352_7 then
					arg_349_1.talkMaxDuration = var_352_7

					if var_352_7 + var_352_0 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_7 + var_352_0
					end
				end

				arg_349_1.text_.text = var_352_4
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)
				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_8 = math.max(var_352_1, arg_349_1.talkMaxDuration)

			if var_352_0 <= arg_349_1.time_ and arg_349_1.time_ < var_352_0 + var_352_8 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_0) / var_352_8

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_0 + var_352_8 and arg_349_1.time_ < var_352_0 + var_352_8 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {}

		arg_349_1:InitPlayNodeList()
	end,
	Play1109402086 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 1109402086
		arg_353_1.duration_ = 2

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play1109402087(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			local var_356_0 = arg_353_1.actors_["1094ui_story"].transform
			local var_356_1 = 0

			if var_356_1 < arg_353_1.time_ and arg_353_1.time_ <= var_356_1 + arg_356_0 then
				arg_353_1.var_.moveOldPos1094ui_story = var_356_0.localPosition
			end

			local var_356_2 = 0.001

			if var_356_1 <= arg_353_1.time_ and arg_353_1.time_ < var_356_1 + var_356_2 then
				local var_356_3 = (arg_353_1.time_ - var_356_1) / var_356_2
				local var_356_4 = Vector3.New(0, -0.84, -6.1)

				var_356_0.localPosition = Vector3.Lerp(arg_353_1.var_.moveOldPos1094ui_story, var_356_4, var_356_3)

				local var_356_5 = manager.ui.mainCamera.transform.position - var_356_0.position

				var_356_0.forward = Vector3.New(var_356_5.x, var_356_5.y, var_356_5.z)

				local var_356_6 = var_356_0.localEulerAngles

				var_356_6.z = 0
				var_356_6.x = 0
				var_356_0.localEulerAngles = var_356_6
			end

			if arg_353_1.time_ >= var_356_1 + var_356_2 and arg_353_1.time_ < var_356_1 + var_356_2 + arg_356_0 then
				var_356_0.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_356_7 = manager.ui.mainCamera.transform.position - var_356_0.position

				var_356_0.forward = Vector3.New(var_356_7.x, var_356_7.y, var_356_7.z)

				local var_356_8 = var_356_0.localEulerAngles

				var_356_8.z = 0
				var_356_8.x = 0
				var_356_0.localEulerAngles = var_356_8
			end

			local var_356_9 = arg_353_1.actors_["1094ui_story"]
			local var_356_10 = 0

			if var_356_10 < arg_353_1.time_ and arg_353_1.time_ <= var_356_10 + arg_356_0 and not isNil(var_356_9) and arg_353_1.var_.characterEffect1094ui_story == nil then
				arg_353_1.var_.characterEffect1094ui_story = var_356_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_356_11 = 0.200000002980232

			if var_356_10 <= arg_353_1.time_ and arg_353_1.time_ < var_356_10 + var_356_11 and not isNil(var_356_9) then
				local var_356_12 = (arg_353_1.time_ - var_356_10) / var_356_11

				if arg_353_1.var_.characterEffect1094ui_story and not isNil(var_356_9) then
					arg_353_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_353_1.time_ >= var_356_10 + var_356_11 and arg_353_1.time_ < var_356_10 + var_356_11 + arg_356_0 and not isNil(var_356_9) and arg_353_1.var_.characterEffect1094ui_story then
				arg_353_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_356_13 = 0

			if var_356_13 < arg_353_1.time_ and arg_353_1.time_ <= var_356_13 + arg_356_0 then
				arg_353_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_356_14 = 0

			if var_356_14 < arg_353_1.time_ and arg_353_1.time_ <= var_356_14 + arg_356_0 then
				arg_353_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action3_1")
			end

			local var_356_15 = 0
			local var_356_16 = 0.05

			if var_356_15 < arg_353_1.time_ and arg_353_1.time_ <= var_356_15 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, true)

				local var_356_17 = arg_353_1:FormatText(StoryNameCfg[434].name)

				arg_353_1.leftNameTxt_.text = var_356_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_353_1.leftNameTxt_.transform)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1.leftNameTxt_.text)
				SetActive(arg_353_1.iconTrs_.gameObject, false)
				arg_353_1.callingController_:SetSelectedState("normal")

				local var_356_18 = arg_353_1:GetWordFromCfg(1109402086)
				local var_356_19 = arg_353_1:FormatText(var_356_18.content)

				arg_353_1.text_.text = var_356_19

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_20 = 2
				local var_356_21 = utf8.len(var_356_19)
				local var_356_22 = var_356_20 <= 0 and var_356_16 or var_356_16 * (var_356_21 / var_356_20)

				if var_356_22 > 0 and var_356_16 < var_356_22 then
					arg_353_1.talkMaxDuration = var_356_22

					if var_356_22 + var_356_15 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_22 + var_356_15
					end
				end

				arg_353_1.text_.text = var_356_19
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402086", "story_v_side_new_1109402.awb") ~= 0 then
					local var_356_23 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402086", "story_v_side_new_1109402.awb") / 1000

					if var_356_23 + var_356_15 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_23 + var_356_15
					end

					if var_356_18.prefab_name ~= "" and arg_353_1.actors_[var_356_18.prefab_name] ~= nil then
						local var_356_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_353_1.actors_[var_356_18.prefab_name].transform, "story_v_side_new_1109402", "1109402086", "story_v_side_new_1109402.awb")

						arg_353_1:RecordAudio("1109402086", var_356_24)
						arg_353_1:RecordAudio("1109402086", var_356_24)
					else
						arg_353_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402086", "story_v_side_new_1109402.awb")
					end

					arg_353_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402086", "story_v_side_new_1109402.awb")
				end

				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_25 = math.max(var_356_16, arg_353_1.talkMaxDuration)

			if var_356_15 <= arg_353_1.time_ and arg_353_1.time_ < var_356_15 + var_356_25 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - var_356_15) / var_356_25

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= var_356_15 + var_356_25 and arg_353_1.time_ < var_356_15 + var_356_25 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_353_1:InitPlayNodeList()
	end,
	Play1109402087 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 1109402087
		arg_357_1.duration_ = 5

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play1109402088(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			local var_360_0 = arg_357_1.actors_["1094ui_story"]
			local var_360_1 = 0

			if var_360_1 < arg_357_1.time_ and arg_357_1.time_ <= var_360_1 + arg_360_0 and not isNil(var_360_0) and arg_357_1.var_.characterEffect1094ui_story == nil then
				arg_357_1.var_.characterEffect1094ui_story = var_360_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_360_2 = 0.200000002980232

			if var_360_1 <= arg_357_1.time_ and arg_357_1.time_ < var_360_1 + var_360_2 and not isNil(var_360_0) then
				local var_360_3 = (arg_357_1.time_ - var_360_1) / var_360_2

				if arg_357_1.var_.characterEffect1094ui_story and not isNil(var_360_0) then
					local var_360_4 = Mathf.Lerp(0, 0.5, var_360_3)

					arg_357_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_357_1.var_.characterEffect1094ui_story.fillRatio = var_360_4
				end
			end

			if arg_357_1.time_ >= var_360_1 + var_360_2 and arg_357_1.time_ < var_360_1 + var_360_2 + arg_360_0 and not isNil(var_360_0) and arg_357_1.var_.characterEffect1094ui_story then
				local var_360_5 = 0.5

				arg_357_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_357_1.var_.characterEffect1094ui_story.fillRatio = var_360_5
			end

			local var_360_6 = 0
			local var_360_7 = 0.275

			if var_360_6 < arg_357_1.time_ and arg_357_1.time_ <= var_360_6 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, false)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_8 = arg_357_1:GetWordFromCfg(1109402087)
				local var_360_9 = arg_357_1:FormatText(var_360_8.content)

				arg_357_1.text_.text = var_360_9

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_10 = 11
				local var_360_11 = utf8.len(var_360_9)
				local var_360_12 = var_360_10 <= 0 and var_360_7 or var_360_7 * (var_360_11 / var_360_10)

				if var_360_12 > 0 and var_360_7 < var_360_12 then
					arg_357_1.talkMaxDuration = var_360_12

					if var_360_12 + var_360_6 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_12 + var_360_6
					end
				end

				arg_357_1.text_.text = var_360_9
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)
				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_13 = math.max(var_360_7, arg_357_1.talkMaxDuration)

			if var_360_6 <= arg_357_1.time_ and arg_357_1.time_ < var_360_6 + var_360_13 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_6) / var_360_13

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_6 + var_360_13 and arg_357_1.time_ < var_360_6 + var_360_13 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {}

		arg_357_1:InitPlayNodeList()
	end,
	Play1109402088 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 1109402088
		arg_361_1.duration_ = 5

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play1109402089(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			local var_364_0 = 0
			local var_364_1 = 0.275

			if var_364_0 < arg_361_1.time_ and arg_361_1.time_ <= var_364_0 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, true)

				local var_364_2 = arg_361_1:FormatText(StoryNameCfg[7].name)

				arg_361_1.leftNameTxt_.text = var_364_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_361_1.leftNameTxt_.transform)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1.leftNameTxt_.text)
				SetActive(arg_361_1.iconTrs_.gameObject, true)
				arg_361_1.iconController_:SetSelectedState("hero")

				arg_361_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_361_1.callingController_:SetSelectedState("normal")

				arg_361_1.keyicon_.color = Color.New(1, 1, 1)
				arg_361_1.icon_.color = Color.New(1, 1, 1)

				local var_364_3 = arg_361_1:GetWordFromCfg(1109402088)
				local var_364_4 = arg_361_1:FormatText(var_364_3.content)

				arg_361_1.text_.text = var_364_4

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_5 = 11
				local var_364_6 = utf8.len(var_364_4)
				local var_364_7 = var_364_5 <= 0 and var_364_1 or var_364_1 * (var_364_6 / var_364_5)

				if var_364_7 > 0 and var_364_1 < var_364_7 then
					arg_361_1.talkMaxDuration = var_364_7

					if var_364_7 + var_364_0 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_7 + var_364_0
					end
				end

				arg_361_1.text_.text = var_364_4
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)
				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_8 = math.max(var_364_1, arg_361_1.talkMaxDuration)

			if var_364_0 <= arg_361_1.time_ and arg_361_1.time_ < var_364_0 + var_364_8 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - var_364_0) / var_364_8

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= var_364_0 + var_364_8 and arg_361_1.time_ < var_364_0 + var_364_8 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {}

		arg_361_1:InitPlayNodeList()
	end,
	Play1109402089 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 1109402089
		arg_365_1.duration_ = 2.6

		local var_365_0 = {
			ja = 2.6,
			ko = 1.999999999999,
			zh = 1.999999999999
		}
		local var_365_1 = manager.audio:GetLocalizationFlag()

		if var_365_0[var_365_1] ~= nil then
			arg_365_1.duration_ = var_365_0[var_365_1]
		end

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"
		end

		function arg_365_1.playNext_(arg_367_0)
			if arg_367_0 == 1 then
				arg_365_0:Play1109402090(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			local var_368_0 = arg_365_1.actors_["1094ui_story"].transform
			local var_368_1 = 0

			if var_368_1 < arg_365_1.time_ and arg_365_1.time_ <= var_368_1 + arg_368_0 then
				arg_365_1.var_.moveOldPos1094ui_story = var_368_0.localPosition
			end

			local var_368_2 = 0.001

			if var_368_1 <= arg_365_1.time_ and arg_365_1.time_ < var_368_1 + var_368_2 then
				local var_368_3 = (arg_365_1.time_ - var_368_1) / var_368_2
				local var_368_4 = Vector3.New(0, -0.84, -6.1)

				var_368_0.localPosition = Vector3.Lerp(arg_365_1.var_.moveOldPos1094ui_story, var_368_4, var_368_3)

				local var_368_5 = manager.ui.mainCamera.transform.position - var_368_0.position

				var_368_0.forward = Vector3.New(var_368_5.x, var_368_5.y, var_368_5.z)

				local var_368_6 = var_368_0.localEulerAngles

				var_368_6.z = 0
				var_368_6.x = 0
				var_368_0.localEulerAngles = var_368_6
			end

			if arg_365_1.time_ >= var_368_1 + var_368_2 and arg_365_1.time_ < var_368_1 + var_368_2 + arg_368_0 then
				var_368_0.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_368_7 = manager.ui.mainCamera.transform.position - var_368_0.position

				var_368_0.forward = Vector3.New(var_368_7.x, var_368_7.y, var_368_7.z)

				local var_368_8 = var_368_0.localEulerAngles

				var_368_8.z = 0
				var_368_8.x = 0
				var_368_0.localEulerAngles = var_368_8
			end

			local var_368_9 = arg_365_1.actors_["1094ui_story"]
			local var_368_10 = 0

			if var_368_10 < arg_365_1.time_ and arg_365_1.time_ <= var_368_10 + arg_368_0 and not isNil(var_368_9) and arg_365_1.var_.characterEffect1094ui_story == nil then
				arg_365_1.var_.characterEffect1094ui_story = var_368_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_368_11 = 0.200000002980232

			if var_368_10 <= arg_365_1.time_ and arg_365_1.time_ < var_368_10 + var_368_11 and not isNil(var_368_9) then
				local var_368_12 = (arg_365_1.time_ - var_368_10) / var_368_11

				if arg_365_1.var_.characterEffect1094ui_story and not isNil(var_368_9) then
					arg_365_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_365_1.time_ >= var_368_10 + var_368_11 and arg_365_1.time_ < var_368_10 + var_368_11 + arg_368_0 and not isNil(var_368_9) and arg_365_1.var_.characterEffect1094ui_story then
				arg_365_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_368_13 = 0

			if var_368_13 < arg_365_1.time_ and arg_365_1.time_ <= var_368_13 + arg_368_0 then
				arg_365_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_368_14 = 0
			local var_368_15 = 0.125

			if var_368_14 < arg_365_1.time_ and arg_365_1.time_ <= var_368_14 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, true)

				local var_368_16 = arg_365_1:FormatText(StoryNameCfg[181].name)

				arg_365_1.leftNameTxt_.text = var_368_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_365_1.leftNameTxt_.transform)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1.leftNameTxt_.text)
				SetActive(arg_365_1.iconTrs_.gameObject, false)
				arg_365_1.callingController_:SetSelectedState("normal")

				local var_368_17 = arg_365_1:GetWordFromCfg(1109402089)
				local var_368_18 = arg_365_1:FormatText(var_368_17.content)

				arg_365_1.text_.text = var_368_18

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_19 = 5
				local var_368_20 = utf8.len(var_368_18)
				local var_368_21 = var_368_19 <= 0 and var_368_15 or var_368_15 * (var_368_20 / var_368_19)

				if var_368_21 > 0 and var_368_15 < var_368_21 then
					arg_365_1.talkMaxDuration = var_368_21

					if var_368_21 + var_368_14 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_21 + var_368_14
					end
				end

				arg_365_1.text_.text = var_368_18
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402089", "story_v_side_new_1109402.awb") ~= 0 then
					local var_368_22 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402089", "story_v_side_new_1109402.awb") / 1000

					if var_368_22 + var_368_14 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_22 + var_368_14
					end

					if var_368_17.prefab_name ~= "" and arg_365_1.actors_[var_368_17.prefab_name] ~= nil then
						local var_368_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_365_1.actors_[var_368_17.prefab_name].transform, "story_v_side_new_1109402", "1109402089", "story_v_side_new_1109402.awb")

						arg_365_1:RecordAudio("1109402089", var_368_23)
						arg_365_1:RecordAudio("1109402089", var_368_23)
					else
						arg_365_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402089", "story_v_side_new_1109402.awb")
					end

					arg_365_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402089", "story_v_side_new_1109402.awb")
				end

				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_24 = math.max(var_368_15, arg_365_1.talkMaxDuration)

			if var_368_14 <= arg_365_1.time_ and arg_365_1.time_ < var_368_14 + var_368_24 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - var_368_14) / var_368_24

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= var_368_14 + var_368_24 and arg_365_1.time_ < var_368_14 + var_368_24 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_365_1:InitPlayNodeList()
	end,
	Play1109402090 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 1109402090
		arg_369_1.duration_ = 5

		SetActive(arg_369_1.tipsGo_, false)

		function arg_369_1.onSingleLineFinish_()
			arg_369_1.onSingleLineUpdate_ = nil
			arg_369_1.onSingleLineFinish_ = nil
			arg_369_1.state_ = "waiting"
		end

		function arg_369_1.playNext_(arg_371_0)
			if arg_371_0 == 1 then
				arg_369_0:Play1109402091(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			local var_372_0 = arg_369_1.actors_["1094ui_story"]
			local var_372_1 = 0

			if var_372_1 < arg_369_1.time_ and arg_369_1.time_ <= var_372_1 + arg_372_0 and not isNil(var_372_0) and arg_369_1.var_.characterEffect1094ui_story == nil then
				arg_369_1.var_.characterEffect1094ui_story = var_372_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_372_2 = 0.200000002980232

			if var_372_1 <= arg_369_1.time_ and arg_369_1.time_ < var_372_1 + var_372_2 and not isNil(var_372_0) then
				local var_372_3 = (arg_369_1.time_ - var_372_1) / var_372_2

				if arg_369_1.var_.characterEffect1094ui_story and not isNil(var_372_0) then
					local var_372_4 = Mathf.Lerp(0, 0.5, var_372_3)

					arg_369_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_369_1.var_.characterEffect1094ui_story.fillRatio = var_372_4
				end
			end

			if arg_369_1.time_ >= var_372_1 + var_372_2 and arg_369_1.time_ < var_372_1 + var_372_2 + arg_372_0 and not isNil(var_372_0) and arg_369_1.var_.characterEffect1094ui_story then
				local var_372_5 = 0.5

				arg_369_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_369_1.var_.characterEffect1094ui_story.fillRatio = var_372_5
			end

			local var_372_6 = 0
			local var_372_7 = 0.6

			if var_372_6 < arg_369_1.time_ and arg_369_1.time_ <= var_372_6 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, true)

				local var_372_8 = arg_369_1:FormatText(StoryNameCfg[7].name)

				arg_369_1.leftNameTxt_.text = var_372_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_369_1.leftNameTxt_.transform)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1.leftNameTxt_.text)
				SetActive(arg_369_1.iconTrs_.gameObject, true)
				arg_369_1.iconController_:SetSelectedState("hero")

				arg_369_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_369_1.callingController_:SetSelectedState("normal")

				arg_369_1.keyicon_.color = Color.New(1, 1, 1)
				arg_369_1.icon_.color = Color.New(1, 1, 1)

				local var_372_9 = arg_369_1:GetWordFromCfg(1109402090)
				local var_372_10 = arg_369_1:FormatText(var_372_9.content)

				arg_369_1.text_.text = var_372_10

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_11 = 24
				local var_372_12 = utf8.len(var_372_10)
				local var_372_13 = var_372_11 <= 0 and var_372_7 or var_372_7 * (var_372_12 / var_372_11)

				if var_372_13 > 0 and var_372_7 < var_372_13 then
					arg_369_1.talkMaxDuration = var_372_13

					if var_372_13 + var_372_6 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_13 + var_372_6
					end
				end

				arg_369_1.text_.text = var_372_10
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)
				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_14 = math.max(var_372_7, arg_369_1.talkMaxDuration)

			if var_372_6 <= arg_369_1.time_ and arg_369_1.time_ < var_372_6 + var_372_14 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - var_372_6) / var_372_14

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= var_372_6 + var_372_14 and arg_369_1.time_ < var_372_6 + var_372_14 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {}

		arg_369_1:InitPlayNodeList()
	end,
	Play1109402091 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 1109402091
		arg_373_1.duration_ = 1.57

		local var_373_0 = {
			ja = 1.266,
			ko = 1.566,
			zh = 1.566
		}
		local var_373_1 = manager.audio:GetLocalizationFlag()

		if var_373_0[var_373_1] ~= nil then
			arg_373_1.duration_ = var_373_0[var_373_1]
		end

		SetActive(arg_373_1.tipsGo_, false)

		function arg_373_1.onSingleLineFinish_()
			arg_373_1.onSingleLineUpdate_ = nil
			arg_373_1.onSingleLineFinish_ = nil
			arg_373_1.state_ = "waiting"
		end

		function arg_373_1.playNext_(arg_375_0)
			if arg_375_0 == 1 then
				arg_373_0:Play1109402092(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			local var_376_0 = 0
			local var_376_1 = 0.05

			if var_376_0 < arg_373_1.time_ and arg_373_1.time_ <= var_376_0 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, true)

				local var_376_2 = arg_373_1:FormatText(StoryNameCfg[189].name)

				arg_373_1.leftNameTxt_.text = var_376_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_373_1.leftNameTxt_.transform)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1.leftNameTxt_.text)
				SetActive(arg_373_1.iconTrs_.gameObject, true)
				arg_373_1.iconController_:SetSelectedState("hero")

				arg_373_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vina")

				arg_373_1.callingController_:SetSelectedState("normal")

				arg_373_1.keyicon_.color = Color.New(1, 1, 1)
				arg_373_1.icon_.color = Color.New(1, 1, 1)

				local var_376_3 = arg_373_1:GetWordFromCfg(1109402091)
				local var_376_4 = arg_373_1:FormatText(var_376_3.content)

				arg_373_1.text_.text = var_376_4

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_5 = 2
				local var_376_6 = utf8.len(var_376_4)
				local var_376_7 = var_376_5 <= 0 and var_376_1 or var_376_1 * (var_376_6 / var_376_5)

				if var_376_7 > 0 and var_376_1 < var_376_7 then
					arg_373_1.talkMaxDuration = var_376_7

					if var_376_7 + var_376_0 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_7 + var_376_0
					end
				end

				arg_373_1.text_.text = var_376_4
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402091", "story_v_side_new_1109402.awb") ~= 0 then
					local var_376_8 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402091", "story_v_side_new_1109402.awb") / 1000

					if var_376_8 + var_376_0 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_8 + var_376_0
					end

					if var_376_3.prefab_name ~= "" and arg_373_1.actors_[var_376_3.prefab_name] ~= nil then
						local var_376_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_373_1.actors_[var_376_3.prefab_name].transform, "story_v_side_new_1109402", "1109402091", "story_v_side_new_1109402.awb")

						arg_373_1:RecordAudio("1109402091", var_376_9)
						arg_373_1:RecordAudio("1109402091", var_376_9)
					else
						arg_373_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402091", "story_v_side_new_1109402.awb")
					end

					arg_373_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402091", "story_v_side_new_1109402.awb")
				end

				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_10 = math.max(var_376_1, arg_373_1.talkMaxDuration)

			if var_376_0 <= arg_373_1.time_ and arg_373_1.time_ < var_376_0 + var_376_10 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - var_376_0) / var_376_10

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= var_376_0 + var_376_10 and arg_373_1.time_ < var_376_0 + var_376_10 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {}

		arg_373_1:InitPlayNodeList()
	end,
	Play1109402092 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 1109402092
		arg_377_1.duration_ = 6

		SetActive(arg_377_1.tipsGo_, false)

		function arg_377_1.onSingleLineFinish_()
			arg_377_1.onSingleLineUpdate_ = nil
			arg_377_1.onSingleLineFinish_ = nil
			arg_377_1.state_ = "waiting"
		end

		function arg_377_1.playNext_(arg_379_0)
			if arg_379_0 == 1 then
				arg_377_0:Play1109402093(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			local var_380_0 = 2

			if var_380_0 < arg_377_1.time_ and arg_377_1.time_ <= var_380_0 + arg_380_0 then
				local var_380_1 = manager.ui.mainCamera.transform.localPosition
				local var_380_2 = Vector3.New(0, 0, 10) + Vector3.New(var_380_1.x, var_380_1.y, 0)
				local var_380_3 = arg_377_1.bgs_.I05d

				var_380_3.transform.localPosition = var_380_2
				var_380_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_380_4 = var_380_3:GetComponent("SpriteRenderer")

				if var_380_4 and var_380_4.sprite then
					local var_380_5 = (var_380_3.transform.localPosition - var_380_1).z
					local var_380_6 = manager.ui.mainCameraCom_
					local var_380_7 = 2 * var_380_5 * Mathf.Tan(var_380_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_380_8 = var_380_7 * var_380_6.aspect
					local var_380_9 = var_380_4.sprite.bounds.size.x
					local var_380_10 = var_380_4.sprite.bounds.size.y
					local var_380_11 = var_380_8 / var_380_9
					local var_380_12 = var_380_7 / var_380_10
					local var_380_13 = var_380_12 < var_380_11 and var_380_11 or var_380_12

					var_380_3.transform.localScale = Vector3.New(var_380_13, var_380_13, 0)
				end

				for iter_380_0, iter_380_1 in pairs(arg_377_1.bgs_) do
					if iter_380_0 ~= "I05d" then
						iter_380_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_380_14 = 0

			if var_380_14 < arg_377_1.time_ and arg_377_1.time_ <= var_380_14 + arg_380_0 then
				arg_377_1.mask_.enabled = true
				arg_377_1.mask_.raycastTarget = true

				arg_377_1:SetGaussion(false)
			end

			local var_380_15 = 2

			if var_380_14 <= arg_377_1.time_ and arg_377_1.time_ < var_380_14 + var_380_15 then
				local var_380_16 = (arg_377_1.time_ - var_380_14) / var_380_15
				local var_380_17 = Color.New(0, 0, 0)

				var_380_17.a = Mathf.Lerp(0, 1, var_380_16)
				arg_377_1.mask_.color = var_380_17
			end

			if arg_377_1.time_ >= var_380_14 + var_380_15 and arg_377_1.time_ < var_380_14 + var_380_15 + arg_380_0 then
				local var_380_18 = Color.New(0, 0, 0)

				var_380_18.a = 1
				arg_377_1.mask_.color = var_380_18
			end

			local var_380_19 = 2

			if var_380_19 < arg_377_1.time_ and arg_377_1.time_ <= var_380_19 + arg_380_0 then
				arg_377_1.mask_.enabled = true
				arg_377_1.mask_.raycastTarget = true

				arg_377_1:SetGaussion(false)
			end

			local var_380_20 = 2

			if var_380_19 <= arg_377_1.time_ and arg_377_1.time_ < var_380_19 + var_380_20 then
				local var_380_21 = (arg_377_1.time_ - var_380_19) / var_380_20
				local var_380_22 = Color.New(0, 0, 0)

				var_380_22.a = Mathf.Lerp(1, 0, var_380_21)
				arg_377_1.mask_.color = var_380_22
			end

			if arg_377_1.time_ >= var_380_19 + var_380_20 and arg_377_1.time_ < var_380_19 + var_380_20 + arg_380_0 then
				local var_380_23 = Color.New(0, 0, 0)
				local var_380_24 = 0

				arg_377_1.mask_.enabled = false
				var_380_23.a = var_380_24
				arg_377_1.mask_.color = var_380_23
			end

			local var_380_25 = arg_377_1.actors_["1094ui_story"].transform
			local var_380_26 = 4

			if var_380_26 < arg_377_1.time_ and arg_377_1.time_ <= var_380_26 + arg_380_0 then
				arg_377_1.var_.moveOldPos1094ui_story = var_380_25.localPosition
			end

			local var_380_27 = 0.001

			if var_380_26 <= arg_377_1.time_ and arg_377_1.time_ < var_380_26 + var_380_27 then
				local var_380_28 = (arg_377_1.time_ - var_380_26) / var_380_27
				local var_380_29 = Vector3.New(0, -0.84, -6.1)

				var_380_25.localPosition = Vector3.Lerp(arg_377_1.var_.moveOldPos1094ui_story, var_380_29, var_380_28)

				local var_380_30 = manager.ui.mainCamera.transform.position - var_380_25.position

				var_380_25.forward = Vector3.New(var_380_30.x, var_380_30.y, var_380_30.z)

				local var_380_31 = var_380_25.localEulerAngles

				var_380_31.z = 0
				var_380_31.x = 0
				var_380_25.localEulerAngles = var_380_31
			end

			if arg_377_1.time_ >= var_380_26 + var_380_27 and arg_377_1.time_ < var_380_26 + var_380_27 + arg_380_0 then
				var_380_25.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_380_32 = manager.ui.mainCamera.transform.position - var_380_25.position

				var_380_25.forward = Vector3.New(var_380_32.x, var_380_32.y, var_380_32.z)

				local var_380_33 = var_380_25.localEulerAngles

				var_380_33.z = 0
				var_380_33.x = 0
				var_380_25.localEulerAngles = var_380_33
			end

			local var_380_34 = arg_377_1.actors_["1094ui_story"]
			local var_380_35 = 4

			if var_380_35 < arg_377_1.time_ and arg_377_1.time_ <= var_380_35 + arg_380_0 and not isNil(var_380_34) and arg_377_1.var_.characterEffect1094ui_story == nil then
				arg_377_1.var_.characterEffect1094ui_story = var_380_34:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_380_36 = 0.200000002980232

			if var_380_35 <= arg_377_1.time_ and arg_377_1.time_ < var_380_35 + var_380_36 and not isNil(var_380_34) then
				local var_380_37 = (arg_377_1.time_ - var_380_35) / var_380_36

				if arg_377_1.var_.characterEffect1094ui_story and not isNil(var_380_34) then
					arg_377_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_377_1.time_ >= var_380_35 + var_380_36 and arg_377_1.time_ < var_380_35 + var_380_36 + arg_380_0 and not isNil(var_380_34) and arg_377_1.var_.characterEffect1094ui_story then
				arg_377_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_380_38 = 4

			if var_380_38 < arg_377_1.time_ and arg_377_1.time_ <= var_380_38 + arg_380_0 then
				arg_377_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action1_1")
			end

			local var_380_39 = 4

			if var_380_39 < arg_377_1.time_ and arg_377_1.time_ <= var_380_39 + arg_380_0 then
				arg_377_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_380_40 = arg_377_1.actors_["1094ui_story"].transform
			local var_380_41 = 0

			if var_380_41 < arg_377_1.time_ and arg_377_1.time_ <= var_380_41 + arg_380_0 then
				arg_377_1.var_.moveOldPos1094ui_story = var_380_40.localPosition
			end

			local var_380_42 = 0.001

			if var_380_41 <= arg_377_1.time_ and arg_377_1.time_ < var_380_41 + var_380_42 then
				local var_380_43 = (arg_377_1.time_ - var_380_41) / var_380_42
				local var_380_44 = Vector3.New(0, 100, 0)

				var_380_40.localPosition = Vector3.Lerp(arg_377_1.var_.moveOldPos1094ui_story, var_380_44, var_380_43)

				local var_380_45 = manager.ui.mainCamera.transform.position - var_380_40.position

				var_380_40.forward = Vector3.New(var_380_45.x, var_380_45.y, var_380_45.z)

				local var_380_46 = var_380_40.localEulerAngles

				var_380_46.z = 0
				var_380_46.x = 0
				var_380_40.localEulerAngles = var_380_46
			end

			if arg_377_1.time_ >= var_380_41 + var_380_42 and arg_377_1.time_ < var_380_41 + var_380_42 + arg_380_0 then
				var_380_40.localPosition = Vector3.New(0, 100, 0)

				local var_380_47 = manager.ui.mainCamera.transform.position - var_380_40.position

				var_380_40.forward = Vector3.New(var_380_47.x, var_380_47.y, var_380_47.z)

				local var_380_48 = var_380_40.localEulerAngles

				var_380_48.z = 0
				var_380_48.x = 0
				var_380_40.localEulerAngles = var_380_48
			end

			if arg_377_1.frameCnt_ <= 1 then
				arg_377_1.dialog_:SetActive(false)
			end

			local var_380_49 = 4
			local var_380_50 = 0.125

			if var_380_49 < arg_377_1.time_ and arg_377_1.time_ <= var_380_49 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0

				arg_377_1.dialog_:SetActive(true)

				arg_377_1.dialogCg_.alpha = 0

				local var_380_51 = LeanTween.value(arg_377_1.dialog_, 0, 1, 0.3)

				var_380_51:setOnUpdate(LuaHelper.FloatAction(function(arg_381_0)
					arg_377_1.dialogCg_.alpha = arg_381_0
				end))
				var_380_51:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_377_1.dialog_)
					var_380_51:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_377_1.duration_ = arg_377_1.duration_ + 0.3

				SetActive(arg_377_1.leftNameGo_, true)

				local var_380_52 = arg_377_1:FormatText(StoryNameCfg[181].name)

				arg_377_1.leftNameTxt_.text = var_380_52

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_377_1.leftNameTxt_.transform)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1.leftNameTxt_.text)
				SetActive(arg_377_1.iconTrs_.gameObject, false)
				arg_377_1.callingController_:SetSelectedState("normal")

				local var_380_53 = arg_377_1:GetWordFromCfg(1109402092)
				local var_380_54 = arg_377_1:FormatText(var_380_53.content)

				arg_377_1.text_.text = var_380_54

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_55 = 5
				local var_380_56 = utf8.len(var_380_54)
				local var_380_57 = var_380_55 <= 0 and var_380_50 or var_380_50 * (var_380_56 / var_380_55)

				if var_380_57 > 0 and var_380_50 < var_380_57 then
					arg_377_1.talkMaxDuration = var_380_57
					var_380_49 = var_380_49 + 0.3

					if var_380_57 + var_380_49 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_57 + var_380_49
					end
				end

				arg_377_1.text_.text = var_380_54
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402092", "story_v_side_new_1109402.awb") ~= 0 then
					local var_380_58 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402092", "story_v_side_new_1109402.awb") / 1000

					if var_380_58 + var_380_49 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_58 + var_380_49
					end

					if var_380_53.prefab_name ~= "" and arg_377_1.actors_[var_380_53.prefab_name] ~= nil then
						local var_380_59 = LuaForUtil.PlayVoiceWithCriLipsync(arg_377_1.actors_[var_380_53.prefab_name].transform, "story_v_side_new_1109402", "1109402092", "story_v_side_new_1109402.awb")

						arg_377_1:RecordAudio("1109402092", var_380_59)
						arg_377_1:RecordAudio("1109402092", var_380_59)
					else
						arg_377_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402092", "story_v_side_new_1109402.awb")
					end

					arg_377_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402092", "story_v_side_new_1109402.awb")
				end

				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_60 = var_380_49 + 0.3
			local var_380_61 = math.max(var_380_50, arg_377_1.talkMaxDuration)

			if var_380_60 <= arg_377_1.time_ and arg_377_1.time_ < var_380_60 + var_380_61 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - var_380_60) / var_380_61

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= var_380_60 + var_380_61 and arg_377_1.time_ < var_380_60 + var_380_61 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_377_1:InitPlayNodeList()
	end,
	Play1109402093 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 1109402093
		arg_383_1.duration_ = 5

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"
		end

		function arg_383_1.playNext_(arg_385_0)
			if arg_385_0 == 1 then
				arg_383_0:Play1109402094(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			local var_386_0 = arg_383_1.actors_["1094ui_story"]
			local var_386_1 = 0

			if var_386_1 < arg_383_1.time_ and arg_383_1.time_ <= var_386_1 + arg_386_0 and not isNil(var_386_0) and arg_383_1.var_.characterEffect1094ui_story == nil then
				arg_383_1.var_.characterEffect1094ui_story = var_386_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_386_2 = 0.200000002980232

			if var_386_1 <= arg_383_1.time_ and arg_383_1.time_ < var_386_1 + var_386_2 and not isNil(var_386_0) then
				local var_386_3 = (arg_383_1.time_ - var_386_1) / var_386_2

				if arg_383_1.var_.characterEffect1094ui_story and not isNil(var_386_0) then
					local var_386_4 = Mathf.Lerp(0, 0.5, var_386_3)

					arg_383_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_383_1.var_.characterEffect1094ui_story.fillRatio = var_386_4
				end
			end

			if arg_383_1.time_ >= var_386_1 + var_386_2 and arg_383_1.time_ < var_386_1 + var_386_2 + arg_386_0 and not isNil(var_386_0) and arg_383_1.var_.characterEffect1094ui_story then
				local var_386_5 = 0.5

				arg_383_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_383_1.var_.characterEffect1094ui_story.fillRatio = var_386_5
			end

			local var_386_6 = 0
			local var_386_7 = 0.65

			if var_386_6 < arg_383_1.time_ and arg_383_1.time_ <= var_386_6 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, true)

				local var_386_8 = arg_383_1:FormatText(StoryNameCfg[7].name)

				arg_383_1.leftNameTxt_.text = var_386_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_383_1.leftNameTxt_.transform)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1.leftNameTxt_.text)
				SetActive(arg_383_1.iconTrs_.gameObject, true)
				arg_383_1.iconController_:SetSelectedState("hero")

				arg_383_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_383_1.callingController_:SetSelectedState("normal")

				arg_383_1.keyicon_.color = Color.New(1, 1, 1)
				arg_383_1.icon_.color = Color.New(1, 1, 1)

				local var_386_9 = arg_383_1:GetWordFromCfg(1109402093)
				local var_386_10 = arg_383_1:FormatText(var_386_9.content)

				arg_383_1.text_.text = var_386_10

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_11 = 26
				local var_386_12 = utf8.len(var_386_10)
				local var_386_13 = var_386_11 <= 0 and var_386_7 or var_386_7 * (var_386_12 / var_386_11)

				if var_386_13 > 0 and var_386_7 < var_386_13 then
					arg_383_1.talkMaxDuration = var_386_13

					if var_386_13 + var_386_6 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_13 + var_386_6
					end
				end

				arg_383_1.text_.text = var_386_10
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)
				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_14 = math.max(var_386_7, arg_383_1.talkMaxDuration)

			if var_386_6 <= arg_383_1.time_ and arg_383_1.time_ < var_386_6 + var_386_14 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - var_386_6) / var_386_14

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= var_386_6 + var_386_14 and arg_383_1.time_ < var_386_6 + var_386_14 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {}

		arg_383_1:InitPlayNodeList()
	end,
	Play1109402094 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 1109402094
		arg_387_1.duration_ = 4.6

		local var_387_0 = {
			ja = 1.999999999999,
			ko = 4.6,
			zh = 4.6
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
				arg_387_0:Play1109402095(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			local var_390_0 = arg_387_1.actors_["1094ui_story"].transform
			local var_390_1 = 0

			if var_390_1 < arg_387_1.time_ and arg_387_1.time_ <= var_390_1 + arg_390_0 then
				arg_387_1.var_.moveOldPos1094ui_story = var_390_0.localPosition
			end

			local var_390_2 = 0.001

			if var_390_1 <= arg_387_1.time_ and arg_387_1.time_ < var_390_1 + var_390_2 then
				local var_390_3 = (arg_387_1.time_ - var_390_1) / var_390_2
				local var_390_4 = Vector3.New(0, -0.84, -6.1)

				var_390_0.localPosition = Vector3.Lerp(arg_387_1.var_.moveOldPos1094ui_story, var_390_4, var_390_3)

				local var_390_5 = manager.ui.mainCamera.transform.position - var_390_0.position

				var_390_0.forward = Vector3.New(var_390_5.x, var_390_5.y, var_390_5.z)

				local var_390_6 = var_390_0.localEulerAngles

				var_390_6.z = 0
				var_390_6.x = 0
				var_390_0.localEulerAngles = var_390_6
			end

			if arg_387_1.time_ >= var_390_1 + var_390_2 and arg_387_1.time_ < var_390_1 + var_390_2 + arg_390_0 then
				var_390_0.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_390_7 = manager.ui.mainCamera.transform.position - var_390_0.position

				var_390_0.forward = Vector3.New(var_390_7.x, var_390_7.y, var_390_7.z)

				local var_390_8 = var_390_0.localEulerAngles

				var_390_8.z = 0
				var_390_8.x = 0
				var_390_0.localEulerAngles = var_390_8
			end

			local var_390_9 = arg_387_1.actors_["1094ui_story"]
			local var_390_10 = 0

			if var_390_10 < arg_387_1.time_ and arg_387_1.time_ <= var_390_10 + arg_390_0 and not isNil(var_390_9) and arg_387_1.var_.characterEffect1094ui_story == nil then
				arg_387_1.var_.characterEffect1094ui_story = var_390_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_390_11 = 0.200000002980232

			if var_390_10 <= arg_387_1.time_ and arg_387_1.time_ < var_390_10 + var_390_11 and not isNil(var_390_9) then
				local var_390_12 = (arg_387_1.time_ - var_390_10) / var_390_11

				if arg_387_1.var_.characterEffect1094ui_story and not isNil(var_390_9) then
					arg_387_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_387_1.time_ >= var_390_10 + var_390_11 and arg_387_1.time_ < var_390_10 + var_390_11 + arg_390_0 and not isNil(var_390_9) and arg_387_1.var_.characterEffect1094ui_story then
				arg_387_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_390_13 = 0

			if var_390_13 < arg_387_1.time_ and arg_387_1.time_ <= var_390_13 + arg_390_0 then
				arg_387_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action4_1")
			end

			local var_390_14 = 0

			if var_390_14 < arg_387_1.time_ and arg_387_1.time_ <= var_390_14 + arg_390_0 then
				arg_387_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_390_15 = 0
			local var_390_16 = 0.225

			if var_390_15 < arg_387_1.time_ and arg_387_1.time_ <= var_390_15 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0
				arg_387_1.dialogCg_.alpha = 1

				arg_387_1.dialog_:SetActive(true)
				SetActive(arg_387_1.leftNameGo_, true)

				local var_390_17 = arg_387_1:FormatText(StoryNameCfg[181].name)

				arg_387_1.leftNameTxt_.text = var_390_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_387_1.leftNameTxt_.transform)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1.leftNameTxt_.text)
				SetActive(arg_387_1.iconTrs_.gameObject, false)
				arg_387_1.callingController_:SetSelectedState("normal")

				local var_390_18 = arg_387_1:GetWordFromCfg(1109402094)
				local var_390_19 = arg_387_1:FormatText(var_390_18.content)

				arg_387_1.text_.text = var_390_19

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_20 = 9
				local var_390_21 = utf8.len(var_390_19)
				local var_390_22 = var_390_20 <= 0 and var_390_16 or var_390_16 * (var_390_21 / var_390_20)

				if var_390_22 > 0 and var_390_16 < var_390_22 then
					arg_387_1.talkMaxDuration = var_390_22

					if var_390_22 + var_390_15 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_22 + var_390_15
					end
				end

				arg_387_1.text_.text = var_390_19
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402094", "story_v_side_new_1109402.awb") ~= 0 then
					local var_390_23 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402094", "story_v_side_new_1109402.awb") / 1000

					if var_390_23 + var_390_15 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_23 + var_390_15
					end

					if var_390_18.prefab_name ~= "" and arg_387_1.actors_[var_390_18.prefab_name] ~= nil then
						local var_390_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_387_1.actors_[var_390_18.prefab_name].transform, "story_v_side_new_1109402", "1109402094", "story_v_side_new_1109402.awb")

						arg_387_1:RecordAudio("1109402094", var_390_24)
						arg_387_1:RecordAudio("1109402094", var_390_24)
					else
						arg_387_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402094", "story_v_side_new_1109402.awb")
					end

					arg_387_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402094", "story_v_side_new_1109402.awb")
				end

				arg_387_1:RecordContent(arg_387_1.text_.text)
			end

			local var_390_25 = math.max(var_390_16, arg_387_1.talkMaxDuration)

			if var_390_15 <= arg_387_1.time_ and arg_387_1.time_ < var_390_15 + var_390_25 then
				arg_387_1.typewritter.percent = (arg_387_1.time_ - var_390_15) / var_390_25

				arg_387_1.typewritter:SetDirty()
			end

			if arg_387_1.time_ >= var_390_15 + var_390_25 and arg_387_1.time_ < var_390_15 + var_390_25 + arg_390_0 then
				arg_387_1.typewritter.percent = 1

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(true)
			end
		end

		arg_387_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_387_1:InitPlayNodeList()
	end,
	Play1109402095 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 1109402095
		arg_391_1.duration_ = 5

		SetActive(arg_391_1.tipsGo_, false)

		function arg_391_1.onSingleLineFinish_()
			arg_391_1.onSingleLineUpdate_ = nil
			arg_391_1.onSingleLineFinish_ = nil
			arg_391_1.state_ = "waiting"
		end

		function arg_391_1.playNext_(arg_393_0)
			if arg_393_0 == 1 then
				arg_391_0:Play1109402096(arg_391_1)
			end
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			local var_394_0 = arg_391_1.actors_["1094ui_story"]
			local var_394_1 = 0

			if var_394_1 < arg_391_1.time_ and arg_391_1.time_ <= var_394_1 + arg_394_0 and not isNil(var_394_0) and arg_391_1.var_.characterEffect1094ui_story == nil then
				arg_391_1.var_.characterEffect1094ui_story = var_394_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_394_2 = 0.200000002980232

			if var_394_1 <= arg_391_1.time_ and arg_391_1.time_ < var_394_1 + var_394_2 and not isNil(var_394_0) then
				local var_394_3 = (arg_391_1.time_ - var_394_1) / var_394_2

				if arg_391_1.var_.characterEffect1094ui_story and not isNil(var_394_0) then
					local var_394_4 = Mathf.Lerp(0, 0.5, var_394_3)

					arg_391_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_391_1.var_.characterEffect1094ui_story.fillRatio = var_394_4
				end
			end

			if arg_391_1.time_ >= var_394_1 + var_394_2 and arg_391_1.time_ < var_394_1 + var_394_2 + arg_394_0 and not isNil(var_394_0) and arg_391_1.var_.characterEffect1094ui_story then
				local var_394_5 = 0.5

				arg_391_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_391_1.var_.characterEffect1094ui_story.fillRatio = var_394_5
			end

			local var_394_6 = 0
			local var_394_7 = 0.55

			if var_394_6 < arg_391_1.time_ and arg_391_1.time_ <= var_394_6 + arg_394_0 then
				arg_391_1.talkMaxDuration = 0
				arg_391_1.dialogCg_.alpha = 1

				arg_391_1.dialog_:SetActive(true)
				SetActive(arg_391_1.leftNameGo_, true)

				local var_394_8 = arg_391_1:FormatText(StoryNameCfg[7].name)

				arg_391_1.leftNameTxt_.text = var_394_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_391_1.leftNameTxt_.transform)

				arg_391_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_391_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_391_1:RecordName(arg_391_1.leftNameTxt_.text)
				SetActive(arg_391_1.iconTrs_.gameObject, true)
				arg_391_1.iconController_:SetSelectedState("hero")

				arg_391_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_391_1.callingController_:SetSelectedState("normal")

				arg_391_1.keyicon_.color = Color.New(1, 1, 1)
				arg_391_1.icon_.color = Color.New(1, 1, 1)

				local var_394_9 = arg_391_1:GetWordFromCfg(1109402095)
				local var_394_10 = arg_391_1:FormatText(var_394_9.content)

				arg_391_1.text_.text = var_394_10

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_11 = 22
				local var_394_12 = utf8.len(var_394_10)
				local var_394_13 = var_394_11 <= 0 and var_394_7 or var_394_7 * (var_394_12 / var_394_11)

				if var_394_13 > 0 and var_394_7 < var_394_13 then
					arg_391_1.talkMaxDuration = var_394_13

					if var_394_13 + var_394_6 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_13 + var_394_6
					end
				end

				arg_391_1.text_.text = var_394_10
				arg_391_1.typewritter.percent = 0

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(false)
				arg_391_1:RecordContent(arg_391_1.text_.text)
			end

			local var_394_14 = math.max(var_394_7, arg_391_1.talkMaxDuration)

			if var_394_6 <= arg_391_1.time_ and arg_391_1.time_ < var_394_6 + var_394_14 then
				arg_391_1.typewritter.percent = (arg_391_1.time_ - var_394_6) / var_394_14

				arg_391_1.typewritter:SetDirty()
			end

			if arg_391_1.time_ >= var_394_6 + var_394_14 and arg_391_1.time_ < var_394_6 + var_394_14 + arg_394_0 then
				arg_391_1.typewritter.percent = 1

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(true)
			end
		end

		arg_391_1.nodeConfigList_ = {}

		arg_391_1:InitPlayNodeList()
	end,
	Play1109402096 = function(arg_395_0, arg_395_1)
		arg_395_1.time_ = 0
		arg_395_1.frameCnt_ = 0
		arg_395_1.state_ = "playing"
		arg_395_1.curTalkId_ = 1109402096
		arg_395_1.duration_ = 3.6

		local var_395_0 = {
			ja = 3.6,
			ko = 3,
			zh = 3
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
				arg_395_0:Play1109402097(arg_395_1)
			end
		end

		function arg_395_1.onSingleLineUpdate_(arg_398_0)
			local var_398_0 = 0
			local var_398_1 = 0.325

			if var_398_0 < arg_395_1.time_ and arg_395_1.time_ <= var_398_0 + arg_398_0 then
				arg_395_1.talkMaxDuration = 0
				arg_395_1.dialogCg_.alpha = 1

				arg_395_1.dialog_:SetActive(true)
				SetActive(arg_395_1.leftNameGo_, true)

				local var_398_2 = arg_395_1:FormatText(StoryNameCfg[189].name)

				arg_395_1.leftNameTxt_.text = var_398_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_395_1.leftNameTxt_.transform)

				arg_395_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_395_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_395_1:RecordName(arg_395_1.leftNameTxt_.text)
				SetActive(arg_395_1.iconTrs_.gameObject, true)
				arg_395_1.iconController_:SetSelectedState("hero")

				arg_395_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vina")

				arg_395_1.callingController_:SetSelectedState("normal")

				arg_395_1.keyicon_.color = Color.New(1, 1, 1)
				arg_395_1.icon_.color = Color.New(1, 1, 1)

				local var_398_3 = arg_395_1:GetWordFromCfg(1109402096)
				local var_398_4 = arg_395_1:FormatText(var_398_3.content)

				arg_395_1.text_.text = var_398_4

				LuaForUtil.ClearLinePrefixSymbol(arg_395_1.text_)

				local var_398_5 = 13
				local var_398_6 = utf8.len(var_398_4)
				local var_398_7 = var_398_5 <= 0 and var_398_1 or var_398_1 * (var_398_6 / var_398_5)

				if var_398_7 > 0 and var_398_1 < var_398_7 then
					arg_395_1.talkMaxDuration = var_398_7

					if var_398_7 + var_398_0 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_7 + var_398_0
					end
				end

				arg_395_1.text_.text = var_398_4
				arg_395_1.typewritter.percent = 0

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402096", "story_v_side_new_1109402.awb") ~= 0 then
					local var_398_8 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402096", "story_v_side_new_1109402.awb") / 1000

					if var_398_8 + var_398_0 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_8 + var_398_0
					end

					if var_398_3.prefab_name ~= "" and arg_395_1.actors_[var_398_3.prefab_name] ~= nil then
						local var_398_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_395_1.actors_[var_398_3.prefab_name].transform, "story_v_side_new_1109402", "1109402096", "story_v_side_new_1109402.awb")

						arg_395_1:RecordAudio("1109402096", var_398_9)
						arg_395_1:RecordAudio("1109402096", var_398_9)
					else
						arg_395_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402096", "story_v_side_new_1109402.awb")
					end

					arg_395_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402096", "story_v_side_new_1109402.awb")
				end

				arg_395_1:RecordContent(arg_395_1.text_.text)
			end

			local var_398_10 = math.max(var_398_1, arg_395_1.talkMaxDuration)

			if var_398_0 <= arg_395_1.time_ and arg_395_1.time_ < var_398_0 + var_398_10 then
				arg_395_1.typewritter.percent = (arg_395_1.time_ - var_398_0) / var_398_10

				arg_395_1.typewritter:SetDirty()
			end

			if arg_395_1.time_ >= var_398_0 + var_398_10 and arg_395_1.time_ < var_398_0 + var_398_10 + arg_398_0 then
				arg_395_1.typewritter.percent = 1

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(true)
			end
		end

		arg_395_1.nodeConfigList_ = {}

		arg_395_1:InitPlayNodeList()
	end,
	Play1109402097 = function(arg_399_0, arg_399_1)
		arg_399_1.time_ = 0
		arg_399_1.frameCnt_ = 0
		arg_399_1.state_ = "playing"
		arg_399_1.curTalkId_ = 1109402097
		arg_399_1.duration_ = 5

		SetActive(arg_399_1.tipsGo_, false)

		function arg_399_1.onSingleLineFinish_()
			arg_399_1.onSingleLineUpdate_ = nil
			arg_399_1.onSingleLineFinish_ = nil
			arg_399_1.state_ = "waiting"
		end

		function arg_399_1.playNext_(arg_401_0)
			if arg_401_0 == 1 then
				arg_399_0:Play1109402098(arg_399_1)
			end
		end

		function arg_399_1.onSingleLineUpdate_(arg_402_0)
			local var_402_0 = 0
			local var_402_1 = 0.575

			if var_402_0 < arg_399_1.time_ and arg_399_1.time_ <= var_402_0 + arg_402_0 then
				arg_399_1.talkMaxDuration = 0
				arg_399_1.dialogCg_.alpha = 1

				arg_399_1.dialog_:SetActive(true)
				SetActive(arg_399_1.leftNameGo_, true)

				local var_402_2 = arg_399_1:FormatText(StoryNameCfg[7].name)

				arg_399_1.leftNameTxt_.text = var_402_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_399_1.leftNameTxt_.transform)

				arg_399_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_399_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_399_1:RecordName(arg_399_1.leftNameTxt_.text)
				SetActive(arg_399_1.iconTrs_.gameObject, true)
				arg_399_1.iconController_:SetSelectedState("hero")

				arg_399_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_399_1.callingController_:SetSelectedState("normal")

				arg_399_1.keyicon_.color = Color.New(1, 1, 1)
				arg_399_1.icon_.color = Color.New(1, 1, 1)

				local var_402_3 = arg_399_1:GetWordFromCfg(1109402097)
				local var_402_4 = arg_399_1:FormatText(var_402_3.content)

				arg_399_1.text_.text = var_402_4

				LuaForUtil.ClearLinePrefixSymbol(arg_399_1.text_)

				local var_402_5 = 23
				local var_402_6 = utf8.len(var_402_4)
				local var_402_7 = var_402_5 <= 0 and var_402_1 or var_402_1 * (var_402_6 / var_402_5)

				if var_402_7 > 0 and var_402_1 < var_402_7 then
					arg_399_1.talkMaxDuration = var_402_7

					if var_402_7 + var_402_0 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_7 + var_402_0
					end
				end

				arg_399_1.text_.text = var_402_4
				arg_399_1.typewritter.percent = 0

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(false)
				arg_399_1:RecordContent(arg_399_1.text_.text)
			end

			local var_402_8 = math.max(var_402_1, arg_399_1.talkMaxDuration)

			if var_402_0 <= arg_399_1.time_ and arg_399_1.time_ < var_402_0 + var_402_8 then
				arg_399_1.typewritter.percent = (arg_399_1.time_ - var_402_0) / var_402_8

				arg_399_1.typewritter:SetDirty()
			end

			if arg_399_1.time_ >= var_402_0 + var_402_8 and arg_399_1.time_ < var_402_0 + var_402_8 + arg_402_0 then
				arg_399_1.typewritter.percent = 1

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(true)
			end
		end

		arg_399_1.nodeConfigList_ = {}

		arg_399_1:InitPlayNodeList()
	end,
	Play1109402098 = function(arg_403_0, arg_403_1)
		arg_403_1.time_ = 0
		arg_403_1.frameCnt_ = 0
		arg_403_1.state_ = "playing"
		arg_403_1.curTalkId_ = 1109402098
		arg_403_1.duration_ = 3.43

		local var_403_0 = {
			ja = 1.999999999999,
			ko = 3.433,
			zh = 3.433
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
				arg_403_0:Play1109402099(arg_403_1)
			end
		end

		function arg_403_1.onSingleLineUpdate_(arg_406_0)
			local var_406_0 = arg_403_1.actors_["1094ui_story"].transform
			local var_406_1 = 0

			if var_406_1 < arg_403_1.time_ and arg_403_1.time_ <= var_406_1 + arg_406_0 then
				arg_403_1.var_.moveOldPos1094ui_story = var_406_0.localPosition
			end

			local var_406_2 = 0.001

			if var_406_1 <= arg_403_1.time_ and arg_403_1.time_ < var_406_1 + var_406_2 then
				local var_406_3 = (arg_403_1.time_ - var_406_1) / var_406_2
				local var_406_4 = Vector3.New(0, -0.84, -6.1)

				var_406_0.localPosition = Vector3.Lerp(arg_403_1.var_.moveOldPos1094ui_story, var_406_4, var_406_3)

				local var_406_5 = manager.ui.mainCamera.transform.position - var_406_0.position

				var_406_0.forward = Vector3.New(var_406_5.x, var_406_5.y, var_406_5.z)

				local var_406_6 = var_406_0.localEulerAngles

				var_406_6.z = 0
				var_406_6.x = 0
				var_406_0.localEulerAngles = var_406_6
			end

			if arg_403_1.time_ >= var_406_1 + var_406_2 and arg_403_1.time_ < var_406_1 + var_406_2 + arg_406_0 then
				var_406_0.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_406_7 = manager.ui.mainCamera.transform.position - var_406_0.position

				var_406_0.forward = Vector3.New(var_406_7.x, var_406_7.y, var_406_7.z)

				local var_406_8 = var_406_0.localEulerAngles

				var_406_8.z = 0
				var_406_8.x = 0
				var_406_0.localEulerAngles = var_406_8
			end

			local var_406_9 = arg_403_1.actors_["1094ui_story"]
			local var_406_10 = 0

			if var_406_10 < arg_403_1.time_ and arg_403_1.time_ <= var_406_10 + arg_406_0 and not isNil(var_406_9) and arg_403_1.var_.characterEffect1094ui_story == nil then
				arg_403_1.var_.characterEffect1094ui_story = var_406_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_406_11 = 0.200000002980232

			if var_406_10 <= arg_403_1.time_ and arg_403_1.time_ < var_406_10 + var_406_11 and not isNil(var_406_9) then
				local var_406_12 = (arg_403_1.time_ - var_406_10) / var_406_11

				if arg_403_1.var_.characterEffect1094ui_story and not isNil(var_406_9) then
					arg_403_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_403_1.time_ >= var_406_10 + var_406_11 and arg_403_1.time_ < var_406_10 + var_406_11 + arg_406_0 and not isNil(var_406_9) and arg_403_1.var_.characterEffect1094ui_story then
				arg_403_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_406_13 = 0

			if var_406_13 < arg_403_1.time_ and arg_403_1.time_ <= var_406_13 + arg_406_0 then
				arg_403_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action4_2")
			end

			local var_406_14 = 0

			if var_406_14 < arg_403_1.time_ and arg_403_1.time_ <= var_406_14 + arg_406_0 then
				arg_403_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_406_15 = 0
			local var_406_16 = 0.25

			if var_406_15 < arg_403_1.time_ and arg_403_1.time_ <= var_406_15 + arg_406_0 then
				arg_403_1.talkMaxDuration = 0
				arg_403_1.dialogCg_.alpha = 1

				arg_403_1.dialog_:SetActive(true)
				SetActive(arg_403_1.leftNameGo_, true)

				local var_406_17 = arg_403_1:FormatText(StoryNameCfg[181].name)

				arg_403_1.leftNameTxt_.text = var_406_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_403_1.leftNameTxt_.transform)

				arg_403_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_403_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_403_1:RecordName(arg_403_1.leftNameTxt_.text)
				SetActive(arg_403_1.iconTrs_.gameObject, false)
				arg_403_1.callingController_:SetSelectedState("normal")

				local var_406_18 = arg_403_1:GetWordFromCfg(1109402098)
				local var_406_19 = arg_403_1:FormatText(var_406_18.content)

				arg_403_1.text_.text = var_406_19

				LuaForUtil.ClearLinePrefixSymbol(arg_403_1.text_)

				local var_406_20 = 10
				local var_406_21 = utf8.len(var_406_19)
				local var_406_22 = var_406_20 <= 0 and var_406_16 or var_406_16 * (var_406_21 / var_406_20)

				if var_406_22 > 0 and var_406_16 < var_406_22 then
					arg_403_1.talkMaxDuration = var_406_22

					if var_406_22 + var_406_15 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_22 + var_406_15
					end
				end

				arg_403_1.text_.text = var_406_19
				arg_403_1.typewritter.percent = 0

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402098", "story_v_side_new_1109402.awb") ~= 0 then
					local var_406_23 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402098", "story_v_side_new_1109402.awb") / 1000

					if var_406_23 + var_406_15 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_23 + var_406_15
					end

					if var_406_18.prefab_name ~= "" and arg_403_1.actors_[var_406_18.prefab_name] ~= nil then
						local var_406_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_403_1.actors_[var_406_18.prefab_name].transform, "story_v_side_new_1109402", "1109402098", "story_v_side_new_1109402.awb")

						arg_403_1:RecordAudio("1109402098", var_406_24)
						arg_403_1:RecordAudio("1109402098", var_406_24)
					else
						arg_403_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402098", "story_v_side_new_1109402.awb")
					end

					arg_403_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402098", "story_v_side_new_1109402.awb")
				end

				arg_403_1:RecordContent(arg_403_1.text_.text)
			end

			local var_406_25 = math.max(var_406_16, arg_403_1.talkMaxDuration)

			if var_406_15 <= arg_403_1.time_ and arg_403_1.time_ < var_406_15 + var_406_25 then
				arg_403_1.typewritter.percent = (arg_403_1.time_ - var_406_15) / var_406_25

				arg_403_1.typewritter:SetDirty()
			end

			if arg_403_1.time_ >= var_406_15 + var_406_25 and arg_403_1.time_ < var_406_15 + var_406_25 + arg_406_0 then
				arg_403_1.typewritter.percent = 1

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(true)
			end
		end

		arg_403_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_403_1:InitPlayNodeList()
	end,
	Play1109402099 = function(arg_407_0, arg_407_1)
		arg_407_1.time_ = 0
		arg_407_1.frameCnt_ = 0
		arg_407_1.state_ = "playing"
		arg_407_1.curTalkId_ = 1109402099
		arg_407_1.duration_ = 11.57

		local var_407_0 = {
			ja = 11.566,
			ko = 5.866,
			zh = 5.866
		}
		local var_407_1 = manager.audio:GetLocalizationFlag()

		if var_407_0[var_407_1] ~= nil then
			arg_407_1.duration_ = var_407_0[var_407_1]
		end

		SetActive(arg_407_1.tipsGo_, false)

		function arg_407_1.onSingleLineFinish_()
			arg_407_1.onSingleLineUpdate_ = nil
			arg_407_1.onSingleLineFinish_ = nil
			arg_407_1.state_ = "waiting"
		end

		function arg_407_1.playNext_(arg_409_0)
			if arg_409_0 == 1 then
				arg_407_0:Play1109402100(arg_407_1)
			end
		end

		function arg_407_1.onSingleLineUpdate_(arg_410_0)
			local var_410_0 = arg_407_1.actors_["1094ui_story"]
			local var_410_1 = 0

			if var_410_1 < arg_407_1.time_ and arg_407_1.time_ <= var_410_1 + arg_410_0 and not isNil(var_410_0) and arg_407_1.var_.characterEffect1094ui_story == nil then
				arg_407_1.var_.characterEffect1094ui_story = var_410_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_410_2 = 0.200000002980232

			if var_410_1 <= arg_407_1.time_ and arg_407_1.time_ < var_410_1 + var_410_2 and not isNil(var_410_0) then
				local var_410_3 = (arg_407_1.time_ - var_410_1) / var_410_2

				if arg_407_1.var_.characterEffect1094ui_story and not isNil(var_410_0) then
					local var_410_4 = Mathf.Lerp(0, 0.5, var_410_3)

					arg_407_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_407_1.var_.characterEffect1094ui_story.fillRatio = var_410_4
				end
			end

			if arg_407_1.time_ >= var_410_1 + var_410_2 and arg_407_1.time_ < var_410_1 + var_410_2 + arg_410_0 and not isNil(var_410_0) and arg_407_1.var_.characterEffect1094ui_story then
				local var_410_5 = 0.5

				arg_407_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_407_1.var_.characterEffect1094ui_story.fillRatio = var_410_5
			end

			local var_410_6 = 0
			local var_410_7 = 0.65

			if var_410_6 < arg_407_1.time_ and arg_407_1.time_ <= var_410_6 + arg_410_0 then
				arg_407_1.talkMaxDuration = 0
				arg_407_1.dialogCg_.alpha = 1

				arg_407_1.dialog_:SetActive(true)
				SetActive(arg_407_1.leftNameGo_, true)

				local var_410_8 = arg_407_1:FormatText(StoryNameCfg[189].name)

				arg_407_1.leftNameTxt_.text = var_410_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_407_1.leftNameTxt_.transform)

				arg_407_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_407_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_407_1:RecordName(arg_407_1.leftNameTxt_.text)
				SetActive(arg_407_1.iconTrs_.gameObject, true)
				arg_407_1.iconController_:SetSelectedState("hero")

				arg_407_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vina")

				arg_407_1.callingController_:SetSelectedState("normal")

				arg_407_1.keyicon_.color = Color.New(1, 1, 1)
				arg_407_1.icon_.color = Color.New(1, 1, 1)

				local var_410_9 = arg_407_1:GetWordFromCfg(1109402099)
				local var_410_10 = arg_407_1:FormatText(var_410_9.content)

				arg_407_1.text_.text = var_410_10

				LuaForUtil.ClearLinePrefixSymbol(arg_407_1.text_)

				local var_410_11 = 26
				local var_410_12 = utf8.len(var_410_10)
				local var_410_13 = var_410_11 <= 0 and var_410_7 or var_410_7 * (var_410_12 / var_410_11)

				if var_410_13 > 0 and var_410_7 < var_410_13 then
					arg_407_1.talkMaxDuration = var_410_13

					if var_410_13 + var_410_6 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_13 + var_410_6
					end
				end

				arg_407_1.text_.text = var_410_10
				arg_407_1.typewritter.percent = 0

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402099", "story_v_side_new_1109402.awb") ~= 0 then
					local var_410_14 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402099", "story_v_side_new_1109402.awb") / 1000

					if var_410_14 + var_410_6 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_14 + var_410_6
					end

					if var_410_9.prefab_name ~= "" and arg_407_1.actors_[var_410_9.prefab_name] ~= nil then
						local var_410_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_407_1.actors_[var_410_9.prefab_name].transform, "story_v_side_new_1109402", "1109402099", "story_v_side_new_1109402.awb")

						arg_407_1:RecordAudio("1109402099", var_410_15)
						arg_407_1:RecordAudio("1109402099", var_410_15)
					else
						arg_407_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402099", "story_v_side_new_1109402.awb")
					end

					arg_407_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402099", "story_v_side_new_1109402.awb")
				end

				arg_407_1:RecordContent(arg_407_1.text_.text)
			end

			local var_410_16 = math.max(var_410_7, arg_407_1.talkMaxDuration)

			if var_410_6 <= arg_407_1.time_ and arg_407_1.time_ < var_410_6 + var_410_16 then
				arg_407_1.typewritter.percent = (arg_407_1.time_ - var_410_6) / var_410_16

				arg_407_1.typewritter:SetDirty()
			end

			if arg_407_1.time_ >= var_410_6 + var_410_16 and arg_407_1.time_ < var_410_6 + var_410_16 + arg_410_0 then
				arg_407_1.typewritter.percent = 1

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(true)
			end
		end

		arg_407_1.nodeConfigList_ = {}

		arg_407_1:InitPlayNodeList()
	end,
	Play1109402100 = function(arg_411_0, arg_411_1)
		arg_411_1.time_ = 0
		arg_411_1.frameCnt_ = 0
		arg_411_1.state_ = "playing"
		arg_411_1.curTalkId_ = 1109402100
		arg_411_1.duration_ = 8.9

		local var_411_0 = {
			ja = 8.9,
			ko = 6.3,
			zh = 6.3
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
		end

		function arg_411_1.playNext_(arg_413_0)
			if arg_413_0 == 1 then
				arg_411_0:Play1109402101(arg_411_1)
			end
		end

		function arg_411_1.onSingleLineUpdate_(arg_414_0)
			local var_414_0 = 0
			local var_414_1 = 0.8

			if var_414_0 < arg_411_1.time_ and arg_411_1.time_ <= var_414_0 + arg_414_0 then
				arg_411_1.talkMaxDuration = 0
				arg_411_1.dialogCg_.alpha = 1

				arg_411_1.dialog_:SetActive(true)
				SetActive(arg_411_1.leftNameGo_, true)

				local var_414_2 = arg_411_1:FormatText(StoryNameCfg[189].name)

				arg_411_1.leftNameTxt_.text = var_414_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_411_1.leftNameTxt_.transform)

				arg_411_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_411_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_411_1:RecordName(arg_411_1.leftNameTxt_.text)
				SetActive(arg_411_1.iconTrs_.gameObject, true)
				arg_411_1.iconController_:SetSelectedState("hero")

				arg_411_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vina")

				arg_411_1.callingController_:SetSelectedState("normal")

				arg_411_1.keyicon_.color = Color.New(1, 1, 1)
				arg_411_1.icon_.color = Color.New(1, 1, 1)

				local var_414_3 = arg_411_1:GetWordFromCfg(1109402100)
				local var_414_4 = arg_411_1:FormatText(var_414_3.content)

				arg_411_1.text_.text = var_414_4

				LuaForUtil.ClearLinePrefixSymbol(arg_411_1.text_)

				local var_414_5 = 32
				local var_414_6 = utf8.len(var_414_4)
				local var_414_7 = var_414_5 <= 0 and var_414_1 or var_414_1 * (var_414_6 / var_414_5)

				if var_414_7 > 0 and var_414_1 < var_414_7 then
					arg_411_1.talkMaxDuration = var_414_7

					if var_414_7 + var_414_0 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_7 + var_414_0
					end
				end

				arg_411_1.text_.text = var_414_4
				arg_411_1.typewritter.percent = 0

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402100", "story_v_side_new_1109402.awb") ~= 0 then
					local var_414_8 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402100", "story_v_side_new_1109402.awb") / 1000

					if var_414_8 + var_414_0 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_8 + var_414_0
					end

					if var_414_3.prefab_name ~= "" and arg_411_1.actors_[var_414_3.prefab_name] ~= nil then
						local var_414_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_411_1.actors_[var_414_3.prefab_name].transform, "story_v_side_new_1109402", "1109402100", "story_v_side_new_1109402.awb")

						arg_411_1:RecordAudio("1109402100", var_414_9)
						arg_411_1:RecordAudio("1109402100", var_414_9)
					else
						arg_411_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402100", "story_v_side_new_1109402.awb")
					end

					arg_411_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402100", "story_v_side_new_1109402.awb")
				end

				arg_411_1:RecordContent(arg_411_1.text_.text)
			end

			local var_414_10 = math.max(var_414_1, arg_411_1.talkMaxDuration)

			if var_414_0 <= arg_411_1.time_ and arg_411_1.time_ < var_414_0 + var_414_10 then
				arg_411_1.typewritter.percent = (arg_411_1.time_ - var_414_0) / var_414_10

				arg_411_1.typewritter:SetDirty()
			end

			if arg_411_1.time_ >= var_414_0 + var_414_10 and arg_411_1.time_ < var_414_0 + var_414_10 + arg_414_0 then
				arg_411_1.typewritter.percent = 1

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(true)
			end
		end

		arg_411_1.nodeConfigList_ = {}

		arg_411_1:InitPlayNodeList()
	end,
	Play1109402101 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 1109402101
		arg_415_1.duration_ = 9

		SetActive(arg_415_1.tipsGo_, false)

		function arg_415_1.onSingleLineFinish_()
			arg_415_1.onSingleLineUpdate_ = nil
			arg_415_1.onSingleLineFinish_ = nil
			arg_415_1.state_ = "waiting"
		end

		function arg_415_1.playNext_(arg_417_0)
			if arg_417_0 == 1 then
				arg_415_0:Play1109402102(arg_415_1)
			end
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			local var_418_0 = "ST17"

			if arg_415_1.bgs_[var_418_0] == nil then
				local var_418_1 = Object.Instantiate(arg_415_1.paintGo_)

				var_418_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_418_0)
				var_418_1.name = var_418_0
				var_418_1.transform.parent = arg_415_1.stage_.transform
				var_418_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_415_1.bgs_[var_418_0] = var_418_1
			end

			local var_418_2 = 2

			if var_418_2 < arg_415_1.time_ and arg_415_1.time_ <= var_418_2 + arg_418_0 then
				local var_418_3 = manager.ui.mainCamera.transform.localPosition
				local var_418_4 = Vector3.New(0, 0, 10) + Vector3.New(var_418_3.x, var_418_3.y, 0)
				local var_418_5 = arg_415_1.bgs_.ST17

				var_418_5.transform.localPosition = var_418_4
				var_418_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_418_6 = var_418_5:GetComponent("SpriteRenderer")

				if var_418_6 and var_418_6.sprite then
					local var_418_7 = (var_418_5.transform.localPosition - var_418_3).z
					local var_418_8 = manager.ui.mainCameraCom_
					local var_418_9 = 2 * var_418_7 * Mathf.Tan(var_418_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_418_10 = var_418_9 * var_418_8.aspect
					local var_418_11 = var_418_6.sprite.bounds.size.x
					local var_418_12 = var_418_6.sprite.bounds.size.y
					local var_418_13 = var_418_10 / var_418_11
					local var_418_14 = var_418_9 / var_418_12
					local var_418_15 = var_418_14 < var_418_13 and var_418_13 or var_418_14

					var_418_5.transform.localScale = Vector3.New(var_418_15, var_418_15, 0)
				end

				for iter_418_0, iter_418_1 in pairs(arg_415_1.bgs_) do
					if iter_418_0 ~= "ST17" then
						iter_418_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_418_16 = 0

			if var_418_16 < arg_415_1.time_ and arg_415_1.time_ <= var_418_16 + arg_418_0 then
				arg_415_1.mask_.enabled = true
				arg_415_1.mask_.raycastTarget = true

				arg_415_1:SetGaussion(false)
			end

			local var_418_17 = 2

			if var_418_16 <= arg_415_1.time_ and arg_415_1.time_ < var_418_16 + var_418_17 then
				local var_418_18 = (arg_415_1.time_ - var_418_16) / var_418_17
				local var_418_19 = Color.New(0, 0, 0)

				var_418_19.a = Mathf.Lerp(0, 1, var_418_18)
				arg_415_1.mask_.color = var_418_19
			end

			if arg_415_1.time_ >= var_418_16 + var_418_17 and arg_415_1.time_ < var_418_16 + var_418_17 + arg_418_0 then
				local var_418_20 = Color.New(0, 0, 0)

				var_418_20.a = 1
				arg_415_1.mask_.color = var_418_20
			end

			local var_418_21 = 2

			if var_418_21 < arg_415_1.time_ and arg_415_1.time_ <= var_418_21 + arg_418_0 then
				arg_415_1.mask_.enabled = true
				arg_415_1.mask_.raycastTarget = true

				arg_415_1:SetGaussion(false)
			end

			local var_418_22 = 2

			if var_418_21 <= arg_415_1.time_ and arg_415_1.time_ < var_418_21 + var_418_22 then
				local var_418_23 = (arg_415_1.time_ - var_418_21) / var_418_22
				local var_418_24 = Color.New(0, 0, 0)

				var_418_24.a = Mathf.Lerp(1, 0, var_418_23)
				arg_415_1.mask_.color = var_418_24
			end

			if arg_415_1.time_ >= var_418_21 + var_418_22 and arg_415_1.time_ < var_418_21 + var_418_22 + arg_418_0 then
				local var_418_25 = Color.New(0, 0, 0)
				local var_418_26 = 0

				arg_415_1.mask_.enabled = false
				var_418_25.a = var_418_26
				arg_415_1.mask_.color = var_418_25
			end

			local var_418_27 = arg_415_1.actors_["1094ui_story"].transform
			local var_418_28 = 0

			if var_418_28 < arg_415_1.time_ and arg_415_1.time_ <= var_418_28 + arg_418_0 then
				arg_415_1.var_.moveOldPos1094ui_story = var_418_27.localPosition
			end

			local var_418_29 = 0.001

			if var_418_28 <= arg_415_1.time_ and arg_415_1.time_ < var_418_28 + var_418_29 then
				local var_418_30 = (arg_415_1.time_ - var_418_28) / var_418_29
				local var_418_31 = Vector3.New(0, 100, 0)

				var_418_27.localPosition = Vector3.Lerp(arg_415_1.var_.moveOldPos1094ui_story, var_418_31, var_418_30)

				local var_418_32 = manager.ui.mainCamera.transform.position - var_418_27.position

				var_418_27.forward = Vector3.New(var_418_32.x, var_418_32.y, var_418_32.z)

				local var_418_33 = var_418_27.localEulerAngles

				var_418_33.z = 0
				var_418_33.x = 0
				var_418_27.localEulerAngles = var_418_33
			end

			if arg_415_1.time_ >= var_418_28 + var_418_29 and arg_415_1.time_ < var_418_28 + var_418_29 + arg_418_0 then
				var_418_27.localPosition = Vector3.New(0, 100, 0)

				local var_418_34 = manager.ui.mainCamera.transform.position - var_418_27.position

				var_418_27.forward = Vector3.New(var_418_34.x, var_418_34.y, var_418_34.z)

				local var_418_35 = var_418_27.localEulerAngles

				var_418_35.z = 0
				var_418_35.x = 0
				var_418_27.localEulerAngles = var_418_35
			end

			local var_418_36 = arg_415_1.actors_["1094ui_story"]
			local var_418_37 = 0

			if var_418_37 < arg_415_1.time_ and arg_415_1.time_ <= var_418_37 + arg_418_0 and not isNil(var_418_36) and arg_415_1.var_.characterEffect1094ui_story == nil then
				arg_415_1.var_.characterEffect1094ui_story = var_418_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_418_38 = 0.200000002980232

			if var_418_37 <= arg_415_1.time_ and arg_415_1.time_ < var_418_37 + var_418_38 and not isNil(var_418_36) then
				local var_418_39 = (arg_415_1.time_ - var_418_37) / var_418_38

				if arg_415_1.var_.characterEffect1094ui_story and not isNil(var_418_36) then
					local var_418_40 = Mathf.Lerp(0, 0.5, var_418_39)

					arg_415_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_415_1.var_.characterEffect1094ui_story.fillRatio = var_418_40
				end
			end

			if arg_415_1.time_ >= var_418_37 + var_418_38 and arg_415_1.time_ < var_418_37 + var_418_38 + arg_418_0 and not isNil(var_418_36) and arg_415_1.var_.characterEffect1094ui_story then
				local var_418_41 = 0.5

				arg_415_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_415_1.var_.characterEffect1094ui_story.fillRatio = var_418_41
			end

			if arg_415_1.frameCnt_ <= 1 then
				arg_415_1.dialog_:SetActive(false)
			end

			local var_418_42 = 4
			local var_418_43 = 0.4

			if var_418_42 < arg_415_1.time_ and arg_415_1.time_ <= var_418_42 + arg_418_0 then
				arg_415_1.talkMaxDuration = 0

				arg_415_1.dialog_:SetActive(true)

				arg_415_1.dialogCg_.alpha = 0

				local var_418_44 = LeanTween.value(arg_415_1.dialog_, 0, 1, 0.3)

				var_418_44:setOnUpdate(LuaHelper.FloatAction(function(arg_419_0)
					arg_415_1.dialogCg_.alpha = arg_419_0
				end))
				var_418_44:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_415_1.dialog_)
					var_418_44:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_415_1.duration_ = arg_415_1.duration_ + 0.3

				SetActive(arg_415_1.leftNameGo_, false)

				arg_415_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_415_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_415_1:RecordName(arg_415_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_415_1.iconTrs_.gameObject, false)
				arg_415_1.callingController_:SetSelectedState("normal")

				local var_418_45 = arg_415_1:GetWordFromCfg(1109402101)
				local var_418_46 = arg_415_1:FormatText(var_418_45.content)

				arg_415_1.text_.text = var_418_46

				LuaForUtil.ClearLinePrefixSymbol(arg_415_1.text_)

				local var_418_47 = 16
				local var_418_48 = utf8.len(var_418_46)
				local var_418_49 = var_418_47 <= 0 and var_418_43 or var_418_43 * (var_418_48 / var_418_47)

				if var_418_49 > 0 and var_418_43 < var_418_49 then
					arg_415_1.talkMaxDuration = var_418_49
					var_418_42 = var_418_42 + 0.3

					if var_418_49 + var_418_42 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_49 + var_418_42
					end
				end

				arg_415_1.text_.text = var_418_46
				arg_415_1.typewritter.percent = 0

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(false)
				arg_415_1:RecordContent(arg_415_1.text_.text)
			end

			local var_418_50 = var_418_42 + 0.3
			local var_418_51 = math.max(var_418_43, arg_415_1.talkMaxDuration)

			if var_418_50 <= arg_415_1.time_ and arg_415_1.time_ < var_418_50 + var_418_51 then
				arg_415_1.typewritter.percent = (arg_415_1.time_ - var_418_50) / var_418_51

				arg_415_1.typewritter:SetDirty()
			end

			if arg_415_1.time_ >= var_418_50 + var_418_51 and arg_415_1.time_ < var_418_50 + var_418_51 + arg_418_0 then
				arg_415_1.typewritter.percent = 1

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(true)
			end
		end

		arg_415_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_415_1:InitPlayNodeList()
	end,
	Play1109402102 = function(arg_421_0, arg_421_1)
		arg_421_1.time_ = 0
		arg_421_1.frameCnt_ = 0
		arg_421_1.state_ = "playing"
		arg_421_1.curTalkId_ = 1109402102
		arg_421_1.duration_ = 5

		SetActive(arg_421_1.tipsGo_, false)

		function arg_421_1.onSingleLineFinish_()
			arg_421_1.onSingleLineUpdate_ = nil
			arg_421_1.onSingleLineFinish_ = nil
			arg_421_1.state_ = "waiting"
		end

		function arg_421_1.playNext_(arg_423_0)
			if arg_423_0 == 1 then
				arg_421_0:Play1109402103(arg_421_1)
			end
		end

		function arg_421_1.onSingleLineUpdate_(arg_424_0)
			local var_424_0 = 0
			local var_424_1 = 1.075

			if var_424_0 < arg_421_1.time_ and arg_421_1.time_ <= var_424_0 + arg_424_0 then
				arg_421_1.talkMaxDuration = 0
				arg_421_1.dialogCg_.alpha = 1

				arg_421_1.dialog_:SetActive(true)
				SetActive(arg_421_1.leftNameGo_, false)

				arg_421_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_421_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_421_1:RecordName(arg_421_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_421_1.iconTrs_.gameObject, false)
				arg_421_1.callingController_:SetSelectedState("normal")

				local var_424_2 = arg_421_1:GetWordFromCfg(1109402102)
				local var_424_3 = arg_421_1:FormatText(var_424_2.content)

				arg_421_1.text_.text = var_424_3

				LuaForUtil.ClearLinePrefixSymbol(arg_421_1.text_)

				local var_424_4 = 43
				local var_424_5 = utf8.len(var_424_3)
				local var_424_6 = var_424_4 <= 0 and var_424_1 or var_424_1 * (var_424_5 / var_424_4)

				if var_424_6 > 0 and var_424_1 < var_424_6 then
					arg_421_1.talkMaxDuration = var_424_6

					if var_424_6 + var_424_0 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_6 + var_424_0
					end
				end

				arg_421_1.text_.text = var_424_3
				arg_421_1.typewritter.percent = 0

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(false)
				arg_421_1:RecordContent(arg_421_1.text_.text)
			end

			local var_424_7 = math.max(var_424_1, arg_421_1.talkMaxDuration)

			if var_424_0 <= arg_421_1.time_ and arg_421_1.time_ < var_424_0 + var_424_7 then
				arg_421_1.typewritter.percent = (arg_421_1.time_ - var_424_0) / var_424_7

				arg_421_1.typewritter:SetDirty()
			end

			if arg_421_1.time_ >= var_424_0 + var_424_7 and arg_421_1.time_ < var_424_0 + var_424_7 + arg_424_0 then
				arg_421_1.typewritter.percent = 1

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(true)
			end
		end

		arg_421_1.nodeConfigList_ = {}

		arg_421_1:InitPlayNodeList()
	end,
	Play1109402103 = function(arg_425_0, arg_425_1)
		arg_425_1.time_ = 0
		arg_425_1.frameCnt_ = 0
		arg_425_1.state_ = "playing"
		arg_425_1.curTalkId_ = 1109402103
		arg_425_1.duration_ = 5

		SetActive(arg_425_1.tipsGo_, false)

		function arg_425_1.onSingleLineFinish_()
			arg_425_1.onSingleLineUpdate_ = nil
			arg_425_1.onSingleLineFinish_ = nil
			arg_425_1.state_ = "waiting"
		end

		function arg_425_1.playNext_(arg_427_0)
			if arg_427_0 == 1 then
				arg_425_0:Play1109402104(arg_425_1)
			end
		end

		function arg_425_1.onSingleLineUpdate_(arg_428_0)
			local var_428_0 = 0
			local var_428_1 = 0.575

			if var_428_0 < arg_425_1.time_ and arg_425_1.time_ <= var_428_0 + arg_428_0 then
				arg_425_1.talkMaxDuration = 0
				arg_425_1.dialogCg_.alpha = 1

				arg_425_1.dialog_:SetActive(true)
				SetActive(arg_425_1.leftNameGo_, false)

				arg_425_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_425_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_425_1:RecordName(arg_425_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_425_1.iconTrs_.gameObject, false)
				arg_425_1.callingController_:SetSelectedState("normal")

				local var_428_2 = arg_425_1:GetWordFromCfg(1109402103)
				local var_428_3 = arg_425_1:FormatText(var_428_2.content)

				arg_425_1.text_.text = var_428_3

				LuaForUtil.ClearLinePrefixSymbol(arg_425_1.text_)

				local var_428_4 = 23
				local var_428_5 = utf8.len(var_428_3)
				local var_428_6 = var_428_4 <= 0 and var_428_1 or var_428_1 * (var_428_5 / var_428_4)

				if var_428_6 > 0 and var_428_1 < var_428_6 then
					arg_425_1.talkMaxDuration = var_428_6

					if var_428_6 + var_428_0 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_6 + var_428_0
					end
				end

				arg_425_1.text_.text = var_428_3
				arg_425_1.typewritter.percent = 0

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(false)
				arg_425_1:RecordContent(arg_425_1.text_.text)
			end

			local var_428_7 = math.max(var_428_1, arg_425_1.talkMaxDuration)

			if var_428_0 <= arg_425_1.time_ and arg_425_1.time_ < var_428_0 + var_428_7 then
				arg_425_1.typewritter.percent = (arg_425_1.time_ - var_428_0) / var_428_7

				arg_425_1.typewritter:SetDirty()
			end

			if arg_425_1.time_ >= var_428_0 + var_428_7 and arg_425_1.time_ < var_428_0 + var_428_7 + arg_428_0 then
				arg_425_1.typewritter.percent = 1

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(true)
			end
		end

		arg_425_1.nodeConfigList_ = {}

		arg_425_1:InitPlayNodeList()
	end,
	Play1109402104 = function(arg_429_0, arg_429_1)
		arg_429_1.time_ = 0
		arg_429_1.frameCnt_ = 0
		arg_429_1.state_ = "playing"
		arg_429_1.curTalkId_ = 1109402104
		arg_429_1.duration_ = 5

		SetActive(arg_429_1.tipsGo_, false)

		function arg_429_1.onSingleLineFinish_()
			arg_429_1.onSingleLineUpdate_ = nil
			arg_429_1.onSingleLineFinish_ = nil
			arg_429_1.state_ = "waiting"
		end

		function arg_429_1.playNext_(arg_431_0)
			if arg_431_0 == 1 then
				arg_429_0:Play1109402105(arg_429_1)
			end
		end

		function arg_429_1.onSingleLineUpdate_(arg_432_0)
			local var_432_0 = 0
			local var_432_1 = 1.85

			if var_432_0 < arg_429_1.time_ and arg_429_1.time_ <= var_432_0 + arg_432_0 then
				arg_429_1.talkMaxDuration = 0
				arg_429_1.dialogCg_.alpha = 1

				arg_429_1.dialog_:SetActive(true)
				SetActive(arg_429_1.leftNameGo_, false)

				arg_429_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_429_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_429_1:RecordName(arg_429_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_429_1.iconTrs_.gameObject, false)
				arg_429_1.callingController_:SetSelectedState("normal")

				local var_432_2 = arg_429_1:GetWordFromCfg(1109402104)
				local var_432_3 = arg_429_1:FormatText(var_432_2.content)

				arg_429_1.text_.text = var_432_3

				LuaForUtil.ClearLinePrefixSymbol(arg_429_1.text_)

				local var_432_4 = 74
				local var_432_5 = utf8.len(var_432_3)
				local var_432_6 = var_432_4 <= 0 and var_432_1 or var_432_1 * (var_432_5 / var_432_4)

				if var_432_6 > 0 and var_432_1 < var_432_6 then
					arg_429_1.talkMaxDuration = var_432_6

					if var_432_6 + var_432_0 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_6 + var_432_0
					end
				end

				arg_429_1.text_.text = var_432_3
				arg_429_1.typewritter.percent = 0

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(false)
				arg_429_1:RecordContent(arg_429_1.text_.text)
			end

			local var_432_7 = math.max(var_432_1, arg_429_1.talkMaxDuration)

			if var_432_0 <= arg_429_1.time_ and arg_429_1.time_ < var_432_0 + var_432_7 then
				arg_429_1.typewritter.percent = (arg_429_1.time_ - var_432_0) / var_432_7

				arg_429_1.typewritter:SetDirty()
			end

			if arg_429_1.time_ >= var_432_0 + var_432_7 and arg_429_1.time_ < var_432_0 + var_432_7 + arg_432_0 then
				arg_429_1.typewritter.percent = 1

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(true)
			end
		end

		arg_429_1.nodeConfigList_ = {}

		arg_429_1:InitPlayNodeList()
	end,
	Play1109402105 = function(arg_433_0, arg_433_1)
		arg_433_1.time_ = 0
		arg_433_1.frameCnt_ = 0
		arg_433_1.state_ = "playing"
		arg_433_1.curTalkId_ = 1109402105
		arg_433_1.duration_ = 7.97

		local var_433_0 = {
			ja = 7.966,
			ko = 6.166,
			zh = 6.166
		}
		local var_433_1 = manager.audio:GetLocalizationFlag()

		if var_433_0[var_433_1] ~= nil then
			arg_433_1.duration_ = var_433_0[var_433_1]
		end

		SetActive(arg_433_1.tipsGo_, false)

		function arg_433_1.onSingleLineFinish_()
			arg_433_1.onSingleLineUpdate_ = nil
			arg_433_1.onSingleLineFinish_ = nil
			arg_433_1.state_ = "waiting"
		end

		function arg_433_1.playNext_(arg_435_0)
			if arg_435_0 == 1 then
				arg_433_0:Play1109402106(arg_433_1)
			end
		end

		function arg_433_1.onSingleLineUpdate_(arg_436_0)
			local var_436_0 = 0
			local var_436_1 = 0.475

			if var_436_0 < arg_433_1.time_ and arg_433_1.time_ <= var_436_0 + arg_436_0 then
				arg_433_1.talkMaxDuration = 0
				arg_433_1.dialogCg_.alpha = 1

				arg_433_1.dialog_:SetActive(true)
				SetActive(arg_433_1.leftNameGo_, true)

				local var_436_2 = arg_433_1:FormatText(StoryNameCfg[189].name)

				arg_433_1.leftNameTxt_.text = var_436_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_433_1.leftNameTxt_.transform)

				arg_433_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_433_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_433_1:RecordName(arg_433_1.leftNameTxt_.text)
				SetActive(arg_433_1.iconTrs_.gameObject, true)
				arg_433_1.iconController_:SetSelectedState("hero")

				arg_433_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vina")

				arg_433_1.callingController_:SetSelectedState("normal")

				arg_433_1.keyicon_.color = Color.New(1, 1, 1)
				arg_433_1.icon_.color = Color.New(1, 1, 1)

				local var_436_3 = arg_433_1:GetWordFromCfg(1109402105)
				local var_436_4 = arg_433_1:FormatText(var_436_3.content)

				arg_433_1.text_.text = var_436_4

				LuaForUtil.ClearLinePrefixSymbol(arg_433_1.text_)

				local var_436_5 = 19
				local var_436_6 = utf8.len(var_436_4)
				local var_436_7 = var_436_5 <= 0 and var_436_1 or var_436_1 * (var_436_6 / var_436_5)

				if var_436_7 > 0 and var_436_1 < var_436_7 then
					arg_433_1.talkMaxDuration = var_436_7

					if var_436_7 + var_436_0 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_7 + var_436_0
					end
				end

				arg_433_1.text_.text = var_436_4
				arg_433_1.typewritter.percent = 0

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402105", "story_v_side_new_1109402.awb") ~= 0 then
					local var_436_8 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402105", "story_v_side_new_1109402.awb") / 1000

					if var_436_8 + var_436_0 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_8 + var_436_0
					end

					if var_436_3.prefab_name ~= "" and arg_433_1.actors_[var_436_3.prefab_name] ~= nil then
						local var_436_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_433_1.actors_[var_436_3.prefab_name].transform, "story_v_side_new_1109402", "1109402105", "story_v_side_new_1109402.awb")

						arg_433_1:RecordAudio("1109402105", var_436_9)
						arg_433_1:RecordAudio("1109402105", var_436_9)
					else
						arg_433_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402105", "story_v_side_new_1109402.awb")
					end

					arg_433_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402105", "story_v_side_new_1109402.awb")
				end

				arg_433_1:RecordContent(arg_433_1.text_.text)
			end

			local var_436_10 = math.max(var_436_1, arg_433_1.talkMaxDuration)

			if var_436_0 <= arg_433_1.time_ and arg_433_1.time_ < var_436_0 + var_436_10 then
				arg_433_1.typewritter.percent = (arg_433_1.time_ - var_436_0) / var_436_10

				arg_433_1.typewritter:SetDirty()
			end

			if arg_433_1.time_ >= var_436_0 + var_436_10 and arg_433_1.time_ < var_436_0 + var_436_10 + arg_436_0 then
				arg_433_1.typewritter.percent = 1

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(true)
			end
		end

		arg_433_1.nodeConfigList_ = {}

		arg_433_1:InitPlayNodeList()
	end,
	Play1109402106 = function(arg_437_0, arg_437_1)
		arg_437_1.time_ = 0
		arg_437_1.frameCnt_ = 0
		arg_437_1.state_ = "playing"
		arg_437_1.curTalkId_ = 1109402106
		arg_437_1.duration_ = 13.2

		local var_437_0 = {
			ja = 13.2,
			ko = 8.633,
			zh = 8.633
		}
		local var_437_1 = manager.audio:GetLocalizationFlag()

		if var_437_0[var_437_1] ~= nil then
			arg_437_1.duration_ = var_437_0[var_437_1]
		end

		SetActive(arg_437_1.tipsGo_, false)

		function arg_437_1.onSingleLineFinish_()
			arg_437_1.onSingleLineUpdate_ = nil
			arg_437_1.onSingleLineFinish_ = nil
			arg_437_1.state_ = "waiting"
		end

		function arg_437_1.playNext_(arg_439_0)
			if arg_439_0 == 1 then
				arg_437_0:Play1109402107(arg_437_1)
			end
		end

		function arg_437_1.onSingleLineUpdate_(arg_440_0)
			local var_440_0 = arg_437_1.actors_["1094ui_story"].transform
			local var_440_1 = 0

			if var_440_1 < arg_437_1.time_ and arg_437_1.time_ <= var_440_1 + arg_440_0 then
				arg_437_1.var_.moveOldPos1094ui_story = var_440_0.localPosition
			end

			local var_440_2 = 0.001

			if var_440_1 <= arg_437_1.time_ and arg_437_1.time_ < var_440_1 + var_440_2 then
				local var_440_3 = (arg_437_1.time_ - var_440_1) / var_440_2
				local var_440_4 = Vector3.New(0, -0.84, -6.1)

				var_440_0.localPosition = Vector3.Lerp(arg_437_1.var_.moveOldPos1094ui_story, var_440_4, var_440_3)

				local var_440_5 = manager.ui.mainCamera.transform.position - var_440_0.position

				var_440_0.forward = Vector3.New(var_440_5.x, var_440_5.y, var_440_5.z)

				local var_440_6 = var_440_0.localEulerAngles

				var_440_6.z = 0
				var_440_6.x = 0
				var_440_0.localEulerAngles = var_440_6
			end

			if arg_437_1.time_ >= var_440_1 + var_440_2 and arg_437_1.time_ < var_440_1 + var_440_2 + arg_440_0 then
				var_440_0.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_440_7 = manager.ui.mainCamera.transform.position - var_440_0.position

				var_440_0.forward = Vector3.New(var_440_7.x, var_440_7.y, var_440_7.z)

				local var_440_8 = var_440_0.localEulerAngles

				var_440_8.z = 0
				var_440_8.x = 0
				var_440_0.localEulerAngles = var_440_8
			end

			local var_440_9 = arg_437_1.actors_["1094ui_story"]
			local var_440_10 = 0

			if var_440_10 < arg_437_1.time_ and arg_437_1.time_ <= var_440_10 + arg_440_0 and not isNil(var_440_9) and arg_437_1.var_.characterEffect1094ui_story == nil then
				arg_437_1.var_.characterEffect1094ui_story = var_440_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_440_11 = 0.200000002980232

			if var_440_10 <= arg_437_1.time_ and arg_437_1.time_ < var_440_10 + var_440_11 and not isNil(var_440_9) then
				local var_440_12 = (arg_437_1.time_ - var_440_10) / var_440_11

				if arg_437_1.var_.characterEffect1094ui_story and not isNil(var_440_9) then
					arg_437_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_437_1.time_ >= var_440_10 + var_440_11 and arg_437_1.time_ < var_440_10 + var_440_11 + arg_440_0 and not isNil(var_440_9) and arg_437_1.var_.characterEffect1094ui_story then
				arg_437_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_440_13 = 0

			if var_440_13 < arg_437_1.time_ and arg_437_1.time_ <= var_440_13 + arg_440_0 then
				arg_437_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action1_1")
			end

			local var_440_14 = 0

			if var_440_14 < arg_437_1.time_ and arg_437_1.time_ <= var_440_14 + arg_440_0 then
				arg_437_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_440_15 = 0
			local var_440_16 = 0.8

			if var_440_15 < arg_437_1.time_ and arg_437_1.time_ <= var_440_15 + arg_440_0 then
				arg_437_1.talkMaxDuration = 0
				arg_437_1.dialogCg_.alpha = 1

				arg_437_1.dialog_:SetActive(true)
				SetActive(arg_437_1.leftNameGo_, true)

				local var_440_17 = arg_437_1:FormatText(StoryNameCfg[181].name)

				arg_437_1.leftNameTxt_.text = var_440_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_437_1.leftNameTxt_.transform)

				arg_437_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_437_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_437_1:RecordName(arg_437_1.leftNameTxt_.text)
				SetActive(arg_437_1.iconTrs_.gameObject, false)
				arg_437_1.callingController_:SetSelectedState("normal")

				local var_440_18 = arg_437_1:GetWordFromCfg(1109402106)
				local var_440_19 = arg_437_1:FormatText(var_440_18.content)

				arg_437_1.text_.text = var_440_19

				LuaForUtil.ClearLinePrefixSymbol(arg_437_1.text_)

				local var_440_20 = 32
				local var_440_21 = utf8.len(var_440_19)
				local var_440_22 = var_440_20 <= 0 and var_440_16 or var_440_16 * (var_440_21 / var_440_20)

				if var_440_22 > 0 and var_440_16 < var_440_22 then
					arg_437_1.talkMaxDuration = var_440_22

					if var_440_22 + var_440_15 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_22 + var_440_15
					end
				end

				arg_437_1.text_.text = var_440_19
				arg_437_1.typewritter.percent = 0

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402106", "story_v_side_new_1109402.awb") ~= 0 then
					local var_440_23 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402106", "story_v_side_new_1109402.awb") / 1000

					if var_440_23 + var_440_15 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_23 + var_440_15
					end

					if var_440_18.prefab_name ~= "" and arg_437_1.actors_[var_440_18.prefab_name] ~= nil then
						local var_440_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_437_1.actors_[var_440_18.prefab_name].transform, "story_v_side_new_1109402", "1109402106", "story_v_side_new_1109402.awb")

						arg_437_1:RecordAudio("1109402106", var_440_24)
						arg_437_1:RecordAudio("1109402106", var_440_24)
					else
						arg_437_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402106", "story_v_side_new_1109402.awb")
					end

					arg_437_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402106", "story_v_side_new_1109402.awb")
				end

				arg_437_1:RecordContent(arg_437_1.text_.text)
			end

			local var_440_25 = math.max(var_440_16, arg_437_1.talkMaxDuration)

			if var_440_15 <= arg_437_1.time_ and arg_437_1.time_ < var_440_15 + var_440_25 then
				arg_437_1.typewritter.percent = (arg_437_1.time_ - var_440_15) / var_440_25

				arg_437_1.typewritter:SetDirty()
			end

			if arg_437_1.time_ >= var_440_15 + var_440_25 and arg_437_1.time_ < var_440_15 + var_440_25 + arg_440_0 then
				arg_437_1.typewritter.percent = 1

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(true)
			end
		end

		arg_437_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_437_1:InitPlayNodeList()
	end,
	Play1109402107 = function(arg_441_0, arg_441_1)
		arg_441_1.time_ = 0
		arg_441_1.frameCnt_ = 0
		arg_441_1.state_ = "playing"
		arg_441_1.curTalkId_ = 1109402107
		arg_441_1.duration_ = 3.87

		local var_441_0 = {
			ja = 3.866,
			ko = 1.633,
			zh = 1.633
		}
		local var_441_1 = manager.audio:GetLocalizationFlag()

		if var_441_0[var_441_1] ~= nil then
			arg_441_1.duration_ = var_441_0[var_441_1]
		end

		SetActive(arg_441_1.tipsGo_, false)

		function arg_441_1.onSingleLineFinish_()
			arg_441_1.onSingleLineUpdate_ = nil
			arg_441_1.onSingleLineFinish_ = nil
			arg_441_1.state_ = "waiting"
		end

		function arg_441_1.playNext_(arg_443_0)
			if arg_443_0 == 1 then
				arg_441_0:Play1109402108(arg_441_1)
			end
		end

		function arg_441_1.onSingleLineUpdate_(arg_444_0)
			local var_444_0 = arg_441_1.actors_["1094ui_story"]
			local var_444_1 = 0

			if var_444_1 < arg_441_1.time_ and arg_441_1.time_ <= var_444_1 + arg_444_0 and not isNil(var_444_0) and arg_441_1.var_.characterEffect1094ui_story == nil then
				arg_441_1.var_.characterEffect1094ui_story = var_444_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_444_2 = 0.200000002980232

			if var_444_1 <= arg_441_1.time_ and arg_441_1.time_ < var_444_1 + var_444_2 and not isNil(var_444_0) then
				local var_444_3 = (arg_441_1.time_ - var_444_1) / var_444_2

				if arg_441_1.var_.characterEffect1094ui_story and not isNil(var_444_0) then
					local var_444_4 = Mathf.Lerp(0, 0.5, var_444_3)

					arg_441_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_441_1.var_.characterEffect1094ui_story.fillRatio = var_444_4
				end
			end

			if arg_441_1.time_ >= var_444_1 + var_444_2 and arg_441_1.time_ < var_444_1 + var_444_2 + arg_444_0 and not isNil(var_444_0) and arg_441_1.var_.characterEffect1094ui_story then
				local var_444_5 = 0.5

				arg_441_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_441_1.var_.characterEffect1094ui_story.fillRatio = var_444_5
			end

			local var_444_6 = 0
			local var_444_7 = 0.125

			if var_444_6 < arg_441_1.time_ and arg_441_1.time_ <= var_444_6 + arg_444_0 then
				arg_441_1.talkMaxDuration = 0
				arg_441_1.dialogCg_.alpha = 1

				arg_441_1.dialog_:SetActive(true)
				SetActive(arg_441_1.leftNameGo_, true)

				local var_444_8 = arg_441_1:FormatText(StoryNameCfg[189].name)

				arg_441_1.leftNameTxt_.text = var_444_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_441_1.leftNameTxt_.transform)

				arg_441_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_441_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_441_1:RecordName(arg_441_1.leftNameTxt_.text)
				SetActive(arg_441_1.iconTrs_.gameObject, true)
				arg_441_1.iconController_:SetSelectedState("hero")

				arg_441_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vina")

				arg_441_1.callingController_:SetSelectedState("normal")

				arg_441_1.keyicon_.color = Color.New(1, 1, 1)
				arg_441_1.icon_.color = Color.New(1, 1, 1)

				local var_444_9 = arg_441_1:GetWordFromCfg(1109402107)
				local var_444_10 = arg_441_1:FormatText(var_444_9.content)

				arg_441_1.text_.text = var_444_10

				LuaForUtil.ClearLinePrefixSymbol(arg_441_1.text_)

				local var_444_11 = 5
				local var_444_12 = utf8.len(var_444_10)
				local var_444_13 = var_444_11 <= 0 and var_444_7 or var_444_7 * (var_444_12 / var_444_11)

				if var_444_13 > 0 and var_444_7 < var_444_13 then
					arg_441_1.talkMaxDuration = var_444_13

					if var_444_13 + var_444_6 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_13 + var_444_6
					end
				end

				arg_441_1.text_.text = var_444_10
				arg_441_1.typewritter.percent = 0

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402107", "story_v_side_new_1109402.awb") ~= 0 then
					local var_444_14 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402107", "story_v_side_new_1109402.awb") / 1000

					if var_444_14 + var_444_6 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_14 + var_444_6
					end

					if var_444_9.prefab_name ~= "" and arg_441_1.actors_[var_444_9.prefab_name] ~= nil then
						local var_444_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_441_1.actors_[var_444_9.prefab_name].transform, "story_v_side_new_1109402", "1109402107", "story_v_side_new_1109402.awb")

						arg_441_1:RecordAudio("1109402107", var_444_15)
						arg_441_1:RecordAudio("1109402107", var_444_15)
					else
						arg_441_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402107", "story_v_side_new_1109402.awb")
					end

					arg_441_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402107", "story_v_side_new_1109402.awb")
				end

				arg_441_1:RecordContent(arg_441_1.text_.text)
			end

			local var_444_16 = math.max(var_444_7, arg_441_1.talkMaxDuration)

			if var_444_6 <= arg_441_1.time_ and arg_441_1.time_ < var_444_6 + var_444_16 then
				arg_441_1.typewritter.percent = (arg_441_1.time_ - var_444_6) / var_444_16

				arg_441_1.typewritter:SetDirty()
			end

			if arg_441_1.time_ >= var_444_6 + var_444_16 and arg_441_1.time_ < var_444_6 + var_444_16 + arg_444_0 then
				arg_441_1.typewritter.percent = 1

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(true)
			end
		end

		arg_441_1.nodeConfigList_ = {}

		arg_441_1:InitPlayNodeList()
	end,
	Play1109402108 = function(arg_445_0, arg_445_1)
		arg_445_1.time_ = 0
		arg_445_1.frameCnt_ = 0
		arg_445_1.state_ = "playing"
		arg_445_1.curTalkId_ = 1109402108
		arg_445_1.duration_ = 5

		SetActive(arg_445_1.tipsGo_, false)

		function arg_445_1.onSingleLineFinish_()
			arg_445_1.onSingleLineUpdate_ = nil
			arg_445_1.onSingleLineFinish_ = nil
			arg_445_1.state_ = "waiting"
		end

		function arg_445_1.playNext_(arg_447_0)
			if arg_447_0 == 1 then
				arg_445_0:Play1109402109(arg_445_1)
			end
		end

		function arg_445_1.onSingleLineUpdate_(arg_448_0)
			local var_448_0 = 0
			local var_448_1 = 0.925

			if var_448_0 < arg_445_1.time_ and arg_445_1.time_ <= var_448_0 + arg_448_0 then
				arg_445_1.talkMaxDuration = 0
				arg_445_1.dialogCg_.alpha = 1

				arg_445_1.dialog_:SetActive(true)
				SetActive(arg_445_1.leftNameGo_, false)

				arg_445_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_445_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_445_1:RecordName(arg_445_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_445_1.iconTrs_.gameObject, false)
				arg_445_1.callingController_:SetSelectedState("normal")

				local var_448_2 = arg_445_1:GetWordFromCfg(1109402108)
				local var_448_3 = arg_445_1:FormatText(var_448_2.content)

				arg_445_1.text_.text = var_448_3

				LuaForUtil.ClearLinePrefixSymbol(arg_445_1.text_)

				local var_448_4 = 37
				local var_448_5 = utf8.len(var_448_3)
				local var_448_6 = var_448_4 <= 0 and var_448_1 or var_448_1 * (var_448_5 / var_448_4)

				if var_448_6 > 0 and var_448_1 < var_448_6 then
					arg_445_1.talkMaxDuration = var_448_6

					if var_448_6 + var_448_0 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_6 + var_448_0
					end
				end

				arg_445_1.text_.text = var_448_3
				arg_445_1.typewritter.percent = 0

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(false)
				arg_445_1:RecordContent(arg_445_1.text_.text)
			end

			local var_448_7 = math.max(var_448_1, arg_445_1.talkMaxDuration)

			if var_448_0 <= arg_445_1.time_ and arg_445_1.time_ < var_448_0 + var_448_7 then
				arg_445_1.typewritter.percent = (arg_445_1.time_ - var_448_0) / var_448_7

				arg_445_1.typewritter:SetDirty()
			end

			if arg_445_1.time_ >= var_448_0 + var_448_7 and arg_445_1.time_ < var_448_0 + var_448_7 + arg_448_0 then
				arg_445_1.typewritter.percent = 1

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(true)
			end
		end

		arg_445_1.nodeConfigList_ = {}

		arg_445_1:InitPlayNodeList()
	end,
	Play1109402109 = function(arg_449_0, arg_449_1)
		arg_449_1.time_ = 0
		arg_449_1.frameCnt_ = 0
		arg_449_1.state_ = "playing"
		arg_449_1.curTalkId_ = 1109402109
		arg_449_1.duration_ = 5

		SetActive(arg_449_1.tipsGo_, false)

		function arg_449_1.onSingleLineFinish_()
			arg_449_1.onSingleLineUpdate_ = nil
			arg_449_1.onSingleLineFinish_ = nil
			arg_449_1.state_ = "waiting"
		end

		function arg_449_1.playNext_(arg_451_0)
			if arg_451_0 == 1 then
				arg_449_0:Play1109402110(arg_449_1)
			end
		end

		function arg_449_1.onSingleLineUpdate_(arg_452_0)
			local var_452_0 = 0
			local var_452_1 = 0.25

			if var_452_0 < arg_449_1.time_ and arg_449_1.time_ <= var_452_0 + arg_452_0 then
				arg_449_1.talkMaxDuration = 0
				arg_449_1.dialogCg_.alpha = 1

				arg_449_1.dialog_:SetActive(true)
				SetActive(arg_449_1.leftNameGo_, true)

				local var_452_2 = arg_449_1:FormatText(StoryNameCfg[7].name)

				arg_449_1.leftNameTxt_.text = var_452_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_449_1.leftNameTxt_.transform)

				arg_449_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_449_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_449_1:RecordName(arg_449_1.leftNameTxt_.text)
				SetActive(arg_449_1.iconTrs_.gameObject, true)
				arg_449_1.iconController_:SetSelectedState("hero")

				arg_449_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_449_1.callingController_:SetSelectedState("normal")

				arg_449_1.keyicon_.color = Color.New(1, 1, 1)
				arg_449_1.icon_.color = Color.New(1, 1, 1)

				local var_452_3 = arg_449_1:GetWordFromCfg(1109402109)
				local var_452_4 = arg_449_1:FormatText(var_452_3.content)

				arg_449_1.text_.text = var_452_4

				LuaForUtil.ClearLinePrefixSymbol(arg_449_1.text_)

				local var_452_5 = 10
				local var_452_6 = utf8.len(var_452_4)
				local var_452_7 = var_452_5 <= 0 and var_452_1 or var_452_1 * (var_452_6 / var_452_5)

				if var_452_7 > 0 and var_452_1 < var_452_7 then
					arg_449_1.talkMaxDuration = var_452_7

					if var_452_7 + var_452_0 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_7 + var_452_0
					end
				end

				arg_449_1.text_.text = var_452_4
				arg_449_1.typewritter.percent = 0

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(false)
				arg_449_1:RecordContent(arg_449_1.text_.text)
			end

			local var_452_8 = math.max(var_452_1, arg_449_1.talkMaxDuration)

			if var_452_0 <= arg_449_1.time_ and arg_449_1.time_ < var_452_0 + var_452_8 then
				arg_449_1.typewritter.percent = (arg_449_1.time_ - var_452_0) / var_452_8

				arg_449_1.typewritter:SetDirty()
			end

			if arg_449_1.time_ >= var_452_0 + var_452_8 and arg_449_1.time_ < var_452_0 + var_452_8 + arg_452_0 then
				arg_449_1.typewritter.percent = 1

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(true)
			end
		end

		arg_449_1.nodeConfigList_ = {}

		arg_449_1:InitPlayNodeList()
	end,
	Play1109402110 = function(arg_453_0, arg_453_1)
		arg_453_1.time_ = 0
		arg_453_1.frameCnt_ = 0
		arg_453_1.state_ = "playing"
		arg_453_1.curTalkId_ = 1109402110
		arg_453_1.duration_ = 5

		SetActive(arg_453_1.tipsGo_, false)

		function arg_453_1.onSingleLineFinish_()
			arg_453_1.onSingleLineUpdate_ = nil
			arg_453_1.onSingleLineFinish_ = nil
			arg_453_1.state_ = "waiting"
		end

		function arg_453_1.playNext_(arg_455_0)
			if arg_455_0 == 1 then
				arg_453_0:Play1109402111(arg_453_1)
			end
		end

		function arg_453_1.onSingleLineUpdate_(arg_456_0)
			local var_456_0 = arg_453_1.actors_["1094ui_story"].transform
			local var_456_1 = 0

			if var_456_1 < arg_453_1.time_ and arg_453_1.time_ <= var_456_1 + arg_456_0 then
				arg_453_1.var_.moveOldPos1094ui_story = var_456_0.localPosition
			end

			local var_456_2 = 0.001

			if var_456_1 <= arg_453_1.time_ and arg_453_1.time_ < var_456_1 + var_456_2 then
				local var_456_3 = (arg_453_1.time_ - var_456_1) / var_456_2
				local var_456_4 = Vector3.New(0, -0.84, -6.1)

				var_456_0.localPosition = Vector3.Lerp(arg_453_1.var_.moveOldPos1094ui_story, var_456_4, var_456_3)

				local var_456_5 = manager.ui.mainCamera.transform.position - var_456_0.position

				var_456_0.forward = Vector3.New(var_456_5.x, var_456_5.y, var_456_5.z)

				local var_456_6 = var_456_0.localEulerAngles

				var_456_6.z = 0
				var_456_6.x = 0
				var_456_0.localEulerAngles = var_456_6
			end

			if arg_453_1.time_ >= var_456_1 + var_456_2 and arg_453_1.time_ < var_456_1 + var_456_2 + arg_456_0 then
				var_456_0.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_456_7 = manager.ui.mainCamera.transform.position - var_456_0.position

				var_456_0.forward = Vector3.New(var_456_7.x, var_456_7.y, var_456_7.z)

				local var_456_8 = var_456_0.localEulerAngles

				var_456_8.z = 0
				var_456_8.x = 0
				var_456_0.localEulerAngles = var_456_8
			end

			local var_456_9 = 0

			if var_456_9 < arg_453_1.time_ and arg_453_1.time_ <= var_456_9 + arg_456_0 then
				arg_453_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action5_1")
			end

			local var_456_10 = 0
			local var_456_11 = 0.85

			if var_456_10 < arg_453_1.time_ and arg_453_1.time_ <= var_456_10 + arg_456_0 then
				arg_453_1.talkMaxDuration = 0
				arg_453_1.dialogCg_.alpha = 1

				arg_453_1.dialog_:SetActive(true)
				SetActive(arg_453_1.leftNameGo_, false)

				arg_453_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_453_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_453_1:RecordName(arg_453_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_453_1.iconTrs_.gameObject, false)
				arg_453_1.callingController_:SetSelectedState("normal")

				local var_456_12 = arg_453_1:GetWordFromCfg(1109402110)
				local var_456_13 = arg_453_1:FormatText(var_456_12.content)

				arg_453_1.text_.text = var_456_13

				LuaForUtil.ClearLinePrefixSymbol(arg_453_1.text_)

				local var_456_14 = 33
				local var_456_15 = utf8.len(var_456_13)
				local var_456_16 = var_456_14 <= 0 and var_456_11 or var_456_11 * (var_456_15 / var_456_14)

				if var_456_16 > 0 and var_456_11 < var_456_16 then
					arg_453_1.talkMaxDuration = var_456_16

					if var_456_16 + var_456_10 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_16 + var_456_10
					end
				end

				arg_453_1.text_.text = var_456_13
				arg_453_1.typewritter.percent = 0

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(false)
				arg_453_1:RecordContent(arg_453_1.text_.text)
			end

			local var_456_17 = math.max(var_456_11, arg_453_1.talkMaxDuration)

			if var_456_10 <= arg_453_1.time_ and arg_453_1.time_ < var_456_10 + var_456_17 then
				arg_453_1.typewritter.percent = (arg_453_1.time_ - var_456_10) / var_456_17

				arg_453_1.typewritter:SetDirty()
			end

			if arg_453_1.time_ >= var_456_10 + var_456_17 and arg_453_1.time_ < var_456_10 + var_456_17 + arg_456_0 then
				arg_453_1.typewritter.percent = 1

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(true)
			end
		end

		arg_453_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_453_1:InitPlayNodeList()
	end,
	Play1109402111 = function(arg_457_0, arg_457_1)
		arg_457_1.time_ = 0
		arg_457_1.frameCnt_ = 0
		arg_457_1.state_ = "playing"
		arg_457_1.curTalkId_ = 1109402111
		arg_457_1.duration_ = 4.1

		local var_457_0 = {
			ja = 4.1,
			ko = 1.999999999999,
			zh = 1.999999999999
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
				arg_457_0:Play1109402112(arg_457_1)
			end
		end

		function arg_457_1.onSingleLineUpdate_(arg_460_0)
			local var_460_0 = arg_457_1.actors_["1094ui_story"].transform
			local var_460_1 = 0

			if var_460_1 < arg_457_1.time_ and arg_457_1.time_ <= var_460_1 + arg_460_0 then
				arg_457_1.var_.moveOldPos1094ui_story = var_460_0.localPosition
			end

			local var_460_2 = 0.001

			if var_460_1 <= arg_457_1.time_ and arg_457_1.time_ < var_460_1 + var_460_2 then
				local var_460_3 = (arg_457_1.time_ - var_460_1) / var_460_2
				local var_460_4 = Vector3.New(0, -0.84, -6.1)

				var_460_0.localPosition = Vector3.Lerp(arg_457_1.var_.moveOldPos1094ui_story, var_460_4, var_460_3)

				local var_460_5 = manager.ui.mainCamera.transform.position - var_460_0.position

				var_460_0.forward = Vector3.New(var_460_5.x, var_460_5.y, var_460_5.z)

				local var_460_6 = var_460_0.localEulerAngles

				var_460_6.z = 0
				var_460_6.x = 0
				var_460_0.localEulerAngles = var_460_6
			end

			if arg_457_1.time_ >= var_460_1 + var_460_2 and arg_457_1.time_ < var_460_1 + var_460_2 + arg_460_0 then
				var_460_0.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_460_7 = manager.ui.mainCamera.transform.position - var_460_0.position

				var_460_0.forward = Vector3.New(var_460_7.x, var_460_7.y, var_460_7.z)

				local var_460_8 = var_460_0.localEulerAngles

				var_460_8.z = 0
				var_460_8.x = 0
				var_460_0.localEulerAngles = var_460_8
			end

			local var_460_9 = arg_457_1.actors_["1094ui_story"]
			local var_460_10 = 0

			if var_460_10 < arg_457_1.time_ and arg_457_1.time_ <= var_460_10 + arg_460_0 and not isNil(var_460_9) and arg_457_1.var_.characterEffect1094ui_story == nil then
				arg_457_1.var_.characterEffect1094ui_story = var_460_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_460_11 = 0.200000002980232

			if var_460_10 <= arg_457_1.time_ and arg_457_1.time_ < var_460_10 + var_460_11 and not isNil(var_460_9) then
				local var_460_12 = (arg_457_1.time_ - var_460_10) / var_460_11

				if arg_457_1.var_.characterEffect1094ui_story and not isNil(var_460_9) then
					arg_457_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_457_1.time_ >= var_460_10 + var_460_11 and arg_457_1.time_ < var_460_10 + var_460_11 + arg_460_0 and not isNil(var_460_9) and arg_457_1.var_.characterEffect1094ui_story then
				arg_457_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_460_13 = 0

			if var_460_13 < arg_457_1.time_ and arg_457_1.time_ <= var_460_13 + arg_460_0 then
				arg_457_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094actionlink/1094action454")
			end

			local var_460_14 = 0

			if var_460_14 < arg_457_1.time_ and arg_457_1.time_ <= var_460_14 + arg_460_0 then
				arg_457_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_460_15 = 0
			local var_460_16 = 0.15

			if var_460_15 < arg_457_1.time_ and arg_457_1.time_ <= var_460_15 + arg_460_0 then
				arg_457_1.talkMaxDuration = 0
				arg_457_1.dialogCg_.alpha = 1

				arg_457_1.dialog_:SetActive(true)
				SetActive(arg_457_1.leftNameGo_, true)

				local var_460_17 = arg_457_1:FormatText(StoryNameCfg[181].name)

				arg_457_1.leftNameTxt_.text = var_460_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_457_1.leftNameTxt_.transform)

				arg_457_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_457_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_457_1:RecordName(arg_457_1.leftNameTxt_.text)
				SetActive(arg_457_1.iconTrs_.gameObject, false)
				arg_457_1.callingController_:SetSelectedState("normal")

				local var_460_18 = arg_457_1:GetWordFromCfg(1109402111)
				local var_460_19 = arg_457_1:FormatText(var_460_18.content)

				arg_457_1.text_.text = var_460_19

				LuaForUtil.ClearLinePrefixSymbol(arg_457_1.text_)

				local var_460_20 = 6
				local var_460_21 = utf8.len(var_460_19)
				local var_460_22 = var_460_20 <= 0 and var_460_16 or var_460_16 * (var_460_21 / var_460_20)

				if var_460_22 > 0 and var_460_16 < var_460_22 then
					arg_457_1.talkMaxDuration = var_460_22

					if var_460_22 + var_460_15 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_22 + var_460_15
					end
				end

				arg_457_1.text_.text = var_460_19
				arg_457_1.typewritter.percent = 0

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402111", "story_v_side_new_1109402.awb") ~= 0 then
					local var_460_23 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402111", "story_v_side_new_1109402.awb") / 1000

					if var_460_23 + var_460_15 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_23 + var_460_15
					end

					if var_460_18.prefab_name ~= "" and arg_457_1.actors_[var_460_18.prefab_name] ~= nil then
						local var_460_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_457_1.actors_[var_460_18.prefab_name].transform, "story_v_side_new_1109402", "1109402111", "story_v_side_new_1109402.awb")

						arg_457_1:RecordAudio("1109402111", var_460_24)
						arg_457_1:RecordAudio("1109402111", var_460_24)
					else
						arg_457_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402111", "story_v_side_new_1109402.awb")
					end

					arg_457_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402111", "story_v_side_new_1109402.awb")
				end

				arg_457_1:RecordContent(arg_457_1.text_.text)
			end

			local var_460_25 = math.max(var_460_16, arg_457_1.talkMaxDuration)

			if var_460_15 <= arg_457_1.time_ and arg_457_1.time_ < var_460_15 + var_460_25 then
				arg_457_1.typewritter.percent = (arg_457_1.time_ - var_460_15) / var_460_25

				arg_457_1.typewritter:SetDirty()
			end

			if arg_457_1.time_ >= var_460_15 + var_460_25 and arg_457_1.time_ < var_460_15 + var_460_25 + arg_460_0 then
				arg_457_1.typewritter.percent = 1

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(true)
			end
		end

		arg_457_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
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
	Play1109402112 = function(arg_461_0, arg_461_1)
		arg_461_1.time_ = 0
		arg_461_1.frameCnt_ = 0
		arg_461_1.state_ = "playing"
		arg_461_1.curTalkId_ = 1109402112
		arg_461_1.duration_ = 5.27

		local var_461_0 = {
			ja = 5.266,
			ko = 4.8,
			zh = 4.8
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
				arg_461_0:Play1109402113(arg_461_1)
			end
		end

		function arg_461_1.onSingleLineUpdate_(arg_464_0)
			local var_464_0 = arg_461_1.actors_["1094ui_story"]
			local var_464_1 = 0

			if var_464_1 < arg_461_1.time_ and arg_461_1.time_ <= var_464_1 + arg_464_0 and not isNil(var_464_0) and arg_461_1.var_.characterEffect1094ui_story == nil then
				arg_461_1.var_.characterEffect1094ui_story = var_464_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_464_2 = 0.200000002980232

			if var_464_1 <= arg_461_1.time_ and arg_461_1.time_ < var_464_1 + var_464_2 and not isNil(var_464_0) then
				local var_464_3 = (arg_461_1.time_ - var_464_1) / var_464_2

				if arg_461_1.var_.characterEffect1094ui_story and not isNil(var_464_0) then
					local var_464_4 = Mathf.Lerp(0, 0.5, var_464_3)

					arg_461_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_461_1.var_.characterEffect1094ui_story.fillRatio = var_464_4
				end
			end

			if arg_461_1.time_ >= var_464_1 + var_464_2 and arg_461_1.time_ < var_464_1 + var_464_2 + arg_464_0 and not isNil(var_464_0) and arg_461_1.var_.characterEffect1094ui_story then
				local var_464_5 = 0.5

				arg_461_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_461_1.var_.characterEffect1094ui_story.fillRatio = var_464_5
			end

			local var_464_6 = 0
			local var_464_7 = 0.575

			if var_464_6 < arg_461_1.time_ and arg_461_1.time_ <= var_464_6 + arg_464_0 then
				arg_461_1.talkMaxDuration = 0
				arg_461_1.dialogCg_.alpha = 1

				arg_461_1.dialog_:SetActive(true)
				SetActive(arg_461_1.leftNameGo_, true)

				local var_464_8 = arg_461_1:FormatText(StoryNameCfg[426].name)

				arg_461_1.leftNameTxt_.text = var_464_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_461_1.leftNameTxt_.transform)

				arg_461_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_461_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_461_1:RecordName(arg_461_1.leftNameTxt_.text)
				SetActive(arg_461_1.iconTrs_.gameObject, true)
				arg_461_1.iconController_:SetSelectedState("hero")

				arg_461_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenwa")

				arg_461_1.callingController_:SetSelectedState("normal")

				arg_461_1.keyicon_.color = Color.New(1, 1, 1)
				arg_461_1.icon_.color = Color.New(1, 1, 1)

				local var_464_9 = arg_461_1:GetWordFromCfg(1109402112)
				local var_464_10 = arg_461_1:FormatText(var_464_9.content)

				arg_461_1.text_.text = var_464_10

				LuaForUtil.ClearLinePrefixSymbol(arg_461_1.text_)

				local var_464_11 = 23
				local var_464_12 = utf8.len(var_464_10)
				local var_464_13 = var_464_11 <= 0 and var_464_7 or var_464_7 * (var_464_12 / var_464_11)

				if var_464_13 > 0 and var_464_7 < var_464_13 then
					arg_461_1.talkMaxDuration = var_464_13

					if var_464_13 + var_464_6 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_13 + var_464_6
					end
				end

				arg_461_1.text_.text = var_464_10
				arg_461_1.typewritter.percent = 0

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402112", "story_v_side_new_1109402.awb") ~= 0 then
					local var_464_14 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402112", "story_v_side_new_1109402.awb") / 1000

					if var_464_14 + var_464_6 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_14 + var_464_6
					end

					if var_464_9.prefab_name ~= "" and arg_461_1.actors_[var_464_9.prefab_name] ~= nil then
						local var_464_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_461_1.actors_[var_464_9.prefab_name].transform, "story_v_side_new_1109402", "1109402112", "story_v_side_new_1109402.awb")

						arg_461_1:RecordAudio("1109402112", var_464_15)
						arg_461_1:RecordAudio("1109402112", var_464_15)
					else
						arg_461_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402112", "story_v_side_new_1109402.awb")
					end

					arg_461_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402112", "story_v_side_new_1109402.awb")
				end

				arg_461_1:RecordContent(arg_461_1.text_.text)
			end

			local var_464_16 = math.max(var_464_7, arg_461_1.talkMaxDuration)

			if var_464_6 <= arg_461_1.time_ and arg_461_1.time_ < var_464_6 + var_464_16 then
				arg_461_1.typewritter.percent = (arg_461_1.time_ - var_464_6) / var_464_16

				arg_461_1.typewritter:SetDirty()
			end

			if arg_461_1.time_ >= var_464_6 + var_464_16 and arg_461_1.time_ < var_464_6 + var_464_16 + arg_464_0 then
				arg_461_1.typewritter.percent = 1

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(true)
			end
		end

		arg_461_1.nodeConfigList_ = {}

		arg_461_1:InitPlayNodeList()
	end,
	Play1109402113 = function(arg_465_0, arg_465_1)
		arg_465_1.time_ = 0
		arg_465_1.frameCnt_ = 0
		arg_465_1.state_ = "playing"
		arg_465_1.curTalkId_ = 1109402113
		arg_465_1.duration_ = 5

		SetActive(arg_465_1.tipsGo_, false)

		function arg_465_1.onSingleLineFinish_()
			arg_465_1.onSingleLineUpdate_ = nil
			arg_465_1.onSingleLineFinish_ = nil
			arg_465_1.state_ = "waiting"
		end

		function arg_465_1.playNext_(arg_467_0)
			if arg_467_0 == 1 then
				arg_465_0:Play1109402114(arg_465_1)
			end
		end

		function arg_465_1.onSingleLineUpdate_(arg_468_0)
			local var_468_0 = 0

			if var_468_0 < arg_465_1.time_ and arg_465_1.time_ <= var_468_0 + arg_468_0 then
				arg_465_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_468_1 = 0
			local var_468_2 = 0.6

			if var_468_1 < arg_465_1.time_ and arg_465_1.time_ <= var_468_1 + arg_468_0 then
				arg_465_1.talkMaxDuration = 0
				arg_465_1.dialogCg_.alpha = 1

				arg_465_1.dialog_:SetActive(true)
				SetActive(arg_465_1.leftNameGo_, false)

				arg_465_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_465_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_465_1:RecordName(arg_465_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_465_1.iconTrs_.gameObject, false)
				arg_465_1.callingController_:SetSelectedState("normal")

				local var_468_3 = arg_465_1:GetWordFromCfg(1109402113)
				local var_468_4 = arg_465_1:FormatText(var_468_3.content)

				arg_465_1.text_.text = var_468_4

				LuaForUtil.ClearLinePrefixSymbol(arg_465_1.text_)

				local var_468_5 = 24
				local var_468_6 = utf8.len(var_468_4)
				local var_468_7 = var_468_5 <= 0 and var_468_2 or var_468_2 * (var_468_6 / var_468_5)

				if var_468_7 > 0 and var_468_2 < var_468_7 then
					arg_465_1.talkMaxDuration = var_468_7

					if var_468_7 + var_468_1 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_7 + var_468_1
					end
				end

				arg_465_1.text_.text = var_468_4
				arg_465_1.typewritter.percent = 0

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(false)
				arg_465_1:RecordContent(arg_465_1.text_.text)
			end

			local var_468_8 = math.max(var_468_2, arg_465_1.talkMaxDuration)

			if var_468_1 <= arg_465_1.time_ and arg_465_1.time_ < var_468_1 + var_468_8 then
				arg_465_1.typewritter.percent = (arg_465_1.time_ - var_468_1) / var_468_8

				arg_465_1.typewritter:SetDirty()
			end

			if arg_465_1.time_ >= var_468_1 + var_468_8 and arg_465_1.time_ < var_468_1 + var_468_8 + arg_468_0 then
				arg_465_1.typewritter.percent = 1

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(true)
			end
		end

		arg_465_1.nodeConfigList_ = {}

		arg_465_1:InitPlayNodeList()
	end,
	Play1109402114 = function(arg_469_0, arg_469_1)
		arg_469_1.time_ = 0
		arg_469_1.frameCnt_ = 0
		arg_469_1.state_ = "playing"
		arg_469_1.curTalkId_ = 1109402114
		arg_469_1.duration_ = 5.23

		local var_469_0 = {
			ja = 5.233,
			ko = 3.566,
			zh = 3.566
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
				arg_469_0:Play1109402115(arg_469_1)
			end
		end

		function arg_469_1.onSingleLineUpdate_(arg_472_0)
			local var_472_0 = 0
			local var_472_1 = 0.325

			if var_472_0 < arg_469_1.time_ and arg_469_1.time_ <= var_472_0 + arg_472_0 then
				arg_469_1.talkMaxDuration = 0
				arg_469_1.dialogCg_.alpha = 1

				arg_469_1.dialog_:SetActive(true)
				SetActive(arg_469_1.leftNameGo_, true)

				local var_472_2 = arg_469_1:FormatText(StoryNameCfg[426].name)

				arg_469_1.leftNameTxt_.text = var_472_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_469_1.leftNameTxt_.transform)

				arg_469_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_469_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_469_1:RecordName(arg_469_1.leftNameTxt_.text)
				SetActive(arg_469_1.iconTrs_.gameObject, true)
				arg_469_1.iconController_:SetSelectedState("hero")

				arg_469_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenwa")

				arg_469_1.callingController_:SetSelectedState("normal")

				arg_469_1.keyicon_.color = Color.New(1, 1, 1)
				arg_469_1.icon_.color = Color.New(1, 1, 1)

				local var_472_3 = arg_469_1:GetWordFromCfg(1109402114)
				local var_472_4 = arg_469_1:FormatText(var_472_3.content)

				arg_469_1.text_.text = var_472_4

				LuaForUtil.ClearLinePrefixSymbol(arg_469_1.text_)

				local var_472_5 = 13
				local var_472_6 = utf8.len(var_472_4)
				local var_472_7 = var_472_5 <= 0 and var_472_1 or var_472_1 * (var_472_6 / var_472_5)

				if var_472_7 > 0 and var_472_1 < var_472_7 then
					arg_469_1.talkMaxDuration = var_472_7

					if var_472_7 + var_472_0 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_7 + var_472_0
					end
				end

				arg_469_1.text_.text = var_472_4
				arg_469_1.typewritter.percent = 0

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402114", "story_v_side_new_1109402.awb") ~= 0 then
					local var_472_8 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402114", "story_v_side_new_1109402.awb") / 1000

					if var_472_8 + var_472_0 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_8 + var_472_0
					end

					if var_472_3.prefab_name ~= "" and arg_469_1.actors_[var_472_3.prefab_name] ~= nil then
						local var_472_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_469_1.actors_[var_472_3.prefab_name].transform, "story_v_side_new_1109402", "1109402114", "story_v_side_new_1109402.awb")

						arg_469_1:RecordAudio("1109402114", var_472_9)
						arg_469_1:RecordAudio("1109402114", var_472_9)
					else
						arg_469_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402114", "story_v_side_new_1109402.awb")
					end

					arg_469_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402114", "story_v_side_new_1109402.awb")
				end

				arg_469_1:RecordContent(arg_469_1.text_.text)
			end

			local var_472_10 = math.max(var_472_1, arg_469_1.talkMaxDuration)

			if var_472_0 <= arg_469_1.time_ and arg_469_1.time_ < var_472_0 + var_472_10 then
				arg_469_1.typewritter.percent = (arg_469_1.time_ - var_472_0) / var_472_10

				arg_469_1.typewritter:SetDirty()
			end

			if arg_469_1.time_ >= var_472_0 + var_472_10 and arg_469_1.time_ < var_472_0 + var_472_10 + arg_472_0 then
				arg_469_1.typewritter.percent = 1

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(true)
			end
		end

		arg_469_1.nodeConfigList_ = {}

		arg_469_1:InitPlayNodeList()
	end,
	Play1109402115 = function(arg_473_0, arg_473_1)
		arg_473_1.time_ = 0
		arg_473_1.frameCnt_ = 0
		arg_473_1.state_ = "playing"
		arg_473_1.curTalkId_ = 1109402115
		arg_473_1.duration_ = 5

		SetActive(arg_473_1.tipsGo_, false)

		function arg_473_1.onSingleLineFinish_()
			arg_473_1.onSingleLineUpdate_ = nil
			arg_473_1.onSingleLineFinish_ = nil
			arg_473_1.state_ = "waiting"
		end

		function arg_473_1.playNext_(arg_475_0)
			if arg_475_0 == 1 then
				arg_473_0:Play1109402116(arg_473_1)
			end
		end

		function arg_473_1.onSingleLineUpdate_(arg_476_0)
			local var_476_0 = 0
			local var_476_1 = 0.8

			if var_476_0 < arg_473_1.time_ and arg_473_1.time_ <= var_476_0 + arg_476_0 then
				arg_473_1.talkMaxDuration = 0
				arg_473_1.dialogCg_.alpha = 1

				arg_473_1.dialog_:SetActive(true)
				SetActive(arg_473_1.leftNameGo_, false)

				arg_473_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_473_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_473_1:RecordName(arg_473_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_473_1.iconTrs_.gameObject, false)
				arg_473_1.callingController_:SetSelectedState("normal")

				local var_476_2 = arg_473_1:GetWordFromCfg(1109402115)
				local var_476_3 = arg_473_1:FormatText(var_476_2.content)

				arg_473_1.text_.text = var_476_3

				LuaForUtil.ClearLinePrefixSymbol(arg_473_1.text_)

				local var_476_4 = 32
				local var_476_5 = utf8.len(var_476_3)
				local var_476_6 = var_476_4 <= 0 and var_476_1 or var_476_1 * (var_476_5 / var_476_4)

				if var_476_6 > 0 and var_476_1 < var_476_6 then
					arg_473_1.talkMaxDuration = var_476_6

					if var_476_6 + var_476_0 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_6 + var_476_0
					end
				end

				arg_473_1.text_.text = var_476_3
				arg_473_1.typewritter.percent = 0

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(false)
				arg_473_1:RecordContent(arg_473_1.text_.text)
			end

			local var_476_7 = math.max(var_476_1, arg_473_1.talkMaxDuration)

			if var_476_0 <= arg_473_1.time_ and arg_473_1.time_ < var_476_0 + var_476_7 then
				arg_473_1.typewritter.percent = (arg_473_1.time_ - var_476_0) / var_476_7

				arg_473_1.typewritter:SetDirty()
			end

			if arg_473_1.time_ >= var_476_0 + var_476_7 and arg_473_1.time_ < var_476_0 + var_476_7 + arg_476_0 then
				arg_473_1.typewritter.percent = 1

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(true)
			end
		end

		arg_473_1.nodeConfigList_ = {}

		arg_473_1:InitPlayNodeList()
	end,
	Play1109402116 = function(arg_477_0, arg_477_1)
		arg_477_1.time_ = 0
		arg_477_1.frameCnt_ = 0
		arg_477_1.state_ = "playing"
		arg_477_1.curTalkId_ = 1109402116
		arg_477_1.duration_ = 2

		SetActive(arg_477_1.tipsGo_, false)

		function arg_477_1.onSingleLineFinish_()
			arg_477_1.onSingleLineUpdate_ = nil
			arg_477_1.onSingleLineFinish_ = nil
			arg_477_1.state_ = "waiting"
		end

		function arg_477_1.playNext_(arg_479_0)
			if arg_479_0 == 1 then
				arg_477_0:Play1109402117(arg_477_1)
			end
		end

		function arg_477_1.onSingleLineUpdate_(arg_480_0)
			local var_480_0 = arg_477_1.actors_["1094ui_story"].transform
			local var_480_1 = 0

			if var_480_1 < arg_477_1.time_ and arg_477_1.time_ <= var_480_1 + arg_480_0 then
				arg_477_1.var_.moveOldPos1094ui_story = var_480_0.localPosition
			end

			local var_480_2 = 0.001

			if var_480_1 <= arg_477_1.time_ and arg_477_1.time_ < var_480_1 + var_480_2 then
				local var_480_3 = (arg_477_1.time_ - var_480_1) / var_480_2
				local var_480_4 = Vector3.New(0, -0.84, -6.1)

				var_480_0.localPosition = Vector3.Lerp(arg_477_1.var_.moveOldPos1094ui_story, var_480_4, var_480_3)

				local var_480_5 = manager.ui.mainCamera.transform.position - var_480_0.position

				var_480_0.forward = Vector3.New(var_480_5.x, var_480_5.y, var_480_5.z)

				local var_480_6 = var_480_0.localEulerAngles

				var_480_6.z = 0
				var_480_6.x = 0
				var_480_0.localEulerAngles = var_480_6
			end

			if arg_477_1.time_ >= var_480_1 + var_480_2 and arg_477_1.time_ < var_480_1 + var_480_2 + arg_480_0 then
				var_480_0.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_480_7 = manager.ui.mainCamera.transform.position - var_480_0.position

				var_480_0.forward = Vector3.New(var_480_7.x, var_480_7.y, var_480_7.z)

				local var_480_8 = var_480_0.localEulerAngles

				var_480_8.z = 0
				var_480_8.x = 0
				var_480_0.localEulerAngles = var_480_8
			end

			local var_480_9 = arg_477_1.actors_["1094ui_story"]
			local var_480_10 = 0

			if var_480_10 < arg_477_1.time_ and arg_477_1.time_ <= var_480_10 + arg_480_0 and not isNil(var_480_9) and arg_477_1.var_.characterEffect1094ui_story == nil then
				arg_477_1.var_.characterEffect1094ui_story = var_480_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_480_11 = 0.200000002980232

			if var_480_10 <= arg_477_1.time_ and arg_477_1.time_ < var_480_10 + var_480_11 and not isNil(var_480_9) then
				local var_480_12 = (arg_477_1.time_ - var_480_10) / var_480_11

				if arg_477_1.var_.characterEffect1094ui_story and not isNil(var_480_9) then
					arg_477_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_477_1.time_ >= var_480_10 + var_480_11 and arg_477_1.time_ < var_480_10 + var_480_11 + arg_480_0 and not isNil(var_480_9) and arg_477_1.var_.characterEffect1094ui_story then
				arg_477_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_480_13 = 0

			if var_480_13 < arg_477_1.time_ and arg_477_1.time_ <= var_480_13 + arg_480_0 then
				arg_477_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action4_2")
			end

			local var_480_14 = 0

			if var_480_14 < arg_477_1.time_ and arg_477_1.time_ <= var_480_14 + arg_480_0 then
				arg_477_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_480_15 = 0
			local var_480_16 = 0.1

			if var_480_15 < arg_477_1.time_ and arg_477_1.time_ <= var_480_15 + arg_480_0 then
				arg_477_1.talkMaxDuration = 0
				arg_477_1.dialogCg_.alpha = 1

				arg_477_1.dialog_:SetActive(true)
				SetActive(arg_477_1.leftNameGo_, true)

				local var_480_17 = arg_477_1:FormatText(StoryNameCfg[181].name)

				arg_477_1.leftNameTxt_.text = var_480_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_477_1.leftNameTxt_.transform)

				arg_477_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_477_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_477_1:RecordName(arg_477_1.leftNameTxt_.text)
				SetActive(arg_477_1.iconTrs_.gameObject, false)
				arg_477_1.callingController_:SetSelectedState("normal")

				local var_480_18 = arg_477_1:GetWordFromCfg(1109402116)
				local var_480_19 = arg_477_1:FormatText(var_480_18.content)

				arg_477_1.text_.text = var_480_19

				LuaForUtil.ClearLinePrefixSymbol(arg_477_1.text_)

				local var_480_20 = 4
				local var_480_21 = utf8.len(var_480_19)
				local var_480_22 = var_480_20 <= 0 and var_480_16 or var_480_16 * (var_480_21 / var_480_20)

				if var_480_22 > 0 and var_480_16 < var_480_22 then
					arg_477_1.talkMaxDuration = var_480_22

					if var_480_22 + var_480_15 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_22 + var_480_15
					end
				end

				arg_477_1.text_.text = var_480_19
				arg_477_1.typewritter.percent = 0

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402116", "story_v_side_new_1109402.awb") ~= 0 then
					local var_480_23 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402116", "story_v_side_new_1109402.awb") / 1000

					if var_480_23 + var_480_15 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_23 + var_480_15
					end

					if var_480_18.prefab_name ~= "" and arg_477_1.actors_[var_480_18.prefab_name] ~= nil then
						local var_480_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_477_1.actors_[var_480_18.prefab_name].transform, "story_v_side_new_1109402", "1109402116", "story_v_side_new_1109402.awb")

						arg_477_1:RecordAudio("1109402116", var_480_24)
						arg_477_1:RecordAudio("1109402116", var_480_24)
					else
						arg_477_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402116", "story_v_side_new_1109402.awb")
					end

					arg_477_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402116", "story_v_side_new_1109402.awb")
				end

				arg_477_1:RecordContent(arg_477_1.text_.text)
			end

			local var_480_25 = math.max(var_480_16, arg_477_1.talkMaxDuration)

			if var_480_15 <= arg_477_1.time_ and arg_477_1.time_ < var_480_15 + var_480_25 then
				arg_477_1.typewritter.percent = (arg_477_1.time_ - var_480_15) / var_480_25

				arg_477_1.typewritter:SetDirty()
			end

			if arg_477_1.time_ >= var_480_15 + var_480_25 and arg_477_1.time_ < var_480_15 + var_480_25 + arg_480_0 then
				arg_477_1.typewritter.percent = 1

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(true)
			end
		end

		arg_477_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_477_1:InitPlayNodeList()
	end,
	Play1109402117 = function(arg_481_0, arg_481_1)
		arg_481_1.time_ = 0
		arg_481_1.frameCnt_ = 0
		arg_481_1.state_ = "playing"
		arg_481_1.curTalkId_ = 1109402117
		arg_481_1.duration_ = 7.07

		local var_481_0 = {
			ja = 7.066,
			ko = 6.166,
			zh = 6.166
		}
		local var_481_1 = manager.audio:GetLocalizationFlag()

		if var_481_0[var_481_1] ~= nil then
			arg_481_1.duration_ = var_481_0[var_481_1]
		end

		SetActive(arg_481_1.tipsGo_, false)

		function arg_481_1.onSingleLineFinish_()
			arg_481_1.onSingleLineUpdate_ = nil
			arg_481_1.onSingleLineFinish_ = nil
			arg_481_1.state_ = "waiting"
		end

		function arg_481_1.playNext_(arg_483_0)
			if arg_483_0 == 1 then
				arg_481_0:Play1109402118(arg_481_1)
			end
		end

		function arg_481_1.onSingleLineUpdate_(arg_484_0)
			local var_484_0 = arg_481_1.actors_["1094ui_story"]
			local var_484_1 = 0

			if var_484_1 < arg_481_1.time_ and arg_481_1.time_ <= var_484_1 + arg_484_0 and not isNil(var_484_0) and arg_481_1.var_.characterEffect1094ui_story == nil then
				arg_481_1.var_.characterEffect1094ui_story = var_484_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_484_2 = 0.200000002980232

			if var_484_1 <= arg_481_1.time_ and arg_481_1.time_ < var_484_1 + var_484_2 and not isNil(var_484_0) then
				local var_484_3 = (arg_481_1.time_ - var_484_1) / var_484_2

				if arg_481_1.var_.characterEffect1094ui_story and not isNil(var_484_0) then
					local var_484_4 = Mathf.Lerp(0, 0.5, var_484_3)

					arg_481_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_481_1.var_.characterEffect1094ui_story.fillRatio = var_484_4
				end
			end

			if arg_481_1.time_ >= var_484_1 + var_484_2 and arg_481_1.time_ < var_484_1 + var_484_2 + arg_484_0 and not isNil(var_484_0) and arg_481_1.var_.characterEffect1094ui_story then
				local var_484_5 = 0.5

				arg_481_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_481_1.var_.characterEffect1094ui_story.fillRatio = var_484_5
			end

			local var_484_6 = 0
			local var_484_7 = 0.825

			if var_484_6 < arg_481_1.time_ and arg_481_1.time_ <= var_484_6 + arg_484_0 then
				arg_481_1.talkMaxDuration = 0
				arg_481_1.dialogCg_.alpha = 1

				arg_481_1.dialog_:SetActive(true)
				SetActive(arg_481_1.leftNameGo_, true)

				local var_484_8 = arg_481_1:FormatText(StoryNameCfg[426].name)

				arg_481_1.leftNameTxt_.text = var_484_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_481_1.leftNameTxt_.transform)

				arg_481_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_481_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_481_1:RecordName(arg_481_1.leftNameTxt_.text)
				SetActive(arg_481_1.iconTrs_.gameObject, true)
				arg_481_1.iconController_:SetSelectedState("hero")

				arg_481_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenwa")

				arg_481_1.callingController_:SetSelectedState("normal")

				arg_481_1.keyicon_.color = Color.New(1, 1, 1)
				arg_481_1.icon_.color = Color.New(1, 1, 1)

				local var_484_9 = arg_481_1:GetWordFromCfg(1109402117)
				local var_484_10 = arg_481_1:FormatText(var_484_9.content)

				arg_481_1.text_.text = var_484_10

				LuaForUtil.ClearLinePrefixSymbol(arg_481_1.text_)

				local var_484_11 = 33
				local var_484_12 = utf8.len(var_484_10)
				local var_484_13 = var_484_11 <= 0 and var_484_7 or var_484_7 * (var_484_12 / var_484_11)

				if var_484_13 > 0 and var_484_7 < var_484_13 then
					arg_481_1.talkMaxDuration = var_484_13

					if var_484_13 + var_484_6 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_13 + var_484_6
					end
				end

				arg_481_1.text_.text = var_484_10
				arg_481_1.typewritter.percent = 0

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402117", "story_v_side_new_1109402.awb") ~= 0 then
					local var_484_14 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402117", "story_v_side_new_1109402.awb") / 1000

					if var_484_14 + var_484_6 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_14 + var_484_6
					end

					if var_484_9.prefab_name ~= "" and arg_481_1.actors_[var_484_9.prefab_name] ~= nil then
						local var_484_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_481_1.actors_[var_484_9.prefab_name].transform, "story_v_side_new_1109402", "1109402117", "story_v_side_new_1109402.awb")

						arg_481_1:RecordAudio("1109402117", var_484_15)
						arg_481_1:RecordAudio("1109402117", var_484_15)
					else
						arg_481_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402117", "story_v_side_new_1109402.awb")
					end

					arg_481_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402117", "story_v_side_new_1109402.awb")
				end

				arg_481_1:RecordContent(arg_481_1.text_.text)
			end

			local var_484_16 = math.max(var_484_7, arg_481_1.talkMaxDuration)

			if var_484_6 <= arg_481_1.time_ and arg_481_1.time_ < var_484_6 + var_484_16 then
				arg_481_1.typewritter.percent = (arg_481_1.time_ - var_484_6) / var_484_16

				arg_481_1.typewritter:SetDirty()
			end

			if arg_481_1.time_ >= var_484_6 + var_484_16 and arg_481_1.time_ < var_484_6 + var_484_16 + arg_484_0 then
				arg_481_1.typewritter.percent = 1

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(true)
			end
		end

		arg_481_1.nodeConfigList_ = {}

		arg_481_1:InitPlayNodeList()
	end,
	Play1109402118 = function(arg_485_0, arg_485_1)
		arg_485_1.time_ = 0
		arg_485_1.frameCnt_ = 0
		arg_485_1.state_ = "playing"
		arg_485_1.curTalkId_ = 1109402118
		arg_485_1.duration_ = 6.73

		local var_485_0 = {
			ja = 3.566,
			ko = 6.733,
			zh = 6.733
		}
		local var_485_1 = manager.audio:GetLocalizationFlag()

		if var_485_0[var_485_1] ~= nil then
			arg_485_1.duration_ = var_485_0[var_485_1]
		end

		SetActive(arg_485_1.tipsGo_, false)

		function arg_485_1.onSingleLineFinish_()
			arg_485_1.onSingleLineUpdate_ = nil
			arg_485_1.onSingleLineFinish_ = nil
			arg_485_1.state_ = "waiting"
		end

		function arg_485_1.playNext_(arg_487_0)
			if arg_487_0 == 1 then
				arg_485_0:Play1109402119(arg_485_1)
			end
		end

		function arg_485_1.onSingleLineUpdate_(arg_488_0)
			local var_488_0 = 0
			local var_488_1 = 0.55

			if var_488_0 < arg_485_1.time_ and arg_485_1.time_ <= var_488_0 + arg_488_0 then
				arg_485_1.talkMaxDuration = 0
				arg_485_1.dialogCg_.alpha = 1

				arg_485_1.dialog_:SetActive(true)
				SetActive(arg_485_1.leftNameGo_, true)

				local var_488_2 = arg_485_1:FormatText(StoryNameCfg[189].name)

				arg_485_1.leftNameTxt_.text = var_488_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_485_1.leftNameTxt_.transform)

				arg_485_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_485_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_485_1:RecordName(arg_485_1.leftNameTxt_.text)
				SetActive(arg_485_1.iconTrs_.gameObject, true)
				arg_485_1.iconController_:SetSelectedState("hero")

				arg_485_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vina")

				arg_485_1.callingController_:SetSelectedState("normal")

				arg_485_1.keyicon_.color = Color.New(1, 1, 1)
				arg_485_1.icon_.color = Color.New(1, 1, 1)

				local var_488_3 = arg_485_1:GetWordFromCfg(1109402118)
				local var_488_4 = arg_485_1:FormatText(var_488_3.content)

				arg_485_1.text_.text = var_488_4

				LuaForUtil.ClearLinePrefixSymbol(arg_485_1.text_)

				local var_488_5 = 22
				local var_488_6 = utf8.len(var_488_4)
				local var_488_7 = var_488_5 <= 0 and var_488_1 or var_488_1 * (var_488_6 / var_488_5)

				if var_488_7 > 0 and var_488_1 < var_488_7 then
					arg_485_1.talkMaxDuration = var_488_7

					if var_488_7 + var_488_0 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_7 + var_488_0
					end
				end

				arg_485_1.text_.text = var_488_4
				arg_485_1.typewritter.percent = 0

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402118", "story_v_side_new_1109402.awb") ~= 0 then
					local var_488_8 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402118", "story_v_side_new_1109402.awb") / 1000

					if var_488_8 + var_488_0 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_8 + var_488_0
					end

					if var_488_3.prefab_name ~= "" and arg_485_1.actors_[var_488_3.prefab_name] ~= nil then
						local var_488_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_485_1.actors_[var_488_3.prefab_name].transform, "story_v_side_new_1109402", "1109402118", "story_v_side_new_1109402.awb")

						arg_485_1:RecordAudio("1109402118", var_488_9)
						arg_485_1:RecordAudio("1109402118", var_488_9)
					else
						arg_485_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402118", "story_v_side_new_1109402.awb")
					end

					arg_485_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402118", "story_v_side_new_1109402.awb")
				end

				arg_485_1:RecordContent(arg_485_1.text_.text)
			end

			local var_488_10 = math.max(var_488_1, arg_485_1.talkMaxDuration)

			if var_488_0 <= arg_485_1.time_ and arg_485_1.time_ < var_488_0 + var_488_10 then
				arg_485_1.typewritter.percent = (arg_485_1.time_ - var_488_0) / var_488_10

				arg_485_1.typewritter:SetDirty()
			end

			if arg_485_1.time_ >= var_488_0 + var_488_10 and arg_485_1.time_ < var_488_0 + var_488_10 + arg_488_0 then
				arg_485_1.typewritter.percent = 1

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(true)
			end
		end

		arg_485_1.nodeConfigList_ = {}

		arg_485_1:InitPlayNodeList()
	end,
	Play1109402119 = function(arg_489_0, arg_489_1)
		arg_489_1.time_ = 0
		arg_489_1.frameCnt_ = 0
		arg_489_1.state_ = "playing"
		arg_489_1.curTalkId_ = 1109402119
		arg_489_1.duration_ = 9.8

		local var_489_0 = {
			ja = 9.8,
			ko = 6.6,
			zh = 6.6
		}
		local var_489_1 = manager.audio:GetLocalizationFlag()

		if var_489_0[var_489_1] ~= nil then
			arg_489_1.duration_ = var_489_0[var_489_1]
		end

		SetActive(arg_489_1.tipsGo_, false)

		function arg_489_1.onSingleLineFinish_()
			arg_489_1.onSingleLineUpdate_ = nil
			arg_489_1.onSingleLineFinish_ = nil
			arg_489_1.state_ = "waiting"
		end

		function arg_489_1.playNext_(arg_491_0)
			if arg_491_0 == 1 then
				arg_489_0:Play1109402120(arg_489_1)
			end
		end

		function arg_489_1.onSingleLineUpdate_(arg_492_0)
			local var_492_0 = 0
			local var_492_1 = 0.775

			if var_492_0 < arg_489_1.time_ and arg_489_1.time_ <= var_492_0 + arg_492_0 then
				arg_489_1.talkMaxDuration = 0
				arg_489_1.dialogCg_.alpha = 1

				arg_489_1.dialog_:SetActive(true)
				SetActive(arg_489_1.leftNameGo_, true)

				local var_492_2 = arg_489_1:FormatText(StoryNameCfg[426].name)

				arg_489_1.leftNameTxt_.text = var_492_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_489_1.leftNameTxt_.transform)

				arg_489_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_489_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_489_1:RecordName(arg_489_1.leftNameTxt_.text)
				SetActive(arg_489_1.iconTrs_.gameObject, true)
				arg_489_1.iconController_:SetSelectedState("hero")

				arg_489_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenwa")

				arg_489_1.callingController_:SetSelectedState("normal")

				arg_489_1.keyicon_.color = Color.New(1, 1, 1)
				arg_489_1.icon_.color = Color.New(1, 1, 1)

				local var_492_3 = arg_489_1:GetWordFromCfg(1109402119)
				local var_492_4 = arg_489_1:FormatText(var_492_3.content)

				arg_489_1.text_.text = var_492_4

				LuaForUtil.ClearLinePrefixSymbol(arg_489_1.text_)

				local var_492_5 = 31
				local var_492_6 = utf8.len(var_492_4)
				local var_492_7 = var_492_5 <= 0 and var_492_1 or var_492_1 * (var_492_6 / var_492_5)

				if var_492_7 > 0 and var_492_1 < var_492_7 then
					arg_489_1.talkMaxDuration = var_492_7

					if var_492_7 + var_492_0 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_7 + var_492_0
					end
				end

				arg_489_1.text_.text = var_492_4
				arg_489_1.typewritter.percent = 0

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402119", "story_v_side_new_1109402.awb") ~= 0 then
					local var_492_8 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402119", "story_v_side_new_1109402.awb") / 1000

					if var_492_8 + var_492_0 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_8 + var_492_0
					end

					if var_492_3.prefab_name ~= "" and arg_489_1.actors_[var_492_3.prefab_name] ~= nil then
						local var_492_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_489_1.actors_[var_492_3.prefab_name].transform, "story_v_side_new_1109402", "1109402119", "story_v_side_new_1109402.awb")

						arg_489_1:RecordAudio("1109402119", var_492_9)
						arg_489_1:RecordAudio("1109402119", var_492_9)
					else
						arg_489_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402119", "story_v_side_new_1109402.awb")
					end

					arg_489_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402119", "story_v_side_new_1109402.awb")
				end

				arg_489_1:RecordContent(arg_489_1.text_.text)
			end

			local var_492_10 = math.max(var_492_1, arg_489_1.talkMaxDuration)

			if var_492_0 <= arg_489_1.time_ and arg_489_1.time_ < var_492_0 + var_492_10 then
				arg_489_1.typewritter.percent = (arg_489_1.time_ - var_492_0) / var_492_10

				arg_489_1.typewritter:SetDirty()
			end

			if arg_489_1.time_ >= var_492_0 + var_492_10 and arg_489_1.time_ < var_492_0 + var_492_10 + arg_492_0 then
				arg_489_1.typewritter.percent = 1

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(true)
			end
		end

		arg_489_1.nodeConfigList_ = {}

		arg_489_1:InitPlayNodeList()
	end,
	Play1109402120 = function(arg_493_0, arg_493_1)
		arg_493_1.time_ = 0
		arg_493_1.frameCnt_ = 0
		arg_493_1.state_ = "playing"
		arg_493_1.curTalkId_ = 1109402120
		arg_493_1.duration_ = 5

		SetActive(arg_493_1.tipsGo_, false)

		function arg_493_1.onSingleLineFinish_()
			arg_493_1.onSingleLineUpdate_ = nil
			arg_493_1.onSingleLineFinish_ = nil
			arg_493_1.state_ = "waiting"
		end

		function arg_493_1.playNext_(arg_495_0)
			if arg_495_0 == 1 then
				arg_493_0:Play1109402121(arg_493_1)
			end
		end

		function arg_493_1.onSingleLineUpdate_(arg_496_0)
			local var_496_0 = 0
			local var_496_1 = 0.55

			if var_496_0 < arg_493_1.time_ and arg_493_1.time_ <= var_496_0 + arg_496_0 then
				arg_493_1.talkMaxDuration = 0
				arg_493_1.dialogCg_.alpha = 1

				arg_493_1.dialog_:SetActive(true)
				SetActive(arg_493_1.leftNameGo_, true)

				local var_496_2 = arg_493_1:FormatText(StoryNameCfg[7].name)

				arg_493_1.leftNameTxt_.text = var_496_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_493_1.leftNameTxt_.transform)

				arg_493_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_493_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_493_1:RecordName(arg_493_1.leftNameTxt_.text)
				SetActive(arg_493_1.iconTrs_.gameObject, true)
				arg_493_1.iconController_:SetSelectedState("hero")

				arg_493_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_493_1.callingController_:SetSelectedState("normal")

				arg_493_1.keyicon_.color = Color.New(1, 1, 1)
				arg_493_1.icon_.color = Color.New(1, 1, 1)

				local var_496_3 = arg_493_1:GetWordFromCfg(1109402120)
				local var_496_4 = arg_493_1:FormatText(var_496_3.content)

				arg_493_1.text_.text = var_496_4

				LuaForUtil.ClearLinePrefixSymbol(arg_493_1.text_)

				local var_496_5 = 22
				local var_496_6 = utf8.len(var_496_4)
				local var_496_7 = var_496_5 <= 0 and var_496_1 or var_496_1 * (var_496_6 / var_496_5)

				if var_496_7 > 0 and var_496_1 < var_496_7 then
					arg_493_1.talkMaxDuration = var_496_7

					if var_496_7 + var_496_0 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_7 + var_496_0
					end
				end

				arg_493_1.text_.text = var_496_4
				arg_493_1.typewritter.percent = 0

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(false)
				arg_493_1:RecordContent(arg_493_1.text_.text)
			end

			local var_496_8 = math.max(var_496_1, arg_493_1.talkMaxDuration)

			if var_496_0 <= arg_493_1.time_ and arg_493_1.time_ < var_496_0 + var_496_8 then
				arg_493_1.typewritter.percent = (arg_493_1.time_ - var_496_0) / var_496_8

				arg_493_1.typewritter:SetDirty()
			end

			if arg_493_1.time_ >= var_496_0 + var_496_8 and arg_493_1.time_ < var_496_0 + var_496_8 + arg_496_0 then
				arg_493_1.typewritter.percent = 1

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(true)
			end
		end

		arg_493_1.nodeConfigList_ = {}

		arg_493_1:InitPlayNodeList()
	end,
	Play1109402121 = function(arg_497_0, arg_497_1)
		arg_497_1.time_ = 0
		arg_497_1.frameCnt_ = 0
		arg_497_1.state_ = "playing"
		arg_497_1.curTalkId_ = 1109402121
		arg_497_1.duration_ = 2.93

		local var_497_0 = {
			ja = 2.833,
			ko = 2.933,
			zh = 2.933
		}
		local var_497_1 = manager.audio:GetLocalizationFlag()

		if var_497_0[var_497_1] ~= nil then
			arg_497_1.duration_ = var_497_0[var_497_1]
		end

		SetActive(arg_497_1.tipsGo_, false)

		function arg_497_1.onSingleLineFinish_()
			arg_497_1.onSingleLineUpdate_ = nil
			arg_497_1.onSingleLineFinish_ = nil
			arg_497_1.state_ = "waiting"
		end

		function arg_497_1.playNext_(arg_499_0)
			if arg_499_0 == 1 then
				arg_497_0:Play1109402122(arg_497_1)
			end
		end

		function arg_497_1.onSingleLineUpdate_(arg_500_0)
			local var_500_0 = 0

			if var_500_0 < arg_497_1.time_ and arg_497_1.time_ <= var_500_0 + arg_500_0 then
				arg_497_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action5_1")
			end

			local var_500_1 = 0
			local var_500_2 = 0.325

			if var_500_1 < arg_497_1.time_ and arg_497_1.time_ <= var_500_1 + arg_500_0 then
				arg_497_1.talkMaxDuration = 0
				arg_497_1.dialogCg_.alpha = 1

				arg_497_1.dialog_:SetActive(true)
				SetActive(arg_497_1.leftNameGo_, true)

				local var_500_3 = arg_497_1:FormatText(StoryNameCfg[426].name)

				arg_497_1.leftNameTxt_.text = var_500_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_497_1.leftNameTxt_.transform)

				arg_497_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_497_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_497_1:RecordName(arg_497_1.leftNameTxt_.text)
				SetActive(arg_497_1.iconTrs_.gameObject, true)
				arg_497_1.iconController_:SetSelectedState("hero")

				arg_497_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenwa")

				arg_497_1.callingController_:SetSelectedState("normal")

				arg_497_1.keyicon_.color = Color.New(1, 1, 1)
				arg_497_1.icon_.color = Color.New(1, 1, 1)

				local var_500_4 = arg_497_1:GetWordFromCfg(1109402121)
				local var_500_5 = arg_497_1:FormatText(var_500_4.content)

				arg_497_1.text_.text = var_500_5

				LuaForUtil.ClearLinePrefixSymbol(arg_497_1.text_)

				local var_500_6 = 13
				local var_500_7 = utf8.len(var_500_5)
				local var_500_8 = var_500_6 <= 0 and var_500_2 or var_500_2 * (var_500_7 / var_500_6)

				if var_500_8 > 0 and var_500_2 < var_500_8 then
					arg_497_1.talkMaxDuration = var_500_8

					if var_500_8 + var_500_1 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_8 + var_500_1
					end
				end

				arg_497_1.text_.text = var_500_5
				arg_497_1.typewritter.percent = 0

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402121", "story_v_side_new_1109402.awb") ~= 0 then
					local var_500_9 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402121", "story_v_side_new_1109402.awb") / 1000

					if var_500_9 + var_500_1 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_9 + var_500_1
					end

					if var_500_4.prefab_name ~= "" and arg_497_1.actors_[var_500_4.prefab_name] ~= nil then
						local var_500_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_497_1.actors_[var_500_4.prefab_name].transform, "story_v_side_new_1109402", "1109402121", "story_v_side_new_1109402.awb")

						arg_497_1:RecordAudio("1109402121", var_500_10)
						arg_497_1:RecordAudio("1109402121", var_500_10)
					else
						arg_497_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402121", "story_v_side_new_1109402.awb")
					end

					arg_497_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402121", "story_v_side_new_1109402.awb")
				end

				arg_497_1:RecordContent(arg_497_1.text_.text)
			end

			local var_500_11 = math.max(var_500_2, arg_497_1.talkMaxDuration)

			if var_500_1 <= arg_497_1.time_ and arg_497_1.time_ < var_500_1 + var_500_11 then
				arg_497_1.typewritter.percent = (arg_497_1.time_ - var_500_1) / var_500_11

				arg_497_1.typewritter:SetDirty()
			end

			if arg_497_1.time_ >= var_500_1 + var_500_11 and arg_497_1.time_ < var_500_1 + var_500_11 + arg_500_0 then
				arg_497_1.typewritter.percent = 1

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(true)
			end
		end

		arg_497_1.nodeConfigList_ = {}

		arg_497_1:InitPlayNodeList()
	end,
	Play1109402122 = function(arg_501_0, arg_501_1)
		arg_501_1.time_ = 0
		arg_501_1.frameCnt_ = 0
		arg_501_1.state_ = "playing"
		arg_501_1.curTalkId_ = 1109402122
		arg_501_1.duration_ = 5

		SetActive(arg_501_1.tipsGo_, false)

		function arg_501_1.onSingleLineFinish_()
			arg_501_1.onSingleLineUpdate_ = nil
			arg_501_1.onSingleLineFinish_ = nil
			arg_501_1.state_ = "waiting"
		end

		function arg_501_1.playNext_(arg_503_0)
			if arg_503_0 == 1 then
				arg_501_0:Play1109402123(arg_501_1)
			end
		end

		function arg_501_1.onSingleLineUpdate_(arg_504_0)
			local var_504_0 = 0
			local var_504_1 = 0.45

			if var_504_0 < arg_501_1.time_ and arg_501_1.time_ <= var_504_0 + arg_504_0 then
				arg_501_1.talkMaxDuration = 0
				arg_501_1.dialogCg_.alpha = 1

				arg_501_1.dialog_:SetActive(true)
				SetActive(arg_501_1.leftNameGo_, true)

				local var_504_2 = arg_501_1:FormatText(StoryNameCfg[7].name)

				arg_501_1.leftNameTxt_.text = var_504_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_501_1.leftNameTxt_.transform)

				arg_501_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_501_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_501_1:RecordName(arg_501_1.leftNameTxt_.text)
				SetActive(arg_501_1.iconTrs_.gameObject, true)
				arg_501_1.iconController_:SetSelectedState("hero")

				arg_501_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_501_1.callingController_:SetSelectedState("normal")

				arg_501_1.keyicon_.color = Color.New(1, 1, 1)
				arg_501_1.icon_.color = Color.New(1, 1, 1)

				local var_504_3 = arg_501_1:GetWordFromCfg(1109402122)
				local var_504_4 = arg_501_1:FormatText(var_504_3.content)

				arg_501_1.text_.text = var_504_4

				LuaForUtil.ClearLinePrefixSymbol(arg_501_1.text_)

				local var_504_5 = 18
				local var_504_6 = utf8.len(var_504_4)
				local var_504_7 = var_504_5 <= 0 and var_504_1 or var_504_1 * (var_504_6 / var_504_5)

				if var_504_7 > 0 and var_504_1 < var_504_7 then
					arg_501_1.talkMaxDuration = var_504_7

					if var_504_7 + var_504_0 > arg_501_1.duration_ then
						arg_501_1.duration_ = var_504_7 + var_504_0
					end
				end

				arg_501_1.text_.text = var_504_4
				arg_501_1.typewritter.percent = 0

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(false)
				arg_501_1:RecordContent(arg_501_1.text_.text)
			end

			local var_504_8 = math.max(var_504_1, arg_501_1.talkMaxDuration)

			if var_504_0 <= arg_501_1.time_ and arg_501_1.time_ < var_504_0 + var_504_8 then
				arg_501_1.typewritter.percent = (arg_501_1.time_ - var_504_0) / var_504_8

				arg_501_1.typewritter:SetDirty()
			end

			if arg_501_1.time_ >= var_504_0 + var_504_8 and arg_501_1.time_ < var_504_0 + var_504_8 + arg_504_0 then
				arg_501_1.typewritter.percent = 1

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(true)
			end
		end

		arg_501_1.nodeConfigList_ = {}

		arg_501_1:InitPlayNodeList()
	end,
	Play1109402123 = function(arg_505_0, arg_505_1)
		arg_505_1.time_ = 0
		arg_505_1.frameCnt_ = 0
		arg_505_1.state_ = "playing"
		arg_505_1.curTalkId_ = 1109402123
		arg_505_1.duration_ = 5

		SetActive(arg_505_1.tipsGo_, false)

		function arg_505_1.onSingleLineFinish_()
			arg_505_1.onSingleLineUpdate_ = nil
			arg_505_1.onSingleLineFinish_ = nil
			arg_505_1.state_ = "waiting"
		end

		function arg_505_1.playNext_(arg_507_0)
			if arg_507_0 == 1 then
				arg_505_0:Play1109402124(arg_505_1)
			end
		end

		function arg_505_1.onSingleLineUpdate_(arg_508_0)
			local var_508_0 = 0
			local var_508_1 = 0.375

			if var_508_0 < arg_505_1.time_ and arg_505_1.time_ <= var_508_0 + arg_508_0 then
				arg_505_1.talkMaxDuration = 0
				arg_505_1.dialogCg_.alpha = 1

				arg_505_1.dialog_:SetActive(true)
				SetActive(arg_505_1.leftNameGo_, false)

				arg_505_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_505_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_505_1:RecordName(arg_505_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_505_1.iconTrs_.gameObject, false)
				arg_505_1.callingController_:SetSelectedState("normal")

				local var_508_2 = arg_505_1:GetWordFromCfg(1109402123)
				local var_508_3 = arg_505_1:FormatText(var_508_2.content)

				arg_505_1.text_.text = var_508_3

				LuaForUtil.ClearLinePrefixSymbol(arg_505_1.text_)

				local var_508_4 = 15
				local var_508_5 = utf8.len(var_508_3)
				local var_508_6 = var_508_4 <= 0 and var_508_1 or var_508_1 * (var_508_5 / var_508_4)

				if var_508_6 > 0 and var_508_1 < var_508_6 then
					arg_505_1.talkMaxDuration = var_508_6

					if var_508_6 + var_508_0 > arg_505_1.duration_ then
						arg_505_1.duration_ = var_508_6 + var_508_0
					end
				end

				arg_505_1.text_.text = var_508_3
				arg_505_1.typewritter.percent = 0

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(false)
				arg_505_1:RecordContent(arg_505_1.text_.text)
			end

			local var_508_7 = math.max(var_508_1, arg_505_1.talkMaxDuration)

			if var_508_0 <= arg_505_1.time_ and arg_505_1.time_ < var_508_0 + var_508_7 then
				arg_505_1.typewritter.percent = (arg_505_1.time_ - var_508_0) / var_508_7

				arg_505_1.typewritter:SetDirty()
			end

			if arg_505_1.time_ >= var_508_0 + var_508_7 and arg_505_1.time_ < var_508_0 + var_508_7 + arg_508_0 then
				arg_505_1.typewritter.percent = 1

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(true)
			end
		end

		arg_505_1.nodeConfigList_ = {}

		arg_505_1:InitPlayNodeList()
	end,
	Play1109402124 = function(arg_509_0, arg_509_1)
		arg_509_1.time_ = 0
		arg_509_1.frameCnt_ = 0
		arg_509_1.state_ = "playing"
		arg_509_1.curTalkId_ = 1109402124
		arg_509_1.duration_ = 6.27

		local var_509_0 = {
			ja = 6.266,
			ko = 6,
			zh = 6
		}
		local var_509_1 = manager.audio:GetLocalizationFlag()

		if var_509_0[var_509_1] ~= nil then
			arg_509_1.duration_ = var_509_0[var_509_1]
		end

		SetActive(arg_509_1.tipsGo_, false)

		function arg_509_1.onSingleLineFinish_()
			arg_509_1.onSingleLineUpdate_ = nil
			arg_509_1.onSingleLineFinish_ = nil
			arg_509_1.state_ = "waiting"
		end

		function arg_509_1.playNext_(arg_511_0)
			if arg_511_0 == 1 then
				arg_509_0:Play1109402125(arg_509_1)
			end
		end

		function arg_509_1.onSingleLineUpdate_(arg_512_0)
			local var_512_0 = 0
			local var_512_1 = 0.675

			if var_512_0 < arg_509_1.time_ and arg_509_1.time_ <= var_512_0 + arg_512_0 then
				arg_509_1.talkMaxDuration = 0
				arg_509_1.dialogCg_.alpha = 1

				arg_509_1.dialog_:SetActive(true)
				SetActive(arg_509_1.leftNameGo_, true)

				local var_512_2 = arg_509_1:FormatText(StoryNameCfg[426].name)

				arg_509_1.leftNameTxt_.text = var_512_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_509_1.leftNameTxt_.transform)

				arg_509_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_509_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_509_1:RecordName(arg_509_1.leftNameTxt_.text)
				SetActive(arg_509_1.iconTrs_.gameObject, true)
				arg_509_1.iconController_:SetSelectedState("hero")

				arg_509_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenwa")

				arg_509_1.callingController_:SetSelectedState("normal")

				arg_509_1.keyicon_.color = Color.New(1, 1, 1)
				arg_509_1.icon_.color = Color.New(1, 1, 1)

				local var_512_3 = arg_509_1:GetWordFromCfg(1109402124)
				local var_512_4 = arg_509_1:FormatText(var_512_3.content)

				arg_509_1.text_.text = var_512_4

				LuaForUtil.ClearLinePrefixSymbol(arg_509_1.text_)

				local var_512_5 = 27
				local var_512_6 = utf8.len(var_512_4)
				local var_512_7 = var_512_5 <= 0 and var_512_1 or var_512_1 * (var_512_6 / var_512_5)

				if var_512_7 > 0 and var_512_1 < var_512_7 then
					arg_509_1.talkMaxDuration = var_512_7

					if var_512_7 + var_512_0 > arg_509_1.duration_ then
						arg_509_1.duration_ = var_512_7 + var_512_0
					end
				end

				arg_509_1.text_.text = var_512_4
				arg_509_1.typewritter.percent = 0

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402124", "story_v_side_new_1109402.awb") ~= 0 then
					local var_512_8 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402124", "story_v_side_new_1109402.awb") / 1000

					if var_512_8 + var_512_0 > arg_509_1.duration_ then
						arg_509_1.duration_ = var_512_8 + var_512_0
					end

					if var_512_3.prefab_name ~= "" and arg_509_1.actors_[var_512_3.prefab_name] ~= nil then
						local var_512_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_509_1.actors_[var_512_3.prefab_name].transform, "story_v_side_new_1109402", "1109402124", "story_v_side_new_1109402.awb")

						arg_509_1:RecordAudio("1109402124", var_512_9)
						arg_509_1:RecordAudio("1109402124", var_512_9)
					else
						arg_509_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402124", "story_v_side_new_1109402.awb")
					end

					arg_509_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402124", "story_v_side_new_1109402.awb")
				end

				arg_509_1:RecordContent(arg_509_1.text_.text)
			end

			local var_512_10 = math.max(var_512_1, arg_509_1.talkMaxDuration)

			if var_512_0 <= arg_509_1.time_ and arg_509_1.time_ < var_512_0 + var_512_10 then
				arg_509_1.typewritter.percent = (arg_509_1.time_ - var_512_0) / var_512_10

				arg_509_1.typewritter:SetDirty()
			end

			if arg_509_1.time_ >= var_512_0 + var_512_10 and arg_509_1.time_ < var_512_0 + var_512_10 + arg_512_0 then
				arg_509_1.typewritter.percent = 1

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(true)
			end
		end

		arg_509_1.nodeConfigList_ = {}

		arg_509_1:InitPlayNodeList()
	end,
	Play1109402125 = function(arg_513_0, arg_513_1)
		arg_513_1.time_ = 0
		arg_513_1.frameCnt_ = 0
		arg_513_1.state_ = "playing"
		arg_513_1.curTalkId_ = 1109402125
		arg_513_1.duration_ = 8.47

		local var_513_0 = {
			ja = 8.466,
			ko = 5.7,
			zh = 5.7
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
				arg_513_0:Play1109402126(arg_513_1)
			end
		end

		function arg_513_1.onSingleLineUpdate_(arg_516_0)
			local var_516_0 = 0
			local var_516_1 = 0.575

			if var_516_0 < arg_513_1.time_ and arg_513_1.time_ <= var_516_0 + arg_516_0 then
				arg_513_1.talkMaxDuration = 0
				arg_513_1.dialogCg_.alpha = 1

				arg_513_1.dialog_:SetActive(true)
				SetActive(arg_513_1.leftNameGo_, true)

				local var_516_2 = arg_513_1:FormatText(StoryNameCfg[189].name)

				arg_513_1.leftNameTxt_.text = var_516_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_513_1.leftNameTxt_.transform)

				arg_513_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_513_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_513_1:RecordName(arg_513_1.leftNameTxt_.text)
				SetActive(arg_513_1.iconTrs_.gameObject, true)
				arg_513_1.iconController_:SetSelectedState("hero")

				arg_513_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vina")

				arg_513_1.callingController_:SetSelectedState("normal")

				arg_513_1.keyicon_.color = Color.New(1, 1, 1)
				arg_513_1.icon_.color = Color.New(1, 1, 1)

				local var_516_3 = arg_513_1:GetWordFromCfg(1109402125)
				local var_516_4 = arg_513_1:FormatText(var_516_3.content)

				arg_513_1.text_.text = var_516_4

				LuaForUtil.ClearLinePrefixSymbol(arg_513_1.text_)

				local var_516_5 = 23
				local var_516_6 = utf8.len(var_516_4)
				local var_516_7 = var_516_5 <= 0 and var_516_1 or var_516_1 * (var_516_6 / var_516_5)

				if var_516_7 > 0 and var_516_1 < var_516_7 then
					arg_513_1.talkMaxDuration = var_516_7

					if var_516_7 + var_516_0 > arg_513_1.duration_ then
						arg_513_1.duration_ = var_516_7 + var_516_0
					end
				end

				arg_513_1.text_.text = var_516_4
				arg_513_1.typewritter.percent = 0

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402125", "story_v_side_new_1109402.awb") ~= 0 then
					local var_516_8 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402125", "story_v_side_new_1109402.awb") / 1000

					if var_516_8 + var_516_0 > arg_513_1.duration_ then
						arg_513_1.duration_ = var_516_8 + var_516_0
					end

					if var_516_3.prefab_name ~= "" and arg_513_1.actors_[var_516_3.prefab_name] ~= nil then
						local var_516_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_513_1.actors_[var_516_3.prefab_name].transform, "story_v_side_new_1109402", "1109402125", "story_v_side_new_1109402.awb")

						arg_513_1:RecordAudio("1109402125", var_516_9)
						arg_513_1:RecordAudio("1109402125", var_516_9)
					else
						arg_513_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402125", "story_v_side_new_1109402.awb")
					end

					arg_513_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402125", "story_v_side_new_1109402.awb")
				end

				arg_513_1:RecordContent(arg_513_1.text_.text)
			end

			local var_516_10 = math.max(var_516_1, arg_513_1.talkMaxDuration)

			if var_516_0 <= arg_513_1.time_ and arg_513_1.time_ < var_516_0 + var_516_10 then
				arg_513_1.typewritter.percent = (arg_513_1.time_ - var_516_0) / var_516_10

				arg_513_1.typewritter:SetDirty()
			end

			if arg_513_1.time_ >= var_516_0 + var_516_10 and arg_513_1.time_ < var_516_0 + var_516_10 + arg_516_0 then
				arg_513_1.typewritter.percent = 1

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(true)
			end
		end

		arg_513_1.nodeConfigList_ = {}

		arg_513_1:InitPlayNodeList()
	end,
	Play1109402126 = function(arg_517_0, arg_517_1)
		arg_517_1.time_ = 0
		arg_517_1.frameCnt_ = 0
		arg_517_1.state_ = "playing"
		arg_517_1.curTalkId_ = 1109402126
		arg_517_1.duration_ = 7

		SetActive(arg_517_1.tipsGo_, false)

		function arg_517_1.onSingleLineFinish_()
			arg_517_1.onSingleLineUpdate_ = nil
			arg_517_1.onSingleLineFinish_ = nil
			arg_517_1.state_ = "waiting"
		end

		function arg_517_1.playNext_(arg_519_0)
			if arg_519_0 == 1 then
				arg_517_0:Play1109402127(arg_517_1)
			end
		end

		function arg_517_1.onSingleLineUpdate_(arg_520_0)
			local var_520_0 = "STblack"

			if arg_517_1.bgs_[var_520_0] == nil then
				local var_520_1 = Object.Instantiate(arg_517_1.paintGo_)

				var_520_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_520_0)
				var_520_1.name = var_520_0
				var_520_1.transform.parent = arg_517_1.stage_.transform
				var_520_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_517_1.bgs_[var_520_0] = var_520_1
			end

			local var_520_2 = 0

			if var_520_2 < arg_517_1.time_ and arg_517_1.time_ <= var_520_2 + arg_520_0 then
				local var_520_3 = manager.ui.mainCamera.transform.localPosition
				local var_520_4 = Vector3.New(0, 0, 10) + Vector3.New(var_520_3.x, var_520_3.y, 0)
				local var_520_5 = arg_517_1.bgs_.STblack

				var_520_5.transform.localPosition = var_520_4
				var_520_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_520_6 = var_520_5:GetComponent("SpriteRenderer")

				if var_520_6 and var_520_6.sprite then
					local var_520_7 = (var_520_5.transform.localPosition - var_520_3).z
					local var_520_8 = manager.ui.mainCameraCom_
					local var_520_9 = 2 * var_520_7 * Mathf.Tan(var_520_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_520_10 = var_520_9 * var_520_8.aspect
					local var_520_11 = var_520_6.sprite.bounds.size.x
					local var_520_12 = var_520_6.sprite.bounds.size.y
					local var_520_13 = var_520_10 / var_520_11
					local var_520_14 = var_520_9 / var_520_12
					local var_520_15 = var_520_14 < var_520_13 and var_520_13 or var_520_14

					var_520_5.transform.localScale = Vector3.New(var_520_15, var_520_15, 0)
				end

				for iter_520_0, iter_520_1 in pairs(arg_517_1.bgs_) do
					if iter_520_0 ~= "STblack" then
						iter_520_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_520_16 = arg_517_1.actors_["1094ui_story"].transform
			local var_520_17 = 0

			if var_520_17 < arg_517_1.time_ and arg_517_1.time_ <= var_520_17 + arg_520_0 then
				arg_517_1.var_.moveOldPos1094ui_story = var_520_16.localPosition
			end

			local var_520_18 = 0.001

			if var_520_17 <= arg_517_1.time_ and arg_517_1.time_ < var_520_17 + var_520_18 then
				local var_520_19 = (arg_517_1.time_ - var_520_17) / var_520_18
				local var_520_20 = Vector3.New(0, 100, 0)

				var_520_16.localPosition = Vector3.Lerp(arg_517_1.var_.moveOldPos1094ui_story, var_520_20, var_520_19)

				local var_520_21 = manager.ui.mainCamera.transform.position - var_520_16.position

				var_520_16.forward = Vector3.New(var_520_21.x, var_520_21.y, var_520_21.z)

				local var_520_22 = var_520_16.localEulerAngles

				var_520_22.z = 0
				var_520_22.x = 0
				var_520_16.localEulerAngles = var_520_22
			end

			if arg_517_1.time_ >= var_520_17 + var_520_18 and arg_517_1.time_ < var_520_17 + var_520_18 + arg_520_0 then
				var_520_16.localPosition = Vector3.New(0, 100, 0)

				local var_520_23 = manager.ui.mainCamera.transform.position - var_520_16.position

				var_520_16.forward = Vector3.New(var_520_23.x, var_520_23.y, var_520_23.z)

				local var_520_24 = var_520_16.localEulerAngles

				var_520_24.z = 0
				var_520_24.x = 0
				var_520_16.localEulerAngles = var_520_24
			end

			local var_520_25 = arg_517_1.actors_["1094ui_story"]
			local var_520_26 = 0

			if var_520_26 < arg_517_1.time_ and arg_517_1.time_ <= var_520_26 + arg_520_0 and not isNil(var_520_25) and arg_517_1.var_.characterEffect1094ui_story == nil then
				arg_517_1.var_.characterEffect1094ui_story = var_520_25:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_520_27 = 0.200000002980232

			if var_520_26 <= arg_517_1.time_ and arg_517_1.time_ < var_520_26 + var_520_27 and not isNil(var_520_25) then
				local var_520_28 = (arg_517_1.time_ - var_520_26) / var_520_27

				if arg_517_1.var_.characterEffect1094ui_story and not isNil(var_520_25) then
					local var_520_29 = Mathf.Lerp(0, 0.5, var_520_28)

					arg_517_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_517_1.var_.characterEffect1094ui_story.fillRatio = var_520_29
				end
			end

			if arg_517_1.time_ >= var_520_26 + var_520_27 and arg_517_1.time_ < var_520_26 + var_520_27 + arg_520_0 and not isNil(var_520_25) and arg_517_1.var_.characterEffect1094ui_story then
				local var_520_30 = 0.5

				arg_517_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_517_1.var_.characterEffect1094ui_story.fillRatio = var_520_30
			end

			local var_520_31 = 0

			if var_520_31 < arg_517_1.time_ and arg_517_1.time_ <= var_520_31 + arg_520_0 then
				arg_517_1.mask_.enabled = true
				arg_517_1.mask_.raycastTarget = true

				arg_517_1:SetGaussion(false)
			end

			local var_520_32 = 2

			if var_520_31 <= arg_517_1.time_ and arg_517_1.time_ < var_520_31 + var_520_32 then
				local var_520_33 = (arg_517_1.time_ - var_520_31) / var_520_32
				local var_520_34 = Color.New(0, 0, 0)

				var_520_34.a = Mathf.Lerp(1, 0, var_520_33)
				arg_517_1.mask_.color = var_520_34
			end

			if arg_517_1.time_ >= var_520_31 + var_520_32 and arg_517_1.time_ < var_520_31 + var_520_32 + arg_520_0 then
				local var_520_35 = Color.New(0, 0, 0)
				local var_520_36 = 0

				arg_517_1.mask_.enabled = false
				var_520_35.a = var_520_36
				arg_517_1.mask_.color = var_520_35
			end

			if arg_517_1.frameCnt_ <= 1 then
				arg_517_1.dialog_:SetActive(false)
			end

			local var_520_37 = 2
			local var_520_38 = 0.65

			if var_520_37 < arg_517_1.time_ and arg_517_1.time_ <= var_520_37 + arg_520_0 then
				arg_517_1.talkMaxDuration = 0

				arg_517_1.dialog_:SetActive(true)

				arg_517_1.dialogCg_.alpha = 0

				local var_520_39 = LeanTween.value(arg_517_1.dialog_, 0, 1, 0.3)

				var_520_39:setOnUpdate(LuaHelper.FloatAction(function(arg_521_0)
					arg_517_1.dialogCg_.alpha = arg_521_0
				end))
				var_520_39:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_517_1.dialog_)
					var_520_39:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_517_1.duration_ = arg_517_1.duration_ + 0.3

				SetActive(arg_517_1.leftNameGo_, false)

				arg_517_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_517_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_517_1:RecordName(arg_517_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_517_1.iconTrs_.gameObject, false)
				arg_517_1.callingController_:SetSelectedState("normal")

				local var_520_40 = arg_517_1:GetWordFromCfg(1109402126)
				local var_520_41 = arg_517_1:FormatText(var_520_40.content)

				arg_517_1.text_.text = var_520_41

				LuaForUtil.ClearLinePrefixSymbol(arg_517_1.text_)

				local var_520_42 = 26
				local var_520_43 = utf8.len(var_520_41)
				local var_520_44 = var_520_42 <= 0 and var_520_38 or var_520_38 * (var_520_43 / var_520_42)

				if var_520_44 > 0 and var_520_38 < var_520_44 then
					arg_517_1.talkMaxDuration = var_520_44
					var_520_37 = var_520_37 + 0.3

					if var_520_44 + var_520_37 > arg_517_1.duration_ then
						arg_517_1.duration_ = var_520_44 + var_520_37
					end
				end

				arg_517_1.text_.text = var_520_41
				arg_517_1.typewritter.percent = 0

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(false)
				arg_517_1:RecordContent(arg_517_1.text_.text)
			end

			local var_520_45 = var_520_37 + 0.3
			local var_520_46 = math.max(var_520_38, arg_517_1.talkMaxDuration)

			if var_520_45 <= arg_517_1.time_ and arg_517_1.time_ < var_520_45 + var_520_46 then
				arg_517_1.typewritter.percent = (arg_517_1.time_ - var_520_45) / var_520_46

				arg_517_1.typewritter:SetDirty()
			end

			if arg_517_1.time_ >= var_520_45 + var_520_46 and arg_517_1.time_ < var_520_45 + var_520_46 + arg_520_0 then
				arg_517_1.typewritter.percent = 1

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(true)
			end
		end

		arg_517_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_517_1:InitPlayNodeList()
	end,
	Play1109402127 = function(arg_523_0, arg_523_1)
		arg_523_1.time_ = 0
		arg_523_1.frameCnt_ = 0
		arg_523_1.state_ = "playing"
		arg_523_1.curTalkId_ = 1109402127
		arg_523_1.duration_ = 5

		SetActive(arg_523_1.tipsGo_, false)

		function arg_523_1.onSingleLineFinish_()
			arg_523_1.onSingleLineUpdate_ = nil
			arg_523_1.onSingleLineFinish_ = nil
			arg_523_1.state_ = "waiting"
		end

		function arg_523_1.playNext_(arg_525_0)
			if arg_525_0 == 1 then
				arg_523_0:Play1109402128(arg_523_1)
			end
		end

		function arg_523_1.onSingleLineUpdate_(arg_526_0)
			local var_526_0 = 0
			local var_526_1 = 0.65

			if var_526_0 < arg_523_1.time_ and arg_523_1.time_ <= var_526_0 + arg_526_0 then
				arg_523_1.talkMaxDuration = 0
				arg_523_1.dialogCg_.alpha = 1

				arg_523_1.dialog_:SetActive(true)
				SetActive(arg_523_1.leftNameGo_, false)

				arg_523_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_523_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_523_1:RecordName(arg_523_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_523_1.iconTrs_.gameObject, false)
				arg_523_1.callingController_:SetSelectedState("normal")

				local var_526_2 = arg_523_1:GetWordFromCfg(1109402127)
				local var_526_3 = arg_523_1:FormatText(var_526_2.content)

				arg_523_1.text_.text = var_526_3

				LuaForUtil.ClearLinePrefixSymbol(arg_523_1.text_)

				local var_526_4 = 26
				local var_526_5 = utf8.len(var_526_3)
				local var_526_6 = var_526_4 <= 0 and var_526_1 or var_526_1 * (var_526_5 / var_526_4)

				if var_526_6 > 0 and var_526_1 < var_526_6 then
					arg_523_1.talkMaxDuration = var_526_6

					if var_526_6 + var_526_0 > arg_523_1.duration_ then
						arg_523_1.duration_ = var_526_6 + var_526_0
					end
				end

				arg_523_1.text_.text = var_526_3
				arg_523_1.typewritter.percent = 0

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(false)
				arg_523_1:RecordContent(arg_523_1.text_.text)
			end

			local var_526_7 = math.max(var_526_1, arg_523_1.talkMaxDuration)

			if var_526_0 <= arg_523_1.time_ and arg_523_1.time_ < var_526_0 + var_526_7 then
				arg_523_1.typewritter.percent = (arg_523_1.time_ - var_526_0) / var_526_7

				arg_523_1.typewritter:SetDirty()
			end

			if arg_523_1.time_ >= var_526_0 + var_526_7 and arg_523_1.time_ < var_526_0 + var_526_7 + arg_526_0 then
				arg_523_1.typewritter.percent = 1

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(true)
			end
		end

		arg_523_1.nodeConfigList_ = {}

		arg_523_1:InitPlayNodeList()
	end,
	Play1109402128 = function(arg_527_0, arg_527_1)
		arg_527_1.time_ = 0
		arg_527_1.frameCnt_ = 0
		arg_527_1.state_ = "playing"
		arg_527_1.curTalkId_ = 1109402128
		arg_527_1.duration_ = 5

		SetActive(arg_527_1.tipsGo_, false)

		function arg_527_1.onSingleLineFinish_()
			arg_527_1.onSingleLineUpdate_ = nil
			arg_527_1.onSingleLineFinish_ = nil
			arg_527_1.state_ = "waiting"
		end

		function arg_527_1.playNext_(arg_529_0)
			if arg_529_0 == 1 then
				arg_527_0:Play1109402129(arg_527_1)
			end
		end

		function arg_527_1.onSingleLineUpdate_(arg_530_0)
			local var_530_0 = 0
			local var_530_1 = 0.675

			if var_530_0 < arg_527_1.time_ and arg_527_1.time_ <= var_530_0 + arg_530_0 then
				arg_527_1.talkMaxDuration = 0
				arg_527_1.dialogCg_.alpha = 1

				arg_527_1.dialog_:SetActive(true)
				SetActive(arg_527_1.leftNameGo_, false)

				arg_527_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_527_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_527_1:RecordName(arg_527_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_527_1.iconTrs_.gameObject, false)
				arg_527_1.callingController_:SetSelectedState("normal")

				local var_530_2 = arg_527_1:GetWordFromCfg(1109402128)
				local var_530_3 = arg_527_1:FormatText(var_530_2.content)

				arg_527_1.text_.text = var_530_3

				LuaForUtil.ClearLinePrefixSymbol(arg_527_1.text_)

				local var_530_4 = 27
				local var_530_5 = utf8.len(var_530_3)
				local var_530_6 = var_530_4 <= 0 and var_530_1 or var_530_1 * (var_530_5 / var_530_4)

				if var_530_6 > 0 and var_530_1 < var_530_6 then
					arg_527_1.talkMaxDuration = var_530_6

					if var_530_6 + var_530_0 > arg_527_1.duration_ then
						arg_527_1.duration_ = var_530_6 + var_530_0
					end
				end

				arg_527_1.text_.text = var_530_3
				arg_527_1.typewritter.percent = 0

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(false)
				arg_527_1:RecordContent(arg_527_1.text_.text)
			end

			local var_530_7 = math.max(var_530_1, arg_527_1.talkMaxDuration)

			if var_530_0 <= arg_527_1.time_ and arg_527_1.time_ < var_530_0 + var_530_7 then
				arg_527_1.typewritter.percent = (arg_527_1.time_ - var_530_0) / var_530_7

				arg_527_1.typewritter:SetDirty()
			end

			if arg_527_1.time_ >= var_530_0 + var_530_7 and arg_527_1.time_ < var_530_0 + var_530_7 + arg_530_0 then
				arg_527_1.typewritter.percent = 1

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(true)
			end
		end

		arg_527_1.nodeConfigList_ = {}

		arg_527_1:InitPlayNodeList()
	end,
	Play1109402129 = function(arg_531_0, arg_531_1)
		arg_531_1.time_ = 0
		arg_531_1.frameCnt_ = 0
		arg_531_1.state_ = "playing"
		arg_531_1.curTalkId_ = 1109402129
		arg_531_1.duration_ = 7

		SetActive(arg_531_1.tipsGo_, false)

		function arg_531_1.onSingleLineFinish_()
			arg_531_1.onSingleLineUpdate_ = nil
			arg_531_1.onSingleLineFinish_ = nil
			arg_531_1.state_ = "waiting"
		end

		function arg_531_1.playNext_(arg_533_0)
			if arg_533_0 == 1 then
				arg_531_0:Play1109402130(arg_531_1)
			end
		end

		function arg_531_1.onSingleLineUpdate_(arg_534_0)
			local var_534_0 = "ST03a"

			if arg_531_1.bgs_[var_534_0] == nil then
				local var_534_1 = Object.Instantiate(arg_531_1.paintGo_)

				var_534_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_534_0)
				var_534_1.name = var_534_0
				var_534_1.transform.parent = arg_531_1.stage_.transform
				var_534_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_531_1.bgs_[var_534_0] = var_534_1
			end

			local var_534_2 = 0

			if var_534_2 < arg_531_1.time_ and arg_531_1.time_ <= var_534_2 + arg_534_0 then
				if arg_531_0.sceneSettingEffect_ then
					arg_531_1.sceneSettingEffect_.enabled = false
				end

				arg_531_1.sceneSettingGo_:SetActive(true)

				local var_534_3 = manager.ui.mainCamera.transform.localPosition
				local var_534_4 = Vector3.New(0, 0, 10) + Vector3.New(var_534_3.x, var_534_3.y, 0)
				local var_534_5 = arg_531_1.bgs_.ST03a

				var_534_5.transform.localPosition = var_534_4
				var_534_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_534_6 = var_534_5:GetComponent("SpriteRenderer")

				if var_534_6 and var_534_6.sprite then
					local var_534_7 = (var_534_5.transform.localPosition - var_534_3).z
					local var_534_8 = manager.ui.mainCameraCom_
					local var_534_9 = 2 * var_534_7 * Mathf.Tan(var_534_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_534_10 = var_534_9 * var_534_8.aspect
					local var_534_11 = var_534_6.sprite.bounds.size.x
					local var_534_12 = var_534_6.sprite.bounds.size.y
					local var_534_13 = var_534_10 / var_534_11
					local var_534_14 = var_534_9 / var_534_12
					local var_534_15 = var_534_14 < var_534_13 and var_534_13 or var_534_14

					var_534_5.transform.localScale = Vector3.New(var_534_15, var_534_15, 0)
				end

				for iter_534_0, iter_534_1 in pairs(arg_531_1.bgs_) do
					if iter_534_0 ~= "ST03a" then
						iter_534_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_534_16 = 0

			if var_534_16 < arg_531_1.time_ and arg_531_1.time_ <= var_534_16 + arg_534_0 then
				arg_531_1.mask_.enabled = true
				arg_531_1.mask_.raycastTarget = true

				arg_531_1:SetGaussion(false)
			end

			local var_534_17 = 2

			if var_534_16 <= arg_531_1.time_ and arg_531_1.time_ < var_534_16 + var_534_17 then
				local var_534_18 = (arg_531_1.time_ - var_534_16) / var_534_17
				local var_534_19 = Color.New(0, 0, 0)

				var_534_19.a = Mathf.Lerp(1, 0, var_534_18)
				arg_531_1.mask_.color = var_534_19
			end

			if arg_531_1.time_ >= var_534_16 + var_534_17 and arg_531_1.time_ < var_534_16 + var_534_17 + arg_534_0 then
				local var_534_20 = Color.New(0, 0, 0)
				local var_534_21 = 0

				arg_531_1.mask_.enabled = false
				var_534_20.a = var_534_21
				arg_531_1.mask_.color = var_534_20
			end

			if arg_531_1.frameCnt_ <= 1 then
				arg_531_1.dialog_:SetActive(false)
			end

			local var_534_22 = 2
			local var_534_23 = 0.75

			if var_534_22 < arg_531_1.time_ and arg_531_1.time_ <= var_534_22 + arg_534_0 then
				arg_531_1.talkMaxDuration = 0

				arg_531_1.dialog_:SetActive(true)

				arg_531_1.dialogCg_.alpha = 0

				local var_534_24 = LeanTween.value(arg_531_1.dialog_, 0, 1, 0.3)

				var_534_24:setOnUpdate(LuaHelper.FloatAction(function(arg_535_0)
					arg_531_1.dialogCg_.alpha = arg_535_0
				end))
				var_534_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_531_1.dialog_)
					var_534_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_531_1.duration_ = arg_531_1.duration_ + 0.3

				SetActive(arg_531_1.leftNameGo_, false)

				arg_531_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_531_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_531_1:RecordName(arg_531_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_531_1.iconTrs_.gameObject, false)
				arg_531_1.callingController_:SetSelectedState("normal")

				local var_534_25 = arg_531_1:GetWordFromCfg(1109402129)
				local var_534_26 = arg_531_1:FormatText(var_534_25.content)

				arg_531_1.text_.text = var_534_26

				LuaForUtil.ClearLinePrefixSymbol(arg_531_1.text_)

				local var_534_27 = 30
				local var_534_28 = utf8.len(var_534_26)
				local var_534_29 = var_534_27 <= 0 and var_534_23 or var_534_23 * (var_534_28 / var_534_27)

				if var_534_29 > 0 and var_534_23 < var_534_29 then
					arg_531_1.talkMaxDuration = var_534_29
					var_534_22 = var_534_22 + 0.3

					if var_534_29 + var_534_22 > arg_531_1.duration_ then
						arg_531_1.duration_ = var_534_29 + var_534_22
					end
				end

				arg_531_1.text_.text = var_534_26
				arg_531_1.typewritter.percent = 0

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(false)
				arg_531_1:RecordContent(arg_531_1.text_.text)
			end

			local var_534_30 = var_534_22 + 0.3
			local var_534_31 = math.max(var_534_23, arg_531_1.talkMaxDuration)

			if var_534_30 <= arg_531_1.time_ and arg_531_1.time_ < var_534_30 + var_534_31 then
				arg_531_1.typewritter.percent = (arg_531_1.time_ - var_534_30) / var_534_31

				arg_531_1.typewritter:SetDirty()
			end

			if arg_531_1.time_ >= var_534_30 + var_534_31 and arg_531_1.time_ < var_534_30 + var_534_31 + arg_534_0 then
				arg_531_1.typewritter.percent = 1

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(true)
			end
		end

		arg_531_1.nodeConfigList_ = {}

		arg_531_1:InitPlayNodeList()
	end,
	Play1109402130 = function(arg_537_0, arg_537_1)
		arg_537_1.time_ = 0
		arg_537_1.frameCnt_ = 0
		arg_537_1.state_ = "playing"
		arg_537_1.curTalkId_ = 1109402130
		arg_537_1.duration_ = 5

		SetActive(arg_537_1.tipsGo_, false)

		function arg_537_1.onSingleLineFinish_()
			arg_537_1.onSingleLineUpdate_ = nil
			arg_537_1.onSingleLineFinish_ = nil
			arg_537_1.state_ = "waiting"
		end

		function arg_537_1.playNext_(arg_539_0)
			if arg_539_0 == 1 then
				arg_537_0:Play1109402131(arg_537_1)
			end
		end

		function arg_537_1.onSingleLineUpdate_(arg_540_0)
			local var_540_0 = 0
			local var_540_1 = 0.7

			if var_540_0 < arg_537_1.time_ and arg_537_1.time_ <= var_540_0 + arg_540_0 then
				arg_537_1.talkMaxDuration = 0
				arg_537_1.dialogCg_.alpha = 1

				arg_537_1.dialog_:SetActive(true)
				SetActive(arg_537_1.leftNameGo_, false)

				arg_537_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_537_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_537_1:RecordName(arg_537_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_537_1.iconTrs_.gameObject, false)
				arg_537_1.callingController_:SetSelectedState("normal")

				local var_540_2 = arg_537_1:GetWordFromCfg(1109402130)
				local var_540_3 = arg_537_1:FormatText(var_540_2.content)

				arg_537_1.text_.text = var_540_3

				LuaForUtil.ClearLinePrefixSymbol(arg_537_1.text_)

				local var_540_4 = 28
				local var_540_5 = utf8.len(var_540_3)
				local var_540_6 = var_540_4 <= 0 and var_540_1 or var_540_1 * (var_540_5 / var_540_4)

				if var_540_6 > 0 and var_540_1 < var_540_6 then
					arg_537_1.talkMaxDuration = var_540_6

					if var_540_6 + var_540_0 > arg_537_1.duration_ then
						arg_537_1.duration_ = var_540_6 + var_540_0
					end
				end

				arg_537_1.text_.text = var_540_3
				arg_537_1.typewritter.percent = 0

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(false)
				arg_537_1:RecordContent(arg_537_1.text_.text)
			end

			local var_540_7 = math.max(var_540_1, arg_537_1.talkMaxDuration)

			if var_540_0 <= arg_537_1.time_ and arg_537_1.time_ < var_540_0 + var_540_7 then
				arg_537_1.typewritter.percent = (arg_537_1.time_ - var_540_0) / var_540_7

				arg_537_1.typewritter:SetDirty()
			end

			if arg_537_1.time_ >= var_540_0 + var_540_7 and arg_537_1.time_ < var_540_0 + var_540_7 + arg_540_0 then
				arg_537_1.typewritter.percent = 1

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(true)
			end
		end

		arg_537_1.nodeConfigList_ = {}

		arg_537_1:InitPlayNodeList()
	end,
	Play1109402131 = function(arg_541_0, arg_541_1)
		arg_541_1.time_ = 0
		arg_541_1.frameCnt_ = 0
		arg_541_1.state_ = "playing"
		arg_541_1.curTalkId_ = 1109402131
		arg_541_1.duration_ = 6.73

		local var_541_0 = {
			ja = 6.733,
			ko = 5.666,
			zh = 5.666
		}
		local var_541_1 = manager.audio:GetLocalizationFlag()

		if var_541_0[var_541_1] ~= nil then
			arg_541_1.duration_ = var_541_0[var_541_1]
		end

		SetActive(arg_541_1.tipsGo_, false)

		function arg_541_1.onSingleLineFinish_()
			arg_541_1.onSingleLineUpdate_ = nil
			arg_541_1.onSingleLineFinish_ = nil
			arg_541_1.state_ = "waiting"
		end

		function arg_541_1.playNext_(arg_543_0)
			if arg_543_0 == 1 then
				arg_541_0:Play1109402132(arg_541_1)
			end
		end

		function arg_541_1.onSingleLineUpdate_(arg_544_0)
			local var_544_0 = 0
			local var_544_1 = 0.625

			if var_544_0 < arg_541_1.time_ and arg_541_1.time_ <= var_544_0 + arg_544_0 then
				arg_541_1.talkMaxDuration = 0
				arg_541_1.dialogCg_.alpha = 1

				arg_541_1.dialog_:SetActive(true)
				SetActive(arg_541_1.leftNameGo_, true)

				local var_544_2 = arg_541_1:FormatText(StoryNameCfg[189].name)

				arg_541_1.leftNameTxt_.text = var_544_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_541_1.leftNameTxt_.transform)

				arg_541_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_541_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_541_1:RecordName(arg_541_1.leftNameTxt_.text)
				SetActive(arg_541_1.iconTrs_.gameObject, true)
				arg_541_1.iconController_:SetSelectedState("hero")

				arg_541_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vina")

				arg_541_1.callingController_:SetSelectedState("normal")

				arg_541_1.keyicon_.color = Color.New(1, 1, 1)
				arg_541_1.icon_.color = Color.New(1, 1, 1)

				local var_544_3 = arg_541_1:GetWordFromCfg(1109402131)
				local var_544_4 = arg_541_1:FormatText(var_544_3.content)

				arg_541_1.text_.text = var_544_4

				LuaForUtil.ClearLinePrefixSymbol(arg_541_1.text_)

				local var_544_5 = 25
				local var_544_6 = utf8.len(var_544_4)
				local var_544_7 = var_544_5 <= 0 and var_544_1 or var_544_1 * (var_544_6 / var_544_5)

				if var_544_7 > 0 and var_544_1 < var_544_7 then
					arg_541_1.talkMaxDuration = var_544_7

					if var_544_7 + var_544_0 > arg_541_1.duration_ then
						arg_541_1.duration_ = var_544_7 + var_544_0
					end
				end

				arg_541_1.text_.text = var_544_4
				arg_541_1.typewritter.percent = 0

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402131", "story_v_side_new_1109402.awb") ~= 0 then
					local var_544_8 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402131", "story_v_side_new_1109402.awb") / 1000

					if var_544_8 + var_544_0 > arg_541_1.duration_ then
						arg_541_1.duration_ = var_544_8 + var_544_0
					end

					if var_544_3.prefab_name ~= "" and arg_541_1.actors_[var_544_3.prefab_name] ~= nil then
						local var_544_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_541_1.actors_[var_544_3.prefab_name].transform, "story_v_side_new_1109402", "1109402131", "story_v_side_new_1109402.awb")

						arg_541_1:RecordAudio("1109402131", var_544_9)
						arg_541_1:RecordAudio("1109402131", var_544_9)
					else
						arg_541_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402131", "story_v_side_new_1109402.awb")
					end

					arg_541_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402131", "story_v_side_new_1109402.awb")
				end

				arg_541_1:RecordContent(arg_541_1.text_.text)
			end

			local var_544_10 = math.max(var_544_1, arg_541_1.talkMaxDuration)

			if var_544_0 <= arg_541_1.time_ and arg_541_1.time_ < var_544_0 + var_544_10 then
				arg_541_1.typewritter.percent = (arg_541_1.time_ - var_544_0) / var_544_10

				arg_541_1.typewritter:SetDirty()
			end

			if arg_541_1.time_ >= var_544_0 + var_544_10 and arg_541_1.time_ < var_544_0 + var_544_10 + arg_544_0 then
				arg_541_1.typewritter.percent = 1

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(true)
			end
		end

		arg_541_1.nodeConfigList_ = {}

		arg_541_1:InitPlayNodeList()
	end,
	Play1109402132 = function(arg_545_0, arg_545_1)
		arg_545_1.time_ = 0
		arg_545_1.frameCnt_ = 0
		arg_545_1.state_ = "playing"
		arg_545_1.curTalkId_ = 1109402132
		arg_545_1.duration_ = 5

		SetActive(arg_545_1.tipsGo_, false)

		function arg_545_1.onSingleLineFinish_()
			arg_545_1.onSingleLineUpdate_ = nil
			arg_545_1.onSingleLineFinish_ = nil
			arg_545_1.state_ = "waiting"
		end

		function arg_545_1.playNext_(arg_547_0)
			if arg_547_0 == 1 then
				arg_545_0:Play1109402133(arg_545_1)
			end
		end

		function arg_545_1.onSingleLineUpdate_(arg_548_0)
			local var_548_0 = 0
			local var_548_1 = 0.875

			if var_548_0 < arg_545_1.time_ and arg_545_1.time_ <= var_548_0 + arg_548_0 then
				arg_545_1.talkMaxDuration = 0
				arg_545_1.dialogCg_.alpha = 1

				arg_545_1.dialog_:SetActive(true)
				SetActive(arg_545_1.leftNameGo_, true)

				local var_548_2 = arg_545_1:FormatText(StoryNameCfg[7].name)

				arg_545_1.leftNameTxt_.text = var_548_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_545_1.leftNameTxt_.transform)

				arg_545_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_545_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_545_1:RecordName(arg_545_1.leftNameTxt_.text)
				SetActive(arg_545_1.iconTrs_.gameObject, true)
				arg_545_1.iconController_:SetSelectedState("hero")

				arg_545_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_545_1.callingController_:SetSelectedState("normal")

				arg_545_1.keyicon_.color = Color.New(1, 1, 1)
				arg_545_1.icon_.color = Color.New(1, 1, 1)

				local var_548_3 = arg_545_1:GetWordFromCfg(1109402132)
				local var_548_4 = arg_545_1:FormatText(var_548_3.content)

				arg_545_1.text_.text = var_548_4

				LuaForUtil.ClearLinePrefixSymbol(arg_545_1.text_)

				local var_548_5 = 35
				local var_548_6 = utf8.len(var_548_4)
				local var_548_7 = var_548_5 <= 0 and var_548_1 or var_548_1 * (var_548_6 / var_548_5)

				if var_548_7 > 0 and var_548_1 < var_548_7 then
					arg_545_1.talkMaxDuration = var_548_7

					if var_548_7 + var_548_0 > arg_545_1.duration_ then
						arg_545_1.duration_ = var_548_7 + var_548_0
					end
				end

				arg_545_1.text_.text = var_548_4
				arg_545_1.typewritter.percent = 0

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(false)
				arg_545_1:RecordContent(arg_545_1.text_.text)
			end

			local var_548_8 = math.max(var_548_1, arg_545_1.talkMaxDuration)

			if var_548_0 <= arg_545_1.time_ and arg_545_1.time_ < var_548_0 + var_548_8 then
				arg_545_1.typewritter.percent = (arg_545_1.time_ - var_548_0) / var_548_8

				arg_545_1.typewritter:SetDirty()
			end

			if arg_545_1.time_ >= var_548_0 + var_548_8 and arg_545_1.time_ < var_548_0 + var_548_8 + arg_548_0 then
				arg_545_1.typewritter.percent = 1

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(true)
			end
		end

		arg_545_1.nodeConfigList_ = {}

		arg_545_1:InitPlayNodeList()
	end,
	Play1109402133 = function(arg_549_0, arg_549_1)
		arg_549_1.time_ = 0
		arg_549_1.frameCnt_ = 0
		arg_549_1.state_ = "playing"
		arg_549_1.curTalkId_ = 1109402133
		arg_549_1.duration_ = 5

		SetActive(arg_549_1.tipsGo_, false)

		function arg_549_1.onSingleLineFinish_()
			arg_549_1.onSingleLineUpdate_ = nil
			arg_549_1.onSingleLineFinish_ = nil
			arg_549_1.state_ = "waiting"
		end

		function arg_549_1.playNext_(arg_551_0)
			if arg_551_0 == 1 then
				arg_549_0:Play1109402134(arg_549_1)
			end
		end

		function arg_549_1.onSingleLineUpdate_(arg_552_0)
			local var_552_0 = 0
			local var_552_1 = 0.7

			if var_552_0 < arg_549_1.time_ and arg_549_1.time_ <= var_552_0 + arg_552_0 then
				arg_549_1.talkMaxDuration = 0
				arg_549_1.dialogCg_.alpha = 1

				arg_549_1.dialog_:SetActive(true)
				SetActive(arg_549_1.leftNameGo_, true)

				local var_552_2 = arg_549_1:FormatText(StoryNameCfg[7].name)

				arg_549_1.leftNameTxt_.text = var_552_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_549_1.leftNameTxt_.transform)

				arg_549_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_549_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_549_1:RecordName(arg_549_1.leftNameTxt_.text)
				SetActive(arg_549_1.iconTrs_.gameObject, true)
				arg_549_1.iconController_:SetSelectedState("hero")

				arg_549_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_549_1.callingController_:SetSelectedState("normal")

				arg_549_1.keyicon_.color = Color.New(1, 1, 1)
				arg_549_1.icon_.color = Color.New(1, 1, 1)

				local var_552_3 = arg_549_1:GetWordFromCfg(1109402133)
				local var_552_4 = arg_549_1:FormatText(var_552_3.content)

				arg_549_1.text_.text = var_552_4

				LuaForUtil.ClearLinePrefixSymbol(arg_549_1.text_)

				local var_552_5 = 28
				local var_552_6 = utf8.len(var_552_4)
				local var_552_7 = var_552_5 <= 0 and var_552_1 or var_552_1 * (var_552_6 / var_552_5)

				if var_552_7 > 0 and var_552_1 < var_552_7 then
					arg_549_1.talkMaxDuration = var_552_7

					if var_552_7 + var_552_0 > arg_549_1.duration_ then
						arg_549_1.duration_ = var_552_7 + var_552_0
					end
				end

				arg_549_1.text_.text = var_552_4
				arg_549_1.typewritter.percent = 0

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(false)
				arg_549_1:RecordContent(arg_549_1.text_.text)
			end

			local var_552_8 = math.max(var_552_1, arg_549_1.talkMaxDuration)

			if var_552_0 <= arg_549_1.time_ and arg_549_1.time_ < var_552_0 + var_552_8 then
				arg_549_1.typewritter.percent = (arg_549_1.time_ - var_552_0) / var_552_8

				arg_549_1.typewritter:SetDirty()
			end

			if arg_549_1.time_ >= var_552_0 + var_552_8 and arg_549_1.time_ < var_552_0 + var_552_8 + arg_552_0 then
				arg_549_1.typewritter.percent = 1

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(true)
			end
		end

		arg_549_1.nodeConfigList_ = {}

		arg_549_1:InitPlayNodeList()
	end,
	Play1109402134 = function(arg_553_0, arg_553_1)
		arg_553_1.time_ = 0
		arg_553_1.frameCnt_ = 0
		arg_553_1.state_ = "playing"
		arg_553_1.curTalkId_ = 1109402134
		arg_553_1.duration_ = 3.17

		local var_553_0 = {
			ja = 3.166,
			ko = 1.233,
			zh = 1.233
		}
		local var_553_1 = manager.audio:GetLocalizationFlag()

		if var_553_0[var_553_1] ~= nil then
			arg_553_1.duration_ = var_553_0[var_553_1]
		end

		SetActive(arg_553_1.tipsGo_, false)

		function arg_553_1.onSingleLineFinish_()
			arg_553_1.onSingleLineUpdate_ = nil
			arg_553_1.onSingleLineFinish_ = nil
			arg_553_1.state_ = "waiting"
		end

		function arg_553_1.playNext_(arg_555_0)
			if arg_555_0 == 1 then
				arg_553_0:Play1109402135(arg_553_1)
			end
		end

		function arg_553_1.onSingleLineUpdate_(arg_556_0)
			local var_556_0 = arg_553_1.actors_["1094ui_story"].transform
			local var_556_1 = 0

			if var_556_1 < arg_553_1.time_ and arg_553_1.time_ <= var_556_1 + arg_556_0 then
				arg_553_1.var_.moveOldPos1094ui_story = var_556_0.localPosition
			end

			local var_556_2 = 0.001

			if var_556_1 <= arg_553_1.time_ and arg_553_1.time_ < var_556_1 + var_556_2 then
				local var_556_3 = (arg_553_1.time_ - var_556_1) / var_556_2
				local var_556_4 = Vector3.New(0, -0.84, -6.1)

				var_556_0.localPosition = Vector3.Lerp(arg_553_1.var_.moveOldPos1094ui_story, var_556_4, var_556_3)

				local var_556_5 = manager.ui.mainCamera.transform.position - var_556_0.position

				var_556_0.forward = Vector3.New(var_556_5.x, var_556_5.y, var_556_5.z)

				local var_556_6 = var_556_0.localEulerAngles

				var_556_6.z = 0
				var_556_6.x = 0
				var_556_0.localEulerAngles = var_556_6
			end

			if arg_553_1.time_ >= var_556_1 + var_556_2 and arg_553_1.time_ < var_556_1 + var_556_2 + arg_556_0 then
				var_556_0.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_556_7 = manager.ui.mainCamera.transform.position - var_556_0.position

				var_556_0.forward = Vector3.New(var_556_7.x, var_556_7.y, var_556_7.z)

				local var_556_8 = var_556_0.localEulerAngles

				var_556_8.z = 0
				var_556_8.x = 0
				var_556_0.localEulerAngles = var_556_8
			end

			local var_556_9 = arg_553_1.actors_["1094ui_story"]
			local var_556_10 = 0

			if var_556_10 < arg_553_1.time_ and arg_553_1.time_ <= var_556_10 + arg_556_0 and not isNil(var_556_9) and arg_553_1.var_.characterEffect1094ui_story == nil then
				arg_553_1.var_.characterEffect1094ui_story = var_556_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_556_11 = 0.200000002980232

			if var_556_10 <= arg_553_1.time_ and arg_553_1.time_ < var_556_10 + var_556_11 and not isNil(var_556_9) then
				local var_556_12 = (arg_553_1.time_ - var_556_10) / var_556_11

				if arg_553_1.var_.characterEffect1094ui_story and not isNil(var_556_9) then
					arg_553_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_553_1.time_ >= var_556_10 + var_556_11 and arg_553_1.time_ < var_556_10 + var_556_11 + arg_556_0 and not isNil(var_556_9) and arg_553_1.var_.characterEffect1094ui_story then
				arg_553_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_556_13 = 0

			if var_556_13 < arg_553_1.time_ and arg_553_1.time_ <= var_556_13 + arg_556_0 then
				arg_553_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action1_1")
			end

			local var_556_14 = 0

			if var_556_14 < arg_553_1.time_ and arg_553_1.time_ <= var_556_14 + arg_556_0 then
				arg_553_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_556_15 = 0
			local var_556_16 = 0.075

			if var_556_15 < arg_553_1.time_ and arg_553_1.time_ <= var_556_15 + arg_556_0 then
				arg_553_1.talkMaxDuration = 0
				arg_553_1.dialogCg_.alpha = 1

				arg_553_1.dialog_:SetActive(true)
				SetActive(arg_553_1.leftNameGo_, true)

				local var_556_17 = arg_553_1:FormatText(StoryNameCfg[181].name)

				arg_553_1.leftNameTxt_.text = var_556_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_553_1.leftNameTxt_.transform)

				arg_553_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_553_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_553_1:RecordName(arg_553_1.leftNameTxt_.text)
				SetActive(arg_553_1.iconTrs_.gameObject, false)
				arg_553_1.callingController_:SetSelectedState("normal")

				local var_556_18 = arg_553_1:GetWordFromCfg(1109402134)
				local var_556_19 = arg_553_1:FormatText(var_556_18.content)

				arg_553_1.text_.text = var_556_19

				LuaForUtil.ClearLinePrefixSymbol(arg_553_1.text_)

				local var_556_20 = 3
				local var_556_21 = utf8.len(var_556_19)
				local var_556_22 = var_556_20 <= 0 and var_556_16 or var_556_16 * (var_556_21 / var_556_20)

				if var_556_22 > 0 and var_556_16 < var_556_22 then
					arg_553_1.talkMaxDuration = var_556_22

					if var_556_22 + var_556_15 > arg_553_1.duration_ then
						arg_553_1.duration_ = var_556_22 + var_556_15
					end
				end

				arg_553_1.text_.text = var_556_19
				arg_553_1.typewritter.percent = 0

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402134", "story_v_side_new_1109402.awb") ~= 0 then
					local var_556_23 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402134", "story_v_side_new_1109402.awb") / 1000

					if var_556_23 + var_556_15 > arg_553_1.duration_ then
						arg_553_1.duration_ = var_556_23 + var_556_15
					end

					if var_556_18.prefab_name ~= "" and arg_553_1.actors_[var_556_18.prefab_name] ~= nil then
						local var_556_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_553_1.actors_[var_556_18.prefab_name].transform, "story_v_side_new_1109402", "1109402134", "story_v_side_new_1109402.awb")

						arg_553_1:RecordAudio("1109402134", var_556_24)
						arg_553_1:RecordAudio("1109402134", var_556_24)
					else
						arg_553_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402134", "story_v_side_new_1109402.awb")
					end

					arg_553_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402134", "story_v_side_new_1109402.awb")
				end

				arg_553_1:RecordContent(arg_553_1.text_.text)
			end

			local var_556_25 = math.max(var_556_16, arg_553_1.talkMaxDuration)

			if var_556_15 <= arg_553_1.time_ and arg_553_1.time_ < var_556_15 + var_556_25 then
				arg_553_1.typewritter.percent = (arg_553_1.time_ - var_556_15) / var_556_25

				arg_553_1.typewritter:SetDirty()
			end

			if arg_553_1.time_ >= var_556_15 + var_556_25 and arg_553_1.time_ < var_556_15 + var_556_25 + arg_556_0 then
				arg_553_1.typewritter.percent = 1

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(true)
			end
		end

		arg_553_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_553_1:InitPlayNodeList()
	end,
	Play1109402135 = function(arg_557_0, arg_557_1)
		arg_557_1.time_ = 0
		arg_557_1.frameCnt_ = 0
		arg_557_1.state_ = "playing"
		arg_557_1.curTalkId_ = 1109402135
		arg_557_1.duration_ = 5

		SetActive(arg_557_1.tipsGo_, false)

		function arg_557_1.onSingleLineFinish_()
			arg_557_1.onSingleLineUpdate_ = nil
			arg_557_1.onSingleLineFinish_ = nil
			arg_557_1.state_ = "waiting"
		end

		function arg_557_1.playNext_(arg_559_0)
			if arg_559_0 == 1 then
				arg_557_0:Play1109402136(arg_557_1)
			end
		end

		function arg_557_1.onSingleLineUpdate_(arg_560_0)
			local var_560_0 = arg_557_1.actors_["1094ui_story"]
			local var_560_1 = 0

			if var_560_1 < arg_557_1.time_ and arg_557_1.time_ <= var_560_1 + arg_560_0 and not isNil(var_560_0) and arg_557_1.var_.characterEffect1094ui_story == nil then
				arg_557_1.var_.characterEffect1094ui_story = var_560_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_560_2 = 0.200000002980232

			if var_560_1 <= arg_557_1.time_ and arg_557_1.time_ < var_560_1 + var_560_2 and not isNil(var_560_0) then
				local var_560_3 = (arg_557_1.time_ - var_560_1) / var_560_2

				if arg_557_1.var_.characterEffect1094ui_story and not isNil(var_560_0) then
					local var_560_4 = Mathf.Lerp(0, 0.5, var_560_3)

					arg_557_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_557_1.var_.characterEffect1094ui_story.fillRatio = var_560_4
				end
			end

			if arg_557_1.time_ >= var_560_1 + var_560_2 and arg_557_1.time_ < var_560_1 + var_560_2 + arg_560_0 and not isNil(var_560_0) and arg_557_1.var_.characterEffect1094ui_story then
				local var_560_5 = 0.5

				arg_557_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_557_1.var_.characterEffect1094ui_story.fillRatio = var_560_5
			end

			local var_560_6 = 0
			local var_560_7 = 0.625

			if var_560_6 < arg_557_1.time_ and arg_557_1.time_ <= var_560_6 + arg_560_0 then
				arg_557_1.talkMaxDuration = 0
				arg_557_1.dialogCg_.alpha = 1

				arg_557_1.dialog_:SetActive(true)
				SetActive(arg_557_1.leftNameGo_, true)

				local var_560_8 = arg_557_1:FormatText(StoryNameCfg[7].name)

				arg_557_1.leftNameTxt_.text = var_560_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_557_1.leftNameTxt_.transform)

				arg_557_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_557_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_557_1:RecordName(arg_557_1.leftNameTxt_.text)
				SetActive(arg_557_1.iconTrs_.gameObject, true)
				arg_557_1.iconController_:SetSelectedState("hero")

				arg_557_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_557_1.callingController_:SetSelectedState("normal")

				arg_557_1.keyicon_.color = Color.New(1, 1, 1)
				arg_557_1.icon_.color = Color.New(1, 1, 1)

				local var_560_9 = arg_557_1:GetWordFromCfg(1109402135)
				local var_560_10 = arg_557_1:FormatText(var_560_9.content)

				arg_557_1.text_.text = var_560_10

				LuaForUtil.ClearLinePrefixSymbol(arg_557_1.text_)

				local var_560_11 = 25
				local var_560_12 = utf8.len(var_560_10)
				local var_560_13 = var_560_11 <= 0 and var_560_7 or var_560_7 * (var_560_12 / var_560_11)

				if var_560_13 > 0 and var_560_7 < var_560_13 then
					arg_557_1.talkMaxDuration = var_560_13

					if var_560_13 + var_560_6 > arg_557_1.duration_ then
						arg_557_1.duration_ = var_560_13 + var_560_6
					end
				end

				arg_557_1.text_.text = var_560_10
				arg_557_1.typewritter.percent = 0

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(false)
				arg_557_1:RecordContent(arg_557_1.text_.text)
			end

			local var_560_14 = math.max(var_560_7, arg_557_1.talkMaxDuration)

			if var_560_6 <= arg_557_1.time_ and arg_557_1.time_ < var_560_6 + var_560_14 then
				arg_557_1.typewritter.percent = (arg_557_1.time_ - var_560_6) / var_560_14

				arg_557_1.typewritter:SetDirty()
			end

			if arg_557_1.time_ >= var_560_6 + var_560_14 and arg_557_1.time_ < var_560_6 + var_560_14 + arg_560_0 then
				arg_557_1.typewritter.percent = 1

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(true)
			end
		end

		arg_557_1.nodeConfigList_ = {}

		arg_557_1:InitPlayNodeList()
	end,
	Play1109402136 = function(arg_561_0, arg_561_1)
		arg_561_1.time_ = 0
		arg_561_1.frameCnt_ = 0
		arg_561_1.state_ = "playing"
		arg_561_1.curTalkId_ = 1109402136
		arg_561_1.duration_ = 5.2

		local var_561_0 = {
			ja = 5.2,
			ko = 3.433,
			zh = 3.433
		}
		local var_561_1 = manager.audio:GetLocalizationFlag()

		if var_561_0[var_561_1] ~= nil then
			arg_561_1.duration_ = var_561_0[var_561_1]
		end

		SetActive(arg_561_1.tipsGo_, false)

		function arg_561_1.onSingleLineFinish_()
			arg_561_1.onSingleLineUpdate_ = nil
			arg_561_1.onSingleLineFinish_ = nil
			arg_561_1.state_ = "waiting"
		end

		function arg_561_1.playNext_(arg_563_0)
			if arg_563_0 == 1 then
				arg_561_0:Play1109402137(arg_561_1)
			end
		end

		function arg_561_1.onSingleLineUpdate_(arg_564_0)
			local var_564_0 = arg_561_1.actors_["1094ui_story"].transform
			local var_564_1 = 0

			if var_564_1 < arg_561_1.time_ and arg_561_1.time_ <= var_564_1 + arg_564_0 then
				arg_561_1.var_.moveOldPos1094ui_story = var_564_0.localPosition
			end

			local var_564_2 = 0.001

			if var_564_1 <= arg_561_1.time_ and arg_561_1.time_ < var_564_1 + var_564_2 then
				local var_564_3 = (arg_561_1.time_ - var_564_1) / var_564_2
				local var_564_4 = Vector3.New(0, -0.84, -6.1)

				var_564_0.localPosition = Vector3.Lerp(arg_561_1.var_.moveOldPos1094ui_story, var_564_4, var_564_3)

				local var_564_5 = manager.ui.mainCamera.transform.position - var_564_0.position

				var_564_0.forward = Vector3.New(var_564_5.x, var_564_5.y, var_564_5.z)

				local var_564_6 = var_564_0.localEulerAngles

				var_564_6.z = 0
				var_564_6.x = 0
				var_564_0.localEulerAngles = var_564_6
			end

			if arg_561_1.time_ >= var_564_1 + var_564_2 and arg_561_1.time_ < var_564_1 + var_564_2 + arg_564_0 then
				var_564_0.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_564_7 = manager.ui.mainCamera.transform.position - var_564_0.position

				var_564_0.forward = Vector3.New(var_564_7.x, var_564_7.y, var_564_7.z)

				local var_564_8 = var_564_0.localEulerAngles

				var_564_8.z = 0
				var_564_8.x = 0
				var_564_0.localEulerAngles = var_564_8
			end

			local var_564_9 = arg_561_1.actors_["1094ui_story"]
			local var_564_10 = 0

			if var_564_10 < arg_561_1.time_ and arg_561_1.time_ <= var_564_10 + arg_564_0 and not isNil(var_564_9) and arg_561_1.var_.characterEffect1094ui_story == nil then
				arg_561_1.var_.characterEffect1094ui_story = var_564_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_564_11 = 0.200000002980232

			if var_564_10 <= arg_561_1.time_ and arg_561_1.time_ < var_564_10 + var_564_11 and not isNil(var_564_9) then
				local var_564_12 = (arg_561_1.time_ - var_564_10) / var_564_11

				if arg_561_1.var_.characterEffect1094ui_story and not isNil(var_564_9) then
					arg_561_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_561_1.time_ >= var_564_10 + var_564_11 and arg_561_1.time_ < var_564_10 + var_564_11 + arg_564_0 and not isNil(var_564_9) and arg_561_1.var_.characterEffect1094ui_story then
				arg_561_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_564_13 = 0

			if var_564_13 < arg_561_1.time_ and arg_561_1.time_ <= var_564_13 + arg_564_0 then
				arg_561_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_564_14 = 0
			local var_564_15 = 0.3

			if var_564_14 < arg_561_1.time_ and arg_561_1.time_ <= var_564_14 + arg_564_0 then
				arg_561_1.talkMaxDuration = 0
				arg_561_1.dialogCg_.alpha = 1

				arg_561_1.dialog_:SetActive(true)
				SetActive(arg_561_1.leftNameGo_, true)

				local var_564_16 = arg_561_1:FormatText(StoryNameCfg[181].name)

				arg_561_1.leftNameTxt_.text = var_564_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_561_1.leftNameTxt_.transform)

				arg_561_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_561_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_561_1:RecordName(arg_561_1.leftNameTxt_.text)
				SetActive(arg_561_1.iconTrs_.gameObject, false)
				arg_561_1.callingController_:SetSelectedState("normal")

				local var_564_17 = arg_561_1:GetWordFromCfg(1109402136)
				local var_564_18 = arg_561_1:FormatText(var_564_17.content)

				arg_561_1.text_.text = var_564_18

				LuaForUtil.ClearLinePrefixSymbol(arg_561_1.text_)

				local var_564_19 = 12
				local var_564_20 = utf8.len(var_564_18)
				local var_564_21 = var_564_19 <= 0 and var_564_15 or var_564_15 * (var_564_20 / var_564_19)

				if var_564_21 > 0 and var_564_15 < var_564_21 then
					arg_561_1.talkMaxDuration = var_564_21

					if var_564_21 + var_564_14 > arg_561_1.duration_ then
						arg_561_1.duration_ = var_564_21 + var_564_14
					end
				end

				arg_561_1.text_.text = var_564_18
				arg_561_1.typewritter.percent = 0

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402136", "story_v_side_new_1109402.awb") ~= 0 then
					local var_564_22 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402136", "story_v_side_new_1109402.awb") / 1000

					if var_564_22 + var_564_14 > arg_561_1.duration_ then
						arg_561_1.duration_ = var_564_22 + var_564_14
					end

					if var_564_17.prefab_name ~= "" and arg_561_1.actors_[var_564_17.prefab_name] ~= nil then
						local var_564_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_561_1.actors_[var_564_17.prefab_name].transform, "story_v_side_new_1109402", "1109402136", "story_v_side_new_1109402.awb")

						arg_561_1:RecordAudio("1109402136", var_564_23)
						arg_561_1:RecordAudio("1109402136", var_564_23)
					else
						arg_561_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402136", "story_v_side_new_1109402.awb")
					end

					arg_561_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402136", "story_v_side_new_1109402.awb")
				end

				arg_561_1:RecordContent(arg_561_1.text_.text)
			end

			local var_564_24 = math.max(var_564_15, arg_561_1.talkMaxDuration)

			if var_564_14 <= arg_561_1.time_ and arg_561_1.time_ < var_564_14 + var_564_24 then
				arg_561_1.typewritter.percent = (arg_561_1.time_ - var_564_14) / var_564_24

				arg_561_1.typewritter:SetDirty()
			end

			if arg_561_1.time_ >= var_564_14 + var_564_24 and arg_561_1.time_ < var_564_14 + var_564_24 + arg_564_0 then
				arg_561_1.typewritter.percent = 1

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(true)
			end
		end

		arg_561_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_561_1:InitPlayNodeList()
	end,
	Play1109402137 = function(arg_565_0, arg_565_1)
		arg_565_1.time_ = 0
		arg_565_1.frameCnt_ = 0
		arg_565_1.state_ = "playing"
		arg_565_1.curTalkId_ = 1109402137
		arg_565_1.duration_ = 5

		SetActive(arg_565_1.tipsGo_, false)

		function arg_565_1.onSingleLineFinish_()
			arg_565_1.onSingleLineUpdate_ = nil
			arg_565_1.onSingleLineFinish_ = nil
			arg_565_1.state_ = "waiting"
		end

		function arg_565_1.playNext_(arg_567_0)
			if arg_567_0 == 1 then
				arg_565_0:Play1109402138(arg_565_1)
			end
		end

		function arg_565_1.onSingleLineUpdate_(arg_568_0)
			local var_568_0 = arg_565_1.actors_["1094ui_story"]
			local var_568_1 = 0

			if var_568_1 < arg_565_1.time_ and arg_565_1.time_ <= var_568_1 + arg_568_0 and not isNil(var_568_0) and arg_565_1.var_.characterEffect1094ui_story == nil then
				arg_565_1.var_.characterEffect1094ui_story = var_568_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_568_2 = 0.200000002980232

			if var_568_1 <= arg_565_1.time_ and arg_565_1.time_ < var_568_1 + var_568_2 and not isNil(var_568_0) then
				local var_568_3 = (arg_565_1.time_ - var_568_1) / var_568_2

				if arg_565_1.var_.characterEffect1094ui_story and not isNil(var_568_0) then
					local var_568_4 = Mathf.Lerp(0, 0.5, var_568_3)

					arg_565_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_565_1.var_.characterEffect1094ui_story.fillRatio = var_568_4
				end
			end

			if arg_565_1.time_ >= var_568_1 + var_568_2 and arg_565_1.time_ < var_568_1 + var_568_2 + arg_568_0 and not isNil(var_568_0) and arg_565_1.var_.characterEffect1094ui_story then
				local var_568_5 = 0.5

				arg_565_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_565_1.var_.characterEffect1094ui_story.fillRatio = var_568_5
			end

			local var_568_6 = 0
			local var_568_7 = 0.425

			if var_568_6 < arg_565_1.time_ and arg_565_1.time_ <= var_568_6 + arg_568_0 then
				arg_565_1.talkMaxDuration = 0
				arg_565_1.dialogCg_.alpha = 1

				arg_565_1.dialog_:SetActive(true)
				SetActive(arg_565_1.leftNameGo_, true)

				local var_568_8 = arg_565_1:FormatText(StoryNameCfg[7].name)

				arg_565_1.leftNameTxt_.text = var_568_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_565_1.leftNameTxt_.transform)

				arg_565_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_565_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_565_1:RecordName(arg_565_1.leftNameTxt_.text)
				SetActive(arg_565_1.iconTrs_.gameObject, true)
				arg_565_1.iconController_:SetSelectedState("hero")

				arg_565_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_565_1.callingController_:SetSelectedState("normal")

				arg_565_1.keyicon_.color = Color.New(1, 1, 1)
				arg_565_1.icon_.color = Color.New(1, 1, 1)

				local var_568_9 = arg_565_1:GetWordFromCfg(1109402137)
				local var_568_10 = arg_565_1:FormatText(var_568_9.content)

				arg_565_1.text_.text = var_568_10

				LuaForUtil.ClearLinePrefixSymbol(arg_565_1.text_)

				local var_568_11 = 17
				local var_568_12 = utf8.len(var_568_10)
				local var_568_13 = var_568_11 <= 0 and var_568_7 or var_568_7 * (var_568_12 / var_568_11)

				if var_568_13 > 0 and var_568_7 < var_568_13 then
					arg_565_1.talkMaxDuration = var_568_13

					if var_568_13 + var_568_6 > arg_565_1.duration_ then
						arg_565_1.duration_ = var_568_13 + var_568_6
					end
				end

				arg_565_1.text_.text = var_568_10
				arg_565_1.typewritter.percent = 0

				arg_565_1.typewritter:SetDirty()
				arg_565_1:ShowNextGo(false)
				arg_565_1:RecordContent(arg_565_1.text_.text)
			end

			local var_568_14 = math.max(var_568_7, arg_565_1.talkMaxDuration)

			if var_568_6 <= arg_565_1.time_ and arg_565_1.time_ < var_568_6 + var_568_14 then
				arg_565_1.typewritter.percent = (arg_565_1.time_ - var_568_6) / var_568_14

				arg_565_1.typewritter:SetDirty()
			end

			if arg_565_1.time_ >= var_568_6 + var_568_14 and arg_565_1.time_ < var_568_6 + var_568_14 + arg_568_0 then
				arg_565_1.typewritter.percent = 1

				arg_565_1.typewritter:SetDirty()
				arg_565_1:ShowNextGo(true)
			end
		end

		arg_565_1.nodeConfigList_ = {}

		arg_565_1:InitPlayNodeList()
	end,
	Play1109402138 = function(arg_569_0, arg_569_1)
		arg_569_1.time_ = 0
		arg_569_1.frameCnt_ = 0
		arg_569_1.state_ = "playing"
		arg_569_1.curTalkId_ = 1109402138
		arg_569_1.duration_ = 2

		SetActive(arg_569_1.tipsGo_, false)

		function arg_569_1.onSingleLineFinish_()
			arg_569_1.onSingleLineUpdate_ = nil
			arg_569_1.onSingleLineFinish_ = nil
			arg_569_1.state_ = "waiting"
		end

		function arg_569_1.playNext_(arg_571_0)
			if arg_571_0 == 1 then
				arg_569_0:Play1109402139(arg_569_1)
			end
		end

		function arg_569_1.onSingleLineUpdate_(arg_572_0)
			local var_572_0 = arg_569_1.actors_["1094ui_story"].transform
			local var_572_1 = 0

			if var_572_1 < arg_569_1.time_ and arg_569_1.time_ <= var_572_1 + arg_572_0 then
				arg_569_1.var_.moveOldPos1094ui_story = var_572_0.localPosition
			end

			local var_572_2 = 0.001

			if var_572_1 <= arg_569_1.time_ and arg_569_1.time_ < var_572_1 + var_572_2 then
				local var_572_3 = (arg_569_1.time_ - var_572_1) / var_572_2
				local var_572_4 = Vector3.New(0, -0.84, -6.1)

				var_572_0.localPosition = Vector3.Lerp(arg_569_1.var_.moveOldPos1094ui_story, var_572_4, var_572_3)

				local var_572_5 = manager.ui.mainCamera.transform.position - var_572_0.position

				var_572_0.forward = Vector3.New(var_572_5.x, var_572_5.y, var_572_5.z)

				local var_572_6 = var_572_0.localEulerAngles

				var_572_6.z = 0
				var_572_6.x = 0
				var_572_0.localEulerAngles = var_572_6
			end

			if arg_569_1.time_ >= var_572_1 + var_572_2 and arg_569_1.time_ < var_572_1 + var_572_2 + arg_572_0 then
				var_572_0.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_572_7 = manager.ui.mainCamera.transform.position - var_572_0.position

				var_572_0.forward = Vector3.New(var_572_7.x, var_572_7.y, var_572_7.z)

				local var_572_8 = var_572_0.localEulerAngles

				var_572_8.z = 0
				var_572_8.x = 0
				var_572_0.localEulerAngles = var_572_8
			end

			local var_572_9 = arg_569_1.actors_["1094ui_story"]
			local var_572_10 = 0

			if var_572_10 < arg_569_1.time_ and arg_569_1.time_ <= var_572_10 + arg_572_0 and not isNil(var_572_9) and arg_569_1.var_.characterEffect1094ui_story == nil then
				arg_569_1.var_.characterEffect1094ui_story = var_572_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_572_11 = 0.200000002980232

			if var_572_10 <= arg_569_1.time_ and arg_569_1.time_ < var_572_10 + var_572_11 and not isNil(var_572_9) then
				local var_572_12 = (arg_569_1.time_ - var_572_10) / var_572_11

				if arg_569_1.var_.characterEffect1094ui_story and not isNil(var_572_9) then
					arg_569_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_569_1.time_ >= var_572_10 + var_572_11 and arg_569_1.time_ < var_572_10 + var_572_11 + arg_572_0 and not isNil(var_572_9) and arg_569_1.var_.characterEffect1094ui_story then
				arg_569_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_572_13 = 0

			if var_572_13 < arg_569_1.time_ and arg_569_1.time_ <= var_572_13 + arg_572_0 then
				arg_569_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_572_14 = 0
			local var_572_15 = 0.15

			if var_572_14 < arg_569_1.time_ and arg_569_1.time_ <= var_572_14 + arg_572_0 then
				arg_569_1.talkMaxDuration = 0
				arg_569_1.dialogCg_.alpha = 1

				arg_569_1.dialog_:SetActive(true)
				SetActive(arg_569_1.leftNameGo_, true)

				local var_572_16 = arg_569_1:FormatText(StoryNameCfg[181].name)

				arg_569_1.leftNameTxt_.text = var_572_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_569_1.leftNameTxt_.transform)

				arg_569_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_569_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_569_1:RecordName(arg_569_1.leftNameTxt_.text)
				SetActive(arg_569_1.iconTrs_.gameObject, false)
				arg_569_1.callingController_:SetSelectedState("normal")

				local var_572_17 = arg_569_1:GetWordFromCfg(1109402138)
				local var_572_18 = arg_569_1:FormatText(var_572_17.content)

				arg_569_1.text_.text = var_572_18

				LuaForUtil.ClearLinePrefixSymbol(arg_569_1.text_)

				local var_572_19 = 6
				local var_572_20 = utf8.len(var_572_18)
				local var_572_21 = var_572_19 <= 0 and var_572_15 or var_572_15 * (var_572_20 / var_572_19)

				if var_572_21 > 0 and var_572_15 < var_572_21 then
					arg_569_1.talkMaxDuration = var_572_21

					if var_572_21 + var_572_14 > arg_569_1.duration_ then
						arg_569_1.duration_ = var_572_21 + var_572_14
					end
				end

				arg_569_1.text_.text = var_572_18
				arg_569_1.typewritter.percent = 0

				arg_569_1.typewritter:SetDirty()
				arg_569_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402138", "story_v_side_new_1109402.awb") ~= 0 then
					local var_572_22 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402138", "story_v_side_new_1109402.awb") / 1000

					if var_572_22 + var_572_14 > arg_569_1.duration_ then
						arg_569_1.duration_ = var_572_22 + var_572_14
					end

					if var_572_17.prefab_name ~= "" and arg_569_1.actors_[var_572_17.prefab_name] ~= nil then
						local var_572_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_569_1.actors_[var_572_17.prefab_name].transform, "story_v_side_new_1109402", "1109402138", "story_v_side_new_1109402.awb")

						arg_569_1:RecordAudio("1109402138", var_572_23)
						arg_569_1:RecordAudio("1109402138", var_572_23)
					else
						arg_569_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402138", "story_v_side_new_1109402.awb")
					end

					arg_569_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402138", "story_v_side_new_1109402.awb")
				end

				arg_569_1:RecordContent(arg_569_1.text_.text)
			end

			local var_572_24 = math.max(var_572_15, arg_569_1.talkMaxDuration)

			if var_572_14 <= arg_569_1.time_ and arg_569_1.time_ < var_572_14 + var_572_24 then
				arg_569_1.typewritter.percent = (arg_569_1.time_ - var_572_14) / var_572_24

				arg_569_1.typewritter:SetDirty()
			end

			if arg_569_1.time_ >= var_572_14 + var_572_24 and arg_569_1.time_ < var_572_14 + var_572_24 + arg_572_0 then
				arg_569_1.typewritter.percent = 1

				arg_569_1.typewritter:SetDirty()
				arg_569_1:ShowNextGo(true)
			end
		end

		arg_569_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_569_1:InitPlayNodeList()
	end,
	Play1109402139 = function(arg_573_0, arg_573_1)
		arg_573_1.time_ = 0
		arg_573_1.frameCnt_ = 0
		arg_573_1.state_ = "playing"
		arg_573_1.curTalkId_ = 1109402139
		arg_573_1.duration_ = 9

		SetActive(arg_573_1.tipsGo_, false)

		function arg_573_1.onSingleLineFinish_()
			arg_573_1.onSingleLineUpdate_ = nil
			arg_573_1.onSingleLineFinish_ = nil
			arg_573_1.state_ = "waiting"
		end

		function arg_573_1.playNext_(arg_575_0)
			if arg_575_0 == 1 then
				arg_573_0:Play1109402140(arg_573_1)
			end
		end

		function arg_573_1.onSingleLineUpdate_(arg_576_0)
			local var_576_0 = "I05a"

			if arg_573_1.bgs_[var_576_0] == nil then
				local var_576_1 = Object.Instantiate(arg_573_1.paintGo_)

				var_576_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_576_0)
				var_576_1.name = var_576_0
				var_576_1.transform.parent = arg_573_1.stage_.transform
				var_576_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_573_1.bgs_[var_576_0] = var_576_1
			end

			local var_576_2 = 2

			if var_576_2 < arg_573_1.time_ and arg_573_1.time_ <= var_576_2 + arg_576_0 then
				if arg_573_0.sceneSettingEffect_ then
					arg_573_1.sceneSettingEffect_.enabled = false
				end

				arg_573_1.sceneSettingGo_:SetActive(true)

				local var_576_3 = manager.ui.mainCamera.transform.localPosition
				local var_576_4 = Vector3.New(0, 0, 10) + Vector3.New(var_576_3.x, var_576_3.y, 0)
				local var_576_5 = arg_573_1.bgs_.I05a

				var_576_5.transform.localPosition = var_576_4
				var_576_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_576_6 = var_576_5:GetComponent("SpriteRenderer")

				if var_576_6 and var_576_6.sprite then
					local var_576_7 = (var_576_5.transform.localPosition - var_576_3).z
					local var_576_8 = manager.ui.mainCameraCom_
					local var_576_9 = 2 * var_576_7 * Mathf.Tan(var_576_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_576_10 = var_576_9 * var_576_8.aspect
					local var_576_11 = var_576_6.sprite.bounds.size.x
					local var_576_12 = var_576_6.sprite.bounds.size.y
					local var_576_13 = var_576_10 / var_576_11
					local var_576_14 = var_576_9 / var_576_12
					local var_576_15 = var_576_14 < var_576_13 and var_576_13 or var_576_14

					var_576_5.transform.localScale = Vector3.New(var_576_15, var_576_15, 0)
				end

				for iter_576_0, iter_576_1 in pairs(arg_573_1.bgs_) do
					if iter_576_0 ~= "I05a" then
						iter_576_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_576_16 = 0

			if var_576_16 < arg_573_1.time_ and arg_573_1.time_ <= var_576_16 + arg_576_0 then
				arg_573_1.mask_.enabled = true
				arg_573_1.mask_.raycastTarget = true

				arg_573_1:SetGaussion(false)
			end

			local var_576_17 = 2

			if var_576_16 <= arg_573_1.time_ and arg_573_1.time_ < var_576_16 + var_576_17 then
				local var_576_18 = (arg_573_1.time_ - var_576_16) / var_576_17
				local var_576_19 = Color.New(0, 0, 0)

				var_576_19.a = Mathf.Lerp(0, 1, var_576_18)
				arg_573_1.mask_.color = var_576_19
			end

			if arg_573_1.time_ >= var_576_16 + var_576_17 and arg_573_1.time_ < var_576_16 + var_576_17 + arg_576_0 then
				local var_576_20 = Color.New(0, 0, 0)

				var_576_20.a = 1
				arg_573_1.mask_.color = var_576_20
			end

			local var_576_21 = 2

			if var_576_21 < arg_573_1.time_ and arg_573_1.time_ <= var_576_21 + arg_576_0 then
				arg_573_1.mask_.enabled = true
				arg_573_1.mask_.raycastTarget = true

				arg_573_1:SetGaussion(false)
			end

			local var_576_22 = 2

			if var_576_21 <= arg_573_1.time_ and arg_573_1.time_ < var_576_21 + var_576_22 then
				local var_576_23 = (arg_573_1.time_ - var_576_21) / var_576_22
				local var_576_24 = Color.New(0, 0, 0)

				var_576_24.a = Mathf.Lerp(1, 0, var_576_23)
				arg_573_1.mask_.color = var_576_24
			end

			if arg_573_1.time_ >= var_576_21 + var_576_22 and arg_573_1.time_ < var_576_21 + var_576_22 + arg_576_0 then
				local var_576_25 = Color.New(0, 0, 0)
				local var_576_26 = 0

				arg_573_1.mask_.enabled = false
				var_576_25.a = var_576_26
				arg_573_1.mask_.color = var_576_25
			end

			local var_576_27 = arg_573_1.actors_["1094ui_story"].transform
			local var_576_28 = 0

			if var_576_28 < arg_573_1.time_ and arg_573_1.time_ <= var_576_28 + arg_576_0 then
				arg_573_1.var_.moveOldPos1094ui_story = var_576_27.localPosition
			end

			local var_576_29 = 0.001

			if var_576_28 <= arg_573_1.time_ and arg_573_1.time_ < var_576_28 + var_576_29 then
				local var_576_30 = (arg_573_1.time_ - var_576_28) / var_576_29
				local var_576_31 = Vector3.New(0, 100, 0)

				var_576_27.localPosition = Vector3.Lerp(arg_573_1.var_.moveOldPos1094ui_story, var_576_31, var_576_30)

				local var_576_32 = manager.ui.mainCamera.transform.position - var_576_27.position

				var_576_27.forward = Vector3.New(var_576_32.x, var_576_32.y, var_576_32.z)

				local var_576_33 = var_576_27.localEulerAngles

				var_576_33.z = 0
				var_576_33.x = 0
				var_576_27.localEulerAngles = var_576_33
			end

			if arg_573_1.time_ >= var_576_28 + var_576_29 and arg_573_1.time_ < var_576_28 + var_576_29 + arg_576_0 then
				var_576_27.localPosition = Vector3.New(0, 100, 0)

				local var_576_34 = manager.ui.mainCamera.transform.position - var_576_27.position

				var_576_27.forward = Vector3.New(var_576_34.x, var_576_34.y, var_576_34.z)

				local var_576_35 = var_576_27.localEulerAngles

				var_576_35.z = 0
				var_576_35.x = 0
				var_576_27.localEulerAngles = var_576_35
			end

			local var_576_36 = arg_573_1.actors_["1094ui_story"]
			local var_576_37 = 0

			if var_576_37 < arg_573_1.time_ and arg_573_1.time_ <= var_576_37 + arg_576_0 and not isNil(var_576_36) and arg_573_1.var_.characterEffect1094ui_story == nil then
				arg_573_1.var_.characterEffect1094ui_story = var_576_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_576_38 = 0.200000002980232

			if var_576_37 <= arg_573_1.time_ and arg_573_1.time_ < var_576_37 + var_576_38 and not isNil(var_576_36) then
				local var_576_39 = (arg_573_1.time_ - var_576_37) / var_576_38

				if arg_573_1.var_.characterEffect1094ui_story and not isNil(var_576_36) then
					local var_576_40 = Mathf.Lerp(0, 0.5, var_576_39)

					arg_573_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_573_1.var_.characterEffect1094ui_story.fillRatio = var_576_40
				end
			end

			if arg_573_1.time_ >= var_576_37 + var_576_38 and arg_573_1.time_ < var_576_37 + var_576_38 + arg_576_0 and not isNil(var_576_36) and arg_573_1.var_.characterEffect1094ui_story then
				local var_576_41 = 0.5

				arg_573_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_573_1.var_.characterEffect1094ui_story.fillRatio = var_576_41
			end

			local var_576_42 = 4
			local var_576_43 = 1

			if var_576_42 < arg_573_1.time_ and arg_573_1.time_ <= var_576_42 + arg_576_0 then
				local var_576_44 = "play"
				local var_576_45 = "effect"

				arg_573_1:AudioAction(var_576_44, var_576_45, "se_story_side_1094", "se_story_1094_chime", "")
			end

			if arg_573_1.frameCnt_ <= 1 then
				arg_573_1.dialog_:SetActive(false)
			end

			local var_576_46 = 4
			local var_576_47 = 1

			if var_576_46 < arg_573_1.time_ and arg_573_1.time_ <= var_576_46 + arg_576_0 then
				arg_573_1.talkMaxDuration = 0

				arg_573_1.dialog_:SetActive(true)

				arg_573_1.dialogCg_.alpha = 0

				local var_576_48 = LeanTween.value(arg_573_1.dialog_, 0, 1, 0.3)

				var_576_48:setOnUpdate(LuaHelper.FloatAction(function(arg_577_0)
					arg_573_1.dialogCg_.alpha = arg_577_0
				end))
				var_576_48:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_573_1.dialog_)
					var_576_48:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_573_1.duration_ = arg_573_1.duration_ + 0.3

				SetActive(arg_573_1.leftNameGo_, false)

				arg_573_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_573_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_573_1:RecordName(arg_573_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_573_1.iconTrs_.gameObject, false)
				arg_573_1.callingController_:SetSelectedState("normal")

				local var_576_49 = arg_573_1:GetWordFromCfg(1109402139)
				local var_576_50 = arg_573_1:FormatText(var_576_49.content)

				arg_573_1.text_.text = var_576_50

				LuaForUtil.ClearLinePrefixSymbol(arg_573_1.text_)

				local var_576_51 = 40
				local var_576_52 = utf8.len(var_576_50)
				local var_576_53 = var_576_51 <= 0 and var_576_47 or var_576_47 * (var_576_52 / var_576_51)

				if var_576_53 > 0 and var_576_47 < var_576_53 then
					arg_573_1.talkMaxDuration = var_576_53
					var_576_46 = var_576_46 + 0.3

					if var_576_53 + var_576_46 > arg_573_1.duration_ then
						arg_573_1.duration_ = var_576_53 + var_576_46
					end
				end

				arg_573_1.text_.text = var_576_50
				arg_573_1.typewritter.percent = 0

				arg_573_1.typewritter:SetDirty()
				arg_573_1:ShowNextGo(false)
				arg_573_1:RecordContent(arg_573_1.text_.text)
			end

			local var_576_54 = var_576_46 + 0.3
			local var_576_55 = math.max(var_576_47, arg_573_1.talkMaxDuration)

			if var_576_54 <= arg_573_1.time_ and arg_573_1.time_ < var_576_54 + var_576_55 then
				arg_573_1.typewritter.percent = (arg_573_1.time_ - var_576_54) / var_576_55

				arg_573_1.typewritter:SetDirty()
			end

			if arg_573_1.time_ >= var_576_54 + var_576_55 and arg_573_1.time_ < var_576_54 + var_576_55 + arg_576_0 then
				arg_573_1.typewritter.percent = 1

				arg_573_1.typewritter:SetDirty()
				arg_573_1:ShowNextGo(true)
			end
		end

		arg_573_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_573_1:InitPlayNodeList()
	end,
	Play1109402140 = function(arg_579_0, arg_579_1)
		arg_579_1.time_ = 0
		arg_579_1.frameCnt_ = 0
		arg_579_1.state_ = "playing"
		arg_579_1.curTalkId_ = 1109402140
		arg_579_1.duration_ = 3.93

		local var_579_0 = {
			ja = 3.933,
			ko = 3.9,
			zh = 3.9
		}
		local var_579_1 = manager.audio:GetLocalizationFlag()

		if var_579_0[var_579_1] ~= nil then
			arg_579_1.duration_ = var_579_0[var_579_1]
		end

		SetActive(arg_579_1.tipsGo_, false)

		function arg_579_1.onSingleLineFinish_()
			arg_579_1.onSingleLineUpdate_ = nil
			arg_579_1.onSingleLineFinish_ = nil
			arg_579_1.state_ = "waiting"
		end

		function arg_579_1.playNext_(arg_581_0)
			if arg_581_0 == 1 then
				arg_579_0:Play1109402141(arg_579_1)
			end
		end

		function arg_579_1.onSingleLineUpdate_(arg_582_0)
			local var_582_0 = 0
			local var_582_1 = 0.35

			if var_582_0 < arg_579_1.time_ and arg_579_1.time_ <= var_582_0 + arg_582_0 then
				arg_579_1.talkMaxDuration = 0
				arg_579_1.dialogCg_.alpha = 1

				arg_579_1.dialog_:SetActive(true)
				SetActive(arg_579_1.leftNameGo_, true)

				local var_582_2 = arg_579_1:FormatText(StoryNameCfg[189].name)

				arg_579_1.leftNameTxt_.text = var_582_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_579_1.leftNameTxt_.transform)

				arg_579_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_579_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_579_1:RecordName(arg_579_1.leftNameTxt_.text)
				SetActive(arg_579_1.iconTrs_.gameObject, true)
				arg_579_1.iconController_:SetSelectedState("hero")

				arg_579_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vina")

				arg_579_1.callingController_:SetSelectedState("normal")

				arg_579_1.keyicon_.color = Color.New(1, 1, 1)
				arg_579_1.icon_.color = Color.New(1, 1, 1)

				local var_582_3 = arg_579_1:GetWordFromCfg(1109402140)
				local var_582_4 = arg_579_1:FormatText(var_582_3.content)

				arg_579_1.text_.text = var_582_4

				LuaForUtil.ClearLinePrefixSymbol(arg_579_1.text_)

				local var_582_5 = 14
				local var_582_6 = utf8.len(var_582_4)
				local var_582_7 = var_582_5 <= 0 and var_582_1 or var_582_1 * (var_582_6 / var_582_5)

				if var_582_7 > 0 and var_582_1 < var_582_7 then
					arg_579_1.talkMaxDuration = var_582_7

					if var_582_7 + var_582_0 > arg_579_1.duration_ then
						arg_579_1.duration_ = var_582_7 + var_582_0
					end
				end

				arg_579_1.text_.text = var_582_4
				arg_579_1.typewritter.percent = 0

				arg_579_1.typewritter:SetDirty()
				arg_579_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402140", "story_v_side_new_1109402.awb") ~= 0 then
					local var_582_8 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402140", "story_v_side_new_1109402.awb") / 1000

					if var_582_8 + var_582_0 > arg_579_1.duration_ then
						arg_579_1.duration_ = var_582_8 + var_582_0
					end

					if var_582_3.prefab_name ~= "" and arg_579_1.actors_[var_582_3.prefab_name] ~= nil then
						local var_582_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_579_1.actors_[var_582_3.prefab_name].transform, "story_v_side_new_1109402", "1109402140", "story_v_side_new_1109402.awb")

						arg_579_1:RecordAudio("1109402140", var_582_9)
						arg_579_1:RecordAudio("1109402140", var_582_9)
					else
						arg_579_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402140", "story_v_side_new_1109402.awb")
					end

					arg_579_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402140", "story_v_side_new_1109402.awb")
				end

				arg_579_1:RecordContent(arg_579_1.text_.text)
			end

			local var_582_10 = math.max(var_582_1, arg_579_1.talkMaxDuration)

			if var_582_0 <= arg_579_1.time_ and arg_579_1.time_ < var_582_0 + var_582_10 then
				arg_579_1.typewritter.percent = (arg_579_1.time_ - var_582_0) / var_582_10

				arg_579_1.typewritter:SetDirty()
			end

			if arg_579_1.time_ >= var_582_0 + var_582_10 and arg_579_1.time_ < var_582_0 + var_582_10 + arg_582_0 then
				arg_579_1.typewritter.percent = 1

				arg_579_1.typewritter:SetDirty()
				arg_579_1:ShowNextGo(true)
			end
		end

		arg_579_1.nodeConfigList_ = {}

		arg_579_1:InitPlayNodeList()
	end,
	Play1109402141 = function(arg_583_0, arg_583_1)
		arg_583_1.time_ = 0
		arg_583_1.frameCnt_ = 0
		arg_583_1.state_ = "playing"
		arg_583_1.curTalkId_ = 1109402141
		arg_583_1.duration_ = 12.37

		local var_583_0 = {
			ja = 12.366,
			ko = 8.8,
			zh = 8.8
		}
		local var_583_1 = manager.audio:GetLocalizationFlag()

		if var_583_0[var_583_1] ~= nil then
			arg_583_1.duration_ = var_583_0[var_583_1]
		end

		SetActive(arg_583_1.tipsGo_, false)

		function arg_583_1.onSingleLineFinish_()
			arg_583_1.onSingleLineUpdate_ = nil
			arg_583_1.onSingleLineFinish_ = nil
			arg_583_1.state_ = "waiting"
		end

		function arg_583_1.playNext_(arg_585_0)
			if arg_585_0 == 1 then
				arg_583_0:Play1109402142(arg_583_1)
			end
		end

		function arg_583_1.onSingleLineUpdate_(arg_586_0)
			local var_586_0 = 0
			local var_586_1 = 1

			if var_586_0 < arg_583_1.time_ and arg_583_1.time_ <= var_586_0 + arg_586_0 then
				arg_583_1.talkMaxDuration = 0
				arg_583_1.dialogCg_.alpha = 1

				arg_583_1.dialog_:SetActive(true)
				SetActive(arg_583_1.leftNameGo_, true)

				local var_586_2 = arg_583_1:FormatText(StoryNameCfg[189].name)

				arg_583_1.leftNameTxt_.text = var_586_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_583_1.leftNameTxt_.transform)

				arg_583_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_583_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_583_1:RecordName(arg_583_1.leftNameTxt_.text)
				SetActive(arg_583_1.iconTrs_.gameObject, true)
				arg_583_1.iconController_:SetSelectedState("hero")

				arg_583_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vina")

				arg_583_1.callingController_:SetSelectedState("normal")

				arg_583_1.keyicon_.color = Color.New(1, 1, 1)
				arg_583_1.icon_.color = Color.New(1, 1, 1)

				local var_586_3 = arg_583_1:GetWordFromCfg(1109402141)
				local var_586_4 = arg_583_1:FormatText(var_586_3.content)

				arg_583_1.text_.text = var_586_4

				LuaForUtil.ClearLinePrefixSymbol(arg_583_1.text_)

				local var_586_5 = 40
				local var_586_6 = utf8.len(var_586_4)
				local var_586_7 = var_586_5 <= 0 and var_586_1 or var_586_1 * (var_586_6 / var_586_5)

				if var_586_7 > 0 and var_586_1 < var_586_7 then
					arg_583_1.talkMaxDuration = var_586_7

					if var_586_7 + var_586_0 > arg_583_1.duration_ then
						arg_583_1.duration_ = var_586_7 + var_586_0
					end
				end

				arg_583_1.text_.text = var_586_4
				arg_583_1.typewritter.percent = 0

				arg_583_1.typewritter:SetDirty()
				arg_583_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402141", "story_v_side_new_1109402.awb") ~= 0 then
					local var_586_8 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402141", "story_v_side_new_1109402.awb") / 1000

					if var_586_8 + var_586_0 > arg_583_1.duration_ then
						arg_583_1.duration_ = var_586_8 + var_586_0
					end

					if var_586_3.prefab_name ~= "" and arg_583_1.actors_[var_586_3.prefab_name] ~= nil then
						local var_586_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_583_1.actors_[var_586_3.prefab_name].transform, "story_v_side_new_1109402", "1109402141", "story_v_side_new_1109402.awb")

						arg_583_1:RecordAudio("1109402141", var_586_9)
						arg_583_1:RecordAudio("1109402141", var_586_9)
					else
						arg_583_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402141", "story_v_side_new_1109402.awb")
					end

					arg_583_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402141", "story_v_side_new_1109402.awb")
				end

				arg_583_1:RecordContent(arg_583_1.text_.text)
			end

			local var_586_10 = math.max(var_586_1, arg_583_1.talkMaxDuration)

			if var_586_0 <= arg_583_1.time_ and arg_583_1.time_ < var_586_0 + var_586_10 then
				arg_583_1.typewritter.percent = (arg_583_1.time_ - var_586_0) / var_586_10

				arg_583_1.typewritter:SetDirty()
			end

			if arg_583_1.time_ >= var_586_0 + var_586_10 and arg_583_1.time_ < var_586_0 + var_586_10 + arg_586_0 then
				arg_583_1.typewritter.percent = 1

				arg_583_1.typewritter:SetDirty()
				arg_583_1:ShowNextGo(true)
			end
		end

		arg_583_1.nodeConfigList_ = {}

		arg_583_1:InitPlayNodeList()
	end,
	Play1109402142 = function(arg_587_0, arg_587_1)
		arg_587_1.time_ = 0
		arg_587_1.frameCnt_ = 0
		arg_587_1.state_ = "playing"
		arg_587_1.curTalkId_ = 1109402142
		arg_587_1.duration_ = 5

		SetActive(arg_587_1.tipsGo_, false)

		function arg_587_1.onSingleLineFinish_()
			arg_587_1.onSingleLineUpdate_ = nil
			arg_587_1.onSingleLineFinish_ = nil
			arg_587_1.state_ = "waiting"
		end

		function arg_587_1.playNext_(arg_589_0)
			if arg_589_0 == 1 then
				arg_587_0:Play1109402143(arg_587_1)
			end
		end

		function arg_587_1.onSingleLineUpdate_(arg_590_0)
			local var_590_0 = 0
			local var_590_1 = 0.475

			if var_590_0 < arg_587_1.time_ and arg_587_1.time_ <= var_590_0 + arg_590_0 then
				arg_587_1.talkMaxDuration = 0
				arg_587_1.dialogCg_.alpha = 1

				arg_587_1.dialog_:SetActive(true)
				SetActive(arg_587_1.leftNameGo_, false)

				arg_587_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_587_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_587_1:RecordName(arg_587_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_587_1.iconTrs_.gameObject, false)
				arg_587_1.callingController_:SetSelectedState("normal")

				local var_590_2 = arg_587_1:GetWordFromCfg(1109402142)
				local var_590_3 = arg_587_1:FormatText(var_590_2.content)

				arg_587_1.text_.text = var_590_3

				LuaForUtil.ClearLinePrefixSymbol(arg_587_1.text_)

				local var_590_4 = 19
				local var_590_5 = utf8.len(var_590_3)
				local var_590_6 = var_590_4 <= 0 and var_590_1 or var_590_1 * (var_590_5 / var_590_4)

				if var_590_6 > 0 and var_590_1 < var_590_6 then
					arg_587_1.talkMaxDuration = var_590_6

					if var_590_6 + var_590_0 > arg_587_1.duration_ then
						arg_587_1.duration_ = var_590_6 + var_590_0
					end
				end

				arg_587_1.text_.text = var_590_3
				arg_587_1.typewritter.percent = 0

				arg_587_1.typewritter:SetDirty()
				arg_587_1:ShowNextGo(false)
				arg_587_1:RecordContent(arg_587_1.text_.text)
			end

			local var_590_7 = math.max(var_590_1, arg_587_1.talkMaxDuration)

			if var_590_0 <= arg_587_1.time_ and arg_587_1.time_ < var_590_0 + var_590_7 then
				arg_587_1.typewritter.percent = (arg_587_1.time_ - var_590_0) / var_590_7

				arg_587_1.typewritter:SetDirty()
			end

			if arg_587_1.time_ >= var_590_0 + var_590_7 and arg_587_1.time_ < var_590_0 + var_590_7 + arg_590_0 then
				arg_587_1.typewritter.percent = 1

				arg_587_1.typewritter:SetDirty()
				arg_587_1:ShowNextGo(true)
			end
		end

		arg_587_1.nodeConfigList_ = {}

		arg_587_1:InitPlayNodeList()
	end,
	Play1109402143 = function(arg_591_0, arg_591_1)
		arg_591_1.time_ = 0
		arg_591_1.frameCnt_ = 0
		arg_591_1.state_ = "playing"
		arg_591_1.curTalkId_ = 1109402143
		arg_591_1.duration_ = 5

		SetActive(arg_591_1.tipsGo_, false)

		function arg_591_1.onSingleLineFinish_()
			arg_591_1.onSingleLineUpdate_ = nil
			arg_591_1.onSingleLineFinish_ = nil
			arg_591_1.state_ = "waiting"
		end

		function arg_591_1.playNext_(arg_593_0)
			if arg_593_0 == 1 then
				arg_591_0:Play1109402144(arg_591_1)
			end
		end

		function arg_591_1.onSingleLineUpdate_(arg_594_0)
			local var_594_0 = 0
			local var_594_1 = 0.6

			if var_594_0 < arg_591_1.time_ and arg_591_1.time_ <= var_594_0 + arg_594_0 then
				arg_591_1.talkMaxDuration = 0
				arg_591_1.dialogCg_.alpha = 1

				arg_591_1.dialog_:SetActive(true)
				SetActive(arg_591_1.leftNameGo_, true)

				local var_594_2 = arg_591_1:FormatText(StoryNameCfg[7].name)

				arg_591_1.leftNameTxt_.text = var_594_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_591_1.leftNameTxt_.transform)

				arg_591_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_591_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_591_1:RecordName(arg_591_1.leftNameTxt_.text)
				SetActive(arg_591_1.iconTrs_.gameObject, true)
				arg_591_1.iconController_:SetSelectedState("hero")

				arg_591_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_591_1.callingController_:SetSelectedState("normal")

				arg_591_1.keyicon_.color = Color.New(1, 1, 1)
				arg_591_1.icon_.color = Color.New(1, 1, 1)

				local var_594_3 = arg_591_1:GetWordFromCfg(1109402143)
				local var_594_4 = arg_591_1:FormatText(var_594_3.content)

				arg_591_1.text_.text = var_594_4

				LuaForUtil.ClearLinePrefixSymbol(arg_591_1.text_)

				local var_594_5 = 24
				local var_594_6 = utf8.len(var_594_4)
				local var_594_7 = var_594_5 <= 0 and var_594_1 or var_594_1 * (var_594_6 / var_594_5)

				if var_594_7 > 0 and var_594_1 < var_594_7 then
					arg_591_1.talkMaxDuration = var_594_7

					if var_594_7 + var_594_0 > arg_591_1.duration_ then
						arg_591_1.duration_ = var_594_7 + var_594_0
					end
				end

				arg_591_1.text_.text = var_594_4
				arg_591_1.typewritter.percent = 0

				arg_591_1.typewritter:SetDirty()
				arg_591_1:ShowNextGo(false)
				arg_591_1:RecordContent(arg_591_1.text_.text)
			end

			local var_594_8 = math.max(var_594_1, arg_591_1.talkMaxDuration)

			if var_594_0 <= arg_591_1.time_ and arg_591_1.time_ < var_594_0 + var_594_8 then
				arg_591_1.typewritter.percent = (arg_591_1.time_ - var_594_0) / var_594_8

				arg_591_1.typewritter:SetDirty()
			end

			if arg_591_1.time_ >= var_594_0 + var_594_8 and arg_591_1.time_ < var_594_0 + var_594_8 + arg_594_0 then
				arg_591_1.typewritter.percent = 1

				arg_591_1.typewritter:SetDirty()
				arg_591_1:ShowNextGo(true)
			end
		end

		arg_591_1.nodeConfigList_ = {}

		arg_591_1:InitPlayNodeList()
	end,
	Play1109402144 = function(arg_595_0, arg_595_1)
		arg_595_1.time_ = 0
		arg_595_1.frameCnt_ = 0
		arg_595_1.state_ = "playing"
		arg_595_1.curTalkId_ = 1109402144
		arg_595_1.duration_ = 5.97

		local var_595_0 = {
			ja = 5.433,
			ko = 5.966,
			zh = 5.966
		}
		local var_595_1 = manager.audio:GetLocalizationFlag()

		if var_595_0[var_595_1] ~= nil then
			arg_595_1.duration_ = var_595_0[var_595_1]
		end

		SetActive(arg_595_1.tipsGo_, false)

		function arg_595_1.onSingleLineFinish_()
			arg_595_1.onSingleLineUpdate_ = nil
			arg_595_1.onSingleLineFinish_ = nil
			arg_595_1.state_ = "waiting"
		end

		function arg_595_1.playNext_(arg_597_0)
			if arg_597_0 == 1 then
				arg_595_0:Play1109402145(arg_595_1)
			end
		end

		function arg_595_1.onSingleLineUpdate_(arg_598_0)
			local var_598_0 = arg_595_1.actors_["1094ui_story"].transform
			local var_598_1 = 0

			if var_598_1 < arg_595_1.time_ and arg_595_1.time_ <= var_598_1 + arg_598_0 then
				arg_595_1.var_.moveOldPos1094ui_story = var_598_0.localPosition
			end

			local var_598_2 = 0.001

			if var_598_1 <= arg_595_1.time_ and arg_595_1.time_ < var_598_1 + var_598_2 then
				local var_598_3 = (arg_595_1.time_ - var_598_1) / var_598_2
				local var_598_4 = Vector3.New(0, -0.84, -6.1)

				var_598_0.localPosition = Vector3.Lerp(arg_595_1.var_.moveOldPos1094ui_story, var_598_4, var_598_3)

				local var_598_5 = manager.ui.mainCamera.transform.position - var_598_0.position

				var_598_0.forward = Vector3.New(var_598_5.x, var_598_5.y, var_598_5.z)

				local var_598_6 = var_598_0.localEulerAngles

				var_598_6.z = 0
				var_598_6.x = 0
				var_598_0.localEulerAngles = var_598_6
			end

			if arg_595_1.time_ >= var_598_1 + var_598_2 and arg_595_1.time_ < var_598_1 + var_598_2 + arg_598_0 then
				var_598_0.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_598_7 = manager.ui.mainCamera.transform.position - var_598_0.position

				var_598_0.forward = Vector3.New(var_598_7.x, var_598_7.y, var_598_7.z)

				local var_598_8 = var_598_0.localEulerAngles

				var_598_8.z = 0
				var_598_8.x = 0
				var_598_0.localEulerAngles = var_598_8
			end

			local var_598_9 = arg_595_1.actors_["1094ui_story"]
			local var_598_10 = 0

			if var_598_10 < arg_595_1.time_ and arg_595_1.time_ <= var_598_10 + arg_598_0 and not isNil(var_598_9) and arg_595_1.var_.characterEffect1094ui_story == nil then
				arg_595_1.var_.characterEffect1094ui_story = var_598_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_598_11 = 0.200000002980232

			if var_598_10 <= arg_595_1.time_ and arg_595_1.time_ < var_598_10 + var_598_11 and not isNil(var_598_9) then
				local var_598_12 = (arg_595_1.time_ - var_598_10) / var_598_11

				if arg_595_1.var_.characterEffect1094ui_story and not isNil(var_598_9) then
					arg_595_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_595_1.time_ >= var_598_10 + var_598_11 and arg_595_1.time_ < var_598_10 + var_598_11 + arg_598_0 and not isNil(var_598_9) and arg_595_1.var_.characterEffect1094ui_story then
				arg_595_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_598_13 = 0

			if var_598_13 < arg_595_1.time_ and arg_595_1.time_ <= var_598_13 + arg_598_0 then
				arg_595_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action1_1")
			end

			local var_598_14 = 0

			if var_598_14 < arg_595_1.time_ and arg_595_1.time_ <= var_598_14 + arg_598_0 then
				arg_595_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_598_15 = 0
			local var_598_16 = 0.575

			if var_598_15 < arg_595_1.time_ and arg_595_1.time_ <= var_598_15 + arg_598_0 then
				arg_595_1.talkMaxDuration = 0
				arg_595_1.dialogCg_.alpha = 1

				arg_595_1.dialog_:SetActive(true)
				SetActive(arg_595_1.leftNameGo_, true)

				local var_598_17 = arg_595_1:FormatText(StoryNameCfg[181].name)

				arg_595_1.leftNameTxt_.text = var_598_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_595_1.leftNameTxt_.transform)

				arg_595_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_595_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_595_1:RecordName(arg_595_1.leftNameTxt_.text)
				SetActive(arg_595_1.iconTrs_.gameObject, false)
				arg_595_1.callingController_:SetSelectedState("normal")

				local var_598_18 = arg_595_1:GetWordFromCfg(1109402144)
				local var_598_19 = arg_595_1:FormatText(var_598_18.content)

				arg_595_1.text_.text = var_598_19

				LuaForUtil.ClearLinePrefixSymbol(arg_595_1.text_)

				local var_598_20 = 23
				local var_598_21 = utf8.len(var_598_19)
				local var_598_22 = var_598_20 <= 0 and var_598_16 or var_598_16 * (var_598_21 / var_598_20)

				if var_598_22 > 0 and var_598_16 < var_598_22 then
					arg_595_1.talkMaxDuration = var_598_22

					if var_598_22 + var_598_15 > arg_595_1.duration_ then
						arg_595_1.duration_ = var_598_22 + var_598_15
					end
				end

				arg_595_1.text_.text = var_598_19
				arg_595_1.typewritter.percent = 0

				arg_595_1.typewritter:SetDirty()
				arg_595_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402144", "story_v_side_new_1109402.awb") ~= 0 then
					local var_598_23 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402144", "story_v_side_new_1109402.awb") / 1000

					if var_598_23 + var_598_15 > arg_595_1.duration_ then
						arg_595_1.duration_ = var_598_23 + var_598_15
					end

					if var_598_18.prefab_name ~= "" and arg_595_1.actors_[var_598_18.prefab_name] ~= nil then
						local var_598_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_595_1.actors_[var_598_18.prefab_name].transform, "story_v_side_new_1109402", "1109402144", "story_v_side_new_1109402.awb")

						arg_595_1:RecordAudio("1109402144", var_598_24)
						arg_595_1:RecordAudio("1109402144", var_598_24)
					else
						arg_595_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402144", "story_v_side_new_1109402.awb")
					end

					arg_595_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402144", "story_v_side_new_1109402.awb")
				end

				arg_595_1:RecordContent(arg_595_1.text_.text)
			end

			local var_598_25 = math.max(var_598_16, arg_595_1.talkMaxDuration)

			if var_598_15 <= arg_595_1.time_ and arg_595_1.time_ < var_598_15 + var_598_25 then
				arg_595_1.typewritter.percent = (arg_595_1.time_ - var_598_15) / var_598_25

				arg_595_1.typewritter:SetDirty()
			end

			if arg_595_1.time_ >= var_598_15 + var_598_25 and arg_595_1.time_ < var_598_15 + var_598_25 + arg_598_0 then
				arg_595_1.typewritter.percent = 1

				arg_595_1.typewritter:SetDirty()
				arg_595_1:ShowNextGo(true)
			end
		end

		arg_595_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_595_1:InitPlayNodeList()
	end,
	Play1109402145 = function(arg_599_0, arg_599_1)
		arg_599_1.time_ = 0
		arg_599_1.frameCnt_ = 0
		arg_599_1.state_ = "playing"
		arg_599_1.curTalkId_ = 1109402145
		arg_599_1.duration_ = 5

		SetActive(arg_599_1.tipsGo_, false)

		function arg_599_1.onSingleLineFinish_()
			arg_599_1.onSingleLineUpdate_ = nil
			arg_599_1.onSingleLineFinish_ = nil
			arg_599_1.state_ = "waiting"
		end

		function arg_599_1.playNext_(arg_601_0)
			if arg_601_0 == 1 then
				arg_599_0:Play1109402146(arg_599_1)
			end
		end

		function arg_599_1.onSingleLineUpdate_(arg_602_0)
			local var_602_0 = arg_599_1.actors_["1094ui_story"]
			local var_602_1 = 0

			if var_602_1 < arg_599_1.time_ and arg_599_1.time_ <= var_602_1 + arg_602_0 and not isNil(var_602_0) and arg_599_1.var_.characterEffect1094ui_story == nil then
				arg_599_1.var_.characterEffect1094ui_story = var_602_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_602_2 = 0.200000002980232

			if var_602_1 <= arg_599_1.time_ and arg_599_1.time_ < var_602_1 + var_602_2 and not isNil(var_602_0) then
				local var_602_3 = (arg_599_1.time_ - var_602_1) / var_602_2

				if arg_599_1.var_.characterEffect1094ui_story and not isNil(var_602_0) then
					local var_602_4 = Mathf.Lerp(0, 0.5, var_602_3)

					arg_599_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_599_1.var_.characterEffect1094ui_story.fillRatio = var_602_4
				end
			end

			if arg_599_1.time_ >= var_602_1 + var_602_2 and arg_599_1.time_ < var_602_1 + var_602_2 + arg_602_0 and not isNil(var_602_0) and arg_599_1.var_.characterEffect1094ui_story then
				local var_602_5 = 0.5

				arg_599_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_599_1.var_.characterEffect1094ui_story.fillRatio = var_602_5
			end

			local var_602_6 = 0
			local var_602_7 = 0.1

			if var_602_6 < arg_599_1.time_ and arg_599_1.time_ <= var_602_6 + arg_602_0 then
				arg_599_1.talkMaxDuration = 0
				arg_599_1.dialogCg_.alpha = 1

				arg_599_1.dialog_:SetActive(true)
				SetActive(arg_599_1.leftNameGo_, true)

				local var_602_8 = arg_599_1:FormatText(StoryNameCfg[7].name)

				arg_599_1.leftNameTxt_.text = var_602_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_599_1.leftNameTxt_.transform)

				arg_599_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_599_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_599_1:RecordName(arg_599_1.leftNameTxt_.text)
				SetActive(arg_599_1.iconTrs_.gameObject, true)
				arg_599_1.iconController_:SetSelectedState("hero")

				arg_599_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_599_1.callingController_:SetSelectedState("normal")

				arg_599_1.keyicon_.color = Color.New(1, 1, 1)
				arg_599_1.icon_.color = Color.New(1, 1, 1)

				local var_602_9 = arg_599_1:GetWordFromCfg(1109402145)
				local var_602_10 = arg_599_1:FormatText(var_602_9.content)

				arg_599_1.text_.text = var_602_10

				LuaForUtil.ClearLinePrefixSymbol(arg_599_1.text_)

				local var_602_11 = 4
				local var_602_12 = utf8.len(var_602_10)
				local var_602_13 = var_602_11 <= 0 and var_602_7 or var_602_7 * (var_602_12 / var_602_11)

				if var_602_13 > 0 and var_602_7 < var_602_13 then
					arg_599_1.talkMaxDuration = var_602_13

					if var_602_13 + var_602_6 > arg_599_1.duration_ then
						arg_599_1.duration_ = var_602_13 + var_602_6
					end
				end

				arg_599_1.text_.text = var_602_10
				arg_599_1.typewritter.percent = 0

				arg_599_1.typewritter:SetDirty()
				arg_599_1:ShowNextGo(false)
				arg_599_1:RecordContent(arg_599_1.text_.text)
			end

			local var_602_14 = math.max(var_602_7, arg_599_1.talkMaxDuration)

			if var_602_6 <= arg_599_1.time_ and arg_599_1.time_ < var_602_6 + var_602_14 then
				arg_599_1.typewritter.percent = (arg_599_1.time_ - var_602_6) / var_602_14

				arg_599_1.typewritter:SetDirty()
			end

			if arg_599_1.time_ >= var_602_6 + var_602_14 and arg_599_1.time_ < var_602_6 + var_602_14 + arg_602_0 then
				arg_599_1.typewritter.percent = 1

				arg_599_1.typewritter:SetDirty()
				arg_599_1:ShowNextGo(true)
			end
		end

		arg_599_1.nodeConfigList_ = {}

		arg_599_1:InitPlayNodeList()
	end,
	Play1109402146 = function(arg_603_0, arg_603_1)
		arg_603_1.time_ = 0
		arg_603_1.frameCnt_ = 0
		arg_603_1.state_ = "playing"
		arg_603_1.curTalkId_ = 1109402146
		arg_603_1.duration_ = 9.9

		local var_603_0 = {
			ja = 7.433,
			ko = 9.9,
			zh = 9.9
		}
		local var_603_1 = manager.audio:GetLocalizationFlag()

		if var_603_0[var_603_1] ~= nil then
			arg_603_1.duration_ = var_603_0[var_603_1]
		end

		SetActive(arg_603_1.tipsGo_, false)

		function arg_603_1.onSingleLineFinish_()
			arg_603_1.onSingleLineUpdate_ = nil
			arg_603_1.onSingleLineFinish_ = nil
			arg_603_1.state_ = "waiting"
		end

		function arg_603_1.playNext_(arg_605_0)
			if arg_605_0 == 1 then
				arg_603_0:Play1109402147(arg_603_1)
			end
		end

		function arg_603_1.onSingleLineUpdate_(arg_606_0)
			local var_606_0 = 0
			local var_606_1 = 0.825

			if var_606_0 < arg_603_1.time_ and arg_603_1.time_ <= var_606_0 + arg_606_0 then
				arg_603_1.talkMaxDuration = 0
				arg_603_1.dialogCg_.alpha = 1

				arg_603_1.dialog_:SetActive(true)
				SetActive(arg_603_1.leftNameGo_, true)

				local var_606_2 = arg_603_1:FormatText(StoryNameCfg[189].name)

				arg_603_1.leftNameTxt_.text = var_606_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_603_1.leftNameTxt_.transform)

				arg_603_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_603_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_603_1:RecordName(arg_603_1.leftNameTxt_.text)
				SetActive(arg_603_1.iconTrs_.gameObject, true)
				arg_603_1.iconController_:SetSelectedState("hero")

				arg_603_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vina")

				arg_603_1.callingController_:SetSelectedState("normal")

				arg_603_1.keyicon_.color = Color.New(1, 1, 1)
				arg_603_1.icon_.color = Color.New(1, 1, 1)

				local var_606_3 = arg_603_1:GetWordFromCfg(1109402146)
				local var_606_4 = arg_603_1:FormatText(var_606_3.content)

				arg_603_1.text_.text = var_606_4

				LuaForUtil.ClearLinePrefixSymbol(arg_603_1.text_)

				local var_606_5 = 37
				local var_606_6 = utf8.len(var_606_4)
				local var_606_7 = var_606_5 <= 0 and var_606_1 or var_606_1 * (var_606_6 / var_606_5)

				if var_606_7 > 0 and var_606_1 < var_606_7 then
					arg_603_1.talkMaxDuration = var_606_7

					if var_606_7 + var_606_0 > arg_603_1.duration_ then
						arg_603_1.duration_ = var_606_7 + var_606_0
					end
				end

				arg_603_1.text_.text = var_606_4
				arg_603_1.typewritter.percent = 0

				arg_603_1.typewritter:SetDirty()
				arg_603_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402146", "story_v_side_new_1109402.awb") ~= 0 then
					local var_606_8 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402146", "story_v_side_new_1109402.awb") / 1000

					if var_606_8 + var_606_0 > arg_603_1.duration_ then
						arg_603_1.duration_ = var_606_8 + var_606_0
					end

					if var_606_3.prefab_name ~= "" and arg_603_1.actors_[var_606_3.prefab_name] ~= nil then
						local var_606_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_603_1.actors_[var_606_3.prefab_name].transform, "story_v_side_new_1109402", "1109402146", "story_v_side_new_1109402.awb")

						arg_603_1:RecordAudio("1109402146", var_606_9)
						arg_603_1:RecordAudio("1109402146", var_606_9)
					else
						arg_603_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402146", "story_v_side_new_1109402.awb")
					end

					arg_603_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402146", "story_v_side_new_1109402.awb")
				end

				arg_603_1:RecordContent(arg_603_1.text_.text)
			end

			local var_606_10 = math.max(var_606_1, arg_603_1.talkMaxDuration)

			if var_606_0 <= arg_603_1.time_ and arg_603_1.time_ < var_606_0 + var_606_10 then
				arg_603_1.typewritter.percent = (arg_603_1.time_ - var_606_0) / var_606_10

				arg_603_1.typewritter:SetDirty()
			end

			if arg_603_1.time_ >= var_606_0 + var_606_10 and arg_603_1.time_ < var_606_0 + var_606_10 + arg_606_0 then
				arg_603_1.typewritter.percent = 1

				arg_603_1.typewritter:SetDirty()
				arg_603_1:ShowNextGo(true)
			end
		end

		arg_603_1.nodeConfigList_ = {}

		arg_603_1:InitPlayNodeList()
	end,
	Play1109402147 = function(arg_607_0, arg_607_1)
		arg_607_1.time_ = 0
		arg_607_1.frameCnt_ = 0
		arg_607_1.state_ = "playing"
		arg_607_1.curTalkId_ = 1109402147
		arg_607_1.duration_ = 6.1

		local var_607_0 = {
			ja = 6.1,
			ko = 4.3,
			zh = 4.3
		}
		local var_607_1 = manager.audio:GetLocalizationFlag()

		if var_607_0[var_607_1] ~= nil then
			arg_607_1.duration_ = var_607_0[var_607_1]
		end

		SetActive(arg_607_1.tipsGo_, false)

		function arg_607_1.onSingleLineFinish_()
			arg_607_1.onSingleLineUpdate_ = nil
			arg_607_1.onSingleLineFinish_ = nil
			arg_607_1.state_ = "waiting"
		end

		function arg_607_1.playNext_(arg_609_0)
			if arg_609_0 == 1 then
				arg_607_0:Play1109402148(arg_607_1)
			end
		end

		function arg_607_1.onSingleLineUpdate_(arg_610_0)
			local var_610_0 = arg_607_1.actors_["1094ui_story"].transform
			local var_610_1 = 0

			if var_610_1 < arg_607_1.time_ and arg_607_1.time_ <= var_610_1 + arg_610_0 then
				arg_607_1.var_.moveOldPos1094ui_story = var_610_0.localPosition
			end

			local var_610_2 = 0.001

			if var_610_1 <= arg_607_1.time_ and arg_607_1.time_ < var_610_1 + var_610_2 then
				local var_610_3 = (arg_607_1.time_ - var_610_1) / var_610_2
				local var_610_4 = Vector3.New(0, -0.84, -6.1)

				var_610_0.localPosition = Vector3.Lerp(arg_607_1.var_.moveOldPos1094ui_story, var_610_4, var_610_3)

				local var_610_5 = manager.ui.mainCamera.transform.position - var_610_0.position

				var_610_0.forward = Vector3.New(var_610_5.x, var_610_5.y, var_610_5.z)

				local var_610_6 = var_610_0.localEulerAngles

				var_610_6.z = 0
				var_610_6.x = 0
				var_610_0.localEulerAngles = var_610_6
			end

			if arg_607_1.time_ >= var_610_1 + var_610_2 and arg_607_1.time_ < var_610_1 + var_610_2 + arg_610_0 then
				var_610_0.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_610_7 = manager.ui.mainCamera.transform.position - var_610_0.position

				var_610_0.forward = Vector3.New(var_610_7.x, var_610_7.y, var_610_7.z)

				local var_610_8 = var_610_0.localEulerAngles

				var_610_8.z = 0
				var_610_8.x = 0
				var_610_0.localEulerAngles = var_610_8
			end

			local var_610_9 = arg_607_1.actors_["1094ui_story"]
			local var_610_10 = 0

			if var_610_10 < arg_607_1.time_ and arg_607_1.time_ <= var_610_10 + arg_610_0 and not isNil(var_610_9) and arg_607_1.var_.characterEffect1094ui_story == nil then
				arg_607_1.var_.characterEffect1094ui_story = var_610_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_610_11 = 0.200000002980232

			if var_610_10 <= arg_607_1.time_ and arg_607_1.time_ < var_610_10 + var_610_11 and not isNil(var_610_9) then
				local var_610_12 = (arg_607_1.time_ - var_610_10) / var_610_11

				if arg_607_1.var_.characterEffect1094ui_story and not isNil(var_610_9) then
					arg_607_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_607_1.time_ >= var_610_10 + var_610_11 and arg_607_1.time_ < var_610_10 + var_610_11 + arg_610_0 and not isNil(var_610_9) and arg_607_1.var_.characterEffect1094ui_story then
				arg_607_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_610_13 = 0

			if var_610_13 < arg_607_1.time_ and arg_607_1.time_ <= var_610_13 + arg_610_0 then
				arg_607_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action1_1")
			end

			local var_610_14 = 0

			if var_610_14 < arg_607_1.time_ and arg_607_1.time_ <= var_610_14 + arg_610_0 then
				arg_607_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_610_15 = 0
			local var_610_16 = 0.35

			if var_610_15 < arg_607_1.time_ and arg_607_1.time_ <= var_610_15 + arg_610_0 then
				arg_607_1.talkMaxDuration = 0
				arg_607_1.dialogCg_.alpha = 1

				arg_607_1.dialog_:SetActive(true)
				SetActive(arg_607_1.leftNameGo_, true)

				local var_610_17 = arg_607_1:FormatText(StoryNameCfg[181].name)

				arg_607_1.leftNameTxt_.text = var_610_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_607_1.leftNameTxt_.transform)

				arg_607_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_607_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_607_1:RecordName(arg_607_1.leftNameTxt_.text)
				SetActive(arg_607_1.iconTrs_.gameObject, false)
				arg_607_1.callingController_:SetSelectedState("normal")

				local var_610_18 = arg_607_1:GetWordFromCfg(1109402147)
				local var_610_19 = arg_607_1:FormatText(var_610_18.content)

				arg_607_1.text_.text = var_610_19

				LuaForUtil.ClearLinePrefixSymbol(arg_607_1.text_)

				local var_610_20 = 14
				local var_610_21 = utf8.len(var_610_19)
				local var_610_22 = var_610_20 <= 0 and var_610_16 or var_610_16 * (var_610_21 / var_610_20)

				if var_610_22 > 0 and var_610_16 < var_610_22 then
					arg_607_1.talkMaxDuration = var_610_22

					if var_610_22 + var_610_15 > arg_607_1.duration_ then
						arg_607_1.duration_ = var_610_22 + var_610_15
					end
				end

				arg_607_1.text_.text = var_610_19
				arg_607_1.typewritter.percent = 0

				arg_607_1.typewritter:SetDirty()
				arg_607_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402147", "story_v_side_new_1109402.awb") ~= 0 then
					local var_610_23 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402147", "story_v_side_new_1109402.awb") / 1000

					if var_610_23 + var_610_15 > arg_607_1.duration_ then
						arg_607_1.duration_ = var_610_23 + var_610_15
					end

					if var_610_18.prefab_name ~= "" and arg_607_1.actors_[var_610_18.prefab_name] ~= nil then
						local var_610_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_607_1.actors_[var_610_18.prefab_name].transform, "story_v_side_new_1109402", "1109402147", "story_v_side_new_1109402.awb")

						arg_607_1:RecordAudio("1109402147", var_610_24)
						arg_607_1:RecordAudio("1109402147", var_610_24)
					else
						arg_607_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402147", "story_v_side_new_1109402.awb")
					end

					arg_607_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402147", "story_v_side_new_1109402.awb")
				end

				arg_607_1:RecordContent(arg_607_1.text_.text)
			end

			local var_610_25 = math.max(var_610_16, arg_607_1.talkMaxDuration)

			if var_610_15 <= arg_607_1.time_ and arg_607_1.time_ < var_610_15 + var_610_25 then
				arg_607_1.typewritter.percent = (arg_607_1.time_ - var_610_15) / var_610_25

				arg_607_1.typewritter:SetDirty()
			end

			if arg_607_1.time_ >= var_610_15 + var_610_25 and arg_607_1.time_ < var_610_15 + var_610_25 + arg_610_0 then
				arg_607_1.typewritter.percent = 1

				arg_607_1.typewritter:SetDirty()
				arg_607_1:ShowNextGo(true)
			end
		end

		arg_607_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_607_1:InitPlayNodeList()
	end,
	Play1109402148 = function(arg_611_0, arg_611_1)
		arg_611_1.time_ = 0
		arg_611_1.frameCnt_ = 0
		arg_611_1.state_ = "playing"
		arg_611_1.curTalkId_ = 1109402148
		arg_611_1.duration_ = 7.3

		local var_611_0 = {
			ja = 7.3,
			ko = 2.733,
			zh = 2.733
		}
		local var_611_1 = manager.audio:GetLocalizationFlag()

		if var_611_0[var_611_1] ~= nil then
			arg_611_1.duration_ = var_611_0[var_611_1]
		end

		SetActive(arg_611_1.tipsGo_, false)

		function arg_611_1.onSingleLineFinish_()
			arg_611_1.onSingleLineUpdate_ = nil
			arg_611_1.onSingleLineFinish_ = nil
			arg_611_1.state_ = "waiting"
		end

		function arg_611_1.playNext_(arg_613_0)
			if arg_613_0 == 1 then
				arg_611_0:Play1109402149(arg_611_1)
			end
		end

		function arg_611_1.onSingleLineUpdate_(arg_614_0)
			local var_614_0 = arg_611_1.actors_["1094ui_story"]
			local var_614_1 = 0

			if var_614_1 < arg_611_1.time_ and arg_611_1.time_ <= var_614_1 + arg_614_0 and not isNil(var_614_0) and arg_611_1.var_.characterEffect1094ui_story == nil then
				arg_611_1.var_.characterEffect1094ui_story = var_614_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_614_2 = 0.200000002980232

			if var_614_1 <= arg_611_1.time_ and arg_611_1.time_ < var_614_1 + var_614_2 and not isNil(var_614_0) then
				local var_614_3 = (arg_611_1.time_ - var_614_1) / var_614_2

				if arg_611_1.var_.characterEffect1094ui_story and not isNil(var_614_0) then
					local var_614_4 = Mathf.Lerp(0, 0.5, var_614_3)

					arg_611_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_611_1.var_.characterEffect1094ui_story.fillRatio = var_614_4
				end
			end

			if arg_611_1.time_ >= var_614_1 + var_614_2 and arg_611_1.time_ < var_614_1 + var_614_2 + arg_614_0 and not isNil(var_614_0) and arg_611_1.var_.characterEffect1094ui_story then
				local var_614_5 = 0.5

				arg_611_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_611_1.var_.characterEffect1094ui_story.fillRatio = var_614_5
			end

			local var_614_6 = 0
			local var_614_7 = 0.275

			if var_614_6 < arg_611_1.time_ and arg_611_1.time_ <= var_614_6 + arg_614_0 then
				arg_611_1.talkMaxDuration = 0
				arg_611_1.dialogCg_.alpha = 1

				arg_611_1.dialog_:SetActive(true)
				SetActive(arg_611_1.leftNameGo_, true)

				local var_614_8 = arg_611_1:FormatText(StoryNameCfg[189].name)

				arg_611_1.leftNameTxt_.text = var_614_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_611_1.leftNameTxt_.transform)

				arg_611_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_611_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_611_1:RecordName(arg_611_1.leftNameTxt_.text)
				SetActive(arg_611_1.iconTrs_.gameObject, true)
				arg_611_1.iconController_:SetSelectedState("hero")

				arg_611_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vina")

				arg_611_1.callingController_:SetSelectedState("normal")

				arg_611_1.keyicon_.color = Color.New(1, 1, 1)
				arg_611_1.icon_.color = Color.New(1, 1, 1)

				local var_614_9 = arg_611_1:GetWordFromCfg(1109402148)
				local var_614_10 = arg_611_1:FormatText(var_614_9.content)

				arg_611_1.text_.text = var_614_10

				LuaForUtil.ClearLinePrefixSymbol(arg_611_1.text_)

				local var_614_11 = 11
				local var_614_12 = utf8.len(var_614_10)
				local var_614_13 = var_614_11 <= 0 and var_614_7 or var_614_7 * (var_614_12 / var_614_11)

				if var_614_13 > 0 and var_614_7 < var_614_13 then
					arg_611_1.talkMaxDuration = var_614_13

					if var_614_13 + var_614_6 > arg_611_1.duration_ then
						arg_611_1.duration_ = var_614_13 + var_614_6
					end
				end

				arg_611_1.text_.text = var_614_10
				arg_611_1.typewritter.percent = 0

				arg_611_1.typewritter:SetDirty()
				arg_611_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402148", "story_v_side_new_1109402.awb") ~= 0 then
					local var_614_14 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402148", "story_v_side_new_1109402.awb") / 1000

					if var_614_14 + var_614_6 > arg_611_1.duration_ then
						arg_611_1.duration_ = var_614_14 + var_614_6
					end

					if var_614_9.prefab_name ~= "" and arg_611_1.actors_[var_614_9.prefab_name] ~= nil then
						local var_614_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_611_1.actors_[var_614_9.prefab_name].transform, "story_v_side_new_1109402", "1109402148", "story_v_side_new_1109402.awb")

						arg_611_1:RecordAudio("1109402148", var_614_15)
						arg_611_1:RecordAudio("1109402148", var_614_15)
					else
						arg_611_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402148", "story_v_side_new_1109402.awb")
					end

					arg_611_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402148", "story_v_side_new_1109402.awb")
				end

				arg_611_1:RecordContent(arg_611_1.text_.text)
			end

			local var_614_16 = math.max(var_614_7, arg_611_1.talkMaxDuration)

			if var_614_6 <= arg_611_1.time_ and arg_611_1.time_ < var_614_6 + var_614_16 then
				arg_611_1.typewritter.percent = (arg_611_1.time_ - var_614_6) / var_614_16

				arg_611_1.typewritter:SetDirty()
			end

			if arg_611_1.time_ >= var_614_6 + var_614_16 and arg_611_1.time_ < var_614_6 + var_614_16 + arg_614_0 then
				arg_611_1.typewritter.percent = 1

				arg_611_1.typewritter:SetDirty()
				arg_611_1:ShowNextGo(true)
			end
		end

		arg_611_1.nodeConfigList_ = {}

		arg_611_1:InitPlayNodeList()
	end,
	Play1109402149 = function(arg_615_0, arg_615_1)
		arg_615_1.time_ = 0
		arg_615_1.frameCnt_ = 0
		arg_615_1.state_ = "playing"
		arg_615_1.curTalkId_ = 1109402149
		arg_615_1.duration_ = 5.47

		local var_615_0 = {
			ja = 5.466,
			ko = 3,
			zh = 3
		}
		local var_615_1 = manager.audio:GetLocalizationFlag()

		if var_615_0[var_615_1] ~= nil then
			arg_615_1.duration_ = var_615_0[var_615_1]
		end

		SetActive(arg_615_1.tipsGo_, false)

		function arg_615_1.onSingleLineFinish_()
			arg_615_1.onSingleLineUpdate_ = nil
			arg_615_1.onSingleLineFinish_ = nil
			arg_615_1.state_ = "waiting"
		end

		function arg_615_1.playNext_(arg_617_0)
			if arg_617_0 == 1 then
				arg_615_0:Play1109402150(arg_615_1)
			end
		end

		function arg_615_1.onSingleLineUpdate_(arg_618_0)
			local var_618_0 = 0
			local var_618_1 = 0.375

			if var_618_0 < arg_615_1.time_ and arg_615_1.time_ <= var_618_0 + arg_618_0 then
				arg_615_1.talkMaxDuration = 0
				arg_615_1.dialogCg_.alpha = 1

				arg_615_1.dialog_:SetActive(true)
				SetActive(arg_615_1.leftNameGo_, true)

				local var_618_2 = arg_615_1:FormatText(StoryNameCfg[189].name)

				arg_615_1.leftNameTxt_.text = var_618_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_615_1.leftNameTxt_.transform)

				arg_615_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_615_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_615_1:RecordName(arg_615_1.leftNameTxt_.text)
				SetActive(arg_615_1.iconTrs_.gameObject, true)
				arg_615_1.iconController_:SetSelectedState("hero")

				arg_615_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vina")

				arg_615_1.callingController_:SetSelectedState("normal")

				arg_615_1.keyicon_.color = Color.New(1, 1, 1)
				arg_615_1.icon_.color = Color.New(1, 1, 1)

				local var_618_3 = arg_615_1:GetWordFromCfg(1109402149)
				local var_618_4 = arg_615_1:FormatText(var_618_3.content)

				arg_615_1.text_.text = var_618_4

				LuaForUtil.ClearLinePrefixSymbol(arg_615_1.text_)

				local var_618_5 = 15
				local var_618_6 = utf8.len(var_618_4)
				local var_618_7 = var_618_5 <= 0 and var_618_1 or var_618_1 * (var_618_6 / var_618_5)

				if var_618_7 > 0 and var_618_1 < var_618_7 then
					arg_615_1.talkMaxDuration = var_618_7

					if var_618_7 + var_618_0 > arg_615_1.duration_ then
						arg_615_1.duration_ = var_618_7 + var_618_0
					end
				end

				arg_615_1.text_.text = var_618_4
				arg_615_1.typewritter.percent = 0

				arg_615_1.typewritter:SetDirty()
				arg_615_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402149", "story_v_side_new_1109402.awb") ~= 0 then
					local var_618_8 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402149", "story_v_side_new_1109402.awb") / 1000

					if var_618_8 + var_618_0 > arg_615_1.duration_ then
						arg_615_1.duration_ = var_618_8 + var_618_0
					end

					if var_618_3.prefab_name ~= "" and arg_615_1.actors_[var_618_3.prefab_name] ~= nil then
						local var_618_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_615_1.actors_[var_618_3.prefab_name].transform, "story_v_side_new_1109402", "1109402149", "story_v_side_new_1109402.awb")

						arg_615_1:RecordAudio("1109402149", var_618_9)
						arg_615_1:RecordAudio("1109402149", var_618_9)
					else
						arg_615_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402149", "story_v_side_new_1109402.awb")
					end

					arg_615_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402149", "story_v_side_new_1109402.awb")
				end

				arg_615_1:RecordContent(arg_615_1.text_.text)
			end

			local var_618_10 = math.max(var_618_1, arg_615_1.talkMaxDuration)

			if var_618_0 <= arg_615_1.time_ and arg_615_1.time_ < var_618_0 + var_618_10 then
				arg_615_1.typewritter.percent = (arg_615_1.time_ - var_618_0) / var_618_10

				arg_615_1.typewritter:SetDirty()
			end

			if arg_615_1.time_ >= var_618_0 + var_618_10 and arg_615_1.time_ < var_618_0 + var_618_10 + arg_618_0 then
				arg_615_1.typewritter.percent = 1

				arg_615_1.typewritter:SetDirty()
				arg_615_1:ShowNextGo(true)
			end
		end

		arg_615_1.nodeConfigList_ = {}

		arg_615_1:InitPlayNodeList()
	end,
	Play1109402150 = function(arg_619_0, arg_619_1)
		arg_619_1.time_ = 0
		arg_619_1.frameCnt_ = 0
		arg_619_1.state_ = "playing"
		arg_619_1.curTalkId_ = 1109402150
		arg_619_1.duration_ = 2.5

		local var_619_0 = {
			ja = 2.5,
			ko = 2.433,
			zh = 2.433
		}
		local var_619_1 = manager.audio:GetLocalizationFlag()

		if var_619_0[var_619_1] ~= nil then
			arg_619_1.duration_ = var_619_0[var_619_1]
		end

		SetActive(arg_619_1.tipsGo_, false)

		function arg_619_1.onSingleLineFinish_()
			arg_619_1.onSingleLineUpdate_ = nil
			arg_619_1.onSingleLineFinish_ = nil
			arg_619_1.state_ = "waiting"
		end

		function arg_619_1.playNext_(arg_621_0)
			if arg_621_0 == 1 then
				arg_619_0:Play1109402151(arg_619_1)
			end
		end

		function arg_619_1.onSingleLineUpdate_(arg_622_0)
			local var_622_0 = arg_619_1.actors_["1094ui_story"].transform
			local var_622_1 = 0

			if var_622_1 < arg_619_1.time_ and arg_619_1.time_ <= var_622_1 + arg_622_0 then
				arg_619_1.var_.moveOldPos1094ui_story = var_622_0.localPosition
			end

			local var_622_2 = 0.001

			if var_622_1 <= arg_619_1.time_ and arg_619_1.time_ < var_622_1 + var_622_2 then
				local var_622_3 = (arg_619_1.time_ - var_622_1) / var_622_2
				local var_622_4 = Vector3.New(0, -0.84, -6.1)

				var_622_0.localPosition = Vector3.Lerp(arg_619_1.var_.moveOldPos1094ui_story, var_622_4, var_622_3)

				local var_622_5 = manager.ui.mainCamera.transform.position - var_622_0.position

				var_622_0.forward = Vector3.New(var_622_5.x, var_622_5.y, var_622_5.z)

				local var_622_6 = var_622_0.localEulerAngles

				var_622_6.z = 0
				var_622_6.x = 0
				var_622_0.localEulerAngles = var_622_6
			end

			if arg_619_1.time_ >= var_622_1 + var_622_2 and arg_619_1.time_ < var_622_1 + var_622_2 + arg_622_0 then
				var_622_0.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_622_7 = manager.ui.mainCamera.transform.position - var_622_0.position

				var_622_0.forward = Vector3.New(var_622_7.x, var_622_7.y, var_622_7.z)

				local var_622_8 = var_622_0.localEulerAngles

				var_622_8.z = 0
				var_622_8.x = 0
				var_622_0.localEulerAngles = var_622_8
			end

			local var_622_9 = arg_619_1.actors_["1094ui_story"]
			local var_622_10 = 0

			if var_622_10 < arg_619_1.time_ and arg_619_1.time_ <= var_622_10 + arg_622_0 and not isNil(var_622_9) and arg_619_1.var_.characterEffect1094ui_story == nil then
				arg_619_1.var_.characterEffect1094ui_story = var_622_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_622_11 = 0.200000002980232

			if var_622_10 <= arg_619_1.time_ and arg_619_1.time_ < var_622_10 + var_622_11 and not isNil(var_622_9) then
				local var_622_12 = (arg_619_1.time_ - var_622_10) / var_622_11

				if arg_619_1.var_.characterEffect1094ui_story and not isNil(var_622_9) then
					arg_619_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_619_1.time_ >= var_622_10 + var_622_11 and arg_619_1.time_ < var_622_10 + var_622_11 + arg_622_0 and not isNil(var_622_9) and arg_619_1.var_.characterEffect1094ui_story then
				arg_619_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_622_13 = 0

			if var_622_13 < arg_619_1.time_ and arg_619_1.time_ <= var_622_13 + arg_622_0 then
				arg_619_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action1_1")
			end

			local var_622_14 = 0

			if var_622_14 < arg_619_1.time_ and arg_619_1.time_ <= var_622_14 + arg_622_0 then
				arg_619_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_622_15 = 0
			local var_622_16 = 0.175

			if var_622_15 < arg_619_1.time_ and arg_619_1.time_ <= var_622_15 + arg_622_0 then
				arg_619_1.talkMaxDuration = 0
				arg_619_1.dialogCg_.alpha = 1

				arg_619_1.dialog_:SetActive(true)
				SetActive(arg_619_1.leftNameGo_, true)

				local var_622_17 = arg_619_1:FormatText(StoryNameCfg[181].name)

				arg_619_1.leftNameTxt_.text = var_622_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_619_1.leftNameTxt_.transform)

				arg_619_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_619_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_619_1:RecordName(arg_619_1.leftNameTxt_.text)
				SetActive(arg_619_1.iconTrs_.gameObject, false)
				arg_619_1.callingController_:SetSelectedState("normal")

				local var_622_18 = arg_619_1:GetWordFromCfg(1109402150)
				local var_622_19 = arg_619_1:FormatText(var_622_18.content)

				arg_619_1.text_.text = var_622_19

				LuaForUtil.ClearLinePrefixSymbol(arg_619_1.text_)

				local var_622_20 = 7
				local var_622_21 = utf8.len(var_622_19)
				local var_622_22 = var_622_20 <= 0 and var_622_16 or var_622_16 * (var_622_21 / var_622_20)

				if var_622_22 > 0 and var_622_16 < var_622_22 then
					arg_619_1.talkMaxDuration = var_622_22

					if var_622_22 + var_622_15 > arg_619_1.duration_ then
						arg_619_1.duration_ = var_622_22 + var_622_15
					end
				end

				arg_619_1.text_.text = var_622_19
				arg_619_1.typewritter.percent = 0

				arg_619_1.typewritter:SetDirty()
				arg_619_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402150", "story_v_side_new_1109402.awb") ~= 0 then
					local var_622_23 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402150", "story_v_side_new_1109402.awb") / 1000

					if var_622_23 + var_622_15 > arg_619_1.duration_ then
						arg_619_1.duration_ = var_622_23 + var_622_15
					end

					if var_622_18.prefab_name ~= "" and arg_619_1.actors_[var_622_18.prefab_name] ~= nil then
						local var_622_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_619_1.actors_[var_622_18.prefab_name].transform, "story_v_side_new_1109402", "1109402150", "story_v_side_new_1109402.awb")

						arg_619_1:RecordAudio("1109402150", var_622_24)
						arg_619_1:RecordAudio("1109402150", var_622_24)
					else
						arg_619_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402150", "story_v_side_new_1109402.awb")
					end

					arg_619_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402150", "story_v_side_new_1109402.awb")
				end

				arg_619_1:RecordContent(arg_619_1.text_.text)
			end

			local var_622_25 = math.max(var_622_16, arg_619_1.talkMaxDuration)

			if var_622_15 <= arg_619_1.time_ and arg_619_1.time_ < var_622_15 + var_622_25 then
				arg_619_1.typewritter.percent = (arg_619_1.time_ - var_622_15) / var_622_25

				arg_619_1.typewritter:SetDirty()
			end

			if arg_619_1.time_ >= var_622_15 + var_622_25 and arg_619_1.time_ < var_622_15 + var_622_25 + arg_622_0 then
				arg_619_1.typewritter.percent = 1

				arg_619_1.typewritter:SetDirty()
				arg_619_1:ShowNextGo(true)
			end
		end

		arg_619_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_619_1:InitPlayNodeList()
	end,
	Play1109402151 = function(arg_623_0, arg_623_1)
		arg_623_1.time_ = 0
		arg_623_1.frameCnt_ = 0
		arg_623_1.state_ = "playing"
		arg_623_1.curTalkId_ = 1109402151
		arg_623_1.duration_ = 5

		SetActive(arg_623_1.tipsGo_, false)

		function arg_623_1.onSingleLineFinish_()
			arg_623_1.onSingleLineUpdate_ = nil
			arg_623_1.onSingleLineFinish_ = nil
			arg_623_1.state_ = "waiting"
		end

		function arg_623_1.playNext_(arg_625_0)
			if arg_625_0 == 1 then
				arg_623_0:Play1109402152(arg_623_1)
			end
		end

		function arg_623_1.onSingleLineUpdate_(arg_626_0)
			local var_626_0 = arg_623_1.actors_["1094ui_story"]
			local var_626_1 = 0

			if var_626_1 < arg_623_1.time_ and arg_623_1.time_ <= var_626_1 + arg_626_0 and not isNil(var_626_0) and arg_623_1.var_.characterEffect1094ui_story == nil then
				arg_623_1.var_.characterEffect1094ui_story = var_626_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_626_2 = 0.200000002980232

			if var_626_1 <= arg_623_1.time_ and arg_623_1.time_ < var_626_1 + var_626_2 and not isNil(var_626_0) then
				local var_626_3 = (arg_623_1.time_ - var_626_1) / var_626_2

				if arg_623_1.var_.characterEffect1094ui_story and not isNil(var_626_0) then
					local var_626_4 = Mathf.Lerp(0, 0.5, var_626_3)

					arg_623_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_623_1.var_.characterEffect1094ui_story.fillRatio = var_626_4
				end
			end

			if arg_623_1.time_ >= var_626_1 + var_626_2 and arg_623_1.time_ < var_626_1 + var_626_2 + arg_626_0 and not isNil(var_626_0) and arg_623_1.var_.characterEffect1094ui_story then
				local var_626_5 = 0.5

				arg_623_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_623_1.var_.characterEffect1094ui_story.fillRatio = var_626_5
			end

			local var_626_6 = 0
			local var_626_7 = 0.75

			if var_626_6 < arg_623_1.time_ and arg_623_1.time_ <= var_626_6 + arg_626_0 then
				arg_623_1.talkMaxDuration = 0
				arg_623_1.dialogCg_.alpha = 1

				arg_623_1.dialog_:SetActive(true)
				SetActive(arg_623_1.leftNameGo_, false)

				arg_623_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_623_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_623_1:RecordName(arg_623_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_623_1.iconTrs_.gameObject, false)
				arg_623_1.callingController_:SetSelectedState("normal")

				local var_626_8 = arg_623_1:GetWordFromCfg(1109402151)
				local var_626_9 = arg_623_1:FormatText(var_626_8.content)

				arg_623_1.text_.text = var_626_9

				LuaForUtil.ClearLinePrefixSymbol(arg_623_1.text_)

				local var_626_10 = 35
				local var_626_11 = utf8.len(var_626_9)
				local var_626_12 = var_626_10 <= 0 and var_626_7 or var_626_7 * (var_626_11 / var_626_10)

				if var_626_12 > 0 and var_626_7 < var_626_12 then
					arg_623_1.talkMaxDuration = var_626_12

					if var_626_12 + var_626_6 > arg_623_1.duration_ then
						arg_623_1.duration_ = var_626_12 + var_626_6
					end
				end

				arg_623_1.text_.text = var_626_9
				arg_623_1.typewritter.percent = 0

				arg_623_1.typewritter:SetDirty()
				arg_623_1:ShowNextGo(false)
				arg_623_1:RecordContent(arg_623_1.text_.text)
			end

			local var_626_13 = math.max(var_626_7, arg_623_1.talkMaxDuration)

			if var_626_6 <= arg_623_1.time_ and arg_623_1.time_ < var_626_6 + var_626_13 then
				arg_623_1.typewritter.percent = (arg_623_1.time_ - var_626_6) / var_626_13

				arg_623_1.typewritter:SetDirty()
			end

			if arg_623_1.time_ >= var_626_6 + var_626_13 and arg_623_1.time_ < var_626_6 + var_626_13 + arg_626_0 then
				arg_623_1.typewritter.percent = 1

				arg_623_1.typewritter:SetDirty()
				arg_623_1:ShowNextGo(true)
			end
		end

		arg_623_1.nodeConfigList_ = {}

		arg_623_1:InitPlayNodeList()
	end,
	Play1109402152 = function(arg_627_0, arg_627_1)
		arg_627_1.time_ = 0
		arg_627_1.frameCnt_ = 0
		arg_627_1.state_ = "playing"
		arg_627_1.curTalkId_ = 1109402152
		arg_627_1.duration_ = 5

		SetActive(arg_627_1.tipsGo_, false)

		function arg_627_1.onSingleLineFinish_()
			arg_627_1.onSingleLineUpdate_ = nil
			arg_627_1.onSingleLineFinish_ = nil
			arg_627_1.state_ = "waiting"
		end

		function arg_627_1.playNext_(arg_629_0)
			if arg_629_0 == 1 then
				arg_627_0:Play1109402153(arg_627_1)
			end
		end

		function arg_627_1.onSingleLineUpdate_(arg_630_0)
			local var_630_0 = 0
			local var_630_1 = 0.275

			if var_630_0 < arg_627_1.time_ and arg_627_1.time_ <= var_630_0 + arg_630_0 then
				arg_627_1.talkMaxDuration = 0
				arg_627_1.dialogCg_.alpha = 1

				arg_627_1.dialog_:SetActive(true)
				SetActive(arg_627_1.leftNameGo_, true)

				local var_630_2 = arg_627_1:FormatText(StoryNameCfg[7].name)

				arg_627_1.leftNameTxt_.text = var_630_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_627_1.leftNameTxt_.transform)

				arg_627_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_627_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_627_1:RecordName(arg_627_1.leftNameTxt_.text)
				SetActive(arg_627_1.iconTrs_.gameObject, true)
				arg_627_1.iconController_:SetSelectedState("hero")

				arg_627_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_627_1.callingController_:SetSelectedState("normal")

				arg_627_1.keyicon_.color = Color.New(1, 1, 1)
				arg_627_1.icon_.color = Color.New(1, 1, 1)

				local var_630_3 = arg_627_1:GetWordFromCfg(1109402152)
				local var_630_4 = arg_627_1:FormatText(var_630_3.content)

				arg_627_1.text_.text = var_630_4

				LuaForUtil.ClearLinePrefixSymbol(arg_627_1.text_)

				local var_630_5 = 11
				local var_630_6 = utf8.len(var_630_4)
				local var_630_7 = var_630_5 <= 0 and var_630_1 or var_630_1 * (var_630_6 / var_630_5)

				if var_630_7 > 0 and var_630_1 < var_630_7 then
					arg_627_1.talkMaxDuration = var_630_7

					if var_630_7 + var_630_0 > arg_627_1.duration_ then
						arg_627_1.duration_ = var_630_7 + var_630_0
					end
				end

				arg_627_1.text_.text = var_630_4
				arg_627_1.typewritter.percent = 0

				arg_627_1.typewritter:SetDirty()
				arg_627_1:ShowNextGo(false)
				arg_627_1:RecordContent(arg_627_1.text_.text)
			end

			local var_630_8 = math.max(var_630_1, arg_627_1.talkMaxDuration)

			if var_630_0 <= arg_627_1.time_ and arg_627_1.time_ < var_630_0 + var_630_8 then
				arg_627_1.typewritter.percent = (arg_627_1.time_ - var_630_0) / var_630_8

				arg_627_1.typewritter:SetDirty()
			end

			if arg_627_1.time_ >= var_630_0 + var_630_8 and arg_627_1.time_ < var_630_0 + var_630_8 + arg_630_0 then
				arg_627_1.typewritter.percent = 1

				arg_627_1.typewritter:SetDirty()
				arg_627_1:ShowNextGo(true)
			end
		end

		arg_627_1.nodeConfigList_ = {}

		arg_627_1:InitPlayNodeList()
	end,
	Play1109402153 = function(arg_631_0, arg_631_1)
		arg_631_1.time_ = 0
		arg_631_1.frameCnt_ = 0
		arg_631_1.state_ = "playing"
		arg_631_1.curTalkId_ = 1109402153
		arg_631_1.duration_ = 12.5

		local var_631_0 = {
			ja = 12.5,
			ko = 6.3,
			zh = 6.3
		}
		local var_631_1 = manager.audio:GetLocalizationFlag()

		if var_631_0[var_631_1] ~= nil then
			arg_631_1.duration_ = var_631_0[var_631_1]
		end

		SetActive(arg_631_1.tipsGo_, false)

		function arg_631_1.onSingleLineFinish_()
			arg_631_1.onSingleLineUpdate_ = nil
			arg_631_1.onSingleLineFinish_ = nil
			arg_631_1.state_ = "waiting"
		end

		function arg_631_1.playNext_(arg_633_0)
			if arg_633_0 == 1 then
				arg_631_0:Play1109402154(arg_631_1)
			end
		end

		function arg_631_1.onSingleLineUpdate_(arg_634_0)
			local var_634_0 = 0
			local var_634_1 = 0.55

			if var_634_0 < arg_631_1.time_ and arg_631_1.time_ <= var_634_0 + arg_634_0 then
				arg_631_1.talkMaxDuration = 0
				arg_631_1.dialogCg_.alpha = 1

				arg_631_1.dialog_:SetActive(true)
				SetActive(arg_631_1.leftNameGo_, true)

				local var_634_2 = arg_631_1:FormatText(StoryNameCfg[189].name)

				arg_631_1.leftNameTxt_.text = var_634_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_631_1.leftNameTxt_.transform)

				arg_631_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_631_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_631_1:RecordName(arg_631_1.leftNameTxt_.text)
				SetActive(arg_631_1.iconTrs_.gameObject, true)
				arg_631_1.iconController_:SetSelectedState("hero")

				arg_631_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vina")

				arg_631_1.callingController_:SetSelectedState("normal")

				arg_631_1.keyicon_.color = Color.New(1, 1, 1)
				arg_631_1.icon_.color = Color.New(1, 1, 1)

				local var_634_3 = arg_631_1:GetWordFromCfg(1109402153)
				local var_634_4 = arg_631_1:FormatText(var_634_3.content)

				arg_631_1.text_.text = var_634_4

				LuaForUtil.ClearLinePrefixSymbol(arg_631_1.text_)

				local var_634_5 = 22
				local var_634_6 = utf8.len(var_634_4)
				local var_634_7 = var_634_5 <= 0 and var_634_1 or var_634_1 * (var_634_6 / var_634_5)

				if var_634_7 > 0 and var_634_1 < var_634_7 then
					arg_631_1.talkMaxDuration = var_634_7

					if var_634_7 + var_634_0 > arg_631_1.duration_ then
						arg_631_1.duration_ = var_634_7 + var_634_0
					end
				end

				arg_631_1.text_.text = var_634_4
				arg_631_1.typewritter.percent = 0

				arg_631_1.typewritter:SetDirty()
				arg_631_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402153", "story_v_side_new_1109402.awb") ~= 0 then
					local var_634_8 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402153", "story_v_side_new_1109402.awb") / 1000

					if var_634_8 + var_634_0 > arg_631_1.duration_ then
						arg_631_1.duration_ = var_634_8 + var_634_0
					end

					if var_634_3.prefab_name ~= "" and arg_631_1.actors_[var_634_3.prefab_name] ~= nil then
						local var_634_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_631_1.actors_[var_634_3.prefab_name].transform, "story_v_side_new_1109402", "1109402153", "story_v_side_new_1109402.awb")

						arg_631_1:RecordAudio("1109402153", var_634_9)
						arg_631_1:RecordAudio("1109402153", var_634_9)
					else
						arg_631_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402153", "story_v_side_new_1109402.awb")
					end

					arg_631_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402153", "story_v_side_new_1109402.awb")
				end

				arg_631_1:RecordContent(arg_631_1.text_.text)
			end

			local var_634_10 = math.max(var_634_1, arg_631_1.talkMaxDuration)

			if var_634_0 <= arg_631_1.time_ and arg_631_1.time_ < var_634_0 + var_634_10 then
				arg_631_1.typewritter.percent = (arg_631_1.time_ - var_634_0) / var_634_10

				arg_631_1.typewritter:SetDirty()
			end

			if arg_631_1.time_ >= var_634_0 + var_634_10 and arg_631_1.time_ < var_634_0 + var_634_10 + arg_634_0 then
				arg_631_1.typewritter.percent = 1

				arg_631_1.typewritter:SetDirty()
				arg_631_1:ShowNextGo(true)
			end
		end

		arg_631_1.nodeConfigList_ = {}

		arg_631_1:InitPlayNodeList()
	end,
	Play1109402154 = function(arg_635_0, arg_635_1)
		arg_635_1.time_ = 0
		arg_635_1.frameCnt_ = 0
		arg_635_1.state_ = "playing"
		arg_635_1.curTalkId_ = 1109402154
		arg_635_1.duration_ = 12.27

		local var_635_0 = {
			ja = 12.266,
			ko = 4.666,
			zh = 4.666
		}
		local var_635_1 = manager.audio:GetLocalizationFlag()

		if var_635_0[var_635_1] ~= nil then
			arg_635_1.duration_ = var_635_0[var_635_1]
		end

		SetActive(arg_635_1.tipsGo_, false)

		function arg_635_1.onSingleLineFinish_()
			arg_635_1.onSingleLineUpdate_ = nil
			arg_635_1.onSingleLineFinish_ = nil
			arg_635_1.state_ = "waiting"
		end

		function arg_635_1.playNext_(arg_637_0)
			if arg_637_0 == 1 then
				arg_635_0:Play1109402155(arg_635_1)
			end
		end

		function arg_635_1.onSingleLineUpdate_(arg_638_0)
			local var_638_0 = 0
			local var_638_1 = 0.525

			if var_638_0 < arg_635_1.time_ and arg_635_1.time_ <= var_638_0 + arg_638_0 then
				arg_635_1.talkMaxDuration = 0
				arg_635_1.dialogCg_.alpha = 1

				arg_635_1.dialog_:SetActive(true)
				SetActive(arg_635_1.leftNameGo_, true)

				local var_638_2 = arg_635_1:FormatText(StoryNameCfg[189].name)

				arg_635_1.leftNameTxt_.text = var_638_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_635_1.leftNameTxt_.transform)

				arg_635_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_635_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_635_1:RecordName(arg_635_1.leftNameTxt_.text)
				SetActive(arg_635_1.iconTrs_.gameObject, true)
				arg_635_1.iconController_:SetSelectedState("hero")

				arg_635_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vina")

				arg_635_1.callingController_:SetSelectedState("normal")

				arg_635_1.keyicon_.color = Color.New(1, 1, 1)
				arg_635_1.icon_.color = Color.New(1, 1, 1)

				local var_638_3 = arg_635_1:GetWordFromCfg(1109402154)
				local var_638_4 = arg_635_1:FormatText(var_638_3.content)

				arg_635_1.text_.text = var_638_4

				LuaForUtil.ClearLinePrefixSymbol(arg_635_1.text_)

				local var_638_5 = 21
				local var_638_6 = utf8.len(var_638_4)
				local var_638_7 = var_638_5 <= 0 and var_638_1 or var_638_1 * (var_638_6 / var_638_5)

				if var_638_7 > 0 and var_638_1 < var_638_7 then
					arg_635_1.talkMaxDuration = var_638_7

					if var_638_7 + var_638_0 > arg_635_1.duration_ then
						arg_635_1.duration_ = var_638_7 + var_638_0
					end
				end

				arg_635_1.text_.text = var_638_4
				arg_635_1.typewritter.percent = 0

				arg_635_1.typewritter:SetDirty()
				arg_635_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402154", "story_v_side_new_1109402.awb") ~= 0 then
					local var_638_8 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402154", "story_v_side_new_1109402.awb") / 1000

					if var_638_8 + var_638_0 > arg_635_1.duration_ then
						arg_635_1.duration_ = var_638_8 + var_638_0
					end

					if var_638_3.prefab_name ~= "" and arg_635_1.actors_[var_638_3.prefab_name] ~= nil then
						local var_638_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_635_1.actors_[var_638_3.prefab_name].transform, "story_v_side_new_1109402", "1109402154", "story_v_side_new_1109402.awb")

						arg_635_1:RecordAudio("1109402154", var_638_9)
						arg_635_1:RecordAudio("1109402154", var_638_9)
					else
						arg_635_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402154", "story_v_side_new_1109402.awb")
					end

					arg_635_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402154", "story_v_side_new_1109402.awb")
				end

				arg_635_1:RecordContent(arg_635_1.text_.text)
			end

			local var_638_10 = math.max(var_638_1, arg_635_1.talkMaxDuration)

			if var_638_0 <= arg_635_1.time_ and arg_635_1.time_ < var_638_0 + var_638_10 then
				arg_635_1.typewritter.percent = (arg_635_1.time_ - var_638_0) / var_638_10

				arg_635_1.typewritter:SetDirty()
			end

			if arg_635_1.time_ >= var_638_0 + var_638_10 and arg_635_1.time_ < var_638_0 + var_638_10 + arg_638_0 then
				arg_635_1.typewritter.percent = 1

				arg_635_1.typewritter:SetDirty()
				arg_635_1:ShowNextGo(true)
			end
		end

		arg_635_1.nodeConfigList_ = {}

		arg_635_1:InitPlayNodeList()
	end,
	Play1109402155 = function(arg_639_0, arg_639_1)
		arg_639_1.time_ = 0
		arg_639_1.frameCnt_ = 0
		arg_639_1.state_ = "playing"
		arg_639_1.curTalkId_ = 1109402155
		arg_639_1.duration_ = 3.03

		local var_639_0 = {
			ja = 3.033,
			ko = 2.366,
			zh = 2.366
		}
		local var_639_1 = manager.audio:GetLocalizationFlag()

		if var_639_0[var_639_1] ~= nil then
			arg_639_1.duration_ = var_639_0[var_639_1]
		end

		SetActive(arg_639_1.tipsGo_, false)

		function arg_639_1.onSingleLineFinish_()
			arg_639_1.onSingleLineUpdate_ = nil
			arg_639_1.onSingleLineFinish_ = nil
			arg_639_1.state_ = "waiting"
		end

		function arg_639_1.playNext_(arg_641_0)
			if arg_641_0 == 1 then
				arg_639_0:Play1109402156(arg_639_1)
			end
		end

		function arg_639_1.onSingleLineUpdate_(arg_642_0)
			local var_642_0 = arg_639_1.actors_["1094ui_story"].transform
			local var_642_1 = 0

			if var_642_1 < arg_639_1.time_ and arg_639_1.time_ <= var_642_1 + arg_642_0 then
				arg_639_1.var_.moveOldPos1094ui_story = var_642_0.localPosition
			end

			local var_642_2 = 0.001

			if var_642_1 <= arg_639_1.time_ and arg_639_1.time_ < var_642_1 + var_642_2 then
				local var_642_3 = (arg_639_1.time_ - var_642_1) / var_642_2
				local var_642_4 = Vector3.New(0, -0.84, -6.1)

				var_642_0.localPosition = Vector3.Lerp(arg_639_1.var_.moveOldPos1094ui_story, var_642_4, var_642_3)

				local var_642_5 = manager.ui.mainCamera.transform.position - var_642_0.position

				var_642_0.forward = Vector3.New(var_642_5.x, var_642_5.y, var_642_5.z)

				local var_642_6 = var_642_0.localEulerAngles

				var_642_6.z = 0
				var_642_6.x = 0
				var_642_0.localEulerAngles = var_642_6
			end

			if arg_639_1.time_ >= var_642_1 + var_642_2 and arg_639_1.time_ < var_642_1 + var_642_2 + arg_642_0 then
				var_642_0.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_642_7 = manager.ui.mainCamera.transform.position - var_642_0.position

				var_642_0.forward = Vector3.New(var_642_7.x, var_642_7.y, var_642_7.z)

				local var_642_8 = var_642_0.localEulerAngles

				var_642_8.z = 0
				var_642_8.x = 0
				var_642_0.localEulerAngles = var_642_8
			end

			local var_642_9 = arg_639_1.actors_["1094ui_story"]
			local var_642_10 = 0

			if var_642_10 < arg_639_1.time_ and arg_639_1.time_ <= var_642_10 + arg_642_0 and not isNil(var_642_9) and arg_639_1.var_.characterEffect1094ui_story == nil then
				arg_639_1.var_.characterEffect1094ui_story = var_642_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_642_11 = 0.200000002980232

			if var_642_10 <= arg_639_1.time_ and arg_639_1.time_ < var_642_10 + var_642_11 and not isNil(var_642_9) then
				local var_642_12 = (arg_639_1.time_ - var_642_10) / var_642_11

				if arg_639_1.var_.characterEffect1094ui_story and not isNil(var_642_9) then
					arg_639_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_639_1.time_ >= var_642_10 + var_642_11 and arg_639_1.time_ < var_642_10 + var_642_11 + arg_642_0 and not isNil(var_642_9) and arg_639_1.var_.characterEffect1094ui_story then
				arg_639_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_642_13 = 0

			if var_642_13 < arg_639_1.time_ and arg_639_1.time_ <= var_642_13 + arg_642_0 then
				arg_639_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action1_1")
			end

			local var_642_14 = 0

			if var_642_14 < arg_639_1.time_ and arg_639_1.time_ <= var_642_14 + arg_642_0 then
				arg_639_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_642_15 = 0
			local var_642_16 = 0.225

			if var_642_15 < arg_639_1.time_ and arg_639_1.time_ <= var_642_15 + arg_642_0 then
				arg_639_1.talkMaxDuration = 0
				arg_639_1.dialogCg_.alpha = 1

				arg_639_1.dialog_:SetActive(true)
				SetActive(arg_639_1.leftNameGo_, true)

				local var_642_17 = arg_639_1:FormatText(StoryNameCfg[181].name)

				arg_639_1.leftNameTxt_.text = var_642_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_639_1.leftNameTxt_.transform)

				arg_639_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_639_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_639_1:RecordName(arg_639_1.leftNameTxt_.text)
				SetActive(arg_639_1.iconTrs_.gameObject, false)
				arg_639_1.callingController_:SetSelectedState("normal")

				local var_642_18 = arg_639_1:GetWordFromCfg(1109402155)
				local var_642_19 = arg_639_1:FormatText(var_642_18.content)

				arg_639_1.text_.text = var_642_19

				LuaForUtil.ClearLinePrefixSymbol(arg_639_1.text_)

				local var_642_20 = 9
				local var_642_21 = utf8.len(var_642_19)
				local var_642_22 = var_642_20 <= 0 and var_642_16 or var_642_16 * (var_642_21 / var_642_20)

				if var_642_22 > 0 and var_642_16 < var_642_22 then
					arg_639_1.talkMaxDuration = var_642_22

					if var_642_22 + var_642_15 > arg_639_1.duration_ then
						arg_639_1.duration_ = var_642_22 + var_642_15
					end
				end

				arg_639_1.text_.text = var_642_19
				arg_639_1.typewritter.percent = 0

				arg_639_1.typewritter:SetDirty()
				arg_639_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402155", "story_v_side_new_1109402.awb") ~= 0 then
					local var_642_23 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402155", "story_v_side_new_1109402.awb") / 1000

					if var_642_23 + var_642_15 > arg_639_1.duration_ then
						arg_639_1.duration_ = var_642_23 + var_642_15
					end

					if var_642_18.prefab_name ~= "" and arg_639_1.actors_[var_642_18.prefab_name] ~= nil then
						local var_642_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_639_1.actors_[var_642_18.prefab_name].transform, "story_v_side_new_1109402", "1109402155", "story_v_side_new_1109402.awb")

						arg_639_1:RecordAudio("1109402155", var_642_24)
						arg_639_1:RecordAudio("1109402155", var_642_24)
					else
						arg_639_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402155", "story_v_side_new_1109402.awb")
					end

					arg_639_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402155", "story_v_side_new_1109402.awb")
				end

				arg_639_1:RecordContent(arg_639_1.text_.text)
			end

			local var_642_25 = math.max(var_642_16, arg_639_1.talkMaxDuration)

			if var_642_15 <= arg_639_1.time_ and arg_639_1.time_ < var_642_15 + var_642_25 then
				arg_639_1.typewritter.percent = (arg_639_1.time_ - var_642_15) / var_642_25

				arg_639_1.typewritter:SetDirty()
			end

			if arg_639_1.time_ >= var_642_15 + var_642_25 and arg_639_1.time_ < var_642_15 + var_642_25 + arg_642_0 then
				arg_639_1.typewritter.percent = 1

				arg_639_1.typewritter:SetDirty()
				arg_639_1:ShowNextGo(true)
			end
		end

		arg_639_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_639_1:InitPlayNodeList()
	end,
	Play1109402156 = function(arg_643_0, arg_643_1)
		arg_643_1.time_ = 0
		arg_643_1.frameCnt_ = 0
		arg_643_1.state_ = "playing"
		arg_643_1.curTalkId_ = 1109402156
		arg_643_1.duration_ = 6.33

		local var_643_0 = {
			ja = 4.966,
			ko = 6.333,
			zh = 6.333
		}
		local var_643_1 = manager.audio:GetLocalizationFlag()

		if var_643_0[var_643_1] ~= nil then
			arg_643_1.duration_ = var_643_0[var_643_1]
		end

		SetActive(arg_643_1.tipsGo_, false)

		function arg_643_1.onSingleLineFinish_()
			arg_643_1.onSingleLineUpdate_ = nil
			arg_643_1.onSingleLineFinish_ = nil
			arg_643_1.state_ = "waiting"
		end

		function arg_643_1.playNext_(arg_645_0)
			if arg_645_0 == 1 then
				arg_643_0:Play1109402157(arg_643_1)
			end
		end

		function arg_643_1.onSingleLineUpdate_(arg_646_0)
			local var_646_0 = arg_643_1.actors_["1094ui_story"].transform
			local var_646_1 = 0

			if var_646_1 < arg_643_1.time_ and arg_643_1.time_ <= var_646_1 + arg_646_0 then
				arg_643_1.var_.moveOldPos1094ui_story = var_646_0.localPosition
			end

			local var_646_2 = 0.001

			if var_646_1 <= arg_643_1.time_ and arg_643_1.time_ < var_646_1 + var_646_2 then
				local var_646_3 = (arg_643_1.time_ - var_646_1) / var_646_2
				local var_646_4 = Vector3.New(0, -0.84, -6.1)

				var_646_0.localPosition = Vector3.Lerp(arg_643_1.var_.moveOldPos1094ui_story, var_646_4, var_646_3)

				local var_646_5 = manager.ui.mainCamera.transform.position - var_646_0.position

				var_646_0.forward = Vector3.New(var_646_5.x, var_646_5.y, var_646_5.z)

				local var_646_6 = var_646_0.localEulerAngles

				var_646_6.z = 0
				var_646_6.x = 0
				var_646_0.localEulerAngles = var_646_6
			end

			if arg_643_1.time_ >= var_646_1 + var_646_2 and arg_643_1.time_ < var_646_1 + var_646_2 + arg_646_0 then
				var_646_0.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_646_7 = manager.ui.mainCamera.transform.position - var_646_0.position

				var_646_0.forward = Vector3.New(var_646_7.x, var_646_7.y, var_646_7.z)

				local var_646_8 = var_646_0.localEulerAngles

				var_646_8.z = 0
				var_646_8.x = 0
				var_646_0.localEulerAngles = var_646_8
			end

			local var_646_9 = arg_643_1.actors_["1094ui_story"]
			local var_646_10 = 0

			if var_646_10 < arg_643_1.time_ and arg_643_1.time_ <= var_646_10 + arg_646_0 and not isNil(var_646_9) and arg_643_1.var_.characterEffect1094ui_story == nil then
				arg_643_1.var_.characterEffect1094ui_story = var_646_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_646_11 = 0.200000002980232

			if var_646_10 <= arg_643_1.time_ and arg_643_1.time_ < var_646_10 + var_646_11 and not isNil(var_646_9) then
				local var_646_12 = (arg_643_1.time_ - var_646_10) / var_646_11

				if arg_643_1.var_.characterEffect1094ui_story and not isNil(var_646_9) then
					arg_643_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_643_1.time_ >= var_646_10 + var_646_11 and arg_643_1.time_ < var_646_10 + var_646_11 + arg_646_0 and not isNil(var_646_9) and arg_643_1.var_.characterEffect1094ui_story then
				arg_643_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_646_13 = 0

			if var_646_13 < arg_643_1.time_ and arg_643_1.time_ <= var_646_13 + arg_646_0 then
				arg_643_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action5_1")
			end

			local var_646_14 = 0

			if var_646_14 < arg_643_1.time_ and arg_643_1.time_ <= var_646_14 + arg_646_0 then
				arg_643_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_646_15 = 0
			local var_646_16 = 0.5

			if var_646_15 < arg_643_1.time_ and arg_643_1.time_ <= var_646_15 + arg_646_0 then
				arg_643_1.talkMaxDuration = 0
				arg_643_1.dialogCg_.alpha = 1

				arg_643_1.dialog_:SetActive(true)
				SetActive(arg_643_1.leftNameGo_, true)

				local var_646_17 = arg_643_1:FormatText(StoryNameCfg[181].name)

				arg_643_1.leftNameTxt_.text = var_646_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_643_1.leftNameTxt_.transform)

				arg_643_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_643_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_643_1:RecordName(arg_643_1.leftNameTxt_.text)
				SetActive(arg_643_1.iconTrs_.gameObject, false)
				arg_643_1.callingController_:SetSelectedState("normal")

				local var_646_18 = arg_643_1:GetWordFromCfg(1109402156)
				local var_646_19 = arg_643_1:FormatText(var_646_18.content)

				arg_643_1.text_.text = var_646_19

				LuaForUtil.ClearLinePrefixSymbol(arg_643_1.text_)

				local var_646_20 = 20
				local var_646_21 = utf8.len(var_646_19)
				local var_646_22 = var_646_20 <= 0 and var_646_16 or var_646_16 * (var_646_21 / var_646_20)

				if var_646_22 > 0 and var_646_16 < var_646_22 then
					arg_643_1.talkMaxDuration = var_646_22

					if var_646_22 + var_646_15 > arg_643_1.duration_ then
						arg_643_1.duration_ = var_646_22 + var_646_15
					end
				end

				arg_643_1.text_.text = var_646_19
				arg_643_1.typewritter.percent = 0

				arg_643_1.typewritter:SetDirty()
				arg_643_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402156", "story_v_side_new_1109402.awb") ~= 0 then
					local var_646_23 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402156", "story_v_side_new_1109402.awb") / 1000

					if var_646_23 + var_646_15 > arg_643_1.duration_ then
						arg_643_1.duration_ = var_646_23 + var_646_15
					end

					if var_646_18.prefab_name ~= "" and arg_643_1.actors_[var_646_18.prefab_name] ~= nil then
						local var_646_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_643_1.actors_[var_646_18.prefab_name].transform, "story_v_side_new_1109402", "1109402156", "story_v_side_new_1109402.awb")

						arg_643_1:RecordAudio("1109402156", var_646_24)
						arg_643_1:RecordAudio("1109402156", var_646_24)
					else
						arg_643_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402156", "story_v_side_new_1109402.awb")
					end

					arg_643_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402156", "story_v_side_new_1109402.awb")
				end

				arg_643_1:RecordContent(arg_643_1.text_.text)
			end

			local var_646_25 = math.max(var_646_16, arg_643_1.talkMaxDuration)

			if var_646_15 <= arg_643_1.time_ and arg_643_1.time_ < var_646_15 + var_646_25 then
				arg_643_1.typewritter.percent = (arg_643_1.time_ - var_646_15) / var_646_25

				arg_643_1.typewritter:SetDirty()
			end

			if arg_643_1.time_ >= var_646_15 + var_646_25 and arg_643_1.time_ < var_646_15 + var_646_25 + arg_646_0 then
				arg_643_1.typewritter.percent = 1

				arg_643_1.typewritter:SetDirty()
				arg_643_1:ShowNextGo(true)
			end
		end

		arg_643_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_643_1:InitPlayNodeList()
	end,
	Play1109402157 = function(arg_647_0, arg_647_1)
		arg_647_1.time_ = 0
		arg_647_1.frameCnt_ = 0
		arg_647_1.state_ = "playing"
		arg_647_1.curTalkId_ = 1109402157
		arg_647_1.duration_ = 0.2

		SetActive(arg_647_1.tipsGo_, false)

		function arg_647_1.onSingleLineFinish_()
			arg_647_1.onSingleLineUpdate_ = nil
			arg_647_1.onSingleLineFinish_ = nil
			arg_647_1.state_ = "waiting"

			SetActive(arg_647_1.choicesGo_, true)

			for iter_648_0, iter_648_1 in ipairs(arg_647_1.choices_) do
				local var_648_0 = iter_648_0 <= 1

				SetActive(iter_648_1.go, var_648_0)
			end

			arg_647_1.choices_[1].txt.text = arg_647_1:FormatText(StoryChoiceCfg[407].name)
		end

		function arg_647_1.playNext_(arg_649_0)
			if arg_649_0 == 1 then
				arg_647_0:Play1109402158(arg_647_1)
			end

			arg_647_1:RecordChoiceLog(1109402157, 407)
		end

		function arg_647_1.onSingleLineUpdate_(arg_650_0)
			local var_650_0 = arg_647_1.actors_["1094ui_story"]
			local var_650_1 = 0

			if var_650_1 < arg_647_1.time_ and arg_647_1.time_ <= var_650_1 + arg_650_0 and not isNil(var_650_0) and arg_647_1.var_.characterEffect1094ui_story == nil then
				arg_647_1.var_.characterEffect1094ui_story = var_650_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_650_2 = 0.200000002980232

			if var_650_1 <= arg_647_1.time_ and arg_647_1.time_ < var_650_1 + var_650_2 and not isNil(var_650_0) then
				local var_650_3 = (arg_647_1.time_ - var_650_1) / var_650_2

				if arg_647_1.var_.characterEffect1094ui_story and not isNil(var_650_0) then
					local var_650_4 = Mathf.Lerp(0, 0.5, var_650_3)

					arg_647_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_647_1.var_.characterEffect1094ui_story.fillRatio = var_650_4
				end
			end

			if arg_647_1.time_ >= var_650_1 + var_650_2 and arg_647_1.time_ < var_650_1 + var_650_2 + arg_650_0 and not isNil(var_650_0) and arg_647_1.var_.characterEffect1094ui_story then
				local var_650_5 = 0.5

				arg_647_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_647_1.var_.characterEffect1094ui_story.fillRatio = var_650_5
			end

			local var_650_6 = 0
			local var_650_7 = 0.2

			if var_650_6 < arg_647_1.time_ and arg_647_1.time_ <= var_650_6 + arg_650_0 then
				local var_650_8 = "play"
				local var_650_9 = "music"

				arg_647_1:AudioAction(var_650_8, var_650_9, "ui_battle", "ui_battle_stopbgm", "")

				local var_650_10 = ""
				local var_650_11 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_650_11 ~= "" then
					if arg_647_1.bgmTxt_.text ~= var_650_11 and arg_647_1.bgmTxt_.text ~= "" then
						if arg_647_1.bgmTxt2_.text ~= "" then
							arg_647_1.bgmTxt_.text = arg_647_1.bgmTxt2_.text
						end

						arg_647_1.bgmTxt2_.text = var_650_11

						arg_647_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_647_1.bgmTxt_.text = var_650_11
						arg_647_1.bgmTxt2_.text = var_650_11
					end

					if arg_647_1.bgmTimer then
						arg_647_1.bgmTimer:Stop()

						arg_647_1.bgmTimer = nil
					end

					if arg_647_1.settingData.show_music_name == 1 then
						arg_647_1.musicController:SetSelectedState("show")
						arg_647_1.musicAnimator_:Play("open", 0, 0)

						if arg_647_1.settingData.music_time ~= 0 then
							arg_647_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_647_1.settingData.music_time), function()
								if arg_647_1 == nil or isNil(arg_647_1.bgmTxt_) then
									return
								end

								arg_647_1.musicController:SetSelectedState("hide")
								arg_647_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_650_12 = 0

			if var_650_12 < arg_647_1.time_ and arg_647_1.time_ <= var_650_12 + arg_650_0 then
				arg_647_1.allBtn_.enabled = false
			end

			local var_650_13 = 0.200000002980232

			if arg_647_1.time_ >= var_650_12 + var_650_13 and arg_647_1.time_ < var_650_12 + var_650_13 + arg_650_0 then
				arg_647_1.allBtn_.enabled = true
			end
		end

		arg_647_1.nodeConfigList_ = {}

		arg_647_1:InitPlayNodeList()
	end,
	Play1109402158 = function(arg_652_0, arg_652_1)
		arg_652_1.time_ = 0
		arg_652_1.frameCnt_ = 0
		arg_652_1.state_ = "playing"
		arg_652_1.curTalkId_ = 1109402158
		arg_652_1.duration_ = 7

		SetActive(arg_652_1.tipsGo_, false)

		function arg_652_1.onSingleLineFinish_()
			arg_652_1.onSingleLineUpdate_ = nil
			arg_652_1.onSingleLineFinish_ = nil
			arg_652_1.state_ = "waiting"
		end

		function arg_652_1.playNext_(arg_654_0)
			if arg_654_0 == 1 then
				arg_652_0:Play1109402159(arg_652_1)
			end
		end

		function arg_652_1.onSingleLineUpdate_(arg_655_0)
			local var_655_0 = 0

			if var_655_0 < arg_652_1.time_ and arg_652_1.time_ <= var_655_0 + arg_655_0 then
				local var_655_1 = manager.ui.mainCamera.transform.localPosition
				local var_655_2 = Vector3.New(0, 0, 10) + Vector3.New(var_655_1.x, var_655_1.y, 0)
				local var_655_3 = arg_652_1.bgs_.STblack

				var_655_3.transform.localPosition = var_655_2
				var_655_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_655_4 = var_655_3:GetComponent("SpriteRenderer")

				if var_655_4 and var_655_4.sprite then
					local var_655_5 = (var_655_3.transform.localPosition - var_655_1).z
					local var_655_6 = manager.ui.mainCameraCom_
					local var_655_7 = 2 * var_655_5 * Mathf.Tan(var_655_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_655_8 = var_655_7 * var_655_6.aspect
					local var_655_9 = var_655_4.sprite.bounds.size.x
					local var_655_10 = var_655_4.sprite.bounds.size.y
					local var_655_11 = var_655_8 / var_655_9
					local var_655_12 = var_655_7 / var_655_10
					local var_655_13 = var_655_12 < var_655_11 and var_655_11 or var_655_12

					var_655_3.transform.localScale = Vector3.New(var_655_13, var_655_13, 0)
				end

				for iter_655_0, iter_655_1 in pairs(arg_652_1.bgs_) do
					if iter_655_0 ~= "STblack" then
						iter_655_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_655_14 = 0

			if var_655_14 < arg_652_1.time_ and arg_652_1.time_ <= var_655_14 + arg_655_0 then
				arg_652_1.mask_.enabled = true
				arg_652_1.mask_.raycastTarget = true

				arg_652_1:SetGaussion(false)
			end

			local var_655_15 = 2

			if var_655_14 <= arg_652_1.time_ and arg_652_1.time_ < var_655_14 + var_655_15 then
				local var_655_16 = (arg_652_1.time_ - var_655_14) / var_655_15
				local var_655_17 = Color.New(0, 0, 0)

				var_655_17.a = Mathf.Lerp(1, 0, var_655_16)
				arg_652_1.mask_.color = var_655_17
			end

			if arg_652_1.time_ >= var_655_14 + var_655_15 and arg_652_1.time_ < var_655_14 + var_655_15 + arg_655_0 then
				local var_655_18 = Color.New(0, 0, 0)
				local var_655_19 = 0

				arg_652_1.mask_.enabled = false
				var_655_18.a = var_655_19
				arg_652_1.mask_.color = var_655_18
			end

			local var_655_20 = arg_652_1.actors_["1094ui_story"].transform
			local var_655_21 = 0

			if var_655_21 < arg_652_1.time_ and arg_652_1.time_ <= var_655_21 + arg_655_0 then
				arg_652_1.var_.moveOldPos1094ui_story = var_655_20.localPosition
			end

			local var_655_22 = 0.001

			if var_655_21 <= arg_652_1.time_ and arg_652_1.time_ < var_655_21 + var_655_22 then
				local var_655_23 = (arg_652_1.time_ - var_655_21) / var_655_22
				local var_655_24 = Vector3.New(0, 100, 0)

				var_655_20.localPosition = Vector3.Lerp(arg_652_1.var_.moveOldPos1094ui_story, var_655_24, var_655_23)

				local var_655_25 = manager.ui.mainCamera.transform.position - var_655_20.position

				var_655_20.forward = Vector3.New(var_655_25.x, var_655_25.y, var_655_25.z)

				local var_655_26 = var_655_20.localEulerAngles

				var_655_26.z = 0
				var_655_26.x = 0
				var_655_20.localEulerAngles = var_655_26
			end

			if arg_652_1.time_ >= var_655_21 + var_655_22 and arg_652_1.time_ < var_655_21 + var_655_22 + arg_655_0 then
				var_655_20.localPosition = Vector3.New(0, 100, 0)

				local var_655_27 = manager.ui.mainCamera.transform.position - var_655_20.position

				var_655_20.forward = Vector3.New(var_655_27.x, var_655_27.y, var_655_27.z)

				local var_655_28 = var_655_20.localEulerAngles

				var_655_28.z = 0
				var_655_28.x = 0
				var_655_20.localEulerAngles = var_655_28
			end

			local var_655_29 = arg_652_1.actors_["1094ui_story"]
			local var_655_30 = 0

			if var_655_30 < arg_652_1.time_ and arg_652_1.time_ <= var_655_30 + arg_655_0 and not isNil(var_655_29) and arg_652_1.var_.characterEffect1094ui_story == nil then
				arg_652_1.var_.characterEffect1094ui_story = var_655_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_655_31 = 0.200000002980232

			if var_655_30 <= arg_652_1.time_ and arg_652_1.time_ < var_655_30 + var_655_31 and not isNil(var_655_29) then
				local var_655_32 = (arg_652_1.time_ - var_655_30) / var_655_31

				if arg_652_1.var_.characterEffect1094ui_story and not isNil(var_655_29) then
					local var_655_33 = Mathf.Lerp(0, 0.5, var_655_32)

					arg_652_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_652_1.var_.characterEffect1094ui_story.fillRatio = var_655_33
				end
			end

			if arg_652_1.time_ >= var_655_30 + var_655_31 and arg_652_1.time_ < var_655_30 + var_655_31 + arg_655_0 and not isNil(var_655_29) and arg_652_1.var_.characterEffect1094ui_story then
				local var_655_34 = 0.5

				arg_652_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_652_1.var_.characterEffect1094ui_story.fillRatio = var_655_34
			end

			local var_655_35 = 0
			local var_655_36 = 0.2

			if var_655_35 < arg_652_1.time_ and arg_652_1.time_ <= var_655_35 + arg_655_0 then
				local var_655_37 = "play"
				local var_655_38 = "music"

				arg_652_1:AudioAction(var_655_37, var_655_38, "ui_battle", "ui_battle_stopbgm", "")

				local var_655_39 = ""
				local var_655_40 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_655_40 ~= "" then
					if arg_652_1.bgmTxt_.text ~= var_655_40 and arg_652_1.bgmTxt_.text ~= "" then
						if arg_652_1.bgmTxt2_.text ~= "" then
							arg_652_1.bgmTxt_.text = arg_652_1.bgmTxt2_.text
						end

						arg_652_1.bgmTxt2_.text = var_655_40

						arg_652_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_652_1.bgmTxt_.text = var_655_40
						arg_652_1.bgmTxt2_.text = var_655_40
					end

					if arg_652_1.bgmTimer then
						arg_652_1.bgmTimer:Stop()

						arg_652_1.bgmTimer = nil
					end

					if arg_652_1.settingData.show_music_name == 1 then
						arg_652_1.musicController:SetSelectedState("show")
						arg_652_1.musicAnimator_:Play("open", 0, 0)

						if arg_652_1.settingData.music_time ~= 0 then
							arg_652_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_652_1.settingData.music_time), function()
								if arg_652_1 == nil or isNil(arg_652_1.bgmTxt_) then
									return
								end

								arg_652_1.musicController:SetSelectedState("hide")
								arg_652_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_655_41 = 1.46666666666667
			local var_655_42 = 1

			if var_655_41 < arg_652_1.time_ and arg_652_1.time_ <= var_655_41 + arg_655_0 then
				local var_655_43 = "play"
				local var_655_44 = "music"

				arg_652_1:AudioAction(var_655_43, var_655_44, "bgm_activity_1_1_hel_story_warm", "bgm_activity_1_1_hel_story_warm", "bgm_activity_1_1_hel_story_warm.awb")

				local var_655_45 = ""
				local var_655_46 = manager.audio:GetAudioName("bgm_activity_1_1_hel_story_warm", "bgm_activity_1_1_hel_story_warm")

				if var_655_46 ~= "" then
					if arg_652_1.bgmTxt_.text ~= var_655_46 and arg_652_1.bgmTxt_.text ~= "" then
						if arg_652_1.bgmTxt2_.text ~= "" then
							arg_652_1.bgmTxt_.text = arg_652_1.bgmTxt2_.text
						end

						arg_652_1.bgmTxt2_.text = var_655_46

						arg_652_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_652_1.bgmTxt_.text = var_655_46
						arg_652_1.bgmTxt2_.text = var_655_46
					end

					if arg_652_1.bgmTimer then
						arg_652_1.bgmTimer:Stop()

						arg_652_1.bgmTimer = nil
					end

					if arg_652_1.settingData.show_music_name == 1 then
						arg_652_1.musicController:SetSelectedState("show")
						arg_652_1.musicAnimator_:Play("open", 0, 0)

						if arg_652_1.settingData.music_time ~= 0 then
							arg_652_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_652_1.settingData.music_time), function()
								if arg_652_1 == nil or isNil(arg_652_1.bgmTxt_) then
									return
								end

								arg_652_1.musicController:SetSelectedState("hide")
								arg_652_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_652_1.frameCnt_ <= 1 then
				arg_652_1.dialog_:SetActive(false)
			end

			local var_655_47 = 2
			local var_655_48 = 0.525

			if var_655_47 < arg_652_1.time_ and arg_652_1.time_ <= var_655_47 + arg_655_0 then
				arg_652_1.talkMaxDuration = 0

				arg_652_1.dialog_:SetActive(true)

				arg_652_1.dialogCg_.alpha = 0

				local var_655_49 = LeanTween.value(arg_652_1.dialog_, 0, 1, 0.3)

				var_655_49:setOnUpdate(LuaHelper.FloatAction(function(arg_658_0)
					arg_652_1.dialogCg_.alpha = arg_658_0
				end))
				var_655_49:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_652_1.dialog_)
					var_655_49:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_652_1.duration_ = arg_652_1.duration_ + 0.3

				SetActive(arg_652_1.leftNameGo_, false)

				arg_652_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_652_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_652_1:RecordName(arg_652_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_652_1.iconTrs_.gameObject, false)
				arg_652_1.callingController_:SetSelectedState("normal")

				local var_655_50 = arg_652_1:GetWordFromCfg(1109402158)
				local var_655_51 = arg_652_1:FormatText(var_655_50.content)

				arg_652_1.text_.text = var_655_51

				LuaForUtil.ClearLinePrefixSymbol(arg_652_1.text_)

				local var_655_52 = 24
				local var_655_53 = utf8.len(var_655_51)
				local var_655_54 = var_655_52 <= 0 and var_655_48 or var_655_48 * (var_655_53 / var_655_52)

				if var_655_54 > 0 and var_655_48 < var_655_54 then
					arg_652_1.talkMaxDuration = var_655_54
					var_655_47 = var_655_47 + 0.3

					if var_655_54 + var_655_47 > arg_652_1.duration_ then
						arg_652_1.duration_ = var_655_54 + var_655_47
					end
				end

				arg_652_1.text_.text = var_655_51
				arg_652_1.typewritter.percent = 0

				arg_652_1.typewritter:SetDirty()
				arg_652_1:ShowNextGo(false)
				arg_652_1:RecordContent(arg_652_1.text_.text)
			end

			local var_655_55 = var_655_47 + 0.3
			local var_655_56 = math.max(var_655_48, arg_652_1.talkMaxDuration)

			if var_655_55 <= arg_652_1.time_ and arg_652_1.time_ < var_655_55 + var_655_56 then
				arg_652_1.typewritter.percent = (arg_652_1.time_ - var_655_55) / var_655_56

				arg_652_1.typewritter:SetDirty()
			end

			if arg_652_1.time_ >= var_655_55 + var_655_56 and arg_652_1.time_ < var_655_55 + var_655_56 + arg_655_0 then
				arg_652_1.typewritter.percent = 1

				arg_652_1.typewritter:SetDirty()
				arg_652_1:ShowNextGo(true)
			end
		end

		arg_652_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_652_1:InitPlayNodeList()
	end,
	Play1109402159 = function(arg_660_0, arg_660_1)
		arg_660_1.time_ = 0
		arg_660_1.frameCnt_ = 0
		arg_660_1.state_ = "playing"
		arg_660_1.curTalkId_ = 1109402159
		arg_660_1.duration_ = 2.83

		local var_660_0 = {
			ja = 2.833,
			ko = 2.666,
			zh = 2.666
		}
		local var_660_1 = manager.audio:GetLocalizationFlag()

		if var_660_0[var_660_1] ~= nil then
			arg_660_1.duration_ = var_660_0[var_660_1]
		end

		SetActive(arg_660_1.tipsGo_, false)

		function arg_660_1.onSingleLineFinish_()
			arg_660_1.onSingleLineUpdate_ = nil
			arg_660_1.onSingleLineFinish_ = nil
			arg_660_1.state_ = "waiting"
		end

		function arg_660_1.playNext_(arg_662_0)
			if arg_662_0 == 1 then
				arg_660_0:Play1109402160(arg_660_1)
			end
		end

		function arg_660_1.onSingleLineUpdate_(arg_663_0)
			local var_663_0 = 0
			local var_663_1 = 0.225

			if var_663_0 < arg_660_1.time_ and arg_660_1.time_ <= var_663_0 + arg_663_0 then
				arg_660_1.talkMaxDuration = 0
				arg_660_1.dialogCg_.alpha = 1

				arg_660_1.dialog_:SetActive(true)
				SetActive(arg_660_1.leftNameGo_, true)

				local var_663_2 = arg_660_1:FormatText(StoryNameCfg[181].name)

				arg_660_1.leftNameTxt_.text = var_663_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_660_1.leftNameTxt_.transform)

				arg_660_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_660_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_660_1:RecordName(arg_660_1.leftNameTxt_.text)
				SetActive(arg_660_1.iconTrs_.gameObject, true)
				arg_660_1.iconController_:SetSelectedState("hero")

				arg_660_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1094")

				arg_660_1.callingController_:SetSelectedState("normal")

				arg_660_1.keyicon_.color = Color.New(1, 1, 1)
				arg_660_1.icon_.color = Color.New(1, 1, 1)

				local var_663_3 = arg_660_1:GetWordFromCfg(1109402159)
				local var_663_4 = arg_660_1:FormatText(var_663_3.content)

				arg_660_1.text_.text = var_663_4

				LuaForUtil.ClearLinePrefixSymbol(arg_660_1.text_)

				local var_663_5 = 9
				local var_663_6 = utf8.len(var_663_4)
				local var_663_7 = var_663_5 <= 0 and var_663_1 or var_663_1 * (var_663_6 / var_663_5)

				if var_663_7 > 0 and var_663_1 < var_663_7 then
					arg_660_1.talkMaxDuration = var_663_7

					if var_663_7 + var_663_0 > arg_660_1.duration_ then
						arg_660_1.duration_ = var_663_7 + var_663_0
					end
				end

				arg_660_1.text_.text = var_663_4
				arg_660_1.typewritter.percent = 0

				arg_660_1.typewritter:SetDirty()
				arg_660_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402159", "story_v_side_new_1109402.awb") ~= 0 then
					local var_663_8 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402159", "story_v_side_new_1109402.awb") / 1000

					if var_663_8 + var_663_0 > arg_660_1.duration_ then
						arg_660_1.duration_ = var_663_8 + var_663_0
					end

					if var_663_3.prefab_name ~= "" and arg_660_1.actors_[var_663_3.prefab_name] ~= nil then
						local var_663_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_660_1.actors_[var_663_3.prefab_name].transform, "story_v_side_new_1109402", "1109402159", "story_v_side_new_1109402.awb")

						arg_660_1:RecordAudio("1109402159", var_663_9)
						arg_660_1:RecordAudio("1109402159", var_663_9)
					else
						arg_660_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402159", "story_v_side_new_1109402.awb")
					end

					arg_660_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402159", "story_v_side_new_1109402.awb")
				end

				arg_660_1:RecordContent(arg_660_1.text_.text)
			end

			local var_663_10 = math.max(var_663_1, arg_660_1.talkMaxDuration)

			if var_663_0 <= arg_660_1.time_ and arg_660_1.time_ < var_663_0 + var_663_10 then
				arg_660_1.typewritter.percent = (arg_660_1.time_ - var_663_0) / var_663_10

				arg_660_1.typewritter:SetDirty()
			end

			if arg_660_1.time_ >= var_663_0 + var_663_10 and arg_660_1.time_ < var_663_0 + var_663_10 + arg_663_0 then
				arg_660_1.typewritter.percent = 1

				arg_660_1.typewritter:SetDirty()
				arg_660_1:ShowNextGo(true)
			end
		end

		arg_660_1.nodeConfigList_ = {}

		arg_660_1:InitPlayNodeList()
	end,
	Play1109402160 = function(arg_664_0, arg_664_1)
		arg_664_1.time_ = 0
		arg_664_1.frameCnt_ = 0
		arg_664_1.state_ = "playing"
		arg_664_1.curTalkId_ = 1109402160
		arg_664_1.duration_ = 7.97

		SetActive(arg_664_1.tipsGo_, false)

		function arg_664_1.onSingleLineFinish_()
			arg_664_1.onSingleLineUpdate_ = nil
			arg_664_1.onSingleLineFinish_ = nil
			arg_664_1.state_ = "waiting"
		end

		function arg_664_1.playNext_(arg_666_0)
			if arg_666_0 == 1 then
				arg_664_0:Play1109402161(arg_664_1)
			end
		end

		function arg_664_1.onSingleLineUpdate_(arg_667_0)
			local var_667_0 = 0

			if var_667_0 < arg_664_1.time_ and arg_664_1.time_ <= var_667_0 + arg_667_0 then
				arg_664_1.fswbg_:SetActive(true)
				arg_664_1.dialog_:SetActive(false)

				arg_664_1.fswtw_.percent = 0

				local var_667_1 = arg_664_1:GetWordFromCfg(1109402160)
				local var_667_2 = arg_664_1:FormatText(var_667_1.content)

				arg_664_1.fswt_.text = var_667_2

				LuaForUtil.ClearLinePrefixSymbol(arg_664_1.fswt_)

				arg_664_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_664_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_664_1.fswtw_:SetDirty()

				arg_664_1.typewritterCharCountI18N = 0

				SetActive(arg_664_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_664_1:ShowNextGo(false)
			end

			local var_667_3 = 0.0166666666666667

			if var_667_3 < arg_664_1.time_ and arg_664_1.time_ <= var_667_3 + arg_667_0 then
				arg_664_1.var_.oldValueTypewriter = arg_664_1.fswtw_.percent

				SetActive(arg_664_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_664_1:ShowNextGo(false)
			end

			local var_667_4 = 0
			local var_667_5 = -9.33333333333333
			local var_667_6 = arg_664_1:GetWordFromCfg(1109402160)
			local var_667_7 = arg_664_1:FormatText(var_667_6.content)
			local var_667_8, var_667_9 = arg_664_1:GetPercentByPara(var_667_7, 1)

			if var_667_3 < arg_664_1.time_ and arg_664_1.time_ <= var_667_3 + arg_667_0 then
				arg_664_1.talkMaxDuration = 0

				local var_667_10 = var_667_4 <= 0 and var_667_5 or var_667_5 * ((var_667_9 - arg_664_1.typewritterCharCountI18N) / var_667_4)

				if var_667_10 > 0 and var_667_5 < var_667_10 then
					arg_664_1.talkMaxDuration = var_667_10

					if var_667_10 + var_667_3 > arg_664_1.duration_ then
						arg_664_1.duration_ = var_667_10 + var_667_3
					end
				end
			end

			local var_667_11 = -9.33333333333333
			local var_667_12 = math.max(var_667_11, arg_664_1.talkMaxDuration)

			if var_667_3 <= arg_664_1.time_ and arg_664_1.time_ < var_667_3 + var_667_12 then
				local var_667_13 = (arg_664_1.time_ - var_667_3) / var_667_12

				arg_664_1.fswtw_.percent = Mathf.Lerp(arg_664_1.var_.oldValueTypewriter, var_667_8, var_667_13)
				arg_664_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_664_1.fswtw_:SetDirty()
			end

			if arg_664_1.time_ >= var_667_3 + var_667_12 and arg_664_1.time_ < var_667_3 + var_667_12 + arg_667_0 then
				arg_664_1.fswtw_.percent = var_667_8

				arg_664_1.fswtw_:SetDirty()
				arg_664_1:ShowNextGo(true)

				arg_664_1.typewritterCharCountI18N = var_667_9
			end

			local var_667_14 = 0
			local var_667_15 = 7.966
			local var_667_16 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402160", "story_v_side_new_1109402.awb") / 1000

			if var_667_16 > 0 and var_667_15 < var_667_16 and var_667_16 + var_667_14 > arg_664_1.duration_ then
				local var_667_17 = var_667_16

				arg_664_1.duration_ = var_667_16 + var_667_14
			end

			if var_667_14 < arg_664_1.time_ and arg_664_1.time_ <= var_667_14 + arg_667_0 then
				local var_667_18 = "play"
				local var_667_19 = "voice"

				arg_664_1:AudioAction(var_667_18, var_667_19, "story_v_side_new_1109402", "1109402160", "story_v_side_new_1109402.awb")
			end
		end

		arg_664_1.nodeConfigList_ = {}

		arg_664_1:InitPlayNodeList()
	end,
	Play1109402161 = function(arg_668_0, arg_668_1)
		arg_668_1.time_ = 0
		arg_668_1.frameCnt_ = 0
		arg_668_1.state_ = "playing"
		arg_668_1.curTalkId_ = 1109402161
		arg_668_1.duration_ = 5.67

		SetActive(arg_668_1.tipsGo_, false)

		function arg_668_1.onSingleLineFinish_()
			arg_668_1.onSingleLineUpdate_ = nil
			arg_668_1.onSingleLineFinish_ = nil
			arg_668_1.state_ = "waiting"
		end

		function arg_668_1.playNext_(arg_670_0)
			if arg_670_0 == 1 then
				arg_668_0:Play1109402162(arg_668_1)
			end
		end

		function arg_668_1.onSingleLineUpdate_(arg_671_0)
			local var_671_0 = 0

			if var_671_0 < arg_668_1.time_ and arg_668_1.time_ <= var_671_0 + arg_671_0 then
				arg_668_1.var_.oldValueTypewriter = arg_668_1.fswtw_.percent

				SetActive(arg_668_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_668_1:ShowNextGo(false)
			end

			local var_671_1 = 0
			local var_671_2 = 0
			local var_671_3 = arg_668_1:GetWordFromCfg(1109402160)
			local var_671_4 = arg_668_1:FormatText(var_671_3.content)
			local var_671_5, var_671_6 = arg_668_1:GetPercentByPara(var_671_4, 6)

			if var_671_0 < arg_668_1.time_ and arg_668_1.time_ <= var_671_0 + arg_671_0 then
				arg_668_1.talkMaxDuration = 0

				local var_671_7 = var_671_1 <= 0 and var_671_2 or var_671_2 * ((var_671_6 - arg_668_1.typewritterCharCountI18N) / var_671_1)

				if var_671_7 > 0 and var_671_2 < var_671_7 then
					arg_668_1.talkMaxDuration = var_671_7

					if var_671_7 + var_671_0 > arg_668_1.duration_ then
						arg_668_1.duration_ = var_671_7 + var_671_0
					end
				end
			end

			local var_671_8 = 0
			local var_671_9 = math.max(var_671_8, arg_668_1.talkMaxDuration)

			if var_671_0 <= arg_668_1.time_ and arg_668_1.time_ < var_671_0 + var_671_9 then
				local var_671_10 = (arg_668_1.time_ - var_671_0) / var_671_9

				arg_668_1.fswtw_.percent = Mathf.Lerp(arg_668_1.var_.oldValueTypewriter, var_671_5, var_671_10)
				arg_668_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_668_1.fswtw_:SetDirty()
			end

			if arg_668_1.time_ >= var_671_0 + var_671_9 and arg_668_1.time_ < var_671_0 + var_671_9 + arg_671_0 then
				arg_668_1.fswtw_.percent = var_671_5

				arg_668_1.fswtw_:SetDirty()
				arg_668_1:ShowNextGo(true)

				arg_668_1.typewritterCharCountI18N = var_671_6
			end

			local var_671_11 = 0

			if var_671_11 < arg_668_1.time_ and arg_668_1.time_ <= var_671_11 + arg_671_0 then
				arg_668_1.var_.oldValueTypewriter = arg_668_1.fswtw_.percent

				SetActive(arg_668_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_668_1:ShowNextGo(false)
			end

			local var_671_12 = 42
			local var_671_13 = 2.8
			local var_671_14 = arg_668_1:GetWordFromCfg(1109402160)
			local var_671_15 = arg_668_1:FormatText(var_671_14.content)
			local var_671_16, var_671_17 = arg_668_1:GetPercentByPara(var_671_15, 1)

			if var_671_11 < arg_668_1.time_ and arg_668_1.time_ <= var_671_11 + arg_671_0 then
				arg_668_1.talkMaxDuration = 0

				local var_671_18 = var_671_12 <= 0 and var_671_13 or var_671_13 * ((var_671_17 - arg_668_1.typewritterCharCountI18N) / var_671_12)

				if var_671_18 > 0 and var_671_13 < var_671_18 then
					arg_668_1.talkMaxDuration = var_671_18

					if var_671_18 + var_671_11 > arg_668_1.duration_ then
						arg_668_1.duration_ = var_671_18 + var_671_11
					end
				end
			end

			local var_671_19 = 2.8
			local var_671_20 = math.max(var_671_19, arg_668_1.talkMaxDuration)

			if var_671_11 <= arg_668_1.time_ and arg_668_1.time_ < var_671_11 + var_671_20 then
				local var_671_21 = (arg_668_1.time_ - var_671_11) / var_671_20

				arg_668_1.fswtw_.percent = Mathf.Lerp(arg_668_1.var_.oldValueTypewriter, var_671_16, var_671_21)
				arg_668_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_668_1.fswtw_:SetDirty()
			end

			if arg_668_1.time_ >= var_671_11 + var_671_20 and arg_668_1.time_ < var_671_11 + var_671_20 + arg_671_0 then
				arg_668_1.fswtw_.percent = var_671_16

				arg_668_1.fswtw_:SetDirty()
				arg_668_1:ShowNextGo(true)

				arg_668_1.typewritterCharCountI18N = var_671_17
			end

			local var_671_22 = 0
			local var_671_23 = 5.666
			local var_671_24 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402161", "story_v_side_new_1109402.awb") / 1000

			if var_671_24 > 0 and var_671_23 < var_671_24 and var_671_24 + var_671_22 > arg_668_1.duration_ then
				local var_671_25 = var_671_24

				arg_668_1.duration_ = var_671_24 + var_671_22
			end

			if var_671_22 < arg_668_1.time_ and arg_668_1.time_ <= var_671_22 + arg_671_0 then
				local var_671_26 = "play"
				local var_671_27 = "voice"

				arg_668_1:AudioAction(var_671_26, var_671_27, "story_v_side_new_1109402", "1109402161", "story_v_side_new_1109402.awb")
			end
		end

		arg_668_1.nodeConfigList_ = {}

		arg_668_1:InitPlayNodeList()
	end,
	Play1109402162 = function(arg_672_0, arg_672_1)
		arg_672_1.time_ = 0
		arg_672_1.frameCnt_ = 0
		arg_672_1.state_ = "playing"
		arg_672_1.curTalkId_ = 1109402162
		arg_672_1.duration_ = 3.47

		SetActive(arg_672_1.tipsGo_, false)

		function arg_672_1.onSingleLineFinish_()
			arg_672_1.onSingleLineUpdate_ = nil
			arg_672_1.onSingleLineFinish_ = nil
			arg_672_1.state_ = "waiting"
		end

		function arg_672_1.playNext_(arg_674_0)
			if arg_674_0 == 1 then
				arg_672_0:Play1109402163(arg_672_1)
			end
		end

		function arg_672_1.onSingleLineUpdate_(arg_675_0)
			local var_675_0 = 0

			if var_675_0 < arg_672_1.time_ and arg_672_1.time_ <= var_675_0 + arg_675_0 then
				arg_672_1.var_.oldValueTypewriter = arg_672_1.fswtw_.percent

				SetActive(arg_672_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_672_1:ShowNextGo(false)
			end

			local var_675_1 = 0
			local var_675_2 = 0
			local var_675_3 = arg_672_1:GetWordFromCfg(1109402160)
			local var_675_4 = arg_672_1:FormatText(var_675_3.content)
			local var_675_5, var_675_6 = arg_672_1:GetPercentByPara(var_675_4, 6)

			if var_675_0 < arg_672_1.time_ and arg_672_1.time_ <= var_675_0 + arg_675_0 then
				arg_672_1.talkMaxDuration = 0

				local var_675_7 = var_675_1 <= 0 and var_675_2 or var_675_2 * ((var_675_6 - arg_672_1.typewritterCharCountI18N) / var_675_1)

				if var_675_7 > 0 and var_675_2 < var_675_7 then
					arg_672_1.talkMaxDuration = var_675_7

					if var_675_7 + var_675_0 > arg_672_1.duration_ then
						arg_672_1.duration_ = var_675_7 + var_675_0
					end
				end
			end

			local var_675_8 = 0
			local var_675_9 = math.max(var_675_8, arg_672_1.talkMaxDuration)

			if var_675_0 <= arg_672_1.time_ and arg_672_1.time_ < var_675_0 + var_675_9 then
				local var_675_10 = (arg_672_1.time_ - var_675_0) / var_675_9

				arg_672_1.fswtw_.percent = Mathf.Lerp(arg_672_1.var_.oldValueTypewriter, var_675_5, var_675_10)
				arg_672_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_672_1.fswtw_:SetDirty()
			end

			if arg_672_1.time_ >= var_675_0 + var_675_9 and arg_672_1.time_ < var_675_0 + var_675_9 + arg_675_0 then
				arg_672_1.fswtw_.percent = var_675_5

				arg_672_1.fswtw_:SetDirty()
				arg_672_1:ShowNextGo(true)

				arg_672_1.typewritterCharCountI18N = var_675_6
			end

			local var_675_11 = 0

			if var_675_11 < arg_672_1.time_ and arg_672_1.time_ <= var_675_11 + arg_675_0 then
				arg_672_1.var_.oldValueTypewriter = arg_672_1.fswtw_.percent

				SetActive(arg_672_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_672_1:ShowNextGo(false)
			end

			local var_675_12 = 40
			local var_675_13 = 1.26666666666667
			local var_675_14 = arg_672_1:GetWordFromCfg(1109402160)
			local var_675_15 = arg_672_1:FormatText(var_675_14.content)
			local var_675_16, var_675_17 = arg_672_1:GetPercentByPara(var_675_15, 3)

			if var_675_11 < arg_672_1.time_ and arg_672_1.time_ <= var_675_11 + arg_675_0 then
				arg_672_1.talkMaxDuration = 0

				local var_675_18 = var_675_12 <= 0 and var_675_13 or var_675_13 * ((var_675_17 - arg_672_1.typewritterCharCountI18N) / var_675_12)

				if var_675_18 > 0 and var_675_13 < var_675_18 then
					arg_672_1.talkMaxDuration = var_675_18

					if var_675_18 + var_675_11 > arg_672_1.duration_ then
						arg_672_1.duration_ = var_675_18 + var_675_11
					end
				end
			end

			local var_675_19 = 1.26666666666667
			local var_675_20 = math.max(var_675_19, arg_672_1.talkMaxDuration)

			if var_675_11 <= arg_672_1.time_ and arg_672_1.time_ < var_675_11 + var_675_20 then
				local var_675_21 = (arg_672_1.time_ - var_675_11) / var_675_20

				arg_672_1.fswtw_.percent = Mathf.Lerp(arg_672_1.var_.oldValueTypewriter, var_675_16, var_675_21)
				arg_672_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_672_1.fswtw_:SetDirty()
			end

			if arg_672_1.time_ >= var_675_11 + var_675_20 and arg_672_1.time_ < var_675_11 + var_675_20 + arg_675_0 then
				arg_672_1.fswtw_.percent = var_675_16

				arg_672_1.fswtw_:SetDirty()
				arg_672_1:ShowNextGo(true)

				arg_672_1.typewritterCharCountI18N = var_675_17
			end

			local var_675_22 = 0
			local var_675_23 = 3.466
			local var_675_24 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402162", "story_v_side_new_1109402.awb") / 1000

			if var_675_24 > 0 and var_675_23 < var_675_24 and var_675_24 + var_675_22 > arg_672_1.duration_ then
				local var_675_25 = var_675_24

				arg_672_1.duration_ = var_675_24 + var_675_22
			end

			if var_675_22 < arg_672_1.time_ and arg_672_1.time_ <= var_675_22 + arg_675_0 then
				local var_675_26 = "play"
				local var_675_27 = "voice"

				arg_672_1:AudioAction(var_675_26, var_675_27, "story_v_side_new_1109402", "1109402162", "story_v_side_new_1109402.awb")
			end
		end

		arg_672_1.nodeConfigList_ = {}

		arg_672_1:InitPlayNodeList()
	end,
	Play1109402163 = function(arg_676_0, arg_676_1)
		arg_676_1.time_ = 0
		arg_676_1.frameCnt_ = 0
		arg_676_1.state_ = "playing"
		arg_676_1.curTalkId_ = 1109402163
		arg_676_1.duration_ = 1.4

		SetActive(arg_676_1.tipsGo_, false)

		function arg_676_1.onSingleLineFinish_()
			arg_676_1.onSingleLineUpdate_ = nil
			arg_676_1.onSingleLineFinish_ = nil
			arg_676_1.state_ = "waiting"
		end

		function arg_676_1.playNext_(arg_678_0)
			if arg_678_0 == 1 then
				arg_676_0:Play1109402164(arg_676_1)
			end
		end

		function arg_676_1.onSingleLineUpdate_(arg_679_0)
			local var_679_0 = 0

			if var_679_0 < arg_676_1.time_ and arg_676_1.time_ <= var_679_0 + arg_679_0 then
				arg_676_1.var_.oldValueTypewriter = arg_676_1.fswtw_.percent

				SetActive(arg_676_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_676_1:ShowNextGo(false)
			end

			local var_679_1 = 0
			local var_679_2 = 0
			local var_679_3 = arg_676_1:GetWordFromCfg(1109402160)
			local var_679_4 = arg_676_1:FormatText(var_679_3.content)
			local var_679_5, var_679_6 = arg_676_1:GetPercentByPara(var_679_4, 6)

			if var_679_0 < arg_676_1.time_ and arg_676_1.time_ <= var_679_0 + arg_679_0 then
				arg_676_1.talkMaxDuration = 0

				local var_679_7 = var_679_1 <= 0 and var_679_2 or var_679_2 * ((var_679_6 - arg_676_1.typewritterCharCountI18N) / var_679_1)

				if var_679_7 > 0 and var_679_2 < var_679_7 then
					arg_676_1.talkMaxDuration = var_679_7

					if var_679_7 + var_679_0 > arg_676_1.duration_ then
						arg_676_1.duration_ = var_679_7 + var_679_0
					end
				end
			end

			local var_679_8 = 0
			local var_679_9 = math.max(var_679_8, arg_676_1.talkMaxDuration)

			if var_679_0 <= arg_676_1.time_ and arg_676_1.time_ < var_679_0 + var_679_9 then
				local var_679_10 = (arg_676_1.time_ - var_679_0) / var_679_9

				arg_676_1.fswtw_.percent = Mathf.Lerp(arg_676_1.var_.oldValueTypewriter, var_679_5, var_679_10)
				arg_676_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_676_1.fswtw_:SetDirty()
			end

			if arg_676_1.time_ >= var_679_0 + var_679_9 and arg_676_1.time_ < var_679_0 + var_679_9 + arg_679_0 then
				arg_676_1.fswtw_.percent = var_679_5

				arg_676_1.fswtw_:SetDirty()
				arg_676_1:ShowNextGo(true)

				arg_676_1.typewritterCharCountI18N = var_679_6
			end

			local var_679_11 = 0

			if var_679_11 < arg_676_1.time_ and arg_676_1.time_ <= var_679_11 + arg_679_0 then
				arg_676_1.var_.oldValueTypewriter = arg_676_1.fswtw_.percent

				SetActive(arg_676_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_676_1:ShowNextGo(false)
			end

			local var_679_12 = 21
			local var_679_13 = 1.4
			local var_679_14 = arg_676_1:GetWordFromCfg(1109402160)
			local var_679_15 = arg_676_1:FormatText(var_679_14.content)
			local var_679_16, var_679_17 = arg_676_1:GetPercentByPara(var_679_15, 4)

			if var_679_11 < arg_676_1.time_ and arg_676_1.time_ <= var_679_11 + arg_679_0 then
				arg_676_1.talkMaxDuration = 0

				local var_679_18 = var_679_12 <= 0 and var_679_13 or var_679_13 * ((var_679_17 - arg_676_1.typewritterCharCountI18N) / var_679_12)

				if var_679_18 > 0 and var_679_13 < var_679_18 then
					arg_676_1.talkMaxDuration = var_679_18

					if var_679_18 + var_679_11 > arg_676_1.duration_ then
						arg_676_1.duration_ = var_679_18 + var_679_11
					end
				end
			end

			local var_679_19 = 1.4
			local var_679_20 = math.max(var_679_19, arg_676_1.talkMaxDuration)

			if var_679_11 <= arg_676_1.time_ and arg_676_1.time_ < var_679_11 + var_679_20 then
				local var_679_21 = (arg_676_1.time_ - var_679_11) / var_679_20

				arg_676_1.fswtw_.percent = Mathf.Lerp(arg_676_1.var_.oldValueTypewriter, var_679_16, var_679_21)
				arg_676_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_676_1.fswtw_:SetDirty()
			end

			if arg_676_1.time_ >= var_679_11 + var_679_20 and arg_676_1.time_ < var_679_11 + var_679_20 + arg_679_0 then
				arg_676_1.fswtw_.percent = var_679_16

				arg_676_1.fswtw_:SetDirty()
				arg_676_1:ShowNextGo(true)

				arg_676_1.typewritterCharCountI18N = var_679_17
			end
		end

		arg_676_1.nodeConfigList_ = {}

		arg_676_1:InitPlayNodeList()
	end,
	Play1109402164 = function(arg_680_0, arg_680_1)
		arg_680_1.time_ = 0
		arg_680_1.frameCnt_ = 0
		arg_680_1.state_ = "playing"
		arg_680_1.curTalkId_ = 1109402164
		arg_680_1.duration_ = 2.47

		SetActive(arg_680_1.tipsGo_, false)

		function arg_680_1.onSingleLineFinish_()
			arg_680_1.onSingleLineUpdate_ = nil
			arg_680_1.onSingleLineFinish_ = nil
			arg_680_1.state_ = "waiting"
		end

		function arg_680_1.playNext_(arg_682_0)
			if arg_682_0 == 1 then
				arg_680_0:Play1109402165(arg_680_1)
			end
		end

		function arg_680_1.onSingleLineUpdate_(arg_683_0)
			local var_683_0 = 0

			if var_683_0 < arg_680_1.time_ and arg_680_1.time_ <= var_683_0 + arg_683_0 then
				arg_680_1.var_.oldValueTypewriter = arg_680_1.fswtw_.percent

				SetActive(arg_680_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_680_1:ShowNextGo(false)
			end

			local var_683_1 = 0
			local var_683_2 = 0
			local var_683_3 = arg_680_1:GetWordFromCfg(1109402160)
			local var_683_4 = arg_680_1:FormatText(var_683_3.content)
			local var_683_5, var_683_6 = arg_680_1:GetPercentByPara(var_683_4, 6)

			if var_683_0 < arg_680_1.time_ and arg_680_1.time_ <= var_683_0 + arg_683_0 then
				arg_680_1.talkMaxDuration = 0

				local var_683_7 = var_683_1 <= 0 and var_683_2 or var_683_2 * ((var_683_6 - arg_680_1.typewritterCharCountI18N) / var_683_1)

				if var_683_7 > 0 and var_683_2 < var_683_7 then
					arg_680_1.talkMaxDuration = var_683_7

					if var_683_7 + var_683_0 > arg_680_1.duration_ then
						arg_680_1.duration_ = var_683_7 + var_683_0
					end
				end
			end

			local var_683_8 = 0
			local var_683_9 = math.max(var_683_8, arg_680_1.talkMaxDuration)

			if var_683_0 <= arg_680_1.time_ and arg_680_1.time_ < var_683_0 + var_683_9 then
				local var_683_10 = (arg_680_1.time_ - var_683_0) / var_683_9

				arg_680_1.fswtw_.percent = Mathf.Lerp(arg_680_1.var_.oldValueTypewriter, var_683_5, var_683_10)
				arg_680_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_680_1.fswtw_:SetDirty()
			end

			if arg_680_1.time_ >= var_683_0 + var_683_9 and arg_680_1.time_ < var_683_0 + var_683_9 + arg_683_0 then
				arg_680_1.fswtw_.percent = var_683_5

				arg_680_1.fswtw_:SetDirty()
				arg_680_1:ShowNextGo(true)

				arg_680_1.typewritterCharCountI18N = var_683_6
			end

			local var_683_11 = 0

			if var_683_11 < arg_680_1.time_ and arg_680_1.time_ <= var_683_11 + arg_683_0 then
				arg_680_1.var_.oldValueTypewriter = arg_680_1.fswtw_.percent

				SetActive(arg_680_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_680_1:ShowNextGo(false)
			end

			local var_683_12 = 37
			local var_683_13 = 2.46666666666667
			local var_683_14 = arg_680_1:GetWordFromCfg(1109402160)
			local var_683_15 = arg_680_1:FormatText(var_683_14.content)
			local var_683_16, var_683_17 = arg_680_1:GetPercentByPara(var_683_15, 5)

			if var_683_11 < arg_680_1.time_ and arg_680_1.time_ <= var_683_11 + arg_683_0 then
				arg_680_1.talkMaxDuration = 0

				local var_683_18 = var_683_12 <= 0 and var_683_13 or var_683_13 * ((var_683_17 - arg_680_1.typewritterCharCountI18N) / var_683_12)

				if var_683_18 > 0 and var_683_13 < var_683_18 then
					arg_680_1.talkMaxDuration = var_683_18

					if var_683_18 + var_683_11 > arg_680_1.duration_ then
						arg_680_1.duration_ = var_683_18 + var_683_11
					end
				end
			end

			local var_683_19 = 2.46666666666667
			local var_683_20 = math.max(var_683_19, arg_680_1.talkMaxDuration)

			if var_683_11 <= arg_680_1.time_ and arg_680_1.time_ < var_683_11 + var_683_20 then
				local var_683_21 = (arg_680_1.time_ - var_683_11) / var_683_20

				arg_680_1.fswtw_.percent = Mathf.Lerp(arg_680_1.var_.oldValueTypewriter, var_683_16, var_683_21)
				arg_680_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_680_1.fswtw_:SetDirty()
			end

			if arg_680_1.time_ >= var_683_11 + var_683_20 and arg_680_1.time_ < var_683_11 + var_683_20 + arg_683_0 then
				arg_680_1.fswtw_.percent = var_683_16

				arg_680_1.fswtw_:SetDirty()
				arg_680_1:ShowNextGo(true)

				arg_680_1.typewritterCharCountI18N = var_683_17
			end
		end

		arg_680_1.nodeConfigList_ = {}

		arg_680_1:InitPlayNodeList()
	end,
	Play1109402165 = function(arg_684_0, arg_684_1)
		arg_684_1.time_ = 0
		arg_684_1.frameCnt_ = 0
		arg_684_1.state_ = "playing"
		arg_684_1.curTalkId_ = 1109402165
		arg_684_1.duration_ = 5.4

		SetActive(arg_684_1.tipsGo_, false)

		function arg_684_1.onSingleLineFinish_()
			arg_684_1.onSingleLineUpdate_ = nil
			arg_684_1.onSingleLineFinish_ = nil
			arg_684_1.state_ = "waiting"
		end

		function arg_684_1.playNext_(arg_686_0)
			if arg_686_0 == 1 then
				arg_684_0:Play1109402166(arg_684_1)
			end
		end

		function arg_684_1.onSingleLineUpdate_(arg_687_0)
			local var_687_0 = 0

			if var_687_0 < arg_684_1.time_ and arg_684_1.time_ <= var_687_0 + arg_687_0 then
				arg_684_1.var_.oldValueTypewriter = arg_684_1.fswtw_.percent

				SetActive(arg_684_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_684_1:ShowNextGo(false)
			end

			local var_687_1 = 0
			local var_687_2 = 0
			local var_687_3 = arg_684_1:GetWordFromCfg(1109402160)
			local var_687_4 = arg_684_1:FormatText(var_687_3.content)
			local var_687_5, var_687_6 = arg_684_1:GetPercentByPara(var_687_4, 6)

			if var_687_0 < arg_684_1.time_ and arg_684_1.time_ <= var_687_0 + arg_687_0 then
				arg_684_1.talkMaxDuration = 0

				local var_687_7 = var_687_1 <= 0 and var_687_2 or var_687_2 * ((var_687_6 - arg_684_1.typewritterCharCountI18N) / var_687_1)

				if var_687_7 > 0 and var_687_2 < var_687_7 then
					arg_684_1.talkMaxDuration = var_687_7

					if var_687_7 + var_687_0 > arg_684_1.duration_ then
						arg_684_1.duration_ = var_687_7 + var_687_0
					end
				end
			end

			local var_687_8 = 0
			local var_687_9 = math.max(var_687_8, arg_684_1.talkMaxDuration)

			if var_687_0 <= arg_684_1.time_ and arg_684_1.time_ < var_687_0 + var_687_9 then
				local var_687_10 = (arg_684_1.time_ - var_687_0) / var_687_9

				arg_684_1.fswtw_.percent = Mathf.Lerp(arg_684_1.var_.oldValueTypewriter, var_687_5, var_687_10)
				arg_684_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_684_1.fswtw_:SetDirty()
			end

			if arg_684_1.time_ >= var_687_0 + var_687_9 and arg_684_1.time_ < var_687_0 + var_687_9 + arg_687_0 then
				arg_684_1.fswtw_.percent = var_687_5

				arg_684_1.fswtw_:SetDirty()
				arg_684_1:ShowNextGo(true)

				arg_684_1.typewritterCharCountI18N = var_687_6
			end

			local var_687_11 = 0

			if var_687_11 < arg_684_1.time_ and arg_684_1.time_ <= var_687_11 + arg_687_0 then
				arg_684_1.var_.oldValueTypewriter = arg_684_1.fswtw_.percent

				SetActive(arg_684_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_684_1:ShowNextGo(false)
			end

			local var_687_12 = 25
			local var_687_13 = 1.66666666666667
			local var_687_14 = arg_684_1:GetWordFromCfg(1109402160)
			local var_687_15 = arg_684_1:FormatText(var_687_14.content)
			local var_687_16, var_687_17 = arg_684_1:GetPercentByPara(var_687_15, 6)

			if var_687_11 < arg_684_1.time_ and arg_684_1.time_ <= var_687_11 + arg_687_0 then
				arg_684_1.talkMaxDuration = 0

				local var_687_18 = var_687_12 <= 0 and var_687_13 or var_687_13 * ((var_687_17 - arg_684_1.typewritterCharCountI18N) / var_687_12)

				if var_687_18 > 0 and var_687_13 < var_687_18 then
					arg_684_1.talkMaxDuration = var_687_18

					if var_687_18 + var_687_11 > arg_684_1.duration_ then
						arg_684_1.duration_ = var_687_18 + var_687_11
					end
				end
			end

			local var_687_19 = 1.66666666666667
			local var_687_20 = math.max(var_687_19, arg_684_1.talkMaxDuration)

			if var_687_11 <= arg_684_1.time_ and arg_684_1.time_ < var_687_11 + var_687_20 then
				local var_687_21 = (arg_684_1.time_ - var_687_11) / var_687_20

				arg_684_1.fswtw_.percent = Mathf.Lerp(arg_684_1.var_.oldValueTypewriter, var_687_16, var_687_21)
				arg_684_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_684_1.fswtw_:SetDirty()
			end

			if arg_684_1.time_ >= var_687_11 + var_687_20 and arg_684_1.time_ < var_687_11 + var_687_20 + arg_687_0 then
				arg_684_1.fswtw_.percent = var_687_16

				arg_684_1.fswtw_:SetDirty()
				arg_684_1:ShowNextGo(true)

				arg_684_1.typewritterCharCountI18N = var_687_17
			end

			local var_687_22 = 0
			local var_687_23 = 5.4
			local var_687_24 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402165", "story_v_side_new_1109402.awb") / 1000

			if var_687_24 > 0 and var_687_23 < var_687_24 and var_687_24 + var_687_22 > arg_684_1.duration_ then
				local var_687_25 = var_687_24

				arg_684_1.duration_ = var_687_24 + var_687_22
			end

			if var_687_22 < arg_684_1.time_ and arg_684_1.time_ <= var_687_22 + arg_687_0 then
				local var_687_26 = "play"
				local var_687_27 = "voice"

				arg_684_1:AudioAction(var_687_26, var_687_27, "story_v_side_new_1109402", "1109402165", "story_v_side_new_1109402.awb")
			end
		end

		arg_684_1.nodeConfigList_ = {}

		arg_684_1:InitPlayNodeList()
	end,
	Play1109402166 = function(arg_688_0, arg_688_1)
		arg_688_1.time_ = 0
		arg_688_1.frameCnt_ = 0
		arg_688_1.state_ = "playing"
		arg_688_1.curTalkId_ = 1109402166
		arg_688_1.duration_ = 5.93

		SetActive(arg_688_1.tipsGo_, false)

		function arg_688_1.onSingleLineFinish_()
			arg_688_1.onSingleLineUpdate_ = nil
			arg_688_1.onSingleLineFinish_ = nil
			arg_688_1.state_ = "waiting"
		end

		function arg_688_1.playNext_(arg_690_0)
			if arg_690_0 == 1 then
				arg_688_0:Play1109402167(arg_688_1)
			end
		end

		function arg_688_1.onSingleLineUpdate_(arg_691_0)
			local var_691_0 = 0

			if var_691_0 < arg_688_1.time_ and arg_688_1.time_ <= var_691_0 + arg_691_0 then
				arg_688_1.var_.oldValueTypewriter = arg_688_1.fswtw_.percent

				SetActive(arg_688_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_688_1:ShowNextGo(false)
			end

			local var_691_1 = 0
			local var_691_2 = 0
			local var_691_3 = arg_688_1:GetWordFromCfg(1109402160)
			local var_691_4 = arg_688_1:FormatText(var_691_3.content)
			local var_691_5, var_691_6 = arg_688_1:GetPercentByPara(var_691_4, 6)

			if var_691_0 < arg_688_1.time_ and arg_688_1.time_ <= var_691_0 + arg_691_0 then
				arg_688_1.talkMaxDuration = 0

				local var_691_7 = var_691_1 <= 0 and var_691_2 or var_691_2 * ((var_691_6 - arg_688_1.typewritterCharCountI18N) / var_691_1)

				if var_691_7 > 0 and var_691_2 < var_691_7 then
					arg_688_1.talkMaxDuration = var_691_7

					if var_691_7 + var_691_0 > arg_688_1.duration_ then
						arg_688_1.duration_ = var_691_7 + var_691_0
					end
				end
			end

			local var_691_8 = 0
			local var_691_9 = math.max(var_691_8, arg_688_1.talkMaxDuration)

			if var_691_0 <= arg_688_1.time_ and arg_688_1.time_ < var_691_0 + var_691_9 then
				local var_691_10 = (arg_688_1.time_ - var_691_0) / var_691_9

				arg_688_1.fswtw_.percent = Mathf.Lerp(arg_688_1.var_.oldValueTypewriter, var_691_5, var_691_10)
				arg_688_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_688_1.fswtw_:SetDirty()
			end

			if arg_688_1.time_ >= var_691_0 + var_691_9 and arg_688_1.time_ < var_691_0 + var_691_9 + arg_691_0 then
				arg_688_1.fswtw_.percent = var_691_5

				arg_688_1.fswtw_:SetDirty()
				arg_688_1:ShowNextGo(true)

				arg_688_1.typewritterCharCountI18N = var_691_6
			end

			local var_691_11 = 0

			if var_691_11 < arg_688_1.time_ and arg_688_1.time_ <= var_691_11 + arg_691_0 then
				arg_688_1.fswbg_:SetActive(true)
				arg_688_1.dialog_:SetActive(false)

				arg_688_1.fswtw_.percent = 0

				local var_691_12 = arg_688_1:GetWordFromCfg(1109402166)
				local var_691_13 = arg_688_1:FormatText(var_691_12.content)

				arg_688_1.fswt_.text = var_691_13

				LuaForUtil.ClearLinePrefixSymbol(arg_688_1.fswt_)

				arg_688_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_688_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_688_1.fswtw_:SetDirty()

				arg_688_1.typewritterCharCountI18N = 0

				SetActive(arg_688_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_688_1:ShowNextGo(false)
			end

			local var_691_14 = 0.0166666666666667

			if var_691_14 < arg_688_1.time_ and arg_688_1.time_ <= var_691_14 + arg_691_0 then
				arg_688_1.var_.oldValueTypewriter = arg_688_1.fswtw_.percent

				SetActive(arg_688_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_688_1:ShowNextGo(false)
			end

			local var_691_15 = 24
			local var_691_16 = 1.6
			local var_691_17 = arg_688_1:GetWordFromCfg(1109402166)
			local var_691_18 = arg_688_1:FormatText(var_691_17.content)
			local var_691_19, var_691_20 = arg_688_1:GetPercentByPara(var_691_18, 1)

			if var_691_14 < arg_688_1.time_ and arg_688_1.time_ <= var_691_14 + arg_691_0 then
				arg_688_1.talkMaxDuration = 0

				local var_691_21 = var_691_15 <= 0 and var_691_16 or var_691_16 * ((var_691_20 - arg_688_1.typewritterCharCountI18N) / var_691_15)

				if var_691_21 > 0 and var_691_16 < var_691_21 then
					arg_688_1.talkMaxDuration = var_691_21

					if var_691_21 + var_691_14 > arg_688_1.duration_ then
						arg_688_1.duration_ = var_691_21 + var_691_14
					end
				end
			end

			local var_691_22 = 1.6
			local var_691_23 = math.max(var_691_22, arg_688_1.talkMaxDuration)

			if var_691_14 <= arg_688_1.time_ and arg_688_1.time_ < var_691_14 + var_691_23 then
				local var_691_24 = (arg_688_1.time_ - var_691_14) / var_691_23

				arg_688_1.fswtw_.percent = Mathf.Lerp(arg_688_1.var_.oldValueTypewriter, var_691_19, var_691_24)
				arg_688_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_688_1.fswtw_:SetDirty()
			end

			if arg_688_1.time_ >= var_691_14 + var_691_23 and arg_688_1.time_ < var_691_14 + var_691_23 + arg_691_0 then
				arg_688_1.fswtw_.percent = var_691_19

				arg_688_1.fswtw_:SetDirty()
				arg_688_1:ShowNextGo(true)

				arg_688_1.typewritterCharCountI18N = var_691_20
			end

			local var_691_25 = 0
			local var_691_26 = 5.933
			local var_691_27 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402166", "story_v_side_new_1109402.awb") / 1000

			if var_691_27 > 0 and var_691_26 < var_691_27 and var_691_27 + var_691_25 > arg_688_1.duration_ then
				local var_691_28 = var_691_27

				arg_688_1.duration_ = var_691_27 + var_691_25
			end

			if var_691_25 < arg_688_1.time_ and arg_688_1.time_ <= var_691_25 + arg_691_0 then
				local var_691_29 = "play"
				local var_691_30 = "voice"

				arg_688_1:AudioAction(var_691_29, var_691_30, "story_v_side_new_1109402", "1109402166", "story_v_side_new_1109402.awb")
			end
		end

		arg_688_1.nodeConfigList_ = {}

		arg_688_1:InitPlayNodeList()
	end,
	Play1109402167 = function(arg_692_0, arg_692_1)
		arg_692_1.time_ = 0
		arg_692_1.frameCnt_ = 0
		arg_692_1.state_ = "playing"
		arg_692_1.curTalkId_ = 1109402167
		arg_692_1.duration_ = 6.43

		SetActive(arg_692_1.tipsGo_, false)

		function arg_692_1.onSingleLineFinish_()
			arg_692_1.onSingleLineUpdate_ = nil
			arg_692_1.onSingleLineFinish_ = nil
			arg_692_1.state_ = "waiting"
		end

		function arg_692_1.playNext_(arg_694_0)
			if arg_694_0 == 1 then
				arg_692_0:Play1109402168(arg_692_1)
			end
		end

		function arg_692_1.onSingleLineUpdate_(arg_695_0)
			local var_695_0 = 0

			if var_695_0 < arg_692_1.time_ and arg_692_1.time_ <= var_695_0 + arg_695_0 then
				arg_692_1.var_.oldValueTypewriter = arg_692_1.fswtw_.percent

				SetActive(arg_692_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_692_1:ShowNextGo(false)
			end

			local var_695_1 = 26
			local var_695_2 = 1.73333333333333
			local var_695_3 = arg_692_1:GetWordFromCfg(1109402166)
			local var_695_4 = arg_692_1:FormatText(var_695_3.content)
			local var_695_5, var_695_6 = arg_692_1:GetPercentByPara(var_695_4, 2)

			if var_695_0 < arg_692_1.time_ and arg_692_1.time_ <= var_695_0 + arg_695_0 then
				arg_692_1.talkMaxDuration = 0

				local var_695_7 = var_695_1 <= 0 and var_695_2 or var_695_2 * ((var_695_6 - arg_692_1.typewritterCharCountI18N) / var_695_1)

				if var_695_7 > 0 and var_695_2 < var_695_7 then
					arg_692_1.talkMaxDuration = var_695_7

					if var_695_7 + var_695_0 > arg_692_1.duration_ then
						arg_692_1.duration_ = var_695_7 + var_695_0
					end
				end
			end

			local var_695_8 = 1.73333333333333
			local var_695_9 = math.max(var_695_8, arg_692_1.talkMaxDuration)

			if var_695_0 <= arg_692_1.time_ and arg_692_1.time_ < var_695_0 + var_695_9 then
				local var_695_10 = (arg_692_1.time_ - var_695_0) / var_695_9

				arg_692_1.fswtw_.percent = Mathf.Lerp(arg_692_1.var_.oldValueTypewriter, var_695_5, var_695_10)
				arg_692_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_692_1.fswtw_:SetDirty()
			end

			if arg_692_1.time_ >= var_695_0 + var_695_9 and arg_692_1.time_ < var_695_0 + var_695_9 + arg_695_0 then
				arg_692_1.fswtw_.percent = var_695_5

				arg_692_1.fswtw_:SetDirty()
				arg_692_1:ShowNextGo(true)

				arg_692_1.typewritterCharCountI18N = var_695_6
			end

			local var_695_11 = 0
			local var_695_12 = 6.433
			local var_695_13 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402167", "story_v_side_new_1109402.awb") / 1000

			if var_695_13 > 0 and var_695_12 < var_695_13 and var_695_13 + var_695_11 > arg_692_1.duration_ then
				local var_695_14 = var_695_13

				arg_692_1.duration_ = var_695_13 + var_695_11
			end

			if var_695_11 < arg_692_1.time_ and arg_692_1.time_ <= var_695_11 + arg_695_0 then
				local var_695_15 = "play"
				local var_695_16 = "voice"

				arg_692_1:AudioAction(var_695_15, var_695_16, "story_v_side_new_1109402", "1109402167", "story_v_side_new_1109402.awb")
			end
		end

		arg_692_1.nodeConfigList_ = {}

		arg_692_1:InitPlayNodeList()
	end,
	Play1109402168 = function(arg_696_0, arg_696_1)
		arg_696_1.time_ = 0
		arg_696_1.frameCnt_ = 0
		arg_696_1.state_ = "playing"
		arg_696_1.curTalkId_ = 1109402168
		arg_696_1.duration_ = 6.17

		SetActive(arg_696_1.tipsGo_, false)

		function arg_696_1.onSingleLineFinish_()
			arg_696_1.onSingleLineUpdate_ = nil
			arg_696_1.onSingleLineFinish_ = nil
			arg_696_1.state_ = "waiting"
		end

		function arg_696_1.playNext_(arg_698_0)
			if arg_698_0 == 1 then
				arg_696_0:Play1109402169(arg_696_1)
			end
		end

		function arg_696_1.onSingleLineUpdate_(arg_699_0)
			local var_699_0 = 0

			if var_699_0 < arg_696_1.time_ and arg_696_1.time_ <= var_699_0 + arg_699_0 then
				arg_696_1.var_.oldValueTypewriter = arg_696_1.fswtw_.percent

				SetActive(arg_696_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_696_1:ShowNextGo(false)
			end

			local var_699_1 = 28
			local var_699_2 = 1.86666666666667
			local var_699_3 = arg_696_1:GetWordFromCfg(1109402166)
			local var_699_4 = arg_696_1:FormatText(var_699_3.content)
			local var_699_5, var_699_6 = arg_696_1:GetPercentByPara(var_699_4, 3)

			if var_699_0 < arg_696_1.time_ and arg_696_1.time_ <= var_699_0 + arg_699_0 then
				arg_696_1.talkMaxDuration = 0

				local var_699_7 = var_699_1 <= 0 and var_699_2 or var_699_2 * ((var_699_6 - arg_696_1.typewritterCharCountI18N) / var_699_1)

				if var_699_7 > 0 and var_699_2 < var_699_7 then
					arg_696_1.talkMaxDuration = var_699_7

					if var_699_7 + var_699_0 > arg_696_1.duration_ then
						arg_696_1.duration_ = var_699_7 + var_699_0
					end
				end
			end

			local var_699_8 = 1.86666666666667
			local var_699_9 = math.max(var_699_8, arg_696_1.talkMaxDuration)

			if var_699_0 <= arg_696_1.time_ and arg_696_1.time_ < var_699_0 + var_699_9 then
				local var_699_10 = (arg_696_1.time_ - var_699_0) / var_699_9

				arg_696_1.fswtw_.percent = Mathf.Lerp(arg_696_1.var_.oldValueTypewriter, var_699_5, var_699_10)
				arg_696_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_696_1.fswtw_:SetDirty()
			end

			if arg_696_1.time_ >= var_699_0 + var_699_9 and arg_696_1.time_ < var_699_0 + var_699_9 + arg_699_0 then
				arg_696_1.fswtw_.percent = var_699_5

				arg_696_1.fswtw_:SetDirty()
				arg_696_1:ShowNextGo(true)

				arg_696_1.typewritterCharCountI18N = var_699_6
			end

			local var_699_11 = 0
			local var_699_12 = 6.166
			local var_699_13 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402168", "story_v_side_new_1109402.awb") / 1000

			if var_699_13 > 0 and var_699_12 < var_699_13 and var_699_13 + var_699_11 > arg_696_1.duration_ then
				local var_699_14 = var_699_13

				arg_696_1.duration_ = var_699_13 + var_699_11
			end

			if var_699_11 < arg_696_1.time_ and arg_696_1.time_ <= var_699_11 + arg_699_0 then
				local var_699_15 = "play"
				local var_699_16 = "voice"

				arg_696_1:AudioAction(var_699_15, var_699_16, "story_v_side_new_1109402", "1109402168", "story_v_side_new_1109402.awb")
			end
		end

		arg_696_1.nodeConfigList_ = {}

		arg_696_1:InitPlayNodeList()
	end,
	Play1109402169 = function(arg_700_0, arg_700_1)
		arg_700_1.time_ = 0
		arg_700_1.frameCnt_ = 0
		arg_700_1.state_ = "playing"
		arg_700_1.curTalkId_ = 1109402169
		arg_700_1.duration_ = 2.53

		SetActive(arg_700_1.tipsGo_, false)

		function arg_700_1.onSingleLineFinish_()
			arg_700_1.onSingleLineUpdate_ = nil
			arg_700_1.onSingleLineFinish_ = nil
			arg_700_1.state_ = "waiting"
		end

		function arg_700_1.playNext_(arg_702_0)
			if arg_702_0 == 1 then
				arg_700_0:Play1109402170(arg_700_1)
			end
		end

		function arg_700_1.onSingleLineUpdate_(arg_703_0)
			local var_703_0 = 0

			if var_703_0 < arg_700_1.time_ and arg_700_1.time_ <= var_703_0 + arg_703_0 then
				arg_700_1.var_.oldValueTypewriter = arg_700_1.fswtw_.percent

				SetActive(arg_700_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_700_1:ShowNextGo(false)
			end

			local var_703_1 = 38
			local var_703_2 = 2.53333333333333
			local var_703_3 = arg_700_1:GetWordFromCfg(1109402166)
			local var_703_4 = arg_700_1:FormatText(var_703_3.content)
			local var_703_5, var_703_6 = arg_700_1:GetPercentByPara(var_703_4, 4)

			if var_703_0 < arg_700_1.time_ and arg_700_1.time_ <= var_703_0 + arg_703_0 then
				arg_700_1.talkMaxDuration = 0

				local var_703_7 = var_703_1 <= 0 and var_703_2 or var_703_2 * ((var_703_6 - arg_700_1.typewritterCharCountI18N) / var_703_1)

				if var_703_7 > 0 and var_703_2 < var_703_7 then
					arg_700_1.talkMaxDuration = var_703_7

					if var_703_7 + var_703_0 > arg_700_1.duration_ then
						arg_700_1.duration_ = var_703_7 + var_703_0
					end
				end
			end

			local var_703_8 = 2.53333333333333
			local var_703_9 = math.max(var_703_8, arg_700_1.talkMaxDuration)

			if var_703_0 <= arg_700_1.time_ and arg_700_1.time_ < var_703_0 + var_703_9 then
				local var_703_10 = (arg_700_1.time_ - var_703_0) / var_703_9

				arg_700_1.fswtw_.percent = Mathf.Lerp(arg_700_1.var_.oldValueTypewriter, var_703_5, var_703_10)
				arg_700_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_700_1.fswtw_:SetDirty()
			end

			if arg_700_1.time_ >= var_703_0 + var_703_9 and arg_700_1.time_ < var_703_0 + var_703_9 + arg_703_0 then
				arg_700_1.fswtw_.percent = var_703_5

				arg_700_1.fswtw_:SetDirty()
				arg_700_1:ShowNextGo(true)

				arg_700_1.typewritterCharCountI18N = var_703_6
			end
		end

		arg_700_1.nodeConfigList_ = {}

		arg_700_1:InitPlayNodeList()
	end,
	Play1109402170 = function(arg_704_0, arg_704_1)
		arg_704_1.time_ = 0
		arg_704_1.frameCnt_ = 0
		arg_704_1.state_ = "playing"
		arg_704_1.curTalkId_ = 1109402170
		arg_704_1.duration_ = 6.93

		SetActive(arg_704_1.tipsGo_, false)

		function arg_704_1.onSingleLineFinish_()
			arg_704_1.onSingleLineUpdate_ = nil
			arg_704_1.onSingleLineFinish_ = nil
			arg_704_1.state_ = "waiting"
		end

		function arg_704_1.playNext_(arg_706_0)
			if arg_706_0 == 1 then
				arg_704_0:Play1109402171(arg_704_1)
			end
		end

		function arg_704_1.onSingleLineUpdate_(arg_707_0)
			local var_707_0 = 0

			if var_707_0 < arg_704_1.time_ and arg_704_1.time_ <= var_707_0 + arg_707_0 then
				arg_704_1.var_.oldValueTypewriter = arg_704_1.fswtw_.percent

				SetActive(arg_704_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_704_1:ShowNextGo(false)
			end

			local var_707_1 = 35
			local var_707_2 = 2.33333333333333
			local var_707_3 = arg_704_1:GetWordFromCfg(1109402166)
			local var_707_4 = arg_704_1:FormatText(var_707_3.content)
			local var_707_5, var_707_6 = arg_704_1:GetPercentByPara(var_707_4, 5)

			if var_707_0 < arg_704_1.time_ and arg_704_1.time_ <= var_707_0 + arg_707_0 then
				arg_704_1.talkMaxDuration = 0

				local var_707_7 = var_707_1 <= 0 and var_707_2 or var_707_2 * ((var_707_6 - arg_704_1.typewritterCharCountI18N) / var_707_1)

				if var_707_7 > 0 and var_707_2 < var_707_7 then
					arg_704_1.talkMaxDuration = var_707_7

					if var_707_7 + var_707_0 > arg_704_1.duration_ then
						arg_704_1.duration_ = var_707_7 + var_707_0
					end
				end
			end

			local var_707_8 = 2.33333333333333
			local var_707_9 = math.max(var_707_8, arg_704_1.talkMaxDuration)

			if var_707_0 <= arg_704_1.time_ and arg_704_1.time_ < var_707_0 + var_707_9 then
				local var_707_10 = (arg_704_1.time_ - var_707_0) / var_707_9

				arg_704_1.fswtw_.percent = Mathf.Lerp(arg_704_1.var_.oldValueTypewriter, var_707_5, var_707_10)
				arg_704_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_704_1.fswtw_:SetDirty()
			end

			if arg_704_1.time_ >= var_707_0 + var_707_9 and arg_704_1.time_ < var_707_0 + var_707_9 + arg_707_0 then
				arg_704_1.fswtw_.percent = var_707_5

				arg_704_1.fswtw_:SetDirty()
				arg_704_1:ShowNextGo(true)

				arg_704_1.typewritterCharCountI18N = var_707_6
			end

			local var_707_11 = 0
			local var_707_12 = 6.933
			local var_707_13 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402170", "story_v_side_new_1109402.awb") / 1000

			if var_707_13 > 0 and var_707_12 < var_707_13 and var_707_13 + var_707_11 > arg_704_1.duration_ then
				local var_707_14 = var_707_13

				arg_704_1.duration_ = var_707_13 + var_707_11
			end

			if var_707_11 < arg_704_1.time_ and arg_704_1.time_ <= var_707_11 + arg_707_0 then
				local var_707_15 = "play"
				local var_707_16 = "voice"

				arg_704_1:AudioAction(var_707_15, var_707_16, "story_v_side_new_1109402", "1109402170", "story_v_side_new_1109402.awb")
			end
		end

		arg_704_1.nodeConfigList_ = {}

		arg_704_1:InitPlayNodeList()
	end,
	Play1109402171 = function(arg_708_0, arg_708_1)
		arg_708_1.time_ = 0
		arg_708_1.frameCnt_ = 0
		arg_708_1.state_ = "playing"
		arg_708_1.curTalkId_ = 1109402171
		arg_708_1.duration_ = 2.33

		SetActive(arg_708_1.tipsGo_, false)

		function arg_708_1.onSingleLineFinish_()
			arg_708_1.onSingleLineUpdate_ = nil
			arg_708_1.onSingleLineFinish_ = nil
			arg_708_1.state_ = "waiting"
		end

		function arg_708_1.playNext_(arg_710_0)
			if arg_710_0 == 1 then
				arg_708_0:Play1109402172(arg_708_1)
			end
		end

		function arg_708_1.onSingleLineUpdate_(arg_711_0)
			local var_711_0 = 0

			if var_711_0 < arg_708_1.time_ and arg_708_1.time_ <= var_711_0 + arg_711_0 then
				arg_708_1.var_.oldValueTypewriter = arg_708_1.fswtw_.percent

				SetActive(arg_708_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_708_1:ShowNextGo(false)
			end

			local var_711_1 = 35
			local var_711_2 = 2.33333333333333
			local var_711_3 = arg_708_1:GetWordFromCfg(1109402166)
			local var_711_4 = arg_708_1:FormatText(var_711_3.content)
			local var_711_5, var_711_6 = arg_708_1:GetPercentByPara(var_711_4, 6)

			if var_711_0 < arg_708_1.time_ and arg_708_1.time_ <= var_711_0 + arg_711_0 then
				arg_708_1.talkMaxDuration = 0

				local var_711_7 = var_711_1 <= 0 and var_711_2 or var_711_2 * ((var_711_6 - arg_708_1.typewritterCharCountI18N) / var_711_1)

				if var_711_7 > 0 and var_711_2 < var_711_7 then
					arg_708_1.talkMaxDuration = var_711_7

					if var_711_7 + var_711_0 > arg_708_1.duration_ then
						arg_708_1.duration_ = var_711_7 + var_711_0
					end
				end
			end

			local var_711_8 = 2.33333333333333
			local var_711_9 = math.max(var_711_8, arg_708_1.talkMaxDuration)

			if var_711_0 <= arg_708_1.time_ and arg_708_1.time_ < var_711_0 + var_711_9 then
				local var_711_10 = (arg_708_1.time_ - var_711_0) / var_711_9

				arg_708_1.fswtw_.percent = Mathf.Lerp(arg_708_1.var_.oldValueTypewriter, var_711_5, var_711_10)
				arg_708_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_708_1.fswtw_:SetDirty()
			end

			if arg_708_1.time_ >= var_711_0 + var_711_9 and arg_708_1.time_ < var_711_0 + var_711_9 + arg_711_0 then
				arg_708_1.fswtw_.percent = var_711_5

				arg_708_1.fswtw_:SetDirty()
				arg_708_1:ShowNextGo(true)

				arg_708_1.typewritterCharCountI18N = var_711_6
			end
		end

		arg_708_1.nodeConfigList_ = {}

		arg_708_1:InitPlayNodeList()
	end,
	Play1109402172 = function(arg_712_0, arg_712_1)
		arg_712_1.time_ = 0
		arg_712_1.frameCnt_ = 0
		arg_712_1.state_ = "playing"
		arg_712_1.curTalkId_ = 1109402172
		arg_712_1.duration_ = 1

		SetActive(arg_712_1.tipsGo_, false)

		function arg_712_1.onSingleLineFinish_()
			arg_712_1.onSingleLineUpdate_ = nil
			arg_712_1.onSingleLineFinish_ = nil
			arg_712_1.state_ = "waiting"
		end

		function arg_712_1.playNext_(arg_714_0)
			if arg_714_0 == 1 then
				arg_712_0:Play1109402173(arg_712_1)
			end
		end

		function arg_712_1.onSingleLineUpdate_(arg_715_0)
			local var_715_0 = 0

			if var_715_0 < arg_712_1.time_ and arg_712_1.time_ <= var_715_0 + arg_715_0 then
				arg_712_1.fswbg_:SetActive(true)
				arg_712_1.dialog_:SetActive(false)

				arg_712_1.fswtw_.percent = 0

				local var_715_1 = arg_712_1:GetWordFromCfg(1109402172)
				local var_715_2 = arg_712_1:FormatText(var_715_1.content)

				arg_712_1.fswt_.text = var_715_2

				LuaForUtil.ClearLinePrefixSymbol(arg_712_1.fswt_)

				arg_712_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_712_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_712_1.fswtw_:SetDirty()

				arg_712_1.typewritterCharCountI18N = 0

				SetActive(arg_712_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_712_1:ShowNextGo(false)
			end

			local var_715_3 = 0.0166666666666667

			if var_715_3 < arg_712_1.time_ and arg_712_1.time_ <= var_715_3 + arg_715_0 then
				arg_712_1.var_.oldValueTypewriter = arg_712_1.fswtw_.percent

				SetActive(arg_712_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_712_1:ShowNextGo(false)
			end

			local var_715_4 = 12
			local var_715_5 = 0.8
			local var_715_6 = arg_712_1:GetWordFromCfg(1109402172)
			local var_715_7 = arg_712_1:FormatText(var_715_6.content)
			local var_715_8, var_715_9 = arg_712_1:GetPercentByPara(var_715_7, 1)

			if var_715_3 < arg_712_1.time_ and arg_712_1.time_ <= var_715_3 + arg_715_0 then
				arg_712_1.talkMaxDuration = 0

				local var_715_10 = var_715_4 <= 0 and var_715_5 or var_715_5 * ((var_715_9 - arg_712_1.typewritterCharCountI18N) / var_715_4)

				if var_715_10 > 0 and var_715_5 < var_715_10 then
					arg_712_1.talkMaxDuration = var_715_10

					if var_715_10 + var_715_3 > arg_712_1.duration_ then
						arg_712_1.duration_ = var_715_10 + var_715_3
					end
				end
			end

			local var_715_11 = 0.8
			local var_715_12 = math.max(var_715_11, arg_712_1.talkMaxDuration)

			if var_715_3 <= arg_712_1.time_ and arg_712_1.time_ < var_715_3 + var_715_12 then
				local var_715_13 = (arg_712_1.time_ - var_715_3) / var_715_12

				arg_712_1.fswtw_.percent = Mathf.Lerp(arg_712_1.var_.oldValueTypewriter, var_715_8, var_715_13)
				arg_712_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_712_1.fswtw_:SetDirty()
			end

			if arg_712_1.time_ >= var_715_3 + var_715_12 and arg_712_1.time_ < var_715_3 + var_715_12 + arg_715_0 then
				arg_712_1.fswtw_.percent = var_715_8

				arg_712_1.fswtw_:SetDirty()
				arg_712_1:ShowNextGo(true)

				arg_712_1.typewritterCharCountI18N = var_715_9
			end
		end

		arg_712_1.nodeConfigList_ = {}

		arg_712_1:InitPlayNodeList()
	end,
	Play1109402173 = function(arg_716_0, arg_716_1)
		arg_716_1.time_ = 0
		arg_716_1.frameCnt_ = 0
		arg_716_1.state_ = "playing"
		arg_716_1.curTalkId_ = 1109402173
		arg_716_1.duration_ = 2.13

		SetActive(arg_716_1.tipsGo_, false)

		function arg_716_1.onSingleLineFinish_()
			arg_716_1.onSingleLineUpdate_ = nil
			arg_716_1.onSingleLineFinish_ = nil
			arg_716_1.state_ = "waiting"
		end

		function arg_716_1.playNext_(arg_718_0)
			if arg_718_0 == 1 then
				arg_716_0:Play1109402174(arg_716_1)
			end
		end

		function arg_716_1.onSingleLineUpdate_(arg_719_0)
			local var_719_0 = 0

			if var_719_0 < arg_716_1.time_ and arg_716_1.time_ <= var_719_0 + arg_719_0 then
				arg_716_1.var_.oldValueTypewriter = arg_716_1.fswtw_.percent

				SetActive(arg_716_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_716_1:ShowNextGo(false)
			end

			local var_719_1 = 32
			local var_719_2 = 2.13333333333333
			local var_719_3 = arg_716_1:GetWordFromCfg(1109402172)
			local var_719_4 = arg_716_1:FormatText(var_719_3.content)
			local var_719_5, var_719_6 = arg_716_1:GetPercentByPara(var_719_4, 2)

			if var_719_0 < arg_716_1.time_ and arg_716_1.time_ <= var_719_0 + arg_719_0 then
				arg_716_1.talkMaxDuration = 0

				local var_719_7 = var_719_1 <= 0 and var_719_2 or var_719_2 * ((var_719_6 - arg_716_1.typewritterCharCountI18N) / var_719_1)

				if var_719_7 > 0 and var_719_2 < var_719_7 then
					arg_716_1.talkMaxDuration = var_719_7

					if var_719_7 + var_719_0 > arg_716_1.duration_ then
						arg_716_1.duration_ = var_719_7 + var_719_0
					end
				end
			end

			local var_719_8 = 2.13333333333333
			local var_719_9 = math.max(var_719_8, arg_716_1.talkMaxDuration)

			if var_719_0 <= arg_716_1.time_ and arg_716_1.time_ < var_719_0 + var_719_9 then
				local var_719_10 = (arg_716_1.time_ - var_719_0) / var_719_9

				arg_716_1.fswtw_.percent = Mathf.Lerp(arg_716_1.var_.oldValueTypewriter, var_719_5, var_719_10)
				arg_716_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_716_1.fswtw_:SetDirty()
			end

			if arg_716_1.time_ >= var_719_0 + var_719_9 and arg_716_1.time_ < var_719_0 + var_719_9 + arg_719_0 then
				arg_716_1.fswtw_.percent = var_719_5

				arg_716_1.fswtw_:SetDirty()
				arg_716_1:ShowNextGo(true)

				arg_716_1.typewritterCharCountI18N = var_719_6
			end
		end

		arg_716_1.nodeConfigList_ = {}

		arg_716_1:InitPlayNodeList()
	end,
	Play1109402174 = function(arg_720_0, arg_720_1)
		arg_720_1.time_ = 0
		arg_720_1.frameCnt_ = 0
		arg_720_1.state_ = "playing"
		arg_720_1.curTalkId_ = 1109402174
		arg_720_1.duration_ = 2.7

		SetActive(arg_720_1.tipsGo_, false)

		function arg_720_1.onSingleLineFinish_()
			arg_720_1.onSingleLineUpdate_ = nil
			arg_720_1.onSingleLineFinish_ = nil
			arg_720_1.state_ = "waiting"
		end

		function arg_720_1.playNext_(arg_722_0)
			if arg_722_0 == 1 then
				arg_720_0:Play1109402175(arg_720_1)
			end
		end

		function arg_720_1.onSingleLineUpdate_(arg_723_0)
			local var_723_0 = 0

			if var_723_0 < arg_720_1.time_ and arg_720_1.time_ <= var_723_0 + arg_723_0 then
				arg_720_1.var_.oldValueTypewriter = arg_720_1.fswtw_.percent

				SetActive(arg_720_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_720_1:ShowNextGo(false)
			end

			local var_723_1 = 13
			local var_723_2 = 0.866666666666667
			local var_723_3 = arg_720_1:GetWordFromCfg(1109402172)
			local var_723_4 = arg_720_1:FormatText(var_723_3.content)
			local var_723_5, var_723_6 = arg_720_1:GetPercentByPara(var_723_4, 3)

			if var_723_0 < arg_720_1.time_ and arg_720_1.time_ <= var_723_0 + arg_723_0 then
				arg_720_1.talkMaxDuration = 0

				local var_723_7 = var_723_1 <= 0 and var_723_2 or var_723_2 * ((var_723_6 - arg_720_1.typewritterCharCountI18N) / var_723_1)

				if var_723_7 > 0 and var_723_2 < var_723_7 then
					arg_720_1.talkMaxDuration = var_723_7

					if var_723_7 + var_723_0 > arg_720_1.duration_ then
						arg_720_1.duration_ = var_723_7 + var_723_0
					end
				end
			end

			local var_723_8 = 0.866666666666667
			local var_723_9 = math.max(var_723_8, arg_720_1.talkMaxDuration)

			if var_723_0 <= arg_720_1.time_ and arg_720_1.time_ < var_723_0 + var_723_9 then
				local var_723_10 = (arg_720_1.time_ - var_723_0) / var_723_9

				arg_720_1.fswtw_.percent = Mathf.Lerp(arg_720_1.var_.oldValueTypewriter, var_723_5, var_723_10)
				arg_720_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_720_1.fswtw_:SetDirty()
			end

			if arg_720_1.time_ >= var_723_0 + var_723_9 and arg_720_1.time_ < var_723_0 + var_723_9 + arg_723_0 then
				arg_720_1.fswtw_.percent = var_723_5

				arg_720_1.fswtw_:SetDirty()
				arg_720_1:ShowNextGo(true)

				arg_720_1.typewritterCharCountI18N = var_723_6
			end

			local var_723_11 = 0
			local var_723_12 = 2.7
			local var_723_13 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402174", "story_v_side_new_1109402.awb") / 1000

			if var_723_13 > 0 and var_723_12 < var_723_13 and var_723_13 + var_723_11 > arg_720_1.duration_ then
				local var_723_14 = var_723_13

				arg_720_1.duration_ = var_723_13 + var_723_11
			end

			if var_723_11 < arg_720_1.time_ and arg_720_1.time_ <= var_723_11 + arg_723_0 then
				local var_723_15 = "play"
				local var_723_16 = "voice"

				arg_720_1:AudioAction(var_723_15, var_723_16, "story_v_side_new_1109402", "1109402174", "story_v_side_new_1109402.awb")
			end
		end

		arg_720_1.nodeConfigList_ = {}

		arg_720_1:InitPlayNodeList()
	end,
	Play1109402175 = function(arg_724_0, arg_724_1)
		arg_724_1.time_ = 0
		arg_724_1.frameCnt_ = 0
		arg_724_1.state_ = "playing"
		arg_724_1.curTalkId_ = 1109402175
		arg_724_1.duration_ = 2.43

		SetActive(arg_724_1.tipsGo_, false)

		function arg_724_1.onSingleLineFinish_()
			arg_724_1.onSingleLineUpdate_ = nil
			arg_724_1.onSingleLineFinish_ = nil
			arg_724_1.state_ = "waiting"
		end

		function arg_724_1.playNext_(arg_726_0)
			if arg_726_0 == 1 then
				arg_724_0:Play1109402176(arg_724_1)
			end
		end

		function arg_724_1.onSingleLineUpdate_(arg_727_0)
			local var_727_0 = 0

			if var_727_0 < arg_724_1.time_ and arg_724_1.time_ <= var_727_0 + arg_727_0 then
				arg_724_1.var_.oldValueTypewriter = arg_724_1.fswtw_.percent

				SetActive(arg_724_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_724_1:ShowNextGo(false)
			end

			local var_727_1 = 10
			local var_727_2 = 0.666666666666667
			local var_727_3 = arg_724_1:GetWordFromCfg(1109402172)
			local var_727_4 = arg_724_1:FormatText(var_727_3.content)
			local var_727_5, var_727_6 = arg_724_1:GetPercentByPara(var_727_4, 4)

			if var_727_0 < arg_724_1.time_ and arg_724_1.time_ <= var_727_0 + arg_727_0 then
				arg_724_1.talkMaxDuration = 0

				local var_727_7 = var_727_1 <= 0 and var_727_2 or var_727_2 * ((var_727_6 - arg_724_1.typewritterCharCountI18N) / var_727_1)

				if var_727_7 > 0 and var_727_2 < var_727_7 then
					arg_724_1.talkMaxDuration = var_727_7

					if var_727_7 + var_727_0 > arg_724_1.duration_ then
						arg_724_1.duration_ = var_727_7 + var_727_0
					end
				end
			end

			local var_727_8 = 0.666666666666667
			local var_727_9 = math.max(var_727_8, arg_724_1.talkMaxDuration)

			if var_727_0 <= arg_724_1.time_ and arg_724_1.time_ < var_727_0 + var_727_9 then
				local var_727_10 = (arg_724_1.time_ - var_727_0) / var_727_9

				arg_724_1.fswtw_.percent = Mathf.Lerp(arg_724_1.var_.oldValueTypewriter, var_727_5, var_727_10)
				arg_724_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_724_1.fswtw_:SetDirty()
			end

			if arg_724_1.time_ >= var_727_0 + var_727_9 and arg_724_1.time_ < var_727_0 + var_727_9 + arg_727_0 then
				arg_724_1.fswtw_.percent = var_727_5

				arg_724_1.fswtw_:SetDirty()
				arg_724_1:ShowNextGo(true)

				arg_724_1.typewritterCharCountI18N = var_727_6
			end

			local var_727_11 = 0
			local var_727_12 = 2.433
			local var_727_13 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402175", "story_v_side_new_1109402.awb") / 1000

			if var_727_13 > 0 and var_727_12 < var_727_13 and var_727_13 + var_727_11 > arg_724_1.duration_ then
				local var_727_14 = var_727_13

				arg_724_1.duration_ = var_727_13 + var_727_11
			end

			if var_727_11 < arg_724_1.time_ and arg_724_1.time_ <= var_727_11 + arg_727_0 then
				local var_727_15 = "play"
				local var_727_16 = "voice"

				arg_724_1:AudioAction(var_727_15, var_727_16, "story_v_side_new_1109402", "1109402175", "story_v_side_new_1109402.awb")
			end
		end

		arg_724_1.nodeConfigList_ = {}

		arg_724_1:InitPlayNodeList()
	end,
	Play1109402176 = function(arg_728_0, arg_728_1)
		arg_728_1.time_ = 0
		arg_728_1.frameCnt_ = 0
		arg_728_1.state_ = "playing"
		arg_728_1.curTalkId_ = 1109402176
		arg_728_1.duration_ = 1.97

		SetActive(arg_728_1.tipsGo_, false)

		function arg_728_1.onSingleLineFinish_()
			arg_728_1.onSingleLineUpdate_ = nil
			arg_728_1.onSingleLineFinish_ = nil
			arg_728_1.state_ = "waiting"
		end

		function arg_728_1.playNext_(arg_730_0)
			if arg_730_0 == 1 then
				arg_728_0:Play1109402177(arg_728_1)
			end
		end

		function arg_728_1.onSingleLineUpdate_(arg_731_0)
			local var_731_0 = 0

			if var_731_0 < arg_728_1.time_ and arg_728_1.time_ <= var_731_0 + arg_731_0 then
				arg_728_1.var_.oldValueTypewriter = arg_728_1.fswtw_.percent

				SetActive(arg_728_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_728_1:ShowNextGo(false)
			end

			local var_731_1 = 6
			local var_731_2 = 0.4
			local var_731_3 = arg_728_1:GetWordFromCfg(1109402172)
			local var_731_4 = arg_728_1:FormatText(var_731_3.content)
			local var_731_5, var_731_6 = arg_728_1:GetPercentByPara(var_731_4, 5)

			if var_731_0 < arg_728_1.time_ and arg_728_1.time_ <= var_731_0 + arg_731_0 then
				arg_728_1.talkMaxDuration = 0

				local var_731_7 = var_731_1 <= 0 and var_731_2 or var_731_2 * ((var_731_6 - arg_728_1.typewritterCharCountI18N) / var_731_1)

				if var_731_7 > 0 and var_731_2 < var_731_7 then
					arg_728_1.talkMaxDuration = var_731_7

					if var_731_7 + var_731_0 > arg_728_1.duration_ then
						arg_728_1.duration_ = var_731_7 + var_731_0
					end
				end
			end

			local var_731_8 = 0.4
			local var_731_9 = math.max(var_731_8, arg_728_1.talkMaxDuration)

			if var_731_0 <= arg_728_1.time_ and arg_728_1.time_ < var_731_0 + var_731_9 then
				local var_731_10 = (arg_728_1.time_ - var_731_0) / var_731_9

				arg_728_1.fswtw_.percent = Mathf.Lerp(arg_728_1.var_.oldValueTypewriter, var_731_5, var_731_10)
				arg_728_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_728_1.fswtw_:SetDirty()
			end

			if arg_728_1.time_ >= var_731_0 + var_731_9 and arg_728_1.time_ < var_731_0 + var_731_9 + arg_731_0 then
				arg_728_1.fswtw_.percent = var_731_5

				arg_728_1.fswtw_:SetDirty()
				arg_728_1:ShowNextGo(true)

				arg_728_1.typewritterCharCountI18N = var_731_6
			end

			local var_731_11 = 0
			local var_731_12 = 1.966
			local var_731_13 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402176", "story_v_side_new_1109402.awb") / 1000

			if var_731_13 > 0 and var_731_12 < var_731_13 and var_731_13 + var_731_11 > arg_728_1.duration_ then
				local var_731_14 = var_731_13

				arg_728_1.duration_ = var_731_13 + var_731_11
			end

			if var_731_11 < arg_728_1.time_ and arg_728_1.time_ <= var_731_11 + arg_731_0 then
				local var_731_15 = "play"
				local var_731_16 = "voice"

				arg_728_1:AudioAction(var_731_15, var_731_16, "story_v_side_new_1109402", "1109402176", "story_v_side_new_1109402.awb")
			end
		end

		arg_728_1.nodeConfigList_ = {}

		arg_728_1:InitPlayNodeList()
	end,
	Play1109402177 = function(arg_732_0, arg_732_1)
		arg_732_1.time_ = 0
		arg_732_1.frameCnt_ = 0
		arg_732_1.state_ = "playing"
		arg_732_1.curTalkId_ = 1109402177
		arg_732_1.duration_ = 3.27

		SetActive(arg_732_1.tipsGo_, false)

		function arg_732_1.onSingleLineFinish_()
			arg_732_1.onSingleLineUpdate_ = nil
			arg_732_1.onSingleLineFinish_ = nil
			arg_732_1.state_ = "waiting"
		end

		function arg_732_1.playNext_(arg_734_0)
			if arg_734_0 == 1 then
				arg_732_0:Play1109402178(arg_732_1)
			end
		end

		function arg_732_1.onSingleLineUpdate_(arg_735_0)
			local var_735_0 = 0

			if var_735_0 < arg_732_1.time_ and arg_732_1.time_ <= var_735_0 + arg_735_0 then
				arg_732_1.var_.oldValueTypewriter = arg_732_1.fswtw_.percent

				SetActive(arg_732_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_732_1:ShowNextGo(false)
			end

			local var_735_1 = 11
			local var_735_2 = 0.733333333333333
			local var_735_3 = arg_732_1:GetWordFromCfg(1109402172)
			local var_735_4 = arg_732_1:FormatText(var_735_3.content)
			local var_735_5, var_735_6 = arg_732_1:GetPercentByPara(var_735_4, 6)

			if var_735_0 < arg_732_1.time_ and arg_732_1.time_ <= var_735_0 + arg_735_0 then
				arg_732_1.talkMaxDuration = 0

				local var_735_7 = var_735_1 <= 0 and var_735_2 or var_735_2 * ((var_735_6 - arg_732_1.typewritterCharCountI18N) / var_735_1)

				if var_735_7 > 0 and var_735_2 < var_735_7 then
					arg_732_1.talkMaxDuration = var_735_7

					if var_735_7 + var_735_0 > arg_732_1.duration_ then
						arg_732_1.duration_ = var_735_7 + var_735_0
					end
				end
			end

			local var_735_8 = 0.733333333333333
			local var_735_9 = math.max(var_735_8, arg_732_1.talkMaxDuration)

			if var_735_0 <= arg_732_1.time_ and arg_732_1.time_ < var_735_0 + var_735_9 then
				local var_735_10 = (arg_732_1.time_ - var_735_0) / var_735_9

				arg_732_1.fswtw_.percent = Mathf.Lerp(arg_732_1.var_.oldValueTypewriter, var_735_5, var_735_10)
				arg_732_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_732_1.fswtw_:SetDirty()
			end

			if arg_732_1.time_ >= var_735_0 + var_735_9 and arg_732_1.time_ < var_735_0 + var_735_9 + arg_735_0 then
				arg_732_1.fswtw_.percent = var_735_5

				arg_732_1.fswtw_:SetDirty()
				arg_732_1:ShowNextGo(true)

				arg_732_1.typewritterCharCountI18N = var_735_6
			end

			local var_735_11 = 0
			local var_735_12 = 3.266
			local var_735_13 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402177", "story_v_side_new_1109402.awb") / 1000

			if var_735_13 > 0 and var_735_12 < var_735_13 and var_735_13 + var_735_11 > arg_732_1.duration_ then
				local var_735_14 = var_735_13

				arg_732_1.duration_ = var_735_13 + var_735_11
			end

			if var_735_11 < arg_732_1.time_ and arg_732_1.time_ <= var_735_11 + arg_735_0 then
				local var_735_15 = "play"
				local var_735_16 = "voice"

				arg_732_1:AudioAction(var_735_15, var_735_16, "story_v_side_new_1109402", "1109402177", "story_v_side_new_1109402.awb")
			end
		end

		arg_732_1.nodeConfigList_ = {}

		arg_732_1:InitPlayNodeList()
	end,
	Play1109402178 = function(arg_736_0, arg_736_1)
		arg_736_1.time_ = 0
		arg_736_1.frameCnt_ = 0
		arg_736_1.state_ = "playing"
		arg_736_1.curTalkId_ = 1109402178
		arg_736_1.duration_ = 3.83

		SetActive(arg_736_1.tipsGo_, false)

		function arg_736_1.onSingleLineFinish_()
			arg_736_1.onSingleLineUpdate_ = nil
			arg_736_1.onSingleLineFinish_ = nil
			arg_736_1.state_ = "waiting"
		end

		function arg_736_1.playNext_(arg_738_0)
			if arg_738_0 == 1 then
				arg_736_0:Play1109402179(arg_736_1)
			end
		end

		function arg_736_1.onSingleLineUpdate_(arg_739_0)
			local var_739_0 = 0

			if var_739_0 < arg_736_1.time_ and arg_736_1.time_ <= var_739_0 + arg_739_0 then
				arg_736_1.fswbg_:SetActive(true)
				arg_736_1.dialog_:SetActive(false)

				arg_736_1.fswtw_.percent = 0

				local var_739_1 = arg_736_1:GetWordFromCfg(1109402178)
				local var_739_2 = arg_736_1:FormatText(var_739_1.content)

				arg_736_1.fswt_.text = var_739_2

				LuaForUtil.ClearLinePrefixSymbol(arg_736_1.fswt_)

				arg_736_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_736_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_736_1.fswtw_:SetDirty()

				arg_736_1.typewritterCharCountI18N = 0

				SetActive(arg_736_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_736_1:ShowNextGo(false)
			end

			local var_739_3 = 0.0166666666666667

			if var_739_3 < arg_736_1.time_ and arg_736_1.time_ <= var_739_3 + arg_739_0 then
				arg_736_1.var_.oldValueTypewriter = arg_736_1.fswtw_.percent

				SetActive(arg_736_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_736_1:ShowNextGo(false)
			end

			local var_739_4 = 12
			local var_739_5 = 0.8
			local var_739_6 = arg_736_1:GetWordFromCfg(1109402178)
			local var_739_7 = arg_736_1:FormatText(var_739_6.content)
			local var_739_8, var_739_9 = arg_736_1:GetPercentByPara(var_739_7, 1)

			if var_739_3 < arg_736_1.time_ and arg_736_1.time_ <= var_739_3 + arg_739_0 then
				arg_736_1.talkMaxDuration = 0

				local var_739_10 = var_739_4 <= 0 and var_739_5 or var_739_5 * ((var_739_9 - arg_736_1.typewritterCharCountI18N) / var_739_4)

				if var_739_10 > 0 and var_739_5 < var_739_10 then
					arg_736_1.talkMaxDuration = var_739_10

					if var_739_10 + var_739_3 > arg_736_1.duration_ then
						arg_736_1.duration_ = var_739_10 + var_739_3
					end
				end
			end

			local var_739_11 = 0.8
			local var_739_12 = math.max(var_739_11, arg_736_1.talkMaxDuration)

			if var_739_3 <= arg_736_1.time_ and arg_736_1.time_ < var_739_3 + var_739_12 then
				local var_739_13 = (arg_736_1.time_ - var_739_3) / var_739_12

				arg_736_1.fswtw_.percent = Mathf.Lerp(arg_736_1.var_.oldValueTypewriter, var_739_8, var_739_13)
				arg_736_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_736_1.fswtw_:SetDirty()
			end

			if arg_736_1.time_ >= var_739_3 + var_739_12 and arg_736_1.time_ < var_739_3 + var_739_12 + arg_739_0 then
				arg_736_1.fswtw_.percent = var_739_8

				arg_736_1.fswtw_:SetDirty()
				arg_736_1:ShowNextGo(true)

				arg_736_1.typewritterCharCountI18N = var_739_9
			end

			local var_739_14 = 0
			local var_739_15 = 3.833
			local var_739_16 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402178", "story_v_side_new_1109402.awb") / 1000

			if var_739_16 > 0 and var_739_15 < var_739_16 and var_739_16 + var_739_14 > arg_736_1.duration_ then
				local var_739_17 = var_739_16

				arg_736_1.duration_ = var_739_16 + var_739_14
			end

			if var_739_14 < arg_736_1.time_ and arg_736_1.time_ <= var_739_14 + arg_739_0 then
				local var_739_18 = "play"
				local var_739_19 = "voice"

				arg_736_1:AudioAction(var_739_18, var_739_19, "story_v_side_new_1109402", "1109402178", "story_v_side_new_1109402.awb")
			end
		end

		arg_736_1.nodeConfigList_ = {}

		arg_736_1:InitPlayNodeList()
	end,
	Play1109402179 = function(arg_740_0, arg_740_1)
		arg_740_1.time_ = 0
		arg_740_1.frameCnt_ = 0
		arg_740_1.state_ = "playing"
		arg_740_1.curTalkId_ = 1109402179
		arg_740_1.duration_ = 1.47

		SetActive(arg_740_1.tipsGo_, false)

		function arg_740_1.onSingleLineFinish_()
			arg_740_1.onSingleLineUpdate_ = nil
			arg_740_1.onSingleLineFinish_ = nil
			arg_740_1.state_ = "waiting"
		end

		function arg_740_1.playNext_(arg_742_0)
			if arg_742_0 == 1 then
				arg_740_0:Play1109402180(arg_740_1)
			end
		end

		function arg_740_1.onSingleLineUpdate_(arg_743_0)
			local var_743_0 = 0

			if var_743_0 < arg_740_1.time_ and arg_740_1.time_ <= var_743_0 + arg_743_0 then
				arg_740_1.var_.oldValueTypewriter = arg_740_1.fswtw_.percent

				SetActive(arg_740_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_740_1:ShowNextGo(false)
			end

			local var_743_1 = 22
			local var_743_2 = 1.46666666666667
			local var_743_3 = arg_740_1:GetWordFromCfg(1109402178)
			local var_743_4 = arg_740_1:FormatText(var_743_3.content)
			local var_743_5, var_743_6 = arg_740_1:GetPercentByPara(var_743_4, 2)

			if var_743_0 < arg_740_1.time_ and arg_740_1.time_ <= var_743_0 + arg_743_0 then
				arg_740_1.talkMaxDuration = 0

				local var_743_7 = var_743_1 <= 0 and var_743_2 or var_743_2 * ((var_743_6 - arg_740_1.typewritterCharCountI18N) / var_743_1)

				if var_743_7 > 0 and var_743_2 < var_743_7 then
					arg_740_1.talkMaxDuration = var_743_7

					if var_743_7 + var_743_0 > arg_740_1.duration_ then
						arg_740_1.duration_ = var_743_7 + var_743_0
					end
				end
			end

			local var_743_8 = 1.46666666666667
			local var_743_9 = math.max(var_743_8, arg_740_1.talkMaxDuration)

			if var_743_0 <= arg_740_1.time_ and arg_740_1.time_ < var_743_0 + var_743_9 then
				local var_743_10 = (arg_740_1.time_ - var_743_0) / var_743_9

				arg_740_1.fswtw_.percent = Mathf.Lerp(arg_740_1.var_.oldValueTypewriter, var_743_5, var_743_10)
				arg_740_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_740_1.fswtw_:SetDirty()
			end

			if arg_740_1.time_ >= var_743_0 + var_743_9 and arg_740_1.time_ < var_743_0 + var_743_9 + arg_743_0 then
				arg_740_1.fswtw_.percent = var_743_5

				arg_740_1.fswtw_:SetDirty()
				arg_740_1:ShowNextGo(true)

				arg_740_1.typewritterCharCountI18N = var_743_6
			end
		end

		arg_740_1.nodeConfigList_ = {}

		arg_740_1:InitPlayNodeList()
	end,
	Play1109402180 = function(arg_744_0, arg_744_1)
		arg_744_1.time_ = 0
		arg_744_1.frameCnt_ = 0
		arg_744_1.state_ = "playing"
		arg_744_1.curTalkId_ = 1109402180
		arg_744_1.duration_ = 4.4

		SetActive(arg_744_1.tipsGo_, false)

		function arg_744_1.onSingleLineFinish_()
			arg_744_1.onSingleLineUpdate_ = nil
			arg_744_1.onSingleLineFinish_ = nil
			arg_744_1.state_ = "waiting"
		end

		function arg_744_1.playNext_(arg_746_0)
			if arg_746_0 == 1 then
				arg_744_0:Play1109402181(arg_744_1)
			end
		end

		function arg_744_1.onSingleLineUpdate_(arg_747_0)
			local var_747_0 = 0

			if var_747_0 < arg_744_1.time_ and arg_744_1.time_ <= var_747_0 + arg_747_0 then
				arg_744_1.var_.oldValueTypewriter = arg_744_1.fswtw_.percent

				SetActive(arg_744_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_744_1:ShowNextGo(false)
			end

			local var_747_1 = 18
			local var_747_2 = 1.2
			local var_747_3 = arg_744_1:GetWordFromCfg(1109402178)
			local var_747_4 = arg_744_1:FormatText(var_747_3.content)
			local var_747_5, var_747_6 = arg_744_1:GetPercentByPara(var_747_4, 3)

			if var_747_0 < arg_744_1.time_ and arg_744_1.time_ <= var_747_0 + arg_747_0 then
				arg_744_1.talkMaxDuration = 0

				local var_747_7 = var_747_1 <= 0 and var_747_2 or var_747_2 * ((var_747_6 - arg_744_1.typewritterCharCountI18N) / var_747_1)

				if var_747_7 > 0 and var_747_2 < var_747_7 then
					arg_744_1.talkMaxDuration = var_747_7

					if var_747_7 + var_747_0 > arg_744_1.duration_ then
						arg_744_1.duration_ = var_747_7 + var_747_0
					end
				end
			end

			local var_747_8 = 1.2
			local var_747_9 = math.max(var_747_8, arg_744_1.talkMaxDuration)

			if var_747_0 <= arg_744_1.time_ and arg_744_1.time_ < var_747_0 + var_747_9 then
				local var_747_10 = (arg_744_1.time_ - var_747_0) / var_747_9

				arg_744_1.fswtw_.percent = Mathf.Lerp(arg_744_1.var_.oldValueTypewriter, var_747_5, var_747_10)
				arg_744_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_744_1.fswtw_:SetDirty()
			end

			if arg_744_1.time_ >= var_747_0 + var_747_9 and arg_744_1.time_ < var_747_0 + var_747_9 + arg_747_0 then
				arg_744_1.fswtw_.percent = var_747_5

				arg_744_1.fswtw_:SetDirty()
				arg_744_1:ShowNextGo(true)

				arg_744_1.typewritterCharCountI18N = var_747_6
			end

			local var_747_11 = 0
			local var_747_12 = 4.4
			local var_747_13 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402180", "story_v_side_new_1109402.awb") / 1000

			if var_747_13 > 0 and var_747_12 < var_747_13 and var_747_13 + var_747_11 > arg_744_1.duration_ then
				local var_747_14 = var_747_13

				arg_744_1.duration_ = var_747_13 + var_747_11
			end

			if var_747_11 < arg_744_1.time_ and arg_744_1.time_ <= var_747_11 + arg_747_0 then
				local var_747_15 = "play"
				local var_747_16 = "voice"

				arg_744_1:AudioAction(var_747_15, var_747_16, "story_v_side_new_1109402", "1109402180", "story_v_side_new_1109402.awb")
			end
		end

		arg_744_1.nodeConfigList_ = {}

		arg_744_1:InitPlayNodeList()
	end,
	Play1109402181 = function(arg_748_0, arg_748_1)
		arg_748_1.time_ = 0
		arg_748_1.frameCnt_ = 0
		arg_748_1.state_ = "playing"
		arg_748_1.curTalkId_ = 1109402181
		arg_748_1.duration_ = 1

		SetActive(arg_748_1.tipsGo_, false)

		function arg_748_1.onSingleLineFinish_()
			arg_748_1.onSingleLineUpdate_ = nil
			arg_748_1.onSingleLineFinish_ = nil
			arg_748_1.state_ = "waiting"
		end

		function arg_748_1.playNext_(arg_750_0)
			if arg_750_0 == 1 then
				arg_748_0:Play1109402182(arg_748_1)
			end
		end

		function arg_748_1.onSingleLineUpdate_(arg_751_0)
			local var_751_0 = 0

			if var_751_0 < arg_748_1.time_ and arg_748_1.time_ <= var_751_0 + arg_751_0 then
				arg_748_1.var_.oldValueTypewriter = arg_748_1.fswtw_.percent

				SetActive(arg_748_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_748_1:ShowNextGo(false)
			end

			local var_751_1 = 11
			local var_751_2 = 0.733333333333333
			local var_751_3 = arg_748_1:GetWordFromCfg(1109402178)
			local var_751_4 = arg_748_1:FormatText(var_751_3.content)
			local var_751_5, var_751_6 = arg_748_1:GetPercentByPara(var_751_4, 4)

			if var_751_0 < arg_748_1.time_ and arg_748_1.time_ <= var_751_0 + arg_751_0 then
				arg_748_1.talkMaxDuration = 0

				local var_751_7 = var_751_1 <= 0 and var_751_2 or var_751_2 * ((var_751_6 - arg_748_1.typewritterCharCountI18N) / var_751_1)

				if var_751_7 > 0 and var_751_2 < var_751_7 then
					arg_748_1.talkMaxDuration = var_751_7

					if var_751_7 + var_751_0 > arg_748_1.duration_ then
						arg_748_1.duration_ = var_751_7 + var_751_0
					end
				end
			end

			local var_751_8 = 0.733333333333333
			local var_751_9 = math.max(var_751_8, arg_748_1.talkMaxDuration)

			if var_751_0 <= arg_748_1.time_ and arg_748_1.time_ < var_751_0 + var_751_9 then
				local var_751_10 = (arg_748_1.time_ - var_751_0) / var_751_9

				arg_748_1.fswtw_.percent = Mathf.Lerp(arg_748_1.var_.oldValueTypewriter, var_751_5, var_751_10)
				arg_748_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_748_1.fswtw_:SetDirty()
			end

			if arg_748_1.time_ >= var_751_0 + var_751_9 and arg_748_1.time_ < var_751_0 + var_751_9 + arg_751_0 then
				arg_748_1.fswtw_.percent = var_751_5

				arg_748_1.fswtw_:SetDirty()
				arg_748_1:ShowNextGo(true)

				arg_748_1.typewritterCharCountI18N = var_751_6
			end
		end

		arg_748_1.nodeConfigList_ = {}

		arg_748_1:InitPlayNodeList()
	end,
	Play1109402182 = function(arg_752_0, arg_752_1)
		arg_752_1.time_ = 0
		arg_752_1.frameCnt_ = 0
		arg_752_1.state_ = "playing"
		arg_752_1.curTalkId_ = 1109402182
		arg_752_1.duration_ = 6.07

		SetActive(arg_752_1.tipsGo_, false)

		function arg_752_1.onSingleLineFinish_()
			arg_752_1.onSingleLineUpdate_ = nil
			arg_752_1.onSingleLineFinish_ = nil
			arg_752_1.state_ = "waiting"
		end

		function arg_752_1.playNext_(arg_754_0)
			if arg_754_0 == 1 then
				arg_752_0:Play1109402183(arg_752_1)
			end
		end

		function arg_752_1.onSingleLineUpdate_(arg_755_0)
			local var_755_0 = 0

			if var_755_0 < arg_752_1.time_ and arg_752_1.time_ <= var_755_0 + arg_755_0 then
				arg_752_1.var_.oldValueTypewriter = arg_752_1.fswtw_.percent

				SetActive(arg_752_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_752_1:ShowNextGo(false)
			end

			local var_755_1 = 27
			local var_755_2 = 1.8
			local var_755_3 = arg_752_1:GetWordFromCfg(1109402178)
			local var_755_4 = arg_752_1:FormatText(var_755_3.content)
			local var_755_5, var_755_6 = arg_752_1:GetPercentByPara(var_755_4, 5)

			if var_755_0 < arg_752_1.time_ and arg_752_1.time_ <= var_755_0 + arg_755_0 then
				arg_752_1.talkMaxDuration = 0

				local var_755_7 = var_755_1 <= 0 and var_755_2 or var_755_2 * ((var_755_6 - arg_752_1.typewritterCharCountI18N) / var_755_1)

				if var_755_7 > 0 and var_755_2 < var_755_7 then
					arg_752_1.talkMaxDuration = var_755_7

					if var_755_7 + var_755_0 > arg_752_1.duration_ then
						arg_752_1.duration_ = var_755_7 + var_755_0
					end
				end
			end

			local var_755_8 = 1.8
			local var_755_9 = math.max(var_755_8, arg_752_1.talkMaxDuration)

			if var_755_0 <= arg_752_1.time_ and arg_752_1.time_ < var_755_0 + var_755_9 then
				local var_755_10 = (arg_752_1.time_ - var_755_0) / var_755_9

				arg_752_1.fswtw_.percent = Mathf.Lerp(arg_752_1.var_.oldValueTypewriter, var_755_5, var_755_10)
				arg_752_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_752_1.fswtw_:SetDirty()
			end

			if arg_752_1.time_ >= var_755_0 + var_755_9 and arg_752_1.time_ < var_755_0 + var_755_9 + arg_755_0 then
				arg_752_1.fswtw_.percent = var_755_5

				arg_752_1.fswtw_:SetDirty()
				arg_752_1:ShowNextGo(true)

				arg_752_1.typewritterCharCountI18N = var_755_6
			end

			local var_755_11 = 0
			local var_755_12 = 6.066
			local var_755_13 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402182", "story_v_side_new_1109402.awb") / 1000

			if var_755_13 > 0 and var_755_12 < var_755_13 and var_755_13 + var_755_11 > arg_752_1.duration_ then
				local var_755_14 = var_755_13

				arg_752_1.duration_ = var_755_13 + var_755_11
			end

			if var_755_11 < arg_752_1.time_ and arg_752_1.time_ <= var_755_11 + arg_755_0 then
				local var_755_15 = "play"
				local var_755_16 = "voice"

				arg_752_1:AudioAction(var_755_15, var_755_16, "story_v_side_new_1109402", "1109402182", "story_v_side_new_1109402.awb")
			end
		end

		arg_752_1.nodeConfigList_ = {}

		arg_752_1:InitPlayNodeList()
	end,
	Play1109402183 = function(arg_756_0, arg_756_1)
		arg_756_1.time_ = 0
		arg_756_1.frameCnt_ = 0
		arg_756_1.state_ = "playing"
		arg_756_1.curTalkId_ = 1109402183
		arg_756_1.duration_ = 1.43

		SetActive(arg_756_1.tipsGo_, false)

		function arg_756_1.onSingleLineFinish_()
			arg_756_1.onSingleLineUpdate_ = nil
			arg_756_1.onSingleLineFinish_ = nil
			arg_756_1.state_ = "waiting"
		end

		function arg_756_1.playNext_(arg_758_0)
			if arg_758_0 == 1 then
				arg_756_0:Play1109402184(arg_756_1)
			end
		end

		function arg_756_1.onSingleLineUpdate_(arg_759_0)
			local var_759_0 = 0

			if var_759_0 < arg_756_1.time_ and arg_756_1.time_ <= var_759_0 + arg_759_0 then
				arg_756_1.var_.oldValueTypewriter = arg_756_1.fswtw_.percent

				SetActive(arg_756_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_756_1:ShowNextGo(false)
			end

			local var_759_1 = 5
			local var_759_2 = 0.333333333333333
			local var_759_3 = arg_756_1:GetWordFromCfg(1109402178)
			local var_759_4 = arg_756_1:FormatText(var_759_3.content)
			local var_759_5, var_759_6 = arg_756_1:GetPercentByPara(var_759_4, 6)

			if var_759_0 < arg_756_1.time_ and arg_756_1.time_ <= var_759_0 + arg_759_0 then
				arg_756_1.talkMaxDuration = 0

				local var_759_7 = var_759_1 <= 0 and var_759_2 or var_759_2 * ((var_759_6 - arg_756_1.typewritterCharCountI18N) / var_759_1)

				if var_759_7 > 0 and var_759_2 < var_759_7 then
					arg_756_1.talkMaxDuration = var_759_7

					if var_759_7 + var_759_0 > arg_756_1.duration_ then
						arg_756_1.duration_ = var_759_7 + var_759_0
					end
				end
			end

			local var_759_8 = 0.333333333333333
			local var_759_9 = math.max(var_759_8, arg_756_1.talkMaxDuration)

			if var_759_0 <= arg_756_1.time_ and arg_756_1.time_ < var_759_0 + var_759_9 then
				local var_759_10 = (arg_756_1.time_ - var_759_0) / var_759_9

				arg_756_1.fswtw_.percent = Mathf.Lerp(arg_756_1.var_.oldValueTypewriter, var_759_5, var_759_10)
				arg_756_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_756_1.fswtw_:SetDirty()
			end

			if arg_756_1.time_ >= var_759_0 + var_759_9 and arg_756_1.time_ < var_759_0 + var_759_9 + arg_759_0 then
				arg_756_1.fswtw_.percent = var_759_5

				arg_756_1.fswtw_:SetDirty()
				arg_756_1:ShowNextGo(true)

				arg_756_1.typewritterCharCountI18N = var_759_6
			end

			local var_759_11 = 0
			local var_759_12 = 1.433
			local var_759_13 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402183", "story_v_side_new_1109402.awb") / 1000

			if var_759_13 > 0 and var_759_12 < var_759_13 and var_759_13 + var_759_11 > arg_756_1.duration_ then
				local var_759_14 = var_759_13

				arg_756_1.duration_ = var_759_13 + var_759_11
			end

			if var_759_11 < arg_756_1.time_ and arg_756_1.time_ <= var_759_11 + arg_759_0 then
				local var_759_15 = "play"
				local var_759_16 = "voice"

				arg_756_1:AudioAction(var_759_15, var_759_16, "story_v_side_new_1109402", "1109402183", "story_v_side_new_1109402.awb")
			end
		end

		arg_756_1.nodeConfigList_ = {}

		arg_756_1:InitPlayNodeList()
	end,
	Play1109402184 = function(arg_760_0, arg_760_1)
		arg_760_1.time_ = 0
		arg_760_1.frameCnt_ = 0
		arg_760_1.state_ = "playing"
		arg_760_1.curTalkId_ = 1109402184
		arg_760_1.duration_ = 1.95

		SetActive(arg_760_1.tipsGo_, false)

		function arg_760_1.onSingleLineFinish_()
			arg_760_1.onSingleLineUpdate_ = nil
			arg_760_1.onSingleLineFinish_ = nil
			arg_760_1.state_ = "waiting"
		end

		function arg_760_1.playNext_(arg_762_0)
			if arg_762_0 == 1 then
				arg_760_0:Play1109402185(arg_760_1)
			end
		end

		function arg_760_1.onSingleLineUpdate_(arg_763_0)
			local var_763_0 = 0

			if var_763_0 < arg_760_1.time_ and arg_760_1.time_ <= var_763_0 + arg_763_0 then
				arg_760_1.fswbg_:SetActive(true)
				arg_760_1.dialog_:SetActive(false)

				arg_760_1.fswtw_.percent = 0

				local var_763_1 = arg_760_1:GetWordFromCfg(1109402184)
				local var_763_2 = arg_760_1:FormatText(var_763_1.content)

				arg_760_1.fswt_.text = var_763_2

				LuaForUtil.ClearLinePrefixSymbol(arg_760_1.fswt_)

				arg_760_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_760_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_760_1.fswtw_:SetDirty()

				arg_760_1.typewritterCharCountI18N = 0

				SetActive(arg_760_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_760_1:ShowNextGo(false)
			end

			local var_763_3 = 0.0166666666666667

			if var_763_3 < arg_760_1.time_ and arg_760_1.time_ <= var_763_3 + arg_763_0 then
				arg_760_1.var_.oldValueTypewriter = arg_760_1.fswtw_.percent

				SetActive(arg_760_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_760_1:ShowNextGo(false)
			end

			local var_763_4 = 29
			local var_763_5 = 1.93333333333333
			local var_763_6 = arg_760_1:GetWordFromCfg(1109402184)
			local var_763_7 = arg_760_1:FormatText(var_763_6.content)
			local var_763_8, var_763_9 = arg_760_1:GetPercentByPara(var_763_7, 1)

			if var_763_3 < arg_760_1.time_ and arg_760_1.time_ <= var_763_3 + arg_763_0 then
				arg_760_1.talkMaxDuration = 0

				local var_763_10 = var_763_4 <= 0 and var_763_5 or var_763_5 * ((var_763_9 - arg_760_1.typewritterCharCountI18N) / var_763_4)

				if var_763_10 > 0 and var_763_5 < var_763_10 then
					arg_760_1.talkMaxDuration = var_763_10

					if var_763_10 + var_763_3 > arg_760_1.duration_ then
						arg_760_1.duration_ = var_763_10 + var_763_3
					end
				end
			end

			local var_763_11 = 1.93333333333333
			local var_763_12 = math.max(var_763_11, arg_760_1.talkMaxDuration)

			if var_763_3 <= arg_760_1.time_ and arg_760_1.time_ < var_763_3 + var_763_12 then
				local var_763_13 = (arg_760_1.time_ - var_763_3) / var_763_12

				arg_760_1.fswtw_.percent = Mathf.Lerp(arg_760_1.var_.oldValueTypewriter, var_763_8, var_763_13)
				arg_760_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_760_1.fswtw_:SetDirty()
			end

			if arg_760_1.time_ >= var_763_3 + var_763_12 and arg_760_1.time_ < var_763_3 + var_763_12 + arg_763_0 then
				arg_760_1.fswtw_.percent = var_763_8

				arg_760_1.fswtw_:SetDirty()
				arg_760_1:ShowNextGo(true)

				arg_760_1.typewritterCharCountI18N = var_763_9
			end
		end

		arg_760_1.nodeConfigList_ = {}

		arg_760_1:InitPlayNodeList()
	end,
	Play1109402185 = function(arg_764_0, arg_764_1)
		arg_764_1.time_ = 0
		arg_764_1.frameCnt_ = 0
		arg_764_1.state_ = "playing"
		arg_764_1.curTalkId_ = 1109402185
		arg_764_1.duration_ = 9.3

		SetActive(arg_764_1.tipsGo_, false)

		function arg_764_1.onSingleLineFinish_()
			arg_764_1.onSingleLineUpdate_ = nil
			arg_764_1.onSingleLineFinish_ = nil
			arg_764_1.state_ = "waiting"
		end

		function arg_764_1.playNext_(arg_766_0)
			if arg_766_0 == 1 then
				arg_764_0:Play1109402186(arg_764_1)
			end
		end

		function arg_764_1.onSingleLineUpdate_(arg_767_0)
			local var_767_0 = 0

			if var_767_0 < arg_764_1.time_ and arg_764_1.time_ <= var_767_0 + arg_767_0 then
				arg_764_1.var_.oldValueTypewriter = arg_764_1.fswtw_.percent

				SetActive(arg_764_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_764_1:ShowNextGo(false)
			end

			local var_767_1 = 43
			local var_767_2 = 2.86666666666667
			local var_767_3 = arg_764_1:GetWordFromCfg(1109402184)
			local var_767_4 = arg_764_1:FormatText(var_767_3.content)
			local var_767_5, var_767_6 = arg_764_1:GetPercentByPara(var_767_4, 2)

			if var_767_0 < arg_764_1.time_ and arg_764_1.time_ <= var_767_0 + arg_767_0 then
				arg_764_1.talkMaxDuration = 0

				local var_767_7 = var_767_1 <= 0 and var_767_2 or var_767_2 * ((var_767_6 - arg_764_1.typewritterCharCountI18N) / var_767_1)

				if var_767_7 > 0 and var_767_2 < var_767_7 then
					arg_764_1.talkMaxDuration = var_767_7

					if var_767_7 + var_767_0 > arg_764_1.duration_ then
						arg_764_1.duration_ = var_767_7 + var_767_0
					end
				end
			end

			local var_767_8 = 2.86666666666667
			local var_767_9 = math.max(var_767_8, arg_764_1.talkMaxDuration)

			if var_767_0 <= arg_764_1.time_ and arg_764_1.time_ < var_767_0 + var_767_9 then
				local var_767_10 = (arg_764_1.time_ - var_767_0) / var_767_9

				arg_764_1.fswtw_.percent = Mathf.Lerp(arg_764_1.var_.oldValueTypewriter, var_767_5, var_767_10)
				arg_764_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_764_1.fswtw_:SetDirty()
			end

			if arg_764_1.time_ >= var_767_0 + var_767_9 and arg_764_1.time_ < var_767_0 + var_767_9 + arg_767_0 then
				arg_764_1.fswtw_.percent = var_767_5

				arg_764_1.fswtw_:SetDirty()
				arg_764_1:ShowNextGo(true)

				arg_764_1.typewritterCharCountI18N = var_767_6
			end

			local var_767_11 = 0
			local var_767_12 = 9.3
			local var_767_13 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402185", "story_v_side_new_1109402.awb") / 1000

			if var_767_13 > 0 and var_767_12 < var_767_13 and var_767_13 + var_767_11 > arg_764_1.duration_ then
				local var_767_14 = var_767_13

				arg_764_1.duration_ = var_767_13 + var_767_11
			end

			if var_767_11 < arg_764_1.time_ and arg_764_1.time_ <= var_767_11 + arg_767_0 then
				local var_767_15 = "play"
				local var_767_16 = "voice"

				arg_764_1:AudioAction(var_767_15, var_767_16, "story_v_side_new_1109402", "1109402185", "story_v_side_new_1109402.awb")
			end
		end

		arg_764_1.nodeConfigList_ = {}

		arg_764_1:InitPlayNodeList()
	end,
	Play1109402186 = function(arg_768_0, arg_768_1)
		arg_768_1.time_ = 0
		arg_768_1.frameCnt_ = 0
		arg_768_1.state_ = "playing"
		arg_768_1.curTalkId_ = 1109402186
		arg_768_1.duration_ = 1.13

		SetActive(arg_768_1.tipsGo_, false)

		function arg_768_1.onSingleLineFinish_()
			arg_768_1.onSingleLineUpdate_ = nil
			arg_768_1.onSingleLineFinish_ = nil
			arg_768_1.state_ = "waiting"
		end

		function arg_768_1.playNext_(arg_770_0)
			if arg_770_0 == 1 then
				arg_768_0:Play1109402187(arg_768_1)
			end
		end

		function arg_768_1.onSingleLineUpdate_(arg_771_0)
			local var_771_0 = 0

			if var_771_0 < arg_768_1.time_ and arg_768_1.time_ <= var_771_0 + arg_771_0 then
				arg_768_1.var_.oldValueTypewriter = arg_768_1.fswtw_.percent

				SetActive(arg_768_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_768_1:ShowNextGo(false)
			end

			local var_771_1 = 7
			local var_771_2 = 0.466666666666667
			local var_771_3 = arg_768_1:GetWordFromCfg(1109402184)
			local var_771_4 = arg_768_1:FormatText(var_771_3.content)
			local var_771_5, var_771_6 = arg_768_1:GetPercentByPara(var_771_4, 3)

			if var_771_0 < arg_768_1.time_ and arg_768_1.time_ <= var_771_0 + arg_771_0 then
				arg_768_1.talkMaxDuration = 0

				local var_771_7 = var_771_1 <= 0 and var_771_2 or var_771_2 * ((var_771_6 - arg_768_1.typewritterCharCountI18N) / var_771_1)

				if var_771_7 > 0 and var_771_2 < var_771_7 then
					arg_768_1.talkMaxDuration = var_771_7

					if var_771_7 + var_771_0 > arg_768_1.duration_ then
						arg_768_1.duration_ = var_771_7 + var_771_0
					end
				end
			end

			local var_771_8 = 0.466666666666667
			local var_771_9 = math.max(var_771_8, arg_768_1.talkMaxDuration)

			if var_771_0 <= arg_768_1.time_ and arg_768_1.time_ < var_771_0 + var_771_9 then
				local var_771_10 = (arg_768_1.time_ - var_771_0) / var_771_9

				arg_768_1.fswtw_.percent = Mathf.Lerp(arg_768_1.var_.oldValueTypewriter, var_771_5, var_771_10)
				arg_768_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_768_1.fswtw_:SetDirty()
			end

			if arg_768_1.time_ >= var_771_0 + var_771_9 and arg_768_1.time_ < var_771_0 + var_771_9 + arg_771_0 then
				arg_768_1.fswtw_.percent = var_771_5

				arg_768_1.fswtw_:SetDirty()
				arg_768_1:ShowNextGo(true)

				arg_768_1.typewritterCharCountI18N = var_771_6
			end

			local var_771_11 = 0
			local var_771_12 = 1.133
			local var_771_13 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402186", "story_v_side_new_1109402.awb") / 1000

			if var_771_13 > 0 and var_771_12 < var_771_13 and var_771_13 + var_771_11 > arg_768_1.duration_ then
				local var_771_14 = var_771_13

				arg_768_1.duration_ = var_771_13 + var_771_11
			end

			if var_771_11 < arg_768_1.time_ and arg_768_1.time_ <= var_771_11 + arg_771_0 then
				local var_771_15 = "play"
				local var_771_16 = "voice"

				arg_768_1:AudioAction(var_771_15, var_771_16, "story_v_side_new_1109402", "1109402186", "story_v_side_new_1109402.awb")
			end
		end

		arg_768_1.nodeConfigList_ = {}

		arg_768_1:InitPlayNodeList()
	end,
	Play1109402187 = function(arg_772_0, arg_772_1)
		arg_772_1.time_ = 0
		arg_772_1.frameCnt_ = 0
		arg_772_1.state_ = "playing"
		arg_772_1.curTalkId_ = 1109402187
		arg_772_1.duration_ = 7.9

		SetActive(arg_772_1.tipsGo_, false)

		function arg_772_1.onSingleLineFinish_()
			arg_772_1.onSingleLineUpdate_ = nil
			arg_772_1.onSingleLineFinish_ = nil
			arg_772_1.state_ = "waiting"
		end

		function arg_772_1.playNext_(arg_774_0)
			if arg_774_0 == 1 then
				arg_772_0:Play1109402188(arg_772_1)
			end
		end

		function arg_772_1.onSingleLineUpdate_(arg_775_0)
			local var_775_0 = 0

			if var_775_0 < arg_772_1.time_ and arg_772_1.time_ <= var_775_0 + arg_775_0 then
				arg_772_1.var_.oldValueTypewriter = arg_772_1.fswtw_.percent

				SetActive(arg_772_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_772_1:ShowNextGo(false)
			end

			local var_775_1 = 38
			local var_775_2 = 2.53333333333333
			local var_775_3 = arg_772_1:GetWordFromCfg(1109402184)
			local var_775_4 = arg_772_1:FormatText(var_775_3.content)
			local var_775_5, var_775_6 = arg_772_1:GetPercentByPara(var_775_4, 4)

			if var_775_0 < arg_772_1.time_ and arg_772_1.time_ <= var_775_0 + arg_775_0 then
				arg_772_1.talkMaxDuration = 0

				local var_775_7 = var_775_1 <= 0 and var_775_2 or var_775_2 * ((var_775_6 - arg_772_1.typewritterCharCountI18N) / var_775_1)

				if var_775_7 > 0 and var_775_2 < var_775_7 then
					arg_772_1.talkMaxDuration = var_775_7

					if var_775_7 + var_775_0 > arg_772_1.duration_ then
						arg_772_1.duration_ = var_775_7 + var_775_0
					end
				end
			end

			local var_775_8 = 2.53333333333333
			local var_775_9 = math.max(var_775_8, arg_772_1.talkMaxDuration)

			if var_775_0 <= arg_772_1.time_ and arg_772_1.time_ < var_775_0 + var_775_9 then
				local var_775_10 = (arg_772_1.time_ - var_775_0) / var_775_9

				arg_772_1.fswtw_.percent = Mathf.Lerp(arg_772_1.var_.oldValueTypewriter, var_775_5, var_775_10)
				arg_772_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_772_1.fswtw_:SetDirty()
			end

			if arg_772_1.time_ >= var_775_0 + var_775_9 and arg_772_1.time_ < var_775_0 + var_775_9 + arg_775_0 then
				arg_772_1.fswtw_.percent = var_775_5

				arg_772_1.fswtw_:SetDirty()
				arg_772_1:ShowNextGo(true)

				arg_772_1.typewritterCharCountI18N = var_775_6
			end

			local var_775_11 = 0
			local var_775_12 = 7.9
			local var_775_13 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402187", "story_v_side_new_1109402.awb") / 1000

			if var_775_13 > 0 and var_775_12 < var_775_13 and var_775_13 + var_775_11 > arg_772_1.duration_ then
				local var_775_14 = var_775_13

				arg_772_1.duration_ = var_775_13 + var_775_11
			end

			if var_775_11 < arg_772_1.time_ and arg_772_1.time_ <= var_775_11 + arg_775_0 then
				local var_775_15 = "play"
				local var_775_16 = "voice"

				arg_772_1:AudioAction(var_775_15, var_775_16, "story_v_side_new_1109402", "1109402187", "story_v_side_new_1109402.awb")
			end
		end

		arg_772_1.nodeConfigList_ = {}

		arg_772_1:InitPlayNodeList()
	end,
	Play1109402188 = function(arg_776_0, arg_776_1)
		arg_776_1.time_ = 0
		arg_776_1.frameCnt_ = 0
		arg_776_1.state_ = "playing"
		arg_776_1.curTalkId_ = 1109402188
		arg_776_1.duration_ = 0.67

		SetActive(arg_776_1.tipsGo_, false)

		function arg_776_1.onSingleLineFinish_()
			arg_776_1.onSingleLineUpdate_ = nil
			arg_776_1.onSingleLineFinish_ = nil
			arg_776_1.state_ = "waiting"
		end

		function arg_776_1.playNext_(arg_778_0)
			if arg_778_0 == 1 then
				arg_776_0:Play1109402189(arg_776_1)
			end
		end

		function arg_776_1.onSingleLineUpdate_(arg_779_0)
			local var_779_0 = 0

			if var_779_0 < arg_776_1.time_ and arg_776_1.time_ <= var_779_0 + arg_779_0 then
				arg_776_1.var_.oldValueTypewriter = arg_776_1.fswtw_.percent

				SetActive(arg_776_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_776_1:ShowNextGo(false)
			end

			local var_779_1 = 10
			local var_779_2 = 0.666666666666667
			local var_779_3 = arg_776_1:GetWordFromCfg(1109402184)
			local var_779_4 = arg_776_1:FormatText(var_779_3.content)
			local var_779_5, var_779_6 = arg_776_1:GetPercentByPara(var_779_4, 5)

			if var_779_0 < arg_776_1.time_ and arg_776_1.time_ <= var_779_0 + arg_779_0 then
				arg_776_1.talkMaxDuration = 0

				local var_779_7 = var_779_1 <= 0 and var_779_2 or var_779_2 * ((var_779_6 - arg_776_1.typewritterCharCountI18N) / var_779_1)

				if var_779_7 > 0 and var_779_2 < var_779_7 then
					arg_776_1.talkMaxDuration = var_779_7

					if var_779_7 + var_779_0 > arg_776_1.duration_ then
						arg_776_1.duration_ = var_779_7 + var_779_0
					end
				end
			end

			local var_779_8 = 0.666666666666667
			local var_779_9 = math.max(var_779_8, arg_776_1.talkMaxDuration)

			if var_779_0 <= arg_776_1.time_ and arg_776_1.time_ < var_779_0 + var_779_9 then
				local var_779_10 = (arg_776_1.time_ - var_779_0) / var_779_9

				arg_776_1.fswtw_.percent = Mathf.Lerp(arg_776_1.var_.oldValueTypewriter, var_779_5, var_779_10)
				arg_776_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_776_1.fswtw_:SetDirty()
			end

			if arg_776_1.time_ >= var_779_0 + var_779_9 and arg_776_1.time_ < var_779_0 + var_779_9 + arg_779_0 then
				arg_776_1.fswtw_.percent = var_779_5

				arg_776_1.fswtw_:SetDirty()
				arg_776_1:ShowNextGo(true)

				arg_776_1.typewritterCharCountI18N = var_779_6
			end
		end

		arg_776_1.nodeConfigList_ = {}

		arg_776_1:InitPlayNodeList()
	end,
	Play1109402189 = function(arg_780_0, arg_780_1)
		arg_780_1.time_ = 0
		arg_780_1.frameCnt_ = 0
		arg_780_1.state_ = "playing"
		arg_780_1.curTalkId_ = 1109402189
		arg_780_1.duration_ = 1.3

		SetActive(arg_780_1.tipsGo_, false)

		function arg_780_1.onSingleLineFinish_()
			arg_780_1.onSingleLineUpdate_ = nil
			arg_780_1.onSingleLineFinish_ = nil
			arg_780_1.state_ = "waiting"
		end

		function arg_780_1.playNext_(arg_782_0)
			if arg_782_0 == 1 then
				arg_780_0:Play1109402190(arg_780_1)
			end
		end

		function arg_780_1.onSingleLineUpdate_(arg_783_0)
			local var_783_0 = 0

			if var_783_0 < arg_780_1.time_ and arg_780_1.time_ <= var_783_0 + arg_783_0 then
				arg_780_1.var_.oldValueTypewriter = arg_780_1.fswtw_.percent

				SetActive(arg_780_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_780_1:ShowNextGo(false)
			end

			local var_783_1 = 5
			local var_783_2 = 0.333333333333333
			local var_783_3 = arg_780_1:GetWordFromCfg(1109402184)
			local var_783_4 = arg_780_1:FormatText(var_783_3.content)
			local var_783_5, var_783_6 = arg_780_1:GetPercentByPara(var_783_4, 6)

			if var_783_0 < arg_780_1.time_ and arg_780_1.time_ <= var_783_0 + arg_783_0 then
				arg_780_1.talkMaxDuration = 0

				local var_783_7 = var_783_1 <= 0 and var_783_2 or var_783_2 * ((var_783_6 - arg_780_1.typewritterCharCountI18N) / var_783_1)

				if var_783_7 > 0 and var_783_2 < var_783_7 then
					arg_780_1.talkMaxDuration = var_783_7

					if var_783_7 + var_783_0 > arg_780_1.duration_ then
						arg_780_1.duration_ = var_783_7 + var_783_0
					end
				end
			end

			local var_783_8 = 0.333333333333333
			local var_783_9 = math.max(var_783_8, arg_780_1.talkMaxDuration)

			if var_783_0 <= arg_780_1.time_ and arg_780_1.time_ < var_783_0 + var_783_9 then
				local var_783_10 = (arg_780_1.time_ - var_783_0) / var_783_9

				arg_780_1.fswtw_.percent = Mathf.Lerp(arg_780_1.var_.oldValueTypewriter, var_783_5, var_783_10)
				arg_780_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_780_1.fswtw_:SetDirty()
			end

			if arg_780_1.time_ >= var_783_0 + var_783_9 and arg_780_1.time_ < var_783_0 + var_783_9 + arg_783_0 then
				arg_780_1.fswtw_.percent = var_783_5

				arg_780_1.fswtw_:SetDirty()
				arg_780_1:ShowNextGo(true)

				arg_780_1.typewritterCharCountI18N = var_783_6
			end

			local var_783_11 = 0
			local var_783_12 = 1.3
			local var_783_13 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402189", "story_v_side_new_1109402.awb") / 1000

			if var_783_13 > 0 and var_783_12 < var_783_13 and var_783_13 + var_783_11 > arg_780_1.duration_ then
				local var_783_14 = var_783_13

				arg_780_1.duration_ = var_783_13 + var_783_11
			end

			if var_783_11 < arg_780_1.time_ and arg_780_1.time_ <= var_783_11 + arg_783_0 then
				local var_783_15 = "play"
				local var_783_16 = "voice"

				arg_780_1:AudioAction(var_783_15, var_783_16, "story_v_side_new_1109402", "1109402189", "story_v_side_new_1109402.awb")
			end
		end

		arg_780_1.nodeConfigList_ = {}

		arg_780_1:InitPlayNodeList()
	end,
	Play1109402190 = function(arg_784_0, arg_784_1)
		arg_784_1.time_ = 0
		arg_784_1.frameCnt_ = 0
		arg_784_1.state_ = "playing"
		arg_784_1.curTalkId_ = 1109402190
		arg_784_1.duration_ = 7

		SetActive(arg_784_1.tipsGo_, false)

		function arg_784_1.onSingleLineFinish_()
			arg_784_1.onSingleLineUpdate_ = nil
			arg_784_1.onSingleLineFinish_ = nil
			arg_784_1.state_ = "waiting"
		end

		function arg_784_1.playNext_(arg_786_0)
			if arg_786_0 == 1 then
				arg_784_0:Play1109402191(arg_784_1)
			end
		end

		function arg_784_1.onSingleLineUpdate_(arg_787_0)
			local var_787_0 = 0

			if var_787_0 < arg_784_1.time_ and arg_784_1.time_ <= var_787_0 + arg_787_0 then
				if arg_784_0.sceneSettingEffect_ then
					arg_784_1.sceneSettingEffect_.enabled = false
				end

				arg_784_1.sceneSettingGo_:SetActive(true)

				local var_787_1 = manager.ui.mainCamera.transform.localPosition
				local var_787_2 = Vector3.New(0, 0, 10) + Vector3.New(var_787_1.x, var_787_1.y, 0)
				local var_787_3 = arg_784_1.bgs_.ST03a

				var_787_3.transform.localPosition = var_787_2
				var_787_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_787_4 = var_787_3:GetComponent("SpriteRenderer")

				if var_787_4 and var_787_4.sprite then
					local var_787_5 = (var_787_3.transform.localPosition - var_787_1).z
					local var_787_6 = manager.ui.mainCameraCom_
					local var_787_7 = 2 * var_787_5 * Mathf.Tan(var_787_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_787_8 = var_787_7 * var_787_6.aspect
					local var_787_9 = var_787_4.sprite.bounds.size.x
					local var_787_10 = var_787_4.sprite.bounds.size.y
					local var_787_11 = var_787_8 / var_787_9
					local var_787_12 = var_787_7 / var_787_10
					local var_787_13 = var_787_12 < var_787_11 and var_787_11 or var_787_12

					var_787_3.transform.localScale = Vector3.New(var_787_13, var_787_13, 0)
				end

				for iter_787_0, iter_787_1 in pairs(arg_784_1.bgs_) do
					if iter_787_0 ~= "ST03a" then
						iter_787_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_787_14 = 0

			if var_787_14 < arg_784_1.time_ and arg_784_1.time_ <= var_787_14 + arg_787_0 then
				arg_784_1.mask_.enabled = true
				arg_784_1.mask_.raycastTarget = true

				arg_784_1:SetGaussion(false)
			end

			local var_787_15 = 2

			if var_787_14 <= arg_784_1.time_ and arg_784_1.time_ < var_787_14 + var_787_15 then
				local var_787_16 = (arg_784_1.time_ - var_787_14) / var_787_15
				local var_787_17 = Color.New(0, 0, 0)

				var_787_17.a = Mathf.Lerp(1, 0, var_787_16)
				arg_784_1.mask_.color = var_787_17
			end

			if arg_784_1.time_ >= var_787_14 + var_787_15 and arg_784_1.time_ < var_787_14 + var_787_15 + arg_787_0 then
				local var_787_18 = Color.New(0, 0, 0)
				local var_787_19 = 0

				arg_784_1.mask_.enabled = false
				var_787_18.a = var_787_19
				arg_784_1.mask_.color = var_787_18
			end

			local var_787_20 = 0

			if var_787_20 < arg_784_1.time_ and arg_784_1.time_ <= var_787_20 + arg_787_0 then
				arg_784_1.fswbg_:SetActive(false)
				arg_784_1.dialog_:SetActive(false)
				SetActive(arg_784_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_784_1:ShowNextGo(false)
			end

			if arg_784_1.frameCnt_ <= 1 then
				arg_784_1.dialog_:SetActive(false)
			end

			local var_787_21 = 2
			local var_787_22 = 1

			if var_787_21 < arg_784_1.time_ and arg_784_1.time_ <= var_787_21 + arg_787_0 then
				arg_784_1.talkMaxDuration = 0

				arg_784_1.dialog_:SetActive(true)

				arg_784_1.dialogCg_.alpha = 0

				local var_787_23 = LeanTween.value(arg_784_1.dialog_, 0, 1, 0.3)

				var_787_23:setOnUpdate(LuaHelper.FloatAction(function(arg_788_0)
					arg_784_1.dialogCg_.alpha = arg_788_0
				end))
				var_787_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_784_1.dialog_)
					var_787_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_784_1.duration_ = arg_784_1.duration_ + 0.3

				SetActive(arg_784_1.leftNameGo_, false)

				arg_784_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_784_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_784_1:RecordName(arg_784_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_784_1.iconTrs_.gameObject, false)
				arg_784_1.callingController_:SetSelectedState("normal")

				local var_787_24 = arg_784_1:GetWordFromCfg(1109402190)
				local var_787_25 = arg_784_1:FormatText(var_787_24.content)

				arg_784_1.text_.text = var_787_25

				LuaForUtil.ClearLinePrefixSymbol(arg_784_1.text_)

				local var_787_26 = 40
				local var_787_27 = utf8.len(var_787_25)
				local var_787_28 = var_787_26 <= 0 and var_787_22 or var_787_22 * (var_787_27 / var_787_26)

				if var_787_28 > 0 and var_787_22 < var_787_28 then
					arg_784_1.talkMaxDuration = var_787_28
					var_787_21 = var_787_21 + 0.3

					if var_787_28 + var_787_21 > arg_784_1.duration_ then
						arg_784_1.duration_ = var_787_28 + var_787_21
					end
				end

				arg_784_1.text_.text = var_787_25
				arg_784_1.typewritter.percent = 0

				arg_784_1.typewritter:SetDirty()
				arg_784_1:ShowNextGo(false)
				arg_784_1:RecordContent(arg_784_1.text_.text)
			end

			local var_787_29 = var_787_21 + 0.3
			local var_787_30 = math.max(var_787_22, arg_784_1.talkMaxDuration)

			if var_787_29 <= arg_784_1.time_ and arg_784_1.time_ < var_787_29 + var_787_30 then
				arg_784_1.typewritter.percent = (arg_784_1.time_ - var_787_29) / var_787_30

				arg_784_1.typewritter:SetDirty()
			end

			if arg_784_1.time_ >= var_787_29 + var_787_30 and arg_784_1.time_ < var_787_29 + var_787_30 + arg_787_0 then
				arg_784_1.typewritter.percent = 1

				arg_784_1.typewritter:SetDirty()
				arg_784_1:ShowNextGo(true)
			end
		end

		arg_784_1.nodeConfigList_ = {}

		arg_784_1:InitPlayNodeList()
	end,
	Play1109402191 = function(arg_790_0, arg_790_1)
		arg_790_1.time_ = 0
		arg_790_1.frameCnt_ = 0
		arg_790_1.state_ = "playing"
		arg_790_1.curTalkId_ = 1109402191
		arg_790_1.duration_ = 5

		SetActive(arg_790_1.tipsGo_, false)

		function arg_790_1.onSingleLineFinish_()
			arg_790_1.onSingleLineUpdate_ = nil
			arg_790_1.onSingleLineFinish_ = nil
			arg_790_1.state_ = "waiting"
		end

		function arg_790_1.playNext_(arg_792_0)
			if arg_792_0 == 1 then
				arg_790_0:Play1109402192(arg_790_1)
			end
		end

		function arg_790_1.onSingleLineUpdate_(arg_793_0)
			local var_793_0 = 0
			local var_793_1 = 1

			if var_793_0 < arg_790_1.time_ and arg_790_1.time_ <= var_793_0 + arg_793_0 then
				local var_793_2 = "play"
				local var_793_3 = "effect"

				arg_790_1:AudioAction(var_793_2, var_793_3, "se_story_activity_1_5_3", "se_story_activity_1_5_3_fireworks_loop", "")
			end

			local var_793_4 = 0
			local var_793_5 = 1

			if var_793_4 < arg_790_1.time_ and arg_790_1.time_ <= var_793_4 + arg_793_0 then
				arg_790_1.talkMaxDuration = 0
				arg_790_1.dialogCg_.alpha = 1

				arg_790_1.dialog_:SetActive(true)
				SetActive(arg_790_1.leftNameGo_, false)

				arg_790_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_790_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_790_1:RecordName(arg_790_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_790_1.iconTrs_.gameObject, false)
				arg_790_1.callingController_:SetSelectedState("normal")

				local var_793_6 = arg_790_1:GetWordFromCfg(1109402191)
				local var_793_7 = arg_790_1:FormatText(var_793_6.content)

				arg_790_1.text_.text = var_793_7

				LuaForUtil.ClearLinePrefixSymbol(arg_790_1.text_)

				local var_793_8 = 40
				local var_793_9 = utf8.len(var_793_7)
				local var_793_10 = var_793_8 <= 0 and var_793_5 or var_793_5 * (var_793_9 / var_793_8)

				if var_793_10 > 0 and var_793_5 < var_793_10 then
					arg_790_1.talkMaxDuration = var_793_10

					if var_793_10 + var_793_4 > arg_790_1.duration_ then
						arg_790_1.duration_ = var_793_10 + var_793_4
					end
				end

				arg_790_1.text_.text = var_793_7
				arg_790_1.typewritter.percent = 0

				arg_790_1.typewritter:SetDirty()
				arg_790_1:ShowNextGo(false)
				arg_790_1:RecordContent(arg_790_1.text_.text)
			end

			local var_793_11 = math.max(var_793_5, arg_790_1.talkMaxDuration)

			if var_793_4 <= arg_790_1.time_ and arg_790_1.time_ < var_793_4 + var_793_11 then
				arg_790_1.typewritter.percent = (arg_790_1.time_ - var_793_4) / var_793_11

				arg_790_1.typewritter:SetDirty()
			end

			if arg_790_1.time_ >= var_793_4 + var_793_11 and arg_790_1.time_ < var_793_4 + var_793_11 + arg_793_0 then
				arg_790_1.typewritter.percent = 1

				arg_790_1.typewritter:SetDirty()
				arg_790_1:ShowNextGo(true)
			end
		end

		arg_790_1.nodeConfigList_ = {}

		arg_790_1:InitPlayNodeList()
	end,
	Play1109402192 = function(arg_794_0, arg_794_1)
		arg_794_1.time_ = 0
		arg_794_1.frameCnt_ = 0
		arg_794_1.state_ = "playing"
		arg_794_1.curTalkId_ = 1109402192
		arg_794_1.duration_ = 3.43

		local var_794_0 = {
			ja = 3.333,
			ko = 3.433,
			zh = 3.433
		}
		local var_794_1 = manager.audio:GetLocalizationFlag()

		if var_794_0[var_794_1] ~= nil then
			arg_794_1.duration_ = var_794_0[var_794_1]
		end

		SetActive(arg_794_1.tipsGo_, false)

		function arg_794_1.onSingleLineFinish_()
			arg_794_1.onSingleLineUpdate_ = nil
			arg_794_1.onSingleLineFinish_ = nil
			arg_794_1.state_ = "waiting"
		end

		function arg_794_1.playNext_(arg_796_0)
			if arg_796_0 == 1 then
				arg_794_0:Play1109402193(arg_794_1)
			end
		end

		function arg_794_1.onSingleLineUpdate_(arg_797_0)
			local var_797_0 = arg_794_1.actors_["1094ui_story"].transform
			local var_797_1 = 0

			if var_797_1 < arg_794_1.time_ and arg_794_1.time_ <= var_797_1 + arg_797_0 then
				arg_794_1.var_.moveOldPos1094ui_story = var_797_0.localPosition
			end

			local var_797_2 = 0.001

			if var_797_1 <= arg_794_1.time_ and arg_794_1.time_ < var_797_1 + var_797_2 then
				local var_797_3 = (arg_794_1.time_ - var_797_1) / var_797_2
				local var_797_4 = Vector3.New(0, -0.84, -6.1)

				var_797_0.localPosition = Vector3.Lerp(arg_794_1.var_.moveOldPos1094ui_story, var_797_4, var_797_3)

				local var_797_5 = manager.ui.mainCamera.transform.position - var_797_0.position

				var_797_0.forward = Vector3.New(var_797_5.x, var_797_5.y, var_797_5.z)

				local var_797_6 = var_797_0.localEulerAngles

				var_797_6.z = 0
				var_797_6.x = 0
				var_797_0.localEulerAngles = var_797_6
			end

			if arg_794_1.time_ >= var_797_1 + var_797_2 and arg_794_1.time_ < var_797_1 + var_797_2 + arg_797_0 then
				var_797_0.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_797_7 = manager.ui.mainCamera.transform.position - var_797_0.position

				var_797_0.forward = Vector3.New(var_797_7.x, var_797_7.y, var_797_7.z)

				local var_797_8 = var_797_0.localEulerAngles

				var_797_8.z = 0
				var_797_8.x = 0
				var_797_0.localEulerAngles = var_797_8
			end

			local var_797_9 = arg_794_1.actors_["1094ui_story"]
			local var_797_10 = 0

			if var_797_10 < arg_794_1.time_ and arg_794_1.time_ <= var_797_10 + arg_797_0 and not isNil(var_797_9) and arg_794_1.var_.characterEffect1094ui_story == nil then
				arg_794_1.var_.characterEffect1094ui_story = var_797_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_797_11 = 0.200000002980232

			if var_797_10 <= arg_794_1.time_ and arg_794_1.time_ < var_797_10 + var_797_11 and not isNil(var_797_9) then
				local var_797_12 = (arg_794_1.time_ - var_797_10) / var_797_11

				if arg_794_1.var_.characterEffect1094ui_story and not isNil(var_797_9) then
					arg_794_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_794_1.time_ >= var_797_10 + var_797_11 and arg_794_1.time_ < var_797_10 + var_797_11 + arg_797_0 and not isNil(var_797_9) and arg_794_1.var_.characterEffect1094ui_story then
				arg_794_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_797_13 = 0

			if var_797_13 < arg_794_1.time_ and arg_794_1.time_ <= var_797_13 + arg_797_0 then
				arg_794_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action1_1")
			end

			local var_797_14 = 0

			if var_797_14 < arg_794_1.time_ and arg_794_1.time_ <= var_797_14 + arg_797_0 then
				arg_794_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_797_15 = 0
			local var_797_16 = 0.225

			if var_797_15 < arg_794_1.time_ and arg_794_1.time_ <= var_797_15 + arg_797_0 then
				arg_794_1.talkMaxDuration = 0
				arg_794_1.dialogCg_.alpha = 1

				arg_794_1.dialog_:SetActive(true)
				SetActive(arg_794_1.leftNameGo_, true)

				local var_797_17 = arg_794_1:FormatText(StoryNameCfg[181].name)

				arg_794_1.leftNameTxt_.text = var_797_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_794_1.leftNameTxt_.transform)

				arg_794_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_794_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_794_1:RecordName(arg_794_1.leftNameTxt_.text)
				SetActive(arg_794_1.iconTrs_.gameObject, false)
				arg_794_1.callingController_:SetSelectedState("normal")

				local var_797_18 = arg_794_1:GetWordFromCfg(1109402192)
				local var_797_19 = arg_794_1:FormatText(var_797_18.content)

				arg_794_1.text_.text = var_797_19

				LuaForUtil.ClearLinePrefixSymbol(arg_794_1.text_)

				local var_797_20 = 9
				local var_797_21 = utf8.len(var_797_19)
				local var_797_22 = var_797_20 <= 0 and var_797_16 or var_797_16 * (var_797_21 / var_797_20)

				if var_797_22 > 0 and var_797_16 < var_797_22 then
					arg_794_1.talkMaxDuration = var_797_22

					if var_797_22 + var_797_15 > arg_794_1.duration_ then
						arg_794_1.duration_ = var_797_22 + var_797_15
					end
				end

				arg_794_1.text_.text = var_797_19
				arg_794_1.typewritter.percent = 0

				arg_794_1.typewritter:SetDirty()
				arg_794_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402192", "story_v_side_new_1109402.awb") ~= 0 then
					local var_797_23 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402192", "story_v_side_new_1109402.awb") / 1000

					if var_797_23 + var_797_15 > arg_794_1.duration_ then
						arg_794_1.duration_ = var_797_23 + var_797_15
					end

					if var_797_18.prefab_name ~= "" and arg_794_1.actors_[var_797_18.prefab_name] ~= nil then
						local var_797_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_794_1.actors_[var_797_18.prefab_name].transform, "story_v_side_new_1109402", "1109402192", "story_v_side_new_1109402.awb")

						arg_794_1:RecordAudio("1109402192", var_797_24)
						arg_794_1:RecordAudio("1109402192", var_797_24)
					else
						arg_794_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402192", "story_v_side_new_1109402.awb")
					end

					arg_794_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402192", "story_v_side_new_1109402.awb")
				end

				arg_794_1:RecordContent(arg_794_1.text_.text)
			end

			local var_797_25 = math.max(var_797_16, arg_794_1.talkMaxDuration)

			if var_797_15 <= arg_794_1.time_ and arg_794_1.time_ < var_797_15 + var_797_25 then
				arg_794_1.typewritter.percent = (arg_794_1.time_ - var_797_15) / var_797_25

				arg_794_1.typewritter:SetDirty()
			end

			if arg_794_1.time_ >= var_797_15 + var_797_25 and arg_794_1.time_ < var_797_15 + var_797_25 + arg_797_0 then
				arg_794_1.typewritter.percent = 1

				arg_794_1.typewritter:SetDirty()
				arg_794_1:ShowNextGo(true)
			end
		end

		arg_794_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_794_1:InitPlayNodeList()
	end,
	Play1109402193 = function(arg_798_0, arg_798_1)
		arg_798_1.time_ = 0
		arg_798_1.frameCnt_ = 0
		arg_798_1.state_ = "playing"
		arg_798_1.curTalkId_ = 1109402193
		arg_798_1.duration_ = 5

		SetActive(arg_798_1.tipsGo_, false)

		function arg_798_1.onSingleLineFinish_()
			arg_798_1.onSingleLineUpdate_ = nil
			arg_798_1.onSingleLineFinish_ = nil
			arg_798_1.state_ = "waiting"
		end

		function arg_798_1.playNext_(arg_800_0)
			if arg_800_0 == 1 then
				arg_798_0:Play1109402194(arg_798_1)
			end
		end

		function arg_798_1.onSingleLineUpdate_(arg_801_0)
			local var_801_0 = arg_798_1.actors_["1094ui_story"]
			local var_801_1 = 0

			if var_801_1 < arg_798_1.time_ and arg_798_1.time_ <= var_801_1 + arg_801_0 and not isNil(var_801_0) and arg_798_1.var_.characterEffect1094ui_story == nil then
				arg_798_1.var_.characterEffect1094ui_story = var_801_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_801_2 = 0.200000002980232

			if var_801_1 <= arg_798_1.time_ and arg_798_1.time_ < var_801_1 + var_801_2 and not isNil(var_801_0) then
				local var_801_3 = (arg_798_1.time_ - var_801_1) / var_801_2

				if arg_798_1.var_.characterEffect1094ui_story and not isNil(var_801_0) then
					local var_801_4 = Mathf.Lerp(0, 0.5, var_801_3)

					arg_798_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_798_1.var_.characterEffect1094ui_story.fillRatio = var_801_4
				end
			end

			if arg_798_1.time_ >= var_801_1 + var_801_2 and arg_798_1.time_ < var_801_1 + var_801_2 + arg_801_0 and not isNil(var_801_0) and arg_798_1.var_.characterEffect1094ui_story then
				local var_801_5 = 0.5

				arg_798_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_798_1.var_.characterEffect1094ui_story.fillRatio = var_801_5
			end

			local var_801_6 = 0
			local var_801_7 = 0.975

			if var_801_6 < arg_798_1.time_ and arg_798_1.time_ <= var_801_6 + arg_801_0 then
				arg_798_1.talkMaxDuration = 0
				arg_798_1.dialogCg_.alpha = 1

				arg_798_1.dialog_:SetActive(true)
				SetActive(arg_798_1.leftNameGo_, true)

				local var_801_8 = arg_798_1:FormatText(StoryNameCfg[7].name)

				arg_798_1.leftNameTxt_.text = var_801_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_798_1.leftNameTxt_.transform)

				arg_798_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_798_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_798_1:RecordName(arg_798_1.leftNameTxt_.text)
				SetActive(arg_798_1.iconTrs_.gameObject, true)
				arg_798_1.iconController_:SetSelectedState("hero")

				arg_798_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_798_1.callingController_:SetSelectedState("normal")

				arg_798_1.keyicon_.color = Color.New(1, 1, 1)
				arg_798_1.icon_.color = Color.New(1, 1, 1)

				local var_801_9 = arg_798_1:GetWordFromCfg(1109402193)
				local var_801_10 = arg_798_1:FormatText(var_801_9.content)

				arg_798_1.text_.text = var_801_10

				LuaForUtil.ClearLinePrefixSymbol(arg_798_1.text_)

				local var_801_11 = 39
				local var_801_12 = utf8.len(var_801_10)
				local var_801_13 = var_801_11 <= 0 and var_801_7 or var_801_7 * (var_801_12 / var_801_11)

				if var_801_13 > 0 and var_801_7 < var_801_13 then
					arg_798_1.talkMaxDuration = var_801_13

					if var_801_13 + var_801_6 > arg_798_1.duration_ then
						arg_798_1.duration_ = var_801_13 + var_801_6
					end
				end

				arg_798_1.text_.text = var_801_10
				arg_798_1.typewritter.percent = 0

				arg_798_1.typewritter:SetDirty()
				arg_798_1:ShowNextGo(false)
				arg_798_1:RecordContent(arg_798_1.text_.text)
			end

			local var_801_14 = math.max(var_801_7, arg_798_1.talkMaxDuration)

			if var_801_6 <= arg_798_1.time_ and arg_798_1.time_ < var_801_6 + var_801_14 then
				arg_798_1.typewritter.percent = (arg_798_1.time_ - var_801_6) / var_801_14

				arg_798_1.typewritter:SetDirty()
			end

			if arg_798_1.time_ >= var_801_6 + var_801_14 and arg_798_1.time_ < var_801_6 + var_801_14 + arg_801_0 then
				arg_798_1.typewritter.percent = 1

				arg_798_1.typewritter:SetDirty()
				arg_798_1:ShowNextGo(true)
			end
		end

		arg_798_1.nodeConfigList_ = {}

		arg_798_1:InitPlayNodeList()
	end,
	Play1109402194 = function(arg_802_0, arg_802_1)
		arg_802_1.time_ = 0
		arg_802_1.frameCnt_ = 0
		arg_802_1.state_ = "playing"
		arg_802_1.curTalkId_ = 1109402194
		arg_802_1.duration_ = 4.3

		local var_802_0 = {
			ja = 1.999999999999,
			ko = 4.3,
			zh = 4.3
		}
		local var_802_1 = manager.audio:GetLocalizationFlag()

		if var_802_0[var_802_1] ~= nil then
			arg_802_1.duration_ = var_802_0[var_802_1]
		end

		SetActive(arg_802_1.tipsGo_, false)

		function arg_802_1.onSingleLineFinish_()
			arg_802_1.onSingleLineUpdate_ = nil
			arg_802_1.onSingleLineFinish_ = nil
			arg_802_1.state_ = "waiting"
			arg_802_1.auto_ = false
		end

		function arg_802_1.playNext_(arg_804_0)
			arg_802_1.onStoryFinished_()
		end

		function arg_802_1.onSingleLineUpdate_(arg_805_0)
			local var_805_0 = arg_802_1.actors_["1094ui_story"].transform
			local var_805_1 = 0

			if var_805_1 < arg_802_1.time_ and arg_802_1.time_ <= var_805_1 + arg_805_0 then
				arg_802_1.var_.moveOldPos1094ui_story = var_805_0.localPosition
			end

			local var_805_2 = 0.001

			if var_805_1 <= arg_802_1.time_ and arg_802_1.time_ < var_805_1 + var_805_2 then
				local var_805_3 = (arg_802_1.time_ - var_805_1) / var_805_2
				local var_805_4 = Vector3.New(0, -0.84, -6.1)

				var_805_0.localPosition = Vector3.Lerp(arg_802_1.var_.moveOldPos1094ui_story, var_805_4, var_805_3)

				local var_805_5 = manager.ui.mainCamera.transform.position - var_805_0.position

				var_805_0.forward = Vector3.New(var_805_5.x, var_805_5.y, var_805_5.z)

				local var_805_6 = var_805_0.localEulerAngles

				var_805_6.z = 0
				var_805_6.x = 0
				var_805_0.localEulerAngles = var_805_6
			end

			if arg_802_1.time_ >= var_805_1 + var_805_2 and arg_802_1.time_ < var_805_1 + var_805_2 + arg_805_0 then
				var_805_0.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_805_7 = manager.ui.mainCamera.transform.position - var_805_0.position

				var_805_0.forward = Vector3.New(var_805_7.x, var_805_7.y, var_805_7.z)

				local var_805_8 = var_805_0.localEulerAngles

				var_805_8.z = 0
				var_805_8.x = 0
				var_805_0.localEulerAngles = var_805_8
			end

			local var_805_9 = arg_802_1.actors_["1094ui_story"]
			local var_805_10 = 0

			if var_805_10 < arg_802_1.time_ and arg_802_1.time_ <= var_805_10 + arg_805_0 and not isNil(var_805_9) and arg_802_1.var_.characterEffect1094ui_story == nil then
				arg_802_1.var_.characterEffect1094ui_story = var_805_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_805_11 = 0.200000002980232

			if var_805_10 <= arg_802_1.time_ and arg_802_1.time_ < var_805_10 + var_805_11 and not isNil(var_805_9) then
				local var_805_12 = (arg_802_1.time_ - var_805_10) / var_805_11

				if arg_802_1.var_.characterEffect1094ui_story and not isNil(var_805_9) then
					arg_802_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_802_1.time_ >= var_805_10 + var_805_11 and arg_802_1.time_ < var_805_10 + var_805_11 + arg_805_0 and not isNil(var_805_9) and arg_802_1.var_.characterEffect1094ui_story then
				arg_802_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_805_13 = 0

			if var_805_13 < arg_802_1.time_ and arg_802_1.time_ <= var_805_13 + arg_805_0 then
				arg_802_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action1_1")
			end

			local var_805_14 = 0

			if var_805_14 < arg_802_1.time_ and arg_802_1.time_ <= var_805_14 + arg_805_0 then
				arg_802_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_805_15 = 0
			local var_805_16 = 0.275

			if var_805_15 < arg_802_1.time_ and arg_802_1.time_ <= var_805_15 + arg_805_0 then
				arg_802_1.talkMaxDuration = 0
				arg_802_1.dialogCg_.alpha = 1

				arg_802_1.dialog_:SetActive(true)
				SetActive(arg_802_1.leftNameGo_, true)

				local var_805_17 = arg_802_1:FormatText(StoryNameCfg[181].name)

				arg_802_1.leftNameTxt_.text = var_805_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_802_1.leftNameTxt_.transform)

				arg_802_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_802_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_802_1:RecordName(arg_802_1.leftNameTxt_.text)
				SetActive(arg_802_1.iconTrs_.gameObject, false)
				arg_802_1.callingController_:SetSelectedState("normal")

				local var_805_18 = arg_802_1:GetWordFromCfg(1109402194)
				local var_805_19 = arg_802_1:FormatText(var_805_18.content)

				arg_802_1.text_.text = var_805_19

				LuaForUtil.ClearLinePrefixSymbol(arg_802_1.text_)

				local var_805_20 = 11
				local var_805_21 = utf8.len(var_805_19)
				local var_805_22 = var_805_20 <= 0 and var_805_16 or var_805_16 * (var_805_21 / var_805_20)

				if var_805_22 > 0 and var_805_16 < var_805_22 then
					arg_802_1.talkMaxDuration = var_805_22

					if var_805_22 + var_805_15 > arg_802_1.duration_ then
						arg_802_1.duration_ = var_805_22 + var_805_15
					end
				end

				arg_802_1.text_.text = var_805_19
				arg_802_1.typewritter.percent = 0

				arg_802_1.typewritter:SetDirty()
				arg_802_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402194", "story_v_side_new_1109402.awb") ~= 0 then
					local var_805_23 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402194", "story_v_side_new_1109402.awb") / 1000

					if var_805_23 + var_805_15 > arg_802_1.duration_ then
						arg_802_1.duration_ = var_805_23 + var_805_15
					end

					if var_805_18.prefab_name ~= "" and arg_802_1.actors_[var_805_18.prefab_name] ~= nil then
						local var_805_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_802_1.actors_[var_805_18.prefab_name].transform, "story_v_side_new_1109402", "1109402194", "story_v_side_new_1109402.awb")

						arg_802_1:RecordAudio("1109402194", var_805_24)
						arg_802_1:RecordAudio("1109402194", var_805_24)
					else
						arg_802_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402194", "story_v_side_new_1109402.awb")
					end

					arg_802_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402194", "story_v_side_new_1109402.awb")
				end

				arg_802_1:RecordContent(arg_802_1.text_.text)
			end

			local var_805_25 = math.max(var_805_16, arg_802_1.talkMaxDuration)

			if var_805_15 <= arg_802_1.time_ and arg_802_1.time_ < var_805_15 + var_805_25 then
				arg_802_1.typewritter.percent = (arg_802_1.time_ - var_805_15) / var_805_25

				arg_802_1.typewritter:SetDirty()
			end

			if arg_802_1.time_ >= var_805_15 + var_805_25 and arg_802_1.time_ < var_805_15 + var_805_25 + arg_805_0 then
				arg_802_1.typewritter.percent = 1

				arg_802_1.typewritter:SetDirty()
				arg_802_1:ShowNextGo(true)
			end
		end

		arg_802_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_802_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST03",
		"TextureConfig/Background/I05d",
		"TextureConfig/Background/D06_1",
		"TextureConfig/Background/ST17",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST03a",
		"TextureConfig/Background/I05a"
	},
	voices = {
		"story_v_side_new_1109402.awb"
	}
}
