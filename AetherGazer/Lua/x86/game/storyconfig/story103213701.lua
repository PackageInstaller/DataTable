return {
	Play321371001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 321371001
		arg_1_1.duration_ = 4.4

		local var_1_0 = {
			zh = 3.5,
			ja = 4.4
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
				arg_1_0:Play321371002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "L09g"

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
				local var_4_5 = arg_1_1.bgs_.L09g

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
					if iter_4_0 ~= "L09g" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 2

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

			local var_4_30 = 0.4
			local var_4_31 = 1

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				local var_4_32 = "play"
				local var_4_33 = "music"

				arg_1_1:AudioAction(var_4_32, var_4_33, "bgm_activity_4_0_story_quake_unsettled", "bgm_activity_4_0_story_quake_unsettled", "bgm_activity_4_0_story_quake_unsettled.awb")

				local var_4_34 = ""
				local var_4_35 = manager.audio:GetAudioName("bgm_activity_4_0_story_quake_unsettled", "bgm_activity_4_0_story_quake_unsettled")

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

			local var_4_36 = 2
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

				local var_4_39 = arg_1_1:FormatText(StoryNameCfg[1178].name)

				arg_1_1.leftNameTxt_.text = var_4_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10131")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_40 = arg_1_1:GetWordFromCfg(321371001)
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

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371001", "story_v_out_321371.awb") ~= 0 then
					local var_4_45 = manager.audio:GetVoiceLength("story_v_out_321371", "321371001", "story_v_out_321371.awb") / 1000

					if var_4_45 + var_4_36 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_45 + var_4_36
					end

					if var_4_40.prefab_name ~= "" and arg_1_1.actors_[var_4_40.prefab_name] ~= nil then
						local var_4_46 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_40.prefab_name].transform, "story_v_out_321371", "321371001", "story_v_out_321371.awb")

						arg_1_1:RecordAudio("321371001", var_4_46)
						arg_1_1:RecordAudio("321371001", var_4_46)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_321371", "321371001", "story_v_out_321371.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_321371", "321371001", "story_v_out_321371.awb")
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
	Play321371002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 321371002
		arg_9_1.duration_ = 3.97

		local var_9_0 = {
			zh = 3.966,
			ja = 3.1
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
				arg_9_0:Play321371003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 0.425

			if var_12_0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_2 = arg_9_1:FormatText(StoryNameCfg[67].name)

				arg_9_1.leftNameTxt_.text = var_12_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1111")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_3 = arg_9_1:GetWordFromCfg(321371002)
				local var_12_4 = arg_9_1:FormatText(var_12_3.content)

				arg_9_1.text_.text = var_12_4

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_5 = 17
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

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371002", "story_v_out_321371.awb") ~= 0 then
					local var_12_8 = manager.audio:GetVoiceLength("story_v_out_321371", "321371002", "story_v_out_321371.awb") / 1000

					if var_12_8 + var_12_0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_8 + var_12_0
					end

					if var_12_3.prefab_name ~= "" and arg_9_1.actors_[var_12_3.prefab_name] ~= nil then
						local var_12_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_3.prefab_name].transform, "story_v_out_321371", "321371002", "story_v_out_321371.awb")

						arg_9_1:RecordAudio("321371002", var_12_9)
						arg_9_1:RecordAudio("321371002", var_12_9)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_321371", "321371002", "story_v_out_321371.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_321371", "321371002", "story_v_out_321371.awb")
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
	Play321371003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 321371003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play321371004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0
			local var_16_1 = 1.425

			if var_16_0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_2 = arg_13_1:GetWordFromCfg(321371003)
				local var_16_3 = arg_13_1:FormatText(var_16_2.content)

				arg_13_1.text_.text = var_16_3

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 57
				local var_16_5 = utf8.len(var_16_3)
				local var_16_6 = var_16_4 <= 0 and var_16_1 or var_16_1 * (var_16_5 / var_16_4)

				if var_16_6 > 0 and var_16_1 < var_16_6 then
					arg_13_1.talkMaxDuration = var_16_6

					if var_16_6 + var_16_0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_6 + var_16_0
					end
				end

				arg_13_1.text_.text = var_16_3
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_7 = math.max(var_16_1, arg_13_1.talkMaxDuration)

			if var_16_0 <= arg_13_1.time_ and arg_13_1.time_ < var_16_0 + var_16_7 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_0) / var_16_7

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_0 + var_16_7 and arg_13_1.time_ < var_16_0 + var_16_7 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play321371004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 321371004
		arg_17_1.duration_ = 4.3

		local var_17_0 = {
			zh = 3.466,
			ja = 4.3
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
				arg_17_0:Play321371005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = "1111ui_story"

			if arg_17_1.actors_[var_20_0] == nil then
				local var_20_1 = Asset.Load("Char/" .. "1111ui_story")

				if not isNil(var_20_1) then
					local var_20_2 = Object.Instantiate(Asset.Load("Char/" .. "1111ui_story"), arg_17_1.stage_.transform)

					var_20_2.name = var_20_0
					var_20_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_17_1.actors_[var_20_0] = var_20_2

					local var_20_3 = var_20_2:GetComponentInChildren(typeof(CharacterEffect))

					var_20_3.enabled = true

					local var_20_4 = GameObjectTools.GetOrAddComponent(var_20_2, typeof(DynamicBoneHelper))

					if var_20_4 then
						var_20_4:EnableDynamicBone(false)
					end

					arg_17_1:ShowWeapon(var_20_3.transform, false)

					arg_17_1.var_[var_20_0 .. "Animator"] = var_20_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_17_1.var_[var_20_0 .. "Animator"].applyRootMotion = true
					arg_17_1.var_[var_20_0 .. "LipSync"] = var_20_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_20_5 = arg_17_1.actors_["1111ui_story"].transform
			local var_20_6 = 0

			if var_20_6 < arg_17_1.time_ and arg_17_1.time_ <= var_20_6 + arg_20_0 then
				arg_17_1.var_.moveOldPos1111ui_story = var_20_5.localPosition
			end

			local var_20_7 = 0.001

			if var_20_6 <= arg_17_1.time_ and arg_17_1.time_ < var_20_6 + var_20_7 then
				local var_20_8 = (arg_17_1.time_ - var_20_6) / var_20_7
				local var_20_9 = Vector3.New(-0.79, -0.87, -5.7)

				var_20_5.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1111ui_story, var_20_9, var_20_8)

				local var_20_10 = manager.ui.mainCamera.transform.position - var_20_5.position

				var_20_5.forward = Vector3.New(var_20_10.x, var_20_10.y, var_20_10.z)

				local var_20_11 = var_20_5.localEulerAngles

				var_20_11.z = 0
				var_20_11.x = 0
				var_20_5.localEulerAngles = var_20_11
			end

			if arg_17_1.time_ >= var_20_6 + var_20_7 and arg_17_1.time_ < var_20_6 + var_20_7 + arg_20_0 then
				var_20_5.localPosition = Vector3.New(-0.79, -0.87, -5.7)

				local var_20_12 = manager.ui.mainCamera.transform.position - var_20_5.position

				var_20_5.forward = Vector3.New(var_20_12.x, var_20_12.y, var_20_12.z)

				local var_20_13 = var_20_5.localEulerAngles

				var_20_13.z = 0
				var_20_13.x = 0
				var_20_5.localEulerAngles = var_20_13
			end

			local var_20_14 = arg_17_1.actors_["1111ui_story"]
			local var_20_15 = 0

			if var_20_15 < arg_17_1.time_ and arg_17_1.time_ <= var_20_15 + arg_20_0 and not isNil(var_20_14) and arg_17_1.var_.characterEffect1111ui_story == nil then
				arg_17_1.var_.characterEffect1111ui_story = var_20_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_16 = 0.200000002980232

			if var_20_15 <= arg_17_1.time_ and arg_17_1.time_ < var_20_15 + var_20_16 and not isNil(var_20_14) then
				local var_20_17 = (arg_17_1.time_ - var_20_15) / var_20_16

				if arg_17_1.var_.characterEffect1111ui_story and not isNil(var_20_14) then
					arg_17_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= var_20_15 + var_20_16 and arg_17_1.time_ < var_20_15 + var_20_16 + arg_20_0 and not isNil(var_20_14) and arg_17_1.var_.characterEffect1111ui_story then
				arg_17_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_20_18 = 0

			if var_20_18 < arg_17_1.time_ and arg_17_1.time_ <= var_20_18 + arg_20_0 then
				arg_17_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action4_1")
			end

			local var_20_19 = 0

			if var_20_19 < arg_17_1.time_ and arg_17_1.time_ <= var_20_19 + arg_20_0 then
				arg_17_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_20_20 = 0
			local var_20_21 = 0.3

			if var_20_20 < arg_17_1.time_ and arg_17_1.time_ <= var_20_20 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_22 = arg_17_1:FormatText(StoryNameCfg[67].name)

				arg_17_1.leftNameTxt_.text = var_20_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_23 = arg_17_1:GetWordFromCfg(321371004)
				local var_20_24 = arg_17_1:FormatText(var_20_23.content)

				arg_17_1.text_.text = var_20_24

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_25 = 12
				local var_20_26 = utf8.len(var_20_24)
				local var_20_27 = var_20_25 <= 0 and var_20_21 or var_20_21 * (var_20_26 / var_20_25)

				if var_20_27 > 0 and var_20_21 < var_20_27 then
					arg_17_1.talkMaxDuration = var_20_27

					if var_20_27 + var_20_20 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_27 + var_20_20
					end
				end

				arg_17_1.text_.text = var_20_24
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371004", "story_v_out_321371.awb") ~= 0 then
					local var_20_28 = manager.audio:GetVoiceLength("story_v_out_321371", "321371004", "story_v_out_321371.awb") / 1000

					if var_20_28 + var_20_20 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_28 + var_20_20
					end

					if var_20_23.prefab_name ~= "" and arg_17_1.actors_[var_20_23.prefab_name] ~= nil then
						local var_20_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_23.prefab_name].transform, "story_v_out_321371", "321371004", "story_v_out_321371.awb")

						arg_17_1:RecordAudio("321371004", var_20_29)
						arg_17_1:RecordAudio("321371004", var_20_29)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_321371", "321371004", "story_v_out_321371.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_321371", "321371004", "story_v_out_321371.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_30 = math.max(var_20_21, arg_17_1.talkMaxDuration)

			if var_20_20 <= arg_17_1.time_ and arg_17_1.time_ < var_20_20 + var_20_30 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_20) / var_20_30

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_20 + var_20_30 and arg_17_1.time_ < var_20_20 + var_20_30 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_17_1:InitPlayNodeList()
	end,
	Play321371005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 321371005
		arg_21_1.duration_ = 2

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play321371006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = "10131ui_story"

			if arg_21_1.actors_[var_24_0] == nil then
				local var_24_1 = Asset.Load("Char/" .. "10131ui_story")

				if not isNil(var_24_1) then
					local var_24_2 = Object.Instantiate(Asset.Load("Char/" .. "10131ui_story"), arg_21_1.stage_.transform)

					var_24_2.name = var_24_0
					var_24_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_21_1.actors_[var_24_0] = var_24_2

					local var_24_3 = var_24_2:GetComponentInChildren(typeof(CharacterEffect))

					var_24_3.enabled = true

					local var_24_4 = GameObjectTools.GetOrAddComponent(var_24_2, typeof(DynamicBoneHelper))

					if var_24_4 then
						var_24_4:EnableDynamicBone(false)
					end

					arg_21_1:ShowWeapon(var_24_3.transform, false)

					arg_21_1.var_[var_24_0 .. "Animator"] = var_24_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_21_1.var_[var_24_0 .. "Animator"].applyRootMotion = true
					arg_21_1.var_[var_24_0 .. "LipSync"] = var_24_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_24_5 = arg_21_1.actors_["10131ui_story"].transform
			local var_24_6 = 0

			if var_24_6 < arg_21_1.time_ and arg_21_1.time_ <= var_24_6 + arg_24_0 then
				arg_21_1.var_.moveOldPos10131ui_story = var_24_5.localPosition
			end

			local var_24_7 = 0.001

			if var_24_6 <= arg_21_1.time_ and arg_21_1.time_ < var_24_6 + var_24_7 then
				local var_24_8 = (arg_21_1.time_ - var_24_6) / var_24_7
				local var_24_9 = Vector3.New(0.83, -0.96, -5.8)

				var_24_5.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos10131ui_story, var_24_9, var_24_8)

				local var_24_10 = manager.ui.mainCamera.transform.position - var_24_5.position

				var_24_5.forward = Vector3.New(var_24_10.x, var_24_10.y, var_24_10.z)

				local var_24_11 = var_24_5.localEulerAngles

				var_24_11.z = 0
				var_24_11.x = 0
				var_24_5.localEulerAngles = var_24_11
			end

			if arg_21_1.time_ >= var_24_6 + var_24_7 and arg_21_1.time_ < var_24_6 + var_24_7 + arg_24_0 then
				var_24_5.localPosition = Vector3.New(0.83, -0.96, -5.8)

				local var_24_12 = manager.ui.mainCamera.transform.position - var_24_5.position

				var_24_5.forward = Vector3.New(var_24_12.x, var_24_12.y, var_24_12.z)

				local var_24_13 = var_24_5.localEulerAngles

				var_24_13.z = 0
				var_24_13.x = 0
				var_24_5.localEulerAngles = var_24_13
			end

			local var_24_14 = arg_21_1.actors_["10131ui_story"]
			local var_24_15 = 0

			if var_24_15 < arg_21_1.time_ and arg_21_1.time_ <= var_24_15 + arg_24_0 and not isNil(var_24_14) and arg_21_1.var_.characterEffect10131ui_story == nil then
				arg_21_1.var_.characterEffect10131ui_story = var_24_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_16 = 0.200000002980232

			if var_24_15 <= arg_21_1.time_ and arg_21_1.time_ < var_24_15 + var_24_16 and not isNil(var_24_14) then
				local var_24_17 = (arg_21_1.time_ - var_24_15) / var_24_16

				if arg_21_1.var_.characterEffect10131ui_story and not isNil(var_24_14) then
					arg_21_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= var_24_15 + var_24_16 and arg_21_1.time_ < var_24_15 + var_24_16 + arg_24_0 and not isNil(var_24_14) and arg_21_1.var_.characterEffect10131ui_story then
				arg_21_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_24_18 = arg_21_1.actors_["1111ui_story"]
			local var_24_19 = 0

			if var_24_19 < arg_21_1.time_ and arg_21_1.time_ <= var_24_19 + arg_24_0 and not isNil(var_24_18) and arg_21_1.var_.characterEffect1111ui_story == nil then
				arg_21_1.var_.characterEffect1111ui_story = var_24_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_20 = 0.200000002980232

			if var_24_19 <= arg_21_1.time_ and arg_21_1.time_ < var_24_19 + var_24_20 and not isNil(var_24_18) then
				local var_24_21 = (arg_21_1.time_ - var_24_19) / var_24_20

				if arg_21_1.var_.characterEffect1111ui_story and not isNil(var_24_18) then
					local var_24_22 = Mathf.Lerp(0, 0.5, var_24_21)

					arg_21_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1111ui_story.fillRatio = var_24_22
				end
			end

			if arg_21_1.time_ >= var_24_19 + var_24_20 and arg_21_1.time_ < var_24_19 + var_24_20 + arg_24_0 and not isNil(var_24_18) and arg_21_1.var_.characterEffect1111ui_story then
				local var_24_23 = 0.5

				arg_21_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1111ui_story.fillRatio = var_24_23
			end

			local var_24_24 = 0

			if var_24_24 < arg_21_1.time_ and arg_21_1.time_ <= var_24_24 + arg_24_0 then
				arg_21_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action5_1")
			end

			local var_24_25 = 0

			if var_24_25 < arg_21_1.time_ and arg_21_1.time_ <= var_24_25 + arg_24_0 then
				arg_21_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_24_26 = 0
			local var_24_27 = 0.075

			if var_24_26 < arg_21_1.time_ and arg_21_1.time_ <= var_24_26 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_28 = arg_21_1:FormatText(StoryNameCfg[1178].name)

				arg_21_1.leftNameTxt_.text = var_24_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_29 = arg_21_1:GetWordFromCfg(321371005)
				local var_24_30 = arg_21_1:FormatText(var_24_29.content)

				arg_21_1.text_.text = var_24_30

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_31 = 3
				local var_24_32 = utf8.len(var_24_30)
				local var_24_33 = var_24_31 <= 0 and var_24_27 or var_24_27 * (var_24_32 / var_24_31)

				if var_24_33 > 0 and var_24_27 < var_24_33 then
					arg_21_1.talkMaxDuration = var_24_33

					if var_24_33 + var_24_26 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_33 + var_24_26
					end
				end

				arg_21_1.text_.text = var_24_30
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371005", "story_v_out_321371.awb") ~= 0 then
					local var_24_34 = manager.audio:GetVoiceLength("story_v_out_321371", "321371005", "story_v_out_321371.awb") / 1000

					if var_24_34 + var_24_26 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_34 + var_24_26
					end

					if var_24_29.prefab_name ~= "" and arg_21_1.actors_[var_24_29.prefab_name] ~= nil then
						local var_24_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_29.prefab_name].transform, "story_v_out_321371", "321371005", "story_v_out_321371.awb")

						arg_21_1:RecordAudio("321371005", var_24_35)
						arg_21_1:RecordAudio("321371005", var_24_35)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_321371", "321371005", "story_v_out_321371.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_321371", "321371005", "story_v_out_321371.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_36 = math.max(var_24_27, arg_21_1.talkMaxDuration)

			if var_24_26 <= arg_21_1.time_ and arg_21_1.time_ < var_24_26 + var_24_36 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_26) / var_24_36

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_26 + var_24_36 and arg_21_1.time_ < var_24_26 + var_24_36 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10131ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_21_1:InitPlayNodeList()
	end,
	Play321371006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 321371006
		arg_25_1.duration_ = 5.3

		local var_25_0 = {
			zh = 4.833,
			ja = 5.3
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
				arg_25_0:Play321371007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["1111ui_story"].transform
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.var_.moveOldPos1111ui_story = var_28_0.localPosition
			end

			local var_28_2 = 0.001

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2
				local var_28_4 = Vector3.New(-0.79, -0.87, -5.7)

				var_28_0.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1111ui_story, var_28_4, var_28_3)

				local var_28_5 = manager.ui.mainCamera.transform.position - var_28_0.position

				var_28_0.forward = Vector3.New(var_28_5.x, var_28_5.y, var_28_5.z)

				local var_28_6 = var_28_0.localEulerAngles

				var_28_6.z = 0
				var_28_6.x = 0
				var_28_0.localEulerAngles = var_28_6
			end

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 then
				var_28_0.localPosition = Vector3.New(-0.79, -0.87, -5.7)

				local var_28_7 = manager.ui.mainCamera.transform.position - var_28_0.position

				var_28_0.forward = Vector3.New(var_28_7.x, var_28_7.y, var_28_7.z)

				local var_28_8 = var_28_0.localEulerAngles

				var_28_8.z = 0
				var_28_8.x = 0
				var_28_0.localEulerAngles = var_28_8
			end

			local var_28_9 = arg_25_1.actors_["1111ui_story"]
			local var_28_10 = 0

			if var_28_10 < arg_25_1.time_ and arg_25_1.time_ <= var_28_10 + arg_28_0 and not isNil(var_28_9) and arg_25_1.var_.characterEffect1111ui_story == nil then
				arg_25_1.var_.characterEffect1111ui_story = var_28_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_11 = 0.200000002980232

			if var_28_10 <= arg_25_1.time_ and arg_25_1.time_ < var_28_10 + var_28_11 and not isNil(var_28_9) then
				local var_28_12 = (arg_25_1.time_ - var_28_10) / var_28_11

				if arg_25_1.var_.characterEffect1111ui_story and not isNil(var_28_9) then
					arg_25_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= var_28_10 + var_28_11 and arg_25_1.time_ < var_28_10 + var_28_11 + arg_28_0 and not isNil(var_28_9) and arg_25_1.var_.characterEffect1111ui_story then
				arg_25_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_28_13 = arg_25_1.actors_["10131ui_story"]
			local var_28_14 = 0

			if var_28_14 < arg_25_1.time_ and arg_25_1.time_ <= var_28_14 + arg_28_0 and not isNil(var_28_13) and arg_25_1.var_.characterEffect10131ui_story == nil then
				arg_25_1.var_.characterEffect10131ui_story = var_28_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_15 = 0.200000002980232

			if var_28_14 <= arg_25_1.time_ and arg_25_1.time_ < var_28_14 + var_28_15 and not isNil(var_28_13) then
				local var_28_16 = (arg_25_1.time_ - var_28_14) / var_28_15

				if arg_25_1.var_.characterEffect10131ui_story and not isNil(var_28_13) then
					local var_28_17 = Mathf.Lerp(0, 0.5, var_28_16)

					arg_25_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_25_1.var_.characterEffect10131ui_story.fillRatio = var_28_17
				end
			end

			if arg_25_1.time_ >= var_28_14 + var_28_15 and arg_25_1.time_ < var_28_14 + var_28_15 + arg_28_0 and not isNil(var_28_13) and arg_25_1.var_.characterEffect10131ui_story then
				local var_28_18 = 0.5

				arg_25_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_25_1.var_.characterEffect10131ui_story.fillRatio = var_28_18
			end

			local var_28_19 = 0
			local var_28_20 = 0.475

			if var_28_19 < arg_25_1.time_ and arg_25_1.time_ <= var_28_19 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_21 = arg_25_1:FormatText(StoryNameCfg[67].name)

				arg_25_1.leftNameTxt_.text = var_28_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_22 = arg_25_1:GetWordFromCfg(321371006)
				local var_28_23 = arg_25_1:FormatText(var_28_22.content)

				arg_25_1.text_.text = var_28_23

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_24 = 19
				local var_28_25 = utf8.len(var_28_23)
				local var_28_26 = var_28_24 <= 0 and var_28_20 or var_28_20 * (var_28_25 / var_28_24)

				if var_28_26 > 0 and var_28_20 < var_28_26 then
					arg_25_1.talkMaxDuration = var_28_26

					if var_28_26 + var_28_19 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_26 + var_28_19
					end
				end

				arg_25_1.text_.text = var_28_23
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371006", "story_v_out_321371.awb") ~= 0 then
					local var_28_27 = manager.audio:GetVoiceLength("story_v_out_321371", "321371006", "story_v_out_321371.awb") / 1000

					if var_28_27 + var_28_19 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_27 + var_28_19
					end

					if var_28_22.prefab_name ~= "" and arg_25_1.actors_[var_28_22.prefab_name] ~= nil then
						local var_28_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_22.prefab_name].transform, "story_v_out_321371", "321371006", "story_v_out_321371.awb")

						arg_25_1:RecordAudio("321371006", var_28_28)
						arg_25_1:RecordAudio("321371006", var_28_28)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_321371", "321371006", "story_v_out_321371.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_321371", "321371006", "story_v_out_321371.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_29 = math.max(var_28_20, arg_25_1.talkMaxDuration)

			if var_28_19 <= arg_25_1.time_ and arg_25_1.time_ < var_28_19 + var_28_29 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_19) / var_28_29

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_19 + var_28_29 and arg_25_1.time_ < var_28_19 + var_28_29 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_25_1:InitPlayNodeList()
	end,
	Play321371007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 321371007
		arg_29_1.duration_ = 6.83

		local var_29_0 = {
			zh = 5.733,
			ja = 6.833
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
				arg_29_0:Play321371008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["1111ui_story"].transform
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 then
				arg_29_1.var_.moveOldPos1111ui_story = var_32_0.localPosition
			end

			local var_32_2 = 0.001

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2
				local var_32_4 = Vector3.New(-0.79, -0.87, -5.7)

				var_32_0.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1111ui_story, var_32_4, var_32_3)

				local var_32_5 = manager.ui.mainCamera.transform.position - var_32_0.position

				var_32_0.forward = Vector3.New(var_32_5.x, var_32_5.y, var_32_5.z)

				local var_32_6 = var_32_0.localEulerAngles

				var_32_6.z = 0
				var_32_6.x = 0
				var_32_0.localEulerAngles = var_32_6
			end

			if arg_29_1.time_ >= var_32_1 + var_32_2 and arg_29_1.time_ < var_32_1 + var_32_2 + arg_32_0 then
				var_32_0.localPosition = Vector3.New(-0.79, -0.87, -5.7)

				local var_32_7 = manager.ui.mainCamera.transform.position - var_32_0.position

				var_32_0.forward = Vector3.New(var_32_7.x, var_32_7.y, var_32_7.z)

				local var_32_8 = var_32_0.localEulerAngles

				var_32_8.z = 0
				var_32_8.x = 0
				var_32_0.localEulerAngles = var_32_8
			end

			local var_32_9 = 0

			if var_32_9 < arg_29_1.time_ and arg_29_1.time_ <= var_32_9 + arg_32_0 then
				arg_29_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action4_2")
			end

			local var_32_10 = 0

			if var_32_10 < arg_29_1.time_ and arg_29_1.time_ <= var_32_10 + arg_32_0 then
				arg_29_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_32_11 = 0
			local var_32_12 = 0.725

			if var_32_11 < arg_29_1.time_ and arg_29_1.time_ <= var_32_11 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_13 = arg_29_1:FormatText(StoryNameCfg[67].name)

				arg_29_1.leftNameTxt_.text = var_32_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_14 = arg_29_1:GetWordFromCfg(321371007)
				local var_32_15 = arg_29_1:FormatText(var_32_14.content)

				arg_29_1.text_.text = var_32_15

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_16 = 29
				local var_32_17 = utf8.len(var_32_15)
				local var_32_18 = var_32_16 <= 0 and var_32_12 or var_32_12 * (var_32_17 / var_32_16)

				if var_32_18 > 0 and var_32_12 < var_32_18 then
					arg_29_1.talkMaxDuration = var_32_18

					if var_32_18 + var_32_11 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_18 + var_32_11
					end
				end

				arg_29_1.text_.text = var_32_15
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371007", "story_v_out_321371.awb") ~= 0 then
					local var_32_19 = manager.audio:GetVoiceLength("story_v_out_321371", "321371007", "story_v_out_321371.awb") / 1000

					if var_32_19 + var_32_11 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_19 + var_32_11
					end

					if var_32_14.prefab_name ~= "" and arg_29_1.actors_[var_32_14.prefab_name] ~= nil then
						local var_32_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_14.prefab_name].transform, "story_v_out_321371", "321371007", "story_v_out_321371.awb")

						arg_29_1:RecordAudio("321371007", var_32_20)
						arg_29_1:RecordAudio("321371007", var_32_20)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_321371", "321371007", "story_v_out_321371.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_321371", "321371007", "story_v_out_321371.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_21 = math.max(var_32_12, arg_29_1.talkMaxDuration)

			if var_32_11 <= arg_29_1.time_ and arg_29_1.time_ < var_32_11 + var_32_21 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_11) / var_32_21

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_11 + var_32_21 and arg_29_1.time_ < var_32_11 + var_32_21 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
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
	Play321371008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 321371008
		arg_33_1.duration_ = 8.07

		local var_33_0 = {
			zh = 5.7,
			ja = 8.066
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
				arg_33_0:Play321371009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["1111ui_story"].transform
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1.var_.moveOldPos1111ui_story = var_36_0.localPosition
			end

			local var_36_2 = 0.001

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2
				local var_36_4 = Vector3.New(-0.79, -0.87, -5.7)

				var_36_0.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1111ui_story, var_36_4, var_36_3)

				local var_36_5 = manager.ui.mainCamera.transform.position - var_36_0.position

				var_36_0.forward = Vector3.New(var_36_5.x, var_36_5.y, var_36_5.z)

				local var_36_6 = var_36_0.localEulerAngles

				var_36_6.z = 0
				var_36_6.x = 0
				var_36_0.localEulerAngles = var_36_6
			end

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 then
				var_36_0.localPosition = Vector3.New(-0.79, -0.87, -5.7)

				local var_36_7 = manager.ui.mainCamera.transform.position - var_36_0.position

				var_36_0.forward = Vector3.New(var_36_7.x, var_36_7.y, var_36_7.z)

				local var_36_8 = var_36_0.localEulerAngles

				var_36_8.z = 0
				var_36_8.x = 0
				var_36_0.localEulerAngles = var_36_8
			end

			local var_36_9 = 0
			local var_36_10 = 0.625

			if var_36_9 < arg_33_1.time_ and arg_33_1.time_ <= var_36_9 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_11 = arg_33_1:FormatText(StoryNameCfg[67].name)

				arg_33_1.leftNameTxt_.text = var_36_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_12 = arg_33_1:GetWordFromCfg(321371008)
				local var_36_13 = arg_33_1:FormatText(var_36_12.content)

				arg_33_1.text_.text = var_36_13

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_14 = 24
				local var_36_15 = utf8.len(var_36_13)
				local var_36_16 = var_36_14 <= 0 and var_36_10 or var_36_10 * (var_36_15 / var_36_14)

				if var_36_16 > 0 and var_36_10 < var_36_16 then
					arg_33_1.talkMaxDuration = var_36_16

					if var_36_16 + var_36_9 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_16 + var_36_9
					end
				end

				arg_33_1.text_.text = var_36_13
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371008", "story_v_out_321371.awb") ~= 0 then
					local var_36_17 = manager.audio:GetVoiceLength("story_v_out_321371", "321371008", "story_v_out_321371.awb") / 1000

					if var_36_17 + var_36_9 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_17 + var_36_9
					end

					if var_36_12.prefab_name ~= "" and arg_33_1.actors_[var_36_12.prefab_name] ~= nil then
						local var_36_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_12.prefab_name].transform, "story_v_out_321371", "321371008", "story_v_out_321371.awb")

						arg_33_1:RecordAudio("321371008", var_36_18)
						arg_33_1:RecordAudio("321371008", var_36_18)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_321371", "321371008", "story_v_out_321371.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_321371", "321371008", "story_v_out_321371.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_19 = math.max(var_36_10, arg_33_1.talkMaxDuration)

			if var_36_9 <= arg_33_1.time_ and arg_33_1.time_ < var_36_9 + var_36_19 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_9) / var_36_19

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_9 + var_36_19 and arg_33_1.time_ < var_36_9 + var_36_19 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_33_1:InitPlayNodeList()
	end,
	Play321371009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 321371009
		arg_37_1.duration_ = 3.9

		local var_37_0 = {
			zh = 2.866,
			ja = 3.9
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
				arg_37_0:Play321371010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["10131ui_story"].transform
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1.var_.moveOldPos10131ui_story = var_40_0.localPosition
			end

			local var_40_2 = 0.001

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2
				local var_40_4 = Vector3.New(0.83, -0.96, -5.8)

				var_40_0.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos10131ui_story, var_40_4, var_40_3)

				local var_40_5 = manager.ui.mainCamera.transform.position - var_40_0.position

				var_40_0.forward = Vector3.New(var_40_5.x, var_40_5.y, var_40_5.z)

				local var_40_6 = var_40_0.localEulerAngles

				var_40_6.z = 0
				var_40_6.x = 0
				var_40_0.localEulerAngles = var_40_6
			end

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 then
				var_40_0.localPosition = Vector3.New(0.83, -0.96, -5.8)

				local var_40_7 = manager.ui.mainCamera.transform.position - var_40_0.position

				var_40_0.forward = Vector3.New(var_40_7.x, var_40_7.y, var_40_7.z)

				local var_40_8 = var_40_0.localEulerAngles

				var_40_8.z = 0
				var_40_8.x = 0
				var_40_0.localEulerAngles = var_40_8
			end

			local var_40_9 = arg_37_1.actors_["10131ui_story"]
			local var_40_10 = 0

			if var_40_10 < arg_37_1.time_ and arg_37_1.time_ <= var_40_10 + arg_40_0 and not isNil(var_40_9) and arg_37_1.var_.characterEffect10131ui_story == nil then
				arg_37_1.var_.characterEffect10131ui_story = var_40_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_11 = 0.200000002980232

			if var_40_10 <= arg_37_1.time_ and arg_37_1.time_ < var_40_10 + var_40_11 and not isNil(var_40_9) then
				local var_40_12 = (arg_37_1.time_ - var_40_10) / var_40_11

				if arg_37_1.var_.characterEffect10131ui_story and not isNil(var_40_9) then
					arg_37_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= var_40_10 + var_40_11 and arg_37_1.time_ < var_40_10 + var_40_11 + arg_40_0 and not isNil(var_40_9) and arg_37_1.var_.characterEffect10131ui_story then
				arg_37_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_40_13 = arg_37_1.actors_["1111ui_story"]
			local var_40_14 = 0

			if var_40_14 < arg_37_1.time_ and arg_37_1.time_ <= var_40_14 + arg_40_0 and not isNil(var_40_13) and arg_37_1.var_.characterEffect1111ui_story == nil then
				arg_37_1.var_.characterEffect1111ui_story = var_40_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_15 = 0.200000002980232

			if var_40_14 <= arg_37_1.time_ and arg_37_1.time_ < var_40_14 + var_40_15 and not isNil(var_40_13) then
				local var_40_16 = (arg_37_1.time_ - var_40_14) / var_40_15

				if arg_37_1.var_.characterEffect1111ui_story and not isNil(var_40_13) then
					local var_40_17 = Mathf.Lerp(0, 0.5, var_40_16)

					arg_37_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1111ui_story.fillRatio = var_40_17
				end
			end

			if arg_37_1.time_ >= var_40_14 + var_40_15 and arg_37_1.time_ < var_40_14 + var_40_15 + arg_40_0 and not isNil(var_40_13) and arg_37_1.var_.characterEffect1111ui_story then
				local var_40_18 = 0.5

				arg_37_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1111ui_story.fillRatio = var_40_18
			end

			local var_40_19 = 0

			if var_40_19 < arg_37_1.time_ and arg_37_1.time_ <= var_40_19 + arg_40_0 then
				arg_37_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131actionlink/10131action456")
			end

			local var_40_20 = 0

			if var_40_20 < arg_37_1.time_ and arg_37_1.time_ <= var_40_20 + arg_40_0 then
				arg_37_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_40_21 = 0
			local var_40_22 = 0.35

			if var_40_21 < arg_37_1.time_ and arg_37_1.time_ <= var_40_21 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_23 = arg_37_1:FormatText(StoryNameCfg[1178].name)

				arg_37_1.leftNameTxt_.text = var_40_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_24 = arg_37_1:GetWordFromCfg(321371009)
				local var_40_25 = arg_37_1:FormatText(var_40_24.content)

				arg_37_1.text_.text = var_40_25

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_26 = 14
				local var_40_27 = utf8.len(var_40_25)
				local var_40_28 = var_40_26 <= 0 and var_40_22 or var_40_22 * (var_40_27 / var_40_26)

				if var_40_28 > 0 and var_40_22 < var_40_28 then
					arg_37_1.talkMaxDuration = var_40_28

					if var_40_28 + var_40_21 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_28 + var_40_21
					end
				end

				arg_37_1.text_.text = var_40_25
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371009", "story_v_out_321371.awb") ~= 0 then
					local var_40_29 = manager.audio:GetVoiceLength("story_v_out_321371", "321371009", "story_v_out_321371.awb") / 1000

					if var_40_29 + var_40_21 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_29 + var_40_21
					end

					if var_40_24.prefab_name ~= "" and arg_37_1.actors_[var_40_24.prefab_name] ~= nil then
						local var_40_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_24.prefab_name].transform, "story_v_out_321371", "321371009", "story_v_out_321371.awb")

						arg_37_1:RecordAudio("321371009", var_40_30)
						arg_37_1:RecordAudio("321371009", var_40_30)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_321371", "321371009", "story_v_out_321371.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_321371", "321371009", "story_v_out_321371.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_31 = math.max(var_40_22, arg_37_1.talkMaxDuration)

			if var_40_21 <= arg_37_1.time_ and arg_37_1.time_ < var_40_21 + var_40_31 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_21) / var_40_31

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_21 + var_40_31 and arg_37_1.time_ < var_40_21 + var_40_31 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10131ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_37_1:InitPlayNodeList()
	end,
	Play321371010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 321371010
		arg_41_1.duration_ = 3.47

		local var_41_0 = {
			zh = 2.66633333333333,
			ja = 3.46633333333333
		}
		local var_41_1 = manager.audio:GetLocalizationFlag()

		if var_41_0[var_41_1] ~= nil then
			arg_41_1.duration_ = var_41_0[var_41_1]
		end

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play321371011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["1111ui_story"].transform
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 then
				arg_41_1.var_.moveOldPos1111ui_story = var_44_0.localPosition
			end

			local var_44_2 = 0.001

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2
				local var_44_4 = Vector3.New(-0.79, -0.87, -5.7)

				var_44_0.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1111ui_story, var_44_4, var_44_3)

				local var_44_5 = manager.ui.mainCamera.transform.position - var_44_0.position

				var_44_0.forward = Vector3.New(var_44_5.x, var_44_5.y, var_44_5.z)

				local var_44_6 = var_44_0.localEulerAngles

				var_44_6.z = 0
				var_44_6.x = 0
				var_44_0.localEulerAngles = var_44_6
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 then
				var_44_0.localPosition = Vector3.New(-0.79, -0.87, -5.7)

				local var_44_7 = manager.ui.mainCamera.transform.position - var_44_0.position

				var_44_0.forward = Vector3.New(var_44_7.x, var_44_7.y, var_44_7.z)

				local var_44_8 = var_44_0.localEulerAngles

				var_44_8.z = 0
				var_44_8.x = 0
				var_44_0.localEulerAngles = var_44_8
			end

			local var_44_9 = arg_41_1.actors_["1111ui_story"]
			local var_44_10 = 0

			if var_44_10 < arg_41_1.time_ and arg_41_1.time_ <= var_44_10 + arg_44_0 and not isNil(var_44_9) and arg_41_1.var_.characterEffect1111ui_story == nil then
				arg_41_1.var_.characterEffect1111ui_story = var_44_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_11 = 0.200000002980232

			if var_44_10 <= arg_41_1.time_ and arg_41_1.time_ < var_44_10 + var_44_11 and not isNil(var_44_9) then
				local var_44_12 = (arg_41_1.time_ - var_44_10) / var_44_11

				if arg_41_1.var_.characterEffect1111ui_story and not isNil(var_44_9) then
					arg_41_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= var_44_10 + var_44_11 and arg_41_1.time_ < var_44_10 + var_44_11 + arg_44_0 and not isNil(var_44_9) and arg_41_1.var_.characterEffect1111ui_story then
				arg_41_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_44_13 = arg_41_1.actors_["10131ui_story"]
			local var_44_14 = 0

			if var_44_14 < arg_41_1.time_ and arg_41_1.time_ <= var_44_14 + arg_44_0 and not isNil(var_44_13) and arg_41_1.var_.characterEffect10131ui_story == nil then
				arg_41_1.var_.characterEffect10131ui_story = var_44_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_15 = 0.200000002980232

			if var_44_14 <= arg_41_1.time_ and arg_41_1.time_ < var_44_14 + var_44_15 and not isNil(var_44_13) then
				local var_44_16 = (arg_41_1.time_ - var_44_14) / var_44_15

				if arg_41_1.var_.characterEffect10131ui_story and not isNil(var_44_13) then
					local var_44_17 = Mathf.Lerp(0, 0.5, var_44_16)

					arg_41_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_41_1.var_.characterEffect10131ui_story.fillRatio = var_44_17
				end
			end

			if arg_41_1.time_ >= var_44_14 + var_44_15 and arg_41_1.time_ < var_44_14 + var_44_15 + arg_44_0 and not isNil(var_44_13) and arg_41_1.var_.characterEffect10131ui_story then
				local var_44_18 = 0.5

				arg_41_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_41_1.var_.characterEffect10131ui_story.fillRatio = var_44_18
			end

			local var_44_19 = 0

			if var_44_19 < arg_41_1.time_ and arg_41_1.time_ <= var_44_19 + arg_44_0 then
				arg_41_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action2_1")
			end

			local var_44_20 = 0

			if var_44_20 < arg_41_1.time_ and arg_41_1.time_ <= var_44_20 + arg_44_0 then
				arg_41_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_44_21 = 0

			if var_44_21 < arg_41_1.time_ and arg_41_1.time_ <= var_44_21 + arg_44_0 then
				arg_41_1.allBtn_.enabled = false
			end

			local var_44_22 = 0.908333333333333

			if arg_41_1.time_ >= var_44_21 + var_44_22 and arg_41_1.time_ < var_44_21 + var_44_22 + arg_44_0 then
				arg_41_1.allBtn_.enabled = true
			end

			if arg_41_1.frameCnt_ <= 1 then
				arg_41_1.dialog_:SetActive(false)
			end

			local var_44_23 = 0.733333333333333
			local var_44_24 = 0.175

			if var_44_23 < arg_41_1.time_ and arg_41_1.time_ <= var_44_23 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0

				arg_41_1.dialog_:SetActive(true)

				arg_41_1.dialogCg_.alpha = 0

				local var_44_25 = LeanTween.value(arg_41_1.dialog_, 0, 1, 0.3)

				var_44_25:setOnUpdate(LuaHelper.FloatAction(function(arg_45_0)
					arg_41_1.dialogCg_.alpha = arg_45_0
				end))
				var_44_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_41_1.dialog_)
					var_44_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_41_1.duration_ = arg_41_1.duration_ + 0.3

				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_26 = arg_41_1:FormatText(StoryNameCfg[67].name)

				arg_41_1.leftNameTxt_.text = var_44_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_27 = arg_41_1:GetWordFromCfg(321371010)
				local var_44_28 = arg_41_1:FormatText(var_44_27.content)

				arg_41_1.text_.text = var_44_28

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_29 = 7
				local var_44_30 = utf8.len(var_44_28)
				local var_44_31 = var_44_29 <= 0 and var_44_24 or var_44_24 * (var_44_30 / var_44_29)

				if var_44_31 > 0 and var_44_24 < var_44_31 then
					arg_41_1.talkMaxDuration = var_44_31
					var_44_23 = var_44_23 + 0.3

					if var_44_31 + var_44_23 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_31 + var_44_23
					end
				end

				arg_41_1.text_.text = var_44_28
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371010", "story_v_out_321371.awb") ~= 0 then
					local var_44_32 = manager.audio:GetVoiceLength("story_v_out_321371", "321371010", "story_v_out_321371.awb") / 1000

					if var_44_32 + var_44_23 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_32 + var_44_23
					end

					if var_44_27.prefab_name ~= "" and arg_41_1.actors_[var_44_27.prefab_name] ~= nil then
						local var_44_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_27.prefab_name].transform, "story_v_out_321371", "321371010", "story_v_out_321371.awb")

						arg_41_1:RecordAudio("321371010", var_44_33)
						arg_41_1:RecordAudio("321371010", var_44_33)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_321371", "321371010", "story_v_out_321371.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_321371", "321371010", "story_v_out_321371.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_34 = var_44_23 + 0.3
			local var_44_35 = math.max(var_44_24, arg_41_1.talkMaxDuration)

			if var_44_34 <= arg_41_1.time_ and arg_41_1.time_ < var_44_34 + var_44_35 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_34) / var_44_35

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_34 + var_44_35 and arg_41_1.time_ < var_44_34 + var_44_35 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_41_1:InitPlayNodeList()
	end,
	Play321371011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 321371011
		arg_47_1.duration_ = 5.03

		local var_47_0 = {
			zh = 3.9,
			ja = 5.033
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
				arg_47_0:Play321371012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = arg_47_1.actors_["10131ui_story"].transform
			local var_50_1 = 0

			if var_50_1 < arg_47_1.time_ and arg_47_1.time_ <= var_50_1 + arg_50_0 then
				arg_47_1.var_.moveOldPos10131ui_story = var_50_0.localPosition
			end

			local var_50_2 = 0.001

			if var_50_1 <= arg_47_1.time_ and arg_47_1.time_ < var_50_1 + var_50_2 then
				local var_50_3 = (arg_47_1.time_ - var_50_1) / var_50_2
				local var_50_4 = Vector3.New(0.83, -0.96, -5.8)

				var_50_0.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos10131ui_story, var_50_4, var_50_3)

				local var_50_5 = manager.ui.mainCamera.transform.position - var_50_0.position

				var_50_0.forward = Vector3.New(var_50_5.x, var_50_5.y, var_50_5.z)

				local var_50_6 = var_50_0.localEulerAngles

				var_50_6.z = 0
				var_50_6.x = 0
				var_50_0.localEulerAngles = var_50_6
			end

			if arg_47_1.time_ >= var_50_1 + var_50_2 and arg_47_1.time_ < var_50_1 + var_50_2 + arg_50_0 then
				var_50_0.localPosition = Vector3.New(0.83, -0.96, -5.8)

				local var_50_7 = manager.ui.mainCamera.transform.position - var_50_0.position

				var_50_0.forward = Vector3.New(var_50_7.x, var_50_7.y, var_50_7.z)

				local var_50_8 = var_50_0.localEulerAngles

				var_50_8.z = 0
				var_50_8.x = 0
				var_50_0.localEulerAngles = var_50_8
			end

			local var_50_9 = arg_47_1.actors_["10131ui_story"]
			local var_50_10 = 0

			if var_50_10 < arg_47_1.time_ and arg_47_1.time_ <= var_50_10 + arg_50_0 and not isNil(var_50_9) and arg_47_1.var_.characterEffect10131ui_story == nil then
				arg_47_1.var_.characterEffect10131ui_story = var_50_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_11 = 0.200000002980232

			if var_50_10 <= arg_47_1.time_ and arg_47_1.time_ < var_50_10 + var_50_11 and not isNil(var_50_9) then
				local var_50_12 = (arg_47_1.time_ - var_50_10) / var_50_11

				if arg_47_1.var_.characterEffect10131ui_story and not isNil(var_50_9) then
					arg_47_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_47_1.time_ >= var_50_10 + var_50_11 and arg_47_1.time_ < var_50_10 + var_50_11 + arg_50_0 and not isNil(var_50_9) and arg_47_1.var_.characterEffect10131ui_story then
				arg_47_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_50_13 = arg_47_1.actors_["1111ui_story"]
			local var_50_14 = 0

			if var_50_14 < arg_47_1.time_ and arg_47_1.time_ <= var_50_14 + arg_50_0 and not isNil(var_50_13) and arg_47_1.var_.characterEffect1111ui_story == nil then
				arg_47_1.var_.characterEffect1111ui_story = var_50_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_15 = 0.200000002980232

			if var_50_14 <= arg_47_1.time_ and arg_47_1.time_ < var_50_14 + var_50_15 and not isNil(var_50_13) then
				local var_50_16 = (arg_47_1.time_ - var_50_14) / var_50_15

				if arg_47_1.var_.characterEffect1111ui_story and not isNil(var_50_13) then
					local var_50_17 = Mathf.Lerp(0, 0.5, var_50_16)

					arg_47_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_47_1.var_.characterEffect1111ui_story.fillRatio = var_50_17
				end
			end

			if arg_47_1.time_ >= var_50_14 + var_50_15 and arg_47_1.time_ < var_50_14 + var_50_15 + arg_50_0 and not isNil(var_50_13) and arg_47_1.var_.characterEffect1111ui_story then
				local var_50_18 = 0.5

				arg_47_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_47_1.var_.characterEffect1111ui_story.fillRatio = var_50_18
			end

			local var_50_19 = 0

			if var_50_19 < arg_47_1.time_ and arg_47_1.time_ <= var_50_19 + arg_50_0 then
				arg_47_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action6_2")
			end

			local var_50_20 = 0

			if var_50_20 < arg_47_1.time_ and arg_47_1.time_ <= var_50_20 + arg_50_0 then
				arg_47_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_50_21 = 0
			local var_50_22 = 0.45

			if var_50_21 < arg_47_1.time_ and arg_47_1.time_ <= var_50_21 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				local var_50_23 = arg_47_1:FormatText(StoryNameCfg[1178].name)

				arg_47_1.leftNameTxt_.text = var_50_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_24 = arg_47_1:GetWordFromCfg(321371011)
				local var_50_25 = arg_47_1:FormatText(var_50_24.content)

				arg_47_1.text_.text = var_50_25

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_26 = 18
				local var_50_27 = utf8.len(var_50_25)
				local var_50_28 = var_50_26 <= 0 and var_50_22 or var_50_22 * (var_50_27 / var_50_26)

				if var_50_28 > 0 and var_50_22 < var_50_28 then
					arg_47_1.talkMaxDuration = var_50_28

					if var_50_28 + var_50_21 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_28 + var_50_21
					end
				end

				arg_47_1.text_.text = var_50_25
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371011", "story_v_out_321371.awb") ~= 0 then
					local var_50_29 = manager.audio:GetVoiceLength("story_v_out_321371", "321371011", "story_v_out_321371.awb") / 1000

					if var_50_29 + var_50_21 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_29 + var_50_21
					end

					if var_50_24.prefab_name ~= "" and arg_47_1.actors_[var_50_24.prefab_name] ~= nil then
						local var_50_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_24.prefab_name].transform, "story_v_out_321371", "321371011", "story_v_out_321371.awb")

						arg_47_1:RecordAudio("321371011", var_50_30)
						arg_47_1:RecordAudio("321371011", var_50_30)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_321371", "321371011", "story_v_out_321371.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_321371", "321371011", "story_v_out_321371.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_31 = math.max(var_50_22, arg_47_1.talkMaxDuration)

			if var_50_21 <= arg_47_1.time_ and arg_47_1.time_ < var_50_21 + var_50_31 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_21) / var_50_31

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_21 + var_50_31 and arg_47_1.time_ < var_50_21 + var_50_31 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10131ui_story",
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
	Play321371012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 321371012
		arg_51_1.duration_ = 9.63

		local var_51_0 = {
			zh = 7.9,
			ja = 9.633
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
				arg_51_0:Play321371013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = 0
			local var_54_1 = 0.975

			if var_54_0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_0 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				local var_54_2 = arg_51_1:FormatText(StoryNameCfg[1178].name)

				arg_51_1.leftNameTxt_.text = var_54_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_3 = arg_51_1:GetWordFromCfg(321371012)
				local var_54_4 = arg_51_1:FormatText(var_54_3.content)

				arg_51_1.text_.text = var_54_4

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_5 = 39
				local var_54_6 = utf8.len(var_54_4)
				local var_54_7 = var_54_5 <= 0 and var_54_1 or var_54_1 * (var_54_6 / var_54_5)

				if var_54_7 > 0 and var_54_1 < var_54_7 then
					arg_51_1.talkMaxDuration = var_54_7

					if var_54_7 + var_54_0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_7 + var_54_0
					end
				end

				arg_51_1.text_.text = var_54_4
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371012", "story_v_out_321371.awb") ~= 0 then
					local var_54_8 = manager.audio:GetVoiceLength("story_v_out_321371", "321371012", "story_v_out_321371.awb") / 1000

					if var_54_8 + var_54_0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_8 + var_54_0
					end

					if var_54_3.prefab_name ~= "" and arg_51_1.actors_[var_54_3.prefab_name] ~= nil then
						local var_54_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_3.prefab_name].transform, "story_v_out_321371", "321371012", "story_v_out_321371.awb")

						arg_51_1:RecordAudio("321371012", var_54_9)
						arg_51_1:RecordAudio("321371012", var_54_9)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_321371", "321371012", "story_v_out_321371.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_321371", "321371012", "story_v_out_321371.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_10 = math.max(var_54_1, arg_51_1.talkMaxDuration)

			if var_54_0 <= arg_51_1.time_ and arg_51_1.time_ < var_54_0 + var_54_10 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_0) / var_54_10

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_0 + var_54_10 and arg_51_1.time_ < var_54_0 + var_54_10 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play321371013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 321371013
		arg_55_1.duration_ = 7.83

		local var_55_0 = {
			zh = 5.4,
			ja = 7.833
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
				arg_55_0:Play321371014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = arg_55_1.actors_["1111ui_story"].transform
			local var_58_1 = 0

			if var_58_1 < arg_55_1.time_ and arg_55_1.time_ <= var_58_1 + arg_58_0 then
				arg_55_1.var_.moveOldPos1111ui_story = var_58_0.localPosition
			end

			local var_58_2 = 0.001

			if var_58_1 <= arg_55_1.time_ and arg_55_1.time_ < var_58_1 + var_58_2 then
				local var_58_3 = (arg_55_1.time_ - var_58_1) / var_58_2
				local var_58_4 = Vector3.New(-0.79, -0.87, -5.7)

				var_58_0.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos1111ui_story, var_58_4, var_58_3)

				local var_58_5 = manager.ui.mainCamera.transform.position - var_58_0.position

				var_58_0.forward = Vector3.New(var_58_5.x, var_58_5.y, var_58_5.z)

				local var_58_6 = var_58_0.localEulerAngles

				var_58_6.z = 0
				var_58_6.x = 0
				var_58_0.localEulerAngles = var_58_6
			end

			if arg_55_1.time_ >= var_58_1 + var_58_2 and arg_55_1.time_ < var_58_1 + var_58_2 + arg_58_0 then
				var_58_0.localPosition = Vector3.New(-0.79, -0.87, -5.7)

				local var_58_7 = manager.ui.mainCamera.transform.position - var_58_0.position

				var_58_0.forward = Vector3.New(var_58_7.x, var_58_7.y, var_58_7.z)

				local var_58_8 = var_58_0.localEulerAngles

				var_58_8.z = 0
				var_58_8.x = 0
				var_58_0.localEulerAngles = var_58_8
			end

			local var_58_9 = arg_55_1.actors_["1111ui_story"]
			local var_58_10 = 0

			if var_58_10 < arg_55_1.time_ and arg_55_1.time_ <= var_58_10 + arg_58_0 and not isNil(var_58_9) and arg_55_1.var_.characterEffect1111ui_story == nil then
				arg_55_1.var_.characterEffect1111ui_story = var_58_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_11 = 0.200000002980232

			if var_58_10 <= arg_55_1.time_ and arg_55_1.time_ < var_58_10 + var_58_11 and not isNil(var_58_9) then
				local var_58_12 = (arg_55_1.time_ - var_58_10) / var_58_11

				if arg_55_1.var_.characterEffect1111ui_story and not isNil(var_58_9) then
					arg_55_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_55_1.time_ >= var_58_10 + var_58_11 and arg_55_1.time_ < var_58_10 + var_58_11 + arg_58_0 and not isNil(var_58_9) and arg_55_1.var_.characterEffect1111ui_story then
				arg_55_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_58_13 = arg_55_1.actors_["10131ui_story"]
			local var_58_14 = 0

			if var_58_14 < arg_55_1.time_ and arg_55_1.time_ <= var_58_14 + arg_58_0 and not isNil(var_58_13) and arg_55_1.var_.characterEffect10131ui_story == nil then
				arg_55_1.var_.characterEffect10131ui_story = var_58_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_15 = 0.200000002980232

			if var_58_14 <= arg_55_1.time_ and arg_55_1.time_ < var_58_14 + var_58_15 and not isNil(var_58_13) then
				local var_58_16 = (arg_55_1.time_ - var_58_14) / var_58_15

				if arg_55_1.var_.characterEffect10131ui_story and not isNil(var_58_13) then
					local var_58_17 = Mathf.Lerp(0, 0.5, var_58_16)

					arg_55_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_55_1.var_.characterEffect10131ui_story.fillRatio = var_58_17
				end
			end

			if arg_55_1.time_ >= var_58_14 + var_58_15 and arg_55_1.time_ < var_58_14 + var_58_15 + arg_58_0 and not isNil(var_58_13) and arg_55_1.var_.characterEffect10131ui_story then
				local var_58_18 = 0.5

				arg_55_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_55_1.var_.characterEffect10131ui_story.fillRatio = var_58_18
			end

			local var_58_19 = 0

			if var_58_19 < arg_55_1.time_ and arg_55_1.time_ <= var_58_19 + arg_58_0 then
				arg_55_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action2_2")
			end

			local var_58_20 = 0

			if var_58_20 < arg_55_1.time_ and arg_55_1.time_ <= var_58_20 + arg_58_0 then
				arg_55_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_58_21 = 0
			local var_58_22 = 0.65

			if var_58_21 < arg_55_1.time_ and arg_55_1.time_ <= var_58_21 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				local var_58_23 = arg_55_1:FormatText(StoryNameCfg[67].name)

				arg_55_1.leftNameTxt_.text = var_58_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_24 = arg_55_1:GetWordFromCfg(321371013)
				local var_58_25 = arg_55_1:FormatText(var_58_24.content)

				arg_55_1.text_.text = var_58_25

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_26 = 26
				local var_58_27 = utf8.len(var_58_25)
				local var_58_28 = var_58_26 <= 0 and var_58_22 or var_58_22 * (var_58_27 / var_58_26)

				if var_58_28 > 0 and var_58_22 < var_58_28 then
					arg_55_1.talkMaxDuration = var_58_28

					if var_58_28 + var_58_21 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_28 + var_58_21
					end
				end

				arg_55_1.text_.text = var_58_25
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371013", "story_v_out_321371.awb") ~= 0 then
					local var_58_29 = manager.audio:GetVoiceLength("story_v_out_321371", "321371013", "story_v_out_321371.awb") / 1000

					if var_58_29 + var_58_21 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_29 + var_58_21
					end

					if var_58_24.prefab_name ~= "" and arg_55_1.actors_[var_58_24.prefab_name] ~= nil then
						local var_58_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_24.prefab_name].transform, "story_v_out_321371", "321371013", "story_v_out_321371.awb")

						arg_55_1:RecordAudio("321371013", var_58_30)
						arg_55_1:RecordAudio("321371013", var_58_30)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_321371", "321371013", "story_v_out_321371.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_321371", "321371013", "story_v_out_321371.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_31 = math.max(var_58_22, arg_55_1.talkMaxDuration)

			if var_58_21 <= arg_55_1.time_ and arg_55_1.time_ < var_58_21 + var_58_31 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_21) / var_58_31

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_21 + var_58_31 and arg_55_1.time_ < var_58_21 + var_58_31 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_55_1:InitPlayNodeList()
	end,
	Play321371014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 321371014
		arg_59_1.duration_ = 6

		local var_59_0 = {
			zh = 5.8,
			ja = 6
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
				arg_59_0:Play321371015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = 0
			local var_62_1 = 0.775

			if var_62_0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_0 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				local var_62_2 = arg_59_1:FormatText(StoryNameCfg[67].name)

				arg_59_1.leftNameTxt_.text = var_62_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_3 = arg_59_1:GetWordFromCfg(321371014)
				local var_62_4 = arg_59_1:FormatText(var_62_3.content)

				arg_59_1.text_.text = var_62_4

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_5 = 31
				local var_62_6 = utf8.len(var_62_4)
				local var_62_7 = var_62_5 <= 0 and var_62_1 or var_62_1 * (var_62_6 / var_62_5)

				if var_62_7 > 0 and var_62_1 < var_62_7 then
					arg_59_1.talkMaxDuration = var_62_7

					if var_62_7 + var_62_0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_7 + var_62_0
					end
				end

				arg_59_1.text_.text = var_62_4
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371014", "story_v_out_321371.awb") ~= 0 then
					local var_62_8 = manager.audio:GetVoiceLength("story_v_out_321371", "321371014", "story_v_out_321371.awb") / 1000

					if var_62_8 + var_62_0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_8 + var_62_0
					end

					if var_62_3.prefab_name ~= "" and arg_59_1.actors_[var_62_3.prefab_name] ~= nil then
						local var_62_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_3.prefab_name].transform, "story_v_out_321371", "321371014", "story_v_out_321371.awb")

						arg_59_1:RecordAudio("321371014", var_62_9)
						arg_59_1:RecordAudio("321371014", var_62_9)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_321371", "321371014", "story_v_out_321371.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_321371", "321371014", "story_v_out_321371.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_10 = math.max(var_62_1, arg_59_1.talkMaxDuration)

			if var_62_0 <= arg_59_1.time_ and arg_59_1.time_ < var_62_0 + var_62_10 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_0) / var_62_10

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_0 + var_62_10 and arg_59_1.time_ < var_62_0 + var_62_10 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play321371015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 321371015
		arg_63_1.duration_ = 11.07

		local var_63_0 = {
			zh = 7.6,
			ja = 11.066
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
				arg_63_0:Play321371016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = 0
			local var_66_1 = 0.85

			if var_66_0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_0 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				local var_66_2 = arg_63_1:FormatText(StoryNameCfg[67].name)

				arg_63_1.leftNameTxt_.text = var_66_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_3 = arg_63_1:GetWordFromCfg(321371015)
				local var_66_4 = arg_63_1:FormatText(var_66_3.content)

				arg_63_1.text_.text = var_66_4

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_5 = 34
				local var_66_6 = utf8.len(var_66_4)
				local var_66_7 = var_66_5 <= 0 and var_66_1 or var_66_1 * (var_66_6 / var_66_5)

				if var_66_7 > 0 and var_66_1 < var_66_7 then
					arg_63_1.talkMaxDuration = var_66_7

					if var_66_7 + var_66_0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_7 + var_66_0
					end
				end

				arg_63_1.text_.text = var_66_4
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371015", "story_v_out_321371.awb") ~= 0 then
					local var_66_8 = manager.audio:GetVoiceLength("story_v_out_321371", "321371015", "story_v_out_321371.awb") / 1000

					if var_66_8 + var_66_0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_8 + var_66_0
					end

					if var_66_3.prefab_name ~= "" and arg_63_1.actors_[var_66_3.prefab_name] ~= nil then
						local var_66_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_3.prefab_name].transform, "story_v_out_321371", "321371015", "story_v_out_321371.awb")

						arg_63_1:RecordAudio("321371015", var_66_9)
						arg_63_1:RecordAudio("321371015", var_66_9)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_321371", "321371015", "story_v_out_321371.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_321371", "321371015", "story_v_out_321371.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_10 = math.max(var_66_1, arg_63_1.talkMaxDuration)

			if var_66_0 <= arg_63_1.time_ and arg_63_1.time_ < var_66_0 + var_66_10 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_0) / var_66_10

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_0 + var_66_10 and arg_63_1.time_ < var_66_0 + var_66_10 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play321371016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 321371016
		arg_67_1.duration_ = 5.67

		local var_67_0 = {
			zh = 5.666,
			ja = 4.733
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
				arg_67_0:Play321371017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = arg_67_1.actors_["1111ui_story"].transform
			local var_70_1 = 0

			if var_70_1 < arg_67_1.time_ and arg_67_1.time_ <= var_70_1 + arg_70_0 then
				arg_67_1.var_.moveOldPos1111ui_story = var_70_0.localPosition
			end

			local var_70_2 = 0.001

			if var_70_1 <= arg_67_1.time_ and arg_67_1.time_ < var_70_1 + var_70_2 then
				local var_70_3 = (arg_67_1.time_ - var_70_1) / var_70_2
				local var_70_4 = Vector3.New(-0.79, -0.87, -5.7)

				var_70_0.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos1111ui_story, var_70_4, var_70_3)

				local var_70_5 = manager.ui.mainCamera.transform.position - var_70_0.position

				var_70_0.forward = Vector3.New(var_70_5.x, var_70_5.y, var_70_5.z)

				local var_70_6 = var_70_0.localEulerAngles

				var_70_6.z = 0
				var_70_6.x = 0
				var_70_0.localEulerAngles = var_70_6
			end

			if arg_67_1.time_ >= var_70_1 + var_70_2 and arg_67_1.time_ < var_70_1 + var_70_2 + arg_70_0 then
				var_70_0.localPosition = Vector3.New(-0.79, -0.87, -5.7)

				local var_70_7 = manager.ui.mainCamera.transform.position - var_70_0.position

				var_70_0.forward = Vector3.New(var_70_7.x, var_70_7.y, var_70_7.z)

				local var_70_8 = var_70_0.localEulerAngles

				var_70_8.z = 0
				var_70_8.x = 0
				var_70_0.localEulerAngles = var_70_8
			end

			local var_70_9 = 0

			if var_70_9 < arg_67_1.time_ and arg_67_1.time_ <= var_70_9 + arg_70_0 then
				arg_67_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action8_1")
			end

			local var_70_10 = 0

			if var_70_10 < arg_67_1.time_ and arg_67_1.time_ <= var_70_10 + arg_70_0 then
				arg_67_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_70_11 = 0
			local var_70_12 = 0.65

			if var_70_11 < arg_67_1.time_ and arg_67_1.time_ <= var_70_11 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				local var_70_13 = arg_67_1:FormatText(StoryNameCfg[67].name)

				arg_67_1.leftNameTxt_.text = var_70_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_14 = arg_67_1:GetWordFromCfg(321371016)
				local var_70_15 = arg_67_1:FormatText(var_70_14.content)

				arg_67_1.text_.text = var_70_15

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_16 = 26
				local var_70_17 = utf8.len(var_70_15)
				local var_70_18 = var_70_16 <= 0 and var_70_12 or var_70_12 * (var_70_17 / var_70_16)

				if var_70_18 > 0 and var_70_12 < var_70_18 then
					arg_67_1.talkMaxDuration = var_70_18

					if var_70_18 + var_70_11 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_18 + var_70_11
					end
				end

				arg_67_1.text_.text = var_70_15
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371016", "story_v_out_321371.awb") ~= 0 then
					local var_70_19 = manager.audio:GetVoiceLength("story_v_out_321371", "321371016", "story_v_out_321371.awb") / 1000

					if var_70_19 + var_70_11 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_19 + var_70_11
					end

					if var_70_14.prefab_name ~= "" and arg_67_1.actors_[var_70_14.prefab_name] ~= nil then
						local var_70_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_14.prefab_name].transform, "story_v_out_321371", "321371016", "story_v_out_321371.awb")

						arg_67_1:RecordAudio("321371016", var_70_20)
						arg_67_1:RecordAudio("321371016", var_70_20)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_321371", "321371016", "story_v_out_321371.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_321371", "321371016", "story_v_out_321371.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_21 = math.max(var_70_12, arg_67_1.talkMaxDuration)

			if var_70_11 <= arg_67_1.time_ and arg_67_1.time_ < var_70_11 + var_70_21 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_11) / var_70_21

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_11 + var_70_21 and arg_67_1.time_ < var_70_11 + var_70_21 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_67_1:InitPlayNodeList()
	end,
	Play321371017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 321371017
		arg_71_1.duration_ = 4.67

		local var_71_0 = {
			zh = 3.233,
			ja = 4.666
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
				arg_71_0:Play321371018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = arg_71_1.actors_["10131ui_story"].transform
			local var_74_1 = 0

			if var_74_1 < arg_71_1.time_ and arg_71_1.time_ <= var_74_1 + arg_74_0 then
				arg_71_1.var_.moveOldPos10131ui_story = var_74_0.localPosition
			end

			local var_74_2 = 0.001

			if var_74_1 <= arg_71_1.time_ and arg_71_1.time_ < var_74_1 + var_74_2 then
				local var_74_3 = (arg_71_1.time_ - var_74_1) / var_74_2
				local var_74_4 = Vector3.New(0.83, -0.96, -5.8)

				var_74_0.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos10131ui_story, var_74_4, var_74_3)

				local var_74_5 = manager.ui.mainCamera.transform.position - var_74_0.position

				var_74_0.forward = Vector3.New(var_74_5.x, var_74_5.y, var_74_5.z)

				local var_74_6 = var_74_0.localEulerAngles

				var_74_6.z = 0
				var_74_6.x = 0
				var_74_0.localEulerAngles = var_74_6
			end

			if arg_71_1.time_ >= var_74_1 + var_74_2 and arg_71_1.time_ < var_74_1 + var_74_2 + arg_74_0 then
				var_74_0.localPosition = Vector3.New(0.83, -0.96, -5.8)

				local var_74_7 = manager.ui.mainCamera.transform.position - var_74_0.position

				var_74_0.forward = Vector3.New(var_74_7.x, var_74_7.y, var_74_7.z)

				local var_74_8 = var_74_0.localEulerAngles

				var_74_8.z = 0
				var_74_8.x = 0
				var_74_0.localEulerAngles = var_74_8
			end

			local var_74_9 = arg_71_1.actors_["10131ui_story"]
			local var_74_10 = 0

			if var_74_10 < arg_71_1.time_ and arg_71_1.time_ <= var_74_10 + arg_74_0 and not isNil(var_74_9) and arg_71_1.var_.characterEffect10131ui_story == nil then
				arg_71_1.var_.characterEffect10131ui_story = var_74_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_11 = 0.200000002980232

			if var_74_10 <= arg_71_1.time_ and arg_71_1.time_ < var_74_10 + var_74_11 and not isNil(var_74_9) then
				local var_74_12 = (arg_71_1.time_ - var_74_10) / var_74_11

				if arg_71_1.var_.characterEffect10131ui_story and not isNil(var_74_9) then
					arg_71_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_71_1.time_ >= var_74_10 + var_74_11 and arg_71_1.time_ < var_74_10 + var_74_11 + arg_74_0 and not isNil(var_74_9) and arg_71_1.var_.characterEffect10131ui_story then
				arg_71_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_74_13 = arg_71_1.actors_["1111ui_story"]
			local var_74_14 = 0

			if var_74_14 < arg_71_1.time_ and arg_71_1.time_ <= var_74_14 + arg_74_0 and not isNil(var_74_13) and arg_71_1.var_.characterEffect1111ui_story == nil then
				arg_71_1.var_.characterEffect1111ui_story = var_74_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_15 = 0.200000002980232

			if var_74_14 <= arg_71_1.time_ and arg_71_1.time_ < var_74_14 + var_74_15 and not isNil(var_74_13) then
				local var_74_16 = (arg_71_1.time_ - var_74_14) / var_74_15

				if arg_71_1.var_.characterEffect1111ui_story and not isNil(var_74_13) then
					local var_74_17 = Mathf.Lerp(0, 0.5, var_74_16)

					arg_71_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_71_1.var_.characterEffect1111ui_story.fillRatio = var_74_17
				end
			end

			if arg_71_1.time_ >= var_74_14 + var_74_15 and arg_71_1.time_ < var_74_14 + var_74_15 + arg_74_0 and not isNil(var_74_13) and arg_71_1.var_.characterEffect1111ui_story then
				local var_74_18 = 0.5

				arg_71_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_71_1.var_.characterEffect1111ui_story.fillRatio = var_74_18
			end

			local var_74_19 = 0

			if var_74_19 < arg_71_1.time_ and arg_71_1.time_ <= var_74_19 + arg_74_0 then
				arg_71_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action1_1")
			end

			local var_74_20 = 0

			if var_74_20 < arg_71_1.time_ and arg_71_1.time_ <= var_74_20 + arg_74_0 then
				arg_71_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_74_21 = 0
			local var_74_22 = 0.275

			if var_74_21 < arg_71_1.time_ and arg_71_1.time_ <= var_74_21 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				local var_74_23 = arg_71_1:FormatText(StoryNameCfg[1178].name)

				arg_71_1.leftNameTxt_.text = var_74_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_24 = arg_71_1:GetWordFromCfg(321371017)
				local var_74_25 = arg_71_1:FormatText(var_74_24.content)

				arg_71_1.text_.text = var_74_25

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_26 = 11
				local var_74_27 = utf8.len(var_74_25)
				local var_74_28 = var_74_26 <= 0 and var_74_22 or var_74_22 * (var_74_27 / var_74_26)

				if var_74_28 > 0 and var_74_22 < var_74_28 then
					arg_71_1.talkMaxDuration = var_74_28

					if var_74_28 + var_74_21 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_28 + var_74_21
					end
				end

				arg_71_1.text_.text = var_74_25
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371017", "story_v_out_321371.awb") ~= 0 then
					local var_74_29 = manager.audio:GetVoiceLength("story_v_out_321371", "321371017", "story_v_out_321371.awb") / 1000

					if var_74_29 + var_74_21 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_29 + var_74_21
					end

					if var_74_24.prefab_name ~= "" and arg_71_1.actors_[var_74_24.prefab_name] ~= nil then
						local var_74_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_24.prefab_name].transform, "story_v_out_321371", "321371017", "story_v_out_321371.awb")

						arg_71_1:RecordAudio("321371017", var_74_30)
						arg_71_1:RecordAudio("321371017", var_74_30)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_321371", "321371017", "story_v_out_321371.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_321371", "321371017", "story_v_out_321371.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_31 = math.max(var_74_22, arg_71_1.talkMaxDuration)

			if var_74_21 <= arg_71_1.time_ and arg_71_1.time_ < var_74_21 + var_74_31 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_21) / var_74_31

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_21 + var_74_31 and arg_71_1.time_ < var_74_21 + var_74_31 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10131ui_story",
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
	Play321371018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 321371018
		arg_75_1.duration_ = 6.5

		local var_75_0 = {
			zh = 5.6,
			ja = 6.5
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
				arg_75_0:Play321371019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = arg_75_1.actors_["1111ui_story"].transform
			local var_78_1 = 0

			if var_78_1 < arg_75_1.time_ and arg_75_1.time_ <= var_78_1 + arg_78_0 then
				arg_75_1.var_.moveOldPos1111ui_story = var_78_0.localPosition
			end

			local var_78_2 = 0.001

			if var_78_1 <= arg_75_1.time_ and arg_75_1.time_ < var_78_1 + var_78_2 then
				local var_78_3 = (arg_75_1.time_ - var_78_1) / var_78_2
				local var_78_4 = Vector3.New(-0.79, -0.87, -5.7)

				var_78_0.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos1111ui_story, var_78_4, var_78_3)

				local var_78_5 = manager.ui.mainCamera.transform.position - var_78_0.position

				var_78_0.forward = Vector3.New(var_78_5.x, var_78_5.y, var_78_5.z)

				local var_78_6 = var_78_0.localEulerAngles

				var_78_6.z = 0
				var_78_6.x = 0
				var_78_0.localEulerAngles = var_78_6
			end

			if arg_75_1.time_ >= var_78_1 + var_78_2 and arg_75_1.time_ < var_78_1 + var_78_2 + arg_78_0 then
				var_78_0.localPosition = Vector3.New(-0.79, -0.87, -5.7)

				local var_78_7 = manager.ui.mainCamera.transform.position - var_78_0.position

				var_78_0.forward = Vector3.New(var_78_7.x, var_78_7.y, var_78_7.z)

				local var_78_8 = var_78_0.localEulerAngles

				var_78_8.z = 0
				var_78_8.x = 0
				var_78_0.localEulerAngles = var_78_8
			end

			local var_78_9 = arg_75_1.actors_["1111ui_story"]
			local var_78_10 = 0

			if var_78_10 < arg_75_1.time_ and arg_75_1.time_ <= var_78_10 + arg_78_0 and not isNil(var_78_9) and arg_75_1.var_.characterEffect1111ui_story == nil then
				arg_75_1.var_.characterEffect1111ui_story = var_78_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_11 = 0.200000002980232

			if var_78_10 <= arg_75_1.time_ and arg_75_1.time_ < var_78_10 + var_78_11 and not isNil(var_78_9) then
				local var_78_12 = (arg_75_1.time_ - var_78_10) / var_78_11

				if arg_75_1.var_.characterEffect1111ui_story and not isNil(var_78_9) then
					arg_75_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_75_1.time_ >= var_78_10 + var_78_11 and arg_75_1.time_ < var_78_10 + var_78_11 + arg_78_0 and not isNil(var_78_9) and arg_75_1.var_.characterEffect1111ui_story then
				arg_75_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_78_13 = arg_75_1.actors_["10131ui_story"]
			local var_78_14 = 0

			if var_78_14 < arg_75_1.time_ and arg_75_1.time_ <= var_78_14 + arg_78_0 and not isNil(var_78_13) and arg_75_1.var_.characterEffect10131ui_story == nil then
				arg_75_1.var_.characterEffect10131ui_story = var_78_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_15 = 0.200000002980232

			if var_78_14 <= arg_75_1.time_ and arg_75_1.time_ < var_78_14 + var_78_15 and not isNil(var_78_13) then
				local var_78_16 = (arg_75_1.time_ - var_78_14) / var_78_15

				if arg_75_1.var_.characterEffect10131ui_story and not isNil(var_78_13) then
					local var_78_17 = Mathf.Lerp(0, 0.5, var_78_16)

					arg_75_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_75_1.var_.characterEffect10131ui_story.fillRatio = var_78_17
				end
			end

			if arg_75_1.time_ >= var_78_14 + var_78_15 and arg_75_1.time_ < var_78_14 + var_78_15 + arg_78_0 and not isNil(var_78_13) and arg_75_1.var_.characterEffect10131ui_story then
				local var_78_18 = 0.5

				arg_75_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_75_1.var_.characterEffect10131ui_story.fillRatio = var_78_18
			end

			local var_78_19 = 0

			if var_78_19 < arg_75_1.time_ and arg_75_1.time_ <= var_78_19 + arg_78_0 then
				arg_75_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_78_20 = 0

			if var_78_20 < arg_75_1.time_ and arg_75_1.time_ <= var_78_20 + arg_78_0 then
				arg_75_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action8_2", "EmotionTimelineAnimator")
			end

			local var_78_21 = 0
			local var_78_22 = 0.65

			if var_78_21 < arg_75_1.time_ and arg_75_1.time_ <= var_78_21 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				local var_78_23 = arg_75_1:FormatText(StoryNameCfg[67].name)

				arg_75_1.leftNameTxt_.text = var_78_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_24 = arg_75_1:GetWordFromCfg(321371018)
				local var_78_25 = arg_75_1:FormatText(var_78_24.content)

				arg_75_1.text_.text = var_78_25

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_26 = 26
				local var_78_27 = utf8.len(var_78_25)
				local var_78_28 = var_78_26 <= 0 and var_78_22 or var_78_22 * (var_78_27 / var_78_26)

				if var_78_28 > 0 and var_78_22 < var_78_28 then
					arg_75_1.talkMaxDuration = var_78_28

					if var_78_28 + var_78_21 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_28 + var_78_21
					end
				end

				arg_75_1.text_.text = var_78_25
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371018", "story_v_out_321371.awb") ~= 0 then
					local var_78_29 = manager.audio:GetVoiceLength("story_v_out_321371", "321371018", "story_v_out_321371.awb") / 1000

					if var_78_29 + var_78_21 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_29 + var_78_21
					end

					if var_78_24.prefab_name ~= "" and arg_75_1.actors_[var_78_24.prefab_name] ~= nil then
						local var_78_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_24.prefab_name].transform, "story_v_out_321371", "321371018", "story_v_out_321371.awb")

						arg_75_1:RecordAudio("321371018", var_78_30)
						arg_75_1:RecordAudio("321371018", var_78_30)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_321371", "321371018", "story_v_out_321371.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_321371", "321371018", "story_v_out_321371.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_31 = math.max(var_78_22, arg_75_1.talkMaxDuration)

			if var_78_21 <= arg_75_1.time_ and arg_75_1.time_ < var_78_21 + var_78_31 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_21) / var_78_31

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_21 + var_78_31 and arg_75_1.time_ < var_78_21 + var_78_31 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_75_1:InitPlayNodeList()
	end,
	Play321371019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 321371019
		arg_79_1.duration_ = 4.07

		local var_79_0 = {
			zh = 3.466,
			ja = 4.066
		}
		local var_79_1 = manager.audio:GetLocalizationFlag()

		if var_79_0[var_79_1] ~= nil then
			arg_79_1.duration_ = var_79_0[var_79_1]
		end

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play321371020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = arg_79_1.actors_["10131ui_story"]
			local var_82_1 = 0

			if var_82_1 < arg_79_1.time_ and arg_79_1.time_ <= var_82_1 + arg_82_0 and not isNil(var_82_0) and arg_79_1.var_.characterEffect10131ui_story == nil then
				arg_79_1.var_.characterEffect10131ui_story = var_82_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_2 = 0.200000002980232

			if var_82_1 <= arg_79_1.time_ and arg_79_1.time_ < var_82_1 + var_82_2 and not isNil(var_82_0) then
				local var_82_3 = (arg_79_1.time_ - var_82_1) / var_82_2

				if arg_79_1.var_.characterEffect10131ui_story and not isNil(var_82_0) then
					arg_79_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_79_1.time_ >= var_82_1 + var_82_2 and arg_79_1.time_ < var_82_1 + var_82_2 + arg_82_0 and not isNil(var_82_0) and arg_79_1.var_.characterEffect10131ui_story then
				arg_79_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_82_4 = arg_79_1.actors_["1111ui_story"]
			local var_82_5 = 0

			if var_82_5 < arg_79_1.time_ and arg_79_1.time_ <= var_82_5 + arg_82_0 and not isNil(var_82_4) and arg_79_1.var_.characterEffect1111ui_story == nil then
				arg_79_1.var_.characterEffect1111ui_story = var_82_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_6 = 0.200000002980232

			if var_82_5 <= arg_79_1.time_ and arg_79_1.time_ < var_82_5 + var_82_6 and not isNil(var_82_4) then
				local var_82_7 = (arg_79_1.time_ - var_82_5) / var_82_6

				if arg_79_1.var_.characterEffect1111ui_story and not isNil(var_82_4) then
					local var_82_8 = Mathf.Lerp(0, 0.5, var_82_7)

					arg_79_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_79_1.var_.characterEffect1111ui_story.fillRatio = var_82_8
				end
			end

			if arg_79_1.time_ >= var_82_5 + var_82_6 and arg_79_1.time_ < var_82_5 + var_82_6 + arg_82_0 and not isNil(var_82_4) and arg_79_1.var_.characterEffect1111ui_story then
				local var_82_9 = 0.5

				arg_79_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_79_1.var_.characterEffect1111ui_story.fillRatio = var_82_9
			end

			local var_82_10 = 0

			if var_82_10 < arg_79_1.time_ and arg_79_1.time_ <= var_82_10 + arg_82_0 then
				arg_79_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action1_1")
			end

			local var_82_11 = 0

			if var_82_11 < arg_79_1.time_ and arg_79_1.time_ <= var_82_11 + arg_82_0 then
				arg_79_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_82_12 = 0
			local var_82_13 = 0.4

			if var_82_12 < arg_79_1.time_ and arg_79_1.time_ <= var_82_12 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				local var_82_14 = arg_79_1:FormatText(StoryNameCfg[1178].name)

				arg_79_1.leftNameTxt_.text = var_82_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_15 = arg_79_1:GetWordFromCfg(321371019)
				local var_82_16 = arg_79_1:FormatText(var_82_15.content)

				arg_79_1.text_.text = var_82_16

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_17 = 16
				local var_82_18 = utf8.len(var_82_16)
				local var_82_19 = var_82_17 <= 0 and var_82_13 or var_82_13 * (var_82_18 / var_82_17)

				if var_82_19 > 0 and var_82_13 < var_82_19 then
					arg_79_1.talkMaxDuration = var_82_19

					if var_82_19 + var_82_12 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_19 + var_82_12
					end
				end

				arg_79_1.text_.text = var_82_16
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371019", "story_v_out_321371.awb") ~= 0 then
					local var_82_20 = manager.audio:GetVoiceLength("story_v_out_321371", "321371019", "story_v_out_321371.awb") / 1000

					if var_82_20 + var_82_12 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_20 + var_82_12
					end

					if var_82_15.prefab_name ~= "" and arg_79_1.actors_[var_82_15.prefab_name] ~= nil then
						local var_82_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_15.prefab_name].transform, "story_v_out_321371", "321371019", "story_v_out_321371.awb")

						arg_79_1:RecordAudio("321371019", var_82_21)
						arg_79_1:RecordAudio("321371019", var_82_21)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_321371", "321371019", "story_v_out_321371.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_321371", "321371019", "story_v_out_321371.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_22 = math.max(var_82_13, arg_79_1.talkMaxDuration)

			if var_82_12 <= arg_79_1.time_ and arg_79_1.time_ < var_82_12 + var_82_22 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_12) / var_82_22

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_12 + var_82_22 and arg_79_1.time_ < var_82_12 + var_82_22 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play321371020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 321371020
		arg_83_1.duration_ = 6.83

		local var_83_0 = {
			zh = 6.833,
			ja = 6.133
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
				arg_83_0:Play321371021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = arg_83_1.actors_["1111ui_story"]
			local var_86_1 = 0

			if var_86_1 < arg_83_1.time_ and arg_83_1.time_ <= var_86_1 + arg_86_0 and not isNil(var_86_0) and arg_83_1.var_.characterEffect1111ui_story == nil then
				arg_83_1.var_.characterEffect1111ui_story = var_86_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_2 = 0.200000002980232

			if var_86_1 <= arg_83_1.time_ and arg_83_1.time_ < var_86_1 + var_86_2 and not isNil(var_86_0) then
				local var_86_3 = (arg_83_1.time_ - var_86_1) / var_86_2

				if arg_83_1.var_.characterEffect1111ui_story and not isNil(var_86_0) then
					arg_83_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_83_1.time_ >= var_86_1 + var_86_2 and arg_83_1.time_ < var_86_1 + var_86_2 + arg_86_0 and not isNil(var_86_0) and arg_83_1.var_.characterEffect1111ui_story then
				arg_83_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_86_4 = arg_83_1.actors_["10131ui_story"]
			local var_86_5 = 0

			if var_86_5 < arg_83_1.time_ and arg_83_1.time_ <= var_86_5 + arg_86_0 and not isNil(var_86_4) and arg_83_1.var_.characterEffect10131ui_story == nil then
				arg_83_1.var_.characterEffect10131ui_story = var_86_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_6 = 0.200000002980232

			if var_86_5 <= arg_83_1.time_ and arg_83_1.time_ < var_86_5 + var_86_6 and not isNil(var_86_4) then
				local var_86_7 = (arg_83_1.time_ - var_86_5) / var_86_6

				if arg_83_1.var_.characterEffect10131ui_story and not isNil(var_86_4) then
					local var_86_8 = Mathf.Lerp(0, 0.5, var_86_7)

					arg_83_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_83_1.var_.characterEffect10131ui_story.fillRatio = var_86_8
				end
			end

			if arg_83_1.time_ >= var_86_5 + var_86_6 and arg_83_1.time_ < var_86_5 + var_86_6 + arg_86_0 and not isNil(var_86_4) and arg_83_1.var_.characterEffect10131ui_story then
				local var_86_9 = 0.5

				arg_83_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_83_1.var_.characterEffect10131ui_story.fillRatio = var_86_9
			end

			local var_86_10 = 0

			if var_86_10 < arg_83_1.time_ and arg_83_1.time_ <= var_86_10 + arg_86_0 then
				arg_83_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action4_1")
			end

			local var_86_11 = 0

			if var_86_11 < arg_83_1.time_ and arg_83_1.time_ <= var_86_11 + arg_86_0 then
				arg_83_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_86_12 = 0
			local var_86_13 = 0.75

			if var_86_12 < arg_83_1.time_ and arg_83_1.time_ <= var_86_12 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				local var_86_14 = arg_83_1:FormatText(StoryNameCfg[67].name)

				arg_83_1.leftNameTxt_.text = var_86_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_15 = arg_83_1:GetWordFromCfg(321371020)
				local var_86_16 = arg_83_1:FormatText(var_86_15.content)

				arg_83_1.text_.text = var_86_16

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_17 = 30
				local var_86_18 = utf8.len(var_86_16)
				local var_86_19 = var_86_17 <= 0 and var_86_13 or var_86_13 * (var_86_18 / var_86_17)

				if var_86_19 > 0 and var_86_13 < var_86_19 then
					arg_83_1.talkMaxDuration = var_86_19

					if var_86_19 + var_86_12 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_19 + var_86_12
					end
				end

				arg_83_1.text_.text = var_86_16
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371020", "story_v_out_321371.awb") ~= 0 then
					local var_86_20 = manager.audio:GetVoiceLength("story_v_out_321371", "321371020", "story_v_out_321371.awb") / 1000

					if var_86_20 + var_86_12 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_20 + var_86_12
					end

					if var_86_15.prefab_name ~= "" and arg_83_1.actors_[var_86_15.prefab_name] ~= nil then
						local var_86_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_15.prefab_name].transform, "story_v_out_321371", "321371020", "story_v_out_321371.awb")

						arg_83_1:RecordAudio("321371020", var_86_21)
						arg_83_1:RecordAudio("321371020", var_86_21)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_321371", "321371020", "story_v_out_321371.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_321371", "321371020", "story_v_out_321371.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_22 = math.max(var_86_13, arg_83_1.talkMaxDuration)

			if var_86_12 <= arg_83_1.time_ and arg_83_1.time_ < var_86_12 + var_86_22 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_12) / var_86_22

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_12 + var_86_22 and arg_83_1.time_ < var_86_12 + var_86_22 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play321371021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 321371021
		arg_87_1.duration_ = 5

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play321371022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = arg_87_1.actors_["1111ui_story"].transform
			local var_90_1 = 0

			if var_90_1 < arg_87_1.time_ and arg_87_1.time_ <= var_90_1 + arg_90_0 then
				arg_87_1.var_.moveOldPos1111ui_story = var_90_0.localPosition
			end

			local var_90_2 = 0.001

			if var_90_1 <= arg_87_1.time_ and arg_87_1.time_ < var_90_1 + var_90_2 then
				local var_90_3 = (arg_87_1.time_ - var_90_1) / var_90_2
				local var_90_4 = Vector3.New(0, 100, 0)

				var_90_0.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos1111ui_story, var_90_4, var_90_3)

				local var_90_5 = manager.ui.mainCamera.transform.position - var_90_0.position

				var_90_0.forward = Vector3.New(var_90_5.x, var_90_5.y, var_90_5.z)

				local var_90_6 = var_90_0.localEulerAngles

				var_90_6.z = 0
				var_90_6.x = 0
				var_90_0.localEulerAngles = var_90_6
			end

			if arg_87_1.time_ >= var_90_1 + var_90_2 and arg_87_1.time_ < var_90_1 + var_90_2 + arg_90_0 then
				var_90_0.localPosition = Vector3.New(0, 100, 0)

				local var_90_7 = manager.ui.mainCamera.transform.position - var_90_0.position

				var_90_0.forward = Vector3.New(var_90_7.x, var_90_7.y, var_90_7.z)

				local var_90_8 = var_90_0.localEulerAngles

				var_90_8.z = 0
				var_90_8.x = 0
				var_90_0.localEulerAngles = var_90_8
			end

			local var_90_9 = arg_87_1.actors_["10131ui_story"].transform
			local var_90_10 = 0

			if var_90_10 < arg_87_1.time_ and arg_87_1.time_ <= var_90_10 + arg_90_0 then
				arg_87_1.var_.moveOldPos10131ui_story = var_90_9.localPosition
			end

			local var_90_11 = 0.001

			if var_90_10 <= arg_87_1.time_ and arg_87_1.time_ < var_90_10 + var_90_11 then
				local var_90_12 = (arg_87_1.time_ - var_90_10) / var_90_11
				local var_90_13 = Vector3.New(0, 100, 0)

				var_90_9.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos10131ui_story, var_90_13, var_90_12)

				local var_90_14 = manager.ui.mainCamera.transform.position - var_90_9.position

				var_90_9.forward = Vector3.New(var_90_14.x, var_90_14.y, var_90_14.z)

				local var_90_15 = var_90_9.localEulerAngles

				var_90_15.z = 0
				var_90_15.x = 0
				var_90_9.localEulerAngles = var_90_15
			end

			if arg_87_1.time_ >= var_90_10 + var_90_11 and arg_87_1.time_ < var_90_10 + var_90_11 + arg_90_0 then
				var_90_9.localPosition = Vector3.New(0, 100, 0)

				local var_90_16 = manager.ui.mainCamera.transform.position - var_90_9.position

				var_90_9.forward = Vector3.New(var_90_16.x, var_90_16.y, var_90_16.z)

				local var_90_17 = var_90_9.localEulerAngles

				var_90_17.z = 0
				var_90_17.x = 0
				var_90_9.localEulerAngles = var_90_17
			end

			local var_90_18 = arg_87_1.actors_["1111ui_story"]
			local var_90_19 = 0

			if var_90_19 < arg_87_1.time_ and arg_87_1.time_ <= var_90_19 + arg_90_0 and not isNil(var_90_18) and arg_87_1.var_.characterEffect1111ui_story == nil then
				arg_87_1.var_.characterEffect1111ui_story = var_90_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_20 = 0.200000002980232

			if var_90_19 <= arg_87_1.time_ and arg_87_1.time_ < var_90_19 + var_90_20 and not isNil(var_90_18) then
				local var_90_21 = (arg_87_1.time_ - var_90_19) / var_90_20

				if arg_87_1.var_.characterEffect1111ui_story and not isNil(var_90_18) then
					local var_90_22 = Mathf.Lerp(0, 0.5, var_90_21)

					arg_87_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_87_1.var_.characterEffect1111ui_story.fillRatio = var_90_22
				end
			end

			if arg_87_1.time_ >= var_90_19 + var_90_20 and arg_87_1.time_ < var_90_19 + var_90_20 + arg_90_0 and not isNil(var_90_18) and arg_87_1.var_.characterEffect1111ui_story then
				local var_90_23 = 0.5

				arg_87_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_87_1.var_.characterEffect1111ui_story.fillRatio = var_90_23
			end

			local var_90_24 = 0
			local var_90_25 = 0.925

			if var_90_24 < arg_87_1.time_ and arg_87_1.time_ <= var_90_24 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, false)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_26 = arg_87_1:GetWordFromCfg(321371021)
				local var_90_27 = arg_87_1:FormatText(var_90_26.content)

				arg_87_1.text_.text = var_90_27

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_28 = 37
				local var_90_29 = utf8.len(var_90_27)
				local var_90_30 = var_90_28 <= 0 and var_90_25 or var_90_25 * (var_90_29 / var_90_28)

				if var_90_30 > 0 and var_90_25 < var_90_30 then
					arg_87_1.talkMaxDuration = var_90_30

					if var_90_30 + var_90_24 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_30 + var_90_24
					end
				end

				arg_87_1.text_.text = var_90_27
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)
				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_31 = math.max(var_90_25, arg_87_1.talkMaxDuration)

			if var_90_24 <= arg_87_1.time_ and arg_87_1.time_ < var_90_24 + var_90_31 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_24) / var_90_31

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_24 + var_90_31 and arg_87_1.time_ < var_90_24 + var_90_31 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10131ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_87_1:InitPlayNodeList()
	end,
	Play321371022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 321371022
		arg_91_1.duration_ = 5

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play321371023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = 0.05
			local var_94_1 = 1

			if var_94_0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_0 + arg_94_0 then
				local var_94_2 = "play"
				local var_94_3 = "effect"

				arg_91_1:AudioAction(var_94_2, var_94_3, "se_story_141", "se_story_141_sword_aim", "")
			end

			local var_94_4 = 0
			local var_94_5 = 1.025

			if var_94_4 < arg_91_1.time_ and arg_91_1.time_ <= var_94_4 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, false)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_6 = arg_91_1:GetWordFromCfg(321371022)
				local var_94_7 = arg_91_1:FormatText(var_94_6.content)

				arg_91_1.text_.text = var_94_7

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_8 = 41
				local var_94_9 = utf8.len(var_94_7)
				local var_94_10 = var_94_8 <= 0 and var_94_5 or var_94_5 * (var_94_9 / var_94_8)

				if var_94_10 > 0 and var_94_5 < var_94_10 then
					arg_91_1.talkMaxDuration = var_94_10

					if var_94_10 + var_94_4 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_10 + var_94_4
					end
				end

				arg_91_1.text_.text = var_94_7
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)
				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_11 = math.max(var_94_5, arg_91_1.talkMaxDuration)

			if var_94_4 <= arg_91_1.time_ and arg_91_1.time_ < var_94_4 + var_94_11 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_4) / var_94_11

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_4 + var_94_11 and arg_91_1.time_ < var_94_4 + var_94_11 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play321371023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 321371023
		arg_95_1.duration_ = 5.3

		local var_95_0 = {
			zh = 5,
			ja = 5.3
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
				arg_95_0:Play321371024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = arg_95_1.actors_["1111ui_story"].transform
			local var_98_1 = 0

			if var_98_1 < arg_95_1.time_ and arg_95_1.time_ <= var_98_1 + arg_98_0 then
				arg_95_1.var_.moveOldPos1111ui_story = var_98_0.localPosition
			end

			local var_98_2 = 0.001

			if var_98_1 <= arg_95_1.time_ and arg_95_1.time_ < var_98_1 + var_98_2 then
				local var_98_3 = (arg_95_1.time_ - var_98_1) / var_98_2
				local var_98_4 = Vector3.New(0, -0.87, -5.7)

				var_98_0.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos1111ui_story, var_98_4, var_98_3)

				local var_98_5 = manager.ui.mainCamera.transform.position - var_98_0.position

				var_98_0.forward = Vector3.New(var_98_5.x, var_98_5.y, var_98_5.z)

				local var_98_6 = var_98_0.localEulerAngles

				var_98_6.z = 0
				var_98_6.x = 0
				var_98_0.localEulerAngles = var_98_6
			end

			if arg_95_1.time_ >= var_98_1 + var_98_2 and arg_95_1.time_ < var_98_1 + var_98_2 + arg_98_0 then
				var_98_0.localPosition = Vector3.New(0, -0.87, -5.7)

				local var_98_7 = manager.ui.mainCamera.transform.position - var_98_0.position

				var_98_0.forward = Vector3.New(var_98_7.x, var_98_7.y, var_98_7.z)

				local var_98_8 = var_98_0.localEulerAngles

				var_98_8.z = 0
				var_98_8.x = 0
				var_98_0.localEulerAngles = var_98_8
			end

			local var_98_9 = arg_95_1.actors_["1111ui_story"]
			local var_98_10 = 0

			if var_98_10 < arg_95_1.time_ and arg_95_1.time_ <= var_98_10 + arg_98_0 and not isNil(var_98_9) and arg_95_1.var_.characterEffect1111ui_story == nil then
				arg_95_1.var_.characterEffect1111ui_story = var_98_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_11 = 0.200000002980232

			if var_98_10 <= arg_95_1.time_ and arg_95_1.time_ < var_98_10 + var_98_11 and not isNil(var_98_9) then
				local var_98_12 = (arg_95_1.time_ - var_98_10) / var_98_11

				if arg_95_1.var_.characterEffect1111ui_story and not isNil(var_98_9) then
					arg_95_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_95_1.time_ >= var_98_10 + var_98_11 and arg_95_1.time_ < var_98_10 + var_98_11 + arg_98_0 and not isNil(var_98_9) and arg_95_1.var_.characterEffect1111ui_story then
				arg_95_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_98_13 = 0

			if var_98_13 < arg_95_1.time_ and arg_95_1.time_ <= var_98_13 + arg_98_0 then
				arg_95_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action1_1")
			end

			local var_98_14 = 0

			if var_98_14 < arg_95_1.time_ and arg_95_1.time_ <= var_98_14 + arg_98_0 then
				arg_95_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_98_15 = 0
			local var_98_16 = 0.55

			if var_98_15 < arg_95_1.time_ and arg_95_1.time_ <= var_98_15 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				local var_98_17 = arg_95_1:FormatText(StoryNameCfg[67].name)

				arg_95_1.leftNameTxt_.text = var_98_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_18 = arg_95_1:GetWordFromCfg(321371023)
				local var_98_19 = arg_95_1:FormatText(var_98_18.content)

				arg_95_1.text_.text = var_98_19

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_20 = 22
				local var_98_21 = utf8.len(var_98_19)
				local var_98_22 = var_98_20 <= 0 and var_98_16 or var_98_16 * (var_98_21 / var_98_20)

				if var_98_22 > 0 and var_98_16 < var_98_22 then
					arg_95_1.talkMaxDuration = var_98_22

					if var_98_22 + var_98_15 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_22 + var_98_15
					end
				end

				arg_95_1.text_.text = var_98_19
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371023", "story_v_out_321371.awb") ~= 0 then
					local var_98_23 = manager.audio:GetVoiceLength("story_v_out_321371", "321371023", "story_v_out_321371.awb") / 1000

					if var_98_23 + var_98_15 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_23 + var_98_15
					end

					if var_98_18.prefab_name ~= "" and arg_95_1.actors_[var_98_18.prefab_name] ~= nil then
						local var_98_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_18.prefab_name].transform, "story_v_out_321371", "321371023", "story_v_out_321371.awb")

						arg_95_1:RecordAudio("321371023", var_98_24)
						arg_95_1:RecordAudio("321371023", var_98_24)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_321371", "321371023", "story_v_out_321371.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_321371", "321371023", "story_v_out_321371.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_25 = math.max(var_98_16, arg_95_1.talkMaxDuration)

			if var_98_15 <= arg_95_1.time_ and arg_95_1.time_ < var_98_15 + var_98_25 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_15) / var_98_25

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_15 + var_98_25 and arg_95_1.time_ < var_98_15 + var_98_25 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_95_1:InitPlayNodeList()
	end,
	Play321371024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 321371024
		arg_99_1.duration_ = 5

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play321371025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = arg_99_1.actors_["1111ui_story"].transform
			local var_102_1 = 0

			if var_102_1 < arg_99_1.time_ and arg_99_1.time_ <= var_102_1 + arg_102_0 then
				arg_99_1.var_.moveOldPos1111ui_story = var_102_0.localPosition
			end

			local var_102_2 = 0.001

			if var_102_1 <= arg_99_1.time_ and arg_99_1.time_ < var_102_1 + var_102_2 then
				local var_102_3 = (arg_99_1.time_ - var_102_1) / var_102_2
				local var_102_4 = Vector3.New(0, 100, 0)

				var_102_0.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos1111ui_story, var_102_4, var_102_3)

				local var_102_5 = manager.ui.mainCamera.transform.position - var_102_0.position

				var_102_0.forward = Vector3.New(var_102_5.x, var_102_5.y, var_102_5.z)

				local var_102_6 = var_102_0.localEulerAngles

				var_102_6.z = 0
				var_102_6.x = 0
				var_102_0.localEulerAngles = var_102_6
			end

			if arg_99_1.time_ >= var_102_1 + var_102_2 and arg_99_1.time_ < var_102_1 + var_102_2 + arg_102_0 then
				var_102_0.localPosition = Vector3.New(0, 100, 0)

				local var_102_7 = manager.ui.mainCamera.transform.position - var_102_0.position

				var_102_0.forward = Vector3.New(var_102_7.x, var_102_7.y, var_102_7.z)

				local var_102_8 = var_102_0.localEulerAngles

				var_102_8.z = 0
				var_102_8.x = 0
				var_102_0.localEulerAngles = var_102_8
			end

			local var_102_9 = arg_99_1.actors_["1111ui_story"]
			local var_102_10 = 0

			if var_102_10 < arg_99_1.time_ and arg_99_1.time_ <= var_102_10 + arg_102_0 and not isNil(var_102_9) and arg_99_1.var_.characterEffect1111ui_story == nil then
				arg_99_1.var_.characterEffect1111ui_story = var_102_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_11 = 0.200000002980232

			if var_102_10 <= arg_99_1.time_ and arg_99_1.time_ < var_102_10 + var_102_11 and not isNil(var_102_9) then
				local var_102_12 = (arg_99_1.time_ - var_102_10) / var_102_11

				if arg_99_1.var_.characterEffect1111ui_story and not isNil(var_102_9) then
					local var_102_13 = Mathf.Lerp(0, 0.5, var_102_12)

					arg_99_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_99_1.var_.characterEffect1111ui_story.fillRatio = var_102_13
				end
			end

			if arg_99_1.time_ >= var_102_10 + var_102_11 and arg_99_1.time_ < var_102_10 + var_102_11 + arg_102_0 and not isNil(var_102_9) and arg_99_1.var_.characterEffect1111ui_story then
				local var_102_14 = 0.5

				arg_99_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_99_1.var_.characterEffect1111ui_story.fillRatio = var_102_14
			end

			local var_102_15 = 0
			local var_102_16 = 0.775

			if var_102_15 < arg_99_1.time_ and arg_99_1.time_ <= var_102_15 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, false)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_17 = arg_99_1:GetWordFromCfg(321371024)
				local var_102_18 = arg_99_1:FormatText(var_102_17.content)

				arg_99_1.text_.text = var_102_18

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_19 = 31
				local var_102_20 = utf8.len(var_102_18)
				local var_102_21 = var_102_19 <= 0 and var_102_16 or var_102_16 * (var_102_20 / var_102_19)

				if var_102_21 > 0 and var_102_16 < var_102_21 then
					arg_99_1.talkMaxDuration = var_102_21

					if var_102_21 + var_102_15 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_21 + var_102_15
					end
				end

				arg_99_1.text_.text = var_102_18
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)
				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_22 = math.max(var_102_16, arg_99_1.talkMaxDuration)

			if var_102_15 <= arg_99_1.time_ and arg_99_1.time_ < var_102_15 + var_102_22 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_15) / var_102_22

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_15 + var_102_22 and arg_99_1.time_ < var_102_15 + var_102_22 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_99_1:InitPlayNodeList()
	end,
	Play321371025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 321371025
		arg_103_1.duration_ = 7.87

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play321371026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = 0

			if var_106_0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_0 + arg_106_0 then
				arg_103_1.mask_.enabled = true
				arg_103_1.mask_.raycastTarget = true

				arg_103_1:SetGaussion(false)
			end

			local var_106_1 = 1.4

			if var_106_0 <= arg_103_1.time_ and arg_103_1.time_ < var_106_0 + var_106_1 then
				local var_106_2 = (arg_103_1.time_ - var_106_0) / var_106_1
				local var_106_3 = Color.New(1, 1, 1)

				var_106_3.a = Mathf.Lerp(0, 1, var_106_2)
				arg_103_1.mask_.color = var_106_3
			end

			if arg_103_1.time_ >= var_106_0 + var_106_1 and arg_103_1.time_ < var_106_0 + var_106_1 + arg_106_0 then
				local var_106_4 = Color.New(1, 1, 1)

				var_106_4.a = 1
				arg_103_1.mask_.color = var_106_4
			end

			local var_106_5 = 1.4

			if var_106_5 < arg_103_1.time_ and arg_103_1.time_ <= var_106_5 + arg_106_0 then
				arg_103_1.mask_.enabled = true
				arg_103_1.mask_.raycastTarget = true

				arg_103_1:SetGaussion(false)
			end

			local var_106_6 = 1.6

			if var_106_5 <= arg_103_1.time_ and arg_103_1.time_ < var_106_5 + var_106_6 then
				local var_106_7 = (arg_103_1.time_ - var_106_5) / var_106_6
				local var_106_8 = Color.New(1, 1, 1)

				var_106_8.a = Mathf.Lerp(1, 0, var_106_7)
				arg_103_1.mask_.color = var_106_8
			end

			if arg_103_1.time_ >= var_106_5 + var_106_6 and arg_103_1.time_ < var_106_5 + var_106_6 + arg_106_0 then
				local var_106_9 = Color.New(1, 1, 1)
				local var_106_10 = 0

				arg_103_1.mask_.enabled = false
				var_106_9.a = var_106_10
				arg_103_1.mask_.color = var_106_9
			end

			local var_106_11 = manager.ui.mainCamera.transform
			local var_106_12 = 1.4

			if var_106_12 < arg_103_1.time_ and arg_103_1.time_ <= var_106_12 + arg_106_0 then
				local var_106_13 = arg_103_1.var_.effectsuipian1
				local var_106_14
				local var_106_15 = var_106_11

				if not var_106_13 then
					var_106_13 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_xishan"), var_106_15)
					var_106_13.name = "suipian1"
					arg_103_1.var_.effectsuipian1 = var_106_13
				else
					var_106_13.transform:SetParent(var_106_15)
				end

				var_106_13.transform.localPosition = Vector3.New(0, 0, -10)
				var_106_13.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_106_16 = arg_103_1.bgs_.L09g.transform
			local var_106_17 = 1.4

			if var_106_17 < arg_103_1.time_ and arg_103_1.time_ <= var_106_17 + arg_106_0 then
				arg_103_1.var_.moveOldPosL09g = var_106_16.localPosition
			end

			local var_106_18 = 0.001

			if var_106_17 <= arg_103_1.time_ and arg_103_1.time_ < var_106_17 + var_106_18 then
				local var_106_19 = (arg_103_1.time_ - var_106_17) / var_106_18
				local var_106_20 = Vector3.New(0, 1, 10)

				var_106_16.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPosL09g, var_106_20, var_106_19)
			end

			if arg_103_1.time_ >= var_106_17 + var_106_18 and arg_103_1.time_ < var_106_17 + var_106_18 + arg_106_0 then
				var_106_16.localPosition = Vector3.New(0, 1, 10)
			end

			local var_106_21 = arg_103_1.bgs_.L09g.transform
			local var_106_22 = 1.434

			if var_106_22 < arg_103_1.time_ and arg_103_1.time_ <= var_106_22 + arg_106_0 then
				arg_103_1.var_.moveOldPosL09g = var_106_21.localPosition
			end

			local var_106_23 = 2.13266666666667

			if var_106_22 <= arg_103_1.time_ and arg_103_1.time_ < var_106_22 + var_106_23 then
				local var_106_24 = (arg_103_1.time_ - var_106_22) / var_106_23
				local var_106_25 = Vector3.New(0, 1, 9.5)

				var_106_21.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPosL09g, var_106_25, var_106_24)
			end

			if arg_103_1.time_ >= var_106_22 + var_106_23 and arg_103_1.time_ < var_106_22 + var_106_23 + arg_106_0 then
				var_106_21.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_106_26 = 1.36733333333333

			if var_106_26 < arg_103_1.time_ and arg_103_1.time_ <= var_106_26 + arg_106_0 then
				local var_106_27 = manager.ui.mainCamera.transform.localPosition
				local var_106_28 = Vector3.New(0, 0, 10) + Vector3.New(var_106_27.x, var_106_27.y, 0)
				local var_106_29 = arg_103_1.bgs_.L09g

				var_106_29.transform.localPosition = var_106_28
				var_106_29.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_106_30 = var_106_29:GetComponent("SpriteRenderer")

				if var_106_30 and var_106_30.sprite then
					local var_106_31 = (var_106_29.transform.localPosition - var_106_27).z
					local var_106_32 = manager.ui.mainCameraCom_
					local var_106_33 = 2 * var_106_31 * Mathf.Tan(var_106_32.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_106_34 = var_106_33 * var_106_32.aspect
					local var_106_35 = var_106_30.sprite.bounds.size.x
					local var_106_36 = var_106_30.sprite.bounds.size.y
					local var_106_37 = var_106_34 / var_106_35
					local var_106_38 = var_106_33 / var_106_36
					local var_106_39 = var_106_38 < var_106_37 and var_106_37 or var_106_38

					var_106_29.transform.localScale = Vector3.New(var_106_39, var_106_39, 0)
				end

				for iter_106_0, iter_106_1 in pairs(arg_103_1.bgs_) do
					if iter_106_0 ~= "L09g" then
						iter_106_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_106_40 = 2.7

			if var_106_40 < arg_103_1.time_ and arg_103_1.time_ <= var_106_40 + arg_106_0 then
				arg_103_1.allBtn_.enabled = false
			end

			local var_106_41 = 0.933333333333333

			if arg_103_1.time_ >= var_106_40 + var_106_41 and arg_103_1.time_ < var_106_40 + var_106_41 + arg_106_0 then
				arg_103_1.allBtn_.enabled = true
			end

			local var_106_42 = 0
			local var_106_43 = 1

			if var_106_42 < arg_103_1.time_ and arg_103_1.time_ <= var_106_42 + arg_106_0 then
				local var_106_44 = "play"
				local var_106_45 = "effect"

				arg_103_1:AudioAction(var_106_44, var_106_45, "se_story_140", "se_story_140_reaction", "")
			end

			if arg_103_1.frameCnt_ <= 1 then
				arg_103_1.dialog_:SetActive(false)
			end

			local var_106_46 = 2.86666666666667
			local var_106_47 = 1.2

			if var_106_46 < arg_103_1.time_ and arg_103_1.time_ <= var_106_46 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0

				arg_103_1.dialog_:SetActive(true)

				arg_103_1.dialogCg_.alpha = 0

				local var_106_48 = LeanTween.value(arg_103_1.dialog_, 0, 1, 0.3)

				var_106_48:setOnUpdate(LuaHelper.FloatAction(function(arg_107_0)
					arg_103_1.dialogCg_.alpha = arg_107_0
				end))
				var_106_48:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_103_1.dialog_)
					var_106_48:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_103_1.duration_ = arg_103_1.duration_ + 0.3

				SetActive(arg_103_1.leftNameGo_, false)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_49 = arg_103_1:GetWordFromCfg(321371025)
				local var_106_50 = arg_103_1:FormatText(var_106_49.content)

				arg_103_1.text_.text = var_106_50

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_51 = 48
				local var_106_52 = utf8.len(var_106_50)
				local var_106_53 = var_106_51 <= 0 and var_106_47 or var_106_47 * (var_106_52 / var_106_51)

				if var_106_53 > 0 and var_106_47 < var_106_53 then
					arg_103_1.talkMaxDuration = var_106_53
					var_106_46 = var_106_46 + 0.3

					if var_106_53 + var_106_46 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_53 + var_106_46
					end
				end

				arg_103_1.text_.text = var_106_50
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)
				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_54 = var_106_46 + 0.3
			local var_106_55 = math.max(var_106_47, arg_103_1.talkMaxDuration)

			if var_106_54 <= arg_103_1.time_ and arg_103_1.time_ < var_106_54 + var_106_55 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_54) / var_106_55

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_54 + var_106_55 and arg_103_1.time_ < var_106_54 + var_106_55 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "L09g",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "L09g",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2.13266666666667,
				className = "StoryMoveNode",
				startTime = 1.434,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_103_1:InitPlayNodeList()
	end,
	Play321371026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 321371026
		arg_109_1.duration_ = 1.7

		local var_109_0 = {
			zh = 1.466,
			ja = 1.7
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
				arg_109_0:Play321371027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = arg_109_1.actors_["1111ui_story"].transform
			local var_112_1 = 0

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 then
				arg_109_1.var_.moveOldPos1111ui_story = var_112_0.localPosition
			end

			local var_112_2 = 0.001

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_2 then
				local var_112_3 = (arg_109_1.time_ - var_112_1) / var_112_2
				local var_112_4 = Vector3.New(-0.79, -0.87, -5.7)

				var_112_0.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1111ui_story, var_112_4, var_112_3)

				local var_112_5 = manager.ui.mainCamera.transform.position - var_112_0.position

				var_112_0.forward = Vector3.New(var_112_5.x, var_112_5.y, var_112_5.z)

				local var_112_6 = var_112_0.localEulerAngles

				var_112_6.z = 0
				var_112_6.x = 0
				var_112_0.localEulerAngles = var_112_6
			end

			if arg_109_1.time_ >= var_112_1 + var_112_2 and arg_109_1.time_ < var_112_1 + var_112_2 + arg_112_0 then
				var_112_0.localPosition = Vector3.New(-0.79, -0.87, -5.7)

				local var_112_7 = manager.ui.mainCamera.transform.position - var_112_0.position

				var_112_0.forward = Vector3.New(var_112_7.x, var_112_7.y, var_112_7.z)

				local var_112_8 = var_112_0.localEulerAngles

				var_112_8.z = 0
				var_112_8.x = 0
				var_112_0.localEulerAngles = var_112_8
			end

			local var_112_9 = arg_109_1.actors_["1111ui_story"]
			local var_112_10 = 0

			if var_112_10 < arg_109_1.time_ and arg_109_1.time_ <= var_112_10 + arg_112_0 and not isNil(var_112_9) and arg_109_1.var_.characterEffect1111ui_story == nil then
				arg_109_1.var_.characterEffect1111ui_story = var_112_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_11 = 0.200000002980232

			if var_112_10 <= arg_109_1.time_ and arg_109_1.time_ < var_112_10 + var_112_11 and not isNil(var_112_9) then
				local var_112_12 = (arg_109_1.time_ - var_112_10) / var_112_11

				if arg_109_1.var_.characterEffect1111ui_story and not isNil(var_112_9) then
					arg_109_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= var_112_10 + var_112_11 and arg_109_1.time_ < var_112_10 + var_112_11 + arg_112_0 and not isNil(var_112_9) and arg_109_1.var_.characterEffect1111ui_story then
				arg_109_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_112_13 = 0

			if var_112_13 < arg_109_1.time_ and arg_109_1.time_ <= var_112_13 + arg_112_0 then
				arg_109_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action1_1")
			end

			local var_112_14 = 0

			if var_112_14 < arg_109_1.time_ and arg_109_1.time_ <= var_112_14 + arg_112_0 then
				arg_109_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_112_15 = 0
			local var_112_16 = 0.15

			if var_112_15 < arg_109_1.time_ and arg_109_1.time_ <= var_112_15 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_17 = arg_109_1:FormatText(StoryNameCfg[67].name)

				arg_109_1.leftNameTxt_.text = var_112_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_18 = arg_109_1:GetWordFromCfg(321371026)
				local var_112_19 = arg_109_1:FormatText(var_112_18.content)

				arg_109_1.text_.text = var_112_19

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_20 = 6
				local var_112_21 = utf8.len(var_112_19)
				local var_112_22 = var_112_20 <= 0 and var_112_16 or var_112_16 * (var_112_21 / var_112_20)

				if var_112_22 > 0 and var_112_16 < var_112_22 then
					arg_109_1.talkMaxDuration = var_112_22

					if var_112_22 + var_112_15 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_22 + var_112_15
					end
				end

				arg_109_1.text_.text = var_112_19
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371026", "story_v_out_321371.awb") ~= 0 then
					local var_112_23 = manager.audio:GetVoiceLength("story_v_out_321371", "321371026", "story_v_out_321371.awb") / 1000

					if var_112_23 + var_112_15 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_23 + var_112_15
					end

					if var_112_18.prefab_name ~= "" and arg_109_1.actors_[var_112_18.prefab_name] ~= nil then
						local var_112_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_18.prefab_name].transform, "story_v_out_321371", "321371026", "story_v_out_321371.awb")

						arg_109_1:RecordAudio("321371026", var_112_24)
						arg_109_1:RecordAudio("321371026", var_112_24)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_321371", "321371026", "story_v_out_321371.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_321371", "321371026", "story_v_out_321371.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_25 = math.max(var_112_16, arg_109_1.talkMaxDuration)

			if var_112_15 <= arg_109_1.time_ and arg_109_1.time_ < var_112_15 + var_112_25 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_15) / var_112_25

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_15 + var_112_25 and arg_109_1.time_ < var_112_15 + var_112_25 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
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
	Play321371027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 321371027
		arg_113_1.duration_ = 7.07

		local var_113_0 = {
			zh = 7.066,
			ja = 6.6
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
				arg_113_0:Play321371028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = arg_113_1.actors_["10131ui_story"].transform
			local var_116_1 = 0

			if var_116_1 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 then
				arg_113_1.var_.moveOldPos10131ui_story = var_116_0.localPosition
			end

			local var_116_2 = 0.001

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_2 then
				local var_116_3 = (arg_113_1.time_ - var_116_1) / var_116_2
				local var_116_4 = Vector3.New(0.83, -0.96, -5.8)

				var_116_0.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos10131ui_story, var_116_4, var_116_3)

				local var_116_5 = manager.ui.mainCamera.transform.position - var_116_0.position

				var_116_0.forward = Vector3.New(var_116_5.x, var_116_5.y, var_116_5.z)

				local var_116_6 = var_116_0.localEulerAngles

				var_116_6.z = 0
				var_116_6.x = 0
				var_116_0.localEulerAngles = var_116_6
			end

			if arg_113_1.time_ >= var_116_1 + var_116_2 and arg_113_1.time_ < var_116_1 + var_116_2 + arg_116_0 then
				var_116_0.localPosition = Vector3.New(0.83, -0.96, -5.8)

				local var_116_7 = manager.ui.mainCamera.transform.position - var_116_0.position

				var_116_0.forward = Vector3.New(var_116_7.x, var_116_7.y, var_116_7.z)

				local var_116_8 = var_116_0.localEulerAngles

				var_116_8.z = 0
				var_116_8.x = 0
				var_116_0.localEulerAngles = var_116_8
			end

			local var_116_9 = arg_113_1.actors_["10131ui_story"]
			local var_116_10 = 0

			if var_116_10 < arg_113_1.time_ and arg_113_1.time_ <= var_116_10 + arg_116_0 and not isNil(var_116_9) and arg_113_1.var_.characterEffect10131ui_story == nil then
				arg_113_1.var_.characterEffect10131ui_story = var_116_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_11 = 0.200000002980232

			if var_116_10 <= arg_113_1.time_ and arg_113_1.time_ < var_116_10 + var_116_11 and not isNil(var_116_9) then
				local var_116_12 = (arg_113_1.time_ - var_116_10) / var_116_11

				if arg_113_1.var_.characterEffect10131ui_story and not isNil(var_116_9) then
					arg_113_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= var_116_10 + var_116_11 and arg_113_1.time_ < var_116_10 + var_116_11 + arg_116_0 and not isNil(var_116_9) and arg_113_1.var_.characterEffect10131ui_story then
				arg_113_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_116_13 = arg_113_1.actors_["1111ui_story"]
			local var_116_14 = 0

			if var_116_14 < arg_113_1.time_ and arg_113_1.time_ <= var_116_14 + arg_116_0 and not isNil(var_116_13) and arg_113_1.var_.characterEffect1111ui_story == nil then
				arg_113_1.var_.characterEffect1111ui_story = var_116_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_15 = 0.200000002980232

			if var_116_14 <= arg_113_1.time_ and arg_113_1.time_ < var_116_14 + var_116_15 and not isNil(var_116_13) then
				local var_116_16 = (arg_113_1.time_ - var_116_14) / var_116_15

				if arg_113_1.var_.characterEffect1111ui_story and not isNil(var_116_13) then
					local var_116_17 = Mathf.Lerp(0, 0.5, var_116_16)

					arg_113_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_113_1.var_.characterEffect1111ui_story.fillRatio = var_116_17
				end
			end

			if arg_113_1.time_ >= var_116_14 + var_116_15 and arg_113_1.time_ < var_116_14 + var_116_15 + arg_116_0 and not isNil(var_116_13) and arg_113_1.var_.characterEffect1111ui_story then
				local var_116_18 = 0.5

				arg_113_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_113_1.var_.characterEffect1111ui_story.fillRatio = var_116_18
			end

			local var_116_19 = 0

			if var_116_19 < arg_113_1.time_ and arg_113_1.time_ <= var_116_19 + arg_116_0 then
				arg_113_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action1_1")
			end

			local var_116_20 = 0

			if var_116_20 < arg_113_1.time_ and arg_113_1.time_ <= var_116_20 + arg_116_0 then
				arg_113_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_116_21 = 0
			local var_116_22 = 0.7

			if var_116_21 < arg_113_1.time_ and arg_113_1.time_ <= var_116_21 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_23 = arg_113_1:FormatText(StoryNameCfg[1178].name)

				arg_113_1.leftNameTxt_.text = var_116_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_24 = arg_113_1:GetWordFromCfg(321371027)
				local var_116_25 = arg_113_1:FormatText(var_116_24.content)

				arg_113_1.text_.text = var_116_25

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_26 = 28
				local var_116_27 = utf8.len(var_116_25)
				local var_116_28 = var_116_26 <= 0 and var_116_22 or var_116_22 * (var_116_27 / var_116_26)

				if var_116_28 > 0 and var_116_22 < var_116_28 then
					arg_113_1.talkMaxDuration = var_116_28

					if var_116_28 + var_116_21 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_28 + var_116_21
					end
				end

				arg_113_1.text_.text = var_116_25
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371027", "story_v_out_321371.awb") ~= 0 then
					local var_116_29 = manager.audio:GetVoiceLength("story_v_out_321371", "321371027", "story_v_out_321371.awb") / 1000

					if var_116_29 + var_116_21 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_29 + var_116_21
					end

					if var_116_24.prefab_name ~= "" and arg_113_1.actors_[var_116_24.prefab_name] ~= nil then
						local var_116_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_24.prefab_name].transform, "story_v_out_321371", "321371027", "story_v_out_321371.awb")

						arg_113_1:RecordAudio("321371027", var_116_30)
						arg_113_1:RecordAudio("321371027", var_116_30)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_321371", "321371027", "story_v_out_321371.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_321371", "321371027", "story_v_out_321371.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_31 = math.max(var_116_22, arg_113_1.talkMaxDuration)

			if var_116_21 <= arg_113_1.time_ and arg_113_1.time_ < var_116_21 + var_116_31 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_21) / var_116_31

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_21 + var_116_31 and arg_113_1.time_ < var_116_21 + var_116_31 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10131ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_113_1:InitPlayNodeList()
	end,
	Play321371028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 321371028
		arg_117_1.duration_ = 2.5

		local var_117_0 = {
			zh = 2.3,
			ja = 2.5
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
				arg_117_0:Play321371029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = arg_117_1.actors_["1111ui_story"].transform
			local var_120_1 = 0

			if var_120_1 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 then
				arg_117_1.var_.moveOldPos1111ui_story = var_120_0.localPosition
			end

			local var_120_2 = 0.001

			if var_120_1 <= arg_117_1.time_ and arg_117_1.time_ < var_120_1 + var_120_2 then
				local var_120_3 = (arg_117_1.time_ - var_120_1) / var_120_2
				local var_120_4 = Vector3.New(-0.79, -0.87, -5.7)

				var_120_0.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos1111ui_story, var_120_4, var_120_3)

				local var_120_5 = manager.ui.mainCamera.transform.position - var_120_0.position

				var_120_0.forward = Vector3.New(var_120_5.x, var_120_5.y, var_120_5.z)

				local var_120_6 = var_120_0.localEulerAngles

				var_120_6.z = 0
				var_120_6.x = 0
				var_120_0.localEulerAngles = var_120_6
			end

			if arg_117_1.time_ >= var_120_1 + var_120_2 and arg_117_1.time_ < var_120_1 + var_120_2 + arg_120_0 then
				var_120_0.localPosition = Vector3.New(-0.79, -0.87, -5.7)

				local var_120_7 = manager.ui.mainCamera.transform.position - var_120_0.position

				var_120_0.forward = Vector3.New(var_120_7.x, var_120_7.y, var_120_7.z)

				local var_120_8 = var_120_0.localEulerAngles

				var_120_8.z = 0
				var_120_8.x = 0
				var_120_0.localEulerAngles = var_120_8
			end

			local var_120_9 = arg_117_1.actors_["1111ui_story"]
			local var_120_10 = 0

			if var_120_10 < arg_117_1.time_ and arg_117_1.time_ <= var_120_10 + arg_120_0 and not isNil(var_120_9) and arg_117_1.var_.characterEffect1111ui_story == nil then
				arg_117_1.var_.characterEffect1111ui_story = var_120_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_11 = 0.200000002980232

			if var_120_10 <= arg_117_1.time_ and arg_117_1.time_ < var_120_10 + var_120_11 and not isNil(var_120_9) then
				local var_120_12 = (arg_117_1.time_ - var_120_10) / var_120_11

				if arg_117_1.var_.characterEffect1111ui_story and not isNil(var_120_9) then
					arg_117_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_117_1.time_ >= var_120_10 + var_120_11 and arg_117_1.time_ < var_120_10 + var_120_11 + arg_120_0 and not isNil(var_120_9) and arg_117_1.var_.characterEffect1111ui_story then
				arg_117_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_120_13 = arg_117_1.actors_["10131ui_story"]
			local var_120_14 = 0

			if var_120_14 < arg_117_1.time_ and arg_117_1.time_ <= var_120_14 + arg_120_0 and not isNil(var_120_13) and arg_117_1.var_.characterEffect10131ui_story == nil then
				arg_117_1.var_.characterEffect10131ui_story = var_120_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_15 = 0.200000002980232

			if var_120_14 <= arg_117_1.time_ and arg_117_1.time_ < var_120_14 + var_120_15 and not isNil(var_120_13) then
				local var_120_16 = (arg_117_1.time_ - var_120_14) / var_120_15

				if arg_117_1.var_.characterEffect10131ui_story and not isNil(var_120_13) then
					local var_120_17 = Mathf.Lerp(0, 0.5, var_120_16)

					arg_117_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_117_1.var_.characterEffect10131ui_story.fillRatio = var_120_17
				end
			end

			if arg_117_1.time_ >= var_120_14 + var_120_15 and arg_117_1.time_ < var_120_14 + var_120_15 + arg_120_0 and not isNil(var_120_13) and arg_117_1.var_.characterEffect10131ui_story then
				local var_120_18 = 0.5

				arg_117_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_117_1.var_.characterEffect10131ui_story.fillRatio = var_120_18
			end

			local var_120_19 = 0

			if var_120_19 < arg_117_1.time_ and arg_117_1.time_ <= var_120_19 + arg_120_0 then
				arg_117_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action4_1")
			end

			local var_120_20 = 0

			if var_120_20 < arg_117_1.time_ and arg_117_1.time_ <= var_120_20 + arg_120_0 then
				arg_117_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_120_21 = 0
			local var_120_22 = 0.25

			if var_120_21 < arg_117_1.time_ and arg_117_1.time_ <= var_120_21 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_23 = arg_117_1:FormatText(StoryNameCfg[67].name)

				arg_117_1.leftNameTxt_.text = var_120_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_24 = arg_117_1:GetWordFromCfg(321371028)
				local var_120_25 = arg_117_1:FormatText(var_120_24.content)

				arg_117_1.text_.text = var_120_25

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_26 = 10
				local var_120_27 = utf8.len(var_120_25)
				local var_120_28 = var_120_26 <= 0 and var_120_22 or var_120_22 * (var_120_27 / var_120_26)

				if var_120_28 > 0 and var_120_22 < var_120_28 then
					arg_117_1.talkMaxDuration = var_120_28

					if var_120_28 + var_120_21 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_28 + var_120_21
					end
				end

				arg_117_1.text_.text = var_120_25
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371028", "story_v_out_321371.awb") ~= 0 then
					local var_120_29 = manager.audio:GetVoiceLength("story_v_out_321371", "321371028", "story_v_out_321371.awb") / 1000

					if var_120_29 + var_120_21 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_29 + var_120_21
					end

					if var_120_24.prefab_name ~= "" and arg_117_1.actors_[var_120_24.prefab_name] ~= nil then
						local var_120_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_24.prefab_name].transform, "story_v_out_321371", "321371028", "story_v_out_321371.awb")

						arg_117_1:RecordAudio("321371028", var_120_30)
						arg_117_1:RecordAudio("321371028", var_120_30)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_321371", "321371028", "story_v_out_321371.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_321371", "321371028", "story_v_out_321371.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_31 = math.max(var_120_22, arg_117_1.talkMaxDuration)

			if var_120_21 <= arg_117_1.time_ and arg_117_1.time_ < var_120_21 + var_120_31 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_21) / var_120_31

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_21 + var_120_31 and arg_117_1.time_ < var_120_21 + var_120_31 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_117_1:InitPlayNodeList()
	end,
	Play321371029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 321371029
		arg_121_1.duration_ = 4.4

		local var_121_0 = {
			zh = 4.1,
			ja = 4.4
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
				arg_121_0:Play321371030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = arg_121_1.actors_["10131ui_story"].transform
			local var_124_1 = 0

			if var_124_1 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 then
				arg_121_1.var_.moveOldPos10131ui_story = var_124_0.localPosition
			end

			local var_124_2 = 0.001

			if var_124_1 <= arg_121_1.time_ and arg_121_1.time_ < var_124_1 + var_124_2 then
				local var_124_3 = (arg_121_1.time_ - var_124_1) / var_124_2
				local var_124_4 = Vector3.New(0.83, -0.96, -5.8)

				var_124_0.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos10131ui_story, var_124_4, var_124_3)

				local var_124_5 = manager.ui.mainCamera.transform.position - var_124_0.position

				var_124_0.forward = Vector3.New(var_124_5.x, var_124_5.y, var_124_5.z)

				local var_124_6 = var_124_0.localEulerAngles

				var_124_6.z = 0
				var_124_6.x = 0
				var_124_0.localEulerAngles = var_124_6
			end

			if arg_121_1.time_ >= var_124_1 + var_124_2 and arg_121_1.time_ < var_124_1 + var_124_2 + arg_124_0 then
				var_124_0.localPosition = Vector3.New(0.83, -0.96, -5.8)

				local var_124_7 = manager.ui.mainCamera.transform.position - var_124_0.position

				var_124_0.forward = Vector3.New(var_124_7.x, var_124_7.y, var_124_7.z)

				local var_124_8 = var_124_0.localEulerAngles

				var_124_8.z = 0
				var_124_8.x = 0
				var_124_0.localEulerAngles = var_124_8
			end

			local var_124_9 = arg_121_1.actors_["10131ui_story"]
			local var_124_10 = 0

			if var_124_10 < arg_121_1.time_ and arg_121_1.time_ <= var_124_10 + arg_124_0 and not isNil(var_124_9) and arg_121_1.var_.characterEffect10131ui_story == nil then
				arg_121_1.var_.characterEffect10131ui_story = var_124_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_11 = 0.200000002980232

			if var_124_10 <= arg_121_1.time_ and arg_121_1.time_ < var_124_10 + var_124_11 and not isNil(var_124_9) then
				local var_124_12 = (arg_121_1.time_ - var_124_10) / var_124_11

				if arg_121_1.var_.characterEffect10131ui_story and not isNil(var_124_9) then
					arg_121_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= var_124_10 + var_124_11 and arg_121_1.time_ < var_124_10 + var_124_11 + arg_124_0 and not isNil(var_124_9) and arg_121_1.var_.characterEffect10131ui_story then
				arg_121_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_124_13 = arg_121_1.actors_["1111ui_story"]
			local var_124_14 = 0

			if var_124_14 < arg_121_1.time_ and arg_121_1.time_ <= var_124_14 + arg_124_0 and not isNil(var_124_13) and arg_121_1.var_.characterEffect1111ui_story == nil then
				arg_121_1.var_.characterEffect1111ui_story = var_124_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_15 = 0.200000002980232

			if var_124_14 <= arg_121_1.time_ and arg_121_1.time_ < var_124_14 + var_124_15 and not isNil(var_124_13) then
				local var_124_16 = (arg_121_1.time_ - var_124_14) / var_124_15

				if arg_121_1.var_.characterEffect1111ui_story and not isNil(var_124_13) then
					local var_124_17 = Mathf.Lerp(0, 0.5, var_124_16)

					arg_121_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_121_1.var_.characterEffect1111ui_story.fillRatio = var_124_17
				end
			end

			if arg_121_1.time_ >= var_124_14 + var_124_15 and arg_121_1.time_ < var_124_14 + var_124_15 + arg_124_0 and not isNil(var_124_13) and arg_121_1.var_.characterEffect1111ui_story then
				local var_124_18 = 0.5

				arg_121_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_121_1.var_.characterEffect1111ui_story.fillRatio = var_124_18
			end

			local var_124_19 = 0

			if var_124_19 < arg_121_1.time_ and arg_121_1.time_ <= var_124_19 + arg_124_0 then
				arg_121_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action6_1")
			end

			local var_124_20 = 0

			if var_124_20 < arg_121_1.time_ and arg_121_1.time_ <= var_124_20 + arg_124_0 then
				arg_121_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_124_21 = 0
			local var_124_22 = 0.475

			if var_124_21 < arg_121_1.time_ and arg_121_1.time_ <= var_124_21 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_23 = arg_121_1:FormatText(StoryNameCfg[1178].name)

				arg_121_1.leftNameTxt_.text = var_124_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_24 = arg_121_1:GetWordFromCfg(321371029)
				local var_124_25 = arg_121_1:FormatText(var_124_24.content)

				arg_121_1.text_.text = var_124_25

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_26 = 19
				local var_124_27 = utf8.len(var_124_25)
				local var_124_28 = var_124_26 <= 0 and var_124_22 or var_124_22 * (var_124_27 / var_124_26)

				if var_124_28 > 0 and var_124_22 < var_124_28 then
					arg_121_1.talkMaxDuration = var_124_28

					if var_124_28 + var_124_21 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_28 + var_124_21
					end
				end

				arg_121_1.text_.text = var_124_25
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371029", "story_v_out_321371.awb") ~= 0 then
					local var_124_29 = manager.audio:GetVoiceLength("story_v_out_321371", "321371029", "story_v_out_321371.awb") / 1000

					if var_124_29 + var_124_21 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_29 + var_124_21
					end

					if var_124_24.prefab_name ~= "" and arg_121_1.actors_[var_124_24.prefab_name] ~= nil then
						local var_124_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_24.prefab_name].transform, "story_v_out_321371", "321371029", "story_v_out_321371.awb")

						arg_121_1:RecordAudio("321371029", var_124_30)
						arg_121_1:RecordAudio("321371029", var_124_30)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_321371", "321371029", "story_v_out_321371.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_321371", "321371029", "story_v_out_321371.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_31 = math.max(var_124_22, arg_121_1.talkMaxDuration)

			if var_124_21 <= arg_121_1.time_ and arg_121_1.time_ < var_124_21 + var_124_31 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_21) / var_124_31

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_21 + var_124_31 and arg_121_1.time_ < var_124_21 + var_124_31 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10131ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_121_1:InitPlayNodeList()
	end,
	Play321371030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 321371030
		arg_125_1.duration_ = 12.47

		local var_125_0 = {
			zh = 9.6,
			ja = 12.466
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
				arg_125_0:Play321371031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = 0
			local var_128_1 = 0.875

			if var_128_0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_0 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				local var_128_2 = arg_125_1:FormatText(StoryNameCfg[1178].name)

				arg_125_1.leftNameTxt_.text = var_128_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_3 = arg_125_1:GetWordFromCfg(321371030)
				local var_128_4 = arg_125_1:FormatText(var_128_3.content)

				arg_125_1.text_.text = var_128_4

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_5 = 35
				local var_128_6 = utf8.len(var_128_4)
				local var_128_7 = var_128_5 <= 0 and var_128_1 or var_128_1 * (var_128_6 / var_128_5)

				if var_128_7 > 0 and var_128_1 < var_128_7 then
					arg_125_1.talkMaxDuration = var_128_7

					if var_128_7 + var_128_0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_7 + var_128_0
					end
				end

				arg_125_1.text_.text = var_128_4
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371030", "story_v_out_321371.awb") ~= 0 then
					local var_128_8 = manager.audio:GetVoiceLength("story_v_out_321371", "321371030", "story_v_out_321371.awb") / 1000

					if var_128_8 + var_128_0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_8 + var_128_0
					end

					if var_128_3.prefab_name ~= "" and arg_125_1.actors_[var_128_3.prefab_name] ~= nil then
						local var_128_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_3.prefab_name].transform, "story_v_out_321371", "321371030", "story_v_out_321371.awb")

						arg_125_1:RecordAudio("321371030", var_128_9)
						arg_125_1:RecordAudio("321371030", var_128_9)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_321371", "321371030", "story_v_out_321371.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_321371", "321371030", "story_v_out_321371.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_10 = math.max(var_128_1, arg_125_1.talkMaxDuration)

			if var_128_0 <= arg_125_1.time_ and arg_125_1.time_ < var_128_0 + var_128_10 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_0) / var_128_10

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_0 + var_128_10 and arg_125_1.time_ < var_128_0 + var_128_10 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play321371031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 321371031
		arg_129_1.duration_ = 2.4

		local var_129_0 = {
			zh = 1.999999999999,
			ja = 2.4
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
				arg_129_0:Play321371032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 0

			if var_132_0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_0 + arg_132_0 then
				arg_129_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/expr_biyanbiaozhun", "EmotionTimelineAnimator")
			end

			local var_132_1 = 0
			local var_132_2 = 0.125

			if var_132_1 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_3 = arg_129_1:FormatText(StoryNameCfg[1178].name)

				arg_129_1.leftNameTxt_.text = var_132_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_4 = arg_129_1:GetWordFromCfg(321371031)
				local var_132_5 = arg_129_1:FormatText(var_132_4.content)

				arg_129_1.text_.text = var_132_5

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_6 = 5
				local var_132_7 = utf8.len(var_132_5)
				local var_132_8 = var_132_6 <= 0 and var_132_2 or var_132_2 * (var_132_7 / var_132_6)

				if var_132_8 > 0 and var_132_2 < var_132_8 then
					arg_129_1.talkMaxDuration = var_132_8

					if var_132_8 + var_132_1 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_8 + var_132_1
					end
				end

				arg_129_1.text_.text = var_132_5
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371031", "story_v_out_321371.awb") ~= 0 then
					local var_132_9 = manager.audio:GetVoiceLength("story_v_out_321371", "321371031", "story_v_out_321371.awb") / 1000

					if var_132_9 + var_132_1 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_9 + var_132_1
					end

					if var_132_4.prefab_name ~= "" and arg_129_1.actors_[var_132_4.prefab_name] ~= nil then
						local var_132_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_4.prefab_name].transform, "story_v_out_321371", "321371031", "story_v_out_321371.awb")

						arg_129_1:RecordAudio("321371031", var_132_10)
						arg_129_1:RecordAudio("321371031", var_132_10)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_321371", "321371031", "story_v_out_321371.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_321371", "321371031", "story_v_out_321371.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_11 = math.max(var_132_2, arg_129_1.talkMaxDuration)

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_11 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_1) / var_132_11

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_1 + var_132_11 and arg_129_1.time_ < var_132_1 + var_132_11 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play321371032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 321371032
		arg_133_1.duration_ = 4.63

		local var_133_0 = {
			zh = 2.3,
			ja = 4.633
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
				arg_133_0:Play321371033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = arg_133_1.actors_["1111ui_story"].transform
			local var_136_1 = 0

			if var_136_1 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 then
				arg_133_1.var_.moveOldPos1111ui_story = var_136_0.localPosition
			end

			local var_136_2 = 0.001

			if var_136_1 <= arg_133_1.time_ and arg_133_1.time_ < var_136_1 + var_136_2 then
				local var_136_3 = (arg_133_1.time_ - var_136_1) / var_136_2
				local var_136_4 = Vector3.New(-0.79, -0.87, -5.7)

				var_136_0.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos1111ui_story, var_136_4, var_136_3)

				local var_136_5 = manager.ui.mainCamera.transform.position - var_136_0.position

				var_136_0.forward = Vector3.New(var_136_5.x, var_136_5.y, var_136_5.z)

				local var_136_6 = var_136_0.localEulerAngles

				var_136_6.z = 0
				var_136_6.x = 0
				var_136_0.localEulerAngles = var_136_6
			end

			if arg_133_1.time_ >= var_136_1 + var_136_2 and arg_133_1.time_ < var_136_1 + var_136_2 + arg_136_0 then
				var_136_0.localPosition = Vector3.New(-0.79, -0.87, -5.7)

				local var_136_7 = manager.ui.mainCamera.transform.position - var_136_0.position

				var_136_0.forward = Vector3.New(var_136_7.x, var_136_7.y, var_136_7.z)

				local var_136_8 = var_136_0.localEulerAngles

				var_136_8.z = 0
				var_136_8.x = 0
				var_136_0.localEulerAngles = var_136_8
			end

			local var_136_9 = arg_133_1.actors_["1111ui_story"]
			local var_136_10 = 0

			if var_136_10 < arg_133_1.time_ and arg_133_1.time_ <= var_136_10 + arg_136_0 and not isNil(var_136_9) and arg_133_1.var_.characterEffect1111ui_story == nil then
				arg_133_1.var_.characterEffect1111ui_story = var_136_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_11 = 0.200000002980232

			if var_136_10 <= arg_133_1.time_ and arg_133_1.time_ < var_136_10 + var_136_11 and not isNil(var_136_9) then
				local var_136_12 = (arg_133_1.time_ - var_136_10) / var_136_11

				if arg_133_1.var_.characterEffect1111ui_story and not isNil(var_136_9) then
					arg_133_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= var_136_10 + var_136_11 and arg_133_1.time_ < var_136_10 + var_136_11 + arg_136_0 and not isNil(var_136_9) and arg_133_1.var_.characterEffect1111ui_story then
				arg_133_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_136_13 = arg_133_1.actors_["10131ui_story"]
			local var_136_14 = 0

			if var_136_14 < arg_133_1.time_ and arg_133_1.time_ <= var_136_14 + arg_136_0 and not isNil(var_136_13) and arg_133_1.var_.characterEffect10131ui_story == nil then
				arg_133_1.var_.characterEffect10131ui_story = var_136_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_15 = 0.200000002980232

			if var_136_14 <= arg_133_1.time_ and arg_133_1.time_ < var_136_14 + var_136_15 and not isNil(var_136_13) then
				local var_136_16 = (arg_133_1.time_ - var_136_14) / var_136_15

				if arg_133_1.var_.characterEffect10131ui_story and not isNil(var_136_13) then
					local var_136_17 = Mathf.Lerp(0, 0.5, var_136_16)

					arg_133_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_133_1.var_.characterEffect10131ui_story.fillRatio = var_136_17
				end
			end

			if arg_133_1.time_ >= var_136_14 + var_136_15 and arg_133_1.time_ < var_136_14 + var_136_15 + arg_136_0 and not isNil(var_136_13) and arg_133_1.var_.characterEffect10131ui_story then
				local var_136_18 = 0.5

				arg_133_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_133_1.var_.characterEffect10131ui_story.fillRatio = var_136_18
			end

			local var_136_19 = 0

			if var_136_19 < arg_133_1.time_ and arg_133_1.time_ <= var_136_19 + arg_136_0 then
				arg_133_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action4_2")
			end

			local var_136_20 = 0

			if var_136_20 < arg_133_1.time_ and arg_133_1.time_ <= var_136_20 + arg_136_0 then
				arg_133_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva", "EmotionTimelineAnimator")
			end

			local var_136_21 = 0
			local var_136_22 = 0.25

			if var_136_21 < arg_133_1.time_ and arg_133_1.time_ <= var_136_21 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_23 = arg_133_1:FormatText(StoryNameCfg[67].name)

				arg_133_1.leftNameTxt_.text = var_136_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_24 = arg_133_1:GetWordFromCfg(321371032)
				local var_136_25 = arg_133_1:FormatText(var_136_24.content)

				arg_133_1.text_.text = var_136_25

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_26 = 10
				local var_136_27 = utf8.len(var_136_25)
				local var_136_28 = var_136_26 <= 0 and var_136_22 or var_136_22 * (var_136_27 / var_136_26)

				if var_136_28 > 0 and var_136_22 < var_136_28 then
					arg_133_1.talkMaxDuration = var_136_28

					if var_136_28 + var_136_21 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_28 + var_136_21
					end
				end

				arg_133_1.text_.text = var_136_25
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371032", "story_v_out_321371.awb") ~= 0 then
					local var_136_29 = manager.audio:GetVoiceLength("story_v_out_321371", "321371032", "story_v_out_321371.awb") / 1000

					if var_136_29 + var_136_21 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_29 + var_136_21
					end

					if var_136_24.prefab_name ~= "" and arg_133_1.actors_[var_136_24.prefab_name] ~= nil then
						local var_136_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_24.prefab_name].transform, "story_v_out_321371", "321371032", "story_v_out_321371.awb")

						arg_133_1:RecordAudio("321371032", var_136_30)
						arg_133_1:RecordAudio("321371032", var_136_30)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_321371", "321371032", "story_v_out_321371.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_321371", "321371032", "story_v_out_321371.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_31 = math.max(var_136_22, arg_133_1.talkMaxDuration)

			if var_136_21 <= arg_133_1.time_ and arg_133_1.time_ < var_136_21 + var_136_31 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_21) / var_136_31

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_21 + var_136_31 and arg_133_1.time_ < var_136_21 + var_136_31 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_133_1:InitPlayNodeList()
	end,
	Play321371033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 321371033
		arg_137_1.duration_ = 12

		local var_137_0 = {
			zh = 7.9,
			ja = 12
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
				arg_137_0:Play321371034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = arg_137_1.actors_["10131ui_story"].transform
			local var_140_1 = 0

			if var_140_1 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 then
				arg_137_1.var_.moveOldPos10131ui_story = var_140_0.localPosition
			end

			local var_140_2 = 0.001

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_2 then
				local var_140_3 = (arg_137_1.time_ - var_140_1) / var_140_2
				local var_140_4 = Vector3.New(0.83, -0.96, -5.8)

				var_140_0.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos10131ui_story, var_140_4, var_140_3)

				local var_140_5 = manager.ui.mainCamera.transform.position - var_140_0.position

				var_140_0.forward = Vector3.New(var_140_5.x, var_140_5.y, var_140_5.z)

				local var_140_6 = var_140_0.localEulerAngles

				var_140_6.z = 0
				var_140_6.x = 0
				var_140_0.localEulerAngles = var_140_6
			end

			if arg_137_1.time_ >= var_140_1 + var_140_2 and arg_137_1.time_ < var_140_1 + var_140_2 + arg_140_0 then
				var_140_0.localPosition = Vector3.New(0.83, -0.96, -5.8)

				local var_140_7 = manager.ui.mainCamera.transform.position - var_140_0.position

				var_140_0.forward = Vector3.New(var_140_7.x, var_140_7.y, var_140_7.z)

				local var_140_8 = var_140_0.localEulerAngles

				var_140_8.z = 0
				var_140_8.x = 0
				var_140_0.localEulerAngles = var_140_8
			end

			local var_140_9 = arg_137_1.actors_["10131ui_story"]
			local var_140_10 = 0

			if var_140_10 < arg_137_1.time_ and arg_137_1.time_ <= var_140_10 + arg_140_0 and not isNil(var_140_9) and arg_137_1.var_.characterEffect10131ui_story == nil then
				arg_137_1.var_.characterEffect10131ui_story = var_140_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_11 = 0.200000002980232

			if var_140_10 <= arg_137_1.time_ and arg_137_1.time_ < var_140_10 + var_140_11 and not isNil(var_140_9) then
				local var_140_12 = (arg_137_1.time_ - var_140_10) / var_140_11

				if arg_137_1.var_.characterEffect10131ui_story and not isNil(var_140_9) then
					arg_137_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_137_1.time_ >= var_140_10 + var_140_11 and arg_137_1.time_ < var_140_10 + var_140_11 + arg_140_0 and not isNil(var_140_9) and arg_137_1.var_.characterEffect10131ui_story then
				arg_137_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_140_13 = arg_137_1.actors_["1111ui_story"]
			local var_140_14 = 0

			if var_140_14 < arg_137_1.time_ and arg_137_1.time_ <= var_140_14 + arg_140_0 and not isNil(var_140_13) and arg_137_1.var_.characterEffect1111ui_story == nil then
				arg_137_1.var_.characterEffect1111ui_story = var_140_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_15 = 0.200000002980232

			if var_140_14 <= arg_137_1.time_ and arg_137_1.time_ < var_140_14 + var_140_15 and not isNil(var_140_13) then
				local var_140_16 = (arg_137_1.time_ - var_140_14) / var_140_15

				if arg_137_1.var_.characterEffect1111ui_story and not isNil(var_140_13) then
					local var_140_17 = Mathf.Lerp(0, 0.5, var_140_16)

					arg_137_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_137_1.var_.characterEffect1111ui_story.fillRatio = var_140_17
				end
			end

			if arg_137_1.time_ >= var_140_14 + var_140_15 and arg_137_1.time_ < var_140_14 + var_140_15 + arg_140_0 and not isNil(var_140_13) and arg_137_1.var_.characterEffect1111ui_story then
				local var_140_18 = 0.5

				arg_137_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_137_1.var_.characterEffect1111ui_story.fillRatio = var_140_18
			end

			local var_140_19 = 0

			if var_140_19 < arg_137_1.time_ and arg_137_1.time_ <= var_140_19 + arg_140_0 then
				arg_137_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action6_2")
			end

			local var_140_20 = 0

			if var_140_20 < arg_137_1.time_ and arg_137_1.time_ <= var_140_20 + arg_140_0 then
				arg_137_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_140_21 = 0
			local var_140_22 = 0.9

			if var_140_21 < arg_137_1.time_ and arg_137_1.time_ <= var_140_21 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_23 = arg_137_1:FormatText(StoryNameCfg[1178].name)

				arg_137_1.leftNameTxt_.text = var_140_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_24 = arg_137_1:GetWordFromCfg(321371033)
				local var_140_25 = arg_137_1:FormatText(var_140_24.content)

				arg_137_1.text_.text = var_140_25

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_26 = 36
				local var_140_27 = utf8.len(var_140_25)
				local var_140_28 = var_140_26 <= 0 and var_140_22 or var_140_22 * (var_140_27 / var_140_26)

				if var_140_28 > 0 and var_140_22 < var_140_28 then
					arg_137_1.talkMaxDuration = var_140_28

					if var_140_28 + var_140_21 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_28 + var_140_21
					end
				end

				arg_137_1.text_.text = var_140_25
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371033", "story_v_out_321371.awb") ~= 0 then
					local var_140_29 = manager.audio:GetVoiceLength("story_v_out_321371", "321371033", "story_v_out_321371.awb") / 1000

					if var_140_29 + var_140_21 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_29 + var_140_21
					end

					if var_140_24.prefab_name ~= "" and arg_137_1.actors_[var_140_24.prefab_name] ~= nil then
						local var_140_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_24.prefab_name].transform, "story_v_out_321371", "321371033", "story_v_out_321371.awb")

						arg_137_1:RecordAudio("321371033", var_140_30)
						arg_137_1:RecordAudio("321371033", var_140_30)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_321371", "321371033", "story_v_out_321371.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_321371", "321371033", "story_v_out_321371.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_31 = math.max(var_140_22, arg_137_1.talkMaxDuration)

			if var_140_21 <= arg_137_1.time_ and arg_137_1.time_ < var_140_21 + var_140_31 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_21) / var_140_31

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_21 + var_140_31 and arg_137_1.time_ < var_140_21 + var_140_31 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10131ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_137_1:InitPlayNodeList()
	end,
	Play321371034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 321371034
		arg_141_1.duration_ = 5

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play321371035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = manager.ui.mainCamera.transform
			local var_144_1 = 0

			if var_144_1 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 then
				local var_144_2 = arg_141_1.var_.effectsuipian1

				if var_144_2 then
					Object.Destroy(var_144_2)

					arg_141_1.var_.effectsuipian1 = nil
				end
			end

			local var_144_3 = arg_141_1.actors_["10131ui_story"]
			local var_144_4 = 0

			if var_144_4 < arg_141_1.time_ and arg_141_1.time_ <= var_144_4 + arg_144_0 and not isNil(var_144_3) and arg_141_1.var_.characterEffect10131ui_story == nil then
				arg_141_1.var_.characterEffect10131ui_story = var_144_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_5 = 0.200000002980232

			if var_144_4 <= arg_141_1.time_ and arg_141_1.time_ < var_144_4 + var_144_5 and not isNil(var_144_3) then
				local var_144_6 = (arg_141_1.time_ - var_144_4) / var_144_5

				if arg_141_1.var_.characterEffect10131ui_story and not isNil(var_144_3) then
					local var_144_7 = Mathf.Lerp(0, 0.5, var_144_6)

					arg_141_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_141_1.var_.characterEffect10131ui_story.fillRatio = var_144_7
				end
			end

			if arg_141_1.time_ >= var_144_4 + var_144_5 and arg_141_1.time_ < var_144_4 + var_144_5 + arg_144_0 and not isNil(var_144_3) and arg_141_1.var_.characterEffect10131ui_story then
				local var_144_8 = 0.5

				arg_141_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_141_1.var_.characterEffect10131ui_story.fillRatio = var_144_8
			end

			local var_144_9 = arg_141_1.actors_["1111ui_story"]
			local var_144_10 = 0

			if var_144_10 < arg_141_1.time_ and arg_141_1.time_ <= var_144_10 + arg_144_0 and not isNil(var_144_9) and arg_141_1.var_.characterEffect1111ui_story == nil then
				arg_141_1.var_.characterEffect1111ui_story = var_144_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_11 = 0.200000002980232

			if var_144_10 <= arg_141_1.time_ and arg_141_1.time_ < var_144_10 + var_144_11 and not isNil(var_144_9) then
				local var_144_12 = (arg_141_1.time_ - var_144_10) / var_144_11

				if arg_141_1.var_.characterEffect1111ui_story and not isNil(var_144_9) then
					local var_144_13 = Mathf.Lerp(0, 0.5, var_144_12)

					arg_141_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_141_1.var_.characterEffect1111ui_story.fillRatio = var_144_13
				end
			end

			if arg_141_1.time_ >= var_144_10 + var_144_11 and arg_141_1.time_ < var_144_10 + var_144_11 + arg_144_0 and not isNil(var_144_9) and arg_141_1.var_.characterEffect1111ui_story then
				local var_144_14 = 0.5

				arg_141_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_141_1.var_.characterEffect1111ui_story.fillRatio = var_144_14
			end

			local var_144_15 = 0
			local var_144_16 = 0.925

			if var_144_15 < arg_141_1.time_ and arg_141_1.time_ <= var_144_15 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, false)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_17 = arg_141_1:GetWordFromCfg(321371034)
				local var_144_18 = arg_141_1:FormatText(var_144_17.content)

				arg_141_1.text_.text = var_144_18

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_19 = 37
				local var_144_20 = utf8.len(var_144_18)
				local var_144_21 = var_144_19 <= 0 and var_144_16 or var_144_16 * (var_144_20 / var_144_19)

				if var_144_21 > 0 and var_144_16 < var_144_21 then
					arg_141_1.talkMaxDuration = var_144_21

					if var_144_21 + var_144_15 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_21 + var_144_15
					end
				end

				arg_141_1.text_.text = var_144_18
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)
				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_22 = math.max(var_144_16, arg_141_1.talkMaxDuration)

			if var_144_15 <= arg_141_1.time_ and arg_141_1.time_ < var_144_15 + var_144_22 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_15) / var_144_22

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_15 + var_144_22 and arg_141_1.time_ < var_144_15 + var_144_22 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play321371035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 321371035
		arg_145_1.duration_ = 8.23

		local var_145_0 = {
			zh = 7.4,
			ja = 8.233
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
				arg_145_0:Play321371036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = arg_145_1.actors_["10131ui_story"].transform
			local var_148_1 = 0

			if var_148_1 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 then
				arg_145_1.var_.moveOldPos10131ui_story = var_148_0.localPosition
			end

			local var_148_2 = 0.001

			if var_148_1 <= arg_145_1.time_ and arg_145_1.time_ < var_148_1 + var_148_2 then
				local var_148_3 = (arg_145_1.time_ - var_148_1) / var_148_2
				local var_148_4 = Vector3.New(0.83, -0.96, -5.8)

				var_148_0.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos10131ui_story, var_148_4, var_148_3)

				local var_148_5 = manager.ui.mainCamera.transform.position - var_148_0.position

				var_148_0.forward = Vector3.New(var_148_5.x, var_148_5.y, var_148_5.z)

				local var_148_6 = var_148_0.localEulerAngles

				var_148_6.z = 0
				var_148_6.x = 0
				var_148_0.localEulerAngles = var_148_6
			end

			if arg_145_1.time_ >= var_148_1 + var_148_2 and arg_145_1.time_ < var_148_1 + var_148_2 + arg_148_0 then
				var_148_0.localPosition = Vector3.New(0.83, -0.96, -5.8)

				local var_148_7 = manager.ui.mainCamera.transform.position - var_148_0.position

				var_148_0.forward = Vector3.New(var_148_7.x, var_148_7.y, var_148_7.z)

				local var_148_8 = var_148_0.localEulerAngles

				var_148_8.z = 0
				var_148_8.x = 0
				var_148_0.localEulerAngles = var_148_8
			end

			local var_148_9 = arg_145_1.actors_["10131ui_story"]
			local var_148_10 = 0

			if var_148_10 < arg_145_1.time_ and arg_145_1.time_ <= var_148_10 + arg_148_0 and not isNil(var_148_9) and arg_145_1.var_.characterEffect10131ui_story == nil then
				arg_145_1.var_.characterEffect10131ui_story = var_148_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_11 = 0.200000002980232

			if var_148_10 <= arg_145_1.time_ and arg_145_1.time_ < var_148_10 + var_148_11 and not isNil(var_148_9) then
				local var_148_12 = (arg_145_1.time_ - var_148_10) / var_148_11

				if arg_145_1.var_.characterEffect10131ui_story and not isNil(var_148_9) then
					arg_145_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_145_1.time_ >= var_148_10 + var_148_11 and arg_145_1.time_ < var_148_10 + var_148_11 + arg_148_0 and not isNil(var_148_9) and arg_145_1.var_.characterEffect10131ui_story then
				arg_145_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_148_13 = 0

			if var_148_13 < arg_145_1.time_ and arg_145_1.time_ <= var_148_13 + arg_148_0 then
				arg_145_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_148_14 = 0
			local var_148_15 = 0.775

			if var_148_14 < arg_145_1.time_ and arg_145_1.time_ <= var_148_14 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				local var_148_16 = arg_145_1:FormatText(StoryNameCfg[1178].name)

				arg_145_1.leftNameTxt_.text = var_148_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_17 = arg_145_1:GetWordFromCfg(321371035)
				local var_148_18 = arg_145_1:FormatText(var_148_17.content)

				arg_145_1.text_.text = var_148_18

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_19 = 31
				local var_148_20 = utf8.len(var_148_18)
				local var_148_21 = var_148_19 <= 0 and var_148_15 or var_148_15 * (var_148_20 / var_148_19)

				if var_148_21 > 0 and var_148_15 < var_148_21 then
					arg_145_1.talkMaxDuration = var_148_21

					if var_148_21 + var_148_14 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_21 + var_148_14
					end
				end

				arg_145_1.text_.text = var_148_18
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371035", "story_v_out_321371.awb") ~= 0 then
					local var_148_22 = manager.audio:GetVoiceLength("story_v_out_321371", "321371035", "story_v_out_321371.awb") / 1000

					if var_148_22 + var_148_14 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_22 + var_148_14
					end

					if var_148_17.prefab_name ~= "" and arg_145_1.actors_[var_148_17.prefab_name] ~= nil then
						local var_148_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_17.prefab_name].transform, "story_v_out_321371", "321371035", "story_v_out_321371.awb")

						arg_145_1:RecordAudio("321371035", var_148_23)
						arg_145_1:RecordAudio("321371035", var_148_23)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_321371", "321371035", "story_v_out_321371.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_321371", "321371035", "story_v_out_321371.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_24 = math.max(var_148_15, arg_145_1.talkMaxDuration)

			if var_148_14 <= arg_145_1.time_ and arg_145_1.time_ < var_148_14 + var_148_24 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_14) / var_148_24

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_14 + var_148_24 and arg_145_1.time_ < var_148_14 + var_148_24 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10131ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_145_1:InitPlayNodeList()
	end,
	Play321371036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 321371036
		arg_149_1.duration_ = 3.77

		local var_149_0 = {
			zh = 2.566,
			ja = 3.766
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
				arg_149_0:Play321371037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = arg_149_1.actors_["1111ui_story"].transform
			local var_152_1 = 0

			if var_152_1 < arg_149_1.time_ and arg_149_1.time_ <= var_152_1 + arg_152_0 then
				arg_149_1.var_.moveOldPos1111ui_story = var_152_0.localPosition
			end

			local var_152_2 = 0.001

			if var_152_1 <= arg_149_1.time_ and arg_149_1.time_ < var_152_1 + var_152_2 then
				local var_152_3 = (arg_149_1.time_ - var_152_1) / var_152_2
				local var_152_4 = Vector3.New(-0.79, -0.87, -5.7)

				var_152_0.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos1111ui_story, var_152_4, var_152_3)

				local var_152_5 = manager.ui.mainCamera.transform.position - var_152_0.position

				var_152_0.forward = Vector3.New(var_152_5.x, var_152_5.y, var_152_5.z)

				local var_152_6 = var_152_0.localEulerAngles

				var_152_6.z = 0
				var_152_6.x = 0
				var_152_0.localEulerAngles = var_152_6
			end

			if arg_149_1.time_ >= var_152_1 + var_152_2 and arg_149_1.time_ < var_152_1 + var_152_2 + arg_152_0 then
				var_152_0.localPosition = Vector3.New(-0.79, -0.87, -5.7)

				local var_152_7 = manager.ui.mainCamera.transform.position - var_152_0.position

				var_152_0.forward = Vector3.New(var_152_7.x, var_152_7.y, var_152_7.z)

				local var_152_8 = var_152_0.localEulerAngles

				var_152_8.z = 0
				var_152_8.x = 0
				var_152_0.localEulerAngles = var_152_8
			end

			local var_152_9 = arg_149_1.actors_["1111ui_story"]
			local var_152_10 = 0

			if var_152_10 < arg_149_1.time_ and arg_149_1.time_ <= var_152_10 + arg_152_0 and not isNil(var_152_9) and arg_149_1.var_.characterEffect1111ui_story == nil then
				arg_149_1.var_.characterEffect1111ui_story = var_152_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_11 = 0.200000002980232

			if var_152_10 <= arg_149_1.time_ and arg_149_1.time_ < var_152_10 + var_152_11 and not isNil(var_152_9) then
				local var_152_12 = (arg_149_1.time_ - var_152_10) / var_152_11

				if arg_149_1.var_.characterEffect1111ui_story and not isNil(var_152_9) then
					arg_149_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_149_1.time_ >= var_152_10 + var_152_11 and arg_149_1.time_ < var_152_10 + var_152_11 + arg_152_0 and not isNil(var_152_9) and arg_149_1.var_.characterEffect1111ui_story then
				arg_149_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_152_13 = arg_149_1.actors_["10131ui_story"]
			local var_152_14 = 0

			if var_152_14 < arg_149_1.time_ and arg_149_1.time_ <= var_152_14 + arg_152_0 and not isNil(var_152_13) and arg_149_1.var_.characterEffect10131ui_story == nil then
				arg_149_1.var_.characterEffect10131ui_story = var_152_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_15 = 0.200000002980232

			if var_152_14 <= arg_149_1.time_ and arg_149_1.time_ < var_152_14 + var_152_15 and not isNil(var_152_13) then
				local var_152_16 = (arg_149_1.time_ - var_152_14) / var_152_15

				if arg_149_1.var_.characterEffect10131ui_story and not isNil(var_152_13) then
					local var_152_17 = Mathf.Lerp(0, 0.5, var_152_16)

					arg_149_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_149_1.var_.characterEffect10131ui_story.fillRatio = var_152_17
				end
			end

			if arg_149_1.time_ >= var_152_14 + var_152_15 and arg_149_1.time_ < var_152_14 + var_152_15 + arg_152_0 and not isNil(var_152_13) and arg_149_1.var_.characterEffect10131ui_story then
				local var_152_18 = 0.5

				arg_149_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_149_1.var_.characterEffect10131ui_story.fillRatio = var_152_18
			end

			local var_152_19 = 0

			if var_152_19 < arg_149_1.time_ and arg_149_1.time_ <= var_152_19 + arg_152_0 then
				arg_149_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action5_1")
			end

			local var_152_20 = 0

			if var_152_20 < arg_149_1.time_ and arg_149_1.time_ <= var_152_20 + arg_152_0 then
				arg_149_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_152_21 = 0
			local var_152_22 = 0.35

			if var_152_21 < arg_149_1.time_ and arg_149_1.time_ <= var_152_21 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				local var_152_23 = arg_149_1:FormatText(StoryNameCfg[67].name)

				arg_149_1.leftNameTxt_.text = var_152_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_24 = arg_149_1:GetWordFromCfg(321371036)
				local var_152_25 = arg_149_1:FormatText(var_152_24.content)

				arg_149_1.text_.text = var_152_25

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_26 = 14
				local var_152_27 = utf8.len(var_152_25)
				local var_152_28 = var_152_26 <= 0 and var_152_22 or var_152_22 * (var_152_27 / var_152_26)

				if var_152_28 > 0 and var_152_22 < var_152_28 then
					arg_149_1.talkMaxDuration = var_152_28

					if var_152_28 + var_152_21 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_28 + var_152_21
					end
				end

				arg_149_1.text_.text = var_152_25
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371036", "story_v_out_321371.awb") ~= 0 then
					local var_152_29 = manager.audio:GetVoiceLength("story_v_out_321371", "321371036", "story_v_out_321371.awb") / 1000

					if var_152_29 + var_152_21 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_29 + var_152_21
					end

					if var_152_24.prefab_name ~= "" and arg_149_1.actors_[var_152_24.prefab_name] ~= nil then
						local var_152_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_24.prefab_name].transform, "story_v_out_321371", "321371036", "story_v_out_321371.awb")

						arg_149_1:RecordAudio("321371036", var_152_30)
						arg_149_1:RecordAudio("321371036", var_152_30)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_321371", "321371036", "story_v_out_321371.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_321371", "321371036", "story_v_out_321371.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_31 = math.max(var_152_22, arg_149_1.talkMaxDuration)

			if var_152_21 <= arg_149_1.time_ and arg_149_1.time_ < var_152_21 + var_152_31 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_21) / var_152_31

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_21 + var_152_31 and arg_149_1.time_ < var_152_21 + var_152_31 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_149_1:InitPlayNodeList()
	end,
	Play321371037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 321371037
		arg_153_1.duration_ = 14.37

		local var_153_0 = {
			zh = 12.733,
			ja = 14.366
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
				arg_153_0:Play321371038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = arg_153_1.actors_["10131ui_story"]
			local var_156_1 = 0

			if var_156_1 < arg_153_1.time_ and arg_153_1.time_ <= var_156_1 + arg_156_0 and not isNil(var_156_0) and arg_153_1.var_.characterEffect10131ui_story == nil then
				arg_153_1.var_.characterEffect10131ui_story = var_156_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_2 = 0.200000002980232

			if var_156_1 <= arg_153_1.time_ and arg_153_1.time_ < var_156_1 + var_156_2 and not isNil(var_156_0) then
				local var_156_3 = (arg_153_1.time_ - var_156_1) / var_156_2

				if arg_153_1.var_.characterEffect10131ui_story and not isNil(var_156_0) then
					arg_153_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_153_1.time_ >= var_156_1 + var_156_2 and arg_153_1.time_ < var_156_1 + var_156_2 + arg_156_0 and not isNil(var_156_0) and arg_153_1.var_.characterEffect10131ui_story then
				arg_153_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_156_4 = arg_153_1.actors_["1111ui_story"]
			local var_156_5 = 0

			if var_156_5 < arg_153_1.time_ and arg_153_1.time_ <= var_156_5 + arg_156_0 and not isNil(var_156_4) and arg_153_1.var_.characterEffect1111ui_story == nil then
				arg_153_1.var_.characterEffect1111ui_story = var_156_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_6 = 0.200000002980232

			if var_156_5 <= arg_153_1.time_ and arg_153_1.time_ < var_156_5 + var_156_6 and not isNil(var_156_4) then
				local var_156_7 = (arg_153_1.time_ - var_156_5) / var_156_6

				if arg_153_1.var_.characterEffect1111ui_story and not isNil(var_156_4) then
					local var_156_8 = Mathf.Lerp(0, 0.5, var_156_7)

					arg_153_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_153_1.var_.characterEffect1111ui_story.fillRatio = var_156_8
				end
			end

			if arg_153_1.time_ >= var_156_5 + var_156_6 and arg_153_1.time_ < var_156_5 + var_156_6 + arg_156_0 and not isNil(var_156_4) and arg_153_1.var_.characterEffect1111ui_story then
				local var_156_9 = 0.5

				arg_153_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_153_1.var_.characterEffect1111ui_story.fillRatio = var_156_9
			end

			local var_156_10 = 0

			if var_156_10 < arg_153_1.time_ and arg_153_1.time_ <= var_156_10 + arg_156_0 then
				arg_153_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action1_1")
			end

			local var_156_11 = 0
			local var_156_12 = 1.225

			if var_156_11 < arg_153_1.time_ and arg_153_1.time_ <= var_156_11 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_13 = arg_153_1:FormatText(StoryNameCfg[1178].name)

				arg_153_1.leftNameTxt_.text = var_156_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_14 = arg_153_1:GetWordFromCfg(321371037)
				local var_156_15 = arg_153_1:FormatText(var_156_14.content)

				arg_153_1.text_.text = var_156_15

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_16 = 49
				local var_156_17 = utf8.len(var_156_15)
				local var_156_18 = var_156_16 <= 0 and var_156_12 or var_156_12 * (var_156_17 / var_156_16)

				if var_156_18 > 0 and var_156_12 < var_156_18 then
					arg_153_1.talkMaxDuration = var_156_18

					if var_156_18 + var_156_11 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_18 + var_156_11
					end
				end

				arg_153_1.text_.text = var_156_15
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371037", "story_v_out_321371.awb") ~= 0 then
					local var_156_19 = manager.audio:GetVoiceLength("story_v_out_321371", "321371037", "story_v_out_321371.awb") / 1000

					if var_156_19 + var_156_11 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_19 + var_156_11
					end

					if var_156_14.prefab_name ~= "" and arg_153_1.actors_[var_156_14.prefab_name] ~= nil then
						local var_156_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_14.prefab_name].transform, "story_v_out_321371", "321371037", "story_v_out_321371.awb")

						arg_153_1:RecordAudio("321371037", var_156_20)
						arg_153_1:RecordAudio("321371037", var_156_20)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_321371", "321371037", "story_v_out_321371.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_321371", "321371037", "story_v_out_321371.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_21 = math.max(var_156_12, arg_153_1.talkMaxDuration)

			if var_156_11 <= arg_153_1.time_ and arg_153_1.time_ < var_156_11 + var_156_21 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_11) / var_156_21

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_11 + var_156_21 and arg_153_1.time_ < var_156_11 + var_156_21 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play321371038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 321371038
		arg_157_1.duration_ = 6.67

		local var_157_0 = {
			zh = 4.733,
			ja = 6.666
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
				arg_157_0:Play321371039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = 0

			if var_160_0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_0 + arg_160_0 then
				arg_157_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action6_1")
			end

			local var_160_1 = 0

			if var_160_1 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 then
				arg_157_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_160_2 = 0
			local var_160_3 = 0.35

			if var_160_2 < arg_157_1.time_ and arg_157_1.time_ <= var_160_2 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				local var_160_4 = arg_157_1:FormatText(StoryNameCfg[1178].name)

				arg_157_1.leftNameTxt_.text = var_160_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_5 = arg_157_1:GetWordFromCfg(321371038)
				local var_160_6 = arg_157_1:FormatText(var_160_5.content)

				arg_157_1.text_.text = var_160_6

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_7 = 14
				local var_160_8 = utf8.len(var_160_6)
				local var_160_9 = var_160_7 <= 0 and var_160_3 or var_160_3 * (var_160_8 / var_160_7)

				if var_160_9 > 0 and var_160_3 < var_160_9 then
					arg_157_1.talkMaxDuration = var_160_9

					if var_160_9 + var_160_2 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_9 + var_160_2
					end
				end

				arg_157_1.text_.text = var_160_6
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371038", "story_v_out_321371.awb") ~= 0 then
					local var_160_10 = manager.audio:GetVoiceLength("story_v_out_321371", "321371038", "story_v_out_321371.awb") / 1000

					if var_160_10 + var_160_2 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_10 + var_160_2
					end

					if var_160_5.prefab_name ~= "" and arg_157_1.actors_[var_160_5.prefab_name] ~= nil then
						local var_160_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_5.prefab_name].transform, "story_v_out_321371", "321371038", "story_v_out_321371.awb")

						arg_157_1:RecordAudio("321371038", var_160_11)
						arg_157_1:RecordAudio("321371038", var_160_11)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_321371", "321371038", "story_v_out_321371.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_321371", "321371038", "story_v_out_321371.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_12 = math.max(var_160_3, arg_157_1.talkMaxDuration)

			if var_160_2 <= arg_157_1.time_ and arg_157_1.time_ < var_160_2 + var_160_12 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_2) / var_160_12

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_2 + var_160_12 and arg_157_1.time_ < var_160_2 + var_160_12 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play321371039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 321371039
		arg_161_1.duration_ = 5

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play321371040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = arg_161_1.actors_["10131ui_story"].transform
			local var_164_1 = 0

			if var_164_1 < arg_161_1.time_ and arg_161_1.time_ <= var_164_1 + arg_164_0 then
				arg_161_1.var_.moveOldPos10131ui_story = var_164_0.localPosition
			end

			local var_164_2 = 0.001

			if var_164_1 <= arg_161_1.time_ and arg_161_1.time_ < var_164_1 + var_164_2 then
				local var_164_3 = (arg_161_1.time_ - var_164_1) / var_164_2
				local var_164_4 = Vector3.New(0, 100, 0)

				var_164_0.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos10131ui_story, var_164_4, var_164_3)

				local var_164_5 = manager.ui.mainCamera.transform.position - var_164_0.position

				var_164_0.forward = Vector3.New(var_164_5.x, var_164_5.y, var_164_5.z)

				local var_164_6 = var_164_0.localEulerAngles

				var_164_6.z = 0
				var_164_6.x = 0
				var_164_0.localEulerAngles = var_164_6
			end

			if arg_161_1.time_ >= var_164_1 + var_164_2 and arg_161_1.time_ < var_164_1 + var_164_2 + arg_164_0 then
				var_164_0.localPosition = Vector3.New(0, 100, 0)

				local var_164_7 = manager.ui.mainCamera.transform.position - var_164_0.position

				var_164_0.forward = Vector3.New(var_164_7.x, var_164_7.y, var_164_7.z)

				local var_164_8 = var_164_0.localEulerAngles

				var_164_8.z = 0
				var_164_8.x = 0
				var_164_0.localEulerAngles = var_164_8
			end

			local var_164_9 = arg_161_1.actors_["1111ui_story"].transform
			local var_164_10 = 0

			if var_164_10 < arg_161_1.time_ and arg_161_1.time_ <= var_164_10 + arg_164_0 then
				arg_161_1.var_.moveOldPos1111ui_story = var_164_9.localPosition
			end

			local var_164_11 = 0.001

			if var_164_10 <= arg_161_1.time_ and arg_161_1.time_ < var_164_10 + var_164_11 then
				local var_164_12 = (arg_161_1.time_ - var_164_10) / var_164_11
				local var_164_13 = Vector3.New(0, 100, 0)

				var_164_9.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos1111ui_story, var_164_13, var_164_12)

				local var_164_14 = manager.ui.mainCamera.transform.position - var_164_9.position

				var_164_9.forward = Vector3.New(var_164_14.x, var_164_14.y, var_164_14.z)

				local var_164_15 = var_164_9.localEulerAngles

				var_164_15.z = 0
				var_164_15.x = 0
				var_164_9.localEulerAngles = var_164_15
			end

			if arg_161_1.time_ >= var_164_10 + var_164_11 and arg_161_1.time_ < var_164_10 + var_164_11 + arg_164_0 then
				var_164_9.localPosition = Vector3.New(0, 100, 0)

				local var_164_16 = manager.ui.mainCamera.transform.position - var_164_9.position

				var_164_9.forward = Vector3.New(var_164_16.x, var_164_16.y, var_164_16.z)

				local var_164_17 = var_164_9.localEulerAngles

				var_164_17.z = 0
				var_164_17.x = 0
				var_164_9.localEulerAngles = var_164_17
			end

			local var_164_18 = arg_161_1.actors_["10131ui_story"]
			local var_164_19 = 0

			if var_164_19 < arg_161_1.time_ and arg_161_1.time_ <= var_164_19 + arg_164_0 and not isNil(var_164_18) and arg_161_1.var_.characterEffect10131ui_story == nil then
				arg_161_1.var_.characterEffect10131ui_story = var_164_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_20 = 0.200000002980232

			if var_164_19 <= arg_161_1.time_ and arg_161_1.time_ < var_164_19 + var_164_20 and not isNil(var_164_18) then
				local var_164_21 = (arg_161_1.time_ - var_164_19) / var_164_20

				if arg_161_1.var_.characterEffect10131ui_story and not isNil(var_164_18) then
					local var_164_22 = Mathf.Lerp(0, 0.5, var_164_21)

					arg_161_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_161_1.var_.characterEffect10131ui_story.fillRatio = var_164_22
				end
			end

			if arg_161_1.time_ >= var_164_19 + var_164_20 and arg_161_1.time_ < var_164_19 + var_164_20 + arg_164_0 and not isNil(var_164_18) and arg_161_1.var_.characterEffect10131ui_story then
				local var_164_23 = 0.5

				arg_161_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_161_1.var_.characterEffect10131ui_story.fillRatio = var_164_23
			end

			local var_164_24 = 0
			local var_164_25 = 0.925

			if var_164_24 < arg_161_1.time_ and arg_161_1.time_ <= var_164_24 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, false)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_26 = arg_161_1:GetWordFromCfg(321371039)
				local var_164_27 = arg_161_1:FormatText(var_164_26.content)

				arg_161_1.text_.text = var_164_27

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_28 = 37
				local var_164_29 = utf8.len(var_164_27)
				local var_164_30 = var_164_28 <= 0 and var_164_25 or var_164_25 * (var_164_29 / var_164_28)

				if var_164_30 > 0 and var_164_25 < var_164_30 then
					arg_161_1.talkMaxDuration = var_164_30

					if var_164_30 + var_164_24 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_30 + var_164_24
					end
				end

				arg_161_1.text_.text = var_164_27
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_31 = math.max(var_164_25, arg_161_1.talkMaxDuration)

			if var_164_24 <= arg_161_1.time_ and arg_161_1.time_ < var_164_24 + var_164_31 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_24) / var_164_31

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_24 + var_164_31 and arg_161_1.time_ < var_164_24 + var_164_31 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10131ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_161_1:InitPlayNodeList()
	end,
	Play321371040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 321371040
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play321371041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = 0.05
			local var_168_1 = 1

			if var_168_0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_0 + arg_168_0 then
				local var_168_2 = "play"
				local var_168_3 = "effect"

				arg_165_1:AudioAction(var_168_2, var_168_3, "se_story_141", "se_story_141_snake07", "")
			end

			local var_168_4 = 0
			local var_168_5 = 0.7

			if var_168_4 < arg_165_1.time_ and arg_165_1.time_ <= var_168_4 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, false)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_6 = arg_165_1:GetWordFromCfg(321371040)
				local var_168_7 = arg_165_1:FormatText(var_168_6.content)

				arg_165_1.text_.text = var_168_7

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_8 = 28
				local var_168_9 = utf8.len(var_168_7)
				local var_168_10 = var_168_8 <= 0 and var_168_5 or var_168_5 * (var_168_9 / var_168_8)

				if var_168_10 > 0 and var_168_5 < var_168_10 then
					arg_165_1.talkMaxDuration = var_168_10

					if var_168_10 + var_168_4 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_10 + var_168_4
					end
				end

				arg_165_1.text_.text = var_168_7
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)
				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_11 = math.max(var_168_5, arg_165_1.talkMaxDuration)

			if var_168_4 <= arg_165_1.time_ and arg_165_1.time_ < var_168_4 + var_168_11 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_4) / var_168_11

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_4 + var_168_11 and arg_165_1.time_ < var_168_4 + var_168_11 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play321371041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 321371041
		arg_169_1.duration_ = 6.23

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play321371042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = manager.ui.mainCamera.transform
			local var_172_1 = 0

			if var_172_1 < arg_169_1.time_ and arg_169_1.time_ <= var_172_1 + arg_172_0 then
				arg_169_1.var_.shakeOldPos = var_172_0.localPosition
			end

			local var_172_2 = 1

			if var_172_1 <= arg_169_1.time_ and arg_169_1.time_ < var_172_1 + var_172_2 then
				local var_172_3 = (arg_169_1.time_ - var_172_1) / 0.066
				local var_172_4, var_172_5 = math.modf(var_172_3)

				var_172_0.localPosition = Vector3.New(var_172_5 * 0.13, var_172_5 * 0.13, var_172_5 * 0.13) + arg_169_1.var_.shakeOldPos
			end

			if arg_169_1.time_ >= var_172_1 + var_172_2 and arg_169_1.time_ < var_172_1 + var_172_2 + arg_172_0 then
				var_172_0.localPosition = arg_169_1.var_.shakeOldPos
			end

			local var_172_6 = 0

			if var_172_6 < arg_169_1.time_ and arg_169_1.time_ <= var_172_6 + arg_172_0 then
				arg_169_1.allBtn_.enabled = false
			end

			local var_172_7 = 1.73333333333333

			if arg_169_1.time_ >= var_172_6 + var_172_7 and arg_169_1.time_ < var_172_6 + var_172_7 + arg_172_0 then
				arg_169_1.allBtn_.enabled = true
			end

			local var_172_8 = manager.ui.mainCamera.transform
			local var_172_9 = 0

			if var_172_9 < arg_169_1.time_ and arg_169_1.time_ <= var_172_9 + arg_172_0 then
				local var_172_10 = arg_169_1.var_.effectsuipianjingzhu1
				local var_172_11
				local var_172_12 = var_172_8

				if not var_172_10 then
					var_172_10 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_dust_1"), var_172_12)
					var_172_10.name = "suipianjingzhu1"
					arg_169_1.var_.effectsuipianjingzhu1 = var_172_10
				else
					var_172_10.transform:SetParent(var_172_12)
				end

				var_172_10.transform.localPosition = Vector3.New(0, 0, 0)
				var_172_10.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_172_13 = manager.ui.mainCamera.transform
			local var_172_14 = 1.5

			if var_172_14 < arg_169_1.time_ and arg_169_1.time_ <= var_172_14 + arg_172_0 then
				local var_172_15 = arg_169_1.var_.effectsuipianjingzhu1

				if var_172_15 then
					Object.Destroy(var_172_15)

					arg_169_1.var_.effectsuipianjingzhu1 = nil
				end
			end

			local var_172_16 = manager.ui.mainCamera.transform
			local var_172_17 = 0

			if var_172_17 < arg_169_1.time_ and arg_169_1.time_ <= var_172_17 + arg_172_0 then
				local var_172_18 = arg_169_1.var_.effect1041
				local var_172_19
				local var_172_20 = var_172_16

				if not var_172_18 then
					var_172_18 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_posui"), var_172_20)
					var_172_18.name = "1041"
					arg_169_1.var_.effect1041 = var_172_18
				else
					var_172_18.transform:SetParent(var_172_20)
				end

				var_172_18.transform.localPosition = Vector3.New(0, 0, 0)
				var_172_18.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_172_21 = manager.ui.mainCamera.transform
			local var_172_22 = 2.63333333333333

			if var_172_22 < arg_169_1.time_ and arg_169_1.time_ <= var_172_22 + arg_172_0 then
				local var_172_23 = arg_169_1.var_.effect1041

				if var_172_23 then
					Object.Destroy(var_172_23)

					arg_169_1.var_.effect1041 = nil
				end
			end

			local var_172_24 = 2.33333333333333
			local var_172_25 = 1

			if var_172_24 < arg_169_1.time_ and arg_169_1.time_ <= var_172_24 + arg_172_0 then
				local var_172_26 = "play"
				local var_172_27 = "effect"

				arg_169_1:AudioAction(var_172_26, var_172_27, "se_story_140", "se_story_140_scythe5", "")
			end

			local var_172_28 = 0.05
			local var_172_29 = 1

			if var_172_28 < arg_169_1.time_ and arg_169_1.time_ <= var_172_28 + arg_172_0 then
				local var_172_30 = "play"
				local var_172_31 = "effect"

				arg_169_1:AudioAction(var_172_30, var_172_31, "se_story_140", "se_story_140_glass", "")
			end

			if arg_169_1.frameCnt_ <= 1 then
				arg_169_1.dialog_:SetActive(false)
			end

			local var_172_32 = 1.23333333333333
			local var_172_33 = 1.4

			if var_172_32 < arg_169_1.time_ and arg_169_1.time_ <= var_172_32 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0

				arg_169_1.dialog_:SetActive(true)

				arg_169_1.dialogCg_.alpha = 0

				local var_172_34 = LeanTween.value(arg_169_1.dialog_, 0, 1, 0.3)

				var_172_34:setOnUpdate(LuaHelper.FloatAction(function(arg_173_0)
					arg_169_1.dialogCg_.alpha = arg_173_0
				end))
				var_172_34:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_169_1.dialog_)
					var_172_34:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_169_1.duration_ = arg_169_1.duration_ + 0.3

				SetActive(arg_169_1.leftNameGo_, false)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_35 = arg_169_1:GetWordFromCfg(321371041)
				local var_172_36 = arg_169_1:FormatText(var_172_35.content)

				arg_169_1.text_.text = var_172_36

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_37 = 56
				local var_172_38 = utf8.len(var_172_36)
				local var_172_39 = var_172_37 <= 0 and var_172_33 or var_172_33 * (var_172_38 / var_172_37)

				if var_172_39 > 0 and var_172_33 < var_172_39 then
					arg_169_1.talkMaxDuration = var_172_39
					var_172_32 = var_172_32 + 0.3

					if var_172_39 + var_172_32 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_39 + var_172_32
					end
				end

				arg_169_1.text_.text = var_172_36
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)
				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_40 = var_172_32 + 0.3
			local var_172_41 = math.max(var_172_33, arg_169_1.talkMaxDuration)

			if var_172_40 <= arg_169_1.time_ and arg_169_1.time_ < var_172_40 + var_172_41 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_40) / var_172_41

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_40 + var_172_41 and arg_169_1.time_ < var_172_40 + var_172_41 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play321371042 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 321371042
		arg_175_1.duration_ = 10.37

		local var_175_0 = {
			zh = 10.366,
			ja = 9.733
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
				arg_175_0:Play321371043(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = "ST0506a"

			if arg_175_1.bgs_[var_178_0] == nil then
				local var_178_1 = Object.Instantiate(arg_175_1.paintGo_)

				var_178_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_178_0)
				var_178_1.name = var_178_0
				var_178_1.transform.parent = arg_175_1.stage_.transform
				var_178_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_175_1.bgs_[var_178_0] = var_178_1
			end

			local var_178_2 = 2

			if var_178_2 < arg_175_1.time_ and arg_175_1.time_ <= var_178_2 + arg_178_0 then
				local var_178_3 = manager.ui.mainCamera.transform.localPosition
				local var_178_4 = Vector3.New(0, 0, 10) + Vector3.New(var_178_3.x, var_178_3.y, 0)
				local var_178_5 = arg_175_1.bgs_.ST0506a

				var_178_5.transform.localPosition = var_178_4
				var_178_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_178_6 = var_178_5:GetComponent("SpriteRenderer")

				if var_178_6 and var_178_6.sprite then
					local var_178_7 = (var_178_5.transform.localPosition - var_178_3).z
					local var_178_8 = manager.ui.mainCameraCom_
					local var_178_9 = 2 * var_178_7 * Mathf.Tan(var_178_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_178_10 = var_178_9 * var_178_8.aspect
					local var_178_11 = var_178_6.sprite.bounds.size.x
					local var_178_12 = var_178_6.sprite.bounds.size.y
					local var_178_13 = var_178_10 / var_178_11
					local var_178_14 = var_178_9 / var_178_12
					local var_178_15 = var_178_14 < var_178_13 and var_178_13 or var_178_14

					var_178_5.transform.localScale = Vector3.New(var_178_15, var_178_15, 0)
				end

				for iter_178_0, iter_178_1 in pairs(arg_175_1.bgs_) do
					if iter_178_0 ~= "ST0506a" then
						iter_178_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_178_16 = 4

			if var_178_16 < arg_175_1.time_ and arg_175_1.time_ <= var_178_16 + arg_178_0 then
				arg_175_1.allBtn_.enabled = false
			end

			local var_178_17 = 0.3

			if arg_175_1.time_ >= var_178_16 + var_178_17 and arg_175_1.time_ < var_178_16 + var_178_17 + arg_178_0 then
				arg_175_1.allBtn_.enabled = true
			end

			local var_178_18 = 0

			if var_178_18 < arg_175_1.time_ and arg_175_1.time_ <= var_178_18 + arg_178_0 then
				arg_175_1.mask_.enabled = true
				arg_175_1.mask_.raycastTarget = true

				arg_175_1:SetGaussion(false)
			end

			local var_178_19 = 2

			if var_178_18 <= arg_175_1.time_ and arg_175_1.time_ < var_178_18 + var_178_19 then
				local var_178_20 = (arg_175_1.time_ - var_178_18) / var_178_19
				local var_178_21 = Color.New(0, 0, 0)

				var_178_21.a = Mathf.Lerp(0, 1, var_178_20)
				arg_175_1.mask_.color = var_178_21
			end

			if arg_175_1.time_ >= var_178_18 + var_178_19 and arg_175_1.time_ < var_178_18 + var_178_19 + arg_178_0 then
				local var_178_22 = Color.New(0, 0, 0)

				var_178_22.a = 1
				arg_175_1.mask_.color = var_178_22
			end

			local var_178_23 = 2

			if var_178_23 < arg_175_1.time_ and arg_175_1.time_ <= var_178_23 + arg_178_0 then
				arg_175_1.mask_.enabled = true
				arg_175_1.mask_.raycastTarget = true

				arg_175_1:SetGaussion(false)
			end

			local var_178_24 = 2

			if var_178_23 <= arg_175_1.time_ and arg_175_1.time_ < var_178_23 + var_178_24 then
				local var_178_25 = (arg_175_1.time_ - var_178_23) / var_178_24
				local var_178_26 = Color.New(0, 0, 0)

				var_178_26.a = Mathf.Lerp(1, 0, var_178_25)
				arg_175_1.mask_.color = var_178_26
			end

			if arg_175_1.time_ >= var_178_23 + var_178_24 and arg_175_1.time_ < var_178_23 + var_178_24 + arg_178_0 then
				local var_178_27 = Color.New(0, 0, 0)
				local var_178_28 = 0

				arg_175_1.mask_.enabled = false
				var_178_27.a = var_178_28
				arg_175_1.mask_.color = var_178_27
			end

			if arg_175_1.frameCnt_ <= 1 then
				arg_175_1.dialog_:SetActive(false)
			end

			local var_178_29 = 4
			local var_178_30 = 0.425

			if var_178_29 < arg_175_1.time_ and arg_175_1.time_ <= var_178_29 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0

				arg_175_1.dialog_:SetActive(true)

				arg_175_1.dialogCg_.alpha = 0

				local var_178_31 = LeanTween.value(arg_175_1.dialog_, 0, 1, 0.3)

				var_178_31:setOnUpdate(LuaHelper.FloatAction(function(arg_179_0)
					arg_175_1.dialogCg_.alpha = arg_179_0
				end))
				var_178_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_175_1.dialog_)
					var_178_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_175_1.duration_ = arg_175_1.duration_ + 0.3

				SetActive(arg_175_1.leftNameGo_, true)

				local var_178_32 = arg_175_1:FormatText(StoryNameCfg[184].name)

				arg_175_1.leftNameTxt_.text = var_178_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, true)
				arg_175_1.iconController_:SetSelectedState("hero")

				arg_175_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_otis")

				arg_175_1.callingController_:SetSelectedState("normal")

				arg_175_1.keyicon_.color = Color.New(1, 1, 1)
				arg_175_1.icon_.color = Color.New(1, 1, 1)

				local var_178_33 = arg_175_1:GetWordFromCfg(321371042)
				local var_178_34 = arg_175_1:FormatText(var_178_33.content)

				arg_175_1.text_.text = var_178_34

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_35 = 17
				local var_178_36 = utf8.len(var_178_34)
				local var_178_37 = var_178_35 <= 0 and var_178_30 or var_178_30 * (var_178_36 / var_178_35)

				if var_178_37 > 0 and var_178_30 < var_178_37 then
					arg_175_1.talkMaxDuration = var_178_37
					var_178_29 = var_178_29 + 0.3

					if var_178_37 + var_178_29 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_37 + var_178_29
					end
				end

				arg_175_1.text_.text = var_178_34
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371042", "story_v_out_321371.awb") ~= 0 then
					local var_178_38 = manager.audio:GetVoiceLength("story_v_out_321371", "321371042", "story_v_out_321371.awb") / 1000

					if var_178_38 + var_178_29 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_38 + var_178_29
					end

					if var_178_33.prefab_name ~= "" and arg_175_1.actors_[var_178_33.prefab_name] ~= nil then
						local var_178_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_33.prefab_name].transform, "story_v_out_321371", "321371042", "story_v_out_321371.awb")

						arg_175_1:RecordAudio("321371042", var_178_39)
						arg_175_1:RecordAudio("321371042", var_178_39)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_321371", "321371042", "story_v_out_321371.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_321371", "321371042", "story_v_out_321371.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_40 = var_178_29 + 0.3
			local var_178_41 = math.max(var_178_30, arg_175_1.talkMaxDuration)

			if var_178_40 <= arg_175_1.time_ and arg_175_1.time_ < var_178_40 + var_178_41 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_40) / var_178_41

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_40 + var_178_41 and arg_175_1.time_ < var_178_40 + var_178_41 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play321371043 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 321371043
		arg_181_1.duration_ = 10.93

		local var_181_0 = {
			zh = 10.266,
			ja = 10.933
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
				arg_181_0:Play321371044(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = 0
			local var_184_1 = 0.85

			if var_184_0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_0 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				local var_184_2 = arg_181_1:FormatText(StoryNameCfg[184].name)

				arg_181_1.leftNameTxt_.text = var_184_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, true)
				arg_181_1.iconController_:SetSelectedState("hero")

				arg_181_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_otis")

				arg_181_1.callingController_:SetSelectedState("normal")

				arg_181_1.keyicon_.color = Color.New(1, 1, 1)
				arg_181_1.icon_.color = Color.New(1, 1, 1)

				local var_184_3 = arg_181_1:GetWordFromCfg(321371043)
				local var_184_4 = arg_181_1:FormatText(var_184_3.content)

				arg_181_1.text_.text = var_184_4

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_5 = 34
				local var_184_6 = utf8.len(var_184_4)
				local var_184_7 = var_184_5 <= 0 and var_184_1 or var_184_1 * (var_184_6 / var_184_5)

				if var_184_7 > 0 and var_184_1 < var_184_7 then
					arg_181_1.talkMaxDuration = var_184_7

					if var_184_7 + var_184_0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_7 + var_184_0
					end
				end

				arg_181_1.text_.text = var_184_4
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371043", "story_v_out_321371.awb") ~= 0 then
					local var_184_8 = manager.audio:GetVoiceLength("story_v_out_321371", "321371043", "story_v_out_321371.awb") / 1000

					if var_184_8 + var_184_0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_8 + var_184_0
					end

					if var_184_3.prefab_name ~= "" and arg_181_1.actors_[var_184_3.prefab_name] ~= nil then
						local var_184_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_3.prefab_name].transform, "story_v_out_321371", "321371043", "story_v_out_321371.awb")

						arg_181_1:RecordAudio("321371043", var_184_9)
						arg_181_1:RecordAudio("321371043", var_184_9)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_321371", "321371043", "story_v_out_321371.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_321371", "321371043", "story_v_out_321371.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_10 = math.max(var_184_1, arg_181_1.talkMaxDuration)

			if var_184_0 <= arg_181_1.time_ and arg_181_1.time_ < var_184_0 + var_184_10 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_0) / var_184_10

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_0 + var_184_10 and arg_181_1.time_ < var_184_0 + var_184_10 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play321371044 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 321371044
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play321371045(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 0.05
			local var_188_1 = 1

			if var_188_0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_0 + arg_188_0 then
				local var_188_2 = "play"
				local var_188_3 = "effect"

				arg_185_1:AudioAction(var_188_2, var_188_3, "se_story_140", "se_story_140_foley_chair", "")
			end

			local var_188_4 = 0
			local var_188_5 = 1

			if var_188_4 < arg_185_1.time_ and arg_185_1.time_ <= var_188_4 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, false)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_6 = arg_185_1:GetWordFromCfg(321371044)
				local var_188_7 = arg_185_1:FormatText(var_188_6.content)

				arg_185_1.text_.text = var_188_7

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_8 = 40
				local var_188_9 = utf8.len(var_188_7)
				local var_188_10 = var_188_8 <= 0 and var_188_5 or var_188_5 * (var_188_9 / var_188_8)

				if var_188_10 > 0 and var_188_5 < var_188_10 then
					arg_185_1.talkMaxDuration = var_188_10

					if var_188_10 + var_188_4 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_10 + var_188_4
					end
				end

				arg_185_1.text_.text = var_188_7
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_11 = math.max(var_188_5, arg_185_1.talkMaxDuration)

			if var_188_4 <= arg_185_1.time_ and arg_185_1.time_ < var_188_4 + var_188_11 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_4) / var_188_11

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_4 + var_188_11 and arg_185_1.time_ < var_188_4 + var_188_11 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play321371045 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 321371045
		arg_189_1.duration_ = 3

		local var_189_0 = {
			zh = 1.366,
			ja = 3
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
				arg_189_0:Play321371046(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = 0
			local var_192_1 = 0.15

			if var_192_0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_0 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				local var_192_2 = arg_189_1:FormatText(StoryNameCfg[1213].name)

				arg_189_1.leftNameTxt_.text = var_192_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, true)
				arg_189_1.iconController_:SetSelectedState("hero")

				arg_189_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Elizabeth")

				arg_189_1.callingController_:SetSelectedState("normal")

				arg_189_1.keyicon_.color = Color.New(1, 1, 1)
				arg_189_1.icon_.color = Color.New(1, 1, 1)

				local var_192_3 = arg_189_1:GetWordFromCfg(321371045)
				local var_192_4 = arg_189_1:FormatText(var_192_3.content)

				arg_189_1.text_.text = var_192_4

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_5 = 6
				local var_192_6 = utf8.len(var_192_4)
				local var_192_7 = var_192_5 <= 0 and var_192_1 or var_192_1 * (var_192_6 / var_192_5)

				if var_192_7 > 0 and var_192_1 < var_192_7 then
					arg_189_1.talkMaxDuration = var_192_7

					if var_192_7 + var_192_0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_7 + var_192_0
					end
				end

				arg_189_1.text_.text = var_192_4
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371045", "story_v_out_321371.awb") ~= 0 then
					local var_192_8 = manager.audio:GetVoiceLength("story_v_out_321371", "321371045", "story_v_out_321371.awb") / 1000

					if var_192_8 + var_192_0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_8 + var_192_0
					end

					if var_192_3.prefab_name ~= "" and arg_189_1.actors_[var_192_3.prefab_name] ~= nil then
						local var_192_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_3.prefab_name].transform, "story_v_out_321371", "321371045", "story_v_out_321371.awb")

						arg_189_1:RecordAudio("321371045", var_192_9)
						arg_189_1:RecordAudio("321371045", var_192_9)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_321371", "321371045", "story_v_out_321371.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_321371", "321371045", "story_v_out_321371.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_10 = math.max(var_192_1, arg_189_1.talkMaxDuration)

			if var_192_0 <= arg_189_1.time_ and arg_189_1.time_ < var_192_0 + var_192_10 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_0) / var_192_10

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_0 + var_192_10 and arg_189_1.time_ < var_192_0 + var_192_10 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play321371046 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 321371046
		arg_193_1.duration_ = 8.03

		local var_193_0 = {
			zh = 8.033,
			ja = 7.5
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
				arg_193_0:Play321371047(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = 0
			local var_196_1 = 0.65

			if var_196_0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_0 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				local var_196_2 = arg_193_1:FormatText(StoryNameCfg[184].name)

				arg_193_1.leftNameTxt_.text = var_196_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, true)
				arg_193_1.iconController_:SetSelectedState("hero")

				arg_193_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_otis")

				arg_193_1.callingController_:SetSelectedState("normal")

				arg_193_1.keyicon_.color = Color.New(1, 1, 1)
				arg_193_1.icon_.color = Color.New(1, 1, 1)

				local var_196_3 = arg_193_1:GetWordFromCfg(321371046)
				local var_196_4 = arg_193_1:FormatText(var_196_3.content)

				arg_193_1.text_.text = var_196_4

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_5 = 26
				local var_196_6 = utf8.len(var_196_4)
				local var_196_7 = var_196_5 <= 0 and var_196_1 or var_196_1 * (var_196_6 / var_196_5)

				if var_196_7 > 0 and var_196_1 < var_196_7 then
					arg_193_1.talkMaxDuration = var_196_7

					if var_196_7 + var_196_0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_7 + var_196_0
					end
				end

				arg_193_1.text_.text = var_196_4
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371046", "story_v_out_321371.awb") ~= 0 then
					local var_196_8 = manager.audio:GetVoiceLength("story_v_out_321371", "321371046", "story_v_out_321371.awb") / 1000

					if var_196_8 + var_196_0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_8 + var_196_0
					end

					if var_196_3.prefab_name ~= "" and arg_193_1.actors_[var_196_3.prefab_name] ~= nil then
						local var_196_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_3.prefab_name].transform, "story_v_out_321371", "321371046", "story_v_out_321371.awb")

						arg_193_1:RecordAudio("321371046", var_196_9)
						arg_193_1:RecordAudio("321371046", var_196_9)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_321371", "321371046", "story_v_out_321371.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_321371", "321371046", "story_v_out_321371.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_10 = math.max(var_196_1, arg_193_1.talkMaxDuration)

			if var_196_0 <= arg_193_1.time_ and arg_193_1.time_ < var_196_0 + var_196_10 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_0) / var_196_10

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_0 + var_196_10 and arg_193_1.time_ < var_196_0 + var_196_10 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play321371047 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 321371047
		arg_197_1.duration_ = 5.97

		local var_197_0 = {
			zh = 3.866,
			ja = 5.966
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
				arg_197_0:Play321371048(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = 0
			local var_200_1 = 0.375

			if var_200_0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_0 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				local var_200_2 = arg_197_1:FormatText(StoryNameCfg[184].name)

				arg_197_1.leftNameTxt_.text = var_200_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, true)
				arg_197_1.iconController_:SetSelectedState("hero")

				arg_197_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_otis")

				arg_197_1.callingController_:SetSelectedState("normal")

				arg_197_1.keyicon_.color = Color.New(1, 1, 1)
				arg_197_1.icon_.color = Color.New(1, 1, 1)

				local var_200_3 = arg_197_1:GetWordFromCfg(321371047)
				local var_200_4 = arg_197_1:FormatText(var_200_3.content)

				arg_197_1.text_.text = var_200_4

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_5 = 15
				local var_200_6 = utf8.len(var_200_4)
				local var_200_7 = var_200_5 <= 0 and var_200_1 or var_200_1 * (var_200_6 / var_200_5)

				if var_200_7 > 0 and var_200_1 < var_200_7 then
					arg_197_1.talkMaxDuration = var_200_7

					if var_200_7 + var_200_0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_7 + var_200_0
					end
				end

				arg_197_1.text_.text = var_200_4
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371047", "story_v_out_321371.awb") ~= 0 then
					local var_200_8 = manager.audio:GetVoiceLength("story_v_out_321371", "321371047", "story_v_out_321371.awb") / 1000

					if var_200_8 + var_200_0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_8 + var_200_0
					end

					if var_200_3.prefab_name ~= "" and arg_197_1.actors_[var_200_3.prefab_name] ~= nil then
						local var_200_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_3.prefab_name].transform, "story_v_out_321371", "321371047", "story_v_out_321371.awb")

						arg_197_1:RecordAudio("321371047", var_200_9)
						arg_197_1:RecordAudio("321371047", var_200_9)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_321371", "321371047", "story_v_out_321371.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_321371", "321371047", "story_v_out_321371.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_10 = math.max(var_200_1, arg_197_1.talkMaxDuration)

			if var_200_0 <= arg_197_1.time_ and arg_197_1.time_ < var_200_0 + var_200_10 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_0) / var_200_10

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_0 + var_200_10 and arg_197_1.time_ < var_200_0 + var_200_10 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play321371048 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 321371048
		arg_201_1.duration_ = 7.07

		local var_201_0 = {
			zh = 7.066,
			ja = 7.033
		}
		local var_201_1 = manager.audio:GetLocalizationFlag()

		if var_201_0[var_201_1] ~= nil then
			arg_201_1.duration_ = var_201_0[var_201_1]
		end

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play321371049(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = 0
			local var_204_1 = 0.625

			if var_204_0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_0 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				local var_204_2 = arg_201_1:FormatText(StoryNameCfg[184].name)

				arg_201_1.leftNameTxt_.text = var_204_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, true)
				arg_201_1.iconController_:SetSelectedState("hero")

				arg_201_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_otis")

				arg_201_1.callingController_:SetSelectedState("normal")

				arg_201_1.keyicon_.color = Color.New(1, 1, 1)
				arg_201_1.icon_.color = Color.New(1, 1, 1)

				local var_204_3 = arg_201_1:GetWordFromCfg(321371048)
				local var_204_4 = arg_201_1:FormatText(var_204_3.content)

				arg_201_1.text_.text = var_204_4

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_5 = 25
				local var_204_6 = utf8.len(var_204_4)
				local var_204_7 = var_204_5 <= 0 and var_204_1 or var_204_1 * (var_204_6 / var_204_5)

				if var_204_7 > 0 and var_204_1 < var_204_7 then
					arg_201_1.talkMaxDuration = var_204_7

					if var_204_7 + var_204_0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_7 + var_204_0
					end
				end

				arg_201_1.text_.text = var_204_4
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371048", "story_v_out_321371.awb") ~= 0 then
					local var_204_8 = manager.audio:GetVoiceLength("story_v_out_321371", "321371048", "story_v_out_321371.awb") / 1000

					if var_204_8 + var_204_0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_8 + var_204_0
					end

					if var_204_3.prefab_name ~= "" and arg_201_1.actors_[var_204_3.prefab_name] ~= nil then
						local var_204_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_3.prefab_name].transform, "story_v_out_321371", "321371048", "story_v_out_321371.awb")

						arg_201_1:RecordAudio("321371048", var_204_9)
						arg_201_1:RecordAudio("321371048", var_204_9)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_321371", "321371048", "story_v_out_321371.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_321371", "321371048", "story_v_out_321371.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_10 = math.max(var_204_1, arg_201_1.talkMaxDuration)

			if var_204_0 <= arg_201_1.time_ and arg_201_1.time_ < var_204_0 + var_204_10 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_0) / var_204_10

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_0 + var_204_10 and arg_201_1.time_ < var_204_0 + var_204_10 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play321371049 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 321371049
		arg_205_1.duration_ = 7.3

		local var_205_0 = {
			zh = 3,
			ja = 7.3
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
				arg_205_0:Play321371050(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = 0
			local var_208_1 = 0.325

			if var_208_0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_0 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				local var_208_2 = arg_205_1:FormatText(StoryNameCfg[1213].name)

				arg_205_1.leftNameTxt_.text = var_208_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, true)
				arg_205_1.iconController_:SetSelectedState("hero")

				arg_205_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Elizabeth")

				arg_205_1.callingController_:SetSelectedState("normal")

				arg_205_1.keyicon_.color = Color.New(1, 1, 1)
				arg_205_1.icon_.color = Color.New(1, 1, 1)

				local var_208_3 = arg_205_1:GetWordFromCfg(321371049)
				local var_208_4 = arg_205_1:FormatText(var_208_3.content)

				arg_205_1.text_.text = var_208_4

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_5 = 13
				local var_208_6 = utf8.len(var_208_4)
				local var_208_7 = var_208_5 <= 0 and var_208_1 or var_208_1 * (var_208_6 / var_208_5)

				if var_208_7 > 0 and var_208_1 < var_208_7 then
					arg_205_1.talkMaxDuration = var_208_7

					if var_208_7 + var_208_0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_7 + var_208_0
					end
				end

				arg_205_1.text_.text = var_208_4
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371049", "story_v_out_321371.awb") ~= 0 then
					local var_208_8 = manager.audio:GetVoiceLength("story_v_out_321371", "321371049", "story_v_out_321371.awb") / 1000

					if var_208_8 + var_208_0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_8 + var_208_0
					end

					if var_208_3.prefab_name ~= "" and arg_205_1.actors_[var_208_3.prefab_name] ~= nil then
						local var_208_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_3.prefab_name].transform, "story_v_out_321371", "321371049", "story_v_out_321371.awb")

						arg_205_1:RecordAudio("321371049", var_208_9)
						arg_205_1:RecordAudio("321371049", var_208_9)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_321371", "321371049", "story_v_out_321371.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_321371", "321371049", "story_v_out_321371.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_10 = math.max(var_208_1, arg_205_1.talkMaxDuration)

			if var_208_0 <= arg_205_1.time_ and arg_205_1.time_ < var_208_0 + var_208_10 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_0) / var_208_10

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_0 + var_208_10 and arg_205_1.time_ < var_208_0 + var_208_10 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play321371050 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 321371050
		arg_209_1.duration_ = 16.63

		local var_209_0 = {
			zh = 13.566,
			ja = 16.633
		}
		local var_209_1 = manager.audio:GetLocalizationFlag()

		if var_209_0[var_209_1] ~= nil then
			arg_209_1.duration_ = var_209_0[var_209_1]
		end

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play321371051(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = 0
			local var_212_1 = 0.95

			if var_212_0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_0 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				local var_212_2 = arg_209_1:FormatText(StoryNameCfg[184].name)

				arg_209_1.leftNameTxt_.text = var_212_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, true)
				arg_209_1.iconController_:SetSelectedState("hero")

				arg_209_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_otis")

				arg_209_1.callingController_:SetSelectedState("normal")

				arg_209_1.keyicon_.color = Color.New(1, 1, 1)
				arg_209_1.icon_.color = Color.New(1, 1, 1)

				local var_212_3 = arg_209_1:GetWordFromCfg(321371050)
				local var_212_4 = arg_209_1:FormatText(var_212_3.content)

				arg_209_1.text_.text = var_212_4

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_5 = 38
				local var_212_6 = utf8.len(var_212_4)
				local var_212_7 = var_212_5 <= 0 and var_212_1 or var_212_1 * (var_212_6 / var_212_5)

				if var_212_7 > 0 and var_212_1 < var_212_7 then
					arg_209_1.talkMaxDuration = var_212_7

					if var_212_7 + var_212_0 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_7 + var_212_0
					end
				end

				arg_209_1.text_.text = var_212_4
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371050", "story_v_out_321371.awb") ~= 0 then
					local var_212_8 = manager.audio:GetVoiceLength("story_v_out_321371", "321371050", "story_v_out_321371.awb") / 1000

					if var_212_8 + var_212_0 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_8 + var_212_0
					end

					if var_212_3.prefab_name ~= "" and arg_209_1.actors_[var_212_3.prefab_name] ~= nil then
						local var_212_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_3.prefab_name].transform, "story_v_out_321371", "321371050", "story_v_out_321371.awb")

						arg_209_1:RecordAudio("321371050", var_212_9)
						arg_209_1:RecordAudio("321371050", var_212_9)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_321371", "321371050", "story_v_out_321371.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_321371", "321371050", "story_v_out_321371.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_10 = math.max(var_212_1, arg_209_1.talkMaxDuration)

			if var_212_0 <= arg_209_1.time_ and arg_209_1.time_ < var_212_0 + var_212_10 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_0) / var_212_10

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_0 + var_212_10 and arg_209_1.time_ < var_212_0 + var_212_10 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play321371051 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 321371051
		arg_213_1.duration_ = 14.53

		local var_213_0 = {
			zh = 10.066,
			ja = 14.533
		}
		local var_213_1 = manager.audio:GetLocalizationFlag()

		if var_213_0[var_213_1] ~= nil then
			arg_213_1.duration_ = var_213_0[var_213_1]
		end

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play321371052(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = 0
			local var_216_1 = 0.725

			if var_216_0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_0 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				local var_216_2 = arg_213_1:FormatText(StoryNameCfg[184].name)

				arg_213_1.leftNameTxt_.text = var_216_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, true)
				arg_213_1.iconController_:SetSelectedState("hero")

				arg_213_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_otis")

				arg_213_1.callingController_:SetSelectedState("normal")

				arg_213_1.keyicon_.color = Color.New(1, 1, 1)
				arg_213_1.icon_.color = Color.New(1, 1, 1)

				local var_216_3 = arg_213_1:GetWordFromCfg(321371051)
				local var_216_4 = arg_213_1:FormatText(var_216_3.content)

				arg_213_1.text_.text = var_216_4

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_5 = 29
				local var_216_6 = utf8.len(var_216_4)
				local var_216_7 = var_216_5 <= 0 and var_216_1 or var_216_1 * (var_216_6 / var_216_5)

				if var_216_7 > 0 and var_216_1 < var_216_7 then
					arg_213_1.talkMaxDuration = var_216_7

					if var_216_7 + var_216_0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_7 + var_216_0
					end
				end

				arg_213_1.text_.text = var_216_4
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371051", "story_v_out_321371.awb") ~= 0 then
					local var_216_8 = manager.audio:GetVoiceLength("story_v_out_321371", "321371051", "story_v_out_321371.awb") / 1000

					if var_216_8 + var_216_0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_8 + var_216_0
					end

					if var_216_3.prefab_name ~= "" and arg_213_1.actors_[var_216_3.prefab_name] ~= nil then
						local var_216_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_3.prefab_name].transform, "story_v_out_321371", "321371051", "story_v_out_321371.awb")

						arg_213_1:RecordAudio("321371051", var_216_9)
						arg_213_1:RecordAudio("321371051", var_216_9)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_321371", "321371051", "story_v_out_321371.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_321371", "321371051", "story_v_out_321371.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_10 = math.max(var_216_1, arg_213_1.talkMaxDuration)

			if var_216_0 <= arg_213_1.time_ and arg_213_1.time_ < var_216_0 + var_216_10 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_0) / var_216_10

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_0 + var_216_10 and arg_213_1.time_ < var_216_0 + var_216_10 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play321371052 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 321371052
		arg_217_1.duration_ = 11.67

		local var_217_0 = {
			zh = 11.666,
			ja = 11
		}
		local var_217_1 = manager.audio:GetLocalizationFlag()

		if var_217_0[var_217_1] ~= nil then
			arg_217_1.duration_ = var_217_0[var_217_1]
		end

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play321371053(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = 0
			local var_220_1 = 0.825

			if var_220_0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_0 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				local var_220_2 = arg_217_1:FormatText(StoryNameCfg[184].name)

				arg_217_1.leftNameTxt_.text = var_220_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, true)
				arg_217_1.iconController_:SetSelectedState("hero")

				arg_217_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_otis")

				arg_217_1.callingController_:SetSelectedState("normal")

				arg_217_1.keyicon_.color = Color.New(1, 1, 1)
				arg_217_1.icon_.color = Color.New(1, 1, 1)

				local var_220_3 = arg_217_1:GetWordFromCfg(321371052)
				local var_220_4 = arg_217_1:FormatText(var_220_3.content)

				arg_217_1.text_.text = var_220_4

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_5 = 33
				local var_220_6 = utf8.len(var_220_4)
				local var_220_7 = var_220_5 <= 0 and var_220_1 or var_220_1 * (var_220_6 / var_220_5)

				if var_220_7 > 0 and var_220_1 < var_220_7 then
					arg_217_1.talkMaxDuration = var_220_7

					if var_220_7 + var_220_0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_7 + var_220_0
					end
				end

				arg_217_1.text_.text = var_220_4
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371052", "story_v_out_321371.awb") ~= 0 then
					local var_220_8 = manager.audio:GetVoiceLength("story_v_out_321371", "321371052", "story_v_out_321371.awb") / 1000

					if var_220_8 + var_220_0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_8 + var_220_0
					end

					if var_220_3.prefab_name ~= "" and arg_217_1.actors_[var_220_3.prefab_name] ~= nil then
						local var_220_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_3.prefab_name].transform, "story_v_out_321371", "321371052", "story_v_out_321371.awb")

						arg_217_1:RecordAudio("321371052", var_220_9)
						arg_217_1:RecordAudio("321371052", var_220_9)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_321371", "321371052", "story_v_out_321371.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_321371", "321371052", "story_v_out_321371.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_10 = math.max(var_220_1, arg_217_1.talkMaxDuration)

			if var_220_0 <= arg_217_1.time_ and arg_217_1.time_ < var_220_0 + var_220_10 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_0) / var_220_10

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_0 + var_220_10 and arg_217_1.time_ < var_220_0 + var_220_10 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play321371053 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 321371053
		arg_221_1.duration_ = 5.67

		local var_221_0 = {
			zh = 5.666,
			ja = 5.433
		}
		local var_221_1 = manager.audio:GetLocalizationFlag()

		if var_221_0[var_221_1] ~= nil then
			arg_221_1.duration_ = var_221_0[var_221_1]
		end

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play321371054(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = 0
			local var_224_1 = 0.425

			if var_224_0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_0 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				local var_224_2 = arg_221_1:FormatText(StoryNameCfg[184].name)

				arg_221_1.leftNameTxt_.text = var_224_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, true)
				arg_221_1.iconController_:SetSelectedState("hero")

				arg_221_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_otis")

				arg_221_1.callingController_:SetSelectedState("normal")

				arg_221_1.keyicon_.color = Color.New(1, 1, 1)
				arg_221_1.icon_.color = Color.New(1, 1, 1)

				local var_224_3 = arg_221_1:GetWordFromCfg(321371053)
				local var_224_4 = arg_221_1:FormatText(var_224_3.content)

				arg_221_1.text_.text = var_224_4

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_5 = 17
				local var_224_6 = utf8.len(var_224_4)
				local var_224_7 = var_224_5 <= 0 and var_224_1 or var_224_1 * (var_224_6 / var_224_5)

				if var_224_7 > 0 and var_224_1 < var_224_7 then
					arg_221_1.talkMaxDuration = var_224_7

					if var_224_7 + var_224_0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_7 + var_224_0
					end
				end

				arg_221_1.text_.text = var_224_4
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371053", "story_v_out_321371.awb") ~= 0 then
					local var_224_8 = manager.audio:GetVoiceLength("story_v_out_321371", "321371053", "story_v_out_321371.awb") / 1000

					if var_224_8 + var_224_0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_8 + var_224_0
					end

					if var_224_3.prefab_name ~= "" and arg_221_1.actors_[var_224_3.prefab_name] ~= nil then
						local var_224_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_3.prefab_name].transform, "story_v_out_321371", "321371053", "story_v_out_321371.awb")

						arg_221_1:RecordAudio("321371053", var_224_9)
						arg_221_1:RecordAudio("321371053", var_224_9)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_321371", "321371053", "story_v_out_321371.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_321371", "321371053", "story_v_out_321371.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_10 = math.max(var_224_1, arg_221_1.talkMaxDuration)

			if var_224_0 <= arg_221_1.time_ and arg_221_1.time_ < var_224_0 + var_224_10 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_0) / var_224_10

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_0 + var_224_10 and arg_221_1.time_ < var_224_0 + var_224_10 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play321371054 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 321371054
		arg_225_1.duration_ = 4.6

		local var_225_0 = {
			zh = 4.6,
			ja = 1.533
		}
		local var_225_1 = manager.audio:GetLocalizationFlag()

		if var_225_0[var_225_1] ~= nil then
			arg_225_1.duration_ = var_225_0[var_225_1]
		end

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play321371055(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = 0
			local var_228_1 = 0.175

			if var_228_0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_0 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				local var_228_2 = arg_225_1:FormatText(StoryNameCfg[184].name)

				arg_225_1.leftNameTxt_.text = var_228_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, true)
				arg_225_1.iconController_:SetSelectedState("hero")

				arg_225_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_otis")

				arg_225_1.callingController_:SetSelectedState("normal")

				arg_225_1.keyicon_.color = Color.New(1, 1, 1)
				arg_225_1.icon_.color = Color.New(1, 1, 1)

				local var_228_3 = arg_225_1:GetWordFromCfg(321371054)
				local var_228_4 = arg_225_1:FormatText(var_228_3.content)

				arg_225_1.text_.text = var_228_4

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_5 = 7
				local var_228_6 = utf8.len(var_228_4)
				local var_228_7 = var_228_5 <= 0 and var_228_1 or var_228_1 * (var_228_6 / var_228_5)

				if var_228_7 > 0 and var_228_1 < var_228_7 then
					arg_225_1.talkMaxDuration = var_228_7

					if var_228_7 + var_228_0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_7 + var_228_0
					end
				end

				arg_225_1.text_.text = var_228_4
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371054", "story_v_out_321371.awb") ~= 0 then
					local var_228_8 = manager.audio:GetVoiceLength("story_v_out_321371", "321371054", "story_v_out_321371.awb") / 1000

					if var_228_8 + var_228_0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_8 + var_228_0
					end

					if var_228_3.prefab_name ~= "" and arg_225_1.actors_[var_228_3.prefab_name] ~= nil then
						local var_228_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_3.prefab_name].transform, "story_v_out_321371", "321371054", "story_v_out_321371.awb")

						arg_225_1:RecordAudio("321371054", var_228_9)
						arg_225_1:RecordAudio("321371054", var_228_9)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_321371", "321371054", "story_v_out_321371.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_321371", "321371054", "story_v_out_321371.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_10 = math.max(var_228_1, arg_225_1.talkMaxDuration)

			if var_228_0 <= arg_225_1.time_ and arg_225_1.time_ < var_228_0 + var_228_10 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_0) / var_228_10

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_0 + var_228_10 and arg_225_1.time_ < var_228_0 + var_228_10 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play321371055 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 321371055
		arg_229_1.duration_ = 5

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play321371056(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = 0.433333333333333
			local var_232_1 = 1

			if var_232_0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_0 + arg_232_0 then
				local var_232_2 = "play"
				local var_232_3 = "effect"

				arg_229_1:AudioAction(var_232_2, var_232_3, "se_story_141", "se_story_141_footstep_back", "")
			end

			local var_232_4 = 0
			local var_232_5 = 1.6

			if var_232_4 < arg_229_1.time_ and arg_229_1.time_ <= var_232_4 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, false)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_6 = arg_229_1:GetWordFromCfg(321371055)
				local var_232_7 = arg_229_1:FormatText(var_232_6.content)

				arg_229_1.text_.text = var_232_7

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_8 = 64
				local var_232_9 = utf8.len(var_232_7)
				local var_232_10 = var_232_8 <= 0 and var_232_5 or var_232_5 * (var_232_9 / var_232_8)

				if var_232_10 > 0 and var_232_5 < var_232_10 then
					arg_229_1.talkMaxDuration = var_232_10

					if var_232_10 + var_232_4 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_10 + var_232_4
					end
				end

				arg_229_1.text_.text = var_232_7
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)
				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_11 = math.max(var_232_5, arg_229_1.talkMaxDuration)

			if var_232_4 <= arg_229_1.time_ and arg_229_1.time_ < var_232_4 + var_232_11 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_4) / var_232_11

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_4 + var_232_11 and arg_229_1.time_ < var_232_4 + var_232_11 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play321371056 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 321371056
		arg_233_1.duration_ = 3.33

		local var_233_0 = {
			zh = 1.7,
			ja = 3.333
		}
		local var_233_1 = manager.audio:GetLocalizationFlag()

		if var_233_0[var_233_1] ~= nil then
			arg_233_1.duration_ = var_233_0[var_233_1]
		end

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play321371057(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = 0
			local var_236_1 = 0.15

			if var_236_0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_0 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				local var_236_2 = arg_233_1:FormatText(StoryNameCfg[1213].name)

				arg_233_1.leftNameTxt_.text = var_236_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, true)
				arg_233_1.iconController_:SetSelectedState("hero")

				arg_233_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Elizabeth")

				arg_233_1.callingController_:SetSelectedState("normal")

				arg_233_1.keyicon_.color = Color.New(1, 1, 1)
				arg_233_1.icon_.color = Color.New(1, 1, 1)

				local var_236_3 = arg_233_1:GetWordFromCfg(321371056)
				local var_236_4 = arg_233_1:FormatText(var_236_3.content)

				arg_233_1.text_.text = var_236_4

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_5 = 6
				local var_236_6 = utf8.len(var_236_4)
				local var_236_7 = var_236_5 <= 0 and var_236_1 or var_236_1 * (var_236_6 / var_236_5)

				if var_236_7 > 0 and var_236_1 < var_236_7 then
					arg_233_1.talkMaxDuration = var_236_7

					if var_236_7 + var_236_0 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_7 + var_236_0
					end
				end

				arg_233_1.text_.text = var_236_4
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371056", "story_v_out_321371.awb") ~= 0 then
					local var_236_8 = manager.audio:GetVoiceLength("story_v_out_321371", "321371056", "story_v_out_321371.awb") / 1000

					if var_236_8 + var_236_0 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_8 + var_236_0
					end

					if var_236_3.prefab_name ~= "" and arg_233_1.actors_[var_236_3.prefab_name] ~= nil then
						local var_236_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_3.prefab_name].transform, "story_v_out_321371", "321371056", "story_v_out_321371.awb")

						arg_233_1:RecordAudio("321371056", var_236_9)
						arg_233_1:RecordAudio("321371056", var_236_9)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_321371", "321371056", "story_v_out_321371.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_321371", "321371056", "story_v_out_321371.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_10 = math.max(var_236_1, arg_233_1.talkMaxDuration)

			if var_236_0 <= arg_233_1.time_ and arg_233_1.time_ < var_236_0 + var_236_10 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_0) / var_236_10

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_0 + var_236_10 and arg_233_1.time_ < var_236_0 + var_236_10 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play321371057 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 321371057
		arg_237_1.duration_ = 2

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play321371058(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = "1037ui_story"

			if arg_237_1.actors_[var_240_0] == nil then
				local var_240_1 = Asset.Load("Char/" .. "1037ui_story")

				if not isNil(var_240_1) then
					local var_240_2 = Object.Instantiate(Asset.Load("Char/" .. "1037ui_story"), arg_237_1.stage_.transform)

					var_240_2.name = var_240_0
					var_240_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_237_1.actors_[var_240_0] = var_240_2

					local var_240_3 = var_240_2:GetComponentInChildren(typeof(CharacterEffect))

					var_240_3.enabled = true

					local var_240_4 = GameObjectTools.GetOrAddComponent(var_240_2, typeof(DynamicBoneHelper))

					if var_240_4 then
						var_240_4:EnableDynamicBone(false)
					end

					arg_237_1:ShowWeapon(var_240_3.transform, false)

					arg_237_1.var_[var_240_0 .. "Animator"] = var_240_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_237_1.var_[var_240_0 .. "Animator"].applyRootMotion = true
					arg_237_1.var_[var_240_0 .. "LipSync"] = var_240_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_240_5 = arg_237_1.actors_["1037ui_story"]
			local var_240_6 = 0

			if var_240_6 < arg_237_1.time_ and arg_237_1.time_ <= var_240_6 + arg_240_0 and not isNil(var_240_5) and arg_237_1.var_.characterEffect1037ui_story == nil then
				arg_237_1.var_.characterEffect1037ui_story = var_240_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_7 = 0.200000002980232

			if var_240_6 <= arg_237_1.time_ and arg_237_1.time_ < var_240_6 + var_240_7 and not isNil(var_240_5) then
				local var_240_8 = (arg_237_1.time_ - var_240_6) / var_240_7

				if arg_237_1.var_.characterEffect1037ui_story and not isNil(var_240_5) then
					arg_237_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_237_1.time_ >= var_240_6 + var_240_7 and arg_237_1.time_ < var_240_6 + var_240_7 + arg_240_0 and not isNil(var_240_5) and arg_237_1.var_.characterEffect1037ui_story then
				arg_237_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_240_9 = "1043ui_story"

			if arg_237_1.actors_[var_240_9] == nil then
				local var_240_10 = Asset.Load("Char/" .. "1043ui_story")

				if not isNil(var_240_10) then
					local var_240_11 = Object.Instantiate(Asset.Load("Char/" .. "1043ui_story"), arg_237_1.stage_.transform)

					var_240_11.name = var_240_9
					var_240_11.transform.localPosition = Vector3.New(0, 100, 0)
					arg_237_1.actors_[var_240_9] = var_240_11

					local var_240_12 = var_240_11:GetComponentInChildren(typeof(CharacterEffect))

					var_240_12.enabled = true

					local var_240_13 = GameObjectTools.GetOrAddComponent(var_240_11, typeof(DynamicBoneHelper))

					if var_240_13 then
						var_240_13:EnableDynamicBone(false)
					end

					arg_237_1:ShowWeapon(var_240_12.transform, false)

					arg_237_1.var_[var_240_9 .. "Animator"] = var_240_12.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_237_1.var_[var_240_9 .. "Animator"].applyRootMotion = true
					arg_237_1.var_[var_240_9 .. "LipSync"] = var_240_12.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_240_14 = arg_237_1.actors_["1043ui_story"].transform
			local var_240_15 = 0

			if var_240_15 < arg_237_1.time_ and arg_237_1.time_ <= var_240_15 + arg_240_0 then
				arg_237_1.var_.moveOldPos1043ui_story = var_240_14.localPosition
			end

			local var_240_16 = 0.001

			if var_240_15 <= arg_237_1.time_ and arg_237_1.time_ < var_240_15 + var_240_16 then
				local var_240_17 = (arg_237_1.time_ - var_240_15) / var_240_16
				local var_240_18 = Vector3.New(0.01, -1.01, -5.73)

				var_240_14.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPos1043ui_story, var_240_18, var_240_17)

				local var_240_19 = manager.ui.mainCamera.transform.position - var_240_14.position

				var_240_14.forward = Vector3.New(var_240_19.x, var_240_19.y, var_240_19.z)

				local var_240_20 = var_240_14.localEulerAngles

				var_240_20.z = 0
				var_240_20.x = 0
				var_240_14.localEulerAngles = var_240_20
			end

			if arg_237_1.time_ >= var_240_15 + var_240_16 and arg_237_1.time_ < var_240_15 + var_240_16 + arg_240_0 then
				var_240_14.localPosition = Vector3.New(0.01, -1.01, -5.73)

				local var_240_21 = manager.ui.mainCamera.transform.position - var_240_14.position

				var_240_14.forward = Vector3.New(var_240_21.x, var_240_21.y, var_240_21.z)

				local var_240_22 = var_240_14.localEulerAngles

				var_240_22.z = 0
				var_240_22.x = 0
				var_240_14.localEulerAngles = var_240_22
			end

			local var_240_23 = 0

			if var_240_23 < arg_237_1.time_ and arg_237_1.time_ <= var_240_23 + arg_240_0 then
				arg_237_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action1_1")
			end

			local var_240_24 = 0
			local var_240_25 = 0.05

			if var_240_24 < arg_237_1.time_ and arg_237_1.time_ <= var_240_24 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				local var_240_26 = arg_237_1:FormatText(StoryNameCfg[1156].name)

				arg_237_1.leftNameTxt_.text = var_240_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_27 = arg_237_1:GetWordFromCfg(321371057)
				local var_240_28 = arg_237_1:FormatText(var_240_27.content)

				arg_237_1.text_.text = var_240_28

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_29 = 2
				local var_240_30 = utf8.len(var_240_28)
				local var_240_31 = var_240_29 <= 0 and var_240_25 or var_240_25 * (var_240_30 / var_240_29)

				if var_240_31 > 0 and var_240_25 < var_240_31 then
					arg_237_1.talkMaxDuration = var_240_31

					if var_240_31 + var_240_24 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_31 + var_240_24
					end
				end

				arg_237_1.text_.text = var_240_28
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371057", "story_v_out_321371.awb") ~= 0 then
					local var_240_32 = manager.audio:GetVoiceLength("story_v_out_321371", "321371057", "story_v_out_321371.awb") / 1000

					if var_240_32 + var_240_24 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_32 + var_240_24
					end

					if var_240_27.prefab_name ~= "" and arg_237_1.actors_[var_240_27.prefab_name] ~= nil then
						local var_240_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_27.prefab_name].transform, "story_v_out_321371", "321371057", "story_v_out_321371.awb")

						arg_237_1:RecordAudio("321371057", var_240_33)
						arg_237_1:RecordAudio("321371057", var_240_33)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_out_321371", "321371057", "story_v_out_321371.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_out_321371", "321371057", "story_v_out_321371.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_34 = math.max(var_240_25, arg_237_1.talkMaxDuration)

			if var_240_24 <= arg_237_1.time_ and arg_237_1.time_ < var_240_24 + var_240_34 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_24) / var_240_34

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_24 + var_240_34 and arg_237_1.time_ < var_240_24 + var_240_34 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_237_1:InitPlayNodeList()
	end,
	Play321371058 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 321371058
		arg_241_1.duration_ = 5.63

		local var_241_0 = {
			zh = 4.7,
			ja = 5.633
		}
		local var_241_1 = manager.audio:GetLocalizationFlag()

		if var_241_0[var_241_1] ~= nil then
			arg_241_1.duration_ = var_241_0[var_241_1]
		end

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play321371059(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = arg_241_1.actors_["1037ui_story"]
			local var_244_1 = 0

			if var_244_1 < arg_241_1.time_ and arg_241_1.time_ <= var_244_1 + arg_244_0 and not isNil(var_244_0) and arg_241_1.var_.characterEffect1037ui_story == nil then
				arg_241_1.var_.characterEffect1037ui_story = var_244_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_2 = 0.200000002980232

			if var_244_1 <= arg_241_1.time_ and arg_241_1.time_ < var_244_1 + var_244_2 and not isNil(var_244_0) then
				local var_244_3 = (arg_241_1.time_ - var_244_1) / var_244_2

				if arg_241_1.var_.characterEffect1037ui_story and not isNil(var_244_0) then
					local var_244_4 = Mathf.Lerp(0, 0.5, var_244_3)

					arg_241_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_241_1.var_.characterEffect1037ui_story.fillRatio = var_244_4
				end
			end

			if arg_241_1.time_ >= var_244_1 + var_244_2 and arg_241_1.time_ < var_244_1 + var_244_2 + arg_244_0 and not isNil(var_244_0) and arg_241_1.var_.characterEffect1037ui_story then
				local var_244_5 = 0.5

				arg_241_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_241_1.var_.characterEffect1037ui_story.fillRatio = var_244_5
			end

			local var_244_6 = arg_241_1.actors_["1043ui_story"].transform
			local var_244_7 = 0

			if var_244_7 < arg_241_1.time_ and arg_241_1.time_ <= var_244_7 + arg_244_0 then
				arg_241_1.var_.moveOldPos1043ui_story = var_244_6.localPosition
			end

			local var_244_8 = 0.001

			if var_244_7 <= arg_241_1.time_ and arg_241_1.time_ < var_244_7 + var_244_8 then
				local var_244_9 = (arg_241_1.time_ - var_244_7) / var_244_8
				local var_244_10 = Vector3.New(0, 100, 0)

				var_244_6.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos1043ui_story, var_244_10, var_244_9)

				local var_244_11 = manager.ui.mainCamera.transform.position - var_244_6.position

				var_244_6.forward = Vector3.New(var_244_11.x, var_244_11.y, var_244_11.z)

				local var_244_12 = var_244_6.localEulerAngles

				var_244_12.z = 0
				var_244_12.x = 0
				var_244_6.localEulerAngles = var_244_12
			end

			if arg_241_1.time_ >= var_244_7 + var_244_8 and arg_241_1.time_ < var_244_7 + var_244_8 + arg_244_0 then
				var_244_6.localPosition = Vector3.New(0, 100, 0)

				local var_244_13 = manager.ui.mainCamera.transform.position - var_244_6.position

				var_244_6.forward = Vector3.New(var_244_13.x, var_244_13.y, var_244_13.z)

				local var_244_14 = var_244_6.localEulerAngles

				var_244_14.z = 0
				var_244_14.x = 0
				var_244_6.localEulerAngles = var_244_14
			end

			local var_244_15 = 0
			local var_244_16 = 0.3

			if var_244_15 < arg_241_1.time_ and arg_241_1.time_ <= var_244_15 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				local var_244_17 = arg_241_1:FormatText(StoryNameCfg[184].name)

				arg_241_1.leftNameTxt_.text = var_244_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, true)
				arg_241_1.iconController_:SetSelectedState("hero")

				arg_241_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_otis")

				arg_241_1.callingController_:SetSelectedState("normal")

				arg_241_1.keyicon_.color = Color.New(1, 1, 1)
				arg_241_1.icon_.color = Color.New(1, 1, 1)

				local var_244_18 = arg_241_1:GetWordFromCfg(321371058)
				local var_244_19 = arg_241_1:FormatText(var_244_18.content)

				arg_241_1.text_.text = var_244_19

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_20 = 12
				local var_244_21 = utf8.len(var_244_19)
				local var_244_22 = var_244_20 <= 0 and var_244_16 or var_244_16 * (var_244_21 / var_244_20)

				if var_244_22 > 0 and var_244_16 < var_244_22 then
					arg_241_1.talkMaxDuration = var_244_22

					if var_244_22 + var_244_15 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_22 + var_244_15
					end
				end

				arg_241_1.text_.text = var_244_19
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371058", "story_v_out_321371.awb") ~= 0 then
					local var_244_23 = manager.audio:GetVoiceLength("story_v_out_321371", "321371058", "story_v_out_321371.awb") / 1000

					if var_244_23 + var_244_15 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_23 + var_244_15
					end

					if var_244_18.prefab_name ~= "" and arg_241_1.actors_[var_244_18.prefab_name] ~= nil then
						local var_244_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_18.prefab_name].transform, "story_v_out_321371", "321371058", "story_v_out_321371.awb")

						arg_241_1:RecordAudio("321371058", var_244_24)
						arg_241_1:RecordAudio("321371058", var_244_24)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_321371", "321371058", "story_v_out_321371.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_321371", "321371058", "story_v_out_321371.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_25 = math.max(var_244_16, arg_241_1.talkMaxDuration)

			if var_244_15 <= arg_241_1.time_ and arg_241_1.time_ < var_244_15 + var_244_25 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_15) / var_244_25

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_15 + var_244_25 and arg_241_1.time_ < var_244_15 + var_244_25 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_241_1:InitPlayNodeList()
	end,
	Play321371059 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 321371059
		arg_245_1.duration_ = 6.57

		local var_245_0 = {
			zh = 4.066,
			ja = 6.566
		}
		local var_245_1 = manager.audio:GetLocalizationFlag()

		if var_245_0[var_245_1] ~= nil then
			arg_245_1.duration_ = var_245_0[var_245_1]
		end

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play321371060(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = 0
			local var_248_1 = 0.425

			if var_248_0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_0 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				local var_248_2 = arg_245_1:FormatText(StoryNameCfg[1213].name)

				arg_245_1.leftNameTxt_.text = var_248_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, true)
				arg_245_1.iconController_:SetSelectedState("hero")

				arg_245_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Elizabeth")

				arg_245_1.callingController_:SetSelectedState("normal")

				arg_245_1.keyicon_.color = Color.New(1, 1, 1)
				arg_245_1.icon_.color = Color.New(1, 1, 1)

				local var_248_3 = arg_245_1:GetWordFromCfg(321371059)
				local var_248_4 = arg_245_1:FormatText(var_248_3.content)

				arg_245_1.text_.text = var_248_4

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_5 = 17
				local var_248_6 = utf8.len(var_248_4)
				local var_248_7 = var_248_5 <= 0 and var_248_1 or var_248_1 * (var_248_6 / var_248_5)

				if var_248_7 > 0 and var_248_1 < var_248_7 then
					arg_245_1.talkMaxDuration = var_248_7

					if var_248_7 + var_248_0 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_7 + var_248_0
					end
				end

				arg_245_1.text_.text = var_248_4
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371059", "story_v_out_321371.awb") ~= 0 then
					local var_248_8 = manager.audio:GetVoiceLength("story_v_out_321371", "321371059", "story_v_out_321371.awb") / 1000

					if var_248_8 + var_248_0 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_8 + var_248_0
					end

					if var_248_3.prefab_name ~= "" and arg_245_1.actors_[var_248_3.prefab_name] ~= nil then
						local var_248_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_3.prefab_name].transform, "story_v_out_321371", "321371059", "story_v_out_321371.awb")

						arg_245_1:RecordAudio("321371059", var_248_9)
						arg_245_1:RecordAudio("321371059", var_248_9)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_321371", "321371059", "story_v_out_321371.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_321371", "321371059", "story_v_out_321371.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_10 = math.max(var_248_1, arg_245_1.talkMaxDuration)

			if var_248_0 <= arg_245_1.time_ and arg_245_1.time_ < var_248_0 + var_248_10 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_0) / var_248_10

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_0 + var_248_10 and arg_245_1.time_ < var_248_0 + var_248_10 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play321371060 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 321371060
		arg_249_1.duration_ = 10.1

		local var_249_0 = {
			zh = 8.1,
			ja = 10.1
		}
		local var_249_1 = manager.audio:GetLocalizationFlag()

		if var_249_0[var_249_1] ~= nil then
			arg_249_1.duration_ = var_249_0[var_249_1]
		end

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play321371061(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = 0
			local var_252_1 = 0.8

			if var_252_0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_0 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				local var_252_2 = arg_249_1:FormatText(StoryNameCfg[1213].name)

				arg_249_1.leftNameTxt_.text = var_252_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, true)
				arg_249_1.iconController_:SetSelectedState("hero")

				arg_249_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Elizabeth")

				arg_249_1.callingController_:SetSelectedState("normal")

				arg_249_1.keyicon_.color = Color.New(1, 1, 1)
				arg_249_1.icon_.color = Color.New(1, 1, 1)

				local var_252_3 = arg_249_1:GetWordFromCfg(321371060)
				local var_252_4 = arg_249_1:FormatText(var_252_3.content)

				arg_249_1.text_.text = var_252_4

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_5 = 32
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

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371060", "story_v_out_321371.awb") ~= 0 then
					local var_252_8 = manager.audio:GetVoiceLength("story_v_out_321371", "321371060", "story_v_out_321371.awb") / 1000

					if var_252_8 + var_252_0 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_8 + var_252_0
					end

					if var_252_3.prefab_name ~= "" and arg_249_1.actors_[var_252_3.prefab_name] ~= nil then
						local var_252_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_3.prefab_name].transform, "story_v_out_321371", "321371060", "story_v_out_321371.awb")

						arg_249_1:RecordAudio("321371060", var_252_9)
						arg_249_1:RecordAudio("321371060", var_252_9)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_321371", "321371060", "story_v_out_321371.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_321371", "321371060", "story_v_out_321371.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_10 = math.max(var_252_1, arg_249_1.talkMaxDuration)

			if var_252_0 <= arg_249_1.time_ and arg_249_1.time_ < var_252_0 + var_252_10 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_0) / var_252_10

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_0 + var_252_10 and arg_249_1.time_ < var_252_0 + var_252_10 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play321371061 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 321371061
		arg_253_1.duration_ = 6

		local var_253_0 = {
			zh = 6,
			ja = 5.733
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
				arg_253_0:Play321371062(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = 0
			local var_256_1 = 0.4

			if var_256_0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_0 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				local var_256_2 = arg_253_1:FormatText(StoryNameCfg[184].name)

				arg_253_1.leftNameTxt_.text = var_256_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, true)
				arg_253_1.iconController_:SetSelectedState("hero")

				arg_253_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_otis")

				arg_253_1.callingController_:SetSelectedState("normal")

				arg_253_1.keyicon_.color = Color.New(1, 1, 1)
				arg_253_1.icon_.color = Color.New(1, 1, 1)

				local var_256_3 = arg_253_1:GetWordFromCfg(321371061)
				local var_256_4 = arg_253_1:FormatText(var_256_3.content)

				arg_253_1.text_.text = var_256_4

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_5 = 16
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

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371061", "story_v_out_321371.awb") ~= 0 then
					local var_256_8 = manager.audio:GetVoiceLength("story_v_out_321371", "321371061", "story_v_out_321371.awb") / 1000

					if var_256_8 + var_256_0 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_8 + var_256_0
					end

					if var_256_3.prefab_name ~= "" and arg_253_1.actors_[var_256_3.prefab_name] ~= nil then
						local var_256_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_3.prefab_name].transform, "story_v_out_321371", "321371061", "story_v_out_321371.awb")

						arg_253_1:RecordAudio("321371061", var_256_9)
						arg_253_1:RecordAudio("321371061", var_256_9)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_321371", "321371061", "story_v_out_321371.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_321371", "321371061", "story_v_out_321371.awb")
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
	Play321371062 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 321371062
		arg_257_1.duration_ = 4.77

		local var_257_0 = {
			zh = 3.733,
			ja = 4.766
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
				arg_257_0:Play321371063(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = 0
			local var_260_1 = 0.375

			if var_260_0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_0 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				local var_260_2 = arg_257_1:FormatText(StoryNameCfg[1213].name)

				arg_257_1.leftNameTxt_.text = var_260_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, true)
				arg_257_1.iconController_:SetSelectedState("hero")

				arg_257_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Elizabeth")

				arg_257_1.callingController_:SetSelectedState("normal")

				arg_257_1.keyicon_.color = Color.New(1, 1, 1)
				arg_257_1.icon_.color = Color.New(1, 1, 1)

				local var_260_3 = arg_257_1:GetWordFromCfg(321371062)
				local var_260_4 = arg_257_1:FormatText(var_260_3.content)

				arg_257_1.text_.text = var_260_4

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_5 = 15
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

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371062", "story_v_out_321371.awb") ~= 0 then
					local var_260_8 = manager.audio:GetVoiceLength("story_v_out_321371", "321371062", "story_v_out_321371.awb") / 1000

					if var_260_8 + var_260_0 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_8 + var_260_0
					end

					if var_260_3.prefab_name ~= "" and arg_257_1.actors_[var_260_3.prefab_name] ~= nil then
						local var_260_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_3.prefab_name].transform, "story_v_out_321371", "321371062", "story_v_out_321371.awb")

						arg_257_1:RecordAudio("321371062", var_260_9)
						arg_257_1:RecordAudio("321371062", var_260_9)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_321371", "321371062", "story_v_out_321371.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_321371", "321371062", "story_v_out_321371.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_10 = math.max(var_260_1, arg_257_1.talkMaxDuration)

			if var_260_0 <= arg_257_1.time_ and arg_257_1.time_ < var_260_0 + var_260_10 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_0) / var_260_10

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_0 + var_260_10 and arg_257_1.time_ < var_260_0 + var_260_10 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play321371063 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 321371063
		arg_261_1.duration_ = 9.9

		local var_261_0 = {
			zh = 9.9,
			ja = 7.566
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
				arg_261_0:Play321371064(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = 0
			local var_264_1 = 0.75

			if var_264_0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_0 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				local var_264_2 = arg_261_1:FormatText(StoryNameCfg[1213].name)

				arg_261_1.leftNameTxt_.text = var_264_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, true)
				arg_261_1.iconController_:SetSelectedState("hero")

				arg_261_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Elizabeth")

				arg_261_1.callingController_:SetSelectedState("normal")

				arg_261_1.keyicon_.color = Color.New(1, 1, 1)
				arg_261_1.icon_.color = Color.New(1, 1, 1)

				local var_264_3 = arg_261_1:GetWordFromCfg(321371063)
				local var_264_4 = arg_261_1:FormatText(var_264_3.content)

				arg_261_1.text_.text = var_264_4

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_5 = 30
				local var_264_6 = utf8.len(var_264_4)
				local var_264_7 = var_264_5 <= 0 and var_264_1 or var_264_1 * (var_264_6 / var_264_5)

				if var_264_7 > 0 and var_264_1 < var_264_7 then
					arg_261_1.talkMaxDuration = var_264_7

					if var_264_7 + var_264_0 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_7 + var_264_0
					end
				end

				arg_261_1.text_.text = var_264_4
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371063", "story_v_out_321371.awb") ~= 0 then
					local var_264_8 = manager.audio:GetVoiceLength("story_v_out_321371", "321371063", "story_v_out_321371.awb") / 1000

					if var_264_8 + var_264_0 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_8 + var_264_0
					end

					if var_264_3.prefab_name ~= "" and arg_261_1.actors_[var_264_3.prefab_name] ~= nil then
						local var_264_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_3.prefab_name].transform, "story_v_out_321371", "321371063", "story_v_out_321371.awb")

						arg_261_1:RecordAudio("321371063", var_264_9)
						arg_261_1:RecordAudio("321371063", var_264_9)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_321371", "321371063", "story_v_out_321371.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_321371", "321371063", "story_v_out_321371.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_10 = math.max(var_264_1, arg_261_1.talkMaxDuration)

			if var_264_0 <= arg_261_1.time_ and arg_261_1.time_ < var_264_0 + var_264_10 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_0) / var_264_10

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_0 + var_264_10 and arg_261_1.time_ < var_264_0 + var_264_10 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play321371064 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 321371064
		arg_265_1.duration_ = 5.82

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play321371065(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0
			local var_268_1 = 0

			if var_268_1 < arg_265_1.time_ and arg_265_1.time_ <= var_268_1 + arg_268_0 then
				local var_268_2 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_268_2 then
					var_268_2.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_268_2.radialBlurScale = 0.6
					var_268_2.radialBlurGradient = 1
					var_268_2.radialBlurIntensity = 1

					if var_268_0 then
						var_268_2.radialBlurTarget = var_268_0.transform
					end
				end
			end

			local var_268_3 = 2

			if var_268_1 <= arg_265_1.time_ and arg_265_1.time_ < var_268_1 + var_268_3 then
				local var_268_4 = (arg_265_1.time_ - var_268_1) / var_268_3
				local var_268_5 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_268_5 then
					var_268_5.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_268_5.radialBlurScale = Mathf.Lerp(0.6, 0, var_268_4)
					var_268_5.radialBlurGradient = Mathf.Lerp(1, 1, var_268_4)
					var_268_5.radialBlurIntensity = Mathf.Lerp(1, 1, var_268_4)
				end
			end

			if arg_265_1.time_ >= var_268_1 + var_268_3 and arg_265_1.time_ < var_268_1 + var_268_3 + arg_268_0 then
				local var_268_6 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_268_6 then
					var_268_6.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_268_6.radialBlurScale = 0
					var_268_6.radialBlurGradient = 1
					var_268_6.radialBlurIntensity = 1
				end
			end

			local var_268_7 = 0

			if var_268_7 < arg_265_1.time_ and arg_265_1.time_ <= var_268_7 + arg_268_0 then
				arg_265_1.allBtn_.enabled = false
			end

			local var_268_8 = 0.825

			if arg_265_1.time_ >= var_268_7 + var_268_8 and arg_265_1.time_ < var_268_7 + var_268_8 + arg_268_0 then
				arg_265_1.allBtn_.enabled = true
			end

			if arg_265_1.frameCnt_ <= 1 then
				arg_265_1.dialog_:SetActive(false)
			end

			local var_268_9 = 0.825
			local var_268_10 = 1.175

			if var_268_9 < arg_265_1.time_ and arg_265_1.time_ <= var_268_9 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0

				arg_265_1.dialog_:SetActive(true)

				arg_265_1.dialogCg_.alpha = 0

				local var_268_11 = LeanTween.value(arg_265_1.dialog_, 0, 1, 0.3)

				var_268_11:setOnUpdate(LuaHelper.FloatAction(function(arg_269_0)
					arg_265_1.dialogCg_.alpha = arg_269_0
				end))
				var_268_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_265_1.dialog_)
					var_268_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_265_1.duration_ = arg_265_1.duration_ + 0.3

				SetActive(arg_265_1.leftNameGo_, false)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_12 = arg_265_1:GetWordFromCfg(321371064)
				local var_268_13 = arg_265_1:FormatText(var_268_12.content)

				arg_265_1.text_.text = var_268_13

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_14 = 47
				local var_268_15 = utf8.len(var_268_13)
				local var_268_16 = var_268_14 <= 0 and var_268_10 or var_268_10 * (var_268_15 / var_268_14)

				if var_268_16 > 0 and var_268_10 < var_268_16 then
					arg_265_1.talkMaxDuration = var_268_16
					var_268_9 = var_268_9 + 0.3

					if var_268_16 + var_268_9 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_16 + var_268_9
					end
				end

				arg_265_1.text_.text = var_268_13
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)
				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_17 = var_268_9 + 0.3
			local var_268_18 = math.max(var_268_10, arg_265_1.talkMaxDuration)

			if var_268_17 <= arg_265_1.time_ and arg_265_1.time_ < var_268_17 + var_268_18 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_17) / var_268_18

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_17 + var_268_18 and arg_265_1.time_ < var_268_17 + var_268_18 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play321371065 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 321371065
		arg_271_1.duration_ = 5.37

		local var_271_0 = {
			zh = 3.1,
			ja = 5.366
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
				arg_271_0:Play321371066(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = 0
			local var_274_1 = 0.2

			if var_274_0 < arg_271_1.time_ and arg_271_1.time_ <= var_274_0 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				local var_274_2 = arg_271_1:FormatText(StoryNameCfg[184].name)

				arg_271_1.leftNameTxt_.text = var_274_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, true)
				arg_271_1.iconController_:SetSelectedState("hero")

				arg_271_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_otis")

				arg_271_1.callingController_:SetSelectedState("normal")

				arg_271_1.keyicon_.color = Color.New(1, 1, 1)
				arg_271_1.icon_.color = Color.New(1, 1, 1)

				local var_274_3 = arg_271_1:GetWordFromCfg(321371065)
				local var_274_4 = arg_271_1:FormatText(var_274_3.content)

				arg_271_1.text_.text = var_274_4

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_5 = 8
				local var_274_6 = utf8.len(var_274_4)
				local var_274_7 = var_274_5 <= 0 and var_274_1 or var_274_1 * (var_274_6 / var_274_5)

				if var_274_7 > 0 and var_274_1 < var_274_7 then
					arg_271_1.talkMaxDuration = var_274_7

					if var_274_7 + var_274_0 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_7 + var_274_0
					end
				end

				arg_271_1.text_.text = var_274_4
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371065", "story_v_out_321371.awb") ~= 0 then
					local var_274_8 = manager.audio:GetVoiceLength("story_v_out_321371", "321371065", "story_v_out_321371.awb") / 1000

					if var_274_8 + var_274_0 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_8 + var_274_0
					end

					if var_274_3.prefab_name ~= "" and arg_271_1.actors_[var_274_3.prefab_name] ~= nil then
						local var_274_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_3.prefab_name].transform, "story_v_out_321371", "321371065", "story_v_out_321371.awb")

						arg_271_1:RecordAudio("321371065", var_274_9)
						arg_271_1:RecordAudio("321371065", var_274_9)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_out_321371", "321371065", "story_v_out_321371.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_out_321371", "321371065", "story_v_out_321371.awb")
				end

				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_10 = math.max(var_274_1, arg_271_1.talkMaxDuration)

			if var_274_0 <= arg_271_1.time_ and arg_271_1.time_ < var_274_0 + var_274_10 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_0) / var_274_10

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_0 + var_274_10 and arg_271_1.time_ < var_274_0 + var_274_10 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {}

		arg_271_1:InitPlayNodeList()
	end,
	Play321371066 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 321371066
		arg_275_1.duration_ = 5.87

		local var_275_0 = {
			zh = 5.866,
			ja = 5.6
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
				arg_275_0:Play321371067(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			local var_278_0 = 0
			local var_278_1 = 0.35

			if var_278_0 < arg_275_1.time_ and arg_275_1.time_ <= var_278_0 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				local var_278_2 = arg_275_1:FormatText(StoryNameCfg[184].name)

				arg_275_1.leftNameTxt_.text = var_278_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, true)
				arg_275_1.iconController_:SetSelectedState("hero")

				arg_275_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_otis")

				arg_275_1.callingController_:SetSelectedState("normal")

				arg_275_1.keyicon_.color = Color.New(1, 1, 1)
				arg_275_1.icon_.color = Color.New(1, 1, 1)

				local var_278_3 = arg_275_1:GetWordFromCfg(321371066)
				local var_278_4 = arg_275_1:FormatText(var_278_3.content)

				arg_275_1.text_.text = var_278_4

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_5 = 14
				local var_278_6 = utf8.len(var_278_4)
				local var_278_7 = var_278_5 <= 0 and var_278_1 or var_278_1 * (var_278_6 / var_278_5)

				if var_278_7 > 0 and var_278_1 < var_278_7 then
					arg_275_1.talkMaxDuration = var_278_7

					if var_278_7 + var_278_0 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_7 + var_278_0
					end
				end

				arg_275_1.text_.text = var_278_4
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371066", "story_v_out_321371.awb") ~= 0 then
					local var_278_8 = manager.audio:GetVoiceLength("story_v_out_321371", "321371066", "story_v_out_321371.awb") / 1000

					if var_278_8 + var_278_0 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_8 + var_278_0
					end

					if var_278_3.prefab_name ~= "" and arg_275_1.actors_[var_278_3.prefab_name] ~= nil then
						local var_278_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_275_1.actors_[var_278_3.prefab_name].transform, "story_v_out_321371", "321371066", "story_v_out_321371.awb")

						arg_275_1:RecordAudio("321371066", var_278_9)
						arg_275_1:RecordAudio("321371066", var_278_9)
					else
						arg_275_1:AudioAction("play", "voice", "story_v_out_321371", "321371066", "story_v_out_321371.awb")
					end

					arg_275_1:RecordHistoryTalkVoice("story_v_out_321371", "321371066", "story_v_out_321371.awb")
				end

				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_10 = math.max(var_278_1, arg_275_1.talkMaxDuration)

			if var_278_0 <= arg_275_1.time_ and arg_275_1.time_ < var_278_0 + var_278_10 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_0) / var_278_10

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_0 + var_278_10 and arg_275_1.time_ < var_278_0 + var_278_10 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play321371067 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 321371067
		arg_279_1.duration_ = 5

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play321371068(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			local var_282_0 = 0
			local var_282_1 = 0.95

			if var_282_0 < arg_279_1.time_ and arg_279_1.time_ <= var_282_0 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, false)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_2 = arg_279_1:GetWordFromCfg(321371067)
				local var_282_3 = arg_279_1:FormatText(var_282_2.content)

				arg_279_1.text_.text = var_282_3

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_4 = 38
				local var_282_5 = utf8.len(var_282_3)
				local var_282_6 = var_282_4 <= 0 and var_282_1 or var_282_1 * (var_282_5 / var_282_4)

				if var_282_6 > 0 and var_282_1 < var_282_6 then
					arg_279_1.talkMaxDuration = var_282_6

					if var_282_6 + var_282_0 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_6 + var_282_0
					end
				end

				arg_279_1.text_.text = var_282_3
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)
				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_7 = math.max(var_282_1, arg_279_1.talkMaxDuration)

			if var_282_0 <= arg_279_1.time_ and arg_279_1.time_ < var_282_0 + var_282_7 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_0) / var_282_7

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_0 + var_282_7 and arg_279_1.time_ < var_282_0 + var_282_7 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {}

		arg_279_1:InitPlayNodeList()
	end,
	Play321371068 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 321371068
		arg_283_1.duration_ = 6.23

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play321371069(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			local var_286_0
			local var_286_1 = 0

			if var_286_1 < arg_283_1.time_ and arg_283_1.time_ <= var_286_1 + arg_286_0 then
				local var_286_2 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_286_2 then
					var_286_2.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_286_2.radialBlurScale = 0.854
					var_286_2.radialBlurGradient = 1
					var_286_2.radialBlurIntensity = 1

					if var_286_0 then
						var_286_2.radialBlurTarget = var_286_0.transform
					end
				end
			end

			local var_286_3 = 1.33333333333333

			if var_286_1 <= arg_283_1.time_ and arg_283_1.time_ < var_286_1 + var_286_3 then
				local var_286_4 = (arg_283_1.time_ - var_286_1) / var_286_3
				local var_286_5 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_286_5 then
					var_286_5.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_286_5.radialBlurScale = Mathf.Lerp(0.854, 0.97, var_286_4)
					var_286_5.radialBlurGradient = Mathf.Lerp(1, 1, var_286_4)
					var_286_5.radialBlurIntensity = Mathf.Lerp(1, 1, var_286_4)
				end
			end

			if arg_283_1.time_ >= var_286_1 + var_286_3 and arg_283_1.time_ < var_286_1 + var_286_3 + arg_286_0 then
				local var_286_6 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_286_6 then
					var_286_6.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_286_6.radialBlurScale = 0.97
					var_286_6.radialBlurGradient = 1
					var_286_6.radialBlurIntensity = 1
				end
			end

			local var_286_7 = 0

			if var_286_7 < arg_283_1.time_ and arg_283_1.time_ <= var_286_7 + arg_286_0 then
				arg_283_1.allBtn_.enabled = false
			end

			local var_286_8 = 1.9

			if arg_283_1.time_ >= var_286_7 + var_286_8 and arg_283_1.time_ < var_286_7 + var_286_8 + arg_286_0 then
				arg_283_1.allBtn_.enabled = true
			end

			local var_286_9 = 0
			local var_286_10 = 1

			if var_286_9 < arg_283_1.time_ and arg_283_1.time_ <= var_286_9 + arg_286_0 then
				local var_286_11 = "play"
				local var_286_12 = "effect"

				arg_283_1:AudioAction(var_286_11, var_286_12, "se_story_141", "se_story_141_unreal", "")
			end

			local var_286_13 = 1.23333333333333
			local var_286_14 = 1.65

			if var_286_13 < arg_283_1.time_ and arg_283_1.time_ <= var_286_13 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, false)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_15 = arg_283_1:GetWordFromCfg(321371068)
				local var_286_16 = arg_283_1:FormatText(var_286_15.content)

				arg_283_1.text_.text = var_286_16

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_17 = 66
				local var_286_18 = utf8.len(var_286_16)
				local var_286_19 = var_286_17 <= 0 and var_286_14 or var_286_14 * (var_286_18 / var_286_17)

				if var_286_19 > 0 and var_286_14 < var_286_19 then
					arg_283_1.talkMaxDuration = var_286_19

					if var_286_19 + var_286_13 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_19 + var_286_13
					end
				end

				arg_283_1.text_.text = var_286_16
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)
				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_20 = math.max(var_286_14, arg_283_1.talkMaxDuration)

			if var_286_13 <= arg_283_1.time_ and arg_283_1.time_ < var_286_13 + var_286_20 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_13) / var_286_20

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_13 + var_286_20 and arg_283_1.time_ < var_286_13 + var_286_20 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {}

		arg_283_1:InitPlayNodeList()
	end,
	Play321371069 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 321371069
		arg_287_1.duration_ = 3.07

		local var_287_0 = {
			zh = 2.8,
			ja = 3.066
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
				arg_287_0:Play321371070(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			local var_290_0 = 0
			local var_290_1 = 0.3

			if var_290_0 < arg_287_1.time_ and arg_287_1.time_ <= var_290_0 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				local var_290_2 = arg_287_1:FormatText(StoryNameCfg[1165].name)

				arg_287_1.leftNameTxt_.text = var_290_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, true)
				arg_287_1.iconController_:SetSelectedState("hero")

				arg_287_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_naiti")

				arg_287_1.callingController_:SetSelectedState("normal")

				arg_287_1.keyicon_.color = Color.New(1, 1, 1)
				arg_287_1.icon_.color = Color.New(1, 1, 1)

				local var_290_3 = arg_287_1:GetWordFromCfg(321371069)
				local var_290_4 = arg_287_1:FormatText(var_290_3.content)

				arg_287_1.text_.text = var_290_4

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_5 = 12
				local var_290_6 = utf8.len(var_290_4)
				local var_290_7 = var_290_5 <= 0 and var_290_1 or var_290_1 * (var_290_6 / var_290_5)

				if var_290_7 > 0 and var_290_1 < var_290_7 then
					arg_287_1.talkMaxDuration = var_290_7

					if var_290_7 + var_290_0 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_7 + var_290_0
					end
				end

				arg_287_1.text_.text = var_290_4
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371069", "story_v_out_321371.awb") ~= 0 then
					local var_290_8 = manager.audio:GetVoiceLength("story_v_out_321371", "321371069", "story_v_out_321371.awb") / 1000

					if var_290_8 + var_290_0 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_8 + var_290_0
					end

					if var_290_3.prefab_name ~= "" and arg_287_1.actors_[var_290_3.prefab_name] ~= nil then
						local var_290_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_3.prefab_name].transform, "story_v_out_321371", "321371069", "story_v_out_321371.awb")

						arg_287_1:RecordAudio("321371069", var_290_9)
						arg_287_1:RecordAudio("321371069", var_290_9)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_out_321371", "321371069", "story_v_out_321371.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_out_321371", "321371069", "story_v_out_321371.awb")
				end

				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_10 = math.max(var_290_1, arg_287_1.talkMaxDuration)

			if var_290_0 <= arg_287_1.time_ and arg_287_1.time_ < var_290_0 + var_290_10 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_0) / var_290_10

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_0 + var_290_10 and arg_287_1.time_ < var_290_0 + var_290_10 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {}

		arg_287_1:InitPlayNodeList()
	end,
	Play321371070 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 321371070
		arg_291_1.duration_ = 3.23

		local var_291_0 = {
			zh = 1.266,
			ja = 3.233
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
				arg_291_0:Play321371071(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			local var_294_0 = 0
			local var_294_1 = 0.125

			if var_294_0 < arg_291_1.time_ and arg_291_1.time_ <= var_294_0 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				local var_294_2 = arg_291_1:FormatText(StoryNameCfg[1156].name)

				arg_291_1.leftNameTxt_.text = var_294_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, true)
				arg_291_1.iconController_:SetSelectedState("hero")

				arg_291_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1043")

				arg_291_1.callingController_:SetSelectedState("normal")

				arg_291_1.keyicon_.color = Color.New(1, 1, 1)
				arg_291_1.icon_.color = Color.New(1, 1, 1)

				local var_294_3 = arg_291_1:GetWordFromCfg(321371070)
				local var_294_4 = arg_291_1:FormatText(var_294_3.content)

				arg_291_1.text_.text = var_294_4

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_5 = 5
				local var_294_6 = utf8.len(var_294_4)
				local var_294_7 = var_294_5 <= 0 and var_294_1 or var_294_1 * (var_294_6 / var_294_5)

				if var_294_7 > 0 and var_294_1 < var_294_7 then
					arg_291_1.talkMaxDuration = var_294_7

					if var_294_7 + var_294_0 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_7 + var_294_0
					end
				end

				arg_291_1.text_.text = var_294_4
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371070", "story_v_out_321371.awb") ~= 0 then
					local var_294_8 = manager.audio:GetVoiceLength("story_v_out_321371", "321371070", "story_v_out_321371.awb") / 1000

					if var_294_8 + var_294_0 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_8 + var_294_0
					end

					if var_294_3.prefab_name ~= "" and arg_291_1.actors_[var_294_3.prefab_name] ~= nil then
						local var_294_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_291_1.actors_[var_294_3.prefab_name].transform, "story_v_out_321371", "321371070", "story_v_out_321371.awb")

						arg_291_1:RecordAudio("321371070", var_294_9)
						arg_291_1:RecordAudio("321371070", var_294_9)
					else
						arg_291_1:AudioAction("play", "voice", "story_v_out_321371", "321371070", "story_v_out_321371.awb")
					end

					arg_291_1:RecordHistoryTalkVoice("story_v_out_321371", "321371070", "story_v_out_321371.awb")
				end

				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_10 = math.max(var_294_1, arg_291_1.talkMaxDuration)

			if var_294_0 <= arg_291_1.time_ and arg_291_1.time_ < var_294_0 + var_294_10 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_0) / var_294_10

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_0 + var_294_10 and arg_291_1.time_ < var_294_0 + var_294_10 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {}

		arg_291_1:InitPlayNodeList()
	end,
	Play321371071 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 321371071
		arg_295_1.duration_ = 8.63

		local var_295_0 = {
			zh = 4.733,
			ja = 8.633
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
				arg_295_0:Play321371072(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			local var_298_0 = 0
			local var_298_1 = 0.65

			if var_298_0 < arg_295_1.time_ and arg_295_1.time_ <= var_298_0 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				local var_298_2 = arg_295_1:FormatText(StoryNameCfg[1156].name)

				arg_295_1.leftNameTxt_.text = var_298_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, true)
				arg_295_1.iconController_:SetSelectedState("hero")

				arg_295_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1043")

				arg_295_1.callingController_:SetSelectedState("normal")

				arg_295_1.keyicon_.color = Color.New(1, 1, 1)
				arg_295_1.icon_.color = Color.New(1, 1, 1)

				local var_298_3 = arg_295_1:GetWordFromCfg(321371071)
				local var_298_4 = arg_295_1:FormatText(var_298_3.content)

				arg_295_1.text_.text = var_298_4

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_5 = 26
				local var_298_6 = utf8.len(var_298_4)
				local var_298_7 = var_298_5 <= 0 and var_298_1 or var_298_1 * (var_298_6 / var_298_5)

				if var_298_7 > 0 and var_298_1 < var_298_7 then
					arg_295_1.talkMaxDuration = var_298_7

					if var_298_7 + var_298_0 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_7 + var_298_0
					end
				end

				arg_295_1.text_.text = var_298_4
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371071", "story_v_out_321371.awb") ~= 0 then
					local var_298_8 = manager.audio:GetVoiceLength("story_v_out_321371", "321371071", "story_v_out_321371.awb") / 1000

					if var_298_8 + var_298_0 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_8 + var_298_0
					end

					if var_298_3.prefab_name ~= "" and arg_295_1.actors_[var_298_3.prefab_name] ~= nil then
						local var_298_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_295_1.actors_[var_298_3.prefab_name].transform, "story_v_out_321371", "321371071", "story_v_out_321371.awb")

						arg_295_1:RecordAudio("321371071", var_298_9)
						arg_295_1:RecordAudio("321371071", var_298_9)
					else
						arg_295_1:AudioAction("play", "voice", "story_v_out_321371", "321371071", "story_v_out_321371.awb")
					end

					arg_295_1:RecordHistoryTalkVoice("story_v_out_321371", "321371071", "story_v_out_321371.awb")
				end

				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_10 = math.max(var_298_1, arg_295_1.talkMaxDuration)

			if var_298_0 <= arg_295_1.time_ and arg_295_1.time_ < var_298_0 + var_298_10 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_0) / var_298_10

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_0 + var_298_10 and arg_295_1.time_ < var_298_0 + var_298_10 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {}

		arg_295_1:InitPlayNodeList()
	end,
	Play321371072 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 321371072
		arg_299_1.duration_ = 5.17

		local var_299_0 = {
			zh = 2.9,
			ja = 5.166
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
				arg_299_0:Play321371073(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			local var_302_0 = 0
			local var_302_1 = 0.275

			if var_302_0 < arg_299_1.time_ and arg_299_1.time_ <= var_302_0 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				local var_302_2 = arg_299_1:FormatText(StoryNameCfg[1156].name)

				arg_299_1.leftNameTxt_.text = var_302_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, true)
				arg_299_1.iconController_:SetSelectedState("hero")

				arg_299_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1043")

				arg_299_1.callingController_:SetSelectedState("normal")

				arg_299_1.keyicon_.color = Color.New(1, 1, 1)
				arg_299_1.icon_.color = Color.New(1, 1, 1)

				local var_302_3 = arg_299_1:GetWordFromCfg(321371072)
				local var_302_4 = arg_299_1:FormatText(var_302_3.content)

				arg_299_1.text_.text = var_302_4

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_5 = 11
				local var_302_6 = utf8.len(var_302_4)
				local var_302_7 = var_302_5 <= 0 and var_302_1 or var_302_1 * (var_302_6 / var_302_5)

				if var_302_7 > 0 and var_302_1 < var_302_7 then
					arg_299_1.talkMaxDuration = var_302_7

					if var_302_7 + var_302_0 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_7 + var_302_0
					end
				end

				arg_299_1.text_.text = var_302_4
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371072", "story_v_out_321371.awb") ~= 0 then
					local var_302_8 = manager.audio:GetVoiceLength("story_v_out_321371", "321371072", "story_v_out_321371.awb") / 1000

					if var_302_8 + var_302_0 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_8 + var_302_0
					end

					if var_302_3.prefab_name ~= "" and arg_299_1.actors_[var_302_3.prefab_name] ~= nil then
						local var_302_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_299_1.actors_[var_302_3.prefab_name].transform, "story_v_out_321371", "321371072", "story_v_out_321371.awb")

						arg_299_1:RecordAudio("321371072", var_302_9)
						arg_299_1:RecordAudio("321371072", var_302_9)
					else
						arg_299_1:AudioAction("play", "voice", "story_v_out_321371", "321371072", "story_v_out_321371.awb")
					end

					arg_299_1:RecordHistoryTalkVoice("story_v_out_321371", "321371072", "story_v_out_321371.awb")
				end

				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_10 = math.max(var_302_1, arg_299_1.talkMaxDuration)

			if var_302_0 <= arg_299_1.time_ and arg_299_1.time_ < var_302_0 + var_302_10 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_0) / var_302_10

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_0 + var_302_10 and arg_299_1.time_ < var_302_0 + var_302_10 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {}

		arg_299_1:InitPlayNodeList()
	end,
	Play321371073 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 321371073
		arg_303_1.duration_ = 6.73

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play321371074(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			local var_306_0 = arg_303_1.actors_["1037ui_story"]
			local var_306_1 = 0

			if var_306_1 < arg_303_1.time_ and arg_303_1.time_ <= var_306_1 + arg_306_0 and not isNil(var_306_0) and arg_303_1.var_.characterEffect1037ui_story == nil then
				arg_303_1.var_.characterEffect1037ui_story = var_306_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_306_2 = 0.200000002980232

			if var_306_1 <= arg_303_1.time_ and arg_303_1.time_ < var_306_1 + var_306_2 and not isNil(var_306_0) then
				local var_306_3 = (arg_303_1.time_ - var_306_1) / var_306_2

				if arg_303_1.var_.characterEffect1037ui_story and not isNil(var_306_0) then
					local var_306_4 = Mathf.Lerp(0, 0.5, var_306_3)

					arg_303_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_303_1.var_.characterEffect1037ui_story.fillRatio = var_306_4
				end
			end

			if arg_303_1.time_ >= var_306_1 + var_306_2 and arg_303_1.time_ < var_306_1 + var_306_2 + arg_306_0 and not isNil(var_306_0) and arg_303_1.var_.characterEffect1037ui_story then
				local var_306_5 = 0.5

				arg_303_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_303_1.var_.characterEffect1037ui_story.fillRatio = var_306_5
			end

			local var_306_6
			local var_306_7 = 0

			if var_306_7 < arg_303_1.time_ and arg_303_1.time_ <= var_306_7 + arg_306_0 then
				local var_306_8 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_306_8 then
					var_306_8.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_306_8.radialBlurScale = 0
					var_306_8.radialBlurGradient = 1
					var_306_8.radialBlurIntensity = 1

					if var_306_6 then
						var_306_8.radialBlurTarget = var_306_6.transform
					end
				end
			end

			local var_306_9 = 0.200000002980232

			if var_306_7 <= arg_303_1.time_ and arg_303_1.time_ < var_306_7 + var_306_9 then
				local var_306_10 = (arg_303_1.time_ - var_306_7) / var_306_9
				local var_306_11 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_306_11 then
					var_306_11.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_306_11.radialBlurScale = Mathf.Lerp(0, 0, var_306_10)
					var_306_11.radialBlurGradient = Mathf.Lerp(1, 1, var_306_10)
					var_306_11.radialBlurIntensity = Mathf.Lerp(1, 1, var_306_10)
				end
			end

			if arg_303_1.time_ >= var_306_7 + var_306_9 and arg_303_1.time_ < var_306_7 + var_306_9 + arg_306_0 then
				local var_306_12 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_306_12 then
					var_306_12.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_306_12.radialBlurScale = 0
					var_306_12.radialBlurGradient = 1
					var_306_12.radialBlurIntensity = 1
				end
			end

			local var_306_13 = 0

			if var_306_13 < arg_303_1.time_ and arg_303_1.time_ <= var_306_13 + arg_306_0 then
				arg_303_1.mask_.enabled = true
				arg_303_1.mask_.raycastTarget = true

				arg_303_1:SetGaussion(false)
			end

			local var_306_14 = 2

			if var_306_13 <= arg_303_1.time_ and arg_303_1.time_ < var_306_13 + var_306_14 then
				local var_306_15 = (arg_303_1.time_ - var_306_13) / var_306_14
				local var_306_16 = Color.New(1, 1, 1)

				var_306_16.a = Mathf.Lerp(1, 0, var_306_15)
				arg_303_1.mask_.color = var_306_16
			end

			if arg_303_1.time_ >= var_306_13 + var_306_14 and arg_303_1.time_ < var_306_13 + var_306_14 + arg_306_0 then
				local var_306_17 = Color.New(1, 1, 1)
				local var_306_18 = 0

				arg_303_1.mask_.enabled = false
				var_306_17.a = var_306_18
				arg_303_1.mask_.color = var_306_17
			end

			if arg_303_1.frameCnt_ <= 1 then
				arg_303_1.dialog_:SetActive(false)
			end

			local var_306_19 = 1.73333333333333
			local var_306_20 = 1.325

			if var_306_19 < arg_303_1.time_ and arg_303_1.time_ <= var_306_19 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0

				arg_303_1.dialog_:SetActive(true)

				arg_303_1.dialogCg_.alpha = 0

				local var_306_21 = LeanTween.value(arg_303_1.dialog_, 0, 1, 0.3)

				var_306_21:setOnUpdate(LuaHelper.FloatAction(function(arg_307_0)
					arg_303_1.dialogCg_.alpha = arg_307_0
				end))
				var_306_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_303_1.dialog_)
					var_306_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_303_1.duration_ = arg_303_1.duration_ + 0.3

				SetActive(arg_303_1.leftNameGo_, false)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_22 = arg_303_1:GetWordFromCfg(321371073)
				local var_306_23 = arg_303_1:FormatText(var_306_22.content)

				arg_303_1.text_.text = var_306_23

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_24 = 53
				local var_306_25 = utf8.len(var_306_23)
				local var_306_26 = var_306_24 <= 0 and var_306_20 or var_306_20 * (var_306_25 / var_306_24)

				if var_306_26 > 0 and var_306_20 < var_306_26 then
					arg_303_1.talkMaxDuration = var_306_26
					var_306_19 = var_306_19 + 0.3

					if var_306_26 + var_306_19 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_26 + var_306_19
					end
				end

				arg_303_1.text_.text = var_306_23
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)
				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_27 = var_306_19 + 0.3
			local var_306_28 = math.max(var_306_20, arg_303_1.talkMaxDuration)

			if var_306_27 <= arg_303_1.time_ and arg_303_1.time_ < var_306_27 + var_306_28 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_27) / var_306_28

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_27 + var_306_28 and arg_303_1.time_ < var_306_27 + var_306_28 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {}

		arg_303_1:InitPlayNodeList()
	end,
	Play321371074 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 321371074
		arg_309_1.duration_ = 4.93

		local var_309_0 = {
			zh = 4.933,
			ja = 4.666
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
				arg_309_0:Play321371075(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = arg_309_1.actors_["1043ui_story"].transform
			local var_312_1 = 0

			if var_312_1 < arg_309_1.time_ and arg_309_1.time_ <= var_312_1 + arg_312_0 then
				arg_309_1.var_.moveOldPos1043ui_story = var_312_0.localPosition
			end

			local var_312_2 = 0.001

			if var_312_1 <= arg_309_1.time_ and arg_309_1.time_ < var_312_1 + var_312_2 then
				local var_312_3 = (arg_309_1.time_ - var_312_1) / var_312_2
				local var_312_4 = Vector3.New(0.01, -1.01, -5.73)

				var_312_0.localPosition = Vector3.Lerp(arg_309_1.var_.moveOldPos1043ui_story, var_312_4, var_312_3)

				local var_312_5 = manager.ui.mainCamera.transform.position - var_312_0.position

				var_312_0.forward = Vector3.New(var_312_5.x, var_312_5.y, var_312_5.z)

				local var_312_6 = var_312_0.localEulerAngles

				var_312_6.z = 0
				var_312_6.x = 0
				var_312_0.localEulerAngles = var_312_6
			end

			if arg_309_1.time_ >= var_312_1 + var_312_2 and arg_309_1.time_ < var_312_1 + var_312_2 + arg_312_0 then
				var_312_0.localPosition = Vector3.New(0.01, -1.01, -5.73)

				local var_312_7 = manager.ui.mainCamera.transform.position - var_312_0.position

				var_312_0.forward = Vector3.New(var_312_7.x, var_312_7.y, var_312_7.z)

				local var_312_8 = var_312_0.localEulerAngles

				var_312_8.z = 0
				var_312_8.x = 0
				var_312_0.localEulerAngles = var_312_8
			end

			local var_312_9 = arg_309_1.actors_["1043ui_story"]
			local var_312_10 = 0

			if var_312_10 < arg_309_1.time_ and arg_309_1.time_ <= var_312_10 + arg_312_0 and not isNil(var_312_9) and arg_309_1.var_.characterEffect1043ui_story == nil then
				arg_309_1.var_.characterEffect1043ui_story = var_312_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_312_11 = 0.200000002980232

			if var_312_10 <= arg_309_1.time_ and arg_309_1.time_ < var_312_10 + var_312_11 and not isNil(var_312_9) then
				local var_312_12 = (arg_309_1.time_ - var_312_10) / var_312_11

				if arg_309_1.var_.characterEffect1043ui_story and not isNil(var_312_9) then
					arg_309_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_309_1.time_ >= var_312_10 + var_312_11 and arg_309_1.time_ < var_312_10 + var_312_11 + arg_312_0 and not isNil(var_312_9) and arg_309_1.var_.characterEffect1043ui_story then
				arg_309_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_312_13 = 0

			if var_312_13 < arg_309_1.time_ and arg_309_1.time_ <= var_312_13 + arg_312_0 then
				arg_309_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action1_1")
			end

			local var_312_14 = 0

			if var_312_14 < arg_309_1.time_ and arg_309_1.time_ <= var_312_14 + arg_312_0 then
				arg_309_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_312_15 = 0
			local var_312_16 = 0.525

			if var_312_15 < arg_309_1.time_ and arg_309_1.time_ <= var_312_15 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				local var_312_17 = arg_309_1:FormatText(StoryNameCfg[1156].name)

				arg_309_1.leftNameTxt_.text = var_312_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_18 = arg_309_1:GetWordFromCfg(321371074)
				local var_312_19 = arg_309_1:FormatText(var_312_18.content)

				arg_309_1.text_.text = var_312_19

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_20 = 21
				local var_312_21 = utf8.len(var_312_19)
				local var_312_22 = var_312_20 <= 0 and var_312_16 or var_312_16 * (var_312_21 / var_312_20)

				if var_312_22 > 0 and var_312_16 < var_312_22 then
					arg_309_1.talkMaxDuration = var_312_22

					if var_312_22 + var_312_15 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_22 + var_312_15
					end
				end

				arg_309_1.text_.text = var_312_19
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371074", "story_v_out_321371.awb") ~= 0 then
					local var_312_23 = manager.audio:GetVoiceLength("story_v_out_321371", "321371074", "story_v_out_321371.awb") / 1000

					if var_312_23 + var_312_15 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_23 + var_312_15
					end

					if var_312_18.prefab_name ~= "" and arg_309_1.actors_[var_312_18.prefab_name] ~= nil then
						local var_312_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_309_1.actors_[var_312_18.prefab_name].transform, "story_v_out_321371", "321371074", "story_v_out_321371.awb")

						arg_309_1:RecordAudio("321371074", var_312_24)
						arg_309_1:RecordAudio("321371074", var_312_24)
					else
						arg_309_1:AudioAction("play", "voice", "story_v_out_321371", "321371074", "story_v_out_321371.awb")
					end

					arg_309_1:RecordHistoryTalkVoice("story_v_out_321371", "321371074", "story_v_out_321371.awb")
				end

				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_25 = math.max(var_312_16, arg_309_1.talkMaxDuration)

			if var_312_15 <= arg_309_1.time_ and arg_309_1.time_ < var_312_15 + var_312_25 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_15) / var_312_25

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_15 + var_312_25 and arg_309_1.time_ < var_312_15 + var_312_25 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_309_1:InitPlayNodeList()
	end,
	Play321371075 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 321371075
		arg_313_1.duration_ = 5

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play321371076(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			local var_316_0 = arg_313_1.actors_["1043ui_story"].transform
			local var_316_1 = 0

			if var_316_1 < arg_313_1.time_ and arg_313_1.time_ <= var_316_1 + arg_316_0 then
				arg_313_1.var_.moveOldPos1043ui_story = var_316_0.localPosition
			end

			local var_316_2 = 0.001

			if var_316_1 <= arg_313_1.time_ and arg_313_1.time_ < var_316_1 + var_316_2 then
				local var_316_3 = (arg_313_1.time_ - var_316_1) / var_316_2
				local var_316_4 = Vector3.New(0, 100, 0)

				var_316_0.localPosition = Vector3.Lerp(arg_313_1.var_.moveOldPos1043ui_story, var_316_4, var_316_3)

				local var_316_5 = manager.ui.mainCamera.transform.position - var_316_0.position

				var_316_0.forward = Vector3.New(var_316_5.x, var_316_5.y, var_316_5.z)

				local var_316_6 = var_316_0.localEulerAngles

				var_316_6.z = 0
				var_316_6.x = 0
				var_316_0.localEulerAngles = var_316_6
			end

			if arg_313_1.time_ >= var_316_1 + var_316_2 and arg_313_1.time_ < var_316_1 + var_316_2 + arg_316_0 then
				var_316_0.localPosition = Vector3.New(0, 100, 0)

				local var_316_7 = manager.ui.mainCamera.transform.position - var_316_0.position

				var_316_0.forward = Vector3.New(var_316_7.x, var_316_7.y, var_316_7.z)

				local var_316_8 = var_316_0.localEulerAngles

				var_316_8.z = 0
				var_316_8.x = 0
				var_316_0.localEulerAngles = var_316_8
			end

			local var_316_9 = arg_313_1.actors_["1043ui_story"]
			local var_316_10 = 0

			if var_316_10 < arg_313_1.time_ and arg_313_1.time_ <= var_316_10 + arg_316_0 and not isNil(var_316_9) and arg_313_1.var_.characterEffect1043ui_story == nil then
				arg_313_1.var_.characterEffect1043ui_story = var_316_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_11 = 0.200000002980232

			if var_316_10 <= arg_313_1.time_ and arg_313_1.time_ < var_316_10 + var_316_11 and not isNil(var_316_9) then
				local var_316_12 = (arg_313_1.time_ - var_316_10) / var_316_11

				if arg_313_1.var_.characterEffect1043ui_story and not isNil(var_316_9) then
					local var_316_13 = Mathf.Lerp(0, 0.5, var_316_12)

					arg_313_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_313_1.var_.characterEffect1043ui_story.fillRatio = var_316_13
				end
			end

			if arg_313_1.time_ >= var_316_10 + var_316_11 and arg_313_1.time_ < var_316_10 + var_316_11 + arg_316_0 and not isNil(var_316_9) and arg_313_1.var_.characterEffect1043ui_story then
				local var_316_14 = 0.5

				arg_313_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_313_1.var_.characterEffect1043ui_story.fillRatio = var_316_14
			end

			local var_316_15 = 0
			local var_316_16 = 0.675

			if var_316_15 < arg_313_1.time_ and arg_313_1.time_ <= var_316_15 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, false)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_17 = arg_313_1:GetWordFromCfg(321371075)
				local var_316_18 = arg_313_1:FormatText(var_316_17.content)

				arg_313_1.text_.text = var_316_18

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_19 = 27
				local var_316_20 = utf8.len(var_316_18)
				local var_316_21 = var_316_19 <= 0 and var_316_16 or var_316_16 * (var_316_20 / var_316_19)

				if var_316_21 > 0 and var_316_16 < var_316_21 then
					arg_313_1.talkMaxDuration = var_316_21

					if var_316_21 + var_316_15 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_21 + var_316_15
					end
				end

				arg_313_1.text_.text = var_316_18
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)
				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_22 = math.max(var_316_16, arg_313_1.talkMaxDuration)

			if var_316_15 <= arg_313_1.time_ and arg_313_1.time_ < var_316_15 + var_316_22 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_15) / var_316_22

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_15 + var_316_22 and arg_313_1.time_ < var_316_15 + var_316_22 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_313_1:InitPlayNodeList()
	end,
	Play321371076 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 321371076
		arg_317_1.duration_ = 5

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play321371077(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = 0
			local var_320_1 = 1.225

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

				local var_320_2 = arg_317_1:GetWordFromCfg(321371076)
				local var_320_3 = arg_317_1:FormatText(var_320_2.content)

				arg_317_1.text_.text = var_320_3

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_4 = 49
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
	Play321371077 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 321371077
		arg_321_1.duration_ = 6.63

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play321371078(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = manager.ui.mainCamera.transform
			local var_324_1 = 0

			if var_324_1 < arg_321_1.time_ and arg_321_1.time_ <= var_324_1 + arg_324_0 then
				local var_324_2 = arg_321_1.var_.effectzhongnu1
				local var_324_3
				local var_324_4 = var_324_0

				if not var_324_2 then
					var_324_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), var_324_4)
					var_324_2.name = "zhongnu1"
					arg_321_1.var_.effectzhongnu1 = var_324_2
				else
					var_324_2.transform:SetParent(var_324_4)
				end

				var_324_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_324_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_324_5 = manager.ui.mainCamera.transform
			local var_324_6 = 2

			if var_324_6 < arg_321_1.time_ and arg_321_1.time_ <= var_324_6 + arg_324_0 then
				local var_324_7 = arg_321_1.var_.effectzhongnu1

				if var_324_7 then
					Object.Destroy(var_324_7)

					arg_321_1.var_.effectzhongnu1 = nil
				end
			end

			local var_324_8 = manager.ui.mainCamera.transform
			local var_324_9 = 0.0666666666666667

			if var_324_9 < arg_321_1.time_ and arg_321_1.time_ <= var_324_9 + arg_324_0 then
				arg_321_1.var_.shakeOldPos = var_324_8.localPosition
			end

			local var_324_10 = 0.333333333333333

			if var_324_9 <= arg_321_1.time_ and arg_321_1.time_ < var_324_9 + var_324_10 then
				local var_324_11 = (arg_321_1.time_ - var_324_9) / 0.066
				local var_324_12, var_324_13 = math.modf(var_324_11)

				var_324_8.localPosition = Vector3.New(var_324_13 * 0.13, var_324_13 * 0.13, var_324_13 * 0.13) + arg_321_1.var_.shakeOldPos
			end

			if arg_321_1.time_ >= var_324_9 + var_324_10 and arg_321_1.time_ < var_324_9 + var_324_10 + arg_324_0 then
				var_324_8.localPosition = arg_321_1.var_.shakeOldPos
			end

			local var_324_14 = 0

			if var_324_14 < arg_321_1.time_ and arg_321_1.time_ <= var_324_14 + arg_324_0 then
				arg_321_1.allBtn_.enabled = false
			end

			local var_324_15 = 2

			if arg_321_1.time_ >= var_324_14 + var_324_15 and arg_321_1.time_ < var_324_14 + var_324_15 + arg_324_0 then
				arg_321_1.allBtn_.enabled = true
			end

			local var_324_16 = 0.05
			local var_324_17 = 1

			if var_324_16 < arg_321_1.time_ and arg_321_1.time_ <= var_324_16 + arg_324_0 then
				local var_324_18 = "play"
				local var_324_19 = "effect"

				arg_321_1:AudioAction(var_324_18, var_324_19, "se_story_141", "se_story_141_crossbow", "")
			end

			if arg_321_1.frameCnt_ <= 1 then
				arg_321_1.dialog_:SetActive(false)
			end

			local var_324_20 = 1.63333333333333
			local var_324_21 = 1.425

			if var_324_20 < arg_321_1.time_ and arg_321_1.time_ <= var_324_20 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0

				arg_321_1.dialog_:SetActive(true)

				arg_321_1.dialogCg_.alpha = 0

				local var_324_22 = LeanTween.value(arg_321_1.dialog_, 0, 1, 0.3)

				var_324_22:setOnUpdate(LuaHelper.FloatAction(function(arg_325_0)
					arg_321_1.dialogCg_.alpha = arg_325_0
				end))
				var_324_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_321_1.dialog_)
					var_324_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_321_1.duration_ = arg_321_1.duration_ + 0.3

				SetActive(arg_321_1.leftNameGo_, false)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_23 = arg_321_1:GetWordFromCfg(321371077)
				local var_324_24 = arg_321_1:FormatText(var_324_23.content)

				arg_321_1.text_.text = var_324_24

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_25 = 57
				local var_324_26 = utf8.len(var_324_24)
				local var_324_27 = var_324_25 <= 0 and var_324_21 or var_324_21 * (var_324_26 / var_324_25)

				if var_324_27 > 0 and var_324_21 < var_324_27 then
					arg_321_1.talkMaxDuration = var_324_27
					var_324_20 = var_324_20 + 0.3

					if var_324_27 + var_324_20 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_27 + var_324_20
					end
				end

				arg_321_1.text_.text = var_324_24
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)
				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_28 = var_324_20 + 0.3
			local var_324_29 = math.max(var_324_21, arg_321_1.talkMaxDuration)

			if var_324_28 <= arg_321_1.time_ and arg_321_1.time_ < var_324_28 + var_324_29 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_28) / var_324_29

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_28 + var_324_29 and arg_321_1.time_ < var_324_28 + var_324_29 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play321371078 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 321371078
		arg_327_1.duration_ = 5

		SetActive(arg_327_1.tipsGo_, false)

		function arg_327_1.onSingleLineFinish_()
			arg_327_1.onSingleLineUpdate_ = nil
			arg_327_1.onSingleLineFinish_ = nil
			arg_327_1.state_ = "waiting"
		end

		function arg_327_1.playNext_(arg_329_0)
			if arg_329_0 == 1 then
				arg_327_0:Play321371079(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			local var_330_0 = 0.566666666666667
			local var_330_1 = 1

			if var_330_0 < arg_327_1.time_ and arg_327_1.time_ <= var_330_0 + arg_330_0 then
				local var_330_2 = "play"
				local var_330_3 = "effect"

				arg_327_1:AudioAction(var_330_2, var_330_3, "se_story_123_01", "se_story_123_01_whoosh", "")
			end

			local var_330_4 = 0
			local var_330_5 = 0.825

			if var_330_4 < arg_327_1.time_ and arg_327_1.time_ <= var_330_4 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, false)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_327_1.iconTrs_.gameObject, false)
				arg_327_1.callingController_:SetSelectedState("normal")

				local var_330_6 = arg_327_1:GetWordFromCfg(321371078)
				local var_330_7 = arg_327_1:FormatText(var_330_6.content)

				arg_327_1.text_.text = var_330_7

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_8 = 33
				local var_330_9 = utf8.len(var_330_7)
				local var_330_10 = var_330_8 <= 0 and var_330_5 or var_330_5 * (var_330_9 / var_330_8)

				if var_330_10 > 0 and var_330_5 < var_330_10 then
					arg_327_1.talkMaxDuration = var_330_10

					if var_330_10 + var_330_4 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_10 + var_330_4
					end
				end

				arg_327_1.text_.text = var_330_7
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)
				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_11 = math.max(var_330_5, arg_327_1.talkMaxDuration)

			if var_330_4 <= arg_327_1.time_ and arg_327_1.time_ < var_330_4 + var_330_11 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_4) / var_330_11

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_4 + var_330_11 and arg_327_1.time_ < var_330_4 + var_330_11 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {}

		arg_327_1:InitPlayNodeList()
	end,
	Play321371079 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 321371079
		arg_331_1.duration_ = 6.67

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play321371080(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			local var_334_0 = manager.ui.mainCamera.transform
			local var_334_1 = 0

			if var_334_1 < arg_331_1.time_ and arg_331_1.time_ <= var_334_1 + arg_334_0 then
				local var_334_2 = arg_331_1.var_.effectqiangbiposui1
				local var_334_3
				local var_334_4 = var_334_0

				if not var_334_2 then
					var_334_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_heibaishan"), var_334_4)
					var_334_2.name = "qiangbiposui1"
					arg_331_1.var_.effectqiangbiposui1 = var_334_2
				else
					var_334_2.transform:SetParent(var_334_4)
				end

				var_334_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_334_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_334_5 = manager.ui.mainCamera.transform
			local var_334_6 = 2

			if var_334_6 < arg_331_1.time_ and arg_331_1.time_ <= var_334_6 + arg_334_0 then
				local var_334_7 = arg_331_1.var_.effectqiangbiposui1

				if var_334_7 then
					Object.Destroy(var_334_7)

					arg_331_1.var_.effectqiangbiposui1 = nil
				end
			end

			local var_334_8 = manager.ui.mainCamera.transform
			local var_334_9 = 0

			if var_334_9 < arg_331_1.time_ and arg_331_1.time_ <= var_334_9 + arg_334_0 then
				arg_331_1.var_.shakeOldPos = var_334_8.localPosition
			end

			local var_334_10 = 1.43333333333333

			if var_334_9 <= arg_331_1.time_ and arg_331_1.time_ < var_334_9 + var_334_10 then
				local var_334_11 = (arg_331_1.time_ - var_334_9) / 0.066
				local var_334_12, var_334_13 = math.modf(var_334_11)

				var_334_8.localPosition = Vector3.New(var_334_13 * 0.13, var_334_13 * 0.13, var_334_13 * 0.13) + arg_331_1.var_.shakeOldPos
			end

			if arg_331_1.time_ >= var_334_9 + var_334_10 and arg_331_1.time_ < var_334_9 + var_334_10 + arg_334_0 then
				var_334_8.localPosition = arg_331_1.var_.shakeOldPos
			end

			local var_334_14 = 0

			if var_334_14 < arg_331_1.time_ and arg_331_1.time_ <= var_334_14 + arg_334_0 then
				arg_331_1.allBtn_.enabled = false
			end

			local var_334_15 = 1.43333333333333

			if arg_331_1.time_ >= var_334_14 + var_334_15 and arg_331_1.time_ < var_334_14 + var_334_15 + arg_334_0 then
				arg_331_1.allBtn_.enabled = true
			end

			local var_334_16 = 0.05
			local var_334_17 = 1

			if var_334_16 < arg_331_1.time_ and arg_331_1.time_ <= var_334_16 + arg_334_0 then
				local var_334_18 = "play"
				local var_334_19 = "effect"

				arg_331_1:AudioAction(var_334_18, var_334_19, "se_story_141", "se_story_141_wall_destroy", "")
			end

			if arg_331_1.frameCnt_ <= 1 then
				arg_331_1.dialog_:SetActive(false)
			end

			local var_334_20 = 1.66666666666667
			local var_334_21 = 1.35

			if var_334_20 < arg_331_1.time_ and arg_331_1.time_ <= var_334_20 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0

				arg_331_1.dialog_:SetActive(true)

				arg_331_1.dialogCg_.alpha = 0

				local var_334_22 = LeanTween.value(arg_331_1.dialog_, 0, 1, 0.3)

				var_334_22:setOnUpdate(LuaHelper.FloatAction(function(arg_335_0)
					arg_331_1.dialogCg_.alpha = arg_335_0
				end))
				var_334_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_331_1.dialog_)
					var_334_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_331_1.duration_ = arg_331_1.duration_ + 0.3

				SetActive(arg_331_1.leftNameGo_, false)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_23 = arg_331_1:GetWordFromCfg(321371079)
				local var_334_24 = arg_331_1:FormatText(var_334_23.content)

				arg_331_1.text_.text = var_334_24

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_25 = 54
				local var_334_26 = utf8.len(var_334_24)
				local var_334_27 = var_334_25 <= 0 and var_334_21 or var_334_21 * (var_334_26 / var_334_25)

				if var_334_27 > 0 and var_334_21 < var_334_27 then
					arg_331_1.talkMaxDuration = var_334_27
					var_334_20 = var_334_20 + 0.3

					if var_334_27 + var_334_20 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_27 + var_334_20
					end
				end

				arg_331_1.text_.text = var_334_24
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)
				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_28 = var_334_20 + 0.3
			local var_334_29 = math.max(var_334_21, arg_331_1.talkMaxDuration)

			if var_334_28 <= arg_331_1.time_ and arg_331_1.time_ < var_334_28 + var_334_29 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_28) / var_334_29

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_28 + var_334_29 and arg_331_1.time_ < var_334_28 + var_334_29 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {}

		arg_331_1:InitPlayNodeList()
	end,
	Play321371080 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 321371080
		arg_337_1.duration_ = 3.27

		local var_337_0 = {
			zh = 2.333,
			ja = 3.266
		}
		local var_337_1 = manager.audio:GetLocalizationFlag()

		if var_337_0[var_337_1] ~= nil then
			arg_337_1.duration_ = var_337_0[var_337_1]
		end

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play321371081(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			local var_340_0 = 0
			local var_340_1 = 0.25

			if var_340_0 < arg_337_1.time_ and arg_337_1.time_ <= var_340_0 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				local var_340_2 = arg_337_1:FormatText(StoryNameCfg[1165].name)

				arg_337_1.leftNameTxt_.text = var_340_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, true)
				arg_337_1.iconController_:SetSelectedState("hero")

				arg_337_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_naiti")

				arg_337_1.callingController_:SetSelectedState("normal")

				arg_337_1.keyicon_.color = Color.New(1, 1, 1)
				arg_337_1.icon_.color = Color.New(1, 1, 1)

				local var_340_3 = arg_337_1:GetWordFromCfg(321371080)
				local var_340_4 = arg_337_1:FormatText(var_340_3.content)

				arg_337_1.text_.text = var_340_4

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_5 = 10
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

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371080", "story_v_out_321371.awb") ~= 0 then
					local var_340_8 = manager.audio:GetVoiceLength("story_v_out_321371", "321371080", "story_v_out_321371.awb") / 1000

					if var_340_8 + var_340_0 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_8 + var_340_0
					end

					if var_340_3.prefab_name ~= "" and arg_337_1.actors_[var_340_3.prefab_name] ~= nil then
						local var_340_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_337_1.actors_[var_340_3.prefab_name].transform, "story_v_out_321371", "321371080", "story_v_out_321371.awb")

						arg_337_1:RecordAudio("321371080", var_340_9)
						arg_337_1:RecordAudio("321371080", var_340_9)
					else
						arg_337_1:AudioAction("play", "voice", "story_v_out_321371", "321371080", "story_v_out_321371.awb")
					end

					arg_337_1:RecordHistoryTalkVoice("story_v_out_321371", "321371080", "story_v_out_321371.awb")
				end

				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_10 = math.max(var_340_1, arg_337_1.talkMaxDuration)

			if var_340_0 <= arg_337_1.time_ and arg_337_1.time_ < var_340_0 + var_340_10 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_0) / var_340_10

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_0 + var_340_10 and arg_337_1.time_ < var_340_0 + var_340_10 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {}

		arg_337_1:InitPlayNodeList()
	end,
	Play321371081 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 321371081
		arg_341_1.duration_ = 4.93

		local var_341_0 = {
			zh = 4.3,
			ja = 4.933
		}
		local var_341_1 = manager.audio:GetLocalizationFlag()

		if var_341_0[var_341_1] ~= nil then
			arg_341_1.duration_ = var_341_0[var_341_1]
		end

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play321371082(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			local var_344_0 = arg_341_1.actors_["1043ui_story"].transform
			local var_344_1 = 0

			if var_344_1 < arg_341_1.time_ and arg_341_1.time_ <= var_344_1 + arg_344_0 then
				arg_341_1.var_.moveOldPos1043ui_story = var_344_0.localPosition
			end

			local var_344_2 = 0.001

			if var_344_1 <= arg_341_1.time_ and arg_341_1.time_ < var_344_1 + var_344_2 then
				local var_344_3 = (arg_341_1.time_ - var_344_1) / var_344_2
				local var_344_4 = Vector3.New(0.01, -1.01, -5.73)

				var_344_0.localPosition = Vector3.Lerp(arg_341_1.var_.moveOldPos1043ui_story, var_344_4, var_344_3)

				local var_344_5 = manager.ui.mainCamera.transform.position - var_344_0.position

				var_344_0.forward = Vector3.New(var_344_5.x, var_344_5.y, var_344_5.z)

				local var_344_6 = var_344_0.localEulerAngles

				var_344_6.z = 0
				var_344_6.x = 0
				var_344_0.localEulerAngles = var_344_6
			end

			if arg_341_1.time_ >= var_344_1 + var_344_2 and arg_341_1.time_ < var_344_1 + var_344_2 + arg_344_0 then
				var_344_0.localPosition = Vector3.New(0.01, -1.01, -5.73)

				local var_344_7 = manager.ui.mainCamera.transform.position - var_344_0.position

				var_344_0.forward = Vector3.New(var_344_7.x, var_344_7.y, var_344_7.z)

				local var_344_8 = var_344_0.localEulerAngles

				var_344_8.z = 0
				var_344_8.x = 0
				var_344_0.localEulerAngles = var_344_8
			end

			local var_344_9 = arg_341_1.actors_["1043ui_story"]
			local var_344_10 = 0

			if var_344_10 < arg_341_1.time_ and arg_341_1.time_ <= var_344_10 + arg_344_0 and not isNil(var_344_9) and arg_341_1.var_.characterEffect1043ui_story == nil then
				arg_341_1.var_.characterEffect1043ui_story = var_344_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_344_11 = 0.200000002980232

			if var_344_10 <= arg_341_1.time_ and arg_341_1.time_ < var_344_10 + var_344_11 and not isNil(var_344_9) then
				local var_344_12 = (arg_341_1.time_ - var_344_10) / var_344_11

				if arg_341_1.var_.characterEffect1043ui_story and not isNil(var_344_9) then
					arg_341_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_341_1.time_ >= var_344_10 + var_344_11 and arg_341_1.time_ < var_344_10 + var_344_11 + arg_344_0 and not isNil(var_344_9) and arg_341_1.var_.characterEffect1043ui_story then
				arg_341_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_344_13 = 0

			if var_344_13 < arg_341_1.time_ and arg_341_1.time_ <= var_344_13 + arg_344_0 then
				arg_341_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action8_1")
			end

			local var_344_14 = 0

			if var_344_14 < arg_341_1.time_ and arg_341_1.time_ <= var_344_14 + arg_344_0 then
				arg_341_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_344_15 = 0
			local var_344_16 = 0.45

			if var_344_15 < arg_341_1.time_ and arg_341_1.time_ <= var_344_15 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				local var_344_17 = arg_341_1:FormatText(StoryNameCfg[1156].name)

				arg_341_1.leftNameTxt_.text = var_344_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_18 = arg_341_1:GetWordFromCfg(321371081)
				local var_344_19 = arg_341_1:FormatText(var_344_18.content)

				arg_341_1.text_.text = var_344_19

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_20 = 18
				local var_344_21 = utf8.len(var_344_19)
				local var_344_22 = var_344_20 <= 0 and var_344_16 or var_344_16 * (var_344_21 / var_344_20)

				if var_344_22 > 0 and var_344_16 < var_344_22 then
					arg_341_1.talkMaxDuration = var_344_22

					if var_344_22 + var_344_15 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_22 + var_344_15
					end
				end

				arg_341_1.text_.text = var_344_19
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371081", "story_v_out_321371.awb") ~= 0 then
					local var_344_23 = manager.audio:GetVoiceLength("story_v_out_321371", "321371081", "story_v_out_321371.awb") / 1000

					if var_344_23 + var_344_15 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_23 + var_344_15
					end

					if var_344_18.prefab_name ~= "" and arg_341_1.actors_[var_344_18.prefab_name] ~= nil then
						local var_344_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_341_1.actors_[var_344_18.prefab_name].transform, "story_v_out_321371", "321371081", "story_v_out_321371.awb")

						arg_341_1:RecordAudio("321371081", var_344_24)
						arg_341_1:RecordAudio("321371081", var_344_24)
					else
						arg_341_1:AudioAction("play", "voice", "story_v_out_321371", "321371081", "story_v_out_321371.awb")
					end

					arg_341_1:RecordHistoryTalkVoice("story_v_out_321371", "321371081", "story_v_out_321371.awb")
				end

				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_25 = math.max(var_344_16, arg_341_1.talkMaxDuration)

			if var_344_15 <= arg_341_1.time_ and arg_341_1.time_ < var_344_15 + var_344_25 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_15) / var_344_25

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_15 + var_344_25 and arg_341_1.time_ < var_344_15 + var_344_25 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1043ui_story",
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
	Play321371082 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 321371082
		arg_345_1.duration_ = 7.5

		local var_345_0 = {
			zh = 7.5,
			ja = 7.4
		}
		local var_345_1 = manager.audio:GetLocalizationFlag()

		if var_345_0[var_345_1] ~= nil then
			arg_345_1.duration_ = var_345_0[var_345_1]
		end

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play321371083(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			local var_348_0 = 1.999999999999

			if var_348_0 < arg_345_1.time_ and arg_345_1.time_ <= var_348_0 + arg_348_0 then
				local var_348_1 = manager.ui.mainCamera.transform.localPosition
				local var_348_2 = Vector3.New(0, 0, 10) + Vector3.New(var_348_1.x, var_348_1.y, 0)
				local var_348_3 = arg_345_1.bgs_.L09g

				var_348_3.transform.localPosition = var_348_2
				var_348_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_348_4 = var_348_3:GetComponent("SpriteRenderer")

				if var_348_4 and var_348_4.sprite then
					local var_348_5 = (var_348_3.transform.localPosition - var_348_1).z
					local var_348_6 = manager.ui.mainCameraCom_
					local var_348_7 = 2 * var_348_5 * Mathf.Tan(var_348_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_348_8 = var_348_7 * var_348_6.aspect
					local var_348_9 = var_348_4.sprite.bounds.size.x
					local var_348_10 = var_348_4.sprite.bounds.size.y
					local var_348_11 = var_348_8 / var_348_9
					local var_348_12 = var_348_7 / var_348_10
					local var_348_13 = var_348_12 < var_348_11 and var_348_11 or var_348_12

					var_348_3.transform.localScale = Vector3.New(var_348_13, var_348_13, 0)
				end

				for iter_348_0, iter_348_1 in pairs(arg_345_1.bgs_) do
					if iter_348_0 ~= "L09g" then
						iter_348_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_348_14 = 3.999999999999

			if var_348_14 < arg_345_1.time_ and arg_345_1.time_ <= var_348_14 + arg_348_0 then
				arg_345_1.allBtn_.enabled = false
			end

			local var_348_15 = 0.3

			if arg_345_1.time_ >= var_348_14 + var_348_15 and arg_345_1.time_ < var_348_14 + var_348_15 + arg_348_0 then
				arg_345_1.allBtn_.enabled = true
			end

			local var_348_16 = 0

			if var_348_16 < arg_345_1.time_ and arg_345_1.time_ <= var_348_16 + arg_348_0 then
				arg_345_1.mask_.enabled = true
				arg_345_1.mask_.raycastTarget = true

				arg_345_1:SetGaussion(false)
			end

			local var_348_17 = 2

			if var_348_16 <= arg_345_1.time_ and arg_345_1.time_ < var_348_16 + var_348_17 then
				local var_348_18 = (arg_345_1.time_ - var_348_16) / var_348_17
				local var_348_19 = Color.New(0, 0, 0)

				var_348_19.a = Mathf.Lerp(0, 1, var_348_18)
				arg_345_1.mask_.color = var_348_19
			end

			if arg_345_1.time_ >= var_348_16 + var_348_17 and arg_345_1.time_ < var_348_16 + var_348_17 + arg_348_0 then
				local var_348_20 = Color.New(0, 0, 0)

				var_348_20.a = 1
				arg_345_1.mask_.color = var_348_20
			end

			local var_348_21 = 2

			if var_348_21 < arg_345_1.time_ and arg_345_1.time_ <= var_348_21 + arg_348_0 then
				arg_345_1.mask_.enabled = true
				arg_345_1.mask_.raycastTarget = true

				arg_345_1:SetGaussion(false)
			end

			local var_348_22 = 2

			if var_348_21 <= arg_345_1.time_ and arg_345_1.time_ < var_348_21 + var_348_22 then
				local var_348_23 = (arg_345_1.time_ - var_348_21) / var_348_22
				local var_348_24 = Color.New(0, 0, 0)

				var_348_24.a = Mathf.Lerp(1, 0, var_348_23)
				arg_345_1.mask_.color = var_348_24
			end

			if arg_345_1.time_ >= var_348_21 + var_348_22 and arg_345_1.time_ < var_348_21 + var_348_22 + arg_348_0 then
				local var_348_25 = Color.New(0, 0, 0)
				local var_348_26 = 0

				arg_345_1.mask_.enabled = false
				var_348_25.a = var_348_26
				arg_345_1.mask_.color = var_348_25
			end

			local var_348_27 = arg_345_1.actors_["1043ui_story"].transform
			local var_348_28 = 1.96599999815226

			if var_348_28 < arg_345_1.time_ and arg_345_1.time_ <= var_348_28 + arg_348_0 then
				arg_345_1.var_.moveOldPos1043ui_story = var_348_27.localPosition
			end

			local var_348_29 = 0.001

			if var_348_28 <= arg_345_1.time_ and arg_345_1.time_ < var_348_28 + var_348_29 then
				local var_348_30 = (arg_345_1.time_ - var_348_28) / var_348_29
				local var_348_31 = Vector3.New(0, 100, 0)

				var_348_27.localPosition = Vector3.Lerp(arg_345_1.var_.moveOldPos1043ui_story, var_348_31, var_348_30)

				local var_348_32 = manager.ui.mainCamera.transform.position - var_348_27.position

				var_348_27.forward = Vector3.New(var_348_32.x, var_348_32.y, var_348_32.z)

				local var_348_33 = var_348_27.localEulerAngles

				var_348_33.z = 0
				var_348_33.x = 0
				var_348_27.localEulerAngles = var_348_33
			end

			if arg_345_1.time_ >= var_348_28 + var_348_29 and arg_345_1.time_ < var_348_28 + var_348_29 + arg_348_0 then
				var_348_27.localPosition = Vector3.New(0, 100, 0)

				local var_348_34 = manager.ui.mainCamera.transform.position - var_348_27.position

				var_348_27.forward = Vector3.New(var_348_34.x, var_348_34.y, var_348_34.z)

				local var_348_35 = var_348_27.localEulerAngles

				var_348_35.z = 0
				var_348_35.x = 0
				var_348_27.localEulerAngles = var_348_35
			end

			local var_348_36 = arg_345_1.actors_["1043ui_story"]
			local var_348_37 = 1.96599999815226

			if var_348_37 < arg_345_1.time_ and arg_345_1.time_ <= var_348_37 + arg_348_0 and not isNil(var_348_36) and arg_345_1.var_.characterEffect1043ui_story == nil then
				arg_345_1.var_.characterEffect1043ui_story = var_348_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_348_38 = 0.034000001847744

			if var_348_37 <= arg_345_1.time_ and arg_345_1.time_ < var_348_37 + var_348_38 and not isNil(var_348_36) then
				local var_348_39 = (arg_345_1.time_ - var_348_37) / var_348_38

				if arg_345_1.var_.characterEffect1043ui_story and not isNil(var_348_36) then
					local var_348_40 = Mathf.Lerp(0, 0.5, var_348_39)

					arg_345_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_345_1.var_.characterEffect1043ui_story.fillRatio = var_348_40
				end
			end

			if arg_345_1.time_ >= var_348_37 + var_348_38 and arg_345_1.time_ < var_348_37 + var_348_38 + arg_348_0 and not isNil(var_348_36) and arg_345_1.var_.characterEffect1043ui_story then
				local var_348_41 = 0.5

				arg_345_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_345_1.var_.characterEffect1043ui_story.fillRatio = var_348_41
			end

			local var_348_42 = arg_345_1.actors_["1111ui_story"].transform
			local var_348_43 = 3.8

			if var_348_43 < arg_345_1.time_ and arg_345_1.time_ <= var_348_43 + arg_348_0 then
				arg_345_1.var_.moveOldPos1111ui_story = var_348_42.localPosition
			end

			local var_348_44 = 0.001

			if var_348_43 <= arg_345_1.time_ and arg_345_1.time_ < var_348_43 + var_348_44 then
				local var_348_45 = (arg_345_1.time_ - var_348_43) / var_348_44
				local var_348_46 = Vector3.New(0, -0.87, -5.7)

				var_348_42.localPosition = Vector3.Lerp(arg_345_1.var_.moveOldPos1111ui_story, var_348_46, var_348_45)

				local var_348_47 = manager.ui.mainCamera.transform.position - var_348_42.position

				var_348_42.forward = Vector3.New(var_348_47.x, var_348_47.y, var_348_47.z)

				local var_348_48 = var_348_42.localEulerAngles

				var_348_48.z = 0
				var_348_48.x = 0
				var_348_42.localEulerAngles = var_348_48
			end

			if arg_345_1.time_ >= var_348_43 + var_348_44 and arg_345_1.time_ < var_348_43 + var_348_44 + arg_348_0 then
				var_348_42.localPosition = Vector3.New(0, -0.87, -5.7)

				local var_348_49 = manager.ui.mainCamera.transform.position - var_348_42.position

				var_348_42.forward = Vector3.New(var_348_49.x, var_348_49.y, var_348_49.z)

				local var_348_50 = var_348_42.localEulerAngles

				var_348_50.z = 0
				var_348_50.x = 0
				var_348_42.localEulerAngles = var_348_50
			end

			local var_348_51 = arg_345_1.actors_["1111ui_story"]
			local var_348_52 = 3.8

			if var_348_52 < arg_345_1.time_ and arg_345_1.time_ <= var_348_52 + arg_348_0 and not isNil(var_348_51) and arg_345_1.var_.characterEffect1111ui_story == nil then
				arg_345_1.var_.characterEffect1111ui_story = var_348_51:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_348_53 = 0.200000002980232

			if var_348_52 <= arg_345_1.time_ and arg_345_1.time_ < var_348_52 + var_348_53 and not isNil(var_348_51) then
				local var_348_54 = (arg_345_1.time_ - var_348_52) / var_348_53

				if arg_345_1.var_.characterEffect1111ui_story and not isNil(var_348_51) then
					arg_345_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_345_1.time_ >= var_348_52 + var_348_53 and arg_345_1.time_ < var_348_52 + var_348_53 + arg_348_0 and not isNil(var_348_51) and arg_345_1.var_.characterEffect1111ui_story then
				arg_345_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_348_55 = 3.8

			if var_348_55 < arg_345_1.time_ and arg_345_1.time_ <= var_348_55 + arg_348_0 then
				arg_345_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action7_2")
			end

			local var_348_56 = 3.8

			if var_348_56 < arg_345_1.time_ and arg_345_1.time_ <= var_348_56 + arg_348_0 then
				arg_345_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if arg_345_1.frameCnt_ <= 1 then
				arg_345_1.dialog_:SetActive(false)
			end

			local var_348_57 = 4
			local var_348_58 = 0.325

			if var_348_57 < arg_345_1.time_ and arg_345_1.time_ <= var_348_57 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0

				arg_345_1.dialog_:SetActive(true)

				arg_345_1.dialogCg_.alpha = 0

				local var_348_59 = LeanTween.value(arg_345_1.dialog_, 0, 1, 0.3)

				var_348_59:setOnUpdate(LuaHelper.FloatAction(function(arg_349_0)
					arg_345_1.dialogCg_.alpha = arg_349_0
				end))
				var_348_59:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_345_1.dialog_)
					var_348_59:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_345_1.duration_ = arg_345_1.duration_ + 0.3

				SetActive(arg_345_1.leftNameGo_, true)

				local var_348_60 = arg_345_1:FormatText(StoryNameCfg[67].name)

				arg_345_1.leftNameTxt_.text = var_348_60

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_345_1.leftNameTxt_.transform)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1.leftNameTxt_.text)
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_61 = arg_345_1:GetWordFromCfg(321371082)
				local var_348_62 = arg_345_1:FormatText(var_348_61.content)

				arg_345_1.text_.text = var_348_62

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_63 = 13
				local var_348_64 = utf8.len(var_348_62)
				local var_348_65 = var_348_63 <= 0 and var_348_58 or var_348_58 * (var_348_64 / var_348_63)

				if var_348_65 > 0 and var_348_58 < var_348_65 then
					arg_345_1.talkMaxDuration = var_348_65
					var_348_57 = var_348_57 + 0.3

					if var_348_65 + var_348_57 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_65 + var_348_57
					end
				end

				arg_345_1.text_.text = var_348_62
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371082", "story_v_out_321371.awb") ~= 0 then
					local var_348_66 = manager.audio:GetVoiceLength("story_v_out_321371", "321371082", "story_v_out_321371.awb") / 1000

					if var_348_66 + var_348_57 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_66 + var_348_57
					end

					if var_348_61.prefab_name ~= "" and arg_345_1.actors_[var_348_61.prefab_name] ~= nil then
						local var_348_67 = LuaForUtil.PlayVoiceWithCriLipsync(arg_345_1.actors_[var_348_61.prefab_name].transform, "story_v_out_321371", "321371082", "story_v_out_321371.awb")

						arg_345_1:RecordAudio("321371082", var_348_67)
						arg_345_1:RecordAudio("321371082", var_348_67)
					else
						arg_345_1:AudioAction("play", "voice", "story_v_out_321371", "321371082", "story_v_out_321371.awb")
					end

					arg_345_1:RecordHistoryTalkVoice("story_v_out_321371", "321371082", "story_v_out_321371.awb")
				end

				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_68 = var_348_57 + 0.3
			local var_348_69 = math.max(var_348_58, arg_345_1.talkMaxDuration)

			if var_348_68 <= arg_345_1.time_ and arg_345_1.time_ < var_348_68 + var_348_69 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_68) / var_348_69

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_68 + var_348_69 and arg_345_1.time_ < var_348_68 + var_348_69 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_345_1:InitPlayNodeList()
	end,
	Play321371083 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 321371083
		arg_351_1.duration_ = 5

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play321371084(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			local var_354_0 = arg_351_1.actors_["1111ui_story"].transform
			local var_354_1 = 0

			if var_354_1 < arg_351_1.time_ and arg_351_1.time_ <= var_354_1 + arg_354_0 then
				arg_351_1.var_.moveOldPos1111ui_story = var_354_0.localPosition
			end

			local var_354_2 = 0.001

			if var_354_1 <= arg_351_1.time_ and arg_351_1.time_ < var_354_1 + var_354_2 then
				local var_354_3 = (arg_351_1.time_ - var_354_1) / var_354_2
				local var_354_4 = Vector3.New(0, 100, 0)

				var_354_0.localPosition = Vector3.Lerp(arg_351_1.var_.moveOldPos1111ui_story, var_354_4, var_354_3)

				local var_354_5 = manager.ui.mainCamera.transform.position - var_354_0.position

				var_354_0.forward = Vector3.New(var_354_5.x, var_354_5.y, var_354_5.z)

				local var_354_6 = var_354_0.localEulerAngles

				var_354_6.z = 0
				var_354_6.x = 0
				var_354_0.localEulerAngles = var_354_6
			end

			if arg_351_1.time_ >= var_354_1 + var_354_2 and arg_351_1.time_ < var_354_1 + var_354_2 + arg_354_0 then
				var_354_0.localPosition = Vector3.New(0, 100, 0)

				local var_354_7 = manager.ui.mainCamera.transform.position - var_354_0.position

				var_354_0.forward = Vector3.New(var_354_7.x, var_354_7.y, var_354_7.z)

				local var_354_8 = var_354_0.localEulerAngles

				var_354_8.z = 0
				var_354_8.x = 0
				var_354_0.localEulerAngles = var_354_8
			end

			local var_354_9 = arg_351_1.actors_["1111ui_story"]
			local var_354_10 = 0

			if var_354_10 < arg_351_1.time_ and arg_351_1.time_ <= var_354_10 + arg_354_0 and not isNil(var_354_9) and arg_351_1.var_.characterEffect1111ui_story == nil then
				arg_351_1.var_.characterEffect1111ui_story = var_354_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_354_11 = 0.200000002980232

			if var_354_10 <= arg_351_1.time_ and arg_351_1.time_ < var_354_10 + var_354_11 and not isNil(var_354_9) then
				local var_354_12 = (arg_351_1.time_ - var_354_10) / var_354_11

				if arg_351_1.var_.characterEffect1111ui_story and not isNil(var_354_9) then
					local var_354_13 = Mathf.Lerp(0, 0.5, var_354_12)

					arg_351_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_351_1.var_.characterEffect1111ui_story.fillRatio = var_354_13
				end
			end

			if arg_351_1.time_ >= var_354_10 + var_354_11 and arg_351_1.time_ < var_354_10 + var_354_11 + arg_354_0 and not isNil(var_354_9) and arg_351_1.var_.characterEffect1111ui_story then
				local var_354_14 = 0.5

				arg_351_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_351_1.var_.characterEffect1111ui_story.fillRatio = var_354_14
			end

			local var_354_15 = 0
			local var_354_16 = 0.8

			if var_354_15 < arg_351_1.time_ and arg_351_1.time_ <= var_354_15 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, false)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_17 = arg_351_1:GetWordFromCfg(321371083)
				local var_354_18 = arg_351_1:FormatText(var_354_17.content)

				arg_351_1.text_.text = var_354_18

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_19 = 32
				local var_354_20 = utf8.len(var_354_18)
				local var_354_21 = var_354_19 <= 0 and var_354_16 or var_354_16 * (var_354_20 / var_354_19)

				if var_354_21 > 0 and var_354_16 < var_354_21 then
					arg_351_1.talkMaxDuration = var_354_21

					if var_354_21 + var_354_15 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_21 + var_354_15
					end
				end

				arg_351_1.text_.text = var_354_18
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)
				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_22 = math.max(var_354_16, arg_351_1.talkMaxDuration)

			if var_354_15 <= arg_351_1.time_ and arg_351_1.time_ < var_354_15 + var_354_22 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_15) / var_354_22

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_15 + var_354_22 and arg_351_1.time_ < var_354_15 + var_354_22 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_351_1:InitPlayNodeList()
	end,
	Play321371084 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 321371084
		arg_355_1.duration_ = 5.33

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play321371085(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			local var_358_0 = manager.ui.mainCamera.transform
			local var_358_1 = 0

			if var_358_1 < arg_355_1.time_ and arg_355_1.time_ <= var_358_1 + arg_358_0 then
				local var_358_2 = arg_355_1.var_.effect498
				local var_358_3
				local var_358_4 = var_358_0

				if not var_358_2 then
					var_358_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_daoguang01"), var_358_4)
					var_358_2.name = "498"
					arg_355_1.var_.effect498 = var_358_2
				else
					var_358_2.transform:SetParent(var_358_4)
				end

				var_358_2.transform.localPosition = Vector3.New(0, 0, 0.66)
				var_358_2.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_358_5 = manager.ui.mainCameraCom_
				local var_358_6 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_358_5.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_358_7 = var_358_2.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_358_8 = 15
				local var_358_9 = 2 * var_358_8 * Mathf.Tan(var_358_5.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_358_5.aspect
				local var_358_10 = 1
				local var_358_11 = 1.7777777777777777

				if var_358_11 < var_358_5.aspect then
					var_358_10 = var_358_9 / (2 * var_358_8 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_358_11)
				end

				for iter_358_0, iter_358_1 in ipairs(var_358_7) do
					local var_358_12 = iter_358_1.transform.localScale

					iter_358_1.transform.localScale = Vector3.New(var_358_12.x / var_358_6 * var_358_10, var_358_12.y / var_358_6, var_358_12.z)
				end
			end

			local var_358_13 = manager.ui.mainCamera.transform
			local var_358_14 = 0.875

			if var_358_14 < arg_355_1.time_ and arg_355_1.time_ <= var_358_14 + arg_358_0 then
				local var_358_15 = arg_355_1.var_.effect498

				if var_358_15 then
					Object.Destroy(var_358_15)

					arg_355_1.var_.effect498 = nil
				end
			end

			local var_358_16 = 0

			if var_358_16 < arg_355_1.time_ and arg_355_1.time_ <= var_358_16 + arg_358_0 then
				arg_355_1.allBtn_.enabled = false
			end

			local var_358_17 = 0.875

			if arg_355_1.time_ >= var_358_16 + var_358_17 and arg_355_1.time_ < var_358_16 + var_358_17 + arg_358_0 then
				arg_355_1.allBtn_.enabled = true
			end

			local var_358_18 = manager.ui.mainCamera.transform
			local var_358_19 = 0

			if var_358_19 < arg_355_1.time_ and arg_355_1.time_ <= var_358_19 + arg_358_0 then
				local var_358_20 = arg_355_1.var_.effecttankai1
				local var_358_21
				local var_358_22 = var_358_18

				if not var_358_20 then
					var_358_20 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), var_358_22)
					var_358_20.name = "tankai1"
					arg_355_1.var_.effecttankai1 = var_358_20
				else
					var_358_20.transform:SetParent(var_358_22)
				end

				var_358_20.transform.localPosition = Vector3.New(0, 0, -1)
				var_358_20.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_358_23 = manager.ui.mainCamera.transform
			local var_358_24 = 1

			if var_358_24 < arg_355_1.time_ and arg_355_1.time_ <= var_358_24 + arg_358_0 then
				local var_358_25 = arg_355_1.var_.effecttankai1

				if var_358_25 then
					Object.Destroy(var_358_25)

					arg_355_1.var_.effecttankai1 = nil
				end
			end

			local var_358_26 = 0
			local var_358_27 = 1

			if var_358_26 < arg_355_1.time_ and arg_355_1.time_ <= var_358_26 + arg_358_0 then
				local var_358_28 = "play"
				local var_358_29 = "effect"

				arg_355_1:AudioAction(var_358_28, var_358_29, "se_story_120_00", "se_story_120_00_sword01", "")
			end

			local var_358_30 = 0.333333333333333
			local var_358_31 = 0.975

			if var_358_30 < arg_355_1.time_ and arg_355_1.time_ <= var_358_30 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, false)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_355_1.iconTrs_.gameObject, false)
				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_32 = arg_355_1:GetWordFromCfg(321371084)
				local var_358_33 = arg_355_1:FormatText(var_358_32.content)

				arg_355_1.text_.text = var_358_33

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_34 = 39
				local var_358_35 = utf8.len(var_358_33)
				local var_358_36 = var_358_34 <= 0 and var_358_31 or var_358_31 * (var_358_35 / var_358_34)

				if var_358_36 > 0 and var_358_31 < var_358_36 then
					arg_355_1.talkMaxDuration = var_358_36

					if var_358_36 + var_358_30 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_36 + var_358_30
					end
				end

				arg_355_1.text_.text = var_358_33
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)
				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_37 = math.max(var_358_31, arg_355_1.talkMaxDuration)

			if var_358_30 <= arg_355_1.time_ and arg_355_1.time_ < var_358_30 + var_358_37 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_30) / var_358_37

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_30 + var_358_37 and arg_355_1.time_ < var_358_30 + var_358_37 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {}

		arg_355_1:InitPlayNodeList()
	end,
	Play321371085 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 321371085
		arg_359_1.duration_ = 2

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play321371086(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			local var_362_0 = arg_359_1.actors_["1111ui_story"].transform
			local var_362_1 = 0

			if var_362_1 < arg_359_1.time_ and arg_359_1.time_ <= var_362_1 + arg_362_0 then
				arg_359_1.var_.moveOldPos1111ui_story = var_362_0.localPosition
			end

			local var_362_2 = 0.001

			if var_362_1 <= arg_359_1.time_ and arg_359_1.time_ < var_362_1 + var_362_2 then
				local var_362_3 = (arg_359_1.time_ - var_362_1) / var_362_2
				local var_362_4 = Vector3.New(0, -0.87, -5.7)

				var_362_0.localPosition = Vector3.Lerp(arg_359_1.var_.moveOldPos1111ui_story, var_362_4, var_362_3)

				local var_362_5 = manager.ui.mainCamera.transform.position - var_362_0.position

				var_362_0.forward = Vector3.New(var_362_5.x, var_362_5.y, var_362_5.z)

				local var_362_6 = var_362_0.localEulerAngles

				var_362_6.z = 0
				var_362_6.x = 0
				var_362_0.localEulerAngles = var_362_6
			end

			if arg_359_1.time_ >= var_362_1 + var_362_2 and arg_359_1.time_ < var_362_1 + var_362_2 + arg_362_0 then
				var_362_0.localPosition = Vector3.New(0, -0.87, -5.7)

				local var_362_7 = manager.ui.mainCamera.transform.position - var_362_0.position

				var_362_0.forward = Vector3.New(var_362_7.x, var_362_7.y, var_362_7.z)

				local var_362_8 = var_362_0.localEulerAngles

				var_362_8.z = 0
				var_362_8.x = 0
				var_362_0.localEulerAngles = var_362_8
			end

			local var_362_9 = arg_359_1.actors_["1111ui_story"]
			local var_362_10 = 0

			if var_362_10 < arg_359_1.time_ and arg_359_1.time_ <= var_362_10 + arg_362_0 and not isNil(var_362_9) and arg_359_1.var_.characterEffect1111ui_story == nil then
				arg_359_1.var_.characterEffect1111ui_story = var_362_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_362_11 = 0.200000002980232

			if var_362_10 <= arg_359_1.time_ and arg_359_1.time_ < var_362_10 + var_362_11 and not isNil(var_362_9) then
				local var_362_12 = (arg_359_1.time_ - var_362_10) / var_362_11

				if arg_359_1.var_.characterEffect1111ui_story and not isNil(var_362_9) then
					arg_359_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_359_1.time_ >= var_362_10 + var_362_11 and arg_359_1.time_ < var_362_10 + var_362_11 + arg_362_0 and not isNil(var_362_9) and arg_359_1.var_.characterEffect1111ui_story then
				arg_359_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_362_13 = 0

			if var_362_13 < arg_359_1.time_ and arg_359_1.time_ <= var_362_13 + arg_362_0 then
				arg_359_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action2_1")
			end

			local var_362_14 = 0

			if var_362_14 < arg_359_1.time_ and arg_359_1.time_ <= var_362_14 + arg_362_0 then
				arg_359_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva", "EmotionTimelineAnimator")
			end

			local var_362_15 = 0
			local var_362_16 = 0.15

			if var_362_15 < arg_359_1.time_ and arg_359_1.time_ <= var_362_15 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, true)

				local var_362_17 = arg_359_1:FormatText(StoryNameCfg[67].name)

				arg_359_1.leftNameTxt_.text = var_362_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_359_1.leftNameTxt_.transform)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1.leftNameTxt_.text)
				SetActive(arg_359_1.iconTrs_.gameObject, false)
				arg_359_1.callingController_:SetSelectedState("normal")

				local var_362_18 = arg_359_1:GetWordFromCfg(321371085)
				local var_362_19 = arg_359_1:FormatText(var_362_18.content)

				arg_359_1.text_.text = var_362_19

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_20 = 6
				local var_362_21 = utf8.len(var_362_19)
				local var_362_22 = var_362_20 <= 0 and var_362_16 or var_362_16 * (var_362_21 / var_362_20)

				if var_362_22 > 0 and var_362_16 < var_362_22 then
					arg_359_1.talkMaxDuration = var_362_22

					if var_362_22 + var_362_15 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_22 + var_362_15
					end
				end

				arg_359_1.text_.text = var_362_19
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371085", "story_v_out_321371.awb") ~= 0 then
					local var_362_23 = manager.audio:GetVoiceLength("story_v_out_321371", "321371085", "story_v_out_321371.awb") / 1000

					if var_362_23 + var_362_15 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_23 + var_362_15
					end

					if var_362_18.prefab_name ~= "" and arg_359_1.actors_[var_362_18.prefab_name] ~= nil then
						local var_362_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_359_1.actors_[var_362_18.prefab_name].transform, "story_v_out_321371", "321371085", "story_v_out_321371.awb")

						arg_359_1:RecordAudio("321371085", var_362_24)
						arg_359_1:RecordAudio("321371085", var_362_24)
					else
						arg_359_1:AudioAction("play", "voice", "story_v_out_321371", "321371085", "story_v_out_321371.awb")
					end

					arg_359_1:RecordHistoryTalkVoice("story_v_out_321371", "321371085", "story_v_out_321371.awb")
				end

				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_25 = math.max(var_362_16, arg_359_1.talkMaxDuration)

			if var_362_15 <= arg_359_1.time_ and arg_359_1.time_ < var_362_15 + var_362_25 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - var_362_15) / var_362_25

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= var_362_15 + var_362_25 and arg_359_1.time_ < var_362_15 + var_362_25 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_359_1:InitPlayNodeList()
	end,
	Play321371086 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 321371086
		arg_363_1.duration_ = 4.8

		local var_363_0 = {
			zh = 3,
			ja = 4.8
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
				arg_363_0:Play321371087(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			local var_366_0 = arg_363_1.actors_["1111ui_story"]
			local var_366_1 = 0

			if var_366_1 < arg_363_1.time_ and arg_363_1.time_ <= var_366_1 + arg_366_0 and not isNil(var_366_0) and arg_363_1.var_.characterEffect1111ui_story == nil then
				arg_363_1.var_.characterEffect1111ui_story = var_366_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_366_2 = 0.200000002980232

			if var_366_1 <= arg_363_1.time_ and arg_363_1.time_ < var_366_1 + var_366_2 and not isNil(var_366_0) then
				local var_366_3 = (arg_363_1.time_ - var_366_1) / var_366_2

				if arg_363_1.var_.characterEffect1111ui_story and not isNil(var_366_0) then
					local var_366_4 = Mathf.Lerp(0, 0.5, var_366_3)

					arg_363_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_363_1.var_.characterEffect1111ui_story.fillRatio = var_366_4
				end
			end

			if arg_363_1.time_ >= var_366_1 + var_366_2 and arg_363_1.time_ < var_366_1 + var_366_2 + arg_366_0 and not isNil(var_366_0) and arg_363_1.var_.characterEffect1111ui_story then
				local var_366_5 = 0.5

				arg_363_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_363_1.var_.characterEffect1111ui_story.fillRatio = var_366_5
			end

			local var_366_6 = 0
			local var_366_7 = 0.4

			if var_366_6 < arg_363_1.time_ and arg_363_1.time_ <= var_366_6 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, true)

				local var_366_8 = arg_363_1:FormatText(StoryNameCfg[1178].name)

				arg_363_1.leftNameTxt_.text = var_366_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_363_1.leftNameTxt_.transform)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1.leftNameTxt_.text)
				SetActive(arg_363_1.iconTrs_.gameObject, true)
				arg_363_1.iconController_:SetSelectedState("hero")

				arg_363_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10131")

				arg_363_1.callingController_:SetSelectedState("normal")

				arg_363_1.keyicon_.color = Color.New(1, 1, 1)
				arg_363_1.icon_.color = Color.New(1, 1, 1)

				local var_366_9 = arg_363_1:GetWordFromCfg(321371086)
				local var_366_10 = arg_363_1:FormatText(var_366_9.content)

				arg_363_1.text_.text = var_366_10

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_11 = 16
				local var_366_12 = utf8.len(var_366_10)
				local var_366_13 = var_366_11 <= 0 and var_366_7 or var_366_7 * (var_366_12 / var_366_11)

				if var_366_13 > 0 and var_366_7 < var_366_13 then
					arg_363_1.talkMaxDuration = var_366_13

					if var_366_13 + var_366_6 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_13 + var_366_6
					end
				end

				arg_363_1.text_.text = var_366_10
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371086", "story_v_out_321371.awb") ~= 0 then
					local var_366_14 = manager.audio:GetVoiceLength("story_v_out_321371", "321371086", "story_v_out_321371.awb") / 1000

					if var_366_14 + var_366_6 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_14 + var_366_6
					end

					if var_366_9.prefab_name ~= "" and arg_363_1.actors_[var_366_9.prefab_name] ~= nil then
						local var_366_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_363_1.actors_[var_366_9.prefab_name].transform, "story_v_out_321371", "321371086", "story_v_out_321371.awb")

						arg_363_1:RecordAudio("321371086", var_366_15)
						arg_363_1:RecordAudio("321371086", var_366_15)
					else
						arg_363_1:AudioAction("play", "voice", "story_v_out_321371", "321371086", "story_v_out_321371.awb")
					end

					arg_363_1:RecordHistoryTalkVoice("story_v_out_321371", "321371086", "story_v_out_321371.awb")
				end

				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_16 = math.max(var_366_7, arg_363_1.talkMaxDuration)

			if var_366_6 <= arg_363_1.time_ and arg_363_1.time_ < var_366_6 + var_366_16 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - var_366_6) / var_366_16

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= var_366_6 + var_366_16 and arg_363_1.time_ < var_366_6 + var_366_16 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {}

		arg_363_1:InitPlayNodeList()
	end,
	Play321371087 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 321371087
		arg_367_1.duration_ = 5

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play321371088(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			local var_370_0 = arg_367_1.actors_["10131ui_story"].transform
			local var_370_1 = 0

			if var_370_1 < arg_367_1.time_ and arg_367_1.time_ <= var_370_1 + arg_370_0 then
				arg_367_1.var_.moveOldPos10131ui_story = var_370_0.localPosition
			end

			local var_370_2 = 0.001

			if var_370_1 <= arg_367_1.time_ and arg_367_1.time_ < var_370_1 + var_370_2 then
				local var_370_3 = (arg_367_1.time_ - var_370_1) / var_370_2
				local var_370_4 = Vector3.New(0, 100, 0)

				var_370_0.localPosition = Vector3.Lerp(arg_367_1.var_.moveOldPos10131ui_story, var_370_4, var_370_3)

				local var_370_5 = manager.ui.mainCamera.transform.position - var_370_0.position

				var_370_0.forward = Vector3.New(var_370_5.x, var_370_5.y, var_370_5.z)

				local var_370_6 = var_370_0.localEulerAngles

				var_370_6.z = 0
				var_370_6.x = 0
				var_370_0.localEulerAngles = var_370_6
			end

			if arg_367_1.time_ >= var_370_1 + var_370_2 and arg_367_1.time_ < var_370_1 + var_370_2 + arg_370_0 then
				var_370_0.localPosition = Vector3.New(0, 100, 0)

				local var_370_7 = manager.ui.mainCamera.transform.position - var_370_0.position

				var_370_0.forward = Vector3.New(var_370_7.x, var_370_7.y, var_370_7.z)

				local var_370_8 = var_370_0.localEulerAngles

				var_370_8.z = 0
				var_370_8.x = 0
				var_370_0.localEulerAngles = var_370_8
			end

			local var_370_9 = arg_367_1.actors_["1111ui_story"].transform
			local var_370_10 = 0

			if var_370_10 < arg_367_1.time_ and arg_367_1.time_ <= var_370_10 + arg_370_0 then
				arg_367_1.var_.moveOldPos1111ui_story = var_370_9.localPosition
			end

			local var_370_11 = 0.001

			if var_370_10 <= arg_367_1.time_ and arg_367_1.time_ < var_370_10 + var_370_11 then
				local var_370_12 = (arg_367_1.time_ - var_370_10) / var_370_11
				local var_370_13 = Vector3.New(0, 100, 0)

				var_370_9.localPosition = Vector3.Lerp(arg_367_1.var_.moveOldPos1111ui_story, var_370_13, var_370_12)

				local var_370_14 = manager.ui.mainCamera.transform.position - var_370_9.position

				var_370_9.forward = Vector3.New(var_370_14.x, var_370_14.y, var_370_14.z)

				local var_370_15 = var_370_9.localEulerAngles

				var_370_15.z = 0
				var_370_15.x = 0
				var_370_9.localEulerAngles = var_370_15
			end

			if arg_367_1.time_ >= var_370_10 + var_370_11 and arg_367_1.time_ < var_370_10 + var_370_11 + arg_370_0 then
				var_370_9.localPosition = Vector3.New(0, 100, 0)

				local var_370_16 = manager.ui.mainCamera.transform.position - var_370_9.position

				var_370_9.forward = Vector3.New(var_370_16.x, var_370_16.y, var_370_16.z)

				local var_370_17 = var_370_9.localEulerAngles

				var_370_17.z = 0
				var_370_17.x = 0
				var_370_9.localEulerAngles = var_370_17
			end

			local var_370_18 = 0
			local var_370_19 = 1.525

			if var_370_18 < arg_367_1.time_ and arg_367_1.time_ <= var_370_18 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, false)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_367_1.iconTrs_.gameObject, false)
				arg_367_1.callingController_:SetSelectedState("normal")

				local var_370_20 = arg_367_1:GetWordFromCfg(321371087)
				local var_370_21 = arg_367_1:FormatText(var_370_20.content)

				arg_367_1.text_.text = var_370_21

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_22 = 61
				local var_370_23 = utf8.len(var_370_21)
				local var_370_24 = var_370_22 <= 0 and var_370_19 or var_370_19 * (var_370_23 / var_370_22)

				if var_370_24 > 0 and var_370_19 < var_370_24 then
					arg_367_1.talkMaxDuration = var_370_24

					if var_370_24 + var_370_18 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_24 + var_370_18
					end
				end

				arg_367_1.text_.text = var_370_21
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)
				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_25 = math.max(var_370_19, arg_367_1.talkMaxDuration)

			if var_370_18 <= arg_367_1.time_ and arg_367_1.time_ < var_370_18 + var_370_25 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - var_370_18) / var_370_25

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= var_370_18 + var_370_25 and arg_367_1.time_ < var_370_18 + var_370_25 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10131ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_367_1:InitPlayNodeList()
	end,
	Play321371088 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 321371088
		arg_371_1.duration_ = 4.27

		local var_371_0 = {
			zh = 4.266,
			ja = 4.2
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
				arg_371_0:Play321371089(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			local var_374_0 = arg_371_1.actors_["1111ui_story"].transform
			local var_374_1 = 0

			if var_374_1 < arg_371_1.time_ and arg_371_1.time_ <= var_374_1 + arg_374_0 then
				arg_371_1.var_.moveOldPos1111ui_story = var_374_0.localPosition
			end

			local var_374_2 = 0.001

			if var_374_1 <= arg_371_1.time_ and arg_371_1.time_ < var_374_1 + var_374_2 then
				local var_374_3 = (arg_371_1.time_ - var_374_1) / var_374_2
				local var_374_4 = Vector3.New(0, -0.87, -5.7)

				var_374_0.localPosition = Vector3.Lerp(arg_371_1.var_.moveOldPos1111ui_story, var_374_4, var_374_3)

				local var_374_5 = manager.ui.mainCamera.transform.position - var_374_0.position

				var_374_0.forward = Vector3.New(var_374_5.x, var_374_5.y, var_374_5.z)

				local var_374_6 = var_374_0.localEulerAngles

				var_374_6.z = 0
				var_374_6.x = 0
				var_374_0.localEulerAngles = var_374_6
			end

			if arg_371_1.time_ >= var_374_1 + var_374_2 and arg_371_1.time_ < var_374_1 + var_374_2 + arg_374_0 then
				var_374_0.localPosition = Vector3.New(0, -0.87, -5.7)

				local var_374_7 = manager.ui.mainCamera.transform.position - var_374_0.position

				var_374_0.forward = Vector3.New(var_374_7.x, var_374_7.y, var_374_7.z)

				local var_374_8 = var_374_0.localEulerAngles

				var_374_8.z = 0
				var_374_8.x = 0
				var_374_0.localEulerAngles = var_374_8
			end

			local var_374_9 = arg_371_1.actors_["1111ui_story"]
			local var_374_10 = 0

			if var_374_10 < arg_371_1.time_ and arg_371_1.time_ <= var_374_10 + arg_374_0 and not isNil(var_374_9) and arg_371_1.var_.characterEffect1111ui_story == nil then
				arg_371_1.var_.characterEffect1111ui_story = var_374_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_374_11 = 0.200000002980232

			if var_374_10 <= arg_371_1.time_ and arg_371_1.time_ < var_374_10 + var_374_11 and not isNil(var_374_9) then
				local var_374_12 = (arg_371_1.time_ - var_374_10) / var_374_11

				if arg_371_1.var_.characterEffect1111ui_story and not isNil(var_374_9) then
					arg_371_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_371_1.time_ >= var_374_10 + var_374_11 and arg_371_1.time_ < var_374_10 + var_374_11 + arg_374_0 and not isNil(var_374_9) and arg_371_1.var_.characterEffect1111ui_story then
				arg_371_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_374_13 = 0

			if var_374_13 < arg_371_1.time_ and arg_371_1.time_ <= var_374_13 + arg_374_0 then
				arg_371_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action2_2")
			end

			local var_374_14 = 0

			if var_374_14 < arg_371_1.time_ and arg_371_1.time_ <= var_374_14 + arg_374_0 then
				arg_371_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_374_15 = 0
			local var_374_16 = 0.5

			if var_374_15 < arg_371_1.time_ and arg_371_1.time_ <= var_374_15 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, true)

				local var_374_17 = arg_371_1:FormatText(StoryNameCfg[67].name)

				arg_371_1.leftNameTxt_.text = var_374_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_371_1.leftNameTxt_.transform)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1.leftNameTxt_.text)
				SetActive(arg_371_1.iconTrs_.gameObject, false)
				arg_371_1.callingController_:SetSelectedState("normal")

				local var_374_18 = arg_371_1:GetWordFromCfg(321371088)
				local var_374_19 = arg_371_1:FormatText(var_374_18.content)

				arg_371_1.text_.text = var_374_19

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_20 = 20
				local var_374_21 = utf8.len(var_374_19)
				local var_374_22 = var_374_20 <= 0 and var_374_16 or var_374_16 * (var_374_21 / var_374_20)

				if var_374_22 > 0 and var_374_16 < var_374_22 then
					arg_371_1.talkMaxDuration = var_374_22

					if var_374_22 + var_374_15 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_22 + var_374_15
					end
				end

				arg_371_1.text_.text = var_374_19
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371088", "story_v_out_321371.awb") ~= 0 then
					local var_374_23 = manager.audio:GetVoiceLength("story_v_out_321371", "321371088", "story_v_out_321371.awb") / 1000

					if var_374_23 + var_374_15 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_23 + var_374_15
					end

					if var_374_18.prefab_name ~= "" and arg_371_1.actors_[var_374_18.prefab_name] ~= nil then
						local var_374_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_371_1.actors_[var_374_18.prefab_name].transform, "story_v_out_321371", "321371088", "story_v_out_321371.awb")

						arg_371_1:RecordAudio("321371088", var_374_24)
						arg_371_1:RecordAudio("321371088", var_374_24)
					else
						arg_371_1:AudioAction("play", "voice", "story_v_out_321371", "321371088", "story_v_out_321371.awb")
					end

					arg_371_1:RecordHistoryTalkVoice("story_v_out_321371", "321371088", "story_v_out_321371.awb")
				end

				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_25 = math.max(var_374_16, arg_371_1.talkMaxDuration)

			if var_374_15 <= arg_371_1.time_ and arg_371_1.time_ < var_374_15 + var_374_25 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - var_374_15) / var_374_25

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= var_374_15 + var_374_25 and arg_371_1.time_ < var_374_15 + var_374_25 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_371_1:InitPlayNodeList()
	end,
	Play321371089 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 321371089
		arg_375_1.duration_ = 8.7

		local var_375_0 = {
			zh = 6.9,
			ja = 8.7
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
				arg_375_0:Play321371090(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			local var_378_0 = 0
			local var_378_1 = 0.7

			if var_378_0 < arg_375_1.time_ and arg_375_1.time_ <= var_378_0 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, true)

				local var_378_2 = arg_375_1:FormatText(StoryNameCfg[67].name)

				arg_375_1.leftNameTxt_.text = var_378_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_375_1.leftNameTxt_.transform)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1.leftNameTxt_.text)
				SetActive(arg_375_1.iconTrs_.gameObject, false)
				arg_375_1.callingController_:SetSelectedState("normal")

				local var_378_3 = arg_375_1:GetWordFromCfg(321371089)
				local var_378_4 = arg_375_1:FormatText(var_378_3.content)

				arg_375_1.text_.text = var_378_4

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_5 = 28
				local var_378_6 = utf8.len(var_378_4)
				local var_378_7 = var_378_5 <= 0 and var_378_1 or var_378_1 * (var_378_6 / var_378_5)

				if var_378_7 > 0 and var_378_1 < var_378_7 then
					arg_375_1.talkMaxDuration = var_378_7

					if var_378_7 + var_378_0 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_7 + var_378_0
					end
				end

				arg_375_1.text_.text = var_378_4
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371089", "story_v_out_321371.awb") ~= 0 then
					local var_378_8 = manager.audio:GetVoiceLength("story_v_out_321371", "321371089", "story_v_out_321371.awb") / 1000

					if var_378_8 + var_378_0 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_8 + var_378_0
					end

					if var_378_3.prefab_name ~= "" and arg_375_1.actors_[var_378_3.prefab_name] ~= nil then
						local var_378_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_375_1.actors_[var_378_3.prefab_name].transform, "story_v_out_321371", "321371089", "story_v_out_321371.awb")

						arg_375_1:RecordAudio("321371089", var_378_9)
						arg_375_1:RecordAudio("321371089", var_378_9)
					else
						arg_375_1:AudioAction("play", "voice", "story_v_out_321371", "321371089", "story_v_out_321371.awb")
					end

					arg_375_1:RecordHistoryTalkVoice("story_v_out_321371", "321371089", "story_v_out_321371.awb")
				end

				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_10 = math.max(var_378_1, arg_375_1.talkMaxDuration)

			if var_378_0 <= arg_375_1.time_ and arg_375_1.time_ < var_378_0 + var_378_10 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - var_378_0) / var_378_10

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= var_378_0 + var_378_10 and arg_375_1.time_ < var_378_0 + var_378_10 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {}

		arg_375_1:InitPlayNodeList()
	end,
	Play321371090 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 321371090
		arg_379_1.duration_ = 7

		local var_379_0 = {
			zh = 6.6,
			ja = 7
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
				arg_379_0:Play321371091(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			local var_382_0 = arg_379_1.actors_["1111ui_story"].transform
			local var_382_1 = 0

			if var_382_1 < arg_379_1.time_ and arg_379_1.time_ <= var_382_1 + arg_382_0 then
				arg_379_1.var_.moveOldPos1111ui_story = var_382_0.localPosition
			end

			local var_382_2 = 0.001

			if var_382_1 <= arg_379_1.time_ and arg_379_1.time_ < var_382_1 + var_382_2 then
				local var_382_3 = (arg_379_1.time_ - var_382_1) / var_382_2
				local var_382_4 = Vector3.New(0, -0.87, -5.7)

				var_382_0.localPosition = Vector3.Lerp(arg_379_1.var_.moveOldPos1111ui_story, var_382_4, var_382_3)

				local var_382_5 = manager.ui.mainCamera.transform.position - var_382_0.position

				var_382_0.forward = Vector3.New(var_382_5.x, var_382_5.y, var_382_5.z)

				local var_382_6 = var_382_0.localEulerAngles

				var_382_6.z = 0
				var_382_6.x = 0
				var_382_0.localEulerAngles = var_382_6
			end

			if arg_379_1.time_ >= var_382_1 + var_382_2 and arg_379_1.time_ < var_382_1 + var_382_2 + arg_382_0 then
				var_382_0.localPosition = Vector3.New(0, -0.87, -5.7)

				local var_382_7 = manager.ui.mainCamera.transform.position - var_382_0.position

				var_382_0.forward = Vector3.New(var_382_7.x, var_382_7.y, var_382_7.z)

				local var_382_8 = var_382_0.localEulerAngles

				var_382_8.z = 0
				var_382_8.x = 0
				var_382_0.localEulerAngles = var_382_8
			end

			local var_382_9 = 0

			if var_382_9 < arg_379_1.time_ and arg_379_1.time_ <= var_382_9 + arg_382_0 then
				arg_379_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action4_1")
			end

			local var_382_10 = 0

			if var_382_10 < arg_379_1.time_ and arg_379_1.time_ <= var_382_10 + arg_382_0 then
				arg_379_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1301cva", "EmotionTimelineAnimator")
			end

			local var_382_11 = 0
			local var_382_12 = 0.75

			if var_382_11 < arg_379_1.time_ and arg_379_1.time_ <= var_382_11 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, true)

				local var_382_13 = arg_379_1:FormatText(StoryNameCfg[67].name)

				arg_379_1.leftNameTxt_.text = var_382_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_379_1.leftNameTxt_.transform)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1.leftNameTxt_.text)
				SetActive(arg_379_1.iconTrs_.gameObject, false)
				arg_379_1.callingController_:SetSelectedState("normal")

				local var_382_14 = arg_379_1:GetWordFromCfg(321371090)
				local var_382_15 = arg_379_1:FormatText(var_382_14.content)

				arg_379_1.text_.text = var_382_15

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_16 = 30
				local var_382_17 = utf8.len(var_382_15)
				local var_382_18 = var_382_16 <= 0 and var_382_12 or var_382_12 * (var_382_17 / var_382_16)

				if var_382_18 > 0 and var_382_12 < var_382_18 then
					arg_379_1.talkMaxDuration = var_382_18

					if var_382_18 + var_382_11 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_18 + var_382_11
					end
				end

				arg_379_1.text_.text = var_382_15
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371090", "story_v_out_321371.awb") ~= 0 then
					local var_382_19 = manager.audio:GetVoiceLength("story_v_out_321371", "321371090", "story_v_out_321371.awb") / 1000

					if var_382_19 + var_382_11 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_19 + var_382_11
					end

					if var_382_14.prefab_name ~= "" and arg_379_1.actors_[var_382_14.prefab_name] ~= nil then
						local var_382_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_379_1.actors_[var_382_14.prefab_name].transform, "story_v_out_321371", "321371090", "story_v_out_321371.awb")

						arg_379_1:RecordAudio("321371090", var_382_20)
						arg_379_1:RecordAudio("321371090", var_382_20)
					else
						arg_379_1:AudioAction("play", "voice", "story_v_out_321371", "321371090", "story_v_out_321371.awb")
					end

					arg_379_1:RecordHistoryTalkVoice("story_v_out_321371", "321371090", "story_v_out_321371.awb")
				end

				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_21 = math.max(var_382_12, arg_379_1.talkMaxDuration)

			if var_382_11 <= arg_379_1.time_ and arg_379_1.time_ < var_382_11 + var_382_21 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - var_382_11) / var_382_21

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= var_382_11 + var_382_21 and arg_379_1.time_ < var_382_11 + var_382_21 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_379_1:InitPlayNodeList()
	end,
	Play321371091 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 321371091
		arg_383_1.duration_ = 5

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"
		end

		function arg_383_1.playNext_(arg_385_0)
			if arg_385_0 == 1 then
				arg_383_0:Play321371092(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			local var_386_0 = arg_383_1.actors_["1111ui_story"].transform
			local var_386_1 = 0

			if var_386_1 < arg_383_1.time_ and arg_383_1.time_ <= var_386_1 + arg_386_0 then
				arg_383_1.var_.moveOldPos1111ui_story = var_386_0.localPosition
			end

			local var_386_2 = 0.001

			if var_386_1 <= arg_383_1.time_ and arg_383_1.time_ < var_386_1 + var_386_2 then
				local var_386_3 = (arg_383_1.time_ - var_386_1) / var_386_2
				local var_386_4 = Vector3.New(0, 100, 0)

				var_386_0.localPosition = Vector3.Lerp(arg_383_1.var_.moveOldPos1111ui_story, var_386_4, var_386_3)

				local var_386_5 = manager.ui.mainCamera.transform.position - var_386_0.position

				var_386_0.forward = Vector3.New(var_386_5.x, var_386_5.y, var_386_5.z)

				local var_386_6 = var_386_0.localEulerAngles

				var_386_6.z = 0
				var_386_6.x = 0
				var_386_0.localEulerAngles = var_386_6
			end

			if arg_383_1.time_ >= var_386_1 + var_386_2 and arg_383_1.time_ < var_386_1 + var_386_2 + arg_386_0 then
				var_386_0.localPosition = Vector3.New(0, 100, 0)

				local var_386_7 = manager.ui.mainCamera.transform.position - var_386_0.position

				var_386_0.forward = Vector3.New(var_386_7.x, var_386_7.y, var_386_7.z)

				local var_386_8 = var_386_0.localEulerAngles

				var_386_8.z = 0
				var_386_8.x = 0
				var_386_0.localEulerAngles = var_386_8
			end

			local var_386_9 = arg_383_1.actors_["1111ui_story"]
			local var_386_10 = 0

			if var_386_10 < arg_383_1.time_ and arg_383_1.time_ <= var_386_10 + arg_386_0 and not isNil(var_386_9) and arg_383_1.var_.characterEffect1111ui_story == nil then
				arg_383_1.var_.characterEffect1111ui_story = var_386_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_386_11 = 0.200000002980232

			if var_386_10 <= arg_383_1.time_ and arg_383_1.time_ < var_386_10 + var_386_11 and not isNil(var_386_9) then
				local var_386_12 = (arg_383_1.time_ - var_386_10) / var_386_11

				if arg_383_1.var_.characterEffect1111ui_story and not isNil(var_386_9) then
					local var_386_13 = Mathf.Lerp(0, 0.5, var_386_12)

					arg_383_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_383_1.var_.characterEffect1111ui_story.fillRatio = var_386_13
				end
			end

			if arg_383_1.time_ >= var_386_10 + var_386_11 and arg_383_1.time_ < var_386_10 + var_386_11 + arg_386_0 and not isNil(var_386_9) and arg_383_1.var_.characterEffect1111ui_story then
				local var_386_14 = 0.5

				arg_383_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_383_1.var_.characterEffect1111ui_story.fillRatio = var_386_14
			end

			local var_386_15 = 0
			local var_386_16 = 0.475

			if var_386_15 < arg_383_1.time_ and arg_383_1.time_ <= var_386_15 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, false)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_383_1.iconTrs_.gameObject, false)
				arg_383_1.callingController_:SetSelectedState("normal")

				local var_386_17 = arg_383_1:GetWordFromCfg(321371091)
				local var_386_18 = arg_383_1:FormatText(var_386_17.content)

				arg_383_1.text_.text = var_386_18

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_19 = 19
				local var_386_20 = utf8.len(var_386_18)
				local var_386_21 = var_386_19 <= 0 and var_386_16 or var_386_16 * (var_386_20 / var_386_19)

				if var_386_21 > 0 and var_386_16 < var_386_21 then
					arg_383_1.talkMaxDuration = var_386_21

					if var_386_21 + var_386_15 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_21 + var_386_15
					end
				end

				arg_383_1.text_.text = var_386_18
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)
				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_22 = math.max(var_386_16, arg_383_1.talkMaxDuration)

			if var_386_15 <= arg_383_1.time_ and arg_383_1.time_ < var_386_15 + var_386_22 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - var_386_15) / var_386_22

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= var_386_15 + var_386_22 and arg_383_1.time_ < var_386_15 + var_386_22 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_383_1:InitPlayNodeList()
	end,
	Play321371092 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 321371092
		arg_387_1.duration_ = 5

		SetActive(arg_387_1.tipsGo_, false)

		function arg_387_1.onSingleLineFinish_()
			arg_387_1.onSingleLineUpdate_ = nil
			arg_387_1.onSingleLineFinish_ = nil
			arg_387_1.state_ = "waiting"
		end

		function arg_387_1.playNext_(arg_389_0)
			if arg_389_0 == 1 then
				arg_387_0:Play321371093(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			local var_390_0 = 0
			local var_390_1 = 1.625

			if var_390_0 < arg_387_1.time_ and arg_387_1.time_ <= var_390_0 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0
				arg_387_1.dialogCg_.alpha = 1

				arg_387_1.dialog_:SetActive(true)
				SetActive(arg_387_1.leftNameGo_, false)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_387_1.iconTrs_.gameObject, false)
				arg_387_1.callingController_:SetSelectedState("normal")

				local var_390_2 = arg_387_1:GetWordFromCfg(321371092)
				local var_390_3 = arg_387_1:FormatText(var_390_2.content)

				arg_387_1.text_.text = var_390_3

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_4 = 65
				local var_390_5 = utf8.len(var_390_3)
				local var_390_6 = var_390_4 <= 0 and var_390_1 or var_390_1 * (var_390_5 / var_390_4)

				if var_390_6 > 0 and var_390_1 < var_390_6 then
					arg_387_1.talkMaxDuration = var_390_6

					if var_390_6 + var_390_0 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_6 + var_390_0
					end
				end

				arg_387_1.text_.text = var_390_3
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)
				arg_387_1:RecordContent(arg_387_1.text_.text)
			end

			local var_390_7 = math.max(var_390_1, arg_387_1.talkMaxDuration)

			if var_390_0 <= arg_387_1.time_ and arg_387_1.time_ < var_390_0 + var_390_7 then
				arg_387_1.typewritter.percent = (arg_387_1.time_ - var_390_0) / var_390_7

				arg_387_1.typewritter:SetDirty()
			end

			if arg_387_1.time_ >= var_390_0 + var_390_7 and arg_387_1.time_ < var_390_0 + var_390_7 + arg_390_0 then
				arg_387_1.typewritter.percent = 1

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(true)
			end
		end

		arg_387_1.nodeConfigList_ = {}

		arg_387_1:InitPlayNodeList()
	end,
	Play321371093 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 321371093
		arg_391_1.duration_ = 2.93

		local var_391_0 = {
			zh = 2.933,
			ja = 1.999999999999
		}
		local var_391_1 = manager.audio:GetLocalizationFlag()

		if var_391_0[var_391_1] ~= nil then
			arg_391_1.duration_ = var_391_0[var_391_1]
		end

		SetActive(arg_391_1.tipsGo_, false)

		function arg_391_1.onSingleLineFinish_()
			arg_391_1.onSingleLineUpdate_ = nil
			arg_391_1.onSingleLineFinish_ = nil
			arg_391_1.state_ = "waiting"
		end

		function arg_391_1.playNext_(arg_393_0)
			if arg_393_0 == 1 then
				arg_391_0:Play321371094(arg_391_1)
			end
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			local var_394_0 = arg_391_1.actors_["1111ui_story"].transform
			local var_394_1 = 0

			if var_394_1 < arg_391_1.time_ and arg_391_1.time_ <= var_394_1 + arg_394_0 then
				arg_391_1.var_.moveOldPos1111ui_story = var_394_0.localPosition
			end

			local var_394_2 = 0.001

			if var_394_1 <= arg_391_1.time_ and arg_391_1.time_ < var_394_1 + var_394_2 then
				local var_394_3 = (arg_391_1.time_ - var_394_1) / var_394_2
				local var_394_4 = Vector3.New(0, -0.87, -5.7)

				var_394_0.localPosition = Vector3.Lerp(arg_391_1.var_.moveOldPos1111ui_story, var_394_4, var_394_3)

				local var_394_5 = manager.ui.mainCamera.transform.position - var_394_0.position

				var_394_0.forward = Vector3.New(var_394_5.x, var_394_5.y, var_394_5.z)

				local var_394_6 = var_394_0.localEulerAngles

				var_394_6.z = 0
				var_394_6.x = 0
				var_394_0.localEulerAngles = var_394_6
			end

			if arg_391_1.time_ >= var_394_1 + var_394_2 and arg_391_1.time_ < var_394_1 + var_394_2 + arg_394_0 then
				var_394_0.localPosition = Vector3.New(0, -0.87, -5.7)

				local var_394_7 = manager.ui.mainCamera.transform.position - var_394_0.position

				var_394_0.forward = Vector3.New(var_394_7.x, var_394_7.y, var_394_7.z)

				local var_394_8 = var_394_0.localEulerAngles

				var_394_8.z = 0
				var_394_8.x = 0
				var_394_0.localEulerAngles = var_394_8
			end

			local var_394_9 = arg_391_1.actors_["1111ui_story"]
			local var_394_10 = 0

			if var_394_10 < arg_391_1.time_ and arg_391_1.time_ <= var_394_10 + arg_394_0 and not isNil(var_394_9) and arg_391_1.var_.characterEffect1111ui_story == nil then
				arg_391_1.var_.characterEffect1111ui_story = var_394_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_394_11 = 0.200000002980232

			if var_394_10 <= arg_391_1.time_ and arg_391_1.time_ < var_394_10 + var_394_11 and not isNil(var_394_9) then
				local var_394_12 = (arg_391_1.time_ - var_394_10) / var_394_11

				if arg_391_1.var_.characterEffect1111ui_story and not isNil(var_394_9) then
					arg_391_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_391_1.time_ >= var_394_10 + var_394_11 and arg_391_1.time_ < var_394_10 + var_394_11 + arg_394_0 and not isNil(var_394_9) and arg_391_1.var_.characterEffect1111ui_story then
				arg_391_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_394_13 = 0

			if var_394_13 < arg_391_1.time_ and arg_391_1.time_ <= var_394_13 + arg_394_0 then
				arg_391_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111actionlink/1111action445")
			end

			local var_394_14 = 0

			if var_394_14 < arg_391_1.time_ and arg_391_1.time_ <= var_394_14 + arg_394_0 then
				arg_391_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_394_15 = 0
			local var_394_16 = 0.15

			if var_394_15 < arg_391_1.time_ and arg_391_1.time_ <= var_394_15 + arg_394_0 then
				arg_391_1.talkMaxDuration = 0
				arg_391_1.dialogCg_.alpha = 1

				arg_391_1.dialog_:SetActive(true)
				SetActive(arg_391_1.leftNameGo_, true)

				local var_394_17 = arg_391_1:FormatText(StoryNameCfg[67].name)

				arg_391_1.leftNameTxt_.text = var_394_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_391_1.leftNameTxt_.transform)

				arg_391_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_391_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_391_1:RecordName(arg_391_1.leftNameTxt_.text)
				SetActive(arg_391_1.iconTrs_.gameObject, false)
				arg_391_1.callingController_:SetSelectedState("normal")

				local var_394_18 = arg_391_1:GetWordFromCfg(321371093)
				local var_394_19 = arg_391_1:FormatText(var_394_18.content)

				arg_391_1.text_.text = var_394_19

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_20 = 6
				local var_394_21 = utf8.len(var_394_19)
				local var_394_22 = var_394_20 <= 0 and var_394_16 or var_394_16 * (var_394_21 / var_394_20)

				if var_394_22 > 0 and var_394_16 < var_394_22 then
					arg_391_1.talkMaxDuration = var_394_22

					if var_394_22 + var_394_15 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_22 + var_394_15
					end
				end

				arg_391_1.text_.text = var_394_19
				arg_391_1.typewritter.percent = 0

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371093", "story_v_out_321371.awb") ~= 0 then
					local var_394_23 = manager.audio:GetVoiceLength("story_v_out_321371", "321371093", "story_v_out_321371.awb") / 1000

					if var_394_23 + var_394_15 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_23 + var_394_15
					end

					if var_394_18.prefab_name ~= "" and arg_391_1.actors_[var_394_18.prefab_name] ~= nil then
						local var_394_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_391_1.actors_[var_394_18.prefab_name].transform, "story_v_out_321371", "321371093", "story_v_out_321371.awb")

						arg_391_1:RecordAudio("321371093", var_394_24)
						arg_391_1:RecordAudio("321371093", var_394_24)
					else
						arg_391_1:AudioAction("play", "voice", "story_v_out_321371", "321371093", "story_v_out_321371.awb")
					end

					arg_391_1:RecordHistoryTalkVoice("story_v_out_321371", "321371093", "story_v_out_321371.awb")
				end

				arg_391_1:RecordContent(arg_391_1.text_.text)
			end

			local var_394_25 = math.max(var_394_16, arg_391_1.talkMaxDuration)

			if var_394_15 <= arg_391_1.time_ and arg_391_1.time_ < var_394_15 + var_394_25 then
				arg_391_1.typewritter.percent = (arg_391_1.time_ - var_394_15) / var_394_25

				arg_391_1.typewritter:SetDirty()
			end

			if arg_391_1.time_ >= var_394_15 + var_394_25 and arg_391_1.time_ < var_394_15 + var_394_25 + arg_394_0 then
				arg_391_1.typewritter.percent = 1

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(true)
			end
		end

		arg_391_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_391_1:InitPlayNodeList()
	end,
	Play321371094 = function(arg_395_0, arg_395_1)
		arg_395_1.time_ = 0
		arg_395_1.frameCnt_ = 0
		arg_395_1.state_ = "playing"
		arg_395_1.curTalkId_ = 321371094
		arg_395_1.duration_ = 7

		SetActive(arg_395_1.tipsGo_, false)

		function arg_395_1.onSingleLineFinish_()
			arg_395_1.onSingleLineUpdate_ = nil
			arg_395_1.onSingleLineFinish_ = nil
			arg_395_1.state_ = "waiting"
		end

		function arg_395_1.playNext_(arg_397_0)
			if arg_397_0 == 1 then
				arg_395_0:Play321371095(arg_395_1)
			end
		end

		function arg_395_1.onSingleLineUpdate_(arg_398_0)
			local var_398_0 = arg_395_1.actors_["1111ui_story"].transform
			local var_398_1 = 0

			if var_398_1 < arg_395_1.time_ and arg_395_1.time_ <= var_398_1 + arg_398_0 then
				arg_395_1.var_.moveOldPos1111ui_story = var_398_0.localPosition
			end

			local var_398_2 = 0.001

			if var_398_1 <= arg_395_1.time_ and arg_395_1.time_ < var_398_1 + var_398_2 then
				local var_398_3 = (arg_395_1.time_ - var_398_1) / var_398_2
				local var_398_4 = Vector3.New(0, 100, 0)

				var_398_0.localPosition = Vector3.Lerp(arg_395_1.var_.moveOldPos1111ui_story, var_398_4, var_398_3)

				local var_398_5 = manager.ui.mainCamera.transform.position - var_398_0.position

				var_398_0.forward = Vector3.New(var_398_5.x, var_398_5.y, var_398_5.z)

				local var_398_6 = var_398_0.localEulerAngles

				var_398_6.z = 0
				var_398_6.x = 0
				var_398_0.localEulerAngles = var_398_6
			end

			if arg_395_1.time_ >= var_398_1 + var_398_2 and arg_395_1.time_ < var_398_1 + var_398_2 + arg_398_0 then
				var_398_0.localPosition = Vector3.New(0, 100, 0)

				local var_398_7 = manager.ui.mainCamera.transform.position - var_398_0.position

				var_398_0.forward = Vector3.New(var_398_7.x, var_398_7.y, var_398_7.z)

				local var_398_8 = var_398_0.localEulerAngles

				var_398_8.z = 0
				var_398_8.x = 0
				var_398_0.localEulerAngles = var_398_8
			end

			local var_398_9 = arg_395_1.actors_["1111ui_story"]
			local var_398_10 = 0

			if var_398_10 < arg_395_1.time_ and arg_395_1.time_ <= var_398_10 + arg_398_0 and not isNil(var_398_9) and arg_395_1.var_.characterEffect1111ui_story == nil then
				arg_395_1.var_.characterEffect1111ui_story = var_398_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_398_11 = 0.034000001847744

			if var_398_10 <= arg_395_1.time_ and arg_395_1.time_ < var_398_10 + var_398_11 and not isNil(var_398_9) then
				local var_398_12 = (arg_395_1.time_ - var_398_10) / var_398_11

				if arg_395_1.var_.characterEffect1111ui_story and not isNil(var_398_9) then
					local var_398_13 = Mathf.Lerp(0, 0.5, var_398_12)

					arg_395_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_395_1.var_.characterEffect1111ui_story.fillRatio = var_398_13
				end
			end

			if arg_395_1.time_ >= var_398_10 + var_398_11 and arg_395_1.time_ < var_398_10 + var_398_11 + arg_398_0 and not isNil(var_398_9) and arg_395_1.var_.characterEffect1111ui_story then
				local var_398_14 = 0.5

				arg_395_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_395_1.var_.characterEffect1111ui_story.fillRatio = var_398_14
			end

			local var_398_15 = manager.ui.mainCamera.transform
			local var_398_16 = 1.2

			if var_398_16 < arg_395_1.time_ and arg_395_1.time_ <= var_398_16 + arg_398_0 then
				local var_398_17 = arg_395_1.var_.effectchenai1
				local var_398_18
				local var_398_19 = var_398_15

				if not var_398_17 then
					var_398_17 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_mist_in"), var_398_19)
					var_398_17.name = "chenai1"
					arg_395_1.var_.effectchenai1 = var_398_17
				else
					var_398_17.transform:SetParent(var_398_19)
				end

				var_398_17.transform.localPosition = Vector3.New(0, 0, 0)
				var_398_17.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_398_20 = manager.ui.mainCamera.transform
			local var_398_21 = 1.2

			if var_398_21 < arg_395_1.time_ and arg_395_1.time_ <= var_398_21 + arg_398_0 then
				local var_398_22 = arg_395_1.var_.effectchenai4
				local var_398_23
				local var_398_24 = var_398_20

				if not var_398_22 then
					var_398_22 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_xishan"), var_398_24)
					var_398_22.name = "chenai4"
					arg_395_1.var_.effectchenai4 = var_398_22
				else
					var_398_22.transform:SetParent(var_398_24)
				end

				var_398_22.transform.localPosition = Vector3.New(0, 0, -5.34)
				var_398_22.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_398_25 = manager.ui.mainCamera.transform
			local var_398_26 = 1.2

			if var_398_26 < arg_395_1.time_ and arg_395_1.time_ <= var_398_26 + arg_398_0 then
				arg_395_1.var_.shakeOldPos = var_398_25.localPosition
			end

			local var_398_27 = 1.5

			if var_398_26 <= arg_395_1.time_ and arg_395_1.time_ < var_398_26 + var_398_27 then
				local var_398_28 = (arg_395_1.time_ - var_398_26) / 0.066
				local var_398_29, var_398_30 = math.modf(var_398_28)

				var_398_25.localPosition = Vector3.New(var_398_30 * 0.13, var_398_30 * 0.13, var_398_30 * 0.13) + arg_395_1.var_.shakeOldPos
			end

			if arg_395_1.time_ >= var_398_26 + var_398_27 and arg_395_1.time_ < var_398_26 + var_398_27 + arg_398_0 then
				var_398_25.localPosition = arg_395_1.var_.shakeOldPos
			end

			local var_398_31 = manager.ui.mainCamera.transform
			local var_398_32 = 0

			if var_398_32 < arg_395_1.time_ and arg_395_1.time_ <= var_398_32 + arg_398_0 then
				local var_398_33 = arg_395_1.var_.effectbiaocengjingxiang
				local var_398_34
				local var_398_35 = var_398_31

				if not var_398_33 then
					var_398_33 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zxuanguang_in_keep"), var_398_35)
					var_398_33.name = "biaocengjingxiang"
					arg_395_1.var_.effectbiaocengjingxiang = var_398_33
				else
					var_398_33.transform:SetParent(var_398_35)
				end

				var_398_33.transform.localPosition = Vector3.New(0, 0, 0)
				var_398_33.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_398_36 = manager.ui.mainCamera.transform
			local var_398_37 = 1.2

			if var_398_37 < arg_395_1.time_ and arg_395_1.time_ <= var_398_37 + arg_398_0 then
				local var_398_38 = arg_395_1.var_.effectbiaocengjingxiang2
				local var_398_39
				local var_398_40 = var_398_36

				if not var_398_38 then
					var_398_38 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zxuanguang_out"), var_398_40)
					var_398_38.name = "biaocengjingxiang2"
					arg_395_1.var_.effectbiaocengjingxiang2 = var_398_38
				else
					var_398_38.transform:SetParent(var_398_40)
				end

				var_398_38.transform.localPosition = Vector3.New(0, 0, 0)
				var_398_38.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_398_41 = manager.ui.mainCamera.transform
			local var_398_42 = 1.9

			if var_398_42 < arg_395_1.time_ and arg_395_1.time_ <= var_398_42 + arg_398_0 then
				local var_398_43 = arg_395_1.var_.effectbiaocengjingxiang2

				if var_398_43 then
					Object.Destroy(var_398_43)

					arg_395_1.var_.effectbiaocengjingxiang2 = nil
				end
			end

			local var_398_44 = manager.ui.mainCamera.transform
			local var_398_45 = 1.2

			if var_398_45 < arg_395_1.time_ and arg_395_1.time_ <= var_398_45 + arg_398_0 then
				local var_398_46 = arg_395_1.var_.effectbiaocengjingxiang

				if var_398_46 then
					Object.Destroy(var_398_46)

					arg_395_1.var_.effectbiaocengjingxiang = nil
				end
			end

			local var_398_47 = 0

			if var_398_47 < arg_395_1.time_ and arg_395_1.time_ <= var_398_47 + arg_398_0 then
				arg_395_1.allBtn_.enabled = false
			end

			local var_398_48 = 1.7

			if arg_395_1.time_ >= var_398_47 + var_398_48 and arg_395_1.time_ < var_398_47 + var_398_48 + arg_398_0 then
				arg_395_1.allBtn_.enabled = true
			end

			local var_398_49 = 1.2
			local var_398_50 = 1

			if var_398_49 < arg_395_1.time_ and arg_395_1.time_ <= var_398_49 + arg_398_0 then
				local var_398_51 = "play"
				local var_398_52 = "effect"

				arg_395_1:AudioAction(var_398_51, var_398_52, "se_story_141", "se_story_141_hit", "")
			end

			if arg_395_1.frameCnt_ <= 1 then
				arg_395_1.dialog_:SetActive(false)
			end

			local var_398_53 = 2
			local var_398_54 = 1.55

			if var_398_53 < arg_395_1.time_ and arg_395_1.time_ <= var_398_53 + arg_398_0 then
				arg_395_1.talkMaxDuration = 0

				arg_395_1.dialog_:SetActive(true)

				arg_395_1.dialogCg_.alpha = 0

				local var_398_55 = LeanTween.value(arg_395_1.dialog_, 0, 1, 0.3)

				var_398_55:setOnUpdate(LuaHelper.FloatAction(function(arg_399_0)
					arg_395_1.dialogCg_.alpha = arg_399_0
				end))
				var_398_55:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_395_1.dialog_)
					var_398_55:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_395_1.duration_ = arg_395_1.duration_ + 0.3

				SetActive(arg_395_1.leftNameGo_, false)

				arg_395_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_395_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_395_1:RecordName(arg_395_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_395_1.iconTrs_.gameObject, false)
				arg_395_1.callingController_:SetSelectedState("normal")

				local var_398_56 = arg_395_1:GetWordFromCfg(321371094)
				local var_398_57 = arg_395_1:FormatText(var_398_56.content)

				arg_395_1.text_.text = var_398_57

				LuaForUtil.ClearLinePrefixSymbol(arg_395_1.text_)

				local var_398_58 = 62
				local var_398_59 = utf8.len(var_398_57)
				local var_398_60 = var_398_58 <= 0 and var_398_54 or var_398_54 * (var_398_59 / var_398_58)

				if var_398_60 > 0 and var_398_54 < var_398_60 then
					arg_395_1.talkMaxDuration = var_398_60
					var_398_53 = var_398_53 + 0.3

					if var_398_60 + var_398_53 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_60 + var_398_53
					end
				end

				arg_395_1.text_.text = var_398_57
				arg_395_1.typewritter.percent = 0

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(false)
				arg_395_1:RecordContent(arg_395_1.text_.text)
			end

			local var_398_61 = var_398_53 + 0.3
			local var_398_62 = math.max(var_398_54, arg_395_1.talkMaxDuration)

			if var_398_61 <= arg_395_1.time_ and arg_395_1.time_ < var_398_61 + var_398_62 then
				arg_395_1.typewritter.percent = (arg_395_1.time_ - var_398_61) / var_398_62

				arg_395_1.typewritter:SetDirty()
			end

			if arg_395_1.time_ >= var_398_61 + var_398_62 and arg_395_1.time_ < var_398_61 + var_398_62 + arg_398_0 then
				arg_395_1.typewritter.percent = 1

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(true)
			end
		end

		arg_395_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_395_1:InitPlayNodeList()
	end,
	Play321371095 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 321371095
		arg_401_1.duration_ = 5

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play321371096(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			local var_404_0 = 0
			local var_404_1 = 1.275

			if var_404_0 < arg_401_1.time_ and arg_401_1.time_ <= var_404_0 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, false)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_401_1.iconTrs_.gameObject, false)
				arg_401_1.callingController_:SetSelectedState("normal")

				local var_404_2 = arg_401_1:GetWordFromCfg(321371095)
				local var_404_3 = arg_401_1:FormatText(var_404_2.content)

				arg_401_1.text_.text = var_404_3

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_4 = 51
				local var_404_5 = utf8.len(var_404_3)
				local var_404_6 = var_404_4 <= 0 and var_404_1 or var_404_1 * (var_404_5 / var_404_4)

				if var_404_6 > 0 and var_404_1 < var_404_6 then
					arg_401_1.talkMaxDuration = var_404_6

					if var_404_6 + var_404_0 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_6 + var_404_0
					end
				end

				arg_401_1.text_.text = var_404_3
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)
				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_7 = math.max(var_404_1, arg_401_1.talkMaxDuration)

			if var_404_0 <= arg_401_1.time_ and arg_401_1.time_ < var_404_0 + var_404_7 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - var_404_0) / var_404_7

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= var_404_0 + var_404_7 and arg_401_1.time_ < var_404_0 + var_404_7 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {}

		arg_401_1:InitPlayNodeList()
	end,
	Play321371096 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 321371096
		arg_405_1.duration_ = 5.77

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play321371097(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			local var_408_0 = manager.ui.mainCamera.transform
			local var_408_1 = 0

			if var_408_1 < arg_405_1.time_ and arg_405_1.time_ <= var_408_1 + arg_408_0 then
				arg_405_1.var_.shakeOldPos = var_408_0.localPosition
			end

			local var_408_2 = 0.766666666666667

			if var_408_1 <= arg_405_1.time_ and arg_405_1.time_ < var_408_1 + var_408_2 then
				local var_408_3 = (arg_405_1.time_ - var_408_1) / 0.066
				local var_408_4, var_408_5 = math.modf(var_408_3)

				var_408_0.localPosition = Vector3.New(var_408_5 * 0.13, var_408_5 * 0.13, var_408_5 * 0.13) + arg_405_1.var_.shakeOldPos
			end

			if arg_405_1.time_ >= var_408_1 + var_408_2 and arg_405_1.time_ < var_408_1 + var_408_2 + arg_408_0 then
				var_408_0.localPosition = arg_405_1.var_.shakeOldPos
			end

			local var_408_6 = 0

			if var_408_6 < arg_405_1.time_ and arg_405_1.time_ <= var_408_6 + arg_408_0 then
				arg_405_1.allBtn_.enabled = false
			end

			local var_408_7 = 1.1

			if arg_405_1.time_ >= var_408_6 + var_408_7 and arg_405_1.time_ < var_408_6 + var_408_7 + arg_408_0 then
				arg_405_1.allBtn_.enabled = true
			end

			local var_408_8 = manager.ui.mainCamera.transform
			local var_408_9 = 0

			if var_408_9 < arg_405_1.time_ and arg_405_1.time_ <= var_408_9 + arg_408_0 then
				local var_408_10 = arg_405_1.var_.effectchenai1

				if var_408_10 then
					Object.Destroy(var_408_10)

					arg_405_1.var_.effectchenai1 = nil
				end
			end

			local var_408_11 = manager.ui.mainCamera.transform
			local var_408_12 = 0

			if var_408_12 < arg_405_1.time_ and arg_405_1.time_ <= var_408_12 + arg_408_0 then
				local var_408_13 = arg_405_1.var_.effectchenai4

				if var_408_13 then
					Object.Destroy(var_408_13)

					arg_405_1.var_.effectchenai4 = nil
				end
			end

			local var_408_14 = 0
			local var_408_15 = 1

			if var_408_14 < arg_405_1.time_ and arg_405_1.time_ <= var_408_14 + arg_408_0 then
				local var_408_16 = "play"
				local var_408_17 = "effect"

				arg_405_1:AudioAction(var_408_16, var_408_17, "se_story_141", "se_story_141_snake04", "")
			end

			if arg_405_1.frameCnt_ <= 1 then
				arg_405_1.dialog_:SetActive(false)
			end

			local var_408_18 = 0.766666666666667
			local var_408_19 = 1.15

			if var_408_18 < arg_405_1.time_ and arg_405_1.time_ <= var_408_18 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0

				arg_405_1.dialog_:SetActive(true)

				arg_405_1.dialogCg_.alpha = 0

				local var_408_20 = LeanTween.value(arg_405_1.dialog_, 0, 1, 0.3)

				var_408_20:setOnUpdate(LuaHelper.FloatAction(function(arg_409_0)
					arg_405_1.dialogCg_.alpha = arg_409_0
				end))
				var_408_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_405_1.dialog_)
					var_408_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_405_1.duration_ = arg_405_1.duration_ + 0.3

				SetActive(arg_405_1.leftNameGo_, false)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_405_1.iconTrs_.gameObject, false)
				arg_405_1.callingController_:SetSelectedState("normal")

				local var_408_21 = arg_405_1:GetWordFromCfg(321371096)
				local var_408_22 = arg_405_1:FormatText(var_408_21.content)

				arg_405_1.text_.text = var_408_22

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_23 = 46
				local var_408_24 = utf8.len(var_408_22)
				local var_408_25 = var_408_23 <= 0 and var_408_19 or var_408_19 * (var_408_24 / var_408_23)

				if var_408_25 > 0 and var_408_19 < var_408_25 then
					arg_405_1.talkMaxDuration = var_408_25
					var_408_18 = var_408_18 + 0.3

					if var_408_25 + var_408_18 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_25 + var_408_18
					end
				end

				arg_405_1.text_.text = var_408_22
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)
				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_26 = var_408_18 + 0.3
			local var_408_27 = math.max(var_408_19, arg_405_1.talkMaxDuration)

			if var_408_26 <= arg_405_1.time_ and arg_405_1.time_ < var_408_26 + var_408_27 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - var_408_26) / var_408_27

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= var_408_26 + var_408_27 and arg_405_1.time_ < var_408_26 + var_408_27 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {}

		arg_405_1:InitPlayNodeList()
	end,
	Play321371097 = function(arg_411_0, arg_411_1)
		arg_411_1.time_ = 0
		arg_411_1.frameCnt_ = 0
		arg_411_1.state_ = "playing"
		arg_411_1.curTalkId_ = 321371097
		arg_411_1.duration_ = 5

		SetActive(arg_411_1.tipsGo_, false)

		function arg_411_1.onSingleLineFinish_()
			arg_411_1.onSingleLineUpdate_ = nil
			arg_411_1.onSingleLineFinish_ = nil
			arg_411_1.state_ = "waiting"
		end

		function arg_411_1.playNext_(arg_413_0)
			if arg_413_0 == 1 then
				arg_411_0:Play321371098(arg_411_1)
			end
		end

		function arg_411_1.onSingleLineUpdate_(arg_414_0)
			local var_414_0 = 0
			local var_414_1 = 0.9

			if var_414_0 < arg_411_1.time_ and arg_411_1.time_ <= var_414_0 + arg_414_0 then
				arg_411_1.talkMaxDuration = 0
				arg_411_1.dialogCg_.alpha = 1

				arg_411_1.dialog_:SetActive(true)
				SetActive(arg_411_1.leftNameGo_, false)

				arg_411_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_411_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_411_1:RecordName(arg_411_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_411_1.iconTrs_.gameObject, false)
				arg_411_1.callingController_:SetSelectedState("normal")

				local var_414_2 = arg_411_1:GetWordFromCfg(321371097)
				local var_414_3 = arg_411_1:FormatText(var_414_2.content)

				arg_411_1.text_.text = var_414_3

				LuaForUtil.ClearLinePrefixSymbol(arg_411_1.text_)

				local var_414_4 = 36
				local var_414_5 = utf8.len(var_414_3)
				local var_414_6 = var_414_4 <= 0 and var_414_1 or var_414_1 * (var_414_5 / var_414_4)

				if var_414_6 > 0 and var_414_1 < var_414_6 then
					arg_411_1.talkMaxDuration = var_414_6

					if var_414_6 + var_414_0 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_6 + var_414_0
					end
				end

				arg_411_1.text_.text = var_414_3
				arg_411_1.typewritter.percent = 0

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(false)
				arg_411_1:RecordContent(arg_411_1.text_.text)
			end

			local var_414_7 = math.max(var_414_1, arg_411_1.talkMaxDuration)

			if var_414_0 <= arg_411_1.time_ and arg_411_1.time_ < var_414_0 + var_414_7 then
				arg_411_1.typewritter.percent = (arg_411_1.time_ - var_414_0) / var_414_7

				arg_411_1.typewritter:SetDirty()
			end

			if arg_411_1.time_ >= var_414_0 + var_414_7 and arg_411_1.time_ < var_414_0 + var_414_7 + arg_414_0 then
				arg_411_1.typewritter.percent = 1

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(true)
			end
		end

		arg_411_1.nodeConfigList_ = {}

		arg_411_1:InitPlayNodeList()
	end,
	Play321371098 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 321371098
		arg_415_1.duration_ = 2.13

		SetActive(arg_415_1.tipsGo_, false)

		function arg_415_1.onSingleLineFinish_()
			arg_415_1.onSingleLineUpdate_ = nil
			arg_415_1.onSingleLineFinish_ = nil
			arg_415_1.state_ = "waiting"
		end

		function arg_415_1.playNext_(arg_417_0)
			if arg_417_0 == 1 then
				arg_415_0:Play321371099(arg_415_1)
			end
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			local var_418_0 = 0

			if var_418_0 < arg_415_1.time_ and arg_415_1.time_ <= var_418_0 + arg_418_0 then
				arg_415_1.mask_.enabled = true
				arg_415_1.mask_.raycastTarget = true

				arg_415_1:SetGaussion(false)
			end

			local var_418_1 = 1

			if var_418_0 <= arg_415_1.time_ and arg_415_1.time_ < var_418_0 + var_418_1 then
				local var_418_2 = (arg_415_1.time_ - var_418_0) / var_418_1
				local var_418_3 = Color.New(0, 0, 0)

				var_418_3.a = Mathf.Lerp(0, 1, var_418_2)
				arg_415_1.mask_.color = var_418_3
			end

			if arg_415_1.time_ >= var_418_0 + var_418_1 and arg_415_1.time_ < var_418_0 + var_418_1 + arg_418_0 then
				local var_418_4 = Color.New(0, 0, 0)

				var_418_4.a = 1
				arg_415_1.mask_.color = var_418_4
			end

			local var_418_5 = 1

			if var_418_5 < arg_415_1.time_ and arg_415_1.time_ <= var_418_5 + arg_418_0 then
				arg_415_1.mask_.enabled = true
				arg_415_1.mask_.raycastTarget = true

				arg_415_1:SetGaussion(false)
			end

			local var_418_6 = 1

			if var_418_5 <= arg_415_1.time_ and arg_415_1.time_ < var_418_5 + var_418_6 then
				local var_418_7 = (arg_415_1.time_ - var_418_5) / var_418_6
				local var_418_8 = Color.New(0, 0, 0)

				var_418_8.a = Mathf.Lerp(1, 0, var_418_7)
				arg_415_1.mask_.color = var_418_8
			end

			if arg_415_1.time_ >= var_418_5 + var_418_6 and arg_415_1.time_ < var_418_5 + var_418_6 + arg_418_0 then
				local var_418_9 = Color.New(0, 0, 0)
				local var_418_10 = 0

				arg_415_1.mask_.enabled = false
				var_418_9.a = var_418_10
				arg_415_1.mask_.color = var_418_9
			end

			local var_418_11 = "STblack"

			if arg_415_1.bgs_[var_418_11] == nil then
				local var_418_12 = Object.Instantiate(arg_415_1.paintGo_)

				var_418_12:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_418_11)
				var_418_12.name = var_418_11
				var_418_12.transform.parent = arg_415_1.stage_.transform
				var_418_12.transform.localPosition = Vector3.New(0, 100, 0)
				arg_415_1.bgs_[var_418_11] = var_418_12
			end

			local var_418_13 = 1

			if var_418_13 < arg_415_1.time_ and arg_415_1.time_ <= var_418_13 + arg_418_0 then
				local var_418_14 = manager.ui.mainCamera.transform.localPosition
				local var_418_15 = Vector3.New(0, 0, 10) + Vector3.New(var_418_14.x, var_418_14.y, 0)
				local var_418_16 = arg_415_1.bgs_.STblack

				var_418_16.transform.localPosition = var_418_15
				var_418_16.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_418_17 = var_418_16:GetComponent("SpriteRenderer")

				if var_418_17 and var_418_17.sprite then
					local var_418_18 = (var_418_16.transform.localPosition - var_418_14).z
					local var_418_19 = manager.ui.mainCameraCom_
					local var_418_20 = 2 * var_418_18 * Mathf.Tan(var_418_19.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_418_21 = var_418_20 * var_418_19.aspect
					local var_418_22 = var_418_17.sprite.bounds.size.x
					local var_418_23 = var_418_17.sprite.bounds.size.y
					local var_418_24 = var_418_21 / var_418_22
					local var_418_25 = var_418_20 / var_418_23
					local var_418_26 = var_418_25 < var_418_24 and var_418_24 or var_418_25

					var_418_16.transform.localScale = Vector3.New(var_418_26, var_418_26, 0)
				end

				for iter_418_0, iter_418_1 in pairs(arg_415_1.bgs_) do
					if iter_418_0 ~= "STblack" then
						iter_418_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_418_27 = 1

			if var_418_27 < arg_415_1.time_ and arg_415_1.time_ <= var_418_27 + arg_418_0 then
				arg_415_1.fswbg_:SetActive(true)
				arg_415_1.dialog_:SetActive(false)

				arg_415_1.fswtw_.percent = 0

				local var_418_28 = arg_415_1:GetWordFromCfg(321371098)
				local var_418_29 = arg_415_1:FormatText(var_418_28.content)

				arg_415_1.fswt_.text = var_418_29

				LuaForUtil.ClearLinePrefixSymbol(arg_415_1.fswt_)

				arg_415_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_415_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_415_1.fswtw_:SetDirty()

				arg_415_1.typewritterCharCountI18N = 0

				SetActive(arg_415_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_415_1:ShowNextGo(false)
			end

			local var_418_30 = 1.06666666666667

			if var_418_30 < arg_415_1.time_ and arg_415_1.time_ <= var_418_30 + arg_418_0 then
				arg_415_1.var_.oldValueTypewriter = arg_415_1.fswtw_.percent

				SetActive(arg_415_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_415_1:ShowNextGo(false)
			end

			local var_418_31 = 16
			local var_418_32 = 1.06666666666667
			local var_418_33 = arg_415_1:GetWordFromCfg(321371098)
			local var_418_34 = arg_415_1:FormatText(var_418_33.content)
			local var_418_35, var_418_36 = arg_415_1:GetPercentByPara(var_418_34, 1)

			if var_418_30 < arg_415_1.time_ and arg_415_1.time_ <= var_418_30 + arg_418_0 then
				arg_415_1.talkMaxDuration = 0

				local var_418_37 = var_418_31 <= 0 and var_418_32 or var_418_32 * ((var_418_36 - arg_415_1.typewritterCharCountI18N) / var_418_31)

				if var_418_37 > 0 and var_418_32 < var_418_37 then
					arg_415_1.talkMaxDuration = var_418_37

					if var_418_37 + var_418_30 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_37 + var_418_30
					end
				end
			end

			local var_418_38 = 1.06666666666667
			local var_418_39 = math.max(var_418_38, arg_415_1.talkMaxDuration)

			if var_418_30 <= arg_415_1.time_ and arg_415_1.time_ < var_418_30 + var_418_39 then
				local var_418_40 = (arg_415_1.time_ - var_418_30) / var_418_39

				arg_415_1.fswtw_.percent = Mathf.Lerp(arg_415_1.var_.oldValueTypewriter, var_418_35, var_418_40)
				arg_415_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_415_1.fswtw_:SetDirty()
			end

			if arg_415_1.time_ >= var_418_30 + var_418_39 and arg_415_1.time_ < var_418_30 + var_418_39 + arg_418_0 then
				arg_415_1.fswtw_.percent = var_418_35

				arg_415_1.fswtw_:SetDirty()
				arg_415_1:ShowNextGo(true)

				arg_415_1.typewritterCharCountI18N = var_418_36
			end

			local var_418_41 = 1

			if var_418_41 < arg_415_1.time_ and arg_415_1.time_ <= var_418_41 + arg_418_0 then
				local var_418_42 = arg_415_1.fswbg_.transform:Find("textbox/adapt/content") or arg_415_1.fswbg_.transform:Find("textbox/content")
				local var_418_43 = arg_415_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_418_44 = var_418_42:GetComponent("Text")
				local var_418_45 = var_418_42:GetComponent("RectTransform")

				var_418_44.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_418_45.offsetMin = Vector2.New(0, 0)
				var_418_45.offsetMax = Vector2.New(0, 0)
			end

			local var_418_46 = 1
			local var_418_47 = 1
			local var_418_48 = manager.audio:GetVoiceLength("story_v_out_321371", "321371098", "story_v_out_321371.awb") / 1000

			if var_418_48 > 0 and var_418_47 < var_418_48 and var_418_48 + var_418_46 > arg_415_1.duration_ then
				local var_418_49 = var_418_48

				arg_415_1.duration_ = var_418_48 + var_418_46
			end

			if var_418_46 < arg_415_1.time_ and arg_415_1.time_ <= var_418_46 + arg_418_0 then
				local var_418_50 = "play"
				local var_418_51 = "voice"

				arg_415_1:AudioAction(var_418_50, var_418_51, "story_v_out_321371", "321371098", "story_v_out_321371.awb")
			end
		end

		arg_415_1.nodeConfigList_ = {}

		arg_415_1:InitPlayNodeList()
	end,
	Play321371099 = function(arg_419_0, arg_419_1)
		arg_419_1.time_ = 0
		arg_419_1.frameCnt_ = 0
		arg_419_1.state_ = "playing"
		arg_419_1.curTalkId_ = 321371099
		arg_419_1.duration_ = 5.3

		SetActive(arg_419_1.tipsGo_, false)

		function arg_419_1.onSingleLineFinish_()
			arg_419_1.onSingleLineUpdate_ = nil
			arg_419_1.onSingleLineFinish_ = nil
			arg_419_1.state_ = "waiting"
		end

		function arg_419_1.playNext_(arg_421_0)
			if arg_421_0 == 1 then
				arg_419_0:Play321371100(arg_419_1)
			end
		end

		function arg_419_1.onSingleLineUpdate_(arg_422_0)
			local var_422_0 = 0

			if var_422_0 < arg_419_1.time_ and arg_419_1.time_ <= var_422_0 + arg_422_0 then
				arg_419_1.fswbg_:SetActive(true)
				arg_419_1.dialog_:SetActive(false)

				arg_419_1.fswtw_.percent = 0

				local var_422_1 = arg_419_1:GetWordFromCfg(321371099)
				local var_422_2 = arg_419_1:FormatText(var_422_1.content)

				arg_419_1.fswt_.text = var_422_2

				LuaForUtil.ClearLinePrefixSymbol(arg_419_1.fswt_)

				arg_419_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_419_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_419_1.fswtw_:SetDirty()

				arg_419_1.typewritterCharCountI18N = 0

				SetActive(arg_419_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_419_1:ShowNextGo(false)
			end

			local var_422_3 = 0.0666666666666667

			if var_422_3 < arg_419_1.time_ and arg_419_1.time_ <= var_422_3 + arg_422_0 then
				arg_419_1.var_.oldValueTypewriter = arg_419_1.fswtw_.percent

				SetActive(arg_419_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_419_1:ShowNextGo(false)
			end

			local var_422_4 = 34
			local var_422_5 = 2.26666666666667
			local var_422_6 = arg_419_1:GetWordFromCfg(321371099)
			local var_422_7 = arg_419_1:FormatText(var_422_6.content)
			local var_422_8, var_422_9 = arg_419_1:GetPercentByPara(var_422_7, 1)

			if var_422_3 < arg_419_1.time_ and arg_419_1.time_ <= var_422_3 + arg_422_0 then
				arg_419_1.talkMaxDuration = 0

				local var_422_10 = var_422_4 <= 0 and var_422_5 or var_422_5 * ((var_422_9 - arg_419_1.typewritterCharCountI18N) / var_422_4)

				if var_422_10 > 0 and var_422_5 < var_422_10 then
					arg_419_1.talkMaxDuration = var_422_10

					if var_422_10 + var_422_3 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_10 + var_422_3
					end
				end
			end

			local var_422_11 = 2.26666666666667
			local var_422_12 = math.max(var_422_11, arg_419_1.talkMaxDuration)

			if var_422_3 <= arg_419_1.time_ and arg_419_1.time_ < var_422_3 + var_422_12 then
				local var_422_13 = (arg_419_1.time_ - var_422_3) / var_422_12

				arg_419_1.fswtw_.percent = Mathf.Lerp(arg_419_1.var_.oldValueTypewriter, var_422_8, var_422_13)
				arg_419_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_419_1.fswtw_:SetDirty()
			end

			if arg_419_1.time_ >= var_422_3 + var_422_12 and arg_419_1.time_ < var_422_3 + var_422_12 + arg_422_0 then
				arg_419_1.fswtw_.percent = var_422_8

				arg_419_1.fswtw_:SetDirty()
				arg_419_1:ShowNextGo(true)

				arg_419_1.typewritterCharCountI18N = var_422_9
			end

			local var_422_14 = 0
			local var_422_15 = 5.3
			local var_422_16 = manager.audio:GetVoiceLength("story_v_out_321371", "321371099", "story_v_out_321371.awb") / 1000

			if var_422_16 > 0 and var_422_15 < var_422_16 and var_422_16 + var_422_14 > arg_419_1.duration_ then
				local var_422_17 = var_422_16

				arg_419_1.duration_ = var_422_16 + var_422_14
			end

			if var_422_14 < arg_419_1.time_ and arg_419_1.time_ <= var_422_14 + arg_422_0 then
				local var_422_18 = "play"
				local var_422_19 = "voice"

				arg_419_1:AudioAction(var_422_18, var_422_19, "story_v_out_321371", "321371099", "story_v_out_321371.awb")
			end
		end

		arg_419_1.nodeConfigList_ = {}

		arg_419_1:InitPlayNodeList()
	end,
	Play321371100 = function(arg_423_0, arg_423_1)
		arg_423_1.time_ = 0
		arg_423_1.frameCnt_ = 0
		arg_423_1.state_ = "playing"
		arg_423_1.curTalkId_ = 321371100
		arg_423_1.duration_ = 7

		SetActive(arg_423_1.tipsGo_, false)

		function arg_423_1.onSingleLineFinish_()
			arg_423_1.onSingleLineUpdate_ = nil
			arg_423_1.onSingleLineFinish_ = nil
			arg_423_1.state_ = "waiting"
		end

		function arg_423_1.playNext_(arg_425_0)
			if arg_425_0 == 1 then
				arg_423_0:Play321371101(arg_423_1)
			end
		end

		function arg_423_1.onSingleLineUpdate_(arg_426_0)
			local var_426_0 = arg_423_1.actors_["1111ui_story"].transform
			local var_426_1 = 0

			if var_426_1 < arg_423_1.time_ and arg_423_1.time_ <= var_426_1 + arg_426_0 then
				arg_423_1.var_.moveOldPos1111ui_story = var_426_0.localPosition
			end

			local var_426_2 = 0.001

			if var_426_1 <= arg_423_1.time_ and arg_423_1.time_ < var_426_1 + var_426_2 then
				local var_426_3 = (arg_423_1.time_ - var_426_1) / var_426_2
				local var_426_4 = Vector3.New(0, 100, 0)

				var_426_0.localPosition = Vector3.Lerp(arg_423_1.var_.moveOldPos1111ui_story, var_426_4, var_426_3)

				local var_426_5 = manager.ui.mainCamera.transform.position - var_426_0.position

				var_426_0.forward = Vector3.New(var_426_5.x, var_426_5.y, var_426_5.z)

				local var_426_6 = var_426_0.localEulerAngles

				var_426_6.z = 0
				var_426_6.x = 0
				var_426_0.localEulerAngles = var_426_6
			end

			if arg_423_1.time_ >= var_426_1 + var_426_2 and arg_423_1.time_ < var_426_1 + var_426_2 + arg_426_0 then
				var_426_0.localPosition = Vector3.New(0, 100, 0)

				local var_426_7 = manager.ui.mainCamera.transform.position - var_426_0.position

				var_426_0.forward = Vector3.New(var_426_7.x, var_426_7.y, var_426_7.z)

				local var_426_8 = var_426_0.localEulerAngles

				var_426_8.z = 0
				var_426_8.x = 0
				var_426_0.localEulerAngles = var_426_8
			end

			local var_426_9 = arg_423_1.actors_["1111ui_story"]
			local var_426_10 = 0

			if var_426_10 < arg_423_1.time_ and arg_423_1.time_ <= var_426_10 + arg_426_0 and not isNil(var_426_9) and arg_423_1.var_.characterEffect1111ui_story == nil then
				arg_423_1.var_.characterEffect1111ui_story = var_426_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_426_11 = 0.200000002980232

			if var_426_10 <= arg_423_1.time_ and arg_423_1.time_ < var_426_10 + var_426_11 and not isNil(var_426_9) then
				local var_426_12 = (arg_423_1.time_ - var_426_10) / var_426_11

				if arg_423_1.var_.characterEffect1111ui_story and not isNil(var_426_9) then
					local var_426_13 = Mathf.Lerp(0, 0.5, var_426_12)

					arg_423_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_423_1.var_.characterEffect1111ui_story.fillRatio = var_426_13
				end
			end

			if arg_423_1.time_ >= var_426_10 + var_426_11 and arg_423_1.time_ < var_426_10 + var_426_11 + arg_426_0 and not isNil(var_426_9) and arg_423_1.var_.characterEffect1111ui_story then
				local var_426_14 = 0.5

				arg_423_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_423_1.var_.characterEffect1111ui_story.fillRatio = var_426_14
			end

			local var_426_15 = 0

			if var_426_15 < arg_423_1.time_ and arg_423_1.time_ <= var_426_15 + arg_426_0 then
				arg_423_1.mask_.enabled = true
				arg_423_1.mask_.raycastTarget = true

				arg_423_1:SetGaussion(false)
			end

			local var_426_16 = 1

			if var_426_15 <= arg_423_1.time_ and arg_423_1.time_ < var_426_15 + var_426_16 then
				local var_426_17 = (arg_423_1.time_ - var_426_15) / var_426_16
				local var_426_18 = Color.New(0, 0, 0)

				var_426_18.a = Mathf.Lerp(0, 1, var_426_17)
				arg_423_1.mask_.color = var_426_18
			end

			if arg_423_1.time_ >= var_426_15 + var_426_16 and arg_423_1.time_ < var_426_15 + var_426_16 + arg_426_0 then
				local var_426_19 = Color.New(0, 0, 0)

				var_426_19.a = 1
				arg_423_1.mask_.color = var_426_19
			end

			local var_426_20 = 1

			if var_426_20 < arg_423_1.time_ and arg_423_1.time_ <= var_426_20 + arg_426_0 then
				arg_423_1.mask_.enabled = true
				arg_423_1.mask_.raycastTarget = true

				arg_423_1:SetGaussion(false)
			end

			local var_426_21 = 1

			if var_426_20 <= arg_423_1.time_ and arg_423_1.time_ < var_426_20 + var_426_21 then
				local var_426_22 = (arg_423_1.time_ - var_426_20) / var_426_21
				local var_426_23 = Color.New(0, 0, 0)

				var_426_23.a = Mathf.Lerp(1, 0, var_426_22)
				arg_423_1.mask_.color = var_426_23
			end

			if arg_423_1.time_ >= var_426_20 + var_426_21 and arg_423_1.time_ < var_426_20 + var_426_21 + arg_426_0 then
				local var_426_24 = Color.New(0, 0, 0)
				local var_426_25 = 0

				arg_423_1.mask_.enabled = false
				var_426_24.a = var_426_25
				arg_423_1.mask_.color = var_426_24
			end

			local var_426_26 = 1

			if var_426_26 < arg_423_1.time_ and arg_423_1.time_ <= var_426_26 + arg_426_0 then
				local var_426_27 = manager.ui.mainCamera.transform.localPosition
				local var_426_28 = Vector3.New(0, 0, 10) + Vector3.New(var_426_27.x, var_426_27.y, 0)
				local var_426_29 = arg_423_1.bgs_.L09g

				var_426_29.transform.localPosition = var_426_28
				var_426_29.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_426_30 = var_426_29:GetComponent("SpriteRenderer")

				if var_426_30 and var_426_30.sprite then
					local var_426_31 = (var_426_29.transform.localPosition - var_426_27).z
					local var_426_32 = manager.ui.mainCameraCom_
					local var_426_33 = 2 * var_426_31 * Mathf.Tan(var_426_32.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_426_34 = var_426_33 * var_426_32.aspect
					local var_426_35 = var_426_30.sprite.bounds.size.x
					local var_426_36 = var_426_30.sprite.bounds.size.y
					local var_426_37 = var_426_34 / var_426_35
					local var_426_38 = var_426_33 / var_426_36
					local var_426_39 = var_426_38 < var_426_37 and var_426_37 or var_426_38

					var_426_29.transform.localScale = Vector3.New(var_426_39, var_426_39, 0)
				end

				for iter_426_0, iter_426_1 in pairs(arg_423_1.bgs_) do
					if iter_426_0 ~= "L09g" then
						iter_426_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_426_40
			local var_426_41 = 1

			if var_426_41 < arg_423_1.time_ and arg_423_1.time_ <= var_426_41 + arg_426_0 then
				local var_426_42 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_426_42 then
					var_426_42.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_426_42.radialBlurScale = 0
					var_426_42.radialBlurGradient = 1
					var_426_42.radialBlurIntensity = 1

					if var_426_40 then
						var_426_42.radialBlurTarget = var_426_40.transform
					end
				end
			end

			local var_426_43 = 2

			if var_426_41 <= arg_423_1.time_ and arg_423_1.time_ < var_426_41 + var_426_43 then
				local var_426_44 = (arg_423_1.time_ - var_426_41) / var_426_43
				local var_426_45 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_426_45 then
					var_426_45.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_426_45.radialBlurScale = Mathf.Lerp(0, 0.75, var_426_44)
					var_426_45.radialBlurGradient = Mathf.Lerp(1, 1, var_426_44)
					var_426_45.radialBlurIntensity = Mathf.Lerp(1, 1, var_426_44)
				end
			end

			if arg_423_1.time_ >= var_426_41 + var_426_43 and arg_423_1.time_ < var_426_41 + var_426_43 + arg_426_0 then
				local var_426_46 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_426_46 then
					var_426_46.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_426_46.radialBlurScale = 0.75
					var_426_46.radialBlurGradient = 1
					var_426_46.radialBlurIntensity = 1
				end
			end

			local var_426_47 = 0.933333333333333

			if var_426_47 < arg_423_1.time_ and arg_423_1.time_ <= var_426_47 + arg_426_0 then
				arg_423_1.fswbg_:SetActive(false)
				arg_423_1.dialog_:SetActive(false)
				SetActive(arg_423_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_423_1:ShowNextGo(false)
			end

			local var_426_48 = 1.16666666666667
			local var_426_49 = 1

			if var_426_48 < arg_423_1.time_ and arg_423_1.time_ <= var_426_48 + arg_426_0 then
				local var_426_50 = "play"
				local var_426_51 = "effect"

				arg_423_1:AudioAction(var_426_50, var_426_51, "se_story_141", "se_story_141_snake08", "")
			end

			local var_426_52 = 1.999999999999
			local var_426_53 = 0.675

			if var_426_52 < arg_423_1.time_ and arg_423_1.time_ <= var_426_52 + arg_426_0 then
				arg_423_1.talkMaxDuration = 0
				arg_423_1.dialogCg_.alpha = 1

				arg_423_1.dialog_:SetActive(true)
				SetActive(arg_423_1.leftNameGo_, false)

				arg_423_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_423_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_423_1:RecordName(arg_423_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_423_1.iconTrs_.gameObject, false)
				arg_423_1.callingController_:SetSelectedState("normal")

				local var_426_54 = arg_423_1:GetWordFromCfg(321371100)
				local var_426_55 = arg_423_1:FormatText(var_426_54.content)

				arg_423_1.text_.text = var_426_55

				LuaForUtil.ClearLinePrefixSymbol(arg_423_1.text_)

				local var_426_56 = 27
				local var_426_57 = utf8.len(var_426_55)
				local var_426_58 = var_426_56 <= 0 and var_426_53 or var_426_53 * (var_426_57 / var_426_56)

				if var_426_58 > 0 and var_426_53 < var_426_58 then
					arg_423_1.talkMaxDuration = var_426_58

					if var_426_58 + var_426_52 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_58 + var_426_52
					end
				end

				arg_423_1.text_.text = var_426_55
				arg_423_1.typewritter.percent = 0

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(false)
				arg_423_1:RecordContent(arg_423_1.text_.text)
			end

			local var_426_59 = math.max(var_426_53, arg_423_1.talkMaxDuration)

			if var_426_52 <= arg_423_1.time_ and arg_423_1.time_ < var_426_52 + var_426_59 then
				arg_423_1.typewritter.percent = (arg_423_1.time_ - var_426_52) / var_426_59

				arg_423_1.typewritter:SetDirty()
			end

			if arg_423_1.time_ >= var_426_52 + var_426_59 and arg_423_1.time_ < var_426_52 + var_426_59 + arg_426_0 then
				arg_423_1.typewritter.percent = 1

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(true)
			end
		end

		arg_423_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_423_1:InitPlayNodeList()
	end,
	Play321371101 = function(arg_427_0, arg_427_1)
		arg_427_1.time_ = 0
		arg_427_1.frameCnt_ = 0
		arg_427_1.state_ = "playing"
		arg_427_1.curTalkId_ = 321371101
		arg_427_1.duration_ = 5

		SetActive(arg_427_1.tipsGo_, false)

		function arg_427_1.onSingleLineFinish_()
			arg_427_1.onSingleLineUpdate_ = nil
			arg_427_1.onSingleLineFinish_ = nil
			arg_427_1.state_ = "waiting"
		end

		function arg_427_1.playNext_(arg_429_0)
			if arg_429_0 == 1 then
				arg_427_0:Play321371102(arg_427_1)
			end
		end

		function arg_427_1.onSingleLineUpdate_(arg_430_0)
			local var_430_0 = 0
			local var_430_1 = 1.4

			if var_430_0 < arg_427_1.time_ and arg_427_1.time_ <= var_430_0 + arg_430_0 then
				arg_427_1.talkMaxDuration = 0
				arg_427_1.dialogCg_.alpha = 1

				arg_427_1.dialog_:SetActive(true)
				SetActive(arg_427_1.leftNameGo_, false)

				arg_427_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_427_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_427_1:RecordName(arg_427_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_427_1.iconTrs_.gameObject, false)
				arg_427_1.callingController_:SetSelectedState("normal")

				local var_430_2 = arg_427_1:GetWordFromCfg(321371101)
				local var_430_3 = arg_427_1:FormatText(var_430_2.content)

				arg_427_1.text_.text = var_430_3

				LuaForUtil.ClearLinePrefixSymbol(arg_427_1.text_)

				local var_430_4 = 56
				local var_430_5 = utf8.len(var_430_3)
				local var_430_6 = var_430_4 <= 0 and var_430_1 or var_430_1 * (var_430_5 / var_430_4)

				if var_430_6 > 0 and var_430_1 < var_430_6 then
					arg_427_1.talkMaxDuration = var_430_6

					if var_430_6 + var_430_0 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_6 + var_430_0
					end
				end

				arg_427_1.text_.text = var_430_3
				arg_427_1.typewritter.percent = 0

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(false)
				arg_427_1:RecordContent(arg_427_1.text_.text)
			end

			local var_430_7 = math.max(var_430_1, arg_427_1.talkMaxDuration)

			if var_430_0 <= arg_427_1.time_ and arg_427_1.time_ < var_430_0 + var_430_7 then
				arg_427_1.typewritter.percent = (arg_427_1.time_ - var_430_0) / var_430_7

				arg_427_1.typewritter:SetDirty()
			end

			if arg_427_1.time_ >= var_430_0 + var_430_7 and arg_427_1.time_ < var_430_0 + var_430_7 + arg_430_0 then
				arg_427_1.typewritter.percent = 1

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(true)
			end
		end

		arg_427_1.nodeConfigList_ = {}

		arg_427_1:InitPlayNodeList()
	end,
	Play321371102 = function(arg_431_0, arg_431_1)
		arg_431_1.time_ = 0
		arg_431_1.frameCnt_ = 0
		arg_431_1.state_ = "playing"
		arg_431_1.curTalkId_ = 321371102
		arg_431_1.duration_ = 5

		SetActive(arg_431_1.tipsGo_, false)

		function arg_431_1.onSingleLineFinish_()
			arg_431_1.onSingleLineUpdate_ = nil
			arg_431_1.onSingleLineFinish_ = nil
			arg_431_1.state_ = "waiting"
		end

		function arg_431_1.playNext_(arg_433_0)
			if arg_433_0 == 1 then
				arg_431_0:Play321371103(arg_431_1)
			end
		end

		function arg_431_1.onSingleLineUpdate_(arg_434_0)
			local var_434_0 = 0
			local var_434_1 = 1.075

			if var_434_0 < arg_431_1.time_ and arg_431_1.time_ <= var_434_0 + arg_434_0 then
				arg_431_1.talkMaxDuration = 0
				arg_431_1.dialogCg_.alpha = 1

				arg_431_1.dialog_:SetActive(true)
				SetActive(arg_431_1.leftNameGo_, false)

				arg_431_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_431_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_431_1:RecordName(arg_431_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_431_1.iconTrs_.gameObject, false)
				arg_431_1.callingController_:SetSelectedState("normal")

				local var_434_2 = arg_431_1:GetWordFromCfg(321371102)
				local var_434_3 = arg_431_1:FormatText(var_434_2.content)

				arg_431_1.text_.text = var_434_3

				LuaForUtil.ClearLinePrefixSymbol(arg_431_1.text_)

				local var_434_4 = 43
				local var_434_5 = utf8.len(var_434_3)
				local var_434_6 = var_434_4 <= 0 and var_434_1 or var_434_1 * (var_434_5 / var_434_4)

				if var_434_6 > 0 and var_434_1 < var_434_6 then
					arg_431_1.talkMaxDuration = var_434_6

					if var_434_6 + var_434_0 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_6 + var_434_0
					end
				end

				arg_431_1.text_.text = var_434_3
				arg_431_1.typewritter.percent = 0

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(false)
				arg_431_1:RecordContent(arg_431_1.text_.text)
			end

			local var_434_7 = math.max(var_434_1, arg_431_1.talkMaxDuration)

			if var_434_0 <= arg_431_1.time_ and arg_431_1.time_ < var_434_0 + var_434_7 then
				arg_431_1.typewritter.percent = (arg_431_1.time_ - var_434_0) / var_434_7

				arg_431_1.typewritter:SetDirty()
			end

			if arg_431_1.time_ >= var_434_0 + var_434_7 and arg_431_1.time_ < var_434_0 + var_434_7 + arg_434_0 then
				arg_431_1.typewritter.percent = 1

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(true)
			end
		end

		arg_431_1.nodeConfigList_ = {}

		arg_431_1:InitPlayNodeList()
	end,
	Play321371103 = function(arg_435_0, arg_435_1)
		arg_435_1.time_ = 0
		arg_435_1.frameCnt_ = 0
		arg_435_1.state_ = "playing"
		arg_435_1.curTalkId_ = 321371103
		arg_435_1.duration_ = 8.47

		local var_435_0 = {
			zh = 8.466,
			ja = 6.8
		}
		local var_435_1 = manager.audio:GetLocalizationFlag()

		if var_435_0[var_435_1] ~= nil then
			arg_435_1.duration_ = var_435_0[var_435_1]
		end

		SetActive(arg_435_1.tipsGo_, false)

		function arg_435_1.onSingleLineFinish_()
			arg_435_1.onSingleLineUpdate_ = nil
			arg_435_1.onSingleLineFinish_ = nil
			arg_435_1.state_ = "waiting"
		end

		function arg_435_1.playNext_(arg_437_0)
			if arg_437_0 == 1 then
				arg_435_0:Play321371104(arg_435_1)
			end
		end

		function arg_435_1.onSingleLineUpdate_(arg_438_0)
			local var_438_0 = 0
			local var_438_1 = 0.55

			if var_438_0 < arg_435_1.time_ and arg_435_1.time_ <= var_438_0 + arg_438_0 then
				arg_435_1.talkMaxDuration = 0
				arg_435_1.dialogCg_.alpha = 1

				arg_435_1.dialog_:SetActive(true)
				SetActive(arg_435_1.leftNameGo_, true)

				local var_438_2 = arg_435_1:FormatText(StoryNameCfg[67].name)

				arg_435_1.leftNameTxt_.text = var_438_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_435_1.leftNameTxt_.transform)

				arg_435_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_435_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_435_1:RecordName(arg_435_1.leftNameTxt_.text)
				SetActive(arg_435_1.iconTrs_.gameObject, true)
				arg_435_1.iconController_:SetSelectedState("hero")

				arg_435_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1111")

				arg_435_1.callingController_:SetSelectedState("normal")

				arg_435_1.keyicon_.color = Color.New(1, 1, 1)
				arg_435_1.icon_.color = Color.New(1, 1, 1)

				local var_438_3 = arg_435_1:GetWordFromCfg(321371103)
				local var_438_4 = arg_435_1:FormatText(var_438_3.content)

				arg_435_1.text_.text = var_438_4

				LuaForUtil.ClearLinePrefixSymbol(arg_435_1.text_)

				local var_438_5 = 22
				local var_438_6 = utf8.len(var_438_4)
				local var_438_7 = var_438_5 <= 0 and var_438_1 or var_438_1 * (var_438_6 / var_438_5)

				if var_438_7 > 0 and var_438_1 < var_438_7 then
					arg_435_1.talkMaxDuration = var_438_7

					if var_438_7 + var_438_0 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_7 + var_438_0
					end
				end

				arg_435_1.text_.text = var_438_4
				arg_435_1.typewritter.percent = 0

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371103", "story_v_out_321371.awb") ~= 0 then
					local var_438_8 = manager.audio:GetVoiceLength("story_v_out_321371", "321371103", "story_v_out_321371.awb") / 1000

					if var_438_8 + var_438_0 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_8 + var_438_0
					end

					if var_438_3.prefab_name ~= "" and arg_435_1.actors_[var_438_3.prefab_name] ~= nil then
						local var_438_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_435_1.actors_[var_438_3.prefab_name].transform, "story_v_out_321371", "321371103", "story_v_out_321371.awb")

						arg_435_1:RecordAudio("321371103", var_438_9)
						arg_435_1:RecordAudio("321371103", var_438_9)
					else
						arg_435_1:AudioAction("play", "voice", "story_v_out_321371", "321371103", "story_v_out_321371.awb")
					end

					arg_435_1:RecordHistoryTalkVoice("story_v_out_321371", "321371103", "story_v_out_321371.awb")
				end

				arg_435_1:RecordContent(arg_435_1.text_.text)
			end

			local var_438_10 = math.max(var_438_1, arg_435_1.talkMaxDuration)

			if var_438_0 <= arg_435_1.time_ and arg_435_1.time_ < var_438_0 + var_438_10 then
				arg_435_1.typewritter.percent = (arg_435_1.time_ - var_438_0) / var_438_10

				arg_435_1.typewritter:SetDirty()
			end

			if arg_435_1.time_ >= var_438_0 + var_438_10 and arg_435_1.time_ < var_438_0 + var_438_10 + arg_438_0 then
				arg_435_1.typewritter.percent = 1

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(true)
			end
		end

		arg_435_1.nodeConfigList_ = {}

		arg_435_1:InitPlayNodeList()
	end,
	Play321371104 = function(arg_439_0, arg_439_1)
		arg_439_1.time_ = 0
		arg_439_1.frameCnt_ = 0
		arg_439_1.state_ = "playing"
		arg_439_1.curTalkId_ = 321371104
		arg_439_1.duration_ = 5.47

		local var_439_0 = {
			zh = 4.533,
			ja = 5.466
		}
		local var_439_1 = manager.audio:GetLocalizationFlag()

		if var_439_0[var_439_1] ~= nil then
			arg_439_1.duration_ = var_439_0[var_439_1]
		end

		SetActive(arg_439_1.tipsGo_, false)

		function arg_439_1.onSingleLineFinish_()
			arg_439_1.onSingleLineUpdate_ = nil
			arg_439_1.onSingleLineFinish_ = nil
			arg_439_1.state_ = "waiting"
		end

		function arg_439_1.playNext_(arg_441_0)
			if arg_441_0 == 1 then
				arg_439_0:Play321371105(arg_439_1)
			end
		end

		function arg_439_1.onSingleLineUpdate_(arg_442_0)
			local var_442_0 = 0
			local var_442_1 = 0.425

			if var_442_0 < arg_439_1.time_ and arg_439_1.time_ <= var_442_0 + arg_442_0 then
				arg_439_1.talkMaxDuration = 0
				arg_439_1.dialogCg_.alpha = 1

				arg_439_1.dialog_:SetActive(true)
				SetActive(arg_439_1.leftNameGo_, true)

				local var_442_2 = arg_439_1:FormatText(StoryNameCfg[1178].name)

				arg_439_1.leftNameTxt_.text = var_442_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_439_1.leftNameTxt_.transform)

				arg_439_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_439_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_439_1:RecordName(arg_439_1.leftNameTxt_.text)
				SetActive(arg_439_1.iconTrs_.gameObject, true)
				arg_439_1.iconController_:SetSelectedState("hero")

				arg_439_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10131")

				arg_439_1.callingController_:SetSelectedState("normal")

				arg_439_1.keyicon_.color = Color.New(1, 1, 1)
				arg_439_1.icon_.color = Color.New(1, 1, 1)

				local var_442_3 = arg_439_1:GetWordFromCfg(321371104)
				local var_442_4 = arg_439_1:FormatText(var_442_3.content)

				arg_439_1.text_.text = var_442_4

				LuaForUtil.ClearLinePrefixSymbol(arg_439_1.text_)

				local var_442_5 = 17
				local var_442_6 = utf8.len(var_442_4)
				local var_442_7 = var_442_5 <= 0 and var_442_1 or var_442_1 * (var_442_6 / var_442_5)

				if var_442_7 > 0 and var_442_1 < var_442_7 then
					arg_439_1.talkMaxDuration = var_442_7

					if var_442_7 + var_442_0 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_7 + var_442_0
					end
				end

				arg_439_1.text_.text = var_442_4
				arg_439_1.typewritter.percent = 0

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371104", "story_v_out_321371.awb") ~= 0 then
					local var_442_8 = manager.audio:GetVoiceLength("story_v_out_321371", "321371104", "story_v_out_321371.awb") / 1000

					if var_442_8 + var_442_0 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_8 + var_442_0
					end

					if var_442_3.prefab_name ~= "" and arg_439_1.actors_[var_442_3.prefab_name] ~= nil then
						local var_442_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_439_1.actors_[var_442_3.prefab_name].transform, "story_v_out_321371", "321371104", "story_v_out_321371.awb")

						arg_439_1:RecordAudio("321371104", var_442_9)
						arg_439_1:RecordAudio("321371104", var_442_9)
					else
						arg_439_1:AudioAction("play", "voice", "story_v_out_321371", "321371104", "story_v_out_321371.awb")
					end

					arg_439_1:RecordHistoryTalkVoice("story_v_out_321371", "321371104", "story_v_out_321371.awb")
				end

				arg_439_1:RecordContent(arg_439_1.text_.text)
			end

			local var_442_10 = math.max(var_442_1, arg_439_1.talkMaxDuration)

			if var_442_0 <= arg_439_1.time_ and arg_439_1.time_ < var_442_0 + var_442_10 then
				arg_439_1.typewritter.percent = (arg_439_1.time_ - var_442_0) / var_442_10

				arg_439_1.typewritter:SetDirty()
			end

			if arg_439_1.time_ >= var_442_0 + var_442_10 and arg_439_1.time_ < var_442_0 + var_442_10 + arg_442_0 then
				arg_439_1.typewritter.percent = 1

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(true)
			end
		end

		arg_439_1.nodeConfigList_ = {}

		arg_439_1:InitPlayNodeList()
	end,
	Play321371105 = function(arg_443_0, arg_443_1)
		arg_443_1.time_ = 0
		arg_443_1.frameCnt_ = 0
		arg_443_1.state_ = "playing"
		arg_443_1.curTalkId_ = 321371105
		arg_443_1.duration_ = 5

		SetActive(arg_443_1.tipsGo_, false)

		function arg_443_1.onSingleLineFinish_()
			arg_443_1.onSingleLineUpdate_ = nil
			arg_443_1.onSingleLineFinish_ = nil
			arg_443_1.state_ = "waiting"
		end

		function arg_443_1.playNext_(arg_445_0)
			if arg_445_0 == 1 then
				arg_443_0:Play321371106(arg_443_1)
			end
		end

		function arg_443_1.onSingleLineUpdate_(arg_446_0)
			local var_446_0 = arg_443_1.actors_["10131ui_story"].transform
			local var_446_1 = 0

			if var_446_1 < arg_443_1.time_ and arg_443_1.time_ <= var_446_1 + arg_446_0 then
				arg_443_1.var_.moveOldPos10131ui_story = var_446_0.localPosition
			end

			local var_446_2 = 0.001

			if var_446_1 <= arg_443_1.time_ and arg_443_1.time_ < var_446_1 + var_446_2 then
				local var_446_3 = (arg_443_1.time_ - var_446_1) / var_446_2
				local var_446_4 = Vector3.New(0, 100, 0)

				var_446_0.localPosition = Vector3.Lerp(arg_443_1.var_.moveOldPos10131ui_story, var_446_4, var_446_3)

				local var_446_5 = manager.ui.mainCamera.transform.position - var_446_0.position

				var_446_0.forward = Vector3.New(var_446_5.x, var_446_5.y, var_446_5.z)

				local var_446_6 = var_446_0.localEulerAngles

				var_446_6.z = 0
				var_446_6.x = 0
				var_446_0.localEulerAngles = var_446_6
			end

			if arg_443_1.time_ >= var_446_1 + var_446_2 and arg_443_1.time_ < var_446_1 + var_446_2 + arg_446_0 then
				var_446_0.localPosition = Vector3.New(0, 100, 0)

				local var_446_7 = manager.ui.mainCamera.transform.position - var_446_0.position

				var_446_0.forward = Vector3.New(var_446_7.x, var_446_7.y, var_446_7.z)

				local var_446_8 = var_446_0.localEulerAngles

				var_446_8.z = 0
				var_446_8.x = 0
				var_446_0.localEulerAngles = var_446_8
			end

			local var_446_9 = arg_443_1.actors_["1111ui_story"].transform
			local var_446_10 = 0

			if var_446_10 < arg_443_1.time_ and arg_443_1.time_ <= var_446_10 + arg_446_0 then
				arg_443_1.var_.moveOldPos1111ui_story = var_446_9.localPosition
			end

			local var_446_11 = 0.001

			if var_446_10 <= arg_443_1.time_ and arg_443_1.time_ < var_446_10 + var_446_11 then
				local var_446_12 = (arg_443_1.time_ - var_446_10) / var_446_11
				local var_446_13 = Vector3.New(0, 100, 0)

				var_446_9.localPosition = Vector3.Lerp(arg_443_1.var_.moveOldPos1111ui_story, var_446_13, var_446_12)

				local var_446_14 = manager.ui.mainCamera.transform.position - var_446_9.position

				var_446_9.forward = Vector3.New(var_446_14.x, var_446_14.y, var_446_14.z)

				local var_446_15 = var_446_9.localEulerAngles

				var_446_15.z = 0
				var_446_15.x = 0
				var_446_9.localEulerAngles = var_446_15
			end

			if arg_443_1.time_ >= var_446_10 + var_446_11 and arg_443_1.time_ < var_446_10 + var_446_11 + arg_446_0 then
				var_446_9.localPosition = Vector3.New(0, 100, 0)

				local var_446_16 = manager.ui.mainCamera.transform.position - var_446_9.position

				var_446_9.forward = Vector3.New(var_446_16.x, var_446_16.y, var_446_16.z)

				local var_446_17 = var_446_9.localEulerAngles

				var_446_17.z = 0
				var_446_17.x = 0
				var_446_9.localEulerAngles = var_446_17
			end

			local var_446_18 = arg_443_1.actors_["10131ui_story"]
			local var_446_19 = 0

			if var_446_19 < arg_443_1.time_ and arg_443_1.time_ <= var_446_19 + arg_446_0 and not isNil(var_446_18) and arg_443_1.var_.characterEffect10131ui_story == nil then
				arg_443_1.var_.characterEffect10131ui_story = var_446_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_446_20 = 0.200000002980232

			if var_446_19 <= arg_443_1.time_ and arg_443_1.time_ < var_446_19 + var_446_20 and not isNil(var_446_18) then
				local var_446_21 = (arg_443_1.time_ - var_446_19) / var_446_20

				if arg_443_1.var_.characterEffect10131ui_story and not isNil(var_446_18) then
					local var_446_22 = Mathf.Lerp(0, 0.5, var_446_21)

					arg_443_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_443_1.var_.characterEffect10131ui_story.fillRatio = var_446_22
				end
			end

			if arg_443_1.time_ >= var_446_19 + var_446_20 and arg_443_1.time_ < var_446_19 + var_446_20 + arg_446_0 and not isNil(var_446_18) and arg_443_1.var_.characterEffect10131ui_story then
				local var_446_23 = 0.5

				arg_443_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_443_1.var_.characterEffect10131ui_story.fillRatio = var_446_23
			end

			local var_446_24 = 0
			local var_446_25 = 0.525

			if var_446_24 < arg_443_1.time_ and arg_443_1.time_ <= var_446_24 + arg_446_0 then
				arg_443_1.talkMaxDuration = 0
				arg_443_1.dialogCg_.alpha = 1

				arg_443_1.dialog_:SetActive(true)
				SetActive(arg_443_1.leftNameGo_, false)

				arg_443_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_443_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_443_1:RecordName(arg_443_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_443_1.iconTrs_.gameObject, false)
				arg_443_1.callingController_:SetSelectedState("normal")

				local var_446_26 = arg_443_1:GetWordFromCfg(321371105)
				local var_446_27 = arg_443_1:FormatText(var_446_26.content)

				arg_443_1.text_.text = var_446_27

				LuaForUtil.ClearLinePrefixSymbol(arg_443_1.text_)

				local var_446_28 = 21
				local var_446_29 = utf8.len(var_446_27)
				local var_446_30 = var_446_28 <= 0 and var_446_25 or var_446_25 * (var_446_29 / var_446_28)

				if var_446_30 > 0 and var_446_25 < var_446_30 then
					arg_443_1.talkMaxDuration = var_446_30

					if var_446_30 + var_446_24 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_30 + var_446_24
					end
				end

				arg_443_1.text_.text = var_446_27
				arg_443_1.typewritter.percent = 0

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(false)
				arg_443_1:RecordContent(arg_443_1.text_.text)
			end

			local var_446_31 = math.max(var_446_25, arg_443_1.talkMaxDuration)

			if var_446_24 <= arg_443_1.time_ and arg_443_1.time_ < var_446_24 + var_446_31 then
				arg_443_1.typewritter.percent = (arg_443_1.time_ - var_446_24) / var_446_31

				arg_443_1.typewritter:SetDirty()
			end

			if arg_443_1.time_ >= var_446_24 + var_446_31 and arg_443_1.time_ < var_446_24 + var_446_31 + arg_446_0 then
				arg_443_1.typewritter.percent = 1

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(true)
			end
		end

		arg_443_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10131ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_443_1:InitPlayNodeList()
	end,
	Play321371106 = function(arg_447_0, arg_447_1)
		arg_447_1.time_ = 0
		arg_447_1.frameCnt_ = 0
		arg_447_1.state_ = "playing"
		arg_447_1.curTalkId_ = 321371106
		arg_447_1.duration_ = 5

		SetActive(arg_447_1.tipsGo_, false)

		function arg_447_1.onSingleLineFinish_()
			arg_447_1.onSingleLineUpdate_ = nil
			arg_447_1.onSingleLineFinish_ = nil
			arg_447_1.state_ = "waiting"
		end

		function arg_447_1.playNext_(arg_449_0)
			if arg_449_0 == 1 then
				arg_447_0:Play321371107(arg_447_1)
			end
		end

		function arg_447_1.onSingleLineUpdate_(arg_450_0)
			local var_450_0 = 0
			local var_450_1 = 1.25

			if var_450_0 < arg_447_1.time_ and arg_447_1.time_ <= var_450_0 + arg_450_0 then
				arg_447_1.talkMaxDuration = 0
				arg_447_1.dialogCg_.alpha = 1

				arg_447_1.dialog_:SetActive(true)
				SetActive(arg_447_1.leftNameGo_, false)

				arg_447_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_447_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_447_1:RecordName(arg_447_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_447_1.iconTrs_.gameObject, false)
				arg_447_1.callingController_:SetSelectedState("normal")

				local var_450_2 = arg_447_1:GetWordFromCfg(321371106)
				local var_450_3 = arg_447_1:FormatText(var_450_2.content)

				arg_447_1.text_.text = var_450_3

				LuaForUtil.ClearLinePrefixSymbol(arg_447_1.text_)

				local var_450_4 = 50
				local var_450_5 = utf8.len(var_450_3)
				local var_450_6 = var_450_4 <= 0 and var_450_1 or var_450_1 * (var_450_5 / var_450_4)

				if var_450_6 > 0 and var_450_1 < var_450_6 then
					arg_447_1.talkMaxDuration = var_450_6

					if var_450_6 + var_450_0 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_6 + var_450_0
					end
				end

				arg_447_1.text_.text = var_450_3
				arg_447_1.typewritter.percent = 0

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(false)
				arg_447_1:RecordContent(arg_447_1.text_.text)
			end

			local var_450_7 = math.max(var_450_1, arg_447_1.talkMaxDuration)

			if var_450_0 <= arg_447_1.time_ and arg_447_1.time_ < var_450_0 + var_450_7 then
				arg_447_1.typewritter.percent = (arg_447_1.time_ - var_450_0) / var_450_7

				arg_447_1.typewritter:SetDirty()
			end

			if arg_447_1.time_ >= var_450_0 + var_450_7 and arg_447_1.time_ < var_450_0 + var_450_7 + arg_450_0 then
				arg_447_1.typewritter.percent = 1

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(true)
			end
		end

		arg_447_1.nodeConfigList_ = {}

		arg_447_1:InitPlayNodeList()
	end,
	Play321371107 = function(arg_451_0, arg_451_1)
		arg_451_1.time_ = 0
		arg_451_1.frameCnt_ = 0
		arg_451_1.state_ = "playing"
		arg_451_1.curTalkId_ = 321371107
		arg_451_1.duration_ = 4.77

		local var_451_0 = {
			zh = 4.766,
			ja = 3.6
		}
		local var_451_1 = manager.audio:GetLocalizationFlag()

		if var_451_0[var_451_1] ~= nil then
			arg_451_1.duration_ = var_451_0[var_451_1]
		end

		SetActive(arg_451_1.tipsGo_, false)

		function arg_451_1.onSingleLineFinish_()
			arg_451_1.onSingleLineUpdate_ = nil
			arg_451_1.onSingleLineFinish_ = nil
			arg_451_1.state_ = "waiting"
		end

		function arg_451_1.playNext_(arg_453_0)
			if arg_453_0 == 1 then
				arg_451_0:Play321371108(arg_451_1)
			end
		end

		function arg_451_1.onSingleLineUpdate_(arg_454_0)
			local var_454_0 = arg_451_1.actors_["1111ui_story"].transform
			local var_454_1 = 0

			if var_454_1 < arg_451_1.time_ and arg_451_1.time_ <= var_454_1 + arg_454_0 then
				arg_451_1.var_.moveOldPos1111ui_story = var_454_0.localPosition
			end

			local var_454_2 = 0.001

			if var_454_1 <= arg_451_1.time_ and arg_451_1.time_ < var_454_1 + var_454_2 then
				local var_454_3 = (arg_451_1.time_ - var_454_1) / var_454_2
				local var_454_4 = Vector3.New(0, -0.87, -5.7)

				var_454_0.localPosition = Vector3.Lerp(arg_451_1.var_.moveOldPos1111ui_story, var_454_4, var_454_3)

				local var_454_5 = manager.ui.mainCamera.transform.position - var_454_0.position

				var_454_0.forward = Vector3.New(var_454_5.x, var_454_5.y, var_454_5.z)

				local var_454_6 = var_454_0.localEulerAngles

				var_454_6.z = 0
				var_454_6.x = 0
				var_454_0.localEulerAngles = var_454_6
			end

			if arg_451_1.time_ >= var_454_1 + var_454_2 and arg_451_1.time_ < var_454_1 + var_454_2 + arg_454_0 then
				var_454_0.localPosition = Vector3.New(0, -0.87, -5.7)

				local var_454_7 = manager.ui.mainCamera.transform.position - var_454_0.position

				var_454_0.forward = Vector3.New(var_454_7.x, var_454_7.y, var_454_7.z)

				local var_454_8 = var_454_0.localEulerAngles

				var_454_8.z = 0
				var_454_8.x = 0
				var_454_0.localEulerAngles = var_454_8
			end

			local var_454_9 = arg_451_1.actors_["1111ui_story"]
			local var_454_10 = 0

			if var_454_10 < arg_451_1.time_ and arg_451_1.time_ <= var_454_10 + arg_454_0 and not isNil(var_454_9) and arg_451_1.var_.characterEffect1111ui_story == nil then
				arg_451_1.var_.characterEffect1111ui_story = var_454_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_454_11 = 0.200000002980232

			if var_454_10 <= arg_451_1.time_ and arg_451_1.time_ < var_454_10 + var_454_11 and not isNil(var_454_9) then
				local var_454_12 = (arg_451_1.time_ - var_454_10) / var_454_11

				if arg_451_1.var_.characterEffect1111ui_story and not isNil(var_454_9) then
					arg_451_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_451_1.time_ >= var_454_10 + var_454_11 and arg_451_1.time_ < var_454_10 + var_454_11 + arg_454_0 and not isNil(var_454_9) and arg_451_1.var_.characterEffect1111ui_story then
				arg_451_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_454_13 = 0

			if var_454_13 < arg_451_1.time_ and arg_451_1.time_ <= var_454_13 + arg_454_0 then
				arg_451_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action1_1")
			end

			local var_454_14 = 0

			if var_454_14 < arg_451_1.time_ and arg_451_1.time_ <= var_454_14 + arg_454_0 then
				arg_451_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva", "EmotionTimelineAnimator")
			end

			local var_454_15 = 0
			local var_454_16 = 0.35

			if var_454_15 < arg_451_1.time_ and arg_451_1.time_ <= var_454_15 + arg_454_0 then
				arg_451_1.talkMaxDuration = 0
				arg_451_1.dialogCg_.alpha = 1

				arg_451_1.dialog_:SetActive(true)
				SetActive(arg_451_1.leftNameGo_, true)

				local var_454_17 = arg_451_1:FormatText(StoryNameCfg[67].name)

				arg_451_1.leftNameTxt_.text = var_454_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_451_1.leftNameTxt_.transform)

				arg_451_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_451_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_451_1:RecordName(arg_451_1.leftNameTxt_.text)
				SetActive(arg_451_1.iconTrs_.gameObject, false)
				arg_451_1.callingController_:SetSelectedState("normal")

				local var_454_18 = arg_451_1:GetWordFromCfg(321371107)
				local var_454_19 = arg_451_1:FormatText(var_454_18.content)

				arg_451_1.text_.text = var_454_19

				LuaForUtil.ClearLinePrefixSymbol(arg_451_1.text_)

				local var_454_20 = 14
				local var_454_21 = utf8.len(var_454_19)
				local var_454_22 = var_454_20 <= 0 and var_454_16 or var_454_16 * (var_454_21 / var_454_20)

				if var_454_22 > 0 and var_454_16 < var_454_22 then
					arg_451_1.talkMaxDuration = var_454_22

					if var_454_22 + var_454_15 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_22 + var_454_15
					end
				end

				arg_451_1.text_.text = var_454_19
				arg_451_1.typewritter.percent = 0

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371107", "story_v_out_321371.awb") ~= 0 then
					local var_454_23 = manager.audio:GetVoiceLength("story_v_out_321371", "321371107", "story_v_out_321371.awb") / 1000

					if var_454_23 + var_454_15 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_23 + var_454_15
					end

					if var_454_18.prefab_name ~= "" and arg_451_1.actors_[var_454_18.prefab_name] ~= nil then
						local var_454_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_451_1.actors_[var_454_18.prefab_name].transform, "story_v_out_321371", "321371107", "story_v_out_321371.awb")

						arg_451_1:RecordAudio("321371107", var_454_24)
						arg_451_1:RecordAudio("321371107", var_454_24)
					else
						arg_451_1:AudioAction("play", "voice", "story_v_out_321371", "321371107", "story_v_out_321371.awb")
					end

					arg_451_1:RecordHistoryTalkVoice("story_v_out_321371", "321371107", "story_v_out_321371.awb")
				end

				arg_451_1:RecordContent(arg_451_1.text_.text)
			end

			local var_454_25 = math.max(var_454_16, arg_451_1.talkMaxDuration)

			if var_454_15 <= arg_451_1.time_ and arg_451_1.time_ < var_454_15 + var_454_25 then
				arg_451_1.typewritter.percent = (arg_451_1.time_ - var_454_15) / var_454_25

				arg_451_1.typewritter:SetDirty()
			end

			if arg_451_1.time_ >= var_454_15 + var_454_25 and arg_451_1.time_ < var_454_15 + var_454_25 + arg_454_0 then
				arg_451_1.typewritter.percent = 1

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(true)
			end
		end

		arg_451_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_451_1:InitPlayNodeList()
	end,
	Play321371108 = function(arg_455_0, arg_455_1)
		arg_455_1.time_ = 0
		arg_455_1.frameCnt_ = 0
		arg_455_1.state_ = "playing"
		arg_455_1.curTalkId_ = 321371108
		arg_455_1.duration_ = 4.77

		local var_455_0 = {
			zh = 4.4,
			ja = 4.766
		}
		local var_455_1 = manager.audio:GetLocalizationFlag()

		if var_455_0[var_455_1] ~= nil then
			arg_455_1.duration_ = var_455_0[var_455_1]
		end

		SetActive(arg_455_1.tipsGo_, false)

		function arg_455_1.onSingleLineFinish_()
			arg_455_1.onSingleLineUpdate_ = nil
			arg_455_1.onSingleLineFinish_ = nil
			arg_455_1.state_ = "waiting"
		end

		function arg_455_1.playNext_(arg_457_0)
			if arg_457_0 == 1 then
				arg_455_0:Play321371109(arg_455_1)
			end
		end

		function arg_455_1.onSingleLineUpdate_(arg_458_0)
			local var_458_0 = arg_455_1.actors_["1111ui_story"]
			local var_458_1 = 0

			if var_458_1 < arg_455_1.time_ and arg_455_1.time_ <= var_458_1 + arg_458_0 and not isNil(var_458_0) and arg_455_1.var_.characterEffect1111ui_story == nil then
				arg_455_1.var_.characterEffect1111ui_story = var_458_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_458_2 = 0.200000002980232

			if var_458_1 <= arg_455_1.time_ and arg_455_1.time_ < var_458_1 + var_458_2 and not isNil(var_458_0) then
				local var_458_3 = (arg_455_1.time_ - var_458_1) / var_458_2

				if arg_455_1.var_.characterEffect1111ui_story and not isNil(var_458_0) then
					local var_458_4 = Mathf.Lerp(0, 0.5, var_458_3)

					arg_455_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_455_1.var_.characterEffect1111ui_story.fillRatio = var_458_4
				end
			end

			if arg_455_1.time_ >= var_458_1 + var_458_2 and arg_455_1.time_ < var_458_1 + var_458_2 + arg_458_0 and not isNil(var_458_0) and arg_455_1.var_.characterEffect1111ui_story then
				local var_458_5 = 0.5

				arg_455_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_455_1.var_.characterEffect1111ui_story.fillRatio = var_458_5
			end

			local var_458_6 = 0
			local var_458_7 = 0.45

			if var_458_6 < arg_455_1.time_ and arg_455_1.time_ <= var_458_6 + arg_458_0 then
				arg_455_1.talkMaxDuration = 0
				arg_455_1.dialogCg_.alpha = 1

				arg_455_1.dialog_:SetActive(true)
				SetActive(arg_455_1.leftNameGo_, true)

				local var_458_8 = arg_455_1:FormatText(StoryNameCfg[1178].name)

				arg_455_1.leftNameTxt_.text = var_458_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_455_1.leftNameTxt_.transform)

				arg_455_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_455_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_455_1:RecordName(arg_455_1.leftNameTxt_.text)
				SetActive(arg_455_1.iconTrs_.gameObject, true)
				arg_455_1.iconController_:SetSelectedState("hero")

				arg_455_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10131")

				arg_455_1.callingController_:SetSelectedState("normal")

				arg_455_1.keyicon_.color = Color.New(1, 1, 1)
				arg_455_1.icon_.color = Color.New(1, 1, 1)

				local var_458_9 = arg_455_1:GetWordFromCfg(321371108)
				local var_458_10 = arg_455_1:FormatText(var_458_9.content)

				arg_455_1.text_.text = var_458_10

				LuaForUtil.ClearLinePrefixSymbol(arg_455_1.text_)

				local var_458_11 = 18
				local var_458_12 = utf8.len(var_458_10)
				local var_458_13 = var_458_11 <= 0 and var_458_7 or var_458_7 * (var_458_12 / var_458_11)

				if var_458_13 > 0 and var_458_7 < var_458_13 then
					arg_455_1.talkMaxDuration = var_458_13

					if var_458_13 + var_458_6 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_13 + var_458_6
					end
				end

				arg_455_1.text_.text = var_458_10
				arg_455_1.typewritter.percent = 0

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371108", "story_v_out_321371.awb") ~= 0 then
					local var_458_14 = manager.audio:GetVoiceLength("story_v_out_321371", "321371108", "story_v_out_321371.awb") / 1000

					if var_458_14 + var_458_6 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_14 + var_458_6
					end

					if var_458_9.prefab_name ~= "" and arg_455_1.actors_[var_458_9.prefab_name] ~= nil then
						local var_458_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_455_1.actors_[var_458_9.prefab_name].transform, "story_v_out_321371", "321371108", "story_v_out_321371.awb")

						arg_455_1:RecordAudio("321371108", var_458_15)
						arg_455_1:RecordAudio("321371108", var_458_15)
					else
						arg_455_1:AudioAction("play", "voice", "story_v_out_321371", "321371108", "story_v_out_321371.awb")
					end

					arg_455_1:RecordHistoryTalkVoice("story_v_out_321371", "321371108", "story_v_out_321371.awb")
				end

				arg_455_1:RecordContent(arg_455_1.text_.text)
			end

			local var_458_16 = math.max(var_458_7, arg_455_1.talkMaxDuration)

			if var_458_6 <= arg_455_1.time_ and arg_455_1.time_ < var_458_6 + var_458_16 then
				arg_455_1.typewritter.percent = (arg_455_1.time_ - var_458_6) / var_458_16

				arg_455_1.typewritter:SetDirty()
			end

			if arg_455_1.time_ >= var_458_6 + var_458_16 and arg_455_1.time_ < var_458_6 + var_458_16 + arg_458_0 then
				arg_455_1.typewritter.percent = 1

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(true)
			end
		end

		arg_455_1.nodeConfigList_ = {}

		arg_455_1:InitPlayNodeList()
	end,
	Play321371109 = function(arg_459_0, arg_459_1)
		arg_459_1.time_ = 0
		arg_459_1.frameCnt_ = 0
		arg_459_1.state_ = "playing"
		arg_459_1.curTalkId_ = 321371109
		arg_459_1.duration_ = 5.2

		local var_459_0 = {
			zh = 3.3,
			ja = 5.2
		}
		local var_459_1 = manager.audio:GetLocalizationFlag()

		if var_459_0[var_459_1] ~= nil then
			arg_459_1.duration_ = var_459_0[var_459_1]
		end

		SetActive(arg_459_1.tipsGo_, false)

		function arg_459_1.onSingleLineFinish_()
			arg_459_1.onSingleLineUpdate_ = nil
			arg_459_1.onSingleLineFinish_ = nil
			arg_459_1.state_ = "waiting"
		end

		function arg_459_1.playNext_(arg_461_0)
			if arg_461_0 == 1 then
				arg_459_0:Play321371110(arg_459_1)
			end
		end

		function arg_459_1.onSingleLineUpdate_(arg_462_0)
			local var_462_0 = arg_459_1.actors_["1111ui_story"]
			local var_462_1 = 0

			if var_462_1 < arg_459_1.time_ and arg_459_1.time_ <= var_462_1 + arg_462_0 and not isNil(var_462_0) and arg_459_1.var_.characterEffect1111ui_story == nil then
				arg_459_1.var_.characterEffect1111ui_story = var_462_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_462_2 = 0.200000002980232

			if var_462_1 <= arg_459_1.time_ and arg_459_1.time_ < var_462_1 + var_462_2 and not isNil(var_462_0) then
				local var_462_3 = (arg_459_1.time_ - var_462_1) / var_462_2

				if arg_459_1.var_.characterEffect1111ui_story and not isNil(var_462_0) then
					arg_459_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_459_1.time_ >= var_462_1 + var_462_2 and arg_459_1.time_ < var_462_1 + var_462_2 + arg_462_0 and not isNil(var_462_0) and arg_459_1.var_.characterEffect1111ui_story then
				arg_459_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_462_4 = arg_459_1.actors_["10131ui_story"]
			local var_462_5 = 0

			if var_462_5 < arg_459_1.time_ and arg_459_1.time_ <= var_462_5 + arg_462_0 and not isNil(var_462_4) and arg_459_1.var_.characterEffect10131ui_story == nil then
				arg_459_1.var_.characterEffect10131ui_story = var_462_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_462_6 = 0.200000002980232

			if var_462_5 <= arg_459_1.time_ and arg_459_1.time_ < var_462_5 + var_462_6 and not isNil(var_462_4) then
				local var_462_7 = (arg_459_1.time_ - var_462_5) / var_462_6

				if arg_459_1.var_.characterEffect10131ui_story and not isNil(var_462_4) then
					local var_462_8 = Mathf.Lerp(0, 0.5, var_462_7)

					arg_459_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_459_1.var_.characterEffect10131ui_story.fillRatio = var_462_8
				end
			end

			if arg_459_1.time_ >= var_462_5 + var_462_6 and arg_459_1.time_ < var_462_5 + var_462_6 + arg_462_0 and not isNil(var_462_4) and arg_459_1.var_.characterEffect10131ui_story then
				local var_462_9 = 0.5

				arg_459_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_459_1.var_.characterEffect10131ui_story.fillRatio = var_462_9
			end

			local var_462_10 = 0

			if var_462_10 < arg_459_1.time_ and arg_459_1.time_ <= var_462_10 + arg_462_0 then
				arg_459_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action4_1")
			end

			local var_462_11 = 0

			if var_462_11 < arg_459_1.time_ and arg_459_1.time_ <= var_462_11 + arg_462_0 then
				arg_459_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_462_12 = 0
			local var_462_13 = 0.35

			if var_462_12 < arg_459_1.time_ and arg_459_1.time_ <= var_462_12 + arg_462_0 then
				arg_459_1.talkMaxDuration = 0
				arg_459_1.dialogCg_.alpha = 1

				arg_459_1.dialog_:SetActive(true)
				SetActive(arg_459_1.leftNameGo_, true)

				local var_462_14 = arg_459_1:FormatText(StoryNameCfg[67].name)

				arg_459_1.leftNameTxt_.text = var_462_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_459_1.leftNameTxt_.transform)

				arg_459_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_459_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_459_1:RecordName(arg_459_1.leftNameTxt_.text)
				SetActive(arg_459_1.iconTrs_.gameObject, false)
				arg_459_1.callingController_:SetSelectedState("normal")

				local var_462_15 = arg_459_1:GetWordFromCfg(321371109)
				local var_462_16 = arg_459_1:FormatText(var_462_15.content)

				arg_459_1.text_.text = var_462_16

				LuaForUtil.ClearLinePrefixSymbol(arg_459_1.text_)

				local var_462_17 = 14
				local var_462_18 = utf8.len(var_462_16)
				local var_462_19 = var_462_17 <= 0 and var_462_13 or var_462_13 * (var_462_18 / var_462_17)

				if var_462_19 > 0 and var_462_13 < var_462_19 then
					arg_459_1.talkMaxDuration = var_462_19

					if var_462_19 + var_462_12 > arg_459_1.duration_ then
						arg_459_1.duration_ = var_462_19 + var_462_12
					end
				end

				arg_459_1.text_.text = var_462_16
				arg_459_1.typewritter.percent = 0

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371109", "story_v_out_321371.awb") ~= 0 then
					local var_462_20 = manager.audio:GetVoiceLength("story_v_out_321371", "321371109", "story_v_out_321371.awb") / 1000

					if var_462_20 + var_462_12 > arg_459_1.duration_ then
						arg_459_1.duration_ = var_462_20 + var_462_12
					end

					if var_462_15.prefab_name ~= "" and arg_459_1.actors_[var_462_15.prefab_name] ~= nil then
						local var_462_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_459_1.actors_[var_462_15.prefab_name].transform, "story_v_out_321371", "321371109", "story_v_out_321371.awb")

						arg_459_1:RecordAudio("321371109", var_462_21)
						arg_459_1:RecordAudio("321371109", var_462_21)
					else
						arg_459_1:AudioAction("play", "voice", "story_v_out_321371", "321371109", "story_v_out_321371.awb")
					end

					arg_459_1:RecordHistoryTalkVoice("story_v_out_321371", "321371109", "story_v_out_321371.awb")
				end

				arg_459_1:RecordContent(arg_459_1.text_.text)
			end

			local var_462_22 = math.max(var_462_13, arg_459_1.talkMaxDuration)

			if var_462_12 <= arg_459_1.time_ and arg_459_1.time_ < var_462_12 + var_462_22 then
				arg_459_1.typewritter.percent = (arg_459_1.time_ - var_462_12) / var_462_22

				arg_459_1.typewritter:SetDirty()
			end

			if arg_459_1.time_ >= var_462_12 + var_462_22 and arg_459_1.time_ < var_462_12 + var_462_22 + arg_462_0 then
				arg_459_1.typewritter.percent = 1

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(true)
			end
		end

		arg_459_1.nodeConfigList_ = {}

		arg_459_1:InitPlayNodeList()
	end,
	Play321371110 = function(arg_463_0, arg_463_1)
		arg_463_1.time_ = 0
		arg_463_1.frameCnt_ = 0
		arg_463_1.state_ = "playing"
		arg_463_1.curTalkId_ = 321371110
		arg_463_1.duration_ = 1.53

		local var_463_0 = {
			zh = 1.033,
			ja = 1.533
		}
		local var_463_1 = manager.audio:GetLocalizationFlag()

		if var_463_0[var_463_1] ~= nil then
			arg_463_1.duration_ = var_463_0[var_463_1]
		end

		SetActive(arg_463_1.tipsGo_, false)

		function arg_463_1.onSingleLineFinish_()
			arg_463_1.onSingleLineUpdate_ = nil
			arg_463_1.onSingleLineFinish_ = nil
			arg_463_1.state_ = "waiting"
		end

		function arg_463_1.playNext_(arg_465_0)
			if arg_465_0 == 1 then
				arg_463_0:Play321371111(arg_463_1)
			end
		end

		function arg_463_1.onSingleLineUpdate_(arg_466_0)
			local var_466_0 = arg_463_1.actors_["1111ui_story"]
			local var_466_1 = 0

			if var_466_1 < arg_463_1.time_ and arg_463_1.time_ <= var_466_1 + arg_466_0 and not isNil(var_466_0) and arg_463_1.var_.characterEffect1111ui_story == nil then
				arg_463_1.var_.characterEffect1111ui_story = var_466_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_466_2 = 0.200000002980232

			if var_466_1 <= arg_463_1.time_ and arg_463_1.time_ < var_466_1 + var_466_2 and not isNil(var_466_0) then
				local var_466_3 = (arg_463_1.time_ - var_466_1) / var_466_2

				if arg_463_1.var_.characterEffect1111ui_story and not isNil(var_466_0) then
					local var_466_4 = Mathf.Lerp(0, 0.5, var_466_3)

					arg_463_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_463_1.var_.characterEffect1111ui_story.fillRatio = var_466_4
				end
			end

			if arg_463_1.time_ >= var_466_1 + var_466_2 and arg_463_1.time_ < var_466_1 + var_466_2 + arg_466_0 and not isNil(var_466_0) and arg_463_1.var_.characterEffect1111ui_story then
				local var_466_5 = 0.5

				arg_463_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_463_1.var_.characterEffect1111ui_story.fillRatio = var_466_5
			end

			local var_466_6 = 0
			local var_466_7 = 0.075

			if var_466_6 < arg_463_1.time_ and arg_463_1.time_ <= var_466_6 + arg_466_0 then
				arg_463_1.talkMaxDuration = 0
				arg_463_1.dialogCg_.alpha = 1

				arg_463_1.dialog_:SetActive(true)
				SetActive(arg_463_1.leftNameGo_, true)

				local var_466_8 = arg_463_1:FormatText(StoryNameCfg[1178].name)

				arg_463_1.leftNameTxt_.text = var_466_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_463_1.leftNameTxt_.transform)

				arg_463_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_463_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_463_1:RecordName(arg_463_1.leftNameTxt_.text)
				SetActive(arg_463_1.iconTrs_.gameObject, true)
				arg_463_1.iconController_:SetSelectedState("hero")

				arg_463_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10131")

				arg_463_1.callingController_:SetSelectedState("normal")

				arg_463_1.keyicon_.color = Color.New(1, 1, 1)
				arg_463_1.icon_.color = Color.New(1, 1, 1)

				local var_466_9 = arg_463_1:GetWordFromCfg(321371110)
				local var_466_10 = arg_463_1:FormatText(var_466_9.content)

				arg_463_1.text_.text = var_466_10

				LuaForUtil.ClearLinePrefixSymbol(arg_463_1.text_)

				local var_466_11 = 3
				local var_466_12 = utf8.len(var_466_10)
				local var_466_13 = var_466_11 <= 0 and var_466_7 or var_466_7 * (var_466_12 / var_466_11)

				if var_466_13 > 0 and var_466_7 < var_466_13 then
					arg_463_1.talkMaxDuration = var_466_13

					if var_466_13 + var_466_6 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_13 + var_466_6
					end
				end

				arg_463_1.text_.text = var_466_10
				arg_463_1.typewritter.percent = 0

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371110", "story_v_out_321371.awb") ~= 0 then
					local var_466_14 = manager.audio:GetVoiceLength("story_v_out_321371", "321371110", "story_v_out_321371.awb") / 1000

					if var_466_14 + var_466_6 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_14 + var_466_6
					end

					if var_466_9.prefab_name ~= "" and arg_463_1.actors_[var_466_9.prefab_name] ~= nil then
						local var_466_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_463_1.actors_[var_466_9.prefab_name].transform, "story_v_out_321371", "321371110", "story_v_out_321371.awb")

						arg_463_1:RecordAudio("321371110", var_466_15)
						arg_463_1:RecordAudio("321371110", var_466_15)
					else
						arg_463_1:AudioAction("play", "voice", "story_v_out_321371", "321371110", "story_v_out_321371.awb")
					end

					arg_463_1:RecordHistoryTalkVoice("story_v_out_321371", "321371110", "story_v_out_321371.awb")
				end

				arg_463_1:RecordContent(arg_463_1.text_.text)
			end

			local var_466_16 = math.max(var_466_7, arg_463_1.talkMaxDuration)

			if var_466_6 <= arg_463_1.time_ and arg_463_1.time_ < var_466_6 + var_466_16 then
				arg_463_1.typewritter.percent = (arg_463_1.time_ - var_466_6) / var_466_16

				arg_463_1.typewritter:SetDirty()
			end

			if arg_463_1.time_ >= var_466_6 + var_466_16 and arg_463_1.time_ < var_466_6 + var_466_16 + arg_466_0 then
				arg_463_1.typewritter.percent = 1

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(true)
			end
		end

		arg_463_1.nodeConfigList_ = {}

		arg_463_1:InitPlayNodeList()
	end,
	Play321371111 = function(arg_467_0, arg_467_1)
		arg_467_1.time_ = 0
		arg_467_1.frameCnt_ = 0
		arg_467_1.state_ = "playing"
		arg_467_1.curTalkId_ = 321371111
		arg_467_1.duration_ = 11.13

		local var_467_0 = {
			zh = 8.333,
			ja = 11.133
		}
		local var_467_1 = manager.audio:GetLocalizationFlag()

		if var_467_0[var_467_1] ~= nil then
			arg_467_1.duration_ = var_467_0[var_467_1]
		end

		SetActive(arg_467_1.tipsGo_, false)

		function arg_467_1.onSingleLineFinish_()
			arg_467_1.onSingleLineUpdate_ = nil
			arg_467_1.onSingleLineFinish_ = nil
			arg_467_1.state_ = "waiting"
		end

		function arg_467_1.playNext_(arg_469_0)
			if arg_469_0 == 1 then
				arg_467_0:Play321371112(arg_467_1)
			end
		end

		function arg_467_1.onSingleLineUpdate_(arg_470_0)
			local var_470_0 = arg_467_1.actors_["1111ui_story"].transform
			local var_470_1 = 0

			if var_470_1 < arg_467_1.time_ and arg_467_1.time_ <= var_470_1 + arg_470_0 then
				arg_467_1.var_.moveOldPos1111ui_story = var_470_0.localPosition
			end

			local var_470_2 = 0.001

			if var_470_1 <= arg_467_1.time_ and arg_467_1.time_ < var_470_1 + var_470_2 then
				local var_470_3 = (arg_467_1.time_ - var_470_1) / var_470_2
				local var_470_4 = Vector3.New(0, -0.87, -5.7)

				var_470_0.localPosition = Vector3.Lerp(arg_467_1.var_.moveOldPos1111ui_story, var_470_4, var_470_3)

				local var_470_5 = manager.ui.mainCamera.transform.position - var_470_0.position

				var_470_0.forward = Vector3.New(var_470_5.x, var_470_5.y, var_470_5.z)

				local var_470_6 = var_470_0.localEulerAngles

				var_470_6.z = 0
				var_470_6.x = 0
				var_470_0.localEulerAngles = var_470_6
			end

			if arg_467_1.time_ >= var_470_1 + var_470_2 and arg_467_1.time_ < var_470_1 + var_470_2 + arg_470_0 then
				var_470_0.localPosition = Vector3.New(0, -0.87, -5.7)

				local var_470_7 = manager.ui.mainCamera.transform.position - var_470_0.position

				var_470_0.forward = Vector3.New(var_470_7.x, var_470_7.y, var_470_7.z)

				local var_470_8 = var_470_0.localEulerAngles

				var_470_8.z = 0
				var_470_8.x = 0
				var_470_0.localEulerAngles = var_470_8
			end

			local var_470_9 = arg_467_1.actors_["1111ui_story"]
			local var_470_10 = 0

			if var_470_10 < arg_467_1.time_ and arg_467_1.time_ <= var_470_10 + arg_470_0 and not isNil(var_470_9) and arg_467_1.var_.characterEffect1111ui_story == nil then
				arg_467_1.var_.characterEffect1111ui_story = var_470_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_470_11 = 0.200000002980232

			if var_470_10 <= arg_467_1.time_ and arg_467_1.time_ < var_470_10 + var_470_11 and not isNil(var_470_9) then
				local var_470_12 = (arg_467_1.time_ - var_470_10) / var_470_11

				if arg_467_1.var_.characterEffect1111ui_story and not isNil(var_470_9) then
					arg_467_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_467_1.time_ >= var_470_10 + var_470_11 and arg_467_1.time_ < var_470_10 + var_470_11 + arg_470_0 and not isNil(var_470_9) and arg_467_1.var_.characterEffect1111ui_story then
				arg_467_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_470_13 = arg_467_1.actors_["10131ui_story"]
			local var_470_14 = 0

			if var_470_14 < arg_467_1.time_ and arg_467_1.time_ <= var_470_14 + arg_470_0 and not isNil(var_470_13) and arg_467_1.var_.characterEffect10131ui_story == nil then
				arg_467_1.var_.characterEffect10131ui_story = var_470_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_470_15 = 0.200000002980232

			if var_470_14 <= arg_467_1.time_ and arg_467_1.time_ < var_470_14 + var_470_15 and not isNil(var_470_13) then
				local var_470_16 = (arg_467_1.time_ - var_470_14) / var_470_15

				if arg_467_1.var_.characterEffect10131ui_story and not isNil(var_470_13) then
					local var_470_17 = Mathf.Lerp(0, 0.5, var_470_16)

					arg_467_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_467_1.var_.characterEffect10131ui_story.fillRatio = var_470_17
				end
			end

			if arg_467_1.time_ >= var_470_14 + var_470_15 and arg_467_1.time_ < var_470_14 + var_470_15 + arg_470_0 and not isNil(var_470_13) and arg_467_1.var_.characterEffect10131ui_story then
				local var_470_18 = 0.5

				arg_467_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_467_1.var_.characterEffect10131ui_story.fillRatio = var_470_18
			end

			local var_470_19 = 0

			if var_470_19 < arg_467_1.time_ and arg_467_1.time_ <= var_470_19 + arg_470_0 then
				arg_467_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111actionlink/1111action446")
			end

			local var_470_20 = 0

			if var_470_20 < arg_467_1.time_ and arg_467_1.time_ <= var_470_20 + arg_470_0 then
				arg_467_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_470_21 = 0
			local var_470_22 = 0.775

			if var_470_21 < arg_467_1.time_ and arg_467_1.time_ <= var_470_21 + arg_470_0 then
				arg_467_1.talkMaxDuration = 0
				arg_467_1.dialogCg_.alpha = 1

				arg_467_1.dialog_:SetActive(true)
				SetActive(arg_467_1.leftNameGo_, true)

				local var_470_23 = arg_467_1:FormatText(StoryNameCfg[67].name)

				arg_467_1.leftNameTxt_.text = var_470_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_467_1.leftNameTxt_.transform)

				arg_467_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_467_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_467_1:RecordName(arg_467_1.leftNameTxt_.text)
				SetActive(arg_467_1.iconTrs_.gameObject, false)
				arg_467_1.callingController_:SetSelectedState("normal")

				local var_470_24 = arg_467_1:GetWordFromCfg(321371111)
				local var_470_25 = arg_467_1:FormatText(var_470_24.content)

				arg_467_1.text_.text = var_470_25

				LuaForUtil.ClearLinePrefixSymbol(arg_467_1.text_)

				local var_470_26 = 31
				local var_470_27 = utf8.len(var_470_25)
				local var_470_28 = var_470_26 <= 0 and var_470_22 or var_470_22 * (var_470_27 / var_470_26)

				if var_470_28 > 0 and var_470_22 < var_470_28 then
					arg_467_1.talkMaxDuration = var_470_28

					if var_470_28 + var_470_21 > arg_467_1.duration_ then
						arg_467_1.duration_ = var_470_28 + var_470_21
					end
				end

				arg_467_1.text_.text = var_470_25
				arg_467_1.typewritter.percent = 0

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371111", "story_v_out_321371.awb") ~= 0 then
					local var_470_29 = manager.audio:GetVoiceLength("story_v_out_321371", "321371111", "story_v_out_321371.awb") / 1000

					if var_470_29 + var_470_21 > arg_467_1.duration_ then
						arg_467_1.duration_ = var_470_29 + var_470_21
					end

					if var_470_24.prefab_name ~= "" and arg_467_1.actors_[var_470_24.prefab_name] ~= nil then
						local var_470_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_467_1.actors_[var_470_24.prefab_name].transform, "story_v_out_321371", "321371111", "story_v_out_321371.awb")

						arg_467_1:RecordAudio("321371111", var_470_30)
						arg_467_1:RecordAudio("321371111", var_470_30)
					else
						arg_467_1:AudioAction("play", "voice", "story_v_out_321371", "321371111", "story_v_out_321371.awb")
					end

					arg_467_1:RecordHistoryTalkVoice("story_v_out_321371", "321371111", "story_v_out_321371.awb")
				end

				arg_467_1:RecordContent(arg_467_1.text_.text)
			end

			local var_470_31 = math.max(var_470_22, arg_467_1.talkMaxDuration)

			if var_470_21 <= arg_467_1.time_ and arg_467_1.time_ < var_470_21 + var_470_31 then
				arg_467_1.typewritter.percent = (arg_467_1.time_ - var_470_21) / var_470_31

				arg_467_1.typewritter:SetDirty()
			end

			if arg_467_1.time_ >= var_470_21 + var_470_31 and arg_467_1.time_ < var_470_21 + var_470_31 + arg_470_0 then
				arg_467_1.typewritter.percent = 1

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(true)
			end
		end

		arg_467_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_467_1:InitPlayNodeList()
	end,
	Play321371112 = function(arg_471_0, arg_471_1)
		arg_471_1.time_ = 0
		arg_471_1.frameCnt_ = 0
		arg_471_1.state_ = "playing"
		arg_471_1.curTalkId_ = 321371112
		arg_471_1.duration_ = 8

		SetActive(arg_471_1.tipsGo_, false)

		function arg_471_1.onSingleLineFinish_()
			arg_471_1.onSingleLineUpdate_ = nil
			arg_471_1.onSingleLineFinish_ = nil
			arg_471_1.state_ = "waiting"
		end

		function arg_471_1.playNext_(arg_473_0)
			if arg_473_0 == 1 then
				arg_471_0:Play321371113(arg_471_1)
			end
		end

		function arg_471_1.onSingleLineUpdate_(arg_474_0)
			local var_474_0 = "MS2112"

			if arg_471_1.bgs_[var_474_0] == nil then
				local var_474_1 = Object.Instantiate(arg_471_1.paintGo_)

				var_474_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_474_0)
				var_474_1.name = var_474_0
				var_474_1.transform.parent = arg_471_1.stage_.transform
				var_474_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_471_1.bgs_[var_474_0] = var_474_1
			end

			local var_474_2 = 0

			if var_474_2 < arg_471_1.time_ and arg_471_1.time_ <= var_474_2 + arg_474_0 then
				local var_474_3 = manager.ui.mainCamera.transform.localPosition
				local var_474_4 = Vector3.New(0, 0, 10) + Vector3.New(var_474_3.x, var_474_3.y, 0)
				local var_474_5 = arg_471_1.bgs_.MS2112

				var_474_5.transform.localPosition = var_474_4
				var_474_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_474_6 = var_474_5:GetComponent("SpriteRenderer")

				if var_474_6 and var_474_6.sprite then
					local var_474_7 = (var_474_5.transform.localPosition - var_474_3).z
					local var_474_8 = manager.ui.mainCameraCom_
					local var_474_9 = 2 * var_474_7 * Mathf.Tan(var_474_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_474_10 = var_474_9 * var_474_8.aspect
					local var_474_11 = var_474_6.sprite.bounds.size.x
					local var_474_12 = var_474_6.sprite.bounds.size.y
					local var_474_13 = var_474_10 / var_474_11
					local var_474_14 = var_474_9 / var_474_12
					local var_474_15 = var_474_14 < var_474_13 and var_474_13 or var_474_14

					var_474_5.transform.localScale = Vector3.New(var_474_15, var_474_15, 0)
				end

				for iter_474_0, iter_474_1 in pairs(arg_471_1.bgs_) do
					if iter_474_0 ~= "MS2112" then
						iter_474_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_474_16 = 1.999999999999

			if var_474_16 < arg_471_1.time_ and arg_471_1.time_ <= var_474_16 + arg_474_0 then
				arg_471_1.allBtn_.enabled = false
			end

			local var_474_17 = 0.3

			if arg_471_1.time_ >= var_474_16 + var_474_17 and arg_471_1.time_ < var_474_16 + var_474_17 + arg_474_0 then
				arg_471_1.allBtn_.enabled = true
			end

			local var_474_18 = 0

			if var_474_18 < arg_471_1.time_ and arg_471_1.time_ <= var_474_18 + arg_474_0 then
				arg_471_1.mask_.enabled = true
				arg_471_1.mask_.raycastTarget = true

				arg_471_1:SetGaussion(false)
			end

			local var_474_19 = 2

			if var_474_18 <= arg_471_1.time_ and arg_471_1.time_ < var_474_18 + var_474_19 then
				local var_474_20 = (arg_471_1.time_ - var_474_18) / var_474_19
				local var_474_21 = Color.New(1, 1, 1)

				var_474_21.a = Mathf.Lerp(1, 0, var_474_20)
				arg_471_1.mask_.color = var_474_21
			end

			if arg_471_1.time_ >= var_474_18 + var_474_19 and arg_471_1.time_ < var_474_18 + var_474_19 + arg_474_0 then
				local var_474_22 = Color.New(1, 1, 1)
				local var_474_23 = 0

				arg_471_1.mask_.enabled = false
				var_474_22.a = var_474_23
				arg_471_1.mask_.color = var_474_22
			end

			local var_474_24 = manager.ui.mainCamera.transform
			local var_474_25 = 0.2

			if var_474_25 < arg_471_1.time_ and arg_471_1.time_ <= var_474_25 + arg_474_0 then
				local var_474_26 = arg_471_1.var_.effectmingwangshenghun1
				local var_474_27
				local var_474_28 = var_474_24

				if not var_474_26 then
					var_474_26 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_redtwister_out"), var_474_28)
					var_474_26.name = "mingwangshenghun1"
					arg_471_1.var_.effectmingwangshenghun1 = var_474_26
				else
					var_474_26.transform:SetParent(var_474_28)
				end

				var_474_26.transform.localPosition = Vector3.New(0, 0, 0.52)
				var_474_26.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_474_29 = manager.ui.mainCamera.transform
			local var_474_30 = 5.2

			if var_474_30 < arg_471_1.time_ and arg_471_1.time_ <= var_474_30 + arg_474_0 then
				local var_474_31 = arg_471_1.var_.effectmingwangshenghun1

				if var_474_31 then
					Object.Destroy(var_474_31)

					arg_471_1.var_.effectmingwangshenghun1 = nil
				end
			end

			local var_474_32 = arg_471_1.bgs_.MS2112.transform
			local var_474_33 = 0

			if var_474_33 < arg_471_1.time_ and arg_471_1.time_ <= var_474_33 + arg_474_0 then
				arg_471_1.var_.moveOldPosMS2112 = var_474_32.localPosition
			end

			local var_474_34 = 0.1

			if var_474_33 <= arg_471_1.time_ and arg_471_1.time_ < var_474_33 + var_474_34 then
				local var_474_35 = (arg_471_1.time_ - var_474_33) / var_474_34
				local var_474_36 = Vector3.New(0, 0.1, 5)

				var_474_32.localPosition = Vector3.Lerp(arg_471_1.var_.moveOldPosMS2112, var_474_36, var_474_35)
			end

			if arg_471_1.time_ >= var_474_33 + var_474_34 and arg_471_1.time_ < var_474_33 + var_474_34 + arg_474_0 then
				var_474_32.localPosition = Vector3.New(0, 0.1, 5)
			end

			local var_474_37 = arg_471_1.bgs_.MS2112.transform
			local var_474_38 = 0.1

			if var_474_38 < arg_471_1.time_ and arg_471_1.time_ <= var_474_38 + arg_474_0 then
				arg_471_1.var_.moveOldPosMS2112 = var_474_37.localPosition
			end

			local var_474_39 = 2.9

			if var_474_38 <= arg_471_1.time_ and arg_471_1.time_ < var_474_38 + var_474_39 then
				local var_474_40 = (arg_471_1.time_ - var_474_38) / var_474_39
				local var_474_41 = Vector3.New(0, 0.1, 5.5)

				var_474_37.localPosition = Vector3.Lerp(arg_471_1.var_.moveOldPosMS2112, var_474_41, var_474_40)
			end

			if arg_471_1.time_ >= var_474_38 + var_474_39 and arg_471_1.time_ < var_474_38 + var_474_39 + arg_474_0 then
				var_474_37.localPosition = Vector3.New(0, 0.1, 5.5)
			end

			local var_474_42 = manager.ui.mainCamera.transform
			local var_474_43 = 0

			if var_474_43 < arg_471_1.time_ and arg_471_1.time_ <= var_474_43 + arg_474_0 then
				local var_474_44 = arg_471_1.var_.effectmingwangshenghun2
				local var_474_45
				local var_474_46 = var_474_42

				if not var_474_44 then
					var_474_44 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_xishan"), var_474_46)
					var_474_44.name = "mingwangshenghun2"
					arg_471_1.var_.effectmingwangshenghun2 = var_474_44
				else
					var_474_44.transform:SetParent(var_474_46)
				end

				var_474_44.transform.localPosition = Vector3.New(0, 0, -10.76)
				var_474_44.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_474_47 = arg_471_1.actors_["1111ui_story"].transform
			local var_474_48 = 0

			if var_474_48 < arg_471_1.time_ and arg_471_1.time_ <= var_474_48 + arg_474_0 then
				arg_471_1.var_.moveOldPos1111ui_story = var_474_47.localPosition
			end

			local var_474_49 = 0.001

			if var_474_48 <= arg_471_1.time_ and arg_471_1.time_ < var_474_48 + var_474_49 then
				local var_474_50 = (arg_471_1.time_ - var_474_48) / var_474_49
				local var_474_51 = Vector3.New(0, 100, 0)

				var_474_47.localPosition = Vector3.Lerp(arg_471_1.var_.moveOldPos1111ui_story, var_474_51, var_474_50)

				local var_474_52 = manager.ui.mainCamera.transform.position - var_474_47.position

				var_474_47.forward = Vector3.New(var_474_52.x, var_474_52.y, var_474_52.z)

				local var_474_53 = var_474_47.localEulerAngles

				var_474_53.z = 0
				var_474_53.x = 0
				var_474_47.localEulerAngles = var_474_53
			end

			if arg_471_1.time_ >= var_474_48 + var_474_49 and arg_471_1.time_ < var_474_48 + var_474_49 + arg_474_0 then
				var_474_47.localPosition = Vector3.New(0, 100, 0)

				local var_474_54 = manager.ui.mainCamera.transform.position - var_474_47.position

				var_474_47.forward = Vector3.New(var_474_54.x, var_474_54.y, var_474_54.z)

				local var_474_55 = var_474_47.localEulerAngles

				var_474_55.z = 0
				var_474_55.x = 0
				var_474_47.localEulerAngles = var_474_55
			end

			local var_474_56 = 0.2
			local var_474_57 = 1

			if var_474_56 < arg_471_1.time_ and arg_471_1.time_ <= var_474_56 + arg_474_0 then
				local var_474_58 = "play"
				local var_474_59 = "effect"

				arg_471_1:AudioAction(var_474_58, var_474_59, "se_story_141", "se_story_141_scythe", "")
			end

			if arg_471_1.frameCnt_ <= 1 then
				arg_471_1.dialog_:SetActive(false)
			end

			local var_474_60 = 3
			local var_474_61 = 1.225

			if var_474_60 < arg_471_1.time_ and arg_471_1.time_ <= var_474_60 + arg_474_0 then
				arg_471_1.talkMaxDuration = 0

				arg_471_1.dialog_:SetActive(true)

				arg_471_1.dialogCg_.alpha = 0

				local var_474_62 = LeanTween.value(arg_471_1.dialog_, 0, 1, 0.3)

				var_474_62:setOnUpdate(LuaHelper.FloatAction(function(arg_475_0)
					arg_471_1.dialogCg_.alpha = arg_475_0
				end))
				var_474_62:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_471_1.dialog_)
					var_474_62:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_471_1.duration_ = arg_471_1.duration_ + 0.3

				SetActive(arg_471_1.leftNameGo_, false)

				arg_471_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_471_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_471_1:RecordName(arg_471_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_471_1.iconTrs_.gameObject, false)
				arg_471_1.callingController_:SetSelectedState("normal")

				local var_474_63 = arg_471_1:GetWordFromCfg(321371112)
				local var_474_64 = arg_471_1:FormatText(var_474_63.content)

				arg_471_1.text_.text = var_474_64

				LuaForUtil.ClearLinePrefixSymbol(arg_471_1.text_)

				local var_474_65 = 49
				local var_474_66 = utf8.len(var_474_64)
				local var_474_67 = var_474_65 <= 0 and var_474_61 or var_474_61 * (var_474_66 / var_474_65)

				if var_474_67 > 0 and var_474_61 < var_474_67 then
					arg_471_1.talkMaxDuration = var_474_67
					var_474_60 = var_474_60 + 0.3

					if var_474_67 + var_474_60 > arg_471_1.duration_ then
						arg_471_1.duration_ = var_474_67 + var_474_60
					end
				end

				arg_471_1.text_.text = var_474_64
				arg_471_1.typewritter.percent = 0

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(false)
				arg_471_1:RecordContent(arg_471_1.text_.text)
			end

			local var_474_68 = var_474_60 + 0.3
			local var_474_69 = math.max(var_474_61, arg_471_1.talkMaxDuration)

			if var_474_68 <= arg_471_1.time_ and arg_471_1.time_ < var_474_68 + var_474_69 then
				arg_471_1.typewritter.percent = (arg_471_1.time_ - var_474_68) / var_474_69

				arg_471_1.typewritter:SetDirty()
			end

			if arg_471_1.time_ >= var_474_68 + var_474_69 and arg_471_1.time_ < var_474_68 + var_474_69 + arg_474_0 then
				arg_471_1.typewritter.percent = 1

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(true)
			end
		end

		arg_471_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "MS2112",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.1,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "MS2112",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2.9,
				className = "StoryMoveNode",
				startTime = 0.1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_471_1:InitPlayNodeList()
	end,
	Play321371113 = function(arg_477_0, arg_477_1)
		arg_477_1.time_ = 0
		arg_477_1.frameCnt_ = 0
		arg_477_1.state_ = "playing"
		arg_477_1.curTalkId_ = 321371113
		arg_477_1.duration_ = 5

		SetActive(arg_477_1.tipsGo_, false)

		function arg_477_1.onSingleLineFinish_()
			arg_477_1.onSingleLineUpdate_ = nil
			arg_477_1.onSingleLineFinish_ = nil
			arg_477_1.state_ = "waiting"
		end

		function arg_477_1.playNext_(arg_479_0)
			if arg_479_0 == 1 then
				arg_477_0:Play321371114(arg_477_1)
			end
		end

		function arg_477_1.onSingleLineUpdate_(arg_480_0)
			local var_480_0 = 0.05
			local var_480_1 = 1

			if var_480_0 < arg_477_1.time_ and arg_477_1.time_ <= var_480_0 + arg_480_0 then
				local var_480_2 = "play"
				local var_480_3 = "effect"

				arg_477_1:AudioAction(var_480_2, var_480_3, "se_story_141", "se_story_141_energy", "")
			end

			local var_480_4 = 0
			local var_480_5 = 0.8

			if var_480_4 < arg_477_1.time_ and arg_477_1.time_ <= var_480_4 + arg_480_0 then
				arg_477_1.talkMaxDuration = 0
				arg_477_1.dialogCg_.alpha = 1

				arg_477_1.dialog_:SetActive(true)
				SetActive(arg_477_1.leftNameGo_, false)

				arg_477_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_477_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_477_1:RecordName(arg_477_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_477_1.iconTrs_.gameObject, false)
				arg_477_1.callingController_:SetSelectedState("normal")

				local var_480_6 = arg_477_1:GetWordFromCfg(321371113)
				local var_480_7 = arg_477_1:FormatText(var_480_6.content)

				arg_477_1.text_.text = var_480_7

				LuaForUtil.ClearLinePrefixSymbol(arg_477_1.text_)

				local var_480_8 = 32
				local var_480_9 = utf8.len(var_480_7)
				local var_480_10 = var_480_8 <= 0 and var_480_5 or var_480_5 * (var_480_9 / var_480_8)

				if var_480_10 > 0 and var_480_5 < var_480_10 then
					arg_477_1.talkMaxDuration = var_480_10

					if var_480_10 + var_480_4 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_10 + var_480_4
					end
				end

				arg_477_1.text_.text = var_480_7
				arg_477_1.typewritter.percent = 0

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(false)
				arg_477_1:RecordContent(arg_477_1.text_.text)
			end

			local var_480_11 = math.max(var_480_5, arg_477_1.talkMaxDuration)

			if var_480_4 <= arg_477_1.time_ and arg_477_1.time_ < var_480_4 + var_480_11 then
				arg_477_1.typewritter.percent = (arg_477_1.time_ - var_480_4) / var_480_11

				arg_477_1.typewritter:SetDirty()
			end

			if arg_477_1.time_ >= var_480_4 + var_480_11 and arg_477_1.time_ < var_480_4 + var_480_11 + arg_480_0 then
				arg_477_1.typewritter.percent = 1

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(true)
			end
		end

		arg_477_1.nodeConfigList_ = {}

		arg_477_1:InitPlayNodeList()
	end,
	Play321371114 = function(arg_481_0, arg_481_1)
		arg_481_1.time_ = 0
		arg_481_1.frameCnt_ = 0
		arg_481_1.state_ = "playing"
		arg_481_1.curTalkId_ = 321371114
		arg_481_1.duration_ = 5

		SetActive(arg_481_1.tipsGo_, false)

		function arg_481_1.onSingleLineFinish_()
			arg_481_1.onSingleLineUpdate_ = nil
			arg_481_1.onSingleLineFinish_ = nil
			arg_481_1.state_ = "waiting"
		end

		function arg_481_1.playNext_(arg_483_0)
			if arg_483_0 == 1 then
				arg_481_0:Play321371115(arg_481_1)
			end
		end

		function arg_481_1.onSingleLineUpdate_(arg_484_0)
			local var_484_0 = 0
			local var_484_1 = 0.975

			if var_484_0 < arg_481_1.time_ and arg_481_1.time_ <= var_484_0 + arg_484_0 then
				arg_481_1.talkMaxDuration = 0
				arg_481_1.dialogCg_.alpha = 1

				arg_481_1.dialog_:SetActive(true)
				SetActive(arg_481_1.leftNameGo_, false)

				arg_481_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_481_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_481_1:RecordName(arg_481_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_481_1.iconTrs_.gameObject, false)
				arg_481_1.callingController_:SetSelectedState("normal")

				local var_484_2 = arg_481_1:GetWordFromCfg(321371114)
				local var_484_3 = arg_481_1:FormatText(var_484_2.content)

				arg_481_1.text_.text = var_484_3

				LuaForUtil.ClearLinePrefixSymbol(arg_481_1.text_)

				local var_484_4 = 39
				local var_484_5 = utf8.len(var_484_3)
				local var_484_6 = var_484_4 <= 0 and var_484_1 or var_484_1 * (var_484_5 / var_484_4)

				if var_484_6 > 0 and var_484_1 < var_484_6 then
					arg_481_1.talkMaxDuration = var_484_6

					if var_484_6 + var_484_0 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_6 + var_484_0
					end
				end

				arg_481_1.text_.text = var_484_3
				arg_481_1.typewritter.percent = 0

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(false)
				arg_481_1:RecordContent(arg_481_1.text_.text)
			end

			local var_484_7 = math.max(var_484_1, arg_481_1.talkMaxDuration)

			if var_484_0 <= arg_481_1.time_ and arg_481_1.time_ < var_484_0 + var_484_7 then
				arg_481_1.typewritter.percent = (arg_481_1.time_ - var_484_0) / var_484_7

				arg_481_1.typewritter:SetDirty()
			end

			if arg_481_1.time_ >= var_484_0 + var_484_7 and arg_481_1.time_ < var_484_0 + var_484_7 + arg_484_0 then
				arg_481_1.typewritter.percent = 1

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(true)
			end
		end

		arg_481_1.nodeConfigList_ = {}

		arg_481_1:InitPlayNodeList()
	end,
	Play321371115 = function(arg_485_0, arg_485_1)
		arg_485_1.time_ = 0
		arg_485_1.frameCnt_ = 0
		arg_485_1.state_ = "playing"
		arg_485_1.curTalkId_ = 321371115
		arg_485_1.duration_ = 10.37

		local var_485_0 = {
			zh = 10.366,
			ja = 6.9
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
				arg_485_0:Play321371116(arg_485_1)
			end
		end

		function arg_485_1.onSingleLineUpdate_(arg_488_0)
			local var_488_0 = arg_485_1.actors_["1111ui_story"]
			local var_488_1 = 0

			if var_488_1 < arg_485_1.time_ and arg_485_1.time_ <= var_488_1 + arg_488_0 and not isNil(var_488_0) and arg_485_1.var_.characterEffect1111ui_story == nil then
				arg_485_1.var_.characterEffect1111ui_story = var_488_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_488_2 = 0.200000002980232

			if var_488_1 <= arg_485_1.time_ and arg_485_1.time_ < var_488_1 + var_488_2 and not isNil(var_488_0) then
				local var_488_3 = (arg_485_1.time_ - var_488_1) / var_488_2

				if arg_485_1.var_.characterEffect1111ui_story and not isNil(var_488_0) then
					arg_485_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_485_1.time_ >= var_488_1 + var_488_2 and arg_485_1.time_ < var_488_1 + var_488_2 + arg_488_0 and not isNil(var_488_0) and arg_485_1.var_.characterEffect1111ui_story then
				arg_485_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_488_4 = 0
			local var_488_5 = 0.85

			if var_488_4 < arg_485_1.time_ and arg_485_1.time_ <= var_488_4 + arg_488_0 then
				arg_485_1.talkMaxDuration = 0
				arg_485_1.dialogCg_.alpha = 1

				arg_485_1.dialog_:SetActive(true)
				SetActive(arg_485_1.leftNameGo_, true)

				local var_488_6 = arg_485_1:FormatText(StoryNameCfg[67].name)

				arg_485_1.leftNameTxt_.text = var_488_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_485_1.leftNameTxt_.transform)

				arg_485_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_485_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_485_1:RecordName(arg_485_1.leftNameTxt_.text)
				SetActive(arg_485_1.iconTrs_.gameObject, false)
				arg_485_1.callingController_:SetSelectedState("normal")

				local var_488_7 = arg_485_1:GetWordFromCfg(321371115)
				local var_488_8 = arg_485_1:FormatText(var_488_7.content)

				arg_485_1.text_.text = var_488_8

				LuaForUtil.ClearLinePrefixSymbol(arg_485_1.text_)

				local var_488_9 = 34
				local var_488_10 = utf8.len(var_488_8)
				local var_488_11 = var_488_9 <= 0 and var_488_5 or var_488_5 * (var_488_10 / var_488_9)

				if var_488_11 > 0 and var_488_5 < var_488_11 then
					arg_485_1.talkMaxDuration = var_488_11

					if var_488_11 + var_488_4 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_11 + var_488_4
					end
				end

				arg_485_1.text_.text = var_488_8
				arg_485_1.typewritter.percent = 0

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371115", "story_v_out_321371.awb") ~= 0 then
					local var_488_12 = manager.audio:GetVoiceLength("story_v_out_321371", "321371115", "story_v_out_321371.awb") / 1000

					if var_488_12 + var_488_4 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_12 + var_488_4
					end

					if var_488_7.prefab_name ~= "" and arg_485_1.actors_[var_488_7.prefab_name] ~= nil then
						local var_488_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_485_1.actors_[var_488_7.prefab_name].transform, "story_v_out_321371", "321371115", "story_v_out_321371.awb")

						arg_485_1:RecordAudio("321371115", var_488_13)
						arg_485_1:RecordAudio("321371115", var_488_13)
					else
						arg_485_1:AudioAction("play", "voice", "story_v_out_321371", "321371115", "story_v_out_321371.awb")
					end

					arg_485_1:RecordHistoryTalkVoice("story_v_out_321371", "321371115", "story_v_out_321371.awb")
				end

				arg_485_1:RecordContent(arg_485_1.text_.text)
			end

			local var_488_14 = math.max(var_488_5, arg_485_1.talkMaxDuration)

			if var_488_4 <= arg_485_1.time_ and arg_485_1.time_ < var_488_4 + var_488_14 then
				arg_485_1.typewritter.percent = (arg_485_1.time_ - var_488_4) / var_488_14

				arg_485_1.typewritter:SetDirty()
			end

			if arg_485_1.time_ >= var_488_4 + var_488_14 and arg_485_1.time_ < var_488_4 + var_488_14 + arg_488_0 then
				arg_485_1.typewritter.percent = 1

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(true)
			end
		end

		arg_485_1.nodeConfigList_ = {}

		arg_485_1:InitPlayNodeList()
	end,
	Play321371116 = function(arg_489_0, arg_489_1)
		arg_489_1.time_ = 0
		arg_489_1.frameCnt_ = 0
		arg_489_1.state_ = "playing"
		arg_489_1.curTalkId_ = 321371116
		arg_489_1.duration_ = 7.03

		local var_489_0 = {
			zh = 7.033,
			ja = 6.066
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
				arg_489_0:Play321371117(arg_489_1)
			end
		end

		function arg_489_1.onSingleLineUpdate_(arg_492_0)
			local var_492_0 = 0
			local var_492_1 = 0.675

			if var_492_0 < arg_489_1.time_ and arg_489_1.time_ <= var_492_0 + arg_492_0 then
				arg_489_1.talkMaxDuration = 0
				arg_489_1.dialogCg_.alpha = 1

				arg_489_1.dialog_:SetActive(true)
				SetActive(arg_489_1.leftNameGo_, true)

				local var_492_2 = arg_489_1:FormatText(StoryNameCfg[67].name)

				arg_489_1.leftNameTxt_.text = var_492_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_489_1.leftNameTxt_.transform)

				arg_489_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_489_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_489_1:RecordName(arg_489_1.leftNameTxt_.text)
				SetActive(arg_489_1.iconTrs_.gameObject, false)
				arg_489_1.callingController_:SetSelectedState("normal")

				local var_492_3 = arg_489_1:GetWordFromCfg(321371116)
				local var_492_4 = arg_489_1:FormatText(var_492_3.content)

				arg_489_1.text_.text = var_492_4

				LuaForUtil.ClearLinePrefixSymbol(arg_489_1.text_)

				local var_492_5 = 27
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

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371116", "story_v_out_321371.awb") ~= 0 then
					local var_492_8 = manager.audio:GetVoiceLength("story_v_out_321371", "321371116", "story_v_out_321371.awb") / 1000

					if var_492_8 + var_492_0 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_8 + var_492_0
					end

					if var_492_3.prefab_name ~= "" and arg_489_1.actors_[var_492_3.prefab_name] ~= nil then
						local var_492_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_489_1.actors_[var_492_3.prefab_name].transform, "story_v_out_321371", "321371116", "story_v_out_321371.awb")

						arg_489_1:RecordAudio("321371116", var_492_9)
						arg_489_1:RecordAudio("321371116", var_492_9)
					else
						arg_489_1:AudioAction("play", "voice", "story_v_out_321371", "321371116", "story_v_out_321371.awb")
					end

					arg_489_1:RecordHistoryTalkVoice("story_v_out_321371", "321371116", "story_v_out_321371.awb")
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
	Play321371117 = function(arg_493_0, arg_493_1)
		arg_493_1.time_ = 0
		arg_493_1.frameCnt_ = 0
		arg_493_1.state_ = "playing"
		arg_493_1.curTalkId_ = 321371117
		arg_493_1.duration_ = 7.5

		SetActive(arg_493_1.tipsGo_, false)

		function arg_493_1.onSingleLineFinish_()
			arg_493_1.onSingleLineUpdate_ = nil
			arg_493_1.onSingleLineFinish_ = nil
			arg_493_1.state_ = "waiting"
		end

		function arg_493_1.playNext_(arg_495_0)
			if arg_495_0 == 1 then
				arg_493_0:Play321371118(arg_493_1)
			end
		end

		function arg_493_1.onSingleLineUpdate_(arg_496_0)
			local var_496_0 = arg_493_1.bgs_.MS2112.transform
			local var_496_1 = 0.5

			if var_496_1 < arg_493_1.time_ and arg_493_1.time_ <= var_496_1 + arg_496_0 then
				arg_493_1.var_.moveOldPosMS2112 = var_496_0.localPosition
			end

			local var_496_2 = 0.001

			if var_496_1 <= arg_493_1.time_ and arg_493_1.time_ < var_496_1 + var_496_2 then
				local var_496_3 = (arg_493_1.time_ - var_496_1) / var_496_2
				local var_496_4 = Vector3.New(0, 1, 9.5)

				var_496_0.localPosition = Vector3.Lerp(arg_493_1.var_.moveOldPosMS2112, var_496_4, var_496_3)
			end

			if arg_493_1.time_ >= var_496_1 + var_496_2 and arg_493_1.time_ < var_496_1 + var_496_2 + arg_496_0 then
				var_496_0.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_496_5 = arg_493_1.bgs_.MS2112.transform
			local var_496_6 = 0.516666666666667

			if var_496_6 < arg_493_1.time_ and arg_493_1.time_ <= var_496_6 + arg_496_0 then
				arg_493_1.var_.moveOldPosMS2112 = var_496_5.localPosition
			end

			local var_496_7 = 1.98333333333333

			if var_496_6 <= arg_493_1.time_ and arg_493_1.time_ < var_496_6 + var_496_7 then
				local var_496_8 = (arg_493_1.time_ - var_496_6) / var_496_7
				local var_496_9 = Vector3.New(0, 1, 10)

				var_496_5.localPosition = Vector3.Lerp(arg_493_1.var_.moveOldPosMS2112, var_496_9, var_496_8)
			end

			if arg_493_1.time_ >= var_496_6 + var_496_7 and arg_493_1.time_ < var_496_6 + var_496_7 + arg_496_0 then
				var_496_5.localPosition = Vector3.New(0, 1, 10)
			end

			local var_496_10 = 0

			if var_496_10 < arg_493_1.time_ and arg_493_1.time_ <= var_496_10 + arg_496_0 then
				arg_493_1.allBtn_.enabled = false
			end

			local var_496_11 = 2.5

			if arg_493_1.time_ >= var_496_10 + var_496_11 and arg_493_1.time_ < var_496_10 + var_496_11 + arg_496_0 then
				arg_493_1.allBtn_.enabled = true
			end

			local var_496_12 = 0

			if var_496_12 < arg_493_1.time_ and arg_493_1.time_ <= var_496_12 + arg_496_0 then
				arg_493_1.mask_.enabled = true
				arg_493_1.mask_.raycastTarget = true

				arg_493_1:SetGaussion(false)
			end

			local var_496_13 = 0.5

			if var_496_12 <= arg_493_1.time_ and arg_493_1.time_ < var_496_12 + var_496_13 then
				local var_496_14 = (arg_493_1.time_ - var_496_12) / var_496_13
				local var_496_15 = Color.New(0, 0, 0)

				var_496_15.a = Mathf.Lerp(0, 1, var_496_14)
				arg_493_1.mask_.color = var_496_15
			end

			if arg_493_1.time_ >= var_496_12 + var_496_13 and arg_493_1.time_ < var_496_12 + var_496_13 + arg_496_0 then
				local var_496_16 = Color.New(0, 0, 0)

				var_496_16.a = 1
				arg_493_1.mask_.color = var_496_16
			end

			local var_496_17 = 0.5

			if var_496_17 < arg_493_1.time_ and arg_493_1.time_ <= var_496_17 + arg_496_0 then
				arg_493_1.mask_.enabled = true
				arg_493_1.mask_.raycastTarget = true

				arg_493_1:SetGaussion(false)
			end

			local var_496_18 = 0.5999999

			if var_496_17 <= arg_493_1.time_ and arg_493_1.time_ < var_496_17 + var_496_18 then
				local var_496_19 = (arg_493_1.time_ - var_496_17) / var_496_18
				local var_496_20 = Color.New(0, 0, 0)

				var_496_20.a = Mathf.Lerp(1, 0, var_496_19)
				arg_493_1.mask_.color = var_496_20
			end

			if arg_493_1.time_ >= var_496_17 + var_496_18 and arg_493_1.time_ < var_496_17 + var_496_18 + arg_496_0 then
				local var_496_21 = Color.New(0, 0, 0)
				local var_496_22 = 0

				arg_493_1.mask_.enabled = false
				var_496_21.a = var_496_22
				arg_493_1.mask_.color = var_496_21
			end

			local var_496_23 = 3
			local var_496_24 = 1

			if var_496_23 < arg_493_1.time_ and arg_493_1.time_ <= var_496_23 + arg_496_0 then
				local var_496_25 = "play"
				local var_496_26 = "effect"

				arg_493_1:AudioAction(var_496_25, var_496_26, "se_story_141", "se_story_141_sword wing01", "")
			end

			local var_496_27 = 2.5
			local var_496_28 = 1

			if var_496_27 < arg_493_1.time_ and arg_493_1.time_ <= var_496_27 + arg_496_0 then
				arg_493_1.talkMaxDuration = 0
				arg_493_1.dialogCg_.alpha = 1

				arg_493_1.dialog_:SetActive(true)
				SetActive(arg_493_1.leftNameGo_, false)

				arg_493_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_493_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_493_1:RecordName(arg_493_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_493_1.iconTrs_.gameObject, false)
				arg_493_1.callingController_:SetSelectedState("normal")

				local var_496_29 = arg_493_1:GetWordFromCfg(321371117)
				local var_496_30 = arg_493_1:FormatText(var_496_29.content)

				arg_493_1.text_.text = var_496_30

				LuaForUtil.ClearLinePrefixSymbol(arg_493_1.text_)

				local var_496_31 = 40
				local var_496_32 = utf8.len(var_496_30)
				local var_496_33 = var_496_31 <= 0 and var_496_28 or var_496_28 * (var_496_32 / var_496_31)

				if var_496_33 > 0 and var_496_28 < var_496_33 then
					arg_493_1.talkMaxDuration = var_496_33

					if var_496_33 + var_496_27 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_33 + var_496_27
					end
				end

				arg_493_1.text_.text = var_496_30
				arg_493_1.typewritter.percent = 0

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(false)
				arg_493_1:RecordContent(arg_493_1.text_.text)
			end

			local var_496_34 = math.max(var_496_28, arg_493_1.talkMaxDuration)

			if var_496_27 <= arg_493_1.time_ and arg_493_1.time_ < var_496_27 + var_496_34 then
				arg_493_1.typewritter.percent = (arg_493_1.time_ - var_496_27) / var_496_34

				arg_493_1.typewritter:SetDirty()
			end

			if arg_493_1.time_ >= var_496_27 + var_496_34 and arg_493_1.time_ < var_496_27 + var_496_34 + arg_496_0 then
				arg_493_1.typewritter.percent = 1

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(true)
			end
		end

		arg_493_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "MS2112",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "MS2112",
				changeDisplayLayer = false,
				needEase = false,
				duration = 1.98333333333333,
				className = "StoryMoveNode",
				startTime = 0.516666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_493_1:InitPlayNodeList()
	end,
	Play321371118 = function(arg_497_0, arg_497_1)
		arg_497_1.time_ = 0
		arg_497_1.frameCnt_ = 0
		arg_497_1.state_ = "playing"
		arg_497_1.curTalkId_ = 321371118
		arg_497_1.duration_ = 5

		SetActive(arg_497_1.tipsGo_, false)

		function arg_497_1.onSingleLineFinish_()
			arg_497_1.onSingleLineUpdate_ = nil
			arg_497_1.onSingleLineFinish_ = nil
			arg_497_1.state_ = "waiting"
		end

		function arg_497_1.playNext_(arg_499_0)
			if arg_499_0 == 1 then
				arg_497_0:Play321371119(arg_497_1)
			end
		end

		function arg_497_1.onSingleLineUpdate_(arg_500_0)
			local var_500_0 = 0.166666666666667
			local var_500_1 = 1

			if var_500_0 < arg_497_1.time_ and arg_497_1.time_ <= var_500_0 + arg_500_0 then
				local var_500_2 = "play"
				local var_500_3 = "effect"

				arg_497_1:AudioAction(var_500_2, var_500_3, "se_story_141", "se_story_141_sword wing02", "")
			end

			local var_500_4 = 0
			local var_500_5 = 1.625

			if var_500_4 < arg_497_1.time_ and arg_497_1.time_ <= var_500_4 + arg_500_0 then
				arg_497_1.talkMaxDuration = 0
				arg_497_1.dialogCg_.alpha = 1

				arg_497_1.dialog_:SetActive(true)
				SetActive(arg_497_1.leftNameGo_, false)

				arg_497_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_497_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_497_1:RecordName(arg_497_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_497_1.iconTrs_.gameObject, false)
				arg_497_1.callingController_:SetSelectedState("normal")

				local var_500_6 = arg_497_1:GetWordFromCfg(321371118)
				local var_500_7 = arg_497_1:FormatText(var_500_6.content)

				arg_497_1.text_.text = var_500_7

				LuaForUtil.ClearLinePrefixSymbol(arg_497_1.text_)

				local var_500_8 = 65
				local var_500_9 = utf8.len(var_500_7)
				local var_500_10 = var_500_8 <= 0 and var_500_5 or var_500_5 * (var_500_9 / var_500_8)

				if var_500_10 > 0 and var_500_5 < var_500_10 then
					arg_497_1.talkMaxDuration = var_500_10

					if var_500_10 + var_500_4 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_10 + var_500_4
					end
				end

				arg_497_1.text_.text = var_500_7
				arg_497_1.typewritter.percent = 0

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(false)
				arg_497_1:RecordContent(arg_497_1.text_.text)
			end

			local var_500_11 = math.max(var_500_5, arg_497_1.talkMaxDuration)

			if var_500_4 <= arg_497_1.time_ and arg_497_1.time_ < var_500_4 + var_500_11 then
				arg_497_1.typewritter.percent = (arg_497_1.time_ - var_500_4) / var_500_11

				arg_497_1.typewritter:SetDirty()
			end

			if arg_497_1.time_ >= var_500_4 + var_500_11 and arg_497_1.time_ < var_500_4 + var_500_11 + arg_500_0 then
				arg_497_1.typewritter.percent = 1

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(true)
			end
		end

		arg_497_1.nodeConfigList_ = {}

		arg_497_1:InitPlayNodeList()
	end,
	Play321371119 = function(arg_501_0, arg_501_1)
		arg_501_1.time_ = 0
		arg_501_1.frameCnt_ = 0
		arg_501_1.state_ = "playing"
		arg_501_1.curTalkId_ = 321371119
		arg_501_1.duration_ = 6.8

		SetActive(arg_501_1.tipsGo_, false)

		function arg_501_1.onSingleLineFinish_()
			arg_501_1.onSingleLineUpdate_ = nil
			arg_501_1.onSingleLineFinish_ = nil
			arg_501_1.state_ = "waiting"
		end

		function arg_501_1.playNext_(arg_503_0)
			if arg_503_0 == 1 then
				arg_501_0:Play321371120(arg_501_1)
			end
		end

		function arg_501_1.onSingleLineUpdate_(arg_504_0)
			local var_504_0 = arg_501_1.bgs_.MS2112.transform
			local var_504_1 = 0.1

			if var_504_1 < arg_501_1.time_ and arg_501_1.time_ <= var_504_1 + arg_504_0 then
				arg_501_1.var_.moveOldPosMS2112 = var_504_0.localPosition
			end

			local var_504_2 = 0.001

			if var_504_1 <= arg_501_1.time_ and arg_501_1.time_ < var_504_1 + var_504_2 then
				local var_504_3 = (arg_501_1.time_ - var_504_1) / var_504_2
				local var_504_4 = Vector3.New(0, 1, 6)

				var_504_0.localPosition = Vector3.Lerp(arg_501_1.var_.moveOldPosMS2112, var_504_4, var_504_3)
			end

			if arg_501_1.time_ >= var_504_1 + var_504_2 and arg_501_1.time_ < var_504_1 + var_504_2 + arg_504_0 then
				var_504_0.localPosition = Vector3.New(0, 1, 6)
			end

			local var_504_5 = arg_501_1.bgs_.MS2112.transform
			local var_504_6 = 0.134

			if var_504_6 < arg_501_1.time_ and arg_501_1.time_ <= var_504_6 + arg_504_0 then
				arg_501_1.var_.moveOldPosMS2112 = var_504_5.localPosition
			end

			local var_504_7 = 2.39933333333333

			if var_504_6 <= arg_501_1.time_ and arg_501_1.time_ < var_504_6 + var_504_7 then
				local var_504_8 = (arg_501_1.time_ - var_504_6) / var_504_7
				local var_504_9 = Vector3.New(0, 0.55, 6)

				var_504_5.localPosition = Vector3.Lerp(arg_501_1.var_.moveOldPosMS2112, var_504_9, var_504_8)
			end

			if arg_501_1.time_ >= var_504_6 + var_504_7 and arg_501_1.time_ < var_504_6 + var_504_7 + arg_504_0 then
				var_504_5.localPosition = Vector3.New(0, 0.55, 6)
			end

			local var_504_10 = 0

			if var_504_10 < arg_501_1.time_ and arg_501_1.time_ <= var_504_10 + arg_504_0 then
				arg_501_1.allBtn_.enabled = false
			end

			local var_504_11 = 2.13333333333333

			if arg_501_1.time_ >= var_504_10 + var_504_11 and arg_501_1.time_ < var_504_10 + var_504_11 + arg_504_0 then
				arg_501_1.allBtn_.enabled = true
			end

			local var_504_12 = manager.ui.mainCamera.transform
			local var_504_13 = 0

			if var_504_13 < arg_501_1.time_ and arg_501_1.time_ <= var_504_13 + arg_504_0 then
				arg_501_1.var_.shakeOldPos = var_504_12.localPosition
			end

			local var_504_14 = 1.1

			if var_504_13 <= arg_501_1.time_ and arg_501_1.time_ < var_504_13 + var_504_14 then
				local var_504_15 = (arg_501_1.time_ - var_504_13) / 0.066
				local var_504_16, var_504_17 = math.modf(var_504_15)

				var_504_12.localPosition = Vector3.New(var_504_17 * 0.13, var_504_17 * 0.13, var_504_17 * 0.13) + arg_501_1.var_.shakeOldPos
			end

			if arg_501_1.time_ >= var_504_13 + var_504_14 and arg_501_1.time_ < var_504_13 + var_504_14 + arg_504_0 then
				var_504_12.localPosition = arg_501_1.var_.shakeOldPos
			end

			local var_504_18 = manager.ui.mainCamera.transform
			local var_504_19 = 0

			if var_504_19 < arg_501_1.time_ and arg_501_1.time_ <= var_504_19 + arg_504_0 then
				local var_504_20 = arg_501_1.var_.effect8851
				local var_504_21
				local var_504_22 = var_504_18

				if not var_504_20 then
					var_504_20 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_suduxian01_in_keep"), var_504_22)
					var_504_20.name = "8851"
					arg_501_1.var_.effect8851 = var_504_20
				else
					var_504_20.transform:SetParent(var_504_22)
				end

				var_504_20.transform.localPosition = Vector3.New(0.06, 0, -5.86)
				var_504_20.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_504_23 = manager.ui.mainCameraCom_
				local var_504_24 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_504_23.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_504_25 = var_504_20.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_504_26 = 15
				local var_504_27 = 2 * var_504_26 * Mathf.Tan(var_504_23.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_504_23.aspect
				local var_504_28 = 1
				local var_504_29 = 1.7777777777777777

				if var_504_29 < var_504_23.aspect then
					var_504_28 = var_504_27 / (2 * var_504_26 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_504_29)
				end

				for iter_504_0, iter_504_1 in ipairs(var_504_25) do
					local var_504_30 = iter_504_1.transform.localScale

					iter_504_1.transform.localScale = Vector3.New(var_504_30.x / var_504_24 * var_504_28, var_504_30.y / var_504_24, var_504_30.z)
				end
			end

			local var_504_31 = manager.ui.mainCamera.transform
			local var_504_32 = 0

			if var_504_32 < arg_501_1.time_ and arg_501_1.time_ <= var_504_32 + arg_504_0 then
				local var_504_33 = arg_501_1.var_.effectmingwangshenghun2

				if var_504_33 then
					Object.Destroy(var_504_33)

					arg_501_1.var_.effectmingwangshenghun2 = nil
				end
			end

			local var_504_34 = 0

			if var_504_34 < arg_501_1.time_ and arg_501_1.time_ <= var_504_34 + arg_504_0 then
				arg_501_1.mask_.enabled = true
				arg_501_1.mask_.raycastTarget = true

				arg_501_1:SetGaussion(false)
			end

			local var_504_35 = 0.1

			if var_504_34 <= arg_501_1.time_ and arg_501_1.time_ < var_504_34 + var_504_35 then
				local var_504_36 = (arg_501_1.time_ - var_504_34) / var_504_35
				local var_504_37 = Color.New(1, 1, 1)

				var_504_37.a = Mathf.Lerp(0, 1, var_504_36)
				arg_501_1.mask_.color = var_504_37
			end

			if arg_501_1.time_ >= var_504_34 + var_504_35 and arg_501_1.time_ < var_504_34 + var_504_35 + arg_504_0 then
				local var_504_38 = Color.New(1, 1, 1)

				var_504_38.a = 1
				arg_501_1.mask_.color = var_504_38
			end

			local var_504_39 = 0.1

			if var_504_39 < arg_501_1.time_ and arg_501_1.time_ <= var_504_39 + arg_504_0 then
				arg_501_1.mask_.enabled = true
				arg_501_1.mask_.raycastTarget = true

				arg_501_1:SetGaussion(false)
			end

			local var_504_40 = 0.2

			if var_504_39 <= arg_501_1.time_ and arg_501_1.time_ < var_504_39 + var_504_40 then
				local var_504_41 = (arg_501_1.time_ - var_504_39) / var_504_40
				local var_504_42 = Color.New(1, 1, 1)

				var_504_42.a = Mathf.Lerp(1, 0, var_504_41)
				arg_501_1.mask_.color = var_504_42
			end

			if arg_501_1.time_ >= var_504_39 + var_504_40 and arg_501_1.time_ < var_504_39 + var_504_40 + arg_504_0 then
				local var_504_43 = Color.New(1, 1, 1)
				local var_504_44 = 0

				arg_501_1.mask_.enabled = false
				var_504_43.a = var_504_44
				arg_501_1.mask_.color = var_504_43
			end

			local var_504_45 = 0
			local var_504_46 = 1

			if var_504_45 < arg_501_1.time_ and arg_501_1.time_ <= var_504_45 + arg_504_0 then
				local var_504_47 = "play"
				local var_504_48 = "effect"

				arg_501_1:AudioAction(var_504_47, var_504_48, "se_story_141", "se_story_141_ring", "")
			end

			if arg_501_1.frameCnt_ <= 1 then
				arg_501_1.dialog_:SetActive(false)
			end

			local var_504_49 = 1.8
			local var_504_50 = 1.35

			if var_504_49 < arg_501_1.time_ and arg_501_1.time_ <= var_504_49 + arg_504_0 then
				arg_501_1.talkMaxDuration = 0

				arg_501_1.dialog_:SetActive(true)

				arg_501_1.dialogCg_.alpha = 0

				local var_504_51 = LeanTween.value(arg_501_1.dialog_, 0, 1, 0.3)

				var_504_51:setOnUpdate(LuaHelper.FloatAction(function(arg_505_0)
					arg_501_1.dialogCg_.alpha = arg_505_0
				end))
				var_504_51:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_501_1.dialog_)
					var_504_51:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_501_1.duration_ = arg_501_1.duration_ + 0.3

				SetActive(arg_501_1.leftNameGo_, false)

				arg_501_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_501_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_501_1:RecordName(arg_501_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_501_1.iconTrs_.gameObject, false)
				arg_501_1.callingController_:SetSelectedState("normal")

				local var_504_52 = arg_501_1:GetWordFromCfg(321371119)
				local var_504_53 = arg_501_1:FormatText(var_504_52.content)

				arg_501_1.text_.text = var_504_53

				LuaForUtil.ClearLinePrefixSymbol(arg_501_1.text_)

				local var_504_54 = 54
				local var_504_55 = utf8.len(var_504_53)
				local var_504_56 = var_504_54 <= 0 and var_504_50 or var_504_50 * (var_504_55 / var_504_54)

				if var_504_56 > 0 and var_504_50 < var_504_56 then
					arg_501_1.talkMaxDuration = var_504_56
					var_504_49 = var_504_49 + 0.3

					if var_504_56 + var_504_49 > arg_501_1.duration_ then
						arg_501_1.duration_ = var_504_56 + var_504_49
					end
				end

				arg_501_1.text_.text = var_504_53
				arg_501_1.typewritter.percent = 0

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(false)
				arg_501_1:RecordContent(arg_501_1.text_.text)
			end

			local var_504_57 = var_504_49 + 0.3
			local var_504_58 = math.max(var_504_50, arg_501_1.talkMaxDuration)

			if var_504_57 <= arg_501_1.time_ and arg_501_1.time_ < var_504_57 + var_504_58 then
				arg_501_1.typewritter.percent = (arg_501_1.time_ - var_504_57) / var_504_58

				arg_501_1.typewritter:SetDirty()
			end

			if arg_501_1.time_ >= var_504_57 + var_504_58 and arg_501_1.time_ < var_504_57 + var_504_58 + arg_504_0 then
				arg_501_1.typewritter.percent = 1

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(true)
			end
		end

		arg_501_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "MS2112",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "MS2112",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2.39933333333333,
				className = "StoryMoveNode",
				startTime = 0.134,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_501_1:InitPlayNodeList()
	end,
	Play321371120 = function(arg_507_0, arg_507_1)
		arg_507_1.time_ = 0
		arg_507_1.frameCnt_ = 0
		arg_507_1.state_ = "playing"
		arg_507_1.curTalkId_ = 321371120
		arg_507_1.duration_ = 5

		SetActive(arg_507_1.tipsGo_, false)

		function arg_507_1.onSingleLineFinish_()
			arg_507_1.onSingleLineUpdate_ = nil
			arg_507_1.onSingleLineFinish_ = nil
			arg_507_1.state_ = "waiting"
		end

		function arg_507_1.playNext_(arg_509_0)
			if arg_509_0 == 1 then
				arg_507_0:Play321371121(arg_507_1)
			end
		end

		function arg_507_1.onSingleLineUpdate_(arg_510_0)
			local var_510_0 = 0
			local var_510_1 = 1.25

			if var_510_0 < arg_507_1.time_ and arg_507_1.time_ <= var_510_0 + arg_510_0 then
				arg_507_1.talkMaxDuration = 0
				arg_507_1.dialogCg_.alpha = 1

				arg_507_1.dialog_:SetActive(true)
				SetActive(arg_507_1.leftNameGo_, false)

				arg_507_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_507_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_507_1:RecordName(arg_507_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_507_1.iconTrs_.gameObject, false)
				arg_507_1.callingController_:SetSelectedState("normal")

				local var_510_2 = arg_507_1:GetWordFromCfg(321371120)
				local var_510_3 = arg_507_1:FormatText(var_510_2.content)

				arg_507_1.text_.text = var_510_3

				LuaForUtil.ClearLinePrefixSymbol(arg_507_1.text_)

				local var_510_4 = 50
				local var_510_5 = utf8.len(var_510_3)
				local var_510_6 = var_510_4 <= 0 and var_510_1 or var_510_1 * (var_510_5 / var_510_4)

				if var_510_6 > 0 and var_510_1 < var_510_6 then
					arg_507_1.talkMaxDuration = var_510_6

					if var_510_6 + var_510_0 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_6 + var_510_0
					end
				end

				arg_507_1.text_.text = var_510_3
				arg_507_1.typewritter.percent = 0

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(false)
				arg_507_1:RecordContent(arg_507_1.text_.text)
			end

			local var_510_7 = math.max(var_510_1, arg_507_1.talkMaxDuration)

			if var_510_0 <= arg_507_1.time_ and arg_507_1.time_ < var_510_0 + var_510_7 then
				arg_507_1.typewritter.percent = (arg_507_1.time_ - var_510_0) / var_510_7

				arg_507_1.typewritter:SetDirty()
			end

			if arg_507_1.time_ >= var_510_0 + var_510_7 and arg_507_1.time_ < var_510_0 + var_510_7 + arg_510_0 then
				arg_507_1.typewritter.percent = 1

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(true)
			end
		end

		arg_507_1.nodeConfigList_ = {}

		arg_507_1:InitPlayNodeList()
	end,
	Play321371121 = function(arg_511_0, arg_511_1)
		arg_511_1.time_ = 0
		arg_511_1.frameCnt_ = 0
		arg_511_1.state_ = "playing"
		arg_511_1.curTalkId_ = 321371121
		arg_511_1.duration_ = 5.77

		local var_511_0 = {
			zh = 4.333,
			ja = 5.766
		}
		local var_511_1 = manager.audio:GetLocalizationFlag()

		if var_511_0[var_511_1] ~= nil then
			arg_511_1.duration_ = var_511_0[var_511_1]
		end

		SetActive(arg_511_1.tipsGo_, false)

		function arg_511_1.onSingleLineFinish_()
			arg_511_1.onSingleLineUpdate_ = nil
			arg_511_1.onSingleLineFinish_ = nil
			arg_511_1.state_ = "waiting"
		end

		function arg_511_1.playNext_(arg_513_0)
			if arg_513_0 == 1 then
				arg_511_0:Play321371122(arg_511_1)
			end
		end

		function arg_511_1.onSingleLineUpdate_(arg_514_0)
			local var_514_0 = arg_511_1.actors_["1111ui_story"]
			local var_514_1 = 0

			if var_514_1 < arg_511_1.time_ and arg_511_1.time_ <= var_514_1 + arg_514_0 and not isNil(var_514_0) and arg_511_1.var_.characterEffect1111ui_story == nil then
				arg_511_1.var_.characterEffect1111ui_story = var_514_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_514_2 = 0.200000002980232

			if var_514_1 <= arg_511_1.time_ and arg_511_1.time_ < var_514_1 + var_514_2 and not isNil(var_514_0) then
				local var_514_3 = (arg_511_1.time_ - var_514_1) / var_514_2

				if arg_511_1.var_.characterEffect1111ui_story and not isNil(var_514_0) then
					arg_511_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_511_1.time_ >= var_514_1 + var_514_2 and arg_511_1.time_ < var_514_1 + var_514_2 + arg_514_0 and not isNil(var_514_0) and arg_511_1.var_.characterEffect1111ui_story then
				arg_511_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_514_4 = 0
			local var_514_5 = 0.4

			if var_514_4 < arg_511_1.time_ and arg_511_1.time_ <= var_514_4 + arg_514_0 then
				arg_511_1.talkMaxDuration = 0
				arg_511_1.dialogCg_.alpha = 1

				arg_511_1.dialog_:SetActive(true)
				SetActive(arg_511_1.leftNameGo_, true)

				local var_514_6 = arg_511_1:FormatText(StoryNameCfg[67].name)

				arg_511_1.leftNameTxt_.text = var_514_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_511_1.leftNameTxt_.transform)

				arg_511_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_511_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_511_1:RecordName(arg_511_1.leftNameTxt_.text)
				SetActive(arg_511_1.iconTrs_.gameObject, false)
				arg_511_1.callingController_:SetSelectedState("normal")

				local var_514_7 = arg_511_1:GetWordFromCfg(321371121)
				local var_514_8 = arg_511_1:FormatText(var_514_7.content)

				arg_511_1.text_.text = var_514_8

				LuaForUtil.ClearLinePrefixSymbol(arg_511_1.text_)

				local var_514_9 = 16
				local var_514_10 = utf8.len(var_514_8)
				local var_514_11 = var_514_9 <= 0 and var_514_5 or var_514_5 * (var_514_10 / var_514_9)

				if var_514_11 > 0 and var_514_5 < var_514_11 then
					arg_511_1.talkMaxDuration = var_514_11

					if var_514_11 + var_514_4 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_11 + var_514_4
					end
				end

				arg_511_1.text_.text = var_514_8
				arg_511_1.typewritter.percent = 0

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371121", "story_v_out_321371.awb") ~= 0 then
					local var_514_12 = manager.audio:GetVoiceLength("story_v_out_321371", "321371121", "story_v_out_321371.awb") / 1000

					if var_514_12 + var_514_4 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_12 + var_514_4
					end

					if var_514_7.prefab_name ~= "" and arg_511_1.actors_[var_514_7.prefab_name] ~= nil then
						local var_514_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_511_1.actors_[var_514_7.prefab_name].transform, "story_v_out_321371", "321371121", "story_v_out_321371.awb")

						arg_511_1:RecordAudio("321371121", var_514_13)
						arg_511_1:RecordAudio("321371121", var_514_13)
					else
						arg_511_1:AudioAction("play", "voice", "story_v_out_321371", "321371121", "story_v_out_321371.awb")
					end

					arg_511_1:RecordHistoryTalkVoice("story_v_out_321371", "321371121", "story_v_out_321371.awb")
				end

				arg_511_1:RecordContent(arg_511_1.text_.text)
			end

			local var_514_14 = math.max(var_514_5, arg_511_1.talkMaxDuration)

			if var_514_4 <= arg_511_1.time_ and arg_511_1.time_ < var_514_4 + var_514_14 then
				arg_511_1.typewritter.percent = (arg_511_1.time_ - var_514_4) / var_514_14

				arg_511_1.typewritter:SetDirty()
			end

			if arg_511_1.time_ >= var_514_4 + var_514_14 and arg_511_1.time_ < var_514_4 + var_514_14 + arg_514_0 then
				arg_511_1.typewritter.percent = 1

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(true)
			end
		end

		arg_511_1.nodeConfigList_ = {}

		arg_511_1:InitPlayNodeList()
	end,
	Play321371122 = function(arg_515_0, arg_515_1)
		arg_515_1.time_ = 0
		arg_515_1.frameCnt_ = 0
		arg_515_1.state_ = "playing"
		arg_515_1.curTalkId_ = 321371122
		arg_515_1.duration_ = 4.2

		local var_515_0 = {
			zh = 4.2,
			ja = 1.933
		}
		local var_515_1 = manager.audio:GetLocalizationFlag()

		if var_515_0[var_515_1] ~= nil then
			arg_515_1.duration_ = var_515_0[var_515_1]
		end

		SetActive(arg_515_1.tipsGo_, false)

		function arg_515_1.onSingleLineFinish_()
			arg_515_1.onSingleLineUpdate_ = nil
			arg_515_1.onSingleLineFinish_ = nil
			arg_515_1.state_ = "waiting"
		end

		function arg_515_1.playNext_(arg_517_0)
			if arg_517_0 == 1 then
				arg_515_0:Play321371123(arg_515_1)
			end
		end

		function arg_515_1.onSingleLineUpdate_(arg_518_0)
			local var_518_0 = 0
			local var_518_1 = 0.35

			if var_518_0 < arg_515_1.time_ and arg_515_1.time_ <= var_518_0 + arg_518_0 then
				arg_515_1.talkMaxDuration = 0
				arg_515_1.dialogCg_.alpha = 1

				arg_515_1.dialog_:SetActive(true)
				SetActive(arg_515_1.leftNameGo_, true)

				local var_518_2 = arg_515_1:FormatText(StoryNameCfg[67].name)

				arg_515_1.leftNameTxt_.text = var_518_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_515_1.leftNameTxt_.transform)

				arg_515_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_515_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_515_1:RecordName(arg_515_1.leftNameTxt_.text)
				SetActive(arg_515_1.iconTrs_.gameObject, false)
				arg_515_1.callingController_:SetSelectedState("normal")

				local var_518_3 = arg_515_1:GetWordFromCfg(321371122)
				local var_518_4 = arg_515_1:FormatText(var_518_3.content)

				arg_515_1.text_.text = var_518_4

				LuaForUtil.ClearLinePrefixSymbol(arg_515_1.text_)

				local var_518_5 = 14
				local var_518_6 = utf8.len(var_518_4)
				local var_518_7 = var_518_5 <= 0 and var_518_1 or var_518_1 * (var_518_6 / var_518_5)

				if var_518_7 > 0 and var_518_1 < var_518_7 then
					arg_515_1.talkMaxDuration = var_518_7

					if var_518_7 + var_518_0 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_7 + var_518_0
					end
				end

				arg_515_1.text_.text = var_518_4
				arg_515_1.typewritter.percent = 0

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371122", "story_v_out_321371.awb") ~= 0 then
					local var_518_8 = manager.audio:GetVoiceLength("story_v_out_321371", "321371122", "story_v_out_321371.awb") / 1000

					if var_518_8 + var_518_0 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_8 + var_518_0
					end

					if var_518_3.prefab_name ~= "" and arg_515_1.actors_[var_518_3.prefab_name] ~= nil then
						local var_518_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_515_1.actors_[var_518_3.prefab_name].transform, "story_v_out_321371", "321371122", "story_v_out_321371.awb")

						arg_515_1:RecordAudio("321371122", var_518_9)
						arg_515_1:RecordAudio("321371122", var_518_9)
					else
						arg_515_1:AudioAction("play", "voice", "story_v_out_321371", "321371122", "story_v_out_321371.awb")
					end

					arg_515_1:RecordHistoryTalkVoice("story_v_out_321371", "321371122", "story_v_out_321371.awb")
				end

				arg_515_1:RecordContent(arg_515_1.text_.text)
			end

			local var_518_10 = math.max(var_518_1, arg_515_1.talkMaxDuration)

			if var_518_0 <= arg_515_1.time_ and arg_515_1.time_ < var_518_0 + var_518_10 then
				arg_515_1.typewritter.percent = (arg_515_1.time_ - var_518_0) / var_518_10

				arg_515_1.typewritter:SetDirty()
			end

			if arg_515_1.time_ >= var_518_0 + var_518_10 and arg_515_1.time_ < var_518_0 + var_518_10 + arg_518_0 then
				arg_515_1.typewritter.percent = 1

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(true)
			end
		end

		arg_515_1.nodeConfigList_ = {}

		arg_515_1:InitPlayNodeList()
	end,
	Play321371123 = function(arg_519_0, arg_519_1)
		arg_519_1.time_ = 0
		arg_519_1.frameCnt_ = 0
		arg_519_1.state_ = "playing"
		arg_519_1.curTalkId_ = 321371123
		arg_519_1.duration_ = 5.4

		local var_519_0 = {
			zh = 5.4,
			ja = 4
		}
		local var_519_1 = manager.audio:GetLocalizationFlag()

		if var_519_0[var_519_1] ~= nil then
			arg_519_1.duration_ = var_519_0[var_519_1]
		end

		SetActive(arg_519_1.tipsGo_, false)

		function arg_519_1.onSingleLineFinish_()
			arg_519_1.onSingleLineUpdate_ = nil
			arg_519_1.onSingleLineFinish_ = nil
			arg_519_1.state_ = "waiting"
			arg_519_1.auto_ = false
		end

		function arg_519_1.playNext_(arg_521_0)
			arg_519_1.onStoryFinished_()
		end

		function arg_519_1.onSingleLineUpdate_(arg_522_0)
			local var_522_0 = 0
			local var_522_1 = 0.3

			if var_522_0 < arg_519_1.time_ and arg_519_1.time_ <= var_522_0 + arg_522_0 then
				arg_519_1.talkMaxDuration = 0
				arg_519_1.dialogCg_.alpha = 1

				arg_519_1.dialog_:SetActive(true)
				SetActive(arg_519_1.leftNameGo_, true)

				local var_522_2 = arg_519_1:FormatText(StoryNameCfg[67].name)

				arg_519_1.leftNameTxt_.text = var_522_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_519_1.leftNameTxt_.transform)

				arg_519_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_519_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_519_1:RecordName(arg_519_1.leftNameTxt_.text)
				SetActive(arg_519_1.iconTrs_.gameObject, false)
				arg_519_1.callingController_:SetSelectedState("normal")

				local var_522_3 = arg_519_1:GetWordFromCfg(321371123)
				local var_522_4 = arg_519_1:FormatText(var_522_3.content)

				arg_519_1.text_.text = var_522_4

				LuaForUtil.ClearLinePrefixSymbol(arg_519_1.text_)

				local var_522_5 = 12
				local var_522_6 = utf8.len(var_522_4)
				local var_522_7 = var_522_5 <= 0 and var_522_1 or var_522_1 * (var_522_6 / var_522_5)

				if var_522_7 > 0 and var_522_1 < var_522_7 then
					arg_519_1.talkMaxDuration = var_522_7

					if var_522_7 + var_522_0 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_7 + var_522_0
					end
				end

				arg_519_1.text_.text = var_522_4
				arg_519_1.typewritter.percent = 0

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371123", "story_v_out_321371.awb") ~= 0 then
					local var_522_8 = manager.audio:GetVoiceLength("story_v_out_321371", "321371123", "story_v_out_321371.awb") / 1000

					if var_522_8 + var_522_0 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_8 + var_522_0
					end

					if var_522_3.prefab_name ~= "" and arg_519_1.actors_[var_522_3.prefab_name] ~= nil then
						local var_522_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_519_1.actors_[var_522_3.prefab_name].transform, "story_v_out_321371", "321371123", "story_v_out_321371.awb")

						arg_519_1:RecordAudio("321371123", var_522_9)
						arg_519_1:RecordAudio("321371123", var_522_9)
					else
						arg_519_1:AudioAction("play", "voice", "story_v_out_321371", "321371123", "story_v_out_321371.awb")
					end

					arg_519_1:RecordHistoryTalkVoice("story_v_out_321371", "321371123", "story_v_out_321371.awb")
				end

				arg_519_1:RecordContent(arg_519_1.text_.text)
			end

			local var_522_10 = math.max(var_522_1, arg_519_1.talkMaxDuration)

			if var_522_0 <= arg_519_1.time_ and arg_519_1.time_ < var_522_0 + var_522_10 then
				arg_519_1.typewritter.percent = (arg_519_1.time_ - var_522_0) / var_522_10

				arg_519_1.typewritter:SetDirty()
			end

			if arg_519_1.time_ >= var_522_0 + var_522_10 and arg_519_1.time_ < var_522_0 + var_522_10 + arg_522_0 then
				arg_519_1.typewritter.percent = 1

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(true)
			end
		end

		arg_519_1.nodeConfigList_ = {}

		arg_519_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/L09g",
		"TextureConfig/Background/ST0506a",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/MS2112"
	},
	voices = {
		"story_v_out_321371.awb"
	}
}
