return {
	Play319841001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 319841001
		arg_1_1.duration_ = 6.35

		local var_1_0 = {
			zh = 4.983,
			ja = 6.35
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
				arg_1_0:Play319841002(arg_1_1)
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

			local var_4_30 = 1.65
			local var_4_31 = 0.35

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

				local var_4_33 = arg_1_1:FormatText(StoryNameCfg[640].name)

				arg_1_1.leftNameTxt_.text = var_4_33

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_34 = arg_1_1:GetWordFromCfg(319841001)
				local var_4_35 = arg_1_1:FormatText(var_4_34.content)

				arg_1_1.text_.text = var_4_35

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_36 = 14
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

				if manager.audio:GetVoiceLength("story_v_out_319841", "319841001", "story_v_out_319841.awb") ~= 0 then
					local var_4_39 = manager.audio:GetVoiceLength("story_v_out_319841", "319841001", "story_v_out_319841.awb") / 1000

					if var_4_39 + var_4_30 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_39 + var_4_30
					end

					if var_4_34.prefab_name ~= "" and arg_1_1.actors_[var_4_34.prefab_name] ~= nil then
						local var_4_40 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_34.prefab_name].transform, "story_v_out_319841", "319841001", "story_v_out_319841.awb")

						arg_1_1:RecordAudio("319841001", var_4_40)
						arg_1_1:RecordAudio("319841001", var_4_40)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_319841", "319841001", "story_v_out_319841.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_319841", "319841001", "story_v_out_319841.awb")
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
	Play319841002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 319841002
		arg_8_1.duration_ = 4.4

		local var_8_0 = {
			zh = 4,
			ja = 4.4
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
				arg_8_0:Play319841003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0
			local var_11_1 = 0.275

			if var_11_0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_2 = arg_8_1:FormatText(StoryNameCfg[6].name)

				arg_8_1.leftNameTxt_.text = var_11_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_3 = arg_8_1:GetWordFromCfg(319841002)
				local var_11_4 = arg_8_1:FormatText(var_11_3.content)

				arg_8_1.text_.text = var_11_4

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_5 = 11
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

				if manager.audio:GetVoiceLength("story_v_out_319841", "319841002", "story_v_out_319841.awb") ~= 0 then
					local var_11_8 = manager.audio:GetVoiceLength("story_v_out_319841", "319841002", "story_v_out_319841.awb") / 1000

					if var_11_8 + var_11_0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_8 + var_11_0
					end

					if var_11_3.prefab_name ~= "" and arg_8_1.actors_[var_11_3.prefab_name] ~= nil then
						local var_11_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_3.prefab_name].transform, "story_v_out_319841", "319841002", "story_v_out_319841.awb")

						arg_8_1:RecordAudio("319841002", var_11_9)
						arg_8_1:RecordAudio("319841002", var_11_9)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_319841", "319841002", "story_v_out_319841.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_319841", "319841002", "story_v_out_319841.awb")
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
	Play319841003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 319841003
		arg_12_1.duration_ = 4.7

		local var_12_0 = {
			zh = 3.333,
			ja = 4.7
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
				arg_12_0:Play319841004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0
			local var_15_1 = 0.35

			if var_15_0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_2 = arg_12_1:FormatText(StoryNameCfg[640].name)

				arg_12_1.leftNameTxt_.text = var_15_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_3 = arg_12_1:GetWordFromCfg(319841003)
				local var_15_4 = arg_12_1:FormatText(var_15_3.content)

				arg_12_1.text_.text = var_15_4

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_5 = 14
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

				if manager.audio:GetVoiceLength("story_v_out_319841", "319841003", "story_v_out_319841.awb") ~= 0 then
					local var_15_8 = manager.audio:GetVoiceLength("story_v_out_319841", "319841003", "story_v_out_319841.awb") / 1000

					if var_15_8 + var_15_0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_8 + var_15_0
					end

					if var_15_3.prefab_name ~= "" and arg_12_1.actors_[var_15_3.prefab_name] ~= nil then
						local var_15_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_3.prefab_name].transform, "story_v_out_319841", "319841003", "story_v_out_319841.awb")

						arg_12_1:RecordAudio("319841003", var_15_9)
						arg_12_1:RecordAudio("319841003", var_15_9)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_319841", "319841003", "story_v_out_319841.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_319841", "319841003", "story_v_out_319841.awb")
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
	Play319841004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 319841004
		arg_16_1.duration_ = 5.2

		local var_16_0 = {
			zh = 2.666,
			ja = 5.2
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
				arg_16_0:Play319841005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0
			local var_19_1 = 0.3

			if var_19_0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_0 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_2 = arg_16_1:FormatText(StoryNameCfg[6].name)

				arg_16_1.leftNameTxt_.text = var_19_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_3 = arg_16_1:GetWordFromCfg(319841004)
				local var_19_4 = arg_16_1:FormatText(var_19_3.content)

				arg_16_1.text_.text = var_19_4

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_5 = 12
				local var_19_6 = utf8.len(var_19_4)
				local var_19_7 = var_19_5 <= 0 and var_19_1 or var_19_1 * (var_19_6 / var_19_5)

				if var_19_7 > 0 and var_19_1 < var_19_7 then
					arg_16_1.talkMaxDuration = var_19_7

					if var_19_7 + var_19_0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_7 + var_19_0
					end
				end

				arg_16_1.text_.text = var_19_4
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319841", "319841004", "story_v_out_319841.awb") ~= 0 then
					local var_19_8 = manager.audio:GetVoiceLength("story_v_out_319841", "319841004", "story_v_out_319841.awb") / 1000

					if var_19_8 + var_19_0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_8 + var_19_0
					end

					if var_19_3.prefab_name ~= "" and arg_16_1.actors_[var_19_3.prefab_name] ~= nil then
						local var_19_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_3.prefab_name].transform, "story_v_out_319841", "319841004", "story_v_out_319841.awb")

						arg_16_1:RecordAudio("319841004", var_19_9)
						arg_16_1:RecordAudio("319841004", var_19_9)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_319841", "319841004", "story_v_out_319841.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_319841", "319841004", "story_v_out_319841.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_10 = math.max(var_19_1, arg_16_1.talkMaxDuration)

			if var_19_0 <= arg_16_1.time_ and arg_16_1.time_ < var_19_0 + var_19_10 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_0) / var_19_10

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_0 + var_19_10 and arg_16_1.time_ < var_19_0 + var_19_10 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play319841005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 319841005
		arg_20_1.duration_ = 2.47

		local var_20_0 = {
			zh = 2.46633333333333,
			ja = 2.19933333333333
		}
		local var_20_1 = manager.audio:GetLocalizationFlag()

		if var_20_0[var_20_1] ~= nil then
			arg_20_1.duration_ = var_20_0[var_20_1]
		end

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play319841006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if arg_20_1.frameCnt_ <= 1 then
				arg_20_1.dialog_:SetActive(false)
			end

			local var_23_0 = 0.733333333333333
			local var_23_1 = 0.15

			if var_23_0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_0 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0

				arg_20_1.dialog_:SetActive(true)

				arg_20_1.dialogCg_.alpha = 0

				local var_23_2 = LeanTween.value(arg_20_1.dialog_, 0, 1, 0.3)

				var_23_2:setOnUpdate(LuaHelper.FloatAction(function(arg_24_0)
					arg_20_1.dialogCg_.alpha = arg_24_0
				end))
				var_23_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_20_1.dialog_)
					var_23_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_20_1.duration_ = arg_20_1.duration_ + 0.3

				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_3 = arg_20_1:FormatText(StoryNameCfg[640].name)

				arg_20_1.leftNameTxt_.text = var_23_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_4 = arg_20_1:GetWordFromCfg(319841005)
				local var_23_5 = arg_20_1:FormatText(var_23_4.content)

				arg_20_1.text_.text = var_23_5

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_6 = 6
				local var_23_7 = utf8.len(var_23_5)
				local var_23_8 = var_23_6 <= 0 and var_23_1 or var_23_1 * (var_23_7 / var_23_6)

				if var_23_8 > 0 and var_23_1 < var_23_8 then
					arg_20_1.talkMaxDuration = var_23_8
					var_23_0 = var_23_0 + 0.3

					if var_23_8 + var_23_0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_8 + var_23_0
					end
				end

				arg_20_1.text_.text = var_23_5
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319841", "319841005", "story_v_out_319841.awb") ~= 0 then
					local var_23_9 = manager.audio:GetVoiceLength("story_v_out_319841", "319841005", "story_v_out_319841.awb") / 1000

					if var_23_9 + var_23_0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_9 + var_23_0
					end

					if var_23_4.prefab_name ~= "" and arg_20_1.actors_[var_23_4.prefab_name] ~= nil then
						local var_23_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_4.prefab_name].transform, "story_v_out_319841", "319841005", "story_v_out_319841.awb")

						arg_20_1:RecordAudio("319841005", var_23_10)
						arg_20_1:RecordAudio("319841005", var_23_10)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_319841", "319841005", "story_v_out_319841.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_319841", "319841005", "story_v_out_319841.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_11 = var_23_0 + 0.3
			local var_23_12 = math.max(var_23_1, arg_20_1.talkMaxDuration)

			if var_23_11 <= arg_20_1.time_ and arg_20_1.time_ < var_23_11 + var_23_12 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_11) / var_23_12

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_11 + var_23_12 and arg_20_1.time_ < var_23_11 + var_23_12 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play319841006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 319841006
		arg_26_1.duration_ = 1.27

		local var_26_0 = {
			zh = 1.266,
			ja = 1.1
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
				arg_26_0:Play319841007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			local var_29_0 = 0
			local var_29_1 = 0.05

			if var_29_0 < arg_26_1.time_ and arg_26_1.time_ <= var_29_0 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, true)

				local var_29_2 = arg_26_1:FormatText(StoryNameCfg[6].name)

				arg_26_1.leftNameTxt_.text = var_29_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_26_1.leftNameTxt_.transform)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1.leftNameTxt_.text)
				SetActive(arg_26_1.iconTrs_.gameObject, false)
				arg_26_1.callingController_:SetSelectedState("normal")

				local var_29_3 = arg_26_1:GetWordFromCfg(319841006)
				local var_29_4 = arg_26_1:FormatText(var_29_3.content)

				arg_26_1.text_.text = var_29_4

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_5 = 2
				local var_29_6 = utf8.len(var_29_4)
				local var_29_7 = var_29_5 <= 0 and var_29_1 or var_29_1 * (var_29_6 / var_29_5)

				if var_29_7 > 0 and var_29_1 < var_29_7 then
					arg_26_1.talkMaxDuration = var_29_7

					if var_29_7 + var_29_0 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_7 + var_29_0
					end
				end

				arg_26_1.text_.text = var_29_4
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319841", "319841006", "story_v_out_319841.awb") ~= 0 then
					local var_29_8 = manager.audio:GetVoiceLength("story_v_out_319841", "319841006", "story_v_out_319841.awb") / 1000

					if var_29_8 + var_29_0 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_8 + var_29_0
					end

					if var_29_3.prefab_name ~= "" and arg_26_1.actors_[var_29_3.prefab_name] ~= nil then
						local var_29_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_26_1.actors_[var_29_3.prefab_name].transform, "story_v_out_319841", "319841006", "story_v_out_319841.awb")

						arg_26_1:RecordAudio("319841006", var_29_9)
						arg_26_1:RecordAudio("319841006", var_29_9)
					else
						arg_26_1:AudioAction("play", "voice", "story_v_out_319841", "319841006", "story_v_out_319841.awb")
					end

					arg_26_1:RecordHistoryTalkVoice("story_v_out_319841", "319841006", "story_v_out_319841.awb")
				end

				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_10 = math.max(var_29_1, arg_26_1.talkMaxDuration)

			if var_29_0 <= arg_26_1.time_ and arg_26_1.time_ < var_29_0 + var_29_10 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - var_29_0) / var_29_10

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= var_29_0 + var_29_10 and arg_26_1.time_ < var_29_0 + var_29_10 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {}

		arg_26_1:InitPlayNodeList()
	end,
	Play319841007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 319841007
		arg_30_1.duration_ = 7

		SetActive(arg_30_1.tipsGo_, false)

		function arg_30_1.onSingleLineFinish_()
			arg_30_1.onSingleLineUpdate_ = nil
			arg_30_1.onSingleLineFinish_ = nil
			arg_30_1.state_ = "waiting"
		end

		function arg_30_1.playNext_(arg_32_0)
			if arg_32_0 == 1 then
				arg_30_0:Play319841008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			local var_33_0 = "D02a"

			if arg_30_1.bgs_[var_33_0] == nil then
				local var_33_1 = Object.Instantiate(arg_30_1.paintGo_)

				var_33_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_33_0)
				var_33_1.name = var_33_0
				var_33_1.transform.parent = arg_30_1.stage_.transform
				var_33_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_30_1.bgs_[var_33_0] = var_33_1
			end

			local var_33_2 = 0

			if var_33_2 < arg_30_1.time_ and arg_30_1.time_ <= var_33_2 + arg_33_0 then
				local var_33_3 = manager.ui.mainCamera.transform.localPosition
				local var_33_4 = Vector3.New(0, 0, 10) + Vector3.New(var_33_3.x, var_33_3.y, 0)
				local var_33_5 = arg_30_1.bgs_.D02a

				var_33_5.transform.localPosition = var_33_4
				var_33_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_33_6 = var_33_5:GetComponent("SpriteRenderer")

				if var_33_6 and var_33_6.sprite then
					local var_33_7 = (var_33_5.transform.localPosition - var_33_3).z
					local var_33_8 = manager.ui.mainCameraCom_
					local var_33_9 = 2 * var_33_7 * Mathf.Tan(var_33_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_33_10 = var_33_9 * var_33_8.aspect
					local var_33_11 = var_33_6.sprite.bounds.size.x
					local var_33_12 = var_33_6.sprite.bounds.size.y
					local var_33_13 = var_33_10 / var_33_11
					local var_33_14 = var_33_9 / var_33_12
					local var_33_15 = var_33_14 < var_33_13 and var_33_13 or var_33_14

					var_33_5.transform.localScale = Vector3.New(var_33_15, var_33_15, 0)
				end

				for iter_33_0, iter_33_1 in pairs(arg_30_1.bgs_) do
					if iter_33_0 ~= "D02a" then
						iter_33_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_33_16 = 0

			if var_33_16 < arg_30_1.time_ and arg_30_1.time_ <= var_33_16 + arg_33_0 then
				arg_30_1.allBtn_.enabled = false
			end

			local var_33_17 = 0.3

			if arg_30_1.time_ >= var_33_16 + var_33_17 and arg_30_1.time_ < var_33_16 + var_33_17 + arg_33_0 then
				arg_30_1.allBtn_.enabled = true
			end

			local var_33_18 = 0

			if var_33_18 < arg_30_1.time_ and arg_30_1.time_ <= var_33_18 + arg_33_0 then
				arg_30_1.mask_.enabled = true
				arg_30_1.mask_.raycastTarget = true

				arg_30_1:SetGaussion(false)
			end

			local var_33_19 = 2

			if var_33_18 <= arg_30_1.time_ and arg_30_1.time_ < var_33_18 + var_33_19 then
				local var_33_20 = (arg_30_1.time_ - var_33_18) / var_33_19
				local var_33_21 = Color.New(0, 0, 0)

				var_33_21.a = Mathf.Lerp(1, 0, var_33_20)
				arg_30_1.mask_.color = var_33_21
			end

			if arg_30_1.time_ >= var_33_18 + var_33_19 and arg_30_1.time_ < var_33_18 + var_33_19 + arg_33_0 then
				local var_33_22 = Color.New(0, 0, 0)
				local var_33_23 = 0

				arg_30_1.mask_.enabled = false
				var_33_22.a = var_33_23
				arg_30_1.mask_.color = var_33_22
			end

			local var_33_24 = 0
			local var_33_25 = 0.2

			if var_33_24 < arg_30_1.time_ and arg_30_1.time_ <= var_33_24 + arg_33_0 then
				local var_33_26 = "play"
				local var_33_27 = "music"

				arg_30_1:AudioAction(var_33_26, var_33_27, "ui_battle", "ui_battle_stopbgm", "")

				local var_33_28 = ""
				local var_33_29 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_33_29 ~= "" then
					if arg_30_1.bgmTxt_.text ~= var_33_29 and arg_30_1.bgmTxt_.text ~= "" then
						if arg_30_1.bgmTxt2_.text ~= "" then
							arg_30_1.bgmTxt_.text = arg_30_1.bgmTxt2_.text
						end

						arg_30_1.bgmTxt2_.text = var_33_29

						arg_30_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_30_1.bgmTxt_.text = var_33_29
						arg_30_1.bgmTxt2_.text = var_33_29
					end

					if arg_30_1.bgmTimer then
						arg_30_1.bgmTimer:Stop()

						arg_30_1.bgmTimer = nil
					end

					if arg_30_1.settingData.show_music_name == 1 then
						arg_30_1.musicController:SetSelectedState("show")
						arg_30_1.musicAnimator_:Play("open", 0, 0)

						if arg_30_1.settingData.music_time ~= 0 then
							arg_30_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_30_1.settingData.music_time), function()
								if arg_30_1 == nil or isNil(arg_30_1.bgmTxt_) then
									return
								end

								arg_30_1.musicController:SetSelectedState("hide")
								arg_30_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_33_30 = 0.233333333333333
			local var_33_31 = 1

			if var_33_30 < arg_30_1.time_ and arg_30_1.time_ <= var_33_30 + arg_33_0 then
				local var_33_32 = "play"
				local var_33_33 = "music"

				arg_30_1:AudioAction(var_33_32, var_33_33, "bgm_activity_3_0_story_sad", "bgm_activity_3_0_story_sad", "bgm_activity_3_0_story_sad.awb")

				local var_33_34 = ""
				local var_33_35 = manager.audio:GetAudioName("bgm_activity_3_0_story_sad", "bgm_activity_3_0_story_sad")

				if var_33_35 ~= "" then
					if arg_30_1.bgmTxt_.text ~= var_33_35 and arg_30_1.bgmTxt_.text ~= "" then
						if arg_30_1.bgmTxt2_.text ~= "" then
							arg_30_1.bgmTxt_.text = arg_30_1.bgmTxt2_.text
						end

						arg_30_1.bgmTxt2_.text = var_33_35

						arg_30_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_30_1.bgmTxt_.text = var_33_35
						arg_30_1.bgmTxt2_.text = var_33_35
					end

					if arg_30_1.bgmTimer then
						arg_30_1.bgmTimer:Stop()

						arg_30_1.bgmTimer = nil
					end

					if arg_30_1.settingData.show_music_name == 1 then
						arg_30_1.musicController:SetSelectedState("show")
						arg_30_1.musicAnimator_:Play("open", 0, 0)

						if arg_30_1.settingData.music_time ~= 0 then
							arg_30_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_30_1.settingData.music_time), function()
								if arg_30_1 == nil or isNil(arg_30_1.bgmTxt_) then
									return
								end

								arg_30_1.musicController:SetSelectedState("hide")
								arg_30_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_30_1.frameCnt_ <= 1 then
				arg_30_1.dialog_:SetActive(false)
			end

			local var_33_36 = 2
			local var_33_37 = 0.825

			if var_33_36 < arg_30_1.time_ and arg_30_1.time_ <= var_33_36 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0

				arg_30_1.dialog_:SetActive(true)

				arg_30_1.dialogCg_.alpha = 0

				local var_33_38 = LeanTween.value(arg_30_1.dialog_, 0, 1, 0.3)

				var_33_38:setOnUpdate(LuaHelper.FloatAction(function(arg_36_0)
					arg_30_1.dialogCg_.alpha = arg_36_0
				end))
				var_33_38:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_30_1.dialog_)
					var_33_38:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_30_1.duration_ = arg_30_1.duration_ + 0.3

				SetActive(arg_30_1.leftNameGo_, false)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_30_1.iconTrs_.gameObject, false)
				arg_30_1.callingController_:SetSelectedState("normal")

				local var_33_39 = arg_30_1:GetWordFromCfg(319841007)
				local var_33_40 = arg_30_1:FormatText(var_33_39.content)

				arg_30_1.text_.text = var_33_40

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_41 = 33
				local var_33_42 = utf8.len(var_33_40)
				local var_33_43 = var_33_41 <= 0 and var_33_37 or var_33_37 * (var_33_42 / var_33_41)

				if var_33_43 > 0 and var_33_37 < var_33_43 then
					arg_30_1.talkMaxDuration = var_33_43
					var_33_36 = var_33_36 + 0.3

					if var_33_43 + var_33_36 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_43 + var_33_36
					end
				end

				arg_30_1.text_.text = var_33_40
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)
				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_44 = var_33_36 + 0.3
			local var_33_45 = math.max(var_33_37, arg_30_1.talkMaxDuration)

			if var_33_44 <= arg_30_1.time_ and arg_30_1.time_ < var_33_44 + var_33_45 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_44) / var_33_45

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_44 + var_33_45 and arg_30_1.time_ < var_33_44 + var_33_45 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {}

		arg_30_1:InitPlayNodeList()
	end,
	Play319841008 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 319841008
		arg_38_1.duration_ = 5

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play319841009(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			local var_41_0 = 0
			local var_41_1 = 1.075

			if var_41_0 < arg_38_1.time_ and arg_38_1.time_ <= var_41_0 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, false)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_2 = arg_38_1:GetWordFromCfg(319841008)
				local var_41_3 = arg_38_1:FormatText(var_41_2.content)

				arg_38_1.text_.text = var_41_3

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_4 = 43
				local var_41_5 = utf8.len(var_41_3)
				local var_41_6 = var_41_4 <= 0 and var_41_1 or var_41_1 * (var_41_5 / var_41_4)

				if var_41_6 > 0 and var_41_1 < var_41_6 then
					arg_38_1.talkMaxDuration = var_41_6

					if var_41_6 + var_41_0 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_6 + var_41_0
					end
				end

				arg_38_1.text_.text = var_41_3
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)
				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_7 = math.max(var_41_1, arg_38_1.talkMaxDuration)

			if var_41_0 <= arg_38_1.time_ and arg_38_1.time_ < var_41_0 + var_41_7 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_0) / var_41_7

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_0 + var_41_7 and arg_38_1.time_ < var_41_0 + var_41_7 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play319841009 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 319841009
		arg_42_1.duration_ = 3.83

		local var_42_0 = {
			zh = 3.466,
			ja = 3.833
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
				arg_42_0:Play319841010(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			local var_45_0 = 0
			local var_45_1 = 0.325

			if var_45_0 < arg_42_1.time_ and arg_42_1.time_ <= var_45_0 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				local var_45_2 = arg_42_1:FormatText(StoryNameCfg[640].name)

				arg_42_1.leftNameTxt_.text = var_45_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_3 = arg_42_1:GetWordFromCfg(319841009)
				local var_45_4 = arg_42_1:FormatText(var_45_3.content)

				arg_42_1.text_.text = var_45_4

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_5 = 13
				local var_45_6 = utf8.len(var_45_4)
				local var_45_7 = var_45_5 <= 0 and var_45_1 or var_45_1 * (var_45_6 / var_45_5)

				if var_45_7 > 0 and var_45_1 < var_45_7 then
					arg_42_1.talkMaxDuration = var_45_7

					if var_45_7 + var_45_0 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_7 + var_45_0
					end
				end

				arg_42_1.text_.text = var_45_4
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319841", "319841009", "story_v_out_319841.awb") ~= 0 then
					local var_45_8 = manager.audio:GetVoiceLength("story_v_out_319841", "319841009", "story_v_out_319841.awb") / 1000

					if var_45_8 + var_45_0 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_8 + var_45_0
					end

					if var_45_3.prefab_name ~= "" and arg_42_1.actors_[var_45_3.prefab_name] ~= nil then
						local var_45_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_3.prefab_name].transform, "story_v_out_319841", "319841009", "story_v_out_319841.awb")

						arg_42_1:RecordAudio("319841009", var_45_9)
						arg_42_1:RecordAudio("319841009", var_45_9)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_out_319841", "319841009", "story_v_out_319841.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_out_319841", "319841009", "story_v_out_319841.awb")
				end

				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_10 = math.max(var_45_1, arg_42_1.talkMaxDuration)

			if var_45_0 <= arg_42_1.time_ and arg_42_1.time_ < var_45_0 + var_45_10 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_0) / var_45_10

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_0 + var_45_10 and arg_42_1.time_ < var_45_0 + var_45_10 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {}

		arg_42_1:InitPlayNodeList()
	end,
	Play319841010 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 319841010
		arg_46_1.duration_ = 5

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play319841011(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			local var_49_0 = 0
			local var_49_1 = 1.45

			if var_49_0 < arg_46_1.time_ and arg_46_1.time_ <= var_49_0 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, false)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_2 = arg_46_1:GetWordFromCfg(319841010)
				local var_49_3 = arg_46_1:FormatText(var_49_2.content)

				arg_46_1.text_.text = var_49_3

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_4 = 58
				local var_49_5 = utf8.len(var_49_3)
				local var_49_6 = var_49_4 <= 0 and var_49_1 or var_49_1 * (var_49_5 / var_49_4)

				if var_49_6 > 0 and var_49_1 < var_49_6 then
					arg_46_1.talkMaxDuration = var_49_6

					if var_49_6 + var_49_0 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_6 + var_49_0
					end
				end

				arg_46_1.text_.text = var_49_3
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)
				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_7 = math.max(var_49_1, arg_46_1.talkMaxDuration)

			if var_49_0 <= arg_46_1.time_ and arg_46_1.time_ < var_49_0 + var_49_7 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_0) / var_49_7

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_0 + var_49_7 and arg_46_1.time_ < var_49_0 + var_49_7 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {}

		arg_46_1:InitPlayNodeList()
	end,
	Play319841011 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 319841011
		arg_50_1.duration_ = 4.33

		local var_50_0 = {
			zh = 2.066,
			ja = 4.333
		}
		local var_50_1 = manager.audio:GetLocalizationFlag()

		if var_50_0[var_50_1] ~= nil then
			arg_50_1.duration_ = var_50_0[var_50_1]
		end

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play319841012(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_0 = "1084ui_story"

			if arg_50_1.actors_[var_53_0] == nil then
				local var_53_1 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_53_1) then
					local var_53_2 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_50_1.stage_.transform)

					var_53_2.name = var_53_0
					var_53_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_50_1.actors_[var_53_0] = var_53_2

					local var_53_3 = var_53_2:GetComponentInChildren(typeof(CharacterEffect))

					var_53_3.enabled = true

					local var_53_4 = GameObjectTools.GetOrAddComponent(var_53_2, typeof(DynamicBoneHelper))

					if var_53_4 then
						var_53_4:EnableDynamicBone(false)
					end

					arg_50_1:ShowWeapon(var_53_3.transform, false)

					arg_50_1.var_[var_53_0 .. "Animator"] = var_53_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_50_1.var_[var_53_0 .. "Animator"].applyRootMotion = true
					arg_50_1.var_[var_53_0 .. "LipSync"] = var_53_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_53_5 = arg_50_1.actors_["1084ui_story"].transform
			local var_53_6 = 0

			if var_53_6 < arg_50_1.time_ and arg_50_1.time_ <= var_53_6 + arg_53_0 then
				arg_50_1.var_.moveOldPos1084ui_story = var_53_5.localPosition

				local var_53_7 = "1084ui_story"

				arg_50_1:ShowWeapon(arg_50_1.var_[var_53_7 .. "Animator"].transform, false)
			end

			local var_53_8 = 0.001

			if var_53_6 <= arg_50_1.time_ and arg_50_1.time_ < var_53_6 + var_53_8 then
				local var_53_9 = (arg_50_1.time_ - var_53_6) / var_53_8
				local var_53_10 = Vector3.New(0, -0.97, -6)

				var_53_5.localPosition = Vector3.Lerp(arg_50_1.var_.moveOldPos1084ui_story, var_53_10, var_53_9)

				local var_53_11 = manager.ui.mainCamera.transform.position - var_53_5.position

				var_53_5.forward = Vector3.New(var_53_11.x, var_53_11.y, var_53_11.z)

				local var_53_12 = var_53_5.localEulerAngles

				var_53_12.z = 0
				var_53_12.x = 0
				var_53_5.localEulerAngles = var_53_12
			end

			if arg_50_1.time_ >= var_53_6 + var_53_8 and arg_50_1.time_ < var_53_6 + var_53_8 + arg_53_0 then
				var_53_5.localPosition = Vector3.New(0, -0.97, -6)

				local var_53_13 = manager.ui.mainCamera.transform.position - var_53_5.position

				var_53_5.forward = Vector3.New(var_53_13.x, var_53_13.y, var_53_13.z)

				local var_53_14 = var_53_5.localEulerAngles

				var_53_14.z = 0
				var_53_14.x = 0
				var_53_5.localEulerAngles = var_53_14
			end

			local var_53_15 = arg_50_1.actors_["1084ui_story"]
			local var_53_16 = 0

			if var_53_16 < arg_50_1.time_ and arg_50_1.time_ <= var_53_16 + arg_53_0 and not isNil(var_53_15) and arg_50_1.var_.characterEffect1084ui_story == nil then
				arg_50_1.var_.characterEffect1084ui_story = var_53_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_53_17 = 0.200000002980232

			if var_53_16 <= arg_50_1.time_ and arg_50_1.time_ < var_53_16 + var_53_17 and not isNil(var_53_15) then
				local var_53_18 = (arg_50_1.time_ - var_53_16) / var_53_17

				if arg_50_1.var_.characterEffect1084ui_story and not isNil(var_53_15) then
					arg_50_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_50_1.time_ >= var_53_16 + var_53_17 and arg_50_1.time_ < var_53_16 + var_53_17 + arg_53_0 and not isNil(var_53_15) and arg_50_1.var_.characterEffect1084ui_story then
				arg_50_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_53_19 = 0

			if var_53_19 < arg_50_1.time_ and arg_50_1.time_ <= var_53_19 + arg_53_0 then
				arg_50_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_53_20 = 0

			if var_53_20 < arg_50_1.time_ and arg_50_1.time_ <= var_53_20 + arg_53_0 then
				arg_50_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_53_21 = 0
			local var_53_22 = 0.225

			if var_53_21 < arg_50_1.time_ and arg_50_1.time_ <= var_53_21 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				local var_53_23 = arg_50_1:FormatText(StoryNameCfg[6].name)

				arg_50_1.leftNameTxt_.text = var_53_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_24 = arg_50_1:GetWordFromCfg(319841011)
				local var_53_25 = arg_50_1:FormatText(var_53_24.content)

				arg_50_1.text_.text = var_53_25

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_26 = 9
				local var_53_27 = utf8.len(var_53_25)
				local var_53_28 = var_53_26 <= 0 and var_53_22 or var_53_22 * (var_53_27 / var_53_26)

				if var_53_28 > 0 and var_53_22 < var_53_28 then
					arg_50_1.talkMaxDuration = var_53_28

					if var_53_28 + var_53_21 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_28 + var_53_21
					end
				end

				arg_50_1.text_.text = var_53_25
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319841", "319841011", "story_v_out_319841.awb") ~= 0 then
					local var_53_29 = manager.audio:GetVoiceLength("story_v_out_319841", "319841011", "story_v_out_319841.awb") / 1000

					if var_53_29 + var_53_21 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_29 + var_53_21
					end

					if var_53_24.prefab_name ~= "" and arg_50_1.actors_[var_53_24.prefab_name] ~= nil then
						local var_53_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_50_1.actors_[var_53_24.prefab_name].transform, "story_v_out_319841", "319841011", "story_v_out_319841.awb")

						arg_50_1:RecordAudio("319841011", var_53_30)
						arg_50_1:RecordAudio("319841011", var_53_30)
					else
						arg_50_1:AudioAction("play", "voice", "story_v_out_319841", "319841011", "story_v_out_319841.awb")
					end

					arg_50_1:RecordHistoryTalkVoice("story_v_out_319841", "319841011", "story_v_out_319841.awb")
				end

				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_31 = math.max(var_53_22, arg_50_1.talkMaxDuration)

			if var_53_21 <= arg_50_1.time_ and arg_50_1.time_ < var_53_21 + var_53_31 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_21) / var_53_31

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_21 + var_53_31 and arg_50_1.time_ < var_53_21 + var_53_31 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {
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

		arg_50_1:InitPlayNodeList()
	end,
	Play319841012 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 319841012
		arg_54_1.duration_ = 5.3

		local var_54_0 = {
			zh = 5.3,
			ja = 4.333
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
				arg_54_0:Play319841013(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = 0

			if var_57_0 < arg_54_1.time_ and arg_54_1.time_ <= var_57_0 + arg_57_0 then
				arg_54_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			local var_57_1 = 0
			local var_57_2 = 0.475

			if var_57_1 < arg_54_1.time_ and arg_54_1.time_ <= var_57_1 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				local var_57_3 = arg_54_1:FormatText(StoryNameCfg[6].name)

				arg_54_1.leftNameTxt_.text = var_57_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_4 = arg_54_1:GetWordFromCfg(319841012)
				local var_57_5 = arg_54_1:FormatText(var_57_4.content)

				arg_54_1.text_.text = var_57_5

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_6 = 19
				local var_57_7 = utf8.len(var_57_5)
				local var_57_8 = var_57_6 <= 0 and var_57_2 or var_57_2 * (var_57_7 / var_57_6)

				if var_57_8 > 0 and var_57_2 < var_57_8 then
					arg_54_1.talkMaxDuration = var_57_8

					if var_57_8 + var_57_1 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_8 + var_57_1
					end
				end

				arg_54_1.text_.text = var_57_5
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319841", "319841012", "story_v_out_319841.awb") ~= 0 then
					local var_57_9 = manager.audio:GetVoiceLength("story_v_out_319841", "319841012", "story_v_out_319841.awb") / 1000

					if var_57_9 + var_57_1 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_9 + var_57_1
					end

					if var_57_4.prefab_name ~= "" and arg_54_1.actors_[var_57_4.prefab_name] ~= nil then
						local var_57_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_4.prefab_name].transform, "story_v_out_319841", "319841012", "story_v_out_319841.awb")

						arg_54_1:RecordAudio("319841012", var_57_10)
						arg_54_1:RecordAudio("319841012", var_57_10)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_319841", "319841012", "story_v_out_319841.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_319841", "319841012", "story_v_out_319841.awb")
				end

				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_11 = math.max(var_57_2, arg_54_1.talkMaxDuration)

			if var_57_1 <= arg_54_1.time_ and arg_54_1.time_ < var_57_1 + var_57_11 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_1) / var_57_11

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_1 + var_57_11 and arg_54_1.time_ < var_57_1 + var_57_11 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {}

		arg_54_1:InitPlayNodeList()
	end,
	Play319841013 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 319841013
		arg_58_1.duration_ = 5

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play319841014(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = arg_58_1.actors_["1084ui_story"]
			local var_61_1 = 0

			if var_61_1 < arg_58_1.time_ and arg_58_1.time_ <= var_61_1 + arg_61_0 and not isNil(var_61_0) and arg_58_1.var_.characterEffect1084ui_story == nil then
				arg_58_1.var_.characterEffect1084ui_story = var_61_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_2 = 0.200000002980232

			if var_61_1 <= arg_58_1.time_ and arg_58_1.time_ < var_61_1 + var_61_2 and not isNil(var_61_0) then
				local var_61_3 = (arg_58_1.time_ - var_61_1) / var_61_2

				if arg_58_1.var_.characterEffect1084ui_story and not isNil(var_61_0) then
					local var_61_4 = Mathf.Lerp(0, 0.5, var_61_3)

					arg_58_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_58_1.var_.characterEffect1084ui_story.fillRatio = var_61_4
				end
			end

			if arg_58_1.time_ >= var_61_1 + var_61_2 and arg_58_1.time_ < var_61_1 + var_61_2 + arg_61_0 and not isNil(var_61_0) and arg_58_1.var_.characterEffect1084ui_story then
				local var_61_5 = 0.5

				arg_58_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_58_1.var_.characterEffect1084ui_story.fillRatio = var_61_5
			end

			local var_61_6 = 0
			local var_61_7 = 1.05

			if var_61_6 < arg_58_1.time_ and arg_58_1.time_ <= var_61_6 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, false)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_8 = arg_58_1:GetWordFromCfg(319841013)
				local var_61_9 = arg_58_1:FormatText(var_61_8.content)

				arg_58_1.text_.text = var_61_9

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_10 = 42
				local var_61_11 = utf8.len(var_61_9)
				local var_61_12 = var_61_10 <= 0 and var_61_7 or var_61_7 * (var_61_11 / var_61_10)

				if var_61_12 > 0 and var_61_7 < var_61_12 then
					arg_58_1.talkMaxDuration = var_61_12

					if var_61_12 + var_61_6 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_12 + var_61_6
					end
				end

				arg_58_1.text_.text = var_61_9
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)
				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_13 = math.max(var_61_7, arg_58_1.talkMaxDuration)

			if var_61_6 <= arg_58_1.time_ and arg_58_1.time_ < var_61_6 + var_61_13 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_6) / var_61_13

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_6 + var_61_13 and arg_58_1.time_ < var_61_6 + var_61_13 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play319841014 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 319841014
		arg_62_1.duration_ = 5

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play319841015(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = 0
			local var_65_1 = 1.3

			if var_65_0 < arg_62_1.time_ and arg_62_1.time_ <= var_65_0 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, false)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_2 = arg_62_1:GetWordFromCfg(319841014)
				local var_65_3 = arg_62_1:FormatText(var_65_2.content)

				arg_62_1.text_.text = var_65_3

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_4 = 52
				local var_65_5 = utf8.len(var_65_3)
				local var_65_6 = var_65_4 <= 0 and var_65_1 or var_65_1 * (var_65_5 / var_65_4)

				if var_65_6 > 0 and var_65_1 < var_65_6 then
					arg_62_1.talkMaxDuration = var_65_6

					if var_65_6 + var_65_0 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_6 + var_65_0
					end
				end

				arg_62_1.text_.text = var_65_3
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)
				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_7 = math.max(var_65_1, arg_62_1.talkMaxDuration)

			if var_65_0 <= arg_62_1.time_ and arg_62_1.time_ < var_65_0 + var_65_7 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_0) / var_65_7

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_0 + var_65_7 and arg_62_1.time_ < var_65_0 + var_65_7 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	Play319841015 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 319841015
		arg_66_1.duration_ = 3.47

		local var_66_0 = {
			zh = 3.46666666666667,
			ja = 3.06666666666667
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
				arg_66_0:Play319841016(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = arg_66_1.actors_["1084ui_story"].transform
			local var_69_1 = 0

			if var_69_1 < arg_66_1.time_ and arg_66_1.time_ <= var_69_1 + arg_69_0 then
				arg_66_1.var_.moveOldPos1084ui_story = var_69_0.localPosition
			end

			local var_69_2 = 0.001

			if var_69_1 <= arg_66_1.time_ and arg_66_1.time_ < var_69_1 + var_69_2 then
				local var_69_3 = (arg_66_1.time_ - var_69_1) / var_69_2
				local var_69_4 = Vector3.New(0, -0.97, -6)

				var_69_0.localPosition = Vector3.Lerp(arg_66_1.var_.moveOldPos1084ui_story, var_69_4, var_69_3)

				local var_69_5 = manager.ui.mainCamera.transform.position - var_69_0.position

				var_69_0.forward = Vector3.New(var_69_5.x, var_69_5.y, var_69_5.z)

				local var_69_6 = var_69_0.localEulerAngles

				var_69_6.z = 0
				var_69_6.x = 0
				var_69_0.localEulerAngles = var_69_6
			end

			if arg_66_1.time_ >= var_69_1 + var_69_2 and arg_66_1.time_ < var_69_1 + var_69_2 + arg_69_0 then
				var_69_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_69_7 = manager.ui.mainCamera.transform.position - var_69_0.position

				var_69_0.forward = Vector3.New(var_69_7.x, var_69_7.y, var_69_7.z)

				local var_69_8 = var_69_0.localEulerAngles

				var_69_8.z = 0
				var_69_8.x = 0
				var_69_0.localEulerAngles = var_69_8
			end

			local var_69_9 = arg_66_1.actors_["1084ui_story"]
			local var_69_10 = 0

			if var_69_10 < arg_66_1.time_ and arg_66_1.time_ <= var_69_10 + arg_69_0 and not isNil(var_69_9) and arg_66_1.var_.characterEffect1084ui_story == nil then
				arg_66_1.var_.characterEffect1084ui_story = var_69_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_11 = 0.200000002980232

			if var_69_10 <= arg_66_1.time_ and arg_66_1.time_ < var_69_10 + var_69_11 and not isNil(var_69_9) then
				local var_69_12 = (arg_66_1.time_ - var_69_10) / var_69_11

				if arg_66_1.var_.characterEffect1084ui_story and not isNil(var_69_9) then
					arg_66_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_66_1.time_ >= var_69_10 + var_69_11 and arg_66_1.time_ < var_69_10 + var_69_11 + arg_69_0 and not isNil(var_69_9) and arg_66_1.var_.characterEffect1084ui_story then
				arg_66_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if arg_66_1.frameCnt_ <= 1 then
				arg_66_1.dialog_:SetActive(false)
			end

			local var_69_13 = 0.466666666666667
			local var_69_14 = 0.175

			if var_69_13 < arg_66_1.time_ and arg_66_1.time_ <= var_69_13 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0

				arg_66_1.dialog_:SetActive(true)

				arg_66_1.dialogCg_.alpha = 0

				local var_69_15 = LeanTween.value(arg_66_1.dialog_, 0, 1, 0.3)

				var_69_15:setOnUpdate(LuaHelper.FloatAction(function(arg_70_0)
					arg_66_1.dialogCg_.alpha = arg_70_0
				end))
				var_69_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_66_1.dialog_)
					var_69_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_66_1.duration_ = arg_66_1.duration_ + 0.3

				SetActive(arg_66_1.leftNameGo_, true)

				local var_69_16 = arg_66_1:FormatText(StoryNameCfg[6].name)

				arg_66_1.leftNameTxt_.text = var_69_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_17 = arg_66_1:GetWordFromCfg(319841015)
				local var_69_18 = arg_66_1:FormatText(var_69_17.content)

				arg_66_1.text_.text = var_69_18

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_19 = 7
				local var_69_20 = utf8.len(var_69_18)
				local var_69_21 = var_69_19 <= 0 and var_69_14 or var_69_14 * (var_69_20 / var_69_19)

				if var_69_21 > 0 and var_69_14 < var_69_21 then
					arg_66_1.talkMaxDuration = var_69_21
					var_69_13 = var_69_13 + 0.3

					if var_69_21 + var_69_13 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_21 + var_69_13
					end
				end

				arg_66_1.text_.text = var_69_18
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319841", "319841015", "story_v_out_319841.awb") ~= 0 then
					local var_69_22 = manager.audio:GetVoiceLength("story_v_out_319841", "319841015", "story_v_out_319841.awb") / 1000

					if var_69_22 + var_69_13 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_22 + var_69_13
					end

					if var_69_17.prefab_name ~= "" and arg_66_1.actors_[var_69_17.prefab_name] ~= nil then
						local var_69_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_17.prefab_name].transform, "story_v_out_319841", "319841015", "story_v_out_319841.awb")

						arg_66_1:RecordAudio("319841015", var_69_23)
						arg_66_1:RecordAudio("319841015", var_69_23)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_319841", "319841015", "story_v_out_319841.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_319841", "319841015", "story_v_out_319841.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_24 = var_69_13 + 0.3
			local var_69_25 = math.max(var_69_14, arg_66_1.talkMaxDuration)

			if var_69_24 <= arg_66_1.time_ and arg_66_1.time_ < var_69_24 + var_69_25 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_24) / var_69_25

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_24 + var_69_25 and arg_66_1.time_ < var_69_24 + var_69_25 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {
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

		arg_66_1:InitPlayNodeList()
	end,
	Play319841016 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 319841016
		arg_72_1.duration_ = 5

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play319841017(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = arg_72_1.actors_["1084ui_story"]
			local var_75_1 = 0

			if var_75_1 < arg_72_1.time_ and arg_72_1.time_ <= var_75_1 + arg_75_0 and not isNil(var_75_0) and arg_72_1.var_.characterEffect1084ui_story == nil then
				arg_72_1.var_.characterEffect1084ui_story = var_75_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_2 = 0.200000002980232

			if var_75_1 <= arg_72_1.time_ and arg_72_1.time_ < var_75_1 + var_75_2 and not isNil(var_75_0) then
				local var_75_3 = (arg_72_1.time_ - var_75_1) / var_75_2

				if arg_72_1.var_.characterEffect1084ui_story and not isNil(var_75_0) then
					local var_75_4 = Mathf.Lerp(0, 0.5, var_75_3)

					arg_72_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_72_1.var_.characterEffect1084ui_story.fillRatio = var_75_4
				end
			end

			if arg_72_1.time_ >= var_75_1 + var_75_2 and arg_72_1.time_ < var_75_1 + var_75_2 + arg_75_0 and not isNil(var_75_0) and arg_72_1.var_.characterEffect1084ui_story then
				local var_75_5 = 0.5

				arg_72_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_72_1.var_.characterEffect1084ui_story.fillRatio = var_75_5
			end

			local var_75_6 = arg_72_1.actors_["1084ui_story"].transform
			local var_75_7 = 0

			if var_75_7 < arg_72_1.time_ and arg_72_1.time_ <= var_75_7 + arg_75_0 then
				arg_72_1.var_.moveOldPos1084ui_story = var_75_6.localPosition
			end

			local var_75_8 = 0.001

			if var_75_7 <= arg_72_1.time_ and arg_72_1.time_ < var_75_7 + var_75_8 then
				local var_75_9 = (arg_72_1.time_ - var_75_7) / var_75_8
				local var_75_10 = Vector3.New(0, 100, 0)

				var_75_6.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos1084ui_story, var_75_10, var_75_9)

				local var_75_11 = manager.ui.mainCamera.transform.position - var_75_6.position

				var_75_6.forward = Vector3.New(var_75_11.x, var_75_11.y, var_75_11.z)

				local var_75_12 = var_75_6.localEulerAngles

				var_75_12.z = 0
				var_75_12.x = 0
				var_75_6.localEulerAngles = var_75_12
			end

			if arg_72_1.time_ >= var_75_7 + var_75_8 and arg_72_1.time_ < var_75_7 + var_75_8 + arg_75_0 then
				var_75_6.localPosition = Vector3.New(0, 100, 0)

				local var_75_13 = manager.ui.mainCamera.transform.position - var_75_6.position

				var_75_6.forward = Vector3.New(var_75_13.x, var_75_13.y, var_75_13.z)

				local var_75_14 = var_75_6.localEulerAngles

				var_75_14.z = 0
				var_75_14.x = 0
				var_75_6.localEulerAngles = var_75_14
			end

			local var_75_15 = 0
			local var_75_16 = 1

			if var_75_15 < arg_72_1.time_ and arg_72_1.time_ <= var_75_15 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, false)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_17 = arg_72_1:GetWordFromCfg(319841016)
				local var_75_18 = arg_72_1:FormatText(var_75_17.content)

				arg_72_1.text_.text = var_75_18

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_19 = 40
				local var_75_20 = utf8.len(var_75_18)
				local var_75_21 = var_75_19 <= 0 and var_75_16 or var_75_16 * (var_75_20 / var_75_19)

				if var_75_21 > 0 and var_75_16 < var_75_21 then
					arg_72_1.talkMaxDuration = var_75_21

					if var_75_21 + var_75_15 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_21 + var_75_15
					end
				end

				arg_72_1.text_.text = var_75_18
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)
				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_22 = math.max(var_75_16, arg_72_1.talkMaxDuration)

			if var_75_15 <= arg_72_1.time_ and arg_72_1.time_ < var_75_15 + var_75_22 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_15) / var_75_22

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_15 + var_75_22 and arg_72_1.time_ < var_75_15 + var_75_22 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {
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

		arg_72_1:InitPlayNodeList()
	end,
	Play319841017 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 319841017
		arg_76_1.duration_ = 7.93

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play319841018(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = "ST74"

			if arg_76_1.bgs_[var_79_0] == nil then
				local var_79_1 = Object.Instantiate(arg_76_1.paintGo_)

				var_79_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_79_0)
				var_79_1.name = var_79_0
				var_79_1.transform.parent = arg_76_1.stage_.transform
				var_79_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_76_1.bgs_[var_79_0] = var_79_1
			end

			local var_79_2 = 1.225

			if var_79_2 < arg_76_1.time_ and arg_76_1.time_ <= var_79_2 + arg_79_0 then
				local var_79_3 = manager.ui.mainCamera.transform.localPosition
				local var_79_4 = Vector3.New(0, 0, 10) + Vector3.New(var_79_3.x, var_79_3.y, 0)
				local var_79_5 = arg_76_1.bgs_.ST74

				var_79_5.transform.localPosition = var_79_4
				var_79_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_79_6 = var_79_5:GetComponent("SpriteRenderer")

				if var_79_6 and var_79_6.sprite then
					local var_79_7 = (var_79_5.transform.localPosition - var_79_3).z
					local var_79_8 = manager.ui.mainCameraCom_
					local var_79_9 = 2 * var_79_7 * Mathf.Tan(var_79_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_79_10 = var_79_9 * var_79_8.aspect
					local var_79_11 = var_79_6.sprite.bounds.size.x
					local var_79_12 = var_79_6.sprite.bounds.size.y
					local var_79_13 = var_79_10 / var_79_11
					local var_79_14 = var_79_9 / var_79_12
					local var_79_15 = var_79_14 < var_79_13 and var_79_13 or var_79_14

					var_79_5.transform.localScale = Vector3.New(var_79_15, var_79_15, 0)
				end

				for iter_79_0, iter_79_1 in pairs(arg_76_1.bgs_) do
					if iter_79_0 ~= "ST74" then
						iter_79_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_79_16 = 0

			if var_79_16 < arg_76_1.time_ and arg_76_1.time_ <= var_79_16 + arg_79_0 then
				arg_76_1.allBtn_.enabled = false
			end

			local var_79_17 = 0.3

			if arg_76_1.time_ >= var_79_16 + var_79_17 and arg_76_1.time_ < var_79_16 + var_79_17 + arg_79_0 then
				arg_76_1.allBtn_.enabled = true
			end

			local var_79_18 = 0

			if var_79_18 < arg_76_1.time_ and arg_76_1.time_ <= var_79_18 + arg_79_0 then
				arg_76_1.mask_.enabled = true
				arg_76_1.mask_.raycastTarget = true

				arg_76_1:SetGaussion(false)
			end

			local var_79_19 = 1.225

			if var_79_18 <= arg_76_1.time_ and arg_76_1.time_ < var_79_18 + var_79_19 then
				local var_79_20 = (arg_76_1.time_ - var_79_18) / var_79_19
				local var_79_21 = Color.New(0, 0, 0)

				var_79_21.a = Mathf.Lerp(0, 1, var_79_20)
				arg_76_1.mask_.color = var_79_21
			end

			if arg_76_1.time_ >= var_79_18 + var_79_19 and arg_76_1.time_ < var_79_18 + var_79_19 + arg_79_0 then
				local var_79_22 = Color.New(0, 0, 0)

				var_79_22.a = 1
				arg_76_1.mask_.color = var_79_22
			end

			local var_79_23 = 1.225

			if var_79_23 < arg_76_1.time_ and arg_76_1.time_ <= var_79_23 + arg_79_0 then
				arg_76_1.mask_.enabled = true
				arg_76_1.mask_.raycastTarget = true

				arg_76_1:SetGaussion(false)
			end

			local var_79_24 = 2

			if var_79_23 <= arg_76_1.time_ and arg_76_1.time_ < var_79_23 + var_79_24 then
				local var_79_25 = (arg_76_1.time_ - var_79_23) / var_79_24
				local var_79_26 = Color.New(0, 0, 0)

				var_79_26.a = Mathf.Lerp(1, 0, var_79_25)
				arg_76_1.mask_.color = var_79_26
			end

			if arg_76_1.time_ >= var_79_23 + var_79_24 and arg_76_1.time_ < var_79_23 + var_79_24 + arg_79_0 then
				local var_79_27 = Color.New(0, 0, 0)
				local var_79_28 = 0

				arg_76_1.mask_.enabled = false
				var_79_27.a = var_79_28
				arg_76_1.mask_.color = var_79_27
			end

			if arg_76_1.frameCnt_ <= 1 then
				arg_76_1.dialog_:SetActive(false)
			end

			local var_79_29 = 2.93333333333333
			local var_79_30 = 1.225

			if var_79_29 < arg_76_1.time_ and arg_76_1.time_ <= var_79_29 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0

				arg_76_1.dialog_:SetActive(true)

				arg_76_1.dialogCg_.alpha = 0

				local var_79_31 = LeanTween.value(arg_76_1.dialog_, 0, 1, 0.3)

				var_79_31:setOnUpdate(LuaHelper.FloatAction(function(arg_80_0)
					arg_76_1.dialogCg_.alpha = arg_80_0
				end))
				var_79_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_76_1.dialog_)
					var_79_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_76_1.duration_ = arg_76_1.duration_ + 0.3

				SetActive(arg_76_1.leftNameGo_, false)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_32 = arg_76_1:GetWordFromCfg(319841017)
				local var_79_33 = arg_76_1:FormatText(var_79_32.content)

				arg_76_1.text_.text = var_79_33

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_34 = 49
				local var_79_35 = utf8.len(var_79_33)
				local var_79_36 = var_79_34 <= 0 and var_79_30 or var_79_30 * (var_79_35 / var_79_34)

				if var_79_36 > 0 and var_79_30 < var_79_36 then
					arg_76_1.talkMaxDuration = var_79_36
					var_79_29 = var_79_29 + 0.3

					if var_79_36 + var_79_29 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_36 + var_79_29
					end
				end

				arg_76_1.text_.text = var_79_33
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)
				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_37 = var_79_29 + 0.3
			local var_79_38 = math.max(var_79_30, arg_76_1.talkMaxDuration)

			if var_79_37 <= arg_76_1.time_ and arg_76_1.time_ < var_79_37 + var_79_38 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_37) / var_79_38

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_37 + var_79_38 and arg_76_1.time_ < var_79_37 + var_79_38 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play319841018 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 319841018
		arg_82_1.duration_ = 2.57

		local var_82_0 = {
			zh = 2.433,
			ja = 2.566
		}
		local var_82_1 = manager.audio:GetLocalizationFlag()

		if var_82_0[var_82_1] ~= nil then
			arg_82_1.duration_ = var_82_0[var_82_1]
		end

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play319841019(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = arg_82_1.actors_["1084ui_story"].transform
			local var_85_1 = 0

			if var_85_1 < arg_82_1.time_ and arg_82_1.time_ <= var_85_1 + arg_85_0 then
				arg_82_1.var_.moveOldPos1084ui_story = var_85_0.localPosition
			end

			local var_85_2 = 0.001

			if var_85_1 <= arg_82_1.time_ and arg_82_1.time_ < var_85_1 + var_85_2 then
				local var_85_3 = (arg_82_1.time_ - var_85_1) / var_85_2
				local var_85_4 = Vector3.New(0, -0.97, -6)

				var_85_0.localPosition = Vector3.Lerp(arg_82_1.var_.moveOldPos1084ui_story, var_85_4, var_85_3)

				local var_85_5 = manager.ui.mainCamera.transform.position - var_85_0.position

				var_85_0.forward = Vector3.New(var_85_5.x, var_85_5.y, var_85_5.z)

				local var_85_6 = var_85_0.localEulerAngles

				var_85_6.z = 0
				var_85_6.x = 0
				var_85_0.localEulerAngles = var_85_6
			end

			if arg_82_1.time_ >= var_85_1 + var_85_2 and arg_82_1.time_ < var_85_1 + var_85_2 + arg_85_0 then
				var_85_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_85_7 = manager.ui.mainCamera.transform.position - var_85_0.position

				var_85_0.forward = Vector3.New(var_85_7.x, var_85_7.y, var_85_7.z)

				local var_85_8 = var_85_0.localEulerAngles

				var_85_8.z = 0
				var_85_8.x = 0
				var_85_0.localEulerAngles = var_85_8
			end

			local var_85_9 = arg_82_1.actors_["1084ui_story"]
			local var_85_10 = 0

			if var_85_10 < arg_82_1.time_ and arg_82_1.time_ <= var_85_10 + arg_85_0 and not isNil(var_85_9) and arg_82_1.var_.characterEffect1084ui_story == nil then
				arg_82_1.var_.characterEffect1084ui_story = var_85_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_11 = 0.200000002980232

			if var_85_10 <= arg_82_1.time_ and arg_82_1.time_ < var_85_10 + var_85_11 and not isNil(var_85_9) then
				local var_85_12 = (arg_82_1.time_ - var_85_10) / var_85_11

				if arg_82_1.var_.characterEffect1084ui_story and not isNil(var_85_9) then
					arg_82_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_82_1.time_ >= var_85_10 + var_85_11 and arg_82_1.time_ < var_85_10 + var_85_11 + arg_85_0 and not isNil(var_85_9) and arg_82_1.var_.characterEffect1084ui_story then
				arg_82_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_85_13 = 0

			if var_85_13 < arg_82_1.time_ and arg_82_1.time_ <= var_85_13 + arg_85_0 then
				arg_82_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_2")
			end

			local var_85_14 = 0

			if var_85_14 < arg_82_1.time_ and arg_82_1.time_ <= var_85_14 + arg_85_0 then
				arg_82_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_85_15 = 0
			local var_85_16 = 0.225

			if var_85_15 < arg_82_1.time_ and arg_82_1.time_ <= var_85_15 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				local var_85_17 = arg_82_1:FormatText(StoryNameCfg[6].name)

				arg_82_1.leftNameTxt_.text = var_85_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_18 = arg_82_1:GetWordFromCfg(319841018)
				local var_85_19 = arg_82_1:FormatText(var_85_18.content)

				arg_82_1.text_.text = var_85_19

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_20 = 9
				local var_85_21 = utf8.len(var_85_19)
				local var_85_22 = var_85_20 <= 0 and var_85_16 or var_85_16 * (var_85_21 / var_85_20)

				if var_85_22 > 0 and var_85_16 < var_85_22 then
					arg_82_1.talkMaxDuration = var_85_22

					if var_85_22 + var_85_15 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_22 + var_85_15
					end
				end

				arg_82_1.text_.text = var_85_19
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319841", "319841018", "story_v_out_319841.awb") ~= 0 then
					local var_85_23 = manager.audio:GetVoiceLength("story_v_out_319841", "319841018", "story_v_out_319841.awb") / 1000

					if var_85_23 + var_85_15 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_23 + var_85_15
					end

					if var_85_18.prefab_name ~= "" and arg_82_1.actors_[var_85_18.prefab_name] ~= nil then
						local var_85_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_18.prefab_name].transform, "story_v_out_319841", "319841018", "story_v_out_319841.awb")

						arg_82_1:RecordAudio("319841018", var_85_24)
						arg_82_1:RecordAudio("319841018", var_85_24)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_319841", "319841018", "story_v_out_319841.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_319841", "319841018", "story_v_out_319841.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_25 = math.max(var_85_16, arg_82_1.talkMaxDuration)

			if var_85_15 <= arg_82_1.time_ and arg_82_1.time_ < var_85_15 + var_85_25 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_15) / var_85_25

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_15 + var_85_25 and arg_82_1.time_ < var_85_15 + var_85_25 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {
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

		arg_82_1:InitPlayNodeList()
	end,
	Play319841019 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 319841019
		arg_86_1.duration_ = 5

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play319841020(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = arg_86_1.actors_["1084ui_story"]
			local var_89_1 = 0

			if var_89_1 < arg_86_1.time_ and arg_86_1.time_ <= var_89_1 + arg_89_0 and not isNil(var_89_0) and arg_86_1.var_.characterEffect1084ui_story == nil then
				arg_86_1.var_.characterEffect1084ui_story = var_89_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_2 = 0.200000002980232

			if var_89_1 <= arg_86_1.time_ and arg_86_1.time_ < var_89_1 + var_89_2 and not isNil(var_89_0) then
				local var_89_3 = (arg_86_1.time_ - var_89_1) / var_89_2

				if arg_86_1.var_.characterEffect1084ui_story and not isNil(var_89_0) then
					local var_89_4 = Mathf.Lerp(0, 0.5, var_89_3)

					arg_86_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_86_1.var_.characterEffect1084ui_story.fillRatio = var_89_4
				end
			end

			if arg_86_1.time_ >= var_89_1 + var_89_2 and arg_86_1.time_ < var_89_1 + var_89_2 + arg_89_0 and not isNil(var_89_0) and arg_86_1.var_.characterEffect1084ui_story then
				local var_89_5 = 0.5

				arg_86_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_86_1.var_.characterEffect1084ui_story.fillRatio = var_89_5
			end

			local var_89_6 = 0
			local var_89_7 = 0.575

			if var_89_6 < arg_86_1.time_ and arg_86_1.time_ <= var_89_6 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, false)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_8 = arg_86_1:GetWordFromCfg(319841019)
				local var_89_9 = arg_86_1:FormatText(var_89_8.content)

				arg_86_1.text_.text = var_89_9

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_10 = 23
				local var_89_11 = utf8.len(var_89_9)
				local var_89_12 = var_89_10 <= 0 and var_89_7 or var_89_7 * (var_89_11 / var_89_10)

				if var_89_12 > 0 and var_89_7 < var_89_12 then
					arg_86_1.talkMaxDuration = var_89_12

					if var_89_12 + var_89_6 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_12 + var_89_6
					end
				end

				arg_86_1.text_.text = var_89_9
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)
				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_13 = math.max(var_89_7, arg_86_1.talkMaxDuration)

			if var_89_6 <= arg_86_1.time_ and arg_86_1.time_ < var_89_6 + var_89_13 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_6) / var_89_13

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_6 + var_89_13 and arg_86_1.time_ < var_89_6 + var_89_13 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play319841020 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 319841020
		arg_90_1.duration_ = 5.3

		local var_90_0 = {
			zh = 3.233,
			ja = 5.3
		}
		local var_90_1 = manager.audio:GetLocalizationFlag()

		if var_90_0[var_90_1] ~= nil then
			arg_90_1.duration_ = var_90_0[var_90_1]
		end

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play319841021(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = "10058ui_story"

			if arg_90_1.actors_[var_93_0] == nil then
				local var_93_1 = Asset.Load("Char/" .. "10058ui_story")

				if not isNil(var_93_1) then
					local var_93_2 = Object.Instantiate(Asset.Load("Char/" .. "10058ui_story"), arg_90_1.stage_.transform)

					var_93_2.name = var_93_0
					var_93_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_90_1.actors_[var_93_0] = var_93_2

					local var_93_3 = var_93_2:GetComponentInChildren(typeof(CharacterEffect))

					var_93_3.enabled = true

					local var_93_4 = GameObjectTools.GetOrAddComponent(var_93_2, typeof(DynamicBoneHelper))

					if var_93_4 then
						var_93_4:EnableDynamicBone(false)
					end

					arg_90_1:ShowWeapon(var_93_3.transform, false)

					arg_90_1.var_[var_93_0 .. "Animator"] = var_93_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_90_1.var_[var_93_0 .. "Animator"].applyRootMotion = true
					arg_90_1.var_[var_93_0 .. "LipSync"] = var_93_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_93_5 = arg_90_1.actors_["10058ui_story"].transform
			local var_93_6 = 0

			if var_93_6 < arg_90_1.time_ and arg_90_1.time_ <= var_93_6 + arg_93_0 then
				arg_90_1.var_.moveOldPos10058ui_story = var_93_5.localPosition
			end

			local var_93_7 = 0.001

			if var_93_6 <= arg_90_1.time_ and arg_90_1.time_ < var_93_6 + var_93_7 then
				local var_93_8 = (arg_90_1.time_ - var_93_6) / var_93_7
				local var_93_9 = Vector3.New(0.7, -0.98, -6.1)

				var_93_5.localPosition = Vector3.Lerp(arg_90_1.var_.moveOldPos10058ui_story, var_93_9, var_93_8)

				local var_93_10 = manager.ui.mainCamera.transform.position - var_93_5.position

				var_93_5.forward = Vector3.New(var_93_10.x, var_93_10.y, var_93_10.z)

				local var_93_11 = var_93_5.localEulerAngles

				var_93_11.z = 0
				var_93_11.x = 0
				var_93_5.localEulerAngles = var_93_11
			end

			if arg_90_1.time_ >= var_93_6 + var_93_7 and arg_90_1.time_ < var_93_6 + var_93_7 + arg_93_0 then
				var_93_5.localPosition = Vector3.New(0.7, -0.98, -6.1)

				local var_93_12 = manager.ui.mainCamera.transform.position - var_93_5.position

				var_93_5.forward = Vector3.New(var_93_12.x, var_93_12.y, var_93_12.z)

				local var_93_13 = var_93_5.localEulerAngles

				var_93_13.z = 0
				var_93_13.x = 0
				var_93_5.localEulerAngles = var_93_13
			end

			local var_93_14 = arg_90_1.actors_["10058ui_story"]
			local var_93_15 = 0

			if var_93_15 < arg_90_1.time_ and arg_90_1.time_ <= var_93_15 + arg_93_0 and not isNil(var_93_14) and arg_90_1.var_.characterEffect10058ui_story == nil then
				arg_90_1.var_.characterEffect10058ui_story = var_93_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_16 = 0.200000002980232

			if var_93_15 <= arg_90_1.time_ and arg_90_1.time_ < var_93_15 + var_93_16 and not isNil(var_93_14) then
				local var_93_17 = (arg_90_1.time_ - var_93_15) / var_93_16

				if arg_90_1.var_.characterEffect10058ui_story and not isNil(var_93_14) then
					arg_90_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_90_1.time_ >= var_93_15 + var_93_16 and arg_90_1.time_ < var_93_15 + var_93_16 + arg_93_0 and not isNil(var_93_14) and arg_90_1.var_.characterEffect10058ui_story then
				arg_90_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_93_18 = 0

			if var_93_18 < arg_90_1.time_ and arg_90_1.time_ <= var_93_18 + arg_93_0 then
				arg_90_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_93_19 = 0

			if var_93_19 < arg_90_1.time_ and arg_90_1.time_ <= var_93_19 + arg_93_0 then
				arg_90_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_93_20 = arg_90_1.actors_["1084ui_story"].transform
			local var_93_21 = 0

			if var_93_21 < arg_90_1.time_ and arg_90_1.time_ <= var_93_21 + arg_93_0 then
				arg_90_1.var_.moveOldPos1084ui_story = var_93_20.localPosition
			end

			local var_93_22 = 0.001

			if var_93_21 <= arg_90_1.time_ and arg_90_1.time_ < var_93_21 + var_93_22 then
				local var_93_23 = (arg_90_1.time_ - var_93_21) / var_93_22
				local var_93_24 = Vector3.New(-0.7, -0.97, -6)

				var_93_20.localPosition = Vector3.Lerp(arg_90_1.var_.moveOldPos1084ui_story, var_93_24, var_93_23)

				local var_93_25 = manager.ui.mainCamera.transform.position - var_93_20.position

				var_93_20.forward = Vector3.New(var_93_25.x, var_93_25.y, var_93_25.z)

				local var_93_26 = var_93_20.localEulerAngles

				var_93_26.z = 0
				var_93_26.x = 0
				var_93_20.localEulerAngles = var_93_26
			end

			if arg_90_1.time_ >= var_93_21 + var_93_22 and arg_90_1.time_ < var_93_21 + var_93_22 + arg_93_0 then
				var_93_20.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_93_27 = manager.ui.mainCamera.transform.position - var_93_20.position

				var_93_20.forward = Vector3.New(var_93_27.x, var_93_27.y, var_93_27.z)

				local var_93_28 = var_93_20.localEulerAngles

				var_93_28.z = 0
				var_93_28.x = 0
				var_93_20.localEulerAngles = var_93_28
			end

			local var_93_29 = 0
			local var_93_30 = 0.425

			if var_93_29 < arg_90_1.time_ and arg_90_1.time_ <= var_93_29 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				local var_93_31 = arg_90_1:FormatText(StoryNameCfg[471].name)

				arg_90_1.leftNameTxt_.text = var_93_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_32 = arg_90_1:GetWordFromCfg(319841020)
				local var_93_33 = arg_90_1:FormatText(var_93_32.content)

				arg_90_1.text_.text = var_93_33

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_34 = 17
				local var_93_35 = utf8.len(var_93_33)
				local var_93_36 = var_93_34 <= 0 and var_93_30 or var_93_30 * (var_93_35 / var_93_34)

				if var_93_36 > 0 and var_93_30 < var_93_36 then
					arg_90_1.talkMaxDuration = var_93_36

					if var_93_36 + var_93_29 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_36 + var_93_29
					end
				end

				arg_90_1.text_.text = var_93_33
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319841", "319841020", "story_v_out_319841.awb") ~= 0 then
					local var_93_37 = manager.audio:GetVoiceLength("story_v_out_319841", "319841020", "story_v_out_319841.awb") / 1000

					if var_93_37 + var_93_29 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_37 + var_93_29
					end

					if var_93_32.prefab_name ~= "" and arg_90_1.actors_[var_93_32.prefab_name] ~= nil then
						local var_93_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_32.prefab_name].transform, "story_v_out_319841", "319841020", "story_v_out_319841.awb")

						arg_90_1:RecordAudio("319841020", var_93_38)
						arg_90_1:RecordAudio("319841020", var_93_38)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_319841", "319841020", "story_v_out_319841.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_319841", "319841020", "story_v_out_319841.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_39 = math.max(var_93_30, arg_90_1.talkMaxDuration)

			if var_93_29 <= arg_90_1.time_ and arg_90_1.time_ < var_93_29 + var_93_39 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_29) / var_93_39

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_29 + var_93_39 and arg_90_1.time_ < var_93_29 + var_93_39 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
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

		arg_90_1:InitPlayNodeList()
	end,
	Play319841021 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 319841021
		arg_94_1.duration_ = 4.2

		local var_94_0 = {
			zh = 4.2,
			ja = 3.133
		}
		local var_94_1 = manager.audio:GetLocalizationFlag()

		if var_94_0[var_94_1] ~= nil then
			arg_94_1.duration_ = var_94_0[var_94_1]
		end

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play319841022(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = 0
			local var_97_1 = 0.425

			if var_97_0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_0 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				local var_97_2 = arg_94_1:FormatText(StoryNameCfg[471].name)

				arg_94_1.leftNameTxt_.text = var_97_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_3 = arg_94_1:GetWordFromCfg(319841021)
				local var_97_4 = arg_94_1:FormatText(var_97_3.content)

				arg_94_1.text_.text = var_97_4

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_5 = 17
				local var_97_6 = utf8.len(var_97_4)
				local var_97_7 = var_97_5 <= 0 and var_97_1 or var_97_1 * (var_97_6 / var_97_5)

				if var_97_7 > 0 and var_97_1 < var_97_7 then
					arg_94_1.talkMaxDuration = var_97_7

					if var_97_7 + var_97_0 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_7 + var_97_0
					end
				end

				arg_94_1.text_.text = var_97_4
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319841", "319841021", "story_v_out_319841.awb") ~= 0 then
					local var_97_8 = manager.audio:GetVoiceLength("story_v_out_319841", "319841021", "story_v_out_319841.awb") / 1000

					if var_97_8 + var_97_0 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_8 + var_97_0
					end

					if var_97_3.prefab_name ~= "" and arg_94_1.actors_[var_97_3.prefab_name] ~= nil then
						local var_97_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_3.prefab_name].transform, "story_v_out_319841", "319841021", "story_v_out_319841.awb")

						arg_94_1:RecordAudio("319841021", var_97_9)
						arg_94_1:RecordAudio("319841021", var_97_9)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_319841", "319841021", "story_v_out_319841.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_319841", "319841021", "story_v_out_319841.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_10 = math.max(var_97_1, arg_94_1.talkMaxDuration)

			if var_97_0 <= arg_94_1.time_ and arg_94_1.time_ < var_97_0 + var_97_10 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_0) / var_97_10

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_0 + var_97_10 and arg_94_1.time_ < var_97_0 + var_97_10 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play319841022 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 319841022
		arg_98_1.duration_ = 5

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play319841023(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = arg_98_1.actors_["10058ui_story"]
			local var_101_1 = 0

			if var_101_1 < arg_98_1.time_ and arg_98_1.time_ <= var_101_1 + arg_101_0 and not isNil(var_101_0) and arg_98_1.var_.characterEffect10058ui_story == nil then
				arg_98_1.var_.characterEffect10058ui_story = var_101_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_2 = 0.200000002980232

			if var_101_1 <= arg_98_1.time_ and arg_98_1.time_ < var_101_1 + var_101_2 and not isNil(var_101_0) then
				local var_101_3 = (arg_98_1.time_ - var_101_1) / var_101_2

				if arg_98_1.var_.characterEffect10058ui_story and not isNil(var_101_0) then
					local var_101_4 = Mathf.Lerp(0, 0.5, var_101_3)

					arg_98_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_98_1.var_.characterEffect10058ui_story.fillRatio = var_101_4
				end
			end

			if arg_98_1.time_ >= var_101_1 + var_101_2 and arg_98_1.time_ < var_101_1 + var_101_2 + arg_101_0 and not isNil(var_101_0) and arg_98_1.var_.characterEffect10058ui_story then
				local var_101_5 = 0.5

				arg_98_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_98_1.var_.characterEffect10058ui_story.fillRatio = var_101_5
			end

			local var_101_6 = 0
			local var_101_7 = 0.6

			if var_101_6 < arg_98_1.time_ and arg_98_1.time_ <= var_101_6 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, false)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_8 = arg_98_1:GetWordFromCfg(319841022)
				local var_101_9 = arg_98_1:FormatText(var_101_8.content)

				arg_98_1.text_.text = var_101_9

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_10 = 24
				local var_101_11 = utf8.len(var_101_9)
				local var_101_12 = var_101_10 <= 0 and var_101_7 or var_101_7 * (var_101_11 / var_101_10)

				if var_101_12 > 0 and var_101_7 < var_101_12 then
					arg_98_1.talkMaxDuration = var_101_12

					if var_101_12 + var_101_6 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_12 + var_101_6
					end
				end

				arg_98_1.text_.text = var_101_9
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)
				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_13 = math.max(var_101_7, arg_98_1.talkMaxDuration)

			if var_101_6 <= arg_98_1.time_ and arg_98_1.time_ < var_101_6 + var_101_13 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_6) / var_101_13

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_6 + var_101_13 and arg_98_1.time_ < var_101_6 + var_101_13 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play319841023 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 319841023
		arg_102_1.duration_ = 10.07

		local var_102_0 = {
			zh = 7.866,
			ja = 10.066
		}
		local var_102_1 = manager.audio:GetLocalizationFlag()

		if var_102_0[var_102_1] ~= nil then
			arg_102_1.duration_ = var_102_0[var_102_1]
		end

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play319841024(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = arg_102_1.actors_["10058ui_story"]
			local var_105_1 = 0

			if var_105_1 < arg_102_1.time_ and arg_102_1.time_ <= var_105_1 + arg_105_0 and not isNil(var_105_0) and arg_102_1.var_.characterEffect10058ui_story == nil then
				arg_102_1.var_.characterEffect10058ui_story = var_105_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_2 = 0.200000002980232

			if var_105_1 <= arg_102_1.time_ and arg_102_1.time_ < var_105_1 + var_105_2 and not isNil(var_105_0) then
				local var_105_3 = (arg_102_1.time_ - var_105_1) / var_105_2

				if arg_102_1.var_.characterEffect10058ui_story and not isNil(var_105_0) then
					arg_102_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_102_1.time_ >= var_105_1 + var_105_2 and arg_102_1.time_ < var_105_1 + var_105_2 + arg_105_0 and not isNil(var_105_0) and arg_102_1.var_.characterEffect10058ui_story then
				arg_102_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_105_4 = 0
			local var_105_5 = 0.85

			if var_105_4 < arg_102_1.time_ and arg_102_1.time_ <= var_105_4 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				local var_105_6 = arg_102_1:FormatText(StoryNameCfg[471].name)

				arg_102_1.leftNameTxt_.text = var_105_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_7 = arg_102_1:GetWordFromCfg(319841023)
				local var_105_8 = arg_102_1:FormatText(var_105_7.content)

				arg_102_1.text_.text = var_105_8

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_9 = 34
				local var_105_10 = utf8.len(var_105_8)
				local var_105_11 = var_105_9 <= 0 and var_105_5 or var_105_5 * (var_105_10 / var_105_9)

				if var_105_11 > 0 and var_105_5 < var_105_11 then
					arg_102_1.talkMaxDuration = var_105_11

					if var_105_11 + var_105_4 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_11 + var_105_4
					end
				end

				arg_102_1.text_.text = var_105_8
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319841", "319841023", "story_v_out_319841.awb") ~= 0 then
					local var_105_12 = manager.audio:GetVoiceLength("story_v_out_319841", "319841023", "story_v_out_319841.awb") / 1000

					if var_105_12 + var_105_4 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_12 + var_105_4
					end

					if var_105_7.prefab_name ~= "" and arg_102_1.actors_[var_105_7.prefab_name] ~= nil then
						local var_105_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_7.prefab_name].transform, "story_v_out_319841", "319841023", "story_v_out_319841.awb")

						arg_102_1:RecordAudio("319841023", var_105_13)
						arg_102_1:RecordAudio("319841023", var_105_13)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_319841", "319841023", "story_v_out_319841.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_319841", "319841023", "story_v_out_319841.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_14 = math.max(var_105_5, arg_102_1.talkMaxDuration)

			if var_105_4 <= arg_102_1.time_ and arg_102_1.time_ < var_105_4 + var_105_14 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_4) / var_105_14

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_4 + var_105_14 and arg_102_1.time_ < var_105_4 + var_105_14 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play319841024 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 319841024
		arg_106_1.duration_ = 7.7

		local var_106_0 = {
			zh = 3.733,
			ja = 7.7
		}
		local var_106_1 = manager.audio:GetLocalizationFlag()

		if var_106_0[var_106_1] ~= nil then
			arg_106_1.duration_ = var_106_0[var_106_1]
		end

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play319841025(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = arg_106_1.actors_["10058ui_story"].transform
			local var_109_1 = 0

			if var_109_1 < arg_106_1.time_ and arg_106_1.time_ <= var_109_1 + arg_109_0 then
				arg_106_1.var_.moveOldPos10058ui_story = var_109_0.localPosition
			end

			local var_109_2 = 0.001

			if var_109_1 <= arg_106_1.time_ and arg_106_1.time_ < var_109_1 + var_109_2 then
				local var_109_3 = (arg_106_1.time_ - var_109_1) / var_109_2
				local var_109_4 = Vector3.New(0.7, -0.98, -6.1)

				var_109_0.localPosition = Vector3.Lerp(arg_106_1.var_.moveOldPos10058ui_story, var_109_4, var_109_3)

				local var_109_5 = manager.ui.mainCamera.transform.position - var_109_0.position

				var_109_0.forward = Vector3.New(var_109_5.x, var_109_5.y, var_109_5.z)

				local var_109_6 = var_109_0.localEulerAngles

				var_109_6.z = 0
				var_109_6.x = 0
				var_109_0.localEulerAngles = var_109_6
			end

			if arg_106_1.time_ >= var_109_1 + var_109_2 and arg_106_1.time_ < var_109_1 + var_109_2 + arg_109_0 then
				var_109_0.localPosition = Vector3.New(0.7, -0.98, -6.1)

				local var_109_7 = manager.ui.mainCamera.transform.position - var_109_0.position

				var_109_0.forward = Vector3.New(var_109_7.x, var_109_7.y, var_109_7.z)

				local var_109_8 = var_109_0.localEulerAngles

				var_109_8.z = 0
				var_109_8.x = 0
				var_109_0.localEulerAngles = var_109_8
			end

			local var_109_9 = arg_106_1.actors_["10058ui_story"]
			local var_109_10 = 0

			if var_109_10 < arg_106_1.time_ and arg_106_1.time_ <= var_109_10 + arg_109_0 and not isNil(var_109_9) and arg_106_1.var_.characterEffect10058ui_story == nil then
				arg_106_1.var_.characterEffect10058ui_story = var_109_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_11 = 0.200000002980232

			if var_109_10 <= arg_106_1.time_ and arg_106_1.time_ < var_109_10 + var_109_11 and not isNil(var_109_9) then
				local var_109_12 = (arg_106_1.time_ - var_109_10) / var_109_11

				if arg_106_1.var_.characterEffect10058ui_story and not isNil(var_109_9) then
					arg_106_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_106_1.time_ >= var_109_10 + var_109_11 and arg_106_1.time_ < var_109_10 + var_109_11 + arg_109_0 and not isNil(var_109_9) and arg_106_1.var_.characterEffect10058ui_story then
				arg_106_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_109_13 = 0

			if var_109_13 < arg_106_1.time_ and arg_106_1.time_ <= var_109_13 + arg_109_0 then
				arg_106_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_1")
			end

			local var_109_14 = 0

			if var_109_14 < arg_106_1.time_ and arg_106_1.time_ <= var_109_14 + arg_109_0 then
				arg_106_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_109_15 = 0
			local var_109_16 = 0.45

			if var_109_15 < arg_106_1.time_ and arg_106_1.time_ <= var_109_15 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				local var_109_17 = arg_106_1:FormatText(StoryNameCfg[471].name)

				arg_106_1.leftNameTxt_.text = var_109_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_18 = arg_106_1:GetWordFromCfg(319841024)
				local var_109_19 = arg_106_1:FormatText(var_109_18.content)

				arg_106_1.text_.text = var_109_19

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_20 = 18
				local var_109_21 = utf8.len(var_109_19)
				local var_109_22 = var_109_20 <= 0 and var_109_16 or var_109_16 * (var_109_21 / var_109_20)

				if var_109_22 > 0 and var_109_16 < var_109_22 then
					arg_106_1.talkMaxDuration = var_109_22

					if var_109_22 + var_109_15 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_22 + var_109_15
					end
				end

				arg_106_1.text_.text = var_109_19
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319841", "319841024", "story_v_out_319841.awb") ~= 0 then
					local var_109_23 = manager.audio:GetVoiceLength("story_v_out_319841", "319841024", "story_v_out_319841.awb") / 1000

					if var_109_23 + var_109_15 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_23 + var_109_15
					end

					if var_109_18.prefab_name ~= "" and arg_106_1.actors_[var_109_18.prefab_name] ~= nil then
						local var_109_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_18.prefab_name].transform, "story_v_out_319841", "319841024", "story_v_out_319841.awb")

						arg_106_1:RecordAudio("319841024", var_109_24)
						arg_106_1:RecordAudio("319841024", var_109_24)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_319841", "319841024", "story_v_out_319841.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_319841", "319841024", "story_v_out_319841.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_25 = math.max(var_109_16, arg_106_1.talkMaxDuration)

			if var_109_15 <= arg_106_1.time_ and arg_106_1.time_ < var_109_15 + var_109_25 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_15) / var_109_25

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_15 + var_109_25 and arg_106_1.time_ < var_109_15 + var_109_25 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {
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

		arg_106_1:InitPlayNodeList()
	end,
	Play319841025 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 319841025
		arg_110_1.duration_ = 9.9

		local var_110_0 = {
			zh = 7.63333333333333,
			ja = 9.89933333333333
		}
		local var_110_1 = manager.audio:GetLocalizationFlag()

		if var_110_0[var_110_1] ~= nil then
			arg_110_1.duration_ = var_110_0[var_110_1]
		end

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play319841026(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = "ST72"

			if arg_110_1.bgs_[var_113_0] == nil then
				local var_113_1 = Object.Instantiate(arg_110_1.paintGo_)

				var_113_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_113_0)
				var_113_1.name = var_113_0
				var_113_1.transform.parent = arg_110_1.stage_.transform
				var_113_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_110_1.bgs_[var_113_0] = var_113_1
			end

			local var_113_2 = 1.33333333333333

			if var_113_2 < arg_110_1.time_ and arg_110_1.time_ <= var_113_2 + arg_113_0 then
				local var_113_3 = manager.ui.mainCamera.transform.localPosition
				local var_113_4 = Vector3.New(0, 0, 10) + Vector3.New(var_113_3.x, var_113_3.y, 0)
				local var_113_5 = arg_110_1.bgs_.ST72

				var_113_5.transform.localPosition = var_113_4
				var_113_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_113_6 = var_113_5:GetComponent("SpriteRenderer")

				if var_113_6 and var_113_6.sprite then
					local var_113_7 = (var_113_5.transform.localPosition - var_113_3).z
					local var_113_8 = manager.ui.mainCameraCom_
					local var_113_9 = 2 * var_113_7 * Mathf.Tan(var_113_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_113_10 = var_113_9 * var_113_8.aspect
					local var_113_11 = var_113_6.sprite.bounds.size.x
					local var_113_12 = var_113_6.sprite.bounds.size.y
					local var_113_13 = var_113_10 / var_113_11
					local var_113_14 = var_113_9 / var_113_12
					local var_113_15 = var_113_14 < var_113_13 and var_113_13 or var_113_14

					var_113_5.transform.localScale = Vector3.New(var_113_15, var_113_15, 0)
				end

				for iter_113_0, iter_113_1 in pairs(arg_110_1.bgs_) do
					if iter_113_0 ~= "ST72" then
						iter_113_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_113_16 = 0

			if var_113_16 < arg_110_1.time_ and arg_110_1.time_ <= var_113_16 + arg_113_0 then
				arg_110_1.allBtn_.enabled = false
			end

			local var_113_17 = 0.3

			if arg_110_1.time_ >= var_113_16 + var_113_17 and arg_110_1.time_ < var_113_16 + var_113_17 + arg_113_0 then
				arg_110_1.allBtn_.enabled = true
			end

			local var_113_18 = 0

			if var_113_18 < arg_110_1.time_ and arg_110_1.time_ <= var_113_18 + arg_113_0 then
				arg_110_1.mask_.enabled = true
				arg_110_1.mask_.raycastTarget = true

				arg_110_1:SetGaussion(false)
			end

			local var_113_19 = 1.33333333333333

			if var_113_18 <= arg_110_1.time_ and arg_110_1.time_ < var_113_18 + var_113_19 then
				local var_113_20 = (arg_110_1.time_ - var_113_18) / var_113_19
				local var_113_21 = Color.New(0, 0, 0)

				var_113_21.a = Mathf.Lerp(0, 1, var_113_20)
				arg_110_1.mask_.color = var_113_21
			end

			if arg_110_1.time_ >= var_113_18 + var_113_19 and arg_110_1.time_ < var_113_18 + var_113_19 + arg_113_0 then
				local var_113_22 = Color.New(0, 0, 0)

				var_113_22.a = 1
				arg_110_1.mask_.color = var_113_22
			end

			local var_113_23 = 1.33333333333333

			if var_113_23 < arg_110_1.time_ and arg_110_1.time_ <= var_113_23 + arg_113_0 then
				arg_110_1.mask_.enabled = true
				arg_110_1.mask_.raycastTarget = true

				arg_110_1:SetGaussion(false)
			end

			local var_113_24 = 2

			if var_113_23 <= arg_110_1.time_ and arg_110_1.time_ < var_113_23 + var_113_24 then
				local var_113_25 = (arg_110_1.time_ - var_113_23) / var_113_24
				local var_113_26 = Color.New(0, 0, 0)

				var_113_26.a = Mathf.Lerp(1, 0, var_113_25)
				arg_110_1.mask_.color = var_113_26
			end

			if arg_110_1.time_ >= var_113_23 + var_113_24 and arg_110_1.time_ < var_113_23 + var_113_24 + arg_113_0 then
				local var_113_27 = Color.New(0, 0, 0)
				local var_113_28 = 0

				arg_110_1.mask_.enabled = false
				var_113_27.a = var_113_28
				arg_110_1.mask_.color = var_113_27
			end

			local var_113_29 = "10069ui_story"

			if arg_110_1.actors_[var_113_29] == nil then
				local var_113_30 = Asset.Load("Char/" .. "10069ui_story")

				if not isNil(var_113_30) then
					local var_113_31 = Object.Instantiate(Asset.Load("Char/" .. "10069ui_story"), arg_110_1.stage_.transform)

					var_113_31.name = var_113_29
					var_113_31.transform.localPosition = Vector3.New(0, 100, 0)
					arg_110_1.actors_[var_113_29] = var_113_31

					local var_113_32 = var_113_31:GetComponentInChildren(typeof(CharacterEffect))

					var_113_32.enabled = true

					local var_113_33 = GameObjectTools.GetOrAddComponent(var_113_31, typeof(DynamicBoneHelper))

					if var_113_33 then
						var_113_33:EnableDynamicBone(false)
					end

					arg_110_1:ShowWeapon(var_113_32.transform, false)

					arg_110_1.var_[var_113_29 .. "Animator"] = var_113_32.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_110_1.var_[var_113_29 .. "Animator"].applyRootMotion = true
					arg_110_1.var_[var_113_29 .. "LipSync"] = var_113_32.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_113_34 = arg_110_1.actors_["10069ui_story"].transform
			local var_113_35 = 3.2

			if var_113_35 < arg_110_1.time_ and arg_110_1.time_ <= var_113_35 + arg_113_0 then
				arg_110_1.var_.moveOldPos10069ui_story = var_113_34.localPosition
			end

			local var_113_36 = 0.001

			if var_113_35 <= arg_110_1.time_ and arg_110_1.time_ < var_113_35 + var_113_36 then
				local var_113_37 = (arg_110_1.time_ - var_113_35) / var_113_36
				local var_113_38 = Vector3.New(0, -1.08, -6.33)

				var_113_34.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos10069ui_story, var_113_38, var_113_37)

				local var_113_39 = manager.ui.mainCamera.transform.position - var_113_34.position

				var_113_34.forward = Vector3.New(var_113_39.x, var_113_39.y, var_113_39.z)

				local var_113_40 = var_113_34.localEulerAngles

				var_113_40.z = 0
				var_113_40.x = 0
				var_113_34.localEulerAngles = var_113_40
			end

			if arg_110_1.time_ >= var_113_35 + var_113_36 and arg_110_1.time_ < var_113_35 + var_113_36 + arg_113_0 then
				var_113_34.localPosition = Vector3.New(0, -1.08, -6.33)

				local var_113_41 = manager.ui.mainCamera.transform.position - var_113_34.position

				var_113_34.forward = Vector3.New(var_113_41.x, var_113_41.y, var_113_41.z)

				local var_113_42 = var_113_34.localEulerAngles

				var_113_42.z = 0
				var_113_42.x = 0
				var_113_34.localEulerAngles = var_113_42
			end

			local var_113_43 = arg_110_1.actors_["10069ui_story"]
			local var_113_44 = 3.2

			if var_113_44 < arg_110_1.time_ and arg_110_1.time_ <= var_113_44 + arg_113_0 and not isNil(var_113_43) and arg_110_1.var_.characterEffect10069ui_story == nil then
				arg_110_1.var_.characterEffect10069ui_story = var_113_43:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_45 = 0.200000002980232

			if var_113_44 <= arg_110_1.time_ and arg_110_1.time_ < var_113_44 + var_113_45 and not isNil(var_113_43) then
				local var_113_46 = (arg_110_1.time_ - var_113_44) / var_113_45

				if arg_110_1.var_.characterEffect10069ui_story and not isNil(var_113_43) then
					arg_110_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_110_1.time_ >= var_113_44 + var_113_45 and arg_110_1.time_ < var_113_44 + var_113_45 + arg_113_0 and not isNil(var_113_43) and arg_110_1.var_.characterEffect10069ui_story then
				arg_110_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			local var_113_47 = 3.2

			if var_113_47 < arg_110_1.time_ and arg_110_1.time_ <= var_113_47 + arg_113_0 then
				arg_110_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/story10056/story10056action/10056action1_1")
			end

			local var_113_48 = 3.2

			if var_113_48 < arg_110_1.time_ and arg_110_1.time_ <= var_113_48 + arg_113_0 then
				arg_110_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_113_49 = arg_110_1.actors_["10058ui_story"].transform
			local var_113_50 = 1.33333333333333

			if var_113_50 < arg_110_1.time_ and arg_110_1.time_ <= var_113_50 + arg_113_0 then
				arg_110_1.var_.moveOldPos10058ui_story = var_113_49.localPosition
			end

			local var_113_51 = 0.001

			if var_113_50 <= arg_110_1.time_ and arg_110_1.time_ < var_113_50 + var_113_51 then
				local var_113_52 = (arg_110_1.time_ - var_113_50) / var_113_51
				local var_113_53 = Vector3.New(0, 100, 0)

				var_113_49.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos10058ui_story, var_113_53, var_113_52)

				local var_113_54 = manager.ui.mainCamera.transform.position - var_113_49.position

				var_113_49.forward = Vector3.New(var_113_54.x, var_113_54.y, var_113_54.z)

				local var_113_55 = var_113_49.localEulerAngles

				var_113_55.z = 0
				var_113_55.x = 0
				var_113_49.localEulerAngles = var_113_55
			end

			if arg_110_1.time_ >= var_113_50 + var_113_51 and arg_110_1.time_ < var_113_50 + var_113_51 + arg_113_0 then
				var_113_49.localPosition = Vector3.New(0, 100, 0)

				local var_113_56 = manager.ui.mainCamera.transform.position - var_113_49.position

				var_113_49.forward = Vector3.New(var_113_56.x, var_113_56.y, var_113_56.z)

				local var_113_57 = var_113_49.localEulerAngles

				var_113_57.z = 0
				var_113_57.x = 0
				var_113_49.localEulerAngles = var_113_57
			end

			local var_113_58 = arg_110_1.actors_["1084ui_story"].transform
			local var_113_59 = 1.33333333333333

			if var_113_59 < arg_110_1.time_ and arg_110_1.time_ <= var_113_59 + arg_113_0 then
				arg_110_1.var_.moveOldPos1084ui_story = var_113_58.localPosition
			end

			local var_113_60 = 0.001

			if var_113_59 <= arg_110_1.time_ and arg_110_1.time_ < var_113_59 + var_113_60 then
				local var_113_61 = (arg_110_1.time_ - var_113_59) / var_113_60
				local var_113_62 = Vector3.New(0, 100, 0)

				var_113_58.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos1084ui_story, var_113_62, var_113_61)

				local var_113_63 = manager.ui.mainCamera.transform.position - var_113_58.position

				var_113_58.forward = Vector3.New(var_113_63.x, var_113_63.y, var_113_63.z)

				local var_113_64 = var_113_58.localEulerAngles

				var_113_64.z = 0
				var_113_64.x = 0
				var_113_58.localEulerAngles = var_113_64
			end

			if arg_110_1.time_ >= var_113_59 + var_113_60 and arg_110_1.time_ < var_113_59 + var_113_60 + arg_113_0 then
				var_113_58.localPosition = Vector3.New(0, 100, 0)

				local var_113_65 = manager.ui.mainCamera.transform.position - var_113_58.position

				var_113_58.forward = Vector3.New(var_113_65.x, var_113_65.y, var_113_65.z)

				local var_113_66 = var_113_58.localEulerAngles

				var_113_66.z = 0
				var_113_66.x = 0
				var_113_58.localEulerAngles = var_113_66
			end

			local var_113_67 = 0
			local var_113_68 = 0.2

			if var_113_67 < arg_110_1.time_ and arg_110_1.time_ <= var_113_67 + arg_113_0 then
				local var_113_69 = "play"
				local var_113_70 = "music"

				arg_110_1:AudioAction(var_113_69, var_113_70, "ui_battle", "ui_battle_stopbgm", "")

				local var_113_71 = ""
				local var_113_72 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_113_72 ~= "" then
					if arg_110_1.bgmTxt_.text ~= var_113_72 and arg_110_1.bgmTxt_.text ~= "" then
						if arg_110_1.bgmTxt2_.text ~= "" then
							arg_110_1.bgmTxt_.text = arg_110_1.bgmTxt2_.text
						end

						arg_110_1.bgmTxt2_.text = var_113_72

						arg_110_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_110_1.bgmTxt_.text = var_113_72
						arg_110_1.bgmTxt2_.text = var_113_72
					end

					if arg_110_1.bgmTimer then
						arg_110_1.bgmTimer:Stop()

						arg_110_1.bgmTimer = nil
					end

					if arg_110_1.settingData.show_music_name == 1 then
						arg_110_1.musicController:SetSelectedState("show")
						arg_110_1.musicAnimator_:Play("open", 0, 0)

						if arg_110_1.settingData.music_time ~= 0 then
							arg_110_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_110_1.settingData.music_time), function()
								if arg_110_1 == nil or isNil(arg_110_1.bgmTxt_) then
									return
								end

								arg_110_1.musicController:SetSelectedState("hide")
								arg_110_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_113_73 = 0.233333333333333
			local var_113_74 = 1

			if var_113_73 < arg_110_1.time_ and arg_110_1.time_ <= var_113_73 + arg_113_0 then
				local var_113_75 = "play"
				local var_113_76 = "music"

				arg_110_1:AudioAction(var_113_75, var_113_76, "bgm_activity_3_0_story_intense_piano", "bgm_activity_3_0_story_intense_piano", "bgm_activity_3_0_story_intense_piano.awb")

				local var_113_77 = ""
				local var_113_78 = manager.audio:GetAudioName("bgm_activity_3_0_story_intense_piano", "bgm_activity_3_0_story_intense_piano")

				if var_113_78 ~= "" then
					if arg_110_1.bgmTxt_.text ~= var_113_78 and arg_110_1.bgmTxt_.text ~= "" then
						if arg_110_1.bgmTxt2_.text ~= "" then
							arg_110_1.bgmTxt_.text = arg_110_1.bgmTxt2_.text
						end

						arg_110_1.bgmTxt2_.text = var_113_78

						arg_110_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_110_1.bgmTxt_.text = var_113_78
						arg_110_1.bgmTxt2_.text = var_113_78
					end

					if arg_110_1.bgmTimer then
						arg_110_1.bgmTimer:Stop()

						arg_110_1.bgmTimer = nil
					end

					if arg_110_1.settingData.show_music_name == 1 then
						arg_110_1.musicController:SetSelectedState("show")
						arg_110_1.musicAnimator_:Play("open", 0, 0)

						if arg_110_1.settingData.music_time ~= 0 then
							arg_110_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_110_1.settingData.music_time), function()
								if arg_110_1 == nil or isNil(arg_110_1.bgmTxt_) then
									return
								end

								arg_110_1.musicController:SetSelectedState("hide")
								arg_110_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_110_1.frameCnt_ <= 1 then
				arg_110_1.dialog_:SetActive(false)
			end

			local var_113_79 = 3.33333333333333
			local var_113_80 = 0.5

			if var_113_79 < arg_110_1.time_ and arg_110_1.time_ <= var_113_79 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0

				arg_110_1.dialog_:SetActive(true)

				arg_110_1.dialogCg_.alpha = 0

				local var_113_81 = LeanTween.value(arg_110_1.dialog_, 0, 1, 0.3)

				var_113_81:setOnUpdate(LuaHelper.FloatAction(function(arg_116_0)
					arg_110_1.dialogCg_.alpha = arg_116_0
				end))
				var_113_81:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_110_1.dialog_)
					var_113_81:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_110_1.duration_ = arg_110_1.duration_ + 0.3

				SetActive(arg_110_1.leftNameGo_, true)

				local var_113_82 = arg_110_1:FormatText(StoryNameCfg[693].name)

				arg_110_1.leftNameTxt_.text = var_113_82

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_83 = arg_110_1:GetWordFromCfg(319841025)
				local var_113_84 = arg_110_1:FormatText(var_113_83.content)

				arg_110_1.text_.text = var_113_84

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_85 = 20
				local var_113_86 = utf8.len(var_113_84)
				local var_113_87 = var_113_85 <= 0 and var_113_80 or var_113_80 * (var_113_86 / var_113_85)

				if var_113_87 > 0 and var_113_80 < var_113_87 then
					arg_110_1.talkMaxDuration = var_113_87
					var_113_79 = var_113_79 + 0.3

					if var_113_87 + var_113_79 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_87 + var_113_79
					end
				end

				arg_110_1.text_.text = var_113_84
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319841", "319841025", "story_v_out_319841.awb") ~= 0 then
					local var_113_88 = manager.audio:GetVoiceLength("story_v_out_319841", "319841025", "story_v_out_319841.awb") / 1000

					if var_113_88 + var_113_79 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_88 + var_113_79
					end

					if var_113_83.prefab_name ~= "" and arg_110_1.actors_[var_113_83.prefab_name] ~= nil then
						local var_113_89 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_83.prefab_name].transform, "story_v_out_319841", "319841025", "story_v_out_319841.awb")

						arg_110_1:RecordAudio("319841025", var_113_89)
						arg_110_1:RecordAudio("319841025", var_113_89)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_319841", "319841025", "story_v_out_319841.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_319841", "319841025", "story_v_out_319841.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_90 = var_113_79 + 0.3
			local var_113_91 = math.max(var_113_80, arg_110_1.talkMaxDuration)

			if var_113_90 <= arg_110_1.time_ and arg_110_1.time_ < var_113_90 + var_113_91 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_90) / var_113_91

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_90 + var_113_91 and arg_110_1.time_ < var_113_90 + var_113_91 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.33333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.33333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_110_1:InitPlayNodeList()
	end,
	Play319841026 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 319841026
		arg_118_1.duration_ = 5

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play319841027(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = arg_118_1.actors_["10069ui_story"]
			local var_121_1 = 0

			if var_121_1 < arg_118_1.time_ and arg_118_1.time_ <= var_121_1 + arg_121_0 and not isNil(var_121_0) and arg_118_1.var_.characterEffect10069ui_story == nil then
				arg_118_1.var_.characterEffect10069ui_story = var_121_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_2 = 0.200000002980232

			if var_121_1 <= arg_118_1.time_ and arg_118_1.time_ < var_121_1 + var_121_2 and not isNil(var_121_0) then
				local var_121_3 = (arg_118_1.time_ - var_121_1) / var_121_2

				if arg_118_1.var_.characterEffect10069ui_story and not isNil(var_121_0) then
					local var_121_4 = Mathf.Lerp(0, 0.5, var_121_3)

					arg_118_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_118_1.var_.characterEffect10069ui_story.fillRatio = var_121_4
				end
			end

			if arg_118_1.time_ >= var_121_1 + var_121_2 and arg_118_1.time_ < var_121_1 + var_121_2 + arg_121_0 and not isNil(var_121_0) and arg_118_1.var_.characterEffect10069ui_story then
				local var_121_5 = 0.5

				arg_118_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_118_1.var_.characterEffect10069ui_story.fillRatio = var_121_5
			end

			local var_121_6 = 0
			local var_121_7 = 0.85

			if var_121_6 < arg_118_1.time_ and arg_118_1.time_ <= var_121_6 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, false)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_8 = arg_118_1:GetWordFromCfg(319841026)
				local var_121_9 = arg_118_1:FormatText(var_121_8.content)

				arg_118_1.text_.text = var_121_9

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_10 = 34
				local var_121_11 = utf8.len(var_121_9)
				local var_121_12 = var_121_10 <= 0 and var_121_7 or var_121_7 * (var_121_11 / var_121_10)

				if var_121_12 > 0 and var_121_7 < var_121_12 then
					arg_118_1.talkMaxDuration = var_121_12

					if var_121_12 + var_121_6 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_12 + var_121_6
					end
				end

				arg_118_1.text_.text = var_121_9
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)
				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_13 = math.max(var_121_7, arg_118_1.talkMaxDuration)

			if var_121_6 <= arg_118_1.time_ and arg_118_1.time_ < var_121_6 + var_121_13 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_6) / var_121_13

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_6 + var_121_13 and arg_118_1.time_ < var_121_6 + var_121_13 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {}

		arg_118_1:InitPlayNodeList()
	end,
	Play319841027 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 319841027
		arg_122_1.duration_ = 5

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play319841028(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = arg_122_1.actors_["10069ui_story"].transform
			local var_125_1 = 0

			if var_125_1 < arg_122_1.time_ and arg_122_1.time_ <= var_125_1 + arg_125_0 then
				arg_122_1.var_.moveOldPos10069ui_story = var_125_0.localPosition
			end

			local var_125_2 = 0.001

			if var_125_1 <= arg_122_1.time_ and arg_122_1.time_ < var_125_1 + var_125_2 then
				local var_125_3 = (arg_122_1.time_ - var_125_1) / var_125_2
				local var_125_4 = Vector3.New(0, 100, 0)

				var_125_0.localPosition = Vector3.Lerp(arg_122_1.var_.moveOldPos10069ui_story, var_125_4, var_125_3)

				local var_125_5 = manager.ui.mainCamera.transform.position - var_125_0.position

				var_125_0.forward = Vector3.New(var_125_5.x, var_125_5.y, var_125_5.z)

				local var_125_6 = var_125_0.localEulerAngles

				var_125_6.z = 0
				var_125_6.x = 0
				var_125_0.localEulerAngles = var_125_6
			end

			if arg_122_1.time_ >= var_125_1 + var_125_2 and arg_122_1.time_ < var_125_1 + var_125_2 + arg_125_0 then
				var_125_0.localPosition = Vector3.New(0, 100, 0)

				local var_125_7 = manager.ui.mainCamera.transform.position - var_125_0.position

				var_125_0.forward = Vector3.New(var_125_7.x, var_125_7.y, var_125_7.z)

				local var_125_8 = var_125_0.localEulerAngles

				var_125_8.z = 0
				var_125_8.x = 0
				var_125_0.localEulerAngles = var_125_8
			end

			local var_125_9 = 0
			local var_125_10 = 1.125

			if var_125_9 < arg_122_1.time_ and arg_122_1.time_ <= var_125_9 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, false)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_11 = arg_122_1:GetWordFromCfg(319841027)
				local var_125_12 = arg_122_1:FormatText(var_125_11.content)

				arg_122_1.text_.text = var_125_12

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_13 = 45
				local var_125_14 = utf8.len(var_125_12)
				local var_125_15 = var_125_13 <= 0 and var_125_10 or var_125_10 * (var_125_14 / var_125_13)

				if var_125_15 > 0 and var_125_10 < var_125_15 then
					arg_122_1.talkMaxDuration = var_125_15

					if var_125_15 + var_125_9 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_15 + var_125_9
					end
				end

				arg_122_1.text_.text = var_125_12
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)
				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_16 = math.max(var_125_10, arg_122_1.talkMaxDuration)

			if var_125_9 <= arg_122_1.time_ and arg_122_1.time_ < var_125_9 + var_125_16 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_9) / var_125_16

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_9 + var_125_16 and arg_122_1.time_ < var_125_9 + var_125_16 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_122_1:InitPlayNodeList()
	end,
	Play319841028 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 319841028
		arg_126_1.duration_ = 3.13

		local var_126_0 = {
			zh = 1.999999999999,
			ja = 3.133
		}
		local var_126_1 = manager.audio:GetLocalizationFlag()

		if var_126_0[var_126_1] ~= nil then
			arg_126_1.duration_ = var_126_0[var_126_1]
		end

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play319841029(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = arg_126_1.actors_["10058ui_story"].transform
			local var_129_1 = 0

			if var_129_1 < arg_126_1.time_ and arg_126_1.time_ <= var_129_1 + arg_129_0 then
				arg_126_1.var_.moveOldPos10058ui_story = var_129_0.localPosition
			end

			local var_129_2 = 0.001

			if var_129_1 <= arg_126_1.time_ and arg_126_1.time_ < var_129_1 + var_129_2 then
				local var_129_3 = (arg_126_1.time_ - var_129_1) / var_129_2
				local var_129_4 = Vector3.New(0.7, -0.98, -6.1)

				var_129_0.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos10058ui_story, var_129_4, var_129_3)

				local var_129_5 = manager.ui.mainCamera.transform.position - var_129_0.position

				var_129_0.forward = Vector3.New(var_129_5.x, var_129_5.y, var_129_5.z)

				local var_129_6 = var_129_0.localEulerAngles

				var_129_6.z = 0
				var_129_6.x = 0
				var_129_0.localEulerAngles = var_129_6
			end

			if arg_126_1.time_ >= var_129_1 + var_129_2 and arg_126_1.time_ < var_129_1 + var_129_2 + arg_129_0 then
				var_129_0.localPosition = Vector3.New(0.7, -0.98, -6.1)

				local var_129_7 = manager.ui.mainCamera.transform.position - var_129_0.position

				var_129_0.forward = Vector3.New(var_129_7.x, var_129_7.y, var_129_7.z)

				local var_129_8 = var_129_0.localEulerAngles

				var_129_8.z = 0
				var_129_8.x = 0
				var_129_0.localEulerAngles = var_129_8
			end

			local var_129_9 = arg_126_1.actors_["10058ui_story"]
			local var_129_10 = 0

			if var_129_10 < arg_126_1.time_ and arg_126_1.time_ <= var_129_10 + arg_129_0 and not isNil(var_129_9) and arg_126_1.var_.characterEffect10058ui_story == nil then
				arg_126_1.var_.characterEffect10058ui_story = var_129_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_11 = 0.200000002980232

			if var_129_10 <= arg_126_1.time_ and arg_126_1.time_ < var_129_10 + var_129_11 and not isNil(var_129_9) then
				local var_129_12 = (arg_126_1.time_ - var_129_10) / var_129_11

				if arg_126_1.var_.characterEffect10058ui_story and not isNil(var_129_9) then
					arg_126_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_126_1.time_ >= var_129_10 + var_129_11 and arg_126_1.time_ < var_129_10 + var_129_11 + arg_129_0 and not isNil(var_129_9) and arg_126_1.var_.characterEffect10058ui_story then
				arg_126_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_129_13 = 0

			if var_129_13 < arg_126_1.time_ and arg_126_1.time_ <= var_129_13 + arg_129_0 then
				arg_126_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_2")
			end

			local var_129_14 = 0

			if var_129_14 < arg_126_1.time_ and arg_126_1.time_ <= var_129_14 + arg_129_0 then
				arg_126_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_129_15 = arg_126_1.actors_["10069ui_story"].transform
			local var_129_16 = 0

			if var_129_16 < arg_126_1.time_ and arg_126_1.time_ <= var_129_16 + arg_129_0 then
				arg_126_1.var_.moveOldPos10069ui_story = var_129_15.localPosition
			end

			local var_129_17 = 0.001

			if var_129_16 <= arg_126_1.time_ and arg_126_1.time_ < var_129_16 + var_129_17 then
				local var_129_18 = (arg_126_1.time_ - var_129_16) / var_129_17
				local var_129_19 = Vector3.New(0, 100, 0)

				var_129_15.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos10069ui_story, var_129_19, var_129_18)

				local var_129_20 = manager.ui.mainCamera.transform.position - var_129_15.position

				var_129_15.forward = Vector3.New(var_129_20.x, var_129_20.y, var_129_20.z)

				local var_129_21 = var_129_15.localEulerAngles

				var_129_21.z = 0
				var_129_21.x = 0
				var_129_15.localEulerAngles = var_129_21
			end

			if arg_126_1.time_ >= var_129_16 + var_129_17 and arg_126_1.time_ < var_129_16 + var_129_17 + arg_129_0 then
				var_129_15.localPosition = Vector3.New(0, 100, 0)

				local var_129_22 = manager.ui.mainCamera.transform.position - var_129_15.position

				var_129_15.forward = Vector3.New(var_129_22.x, var_129_22.y, var_129_22.z)

				local var_129_23 = var_129_15.localEulerAngles

				var_129_23.z = 0
				var_129_23.x = 0
				var_129_15.localEulerAngles = var_129_23
			end

			local var_129_24 = arg_126_1.actors_["10069ui_story"]
			local var_129_25 = 0

			if var_129_25 < arg_126_1.time_ and arg_126_1.time_ <= var_129_25 + arg_129_0 and not isNil(var_129_24) and arg_126_1.var_.characterEffect10069ui_story == nil then
				arg_126_1.var_.characterEffect10069ui_story = var_129_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_26 = 0.200000002980232

			if var_129_25 <= arg_126_1.time_ and arg_126_1.time_ < var_129_25 + var_129_26 and not isNil(var_129_24) then
				local var_129_27 = (arg_126_1.time_ - var_129_25) / var_129_26

				if arg_126_1.var_.characterEffect10069ui_story and not isNil(var_129_24) then
					local var_129_28 = Mathf.Lerp(0, 0.5, var_129_27)

					arg_126_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_126_1.var_.characterEffect10069ui_story.fillRatio = var_129_28
				end
			end

			if arg_126_1.time_ >= var_129_25 + var_129_26 and arg_126_1.time_ < var_129_25 + var_129_26 + arg_129_0 and not isNil(var_129_24) and arg_126_1.var_.characterEffect10069ui_story then
				local var_129_29 = 0.5

				arg_126_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_126_1.var_.characterEffect10069ui_story.fillRatio = var_129_29
			end

			local var_129_30 = 0
			local var_129_31 = 0.25

			if var_129_30 < arg_126_1.time_ and arg_126_1.time_ <= var_129_30 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				local var_129_32 = arg_126_1:FormatText(StoryNameCfg[471].name)

				arg_126_1.leftNameTxt_.text = var_129_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_33 = arg_126_1:GetWordFromCfg(319841028)
				local var_129_34 = arg_126_1:FormatText(var_129_33.content)

				arg_126_1.text_.text = var_129_34

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_35 = 10
				local var_129_36 = utf8.len(var_129_34)
				local var_129_37 = var_129_35 <= 0 and var_129_31 or var_129_31 * (var_129_36 / var_129_35)

				if var_129_37 > 0 and var_129_31 < var_129_37 then
					arg_126_1.talkMaxDuration = var_129_37

					if var_129_37 + var_129_30 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_37 + var_129_30
					end
				end

				arg_126_1.text_.text = var_129_34
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319841", "319841028", "story_v_out_319841.awb") ~= 0 then
					local var_129_38 = manager.audio:GetVoiceLength("story_v_out_319841", "319841028", "story_v_out_319841.awb") / 1000

					if var_129_38 + var_129_30 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_38 + var_129_30
					end

					if var_129_33.prefab_name ~= "" and arg_126_1.actors_[var_129_33.prefab_name] ~= nil then
						local var_129_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_33.prefab_name].transform, "story_v_out_319841", "319841028", "story_v_out_319841.awb")

						arg_126_1:RecordAudio("319841028", var_129_39)
						arg_126_1:RecordAudio("319841028", var_129_39)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_out_319841", "319841028", "story_v_out_319841.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_out_319841", "319841028", "story_v_out_319841.awb")
				end

				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_40 = math.max(var_129_31, arg_126_1.talkMaxDuration)

			if var_129_30 <= arg_126_1.time_ and arg_126_1.time_ < var_129_30 + var_129_40 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_30) / var_129_40

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_30 + var_129_40 and arg_126_1.time_ < var_129_30 + var_129_40 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_126_1:InitPlayNodeList()
	end,
	Play319841029 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 319841029
		arg_130_1.duration_ = 10.8

		local var_130_0 = {
			zh = 10.8,
			ja = 7.333
		}
		local var_130_1 = manager.audio:GetLocalizationFlag()

		if var_130_0[var_130_1] ~= nil then
			arg_130_1.duration_ = var_130_0[var_130_1]
		end

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play319841030(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = arg_130_1.actors_["10058ui_story"]
			local var_133_1 = 0

			if var_133_1 < arg_130_1.time_ and arg_130_1.time_ <= var_133_1 + arg_133_0 and not isNil(var_133_0) and arg_130_1.var_.characterEffect10058ui_story == nil then
				arg_130_1.var_.characterEffect10058ui_story = var_133_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_133_2 = 0.200000002980232

			if var_133_1 <= arg_130_1.time_ and arg_130_1.time_ < var_133_1 + var_133_2 and not isNil(var_133_0) then
				local var_133_3 = (arg_130_1.time_ - var_133_1) / var_133_2

				if arg_130_1.var_.characterEffect10058ui_story and not isNil(var_133_0) then
					local var_133_4 = Mathf.Lerp(0, 0.5, var_133_3)

					arg_130_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_130_1.var_.characterEffect10058ui_story.fillRatio = var_133_4
				end
			end

			if arg_130_1.time_ >= var_133_1 + var_133_2 and arg_130_1.time_ < var_133_1 + var_133_2 + arg_133_0 and not isNil(var_133_0) and arg_130_1.var_.characterEffect10058ui_story then
				local var_133_5 = 0.5

				arg_130_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_130_1.var_.characterEffect10058ui_story.fillRatio = var_133_5
			end

			local var_133_6 = arg_130_1.actors_["10069ui_story"].transform
			local var_133_7 = 0

			if var_133_7 < arg_130_1.time_ and arg_130_1.time_ <= var_133_7 + arg_133_0 then
				arg_130_1.var_.moveOldPos10069ui_story = var_133_6.localPosition
			end

			local var_133_8 = 0.001

			if var_133_7 <= arg_130_1.time_ and arg_130_1.time_ < var_133_7 + var_133_8 then
				local var_133_9 = (arg_130_1.time_ - var_133_7) / var_133_8
				local var_133_10 = Vector3.New(-0.7, -1.08, -6.33)

				var_133_6.localPosition = Vector3.Lerp(arg_130_1.var_.moveOldPos10069ui_story, var_133_10, var_133_9)

				local var_133_11 = manager.ui.mainCamera.transform.position - var_133_6.position

				var_133_6.forward = Vector3.New(var_133_11.x, var_133_11.y, var_133_11.z)

				local var_133_12 = var_133_6.localEulerAngles

				var_133_12.z = 0
				var_133_12.x = 0
				var_133_6.localEulerAngles = var_133_12
			end

			if arg_130_1.time_ >= var_133_7 + var_133_8 and arg_130_1.time_ < var_133_7 + var_133_8 + arg_133_0 then
				var_133_6.localPosition = Vector3.New(-0.7, -1.08, -6.33)

				local var_133_13 = manager.ui.mainCamera.transform.position - var_133_6.position

				var_133_6.forward = Vector3.New(var_133_13.x, var_133_13.y, var_133_13.z)

				local var_133_14 = var_133_6.localEulerAngles

				var_133_14.z = 0
				var_133_14.x = 0
				var_133_6.localEulerAngles = var_133_14
			end

			local var_133_15 = arg_130_1.actors_["10069ui_story"]
			local var_133_16 = 0

			if var_133_16 < arg_130_1.time_ and arg_130_1.time_ <= var_133_16 + arg_133_0 and not isNil(var_133_15) and arg_130_1.var_.characterEffect10069ui_story == nil then
				arg_130_1.var_.characterEffect10069ui_story = var_133_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_133_17 = 0.200000002980232

			if var_133_16 <= arg_130_1.time_ and arg_130_1.time_ < var_133_16 + var_133_17 and not isNil(var_133_15) then
				local var_133_18 = (arg_130_1.time_ - var_133_16) / var_133_17

				if arg_130_1.var_.characterEffect10069ui_story and not isNil(var_133_15) then
					arg_130_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_130_1.time_ >= var_133_16 + var_133_17 and arg_130_1.time_ < var_133_16 + var_133_17 + arg_133_0 and not isNil(var_133_15) and arg_130_1.var_.characterEffect10069ui_story then
				arg_130_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			local var_133_19 = 0
			local var_133_20 = 1.325

			if var_133_19 < arg_130_1.time_ and arg_130_1.time_ <= var_133_19 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				local var_133_21 = arg_130_1:FormatText(StoryNameCfg[693].name)

				arg_130_1.leftNameTxt_.text = var_133_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_22 = arg_130_1:GetWordFromCfg(319841029)
				local var_133_23 = arg_130_1:FormatText(var_133_22.content)

				arg_130_1.text_.text = var_133_23

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_24 = 52
				local var_133_25 = utf8.len(var_133_23)
				local var_133_26 = var_133_24 <= 0 and var_133_20 or var_133_20 * (var_133_25 / var_133_24)

				if var_133_26 > 0 and var_133_20 < var_133_26 then
					arg_130_1.talkMaxDuration = var_133_26

					if var_133_26 + var_133_19 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_26 + var_133_19
					end
				end

				arg_130_1.text_.text = var_133_23
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319841", "319841029", "story_v_out_319841.awb") ~= 0 then
					local var_133_27 = manager.audio:GetVoiceLength("story_v_out_319841", "319841029", "story_v_out_319841.awb") / 1000

					if var_133_27 + var_133_19 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_27 + var_133_19
					end

					if var_133_22.prefab_name ~= "" and arg_130_1.actors_[var_133_22.prefab_name] ~= nil then
						local var_133_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_130_1.actors_[var_133_22.prefab_name].transform, "story_v_out_319841", "319841029", "story_v_out_319841.awb")

						arg_130_1:RecordAudio("319841029", var_133_28)
						arg_130_1:RecordAudio("319841029", var_133_28)
					else
						arg_130_1:AudioAction("play", "voice", "story_v_out_319841", "319841029", "story_v_out_319841.awb")
					end

					arg_130_1:RecordHistoryTalkVoice("story_v_out_319841", "319841029", "story_v_out_319841.awb")
				end

				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_29 = math.max(var_133_20, arg_130_1.talkMaxDuration)

			if var_133_19 <= arg_130_1.time_ and arg_130_1.time_ < var_133_19 + var_133_29 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_19) / var_133_29

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_19 + var_133_29 and arg_130_1.time_ < var_133_19 + var_133_29 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_130_1:InitPlayNodeList()
	end,
	Play319841030 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 319841030
		arg_134_1.duration_ = 10.93

		local var_134_0 = {
			zh = 9.5,
			ja = 10.933
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
				arg_134_0:Play319841031(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			local var_137_0 = 0
			local var_137_1 = 1.15

			if var_137_0 < arg_134_1.time_ and arg_134_1.time_ <= var_137_0 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				local var_137_2 = arg_134_1:FormatText(StoryNameCfg[693].name)

				arg_134_1.leftNameTxt_.text = var_137_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_3 = arg_134_1:GetWordFromCfg(319841030)
				local var_137_4 = arg_134_1:FormatText(var_137_3.content)

				arg_134_1.text_.text = var_137_4

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_5 = 46
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

				if manager.audio:GetVoiceLength("story_v_out_319841", "319841030", "story_v_out_319841.awb") ~= 0 then
					local var_137_8 = manager.audio:GetVoiceLength("story_v_out_319841", "319841030", "story_v_out_319841.awb") / 1000

					if var_137_8 + var_137_0 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_8 + var_137_0
					end

					if var_137_3.prefab_name ~= "" and arg_134_1.actors_[var_137_3.prefab_name] ~= nil then
						local var_137_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_134_1.actors_[var_137_3.prefab_name].transform, "story_v_out_319841", "319841030", "story_v_out_319841.awb")

						arg_134_1:RecordAudio("319841030", var_137_9)
						arg_134_1:RecordAudio("319841030", var_137_9)
					else
						arg_134_1:AudioAction("play", "voice", "story_v_out_319841", "319841030", "story_v_out_319841.awb")
					end

					arg_134_1:RecordHistoryTalkVoice("story_v_out_319841", "319841030", "story_v_out_319841.awb")
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
	Play319841031 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 319841031
		arg_138_1.duration_ = 12.47

		local var_138_0 = {
			zh = 12.4,
			ja = 12.466
		}
		local var_138_1 = manager.audio:GetLocalizationFlag()

		if var_138_0[var_138_1] ~= nil then
			arg_138_1.duration_ = var_138_0[var_138_1]
		end

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play319841032(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			local var_141_0 = arg_138_1.actors_["10069ui_story"].transform
			local var_141_1 = 0

			if var_141_1 < arg_138_1.time_ and arg_138_1.time_ <= var_141_1 + arg_141_0 then
				arg_138_1.var_.moveOldPos10069ui_story = var_141_0.localPosition
			end

			local var_141_2 = 0.001

			if var_141_1 <= arg_138_1.time_ and arg_138_1.time_ < var_141_1 + var_141_2 then
				local var_141_3 = (arg_138_1.time_ - var_141_1) / var_141_2
				local var_141_4 = Vector3.New(-0.7, -1.08, -6.33)

				var_141_0.localPosition = Vector3.Lerp(arg_138_1.var_.moveOldPos10069ui_story, var_141_4, var_141_3)

				local var_141_5 = manager.ui.mainCamera.transform.position - var_141_0.position

				var_141_0.forward = Vector3.New(var_141_5.x, var_141_5.y, var_141_5.z)

				local var_141_6 = var_141_0.localEulerAngles

				var_141_6.z = 0
				var_141_6.x = 0
				var_141_0.localEulerAngles = var_141_6
			end

			if arg_138_1.time_ >= var_141_1 + var_141_2 and arg_138_1.time_ < var_141_1 + var_141_2 + arg_141_0 then
				var_141_0.localPosition = Vector3.New(-0.7, -1.08, -6.33)

				local var_141_7 = manager.ui.mainCamera.transform.position - var_141_0.position

				var_141_0.forward = Vector3.New(var_141_7.x, var_141_7.y, var_141_7.z)

				local var_141_8 = var_141_0.localEulerAngles

				var_141_8.z = 0
				var_141_8.x = 0
				var_141_0.localEulerAngles = var_141_8
			end

			local var_141_9 = 0

			if var_141_9 < arg_138_1.time_ and arg_138_1.time_ <= var_141_9 + arg_141_0 then
				arg_138_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/story10056/story10056action/10056action6_1")
			end

			local var_141_10 = 0

			if var_141_10 < arg_138_1.time_ and arg_138_1.time_ <= var_141_10 + arg_141_0 then
				arg_138_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_141_11 = 0
			local var_141_12 = 1.4

			if var_141_11 < arg_138_1.time_ and arg_138_1.time_ <= var_141_11 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				local var_141_13 = arg_138_1:FormatText(StoryNameCfg[693].name)

				arg_138_1.leftNameTxt_.text = var_141_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_14 = arg_138_1:GetWordFromCfg(319841031)
				local var_141_15 = arg_138_1:FormatText(var_141_14.content)

				arg_138_1.text_.text = var_141_15

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_16 = 56
				local var_141_17 = utf8.len(var_141_15)
				local var_141_18 = var_141_16 <= 0 and var_141_12 or var_141_12 * (var_141_17 / var_141_16)

				if var_141_18 > 0 and var_141_12 < var_141_18 then
					arg_138_1.talkMaxDuration = var_141_18

					if var_141_18 + var_141_11 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_18 + var_141_11
					end
				end

				arg_138_1.text_.text = var_141_15
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319841", "319841031", "story_v_out_319841.awb") ~= 0 then
					local var_141_19 = manager.audio:GetVoiceLength("story_v_out_319841", "319841031", "story_v_out_319841.awb") / 1000

					if var_141_19 + var_141_11 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_19 + var_141_11
					end

					if var_141_14.prefab_name ~= "" and arg_138_1.actors_[var_141_14.prefab_name] ~= nil then
						local var_141_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_14.prefab_name].transform, "story_v_out_319841", "319841031", "story_v_out_319841.awb")

						arg_138_1:RecordAudio("319841031", var_141_20)
						arg_138_1:RecordAudio("319841031", var_141_20)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_out_319841", "319841031", "story_v_out_319841.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_out_319841", "319841031", "story_v_out_319841.awb")
				end

				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_21 = math.max(var_141_12, arg_138_1.talkMaxDuration)

			if var_141_11 <= arg_138_1.time_ and arg_138_1.time_ < var_141_11 + var_141_21 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_11) / var_141_21

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_11 + var_141_21 and arg_138_1.time_ < var_141_11 + var_141_21 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_138_1:InitPlayNodeList()
	end,
	Play319841032 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 319841032
		arg_142_1.duration_ = 5.67

		local var_142_0 = {
			zh = 1.999999999999,
			ja = 5.666
		}
		local var_142_1 = manager.audio:GetLocalizationFlag()

		if var_142_0[var_142_1] ~= nil then
			arg_142_1.duration_ = var_142_0[var_142_1]
		end

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play319841033(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			local var_145_0 = arg_142_1.actors_["10058ui_story"].transform
			local var_145_1 = 0

			if var_145_1 < arg_142_1.time_ and arg_142_1.time_ <= var_145_1 + arg_145_0 then
				arg_142_1.var_.moveOldPos10058ui_story = var_145_0.localPosition
			end

			local var_145_2 = 0.001

			if var_145_1 <= arg_142_1.time_ and arg_142_1.time_ < var_145_1 + var_145_2 then
				local var_145_3 = (arg_142_1.time_ - var_145_1) / var_145_2
				local var_145_4 = Vector3.New(0.7, -0.98, -6.1)

				var_145_0.localPosition = Vector3.Lerp(arg_142_1.var_.moveOldPos10058ui_story, var_145_4, var_145_3)

				local var_145_5 = manager.ui.mainCamera.transform.position - var_145_0.position

				var_145_0.forward = Vector3.New(var_145_5.x, var_145_5.y, var_145_5.z)

				local var_145_6 = var_145_0.localEulerAngles

				var_145_6.z = 0
				var_145_6.x = 0
				var_145_0.localEulerAngles = var_145_6
			end

			if arg_142_1.time_ >= var_145_1 + var_145_2 and arg_142_1.time_ < var_145_1 + var_145_2 + arg_145_0 then
				var_145_0.localPosition = Vector3.New(0.7, -0.98, -6.1)

				local var_145_7 = manager.ui.mainCamera.transform.position - var_145_0.position

				var_145_0.forward = Vector3.New(var_145_7.x, var_145_7.y, var_145_7.z)

				local var_145_8 = var_145_0.localEulerAngles

				var_145_8.z = 0
				var_145_8.x = 0
				var_145_0.localEulerAngles = var_145_8
			end

			local var_145_9 = arg_142_1.actors_["10058ui_story"]
			local var_145_10 = 0

			if var_145_10 < arg_142_1.time_ and arg_142_1.time_ <= var_145_10 + arg_145_0 and not isNil(var_145_9) and arg_142_1.var_.characterEffect10058ui_story == nil then
				arg_142_1.var_.characterEffect10058ui_story = var_145_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_145_11 = 0.200000002980232

			if var_145_10 <= arg_142_1.time_ and arg_142_1.time_ < var_145_10 + var_145_11 and not isNil(var_145_9) then
				local var_145_12 = (arg_142_1.time_ - var_145_10) / var_145_11

				if arg_142_1.var_.characterEffect10058ui_story and not isNil(var_145_9) then
					arg_142_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_142_1.time_ >= var_145_10 + var_145_11 and arg_142_1.time_ < var_145_10 + var_145_11 + arg_145_0 and not isNil(var_145_9) and arg_142_1.var_.characterEffect10058ui_story then
				arg_142_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_145_13 = 0

			if var_145_13 < arg_142_1.time_ and arg_142_1.time_ <= var_145_13 + arg_145_0 then
				arg_142_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action7_1")
			end

			local var_145_14 = 0

			if var_145_14 < arg_142_1.time_ and arg_142_1.time_ <= var_145_14 + arg_145_0 then
				arg_142_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_145_15 = arg_142_1.actors_["10069ui_story"]
			local var_145_16 = 0

			if var_145_16 < arg_142_1.time_ and arg_142_1.time_ <= var_145_16 + arg_145_0 and not isNil(var_145_15) and arg_142_1.var_.characterEffect10069ui_story == nil then
				arg_142_1.var_.characterEffect10069ui_story = var_145_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_145_17 = 0.200000002980232

			if var_145_16 <= arg_142_1.time_ and arg_142_1.time_ < var_145_16 + var_145_17 and not isNil(var_145_15) then
				local var_145_18 = (arg_142_1.time_ - var_145_16) / var_145_17

				if arg_142_1.var_.characterEffect10069ui_story and not isNil(var_145_15) then
					local var_145_19 = Mathf.Lerp(0, 0.5, var_145_18)

					arg_142_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_142_1.var_.characterEffect10069ui_story.fillRatio = var_145_19
				end
			end

			if arg_142_1.time_ >= var_145_16 + var_145_17 and arg_142_1.time_ < var_145_16 + var_145_17 + arg_145_0 and not isNil(var_145_15) and arg_142_1.var_.characterEffect10069ui_story then
				local var_145_20 = 0.5

				arg_142_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_142_1.var_.characterEffect10069ui_story.fillRatio = var_145_20
			end

			local var_145_21 = 0
			local var_145_22 = 0.275

			if var_145_21 < arg_142_1.time_ and arg_142_1.time_ <= var_145_21 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				local var_145_23 = arg_142_1:FormatText(StoryNameCfg[471].name)

				arg_142_1.leftNameTxt_.text = var_145_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_24 = arg_142_1:GetWordFromCfg(319841032)
				local var_145_25 = arg_142_1:FormatText(var_145_24.content)

				arg_142_1.text_.text = var_145_25

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_26 = 11
				local var_145_27 = utf8.len(var_145_25)
				local var_145_28 = var_145_26 <= 0 and var_145_22 or var_145_22 * (var_145_27 / var_145_26)

				if var_145_28 > 0 and var_145_22 < var_145_28 then
					arg_142_1.talkMaxDuration = var_145_28

					if var_145_28 + var_145_21 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_28 + var_145_21
					end
				end

				arg_142_1.text_.text = var_145_25
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319841", "319841032", "story_v_out_319841.awb") ~= 0 then
					local var_145_29 = manager.audio:GetVoiceLength("story_v_out_319841", "319841032", "story_v_out_319841.awb") / 1000

					if var_145_29 + var_145_21 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_29 + var_145_21
					end

					if var_145_24.prefab_name ~= "" and arg_142_1.actors_[var_145_24.prefab_name] ~= nil then
						local var_145_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_142_1.actors_[var_145_24.prefab_name].transform, "story_v_out_319841", "319841032", "story_v_out_319841.awb")

						arg_142_1:RecordAudio("319841032", var_145_30)
						arg_142_1:RecordAudio("319841032", var_145_30)
					else
						arg_142_1:AudioAction("play", "voice", "story_v_out_319841", "319841032", "story_v_out_319841.awb")
					end

					arg_142_1:RecordHistoryTalkVoice("story_v_out_319841", "319841032", "story_v_out_319841.awb")
				end

				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_31 = math.max(var_145_22, arg_142_1.talkMaxDuration)

			if var_145_21 <= arg_142_1.time_ and arg_142_1.time_ < var_145_21 + var_145_31 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_21) / var_145_31

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_21 + var_145_31 and arg_142_1.time_ < var_145_21 + var_145_31 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {
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

		arg_142_1:InitPlayNodeList()
	end,
	Play319841033 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 319841033
		arg_146_1.duration_ = 6.9

		local var_146_0 = {
			zh = 6.9,
			ja = 5.433
		}
		local var_146_1 = manager.audio:GetLocalizationFlag()

		if var_146_0[var_146_1] ~= nil then
			arg_146_1.duration_ = var_146_0[var_146_1]
		end

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play319841034(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			local var_149_0 = arg_146_1.actors_["1084ui_story"].transform
			local var_149_1 = 0

			if var_149_1 < arg_146_1.time_ and arg_146_1.time_ <= var_149_1 + arg_149_0 then
				arg_146_1.var_.moveOldPos1084ui_story = var_149_0.localPosition
			end

			local var_149_2 = 0.001

			if var_149_1 <= arg_146_1.time_ and arg_146_1.time_ < var_149_1 + var_149_2 then
				local var_149_3 = (arg_146_1.time_ - var_149_1) / var_149_2
				local var_149_4 = Vector3.New(0, -0.97, -6)

				var_149_0.localPosition = Vector3.Lerp(arg_146_1.var_.moveOldPos1084ui_story, var_149_4, var_149_3)

				local var_149_5 = manager.ui.mainCamera.transform.position - var_149_0.position

				var_149_0.forward = Vector3.New(var_149_5.x, var_149_5.y, var_149_5.z)

				local var_149_6 = var_149_0.localEulerAngles

				var_149_6.z = 0
				var_149_6.x = 0
				var_149_0.localEulerAngles = var_149_6
			end

			if arg_146_1.time_ >= var_149_1 + var_149_2 and arg_146_1.time_ < var_149_1 + var_149_2 + arg_149_0 then
				var_149_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_149_7 = manager.ui.mainCamera.transform.position - var_149_0.position

				var_149_0.forward = Vector3.New(var_149_7.x, var_149_7.y, var_149_7.z)

				local var_149_8 = var_149_0.localEulerAngles

				var_149_8.z = 0
				var_149_8.x = 0
				var_149_0.localEulerAngles = var_149_8
			end

			local var_149_9 = arg_146_1.actors_["1084ui_story"]
			local var_149_10 = 0

			if var_149_10 < arg_146_1.time_ and arg_146_1.time_ <= var_149_10 + arg_149_0 and not isNil(var_149_9) and arg_146_1.var_.characterEffect1084ui_story == nil then
				arg_146_1.var_.characterEffect1084ui_story = var_149_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_149_11 = 0.200000002980232

			if var_149_10 <= arg_146_1.time_ and arg_146_1.time_ < var_149_10 + var_149_11 and not isNil(var_149_9) then
				local var_149_12 = (arg_146_1.time_ - var_149_10) / var_149_11

				if arg_146_1.var_.characterEffect1084ui_story and not isNil(var_149_9) then
					arg_146_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_146_1.time_ >= var_149_10 + var_149_11 and arg_146_1.time_ < var_149_10 + var_149_11 + arg_149_0 and not isNil(var_149_9) and arg_146_1.var_.characterEffect1084ui_story then
				arg_146_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_149_13 = 0

			if var_149_13 < arg_146_1.time_ and arg_146_1.time_ <= var_149_13 + arg_149_0 then
				arg_146_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_149_14 = 0

			if var_149_14 < arg_146_1.time_ and arg_146_1.time_ <= var_149_14 + arg_149_0 then
				arg_146_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_149_15 = arg_146_1.actors_["10058ui_story"].transform
			local var_149_16 = 0

			if var_149_16 < arg_146_1.time_ and arg_146_1.time_ <= var_149_16 + arg_149_0 then
				arg_146_1.var_.moveOldPos10058ui_story = var_149_15.localPosition
			end

			local var_149_17 = 0.001

			if var_149_16 <= arg_146_1.time_ and arg_146_1.time_ < var_149_16 + var_149_17 then
				local var_149_18 = (arg_146_1.time_ - var_149_16) / var_149_17
				local var_149_19 = Vector3.New(0, 100, 0)

				var_149_15.localPosition = Vector3.Lerp(arg_146_1.var_.moveOldPos10058ui_story, var_149_19, var_149_18)

				local var_149_20 = manager.ui.mainCamera.transform.position - var_149_15.position

				var_149_15.forward = Vector3.New(var_149_20.x, var_149_20.y, var_149_20.z)

				local var_149_21 = var_149_15.localEulerAngles

				var_149_21.z = 0
				var_149_21.x = 0
				var_149_15.localEulerAngles = var_149_21
			end

			if arg_146_1.time_ >= var_149_16 + var_149_17 and arg_146_1.time_ < var_149_16 + var_149_17 + arg_149_0 then
				var_149_15.localPosition = Vector3.New(0, 100, 0)

				local var_149_22 = manager.ui.mainCamera.transform.position - var_149_15.position

				var_149_15.forward = Vector3.New(var_149_22.x, var_149_22.y, var_149_22.z)

				local var_149_23 = var_149_15.localEulerAngles

				var_149_23.z = 0
				var_149_23.x = 0
				var_149_15.localEulerAngles = var_149_23
			end

			local var_149_24 = arg_146_1.actors_["10058ui_story"]
			local var_149_25 = 0

			if var_149_25 < arg_146_1.time_ and arg_146_1.time_ <= var_149_25 + arg_149_0 and not isNil(var_149_24) and arg_146_1.var_.characterEffect10058ui_story == nil then
				arg_146_1.var_.characterEffect10058ui_story = var_149_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_149_26 = 0.200000002980232

			if var_149_25 <= arg_146_1.time_ and arg_146_1.time_ < var_149_25 + var_149_26 and not isNil(var_149_24) then
				local var_149_27 = (arg_146_1.time_ - var_149_25) / var_149_26

				if arg_146_1.var_.characterEffect10058ui_story and not isNil(var_149_24) then
					local var_149_28 = Mathf.Lerp(0, 0.5, var_149_27)

					arg_146_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_146_1.var_.characterEffect10058ui_story.fillRatio = var_149_28
				end
			end

			if arg_146_1.time_ >= var_149_25 + var_149_26 and arg_146_1.time_ < var_149_25 + var_149_26 + arg_149_0 and not isNil(var_149_24) and arg_146_1.var_.characterEffect10058ui_story then
				local var_149_29 = 0.5

				arg_146_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_146_1.var_.characterEffect10058ui_story.fillRatio = var_149_29
			end

			local var_149_30 = arg_146_1.actors_["10069ui_story"].transform
			local var_149_31 = 0

			if var_149_31 < arg_146_1.time_ and arg_146_1.time_ <= var_149_31 + arg_149_0 then
				arg_146_1.var_.moveOldPos10069ui_story = var_149_30.localPosition
			end

			local var_149_32 = 0.001

			if var_149_31 <= arg_146_1.time_ and arg_146_1.time_ < var_149_31 + var_149_32 then
				local var_149_33 = (arg_146_1.time_ - var_149_31) / var_149_32
				local var_149_34 = Vector3.New(0, 100, 0)

				var_149_30.localPosition = Vector3.Lerp(arg_146_1.var_.moveOldPos10069ui_story, var_149_34, var_149_33)

				local var_149_35 = manager.ui.mainCamera.transform.position - var_149_30.position

				var_149_30.forward = Vector3.New(var_149_35.x, var_149_35.y, var_149_35.z)

				local var_149_36 = var_149_30.localEulerAngles

				var_149_36.z = 0
				var_149_36.x = 0
				var_149_30.localEulerAngles = var_149_36
			end

			if arg_146_1.time_ >= var_149_31 + var_149_32 and arg_146_1.time_ < var_149_31 + var_149_32 + arg_149_0 then
				var_149_30.localPosition = Vector3.New(0, 100, 0)

				local var_149_37 = manager.ui.mainCamera.transform.position - var_149_30.position

				var_149_30.forward = Vector3.New(var_149_37.x, var_149_37.y, var_149_37.z)

				local var_149_38 = var_149_30.localEulerAngles

				var_149_38.z = 0
				var_149_38.x = 0
				var_149_30.localEulerAngles = var_149_38
			end

			local var_149_39 = arg_146_1.actors_["10069ui_story"]
			local var_149_40 = 0

			if var_149_40 < arg_146_1.time_ and arg_146_1.time_ <= var_149_40 + arg_149_0 and not isNil(var_149_39) and arg_146_1.var_.characterEffect10069ui_story == nil then
				arg_146_1.var_.characterEffect10069ui_story = var_149_39:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_149_41 = 0.200000002980232

			if var_149_40 <= arg_146_1.time_ and arg_146_1.time_ < var_149_40 + var_149_41 and not isNil(var_149_39) then
				local var_149_42 = (arg_146_1.time_ - var_149_40) / var_149_41

				if arg_146_1.var_.characterEffect10069ui_story and not isNil(var_149_39) then
					local var_149_43 = Mathf.Lerp(0, 0.5, var_149_42)

					arg_146_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_146_1.var_.characterEffect10069ui_story.fillRatio = var_149_43
				end
			end

			if arg_146_1.time_ >= var_149_40 + var_149_41 and arg_146_1.time_ < var_149_40 + var_149_41 + arg_149_0 and not isNil(var_149_39) and arg_146_1.var_.characterEffect10069ui_story then
				local var_149_44 = 0.5

				arg_146_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_146_1.var_.characterEffect10069ui_story.fillRatio = var_149_44
			end

			local var_149_45 = 0
			local var_149_46 = 0.6

			if var_149_45 < arg_146_1.time_ and arg_146_1.time_ <= var_149_45 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				local var_149_47 = arg_146_1:FormatText(StoryNameCfg[6].name)

				arg_146_1.leftNameTxt_.text = var_149_47

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_48 = arg_146_1:GetWordFromCfg(319841033)
				local var_149_49 = arg_146_1:FormatText(var_149_48.content)

				arg_146_1.text_.text = var_149_49

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_50 = 24
				local var_149_51 = utf8.len(var_149_49)
				local var_149_52 = var_149_50 <= 0 and var_149_46 or var_149_46 * (var_149_51 / var_149_50)

				if var_149_52 > 0 and var_149_46 < var_149_52 then
					arg_146_1.talkMaxDuration = var_149_52

					if var_149_52 + var_149_45 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_52 + var_149_45
					end
				end

				arg_146_1.text_.text = var_149_49
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319841", "319841033", "story_v_out_319841.awb") ~= 0 then
					local var_149_53 = manager.audio:GetVoiceLength("story_v_out_319841", "319841033", "story_v_out_319841.awb") / 1000

					if var_149_53 + var_149_45 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_53 + var_149_45
					end

					if var_149_48.prefab_name ~= "" and arg_146_1.actors_[var_149_48.prefab_name] ~= nil then
						local var_149_54 = LuaForUtil.PlayVoiceWithCriLipsync(arg_146_1.actors_[var_149_48.prefab_name].transform, "story_v_out_319841", "319841033", "story_v_out_319841.awb")

						arg_146_1:RecordAudio("319841033", var_149_54)
						arg_146_1:RecordAudio("319841033", var_149_54)
					else
						arg_146_1:AudioAction("play", "voice", "story_v_out_319841", "319841033", "story_v_out_319841.awb")
					end

					arg_146_1:RecordHistoryTalkVoice("story_v_out_319841", "319841033", "story_v_out_319841.awb")
				end

				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_55 = math.max(var_149_46, arg_146_1.talkMaxDuration)

			if var_149_45 <= arg_146_1.time_ and arg_146_1.time_ < var_149_45 + var_149_55 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_45) / var_149_55

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_45 + var_149_55 and arg_146_1.time_ < var_149_45 + var_149_55 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {
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
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_146_1:InitPlayNodeList()
	end,
	Play319841034 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 319841034
		arg_150_1.duration_ = 5

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play319841035(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			local var_153_0 = arg_150_1.actors_["1084ui_story"]
			local var_153_1 = 0

			if var_153_1 < arg_150_1.time_ and arg_150_1.time_ <= var_153_1 + arg_153_0 and not isNil(var_153_0) and arg_150_1.var_.characterEffect1084ui_story == nil then
				arg_150_1.var_.characterEffect1084ui_story = var_153_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_153_2 = 0.200000002980232

			if var_153_1 <= arg_150_1.time_ and arg_150_1.time_ < var_153_1 + var_153_2 and not isNil(var_153_0) then
				local var_153_3 = (arg_150_1.time_ - var_153_1) / var_153_2

				if arg_150_1.var_.characterEffect1084ui_story and not isNil(var_153_0) then
					local var_153_4 = Mathf.Lerp(0, 0.5, var_153_3)

					arg_150_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_150_1.var_.characterEffect1084ui_story.fillRatio = var_153_4
				end
			end

			if arg_150_1.time_ >= var_153_1 + var_153_2 and arg_150_1.time_ < var_153_1 + var_153_2 + arg_153_0 and not isNil(var_153_0) and arg_150_1.var_.characterEffect1084ui_story then
				local var_153_5 = 0.5

				arg_150_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_150_1.var_.characterEffect1084ui_story.fillRatio = var_153_5
			end

			local var_153_6 = 0
			local var_153_7 = 0.825

			if var_153_6 < arg_150_1.time_ and arg_150_1.time_ <= var_153_6 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, false)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_8 = arg_150_1:GetWordFromCfg(319841034)
				local var_153_9 = arg_150_1:FormatText(var_153_8.content)

				arg_150_1.text_.text = var_153_9

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_10 = 33
				local var_153_11 = utf8.len(var_153_9)
				local var_153_12 = var_153_10 <= 0 and var_153_7 or var_153_7 * (var_153_11 / var_153_10)

				if var_153_12 > 0 and var_153_7 < var_153_12 then
					arg_150_1.talkMaxDuration = var_153_12

					if var_153_12 + var_153_6 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_12 + var_153_6
					end
				end

				arg_150_1.text_.text = var_153_9
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)
				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_13 = math.max(var_153_7, arg_150_1.talkMaxDuration)

			if var_153_6 <= arg_150_1.time_ and arg_150_1.time_ < var_153_6 + var_153_13 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_6) / var_153_13

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_6 + var_153_13 and arg_150_1.time_ < var_153_6 + var_153_13 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {}

		arg_150_1:InitPlayNodeList()
	end,
	Play319841035 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 319841035
		arg_154_1.duration_ = 6.63

		local var_154_0 = {
			zh = 5.866,
			ja = 6.633
		}
		local var_154_1 = manager.audio:GetLocalizationFlag()

		if var_154_0[var_154_1] ~= nil then
			arg_154_1.duration_ = var_154_0[var_154_1]
		end

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play319841036(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			local var_157_0 = arg_154_1.actors_["10058ui_story"].transform
			local var_157_1 = 0

			if var_157_1 < arg_154_1.time_ and arg_154_1.time_ <= var_157_1 + arg_157_0 then
				arg_154_1.var_.moveOldPos10058ui_story = var_157_0.localPosition
			end

			local var_157_2 = 0.001

			if var_157_1 <= arg_154_1.time_ and arg_154_1.time_ < var_157_1 + var_157_2 then
				local var_157_3 = (arg_154_1.time_ - var_157_1) / var_157_2
				local var_157_4 = Vector3.New(0.7, -0.98, -6.1)

				var_157_0.localPosition = Vector3.Lerp(arg_154_1.var_.moveOldPos10058ui_story, var_157_4, var_157_3)

				local var_157_5 = manager.ui.mainCamera.transform.position - var_157_0.position

				var_157_0.forward = Vector3.New(var_157_5.x, var_157_5.y, var_157_5.z)

				local var_157_6 = var_157_0.localEulerAngles

				var_157_6.z = 0
				var_157_6.x = 0
				var_157_0.localEulerAngles = var_157_6
			end

			if arg_154_1.time_ >= var_157_1 + var_157_2 and arg_154_1.time_ < var_157_1 + var_157_2 + arg_157_0 then
				var_157_0.localPosition = Vector3.New(0.7, -0.98, -6.1)

				local var_157_7 = manager.ui.mainCamera.transform.position - var_157_0.position

				var_157_0.forward = Vector3.New(var_157_7.x, var_157_7.y, var_157_7.z)

				local var_157_8 = var_157_0.localEulerAngles

				var_157_8.z = 0
				var_157_8.x = 0
				var_157_0.localEulerAngles = var_157_8
			end

			local var_157_9 = arg_154_1.actors_["1084ui_story"].transform
			local var_157_10 = 0

			if var_157_10 < arg_154_1.time_ and arg_154_1.time_ <= var_157_10 + arg_157_0 then
				arg_154_1.var_.moveOldPos1084ui_story = var_157_9.localPosition
			end

			local var_157_11 = 0.001

			if var_157_10 <= arg_154_1.time_ and arg_154_1.time_ < var_157_10 + var_157_11 then
				local var_157_12 = (arg_154_1.time_ - var_157_10) / var_157_11
				local var_157_13 = Vector3.New(-0.7, -0.97, -6)

				var_157_9.localPosition = Vector3.Lerp(arg_154_1.var_.moveOldPos1084ui_story, var_157_13, var_157_12)

				local var_157_14 = manager.ui.mainCamera.transform.position - var_157_9.position

				var_157_9.forward = Vector3.New(var_157_14.x, var_157_14.y, var_157_14.z)

				local var_157_15 = var_157_9.localEulerAngles

				var_157_15.z = 0
				var_157_15.x = 0
				var_157_9.localEulerAngles = var_157_15
			end

			if arg_154_1.time_ >= var_157_10 + var_157_11 and arg_154_1.time_ < var_157_10 + var_157_11 + arg_157_0 then
				var_157_9.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_157_16 = manager.ui.mainCamera.transform.position - var_157_9.position

				var_157_9.forward = Vector3.New(var_157_16.x, var_157_16.y, var_157_16.z)

				local var_157_17 = var_157_9.localEulerAngles

				var_157_17.z = 0
				var_157_17.x = 0
				var_157_9.localEulerAngles = var_157_17
			end

			local var_157_18 = arg_154_1.actors_["1084ui_story"]
			local var_157_19 = 0

			if var_157_19 < arg_154_1.time_ and arg_154_1.time_ <= var_157_19 + arg_157_0 and not isNil(var_157_18) and arg_154_1.var_.characterEffect1084ui_story == nil then
				arg_154_1.var_.characterEffect1084ui_story = var_157_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_157_20 = 0.200000002980232

			if var_157_19 <= arg_154_1.time_ and arg_154_1.time_ < var_157_19 + var_157_20 and not isNil(var_157_18) then
				local var_157_21 = (arg_154_1.time_ - var_157_19) / var_157_20

				if arg_154_1.var_.characterEffect1084ui_story and not isNil(var_157_18) then
					local var_157_22 = Mathf.Lerp(0, 0.5, var_157_21)

					arg_154_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_154_1.var_.characterEffect1084ui_story.fillRatio = var_157_22
				end
			end

			if arg_154_1.time_ >= var_157_19 + var_157_20 and arg_154_1.time_ < var_157_19 + var_157_20 + arg_157_0 and not isNil(var_157_18) and arg_154_1.var_.characterEffect1084ui_story then
				local var_157_23 = 0.5

				arg_154_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_154_1.var_.characterEffect1084ui_story.fillRatio = var_157_23
			end

			local var_157_24 = arg_154_1.actors_["10058ui_story"]
			local var_157_25 = 0

			if var_157_25 < arg_154_1.time_ and arg_154_1.time_ <= var_157_25 + arg_157_0 and not isNil(var_157_24) and arg_154_1.var_.characterEffect10058ui_story == nil then
				arg_154_1.var_.characterEffect10058ui_story = var_157_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_157_26 = 0.200000002980232

			if var_157_25 <= arg_154_1.time_ and arg_154_1.time_ < var_157_25 + var_157_26 and not isNil(var_157_24) then
				local var_157_27 = (arg_154_1.time_ - var_157_25) / var_157_26

				if arg_154_1.var_.characterEffect10058ui_story and not isNil(var_157_24) then
					arg_154_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_154_1.time_ >= var_157_25 + var_157_26 and arg_154_1.time_ < var_157_25 + var_157_26 + arg_157_0 and not isNil(var_157_24) and arg_154_1.var_.characterEffect10058ui_story then
				arg_154_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_157_28 = 0

			if var_157_28 < arg_154_1.time_ and arg_154_1.time_ <= var_157_28 + arg_157_0 then
				arg_154_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action7_2")
			end

			local var_157_29 = 0

			if var_157_29 < arg_154_1.time_ and arg_154_1.time_ <= var_157_29 + arg_157_0 then
				arg_154_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_157_30 = 0
			local var_157_31 = 0.6

			if var_157_30 < arg_154_1.time_ and arg_154_1.time_ <= var_157_30 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				local var_157_32 = arg_154_1:FormatText(StoryNameCfg[471].name)

				arg_154_1.leftNameTxt_.text = var_157_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_33 = arg_154_1:GetWordFromCfg(319841035)
				local var_157_34 = arg_154_1:FormatText(var_157_33.content)

				arg_154_1.text_.text = var_157_34

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_35 = 24
				local var_157_36 = utf8.len(var_157_34)
				local var_157_37 = var_157_35 <= 0 and var_157_31 or var_157_31 * (var_157_36 / var_157_35)

				if var_157_37 > 0 and var_157_31 < var_157_37 then
					arg_154_1.talkMaxDuration = var_157_37

					if var_157_37 + var_157_30 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_37 + var_157_30
					end
				end

				arg_154_1.text_.text = var_157_34
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319841", "319841035", "story_v_out_319841.awb") ~= 0 then
					local var_157_38 = manager.audio:GetVoiceLength("story_v_out_319841", "319841035", "story_v_out_319841.awb") / 1000

					if var_157_38 + var_157_30 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_38 + var_157_30
					end

					if var_157_33.prefab_name ~= "" and arg_154_1.actors_[var_157_33.prefab_name] ~= nil then
						local var_157_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_154_1.actors_[var_157_33.prefab_name].transform, "story_v_out_319841", "319841035", "story_v_out_319841.awb")

						arg_154_1:RecordAudio("319841035", var_157_39)
						arg_154_1:RecordAudio("319841035", var_157_39)
					else
						arg_154_1:AudioAction("play", "voice", "story_v_out_319841", "319841035", "story_v_out_319841.awb")
					end

					arg_154_1:RecordHistoryTalkVoice("story_v_out_319841", "319841035", "story_v_out_319841.awb")
				end

				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_40 = math.max(var_157_31, arg_154_1.talkMaxDuration)

			if var_157_30 <= arg_154_1.time_ and arg_154_1.time_ < var_157_30 + var_157_40 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_30) / var_157_40

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_30 + var_157_40 and arg_154_1.time_ < var_157_30 + var_157_40 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
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

		arg_154_1:InitPlayNodeList()
	end,
	Play319841036 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 319841036
		arg_158_1.duration_ = 5

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play319841037(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			local var_161_0 = arg_158_1.actors_["10058ui_story"]
			local var_161_1 = 0

			if var_161_1 < arg_158_1.time_ and arg_158_1.time_ <= var_161_1 + arg_161_0 and not isNil(var_161_0) and arg_158_1.var_.characterEffect10058ui_story == nil then
				arg_158_1.var_.characterEffect10058ui_story = var_161_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_161_2 = 0.200000002980232

			if var_161_1 <= arg_158_1.time_ and arg_158_1.time_ < var_161_1 + var_161_2 and not isNil(var_161_0) then
				local var_161_3 = (arg_158_1.time_ - var_161_1) / var_161_2

				if arg_158_1.var_.characterEffect10058ui_story and not isNil(var_161_0) then
					local var_161_4 = Mathf.Lerp(0, 0.5, var_161_3)

					arg_158_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_158_1.var_.characterEffect10058ui_story.fillRatio = var_161_4
				end
			end

			if arg_158_1.time_ >= var_161_1 + var_161_2 and arg_158_1.time_ < var_161_1 + var_161_2 + arg_161_0 and not isNil(var_161_0) and arg_158_1.var_.characterEffect10058ui_story then
				local var_161_5 = 0.5

				arg_158_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_158_1.var_.characterEffect10058ui_story.fillRatio = var_161_5
			end

			local var_161_6 = 0
			local var_161_7 = 1.15

			if var_161_6 < arg_158_1.time_ and arg_158_1.time_ <= var_161_6 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, false)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_8 = arg_158_1:GetWordFromCfg(319841036)
				local var_161_9 = arg_158_1:FormatText(var_161_8.content)

				arg_158_1.text_.text = var_161_9

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_10 = 46
				local var_161_11 = utf8.len(var_161_9)
				local var_161_12 = var_161_10 <= 0 and var_161_7 or var_161_7 * (var_161_11 / var_161_10)

				if var_161_12 > 0 and var_161_7 < var_161_12 then
					arg_158_1.talkMaxDuration = var_161_12

					if var_161_12 + var_161_6 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_12 + var_161_6
					end
				end

				arg_158_1.text_.text = var_161_9
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)
				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_13 = math.max(var_161_7, arg_158_1.talkMaxDuration)

			if var_161_6 <= arg_158_1.time_ and arg_158_1.time_ < var_161_6 + var_161_13 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_6) / var_161_13

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_6 + var_161_13 and arg_158_1.time_ < var_161_6 + var_161_13 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {}

		arg_158_1:InitPlayNodeList()
	end,
	Play319841037 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 319841037
		arg_162_1.duration_ = 1.7

		local var_162_0 = {
			zh = 1.266,
			ja = 1.7
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
				arg_162_0:Play319841038(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			local var_165_0 = arg_162_1.actors_["10058ui_story"]
			local var_165_1 = 0

			if var_165_1 < arg_162_1.time_ and arg_162_1.time_ <= var_165_1 + arg_165_0 and not isNil(var_165_0) and arg_162_1.var_.characterEffect10058ui_story == nil then
				arg_162_1.var_.characterEffect10058ui_story = var_165_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_165_2 = 0.200000002980232

			if var_165_1 <= arg_162_1.time_ and arg_162_1.time_ < var_165_1 + var_165_2 and not isNil(var_165_0) then
				local var_165_3 = (arg_162_1.time_ - var_165_1) / var_165_2

				if arg_162_1.var_.characterEffect10058ui_story and not isNil(var_165_0) then
					arg_162_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_162_1.time_ >= var_165_1 + var_165_2 and arg_162_1.time_ < var_165_1 + var_165_2 + arg_165_0 and not isNil(var_165_0) and arg_162_1.var_.characterEffect10058ui_story then
				arg_162_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_165_4 = 0
			local var_165_5 = 0.125

			if var_165_4 < arg_162_1.time_ and arg_162_1.time_ <= var_165_4 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, true)

				local var_165_6 = arg_162_1:FormatText(StoryNameCfg[471].name)

				arg_162_1.leftNameTxt_.text = var_165_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_162_1.leftNameTxt_.transform)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1.leftNameTxt_.text)
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_7 = arg_162_1:GetWordFromCfg(319841037)
				local var_165_8 = arg_162_1:FormatText(var_165_7.content)

				arg_162_1.text_.text = var_165_8

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_9 = 5
				local var_165_10 = utf8.len(var_165_8)
				local var_165_11 = var_165_9 <= 0 and var_165_5 or var_165_5 * (var_165_10 / var_165_9)

				if var_165_11 > 0 and var_165_5 < var_165_11 then
					arg_162_1.talkMaxDuration = var_165_11

					if var_165_11 + var_165_4 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_11 + var_165_4
					end
				end

				arg_162_1.text_.text = var_165_8
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319841", "319841037", "story_v_out_319841.awb") ~= 0 then
					local var_165_12 = manager.audio:GetVoiceLength("story_v_out_319841", "319841037", "story_v_out_319841.awb") / 1000

					if var_165_12 + var_165_4 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_12 + var_165_4
					end

					if var_165_7.prefab_name ~= "" and arg_162_1.actors_[var_165_7.prefab_name] ~= nil then
						local var_165_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_162_1.actors_[var_165_7.prefab_name].transform, "story_v_out_319841", "319841037", "story_v_out_319841.awb")

						arg_162_1:RecordAudio("319841037", var_165_13)
						arg_162_1:RecordAudio("319841037", var_165_13)
					else
						arg_162_1:AudioAction("play", "voice", "story_v_out_319841", "319841037", "story_v_out_319841.awb")
					end

					arg_162_1:RecordHistoryTalkVoice("story_v_out_319841", "319841037", "story_v_out_319841.awb")
				end

				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_14 = math.max(var_165_5, arg_162_1.talkMaxDuration)

			if var_165_4 <= arg_162_1.time_ and arg_162_1.time_ < var_165_4 + var_165_14 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_4) / var_165_14

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_4 + var_165_14 and arg_162_1.time_ < var_165_4 + var_165_14 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {}

		arg_162_1:InitPlayNodeList()
	end,
	Play319841038 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 319841038
		arg_166_1.duration_ = 7

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play319841039(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			local var_169_0 = arg_166_1.actors_["1084ui_story"].transform
			local var_169_1 = 1

			if var_169_1 < arg_166_1.time_ and arg_166_1.time_ <= var_169_1 + arg_169_0 then
				arg_166_1.var_.moveOldPos1084ui_story = var_169_0.localPosition
			end

			local var_169_2 = 0.001

			if var_169_1 <= arg_166_1.time_ and arg_166_1.time_ < var_169_1 + var_169_2 then
				local var_169_3 = (arg_166_1.time_ - var_169_1) / var_169_2
				local var_169_4 = Vector3.New(0, 100, 0)

				var_169_0.localPosition = Vector3.Lerp(arg_166_1.var_.moveOldPos1084ui_story, var_169_4, var_169_3)

				local var_169_5 = manager.ui.mainCamera.transform.position - var_169_0.position

				var_169_0.forward = Vector3.New(var_169_5.x, var_169_5.y, var_169_5.z)

				local var_169_6 = var_169_0.localEulerAngles

				var_169_6.z = 0
				var_169_6.x = 0
				var_169_0.localEulerAngles = var_169_6
			end

			if arg_166_1.time_ >= var_169_1 + var_169_2 and arg_166_1.time_ < var_169_1 + var_169_2 + arg_169_0 then
				var_169_0.localPosition = Vector3.New(0, 100, 0)

				local var_169_7 = manager.ui.mainCamera.transform.position - var_169_0.position

				var_169_0.forward = Vector3.New(var_169_7.x, var_169_7.y, var_169_7.z)

				local var_169_8 = var_169_0.localEulerAngles

				var_169_8.z = 0
				var_169_8.x = 0
				var_169_0.localEulerAngles = var_169_8
			end

			local var_169_9 = arg_166_1.actors_["10058ui_story"].transform
			local var_169_10 = 1

			if var_169_10 < arg_166_1.time_ and arg_166_1.time_ <= var_169_10 + arg_169_0 then
				arg_166_1.var_.moveOldPos10058ui_story = var_169_9.localPosition
			end

			local var_169_11 = 0.001

			if var_169_10 <= arg_166_1.time_ and arg_166_1.time_ < var_169_10 + var_169_11 then
				local var_169_12 = (arg_166_1.time_ - var_169_10) / var_169_11
				local var_169_13 = Vector3.New(0, 100, 0)

				var_169_9.localPosition = Vector3.Lerp(arg_166_1.var_.moveOldPos10058ui_story, var_169_13, var_169_12)

				local var_169_14 = manager.ui.mainCamera.transform.position - var_169_9.position

				var_169_9.forward = Vector3.New(var_169_14.x, var_169_14.y, var_169_14.z)

				local var_169_15 = var_169_9.localEulerAngles

				var_169_15.z = 0
				var_169_15.x = 0
				var_169_9.localEulerAngles = var_169_15
			end

			if arg_166_1.time_ >= var_169_10 + var_169_11 and arg_166_1.time_ < var_169_10 + var_169_11 + arg_169_0 then
				var_169_9.localPosition = Vector3.New(0, 100, 0)

				local var_169_16 = manager.ui.mainCamera.transform.position - var_169_9.position

				var_169_9.forward = Vector3.New(var_169_16.x, var_169_16.y, var_169_16.z)

				local var_169_17 = var_169_9.localEulerAngles

				var_169_17.z = 0
				var_169_17.x = 0
				var_169_9.localEulerAngles = var_169_17
			end

			local var_169_18 = 1

			if var_169_18 < arg_166_1.time_ and arg_166_1.time_ <= var_169_18 + arg_169_0 then
				local var_169_19 = manager.ui.mainCamera.transform.localPosition
				local var_169_20 = Vector3.New(0, 0, 10) + Vector3.New(var_169_19.x, var_169_19.y, 0)
				local var_169_21 = arg_166_1.bgs_.ST72

				var_169_21.transform.localPosition = var_169_20
				var_169_21.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_169_22 = var_169_21:GetComponent("SpriteRenderer")

				if var_169_22 and var_169_22.sprite then
					local var_169_23 = (var_169_21.transform.localPosition - var_169_19).z
					local var_169_24 = manager.ui.mainCameraCom_
					local var_169_25 = 2 * var_169_23 * Mathf.Tan(var_169_24.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_169_26 = var_169_25 * var_169_24.aspect
					local var_169_27 = var_169_22.sprite.bounds.size.x
					local var_169_28 = var_169_22.sprite.bounds.size.y
					local var_169_29 = var_169_26 / var_169_27
					local var_169_30 = var_169_25 / var_169_28
					local var_169_31 = var_169_30 < var_169_29 and var_169_29 or var_169_30

					var_169_21.transform.localScale = Vector3.New(var_169_31, var_169_31, 0)
				end

				for iter_169_0, iter_169_1 in pairs(arg_166_1.bgs_) do
					if iter_169_0 ~= "ST72" then
						iter_169_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_169_32 = 0

			if var_169_32 < arg_166_1.time_ and arg_166_1.time_ <= var_169_32 + arg_169_0 then
				arg_166_1.mask_.enabled = true
				arg_166_1.mask_.raycastTarget = true

				arg_166_1:SetGaussion(false)
			end

			local var_169_33 = 1

			if var_169_32 <= arg_166_1.time_ and arg_166_1.time_ < var_169_32 + var_169_33 then
				local var_169_34 = (arg_166_1.time_ - var_169_32) / var_169_33
				local var_169_35 = Color.New(0, 0, 0)

				var_169_35.a = Mathf.Lerp(0, 1, var_169_34)
				arg_166_1.mask_.color = var_169_35
			end

			if arg_166_1.time_ >= var_169_32 + var_169_33 and arg_166_1.time_ < var_169_32 + var_169_33 + arg_169_0 then
				local var_169_36 = Color.New(0, 0, 0)

				var_169_36.a = 1
				arg_166_1.mask_.color = var_169_36
			end

			local var_169_37 = 1

			if var_169_37 < arg_166_1.time_ and arg_166_1.time_ <= var_169_37 + arg_169_0 then
				arg_166_1.mask_.enabled = true
				arg_166_1.mask_.raycastTarget = true

				arg_166_1:SetGaussion(false)
			end

			local var_169_38 = 1

			if var_169_37 <= arg_166_1.time_ and arg_166_1.time_ < var_169_37 + var_169_38 then
				local var_169_39 = (arg_166_1.time_ - var_169_37) / var_169_38
				local var_169_40 = Color.New(0, 0, 0)

				var_169_40.a = Mathf.Lerp(1, 0, var_169_39)
				arg_166_1.mask_.color = var_169_40
			end

			if arg_166_1.time_ >= var_169_37 + var_169_38 and arg_166_1.time_ < var_169_37 + var_169_38 + arg_169_0 then
				local var_169_41 = Color.New(0, 0, 0)
				local var_169_42 = 0

				arg_166_1.mask_.enabled = false
				var_169_41.a = var_169_42
				arg_166_1.mask_.color = var_169_41
			end

			if arg_166_1.frameCnt_ <= 1 then
				arg_166_1.dialog_:SetActive(false)
			end

			local var_169_43 = 2
			local var_169_44 = 1.325

			if var_169_43 < arg_166_1.time_ and arg_166_1.time_ <= var_169_43 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0

				arg_166_1.dialog_:SetActive(true)

				arg_166_1.dialogCg_.alpha = 0

				local var_169_45 = LeanTween.value(arg_166_1.dialog_, 0, 1, 0.3)

				var_169_45:setOnUpdate(LuaHelper.FloatAction(function(arg_170_0)
					arg_166_1.dialogCg_.alpha = arg_170_0
				end))
				var_169_45:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_166_1.dialog_)
					var_169_45:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_166_1.duration_ = arg_166_1.duration_ + 0.3

				SetActive(arg_166_1.leftNameGo_, false)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_46 = arg_166_1:GetWordFromCfg(319841038)
				local var_169_47 = arg_166_1:FormatText(var_169_46.content)

				arg_166_1.text_.text = var_169_47

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_48 = 53
				local var_169_49 = utf8.len(var_169_47)
				local var_169_50 = var_169_48 <= 0 and var_169_44 or var_169_44 * (var_169_49 / var_169_48)

				if var_169_50 > 0 and var_169_44 < var_169_50 then
					arg_166_1.talkMaxDuration = var_169_50
					var_169_43 = var_169_43 + 0.3

					if var_169_50 + var_169_43 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_50 + var_169_43
					end
				end

				arg_166_1.text_.text = var_169_47
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)
				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_51 = var_169_43 + 0.3
			local var_169_52 = math.max(var_169_44, arg_166_1.talkMaxDuration)

			if var_169_51 <= arg_166_1.time_ and arg_166_1.time_ < var_169_51 + var_169_52 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_51) / var_169_52

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_51 + var_169_52 and arg_166_1.time_ < var_169_51 + var_169_52 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_166_1:InitPlayNodeList()
	end,
	Play319841039 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 319841039
		arg_172_1.duration_ = 3.37

		local var_172_0 = {
			zh = 3.266,
			ja = 3.366
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
				arg_172_0:Play319841040(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = arg_172_1.actors_["1084ui_story"].transform
			local var_175_1 = 0

			if var_175_1 < arg_172_1.time_ and arg_172_1.time_ <= var_175_1 + arg_175_0 then
				arg_172_1.var_.moveOldPos1084ui_story = var_175_0.localPosition
			end

			local var_175_2 = 0.001

			if var_175_1 <= arg_172_1.time_ and arg_172_1.time_ < var_175_1 + var_175_2 then
				local var_175_3 = (arg_172_1.time_ - var_175_1) / var_175_2
				local var_175_4 = Vector3.New(-0.7, -0.97, -6)

				var_175_0.localPosition = Vector3.Lerp(arg_172_1.var_.moveOldPos1084ui_story, var_175_4, var_175_3)

				local var_175_5 = manager.ui.mainCamera.transform.position - var_175_0.position

				var_175_0.forward = Vector3.New(var_175_5.x, var_175_5.y, var_175_5.z)

				local var_175_6 = var_175_0.localEulerAngles

				var_175_6.z = 0
				var_175_6.x = 0
				var_175_0.localEulerAngles = var_175_6
			end

			if arg_172_1.time_ >= var_175_1 + var_175_2 and arg_172_1.time_ < var_175_1 + var_175_2 + arg_175_0 then
				var_175_0.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_175_7 = manager.ui.mainCamera.transform.position - var_175_0.position

				var_175_0.forward = Vector3.New(var_175_7.x, var_175_7.y, var_175_7.z)

				local var_175_8 = var_175_0.localEulerAngles

				var_175_8.z = 0
				var_175_8.x = 0
				var_175_0.localEulerAngles = var_175_8
			end

			local var_175_9 = arg_172_1.actors_["1084ui_story"]
			local var_175_10 = 0

			if var_175_10 < arg_172_1.time_ and arg_172_1.time_ <= var_175_10 + arg_175_0 and not isNil(var_175_9) and arg_172_1.var_.characterEffect1084ui_story == nil then
				arg_172_1.var_.characterEffect1084ui_story = var_175_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_11 = 0.200000002980232

			if var_175_10 <= arg_172_1.time_ and arg_172_1.time_ < var_175_10 + var_175_11 and not isNil(var_175_9) then
				local var_175_12 = (arg_172_1.time_ - var_175_10) / var_175_11

				if arg_172_1.var_.characterEffect1084ui_story and not isNil(var_175_9) then
					arg_172_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_172_1.time_ >= var_175_10 + var_175_11 and arg_172_1.time_ < var_175_10 + var_175_11 + arg_175_0 and not isNil(var_175_9) and arg_172_1.var_.characterEffect1084ui_story then
				arg_172_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_175_13 = 0

			if var_175_13 < arg_172_1.time_ and arg_172_1.time_ <= var_175_13 + arg_175_0 then
				arg_172_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_2")
			end

			local var_175_14 = 0

			if var_175_14 < arg_172_1.time_ and arg_172_1.time_ <= var_175_14 + arg_175_0 then
				arg_172_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_175_15 = 0
			local var_175_16 = 0.325

			if var_175_15 < arg_172_1.time_ and arg_172_1.time_ <= var_175_15 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				local var_175_17 = arg_172_1:FormatText(StoryNameCfg[6].name)

				arg_172_1.leftNameTxt_.text = var_175_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_18 = arg_172_1:GetWordFromCfg(319841039)
				local var_175_19 = arg_172_1:FormatText(var_175_18.content)

				arg_172_1.text_.text = var_175_19

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_20 = 13
				local var_175_21 = utf8.len(var_175_19)
				local var_175_22 = var_175_20 <= 0 and var_175_16 or var_175_16 * (var_175_21 / var_175_20)

				if var_175_22 > 0 and var_175_16 < var_175_22 then
					arg_172_1.talkMaxDuration = var_175_22

					if var_175_22 + var_175_15 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_22 + var_175_15
					end
				end

				arg_172_1.text_.text = var_175_19
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319841", "319841039", "story_v_out_319841.awb") ~= 0 then
					local var_175_23 = manager.audio:GetVoiceLength("story_v_out_319841", "319841039", "story_v_out_319841.awb") / 1000

					if var_175_23 + var_175_15 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_23 + var_175_15
					end

					if var_175_18.prefab_name ~= "" and arg_172_1.actors_[var_175_18.prefab_name] ~= nil then
						local var_175_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_172_1.actors_[var_175_18.prefab_name].transform, "story_v_out_319841", "319841039", "story_v_out_319841.awb")

						arg_172_1:RecordAudio("319841039", var_175_24)
						arg_172_1:RecordAudio("319841039", var_175_24)
					else
						arg_172_1:AudioAction("play", "voice", "story_v_out_319841", "319841039", "story_v_out_319841.awb")
					end

					arg_172_1:RecordHistoryTalkVoice("story_v_out_319841", "319841039", "story_v_out_319841.awb")
				end

				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_25 = math.max(var_175_16, arg_172_1.talkMaxDuration)

			if var_175_15 <= arg_172_1.time_ and arg_172_1.time_ < var_175_15 + var_175_25 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_15) / var_175_25

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_15 + var_175_25 and arg_172_1.time_ < var_175_15 + var_175_25 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {
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

		arg_172_1:InitPlayNodeList()
	end,
	Play319841040 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 319841040
		arg_176_1.duration_ = 7.5

		local var_176_0 = {
			zh = 5.6,
			ja = 7.5
		}
		local var_176_1 = manager.audio:GetLocalizationFlag()

		if var_176_0[var_176_1] ~= nil then
			arg_176_1.duration_ = var_176_0[var_176_1]
		end

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play319841041(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			local var_179_0 = "10050ui_story"

			if arg_176_1.actors_[var_179_0] == nil then
				local var_179_1 = Asset.Load("Char/" .. "10050ui_story")

				if not isNil(var_179_1) then
					local var_179_2 = Object.Instantiate(Asset.Load("Char/" .. "10050ui_story"), arg_176_1.stage_.transform)

					var_179_2.name = var_179_0
					var_179_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_176_1.actors_[var_179_0] = var_179_2

					local var_179_3 = var_179_2:GetComponentInChildren(typeof(CharacterEffect))

					var_179_3.enabled = true

					local var_179_4 = GameObjectTools.GetOrAddComponent(var_179_2, typeof(DynamicBoneHelper))

					if var_179_4 then
						var_179_4:EnableDynamicBone(false)
					end

					arg_176_1:ShowWeapon(var_179_3.transform, false)

					arg_176_1.var_[var_179_0 .. "Animator"] = var_179_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_176_1.var_[var_179_0 .. "Animator"].applyRootMotion = true
					arg_176_1.var_[var_179_0 .. "LipSync"] = var_179_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_179_5 = arg_176_1.actors_["10050ui_story"].transform
			local var_179_6 = 0

			if var_179_6 < arg_176_1.time_ and arg_176_1.time_ <= var_179_6 + arg_179_0 then
				arg_176_1.var_.moveOldPos10050ui_story = var_179_5.localPosition
			end

			local var_179_7 = 0.001

			if var_179_6 <= arg_176_1.time_ and arg_176_1.time_ < var_179_6 + var_179_7 then
				local var_179_8 = (arg_176_1.time_ - var_179_6) / var_179_7
				local var_179_9 = Vector3.New(0.7, -0.715, -6.15)

				var_179_5.localPosition = Vector3.Lerp(arg_176_1.var_.moveOldPos10050ui_story, var_179_9, var_179_8)

				local var_179_10 = manager.ui.mainCamera.transform.position - var_179_5.position

				var_179_5.forward = Vector3.New(var_179_10.x, var_179_10.y, var_179_10.z)

				local var_179_11 = var_179_5.localEulerAngles

				var_179_11.z = 0
				var_179_11.x = 0
				var_179_5.localEulerAngles = var_179_11
			end

			if arg_176_1.time_ >= var_179_6 + var_179_7 and arg_176_1.time_ < var_179_6 + var_179_7 + arg_179_0 then
				var_179_5.localPosition = Vector3.New(0.7, -0.715, -6.15)

				local var_179_12 = manager.ui.mainCamera.transform.position - var_179_5.position

				var_179_5.forward = Vector3.New(var_179_12.x, var_179_12.y, var_179_12.z)

				local var_179_13 = var_179_5.localEulerAngles

				var_179_13.z = 0
				var_179_13.x = 0
				var_179_5.localEulerAngles = var_179_13
			end

			local var_179_14 = arg_176_1.actors_["10050ui_story"]
			local var_179_15 = 0

			if var_179_15 < arg_176_1.time_ and arg_176_1.time_ <= var_179_15 + arg_179_0 and not isNil(var_179_14) and arg_176_1.var_.characterEffect10050ui_story == nil then
				arg_176_1.var_.characterEffect10050ui_story = var_179_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_179_16 = 0.200000002980232

			if var_179_15 <= arg_176_1.time_ and arg_176_1.time_ < var_179_15 + var_179_16 and not isNil(var_179_14) then
				local var_179_17 = (arg_176_1.time_ - var_179_15) / var_179_16

				if arg_176_1.var_.characterEffect10050ui_story and not isNil(var_179_14) then
					arg_176_1.var_.characterEffect10050ui_story.fillFlat = false
				end
			end

			if arg_176_1.time_ >= var_179_15 + var_179_16 and arg_176_1.time_ < var_179_15 + var_179_16 + arg_179_0 and not isNil(var_179_14) and arg_176_1.var_.characterEffect10050ui_story then
				arg_176_1.var_.characterEffect10050ui_story.fillFlat = false
			end

			local var_179_18 = 0

			if var_179_18 < arg_176_1.time_ and arg_176_1.time_ <= var_179_18 + arg_179_0 then
				arg_176_1:PlayTimeline("10050ui_story", "StoryTimeline/CharAction/story10050/story10050action/10050action2_1")
			end

			local var_179_19 = 0

			if var_179_19 < arg_176_1.time_ and arg_176_1.time_ <= var_179_19 + arg_179_0 then
				arg_176_1:PlayTimeline("10050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_179_20 = arg_176_1.actors_["10058ui_story"].transform
			local var_179_21 = 0

			if var_179_21 < arg_176_1.time_ and arg_176_1.time_ <= var_179_21 + arg_179_0 then
				arg_176_1.var_.moveOldPos10058ui_story = var_179_20.localPosition
			end

			local var_179_22 = 0.001

			if var_179_21 <= arg_176_1.time_ and arg_176_1.time_ < var_179_21 + var_179_22 then
				local var_179_23 = (arg_176_1.time_ - var_179_21) / var_179_22
				local var_179_24 = Vector3.New(0, 100, 0)

				var_179_20.localPosition = Vector3.Lerp(arg_176_1.var_.moveOldPos10058ui_story, var_179_24, var_179_23)

				local var_179_25 = manager.ui.mainCamera.transform.position - var_179_20.position

				var_179_20.forward = Vector3.New(var_179_25.x, var_179_25.y, var_179_25.z)

				local var_179_26 = var_179_20.localEulerAngles

				var_179_26.z = 0
				var_179_26.x = 0
				var_179_20.localEulerAngles = var_179_26
			end

			if arg_176_1.time_ >= var_179_21 + var_179_22 and arg_176_1.time_ < var_179_21 + var_179_22 + arg_179_0 then
				var_179_20.localPosition = Vector3.New(0, 100, 0)

				local var_179_27 = manager.ui.mainCamera.transform.position - var_179_20.position

				var_179_20.forward = Vector3.New(var_179_27.x, var_179_27.y, var_179_27.z)

				local var_179_28 = var_179_20.localEulerAngles

				var_179_28.z = 0
				var_179_28.x = 0
				var_179_20.localEulerAngles = var_179_28
			end

			local var_179_29 = arg_176_1.actors_["10058ui_story"]
			local var_179_30 = 0

			if var_179_30 < arg_176_1.time_ and arg_176_1.time_ <= var_179_30 + arg_179_0 and not isNil(var_179_29) and arg_176_1.var_.characterEffect10058ui_story == nil then
				arg_176_1.var_.characterEffect10058ui_story = var_179_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_179_31 = 0.200000002980232

			if var_179_30 <= arg_176_1.time_ and arg_176_1.time_ < var_179_30 + var_179_31 and not isNil(var_179_29) then
				local var_179_32 = (arg_176_1.time_ - var_179_30) / var_179_31

				if arg_176_1.var_.characterEffect10058ui_story and not isNil(var_179_29) then
					local var_179_33 = Mathf.Lerp(0, 0.5, var_179_32)

					arg_176_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_176_1.var_.characterEffect10058ui_story.fillRatio = var_179_33
				end
			end

			if arg_176_1.time_ >= var_179_30 + var_179_31 and arg_176_1.time_ < var_179_30 + var_179_31 + arg_179_0 and not isNil(var_179_29) and arg_176_1.var_.characterEffect10058ui_story then
				local var_179_34 = 0.5

				arg_176_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_176_1.var_.characterEffect10058ui_story.fillRatio = var_179_34
			end

			local var_179_35 = arg_176_1.actors_["1084ui_story"].transform
			local var_179_36 = 0

			if var_179_36 < arg_176_1.time_ and arg_176_1.time_ <= var_179_36 + arg_179_0 then
				arg_176_1.var_.moveOldPos1084ui_story = var_179_35.localPosition
			end

			local var_179_37 = 0.001

			if var_179_36 <= arg_176_1.time_ and arg_176_1.time_ < var_179_36 + var_179_37 then
				local var_179_38 = (arg_176_1.time_ - var_179_36) / var_179_37
				local var_179_39 = Vector3.New(-0.7, -0.97, -6)

				var_179_35.localPosition = Vector3.Lerp(arg_176_1.var_.moveOldPos1084ui_story, var_179_39, var_179_38)

				local var_179_40 = manager.ui.mainCamera.transform.position - var_179_35.position

				var_179_35.forward = Vector3.New(var_179_40.x, var_179_40.y, var_179_40.z)

				local var_179_41 = var_179_35.localEulerAngles

				var_179_41.z = 0
				var_179_41.x = 0
				var_179_35.localEulerAngles = var_179_41
			end

			if arg_176_1.time_ >= var_179_36 + var_179_37 and arg_176_1.time_ < var_179_36 + var_179_37 + arg_179_0 then
				var_179_35.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_179_42 = manager.ui.mainCamera.transform.position - var_179_35.position

				var_179_35.forward = Vector3.New(var_179_42.x, var_179_42.y, var_179_42.z)

				local var_179_43 = var_179_35.localEulerAngles

				var_179_43.z = 0
				var_179_43.x = 0
				var_179_35.localEulerAngles = var_179_43
			end

			local var_179_44 = arg_176_1.actors_["1084ui_story"]
			local var_179_45 = 0

			if var_179_45 < arg_176_1.time_ and arg_176_1.time_ <= var_179_45 + arg_179_0 and not isNil(var_179_44) and arg_176_1.var_.characterEffect1084ui_story == nil then
				arg_176_1.var_.characterEffect1084ui_story = var_179_44:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_179_46 = 0.200000002980232

			if var_179_45 <= arg_176_1.time_ and arg_176_1.time_ < var_179_45 + var_179_46 and not isNil(var_179_44) then
				local var_179_47 = (arg_176_1.time_ - var_179_45) / var_179_46

				if arg_176_1.var_.characterEffect1084ui_story and not isNil(var_179_44) then
					local var_179_48 = Mathf.Lerp(0, 0.5, var_179_47)

					arg_176_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_176_1.var_.characterEffect1084ui_story.fillRatio = var_179_48
				end
			end

			if arg_176_1.time_ >= var_179_45 + var_179_46 and arg_176_1.time_ < var_179_45 + var_179_46 + arg_179_0 and not isNil(var_179_44) and arg_176_1.var_.characterEffect1084ui_story then
				local var_179_49 = 0.5

				arg_176_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_176_1.var_.characterEffect1084ui_story.fillRatio = var_179_49
			end

			local var_179_50 = 0
			local var_179_51 = 0.45

			if var_179_50 < arg_176_1.time_ and arg_176_1.time_ <= var_179_50 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				local var_179_52 = arg_176_1:FormatText(StoryNameCfg[692].name)

				arg_176_1.leftNameTxt_.text = var_179_52

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_53 = arg_176_1:GetWordFromCfg(319841040)
				local var_179_54 = arg_176_1:FormatText(var_179_53.content)

				arg_176_1.text_.text = var_179_54

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_55 = 18
				local var_179_56 = utf8.len(var_179_54)
				local var_179_57 = var_179_55 <= 0 and var_179_51 or var_179_51 * (var_179_56 / var_179_55)

				if var_179_57 > 0 and var_179_51 < var_179_57 then
					arg_176_1.talkMaxDuration = var_179_57

					if var_179_57 + var_179_50 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_57 + var_179_50
					end
				end

				arg_176_1.text_.text = var_179_54
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319841", "319841040", "story_v_out_319841.awb") ~= 0 then
					local var_179_58 = manager.audio:GetVoiceLength("story_v_out_319841", "319841040", "story_v_out_319841.awb") / 1000

					if var_179_58 + var_179_50 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_58 + var_179_50
					end

					if var_179_53.prefab_name ~= "" and arg_176_1.actors_[var_179_53.prefab_name] ~= nil then
						local var_179_59 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_53.prefab_name].transform, "story_v_out_319841", "319841040", "story_v_out_319841.awb")

						arg_176_1:RecordAudio("319841040", var_179_59)
						arg_176_1:RecordAudio("319841040", var_179_59)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_out_319841", "319841040", "story_v_out_319841.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_out_319841", "319841040", "story_v_out_319841.awb")
				end

				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_60 = math.max(var_179_51, arg_176_1.talkMaxDuration)

			if var_179_50 <= arg_176_1.time_ and arg_176_1.time_ < var_179_50 + var_179_60 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_50) / var_179_60

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_50 + var_179_60 and arg_176_1.time_ < var_179_50 + var_179_60 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10058ui_story",
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

		arg_176_1:InitPlayNodeList()
	end,
	Play319841041 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 319841041
		arg_180_1.duration_ = 5

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play319841042(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			local var_183_0 = arg_180_1.actors_["10050ui_story"]
			local var_183_1 = 0

			if var_183_1 < arg_180_1.time_ and arg_180_1.time_ <= var_183_1 + arg_183_0 and not isNil(var_183_0) and arg_180_1.var_.characterEffect10050ui_story == nil then
				arg_180_1.var_.characterEffect10050ui_story = var_183_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_183_2 = 0.200000002980232

			if var_183_1 <= arg_180_1.time_ and arg_180_1.time_ < var_183_1 + var_183_2 and not isNil(var_183_0) then
				local var_183_3 = (arg_180_1.time_ - var_183_1) / var_183_2

				if arg_180_1.var_.characterEffect10050ui_story and not isNil(var_183_0) then
					local var_183_4 = Mathf.Lerp(0, 0.5, var_183_3)

					arg_180_1.var_.characterEffect10050ui_story.fillFlat = true
					arg_180_1.var_.characterEffect10050ui_story.fillRatio = var_183_4
				end
			end

			if arg_180_1.time_ >= var_183_1 + var_183_2 and arg_180_1.time_ < var_183_1 + var_183_2 + arg_183_0 and not isNil(var_183_0) and arg_180_1.var_.characterEffect10050ui_story then
				local var_183_5 = 0.5

				arg_180_1.var_.characterEffect10050ui_story.fillFlat = true
				arg_180_1.var_.characterEffect10050ui_story.fillRatio = var_183_5
			end

			local var_183_6 = 0
			local var_183_7 = 1.1

			if var_183_6 < arg_180_1.time_ and arg_180_1.time_ <= var_183_6 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, false)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_8 = arg_180_1:GetWordFromCfg(319841041)
				local var_183_9 = arg_180_1:FormatText(var_183_8.content)

				arg_180_1.text_.text = var_183_9

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_10 = 44
				local var_183_11 = utf8.len(var_183_9)
				local var_183_12 = var_183_10 <= 0 and var_183_7 or var_183_7 * (var_183_11 / var_183_10)

				if var_183_12 > 0 and var_183_7 < var_183_12 then
					arg_180_1.talkMaxDuration = var_183_12

					if var_183_12 + var_183_6 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_12 + var_183_6
					end
				end

				arg_180_1.text_.text = var_183_9
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)
				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_13 = math.max(var_183_7, arg_180_1.talkMaxDuration)

			if var_183_6 <= arg_180_1.time_ and arg_180_1.time_ < var_183_6 + var_183_13 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_6) / var_183_13

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_6 + var_183_13 and arg_180_1.time_ < var_183_6 + var_183_13 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {}

		arg_180_1:InitPlayNodeList()
	end,
	Play319841042 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 319841042
		arg_184_1.duration_ = 6.2

		local var_184_0 = {
			zh = 6.2,
			ja = 6.1
		}
		local var_184_1 = manager.audio:GetLocalizationFlag()

		if var_184_0[var_184_1] ~= nil then
			arg_184_1.duration_ = var_184_0[var_184_1]
		end

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play319841043(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			local var_187_0 = arg_184_1.actors_["10050ui_story"]
			local var_187_1 = 0

			if var_187_1 < arg_184_1.time_ and arg_184_1.time_ <= var_187_1 + arg_187_0 and not isNil(var_187_0) and arg_184_1.var_.characterEffect10050ui_story == nil then
				arg_184_1.var_.characterEffect10050ui_story = var_187_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_187_2 = 0.200000002980232

			if var_187_1 <= arg_184_1.time_ and arg_184_1.time_ < var_187_1 + var_187_2 and not isNil(var_187_0) then
				local var_187_3 = (arg_184_1.time_ - var_187_1) / var_187_2

				if arg_184_1.var_.characterEffect10050ui_story and not isNil(var_187_0) then
					arg_184_1.var_.characterEffect10050ui_story.fillFlat = false
				end
			end

			if arg_184_1.time_ >= var_187_1 + var_187_2 and arg_184_1.time_ < var_187_1 + var_187_2 + arg_187_0 and not isNil(var_187_0) and arg_184_1.var_.characterEffect10050ui_story then
				arg_184_1.var_.characterEffect10050ui_story.fillFlat = false
			end

			local var_187_4 = 0

			if var_187_4 < arg_184_1.time_ and arg_184_1.time_ <= var_187_4 + arg_187_0 then
				arg_184_1:PlayTimeline("10050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2202cva")
			end

			local var_187_5 = 0

			if var_187_5 < arg_184_1.time_ and arg_184_1.time_ <= var_187_5 + arg_187_0 then
				arg_184_1:PlayTimeline("10050ui_story", "StoryTimeline/CharAction/story10050/story10050actionlink/10050action4211")
			end

			local var_187_6 = 0
			local var_187_7 = 0.75

			if var_187_6 < arg_184_1.time_ and arg_184_1.time_ <= var_187_6 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				local var_187_8 = arg_184_1:FormatText(StoryNameCfg[692].name)

				arg_184_1.leftNameTxt_.text = var_187_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_9 = arg_184_1:GetWordFromCfg(319841042)
				local var_187_10 = arg_184_1:FormatText(var_187_9.content)

				arg_184_1.text_.text = var_187_10

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_11 = 30
				local var_187_12 = utf8.len(var_187_10)
				local var_187_13 = var_187_11 <= 0 and var_187_7 or var_187_7 * (var_187_12 / var_187_11)

				if var_187_13 > 0 and var_187_7 < var_187_13 then
					arg_184_1.talkMaxDuration = var_187_13

					if var_187_13 + var_187_6 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_13 + var_187_6
					end
				end

				arg_184_1.text_.text = var_187_10
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319841", "319841042", "story_v_out_319841.awb") ~= 0 then
					local var_187_14 = manager.audio:GetVoiceLength("story_v_out_319841", "319841042", "story_v_out_319841.awb") / 1000

					if var_187_14 + var_187_6 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_14 + var_187_6
					end

					if var_187_9.prefab_name ~= "" and arg_184_1.actors_[var_187_9.prefab_name] ~= nil then
						local var_187_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_184_1.actors_[var_187_9.prefab_name].transform, "story_v_out_319841", "319841042", "story_v_out_319841.awb")

						arg_184_1:RecordAudio("319841042", var_187_15)
						arg_184_1:RecordAudio("319841042", var_187_15)
					else
						arg_184_1:AudioAction("play", "voice", "story_v_out_319841", "319841042", "story_v_out_319841.awb")
					end

					arg_184_1:RecordHistoryTalkVoice("story_v_out_319841", "319841042", "story_v_out_319841.awb")
				end

				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_16 = math.max(var_187_7, arg_184_1.talkMaxDuration)

			if var_187_6 <= arg_184_1.time_ and arg_184_1.time_ < var_187_6 + var_187_16 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_6) / var_187_16

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_6 + var_187_16 and arg_184_1.time_ < var_187_6 + var_187_16 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {}

		arg_184_1:InitPlayNodeList()
	end,
	Play319841043 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 319841043
		arg_188_1.duration_ = 3.03

		local var_188_0 = {
			zh = 1.066,
			ja = 3.033
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
				arg_188_0:Play319841044(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			local var_191_0 = 0
			local var_191_1 = 0.1

			if var_191_0 < arg_188_1.time_ and arg_188_1.time_ <= var_191_0 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, true)

				local var_191_2 = arg_188_1:FormatText(StoryNameCfg[692].name)

				arg_188_1.leftNameTxt_.text = var_191_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_3 = arg_188_1:GetWordFromCfg(319841043)
				local var_191_4 = arg_188_1:FormatText(var_191_3.content)

				arg_188_1.text_.text = var_191_4

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_5 = 4
				local var_191_6 = utf8.len(var_191_4)
				local var_191_7 = var_191_5 <= 0 and var_191_1 or var_191_1 * (var_191_6 / var_191_5)

				if var_191_7 > 0 and var_191_1 < var_191_7 then
					arg_188_1.talkMaxDuration = var_191_7

					if var_191_7 + var_191_0 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_7 + var_191_0
					end
				end

				arg_188_1.text_.text = var_191_4
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319841", "319841043", "story_v_out_319841.awb") ~= 0 then
					local var_191_8 = manager.audio:GetVoiceLength("story_v_out_319841", "319841043", "story_v_out_319841.awb") / 1000

					if var_191_8 + var_191_0 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_8 + var_191_0
					end

					if var_191_3.prefab_name ~= "" and arg_188_1.actors_[var_191_3.prefab_name] ~= nil then
						local var_191_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_188_1.actors_[var_191_3.prefab_name].transform, "story_v_out_319841", "319841043", "story_v_out_319841.awb")

						arg_188_1:RecordAudio("319841043", var_191_9)
						arg_188_1:RecordAudio("319841043", var_191_9)
					else
						arg_188_1:AudioAction("play", "voice", "story_v_out_319841", "319841043", "story_v_out_319841.awb")
					end

					arg_188_1:RecordHistoryTalkVoice("story_v_out_319841", "319841043", "story_v_out_319841.awb")
				end

				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_10 = math.max(var_191_1, arg_188_1.talkMaxDuration)

			if var_191_0 <= arg_188_1.time_ and arg_188_1.time_ < var_191_0 + var_191_10 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_0) / var_191_10

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_0 + var_191_10 and arg_188_1.time_ < var_191_0 + var_191_10 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {}

		arg_188_1:InitPlayNodeList()
	end,
	Play319841044 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 319841044
		arg_192_1.duration_ = 6.8

		local var_192_0 = {
			zh = 4.5,
			ja = 6.8
		}
		local var_192_1 = manager.audio:GetLocalizationFlag()

		if var_192_0[var_192_1] ~= nil then
			arg_192_1.duration_ = var_192_0[var_192_1]
		end

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play319841045(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			local var_195_0 = arg_192_1.actors_["1084ui_story"].transform
			local var_195_1 = 0

			if var_195_1 < arg_192_1.time_ and arg_192_1.time_ <= var_195_1 + arg_195_0 then
				arg_192_1.var_.moveOldPos1084ui_story = var_195_0.localPosition
			end

			local var_195_2 = 0.001

			if var_195_1 <= arg_192_1.time_ and arg_192_1.time_ < var_195_1 + var_195_2 then
				local var_195_3 = (arg_192_1.time_ - var_195_1) / var_195_2
				local var_195_4 = Vector3.New(-0.7, -0.97, -6)

				var_195_0.localPosition = Vector3.Lerp(arg_192_1.var_.moveOldPos1084ui_story, var_195_4, var_195_3)

				local var_195_5 = manager.ui.mainCamera.transform.position - var_195_0.position

				var_195_0.forward = Vector3.New(var_195_5.x, var_195_5.y, var_195_5.z)

				local var_195_6 = var_195_0.localEulerAngles

				var_195_6.z = 0
				var_195_6.x = 0
				var_195_0.localEulerAngles = var_195_6
			end

			if arg_192_1.time_ >= var_195_1 + var_195_2 and arg_192_1.time_ < var_195_1 + var_195_2 + arg_195_0 then
				var_195_0.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_195_7 = manager.ui.mainCamera.transform.position - var_195_0.position

				var_195_0.forward = Vector3.New(var_195_7.x, var_195_7.y, var_195_7.z)

				local var_195_8 = var_195_0.localEulerAngles

				var_195_8.z = 0
				var_195_8.x = 0
				var_195_0.localEulerAngles = var_195_8
			end

			local var_195_9 = arg_192_1.actors_["1084ui_story"]
			local var_195_10 = 0

			if var_195_10 < arg_192_1.time_ and arg_192_1.time_ <= var_195_10 + arg_195_0 and not isNil(var_195_9) and arg_192_1.var_.characterEffect1084ui_story == nil then
				arg_192_1.var_.characterEffect1084ui_story = var_195_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_195_11 = 0.200000002980232

			if var_195_10 <= arg_192_1.time_ and arg_192_1.time_ < var_195_10 + var_195_11 and not isNil(var_195_9) then
				local var_195_12 = (arg_192_1.time_ - var_195_10) / var_195_11

				if arg_192_1.var_.characterEffect1084ui_story and not isNil(var_195_9) then
					arg_192_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_192_1.time_ >= var_195_10 + var_195_11 and arg_192_1.time_ < var_195_10 + var_195_11 + arg_195_0 and not isNil(var_195_9) and arg_192_1.var_.characterEffect1084ui_story then
				arg_192_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_195_13 = 0

			if var_195_13 < arg_192_1.time_ and arg_192_1.time_ <= var_195_13 + arg_195_0 then
				arg_192_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_195_14 = 0

			if var_195_14 < arg_192_1.time_ and arg_192_1.time_ <= var_195_14 + arg_195_0 then
				arg_192_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_195_15 = arg_192_1.actors_["10050ui_story"].transform
			local var_195_16 = 0

			if var_195_16 < arg_192_1.time_ and arg_192_1.time_ <= var_195_16 + arg_195_0 then
				arg_192_1.var_.moveOldPos10050ui_story = var_195_15.localPosition
			end

			local var_195_17 = 0.001

			if var_195_16 <= arg_192_1.time_ and arg_192_1.time_ < var_195_16 + var_195_17 then
				local var_195_18 = (arg_192_1.time_ - var_195_16) / var_195_17
				local var_195_19 = Vector3.New(0.7, -0.715, -6.15)

				var_195_15.localPosition = Vector3.Lerp(arg_192_1.var_.moveOldPos10050ui_story, var_195_19, var_195_18)

				local var_195_20 = manager.ui.mainCamera.transform.position - var_195_15.position

				var_195_15.forward = Vector3.New(var_195_20.x, var_195_20.y, var_195_20.z)

				local var_195_21 = var_195_15.localEulerAngles

				var_195_21.z = 0
				var_195_21.x = 0
				var_195_15.localEulerAngles = var_195_21
			end

			if arg_192_1.time_ >= var_195_16 + var_195_17 and arg_192_1.time_ < var_195_16 + var_195_17 + arg_195_0 then
				var_195_15.localPosition = Vector3.New(0.7, -0.715, -6.15)

				local var_195_22 = manager.ui.mainCamera.transform.position - var_195_15.position

				var_195_15.forward = Vector3.New(var_195_22.x, var_195_22.y, var_195_22.z)

				local var_195_23 = var_195_15.localEulerAngles

				var_195_23.z = 0
				var_195_23.x = 0
				var_195_15.localEulerAngles = var_195_23
			end

			local var_195_24 = arg_192_1.actors_["10050ui_story"]
			local var_195_25 = 0

			if var_195_25 < arg_192_1.time_ and arg_192_1.time_ <= var_195_25 + arg_195_0 and not isNil(var_195_24) and arg_192_1.var_.characterEffect10050ui_story == nil then
				arg_192_1.var_.characterEffect10050ui_story = var_195_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_195_26 = 0.200000002980232

			if var_195_25 <= arg_192_1.time_ and arg_192_1.time_ < var_195_25 + var_195_26 and not isNil(var_195_24) then
				local var_195_27 = (arg_192_1.time_ - var_195_25) / var_195_26

				if arg_192_1.var_.characterEffect10050ui_story and not isNil(var_195_24) then
					local var_195_28 = Mathf.Lerp(0, 0.5, var_195_27)

					arg_192_1.var_.characterEffect10050ui_story.fillFlat = true
					arg_192_1.var_.characterEffect10050ui_story.fillRatio = var_195_28
				end
			end

			if arg_192_1.time_ >= var_195_25 + var_195_26 and arg_192_1.time_ < var_195_25 + var_195_26 + arg_195_0 and not isNil(var_195_24) and arg_192_1.var_.characterEffect10050ui_story then
				local var_195_29 = 0.5

				arg_192_1.var_.characterEffect10050ui_story.fillFlat = true
				arg_192_1.var_.characterEffect10050ui_story.fillRatio = var_195_29
			end

			local var_195_30 = 0
			local var_195_31 = 0.55

			if var_195_30 < arg_192_1.time_ and arg_192_1.time_ <= var_195_30 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				local var_195_32 = arg_192_1:FormatText(StoryNameCfg[6].name)

				arg_192_1.leftNameTxt_.text = var_195_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, false)
				arg_192_1.callingController_:SetSelectedState("normal")

				local var_195_33 = arg_192_1:GetWordFromCfg(319841044)
				local var_195_34 = arg_192_1:FormatText(var_195_33.content)

				arg_192_1.text_.text = var_195_34

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_35 = 22
				local var_195_36 = utf8.len(var_195_34)
				local var_195_37 = var_195_35 <= 0 and var_195_31 or var_195_31 * (var_195_36 / var_195_35)

				if var_195_37 > 0 and var_195_31 < var_195_37 then
					arg_192_1.talkMaxDuration = var_195_37

					if var_195_37 + var_195_30 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_37 + var_195_30
					end
				end

				arg_192_1.text_.text = var_195_34
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319841", "319841044", "story_v_out_319841.awb") ~= 0 then
					local var_195_38 = manager.audio:GetVoiceLength("story_v_out_319841", "319841044", "story_v_out_319841.awb") / 1000

					if var_195_38 + var_195_30 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_38 + var_195_30
					end

					if var_195_33.prefab_name ~= "" and arg_192_1.actors_[var_195_33.prefab_name] ~= nil then
						local var_195_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_192_1.actors_[var_195_33.prefab_name].transform, "story_v_out_319841", "319841044", "story_v_out_319841.awb")

						arg_192_1:RecordAudio("319841044", var_195_39)
						arg_192_1:RecordAudio("319841044", var_195_39)
					else
						arg_192_1:AudioAction("play", "voice", "story_v_out_319841", "319841044", "story_v_out_319841.awb")
					end

					arg_192_1:RecordHistoryTalkVoice("story_v_out_319841", "319841044", "story_v_out_319841.awb")
				end

				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_40 = math.max(var_195_31, arg_192_1.talkMaxDuration)

			if var_195_30 <= arg_192_1.time_ and arg_192_1.time_ < var_195_30 + var_195_40 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_30) / var_195_40

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_30 + var_195_40 and arg_192_1.time_ < var_195_30 + var_195_40 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {
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
				actorName = "10050ui_story",
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
	Play319841045 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 319841045
		arg_196_1.duration_ = 8.63

		local var_196_0 = {
			zh = 6.066,
			ja = 8.633
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
				arg_196_0:Play319841046(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			local var_199_0 = 0

			if var_199_0 < arg_196_1.time_ and arg_196_1.time_ <= var_199_0 + arg_199_0 then
				arg_196_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_1")
			end

			local var_199_1 = 0

			if var_199_1 < arg_196_1.time_ and arg_196_1.time_ <= var_199_1 + arg_199_0 then
				arg_196_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2201cva")
			end

			local var_199_2 = 0
			local var_199_3 = 0.775

			if var_199_2 < arg_196_1.time_ and arg_196_1.time_ <= var_199_2 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, true)

				local var_199_4 = arg_196_1:FormatText(StoryNameCfg[6].name)

				arg_196_1.leftNameTxt_.text = var_199_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_5 = arg_196_1:GetWordFromCfg(319841045)
				local var_199_6 = arg_196_1:FormatText(var_199_5.content)

				arg_196_1.text_.text = var_199_6

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_7 = 31
				local var_199_8 = utf8.len(var_199_6)
				local var_199_9 = var_199_7 <= 0 and var_199_3 or var_199_3 * (var_199_8 / var_199_7)

				if var_199_9 > 0 and var_199_3 < var_199_9 then
					arg_196_1.talkMaxDuration = var_199_9

					if var_199_9 + var_199_2 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_9 + var_199_2
					end
				end

				arg_196_1.text_.text = var_199_6
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319841", "319841045", "story_v_out_319841.awb") ~= 0 then
					local var_199_10 = manager.audio:GetVoiceLength("story_v_out_319841", "319841045", "story_v_out_319841.awb") / 1000

					if var_199_10 + var_199_2 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_10 + var_199_2
					end

					if var_199_5.prefab_name ~= "" and arg_196_1.actors_[var_199_5.prefab_name] ~= nil then
						local var_199_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_196_1.actors_[var_199_5.prefab_name].transform, "story_v_out_319841", "319841045", "story_v_out_319841.awb")

						arg_196_1:RecordAudio("319841045", var_199_11)
						arg_196_1:RecordAudio("319841045", var_199_11)
					else
						arg_196_1:AudioAction("play", "voice", "story_v_out_319841", "319841045", "story_v_out_319841.awb")
					end

					arg_196_1:RecordHistoryTalkVoice("story_v_out_319841", "319841045", "story_v_out_319841.awb")
				end

				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_12 = math.max(var_199_3, arg_196_1.talkMaxDuration)

			if var_199_2 <= arg_196_1.time_ and arg_196_1.time_ < var_199_2 + var_199_12 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_2) / var_199_12

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_2 + var_199_12 and arg_196_1.time_ < var_199_2 + var_199_12 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {}

		arg_196_1:InitPlayNodeList()
	end,
	Play319841046 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 319841046
		arg_200_1.duration_ = 15.4

		local var_200_0 = {
			zh = 15.4,
			ja = 12.466
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
				arg_200_0:Play319841047(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			local var_203_0 = arg_200_1.actors_["10050ui_story"]
			local var_203_1 = 0

			if var_203_1 < arg_200_1.time_ and arg_200_1.time_ <= var_203_1 + arg_203_0 and not isNil(var_203_0) and arg_200_1.var_.characterEffect10050ui_story == nil then
				arg_200_1.var_.characterEffect10050ui_story = var_203_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_203_2 = 0.200000002980232

			if var_203_1 <= arg_200_1.time_ and arg_200_1.time_ < var_203_1 + var_203_2 and not isNil(var_203_0) then
				local var_203_3 = (arg_200_1.time_ - var_203_1) / var_203_2

				if arg_200_1.var_.characterEffect10050ui_story and not isNil(var_203_0) then
					arg_200_1.var_.characterEffect10050ui_story.fillFlat = false
				end
			end

			if arg_200_1.time_ >= var_203_1 + var_203_2 and arg_200_1.time_ < var_203_1 + var_203_2 + arg_203_0 and not isNil(var_203_0) and arg_200_1.var_.characterEffect10050ui_story then
				arg_200_1.var_.characterEffect10050ui_story.fillFlat = false
			end

			local var_203_4 = arg_200_1.actors_["1084ui_story"]
			local var_203_5 = 0

			if var_203_5 < arg_200_1.time_ and arg_200_1.time_ <= var_203_5 + arg_203_0 and not isNil(var_203_4) and arg_200_1.var_.characterEffect1084ui_story == nil then
				arg_200_1.var_.characterEffect1084ui_story = var_203_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_203_6 = 0.200000002980232

			if var_203_5 <= arg_200_1.time_ and arg_200_1.time_ < var_203_5 + var_203_6 and not isNil(var_203_4) then
				local var_203_7 = (arg_200_1.time_ - var_203_5) / var_203_6

				if arg_200_1.var_.characterEffect1084ui_story and not isNil(var_203_4) then
					local var_203_8 = Mathf.Lerp(0, 0.5, var_203_7)

					arg_200_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_200_1.var_.characterEffect1084ui_story.fillRatio = var_203_8
				end
			end

			if arg_200_1.time_ >= var_203_5 + var_203_6 and arg_200_1.time_ < var_203_5 + var_203_6 + arg_203_0 and not isNil(var_203_4) and arg_200_1.var_.characterEffect1084ui_story then
				local var_203_9 = 0.5

				arg_200_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_200_1.var_.characterEffect1084ui_story.fillRatio = var_203_9
			end

			local var_203_10 = 0
			local var_203_11 = 1.35

			if var_203_10 < arg_200_1.time_ and arg_200_1.time_ <= var_203_10 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, true)

				local var_203_12 = arg_200_1:FormatText(StoryNameCfg[692].name)

				arg_200_1.leftNameTxt_.text = var_203_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_200_1.leftNameTxt_.transform)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1.leftNameTxt_.text)
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_13 = arg_200_1:GetWordFromCfg(319841046)
				local var_203_14 = arg_200_1:FormatText(var_203_13.content)

				arg_200_1.text_.text = var_203_14

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_15 = 54
				local var_203_16 = utf8.len(var_203_14)
				local var_203_17 = var_203_15 <= 0 and var_203_11 or var_203_11 * (var_203_16 / var_203_15)

				if var_203_17 > 0 and var_203_11 < var_203_17 then
					arg_200_1.talkMaxDuration = var_203_17

					if var_203_17 + var_203_10 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_17 + var_203_10
					end
				end

				arg_200_1.text_.text = var_203_14
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319841", "319841046", "story_v_out_319841.awb") ~= 0 then
					local var_203_18 = manager.audio:GetVoiceLength("story_v_out_319841", "319841046", "story_v_out_319841.awb") / 1000

					if var_203_18 + var_203_10 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_18 + var_203_10
					end

					if var_203_13.prefab_name ~= "" and arg_200_1.actors_[var_203_13.prefab_name] ~= nil then
						local var_203_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_200_1.actors_[var_203_13.prefab_name].transform, "story_v_out_319841", "319841046", "story_v_out_319841.awb")

						arg_200_1:RecordAudio("319841046", var_203_19)
						arg_200_1:RecordAudio("319841046", var_203_19)
					else
						arg_200_1:AudioAction("play", "voice", "story_v_out_319841", "319841046", "story_v_out_319841.awb")
					end

					arg_200_1:RecordHistoryTalkVoice("story_v_out_319841", "319841046", "story_v_out_319841.awb")
				end

				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_20 = math.max(var_203_11, arg_200_1.talkMaxDuration)

			if var_203_10 <= arg_200_1.time_ and arg_200_1.time_ < var_203_10 + var_203_20 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_10) / var_203_20

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_10 + var_203_20 and arg_200_1.time_ < var_203_10 + var_203_20 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {}

		arg_200_1:InitPlayNodeList()
	end,
	Play319841047 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 319841047
		arg_204_1.duration_ = 9.63

		local var_204_0 = {
			zh = 9.4,
			ja = 9.633
		}
		local var_204_1 = manager.audio:GetLocalizationFlag()

		if var_204_0[var_204_1] ~= nil then
			arg_204_1.duration_ = var_204_0[var_204_1]
		end

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play319841048(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			local var_207_0 = 0

			if var_207_0 < arg_204_1.time_ and arg_204_1.time_ <= var_207_0 + arg_207_0 then
				arg_204_1:PlayTimeline("10050ui_story", "StoryTimeline/CharAction/story10050/story10050action/10050action11_2")
			end

			local var_207_1 = 0

			if var_207_1 < arg_204_1.time_ and arg_204_1.time_ <= var_207_1 + arg_207_0 then
				arg_204_1:PlayTimeline("10050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_207_2 = 0
			local var_207_3 = 0.975

			if var_207_2 < arg_204_1.time_ and arg_204_1.time_ <= var_207_2 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				local var_207_4 = arg_204_1:FormatText(StoryNameCfg[692].name)

				arg_204_1.leftNameTxt_.text = var_207_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, false)
				arg_204_1.callingController_:SetSelectedState("normal")

				local var_207_5 = arg_204_1:GetWordFromCfg(319841047)
				local var_207_6 = arg_204_1:FormatText(var_207_5.content)

				arg_204_1.text_.text = var_207_6

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_7 = 39
				local var_207_8 = utf8.len(var_207_6)
				local var_207_9 = var_207_7 <= 0 and var_207_3 or var_207_3 * (var_207_8 / var_207_7)

				if var_207_9 > 0 and var_207_3 < var_207_9 then
					arg_204_1.talkMaxDuration = var_207_9

					if var_207_9 + var_207_2 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_9 + var_207_2
					end
				end

				arg_204_1.text_.text = var_207_6
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319841", "319841047", "story_v_out_319841.awb") ~= 0 then
					local var_207_10 = manager.audio:GetVoiceLength("story_v_out_319841", "319841047", "story_v_out_319841.awb") / 1000

					if var_207_10 + var_207_2 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_10 + var_207_2
					end

					if var_207_5.prefab_name ~= "" and arg_204_1.actors_[var_207_5.prefab_name] ~= nil then
						local var_207_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_204_1.actors_[var_207_5.prefab_name].transform, "story_v_out_319841", "319841047", "story_v_out_319841.awb")

						arg_204_1:RecordAudio("319841047", var_207_11)
						arg_204_1:RecordAudio("319841047", var_207_11)
					else
						arg_204_1:AudioAction("play", "voice", "story_v_out_319841", "319841047", "story_v_out_319841.awb")
					end

					arg_204_1:RecordHistoryTalkVoice("story_v_out_319841", "319841047", "story_v_out_319841.awb")
				end

				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_12 = math.max(var_207_3, arg_204_1.talkMaxDuration)

			if var_207_2 <= arg_204_1.time_ and arg_204_1.time_ < var_207_2 + var_207_12 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_2) / var_207_12

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_2 + var_207_12 and arg_204_1.time_ < var_207_2 + var_207_12 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {}

		arg_204_1:InitPlayNodeList()
	end,
	Play319841048 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 319841048
		arg_208_1.duration_ = 19.27

		local var_208_0 = {
			zh = 12.933,
			ja = 19.266
		}
		local var_208_1 = manager.audio:GetLocalizationFlag()

		if var_208_0[var_208_1] ~= nil then
			arg_208_1.duration_ = var_208_0[var_208_1]
		end

		SetActive(arg_208_1.tipsGo_, false)

		function arg_208_1.onSingleLineFinish_()
			arg_208_1.onSingleLineUpdate_ = nil
			arg_208_1.onSingleLineFinish_ = nil
			arg_208_1.state_ = "waiting"
		end

		function arg_208_1.playNext_(arg_210_0)
			if arg_210_0 == 1 then
				arg_208_0:Play319841049(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			local var_211_0 = 0

			if var_211_0 < arg_208_1.time_ and arg_208_1.time_ <= var_211_0 + arg_211_0 then
				arg_208_1:PlayTimeline("10050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_211_1 = 0
			local var_211_2 = 1.275

			if var_211_1 < arg_208_1.time_ and arg_208_1.time_ <= var_211_1 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, true)

				local var_211_3 = arg_208_1:FormatText(StoryNameCfg[692].name)

				arg_208_1.leftNameTxt_.text = var_211_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_208_1.leftNameTxt_.transform)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1.leftNameTxt_.text)
				SetActive(arg_208_1.iconTrs_.gameObject, false)
				arg_208_1.callingController_:SetSelectedState("normal")

				local var_211_4 = arg_208_1:GetWordFromCfg(319841048)
				local var_211_5 = arg_208_1:FormatText(var_211_4.content)

				arg_208_1.text_.text = var_211_5

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_6 = 51
				local var_211_7 = utf8.len(var_211_5)
				local var_211_8 = var_211_6 <= 0 and var_211_2 or var_211_2 * (var_211_7 / var_211_6)

				if var_211_8 > 0 and var_211_2 < var_211_8 then
					arg_208_1.talkMaxDuration = var_211_8

					if var_211_8 + var_211_1 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_8 + var_211_1
					end
				end

				arg_208_1.text_.text = var_211_5
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319841", "319841048", "story_v_out_319841.awb") ~= 0 then
					local var_211_9 = manager.audio:GetVoiceLength("story_v_out_319841", "319841048", "story_v_out_319841.awb") / 1000

					if var_211_9 + var_211_1 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_9 + var_211_1
					end

					if var_211_4.prefab_name ~= "" and arg_208_1.actors_[var_211_4.prefab_name] ~= nil then
						local var_211_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_208_1.actors_[var_211_4.prefab_name].transform, "story_v_out_319841", "319841048", "story_v_out_319841.awb")

						arg_208_1:RecordAudio("319841048", var_211_10)
						arg_208_1:RecordAudio("319841048", var_211_10)
					else
						arg_208_1:AudioAction("play", "voice", "story_v_out_319841", "319841048", "story_v_out_319841.awb")
					end

					arg_208_1:RecordHistoryTalkVoice("story_v_out_319841", "319841048", "story_v_out_319841.awb")
				end

				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_11 = math.max(var_211_2, arg_208_1.talkMaxDuration)

			if var_211_1 <= arg_208_1.time_ and arg_208_1.time_ < var_211_1 + var_211_11 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_1) / var_211_11

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_1 + var_211_11 and arg_208_1.time_ < var_211_1 + var_211_11 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {}

		arg_208_1:InitPlayNodeList()
	end,
	Play319841049 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 319841049
		arg_212_1.duration_ = 2

		SetActive(arg_212_1.tipsGo_, false)

		function arg_212_1.onSingleLineFinish_()
			arg_212_1.onSingleLineUpdate_ = nil
			arg_212_1.onSingleLineFinish_ = nil
			arg_212_1.state_ = "waiting"
		end

		function arg_212_1.playNext_(arg_214_0)
			if arg_214_0 == 1 then
				arg_212_0:Play319841050(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			local var_215_0 = arg_212_1.actors_["1084ui_story"].transform
			local var_215_1 = 0

			if var_215_1 < arg_212_1.time_ and arg_212_1.time_ <= var_215_1 + arg_215_0 then
				arg_212_1.var_.moveOldPos1084ui_story = var_215_0.localPosition
			end

			local var_215_2 = 0.001

			if var_215_1 <= arg_212_1.time_ and arg_212_1.time_ < var_215_1 + var_215_2 then
				local var_215_3 = (arg_212_1.time_ - var_215_1) / var_215_2
				local var_215_4 = Vector3.New(-0.7, -0.97, -6)

				var_215_0.localPosition = Vector3.Lerp(arg_212_1.var_.moveOldPos1084ui_story, var_215_4, var_215_3)

				local var_215_5 = manager.ui.mainCamera.transform.position - var_215_0.position

				var_215_0.forward = Vector3.New(var_215_5.x, var_215_5.y, var_215_5.z)

				local var_215_6 = var_215_0.localEulerAngles

				var_215_6.z = 0
				var_215_6.x = 0
				var_215_0.localEulerAngles = var_215_6
			end

			if arg_212_1.time_ >= var_215_1 + var_215_2 and arg_212_1.time_ < var_215_1 + var_215_2 + arg_215_0 then
				var_215_0.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_215_7 = manager.ui.mainCamera.transform.position - var_215_0.position

				var_215_0.forward = Vector3.New(var_215_7.x, var_215_7.y, var_215_7.z)

				local var_215_8 = var_215_0.localEulerAngles

				var_215_8.z = 0
				var_215_8.x = 0
				var_215_0.localEulerAngles = var_215_8
			end

			local var_215_9 = arg_212_1.actors_["1084ui_story"]
			local var_215_10 = 0

			if var_215_10 < arg_212_1.time_ and arg_212_1.time_ <= var_215_10 + arg_215_0 and not isNil(var_215_9) and arg_212_1.var_.characterEffect1084ui_story == nil then
				arg_212_1.var_.characterEffect1084ui_story = var_215_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_215_11 = 0.200000002980232

			if var_215_10 <= arg_212_1.time_ and arg_212_1.time_ < var_215_10 + var_215_11 and not isNil(var_215_9) then
				local var_215_12 = (arg_212_1.time_ - var_215_10) / var_215_11

				if arg_212_1.var_.characterEffect1084ui_story and not isNil(var_215_9) then
					arg_212_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_212_1.time_ >= var_215_10 + var_215_11 and arg_212_1.time_ < var_215_10 + var_215_11 + arg_215_0 and not isNil(var_215_9) and arg_212_1.var_.characterEffect1084ui_story then
				arg_212_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_215_13 = 0

			if var_215_13 < arg_212_1.time_ and arg_212_1.time_ <= var_215_13 + arg_215_0 then
				arg_212_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_2")
			end

			local var_215_14 = 0

			if var_215_14 < arg_212_1.time_ and arg_212_1.time_ <= var_215_14 + arg_215_0 then
				arg_212_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_215_15 = arg_212_1.actors_["10050ui_story"]
			local var_215_16 = 0

			if var_215_16 < arg_212_1.time_ and arg_212_1.time_ <= var_215_16 + arg_215_0 and not isNil(var_215_15) and arg_212_1.var_.characterEffect10050ui_story == nil then
				arg_212_1.var_.characterEffect10050ui_story = var_215_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_215_17 = 0.200000002980232

			if var_215_16 <= arg_212_1.time_ and arg_212_1.time_ < var_215_16 + var_215_17 and not isNil(var_215_15) then
				local var_215_18 = (arg_212_1.time_ - var_215_16) / var_215_17

				if arg_212_1.var_.characterEffect10050ui_story and not isNil(var_215_15) then
					local var_215_19 = Mathf.Lerp(0, 0.5, var_215_18)

					arg_212_1.var_.characterEffect10050ui_story.fillFlat = true
					arg_212_1.var_.characterEffect10050ui_story.fillRatio = var_215_19
				end
			end

			if arg_212_1.time_ >= var_215_16 + var_215_17 and arg_212_1.time_ < var_215_16 + var_215_17 + arg_215_0 and not isNil(var_215_15) and arg_212_1.var_.characterEffect10050ui_story then
				local var_215_20 = 0.5

				arg_212_1.var_.characterEffect10050ui_story.fillFlat = true
				arg_212_1.var_.characterEffect10050ui_story.fillRatio = var_215_20
			end

			local var_215_21 = 0
			local var_215_22 = 0.075

			if var_215_21 < arg_212_1.time_ and arg_212_1.time_ <= var_215_21 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, true)

				local var_215_23 = arg_212_1:FormatText(StoryNameCfg[6].name)

				arg_212_1.leftNameTxt_.text = var_215_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_212_1.leftNameTxt_.transform)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1.leftNameTxt_.text)
				SetActive(arg_212_1.iconTrs_.gameObject, false)
				arg_212_1.callingController_:SetSelectedState("normal")

				local var_215_24 = arg_212_1:GetWordFromCfg(319841049)
				local var_215_25 = arg_212_1:FormatText(var_215_24.content)

				arg_212_1.text_.text = var_215_25

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_26 = 3
				local var_215_27 = utf8.len(var_215_25)
				local var_215_28 = var_215_26 <= 0 and var_215_22 or var_215_22 * (var_215_27 / var_215_26)

				if var_215_28 > 0 and var_215_22 < var_215_28 then
					arg_212_1.talkMaxDuration = var_215_28

					if var_215_28 + var_215_21 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_28 + var_215_21
					end
				end

				arg_212_1.text_.text = var_215_25
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319841", "319841049", "story_v_out_319841.awb") ~= 0 then
					local var_215_29 = manager.audio:GetVoiceLength("story_v_out_319841", "319841049", "story_v_out_319841.awb") / 1000

					if var_215_29 + var_215_21 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_29 + var_215_21
					end

					if var_215_24.prefab_name ~= "" and arg_212_1.actors_[var_215_24.prefab_name] ~= nil then
						local var_215_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_212_1.actors_[var_215_24.prefab_name].transform, "story_v_out_319841", "319841049", "story_v_out_319841.awb")

						arg_212_1:RecordAudio("319841049", var_215_30)
						arg_212_1:RecordAudio("319841049", var_215_30)
					else
						arg_212_1:AudioAction("play", "voice", "story_v_out_319841", "319841049", "story_v_out_319841.awb")
					end

					arg_212_1:RecordHistoryTalkVoice("story_v_out_319841", "319841049", "story_v_out_319841.awb")
				end

				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_31 = math.max(var_215_22, arg_212_1.talkMaxDuration)

			if var_215_21 <= arg_212_1.time_ and arg_212_1.time_ < var_215_21 + var_215_31 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - var_215_21) / var_215_31

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= var_215_21 + var_215_31 and arg_212_1.time_ < var_215_21 + var_215_31 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {
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

		arg_212_1:InitPlayNodeList()
	end,
	Play319841050 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 319841050
		arg_216_1.duration_ = 5.75

		local var_216_0 = {
			zh = 4.41254639732651,
			ja = 5.74554639732651
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
				arg_216_0:Play319841051(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			local var_219_0 = arg_216_1.actors_["10069ui_story"].transform
			local var_219_1 = 0

			if var_219_1 < arg_216_1.time_ and arg_216_1.time_ <= var_219_1 + arg_219_0 then
				arg_216_1.var_.moveOldPos10069ui_story = var_219_0.localPosition
			end

			local var_219_2 = 0.001

			if var_219_1 <= arg_216_1.time_ and arg_216_1.time_ < var_219_1 + var_219_2 then
				local var_219_3 = (arg_216_1.time_ - var_219_1) / var_219_2
				local var_219_4 = Vector3.New(0, -1.08, -6.33)

				var_219_0.localPosition = Vector3.Lerp(arg_216_1.var_.moveOldPos10069ui_story, var_219_4, var_219_3)

				local var_219_5 = manager.ui.mainCamera.transform.position - var_219_0.position

				var_219_0.forward = Vector3.New(var_219_5.x, var_219_5.y, var_219_5.z)

				local var_219_6 = var_219_0.localEulerAngles

				var_219_6.z = 0
				var_219_6.x = 0
				var_219_0.localEulerAngles = var_219_6
			end

			if arg_216_1.time_ >= var_219_1 + var_219_2 and arg_216_1.time_ < var_219_1 + var_219_2 + arg_219_0 then
				var_219_0.localPosition = Vector3.New(0, -1.08, -6.33)

				local var_219_7 = manager.ui.mainCamera.transform.position - var_219_0.position

				var_219_0.forward = Vector3.New(var_219_7.x, var_219_7.y, var_219_7.z)

				local var_219_8 = var_219_0.localEulerAngles

				var_219_8.z = 0
				var_219_8.x = 0
				var_219_0.localEulerAngles = var_219_8
			end

			local var_219_9 = arg_216_1.actors_["10069ui_story"]
			local var_219_10 = 0

			if var_219_10 < arg_216_1.time_ and arg_216_1.time_ <= var_219_10 + arg_219_0 and not isNil(var_219_9) and arg_216_1.var_.characterEffect10069ui_story == nil then
				arg_216_1.var_.characterEffect10069ui_story = var_219_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_219_11 = 0.200000002980232

			if var_219_10 <= arg_216_1.time_ and arg_216_1.time_ < var_219_10 + var_219_11 and not isNil(var_219_9) then
				local var_219_12 = (arg_216_1.time_ - var_219_10) / var_219_11

				if arg_216_1.var_.characterEffect10069ui_story and not isNil(var_219_9) then
					arg_216_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_216_1.time_ >= var_219_10 + var_219_11 and arg_216_1.time_ < var_219_10 + var_219_11 + arg_219_0 and not isNil(var_219_9) and arg_216_1.var_.characterEffect10069ui_story then
				arg_216_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			local var_219_13 = 0

			if var_219_13 < arg_216_1.time_ and arg_216_1.time_ <= var_219_13 + arg_219_0 then
				arg_216_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/story10056/story10056action/10056action6_2")
			end

			local var_219_14 = 0

			if var_219_14 < arg_216_1.time_ and arg_216_1.time_ <= var_219_14 + arg_219_0 then
				arg_216_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_219_15 = arg_216_1.actors_["1084ui_story"].transform
			local var_219_16 = 0

			if var_219_16 < arg_216_1.time_ and arg_216_1.time_ <= var_219_16 + arg_219_0 then
				arg_216_1.var_.moveOldPos1084ui_story = var_219_15.localPosition
			end

			local var_219_17 = 0.001

			if var_219_16 <= arg_216_1.time_ and arg_216_1.time_ < var_219_16 + var_219_17 then
				local var_219_18 = (arg_216_1.time_ - var_219_16) / var_219_17
				local var_219_19 = Vector3.New(0, 100, 0)

				var_219_15.localPosition = Vector3.Lerp(arg_216_1.var_.moveOldPos1084ui_story, var_219_19, var_219_18)

				local var_219_20 = manager.ui.mainCamera.transform.position - var_219_15.position

				var_219_15.forward = Vector3.New(var_219_20.x, var_219_20.y, var_219_20.z)

				local var_219_21 = var_219_15.localEulerAngles

				var_219_21.z = 0
				var_219_21.x = 0
				var_219_15.localEulerAngles = var_219_21
			end

			if arg_216_1.time_ >= var_219_16 + var_219_17 and arg_216_1.time_ < var_219_16 + var_219_17 + arg_219_0 then
				var_219_15.localPosition = Vector3.New(0, 100, 0)

				local var_219_22 = manager.ui.mainCamera.transform.position - var_219_15.position

				var_219_15.forward = Vector3.New(var_219_22.x, var_219_22.y, var_219_22.z)

				local var_219_23 = var_219_15.localEulerAngles

				var_219_23.z = 0
				var_219_23.x = 0
				var_219_15.localEulerAngles = var_219_23
			end

			local var_219_24 = arg_216_1.actors_["1084ui_story"]
			local var_219_25 = 0

			if var_219_25 < arg_216_1.time_ and arg_216_1.time_ <= var_219_25 + arg_219_0 and not isNil(var_219_24) and arg_216_1.var_.characterEffect1084ui_story == nil then
				arg_216_1.var_.characterEffect1084ui_story = var_219_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_219_26 = 0.200000002980232

			if var_219_25 <= arg_216_1.time_ and arg_216_1.time_ < var_219_25 + var_219_26 and not isNil(var_219_24) then
				local var_219_27 = (arg_216_1.time_ - var_219_25) / var_219_26

				if arg_216_1.var_.characterEffect1084ui_story and not isNil(var_219_24) then
					local var_219_28 = Mathf.Lerp(0, 0.5, var_219_27)

					arg_216_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_216_1.var_.characterEffect1084ui_story.fillRatio = var_219_28
				end
			end

			if arg_216_1.time_ >= var_219_25 + var_219_26 and arg_216_1.time_ < var_219_25 + var_219_26 + arg_219_0 and not isNil(var_219_24) and arg_216_1.var_.characterEffect1084ui_story then
				local var_219_29 = 0.5

				arg_216_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_216_1.var_.characterEffect1084ui_story.fillRatio = var_219_29
			end

			local var_219_30 = arg_216_1.actors_["10050ui_story"].transform
			local var_219_31 = 0

			if var_219_31 < arg_216_1.time_ and arg_216_1.time_ <= var_219_31 + arg_219_0 then
				arg_216_1.var_.moveOldPos10050ui_story = var_219_30.localPosition
			end

			local var_219_32 = 0.001

			if var_219_31 <= arg_216_1.time_ and arg_216_1.time_ < var_219_31 + var_219_32 then
				local var_219_33 = (arg_216_1.time_ - var_219_31) / var_219_32
				local var_219_34 = Vector3.New(0, 100, 0)

				var_219_30.localPosition = Vector3.Lerp(arg_216_1.var_.moveOldPos10050ui_story, var_219_34, var_219_33)

				local var_219_35 = manager.ui.mainCamera.transform.position - var_219_30.position

				var_219_30.forward = Vector3.New(var_219_35.x, var_219_35.y, var_219_35.z)

				local var_219_36 = var_219_30.localEulerAngles

				var_219_36.z = 0
				var_219_36.x = 0
				var_219_30.localEulerAngles = var_219_36
			end

			if arg_216_1.time_ >= var_219_31 + var_219_32 and arg_216_1.time_ < var_219_31 + var_219_32 + arg_219_0 then
				var_219_30.localPosition = Vector3.New(0, 100, 0)

				local var_219_37 = manager.ui.mainCamera.transform.position - var_219_30.position

				var_219_30.forward = Vector3.New(var_219_37.x, var_219_37.y, var_219_37.z)

				local var_219_38 = var_219_30.localEulerAngles

				var_219_38.z = 0
				var_219_38.x = 0
				var_219_30.localEulerAngles = var_219_38
			end

			local var_219_39 = arg_216_1.actors_["10050ui_story"]
			local var_219_40 = 0

			if var_219_40 < arg_216_1.time_ and arg_216_1.time_ <= var_219_40 + arg_219_0 and not isNil(var_219_39) and arg_216_1.var_.characterEffect10050ui_story == nil then
				arg_216_1.var_.characterEffect10050ui_story = var_219_39:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_219_41 = 0.200000002980232

			if var_219_40 <= arg_216_1.time_ and arg_216_1.time_ < var_219_40 + var_219_41 and not isNil(var_219_39) then
				local var_219_42 = (arg_216_1.time_ - var_219_40) / var_219_41

				if arg_216_1.var_.characterEffect10050ui_story and not isNil(var_219_39) then
					local var_219_43 = Mathf.Lerp(0, 0.5, var_219_42)

					arg_216_1.var_.characterEffect10050ui_story.fillFlat = true
					arg_216_1.var_.characterEffect10050ui_story.fillRatio = var_219_43
				end
			end

			if arg_216_1.time_ >= var_219_40 + var_219_41 and arg_216_1.time_ < var_219_40 + var_219_41 + arg_219_0 and not isNil(var_219_39) and arg_216_1.var_.characterEffect10050ui_story then
				local var_219_44 = 0.5

				arg_216_1.var_.characterEffect10050ui_story.fillFlat = true
				arg_216_1.var_.characterEffect10050ui_story.fillRatio = var_219_44
			end

			if arg_216_1.frameCnt_ <= 1 then
				arg_216_1.dialog_:SetActive(false)
			end

			local var_219_45 = 0.312546397326514
			local var_219_46 = 0.5

			if var_219_45 < arg_216_1.time_ and arg_216_1.time_ <= var_219_45 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0

				arg_216_1.dialog_:SetActive(true)

				arg_216_1.dialogCg_.alpha = 0

				local var_219_47 = LeanTween.value(arg_216_1.dialog_, 0, 1, 0.3)

				var_219_47:setOnUpdate(LuaHelper.FloatAction(function(arg_220_0)
					arg_216_1.dialogCg_.alpha = arg_220_0
				end))
				var_219_47:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_216_1.dialog_)
					var_219_47:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_216_1.duration_ = arg_216_1.duration_ + 0.3

				SetActive(arg_216_1.leftNameGo_, true)

				local var_219_48 = arg_216_1:FormatText(StoryNameCfg[693].name)

				arg_216_1.leftNameTxt_.text = var_219_48

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_216_1.leftNameTxt_.transform)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1.leftNameTxt_.text)
				SetActive(arg_216_1.iconTrs_.gameObject, false)
				arg_216_1.callingController_:SetSelectedState("normal")

				local var_219_49 = arg_216_1:GetWordFromCfg(319841050)
				local var_219_50 = arg_216_1:FormatText(var_219_49.content)

				arg_216_1.text_.text = var_219_50

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_51 = 20
				local var_219_52 = utf8.len(var_219_50)
				local var_219_53 = var_219_51 <= 0 and var_219_46 or var_219_46 * (var_219_52 / var_219_51)

				if var_219_53 > 0 and var_219_46 < var_219_53 then
					arg_216_1.talkMaxDuration = var_219_53
					var_219_45 = var_219_45 + 0.3

					if var_219_53 + var_219_45 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_53 + var_219_45
					end
				end

				arg_216_1.text_.text = var_219_50
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319841", "319841050", "story_v_out_319841.awb") ~= 0 then
					local var_219_54 = manager.audio:GetVoiceLength("story_v_out_319841", "319841050", "story_v_out_319841.awb") / 1000

					if var_219_54 + var_219_45 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_54 + var_219_45
					end

					if var_219_49.prefab_name ~= "" and arg_216_1.actors_[var_219_49.prefab_name] ~= nil then
						local var_219_55 = LuaForUtil.PlayVoiceWithCriLipsync(arg_216_1.actors_[var_219_49.prefab_name].transform, "story_v_out_319841", "319841050", "story_v_out_319841.awb")

						arg_216_1:RecordAudio("319841050", var_219_55)
						arg_216_1:RecordAudio("319841050", var_219_55)
					else
						arg_216_1:AudioAction("play", "voice", "story_v_out_319841", "319841050", "story_v_out_319841.awb")
					end

					arg_216_1:RecordHistoryTalkVoice("story_v_out_319841", "319841050", "story_v_out_319841.awb")
				end

				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_56 = var_219_45 + 0.3
			local var_219_57 = math.max(var_219_46, arg_216_1.talkMaxDuration)

			if var_219_56 <= arg_216_1.time_ and arg_216_1.time_ < var_219_56 + var_219_57 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_56) / var_219_57

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_56 + var_219_57 and arg_216_1.time_ < var_219_56 + var_219_57 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10069ui_story",
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
			},
			{
				assetPath = "",
				actorName = "10050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_216_1:InitPlayNodeList()
	end,
	Play319841051 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 319841051
		arg_222_1.duration_ = 7.87

		local var_222_0 = {
			zh = 4.633,
			ja = 7.866
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
				arg_222_0:Play319841052(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			local var_225_0 = arg_222_1.actors_["10050ui_story"].transform
			local var_225_1 = 0

			if var_225_1 < arg_222_1.time_ and arg_222_1.time_ <= var_225_1 + arg_225_0 then
				arg_222_1.var_.moveOldPos10050ui_story = var_225_0.localPosition
			end

			local var_225_2 = 0.001

			if var_225_1 <= arg_222_1.time_ and arg_222_1.time_ < var_225_1 + var_225_2 then
				local var_225_3 = (arg_222_1.time_ - var_225_1) / var_225_2
				local var_225_4 = Vector3.New(0.7, -0.715, -6.15)

				var_225_0.localPosition = Vector3.Lerp(arg_222_1.var_.moveOldPos10050ui_story, var_225_4, var_225_3)

				local var_225_5 = manager.ui.mainCamera.transform.position - var_225_0.position

				var_225_0.forward = Vector3.New(var_225_5.x, var_225_5.y, var_225_5.z)

				local var_225_6 = var_225_0.localEulerAngles

				var_225_6.z = 0
				var_225_6.x = 0
				var_225_0.localEulerAngles = var_225_6
			end

			if arg_222_1.time_ >= var_225_1 + var_225_2 and arg_222_1.time_ < var_225_1 + var_225_2 + arg_225_0 then
				var_225_0.localPosition = Vector3.New(0.7, -0.715, -6.15)

				local var_225_7 = manager.ui.mainCamera.transform.position - var_225_0.position

				var_225_0.forward = Vector3.New(var_225_7.x, var_225_7.y, var_225_7.z)

				local var_225_8 = var_225_0.localEulerAngles

				var_225_8.z = 0
				var_225_8.x = 0
				var_225_0.localEulerAngles = var_225_8
			end

			local var_225_9 = arg_222_1.actors_["10050ui_story"]
			local var_225_10 = 0

			if var_225_10 < arg_222_1.time_ and arg_222_1.time_ <= var_225_10 + arg_225_0 and not isNil(var_225_9) and arg_222_1.var_.characterEffect10050ui_story == nil then
				arg_222_1.var_.characterEffect10050ui_story = var_225_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_225_11 = 0.200000002980232

			if var_225_10 <= arg_222_1.time_ and arg_222_1.time_ < var_225_10 + var_225_11 and not isNil(var_225_9) then
				local var_225_12 = (arg_222_1.time_ - var_225_10) / var_225_11

				if arg_222_1.var_.characterEffect10050ui_story and not isNil(var_225_9) then
					arg_222_1.var_.characterEffect10050ui_story.fillFlat = false
				end
			end

			if arg_222_1.time_ >= var_225_10 + var_225_11 and arg_222_1.time_ < var_225_10 + var_225_11 + arg_225_0 and not isNil(var_225_9) and arg_222_1.var_.characterEffect10050ui_story then
				arg_222_1.var_.characterEffect10050ui_story.fillFlat = false
			end

			local var_225_13 = 0

			if var_225_13 < arg_222_1.time_ and arg_222_1.time_ <= var_225_13 + arg_225_0 then
				arg_222_1:PlayTimeline("10050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_225_14 = arg_222_1.actors_["10069ui_story"].transform
			local var_225_15 = 0

			if var_225_15 < arg_222_1.time_ and arg_222_1.time_ <= var_225_15 + arg_225_0 then
				arg_222_1.var_.moveOldPos10069ui_story = var_225_14.localPosition
			end

			local var_225_16 = 0.001

			if var_225_15 <= arg_222_1.time_ and arg_222_1.time_ < var_225_15 + var_225_16 then
				local var_225_17 = (arg_222_1.time_ - var_225_15) / var_225_16
				local var_225_18 = Vector3.New(-0.7, -1.08, -6.33)

				var_225_14.localPosition = Vector3.Lerp(arg_222_1.var_.moveOldPos10069ui_story, var_225_18, var_225_17)

				local var_225_19 = manager.ui.mainCamera.transform.position - var_225_14.position

				var_225_14.forward = Vector3.New(var_225_19.x, var_225_19.y, var_225_19.z)

				local var_225_20 = var_225_14.localEulerAngles

				var_225_20.z = 0
				var_225_20.x = 0
				var_225_14.localEulerAngles = var_225_20
			end

			if arg_222_1.time_ >= var_225_15 + var_225_16 and arg_222_1.time_ < var_225_15 + var_225_16 + arg_225_0 then
				var_225_14.localPosition = Vector3.New(-0.7, -1.08, -6.33)

				local var_225_21 = manager.ui.mainCamera.transform.position - var_225_14.position

				var_225_14.forward = Vector3.New(var_225_21.x, var_225_21.y, var_225_21.z)

				local var_225_22 = var_225_14.localEulerAngles

				var_225_22.z = 0
				var_225_22.x = 0
				var_225_14.localEulerAngles = var_225_22
			end

			local var_225_23 = arg_222_1.actors_["10069ui_story"]
			local var_225_24 = 0

			if var_225_24 < arg_222_1.time_ and arg_222_1.time_ <= var_225_24 + arg_225_0 and not isNil(var_225_23) and arg_222_1.var_.characterEffect10069ui_story == nil then
				arg_222_1.var_.characterEffect10069ui_story = var_225_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_225_25 = 0.200000002980232

			if var_225_24 <= arg_222_1.time_ and arg_222_1.time_ < var_225_24 + var_225_25 and not isNil(var_225_23) then
				local var_225_26 = (arg_222_1.time_ - var_225_24) / var_225_25

				if arg_222_1.var_.characterEffect10069ui_story and not isNil(var_225_23) then
					local var_225_27 = Mathf.Lerp(0, 0.5, var_225_26)

					arg_222_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_222_1.var_.characterEffect10069ui_story.fillRatio = var_225_27
				end
			end

			if arg_222_1.time_ >= var_225_24 + var_225_25 and arg_222_1.time_ < var_225_24 + var_225_25 + arg_225_0 and not isNil(var_225_23) and arg_222_1.var_.characterEffect10069ui_story then
				local var_225_28 = 0.5

				arg_222_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_222_1.var_.characterEffect10069ui_story.fillRatio = var_225_28
			end

			local var_225_29 = 0
			local var_225_30 = 0.575

			if var_225_29 < arg_222_1.time_ and arg_222_1.time_ <= var_225_29 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				local var_225_31 = arg_222_1:FormatText(StoryNameCfg[692].name)

				arg_222_1.leftNameTxt_.text = var_225_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_32 = arg_222_1:GetWordFromCfg(319841051)
				local var_225_33 = arg_222_1:FormatText(var_225_32.content)

				arg_222_1.text_.text = var_225_33

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_34 = 23
				local var_225_35 = utf8.len(var_225_33)
				local var_225_36 = var_225_34 <= 0 and var_225_30 or var_225_30 * (var_225_35 / var_225_34)

				if var_225_36 > 0 and var_225_30 < var_225_36 then
					arg_222_1.talkMaxDuration = var_225_36

					if var_225_36 + var_225_29 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_36 + var_225_29
					end
				end

				arg_222_1.text_.text = var_225_33
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319841", "319841051", "story_v_out_319841.awb") ~= 0 then
					local var_225_37 = manager.audio:GetVoiceLength("story_v_out_319841", "319841051", "story_v_out_319841.awb") / 1000

					if var_225_37 + var_225_29 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_37 + var_225_29
					end

					if var_225_32.prefab_name ~= "" and arg_222_1.actors_[var_225_32.prefab_name] ~= nil then
						local var_225_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_222_1.actors_[var_225_32.prefab_name].transform, "story_v_out_319841", "319841051", "story_v_out_319841.awb")

						arg_222_1:RecordAudio("319841051", var_225_38)
						arg_222_1:RecordAudio("319841051", var_225_38)
					else
						arg_222_1:AudioAction("play", "voice", "story_v_out_319841", "319841051", "story_v_out_319841.awb")
					end

					arg_222_1:RecordHistoryTalkVoice("story_v_out_319841", "319841051", "story_v_out_319841.awb")
				end

				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_39 = math.max(var_225_30, arg_222_1.talkMaxDuration)

			if var_225_29 <= arg_222_1.time_ and arg_222_1.time_ < var_225_29 + var_225_39 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_29) / var_225_39

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_29 + var_225_39 and arg_222_1.time_ < var_225_29 + var_225_39 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10069ui_story",
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
	Play319841052 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 319841052
		arg_226_1.duration_ = 8.53

		local var_226_0 = {
			zh = 6.5,
			ja = 8.533
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
				arg_226_0:Play319841053(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			local var_229_0 = 0

			if var_229_0 < arg_226_1.time_ and arg_226_1.time_ <= var_229_0 + arg_229_0 then
				arg_226_1:PlayTimeline("10050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_229_1 = 0
			local var_229_2 = 0.8

			if var_229_1 < arg_226_1.time_ and arg_226_1.time_ <= var_229_1 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				local var_229_3 = arg_226_1:FormatText(StoryNameCfg[692].name)

				arg_226_1.leftNameTxt_.text = var_229_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, false)
				arg_226_1.callingController_:SetSelectedState("normal")

				local var_229_4 = arg_226_1:GetWordFromCfg(319841052)
				local var_229_5 = arg_226_1:FormatText(var_229_4.content)

				arg_226_1.text_.text = var_229_5

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_6 = 32
				local var_229_7 = utf8.len(var_229_5)
				local var_229_8 = var_229_6 <= 0 and var_229_2 or var_229_2 * (var_229_7 / var_229_6)

				if var_229_8 > 0 and var_229_2 < var_229_8 then
					arg_226_1.talkMaxDuration = var_229_8

					if var_229_8 + var_229_1 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_8 + var_229_1
					end
				end

				arg_226_1.text_.text = var_229_5
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319841", "319841052", "story_v_out_319841.awb") ~= 0 then
					local var_229_9 = manager.audio:GetVoiceLength("story_v_out_319841", "319841052", "story_v_out_319841.awb") / 1000

					if var_229_9 + var_229_1 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_9 + var_229_1
					end

					if var_229_4.prefab_name ~= "" and arg_226_1.actors_[var_229_4.prefab_name] ~= nil then
						local var_229_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_226_1.actors_[var_229_4.prefab_name].transform, "story_v_out_319841", "319841052", "story_v_out_319841.awb")

						arg_226_1:RecordAudio("319841052", var_229_10)
						arg_226_1:RecordAudio("319841052", var_229_10)
					else
						arg_226_1:AudioAction("play", "voice", "story_v_out_319841", "319841052", "story_v_out_319841.awb")
					end

					arg_226_1:RecordHistoryTalkVoice("story_v_out_319841", "319841052", "story_v_out_319841.awb")
				end

				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_11 = math.max(var_229_2, arg_226_1.talkMaxDuration)

			if var_229_1 <= arg_226_1.time_ and arg_226_1.time_ < var_229_1 + var_229_11 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_1) / var_229_11

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_1 + var_229_11 and arg_226_1.time_ < var_229_1 + var_229_11 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {}

		arg_226_1:InitPlayNodeList()
	end,
	Play319841053 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 319841053
		arg_230_1.duration_ = 14.1

		local var_230_0 = {
			zh = 7.5,
			ja = 14.1
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
				arg_230_0:Play319841054(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			local var_233_0 = arg_230_1.actors_["10069ui_story"].transform
			local var_233_1 = 0

			if var_233_1 < arg_230_1.time_ and arg_230_1.time_ <= var_233_1 + arg_233_0 then
				arg_230_1.var_.moveOldPos10069ui_story = var_233_0.localPosition
			end

			local var_233_2 = 0.001

			if var_233_1 <= arg_230_1.time_ and arg_230_1.time_ < var_233_1 + var_233_2 then
				local var_233_3 = (arg_230_1.time_ - var_233_1) / var_233_2
				local var_233_4 = Vector3.New(-0.7, -1.08, -6.33)

				var_233_0.localPosition = Vector3.Lerp(arg_230_1.var_.moveOldPos10069ui_story, var_233_4, var_233_3)

				local var_233_5 = manager.ui.mainCamera.transform.position - var_233_0.position

				var_233_0.forward = Vector3.New(var_233_5.x, var_233_5.y, var_233_5.z)

				local var_233_6 = var_233_0.localEulerAngles

				var_233_6.z = 0
				var_233_6.x = 0
				var_233_0.localEulerAngles = var_233_6
			end

			if arg_230_1.time_ >= var_233_1 + var_233_2 and arg_230_1.time_ < var_233_1 + var_233_2 + arg_233_0 then
				var_233_0.localPosition = Vector3.New(-0.7, -1.08, -6.33)

				local var_233_7 = manager.ui.mainCamera.transform.position - var_233_0.position

				var_233_0.forward = Vector3.New(var_233_7.x, var_233_7.y, var_233_7.z)

				local var_233_8 = var_233_0.localEulerAngles

				var_233_8.z = 0
				var_233_8.x = 0
				var_233_0.localEulerAngles = var_233_8
			end

			local var_233_9 = arg_230_1.actors_["10069ui_story"]
			local var_233_10 = 0

			if var_233_10 < arg_230_1.time_ and arg_230_1.time_ <= var_233_10 + arg_233_0 and not isNil(var_233_9) and arg_230_1.var_.characterEffect10069ui_story == nil then
				arg_230_1.var_.characterEffect10069ui_story = var_233_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_233_11 = 0.200000002980232

			if var_233_10 <= arg_230_1.time_ and arg_230_1.time_ < var_233_10 + var_233_11 and not isNil(var_233_9) then
				local var_233_12 = (arg_230_1.time_ - var_233_10) / var_233_11

				if arg_230_1.var_.characterEffect10069ui_story and not isNil(var_233_9) then
					arg_230_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_230_1.time_ >= var_233_10 + var_233_11 and arg_230_1.time_ < var_233_10 + var_233_11 + arg_233_0 and not isNil(var_233_9) and arg_230_1.var_.characterEffect10069ui_story then
				arg_230_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			local var_233_13 = 0

			if var_233_13 < arg_230_1.time_ and arg_230_1.time_ <= var_233_13 + arg_233_0 then
				arg_230_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/story10056/story10056action/10056action1_1")
			end

			local var_233_14 = 0

			if var_233_14 < arg_230_1.time_ and arg_230_1.time_ <= var_233_14 + arg_233_0 then
				arg_230_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2201cva")
			end

			local var_233_15 = arg_230_1.actors_["10050ui_story"]
			local var_233_16 = 0

			if var_233_16 < arg_230_1.time_ and arg_230_1.time_ <= var_233_16 + arg_233_0 and not isNil(var_233_15) and arg_230_1.var_.characterEffect10050ui_story == nil then
				arg_230_1.var_.characterEffect10050ui_story = var_233_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_233_17 = 0.2

			if var_233_16 <= arg_230_1.time_ and arg_230_1.time_ < var_233_16 + var_233_17 and not isNil(var_233_15) then
				local var_233_18 = (arg_230_1.time_ - var_233_16) / var_233_17

				if arg_230_1.var_.characterEffect10050ui_story and not isNil(var_233_15) then
					local var_233_19 = Mathf.Lerp(0, 0.5, var_233_18)

					arg_230_1.var_.characterEffect10050ui_story.fillFlat = true
					arg_230_1.var_.characterEffect10050ui_story.fillRatio = var_233_19
				end
			end

			if arg_230_1.time_ >= var_233_16 + var_233_17 and arg_230_1.time_ < var_233_16 + var_233_17 + arg_233_0 and not isNil(var_233_15) and arg_230_1.var_.characterEffect10050ui_story then
				local var_233_20 = 0.5

				arg_230_1.var_.characterEffect10050ui_story.fillFlat = true
				arg_230_1.var_.characterEffect10050ui_story.fillRatio = var_233_20
			end

			local var_233_21 = 0
			local var_233_22 = 0.775

			if var_233_21 < arg_230_1.time_ and arg_230_1.time_ <= var_233_21 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				local var_233_23 = arg_230_1:FormatText(StoryNameCfg[693].name)

				arg_230_1.leftNameTxt_.text = var_233_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_24 = arg_230_1:GetWordFromCfg(319841053)
				local var_233_25 = arg_230_1:FormatText(var_233_24.content)

				arg_230_1.text_.text = var_233_25

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_26 = 31
				local var_233_27 = utf8.len(var_233_25)
				local var_233_28 = var_233_26 <= 0 and var_233_22 or var_233_22 * (var_233_27 / var_233_26)

				if var_233_28 > 0 and var_233_22 < var_233_28 then
					arg_230_1.talkMaxDuration = var_233_28

					if var_233_28 + var_233_21 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_28 + var_233_21
					end
				end

				arg_230_1.text_.text = var_233_25
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319841", "319841053", "story_v_out_319841.awb") ~= 0 then
					local var_233_29 = manager.audio:GetVoiceLength("story_v_out_319841", "319841053", "story_v_out_319841.awb") / 1000

					if var_233_29 + var_233_21 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_29 + var_233_21
					end

					if var_233_24.prefab_name ~= "" and arg_230_1.actors_[var_233_24.prefab_name] ~= nil then
						local var_233_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_230_1.actors_[var_233_24.prefab_name].transform, "story_v_out_319841", "319841053", "story_v_out_319841.awb")

						arg_230_1:RecordAudio("319841053", var_233_30)
						arg_230_1:RecordAudio("319841053", var_233_30)
					else
						arg_230_1:AudioAction("play", "voice", "story_v_out_319841", "319841053", "story_v_out_319841.awb")
					end

					arg_230_1:RecordHistoryTalkVoice("story_v_out_319841", "319841053", "story_v_out_319841.awb")
				end

				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_31 = math.max(var_233_22, arg_230_1.talkMaxDuration)

			if var_233_21 <= arg_230_1.time_ and arg_230_1.time_ < var_233_21 + var_233_31 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_21) / var_233_31

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_21 + var_233_31 and arg_230_1.time_ < var_233_21 + var_233_31 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_230_1:InitPlayNodeList()
	end,
	Play319841054 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 319841054
		arg_234_1.duration_ = 5

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play319841055(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			local var_237_0 = arg_234_1.actors_["10050ui_story"].transform
			local var_237_1 = 0

			if var_237_1 < arg_234_1.time_ and arg_234_1.time_ <= var_237_1 + arg_237_0 then
				arg_234_1.var_.moveOldPos10050ui_story = var_237_0.localPosition
			end

			local var_237_2 = 0.001

			if var_237_1 <= arg_234_1.time_ and arg_234_1.time_ < var_237_1 + var_237_2 then
				local var_237_3 = (arg_234_1.time_ - var_237_1) / var_237_2
				local var_237_4 = Vector3.New(0, 100, 0)

				var_237_0.localPosition = Vector3.Lerp(arg_234_1.var_.moveOldPos10050ui_story, var_237_4, var_237_3)

				local var_237_5 = manager.ui.mainCamera.transform.position - var_237_0.position

				var_237_0.forward = Vector3.New(var_237_5.x, var_237_5.y, var_237_5.z)

				local var_237_6 = var_237_0.localEulerAngles

				var_237_6.z = 0
				var_237_6.x = 0
				var_237_0.localEulerAngles = var_237_6
			end

			if arg_234_1.time_ >= var_237_1 + var_237_2 and arg_234_1.time_ < var_237_1 + var_237_2 + arg_237_0 then
				var_237_0.localPosition = Vector3.New(0, 100, 0)

				local var_237_7 = manager.ui.mainCamera.transform.position - var_237_0.position

				var_237_0.forward = Vector3.New(var_237_7.x, var_237_7.y, var_237_7.z)

				local var_237_8 = var_237_0.localEulerAngles

				var_237_8.z = 0
				var_237_8.x = 0
				var_237_0.localEulerAngles = var_237_8
			end

			local var_237_9 = arg_234_1.actors_["10050ui_story"]
			local var_237_10 = 0

			if var_237_10 < arg_234_1.time_ and arg_234_1.time_ <= var_237_10 + arg_237_0 and not isNil(var_237_9) and arg_234_1.var_.characterEffect10050ui_story == nil then
				arg_234_1.var_.characterEffect10050ui_story = var_237_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_237_11 = 0.200000002980232

			if var_237_10 <= arg_234_1.time_ and arg_234_1.time_ < var_237_10 + var_237_11 and not isNil(var_237_9) then
				local var_237_12 = (arg_234_1.time_ - var_237_10) / var_237_11

				if arg_234_1.var_.characterEffect10050ui_story and not isNil(var_237_9) then
					local var_237_13 = Mathf.Lerp(0, 0.5, var_237_12)

					arg_234_1.var_.characterEffect10050ui_story.fillFlat = true
					arg_234_1.var_.characterEffect10050ui_story.fillRatio = var_237_13
				end
			end

			if arg_234_1.time_ >= var_237_10 + var_237_11 and arg_234_1.time_ < var_237_10 + var_237_11 + arg_237_0 and not isNil(var_237_9) and arg_234_1.var_.characterEffect10050ui_story then
				local var_237_14 = 0.5

				arg_234_1.var_.characterEffect10050ui_story.fillFlat = true
				arg_234_1.var_.characterEffect10050ui_story.fillRatio = var_237_14
			end

			local var_237_15 = arg_234_1.actors_["10069ui_story"].transform
			local var_237_16 = 0

			if var_237_16 < arg_234_1.time_ and arg_234_1.time_ <= var_237_16 + arg_237_0 then
				arg_234_1.var_.moveOldPos10069ui_story = var_237_15.localPosition
			end

			local var_237_17 = 0.001

			if var_237_16 <= arg_234_1.time_ and arg_234_1.time_ < var_237_16 + var_237_17 then
				local var_237_18 = (arg_234_1.time_ - var_237_16) / var_237_17
				local var_237_19 = Vector3.New(0, 100, 0)

				var_237_15.localPosition = Vector3.Lerp(arg_234_1.var_.moveOldPos10069ui_story, var_237_19, var_237_18)

				local var_237_20 = manager.ui.mainCamera.transform.position - var_237_15.position

				var_237_15.forward = Vector3.New(var_237_20.x, var_237_20.y, var_237_20.z)

				local var_237_21 = var_237_15.localEulerAngles

				var_237_21.z = 0
				var_237_21.x = 0
				var_237_15.localEulerAngles = var_237_21
			end

			if arg_234_1.time_ >= var_237_16 + var_237_17 and arg_234_1.time_ < var_237_16 + var_237_17 + arg_237_0 then
				var_237_15.localPosition = Vector3.New(0, 100, 0)

				local var_237_22 = manager.ui.mainCamera.transform.position - var_237_15.position

				var_237_15.forward = Vector3.New(var_237_22.x, var_237_22.y, var_237_22.z)

				local var_237_23 = var_237_15.localEulerAngles

				var_237_23.z = 0
				var_237_23.x = 0
				var_237_15.localEulerAngles = var_237_23
			end

			local var_237_24 = arg_234_1.actors_["10069ui_story"]
			local var_237_25 = 0

			if var_237_25 < arg_234_1.time_ and arg_234_1.time_ <= var_237_25 + arg_237_0 and not isNil(var_237_24) and arg_234_1.var_.characterEffect10069ui_story == nil then
				arg_234_1.var_.characterEffect10069ui_story = var_237_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_237_26 = 0.200000002980232

			if var_237_25 <= arg_234_1.time_ and arg_234_1.time_ < var_237_25 + var_237_26 and not isNil(var_237_24) then
				local var_237_27 = (arg_234_1.time_ - var_237_25) / var_237_26

				if arg_234_1.var_.characterEffect10069ui_story and not isNil(var_237_24) then
					local var_237_28 = Mathf.Lerp(0, 0.5, var_237_27)

					arg_234_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_234_1.var_.characterEffect10069ui_story.fillRatio = var_237_28
				end
			end

			if arg_234_1.time_ >= var_237_25 + var_237_26 and arg_234_1.time_ < var_237_25 + var_237_26 + arg_237_0 and not isNil(var_237_24) and arg_234_1.var_.characterEffect10069ui_story then
				local var_237_29 = 0.5

				arg_234_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_234_1.var_.characterEffect10069ui_story.fillRatio = var_237_29
			end

			local var_237_30 = 0
			local var_237_31 = 1.075

			if var_237_30 < arg_234_1.time_ and arg_234_1.time_ <= var_237_30 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, false)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_32 = arg_234_1:GetWordFromCfg(319841054)
				local var_237_33 = arg_234_1:FormatText(var_237_32.content)

				arg_234_1.text_.text = var_237_33

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_34 = 43
				local var_237_35 = utf8.len(var_237_33)
				local var_237_36 = var_237_34 <= 0 and var_237_31 or var_237_31 * (var_237_35 / var_237_34)

				if var_237_36 > 0 and var_237_31 < var_237_36 then
					arg_234_1.talkMaxDuration = var_237_36

					if var_237_36 + var_237_30 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_36 + var_237_30
					end
				end

				arg_234_1.text_.text = var_237_33
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)
				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_37 = math.max(var_237_31, arg_234_1.talkMaxDuration)

			if var_237_30 <= arg_234_1.time_ and arg_234_1.time_ < var_237_30 + var_237_37 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_30) / var_237_37

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_30 + var_237_37 and arg_234_1.time_ < var_237_30 + var_237_37 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_234_1:InitPlayNodeList()
	end,
	Play319841055 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 319841055
		arg_238_1.duration_ = 5.77

		local var_238_0 = {
			zh = 5.766,
			ja = 4
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
				arg_238_0:Play319841056(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			local var_241_0 = arg_238_1.actors_["1084ui_story"].transform
			local var_241_1 = 0

			if var_241_1 < arg_238_1.time_ and arg_238_1.time_ <= var_241_1 + arg_241_0 then
				arg_238_1.var_.moveOldPos1084ui_story = var_241_0.localPosition
			end

			local var_241_2 = 0.001

			if var_241_1 <= arg_238_1.time_ and arg_238_1.time_ < var_241_1 + var_241_2 then
				local var_241_3 = (arg_238_1.time_ - var_241_1) / var_241_2
				local var_241_4 = Vector3.New(0, -0.97, -6)

				var_241_0.localPosition = Vector3.Lerp(arg_238_1.var_.moveOldPos1084ui_story, var_241_4, var_241_3)

				local var_241_5 = manager.ui.mainCamera.transform.position - var_241_0.position

				var_241_0.forward = Vector3.New(var_241_5.x, var_241_5.y, var_241_5.z)

				local var_241_6 = var_241_0.localEulerAngles

				var_241_6.z = 0
				var_241_6.x = 0
				var_241_0.localEulerAngles = var_241_6
			end

			if arg_238_1.time_ >= var_241_1 + var_241_2 and arg_238_1.time_ < var_241_1 + var_241_2 + arg_241_0 then
				var_241_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_241_7 = manager.ui.mainCamera.transform.position - var_241_0.position

				var_241_0.forward = Vector3.New(var_241_7.x, var_241_7.y, var_241_7.z)

				local var_241_8 = var_241_0.localEulerAngles

				var_241_8.z = 0
				var_241_8.x = 0
				var_241_0.localEulerAngles = var_241_8
			end

			local var_241_9 = arg_238_1.actors_["1084ui_story"]
			local var_241_10 = 0

			if var_241_10 < arg_238_1.time_ and arg_238_1.time_ <= var_241_10 + arg_241_0 and not isNil(var_241_9) and arg_238_1.var_.characterEffect1084ui_story == nil then
				arg_238_1.var_.characterEffect1084ui_story = var_241_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_241_11 = 0.200000002980232

			if var_241_10 <= arg_238_1.time_ and arg_238_1.time_ < var_241_10 + var_241_11 and not isNil(var_241_9) then
				local var_241_12 = (arg_238_1.time_ - var_241_10) / var_241_11

				if arg_238_1.var_.characterEffect1084ui_story and not isNil(var_241_9) then
					arg_238_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_238_1.time_ >= var_241_10 + var_241_11 and arg_238_1.time_ < var_241_10 + var_241_11 + arg_241_0 and not isNil(var_241_9) and arg_238_1.var_.characterEffect1084ui_story then
				arg_238_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_241_13 = 0

			if var_241_13 < arg_238_1.time_ and arg_238_1.time_ <= var_241_13 + arg_241_0 then
				arg_238_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			local var_241_14 = 0

			if var_241_14 < arg_238_1.time_ and arg_238_1.time_ <= var_241_14 + arg_241_0 then
				arg_238_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2202cva")
			end

			local var_241_15 = 0
			local var_241_16 = 0.725

			if var_241_15 < arg_238_1.time_ and arg_238_1.time_ <= var_241_15 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, true)

				local var_241_17 = arg_238_1:FormatText(StoryNameCfg[6].name)

				arg_238_1.leftNameTxt_.text = var_241_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_238_1.leftNameTxt_.transform)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1.leftNameTxt_.text)
				SetActive(arg_238_1.iconTrs_.gameObject, false)
				arg_238_1.callingController_:SetSelectedState("normal")

				local var_241_18 = arg_238_1:GetWordFromCfg(319841055)
				local var_241_19 = arg_238_1:FormatText(var_241_18.content)

				arg_238_1.text_.text = var_241_19

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_20 = 29
				local var_241_21 = utf8.len(var_241_19)
				local var_241_22 = var_241_20 <= 0 and var_241_16 or var_241_16 * (var_241_21 / var_241_20)

				if var_241_22 > 0 and var_241_16 < var_241_22 then
					arg_238_1.talkMaxDuration = var_241_22

					if var_241_22 + var_241_15 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_22 + var_241_15
					end
				end

				arg_238_1.text_.text = var_241_19
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319841", "319841055", "story_v_out_319841.awb") ~= 0 then
					local var_241_23 = manager.audio:GetVoiceLength("story_v_out_319841", "319841055", "story_v_out_319841.awb") / 1000

					if var_241_23 + var_241_15 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_23 + var_241_15
					end

					if var_241_18.prefab_name ~= "" and arg_238_1.actors_[var_241_18.prefab_name] ~= nil then
						local var_241_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_238_1.actors_[var_241_18.prefab_name].transform, "story_v_out_319841", "319841055", "story_v_out_319841.awb")

						arg_238_1:RecordAudio("319841055", var_241_24)
						arg_238_1:RecordAudio("319841055", var_241_24)
					else
						arg_238_1:AudioAction("play", "voice", "story_v_out_319841", "319841055", "story_v_out_319841.awb")
					end

					arg_238_1:RecordHistoryTalkVoice("story_v_out_319841", "319841055", "story_v_out_319841.awb")
				end

				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_25 = math.max(var_241_16, arg_238_1.talkMaxDuration)

			if var_241_15 <= arg_238_1.time_ and arg_238_1.time_ < var_241_15 + var_241_25 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_15) / var_241_25

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_15 + var_241_25 and arg_238_1.time_ < var_241_15 + var_241_25 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {
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

		arg_238_1:InitPlayNodeList()
	end,
	Play319841056 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 319841056
		arg_242_1.duration_ = 4.77

		local var_242_0 = {
			zh = 4.766,
			ja = 2.866
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
				arg_242_0:Play319841057(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			local var_245_0 = arg_242_1.actors_["10069ui_story"].transform
			local var_245_1 = 0

			if var_245_1 < arg_242_1.time_ and arg_242_1.time_ <= var_245_1 + arg_245_0 then
				arg_242_1.var_.moveOldPos10069ui_story = var_245_0.localPosition
			end

			local var_245_2 = 0.001

			if var_245_1 <= arg_242_1.time_ and arg_242_1.time_ < var_245_1 + var_245_2 then
				local var_245_3 = (arg_242_1.time_ - var_245_1) / var_245_2
				local var_245_4 = Vector3.New(-0.7, -1.08, -6.33)

				var_245_0.localPosition = Vector3.Lerp(arg_242_1.var_.moveOldPos10069ui_story, var_245_4, var_245_3)

				local var_245_5 = manager.ui.mainCamera.transform.position - var_245_0.position

				var_245_0.forward = Vector3.New(var_245_5.x, var_245_5.y, var_245_5.z)

				local var_245_6 = var_245_0.localEulerAngles

				var_245_6.z = 0
				var_245_6.x = 0
				var_245_0.localEulerAngles = var_245_6
			end

			if arg_242_1.time_ >= var_245_1 + var_245_2 and arg_242_1.time_ < var_245_1 + var_245_2 + arg_245_0 then
				var_245_0.localPosition = Vector3.New(-0.7, -1.08, -6.33)

				local var_245_7 = manager.ui.mainCamera.transform.position - var_245_0.position

				var_245_0.forward = Vector3.New(var_245_7.x, var_245_7.y, var_245_7.z)

				local var_245_8 = var_245_0.localEulerAngles

				var_245_8.z = 0
				var_245_8.x = 0
				var_245_0.localEulerAngles = var_245_8
			end

			local var_245_9 = arg_242_1.actors_["10069ui_story"]
			local var_245_10 = 0

			if var_245_10 < arg_242_1.time_ and arg_242_1.time_ <= var_245_10 + arg_245_0 and not isNil(var_245_9) and arg_242_1.var_.characterEffect10069ui_story == nil then
				arg_242_1.var_.characterEffect10069ui_story = var_245_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_245_11 = 0.200000002980232

			if var_245_10 <= arg_242_1.time_ and arg_242_1.time_ < var_245_10 + var_245_11 and not isNil(var_245_9) then
				local var_245_12 = (arg_242_1.time_ - var_245_10) / var_245_11

				if arg_242_1.var_.characterEffect10069ui_story and not isNil(var_245_9) then
					arg_242_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_242_1.time_ >= var_245_10 + var_245_11 and arg_242_1.time_ < var_245_10 + var_245_11 + arg_245_0 and not isNil(var_245_9) and arg_242_1.var_.characterEffect10069ui_story then
				arg_242_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			local var_245_13 = arg_242_1.actors_["1084ui_story"].transform
			local var_245_14 = 0

			if var_245_14 < arg_242_1.time_ and arg_242_1.time_ <= var_245_14 + arg_245_0 then
				arg_242_1.var_.moveOldPos1084ui_story = var_245_13.localPosition
			end

			local var_245_15 = 0.001

			if var_245_14 <= arg_242_1.time_ and arg_242_1.time_ < var_245_14 + var_245_15 then
				local var_245_16 = (arg_242_1.time_ - var_245_14) / var_245_15
				local var_245_17 = Vector3.New(0.7, -0.97, -6)

				var_245_13.localPosition = Vector3.Lerp(arg_242_1.var_.moveOldPos1084ui_story, var_245_17, var_245_16)

				local var_245_18 = manager.ui.mainCamera.transform.position - var_245_13.position

				var_245_13.forward = Vector3.New(var_245_18.x, var_245_18.y, var_245_18.z)

				local var_245_19 = var_245_13.localEulerAngles

				var_245_19.z = 0
				var_245_19.x = 0
				var_245_13.localEulerAngles = var_245_19
			end

			if arg_242_1.time_ >= var_245_14 + var_245_15 and arg_242_1.time_ < var_245_14 + var_245_15 + arg_245_0 then
				var_245_13.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_245_20 = manager.ui.mainCamera.transform.position - var_245_13.position

				var_245_13.forward = Vector3.New(var_245_20.x, var_245_20.y, var_245_20.z)

				local var_245_21 = var_245_13.localEulerAngles

				var_245_21.z = 0
				var_245_21.x = 0
				var_245_13.localEulerAngles = var_245_21
			end

			local var_245_22 = arg_242_1.actors_["1084ui_story"]
			local var_245_23 = 0

			if var_245_23 < arg_242_1.time_ and arg_242_1.time_ <= var_245_23 + arg_245_0 and not isNil(var_245_22) and arg_242_1.var_.characterEffect1084ui_story == nil then
				arg_242_1.var_.characterEffect1084ui_story = var_245_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_245_24 = 0.200000002980232

			if var_245_23 <= arg_242_1.time_ and arg_242_1.time_ < var_245_23 + var_245_24 and not isNil(var_245_22) then
				local var_245_25 = (arg_242_1.time_ - var_245_23) / var_245_24

				if arg_242_1.var_.characterEffect1084ui_story and not isNil(var_245_22) then
					local var_245_26 = Mathf.Lerp(0, 0.5, var_245_25)

					arg_242_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_242_1.var_.characterEffect1084ui_story.fillRatio = var_245_26
				end
			end

			if arg_242_1.time_ >= var_245_23 + var_245_24 and arg_242_1.time_ < var_245_23 + var_245_24 + arg_245_0 and not isNil(var_245_22) and arg_242_1.var_.characterEffect1084ui_story then
				local var_245_27 = 0.5

				arg_242_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_242_1.var_.characterEffect1084ui_story.fillRatio = var_245_27
			end

			local var_245_28 = 0
			local var_245_29 = 0.675

			if var_245_28 < arg_242_1.time_ and arg_242_1.time_ <= var_245_28 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, true)

				local var_245_30 = arg_242_1:FormatText(StoryNameCfg[693].name)

				arg_242_1.leftNameTxt_.text = var_245_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_242_1.leftNameTxt_.transform)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1.leftNameTxt_.text)
				SetActive(arg_242_1.iconTrs_.gameObject, false)
				arg_242_1.callingController_:SetSelectedState("normal")

				local var_245_31 = arg_242_1:GetWordFromCfg(319841056)
				local var_245_32 = arg_242_1:FormatText(var_245_31.content)

				arg_242_1.text_.text = var_245_32

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_33 = 27
				local var_245_34 = utf8.len(var_245_32)
				local var_245_35 = var_245_33 <= 0 and var_245_29 or var_245_29 * (var_245_34 / var_245_33)

				if var_245_35 > 0 and var_245_29 < var_245_35 then
					arg_242_1.talkMaxDuration = var_245_35

					if var_245_35 + var_245_28 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_35 + var_245_28
					end
				end

				arg_242_1.text_.text = var_245_32
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319841", "319841056", "story_v_out_319841.awb") ~= 0 then
					local var_245_36 = manager.audio:GetVoiceLength("story_v_out_319841", "319841056", "story_v_out_319841.awb") / 1000

					if var_245_36 + var_245_28 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_36 + var_245_28
					end

					if var_245_31.prefab_name ~= "" and arg_242_1.actors_[var_245_31.prefab_name] ~= nil then
						local var_245_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_242_1.actors_[var_245_31.prefab_name].transform, "story_v_out_319841", "319841056", "story_v_out_319841.awb")

						arg_242_1:RecordAudio("319841056", var_245_37)
						arg_242_1:RecordAudio("319841056", var_245_37)
					else
						arg_242_1:AudioAction("play", "voice", "story_v_out_319841", "319841056", "story_v_out_319841.awb")
					end

					arg_242_1:RecordHistoryTalkVoice("story_v_out_319841", "319841056", "story_v_out_319841.awb")
				end

				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_38 = math.max(var_245_29, arg_242_1.talkMaxDuration)

			if var_245_28 <= arg_242_1.time_ and arg_242_1.time_ < var_245_28 + var_245_38 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - var_245_28) / var_245_38

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= var_245_28 + var_245_38 and arg_242_1.time_ < var_245_28 + var_245_38 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10069ui_story",
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

		arg_242_1:InitPlayNodeList()
	end,
	Play319841057 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 319841057
		arg_246_1.duration_ = 5

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play319841058(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			local var_249_0 = arg_246_1.actors_["10069ui_story"]
			local var_249_1 = 0

			if var_249_1 < arg_246_1.time_ and arg_246_1.time_ <= var_249_1 + arg_249_0 and not isNil(var_249_0) and arg_246_1.var_.characterEffect10069ui_story == nil then
				arg_246_1.var_.characterEffect10069ui_story = var_249_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_249_2 = 0.200000002980232

			if var_249_1 <= arg_246_1.time_ and arg_246_1.time_ < var_249_1 + var_249_2 and not isNil(var_249_0) then
				local var_249_3 = (arg_246_1.time_ - var_249_1) / var_249_2

				if arg_246_1.var_.characterEffect10069ui_story and not isNil(var_249_0) then
					local var_249_4 = Mathf.Lerp(0, 0.5, var_249_3)

					arg_246_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_246_1.var_.characterEffect10069ui_story.fillRatio = var_249_4
				end
			end

			if arg_246_1.time_ >= var_249_1 + var_249_2 and arg_246_1.time_ < var_249_1 + var_249_2 + arg_249_0 and not isNil(var_249_0) and arg_246_1.var_.characterEffect10069ui_story then
				local var_249_5 = 0.5

				arg_246_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_246_1.var_.characterEffect10069ui_story.fillRatio = var_249_5
			end

			local var_249_6 = 0
			local var_249_7 = 0.625

			if var_249_6 < arg_246_1.time_ and arg_246_1.time_ <= var_249_6 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, false)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_246_1.iconTrs_.gameObject, false)
				arg_246_1.callingController_:SetSelectedState("normal")

				local var_249_8 = arg_246_1:GetWordFromCfg(319841057)
				local var_249_9 = arg_246_1:FormatText(var_249_8.content)

				arg_246_1.text_.text = var_249_9

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_10 = 25
				local var_249_11 = utf8.len(var_249_9)
				local var_249_12 = var_249_10 <= 0 and var_249_7 or var_249_7 * (var_249_11 / var_249_10)

				if var_249_12 > 0 and var_249_7 < var_249_12 then
					arg_246_1.talkMaxDuration = var_249_12

					if var_249_12 + var_249_6 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_12 + var_249_6
					end
				end

				arg_246_1.text_.text = var_249_9
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)
				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_13 = math.max(var_249_7, arg_246_1.talkMaxDuration)

			if var_249_6 <= arg_246_1.time_ and arg_246_1.time_ < var_249_6 + var_249_13 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - var_249_6) / var_249_13

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= var_249_6 + var_249_13 and arg_246_1.time_ < var_249_6 + var_249_13 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {}

		arg_246_1:InitPlayNodeList()
	end,
	Play319841058 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 319841058
		arg_250_1.duration_ = 5.4

		local var_250_0 = {
			zh = 4.3,
			ja = 5.4
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
				arg_250_0:Play319841059(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			local var_253_0 = arg_250_1.actors_["10069ui_story"]
			local var_253_1 = 0

			if var_253_1 < arg_250_1.time_ and arg_250_1.time_ <= var_253_1 + arg_253_0 and not isNil(var_253_0) and arg_250_1.var_.characterEffect10069ui_story == nil then
				arg_250_1.var_.characterEffect10069ui_story = var_253_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_253_2 = 0.200000002980232

			if var_253_1 <= arg_250_1.time_ and arg_250_1.time_ < var_253_1 + var_253_2 and not isNil(var_253_0) then
				local var_253_3 = (arg_250_1.time_ - var_253_1) / var_253_2

				if arg_250_1.var_.characterEffect10069ui_story and not isNil(var_253_0) then
					arg_250_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_250_1.time_ >= var_253_1 + var_253_2 and arg_250_1.time_ < var_253_1 + var_253_2 + arg_253_0 and not isNil(var_253_0) and arg_250_1.var_.characterEffect10069ui_story then
				arg_250_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			local var_253_4 = 0

			if var_253_4 < arg_250_1.time_ and arg_250_1.time_ <= var_253_4 + arg_253_0 then
				arg_250_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_253_5 = 0
			local var_253_6 = 0.55

			if var_253_5 < arg_250_1.time_ and arg_250_1.time_ <= var_253_5 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, true)

				local var_253_7 = arg_250_1:FormatText(StoryNameCfg[693].name)

				arg_250_1.leftNameTxt_.text = var_253_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_250_1.leftNameTxt_.transform)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1.leftNameTxt_.text)
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_8 = arg_250_1:GetWordFromCfg(319841058)
				local var_253_9 = arg_250_1:FormatText(var_253_8.content)

				arg_250_1.text_.text = var_253_9

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_10 = 22
				local var_253_11 = utf8.len(var_253_9)
				local var_253_12 = var_253_10 <= 0 and var_253_6 or var_253_6 * (var_253_11 / var_253_10)

				if var_253_12 > 0 and var_253_6 < var_253_12 then
					arg_250_1.talkMaxDuration = var_253_12

					if var_253_12 + var_253_5 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_12 + var_253_5
					end
				end

				arg_250_1.text_.text = var_253_9
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319841", "319841058", "story_v_out_319841.awb") ~= 0 then
					local var_253_13 = manager.audio:GetVoiceLength("story_v_out_319841", "319841058", "story_v_out_319841.awb") / 1000

					if var_253_13 + var_253_5 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_13 + var_253_5
					end

					if var_253_8.prefab_name ~= "" and arg_250_1.actors_[var_253_8.prefab_name] ~= nil then
						local var_253_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_250_1.actors_[var_253_8.prefab_name].transform, "story_v_out_319841", "319841058", "story_v_out_319841.awb")

						arg_250_1:RecordAudio("319841058", var_253_14)
						arg_250_1:RecordAudio("319841058", var_253_14)
					else
						arg_250_1:AudioAction("play", "voice", "story_v_out_319841", "319841058", "story_v_out_319841.awb")
					end

					arg_250_1:RecordHistoryTalkVoice("story_v_out_319841", "319841058", "story_v_out_319841.awb")
				end

				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_15 = math.max(var_253_6, arg_250_1.talkMaxDuration)

			if var_253_5 <= arg_250_1.time_ and arg_250_1.time_ < var_253_5 + var_253_15 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_5) / var_253_15

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_5 + var_253_15 and arg_250_1.time_ < var_253_5 + var_253_15 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {}

		arg_250_1:InitPlayNodeList()
	end,
	Play319841059 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 319841059
		arg_254_1.duration_ = 14.7

		local var_254_0 = {
			zh = 12.4,
			ja = 14.7
		}
		local var_254_1 = manager.audio:GetLocalizationFlag()

		if var_254_0[var_254_1] ~= nil then
			arg_254_1.duration_ = var_254_0[var_254_1]
		end

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play319841060(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			local var_257_0 = 0
			local var_257_1 = 1.45

			if var_257_0 < arg_254_1.time_ and arg_254_1.time_ <= var_257_0 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, true)

				local var_257_2 = arg_254_1:FormatText(StoryNameCfg[693].name)

				arg_254_1.leftNameTxt_.text = var_257_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_254_1.leftNameTxt_.transform)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1.leftNameTxt_.text)
				SetActive(arg_254_1.iconTrs_.gameObject, false)
				arg_254_1.callingController_:SetSelectedState("normal")

				local var_257_3 = arg_254_1:GetWordFromCfg(319841059)
				local var_257_4 = arg_254_1:FormatText(var_257_3.content)

				arg_254_1.text_.text = var_257_4

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_5 = 58
				local var_257_6 = utf8.len(var_257_4)
				local var_257_7 = var_257_5 <= 0 and var_257_1 or var_257_1 * (var_257_6 / var_257_5)

				if var_257_7 > 0 and var_257_1 < var_257_7 then
					arg_254_1.talkMaxDuration = var_257_7

					if var_257_7 + var_257_0 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_7 + var_257_0
					end
				end

				arg_254_1.text_.text = var_257_4
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319841", "319841059", "story_v_out_319841.awb") ~= 0 then
					local var_257_8 = manager.audio:GetVoiceLength("story_v_out_319841", "319841059", "story_v_out_319841.awb") / 1000

					if var_257_8 + var_257_0 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_8 + var_257_0
					end

					if var_257_3.prefab_name ~= "" and arg_254_1.actors_[var_257_3.prefab_name] ~= nil then
						local var_257_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_254_1.actors_[var_257_3.prefab_name].transform, "story_v_out_319841", "319841059", "story_v_out_319841.awb")

						arg_254_1:RecordAudio("319841059", var_257_9)
						arg_254_1:RecordAudio("319841059", var_257_9)
					else
						arg_254_1:AudioAction("play", "voice", "story_v_out_319841", "319841059", "story_v_out_319841.awb")
					end

					arg_254_1:RecordHistoryTalkVoice("story_v_out_319841", "319841059", "story_v_out_319841.awb")
				end

				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_10 = math.max(var_257_1, arg_254_1.talkMaxDuration)

			if var_257_0 <= arg_254_1.time_ and arg_254_1.time_ < var_257_0 + var_257_10 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_0) / var_257_10

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_0 + var_257_10 and arg_254_1.time_ < var_257_0 + var_257_10 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {}

		arg_254_1:InitPlayNodeList()
	end,
	Play319841060 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 319841060
		arg_258_1.duration_ = 9.03

		local var_258_0 = {
			zh = 5.833,
			ja = 9.033
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
			arg_258_1.auto_ = false
		end

		function arg_258_1.playNext_(arg_260_0)
			arg_258_1.onStoryFinished_()
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			local var_261_0 = 0
			local var_261_1 = 0.65

			if var_261_0 < arg_258_1.time_ and arg_258_1.time_ <= var_261_0 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				local var_261_2 = arg_258_1:FormatText(StoryNameCfg[693].name)

				arg_258_1.leftNameTxt_.text = var_261_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, false)
				arg_258_1.callingController_:SetSelectedState("normal")

				local var_261_3 = arg_258_1:GetWordFromCfg(319841060)
				local var_261_4 = arg_258_1:FormatText(var_261_3.content)

				arg_258_1.text_.text = var_261_4

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_5 = 26
				local var_261_6 = utf8.len(var_261_4)
				local var_261_7 = var_261_5 <= 0 and var_261_1 or var_261_1 * (var_261_6 / var_261_5)

				if var_261_7 > 0 and var_261_1 < var_261_7 then
					arg_258_1.talkMaxDuration = var_261_7

					if var_261_7 + var_261_0 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_7 + var_261_0
					end
				end

				arg_258_1.text_.text = var_261_4
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319841", "319841060", "story_v_out_319841.awb") ~= 0 then
					local var_261_8 = manager.audio:GetVoiceLength("story_v_out_319841", "319841060", "story_v_out_319841.awb") / 1000

					if var_261_8 + var_261_0 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_8 + var_261_0
					end

					if var_261_3.prefab_name ~= "" and arg_258_1.actors_[var_261_3.prefab_name] ~= nil then
						local var_261_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_258_1.actors_[var_261_3.prefab_name].transform, "story_v_out_319841", "319841060", "story_v_out_319841.awb")

						arg_258_1:RecordAudio("319841060", var_261_9)
						arg_258_1:RecordAudio("319841060", var_261_9)
					else
						arg_258_1:AudioAction("play", "voice", "story_v_out_319841", "319841060", "story_v_out_319841.awb")
					end

					arg_258_1:RecordHistoryTalkVoice("story_v_out_319841", "319841060", "story_v_out_319841.awb")
				end

				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_10 = math.max(var_261_1, arg_258_1.talkMaxDuration)

			if var_261_0 <= arg_258_1.time_ and arg_258_1.time_ < var_261_0 + var_261_10 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_0) / var_261_10

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_0 + var_261_10 and arg_258_1.time_ < var_261_0 + var_261_10 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {}

		arg_258_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/D02a",
		"TextureConfig/Background/ST74",
		"TextureConfig/Background/ST72"
	},
	voices = {
		"story_v_out_319841.awb"
	}
}
