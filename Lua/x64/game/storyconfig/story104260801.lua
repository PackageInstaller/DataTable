return {
	Play426081001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 426081001
		arg_1_1.duration_ = 12.43

		local var_1_0 = {
			zh = 10.899999999999,
			ja = 12.432999999999
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
				arg_1_0:Play426081002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST2401"

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
				local var_4_5 = arg_1_1.bgs_.ST2401

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
					if iter_4_0 ~= "ST2401" then
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
			local var_4_25 = 0.3

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

			local var_4_30 = 0.133333333333333
			local var_4_31 = 1

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				local var_4_32 = "play"
				local var_4_33 = "effect"

				arg_1_1:AudioAction(var_4_32, var_4_33, "se_story_side_1095", "se_story_side_1095_amb_car", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_34 = 1.999999999999
			local var_4_35 = 1.1

			if var_4_34 < arg_1_1.time_ and arg_1_1.time_ <= var_4_34 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_36 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_36:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_37 = arg_1_1:FormatText(StoryNameCfg[1491].name)

				arg_1_1.leftNameTxt_.text = var_4_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officerw")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_38 = arg_1_1:GetWordFromCfg(426081001)
				local var_4_39 = arg_1_1:FormatText(var_4_38.content)

				arg_1_1.text_.text = var_4_39

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_40 = 44
				local var_4_41 = utf8.len(var_4_39)
				local var_4_42 = var_4_40 <= 0 and var_4_35 or var_4_35 * (var_4_41 / var_4_40)

				if var_4_42 > 0 and var_4_35 < var_4_42 then
					arg_1_1.talkMaxDuration = var_4_42
					var_4_34 = var_4_34 + 0.3

					if var_4_42 + var_4_34 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_42 + var_4_34
					end
				end

				arg_1_1.text_.text = var_4_39
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426081", "426081001", "story_v_out_426081.awb") ~= 0 then
					local var_4_43 = manager.audio:GetVoiceLength("story_v_out_426081", "426081001", "story_v_out_426081.awb") / 1000

					if var_4_43 + var_4_34 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_43 + var_4_34
					end

					if var_4_38.prefab_name ~= "" and arg_1_1.actors_[var_4_38.prefab_name] ~= nil then
						local var_4_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_38.prefab_name].transform, "story_v_out_426081", "426081001", "story_v_out_426081.awb")

						arg_1_1:RecordAudio("426081001", var_4_44)
						arg_1_1:RecordAudio("426081001", var_4_44)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_426081", "426081001", "story_v_out_426081.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_426081", "426081001", "story_v_out_426081.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_45 = var_4_34 + 0.3
			local var_4_46 = math.max(var_4_35, arg_1_1.talkMaxDuration)

			if var_4_45 <= arg_1_1.time_ and arg_1_1.time_ < var_4_45 + var_4_46 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_45) / var_4_46

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_45 + var_4_46 and arg_1_1.time_ < var_4_45 + var_4_46 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play426081002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 426081002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play426081003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0
			local var_11_1 = 0.675

			if var_11_0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_2 = arg_8_1:GetWordFromCfg(426081002)
				local var_11_3 = arg_8_1:FormatText(var_11_2.content)

				arg_8_1.text_.text = var_11_3

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_4 = 27
				local var_11_5 = utf8.len(var_11_3)
				local var_11_6 = var_11_4 <= 0 and var_11_1 or var_11_1 * (var_11_5 / var_11_4)

				if var_11_6 > 0 and var_11_1 < var_11_6 then
					arg_8_1.talkMaxDuration = var_11_6

					if var_11_6 + var_11_0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_6 + var_11_0
					end
				end

				arg_8_1.text_.text = var_11_3
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_7 = math.max(var_11_1, arg_8_1.talkMaxDuration)

			if var_11_0 <= arg_8_1.time_ and arg_8_1.time_ < var_11_0 + var_11_7 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_0) / var_11_7

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_0 + var_11_7 and arg_8_1.time_ < var_11_0 + var_11_7 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play426081003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 426081003
		arg_12_1.duration_ = 7.07

		local var_12_0 = {
			zh = 7.066,
			ja = 6.833
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
				arg_12_0:Play426081004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0
			local var_15_1 = 0.975

			if var_15_0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_2 = arg_12_1:FormatText(StoryNameCfg[1491].name)

				arg_12_1.leftNameTxt_.text = var_15_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, true)
				arg_12_1.iconController_:SetSelectedState("hero")

				arg_12_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officerw")

				arg_12_1.callingController_:SetSelectedState("normal")

				arg_12_1.keyicon_.color = Color.New(1, 1, 1)
				arg_12_1.icon_.color = Color.New(1, 1, 1)

				local var_15_3 = arg_12_1:GetWordFromCfg(426081003)
				local var_15_4 = arg_12_1:FormatText(var_15_3.content)

				arg_12_1.text_.text = var_15_4

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_5 = 39
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

				if manager.audio:GetVoiceLength("story_v_out_426081", "426081003", "story_v_out_426081.awb") ~= 0 then
					local var_15_8 = manager.audio:GetVoiceLength("story_v_out_426081", "426081003", "story_v_out_426081.awb") / 1000

					if var_15_8 + var_15_0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_8 + var_15_0
					end

					if var_15_3.prefab_name ~= "" and arg_12_1.actors_[var_15_3.prefab_name] ~= nil then
						local var_15_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_3.prefab_name].transform, "story_v_out_426081", "426081003", "story_v_out_426081.awb")

						arg_12_1:RecordAudio("426081003", var_15_9)
						arg_12_1:RecordAudio("426081003", var_15_9)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_426081", "426081003", "story_v_out_426081.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_426081", "426081003", "story_v_out_426081.awb")
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
	Play426081004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 426081004
		arg_16_1.duration_ = 7.2

		local var_16_0 = {
			zh = 5.733,
			ja = 7.2
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
				arg_16_0:Play426081005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0
			local var_19_1 = 0.875

			if var_19_0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_0 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_2 = arg_16_1:FormatText(StoryNameCfg[1492].name)

				arg_16_1.leftNameTxt_.text = var_19_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, true)
				arg_16_1.iconController_:SetSelectedState("hero")

				arg_16_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_researchera")

				arg_16_1.callingController_:SetSelectedState("normal")

				arg_16_1.keyicon_.color = Color.New(1, 1, 1)
				arg_16_1.icon_.color = Color.New(1, 1, 1)

				local var_19_3 = arg_16_1:GetWordFromCfg(426081004)
				local var_19_4 = arg_16_1:FormatText(var_19_3.content)

				arg_16_1.text_.text = var_19_4

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_5 = 35
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

				if manager.audio:GetVoiceLength("story_v_out_426081", "426081004", "story_v_out_426081.awb") ~= 0 then
					local var_19_8 = manager.audio:GetVoiceLength("story_v_out_426081", "426081004", "story_v_out_426081.awb") / 1000

					if var_19_8 + var_19_0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_8 + var_19_0
					end

					if var_19_3.prefab_name ~= "" and arg_16_1.actors_[var_19_3.prefab_name] ~= nil then
						local var_19_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_3.prefab_name].transform, "story_v_out_426081", "426081004", "story_v_out_426081.awb")

						arg_16_1:RecordAudio("426081004", var_19_9)
						arg_16_1:RecordAudio("426081004", var_19_9)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_426081", "426081004", "story_v_out_426081.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_426081", "426081004", "story_v_out_426081.awb")
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
	Play426081005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 426081005
		arg_20_1.duration_ = 9

		local var_20_0 = {
			zh = 5.266,
			ja = 9
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
				arg_20_0:Play426081006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 0
			local var_23_1 = 0.75

			if var_23_0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_0 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_2 = arg_20_1:FormatText(StoryNameCfg[1492].name)

				arg_20_1.leftNameTxt_.text = var_23_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, true)
				arg_20_1.iconController_:SetSelectedState("hero")

				arg_20_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_researchera")

				arg_20_1.callingController_:SetSelectedState("normal")

				arg_20_1.keyicon_.color = Color.New(1, 1, 1)
				arg_20_1.icon_.color = Color.New(1, 1, 1)

				local var_23_3 = arg_20_1:GetWordFromCfg(426081005)
				local var_23_4 = arg_20_1:FormatText(var_23_3.content)

				arg_20_1.text_.text = var_23_4

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_5 = 30
				local var_23_6 = utf8.len(var_23_4)
				local var_23_7 = var_23_5 <= 0 and var_23_1 or var_23_1 * (var_23_6 / var_23_5)

				if var_23_7 > 0 and var_23_1 < var_23_7 then
					arg_20_1.talkMaxDuration = var_23_7

					if var_23_7 + var_23_0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_7 + var_23_0
					end
				end

				arg_20_1.text_.text = var_23_4
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426081", "426081005", "story_v_out_426081.awb") ~= 0 then
					local var_23_8 = manager.audio:GetVoiceLength("story_v_out_426081", "426081005", "story_v_out_426081.awb") / 1000

					if var_23_8 + var_23_0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_8 + var_23_0
					end

					if var_23_3.prefab_name ~= "" and arg_20_1.actors_[var_23_3.prefab_name] ~= nil then
						local var_23_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_3.prefab_name].transform, "story_v_out_426081", "426081005", "story_v_out_426081.awb")

						arg_20_1:RecordAudio("426081005", var_23_9)
						arg_20_1:RecordAudio("426081005", var_23_9)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_426081", "426081005", "story_v_out_426081.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_426081", "426081005", "story_v_out_426081.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_10 = math.max(var_23_1, arg_20_1.talkMaxDuration)

			if var_23_0 <= arg_20_1.time_ and arg_20_1.time_ < var_23_0 + var_23_10 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_0) / var_23_10

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_0 + var_23_10 and arg_20_1.time_ < var_23_0 + var_23_10 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play426081006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 426081006
		arg_24_1.duration_ = 12.03

		local var_24_0 = {
			zh = 9.266,
			ja = 12.033
		}
		local var_24_1 = manager.audio:GetLocalizationFlag()

		if var_24_0[var_24_1] ~= nil then
			arg_24_1.duration_ = var_24_0[var_24_1]
		end

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play426081007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = 0
			local var_27_1 = 1.125

			if var_27_0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_0 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_2 = arg_24_1:FormatText(StoryNameCfg[1491].name)

				arg_24_1.leftNameTxt_.text = var_27_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, true)
				arg_24_1.iconController_:SetSelectedState("hero")

				arg_24_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officerw")

				arg_24_1.callingController_:SetSelectedState("normal")

				arg_24_1.keyicon_.color = Color.New(1, 1, 1)
				arg_24_1.icon_.color = Color.New(1, 1, 1)

				local var_27_3 = arg_24_1:GetWordFromCfg(426081006)
				local var_27_4 = arg_24_1:FormatText(var_27_3.content)

				arg_24_1.text_.text = var_27_4

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_5 = 45
				local var_27_6 = utf8.len(var_27_4)
				local var_27_7 = var_27_5 <= 0 and var_27_1 or var_27_1 * (var_27_6 / var_27_5)

				if var_27_7 > 0 and var_27_1 < var_27_7 then
					arg_24_1.talkMaxDuration = var_27_7

					if var_27_7 + var_27_0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_7 + var_27_0
					end
				end

				arg_24_1.text_.text = var_27_4
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426081", "426081006", "story_v_out_426081.awb") ~= 0 then
					local var_27_8 = manager.audio:GetVoiceLength("story_v_out_426081", "426081006", "story_v_out_426081.awb") / 1000

					if var_27_8 + var_27_0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_8 + var_27_0
					end

					if var_27_3.prefab_name ~= "" and arg_24_1.actors_[var_27_3.prefab_name] ~= nil then
						local var_27_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_3.prefab_name].transform, "story_v_out_426081", "426081006", "story_v_out_426081.awb")

						arg_24_1:RecordAudio("426081006", var_27_9)
						arg_24_1:RecordAudio("426081006", var_27_9)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_426081", "426081006", "story_v_out_426081.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_426081", "426081006", "story_v_out_426081.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_10 = math.max(var_27_1, arg_24_1.talkMaxDuration)

			if var_27_0 <= arg_24_1.time_ and arg_24_1.time_ < var_27_0 + var_27_10 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_0) / var_27_10

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_0 + var_27_10 and arg_24_1.time_ < var_27_0 + var_27_10 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play426081007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 426081007
		arg_28_1.duration_ = 8.6

		local var_28_0 = {
			zh = 4.766,
			ja = 8.6
		}
		local var_28_1 = manager.audio:GetLocalizationFlag()

		if var_28_0[var_28_1] ~= nil then
			arg_28_1.duration_ = var_28_0[var_28_1]
		end

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play426081008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = 0
			local var_31_1 = 0.675

			if var_31_0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_0 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_2 = arg_28_1:FormatText(StoryNameCfg[1492].name)

				arg_28_1.leftNameTxt_.text = var_31_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, true)
				arg_28_1.iconController_:SetSelectedState("hero")

				arg_28_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_researchera")

				arg_28_1.callingController_:SetSelectedState("normal")

				arg_28_1.keyicon_.color = Color.New(1, 1, 1)
				arg_28_1.icon_.color = Color.New(1, 1, 1)

				local var_31_3 = arg_28_1:GetWordFromCfg(426081007)
				local var_31_4 = arg_28_1:FormatText(var_31_3.content)

				arg_28_1.text_.text = var_31_4

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_5 = 27
				local var_31_6 = utf8.len(var_31_4)
				local var_31_7 = var_31_5 <= 0 and var_31_1 or var_31_1 * (var_31_6 / var_31_5)

				if var_31_7 > 0 and var_31_1 < var_31_7 then
					arg_28_1.talkMaxDuration = var_31_7

					if var_31_7 + var_31_0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_7 + var_31_0
					end
				end

				arg_28_1.text_.text = var_31_4
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426081", "426081007", "story_v_out_426081.awb") ~= 0 then
					local var_31_8 = manager.audio:GetVoiceLength("story_v_out_426081", "426081007", "story_v_out_426081.awb") / 1000

					if var_31_8 + var_31_0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_8 + var_31_0
					end

					if var_31_3.prefab_name ~= "" and arg_28_1.actors_[var_31_3.prefab_name] ~= nil then
						local var_31_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_3.prefab_name].transform, "story_v_out_426081", "426081007", "story_v_out_426081.awb")

						arg_28_1:RecordAudio("426081007", var_31_9)
						arg_28_1:RecordAudio("426081007", var_31_9)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_426081", "426081007", "story_v_out_426081.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_426081", "426081007", "story_v_out_426081.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_10 = math.max(var_31_1, arg_28_1.talkMaxDuration)

			if var_31_0 <= arg_28_1.time_ and arg_28_1.time_ < var_31_0 + var_31_10 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_0) / var_31_10

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_0 + var_31_10 and arg_28_1.time_ < var_31_0 + var_31_10 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play426081008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 426081008
		arg_32_1.duration_ = 4.57

		local var_32_0 = {
			zh = 3.6,
			ja = 4.566
		}
		local var_32_1 = manager.audio:GetLocalizationFlag()

		if var_32_0[var_32_1] ~= nil then
			arg_32_1.duration_ = var_32_0[var_32_1]
		end

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play426081009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = 0
			local var_35_1 = 0.35

			if var_35_0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_0 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_2 = arg_32_1:FormatText(StoryNameCfg[1491].name)

				arg_32_1.leftNameTxt_.text = var_35_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, true)
				arg_32_1.iconController_:SetSelectedState("hero")

				arg_32_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officerw")

				arg_32_1.callingController_:SetSelectedState("normal")

				arg_32_1.keyicon_.color = Color.New(1, 1, 1)
				arg_32_1.icon_.color = Color.New(1, 1, 1)

				local var_35_3 = arg_32_1:GetWordFromCfg(426081008)
				local var_35_4 = arg_32_1:FormatText(var_35_3.content)

				arg_32_1.text_.text = var_35_4

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_5 = 14
				local var_35_6 = utf8.len(var_35_4)
				local var_35_7 = var_35_5 <= 0 and var_35_1 or var_35_1 * (var_35_6 / var_35_5)

				if var_35_7 > 0 and var_35_1 < var_35_7 then
					arg_32_1.talkMaxDuration = var_35_7

					if var_35_7 + var_35_0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_7 + var_35_0
					end
				end

				arg_32_1.text_.text = var_35_4
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426081", "426081008", "story_v_out_426081.awb") ~= 0 then
					local var_35_8 = manager.audio:GetVoiceLength("story_v_out_426081", "426081008", "story_v_out_426081.awb") / 1000

					if var_35_8 + var_35_0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_8 + var_35_0
					end

					if var_35_3.prefab_name ~= "" and arg_32_1.actors_[var_35_3.prefab_name] ~= nil then
						local var_35_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_3.prefab_name].transform, "story_v_out_426081", "426081008", "story_v_out_426081.awb")

						arg_32_1:RecordAudio("426081008", var_35_9)
						arg_32_1:RecordAudio("426081008", var_35_9)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_426081", "426081008", "story_v_out_426081.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_426081", "426081008", "story_v_out_426081.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_10 = math.max(var_35_1, arg_32_1.talkMaxDuration)

			if var_35_0 <= arg_32_1.time_ and arg_32_1.time_ < var_35_0 + var_35_10 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_0) / var_35_10

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_0 + var_35_10 and arg_32_1.time_ < var_35_0 + var_35_10 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play426081009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 426081009
		arg_36_1.duration_ = 6.93

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play426081010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = 0
			local var_39_1 = 0.3

			if var_39_0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_0 + arg_39_0 then
				local var_39_2 = "play"
				local var_39_3 = "music"

				arg_36_1:AudioAction(var_39_2, var_39_3, "ui_battle", "ui_battle_stopbgm", "")

				local var_39_4 = ""
				local var_39_5 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_39_5 ~= "" then
					if arg_36_1.bgmTxt_.text ~= var_39_5 and arg_36_1.bgmTxt_.text ~= "" then
						if arg_36_1.bgmTxt2_.text ~= "" then
							arg_36_1.bgmTxt_.text = arg_36_1.bgmTxt2_.text
						end

						arg_36_1.bgmTxt2_.text = var_39_5

						arg_36_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_36_1.bgmTxt_.text = var_39_5
						arg_36_1.bgmTxt2_.text = var_39_5
					end

					if arg_36_1.bgmTimer then
						arg_36_1.bgmTimer:Stop()

						arg_36_1.bgmTimer = nil
					end

					if arg_36_1.settingData.show_music_name == 1 then
						arg_36_1.musicController:SetSelectedState("show")
						arg_36_1.musicAnimator_:Play("open", 0, 0)

						if arg_36_1.settingData.music_time ~= 0 then
							arg_36_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_36_1.settingData.music_time), function()
								if arg_36_1 == nil or isNil(arg_36_1.bgmTxt_) then
									return
								end

								arg_36_1.musicController:SetSelectedState("hide")
								arg_36_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_39_6 = 0.433333333333333
			local var_39_7 = 1

			if var_39_6 < arg_36_1.time_ and arg_36_1.time_ <= var_39_6 + arg_39_0 then
				local var_39_8 = "play"
				local var_39_9 = "music"

				arg_36_1:AudioAction(var_39_8, var_39_9, "bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue.awb")

				local var_39_10 = ""
				local var_39_11 = manager.audio:GetAudioName("bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue")

				if var_39_11 ~= "" then
					if arg_36_1.bgmTxt_.text ~= var_39_11 and arg_36_1.bgmTxt_.text ~= "" then
						if arg_36_1.bgmTxt2_.text ~= "" then
							arg_36_1.bgmTxt_.text = arg_36_1.bgmTxt2_.text
						end

						arg_36_1.bgmTxt2_.text = var_39_11

						arg_36_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_36_1.bgmTxt_.text = var_39_11
						arg_36_1.bgmTxt2_.text = var_39_11
					end

					if arg_36_1.bgmTimer then
						arg_36_1.bgmTimer:Stop()

						arg_36_1.bgmTimer = nil
					end

					if arg_36_1.settingData.show_music_name == 1 then
						arg_36_1.musicController:SetSelectedState("show")
						arg_36_1.musicAnimator_:Play("open", 0, 0)

						if arg_36_1.settingData.music_time ~= 0 then
							arg_36_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_36_1.settingData.music_time), function()
								if arg_36_1 == nil or isNil(arg_36_1.bgmTxt_) then
									return
								end

								arg_36_1.musicController:SetSelectedState("hide")
								arg_36_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_39_12 = 0.133333333333333
			local var_39_13 = 1

			if var_39_12 < arg_36_1.time_ and arg_36_1.time_ <= var_39_12 + arg_39_0 then
				local var_39_14 = "play"
				local var_39_15 = "effect"

				arg_36_1:AudioAction(var_39_14, var_39_15, "se_story_140", "se_story_140_car02", "")
			end

			local var_39_16 = 0.133333333333333
			local var_39_17 = 1

			if var_39_16 < arg_36_1.time_ and arg_36_1.time_ <= var_39_16 + arg_39_0 then
				local var_39_18 = "stop"
				local var_39_19 = "effect"

				arg_36_1:AudioAction(var_39_18, var_39_19, "se_story_side_1095", "se_story_side_1095_amb_car", "")
			end

			local var_39_20 = 0.433333333333333
			local var_39_21 = 1

			if var_39_20 < arg_36_1.time_ and arg_36_1.time_ <= var_39_20 + arg_39_0 then
				local var_39_22 = "play"
				local var_39_23 = "effect"

				arg_36_1:AudioAction(var_39_22, var_39_23, "se_story_side_1049", "se_story_side_1049_amb_room", "")
			end

			local var_39_24 = 0

			if var_39_24 < arg_36_1.time_ and arg_36_1.time_ <= var_39_24 + arg_39_0 then
				arg_36_1.allBtn_.enabled = false
			end

			local var_39_25 = 2.26666666666667

			if arg_36_1.time_ >= var_39_24 + var_39_25 and arg_36_1.time_ < var_39_24 + var_39_25 + arg_39_0 then
				arg_36_1.allBtn_.enabled = true
			end

			local var_39_26 = manager.ui.mainCamera.transform
			local var_39_27 = 0.866666666666667

			if var_39_27 < arg_36_1.time_ and arg_36_1.time_ <= var_39_27 + arg_39_0 then
				arg_36_1.var_.shakeOldPos = var_39_26.localPosition
			end

			local var_39_28 = 0.4666667

			if var_39_27 <= arg_36_1.time_ and arg_36_1.time_ < var_39_27 + var_39_28 then
				local var_39_29 = (arg_36_1.time_ - var_39_27) / 0.066
				local var_39_30, var_39_31 = math.modf(var_39_29)

				var_39_26.localPosition = Vector3.New(var_39_31 * 0.13, var_39_31 * 0.13, var_39_31 * 0.13) + arg_36_1.var_.shakeOldPos
			end

			if arg_36_1.time_ >= var_39_27 + var_39_28 and arg_36_1.time_ < var_39_27 + var_39_28 + arg_39_0 then
				var_39_26.localPosition = arg_36_1.var_.shakeOldPos
			end

			local var_39_32 = arg_36_1.bgs_.ST2401.transform
			local var_39_33 = 0

			if var_39_33 < arg_36_1.time_ and arg_36_1.time_ <= var_39_33 + arg_39_0 then
				arg_36_1.var_.moveOldPosST2401 = var_39_32.localPosition
			end

			local var_39_34 = 1.63333333333333

			if var_39_33 <= arg_36_1.time_ and arg_36_1.time_ < var_39_33 + var_39_34 then
				local var_39_35 = (arg_36_1.time_ - var_39_33) / var_39_34
				local var_39_36 = Vector3.New(0, 1, 8.5)

				var_39_32.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPosST2401, var_39_36, var_39_35)
			end

			if arg_36_1.time_ >= var_39_33 + var_39_34 and arg_36_1.time_ < var_39_33 + var_39_34 + arg_39_0 then
				var_39_32.localPosition = Vector3.New(0, 1, 8.5)
			end

			if arg_36_1.frameCnt_ <= 1 then
				arg_36_1.dialog_:SetActive(false)
			end

			local var_39_37 = 1.93333333333333
			local var_39_38 = 1.175

			if var_39_37 < arg_36_1.time_ and arg_36_1.time_ <= var_39_37 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0

				arg_36_1.dialog_:SetActive(true)

				arg_36_1.dialogCg_.alpha = 0

				local var_39_39 = LeanTween.value(arg_36_1.dialog_, 0, 1, 0.3)

				var_39_39:setOnUpdate(LuaHelper.FloatAction(function(arg_42_0)
					arg_36_1.dialogCg_.alpha = arg_42_0
				end))
				var_39_39:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_36_1.dialog_)
					var_39_39:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_36_1.duration_ = arg_36_1.duration_ + 0.3

				SetActive(arg_36_1.leftNameGo_, false)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_40 = arg_36_1:GetWordFromCfg(426081009)
				local var_39_41 = arg_36_1:FormatText(var_39_40.content)

				arg_36_1.text_.text = var_39_41

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_42 = 47
				local var_39_43 = utf8.len(var_39_41)
				local var_39_44 = var_39_42 <= 0 and var_39_38 or var_39_38 * (var_39_43 / var_39_42)

				if var_39_44 > 0 and var_39_38 < var_39_44 then
					arg_36_1.talkMaxDuration = var_39_44
					var_39_37 = var_39_37 + 0.3

					if var_39_44 + var_39_37 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_44 + var_39_37
					end
				end

				arg_36_1.text_.text = var_39_41
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)
				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_45 = var_39_37 + 0.3
			local var_39_46 = math.max(var_39_38, arg_36_1.talkMaxDuration)

			if var_39_45 <= arg_36_1.time_ and arg_36_1.time_ < var_39_45 + var_39_46 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_45) / var_39_46

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_45 + var_39_46 and arg_36_1.time_ < var_39_45 + var_39_46 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "ST2401",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 1.63333333333333,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 10),
					endPos = Vector3.New(0, 1, 8.5),
					easeType = LeanTweenType.easeInOutExpo
				}
			}
		}

		arg_36_1:InitPlayNodeList()
	end,
	Play426081010 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 426081010
		arg_44_1.duration_ = 5.17

		local var_44_0 = {
			zh = 4.3,
			ja = 5.166
		}
		local var_44_1 = manager.audio:GetLocalizationFlag()

		if var_44_0[var_44_1] ~= nil then
			arg_44_1.duration_ = var_44_0[var_44_1]
		end

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play426081011(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = 0
			local var_47_1 = 0.3

			if var_47_0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_0 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_2 = arg_44_1:FormatText(StoryNameCfg[1492].name)

				arg_44_1.leftNameTxt_.text = var_47_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, true)
				arg_44_1.iconController_:SetSelectedState("hero")

				arg_44_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_researchera")

				arg_44_1.callingController_:SetSelectedState("normal")

				arg_44_1.keyicon_.color = Color.New(1, 1, 1)
				arg_44_1.icon_.color = Color.New(1, 1, 1)

				local var_47_3 = arg_44_1:GetWordFromCfg(426081010)
				local var_47_4 = arg_44_1:FormatText(var_47_3.content)

				arg_44_1.text_.text = var_47_4

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_5 = 12
				local var_47_6 = utf8.len(var_47_4)
				local var_47_7 = var_47_5 <= 0 and var_47_1 or var_47_1 * (var_47_6 / var_47_5)

				if var_47_7 > 0 and var_47_1 < var_47_7 then
					arg_44_1.talkMaxDuration = var_47_7

					if var_47_7 + var_47_0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_7 + var_47_0
					end
				end

				arg_44_1.text_.text = var_47_4
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426081", "426081010", "story_v_out_426081.awb") ~= 0 then
					local var_47_8 = manager.audio:GetVoiceLength("story_v_out_426081", "426081010", "story_v_out_426081.awb") / 1000

					if var_47_8 + var_47_0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_8 + var_47_0
					end

					if var_47_3.prefab_name ~= "" and arg_44_1.actors_[var_47_3.prefab_name] ~= nil then
						local var_47_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_3.prefab_name].transform, "story_v_out_426081", "426081010", "story_v_out_426081.awb")

						arg_44_1:RecordAudio("426081010", var_47_9)
						arg_44_1:RecordAudio("426081010", var_47_9)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_426081", "426081010", "story_v_out_426081.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_426081", "426081010", "story_v_out_426081.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_10 = math.max(var_47_1, arg_44_1.talkMaxDuration)

			if var_47_0 <= arg_44_1.time_ and arg_44_1.time_ < var_47_0 + var_47_10 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_0) / var_47_10

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_0 + var_47_10 and arg_44_1.time_ < var_47_0 + var_47_10 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play426081011 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 426081011
		arg_48_1.duration_ = 5

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play426081012(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = 0
			local var_51_1 = 0.5

			if var_51_0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_0 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, false)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_2 = arg_48_1:GetWordFromCfg(426081011)
				local var_51_3 = arg_48_1:FormatText(var_51_2.content)

				arg_48_1.text_.text = var_51_3

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_4 = 20
				local var_51_5 = utf8.len(var_51_3)
				local var_51_6 = var_51_4 <= 0 and var_51_1 or var_51_1 * (var_51_5 / var_51_4)

				if var_51_6 > 0 and var_51_1 < var_51_6 then
					arg_48_1.talkMaxDuration = var_51_6

					if var_51_6 + var_51_0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_6 + var_51_0
					end
				end

				arg_48_1.text_.text = var_51_3
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)
				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_7 = math.max(var_51_1, arg_48_1.talkMaxDuration)

			if var_51_0 <= arg_48_1.time_ and arg_48_1.time_ < var_51_0 + var_51_7 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_0) / var_51_7

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_0 + var_51_7 and arg_48_1.time_ < var_51_0 + var_51_7 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play426081012 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 426081012
		arg_52_1.duration_ = 5.03

		local var_52_0 = {
			zh = 4.433,
			ja = 5.033
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
				arg_52_0:Play426081013(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = 0
			local var_55_1 = 0.475

			if var_55_0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_0 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_2 = arg_52_1:FormatText(StoryNameCfg[1491].name)

				arg_52_1.leftNameTxt_.text = var_55_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, true)
				arg_52_1.iconController_:SetSelectedState("hero")

				arg_52_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officerw")

				arg_52_1.callingController_:SetSelectedState("normal")

				arg_52_1.keyicon_.color = Color.New(1, 1, 1)
				arg_52_1.icon_.color = Color.New(1, 1, 1)

				local var_55_3 = arg_52_1:GetWordFromCfg(426081012)
				local var_55_4 = arg_52_1:FormatText(var_55_3.content)

				arg_52_1.text_.text = var_55_4

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_5 = 19
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

				if manager.audio:GetVoiceLength("story_v_out_426081", "426081012", "story_v_out_426081.awb") ~= 0 then
					local var_55_8 = manager.audio:GetVoiceLength("story_v_out_426081", "426081012", "story_v_out_426081.awb") / 1000

					if var_55_8 + var_55_0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_8 + var_55_0
					end

					if var_55_3.prefab_name ~= "" and arg_52_1.actors_[var_55_3.prefab_name] ~= nil then
						local var_55_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_3.prefab_name].transform, "story_v_out_426081", "426081012", "story_v_out_426081.awb")

						arg_52_1:RecordAudio("426081012", var_55_9)
						arg_52_1:RecordAudio("426081012", var_55_9)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_426081", "426081012", "story_v_out_426081.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_426081", "426081012", "story_v_out_426081.awb")
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
	Play426081013 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 426081013
		arg_56_1.duration_ = 8.07

		local var_56_0 = {
			zh = 7.2,
			ja = 8.066
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
				arg_56_0:Play426081014(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = "1054ui_story"

			if arg_56_1.actors_[var_59_0] == nil then
				local var_59_1 = Asset.Load("Char/" .. "1054ui_story")

				if not isNil(var_59_1) then
					local var_59_2 = Object.Instantiate(Asset.Load("Char/" .. "1054ui_story"), arg_56_1.stage_.transform)

					var_59_2.name = var_59_0
					var_59_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_56_1.actors_[var_59_0] = var_59_2

					local var_59_3 = var_59_2:GetComponentInChildren(typeof(CharacterEffect))

					var_59_3.enabled = true

					local var_59_4 = GameObjectTools.GetOrAddComponent(var_59_2, typeof(DynamicBoneHelper))

					if var_59_4 then
						var_59_4:EnableDynamicBone(false)
					end

					arg_56_1:ShowWeapon(var_59_3.transform, false)

					arg_56_1.var_[var_59_0 .. "Animator"] = var_59_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_56_1.var_[var_59_0 .. "Animator"].applyRootMotion = true
					arg_56_1.var_[var_59_0 .. "LipSync"] = var_59_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_59_5 = arg_56_1.actors_["1054ui_story"].transform
			local var_59_6 = 0

			if var_59_6 < arg_56_1.time_ and arg_56_1.time_ <= var_59_6 + arg_59_0 then
				arg_56_1.var_.moveOldPos1054ui_story = var_59_5.localPosition

				local var_59_7 = GameObjectTools.GetOrAddComponent(var_59_5.gameObject, typeof(DynamicBoneHelper))

				if var_59_7 then
					var_59_7:EnableDynamicBone(false)
				end
			end

			local var_59_8 = 0.001

			if var_59_6 <= arg_56_1.time_ and arg_56_1.time_ < var_59_6 + var_59_8 then
				local var_59_9 = (arg_56_1.time_ - var_59_6) / var_59_8
				local var_59_10 = Vector3.New(0, -0.985, -6)

				var_59_5.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos1054ui_story, var_59_10, var_59_9)

				local var_59_11 = manager.ui.mainCamera.transform.position - var_59_5.position

				var_59_5.forward = Vector3.New(var_59_11.x, var_59_11.y, var_59_11.z)

				local var_59_12 = var_59_5.localEulerAngles

				var_59_12.z = 0
				var_59_12.x = 0
				var_59_5.localEulerAngles = var_59_12
			end

			if arg_56_1.time_ >= var_59_6 + var_59_8 and arg_56_1.time_ < var_59_6 + var_59_8 + arg_59_0 then
				var_59_5.localPosition = Vector3.New(0, -0.985, -6)

				local var_59_13 = manager.ui.mainCamera.transform.position - var_59_5.position

				var_59_5.forward = Vector3.New(var_59_13.x, var_59_13.y, var_59_13.z)

				local var_59_14 = var_59_5.localEulerAngles

				var_59_14.z = 0
				var_59_14.x = 0
				var_59_5.localEulerAngles = var_59_14

				local var_59_15 = GameObjectTools.GetOrAddComponent(var_59_5.gameObject, typeof(DynamicBoneHelper))

				if var_59_15 then
					var_59_15:EnableDynamicBone(true)
				end
			end

			local var_59_16 = arg_56_1.actors_["1054ui_story"]
			local var_59_17 = 0

			if var_59_17 < arg_56_1.time_ and arg_56_1.time_ <= var_59_17 + arg_59_0 and not isNil(var_59_16) and arg_56_1.var_.characterEffect1054ui_story == nil then
				arg_56_1.var_.characterEffect1054ui_story = var_59_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_18 = 0.200000002980232

			if var_59_17 <= arg_56_1.time_ and arg_56_1.time_ < var_59_17 + var_59_18 and not isNil(var_59_16) then
				local var_59_19 = (arg_56_1.time_ - var_59_17) / var_59_18

				if arg_56_1.var_.characterEffect1054ui_story and not isNil(var_59_16) then
					arg_56_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_56_1.time_ >= var_59_17 + var_59_18 and arg_56_1.time_ < var_59_17 + var_59_18 + arg_59_0 and not isNil(var_59_16) and arg_56_1.var_.characterEffect1054ui_story then
				arg_56_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_59_20 = 0

			if var_59_20 < arg_56_1.time_ and arg_56_1.time_ <= var_59_20 + arg_59_0 then
				arg_56_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			local var_59_21 = 0

			if var_59_21 < arg_56_1.time_ and arg_56_1.time_ <= var_59_21 + arg_59_0 then
				arg_56_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_59_22 = 0
			local var_59_23 = 0.8

			if var_59_22 < arg_56_1.time_ and arg_56_1.time_ <= var_59_22 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_24 = arg_56_1:FormatText(StoryNameCfg[1487].name)

				arg_56_1.leftNameTxt_.text = var_59_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_25 = arg_56_1:GetWordFromCfg(426081013)
				local var_59_26 = arg_56_1:FormatText(var_59_25.content)

				arg_56_1.text_.text = var_59_26

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_27 = 32
				local var_59_28 = utf8.len(var_59_26)
				local var_59_29 = var_59_27 <= 0 and var_59_23 or var_59_23 * (var_59_28 / var_59_27)

				if var_59_29 > 0 and var_59_23 < var_59_29 then
					arg_56_1.talkMaxDuration = var_59_29

					if var_59_29 + var_59_22 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_29 + var_59_22
					end
				end

				arg_56_1.text_.text = var_59_26
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426081", "426081013", "story_v_out_426081.awb") ~= 0 then
					local var_59_30 = manager.audio:GetVoiceLength("story_v_out_426081", "426081013", "story_v_out_426081.awb") / 1000

					if var_59_30 + var_59_22 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_30 + var_59_22
					end

					if var_59_25.prefab_name ~= "" and arg_56_1.actors_[var_59_25.prefab_name] ~= nil then
						local var_59_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_25.prefab_name].transform, "story_v_out_426081", "426081013", "story_v_out_426081.awb")

						arg_56_1:RecordAudio("426081013", var_59_31)
						arg_56_1:RecordAudio("426081013", var_59_31)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_426081", "426081013", "story_v_out_426081.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_426081", "426081013", "story_v_out_426081.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_32 = math.max(var_59_23, arg_56_1.talkMaxDuration)

			if var_59_22 <= arg_56_1.time_ and arg_56_1.time_ < var_59_22 + var_59_32 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_22) / var_59_32

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_22 + var_59_32 and arg_56_1.time_ < var_59_22 + var_59_32 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_56_1:InitPlayNodeList()
	end,
	Play426081014 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 426081014
		arg_60_1.duration_ = 1.8

		local var_60_0 = {
			zh = 1.1,
			ja = 1.8
		}
		local var_60_1 = manager.audio:GetLocalizationFlag()

		if var_60_0[var_60_1] ~= nil then
			arg_60_1.duration_ = var_60_0[var_60_1]
		end

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play426081015(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = arg_60_1.actors_["1054ui_story"]
			local var_63_1 = 0

			if var_63_1 < arg_60_1.time_ and arg_60_1.time_ <= var_63_1 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.characterEffect1054ui_story == nil then
				arg_60_1.var_.characterEffect1054ui_story = var_63_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_2 = 0.200000002980232

			if var_63_1 <= arg_60_1.time_ and arg_60_1.time_ < var_63_1 + var_63_2 and not isNil(var_63_0) then
				local var_63_3 = (arg_60_1.time_ - var_63_1) / var_63_2

				if arg_60_1.var_.characterEffect1054ui_story and not isNil(var_63_0) then
					local var_63_4 = Mathf.Lerp(0, 0.5, var_63_3)

					arg_60_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_60_1.var_.characterEffect1054ui_story.fillRatio = var_63_4
				end
			end

			if arg_60_1.time_ >= var_63_1 + var_63_2 and arg_60_1.time_ < var_63_1 + var_63_2 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.characterEffect1054ui_story then
				local var_63_5 = 0.5

				arg_60_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_60_1.var_.characterEffect1054ui_story.fillRatio = var_63_5
			end

			local var_63_6 = 0
			local var_63_7 = 0.125

			if var_63_6 < arg_60_1.time_ and arg_60_1.time_ <= var_63_6 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_8 = arg_60_1:FormatText(StoryNameCfg[1491].name)

				arg_60_1.leftNameTxt_.text = var_63_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, true)
				arg_60_1.iconController_:SetSelectedState("hero")

				arg_60_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officerw")

				arg_60_1.callingController_:SetSelectedState("normal")

				arg_60_1.keyicon_.color = Color.New(1, 1, 1)
				arg_60_1.icon_.color = Color.New(1, 1, 1)

				local var_63_9 = arg_60_1:GetWordFromCfg(426081014)
				local var_63_10 = arg_60_1:FormatText(var_63_9.content)

				arg_60_1.text_.text = var_63_10

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_11 = 5
				local var_63_12 = utf8.len(var_63_10)
				local var_63_13 = var_63_11 <= 0 and var_63_7 or var_63_7 * (var_63_12 / var_63_11)

				if var_63_13 > 0 and var_63_7 < var_63_13 then
					arg_60_1.talkMaxDuration = var_63_13

					if var_63_13 + var_63_6 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_13 + var_63_6
					end
				end

				arg_60_1.text_.text = var_63_10
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426081", "426081014", "story_v_out_426081.awb") ~= 0 then
					local var_63_14 = manager.audio:GetVoiceLength("story_v_out_426081", "426081014", "story_v_out_426081.awb") / 1000

					if var_63_14 + var_63_6 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_14 + var_63_6
					end

					if var_63_9.prefab_name ~= "" and arg_60_1.actors_[var_63_9.prefab_name] ~= nil then
						local var_63_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_9.prefab_name].transform, "story_v_out_426081", "426081014", "story_v_out_426081.awb")

						arg_60_1:RecordAudio("426081014", var_63_15)
						arg_60_1:RecordAudio("426081014", var_63_15)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_426081", "426081014", "story_v_out_426081.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_426081", "426081014", "story_v_out_426081.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_16 = math.max(var_63_7, arg_60_1.talkMaxDuration)

			if var_63_6 <= arg_60_1.time_ and arg_60_1.time_ < var_63_6 + var_63_16 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_6) / var_63_16

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_6 + var_63_16 and arg_60_1.time_ < var_63_6 + var_63_16 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play426081015 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 426081015
		arg_64_1.duration_ = 2.03

		local var_64_0 = {
			zh = 1.491,
			ja = 2.025
		}
		local var_64_1 = manager.audio:GetLocalizationFlag()

		if var_64_0[var_64_1] ~= nil then
			arg_64_1.duration_ = var_64_0[var_64_1]
		end

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play426081016(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = arg_64_1.actors_["1054ui_story"].transform
			local var_67_1 = 0

			if var_67_1 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 then
				arg_64_1.var_.moveOldPos1054ui_story = var_67_0.localPosition

				local var_67_2 = GameObjectTools.GetOrAddComponent(var_67_0.gameObject, typeof(DynamicBoneHelper))

				if var_67_2 then
					var_67_2:EnableDynamicBone(false)
				end
			end

			local var_67_3 = 0.001

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_3 then
				local var_67_4 = (arg_64_1.time_ - var_67_1) / var_67_3
				local var_67_5 = Vector3.New(0, 100, 0)

				var_67_0.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos1054ui_story, var_67_5, var_67_4)

				local var_67_6 = manager.ui.mainCamera.transform.position - var_67_0.position

				var_67_0.forward = Vector3.New(var_67_6.x, var_67_6.y, var_67_6.z)

				local var_67_7 = var_67_0.localEulerAngles

				var_67_7.z = 0
				var_67_7.x = 0
				var_67_0.localEulerAngles = var_67_7
			end

			if arg_64_1.time_ >= var_67_1 + var_67_3 and arg_64_1.time_ < var_67_1 + var_67_3 + arg_67_0 then
				var_67_0.localPosition = Vector3.New(0, 100, 0)

				local var_67_8 = manager.ui.mainCamera.transform.position - var_67_0.position

				var_67_0.forward = Vector3.New(var_67_8.x, var_67_8.y, var_67_8.z)

				local var_67_9 = var_67_0.localEulerAngles

				var_67_9.z = 0
				var_67_9.x = 0
				var_67_0.localEulerAngles = var_67_9

				local var_67_10 = GameObjectTools.GetOrAddComponent(var_67_0.gameObject, typeof(DynamicBoneHelper))

				if var_67_10 then
					var_67_10:EnableDynamicBone(true)
				end
			end

			local var_67_11 = manager.ui.mainCamera.transform
			local var_67_12 = 0

			if var_67_12 < arg_64_1.time_ and arg_64_1.time_ <= var_67_12 + arg_67_0 then
				arg_64_1.var_.shakeOldPos = var_67_11.localPosition
			end

			local var_67_13 = 0.6

			if var_67_12 <= arg_64_1.time_ and arg_64_1.time_ < var_67_12 + var_67_13 then
				local var_67_14 = (arg_64_1.time_ - var_67_12) / 0.066
				local var_67_15, var_67_16 = math.modf(var_67_14)

				var_67_11.localPosition = Vector3.New(var_67_16 * 0.13, var_67_16 * 0.13, var_67_16 * 0.13) + arg_64_1.var_.shakeOldPos
			end

			if arg_64_1.time_ >= var_67_12 + var_67_13 and arg_64_1.time_ < var_67_12 + var_67_13 + arg_67_0 then
				var_67_11.localPosition = arg_64_1.var_.shakeOldPos
			end

			local var_67_17 = 0

			if var_67_17 < arg_64_1.time_ and arg_64_1.time_ <= var_67_17 + arg_67_0 then
				arg_64_1.allBtn_.enabled = false
			end

			local var_67_18 = 0.6

			if arg_64_1.time_ >= var_67_17 + var_67_18 and arg_64_1.time_ < var_67_17 + var_67_18 + arg_67_0 then
				arg_64_1.allBtn_.enabled = true
			end

			if arg_64_1.frameCnt_ <= 1 then
				arg_64_1.dialog_:SetActive(false)
			end

			local var_67_19 = 0.425
			local var_67_20 = 0.175

			if var_67_19 < arg_64_1.time_ and arg_64_1.time_ <= var_67_19 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0

				arg_64_1.dialog_:SetActive(true)

				arg_64_1.dialogCg_.alpha = 0

				local var_67_21 = LeanTween.value(arg_64_1.dialog_, 0, 1, 0.3)

				var_67_21:setOnUpdate(LuaHelper.FloatAction(function(arg_68_0)
					arg_64_1.dialogCg_.alpha = arg_68_0
				end))
				var_67_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_64_1.dialog_)
					var_67_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_64_1.duration_ = arg_64_1.duration_ + 0.3

				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_22 = arg_64_1:FormatText(StoryNameCfg[1493].name)

				arg_64_1.leftNameTxt_.text = var_67_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_23 = arg_64_1:GetWordFromCfg(426081015)
				local var_67_24 = arg_64_1:FormatText(var_67_23.content)

				arg_64_1.text_.text = var_67_24

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_25 = 7
				local var_67_26 = utf8.len(var_67_24)
				local var_67_27 = var_67_25 <= 0 and var_67_20 or var_67_20 * (var_67_26 / var_67_25)

				if var_67_27 > 0 and var_67_20 < var_67_27 then
					arg_64_1.talkMaxDuration = var_67_27
					var_67_19 = var_67_19 + 0.3

					if var_67_27 + var_67_19 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_27 + var_67_19
					end
				end

				arg_64_1.text_.text = var_67_24
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426081", "426081015", "story_v_out_426081.awb") ~= 0 then
					local var_67_28 = manager.audio:GetVoiceLength("story_v_out_426081", "426081015", "story_v_out_426081.awb") / 1000

					if var_67_28 + var_67_19 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_28 + var_67_19
					end

					if var_67_23.prefab_name ~= "" and arg_64_1.actors_[var_67_23.prefab_name] ~= nil then
						local var_67_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_23.prefab_name].transform, "story_v_out_426081", "426081015", "story_v_out_426081.awb")

						arg_64_1:RecordAudio("426081015", var_67_29)
						arg_64_1:RecordAudio("426081015", var_67_29)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_426081", "426081015", "story_v_out_426081.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_426081", "426081015", "story_v_out_426081.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_30 = var_67_19 + 0.3
			local var_67_31 = math.max(var_67_20, arg_64_1.talkMaxDuration)

			if var_67_30 <= arg_64_1.time_ and arg_64_1.time_ < var_67_30 + var_67_31 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_30) / var_67_31

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_30 + var_67_31 and arg_64_1.time_ < var_67_30 + var_67_31 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_64_1:InitPlayNodeList()
	end,
	Play426081016 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 426081016
		arg_70_1.duration_ = 6.58

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play426081017(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = arg_70_1.actors_["1054ui_story"].transform
			local var_73_1 = 0

			if var_73_1 < arg_70_1.time_ and arg_70_1.time_ <= var_73_1 + arg_73_0 then
				arg_70_1.var_.moveOldPos1054ui_story = var_73_0.localPosition

				local var_73_2 = GameObjectTools.GetOrAddComponent(var_73_0.gameObject, typeof(DynamicBoneHelper))

				if var_73_2 then
					var_73_2:EnableDynamicBone(false)
				end
			end

			local var_73_3 = 0.001

			if var_73_1 <= arg_70_1.time_ and arg_70_1.time_ < var_73_1 + var_73_3 then
				local var_73_4 = (arg_70_1.time_ - var_73_1) / var_73_3
				local var_73_5 = Vector3.New(0, 100, 0)

				var_73_0.localPosition = Vector3.Lerp(arg_70_1.var_.moveOldPos1054ui_story, var_73_5, var_73_4)

				local var_73_6 = manager.ui.mainCamera.transform.position - var_73_0.position

				var_73_0.forward = Vector3.New(var_73_6.x, var_73_6.y, var_73_6.z)

				local var_73_7 = var_73_0.localEulerAngles

				var_73_7.z = 0
				var_73_7.x = 0
				var_73_0.localEulerAngles = var_73_7
			end

			if arg_70_1.time_ >= var_73_1 + var_73_3 and arg_70_1.time_ < var_73_1 + var_73_3 + arg_73_0 then
				var_73_0.localPosition = Vector3.New(0, 100, 0)

				local var_73_8 = manager.ui.mainCamera.transform.position - var_73_0.position

				var_73_0.forward = Vector3.New(var_73_8.x, var_73_8.y, var_73_8.z)

				local var_73_9 = var_73_0.localEulerAngles

				var_73_9.z = 0
				var_73_9.x = 0
				var_73_0.localEulerAngles = var_73_9

				local var_73_10 = GameObjectTools.GetOrAddComponent(var_73_0.gameObject, typeof(DynamicBoneHelper))

				if var_73_10 then
					var_73_10:EnableDynamicBone(true)
				end
			end

			local var_73_11 = 0.533333333333333
			local var_73_12 = 1

			if var_73_11 < arg_70_1.time_ and arg_70_1.time_ <= var_73_11 + arg_73_0 then
				local var_73_13 = "play"
				local var_73_14 = "effect"

				arg_70_1:AudioAction(var_73_13, var_73_14, "se_story_15", "se_story_15_metal", "")
			end

			local var_73_15 = "ST47"

			if arg_70_1.bgs_[var_73_15] == nil then
				local var_73_16 = Object.Instantiate(arg_70_1.paintGo_)

				var_73_16:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_73_15)
				var_73_16.name = var_73_15
				var_73_16.transform.parent = arg_70_1.stage_.transform
				var_73_16.transform.localPosition = Vector3.New(0, 100, 0)
				arg_70_1.bgs_[var_73_15] = var_73_16
			end

			local var_73_17 = 0.333333333333333

			if var_73_17 < arg_70_1.time_ and arg_70_1.time_ <= var_73_17 + arg_73_0 then
				local var_73_18 = manager.ui.mainCamera.transform.localPosition
				local var_73_19 = Vector3.New(0, 0, 10) + Vector3.New(var_73_18.x, var_73_18.y, 0)
				local var_73_20 = arg_70_1.bgs_.ST47

				var_73_20.transform.localPosition = var_73_19
				var_73_20.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_73_21 = var_73_20:GetComponent("SpriteRenderer")

				if var_73_21 and var_73_21.sprite then
					local var_73_22 = (var_73_20.transform.localPosition - var_73_18).z
					local var_73_23 = manager.ui.mainCameraCom_
					local var_73_24 = 2 * var_73_22 * Mathf.Tan(var_73_23.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_73_25 = var_73_24 * var_73_23.aspect
					local var_73_26 = var_73_21.sprite.bounds.size.x
					local var_73_27 = var_73_21.sprite.bounds.size.y
					local var_73_28 = var_73_25 / var_73_26
					local var_73_29 = var_73_24 / var_73_27
					local var_73_30 = var_73_29 < var_73_28 and var_73_28 or var_73_29

					var_73_20.transform.localScale = Vector3.New(var_73_30, var_73_30, 0)
				end

				for iter_73_0, iter_73_1 in pairs(arg_70_1.bgs_) do
					if iter_73_0 ~= "ST47" then
						iter_73_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_73_31 = manager.ui.mainCamera.transform
			local var_73_32 = 0

			if var_73_32 < arg_70_1.time_ and arg_70_1.time_ <= var_73_32 + arg_73_0 then
				local var_73_33 = arg_70_1.var_.effectheibaishanwuchang1
				local var_73_34
				local var_73_35 = var_73_31

				if not var_73_33 then
					var_73_33 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_heibaishan"), var_73_35)
					var_73_33.name = "heibaishanwuchang1"
					arg_70_1.var_.effectheibaishanwuchang1 = var_73_33
				else
					var_73_33.transform:SetParent(var_73_35)
				end

				var_73_33.transform.localPosition = Vector3.New(0, 0, 0)
				var_73_33.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_73_36 = manager.ui.mainCamera.transform
			local var_73_37 = 2.23333333333333

			if var_73_37 < arg_70_1.time_ and arg_70_1.time_ <= var_73_37 + arg_73_0 then
				local var_73_38 = arg_70_1.var_.effectheibaishanwuchang1

				if var_73_38 then
					Object.Destroy(var_73_38)

					arg_70_1.var_.effectheibaishanwuchang1 = nil
				end
			end

			if arg_70_1.frameCnt_ <= 1 then
				arg_70_1.dialog_:SetActive(false)
			end

			local var_73_39 = 1.58333333333333
			local var_73_40 = 0.95

			if var_73_39 < arg_70_1.time_ and arg_70_1.time_ <= var_73_39 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0

				arg_70_1.dialog_:SetActive(true)

				arg_70_1.dialogCg_.alpha = 0

				local var_73_41 = LeanTween.value(arg_70_1.dialog_, 0, 1, 0.3)

				var_73_41:setOnUpdate(LuaHelper.FloatAction(function(arg_74_0)
					arg_70_1.dialogCg_.alpha = arg_74_0
				end))
				var_73_41:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_70_1.dialog_)
					var_73_41:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_70_1.duration_ = arg_70_1.duration_ + 0.3

				SetActive(arg_70_1.leftNameGo_, false)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_42 = arg_70_1:GetWordFromCfg(426081016)
				local var_73_43 = arg_70_1:FormatText(var_73_42.content)

				arg_70_1.text_.text = var_73_43

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_44 = 38
				local var_73_45 = utf8.len(var_73_43)
				local var_73_46 = var_73_44 <= 0 and var_73_40 or var_73_40 * (var_73_45 / var_73_44)

				if var_73_46 > 0 and var_73_40 < var_73_46 then
					arg_70_1.talkMaxDuration = var_73_46
					var_73_39 = var_73_39 + 0.3

					if var_73_46 + var_73_39 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_46 + var_73_39
					end
				end

				arg_70_1.text_.text = var_73_43
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)
				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_47 = var_73_39 + 0.3
			local var_73_48 = math.max(var_73_40, arg_70_1.talkMaxDuration)

			if var_73_47 <= arg_70_1.time_ and arg_70_1.time_ < var_73_47 + var_73_48 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_47) / var_73_48

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_47 + var_73_48 and arg_70_1.time_ < var_73_47 + var_73_48 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_70_1:InitPlayNodeList()
	end,
	Play426081017 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 426081017
		arg_76_1.duration_ = 5

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play426081018(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = 0.133333333333333
			local var_79_1 = 1

			if var_79_0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_0 + arg_79_0 then
				local var_79_2 = "play"
				local var_79_3 = "effect"

				arg_76_1:AudioAction(var_79_2, var_79_3, "se_story_148", "se_story_148_sword15", "")
			end

			local var_79_4 = 0.2
			local var_79_5 = 1

			if var_79_4 < arg_76_1.time_ and arg_76_1.time_ <= var_79_4 + arg_79_0 then
				local var_79_6 = "play"
				local var_79_7 = "effect"

				arg_76_1:AudioAction(var_79_6, var_79_7, "se_story_16", "se_story_16_gun03", "")
			end

			local var_79_8 = 0
			local var_79_9 = 1.2

			if var_79_8 < arg_76_1.time_ and arg_76_1.time_ <= var_79_8 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, false)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_10 = arg_76_1:GetWordFromCfg(426081017)
				local var_79_11 = arg_76_1:FormatText(var_79_10.content)

				arg_76_1.text_.text = var_79_11

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_12 = 48
				local var_79_13 = utf8.len(var_79_11)
				local var_79_14 = var_79_12 <= 0 and var_79_9 or var_79_9 * (var_79_13 / var_79_12)

				if var_79_14 > 0 and var_79_9 < var_79_14 then
					arg_76_1.talkMaxDuration = var_79_14

					if var_79_14 + var_79_8 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_14 + var_79_8
					end
				end

				arg_76_1.text_.text = var_79_11
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)
				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_15 = math.max(var_79_9, arg_76_1.talkMaxDuration)

			if var_79_8 <= arg_76_1.time_ and arg_76_1.time_ < var_79_8 + var_79_15 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_8) / var_79_15

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_8 + var_79_15 and arg_76_1.time_ < var_79_8 + var_79_15 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play426081018 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 426081018
		arg_80_1.duration_ = 5.07

		local var_80_0 = {
			zh = 3.2,
			ja = 5.066
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
				arg_80_0:Play426081019(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = 0
			local var_83_1 = 0.35

			if var_83_0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_0 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				local var_83_2 = arg_80_1:FormatText(StoryNameCfg[1492].name)

				arg_80_1.leftNameTxt_.text = var_83_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, true)
				arg_80_1.iconController_:SetSelectedState("hero")

				arg_80_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_researchera")

				arg_80_1.callingController_:SetSelectedState("normal")

				arg_80_1.keyicon_.color = Color.New(1, 1, 1)
				arg_80_1.icon_.color = Color.New(1, 1, 1)

				local var_83_3 = arg_80_1:GetWordFromCfg(426081018)
				local var_83_4 = arg_80_1:FormatText(var_83_3.content)

				arg_80_1.text_.text = var_83_4

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_5 = 14
				local var_83_6 = utf8.len(var_83_4)
				local var_83_7 = var_83_5 <= 0 and var_83_1 or var_83_1 * (var_83_6 / var_83_5)

				if var_83_7 > 0 and var_83_1 < var_83_7 then
					arg_80_1.talkMaxDuration = var_83_7

					if var_83_7 + var_83_0 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_7 + var_83_0
					end
				end

				arg_80_1.text_.text = var_83_4
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426081", "426081018", "story_v_out_426081.awb") ~= 0 then
					local var_83_8 = manager.audio:GetVoiceLength("story_v_out_426081", "426081018", "story_v_out_426081.awb") / 1000

					if var_83_8 + var_83_0 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_8 + var_83_0
					end

					if var_83_3.prefab_name ~= "" and arg_80_1.actors_[var_83_3.prefab_name] ~= nil then
						local var_83_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_3.prefab_name].transform, "story_v_out_426081", "426081018", "story_v_out_426081.awb")

						arg_80_1:RecordAudio("426081018", var_83_9)
						arg_80_1:RecordAudio("426081018", var_83_9)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_426081", "426081018", "story_v_out_426081.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_426081", "426081018", "story_v_out_426081.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_10 = math.max(var_83_1, arg_80_1.talkMaxDuration)

			if var_83_0 <= arg_80_1.time_ and arg_80_1.time_ < var_83_0 + var_83_10 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_0) / var_83_10

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_0 + var_83_10 and arg_80_1.time_ < var_83_0 + var_83_10 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play426081019 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 426081019
		arg_84_1.duration_ = 4.07

		local var_84_0 = {
			zh = 2.166,
			ja = 4.066
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
				arg_84_0:Play426081020(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = arg_84_1.actors_["1054ui_story"].transform
			local var_87_1 = 0

			if var_87_1 < arg_84_1.time_ and arg_84_1.time_ <= var_87_1 + arg_87_0 then
				arg_84_1.var_.moveOldPos1054ui_story = var_87_0.localPosition

				local var_87_2 = GameObjectTools.GetOrAddComponent(var_87_0.gameObject, typeof(DynamicBoneHelper))

				if var_87_2 then
					var_87_2:EnableDynamicBone(false)
				end
			end

			local var_87_3 = 0.001

			if var_87_1 <= arg_84_1.time_ and arg_84_1.time_ < var_87_1 + var_87_3 then
				local var_87_4 = (arg_84_1.time_ - var_87_1) / var_87_3
				local var_87_5 = Vector3.New(0, -0.985, -6)

				var_87_0.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos1054ui_story, var_87_5, var_87_4)

				local var_87_6 = manager.ui.mainCamera.transform.position - var_87_0.position

				var_87_0.forward = Vector3.New(var_87_6.x, var_87_6.y, var_87_6.z)

				local var_87_7 = var_87_0.localEulerAngles

				var_87_7.z = 0
				var_87_7.x = 0
				var_87_0.localEulerAngles = var_87_7
			end

			if arg_84_1.time_ >= var_87_1 + var_87_3 and arg_84_1.time_ < var_87_1 + var_87_3 + arg_87_0 then
				var_87_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_87_8 = manager.ui.mainCamera.transform.position - var_87_0.position

				var_87_0.forward = Vector3.New(var_87_8.x, var_87_8.y, var_87_8.z)

				local var_87_9 = var_87_0.localEulerAngles

				var_87_9.z = 0
				var_87_9.x = 0
				var_87_0.localEulerAngles = var_87_9

				local var_87_10 = GameObjectTools.GetOrAddComponent(var_87_0.gameObject, typeof(DynamicBoneHelper))

				if var_87_10 then
					var_87_10:EnableDynamicBone(true)
				end
			end

			local var_87_11 = arg_84_1.actors_["1054ui_story"]
			local var_87_12 = 0

			if var_87_12 < arg_84_1.time_ and arg_84_1.time_ <= var_87_12 + arg_87_0 and not isNil(var_87_11) and arg_84_1.var_.characterEffect1054ui_story == nil then
				arg_84_1.var_.characterEffect1054ui_story = var_87_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_13 = 0.200000002980232

			if var_87_12 <= arg_84_1.time_ and arg_84_1.time_ < var_87_12 + var_87_13 and not isNil(var_87_11) then
				local var_87_14 = (arg_84_1.time_ - var_87_12) / var_87_13

				if arg_84_1.var_.characterEffect1054ui_story and not isNil(var_87_11) then
					arg_84_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_84_1.time_ >= var_87_12 + var_87_13 and arg_84_1.time_ < var_87_12 + var_87_13 + arg_87_0 and not isNil(var_87_11) and arg_84_1.var_.characterEffect1054ui_story then
				arg_84_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_87_15 = 0

			if var_87_15 < arg_84_1.time_ and arg_84_1.time_ <= var_87_15 + arg_87_0 then
				arg_84_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			local var_87_16 = 0

			if var_87_16 < arg_84_1.time_ and arg_84_1.time_ <= var_87_16 + arg_87_0 then
				arg_84_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_87_17 = 0
			local var_87_18 = 0.275

			if var_87_17 < arg_84_1.time_ and arg_84_1.time_ <= var_87_17 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				local var_87_19 = arg_84_1:FormatText(StoryNameCfg[1487].name)

				arg_84_1.leftNameTxt_.text = var_87_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_20 = arg_84_1:GetWordFromCfg(426081019)
				local var_87_21 = arg_84_1:FormatText(var_87_20.content)

				arg_84_1.text_.text = var_87_21

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_22 = 11
				local var_87_23 = utf8.len(var_87_21)
				local var_87_24 = var_87_22 <= 0 and var_87_18 or var_87_18 * (var_87_23 / var_87_22)

				if var_87_24 > 0 and var_87_18 < var_87_24 then
					arg_84_1.talkMaxDuration = var_87_24

					if var_87_24 + var_87_17 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_24 + var_87_17
					end
				end

				arg_84_1.text_.text = var_87_21
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426081", "426081019", "story_v_out_426081.awb") ~= 0 then
					local var_87_25 = manager.audio:GetVoiceLength("story_v_out_426081", "426081019", "story_v_out_426081.awb") / 1000

					if var_87_25 + var_87_17 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_25 + var_87_17
					end

					if var_87_20.prefab_name ~= "" and arg_84_1.actors_[var_87_20.prefab_name] ~= nil then
						local var_87_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_20.prefab_name].transform, "story_v_out_426081", "426081019", "story_v_out_426081.awb")

						arg_84_1:RecordAudio("426081019", var_87_26)
						arg_84_1:RecordAudio("426081019", var_87_26)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_426081", "426081019", "story_v_out_426081.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_426081", "426081019", "story_v_out_426081.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_27 = math.max(var_87_18, arg_84_1.talkMaxDuration)

			if var_87_17 <= arg_84_1.time_ and arg_84_1.time_ < var_87_17 + var_87_27 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_17) / var_87_27

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_17 + var_87_27 and arg_84_1.time_ < var_87_17 + var_87_27 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
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
	Play426081020 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 426081020
		arg_88_1.duration_ = 6.13

		local var_88_0 = {
			zh = 3.666,
			ja = 6.133
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
				arg_88_0:Play426081021(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = arg_88_1.actors_["1054ui_story"]
			local var_91_1 = 0

			if var_91_1 < arg_88_1.time_ and arg_88_1.time_ <= var_91_1 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.characterEffect1054ui_story == nil then
				arg_88_1.var_.characterEffect1054ui_story = var_91_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_2 = 0.200000002980232

			if var_91_1 <= arg_88_1.time_ and arg_88_1.time_ < var_91_1 + var_91_2 and not isNil(var_91_0) then
				local var_91_3 = (arg_88_1.time_ - var_91_1) / var_91_2

				if arg_88_1.var_.characterEffect1054ui_story and not isNil(var_91_0) then
					local var_91_4 = Mathf.Lerp(0, 0.5, var_91_3)

					arg_88_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_88_1.var_.characterEffect1054ui_story.fillRatio = var_91_4
				end
			end

			if arg_88_1.time_ >= var_91_1 + var_91_2 and arg_88_1.time_ < var_91_1 + var_91_2 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.characterEffect1054ui_story then
				local var_91_5 = 0.5

				arg_88_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_88_1.var_.characterEffect1054ui_story.fillRatio = var_91_5
			end

			local var_91_6 = 0
			local var_91_7 = 0.45

			if var_91_6 < arg_88_1.time_ and arg_88_1.time_ <= var_91_6 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				local var_91_8 = arg_88_1:FormatText(StoryNameCfg[1492].name)

				arg_88_1.leftNameTxt_.text = var_91_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, true)
				arg_88_1.iconController_:SetSelectedState("hero")

				arg_88_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_researchera")

				arg_88_1.callingController_:SetSelectedState("normal")

				arg_88_1.keyicon_.color = Color.New(1, 1, 1)
				arg_88_1.icon_.color = Color.New(1, 1, 1)

				local var_91_9 = arg_88_1:GetWordFromCfg(426081020)
				local var_91_10 = arg_88_1:FormatText(var_91_9.content)

				arg_88_1.text_.text = var_91_10

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_11 = 18
				local var_91_12 = utf8.len(var_91_10)
				local var_91_13 = var_91_11 <= 0 and var_91_7 or var_91_7 * (var_91_12 / var_91_11)

				if var_91_13 > 0 and var_91_7 < var_91_13 then
					arg_88_1.talkMaxDuration = var_91_13

					if var_91_13 + var_91_6 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_13 + var_91_6
					end
				end

				arg_88_1.text_.text = var_91_10
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426081", "426081020", "story_v_out_426081.awb") ~= 0 then
					local var_91_14 = manager.audio:GetVoiceLength("story_v_out_426081", "426081020", "story_v_out_426081.awb") / 1000

					if var_91_14 + var_91_6 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_14 + var_91_6
					end

					if var_91_9.prefab_name ~= "" and arg_88_1.actors_[var_91_9.prefab_name] ~= nil then
						local var_91_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_9.prefab_name].transform, "story_v_out_426081", "426081020", "story_v_out_426081.awb")

						arg_88_1:RecordAudio("426081020", var_91_15)
						arg_88_1:RecordAudio("426081020", var_91_15)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_426081", "426081020", "story_v_out_426081.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_426081", "426081020", "story_v_out_426081.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_16 = math.max(var_91_7, arg_88_1.talkMaxDuration)

			if var_91_6 <= arg_88_1.time_ and arg_88_1.time_ < var_91_6 + var_91_16 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_6) / var_91_16

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_6 + var_91_16 and arg_88_1.time_ < var_91_6 + var_91_16 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play426081021 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 426081021
		arg_92_1.duration_ = 5

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play426081022(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = arg_92_1.actors_["1054ui_story"].transform
			local var_95_1 = 0

			if var_95_1 < arg_92_1.time_ and arg_92_1.time_ <= var_95_1 + arg_95_0 then
				arg_92_1.var_.moveOldPos1054ui_story = var_95_0.localPosition

				local var_95_2 = GameObjectTools.GetOrAddComponent(var_95_0.gameObject, typeof(DynamicBoneHelper))

				if var_95_2 then
					var_95_2:EnableDynamicBone(false)
				end
			end

			local var_95_3 = 0.001

			if var_95_1 <= arg_92_1.time_ and arg_92_1.time_ < var_95_1 + var_95_3 then
				local var_95_4 = (arg_92_1.time_ - var_95_1) / var_95_3
				local var_95_5 = Vector3.New(0, 100, 0)

				var_95_0.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos1054ui_story, var_95_5, var_95_4)

				local var_95_6 = manager.ui.mainCamera.transform.position - var_95_0.position

				var_95_0.forward = Vector3.New(var_95_6.x, var_95_6.y, var_95_6.z)

				local var_95_7 = var_95_0.localEulerAngles

				var_95_7.z = 0
				var_95_7.x = 0
				var_95_0.localEulerAngles = var_95_7
			end

			if arg_92_1.time_ >= var_95_1 + var_95_3 and arg_92_1.time_ < var_95_1 + var_95_3 + arg_95_0 then
				var_95_0.localPosition = Vector3.New(0, 100, 0)

				local var_95_8 = manager.ui.mainCamera.transform.position - var_95_0.position

				var_95_0.forward = Vector3.New(var_95_8.x, var_95_8.y, var_95_8.z)

				local var_95_9 = var_95_0.localEulerAngles

				var_95_9.z = 0
				var_95_9.x = 0
				var_95_0.localEulerAngles = var_95_9

				local var_95_10 = GameObjectTools.GetOrAddComponent(var_95_0.gameObject, typeof(DynamicBoneHelper))

				if var_95_10 then
					var_95_10:EnableDynamicBone(true)
				end
			end

			local var_95_11 = 0.133333333333333
			local var_95_12 = 1

			if var_95_11 < arg_92_1.time_ and arg_92_1.time_ <= var_95_11 + arg_95_0 then
				local var_95_13 = "play"
				local var_95_14 = "effect"

				arg_92_1:AudioAction(var_95_13, var_95_14, "se_story_148", "se_story_148_sword09", "")
			end

			local var_95_15 = 0.333333333333333
			local var_95_16 = 1

			if var_95_15 < arg_92_1.time_ and arg_92_1.time_ <= var_95_15 + arg_95_0 then
				local var_95_17 = "play"
				local var_95_18 = "effect"

				arg_92_1:AudioAction(var_95_17, var_95_18, "se_story_128", "se_story_128_metal", "")
			end

			local var_95_19 = manager.ui.mainCamera.transform
			local var_95_20 = 0

			if var_95_20 < arg_92_1.time_ and arg_92_1.time_ <= var_95_20 + arg_95_0 then
				local var_95_21 = arg_92_1.var_.effectdaofeng123
				local var_95_22
				local var_95_23 = var_95_19

				if not var_95_21 then
					var_95_21 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_daoguang03"), var_95_23)
					var_95_21.name = "daofeng123"
					arg_92_1.var_.effectdaofeng123 = var_95_21
				else
					var_95_21.transform:SetParent(var_95_23)
				end

				var_95_21.transform.localPosition = Vector3.New(0, 0, 0)
				var_95_21.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_95_24 = 0
			local var_95_25 = 1.25

			if var_95_24 < arg_92_1.time_ and arg_92_1.time_ <= var_95_24 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, false)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_26 = arg_92_1:GetWordFromCfg(426081021)
				local var_95_27 = arg_92_1:FormatText(var_95_26.content)

				arg_92_1.text_.text = var_95_27

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_28 = 50
				local var_95_29 = utf8.len(var_95_27)
				local var_95_30 = var_95_28 <= 0 and var_95_25 or var_95_25 * (var_95_29 / var_95_28)

				if var_95_30 > 0 and var_95_25 < var_95_30 then
					arg_92_1.talkMaxDuration = var_95_30

					if var_95_30 + var_95_24 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_30 + var_95_24
					end
				end

				arg_92_1.text_.text = var_95_27
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)
				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_31 = math.max(var_95_25, arg_92_1.talkMaxDuration)

			if var_95_24 <= arg_92_1.time_ and arg_92_1.time_ < var_95_24 + var_95_31 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_24) / var_95_31

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_24 + var_95_31 and arg_92_1.time_ < var_95_24 + var_95_31 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
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
	Play426081022 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 426081022
		arg_96_1.duration_ = 4.1

		local var_96_0 = {
			zh = 3.933,
			ja = 4.1
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
				arg_96_0:Play426081023(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = 0
			local var_99_1 = 0.4

			if var_99_0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_0 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				local var_99_2 = arg_96_1:FormatText(StoryNameCfg[1492].name)

				arg_96_1.leftNameTxt_.text = var_99_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, true)
				arg_96_1.iconController_:SetSelectedState("hero")

				arg_96_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_researchera")

				arg_96_1.callingController_:SetSelectedState("normal")

				arg_96_1.keyicon_.color = Color.New(1, 1, 1)
				arg_96_1.icon_.color = Color.New(1, 1, 1)

				local var_99_3 = arg_96_1:GetWordFromCfg(426081022)
				local var_99_4 = arg_96_1:FormatText(var_99_3.content)

				arg_96_1.text_.text = var_99_4

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_5 = 16
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

				if manager.audio:GetVoiceLength("story_v_out_426081", "426081022", "story_v_out_426081.awb") ~= 0 then
					local var_99_8 = manager.audio:GetVoiceLength("story_v_out_426081", "426081022", "story_v_out_426081.awb") / 1000

					if var_99_8 + var_99_0 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_8 + var_99_0
					end

					if var_99_3.prefab_name ~= "" and arg_96_1.actors_[var_99_3.prefab_name] ~= nil then
						local var_99_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_3.prefab_name].transform, "story_v_out_426081", "426081022", "story_v_out_426081.awb")

						arg_96_1:RecordAudio("426081022", var_99_9)
						arg_96_1:RecordAudio("426081022", var_99_9)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_426081", "426081022", "story_v_out_426081.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_426081", "426081022", "story_v_out_426081.awb")
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
	Play426081023 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 426081023
		arg_100_1.duration_ = 5

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play426081024(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = 0
			local var_103_1 = 0.925

			if var_103_0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_0 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, false)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_2 = arg_100_1:GetWordFromCfg(426081023)
				local var_103_3 = arg_100_1:FormatText(var_103_2.content)

				arg_100_1.text_.text = var_103_3

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_4 = 37
				local var_103_5 = utf8.len(var_103_3)
				local var_103_6 = var_103_4 <= 0 and var_103_1 or var_103_1 * (var_103_5 / var_103_4)

				if var_103_6 > 0 and var_103_1 < var_103_6 then
					arg_100_1.talkMaxDuration = var_103_6

					if var_103_6 + var_103_0 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_6 + var_103_0
					end
				end

				arg_100_1.text_.text = var_103_3
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)
				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_7 = math.max(var_103_1, arg_100_1.talkMaxDuration)

			if var_103_0 <= arg_100_1.time_ and arg_100_1.time_ < var_103_0 + var_103_7 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_0) / var_103_7

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_0 + var_103_7 and arg_100_1.time_ < var_103_0 + var_103_7 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play426081024 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 426081024
		arg_104_1.duration_ = 2.73

		local var_104_0 = {
			zh = 1.999999999999,
			ja = 2.733
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
				arg_104_0:Play426081025(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = arg_104_1.actors_["1054ui_story"].transform
			local var_107_1 = 0

			if var_107_1 < arg_104_1.time_ and arg_104_1.time_ <= var_107_1 + arg_107_0 then
				arg_104_1.var_.moveOldPos1054ui_story = var_107_0.localPosition

				local var_107_2 = GameObjectTools.GetOrAddComponent(var_107_0.gameObject, typeof(DynamicBoneHelper))

				if var_107_2 then
					var_107_2:EnableDynamicBone(false)
				end
			end

			local var_107_3 = 0.001

			if var_107_1 <= arg_104_1.time_ and arg_104_1.time_ < var_107_1 + var_107_3 then
				local var_107_4 = (arg_104_1.time_ - var_107_1) / var_107_3
				local var_107_5 = Vector3.New(0, -0.985, -6)

				var_107_0.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos1054ui_story, var_107_5, var_107_4)

				local var_107_6 = manager.ui.mainCamera.transform.position - var_107_0.position

				var_107_0.forward = Vector3.New(var_107_6.x, var_107_6.y, var_107_6.z)

				local var_107_7 = var_107_0.localEulerAngles

				var_107_7.z = 0
				var_107_7.x = 0
				var_107_0.localEulerAngles = var_107_7
			end

			if arg_104_1.time_ >= var_107_1 + var_107_3 and arg_104_1.time_ < var_107_1 + var_107_3 + arg_107_0 then
				var_107_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_107_8 = manager.ui.mainCamera.transform.position - var_107_0.position

				var_107_0.forward = Vector3.New(var_107_8.x, var_107_8.y, var_107_8.z)

				local var_107_9 = var_107_0.localEulerAngles

				var_107_9.z = 0
				var_107_9.x = 0
				var_107_0.localEulerAngles = var_107_9

				local var_107_10 = GameObjectTools.GetOrAddComponent(var_107_0.gameObject, typeof(DynamicBoneHelper))

				if var_107_10 then
					var_107_10:EnableDynamicBone(true)
				end
			end

			local var_107_11 = arg_104_1.actors_["1054ui_story"]
			local var_107_12 = 0

			if var_107_12 < arg_104_1.time_ and arg_104_1.time_ <= var_107_12 + arg_107_0 and not isNil(var_107_11) and arg_104_1.var_.characterEffect1054ui_story == nil then
				arg_104_1.var_.characterEffect1054ui_story = var_107_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_13 = 0.200000002980232

			if var_107_12 <= arg_104_1.time_ and arg_104_1.time_ < var_107_12 + var_107_13 and not isNil(var_107_11) then
				local var_107_14 = (arg_104_1.time_ - var_107_12) / var_107_13

				if arg_104_1.var_.characterEffect1054ui_story and not isNil(var_107_11) then
					arg_104_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_104_1.time_ >= var_107_12 + var_107_13 and arg_104_1.time_ < var_107_12 + var_107_13 + arg_107_0 and not isNil(var_107_11) and arg_104_1.var_.characterEffect1054ui_story then
				arg_104_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_107_15 = 0

			if var_107_15 < arg_104_1.time_ and arg_104_1.time_ <= var_107_15 + arg_107_0 then
				arg_104_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			local var_107_16 = 0

			if var_107_16 < arg_104_1.time_ and arg_104_1.time_ <= var_107_16 + arg_107_0 then
				arg_104_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_107_17 = 0
			local var_107_18 = 0.175

			if var_107_17 < arg_104_1.time_ and arg_104_1.time_ <= var_107_17 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				local var_107_19 = arg_104_1:FormatText(StoryNameCfg[1487].name)

				arg_104_1.leftNameTxt_.text = var_107_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_20 = arg_104_1:GetWordFromCfg(426081024)
				local var_107_21 = arg_104_1:FormatText(var_107_20.content)

				arg_104_1.text_.text = var_107_21

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_22 = 7
				local var_107_23 = utf8.len(var_107_21)
				local var_107_24 = var_107_22 <= 0 and var_107_18 or var_107_18 * (var_107_23 / var_107_22)

				if var_107_24 > 0 and var_107_18 < var_107_24 then
					arg_104_1.talkMaxDuration = var_107_24

					if var_107_24 + var_107_17 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_24 + var_107_17
					end
				end

				arg_104_1.text_.text = var_107_21
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426081", "426081024", "story_v_out_426081.awb") ~= 0 then
					local var_107_25 = manager.audio:GetVoiceLength("story_v_out_426081", "426081024", "story_v_out_426081.awb") / 1000

					if var_107_25 + var_107_17 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_25 + var_107_17
					end

					if var_107_20.prefab_name ~= "" and arg_104_1.actors_[var_107_20.prefab_name] ~= nil then
						local var_107_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_20.prefab_name].transform, "story_v_out_426081", "426081024", "story_v_out_426081.awb")

						arg_104_1:RecordAudio("426081024", var_107_26)
						arg_104_1:RecordAudio("426081024", var_107_26)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_426081", "426081024", "story_v_out_426081.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_426081", "426081024", "story_v_out_426081.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_27 = math.max(var_107_18, arg_104_1.talkMaxDuration)

			if var_107_17 <= arg_104_1.time_ and arg_104_1.time_ < var_107_17 + var_107_27 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_17) / var_107_27

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_17 + var_107_27 and arg_104_1.time_ < var_107_17 + var_107_27 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_104_1:InitPlayNodeList()
	end,
	Play426081025 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 426081025
		arg_108_1.duration_ = 6

		local var_108_0 = {
			zh = 5.2,
			ja = 6
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
				arg_108_0:Play426081026(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = 0

			if var_111_0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_0 + arg_111_0 then
				arg_108_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action4_1")
			end

			local var_111_1 = 0
			local var_111_2 = 0.55

			if var_111_1 < arg_108_1.time_ and arg_108_1.time_ <= var_111_1 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				local var_111_3 = arg_108_1:FormatText(StoryNameCfg[1487].name)

				arg_108_1.leftNameTxt_.text = var_111_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_4 = arg_108_1:GetWordFromCfg(426081025)
				local var_111_5 = arg_108_1:FormatText(var_111_4.content)

				arg_108_1.text_.text = var_111_5

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_6 = 22
				local var_111_7 = utf8.len(var_111_5)
				local var_111_8 = var_111_6 <= 0 and var_111_2 or var_111_2 * (var_111_7 / var_111_6)

				if var_111_8 > 0 and var_111_2 < var_111_8 then
					arg_108_1.talkMaxDuration = var_111_8

					if var_111_8 + var_111_1 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_8 + var_111_1
					end
				end

				arg_108_1.text_.text = var_111_5
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426081", "426081025", "story_v_out_426081.awb") ~= 0 then
					local var_111_9 = manager.audio:GetVoiceLength("story_v_out_426081", "426081025", "story_v_out_426081.awb") / 1000

					if var_111_9 + var_111_1 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_9 + var_111_1
					end

					if var_111_4.prefab_name ~= "" and arg_108_1.actors_[var_111_4.prefab_name] ~= nil then
						local var_111_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_4.prefab_name].transform, "story_v_out_426081", "426081025", "story_v_out_426081.awb")

						arg_108_1:RecordAudio("426081025", var_111_10)
						arg_108_1:RecordAudio("426081025", var_111_10)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_426081", "426081025", "story_v_out_426081.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_426081", "426081025", "story_v_out_426081.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_11 = math.max(var_111_2, arg_108_1.talkMaxDuration)

			if var_111_1 <= arg_108_1.time_ and arg_108_1.time_ < var_111_1 + var_111_11 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_1) / var_111_11

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_1 + var_111_11 and arg_108_1.time_ < var_111_1 + var_111_11 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play426081026 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 426081026
		arg_112_1.duration_ = 3.77

		local var_112_0 = {
			zh = 2.433,
			ja = 3.766
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
				arg_112_0:Play426081027(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = arg_112_1.actors_["1054ui_story"]
			local var_115_1 = 0

			if var_115_1 < arg_112_1.time_ and arg_112_1.time_ <= var_115_1 + arg_115_0 and not isNil(var_115_0) and arg_112_1.var_.characterEffect1054ui_story == nil then
				arg_112_1.var_.characterEffect1054ui_story = var_115_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_2 = 0.200000002980232

			if var_115_1 <= arg_112_1.time_ and arg_112_1.time_ < var_115_1 + var_115_2 and not isNil(var_115_0) then
				local var_115_3 = (arg_112_1.time_ - var_115_1) / var_115_2

				if arg_112_1.var_.characterEffect1054ui_story and not isNil(var_115_0) then
					local var_115_4 = Mathf.Lerp(0, 0.5, var_115_3)

					arg_112_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_112_1.var_.characterEffect1054ui_story.fillRatio = var_115_4
				end
			end

			if arg_112_1.time_ >= var_115_1 + var_115_2 and arg_112_1.time_ < var_115_1 + var_115_2 + arg_115_0 and not isNil(var_115_0) and arg_112_1.var_.characterEffect1054ui_story then
				local var_115_5 = 0.5

				arg_112_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_112_1.var_.characterEffect1054ui_story.fillRatio = var_115_5
			end

			local var_115_6 = 0
			local var_115_7 = 0.225

			if var_115_6 < arg_112_1.time_ and arg_112_1.time_ <= var_115_6 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				local var_115_8 = arg_112_1:FormatText(StoryNameCfg[1491].name)

				arg_112_1.leftNameTxt_.text = var_115_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, true)
				arg_112_1.iconController_:SetSelectedState("hero")

				arg_112_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officerw")

				arg_112_1.callingController_:SetSelectedState("normal")

				arg_112_1.keyicon_.color = Color.New(1, 1, 1)
				arg_112_1.icon_.color = Color.New(1, 1, 1)

				local var_115_9 = arg_112_1:GetWordFromCfg(426081026)
				local var_115_10 = arg_112_1:FormatText(var_115_9.content)

				arg_112_1.text_.text = var_115_10

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_11 = 9
				local var_115_12 = utf8.len(var_115_10)
				local var_115_13 = var_115_11 <= 0 and var_115_7 or var_115_7 * (var_115_12 / var_115_11)

				if var_115_13 > 0 and var_115_7 < var_115_13 then
					arg_112_1.talkMaxDuration = var_115_13

					if var_115_13 + var_115_6 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_13 + var_115_6
					end
				end

				arg_112_1.text_.text = var_115_10
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426081", "426081026", "story_v_out_426081.awb") ~= 0 then
					local var_115_14 = manager.audio:GetVoiceLength("story_v_out_426081", "426081026", "story_v_out_426081.awb") / 1000

					if var_115_14 + var_115_6 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_14 + var_115_6
					end

					if var_115_9.prefab_name ~= "" and arg_112_1.actors_[var_115_9.prefab_name] ~= nil then
						local var_115_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_9.prefab_name].transform, "story_v_out_426081", "426081026", "story_v_out_426081.awb")

						arg_112_1:RecordAudio("426081026", var_115_15)
						arg_112_1:RecordAudio("426081026", var_115_15)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_426081", "426081026", "story_v_out_426081.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_426081", "426081026", "story_v_out_426081.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_16 = math.max(var_115_7, arg_112_1.talkMaxDuration)

			if var_115_6 <= arg_112_1.time_ and arg_112_1.time_ < var_115_6 + var_115_16 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_6) / var_115_16

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_6 + var_115_16 and arg_112_1.time_ < var_115_6 + var_115_16 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play426081027 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 426081027
		arg_116_1.duration_ = 5.63

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play426081028(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = arg_116_1.actors_["1054ui_story"].transform
			local var_119_1 = 0

			if var_119_1 < arg_116_1.time_ and arg_116_1.time_ <= var_119_1 + arg_119_0 then
				arg_116_1.var_.moveOldPos1054ui_story = var_119_0.localPosition

				local var_119_2 = GameObjectTools.GetOrAddComponent(var_119_0.gameObject, typeof(DynamicBoneHelper))

				if var_119_2 then
					var_119_2:EnableDynamicBone(false)
				end
			end

			local var_119_3 = 0.001

			if var_119_1 <= arg_116_1.time_ and arg_116_1.time_ < var_119_1 + var_119_3 then
				local var_119_4 = (arg_116_1.time_ - var_119_1) / var_119_3
				local var_119_5 = Vector3.New(0, 100, 0)

				var_119_0.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos1054ui_story, var_119_5, var_119_4)

				local var_119_6 = manager.ui.mainCamera.transform.position - var_119_0.position

				var_119_0.forward = Vector3.New(var_119_6.x, var_119_6.y, var_119_6.z)

				local var_119_7 = var_119_0.localEulerAngles

				var_119_7.z = 0
				var_119_7.x = 0
				var_119_0.localEulerAngles = var_119_7
			end

			if arg_116_1.time_ >= var_119_1 + var_119_3 and arg_116_1.time_ < var_119_1 + var_119_3 + arg_119_0 then
				var_119_0.localPosition = Vector3.New(0, 100, 0)

				local var_119_8 = manager.ui.mainCamera.transform.position - var_119_0.position

				var_119_0.forward = Vector3.New(var_119_8.x, var_119_8.y, var_119_8.z)

				local var_119_9 = var_119_0.localEulerAngles

				var_119_9.z = 0
				var_119_9.x = 0
				var_119_0.localEulerAngles = var_119_9

				local var_119_10 = GameObjectTools.GetOrAddComponent(var_119_0.gameObject, typeof(DynamicBoneHelper))

				if var_119_10 then
					var_119_10:EnableDynamicBone(true)
				end
			end

			local var_119_11 = 0.133333333333333
			local var_119_12 = 1

			if var_119_11 < arg_116_1.time_ and arg_116_1.time_ <= var_119_11 + arg_119_0 then
				local var_119_13 = "play"
				local var_119_14 = "effect"

				arg_116_1:AudioAction(var_119_13, var_119_14, "se_story_150", "se_story_150_push", "")
			end

			local var_119_15 = arg_116_1.bgs_.ST47.transform
			local var_119_16 = 0

			if var_119_16 < arg_116_1.time_ and arg_116_1.time_ <= var_119_16 + arg_119_0 then
				arg_116_1.var_.moveOldPosST47 = var_119_15.localPosition
			end

			local var_119_17 = 1.13333333333333

			if var_119_16 <= arg_116_1.time_ and arg_116_1.time_ < var_119_16 + var_119_17 then
				local var_119_18 = (arg_116_1.time_ - var_119_16) / var_119_17
				local var_119_19 = Vector3.New(0, 1, 9.5)

				var_119_15.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPosST47, var_119_19, var_119_18)
			end

			if arg_116_1.time_ >= var_119_16 + var_119_17 and arg_116_1.time_ < var_119_16 + var_119_17 + arg_119_0 then
				var_119_15.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_119_20 = manager.ui.mainCamera.transform
			local var_119_21 = 0.633333333333333

			if var_119_21 < arg_116_1.time_ and arg_116_1.time_ <= var_119_21 + arg_119_0 then
				arg_116_1.var_.shakeOldPos = var_119_20.localPosition
			end

			local var_119_22 = 0.5

			if var_119_21 <= arg_116_1.time_ and arg_116_1.time_ < var_119_21 + var_119_22 then
				local var_119_23 = (arg_116_1.time_ - var_119_21) / 0.066
				local var_119_24, var_119_25 = math.modf(var_119_23)

				var_119_20.localPosition = Vector3.New(var_119_25 * 0.13, var_119_25 * 0.13, var_119_25 * 0.13) + arg_116_1.var_.shakeOldPos
			end

			if arg_116_1.time_ >= var_119_21 + var_119_22 and arg_116_1.time_ < var_119_21 + var_119_22 + arg_119_0 then
				var_119_20.localPosition = arg_116_1.var_.shakeOldPos
			end

			local var_119_26 = manager.ui.mainCamera.transform
			local var_119_27 = 0.466666666666667

			if var_119_27 < arg_116_1.time_ and arg_116_1.time_ <= var_119_27 + arg_119_0 then
				local var_119_28 = arg_116_1.var_.effectguaiwupusha1
				local var_119_29
				local var_119_30 = var_119_26

				if not var_119_28 then
					var_119_28 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_daoguang01"), var_119_30)
					var_119_28.name = "guaiwupusha1"
					arg_116_1.var_.effectguaiwupusha1 = var_119_28
				else
					var_119_28.transform:SetParent(var_119_30)
				end

				var_119_28.transform.localPosition = Vector3.New(0, 0, 0)
				var_119_28.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_119_31 = 0

			if var_119_31 < arg_116_1.time_ and arg_116_1.time_ <= var_119_31 + arg_119_0 then
				arg_116_1.allBtn_.enabled = false
			end

			local var_119_32 = 1.6

			if arg_116_1.time_ >= var_119_31 + var_119_32 and arg_116_1.time_ < var_119_31 + var_119_32 + arg_119_0 then
				arg_116_1.allBtn_.enabled = true
			end

			if arg_116_1.frameCnt_ <= 1 then
				arg_116_1.dialog_:SetActive(false)
			end

			local var_119_33 = 0.633333333333333
			local var_119_34 = 1.625

			if var_119_33 < arg_116_1.time_ and arg_116_1.time_ <= var_119_33 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0

				arg_116_1.dialog_:SetActive(true)

				arg_116_1.dialogCg_.alpha = 0

				local var_119_35 = LeanTween.value(arg_116_1.dialog_, 0, 1, 0.3)

				var_119_35:setOnUpdate(LuaHelper.FloatAction(function(arg_120_0)
					arg_116_1.dialogCg_.alpha = arg_120_0
				end))
				var_119_35:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_116_1.dialog_)
					var_119_35:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_116_1.duration_ = arg_116_1.duration_ + 0.3

				SetActive(arg_116_1.leftNameGo_, false)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_36 = arg_116_1:GetWordFromCfg(426081027)
				local var_119_37 = arg_116_1:FormatText(var_119_36.content)

				arg_116_1.text_.text = var_119_37

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_38 = 65
				local var_119_39 = utf8.len(var_119_37)
				local var_119_40 = var_119_38 <= 0 and var_119_34 or var_119_34 * (var_119_39 / var_119_38)

				if var_119_40 > 0 and var_119_34 < var_119_40 then
					arg_116_1.talkMaxDuration = var_119_40
					var_119_33 = var_119_33 + 0.3

					if var_119_40 + var_119_33 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_40 + var_119_33
					end
				end

				arg_116_1.text_.text = var_119_37
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)
				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_41 = var_119_33 + 0.3
			local var_119_42 = math.max(var_119_34, arg_116_1.talkMaxDuration)

			if var_119_41 <= arg_116_1.time_ and arg_116_1.time_ < var_119_41 + var_119_42 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_41) / var_119_42

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_41 + var_119_42 and arg_116_1.time_ < var_119_41 + var_119_42 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "ST47",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 1.13333333333333,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 10),
					endPos = Vector3.New(0, 1, 9.5),
					easeType = LeanTweenType.easeInOutExpo
				}
			}
		}

		arg_116_1:InitPlayNodeList()
	end,
	Play426081028 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 426081028
		arg_122_1.duration_ = 2.3

		local var_122_0 = {
			zh = 2.3,
			ja = 1.999999999999
		}
		local var_122_1 = manager.audio:GetLocalizationFlag()

		if var_122_0[var_122_1] ~= nil then
			arg_122_1.duration_ = var_122_0[var_122_1]
		end

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play426081029(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = arg_122_1.actors_["1054ui_story"].transform
			local var_125_1 = 0

			if var_125_1 < arg_122_1.time_ and arg_122_1.time_ <= var_125_1 + arg_125_0 then
				arg_122_1.var_.moveOldPos1054ui_story = var_125_0.localPosition

				local var_125_2 = GameObjectTools.GetOrAddComponent(var_125_0.gameObject, typeof(DynamicBoneHelper))

				if var_125_2 then
					var_125_2:EnableDynamicBone(false)
				end
			end

			local var_125_3 = 0.001

			if var_125_1 <= arg_122_1.time_ and arg_122_1.time_ < var_125_1 + var_125_3 then
				local var_125_4 = (arg_122_1.time_ - var_125_1) / var_125_3
				local var_125_5 = Vector3.New(0, -0.985, -6)

				var_125_0.localPosition = Vector3.Lerp(arg_122_1.var_.moveOldPos1054ui_story, var_125_5, var_125_4)

				local var_125_6 = manager.ui.mainCamera.transform.position - var_125_0.position

				var_125_0.forward = Vector3.New(var_125_6.x, var_125_6.y, var_125_6.z)

				local var_125_7 = var_125_0.localEulerAngles

				var_125_7.z = 0
				var_125_7.x = 0
				var_125_0.localEulerAngles = var_125_7
			end

			if arg_122_1.time_ >= var_125_1 + var_125_3 and arg_122_1.time_ < var_125_1 + var_125_3 + arg_125_0 then
				var_125_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_125_8 = manager.ui.mainCamera.transform.position - var_125_0.position

				var_125_0.forward = Vector3.New(var_125_8.x, var_125_8.y, var_125_8.z)

				local var_125_9 = var_125_0.localEulerAngles

				var_125_9.z = 0
				var_125_9.x = 0
				var_125_0.localEulerAngles = var_125_9

				local var_125_10 = GameObjectTools.GetOrAddComponent(var_125_0.gameObject, typeof(DynamicBoneHelper))

				if var_125_10 then
					var_125_10:EnableDynamicBone(true)
				end
			end

			local var_125_11 = arg_122_1.actors_["1054ui_story"]
			local var_125_12 = 0

			if var_125_12 < arg_122_1.time_ and arg_122_1.time_ <= var_125_12 + arg_125_0 and not isNil(var_125_11) and arg_122_1.var_.characterEffect1054ui_story == nil then
				arg_122_1.var_.characterEffect1054ui_story = var_125_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_13 = 0.200000002980232

			if var_125_12 <= arg_122_1.time_ and arg_122_1.time_ < var_125_12 + var_125_13 and not isNil(var_125_11) then
				local var_125_14 = (arg_122_1.time_ - var_125_12) / var_125_13

				if arg_122_1.var_.characterEffect1054ui_story and not isNil(var_125_11) then
					arg_122_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_122_1.time_ >= var_125_12 + var_125_13 and arg_122_1.time_ < var_125_12 + var_125_13 + arg_125_0 and not isNil(var_125_11) and arg_122_1.var_.characterEffect1054ui_story then
				arg_122_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_125_15 = 0

			if var_125_15 < arg_122_1.time_ and arg_122_1.time_ <= var_125_15 + arg_125_0 then
				arg_122_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			local var_125_16 = 0

			if var_125_16 < arg_122_1.time_ and arg_122_1.time_ <= var_125_16 + arg_125_0 then
				arg_122_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_125_17 = 0
			local var_125_18 = 0.075

			if var_125_17 < arg_122_1.time_ and arg_122_1.time_ <= var_125_17 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				local var_125_19 = arg_122_1:FormatText(StoryNameCfg[1487].name)

				arg_122_1.leftNameTxt_.text = var_125_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_20 = arg_122_1:GetWordFromCfg(426081028)
				local var_125_21 = arg_122_1:FormatText(var_125_20.content)

				arg_122_1.text_.text = var_125_21

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_22 = 3
				local var_125_23 = utf8.len(var_125_21)
				local var_125_24 = var_125_22 <= 0 and var_125_18 or var_125_18 * (var_125_23 / var_125_22)

				if var_125_24 > 0 and var_125_18 < var_125_24 then
					arg_122_1.talkMaxDuration = var_125_24

					if var_125_24 + var_125_17 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_24 + var_125_17
					end
				end

				arg_122_1.text_.text = var_125_21
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426081", "426081028", "story_v_out_426081.awb") ~= 0 then
					local var_125_25 = manager.audio:GetVoiceLength("story_v_out_426081", "426081028", "story_v_out_426081.awb") / 1000

					if var_125_25 + var_125_17 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_25 + var_125_17
					end

					if var_125_20.prefab_name ~= "" and arg_122_1.actors_[var_125_20.prefab_name] ~= nil then
						local var_125_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_20.prefab_name].transform, "story_v_out_426081", "426081028", "story_v_out_426081.awb")

						arg_122_1:RecordAudio("426081028", var_125_26)
						arg_122_1:RecordAudio("426081028", var_125_26)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_out_426081", "426081028", "story_v_out_426081.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_out_426081", "426081028", "story_v_out_426081.awb")
				end

				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_27 = math.max(var_125_18, arg_122_1.talkMaxDuration)

			if var_125_17 <= arg_122_1.time_ and arg_122_1.time_ < var_125_17 + var_125_27 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_17) / var_125_27

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_17 + var_125_27 and arg_122_1.time_ < var_125_17 + var_125_27 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
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
	Play426081029 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 426081029
		arg_126_1.duration_ = 3.47

		local var_126_0 = {
			zh = 2.733,
			ja = 3.466
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
				arg_126_0:Play426081030(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = arg_126_1.actors_["1054ui_story"]
			local var_129_1 = 0

			if var_129_1 < arg_126_1.time_ and arg_126_1.time_ <= var_129_1 + arg_129_0 and not isNil(var_129_0) and arg_126_1.var_.characterEffect1054ui_story == nil then
				arg_126_1.var_.characterEffect1054ui_story = var_129_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_2 = 0.200000002980232

			if var_129_1 <= arg_126_1.time_ and arg_126_1.time_ < var_129_1 + var_129_2 and not isNil(var_129_0) then
				local var_129_3 = (arg_126_1.time_ - var_129_1) / var_129_2

				if arg_126_1.var_.characterEffect1054ui_story and not isNil(var_129_0) then
					local var_129_4 = Mathf.Lerp(0, 0.5, var_129_3)

					arg_126_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_126_1.var_.characterEffect1054ui_story.fillRatio = var_129_4
				end
			end

			if arg_126_1.time_ >= var_129_1 + var_129_2 and arg_126_1.time_ < var_129_1 + var_129_2 + arg_129_0 and not isNil(var_129_0) and arg_126_1.var_.characterEffect1054ui_story then
				local var_129_5 = 0.5

				arg_126_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_126_1.var_.characterEffect1054ui_story.fillRatio = var_129_5
			end

			local var_129_6 = 0
			local var_129_7 = 0.375

			if var_129_6 < arg_126_1.time_ and arg_126_1.time_ <= var_129_6 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				local var_129_8 = arg_126_1:FormatText(StoryNameCfg[1491].name)

				arg_126_1.leftNameTxt_.text = var_129_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, true)
				arg_126_1.iconController_:SetSelectedState("hero")

				arg_126_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officerw")

				arg_126_1.callingController_:SetSelectedState("normal")

				arg_126_1.keyicon_.color = Color.New(1, 1, 1)
				arg_126_1.icon_.color = Color.New(1, 1, 1)

				local var_129_9 = arg_126_1:GetWordFromCfg(426081029)
				local var_129_10 = arg_126_1:FormatText(var_129_9.content)

				arg_126_1.text_.text = var_129_10

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_11 = 15
				local var_129_12 = utf8.len(var_129_10)
				local var_129_13 = var_129_11 <= 0 and var_129_7 or var_129_7 * (var_129_12 / var_129_11)

				if var_129_13 > 0 and var_129_7 < var_129_13 then
					arg_126_1.talkMaxDuration = var_129_13

					if var_129_13 + var_129_6 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_13 + var_129_6
					end
				end

				arg_126_1.text_.text = var_129_10
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426081", "426081029", "story_v_out_426081.awb") ~= 0 then
					local var_129_14 = manager.audio:GetVoiceLength("story_v_out_426081", "426081029", "story_v_out_426081.awb") / 1000

					if var_129_14 + var_129_6 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_14 + var_129_6
					end

					if var_129_9.prefab_name ~= "" and arg_126_1.actors_[var_129_9.prefab_name] ~= nil then
						local var_129_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_9.prefab_name].transform, "story_v_out_426081", "426081029", "story_v_out_426081.awb")

						arg_126_1:RecordAudio("426081029", var_129_15)
						arg_126_1:RecordAudio("426081029", var_129_15)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_out_426081", "426081029", "story_v_out_426081.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_out_426081", "426081029", "story_v_out_426081.awb")
				end

				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_16 = math.max(var_129_7, arg_126_1.talkMaxDuration)

			if var_129_6 <= arg_126_1.time_ and arg_126_1.time_ < var_129_6 + var_129_16 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_6) / var_129_16

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_6 + var_129_16 and arg_126_1.time_ < var_129_6 + var_129_16 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {}

		arg_126_1:InitPlayNodeList()
	end,
	Play426081030 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 426081030
		arg_130_1.duration_ = 4.67

		local var_130_0 = {
			zh = 3.633,
			ja = 4.666
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
				arg_130_0:Play426081031(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = arg_130_1.actors_["1054ui_story"].transform
			local var_133_1 = 0

			if var_133_1 < arg_130_1.time_ and arg_130_1.time_ <= var_133_1 + arg_133_0 then
				arg_130_1.var_.moveOldPos1054ui_story = var_133_0.localPosition

				local var_133_2 = GameObjectTools.GetOrAddComponent(var_133_0.gameObject, typeof(DynamicBoneHelper))

				if var_133_2 then
					var_133_2:EnableDynamicBone(false)
				end
			end

			local var_133_3 = 0.001

			if var_133_1 <= arg_130_1.time_ and arg_130_1.time_ < var_133_1 + var_133_3 then
				local var_133_4 = (arg_130_1.time_ - var_133_1) / var_133_3
				local var_133_5 = Vector3.New(0, -0.985, -6)

				var_133_0.localPosition = Vector3.Lerp(arg_130_1.var_.moveOldPos1054ui_story, var_133_5, var_133_4)

				local var_133_6 = manager.ui.mainCamera.transform.position - var_133_0.position

				var_133_0.forward = Vector3.New(var_133_6.x, var_133_6.y, var_133_6.z)

				local var_133_7 = var_133_0.localEulerAngles

				var_133_7.z = 0
				var_133_7.x = 0
				var_133_0.localEulerAngles = var_133_7
			end

			if arg_130_1.time_ >= var_133_1 + var_133_3 and arg_130_1.time_ < var_133_1 + var_133_3 + arg_133_0 then
				var_133_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_133_8 = manager.ui.mainCamera.transform.position - var_133_0.position

				var_133_0.forward = Vector3.New(var_133_8.x, var_133_8.y, var_133_8.z)

				local var_133_9 = var_133_0.localEulerAngles

				var_133_9.z = 0
				var_133_9.x = 0
				var_133_0.localEulerAngles = var_133_9

				local var_133_10 = GameObjectTools.GetOrAddComponent(var_133_0.gameObject, typeof(DynamicBoneHelper))

				if var_133_10 then
					var_133_10:EnableDynamicBone(true)
				end
			end

			local var_133_11 = arg_130_1.actors_["1054ui_story"]
			local var_133_12 = 0

			if var_133_12 < arg_130_1.time_ and arg_130_1.time_ <= var_133_12 + arg_133_0 and not isNil(var_133_11) and arg_130_1.var_.characterEffect1054ui_story == nil then
				arg_130_1.var_.characterEffect1054ui_story = var_133_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_133_13 = 0.200000002980232

			if var_133_12 <= arg_130_1.time_ and arg_130_1.time_ < var_133_12 + var_133_13 and not isNil(var_133_11) then
				local var_133_14 = (arg_130_1.time_ - var_133_12) / var_133_13

				if arg_130_1.var_.characterEffect1054ui_story and not isNil(var_133_11) then
					arg_130_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_130_1.time_ >= var_133_12 + var_133_13 and arg_130_1.time_ < var_133_12 + var_133_13 + arg_133_0 and not isNil(var_133_11) and arg_130_1.var_.characterEffect1054ui_story then
				arg_130_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_133_15 = 0

			if var_133_15 < arg_130_1.time_ and arg_130_1.time_ <= var_133_15 + arg_133_0 then
				arg_130_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action4_1")
			end

			local var_133_16 = 0

			if var_133_16 < arg_130_1.time_ and arg_130_1.time_ <= var_133_16 + arg_133_0 then
				arg_130_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_133_17 = 0
			local var_133_18 = 0.325

			if var_133_17 < arg_130_1.time_ and arg_130_1.time_ <= var_133_17 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				local var_133_19 = arg_130_1:FormatText(StoryNameCfg[1487].name)

				arg_130_1.leftNameTxt_.text = var_133_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_20 = arg_130_1:GetWordFromCfg(426081030)
				local var_133_21 = arg_130_1:FormatText(var_133_20.content)

				arg_130_1.text_.text = var_133_21

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_22 = 13
				local var_133_23 = utf8.len(var_133_21)
				local var_133_24 = var_133_22 <= 0 and var_133_18 or var_133_18 * (var_133_23 / var_133_22)

				if var_133_24 > 0 and var_133_18 < var_133_24 then
					arg_130_1.talkMaxDuration = var_133_24

					if var_133_24 + var_133_17 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_24 + var_133_17
					end
				end

				arg_130_1.text_.text = var_133_21
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426081", "426081030", "story_v_out_426081.awb") ~= 0 then
					local var_133_25 = manager.audio:GetVoiceLength("story_v_out_426081", "426081030", "story_v_out_426081.awb") / 1000

					if var_133_25 + var_133_17 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_25 + var_133_17
					end

					if var_133_20.prefab_name ~= "" and arg_130_1.actors_[var_133_20.prefab_name] ~= nil then
						local var_133_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_130_1.actors_[var_133_20.prefab_name].transform, "story_v_out_426081", "426081030", "story_v_out_426081.awb")

						arg_130_1:RecordAudio("426081030", var_133_26)
						arg_130_1:RecordAudio("426081030", var_133_26)
					else
						arg_130_1:AudioAction("play", "voice", "story_v_out_426081", "426081030", "story_v_out_426081.awb")
					end

					arg_130_1:RecordHistoryTalkVoice("story_v_out_426081", "426081030", "story_v_out_426081.awb")
				end

				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_27 = math.max(var_133_18, arg_130_1.talkMaxDuration)

			if var_133_17 <= arg_130_1.time_ and arg_130_1.time_ < var_133_17 + var_133_27 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_17) / var_133_27

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_17 + var_133_27 and arg_130_1.time_ < var_133_17 + var_133_27 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
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
	Play426081031 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 426081031
		arg_134_1.duration_ = 11.07

		local var_134_0 = {
			zh = 6.233,
			ja = 11.066
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
				arg_134_0:Play426081032(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			local var_137_0 = arg_134_1.actors_["1054ui_story"]
			local var_137_1 = 0

			if var_137_1 < arg_134_1.time_ and arg_134_1.time_ <= var_137_1 + arg_137_0 and not isNil(var_137_0) and arg_134_1.var_.characterEffect1054ui_story == nil then
				arg_134_1.var_.characterEffect1054ui_story = var_137_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_2 = 0.200000002980232

			if var_137_1 <= arg_134_1.time_ and arg_134_1.time_ < var_137_1 + var_137_2 and not isNil(var_137_0) then
				local var_137_3 = (arg_134_1.time_ - var_137_1) / var_137_2

				if arg_134_1.var_.characterEffect1054ui_story and not isNil(var_137_0) then
					local var_137_4 = Mathf.Lerp(0, 0.5, var_137_3)

					arg_134_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_134_1.var_.characterEffect1054ui_story.fillRatio = var_137_4
				end
			end

			if arg_134_1.time_ >= var_137_1 + var_137_2 and arg_134_1.time_ < var_137_1 + var_137_2 + arg_137_0 and not isNil(var_137_0) and arg_134_1.var_.characterEffect1054ui_story then
				local var_137_5 = 0.5

				arg_134_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_134_1.var_.characterEffect1054ui_story.fillRatio = var_137_5
			end

			local var_137_6 = 0
			local var_137_7 = 0.9

			if var_137_6 < arg_134_1.time_ and arg_134_1.time_ <= var_137_6 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				local var_137_8 = arg_134_1:FormatText(StoryNameCfg[1491].name)

				arg_134_1.leftNameTxt_.text = var_137_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, true)
				arg_134_1.iconController_:SetSelectedState("hero")

				arg_134_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officerw")

				arg_134_1.callingController_:SetSelectedState("normal")

				arg_134_1.keyicon_.color = Color.New(1, 1, 1)
				arg_134_1.icon_.color = Color.New(1, 1, 1)

				local var_137_9 = arg_134_1:GetWordFromCfg(426081031)
				local var_137_10 = arg_134_1:FormatText(var_137_9.content)

				arg_134_1.text_.text = var_137_10

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_11 = 36
				local var_137_12 = utf8.len(var_137_10)
				local var_137_13 = var_137_11 <= 0 and var_137_7 or var_137_7 * (var_137_12 / var_137_11)

				if var_137_13 > 0 and var_137_7 < var_137_13 then
					arg_134_1.talkMaxDuration = var_137_13

					if var_137_13 + var_137_6 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_13 + var_137_6
					end
				end

				arg_134_1.text_.text = var_137_10
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426081", "426081031", "story_v_out_426081.awb") ~= 0 then
					local var_137_14 = manager.audio:GetVoiceLength("story_v_out_426081", "426081031", "story_v_out_426081.awb") / 1000

					if var_137_14 + var_137_6 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_14 + var_137_6
					end

					if var_137_9.prefab_name ~= "" and arg_134_1.actors_[var_137_9.prefab_name] ~= nil then
						local var_137_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_134_1.actors_[var_137_9.prefab_name].transform, "story_v_out_426081", "426081031", "story_v_out_426081.awb")

						arg_134_1:RecordAudio("426081031", var_137_15)
						arg_134_1:RecordAudio("426081031", var_137_15)
					else
						arg_134_1:AudioAction("play", "voice", "story_v_out_426081", "426081031", "story_v_out_426081.awb")
					end

					arg_134_1:RecordHistoryTalkVoice("story_v_out_426081", "426081031", "story_v_out_426081.awb")
				end

				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_16 = math.max(var_137_7, arg_134_1.talkMaxDuration)

			if var_137_6 <= arg_134_1.time_ and arg_134_1.time_ < var_137_6 + var_137_16 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_6) / var_137_16

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_6 + var_137_16 and arg_134_1.time_ < var_137_6 + var_137_16 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {}

		arg_134_1:InitPlayNodeList()
	end,
	Play426081032 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 426081032
		arg_138_1.duration_ = 3.5

		local var_138_0 = {
			zh = 2.633,
			ja = 3.5
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
				arg_138_0:Play426081033(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			local var_141_0 = 0
			local var_141_1 = 0.425

			if var_141_0 < arg_138_1.time_ and arg_138_1.time_ <= var_141_0 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				local var_141_2 = arg_138_1:FormatText(StoryNameCfg[1491].name)

				arg_138_1.leftNameTxt_.text = var_141_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, true)
				arg_138_1.iconController_:SetSelectedState("hero")

				arg_138_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officerw")

				arg_138_1.callingController_:SetSelectedState("normal")

				arg_138_1.keyicon_.color = Color.New(1, 1, 1)
				arg_138_1.icon_.color = Color.New(1, 1, 1)

				local var_141_3 = arg_138_1:GetWordFromCfg(426081032)
				local var_141_4 = arg_138_1:FormatText(var_141_3.content)

				arg_138_1.text_.text = var_141_4

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_5 = 17
				local var_141_6 = utf8.len(var_141_4)
				local var_141_7 = var_141_5 <= 0 and var_141_1 or var_141_1 * (var_141_6 / var_141_5)

				if var_141_7 > 0 and var_141_1 < var_141_7 then
					arg_138_1.talkMaxDuration = var_141_7

					if var_141_7 + var_141_0 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_7 + var_141_0
					end
				end

				arg_138_1.text_.text = var_141_4
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426081", "426081032", "story_v_out_426081.awb") ~= 0 then
					local var_141_8 = manager.audio:GetVoiceLength("story_v_out_426081", "426081032", "story_v_out_426081.awb") / 1000

					if var_141_8 + var_141_0 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_8 + var_141_0
					end

					if var_141_3.prefab_name ~= "" and arg_138_1.actors_[var_141_3.prefab_name] ~= nil then
						local var_141_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_3.prefab_name].transform, "story_v_out_426081", "426081032", "story_v_out_426081.awb")

						arg_138_1:RecordAudio("426081032", var_141_9)
						arg_138_1:RecordAudio("426081032", var_141_9)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_out_426081", "426081032", "story_v_out_426081.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_out_426081", "426081032", "story_v_out_426081.awb")
				end

				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_10 = math.max(var_141_1, arg_138_1.talkMaxDuration)

			if var_141_0 <= arg_138_1.time_ and arg_138_1.time_ < var_141_0 + var_141_10 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_0) / var_141_10

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_0 + var_141_10 and arg_138_1.time_ < var_141_0 + var_141_10 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {}

		arg_138_1:InitPlayNodeList()
	end,
	Play426081033 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 426081033
		arg_142_1.duration_ = 5

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play426081034(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			local var_145_0 = arg_142_1.actors_["1054ui_story"].transform
			local var_145_1 = 0

			if var_145_1 < arg_142_1.time_ and arg_142_1.time_ <= var_145_1 + arg_145_0 then
				arg_142_1.var_.moveOldPos1054ui_story = var_145_0.localPosition

				local var_145_2 = GameObjectTools.GetOrAddComponent(var_145_0.gameObject, typeof(DynamicBoneHelper))

				if var_145_2 then
					var_145_2:EnableDynamicBone(false)
				end
			end

			local var_145_3 = 0.001

			if var_145_1 <= arg_142_1.time_ and arg_142_1.time_ < var_145_1 + var_145_3 then
				local var_145_4 = (arg_142_1.time_ - var_145_1) / var_145_3
				local var_145_5 = Vector3.New(0, 100, 0)

				var_145_0.localPosition = Vector3.Lerp(arg_142_1.var_.moveOldPos1054ui_story, var_145_5, var_145_4)

				local var_145_6 = manager.ui.mainCamera.transform.position - var_145_0.position

				var_145_0.forward = Vector3.New(var_145_6.x, var_145_6.y, var_145_6.z)

				local var_145_7 = var_145_0.localEulerAngles

				var_145_7.z = 0
				var_145_7.x = 0
				var_145_0.localEulerAngles = var_145_7
			end

			if arg_142_1.time_ >= var_145_1 + var_145_3 and arg_142_1.time_ < var_145_1 + var_145_3 + arg_145_0 then
				var_145_0.localPosition = Vector3.New(0, 100, 0)

				local var_145_8 = manager.ui.mainCamera.transform.position - var_145_0.position

				var_145_0.forward = Vector3.New(var_145_8.x, var_145_8.y, var_145_8.z)

				local var_145_9 = var_145_0.localEulerAngles

				var_145_9.z = 0
				var_145_9.x = 0
				var_145_0.localEulerAngles = var_145_9

				local var_145_10 = GameObjectTools.GetOrAddComponent(var_145_0.gameObject, typeof(DynamicBoneHelper))

				if var_145_10 then
					var_145_10:EnableDynamicBone(true)
				end
			end

			local var_145_11 = 0
			local var_145_12 = 0.625

			if var_145_11 < arg_142_1.time_ and arg_142_1.time_ <= var_145_11 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, false)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_13 = arg_142_1:GetWordFromCfg(426081033)
				local var_145_14 = arg_142_1:FormatText(var_145_13.content)

				arg_142_1.text_.text = var_145_14

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_15 = 25
				local var_145_16 = utf8.len(var_145_14)
				local var_145_17 = var_145_15 <= 0 and var_145_12 or var_145_12 * (var_145_16 / var_145_15)

				if var_145_17 > 0 and var_145_12 < var_145_17 then
					arg_142_1.talkMaxDuration = var_145_17

					if var_145_17 + var_145_11 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_17 + var_145_11
					end
				end

				arg_142_1.text_.text = var_145_14
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)
				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_18 = math.max(var_145_12, arg_142_1.talkMaxDuration)

			if var_145_11 <= arg_142_1.time_ and arg_142_1.time_ < var_145_11 + var_145_18 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_11) / var_145_18

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_11 + var_145_18 and arg_142_1.time_ < var_145_11 + var_145_18 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
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
	Play426081034 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 426081034
		arg_146_1.duration_ = 5

		local var_146_0 = {
			zh = 3.233,
			ja = 5
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
				arg_146_0:Play426081035(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			local var_149_0 = 0
			local var_149_1 = 0.475

			if var_149_0 < arg_146_1.time_ and arg_146_1.time_ <= var_149_0 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				local var_149_2 = arg_146_1:FormatText(StoryNameCfg[1491].name)

				arg_146_1.leftNameTxt_.text = var_149_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, true)
				arg_146_1.iconController_:SetSelectedState("hero")

				arg_146_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officerw")

				arg_146_1.callingController_:SetSelectedState("normal")

				arg_146_1.keyicon_.color = Color.New(1, 1, 1)
				arg_146_1.icon_.color = Color.New(1, 1, 1)

				local var_149_3 = arg_146_1:GetWordFromCfg(426081034)
				local var_149_4 = arg_146_1:FormatText(var_149_3.content)

				arg_146_1.text_.text = var_149_4

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_5 = 19
				local var_149_6 = utf8.len(var_149_4)
				local var_149_7 = var_149_5 <= 0 and var_149_1 or var_149_1 * (var_149_6 / var_149_5)

				if var_149_7 > 0 and var_149_1 < var_149_7 then
					arg_146_1.talkMaxDuration = var_149_7

					if var_149_7 + var_149_0 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_7 + var_149_0
					end
				end

				arg_146_1.text_.text = var_149_4
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426081", "426081034", "story_v_out_426081.awb") ~= 0 then
					local var_149_8 = manager.audio:GetVoiceLength("story_v_out_426081", "426081034", "story_v_out_426081.awb") / 1000

					if var_149_8 + var_149_0 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_8 + var_149_0
					end

					if var_149_3.prefab_name ~= "" and arg_146_1.actors_[var_149_3.prefab_name] ~= nil then
						local var_149_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_146_1.actors_[var_149_3.prefab_name].transform, "story_v_out_426081", "426081034", "story_v_out_426081.awb")

						arg_146_1:RecordAudio("426081034", var_149_9)
						arg_146_1:RecordAudio("426081034", var_149_9)
					else
						arg_146_1:AudioAction("play", "voice", "story_v_out_426081", "426081034", "story_v_out_426081.awb")
					end

					arg_146_1:RecordHistoryTalkVoice("story_v_out_426081", "426081034", "story_v_out_426081.awb")
				end

				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_10 = math.max(var_149_1, arg_146_1.talkMaxDuration)

			if var_149_0 <= arg_146_1.time_ and arg_146_1.time_ < var_149_0 + var_149_10 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_0) / var_149_10

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_0 + var_149_10 and arg_146_1.time_ < var_149_0 + var_149_10 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {}

		arg_146_1:InitPlayNodeList()
	end,
	Play426081035 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 426081035
		arg_150_1.duration_ = 5

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play426081036(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			local var_153_0 = 0.6
			local var_153_1 = 1

			if var_153_0 < arg_150_1.time_ and arg_150_1.time_ <= var_153_0 + arg_153_0 then
				local var_153_2 = "play"
				local var_153_3 = "effect"

				arg_150_1:AudioAction(var_153_2, var_153_3, "se_story_148", "se_story_148_sword02", "")
			end

			local var_153_4 = 0.766666666666667
			local var_153_5 = 1

			if var_153_4 < arg_150_1.time_ and arg_150_1.time_ <= var_153_4 + arg_153_0 then
				local var_153_6 = "play"
				local var_153_7 = "effect"

				arg_150_1:AudioAction(var_153_6, var_153_7, "se_story_123_01", "se_story_123_01_hit", "")
			end

			local var_153_8 = arg_150_1.bgs_.ST47.transform
			local var_153_9 = 0

			if var_153_9 < arg_150_1.time_ and arg_150_1.time_ <= var_153_9 + arg_153_0 then
				arg_150_1.var_.moveOldPosST47 = var_153_8.localPosition
			end

			local var_153_10 = 1.13333333333333

			if var_153_9 <= arg_150_1.time_ and arg_150_1.time_ < var_153_9 + var_153_10 then
				local var_153_11 = (arg_150_1.time_ - var_153_9) / var_153_10
				local var_153_12 = Vector3.New(0, 1, 10)

				var_153_8.localPosition = Vector3.Lerp(arg_150_1.var_.moveOldPosST47, var_153_12, var_153_11)
			end

			if arg_150_1.time_ >= var_153_9 + var_153_10 and arg_150_1.time_ < var_153_9 + var_153_10 + arg_153_0 then
				var_153_8.localPosition = Vector3.New(0, 1, 10)
			end

			local var_153_13 = manager.ui.mainCamera.transform
			local var_153_14 = 0.633333333333333

			if var_153_14 < arg_150_1.time_ and arg_150_1.time_ <= var_153_14 + arg_153_0 then
				arg_150_1.var_.shakeOldPos = var_153_13.localPosition
			end

			local var_153_15 = 0.5

			if var_153_14 <= arg_150_1.time_ and arg_150_1.time_ < var_153_14 + var_153_15 then
				local var_153_16 = (arg_150_1.time_ - var_153_14) / 0.066
				local var_153_17, var_153_18 = math.modf(var_153_16)

				var_153_13.localPosition = Vector3.New(var_153_18 * 0.13, var_153_18 * 0.13, var_153_18 * 0.13) + arg_150_1.var_.shakeOldPos
			end

			if arg_150_1.time_ >= var_153_14 + var_153_15 and arg_150_1.time_ < var_153_14 + var_153_15 + arg_153_0 then
				var_153_13.localPosition = arg_150_1.var_.shakeOldPos
			end

			local var_153_19 = manager.ui.mainCamera.transform
			local var_153_20 = 0.466666666666667

			if var_153_20 < arg_150_1.time_ and arg_150_1.time_ <= var_153_20 + arg_153_0 then
				local var_153_21 = arg_150_1.var_.effectguaiwupusha1
				local var_153_22
				local var_153_23 = var_153_19

				if not var_153_21 then
					var_153_21 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_daoguang01"), var_153_23)
					var_153_21.name = "guaiwupusha1"
					arg_150_1.var_.effectguaiwupusha1 = var_153_21
				else
					var_153_21.transform:SetParent(var_153_23)
				end

				var_153_21.transform.localPosition = Vector3.New(0, 0, 0)
				var_153_21.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_153_24 = 0

			if var_153_24 < arg_150_1.time_ and arg_150_1.time_ <= var_153_24 + arg_153_0 then
				arg_150_1.allBtn_.enabled = false
			end

			local var_153_25 = 1.6

			if arg_150_1.time_ >= var_153_24 + var_153_25 and arg_150_1.time_ < var_153_24 + var_153_25 + arg_153_0 then
				arg_150_1.allBtn_.enabled = true
			end

			local var_153_26 = 0
			local var_153_27 = 1.15

			if var_153_26 < arg_150_1.time_ and arg_150_1.time_ <= var_153_26 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, false)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_28 = arg_150_1:GetWordFromCfg(426081035)
				local var_153_29 = arg_150_1:FormatText(var_153_28.content)

				arg_150_1.text_.text = var_153_29

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_30 = 46
				local var_153_31 = utf8.len(var_153_29)
				local var_153_32 = var_153_30 <= 0 and var_153_27 or var_153_27 * (var_153_31 / var_153_30)

				if var_153_32 > 0 and var_153_27 < var_153_32 then
					arg_150_1.talkMaxDuration = var_153_32

					if var_153_32 + var_153_26 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_32 + var_153_26
					end
				end

				arg_150_1.text_.text = var_153_29
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)
				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_33 = math.max(var_153_27, arg_150_1.talkMaxDuration)

			if var_153_26 <= arg_150_1.time_ and arg_150_1.time_ < var_153_26 + var_153_33 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_26) / var_153_33

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_26 + var_153_33 and arg_150_1.time_ < var_153_26 + var_153_33 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "ST47",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 1.13333333333333,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 9.5),
					endPos = Vector3.New(0, 1, 10),
					easeType = LeanTweenType.easeInOutExpo
				}
			}
		}

		arg_150_1:InitPlayNodeList()
	end,
	Play426081036 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 426081036
		arg_154_1.duration_ = 5

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play426081037(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			local var_157_0 = 0.533333333333333
			local var_157_1 = 1

			if var_157_0 < arg_154_1.time_ and arg_154_1.time_ <= var_157_0 + arg_157_0 then
				local var_157_2 = "play"
				local var_157_3 = "effect"

				arg_154_1:AudioAction(var_157_2, var_157_3, "se_story_4", "se_story_4_arm_1", "")
			end

			local var_157_4 = 0
			local var_157_5 = 0.8

			if var_157_4 < arg_154_1.time_ and arg_154_1.time_ <= var_157_4 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, false)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_6 = arg_154_1:GetWordFromCfg(426081036)
				local var_157_7 = arg_154_1:FormatText(var_157_6.content)

				arg_154_1.text_.text = var_157_7

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_8 = 32
				local var_157_9 = utf8.len(var_157_7)
				local var_157_10 = var_157_8 <= 0 and var_157_5 or var_157_5 * (var_157_9 / var_157_8)

				if var_157_10 > 0 and var_157_5 < var_157_10 then
					arg_154_1.talkMaxDuration = var_157_10

					if var_157_10 + var_157_4 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_10 + var_157_4
					end
				end

				arg_154_1.text_.text = var_157_7
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)
				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_11 = math.max(var_157_5, arg_154_1.talkMaxDuration)

			if var_157_4 <= arg_154_1.time_ and arg_154_1.time_ < var_157_4 + var_157_11 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_4) / var_157_11

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_4 + var_157_11 and arg_154_1.time_ < var_157_4 + var_157_11 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {}

		arg_154_1:InitPlayNodeList()
	end,
	Play426081037 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 426081037
		arg_158_1.duration_ = 5

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play426081038(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			local var_161_0 = 0
			local var_161_1 = 0.825

			if var_161_0 < arg_158_1.time_ and arg_158_1.time_ <= var_161_0 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, false)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_2 = arg_158_1:GetWordFromCfg(426081037)
				local var_161_3 = arg_158_1:FormatText(var_161_2.content)

				arg_158_1.text_.text = var_161_3

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_4 = 33
				local var_161_5 = utf8.len(var_161_3)
				local var_161_6 = var_161_4 <= 0 and var_161_1 or var_161_1 * (var_161_5 / var_161_4)

				if var_161_6 > 0 and var_161_1 < var_161_6 then
					arg_158_1.talkMaxDuration = var_161_6

					if var_161_6 + var_161_0 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_6 + var_161_0
					end
				end

				arg_158_1.text_.text = var_161_3
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)
				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_7 = math.max(var_161_1, arg_158_1.talkMaxDuration)

			if var_161_0 <= arg_158_1.time_ and arg_158_1.time_ < var_161_0 + var_161_7 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_0) / var_161_7

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_0 + var_161_7 and arg_158_1.time_ < var_161_0 + var_161_7 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {}

		arg_158_1:InitPlayNodeList()
	end,
	Play426081038 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 426081038
		arg_162_1.duration_ = 5.03

		local var_162_0 = {
			zh = 5.033,
			ja = 4.9
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
				arg_162_0:Play426081039(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			local var_165_0 = arg_162_1.actors_["1054ui_story"].transform
			local var_165_1 = 0

			if var_165_1 < arg_162_1.time_ and arg_162_1.time_ <= var_165_1 + arg_165_0 then
				arg_162_1.var_.moveOldPos1054ui_story = var_165_0.localPosition

				local var_165_2 = GameObjectTools.GetOrAddComponent(var_165_0.gameObject, typeof(DynamicBoneHelper))

				if var_165_2 then
					var_165_2:EnableDynamicBone(false)
				end
			end

			local var_165_3 = 0.001

			if var_165_1 <= arg_162_1.time_ and arg_162_1.time_ < var_165_1 + var_165_3 then
				local var_165_4 = (arg_162_1.time_ - var_165_1) / var_165_3
				local var_165_5 = Vector3.New(0, -0.985, -6)

				var_165_0.localPosition = Vector3.Lerp(arg_162_1.var_.moveOldPos1054ui_story, var_165_5, var_165_4)

				local var_165_6 = manager.ui.mainCamera.transform.position - var_165_0.position

				var_165_0.forward = Vector3.New(var_165_6.x, var_165_6.y, var_165_6.z)

				local var_165_7 = var_165_0.localEulerAngles

				var_165_7.z = 0
				var_165_7.x = 0
				var_165_0.localEulerAngles = var_165_7
			end

			if arg_162_1.time_ >= var_165_1 + var_165_3 and arg_162_1.time_ < var_165_1 + var_165_3 + arg_165_0 then
				var_165_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_165_8 = manager.ui.mainCamera.transform.position - var_165_0.position

				var_165_0.forward = Vector3.New(var_165_8.x, var_165_8.y, var_165_8.z)

				local var_165_9 = var_165_0.localEulerAngles

				var_165_9.z = 0
				var_165_9.x = 0
				var_165_0.localEulerAngles = var_165_9

				local var_165_10 = GameObjectTools.GetOrAddComponent(var_165_0.gameObject, typeof(DynamicBoneHelper))

				if var_165_10 then
					var_165_10:EnableDynamicBone(true)
				end
			end

			local var_165_11 = arg_162_1.actors_["1054ui_story"]
			local var_165_12 = 0

			if var_165_12 < arg_162_1.time_ and arg_162_1.time_ <= var_165_12 + arg_165_0 and not isNil(var_165_11) and arg_162_1.var_.characterEffect1054ui_story == nil then
				arg_162_1.var_.characterEffect1054ui_story = var_165_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_165_13 = 0.200000002980232

			if var_165_12 <= arg_162_1.time_ and arg_162_1.time_ < var_165_12 + var_165_13 and not isNil(var_165_11) then
				local var_165_14 = (arg_162_1.time_ - var_165_12) / var_165_13

				if arg_162_1.var_.characterEffect1054ui_story and not isNil(var_165_11) then
					arg_162_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_162_1.time_ >= var_165_12 + var_165_13 and arg_162_1.time_ < var_165_12 + var_165_13 + arg_165_0 and not isNil(var_165_11) and arg_162_1.var_.characterEffect1054ui_story then
				arg_162_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_165_15 = 0

			if var_165_15 < arg_162_1.time_ and arg_162_1.time_ <= var_165_15 + arg_165_0 then
				arg_162_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action9_2")
			end

			local var_165_16 = 0

			if var_165_16 < arg_162_1.time_ and arg_162_1.time_ <= var_165_16 + arg_165_0 then
				arg_162_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_165_17 = 0
			local var_165_18 = 0.275

			if var_165_17 < arg_162_1.time_ and arg_162_1.time_ <= var_165_17 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, true)

				local var_165_19 = arg_162_1:FormatText(StoryNameCfg[1487].name)

				arg_162_1.leftNameTxt_.text = var_165_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_162_1.leftNameTxt_.transform)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1.leftNameTxt_.text)
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_20 = arg_162_1:GetWordFromCfg(426081038)
				local var_165_21 = arg_162_1:FormatText(var_165_20.content)

				arg_162_1.text_.text = var_165_21

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_22 = 11
				local var_165_23 = utf8.len(var_165_21)
				local var_165_24 = var_165_22 <= 0 and var_165_18 or var_165_18 * (var_165_23 / var_165_22)

				if var_165_24 > 0 and var_165_18 < var_165_24 then
					arg_162_1.talkMaxDuration = var_165_24

					if var_165_24 + var_165_17 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_24 + var_165_17
					end
				end

				arg_162_1.text_.text = var_165_21
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426081", "426081038", "story_v_out_426081.awb") ~= 0 then
					local var_165_25 = manager.audio:GetVoiceLength("story_v_out_426081", "426081038", "story_v_out_426081.awb") / 1000

					if var_165_25 + var_165_17 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_25 + var_165_17
					end

					if var_165_20.prefab_name ~= "" and arg_162_1.actors_[var_165_20.prefab_name] ~= nil then
						local var_165_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_162_1.actors_[var_165_20.prefab_name].transform, "story_v_out_426081", "426081038", "story_v_out_426081.awb")

						arg_162_1:RecordAudio("426081038", var_165_26)
						arg_162_1:RecordAudio("426081038", var_165_26)
					else
						arg_162_1:AudioAction("play", "voice", "story_v_out_426081", "426081038", "story_v_out_426081.awb")
					end

					arg_162_1:RecordHistoryTalkVoice("story_v_out_426081", "426081038", "story_v_out_426081.awb")
				end

				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_27 = math.max(var_165_18, arg_162_1.talkMaxDuration)

			if var_165_17 <= arg_162_1.time_ and arg_162_1.time_ < var_165_17 + var_165_27 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_17) / var_165_27

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_17 + var_165_27 and arg_162_1.time_ < var_165_17 + var_165_27 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_162_1:InitPlayNodeList()
	end,
	Play426081039 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 426081039
		arg_166_1.duration_ = 9

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play426081040(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			local var_169_0 = 2

			if var_169_0 < arg_166_1.time_ and arg_166_1.time_ <= var_169_0 + arg_169_0 then
				local var_169_1 = manager.ui.mainCamera.transform.localPosition
				local var_169_2 = Vector3.New(0, 0, 10) + Vector3.New(var_169_1.x, var_169_1.y, 0)
				local var_169_3 = arg_166_1.bgs_.ST47

				var_169_3.transform.localPosition = var_169_2
				var_169_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_169_4 = var_169_3:GetComponent("SpriteRenderer")

				if var_169_4 and var_169_4.sprite then
					local var_169_5 = (var_169_3.transform.localPosition - var_169_1).z
					local var_169_6 = manager.ui.mainCameraCom_
					local var_169_7 = 2 * var_169_5 * Mathf.Tan(var_169_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_169_8 = var_169_7 * var_169_6.aspect
					local var_169_9 = var_169_4.sprite.bounds.size.x
					local var_169_10 = var_169_4.sprite.bounds.size.y
					local var_169_11 = var_169_8 / var_169_9
					local var_169_12 = var_169_7 / var_169_10
					local var_169_13 = var_169_12 < var_169_11 and var_169_11 or var_169_12

					var_169_3.transform.localScale = Vector3.New(var_169_13, var_169_13, 0)
				end

				for iter_169_0, iter_169_1 in pairs(arg_166_1.bgs_) do
					if iter_169_0 ~= "ST47" then
						iter_169_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_169_14 = 4

			if var_169_14 < arg_166_1.time_ and arg_166_1.time_ <= var_169_14 + arg_169_0 then
				arg_166_1.allBtn_.enabled = false
			end

			local var_169_15 = 0.3

			if arg_166_1.time_ >= var_169_14 + var_169_15 and arg_166_1.time_ < var_169_14 + var_169_15 + arg_169_0 then
				arg_166_1.allBtn_.enabled = true
			end

			local var_169_16 = 0

			if var_169_16 < arg_166_1.time_ and arg_166_1.time_ <= var_169_16 + arg_169_0 then
				arg_166_1.mask_.enabled = true
				arg_166_1.mask_.raycastTarget = true

				arg_166_1:SetGaussion(false)
			end

			local var_169_17 = 2

			if var_169_16 <= arg_166_1.time_ and arg_166_1.time_ < var_169_16 + var_169_17 then
				local var_169_18 = (arg_166_1.time_ - var_169_16) / var_169_17
				local var_169_19 = Color.New(0, 0, 0)

				var_169_19.a = Mathf.Lerp(0, 1, var_169_18)
				arg_166_1.mask_.color = var_169_19
			end

			if arg_166_1.time_ >= var_169_16 + var_169_17 and arg_166_1.time_ < var_169_16 + var_169_17 + arg_169_0 then
				local var_169_20 = Color.New(0, 0, 0)

				var_169_20.a = 1
				arg_166_1.mask_.color = var_169_20
			end

			local var_169_21 = 2

			if var_169_21 < arg_166_1.time_ and arg_166_1.time_ <= var_169_21 + arg_169_0 then
				arg_166_1.mask_.enabled = true
				arg_166_1.mask_.raycastTarget = true

				arg_166_1:SetGaussion(false)
			end

			local var_169_22 = 2

			if var_169_21 <= arg_166_1.time_ and arg_166_1.time_ < var_169_21 + var_169_22 then
				local var_169_23 = (arg_166_1.time_ - var_169_21) / var_169_22
				local var_169_24 = Color.New(0, 0, 0)

				var_169_24.a = Mathf.Lerp(1, 0, var_169_23)
				arg_166_1.mask_.color = var_169_24
			end

			if arg_166_1.time_ >= var_169_21 + var_169_22 and arg_166_1.time_ < var_169_21 + var_169_22 + arg_169_0 then
				local var_169_25 = Color.New(0, 0, 0)
				local var_169_26 = 0

				arg_166_1.mask_.enabled = false
				var_169_25.a = var_169_26
				arg_166_1.mask_.color = var_169_25
			end

			local var_169_27 = arg_166_1.actors_["1054ui_story"].transform
			local var_169_28 = 1.96599999815226

			if var_169_28 < arg_166_1.time_ and arg_166_1.time_ <= var_169_28 + arg_169_0 then
				arg_166_1.var_.moveOldPos1054ui_story = var_169_27.localPosition

				local var_169_29 = GameObjectTools.GetOrAddComponent(var_169_27.gameObject, typeof(DynamicBoneHelper))

				if var_169_29 then
					var_169_29:EnableDynamicBone(false)
				end
			end

			local var_169_30 = 0.001

			if var_169_28 <= arg_166_1.time_ and arg_166_1.time_ < var_169_28 + var_169_30 then
				local var_169_31 = (arg_166_1.time_ - var_169_28) / var_169_30
				local var_169_32 = Vector3.New(0, 100, 0)

				var_169_27.localPosition = Vector3.Lerp(arg_166_1.var_.moveOldPos1054ui_story, var_169_32, var_169_31)

				local var_169_33 = manager.ui.mainCamera.transform.position - var_169_27.position

				var_169_27.forward = Vector3.New(var_169_33.x, var_169_33.y, var_169_33.z)

				local var_169_34 = var_169_27.localEulerAngles

				var_169_34.z = 0
				var_169_34.x = 0
				var_169_27.localEulerAngles = var_169_34
			end

			if arg_166_1.time_ >= var_169_28 + var_169_30 and arg_166_1.time_ < var_169_28 + var_169_30 + arg_169_0 then
				var_169_27.localPosition = Vector3.New(0, 100, 0)

				local var_169_35 = manager.ui.mainCamera.transform.position - var_169_27.position

				var_169_27.forward = Vector3.New(var_169_35.x, var_169_35.y, var_169_35.z)

				local var_169_36 = var_169_27.localEulerAngles

				var_169_36.z = 0
				var_169_36.x = 0
				var_169_27.localEulerAngles = var_169_36

				local var_169_37 = GameObjectTools.GetOrAddComponent(var_169_27.gameObject, typeof(DynamicBoneHelper))

				if var_169_37 then
					var_169_37:EnableDynamicBone(true)
				end
			end

			local var_169_38 = arg_166_1.actors_["1054ui_story"]
			local var_169_39 = 1.96599999815226

			if var_169_39 < arg_166_1.time_ and arg_166_1.time_ <= var_169_39 + arg_169_0 and not isNil(var_169_38) and arg_166_1.var_.characterEffect1054ui_story == nil then
				arg_166_1.var_.characterEffect1054ui_story = var_169_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_169_40 = 0.034000001847744

			if var_169_39 <= arg_166_1.time_ and arg_166_1.time_ < var_169_39 + var_169_40 and not isNil(var_169_38) then
				local var_169_41 = (arg_166_1.time_ - var_169_39) / var_169_40

				if arg_166_1.var_.characterEffect1054ui_story and not isNil(var_169_38) then
					local var_169_42 = Mathf.Lerp(0, 0.5, var_169_41)

					arg_166_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_166_1.var_.characterEffect1054ui_story.fillRatio = var_169_42
				end
			end

			if arg_166_1.time_ >= var_169_39 + var_169_40 and arg_166_1.time_ < var_169_39 + var_169_40 + arg_169_0 and not isNil(var_169_38) and arg_166_1.var_.characterEffect1054ui_story then
				local var_169_43 = 0.5

				arg_166_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_166_1.var_.characterEffect1054ui_story.fillRatio = var_169_43
			end

			if arg_166_1.frameCnt_ <= 1 then
				arg_166_1.dialog_:SetActive(false)
			end

			local var_169_44 = 4
			local var_169_45 = 0.975

			if var_169_44 < arg_166_1.time_ and arg_166_1.time_ <= var_169_44 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0

				arg_166_1.dialog_:SetActive(true)

				arg_166_1.dialogCg_.alpha = 0

				local var_169_46 = LeanTween.value(arg_166_1.dialog_, 0, 1, 0.3)

				var_169_46:setOnUpdate(LuaHelper.FloatAction(function(arg_170_0)
					arg_166_1.dialogCg_.alpha = arg_170_0
				end))
				var_169_46:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_166_1.dialog_)
					var_169_46:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_166_1.duration_ = arg_166_1.duration_ + 0.3

				SetActive(arg_166_1.leftNameGo_, false)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_47 = arg_166_1:GetWordFromCfg(426081039)
				local var_169_48 = arg_166_1:FormatText(var_169_47.content)

				arg_166_1.text_.text = var_169_48

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_49 = 39
				local var_169_50 = utf8.len(var_169_48)
				local var_169_51 = var_169_49 <= 0 and var_169_45 or var_169_45 * (var_169_50 / var_169_49)

				if var_169_51 > 0 and var_169_45 < var_169_51 then
					arg_166_1.talkMaxDuration = var_169_51
					var_169_44 = var_169_44 + 0.3

					if var_169_51 + var_169_44 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_51 + var_169_44
					end
				end

				arg_166_1.text_.text = var_169_48
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)
				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_52 = var_169_44 + 0.3
			local var_169_53 = math.max(var_169_45, arg_166_1.talkMaxDuration)

			if var_169_52 <= arg_166_1.time_ and arg_166_1.time_ < var_169_52 + var_169_53 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_52) / var_169_53

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_52 + var_169_53 and arg_166_1.time_ < var_169_52 + var_169_53 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_166_1:InitPlayNodeList()
	end,
	Play426081040 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 426081040
		arg_172_1.duration_ = 3.3

		local var_172_0 = {
			zh = 2.4,
			ja = 3.3
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
				arg_172_0:Play426081041(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = 0
			local var_175_1 = 0.325

			if var_175_0 < arg_172_1.time_ and arg_172_1.time_ <= var_175_0 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				local var_175_2 = arg_172_1:FormatText(StoryNameCfg[1491].name)

				arg_172_1.leftNameTxt_.text = var_175_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, true)
				arg_172_1.iconController_:SetSelectedState("hero")

				arg_172_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officerw")

				arg_172_1.callingController_:SetSelectedState("normal")

				arg_172_1.keyicon_.color = Color.New(1, 1, 1)
				arg_172_1.icon_.color = Color.New(1, 1, 1)

				local var_175_3 = arg_172_1:GetWordFromCfg(426081040)
				local var_175_4 = arg_172_1:FormatText(var_175_3.content)

				arg_172_1.text_.text = var_175_4

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_5 = 13
				local var_175_6 = utf8.len(var_175_4)
				local var_175_7 = var_175_5 <= 0 and var_175_1 or var_175_1 * (var_175_6 / var_175_5)

				if var_175_7 > 0 and var_175_1 < var_175_7 then
					arg_172_1.talkMaxDuration = var_175_7

					if var_175_7 + var_175_0 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_7 + var_175_0
					end
				end

				arg_172_1.text_.text = var_175_4
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426081", "426081040", "story_v_out_426081.awb") ~= 0 then
					local var_175_8 = manager.audio:GetVoiceLength("story_v_out_426081", "426081040", "story_v_out_426081.awb") / 1000

					if var_175_8 + var_175_0 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_8 + var_175_0
					end

					if var_175_3.prefab_name ~= "" and arg_172_1.actors_[var_175_3.prefab_name] ~= nil then
						local var_175_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_172_1.actors_[var_175_3.prefab_name].transform, "story_v_out_426081", "426081040", "story_v_out_426081.awb")

						arg_172_1:RecordAudio("426081040", var_175_9)
						arg_172_1:RecordAudio("426081040", var_175_9)
					else
						arg_172_1:AudioAction("play", "voice", "story_v_out_426081", "426081040", "story_v_out_426081.awb")
					end

					arg_172_1:RecordHistoryTalkVoice("story_v_out_426081", "426081040", "story_v_out_426081.awb")
				end

				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_10 = math.max(var_175_1, arg_172_1.talkMaxDuration)

			if var_175_0 <= arg_172_1.time_ and arg_172_1.time_ < var_175_0 + var_175_10 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_0) / var_175_10

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_0 + var_175_10 and arg_172_1.time_ < var_175_0 + var_175_10 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {}

		arg_172_1:InitPlayNodeList()
	end,
	Play426081041 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 426081041
		arg_176_1.duration_ = 2.97

		local var_176_0 = {
			zh = 2.966,
			ja = 1.333
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
				arg_176_0:Play426081042(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			local var_179_0 = 0
			local var_179_1 = 0.075

			if var_179_0 < arg_176_1.time_ and arg_176_1.time_ <= var_179_0 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				local var_179_2 = arg_176_1:FormatText(StoryNameCfg[1487].name)

				arg_176_1.leftNameTxt_.text = var_179_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, true)
				arg_176_1.iconController_:SetSelectedState("hero")

				arg_176_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1054")

				arg_176_1.callingController_:SetSelectedState("normal")

				arg_176_1.keyicon_.color = Color.New(1, 1, 1)
				arg_176_1.icon_.color = Color.New(1, 1, 1)

				local var_179_3 = arg_176_1:GetWordFromCfg(426081041)
				local var_179_4 = arg_176_1:FormatText(var_179_3.content)

				arg_176_1.text_.text = var_179_4

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_5 = 3
				local var_179_6 = utf8.len(var_179_4)
				local var_179_7 = var_179_5 <= 0 and var_179_1 or var_179_1 * (var_179_6 / var_179_5)

				if var_179_7 > 0 and var_179_1 < var_179_7 then
					arg_176_1.talkMaxDuration = var_179_7

					if var_179_7 + var_179_0 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_7 + var_179_0
					end
				end

				arg_176_1.text_.text = var_179_4
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426081", "426081041", "story_v_out_426081.awb") ~= 0 then
					local var_179_8 = manager.audio:GetVoiceLength("story_v_out_426081", "426081041", "story_v_out_426081.awb") / 1000

					if var_179_8 + var_179_0 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_8 + var_179_0
					end

					if var_179_3.prefab_name ~= "" and arg_176_1.actors_[var_179_3.prefab_name] ~= nil then
						local var_179_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_3.prefab_name].transform, "story_v_out_426081", "426081041", "story_v_out_426081.awb")

						arg_176_1:RecordAudio("426081041", var_179_9)
						arg_176_1:RecordAudio("426081041", var_179_9)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_out_426081", "426081041", "story_v_out_426081.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_out_426081", "426081041", "story_v_out_426081.awb")
				end

				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_10 = math.max(var_179_1, arg_176_1.talkMaxDuration)

			if var_179_0 <= arg_176_1.time_ and arg_176_1.time_ < var_179_0 + var_179_10 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_0) / var_179_10

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_0 + var_179_10 and arg_176_1.time_ < var_179_0 + var_179_10 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {}

		arg_176_1:InitPlayNodeList()
	end,
	Play426081042 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 426081042
		arg_180_1.duration_ = 3.2

		local var_180_0 = {
			zh = 2.633,
			ja = 3.2
		}
		local var_180_1 = manager.audio:GetLocalizationFlag()

		if var_180_0[var_180_1] ~= nil then
			arg_180_1.duration_ = var_180_0[var_180_1]
		end

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play426081043(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			local var_183_0 = arg_180_1.actors_["1054ui_story"]
			local var_183_1 = 0

			if var_183_1 < arg_180_1.time_ and arg_180_1.time_ <= var_183_1 + arg_183_0 and not isNil(var_183_0) and arg_180_1.var_.characterEffect1054ui_story == nil then
				arg_180_1.var_.characterEffect1054ui_story = var_183_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_183_2 = 0.200000002980232

			if var_183_1 <= arg_180_1.time_ and arg_180_1.time_ < var_183_1 + var_183_2 and not isNil(var_183_0) then
				local var_183_3 = (arg_180_1.time_ - var_183_1) / var_183_2

				if arg_180_1.var_.characterEffect1054ui_story and not isNil(var_183_0) then
					local var_183_4 = Mathf.Lerp(0, 0.5, var_183_3)

					arg_180_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_180_1.var_.characterEffect1054ui_story.fillRatio = var_183_4
				end
			end

			if arg_180_1.time_ >= var_183_1 + var_183_2 and arg_180_1.time_ < var_183_1 + var_183_2 + arg_183_0 and not isNil(var_183_0) and arg_180_1.var_.characterEffect1054ui_story then
				local var_183_5 = 0.5

				arg_180_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_180_1.var_.characterEffect1054ui_story.fillRatio = var_183_5
			end

			local var_183_6 = 0
			local var_183_7 = 0.35

			if var_183_6 < arg_180_1.time_ and arg_180_1.time_ <= var_183_6 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				local var_183_8 = arg_180_1:FormatText(StoryNameCfg[1491].name)

				arg_180_1.leftNameTxt_.text = var_183_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, true)
				arg_180_1.iconController_:SetSelectedState("hero")

				arg_180_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officerw")

				arg_180_1.callingController_:SetSelectedState("normal")

				arg_180_1.keyicon_.color = Color.New(1, 1, 1)
				arg_180_1.icon_.color = Color.New(1, 1, 1)

				local var_183_9 = arg_180_1:GetWordFromCfg(426081042)
				local var_183_10 = arg_180_1:FormatText(var_183_9.content)

				arg_180_1.text_.text = var_183_10

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_11 = 14
				local var_183_12 = utf8.len(var_183_10)
				local var_183_13 = var_183_11 <= 0 and var_183_7 or var_183_7 * (var_183_12 / var_183_11)

				if var_183_13 > 0 and var_183_7 < var_183_13 then
					arg_180_1.talkMaxDuration = var_183_13

					if var_183_13 + var_183_6 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_13 + var_183_6
					end
				end

				arg_180_1.text_.text = var_183_10
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426081", "426081042", "story_v_out_426081.awb") ~= 0 then
					local var_183_14 = manager.audio:GetVoiceLength("story_v_out_426081", "426081042", "story_v_out_426081.awb") / 1000

					if var_183_14 + var_183_6 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_14 + var_183_6
					end

					if var_183_9.prefab_name ~= "" and arg_180_1.actors_[var_183_9.prefab_name] ~= nil then
						local var_183_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_9.prefab_name].transform, "story_v_out_426081", "426081042", "story_v_out_426081.awb")

						arg_180_1:RecordAudio("426081042", var_183_15)
						arg_180_1:RecordAudio("426081042", var_183_15)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_out_426081", "426081042", "story_v_out_426081.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_out_426081", "426081042", "story_v_out_426081.awb")
				end

				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_16 = math.max(var_183_7, arg_180_1.talkMaxDuration)

			if var_183_6 <= arg_180_1.time_ and arg_180_1.time_ < var_183_6 + var_183_16 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_6) / var_183_16

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_6 + var_183_16 and arg_180_1.time_ < var_183_6 + var_183_16 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {}

		arg_180_1:InitPlayNodeList()
	end,
	Play426081043 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 426081043
		arg_184_1.duration_ = 5.6

		local var_184_0 = {
			zh = 3.4,
			ja = 5.6
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
				arg_184_0:Play426081044(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			local var_187_0 = 0
			local var_187_1 = 0.4

			if var_187_0 < arg_184_1.time_ and arg_184_1.time_ <= var_187_0 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				local var_187_2 = arg_184_1:FormatText(StoryNameCfg[1491].name)

				arg_184_1.leftNameTxt_.text = var_187_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, true)
				arg_184_1.iconController_:SetSelectedState("hero")

				arg_184_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officerw")

				arg_184_1.callingController_:SetSelectedState("normal")

				arg_184_1.keyicon_.color = Color.New(1, 1, 1)
				arg_184_1.icon_.color = Color.New(1, 1, 1)

				local var_187_3 = arg_184_1:GetWordFromCfg(426081043)
				local var_187_4 = arg_184_1:FormatText(var_187_3.content)

				arg_184_1.text_.text = var_187_4

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_5 = 16
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

				if manager.audio:GetVoiceLength("story_v_out_426081", "426081043", "story_v_out_426081.awb") ~= 0 then
					local var_187_8 = manager.audio:GetVoiceLength("story_v_out_426081", "426081043", "story_v_out_426081.awb") / 1000

					if var_187_8 + var_187_0 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_8 + var_187_0
					end

					if var_187_3.prefab_name ~= "" and arg_184_1.actors_[var_187_3.prefab_name] ~= nil then
						local var_187_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_184_1.actors_[var_187_3.prefab_name].transform, "story_v_out_426081", "426081043", "story_v_out_426081.awb")

						arg_184_1:RecordAudio("426081043", var_187_9)
						arg_184_1:RecordAudio("426081043", var_187_9)
					else
						arg_184_1:AudioAction("play", "voice", "story_v_out_426081", "426081043", "story_v_out_426081.awb")
					end

					arg_184_1:RecordHistoryTalkVoice("story_v_out_426081", "426081043", "story_v_out_426081.awb")
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
	Play426081044 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 426081044
		arg_188_1.duration_ = 5

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play426081045(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			local var_191_0 = arg_188_1.actors_["1054ui_story"].transform
			local var_191_1 = 0

			if var_191_1 < arg_188_1.time_ and arg_188_1.time_ <= var_191_1 + arg_191_0 then
				arg_188_1.var_.moveOldPos1054ui_story = var_191_0.localPosition

				local var_191_2 = GameObjectTools.GetOrAddComponent(var_191_0.gameObject, typeof(DynamicBoneHelper))

				if var_191_2 then
					var_191_2:EnableDynamicBone(false)
				end
			end

			local var_191_3 = 0.001

			if var_191_1 <= arg_188_1.time_ and arg_188_1.time_ < var_191_1 + var_191_3 then
				local var_191_4 = (arg_188_1.time_ - var_191_1) / var_191_3
				local var_191_5 = Vector3.New(0, 100, 0)

				var_191_0.localPosition = Vector3.Lerp(arg_188_1.var_.moveOldPos1054ui_story, var_191_5, var_191_4)

				local var_191_6 = manager.ui.mainCamera.transform.position - var_191_0.position

				var_191_0.forward = Vector3.New(var_191_6.x, var_191_6.y, var_191_6.z)

				local var_191_7 = var_191_0.localEulerAngles

				var_191_7.z = 0
				var_191_7.x = 0
				var_191_0.localEulerAngles = var_191_7
			end

			if arg_188_1.time_ >= var_191_1 + var_191_3 and arg_188_1.time_ < var_191_1 + var_191_3 + arg_191_0 then
				var_191_0.localPosition = Vector3.New(0, 100, 0)

				local var_191_8 = manager.ui.mainCamera.transform.position - var_191_0.position

				var_191_0.forward = Vector3.New(var_191_8.x, var_191_8.y, var_191_8.z)

				local var_191_9 = var_191_0.localEulerAngles

				var_191_9.z = 0
				var_191_9.x = 0
				var_191_0.localEulerAngles = var_191_9

				local var_191_10 = GameObjectTools.GetOrAddComponent(var_191_0.gameObject, typeof(DynamicBoneHelper))

				if var_191_10 then
					var_191_10:EnableDynamicBone(true)
				end
			end

			local var_191_11 = 0
			local var_191_12 = 1.25

			if var_191_11 < arg_188_1.time_ and arg_188_1.time_ <= var_191_11 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, false)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_13 = arg_188_1:GetWordFromCfg(426081044)
				local var_191_14 = arg_188_1:FormatText(var_191_13.content)

				arg_188_1.text_.text = var_191_14

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_15 = 50
				local var_191_16 = utf8.len(var_191_14)
				local var_191_17 = var_191_15 <= 0 and var_191_12 or var_191_12 * (var_191_16 / var_191_15)

				if var_191_17 > 0 and var_191_12 < var_191_17 then
					arg_188_1.talkMaxDuration = var_191_17

					if var_191_17 + var_191_11 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_17 + var_191_11
					end
				end

				arg_188_1.text_.text = var_191_14
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)
				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_18 = math.max(var_191_12, arg_188_1.talkMaxDuration)

			if var_191_11 <= arg_188_1.time_ and arg_188_1.time_ < var_191_11 + var_191_18 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_11) / var_191_18

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_11 + var_191_18 and arg_188_1.time_ < var_191_11 + var_191_18 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
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
	Play426081045 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 426081045
		arg_192_1.duration_ = 5

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play426081046(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			local var_195_0 = 0
			local var_195_1 = 0.875

			if var_195_0 < arg_192_1.time_ and arg_192_1.time_ <= var_195_0 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, false)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_192_1.iconTrs_.gameObject, false)
				arg_192_1.callingController_:SetSelectedState("normal")

				local var_195_2 = arg_192_1:GetWordFromCfg(426081045)
				local var_195_3 = arg_192_1:FormatText(var_195_2.content)

				arg_192_1.text_.text = var_195_3

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_4 = 35
				local var_195_5 = utf8.len(var_195_3)
				local var_195_6 = var_195_4 <= 0 and var_195_1 or var_195_1 * (var_195_5 / var_195_4)

				if var_195_6 > 0 and var_195_1 < var_195_6 then
					arg_192_1.talkMaxDuration = var_195_6

					if var_195_6 + var_195_0 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_6 + var_195_0
					end
				end

				arg_192_1.text_.text = var_195_3
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)
				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_7 = math.max(var_195_1, arg_192_1.talkMaxDuration)

			if var_195_0 <= arg_192_1.time_ and arg_192_1.time_ < var_195_0 + var_195_7 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_0) / var_195_7

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_0 + var_195_7 and arg_192_1.time_ < var_195_0 + var_195_7 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {}

		arg_192_1:InitPlayNodeList()
	end,
	Play426081046 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 426081046
		arg_196_1.duration_ = 9.43

		local var_196_0 = {
			zh = 5.8,
			ja = 9.433
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
				arg_196_0:Play426081047(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			local var_199_0 = 0
			local var_199_1 = 0.85

			if var_199_0 < arg_196_1.time_ and arg_196_1.time_ <= var_199_0 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, true)

				local var_199_2 = arg_196_1:FormatText(StoryNameCfg[1492].name)

				arg_196_1.leftNameTxt_.text = var_199_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, true)
				arg_196_1.iconController_:SetSelectedState("hero")

				arg_196_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_researchera")

				arg_196_1.callingController_:SetSelectedState("normal")

				arg_196_1.keyicon_.color = Color.New(1, 1, 1)
				arg_196_1.icon_.color = Color.New(1, 1, 1)

				local var_199_3 = arg_196_1:GetWordFromCfg(426081046)
				local var_199_4 = arg_196_1:FormatText(var_199_3.content)

				arg_196_1.text_.text = var_199_4

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_5 = 34
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

				if manager.audio:GetVoiceLength("story_v_out_426081", "426081046", "story_v_out_426081.awb") ~= 0 then
					local var_199_8 = manager.audio:GetVoiceLength("story_v_out_426081", "426081046", "story_v_out_426081.awb") / 1000

					if var_199_8 + var_199_0 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_8 + var_199_0
					end

					if var_199_3.prefab_name ~= "" and arg_196_1.actors_[var_199_3.prefab_name] ~= nil then
						local var_199_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_196_1.actors_[var_199_3.prefab_name].transform, "story_v_out_426081", "426081046", "story_v_out_426081.awb")

						arg_196_1:RecordAudio("426081046", var_199_9)
						arg_196_1:RecordAudio("426081046", var_199_9)
					else
						arg_196_1:AudioAction("play", "voice", "story_v_out_426081", "426081046", "story_v_out_426081.awb")
					end

					arg_196_1:RecordHistoryTalkVoice("story_v_out_426081", "426081046", "story_v_out_426081.awb")
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
	Play426081047 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 426081047
		arg_200_1.duration_ = 5.7

		local var_200_0 = {
			zh = 5.466,
			ja = 5.7
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
				arg_200_0:Play426081048(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			local var_203_0 = 0
			local var_203_1 = 0.8

			if var_203_0 < arg_200_1.time_ and arg_200_1.time_ <= var_203_0 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, true)

				local var_203_2 = arg_200_1:FormatText(StoryNameCfg[1492].name)

				arg_200_1.leftNameTxt_.text = var_203_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_200_1.leftNameTxt_.transform)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1.leftNameTxt_.text)
				SetActive(arg_200_1.iconTrs_.gameObject, true)
				arg_200_1.iconController_:SetSelectedState("hero")

				arg_200_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_researchera")

				arg_200_1.callingController_:SetSelectedState("normal")

				arg_200_1.keyicon_.color = Color.New(1, 1, 1)
				arg_200_1.icon_.color = Color.New(1, 1, 1)

				local var_203_3 = arg_200_1:GetWordFromCfg(426081047)
				local var_203_4 = arg_200_1:FormatText(var_203_3.content)

				arg_200_1.text_.text = var_203_4

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_5 = 32
				local var_203_6 = utf8.len(var_203_4)
				local var_203_7 = var_203_5 <= 0 and var_203_1 or var_203_1 * (var_203_6 / var_203_5)

				if var_203_7 > 0 and var_203_1 < var_203_7 then
					arg_200_1.talkMaxDuration = var_203_7

					if var_203_7 + var_203_0 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_7 + var_203_0
					end
				end

				arg_200_1.text_.text = var_203_4
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426081", "426081047", "story_v_out_426081.awb") ~= 0 then
					local var_203_8 = manager.audio:GetVoiceLength("story_v_out_426081", "426081047", "story_v_out_426081.awb") / 1000

					if var_203_8 + var_203_0 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_8 + var_203_0
					end

					if var_203_3.prefab_name ~= "" and arg_200_1.actors_[var_203_3.prefab_name] ~= nil then
						local var_203_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_200_1.actors_[var_203_3.prefab_name].transform, "story_v_out_426081", "426081047", "story_v_out_426081.awb")

						arg_200_1:RecordAudio("426081047", var_203_9)
						arg_200_1:RecordAudio("426081047", var_203_9)
					else
						arg_200_1:AudioAction("play", "voice", "story_v_out_426081", "426081047", "story_v_out_426081.awb")
					end

					arg_200_1:RecordHistoryTalkVoice("story_v_out_426081", "426081047", "story_v_out_426081.awb")
				end

				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_10 = math.max(var_203_1, arg_200_1.talkMaxDuration)

			if var_203_0 <= arg_200_1.time_ and arg_200_1.time_ < var_203_0 + var_203_10 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_0) / var_203_10

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_0 + var_203_10 and arg_200_1.time_ < var_203_0 + var_203_10 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {}

		arg_200_1:InitPlayNodeList()
	end,
	Play426081048 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 426081048
		arg_204_1.duration_ = 5

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play426081049(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			local var_207_0 = 0
			local var_207_1 = 0.9

			if var_207_0 < arg_204_1.time_ and arg_204_1.time_ <= var_207_0 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0

				arg_204_1.dialog_:SetActive(true)

				arg_204_1.dialogCg_.alpha = 0

				local var_207_2 = LeanTween.value(arg_204_1.dialog_, 0, 1, 0.3)

				var_207_2:setOnUpdate(LuaHelper.FloatAction(function(arg_208_0)
					arg_204_1.dialogCg_.alpha = arg_208_0
				end))
				var_207_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_204_1.dialog_)
					var_207_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_204_1.duration_ = arg_204_1.duration_ + 0.3

				SetActive(arg_204_1.leftNameGo_, false)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_204_1.iconTrs_.gameObject, false)
				arg_204_1.callingController_:SetSelectedState("normal")

				local var_207_3 = arg_204_1:GetWordFromCfg(426081048)
				local var_207_4 = arg_204_1:FormatText(var_207_3.content)

				arg_204_1.text_.text = var_207_4

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_5 = 36
				local var_207_6 = utf8.len(var_207_4)
				local var_207_7 = var_207_5 <= 0 and var_207_1 or var_207_1 * (var_207_6 / var_207_5)

				if var_207_7 > 0 and var_207_1 < var_207_7 then
					arg_204_1.talkMaxDuration = var_207_7
					var_207_0 = var_207_0 + 0.3

					if var_207_7 + var_207_0 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_7 + var_207_0
					end
				end

				arg_204_1.text_.text = var_207_4
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)
				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_8 = var_207_0 + 0.3
			local var_207_9 = math.max(var_207_1, arg_204_1.talkMaxDuration)

			if var_207_8 <= arg_204_1.time_ and arg_204_1.time_ < var_207_8 + var_207_9 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_8) / var_207_9

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_8 + var_207_9 and arg_204_1.time_ < var_207_8 + var_207_9 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {}

		arg_204_1:InitPlayNodeList()
	end,
	Play426081049 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 426081049
		arg_210_1.duration_ = 5

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play426081050(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			local var_213_0 = 0
			local var_213_1 = 0.55

			if var_213_0 < arg_210_1.time_ and arg_210_1.time_ <= var_213_0 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, false)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_2 = arg_210_1:GetWordFromCfg(426081049)
				local var_213_3 = arg_210_1:FormatText(var_213_2.content)

				arg_210_1.text_.text = var_213_3

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_4 = 22
				local var_213_5 = utf8.len(var_213_3)
				local var_213_6 = var_213_4 <= 0 and var_213_1 or var_213_1 * (var_213_5 / var_213_4)

				if var_213_6 > 0 and var_213_1 < var_213_6 then
					arg_210_1.talkMaxDuration = var_213_6

					if var_213_6 + var_213_0 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_6 + var_213_0
					end
				end

				arg_210_1.text_.text = var_213_3
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)
				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_7 = math.max(var_213_1, arg_210_1.talkMaxDuration)

			if var_213_0 <= arg_210_1.time_ and arg_210_1.time_ < var_213_0 + var_213_7 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_0) / var_213_7

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_0 + var_213_7 and arg_210_1.time_ < var_213_0 + var_213_7 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {}

		arg_210_1:InitPlayNodeList()
	end,
	Play426081050 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 426081050
		arg_214_1.duration_ = 1.37

		local var_214_0 = {
			zh = 1.166,
			ja = 1.366
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
				arg_214_0:Play426081051(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			local var_217_0 = 0
			local var_217_1 = 0.125

			if var_217_0 < arg_214_1.time_ and arg_214_1.time_ <= var_217_0 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				local var_217_2 = arg_214_1:FormatText(StoryNameCfg[1492].name)

				arg_214_1.leftNameTxt_.text = var_217_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, true)
				arg_214_1.iconController_:SetSelectedState("hero")

				arg_214_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_researchera")

				arg_214_1.callingController_:SetSelectedState("normal")

				arg_214_1.keyicon_.color = Color.New(1, 1, 1)
				arg_214_1.icon_.color = Color.New(1, 1, 1)

				local var_217_3 = arg_214_1:GetWordFromCfg(426081050)
				local var_217_4 = arg_214_1:FormatText(var_217_3.content)

				arg_214_1.text_.text = var_217_4

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_5 = 5
				local var_217_6 = utf8.len(var_217_4)
				local var_217_7 = var_217_5 <= 0 and var_217_1 or var_217_1 * (var_217_6 / var_217_5)

				if var_217_7 > 0 and var_217_1 < var_217_7 then
					arg_214_1.talkMaxDuration = var_217_7

					if var_217_7 + var_217_0 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_7 + var_217_0
					end
				end

				arg_214_1.text_.text = var_217_4
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426081", "426081050", "story_v_out_426081.awb") ~= 0 then
					local var_217_8 = manager.audio:GetVoiceLength("story_v_out_426081", "426081050", "story_v_out_426081.awb") / 1000

					if var_217_8 + var_217_0 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_8 + var_217_0
					end

					if var_217_3.prefab_name ~= "" and arg_214_1.actors_[var_217_3.prefab_name] ~= nil then
						local var_217_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_214_1.actors_[var_217_3.prefab_name].transform, "story_v_out_426081", "426081050", "story_v_out_426081.awb")

						arg_214_1:RecordAudio("426081050", var_217_9)
						arg_214_1:RecordAudio("426081050", var_217_9)
					else
						arg_214_1:AudioAction("play", "voice", "story_v_out_426081", "426081050", "story_v_out_426081.awb")
					end

					arg_214_1:RecordHistoryTalkVoice("story_v_out_426081", "426081050", "story_v_out_426081.awb")
				end

				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_10 = math.max(var_217_1, arg_214_1.talkMaxDuration)

			if var_217_0 <= arg_214_1.time_ and arg_214_1.time_ < var_217_0 + var_217_10 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_0) / var_217_10

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_0 + var_217_10 and arg_214_1.time_ < var_217_0 + var_217_10 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {}

		arg_214_1:InitPlayNodeList()
	end,
	Play426081051 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 426081051
		arg_218_1.duration_ = 8.2

		local var_218_0 = {
			zh = 3.8,
			ja = 8.2
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
				arg_218_0:Play426081052(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			local var_221_0 = "1012ui_story"

			if arg_218_1.actors_[var_221_0] == nil then
				local var_221_1 = Asset.Load("Char/" .. "1012ui_story")

				if not isNil(var_221_1) then
					local var_221_2 = Object.Instantiate(Asset.Load("Char/" .. "1012ui_story"), arg_218_1.stage_.transform)

					var_221_2.name = var_221_0
					var_221_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_218_1.actors_[var_221_0] = var_221_2

					local var_221_3 = var_221_2:GetComponentInChildren(typeof(CharacterEffect))

					var_221_3.enabled = true

					local var_221_4 = GameObjectTools.GetOrAddComponent(var_221_2, typeof(DynamicBoneHelper))

					if var_221_4 then
						var_221_4:EnableDynamicBone(false)
					end

					arg_218_1:ShowWeapon(var_221_3.transform, false)

					arg_218_1.var_[var_221_0 .. "Animator"] = var_221_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_218_1.var_[var_221_0 .. "Animator"].applyRootMotion = true
					arg_218_1.var_[var_221_0 .. "LipSync"] = var_221_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_221_5 = arg_218_1.actors_["1012ui_story"].transform
			local var_221_6 = 0

			if var_221_6 < arg_218_1.time_ and arg_218_1.time_ <= var_221_6 + arg_221_0 then
				arg_218_1.var_.moveOldPos1012ui_story = var_221_5.localPosition
			end

			local var_221_7 = 0.001

			if var_221_6 <= arg_218_1.time_ and arg_218_1.time_ < var_221_6 + var_221_7 then
				local var_221_8 = (arg_218_1.time_ - var_221_6) / var_221_7
				local var_221_9 = Vector3.New(0, -1.05, -6.24)

				var_221_5.localPosition = Vector3.Lerp(arg_218_1.var_.moveOldPos1012ui_story, var_221_9, var_221_8)

				local var_221_10 = manager.ui.mainCamera.transform.position - var_221_5.position

				var_221_5.forward = Vector3.New(var_221_10.x, var_221_10.y, var_221_10.z)

				local var_221_11 = var_221_5.localEulerAngles

				var_221_11.z = 0
				var_221_11.x = 0
				var_221_5.localEulerAngles = var_221_11
			end

			if arg_218_1.time_ >= var_221_6 + var_221_7 and arg_218_1.time_ < var_221_6 + var_221_7 + arg_221_0 then
				var_221_5.localPosition = Vector3.New(0, -1.05, -6.24)

				local var_221_12 = manager.ui.mainCamera.transform.position - var_221_5.position

				var_221_5.forward = Vector3.New(var_221_12.x, var_221_12.y, var_221_12.z)

				local var_221_13 = var_221_5.localEulerAngles

				var_221_13.z = 0
				var_221_13.x = 0
				var_221_5.localEulerAngles = var_221_13
			end

			local var_221_14 = arg_218_1.actors_["1012ui_story"]
			local var_221_15 = 0

			if var_221_15 < arg_218_1.time_ and arg_218_1.time_ <= var_221_15 + arg_221_0 and not isNil(var_221_14) and arg_218_1.var_.characterEffect1012ui_story == nil then
				arg_218_1.var_.characterEffect1012ui_story = var_221_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_221_16 = 0.200000002980232

			if var_221_15 <= arg_218_1.time_ and arg_218_1.time_ < var_221_15 + var_221_16 and not isNil(var_221_14) then
				local var_221_17 = (arg_218_1.time_ - var_221_15) / var_221_16

				if arg_218_1.var_.characterEffect1012ui_story and not isNil(var_221_14) then
					arg_218_1.var_.characterEffect1012ui_story.fillFlat = false
				end
			end

			if arg_218_1.time_ >= var_221_15 + var_221_16 and arg_218_1.time_ < var_221_15 + var_221_16 + arg_221_0 and not isNil(var_221_14) and arg_218_1.var_.characterEffect1012ui_story then
				arg_218_1.var_.characterEffect1012ui_story.fillFlat = false
			end

			local var_221_18 = 0

			if var_221_18 < arg_218_1.time_ and arg_218_1.time_ <= var_221_18 + arg_221_0 then
				arg_218_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012action/1012action1_1")
			end

			local var_221_19 = 0

			if var_221_19 < arg_218_1.time_ and arg_218_1.time_ <= var_221_19 + arg_221_0 then
				arg_218_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_221_20 = 0
			local var_221_21 = 0.55

			if var_221_20 < arg_218_1.time_ and arg_218_1.time_ <= var_221_20 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				local var_221_22 = arg_218_1:FormatText(StoryNameCfg[595].name)

				arg_218_1.leftNameTxt_.text = var_221_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_23 = arg_218_1:GetWordFromCfg(426081051)
				local var_221_24 = arg_218_1:FormatText(var_221_23.content)

				arg_218_1.text_.text = var_221_24

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_25 = 22
				local var_221_26 = utf8.len(var_221_24)
				local var_221_27 = var_221_25 <= 0 and var_221_21 or var_221_21 * (var_221_26 / var_221_25)

				if var_221_27 > 0 and var_221_21 < var_221_27 then
					arg_218_1.talkMaxDuration = var_221_27

					if var_221_27 + var_221_20 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_27 + var_221_20
					end
				end

				arg_218_1.text_.text = var_221_24
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426081", "426081051", "story_v_out_426081.awb") ~= 0 then
					local var_221_28 = manager.audio:GetVoiceLength("story_v_out_426081", "426081051", "story_v_out_426081.awb") / 1000

					if var_221_28 + var_221_20 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_28 + var_221_20
					end

					if var_221_23.prefab_name ~= "" and arg_218_1.actors_[var_221_23.prefab_name] ~= nil then
						local var_221_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_218_1.actors_[var_221_23.prefab_name].transform, "story_v_out_426081", "426081051", "story_v_out_426081.awb")

						arg_218_1:RecordAudio("426081051", var_221_29)
						arg_218_1:RecordAudio("426081051", var_221_29)
					else
						arg_218_1:AudioAction("play", "voice", "story_v_out_426081", "426081051", "story_v_out_426081.awb")
					end

					arg_218_1:RecordHistoryTalkVoice("story_v_out_426081", "426081051", "story_v_out_426081.awb")
				end

				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_30 = math.max(var_221_21, arg_218_1.talkMaxDuration)

			if var_221_20 <= arg_218_1.time_ and arg_218_1.time_ < var_221_20 + var_221_30 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_20) / var_221_30

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_20 + var_221_30 and arg_218_1.time_ < var_221_20 + var_221_30 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_218_1:InitPlayNodeList()
	end,
	Play426081052 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 426081052
		arg_222_1.duration_ = 5

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play426081053(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			local var_225_0 = arg_222_1.actors_["1012ui_story"].transform
			local var_225_1 = 0

			if var_225_1 < arg_222_1.time_ and arg_222_1.time_ <= var_225_1 + arg_225_0 then
				arg_222_1.var_.moveOldPos1012ui_story = var_225_0.localPosition
			end

			local var_225_2 = 0.001

			if var_225_1 <= arg_222_1.time_ and arg_222_1.time_ < var_225_1 + var_225_2 then
				local var_225_3 = (arg_222_1.time_ - var_225_1) / var_225_2
				local var_225_4 = Vector3.New(0, 100, 0)

				var_225_0.localPosition = Vector3.Lerp(arg_222_1.var_.moveOldPos1012ui_story, var_225_4, var_225_3)

				local var_225_5 = manager.ui.mainCamera.transform.position - var_225_0.position

				var_225_0.forward = Vector3.New(var_225_5.x, var_225_5.y, var_225_5.z)

				local var_225_6 = var_225_0.localEulerAngles

				var_225_6.z = 0
				var_225_6.x = 0
				var_225_0.localEulerAngles = var_225_6
			end

			if arg_222_1.time_ >= var_225_1 + var_225_2 and arg_222_1.time_ < var_225_1 + var_225_2 + arg_225_0 then
				var_225_0.localPosition = Vector3.New(0, 100, 0)

				local var_225_7 = manager.ui.mainCamera.transform.position - var_225_0.position

				var_225_0.forward = Vector3.New(var_225_7.x, var_225_7.y, var_225_7.z)

				local var_225_8 = var_225_0.localEulerAngles

				var_225_8.z = 0
				var_225_8.x = 0
				var_225_0.localEulerAngles = var_225_8
			end

			local var_225_9 = arg_222_1.actors_["1012ui_story"]
			local var_225_10 = 0

			if var_225_10 < arg_222_1.time_ and arg_222_1.time_ <= var_225_10 + arg_225_0 and not isNil(var_225_9) and arg_222_1.var_.characterEffect1012ui_story == nil then
				arg_222_1.var_.characterEffect1012ui_story = var_225_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_225_11 = 0.200000002980232

			if var_225_10 <= arg_222_1.time_ and arg_222_1.time_ < var_225_10 + var_225_11 and not isNil(var_225_9) then
				local var_225_12 = (arg_222_1.time_ - var_225_10) / var_225_11

				if arg_222_1.var_.characterEffect1012ui_story and not isNil(var_225_9) then
					local var_225_13 = Mathf.Lerp(0, 0.5, var_225_12)

					arg_222_1.var_.characterEffect1012ui_story.fillFlat = true
					arg_222_1.var_.characterEffect1012ui_story.fillRatio = var_225_13
				end
			end

			if arg_222_1.time_ >= var_225_10 + var_225_11 and arg_222_1.time_ < var_225_10 + var_225_11 + arg_225_0 and not isNil(var_225_9) and arg_222_1.var_.characterEffect1012ui_story then
				local var_225_14 = 0.5

				arg_222_1.var_.characterEffect1012ui_story.fillFlat = true
				arg_222_1.var_.characterEffect1012ui_story.fillRatio = var_225_14
			end

			local var_225_15 = 0
			local var_225_16 = 0.55

			if var_225_15 < arg_222_1.time_ and arg_222_1.time_ <= var_225_15 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, false)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_17 = arg_222_1:GetWordFromCfg(426081052)
				local var_225_18 = arg_222_1:FormatText(var_225_17.content)

				arg_222_1.text_.text = var_225_18

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_19 = 22
				local var_225_20 = utf8.len(var_225_18)
				local var_225_21 = var_225_19 <= 0 and var_225_16 or var_225_16 * (var_225_20 / var_225_19)

				if var_225_21 > 0 and var_225_16 < var_225_21 then
					arg_222_1.talkMaxDuration = var_225_21

					if var_225_21 + var_225_15 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_21 + var_225_15
					end
				end

				arg_222_1.text_.text = var_225_18
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)
				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_22 = math.max(var_225_16, arg_222_1.talkMaxDuration)

			if var_225_15 <= arg_222_1.time_ and arg_222_1.time_ < var_225_15 + var_225_22 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_15) / var_225_22

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_15 + var_225_22 and arg_222_1.time_ < var_225_15 + var_225_22 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012ui_story",
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
	Play426081053 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 426081053
		arg_226_1.duration_ = 5

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play426081054(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			local var_229_0 = 0
			local var_229_1 = 0.525

			if var_229_0 < arg_226_1.time_ and arg_226_1.time_ <= var_229_0 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				local var_229_2 = arg_226_1:FormatText(StoryNameCfg[7].name)

				arg_226_1.leftNameTxt_.text = var_229_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, true)
				arg_226_1.iconController_:SetSelectedState("hero")

				arg_226_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_226_1.callingController_:SetSelectedState("normal")

				arg_226_1.keyicon_.color = Color.New(1, 1, 1)
				arg_226_1.icon_.color = Color.New(1, 1, 1)

				local var_229_3 = arg_226_1:GetWordFromCfg(426081053)
				local var_229_4 = arg_226_1:FormatText(var_229_3.content)

				arg_226_1.text_.text = var_229_4

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_5 = 21
				local var_229_6 = utf8.len(var_229_4)
				local var_229_7 = var_229_5 <= 0 and var_229_1 or var_229_1 * (var_229_6 / var_229_5)

				if var_229_7 > 0 and var_229_1 < var_229_7 then
					arg_226_1.talkMaxDuration = var_229_7

					if var_229_7 + var_229_0 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_7 + var_229_0
					end
				end

				arg_226_1.text_.text = var_229_4
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)
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
	Play426081054 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 426081054
		arg_230_1.duration_ = 9

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play426081055(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			local var_233_0 = "ST07a"

			if arg_230_1.bgs_[var_233_0] == nil then
				local var_233_1 = Object.Instantiate(arg_230_1.paintGo_)

				var_233_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_233_0)
				var_233_1.name = var_233_0
				var_233_1.transform.parent = arg_230_1.stage_.transform
				var_233_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_230_1.bgs_[var_233_0] = var_233_1
			end

			local var_233_2 = 2

			if var_233_2 < arg_230_1.time_ and arg_230_1.time_ <= var_233_2 + arg_233_0 then
				local var_233_3 = manager.ui.mainCamera.transform.localPosition
				local var_233_4 = Vector3.New(0, 0, 10) + Vector3.New(var_233_3.x, var_233_3.y, 0)
				local var_233_5 = arg_230_1.bgs_.ST07a

				var_233_5.transform.localPosition = var_233_4
				var_233_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_233_6 = var_233_5:GetComponent("SpriteRenderer")

				if var_233_6 and var_233_6.sprite then
					local var_233_7 = (var_233_5.transform.localPosition - var_233_3).z
					local var_233_8 = manager.ui.mainCameraCom_
					local var_233_9 = 2 * var_233_7 * Mathf.Tan(var_233_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_233_10 = var_233_9 * var_233_8.aspect
					local var_233_11 = var_233_6.sprite.bounds.size.x
					local var_233_12 = var_233_6.sprite.bounds.size.y
					local var_233_13 = var_233_10 / var_233_11
					local var_233_14 = var_233_9 / var_233_12
					local var_233_15 = var_233_14 < var_233_13 and var_233_13 or var_233_14

					var_233_5.transform.localScale = Vector3.New(var_233_15, var_233_15, 0)
				end

				for iter_233_0, iter_233_1 in pairs(arg_230_1.bgs_) do
					if iter_233_0 ~= "ST07a" then
						iter_233_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_233_16 = 4

			if var_233_16 < arg_230_1.time_ and arg_230_1.time_ <= var_233_16 + arg_233_0 then
				arg_230_1.allBtn_.enabled = false
			end

			local var_233_17 = 0.3

			if arg_230_1.time_ >= var_233_16 + var_233_17 and arg_230_1.time_ < var_233_16 + var_233_17 + arg_233_0 then
				arg_230_1.allBtn_.enabled = true
			end

			local var_233_18 = 0

			if var_233_18 < arg_230_1.time_ and arg_230_1.time_ <= var_233_18 + arg_233_0 then
				arg_230_1.mask_.enabled = true
				arg_230_1.mask_.raycastTarget = true

				arg_230_1:SetGaussion(false)
			end

			local var_233_19 = 2

			if var_233_18 <= arg_230_1.time_ and arg_230_1.time_ < var_233_18 + var_233_19 then
				local var_233_20 = (arg_230_1.time_ - var_233_18) / var_233_19
				local var_233_21 = Color.New(0, 0, 0)

				var_233_21.a = Mathf.Lerp(0, 1, var_233_20)
				arg_230_1.mask_.color = var_233_21
			end

			if arg_230_1.time_ >= var_233_18 + var_233_19 and arg_230_1.time_ < var_233_18 + var_233_19 + arg_233_0 then
				local var_233_22 = Color.New(0, 0, 0)

				var_233_22.a = 1
				arg_230_1.mask_.color = var_233_22
			end

			local var_233_23 = 2

			if var_233_23 < arg_230_1.time_ and arg_230_1.time_ <= var_233_23 + arg_233_0 then
				arg_230_1.mask_.enabled = true
				arg_230_1.mask_.raycastTarget = true

				arg_230_1:SetGaussion(false)
			end

			local var_233_24 = 2

			if var_233_23 <= arg_230_1.time_ and arg_230_1.time_ < var_233_23 + var_233_24 then
				local var_233_25 = (arg_230_1.time_ - var_233_23) / var_233_24
				local var_233_26 = Color.New(0, 0, 0)

				var_233_26.a = Mathf.Lerp(1, 0, var_233_25)
				arg_230_1.mask_.color = var_233_26
			end

			if arg_230_1.time_ >= var_233_23 + var_233_24 and arg_230_1.time_ < var_233_23 + var_233_24 + arg_233_0 then
				local var_233_27 = Color.New(0, 0, 0)
				local var_233_28 = 0

				arg_230_1.mask_.enabled = false
				var_233_27.a = var_233_28
				arg_230_1.mask_.color = var_233_27
			end

			local var_233_29 = 2.30833333333333
			local var_233_30 = 1

			if var_233_29 < arg_230_1.time_ and arg_230_1.time_ <= var_233_29 + arg_233_0 then
				local var_233_31 = "stop"
				local var_233_32 = "effect"

				arg_230_1:AudioAction(var_233_31, var_233_32, "se_story_side_1049", "se_story_side_1049_amb_room", "")
			end

			local var_233_33 = 3
			local var_233_34 = 1

			if var_233_33 < arg_230_1.time_ and arg_230_1.time_ <= var_233_33 + arg_233_0 then
				local var_233_35 = "play"
				local var_233_36 = "effect"

				arg_230_1:AudioAction(var_233_35, var_233_36, "se_story_side_1020", "se_story_side_1020_amb_office", "")
			end

			if arg_230_1.frameCnt_ <= 1 then
				arg_230_1.dialog_:SetActive(false)
			end

			local var_233_37 = 4
			local var_233_38 = 0.825

			if var_233_37 < arg_230_1.time_ and arg_230_1.time_ <= var_233_37 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0

				arg_230_1.dialog_:SetActive(true)

				arg_230_1.dialogCg_.alpha = 0

				local var_233_39 = LeanTween.value(arg_230_1.dialog_, 0, 1, 0.3)

				var_233_39:setOnUpdate(LuaHelper.FloatAction(function(arg_234_0)
					arg_230_1.dialogCg_.alpha = arg_234_0
				end))
				var_233_39:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_230_1.dialog_)
					var_233_39:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_230_1.duration_ = arg_230_1.duration_ + 0.3

				SetActive(arg_230_1.leftNameGo_, false)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_40 = arg_230_1:GetWordFromCfg(426081054)
				local var_233_41 = arg_230_1:FormatText(var_233_40.content)

				arg_230_1.text_.text = var_233_41

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_42 = 33
				local var_233_43 = utf8.len(var_233_41)
				local var_233_44 = var_233_42 <= 0 and var_233_38 or var_233_38 * (var_233_43 / var_233_42)

				if var_233_44 > 0 and var_233_38 < var_233_44 then
					arg_230_1.talkMaxDuration = var_233_44
					var_233_37 = var_233_37 + 0.3

					if var_233_44 + var_233_37 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_44 + var_233_37
					end
				end

				arg_230_1.text_.text = var_233_41
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)
				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_45 = var_233_37 + 0.3
			local var_233_46 = math.max(var_233_38, arg_230_1.talkMaxDuration)

			if var_233_45 <= arg_230_1.time_ and arg_230_1.time_ < var_233_45 + var_233_46 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_45) / var_233_46

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_45 + var_233_46 and arg_230_1.time_ < var_233_45 + var_233_46 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {}

		arg_230_1:InitPlayNodeList()
	end,
	Play426081055 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 426081055
		arg_236_1.duration_ = 6.5

		local var_236_0 = {
			zh = 3.5,
			ja = 6.5
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
				arg_236_0:Play426081056(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			local var_239_0 = arg_236_1.actors_["1012ui_story"].transform
			local var_239_1 = 0

			if var_239_1 < arg_236_1.time_ and arg_236_1.time_ <= var_239_1 + arg_239_0 then
				arg_236_1.var_.moveOldPos1012ui_story = var_239_0.localPosition
			end

			local var_239_2 = 0.001

			if var_239_1 <= arg_236_1.time_ and arg_236_1.time_ < var_239_1 + var_239_2 then
				local var_239_3 = (arg_236_1.time_ - var_239_1) / var_239_2
				local var_239_4 = Vector3.New(0, -1.05, -6.24)

				var_239_0.localPosition = Vector3.Lerp(arg_236_1.var_.moveOldPos1012ui_story, var_239_4, var_239_3)

				local var_239_5 = manager.ui.mainCamera.transform.position - var_239_0.position

				var_239_0.forward = Vector3.New(var_239_5.x, var_239_5.y, var_239_5.z)

				local var_239_6 = var_239_0.localEulerAngles

				var_239_6.z = 0
				var_239_6.x = 0
				var_239_0.localEulerAngles = var_239_6
			end

			if arg_236_1.time_ >= var_239_1 + var_239_2 and arg_236_1.time_ < var_239_1 + var_239_2 + arg_239_0 then
				var_239_0.localPosition = Vector3.New(0, -1.05, -6.24)

				local var_239_7 = manager.ui.mainCamera.transform.position - var_239_0.position

				var_239_0.forward = Vector3.New(var_239_7.x, var_239_7.y, var_239_7.z)

				local var_239_8 = var_239_0.localEulerAngles

				var_239_8.z = 0
				var_239_8.x = 0
				var_239_0.localEulerAngles = var_239_8
			end

			local var_239_9 = arg_236_1.actors_["1012ui_story"]
			local var_239_10 = 0

			if var_239_10 < arg_236_1.time_ and arg_236_1.time_ <= var_239_10 + arg_239_0 and not isNil(var_239_9) and arg_236_1.var_.characterEffect1012ui_story == nil then
				arg_236_1.var_.characterEffect1012ui_story = var_239_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_239_11 = 0.200000002980232

			if var_239_10 <= arg_236_1.time_ and arg_236_1.time_ < var_239_10 + var_239_11 and not isNil(var_239_9) then
				local var_239_12 = (arg_236_1.time_ - var_239_10) / var_239_11

				if arg_236_1.var_.characterEffect1012ui_story and not isNil(var_239_9) then
					arg_236_1.var_.characterEffect1012ui_story.fillFlat = false
				end
			end

			if arg_236_1.time_ >= var_239_10 + var_239_11 and arg_236_1.time_ < var_239_10 + var_239_11 + arg_239_0 and not isNil(var_239_9) and arg_236_1.var_.characterEffect1012ui_story then
				arg_236_1.var_.characterEffect1012ui_story.fillFlat = false
			end

			local var_239_13 = 0

			if var_239_13 < arg_236_1.time_ and arg_236_1.time_ <= var_239_13 + arg_239_0 then
				arg_236_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012action/1012action4_1")
			end

			local var_239_14 = 0

			if var_239_14 < arg_236_1.time_ and arg_236_1.time_ <= var_239_14 + arg_239_0 then
				arg_236_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_239_15 = 0
			local var_239_16 = 0.425

			if var_239_15 < arg_236_1.time_ and arg_236_1.time_ <= var_239_15 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, true)

				local var_239_17 = arg_236_1:FormatText(StoryNameCfg[595].name)

				arg_236_1.leftNameTxt_.text = var_239_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_236_1.leftNameTxt_.transform)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1.leftNameTxt_.text)
				SetActive(arg_236_1.iconTrs_.gameObject, false)
				arg_236_1.callingController_:SetSelectedState("normal")

				local var_239_18 = arg_236_1:GetWordFromCfg(426081055)
				local var_239_19 = arg_236_1:FormatText(var_239_18.content)

				arg_236_1.text_.text = var_239_19

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_20 = 17
				local var_239_21 = utf8.len(var_239_19)
				local var_239_22 = var_239_20 <= 0 and var_239_16 or var_239_16 * (var_239_21 / var_239_20)

				if var_239_22 > 0 and var_239_16 < var_239_22 then
					arg_236_1.talkMaxDuration = var_239_22

					if var_239_22 + var_239_15 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_22 + var_239_15
					end
				end

				arg_236_1.text_.text = var_239_19
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426081", "426081055", "story_v_out_426081.awb") ~= 0 then
					local var_239_23 = manager.audio:GetVoiceLength("story_v_out_426081", "426081055", "story_v_out_426081.awb") / 1000

					if var_239_23 + var_239_15 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_23 + var_239_15
					end

					if var_239_18.prefab_name ~= "" and arg_236_1.actors_[var_239_18.prefab_name] ~= nil then
						local var_239_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_236_1.actors_[var_239_18.prefab_name].transform, "story_v_out_426081", "426081055", "story_v_out_426081.awb")

						arg_236_1:RecordAudio("426081055", var_239_24)
						arg_236_1:RecordAudio("426081055", var_239_24)
					else
						arg_236_1:AudioAction("play", "voice", "story_v_out_426081", "426081055", "story_v_out_426081.awb")
					end

					arg_236_1:RecordHistoryTalkVoice("story_v_out_426081", "426081055", "story_v_out_426081.awb")
				end

				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_25 = math.max(var_239_16, arg_236_1.talkMaxDuration)

			if var_239_15 <= arg_236_1.time_ and arg_236_1.time_ < var_239_15 + var_239_25 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - var_239_15) / var_239_25

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= var_239_15 + var_239_25 and arg_236_1.time_ < var_239_15 + var_239_25 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012ui_story",
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
	Play426081056 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 426081056
		arg_240_1.duration_ = 5

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
		end

		function arg_240_1.playNext_(arg_242_0)
			if arg_242_0 == 1 then
				arg_240_0:Play426081057(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			local var_243_0 = arg_240_1.actors_["1012ui_story"]
			local var_243_1 = 0

			if var_243_1 < arg_240_1.time_ and arg_240_1.time_ <= var_243_1 + arg_243_0 and not isNil(var_243_0) and arg_240_1.var_.characterEffect1012ui_story == nil then
				arg_240_1.var_.characterEffect1012ui_story = var_243_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_243_2 = 0.200000002980232

			if var_243_1 <= arg_240_1.time_ and arg_240_1.time_ < var_243_1 + var_243_2 and not isNil(var_243_0) then
				local var_243_3 = (arg_240_1.time_ - var_243_1) / var_243_2

				if arg_240_1.var_.characterEffect1012ui_story and not isNil(var_243_0) then
					local var_243_4 = Mathf.Lerp(0, 0.5, var_243_3)

					arg_240_1.var_.characterEffect1012ui_story.fillFlat = true
					arg_240_1.var_.characterEffect1012ui_story.fillRatio = var_243_4
				end
			end

			if arg_240_1.time_ >= var_243_1 + var_243_2 and arg_240_1.time_ < var_243_1 + var_243_2 + arg_243_0 and not isNil(var_243_0) and arg_240_1.var_.characterEffect1012ui_story then
				local var_243_5 = 0.5

				arg_240_1.var_.characterEffect1012ui_story.fillFlat = true
				arg_240_1.var_.characterEffect1012ui_story.fillRatio = var_243_5
			end

			local var_243_6 = 0
			local var_243_7 = 0.925

			if var_243_6 < arg_240_1.time_ and arg_240_1.time_ <= var_243_6 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, true)

				local var_243_8 = arg_240_1:FormatText(StoryNameCfg[7].name)

				arg_240_1.leftNameTxt_.text = var_243_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_240_1.leftNameTxt_.transform)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1.leftNameTxt_.text)
				SetActive(arg_240_1.iconTrs_.gameObject, true)
				arg_240_1.iconController_:SetSelectedState("hero")

				arg_240_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_240_1.callingController_:SetSelectedState("normal")

				arg_240_1.keyicon_.color = Color.New(1, 1, 1)
				arg_240_1.icon_.color = Color.New(1, 1, 1)

				local var_243_9 = arg_240_1:GetWordFromCfg(426081056)
				local var_243_10 = arg_240_1:FormatText(var_243_9.content)

				arg_240_1.text_.text = var_243_10

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_11 = 37
				local var_243_12 = utf8.len(var_243_10)
				local var_243_13 = var_243_11 <= 0 and var_243_7 or var_243_7 * (var_243_12 / var_243_11)

				if var_243_13 > 0 and var_243_7 < var_243_13 then
					arg_240_1.talkMaxDuration = var_243_13

					if var_243_13 + var_243_6 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_13 + var_243_6
					end
				end

				arg_240_1.text_.text = var_243_10
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)
				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_14 = math.max(var_243_7, arg_240_1.talkMaxDuration)

			if var_243_6 <= arg_240_1.time_ and arg_240_1.time_ < var_243_6 + var_243_14 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - var_243_6) / var_243_14

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= var_243_6 + var_243_14 and arg_240_1.time_ < var_243_6 + var_243_14 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {}

		arg_240_1:InitPlayNodeList()
	end,
	Play426081057 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 426081057
		arg_244_1.duration_ = 5

		SetActive(arg_244_1.tipsGo_, false)

		function arg_244_1.onSingleLineFinish_()
			arg_244_1.onSingleLineUpdate_ = nil
			arg_244_1.onSingleLineFinish_ = nil
			arg_244_1.state_ = "waiting"
		end

		function arg_244_1.playNext_(arg_246_0)
			if arg_246_0 == 1 then
				arg_244_0:Play426081058(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			local var_247_0 = 0
			local var_247_1 = 0.3

			if var_247_0 < arg_244_1.time_ and arg_244_1.time_ <= var_247_0 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, true)

				local var_247_2 = arg_244_1:FormatText(StoryNameCfg[7].name)

				arg_244_1.leftNameTxt_.text = var_247_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_244_1.leftNameTxt_.transform)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1.leftNameTxt_.text)
				SetActive(arg_244_1.iconTrs_.gameObject, true)
				arg_244_1.iconController_:SetSelectedState("hero")

				arg_244_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_244_1.callingController_:SetSelectedState("normal")

				arg_244_1.keyicon_.color = Color.New(1, 1, 1)
				arg_244_1.icon_.color = Color.New(1, 1, 1)

				local var_247_3 = arg_244_1:GetWordFromCfg(426081057)
				local var_247_4 = arg_244_1:FormatText(var_247_3.content)

				arg_244_1.text_.text = var_247_4

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_5 = 12
				local var_247_6 = utf8.len(var_247_4)
				local var_247_7 = var_247_5 <= 0 and var_247_1 or var_247_1 * (var_247_6 / var_247_5)

				if var_247_7 > 0 and var_247_1 < var_247_7 then
					arg_244_1.talkMaxDuration = var_247_7

					if var_247_7 + var_247_0 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_7 + var_247_0
					end
				end

				arg_244_1.text_.text = var_247_4
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)
				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_8 = math.max(var_247_1, arg_244_1.talkMaxDuration)

			if var_247_0 <= arg_244_1.time_ and arg_244_1.time_ < var_247_0 + var_247_8 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_0) / var_247_8

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_0 + var_247_8 and arg_244_1.time_ < var_247_0 + var_247_8 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {}

		arg_244_1:InitPlayNodeList()
	end,
	Play426081058 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 426081058
		arg_248_1.duration_ = 9.17

		local var_248_0 = {
			zh = 5.833,
			ja = 9.166
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
				arg_248_0:Play426081059(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			local var_251_0 = arg_248_1.actors_["1012ui_story"].transform
			local var_251_1 = 0

			if var_251_1 < arg_248_1.time_ and arg_248_1.time_ <= var_251_1 + arg_251_0 then
				arg_248_1.var_.moveOldPos1012ui_story = var_251_0.localPosition
			end

			local var_251_2 = 0.001

			if var_251_1 <= arg_248_1.time_ and arg_248_1.time_ < var_251_1 + var_251_2 then
				local var_251_3 = (arg_248_1.time_ - var_251_1) / var_251_2
				local var_251_4 = Vector3.New(0, -1.05, -6.24)

				var_251_0.localPosition = Vector3.Lerp(arg_248_1.var_.moveOldPos1012ui_story, var_251_4, var_251_3)

				local var_251_5 = manager.ui.mainCamera.transform.position - var_251_0.position

				var_251_0.forward = Vector3.New(var_251_5.x, var_251_5.y, var_251_5.z)

				local var_251_6 = var_251_0.localEulerAngles

				var_251_6.z = 0
				var_251_6.x = 0
				var_251_0.localEulerAngles = var_251_6
			end

			if arg_248_1.time_ >= var_251_1 + var_251_2 and arg_248_1.time_ < var_251_1 + var_251_2 + arg_251_0 then
				var_251_0.localPosition = Vector3.New(0, -1.05, -6.24)

				local var_251_7 = manager.ui.mainCamera.transform.position - var_251_0.position

				var_251_0.forward = Vector3.New(var_251_7.x, var_251_7.y, var_251_7.z)

				local var_251_8 = var_251_0.localEulerAngles

				var_251_8.z = 0
				var_251_8.x = 0
				var_251_0.localEulerAngles = var_251_8
			end

			local var_251_9 = arg_248_1.actors_["1012ui_story"]
			local var_251_10 = 0

			if var_251_10 < arg_248_1.time_ and arg_248_1.time_ <= var_251_10 + arg_251_0 and not isNil(var_251_9) and arg_248_1.var_.characterEffect1012ui_story == nil then
				arg_248_1.var_.characterEffect1012ui_story = var_251_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_251_11 = 0.200000002980232

			if var_251_10 <= arg_248_1.time_ and arg_248_1.time_ < var_251_10 + var_251_11 and not isNil(var_251_9) then
				local var_251_12 = (arg_248_1.time_ - var_251_10) / var_251_11

				if arg_248_1.var_.characterEffect1012ui_story and not isNil(var_251_9) then
					arg_248_1.var_.characterEffect1012ui_story.fillFlat = false
				end
			end

			if arg_248_1.time_ >= var_251_10 + var_251_11 and arg_248_1.time_ < var_251_10 + var_251_11 + arg_251_0 and not isNil(var_251_9) and arg_248_1.var_.characterEffect1012ui_story then
				arg_248_1.var_.characterEffect1012ui_story.fillFlat = false
			end

			local var_251_13 = 0

			if var_251_13 < arg_248_1.time_ and arg_248_1.time_ <= var_251_13 + arg_251_0 then
				arg_248_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012action/1012action4_2")
			end

			local var_251_14 = 0

			if var_251_14 < arg_248_1.time_ and arg_248_1.time_ <= var_251_14 + arg_251_0 then
				arg_248_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_251_15 = 0
			local var_251_16 = 0.725

			if var_251_15 < arg_248_1.time_ and arg_248_1.time_ <= var_251_15 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, true)

				local var_251_17 = arg_248_1:FormatText(StoryNameCfg[595].name)

				arg_248_1.leftNameTxt_.text = var_251_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_248_1.leftNameTxt_.transform)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1.leftNameTxt_.text)
				SetActive(arg_248_1.iconTrs_.gameObject, false)
				arg_248_1.callingController_:SetSelectedState("normal")

				local var_251_18 = arg_248_1:GetWordFromCfg(426081058)
				local var_251_19 = arg_248_1:FormatText(var_251_18.content)

				arg_248_1.text_.text = var_251_19

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_20 = 29
				local var_251_21 = utf8.len(var_251_19)
				local var_251_22 = var_251_20 <= 0 and var_251_16 or var_251_16 * (var_251_21 / var_251_20)

				if var_251_22 > 0 and var_251_16 < var_251_22 then
					arg_248_1.talkMaxDuration = var_251_22

					if var_251_22 + var_251_15 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_22 + var_251_15
					end
				end

				arg_248_1.text_.text = var_251_19
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426081", "426081058", "story_v_out_426081.awb") ~= 0 then
					local var_251_23 = manager.audio:GetVoiceLength("story_v_out_426081", "426081058", "story_v_out_426081.awb") / 1000

					if var_251_23 + var_251_15 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_23 + var_251_15
					end

					if var_251_18.prefab_name ~= "" and arg_248_1.actors_[var_251_18.prefab_name] ~= nil then
						local var_251_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_248_1.actors_[var_251_18.prefab_name].transform, "story_v_out_426081", "426081058", "story_v_out_426081.awb")

						arg_248_1:RecordAudio("426081058", var_251_24)
						arg_248_1:RecordAudio("426081058", var_251_24)
					else
						arg_248_1:AudioAction("play", "voice", "story_v_out_426081", "426081058", "story_v_out_426081.awb")
					end

					arg_248_1:RecordHistoryTalkVoice("story_v_out_426081", "426081058", "story_v_out_426081.awb")
				end

				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_25 = math.max(var_251_16, arg_248_1.talkMaxDuration)

			if var_251_15 <= arg_248_1.time_ and arg_248_1.time_ < var_251_15 + var_251_25 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - var_251_15) / var_251_25

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= var_251_15 + var_251_25 and arg_248_1.time_ < var_251_15 + var_251_25 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012ui_story",
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
	Play426081059 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 426081059
		arg_252_1.duration_ = 5

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play426081060(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			local var_255_0 = arg_252_1.actors_["1012ui_story"].transform
			local var_255_1 = 0

			if var_255_1 < arg_252_1.time_ and arg_252_1.time_ <= var_255_1 + arg_255_0 then
				arg_252_1.var_.moveOldPos1012ui_story = var_255_0.localPosition
			end

			local var_255_2 = 0.001

			if var_255_1 <= arg_252_1.time_ and arg_252_1.time_ < var_255_1 + var_255_2 then
				local var_255_3 = (arg_252_1.time_ - var_255_1) / var_255_2
				local var_255_4 = Vector3.New(0, 100, 0)

				var_255_0.localPosition = Vector3.Lerp(arg_252_1.var_.moveOldPos1012ui_story, var_255_4, var_255_3)

				local var_255_5 = manager.ui.mainCamera.transform.position - var_255_0.position

				var_255_0.forward = Vector3.New(var_255_5.x, var_255_5.y, var_255_5.z)

				local var_255_6 = var_255_0.localEulerAngles

				var_255_6.z = 0
				var_255_6.x = 0
				var_255_0.localEulerAngles = var_255_6
			end

			if arg_252_1.time_ >= var_255_1 + var_255_2 and arg_252_1.time_ < var_255_1 + var_255_2 + arg_255_0 then
				var_255_0.localPosition = Vector3.New(0, 100, 0)

				local var_255_7 = manager.ui.mainCamera.transform.position - var_255_0.position

				var_255_0.forward = Vector3.New(var_255_7.x, var_255_7.y, var_255_7.z)

				local var_255_8 = var_255_0.localEulerAngles

				var_255_8.z = 0
				var_255_8.x = 0
				var_255_0.localEulerAngles = var_255_8
			end

			local var_255_9 = arg_252_1.actors_["1012ui_story"]
			local var_255_10 = 0

			if var_255_10 < arg_252_1.time_ and arg_252_1.time_ <= var_255_10 + arg_255_0 and not isNil(var_255_9) and arg_252_1.var_.characterEffect1012ui_story == nil then
				arg_252_1.var_.characterEffect1012ui_story = var_255_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_255_11 = 0.200000002980232

			if var_255_10 <= arg_252_1.time_ and arg_252_1.time_ < var_255_10 + var_255_11 and not isNil(var_255_9) then
				local var_255_12 = (arg_252_1.time_ - var_255_10) / var_255_11

				if arg_252_1.var_.characterEffect1012ui_story and not isNil(var_255_9) then
					local var_255_13 = Mathf.Lerp(0, 0.5, var_255_12)

					arg_252_1.var_.characterEffect1012ui_story.fillFlat = true
					arg_252_1.var_.characterEffect1012ui_story.fillRatio = var_255_13
				end
			end

			if arg_252_1.time_ >= var_255_10 + var_255_11 and arg_252_1.time_ < var_255_10 + var_255_11 + arg_255_0 and not isNil(var_255_9) and arg_252_1.var_.characterEffect1012ui_story then
				local var_255_14 = 0.5

				arg_252_1.var_.characterEffect1012ui_story.fillFlat = true
				arg_252_1.var_.characterEffect1012ui_story.fillRatio = var_255_14
			end

			local var_255_15 = 0
			local var_255_16 = 0.2

			if var_255_15 < arg_252_1.time_ and arg_252_1.time_ <= var_255_15 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, true)

				local var_255_17 = arg_252_1:FormatText(StoryNameCfg[7].name)

				arg_252_1.leftNameTxt_.text = var_255_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_252_1.leftNameTxt_.transform)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1.leftNameTxt_.text)
				SetActive(arg_252_1.iconTrs_.gameObject, true)
				arg_252_1.iconController_:SetSelectedState("hero")

				arg_252_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_252_1.callingController_:SetSelectedState("normal")

				arg_252_1.keyicon_.color = Color.New(1, 1, 1)
				arg_252_1.icon_.color = Color.New(1, 1, 1)

				local var_255_18 = arg_252_1:GetWordFromCfg(426081059)
				local var_255_19 = arg_252_1:FormatText(var_255_18.content)

				arg_252_1.text_.text = var_255_19

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_20 = 8
				local var_255_21 = utf8.len(var_255_19)
				local var_255_22 = var_255_20 <= 0 and var_255_16 or var_255_16 * (var_255_21 / var_255_20)

				if var_255_22 > 0 and var_255_16 < var_255_22 then
					arg_252_1.talkMaxDuration = var_255_22

					if var_255_22 + var_255_15 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_22 + var_255_15
					end
				end

				arg_252_1.text_.text = var_255_19
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)
				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_23 = math.max(var_255_16, arg_252_1.talkMaxDuration)

			if var_255_15 <= arg_252_1.time_ and arg_252_1.time_ < var_255_15 + var_255_23 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_15) / var_255_23

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_15 + var_255_23 and arg_252_1.time_ < var_255_15 + var_255_23 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_252_1:InitPlayNodeList()
	end,
	Play426081060 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 426081060
		arg_256_1.duration_ = 6.9

		local var_256_0 = {
			zh = 4.633,
			ja = 6.9
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
				arg_256_0:Play426081061(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			local var_259_0 = 0
			local var_259_1 = 0.675

			if var_259_0 < arg_256_1.time_ and arg_256_1.time_ <= var_259_0 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, true)

				local var_259_2 = arg_256_1:FormatText(StoryNameCfg[384].name)

				arg_256_1.leftNameTxt_.text = var_259_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_256_1.leftNameTxt_.transform)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1.leftNameTxt_.text)
				SetActive(arg_256_1.iconTrs_.gameObject, true)
				arg_256_1.iconController_:SetSelectedState("hero")

				arg_256_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1071")

				arg_256_1.callingController_:SetSelectedState("calling")

				arg_256_1.keyicon_.color = Color.New(1, 1, 1)
				arg_256_1.icon_.color = Color.New(1, 1, 1)

				local var_259_3 = arg_256_1:GetWordFromCfg(426081060)
				local var_259_4 = arg_256_1:FormatText(var_259_3.content)

				arg_256_1.text_.text = var_259_4

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_5 = 27
				local var_259_6 = utf8.len(var_259_4)
				local var_259_7 = var_259_5 <= 0 and var_259_1 or var_259_1 * (var_259_6 / var_259_5)

				if var_259_7 > 0 and var_259_1 < var_259_7 then
					arg_256_1.talkMaxDuration = var_259_7

					if var_259_7 + var_259_0 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_7 + var_259_0
					end
				end

				arg_256_1.text_.text = var_259_4
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426081", "426081060", "story_v_out_426081.awb") ~= 0 then
					local var_259_8 = manager.audio:GetVoiceLength("story_v_out_426081", "426081060", "story_v_out_426081.awb") / 1000

					if var_259_8 + var_259_0 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_8 + var_259_0
					end

					if var_259_3.prefab_name ~= "" and arg_256_1.actors_[var_259_3.prefab_name] ~= nil then
						local var_259_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_256_1.actors_[var_259_3.prefab_name].transform, "story_v_out_426081", "426081060", "story_v_out_426081.awb")

						arg_256_1:RecordAudio("426081060", var_259_9)
						arg_256_1:RecordAudio("426081060", var_259_9)
					else
						arg_256_1:AudioAction("play", "voice", "story_v_out_426081", "426081060", "story_v_out_426081.awb")
					end

					arg_256_1:RecordHistoryTalkVoice("story_v_out_426081", "426081060", "story_v_out_426081.awb")
				end

				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_10 = math.max(var_259_1, arg_256_1.talkMaxDuration)

			if var_259_0 <= arg_256_1.time_ and arg_256_1.time_ < var_259_0 + var_259_10 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - var_259_0) / var_259_10

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= var_259_0 + var_259_10 and arg_256_1.time_ < var_259_0 + var_259_10 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {}

		arg_256_1:InitPlayNodeList()
	end,
	Play426081061 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 426081061
		arg_260_1.duration_ = 5

		SetActive(arg_260_1.tipsGo_, false)

		function arg_260_1.onSingleLineFinish_()
			arg_260_1.onSingleLineUpdate_ = nil
			arg_260_1.onSingleLineFinish_ = nil
			arg_260_1.state_ = "waiting"
		end

		function arg_260_1.playNext_(arg_262_0)
			if arg_262_0 == 1 then
				arg_260_0:Play426081062(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			local var_263_0 = 0
			local var_263_1 = 0.875

			if var_263_0 < arg_260_1.time_ and arg_260_1.time_ <= var_263_0 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0
				arg_260_1.dialogCg_.alpha = 1

				arg_260_1.dialog_:SetActive(true)
				SetActive(arg_260_1.leftNameGo_, false)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_260_1.iconTrs_.gameObject, false)
				arg_260_1.callingController_:SetSelectedState("normal")

				local var_263_2 = arg_260_1:GetWordFromCfg(426081061)
				local var_263_3 = arg_260_1:FormatText(var_263_2.content)

				arg_260_1.text_.text = var_263_3

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_4 = 35
				local var_263_5 = utf8.len(var_263_3)
				local var_263_6 = var_263_4 <= 0 and var_263_1 or var_263_1 * (var_263_5 / var_263_4)

				if var_263_6 > 0 and var_263_1 < var_263_6 then
					arg_260_1.talkMaxDuration = var_263_6

					if var_263_6 + var_263_0 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_6 + var_263_0
					end
				end

				arg_260_1.text_.text = var_263_3
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)
				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_7 = math.max(var_263_1, arg_260_1.talkMaxDuration)

			if var_263_0 <= arg_260_1.time_ and arg_260_1.time_ < var_263_0 + var_263_7 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - var_263_0) / var_263_7

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= var_263_0 + var_263_7 and arg_260_1.time_ < var_263_0 + var_263_7 + arg_263_0 then
				arg_260_1.typewritter.percent = 1

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(true)
			end
		end

		arg_260_1.nodeConfigList_ = {}

		arg_260_1:InitPlayNodeList()
	end,
	Play426081062 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 426081062
		arg_264_1.duration_ = 9.6

		local var_264_0 = {
			zh = 7.3,
			ja = 9.6
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
				arg_264_0:Play426081063(arg_264_1)
			end
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			local var_267_0 = 0
			local var_267_1 = 0.925

			if var_267_0 < arg_264_1.time_ and arg_264_1.time_ <= var_267_0 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0
				arg_264_1.dialogCg_.alpha = 1

				arg_264_1.dialog_:SetActive(true)
				SetActive(arg_264_1.leftNameGo_, true)

				local var_267_2 = arg_264_1:FormatText(StoryNameCfg[384].name)

				arg_264_1.leftNameTxt_.text = var_267_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_264_1.leftNameTxt_.transform)

				arg_264_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_264_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_264_1:RecordName(arg_264_1.leftNameTxt_.text)
				SetActive(arg_264_1.iconTrs_.gameObject, true)
				arg_264_1.iconController_:SetSelectedState("hero")

				arg_264_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1071")

				arg_264_1.callingController_:SetSelectedState("calling")

				arg_264_1.keyicon_.color = Color.New(1, 1, 1)
				arg_264_1.icon_.color = Color.New(1, 1, 1)

				local var_267_3 = arg_264_1:GetWordFromCfg(426081062)
				local var_267_4 = arg_264_1:FormatText(var_267_3.content)

				arg_264_1.text_.text = var_267_4

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_5 = 37
				local var_267_6 = utf8.len(var_267_4)
				local var_267_7 = var_267_5 <= 0 and var_267_1 or var_267_1 * (var_267_6 / var_267_5)

				if var_267_7 > 0 and var_267_1 < var_267_7 then
					arg_264_1.talkMaxDuration = var_267_7

					if var_267_7 + var_267_0 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_7 + var_267_0
					end
				end

				arg_264_1.text_.text = var_267_4
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426081", "426081062", "story_v_out_426081.awb") ~= 0 then
					local var_267_8 = manager.audio:GetVoiceLength("story_v_out_426081", "426081062", "story_v_out_426081.awb") / 1000

					if var_267_8 + var_267_0 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_8 + var_267_0
					end

					if var_267_3.prefab_name ~= "" and arg_264_1.actors_[var_267_3.prefab_name] ~= nil then
						local var_267_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_264_1.actors_[var_267_3.prefab_name].transform, "story_v_out_426081", "426081062", "story_v_out_426081.awb")

						arg_264_1:RecordAudio("426081062", var_267_9)
						arg_264_1:RecordAudio("426081062", var_267_9)
					else
						arg_264_1:AudioAction("play", "voice", "story_v_out_426081", "426081062", "story_v_out_426081.awb")
					end

					arg_264_1:RecordHistoryTalkVoice("story_v_out_426081", "426081062", "story_v_out_426081.awb")
				end

				arg_264_1:RecordContent(arg_264_1.text_.text)
			end

			local var_267_10 = math.max(var_267_1, arg_264_1.talkMaxDuration)

			if var_267_0 <= arg_264_1.time_ and arg_264_1.time_ < var_267_0 + var_267_10 then
				arg_264_1.typewritter.percent = (arg_264_1.time_ - var_267_0) / var_267_10

				arg_264_1.typewritter:SetDirty()
			end

			if arg_264_1.time_ >= var_267_0 + var_267_10 and arg_264_1.time_ < var_267_0 + var_267_10 + arg_267_0 then
				arg_264_1.typewritter.percent = 1

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(true)
			end
		end

		arg_264_1.nodeConfigList_ = {}

		arg_264_1:InitPlayNodeList()
	end,
	Play426081063 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 426081063
		arg_268_1.duration_ = 5

		SetActive(arg_268_1.tipsGo_, false)

		function arg_268_1.onSingleLineFinish_()
			arg_268_1.onSingleLineUpdate_ = nil
			arg_268_1.onSingleLineFinish_ = nil
			arg_268_1.state_ = "waiting"
		end

		function arg_268_1.playNext_(arg_270_0)
			if arg_270_0 == 1 then
				arg_268_0:Play426081064(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			local var_271_0 = 0
			local var_271_1 = 0.8

			if var_271_0 < arg_268_1.time_ and arg_268_1.time_ <= var_271_0 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0
				arg_268_1.dialogCg_.alpha = 1

				arg_268_1.dialog_:SetActive(true)
				SetActive(arg_268_1.leftNameGo_, true)

				local var_271_2 = arg_268_1:FormatText(StoryNameCfg[7].name)

				arg_268_1.leftNameTxt_.text = var_271_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_268_1.leftNameTxt_.transform)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1.leftNameTxt_.text)
				SetActive(arg_268_1.iconTrs_.gameObject, true)
				arg_268_1.iconController_:SetSelectedState("hero")

				arg_268_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_268_1.callingController_:SetSelectedState("normal")

				arg_268_1.keyicon_.color = Color.New(1, 1, 1)
				arg_268_1.icon_.color = Color.New(1, 1, 1)

				local var_271_3 = arg_268_1:GetWordFromCfg(426081063)
				local var_271_4 = arg_268_1:FormatText(var_271_3.content)

				arg_268_1.text_.text = var_271_4

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_5 = 32
				local var_271_6 = utf8.len(var_271_4)
				local var_271_7 = var_271_5 <= 0 and var_271_1 or var_271_1 * (var_271_6 / var_271_5)

				if var_271_7 > 0 and var_271_1 < var_271_7 then
					arg_268_1.talkMaxDuration = var_271_7

					if var_271_7 + var_271_0 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_7 + var_271_0
					end
				end

				arg_268_1.text_.text = var_271_4
				arg_268_1.typewritter.percent = 0

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(false)
				arg_268_1:RecordContent(arg_268_1.text_.text)
			end

			local var_271_8 = math.max(var_271_1, arg_268_1.talkMaxDuration)

			if var_271_0 <= arg_268_1.time_ and arg_268_1.time_ < var_271_0 + var_271_8 then
				arg_268_1.typewritter.percent = (arg_268_1.time_ - var_271_0) / var_271_8

				arg_268_1.typewritter:SetDirty()
			end

			if arg_268_1.time_ >= var_271_0 + var_271_8 and arg_268_1.time_ < var_271_0 + var_271_8 + arg_271_0 then
				arg_268_1.typewritter.percent = 1

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(true)
			end
		end

		arg_268_1.nodeConfigList_ = {}

		arg_268_1:InitPlayNodeList()
	end,
	Play426081064 = function(arg_272_0, arg_272_1)
		arg_272_1.time_ = 0
		arg_272_1.frameCnt_ = 0
		arg_272_1.state_ = "playing"
		arg_272_1.curTalkId_ = 426081064
		arg_272_1.duration_ = 9.87

		local var_272_0 = {
			zh = 5.766,
			ja = 9.866
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
				arg_272_0:Play426081065(arg_272_1)
			end
		end

		function arg_272_1.onSingleLineUpdate_(arg_275_0)
			local var_275_0 = 0
			local var_275_1 = 0.725

			if var_275_0 < arg_272_1.time_ and arg_272_1.time_ <= var_275_0 + arg_275_0 then
				arg_272_1.talkMaxDuration = 0
				arg_272_1.dialogCg_.alpha = 1

				arg_272_1.dialog_:SetActive(true)
				SetActive(arg_272_1.leftNameGo_, true)

				local var_275_2 = arg_272_1:FormatText(StoryNameCfg[384].name)

				arg_272_1.leftNameTxt_.text = var_275_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_272_1.leftNameTxt_.transform)

				arg_272_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_272_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_272_1:RecordName(arg_272_1.leftNameTxt_.text)
				SetActive(arg_272_1.iconTrs_.gameObject, true)
				arg_272_1.iconController_:SetSelectedState("hero")

				arg_272_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1071")

				arg_272_1.callingController_:SetSelectedState("calling")

				arg_272_1.keyicon_.color = Color.New(1, 1, 1)
				arg_272_1.icon_.color = Color.New(1, 1, 1)

				local var_275_3 = arg_272_1:GetWordFromCfg(426081064)
				local var_275_4 = arg_272_1:FormatText(var_275_3.content)

				arg_272_1.text_.text = var_275_4

				LuaForUtil.ClearLinePrefixSymbol(arg_272_1.text_)

				local var_275_5 = 29
				local var_275_6 = utf8.len(var_275_4)
				local var_275_7 = var_275_5 <= 0 and var_275_1 or var_275_1 * (var_275_6 / var_275_5)

				if var_275_7 > 0 and var_275_1 < var_275_7 then
					arg_272_1.talkMaxDuration = var_275_7

					if var_275_7 + var_275_0 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_7 + var_275_0
					end
				end

				arg_272_1.text_.text = var_275_4
				arg_272_1.typewritter.percent = 0

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426081", "426081064", "story_v_out_426081.awb") ~= 0 then
					local var_275_8 = manager.audio:GetVoiceLength("story_v_out_426081", "426081064", "story_v_out_426081.awb") / 1000

					if var_275_8 + var_275_0 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_8 + var_275_0
					end

					if var_275_3.prefab_name ~= "" and arg_272_1.actors_[var_275_3.prefab_name] ~= nil then
						local var_275_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_272_1.actors_[var_275_3.prefab_name].transform, "story_v_out_426081", "426081064", "story_v_out_426081.awb")

						arg_272_1:RecordAudio("426081064", var_275_9)
						arg_272_1:RecordAudio("426081064", var_275_9)
					else
						arg_272_1:AudioAction("play", "voice", "story_v_out_426081", "426081064", "story_v_out_426081.awb")
					end

					arg_272_1:RecordHistoryTalkVoice("story_v_out_426081", "426081064", "story_v_out_426081.awb")
				end

				arg_272_1:RecordContent(arg_272_1.text_.text)
			end

			local var_275_10 = math.max(var_275_1, arg_272_1.talkMaxDuration)

			if var_275_0 <= arg_272_1.time_ and arg_272_1.time_ < var_275_0 + var_275_10 then
				arg_272_1.typewritter.percent = (arg_272_1.time_ - var_275_0) / var_275_10

				arg_272_1.typewritter:SetDirty()
			end

			if arg_272_1.time_ >= var_275_0 + var_275_10 and arg_272_1.time_ < var_275_0 + var_275_10 + arg_275_0 then
				arg_272_1.typewritter.percent = 1

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(true)
			end
		end

		arg_272_1.nodeConfigList_ = {}

		arg_272_1:InitPlayNodeList()
	end,
	Play426081065 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 426081065
		arg_276_1.duration_ = 5

		SetActive(arg_276_1.tipsGo_, false)

		function arg_276_1.onSingleLineFinish_()
			arg_276_1.onSingleLineUpdate_ = nil
			arg_276_1.onSingleLineFinish_ = nil
			arg_276_1.state_ = "waiting"
		end

		function arg_276_1.playNext_(arg_278_0)
			if arg_278_0 == 1 then
				arg_276_0:Play426081066(arg_276_1)
			end
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			local var_279_0 = 0
			local var_279_1 = 0.95

			if var_279_0 < arg_276_1.time_ and arg_276_1.time_ <= var_279_0 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0
				arg_276_1.dialogCg_.alpha = 1

				arg_276_1.dialog_:SetActive(true)
				SetActive(arg_276_1.leftNameGo_, true)

				local var_279_2 = arg_276_1:FormatText(StoryNameCfg[7].name)

				arg_276_1.leftNameTxt_.text = var_279_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_276_1.leftNameTxt_.transform)

				arg_276_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_276_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_276_1:RecordName(arg_276_1.leftNameTxt_.text)
				SetActive(arg_276_1.iconTrs_.gameObject, true)
				arg_276_1.iconController_:SetSelectedState("hero")

				arg_276_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_276_1.callingController_:SetSelectedState("normal")

				arg_276_1.keyicon_.color = Color.New(1, 1, 1)
				arg_276_1.icon_.color = Color.New(1, 1, 1)

				local var_279_3 = arg_276_1:GetWordFromCfg(426081065)
				local var_279_4 = arg_276_1:FormatText(var_279_3.content)

				arg_276_1.text_.text = var_279_4

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_5 = 38
				local var_279_6 = utf8.len(var_279_4)
				local var_279_7 = var_279_5 <= 0 and var_279_1 or var_279_1 * (var_279_6 / var_279_5)

				if var_279_7 > 0 and var_279_1 < var_279_7 then
					arg_276_1.talkMaxDuration = var_279_7

					if var_279_7 + var_279_0 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_7 + var_279_0
					end
				end

				arg_276_1.text_.text = var_279_4
				arg_276_1.typewritter.percent = 0

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(false)
				arg_276_1:RecordContent(arg_276_1.text_.text)
			end

			local var_279_8 = math.max(var_279_1, arg_276_1.talkMaxDuration)

			if var_279_0 <= arg_276_1.time_ and arg_276_1.time_ < var_279_0 + var_279_8 then
				arg_276_1.typewritter.percent = (arg_276_1.time_ - var_279_0) / var_279_8

				arg_276_1.typewritter:SetDirty()
			end

			if arg_276_1.time_ >= var_279_0 + var_279_8 and arg_276_1.time_ < var_279_0 + var_279_8 + arg_279_0 then
				arg_276_1.typewritter.percent = 1

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(true)
			end
		end

		arg_276_1.nodeConfigList_ = {}

		arg_276_1:InitPlayNodeList()
	end,
	Play426081066 = function(arg_280_0, arg_280_1)
		arg_280_1.time_ = 0
		arg_280_1.frameCnt_ = 0
		arg_280_1.state_ = "playing"
		arg_280_1.curTalkId_ = 426081066
		arg_280_1.duration_ = 16.5

		local var_280_0 = {
			zh = 6.333,
			ja = 16.5
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
				arg_280_0:Play426081067(arg_280_1)
			end
		end

		function arg_280_1.onSingleLineUpdate_(arg_283_0)
			local var_283_0 = 0
			local var_283_1 = 0.725

			if var_283_0 < arg_280_1.time_ and arg_280_1.time_ <= var_283_0 + arg_283_0 then
				arg_280_1.talkMaxDuration = 0
				arg_280_1.dialogCg_.alpha = 1

				arg_280_1.dialog_:SetActive(true)
				SetActive(arg_280_1.leftNameGo_, true)

				local var_283_2 = arg_280_1:FormatText(StoryNameCfg[384].name)

				arg_280_1.leftNameTxt_.text = var_283_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_280_1.leftNameTxt_.transform)

				arg_280_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_280_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_280_1:RecordName(arg_280_1.leftNameTxt_.text)
				SetActive(arg_280_1.iconTrs_.gameObject, true)
				arg_280_1.iconController_:SetSelectedState("hero")

				arg_280_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1071")

				arg_280_1.callingController_:SetSelectedState("calling")

				arg_280_1.keyicon_.color = Color.New(1, 1, 1)
				arg_280_1.icon_.color = Color.New(1, 1, 1)

				local var_283_3 = arg_280_1:GetWordFromCfg(426081066)
				local var_283_4 = arg_280_1:FormatText(var_283_3.content)

				arg_280_1.text_.text = var_283_4

				LuaForUtil.ClearLinePrefixSymbol(arg_280_1.text_)

				local var_283_5 = 29
				local var_283_6 = utf8.len(var_283_4)
				local var_283_7 = var_283_5 <= 0 and var_283_1 or var_283_1 * (var_283_6 / var_283_5)

				if var_283_7 > 0 and var_283_1 < var_283_7 then
					arg_280_1.talkMaxDuration = var_283_7

					if var_283_7 + var_283_0 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_7 + var_283_0
					end
				end

				arg_280_1.text_.text = var_283_4
				arg_280_1.typewritter.percent = 0

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426081", "426081066", "story_v_out_426081.awb") ~= 0 then
					local var_283_8 = manager.audio:GetVoiceLength("story_v_out_426081", "426081066", "story_v_out_426081.awb") / 1000

					if var_283_8 + var_283_0 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_8 + var_283_0
					end

					if var_283_3.prefab_name ~= "" and arg_280_1.actors_[var_283_3.prefab_name] ~= nil then
						local var_283_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_280_1.actors_[var_283_3.prefab_name].transform, "story_v_out_426081", "426081066", "story_v_out_426081.awb")

						arg_280_1:RecordAudio("426081066", var_283_9)
						arg_280_1:RecordAudio("426081066", var_283_9)
					else
						arg_280_1:AudioAction("play", "voice", "story_v_out_426081", "426081066", "story_v_out_426081.awb")
					end

					arg_280_1:RecordHistoryTalkVoice("story_v_out_426081", "426081066", "story_v_out_426081.awb")
				end

				arg_280_1:RecordContent(arg_280_1.text_.text)
			end

			local var_283_10 = math.max(var_283_1, arg_280_1.talkMaxDuration)

			if var_283_0 <= arg_280_1.time_ and arg_280_1.time_ < var_283_0 + var_283_10 then
				arg_280_1.typewritter.percent = (arg_280_1.time_ - var_283_0) / var_283_10

				arg_280_1.typewritter:SetDirty()
			end

			if arg_280_1.time_ >= var_283_0 + var_283_10 and arg_280_1.time_ < var_283_0 + var_283_10 + arg_283_0 then
				arg_280_1.typewritter.percent = 1

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(true)
			end
		end

		arg_280_1.nodeConfigList_ = {}

		arg_280_1:InitPlayNodeList()
	end,
	Play426081067 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 426081067
		arg_284_1.duration_ = 5

		SetActive(arg_284_1.tipsGo_, false)

		function arg_284_1.onSingleLineFinish_()
			arg_284_1.onSingleLineUpdate_ = nil
			arg_284_1.onSingleLineFinish_ = nil
			arg_284_1.state_ = "waiting"
		end

		function arg_284_1.playNext_(arg_286_0)
			if arg_286_0 == 1 then
				arg_284_0:Play426081068(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			local var_287_0 = 0
			local var_287_1 = 0.275

			if var_287_0 < arg_284_1.time_ and arg_284_1.time_ <= var_287_0 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0
				arg_284_1.dialogCg_.alpha = 1

				arg_284_1.dialog_:SetActive(true)
				SetActive(arg_284_1.leftNameGo_, true)

				local var_287_2 = arg_284_1:FormatText(StoryNameCfg[7].name)

				arg_284_1.leftNameTxt_.text = var_287_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_284_1.leftNameTxt_.transform)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1.leftNameTxt_.text)
				SetActive(arg_284_1.iconTrs_.gameObject, true)
				arg_284_1.iconController_:SetSelectedState("hero")

				arg_284_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_284_1.callingController_:SetSelectedState("normal")

				arg_284_1.keyicon_.color = Color.New(1, 1, 1)
				arg_284_1.icon_.color = Color.New(1, 1, 1)

				local var_287_3 = arg_284_1:GetWordFromCfg(426081067)
				local var_287_4 = arg_284_1:FormatText(var_287_3.content)

				arg_284_1.text_.text = var_287_4

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_5 = 11
				local var_287_6 = utf8.len(var_287_4)
				local var_287_7 = var_287_5 <= 0 and var_287_1 or var_287_1 * (var_287_6 / var_287_5)

				if var_287_7 > 0 and var_287_1 < var_287_7 then
					arg_284_1.talkMaxDuration = var_287_7

					if var_287_7 + var_287_0 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_7 + var_287_0
					end
				end

				arg_284_1.text_.text = var_287_4
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)
				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_8 = math.max(var_287_1, arg_284_1.talkMaxDuration)

			if var_287_0 <= arg_284_1.time_ and arg_284_1.time_ < var_287_0 + var_287_8 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - var_287_0) / var_287_8

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= var_287_0 + var_287_8 and arg_284_1.time_ < var_287_0 + var_287_8 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {}

		arg_284_1:InitPlayNodeList()
	end,
	Play426081068 = function(arg_288_0, arg_288_1)
		arg_288_1.time_ = 0
		arg_288_1.frameCnt_ = 0
		arg_288_1.state_ = "playing"
		arg_288_1.curTalkId_ = 426081068
		arg_288_1.duration_ = 14.7

		local var_288_0 = {
			zh = 8.633,
			ja = 14.7
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
				arg_288_0:Play426081069(arg_288_1)
			end
		end

		function arg_288_1.onSingleLineUpdate_(arg_291_0)
			local var_291_0 = arg_288_1.actors_["1012ui_story"].transform
			local var_291_1 = 0

			if var_291_1 < arg_288_1.time_ and arg_288_1.time_ <= var_291_1 + arg_291_0 then
				arg_288_1.var_.moveOldPos1012ui_story = var_291_0.localPosition
			end

			local var_291_2 = 0.001

			if var_291_1 <= arg_288_1.time_ and arg_288_1.time_ < var_291_1 + var_291_2 then
				local var_291_3 = (arg_288_1.time_ - var_291_1) / var_291_2
				local var_291_4 = Vector3.New(0, -1.05, -6.24)

				var_291_0.localPosition = Vector3.Lerp(arg_288_1.var_.moveOldPos1012ui_story, var_291_4, var_291_3)

				local var_291_5 = manager.ui.mainCamera.transform.position - var_291_0.position

				var_291_0.forward = Vector3.New(var_291_5.x, var_291_5.y, var_291_5.z)

				local var_291_6 = var_291_0.localEulerAngles

				var_291_6.z = 0
				var_291_6.x = 0
				var_291_0.localEulerAngles = var_291_6
			end

			if arg_288_1.time_ >= var_291_1 + var_291_2 and arg_288_1.time_ < var_291_1 + var_291_2 + arg_291_0 then
				var_291_0.localPosition = Vector3.New(0, -1.05, -6.24)

				local var_291_7 = manager.ui.mainCamera.transform.position - var_291_0.position

				var_291_0.forward = Vector3.New(var_291_7.x, var_291_7.y, var_291_7.z)

				local var_291_8 = var_291_0.localEulerAngles

				var_291_8.z = 0
				var_291_8.x = 0
				var_291_0.localEulerAngles = var_291_8
			end

			local var_291_9 = arg_288_1.actors_["1012ui_story"]
			local var_291_10 = 0

			if var_291_10 < arg_288_1.time_ and arg_288_1.time_ <= var_291_10 + arg_291_0 and not isNil(var_291_9) and arg_288_1.var_.characterEffect1012ui_story == nil then
				arg_288_1.var_.characterEffect1012ui_story = var_291_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_291_11 = 0.200000002980232

			if var_291_10 <= arg_288_1.time_ and arg_288_1.time_ < var_291_10 + var_291_11 and not isNil(var_291_9) then
				local var_291_12 = (arg_288_1.time_ - var_291_10) / var_291_11

				if arg_288_1.var_.characterEffect1012ui_story and not isNil(var_291_9) then
					arg_288_1.var_.characterEffect1012ui_story.fillFlat = false
				end
			end

			if arg_288_1.time_ >= var_291_10 + var_291_11 and arg_288_1.time_ < var_291_10 + var_291_11 + arg_291_0 and not isNil(var_291_9) and arg_288_1.var_.characterEffect1012ui_story then
				arg_288_1.var_.characterEffect1012ui_story.fillFlat = false
			end

			local var_291_13 = 0

			if var_291_13 < arg_288_1.time_ and arg_288_1.time_ <= var_291_13 + arg_291_0 then
				arg_288_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012action/1012action1_1")
			end

			local var_291_14 = 0

			if var_291_14 < arg_288_1.time_ and arg_288_1.time_ <= var_291_14 + arg_291_0 then
				arg_288_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_291_15 = 0
			local var_291_16 = 1.075

			if var_291_15 < arg_288_1.time_ and arg_288_1.time_ <= var_291_15 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0
				arg_288_1.dialogCg_.alpha = 1

				arg_288_1.dialog_:SetActive(true)
				SetActive(arg_288_1.leftNameGo_, true)

				local var_291_17 = arg_288_1:FormatText(StoryNameCfg[595].name)

				arg_288_1.leftNameTxt_.text = var_291_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_288_1.leftNameTxt_.transform)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1.leftNameTxt_.text)
				SetActive(arg_288_1.iconTrs_.gameObject, false)
				arg_288_1.callingController_:SetSelectedState("normal")

				local var_291_18 = arg_288_1:GetWordFromCfg(426081068)
				local var_291_19 = arg_288_1:FormatText(var_291_18.content)

				arg_288_1.text_.text = var_291_19

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_20 = 43
				local var_291_21 = utf8.len(var_291_19)
				local var_291_22 = var_291_20 <= 0 and var_291_16 or var_291_16 * (var_291_21 / var_291_20)

				if var_291_22 > 0 and var_291_16 < var_291_22 then
					arg_288_1.talkMaxDuration = var_291_22

					if var_291_22 + var_291_15 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_22 + var_291_15
					end
				end

				arg_288_1.text_.text = var_291_19
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426081", "426081068", "story_v_out_426081.awb") ~= 0 then
					local var_291_23 = manager.audio:GetVoiceLength("story_v_out_426081", "426081068", "story_v_out_426081.awb") / 1000

					if var_291_23 + var_291_15 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_23 + var_291_15
					end

					if var_291_18.prefab_name ~= "" and arg_288_1.actors_[var_291_18.prefab_name] ~= nil then
						local var_291_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_288_1.actors_[var_291_18.prefab_name].transform, "story_v_out_426081", "426081068", "story_v_out_426081.awb")

						arg_288_1:RecordAudio("426081068", var_291_24)
						arg_288_1:RecordAudio("426081068", var_291_24)
					else
						arg_288_1:AudioAction("play", "voice", "story_v_out_426081", "426081068", "story_v_out_426081.awb")
					end

					arg_288_1:RecordHistoryTalkVoice("story_v_out_426081", "426081068", "story_v_out_426081.awb")
				end

				arg_288_1:RecordContent(arg_288_1.text_.text)
			end

			local var_291_25 = math.max(var_291_16, arg_288_1.talkMaxDuration)

			if var_291_15 <= arg_288_1.time_ and arg_288_1.time_ < var_291_15 + var_291_25 then
				arg_288_1.typewritter.percent = (arg_288_1.time_ - var_291_15) / var_291_25

				arg_288_1.typewritter:SetDirty()
			end

			if arg_288_1.time_ >= var_291_15 + var_291_25 and arg_288_1.time_ < var_291_15 + var_291_25 + arg_291_0 then
				arg_288_1.typewritter.percent = 1

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(true)
			end
		end

		arg_288_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012ui_story",
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
	Play426081069 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 426081069
		arg_292_1.duration_ = 5

		SetActive(arg_292_1.tipsGo_, false)

		function arg_292_1.onSingleLineFinish_()
			arg_292_1.onSingleLineUpdate_ = nil
			arg_292_1.onSingleLineFinish_ = nil
			arg_292_1.state_ = "waiting"
		end

		function arg_292_1.playNext_(arg_294_0)
			if arg_294_0 == 1 then
				arg_292_0:Play426081070(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			local var_295_0 = arg_292_1.actors_["1012ui_story"].transform
			local var_295_1 = 0

			if var_295_1 < arg_292_1.time_ and arg_292_1.time_ <= var_295_1 + arg_295_0 then
				arg_292_1.var_.moveOldPos1012ui_story = var_295_0.localPosition
			end

			local var_295_2 = 0.001

			if var_295_1 <= arg_292_1.time_ and arg_292_1.time_ < var_295_1 + var_295_2 then
				local var_295_3 = (arg_292_1.time_ - var_295_1) / var_295_2
				local var_295_4 = Vector3.New(0, 100, 0)

				var_295_0.localPosition = Vector3.Lerp(arg_292_1.var_.moveOldPos1012ui_story, var_295_4, var_295_3)

				local var_295_5 = manager.ui.mainCamera.transform.position - var_295_0.position

				var_295_0.forward = Vector3.New(var_295_5.x, var_295_5.y, var_295_5.z)

				local var_295_6 = var_295_0.localEulerAngles

				var_295_6.z = 0
				var_295_6.x = 0
				var_295_0.localEulerAngles = var_295_6
			end

			if arg_292_1.time_ >= var_295_1 + var_295_2 and arg_292_1.time_ < var_295_1 + var_295_2 + arg_295_0 then
				var_295_0.localPosition = Vector3.New(0, 100, 0)

				local var_295_7 = manager.ui.mainCamera.transform.position - var_295_0.position

				var_295_0.forward = Vector3.New(var_295_7.x, var_295_7.y, var_295_7.z)

				local var_295_8 = var_295_0.localEulerAngles

				var_295_8.z = 0
				var_295_8.x = 0
				var_295_0.localEulerAngles = var_295_8
			end

			local var_295_9 = arg_292_1.actors_["1012ui_story"]
			local var_295_10 = 0

			if var_295_10 < arg_292_1.time_ and arg_292_1.time_ <= var_295_10 + arg_295_0 and not isNil(var_295_9) and arg_292_1.var_.characterEffect1012ui_story == nil then
				arg_292_1.var_.characterEffect1012ui_story = var_295_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_295_11 = 0.200000002980232

			if var_295_10 <= arg_292_1.time_ and arg_292_1.time_ < var_295_10 + var_295_11 and not isNil(var_295_9) then
				local var_295_12 = (arg_292_1.time_ - var_295_10) / var_295_11

				if arg_292_1.var_.characterEffect1012ui_story and not isNil(var_295_9) then
					local var_295_13 = Mathf.Lerp(0, 0.5, var_295_12)

					arg_292_1.var_.characterEffect1012ui_story.fillFlat = true
					arg_292_1.var_.characterEffect1012ui_story.fillRatio = var_295_13
				end
			end

			if arg_292_1.time_ >= var_295_10 + var_295_11 and arg_292_1.time_ < var_295_10 + var_295_11 + arg_295_0 and not isNil(var_295_9) and arg_292_1.var_.characterEffect1012ui_story then
				local var_295_14 = 0.5

				arg_292_1.var_.characterEffect1012ui_story.fillFlat = true
				arg_292_1.var_.characterEffect1012ui_story.fillRatio = var_295_14
			end

			local var_295_15 = 0
			local var_295_16 = 0.975

			if var_295_15 < arg_292_1.time_ and arg_292_1.time_ <= var_295_15 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0
				arg_292_1.dialogCg_.alpha = 1

				arg_292_1.dialog_:SetActive(true)
				SetActive(arg_292_1.leftNameGo_, false)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_292_1.iconTrs_.gameObject, false)
				arg_292_1.callingController_:SetSelectedState("normal")

				local var_295_17 = arg_292_1:GetWordFromCfg(426081069)
				local var_295_18 = arg_292_1:FormatText(var_295_17.content)

				arg_292_1.text_.text = var_295_18

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_19 = 39
				local var_295_20 = utf8.len(var_295_18)
				local var_295_21 = var_295_19 <= 0 and var_295_16 or var_295_16 * (var_295_20 / var_295_19)

				if var_295_21 > 0 and var_295_16 < var_295_21 then
					arg_292_1.talkMaxDuration = var_295_21

					if var_295_21 + var_295_15 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_21 + var_295_15
					end
				end

				arg_292_1.text_.text = var_295_18
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)
				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_22 = math.max(var_295_16, arg_292_1.talkMaxDuration)

			if var_295_15 <= arg_292_1.time_ and arg_292_1.time_ < var_295_15 + var_295_22 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - var_295_15) / var_295_22

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= var_295_15 + var_295_22 and arg_292_1.time_ < var_295_15 + var_295_22 + arg_295_0 then
				arg_292_1.typewritter.percent = 1

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(true)
			end
		end

		arg_292_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_292_1:InitPlayNodeList()
	end,
	Play426081070 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 426081070
		arg_296_1.duration_ = 9

		SetActive(arg_296_1.tipsGo_, false)

		function arg_296_1.onSingleLineFinish_()
			arg_296_1.onSingleLineUpdate_ = nil
			arg_296_1.onSingleLineFinish_ = nil
			arg_296_1.state_ = "waiting"
		end

		function arg_296_1.playNext_(arg_298_0)
			if arg_298_0 == 1 then
				arg_296_0:Play426081071(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			local var_299_0 = "J27f"

			if arg_296_1.bgs_[var_299_0] == nil then
				local var_299_1 = Object.Instantiate(arg_296_1.paintGo_)

				var_299_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_299_0)
				var_299_1.name = var_299_0
				var_299_1.transform.parent = arg_296_1.stage_.transform
				var_299_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_296_1.bgs_[var_299_0] = var_299_1
			end

			local var_299_2 = 2

			if var_299_2 < arg_296_1.time_ and arg_296_1.time_ <= var_299_2 + arg_299_0 then
				local var_299_3 = manager.ui.mainCamera.transform.localPosition
				local var_299_4 = Vector3.New(0, 0, 10) + Vector3.New(var_299_3.x, var_299_3.y, 0)
				local var_299_5 = arg_296_1.bgs_.J27f

				var_299_5.transform.localPosition = var_299_4
				var_299_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_299_6 = var_299_5:GetComponent("SpriteRenderer")

				if var_299_6 and var_299_6.sprite then
					local var_299_7 = (var_299_5.transform.localPosition - var_299_3).z
					local var_299_8 = manager.ui.mainCameraCom_
					local var_299_9 = 2 * var_299_7 * Mathf.Tan(var_299_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_299_10 = var_299_9 * var_299_8.aspect
					local var_299_11 = var_299_6.sprite.bounds.size.x
					local var_299_12 = var_299_6.sprite.bounds.size.y
					local var_299_13 = var_299_10 / var_299_11
					local var_299_14 = var_299_9 / var_299_12
					local var_299_15 = var_299_14 < var_299_13 and var_299_13 or var_299_14

					var_299_5.transform.localScale = Vector3.New(var_299_15, var_299_15, 0)
				end

				for iter_299_0, iter_299_1 in pairs(arg_296_1.bgs_) do
					if iter_299_0 ~= "J27f" then
						iter_299_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_299_16 = 3.999999999999

			if var_299_16 < arg_296_1.time_ and arg_296_1.time_ <= var_299_16 + arg_299_0 then
				arg_296_1.allBtn_.enabled = false
			end

			local var_299_17 = 0.3

			if arg_296_1.time_ >= var_299_16 + var_299_17 and arg_296_1.time_ < var_299_16 + var_299_17 + arg_299_0 then
				arg_296_1.allBtn_.enabled = true
			end

			local var_299_18 = 0

			if var_299_18 < arg_296_1.time_ and arg_296_1.time_ <= var_299_18 + arg_299_0 then
				arg_296_1.mask_.enabled = true
				arg_296_1.mask_.raycastTarget = true

				arg_296_1:SetGaussion(false)
			end

			local var_299_19 = 2

			if var_299_18 <= arg_296_1.time_ and arg_296_1.time_ < var_299_18 + var_299_19 then
				local var_299_20 = (arg_296_1.time_ - var_299_18) / var_299_19
				local var_299_21 = Color.New(0, 0, 0)

				var_299_21.a = Mathf.Lerp(0, 1, var_299_20)
				arg_296_1.mask_.color = var_299_21
			end

			if arg_296_1.time_ >= var_299_18 + var_299_19 and arg_296_1.time_ < var_299_18 + var_299_19 + arg_299_0 then
				local var_299_22 = Color.New(0, 0, 0)

				var_299_22.a = 1
				arg_296_1.mask_.color = var_299_22
			end

			local var_299_23 = 2

			if var_299_23 < arg_296_1.time_ and arg_296_1.time_ <= var_299_23 + arg_299_0 then
				arg_296_1.mask_.enabled = true
				arg_296_1.mask_.raycastTarget = true

				arg_296_1:SetGaussion(false)
			end

			local var_299_24 = 2

			if var_299_23 <= arg_296_1.time_ and arg_296_1.time_ < var_299_23 + var_299_24 then
				local var_299_25 = (arg_296_1.time_ - var_299_23) / var_299_24
				local var_299_26 = Color.New(0, 0, 0)

				var_299_26.a = Mathf.Lerp(1, 0, var_299_25)
				arg_296_1.mask_.color = var_299_26
			end

			if arg_296_1.time_ >= var_299_23 + var_299_24 and arg_296_1.time_ < var_299_23 + var_299_24 + arg_299_0 then
				local var_299_27 = Color.New(0, 0, 0)
				local var_299_28 = 0

				arg_296_1.mask_.enabled = false
				var_299_27.a = var_299_28
				arg_296_1.mask_.color = var_299_27
			end

			local var_299_29 = 2.33333333333333
			local var_299_30 = 1

			if var_299_29 < arg_296_1.time_ and arg_296_1.time_ <= var_299_29 + arg_299_0 then
				local var_299_31 = "stop"
				local var_299_32 = "effect"

				arg_296_1:AudioAction(var_299_31, var_299_32, "se_story_side_1020", "se_story_side_1020_amb_office", "")
			end

			local var_299_33 = 2.8
			local var_299_34 = 1

			if var_299_33 < arg_296_1.time_ and arg_296_1.time_ <= var_299_33 + arg_299_0 then
				local var_299_35 = "play"
				local var_299_36 = "effect"

				arg_296_1:AudioAction(var_299_35, var_299_36, "se_story_1310", "se_story_1310_amb_winter_loop", "")
			end

			if arg_296_1.frameCnt_ <= 1 then
				arg_296_1.dialog_:SetActive(false)
			end

			local var_299_37 = 3.999999999999
			local var_299_38 = 1.075

			if var_299_37 < arg_296_1.time_ and arg_296_1.time_ <= var_299_37 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0

				arg_296_1.dialog_:SetActive(true)

				arg_296_1.dialogCg_.alpha = 0

				local var_299_39 = LeanTween.value(arg_296_1.dialog_, 0, 1, 0.3)

				var_299_39:setOnUpdate(LuaHelper.FloatAction(function(arg_300_0)
					arg_296_1.dialogCg_.alpha = arg_300_0
				end))
				var_299_39:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_296_1.dialog_)
					var_299_39:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_296_1.duration_ = arg_296_1.duration_ + 0.3

				SetActive(arg_296_1.leftNameGo_, false)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_296_1.iconTrs_.gameObject, false)
				arg_296_1.callingController_:SetSelectedState("normal")

				local var_299_40 = arg_296_1:GetWordFromCfg(426081070)
				local var_299_41 = arg_296_1:FormatText(var_299_40.content)

				arg_296_1.text_.text = var_299_41

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_42 = 43
				local var_299_43 = utf8.len(var_299_41)
				local var_299_44 = var_299_42 <= 0 and var_299_38 or var_299_38 * (var_299_43 / var_299_42)

				if var_299_44 > 0 and var_299_38 < var_299_44 then
					arg_296_1.talkMaxDuration = var_299_44
					var_299_37 = var_299_37 + 0.3

					if var_299_44 + var_299_37 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_44 + var_299_37
					end
				end

				arg_296_1.text_.text = var_299_41
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)
				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_45 = var_299_37 + 0.3
			local var_299_46 = math.max(var_299_38, arg_296_1.talkMaxDuration)

			if var_299_45 <= arg_296_1.time_ and arg_296_1.time_ < var_299_45 + var_299_46 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - var_299_45) / var_299_46

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= var_299_45 + var_299_46 and arg_296_1.time_ < var_299_45 + var_299_46 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {}

		arg_296_1:InitPlayNodeList()
	end,
	Play426081071 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 426081071
		arg_302_1.duration_ = 5

		SetActive(arg_302_1.tipsGo_, false)

		function arg_302_1.onSingleLineFinish_()
			arg_302_1.onSingleLineUpdate_ = nil
			arg_302_1.onSingleLineFinish_ = nil
			arg_302_1.state_ = "waiting"
		end

		function arg_302_1.playNext_(arg_304_0)
			if arg_304_0 == 1 then
				arg_302_0:Play426081072(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			local var_305_0 = 0
			local var_305_1 = 0.325

			if var_305_0 < arg_302_1.time_ and arg_302_1.time_ <= var_305_0 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0
				arg_302_1.dialogCg_.alpha = 1

				arg_302_1.dialog_:SetActive(true)
				SetActive(arg_302_1.leftNameGo_, true)

				local var_305_2 = arg_302_1:FormatText(StoryNameCfg[7].name)

				arg_302_1.leftNameTxt_.text = var_305_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_302_1.leftNameTxt_.transform)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1.leftNameTxt_.text)
				SetActive(arg_302_1.iconTrs_.gameObject, true)
				arg_302_1.iconController_:SetSelectedState("hero")

				arg_302_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_302_1.callingController_:SetSelectedState("normal")

				arg_302_1.keyicon_.color = Color.New(1, 1, 1)
				arg_302_1.icon_.color = Color.New(1, 1, 1)

				local var_305_3 = arg_302_1:GetWordFromCfg(426081071)
				local var_305_4 = arg_302_1:FormatText(var_305_3.content)

				arg_302_1.text_.text = var_305_4

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_5 = 13
				local var_305_6 = utf8.len(var_305_4)
				local var_305_7 = var_305_5 <= 0 and var_305_1 or var_305_1 * (var_305_6 / var_305_5)

				if var_305_7 > 0 and var_305_1 < var_305_7 then
					arg_302_1.talkMaxDuration = var_305_7

					if var_305_7 + var_305_0 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_7 + var_305_0
					end
				end

				arg_302_1.text_.text = var_305_4
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)
				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_8 = math.max(var_305_1, arg_302_1.talkMaxDuration)

			if var_305_0 <= arg_302_1.time_ and arg_302_1.time_ < var_305_0 + var_305_8 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - var_305_0) / var_305_8

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= var_305_0 + var_305_8 and arg_302_1.time_ < var_305_0 + var_305_8 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {}

		arg_302_1:InitPlayNodeList()
	end,
	Play426081072 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 426081072
		arg_306_1.duration_ = 7.23

		local var_306_0 = {
			zh = 5.1,
			ja = 7.233
		}
		local var_306_1 = manager.audio:GetLocalizationFlag()

		if var_306_0[var_306_1] ~= nil then
			arg_306_1.duration_ = var_306_0[var_306_1]
		end

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
		end

		function arg_306_1.playNext_(arg_308_0)
			if arg_308_0 == 1 then
				arg_306_0:Play426081073(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			local var_309_0 = arg_306_1.actors_["1012ui_story"].transform
			local var_309_1 = 0

			if var_309_1 < arg_306_1.time_ and arg_306_1.time_ <= var_309_1 + arg_309_0 then
				arg_306_1.var_.moveOldPos1012ui_story = var_309_0.localPosition
			end

			local var_309_2 = 0.001

			if var_309_1 <= arg_306_1.time_ and arg_306_1.time_ < var_309_1 + var_309_2 then
				local var_309_3 = (arg_306_1.time_ - var_309_1) / var_309_2
				local var_309_4 = Vector3.New(0, -1.05, -6.24)

				var_309_0.localPosition = Vector3.Lerp(arg_306_1.var_.moveOldPos1012ui_story, var_309_4, var_309_3)

				local var_309_5 = manager.ui.mainCamera.transform.position - var_309_0.position

				var_309_0.forward = Vector3.New(var_309_5.x, var_309_5.y, var_309_5.z)

				local var_309_6 = var_309_0.localEulerAngles

				var_309_6.z = 0
				var_309_6.x = 0
				var_309_0.localEulerAngles = var_309_6
			end

			if arg_306_1.time_ >= var_309_1 + var_309_2 and arg_306_1.time_ < var_309_1 + var_309_2 + arg_309_0 then
				var_309_0.localPosition = Vector3.New(0, -1.05, -6.24)

				local var_309_7 = manager.ui.mainCamera.transform.position - var_309_0.position

				var_309_0.forward = Vector3.New(var_309_7.x, var_309_7.y, var_309_7.z)

				local var_309_8 = var_309_0.localEulerAngles

				var_309_8.z = 0
				var_309_8.x = 0
				var_309_0.localEulerAngles = var_309_8
			end

			local var_309_9 = arg_306_1.actors_["1012ui_story"]
			local var_309_10 = 0

			if var_309_10 < arg_306_1.time_ and arg_306_1.time_ <= var_309_10 + arg_309_0 and not isNil(var_309_9) and arg_306_1.var_.characterEffect1012ui_story == nil then
				arg_306_1.var_.characterEffect1012ui_story = var_309_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_309_11 = 0.200000002980232

			if var_309_10 <= arg_306_1.time_ and arg_306_1.time_ < var_309_10 + var_309_11 and not isNil(var_309_9) then
				local var_309_12 = (arg_306_1.time_ - var_309_10) / var_309_11

				if arg_306_1.var_.characterEffect1012ui_story and not isNil(var_309_9) then
					arg_306_1.var_.characterEffect1012ui_story.fillFlat = false
				end
			end

			if arg_306_1.time_ >= var_309_10 + var_309_11 and arg_306_1.time_ < var_309_10 + var_309_11 + arg_309_0 and not isNil(var_309_9) and arg_306_1.var_.characterEffect1012ui_story then
				arg_306_1.var_.characterEffect1012ui_story.fillFlat = false
			end

			local var_309_13 = 0

			if var_309_13 < arg_306_1.time_ and arg_306_1.time_ <= var_309_13 + arg_309_0 then
				arg_306_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012action/1012action4_1")
			end

			local var_309_14 = 0
			local var_309_15 = 0.625

			if var_309_14 < arg_306_1.time_ and arg_306_1.time_ <= var_309_14 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, true)

				local var_309_16 = arg_306_1:FormatText(StoryNameCfg[595].name)

				arg_306_1.leftNameTxt_.text = var_309_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_306_1.leftNameTxt_.transform)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1.leftNameTxt_.text)
				SetActive(arg_306_1.iconTrs_.gameObject, false)
				arg_306_1.callingController_:SetSelectedState("normal")

				local var_309_17 = arg_306_1:GetWordFromCfg(426081072)
				local var_309_18 = arg_306_1:FormatText(var_309_17.content)

				arg_306_1.text_.text = var_309_18

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_19 = 25
				local var_309_20 = utf8.len(var_309_18)
				local var_309_21 = var_309_19 <= 0 and var_309_15 or var_309_15 * (var_309_20 / var_309_19)

				if var_309_21 > 0 and var_309_15 < var_309_21 then
					arg_306_1.talkMaxDuration = var_309_21

					if var_309_21 + var_309_14 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_21 + var_309_14
					end
				end

				arg_306_1.text_.text = var_309_18
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426081", "426081072", "story_v_out_426081.awb") ~= 0 then
					local var_309_22 = manager.audio:GetVoiceLength("story_v_out_426081", "426081072", "story_v_out_426081.awb") / 1000

					if var_309_22 + var_309_14 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_22 + var_309_14
					end

					if var_309_17.prefab_name ~= "" and arg_306_1.actors_[var_309_17.prefab_name] ~= nil then
						local var_309_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_306_1.actors_[var_309_17.prefab_name].transform, "story_v_out_426081", "426081072", "story_v_out_426081.awb")

						arg_306_1:RecordAudio("426081072", var_309_23)
						arg_306_1:RecordAudio("426081072", var_309_23)
					else
						arg_306_1:AudioAction("play", "voice", "story_v_out_426081", "426081072", "story_v_out_426081.awb")
					end

					arg_306_1:RecordHistoryTalkVoice("story_v_out_426081", "426081072", "story_v_out_426081.awb")
				end

				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_24 = math.max(var_309_15, arg_306_1.talkMaxDuration)

			if var_309_14 <= arg_306_1.time_ and arg_306_1.time_ < var_309_14 + var_309_24 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - var_309_14) / var_309_24

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= var_309_14 + var_309_24 and arg_306_1.time_ < var_309_14 + var_309_24 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_306_1:InitPlayNodeList()
	end,
	Play426081073 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 426081073
		arg_310_1.duration_ = 5

		SetActive(arg_310_1.tipsGo_, false)

		function arg_310_1.onSingleLineFinish_()
			arg_310_1.onSingleLineUpdate_ = nil
			arg_310_1.onSingleLineFinish_ = nil
			arg_310_1.state_ = "waiting"
		end

		function arg_310_1.playNext_(arg_312_0)
			if arg_312_0 == 1 then
				arg_310_0:Play426081074(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			local var_313_0 = arg_310_1.actors_["1012ui_story"]
			local var_313_1 = 0

			if var_313_1 < arg_310_1.time_ and arg_310_1.time_ <= var_313_1 + arg_313_0 and not isNil(var_313_0) and arg_310_1.var_.characterEffect1012ui_story == nil then
				arg_310_1.var_.characterEffect1012ui_story = var_313_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_313_2 = 0.200000002980232

			if var_313_1 <= arg_310_1.time_ and arg_310_1.time_ < var_313_1 + var_313_2 and not isNil(var_313_0) then
				local var_313_3 = (arg_310_1.time_ - var_313_1) / var_313_2

				if arg_310_1.var_.characterEffect1012ui_story and not isNil(var_313_0) then
					local var_313_4 = Mathf.Lerp(0, 0.5, var_313_3)

					arg_310_1.var_.characterEffect1012ui_story.fillFlat = true
					arg_310_1.var_.characterEffect1012ui_story.fillRatio = var_313_4
				end
			end

			if arg_310_1.time_ >= var_313_1 + var_313_2 and arg_310_1.time_ < var_313_1 + var_313_2 + arg_313_0 and not isNil(var_313_0) and arg_310_1.var_.characterEffect1012ui_story then
				local var_313_5 = 0.5

				arg_310_1.var_.characterEffect1012ui_story.fillFlat = true
				arg_310_1.var_.characterEffect1012ui_story.fillRatio = var_313_5
			end

			local var_313_6 = 0
			local var_313_7 = 0.925

			if var_313_6 < arg_310_1.time_ and arg_310_1.time_ <= var_313_6 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0
				arg_310_1.dialogCg_.alpha = 1

				arg_310_1.dialog_:SetActive(true)
				SetActive(arg_310_1.leftNameGo_, true)

				local var_313_8 = arg_310_1:FormatText(StoryNameCfg[7].name)

				arg_310_1.leftNameTxt_.text = var_313_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_310_1.leftNameTxt_.transform)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1.leftNameTxt_.text)
				SetActive(arg_310_1.iconTrs_.gameObject, true)
				arg_310_1.iconController_:SetSelectedState("hero")

				arg_310_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_310_1.callingController_:SetSelectedState("normal")

				arg_310_1.keyicon_.color = Color.New(1, 1, 1)
				arg_310_1.icon_.color = Color.New(1, 1, 1)

				local var_313_9 = arg_310_1:GetWordFromCfg(426081073)
				local var_313_10 = arg_310_1:FormatText(var_313_9.content)

				arg_310_1.text_.text = var_313_10

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_11 = 37
				local var_313_12 = utf8.len(var_313_10)
				local var_313_13 = var_313_11 <= 0 and var_313_7 or var_313_7 * (var_313_12 / var_313_11)

				if var_313_13 > 0 and var_313_7 < var_313_13 then
					arg_310_1.talkMaxDuration = var_313_13

					if var_313_13 + var_313_6 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_13 + var_313_6
					end
				end

				arg_310_1.text_.text = var_313_10
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)
				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_14 = math.max(var_313_7, arg_310_1.talkMaxDuration)

			if var_313_6 <= arg_310_1.time_ and arg_310_1.time_ < var_313_6 + var_313_14 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - var_313_6) / var_313_14

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= var_313_6 + var_313_14 and arg_310_1.time_ < var_313_6 + var_313_14 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {}

		arg_310_1:InitPlayNodeList()
	end,
	Play426081074 = function(arg_314_0, arg_314_1)
		arg_314_1.time_ = 0
		arg_314_1.frameCnt_ = 0
		arg_314_1.state_ = "playing"
		arg_314_1.curTalkId_ = 426081074
		arg_314_1.duration_ = 5

		SetActive(arg_314_1.tipsGo_, false)

		function arg_314_1.onSingleLineFinish_()
			arg_314_1.onSingleLineUpdate_ = nil
			arg_314_1.onSingleLineFinish_ = nil
			arg_314_1.state_ = "waiting"
		end

		function arg_314_1.playNext_(arg_316_0)
			if arg_316_0 == 1 then
				arg_314_0:Play426081075(arg_314_1)
			end
		end

		function arg_314_1.onSingleLineUpdate_(arg_317_0)
			local var_317_0 = arg_314_1.actors_["1012ui_story"].transform
			local var_317_1 = 0

			if var_317_1 < arg_314_1.time_ and arg_314_1.time_ <= var_317_1 + arg_317_0 then
				arg_314_1.var_.moveOldPos1012ui_story = var_317_0.localPosition
			end

			local var_317_2 = 0.001

			if var_317_1 <= arg_314_1.time_ and arg_314_1.time_ < var_317_1 + var_317_2 then
				local var_317_3 = (arg_314_1.time_ - var_317_1) / var_317_2
				local var_317_4 = Vector3.New(0, 100, 0)

				var_317_0.localPosition = Vector3.Lerp(arg_314_1.var_.moveOldPos1012ui_story, var_317_4, var_317_3)

				local var_317_5 = manager.ui.mainCamera.transform.position - var_317_0.position

				var_317_0.forward = Vector3.New(var_317_5.x, var_317_5.y, var_317_5.z)

				local var_317_6 = var_317_0.localEulerAngles

				var_317_6.z = 0
				var_317_6.x = 0
				var_317_0.localEulerAngles = var_317_6
			end

			if arg_314_1.time_ >= var_317_1 + var_317_2 and arg_314_1.time_ < var_317_1 + var_317_2 + arg_317_0 then
				var_317_0.localPosition = Vector3.New(0, 100, 0)

				local var_317_7 = manager.ui.mainCamera.transform.position - var_317_0.position

				var_317_0.forward = Vector3.New(var_317_7.x, var_317_7.y, var_317_7.z)

				local var_317_8 = var_317_0.localEulerAngles

				var_317_8.z = 0
				var_317_8.x = 0
				var_317_0.localEulerAngles = var_317_8
			end

			local var_317_9 = 0
			local var_317_10 = 1

			if var_317_9 < arg_314_1.time_ and arg_314_1.time_ <= var_317_9 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0
				arg_314_1.dialogCg_.alpha = 1

				arg_314_1.dialog_:SetActive(true)
				SetActive(arg_314_1.leftNameGo_, false)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_314_1.iconTrs_.gameObject, false)
				arg_314_1.callingController_:SetSelectedState("normal")

				local var_317_11 = arg_314_1:GetWordFromCfg(426081074)
				local var_317_12 = arg_314_1:FormatText(var_317_11.content)

				arg_314_1.text_.text = var_317_12

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_13 = 40
				local var_317_14 = utf8.len(var_317_12)
				local var_317_15 = var_317_13 <= 0 and var_317_10 or var_317_10 * (var_317_14 / var_317_13)

				if var_317_15 > 0 and var_317_10 < var_317_15 then
					arg_314_1.talkMaxDuration = var_317_15

					if var_317_15 + var_317_9 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_15 + var_317_9
					end
				end

				arg_314_1.text_.text = var_317_12
				arg_314_1.typewritter.percent = 0

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(false)
				arg_314_1:RecordContent(arg_314_1.text_.text)
			end

			local var_317_16 = math.max(var_317_10, arg_314_1.talkMaxDuration)

			if var_317_9 <= arg_314_1.time_ and arg_314_1.time_ < var_317_9 + var_317_16 then
				arg_314_1.typewritter.percent = (arg_314_1.time_ - var_317_9) / var_317_16

				arg_314_1.typewritter:SetDirty()
			end

			if arg_314_1.time_ >= var_317_9 + var_317_16 and arg_314_1.time_ < var_317_9 + var_317_16 + arg_317_0 then
				arg_314_1.typewritter.percent = 1

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(true)
			end
		end

		arg_314_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_314_1:InitPlayNodeList()
	end,
	Play426081075 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 426081075
		arg_318_1.duration_ = 9

		SetActive(arg_318_1.tipsGo_, false)

		function arg_318_1.onSingleLineFinish_()
			arg_318_1.onSingleLineUpdate_ = nil
			arg_318_1.onSingleLineFinish_ = nil
			arg_318_1.state_ = "waiting"
		end

		function arg_318_1.playNext_(arg_320_0)
			if arg_320_0 == 1 then
				arg_318_0:Play426081076(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			local var_321_0 = 2

			if var_321_0 < arg_318_1.time_ and arg_318_1.time_ <= var_321_0 + arg_321_0 then
				local var_321_1 = manager.ui.mainCamera.transform.localPosition
				local var_321_2 = Vector3.New(0, 0, 10) + Vector3.New(var_321_1.x, var_321_1.y, 0)
				local var_321_3 = arg_318_1.bgs_.J27f

				var_321_3.transform.localPosition = var_321_2
				var_321_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_321_4 = var_321_3:GetComponent("SpriteRenderer")

				if var_321_4 and var_321_4.sprite then
					local var_321_5 = (var_321_3.transform.localPosition - var_321_1).z
					local var_321_6 = manager.ui.mainCameraCom_
					local var_321_7 = 2 * var_321_5 * Mathf.Tan(var_321_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_321_8 = var_321_7 * var_321_6.aspect
					local var_321_9 = var_321_4.sprite.bounds.size.x
					local var_321_10 = var_321_4.sprite.bounds.size.y
					local var_321_11 = var_321_8 / var_321_9
					local var_321_12 = var_321_7 / var_321_10
					local var_321_13 = var_321_12 < var_321_11 and var_321_11 or var_321_12

					var_321_3.transform.localScale = Vector3.New(var_321_13, var_321_13, 0)
				end

				for iter_321_0, iter_321_1 in pairs(arg_318_1.bgs_) do
					if iter_321_0 ~= "J27f" then
						iter_321_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_321_14 = 4

			if var_321_14 < arg_318_1.time_ and arg_318_1.time_ <= var_321_14 + arg_321_0 then
				arg_318_1.allBtn_.enabled = false
			end

			local var_321_15 = 0.3

			if arg_318_1.time_ >= var_321_14 + var_321_15 and arg_318_1.time_ < var_321_14 + var_321_15 + arg_321_0 then
				arg_318_1.allBtn_.enabled = true
			end

			local var_321_16 = 0

			if var_321_16 < arg_318_1.time_ and arg_318_1.time_ <= var_321_16 + arg_321_0 then
				arg_318_1.mask_.enabled = true
				arg_318_1.mask_.raycastTarget = true

				arg_318_1:SetGaussion(false)
			end

			local var_321_17 = 2

			if var_321_16 <= arg_318_1.time_ and arg_318_1.time_ < var_321_16 + var_321_17 then
				local var_321_18 = (arg_318_1.time_ - var_321_16) / var_321_17
				local var_321_19 = Color.New(0, 0, 0)

				var_321_19.a = Mathf.Lerp(0, 1, var_321_18)
				arg_318_1.mask_.color = var_321_19
			end

			if arg_318_1.time_ >= var_321_16 + var_321_17 and arg_318_1.time_ < var_321_16 + var_321_17 + arg_321_0 then
				local var_321_20 = Color.New(0, 0, 0)

				var_321_20.a = 1
				arg_318_1.mask_.color = var_321_20
			end

			local var_321_21 = 2

			if var_321_21 < arg_318_1.time_ and arg_318_1.time_ <= var_321_21 + arg_321_0 then
				arg_318_1.mask_.enabled = true
				arg_318_1.mask_.raycastTarget = true

				arg_318_1:SetGaussion(false)
			end

			local var_321_22 = 2

			if var_321_21 <= arg_318_1.time_ and arg_318_1.time_ < var_321_21 + var_321_22 then
				local var_321_23 = (arg_318_1.time_ - var_321_21) / var_321_22
				local var_321_24 = Color.New(0, 0, 0)

				var_321_24.a = Mathf.Lerp(1, 0, var_321_23)
				arg_318_1.mask_.color = var_321_24
			end

			if arg_318_1.time_ >= var_321_21 + var_321_22 and arg_318_1.time_ < var_321_21 + var_321_22 + arg_321_0 then
				local var_321_25 = Color.New(0, 0, 0)
				local var_321_26 = 0

				arg_318_1.mask_.enabled = false
				var_321_25.a = var_321_26
				arg_318_1.mask_.color = var_321_25
			end

			local var_321_27 = 2
			local var_321_28 = 0.3

			if var_321_27 < arg_318_1.time_ and arg_318_1.time_ <= var_321_27 + arg_321_0 then
				local var_321_29 = "play"
				local var_321_30 = "music"

				arg_318_1:AudioAction(var_321_29, var_321_30, "ui_battle", "ui_battle_stopbgm", "")

				local var_321_31 = ""
				local var_321_32 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_321_32 ~= "" then
					if arg_318_1.bgmTxt_.text ~= var_321_32 and arg_318_1.bgmTxt_.text ~= "" then
						if arg_318_1.bgmTxt2_.text ~= "" then
							arg_318_1.bgmTxt_.text = arg_318_1.bgmTxt2_.text
						end

						arg_318_1.bgmTxt2_.text = var_321_32

						arg_318_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_318_1.bgmTxt_.text = var_321_32
						arg_318_1.bgmTxt2_.text = var_321_32
					end

					if arg_318_1.bgmTimer then
						arg_318_1.bgmTimer:Stop()

						arg_318_1.bgmTimer = nil
					end

					if arg_318_1.settingData.show_music_name == 1 then
						arg_318_1.musicController:SetSelectedState("show")
						arg_318_1.musicAnimator_:Play("open", 0, 0)

						if arg_318_1.settingData.music_time ~= 0 then
							arg_318_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_318_1.settingData.music_time), function()
								if arg_318_1 == nil or isNil(arg_318_1.bgmTxt_) then
									return
								end

								arg_318_1.musicController:SetSelectedState("hide")
								arg_318_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_321_33 = manager.ui.mainCamera.transform
			local var_321_34 = 2

			if var_321_34 < arg_318_1.time_ and arg_318_1.time_ <= var_321_34 + arg_321_0 then
				local var_321_35 = arg_318_1.var_.effectshanshangfeng1
				local var_321_36
				local var_321_37 = var_321_33

				if not var_321_35 then
					var_321_35 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_qiliu_in_keep"), var_321_37)
					var_321_35.name = "shanshangfeng1"
					arg_318_1.var_.effectshanshangfeng1 = var_321_35
				else
					var_321_35.transform:SetParent(var_321_37)
				end

				var_321_35.transform.localPosition = Vector3.New(0, 0, 0)
				var_321_35.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if arg_318_1.frameCnt_ <= 1 then
				arg_318_1.dialog_:SetActive(false)
			end

			local var_321_38 = 4
			local var_321_39 = 0.9

			if var_321_38 < arg_318_1.time_ and arg_318_1.time_ <= var_321_38 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0

				arg_318_1.dialog_:SetActive(true)

				arg_318_1.dialogCg_.alpha = 0

				local var_321_40 = LeanTween.value(arg_318_1.dialog_, 0, 1, 0.3)

				var_321_40:setOnUpdate(LuaHelper.FloatAction(function(arg_323_0)
					arg_318_1.dialogCg_.alpha = arg_323_0
				end))
				var_321_40:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_318_1.dialog_)
					var_321_40:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_318_1.duration_ = arg_318_1.duration_ + 0.3

				SetActive(arg_318_1.leftNameGo_, false)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_318_1.iconTrs_.gameObject, false)
				arg_318_1.callingController_:SetSelectedState("normal")

				local var_321_41 = arg_318_1:GetWordFromCfg(426081075)
				local var_321_42 = arg_318_1:FormatText(var_321_41.content)

				arg_318_1.text_.text = var_321_42

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_43 = 36
				local var_321_44 = utf8.len(var_321_42)
				local var_321_45 = var_321_43 <= 0 and var_321_39 or var_321_39 * (var_321_44 / var_321_43)

				if var_321_45 > 0 and var_321_39 < var_321_45 then
					arg_318_1.talkMaxDuration = var_321_45
					var_321_38 = var_321_38 + 0.3

					if var_321_45 + var_321_38 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_45 + var_321_38
					end
				end

				arg_318_1.text_.text = var_321_42
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)
				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_46 = var_321_38 + 0.3
			local var_321_47 = math.max(var_321_39, arg_318_1.talkMaxDuration)

			if var_321_46 <= arg_318_1.time_ and arg_318_1.time_ < var_321_46 + var_321_47 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - var_321_46) / var_321_47

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= var_321_46 + var_321_47 and arg_318_1.time_ < var_321_46 + var_321_47 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {}

		arg_318_1:InitPlayNodeList()
	end,
	Play426081076 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 426081076
		arg_325_1.duration_ = 5

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play426081077(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			local var_328_0 = 0
			local var_328_1 = 0.3

			if var_328_0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_0 + arg_328_0 then
				local var_328_2 = "play"
				local var_328_3 = "music"

				arg_325_1:AudioAction(var_328_2, var_328_3, "ui_battle", "ui_battle_stopbgm", "")

				local var_328_4 = ""
				local var_328_5 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_328_5 ~= "" then
					if arg_325_1.bgmTxt_.text ~= var_328_5 and arg_325_1.bgmTxt_.text ~= "" then
						if arg_325_1.bgmTxt2_.text ~= "" then
							arg_325_1.bgmTxt_.text = arg_325_1.bgmTxt2_.text
						end

						arg_325_1.bgmTxt2_.text = var_328_5

						arg_325_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_325_1.bgmTxt_.text = var_328_5
						arg_325_1.bgmTxt2_.text = var_328_5
					end

					if arg_325_1.bgmTimer then
						arg_325_1.bgmTimer:Stop()

						arg_325_1.bgmTimer = nil
					end

					if arg_325_1.settingData.show_music_name == 1 then
						arg_325_1.musicController:SetSelectedState("show")
						arg_325_1.musicAnimator_:Play("open", 0, 0)

						if arg_325_1.settingData.music_time ~= 0 then
							arg_325_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_325_1.settingData.music_time), function()
								if arg_325_1 == nil or isNil(arg_325_1.bgmTxt_) then
									return
								end

								arg_325_1.musicController:SetSelectedState("hide")
								arg_325_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_328_6 = 0.3
			local var_328_7 = 1

			if var_328_6 < arg_325_1.time_ and arg_325_1.time_ <= var_328_6 + arg_328_0 then
				local var_328_8 = "play"
				local var_328_9 = "music"

				arg_325_1:AudioAction(var_328_8, var_328_9, "bgm_activity_3_0_story_sad", "bgm_activity_3_0_story_sad", "bgm_activity_3_0_story_sad.awb")

				local var_328_10 = ""
				local var_328_11 = manager.audio:GetAudioName("bgm_activity_3_0_story_sad", "bgm_activity_3_0_story_sad")

				if var_328_11 ~= "" then
					if arg_325_1.bgmTxt_.text ~= var_328_11 and arg_325_1.bgmTxt_.text ~= "" then
						if arg_325_1.bgmTxt2_.text ~= "" then
							arg_325_1.bgmTxt_.text = arg_325_1.bgmTxt2_.text
						end

						arg_325_1.bgmTxt2_.text = var_328_11

						arg_325_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_325_1.bgmTxt_.text = var_328_11
						arg_325_1.bgmTxt2_.text = var_328_11
					end

					if arg_325_1.bgmTimer then
						arg_325_1.bgmTimer:Stop()

						arg_325_1.bgmTimer = nil
					end

					if arg_325_1.settingData.show_music_name == 1 then
						arg_325_1.musicController:SetSelectedState("show")
						arg_325_1.musicAnimator_:Play("open", 0, 0)

						if arg_325_1.settingData.music_time ~= 0 then
							arg_325_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_325_1.settingData.music_time), function()
								if arg_325_1 == nil or isNil(arg_325_1.bgmTxt_) then
									return
								end

								arg_325_1.musicController:SetSelectedState("hide")
								arg_325_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_328_12 = 0
			local var_328_13 = 0.7

			if var_328_12 < arg_325_1.time_ and arg_325_1.time_ <= var_328_12 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				local var_328_14 = arg_325_1:FormatText(StoryNameCfg[7].name)

				arg_325_1.leftNameTxt_.text = var_328_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, true)
				arg_325_1.iconController_:SetSelectedState("hero")

				arg_325_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_325_1.callingController_:SetSelectedState("normal")

				arg_325_1.keyicon_.color = Color.New(1, 1, 1)
				arg_325_1.icon_.color = Color.New(1, 1, 1)

				local var_328_15 = arg_325_1:GetWordFromCfg(426081076)
				local var_328_16 = arg_325_1:FormatText(var_328_15.content)

				arg_325_1.text_.text = var_328_16

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_17 = 28
				local var_328_18 = utf8.len(var_328_16)
				local var_328_19 = var_328_17 <= 0 and var_328_13 or var_328_13 * (var_328_18 / var_328_17)

				if var_328_19 > 0 and var_328_13 < var_328_19 then
					arg_325_1.talkMaxDuration = var_328_19

					if var_328_19 + var_328_12 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_19 + var_328_12
					end
				end

				arg_325_1.text_.text = var_328_16
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)
				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_20 = math.max(var_328_13, arg_325_1.talkMaxDuration)

			if var_328_12 <= arg_325_1.time_ and arg_325_1.time_ < var_328_12 + var_328_20 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_12) / var_328_20

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_12 + var_328_20 and arg_325_1.time_ < var_328_12 + var_328_20 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play426081077 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 426081077
		arg_331_1.duration_ = 1.8

		local var_331_0 = {
			zh = 1.8,
			ja = 1.3
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
				arg_331_0:Play426081078(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			local var_334_0 = 0
			local var_334_1 = 0.125

			if var_334_0 < arg_331_1.time_ and arg_331_1.time_ <= var_334_0 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, true)

				local var_334_2 = arg_331_1:FormatText(StoryNameCfg[1487].name)

				arg_331_1.leftNameTxt_.text = var_334_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_331_1.leftNameTxt_.transform)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1.leftNameTxt_.text)
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_3 = arg_331_1:GetWordFromCfg(426081077)
				local var_334_4 = arg_331_1:FormatText(var_334_3.content)

				arg_331_1.text_.text = var_334_4

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_5 = 5
				local var_334_6 = utf8.len(var_334_4)
				local var_334_7 = var_334_5 <= 0 and var_334_1 or var_334_1 * (var_334_6 / var_334_5)

				if var_334_7 > 0 and var_334_1 < var_334_7 then
					arg_331_1.talkMaxDuration = var_334_7

					if var_334_7 + var_334_0 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_7 + var_334_0
					end
				end

				arg_331_1.text_.text = var_334_4
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426081", "426081077", "story_v_out_426081.awb") ~= 0 then
					local var_334_8 = manager.audio:GetVoiceLength("story_v_out_426081", "426081077", "story_v_out_426081.awb") / 1000

					if var_334_8 + var_334_0 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_8 + var_334_0
					end

					if var_334_3.prefab_name ~= "" and arg_331_1.actors_[var_334_3.prefab_name] ~= nil then
						local var_334_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_331_1.actors_[var_334_3.prefab_name].transform, "story_v_out_426081", "426081077", "story_v_out_426081.awb")

						arg_331_1:RecordAudio("426081077", var_334_9)
						arg_331_1:RecordAudio("426081077", var_334_9)
					else
						arg_331_1:AudioAction("play", "voice", "story_v_out_426081", "426081077", "story_v_out_426081.awb")
					end

					arg_331_1:RecordHistoryTalkVoice("story_v_out_426081", "426081077", "story_v_out_426081.awb")
				end

				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_10 = math.max(var_334_1, arg_331_1.talkMaxDuration)

			if var_334_0 <= arg_331_1.time_ and arg_331_1.time_ < var_334_0 + var_334_10 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_0) / var_334_10

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_0 + var_334_10 and arg_331_1.time_ < var_334_0 + var_334_10 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {}

		arg_331_1:InitPlayNodeList()
	end,
	Play426081078 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 426081078
		arg_335_1.duration_ = 5

		SetActive(arg_335_1.tipsGo_, false)

		function arg_335_1.onSingleLineFinish_()
			arg_335_1.onSingleLineUpdate_ = nil
			arg_335_1.onSingleLineFinish_ = nil
			arg_335_1.state_ = "waiting"
		end

		function arg_335_1.playNext_(arg_337_0)
			if arg_337_0 == 1 then
				arg_335_0:Play426081079(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			local var_338_0 = 0
			local var_338_1 = 0.075

			if var_338_0 < arg_335_1.time_ and arg_335_1.time_ <= var_338_0 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				local var_338_2 = arg_335_1:FormatText(StoryNameCfg[7].name)

				arg_335_1.leftNameTxt_.text = var_338_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, true)
				arg_335_1.iconController_:SetSelectedState("hero")

				arg_335_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_335_1.callingController_:SetSelectedState("normal")

				arg_335_1.keyicon_.color = Color.New(1, 1, 1)
				arg_335_1.icon_.color = Color.New(1, 1, 1)

				local var_338_3 = arg_335_1:GetWordFromCfg(426081078)
				local var_338_4 = arg_335_1:FormatText(var_338_3.content)

				arg_335_1.text_.text = var_338_4

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_5 = 3
				local var_338_6 = utf8.len(var_338_4)
				local var_338_7 = var_338_5 <= 0 and var_338_1 or var_338_1 * (var_338_6 / var_338_5)

				if var_338_7 > 0 and var_338_1 < var_338_7 then
					arg_335_1.talkMaxDuration = var_338_7

					if var_338_7 + var_338_0 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_7 + var_338_0
					end
				end

				arg_335_1.text_.text = var_338_4
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)
				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_8 = math.max(var_338_1, arg_335_1.talkMaxDuration)

			if var_338_0 <= arg_335_1.time_ and arg_335_1.time_ < var_338_0 + var_338_8 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - var_338_0) / var_338_8

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= var_338_0 + var_338_8 and arg_335_1.time_ < var_338_0 + var_338_8 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {}

		arg_335_1:InitPlayNodeList()
	end,
	Play426081079 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 426081079
		arg_339_1.duration_ = 5

		SetActive(arg_339_1.tipsGo_, false)

		function arg_339_1.onSingleLineFinish_()
			arg_339_1.onSingleLineUpdate_ = nil
			arg_339_1.onSingleLineFinish_ = nil
			arg_339_1.state_ = "waiting"
		end

		function arg_339_1.playNext_(arg_341_0)
			if arg_341_0 == 1 then
				arg_339_0:Play426081080(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			local var_342_0 = 0
			local var_342_1 = 0.875

			if var_342_0 < arg_339_1.time_ and arg_339_1.time_ <= var_342_0 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, false)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_339_1.iconTrs_.gameObject, false)
				arg_339_1.callingController_:SetSelectedState("normal")

				local var_342_2 = arg_339_1:GetWordFromCfg(426081079)
				local var_342_3 = arg_339_1:FormatText(var_342_2.content)

				arg_339_1.text_.text = var_342_3

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_4 = 35
				local var_342_5 = utf8.len(var_342_3)
				local var_342_6 = var_342_4 <= 0 and var_342_1 or var_342_1 * (var_342_5 / var_342_4)

				if var_342_6 > 0 and var_342_1 < var_342_6 then
					arg_339_1.talkMaxDuration = var_342_6

					if var_342_6 + var_342_0 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_6 + var_342_0
					end
				end

				arg_339_1.text_.text = var_342_3
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)
				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_7 = math.max(var_342_1, arg_339_1.talkMaxDuration)

			if var_342_0 <= arg_339_1.time_ and arg_339_1.time_ < var_342_0 + var_342_7 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_0) / var_342_7

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_0 + var_342_7 and arg_339_1.time_ < var_342_0 + var_342_7 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {}

		arg_339_1:InitPlayNodeList()
	end,
	Play426081080 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 426081080
		arg_343_1.duration_ = 5

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play426081081(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			local var_346_0 = 0
			local var_346_1 = 0.175

			if var_346_0 < arg_343_1.time_ and arg_343_1.time_ <= var_346_0 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, true)

				local var_346_2 = arg_343_1:FormatText(StoryNameCfg[7].name)

				arg_343_1.leftNameTxt_.text = var_346_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_343_1.leftNameTxt_.transform)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1.leftNameTxt_.text)
				SetActive(arg_343_1.iconTrs_.gameObject, true)
				arg_343_1.iconController_:SetSelectedState("hero")

				arg_343_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_343_1.callingController_:SetSelectedState("normal")

				arg_343_1.keyicon_.color = Color.New(1, 1, 1)
				arg_343_1.icon_.color = Color.New(1, 1, 1)

				local var_346_3 = arg_343_1:GetWordFromCfg(426081080)
				local var_346_4 = arg_343_1:FormatText(var_346_3.content)

				arg_343_1.text_.text = var_346_4

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_5 = 7
				local var_346_6 = utf8.len(var_346_4)
				local var_346_7 = var_346_5 <= 0 and var_346_1 or var_346_1 * (var_346_6 / var_346_5)

				if var_346_7 > 0 and var_346_1 < var_346_7 then
					arg_343_1.talkMaxDuration = var_346_7

					if var_346_7 + var_346_0 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_7 + var_346_0
					end
				end

				arg_343_1.text_.text = var_346_4
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)
				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_8 = math.max(var_346_1, arg_343_1.talkMaxDuration)

			if var_346_0 <= arg_343_1.time_ and arg_343_1.time_ < var_346_0 + var_346_8 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_0) / var_346_8

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_0 + var_346_8 and arg_343_1.time_ < var_346_0 + var_346_8 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {}

		arg_343_1:InitPlayNodeList()
	end,
	Play426081081 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 426081081
		arg_347_1.duration_ = 4.4

		local var_347_0 = {
			zh = 4.4,
			ja = 2.633
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
				arg_347_0:Play426081082(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			local var_350_0 = 0
			local var_350_1 = 0.225

			if var_350_0 < arg_347_1.time_ and arg_347_1.time_ <= var_350_0 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, true)

				local var_350_2 = arg_347_1:FormatText(StoryNameCfg[1487].name)

				arg_347_1.leftNameTxt_.text = var_350_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_347_1.leftNameTxt_.transform)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1.leftNameTxt_.text)
				SetActive(arg_347_1.iconTrs_.gameObject, true)
				arg_347_1.iconController_:SetSelectedState("hero")

				arg_347_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1054")

				arg_347_1.callingController_:SetSelectedState("normal")

				arg_347_1.keyicon_.color = Color.New(1, 1, 1)
				arg_347_1.icon_.color = Color.New(1, 1, 1)

				local var_350_3 = arg_347_1:GetWordFromCfg(426081081)
				local var_350_4 = arg_347_1:FormatText(var_350_3.content)

				arg_347_1.text_.text = var_350_4

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_5 = 9
				local var_350_6 = utf8.len(var_350_4)
				local var_350_7 = var_350_5 <= 0 and var_350_1 or var_350_1 * (var_350_6 / var_350_5)

				if var_350_7 > 0 and var_350_1 < var_350_7 then
					arg_347_1.talkMaxDuration = var_350_7

					if var_350_7 + var_350_0 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_7 + var_350_0
					end
				end

				arg_347_1.text_.text = var_350_4
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426081", "426081081", "story_v_out_426081.awb") ~= 0 then
					local var_350_8 = manager.audio:GetVoiceLength("story_v_out_426081", "426081081", "story_v_out_426081.awb") / 1000

					if var_350_8 + var_350_0 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_8 + var_350_0
					end

					if var_350_3.prefab_name ~= "" and arg_347_1.actors_[var_350_3.prefab_name] ~= nil then
						local var_350_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_347_1.actors_[var_350_3.prefab_name].transform, "story_v_out_426081", "426081081", "story_v_out_426081.awb")

						arg_347_1:RecordAudio("426081081", var_350_9)
						arg_347_1:RecordAudio("426081081", var_350_9)
					else
						arg_347_1:AudioAction("play", "voice", "story_v_out_426081", "426081081", "story_v_out_426081.awb")
					end

					arg_347_1:RecordHistoryTalkVoice("story_v_out_426081", "426081081", "story_v_out_426081.awb")
				end

				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_10 = math.max(var_350_1, arg_347_1.talkMaxDuration)

			if var_350_0 <= arg_347_1.time_ and arg_347_1.time_ < var_350_0 + var_350_10 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - var_350_0) / var_350_10

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= var_350_0 + var_350_10 and arg_347_1.time_ < var_350_0 + var_350_10 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {}

		arg_347_1:InitPlayNodeList()
	end,
	Play426081082 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 426081082
		arg_351_1.duration_ = 5

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play426081083(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			local var_354_0 = 0
			local var_354_1 = 0.575

			if var_354_0 < arg_351_1.time_ and arg_351_1.time_ <= var_354_0 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, true)

				local var_354_2 = arg_351_1:FormatText(StoryNameCfg[7].name)

				arg_351_1.leftNameTxt_.text = var_354_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, true)
				arg_351_1.iconController_:SetSelectedState("hero")

				arg_351_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_351_1.callingController_:SetSelectedState("normal")

				arg_351_1.keyicon_.color = Color.New(1, 1, 1)
				arg_351_1.icon_.color = Color.New(1, 1, 1)

				local var_354_3 = arg_351_1:GetWordFromCfg(426081082)
				local var_354_4 = arg_351_1:FormatText(var_354_3.content)

				arg_351_1.text_.text = var_354_4

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_5 = 23
				local var_354_6 = utf8.len(var_354_4)
				local var_354_7 = var_354_5 <= 0 and var_354_1 or var_354_1 * (var_354_6 / var_354_5)

				if var_354_7 > 0 and var_354_1 < var_354_7 then
					arg_351_1.talkMaxDuration = var_354_7

					if var_354_7 + var_354_0 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_7 + var_354_0
					end
				end

				arg_351_1.text_.text = var_354_4
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)
				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_8 = math.max(var_354_1, arg_351_1.talkMaxDuration)

			if var_354_0 <= arg_351_1.time_ and arg_351_1.time_ < var_354_0 + var_354_8 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_0) / var_354_8

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_0 + var_354_8 and arg_351_1.time_ < var_354_0 + var_354_8 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {}

		arg_351_1:InitPlayNodeList()
	end,
	Play426081083 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 426081083
		arg_355_1.duration_ = 5

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play426081084(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			local var_358_0 = 0
			local var_358_1 = 1.275

			if var_358_0 < arg_355_1.time_ and arg_355_1.time_ <= var_358_0 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, false)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_355_1.iconTrs_.gameObject, false)
				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_2 = arg_355_1:GetWordFromCfg(426081083)
				local var_358_3 = arg_355_1:FormatText(var_358_2.content)

				arg_355_1.text_.text = var_358_3

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_4 = 51
				local var_358_5 = utf8.len(var_358_3)
				local var_358_6 = var_358_4 <= 0 and var_358_1 or var_358_1 * (var_358_5 / var_358_4)

				if var_358_6 > 0 and var_358_1 < var_358_6 then
					arg_355_1.talkMaxDuration = var_358_6

					if var_358_6 + var_358_0 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_6 + var_358_0
					end
				end

				arg_355_1.text_.text = var_358_3
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)
				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_7 = math.max(var_358_1, arg_355_1.talkMaxDuration)

			if var_358_0 <= arg_355_1.time_ and arg_355_1.time_ < var_358_0 + var_358_7 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_0) / var_358_7

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_0 + var_358_7 and arg_355_1.time_ < var_358_0 + var_358_7 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {}

		arg_355_1:InitPlayNodeList()
	end,
	Play426081084 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 426081084
		arg_359_1.duration_ = 5

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play426081085(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			local var_362_0 = 0
			local var_362_1 = 0.775

			if var_362_0 < arg_359_1.time_ and arg_359_1.time_ <= var_362_0 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, true)

				local var_362_2 = arg_359_1:FormatText(StoryNameCfg[7].name)

				arg_359_1.leftNameTxt_.text = var_362_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_359_1.leftNameTxt_.transform)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1.leftNameTxt_.text)
				SetActive(arg_359_1.iconTrs_.gameObject, true)
				arg_359_1.iconController_:SetSelectedState("hero")

				arg_359_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_359_1.callingController_:SetSelectedState("normal")

				arg_359_1.keyicon_.color = Color.New(1, 1, 1)
				arg_359_1.icon_.color = Color.New(1, 1, 1)

				local var_362_3 = arg_359_1:GetWordFromCfg(426081084)
				local var_362_4 = arg_359_1:FormatText(var_362_3.content)

				arg_359_1.text_.text = var_362_4

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_5 = 31
				local var_362_6 = utf8.len(var_362_4)
				local var_362_7 = var_362_5 <= 0 and var_362_1 or var_362_1 * (var_362_6 / var_362_5)

				if var_362_7 > 0 and var_362_1 < var_362_7 then
					arg_359_1.talkMaxDuration = var_362_7

					if var_362_7 + var_362_0 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_7 + var_362_0
					end
				end

				arg_359_1.text_.text = var_362_4
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)
				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_8 = math.max(var_362_1, arg_359_1.talkMaxDuration)

			if var_362_0 <= arg_359_1.time_ and arg_359_1.time_ < var_362_0 + var_362_8 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - var_362_0) / var_362_8

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= var_362_0 + var_362_8 and arg_359_1.time_ < var_362_0 + var_362_8 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {}

		arg_359_1:InitPlayNodeList()
	end,
	Play426081085 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 426081085
		arg_363_1.duration_ = 6.47

		local var_363_0 = {
			zh = 6.466,
			ja = 5.966
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
				arg_363_0:Play426081086(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			local var_366_0 = 0
			local var_366_1 = 0.3

			if var_366_0 < arg_363_1.time_ and arg_363_1.time_ <= var_366_0 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, true)

				local var_366_2 = arg_363_1:FormatText(StoryNameCfg[1487].name)

				arg_363_1.leftNameTxt_.text = var_366_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_363_1.leftNameTxt_.transform)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1.leftNameTxt_.text)
				SetActive(arg_363_1.iconTrs_.gameObject, true)
				arg_363_1.iconController_:SetSelectedState("hero")

				arg_363_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1054")

				arg_363_1.callingController_:SetSelectedState("normal")

				arg_363_1.keyicon_.color = Color.New(1, 1, 1)
				arg_363_1.icon_.color = Color.New(1, 1, 1)

				local var_366_3 = arg_363_1:GetWordFromCfg(426081085)
				local var_366_4 = arg_363_1:FormatText(var_366_3.content)

				arg_363_1.text_.text = var_366_4

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_5 = 12
				local var_366_6 = utf8.len(var_366_4)
				local var_366_7 = var_366_5 <= 0 and var_366_1 or var_366_1 * (var_366_6 / var_366_5)

				if var_366_7 > 0 and var_366_1 < var_366_7 then
					arg_363_1.talkMaxDuration = var_366_7

					if var_366_7 + var_366_0 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_7 + var_366_0
					end
				end

				arg_363_1.text_.text = var_366_4
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426081", "426081085", "story_v_out_426081.awb") ~= 0 then
					local var_366_8 = manager.audio:GetVoiceLength("story_v_out_426081", "426081085", "story_v_out_426081.awb") / 1000

					if var_366_8 + var_366_0 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_8 + var_366_0
					end

					if var_366_3.prefab_name ~= "" and arg_363_1.actors_[var_366_3.prefab_name] ~= nil then
						local var_366_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_363_1.actors_[var_366_3.prefab_name].transform, "story_v_out_426081", "426081085", "story_v_out_426081.awb")

						arg_363_1:RecordAudio("426081085", var_366_9)
						arg_363_1:RecordAudio("426081085", var_366_9)
					else
						arg_363_1:AudioAction("play", "voice", "story_v_out_426081", "426081085", "story_v_out_426081.awb")
					end

					arg_363_1:RecordHistoryTalkVoice("story_v_out_426081", "426081085", "story_v_out_426081.awb")
				end

				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_10 = math.max(var_366_1, arg_363_1.talkMaxDuration)

			if var_366_0 <= arg_363_1.time_ and arg_363_1.time_ < var_366_0 + var_366_10 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - var_366_0) / var_366_10

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= var_366_0 + var_366_10 and arg_363_1.time_ < var_366_0 + var_366_10 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {}

		arg_363_1:InitPlayNodeList()
	end,
	Play426081086 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 426081086
		arg_367_1.duration_ = 5

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play426081087(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			local var_370_0 = 0
			local var_370_1 = 0.45

			if var_370_0 < arg_367_1.time_ and arg_367_1.time_ <= var_370_0 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, true)

				local var_370_2 = arg_367_1:FormatText(StoryNameCfg[7].name)

				arg_367_1.leftNameTxt_.text = var_370_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_367_1.leftNameTxt_.transform)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1.leftNameTxt_.text)
				SetActive(arg_367_1.iconTrs_.gameObject, true)
				arg_367_1.iconController_:SetSelectedState("hero")

				arg_367_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_367_1.callingController_:SetSelectedState("normal")

				arg_367_1.keyicon_.color = Color.New(1, 1, 1)
				arg_367_1.icon_.color = Color.New(1, 1, 1)

				local var_370_3 = arg_367_1:GetWordFromCfg(426081086)
				local var_370_4 = arg_367_1:FormatText(var_370_3.content)

				arg_367_1.text_.text = var_370_4

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_5 = 18
				local var_370_6 = utf8.len(var_370_4)
				local var_370_7 = var_370_5 <= 0 and var_370_1 or var_370_1 * (var_370_6 / var_370_5)

				if var_370_7 > 0 and var_370_1 < var_370_7 then
					arg_367_1.talkMaxDuration = var_370_7

					if var_370_7 + var_370_0 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_7 + var_370_0
					end
				end

				arg_367_1.text_.text = var_370_4
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)
				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_8 = math.max(var_370_1, arg_367_1.talkMaxDuration)

			if var_370_0 <= arg_367_1.time_ and arg_367_1.time_ < var_370_0 + var_370_8 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - var_370_0) / var_370_8

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= var_370_0 + var_370_8 and arg_367_1.time_ < var_370_0 + var_370_8 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {}

		arg_367_1:InitPlayNodeList()
	end,
	Play426081087 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 426081087
		arg_371_1.duration_ = 5

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"
		end

		function arg_371_1.playNext_(arg_373_0)
			if arg_373_0 == 1 then
				arg_371_0:Play426081088(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			local var_374_0 = 0
			local var_374_1 = 1.05

			if var_374_0 < arg_371_1.time_ and arg_371_1.time_ <= var_374_0 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, false)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_371_1.iconTrs_.gameObject, false)
				arg_371_1.callingController_:SetSelectedState("normal")

				local var_374_2 = arg_371_1:GetWordFromCfg(426081087)
				local var_374_3 = arg_371_1:FormatText(var_374_2.content)

				arg_371_1.text_.text = var_374_3

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_4 = 42
				local var_374_5 = utf8.len(var_374_3)
				local var_374_6 = var_374_4 <= 0 and var_374_1 or var_374_1 * (var_374_5 / var_374_4)

				if var_374_6 > 0 and var_374_1 < var_374_6 then
					arg_371_1.talkMaxDuration = var_374_6

					if var_374_6 + var_374_0 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_6 + var_374_0
					end
				end

				arg_371_1.text_.text = var_374_3
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)
				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_7 = math.max(var_374_1, arg_371_1.talkMaxDuration)

			if var_374_0 <= arg_371_1.time_ and arg_371_1.time_ < var_374_0 + var_374_7 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - var_374_0) / var_374_7

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= var_374_0 + var_374_7 and arg_371_1.time_ < var_374_0 + var_374_7 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {}

		arg_371_1:InitPlayNodeList()
	end,
	Play426081088 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 426081088
		arg_375_1.duration_ = 4.5

		local var_375_0 = {
			zh = 4.5,
			ja = 1.5
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
				arg_375_0:Play426081089(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			local var_378_0 = 0
			local var_378_1 = 0.05

			if var_378_0 < arg_375_1.time_ and arg_375_1.time_ <= var_378_0 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, true)

				local var_378_2 = arg_375_1:FormatText(StoryNameCfg[1487].name)

				arg_375_1.leftNameTxt_.text = var_378_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_375_1.leftNameTxt_.transform)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1.leftNameTxt_.text)
				SetActive(arg_375_1.iconTrs_.gameObject, true)
				arg_375_1.iconController_:SetSelectedState("hero")

				arg_375_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1054")

				arg_375_1.callingController_:SetSelectedState("normal")

				arg_375_1.keyicon_.color = Color.New(1, 1, 1)
				arg_375_1.icon_.color = Color.New(1, 1, 1)

				local var_378_3 = arg_375_1:GetWordFromCfg(426081088)
				local var_378_4 = arg_375_1:FormatText(var_378_3.content)

				arg_375_1.text_.text = var_378_4

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_5 = 2
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

				if manager.audio:GetVoiceLength("story_v_out_426081", "426081088", "story_v_out_426081.awb") ~= 0 then
					local var_378_8 = manager.audio:GetVoiceLength("story_v_out_426081", "426081088", "story_v_out_426081.awb") / 1000

					if var_378_8 + var_378_0 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_8 + var_378_0
					end

					if var_378_3.prefab_name ~= "" and arg_375_1.actors_[var_378_3.prefab_name] ~= nil then
						local var_378_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_375_1.actors_[var_378_3.prefab_name].transform, "story_v_out_426081", "426081088", "story_v_out_426081.awb")

						arg_375_1:RecordAudio("426081088", var_378_9)
						arg_375_1:RecordAudio("426081088", var_378_9)
					else
						arg_375_1:AudioAction("play", "voice", "story_v_out_426081", "426081088", "story_v_out_426081.awb")
					end

					arg_375_1:RecordHistoryTalkVoice("story_v_out_426081", "426081088", "story_v_out_426081.awb")
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
	Play426081089 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 426081089
		arg_379_1.duration_ = 5

		SetActive(arg_379_1.tipsGo_, false)

		function arg_379_1.onSingleLineFinish_()
			arg_379_1.onSingleLineUpdate_ = nil
			arg_379_1.onSingleLineFinish_ = nil
			arg_379_1.state_ = "waiting"
		end

		function arg_379_1.playNext_(arg_381_0)
			if arg_381_0 == 1 then
				arg_379_0:Play426081090(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			local var_382_0 = 0
			local var_382_1 = 0.375

			if var_382_0 < arg_379_1.time_ and arg_379_1.time_ <= var_382_0 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, true)

				local var_382_2 = arg_379_1:FormatText(StoryNameCfg[7].name)

				arg_379_1.leftNameTxt_.text = var_382_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_379_1.leftNameTxt_.transform)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1.leftNameTxt_.text)
				SetActive(arg_379_1.iconTrs_.gameObject, true)
				arg_379_1.iconController_:SetSelectedState("hero")

				arg_379_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_379_1.callingController_:SetSelectedState("normal")

				arg_379_1.keyicon_.color = Color.New(1, 1, 1)
				arg_379_1.icon_.color = Color.New(1, 1, 1)

				local var_382_3 = arg_379_1:GetWordFromCfg(426081089)
				local var_382_4 = arg_379_1:FormatText(var_382_3.content)

				arg_379_1.text_.text = var_382_4

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_5 = 15
				local var_382_6 = utf8.len(var_382_4)
				local var_382_7 = var_382_5 <= 0 and var_382_1 or var_382_1 * (var_382_6 / var_382_5)

				if var_382_7 > 0 and var_382_1 < var_382_7 then
					arg_379_1.talkMaxDuration = var_382_7

					if var_382_7 + var_382_0 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_7 + var_382_0
					end
				end

				arg_379_1.text_.text = var_382_4
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)
				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_8 = math.max(var_382_1, arg_379_1.talkMaxDuration)

			if var_382_0 <= arg_379_1.time_ and arg_379_1.time_ < var_382_0 + var_382_8 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - var_382_0) / var_382_8

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= var_382_0 + var_382_8 and arg_379_1.time_ < var_382_0 + var_382_8 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {}

		arg_379_1:InitPlayNodeList()
	end,
	Play426081090 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 426081090
		arg_383_1.duration_ = 5

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"
		end

		function arg_383_1.playNext_(arg_385_0)
			if arg_385_0 == 1 then
				arg_383_0:Play426081091(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			local var_386_0 = 0
			local var_386_1 = 1.025

			if var_386_0 < arg_383_1.time_ and arg_383_1.time_ <= var_386_0 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, false)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_383_1.iconTrs_.gameObject, false)
				arg_383_1.callingController_:SetSelectedState("normal")

				local var_386_2 = arg_383_1:GetWordFromCfg(426081090)
				local var_386_3 = arg_383_1:FormatText(var_386_2.content)

				arg_383_1.text_.text = var_386_3

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_4 = 41
				local var_386_5 = utf8.len(var_386_3)
				local var_386_6 = var_386_4 <= 0 and var_386_1 or var_386_1 * (var_386_5 / var_386_4)

				if var_386_6 > 0 and var_386_1 < var_386_6 then
					arg_383_1.talkMaxDuration = var_386_6

					if var_386_6 + var_386_0 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_6 + var_386_0
					end
				end

				arg_383_1.text_.text = var_386_3
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)
				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_7 = math.max(var_386_1, arg_383_1.talkMaxDuration)

			if var_386_0 <= arg_383_1.time_ and arg_383_1.time_ < var_386_0 + var_386_7 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - var_386_0) / var_386_7

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= var_386_0 + var_386_7 and arg_383_1.time_ < var_386_0 + var_386_7 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {}

		arg_383_1:InitPlayNodeList()
	end,
	Play426081091 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 426081091
		arg_387_1.duration_ = 5

		SetActive(arg_387_1.tipsGo_, false)

		function arg_387_1.onSingleLineFinish_()
			arg_387_1.onSingleLineUpdate_ = nil
			arg_387_1.onSingleLineFinish_ = nil
			arg_387_1.state_ = "waiting"
		end

		function arg_387_1.playNext_(arg_389_0)
			if arg_389_0 == 1 then
				arg_387_0:Play426081092(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			local var_390_0 = 0
			local var_390_1 = 0.6

			if var_390_0 < arg_387_1.time_ and arg_387_1.time_ <= var_390_0 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0
				arg_387_1.dialogCg_.alpha = 1

				arg_387_1.dialog_:SetActive(true)
				SetActive(arg_387_1.leftNameGo_, true)

				local var_390_2 = arg_387_1:FormatText(StoryNameCfg[7].name)

				arg_387_1.leftNameTxt_.text = var_390_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_387_1.leftNameTxt_.transform)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1.leftNameTxt_.text)
				SetActive(arg_387_1.iconTrs_.gameObject, true)
				arg_387_1.iconController_:SetSelectedState("hero")

				arg_387_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_387_1.callingController_:SetSelectedState("normal")

				arg_387_1.keyicon_.color = Color.New(1, 1, 1)
				arg_387_1.icon_.color = Color.New(1, 1, 1)

				local var_390_3 = arg_387_1:GetWordFromCfg(426081091)
				local var_390_4 = arg_387_1:FormatText(var_390_3.content)

				arg_387_1.text_.text = var_390_4

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_5 = 24
				local var_390_6 = utf8.len(var_390_4)
				local var_390_7 = var_390_5 <= 0 and var_390_1 or var_390_1 * (var_390_6 / var_390_5)

				if var_390_7 > 0 and var_390_1 < var_390_7 then
					arg_387_1.talkMaxDuration = var_390_7

					if var_390_7 + var_390_0 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_7 + var_390_0
					end
				end

				arg_387_1.text_.text = var_390_4
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)
				arg_387_1:RecordContent(arg_387_1.text_.text)
			end

			local var_390_8 = math.max(var_390_1, arg_387_1.talkMaxDuration)

			if var_390_0 <= arg_387_1.time_ and arg_387_1.time_ < var_390_0 + var_390_8 then
				arg_387_1.typewritter.percent = (arg_387_1.time_ - var_390_0) / var_390_8

				arg_387_1.typewritter:SetDirty()
			end

			if arg_387_1.time_ >= var_390_0 + var_390_8 and arg_387_1.time_ < var_390_0 + var_390_8 + arg_390_0 then
				arg_387_1.typewritter.percent = 1

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(true)
			end
		end

		arg_387_1.nodeConfigList_ = {}

		arg_387_1:InitPlayNodeList()
	end,
	Play426081092 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 426081092
		arg_391_1.duration_ = 8.27

		local var_391_0 = {
			zh = 7.7,
			ja = 8.266
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
				arg_391_0:Play426081093(arg_391_1)
			end
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			local var_394_0 = 0
			local var_394_1 = 0.325

			if var_394_0 < arg_391_1.time_ and arg_391_1.time_ <= var_394_0 + arg_394_0 then
				arg_391_1.talkMaxDuration = 0
				arg_391_1.dialogCg_.alpha = 1

				arg_391_1.dialog_:SetActive(true)
				SetActive(arg_391_1.leftNameGo_, true)

				local var_394_2 = arg_391_1:FormatText(StoryNameCfg[1487].name)

				arg_391_1.leftNameTxt_.text = var_394_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_391_1.leftNameTxt_.transform)

				arg_391_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_391_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_391_1:RecordName(arg_391_1.leftNameTxt_.text)
				SetActive(arg_391_1.iconTrs_.gameObject, true)
				arg_391_1.iconController_:SetSelectedState("hero")

				arg_391_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1054")

				arg_391_1.callingController_:SetSelectedState("normal")

				arg_391_1.keyicon_.color = Color.New(1, 1, 1)
				arg_391_1.icon_.color = Color.New(1, 1, 1)

				local var_394_3 = arg_391_1:GetWordFromCfg(426081092)
				local var_394_4 = arg_391_1:FormatText(var_394_3.content)

				arg_391_1.text_.text = var_394_4

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_5 = 13
				local var_394_6 = utf8.len(var_394_4)
				local var_394_7 = var_394_5 <= 0 and var_394_1 or var_394_1 * (var_394_6 / var_394_5)

				if var_394_7 > 0 and var_394_1 < var_394_7 then
					arg_391_1.talkMaxDuration = var_394_7

					if var_394_7 + var_394_0 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_7 + var_394_0
					end
				end

				arg_391_1.text_.text = var_394_4
				arg_391_1.typewritter.percent = 0

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426081", "426081092", "story_v_out_426081.awb") ~= 0 then
					local var_394_8 = manager.audio:GetVoiceLength("story_v_out_426081", "426081092", "story_v_out_426081.awb") / 1000

					if var_394_8 + var_394_0 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_8 + var_394_0
					end

					if var_394_3.prefab_name ~= "" and arg_391_1.actors_[var_394_3.prefab_name] ~= nil then
						local var_394_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_391_1.actors_[var_394_3.prefab_name].transform, "story_v_out_426081", "426081092", "story_v_out_426081.awb")

						arg_391_1:RecordAudio("426081092", var_394_9)
						arg_391_1:RecordAudio("426081092", var_394_9)
					else
						arg_391_1:AudioAction("play", "voice", "story_v_out_426081", "426081092", "story_v_out_426081.awb")
					end

					arg_391_1:RecordHistoryTalkVoice("story_v_out_426081", "426081092", "story_v_out_426081.awb")
				end

				arg_391_1:RecordContent(arg_391_1.text_.text)
			end

			local var_394_10 = math.max(var_394_1, arg_391_1.talkMaxDuration)

			if var_394_0 <= arg_391_1.time_ and arg_391_1.time_ < var_394_0 + var_394_10 then
				arg_391_1.typewritter.percent = (arg_391_1.time_ - var_394_0) / var_394_10

				arg_391_1.typewritter:SetDirty()
			end

			if arg_391_1.time_ >= var_394_0 + var_394_10 and arg_391_1.time_ < var_394_0 + var_394_10 + arg_394_0 then
				arg_391_1.typewritter.percent = 1

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(true)
			end
		end

		arg_391_1.nodeConfigList_ = {}

		arg_391_1:InitPlayNodeList()
	end,
	Play426081093 = function(arg_395_0, arg_395_1)
		arg_395_1.time_ = 0
		arg_395_1.frameCnt_ = 0
		arg_395_1.state_ = "playing"
		arg_395_1.curTalkId_ = 426081093
		arg_395_1.duration_ = 1

		SetActive(arg_395_1.tipsGo_, false)

		function arg_395_1.onSingleLineFinish_()
			arg_395_1.onSingleLineUpdate_ = nil
			arg_395_1.onSingleLineFinish_ = nil
			arg_395_1.state_ = "waiting"

			SetActive(arg_395_1.choicesGo_, true)

			for iter_396_0, iter_396_1 in ipairs(arg_395_1.choices_) do
				local var_396_0 = iter_396_0 <= 1

				SetActive(iter_396_1.go, var_396_0)
			end

			arg_395_1.choices_[1].txt.text = arg_395_1:FormatText(StoryChoiceCfg[1608].name)
		end

		function arg_395_1.playNext_(arg_397_0)
			if arg_397_0 == 1 then
				arg_395_0:Play426081094(arg_395_1)
			end

			arg_395_1:RecordChoiceLog(426081093, 1608)
		end

		function arg_395_1.onSingleLineUpdate_(arg_398_0)
			local var_398_0 = 0

			if var_398_0 < arg_395_1.time_ and arg_395_1.time_ <= var_398_0 + arg_398_0 then
				arg_395_1.allBtn_.enabled = false
			end

			local var_398_1 = 0.666666666666667

			if arg_395_1.time_ >= var_398_0 + var_398_1 and arg_395_1.time_ < var_398_0 + var_398_1 + arg_398_0 then
				arg_395_1.allBtn_.enabled = true
			end
		end

		arg_395_1.nodeConfigList_ = {}

		arg_395_1:InitPlayNodeList()
	end,
	Play426081094 = function(arg_399_0, arg_399_1)
		arg_399_1.time_ = 0
		arg_399_1.frameCnt_ = 0
		arg_399_1.state_ = "playing"
		arg_399_1.curTalkId_ = 426081094
		arg_399_1.duration_ = 5

		SetActive(arg_399_1.tipsGo_, false)

		function arg_399_1.onSingleLineFinish_()
			arg_399_1.onSingleLineUpdate_ = nil
			arg_399_1.onSingleLineFinish_ = nil
			arg_399_1.state_ = "waiting"
		end

		function arg_399_1.playNext_(arg_401_0)
			if arg_401_0 == 1 then
				arg_399_0:Play426081095(arg_399_1)
			end
		end

		function arg_399_1.onSingleLineUpdate_(arg_402_0)
			local var_402_0 = 0
			local var_402_1 = 0.15

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

				arg_399_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_399_1.callingController_:SetSelectedState("normal")

				arg_399_1.keyicon_.color = Color.New(1, 1, 1)
				arg_399_1.icon_.color = Color.New(1, 1, 1)

				local var_402_3 = arg_399_1:GetWordFromCfg(426081094)
				local var_402_4 = arg_399_1:FormatText(var_402_3.content)

				arg_399_1.text_.text = var_402_4

				LuaForUtil.ClearLinePrefixSymbol(arg_399_1.text_)

				local var_402_5 = 6
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
	Play426081095 = function(arg_403_0, arg_403_1)
		arg_403_1.time_ = 0
		arg_403_1.frameCnt_ = 0
		arg_403_1.state_ = "playing"
		arg_403_1.curTalkId_ = 426081095
		arg_403_1.duration_ = 5

		SetActive(arg_403_1.tipsGo_, false)

		function arg_403_1.onSingleLineFinish_()
			arg_403_1.onSingleLineUpdate_ = nil
			arg_403_1.onSingleLineFinish_ = nil
			arg_403_1.state_ = "waiting"
		end

		function arg_403_1.playNext_(arg_405_0)
			if arg_405_0 == 1 then
				arg_403_0:Play426081096(arg_403_1)
			end
		end

		function arg_403_1.onSingleLineUpdate_(arg_406_0)
			local var_406_0 = 0
			local var_406_1 = 0.225

			if var_406_0 < arg_403_1.time_ and arg_403_1.time_ <= var_406_0 + arg_406_0 then
				arg_403_1.talkMaxDuration = 0
				arg_403_1.dialogCg_.alpha = 1

				arg_403_1.dialog_:SetActive(true)
				SetActive(arg_403_1.leftNameGo_, true)

				local var_406_2 = arg_403_1:FormatText(StoryNameCfg[7].name)

				arg_403_1.leftNameTxt_.text = var_406_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_403_1.leftNameTxt_.transform)

				arg_403_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_403_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_403_1:RecordName(arg_403_1.leftNameTxt_.text)
				SetActive(arg_403_1.iconTrs_.gameObject, true)
				arg_403_1.iconController_:SetSelectedState("hero")

				arg_403_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_403_1.callingController_:SetSelectedState("normal")

				arg_403_1.keyicon_.color = Color.New(1, 1, 1)
				arg_403_1.icon_.color = Color.New(1, 1, 1)

				local var_406_3 = arg_403_1:GetWordFromCfg(426081095)
				local var_406_4 = arg_403_1:FormatText(var_406_3.content)

				arg_403_1.text_.text = var_406_4

				LuaForUtil.ClearLinePrefixSymbol(arg_403_1.text_)

				local var_406_5 = 9
				local var_406_6 = utf8.len(var_406_4)
				local var_406_7 = var_406_5 <= 0 and var_406_1 or var_406_1 * (var_406_6 / var_406_5)

				if var_406_7 > 0 and var_406_1 < var_406_7 then
					arg_403_1.talkMaxDuration = var_406_7

					if var_406_7 + var_406_0 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_7 + var_406_0
					end
				end

				arg_403_1.text_.text = var_406_4
				arg_403_1.typewritter.percent = 0

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(false)
				arg_403_1:RecordContent(arg_403_1.text_.text)
			end

			local var_406_8 = math.max(var_406_1, arg_403_1.talkMaxDuration)

			if var_406_0 <= arg_403_1.time_ and arg_403_1.time_ < var_406_0 + var_406_8 then
				arg_403_1.typewritter.percent = (arg_403_1.time_ - var_406_0) / var_406_8

				arg_403_1.typewritter:SetDirty()
			end

			if arg_403_1.time_ >= var_406_0 + var_406_8 and arg_403_1.time_ < var_406_0 + var_406_8 + arg_406_0 then
				arg_403_1.typewritter.percent = 1

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(true)
			end
		end

		arg_403_1.nodeConfigList_ = {}

		arg_403_1:InitPlayNodeList()
	end,
	Play426081096 = function(arg_407_0, arg_407_1)
		arg_407_1.time_ = 0
		arg_407_1.frameCnt_ = 0
		arg_407_1.state_ = "playing"
		arg_407_1.curTalkId_ = 426081096
		arg_407_1.duration_ = 5

		SetActive(arg_407_1.tipsGo_, false)

		function arg_407_1.onSingleLineFinish_()
			arg_407_1.onSingleLineUpdate_ = nil
			arg_407_1.onSingleLineFinish_ = nil
			arg_407_1.state_ = "waiting"
		end

		function arg_407_1.playNext_(arg_409_0)
			if arg_409_0 == 1 then
				arg_407_0:Play426081097(arg_407_1)
			end
		end

		function arg_407_1.onSingleLineUpdate_(arg_410_0)
			local var_410_0 = 0
			local var_410_1 = 0.7

			if var_410_0 < arg_407_1.time_ and arg_407_1.time_ <= var_410_0 + arg_410_0 then
				arg_407_1.talkMaxDuration = 0
				arg_407_1.dialogCg_.alpha = 1

				arg_407_1.dialog_:SetActive(true)
				SetActive(arg_407_1.leftNameGo_, true)

				local var_410_2 = arg_407_1:FormatText(StoryNameCfg[7].name)

				arg_407_1.leftNameTxt_.text = var_410_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_407_1.leftNameTxt_.transform)

				arg_407_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_407_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_407_1:RecordName(arg_407_1.leftNameTxt_.text)
				SetActive(arg_407_1.iconTrs_.gameObject, true)
				arg_407_1.iconController_:SetSelectedState("hero")

				arg_407_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_407_1.callingController_:SetSelectedState("normal")

				arg_407_1.keyicon_.color = Color.New(1, 1, 1)
				arg_407_1.icon_.color = Color.New(1, 1, 1)

				local var_410_3 = arg_407_1:GetWordFromCfg(426081096)
				local var_410_4 = arg_407_1:FormatText(var_410_3.content)

				arg_407_1.text_.text = var_410_4

				LuaForUtil.ClearLinePrefixSymbol(arg_407_1.text_)

				local var_410_5 = 28
				local var_410_6 = utf8.len(var_410_4)
				local var_410_7 = var_410_5 <= 0 and var_410_1 or var_410_1 * (var_410_6 / var_410_5)

				if var_410_7 > 0 and var_410_1 < var_410_7 then
					arg_407_1.talkMaxDuration = var_410_7

					if var_410_7 + var_410_0 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_7 + var_410_0
					end
				end

				arg_407_1.text_.text = var_410_4
				arg_407_1.typewritter.percent = 0

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(false)
				arg_407_1:RecordContent(arg_407_1.text_.text)
			end

			local var_410_8 = math.max(var_410_1, arg_407_1.talkMaxDuration)

			if var_410_0 <= arg_407_1.time_ and arg_407_1.time_ < var_410_0 + var_410_8 then
				arg_407_1.typewritter.percent = (arg_407_1.time_ - var_410_0) / var_410_8

				arg_407_1.typewritter:SetDirty()
			end

			if arg_407_1.time_ >= var_410_0 + var_410_8 and arg_407_1.time_ < var_410_0 + var_410_8 + arg_410_0 then
				arg_407_1.typewritter.percent = 1

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(true)
			end
		end

		arg_407_1.nodeConfigList_ = {}

		arg_407_1:InitPlayNodeList()
	end,
	Play426081097 = function(arg_411_0, arg_411_1)
		arg_411_1.time_ = 0
		arg_411_1.frameCnt_ = 0
		arg_411_1.state_ = "playing"
		arg_411_1.curTalkId_ = 426081097
		arg_411_1.duration_ = 4.1

		local var_411_0 = {
			zh = 4.1,
			ja = 1.4
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
				arg_411_0:Play426081098(arg_411_1)
			end
		end

		function arg_411_1.onSingleLineUpdate_(arg_414_0)
			local var_414_0 = 0
			local var_414_1 = 0.15

			if var_414_0 < arg_411_1.time_ and arg_411_1.time_ <= var_414_0 + arg_414_0 then
				arg_411_1.talkMaxDuration = 0
				arg_411_1.dialogCg_.alpha = 1

				arg_411_1.dialog_:SetActive(true)
				SetActive(arg_411_1.leftNameGo_, true)

				local var_414_2 = arg_411_1:FormatText(StoryNameCfg[1487].name)

				arg_411_1.leftNameTxt_.text = var_414_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_411_1.leftNameTxt_.transform)

				arg_411_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_411_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_411_1:RecordName(arg_411_1.leftNameTxt_.text)
				SetActive(arg_411_1.iconTrs_.gameObject, true)
				arg_411_1.iconController_:SetSelectedState("hero")

				arg_411_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1054")

				arg_411_1.callingController_:SetSelectedState("normal")

				arg_411_1.keyicon_.color = Color.New(1, 1, 1)
				arg_411_1.icon_.color = Color.New(1, 1, 1)

				local var_414_3 = arg_411_1:GetWordFromCfg(426081097)
				local var_414_4 = arg_411_1:FormatText(var_414_3.content)

				arg_411_1.text_.text = var_414_4

				LuaForUtil.ClearLinePrefixSymbol(arg_411_1.text_)

				local var_414_5 = 6
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

				if manager.audio:GetVoiceLength("story_v_out_426081", "426081097", "story_v_out_426081.awb") ~= 0 then
					local var_414_8 = manager.audio:GetVoiceLength("story_v_out_426081", "426081097", "story_v_out_426081.awb") / 1000

					if var_414_8 + var_414_0 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_8 + var_414_0
					end

					if var_414_3.prefab_name ~= "" and arg_411_1.actors_[var_414_3.prefab_name] ~= nil then
						local var_414_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_411_1.actors_[var_414_3.prefab_name].transform, "story_v_out_426081", "426081097", "story_v_out_426081.awb")

						arg_411_1:RecordAudio("426081097", var_414_9)
						arg_411_1:RecordAudio("426081097", var_414_9)
					else
						arg_411_1:AudioAction("play", "voice", "story_v_out_426081", "426081097", "story_v_out_426081.awb")
					end

					arg_411_1:RecordHistoryTalkVoice("story_v_out_426081", "426081097", "story_v_out_426081.awb")
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
	Play426081098 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 426081098
		arg_415_1.duration_ = 5

		SetActive(arg_415_1.tipsGo_, false)

		function arg_415_1.onSingleLineFinish_()
			arg_415_1.onSingleLineUpdate_ = nil
			arg_415_1.onSingleLineFinish_ = nil
			arg_415_1.state_ = "waiting"
		end

		function arg_415_1.playNext_(arg_417_0)
			if arg_417_0 == 1 then
				arg_415_0:Play426081099(arg_415_1)
			end
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			local var_418_0 = 0
			local var_418_1 = 1.05

			if var_418_0 < arg_415_1.time_ and arg_415_1.time_ <= var_418_0 + arg_418_0 then
				arg_415_1.talkMaxDuration = 0
				arg_415_1.dialogCg_.alpha = 1

				arg_415_1.dialog_:SetActive(true)
				SetActive(arg_415_1.leftNameGo_, false)

				arg_415_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_415_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_415_1:RecordName(arg_415_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_415_1.iconTrs_.gameObject, false)
				arg_415_1.callingController_:SetSelectedState("normal")

				local var_418_2 = arg_415_1:GetWordFromCfg(426081098)
				local var_418_3 = arg_415_1:FormatText(var_418_2.content)

				arg_415_1.text_.text = var_418_3

				LuaForUtil.ClearLinePrefixSymbol(arg_415_1.text_)

				local var_418_4 = 42
				local var_418_5 = utf8.len(var_418_3)
				local var_418_6 = var_418_4 <= 0 and var_418_1 or var_418_1 * (var_418_5 / var_418_4)

				if var_418_6 > 0 and var_418_1 < var_418_6 then
					arg_415_1.talkMaxDuration = var_418_6

					if var_418_6 + var_418_0 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_6 + var_418_0
					end
				end

				arg_415_1.text_.text = var_418_3
				arg_415_1.typewritter.percent = 0

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(false)
				arg_415_1:RecordContent(arg_415_1.text_.text)
			end

			local var_418_7 = math.max(var_418_1, arg_415_1.talkMaxDuration)

			if var_418_0 <= arg_415_1.time_ and arg_415_1.time_ < var_418_0 + var_418_7 then
				arg_415_1.typewritter.percent = (arg_415_1.time_ - var_418_0) / var_418_7

				arg_415_1.typewritter:SetDirty()
			end

			if arg_415_1.time_ >= var_418_0 + var_418_7 and arg_415_1.time_ < var_418_0 + var_418_7 + arg_418_0 then
				arg_415_1.typewritter.percent = 1

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(true)
			end
		end

		arg_415_1.nodeConfigList_ = {}

		arg_415_1:InitPlayNodeList()
	end,
	Play426081099 = function(arg_419_0, arg_419_1)
		arg_419_1.time_ = 0
		arg_419_1.frameCnt_ = 0
		arg_419_1.state_ = "playing"
		arg_419_1.curTalkId_ = 426081099
		arg_419_1.duration_ = 2.5

		local var_419_0 = {
			zh = 2.5,
			ja = 1.4
		}
		local var_419_1 = manager.audio:GetLocalizationFlag()

		if var_419_0[var_419_1] ~= nil then
			arg_419_1.duration_ = var_419_0[var_419_1]
		end

		SetActive(arg_419_1.tipsGo_, false)

		function arg_419_1.onSingleLineFinish_()
			arg_419_1.onSingleLineUpdate_ = nil
			arg_419_1.onSingleLineFinish_ = nil
			arg_419_1.state_ = "waiting"
		end

		function arg_419_1.playNext_(arg_421_0)
			if arg_421_0 == 1 then
				arg_419_0:Play426081100(arg_419_1)
			end
		end

		function arg_419_1.onSingleLineUpdate_(arg_422_0)
			local var_422_0 = 0
			local var_422_1 = 0.1

			if var_422_0 < arg_419_1.time_ and arg_419_1.time_ <= var_422_0 + arg_422_0 then
				arg_419_1.talkMaxDuration = 0
				arg_419_1.dialogCg_.alpha = 1

				arg_419_1.dialog_:SetActive(true)
				SetActive(arg_419_1.leftNameGo_, true)

				local var_422_2 = arg_419_1:FormatText(StoryNameCfg[1487].name)

				arg_419_1.leftNameTxt_.text = var_422_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_419_1.leftNameTxt_.transform)

				arg_419_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_419_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_419_1:RecordName(arg_419_1.leftNameTxt_.text)
				SetActive(arg_419_1.iconTrs_.gameObject, true)
				arg_419_1.iconController_:SetSelectedState("hero")

				arg_419_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1054")

				arg_419_1.callingController_:SetSelectedState("normal")

				arg_419_1.keyicon_.color = Color.New(1, 1, 1)
				arg_419_1.icon_.color = Color.New(1, 1, 1)

				local var_422_3 = arg_419_1:GetWordFromCfg(426081099)
				local var_422_4 = arg_419_1:FormatText(var_422_3.content)

				arg_419_1.text_.text = var_422_4

				LuaForUtil.ClearLinePrefixSymbol(arg_419_1.text_)

				local var_422_5 = 4
				local var_422_6 = utf8.len(var_422_4)
				local var_422_7 = var_422_5 <= 0 and var_422_1 or var_422_1 * (var_422_6 / var_422_5)

				if var_422_7 > 0 and var_422_1 < var_422_7 then
					arg_419_1.talkMaxDuration = var_422_7

					if var_422_7 + var_422_0 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_7 + var_422_0
					end
				end

				arg_419_1.text_.text = var_422_4
				arg_419_1.typewritter.percent = 0

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426081", "426081099", "story_v_out_426081.awb") ~= 0 then
					local var_422_8 = manager.audio:GetVoiceLength("story_v_out_426081", "426081099", "story_v_out_426081.awb") / 1000

					if var_422_8 + var_422_0 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_8 + var_422_0
					end

					if var_422_3.prefab_name ~= "" and arg_419_1.actors_[var_422_3.prefab_name] ~= nil then
						local var_422_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_419_1.actors_[var_422_3.prefab_name].transform, "story_v_out_426081", "426081099", "story_v_out_426081.awb")

						arg_419_1:RecordAudio("426081099", var_422_9)
						arg_419_1:RecordAudio("426081099", var_422_9)
					else
						arg_419_1:AudioAction("play", "voice", "story_v_out_426081", "426081099", "story_v_out_426081.awb")
					end

					arg_419_1:RecordHistoryTalkVoice("story_v_out_426081", "426081099", "story_v_out_426081.awb")
				end

				arg_419_1:RecordContent(arg_419_1.text_.text)
			end

			local var_422_10 = math.max(var_422_1, arg_419_1.talkMaxDuration)

			if var_422_0 <= arg_419_1.time_ and arg_419_1.time_ < var_422_0 + var_422_10 then
				arg_419_1.typewritter.percent = (arg_419_1.time_ - var_422_0) / var_422_10

				arg_419_1.typewritter:SetDirty()
			end

			if arg_419_1.time_ >= var_422_0 + var_422_10 and arg_419_1.time_ < var_422_0 + var_422_10 + arg_422_0 then
				arg_419_1.typewritter.percent = 1

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(true)
			end
		end

		arg_419_1.nodeConfigList_ = {}

		arg_419_1:InitPlayNodeList()
	end,
	Play426081100 = function(arg_423_0, arg_423_1)
		arg_423_1.time_ = 0
		arg_423_1.frameCnt_ = 0
		arg_423_1.state_ = "playing"
		arg_423_1.curTalkId_ = 426081100
		arg_423_1.duration_ = 5

		SetActive(arg_423_1.tipsGo_, false)

		function arg_423_1.onSingleLineFinish_()
			arg_423_1.onSingleLineUpdate_ = nil
			arg_423_1.onSingleLineFinish_ = nil
			arg_423_1.state_ = "waiting"
		end

		function arg_423_1.playNext_(arg_425_0)
			if arg_425_0 == 1 then
				arg_423_0:Play426081101(arg_423_1)
			end
		end

		function arg_423_1.onSingleLineUpdate_(arg_426_0)
			local var_426_0 = 0
			local var_426_1 = 0.15

			if var_426_0 < arg_423_1.time_ and arg_423_1.time_ <= var_426_0 + arg_426_0 then
				arg_423_1.talkMaxDuration = 0
				arg_423_1.dialogCg_.alpha = 1

				arg_423_1.dialog_:SetActive(true)
				SetActive(arg_423_1.leftNameGo_, true)

				local var_426_2 = arg_423_1:FormatText(StoryNameCfg[7].name)

				arg_423_1.leftNameTxt_.text = var_426_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_423_1.leftNameTxt_.transform)

				arg_423_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_423_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_423_1:RecordName(arg_423_1.leftNameTxt_.text)
				SetActive(arg_423_1.iconTrs_.gameObject, true)
				arg_423_1.iconController_:SetSelectedState("hero")

				arg_423_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_423_1.callingController_:SetSelectedState("normal")

				arg_423_1.keyicon_.color = Color.New(1, 1, 1)
				arg_423_1.icon_.color = Color.New(1, 1, 1)

				local var_426_3 = arg_423_1:GetWordFromCfg(426081100)
				local var_426_4 = arg_423_1:FormatText(var_426_3.content)

				arg_423_1.text_.text = var_426_4

				LuaForUtil.ClearLinePrefixSymbol(arg_423_1.text_)

				local var_426_5 = 6
				local var_426_6 = utf8.len(var_426_4)
				local var_426_7 = var_426_5 <= 0 and var_426_1 or var_426_1 * (var_426_6 / var_426_5)

				if var_426_7 > 0 and var_426_1 < var_426_7 then
					arg_423_1.talkMaxDuration = var_426_7

					if var_426_7 + var_426_0 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_7 + var_426_0
					end
				end

				arg_423_1.text_.text = var_426_4
				arg_423_1.typewritter.percent = 0

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(false)
				arg_423_1:RecordContent(arg_423_1.text_.text)
			end

			local var_426_8 = math.max(var_426_1, arg_423_1.talkMaxDuration)

			if var_426_0 <= arg_423_1.time_ and arg_423_1.time_ < var_426_0 + var_426_8 then
				arg_423_1.typewritter.percent = (arg_423_1.time_ - var_426_0) / var_426_8

				arg_423_1.typewritter:SetDirty()
			end

			if arg_423_1.time_ >= var_426_0 + var_426_8 and arg_423_1.time_ < var_426_0 + var_426_8 + arg_426_0 then
				arg_423_1.typewritter.percent = 1

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(true)
			end
		end

		arg_423_1.nodeConfigList_ = {}

		arg_423_1:InitPlayNodeList()
	end,
	Play426081101 = function(arg_427_0, arg_427_1)
		arg_427_1.time_ = 0
		arg_427_1.frameCnt_ = 0
		arg_427_1.state_ = "playing"
		arg_427_1.curTalkId_ = 426081101
		arg_427_1.duration_ = 2.33

		local var_427_0 = {
			zh = 2.333,
			ja = 2.3
		}
		local var_427_1 = manager.audio:GetLocalizationFlag()

		if var_427_0[var_427_1] ~= nil then
			arg_427_1.duration_ = var_427_0[var_427_1]
		end

		SetActive(arg_427_1.tipsGo_, false)

		function arg_427_1.onSingleLineFinish_()
			arg_427_1.onSingleLineUpdate_ = nil
			arg_427_1.onSingleLineFinish_ = nil
			arg_427_1.state_ = "waiting"
		end

		function arg_427_1.playNext_(arg_429_0)
			if arg_429_0 == 1 then
				arg_427_0:Play426081102(arg_427_1)
			end
		end

		function arg_427_1.onSingleLineUpdate_(arg_430_0)
			local var_430_0 = 0
			local var_430_1 = 0.1

			if var_430_0 < arg_427_1.time_ and arg_427_1.time_ <= var_430_0 + arg_430_0 then
				arg_427_1.talkMaxDuration = 0
				arg_427_1.dialogCg_.alpha = 1

				arg_427_1.dialog_:SetActive(true)
				SetActive(arg_427_1.leftNameGo_, true)

				local var_430_2 = arg_427_1:FormatText(StoryNameCfg[1487].name)

				arg_427_1.leftNameTxt_.text = var_430_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_427_1.leftNameTxt_.transform)

				arg_427_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_427_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_427_1:RecordName(arg_427_1.leftNameTxt_.text)
				SetActive(arg_427_1.iconTrs_.gameObject, true)
				arg_427_1.iconController_:SetSelectedState("hero")

				arg_427_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1054")

				arg_427_1.callingController_:SetSelectedState("normal")

				arg_427_1.keyicon_.color = Color.New(1, 1, 1)
				arg_427_1.icon_.color = Color.New(1, 1, 1)

				local var_430_3 = arg_427_1:GetWordFromCfg(426081101)
				local var_430_4 = arg_427_1:FormatText(var_430_3.content)

				arg_427_1.text_.text = var_430_4

				LuaForUtil.ClearLinePrefixSymbol(arg_427_1.text_)

				local var_430_5 = 4
				local var_430_6 = utf8.len(var_430_4)
				local var_430_7 = var_430_5 <= 0 and var_430_1 or var_430_1 * (var_430_6 / var_430_5)

				if var_430_7 > 0 and var_430_1 < var_430_7 then
					arg_427_1.talkMaxDuration = var_430_7

					if var_430_7 + var_430_0 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_7 + var_430_0
					end
				end

				arg_427_1.text_.text = var_430_4
				arg_427_1.typewritter.percent = 0

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426081", "426081101", "story_v_out_426081.awb") ~= 0 then
					local var_430_8 = manager.audio:GetVoiceLength("story_v_out_426081", "426081101", "story_v_out_426081.awb") / 1000

					if var_430_8 + var_430_0 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_8 + var_430_0
					end

					if var_430_3.prefab_name ~= "" and arg_427_1.actors_[var_430_3.prefab_name] ~= nil then
						local var_430_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_427_1.actors_[var_430_3.prefab_name].transform, "story_v_out_426081", "426081101", "story_v_out_426081.awb")

						arg_427_1:RecordAudio("426081101", var_430_9)
						arg_427_1:RecordAudio("426081101", var_430_9)
					else
						arg_427_1:AudioAction("play", "voice", "story_v_out_426081", "426081101", "story_v_out_426081.awb")
					end

					arg_427_1:RecordHistoryTalkVoice("story_v_out_426081", "426081101", "story_v_out_426081.awb")
				end

				arg_427_1:RecordContent(arg_427_1.text_.text)
			end

			local var_430_10 = math.max(var_430_1, arg_427_1.talkMaxDuration)

			if var_430_0 <= arg_427_1.time_ and arg_427_1.time_ < var_430_0 + var_430_10 then
				arg_427_1.typewritter.percent = (arg_427_1.time_ - var_430_0) / var_430_10

				arg_427_1.typewritter:SetDirty()
			end

			if arg_427_1.time_ >= var_430_0 + var_430_10 and arg_427_1.time_ < var_430_0 + var_430_10 + arg_430_0 then
				arg_427_1.typewritter.percent = 1

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(true)
			end
		end

		arg_427_1.nodeConfigList_ = {}

		arg_427_1:InitPlayNodeList()
	end,
	Play426081102 = function(arg_431_0, arg_431_1)
		arg_431_1.time_ = 0
		arg_431_1.frameCnt_ = 0
		arg_431_1.state_ = "playing"
		arg_431_1.curTalkId_ = 426081102
		arg_431_1.duration_ = 5

		SetActive(arg_431_1.tipsGo_, false)

		function arg_431_1.onSingleLineFinish_()
			arg_431_1.onSingleLineUpdate_ = nil
			arg_431_1.onSingleLineFinish_ = nil
			arg_431_1.state_ = "waiting"
		end

		function arg_431_1.playNext_(arg_433_0)
			if arg_433_0 == 1 then
				arg_431_0:Play426081103(arg_431_1)
			end
		end

		function arg_431_1.onSingleLineUpdate_(arg_434_0)
			local var_434_0 = 0
			local var_434_1 = 0.15

			if var_434_0 < arg_431_1.time_ and arg_431_1.time_ <= var_434_0 + arg_434_0 then
				arg_431_1.talkMaxDuration = 0
				arg_431_1.dialogCg_.alpha = 1

				arg_431_1.dialog_:SetActive(true)
				SetActive(arg_431_1.leftNameGo_, true)

				local var_434_2 = arg_431_1:FormatText(StoryNameCfg[7].name)

				arg_431_1.leftNameTxt_.text = var_434_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_431_1.leftNameTxt_.transform)

				arg_431_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_431_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_431_1:RecordName(arg_431_1.leftNameTxt_.text)
				SetActive(arg_431_1.iconTrs_.gameObject, true)
				arg_431_1.iconController_:SetSelectedState("hero")

				arg_431_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_431_1.callingController_:SetSelectedState("normal")

				arg_431_1.keyicon_.color = Color.New(1, 1, 1)
				arg_431_1.icon_.color = Color.New(1, 1, 1)

				local var_434_3 = arg_431_1:GetWordFromCfg(426081102)
				local var_434_4 = arg_431_1:FormatText(var_434_3.content)

				arg_431_1.text_.text = var_434_4

				LuaForUtil.ClearLinePrefixSymbol(arg_431_1.text_)

				local var_434_5 = 6
				local var_434_6 = utf8.len(var_434_4)
				local var_434_7 = var_434_5 <= 0 and var_434_1 or var_434_1 * (var_434_6 / var_434_5)

				if var_434_7 > 0 and var_434_1 < var_434_7 then
					arg_431_1.talkMaxDuration = var_434_7

					if var_434_7 + var_434_0 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_7 + var_434_0
					end
				end

				arg_431_1.text_.text = var_434_4
				arg_431_1.typewritter.percent = 0

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(false)
				arg_431_1:RecordContent(arg_431_1.text_.text)
			end

			local var_434_8 = math.max(var_434_1, arg_431_1.talkMaxDuration)

			if var_434_0 <= arg_431_1.time_ and arg_431_1.time_ < var_434_0 + var_434_8 then
				arg_431_1.typewritter.percent = (arg_431_1.time_ - var_434_0) / var_434_8

				arg_431_1.typewritter:SetDirty()
			end

			if arg_431_1.time_ >= var_434_0 + var_434_8 and arg_431_1.time_ < var_434_0 + var_434_8 + arg_434_0 then
				arg_431_1.typewritter.percent = 1

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(true)
			end
		end

		arg_431_1.nodeConfigList_ = {}

		arg_431_1:InitPlayNodeList()
	end,
	Play426081103 = function(arg_435_0, arg_435_1)
		arg_435_1.time_ = 0
		arg_435_1.frameCnt_ = 0
		arg_435_1.state_ = "playing"
		arg_435_1.curTalkId_ = 426081103
		arg_435_1.duration_ = 5

		SetActive(arg_435_1.tipsGo_, false)

		function arg_435_1.onSingleLineFinish_()
			arg_435_1.onSingleLineUpdate_ = nil
			arg_435_1.onSingleLineFinish_ = nil
			arg_435_1.state_ = "waiting"
		end

		function arg_435_1.playNext_(arg_437_0)
			if arg_437_0 == 1 then
				arg_435_0:Play426081104(arg_435_1)
			end
		end

		function arg_435_1.onSingleLineUpdate_(arg_438_0)
			local var_438_0 = 0
			local var_438_1 = 1.125

			if var_438_0 < arg_435_1.time_ and arg_435_1.time_ <= var_438_0 + arg_438_0 then
				arg_435_1.talkMaxDuration = 0
				arg_435_1.dialogCg_.alpha = 1

				arg_435_1.dialog_:SetActive(true)
				SetActive(arg_435_1.leftNameGo_, false)

				arg_435_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_435_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_435_1:RecordName(arg_435_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_435_1.iconTrs_.gameObject, false)
				arg_435_1.callingController_:SetSelectedState("normal")

				local var_438_2 = arg_435_1:GetWordFromCfg(426081103)
				local var_438_3 = arg_435_1:FormatText(var_438_2.content)

				arg_435_1.text_.text = var_438_3

				LuaForUtil.ClearLinePrefixSymbol(arg_435_1.text_)

				local var_438_4 = 45
				local var_438_5 = utf8.len(var_438_3)
				local var_438_6 = var_438_4 <= 0 and var_438_1 or var_438_1 * (var_438_5 / var_438_4)

				if var_438_6 > 0 and var_438_1 < var_438_6 then
					arg_435_1.talkMaxDuration = var_438_6

					if var_438_6 + var_438_0 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_6 + var_438_0
					end
				end

				arg_435_1.text_.text = var_438_3
				arg_435_1.typewritter.percent = 0

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(false)
				arg_435_1:RecordContent(arg_435_1.text_.text)
			end

			local var_438_7 = math.max(var_438_1, arg_435_1.talkMaxDuration)

			if var_438_0 <= arg_435_1.time_ and arg_435_1.time_ < var_438_0 + var_438_7 then
				arg_435_1.typewritter.percent = (arg_435_1.time_ - var_438_0) / var_438_7

				arg_435_1.typewritter:SetDirty()
			end

			if arg_435_1.time_ >= var_438_0 + var_438_7 and arg_435_1.time_ < var_438_0 + var_438_7 + arg_438_0 then
				arg_435_1.typewritter.percent = 1

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(true)
			end
		end

		arg_435_1.nodeConfigList_ = {}

		arg_435_1:InitPlayNodeList()
	end,
	Play426081104 = function(arg_439_0, arg_439_1)
		arg_439_1.time_ = 0
		arg_439_1.frameCnt_ = 0
		arg_439_1.state_ = "playing"
		arg_439_1.curTalkId_ = 426081104
		arg_439_1.duration_ = 5

		SetActive(arg_439_1.tipsGo_, false)

		function arg_439_1.onSingleLineFinish_()
			arg_439_1.onSingleLineUpdate_ = nil
			arg_439_1.onSingleLineFinish_ = nil
			arg_439_1.state_ = "waiting"
			arg_439_1.auto_ = false
		end

		function arg_439_1.playNext_(arg_441_0)
			arg_439_1.onStoryFinished_()
		end

		function arg_439_1.onSingleLineUpdate_(arg_442_0)
			local var_442_0 = 0
			local var_442_1 = 0.825

			if var_442_0 < arg_439_1.time_ and arg_439_1.time_ <= var_442_0 + arg_442_0 then
				arg_439_1.talkMaxDuration = 0
				arg_439_1.dialogCg_.alpha = 1

				arg_439_1.dialog_:SetActive(true)
				SetActive(arg_439_1.leftNameGo_, false)

				arg_439_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_439_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_439_1:RecordName(arg_439_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_439_1.iconTrs_.gameObject, false)
				arg_439_1.callingController_:SetSelectedState("normal")

				local var_442_2 = arg_439_1:GetWordFromCfg(426081104)
				local var_442_3 = arg_439_1:FormatText(var_442_2.content)

				arg_439_1.text_.text = var_442_3

				LuaForUtil.ClearLinePrefixSymbol(arg_439_1.text_)

				local var_442_4 = 33
				local var_442_5 = utf8.len(var_442_3)
				local var_442_6 = var_442_4 <= 0 and var_442_1 or var_442_1 * (var_442_5 / var_442_4)

				if var_442_6 > 0 and var_442_1 < var_442_6 then
					arg_439_1.talkMaxDuration = var_442_6

					if var_442_6 + var_442_0 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_6 + var_442_0
					end
				end

				arg_439_1.text_.text = var_442_3
				arg_439_1.typewritter.percent = 0

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(false)
				arg_439_1:RecordContent(arg_439_1.text_.text)
			end

			local var_442_7 = math.max(var_442_1, arg_439_1.talkMaxDuration)

			if var_442_0 <= arg_439_1.time_ and arg_439_1.time_ < var_442_0 + var_442_7 then
				arg_439_1.typewritter.percent = (arg_439_1.time_ - var_442_0) / var_442_7

				arg_439_1.typewritter:SetDirty()
			end

			if arg_439_1.time_ >= var_442_0 + var_442_7 and arg_439_1.time_ < var_442_0 + var_442_7 + arg_442_0 then
				arg_439_1.typewritter.percent = 1

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(true)
			end
		end

		arg_439_1.nodeConfigList_ = {}

		arg_439_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST2401",
		"TextureConfig/Background/ST47",
		"TextureConfig/Background/ST07a",
		"TextureConfig/Background/J27f"
	},
	voices = {
		"story_v_out_426081.awb"
	}
}
