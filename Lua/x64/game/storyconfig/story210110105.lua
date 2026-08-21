return {
	Play1101105001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 1101105001
		arg_1_1.duration_ = 6.67

		local var_1_0 = {
			zh = 6.666,
			ja = 6.1
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
				arg_1_0:Play1101105002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "D999"

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
				local var_4_5 = arg_1_1.bgs_.D999

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
					if iter_4_0 ~= "D999" then
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

			local var_4_22 = 0
			local var_4_23 = 0.3

			if var_4_22 < arg_1_1.time_ and arg_1_1.time_ <= var_4_22 + arg_4_0 then
				local var_4_24 = "play"
				local var_4_25 = "music"

				arg_1_1:AudioAction(var_4_24, var_4_25, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_26 = ""
				local var_4_27 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_27 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_27 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_27

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_27
						arg_1_1.bgmTxt2_.text = var_4_27
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

			local var_4_28 = 0.533333333333333
			local var_4_29 = 1

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_side_daily05", "bgm_side_daily05", "bgm_side_daily05.awb")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("bgm_side_daily05", "bgm_side_daily05")

				if var_4_33 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_33 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_33

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_33
						arg_1_1.bgmTxt2_.text = var_4_33
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

			local var_4_34 = 2
			local var_4_35 = 0.525

			if var_4_34 < arg_1_1.time_ and arg_1_1.time_ <= var_4_34 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_36 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_36:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_37 = arg_1_1:FormatText(StoryNameCfg[36].name)

				arg_1_1.leftNameTxt_.text = var_4_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_38 = arg_1_1:GetWordFromCfg(1101105001)
				local var_4_39 = arg_1_1:FormatText(var_4_38.content)

				arg_1_1.text_.text = var_4_39

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_40 = 21
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

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105001", "story_v_side_new_1101105.awb") ~= 0 then
					local var_4_43 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105001", "story_v_side_new_1101105.awb") / 1000

					if var_4_43 + var_4_34 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_43 + var_4_34
					end

					if var_4_38.prefab_name ~= "" and arg_1_1.actors_[var_4_38.prefab_name] ~= nil then
						local var_4_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_38.prefab_name].transform, "story_v_side_new_1101105", "1101105001", "story_v_side_new_1101105.awb")

						arg_1_1:RecordAudio("1101105001", var_4_44)
						arg_1_1:RecordAudio("1101105001", var_4_44)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105001", "story_v_side_new_1101105.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105001", "story_v_side_new_1101105.awb")
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
	Play1101105002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 1101105002
		arg_9_1.duration_ = 4.43

		local var_9_0 = {
			zh = 4.2,
			ja = 4.433
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
				arg_9_0:Play1101105003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 0.725

			if var_12_0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_2 = arg_9_1:FormatText(StoryNameCfg[36].name)

				arg_9_1.leftNameTxt_.text = var_12_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_3 = arg_9_1:GetWordFromCfg(1101105002)
				local var_12_4 = arg_9_1:FormatText(var_12_3.content)

				arg_9_1.text_.text = var_12_4

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_5 = 29
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

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105002", "story_v_side_new_1101105.awb") ~= 0 then
					local var_12_8 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105002", "story_v_side_new_1101105.awb") / 1000

					if var_12_8 + var_12_0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_8 + var_12_0
					end

					if var_12_3.prefab_name ~= "" and arg_9_1.actors_[var_12_3.prefab_name] ~= nil then
						local var_12_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_3.prefab_name].transform, "story_v_side_new_1101105", "1101105002", "story_v_side_new_1101105.awb")

						arg_9_1:RecordAudio("1101105002", var_12_9)
						arg_9_1:RecordAudio("1101105002", var_12_9)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105002", "story_v_side_new_1101105.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105002", "story_v_side_new_1101105.awb")
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
	Play1101105003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 1101105003
		arg_13_1.duration_ = 9

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play1101105004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = "ST01_blur"

			if arg_13_1.bgs_[var_16_0] == nil then
				local var_16_1 = Object.Instantiate(arg_13_1.paintGo_)

				var_16_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_16_0)
				var_16_1.name = var_16_0
				var_16_1.transform.parent = arg_13_1.stage_.transform
				var_16_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_13_1.bgs_[var_16_0] = var_16_1
			end

			local var_16_2 = 2

			if var_16_2 < arg_13_1.time_ and arg_13_1.time_ <= var_16_2 + arg_16_0 then
				local var_16_3 = manager.ui.mainCamera.transform.localPosition
				local var_16_4 = Vector3.New(0, 0, 10) + Vector3.New(var_16_3.x, var_16_3.y, 0)
				local var_16_5 = arg_13_1.bgs_.ST01_blur

				var_16_5.transform.localPosition = var_16_4
				var_16_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_16_6 = var_16_5:GetComponent("SpriteRenderer")

				if var_16_6 and var_16_6.sprite then
					local var_16_7 = (var_16_5.transform.localPosition - var_16_3).z
					local var_16_8 = manager.ui.mainCameraCom_
					local var_16_9 = 2 * var_16_7 * Mathf.Tan(var_16_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_16_10 = var_16_9 * var_16_8.aspect
					local var_16_11 = var_16_6.sprite.bounds.size.x
					local var_16_12 = var_16_6.sprite.bounds.size.y
					local var_16_13 = var_16_10 / var_16_11
					local var_16_14 = var_16_9 / var_16_12
					local var_16_15 = var_16_14 < var_16_13 and var_16_13 or var_16_14

					var_16_5.transform.localScale = Vector3.New(var_16_15, var_16_15, 0)
				end

				for iter_16_0, iter_16_1 in pairs(arg_13_1.bgs_) do
					if iter_16_0 ~= "ST01_blur" then
						iter_16_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_16_16 = 0

			if var_16_16 < arg_13_1.time_ and arg_13_1.time_ <= var_16_16 + arg_16_0 then
				arg_13_1.mask_.enabled = true
				arg_13_1.mask_.raycastTarget = true

				arg_13_1:SetGaussion(false)
			end

			local var_16_17 = 2

			if var_16_16 <= arg_13_1.time_ and arg_13_1.time_ < var_16_16 + var_16_17 then
				local var_16_18 = (arg_13_1.time_ - var_16_16) / var_16_17
				local var_16_19 = Color.New(0, 0, 0)

				var_16_19.a = Mathf.Lerp(0, 1, var_16_18)
				arg_13_1.mask_.color = var_16_19
			end

			if arg_13_1.time_ >= var_16_16 + var_16_17 and arg_13_1.time_ < var_16_16 + var_16_17 + arg_16_0 then
				local var_16_20 = Color.New(0, 0, 0)

				var_16_20.a = 1
				arg_13_1.mask_.color = var_16_20
			end

			local var_16_21 = 2

			if var_16_21 < arg_13_1.time_ and arg_13_1.time_ <= var_16_21 + arg_16_0 then
				arg_13_1.mask_.enabled = true
				arg_13_1.mask_.raycastTarget = true

				arg_13_1:SetGaussion(false)
			end

			local var_16_22 = 2

			if var_16_21 <= arg_13_1.time_ and arg_13_1.time_ < var_16_21 + var_16_22 then
				local var_16_23 = (arg_13_1.time_ - var_16_21) / var_16_22
				local var_16_24 = Color.New(0, 0, 0)

				var_16_24.a = Mathf.Lerp(1, 0, var_16_23)
				arg_13_1.mask_.color = var_16_24
			end

			if arg_13_1.time_ >= var_16_21 + var_16_22 and arg_13_1.time_ < var_16_21 + var_16_22 + arg_16_0 then
				local var_16_25 = Color.New(0, 0, 0)
				local var_16_26 = 0

				arg_13_1.mask_.enabled = false
				var_16_25.a = var_16_26
				arg_13_1.mask_.color = var_16_25
			end

			if arg_13_1.frameCnt_ <= 1 then
				arg_13_1.dialog_:SetActive(false)
			end

			local var_16_27 = 4
			local var_16_28 = 0.825

			if var_16_27 < arg_13_1.time_ and arg_13_1.time_ <= var_16_27 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0

				arg_13_1.dialog_:SetActive(true)

				arg_13_1.dialogCg_.alpha = 0

				local var_16_29 = LeanTween.value(arg_13_1.dialog_, 0, 1, 0.3)

				var_16_29:setOnUpdate(LuaHelper.FloatAction(function(arg_17_0)
					arg_13_1.dialogCg_.alpha = arg_17_0
				end))
				var_16_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_13_1.dialog_)
					var_16_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_13_1.duration_ = arg_13_1.duration_ + 0.3

				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_30 = arg_13_1:GetWordFromCfg(1101105003)
				local var_16_31 = arg_13_1:FormatText(var_16_30.content)

				arg_13_1.text_.text = var_16_31

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_32 = 33
				local var_16_33 = utf8.len(var_16_31)
				local var_16_34 = var_16_32 <= 0 and var_16_28 or var_16_28 * (var_16_33 / var_16_32)

				if var_16_34 > 0 and var_16_28 < var_16_34 then
					arg_13_1.talkMaxDuration = var_16_34
					var_16_27 = var_16_27 + 0.3

					if var_16_34 + var_16_27 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_34 + var_16_27
					end
				end

				arg_13_1.text_.text = var_16_31
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_35 = var_16_27 + 0.3
			local var_16_36 = math.max(var_16_28, arg_13_1.talkMaxDuration)

			if var_16_35 <= arg_13_1.time_ and arg_13_1.time_ < var_16_35 + var_16_36 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_35) / var_16_36

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_35 + var_16_36 and arg_13_1.time_ < var_16_35 + var_16_36 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play1101105004 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 1101105004
		arg_19_1.duration_ = 5

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play1101105005(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			local var_22_0 = "ST01"

			if arg_19_1.bgs_[var_22_0] == nil then
				local var_22_1 = Object.Instantiate(arg_19_1.blurPaintGo_)
				local var_22_2 = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_22_0)

				var_22_1:GetComponent("SpriteRenderer").sprite = var_22_2
				var_22_1.name = var_22_0
				var_22_1.transform.parent = arg_19_1.stage_.transform
				var_22_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_19_1.bgs_[var_22_0] = var_22_1
			end

			local var_22_3 = 0
			local var_22_4 = arg_19_1.bgs_[var_22_0]

			if var_22_3 < arg_19_1.time_ and arg_19_1.time_ <= var_22_3 + arg_22_0 then
				local var_22_5 = manager.ui.mainCamera.transform.localPosition
				local var_22_6 = Vector3.New(0, 0, 10) + Vector3.New(var_22_5.x, var_22_5.y, 0)

				var_22_4.transform.localPosition = var_22_6
				var_22_4.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_22_7 = var_22_4:GetComponent("SpriteRenderer")

				if var_22_7 and var_22_7.sprite then
					local var_22_8 = (var_22_4.transform.localPosition - var_22_5).z
					local var_22_9 = manager.ui.mainCameraCom_
					local var_22_10 = 2 * var_22_8 * Mathf.Tan(var_22_9.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_22_11 = var_22_10 * var_22_9.aspect
					local var_22_12 = var_22_7.sprite.bounds.size.x
					local var_22_13 = var_22_7.sprite.bounds.size.y
					local var_22_14 = var_22_11 / var_22_12
					local var_22_15 = var_22_10 / var_22_13
					local var_22_16 = var_22_15 < var_22_14 and var_22_14 or var_22_15

					var_22_4.transform.localScale = Vector3.New(var_22_16, var_22_16, 0)
				end
			end

			local var_22_17 = 2

			if var_22_3 <= arg_19_1.time_ and arg_19_1.time_ < var_22_3 + var_22_17 then
				local var_22_18 = (arg_19_1.time_ - var_22_3) / var_22_17
				local var_22_19 = Color.New(1, 1, 1)

				var_22_19.a = Mathf.Lerp(0, 1, var_22_18)

				var_22_4:GetComponent("SpriteRenderer").material:SetColor("_Color", var_22_19)
			end

			local var_22_20 = 0
			local var_22_21 = 0.55

			if var_22_20 < arg_19_1.time_ and arg_19_1.time_ <= var_22_20 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, false)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_22 = arg_19_1:GetWordFromCfg(1101105004)
				local var_22_23 = arg_19_1:FormatText(var_22_22.content)

				arg_19_1.text_.text = var_22_23

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_24 = 22
				local var_22_25 = utf8.len(var_22_23)
				local var_22_26 = var_22_24 <= 0 and var_22_21 or var_22_21 * (var_22_25 / var_22_24)

				if var_22_26 > 0 and var_22_21 < var_22_26 then
					arg_19_1.talkMaxDuration = var_22_26

					if var_22_26 + var_22_20 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_26 + var_22_20
					end
				end

				arg_19_1.text_.text = var_22_23
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)
				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_27 = math.max(var_22_21, arg_19_1.talkMaxDuration)

			if var_22_20 <= arg_19_1.time_ and arg_19_1.time_ < var_22_20 + var_22_27 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_20) / var_22_27

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_20 + var_22_27 and arg_19_1.time_ < var_22_20 + var_22_27 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {}

		arg_19_1:InitPlayNodeList()
	end,
	Play1101105005 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 1101105005
		arg_23_1.duration_ = 5

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play1101105006(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			local var_26_0 = 0
			local var_26_1 = 1.075

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

				local var_26_2 = arg_23_1:GetWordFromCfg(1101105005)
				local var_26_3 = arg_23_1:FormatText(var_26_2.content)

				arg_23_1.text_.text = var_26_3

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_4 = 43
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
	Play1101105006 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 1101105006
		arg_27_1.duration_ = 5

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play1101105007(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			local var_30_0 = 0
			local var_30_1 = 0.85

			if var_30_0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_0 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				local var_30_2 = arg_27_1:FormatText(StoryNameCfg[7].name)

				arg_27_1.leftNameTxt_.text = var_30_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, true)
				arg_27_1.iconController_:SetSelectedState("hero")

				arg_27_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_27_1.callingController_:SetSelectedState("normal")

				arg_27_1.keyicon_.color = Color.New(1, 1, 1)
				arg_27_1.icon_.color = Color.New(1, 1, 1)

				local var_30_3 = arg_27_1:GetWordFromCfg(1101105006)
				local var_30_4 = arg_27_1:FormatText(var_30_3.content)

				arg_27_1.text_.text = var_30_4

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_5 = 34
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
				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_8 = math.max(var_30_1, arg_27_1.talkMaxDuration)

			if var_30_0 <= arg_27_1.time_ and arg_27_1.time_ < var_30_0 + var_30_8 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_0) / var_30_8

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_0 + var_30_8 and arg_27_1.time_ < var_30_0 + var_30_8 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {}

		arg_27_1:InitPlayNodeList()
	end,
	Play1101105007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 1101105007
		arg_31_1.duration_ = 5

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play1101105008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = 0
			local var_34_1 = 0.05

			if var_34_0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_0 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, false)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_2 = arg_31_1:GetWordFromCfg(1101105007)
				local var_34_3 = arg_31_1:FormatText(var_34_2.content)

				arg_31_1.text_.text = var_34_3

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_4 = 2
				local var_34_5 = utf8.len(var_34_3)
				local var_34_6 = var_34_4 <= 0 and var_34_1 or var_34_1 * (var_34_5 / var_34_4)

				if var_34_6 > 0 and var_34_1 < var_34_6 then
					arg_31_1.talkMaxDuration = var_34_6

					if var_34_6 + var_34_0 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_6 + var_34_0
					end
				end

				arg_31_1.text_.text = var_34_3
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)
				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_7 = math.max(var_34_1, arg_31_1.talkMaxDuration)

			if var_34_0 <= arg_31_1.time_ and arg_31_1.time_ < var_34_0 + var_34_7 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_0) / var_34_7

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_0 + var_34_7 and arg_31_1.time_ < var_34_0 + var_34_7 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {}

		arg_31_1:InitPlayNodeList()
	end,
	Play1101105008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 1101105008
		arg_35_1.duration_ = 5

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play1101105009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = 0

			if var_38_0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_0 + arg_38_0 then
				arg_35_1.allBtn_.enabled = false
			end

			local var_38_1 = 1.5

			if arg_35_1.time_ >= var_38_0 + var_38_1 and arg_35_1.time_ < var_38_0 + var_38_1 + arg_38_0 then
				arg_35_1.allBtn_.enabled = true
			end

			local var_38_2 = 0
			local var_38_3 = 0.575

			if var_38_2 < arg_35_1.time_ and arg_35_1.time_ <= var_38_2 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, false)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_4 = arg_35_1:GetWordFromCfg(1101105008)
				local var_38_5 = arg_35_1:FormatText(var_38_4.content)

				arg_35_1.text_.text = var_38_5

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_6 = 23
				local var_38_7 = utf8.len(var_38_5)
				local var_38_8 = var_38_6 <= 0 and var_38_3 or var_38_3 * (var_38_7 / var_38_6)

				if var_38_8 > 0 and var_38_3 < var_38_8 then
					arg_35_1.talkMaxDuration = var_38_8

					if var_38_8 + var_38_2 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_8 + var_38_2
					end
				end

				arg_35_1.text_.text = var_38_5
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)
				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_9 = math.max(var_38_3, arg_35_1.talkMaxDuration)

			if var_38_2 <= arg_35_1.time_ and arg_35_1.time_ < var_38_2 + var_38_9 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_2) / var_38_9

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_2 + var_38_9 and arg_35_1.time_ < var_38_2 + var_38_9 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {}

		arg_35_1:InitPlayNodeList()
	end,
	Play1101105009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 1101105009
		arg_39_1.duration_ = 5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play1101105010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = manager.ui.mainCamera.transform
			local var_42_1 = 0

			if var_42_1 < arg_39_1.time_ and arg_39_1.time_ <= var_42_1 + arg_42_0 then
				arg_39_1.var_.shakeOldPos = var_42_0.localPosition
			end

			local var_42_2 = 1

			if var_42_1 <= arg_39_1.time_ and arg_39_1.time_ < var_42_1 + var_42_2 then
				local var_42_3 = (arg_39_1.time_ - var_42_1) / 0.099
				local var_42_4, var_42_5 = math.modf(var_42_3)

				var_42_0.localPosition = Vector3.New(var_42_5 * 0.13, var_42_5 * 0.13, var_42_5 * 0.13) + arg_39_1.var_.shakeOldPos
			end

			if arg_39_1.time_ >= var_42_1 + var_42_2 and arg_39_1.time_ < var_42_1 + var_42_2 + arg_42_0 then
				var_42_0.localPosition = arg_39_1.var_.shakeOldPos
			end

			local var_42_6 = 0
			local var_42_7 = 0.275

			if var_42_6 < arg_39_1.time_ and arg_39_1.time_ <= var_42_6 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				local var_42_8 = arg_39_1:FormatText(StoryNameCfg[7].name)

				arg_39_1.leftNameTxt_.text = var_42_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, true)
				arg_39_1.iconController_:SetSelectedState("hero")

				arg_39_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_39_1.callingController_:SetSelectedState("normal")

				arg_39_1.keyicon_.color = Color.New(1, 1, 1)
				arg_39_1.icon_.color = Color.New(1, 1, 1)

				local var_42_9 = arg_39_1:GetWordFromCfg(1101105009)
				local var_42_10 = arg_39_1:FormatText(var_42_9.content)

				arg_39_1.text_.text = var_42_10

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_11 = 11
				local var_42_12 = utf8.len(var_42_10)
				local var_42_13 = var_42_11 <= 0 and var_42_7 or var_42_7 * (var_42_12 / var_42_11)

				if var_42_13 > 0 and var_42_7 < var_42_13 then
					arg_39_1.talkMaxDuration = var_42_13

					if var_42_13 + var_42_6 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_13 + var_42_6
					end
				end

				arg_39_1.text_.text = var_42_10
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)
				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_14 = math.max(var_42_7, arg_39_1.talkMaxDuration)

			if var_42_6 <= arg_39_1.time_ and arg_39_1.time_ < var_42_6 + var_42_14 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_6) / var_42_14

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_6 + var_42_14 and arg_39_1.time_ < var_42_6 + var_42_14 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play1101105010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 1101105010
		arg_43_1.duration_ = 5

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play1101105011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = 0
			local var_46_1 = 1.175

			if var_46_0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_0 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, false)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_2 = arg_43_1:GetWordFromCfg(1101105010)
				local var_46_3 = arg_43_1:FormatText(var_46_2.content)

				arg_43_1.text_.text = var_46_3

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_4 = 47
				local var_46_5 = utf8.len(var_46_3)
				local var_46_6 = var_46_4 <= 0 and var_46_1 or var_46_1 * (var_46_5 / var_46_4)

				if var_46_6 > 0 and var_46_1 < var_46_6 then
					arg_43_1.talkMaxDuration = var_46_6

					if var_46_6 + var_46_0 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_6 + var_46_0
					end
				end

				arg_43_1.text_.text = var_46_3
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)
				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_7 = math.max(var_46_1, arg_43_1.talkMaxDuration)

			if var_46_0 <= arg_43_1.time_ and arg_43_1.time_ < var_46_0 + var_46_7 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_0) / var_46_7

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_0 + var_46_7 and arg_43_1.time_ < var_46_0 + var_46_7 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play1101105011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 1101105011
		arg_47_1.duration_ = 5

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play1101105012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = 0
			local var_50_1 = 0.575

			if var_50_0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_0 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, false)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_2 = arg_47_1:GetWordFromCfg(1101105011)
				local var_50_3 = arg_47_1:FormatText(var_50_2.content)

				arg_47_1.text_.text = var_50_3

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_4 = 23
				local var_50_5 = utf8.len(var_50_3)
				local var_50_6 = var_50_4 <= 0 and var_50_1 or var_50_1 * (var_50_5 / var_50_4)

				if var_50_6 > 0 and var_50_1 < var_50_6 then
					arg_47_1.talkMaxDuration = var_50_6

					if var_50_6 + var_50_0 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_6 + var_50_0
					end
				end

				arg_47_1.text_.text = var_50_3
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)
				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_7 = math.max(var_50_1, arg_47_1.talkMaxDuration)

			if var_50_0 <= arg_47_1.time_ and arg_47_1.time_ < var_50_0 + var_50_7 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_0) / var_50_7

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_0 + var_50_7 and arg_47_1.time_ < var_50_0 + var_50_7 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play1101105012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 1101105012
		arg_51_1.duration_ = 5

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play1101105013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = 0
			local var_54_1 = 0.9

			if var_54_0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_0 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, false)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_2 = arg_51_1:GetWordFromCfg(1101105012)
				local var_54_3 = arg_51_1:FormatText(var_54_2.content)

				arg_51_1.text_.text = var_54_3

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_4 = 36
				local var_54_5 = utf8.len(var_54_3)
				local var_54_6 = var_54_4 <= 0 and var_54_1 or var_54_1 * (var_54_5 / var_54_4)

				if var_54_6 > 0 and var_54_1 < var_54_6 then
					arg_51_1.talkMaxDuration = var_54_6

					if var_54_6 + var_54_0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_6 + var_54_0
					end
				end

				arg_51_1.text_.text = var_54_3
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)
				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_7 = math.max(var_54_1, arg_51_1.talkMaxDuration)

			if var_54_0 <= arg_51_1.time_ and arg_51_1.time_ < var_54_0 + var_54_7 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_0) / var_54_7

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_0 + var_54_7 and arg_51_1.time_ < var_54_0 + var_54_7 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play1101105013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 1101105013
		arg_55_1.duration_ = 9

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play1101105014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = "ST12"

			if arg_55_1.bgs_[var_58_0] == nil then
				local var_58_1 = Object.Instantiate(arg_55_1.paintGo_)

				var_58_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_58_0)
				var_58_1.name = var_58_0
				var_58_1.transform.parent = arg_55_1.stage_.transform
				var_58_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_55_1.bgs_[var_58_0] = var_58_1
			end

			local var_58_2 = 2

			if var_58_2 < arg_55_1.time_ and arg_55_1.time_ <= var_58_2 + arg_58_0 then
				local var_58_3 = manager.ui.mainCamera.transform.localPosition
				local var_58_4 = Vector3.New(0, 0, 10) + Vector3.New(var_58_3.x, var_58_3.y, 0)
				local var_58_5 = arg_55_1.bgs_.ST12

				var_58_5.transform.localPosition = var_58_4
				var_58_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_58_6 = var_58_5:GetComponent("SpriteRenderer")

				if var_58_6 and var_58_6.sprite then
					local var_58_7 = (var_58_5.transform.localPosition - var_58_3).z
					local var_58_8 = manager.ui.mainCameraCom_
					local var_58_9 = 2 * var_58_7 * Mathf.Tan(var_58_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_58_10 = var_58_9 * var_58_8.aspect
					local var_58_11 = var_58_6.sprite.bounds.size.x
					local var_58_12 = var_58_6.sprite.bounds.size.y
					local var_58_13 = var_58_10 / var_58_11
					local var_58_14 = var_58_9 / var_58_12
					local var_58_15 = var_58_14 < var_58_13 and var_58_13 or var_58_14

					var_58_5.transform.localScale = Vector3.New(var_58_15, var_58_15, 0)
				end

				for iter_58_0, iter_58_1 in pairs(arg_55_1.bgs_) do
					if iter_58_0 ~= "ST12" then
						iter_58_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_58_16 = 0

			if var_58_16 < arg_55_1.time_ and arg_55_1.time_ <= var_58_16 + arg_58_0 then
				arg_55_1.mask_.enabled = true
				arg_55_1.mask_.raycastTarget = true

				arg_55_1:SetGaussion(false)
			end

			local var_58_17 = 2

			if var_58_16 <= arg_55_1.time_ and arg_55_1.time_ < var_58_16 + var_58_17 then
				local var_58_18 = (arg_55_1.time_ - var_58_16) / var_58_17
				local var_58_19 = Color.New(0, 0, 0)

				var_58_19.a = Mathf.Lerp(0, 1, var_58_18)
				arg_55_1.mask_.color = var_58_19
			end

			if arg_55_1.time_ >= var_58_16 + var_58_17 and arg_55_1.time_ < var_58_16 + var_58_17 + arg_58_0 then
				local var_58_20 = Color.New(0, 0, 0)

				var_58_20.a = 1
				arg_55_1.mask_.color = var_58_20
			end

			local var_58_21 = 2

			if var_58_21 < arg_55_1.time_ and arg_55_1.time_ <= var_58_21 + arg_58_0 then
				arg_55_1.mask_.enabled = true
				arg_55_1.mask_.raycastTarget = true

				arg_55_1:SetGaussion(false)
			end

			local var_58_22 = 2

			if var_58_21 <= arg_55_1.time_ and arg_55_1.time_ < var_58_21 + var_58_22 then
				local var_58_23 = (arg_55_1.time_ - var_58_21) / var_58_22
				local var_58_24 = Color.New(0, 0, 0)

				var_58_24.a = Mathf.Lerp(1, 0, var_58_23)
				arg_55_1.mask_.color = var_58_24
			end

			if arg_55_1.time_ >= var_58_21 + var_58_22 and arg_55_1.time_ < var_58_21 + var_58_22 + arg_58_0 then
				local var_58_25 = Color.New(0, 0, 0)
				local var_58_26 = 0

				arg_55_1.mask_.enabled = false
				var_58_25.a = var_58_26
				arg_55_1.mask_.color = var_58_25
			end

			if arg_55_1.frameCnt_ <= 1 then
				arg_55_1.dialog_:SetActive(false)
			end

			local var_58_27 = 4
			local var_58_28 = 0.775

			if var_58_27 < arg_55_1.time_ and arg_55_1.time_ <= var_58_27 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0

				arg_55_1.dialog_:SetActive(true)

				arg_55_1.dialogCg_.alpha = 0

				local var_58_29 = LeanTween.value(arg_55_1.dialog_, 0, 1, 0.3)

				var_58_29:setOnUpdate(LuaHelper.FloatAction(function(arg_59_0)
					arg_55_1.dialogCg_.alpha = arg_59_0
				end))
				var_58_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_55_1.dialog_)
					var_58_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_55_1.duration_ = arg_55_1.duration_ + 0.3

				SetActive(arg_55_1.leftNameGo_, false)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_30 = arg_55_1:GetWordFromCfg(1101105013)
				local var_58_31 = arg_55_1:FormatText(var_58_30.content)

				arg_55_1.text_.text = var_58_31

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_32 = 31
				local var_58_33 = utf8.len(var_58_31)
				local var_58_34 = var_58_32 <= 0 and var_58_28 or var_58_28 * (var_58_33 / var_58_32)

				if var_58_34 > 0 and var_58_28 < var_58_34 then
					arg_55_1.talkMaxDuration = var_58_34
					var_58_27 = var_58_27 + 0.3

					if var_58_34 + var_58_27 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_34 + var_58_27
					end
				end

				arg_55_1.text_.text = var_58_31
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)
				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_35 = var_58_27 + 0.3
			local var_58_36 = math.max(var_58_28, arg_55_1.talkMaxDuration)

			if var_58_35 <= arg_55_1.time_ and arg_55_1.time_ < var_58_35 + var_58_36 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_35) / var_58_36

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_35 + var_58_36 and arg_55_1.time_ < var_58_35 + var_58_36 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play1101105014 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 1101105014
		arg_61_1.duration_ = 6.07

		local var_61_0 = {
			zh = 3.666,
			ja = 6.066
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
				arg_61_0:Play1101105015(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = "1011ui_story"

			if arg_61_1.actors_[var_64_0] == nil then
				local var_64_1 = Asset.Load("Char/" .. "1011ui_story")

				if not isNil(var_64_1) then
					local var_64_2 = Object.Instantiate(Asset.Load("Char/" .. "1011ui_story"), arg_61_1.stage_.transform)

					var_64_2.name = var_64_0
					var_64_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_61_1.actors_[var_64_0] = var_64_2

					local var_64_3 = var_64_2:GetComponentInChildren(typeof(CharacterEffect))

					var_64_3.enabled = true

					local var_64_4 = GameObjectTools.GetOrAddComponent(var_64_2, typeof(DynamicBoneHelper))

					if var_64_4 then
						var_64_4:EnableDynamicBone(false)
					end

					arg_61_1:ShowWeapon(var_64_3.transform, false)

					arg_61_1.var_[var_64_0 .. "Animator"] = var_64_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_61_1.var_[var_64_0 .. "Animator"].applyRootMotion = true
					arg_61_1.var_[var_64_0 .. "LipSync"] = var_64_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_64_5 = arg_61_1.actors_["1011ui_story"].transform
			local var_64_6 = 0

			if var_64_6 < arg_61_1.time_ and arg_61_1.time_ <= var_64_6 + arg_64_0 then
				arg_61_1.var_.moveOldPos1011ui_story = var_64_5.localPosition
			end

			local var_64_7 = 0.001

			if var_64_6 <= arg_61_1.time_ and arg_61_1.time_ < var_64_6 + var_64_7 then
				local var_64_8 = (arg_61_1.time_ - var_64_6) / var_64_7
				local var_64_9 = Vector3.New(0, -0.71, -6)

				var_64_5.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1011ui_story, var_64_9, var_64_8)

				local var_64_10 = manager.ui.mainCamera.transform.position - var_64_5.position

				var_64_5.forward = Vector3.New(var_64_10.x, var_64_10.y, var_64_10.z)

				local var_64_11 = var_64_5.localEulerAngles

				var_64_11.z = 0
				var_64_11.x = 0
				var_64_5.localEulerAngles = var_64_11
			end

			if arg_61_1.time_ >= var_64_6 + var_64_7 and arg_61_1.time_ < var_64_6 + var_64_7 + arg_64_0 then
				var_64_5.localPosition = Vector3.New(0, -0.71, -6)

				local var_64_12 = manager.ui.mainCamera.transform.position - var_64_5.position

				var_64_5.forward = Vector3.New(var_64_12.x, var_64_12.y, var_64_12.z)

				local var_64_13 = var_64_5.localEulerAngles

				var_64_13.z = 0
				var_64_13.x = 0
				var_64_5.localEulerAngles = var_64_13
			end

			local var_64_14 = arg_61_1.actors_["1011ui_story"]
			local var_64_15 = 0

			if var_64_15 < arg_61_1.time_ and arg_61_1.time_ <= var_64_15 + arg_64_0 and not isNil(var_64_14) and arg_61_1.var_.characterEffect1011ui_story == nil then
				arg_61_1.var_.characterEffect1011ui_story = var_64_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_16 = 0.200000002980232

			if var_64_15 <= arg_61_1.time_ and arg_61_1.time_ < var_64_15 + var_64_16 and not isNil(var_64_14) then
				local var_64_17 = (arg_61_1.time_ - var_64_15) / var_64_16

				if arg_61_1.var_.characterEffect1011ui_story and not isNil(var_64_14) then
					arg_61_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= var_64_15 + var_64_16 and arg_61_1.time_ < var_64_15 + var_64_16 + arg_64_0 and not isNil(var_64_14) and arg_61_1.var_.characterEffect1011ui_story then
				arg_61_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_64_18 = 0

			if var_64_18 < arg_61_1.time_ and arg_61_1.time_ <= var_64_18 + arg_64_0 then
				arg_61_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action8_1")
			end

			local var_64_19 = 0

			if var_64_19 < arg_61_1.time_ and arg_61_1.time_ <= var_64_19 + arg_64_0 then
				arg_61_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_64_20 = 0
			local var_64_21 = 0.35

			if var_64_20 < arg_61_1.time_ and arg_61_1.time_ <= var_64_20 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_22 = arg_61_1:FormatText(StoryNameCfg[37].name)

				arg_61_1.leftNameTxt_.text = var_64_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_23 = arg_61_1:GetWordFromCfg(1101105014)
				local var_64_24 = arg_61_1:FormatText(var_64_23.content)

				arg_61_1.text_.text = var_64_24

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_25 = 14
				local var_64_26 = utf8.len(var_64_24)
				local var_64_27 = var_64_25 <= 0 and var_64_21 or var_64_21 * (var_64_26 / var_64_25)

				if var_64_27 > 0 and var_64_21 < var_64_27 then
					arg_61_1.talkMaxDuration = var_64_27

					if var_64_27 + var_64_20 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_27 + var_64_20
					end
				end

				arg_61_1.text_.text = var_64_24
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105014", "story_v_side_new_1101105.awb") ~= 0 then
					local var_64_28 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105014", "story_v_side_new_1101105.awb") / 1000

					if var_64_28 + var_64_20 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_28 + var_64_20
					end

					if var_64_23.prefab_name ~= "" and arg_61_1.actors_[var_64_23.prefab_name] ~= nil then
						local var_64_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_23.prefab_name].transform, "story_v_side_new_1101105", "1101105014", "story_v_side_new_1101105.awb")

						arg_61_1:RecordAudio("1101105014", var_64_29)
						arg_61_1:RecordAudio("1101105014", var_64_29)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105014", "story_v_side_new_1101105.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105014", "story_v_side_new_1101105.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_30 = math.max(var_64_21, arg_61_1.talkMaxDuration)

			if var_64_20 <= arg_61_1.time_ and arg_61_1.time_ < var_64_20 + var_64_30 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_20) / var_64_30

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_20 + var_64_30 and arg_61_1.time_ < var_64_20 + var_64_30 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
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
	Play1101105015 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 1101105015
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play1101105016(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["1011ui_story"]
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect1011ui_story == nil then
				arg_65_1.var_.characterEffect1011ui_story = var_68_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_2 = 0.200000002980232

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 and not isNil(var_68_0) then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2

				if arg_65_1.var_.characterEffect1011ui_story and not isNil(var_68_0) then
					local var_68_4 = Mathf.Lerp(0, 0.5, var_68_3)

					arg_65_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_65_1.var_.characterEffect1011ui_story.fillRatio = var_68_4
				end
			end

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect1011ui_story then
				local var_68_5 = 0.5

				arg_65_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_65_1.var_.characterEffect1011ui_story.fillRatio = var_68_5
			end

			local var_68_6 = 0
			local var_68_7 = 0.9

			if var_68_6 < arg_65_1.time_ and arg_65_1.time_ <= var_68_6 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, false)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_8 = arg_65_1:GetWordFromCfg(1101105015)
				local var_68_9 = arg_65_1:FormatText(var_68_8.content)

				arg_65_1.text_.text = var_68_9

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_10 = 36
				local var_68_11 = utf8.len(var_68_9)
				local var_68_12 = var_68_10 <= 0 and var_68_7 or var_68_7 * (var_68_11 / var_68_10)

				if var_68_12 > 0 and var_68_7 < var_68_12 then
					arg_65_1.talkMaxDuration = var_68_12

					if var_68_12 + var_68_6 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_12 + var_68_6
					end
				end

				arg_65_1.text_.text = var_68_9
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_13 = math.max(var_68_7, arg_65_1.talkMaxDuration)

			if var_68_6 <= arg_65_1.time_ and arg_65_1.time_ < var_68_6 + var_68_13 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_6) / var_68_13

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_6 + var_68_13 and arg_65_1.time_ < var_68_6 + var_68_13 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play1101105016 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 1101105016
		arg_69_1.duration_ = 4.6

		local var_69_0 = {
			zh = 3.933,
			ja = 4.6
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
				arg_69_0:Play1101105017(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["1011ui_story"].transform
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 then
				arg_69_1.var_.moveOldPos1011ui_story = var_72_0.localPosition
			end

			local var_72_2 = 0.001

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_2 then
				local var_72_3 = (arg_69_1.time_ - var_72_1) / var_72_2
				local var_72_4 = Vector3.New(0, -0.71, -6)

				var_72_0.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1011ui_story, var_72_4, var_72_3)

				local var_72_5 = manager.ui.mainCamera.transform.position - var_72_0.position

				var_72_0.forward = Vector3.New(var_72_5.x, var_72_5.y, var_72_5.z)

				local var_72_6 = var_72_0.localEulerAngles

				var_72_6.z = 0
				var_72_6.x = 0
				var_72_0.localEulerAngles = var_72_6
			end

			if arg_69_1.time_ >= var_72_1 + var_72_2 and arg_69_1.time_ < var_72_1 + var_72_2 + arg_72_0 then
				var_72_0.localPosition = Vector3.New(0, -0.71, -6)

				local var_72_7 = manager.ui.mainCamera.transform.position - var_72_0.position

				var_72_0.forward = Vector3.New(var_72_7.x, var_72_7.y, var_72_7.z)

				local var_72_8 = var_72_0.localEulerAngles

				var_72_8.z = 0
				var_72_8.x = 0
				var_72_0.localEulerAngles = var_72_8
			end

			local var_72_9 = arg_69_1.actors_["1011ui_story"]
			local var_72_10 = 0

			if var_72_10 < arg_69_1.time_ and arg_69_1.time_ <= var_72_10 + arg_72_0 and not isNil(var_72_9) and arg_69_1.var_.characterEffect1011ui_story == nil then
				arg_69_1.var_.characterEffect1011ui_story = var_72_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_11 = 0.200000002980232

			if var_72_10 <= arg_69_1.time_ and arg_69_1.time_ < var_72_10 + var_72_11 and not isNil(var_72_9) then
				local var_72_12 = (arg_69_1.time_ - var_72_10) / var_72_11

				if arg_69_1.var_.characterEffect1011ui_story and not isNil(var_72_9) then
					arg_69_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= var_72_10 + var_72_11 and arg_69_1.time_ < var_72_10 + var_72_11 + arg_72_0 and not isNil(var_72_9) and arg_69_1.var_.characterEffect1011ui_story then
				arg_69_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_72_13 = 0
			local var_72_14 = 0.45

			if var_72_13 < arg_69_1.time_ and arg_69_1.time_ <= var_72_13 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_15 = arg_69_1:FormatText(StoryNameCfg[37].name)

				arg_69_1.leftNameTxt_.text = var_72_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_16 = arg_69_1:GetWordFromCfg(1101105016)
				local var_72_17 = arg_69_1:FormatText(var_72_16.content)

				arg_69_1.text_.text = var_72_17

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_18 = 18
				local var_72_19 = utf8.len(var_72_17)
				local var_72_20 = var_72_18 <= 0 and var_72_14 or var_72_14 * (var_72_19 / var_72_18)

				if var_72_20 > 0 and var_72_14 < var_72_20 then
					arg_69_1.talkMaxDuration = var_72_20

					if var_72_20 + var_72_13 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_20 + var_72_13
					end
				end

				arg_69_1.text_.text = var_72_17
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105016", "story_v_side_new_1101105.awb") ~= 0 then
					local var_72_21 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105016", "story_v_side_new_1101105.awb") / 1000

					if var_72_21 + var_72_13 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_21 + var_72_13
					end

					if var_72_16.prefab_name ~= "" and arg_69_1.actors_[var_72_16.prefab_name] ~= nil then
						local var_72_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_16.prefab_name].transform, "story_v_side_new_1101105", "1101105016", "story_v_side_new_1101105.awb")

						arg_69_1:RecordAudio("1101105016", var_72_22)
						arg_69_1:RecordAudio("1101105016", var_72_22)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105016", "story_v_side_new_1101105.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105016", "story_v_side_new_1101105.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_23 = math.max(var_72_14, arg_69_1.talkMaxDuration)

			if var_72_13 <= arg_69_1.time_ and arg_69_1.time_ < var_72_13 + var_72_23 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_13) / var_72_23

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_13 + var_72_23 and arg_69_1.time_ < var_72_13 + var_72_23 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_69_1:InitPlayNodeList()
	end,
	Play1101105017 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 1101105017
		arg_73_1.duration_ = 1

		SetActive(arg_73_1.tipsGo_, true)

		arg_73_1.tipsText_.text = StoryTipsCfg[101101].name

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"

			SetActive(arg_73_1.choicesGo_, true)

			for iter_74_0, iter_74_1 in ipairs(arg_73_1.choices_) do
				local var_74_0 = iter_74_0 <= 2

				SetActive(iter_74_1.go, var_74_0)
			end

			arg_73_1.choices_[1].txt.text = arg_73_1:FormatText(StoryChoiceCfg[619].name)
			arg_73_1.choices_[2].txt.text = arg_73_1:FormatText(StoryChoiceCfg[623].name)
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play1101105018(arg_73_1)
			end

			if arg_75_0 == 2 then
				PlayerAction.UseStoryTrigger(1011016, 210110105, 1101105017, 2)
				arg_73_0:Play1101105018(arg_73_1)
			end

			arg_73_1:RecordChoiceLog(1101105017, 619, 623)
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["1011ui_story"]
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.characterEffect1011ui_story == nil then
				arg_73_1.var_.characterEffect1011ui_story = var_76_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_2 = 0.200000002980232

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_2 and not isNil(var_76_0) then
				local var_76_3 = (arg_73_1.time_ - var_76_1) / var_76_2

				if arg_73_1.var_.characterEffect1011ui_story and not isNil(var_76_0) then
					local var_76_4 = Mathf.Lerp(0, 0.5, var_76_3)

					arg_73_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_73_1.var_.characterEffect1011ui_story.fillRatio = var_76_4
				end
			end

			if arg_73_1.time_ >= var_76_1 + var_76_2 and arg_73_1.time_ < var_76_1 + var_76_2 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.characterEffect1011ui_story then
				local var_76_5 = 0.5

				arg_73_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_73_1.var_.characterEffect1011ui_story.fillRatio = var_76_5
			end

			local var_76_6 = 0

			if var_76_6 < arg_73_1.time_ and arg_73_1.time_ <= var_76_6 + arg_76_0 then
				arg_73_1.allBtn_.enabled = false
			end

			local var_76_7 = 0.5

			if arg_73_1.time_ >= var_76_6 + var_76_7 and arg_73_1.time_ < var_76_6 + var_76_7 + arg_76_0 then
				arg_73_1.allBtn_.enabled = true
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play1101105018 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 1101105018
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play1101105019(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0
			local var_80_1 = 0.375

			if var_80_0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_2 = arg_77_1:FormatText(StoryNameCfg[7].name)

				arg_77_1.leftNameTxt_.text = var_80_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, true)
				arg_77_1.iconController_:SetSelectedState("hero")

				arg_77_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_77_1.callingController_:SetSelectedState("normal")

				arg_77_1.keyicon_.color = Color.New(1, 1, 1)
				arg_77_1.icon_.color = Color.New(1, 1, 1)

				local var_80_3 = arg_77_1:GetWordFromCfg(1101105018)
				local var_80_4 = arg_77_1:FormatText(var_80_3.content)

				arg_77_1.text_.text = var_80_4

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_5 = 15
				local var_80_6 = utf8.len(var_80_4)
				local var_80_7 = var_80_5 <= 0 and var_80_1 or var_80_1 * (var_80_6 / var_80_5)

				if var_80_7 > 0 and var_80_1 < var_80_7 then
					arg_77_1.talkMaxDuration = var_80_7

					if var_80_7 + var_80_0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_7 + var_80_0
					end
				end

				arg_77_1.text_.text = var_80_4
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_8 = math.max(var_80_1, arg_77_1.talkMaxDuration)

			if var_80_0 <= arg_77_1.time_ and arg_77_1.time_ < var_80_0 + var_80_8 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_0) / var_80_8

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_0 + var_80_8 and arg_77_1.time_ < var_80_0 + var_80_8 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play1101105019 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 1101105019
		arg_81_1.duration_ = 9.23

		local var_81_0 = {
			zh = 7.666,
			ja = 9.233
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
				arg_81_0:Play1101105020(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = arg_81_1.actors_["1011ui_story"].transform
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 then
				arg_81_1.var_.moveOldPos1011ui_story = var_84_0.localPosition
			end

			local var_84_2 = 0.001

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_2 then
				local var_84_3 = (arg_81_1.time_ - var_84_1) / var_84_2
				local var_84_4 = Vector3.New(0, -0.71, -6)

				var_84_0.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1011ui_story, var_84_4, var_84_3)

				local var_84_5 = manager.ui.mainCamera.transform.position - var_84_0.position

				var_84_0.forward = Vector3.New(var_84_5.x, var_84_5.y, var_84_5.z)

				local var_84_6 = var_84_0.localEulerAngles

				var_84_6.z = 0
				var_84_6.x = 0
				var_84_0.localEulerAngles = var_84_6
			end

			if arg_81_1.time_ >= var_84_1 + var_84_2 and arg_81_1.time_ < var_84_1 + var_84_2 + arg_84_0 then
				var_84_0.localPosition = Vector3.New(0, -0.71, -6)

				local var_84_7 = manager.ui.mainCamera.transform.position - var_84_0.position

				var_84_0.forward = Vector3.New(var_84_7.x, var_84_7.y, var_84_7.z)

				local var_84_8 = var_84_0.localEulerAngles

				var_84_8.z = 0
				var_84_8.x = 0
				var_84_0.localEulerAngles = var_84_8
			end

			local var_84_9 = arg_81_1.actors_["1011ui_story"]
			local var_84_10 = 0

			if var_84_10 < arg_81_1.time_ and arg_81_1.time_ <= var_84_10 + arg_84_0 and not isNil(var_84_9) and arg_81_1.var_.characterEffect1011ui_story == nil then
				arg_81_1.var_.characterEffect1011ui_story = var_84_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_11 = 0.200000002980232

			if var_84_10 <= arg_81_1.time_ and arg_81_1.time_ < var_84_10 + var_84_11 and not isNil(var_84_9) then
				local var_84_12 = (arg_81_1.time_ - var_84_10) / var_84_11

				if arg_81_1.var_.characterEffect1011ui_story and not isNil(var_84_9) then
					arg_81_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= var_84_10 + var_84_11 and arg_81_1.time_ < var_84_10 + var_84_11 + arg_84_0 and not isNil(var_84_9) and arg_81_1.var_.characterEffect1011ui_story then
				arg_81_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_84_13 = 0

			if var_84_13 < arg_81_1.time_ and arg_81_1.time_ <= var_84_13 + arg_84_0 then
				arg_81_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011actionlink/1011action486")
			end

			local var_84_14 = 0

			if var_84_14 < arg_81_1.time_ and arg_81_1.time_ <= var_84_14 + arg_84_0 then
				arg_81_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_84_15 = 0
			local var_84_16 = 0.625

			if var_84_15 < arg_81_1.time_ and arg_81_1.time_ <= var_84_15 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_17 = arg_81_1:FormatText(StoryNameCfg[37].name)

				arg_81_1.leftNameTxt_.text = var_84_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_18 = arg_81_1:GetWordFromCfg(1101105019)
				local var_84_19 = arg_81_1:FormatText(var_84_18.content)

				arg_81_1.text_.text = var_84_19

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_20 = 25
				local var_84_21 = utf8.len(var_84_19)
				local var_84_22 = var_84_20 <= 0 and var_84_16 or var_84_16 * (var_84_21 / var_84_20)

				if var_84_22 > 0 and var_84_16 < var_84_22 then
					arg_81_1.talkMaxDuration = var_84_22

					if var_84_22 + var_84_15 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_22 + var_84_15
					end
				end

				arg_81_1.text_.text = var_84_19
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105019", "story_v_side_new_1101105.awb") ~= 0 then
					local var_84_23 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105019", "story_v_side_new_1101105.awb") / 1000

					if var_84_23 + var_84_15 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_23 + var_84_15
					end

					if var_84_18.prefab_name ~= "" and arg_81_1.actors_[var_84_18.prefab_name] ~= nil then
						local var_84_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_18.prefab_name].transform, "story_v_side_new_1101105", "1101105019", "story_v_side_new_1101105.awb")

						arg_81_1:RecordAudio("1101105019", var_84_24)
						arg_81_1:RecordAudio("1101105019", var_84_24)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105019", "story_v_side_new_1101105.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105019", "story_v_side_new_1101105.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_25 = math.max(var_84_16, arg_81_1.talkMaxDuration)

			if var_84_15 <= arg_81_1.time_ and arg_81_1.time_ < var_84_15 + var_84_25 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_15) / var_84_25

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_15 + var_84_25 and arg_81_1.time_ < var_84_15 + var_84_25 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
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
	Play1101105020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 1101105020
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play1101105021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["1011ui_story"]
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.characterEffect1011ui_story == nil then
				arg_85_1.var_.characterEffect1011ui_story = var_88_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_2 = 0.200000002980232

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_2 and not isNil(var_88_0) then
				local var_88_3 = (arg_85_1.time_ - var_88_1) / var_88_2

				if arg_85_1.var_.characterEffect1011ui_story and not isNil(var_88_0) then
					local var_88_4 = Mathf.Lerp(0, 0.5, var_88_3)

					arg_85_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_85_1.var_.characterEffect1011ui_story.fillRatio = var_88_4
				end
			end

			if arg_85_1.time_ >= var_88_1 + var_88_2 and arg_85_1.time_ < var_88_1 + var_88_2 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.characterEffect1011ui_story then
				local var_88_5 = 0.5

				arg_85_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_85_1.var_.characterEffect1011ui_story.fillRatio = var_88_5
			end

			local var_88_6 = 0
			local var_88_7 = 0.825

			if var_88_6 < arg_85_1.time_ and arg_85_1.time_ <= var_88_6 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_8 = arg_85_1:FormatText(StoryNameCfg[7].name)

				arg_85_1.leftNameTxt_.text = var_88_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, true)
				arg_85_1.iconController_:SetSelectedState("hero")

				arg_85_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_85_1.callingController_:SetSelectedState("normal")

				arg_85_1.keyicon_.color = Color.New(1, 1, 1)
				arg_85_1.icon_.color = Color.New(1, 1, 1)

				local var_88_9 = arg_85_1:GetWordFromCfg(1101105020)
				local var_88_10 = arg_85_1:FormatText(var_88_9.content)

				arg_85_1.text_.text = var_88_10

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_11 = 33
				local var_88_12 = utf8.len(var_88_10)
				local var_88_13 = var_88_11 <= 0 and var_88_7 or var_88_7 * (var_88_12 / var_88_11)

				if var_88_13 > 0 and var_88_7 < var_88_13 then
					arg_85_1.talkMaxDuration = var_88_13

					if var_88_13 + var_88_6 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_13 + var_88_6
					end
				end

				arg_85_1.text_.text = var_88_10
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_14 = math.max(var_88_7, arg_85_1.talkMaxDuration)

			if var_88_6 <= arg_85_1.time_ and arg_85_1.time_ < var_88_6 + var_88_14 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_6) / var_88_14

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_6 + var_88_14 and arg_85_1.time_ < var_88_6 + var_88_14 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play1101105021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 1101105021
		arg_89_1.duration_ = 9.97

		local var_89_0 = {
			zh = 9.966,
			ja = 7.966
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
				arg_89_0:Play1101105022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = arg_89_1.actors_["1011ui_story"].transform
			local var_92_1 = 0

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 then
				arg_89_1.var_.moveOldPos1011ui_story = var_92_0.localPosition
			end

			local var_92_2 = 0.001

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_2 then
				local var_92_3 = (arg_89_1.time_ - var_92_1) / var_92_2
				local var_92_4 = Vector3.New(0, -0.71, -6)

				var_92_0.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1011ui_story, var_92_4, var_92_3)

				local var_92_5 = manager.ui.mainCamera.transform.position - var_92_0.position

				var_92_0.forward = Vector3.New(var_92_5.x, var_92_5.y, var_92_5.z)

				local var_92_6 = var_92_0.localEulerAngles

				var_92_6.z = 0
				var_92_6.x = 0
				var_92_0.localEulerAngles = var_92_6
			end

			if arg_89_1.time_ >= var_92_1 + var_92_2 and arg_89_1.time_ < var_92_1 + var_92_2 + arg_92_0 then
				var_92_0.localPosition = Vector3.New(0, -0.71, -6)

				local var_92_7 = manager.ui.mainCamera.transform.position - var_92_0.position

				var_92_0.forward = Vector3.New(var_92_7.x, var_92_7.y, var_92_7.z)

				local var_92_8 = var_92_0.localEulerAngles

				var_92_8.z = 0
				var_92_8.x = 0
				var_92_0.localEulerAngles = var_92_8
			end

			local var_92_9 = arg_89_1.actors_["1011ui_story"]
			local var_92_10 = 0

			if var_92_10 < arg_89_1.time_ and arg_89_1.time_ <= var_92_10 + arg_92_0 and not isNil(var_92_9) and arg_89_1.var_.characterEffect1011ui_story == nil then
				arg_89_1.var_.characterEffect1011ui_story = var_92_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_11 = 0.200000002980232

			if var_92_10 <= arg_89_1.time_ and arg_89_1.time_ < var_92_10 + var_92_11 and not isNil(var_92_9) then
				local var_92_12 = (arg_89_1.time_ - var_92_10) / var_92_11

				if arg_89_1.var_.characterEffect1011ui_story and not isNil(var_92_9) then
					arg_89_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= var_92_10 + var_92_11 and arg_89_1.time_ < var_92_10 + var_92_11 + arg_92_0 and not isNil(var_92_9) and arg_89_1.var_.characterEffect1011ui_story then
				arg_89_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_92_13 = 0

			if var_92_13 < arg_89_1.time_ and arg_89_1.time_ <= var_92_13 + arg_92_0 then
				arg_89_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011actionlink/1011action462")
			end

			local var_92_14 = 0

			if var_92_14 < arg_89_1.time_ and arg_89_1.time_ <= var_92_14 + arg_92_0 then
				arg_89_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_92_15 = 0
			local var_92_16 = 0.675

			if var_92_15 < arg_89_1.time_ and arg_89_1.time_ <= var_92_15 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_17 = arg_89_1:FormatText(StoryNameCfg[37].name)

				arg_89_1.leftNameTxt_.text = var_92_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_18 = arg_89_1:GetWordFromCfg(1101105021)
				local var_92_19 = arg_89_1:FormatText(var_92_18.content)

				arg_89_1.text_.text = var_92_19

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_20 = 27
				local var_92_21 = utf8.len(var_92_19)
				local var_92_22 = var_92_20 <= 0 and var_92_16 or var_92_16 * (var_92_21 / var_92_20)

				if var_92_22 > 0 and var_92_16 < var_92_22 then
					arg_89_1.talkMaxDuration = var_92_22

					if var_92_22 + var_92_15 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_22 + var_92_15
					end
				end

				arg_89_1.text_.text = var_92_19
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105021", "story_v_side_new_1101105.awb") ~= 0 then
					local var_92_23 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105021", "story_v_side_new_1101105.awb") / 1000

					if var_92_23 + var_92_15 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_23 + var_92_15
					end

					if var_92_18.prefab_name ~= "" and arg_89_1.actors_[var_92_18.prefab_name] ~= nil then
						local var_92_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_18.prefab_name].transform, "story_v_side_new_1101105", "1101105021", "story_v_side_new_1101105.awb")

						arg_89_1:RecordAudio("1101105021", var_92_24)
						arg_89_1:RecordAudio("1101105021", var_92_24)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105021", "story_v_side_new_1101105.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105021", "story_v_side_new_1101105.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_25 = math.max(var_92_16, arg_89_1.talkMaxDuration)

			if var_92_15 <= arg_89_1.time_ and arg_89_1.time_ < var_92_15 + var_92_25 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_15) / var_92_25

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_15 + var_92_25 and arg_89_1.time_ < var_92_15 + var_92_25 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_89_1:InitPlayNodeList()
	end,
	Play1101105022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 1101105022
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play1101105023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = arg_93_1.actors_["1011ui_story"]
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.characterEffect1011ui_story == nil then
				arg_93_1.var_.characterEffect1011ui_story = var_96_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_2 = 0.200000002980232

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_2 and not isNil(var_96_0) then
				local var_96_3 = (arg_93_1.time_ - var_96_1) / var_96_2

				if arg_93_1.var_.characterEffect1011ui_story and not isNil(var_96_0) then
					local var_96_4 = Mathf.Lerp(0, 0.5, var_96_3)

					arg_93_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_93_1.var_.characterEffect1011ui_story.fillRatio = var_96_4
				end
			end

			if arg_93_1.time_ >= var_96_1 + var_96_2 and arg_93_1.time_ < var_96_1 + var_96_2 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.characterEffect1011ui_story then
				local var_96_5 = 0.5

				arg_93_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_93_1.var_.characterEffect1011ui_story.fillRatio = var_96_5
			end

			local var_96_6 = 0
			local var_96_7 = 0.6

			if var_96_6 < arg_93_1.time_ and arg_93_1.time_ <= var_96_6 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, false)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_8 = arg_93_1:GetWordFromCfg(1101105022)
				local var_96_9 = arg_93_1:FormatText(var_96_8.content)

				arg_93_1.text_.text = var_96_9

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_10 = 24
				local var_96_11 = utf8.len(var_96_9)
				local var_96_12 = var_96_10 <= 0 and var_96_7 or var_96_7 * (var_96_11 / var_96_10)

				if var_96_12 > 0 and var_96_7 < var_96_12 then
					arg_93_1.talkMaxDuration = var_96_12

					if var_96_12 + var_96_6 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_12 + var_96_6
					end
				end

				arg_93_1.text_.text = var_96_9
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_13 = math.max(var_96_7, arg_93_1.talkMaxDuration)

			if var_96_6 <= arg_93_1.time_ and arg_93_1.time_ < var_96_6 + var_96_13 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_6) / var_96_13

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_6 + var_96_13 and arg_93_1.time_ < var_96_6 + var_96_13 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play1101105023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 1101105023
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play1101105024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0
			local var_100_1 = 0.825

			if var_100_0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_2 = arg_97_1:FormatText(StoryNameCfg[7].name)

				arg_97_1.leftNameTxt_.text = var_100_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, true)
				arg_97_1.iconController_:SetSelectedState("hero")

				arg_97_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_97_1.callingController_:SetSelectedState("normal")

				arg_97_1.keyicon_.color = Color.New(1, 1, 1)
				arg_97_1.icon_.color = Color.New(1, 1, 1)

				local var_100_3 = arg_97_1:GetWordFromCfg(1101105023)
				local var_100_4 = arg_97_1:FormatText(var_100_3.content)

				arg_97_1.text_.text = var_100_4

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_5 = 33
				local var_100_6 = utf8.len(var_100_4)
				local var_100_7 = var_100_5 <= 0 and var_100_1 or var_100_1 * (var_100_6 / var_100_5)

				if var_100_7 > 0 and var_100_1 < var_100_7 then
					arg_97_1.talkMaxDuration = var_100_7

					if var_100_7 + var_100_0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_7 + var_100_0
					end
				end

				arg_97_1.text_.text = var_100_4
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_8 = math.max(var_100_1, arg_97_1.talkMaxDuration)

			if var_100_0 <= arg_97_1.time_ and arg_97_1.time_ < var_100_0 + var_100_8 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_0) / var_100_8

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_0 + var_100_8 and arg_97_1.time_ < var_100_0 + var_100_8 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play1101105024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 1101105024
		arg_101_1.duration_ = 9.03

		local var_101_0 = {
			zh = 8.433,
			ja = 9.033
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
				arg_101_0:Play1101105025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0
			local var_104_1 = 0.975

			if var_104_0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_2 = arg_101_1:FormatText(StoryNameCfg[10].name)

				arg_101_1.leftNameTxt_.text = var_104_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, true)
				arg_101_1.iconController_:SetSelectedState("hero")

				arg_101_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_101_1.callingController_:SetSelectedState("normal")

				arg_101_1.keyicon_.color = Color.New(1, 1, 1)
				arg_101_1.icon_.color = Color.New(1, 1, 1)

				local var_104_3 = arg_101_1:GetWordFromCfg(1101105024)
				local var_104_4 = arg_101_1:FormatText(var_104_3.content)

				arg_101_1.text_.text = var_104_4

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_5 = 39
				local var_104_6 = utf8.len(var_104_4)
				local var_104_7 = var_104_5 <= 0 and var_104_1 or var_104_1 * (var_104_6 / var_104_5)

				if var_104_7 > 0 and var_104_1 < var_104_7 then
					arg_101_1.talkMaxDuration = var_104_7

					if var_104_7 + var_104_0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_7 + var_104_0
					end
				end

				arg_101_1.text_.text = var_104_4
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105024", "story_v_side_new_1101105.awb") ~= 0 then
					local var_104_8 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105024", "story_v_side_new_1101105.awb") / 1000

					if var_104_8 + var_104_0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_8 + var_104_0
					end

					if var_104_3.prefab_name ~= "" and arg_101_1.actors_[var_104_3.prefab_name] ~= nil then
						local var_104_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_3.prefab_name].transform, "story_v_side_new_1101105", "1101105024", "story_v_side_new_1101105.awb")

						arg_101_1:RecordAudio("1101105024", var_104_9)
						arg_101_1:RecordAudio("1101105024", var_104_9)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105024", "story_v_side_new_1101105.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105024", "story_v_side_new_1101105.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_10 = math.max(var_104_1, arg_101_1.talkMaxDuration)

			if var_104_0 <= arg_101_1.time_ and arg_101_1.time_ < var_104_0 + var_104_10 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_0) / var_104_10

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_0 + var_104_10 and arg_101_1.time_ < var_104_0 + var_104_10 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play1101105025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 1101105025
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play1101105026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 0
			local var_108_1 = 0.275

			if var_108_0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_2 = arg_105_1:FormatText(StoryNameCfg[7].name)

				arg_105_1.leftNameTxt_.text = var_108_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, true)
				arg_105_1.iconController_:SetSelectedState("hero")

				arg_105_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_105_1.callingController_:SetSelectedState("normal")

				arg_105_1.keyicon_.color = Color.New(1, 1, 1)
				arg_105_1.icon_.color = Color.New(1, 1, 1)

				local var_108_3 = arg_105_1:GetWordFromCfg(1101105025)
				local var_108_4 = arg_105_1:FormatText(var_108_3.content)

				arg_105_1.text_.text = var_108_4

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_5 = 11
				local var_108_6 = utf8.len(var_108_4)
				local var_108_7 = var_108_5 <= 0 and var_108_1 or var_108_1 * (var_108_6 / var_108_5)

				if var_108_7 > 0 and var_108_1 < var_108_7 then
					arg_105_1.talkMaxDuration = var_108_7

					if var_108_7 + var_108_0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_7 + var_108_0
					end
				end

				arg_105_1.text_.text = var_108_4
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_8 = math.max(var_108_1, arg_105_1.talkMaxDuration)

			if var_108_0 <= arg_105_1.time_ and arg_105_1.time_ < var_108_0 + var_108_8 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_0) / var_108_8

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_0 + var_108_8 and arg_105_1.time_ < var_108_0 + var_108_8 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play1101105026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 1101105026
		arg_109_1.duration_ = 8

		local var_109_0 = {
			zh = 5.4,
			ja = 8
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
				arg_109_0:Play1101105027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = arg_109_1.actors_["1011ui_story"].transform
			local var_112_1 = 0

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 then
				arg_109_1.var_.moveOldPos1011ui_story = var_112_0.localPosition
			end

			local var_112_2 = 0.001

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_2 then
				local var_112_3 = (arg_109_1.time_ - var_112_1) / var_112_2
				local var_112_4 = Vector3.New(0, -0.71, -6)

				var_112_0.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1011ui_story, var_112_4, var_112_3)

				local var_112_5 = manager.ui.mainCamera.transform.position - var_112_0.position

				var_112_0.forward = Vector3.New(var_112_5.x, var_112_5.y, var_112_5.z)

				local var_112_6 = var_112_0.localEulerAngles

				var_112_6.z = 0
				var_112_6.x = 0
				var_112_0.localEulerAngles = var_112_6
			end

			if arg_109_1.time_ >= var_112_1 + var_112_2 and arg_109_1.time_ < var_112_1 + var_112_2 + arg_112_0 then
				var_112_0.localPosition = Vector3.New(0, -0.71, -6)

				local var_112_7 = manager.ui.mainCamera.transform.position - var_112_0.position

				var_112_0.forward = Vector3.New(var_112_7.x, var_112_7.y, var_112_7.z)

				local var_112_8 = var_112_0.localEulerAngles

				var_112_8.z = 0
				var_112_8.x = 0
				var_112_0.localEulerAngles = var_112_8
			end

			local var_112_9 = arg_109_1.actors_["1011ui_story"]
			local var_112_10 = 0

			if var_112_10 < arg_109_1.time_ and arg_109_1.time_ <= var_112_10 + arg_112_0 and not isNil(var_112_9) and arg_109_1.var_.characterEffect1011ui_story == nil then
				arg_109_1.var_.characterEffect1011ui_story = var_112_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_11 = 0.200000002980232

			if var_112_10 <= arg_109_1.time_ and arg_109_1.time_ < var_112_10 + var_112_11 and not isNil(var_112_9) then
				local var_112_12 = (arg_109_1.time_ - var_112_10) / var_112_11

				if arg_109_1.var_.characterEffect1011ui_story and not isNil(var_112_9) then
					arg_109_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= var_112_10 + var_112_11 and arg_109_1.time_ < var_112_10 + var_112_11 + arg_112_0 and not isNil(var_112_9) and arg_109_1.var_.characterEffect1011ui_story then
				arg_109_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_112_13 = 0

			if var_112_13 < arg_109_1.time_ and arg_109_1.time_ <= var_112_13 + arg_112_0 then
				arg_109_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_112_14 = 0

			if var_112_14 < arg_109_1.time_ and arg_109_1.time_ <= var_112_14 + arg_112_0 then
				arg_109_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011actionlink/1011action424")
			end

			local var_112_15 = 0
			local var_112_16 = 0.925

			if var_112_15 < arg_109_1.time_ and arg_109_1.time_ <= var_112_15 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_17 = arg_109_1:FormatText(StoryNameCfg[37].name)

				arg_109_1.leftNameTxt_.text = var_112_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_18 = arg_109_1:GetWordFromCfg(1101105026)
				local var_112_19 = arg_109_1:FormatText(var_112_18.content)

				arg_109_1.text_.text = var_112_19

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_20 = 37
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

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105026", "story_v_side_new_1101105.awb") ~= 0 then
					local var_112_23 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105026", "story_v_side_new_1101105.awb") / 1000

					if var_112_23 + var_112_15 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_23 + var_112_15
					end

					if var_112_18.prefab_name ~= "" and arg_109_1.actors_[var_112_18.prefab_name] ~= nil then
						local var_112_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_18.prefab_name].transform, "story_v_side_new_1101105", "1101105026", "story_v_side_new_1101105.awb")

						arg_109_1:RecordAudio("1101105026", var_112_24)
						arg_109_1:RecordAudio("1101105026", var_112_24)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105026", "story_v_side_new_1101105.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105026", "story_v_side_new_1101105.awb")
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
				actorName = "1011ui_story",
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
	Play1101105027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 1101105027
		arg_113_1.duration_ = 5

		local var_113_0 = {
			zh = 4,
			ja = 5
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
				arg_113_0:Play1101105028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = arg_113_1.actors_["1011ui_story"].transform
			local var_116_1 = 0

			if var_116_1 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 then
				arg_113_1.var_.moveOldPos1011ui_story = var_116_0.localPosition
			end

			local var_116_2 = 0.001

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_2 then
				local var_116_3 = (arg_113_1.time_ - var_116_1) / var_116_2
				local var_116_4 = Vector3.New(0, -0.71, -6)

				var_116_0.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos1011ui_story, var_116_4, var_116_3)

				local var_116_5 = manager.ui.mainCamera.transform.position - var_116_0.position

				var_116_0.forward = Vector3.New(var_116_5.x, var_116_5.y, var_116_5.z)

				local var_116_6 = var_116_0.localEulerAngles

				var_116_6.z = 0
				var_116_6.x = 0
				var_116_0.localEulerAngles = var_116_6
			end

			if arg_113_1.time_ >= var_116_1 + var_116_2 and arg_113_1.time_ < var_116_1 + var_116_2 + arg_116_0 then
				var_116_0.localPosition = Vector3.New(0, -0.71, -6)

				local var_116_7 = manager.ui.mainCamera.transform.position - var_116_0.position

				var_116_0.forward = Vector3.New(var_116_7.x, var_116_7.y, var_116_7.z)

				local var_116_8 = var_116_0.localEulerAngles

				var_116_8.z = 0
				var_116_8.x = 0
				var_116_0.localEulerAngles = var_116_8
			end

			local var_116_9 = arg_113_1.actors_["1011ui_story"]
			local var_116_10 = 0

			if var_116_10 < arg_113_1.time_ and arg_113_1.time_ <= var_116_10 + arg_116_0 and not isNil(var_116_9) and arg_113_1.var_.characterEffect1011ui_story == nil then
				arg_113_1.var_.characterEffect1011ui_story = var_116_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_11 = 0.200000002980232

			if var_116_10 <= arg_113_1.time_ and arg_113_1.time_ < var_116_10 + var_116_11 and not isNil(var_116_9) then
				local var_116_12 = (arg_113_1.time_ - var_116_10) / var_116_11

				if arg_113_1.var_.characterEffect1011ui_story and not isNil(var_116_9) then
					arg_113_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= var_116_10 + var_116_11 and arg_113_1.time_ < var_116_10 + var_116_11 + arg_116_0 and not isNil(var_116_9) and arg_113_1.var_.characterEffect1011ui_story then
				arg_113_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_116_13 = 0

			if var_116_13 < arg_113_1.time_ and arg_113_1.time_ <= var_116_13 + arg_116_0 then
				arg_113_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action4_2")
			end

			local var_116_14 = 0

			if var_116_14 < arg_113_1.time_ and arg_113_1.time_ <= var_116_14 + arg_116_0 then
				arg_113_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_116_15 = 0
			local var_116_16 = 0.475

			if var_116_15 < arg_113_1.time_ and arg_113_1.time_ <= var_116_15 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_17 = arg_113_1:FormatText(StoryNameCfg[37].name)

				arg_113_1.leftNameTxt_.text = var_116_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_18 = arg_113_1:GetWordFromCfg(1101105027)
				local var_116_19 = arg_113_1:FormatText(var_116_18.content)

				arg_113_1.text_.text = var_116_19

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_20 = 19
				local var_116_21 = utf8.len(var_116_19)
				local var_116_22 = var_116_20 <= 0 and var_116_16 or var_116_16 * (var_116_21 / var_116_20)

				if var_116_22 > 0 and var_116_16 < var_116_22 then
					arg_113_1.talkMaxDuration = var_116_22

					if var_116_22 + var_116_15 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_22 + var_116_15
					end
				end

				arg_113_1.text_.text = var_116_19
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105027", "story_v_side_new_1101105.awb") ~= 0 then
					local var_116_23 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105027", "story_v_side_new_1101105.awb") / 1000

					if var_116_23 + var_116_15 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_23 + var_116_15
					end

					if var_116_18.prefab_name ~= "" and arg_113_1.actors_[var_116_18.prefab_name] ~= nil then
						local var_116_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_18.prefab_name].transform, "story_v_side_new_1101105", "1101105027", "story_v_side_new_1101105.awb")

						arg_113_1:RecordAudio("1101105027", var_116_24)
						arg_113_1:RecordAudio("1101105027", var_116_24)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105027", "story_v_side_new_1101105.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105027", "story_v_side_new_1101105.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_25 = math.max(var_116_16, arg_113_1.talkMaxDuration)

			if var_116_15 <= arg_113_1.time_ and arg_113_1.time_ < var_116_15 + var_116_25 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_15) / var_116_25

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_15 + var_116_25 and arg_113_1.time_ < var_116_15 + var_116_25 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
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
	Play1101105028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 1101105028
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play1101105029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = arg_117_1.actors_["1011ui_story"]
			local var_120_1 = 0

			if var_120_1 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 and not isNil(var_120_0) and arg_117_1.var_.characterEffect1011ui_story == nil then
				arg_117_1.var_.characterEffect1011ui_story = var_120_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_2 = 0.200000002980232

			if var_120_1 <= arg_117_1.time_ and arg_117_1.time_ < var_120_1 + var_120_2 and not isNil(var_120_0) then
				local var_120_3 = (arg_117_1.time_ - var_120_1) / var_120_2

				if arg_117_1.var_.characterEffect1011ui_story and not isNil(var_120_0) then
					local var_120_4 = Mathf.Lerp(0, 0.5, var_120_3)

					arg_117_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_117_1.var_.characterEffect1011ui_story.fillRatio = var_120_4
				end
			end

			if arg_117_1.time_ >= var_120_1 + var_120_2 and arg_117_1.time_ < var_120_1 + var_120_2 + arg_120_0 and not isNil(var_120_0) and arg_117_1.var_.characterEffect1011ui_story then
				local var_120_5 = 0.5

				arg_117_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_117_1.var_.characterEffect1011ui_story.fillRatio = var_120_5
			end

			local var_120_6 = 0
			local var_120_7 = 0.875

			if var_120_6 < arg_117_1.time_ and arg_117_1.time_ <= var_120_6 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, false)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_8 = arg_117_1:GetWordFromCfg(1101105028)
				local var_120_9 = arg_117_1:FormatText(var_120_8.content)

				arg_117_1.text_.text = var_120_9

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_10 = 35
				local var_120_11 = utf8.len(var_120_9)
				local var_120_12 = var_120_10 <= 0 and var_120_7 or var_120_7 * (var_120_11 / var_120_10)

				if var_120_12 > 0 and var_120_7 < var_120_12 then
					arg_117_1.talkMaxDuration = var_120_12

					if var_120_12 + var_120_6 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_12 + var_120_6
					end
				end

				arg_117_1.text_.text = var_120_9
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_13 = math.max(var_120_7, arg_117_1.talkMaxDuration)

			if var_120_6 <= arg_117_1.time_ and arg_117_1.time_ < var_120_6 + var_120_13 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_6) / var_120_13

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_6 + var_120_13 and arg_117_1.time_ < var_120_6 + var_120_13 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play1101105029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 1101105029
		arg_121_1.duration_ = 5.77

		local var_121_0 = {
			zh = 5.6,
			ja = 5.766
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
				arg_121_0:Play1101105030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = 0
			local var_124_1 = 0.525

			if var_124_0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_0 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_2 = arg_121_1:FormatText(StoryNameCfg[10].name)

				arg_121_1.leftNameTxt_.text = var_124_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, true)
				arg_121_1.iconController_:SetSelectedState("hero")

				arg_121_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_121_1.callingController_:SetSelectedState("normal")

				arg_121_1.keyicon_.color = Color.New(1, 1, 1)
				arg_121_1.icon_.color = Color.New(1, 1, 1)

				local var_124_3 = arg_121_1:GetWordFromCfg(1101105029)
				local var_124_4 = arg_121_1:FormatText(var_124_3.content)

				arg_121_1.text_.text = var_124_4

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_5 = 21
				local var_124_6 = utf8.len(var_124_4)
				local var_124_7 = var_124_5 <= 0 and var_124_1 or var_124_1 * (var_124_6 / var_124_5)

				if var_124_7 > 0 and var_124_1 < var_124_7 then
					arg_121_1.talkMaxDuration = var_124_7

					if var_124_7 + var_124_0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_7 + var_124_0
					end
				end

				arg_121_1.text_.text = var_124_4
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105029", "story_v_side_new_1101105.awb") ~= 0 then
					local var_124_8 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105029", "story_v_side_new_1101105.awb") / 1000

					if var_124_8 + var_124_0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_8 + var_124_0
					end

					if var_124_3.prefab_name ~= "" and arg_121_1.actors_[var_124_3.prefab_name] ~= nil then
						local var_124_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_3.prefab_name].transform, "story_v_side_new_1101105", "1101105029", "story_v_side_new_1101105.awb")

						arg_121_1:RecordAudio("1101105029", var_124_9)
						arg_121_1:RecordAudio("1101105029", var_124_9)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105029", "story_v_side_new_1101105.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105029", "story_v_side_new_1101105.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_10 = math.max(var_124_1, arg_121_1.talkMaxDuration)

			if var_124_0 <= arg_121_1.time_ and arg_121_1.time_ < var_124_0 + var_124_10 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_0) / var_124_10

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_0 + var_124_10 and arg_121_1.time_ < var_124_0 + var_124_10 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play1101105030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 1101105030
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play1101105031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = 0
			local var_128_1 = 0.375

			if var_128_0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_0 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				local var_128_2 = arg_125_1:FormatText(StoryNameCfg[7].name)

				arg_125_1.leftNameTxt_.text = var_128_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, true)
				arg_125_1.iconController_:SetSelectedState("hero")

				arg_125_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_125_1.callingController_:SetSelectedState("normal")

				arg_125_1.keyicon_.color = Color.New(1, 1, 1)
				arg_125_1.icon_.color = Color.New(1, 1, 1)

				local var_128_3 = arg_125_1:GetWordFromCfg(1101105030)
				local var_128_4 = arg_125_1:FormatText(var_128_3.content)

				arg_125_1.text_.text = var_128_4

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_5 = 15
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
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_8 = math.max(var_128_1, arg_125_1.talkMaxDuration)

			if var_128_0 <= arg_125_1.time_ and arg_125_1.time_ < var_128_0 + var_128_8 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_0) / var_128_8

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_0 + var_128_8 and arg_125_1.time_ < var_128_0 + var_128_8 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play1101105031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 1101105031
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play1101105032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 0
			local var_132_1 = 1.075

			if var_132_0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_0 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_2 = arg_129_1:FormatText(StoryNameCfg[7].name)

				arg_129_1.leftNameTxt_.text = var_132_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, true)
				arg_129_1.iconController_:SetSelectedState("hero")

				arg_129_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_129_1.callingController_:SetSelectedState("normal")

				arg_129_1.keyicon_.color = Color.New(1, 1, 1)
				arg_129_1.icon_.color = Color.New(1, 1, 1)

				local var_132_3 = arg_129_1:GetWordFromCfg(1101105031)
				local var_132_4 = arg_129_1:FormatText(var_132_3.content)

				arg_129_1.text_.text = var_132_4

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_5 = 43
				local var_132_6 = utf8.len(var_132_4)
				local var_132_7 = var_132_5 <= 0 and var_132_1 or var_132_1 * (var_132_6 / var_132_5)

				if var_132_7 > 0 and var_132_1 < var_132_7 then
					arg_129_1.talkMaxDuration = var_132_7

					if var_132_7 + var_132_0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_7 + var_132_0
					end
				end

				arg_129_1.text_.text = var_132_4
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)
				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_8 = math.max(var_132_1, arg_129_1.talkMaxDuration)

			if var_132_0 <= arg_129_1.time_ and arg_129_1.time_ < var_132_0 + var_132_8 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_0) / var_132_8

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_0 + var_132_8 and arg_129_1.time_ < var_132_0 + var_132_8 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play1101105032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 1101105032
		arg_133_1.duration_ = 3.23

		local var_133_0 = {
			zh = 2.066,
			ja = 3.233
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
				arg_133_0:Play1101105033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = 0
			local var_136_1 = 0.275

			if var_136_0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_0 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_2 = arg_133_1:FormatText(StoryNameCfg[10].name)

				arg_133_1.leftNameTxt_.text = var_136_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, true)
				arg_133_1.iconController_:SetSelectedState("hero")

				arg_133_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_133_1.callingController_:SetSelectedState("normal")

				arg_133_1.keyicon_.color = Color.New(1, 1, 1)
				arg_133_1.icon_.color = Color.New(1, 1, 1)

				local var_136_3 = arg_133_1:GetWordFromCfg(1101105032)
				local var_136_4 = arg_133_1:FormatText(var_136_3.content)

				arg_133_1.text_.text = var_136_4

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_5 = 11
				local var_136_6 = utf8.len(var_136_4)
				local var_136_7 = var_136_5 <= 0 and var_136_1 or var_136_1 * (var_136_6 / var_136_5)

				if var_136_7 > 0 and var_136_1 < var_136_7 then
					arg_133_1.talkMaxDuration = var_136_7

					if var_136_7 + var_136_0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_7 + var_136_0
					end
				end

				arg_133_1.text_.text = var_136_4
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105032", "story_v_side_new_1101105.awb") ~= 0 then
					local var_136_8 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105032", "story_v_side_new_1101105.awb") / 1000

					if var_136_8 + var_136_0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_8 + var_136_0
					end

					if var_136_3.prefab_name ~= "" and arg_133_1.actors_[var_136_3.prefab_name] ~= nil then
						local var_136_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_3.prefab_name].transform, "story_v_side_new_1101105", "1101105032", "story_v_side_new_1101105.awb")

						arg_133_1:RecordAudio("1101105032", var_136_9)
						arg_133_1:RecordAudio("1101105032", var_136_9)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105032", "story_v_side_new_1101105.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105032", "story_v_side_new_1101105.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_10 = math.max(var_136_1, arg_133_1.talkMaxDuration)

			if var_136_0 <= arg_133_1.time_ and arg_133_1.time_ < var_136_0 + var_136_10 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_0) / var_136_10

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_0 + var_136_10 and arg_133_1.time_ < var_136_0 + var_136_10 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play1101105033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 1101105033
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play1101105034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = 0
			local var_140_1 = 0.35

			if var_140_0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_0 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_2 = arg_137_1:FormatText(StoryNameCfg[7].name)

				arg_137_1.leftNameTxt_.text = var_140_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, true)
				arg_137_1.iconController_:SetSelectedState("hero")

				arg_137_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_137_1.callingController_:SetSelectedState("normal")

				arg_137_1.keyicon_.color = Color.New(1, 1, 1)
				arg_137_1.icon_.color = Color.New(1, 1, 1)

				local var_140_3 = arg_137_1:GetWordFromCfg(1101105033)
				local var_140_4 = arg_137_1:FormatText(var_140_3.content)

				arg_137_1.text_.text = var_140_4

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_5 = 14
				local var_140_6 = utf8.len(var_140_4)
				local var_140_7 = var_140_5 <= 0 and var_140_1 or var_140_1 * (var_140_6 / var_140_5)

				if var_140_7 > 0 and var_140_1 < var_140_7 then
					arg_137_1.talkMaxDuration = var_140_7

					if var_140_7 + var_140_0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_7 + var_140_0
					end
				end

				arg_137_1.text_.text = var_140_4
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_8 = math.max(var_140_1, arg_137_1.talkMaxDuration)

			if var_140_0 <= arg_137_1.time_ and arg_137_1.time_ < var_140_0 + var_140_8 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_0) / var_140_8

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_0 + var_140_8 and arg_137_1.time_ < var_140_0 + var_140_8 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play1101105034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 1101105034
		arg_141_1.duration_ = 7.83

		local var_141_0 = {
			zh = 6.866,
			ja = 7.833
		}
		local var_141_1 = manager.audio:GetLocalizationFlag()

		if var_141_0[var_141_1] ~= nil then
			arg_141_1.duration_ = var_141_0[var_141_1]
		end

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play1101105035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = arg_141_1.actors_["1011ui_story"].transform
			local var_144_1 = 0

			if var_144_1 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 then
				arg_141_1.var_.moveOldPos1011ui_story = var_144_0.localPosition
			end

			local var_144_2 = 0.001

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_2 then
				local var_144_3 = (arg_141_1.time_ - var_144_1) / var_144_2
				local var_144_4 = Vector3.New(0, -0.71, -6)

				var_144_0.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos1011ui_story, var_144_4, var_144_3)

				local var_144_5 = manager.ui.mainCamera.transform.position - var_144_0.position

				var_144_0.forward = Vector3.New(var_144_5.x, var_144_5.y, var_144_5.z)

				local var_144_6 = var_144_0.localEulerAngles

				var_144_6.z = 0
				var_144_6.x = 0
				var_144_0.localEulerAngles = var_144_6
			end

			if arg_141_1.time_ >= var_144_1 + var_144_2 and arg_141_1.time_ < var_144_1 + var_144_2 + arg_144_0 then
				var_144_0.localPosition = Vector3.New(0, -0.71, -6)

				local var_144_7 = manager.ui.mainCamera.transform.position - var_144_0.position

				var_144_0.forward = Vector3.New(var_144_7.x, var_144_7.y, var_144_7.z)

				local var_144_8 = var_144_0.localEulerAngles

				var_144_8.z = 0
				var_144_8.x = 0
				var_144_0.localEulerAngles = var_144_8
			end

			local var_144_9 = arg_141_1.actors_["1011ui_story"]
			local var_144_10 = 0

			if var_144_10 < arg_141_1.time_ and arg_141_1.time_ <= var_144_10 + arg_144_0 and not isNil(var_144_9) and arg_141_1.var_.characterEffect1011ui_story == nil then
				arg_141_1.var_.characterEffect1011ui_story = var_144_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_11 = 0.200000002980232

			if var_144_10 <= arg_141_1.time_ and arg_141_1.time_ < var_144_10 + var_144_11 and not isNil(var_144_9) then
				local var_144_12 = (arg_141_1.time_ - var_144_10) / var_144_11

				if arg_141_1.var_.characterEffect1011ui_story and not isNil(var_144_9) then
					arg_141_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= var_144_10 + var_144_11 and arg_141_1.time_ < var_144_10 + var_144_11 + arg_144_0 and not isNil(var_144_9) and arg_141_1.var_.characterEffect1011ui_story then
				arg_141_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_144_13 = 0

			if var_144_13 < arg_141_1.time_ and arg_141_1.time_ <= var_144_13 + arg_144_0 then
				arg_141_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action3_1")
			end

			local var_144_14 = 0

			if var_144_14 < arg_141_1.time_ and arg_141_1.time_ <= var_144_14 + arg_144_0 then
				arg_141_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_144_15 = 0
			local var_144_16 = 0.75

			if var_144_15 < arg_141_1.time_ and arg_141_1.time_ <= var_144_15 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_17 = arg_141_1:FormatText(StoryNameCfg[37].name)

				arg_141_1.leftNameTxt_.text = var_144_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_18 = arg_141_1:GetWordFromCfg(1101105034)
				local var_144_19 = arg_141_1:FormatText(var_144_18.content)

				arg_141_1.text_.text = var_144_19

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_20 = 30
				local var_144_21 = utf8.len(var_144_19)
				local var_144_22 = var_144_20 <= 0 and var_144_16 or var_144_16 * (var_144_21 / var_144_20)

				if var_144_22 > 0 and var_144_16 < var_144_22 then
					arg_141_1.talkMaxDuration = var_144_22

					if var_144_22 + var_144_15 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_22 + var_144_15
					end
				end

				arg_141_1.text_.text = var_144_19
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105034", "story_v_side_new_1101105.awb") ~= 0 then
					local var_144_23 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105034", "story_v_side_new_1101105.awb") / 1000

					if var_144_23 + var_144_15 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_23 + var_144_15
					end

					if var_144_18.prefab_name ~= "" and arg_141_1.actors_[var_144_18.prefab_name] ~= nil then
						local var_144_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_18.prefab_name].transform, "story_v_side_new_1101105", "1101105034", "story_v_side_new_1101105.awb")

						arg_141_1:RecordAudio("1101105034", var_144_24)
						arg_141_1:RecordAudio("1101105034", var_144_24)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105034", "story_v_side_new_1101105.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105034", "story_v_side_new_1101105.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_25 = math.max(var_144_16, arg_141_1.talkMaxDuration)

			if var_144_15 <= arg_141_1.time_ and arg_141_1.time_ < var_144_15 + var_144_25 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_15) / var_144_25

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_15 + var_144_25 and arg_141_1.time_ < var_144_15 + var_144_25 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_141_1:InitPlayNodeList()
	end,
	Play1101105035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 1101105035
		arg_145_1.duration_ = 5

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play1101105036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = arg_145_1.actors_["1011ui_story"]
			local var_148_1 = 0

			if var_148_1 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 and not isNil(var_148_0) and arg_145_1.var_.characterEffect1011ui_story == nil then
				arg_145_1.var_.characterEffect1011ui_story = var_148_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_2 = 0.200000002980232

			if var_148_1 <= arg_145_1.time_ and arg_145_1.time_ < var_148_1 + var_148_2 and not isNil(var_148_0) then
				local var_148_3 = (arg_145_1.time_ - var_148_1) / var_148_2

				if arg_145_1.var_.characterEffect1011ui_story and not isNil(var_148_0) then
					local var_148_4 = Mathf.Lerp(0, 0.5, var_148_3)

					arg_145_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_145_1.var_.characterEffect1011ui_story.fillRatio = var_148_4
				end
			end

			if arg_145_1.time_ >= var_148_1 + var_148_2 and arg_145_1.time_ < var_148_1 + var_148_2 + arg_148_0 and not isNil(var_148_0) and arg_145_1.var_.characterEffect1011ui_story then
				local var_148_5 = 0.5

				arg_145_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_145_1.var_.characterEffect1011ui_story.fillRatio = var_148_5
			end

			local var_148_6 = 0
			local var_148_7 = 0.325

			if var_148_6 < arg_145_1.time_ and arg_145_1.time_ <= var_148_6 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				local var_148_8 = arg_145_1:FormatText(StoryNameCfg[7].name)

				arg_145_1.leftNameTxt_.text = var_148_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, true)
				arg_145_1.iconController_:SetSelectedState("hero")

				arg_145_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_145_1.callingController_:SetSelectedState("normal")

				arg_145_1.keyicon_.color = Color.New(1, 1, 1)
				arg_145_1.icon_.color = Color.New(1, 1, 1)

				local var_148_9 = arg_145_1:GetWordFromCfg(1101105035)
				local var_148_10 = arg_145_1:FormatText(var_148_9.content)

				arg_145_1.text_.text = var_148_10

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_11 = 13
				local var_148_12 = utf8.len(var_148_10)
				local var_148_13 = var_148_11 <= 0 and var_148_7 or var_148_7 * (var_148_12 / var_148_11)

				if var_148_13 > 0 and var_148_7 < var_148_13 then
					arg_145_1.talkMaxDuration = var_148_13

					if var_148_13 + var_148_6 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_13 + var_148_6
					end
				end

				arg_145_1.text_.text = var_148_10
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_14 = math.max(var_148_7, arg_145_1.talkMaxDuration)

			if var_148_6 <= arg_145_1.time_ and arg_145_1.time_ < var_148_6 + var_148_14 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_6) / var_148_14

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_6 + var_148_14 and arg_145_1.time_ < var_148_6 + var_148_14 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play1101105036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 1101105036
		arg_149_1.duration_ = 4.53

		local var_149_0 = {
			zh = 3,
			ja = 4.533
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
				arg_149_0:Play1101105037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = arg_149_1.actors_["1011ui_story"].transform
			local var_152_1 = 0

			if var_152_1 < arg_149_1.time_ and arg_149_1.time_ <= var_152_1 + arg_152_0 then
				arg_149_1.var_.moveOldPos1011ui_story = var_152_0.localPosition
			end

			local var_152_2 = 0.001

			if var_152_1 <= arg_149_1.time_ and arg_149_1.time_ < var_152_1 + var_152_2 then
				local var_152_3 = (arg_149_1.time_ - var_152_1) / var_152_2
				local var_152_4 = Vector3.New(0, -0.71, -6)

				var_152_0.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos1011ui_story, var_152_4, var_152_3)

				local var_152_5 = manager.ui.mainCamera.transform.position - var_152_0.position

				var_152_0.forward = Vector3.New(var_152_5.x, var_152_5.y, var_152_5.z)

				local var_152_6 = var_152_0.localEulerAngles

				var_152_6.z = 0
				var_152_6.x = 0
				var_152_0.localEulerAngles = var_152_6
			end

			if arg_149_1.time_ >= var_152_1 + var_152_2 and arg_149_1.time_ < var_152_1 + var_152_2 + arg_152_0 then
				var_152_0.localPosition = Vector3.New(0, -0.71, -6)

				local var_152_7 = manager.ui.mainCamera.transform.position - var_152_0.position

				var_152_0.forward = Vector3.New(var_152_7.x, var_152_7.y, var_152_7.z)

				local var_152_8 = var_152_0.localEulerAngles

				var_152_8.z = 0
				var_152_8.x = 0
				var_152_0.localEulerAngles = var_152_8
			end

			local var_152_9 = arg_149_1.actors_["1011ui_story"]
			local var_152_10 = 0

			if var_152_10 < arg_149_1.time_ and arg_149_1.time_ <= var_152_10 + arg_152_0 and not isNil(var_152_9) and arg_149_1.var_.characterEffect1011ui_story == nil then
				arg_149_1.var_.characterEffect1011ui_story = var_152_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_11 = 0.200000002980232

			if var_152_10 <= arg_149_1.time_ and arg_149_1.time_ < var_152_10 + var_152_11 and not isNil(var_152_9) then
				local var_152_12 = (arg_149_1.time_ - var_152_10) / var_152_11

				if arg_149_1.var_.characterEffect1011ui_story and not isNil(var_152_9) then
					arg_149_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_149_1.time_ >= var_152_10 + var_152_11 and arg_149_1.time_ < var_152_10 + var_152_11 + arg_152_0 and not isNil(var_152_9) and arg_149_1.var_.characterEffect1011ui_story then
				arg_149_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_152_13 = 0

			if var_152_13 < arg_149_1.time_ and arg_149_1.time_ <= var_152_13 + arg_152_0 then
				arg_149_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_152_14 = 0
			local var_152_15 = 0.225

			if var_152_14 < arg_149_1.time_ and arg_149_1.time_ <= var_152_14 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				local var_152_16 = arg_149_1:FormatText(StoryNameCfg[37].name)

				arg_149_1.leftNameTxt_.text = var_152_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_17 = arg_149_1:GetWordFromCfg(1101105036)
				local var_152_18 = arg_149_1:FormatText(var_152_17.content)

				arg_149_1.text_.text = var_152_18

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_19 = 9
				local var_152_20 = utf8.len(var_152_18)
				local var_152_21 = var_152_19 <= 0 and var_152_15 or var_152_15 * (var_152_20 / var_152_19)

				if var_152_21 > 0 and var_152_15 < var_152_21 then
					arg_149_1.talkMaxDuration = var_152_21

					if var_152_21 + var_152_14 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_21 + var_152_14
					end
				end

				arg_149_1.text_.text = var_152_18
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105036", "story_v_side_new_1101105.awb") ~= 0 then
					local var_152_22 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105036", "story_v_side_new_1101105.awb") / 1000

					if var_152_22 + var_152_14 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_22 + var_152_14
					end

					if var_152_17.prefab_name ~= "" and arg_149_1.actors_[var_152_17.prefab_name] ~= nil then
						local var_152_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_17.prefab_name].transform, "story_v_side_new_1101105", "1101105036", "story_v_side_new_1101105.awb")

						arg_149_1:RecordAudio("1101105036", var_152_23)
						arg_149_1:RecordAudio("1101105036", var_152_23)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105036", "story_v_side_new_1101105.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105036", "story_v_side_new_1101105.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_24 = math.max(var_152_15, arg_149_1.talkMaxDuration)

			if var_152_14 <= arg_149_1.time_ and arg_149_1.time_ < var_152_14 + var_152_24 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_14) / var_152_24

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_14 + var_152_24 and arg_149_1.time_ < var_152_14 + var_152_24 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
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
	Play1101105037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 1101105037
		arg_153_1.duration_ = 7.7

		local var_153_0 = {
			zh = 4.3,
			ja = 7.7
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
				arg_153_0:Play1101105038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = arg_153_1.actors_["1011ui_story"]
			local var_156_1 = 0

			if var_156_1 < arg_153_1.time_ and arg_153_1.time_ <= var_156_1 + arg_156_0 and not isNil(var_156_0) and arg_153_1.var_.characterEffect1011ui_story == nil then
				arg_153_1.var_.characterEffect1011ui_story = var_156_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_2 = 0.200000002980232

			if var_156_1 <= arg_153_1.time_ and arg_153_1.time_ < var_156_1 + var_156_2 and not isNil(var_156_0) then
				local var_156_3 = (arg_153_1.time_ - var_156_1) / var_156_2

				if arg_153_1.var_.characterEffect1011ui_story and not isNil(var_156_0) then
					local var_156_4 = Mathf.Lerp(0, 0.5, var_156_3)

					arg_153_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_153_1.var_.characterEffect1011ui_story.fillRatio = var_156_4
				end
			end

			if arg_153_1.time_ >= var_156_1 + var_156_2 and arg_153_1.time_ < var_156_1 + var_156_2 + arg_156_0 and not isNil(var_156_0) and arg_153_1.var_.characterEffect1011ui_story then
				local var_156_5 = 0.5

				arg_153_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_153_1.var_.characterEffect1011ui_story.fillRatio = var_156_5
			end

			local var_156_6 = 0
			local var_156_7 = 0.475

			if var_156_6 < arg_153_1.time_ and arg_153_1.time_ <= var_156_6 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_8 = arg_153_1:FormatText(StoryNameCfg[10].name)

				arg_153_1.leftNameTxt_.text = var_156_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, true)
				arg_153_1.iconController_:SetSelectedState("hero")

				arg_153_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_153_1.callingController_:SetSelectedState("normal")

				arg_153_1.keyicon_.color = Color.New(1, 1, 1)
				arg_153_1.icon_.color = Color.New(1, 1, 1)

				local var_156_9 = arg_153_1:GetWordFromCfg(1101105037)
				local var_156_10 = arg_153_1:FormatText(var_156_9.content)

				arg_153_1.text_.text = var_156_10

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_11 = 19
				local var_156_12 = utf8.len(var_156_10)
				local var_156_13 = var_156_11 <= 0 and var_156_7 or var_156_7 * (var_156_12 / var_156_11)

				if var_156_13 > 0 and var_156_7 < var_156_13 then
					arg_153_1.talkMaxDuration = var_156_13

					if var_156_13 + var_156_6 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_13 + var_156_6
					end
				end

				arg_153_1.text_.text = var_156_10
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105037", "story_v_side_new_1101105.awb") ~= 0 then
					local var_156_14 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105037", "story_v_side_new_1101105.awb") / 1000

					if var_156_14 + var_156_6 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_14 + var_156_6
					end

					if var_156_9.prefab_name ~= "" and arg_153_1.actors_[var_156_9.prefab_name] ~= nil then
						local var_156_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_9.prefab_name].transform, "story_v_side_new_1101105", "1101105037", "story_v_side_new_1101105.awb")

						arg_153_1:RecordAudio("1101105037", var_156_15)
						arg_153_1:RecordAudio("1101105037", var_156_15)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105037", "story_v_side_new_1101105.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105037", "story_v_side_new_1101105.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_16 = math.max(var_156_7, arg_153_1.talkMaxDuration)

			if var_156_6 <= arg_153_1.time_ and arg_153_1.time_ < var_156_6 + var_156_16 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_6) / var_156_16

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_6 + var_156_16 and arg_153_1.time_ < var_156_6 + var_156_16 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play1101105038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 1101105038
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play1101105039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = 0

			if var_160_0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_0 + arg_160_0 then
				arg_157_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_160_1 = 0
			local var_160_2 = 0.85

			if var_160_1 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				local var_160_3 = arg_157_1:FormatText(StoryNameCfg[7].name)

				arg_157_1.leftNameTxt_.text = var_160_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, true)
				arg_157_1.iconController_:SetSelectedState("hero")

				arg_157_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_157_1.callingController_:SetSelectedState("normal")

				arg_157_1.keyicon_.color = Color.New(1, 1, 1)
				arg_157_1.icon_.color = Color.New(1, 1, 1)

				local var_160_4 = arg_157_1:GetWordFromCfg(1101105038)
				local var_160_5 = arg_157_1:FormatText(var_160_4.content)

				arg_157_1.text_.text = var_160_5

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_6 = 34
				local var_160_7 = utf8.len(var_160_5)
				local var_160_8 = var_160_6 <= 0 and var_160_2 or var_160_2 * (var_160_7 / var_160_6)

				if var_160_8 > 0 and var_160_2 < var_160_8 then
					arg_157_1.talkMaxDuration = var_160_8

					if var_160_8 + var_160_1 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_8 + var_160_1
					end
				end

				arg_157_1.text_.text = var_160_5
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_9 = math.max(var_160_2, arg_157_1.talkMaxDuration)

			if var_160_1 <= arg_157_1.time_ and arg_157_1.time_ < var_160_1 + var_160_9 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_1) / var_160_9

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_1 + var_160_9 and arg_157_1.time_ < var_160_1 + var_160_9 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play1101105039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 1101105039
		arg_161_1.duration_ = 3.23

		local var_161_0 = {
			zh = 2.166,
			ja = 3.233
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
				arg_161_0:Play1101105040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 0
			local var_164_1 = 0.225

			if var_164_0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				local var_164_2 = arg_161_1:FormatText(StoryNameCfg[10].name)

				arg_161_1.leftNameTxt_.text = var_164_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, true)
				arg_161_1.iconController_:SetSelectedState("hero")

				arg_161_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_161_1.callingController_:SetSelectedState("normal")

				arg_161_1.keyicon_.color = Color.New(1, 1, 1)
				arg_161_1.icon_.color = Color.New(1, 1, 1)

				local var_164_3 = arg_161_1:GetWordFromCfg(1101105039)
				local var_164_4 = arg_161_1:FormatText(var_164_3.content)

				arg_161_1.text_.text = var_164_4

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_5 = 9
				local var_164_6 = utf8.len(var_164_4)
				local var_164_7 = var_164_5 <= 0 and var_164_1 or var_164_1 * (var_164_6 / var_164_5)

				if var_164_7 > 0 and var_164_1 < var_164_7 then
					arg_161_1.talkMaxDuration = var_164_7

					if var_164_7 + var_164_0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_7 + var_164_0
					end
				end

				arg_161_1.text_.text = var_164_4
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105039", "story_v_side_new_1101105.awb") ~= 0 then
					local var_164_8 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105039", "story_v_side_new_1101105.awb") / 1000

					if var_164_8 + var_164_0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_8 + var_164_0
					end

					if var_164_3.prefab_name ~= "" and arg_161_1.actors_[var_164_3.prefab_name] ~= nil then
						local var_164_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_3.prefab_name].transform, "story_v_side_new_1101105", "1101105039", "story_v_side_new_1101105.awb")

						arg_161_1:RecordAudio("1101105039", var_164_9)
						arg_161_1:RecordAudio("1101105039", var_164_9)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105039", "story_v_side_new_1101105.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105039", "story_v_side_new_1101105.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_10 = math.max(var_164_1, arg_161_1.talkMaxDuration)

			if var_164_0 <= arg_161_1.time_ and arg_161_1.time_ < var_164_0 + var_164_10 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_0) / var_164_10

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_0 + var_164_10 and arg_161_1.time_ < var_164_0 + var_164_10 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play1101105040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 1101105040
		arg_165_1.duration_ = 3.63

		local var_165_0 = {
			zh = 1.999999999999,
			ja = 3.633
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
				arg_165_0:Play1101105041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = arg_165_1.actors_["1011ui_story"].transform
			local var_168_1 = 0

			if var_168_1 < arg_165_1.time_ and arg_165_1.time_ <= var_168_1 + arg_168_0 then
				arg_165_1.var_.moveOldPos1011ui_story = var_168_0.localPosition
			end

			local var_168_2 = 0.001

			if var_168_1 <= arg_165_1.time_ and arg_165_1.time_ < var_168_1 + var_168_2 then
				local var_168_3 = (arg_165_1.time_ - var_168_1) / var_168_2
				local var_168_4 = Vector3.New(0, -0.71, -6)

				var_168_0.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos1011ui_story, var_168_4, var_168_3)

				local var_168_5 = manager.ui.mainCamera.transform.position - var_168_0.position

				var_168_0.forward = Vector3.New(var_168_5.x, var_168_5.y, var_168_5.z)

				local var_168_6 = var_168_0.localEulerAngles

				var_168_6.z = 0
				var_168_6.x = 0
				var_168_0.localEulerAngles = var_168_6
			end

			if arg_165_1.time_ >= var_168_1 + var_168_2 and arg_165_1.time_ < var_168_1 + var_168_2 + arg_168_0 then
				var_168_0.localPosition = Vector3.New(0, -0.71, -6)

				local var_168_7 = manager.ui.mainCamera.transform.position - var_168_0.position

				var_168_0.forward = Vector3.New(var_168_7.x, var_168_7.y, var_168_7.z)

				local var_168_8 = var_168_0.localEulerAngles

				var_168_8.z = 0
				var_168_8.x = 0
				var_168_0.localEulerAngles = var_168_8
			end

			local var_168_9 = arg_165_1.actors_["1011ui_story"]
			local var_168_10 = 0

			if var_168_10 < arg_165_1.time_ and arg_165_1.time_ <= var_168_10 + arg_168_0 and not isNil(var_168_9) and arg_165_1.var_.characterEffect1011ui_story == nil then
				arg_165_1.var_.characterEffect1011ui_story = var_168_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_11 = 0.200000002980232

			if var_168_10 <= arg_165_1.time_ and arg_165_1.time_ < var_168_10 + var_168_11 and not isNil(var_168_9) then
				local var_168_12 = (arg_165_1.time_ - var_168_10) / var_168_11

				if arg_165_1.var_.characterEffect1011ui_story and not isNil(var_168_9) then
					arg_165_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_165_1.time_ >= var_168_10 + var_168_11 and arg_165_1.time_ < var_168_10 + var_168_11 + arg_168_0 and not isNil(var_168_9) and arg_165_1.var_.characterEffect1011ui_story then
				arg_165_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_168_13 = 0

			if var_168_13 < arg_165_1.time_ and arg_165_1.time_ <= var_168_13 + arg_168_0 then
				arg_165_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action3_2")
			end

			local var_168_14 = 0

			if var_168_14 < arg_165_1.time_ and arg_165_1.time_ <= var_168_14 + arg_168_0 then
				arg_165_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_168_15 = 0
			local var_168_16 = 0.075

			if var_168_15 < arg_165_1.time_ and arg_165_1.time_ <= var_168_15 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				local var_168_17 = arg_165_1:FormatText(StoryNameCfg[37].name)

				arg_165_1.leftNameTxt_.text = var_168_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_18 = arg_165_1:GetWordFromCfg(1101105040)
				local var_168_19 = arg_165_1:FormatText(var_168_18.content)

				arg_165_1.text_.text = var_168_19

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_20 = 3
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

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105040", "story_v_side_new_1101105.awb") ~= 0 then
					local var_168_23 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105040", "story_v_side_new_1101105.awb") / 1000

					if var_168_23 + var_168_15 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_23 + var_168_15
					end

					if var_168_18.prefab_name ~= "" and arg_165_1.actors_[var_168_18.prefab_name] ~= nil then
						local var_168_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_18.prefab_name].transform, "story_v_side_new_1101105", "1101105040", "story_v_side_new_1101105.awb")

						arg_165_1:RecordAudio("1101105040", var_168_24)
						arg_165_1:RecordAudio("1101105040", var_168_24)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105040", "story_v_side_new_1101105.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105040", "story_v_side_new_1101105.awb")
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
				actorName = "1011ui_story",
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
	Play1101105041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 1101105041
		arg_169_1.duration_ = 5

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play1101105042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = arg_169_1.actors_["1011ui_story"]
			local var_172_1 = 0

			if var_172_1 < arg_169_1.time_ and arg_169_1.time_ <= var_172_1 + arg_172_0 and not isNil(var_172_0) and arg_169_1.var_.characterEffect1011ui_story == nil then
				arg_169_1.var_.characterEffect1011ui_story = var_172_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_2 = 0.200000002980232

			if var_172_1 <= arg_169_1.time_ and arg_169_1.time_ < var_172_1 + var_172_2 and not isNil(var_172_0) then
				local var_172_3 = (arg_169_1.time_ - var_172_1) / var_172_2

				if arg_169_1.var_.characterEffect1011ui_story and not isNil(var_172_0) then
					local var_172_4 = Mathf.Lerp(0, 0.5, var_172_3)

					arg_169_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_169_1.var_.characterEffect1011ui_story.fillRatio = var_172_4
				end
			end

			if arg_169_1.time_ >= var_172_1 + var_172_2 and arg_169_1.time_ < var_172_1 + var_172_2 + arg_172_0 and not isNil(var_172_0) and arg_169_1.var_.characterEffect1011ui_story then
				local var_172_5 = 0.5

				arg_169_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_169_1.var_.characterEffect1011ui_story.fillRatio = var_172_5
			end

			local var_172_6 = 0
			local var_172_7 = 0.65

			if var_172_6 < arg_169_1.time_ and arg_169_1.time_ <= var_172_6 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				local var_172_8 = arg_169_1:FormatText(StoryNameCfg[7].name)

				arg_169_1.leftNameTxt_.text = var_172_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, true)
				arg_169_1.iconController_:SetSelectedState("hero")

				arg_169_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_169_1.callingController_:SetSelectedState("normal")

				arg_169_1.keyicon_.color = Color.New(1, 1, 1)
				arg_169_1.icon_.color = Color.New(1, 1, 1)

				local var_172_9 = arg_169_1:GetWordFromCfg(1101105041)
				local var_172_10 = arg_169_1:FormatText(var_172_9.content)

				arg_169_1.text_.text = var_172_10

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_11 = 26
				local var_172_12 = utf8.len(var_172_10)
				local var_172_13 = var_172_11 <= 0 and var_172_7 or var_172_7 * (var_172_12 / var_172_11)

				if var_172_13 > 0 and var_172_7 < var_172_13 then
					arg_169_1.talkMaxDuration = var_172_13

					if var_172_13 + var_172_6 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_13 + var_172_6
					end
				end

				arg_169_1.text_.text = var_172_10
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)
				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_14 = math.max(var_172_7, arg_169_1.talkMaxDuration)

			if var_172_6 <= arg_169_1.time_ and arg_169_1.time_ < var_172_6 + var_172_14 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_6) / var_172_14

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_6 + var_172_14 and arg_169_1.time_ < var_172_6 + var_172_14 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play1101105042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 1101105042
		arg_173_1.duration_ = 11.3

		local var_173_0 = {
			zh = 9.7,
			ja = 11.3
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
				arg_173_0:Play1101105043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = arg_173_1.actors_["1011ui_story"].transform
			local var_176_1 = 0

			if var_176_1 < arg_173_1.time_ and arg_173_1.time_ <= var_176_1 + arg_176_0 then
				arg_173_1.var_.moveOldPos1011ui_story = var_176_0.localPosition
			end

			local var_176_2 = 0.001

			if var_176_1 <= arg_173_1.time_ and arg_173_1.time_ < var_176_1 + var_176_2 then
				local var_176_3 = (arg_173_1.time_ - var_176_1) / var_176_2
				local var_176_4 = Vector3.New(0, -0.71, -6)

				var_176_0.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos1011ui_story, var_176_4, var_176_3)

				local var_176_5 = manager.ui.mainCamera.transform.position - var_176_0.position

				var_176_0.forward = Vector3.New(var_176_5.x, var_176_5.y, var_176_5.z)

				local var_176_6 = var_176_0.localEulerAngles

				var_176_6.z = 0
				var_176_6.x = 0
				var_176_0.localEulerAngles = var_176_6
			end

			if arg_173_1.time_ >= var_176_1 + var_176_2 and arg_173_1.time_ < var_176_1 + var_176_2 + arg_176_0 then
				var_176_0.localPosition = Vector3.New(0, -0.71, -6)

				local var_176_7 = manager.ui.mainCamera.transform.position - var_176_0.position

				var_176_0.forward = Vector3.New(var_176_7.x, var_176_7.y, var_176_7.z)

				local var_176_8 = var_176_0.localEulerAngles

				var_176_8.z = 0
				var_176_8.x = 0
				var_176_0.localEulerAngles = var_176_8
			end

			local var_176_9 = arg_173_1.actors_["1011ui_story"]
			local var_176_10 = 0

			if var_176_10 < arg_173_1.time_ and arg_173_1.time_ <= var_176_10 + arg_176_0 and not isNil(var_176_9) and arg_173_1.var_.characterEffect1011ui_story == nil then
				arg_173_1.var_.characterEffect1011ui_story = var_176_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_11 = 0.200000002980232

			if var_176_10 <= arg_173_1.time_ and arg_173_1.time_ < var_176_10 + var_176_11 and not isNil(var_176_9) then
				local var_176_12 = (arg_173_1.time_ - var_176_10) / var_176_11

				if arg_173_1.var_.characterEffect1011ui_story and not isNil(var_176_9) then
					arg_173_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_173_1.time_ >= var_176_10 + var_176_11 and arg_173_1.time_ < var_176_10 + var_176_11 + arg_176_0 and not isNil(var_176_9) and arg_173_1.var_.characterEffect1011ui_story then
				arg_173_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_176_13 = 0

			if var_176_13 < arg_173_1.time_ and arg_173_1.time_ <= var_176_13 + arg_176_0 then
				arg_173_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action4_1")
			end

			local var_176_14 = 0

			if var_176_14 < arg_173_1.time_ and arg_173_1.time_ <= var_176_14 + arg_176_0 then
				arg_173_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_176_15 = 0
			local var_176_16 = 1.175

			if var_176_15 < arg_173_1.time_ and arg_173_1.time_ <= var_176_15 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				local var_176_17 = arg_173_1:FormatText(StoryNameCfg[37].name)

				arg_173_1.leftNameTxt_.text = var_176_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_18 = arg_173_1:GetWordFromCfg(1101105042)
				local var_176_19 = arg_173_1:FormatText(var_176_18.content)

				arg_173_1.text_.text = var_176_19

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_20 = 47
				local var_176_21 = utf8.len(var_176_19)
				local var_176_22 = var_176_20 <= 0 and var_176_16 or var_176_16 * (var_176_21 / var_176_20)

				if var_176_22 > 0 and var_176_16 < var_176_22 then
					arg_173_1.talkMaxDuration = var_176_22

					if var_176_22 + var_176_15 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_22 + var_176_15
					end
				end

				arg_173_1.text_.text = var_176_19
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105042", "story_v_side_new_1101105.awb") ~= 0 then
					local var_176_23 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105042", "story_v_side_new_1101105.awb") / 1000

					if var_176_23 + var_176_15 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_23 + var_176_15
					end

					if var_176_18.prefab_name ~= "" and arg_173_1.actors_[var_176_18.prefab_name] ~= nil then
						local var_176_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_18.prefab_name].transform, "story_v_side_new_1101105", "1101105042", "story_v_side_new_1101105.awb")

						arg_173_1:RecordAudio("1101105042", var_176_24)
						arg_173_1:RecordAudio("1101105042", var_176_24)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105042", "story_v_side_new_1101105.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105042", "story_v_side_new_1101105.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_25 = math.max(var_176_16, arg_173_1.talkMaxDuration)

			if var_176_15 <= arg_173_1.time_ and arg_173_1.time_ < var_176_15 + var_176_25 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_15) / var_176_25

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_15 + var_176_25 and arg_173_1.time_ < var_176_15 + var_176_25 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_173_1:InitPlayNodeList()
	end,
	Play1101105043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 1101105043
		arg_177_1.duration_ = 5

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play1101105044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = arg_177_1.actors_["1011ui_story"]
			local var_180_1 = 0

			if var_180_1 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 and not isNil(var_180_0) and arg_177_1.var_.characterEffect1011ui_story == nil then
				arg_177_1.var_.characterEffect1011ui_story = var_180_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_2 = 0.200000002980232

			if var_180_1 <= arg_177_1.time_ and arg_177_1.time_ < var_180_1 + var_180_2 and not isNil(var_180_0) then
				local var_180_3 = (arg_177_1.time_ - var_180_1) / var_180_2

				if arg_177_1.var_.characterEffect1011ui_story and not isNil(var_180_0) then
					local var_180_4 = Mathf.Lerp(0, 0.5, var_180_3)

					arg_177_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_177_1.var_.characterEffect1011ui_story.fillRatio = var_180_4
				end
			end

			if arg_177_1.time_ >= var_180_1 + var_180_2 and arg_177_1.time_ < var_180_1 + var_180_2 + arg_180_0 and not isNil(var_180_0) and arg_177_1.var_.characterEffect1011ui_story then
				local var_180_5 = 0.5

				arg_177_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_177_1.var_.characterEffect1011ui_story.fillRatio = var_180_5
			end

			local var_180_6 = 0
			local var_180_7 = 0.2

			if var_180_6 < arg_177_1.time_ and arg_177_1.time_ <= var_180_6 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				local var_180_8 = arg_177_1:FormatText(StoryNameCfg[7].name)

				arg_177_1.leftNameTxt_.text = var_180_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, true)
				arg_177_1.iconController_:SetSelectedState("hero")

				arg_177_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_177_1.callingController_:SetSelectedState("normal")

				arg_177_1.keyicon_.color = Color.New(1, 1, 1)
				arg_177_1.icon_.color = Color.New(1, 1, 1)

				local var_180_9 = arg_177_1:GetWordFromCfg(1101105043)
				local var_180_10 = arg_177_1:FormatText(var_180_9.content)

				arg_177_1.text_.text = var_180_10

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_11 = 8
				local var_180_12 = utf8.len(var_180_10)
				local var_180_13 = var_180_11 <= 0 and var_180_7 or var_180_7 * (var_180_12 / var_180_11)

				if var_180_13 > 0 and var_180_7 < var_180_13 then
					arg_177_1.talkMaxDuration = var_180_13

					if var_180_13 + var_180_6 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_13 + var_180_6
					end
				end

				arg_177_1.text_.text = var_180_10
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)
				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_14 = math.max(var_180_7, arg_177_1.talkMaxDuration)

			if var_180_6 <= arg_177_1.time_ and arg_177_1.time_ < var_180_6 + var_180_14 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_6) / var_180_14

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_6 + var_180_14 and arg_177_1.time_ < var_180_6 + var_180_14 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play1101105044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 1101105044
		arg_181_1.duration_ = 5.03

		local var_181_0 = {
			zh = 3.766,
			ja = 5.033
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
				arg_181_0:Play1101105045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = 0
			local var_184_1 = 0.425

			if var_184_0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_0 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				local var_184_2 = arg_181_1:FormatText(StoryNameCfg[10].name)

				arg_181_1.leftNameTxt_.text = var_184_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, true)
				arg_181_1.iconController_:SetSelectedState("hero")

				arg_181_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_181_1.callingController_:SetSelectedState("normal")

				arg_181_1.keyicon_.color = Color.New(1, 1, 1)
				arg_181_1.icon_.color = Color.New(1, 1, 1)

				local var_184_3 = arg_181_1:GetWordFromCfg(1101105044)
				local var_184_4 = arg_181_1:FormatText(var_184_3.content)

				arg_181_1.text_.text = var_184_4

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_5 = 17
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

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105044", "story_v_side_new_1101105.awb") ~= 0 then
					local var_184_8 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105044", "story_v_side_new_1101105.awb") / 1000

					if var_184_8 + var_184_0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_8 + var_184_0
					end

					if var_184_3.prefab_name ~= "" and arg_181_1.actors_[var_184_3.prefab_name] ~= nil then
						local var_184_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_3.prefab_name].transform, "story_v_side_new_1101105", "1101105044", "story_v_side_new_1101105.awb")

						arg_181_1:RecordAudio("1101105044", var_184_9)
						arg_181_1:RecordAudio("1101105044", var_184_9)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105044", "story_v_side_new_1101105.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105044", "story_v_side_new_1101105.awb")
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
	Play1101105045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 1101105045
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play1101105046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 0
			local var_188_1 = 0.8

			if var_188_0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_0 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, false)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_2 = arg_185_1:GetWordFromCfg(1101105045)
				local var_188_3 = arg_185_1:FormatText(var_188_2.content)

				arg_185_1.text_.text = var_188_3

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_4 = 32
				local var_188_5 = utf8.len(var_188_3)
				local var_188_6 = var_188_4 <= 0 and var_188_1 or var_188_1 * (var_188_5 / var_188_4)

				if var_188_6 > 0 and var_188_1 < var_188_6 then
					arg_185_1.talkMaxDuration = var_188_6

					if var_188_6 + var_188_0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_6 + var_188_0
					end
				end

				arg_185_1.text_.text = var_188_3
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_7 = math.max(var_188_1, arg_185_1.talkMaxDuration)

			if var_188_0 <= arg_185_1.time_ and arg_185_1.time_ < var_188_0 + var_188_7 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_0) / var_188_7

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_0 + var_188_7 and arg_185_1.time_ < var_188_0 + var_188_7 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play1101105046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 1101105046
		arg_189_1.duration_ = 5

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play1101105047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = 0
			local var_192_1 = 0.075

			if var_192_0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_0 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				local var_192_2 = arg_189_1:FormatText(StoryNameCfg[7].name)

				arg_189_1.leftNameTxt_.text = var_192_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, true)
				arg_189_1.iconController_:SetSelectedState("hero")

				arg_189_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_189_1.callingController_:SetSelectedState("normal")

				arg_189_1.keyicon_.color = Color.New(1, 1, 1)
				arg_189_1.icon_.color = Color.New(1, 1, 1)

				local var_192_3 = arg_189_1:GetWordFromCfg(1101105046)
				local var_192_4 = arg_189_1:FormatText(var_192_3.content)

				arg_189_1.text_.text = var_192_4

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_5 = 3
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
				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_8 = math.max(var_192_1, arg_189_1.talkMaxDuration)

			if var_192_0 <= arg_189_1.time_ and arg_189_1.time_ < var_192_0 + var_192_8 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_0) / var_192_8

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_0 + var_192_8 and arg_189_1.time_ < var_192_0 + var_192_8 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play1101105047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 1101105047
		arg_193_1.duration_ = 2

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play1101105048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = arg_193_1.actors_["1011ui_story"].transform
			local var_196_1 = 0

			if var_196_1 < arg_193_1.time_ and arg_193_1.time_ <= var_196_1 + arg_196_0 then
				arg_193_1.var_.moveOldPos1011ui_story = var_196_0.localPosition
			end

			local var_196_2 = 0.001

			if var_196_1 <= arg_193_1.time_ and arg_193_1.time_ < var_196_1 + var_196_2 then
				local var_196_3 = (arg_193_1.time_ - var_196_1) / var_196_2
				local var_196_4 = Vector3.New(0, -0.71, -6)

				var_196_0.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos1011ui_story, var_196_4, var_196_3)

				local var_196_5 = manager.ui.mainCamera.transform.position - var_196_0.position

				var_196_0.forward = Vector3.New(var_196_5.x, var_196_5.y, var_196_5.z)

				local var_196_6 = var_196_0.localEulerAngles

				var_196_6.z = 0
				var_196_6.x = 0
				var_196_0.localEulerAngles = var_196_6
			end

			if arg_193_1.time_ >= var_196_1 + var_196_2 and arg_193_1.time_ < var_196_1 + var_196_2 + arg_196_0 then
				var_196_0.localPosition = Vector3.New(0, -0.71, -6)

				local var_196_7 = manager.ui.mainCamera.transform.position - var_196_0.position

				var_196_0.forward = Vector3.New(var_196_7.x, var_196_7.y, var_196_7.z)

				local var_196_8 = var_196_0.localEulerAngles

				var_196_8.z = 0
				var_196_8.x = 0
				var_196_0.localEulerAngles = var_196_8
			end

			local var_196_9 = arg_193_1.actors_["1011ui_story"]
			local var_196_10 = 0

			if var_196_10 < arg_193_1.time_ and arg_193_1.time_ <= var_196_10 + arg_196_0 and not isNil(var_196_9) and arg_193_1.var_.characterEffect1011ui_story == nil then
				arg_193_1.var_.characterEffect1011ui_story = var_196_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_11 = 0.200000002980232

			if var_196_10 <= arg_193_1.time_ and arg_193_1.time_ < var_196_10 + var_196_11 and not isNil(var_196_9) then
				local var_196_12 = (arg_193_1.time_ - var_196_10) / var_196_11

				if arg_193_1.var_.characterEffect1011ui_story and not isNil(var_196_9) then
					arg_193_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_193_1.time_ >= var_196_10 + var_196_11 and arg_193_1.time_ < var_196_10 + var_196_11 + arg_196_0 and not isNil(var_196_9) and arg_193_1.var_.characterEffect1011ui_story then
				arg_193_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_196_13 = 0

			if var_196_13 < arg_193_1.time_ and arg_193_1.time_ <= var_196_13 + arg_196_0 then
				arg_193_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_196_14 = 0
			local var_196_15 = 0.075

			if var_196_14 < arg_193_1.time_ and arg_193_1.time_ <= var_196_14 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				local var_196_16 = arg_193_1:FormatText(StoryNameCfg[37].name)

				arg_193_1.leftNameTxt_.text = var_196_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_17 = arg_193_1:GetWordFromCfg(1101105047)
				local var_196_18 = arg_193_1:FormatText(var_196_17.content)

				arg_193_1.text_.text = var_196_18

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_19 = 3
				local var_196_20 = utf8.len(var_196_18)
				local var_196_21 = var_196_19 <= 0 and var_196_15 or var_196_15 * (var_196_20 / var_196_19)

				if var_196_21 > 0 and var_196_15 < var_196_21 then
					arg_193_1.talkMaxDuration = var_196_21

					if var_196_21 + var_196_14 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_21 + var_196_14
					end
				end

				arg_193_1.text_.text = var_196_18
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105047", "story_v_side_new_1101105.awb") ~= 0 then
					local var_196_22 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105047", "story_v_side_new_1101105.awb") / 1000

					if var_196_22 + var_196_14 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_22 + var_196_14
					end

					if var_196_17.prefab_name ~= "" and arg_193_1.actors_[var_196_17.prefab_name] ~= nil then
						local var_196_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_17.prefab_name].transform, "story_v_side_new_1101105", "1101105047", "story_v_side_new_1101105.awb")

						arg_193_1:RecordAudio("1101105047", var_196_23)
						arg_193_1:RecordAudio("1101105047", var_196_23)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105047", "story_v_side_new_1101105.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105047", "story_v_side_new_1101105.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_24 = math.max(var_196_15, arg_193_1.talkMaxDuration)

			if var_196_14 <= arg_193_1.time_ and arg_193_1.time_ < var_196_14 + var_196_24 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_14) / var_196_24

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_14 + var_196_24 and arg_193_1.time_ < var_196_14 + var_196_24 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_193_1:InitPlayNodeList()
	end,
	Play1101105048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 1101105048
		arg_197_1.duration_ = 6.93

		local var_197_0 = {
			zh = 5.633,
			ja = 6.933
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
				arg_197_0:Play1101105049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = arg_197_1.actors_["1011ui_story"]
			local var_200_1 = 0

			if var_200_1 < arg_197_1.time_ and arg_197_1.time_ <= var_200_1 + arg_200_0 and not isNil(var_200_0) and arg_197_1.var_.characterEffect1011ui_story == nil then
				arg_197_1.var_.characterEffect1011ui_story = var_200_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_2 = 0.200000002980232

			if var_200_1 <= arg_197_1.time_ and arg_197_1.time_ < var_200_1 + var_200_2 and not isNil(var_200_0) then
				local var_200_3 = (arg_197_1.time_ - var_200_1) / var_200_2

				if arg_197_1.var_.characterEffect1011ui_story and not isNil(var_200_0) then
					local var_200_4 = Mathf.Lerp(0, 0.5, var_200_3)

					arg_197_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_197_1.var_.characterEffect1011ui_story.fillRatio = var_200_4
				end
			end

			if arg_197_1.time_ >= var_200_1 + var_200_2 and arg_197_1.time_ < var_200_1 + var_200_2 + arg_200_0 and not isNil(var_200_0) and arg_197_1.var_.characterEffect1011ui_story then
				local var_200_5 = 0.5

				arg_197_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_197_1.var_.characterEffect1011ui_story.fillRatio = var_200_5
			end

			local var_200_6 = 0
			local var_200_7 = 0.65

			if var_200_6 < arg_197_1.time_ and arg_197_1.time_ <= var_200_6 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				local var_200_8 = arg_197_1:FormatText(StoryNameCfg[10].name)

				arg_197_1.leftNameTxt_.text = var_200_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, true)
				arg_197_1.iconController_:SetSelectedState("hero")

				arg_197_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_197_1.callingController_:SetSelectedState("normal")

				arg_197_1.keyicon_.color = Color.New(1, 1, 1)
				arg_197_1.icon_.color = Color.New(1, 1, 1)

				local var_200_9 = arg_197_1:GetWordFromCfg(1101105048)
				local var_200_10 = arg_197_1:FormatText(var_200_9.content)

				arg_197_1.text_.text = var_200_10

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_11 = 26
				local var_200_12 = utf8.len(var_200_10)
				local var_200_13 = var_200_11 <= 0 and var_200_7 or var_200_7 * (var_200_12 / var_200_11)

				if var_200_13 > 0 and var_200_7 < var_200_13 then
					arg_197_1.talkMaxDuration = var_200_13

					if var_200_13 + var_200_6 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_13 + var_200_6
					end
				end

				arg_197_1.text_.text = var_200_10
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105048", "story_v_side_new_1101105.awb") ~= 0 then
					local var_200_14 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105048", "story_v_side_new_1101105.awb") / 1000

					if var_200_14 + var_200_6 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_14 + var_200_6
					end

					if var_200_9.prefab_name ~= "" and arg_197_1.actors_[var_200_9.prefab_name] ~= nil then
						local var_200_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_9.prefab_name].transform, "story_v_side_new_1101105", "1101105048", "story_v_side_new_1101105.awb")

						arg_197_1:RecordAudio("1101105048", var_200_15)
						arg_197_1:RecordAudio("1101105048", var_200_15)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105048", "story_v_side_new_1101105.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105048", "story_v_side_new_1101105.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_16 = math.max(var_200_7, arg_197_1.talkMaxDuration)

			if var_200_6 <= arg_197_1.time_ and arg_197_1.time_ < var_200_6 + var_200_16 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_6) / var_200_16

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_6 + var_200_16 and arg_197_1.time_ < var_200_6 + var_200_16 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play1101105049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 1101105049
		arg_201_1.duration_ = 5

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play1101105050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = 0
			local var_204_1 = 1.1

			if var_204_0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_0 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				local var_204_2 = arg_201_1:FormatText(StoryNameCfg[7].name)

				arg_201_1.leftNameTxt_.text = var_204_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, true)
				arg_201_1.iconController_:SetSelectedState("hero")

				arg_201_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_201_1.callingController_:SetSelectedState("normal")

				arg_201_1.keyicon_.color = Color.New(1, 1, 1)
				arg_201_1.icon_.color = Color.New(1, 1, 1)

				local var_204_3 = arg_201_1:GetWordFromCfg(1101105049)
				local var_204_4 = arg_201_1:FormatText(var_204_3.content)

				arg_201_1.text_.text = var_204_4

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_5 = 44
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
				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_8 = math.max(var_204_1, arg_201_1.talkMaxDuration)

			if var_204_0 <= arg_201_1.time_ and arg_201_1.time_ < var_204_0 + var_204_8 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_0) / var_204_8

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_0 + var_204_8 and arg_201_1.time_ < var_204_0 + var_204_8 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play1101105050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 1101105050
		arg_205_1.duration_ = 6.57

		local var_205_0 = {
			zh = 6.433,
			ja = 6.566
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
				arg_205_0:Play1101105051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = 0

			if var_208_0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_0 + arg_208_0 then
				arg_205_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_208_1 = 0
			local var_208_2 = 0.8

			if var_208_1 < arg_205_1.time_ and arg_205_1.time_ <= var_208_1 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				local var_208_3 = arg_205_1:FormatText(StoryNameCfg[10].name)

				arg_205_1.leftNameTxt_.text = var_208_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, true)
				arg_205_1.iconController_:SetSelectedState("hero")

				arg_205_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_205_1.callingController_:SetSelectedState("normal")

				arg_205_1.keyicon_.color = Color.New(1, 1, 1)
				arg_205_1.icon_.color = Color.New(1, 1, 1)

				local var_208_4 = arg_205_1:GetWordFromCfg(1101105050)
				local var_208_5 = arg_205_1:FormatText(var_208_4.content)

				arg_205_1.text_.text = var_208_5

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_6 = 32
				local var_208_7 = utf8.len(var_208_5)
				local var_208_8 = var_208_6 <= 0 and var_208_2 or var_208_2 * (var_208_7 / var_208_6)

				if var_208_8 > 0 and var_208_2 < var_208_8 then
					arg_205_1.talkMaxDuration = var_208_8

					if var_208_8 + var_208_1 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_8 + var_208_1
					end
				end

				arg_205_1.text_.text = var_208_5
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105050", "story_v_side_new_1101105.awb") ~= 0 then
					local var_208_9 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105050", "story_v_side_new_1101105.awb") / 1000

					if var_208_9 + var_208_1 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_9 + var_208_1
					end

					if var_208_4.prefab_name ~= "" and arg_205_1.actors_[var_208_4.prefab_name] ~= nil then
						local var_208_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_4.prefab_name].transform, "story_v_side_new_1101105", "1101105050", "story_v_side_new_1101105.awb")

						arg_205_1:RecordAudio("1101105050", var_208_10)
						arg_205_1:RecordAudio("1101105050", var_208_10)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105050", "story_v_side_new_1101105.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105050", "story_v_side_new_1101105.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_11 = math.max(var_208_2, arg_205_1.talkMaxDuration)

			if var_208_1 <= arg_205_1.time_ and arg_205_1.time_ < var_208_1 + var_208_11 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_1) / var_208_11

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_1 + var_208_11 and arg_205_1.time_ < var_208_1 + var_208_11 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play1101105051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 1101105051
		arg_209_1.duration_ = 5

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play1101105052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = 0
			local var_212_1 = 0.5

			if var_212_0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_0 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				local var_212_2 = arg_209_1:FormatText(StoryNameCfg[7].name)

				arg_209_1.leftNameTxt_.text = var_212_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, true)
				arg_209_1.iconController_:SetSelectedState("hero")

				arg_209_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_209_1.callingController_:SetSelectedState("normal")

				arg_209_1.keyicon_.color = Color.New(1, 1, 1)
				arg_209_1.icon_.color = Color.New(1, 1, 1)

				local var_212_3 = arg_209_1:GetWordFromCfg(1101105051)
				local var_212_4 = arg_209_1:FormatText(var_212_3.content)

				arg_209_1.text_.text = var_212_4

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_5 = 20
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
				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_8 = math.max(var_212_1, arg_209_1.talkMaxDuration)

			if var_212_0 <= arg_209_1.time_ and arg_209_1.time_ < var_212_0 + var_212_8 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_0) / var_212_8

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_0 + var_212_8 and arg_209_1.time_ < var_212_0 + var_212_8 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play1101105052 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 1101105052
		arg_213_1.duration_ = 8.4

		local var_213_0 = {
			zh = 7.133,
			ja = 8.4
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
				arg_213_0:Play1101105053(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = arg_213_1.actors_["1011ui_story"].transform
			local var_216_1 = 0

			if var_216_1 < arg_213_1.time_ and arg_213_1.time_ <= var_216_1 + arg_216_0 then
				arg_213_1.var_.moveOldPos1011ui_story = var_216_0.localPosition
			end

			local var_216_2 = 0.001

			if var_216_1 <= arg_213_1.time_ and arg_213_1.time_ < var_216_1 + var_216_2 then
				local var_216_3 = (arg_213_1.time_ - var_216_1) / var_216_2
				local var_216_4 = Vector3.New(0, -0.71, -6)

				var_216_0.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos1011ui_story, var_216_4, var_216_3)

				local var_216_5 = manager.ui.mainCamera.transform.position - var_216_0.position

				var_216_0.forward = Vector3.New(var_216_5.x, var_216_5.y, var_216_5.z)

				local var_216_6 = var_216_0.localEulerAngles

				var_216_6.z = 0
				var_216_6.x = 0
				var_216_0.localEulerAngles = var_216_6
			end

			if arg_213_1.time_ >= var_216_1 + var_216_2 and arg_213_1.time_ < var_216_1 + var_216_2 + arg_216_0 then
				var_216_0.localPosition = Vector3.New(0, -0.71, -6)

				local var_216_7 = manager.ui.mainCamera.transform.position - var_216_0.position

				var_216_0.forward = Vector3.New(var_216_7.x, var_216_7.y, var_216_7.z)

				local var_216_8 = var_216_0.localEulerAngles

				var_216_8.z = 0
				var_216_8.x = 0
				var_216_0.localEulerAngles = var_216_8
			end

			local var_216_9 = arg_213_1.actors_["1011ui_story"]
			local var_216_10 = 0

			if var_216_10 < arg_213_1.time_ and arg_213_1.time_ <= var_216_10 + arg_216_0 and not isNil(var_216_9) and arg_213_1.var_.characterEffect1011ui_story == nil then
				arg_213_1.var_.characterEffect1011ui_story = var_216_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_11 = 0.200000002980232

			if var_216_10 <= arg_213_1.time_ and arg_213_1.time_ < var_216_10 + var_216_11 and not isNil(var_216_9) then
				local var_216_12 = (arg_213_1.time_ - var_216_10) / var_216_11

				if arg_213_1.var_.characterEffect1011ui_story and not isNil(var_216_9) then
					arg_213_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_213_1.time_ >= var_216_10 + var_216_11 and arg_213_1.time_ < var_216_10 + var_216_11 + arg_216_0 and not isNil(var_216_9) and arg_213_1.var_.characterEffect1011ui_story then
				arg_213_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_216_13 = 0

			if var_216_13 < arg_213_1.time_ and arg_213_1.time_ <= var_216_13 + arg_216_0 then
				arg_213_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_216_14 = 0
			local var_216_15 = 0.7

			if var_216_14 < arg_213_1.time_ and arg_213_1.time_ <= var_216_14 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				local var_216_16 = arg_213_1:FormatText(StoryNameCfg[37].name)

				arg_213_1.leftNameTxt_.text = var_216_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_17 = arg_213_1:GetWordFromCfg(1101105052)
				local var_216_18 = arg_213_1:FormatText(var_216_17.content)

				arg_213_1.text_.text = var_216_18

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_19 = 28
				local var_216_20 = utf8.len(var_216_18)
				local var_216_21 = var_216_19 <= 0 and var_216_15 or var_216_15 * (var_216_20 / var_216_19)

				if var_216_21 > 0 and var_216_15 < var_216_21 then
					arg_213_1.talkMaxDuration = var_216_21

					if var_216_21 + var_216_14 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_21 + var_216_14
					end
				end

				arg_213_1.text_.text = var_216_18
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105052", "story_v_side_new_1101105.awb") ~= 0 then
					local var_216_22 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105052", "story_v_side_new_1101105.awb") / 1000

					if var_216_22 + var_216_14 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_22 + var_216_14
					end

					if var_216_17.prefab_name ~= "" and arg_213_1.actors_[var_216_17.prefab_name] ~= nil then
						local var_216_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_17.prefab_name].transform, "story_v_side_new_1101105", "1101105052", "story_v_side_new_1101105.awb")

						arg_213_1:RecordAudio("1101105052", var_216_23)
						arg_213_1:RecordAudio("1101105052", var_216_23)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105052", "story_v_side_new_1101105.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105052", "story_v_side_new_1101105.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_24 = math.max(var_216_15, arg_213_1.talkMaxDuration)

			if var_216_14 <= arg_213_1.time_ and arg_213_1.time_ < var_216_14 + var_216_24 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_14) / var_216_24

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_14 + var_216_24 and arg_213_1.time_ < var_216_14 + var_216_24 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_213_1:InitPlayNodeList()
	end,
	Play1101105053 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 1101105053
		arg_217_1.duration_ = 5

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play1101105054(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = arg_217_1.actors_["1011ui_story"]
			local var_220_1 = 0

			if var_220_1 < arg_217_1.time_ and arg_217_1.time_ <= var_220_1 + arg_220_0 and not isNil(var_220_0) and arg_217_1.var_.characterEffect1011ui_story == nil then
				arg_217_1.var_.characterEffect1011ui_story = var_220_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_2 = 0.200000002980232

			if var_220_1 <= arg_217_1.time_ and arg_217_1.time_ < var_220_1 + var_220_2 and not isNil(var_220_0) then
				local var_220_3 = (arg_217_1.time_ - var_220_1) / var_220_2

				if arg_217_1.var_.characterEffect1011ui_story and not isNil(var_220_0) then
					local var_220_4 = Mathf.Lerp(0, 0.5, var_220_3)

					arg_217_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_217_1.var_.characterEffect1011ui_story.fillRatio = var_220_4
				end
			end

			if arg_217_1.time_ >= var_220_1 + var_220_2 and arg_217_1.time_ < var_220_1 + var_220_2 + arg_220_0 and not isNil(var_220_0) and arg_217_1.var_.characterEffect1011ui_story then
				local var_220_5 = 0.5

				arg_217_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_217_1.var_.characterEffect1011ui_story.fillRatio = var_220_5
			end

			local var_220_6 = 0
			local var_220_7 = 0.375

			if var_220_6 < arg_217_1.time_ and arg_217_1.time_ <= var_220_6 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				local var_220_8 = arg_217_1:FormatText(StoryNameCfg[7].name)

				arg_217_1.leftNameTxt_.text = var_220_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, true)
				arg_217_1.iconController_:SetSelectedState("hero")

				arg_217_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_217_1.callingController_:SetSelectedState("normal")

				arg_217_1.keyicon_.color = Color.New(1, 1, 1)
				arg_217_1.icon_.color = Color.New(1, 1, 1)

				local var_220_9 = arg_217_1:GetWordFromCfg(1101105053)
				local var_220_10 = arg_217_1:FormatText(var_220_9.content)

				arg_217_1.text_.text = var_220_10

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_11 = 15
				local var_220_12 = utf8.len(var_220_10)
				local var_220_13 = var_220_11 <= 0 and var_220_7 or var_220_7 * (var_220_12 / var_220_11)

				if var_220_13 > 0 and var_220_7 < var_220_13 then
					arg_217_1.talkMaxDuration = var_220_13

					if var_220_13 + var_220_6 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_13 + var_220_6
					end
				end

				arg_217_1.text_.text = var_220_10
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)
				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_14 = math.max(var_220_7, arg_217_1.talkMaxDuration)

			if var_220_6 <= arg_217_1.time_ and arg_217_1.time_ < var_220_6 + var_220_14 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_6) / var_220_14

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_6 + var_220_14 and arg_217_1.time_ < var_220_6 + var_220_14 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play1101105054 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 1101105054
		arg_221_1.duration_ = 2

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play1101105055(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = arg_221_1.actors_["1011ui_story"].transform
			local var_224_1 = 0

			if var_224_1 < arg_221_1.time_ and arg_221_1.time_ <= var_224_1 + arg_224_0 then
				arg_221_1.var_.moveOldPos1011ui_story = var_224_0.localPosition
			end

			local var_224_2 = 0.001

			if var_224_1 <= arg_221_1.time_ and arg_221_1.time_ < var_224_1 + var_224_2 then
				local var_224_3 = (arg_221_1.time_ - var_224_1) / var_224_2
				local var_224_4 = Vector3.New(0, -0.71, -6)

				var_224_0.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos1011ui_story, var_224_4, var_224_3)

				local var_224_5 = manager.ui.mainCamera.transform.position - var_224_0.position

				var_224_0.forward = Vector3.New(var_224_5.x, var_224_5.y, var_224_5.z)

				local var_224_6 = var_224_0.localEulerAngles

				var_224_6.z = 0
				var_224_6.x = 0
				var_224_0.localEulerAngles = var_224_6
			end

			if arg_221_1.time_ >= var_224_1 + var_224_2 and arg_221_1.time_ < var_224_1 + var_224_2 + arg_224_0 then
				var_224_0.localPosition = Vector3.New(0, -0.71, -6)

				local var_224_7 = manager.ui.mainCamera.transform.position - var_224_0.position

				var_224_0.forward = Vector3.New(var_224_7.x, var_224_7.y, var_224_7.z)

				local var_224_8 = var_224_0.localEulerAngles

				var_224_8.z = 0
				var_224_8.x = 0
				var_224_0.localEulerAngles = var_224_8
			end

			local var_224_9 = arg_221_1.actors_["1011ui_story"]
			local var_224_10 = 0

			if var_224_10 < arg_221_1.time_ and arg_221_1.time_ <= var_224_10 + arg_224_0 and not isNil(var_224_9) and arg_221_1.var_.characterEffect1011ui_story == nil then
				arg_221_1.var_.characterEffect1011ui_story = var_224_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_11 = 0.200000002980232

			if var_224_10 <= arg_221_1.time_ and arg_221_1.time_ < var_224_10 + var_224_11 and not isNil(var_224_9) then
				local var_224_12 = (arg_221_1.time_ - var_224_10) / var_224_11

				if arg_221_1.var_.characterEffect1011ui_story and not isNil(var_224_9) then
					arg_221_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_221_1.time_ >= var_224_10 + var_224_11 and arg_221_1.time_ < var_224_10 + var_224_11 + arg_224_0 and not isNil(var_224_9) and arg_221_1.var_.characterEffect1011ui_story then
				arg_221_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_224_13 = 0

			if var_224_13 < arg_221_1.time_ and arg_221_1.time_ <= var_224_13 + arg_224_0 then
				arg_221_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011actionlink/1011action446")
			end

			local var_224_14 = 0
			local var_224_15 = 0.05

			if var_224_14 < arg_221_1.time_ and arg_221_1.time_ <= var_224_14 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				local var_224_16 = arg_221_1:FormatText(StoryNameCfg[37].name)

				arg_221_1.leftNameTxt_.text = var_224_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_17 = arg_221_1:GetWordFromCfg(1101105054)
				local var_224_18 = arg_221_1:FormatText(var_224_17.content)

				arg_221_1.text_.text = var_224_18

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_19 = 2
				local var_224_20 = utf8.len(var_224_18)
				local var_224_21 = var_224_19 <= 0 and var_224_15 or var_224_15 * (var_224_20 / var_224_19)

				if var_224_21 > 0 and var_224_15 < var_224_21 then
					arg_221_1.talkMaxDuration = var_224_21

					if var_224_21 + var_224_14 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_21 + var_224_14
					end
				end

				arg_221_1.text_.text = var_224_18
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105054", "story_v_side_new_1101105.awb") ~= 0 then
					local var_224_22 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105054", "story_v_side_new_1101105.awb") / 1000

					if var_224_22 + var_224_14 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_22 + var_224_14
					end

					if var_224_17.prefab_name ~= "" and arg_221_1.actors_[var_224_17.prefab_name] ~= nil then
						local var_224_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_17.prefab_name].transform, "story_v_side_new_1101105", "1101105054", "story_v_side_new_1101105.awb")

						arg_221_1:RecordAudio("1101105054", var_224_23)
						arg_221_1:RecordAudio("1101105054", var_224_23)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105054", "story_v_side_new_1101105.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105054", "story_v_side_new_1101105.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_24 = math.max(var_224_15, arg_221_1.talkMaxDuration)

			if var_224_14 <= arg_221_1.time_ and arg_221_1.time_ < var_224_14 + var_224_24 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_14) / var_224_24

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_14 + var_224_24 and arg_221_1.time_ < var_224_14 + var_224_24 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_221_1:InitPlayNodeList()
	end,
	Play1101105055 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 1101105055
		arg_225_1.duration_ = 5

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play1101105056(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = arg_225_1.actors_["1011ui_story"].transform
			local var_228_1 = 0

			if var_228_1 < arg_225_1.time_ and arg_225_1.time_ <= var_228_1 + arg_228_0 then
				arg_225_1.var_.moveOldPos1011ui_story = var_228_0.localPosition
			end

			local var_228_2 = 0.001

			if var_228_1 <= arg_225_1.time_ and arg_225_1.time_ < var_228_1 + var_228_2 then
				local var_228_3 = (arg_225_1.time_ - var_228_1) / var_228_2
				local var_228_4 = Vector3.New(0, 100, 0)

				var_228_0.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos1011ui_story, var_228_4, var_228_3)

				local var_228_5 = manager.ui.mainCamera.transform.position - var_228_0.position

				var_228_0.forward = Vector3.New(var_228_5.x, var_228_5.y, var_228_5.z)

				local var_228_6 = var_228_0.localEulerAngles

				var_228_6.z = 0
				var_228_6.x = 0
				var_228_0.localEulerAngles = var_228_6
			end

			if arg_225_1.time_ >= var_228_1 + var_228_2 and arg_225_1.time_ < var_228_1 + var_228_2 + arg_228_0 then
				var_228_0.localPosition = Vector3.New(0, 100, 0)

				local var_228_7 = manager.ui.mainCamera.transform.position - var_228_0.position

				var_228_0.forward = Vector3.New(var_228_7.x, var_228_7.y, var_228_7.z)

				local var_228_8 = var_228_0.localEulerAngles

				var_228_8.z = 0
				var_228_8.x = 0
				var_228_0.localEulerAngles = var_228_8
			end

			local var_228_9 = arg_225_1.actors_["1011ui_story"]
			local var_228_10 = 0

			if var_228_10 < arg_225_1.time_ and arg_225_1.time_ <= var_228_10 + arg_228_0 and not isNil(var_228_9) and arg_225_1.var_.characterEffect1011ui_story == nil then
				arg_225_1.var_.characterEffect1011ui_story = var_228_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_11 = 0.200000002980232

			if var_228_10 <= arg_225_1.time_ and arg_225_1.time_ < var_228_10 + var_228_11 and not isNil(var_228_9) then
				local var_228_12 = (arg_225_1.time_ - var_228_10) / var_228_11

				if arg_225_1.var_.characterEffect1011ui_story and not isNil(var_228_9) then
					local var_228_13 = Mathf.Lerp(0, 0.5, var_228_12)

					arg_225_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_225_1.var_.characterEffect1011ui_story.fillRatio = var_228_13
				end
			end

			if arg_225_1.time_ >= var_228_10 + var_228_11 and arg_225_1.time_ < var_228_10 + var_228_11 + arg_228_0 and not isNil(var_228_9) and arg_225_1.var_.characterEffect1011ui_story then
				local var_228_14 = 0.5

				arg_225_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_225_1.var_.characterEffect1011ui_story.fillRatio = var_228_14
			end

			local var_228_15 = 0
			local var_228_16 = 0.675

			if var_228_15 < arg_225_1.time_ and arg_225_1.time_ <= var_228_15 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, false)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_17 = arg_225_1:GetWordFromCfg(1101105055)
				local var_228_18 = arg_225_1:FormatText(var_228_17.content)

				arg_225_1.text_.text = var_228_18

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_19 = 27
				local var_228_20 = utf8.len(var_228_18)
				local var_228_21 = var_228_19 <= 0 and var_228_16 or var_228_16 * (var_228_20 / var_228_19)

				if var_228_21 > 0 and var_228_16 < var_228_21 then
					arg_225_1.talkMaxDuration = var_228_21

					if var_228_21 + var_228_15 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_21 + var_228_15
					end
				end

				arg_225_1.text_.text = var_228_18
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)
				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_22 = math.max(var_228_16, arg_225_1.talkMaxDuration)

			if var_228_15 <= arg_225_1.time_ and arg_225_1.time_ < var_228_15 + var_228_22 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_15) / var_228_22

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_15 + var_228_22 and arg_225_1.time_ < var_228_15 + var_228_22 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_225_1:InitPlayNodeList()
	end,
	Play1101105056 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 1101105056
		arg_229_1.duration_ = 10.07

		local var_229_0 = {
			zh = 10.066,
			ja = 9.066
		}
		local var_229_1 = manager.audio:GetLocalizationFlag()

		if var_229_0[var_229_1] ~= nil then
			arg_229_1.duration_ = var_229_0[var_229_1]
		end

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play1101105057(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = "B13"

			if arg_229_1.bgs_[var_232_0] == nil then
				local var_232_1 = Object.Instantiate(arg_229_1.paintGo_)

				var_232_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_232_0)
				var_232_1.name = var_232_0
				var_232_1.transform.parent = arg_229_1.stage_.transform
				var_232_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_229_1.bgs_[var_232_0] = var_232_1
			end

			local var_232_2 = 3

			if var_232_2 < arg_229_1.time_ and arg_229_1.time_ <= var_232_2 + arg_232_0 then
				local var_232_3 = manager.ui.mainCamera.transform.localPosition
				local var_232_4 = Vector3.New(0, 0, 10) + Vector3.New(var_232_3.x, var_232_3.y, 0)
				local var_232_5 = arg_229_1.bgs_.B13

				var_232_5.transform.localPosition = var_232_4
				var_232_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_232_6 = var_232_5:GetComponent("SpriteRenderer")

				if var_232_6 and var_232_6.sprite then
					local var_232_7 = (var_232_5.transform.localPosition - var_232_3).z
					local var_232_8 = manager.ui.mainCameraCom_
					local var_232_9 = 2 * var_232_7 * Mathf.Tan(var_232_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_232_10 = var_232_9 * var_232_8.aspect
					local var_232_11 = var_232_6.sprite.bounds.size.x
					local var_232_12 = var_232_6.sprite.bounds.size.y
					local var_232_13 = var_232_10 / var_232_11
					local var_232_14 = var_232_9 / var_232_12
					local var_232_15 = var_232_14 < var_232_13 and var_232_13 or var_232_14

					var_232_5.transform.localScale = Vector3.New(var_232_15, var_232_15, 0)
				end

				for iter_232_0, iter_232_1 in pairs(arg_229_1.bgs_) do
					if iter_232_0 ~= "B13" then
						iter_232_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_232_16 = 0

			if var_232_16 < arg_229_1.time_ and arg_229_1.time_ <= var_232_16 + arg_232_0 then
				arg_229_1.mask_.enabled = true
				arg_229_1.mask_.raycastTarget = true

				arg_229_1:SetGaussion(false)
			end

			local var_232_17 = 3

			if var_232_16 <= arg_229_1.time_ and arg_229_1.time_ < var_232_16 + var_232_17 then
				local var_232_18 = (arg_229_1.time_ - var_232_16) / var_232_17
				local var_232_19 = Color.New(0, 0, 0)

				var_232_19.a = Mathf.Lerp(0, 1, var_232_18)
				arg_229_1.mask_.color = var_232_19
			end

			if arg_229_1.time_ >= var_232_16 + var_232_17 and arg_229_1.time_ < var_232_16 + var_232_17 + arg_232_0 then
				local var_232_20 = Color.New(0, 0, 0)

				var_232_20.a = 1
				arg_229_1.mask_.color = var_232_20
			end

			local var_232_21 = 3

			if var_232_21 < arg_229_1.time_ and arg_229_1.time_ <= var_232_21 + arg_232_0 then
				arg_229_1.mask_.enabled = true
				arg_229_1.mask_.raycastTarget = true

				arg_229_1:SetGaussion(false)
			end

			local var_232_22 = 3

			if var_232_21 <= arg_229_1.time_ and arg_229_1.time_ < var_232_21 + var_232_22 then
				local var_232_23 = (arg_229_1.time_ - var_232_21) / var_232_22
				local var_232_24 = Color.New(0, 0, 0)

				var_232_24.a = Mathf.Lerp(1, 0, var_232_23)
				arg_229_1.mask_.color = var_232_24
			end

			if arg_229_1.time_ >= var_232_21 + var_232_22 and arg_229_1.time_ < var_232_21 + var_232_22 + arg_232_0 then
				local var_232_25 = Color.New(0, 0, 0)
				local var_232_26 = 0

				arg_229_1.mask_.enabled = false
				var_232_25.a = var_232_26
				arg_229_1.mask_.color = var_232_25
			end

			if arg_229_1.frameCnt_ <= 1 then
				arg_229_1.dialog_:SetActive(false)
			end

			local var_232_27 = 6
			local var_232_28 = 0.375

			if var_232_27 < arg_229_1.time_ and arg_229_1.time_ <= var_232_27 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0

				arg_229_1.dialog_:SetActive(true)

				arg_229_1.dialogCg_.alpha = 0

				local var_232_29 = LeanTween.value(arg_229_1.dialog_, 0, 1, 0.3)

				var_232_29:setOnUpdate(LuaHelper.FloatAction(function(arg_233_0)
					arg_229_1.dialogCg_.alpha = arg_233_0
				end))
				var_232_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_229_1.dialog_)
					var_232_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_229_1.duration_ = arg_229_1.duration_ + 0.3

				SetActive(arg_229_1.leftNameGo_, true)

				local var_232_30 = arg_229_1:FormatText(StoryNameCfg[10].name)

				arg_229_1.leftNameTxt_.text = var_232_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, true)
				arg_229_1.iconController_:SetSelectedState("hero")

				arg_229_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_229_1.callingController_:SetSelectedState("normal")

				arg_229_1.keyicon_.color = Color.New(1, 1, 1)
				arg_229_1.icon_.color = Color.New(1, 1, 1)

				local var_232_31 = arg_229_1:GetWordFromCfg(1101105056)
				local var_232_32 = arg_229_1:FormatText(var_232_31.content)

				arg_229_1.text_.text = var_232_32

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_33 = 15
				local var_232_34 = utf8.len(var_232_32)
				local var_232_35 = var_232_33 <= 0 and var_232_28 or var_232_28 * (var_232_34 / var_232_33)

				if var_232_35 > 0 and var_232_28 < var_232_35 then
					arg_229_1.talkMaxDuration = var_232_35
					var_232_27 = var_232_27 + 0.3

					if var_232_35 + var_232_27 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_35 + var_232_27
					end
				end

				arg_229_1.text_.text = var_232_32
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105056", "story_v_side_new_1101105.awb") ~= 0 then
					local var_232_36 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105056", "story_v_side_new_1101105.awb") / 1000

					if var_232_36 + var_232_27 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_36 + var_232_27
					end

					if var_232_31.prefab_name ~= "" and arg_229_1.actors_[var_232_31.prefab_name] ~= nil then
						local var_232_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_31.prefab_name].transform, "story_v_side_new_1101105", "1101105056", "story_v_side_new_1101105.awb")

						arg_229_1:RecordAudio("1101105056", var_232_37)
						arg_229_1:RecordAudio("1101105056", var_232_37)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105056", "story_v_side_new_1101105.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105056", "story_v_side_new_1101105.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_38 = var_232_27 + 0.3
			local var_232_39 = math.max(var_232_28, arg_229_1.talkMaxDuration)

			if var_232_38 <= arg_229_1.time_ and arg_229_1.time_ < var_232_38 + var_232_39 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_38) / var_232_39

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_38 + var_232_39 and arg_229_1.time_ < var_232_38 + var_232_39 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play1101105057 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 1101105057
		arg_235_1.duration_ = 7.47

		local var_235_0 = {
			zh = 5.4,
			ja = 7.466
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
				arg_235_0:Play1101105058(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = 0
			local var_238_1 = 0.6

			if var_238_0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_0 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				local var_238_2 = arg_235_1:FormatText(StoryNameCfg[10].name)

				arg_235_1.leftNameTxt_.text = var_238_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, true)
				arg_235_1.iconController_:SetSelectedState("hero")

				arg_235_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_235_1.callingController_:SetSelectedState("normal")

				arg_235_1.keyicon_.color = Color.New(1, 1, 1)
				arg_235_1.icon_.color = Color.New(1, 1, 1)

				local var_238_3 = arg_235_1:GetWordFromCfg(1101105057)
				local var_238_4 = arg_235_1:FormatText(var_238_3.content)

				arg_235_1.text_.text = var_238_4

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_5 = 24
				local var_238_6 = utf8.len(var_238_4)
				local var_238_7 = var_238_5 <= 0 and var_238_1 or var_238_1 * (var_238_6 / var_238_5)

				if var_238_7 > 0 and var_238_1 < var_238_7 then
					arg_235_1.talkMaxDuration = var_238_7

					if var_238_7 + var_238_0 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_7 + var_238_0
					end
				end

				arg_235_1.text_.text = var_238_4
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105057", "story_v_side_new_1101105.awb") ~= 0 then
					local var_238_8 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105057", "story_v_side_new_1101105.awb") / 1000

					if var_238_8 + var_238_0 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_8 + var_238_0
					end

					if var_238_3.prefab_name ~= "" and arg_235_1.actors_[var_238_3.prefab_name] ~= nil then
						local var_238_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_3.prefab_name].transform, "story_v_side_new_1101105", "1101105057", "story_v_side_new_1101105.awb")

						arg_235_1:RecordAudio("1101105057", var_238_9)
						arg_235_1:RecordAudio("1101105057", var_238_9)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105057", "story_v_side_new_1101105.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105057", "story_v_side_new_1101105.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_10 = math.max(var_238_1, arg_235_1.talkMaxDuration)

			if var_238_0 <= arg_235_1.time_ and arg_235_1.time_ < var_238_0 + var_238_10 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_0) / var_238_10

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_0 + var_238_10 and arg_235_1.time_ < var_238_0 + var_238_10 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play1101105058 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 1101105058
		arg_239_1.duration_ = 9

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play1101105059(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = "ST10"

			if arg_239_1.bgs_[var_242_0] == nil then
				local var_242_1 = Object.Instantiate(arg_239_1.paintGo_)

				var_242_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_242_0)
				var_242_1.name = var_242_0
				var_242_1.transform.parent = arg_239_1.stage_.transform
				var_242_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_239_1.bgs_[var_242_0] = var_242_1
			end

			local var_242_2 = 2

			if var_242_2 < arg_239_1.time_ and arg_239_1.time_ <= var_242_2 + arg_242_0 then
				local var_242_3 = manager.ui.mainCamera.transform.localPosition
				local var_242_4 = Vector3.New(0, 0, 10) + Vector3.New(var_242_3.x, var_242_3.y, 0)
				local var_242_5 = arg_239_1.bgs_.ST10

				var_242_5.transform.localPosition = var_242_4
				var_242_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_242_6 = var_242_5:GetComponent("SpriteRenderer")

				if var_242_6 and var_242_6.sprite then
					local var_242_7 = (var_242_5.transform.localPosition - var_242_3).z
					local var_242_8 = manager.ui.mainCameraCom_
					local var_242_9 = 2 * var_242_7 * Mathf.Tan(var_242_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_242_10 = var_242_9 * var_242_8.aspect
					local var_242_11 = var_242_6.sprite.bounds.size.x
					local var_242_12 = var_242_6.sprite.bounds.size.y
					local var_242_13 = var_242_10 / var_242_11
					local var_242_14 = var_242_9 / var_242_12
					local var_242_15 = var_242_14 < var_242_13 and var_242_13 or var_242_14

					var_242_5.transform.localScale = Vector3.New(var_242_15, var_242_15, 0)
				end

				for iter_242_0, iter_242_1 in pairs(arg_239_1.bgs_) do
					if iter_242_0 ~= "ST10" then
						iter_242_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_242_16 = 0

			if var_242_16 < arg_239_1.time_ and arg_239_1.time_ <= var_242_16 + arg_242_0 then
				arg_239_1.mask_.enabled = true
				arg_239_1.mask_.raycastTarget = true

				arg_239_1:SetGaussion(false)
			end

			local var_242_17 = 2

			if var_242_16 <= arg_239_1.time_ and arg_239_1.time_ < var_242_16 + var_242_17 then
				local var_242_18 = (arg_239_1.time_ - var_242_16) / var_242_17
				local var_242_19 = Color.New(0, 0, 0)

				var_242_19.a = Mathf.Lerp(0, 1, var_242_18)
				arg_239_1.mask_.color = var_242_19
			end

			if arg_239_1.time_ >= var_242_16 + var_242_17 and arg_239_1.time_ < var_242_16 + var_242_17 + arg_242_0 then
				local var_242_20 = Color.New(0, 0, 0)

				var_242_20.a = 1
				arg_239_1.mask_.color = var_242_20
			end

			local var_242_21 = 2

			if var_242_21 < arg_239_1.time_ and arg_239_1.time_ <= var_242_21 + arg_242_0 then
				arg_239_1.mask_.enabled = true
				arg_239_1.mask_.raycastTarget = true

				arg_239_1:SetGaussion(false)
			end

			local var_242_22 = 2

			if var_242_21 <= arg_239_1.time_ and arg_239_1.time_ < var_242_21 + var_242_22 then
				local var_242_23 = (arg_239_1.time_ - var_242_21) / var_242_22
				local var_242_24 = Color.New(0, 0, 0)

				var_242_24.a = Mathf.Lerp(1, 0, var_242_23)
				arg_239_1.mask_.color = var_242_24
			end

			if arg_239_1.time_ >= var_242_21 + var_242_22 and arg_239_1.time_ < var_242_21 + var_242_22 + arg_242_0 then
				local var_242_25 = Color.New(0, 0, 0)
				local var_242_26 = 0

				arg_239_1.mask_.enabled = false
				var_242_25.a = var_242_26
				arg_239_1.mask_.color = var_242_25
			end

			local var_242_27 = "1033ui_story"

			if arg_239_1.actors_[var_242_27] == nil then
				local var_242_28 = Asset.Load("Char/" .. "1033ui_story")

				if not isNil(var_242_28) then
					local var_242_29 = Object.Instantiate(Asset.Load("Char/" .. "1033ui_story"), arg_239_1.stage_.transform)

					var_242_29.name = var_242_27
					var_242_29.transform.localPosition = Vector3.New(0, 100, 0)
					arg_239_1.actors_[var_242_27] = var_242_29

					local var_242_30 = var_242_29:GetComponentInChildren(typeof(CharacterEffect))

					var_242_30.enabled = true

					local var_242_31 = GameObjectTools.GetOrAddComponent(var_242_29, typeof(DynamicBoneHelper))

					if var_242_31 then
						var_242_31:EnableDynamicBone(false)
					end

					arg_239_1:ShowWeapon(var_242_30.transform, false)

					arg_239_1.var_[var_242_27 .. "Animator"] = var_242_30.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_239_1.var_[var_242_27 .. "Animator"].applyRootMotion = true
					arg_239_1.var_[var_242_27 .. "LipSync"] = var_242_30.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_242_32 = arg_239_1.actors_["1033ui_story"].transform
			local var_242_33 = 4

			if var_242_33 < arg_239_1.time_ and arg_239_1.time_ <= var_242_33 + arg_242_0 then
				arg_239_1.var_.moveOldPos1033ui_story = var_242_32.localPosition
			end

			local var_242_34 = 0.001

			if var_242_33 <= arg_239_1.time_ and arg_239_1.time_ < var_242_33 + var_242_34 then
				local var_242_35 = (arg_239_1.time_ - var_242_33) / var_242_34
				local var_242_36 = Vector3.New(-0.7, -1.01, -6.13)

				var_242_32.localPosition = Vector3.Lerp(arg_239_1.var_.moveOldPos1033ui_story, var_242_36, var_242_35)

				local var_242_37 = manager.ui.mainCamera.transform.position - var_242_32.position

				var_242_32.forward = Vector3.New(var_242_37.x, var_242_37.y, var_242_37.z)

				local var_242_38 = var_242_32.localEulerAngles

				var_242_38.z = 0
				var_242_38.x = 0
				var_242_32.localEulerAngles = var_242_38
			end

			if arg_239_1.time_ >= var_242_33 + var_242_34 and arg_239_1.time_ < var_242_33 + var_242_34 + arg_242_0 then
				var_242_32.localPosition = Vector3.New(-0.7, -1.01, -6.13)

				local var_242_39 = manager.ui.mainCamera.transform.position - var_242_32.position

				var_242_32.forward = Vector3.New(var_242_39.x, var_242_39.y, var_242_39.z)

				local var_242_40 = var_242_32.localEulerAngles

				var_242_40.z = 0
				var_242_40.x = 0
				var_242_32.localEulerAngles = var_242_40
			end

			local var_242_41 = "1066ui_story"

			if arg_239_1.actors_[var_242_41] == nil then
				local var_242_42 = Asset.Load("Char/" .. "1066ui_story")

				if not isNil(var_242_42) then
					local var_242_43 = Object.Instantiate(Asset.Load("Char/" .. "1066ui_story"), arg_239_1.stage_.transform)

					var_242_43.name = var_242_41
					var_242_43.transform.localPosition = Vector3.New(0, 100, 0)
					arg_239_1.actors_[var_242_41] = var_242_43

					local var_242_44 = var_242_43:GetComponentInChildren(typeof(CharacterEffect))

					var_242_44.enabled = true

					local var_242_45 = GameObjectTools.GetOrAddComponent(var_242_43, typeof(DynamicBoneHelper))

					if var_242_45 then
						var_242_45:EnableDynamicBone(false)
					end

					arg_239_1:ShowWeapon(var_242_44.transform, false)

					arg_239_1.var_[var_242_41 .. "Animator"] = var_242_44.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_239_1.var_[var_242_41 .. "Animator"].applyRootMotion = true
					arg_239_1.var_[var_242_41 .. "LipSync"] = var_242_44.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_242_46 = arg_239_1.actors_["1066ui_story"].transform
			local var_242_47 = 4

			if var_242_47 < arg_239_1.time_ and arg_239_1.time_ <= var_242_47 + arg_242_0 then
				arg_239_1.var_.moveOldPos1066ui_story = var_242_46.localPosition
			end

			local var_242_48 = 0.001

			if var_242_47 <= arg_239_1.time_ and arg_239_1.time_ < var_242_47 + var_242_48 then
				local var_242_49 = (arg_239_1.time_ - var_242_47) / var_242_48
				local var_242_50 = Vector3.New(0.7, -0.77, -6.1)

				var_242_46.localPosition = Vector3.Lerp(arg_239_1.var_.moveOldPos1066ui_story, var_242_50, var_242_49)

				local var_242_51 = manager.ui.mainCamera.transform.position - var_242_46.position

				var_242_46.forward = Vector3.New(var_242_51.x, var_242_51.y, var_242_51.z)

				local var_242_52 = var_242_46.localEulerAngles

				var_242_52.z = 0
				var_242_52.x = 0
				var_242_46.localEulerAngles = var_242_52
			end

			if arg_239_1.time_ >= var_242_47 + var_242_48 and arg_239_1.time_ < var_242_47 + var_242_48 + arg_242_0 then
				var_242_46.localPosition = Vector3.New(0.7, -0.77, -6.1)

				local var_242_53 = manager.ui.mainCamera.transform.position - var_242_46.position

				var_242_46.forward = Vector3.New(var_242_53.x, var_242_53.y, var_242_53.z)

				local var_242_54 = var_242_46.localEulerAngles

				var_242_54.z = 0
				var_242_54.x = 0
				var_242_46.localEulerAngles = var_242_54
			end

			local var_242_55 = arg_239_1.actors_["1033ui_story"]
			local var_242_56 = 4

			if var_242_56 < arg_239_1.time_ and arg_239_1.time_ <= var_242_56 + arg_242_0 and not isNil(var_242_55) and arg_239_1.var_.characterEffect1033ui_story == nil then
				arg_239_1.var_.characterEffect1033ui_story = var_242_55:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_242_57 = 0.034000001847744

			if var_242_56 <= arg_239_1.time_ and arg_239_1.time_ < var_242_56 + var_242_57 and not isNil(var_242_55) then
				local var_242_58 = (arg_239_1.time_ - var_242_56) / var_242_57

				if arg_239_1.var_.characterEffect1033ui_story and not isNil(var_242_55) then
					local var_242_59 = Mathf.Lerp(0, 0.5, var_242_58)

					arg_239_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_239_1.var_.characterEffect1033ui_story.fillRatio = var_242_59
				end
			end

			if arg_239_1.time_ >= var_242_56 + var_242_57 and arg_239_1.time_ < var_242_56 + var_242_57 + arg_242_0 and not isNil(var_242_55) and arg_239_1.var_.characterEffect1033ui_story then
				local var_242_60 = 0.5

				arg_239_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_239_1.var_.characterEffect1033ui_story.fillRatio = var_242_60
			end

			local var_242_61 = 4

			if var_242_61 < arg_239_1.time_ and arg_239_1.time_ <= var_242_61 + arg_242_0 then
				arg_239_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action2_1")
			end

			local var_242_62 = 4

			if var_242_62 < arg_239_1.time_ and arg_239_1.time_ <= var_242_62 + arg_242_0 then
				arg_239_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action1_1")
			end

			local var_242_63 = arg_239_1.actors_["1066ui_story"]
			local var_242_64 = 4

			if var_242_64 < arg_239_1.time_ and arg_239_1.time_ <= var_242_64 + arg_242_0 and not isNil(var_242_63) and arg_239_1.var_.characterEffect1066ui_story == nil then
				arg_239_1.var_.characterEffect1066ui_story = var_242_63:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_242_65 = 0.034000001847744

			if var_242_64 <= arg_239_1.time_ and arg_239_1.time_ < var_242_64 + var_242_65 and not isNil(var_242_63) then
				local var_242_66 = (arg_239_1.time_ - var_242_64) / var_242_65

				if arg_239_1.var_.characterEffect1066ui_story and not isNil(var_242_63) then
					local var_242_67 = Mathf.Lerp(0, 0.5, var_242_66)

					arg_239_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_239_1.var_.characterEffect1066ui_story.fillRatio = var_242_67
				end
			end

			if arg_239_1.time_ >= var_242_64 + var_242_65 and arg_239_1.time_ < var_242_64 + var_242_65 + arg_242_0 and not isNil(var_242_63) and arg_239_1.var_.characterEffect1066ui_story then
				local var_242_68 = 0.5

				arg_239_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_239_1.var_.characterEffect1066ui_story.fillRatio = var_242_68
			end

			if arg_239_1.frameCnt_ <= 1 then
				arg_239_1.dialog_:SetActive(false)
			end

			local var_242_69 = 4
			local var_242_70 = 0.8

			if var_242_69 < arg_239_1.time_ and arg_239_1.time_ <= var_242_69 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0

				arg_239_1.dialog_:SetActive(true)

				arg_239_1.dialogCg_.alpha = 0

				local var_242_71 = LeanTween.value(arg_239_1.dialog_, 0, 1, 0.3)

				var_242_71:setOnUpdate(LuaHelper.FloatAction(function(arg_243_0)
					arg_239_1.dialogCg_.alpha = arg_243_0
				end))
				var_242_71:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_239_1.dialog_)
					var_242_71:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_239_1.duration_ = arg_239_1.duration_ + 0.3

				SetActive(arg_239_1.leftNameGo_, true)

				local var_242_72 = arg_239_1:FormatText(StoryNameCfg[7].name)

				arg_239_1.leftNameTxt_.text = var_242_72

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, true)
				arg_239_1.iconController_:SetSelectedState("hero")

				arg_239_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_239_1.callingController_:SetSelectedState("normal")

				arg_239_1.keyicon_.color = Color.New(1, 1, 1)
				arg_239_1.icon_.color = Color.New(1, 1, 1)

				local var_242_73 = arg_239_1:GetWordFromCfg(1101105058)
				local var_242_74 = arg_239_1:FormatText(var_242_73.content)

				arg_239_1.text_.text = var_242_74

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_75 = 32
				local var_242_76 = utf8.len(var_242_74)
				local var_242_77 = var_242_75 <= 0 and var_242_70 or var_242_70 * (var_242_76 / var_242_75)

				if var_242_77 > 0 and var_242_70 < var_242_77 then
					arg_239_1.talkMaxDuration = var_242_77
					var_242_69 = var_242_69 + 0.3

					if var_242_77 + var_242_69 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_77 + var_242_69
					end
				end

				arg_239_1.text_.text = var_242_74
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)
				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_78 = var_242_69 + 0.3
			local var_242_79 = math.max(var_242_70, arg_239_1.talkMaxDuration)

			if var_242_78 <= arg_239_1.time_ and arg_239_1.time_ < var_242_78 + var_242_79 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_78) / var_242_79

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_78 + var_242_79 and arg_239_1.time_ < var_242_78 + var_242_79 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_239_1:InitPlayNodeList()
	end,
	Play1101105059 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 1101105059
		arg_245_1.duration_ = 11.4

		local var_245_0 = {
			zh = 8.266,
			ja = 11.4
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
				arg_245_0:Play1101105060(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = arg_245_1.actors_["1033ui_story"].transform
			local var_248_1 = 0

			if var_248_1 < arg_245_1.time_ and arg_245_1.time_ <= var_248_1 + arg_248_0 then
				arg_245_1.var_.moveOldPos1033ui_story = var_248_0.localPosition
			end

			local var_248_2 = 0.001

			if var_248_1 <= arg_245_1.time_ and arg_245_1.time_ < var_248_1 + var_248_2 then
				local var_248_3 = (arg_245_1.time_ - var_248_1) / var_248_2
				local var_248_4 = Vector3.New(-0.7, -1.01, -6.13)

				var_248_0.localPosition = Vector3.Lerp(arg_245_1.var_.moveOldPos1033ui_story, var_248_4, var_248_3)

				local var_248_5 = manager.ui.mainCamera.transform.position - var_248_0.position

				var_248_0.forward = Vector3.New(var_248_5.x, var_248_5.y, var_248_5.z)

				local var_248_6 = var_248_0.localEulerAngles

				var_248_6.z = 0
				var_248_6.x = 0
				var_248_0.localEulerAngles = var_248_6
			end

			if arg_245_1.time_ >= var_248_1 + var_248_2 and arg_245_1.time_ < var_248_1 + var_248_2 + arg_248_0 then
				var_248_0.localPosition = Vector3.New(-0.7, -1.01, -6.13)

				local var_248_7 = manager.ui.mainCamera.transform.position - var_248_0.position

				var_248_0.forward = Vector3.New(var_248_7.x, var_248_7.y, var_248_7.z)

				local var_248_8 = var_248_0.localEulerAngles

				var_248_8.z = 0
				var_248_8.x = 0
				var_248_0.localEulerAngles = var_248_8
			end

			local var_248_9 = arg_245_1.actors_["1033ui_story"]
			local var_248_10 = 0

			if var_248_10 < arg_245_1.time_ and arg_245_1.time_ <= var_248_10 + arg_248_0 and not isNil(var_248_9) and arg_245_1.var_.characterEffect1033ui_story == nil then
				arg_245_1.var_.characterEffect1033ui_story = var_248_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_11 = 0.200000002980232

			if var_248_10 <= arg_245_1.time_ and arg_245_1.time_ < var_248_10 + var_248_11 and not isNil(var_248_9) then
				local var_248_12 = (arg_245_1.time_ - var_248_10) / var_248_11

				if arg_245_1.var_.characterEffect1033ui_story and not isNil(var_248_9) then
					arg_245_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_245_1.time_ >= var_248_10 + var_248_11 and arg_245_1.time_ < var_248_10 + var_248_11 + arg_248_0 and not isNil(var_248_9) and arg_245_1.var_.characterEffect1033ui_story then
				arg_245_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_248_13 = 0

			if var_248_13 < arg_245_1.time_ and arg_245_1.time_ <= var_248_13 + arg_248_0 then
				arg_245_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_248_14 = arg_245_1.actors_["1066ui_story"].transform
			local var_248_15 = 0

			if var_248_15 < arg_245_1.time_ and arg_245_1.time_ <= var_248_15 + arg_248_0 then
				arg_245_1.var_.moveOldPos1066ui_story = var_248_14.localPosition
			end

			local var_248_16 = 0.001

			if var_248_15 <= arg_245_1.time_ and arg_245_1.time_ < var_248_15 + var_248_16 then
				local var_248_17 = (arg_245_1.time_ - var_248_15) / var_248_16
				local var_248_18 = Vector3.New(0.7, -0.77, -6.1)

				var_248_14.localPosition = Vector3.Lerp(arg_245_1.var_.moveOldPos1066ui_story, var_248_18, var_248_17)

				local var_248_19 = manager.ui.mainCamera.transform.position - var_248_14.position

				var_248_14.forward = Vector3.New(var_248_19.x, var_248_19.y, var_248_19.z)

				local var_248_20 = var_248_14.localEulerAngles

				var_248_20.z = 0
				var_248_20.x = 0
				var_248_14.localEulerAngles = var_248_20
			end

			if arg_245_1.time_ >= var_248_15 + var_248_16 and arg_245_1.time_ < var_248_15 + var_248_16 + arg_248_0 then
				var_248_14.localPosition = Vector3.New(0.7, -0.77, -6.1)

				local var_248_21 = manager.ui.mainCamera.transform.position - var_248_14.position

				var_248_14.forward = Vector3.New(var_248_21.x, var_248_21.y, var_248_21.z)

				local var_248_22 = var_248_14.localEulerAngles

				var_248_22.z = 0
				var_248_22.x = 0
				var_248_14.localEulerAngles = var_248_22
			end

			local var_248_23 = 0
			local var_248_24 = 1.05

			if var_248_23 < arg_245_1.time_ and arg_245_1.time_ <= var_248_23 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				local var_248_25 = arg_245_1:FormatText(StoryNameCfg[236].name)

				arg_245_1.leftNameTxt_.text = var_248_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_26 = arg_245_1:GetWordFromCfg(1101105059)
				local var_248_27 = arg_245_1:FormatText(var_248_26.content)

				arg_245_1.text_.text = var_248_27

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_28 = 42
				local var_248_29 = utf8.len(var_248_27)
				local var_248_30 = var_248_28 <= 0 and var_248_24 or var_248_24 * (var_248_29 / var_248_28)

				if var_248_30 > 0 and var_248_24 < var_248_30 then
					arg_245_1.talkMaxDuration = var_248_30

					if var_248_30 + var_248_23 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_30 + var_248_23
					end
				end

				arg_245_1.text_.text = var_248_27
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105059", "story_v_side_new_1101105.awb") ~= 0 then
					local var_248_31 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105059", "story_v_side_new_1101105.awb") / 1000

					if var_248_31 + var_248_23 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_31 + var_248_23
					end

					if var_248_26.prefab_name ~= "" and arg_245_1.actors_[var_248_26.prefab_name] ~= nil then
						local var_248_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_26.prefab_name].transform, "story_v_side_new_1101105", "1101105059", "story_v_side_new_1101105.awb")

						arg_245_1:RecordAudio("1101105059", var_248_32)
						arg_245_1:RecordAudio("1101105059", var_248_32)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105059", "story_v_side_new_1101105.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105059", "story_v_side_new_1101105.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_33 = math.max(var_248_24, arg_245_1.talkMaxDuration)

			if var_248_23 <= arg_245_1.time_ and arg_245_1.time_ < var_248_23 + var_248_33 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_23) / var_248_33

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_23 + var_248_33 and arg_245_1.time_ < var_248_23 + var_248_33 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_245_1:InitPlayNodeList()
	end,
	Play1101105060 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 1101105060
		arg_249_1.duration_ = 8.57

		local var_249_0 = {
			zh = 5.133,
			ja = 8.566
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
				arg_249_0:Play1101105061(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = 0

			if var_252_0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_0 + arg_252_0 then
				arg_249_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_252_1 = 0
			local var_252_2 = 0.675

			if var_252_1 < arg_249_1.time_ and arg_249_1.time_ <= var_252_1 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				local var_252_3 = arg_249_1:FormatText(StoryNameCfg[236].name)

				arg_249_1.leftNameTxt_.text = var_252_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_4 = arg_249_1:GetWordFromCfg(1101105060)
				local var_252_5 = arg_249_1:FormatText(var_252_4.content)

				arg_249_1.text_.text = var_252_5

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_6 = 27
				local var_252_7 = utf8.len(var_252_5)
				local var_252_8 = var_252_6 <= 0 and var_252_2 or var_252_2 * (var_252_7 / var_252_6)

				if var_252_8 > 0 and var_252_2 < var_252_8 then
					arg_249_1.talkMaxDuration = var_252_8

					if var_252_8 + var_252_1 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_8 + var_252_1
					end
				end

				arg_249_1.text_.text = var_252_5
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105060", "story_v_side_new_1101105.awb") ~= 0 then
					local var_252_9 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105060", "story_v_side_new_1101105.awb") / 1000

					if var_252_9 + var_252_1 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_9 + var_252_1
					end

					if var_252_4.prefab_name ~= "" and arg_249_1.actors_[var_252_4.prefab_name] ~= nil then
						local var_252_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_4.prefab_name].transform, "story_v_side_new_1101105", "1101105060", "story_v_side_new_1101105.awb")

						arg_249_1:RecordAudio("1101105060", var_252_10)
						arg_249_1:RecordAudio("1101105060", var_252_10)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105060", "story_v_side_new_1101105.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105060", "story_v_side_new_1101105.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_11 = math.max(var_252_2, arg_249_1.talkMaxDuration)

			if var_252_1 <= arg_249_1.time_ and arg_249_1.time_ < var_252_1 + var_252_11 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_1) / var_252_11

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_1 + var_252_11 and arg_249_1.time_ < var_252_1 + var_252_11 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play1101105061 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 1101105061
		arg_253_1.duration_ = 4.87

		local var_253_0 = {
			zh = 4.8,
			ja = 4.866
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
				arg_253_0:Play1101105062(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = arg_253_1.actors_["1066ui_story"].transform
			local var_256_1 = 0

			if var_256_1 < arg_253_1.time_ and arg_253_1.time_ <= var_256_1 + arg_256_0 then
				arg_253_1.var_.moveOldPos1066ui_story = var_256_0.localPosition
			end

			local var_256_2 = 0.001

			if var_256_1 <= arg_253_1.time_ and arg_253_1.time_ < var_256_1 + var_256_2 then
				local var_256_3 = (arg_253_1.time_ - var_256_1) / var_256_2
				local var_256_4 = Vector3.New(0.7, -0.77, -6.1)

				var_256_0.localPosition = Vector3.Lerp(arg_253_1.var_.moveOldPos1066ui_story, var_256_4, var_256_3)

				local var_256_5 = manager.ui.mainCamera.transform.position - var_256_0.position

				var_256_0.forward = Vector3.New(var_256_5.x, var_256_5.y, var_256_5.z)

				local var_256_6 = var_256_0.localEulerAngles

				var_256_6.z = 0
				var_256_6.x = 0
				var_256_0.localEulerAngles = var_256_6
			end

			if arg_253_1.time_ >= var_256_1 + var_256_2 and arg_253_1.time_ < var_256_1 + var_256_2 + arg_256_0 then
				var_256_0.localPosition = Vector3.New(0.7, -0.77, -6.1)

				local var_256_7 = manager.ui.mainCamera.transform.position - var_256_0.position

				var_256_0.forward = Vector3.New(var_256_7.x, var_256_7.y, var_256_7.z)

				local var_256_8 = var_256_0.localEulerAngles

				var_256_8.z = 0
				var_256_8.x = 0
				var_256_0.localEulerAngles = var_256_8
			end

			local var_256_9 = arg_253_1.actors_["1066ui_story"]
			local var_256_10 = 0

			if var_256_10 < arg_253_1.time_ and arg_253_1.time_ <= var_256_10 + arg_256_0 and not isNil(var_256_9) and arg_253_1.var_.characterEffect1066ui_story == nil then
				arg_253_1.var_.characterEffect1066ui_story = var_256_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_11 = 0.200000002980232

			if var_256_10 <= arg_253_1.time_ and arg_253_1.time_ < var_256_10 + var_256_11 and not isNil(var_256_9) then
				local var_256_12 = (arg_253_1.time_ - var_256_10) / var_256_11

				if arg_253_1.var_.characterEffect1066ui_story and not isNil(var_256_9) then
					arg_253_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_253_1.time_ >= var_256_10 + var_256_11 and arg_253_1.time_ < var_256_10 + var_256_11 + arg_256_0 and not isNil(var_256_9) and arg_253_1.var_.characterEffect1066ui_story then
				arg_253_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_256_13 = 0

			if var_256_13 < arg_253_1.time_ and arg_253_1.time_ <= var_256_13 + arg_256_0 then
				arg_253_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action3_1")
			end

			local var_256_14 = 0

			if var_256_14 < arg_253_1.time_ and arg_253_1.time_ <= var_256_14 + arg_256_0 then
				arg_253_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_256_15 = arg_253_1.actors_["1033ui_story"]
			local var_256_16 = 0

			if var_256_16 < arg_253_1.time_ and arg_253_1.time_ <= var_256_16 + arg_256_0 and not isNil(var_256_15) and arg_253_1.var_.characterEffect1033ui_story == nil then
				arg_253_1.var_.characterEffect1033ui_story = var_256_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_17 = 0.200000002980232

			if var_256_16 <= arg_253_1.time_ and arg_253_1.time_ < var_256_16 + var_256_17 and not isNil(var_256_15) then
				local var_256_18 = (arg_253_1.time_ - var_256_16) / var_256_17

				if arg_253_1.var_.characterEffect1033ui_story and not isNil(var_256_15) then
					local var_256_19 = Mathf.Lerp(0, 0.5, var_256_18)

					arg_253_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_253_1.var_.characterEffect1033ui_story.fillRatio = var_256_19
				end
			end

			if arg_253_1.time_ >= var_256_16 + var_256_17 and arg_253_1.time_ < var_256_16 + var_256_17 + arg_256_0 and not isNil(var_256_15) and arg_253_1.var_.characterEffect1033ui_story then
				local var_256_20 = 0.5

				arg_253_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_253_1.var_.characterEffect1033ui_story.fillRatio = var_256_20
			end

			local var_256_21 = 0
			local var_256_22 = 0.525

			if var_256_21 < arg_253_1.time_ and arg_253_1.time_ <= var_256_21 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				local var_256_23 = arg_253_1:FormatText(StoryNameCfg[32].name)

				arg_253_1.leftNameTxt_.text = var_256_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_24 = arg_253_1:GetWordFromCfg(1101105061)
				local var_256_25 = arg_253_1:FormatText(var_256_24.content)

				arg_253_1.text_.text = var_256_25

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_26 = 21
				local var_256_27 = utf8.len(var_256_25)
				local var_256_28 = var_256_26 <= 0 and var_256_22 or var_256_22 * (var_256_27 / var_256_26)

				if var_256_28 > 0 and var_256_22 < var_256_28 then
					arg_253_1.talkMaxDuration = var_256_28

					if var_256_28 + var_256_21 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_28 + var_256_21
					end
				end

				arg_253_1.text_.text = var_256_25
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105061", "story_v_side_new_1101105.awb") ~= 0 then
					local var_256_29 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105061", "story_v_side_new_1101105.awb") / 1000

					if var_256_29 + var_256_21 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_29 + var_256_21
					end

					if var_256_24.prefab_name ~= "" and arg_253_1.actors_[var_256_24.prefab_name] ~= nil then
						local var_256_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_24.prefab_name].transform, "story_v_side_new_1101105", "1101105061", "story_v_side_new_1101105.awb")

						arg_253_1:RecordAudio("1101105061", var_256_30)
						arg_253_1:RecordAudio("1101105061", var_256_30)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105061", "story_v_side_new_1101105.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105061", "story_v_side_new_1101105.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_31 = math.max(var_256_22, arg_253_1.talkMaxDuration)

			if var_256_21 <= arg_253_1.time_ and arg_253_1.time_ < var_256_21 + var_256_31 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_21) / var_256_31

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_21 + var_256_31 and arg_253_1.time_ < var_256_21 + var_256_31 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_253_1:InitPlayNodeList()
	end,
	Play1101105062 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 1101105062
		arg_257_1.duration_ = 14.4

		local var_257_0 = {
			zh = 11.633,
			ja = 14.4
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
				arg_257_0:Play1101105063(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = 0
			local var_260_1 = 1.25

			if var_260_0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_0 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				local var_260_2 = arg_257_1:FormatText(StoryNameCfg[32].name)

				arg_257_1.leftNameTxt_.text = var_260_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_3 = arg_257_1:GetWordFromCfg(1101105062)
				local var_260_4 = arg_257_1:FormatText(var_260_3.content)

				arg_257_1.text_.text = var_260_4

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_5 = 50
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

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105062", "story_v_side_new_1101105.awb") ~= 0 then
					local var_260_8 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105062", "story_v_side_new_1101105.awb") / 1000

					if var_260_8 + var_260_0 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_8 + var_260_0
					end

					if var_260_3.prefab_name ~= "" and arg_257_1.actors_[var_260_3.prefab_name] ~= nil then
						local var_260_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_3.prefab_name].transform, "story_v_side_new_1101105", "1101105062", "story_v_side_new_1101105.awb")

						arg_257_1:RecordAudio("1101105062", var_260_9)
						arg_257_1:RecordAudio("1101105062", var_260_9)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105062", "story_v_side_new_1101105.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105062", "story_v_side_new_1101105.awb")
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
	Play1101105063 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 1101105063
		arg_261_1.duration_ = 5

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play1101105064(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = arg_261_1.actors_["1066ui_story"]
			local var_264_1 = 0

			if var_264_1 < arg_261_1.time_ and arg_261_1.time_ <= var_264_1 + arg_264_0 and not isNil(var_264_0) and arg_261_1.var_.characterEffect1066ui_story == nil then
				arg_261_1.var_.characterEffect1066ui_story = var_264_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_2 = 0.200000002980232

			if var_264_1 <= arg_261_1.time_ and arg_261_1.time_ < var_264_1 + var_264_2 and not isNil(var_264_0) then
				local var_264_3 = (arg_261_1.time_ - var_264_1) / var_264_2

				if arg_261_1.var_.characterEffect1066ui_story and not isNil(var_264_0) then
					local var_264_4 = Mathf.Lerp(0, 0.5, var_264_3)

					arg_261_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_261_1.var_.characterEffect1066ui_story.fillRatio = var_264_4
				end
			end

			if arg_261_1.time_ >= var_264_1 + var_264_2 and arg_261_1.time_ < var_264_1 + var_264_2 + arg_264_0 and not isNil(var_264_0) and arg_261_1.var_.characterEffect1066ui_story then
				local var_264_5 = 0.5

				arg_261_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_261_1.var_.characterEffect1066ui_story.fillRatio = var_264_5
			end

			local var_264_6 = 0
			local var_264_7 = 0.45

			if var_264_6 < arg_261_1.time_ and arg_261_1.time_ <= var_264_6 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, false)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_8 = arg_261_1:GetWordFromCfg(1101105063)
				local var_264_9 = arg_261_1:FormatText(var_264_8.content)

				arg_261_1.text_.text = var_264_9

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_10 = 18
				local var_264_11 = utf8.len(var_264_9)
				local var_264_12 = var_264_10 <= 0 and var_264_7 or var_264_7 * (var_264_11 / var_264_10)

				if var_264_12 > 0 and var_264_7 < var_264_12 then
					arg_261_1.talkMaxDuration = var_264_12

					if var_264_12 + var_264_6 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_12 + var_264_6
					end
				end

				arg_261_1.text_.text = var_264_9
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)
				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_13 = math.max(var_264_7, arg_261_1.talkMaxDuration)

			if var_264_6 <= arg_261_1.time_ and arg_261_1.time_ < var_264_6 + var_264_13 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_6) / var_264_13

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_6 + var_264_13 and arg_261_1.time_ < var_264_6 + var_264_13 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play1101105064 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 1101105064
		arg_265_1.duration_ = 4.63

		local var_265_0 = {
			zh = 4.633,
			ja = 4.4
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
				arg_265_0:Play1101105065(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = arg_265_1.actors_["1033ui_story"].transform
			local var_268_1 = 0

			if var_268_1 < arg_265_1.time_ and arg_265_1.time_ <= var_268_1 + arg_268_0 then
				arg_265_1.var_.moveOldPos1033ui_story = var_268_0.localPosition
			end

			local var_268_2 = 0.001

			if var_268_1 <= arg_265_1.time_ and arg_265_1.time_ < var_268_1 + var_268_2 then
				local var_268_3 = (arg_265_1.time_ - var_268_1) / var_268_2
				local var_268_4 = Vector3.New(0, 100, 0)

				var_268_0.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos1033ui_story, var_268_4, var_268_3)

				local var_268_5 = manager.ui.mainCamera.transform.position - var_268_0.position

				var_268_0.forward = Vector3.New(var_268_5.x, var_268_5.y, var_268_5.z)

				local var_268_6 = var_268_0.localEulerAngles

				var_268_6.z = 0
				var_268_6.x = 0
				var_268_0.localEulerAngles = var_268_6
			end

			if arg_265_1.time_ >= var_268_1 + var_268_2 and arg_265_1.time_ < var_268_1 + var_268_2 + arg_268_0 then
				var_268_0.localPosition = Vector3.New(0, 100, 0)

				local var_268_7 = manager.ui.mainCamera.transform.position - var_268_0.position

				var_268_0.forward = Vector3.New(var_268_7.x, var_268_7.y, var_268_7.z)

				local var_268_8 = var_268_0.localEulerAngles

				var_268_8.z = 0
				var_268_8.x = 0
				var_268_0.localEulerAngles = var_268_8
			end

			local var_268_9 = arg_265_1.actors_["1066ui_story"].transform
			local var_268_10 = 0

			if var_268_10 < arg_265_1.time_ and arg_265_1.time_ <= var_268_10 + arg_268_0 then
				arg_265_1.var_.moveOldPos1066ui_story = var_268_9.localPosition
			end

			local var_268_11 = 0.001

			if var_268_10 <= arg_265_1.time_ and arg_265_1.time_ < var_268_10 + var_268_11 then
				local var_268_12 = (arg_265_1.time_ - var_268_10) / var_268_11
				local var_268_13 = Vector3.New(0, 100, 0)

				var_268_9.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos1066ui_story, var_268_13, var_268_12)

				local var_268_14 = manager.ui.mainCamera.transform.position - var_268_9.position

				var_268_9.forward = Vector3.New(var_268_14.x, var_268_14.y, var_268_14.z)

				local var_268_15 = var_268_9.localEulerAngles

				var_268_15.z = 0
				var_268_15.x = 0
				var_268_9.localEulerAngles = var_268_15
			end

			if arg_265_1.time_ >= var_268_10 + var_268_11 and arg_265_1.time_ < var_268_10 + var_268_11 + arg_268_0 then
				var_268_9.localPosition = Vector3.New(0, 100, 0)

				local var_268_16 = manager.ui.mainCamera.transform.position - var_268_9.position

				var_268_9.forward = Vector3.New(var_268_16.x, var_268_16.y, var_268_16.z)

				local var_268_17 = var_268_9.localEulerAngles

				var_268_17.z = 0
				var_268_17.x = 0
				var_268_9.localEulerAngles = var_268_17
			end

			local var_268_18 = arg_265_1.actors_["1011ui_story"].transform
			local var_268_19 = 0

			if var_268_19 < arg_265_1.time_ and arg_265_1.time_ <= var_268_19 + arg_268_0 then
				arg_265_1.var_.moveOldPos1011ui_story = var_268_18.localPosition
			end

			local var_268_20 = 0.001

			if var_268_19 <= arg_265_1.time_ and arg_265_1.time_ < var_268_19 + var_268_20 then
				local var_268_21 = (arg_265_1.time_ - var_268_19) / var_268_20
				local var_268_22 = Vector3.New(0, -0.71, -6)

				var_268_18.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos1011ui_story, var_268_22, var_268_21)

				local var_268_23 = manager.ui.mainCamera.transform.position - var_268_18.position

				var_268_18.forward = Vector3.New(var_268_23.x, var_268_23.y, var_268_23.z)

				local var_268_24 = var_268_18.localEulerAngles

				var_268_24.z = 0
				var_268_24.x = 0
				var_268_18.localEulerAngles = var_268_24
			end

			if arg_265_1.time_ >= var_268_19 + var_268_20 and arg_265_1.time_ < var_268_19 + var_268_20 + arg_268_0 then
				var_268_18.localPosition = Vector3.New(0, -0.71, -6)

				local var_268_25 = manager.ui.mainCamera.transform.position - var_268_18.position

				var_268_18.forward = Vector3.New(var_268_25.x, var_268_25.y, var_268_25.z)

				local var_268_26 = var_268_18.localEulerAngles

				var_268_26.z = 0
				var_268_26.x = 0
				var_268_18.localEulerAngles = var_268_26
			end

			local var_268_27 = arg_265_1.actors_["1011ui_story"]
			local var_268_28 = 0

			if var_268_28 < arg_265_1.time_ and arg_265_1.time_ <= var_268_28 + arg_268_0 and not isNil(var_268_27) and arg_265_1.var_.characterEffect1011ui_story == nil then
				arg_265_1.var_.characterEffect1011ui_story = var_268_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_29 = 0.200000002980232

			if var_268_28 <= arg_265_1.time_ and arg_265_1.time_ < var_268_28 + var_268_29 and not isNil(var_268_27) then
				local var_268_30 = (arg_265_1.time_ - var_268_28) / var_268_29

				if arg_265_1.var_.characterEffect1011ui_story and not isNil(var_268_27) then
					arg_265_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_265_1.time_ >= var_268_28 + var_268_29 and arg_265_1.time_ < var_268_28 + var_268_29 + arg_268_0 and not isNil(var_268_27) and arg_265_1.var_.characterEffect1011ui_story then
				arg_265_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_268_31 = 0

			if var_268_31 < arg_265_1.time_ and arg_265_1.time_ <= var_268_31 + arg_268_0 then
				arg_265_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action1_1")
			end

			local var_268_32 = 0

			if var_268_32 < arg_265_1.time_ and arg_265_1.time_ <= var_268_32 + arg_268_0 then
				arg_265_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_268_33 = 0
			local var_268_34 = 0.45

			if var_268_33 < arg_265_1.time_ and arg_265_1.time_ <= var_268_33 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				local var_268_35 = arg_265_1:FormatText(StoryNameCfg[37].name)

				arg_265_1.leftNameTxt_.text = var_268_35

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_36 = arg_265_1:GetWordFromCfg(1101105064)
				local var_268_37 = arg_265_1:FormatText(var_268_36.content)

				arg_265_1.text_.text = var_268_37

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_38 = 18
				local var_268_39 = utf8.len(var_268_37)
				local var_268_40 = var_268_38 <= 0 and var_268_34 or var_268_34 * (var_268_39 / var_268_38)

				if var_268_40 > 0 and var_268_34 < var_268_40 then
					arg_265_1.talkMaxDuration = var_268_40

					if var_268_40 + var_268_33 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_40 + var_268_33
					end
				end

				arg_265_1.text_.text = var_268_37
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105064", "story_v_side_new_1101105.awb") ~= 0 then
					local var_268_41 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105064", "story_v_side_new_1101105.awb") / 1000

					if var_268_41 + var_268_33 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_41 + var_268_33
					end

					if var_268_36.prefab_name ~= "" and arg_265_1.actors_[var_268_36.prefab_name] ~= nil then
						local var_268_42 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_36.prefab_name].transform, "story_v_side_new_1101105", "1101105064", "story_v_side_new_1101105.awb")

						arg_265_1:RecordAudio("1101105064", var_268_42)
						arg_265_1:RecordAudio("1101105064", var_268_42)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105064", "story_v_side_new_1101105.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105064", "story_v_side_new_1101105.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_43 = math.max(var_268_34, arg_265_1.talkMaxDuration)

			if var_268_33 <= arg_265_1.time_ and arg_265_1.time_ < var_268_33 + var_268_43 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_33) / var_268_43

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_33 + var_268_43 and arg_265_1.time_ < var_268_33 + var_268_43 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
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
	Play1101105065 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 1101105065
		arg_269_1.duration_ = 11.17

		local var_269_0 = {
			zh = 6.366,
			ja = 11.166
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
				arg_269_0:Play1101105066(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = arg_269_1.actors_["1011ui_story"].transform
			local var_272_1 = 0

			if var_272_1 < arg_269_1.time_ and arg_269_1.time_ <= var_272_1 + arg_272_0 then
				arg_269_1.var_.moveOldPos1011ui_story = var_272_0.localPosition
			end

			local var_272_2 = 0.001

			if var_272_1 <= arg_269_1.time_ and arg_269_1.time_ < var_272_1 + var_272_2 then
				local var_272_3 = (arg_269_1.time_ - var_272_1) / var_272_2
				local var_272_4 = Vector3.New(0, 100, 0)

				var_272_0.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos1011ui_story, var_272_4, var_272_3)

				local var_272_5 = manager.ui.mainCamera.transform.position - var_272_0.position

				var_272_0.forward = Vector3.New(var_272_5.x, var_272_5.y, var_272_5.z)

				local var_272_6 = var_272_0.localEulerAngles

				var_272_6.z = 0
				var_272_6.x = 0
				var_272_0.localEulerAngles = var_272_6
			end

			if arg_269_1.time_ >= var_272_1 + var_272_2 and arg_269_1.time_ < var_272_1 + var_272_2 + arg_272_0 then
				var_272_0.localPosition = Vector3.New(0, 100, 0)

				local var_272_7 = manager.ui.mainCamera.transform.position - var_272_0.position

				var_272_0.forward = Vector3.New(var_272_7.x, var_272_7.y, var_272_7.z)

				local var_272_8 = var_272_0.localEulerAngles

				var_272_8.z = 0
				var_272_8.x = 0
				var_272_0.localEulerAngles = var_272_8
			end

			local var_272_9 = arg_269_1.actors_["1011ui_story"]
			local var_272_10 = 0

			if var_272_10 < arg_269_1.time_ and arg_269_1.time_ <= var_272_10 + arg_272_0 and not isNil(var_272_9) and arg_269_1.var_.characterEffect1011ui_story == nil then
				arg_269_1.var_.characterEffect1011ui_story = var_272_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_11 = 0.200000002980232

			if var_272_10 <= arg_269_1.time_ and arg_269_1.time_ < var_272_10 + var_272_11 and not isNil(var_272_9) then
				local var_272_12 = (arg_269_1.time_ - var_272_10) / var_272_11

				if arg_269_1.var_.characterEffect1011ui_story and not isNil(var_272_9) then
					local var_272_13 = Mathf.Lerp(0, 0.5, var_272_12)

					arg_269_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_269_1.var_.characterEffect1011ui_story.fillRatio = var_272_13
				end
			end

			if arg_269_1.time_ >= var_272_10 + var_272_11 and arg_269_1.time_ < var_272_10 + var_272_11 + arg_272_0 and not isNil(var_272_9) and arg_269_1.var_.characterEffect1011ui_story then
				local var_272_14 = 0.5

				arg_269_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_269_1.var_.characterEffect1011ui_story.fillRatio = var_272_14
			end

			local var_272_15 = arg_269_1.actors_["1066ui_story"].transform
			local var_272_16 = 0

			if var_272_16 < arg_269_1.time_ and arg_269_1.time_ <= var_272_16 + arg_272_0 then
				arg_269_1.var_.moveOldPos1066ui_story = var_272_15.localPosition
			end

			local var_272_17 = 0.001

			if var_272_16 <= arg_269_1.time_ and arg_269_1.time_ < var_272_16 + var_272_17 then
				local var_272_18 = (arg_269_1.time_ - var_272_16) / var_272_17
				local var_272_19 = Vector3.New(-0.7, -0.77, -6.1)

				var_272_15.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos1066ui_story, var_272_19, var_272_18)

				local var_272_20 = manager.ui.mainCamera.transform.position - var_272_15.position

				var_272_15.forward = Vector3.New(var_272_20.x, var_272_20.y, var_272_20.z)

				local var_272_21 = var_272_15.localEulerAngles

				var_272_21.z = 0
				var_272_21.x = 0
				var_272_15.localEulerAngles = var_272_21
			end

			if arg_269_1.time_ >= var_272_16 + var_272_17 and arg_269_1.time_ < var_272_16 + var_272_17 + arg_272_0 then
				var_272_15.localPosition = Vector3.New(-0.7, -0.77, -6.1)

				local var_272_22 = manager.ui.mainCamera.transform.position - var_272_15.position

				var_272_15.forward = Vector3.New(var_272_22.x, var_272_22.y, var_272_22.z)

				local var_272_23 = var_272_15.localEulerAngles

				var_272_23.z = 0
				var_272_23.x = 0
				var_272_15.localEulerAngles = var_272_23
			end

			local var_272_24 = arg_269_1.actors_["1066ui_story"]
			local var_272_25 = 0

			if var_272_25 < arg_269_1.time_ and arg_269_1.time_ <= var_272_25 + arg_272_0 and not isNil(var_272_24) and arg_269_1.var_.characterEffect1066ui_story == nil then
				arg_269_1.var_.characterEffect1066ui_story = var_272_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_26 = 0.200000002980232

			if var_272_25 <= arg_269_1.time_ and arg_269_1.time_ < var_272_25 + var_272_26 and not isNil(var_272_24) then
				local var_272_27 = (arg_269_1.time_ - var_272_25) / var_272_26

				if arg_269_1.var_.characterEffect1066ui_story and not isNil(var_272_24) then
					arg_269_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_269_1.time_ >= var_272_25 + var_272_26 and arg_269_1.time_ < var_272_25 + var_272_26 + arg_272_0 and not isNil(var_272_24) and arg_269_1.var_.characterEffect1066ui_story then
				arg_269_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_272_28 = 0

			if var_272_28 < arg_269_1.time_ and arg_269_1.time_ <= var_272_28 + arg_272_0 then
				arg_269_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action8_1")
			end

			local var_272_29 = 0

			if var_272_29 < arg_269_1.time_ and arg_269_1.time_ <= var_272_29 + arg_272_0 then
				arg_269_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_272_30 = arg_269_1.actors_["1033ui_story"].transform
			local var_272_31 = 0

			if var_272_31 < arg_269_1.time_ and arg_269_1.time_ <= var_272_31 + arg_272_0 then
				arg_269_1.var_.moveOldPos1033ui_story = var_272_30.localPosition
			end

			local var_272_32 = 0.001

			if var_272_31 <= arg_269_1.time_ and arg_269_1.time_ < var_272_31 + var_272_32 then
				local var_272_33 = (arg_269_1.time_ - var_272_31) / var_272_32
				local var_272_34 = Vector3.New(0.7, -1.01, -6.13)

				var_272_30.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos1033ui_story, var_272_34, var_272_33)

				local var_272_35 = manager.ui.mainCamera.transform.position - var_272_30.position

				var_272_30.forward = Vector3.New(var_272_35.x, var_272_35.y, var_272_35.z)

				local var_272_36 = var_272_30.localEulerAngles

				var_272_36.z = 0
				var_272_36.x = 0
				var_272_30.localEulerAngles = var_272_36
			end

			if arg_269_1.time_ >= var_272_31 + var_272_32 and arg_269_1.time_ < var_272_31 + var_272_32 + arg_272_0 then
				var_272_30.localPosition = Vector3.New(0.7, -1.01, -6.13)

				local var_272_37 = manager.ui.mainCamera.transform.position - var_272_30.position

				var_272_30.forward = Vector3.New(var_272_37.x, var_272_37.y, var_272_37.z)

				local var_272_38 = var_272_30.localEulerAngles

				var_272_38.z = 0
				var_272_38.x = 0
				var_272_30.localEulerAngles = var_272_38
			end

			local var_272_39 = arg_269_1.actors_["1033ui_story"]
			local var_272_40 = 0

			if var_272_40 < arg_269_1.time_ and arg_269_1.time_ <= var_272_40 + arg_272_0 and not isNil(var_272_39) and arg_269_1.var_.characterEffect1033ui_story == nil then
				arg_269_1.var_.characterEffect1033ui_story = var_272_39:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_41 = 0.200000002980232

			if var_272_40 <= arg_269_1.time_ and arg_269_1.time_ < var_272_40 + var_272_41 and not isNil(var_272_39) then
				local var_272_42 = (arg_269_1.time_ - var_272_40) / var_272_41

				if arg_269_1.var_.characterEffect1033ui_story and not isNil(var_272_39) then
					local var_272_43 = Mathf.Lerp(0, 0.5, var_272_42)

					arg_269_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_269_1.var_.characterEffect1033ui_story.fillRatio = var_272_43
				end
			end

			if arg_269_1.time_ >= var_272_40 + var_272_41 and arg_269_1.time_ < var_272_40 + var_272_41 + arg_272_0 and not isNil(var_272_39) and arg_269_1.var_.characterEffect1033ui_story then
				local var_272_44 = 0.5

				arg_269_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_269_1.var_.characterEffect1033ui_story.fillRatio = var_272_44
			end

			local var_272_45 = 0
			local var_272_46 = 0.75

			if var_272_45 < arg_269_1.time_ and arg_269_1.time_ <= var_272_45 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				local var_272_47 = arg_269_1:FormatText(StoryNameCfg[32].name)

				arg_269_1.leftNameTxt_.text = var_272_47

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_48 = arg_269_1:GetWordFromCfg(1101105065)
				local var_272_49 = arg_269_1:FormatText(var_272_48.content)

				arg_269_1.text_.text = var_272_49

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_50 = 30
				local var_272_51 = utf8.len(var_272_49)
				local var_272_52 = var_272_50 <= 0 and var_272_46 or var_272_46 * (var_272_51 / var_272_50)

				if var_272_52 > 0 and var_272_46 < var_272_52 then
					arg_269_1.talkMaxDuration = var_272_52

					if var_272_52 + var_272_45 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_52 + var_272_45
					end
				end

				arg_269_1.text_.text = var_272_49
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105065", "story_v_side_new_1101105.awb") ~= 0 then
					local var_272_53 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105065", "story_v_side_new_1101105.awb") / 1000

					if var_272_53 + var_272_45 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_53 + var_272_45
					end

					if var_272_48.prefab_name ~= "" and arg_269_1.actors_[var_272_48.prefab_name] ~= nil then
						local var_272_54 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_48.prefab_name].transform, "story_v_side_new_1101105", "1101105065", "story_v_side_new_1101105.awb")

						arg_269_1:RecordAudio("1101105065", var_272_54)
						arg_269_1:RecordAudio("1101105065", var_272_54)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105065", "story_v_side_new_1101105.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105065", "story_v_side_new_1101105.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_55 = math.max(var_272_46, arg_269_1.talkMaxDuration)

			if var_272_45 <= arg_269_1.time_ and arg_269_1.time_ < var_272_45 + var_272_55 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_45) / var_272_55

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_45 + var_272_55 and arg_269_1.time_ < var_272_45 + var_272_55 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_269_1:InitPlayNodeList()
	end,
	Play1101105066 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 1101105066
		arg_273_1.duration_ = 8.1

		local var_273_0 = {
			zh = 5.9,
			ja = 8.1
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
				arg_273_0:Play1101105067(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = arg_273_1.actors_["1066ui_story"]
			local var_276_1 = 0

			if var_276_1 < arg_273_1.time_ and arg_273_1.time_ <= var_276_1 + arg_276_0 and not isNil(var_276_0) and arg_273_1.var_.characterEffect1066ui_story == nil then
				arg_273_1.var_.characterEffect1066ui_story = var_276_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_2 = 0.200000002980232

			if var_276_1 <= arg_273_1.time_ and arg_273_1.time_ < var_276_1 + var_276_2 and not isNil(var_276_0) then
				local var_276_3 = (arg_273_1.time_ - var_276_1) / var_276_2

				if arg_273_1.var_.characterEffect1066ui_story and not isNil(var_276_0) then
					local var_276_4 = Mathf.Lerp(0, 0.5, var_276_3)

					arg_273_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_273_1.var_.characterEffect1066ui_story.fillRatio = var_276_4
				end
			end

			if arg_273_1.time_ >= var_276_1 + var_276_2 and arg_273_1.time_ < var_276_1 + var_276_2 + arg_276_0 and not isNil(var_276_0) and arg_273_1.var_.characterEffect1066ui_story then
				local var_276_5 = 0.5

				arg_273_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_273_1.var_.characterEffect1066ui_story.fillRatio = var_276_5
			end

			local var_276_6 = 0
			local var_276_7 = 0.6

			if var_276_6 < arg_273_1.time_ and arg_273_1.time_ <= var_276_6 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				local var_276_8 = arg_273_1:FormatText(StoryNameCfg[10].name)

				arg_273_1.leftNameTxt_.text = var_276_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, true)
				arg_273_1.iconController_:SetSelectedState("hero")

				arg_273_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_273_1.callingController_:SetSelectedState("normal")

				arg_273_1.keyicon_.color = Color.New(1, 1, 1)
				arg_273_1.icon_.color = Color.New(1, 1, 1)

				local var_276_9 = arg_273_1:GetWordFromCfg(1101105066)
				local var_276_10 = arg_273_1:FormatText(var_276_9.content)

				arg_273_1.text_.text = var_276_10

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_11 = 24
				local var_276_12 = utf8.len(var_276_10)
				local var_276_13 = var_276_11 <= 0 and var_276_7 or var_276_7 * (var_276_12 / var_276_11)

				if var_276_13 > 0 and var_276_7 < var_276_13 then
					arg_273_1.talkMaxDuration = var_276_13

					if var_276_13 + var_276_6 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_13 + var_276_6
					end
				end

				arg_273_1.text_.text = var_276_10
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105066", "story_v_side_new_1101105.awb") ~= 0 then
					local var_276_14 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105066", "story_v_side_new_1101105.awb") / 1000

					if var_276_14 + var_276_6 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_14 + var_276_6
					end

					if var_276_9.prefab_name ~= "" and arg_273_1.actors_[var_276_9.prefab_name] ~= nil then
						local var_276_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_9.prefab_name].transform, "story_v_side_new_1101105", "1101105066", "story_v_side_new_1101105.awb")

						arg_273_1:RecordAudio("1101105066", var_276_15)
						arg_273_1:RecordAudio("1101105066", var_276_15)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105066", "story_v_side_new_1101105.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105066", "story_v_side_new_1101105.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_16 = math.max(var_276_7, arg_273_1.talkMaxDuration)

			if var_276_6 <= arg_273_1.time_ and arg_273_1.time_ < var_276_6 + var_276_16 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_6) / var_276_16

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_6 + var_276_16 and arg_273_1.time_ < var_276_6 + var_276_16 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play1101105067 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 1101105067
		arg_277_1.duration_ = 11.9

		local var_277_0 = {
			zh = 6.166,
			ja = 11.9
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
				arg_277_0:Play1101105068(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = arg_277_1.actors_["1033ui_story"].transform
			local var_280_1 = 0

			if var_280_1 < arg_277_1.time_ and arg_277_1.time_ <= var_280_1 + arg_280_0 then
				arg_277_1.var_.moveOldPos1033ui_story = var_280_0.localPosition
			end

			local var_280_2 = 0.001

			if var_280_1 <= arg_277_1.time_ and arg_277_1.time_ < var_280_1 + var_280_2 then
				local var_280_3 = (arg_277_1.time_ - var_280_1) / var_280_2
				local var_280_4 = Vector3.New(0.7, -1.01, -6.13)

				var_280_0.localPosition = Vector3.Lerp(arg_277_1.var_.moveOldPos1033ui_story, var_280_4, var_280_3)

				local var_280_5 = manager.ui.mainCamera.transform.position - var_280_0.position

				var_280_0.forward = Vector3.New(var_280_5.x, var_280_5.y, var_280_5.z)

				local var_280_6 = var_280_0.localEulerAngles

				var_280_6.z = 0
				var_280_6.x = 0
				var_280_0.localEulerAngles = var_280_6
			end

			if arg_277_1.time_ >= var_280_1 + var_280_2 and arg_277_1.time_ < var_280_1 + var_280_2 + arg_280_0 then
				var_280_0.localPosition = Vector3.New(0.7, -1.01, -6.13)

				local var_280_7 = manager.ui.mainCamera.transform.position - var_280_0.position

				var_280_0.forward = Vector3.New(var_280_7.x, var_280_7.y, var_280_7.z)

				local var_280_8 = var_280_0.localEulerAngles

				var_280_8.z = 0
				var_280_8.x = 0
				var_280_0.localEulerAngles = var_280_8
			end

			local var_280_9 = arg_277_1.actors_["1033ui_story"]
			local var_280_10 = 0

			if var_280_10 < arg_277_1.time_ and arg_277_1.time_ <= var_280_10 + arg_280_0 and not isNil(var_280_9) and arg_277_1.var_.characterEffect1033ui_story == nil then
				arg_277_1.var_.characterEffect1033ui_story = var_280_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_11 = 0.200000002980232

			if var_280_10 <= arg_277_1.time_ and arg_277_1.time_ < var_280_10 + var_280_11 and not isNil(var_280_9) then
				local var_280_12 = (arg_277_1.time_ - var_280_10) / var_280_11

				if arg_277_1.var_.characterEffect1033ui_story and not isNil(var_280_9) then
					arg_277_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_277_1.time_ >= var_280_10 + var_280_11 and arg_277_1.time_ < var_280_10 + var_280_11 + arg_280_0 and not isNil(var_280_9) and arg_277_1.var_.characterEffect1033ui_story then
				arg_277_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_280_13 = 0

			if var_280_13 < arg_277_1.time_ and arg_277_1.time_ <= var_280_13 + arg_280_0 then
				arg_277_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033actionlink/1033action427")
			end

			local var_280_14 = 0

			if var_280_14 < arg_277_1.time_ and arg_277_1.time_ <= var_280_14 + arg_280_0 then
				arg_277_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_280_15 = 0
			local var_280_16 = 0.725

			if var_280_15 < arg_277_1.time_ and arg_277_1.time_ <= var_280_15 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				local var_280_17 = arg_277_1:FormatText(StoryNameCfg[236].name)

				arg_277_1.leftNameTxt_.text = var_280_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_18 = arg_277_1:GetWordFromCfg(1101105067)
				local var_280_19 = arg_277_1:FormatText(var_280_18.content)

				arg_277_1.text_.text = var_280_19

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_20 = 29
				local var_280_21 = utf8.len(var_280_19)
				local var_280_22 = var_280_20 <= 0 and var_280_16 or var_280_16 * (var_280_21 / var_280_20)

				if var_280_22 > 0 and var_280_16 < var_280_22 then
					arg_277_1.talkMaxDuration = var_280_22

					if var_280_22 + var_280_15 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_22 + var_280_15
					end
				end

				arg_277_1.text_.text = var_280_19
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105067", "story_v_side_new_1101105.awb") ~= 0 then
					local var_280_23 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105067", "story_v_side_new_1101105.awb") / 1000

					if var_280_23 + var_280_15 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_23 + var_280_15
					end

					if var_280_18.prefab_name ~= "" and arg_277_1.actors_[var_280_18.prefab_name] ~= nil then
						local var_280_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_18.prefab_name].transform, "story_v_side_new_1101105", "1101105067", "story_v_side_new_1101105.awb")

						arg_277_1:RecordAudio("1101105067", var_280_24)
						arg_277_1:RecordAudio("1101105067", var_280_24)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105067", "story_v_side_new_1101105.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105067", "story_v_side_new_1101105.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_25 = math.max(var_280_16, arg_277_1.talkMaxDuration)

			if var_280_15 <= arg_277_1.time_ and arg_277_1.time_ < var_280_15 + var_280_25 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_15) / var_280_25

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_15 + var_280_25 and arg_277_1.time_ < var_280_15 + var_280_25 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_277_1:InitPlayNodeList()
	end,
	Play1101105068 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 1101105068
		arg_281_1.duration_ = 5

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play1101105069(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = arg_281_1.actors_["1066ui_story"].transform
			local var_284_1 = 0

			if var_284_1 < arg_281_1.time_ and arg_281_1.time_ <= var_284_1 + arg_284_0 then
				arg_281_1.var_.moveOldPos1066ui_story = var_284_0.localPosition
			end

			local var_284_2 = 0.001

			if var_284_1 <= arg_281_1.time_ and arg_281_1.time_ < var_284_1 + var_284_2 then
				local var_284_3 = (arg_281_1.time_ - var_284_1) / var_284_2
				local var_284_4 = Vector3.New(0, 100, 0)

				var_284_0.localPosition = Vector3.Lerp(arg_281_1.var_.moveOldPos1066ui_story, var_284_4, var_284_3)

				local var_284_5 = manager.ui.mainCamera.transform.position - var_284_0.position

				var_284_0.forward = Vector3.New(var_284_5.x, var_284_5.y, var_284_5.z)

				local var_284_6 = var_284_0.localEulerAngles

				var_284_6.z = 0
				var_284_6.x = 0
				var_284_0.localEulerAngles = var_284_6
			end

			if arg_281_1.time_ >= var_284_1 + var_284_2 and arg_281_1.time_ < var_284_1 + var_284_2 + arg_284_0 then
				var_284_0.localPosition = Vector3.New(0, 100, 0)

				local var_284_7 = manager.ui.mainCamera.transform.position - var_284_0.position

				var_284_0.forward = Vector3.New(var_284_7.x, var_284_7.y, var_284_7.z)

				local var_284_8 = var_284_0.localEulerAngles

				var_284_8.z = 0
				var_284_8.x = 0
				var_284_0.localEulerAngles = var_284_8
			end

			local var_284_9 = arg_281_1.actors_["1033ui_story"].transform
			local var_284_10 = 0

			if var_284_10 < arg_281_1.time_ and arg_281_1.time_ <= var_284_10 + arg_284_0 then
				arg_281_1.var_.moveOldPos1033ui_story = var_284_9.localPosition
			end

			local var_284_11 = 0.001

			if var_284_10 <= arg_281_1.time_ and arg_281_1.time_ < var_284_10 + var_284_11 then
				local var_284_12 = (arg_281_1.time_ - var_284_10) / var_284_11
				local var_284_13 = Vector3.New(0, 100, 0)

				var_284_9.localPosition = Vector3.Lerp(arg_281_1.var_.moveOldPos1033ui_story, var_284_13, var_284_12)

				local var_284_14 = manager.ui.mainCamera.transform.position - var_284_9.position

				var_284_9.forward = Vector3.New(var_284_14.x, var_284_14.y, var_284_14.z)

				local var_284_15 = var_284_9.localEulerAngles

				var_284_15.z = 0
				var_284_15.x = 0
				var_284_9.localEulerAngles = var_284_15
			end

			if arg_281_1.time_ >= var_284_10 + var_284_11 and arg_281_1.time_ < var_284_10 + var_284_11 + arg_284_0 then
				var_284_9.localPosition = Vector3.New(0, 100, 0)

				local var_284_16 = manager.ui.mainCamera.transform.position - var_284_9.position

				var_284_9.forward = Vector3.New(var_284_16.x, var_284_16.y, var_284_16.z)

				local var_284_17 = var_284_9.localEulerAngles

				var_284_17.z = 0
				var_284_17.x = 0
				var_284_9.localEulerAngles = var_284_17
			end

			local var_284_18 = 0
			local var_284_19 = 0.85

			if var_284_18 < arg_281_1.time_ and arg_281_1.time_ <= var_284_18 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, false)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_20 = arg_281_1:GetWordFromCfg(1101105068)
				local var_284_21 = arg_281_1:FormatText(var_284_20.content)

				arg_281_1.text_.text = var_284_21

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_22 = 34
				local var_284_23 = utf8.len(var_284_21)
				local var_284_24 = var_284_22 <= 0 and var_284_19 or var_284_19 * (var_284_23 / var_284_22)

				if var_284_24 > 0 and var_284_19 < var_284_24 then
					arg_281_1.talkMaxDuration = var_284_24

					if var_284_24 + var_284_18 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_24 + var_284_18
					end
				end

				arg_281_1.text_.text = var_284_21
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)
				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_25 = math.max(var_284_19, arg_281_1.talkMaxDuration)

			if var_284_18 <= arg_281_1.time_ and arg_281_1.time_ < var_284_18 + var_284_25 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_18) / var_284_25

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_18 + var_284_25 and arg_281_1.time_ < var_284_18 + var_284_25 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_281_1:InitPlayNodeList()
	end,
	Play1101105069 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 1101105069
		arg_285_1.duration_ = 5

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play1101105070(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = 0
			local var_288_1 = 0.4

			if var_288_0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_0 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, false)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_2 = arg_285_1:GetWordFromCfg(1101105069)
				local var_288_3 = arg_285_1:FormatText(var_288_2.content)

				arg_285_1.text_.text = var_288_3

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_4 = 16
				local var_288_5 = utf8.len(var_288_3)
				local var_288_6 = var_288_4 <= 0 and var_288_1 or var_288_1 * (var_288_5 / var_288_4)

				if var_288_6 > 0 and var_288_1 < var_288_6 then
					arg_285_1.talkMaxDuration = var_288_6

					if var_288_6 + var_288_0 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_6 + var_288_0
					end
				end

				arg_285_1.text_.text = var_288_3
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)
				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_7 = math.max(var_288_1, arg_285_1.talkMaxDuration)

			if var_288_0 <= arg_285_1.time_ and arg_285_1.time_ < var_288_0 + var_288_7 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_0) / var_288_7

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_0 + var_288_7 and arg_285_1.time_ < var_288_0 + var_288_7 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play1101105070 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 1101105070
		arg_289_1.duration_ = 5

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play1101105071(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = arg_289_1.actors_["1011ui_story"].transform
			local var_292_1 = 0

			if var_292_1 < arg_289_1.time_ and arg_289_1.time_ <= var_292_1 + arg_292_0 then
				arg_289_1.var_.moveOldPos1011ui_story = var_292_0.localPosition
			end

			local var_292_2 = 0.001

			if var_292_1 <= arg_289_1.time_ and arg_289_1.time_ < var_292_1 + var_292_2 then
				local var_292_3 = (arg_289_1.time_ - var_292_1) / var_292_2
				local var_292_4 = Vector3.New(0, -0.71, -6)

				var_292_0.localPosition = Vector3.Lerp(arg_289_1.var_.moveOldPos1011ui_story, var_292_4, var_292_3)

				local var_292_5 = manager.ui.mainCamera.transform.position - var_292_0.position

				var_292_0.forward = Vector3.New(var_292_5.x, var_292_5.y, var_292_5.z)

				local var_292_6 = var_292_0.localEulerAngles

				var_292_6.z = 0
				var_292_6.x = 0
				var_292_0.localEulerAngles = var_292_6
			end

			if arg_289_1.time_ >= var_292_1 + var_292_2 and arg_289_1.time_ < var_292_1 + var_292_2 + arg_292_0 then
				var_292_0.localPosition = Vector3.New(0, -0.71, -6)

				local var_292_7 = manager.ui.mainCamera.transform.position - var_292_0.position

				var_292_0.forward = Vector3.New(var_292_7.x, var_292_7.y, var_292_7.z)

				local var_292_8 = var_292_0.localEulerAngles

				var_292_8.z = 0
				var_292_8.x = 0
				var_292_0.localEulerAngles = var_292_8
			end

			local var_292_9 = arg_289_1.actors_["1011ui_story"]
			local var_292_10 = 0

			if var_292_10 < arg_289_1.time_ and arg_289_1.time_ <= var_292_10 + arg_292_0 and not isNil(var_292_9) and arg_289_1.var_.characterEffect1011ui_story == nil then
				arg_289_1.var_.characterEffect1011ui_story = var_292_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_11 = 0.200000002980232

			if var_292_10 <= arg_289_1.time_ and arg_289_1.time_ < var_292_10 + var_292_11 and not isNil(var_292_9) then
				local var_292_12 = (arg_289_1.time_ - var_292_10) / var_292_11

				if arg_289_1.var_.characterEffect1011ui_story and not isNil(var_292_9) then
					arg_289_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_289_1.time_ >= var_292_10 + var_292_11 and arg_289_1.time_ < var_292_10 + var_292_11 + arg_292_0 and not isNil(var_292_9) and arg_289_1.var_.characterEffect1011ui_story then
				arg_289_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_292_13 = 0

			if var_292_13 < arg_289_1.time_ and arg_289_1.time_ <= var_292_13 + arg_292_0 then
				arg_289_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action1_1")
			end

			local var_292_14 = 0

			if var_292_14 < arg_289_1.time_ and arg_289_1.time_ <= var_292_14 + arg_292_0 then
				arg_289_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_292_15 = 0
			local var_292_16 = 1.075

			if var_292_15 < arg_289_1.time_ and arg_289_1.time_ <= var_292_15 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, false)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_17 = arg_289_1:GetWordFromCfg(1101105070)
				local var_292_18 = arg_289_1:FormatText(var_292_17.content)

				arg_289_1.text_.text = var_292_18

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_19 = 43
				local var_292_20 = utf8.len(var_292_18)
				local var_292_21 = var_292_19 <= 0 and var_292_16 or var_292_16 * (var_292_20 / var_292_19)

				if var_292_21 > 0 and var_292_16 < var_292_21 then
					arg_289_1.talkMaxDuration = var_292_21

					if var_292_21 + var_292_15 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_21 + var_292_15
					end
				end

				arg_289_1.text_.text = var_292_18
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)
				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_22 = math.max(var_292_16, arg_289_1.talkMaxDuration)

			if var_292_15 <= arg_289_1.time_ and arg_289_1.time_ < var_292_15 + var_292_22 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_15) / var_292_22

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_15 + var_292_22 and arg_289_1.time_ < var_292_15 + var_292_22 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_289_1:InitPlayNodeList()
	end,
	Play1101105071 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 1101105071
		arg_293_1.duration_ = 5

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play1101105072(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = arg_293_1.actors_["1011ui_story"]
			local var_296_1 = 0

			if var_296_1 < arg_293_1.time_ and arg_293_1.time_ <= var_296_1 + arg_296_0 and not isNil(var_296_0) and arg_293_1.var_.characterEffect1011ui_story == nil then
				arg_293_1.var_.characterEffect1011ui_story = var_296_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_2 = 0.200000002980232

			if var_296_1 <= arg_293_1.time_ and arg_293_1.time_ < var_296_1 + var_296_2 and not isNil(var_296_0) then
				local var_296_3 = (arg_293_1.time_ - var_296_1) / var_296_2

				if arg_293_1.var_.characterEffect1011ui_story and not isNil(var_296_0) then
					local var_296_4 = Mathf.Lerp(0, 0.5, var_296_3)

					arg_293_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_293_1.var_.characterEffect1011ui_story.fillRatio = var_296_4
				end
			end

			if arg_293_1.time_ >= var_296_1 + var_296_2 and arg_293_1.time_ < var_296_1 + var_296_2 + arg_296_0 and not isNil(var_296_0) and arg_293_1.var_.characterEffect1011ui_story then
				local var_296_5 = 0.5

				arg_293_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_293_1.var_.characterEffect1011ui_story.fillRatio = var_296_5
			end

			local var_296_6 = 0
			local var_296_7 = 0.7

			if var_296_6 < arg_293_1.time_ and arg_293_1.time_ <= var_296_6 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, false)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_8 = arg_293_1:GetWordFromCfg(1101105071)
				local var_296_9 = arg_293_1:FormatText(var_296_8.content)

				arg_293_1.text_.text = var_296_9

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_10 = 28
				local var_296_11 = utf8.len(var_296_9)
				local var_296_12 = var_296_10 <= 0 and var_296_7 or var_296_7 * (var_296_11 / var_296_10)

				if var_296_12 > 0 and var_296_7 < var_296_12 then
					arg_293_1.talkMaxDuration = var_296_12

					if var_296_12 + var_296_6 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_12 + var_296_6
					end
				end

				arg_293_1.text_.text = var_296_9
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)
				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_13 = math.max(var_296_7, arg_293_1.talkMaxDuration)

			if var_296_6 <= arg_293_1.time_ and arg_293_1.time_ < var_296_6 + var_296_13 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_6) / var_296_13

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_6 + var_296_13 and arg_293_1.time_ < var_296_6 + var_296_13 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play1101105072 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 1101105072
		arg_297_1.duration_ = 2

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play1101105073(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = arg_297_1.actors_["1033ui_story"].transform
			local var_300_1 = 0

			if var_300_1 < arg_297_1.time_ and arg_297_1.time_ <= var_300_1 + arg_300_0 then
				arg_297_1.var_.moveOldPos1033ui_story = var_300_0.localPosition
			end

			local var_300_2 = 0.001

			if var_300_1 <= arg_297_1.time_ and arg_297_1.time_ < var_300_1 + var_300_2 then
				local var_300_3 = (arg_297_1.time_ - var_300_1) / var_300_2
				local var_300_4 = Vector3.New(0, -1.01, -6.13)

				var_300_0.localPosition = Vector3.Lerp(arg_297_1.var_.moveOldPos1033ui_story, var_300_4, var_300_3)

				local var_300_5 = manager.ui.mainCamera.transform.position - var_300_0.position

				var_300_0.forward = Vector3.New(var_300_5.x, var_300_5.y, var_300_5.z)

				local var_300_6 = var_300_0.localEulerAngles

				var_300_6.z = 0
				var_300_6.x = 0
				var_300_0.localEulerAngles = var_300_6
			end

			if arg_297_1.time_ >= var_300_1 + var_300_2 and arg_297_1.time_ < var_300_1 + var_300_2 + arg_300_0 then
				var_300_0.localPosition = Vector3.New(0, -1.01, -6.13)

				local var_300_7 = manager.ui.mainCamera.transform.position - var_300_0.position

				var_300_0.forward = Vector3.New(var_300_7.x, var_300_7.y, var_300_7.z)

				local var_300_8 = var_300_0.localEulerAngles

				var_300_8.z = 0
				var_300_8.x = 0
				var_300_0.localEulerAngles = var_300_8
			end

			local var_300_9 = arg_297_1.actors_["1033ui_story"]
			local var_300_10 = 0

			if var_300_10 < arg_297_1.time_ and arg_297_1.time_ <= var_300_10 + arg_300_0 and not isNil(var_300_9) and arg_297_1.var_.characterEffect1033ui_story == nil then
				arg_297_1.var_.characterEffect1033ui_story = var_300_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_300_11 = 0.200000002980232

			if var_300_10 <= arg_297_1.time_ and arg_297_1.time_ < var_300_10 + var_300_11 and not isNil(var_300_9) then
				local var_300_12 = (arg_297_1.time_ - var_300_10) / var_300_11

				if arg_297_1.var_.characterEffect1033ui_story and not isNil(var_300_9) then
					arg_297_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_297_1.time_ >= var_300_10 + var_300_11 and arg_297_1.time_ < var_300_10 + var_300_11 + arg_300_0 and not isNil(var_300_9) and arg_297_1.var_.characterEffect1033ui_story then
				arg_297_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_300_13 = 0

			if var_300_13 < arg_297_1.time_ and arg_297_1.time_ <= var_300_13 + arg_300_0 then
				arg_297_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action4_1")
			end

			local var_300_14 = 0

			if var_300_14 < arg_297_1.time_ and arg_297_1.time_ <= var_300_14 + arg_300_0 then
				arg_297_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_300_15 = arg_297_1.actors_["1011ui_story"].transform
			local var_300_16 = 0

			if var_300_16 < arg_297_1.time_ and arg_297_1.time_ <= var_300_16 + arg_300_0 then
				arg_297_1.var_.moveOldPos1011ui_story = var_300_15.localPosition
			end

			local var_300_17 = 0.001

			if var_300_16 <= arg_297_1.time_ and arg_297_1.time_ < var_300_16 + var_300_17 then
				local var_300_18 = (arg_297_1.time_ - var_300_16) / var_300_17
				local var_300_19 = Vector3.New(0, 100, 0)

				var_300_15.localPosition = Vector3.Lerp(arg_297_1.var_.moveOldPos1011ui_story, var_300_19, var_300_18)

				local var_300_20 = manager.ui.mainCamera.transform.position - var_300_15.position

				var_300_15.forward = Vector3.New(var_300_20.x, var_300_20.y, var_300_20.z)

				local var_300_21 = var_300_15.localEulerAngles

				var_300_21.z = 0
				var_300_21.x = 0
				var_300_15.localEulerAngles = var_300_21
			end

			if arg_297_1.time_ >= var_300_16 + var_300_17 and arg_297_1.time_ < var_300_16 + var_300_17 + arg_300_0 then
				var_300_15.localPosition = Vector3.New(0, 100, 0)

				local var_300_22 = manager.ui.mainCamera.transform.position - var_300_15.position

				var_300_15.forward = Vector3.New(var_300_22.x, var_300_22.y, var_300_22.z)

				local var_300_23 = var_300_15.localEulerAngles

				var_300_23.z = 0
				var_300_23.x = 0
				var_300_15.localEulerAngles = var_300_23
			end

			local var_300_24 = arg_297_1.actors_["1011ui_story"]
			local var_300_25 = 0

			if var_300_25 < arg_297_1.time_ and arg_297_1.time_ <= var_300_25 + arg_300_0 and not isNil(var_300_24) and arg_297_1.var_.characterEffect1011ui_story == nil then
				arg_297_1.var_.characterEffect1011ui_story = var_300_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_300_26 = 0.200000002980232

			if var_300_25 <= arg_297_1.time_ and arg_297_1.time_ < var_300_25 + var_300_26 and not isNil(var_300_24) then
				local var_300_27 = (arg_297_1.time_ - var_300_25) / var_300_26

				if arg_297_1.var_.characterEffect1011ui_story and not isNil(var_300_24) then
					local var_300_28 = Mathf.Lerp(0, 0.5, var_300_27)

					arg_297_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_297_1.var_.characterEffect1011ui_story.fillRatio = var_300_28
				end
			end

			if arg_297_1.time_ >= var_300_25 + var_300_26 and arg_297_1.time_ < var_300_25 + var_300_26 + arg_300_0 and not isNil(var_300_24) and arg_297_1.var_.characterEffect1011ui_story then
				local var_300_29 = 0.5

				arg_297_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_297_1.var_.characterEffect1011ui_story.fillRatio = var_300_29
			end

			local var_300_30 = 0
			local var_300_31 = 0.05

			if var_300_30 < arg_297_1.time_ and arg_297_1.time_ <= var_300_30 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				local var_300_32 = arg_297_1:FormatText(StoryNameCfg[236].name)

				arg_297_1.leftNameTxt_.text = var_300_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_33 = arg_297_1:GetWordFromCfg(1101105072)
				local var_300_34 = arg_297_1:FormatText(var_300_33.content)

				arg_297_1.text_.text = var_300_34

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_35 = 2
				local var_300_36 = utf8.len(var_300_34)
				local var_300_37 = var_300_35 <= 0 and var_300_31 or var_300_31 * (var_300_36 / var_300_35)

				if var_300_37 > 0 and var_300_31 < var_300_37 then
					arg_297_1.talkMaxDuration = var_300_37

					if var_300_37 + var_300_30 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_37 + var_300_30
					end
				end

				arg_297_1.text_.text = var_300_34
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105072", "story_v_side_new_1101105.awb") ~= 0 then
					local var_300_38 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105072", "story_v_side_new_1101105.awb") / 1000

					if var_300_38 + var_300_30 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_38 + var_300_30
					end

					if var_300_33.prefab_name ~= "" and arg_297_1.actors_[var_300_33.prefab_name] ~= nil then
						local var_300_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_33.prefab_name].transform, "story_v_side_new_1101105", "1101105072", "story_v_side_new_1101105.awb")

						arg_297_1:RecordAudio("1101105072", var_300_39)
						arg_297_1:RecordAudio("1101105072", var_300_39)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105072", "story_v_side_new_1101105.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105072", "story_v_side_new_1101105.awb")
				end

				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_40 = math.max(var_300_31, arg_297_1.talkMaxDuration)

			if var_300_30 <= arg_297_1.time_ and arg_297_1.time_ < var_300_30 + var_300_40 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_30) / var_300_40

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_30 + var_300_40 and arg_297_1.time_ < var_300_30 + var_300_40 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_297_1:InitPlayNodeList()
	end,
	Play1101105073 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 1101105073
		arg_301_1.duration_ = 5

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play1101105074(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = arg_301_1.actors_["1033ui_story"]
			local var_304_1 = 0

			if var_304_1 < arg_301_1.time_ and arg_301_1.time_ <= var_304_1 + arg_304_0 and not isNil(var_304_0) and arg_301_1.var_.characterEffect1033ui_story == nil then
				arg_301_1.var_.characterEffect1033ui_story = var_304_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_304_2 = 0.200000002980232

			if var_304_1 <= arg_301_1.time_ and arg_301_1.time_ < var_304_1 + var_304_2 and not isNil(var_304_0) then
				local var_304_3 = (arg_301_1.time_ - var_304_1) / var_304_2

				if arg_301_1.var_.characterEffect1033ui_story and not isNil(var_304_0) then
					local var_304_4 = Mathf.Lerp(0, 0.5, var_304_3)

					arg_301_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_301_1.var_.characterEffect1033ui_story.fillRatio = var_304_4
				end
			end

			if arg_301_1.time_ >= var_304_1 + var_304_2 and arg_301_1.time_ < var_304_1 + var_304_2 + arg_304_0 and not isNil(var_304_0) and arg_301_1.var_.characterEffect1033ui_story then
				local var_304_5 = 0.5

				arg_301_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_301_1.var_.characterEffect1033ui_story.fillRatio = var_304_5
			end

			local var_304_6 = 0
			local var_304_7 = 0.65

			if var_304_6 < arg_301_1.time_ and arg_301_1.time_ <= var_304_6 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, false)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_8 = arg_301_1:GetWordFromCfg(1101105073)
				local var_304_9 = arg_301_1:FormatText(var_304_8.content)

				arg_301_1.text_.text = var_304_9

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_10 = 26
				local var_304_11 = utf8.len(var_304_9)
				local var_304_12 = var_304_10 <= 0 and var_304_7 or var_304_7 * (var_304_11 / var_304_10)

				if var_304_12 > 0 and var_304_7 < var_304_12 then
					arg_301_1.talkMaxDuration = var_304_12

					if var_304_12 + var_304_6 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_12 + var_304_6
					end
				end

				arg_301_1.text_.text = var_304_9
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)
				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_13 = math.max(var_304_7, arg_301_1.talkMaxDuration)

			if var_304_6 <= arg_301_1.time_ and arg_301_1.time_ < var_304_6 + var_304_13 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_6) / var_304_13

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_6 + var_304_13 and arg_301_1.time_ < var_304_6 + var_304_13 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {}

		arg_301_1:InitPlayNodeList()
	end,
	Play1101105074 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 1101105074
		arg_305_1.duration_ = 2.33

		local var_305_0 = {
			zh = 2,
			ja = 2.333
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
				arg_305_0:Play1101105075(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = 0
			local var_308_1 = 0.1

			if var_308_0 < arg_305_1.time_ and arg_305_1.time_ <= var_308_0 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				local var_308_2 = arg_305_1:FormatText(StoryNameCfg[10].name)

				arg_305_1.leftNameTxt_.text = var_308_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, true)
				arg_305_1.iconController_:SetSelectedState("hero")

				arg_305_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_305_1.callingController_:SetSelectedState("normal")

				arg_305_1.keyicon_.color = Color.New(1, 1, 1)
				arg_305_1.icon_.color = Color.New(1, 1, 1)

				local var_308_3 = arg_305_1:GetWordFromCfg(1101105074)
				local var_308_4 = arg_305_1:FormatText(var_308_3.content)

				arg_305_1.text_.text = var_308_4

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_5 = 4
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

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105074", "story_v_side_new_1101105.awb") ~= 0 then
					local var_308_8 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105074", "story_v_side_new_1101105.awb") / 1000

					if var_308_8 + var_308_0 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_8 + var_308_0
					end

					if var_308_3.prefab_name ~= "" and arg_305_1.actors_[var_308_3.prefab_name] ~= nil then
						local var_308_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_305_1.actors_[var_308_3.prefab_name].transform, "story_v_side_new_1101105", "1101105074", "story_v_side_new_1101105.awb")

						arg_305_1:RecordAudio("1101105074", var_308_9)
						arg_305_1:RecordAudio("1101105074", var_308_9)
					else
						arg_305_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105074", "story_v_side_new_1101105.awb")
					end

					arg_305_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105074", "story_v_side_new_1101105.awb")
				end

				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_10 = math.max(var_308_1, arg_305_1.talkMaxDuration)

			if var_308_0 <= arg_305_1.time_ and arg_305_1.time_ < var_308_0 + var_308_10 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_0) / var_308_10

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_0 + var_308_10 and arg_305_1.time_ < var_308_0 + var_308_10 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play1101105075 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 1101105075
		arg_309_1.duration_ = 5

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play1101105076(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = 0
			local var_312_1 = 0.1

			if var_312_0 < arg_309_1.time_ and arg_309_1.time_ <= var_312_0 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				local var_312_2 = arg_309_1:FormatText(StoryNameCfg[7].name)

				arg_309_1.leftNameTxt_.text = var_312_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, true)
				arg_309_1.iconController_:SetSelectedState("hero")

				arg_309_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_309_1.callingController_:SetSelectedState("normal")

				arg_309_1.keyicon_.color = Color.New(1, 1, 1)
				arg_309_1.icon_.color = Color.New(1, 1, 1)

				local var_312_3 = arg_309_1:GetWordFromCfg(1101105075)
				local var_312_4 = arg_309_1:FormatText(var_312_3.content)

				arg_309_1.text_.text = var_312_4

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_5 = 4
				local var_312_6 = utf8.len(var_312_4)
				local var_312_7 = var_312_5 <= 0 and var_312_1 or var_312_1 * (var_312_6 / var_312_5)

				if var_312_7 > 0 and var_312_1 < var_312_7 then
					arg_309_1.talkMaxDuration = var_312_7

					if var_312_7 + var_312_0 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_7 + var_312_0
					end
				end

				arg_309_1.text_.text = var_312_4
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)
				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_8 = math.max(var_312_1, arg_309_1.talkMaxDuration)

			if var_312_0 <= arg_309_1.time_ and arg_309_1.time_ < var_312_0 + var_312_8 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_0) / var_312_8

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_0 + var_312_8 and arg_309_1.time_ < var_312_0 + var_312_8 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play1101105076 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 1101105076
		arg_313_1.duration_ = 2.4

		local var_313_0 = {
			zh = 2.4,
			ja = 2.3
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
				arg_313_0:Play1101105077(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			local var_316_0 = arg_313_1.actors_["1011ui_story"].transform
			local var_316_1 = 0

			if var_316_1 < arg_313_1.time_ and arg_313_1.time_ <= var_316_1 + arg_316_0 then
				arg_313_1.var_.moveOldPos1011ui_story = var_316_0.localPosition
			end

			local var_316_2 = 0.001

			if var_316_1 <= arg_313_1.time_ and arg_313_1.time_ < var_316_1 + var_316_2 then
				local var_316_3 = (arg_313_1.time_ - var_316_1) / var_316_2
				local var_316_4 = Vector3.New(0, -0.71, -6)

				var_316_0.localPosition = Vector3.Lerp(arg_313_1.var_.moveOldPos1011ui_story, var_316_4, var_316_3)

				local var_316_5 = manager.ui.mainCamera.transform.position - var_316_0.position

				var_316_0.forward = Vector3.New(var_316_5.x, var_316_5.y, var_316_5.z)

				local var_316_6 = var_316_0.localEulerAngles

				var_316_6.z = 0
				var_316_6.x = 0
				var_316_0.localEulerAngles = var_316_6
			end

			if arg_313_1.time_ >= var_316_1 + var_316_2 and arg_313_1.time_ < var_316_1 + var_316_2 + arg_316_0 then
				var_316_0.localPosition = Vector3.New(0, -0.71, -6)

				local var_316_7 = manager.ui.mainCamera.transform.position - var_316_0.position

				var_316_0.forward = Vector3.New(var_316_7.x, var_316_7.y, var_316_7.z)

				local var_316_8 = var_316_0.localEulerAngles

				var_316_8.z = 0
				var_316_8.x = 0
				var_316_0.localEulerAngles = var_316_8
			end

			local var_316_9 = arg_313_1.actors_["1011ui_story"]
			local var_316_10 = 0

			if var_316_10 < arg_313_1.time_ and arg_313_1.time_ <= var_316_10 + arg_316_0 and not isNil(var_316_9) and arg_313_1.var_.characterEffect1011ui_story == nil then
				arg_313_1.var_.characterEffect1011ui_story = var_316_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_11 = 0.200000002980232

			if var_316_10 <= arg_313_1.time_ and arg_313_1.time_ < var_316_10 + var_316_11 and not isNil(var_316_9) then
				local var_316_12 = (arg_313_1.time_ - var_316_10) / var_316_11

				if arg_313_1.var_.characterEffect1011ui_story and not isNil(var_316_9) then
					arg_313_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_313_1.time_ >= var_316_10 + var_316_11 and arg_313_1.time_ < var_316_10 + var_316_11 + arg_316_0 and not isNil(var_316_9) and arg_313_1.var_.characterEffect1011ui_story then
				arg_313_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_316_13 = 0

			if var_316_13 < arg_313_1.time_ and arg_313_1.time_ <= var_316_13 + arg_316_0 then
				arg_313_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action4_1")
			end

			local var_316_14 = 0

			if var_316_14 < arg_313_1.time_ and arg_313_1.time_ <= var_316_14 + arg_316_0 then
				arg_313_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_316_15 = arg_313_1.actors_["1033ui_story"].transform
			local var_316_16 = 0

			if var_316_16 < arg_313_1.time_ and arg_313_1.time_ <= var_316_16 + arg_316_0 then
				arg_313_1.var_.moveOldPos1033ui_story = var_316_15.localPosition
			end

			local var_316_17 = 0.001

			if var_316_16 <= arg_313_1.time_ and arg_313_1.time_ < var_316_16 + var_316_17 then
				local var_316_18 = (arg_313_1.time_ - var_316_16) / var_316_17
				local var_316_19 = Vector3.New(0, 100, 0)

				var_316_15.localPosition = Vector3.Lerp(arg_313_1.var_.moveOldPos1033ui_story, var_316_19, var_316_18)

				local var_316_20 = manager.ui.mainCamera.transform.position - var_316_15.position

				var_316_15.forward = Vector3.New(var_316_20.x, var_316_20.y, var_316_20.z)

				local var_316_21 = var_316_15.localEulerAngles

				var_316_21.z = 0
				var_316_21.x = 0
				var_316_15.localEulerAngles = var_316_21
			end

			if arg_313_1.time_ >= var_316_16 + var_316_17 and arg_313_1.time_ < var_316_16 + var_316_17 + arg_316_0 then
				var_316_15.localPosition = Vector3.New(0, 100, 0)

				local var_316_22 = manager.ui.mainCamera.transform.position - var_316_15.position

				var_316_15.forward = Vector3.New(var_316_22.x, var_316_22.y, var_316_22.z)

				local var_316_23 = var_316_15.localEulerAngles

				var_316_23.z = 0
				var_316_23.x = 0
				var_316_15.localEulerAngles = var_316_23
			end

			local var_316_24 = arg_313_1.actors_["1033ui_story"]
			local var_316_25 = 0

			if var_316_25 < arg_313_1.time_ and arg_313_1.time_ <= var_316_25 + arg_316_0 and not isNil(var_316_24) and arg_313_1.var_.characterEffect1033ui_story == nil then
				arg_313_1.var_.characterEffect1033ui_story = var_316_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_26 = 0.200000002980232

			if var_316_25 <= arg_313_1.time_ and arg_313_1.time_ < var_316_25 + var_316_26 and not isNil(var_316_24) then
				local var_316_27 = (arg_313_1.time_ - var_316_25) / var_316_26

				if arg_313_1.var_.characterEffect1033ui_story and not isNil(var_316_24) then
					local var_316_28 = Mathf.Lerp(0, 0.5, var_316_27)

					arg_313_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_313_1.var_.characterEffect1033ui_story.fillRatio = var_316_28
				end
			end

			if arg_313_1.time_ >= var_316_25 + var_316_26 and arg_313_1.time_ < var_316_25 + var_316_26 + arg_316_0 and not isNil(var_316_24) and arg_313_1.var_.characterEffect1033ui_story then
				local var_316_29 = 0.5

				arg_313_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_313_1.var_.characterEffect1033ui_story.fillRatio = var_316_29
			end

			local var_316_30 = 0
			local var_316_31 = 0.225

			if var_316_30 < arg_313_1.time_ and arg_313_1.time_ <= var_316_30 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				local var_316_32 = arg_313_1:FormatText(StoryNameCfg[37].name)

				arg_313_1.leftNameTxt_.text = var_316_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_33 = arg_313_1:GetWordFromCfg(1101105076)
				local var_316_34 = arg_313_1:FormatText(var_316_33.content)

				arg_313_1.text_.text = var_316_34

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_35 = 9
				local var_316_36 = utf8.len(var_316_34)
				local var_316_37 = var_316_35 <= 0 and var_316_31 or var_316_31 * (var_316_36 / var_316_35)

				if var_316_37 > 0 and var_316_31 < var_316_37 then
					arg_313_1.talkMaxDuration = var_316_37

					if var_316_37 + var_316_30 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_37 + var_316_30
					end
				end

				arg_313_1.text_.text = var_316_34
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105076", "story_v_side_new_1101105.awb") ~= 0 then
					local var_316_38 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105076", "story_v_side_new_1101105.awb") / 1000

					if var_316_38 + var_316_30 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_38 + var_316_30
					end

					if var_316_33.prefab_name ~= "" and arg_313_1.actors_[var_316_33.prefab_name] ~= nil then
						local var_316_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_33.prefab_name].transform, "story_v_side_new_1101105", "1101105076", "story_v_side_new_1101105.awb")

						arg_313_1:RecordAudio("1101105076", var_316_39)
						arg_313_1:RecordAudio("1101105076", var_316_39)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105076", "story_v_side_new_1101105.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105076", "story_v_side_new_1101105.awb")
				end

				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_40 = math.max(var_316_31, arg_313_1.talkMaxDuration)

			if var_316_30 <= arg_313_1.time_ and arg_313_1.time_ < var_316_30 + var_316_40 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_30) / var_316_40

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_30 + var_316_40 and arg_313_1.time_ < var_316_30 + var_316_40 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1033ui_story",
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
	Play1101105077 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 1101105077
		arg_317_1.duration_ = 5

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play1101105078(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = arg_317_1.actors_["1033ui_story"].transform
			local var_320_1 = 0

			if var_320_1 < arg_317_1.time_ and arg_317_1.time_ <= var_320_1 + arg_320_0 then
				arg_317_1.var_.moveOldPos1033ui_story = var_320_0.localPosition
			end

			local var_320_2 = 0.001

			if var_320_1 <= arg_317_1.time_ and arg_317_1.time_ < var_320_1 + var_320_2 then
				local var_320_3 = (arg_317_1.time_ - var_320_1) / var_320_2
				local var_320_4 = Vector3.New(0, -1.01, -6.13)

				var_320_0.localPosition = Vector3.Lerp(arg_317_1.var_.moveOldPos1033ui_story, var_320_4, var_320_3)

				local var_320_5 = manager.ui.mainCamera.transform.position - var_320_0.position

				var_320_0.forward = Vector3.New(var_320_5.x, var_320_5.y, var_320_5.z)

				local var_320_6 = var_320_0.localEulerAngles

				var_320_6.z = 0
				var_320_6.x = 0
				var_320_0.localEulerAngles = var_320_6
			end

			if arg_317_1.time_ >= var_320_1 + var_320_2 and arg_317_1.time_ < var_320_1 + var_320_2 + arg_320_0 then
				var_320_0.localPosition = Vector3.New(0, -1.01, -6.13)

				local var_320_7 = manager.ui.mainCamera.transform.position - var_320_0.position

				var_320_0.forward = Vector3.New(var_320_7.x, var_320_7.y, var_320_7.z)

				local var_320_8 = var_320_0.localEulerAngles

				var_320_8.z = 0
				var_320_8.x = 0
				var_320_0.localEulerAngles = var_320_8
			end

			local var_320_9 = arg_317_1.actors_["1033ui_story"]
			local var_320_10 = 0

			if var_320_10 < arg_317_1.time_ and arg_317_1.time_ <= var_320_10 + arg_320_0 and not isNil(var_320_9) and arg_317_1.var_.characterEffect1033ui_story == nil then
				arg_317_1.var_.characterEffect1033ui_story = var_320_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_11 = 0.200000002980232

			if var_320_10 <= arg_317_1.time_ and arg_317_1.time_ < var_320_10 + var_320_11 and not isNil(var_320_9) then
				local var_320_12 = (arg_317_1.time_ - var_320_10) / var_320_11

				if arg_317_1.var_.characterEffect1033ui_story and not isNil(var_320_9) then
					arg_317_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_317_1.time_ >= var_320_10 + var_320_11 and arg_317_1.time_ < var_320_10 + var_320_11 + arg_320_0 and not isNil(var_320_9) and arg_317_1.var_.characterEffect1033ui_story then
				arg_317_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_320_13 = 0

			if var_320_13 < arg_317_1.time_ and arg_317_1.time_ <= var_320_13 + arg_320_0 then
				arg_317_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_320_14 = arg_317_1.actors_["1011ui_story"].transform
			local var_320_15 = 0

			if var_320_15 < arg_317_1.time_ and arg_317_1.time_ <= var_320_15 + arg_320_0 then
				arg_317_1.var_.moveOldPos1011ui_story = var_320_14.localPosition
			end

			local var_320_16 = 0.001

			if var_320_15 <= arg_317_1.time_ and arg_317_1.time_ < var_320_15 + var_320_16 then
				local var_320_17 = (arg_317_1.time_ - var_320_15) / var_320_16
				local var_320_18 = Vector3.New(0, 100, 0)

				var_320_14.localPosition = Vector3.Lerp(arg_317_1.var_.moveOldPos1011ui_story, var_320_18, var_320_17)

				local var_320_19 = manager.ui.mainCamera.transform.position - var_320_14.position

				var_320_14.forward = Vector3.New(var_320_19.x, var_320_19.y, var_320_19.z)

				local var_320_20 = var_320_14.localEulerAngles

				var_320_20.z = 0
				var_320_20.x = 0
				var_320_14.localEulerAngles = var_320_20
			end

			if arg_317_1.time_ >= var_320_15 + var_320_16 and arg_317_1.time_ < var_320_15 + var_320_16 + arg_320_0 then
				var_320_14.localPosition = Vector3.New(0, 100, 0)

				local var_320_21 = manager.ui.mainCamera.transform.position - var_320_14.position

				var_320_14.forward = Vector3.New(var_320_21.x, var_320_21.y, var_320_21.z)

				local var_320_22 = var_320_14.localEulerAngles

				var_320_22.z = 0
				var_320_22.x = 0
				var_320_14.localEulerAngles = var_320_22
			end

			local var_320_23 = arg_317_1.actors_["1011ui_story"]
			local var_320_24 = 0

			if var_320_24 < arg_317_1.time_ and arg_317_1.time_ <= var_320_24 + arg_320_0 and not isNil(var_320_23) and arg_317_1.var_.characterEffect1011ui_story == nil then
				arg_317_1.var_.characterEffect1011ui_story = var_320_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_25 = 0.200000002980232

			if var_320_24 <= arg_317_1.time_ and arg_317_1.time_ < var_320_24 + var_320_25 and not isNil(var_320_23) then
				local var_320_26 = (arg_317_1.time_ - var_320_24) / var_320_25

				if arg_317_1.var_.characterEffect1011ui_story and not isNil(var_320_23) then
					local var_320_27 = Mathf.Lerp(0, 0.5, var_320_26)

					arg_317_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_317_1.var_.characterEffect1011ui_story.fillRatio = var_320_27
				end
			end

			if arg_317_1.time_ >= var_320_24 + var_320_25 and arg_317_1.time_ < var_320_24 + var_320_25 + arg_320_0 and not isNil(var_320_23) and arg_317_1.var_.characterEffect1011ui_story then
				local var_320_28 = 0.5

				arg_317_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_317_1.var_.characterEffect1011ui_story.fillRatio = var_320_28
			end

			local var_320_29 = 0
			local var_320_30 = 0.45

			if var_320_29 < arg_317_1.time_ and arg_317_1.time_ <= var_320_29 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, false)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_31 = arg_317_1:GetWordFromCfg(1101105077)
				local var_320_32 = arg_317_1:FormatText(var_320_31.content)

				arg_317_1.text_.text = var_320_32

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_33 = 18
				local var_320_34 = utf8.len(var_320_32)
				local var_320_35 = var_320_33 <= 0 and var_320_30 or var_320_30 * (var_320_34 / var_320_33)

				if var_320_35 > 0 and var_320_30 < var_320_35 then
					arg_317_1.talkMaxDuration = var_320_35

					if var_320_35 + var_320_29 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_35 + var_320_29
					end
				end

				arg_317_1.text_.text = var_320_32
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)
				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_36 = math.max(var_320_30, arg_317_1.talkMaxDuration)

			if var_320_29 <= arg_317_1.time_ and arg_317_1.time_ < var_320_29 + var_320_36 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_29) / var_320_36

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_29 + var_320_36 and arg_317_1.time_ < var_320_29 + var_320_36 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_317_1:InitPlayNodeList()
	end,
	Play1101105078 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 1101105078
		arg_321_1.duration_ = 4.2

		local var_321_0 = {
			zh = 3.566,
			ja = 4.2
		}
		local var_321_1 = manager.audio:GetLocalizationFlag()

		if var_321_0[var_321_1] ~= nil then
			arg_321_1.duration_ = var_321_0[var_321_1]
		end

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play1101105079(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = arg_321_1.actors_["1033ui_story"].transform
			local var_324_1 = 0

			if var_324_1 < arg_321_1.time_ and arg_321_1.time_ <= var_324_1 + arg_324_0 then
				arg_321_1.var_.moveOldPos1033ui_story = var_324_0.localPosition
			end

			local var_324_2 = 0.001

			if var_324_1 <= arg_321_1.time_ and arg_321_1.time_ < var_324_1 + var_324_2 then
				local var_324_3 = (arg_321_1.time_ - var_324_1) / var_324_2
				local var_324_4 = Vector3.New(0, -1.01, -6.13)

				var_324_0.localPosition = Vector3.Lerp(arg_321_1.var_.moveOldPos1033ui_story, var_324_4, var_324_3)

				local var_324_5 = manager.ui.mainCamera.transform.position - var_324_0.position

				var_324_0.forward = Vector3.New(var_324_5.x, var_324_5.y, var_324_5.z)

				local var_324_6 = var_324_0.localEulerAngles

				var_324_6.z = 0
				var_324_6.x = 0
				var_324_0.localEulerAngles = var_324_6
			end

			if arg_321_1.time_ >= var_324_1 + var_324_2 and arg_321_1.time_ < var_324_1 + var_324_2 + arg_324_0 then
				var_324_0.localPosition = Vector3.New(0, -1.01, -6.13)

				local var_324_7 = manager.ui.mainCamera.transform.position - var_324_0.position

				var_324_0.forward = Vector3.New(var_324_7.x, var_324_7.y, var_324_7.z)

				local var_324_8 = var_324_0.localEulerAngles

				var_324_8.z = 0
				var_324_8.x = 0
				var_324_0.localEulerAngles = var_324_8
			end

			local var_324_9 = arg_321_1.actors_["1033ui_story"]
			local var_324_10 = 0

			if var_324_10 < arg_321_1.time_ and arg_321_1.time_ <= var_324_10 + arg_324_0 and not isNil(var_324_9) and arg_321_1.var_.characterEffect1033ui_story == nil then
				arg_321_1.var_.characterEffect1033ui_story = var_324_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_324_11 = 0.200000002980232

			if var_324_10 <= arg_321_1.time_ and arg_321_1.time_ < var_324_10 + var_324_11 and not isNil(var_324_9) then
				local var_324_12 = (arg_321_1.time_ - var_324_10) / var_324_11

				if arg_321_1.var_.characterEffect1033ui_story and not isNil(var_324_9) then
					arg_321_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_321_1.time_ >= var_324_10 + var_324_11 and arg_321_1.time_ < var_324_10 + var_324_11 + arg_324_0 and not isNil(var_324_9) and arg_321_1.var_.characterEffect1033ui_story then
				arg_321_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_324_13 = 0

			if var_324_13 < arg_321_1.time_ and arg_321_1.time_ <= var_324_13 + arg_324_0 then
				arg_321_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action4_2")
			end

			local var_324_14 = 0

			if var_324_14 < arg_321_1.time_ and arg_321_1.time_ <= var_324_14 + arg_324_0 then
				arg_321_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_324_15 = arg_321_1.actors_["1011ui_story"].transform
			local var_324_16 = 0

			if var_324_16 < arg_321_1.time_ and arg_321_1.time_ <= var_324_16 + arg_324_0 then
				arg_321_1.var_.moveOldPos1011ui_story = var_324_15.localPosition
			end

			local var_324_17 = 0.001

			if var_324_16 <= arg_321_1.time_ and arg_321_1.time_ < var_324_16 + var_324_17 then
				local var_324_18 = (arg_321_1.time_ - var_324_16) / var_324_17
				local var_324_19 = Vector3.New(0, 100, 0)

				var_324_15.localPosition = Vector3.Lerp(arg_321_1.var_.moveOldPos1011ui_story, var_324_19, var_324_18)

				local var_324_20 = manager.ui.mainCamera.transform.position - var_324_15.position

				var_324_15.forward = Vector3.New(var_324_20.x, var_324_20.y, var_324_20.z)

				local var_324_21 = var_324_15.localEulerAngles

				var_324_21.z = 0
				var_324_21.x = 0
				var_324_15.localEulerAngles = var_324_21
			end

			if arg_321_1.time_ >= var_324_16 + var_324_17 and arg_321_1.time_ < var_324_16 + var_324_17 + arg_324_0 then
				var_324_15.localPosition = Vector3.New(0, 100, 0)

				local var_324_22 = manager.ui.mainCamera.transform.position - var_324_15.position

				var_324_15.forward = Vector3.New(var_324_22.x, var_324_22.y, var_324_22.z)

				local var_324_23 = var_324_15.localEulerAngles

				var_324_23.z = 0
				var_324_23.x = 0
				var_324_15.localEulerAngles = var_324_23
			end

			local var_324_24 = arg_321_1.actors_["1011ui_story"]
			local var_324_25 = 0

			if var_324_25 < arg_321_1.time_ and arg_321_1.time_ <= var_324_25 + arg_324_0 and not isNil(var_324_24) and arg_321_1.var_.characterEffect1011ui_story == nil then
				arg_321_1.var_.characterEffect1011ui_story = var_324_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_324_26 = 0.200000002980232

			if var_324_25 <= arg_321_1.time_ and arg_321_1.time_ < var_324_25 + var_324_26 and not isNil(var_324_24) then
				local var_324_27 = (arg_321_1.time_ - var_324_25) / var_324_26

				if arg_321_1.var_.characterEffect1011ui_story and not isNil(var_324_24) then
					local var_324_28 = Mathf.Lerp(0, 0.5, var_324_27)

					arg_321_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_321_1.var_.characterEffect1011ui_story.fillRatio = var_324_28
				end
			end

			if arg_321_1.time_ >= var_324_25 + var_324_26 and arg_321_1.time_ < var_324_25 + var_324_26 + arg_324_0 and not isNil(var_324_24) and arg_321_1.var_.characterEffect1011ui_story then
				local var_324_29 = 0.5

				arg_321_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_321_1.var_.characterEffect1011ui_story.fillRatio = var_324_29
			end

			local var_324_30 = 0
			local var_324_31 = 0.325

			if var_324_30 < arg_321_1.time_ and arg_321_1.time_ <= var_324_30 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				local var_324_32 = arg_321_1:FormatText(StoryNameCfg[236].name)

				arg_321_1.leftNameTxt_.text = var_324_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_33 = arg_321_1:GetWordFromCfg(1101105078)
				local var_324_34 = arg_321_1:FormatText(var_324_33.content)

				arg_321_1.text_.text = var_324_34

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_35 = 13
				local var_324_36 = utf8.len(var_324_34)
				local var_324_37 = var_324_35 <= 0 and var_324_31 or var_324_31 * (var_324_36 / var_324_35)

				if var_324_37 > 0 and var_324_31 < var_324_37 then
					arg_321_1.talkMaxDuration = var_324_37

					if var_324_37 + var_324_30 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_37 + var_324_30
					end
				end

				arg_321_1.text_.text = var_324_34
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105078", "story_v_side_new_1101105.awb") ~= 0 then
					local var_324_38 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105078", "story_v_side_new_1101105.awb") / 1000

					if var_324_38 + var_324_30 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_38 + var_324_30
					end

					if var_324_33.prefab_name ~= "" and arg_321_1.actors_[var_324_33.prefab_name] ~= nil then
						local var_324_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_33.prefab_name].transform, "story_v_side_new_1101105", "1101105078", "story_v_side_new_1101105.awb")

						arg_321_1:RecordAudio("1101105078", var_324_39)
						arg_321_1:RecordAudio("1101105078", var_324_39)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105078", "story_v_side_new_1101105.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105078", "story_v_side_new_1101105.awb")
				end

				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_40 = math.max(var_324_31, arg_321_1.talkMaxDuration)

			if var_324_30 <= arg_321_1.time_ and arg_321_1.time_ < var_324_30 + var_324_40 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_30) / var_324_40

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_30 + var_324_40 and arg_321_1.time_ < var_324_30 + var_324_40 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_321_1:InitPlayNodeList()
	end,
	Play1101105079 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 1101105079
		arg_325_1.duration_ = 3.17

		local var_325_0 = {
			zh = 3.166,
			ja = 2.866
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
				arg_325_0:Play1101105080(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			local var_328_0 = arg_325_1.actors_["1033ui_story"].transform
			local var_328_1 = 0

			if var_328_1 < arg_325_1.time_ and arg_325_1.time_ <= var_328_1 + arg_328_0 then
				arg_325_1.var_.moveOldPos1033ui_story = var_328_0.localPosition
			end

			local var_328_2 = 0.001

			if var_328_1 <= arg_325_1.time_ and arg_325_1.time_ < var_328_1 + var_328_2 then
				local var_328_3 = (arg_325_1.time_ - var_328_1) / var_328_2
				local var_328_4 = Vector3.New(0, 100, 0)

				var_328_0.localPosition = Vector3.Lerp(arg_325_1.var_.moveOldPos1033ui_story, var_328_4, var_328_3)

				local var_328_5 = manager.ui.mainCamera.transform.position - var_328_0.position

				var_328_0.forward = Vector3.New(var_328_5.x, var_328_5.y, var_328_5.z)

				local var_328_6 = var_328_0.localEulerAngles

				var_328_6.z = 0
				var_328_6.x = 0
				var_328_0.localEulerAngles = var_328_6
			end

			if arg_325_1.time_ >= var_328_1 + var_328_2 and arg_325_1.time_ < var_328_1 + var_328_2 + arg_328_0 then
				var_328_0.localPosition = Vector3.New(0, 100, 0)

				local var_328_7 = manager.ui.mainCamera.transform.position - var_328_0.position

				var_328_0.forward = Vector3.New(var_328_7.x, var_328_7.y, var_328_7.z)

				local var_328_8 = var_328_0.localEulerAngles

				var_328_8.z = 0
				var_328_8.x = 0
				var_328_0.localEulerAngles = var_328_8
			end

			local var_328_9 = arg_325_1.actors_["1033ui_story"]
			local var_328_10 = 0

			if var_328_10 < arg_325_1.time_ and arg_325_1.time_ <= var_328_10 + arg_328_0 and not isNil(var_328_9) and arg_325_1.var_.characterEffect1033ui_story == nil then
				arg_325_1.var_.characterEffect1033ui_story = var_328_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_328_11 = 0.200000002980232

			if var_328_10 <= arg_325_1.time_ and arg_325_1.time_ < var_328_10 + var_328_11 and not isNil(var_328_9) then
				local var_328_12 = (arg_325_1.time_ - var_328_10) / var_328_11

				if arg_325_1.var_.characterEffect1033ui_story and not isNil(var_328_9) then
					local var_328_13 = Mathf.Lerp(0, 0.5, var_328_12)

					arg_325_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_325_1.var_.characterEffect1033ui_story.fillRatio = var_328_13
				end
			end

			if arg_325_1.time_ >= var_328_10 + var_328_11 and arg_325_1.time_ < var_328_10 + var_328_11 + arg_328_0 and not isNil(var_328_9) and arg_325_1.var_.characterEffect1033ui_story then
				local var_328_14 = 0.5

				arg_325_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_325_1.var_.characterEffect1033ui_story.fillRatio = var_328_14
			end

			local var_328_15 = arg_325_1.actors_["1011ui_story"].transform
			local var_328_16 = 0

			if var_328_16 < arg_325_1.time_ and arg_325_1.time_ <= var_328_16 + arg_328_0 then
				arg_325_1.var_.moveOldPos1011ui_story = var_328_15.localPosition
			end

			local var_328_17 = 0.001

			if var_328_16 <= arg_325_1.time_ and arg_325_1.time_ < var_328_16 + var_328_17 then
				local var_328_18 = (arg_325_1.time_ - var_328_16) / var_328_17
				local var_328_19 = Vector3.New(-0.7, -0.71, -6)

				var_328_15.localPosition = Vector3.Lerp(arg_325_1.var_.moveOldPos1011ui_story, var_328_19, var_328_18)

				local var_328_20 = manager.ui.mainCamera.transform.position - var_328_15.position

				var_328_15.forward = Vector3.New(var_328_20.x, var_328_20.y, var_328_20.z)

				local var_328_21 = var_328_15.localEulerAngles

				var_328_21.z = 0
				var_328_21.x = 0
				var_328_15.localEulerAngles = var_328_21
			end

			if arg_325_1.time_ >= var_328_16 + var_328_17 and arg_325_1.time_ < var_328_16 + var_328_17 + arg_328_0 then
				var_328_15.localPosition = Vector3.New(-0.7, -0.71, -6)

				local var_328_22 = manager.ui.mainCamera.transform.position - var_328_15.position

				var_328_15.forward = Vector3.New(var_328_22.x, var_328_22.y, var_328_22.z)

				local var_328_23 = var_328_15.localEulerAngles

				var_328_23.z = 0
				var_328_23.x = 0
				var_328_15.localEulerAngles = var_328_23
			end

			local var_328_24 = arg_325_1.actors_["1011ui_story"]
			local var_328_25 = 0

			if var_328_25 < arg_325_1.time_ and arg_325_1.time_ <= var_328_25 + arg_328_0 and not isNil(var_328_24) and arg_325_1.var_.characterEffect1011ui_story == nil then
				arg_325_1.var_.characterEffect1011ui_story = var_328_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_328_26 = 0.200000002980232

			if var_328_25 <= arg_325_1.time_ and arg_325_1.time_ < var_328_25 + var_328_26 and not isNil(var_328_24) then
				local var_328_27 = (arg_325_1.time_ - var_328_25) / var_328_26

				if arg_325_1.var_.characterEffect1011ui_story and not isNil(var_328_24) then
					arg_325_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_325_1.time_ >= var_328_25 + var_328_26 and arg_325_1.time_ < var_328_25 + var_328_26 + arg_328_0 and not isNil(var_328_24) and arg_325_1.var_.characterEffect1011ui_story then
				arg_325_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_328_28 = "1111ui_story"

			if arg_325_1.actors_[var_328_28] == nil then
				local var_328_29 = Asset.Load("Char/" .. "1111ui_story")

				if not isNil(var_328_29) then
					local var_328_30 = Object.Instantiate(Asset.Load("Char/" .. "1111ui_story"), arg_325_1.stage_.transform)

					var_328_30.name = var_328_28
					var_328_30.transform.localPosition = Vector3.New(0, 100, 0)
					arg_325_1.actors_[var_328_28] = var_328_30

					local var_328_31 = var_328_30:GetComponentInChildren(typeof(CharacterEffect))

					var_328_31.enabled = true

					local var_328_32 = GameObjectTools.GetOrAddComponent(var_328_30, typeof(DynamicBoneHelper))

					if var_328_32 then
						var_328_32:EnableDynamicBone(false)
					end

					arg_325_1:ShowWeapon(var_328_31.transform, false)

					arg_325_1.var_[var_328_28 .. "Animator"] = var_328_31.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_325_1.var_[var_328_28 .. "Animator"].applyRootMotion = true
					arg_325_1.var_[var_328_28 .. "LipSync"] = var_328_31.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_328_33 = arg_325_1.actors_["1111ui_story"].transform
			local var_328_34 = 0

			if var_328_34 < arg_325_1.time_ and arg_325_1.time_ <= var_328_34 + arg_328_0 then
				arg_325_1.var_.moveOldPos1111ui_story = var_328_33.localPosition
			end

			local var_328_35 = 0.001

			if var_328_34 <= arg_325_1.time_ and arg_325_1.time_ < var_328_34 + var_328_35 then
				local var_328_36 = (arg_325_1.time_ - var_328_34) / var_328_35
				local var_328_37 = Vector3.New(0.7, -0.7, -6)

				var_328_33.localPosition = Vector3.Lerp(arg_325_1.var_.moveOldPos1111ui_story, var_328_37, var_328_36)

				local var_328_38 = manager.ui.mainCamera.transform.position - var_328_33.position

				var_328_33.forward = Vector3.New(var_328_38.x, var_328_38.y, var_328_38.z)

				local var_328_39 = var_328_33.localEulerAngles

				var_328_39.z = 0
				var_328_39.x = 0
				var_328_33.localEulerAngles = var_328_39
			end

			if arg_325_1.time_ >= var_328_34 + var_328_35 and arg_325_1.time_ < var_328_34 + var_328_35 + arg_328_0 then
				var_328_33.localPosition = Vector3.New(0.7, -0.7, -6)

				local var_328_40 = manager.ui.mainCamera.transform.position - var_328_33.position

				var_328_33.forward = Vector3.New(var_328_40.x, var_328_40.y, var_328_40.z)

				local var_328_41 = var_328_33.localEulerAngles

				var_328_41.z = 0
				var_328_41.x = 0
				var_328_33.localEulerAngles = var_328_41
			end

			local var_328_42 = arg_325_1.actors_["1111ui_story"]
			local var_328_43 = 0

			if var_328_43 < arg_325_1.time_ and arg_325_1.time_ <= var_328_43 + arg_328_0 and not isNil(var_328_42) and arg_325_1.var_.characterEffect1111ui_story == nil then
				arg_325_1.var_.characterEffect1111ui_story = var_328_42:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_328_44 = 0.200000002980232

			if var_328_43 <= arg_325_1.time_ and arg_325_1.time_ < var_328_43 + var_328_44 and not isNil(var_328_42) then
				local var_328_45 = (arg_325_1.time_ - var_328_43) / var_328_44

				if arg_325_1.var_.characterEffect1111ui_story and not isNil(var_328_42) then
					arg_325_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_325_1.time_ >= var_328_43 + var_328_44 and arg_325_1.time_ < var_328_43 + var_328_44 + arg_328_0 and not isNil(var_328_42) and arg_325_1.var_.characterEffect1111ui_story then
				arg_325_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_328_46 = 0

			if var_328_46 < arg_325_1.time_ and arg_325_1.time_ <= var_328_46 + arg_328_0 then
				arg_325_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action1_1")
			end

			local var_328_47 = 0

			if var_328_47 < arg_325_1.time_ and arg_325_1.time_ <= var_328_47 + arg_328_0 then
				arg_325_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action1_1")
			end

			local var_328_48 = 0

			if var_328_48 < arg_325_1.time_ and arg_325_1.time_ <= var_328_48 + arg_328_0 then
				arg_325_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_328_49 = 0

			if var_328_49 < arg_325_1.time_ and arg_325_1.time_ <= var_328_49 + arg_328_0 then
				arg_325_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_328_50 = 0
			local var_328_51 = 0.325

			if var_328_50 < arg_325_1.time_ and arg_325_1.time_ <= var_328_50 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				local var_328_52 = arg_325_1:FormatText(StoryNameCfg[582].name)

				arg_325_1.leftNameTxt_.text = var_328_52

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_53 = arg_325_1:GetWordFromCfg(1101105079)
				local var_328_54 = arg_325_1:FormatText(var_328_53.content)

				arg_325_1.text_.text = var_328_54

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_55 = 13
				local var_328_56 = utf8.len(var_328_54)
				local var_328_57 = var_328_55 <= 0 and var_328_51 or var_328_51 * (var_328_56 / var_328_55)

				if var_328_57 > 0 and var_328_51 < var_328_57 then
					arg_325_1.talkMaxDuration = var_328_57

					if var_328_57 + var_328_50 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_57 + var_328_50
					end
				end

				arg_325_1.text_.text = var_328_54
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105079", "story_v_side_new_1101105.awb") ~= 0 then
					local var_328_58 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105079", "story_v_side_new_1101105.awb") / 1000

					if var_328_58 + var_328_50 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_58 + var_328_50
					end

					if var_328_53.prefab_name ~= "" and arg_325_1.actors_[var_328_53.prefab_name] ~= nil then
						local var_328_59 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_53.prefab_name].transform, "story_v_side_new_1101105", "1101105079", "story_v_side_new_1101105.awb")

						arg_325_1:RecordAudio("1101105079", var_328_59)
						arg_325_1:RecordAudio("1101105079", var_328_59)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105079", "story_v_side_new_1101105.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105079", "story_v_side_new_1101105.awb")
				end

				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_60 = math.max(var_328_51, arg_325_1.talkMaxDuration)

			if var_328_50 <= arg_325_1.time_ and arg_325_1.time_ < var_328_50 + var_328_60 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_50) / var_328_60

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_50 + var_328_60 and arg_325_1.time_ < var_328_50 + var_328_60 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
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

		arg_325_1:InitPlayNodeList()
	end,
	Play1101105080 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 1101105080
		arg_329_1.duration_ = 7.3

		local var_329_0 = {
			zh = 5.999999999999,
			ja = 7.3
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
				arg_329_0:Play1101105081(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			local var_332_0 = 2

			if var_332_0 < arg_329_1.time_ and arg_329_1.time_ <= var_332_0 + arg_332_0 then
				local var_332_1 = manager.ui.mainCamera.transform.localPosition
				local var_332_2 = Vector3.New(0, 0, 10) + Vector3.New(var_332_1.x, var_332_1.y, 0)
				local var_332_3 = arg_329_1.bgs_.D999

				var_332_3.transform.localPosition = var_332_2
				var_332_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_332_4 = var_332_3:GetComponent("SpriteRenderer")

				if var_332_4 and var_332_4.sprite then
					local var_332_5 = (var_332_3.transform.localPosition - var_332_1).z
					local var_332_6 = manager.ui.mainCameraCom_
					local var_332_7 = 2 * var_332_5 * Mathf.Tan(var_332_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_332_8 = var_332_7 * var_332_6.aspect
					local var_332_9 = var_332_4.sprite.bounds.size.x
					local var_332_10 = var_332_4.sprite.bounds.size.y
					local var_332_11 = var_332_8 / var_332_9
					local var_332_12 = var_332_7 / var_332_10
					local var_332_13 = var_332_12 < var_332_11 and var_332_11 or var_332_12

					var_332_3.transform.localScale = Vector3.New(var_332_13, var_332_13, 0)
				end

				for iter_332_0, iter_332_1 in pairs(arg_329_1.bgs_) do
					if iter_332_0 ~= "D999" then
						iter_332_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_332_14 = 0

			if var_332_14 < arg_329_1.time_ and arg_329_1.time_ <= var_332_14 + arg_332_0 then
				arg_329_1.mask_.enabled = true
				arg_329_1.mask_.raycastTarget = true

				arg_329_1:SetGaussion(false)
			end

			local var_332_15 = 2

			if var_332_14 <= arg_329_1.time_ and arg_329_1.time_ < var_332_14 + var_332_15 then
				local var_332_16 = (arg_329_1.time_ - var_332_14) / var_332_15
				local var_332_17 = Color.New(0, 0, 0)

				var_332_17.a = Mathf.Lerp(0, 1, var_332_16)
				arg_329_1.mask_.color = var_332_17
			end

			if arg_329_1.time_ >= var_332_14 + var_332_15 and arg_329_1.time_ < var_332_14 + var_332_15 + arg_332_0 then
				local var_332_18 = Color.New(0, 0, 0)

				var_332_18.a = 1
				arg_329_1.mask_.color = var_332_18
			end

			local var_332_19 = 2

			if var_332_19 < arg_329_1.time_ and arg_329_1.time_ <= var_332_19 + arg_332_0 then
				arg_329_1.mask_.enabled = true
				arg_329_1.mask_.raycastTarget = true

				arg_329_1:SetGaussion(false)
			end

			local var_332_20 = 2

			if var_332_19 <= arg_329_1.time_ and arg_329_1.time_ < var_332_19 + var_332_20 then
				local var_332_21 = (arg_329_1.time_ - var_332_19) / var_332_20
				local var_332_22 = Color.New(0, 0, 0)

				var_332_22.a = Mathf.Lerp(1, 0, var_332_21)
				arg_329_1.mask_.color = var_332_22
			end

			if arg_329_1.time_ >= var_332_19 + var_332_20 and arg_329_1.time_ < var_332_19 + var_332_20 + arg_332_0 then
				local var_332_23 = Color.New(0, 0, 0)
				local var_332_24 = 0

				arg_329_1.mask_.enabled = false
				var_332_23.a = var_332_24
				arg_329_1.mask_.color = var_332_23
			end

			local var_332_25 = arg_329_1.actors_["1111ui_story"].transform
			local var_332_26 = 4

			if var_332_26 < arg_329_1.time_ and arg_329_1.time_ <= var_332_26 + arg_332_0 then
				arg_329_1.var_.moveOldPos1111ui_story = var_332_25.localPosition
			end

			local var_332_27 = 0.001

			if var_332_26 <= arg_329_1.time_ and arg_329_1.time_ < var_332_26 + var_332_27 then
				local var_332_28 = (arg_329_1.time_ - var_332_26) / var_332_27
				local var_332_29 = Vector3.New(0.7, -0.87, -5.7)

				var_332_25.localPosition = Vector3.Lerp(arg_329_1.var_.moveOldPos1111ui_story, var_332_29, var_332_28)

				local var_332_30 = manager.ui.mainCamera.transform.position - var_332_25.position

				var_332_25.forward = Vector3.New(var_332_30.x, var_332_30.y, var_332_30.z)

				local var_332_31 = var_332_25.localEulerAngles

				var_332_31.z = 0
				var_332_31.x = 0
				var_332_25.localEulerAngles = var_332_31
			end

			if arg_329_1.time_ >= var_332_26 + var_332_27 and arg_329_1.time_ < var_332_26 + var_332_27 + arg_332_0 then
				var_332_25.localPosition = Vector3.New(0.7, -0.87, -5.7)

				local var_332_32 = manager.ui.mainCamera.transform.position - var_332_25.position

				var_332_25.forward = Vector3.New(var_332_32.x, var_332_32.y, var_332_32.z)

				local var_332_33 = var_332_25.localEulerAngles

				var_332_33.z = 0
				var_332_33.x = 0
				var_332_25.localEulerAngles = var_332_33
			end

			local var_332_34 = arg_329_1.actors_["1111ui_story"]
			local var_332_35 = 4

			if var_332_35 < arg_329_1.time_ and arg_329_1.time_ <= var_332_35 + arg_332_0 and not isNil(var_332_34) and arg_329_1.var_.characterEffect1111ui_story == nil then
				arg_329_1.var_.characterEffect1111ui_story = var_332_34:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_332_36 = 0.200000002980232

			if var_332_35 <= arg_329_1.time_ and arg_329_1.time_ < var_332_35 + var_332_36 and not isNil(var_332_34) then
				local var_332_37 = (arg_329_1.time_ - var_332_35) / var_332_36

				if arg_329_1.var_.characterEffect1111ui_story and not isNil(var_332_34) then
					arg_329_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_329_1.time_ >= var_332_35 + var_332_36 and arg_329_1.time_ < var_332_35 + var_332_36 + arg_332_0 and not isNil(var_332_34) and arg_329_1.var_.characterEffect1111ui_story then
				arg_329_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_332_38 = 4

			if var_332_38 < arg_329_1.time_ and arg_329_1.time_ <= var_332_38 + arg_332_0 then
				arg_329_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action1_1")
			end

			local var_332_39 = 4

			if var_332_39 < arg_329_1.time_ and arg_329_1.time_ <= var_332_39 + arg_332_0 then
				arg_329_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_332_40 = arg_329_1.actors_["1011ui_story"].transform
			local var_332_41 = 2

			if var_332_41 < arg_329_1.time_ and arg_329_1.time_ <= var_332_41 + arg_332_0 then
				arg_329_1.var_.moveOldPos1011ui_story = var_332_40.localPosition
			end

			local var_332_42 = 0.001

			if var_332_41 <= arg_329_1.time_ and arg_329_1.time_ < var_332_41 + var_332_42 then
				local var_332_43 = (arg_329_1.time_ - var_332_41) / var_332_42
				local var_332_44 = Vector3.New(0, 100, 0)

				var_332_40.localPosition = Vector3.Lerp(arg_329_1.var_.moveOldPos1011ui_story, var_332_44, var_332_43)

				local var_332_45 = manager.ui.mainCamera.transform.position - var_332_40.position

				var_332_40.forward = Vector3.New(var_332_45.x, var_332_45.y, var_332_45.z)

				local var_332_46 = var_332_40.localEulerAngles

				var_332_46.z = 0
				var_332_46.x = 0
				var_332_40.localEulerAngles = var_332_46
			end

			if arg_329_1.time_ >= var_332_41 + var_332_42 and arg_329_1.time_ < var_332_41 + var_332_42 + arg_332_0 then
				var_332_40.localPosition = Vector3.New(0, 100, 0)

				local var_332_47 = manager.ui.mainCamera.transform.position - var_332_40.position

				var_332_40.forward = Vector3.New(var_332_47.x, var_332_47.y, var_332_47.z)

				local var_332_48 = var_332_40.localEulerAngles

				var_332_48.z = 0
				var_332_48.x = 0
				var_332_40.localEulerAngles = var_332_48
			end

			local var_332_49 = arg_329_1.actors_["1111ui_story"].transform
			local var_332_50 = 2

			if var_332_50 < arg_329_1.time_ and arg_329_1.time_ <= var_332_50 + arg_332_0 then
				arg_329_1.var_.moveOldPos1111ui_story = var_332_49.localPosition
			end

			local var_332_51 = 0.001

			if var_332_50 <= arg_329_1.time_ and arg_329_1.time_ < var_332_50 + var_332_51 then
				local var_332_52 = (arg_329_1.time_ - var_332_50) / var_332_51
				local var_332_53 = Vector3.New(0, 100, 0)

				var_332_49.localPosition = Vector3.Lerp(arg_329_1.var_.moveOldPos1111ui_story, var_332_53, var_332_52)

				local var_332_54 = manager.ui.mainCamera.transform.position - var_332_49.position

				var_332_49.forward = Vector3.New(var_332_54.x, var_332_54.y, var_332_54.z)

				local var_332_55 = var_332_49.localEulerAngles

				var_332_55.z = 0
				var_332_55.x = 0
				var_332_49.localEulerAngles = var_332_55
			end

			if arg_329_1.time_ >= var_332_50 + var_332_51 and arg_329_1.time_ < var_332_50 + var_332_51 + arg_332_0 then
				var_332_49.localPosition = Vector3.New(0, 100, 0)

				local var_332_56 = manager.ui.mainCamera.transform.position - var_332_49.position

				var_332_49.forward = Vector3.New(var_332_56.x, var_332_56.y, var_332_56.z)

				local var_332_57 = var_332_49.localEulerAngles

				var_332_57.z = 0
				var_332_57.x = 0
				var_332_49.localEulerAngles = var_332_57
			end

			local var_332_58 = arg_329_1.actors_["1011ui_story"].transform
			local var_332_59 = 4

			if var_332_59 < arg_329_1.time_ and arg_329_1.time_ <= var_332_59 + arg_332_0 then
				arg_329_1.var_.moveOldPos1011ui_story = var_332_58.localPosition
			end

			local var_332_60 = 0.001

			if var_332_59 <= arg_329_1.time_ and arg_329_1.time_ < var_332_59 + var_332_60 then
				local var_332_61 = (arg_329_1.time_ - var_332_59) / var_332_60
				local var_332_62 = Vector3.New(-0.7, -0.71, -6)

				var_332_58.localPosition = Vector3.Lerp(arg_329_1.var_.moveOldPos1011ui_story, var_332_62, var_332_61)

				local var_332_63 = manager.ui.mainCamera.transform.position - var_332_58.position

				var_332_58.forward = Vector3.New(var_332_63.x, var_332_63.y, var_332_63.z)

				local var_332_64 = var_332_58.localEulerAngles

				var_332_64.z = 0
				var_332_64.x = 0
				var_332_58.localEulerAngles = var_332_64
			end

			if arg_329_1.time_ >= var_332_59 + var_332_60 and arg_329_1.time_ < var_332_59 + var_332_60 + arg_332_0 then
				var_332_58.localPosition = Vector3.New(-0.7, -0.71, -6)

				local var_332_65 = manager.ui.mainCamera.transform.position - var_332_58.position

				var_332_58.forward = Vector3.New(var_332_65.x, var_332_65.y, var_332_65.z)

				local var_332_66 = var_332_58.localEulerAngles

				var_332_66.z = 0
				var_332_66.x = 0
				var_332_58.localEulerAngles = var_332_66
			end

			local var_332_67 = 4

			if var_332_67 < arg_329_1.time_ and arg_329_1.time_ <= var_332_67 + arg_332_0 then
				arg_329_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action1_1")
			end

			local var_332_68 = 4

			if var_332_68 < arg_329_1.time_ and arg_329_1.time_ <= var_332_68 + arg_332_0 then
				arg_329_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			if arg_329_1.frameCnt_ <= 1 then
				arg_329_1.dialog_:SetActive(false)
			end

			local var_332_69 = 4
			local var_332_70 = 0.125

			if var_332_69 < arg_329_1.time_ and arg_329_1.time_ <= var_332_69 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0

				arg_329_1.dialog_:SetActive(true)

				arg_329_1.dialogCg_.alpha = 0

				local var_332_71 = LeanTween.value(arg_329_1.dialog_, 0, 1, 0.3)

				var_332_71:setOnUpdate(LuaHelper.FloatAction(function(arg_333_0)
					arg_329_1.dialogCg_.alpha = arg_333_0
				end))
				var_332_71:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_329_1.dialog_)
					var_332_71:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_329_1.duration_ = arg_329_1.duration_ + 0.3

				SetActive(arg_329_1.leftNameGo_, true)

				local var_332_72 = arg_329_1:FormatText(StoryNameCfg[67].name)

				arg_329_1.leftNameTxt_.text = var_332_72

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_73 = arg_329_1:GetWordFromCfg(1101105080)
				local var_332_74 = arg_329_1:FormatText(var_332_73.content)

				arg_329_1.text_.text = var_332_74

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_75 = 5
				local var_332_76 = utf8.len(var_332_74)
				local var_332_77 = var_332_75 <= 0 and var_332_70 or var_332_70 * (var_332_76 / var_332_75)

				if var_332_77 > 0 and var_332_70 < var_332_77 then
					arg_329_1.talkMaxDuration = var_332_77
					var_332_69 = var_332_69 + 0.3

					if var_332_77 + var_332_69 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_77 + var_332_69
					end
				end

				arg_329_1.text_.text = var_332_74
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105080", "story_v_side_new_1101105.awb") ~= 0 then
					local var_332_78 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105080", "story_v_side_new_1101105.awb") / 1000

					if var_332_78 + var_332_69 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_78 + var_332_69
					end

					if var_332_73.prefab_name ~= "" and arg_329_1.actors_[var_332_73.prefab_name] ~= nil then
						local var_332_79 = LuaForUtil.PlayVoiceWithCriLipsync(arg_329_1.actors_[var_332_73.prefab_name].transform, "story_v_side_new_1101105", "1101105080", "story_v_side_new_1101105.awb")

						arg_329_1:RecordAudio("1101105080", var_332_79)
						arg_329_1:RecordAudio("1101105080", var_332_79)
					else
						arg_329_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105080", "story_v_side_new_1101105.awb")
					end

					arg_329_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105080", "story_v_side_new_1101105.awb")
				end

				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_80 = var_332_69 + 0.3
			local var_332_81 = math.max(var_332_70, arg_329_1.talkMaxDuration)

			if var_332_80 <= arg_329_1.time_ and arg_329_1.time_ < var_332_80 + var_332_81 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_80) / var_332_81

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_80 + var_332_81 and arg_329_1.time_ < var_332_80 + var_332_81 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_329_1:InitPlayNodeList()
	end,
	Play1101105081 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 1101105081
		arg_335_1.duration_ = 3.4

		local var_335_0 = {
			zh = 2.933,
			ja = 3.4
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
				arg_335_0:Play1101105082(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			local var_338_0 = arg_335_1.actors_["1011ui_story"].transform
			local var_338_1 = 0

			if var_338_1 < arg_335_1.time_ and arg_335_1.time_ <= var_338_1 + arg_338_0 then
				arg_335_1.var_.moveOldPos1011ui_story = var_338_0.localPosition
			end

			local var_338_2 = 0.001

			if var_338_1 <= arg_335_1.time_ and arg_335_1.time_ < var_338_1 + var_338_2 then
				local var_338_3 = (arg_335_1.time_ - var_338_1) / var_338_2
				local var_338_4 = Vector3.New(-0.7, -0.71, -6)

				var_338_0.localPosition = Vector3.Lerp(arg_335_1.var_.moveOldPos1011ui_story, var_338_4, var_338_3)

				local var_338_5 = manager.ui.mainCamera.transform.position - var_338_0.position

				var_338_0.forward = Vector3.New(var_338_5.x, var_338_5.y, var_338_5.z)

				local var_338_6 = var_338_0.localEulerAngles

				var_338_6.z = 0
				var_338_6.x = 0
				var_338_0.localEulerAngles = var_338_6
			end

			if arg_335_1.time_ >= var_338_1 + var_338_2 and arg_335_1.time_ < var_338_1 + var_338_2 + arg_338_0 then
				var_338_0.localPosition = Vector3.New(-0.7, -0.71, -6)

				local var_338_7 = manager.ui.mainCamera.transform.position - var_338_0.position

				var_338_0.forward = Vector3.New(var_338_7.x, var_338_7.y, var_338_7.z)

				local var_338_8 = var_338_0.localEulerAngles

				var_338_8.z = 0
				var_338_8.x = 0
				var_338_0.localEulerAngles = var_338_8
			end

			local var_338_9 = arg_335_1.actors_["1011ui_story"]
			local var_338_10 = 0

			if var_338_10 < arg_335_1.time_ and arg_335_1.time_ <= var_338_10 + arg_338_0 and not isNil(var_338_9) and arg_335_1.var_.characterEffect1011ui_story == nil then
				arg_335_1.var_.characterEffect1011ui_story = var_338_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_338_11 = 0.200000002980232

			if var_338_10 <= arg_335_1.time_ and arg_335_1.time_ < var_338_10 + var_338_11 and not isNil(var_338_9) then
				local var_338_12 = (arg_335_1.time_ - var_338_10) / var_338_11

				if arg_335_1.var_.characterEffect1011ui_story and not isNil(var_338_9) then
					arg_335_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_335_1.time_ >= var_338_10 + var_338_11 and arg_335_1.time_ < var_338_10 + var_338_11 + arg_338_0 and not isNil(var_338_9) and arg_335_1.var_.characterEffect1011ui_story then
				arg_335_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_338_13 = 0

			if var_338_13 < arg_335_1.time_ and arg_335_1.time_ <= var_338_13 + arg_338_0 then
				arg_335_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action1_1")
			end

			local var_338_14 = 0

			if var_338_14 < arg_335_1.time_ and arg_335_1.time_ <= var_338_14 + arg_338_0 then
				arg_335_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_338_15 = arg_335_1.actors_["1111ui_story"]
			local var_338_16 = 0

			if var_338_16 < arg_335_1.time_ and arg_335_1.time_ <= var_338_16 + arg_338_0 and not isNil(var_338_15) and arg_335_1.var_.characterEffect1111ui_story == nil then
				arg_335_1.var_.characterEffect1111ui_story = var_338_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_338_17 = 0.200000002980232

			if var_338_16 <= arg_335_1.time_ and arg_335_1.time_ < var_338_16 + var_338_17 and not isNil(var_338_15) then
				local var_338_18 = (arg_335_1.time_ - var_338_16) / var_338_17

				if arg_335_1.var_.characterEffect1111ui_story and not isNil(var_338_15) then
					local var_338_19 = Mathf.Lerp(0, 0.5, var_338_18)

					arg_335_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_335_1.var_.characterEffect1111ui_story.fillRatio = var_338_19
				end
			end

			if arg_335_1.time_ >= var_338_16 + var_338_17 and arg_335_1.time_ < var_338_16 + var_338_17 + arg_338_0 and not isNil(var_338_15) and arg_335_1.var_.characterEffect1111ui_story then
				local var_338_20 = 0.5

				arg_335_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_335_1.var_.characterEffect1111ui_story.fillRatio = var_338_20
			end

			local var_338_21 = 0
			local var_338_22 = 0.175

			if var_338_21 < arg_335_1.time_ and arg_335_1.time_ <= var_338_21 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				local var_338_23 = arg_335_1:FormatText(StoryNameCfg[37].name)

				arg_335_1.leftNameTxt_.text = var_338_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, false)
				arg_335_1.callingController_:SetSelectedState("normal")

				local var_338_24 = arg_335_1:GetWordFromCfg(1101105081)
				local var_338_25 = arg_335_1:FormatText(var_338_24.content)

				arg_335_1.text_.text = var_338_25

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_26 = 7
				local var_338_27 = utf8.len(var_338_25)
				local var_338_28 = var_338_26 <= 0 and var_338_22 or var_338_22 * (var_338_27 / var_338_26)

				if var_338_28 > 0 and var_338_22 < var_338_28 then
					arg_335_1.talkMaxDuration = var_338_28

					if var_338_28 + var_338_21 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_28 + var_338_21
					end
				end

				arg_335_1.text_.text = var_338_25
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105081", "story_v_side_new_1101105.awb") ~= 0 then
					local var_338_29 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105081", "story_v_side_new_1101105.awb") / 1000

					if var_338_29 + var_338_21 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_29 + var_338_21
					end

					if var_338_24.prefab_name ~= "" and arg_335_1.actors_[var_338_24.prefab_name] ~= nil then
						local var_338_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_335_1.actors_[var_338_24.prefab_name].transform, "story_v_side_new_1101105", "1101105081", "story_v_side_new_1101105.awb")

						arg_335_1:RecordAudio("1101105081", var_338_30)
						arg_335_1:RecordAudio("1101105081", var_338_30)
					else
						arg_335_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105081", "story_v_side_new_1101105.awb")
					end

					arg_335_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105081", "story_v_side_new_1101105.awb")
				end

				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_31 = math.max(var_338_22, arg_335_1.talkMaxDuration)

			if var_338_21 <= arg_335_1.time_ and arg_335_1.time_ < var_338_21 + var_338_31 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - var_338_21) / var_338_31

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= var_338_21 + var_338_31 and arg_335_1.time_ < var_338_21 + var_338_31 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_335_1:InitPlayNodeList()
	end,
	Play1101105082 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 1101105082
		arg_339_1.duration_ = 5.67

		local var_339_0 = {
			zh = 4.166,
			ja = 5.666
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
				arg_339_0:Play1101105083(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			local var_342_0 = arg_339_1.actors_["1111ui_story"].transform
			local var_342_1 = 0

			if var_342_1 < arg_339_1.time_ and arg_339_1.time_ <= var_342_1 + arg_342_0 then
				arg_339_1.var_.moveOldPos1111ui_story = var_342_0.localPosition
			end

			local var_342_2 = 0.001

			if var_342_1 <= arg_339_1.time_ and arg_339_1.time_ < var_342_1 + var_342_2 then
				local var_342_3 = (arg_339_1.time_ - var_342_1) / var_342_2
				local var_342_4 = Vector3.New(0.7, -0.87, -5.7)

				var_342_0.localPosition = Vector3.Lerp(arg_339_1.var_.moveOldPos1111ui_story, var_342_4, var_342_3)

				local var_342_5 = manager.ui.mainCamera.transform.position - var_342_0.position

				var_342_0.forward = Vector3.New(var_342_5.x, var_342_5.y, var_342_5.z)

				local var_342_6 = var_342_0.localEulerAngles

				var_342_6.z = 0
				var_342_6.x = 0
				var_342_0.localEulerAngles = var_342_6
			end

			if arg_339_1.time_ >= var_342_1 + var_342_2 and arg_339_1.time_ < var_342_1 + var_342_2 + arg_342_0 then
				var_342_0.localPosition = Vector3.New(0.7, -0.87, -5.7)

				local var_342_7 = manager.ui.mainCamera.transform.position - var_342_0.position

				var_342_0.forward = Vector3.New(var_342_7.x, var_342_7.y, var_342_7.z)

				local var_342_8 = var_342_0.localEulerAngles

				var_342_8.z = 0
				var_342_8.x = 0
				var_342_0.localEulerAngles = var_342_8
			end

			local var_342_9 = arg_339_1.actors_["1111ui_story"]
			local var_342_10 = 0

			if var_342_10 < arg_339_1.time_ and arg_339_1.time_ <= var_342_10 + arg_342_0 and not isNil(var_342_9) and arg_339_1.var_.characterEffect1111ui_story == nil then
				arg_339_1.var_.characterEffect1111ui_story = var_342_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_342_11 = 0.200000002980232

			if var_342_10 <= arg_339_1.time_ and arg_339_1.time_ < var_342_10 + var_342_11 and not isNil(var_342_9) then
				local var_342_12 = (arg_339_1.time_ - var_342_10) / var_342_11

				if arg_339_1.var_.characterEffect1111ui_story and not isNil(var_342_9) then
					arg_339_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_339_1.time_ >= var_342_10 + var_342_11 and arg_339_1.time_ < var_342_10 + var_342_11 + arg_342_0 and not isNil(var_342_9) and arg_339_1.var_.characterEffect1111ui_story then
				arg_339_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_342_13 = 0

			if var_342_13 < arg_339_1.time_ and arg_339_1.time_ <= var_342_13 + arg_342_0 then
				arg_339_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action1_1")
			end

			local var_342_14 = 0

			if var_342_14 < arg_339_1.time_ and arg_339_1.time_ <= var_342_14 + arg_342_0 then
				arg_339_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_342_15 = arg_339_1.actors_["1011ui_story"]
			local var_342_16 = 0

			if var_342_16 < arg_339_1.time_ and arg_339_1.time_ <= var_342_16 + arg_342_0 and not isNil(var_342_15) and arg_339_1.var_.characterEffect1011ui_story == nil then
				arg_339_1.var_.characterEffect1011ui_story = var_342_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_342_17 = 0.200000002980232

			if var_342_16 <= arg_339_1.time_ and arg_339_1.time_ < var_342_16 + var_342_17 and not isNil(var_342_15) then
				local var_342_18 = (arg_339_1.time_ - var_342_16) / var_342_17

				if arg_339_1.var_.characterEffect1011ui_story and not isNil(var_342_15) then
					local var_342_19 = Mathf.Lerp(0, 0.5, var_342_18)

					arg_339_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_339_1.var_.characterEffect1011ui_story.fillRatio = var_342_19
				end
			end

			if arg_339_1.time_ >= var_342_16 + var_342_17 and arg_339_1.time_ < var_342_16 + var_342_17 + arg_342_0 and not isNil(var_342_15) and arg_339_1.var_.characterEffect1011ui_story then
				local var_342_20 = 0.5

				arg_339_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_339_1.var_.characterEffect1011ui_story.fillRatio = var_342_20
			end

			local var_342_21 = 0
			local var_342_22 = 0.825

			if var_342_21 < arg_339_1.time_ and arg_339_1.time_ <= var_342_21 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				local var_342_23 = arg_339_1:FormatText(StoryNameCfg[67].name)

				arg_339_1.leftNameTxt_.text = var_342_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, false)
				arg_339_1.callingController_:SetSelectedState("normal")

				local var_342_24 = arg_339_1:GetWordFromCfg(1101105082)
				local var_342_25 = arg_339_1:FormatText(var_342_24.content)

				arg_339_1.text_.text = var_342_25

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_26 = 33
				local var_342_27 = utf8.len(var_342_25)
				local var_342_28 = var_342_26 <= 0 and var_342_22 or var_342_22 * (var_342_27 / var_342_26)

				if var_342_28 > 0 and var_342_22 < var_342_28 then
					arg_339_1.talkMaxDuration = var_342_28

					if var_342_28 + var_342_21 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_28 + var_342_21
					end
				end

				arg_339_1.text_.text = var_342_25
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105082", "story_v_side_new_1101105.awb") ~= 0 then
					local var_342_29 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105082", "story_v_side_new_1101105.awb") / 1000

					if var_342_29 + var_342_21 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_29 + var_342_21
					end

					if var_342_24.prefab_name ~= "" and arg_339_1.actors_[var_342_24.prefab_name] ~= nil then
						local var_342_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_339_1.actors_[var_342_24.prefab_name].transform, "story_v_side_new_1101105", "1101105082", "story_v_side_new_1101105.awb")

						arg_339_1:RecordAudio("1101105082", var_342_30)
						arg_339_1:RecordAudio("1101105082", var_342_30)
					else
						arg_339_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105082", "story_v_side_new_1101105.awb")
					end

					arg_339_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105082", "story_v_side_new_1101105.awb")
				end

				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_31 = math.max(var_342_22, arg_339_1.talkMaxDuration)

			if var_342_21 <= arg_339_1.time_ and arg_339_1.time_ < var_342_21 + var_342_31 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_21) / var_342_31

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_21 + var_342_31 and arg_339_1.time_ < var_342_21 + var_342_31 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {
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

		arg_339_1:InitPlayNodeList()
	end,
	Play1101105083 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 1101105083
		arg_343_1.duration_ = 9

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play1101105084(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			local var_346_0 = "STblack"

			if arg_343_1.bgs_[var_346_0] == nil then
				local var_346_1 = Object.Instantiate(arg_343_1.paintGo_)

				var_346_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_346_0)
				var_346_1.name = var_346_0
				var_346_1.transform.parent = arg_343_1.stage_.transform
				var_346_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_343_1.bgs_[var_346_0] = var_346_1
			end

			local var_346_2 = 2

			if var_346_2 < arg_343_1.time_ and arg_343_1.time_ <= var_346_2 + arg_346_0 then
				local var_346_3 = manager.ui.mainCamera.transform.localPosition
				local var_346_4 = Vector3.New(0, 0, 10) + Vector3.New(var_346_3.x, var_346_3.y, 0)
				local var_346_5 = arg_343_1.bgs_.STblack

				var_346_5.transform.localPosition = var_346_4
				var_346_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_346_6 = var_346_5:GetComponent("SpriteRenderer")

				if var_346_6 and var_346_6.sprite then
					local var_346_7 = (var_346_5.transform.localPosition - var_346_3).z
					local var_346_8 = manager.ui.mainCameraCom_
					local var_346_9 = 2 * var_346_7 * Mathf.Tan(var_346_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_346_10 = var_346_9 * var_346_8.aspect
					local var_346_11 = var_346_6.sprite.bounds.size.x
					local var_346_12 = var_346_6.sprite.bounds.size.y
					local var_346_13 = var_346_10 / var_346_11
					local var_346_14 = var_346_9 / var_346_12
					local var_346_15 = var_346_14 < var_346_13 and var_346_13 or var_346_14

					var_346_5.transform.localScale = Vector3.New(var_346_15, var_346_15, 0)
				end

				for iter_346_0, iter_346_1 in pairs(arg_343_1.bgs_) do
					if iter_346_0 ~= "STblack" then
						iter_346_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_346_16 = arg_343_1.actors_["1011ui_story"].transform
			local var_346_17 = 2

			if var_346_17 < arg_343_1.time_ and arg_343_1.time_ <= var_346_17 + arg_346_0 then
				arg_343_1.var_.moveOldPos1011ui_story = var_346_16.localPosition
			end

			local var_346_18 = 0.001

			if var_346_17 <= arg_343_1.time_ and arg_343_1.time_ < var_346_17 + var_346_18 then
				local var_346_19 = (arg_343_1.time_ - var_346_17) / var_346_18
				local var_346_20 = Vector3.New(0, 100, 0)

				var_346_16.localPosition = Vector3.Lerp(arg_343_1.var_.moveOldPos1011ui_story, var_346_20, var_346_19)

				local var_346_21 = manager.ui.mainCamera.transform.position - var_346_16.position

				var_346_16.forward = Vector3.New(var_346_21.x, var_346_21.y, var_346_21.z)

				local var_346_22 = var_346_16.localEulerAngles

				var_346_22.z = 0
				var_346_22.x = 0
				var_346_16.localEulerAngles = var_346_22
			end

			if arg_343_1.time_ >= var_346_17 + var_346_18 and arg_343_1.time_ < var_346_17 + var_346_18 + arg_346_0 then
				var_346_16.localPosition = Vector3.New(0, 100, 0)

				local var_346_23 = manager.ui.mainCamera.transform.position - var_346_16.position

				var_346_16.forward = Vector3.New(var_346_23.x, var_346_23.y, var_346_23.z)

				local var_346_24 = var_346_16.localEulerAngles

				var_346_24.z = 0
				var_346_24.x = 0
				var_346_16.localEulerAngles = var_346_24
			end

			local var_346_25 = arg_343_1.actors_["1111ui_story"].transform
			local var_346_26 = 2

			if var_346_26 < arg_343_1.time_ and arg_343_1.time_ <= var_346_26 + arg_346_0 then
				arg_343_1.var_.moveOldPos1111ui_story = var_346_25.localPosition
			end

			local var_346_27 = 0.001

			if var_346_26 <= arg_343_1.time_ and arg_343_1.time_ < var_346_26 + var_346_27 then
				local var_346_28 = (arg_343_1.time_ - var_346_26) / var_346_27
				local var_346_29 = Vector3.New(0, 100, 0)

				var_346_25.localPosition = Vector3.Lerp(arg_343_1.var_.moveOldPos1111ui_story, var_346_29, var_346_28)

				local var_346_30 = manager.ui.mainCamera.transform.position - var_346_25.position

				var_346_25.forward = Vector3.New(var_346_30.x, var_346_30.y, var_346_30.z)

				local var_346_31 = var_346_25.localEulerAngles

				var_346_31.z = 0
				var_346_31.x = 0
				var_346_25.localEulerAngles = var_346_31
			end

			if arg_343_1.time_ >= var_346_26 + var_346_27 and arg_343_1.time_ < var_346_26 + var_346_27 + arg_346_0 then
				var_346_25.localPosition = Vector3.New(0, 100, 0)

				local var_346_32 = manager.ui.mainCamera.transform.position - var_346_25.position

				var_346_25.forward = Vector3.New(var_346_32.x, var_346_32.y, var_346_32.z)

				local var_346_33 = var_346_25.localEulerAngles

				var_346_33.z = 0
				var_346_33.x = 0
				var_346_25.localEulerAngles = var_346_33
			end

			local var_346_34 = 0

			if var_346_34 < arg_343_1.time_ and arg_343_1.time_ <= var_346_34 + arg_346_0 then
				arg_343_1.mask_.enabled = true
				arg_343_1.mask_.raycastTarget = true

				arg_343_1:SetGaussion(false)
			end

			local var_346_35 = 2

			if var_346_34 <= arg_343_1.time_ and arg_343_1.time_ < var_346_34 + var_346_35 then
				local var_346_36 = (arg_343_1.time_ - var_346_34) / var_346_35
				local var_346_37 = Color.New(0, 0, 0)

				var_346_37.a = Mathf.Lerp(0, 1, var_346_36)
				arg_343_1.mask_.color = var_346_37
			end

			if arg_343_1.time_ >= var_346_34 + var_346_35 and arg_343_1.time_ < var_346_34 + var_346_35 + arg_346_0 then
				local var_346_38 = Color.New(0, 0, 0)

				var_346_38.a = 1
				arg_343_1.mask_.color = var_346_38
			end

			local var_346_39 = 2

			if var_346_39 < arg_343_1.time_ and arg_343_1.time_ <= var_346_39 + arg_346_0 then
				arg_343_1.mask_.enabled = true
				arg_343_1.mask_.raycastTarget = true

				arg_343_1:SetGaussion(false)
			end

			local var_346_40 = 2

			if var_346_39 <= arg_343_1.time_ and arg_343_1.time_ < var_346_39 + var_346_40 then
				local var_346_41 = (arg_343_1.time_ - var_346_39) / var_346_40
				local var_346_42 = Color.New(0, 0, 0)

				var_346_42.a = Mathf.Lerp(1, 0, var_346_41)
				arg_343_1.mask_.color = var_346_42
			end

			if arg_343_1.time_ >= var_346_39 + var_346_40 and arg_343_1.time_ < var_346_39 + var_346_40 + arg_346_0 then
				local var_346_43 = Color.New(0, 0, 0)
				local var_346_44 = 0

				arg_343_1.mask_.enabled = false
				var_346_43.a = var_346_44
				arg_343_1.mask_.color = var_346_43
			end

			if arg_343_1.frameCnt_ <= 1 then
				arg_343_1.dialog_:SetActive(false)
			end

			local var_346_45 = 4
			local var_346_46 = 0.05

			if var_346_45 < arg_343_1.time_ and arg_343_1.time_ <= var_346_45 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0

				arg_343_1.dialog_:SetActive(true)

				arg_343_1.dialogCg_.alpha = 0

				local var_346_47 = LeanTween.value(arg_343_1.dialog_, 0, 1, 0.3)

				var_346_47:setOnUpdate(LuaHelper.FloatAction(function(arg_347_0)
					arg_343_1.dialogCg_.alpha = arg_347_0
				end))
				var_346_47:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_343_1.dialog_)
					var_346_47:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_343_1.duration_ = arg_343_1.duration_ + 0.3

				SetActive(arg_343_1.leftNameGo_, false)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_48 = arg_343_1:GetWordFromCfg(1101105083)
				local var_346_49 = arg_343_1:FormatText(var_346_48.content)

				arg_343_1.text_.text = var_346_49

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_50 = 2
				local var_346_51 = utf8.len(var_346_49)
				local var_346_52 = var_346_50 <= 0 and var_346_46 or var_346_46 * (var_346_51 / var_346_50)

				if var_346_52 > 0 and var_346_46 < var_346_52 then
					arg_343_1.talkMaxDuration = var_346_52
					var_346_45 = var_346_45 + 0.3

					if var_346_52 + var_346_45 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_52 + var_346_45
					end
				end

				arg_343_1.text_.text = var_346_49
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)
				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_53 = var_346_45 + 0.3
			local var_346_54 = math.max(var_346_46, arg_343_1.talkMaxDuration)

			if var_346_53 <= arg_343_1.time_ and arg_343_1.time_ < var_346_53 + var_346_54 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_53) / var_346_54

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_53 + var_346_54 and arg_343_1.time_ < var_346_53 + var_346_54 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_343_1:InitPlayNodeList()
	end,
	Play1101105084 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 1101105084
		arg_349_1.duration_ = 6.43

		local var_349_0 = {
			zh = 4.933,
			ja = 6.433
		}
		local var_349_1 = manager.audio:GetLocalizationFlag()

		if var_349_0[var_349_1] ~= nil then
			arg_349_1.duration_ = var_349_0[var_349_1]
		end

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play1101105085(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			local var_352_0 = 0

			if var_352_0 < arg_349_1.time_ and arg_349_1.time_ <= var_352_0 + arg_352_0 then
				local var_352_1 = manager.ui.mainCamera.transform.localPosition
				local var_352_2 = Vector3.New(0, 0, 10) + Vector3.New(var_352_1.x, var_352_1.y, 0)
				local var_352_3 = arg_349_1.bgs_.D999

				var_352_3.transform.localPosition = var_352_2
				var_352_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_352_4 = var_352_3:GetComponent("SpriteRenderer")

				if var_352_4 and var_352_4.sprite then
					local var_352_5 = (var_352_3.transform.localPosition - var_352_1).z
					local var_352_6 = manager.ui.mainCameraCom_
					local var_352_7 = 2 * var_352_5 * Mathf.Tan(var_352_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_352_8 = var_352_7 * var_352_6.aspect
					local var_352_9 = var_352_4.sprite.bounds.size.x
					local var_352_10 = var_352_4.sprite.bounds.size.y
					local var_352_11 = var_352_8 / var_352_9
					local var_352_12 = var_352_7 / var_352_10
					local var_352_13 = var_352_12 < var_352_11 and var_352_11 or var_352_12

					var_352_3.transform.localScale = Vector3.New(var_352_13, var_352_13, 0)
				end

				for iter_352_0, iter_352_1 in pairs(arg_349_1.bgs_) do
					if iter_352_0 ~= "D999" then
						iter_352_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_352_14 = arg_349_1.actors_["1011ui_story"].transform
			local var_352_15 = 2

			if var_352_15 < arg_349_1.time_ and arg_349_1.time_ <= var_352_15 + arg_352_0 then
				arg_349_1.var_.moveOldPos1011ui_story = var_352_14.localPosition
			end

			local var_352_16 = 0.001

			if var_352_15 <= arg_349_1.time_ and arg_349_1.time_ < var_352_15 + var_352_16 then
				local var_352_17 = (arg_349_1.time_ - var_352_15) / var_352_16
				local var_352_18 = Vector3.New(-0.7, -0.71, -6)

				var_352_14.localPosition = Vector3.Lerp(arg_349_1.var_.moveOldPos1011ui_story, var_352_18, var_352_17)

				local var_352_19 = manager.ui.mainCamera.transform.position - var_352_14.position

				var_352_14.forward = Vector3.New(var_352_19.x, var_352_19.y, var_352_19.z)

				local var_352_20 = var_352_14.localEulerAngles

				var_352_20.z = 0
				var_352_20.x = 0
				var_352_14.localEulerAngles = var_352_20
			end

			if arg_349_1.time_ >= var_352_15 + var_352_16 and arg_349_1.time_ < var_352_15 + var_352_16 + arg_352_0 then
				var_352_14.localPosition = Vector3.New(-0.7, -0.71, -6)

				local var_352_21 = manager.ui.mainCamera.transform.position - var_352_14.position

				var_352_14.forward = Vector3.New(var_352_21.x, var_352_21.y, var_352_21.z)

				local var_352_22 = var_352_14.localEulerAngles

				var_352_22.z = 0
				var_352_22.x = 0
				var_352_14.localEulerAngles = var_352_22
			end

			local var_352_23 = arg_349_1.actors_["1011ui_story"]
			local var_352_24 = 2

			if var_352_24 < arg_349_1.time_ and arg_349_1.time_ <= var_352_24 + arg_352_0 and not isNil(var_352_23) and arg_349_1.var_.characterEffect1011ui_story == nil then
				arg_349_1.var_.characterEffect1011ui_story = var_352_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_352_25 = 0.200000002980232

			if var_352_24 <= arg_349_1.time_ and arg_349_1.time_ < var_352_24 + var_352_25 and not isNil(var_352_23) then
				local var_352_26 = (arg_349_1.time_ - var_352_24) / var_352_25

				if arg_349_1.var_.characterEffect1011ui_story and not isNil(var_352_23) then
					arg_349_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_349_1.time_ >= var_352_24 + var_352_25 and arg_349_1.time_ < var_352_24 + var_352_25 + arg_352_0 and not isNil(var_352_23) and arg_349_1.var_.characterEffect1011ui_story then
				arg_349_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_352_27 = 2

			if var_352_27 < arg_349_1.time_ and arg_349_1.time_ <= var_352_27 + arg_352_0 then
				arg_349_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_352_28 = 0

			if var_352_28 < arg_349_1.time_ and arg_349_1.time_ <= var_352_28 + arg_352_0 then
				arg_349_1.mask_.enabled = true
				arg_349_1.mask_.raycastTarget = true

				arg_349_1:SetGaussion(false)
			end

			local var_352_29 = 2

			if var_352_28 <= arg_349_1.time_ and arg_349_1.time_ < var_352_28 + var_352_29 then
				local var_352_30 = (arg_349_1.time_ - var_352_28) / var_352_29
				local var_352_31 = Color.New(0, 0, 0)

				var_352_31.a = Mathf.Lerp(1, 0, var_352_30)
				arg_349_1.mask_.color = var_352_31
			end

			if arg_349_1.time_ >= var_352_28 + var_352_29 and arg_349_1.time_ < var_352_28 + var_352_29 + arg_352_0 then
				local var_352_32 = Color.New(0, 0, 0)
				local var_352_33 = 0

				arg_349_1.mask_.enabled = false
				var_352_32.a = var_352_33
				arg_349_1.mask_.color = var_352_32
			end

			if arg_349_1.frameCnt_ <= 1 then
				arg_349_1.dialog_:SetActive(false)
			end

			local var_352_34 = 2
			local var_352_35 = 0.2

			if var_352_34 < arg_349_1.time_ and arg_349_1.time_ <= var_352_34 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0

				arg_349_1.dialog_:SetActive(true)

				arg_349_1.dialogCg_.alpha = 0

				local var_352_36 = LeanTween.value(arg_349_1.dialog_, 0, 1, 0.3)

				var_352_36:setOnUpdate(LuaHelper.FloatAction(function(arg_353_0)
					arg_349_1.dialogCg_.alpha = arg_353_0
				end))
				var_352_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_349_1.dialog_)
					var_352_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_349_1.duration_ = arg_349_1.duration_ + 0.3

				SetActive(arg_349_1.leftNameGo_, true)

				local var_352_37 = arg_349_1:FormatText(StoryNameCfg[37].name)

				arg_349_1.leftNameTxt_.text = var_352_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_349_1.leftNameTxt_.transform)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1.leftNameTxt_.text)
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_38 = arg_349_1:GetWordFromCfg(1101105084)
				local var_352_39 = arg_349_1:FormatText(var_352_38.content)

				arg_349_1.text_.text = var_352_39

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_40 = 8
				local var_352_41 = utf8.len(var_352_39)
				local var_352_42 = var_352_40 <= 0 and var_352_35 or var_352_35 * (var_352_41 / var_352_40)

				if var_352_42 > 0 and var_352_35 < var_352_42 then
					arg_349_1.talkMaxDuration = var_352_42
					var_352_34 = var_352_34 + 0.3

					if var_352_42 + var_352_34 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_42 + var_352_34
					end
				end

				arg_349_1.text_.text = var_352_39
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105084", "story_v_side_new_1101105.awb") ~= 0 then
					local var_352_43 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105084", "story_v_side_new_1101105.awb") / 1000

					if var_352_43 + var_352_34 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_43 + var_352_34
					end

					if var_352_38.prefab_name ~= "" and arg_349_1.actors_[var_352_38.prefab_name] ~= nil then
						local var_352_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_349_1.actors_[var_352_38.prefab_name].transform, "story_v_side_new_1101105", "1101105084", "story_v_side_new_1101105.awb")

						arg_349_1:RecordAudio("1101105084", var_352_44)
						arg_349_1:RecordAudio("1101105084", var_352_44)
					else
						arg_349_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105084", "story_v_side_new_1101105.awb")
					end

					arg_349_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105084", "story_v_side_new_1101105.awb")
				end

				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_45 = var_352_34 + 0.3
			local var_352_46 = math.max(var_352_35, arg_349_1.talkMaxDuration)

			if var_352_45 <= arg_349_1.time_ and arg_349_1.time_ < var_352_45 + var_352_46 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_45) / var_352_46

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_45 + var_352_46 and arg_349_1.time_ < var_352_45 + var_352_46 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_349_1:InitPlayNodeList()
	end,
	Play1101105085 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 1101105085
		arg_355_1.duration_ = 9.43

		local var_355_0 = {
			zh = 7.4,
			ja = 9.433
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
				arg_355_0:Play1101105086(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			local var_358_0 = arg_355_1.actors_["1111ui_story"].transform
			local var_358_1 = 0

			if var_358_1 < arg_355_1.time_ and arg_355_1.time_ <= var_358_1 + arg_358_0 then
				arg_355_1.var_.moveOldPos1111ui_story = var_358_0.localPosition
			end

			local var_358_2 = 0.001

			if var_358_1 <= arg_355_1.time_ and arg_355_1.time_ < var_358_1 + var_358_2 then
				local var_358_3 = (arg_355_1.time_ - var_358_1) / var_358_2
				local var_358_4 = Vector3.New(0.7, -0.87, -5.7)

				var_358_0.localPosition = Vector3.Lerp(arg_355_1.var_.moveOldPos1111ui_story, var_358_4, var_358_3)

				local var_358_5 = manager.ui.mainCamera.transform.position - var_358_0.position

				var_358_0.forward = Vector3.New(var_358_5.x, var_358_5.y, var_358_5.z)

				local var_358_6 = var_358_0.localEulerAngles

				var_358_6.z = 0
				var_358_6.x = 0
				var_358_0.localEulerAngles = var_358_6
			end

			if arg_355_1.time_ >= var_358_1 + var_358_2 and arg_355_1.time_ < var_358_1 + var_358_2 + arg_358_0 then
				var_358_0.localPosition = Vector3.New(0.7, -0.87, -5.7)

				local var_358_7 = manager.ui.mainCamera.transform.position - var_358_0.position

				var_358_0.forward = Vector3.New(var_358_7.x, var_358_7.y, var_358_7.z)

				local var_358_8 = var_358_0.localEulerAngles

				var_358_8.z = 0
				var_358_8.x = 0
				var_358_0.localEulerAngles = var_358_8
			end

			local var_358_9 = arg_355_1.actors_["1111ui_story"]
			local var_358_10 = 0

			if var_358_10 < arg_355_1.time_ and arg_355_1.time_ <= var_358_10 + arg_358_0 and not isNil(var_358_9) and arg_355_1.var_.characterEffect1111ui_story == nil then
				arg_355_1.var_.characterEffect1111ui_story = var_358_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_358_11 = 0.200000002980232

			if var_358_10 <= arg_355_1.time_ and arg_355_1.time_ < var_358_10 + var_358_11 and not isNil(var_358_9) then
				local var_358_12 = (arg_355_1.time_ - var_358_10) / var_358_11

				if arg_355_1.var_.characterEffect1111ui_story and not isNil(var_358_9) then
					arg_355_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_355_1.time_ >= var_358_10 + var_358_11 and arg_355_1.time_ < var_358_10 + var_358_11 + arg_358_0 and not isNil(var_358_9) and arg_355_1.var_.characterEffect1111ui_story then
				arg_355_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_358_13 = 0

			if var_358_13 < arg_355_1.time_ and arg_355_1.time_ <= var_358_13 + arg_358_0 then
				arg_355_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action8_1")
			end

			local var_358_14 = 0

			if var_358_14 < arg_355_1.time_ and arg_355_1.time_ <= var_358_14 + arg_358_0 then
				arg_355_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_358_15 = arg_355_1.actors_["1011ui_story"]
			local var_358_16 = 0

			if var_358_16 < arg_355_1.time_ and arg_355_1.time_ <= var_358_16 + arg_358_0 and not isNil(var_358_15) and arg_355_1.var_.characterEffect1011ui_story == nil then
				arg_355_1.var_.characterEffect1011ui_story = var_358_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_358_17 = 0.200000002980232

			if var_358_16 <= arg_355_1.time_ and arg_355_1.time_ < var_358_16 + var_358_17 and not isNil(var_358_15) then
				local var_358_18 = (arg_355_1.time_ - var_358_16) / var_358_17

				if arg_355_1.var_.characterEffect1011ui_story and not isNil(var_358_15) then
					local var_358_19 = Mathf.Lerp(0, 0.5, var_358_18)

					arg_355_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_355_1.var_.characterEffect1011ui_story.fillRatio = var_358_19
				end
			end

			if arg_355_1.time_ >= var_358_16 + var_358_17 and arg_355_1.time_ < var_358_16 + var_358_17 + arg_358_0 and not isNil(var_358_15) and arg_355_1.var_.characterEffect1011ui_story then
				local var_358_20 = 0.5

				arg_355_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_355_1.var_.characterEffect1011ui_story.fillRatio = var_358_20
			end

			local var_358_21 = 0
			local var_358_22 = 0.8

			if var_358_21 < arg_355_1.time_ and arg_355_1.time_ <= var_358_21 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, true)

				local var_358_23 = arg_355_1:FormatText(StoryNameCfg[67].name)

				arg_355_1.leftNameTxt_.text = var_358_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_355_1.leftNameTxt_.transform)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1.leftNameTxt_.text)
				SetActive(arg_355_1.iconTrs_.gameObject, false)
				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_24 = arg_355_1:GetWordFromCfg(1101105085)
				local var_358_25 = arg_355_1:FormatText(var_358_24.content)

				arg_355_1.text_.text = var_358_25

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_26 = 32
				local var_358_27 = utf8.len(var_358_25)
				local var_358_28 = var_358_26 <= 0 and var_358_22 or var_358_22 * (var_358_27 / var_358_26)

				if var_358_28 > 0 and var_358_22 < var_358_28 then
					arg_355_1.talkMaxDuration = var_358_28

					if var_358_28 + var_358_21 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_28 + var_358_21
					end
				end

				arg_355_1.text_.text = var_358_25
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105085", "story_v_side_new_1101105.awb") ~= 0 then
					local var_358_29 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105085", "story_v_side_new_1101105.awb") / 1000

					if var_358_29 + var_358_21 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_29 + var_358_21
					end

					if var_358_24.prefab_name ~= "" and arg_355_1.actors_[var_358_24.prefab_name] ~= nil then
						local var_358_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_355_1.actors_[var_358_24.prefab_name].transform, "story_v_side_new_1101105", "1101105085", "story_v_side_new_1101105.awb")

						arg_355_1:RecordAudio("1101105085", var_358_30)
						arg_355_1:RecordAudio("1101105085", var_358_30)
					else
						arg_355_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105085", "story_v_side_new_1101105.awb")
					end

					arg_355_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105085", "story_v_side_new_1101105.awb")
				end

				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_31 = math.max(var_358_22, arg_355_1.talkMaxDuration)

			if var_358_21 <= arg_355_1.time_ and arg_355_1.time_ < var_358_21 + var_358_31 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_21) / var_358_31

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_21 + var_358_31 and arg_355_1.time_ < var_358_21 + var_358_31 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {
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

		arg_355_1:InitPlayNodeList()
	end,
	Play1101105086 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 1101105086
		arg_359_1.duration_ = 10.83

		local var_359_0 = {
			zh = 7.333,
			ja = 10.833
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
				arg_359_0:Play1101105087(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			local var_362_0 = arg_359_1.actors_["1011ui_story"].transform
			local var_362_1 = 0

			if var_362_1 < arg_359_1.time_ and arg_359_1.time_ <= var_362_1 + arg_362_0 then
				arg_359_1.var_.moveOldPos1011ui_story = var_362_0.localPosition
			end

			local var_362_2 = 0.001

			if var_362_1 <= arg_359_1.time_ and arg_359_1.time_ < var_362_1 + var_362_2 then
				local var_362_3 = (arg_359_1.time_ - var_362_1) / var_362_2
				local var_362_4 = Vector3.New(-0.7, -0.71, -6)

				var_362_0.localPosition = Vector3.Lerp(arg_359_1.var_.moveOldPos1011ui_story, var_362_4, var_362_3)

				local var_362_5 = manager.ui.mainCamera.transform.position - var_362_0.position

				var_362_0.forward = Vector3.New(var_362_5.x, var_362_5.y, var_362_5.z)

				local var_362_6 = var_362_0.localEulerAngles

				var_362_6.z = 0
				var_362_6.x = 0
				var_362_0.localEulerAngles = var_362_6
			end

			if arg_359_1.time_ >= var_362_1 + var_362_2 and arg_359_1.time_ < var_362_1 + var_362_2 + arg_362_0 then
				var_362_0.localPosition = Vector3.New(-0.7, -0.71, -6)

				local var_362_7 = manager.ui.mainCamera.transform.position - var_362_0.position

				var_362_0.forward = Vector3.New(var_362_7.x, var_362_7.y, var_362_7.z)

				local var_362_8 = var_362_0.localEulerAngles

				var_362_8.z = 0
				var_362_8.x = 0
				var_362_0.localEulerAngles = var_362_8
			end

			local var_362_9 = arg_359_1.actors_["1011ui_story"]
			local var_362_10 = 0

			if var_362_10 < arg_359_1.time_ and arg_359_1.time_ <= var_362_10 + arg_362_0 and not isNil(var_362_9) and arg_359_1.var_.characterEffect1011ui_story == nil then
				arg_359_1.var_.characterEffect1011ui_story = var_362_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_362_11 = 0.200000002980232

			if var_362_10 <= arg_359_1.time_ and arg_359_1.time_ < var_362_10 + var_362_11 and not isNil(var_362_9) then
				local var_362_12 = (arg_359_1.time_ - var_362_10) / var_362_11

				if arg_359_1.var_.characterEffect1011ui_story and not isNil(var_362_9) then
					arg_359_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_359_1.time_ >= var_362_10 + var_362_11 and arg_359_1.time_ < var_362_10 + var_362_11 + arg_362_0 and not isNil(var_362_9) and arg_359_1.var_.characterEffect1011ui_story then
				arg_359_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_362_13 = 0

			if var_362_13 < arg_359_1.time_ and arg_359_1.time_ <= var_362_13 + arg_362_0 then
				arg_359_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_362_14 = arg_359_1.actors_["1111ui_story"]
			local var_362_15 = 0

			if var_362_15 < arg_359_1.time_ and arg_359_1.time_ <= var_362_15 + arg_362_0 and not isNil(var_362_14) and arg_359_1.var_.characterEffect1111ui_story == nil then
				arg_359_1.var_.characterEffect1111ui_story = var_362_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_362_16 = 0.200000002980232

			if var_362_15 <= arg_359_1.time_ and arg_359_1.time_ < var_362_15 + var_362_16 and not isNil(var_362_14) then
				local var_362_17 = (arg_359_1.time_ - var_362_15) / var_362_16

				if arg_359_1.var_.characterEffect1111ui_story and not isNil(var_362_14) then
					local var_362_18 = Mathf.Lerp(0, 0.5, var_362_17)

					arg_359_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_359_1.var_.characterEffect1111ui_story.fillRatio = var_362_18
				end
			end

			if arg_359_1.time_ >= var_362_15 + var_362_16 and arg_359_1.time_ < var_362_15 + var_362_16 + arg_362_0 and not isNil(var_362_14) and arg_359_1.var_.characterEffect1111ui_story then
				local var_362_19 = 0.5

				arg_359_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_359_1.var_.characterEffect1111ui_story.fillRatio = var_362_19
			end

			local var_362_20 = 0
			local var_362_21 = 0.7

			if var_362_20 < arg_359_1.time_ and arg_359_1.time_ <= var_362_20 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, true)

				local var_362_22 = arg_359_1:FormatText(StoryNameCfg[37].name)

				arg_359_1.leftNameTxt_.text = var_362_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_359_1.leftNameTxt_.transform)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1.leftNameTxt_.text)
				SetActive(arg_359_1.iconTrs_.gameObject, false)
				arg_359_1.callingController_:SetSelectedState("normal")

				local var_362_23 = arg_359_1:GetWordFromCfg(1101105086)
				local var_362_24 = arg_359_1:FormatText(var_362_23.content)

				arg_359_1.text_.text = var_362_24

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_25 = 28
				local var_362_26 = utf8.len(var_362_24)
				local var_362_27 = var_362_25 <= 0 and var_362_21 or var_362_21 * (var_362_26 / var_362_25)

				if var_362_27 > 0 and var_362_21 < var_362_27 then
					arg_359_1.talkMaxDuration = var_362_27

					if var_362_27 + var_362_20 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_27 + var_362_20
					end
				end

				arg_359_1.text_.text = var_362_24
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105086", "story_v_side_new_1101105.awb") ~= 0 then
					local var_362_28 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105086", "story_v_side_new_1101105.awb") / 1000

					if var_362_28 + var_362_20 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_28 + var_362_20
					end

					if var_362_23.prefab_name ~= "" and arg_359_1.actors_[var_362_23.prefab_name] ~= nil then
						local var_362_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_359_1.actors_[var_362_23.prefab_name].transform, "story_v_side_new_1101105", "1101105086", "story_v_side_new_1101105.awb")

						arg_359_1:RecordAudio("1101105086", var_362_29)
						arg_359_1:RecordAudio("1101105086", var_362_29)
					else
						arg_359_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105086", "story_v_side_new_1101105.awb")
					end

					arg_359_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105086", "story_v_side_new_1101105.awb")
				end

				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_30 = math.max(var_362_21, arg_359_1.talkMaxDuration)

			if var_362_20 <= arg_359_1.time_ and arg_359_1.time_ < var_362_20 + var_362_30 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - var_362_20) / var_362_30

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= var_362_20 + var_362_30 and arg_359_1.time_ < var_362_20 + var_362_30 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
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
	Play1101105087 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 1101105087
		arg_363_1.duration_ = 3.9

		local var_363_0 = {
			zh = 2.833,
			ja = 3.9
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
				arg_363_0:Play1101105088(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			local var_366_0 = arg_363_1.actors_["1111ui_story"].transform
			local var_366_1 = 0

			if var_366_1 < arg_363_1.time_ and arg_363_1.time_ <= var_366_1 + arg_366_0 then
				arg_363_1.var_.moveOldPos1111ui_story = var_366_0.localPosition
			end

			local var_366_2 = 0.001

			if var_366_1 <= arg_363_1.time_ and arg_363_1.time_ < var_366_1 + var_366_2 then
				local var_366_3 = (arg_363_1.time_ - var_366_1) / var_366_2
				local var_366_4 = Vector3.New(0.7, -0.87, -5.7)

				var_366_0.localPosition = Vector3.Lerp(arg_363_1.var_.moveOldPos1111ui_story, var_366_4, var_366_3)

				local var_366_5 = manager.ui.mainCamera.transform.position - var_366_0.position

				var_366_0.forward = Vector3.New(var_366_5.x, var_366_5.y, var_366_5.z)

				local var_366_6 = var_366_0.localEulerAngles

				var_366_6.z = 0
				var_366_6.x = 0
				var_366_0.localEulerAngles = var_366_6
			end

			if arg_363_1.time_ >= var_366_1 + var_366_2 and arg_363_1.time_ < var_366_1 + var_366_2 + arg_366_0 then
				var_366_0.localPosition = Vector3.New(0.7, -0.87, -5.7)

				local var_366_7 = manager.ui.mainCamera.transform.position - var_366_0.position

				var_366_0.forward = Vector3.New(var_366_7.x, var_366_7.y, var_366_7.z)

				local var_366_8 = var_366_0.localEulerAngles

				var_366_8.z = 0
				var_366_8.x = 0
				var_366_0.localEulerAngles = var_366_8
			end

			local var_366_9 = arg_363_1.actors_["1111ui_story"]
			local var_366_10 = 0

			if var_366_10 < arg_363_1.time_ and arg_363_1.time_ <= var_366_10 + arg_366_0 and not isNil(var_366_9) and arg_363_1.var_.characterEffect1111ui_story == nil then
				arg_363_1.var_.characterEffect1111ui_story = var_366_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_366_11 = 0.200000002980232

			if var_366_10 <= arg_363_1.time_ and arg_363_1.time_ < var_366_10 + var_366_11 and not isNil(var_366_9) then
				local var_366_12 = (arg_363_1.time_ - var_366_10) / var_366_11

				if arg_363_1.var_.characterEffect1111ui_story and not isNil(var_366_9) then
					arg_363_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_363_1.time_ >= var_366_10 + var_366_11 and arg_363_1.time_ < var_366_10 + var_366_11 + arg_366_0 and not isNil(var_366_9) and arg_363_1.var_.characterEffect1111ui_story then
				arg_363_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_366_13 = 0

			if var_366_13 < arg_363_1.time_ and arg_363_1.time_ <= var_366_13 + arg_366_0 then
				arg_363_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_366_14 = arg_363_1.actors_["1011ui_story"]
			local var_366_15 = 0

			if var_366_15 < arg_363_1.time_ and arg_363_1.time_ <= var_366_15 + arg_366_0 and not isNil(var_366_14) and arg_363_1.var_.characterEffect1011ui_story == nil then
				arg_363_1.var_.characterEffect1011ui_story = var_366_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_366_16 = 0.200000002980232

			if var_366_15 <= arg_363_1.time_ and arg_363_1.time_ < var_366_15 + var_366_16 and not isNil(var_366_14) then
				local var_366_17 = (arg_363_1.time_ - var_366_15) / var_366_16

				if arg_363_1.var_.characterEffect1011ui_story and not isNil(var_366_14) then
					local var_366_18 = Mathf.Lerp(0, 0.5, var_366_17)

					arg_363_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_363_1.var_.characterEffect1011ui_story.fillRatio = var_366_18
				end
			end

			if arg_363_1.time_ >= var_366_15 + var_366_16 and arg_363_1.time_ < var_366_15 + var_366_16 + arg_366_0 and not isNil(var_366_14) and arg_363_1.var_.characterEffect1011ui_story then
				local var_366_19 = 0.5

				arg_363_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_363_1.var_.characterEffect1011ui_story.fillRatio = var_366_19
			end

			local var_366_20 = 0
			local var_366_21 = 0.55

			if var_366_20 < arg_363_1.time_ and arg_363_1.time_ <= var_366_20 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, true)

				local var_366_22 = arg_363_1:FormatText(StoryNameCfg[67].name)

				arg_363_1.leftNameTxt_.text = var_366_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_363_1.leftNameTxt_.transform)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1.leftNameTxt_.text)
				SetActive(arg_363_1.iconTrs_.gameObject, false)
				arg_363_1.callingController_:SetSelectedState("normal")

				local var_366_23 = arg_363_1:GetWordFromCfg(1101105087)
				local var_366_24 = arg_363_1:FormatText(var_366_23.content)

				arg_363_1.text_.text = var_366_24

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_25 = 22
				local var_366_26 = utf8.len(var_366_24)
				local var_366_27 = var_366_25 <= 0 and var_366_21 or var_366_21 * (var_366_26 / var_366_25)

				if var_366_27 > 0 and var_366_21 < var_366_27 then
					arg_363_1.talkMaxDuration = var_366_27

					if var_366_27 + var_366_20 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_27 + var_366_20
					end
				end

				arg_363_1.text_.text = var_366_24
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105087", "story_v_side_new_1101105.awb") ~= 0 then
					local var_366_28 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105087", "story_v_side_new_1101105.awb") / 1000

					if var_366_28 + var_366_20 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_28 + var_366_20
					end

					if var_366_23.prefab_name ~= "" and arg_363_1.actors_[var_366_23.prefab_name] ~= nil then
						local var_366_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_363_1.actors_[var_366_23.prefab_name].transform, "story_v_side_new_1101105", "1101105087", "story_v_side_new_1101105.awb")

						arg_363_1:RecordAudio("1101105087", var_366_29)
						arg_363_1:RecordAudio("1101105087", var_366_29)
					else
						arg_363_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105087", "story_v_side_new_1101105.awb")
					end

					arg_363_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105087", "story_v_side_new_1101105.awb")
				end

				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_30 = math.max(var_366_21, arg_363_1.talkMaxDuration)

			if var_366_20 <= arg_363_1.time_ and arg_363_1.time_ < var_366_20 + var_366_30 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - var_366_20) / var_366_30

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= var_366_20 + var_366_30 and arg_363_1.time_ < var_366_20 + var_366_30 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {
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

		arg_363_1:InitPlayNodeList()
	end,
	Play1101105088 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 1101105088
		arg_367_1.duration_ = 7.33

		local var_367_0 = {
			zh = 3.866,
			ja = 7.333
		}
		local var_367_1 = manager.audio:GetLocalizationFlag()

		if var_367_0[var_367_1] ~= nil then
			arg_367_1.duration_ = var_367_0[var_367_1]
		end

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play1101105089(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			local var_370_0 = arg_367_1.actors_["1111ui_story"].transform
			local var_370_1 = 0

			if var_370_1 < arg_367_1.time_ and arg_367_1.time_ <= var_370_1 + arg_370_0 then
				arg_367_1.var_.moveOldPos1111ui_story = var_370_0.localPosition
			end

			local var_370_2 = 0.001

			if var_370_1 <= arg_367_1.time_ and arg_367_1.time_ < var_370_1 + var_370_2 then
				local var_370_3 = (arg_367_1.time_ - var_370_1) / var_370_2
				local var_370_4 = Vector3.New(0.7, -0.87, -5.7)

				var_370_0.localPosition = Vector3.Lerp(arg_367_1.var_.moveOldPos1111ui_story, var_370_4, var_370_3)

				local var_370_5 = manager.ui.mainCamera.transform.position - var_370_0.position

				var_370_0.forward = Vector3.New(var_370_5.x, var_370_5.y, var_370_5.z)

				local var_370_6 = var_370_0.localEulerAngles

				var_370_6.z = 0
				var_370_6.x = 0
				var_370_0.localEulerAngles = var_370_6
			end

			if arg_367_1.time_ >= var_370_1 + var_370_2 and arg_367_1.time_ < var_370_1 + var_370_2 + arg_370_0 then
				var_370_0.localPosition = Vector3.New(0.7, -0.87, -5.7)

				local var_370_7 = manager.ui.mainCamera.transform.position - var_370_0.position

				var_370_0.forward = Vector3.New(var_370_7.x, var_370_7.y, var_370_7.z)

				local var_370_8 = var_370_0.localEulerAngles

				var_370_8.z = 0
				var_370_8.x = 0
				var_370_0.localEulerAngles = var_370_8
			end

			local var_370_9 = arg_367_1.actors_["1111ui_story"]
			local var_370_10 = 0

			if var_370_10 < arg_367_1.time_ and arg_367_1.time_ <= var_370_10 + arg_370_0 and not isNil(var_370_9) and arg_367_1.var_.characterEffect1111ui_story == nil then
				arg_367_1.var_.characterEffect1111ui_story = var_370_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_370_11 = 0.200000002980232

			if var_370_10 <= arg_367_1.time_ and arg_367_1.time_ < var_370_10 + var_370_11 and not isNil(var_370_9) then
				local var_370_12 = (arg_367_1.time_ - var_370_10) / var_370_11

				if arg_367_1.var_.characterEffect1111ui_story and not isNil(var_370_9) then
					arg_367_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_367_1.time_ >= var_370_10 + var_370_11 and arg_367_1.time_ < var_370_10 + var_370_11 + arg_370_0 and not isNil(var_370_9) and arg_367_1.var_.characterEffect1111ui_story then
				arg_367_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_370_13 = 0

			if var_370_13 < arg_367_1.time_ and arg_367_1.time_ <= var_370_13 + arg_370_0 then
				arg_367_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action8_2")
			end

			local var_370_14 = 0

			if var_370_14 < arg_367_1.time_ and arg_367_1.time_ <= var_370_14 + arg_370_0 then
				arg_367_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_370_15 = 0
			local var_370_16 = 0.325

			if var_370_15 < arg_367_1.time_ and arg_367_1.time_ <= var_370_15 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, true)

				local var_370_17 = arg_367_1:FormatText(StoryNameCfg[67].name)

				arg_367_1.leftNameTxt_.text = var_370_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_367_1.leftNameTxt_.transform)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1.leftNameTxt_.text)
				SetActive(arg_367_1.iconTrs_.gameObject, false)
				arg_367_1.callingController_:SetSelectedState("normal")

				local var_370_18 = arg_367_1:GetWordFromCfg(1101105088)
				local var_370_19 = arg_367_1:FormatText(var_370_18.content)

				arg_367_1.text_.text = var_370_19

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_20 = 13
				local var_370_21 = utf8.len(var_370_19)
				local var_370_22 = var_370_20 <= 0 and var_370_16 or var_370_16 * (var_370_21 / var_370_20)

				if var_370_22 > 0 and var_370_16 < var_370_22 then
					arg_367_1.talkMaxDuration = var_370_22

					if var_370_22 + var_370_15 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_22 + var_370_15
					end
				end

				arg_367_1.text_.text = var_370_19
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105088", "story_v_side_new_1101105.awb") ~= 0 then
					local var_370_23 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105088", "story_v_side_new_1101105.awb") / 1000

					if var_370_23 + var_370_15 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_23 + var_370_15
					end

					if var_370_18.prefab_name ~= "" and arg_367_1.actors_[var_370_18.prefab_name] ~= nil then
						local var_370_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_367_1.actors_[var_370_18.prefab_name].transform, "story_v_side_new_1101105", "1101105088", "story_v_side_new_1101105.awb")

						arg_367_1:RecordAudio("1101105088", var_370_24)
						arg_367_1:RecordAudio("1101105088", var_370_24)
					else
						arg_367_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105088", "story_v_side_new_1101105.awb")
					end

					arg_367_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105088", "story_v_side_new_1101105.awb")
				end

				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_25 = math.max(var_370_16, arg_367_1.talkMaxDuration)

			if var_370_15 <= arg_367_1.time_ and arg_367_1.time_ < var_370_15 + var_370_25 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - var_370_15) / var_370_25

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= var_370_15 + var_370_25 and arg_367_1.time_ < var_370_15 + var_370_25 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {
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
	Play1101105089 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 1101105089
		arg_371_1.duration_ = 2.77

		local var_371_0 = {
			zh = 2.766,
			ja = 2.1
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
				arg_371_0:Play1101105090(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			local var_374_0 = arg_371_1.actors_["1011ui_story"].transform
			local var_374_1 = 0

			if var_374_1 < arg_371_1.time_ and arg_371_1.time_ <= var_374_1 + arg_374_0 then
				arg_371_1.var_.moveOldPos1011ui_story = var_374_0.localPosition
			end

			local var_374_2 = 0.001

			if var_374_1 <= arg_371_1.time_ and arg_371_1.time_ < var_374_1 + var_374_2 then
				local var_374_3 = (arg_371_1.time_ - var_374_1) / var_374_2
				local var_374_4 = Vector3.New(-0.7, -0.71, -6)

				var_374_0.localPosition = Vector3.Lerp(arg_371_1.var_.moveOldPos1011ui_story, var_374_4, var_374_3)

				local var_374_5 = manager.ui.mainCamera.transform.position - var_374_0.position

				var_374_0.forward = Vector3.New(var_374_5.x, var_374_5.y, var_374_5.z)

				local var_374_6 = var_374_0.localEulerAngles

				var_374_6.z = 0
				var_374_6.x = 0
				var_374_0.localEulerAngles = var_374_6
			end

			if arg_371_1.time_ >= var_374_1 + var_374_2 and arg_371_1.time_ < var_374_1 + var_374_2 + arg_374_0 then
				var_374_0.localPosition = Vector3.New(-0.7, -0.71, -6)

				local var_374_7 = manager.ui.mainCamera.transform.position - var_374_0.position

				var_374_0.forward = Vector3.New(var_374_7.x, var_374_7.y, var_374_7.z)

				local var_374_8 = var_374_0.localEulerAngles

				var_374_8.z = 0
				var_374_8.x = 0
				var_374_0.localEulerAngles = var_374_8
			end

			local var_374_9 = arg_371_1.actors_["1011ui_story"]
			local var_374_10 = 0

			if var_374_10 < arg_371_1.time_ and arg_371_1.time_ <= var_374_10 + arg_374_0 and not isNil(var_374_9) and arg_371_1.var_.characterEffect1011ui_story == nil then
				arg_371_1.var_.characterEffect1011ui_story = var_374_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_374_11 = 0.200000002980232

			if var_374_10 <= arg_371_1.time_ and arg_371_1.time_ < var_374_10 + var_374_11 and not isNil(var_374_9) then
				local var_374_12 = (arg_371_1.time_ - var_374_10) / var_374_11

				if arg_371_1.var_.characterEffect1011ui_story and not isNil(var_374_9) then
					arg_371_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_371_1.time_ >= var_374_10 + var_374_11 and arg_371_1.time_ < var_374_10 + var_374_11 + arg_374_0 and not isNil(var_374_9) and arg_371_1.var_.characterEffect1011ui_story then
				arg_371_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_374_13 = 0

			if var_374_13 < arg_371_1.time_ and arg_371_1.time_ <= var_374_13 + arg_374_0 then
				arg_371_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action2_1")
			end

			local var_374_14 = 0

			if var_374_14 < arg_371_1.time_ and arg_371_1.time_ <= var_374_14 + arg_374_0 then
				arg_371_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_374_15 = arg_371_1.actors_["1111ui_story"]
			local var_374_16 = 0

			if var_374_16 < arg_371_1.time_ and arg_371_1.time_ <= var_374_16 + arg_374_0 and not isNil(var_374_15) and arg_371_1.var_.characterEffect1111ui_story == nil then
				arg_371_1.var_.characterEffect1111ui_story = var_374_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_374_17 = 0.200000002980232

			if var_374_16 <= arg_371_1.time_ and arg_371_1.time_ < var_374_16 + var_374_17 and not isNil(var_374_15) then
				local var_374_18 = (arg_371_1.time_ - var_374_16) / var_374_17

				if arg_371_1.var_.characterEffect1111ui_story and not isNil(var_374_15) then
					local var_374_19 = Mathf.Lerp(0, 0.5, var_374_18)

					arg_371_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_371_1.var_.characterEffect1111ui_story.fillRatio = var_374_19
				end
			end

			if arg_371_1.time_ >= var_374_16 + var_374_17 and arg_371_1.time_ < var_374_16 + var_374_17 + arg_374_0 and not isNil(var_374_15) and arg_371_1.var_.characterEffect1111ui_story then
				local var_374_20 = 0.5

				arg_371_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_371_1.var_.characterEffect1111ui_story.fillRatio = var_374_20
			end

			local var_374_21 = 0
			local var_374_22 = 0.05

			if var_374_21 < arg_371_1.time_ and arg_371_1.time_ <= var_374_21 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, true)

				local var_374_23 = arg_371_1:FormatText(StoryNameCfg[37].name)

				arg_371_1.leftNameTxt_.text = var_374_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_371_1.leftNameTxt_.transform)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1.leftNameTxt_.text)
				SetActive(arg_371_1.iconTrs_.gameObject, false)
				arg_371_1.callingController_:SetSelectedState("normal")

				local var_374_24 = arg_371_1:GetWordFromCfg(1101105089)
				local var_374_25 = arg_371_1:FormatText(var_374_24.content)

				arg_371_1.text_.text = var_374_25

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_26 = 2
				local var_374_27 = utf8.len(var_374_25)
				local var_374_28 = var_374_26 <= 0 and var_374_22 or var_374_22 * (var_374_27 / var_374_26)

				if var_374_28 > 0 and var_374_22 < var_374_28 then
					arg_371_1.talkMaxDuration = var_374_28

					if var_374_28 + var_374_21 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_28 + var_374_21
					end
				end

				arg_371_1.text_.text = var_374_25
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105089", "story_v_side_new_1101105.awb") ~= 0 then
					local var_374_29 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105089", "story_v_side_new_1101105.awb") / 1000

					if var_374_29 + var_374_21 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_29 + var_374_21
					end

					if var_374_24.prefab_name ~= "" and arg_371_1.actors_[var_374_24.prefab_name] ~= nil then
						local var_374_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_371_1.actors_[var_374_24.prefab_name].transform, "story_v_side_new_1101105", "1101105089", "story_v_side_new_1101105.awb")

						arg_371_1:RecordAudio("1101105089", var_374_30)
						arg_371_1:RecordAudio("1101105089", var_374_30)
					else
						arg_371_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105089", "story_v_side_new_1101105.awb")
					end

					arg_371_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105089", "story_v_side_new_1101105.awb")
				end

				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_31 = math.max(var_374_22, arg_371_1.talkMaxDuration)

			if var_374_21 <= arg_371_1.time_ and arg_371_1.time_ < var_374_21 + var_374_31 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - var_374_21) / var_374_31

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= var_374_21 + var_374_31 and arg_371_1.time_ < var_374_21 + var_374_31 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
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
	Play1101105090 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 1101105090
		arg_375_1.duration_ = 5.47

		local var_375_0 = {
			zh = 5.466,
			ja = 4.3
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
				arg_375_0:Play1101105091(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			local var_378_0 = arg_375_1.actors_["1011ui_story"].transform
			local var_378_1 = 0

			if var_378_1 < arg_375_1.time_ and arg_375_1.time_ <= var_378_1 + arg_378_0 then
				arg_375_1.var_.moveOldPos1011ui_story = var_378_0.localPosition
			end

			local var_378_2 = 0.001

			if var_378_1 <= arg_375_1.time_ and arg_375_1.time_ < var_378_1 + var_378_2 then
				local var_378_3 = (arg_375_1.time_ - var_378_1) / var_378_2
				local var_378_4 = Vector3.New(-0.7, -0.71, -6)

				var_378_0.localPosition = Vector3.Lerp(arg_375_1.var_.moveOldPos1011ui_story, var_378_4, var_378_3)

				local var_378_5 = manager.ui.mainCamera.transform.position - var_378_0.position

				var_378_0.forward = Vector3.New(var_378_5.x, var_378_5.y, var_378_5.z)

				local var_378_6 = var_378_0.localEulerAngles

				var_378_6.z = 0
				var_378_6.x = 0
				var_378_0.localEulerAngles = var_378_6
			end

			if arg_375_1.time_ >= var_378_1 + var_378_2 and arg_375_1.time_ < var_378_1 + var_378_2 + arg_378_0 then
				var_378_0.localPosition = Vector3.New(-0.7, -0.71, -6)

				local var_378_7 = manager.ui.mainCamera.transform.position - var_378_0.position

				var_378_0.forward = Vector3.New(var_378_7.x, var_378_7.y, var_378_7.z)

				local var_378_8 = var_378_0.localEulerAngles

				var_378_8.z = 0
				var_378_8.x = 0
				var_378_0.localEulerAngles = var_378_8
			end

			local var_378_9 = arg_375_1.actors_["1011ui_story"]
			local var_378_10 = 0

			if var_378_10 < arg_375_1.time_ and arg_375_1.time_ <= var_378_10 + arg_378_0 and not isNil(var_378_9) and arg_375_1.var_.characterEffect1011ui_story == nil then
				arg_375_1.var_.characterEffect1011ui_story = var_378_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_378_11 = 0.200000002980232

			if var_378_10 <= arg_375_1.time_ and arg_375_1.time_ < var_378_10 + var_378_11 and not isNil(var_378_9) then
				local var_378_12 = (arg_375_1.time_ - var_378_10) / var_378_11

				if arg_375_1.var_.characterEffect1011ui_story and not isNil(var_378_9) then
					arg_375_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_375_1.time_ >= var_378_10 + var_378_11 and arg_375_1.time_ < var_378_10 + var_378_11 + arg_378_0 and not isNil(var_378_9) and arg_375_1.var_.characterEffect1011ui_story then
				arg_375_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_378_13 = 0

			if var_378_13 < arg_375_1.time_ and arg_375_1.time_ <= var_378_13 + arg_378_0 then
				arg_375_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_378_14 = 0
			local var_378_15 = 0.575

			if var_378_14 < arg_375_1.time_ and arg_375_1.time_ <= var_378_14 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, true)

				local var_378_16 = arg_375_1:FormatText(StoryNameCfg[37].name)

				arg_375_1.leftNameTxt_.text = var_378_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_375_1.leftNameTxt_.transform)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1.leftNameTxt_.text)
				SetActive(arg_375_1.iconTrs_.gameObject, false)
				arg_375_1.callingController_:SetSelectedState("normal")

				local var_378_17 = arg_375_1:GetWordFromCfg(1101105090)
				local var_378_18 = arg_375_1:FormatText(var_378_17.content)

				arg_375_1.text_.text = var_378_18

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_19 = 23
				local var_378_20 = utf8.len(var_378_18)
				local var_378_21 = var_378_19 <= 0 and var_378_15 or var_378_15 * (var_378_20 / var_378_19)

				if var_378_21 > 0 and var_378_15 < var_378_21 then
					arg_375_1.talkMaxDuration = var_378_21

					if var_378_21 + var_378_14 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_21 + var_378_14
					end
				end

				arg_375_1.text_.text = var_378_18
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105090", "story_v_side_new_1101105.awb") ~= 0 then
					local var_378_22 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105090", "story_v_side_new_1101105.awb") / 1000

					if var_378_22 + var_378_14 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_22 + var_378_14
					end

					if var_378_17.prefab_name ~= "" and arg_375_1.actors_[var_378_17.prefab_name] ~= nil then
						local var_378_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_375_1.actors_[var_378_17.prefab_name].transform, "story_v_side_new_1101105", "1101105090", "story_v_side_new_1101105.awb")

						arg_375_1:RecordAudio("1101105090", var_378_23)
						arg_375_1:RecordAudio("1101105090", var_378_23)
					else
						arg_375_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105090", "story_v_side_new_1101105.awb")
					end

					arg_375_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105090", "story_v_side_new_1101105.awb")
				end

				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_24 = math.max(var_378_15, arg_375_1.talkMaxDuration)

			if var_378_14 <= arg_375_1.time_ and arg_375_1.time_ < var_378_14 + var_378_24 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - var_378_14) / var_378_24

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= var_378_14 + var_378_24 and arg_375_1.time_ < var_378_14 + var_378_24 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_375_1:InitPlayNodeList()
	end,
	Play1101105091 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 1101105091
		arg_379_1.duration_ = 8.93

		local var_379_0 = {
			zh = 3.833,
			ja = 8.933
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
				arg_379_0:Play1101105092(arg_379_1)
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
				local var_382_4 = Vector3.New(0.7, -0.87, -5.7)

				var_382_0.localPosition = Vector3.Lerp(arg_379_1.var_.moveOldPos1111ui_story, var_382_4, var_382_3)

				local var_382_5 = manager.ui.mainCamera.transform.position - var_382_0.position

				var_382_0.forward = Vector3.New(var_382_5.x, var_382_5.y, var_382_5.z)

				local var_382_6 = var_382_0.localEulerAngles

				var_382_6.z = 0
				var_382_6.x = 0
				var_382_0.localEulerAngles = var_382_6
			end

			if arg_379_1.time_ >= var_382_1 + var_382_2 and arg_379_1.time_ < var_382_1 + var_382_2 + arg_382_0 then
				var_382_0.localPosition = Vector3.New(0.7, -0.87, -5.7)

				local var_382_7 = manager.ui.mainCamera.transform.position - var_382_0.position

				var_382_0.forward = Vector3.New(var_382_7.x, var_382_7.y, var_382_7.z)

				local var_382_8 = var_382_0.localEulerAngles

				var_382_8.z = 0
				var_382_8.x = 0
				var_382_0.localEulerAngles = var_382_8
			end

			local var_382_9 = arg_379_1.actors_["1111ui_story"]
			local var_382_10 = 0

			if var_382_10 < arg_379_1.time_ and arg_379_1.time_ <= var_382_10 + arg_382_0 and not isNil(var_382_9) and arg_379_1.var_.characterEffect1111ui_story == nil then
				arg_379_1.var_.characterEffect1111ui_story = var_382_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_382_11 = 0.200000002980232

			if var_382_10 <= arg_379_1.time_ and arg_379_1.time_ < var_382_10 + var_382_11 and not isNil(var_382_9) then
				local var_382_12 = (arg_379_1.time_ - var_382_10) / var_382_11

				if arg_379_1.var_.characterEffect1111ui_story and not isNil(var_382_9) then
					arg_379_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_379_1.time_ >= var_382_10 + var_382_11 and arg_379_1.time_ < var_382_10 + var_382_11 + arg_382_0 and not isNil(var_382_9) and arg_379_1.var_.characterEffect1111ui_story then
				arg_379_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_382_13 = 0

			if var_382_13 < arg_379_1.time_ and arg_379_1.time_ <= var_382_13 + arg_382_0 then
				arg_379_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action9_1")
			end

			local var_382_14 = 0

			if var_382_14 < arg_379_1.time_ and arg_379_1.time_ <= var_382_14 + arg_382_0 then
				arg_379_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_382_15 = arg_379_1.actors_["1011ui_story"]
			local var_382_16 = 0

			if var_382_16 < arg_379_1.time_ and arg_379_1.time_ <= var_382_16 + arg_382_0 and not isNil(var_382_15) and arg_379_1.var_.characterEffect1011ui_story == nil then
				arg_379_1.var_.characterEffect1011ui_story = var_382_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_382_17 = 0.200000002980232

			if var_382_16 <= arg_379_1.time_ and arg_379_1.time_ < var_382_16 + var_382_17 and not isNil(var_382_15) then
				local var_382_18 = (arg_379_1.time_ - var_382_16) / var_382_17

				if arg_379_1.var_.characterEffect1011ui_story and not isNil(var_382_15) then
					local var_382_19 = Mathf.Lerp(0, 0.5, var_382_18)

					arg_379_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_379_1.var_.characterEffect1011ui_story.fillRatio = var_382_19
				end
			end

			if arg_379_1.time_ >= var_382_16 + var_382_17 and arg_379_1.time_ < var_382_16 + var_382_17 + arg_382_0 and not isNil(var_382_15) and arg_379_1.var_.characterEffect1011ui_story then
				local var_382_20 = 0.5

				arg_379_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_379_1.var_.characterEffect1011ui_story.fillRatio = var_382_20
			end

			local var_382_21 = 0
			local var_382_22 = 0.5

			if var_382_21 < arg_379_1.time_ and arg_379_1.time_ <= var_382_21 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, true)

				local var_382_23 = arg_379_1:FormatText(StoryNameCfg[67].name)

				arg_379_1.leftNameTxt_.text = var_382_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_379_1.leftNameTxt_.transform)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1.leftNameTxt_.text)
				SetActive(arg_379_1.iconTrs_.gameObject, false)
				arg_379_1.callingController_:SetSelectedState("normal")

				local var_382_24 = arg_379_1:GetWordFromCfg(1101105091)
				local var_382_25 = arg_379_1:FormatText(var_382_24.content)

				arg_379_1.text_.text = var_382_25

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_26 = 20
				local var_382_27 = utf8.len(var_382_25)
				local var_382_28 = var_382_26 <= 0 and var_382_22 or var_382_22 * (var_382_27 / var_382_26)

				if var_382_28 > 0 and var_382_22 < var_382_28 then
					arg_379_1.talkMaxDuration = var_382_28

					if var_382_28 + var_382_21 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_28 + var_382_21
					end
				end

				arg_379_1.text_.text = var_382_25
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105091", "story_v_side_new_1101105.awb") ~= 0 then
					local var_382_29 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105091", "story_v_side_new_1101105.awb") / 1000

					if var_382_29 + var_382_21 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_29 + var_382_21
					end

					if var_382_24.prefab_name ~= "" and arg_379_1.actors_[var_382_24.prefab_name] ~= nil then
						local var_382_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_379_1.actors_[var_382_24.prefab_name].transform, "story_v_side_new_1101105", "1101105091", "story_v_side_new_1101105.awb")

						arg_379_1:RecordAudio("1101105091", var_382_30)
						arg_379_1:RecordAudio("1101105091", var_382_30)
					else
						arg_379_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105091", "story_v_side_new_1101105.awb")
					end

					arg_379_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105091", "story_v_side_new_1101105.awb")
				end

				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_31 = math.max(var_382_22, arg_379_1.talkMaxDuration)

			if var_382_21 <= arg_379_1.time_ and arg_379_1.time_ < var_382_21 + var_382_31 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - var_382_21) / var_382_31

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= var_382_21 + var_382_31 and arg_379_1.time_ < var_382_21 + var_382_31 + arg_382_0 then
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
	Play1101105092 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 1101105092
		arg_383_1.duration_ = 9.37

		local var_383_0 = {
			zh = 7.7,
			ja = 9.366
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
				arg_383_0:Play1101105093(arg_383_1)
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
				local var_386_4 = Vector3.New(0.7, -0.87, -5.7)

				var_386_0.localPosition = Vector3.Lerp(arg_383_1.var_.moveOldPos1111ui_story, var_386_4, var_386_3)

				local var_386_5 = manager.ui.mainCamera.transform.position - var_386_0.position

				var_386_0.forward = Vector3.New(var_386_5.x, var_386_5.y, var_386_5.z)

				local var_386_6 = var_386_0.localEulerAngles

				var_386_6.z = 0
				var_386_6.x = 0
				var_386_0.localEulerAngles = var_386_6
			end

			if arg_383_1.time_ >= var_386_1 + var_386_2 and arg_383_1.time_ < var_386_1 + var_386_2 + arg_386_0 then
				var_386_0.localPosition = Vector3.New(0.7, -0.87, -5.7)

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
					arg_383_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_383_1.time_ >= var_386_10 + var_386_11 and arg_383_1.time_ < var_386_10 + var_386_11 + arg_386_0 and not isNil(var_386_9) and arg_383_1.var_.characterEffect1111ui_story then
				arg_383_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_386_13 = 0

			if var_386_13 < arg_383_1.time_ and arg_383_1.time_ <= var_386_13 + arg_386_0 then
				arg_383_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_386_14 = 0

			if var_386_14 < arg_383_1.time_ and arg_383_1.time_ <= var_386_14 + arg_386_0 then
				arg_383_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111actionlink/1111action498")
			end

			local var_386_15 = 0
			local var_386_16 = 0.825

			if var_386_15 < arg_383_1.time_ and arg_383_1.time_ <= var_386_15 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, true)

				local var_386_17 = arg_383_1:FormatText(StoryNameCfg[67].name)

				arg_383_1.leftNameTxt_.text = var_386_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_383_1.leftNameTxt_.transform)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1.leftNameTxt_.text)
				SetActive(arg_383_1.iconTrs_.gameObject, false)
				arg_383_1.callingController_:SetSelectedState("normal")

				local var_386_18 = arg_383_1:GetWordFromCfg(1101105092)
				local var_386_19 = arg_383_1:FormatText(var_386_18.content)

				arg_383_1.text_.text = var_386_19

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_20 = 33
				local var_386_21 = utf8.len(var_386_19)
				local var_386_22 = var_386_20 <= 0 and var_386_16 or var_386_16 * (var_386_21 / var_386_20)

				if var_386_22 > 0 and var_386_16 < var_386_22 then
					arg_383_1.talkMaxDuration = var_386_22

					if var_386_22 + var_386_15 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_22 + var_386_15
					end
				end

				arg_383_1.text_.text = var_386_19
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105092", "story_v_side_new_1101105.awb") ~= 0 then
					local var_386_23 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105092", "story_v_side_new_1101105.awb") / 1000

					if var_386_23 + var_386_15 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_23 + var_386_15
					end

					if var_386_18.prefab_name ~= "" and arg_383_1.actors_[var_386_18.prefab_name] ~= nil then
						local var_386_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_383_1.actors_[var_386_18.prefab_name].transform, "story_v_side_new_1101105", "1101105092", "story_v_side_new_1101105.awb")

						arg_383_1:RecordAudio("1101105092", var_386_24)
						arg_383_1:RecordAudio("1101105092", var_386_24)
					else
						arg_383_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105092", "story_v_side_new_1101105.awb")
					end

					arg_383_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105092", "story_v_side_new_1101105.awb")
				end

				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_25 = math.max(var_386_16, arg_383_1.talkMaxDuration)

			if var_386_15 <= arg_383_1.time_ and arg_383_1.time_ < var_386_15 + var_386_25 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - var_386_15) / var_386_25

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= var_386_15 + var_386_25 and arg_383_1.time_ < var_386_15 + var_386_25 + arg_386_0 then
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
	Play1101105093 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 1101105093
		arg_387_1.duration_ = 3.67

		local var_387_0 = {
			zh = 2.966,
			ja = 3.666
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
				arg_387_0:Play1101105094(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			local var_390_0 = arg_387_1.actors_["1011ui_story"].transform
			local var_390_1 = 0

			if var_390_1 < arg_387_1.time_ and arg_387_1.time_ <= var_390_1 + arg_390_0 then
				arg_387_1.var_.moveOldPos1011ui_story = var_390_0.localPosition
			end

			local var_390_2 = 0.001

			if var_390_1 <= arg_387_1.time_ and arg_387_1.time_ < var_390_1 + var_390_2 then
				local var_390_3 = (arg_387_1.time_ - var_390_1) / var_390_2
				local var_390_4 = Vector3.New(-0.7, -0.71, -6)

				var_390_0.localPosition = Vector3.Lerp(arg_387_1.var_.moveOldPos1011ui_story, var_390_4, var_390_3)

				local var_390_5 = manager.ui.mainCamera.transform.position - var_390_0.position

				var_390_0.forward = Vector3.New(var_390_5.x, var_390_5.y, var_390_5.z)

				local var_390_6 = var_390_0.localEulerAngles

				var_390_6.z = 0
				var_390_6.x = 0
				var_390_0.localEulerAngles = var_390_6
			end

			if arg_387_1.time_ >= var_390_1 + var_390_2 and arg_387_1.time_ < var_390_1 + var_390_2 + arg_390_0 then
				var_390_0.localPosition = Vector3.New(-0.7, -0.71, -6)

				local var_390_7 = manager.ui.mainCamera.transform.position - var_390_0.position

				var_390_0.forward = Vector3.New(var_390_7.x, var_390_7.y, var_390_7.z)

				local var_390_8 = var_390_0.localEulerAngles

				var_390_8.z = 0
				var_390_8.x = 0
				var_390_0.localEulerAngles = var_390_8
			end

			local var_390_9 = arg_387_1.actors_["1011ui_story"]
			local var_390_10 = 0

			if var_390_10 < arg_387_1.time_ and arg_387_1.time_ <= var_390_10 + arg_390_0 and not isNil(var_390_9) and arg_387_1.var_.characterEffect1011ui_story == nil then
				arg_387_1.var_.characterEffect1011ui_story = var_390_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_390_11 = 0.200000002980232

			if var_390_10 <= arg_387_1.time_ and arg_387_1.time_ < var_390_10 + var_390_11 and not isNil(var_390_9) then
				local var_390_12 = (arg_387_1.time_ - var_390_10) / var_390_11

				if arg_387_1.var_.characterEffect1011ui_story and not isNil(var_390_9) then
					arg_387_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_387_1.time_ >= var_390_10 + var_390_11 and arg_387_1.time_ < var_390_10 + var_390_11 + arg_390_0 and not isNil(var_390_9) and arg_387_1.var_.characterEffect1011ui_story then
				arg_387_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_390_13 = 0

			if var_390_13 < arg_387_1.time_ and arg_387_1.time_ <= var_390_13 + arg_390_0 then
				arg_387_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_390_14 = arg_387_1.actors_["1111ui_story"]
			local var_390_15 = 0

			if var_390_15 < arg_387_1.time_ and arg_387_1.time_ <= var_390_15 + arg_390_0 and not isNil(var_390_14) and arg_387_1.var_.characterEffect1111ui_story == nil then
				arg_387_1.var_.characterEffect1111ui_story = var_390_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_390_16 = 0.200000002980232

			if var_390_15 <= arg_387_1.time_ and arg_387_1.time_ < var_390_15 + var_390_16 and not isNil(var_390_14) then
				local var_390_17 = (arg_387_1.time_ - var_390_15) / var_390_16

				if arg_387_1.var_.characterEffect1111ui_story and not isNil(var_390_14) then
					local var_390_18 = Mathf.Lerp(0, 0.5, var_390_17)

					arg_387_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_387_1.var_.characterEffect1111ui_story.fillRatio = var_390_18
				end
			end

			if arg_387_1.time_ >= var_390_15 + var_390_16 and arg_387_1.time_ < var_390_15 + var_390_16 + arg_390_0 and not isNil(var_390_14) and arg_387_1.var_.characterEffect1111ui_story then
				local var_390_19 = 0.5

				arg_387_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_387_1.var_.characterEffect1111ui_story.fillRatio = var_390_19
			end

			local var_390_20 = 0
			local var_390_21 = 0.075

			if var_390_20 < arg_387_1.time_ and arg_387_1.time_ <= var_390_20 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0
				arg_387_1.dialogCg_.alpha = 1

				arg_387_1.dialog_:SetActive(true)
				SetActive(arg_387_1.leftNameGo_, true)

				local var_390_22 = arg_387_1:FormatText(StoryNameCfg[37].name)

				arg_387_1.leftNameTxt_.text = var_390_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_387_1.leftNameTxt_.transform)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1.leftNameTxt_.text)
				SetActive(arg_387_1.iconTrs_.gameObject, false)
				arg_387_1.callingController_:SetSelectedState("normal")

				local var_390_23 = arg_387_1:GetWordFromCfg(1101105093)
				local var_390_24 = arg_387_1:FormatText(var_390_23.content)

				arg_387_1.text_.text = var_390_24

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_25 = 3
				local var_390_26 = utf8.len(var_390_24)
				local var_390_27 = var_390_25 <= 0 and var_390_21 or var_390_21 * (var_390_26 / var_390_25)

				if var_390_27 > 0 and var_390_21 < var_390_27 then
					arg_387_1.talkMaxDuration = var_390_27

					if var_390_27 + var_390_20 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_27 + var_390_20
					end
				end

				arg_387_1.text_.text = var_390_24
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105093", "story_v_side_new_1101105.awb") ~= 0 then
					local var_390_28 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105093", "story_v_side_new_1101105.awb") / 1000

					if var_390_28 + var_390_20 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_28 + var_390_20
					end

					if var_390_23.prefab_name ~= "" and arg_387_1.actors_[var_390_23.prefab_name] ~= nil then
						local var_390_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_387_1.actors_[var_390_23.prefab_name].transform, "story_v_side_new_1101105", "1101105093", "story_v_side_new_1101105.awb")

						arg_387_1:RecordAudio("1101105093", var_390_29)
						arg_387_1:RecordAudio("1101105093", var_390_29)
					else
						arg_387_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105093", "story_v_side_new_1101105.awb")
					end

					arg_387_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105093", "story_v_side_new_1101105.awb")
				end

				arg_387_1:RecordContent(arg_387_1.text_.text)
			end

			local var_390_30 = math.max(var_390_21, arg_387_1.talkMaxDuration)

			if var_390_20 <= arg_387_1.time_ and arg_387_1.time_ < var_390_20 + var_390_30 then
				arg_387_1.typewritter.percent = (arg_387_1.time_ - var_390_20) / var_390_30

				arg_387_1.typewritter:SetDirty()
			end

			if arg_387_1.time_ >= var_390_20 + var_390_30 and arg_387_1.time_ < var_390_20 + var_390_30 + arg_390_0 then
				arg_387_1.typewritter.percent = 1

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(true)
			end
		end

		arg_387_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
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
	Play1101105094 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 1101105094
		arg_391_1.duration_ = 9

		SetActive(arg_391_1.tipsGo_, false)

		function arg_391_1.onSingleLineFinish_()
			arg_391_1.onSingleLineUpdate_ = nil
			arg_391_1.onSingleLineFinish_ = nil
			arg_391_1.state_ = "waiting"
		end

		function arg_391_1.playNext_(arg_393_0)
			if arg_393_0 == 1 then
				arg_391_0:Play1101105095(arg_391_1)
			end
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			local var_394_0 = 2

			if var_394_0 < arg_391_1.time_ and arg_391_1.time_ <= var_394_0 + arg_394_0 then
				local var_394_1 = manager.ui.mainCamera.transform.localPosition
				local var_394_2 = Vector3.New(0, 0, 10) + Vector3.New(var_394_1.x, var_394_1.y, 0)
				local var_394_3 = arg_391_1.bgs_.ST12

				var_394_3.transform.localPosition = var_394_2
				var_394_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_394_4 = var_394_3:GetComponent("SpriteRenderer")

				if var_394_4 and var_394_4.sprite then
					local var_394_5 = (var_394_3.transform.localPosition - var_394_1).z
					local var_394_6 = manager.ui.mainCameraCom_
					local var_394_7 = 2 * var_394_5 * Mathf.Tan(var_394_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_394_8 = var_394_7 * var_394_6.aspect
					local var_394_9 = var_394_4.sprite.bounds.size.x
					local var_394_10 = var_394_4.sprite.bounds.size.y
					local var_394_11 = var_394_8 / var_394_9
					local var_394_12 = var_394_7 / var_394_10
					local var_394_13 = var_394_12 < var_394_11 and var_394_11 or var_394_12

					var_394_3.transform.localScale = Vector3.New(var_394_13, var_394_13, 0)
				end

				for iter_394_0, iter_394_1 in pairs(arg_391_1.bgs_) do
					if iter_394_0 ~= "ST12" then
						iter_394_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_394_14 = 0

			if var_394_14 < arg_391_1.time_ and arg_391_1.time_ <= var_394_14 + arg_394_0 then
				arg_391_1.mask_.enabled = true
				arg_391_1.mask_.raycastTarget = true

				arg_391_1:SetGaussion(false)
			end

			local var_394_15 = 2

			if var_394_14 <= arg_391_1.time_ and arg_391_1.time_ < var_394_14 + var_394_15 then
				local var_394_16 = (arg_391_1.time_ - var_394_14) / var_394_15
				local var_394_17 = Color.New(0, 0, 0)

				var_394_17.a = Mathf.Lerp(0, 1, var_394_16)
				arg_391_1.mask_.color = var_394_17
			end

			if arg_391_1.time_ >= var_394_14 + var_394_15 and arg_391_1.time_ < var_394_14 + var_394_15 + arg_394_0 then
				local var_394_18 = Color.New(0, 0, 0)

				var_394_18.a = 1
				arg_391_1.mask_.color = var_394_18
			end

			local var_394_19 = 2

			if var_394_19 < arg_391_1.time_ and arg_391_1.time_ <= var_394_19 + arg_394_0 then
				arg_391_1.mask_.enabled = true
				arg_391_1.mask_.raycastTarget = true

				arg_391_1:SetGaussion(false)
			end

			local var_394_20 = 2

			if var_394_19 <= arg_391_1.time_ and arg_391_1.time_ < var_394_19 + var_394_20 then
				local var_394_21 = (arg_391_1.time_ - var_394_19) / var_394_20
				local var_394_22 = Color.New(0, 0, 0)

				var_394_22.a = Mathf.Lerp(1, 0, var_394_21)
				arg_391_1.mask_.color = var_394_22
			end

			if arg_391_1.time_ >= var_394_19 + var_394_20 and arg_391_1.time_ < var_394_19 + var_394_20 + arg_394_0 then
				local var_394_23 = Color.New(0, 0, 0)
				local var_394_24 = 0

				arg_391_1.mask_.enabled = false
				var_394_23.a = var_394_24
				arg_391_1.mask_.color = var_394_23
			end

			local var_394_25 = arg_391_1.actors_["1011ui_story"].transform
			local var_394_26 = 2

			if var_394_26 < arg_391_1.time_ and arg_391_1.time_ <= var_394_26 + arg_394_0 then
				arg_391_1.var_.moveOldPos1011ui_story = var_394_25.localPosition
			end

			local var_394_27 = 0.001

			if var_394_26 <= arg_391_1.time_ and arg_391_1.time_ < var_394_26 + var_394_27 then
				local var_394_28 = (arg_391_1.time_ - var_394_26) / var_394_27
				local var_394_29 = Vector3.New(0, 100, 0)

				var_394_25.localPosition = Vector3.Lerp(arg_391_1.var_.moveOldPos1011ui_story, var_394_29, var_394_28)

				local var_394_30 = manager.ui.mainCamera.transform.position - var_394_25.position

				var_394_25.forward = Vector3.New(var_394_30.x, var_394_30.y, var_394_30.z)

				local var_394_31 = var_394_25.localEulerAngles

				var_394_31.z = 0
				var_394_31.x = 0
				var_394_25.localEulerAngles = var_394_31
			end

			if arg_391_1.time_ >= var_394_26 + var_394_27 and arg_391_1.time_ < var_394_26 + var_394_27 + arg_394_0 then
				var_394_25.localPosition = Vector3.New(0, 100, 0)

				local var_394_32 = manager.ui.mainCamera.transform.position - var_394_25.position

				var_394_25.forward = Vector3.New(var_394_32.x, var_394_32.y, var_394_32.z)

				local var_394_33 = var_394_25.localEulerAngles

				var_394_33.z = 0
				var_394_33.x = 0
				var_394_25.localEulerAngles = var_394_33
			end

			local var_394_34 = arg_391_1.actors_["1111ui_story"].transform
			local var_394_35 = 2

			if var_394_35 < arg_391_1.time_ and arg_391_1.time_ <= var_394_35 + arg_394_0 then
				arg_391_1.var_.moveOldPos1111ui_story = var_394_34.localPosition
			end

			local var_394_36 = 0.001

			if var_394_35 <= arg_391_1.time_ and arg_391_1.time_ < var_394_35 + var_394_36 then
				local var_394_37 = (arg_391_1.time_ - var_394_35) / var_394_36
				local var_394_38 = Vector3.New(0, 100, 0)

				var_394_34.localPosition = Vector3.Lerp(arg_391_1.var_.moveOldPos1111ui_story, var_394_38, var_394_37)

				local var_394_39 = manager.ui.mainCamera.transform.position - var_394_34.position

				var_394_34.forward = Vector3.New(var_394_39.x, var_394_39.y, var_394_39.z)

				local var_394_40 = var_394_34.localEulerAngles

				var_394_40.z = 0
				var_394_40.x = 0
				var_394_34.localEulerAngles = var_394_40
			end

			if arg_391_1.time_ >= var_394_35 + var_394_36 and arg_391_1.time_ < var_394_35 + var_394_36 + arg_394_0 then
				var_394_34.localPosition = Vector3.New(0, 100, 0)

				local var_394_41 = manager.ui.mainCamera.transform.position - var_394_34.position

				var_394_34.forward = Vector3.New(var_394_41.x, var_394_41.y, var_394_41.z)

				local var_394_42 = var_394_34.localEulerAngles

				var_394_42.z = 0
				var_394_42.x = 0
				var_394_34.localEulerAngles = var_394_42
			end

			if arg_391_1.frameCnt_ <= 1 then
				arg_391_1.dialog_:SetActive(false)
			end

			local var_394_43 = 4
			local var_394_44 = 0.675

			if var_394_43 < arg_391_1.time_ and arg_391_1.time_ <= var_394_43 + arg_394_0 then
				arg_391_1.talkMaxDuration = 0

				arg_391_1.dialog_:SetActive(true)

				arg_391_1.dialogCg_.alpha = 0

				local var_394_45 = LeanTween.value(arg_391_1.dialog_, 0, 1, 0.3)

				var_394_45:setOnUpdate(LuaHelper.FloatAction(function(arg_395_0)
					arg_391_1.dialogCg_.alpha = arg_395_0
				end))
				var_394_45:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_391_1.dialog_)
					var_394_45:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_391_1.duration_ = arg_391_1.duration_ + 0.3

				SetActive(arg_391_1.leftNameGo_, true)

				local var_394_46 = arg_391_1:FormatText(StoryNameCfg[7].name)

				arg_391_1.leftNameTxt_.text = var_394_46

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

				local var_394_47 = arg_391_1:GetWordFromCfg(1101105094)
				local var_394_48 = arg_391_1:FormatText(var_394_47.content)

				arg_391_1.text_.text = var_394_48

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_49 = 27
				local var_394_50 = utf8.len(var_394_48)
				local var_394_51 = var_394_49 <= 0 and var_394_44 or var_394_44 * (var_394_50 / var_394_49)

				if var_394_51 > 0 and var_394_44 < var_394_51 then
					arg_391_1.talkMaxDuration = var_394_51
					var_394_43 = var_394_43 + 0.3

					if var_394_51 + var_394_43 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_51 + var_394_43
					end
				end

				arg_391_1.text_.text = var_394_48
				arg_391_1.typewritter.percent = 0

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(false)
				arg_391_1:RecordContent(arg_391_1.text_.text)
			end

			local var_394_52 = var_394_43 + 0.3
			local var_394_53 = math.max(var_394_44, arg_391_1.talkMaxDuration)

			if var_394_52 <= arg_391_1.time_ and arg_391_1.time_ < var_394_52 + var_394_53 then
				arg_391_1.typewritter.percent = (arg_391_1.time_ - var_394_52) / var_394_53

				arg_391_1.typewritter:SetDirty()
			end

			if arg_391_1.time_ >= var_394_52 + var_394_53 and arg_391_1.time_ < var_394_52 + var_394_53 + arg_394_0 then
				arg_391_1.typewritter.percent = 1

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(true)
			end
		end

		arg_391_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_391_1:InitPlayNodeList()
	end,
	Play1101105095 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 1101105095
		arg_397_1.duration_ = 5

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play1101105096(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			local var_400_0 = 0
			local var_400_1 = 0.65

			if var_400_0 < arg_397_1.time_ and arg_397_1.time_ <= var_400_0 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, false)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_397_1.iconTrs_.gameObject, false)
				arg_397_1.callingController_:SetSelectedState("normal")

				local var_400_2 = arg_397_1:GetWordFromCfg(1101105095)
				local var_400_3 = arg_397_1:FormatText(var_400_2.content)

				arg_397_1.text_.text = var_400_3

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_4 = 26
				local var_400_5 = utf8.len(var_400_3)
				local var_400_6 = var_400_4 <= 0 and var_400_1 or var_400_1 * (var_400_5 / var_400_4)

				if var_400_6 > 0 and var_400_1 < var_400_6 then
					arg_397_1.talkMaxDuration = var_400_6

					if var_400_6 + var_400_0 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_6 + var_400_0
					end
				end

				arg_397_1.text_.text = var_400_3
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)
				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_7 = math.max(var_400_1, arg_397_1.talkMaxDuration)

			if var_400_0 <= arg_397_1.time_ and arg_397_1.time_ < var_400_0 + var_400_7 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - var_400_0) / var_400_7

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= var_400_0 + var_400_7 and arg_397_1.time_ < var_400_0 + var_400_7 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {}

		arg_397_1:InitPlayNodeList()
	end,
	Play1101105096 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 1101105096
		arg_401_1.duration_ = 5

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play1101105097(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			local var_404_0 = 0
			local var_404_1 = 0.725

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

				local var_404_2 = arg_401_1:GetWordFromCfg(1101105096)
				local var_404_3 = arg_401_1:FormatText(var_404_2.content)

				arg_401_1.text_.text = var_404_3

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_4 = 35
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
	Play1101105097 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 1101105097
		arg_405_1.duration_ = 5

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play1101105098(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			local var_408_0 = 0
			local var_408_1 = 0.55

			if var_408_0 < arg_405_1.time_ and arg_405_1.time_ <= var_408_0 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, false)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_405_1.iconTrs_.gameObject, false)
				arg_405_1.callingController_:SetSelectedState("normal")

				local var_408_2 = arg_405_1:GetWordFromCfg(1101105097)
				local var_408_3 = arg_405_1:FormatText(var_408_2.content)

				arg_405_1.text_.text = var_408_3

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_4 = 22
				local var_408_5 = utf8.len(var_408_3)
				local var_408_6 = var_408_4 <= 0 and var_408_1 or var_408_1 * (var_408_5 / var_408_4)

				if var_408_6 > 0 and var_408_1 < var_408_6 then
					arg_405_1.talkMaxDuration = var_408_6

					if var_408_6 + var_408_0 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_6 + var_408_0
					end
				end

				arg_405_1.text_.text = var_408_3
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)
				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_7 = math.max(var_408_1, arg_405_1.talkMaxDuration)

			if var_408_0 <= arg_405_1.time_ and arg_405_1.time_ < var_408_0 + var_408_7 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - var_408_0) / var_408_7

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= var_408_0 + var_408_7 and arg_405_1.time_ < var_408_0 + var_408_7 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {}

		arg_405_1:InitPlayNodeList()
	end,
	Play1101105098 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 1101105098
		arg_409_1.duration_ = 9.43

		local var_409_0 = {
			zh = 4.833,
			ja = 9.433
		}
		local var_409_1 = manager.audio:GetLocalizationFlag()

		if var_409_0[var_409_1] ~= nil then
			arg_409_1.duration_ = var_409_0[var_409_1]
		end

		SetActive(arg_409_1.tipsGo_, false)

		function arg_409_1.onSingleLineFinish_()
			arg_409_1.onSingleLineUpdate_ = nil
			arg_409_1.onSingleLineFinish_ = nil
			arg_409_1.state_ = "waiting"
		end

		function arg_409_1.playNext_(arg_411_0)
			if arg_411_0 == 1 then
				arg_409_0:Play1101105099(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			local var_412_0 = arg_409_1.actors_["1011ui_story"].transform
			local var_412_1 = 0

			if var_412_1 < arg_409_1.time_ and arg_409_1.time_ <= var_412_1 + arg_412_0 then
				arg_409_1.var_.moveOldPos1011ui_story = var_412_0.localPosition
			end

			local var_412_2 = 0.001

			if var_412_1 <= arg_409_1.time_ and arg_409_1.time_ < var_412_1 + var_412_2 then
				local var_412_3 = (arg_409_1.time_ - var_412_1) / var_412_2
				local var_412_4 = Vector3.New(0, -0.71, -6)

				var_412_0.localPosition = Vector3.Lerp(arg_409_1.var_.moveOldPos1011ui_story, var_412_4, var_412_3)

				local var_412_5 = manager.ui.mainCamera.transform.position - var_412_0.position

				var_412_0.forward = Vector3.New(var_412_5.x, var_412_5.y, var_412_5.z)

				local var_412_6 = var_412_0.localEulerAngles

				var_412_6.z = 0
				var_412_6.x = 0
				var_412_0.localEulerAngles = var_412_6
			end

			if arg_409_1.time_ >= var_412_1 + var_412_2 and arg_409_1.time_ < var_412_1 + var_412_2 + arg_412_0 then
				var_412_0.localPosition = Vector3.New(0, -0.71, -6)

				local var_412_7 = manager.ui.mainCamera.transform.position - var_412_0.position

				var_412_0.forward = Vector3.New(var_412_7.x, var_412_7.y, var_412_7.z)

				local var_412_8 = var_412_0.localEulerAngles

				var_412_8.z = 0
				var_412_8.x = 0
				var_412_0.localEulerAngles = var_412_8
			end

			local var_412_9 = arg_409_1.actors_["1011ui_story"]
			local var_412_10 = 0

			if var_412_10 < arg_409_1.time_ and arg_409_1.time_ <= var_412_10 + arg_412_0 and not isNil(var_412_9) and arg_409_1.var_.characterEffect1011ui_story == nil then
				arg_409_1.var_.characterEffect1011ui_story = var_412_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_412_11 = 0.200000002980232

			if var_412_10 <= arg_409_1.time_ and arg_409_1.time_ < var_412_10 + var_412_11 and not isNil(var_412_9) then
				local var_412_12 = (arg_409_1.time_ - var_412_10) / var_412_11

				if arg_409_1.var_.characterEffect1011ui_story and not isNil(var_412_9) then
					arg_409_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_409_1.time_ >= var_412_10 + var_412_11 and arg_409_1.time_ < var_412_10 + var_412_11 + arg_412_0 and not isNil(var_412_9) and arg_409_1.var_.characterEffect1011ui_story then
				arg_409_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_412_13 = 0

			if var_412_13 < arg_409_1.time_ and arg_409_1.time_ <= var_412_13 + arg_412_0 then
				arg_409_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action4_1")
			end

			local var_412_14 = 0

			if var_412_14 < arg_409_1.time_ and arg_409_1.time_ <= var_412_14 + arg_412_0 then
				arg_409_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_412_15 = 0
			local var_412_16 = 0.575

			if var_412_15 < arg_409_1.time_ and arg_409_1.time_ <= var_412_15 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0
				arg_409_1.dialogCg_.alpha = 1

				arg_409_1.dialog_:SetActive(true)
				SetActive(arg_409_1.leftNameGo_, true)

				local var_412_17 = arg_409_1:FormatText(StoryNameCfg[37].name)

				arg_409_1.leftNameTxt_.text = var_412_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_409_1.leftNameTxt_.transform)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1.leftNameTxt_.text)
				SetActive(arg_409_1.iconTrs_.gameObject, false)
				arg_409_1.callingController_:SetSelectedState("normal")

				local var_412_18 = arg_409_1:GetWordFromCfg(1101105098)
				local var_412_19 = arg_409_1:FormatText(var_412_18.content)

				arg_409_1.text_.text = var_412_19

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_20 = 23
				local var_412_21 = utf8.len(var_412_19)
				local var_412_22 = var_412_20 <= 0 and var_412_16 or var_412_16 * (var_412_21 / var_412_20)

				if var_412_22 > 0 and var_412_16 < var_412_22 then
					arg_409_1.talkMaxDuration = var_412_22

					if var_412_22 + var_412_15 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_22 + var_412_15
					end
				end

				arg_409_1.text_.text = var_412_19
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105098", "story_v_side_new_1101105.awb") ~= 0 then
					local var_412_23 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105098", "story_v_side_new_1101105.awb") / 1000

					if var_412_23 + var_412_15 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_23 + var_412_15
					end

					if var_412_18.prefab_name ~= "" and arg_409_1.actors_[var_412_18.prefab_name] ~= nil then
						local var_412_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_409_1.actors_[var_412_18.prefab_name].transform, "story_v_side_new_1101105", "1101105098", "story_v_side_new_1101105.awb")

						arg_409_1:RecordAudio("1101105098", var_412_24)
						arg_409_1:RecordAudio("1101105098", var_412_24)
					else
						arg_409_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105098", "story_v_side_new_1101105.awb")
					end

					arg_409_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105098", "story_v_side_new_1101105.awb")
				end

				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_25 = math.max(var_412_16, arg_409_1.talkMaxDuration)

			if var_412_15 <= arg_409_1.time_ and arg_409_1.time_ < var_412_15 + var_412_25 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - var_412_15) / var_412_25

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= var_412_15 + var_412_25 and arg_409_1.time_ < var_412_15 + var_412_25 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_409_1:InitPlayNodeList()
	end,
	Play1101105099 = function(arg_413_0, arg_413_1)
		arg_413_1.time_ = 0
		arg_413_1.frameCnt_ = 0
		arg_413_1.state_ = "playing"
		arg_413_1.curTalkId_ = 1101105099
		arg_413_1.duration_ = 5

		SetActive(arg_413_1.tipsGo_, false)

		function arg_413_1.onSingleLineFinish_()
			arg_413_1.onSingleLineUpdate_ = nil
			arg_413_1.onSingleLineFinish_ = nil
			arg_413_1.state_ = "waiting"
		end

		function arg_413_1.playNext_(arg_415_0)
			if arg_415_0 == 1 then
				arg_413_0:Play1101105100(arg_413_1)
			end
		end

		function arg_413_1.onSingleLineUpdate_(arg_416_0)
			local var_416_0 = arg_413_1.actors_["1011ui_story"]
			local var_416_1 = 0

			if var_416_1 < arg_413_1.time_ and arg_413_1.time_ <= var_416_1 + arg_416_0 and not isNil(var_416_0) and arg_413_1.var_.characterEffect1011ui_story == nil then
				arg_413_1.var_.characterEffect1011ui_story = var_416_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_416_2 = 0.200000002980232

			if var_416_1 <= arg_413_1.time_ and arg_413_1.time_ < var_416_1 + var_416_2 and not isNil(var_416_0) then
				local var_416_3 = (arg_413_1.time_ - var_416_1) / var_416_2

				if arg_413_1.var_.characterEffect1011ui_story and not isNil(var_416_0) then
					local var_416_4 = Mathf.Lerp(0, 0.5, var_416_3)

					arg_413_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_413_1.var_.characterEffect1011ui_story.fillRatio = var_416_4
				end
			end

			if arg_413_1.time_ >= var_416_1 + var_416_2 and arg_413_1.time_ < var_416_1 + var_416_2 + arg_416_0 and not isNil(var_416_0) and arg_413_1.var_.characterEffect1011ui_story then
				local var_416_5 = 0.5

				arg_413_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_413_1.var_.characterEffect1011ui_story.fillRatio = var_416_5
			end

			local var_416_6 = 0
			local var_416_7 = 0.625

			if var_416_6 < arg_413_1.time_ and arg_413_1.time_ <= var_416_6 + arg_416_0 then
				arg_413_1.talkMaxDuration = 0
				arg_413_1.dialogCg_.alpha = 1

				arg_413_1.dialog_:SetActive(true)
				SetActive(arg_413_1.leftNameGo_, false)

				arg_413_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_413_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_413_1:RecordName(arg_413_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_413_1.iconTrs_.gameObject, false)
				arg_413_1.callingController_:SetSelectedState("normal")

				local var_416_8 = arg_413_1:GetWordFromCfg(1101105099)
				local var_416_9 = arg_413_1:FormatText(var_416_8.content)

				arg_413_1.text_.text = var_416_9

				LuaForUtil.ClearLinePrefixSymbol(arg_413_1.text_)

				local var_416_10 = 25
				local var_416_11 = utf8.len(var_416_9)
				local var_416_12 = var_416_10 <= 0 and var_416_7 or var_416_7 * (var_416_11 / var_416_10)

				if var_416_12 > 0 and var_416_7 < var_416_12 then
					arg_413_1.talkMaxDuration = var_416_12

					if var_416_12 + var_416_6 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_12 + var_416_6
					end
				end

				arg_413_1.text_.text = var_416_9
				arg_413_1.typewritter.percent = 0

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(false)
				arg_413_1:RecordContent(arg_413_1.text_.text)
			end

			local var_416_13 = math.max(var_416_7, arg_413_1.talkMaxDuration)

			if var_416_6 <= arg_413_1.time_ and arg_413_1.time_ < var_416_6 + var_416_13 then
				arg_413_1.typewritter.percent = (arg_413_1.time_ - var_416_6) / var_416_13

				arg_413_1.typewritter:SetDirty()
			end

			if arg_413_1.time_ >= var_416_6 + var_416_13 and arg_413_1.time_ < var_416_6 + var_416_13 + arg_416_0 then
				arg_413_1.typewritter.percent = 1

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(true)
			end
		end

		arg_413_1.nodeConfigList_ = {}

		arg_413_1:InitPlayNodeList()
	end,
	Play1101105100 = function(arg_417_0, arg_417_1)
		arg_417_1.time_ = 0
		arg_417_1.frameCnt_ = 0
		arg_417_1.state_ = "playing"
		arg_417_1.curTalkId_ = 1101105100
		arg_417_1.duration_ = 4.07

		local var_417_0 = {
			zh = 4.066,
			ja = 2.666
		}
		local var_417_1 = manager.audio:GetLocalizationFlag()

		if var_417_0[var_417_1] ~= nil then
			arg_417_1.duration_ = var_417_0[var_417_1]
		end

		SetActive(arg_417_1.tipsGo_, false)

		function arg_417_1.onSingleLineFinish_()
			arg_417_1.onSingleLineUpdate_ = nil
			arg_417_1.onSingleLineFinish_ = nil
			arg_417_1.state_ = "waiting"
		end

		function arg_417_1.playNext_(arg_419_0)
			if arg_419_0 == 1 then
				arg_417_0:Play1101105101(arg_417_1)
			end
		end

		function arg_417_1.onSingleLineUpdate_(arg_420_0)
			local var_420_0 = arg_417_1.actors_["1011ui_story"].transform
			local var_420_1 = 0

			if var_420_1 < arg_417_1.time_ and arg_417_1.time_ <= var_420_1 + arg_420_0 then
				arg_417_1.var_.moveOldPos1011ui_story = var_420_0.localPosition
			end

			local var_420_2 = 0.001

			if var_420_1 <= arg_417_1.time_ and arg_417_1.time_ < var_420_1 + var_420_2 then
				local var_420_3 = (arg_417_1.time_ - var_420_1) / var_420_2
				local var_420_4 = Vector3.New(0, -0.71, -6)

				var_420_0.localPosition = Vector3.Lerp(arg_417_1.var_.moveOldPos1011ui_story, var_420_4, var_420_3)

				local var_420_5 = manager.ui.mainCamera.transform.position - var_420_0.position

				var_420_0.forward = Vector3.New(var_420_5.x, var_420_5.y, var_420_5.z)

				local var_420_6 = var_420_0.localEulerAngles

				var_420_6.z = 0
				var_420_6.x = 0
				var_420_0.localEulerAngles = var_420_6
			end

			if arg_417_1.time_ >= var_420_1 + var_420_2 and arg_417_1.time_ < var_420_1 + var_420_2 + arg_420_0 then
				var_420_0.localPosition = Vector3.New(0, -0.71, -6)

				local var_420_7 = manager.ui.mainCamera.transform.position - var_420_0.position

				var_420_0.forward = Vector3.New(var_420_7.x, var_420_7.y, var_420_7.z)

				local var_420_8 = var_420_0.localEulerAngles

				var_420_8.z = 0
				var_420_8.x = 0
				var_420_0.localEulerAngles = var_420_8
			end

			local var_420_9 = arg_417_1.actors_["1011ui_story"]
			local var_420_10 = 0

			if var_420_10 < arg_417_1.time_ and arg_417_1.time_ <= var_420_10 + arg_420_0 and not isNil(var_420_9) and arg_417_1.var_.characterEffect1011ui_story == nil then
				arg_417_1.var_.characterEffect1011ui_story = var_420_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_420_11 = 0.200000002980232

			if var_420_10 <= arg_417_1.time_ and arg_417_1.time_ < var_420_10 + var_420_11 and not isNil(var_420_9) then
				local var_420_12 = (arg_417_1.time_ - var_420_10) / var_420_11

				if arg_417_1.var_.characterEffect1011ui_story and not isNil(var_420_9) then
					arg_417_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_417_1.time_ >= var_420_10 + var_420_11 and arg_417_1.time_ < var_420_10 + var_420_11 + arg_420_0 and not isNil(var_420_9) and arg_417_1.var_.characterEffect1011ui_story then
				arg_417_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_420_13 = 0

			if var_420_13 < arg_417_1.time_ and arg_417_1.time_ <= var_420_13 + arg_420_0 then
				arg_417_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_420_14 = 0
			local var_420_15 = 0.375

			if var_420_14 < arg_417_1.time_ and arg_417_1.time_ <= var_420_14 + arg_420_0 then
				arg_417_1.talkMaxDuration = 0
				arg_417_1.dialogCg_.alpha = 1

				arg_417_1.dialog_:SetActive(true)
				SetActive(arg_417_1.leftNameGo_, true)

				local var_420_16 = arg_417_1:FormatText(StoryNameCfg[37].name)

				arg_417_1.leftNameTxt_.text = var_420_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_417_1.leftNameTxt_.transform)

				arg_417_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_417_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_417_1:RecordName(arg_417_1.leftNameTxt_.text)
				SetActive(arg_417_1.iconTrs_.gameObject, false)
				arg_417_1.callingController_:SetSelectedState("normal")

				local var_420_17 = arg_417_1:GetWordFromCfg(1101105100)
				local var_420_18 = arg_417_1:FormatText(var_420_17.content)

				arg_417_1.text_.text = var_420_18

				LuaForUtil.ClearLinePrefixSymbol(arg_417_1.text_)

				local var_420_19 = 15
				local var_420_20 = utf8.len(var_420_18)
				local var_420_21 = var_420_19 <= 0 and var_420_15 or var_420_15 * (var_420_20 / var_420_19)

				if var_420_21 > 0 and var_420_15 < var_420_21 then
					arg_417_1.talkMaxDuration = var_420_21

					if var_420_21 + var_420_14 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_21 + var_420_14
					end
				end

				arg_417_1.text_.text = var_420_18
				arg_417_1.typewritter.percent = 0

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105100", "story_v_side_new_1101105.awb") ~= 0 then
					local var_420_22 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105100", "story_v_side_new_1101105.awb") / 1000

					if var_420_22 + var_420_14 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_22 + var_420_14
					end

					if var_420_17.prefab_name ~= "" and arg_417_1.actors_[var_420_17.prefab_name] ~= nil then
						local var_420_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_417_1.actors_[var_420_17.prefab_name].transform, "story_v_side_new_1101105", "1101105100", "story_v_side_new_1101105.awb")

						arg_417_1:RecordAudio("1101105100", var_420_23)
						arg_417_1:RecordAudio("1101105100", var_420_23)
					else
						arg_417_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105100", "story_v_side_new_1101105.awb")
					end

					arg_417_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105100", "story_v_side_new_1101105.awb")
				end

				arg_417_1:RecordContent(arg_417_1.text_.text)
			end

			local var_420_24 = math.max(var_420_15, arg_417_1.talkMaxDuration)

			if var_420_14 <= arg_417_1.time_ and arg_417_1.time_ < var_420_14 + var_420_24 then
				arg_417_1.typewritter.percent = (arg_417_1.time_ - var_420_14) / var_420_24

				arg_417_1.typewritter:SetDirty()
			end

			if arg_417_1.time_ >= var_420_14 + var_420_24 and arg_417_1.time_ < var_420_14 + var_420_24 + arg_420_0 then
				arg_417_1.typewritter.percent = 1

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(true)
			end
		end

		arg_417_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_417_1:InitPlayNodeList()
	end,
	Play1101105101 = function(arg_421_0, arg_421_1)
		arg_421_1.time_ = 0
		arg_421_1.frameCnt_ = 0
		arg_421_1.state_ = "playing"
		arg_421_1.curTalkId_ = 1101105101
		arg_421_1.duration_ = 1

		SetActive(arg_421_1.tipsGo_, false)

		function arg_421_1.onSingleLineFinish_()
			arg_421_1.onSingleLineUpdate_ = nil
			arg_421_1.onSingleLineFinish_ = nil
			arg_421_1.state_ = "waiting"

			SetActive(arg_421_1.choicesGo_, true)

			for iter_422_0, iter_422_1 in ipairs(arg_421_1.choices_) do
				local var_422_0 = iter_422_0 <= 1

				SetActive(iter_422_1.go, var_422_0)
			end

			arg_421_1.choices_[1].txt.text = arg_421_1:FormatText(StoryChoiceCfg[620].name)
		end

		function arg_421_1.playNext_(arg_423_0)
			if arg_423_0 == 1 then
				arg_421_0:Play1101105102(arg_421_1)
			end

			arg_421_1:RecordChoiceLog(1101105101, 620)
		end

		function arg_421_1.onSingleLineUpdate_(arg_424_0)
			local var_424_0 = arg_421_1.actors_["1011ui_story"]
			local var_424_1 = 0

			if var_424_1 < arg_421_1.time_ and arg_421_1.time_ <= var_424_1 + arg_424_0 and not isNil(var_424_0) and arg_421_1.var_.characterEffect1011ui_story == nil then
				arg_421_1.var_.characterEffect1011ui_story = var_424_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_424_2 = 0.200000002980232

			if var_424_1 <= arg_421_1.time_ and arg_421_1.time_ < var_424_1 + var_424_2 and not isNil(var_424_0) then
				local var_424_3 = (arg_421_1.time_ - var_424_1) / var_424_2

				if arg_421_1.var_.characterEffect1011ui_story and not isNil(var_424_0) then
					local var_424_4 = Mathf.Lerp(0, 0.5, var_424_3)

					arg_421_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_421_1.var_.characterEffect1011ui_story.fillRatio = var_424_4
				end
			end

			if arg_421_1.time_ >= var_424_1 + var_424_2 and arg_421_1.time_ < var_424_1 + var_424_2 + arg_424_0 and not isNil(var_424_0) and arg_421_1.var_.characterEffect1011ui_story then
				local var_424_5 = 0.5

				arg_421_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_421_1.var_.characterEffect1011ui_story.fillRatio = var_424_5
			end

			local var_424_6 = 0

			if var_424_6 < arg_421_1.time_ and arg_421_1.time_ <= var_424_6 + arg_424_0 then
				arg_421_1.allBtn_.enabled = false
			end

			local var_424_7 = 0.5

			if arg_421_1.time_ >= var_424_6 + var_424_7 and arg_421_1.time_ < var_424_6 + var_424_7 + arg_424_0 then
				arg_421_1.allBtn_.enabled = true
			end
		end

		arg_421_1.nodeConfigList_ = {}

		arg_421_1:InitPlayNodeList()
	end,
	Play1101105102 = function(arg_425_0, arg_425_1)
		arg_425_1.time_ = 0
		arg_425_1.frameCnt_ = 0
		arg_425_1.state_ = "playing"
		arg_425_1.curTalkId_ = 1101105102
		arg_425_1.duration_ = 3.67

		local var_425_0 = {
			zh = 2.8,
			ja = 3.666
		}
		local var_425_1 = manager.audio:GetLocalizationFlag()

		if var_425_0[var_425_1] ~= nil then
			arg_425_1.duration_ = var_425_0[var_425_1]
		end

		SetActive(arg_425_1.tipsGo_, false)

		function arg_425_1.onSingleLineFinish_()
			arg_425_1.onSingleLineUpdate_ = nil
			arg_425_1.onSingleLineFinish_ = nil
			arg_425_1.state_ = "waiting"
		end

		function arg_425_1.playNext_(arg_427_0)
			if arg_427_0 == 1 then
				arg_425_0:Play1101105103(arg_425_1)
			end
		end

		function arg_425_1.onSingleLineUpdate_(arg_428_0)
			local var_428_0 = arg_425_1.actors_["1011ui_story"].transform
			local var_428_1 = 0

			if var_428_1 < arg_425_1.time_ and arg_425_1.time_ <= var_428_1 + arg_428_0 then
				arg_425_1.var_.moveOldPos1011ui_story = var_428_0.localPosition
			end

			local var_428_2 = 0.001

			if var_428_1 <= arg_425_1.time_ and arg_425_1.time_ < var_428_1 + var_428_2 then
				local var_428_3 = (arg_425_1.time_ - var_428_1) / var_428_2
				local var_428_4 = Vector3.New(0, -0.71, -6)

				var_428_0.localPosition = Vector3.Lerp(arg_425_1.var_.moveOldPos1011ui_story, var_428_4, var_428_3)

				local var_428_5 = manager.ui.mainCamera.transform.position - var_428_0.position

				var_428_0.forward = Vector3.New(var_428_5.x, var_428_5.y, var_428_5.z)

				local var_428_6 = var_428_0.localEulerAngles

				var_428_6.z = 0
				var_428_6.x = 0
				var_428_0.localEulerAngles = var_428_6
			end

			if arg_425_1.time_ >= var_428_1 + var_428_2 and arg_425_1.time_ < var_428_1 + var_428_2 + arg_428_0 then
				var_428_0.localPosition = Vector3.New(0, -0.71, -6)

				local var_428_7 = manager.ui.mainCamera.transform.position - var_428_0.position

				var_428_0.forward = Vector3.New(var_428_7.x, var_428_7.y, var_428_7.z)

				local var_428_8 = var_428_0.localEulerAngles

				var_428_8.z = 0
				var_428_8.x = 0
				var_428_0.localEulerAngles = var_428_8
			end

			local var_428_9 = arg_425_1.actors_["1011ui_story"]
			local var_428_10 = 0

			if var_428_10 < arg_425_1.time_ and arg_425_1.time_ <= var_428_10 + arg_428_0 and not isNil(var_428_9) and arg_425_1.var_.characterEffect1011ui_story == nil then
				arg_425_1.var_.characterEffect1011ui_story = var_428_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_428_11 = 0.200000002980232

			if var_428_10 <= arg_425_1.time_ and arg_425_1.time_ < var_428_10 + var_428_11 and not isNil(var_428_9) then
				local var_428_12 = (arg_425_1.time_ - var_428_10) / var_428_11

				if arg_425_1.var_.characterEffect1011ui_story and not isNil(var_428_9) then
					arg_425_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_425_1.time_ >= var_428_10 + var_428_11 and arg_425_1.time_ < var_428_10 + var_428_11 + arg_428_0 and not isNil(var_428_9) and arg_425_1.var_.characterEffect1011ui_story then
				arg_425_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_428_13 = 0

			if var_428_13 < arg_425_1.time_ and arg_425_1.time_ <= var_428_13 + arg_428_0 then
				arg_425_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action4_2")
			end

			local var_428_14 = 0

			if var_428_14 < arg_425_1.time_ and arg_425_1.time_ <= var_428_14 + arg_428_0 then
				arg_425_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_428_15 = 0
			local var_428_16 = 0.275

			if var_428_15 < arg_425_1.time_ and arg_425_1.time_ <= var_428_15 + arg_428_0 then
				arg_425_1.talkMaxDuration = 0
				arg_425_1.dialogCg_.alpha = 1

				arg_425_1.dialog_:SetActive(true)
				SetActive(arg_425_1.leftNameGo_, true)

				local var_428_17 = arg_425_1:FormatText(StoryNameCfg[37].name)

				arg_425_1.leftNameTxt_.text = var_428_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_425_1.leftNameTxt_.transform)

				arg_425_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_425_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_425_1:RecordName(arg_425_1.leftNameTxt_.text)
				SetActive(arg_425_1.iconTrs_.gameObject, false)
				arg_425_1.callingController_:SetSelectedState("normal")

				local var_428_18 = arg_425_1:GetWordFromCfg(1101105102)
				local var_428_19 = arg_425_1:FormatText(var_428_18.content)

				arg_425_1.text_.text = var_428_19

				LuaForUtil.ClearLinePrefixSymbol(arg_425_1.text_)

				local var_428_20 = 11
				local var_428_21 = utf8.len(var_428_19)
				local var_428_22 = var_428_20 <= 0 and var_428_16 or var_428_16 * (var_428_21 / var_428_20)

				if var_428_22 > 0 and var_428_16 < var_428_22 then
					arg_425_1.talkMaxDuration = var_428_22

					if var_428_22 + var_428_15 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_22 + var_428_15
					end
				end

				arg_425_1.text_.text = var_428_19
				arg_425_1.typewritter.percent = 0

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105102", "story_v_side_new_1101105.awb") ~= 0 then
					local var_428_23 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105102", "story_v_side_new_1101105.awb") / 1000

					if var_428_23 + var_428_15 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_23 + var_428_15
					end

					if var_428_18.prefab_name ~= "" and arg_425_1.actors_[var_428_18.prefab_name] ~= nil then
						local var_428_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_425_1.actors_[var_428_18.prefab_name].transform, "story_v_side_new_1101105", "1101105102", "story_v_side_new_1101105.awb")

						arg_425_1:RecordAudio("1101105102", var_428_24)
						arg_425_1:RecordAudio("1101105102", var_428_24)
					else
						arg_425_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105102", "story_v_side_new_1101105.awb")
					end

					arg_425_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105102", "story_v_side_new_1101105.awb")
				end

				arg_425_1:RecordContent(arg_425_1.text_.text)
			end

			local var_428_25 = math.max(var_428_16, arg_425_1.talkMaxDuration)

			if var_428_15 <= arg_425_1.time_ and arg_425_1.time_ < var_428_15 + var_428_25 then
				arg_425_1.typewritter.percent = (arg_425_1.time_ - var_428_15) / var_428_25

				arg_425_1.typewritter:SetDirty()
			end

			if arg_425_1.time_ >= var_428_15 + var_428_25 and arg_425_1.time_ < var_428_15 + var_428_25 + arg_428_0 then
				arg_425_1.typewritter.percent = 1

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(true)
			end
		end

		arg_425_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_425_1:InitPlayNodeList()
	end,
	Play1101105103 = function(arg_429_0, arg_429_1)
		arg_429_1.time_ = 0
		arg_429_1.frameCnt_ = 0
		arg_429_1.state_ = "playing"
		arg_429_1.curTalkId_ = 1101105103
		arg_429_1.duration_ = 5

		SetActive(arg_429_1.tipsGo_, false)

		function arg_429_1.onSingleLineFinish_()
			arg_429_1.onSingleLineUpdate_ = nil
			arg_429_1.onSingleLineFinish_ = nil
			arg_429_1.state_ = "waiting"
		end

		function arg_429_1.playNext_(arg_431_0)
			if arg_431_0 == 1 then
				arg_429_0:Play1101105104(arg_429_1)
			end
		end

		function arg_429_1.onSingleLineUpdate_(arg_432_0)
			local var_432_0 = arg_429_1.actors_["1011ui_story"]
			local var_432_1 = 0

			if var_432_1 < arg_429_1.time_ and arg_429_1.time_ <= var_432_1 + arg_432_0 and not isNil(var_432_0) and arg_429_1.var_.characterEffect1011ui_story == nil then
				arg_429_1.var_.characterEffect1011ui_story = var_432_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_432_2 = 0.200000002980232

			if var_432_1 <= arg_429_1.time_ and arg_429_1.time_ < var_432_1 + var_432_2 and not isNil(var_432_0) then
				local var_432_3 = (arg_429_1.time_ - var_432_1) / var_432_2

				if arg_429_1.var_.characterEffect1011ui_story and not isNil(var_432_0) then
					local var_432_4 = Mathf.Lerp(0, 0.5, var_432_3)

					arg_429_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_429_1.var_.characterEffect1011ui_story.fillRatio = var_432_4
				end
			end

			if arg_429_1.time_ >= var_432_1 + var_432_2 and arg_429_1.time_ < var_432_1 + var_432_2 + arg_432_0 and not isNil(var_432_0) and arg_429_1.var_.characterEffect1011ui_story then
				local var_432_5 = 0.5

				arg_429_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_429_1.var_.characterEffect1011ui_story.fillRatio = var_432_5
			end

			local var_432_6 = 0
			local var_432_7 = 1.125

			if var_432_6 < arg_429_1.time_ and arg_429_1.time_ <= var_432_6 + arg_432_0 then
				arg_429_1.talkMaxDuration = 0
				arg_429_1.dialogCg_.alpha = 1

				arg_429_1.dialog_:SetActive(true)
				SetActive(arg_429_1.leftNameGo_, false)

				arg_429_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_429_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_429_1:RecordName(arg_429_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_429_1.iconTrs_.gameObject, false)
				arg_429_1.callingController_:SetSelectedState("normal")

				local var_432_8 = arg_429_1:GetWordFromCfg(1101105103)
				local var_432_9 = arg_429_1:FormatText(var_432_8.content)

				arg_429_1.text_.text = var_432_9

				LuaForUtil.ClearLinePrefixSymbol(arg_429_1.text_)

				local var_432_10 = 45
				local var_432_11 = utf8.len(var_432_9)
				local var_432_12 = var_432_10 <= 0 and var_432_7 or var_432_7 * (var_432_11 / var_432_10)

				if var_432_12 > 0 and var_432_7 < var_432_12 then
					arg_429_1.talkMaxDuration = var_432_12

					if var_432_12 + var_432_6 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_12 + var_432_6
					end
				end

				arg_429_1.text_.text = var_432_9
				arg_429_1.typewritter.percent = 0

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(false)
				arg_429_1:RecordContent(arg_429_1.text_.text)
			end

			local var_432_13 = math.max(var_432_7, arg_429_1.talkMaxDuration)

			if var_432_6 <= arg_429_1.time_ and arg_429_1.time_ < var_432_6 + var_432_13 then
				arg_429_1.typewritter.percent = (arg_429_1.time_ - var_432_6) / var_432_13

				arg_429_1.typewritter:SetDirty()
			end

			if arg_429_1.time_ >= var_432_6 + var_432_13 and arg_429_1.time_ < var_432_6 + var_432_13 + arg_432_0 then
				arg_429_1.typewritter.percent = 1

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(true)
			end
		end

		arg_429_1.nodeConfigList_ = {}

		arg_429_1:InitPlayNodeList()
	end,
	Play1101105104 = function(arg_433_0, arg_433_1)
		arg_433_1.time_ = 0
		arg_433_1.frameCnt_ = 0
		arg_433_1.state_ = "playing"
		arg_433_1.curTalkId_ = 1101105104
		arg_433_1.duration_ = 5

		SetActive(arg_433_1.tipsGo_, false)

		function arg_433_1.onSingleLineFinish_()
			arg_433_1.onSingleLineUpdate_ = nil
			arg_433_1.onSingleLineFinish_ = nil
			arg_433_1.state_ = "waiting"
		end

		function arg_433_1.playNext_(arg_435_0)
			if arg_435_0 == 1 then
				arg_433_0:Play1101105105(arg_433_1)
			end
		end

		function arg_433_1.onSingleLineUpdate_(arg_436_0)
			local var_436_0 = 0
			local var_436_1 = 0.4

			if var_436_0 < arg_433_1.time_ and arg_433_1.time_ <= var_436_0 + arg_436_0 then
				arg_433_1.talkMaxDuration = 0
				arg_433_1.dialogCg_.alpha = 1

				arg_433_1.dialog_:SetActive(true)
				SetActive(arg_433_1.leftNameGo_, true)

				local var_436_2 = arg_433_1:FormatText(StoryNameCfg[7].name)

				arg_433_1.leftNameTxt_.text = var_436_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_433_1.leftNameTxt_.transform)

				arg_433_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_433_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_433_1:RecordName(arg_433_1.leftNameTxt_.text)
				SetActive(arg_433_1.iconTrs_.gameObject, true)
				arg_433_1.iconController_:SetSelectedState("hero")

				arg_433_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_433_1.callingController_:SetSelectedState("normal")

				arg_433_1.keyicon_.color = Color.New(1, 1, 1)
				arg_433_1.icon_.color = Color.New(1, 1, 1)

				local var_436_3 = arg_433_1:GetWordFromCfg(1101105104)
				local var_436_4 = arg_433_1:FormatText(var_436_3.content)

				arg_433_1.text_.text = var_436_4

				LuaForUtil.ClearLinePrefixSymbol(arg_433_1.text_)

				local var_436_5 = 16
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
				arg_433_1:RecordContent(arg_433_1.text_.text)
			end

			local var_436_8 = math.max(var_436_1, arg_433_1.talkMaxDuration)

			if var_436_0 <= arg_433_1.time_ and arg_433_1.time_ < var_436_0 + var_436_8 then
				arg_433_1.typewritter.percent = (arg_433_1.time_ - var_436_0) / var_436_8

				arg_433_1.typewritter:SetDirty()
			end

			if arg_433_1.time_ >= var_436_0 + var_436_8 and arg_433_1.time_ < var_436_0 + var_436_8 + arg_436_0 then
				arg_433_1.typewritter.percent = 1

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(true)
			end
		end

		arg_433_1.nodeConfigList_ = {}

		arg_433_1:InitPlayNodeList()
	end,
	Play1101105105 = function(arg_437_0, arg_437_1)
		arg_437_1.time_ = 0
		arg_437_1.frameCnt_ = 0
		arg_437_1.state_ = "playing"
		arg_437_1.curTalkId_ = 1101105105
		arg_437_1.duration_ = 2

		SetActive(arg_437_1.tipsGo_, false)

		function arg_437_1.onSingleLineFinish_()
			arg_437_1.onSingleLineUpdate_ = nil
			arg_437_1.onSingleLineFinish_ = nil
			arg_437_1.state_ = "waiting"
		end

		function arg_437_1.playNext_(arg_439_0)
			if arg_439_0 == 1 then
				arg_437_0:Play1101105106(arg_437_1)
			end
		end

		function arg_437_1.onSingleLineUpdate_(arg_440_0)
			local var_440_0 = arg_437_1.actors_["1011ui_story"].transform
			local var_440_1 = 0

			if var_440_1 < arg_437_1.time_ and arg_437_1.time_ <= var_440_1 + arg_440_0 then
				arg_437_1.var_.moveOldPos1011ui_story = var_440_0.localPosition
			end

			local var_440_2 = 0.001

			if var_440_1 <= arg_437_1.time_ and arg_437_1.time_ < var_440_1 + var_440_2 then
				local var_440_3 = (arg_437_1.time_ - var_440_1) / var_440_2
				local var_440_4 = Vector3.New(0, -0.71, -6)

				var_440_0.localPosition = Vector3.Lerp(arg_437_1.var_.moveOldPos1011ui_story, var_440_4, var_440_3)

				local var_440_5 = manager.ui.mainCamera.transform.position - var_440_0.position

				var_440_0.forward = Vector3.New(var_440_5.x, var_440_5.y, var_440_5.z)

				local var_440_6 = var_440_0.localEulerAngles

				var_440_6.z = 0
				var_440_6.x = 0
				var_440_0.localEulerAngles = var_440_6
			end

			if arg_437_1.time_ >= var_440_1 + var_440_2 and arg_437_1.time_ < var_440_1 + var_440_2 + arg_440_0 then
				var_440_0.localPosition = Vector3.New(0, -0.71, -6)

				local var_440_7 = manager.ui.mainCamera.transform.position - var_440_0.position

				var_440_0.forward = Vector3.New(var_440_7.x, var_440_7.y, var_440_7.z)

				local var_440_8 = var_440_0.localEulerAngles

				var_440_8.z = 0
				var_440_8.x = 0
				var_440_0.localEulerAngles = var_440_8
			end

			local var_440_9 = arg_437_1.actors_["1011ui_story"]
			local var_440_10 = 0

			if var_440_10 < arg_437_1.time_ and arg_437_1.time_ <= var_440_10 + arg_440_0 and not isNil(var_440_9) and arg_437_1.var_.characterEffect1011ui_story == nil then
				arg_437_1.var_.characterEffect1011ui_story = var_440_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_440_11 = 0.200000002980232

			if var_440_10 <= arg_437_1.time_ and arg_437_1.time_ < var_440_10 + var_440_11 and not isNil(var_440_9) then
				local var_440_12 = (arg_437_1.time_ - var_440_10) / var_440_11

				if arg_437_1.var_.characterEffect1011ui_story and not isNil(var_440_9) then
					arg_437_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_437_1.time_ >= var_440_10 + var_440_11 and arg_437_1.time_ < var_440_10 + var_440_11 + arg_440_0 and not isNil(var_440_9) and arg_437_1.var_.characterEffect1011ui_story then
				arg_437_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_440_13 = 0

			if var_440_13 < arg_437_1.time_ and arg_437_1.time_ <= var_440_13 + arg_440_0 then
				arg_437_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action1_1")
			end

			local var_440_14 = 0

			if var_440_14 < arg_437_1.time_ and arg_437_1.time_ <= var_440_14 + arg_440_0 then
				arg_437_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_440_15 = 0
			local var_440_16 = 0.05

			if var_440_15 < arg_437_1.time_ and arg_437_1.time_ <= var_440_15 + arg_440_0 then
				arg_437_1.talkMaxDuration = 0
				arg_437_1.dialogCg_.alpha = 1

				arg_437_1.dialog_:SetActive(true)
				SetActive(arg_437_1.leftNameGo_, true)

				local var_440_17 = arg_437_1:FormatText(StoryNameCfg[37].name)

				arg_437_1.leftNameTxt_.text = var_440_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_437_1.leftNameTxt_.transform)

				arg_437_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_437_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_437_1:RecordName(arg_437_1.leftNameTxt_.text)
				SetActive(arg_437_1.iconTrs_.gameObject, false)
				arg_437_1.callingController_:SetSelectedState("normal")

				local var_440_18 = arg_437_1:GetWordFromCfg(1101105105)
				local var_440_19 = arg_437_1:FormatText(var_440_18.content)

				arg_437_1.text_.text = var_440_19

				LuaForUtil.ClearLinePrefixSymbol(arg_437_1.text_)

				local var_440_20 = 2
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

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105105", "story_v_side_new_1101105.awb") ~= 0 then
					local var_440_23 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105105", "story_v_side_new_1101105.awb") / 1000

					if var_440_23 + var_440_15 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_23 + var_440_15
					end

					if var_440_18.prefab_name ~= "" and arg_437_1.actors_[var_440_18.prefab_name] ~= nil then
						local var_440_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_437_1.actors_[var_440_18.prefab_name].transform, "story_v_side_new_1101105", "1101105105", "story_v_side_new_1101105.awb")

						arg_437_1:RecordAudio("1101105105", var_440_24)
						arg_437_1:RecordAudio("1101105105", var_440_24)
					else
						arg_437_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105105", "story_v_side_new_1101105.awb")
					end

					arg_437_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105105", "story_v_side_new_1101105.awb")
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
				actorName = "1011ui_story",
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
	Play1101105106 = function(arg_441_0, arg_441_1)
		arg_441_1.time_ = 0
		arg_441_1.frameCnt_ = 0
		arg_441_1.state_ = "playing"
		arg_441_1.curTalkId_ = 1101105106
		arg_441_1.duration_ = 5

		SetActive(arg_441_1.tipsGo_, false)

		function arg_441_1.onSingleLineFinish_()
			arg_441_1.onSingleLineUpdate_ = nil
			arg_441_1.onSingleLineFinish_ = nil
			arg_441_1.state_ = "waiting"
		end

		function arg_441_1.playNext_(arg_443_0)
			if arg_443_0 == 1 then
				arg_441_0:Play1101105107(arg_441_1)
			end
		end

		function arg_441_1.onSingleLineUpdate_(arg_444_0)
			local var_444_0 = arg_441_1.actors_["1011ui_story"]
			local var_444_1 = 0

			if var_444_1 < arg_441_1.time_ and arg_441_1.time_ <= var_444_1 + arg_444_0 and not isNil(var_444_0) and arg_441_1.var_.characterEffect1011ui_story == nil then
				arg_441_1.var_.characterEffect1011ui_story = var_444_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_444_2 = 0.200000002980232

			if var_444_1 <= arg_441_1.time_ and arg_441_1.time_ < var_444_1 + var_444_2 and not isNil(var_444_0) then
				local var_444_3 = (arg_441_1.time_ - var_444_1) / var_444_2

				if arg_441_1.var_.characterEffect1011ui_story and not isNil(var_444_0) then
					local var_444_4 = Mathf.Lerp(0, 0.5, var_444_3)

					arg_441_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_441_1.var_.characterEffect1011ui_story.fillRatio = var_444_4
				end
			end

			if arg_441_1.time_ >= var_444_1 + var_444_2 and arg_441_1.time_ < var_444_1 + var_444_2 + arg_444_0 and not isNil(var_444_0) and arg_441_1.var_.characterEffect1011ui_story then
				local var_444_5 = 0.5

				arg_441_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_441_1.var_.characterEffect1011ui_story.fillRatio = var_444_5
			end

			local var_444_6 = 0
			local var_444_7 = 0.45

			if var_444_6 < arg_441_1.time_ and arg_441_1.time_ <= var_444_6 + arg_444_0 then
				arg_441_1.talkMaxDuration = 0
				arg_441_1.dialogCg_.alpha = 1

				arg_441_1.dialog_:SetActive(true)
				SetActive(arg_441_1.leftNameGo_, false)

				arg_441_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_441_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_441_1:RecordName(arg_441_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_441_1.iconTrs_.gameObject, false)
				arg_441_1.callingController_:SetSelectedState("normal")

				local var_444_8 = arg_441_1:GetWordFromCfg(1101105106)
				local var_444_9 = arg_441_1:FormatText(var_444_8.content)

				arg_441_1.text_.text = var_444_9

				LuaForUtil.ClearLinePrefixSymbol(arg_441_1.text_)

				local var_444_10 = 18
				local var_444_11 = utf8.len(var_444_9)
				local var_444_12 = var_444_10 <= 0 and var_444_7 or var_444_7 * (var_444_11 / var_444_10)

				if var_444_12 > 0 and var_444_7 < var_444_12 then
					arg_441_1.talkMaxDuration = var_444_12

					if var_444_12 + var_444_6 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_12 + var_444_6
					end
				end

				arg_441_1.text_.text = var_444_9
				arg_441_1.typewritter.percent = 0

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(false)
				arg_441_1:RecordContent(arg_441_1.text_.text)
			end

			local var_444_13 = math.max(var_444_7, arg_441_1.talkMaxDuration)

			if var_444_6 <= arg_441_1.time_ and arg_441_1.time_ < var_444_6 + var_444_13 then
				arg_441_1.typewritter.percent = (arg_441_1.time_ - var_444_6) / var_444_13

				arg_441_1.typewritter:SetDirty()
			end

			if arg_441_1.time_ >= var_444_6 + var_444_13 and arg_441_1.time_ < var_444_6 + var_444_13 + arg_444_0 then
				arg_441_1.typewritter.percent = 1

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(true)
			end
		end

		arg_441_1.nodeConfigList_ = {}

		arg_441_1:InitPlayNodeList()
	end,
	Play1101105107 = function(arg_445_0, arg_445_1)
		arg_445_1.time_ = 0
		arg_445_1.frameCnt_ = 0
		arg_445_1.state_ = "playing"
		arg_445_1.curTalkId_ = 1101105107
		arg_445_1.duration_ = 5

		SetActive(arg_445_1.tipsGo_, false)

		function arg_445_1.onSingleLineFinish_()
			arg_445_1.onSingleLineUpdate_ = nil
			arg_445_1.onSingleLineFinish_ = nil
			arg_445_1.state_ = "waiting"
		end

		function arg_445_1.playNext_(arg_447_0)
			if arg_447_0 == 1 then
				arg_445_0:Play1101105108(arg_445_1)
			end
		end

		function arg_445_1.onSingleLineUpdate_(arg_448_0)
			local var_448_0 = 0
			local var_448_1 = 1.025

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

				local var_448_2 = arg_445_1:GetWordFromCfg(1101105107)
				local var_448_3 = arg_445_1:FormatText(var_448_2.content)

				arg_445_1.text_.text = var_448_3

				LuaForUtil.ClearLinePrefixSymbol(arg_445_1.text_)

				local var_448_4 = 41
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
	Play1101105108 = function(arg_449_0, arg_449_1)
		arg_449_1.time_ = 0
		arg_449_1.frameCnt_ = 0
		arg_449_1.state_ = "playing"
		arg_449_1.curTalkId_ = 1101105108
		arg_449_1.duration_ = 3.03

		local var_449_0 = {
			zh = 3.033,
			ja = 2.8
		}
		local var_449_1 = manager.audio:GetLocalizationFlag()

		if var_449_0[var_449_1] ~= nil then
			arg_449_1.duration_ = var_449_0[var_449_1]
		end

		SetActive(arg_449_1.tipsGo_, false)

		function arg_449_1.onSingleLineFinish_()
			arg_449_1.onSingleLineUpdate_ = nil
			arg_449_1.onSingleLineFinish_ = nil
			arg_449_1.state_ = "waiting"
		end

		function arg_449_1.playNext_(arg_451_0)
			if arg_451_0 == 1 then
				arg_449_0:Play1101105109(arg_449_1)
			end
		end

		function arg_449_1.onSingleLineUpdate_(arg_452_0)
			local var_452_0 = arg_449_1.actors_["1011ui_story"].transform
			local var_452_1 = 0

			if var_452_1 < arg_449_1.time_ and arg_449_1.time_ <= var_452_1 + arg_452_0 then
				arg_449_1.var_.moveOldPos1011ui_story = var_452_0.localPosition
			end

			local var_452_2 = 0.001

			if var_452_1 <= arg_449_1.time_ and arg_449_1.time_ < var_452_1 + var_452_2 then
				local var_452_3 = (arg_449_1.time_ - var_452_1) / var_452_2
				local var_452_4 = Vector3.New(0, -0.71, -6)

				var_452_0.localPosition = Vector3.Lerp(arg_449_1.var_.moveOldPos1011ui_story, var_452_4, var_452_3)

				local var_452_5 = manager.ui.mainCamera.transform.position - var_452_0.position

				var_452_0.forward = Vector3.New(var_452_5.x, var_452_5.y, var_452_5.z)

				local var_452_6 = var_452_0.localEulerAngles

				var_452_6.z = 0
				var_452_6.x = 0
				var_452_0.localEulerAngles = var_452_6
			end

			if arg_449_1.time_ >= var_452_1 + var_452_2 and arg_449_1.time_ < var_452_1 + var_452_2 + arg_452_0 then
				var_452_0.localPosition = Vector3.New(0, -0.71, -6)

				local var_452_7 = manager.ui.mainCamera.transform.position - var_452_0.position

				var_452_0.forward = Vector3.New(var_452_7.x, var_452_7.y, var_452_7.z)

				local var_452_8 = var_452_0.localEulerAngles

				var_452_8.z = 0
				var_452_8.x = 0
				var_452_0.localEulerAngles = var_452_8
			end

			local var_452_9 = arg_449_1.actors_["1011ui_story"]
			local var_452_10 = 0

			if var_452_10 < arg_449_1.time_ and arg_449_1.time_ <= var_452_10 + arg_452_0 and not isNil(var_452_9) and arg_449_1.var_.characterEffect1011ui_story == nil then
				arg_449_1.var_.characterEffect1011ui_story = var_452_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_452_11 = 0.200000002980232

			if var_452_10 <= arg_449_1.time_ and arg_449_1.time_ < var_452_10 + var_452_11 and not isNil(var_452_9) then
				local var_452_12 = (arg_449_1.time_ - var_452_10) / var_452_11

				if arg_449_1.var_.characterEffect1011ui_story and not isNil(var_452_9) then
					arg_449_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_449_1.time_ >= var_452_10 + var_452_11 and arg_449_1.time_ < var_452_10 + var_452_11 + arg_452_0 and not isNil(var_452_9) and arg_449_1.var_.characterEffect1011ui_story then
				arg_449_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_452_13 = 0

			if var_452_13 < arg_449_1.time_ and arg_449_1.time_ <= var_452_13 + arg_452_0 then
				arg_449_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action5_1")
			end

			local var_452_14 = 0

			if var_452_14 < arg_449_1.time_ and arg_449_1.time_ <= var_452_14 + arg_452_0 then
				arg_449_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_452_15 = 0
			local var_452_16 = 0.325

			if var_452_15 < arg_449_1.time_ and arg_449_1.time_ <= var_452_15 + arg_452_0 then
				arg_449_1.talkMaxDuration = 0
				arg_449_1.dialogCg_.alpha = 1

				arg_449_1.dialog_:SetActive(true)
				SetActive(arg_449_1.leftNameGo_, true)

				local var_452_17 = arg_449_1:FormatText(StoryNameCfg[37].name)

				arg_449_1.leftNameTxt_.text = var_452_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_449_1.leftNameTxt_.transform)

				arg_449_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_449_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_449_1:RecordName(arg_449_1.leftNameTxt_.text)
				SetActive(arg_449_1.iconTrs_.gameObject, false)
				arg_449_1.callingController_:SetSelectedState("normal")

				local var_452_18 = arg_449_1:GetWordFromCfg(1101105108)
				local var_452_19 = arg_449_1:FormatText(var_452_18.content)

				arg_449_1.text_.text = var_452_19

				LuaForUtil.ClearLinePrefixSymbol(arg_449_1.text_)

				local var_452_20 = 13
				local var_452_21 = utf8.len(var_452_19)
				local var_452_22 = var_452_20 <= 0 and var_452_16 or var_452_16 * (var_452_21 / var_452_20)

				if var_452_22 > 0 and var_452_16 < var_452_22 then
					arg_449_1.talkMaxDuration = var_452_22

					if var_452_22 + var_452_15 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_22 + var_452_15
					end
				end

				arg_449_1.text_.text = var_452_19
				arg_449_1.typewritter.percent = 0

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105108", "story_v_side_new_1101105.awb") ~= 0 then
					local var_452_23 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105108", "story_v_side_new_1101105.awb") / 1000

					if var_452_23 + var_452_15 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_23 + var_452_15
					end

					if var_452_18.prefab_name ~= "" and arg_449_1.actors_[var_452_18.prefab_name] ~= nil then
						local var_452_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_449_1.actors_[var_452_18.prefab_name].transform, "story_v_side_new_1101105", "1101105108", "story_v_side_new_1101105.awb")

						arg_449_1:RecordAudio("1101105108", var_452_24)
						arg_449_1:RecordAudio("1101105108", var_452_24)
					else
						arg_449_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105108", "story_v_side_new_1101105.awb")
					end

					arg_449_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105108", "story_v_side_new_1101105.awb")
				end

				arg_449_1:RecordContent(arg_449_1.text_.text)
			end

			local var_452_25 = math.max(var_452_16, arg_449_1.talkMaxDuration)

			if var_452_15 <= arg_449_1.time_ and arg_449_1.time_ < var_452_15 + var_452_25 then
				arg_449_1.typewritter.percent = (arg_449_1.time_ - var_452_15) / var_452_25

				arg_449_1.typewritter:SetDirty()
			end

			if arg_449_1.time_ >= var_452_15 + var_452_25 and arg_449_1.time_ < var_452_15 + var_452_25 + arg_452_0 then
				arg_449_1.typewritter.percent = 1

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(true)
			end
		end

		arg_449_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_449_1:InitPlayNodeList()
	end,
	Play1101105109 = function(arg_453_0, arg_453_1)
		arg_453_1.time_ = 0
		arg_453_1.frameCnt_ = 0
		arg_453_1.state_ = "playing"
		arg_453_1.curTalkId_ = 1101105109
		arg_453_1.duration_ = 5

		SetActive(arg_453_1.tipsGo_, false)

		function arg_453_1.onSingleLineFinish_()
			arg_453_1.onSingleLineUpdate_ = nil
			arg_453_1.onSingleLineFinish_ = nil
			arg_453_1.state_ = "waiting"
		end

		function arg_453_1.playNext_(arg_455_0)
			if arg_455_0 == 1 then
				arg_453_0:Play1101105110(arg_453_1)
			end
		end

		function arg_453_1.onSingleLineUpdate_(arg_456_0)
			local var_456_0 = arg_453_1.actors_["1011ui_story"].transform
			local var_456_1 = 0

			if var_456_1 < arg_453_1.time_ and arg_453_1.time_ <= var_456_1 + arg_456_0 then
				arg_453_1.var_.moveOldPos1011ui_story = var_456_0.localPosition
			end

			local var_456_2 = 0.001

			if var_456_1 <= arg_453_1.time_ and arg_453_1.time_ < var_456_1 + var_456_2 then
				local var_456_3 = (arg_453_1.time_ - var_456_1) / var_456_2
				local var_456_4 = Vector3.New(0, 100, 0)

				var_456_0.localPosition = Vector3.Lerp(arg_453_1.var_.moveOldPos1011ui_story, var_456_4, var_456_3)

				local var_456_5 = manager.ui.mainCamera.transform.position - var_456_0.position

				var_456_0.forward = Vector3.New(var_456_5.x, var_456_5.y, var_456_5.z)

				local var_456_6 = var_456_0.localEulerAngles

				var_456_6.z = 0
				var_456_6.x = 0
				var_456_0.localEulerAngles = var_456_6
			end

			if arg_453_1.time_ >= var_456_1 + var_456_2 and arg_453_1.time_ < var_456_1 + var_456_2 + arg_456_0 then
				var_456_0.localPosition = Vector3.New(0, 100, 0)

				local var_456_7 = manager.ui.mainCamera.transform.position - var_456_0.position

				var_456_0.forward = Vector3.New(var_456_7.x, var_456_7.y, var_456_7.z)

				local var_456_8 = var_456_0.localEulerAngles

				var_456_8.z = 0
				var_456_8.x = 0
				var_456_0.localEulerAngles = var_456_8
			end

			local var_456_9 = arg_453_1.actors_["1011ui_story"]
			local var_456_10 = 0

			if var_456_10 < arg_453_1.time_ and arg_453_1.time_ <= var_456_10 + arg_456_0 and not isNil(var_456_9) and arg_453_1.var_.characterEffect1011ui_story == nil then
				arg_453_1.var_.characterEffect1011ui_story = var_456_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_456_11 = 0.200000002980232

			if var_456_10 <= arg_453_1.time_ and arg_453_1.time_ < var_456_10 + var_456_11 and not isNil(var_456_9) then
				local var_456_12 = (arg_453_1.time_ - var_456_10) / var_456_11

				if arg_453_1.var_.characterEffect1011ui_story and not isNil(var_456_9) then
					local var_456_13 = Mathf.Lerp(0, 0.5, var_456_12)

					arg_453_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_453_1.var_.characterEffect1011ui_story.fillRatio = var_456_13
				end
			end

			if arg_453_1.time_ >= var_456_10 + var_456_11 and arg_453_1.time_ < var_456_10 + var_456_11 + arg_456_0 and not isNil(var_456_9) and arg_453_1.var_.characterEffect1011ui_story then
				local var_456_14 = 0.5

				arg_453_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_453_1.var_.characterEffect1011ui_story.fillRatio = var_456_14
			end

			local var_456_15 = 0
			local var_456_16 = 1.225

			if var_456_15 < arg_453_1.time_ and arg_453_1.time_ <= var_456_15 + arg_456_0 then
				arg_453_1.talkMaxDuration = 0
				arg_453_1.dialogCg_.alpha = 1

				arg_453_1.dialog_:SetActive(true)
				SetActive(arg_453_1.leftNameGo_, false)

				arg_453_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_453_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_453_1:RecordName(arg_453_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_453_1.iconTrs_.gameObject, false)
				arg_453_1.callingController_:SetSelectedState("normal")

				local var_456_17 = arg_453_1:GetWordFromCfg(1101105109)
				local var_456_18 = arg_453_1:FormatText(var_456_17.content)

				arg_453_1.text_.text = var_456_18

				LuaForUtil.ClearLinePrefixSymbol(arg_453_1.text_)

				local var_456_19 = 49
				local var_456_20 = utf8.len(var_456_18)
				local var_456_21 = var_456_19 <= 0 and var_456_16 or var_456_16 * (var_456_20 / var_456_19)

				if var_456_21 > 0 and var_456_16 < var_456_21 then
					arg_453_1.talkMaxDuration = var_456_21

					if var_456_21 + var_456_15 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_21 + var_456_15
					end
				end

				arg_453_1.text_.text = var_456_18
				arg_453_1.typewritter.percent = 0

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(false)
				arg_453_1:RecordContent(arg_453_1.text_.text)
			end

			local var_456_22 = math.max(var_456_16, arg_453_1.talkMaxDuration)

			if var_456_15 <= arg_453_1.time_ and arg_453_1.time_ < var_456_15 + var_456_22 then
				arg_453_1.typewritter.percent = (arg_453_1.time_ - var_456_15) / var_456_22

				arg_453_1.typewritter:SetDirty()
			end

			if arg_453_1.time_ >= var_456_15 + var_456_22 and arg_453_1.time_ < var_456_15 + var_456_22 + arg_456_0 then
				arg_453_1.typewritter.percent = 1

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(true)
			end
		end

		arg_453_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
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
	Play1101105110 = function(arg_457_0, arg_457_1)
		arg_457_1.time_ = 0
		arg_457_1.frameCnt_ = 0
		arg_457_1.state_ = "playing"
		arg_457_1.curTalkId_ = 1101105110
		arg_457_1.duration_ = 8.23

		SetActive(arg_457_1.tipsGo_, false)

		function arg_457_1.onSingleLineFinish_()
			arg_457_1.onSingleLineUpdate_ = nil
			arg_457_1.onSingleLineFinish_ = nil
			arg_457_1.state_ = "waiting"
		end

		function arg_457_1.playNext_(arg_459_0)
			if arg_459_0 == 1 then
				arg_457_0:Play1101105111(arg_457_1)
			end
		end

		function arg_457_1.onSingleLineUpdate_(arg_460_0)
			local var_460_0 = 0

			if var_460_0 < arg_457_1.time_ and arg_457_1.time_ <= var_460_0 + arg_460_0 then
				arg_457_1.fswbg_:SetActive(true)
				arg_457_1.dialog_:SetActive(false)

				arg_457_1.fswtw_.percent = 0

				local var_460_1 = arg_457_1:GetWordFromCfg(1101105110)
				local var_460_2 = arg_457_1:FormatText(var_460_1.content)

				arg_457_1.fswt_.text = var_460_2

				LuaForUtil.ClearLinePrefixSymbol(arg_457_1.fswt_)

				arg_457_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_457_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_457_1.fswtw_:SetDirty()

				arg_457_1.typewritterCharCountI18N = 0

				SetActive(arg_457_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_457_1:ShowNextGo(false)
			end

			local var_460_3 = 0.0166666666666667

			if var_460_3 < arg_457_1.time_ and arg_457_1.time_ <= var_460_3 + arg_460_0 then
				arg_457_1.var_.oldValueTypewriter = arg_457_1.fswtw_.percent

				SetActive(arg_457_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_457_1:ShowNextGo(false)
			end

			local var_460_4 = 37
			local var_460_5 = 2.46666666666667
			local var_460_6 = arg_457_1:GetWordFromCfg(1101105110)
			local var_460_7 = arg_457_1:FormatText(var_460_6.content)
			local var_460_8, var_460_9 = arg_457_1:GetPercentByPara(var_460_7, 1)

			if var_460_3 < arg_457_1.time_ and arg_457_1.time_ <= var_460_3 + arg_460_0 then
				arg_457_1.talkMaxDuration = 0

				local var_460_10 = var_460_4 <= 0 and var_460_5 or var_460_5 * ((var_460_9 - arg_457_1.typewritterCharCountI18N) / var_460_4)

				if var_460_10 > 0 and var_460_5 < var_460_10 then
					arg_457_1.talkMaxDuration = var_460_10

					if var_460_10 + var_460_3 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_10 + var_460_3
					end
				end
			end

			local var_460_11 = 2.46666666666667
			local var_460_12 = math.max(var_460_11, arg_457_1.talkMaxDuration)

			if var_460_3 <= arg_457_1.time_ and arg_457_1.time_ < var_460_3 + var_460_12 then
				local var_460_13 = (arg_457_1.time_ - var_460_3) / var_460_12

				arg_457_1.fswtw_.percent = Mathf.Lerp(arg_457_1.var_.oldValueTypewriter, var_460_8, var_460_13)
				arg_457_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_457_1.fswtw_:SetDirty()
			end

			if arg_457_1.time_ >= var_460_3 + var_460_12 and arg_457_1.time_ < var_460_3 + var_460_12 + arg_460_0 then
				arg_457_1.fswtw_.percent = var_460_8

				arg_457_1.fswtw_:SetDirty()
				arg_457_1:ShowNextGo(true)

				arg_457_1.typewritterCharCountI18N = var_460_9
			end

			local var_460_14 = 0

			if var_460_14 < arg_457_1.time_ and arg_457_1.time_ <= var_460_14 + arg_460_0 then
				local var_460_15 = arg_457_1.fswbg_.transform:Find("textbox/adapt/content") or arg_457_1.fswbg_.transform:Find("textbox/content")
				local var_460_16 = arg_457_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_460_17 = var_460_15:GetComponent("Text")
				local var_460_18 = var_460_15:GetComponent("RectTransform")

				var_460_17.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_460_18.offsetMin = Vector2.New(0, 0)
				var_460_18.offsetMax = Vector2.New(0, 0)
			end

			local var_460_19 = 0
			local var_460_20 = 8.233
			local var_460_21 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105110", "story_v_side_new_1101105.awb") / 1000

			if var_460_21 > 0 and var_460_20 < var_460_21 and var_460_21 + var_460_19 > arg_457_1.duration_ then
				local var_460_22 = var_460_21

				arg_457_1.duration_ = var_460_21 + var_460_19
			end

			if var_460_19 < arg_457_1.time_ and arg_457_1.time_ <= var_460_19 + arg_460_0 then
				local var_460_23 = "play"
				local var_460_24 = "voice"

				arg_457_1:AudioAction(var_460_23, var_460_24, "story_v_side_new_1101105", "1101105110", "story_v_side_new_1101105.awb")
			end
		end

		arg_457_1.nodeConfigList_ = {}

		arg_457_1:InitPlayNodeList()
	end,
	Play1101105111 = function(arg_461_0, arg_461_1)
		arg_461_1.time_ = 0
		arg_461_1.frameCnt_ = 0
		arg_461_1.state_ = "playing"
		arg_461_1.curTalkId_ = 1101105111
		arg_461_1.duration_ = 4.2

		SetActive(arg_461_1.tipsGo_, false)

		function arg_461_1.onSingleLineFinish_()
			arg_461_1.onSingleLineUpdate_ = nil
			arg_461_1.onSingleLineFinish_ = nil
			arg_461_1.state_ = "waiting"
		end

		function arg_461_1.playNext_(arg_463_0)
			if arg_463_0 == 1 then
				arg_461_0:Play1101105112(arg_461_1)
			end
		end

		function arg_461_1.onSingleLineUpdate_(arg_464_0)
			local var_464_0 = 0

			if var_464_0 < arg_461_1.time_ and arg_461_1.time_ <= var_464_0 + arg_464_0 then
				arg_461_1.var_.oldValueTypewriter = arg_461_1.fswtw_.percent

				SetActive(arg_461_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_461_1:ShowNextGo(false)
			end

			local var_464_1 = 23
			local var_464_2 = 1.53333333333333
			local var_464_3 = arg_461_1:GetWordFromCfg(1101105110)
			local var_464_4 = arg_461_1:FormatText(var_464_3.content)
			local var_464_5, var_464_6 = arg_461_1:GetPercentByPara(var_464_4, 2)

			if var_464_0 < arg_461_1.time_ and arg_461_1.time_ <= var_464_0 + arg_464_0 then
				arg_461_1.talkMaxDuration = 0

				local var_464_7 = var_464_1 <= 0 and var_464_2 or var_464_2 * ((var_464_6 - arg_461_1.typewritterCharCountI18N) / var_464_1)

				if var_464_7 > 0 and var_464_2 < var_464_7 then
					arg_461_1.talkMaxDuration = var_464_7

					if var_464_7 + var_464_0 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_7 + var_464_0
					end
				end
			end

			local var_464_8 = 1.53333333333333
			local var_464_9 = math.max(var_464_8, arg_461_1.talkMaxDuration)

			if var_464_0 <= arg_461_1.time_ and arg_461_1.time_ < var_464_0 + var_464_9 then
				local var_464_10 = (arg_461_1.time_ - var_464_0) / var_464_9

				arg_461_1.fswtw_.percent = Mathf.Lerp(arg_461_1.var_.oldValueTypewriter, var_464_5, var_464_10)
				arg_461_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_461_1.fswtw_:SetDirty()
			end

			if arg_461_1.time_ >= var_464_0 + var_464_9 and arg_461_1.time_ < var_464_0 + var_464_9 + arg_464_0 then
				arg_461_1.fswtw_.percent = var_464_5

				arg_461_1.fswtw_:SetDirty()
				arg_461_1:ShowNextGo(true)

				arg_461_1.typewritterCharCountI18N = var_464_6
			end

			local var_464_11 = 0
			local var_464_12 = 4.2
			local var_464_13 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105111", "story_v_side_new_1101105.awb") / 1000

			if var_464_13 > 0 and var_464_12 < var_464_13 and var_464_13 + var_464_11 > arg_461_1.duration_ then
				local var_464_14 = var_464_13

				arg_461_1.duration_ = var_464_13 + var_464_11
			end

			if var_464_11 < arg_461_1.time_ and arg_461_1.time_ <= var_464_11 + arg_464_0 then
				local var_464_15 = "play"
				local var_464_16 = "voice"

				arg_461_1:AudioAction(var_464_15, var_464_16, "story_v_side_new_1101105", "1101105111", "story_v_side_new_1101105.awb")
			end
		end

		arg_461_1.nodeConfigList_ = {}

		arg_461_1:InitPlayNodeList()
	end,
	Play1101105112 = function(arg_465_0, arg_465_1)
		arg_465_1.time_ = 0
		arg_465_1.frameCnt_ = 0
		arg_465_1.state_ = "playing"
		arg_465_1.curTalkId_ = 1101105112
		arg_465_1.duration_ = 8.2

		SetActive(arg_465_1.tipsGo_, false)

		function arg_465_1.onSingleLineFinish_()
			arg_465_1.onSingleLineUpdate_ = nil
			arg_465_1.onSingleLineFinish_ = nil
			arg_465_1.state_ = "waiting"
		end

		function arg_465_1.playNext_(arg_467_0)
			if arg_467_0 == 1 then
				arg_465_0:Play1101105113(arg_465_1)
			end
		end

		function arg_465_1.onSingleLineUpdate_(arg_468_0)
			local var_468_0 = 0

			if var_468_0 < arg_465_1.time_ and arg_465_1.time_ <= var_468_0 + arg_468_0 then
				arg_465_1.var_.oldValueTypewriter = arg_465_1.fswtw_.percent

				SetActive(arg_465_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_465_1:ShowNextGo(false)
			end

			local var_468_1 = 40
			local var_468_2 = 2.66666666666667
			local var_468_3 = arg_465_1:GetWordFromCfg(1101105110)
			local var_468_4 = arg_465_1:FormatText(var_468_3.content)
			local var_468_5, var_468_6 = arg_465_1:GetPercentByPara(var_468_4, 3)

			if var_468_0 < arg_465_1.time_ and arg_465_1.time_ <= var_468_0 + arg_468_0 then
				arg_465_1.talkMaxDuration = 0

				local var_468_7 = var_468_1 <= 0 and var_468_2 or var_468_2 * ((var_468_6 - arg_465_1.typewritterCharCountI18N) / var_468_1)

				if var_468_7 > 0 and var_468_2 < var_468_7 then
					arg_465_1.talkMaxDuration = var_468_7

					if var_468_7 + var_468_0 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_7 + var_468_0
					end
				end
			end

			local var_468_8 = 2.66666666666667
			local var_468_9 = math.max(var_468_8, arg_465_1.talkMaxDuration)

			if var_468_0 <= arg_465_1.time_ and arg_465_1.time_ < var_468_0 + var_468_9 then
				local var_468_10 = (arg_465_1.time_ - var_468_0) / var_468_9

				arg_465_1.fswtw_.percent = Mathf.Lerp(arg_465_1.var_.oldValueTypewriter, var_468_5, var_468_10)
				arg_465_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_465_1.fswtw_:SetDirty()
			end

			if arg_465_1.time_ >= var_468_0 + var_468_9 and arg_465_1.time_ < var_468_0 + var_468_9 + arg_468_0 then
				arg_465_1.fswtw_.percent = var_468_5

				arg_465_1.fswtw_:SetDirty()
				arg_465_1:ShowNextGo(true)

				arg_465_1.typewritterCharCountI18N = var_468_6
			end

			local var_468_11 = 0
			local var_468_12 = 8.2
			local var_468_13 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105112", "story_v_side_new_1101105.awb") / 1000

			if var_468_13 > 0 and var_468_12 < var_468_13 and var_468_13 + var_468_11 > arg_465_1.duration_ then
				local var_468_14 = var_468_13

				arg_465_1.duration_ = var_468_13 + var_468_11
			end

			if var_468_11 < arg_465_1.time_ and arg_465_1.time_ <= var_468_11 + arg_468_0 then
				local var_468_15 = "play"
				local var_468_16 = "voice"

				arg_465_1:AudioAction(var_468_15, var_468_16, "story_v_side_new_1101105", "1101105112", "story_v_side_new_1101105.awb")
			end
		end

		arg_465_1.nodeConfigList_ = {}

		arg_465_1:InitPlayNodeList()
	end,
	Play1101105113 = function(arg_469_0, arg_469_1)
		arg_469_1.time_ = 0
		arg_469_1.frameCnt_ = 0
		arg_469_1.state_ = "playing"
		arg_469_1.curTalkId_ = 1101105113
		arg_469_1.duration_ = 5

		SetActive(arg_469_1.tipsGo_, false)

		function arg_469_1.onSingleLineFinish_()
			arg_469_1.onSingleLineUpdate_ = nil
			arg_469_1.onSingleLineFinish_ = nil
			arg_469_1.state_ = "waiting"
		end

		function arg_469_1.playNext_(arg_471_0)
			if arg_471_0 == 1 then
				arg_469_0:Play1101105114(arg_469_1)
			end
		end

		function arg_469_1.onSingleLineUpdate_(arg_472_0)
			local var_472_0 = 0

			if var_472_0 < arg_469_1.time_ and arg_469_1.time_ <= var_472_0 + arg_472_0 then
				arg_469_1.fswbg_:SetActive(false)
				arg_469_1.dialog_:SetActive(true)
				SetActive(arg_469_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_469_1:ShowNextGo(false)
			end

			local var_472_1 = 0
			local var_472_2 = 0.05

			if var_472_1 < arg_469_1.time_ and arg_469_1.time_ <= var_472_1 + arg_472_0 then
				arg_469_1.talkMaxDuration = 0
				arg_469_1.dialogCg_.alpha = 1

				arg_469_1.dialog_:SetActive(true)
				SetActive(arg_469_1.leftNameGo_, false)

				arg_469_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_469_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_469_1:RecordName(arg_469_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_469_1.iconTrs_.gameObject, false)
				arg_469_1.callingController_:SetSelectedState("normal")

				local var_472_3 = arg_469_1:GetWordFromCfg(1101105113)
				local var_472_4 = arg_469_1:FormatText(var_472_3.content)

				arg_469_1.text_.text = var_472_4

				LuaForUtil.ClearLinePrefixSymbol(arg_469_1.text_)

				local var_472_5 = 2
				local var_472_6 = utf8.len(var_472_4)
				local var_472_7 = var_472_5 <= 0 and var_472_2 or var_472_2 * (var_472_6 / var_472_5)

				if var_472_7 > 0 and var_472_2 < var_472_7 then
					arg_469_1.talkMaxDuration = var_472_7

					if var_472_7 + var_472_1 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_7 + var_472_1
					end
				end

				arg_469_1.text_.text = var_472_4
				arg_469_1.typewritter.percent = 0

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(false)
				arg_469_1:RecordContent(arg_469_1.text_.text)
			end

			local var_472_8 = math.max(var_472_2, arg_469_1.talkMaxDuration)

			if var_472_1 <= arg_469_1.time_ and arg_469_1.time_ < var_472_1 + var_472_8 then
				arg_469_1.typewritter.percent = (arg_469_1.time_ - var_472_1) / var_472_8

				arg_469_1.typewritter:SetDirty()
			end

			if arg_469_1.time_ >= var_472_1 + var_472_8 and arg_469_1.time_ < var_472_1 + var_472_8 + arg_472_0 then
				arg_469_1.typewritter.percent = 1

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(true)
			end
		end

		arg_469_1.nodeConfigList_ = {}

		arg_469_1:InitPlayNodeList()
	end,
	Play1101105114 = function(arg_473_0, arg_473_1)
		arg_473_1.time_ = 0
		arg_473_1.frameCnt_ = 0
		arg_473_1.state_ = "playing"
		arg_473_1.curTalkId_ = 1101105114
		arg_473_1.duration_ = 5

		SetActive(arg_473_1.tipsGo_, false)

		function arg_473_1.onSingleLineFinish_()
			arg_473_1.onSingleLineUpdate_ = nil
			arg_473_1.onSingleLineFinish_ = nil
			arg_473_1.state_ = "waiting"
		end

		function arg_473_1.playNext_(arg_475_0)
			if arg_475_0 == 1 then
				arg_473_0:Play1101105115(arg_473_1)
			end
		end

		function arg_473_1.onSingleLineUpdate_(arg_476_0)
			local var_476_0 = arg_473_1.actors_["1011ui_story"].transform
			local var_476_1 = 0

			if var_476_1 < arg_473_1.time_ and arg_473_1.time_ <= var_476_1 + arg_476_0 then
				arg_473_1.var_.moveOldPos1011ui_story = var_476_0.localPosition
			end

			local var_476_2 = 0.001

			if var_476_1 <= arg_473_1.time_ and arg_473_1.time_ < var_476_1 + var_476_2 then
				local var_476_3 = (arg_473_1.time_ - var_476_1) / var_476_2
				local var_476_4 = Vector3.New(0, -0.71, -6)

				var_476_0.localPosition = Vector3.Lerp(arg_473_1.var_.moveOldPos1011ui_story, var_476_4, var_476_3)

				local var_476_5 = manager.ui.mainCamera.transform.position - var_476_0.position

				var_476_0.forward = Vector3.New(var_476_5.x, var_476_5.y, var_476_5.z)

				local var_476_6 = var_476_0.localEulerAngles

				var_476_6.z = 0
				var_476_6.x = 0
				var_476_0.localEulerAngles = var_476_6
			end

			if arg_473_1.time_ >= var_476_1 + var_476_2 and arg_473_1.time_ < var_476_1 + var_476_2 + arg_476_0 then
				var_476_0.localPosition = Vector3.New(0, -0.71, -6)

				local var_476_7 = manager.ui.mainCamera.transform.position - var_476_0.position

				var_476_0.forward = Vector3.New(var_476_7.x, var_476_7.y, var_476_7.z)

				local var_476_8 = var_476_0.localEulerAngles

				var_476_8.z = 0
				var_476_8.x = 0
				var_476_0.localEulerAngles = var_476_8
			end

			local var_476_9 = arg_473_1.actors_["1011ui_story"]
			local var_476_10 = 0

			if var_476_10 < arg_473_1.time_ and arg_473_1.time_ <= var_476_10 + arg_476_0 and not isNil(var_476_9) and arg_473_1.var_.characterEffect1011ui_story == nil then
				arg_473_1.var_.characterEffect1011ui_story = var_476_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_476_11 = 0.200000002980232

			if var_476_10 <= arg_473_1.time_ and arg_473_1.time_ < var_476_10 + var_476_11 and not isNil(var_476_9) then
				local var_476_12 = (arg_473_1.time_ - var_476_10) / var_476_11

				if arg_473_1.var_.characterEffect1011ui_story and not isNil(var_476_9) then
					local var_476_13 = Mathf.Lerp(0, 0.5, var_476_12)

					arg_473_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_473_1.var_.characterEffect1011ui_story.fillRatio = var_476_13
				end
			end

			if arg_473_1.time_ >= var_476_10 + var_476_11 and arg_473_1.time_ < var_476_10 + var_476_11 + arg_476_0 and not isNil(var_476_9) and arg_473_1.var_.characterEffect1011ui_story then
				local var_476_14 = 0.5

				arg_473_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_473_1.var_.characterEffect1011ui_story.fillRatio = var_476_14
			end

			local var_476_15 = 0
			local var_476_16 = 0.875

			if var_476_15 < arg_473_1.time_ and arg_473_1.time_ <= var_476_15 + arg_476_0 then
				arg_473_1.talkMaxDuration = 0
				arg_473_1.dialogCg_.alpha = 1

				arg_473_1.dialog_:SetActive(true)
				SetActive(arg_473_1.leftNameGo_, true)

				local var_476_17 = arg_473_1:FormatText(StoryNameCfg[7].name)

				arg_473_1.leftNameTxt_.text = var_476_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_473_1.leftNameTxt_.transform)

				arg_473_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_473_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_473_1:RecordName(arg_473_1.leftNameTxt_.text)
				SetActive(arg_473_1.iconTrs_.gameObject, true)
				arg_473_1.iconController_:SetSelectedState("hero")

				arg_473_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_473_1.callingController_:SetSelectedState("normal")

				arg_473_1.keyicon_.color = Color.New(1, 1, 1)
				arg_473_1.icon_.color = Color.New(1, 1, 1)

				local var_476_18 = arg_473_1:GetWordFromCfg(1101105114)
				local var_476_19 = arg_473_1:FormatText(var_476_18.content)

				arg_473_1.text_.text = var_476_19

				LuaForUtil.ClearLinePrefixSymbol(arg_473_1.text_)

				local var_476_20 = 35
				local var_476_21 = utf8.len(var_476_19)
				local var_476_22 = var_476_20 <= 0 and var_476_16 or var_476_16 * (var_476_21 / var_476_20)

				if var_476_22 > 0 and var_476_16 < var_476_22 then
					arg_473_1.talkMaxDuration = var_476_22

					if var_476_22 + var_476_15 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_22 + var_476_15
					end
				end

				arg_473_1.text_.text = var_476_19
				arg_473_1.typewritter.percent = 0

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(false)
				arg_473_1:RecordContent(arg_473_1.text_.text)
			end

			local var_476_23 = math.max(var_476_16, arg_473_1.talkMaxDuration)

			if var_476_15 <= arg_473_1.time_ and arg_473_1.time_ < var_476_15 + var_476_23 then
				arg_473_1.typewritter.percent = (arg_473_1.time_ - var_476_15) / var_476_23

				arg_473_1.typewritter:SetDirty()
			end

			if arg_473_1.time_ >= var_476_15 + var_476_23 and arg_473_1.time_ < var_476_15 + var_476_23 + arg_476_0 then
				arg_473_1.typewritter.percent = 1

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(true)
			end
		end

		arg_473_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_473_1:InitPlayNodeList()
	end,
	Play1101105115 = function(arg_477_0, arg_477_1)
		arg_477_1.time_ = 0
		arg_477_1.frameCnt_ = 0
		arg_477_1.state_ = "playing"
		arg_477_1.curTalkId_ = 1101105115
		arg_477_1.duration_ = 5

		SetActive(arg_477_1.tipsGo_, false)

		function arg_477_1.onSingleLineFinish_()
			arg_477_1.onSingleLineUpdate_ = nil
			arg_477_1.onSingleLineFinish_ = nil
			arg_477_1.state_ = "waiting"
		end

		function arg_477_1.playNext_(arg_479_0)
			if arg_479_0 == 1 then
				arg_477_0:Play1101105116(arg_477_1)
			end
		end

		function arg_477_1.onSingleLineUpdate_(arg_480_0)
			local var_480_0 = 0
			local var_480_1 = 0.55

			if var_480_0 < arg_477_1.time_ and arg_477_1.time_ <= var_480_0 + arg_480_0 then
				arg_477_1.talkMaxDuration = 0
				arg_477_1.dialogCg_.alpha = 1

				arg_477_1.dialog_:SetActive(true)
				SetActive(arg_477_1.leftNameGo_, true)

				local var_480_2 = arg_477_1:FormatText(StoryNameCfg[7].name)

				arg_477_1.leftNameTxt_.text = var_480_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_477_1.leftNameTxt_.transform)

				arg_477_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_477_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_477_1:RecordName(arg_477_1.leftNameTxt_.text)
				SetActive(arg_477_1.iconTrs_.gameObject, true)
				arg_477_1.iconController_:SetSelectedState("hero")

				arg_477_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_477_1.callingController_:SetSelectedState("normal")

				arg_477_1.keyicon_.color = Color.New(1, 1, 1)
				arg_477_1.icon_.color = Color.New(1, 1, 1)

				local var_480_3 = arg_477_1:GetWordFromCfg(1101105115)
				local var_480_4 = arg_477_1:FormatText(var_480_3.content)

				arg_477_1.text_.text = var_480_4

				LuaForUtil.ClearLinePrefixSymbol(arg_477_1.text_)

				local var_480_5 = 22
				local var_480_6 = utf8.len(var_480_4)
				local var_480_7 = var_480_5 <= 0 and var_480_1 or var_480_1 * (var_480_6 / var_480_5)

				if var_480_7 > 0 and var_480_1 < var_480_7 then
					arg_477_1.talkMaxDuration = var_480_7

					if var_480_7 + var_480_0 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_7 + var_480_0
					end
				end

				arg_477_1.text_.text = var_480_4
				arg_477_1.typewritter.percent = 0

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(false)
				arg_477_1:RecordContent(arg_477_1.text_.text)
			end

			local var_480_8 = math.max(var_480_1, arg_477_1.talkMaxDuration)

			if var_480_0 <= arg_477_1.time_ and arg_477_1.time_ < var_480_0 + var_480_8 then
				arg_477_1.typewritter.percent = (arg_477_1.time_ - var_480_0) / var_480_8

				arg_477_1.typewritter:SetDirty()
			end

			if arg_477_1.time_ >= var_480_0 + var_480_8 and arg_477_1.time_ < var_480_0 + var_480_8 + arg_480_0 then
				arg_477_1.typewritter.percent = 1

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(true)
			end
		end

		arg_477_1.nodeConfigList_ = {}

		arg_477_1:InitPlayNodeList()
	end,
	Play1101105116 = function(arg_481_0, arg_481_1)
		arg_481_1.time_ = 0
		arg_481_1.frameCnt_ = 0
		arg_481_1.state_ = "playing"
		arg_481_1.curTalkId_ = 1101105116
		arg_481_1.duration_ = 8.2

		local var_481_0 = {
			zh = 5.333,
			ja = 8.2
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
				arg_481_0:Play1101105117(arg_481_1)
			end
		end

		function arg_481_1.onSingleLineUpdate_(arg_484_0)
			local var_484_0 = arg_481_1.actors_["1011ui_story"].transform
			local var_484_1 = 0

			if var_484_1 < arg_481_1.time_ and arg_481_1.time_ <= var_484_1 + arg_484_0 then
				arg_481_1.var_.moveOldPos1011ui_story = var_484_0.localPosition
			end

			local var_484_2 = 0.001

			if var_484_1 <= arg_481_1.time_ and arg_481_1.time_ < var_484_1 + var_484_2 then
				local var_484_3 = (arg_481_1.time_ - var_484_1) / var_484_2
				local var_484_4 = Vector3.New(0, -0.71, -6)

				var_484_0.localPosition = Vector3.Lerp(arg_481_1.var_.moveOldPos1011ui_story, var_484_4, var_484_3)

				local var_484_5 = manager.ui.mainCamera.transform.position - var_484_0.position

				var_484_0.forward = Vector3.New(var_484_5.x, var_484_5.y, var_484_5.z)

				local var_484_6 = var_484_0.localEulerAngles

				var_484_6.z = 0
				var_484_6.x = 0
				var_484_0.localEulerAngles = var_484_6
			end

			if arg_481_1.time_ >= var_484_1 + var_484_2 and arg_481_1.time_ < var_484_1 + var_484_2 + arg_484_0 then
				var_484_0.localPosition = Vector3.New(0, -0.71, -6)

				local var_484_7 = manager.ui.mainCamera.transform.position - var_484_0.position

				var_484_0.forward = Vector3.New(var_484_7.x, var_484_7.y, var_484_7.z)

				local var_484_8 = var_484_0.localEulerAngles

				var_484_8.z = 0
				var_484_8.x = 0
				var_484_0.localEulerAngles = var_484_8
			end

			local var_484_9 = arg_481_1.actors_["1011ui_story"]
			local var_484_10 = 0

			if var_484_10 < arg_481_1.time_ and arg_481_1.time_ <= var_484_10 + arg_484_0 and not isNil(var_484_9) and arg_481_1.var_.characterEffect1011ui_story == nil then
				arg_481_1.var_.characterEffect1011ui_story = var_484_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_484_11 = 0.200000002980232

			if var_484_10 <= arg_481_1.time_ and arg_481_1.time_ < var_484_10 + var_484_11 and not isNil(var_484_9) then
				local var_484_12 = (arg_481_1.time_ - var_484_10) / var_484_11

				if arg_481_1.var_.characterEffect1011ui_story and not isNil(var_484_9) then
					arg_481_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_481_1.time_ >= var_484_10 + var_484_11 and arg_481_1.time_ < var_484_10 + var_484_11 + arg_484_0 and not isNil(var_484_9) and arg_481_1.var_.characterEffect1011ui_story then
				arg_481_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_484_13 = 0

			if var_484_13 < arg_481_1.time_ and arg_481_1.time_ <= var_484_13 + arg_484_0 then
				arg_481_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011actionlink/1011action453")
			end

			local var_484_14 = 0

			if var_484_14 < arg_481_1.time_ and arg_481_1.time_ <= var_484_14 + arg_484_0 then
				arg_481_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_484_15 = 0
			local var_484_16 = 0.55

			if var_484_15 < arg_481_1.time_ and arg_481_1.time_ <= var_484_15 + arg_484_0 then
				arg_481_1.talkMaxDuration = 0
				arg_481_1.dialogCg_.alpha = 1

				arg_481_1.dialog_:SetActive(true)
				SetActive(arg_481_1.leftNameGo_, true)

				local var_484_17 = arg_481_1:FormatText(StoryNameCfg[37].name)

				arg_481_1.leftNameTxt_.text = var_484_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_481_1.leftNameTxt_.transform)

				arg_481_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_481_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_481_1:RecordName(arg_481_1.leftNameTxt_.text)
				SetActive(arg_481_1.iconTrs_.gameObject, false)
				arg_481_1.callingController_:SetSelectedState("normal")

				local var_484_18 = arg_481_1:GetWordFromCfg(1101105116)
				local var_484_19 = arg_481_1:FormatText(var_484_18.content)

				arg_481_1.text_.text = var_484_19

				LuaForUtil.ClearLinePrefixSymbol(arg_481_1.text_)

				local var_484_20 = 22
				local var_484_21 = utf8.len(var_484_19)
				local var_484_22 = var_484_20 <= 0 and var_484_16 or var_484_16 * (var_484_21 / var_484_20)

				if var_484_22 > 0 and var_484_16 < var_484_22 then
					arg_481_1.talkMaxDuration = var_484_22

					if var_484_22 + var_484_15 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_22 + var_484_15
					end
				end

				arg_481_1.text_.text = var_484_19
				arg_481_1.typewritter.percent = 0

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105116", "story_v_side_new_1101105.awb") ~= 0 then
					local var_484_23 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105116", "story_v_side_new_1101105.awb") / 1000

					if var_484_23 + var_484_15 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_23 + var_484_15
					end

					if var_484_18.prefab_name ~= "" and arg_481_1.actors_[var_484_18.prefab_name] ~= nil then
						local var_484_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_481_1.actors_[var_484_18.prefab_name].transform, "story_v_side_new_1101105", "1101105116", "story_v_side_new_1101105.awb")

						arg_481_1:RecordAudio("1101105116", var_484_24)
						arg_481_1:RecordAudio("1101105116", var_484_24)
					else
						arg_481_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105116", "story_v_side_new_1101105.awb")
					end

					arg_481_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105116", "story_v_side_new_1101105.awb")
				end

				arg_481_1:RecordContent(arg_481_1.text_.text)
			end

			local var_484_25 = math.max(var_484_16, arg_481_1.talkMaxDuration)

			if var_484_15 <= arg_481_1.time_ and arg_481_1.time_ < var_484_15 + var_484_25 then
				arg_481_1.typewritter.percent = (arg_481_1.time_ - var_484_15) / var_484_25

				arg_481_1.typewritter:SetDirty()
			end

			if arg_481_1.time_ >= var_484_15 + var_484_25 and arg_481_1.time_ < var_484_15 + var_484_25 + arg_484_0 then
				arg_481_1.typewritter.percent = 1

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(true)
			end
		end

		arg_481_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_481_1:InitPlayNodeList()
	end,
	Play1101105117 = function(arg_485_0, arg_485_1)
		arg_485_1.time_ = 0
		arg_485_1.frameCnt_ = 0
		arg_485_1.state_ = "playing"
		arg_485_1.curTalkId_ = 1101105117
		arg_485_1.duration_ = 1

		SetActive(arg_485_1.tipsGo_, false)

		function arg_485_1.onSingleLineFinish_()
			arg_485_1.onSingleLineUpdate_ = nil
			arg_485_1.onSingleLineFinish_ = nil
			arg_485_1.state_ = "waiting"

			SetActive(arg_485_1.choicesGo_, true)

			for iter_486_0, iter_486_1 in ipairs(arg_485_1.choices_) do
				local var_486_0 = iter_486_0 <= 1

				SetActive(iter_486_1.go, var_486_0)
			end

			arg_485_1.choices_[1].txt.text = arg_485_1:FormatText(StoryChoiceCfg[621].name)
		end

		function arg_485_1.playNext_(arg_487_0)
			if arg_487_0 == 1 then
				arg_485_0:Play1101105118(arg_485_1)
			end

			arg_485_1:RecordChoiceLog(1101105117, 621)
		end

		function arg_485_1.onSingleLineUpdate_(arg_488_0)
			local var_488_0 = arg_485_1.actors_["1011ui_story"]
			local var_488_1 = 0

			if var_488_1 < arg_485_1.time_ and arg_485_1.time_ <= var_488_1 + arg_488_0 and not isNil(var_488_0) and arg_485_1.var_.characterEffect1011ui_story == nil then
				arg_485_1.var_.characterEffect1011ui_story = var_488_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_488_2 = 0.200000002980232

			if var_488_1 <= arg_485_1.time_ and arg_485_1.time_ < var_488_1 + var_488_2 and not isNil(var_488_0) then
				local var_488_3 = (arg_485_1.time_ - var_488_1) / var_488_2

				if arg_485_1.var_.characterEffect1011ui_story and not isNil(var_488_0) then
					local var_488_4 = Mathf.Lerp(0, 0.5, var_488_3)

					arg_485_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_485_1.var_.characterEffect1011ui_story.fillRatio = var_488_4
				end
			end

			if arg_485_1.time_ >= var_488_1 + var_488_2 and arg_485_1.time_ < var_488_1 + var_488_2 + arg_488_0 and not isNil(var_488_0) and arg_485_1.var_.characterEffect1011ui_story then
				local var_488_5 = 0.5

				arg_485_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_485_1.var_.characterEffect1011ui_story.fillRatio = var_488_5
			end

			local var_488_6 = 0

			if var_488_6 < arg_485_1.time_ and arg_485_1.time_ <= var_488_6 + arg_488_0 then
				arg_485_1.allBtn_.enabled = false
			end

			local var_488_7 = 0.5

			if arg_485_1.time_ >= var_488_6 + var_488_7 and arg_485_1.time_ < var_488_6 + var_488_7 + arg_488_0 then
				arg_485_1.allBtn_.enabled = true
			end
		end

		arg_485_1.nodeConfigList_ = {}

		arg_485_1:InitPlayNodeList()
	end,
	Play1101105118 = function(arg_489_0, arg_489_1)
		arg_489_1.time_ = 0
		arg_489_1.frameCnt_ = 0
		arg_489_1.state_ = "playing"
		arg_489_1.curTalkId_ = 1101105118
		arg_489_1.duration_ = 5

		SetActive(arg_489_1.tipsGo_, false)

		function arg_489_1.onSingleLineFinish_()
			arg_489_1.onSingleLineUpdate_ = nil
			arg_489_1.onSingleLineFinish_ = nil
			arg_489_1.state_ = "waiting"
		end

		function arg_489_1.playNext_(arg_491_0)
			if arg_491_0 == 1 then
				arg_489_0:Play1101105119(arg_489_1)
			end
		end

		function arg_489_1.onSingleLineUpdate_(arg_492_0)
			local var_492_0 = 0
			local var_492_1 = 0.725

			if var_492_0 < arg_489_1.time_ and arg_489_1.time_ <= var_492_0 + arg_492_0 then
				arg_489_1.talkMaxDuration = 0
				arg_489_1.dialogCg_.alpha = 1

				arg_489_1.dialog_:SetActive(true)
				SetActive(arg_489_1.leftNameGo_, true)

				local var_492_2 = arg_489_1:FormatText(StoryNameCfg[7].name)

				arg_489_1.leftNameTxt_.text = var_492_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_489_1.leftNameTxt_.transform)

				arg_489_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_489_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_489_1:RecordName(arg_489_1.leftNameTxt_.text)
				SetActive(arg_489_1.iconTrs_.gameObject, true)
				arg_489_1.iconController_:SetSelectedState("hero")

				arg_489_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_489_1.callingController_:SetSelectedState("normal")

				arg_489_1.keyicon_.color = Color.New(1, 1, 1)
				arg_489_1.icon_.color = Color.New(1, 1, 1)

				local var_492_3 = arg_489_1:GetWordFromCfg(1101105118)
				local var_492_4 = arg_489_1:FormatText(var_492_3.content)

				arg_489_1.text_.text = var_492_4

				LuaForUtil.ClearLinePrefixSymbol(arg_489_1.text_)

				local var_492_5 = 29
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
				arg_489_1:RecordContent(arg_489_1.text_.text)
			end

			local var_492_8 = math.max(var_492_1, arg_489_1.talkMaxDuration)

			if var_492_0 <= arg_489_1.time_ and arg_489_1.time_ < var_492_0 + var_492_8 then
				arg_489_1.typewritter.percent = (arg_489_1.time_ - var_492_0) / var_492_8

				arg_489_1.typewritter:SetDirty()
			end

			if arg_489_1.time_ >= var_492_0 + var_492_8 and arg_489_1.time_ < var_492_0 + var_492_8 + arg_492_0 then
				arg_489_1.typewritter.percent = 1

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(true)
			end
		end

		arg_489_1.nodeConfigList_ = {}

		arg_489_1:InitPlayNodeList()
	end,
	Play1101105119 = function(arg_493_0, arg_493_1)
		arg_493_1.time_ = 0
		arg_493_1.frameCnt_ = 0
		arg_493_1.state_ = "playing"
		arg_493_1.curTalkId_ = 1101105119
		arg_493_1.duration_ = 9.47

		local var_493_0 = {
			zh = 8.933,
			ja = 9.466
		}
		local var_493_1 = manager.audio:GetLocalizationFlag()

		if var_493_0[var_493_1] ~= nil then
			arg_493_1.duration_ = var_493_0[var_493_1]
		end

		SetActive(arg_493_1.tipsGo_, false)

		function arg_493_1.onSingleLineFinish_()
			arg_493_1.onSingleLineUpdate_ = nil
			arg_493_1.onSingleLineFinish_ = nil
			arg_493_1.state_ = "waiting"
		end

		function arg_493_1.playNext_(arg_495_0)
			if arg_495_0 == 1 then
				arg_493_0:Play1101105120(arg_493_1)
			end
		end

		function arg_493_1.onSingleLineUpdate_(arg_496_0)
			local var_496_0 = arg_493_1.actors_["1011ui_story"].transform
			local var_496_1 = 0

			if var_496_1 < arg_493_1.time_ and arg_493_1.time_ <= var_496_1 + arg_496_0 then
				arg_493_1.var_.moveOldPos1011ui_story = var_496_0.localPosition
			end

			local var_496_2 = 0.001

			if var_496_1 <= arg_493_1.time_ and arg_493_1.time_ < var_496_1 + var_496_2 then
				local var_496_3 = (arg_493_1.time_ - var_496_1) / var_496_2
				local var_496_4 = Vector3.New(0, -0.71, -6)

				var_496_0.localPosition = Vector3.Lerp(arg_493_1.var_.moveOldPos1011ui_story, var_496_4, var_496_3)

				local var_496_5 = manager.ui.mainCamera.transform.position - var_496_0.position

				var_496_0.forward = Vector3.New(var_496_5.x, var_496_5.y, var_496_5.z)

				local var_496_6 = var_496_0.localEulerAngles

				var_496_6.z = 0
				var_496_6.x = 0
				var_496_0.localEulerAngles = var_496_6
			end

			if arg_493_1.time_ >= var_496_1 + var_496_2 and arg_493_1.time_ < var_496_1 + var_496_2 + arg_496_0 then
				var_496_0.localPosition = Vector3.New(0, -0.71, -6)

				local var_496_7 = manager.ui.mainCamera.transform.position - var_496_0.position

				var_496_0.forward = Vector3.New(var_496_7.x, var_496_7.y, var_496_7.z)

				local var_496_8 = var_496_0.localEulerAngles

				var_496_8.z = 0
				var_496_8.x = 0
				var_496_0.localEulerAngles = var_496_8
			end

			local var_496_9 = arg_493_1.actors_["1011ui_story"]
			local var_496_10 = 0

			if var_496_10 < arg_493_1.time_ and arg_493_1.time_ <= var_496_10 + arg_496_0 and not isNil(var_496_9) and arg_493_1.var_.characterEffect1011ui_story == nil then
				arg_493_1.var_.characterEffect1011ui_story = var_496_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_496_11 = 0.200000002980232

			if var_496_10 <= arg_493_1.time_ and arg_493_1.time_ < var_496_10 + var_496_11 and not isNil(var_496_9) then
				local var_496_12 = (arg_493_1.time_ - var_496_10) / var_496_11

				if arg_493_1.var_.characterEffect1011ui_story and not isNil(var_496_9) then
					arg_493_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_493_1.time_ >= var_496_10 + var_496_11 and arg_493_1.time_ < var_496_10 + var_496_11 + arg_496_0 and not isNil(var_496_9) and arg_493_1.var_.characterEffect1011ui_story then
				arg_493_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_496_13 = 0

			if var_496_13 < arg_493_1.time_ and arg_493_1.time_ <= var_496_13 + arg_496_0 then
				arg_493_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_496_14 = 0
			local var_496_15 = 1.05

			if var_496_14 < arg_493_1.time_ and arg_493_1.time_ <= var_496_14 + arg_496_0 then
				arg_493_1.talkMaxDuration = 0
				arg_493_1.dialogCg_.alpha = 1

				arg_493_1.dialog_:SetActive(true)
				SetActive(arg_493_1.leftNameGo_, true)

				local var_496_16 = arg_493_1:FormatText(StoryNameCfg[37].name)

				arg_493_1.leftNameTxt_.text = var_496_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_493_1.leftNameTxt_.transform)

				arg_493_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_493_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_493_1:RecordName(arg_493_1.leftNameTxt_.text)
				SetActive(arg_493_1.iconTrs_.gameObject, false)
				arg_493_1.callingController_:SetSelectedState("normal")

				local var_496_17 = arg_493_1:GetWordFromCfg(1101105119)
				local var_496_18 = arg_493_1:FormatText(var_496_17.content)

				arg_493_1.text_.text = var_496_18

				LuaForUtil.ClearLinePrefixSymbol(arg_493_1.text_)

				local var_496_19 = 42
				local var_496_20 = utf8.len(var_496_18)
				local var_496_21 = var_496_19 <= 0 and var_496_15 or var_496_15 * (var_496_20 / var_496_19)

				if var_496_21 > 0 and var_496_15 < var_496_21 then
					arg_493_1.talkMaxDuration = var_496_21

					if var_496_21 + var_496_14 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_21 + var_496_14
					end
				end

				arg_493_1.text_.text = var_496_18
				arg_493_1.typewritter.percent = 0

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105119", "story_v_side_new_1101105.awb") ~= 0 then
					local var_496_22 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105119", "story_v_side_new_1101105.awb") / 1000

					if var_496_22 + var_496_14 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_22 + var_496_14
					end

					if var_496_17.prefab_name ~= "" and arg_493_1.actors_[var_496_17.prefab_name] ~= nil then
						local var_496_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_493_1.actors_[var_496_17.prefab_name].transform, "story_v_side_new_1101105", "1101105119", "story_v_side_new_1101105.awb")

						arg_493_1:RecordAudio("1101105119", var_496_23)
						arg_493_1:RecordAudio("1101105119", var_496_23)
					else
						arg_493_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105119", "story_v_side_new_1101105.awb")
					end

					arg_493_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105119", "story_v_side_new_1101105.awb")
				end

				arg_493_1:RecordContent(arg_493_1.text_.text)
			end

			local var_496_24 = math.max(var_496_15, arg_493_1.talkMaxDuration)

			if var_496_14 <= arg_493_1.time_ and arg_493_1.time_ < var_496_14 + var_496_24 then
				arg_493_1.typewritter.percent = (arg_493_1.time_ - var_496_14) / var_496_24

				arg_493_1.typewritter:SetDirty()
			end

			if arg_493_1.time_ >= var_496_14 + var_496_24 and arg_493_1.time_ < var_496_14 + var_496_24 + arg_496_0 then
				arg_493_1.typewritter.percent = 1

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(true)
			end
		end

		arg_493_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_493_1:InitPlayNodeList()
	end,
	Play1101105120 = function(arg_497_0, arg_497_1)
		arg_497_1.time_ = 0
		arg_497_1.frameCnt_ = 0
		arg_497_1.state_ = "playing"
		arg_497_1.curTalkId_ = 1101105120
		arg_497_1.duration_ = 5

		SetActive(arg_497_1.tipsGo_, false)

		function arg_497_1.onSingleLineFinish_()
			arg_497_1.onSingleLineUpdate_ = nil
			arg_497_1.onSingleLineFinish_ = nil
			arg_497_1.state_ = "waiting"
		end

		function arg_497_1.playNext_(arg_499_0)
			if arg_499_0 == 1 then
				arg_497_0:Play1101105121(arg_497_1)
			end
		end

		function arg_497_1.onSingleLineUpdate_(arg_500_0)
			local var_500_0 = arg_497_1.actors_["1011ui_story"]
			local var_500_1 = 0

			if var_500_1 < arg_497_1.time_ and arg_497_1.time_ <= var_500_1 + arg_500_0 and not isNil(var_500_0) and arg_497_1.var_.characterEffect1011ui_story == nil then
				arg_497_1.var_.characterEffect1011ui_story = var_500_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_500_2 = 0.200000002980232

			if var_500_1 <= arg_497_1.time_ and arg_497_1.time_ < var_500_1 + var_500_2 and not isNil(var_500_0) then
				local var_500_3 = (arg_497_1.time_ - var_500_1) / var_500_2

				if arg_497_1.var_.characterEffect1011ui_story and not isNil(var_500_0) then
					local var_500_4 = Mathf.Lerp(0, 0.5, var_500_3)

					arg_497_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_497_1.var_.characterEffect1011ui_story.fillRatio = var_500_4
				end
			end

			if arg_497_1.time_ >= var_500_1 + var_500_2 and arg_497_1.time_ < var_500_1 + var_500_2 + arg_500_0 and not isNil(var_500_0) and arg_497_1.var_.characterEffect1011ui_story then
				local var_500_5 = 0.5

				arg_497_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_497_1.var_.characterEffect1011ui_story.fillRatio = var_500_5
			end

			local var_500_6 = 0
			local var_500_7 = 0.175

			if var_500_6 < arg_497_1.time_ and arg_497_1.time_ <= var_500_6 + arg_500_0 then
				arg_497_1.talkMaxDuration = 0
				arg_497_1.dialogCg_.alpha = 1

				arg_497_1.dialog_:SetActive(true)
				SetActive(arg_497_1.leftNameGo_, true)

				local var_500_8 = arg_497_1:FormatText(StoryNameCfg[7].name)

				arg_497_1.leftNameTxt_.text = var_500_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_497_1.leftNameTxt_.transform)

				arg_497_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_497_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_497_1:RecordName(arg_497_1.leftNameTxt_.text)
				SetActive(arg_497_1.iconTrs_.gameObject, true)
				arg_497_1.iconController_:SetSelectedState("hero")

				arg_497_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_497_1.callingController_:SetSelectedState("normal")

				arg_497_1.keyicon_.color = Color.New(1, 1, 1)
				arg_497_1.icon_.color = Color.New(1, 1, 1)

				local var_500_9 = arg_497_1:GetWordFromCfg(1101105120)
				local var_500_10 = arg_497_1:FormatText(var_500_9.content)

				arg_497_1.text_.text = var_500_10

				LuaForUtil.ClearLinePrefixSymbol(arg_497_1.text_)

				local var_500_11 = 7
				local var_500_12 = utf8.len(var_500_10)
				local var_500_13 = var_500_11 <= 0 and var_500_7 or var_500_7 * (var_500_12 / var_500_11)

				if var_500_13 > 0 and var_500_7 < var_500_13 then
					arg_497_1.talkMaxDuration = var_500_13

					if var_500_13 + var_500_6 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_13 + var_500_6
					end
				end

				arg_497_1.text_.text = var_500_10
				arg_497_1.typewritter.percent = 0

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(false)
				arg_497_1:RecordContent(arg_497_1.text_.text)
			end

			local var_500_14 = math.max(var_500_7, arg_497_1.talkMaxDuration)

			if var_500_6 <= arg_497_1.time_ and arg_497_1.time_ < var_500_6 + var_500_14 then
				arg_497_1.typewritter.percent = (arg_497_1.time_ - var_500_6) / var_500_14

				arg_497_1.typewritter:SetDirty()
			end

			if arg_497_1.time_ >= var_500_6 + var_500_14 and arg_497_1.time_ < var_500_6 + var_500_14 + arg_500_0 then
				arg_497_1.typewritter.percent = 1

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(true)
			end
		end

		arg_497_1.nodeConfigList_ = {}

		arg_497_1:InitPlayNodeList()
	end,
	Play1101105121 = function(arg_501_0, arg_501_1)
		arg_501_1.time_ = 0
		arg_501_1.frameCnt_ = 0
		arg_501_1.state_ = "playing"
		arg_501_1.curTalkId_ = 1101105121
		arg_501_1.duration_ = 5.63

		local var_501_0 = {
			zh = 3.6,
			ja = 5.633
		}
		local var_501_1 = manager.audio:GetLocalizationFlag()

		if var_501_0[var_501_1] ~= nil then
			arg_501_1.duration_ = var_501_0[var_501_1]
		end

		SetActive(arg_501_1.tipsGo_, false)

		function arg_501_1.onSingleLineFinish_()
			arg_501_1.onSingleLineUpdate_ = nil
			arg_501_1.onSingleLineFinish_ = nil
			arg_501_1.state_ = "waiting"
		end

		function arg_501_1.playNext_(arg_503_0)
			if arg_503_0 == 1 then
				arg_501_0:Play1101105122(arg_501_1)
			end
		end

		function arg_501_1.onSingleLineUpdate_(arg_504_0)
			local var_504_0 = arg_501_1.actors_["1011ui_story"].transform
			local var_504_1 = 0

			if var_504_1 < arg_501_1.time_ and arg_501_1.time_ <= var_504_1 + arg_504_0 then
				arg_501_1.var_.moveOldPos1011ui_story = var_504_0.localPosition
			end

			local var_504_2 = 0.001

			if var_504_1 <= arg_501_1.time_ and arg_501_1.time_ < var_504_1 + var_504_2 then
				local var_504_3 = (arg_501_1.time_ - var_504_1) / var_504_2
				local var_504_4 = Vector3.New(0, -0.71, -6)

				var_504_0.localPosition = Vector3.Lerp(arg_501_1.var_.moveOldPos1011ui_story, var_504_4, var_504_3)

				local var_504_5 = manager.ui.mainCamera.transform.position - var_504_0.position

				var_504_0.forward = Vector3.New(var_504_5.x, var_504_5.y, var_504_5.z)

				local var_504_6 = var_504_0.localEulerAngles

				var_504_6.z = 0
				var_504_6.x = 0
				var_504_0.localEulerAngles = var_504_6
			end

			if arg_501_1.time_ >= var_504_1 + var_504_2 and arg_501_1.time_ < var_504_1 + var_504_2 + arg_504_0 then
				var_504_0.localPosition = Vector3.New(0, -0.71, -6)

				local var_504_7 = manager.ui.mainCamera.transform.position - var_504_0.position

				var_504_0.forward = Vector3.New(var_504_7.x, var_504_7.y, var_504_7.z)

				local var_504_8 = var_504_0.localEulerAngles

				var_504_8.z = 0
				var_504_8.x = 0
				var_504_0.localEulerAngles = var_504_8
			end

			local var_504_9 = arg_501_1.actors_["1011ui_story"]
			local var_504_10 = 0

			if var_504_10 < arg_501_1.time_ and arg_501_1.time_ <= var_504_10 + arg_504_0 and not isNil(var_504_9) and arg_501_1.var_.characterEffect1011ui_story == nil then
				arg_501_1.var_.characterEffect1011ui_story = var_504_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_504_11 = 0.200000002980232

			if var_504_10 <= arg_501_1.time_ and arg_501_1.time_ < var_504_10 + var_504_11 and not isNil(var_504_9) then
				local var_504_12 = (arg_501_1.time_ - var_504_10) / var_504_11

				if arg_501_1.var_.characterEffect1011ui_story and not isNil(var_504_9) then
					arg_501_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_501_1.time_ >= var_504_10 + var_504_11 and arg_501_1.time_ < var_504_10 + var_504_11 + arg_504_0 and not isNil(var_504_9) and arg_501_1.var_.characterEffect1011ui_story then
				arg_501_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_504_13 = 0

			if var_504_13 < arg_501_1.time_ and arg_501_1.time_ <= var_504_13 + arg_504_0 then
				arg_501_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011actionlink/1011action435")
			end

			local var_504_14 = 0

			if var_504_14 < arg_501_1.time_ and arg_501_1.time_ <= var_504_14 + arg_504_0 then
				arg_501_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_504_15 = 0

			if var_504_15 < arg_501_1.time_ and arg_501_1.time_ <= var_504_15 + arg_504_0 then
				arg_501_1.allBtn_.enabled = false
			end

			local var_504_16 = 1.46666666666667

			if arg_501_1.time_ >= var_504_15 + var_504_16 and arg_501_1.time_ < var_504_15 + var_504_16 + arg_504_0 then
				arg_501_1.allBtn_.enabled = true
			end

			local var_504_17 = 0
			local var_504_18 = 0.275

			if var_504_17 < arg_501_1.time_ and arg_501_1.time_ <= var_504_17 + arg_504_0 then
				arg_501_1.talkMaxDuration = 0
				arg_501_1.dialogCg_.alpha = 1

				arg_501_1.dialog_:SetActive(true)
				SetActive(arg_501_1.leftNameGo_, true)

				local var_504_19 = arg_501_1:FormatText(StoryNameCfg[37].name)

				arg_501_1.leftNameTxt_.text = var_504_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_501_1.leftNameTxt_.transform)

				arg_501_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_501_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_501_1:RecordName(arg_501_1.leftNameTxt_.text)
				SetActive(arg_501_1.iconTrs_.gameObject, false)
				arg_501_1.callingController_:SetSelectedState("normal")

				local var_504_20 = arg_501_1:GetWordFromCfg(1101105121)
				local var_504_21 = arg_501_1:FormatText(var_504_20.content)

				arg_501_1.text_.text = var_504_21

				LuaForUtil.ClearLinePrefixSymbol(arg_501_1.text_)

				local var_504_22 = 11
				local var_504_23 = utf8.len(var_504_21)
				local var_504_24 = var_504_22 <= 0 and var_504_18 or var_504_18 * (var_504_23 / var_504_22)

				if var_504_24 > 0 and var_504_18 < var_504_24 then
					arg_501_1.talkMaxDuration = var_504_24

					if var_504_24 + var_504_17 > arg_501_1.duration_ then
						arg_501_1.duration_ = var_504_24 + var_504_17
					end
				end

				arg_501_1.text_.text = var_504_21
				arg_501_1.typewritter.percent = 0

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105121", "story_v_side_new_1101105.awb") ~= 0 then
					local var_504_25 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105121", "story_v_side_new_1101105.awb") / 1000

					if var_504_25 + var_504_17 > arg_501_1.duration_ then
						arg_501_1.duration_ = var_504_25 + var_504_17
					end

					if var_504_20.prefab_name ~= "" and arg_501_1.actors_[var_504_20.prefab_name] ~= nil then
						local var_504_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_501_1.actors_[var_504_20.prefab_name].transform, "story_v_side_new_1101105", "1101105121", "story_v_side_new_1101105.awb")

						arg_501_1:RecordAudio("1101105121", var_504_26)
						arg_501_1:RecordAudio("1101105121", var_504_26)
					else
						arg_501_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105121", "story_v_side_new_1101105.awb")
					end

					arg_501_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105121", "story_v_side_new_1101105.awb")
				end

				arg_501_1:RecordContent(arg_501_1.text_.text)
			end

			local var_504_27 = math.max(var_504_18, arg_501_1.talkMaxDuration)

			if var_504_17 <= arg_501_1.time_ and arg_501_1.time_ < var_504_17 + var_504_27 then
				arg_501_1.typewritter.percent = (arg_501_1.time_ - var_504_17) / var_504_27

				arg_501_1.typewritter:SetDirty()
			end

			if arg_501_1.time_ >= var_504_17 + var_504_27 and arg_501_1.time_ < var_504_17 + var_504_27 + arg_504_0 then
				arg_501_1.typewritter.percent = 1

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(true)
			end
		end

		arg_501_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_501_1:InitPlayNodeList()
	end,
	Play1101105122 = function(arg_505_0, arg_505_1)
		arg_505_1.time_ = 0
		arg_505_1.frameCnt_ = 0
		arg_505_1.state_ = "playing"
		arg_505_1.curTalkId_ = 1101105122
		arg_505_1.duration_ = 5

		SetActive(arg_505_1.tipsGo_, false)

		function arg_505_1.onSingleLineFinish_()
			arg_505_1.onSingleLineUpdate_ = nil
			arg_505_1.onSingleLineFinish_ = nil
			arg_505_1.state_ = "waiting"
		end

		function arg_505_1.playNext_(arg_507_0)
			if arg_507_0 == 1 then
				arg_505_0:Play1101105123(arg_505_1)
			end
		end

		function arg_505_1.onSingleLineUpdate_(arg_508_0)
			local var_508_0 = arg_505_1.actors_["1011ui_story"]
			local var_508_1 = 0

			if var_508_1 < arg_505_1.time_ and arg_505_1.time_ <= var_508_1 + arg_508_0 and not isNil(var_508_0) and arg_505_1.var_.characterEffect1011ui_story == nil then
				arg_505_1.var_.characterEffect1011ui_story = var_508_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_508_2 = 0.200000002980232

			if var_508_1 <= arg_505_1.time_ and arg_505_1.time_ < var_508_1 + var_508_2 and not isNil(var_508_0) then
				local var_508_3 = (arg_505_1.time_ - var_508_1) / var_508_2

				if arg_505_1.var_.characterEffect1011ui_story and not isNil(var_508_0) then
					local var_508_4 = Mathf.Lerp(0, 0.5, var_508_3)

					arg_505_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_505_1.var_.characterEffect1011ui_story.fillRatio = var_508_4
				end
			end

			if arg_505_1.time_ >= var_508_1 + var_508_2 and arg_505_1.time_ < var_508_1 + var_508_2 + arg_508_0 and not isNil(var_508_0) and arg_505_1.var_.characterEffect1011ui_story then
				local var_508_5 = 0.5

				arg_505_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_505_1.var_.characterEffect1011ui_story.fillRatio = var_508_5
			end

			local var_508_6 = 0
			local var_508_7 = 0.275

			if var_508_6 < arg_505_1.time_ and arg_505_1.time_ <= var_508_6 + arg_508_0 then
				arg_505_1.talkMaxDuration = 0
				arg_505_1.dialogCg_.alpha = 1

				arg_505_1.dialog_:SetActive(true)
				SetActive(arg_505_1.leftNameGo_, true)

				local var_508_8 = arg_505_1:FormatText(StoryNameCfg[7].name)

				arg_505_1.leftNameTxt_.text = var_508_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_505_1.leftNameTxt_.transform)

				arg_505_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_505_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_505_1:RecordName(arg_505_1.leftNameTxt_.text)
				SetActive(arg_505_1.iconTrs_.gameObject, true)
				arg_505_1.iconController_:SetSelectedState("hero")

				arg_505_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_505_1.callingController_:SetSelectedState("normal")

				arg_505_1.keyicon_.color = Color.New(1, 1, 1)
				arg_505_1.icon_.color = Color.New(1, 1, 1)

				local var_508_9 = arg_505_1:GetWordFromCfg(1101105122)
				local var_508_10 = arg_505_1:FormatText(var_508_9.content)

				arg_505_1.text_.text = var_508_10

				LuaForUtil.ClearLinePrefixSymbol(arg_505_1.text_)

				local var_508_11 = 11
				local var_508_12 = utf8.len(var_508_10)
				local var_508_13 = var_508_11 <= 0 and var_508_7 or var_508_7 * (var_508_12 / var_508_11)

				if var_508_13 > 0 and var_508_7 < var_508_13 then
					arg_505_1.talkMaxDuration = var_508_13

					if var_508_13 + var_508_6 > arg_505_1.duration_ then
						arg_505_1.duration_ = var_508_13 + var_508_6
					end
				end

				arg_505_1.text_.text = var_508_10
				arg_505_1.typewritter.percent = 0

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(false)
				arg_505_1:RecordContent(arg_505_1.text_.text)
			end

			local var_508_14 = math.max(var_508_7, arg_505_1.talkMaxDuration)

			if var_508_6 <= arg_505_1.time_ and arg_505_1.time_ < var_508_6 + var_508_14 then
				arg_505_1.typewritter.percent = (arg_505_1.time_ - var_508_6) / var_508_14

				arg_505_1.typewritter:SetDirty()
			end

			if arg_505_1.time_ >= var_508_6 + var_508_14 and arg_505_1.time_ < var_508_6 + var_508_14 + arg_508_0 then
				arg_505_1.typewritter.percent = 1

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(true)
			end
		end

		arg_505_1.nodeConfigList_ = {}

		arg_505_1:InitPlayNodeList()
	end,
	Play1101105123 = function(arg_509_0, arg_509_1)
		arg_509_1.time_ = 0
		arg_509_1.frameCnt_ = 0
		arg_509_1.state_ = "playing"
		arg_509_1.curTalkId_ = 1101105123
		arg_509_1.duration_ = 6.47

		local var_509_0 = {
			zh = 6.466,
			ja = 3.233
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
				arg_509_0:Play1101105124(arg_509_1)
			end
		end

		function arg_509_1.onSingleLineUpdate_(arg_512_0)
			local var_512_0 = arg_509_1.actors_["1011ui_story"].transform
			local var_512_1 = 0

			if var_512_1 < arg_509_1.time_ and arg_509_1.time_ <= var_512_1 + arg_512_0 then
				arg_509_1.var_.moveOldPos1011ui_story = var_512_0.localPosition
			end

			local var_512_2 = 0.001

			if var_512_1 <= arg_509_1.time_ and arg_509_1.time_ < var_512_1 + var_512_2 then
				local var_512_3 = (arg_509_1.time_ - var_512_1) / var_512_2
				local var_512_4 = Vector3.New(0, -0.71, -6)

				var_512_0.localPosition = Vector3.Lerp(arg_509_1.var_.moveOldPos1011ui_story, var_512_4, var_512_3)

				local var_512_5 = manager.ui.mainCamera.transform.position - var_512_0.position

				var_512_0.forward = Vector3.New(var_512_5.x, var_512_5.y, var_512_5.z)

				local var_512_6 = var_512_0.localEulerAngles

				var_512_6.z = 0
				var_512_6.x = 0
				var_512_0.localEulerAngles = var_512_6
			end

			if arg_509_1.time_ >= var_512_1 + var_512_2 and arg_509_1.time_ < var_512_1 + var_512_2 + arg_512_0 then
				var_512_0.localPosition = Vector3.New(0, -0.71, -6)

				local var_512_7 = manager.ui.mainCamera.transform.position - var_512_0.position

				var_512_0.forward = Vector3.New(var_512_7.x, var_512_7.y, var_512_7.z)

				local var_512_8 = var_512_0.localEulerAngles

				var_512_8.z = 0
				var_512_8.x = 0
				var_512_0.localEulerAngles = var_512_8
			end

			local var_512_9 = arg_509_1.actors_["1011ui_story"]
			local var_512_10 = 0

			if var_512_10 < arg_509_1.time_ and arg_509_1.time_ <= var_512_10 + arg_512_0 and not isNil(var_512_9) and arg_509_1.var_.characterEffect1011ui_story == nil then
				arg_509_1.var_.characterEffect1011ui_story = var_512_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_512_11 = 0.200000002980232

			if var_512_10 <= arg_509_1.time_ and arg_509_1.time_ < var_512_10 + var_512_11 and not isNil(var_512_9) then
				local var_512_12 = (arg_509_1.time_ - var_512_10) / var_512_11

				if arg_509_1.var_.characterEffect1011ui_story and not isNil(var_512_9) then
					arg_509_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_509_1.time_ >= var_512_10 + var_512_11 and arg_509_1.time_ < var_512_10 + var_512_11 + arg_512_0 and not isNil(var_512_9) and arg_509_1.var_.characterEffect1011ui_story then
				arg_509_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_512_13 = 0

			if var_512_13 < arg_509_1.time_ and arg_509_1.time_ <= var_512_13 + arg_512_0 then
				arg_509_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action5_2")
			end

			local var_512_14 = 0

			if var_512_14 < arg_509_1.time_ and arg_509_1.time_ <= var_512_14 + arg_512_0 then
				arg_509_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_512_15 = 0
			local var_512_16 = 0.7

			if var_512_15 < arg_509_1.time_ and arg_509_1.time_ <= var_512_15 + arg_512_0 then
				arg_509_1.talkMaxDuration = 0
				arg_509_1.dialogCg_.alpha = 1

				arg_509_1.dialog_:SetActive(true)
				SetActive(arg_509_1.leftNameGo_, true)

				local var_512_17 = arg_509_1:FormatText(StoryNameCfg[37].name)

				arg_509_1.leftNameTxt_.text = var_512_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_509_1.leftNameTxt_.transform)

				arg_509_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_509_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_509_1:RecordName(arg_509_1.leftNameTxt_.text)
				SetActive(arg_509_1.iconTrs_.gameObject, false)
				arg_509_1.callingController_:SetSelectedState("normal")

				local var_512_18 = arg_509_1:GetWordFromCfg(1101105123)
				local var_512_19 = arg_509_1:FormatText(var_512_18.content)

				arg_509_1.text_.text = var_512_19

				LuaForUtil.ClearLinePrefixSymbol(arg_509_1.text_)

				local var_512_20 = 28
				local var_512_21 = utf8.len(var_512_19)
				local var_512_22 = var_512_20 <= 0 and var_512_16 or var_512_16 * (var_512_21 / var_512_20)

				if var_512_22 > 0 and var_512_16 < var_512_22 then
					arg_509_1.talkMaxDuration = var_512_22

					if var_512_22 + var_512_15 > arg_509_1.duration_ then
						arg_509_1.duration_ = var_512_22 + var_512_15
					end
				end

				arg_509_1.text_.text = var_512_19
				arg_509_1.typewritter.percent = 0

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105123", "story_v_side_new_1101105.awb") ~= 0 then
					local var_512_23 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105123", "story_v_side_new_1101105.awb") / 1000

					if var_512_23 + var_512_15 > arg_509_1.duration_ then
						arg_509_1.duration_ = var_512_23 + var_512_15
					end

					if var_512_18.prefab_name ~= "" and arg_509_1.actors_[var_512_18.prefab_name] ~= nil then
						local var_512_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_509_1.actors_[var_512_18.prefab_name].transform, "story_v_side_new_1101105", "1101105123", "story_v_side_new_1101105.awb")

						arg_509_1:RecordAudio("1101105123", var_512_24)
						arg_509_1:RecordAudio("1101105123", var_512_24)
					else
						arg_509_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105123", "story_v_side_new_1101105.awb")
					end

					arg_509_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105123", "story_v_side_new_1101105.awb")
				end

				arg_509_1:RecordContent(arg_509_1.text_.text)
			end

			local var_512_25 = math.max(var_512_16, arg_509_1.talkMaxDuration)

			if var_512_15 <= arg_509_1.time_ and arg_509_1.time_ < var_512_15 + var_512_25 then
				arg_509_1.typewritter.percent = (arg_509_1.time_ - var_512_15) / var_512_25

				arg_509_1.typewritter:SetDirty()
			end

			if arg_509_1.time_ >= var_512_15 + var_512_25 and arg_509_1.time_ < var_512_15 + var_512_25 + arg_512_0 then
				arg_509_1.typewritter.percent = 1

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(true)
			end
		end

		arg_509_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_509_1:InitPlayNodeList()
	end,
	Play1101105124 = function(arg_513_0, arg_513_1)
		arg_513_1.time_ = 0
		arg_513_1.frameCnt_ = 0
		arg_513_1.state_ = "playing"
		arg_513_1.curTalkId_ = 1101105124
		arg_513_1.duration_ = 5

		SetActive(arg_513_1.tipsGo_, false)

		function arg_513_1.onSingleLineFinish_()
			arg_513_1.onSingleLineUpdate_ = nil
			arg_513_1.onSingleLineFinish_ = nil
			arg_513_1.state_ = "waiting"
		end

		function arg_513_1.playNext_(arg_515_0)
			if arg_515_0 == 1 then
				arg_513_0:Play1101105125(arg_513_1)
			end
		end

		function arg_513_1.onSingleLineUpdate_(arg_516_0)
			local var_516_0 = arg_513_1.actors_["1011ui_story"]
			local var_516_1 = 0

			if var_516_1 < arg_513_1.time_ and arg_513_1.time_ <= var_516_1 + arg_516_0 and not isNil(var_516_0) and arg_513_1.var_.characterEffect1011ui_story == nil then
				arg_513_1.var_.characterEffect1011ui_story = var_516_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_516_2 = 0.200000002980232

			if var_516_1 <= arg_513_1.time_ and arg_513_1.time_ < var_516_1 + var_516_2 and not isNil(var_516_0) then
				local var_516_3 = (arg_513_1.time_ - var_516_1) / var_516_2

				if arg_513_1.var_.characterEffect1011ui_story and not isNil(var_516_0) then
					local var_516_4 = Mathf.Lerp(0, 0.5, var_516_3)

					arg_513_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_513_1.var_.characterEffect1011ui_story.fillRatio = var_516_4
				end
			end

			if arg_513_1.time_ >= var_516_1 + var_516_2 and arg_513_1.time_ < var_516_1 + var_516_2 + arg_516_0 and not isNil(var_516_0) and arg_513_1.var_.characterEffect1011ui_story then
				local var_516_5 = 0.5

				arg_513_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_513_1.var_.characterEffect1011ui_story.fillRatio = var_516_5
			end

			local var_516_6 = 0
			local var_516_7 = 0.675

			if var_516_6 < arg_513_1.time_ and arg_513_1.time_ <= var_516_6 + arg_516_0 then
				arg_513_1.talkMaxDuration = 0
				arg_513_1.dialogCg_.alpha = 1

				arg_513_1.dialog_:SetActive(true)
				SetActive(arg_513_1.leftNameGo_, false)

				arg_513_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_513_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_513_1:RecordName(arg_513_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_513_1.iconTrs_.gameObject, false)
				arg_513_1.callingController_:SetSelectedState("normal")

				local var_516_8 = arg_513_1:GetWordFromCfg(1101105124)
				local var_516_9 = arg_513_1:FormatText(var_516_8.content)

				arg_513_1.text_.text = var_516_9

				LuaForUtil.ClearLinePrefixSymbol(arg_513_1.text_)

				local var_516_10 = 27
				local var_516_11 = utf8.len(var_516_9)
				local var_516_12 = var_516_10 <= 0 and var_516_7 or var_516_7 * (var_516_11 / var_516_10)

				if var_516_12 > 0 and var_516_7 < var_516_12 then
					arg_513_1.talkMaxDuration = var_516_12

					if var_516_12 + var_516_6 > arg_513_1.duration_ then
						arg_513_1.duration_ = var_516_12 + var_516_6
					end
				end

				arg_513_1.text_.text = var_516_9
				arg_513_1.typewritter.percent = 0

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(false)
				arg_513_1:RecordContent(arg_513_1.text_.text)
			end

			local var_516_13 = math.max(var_516_7, arg_513_1.talkMaxDuration)

			if var_516_6 <= arg_513_1.time_ and arg_513_1.time_ < var_516_6 + var_516_13 then
				arg_513_1.typewritter.percent = (arg_513_1.time_ - var_516_6) / var_516_13

				arg_513_1.typewritter:SetDirty()
			end

			if arg_513_1.time_ >= var_516_6 + var_516_13 and arg_513_1.time_ < var_516_6 + var_516_13 + arg_516_0 then
				arg_513_1.typewritter.percent = 1

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(true)
			end
		end

		arg_513_1.nodeConfigList_ = {}

		arg_513_1:InitPlayNodeList()
	end,
	Play1101105125 = function(arg_517_0, arg_517_1)
		arg_517_1.time_ = 0
		arg_517_1.frameCnt_ = 0
		arg_517_1.state_ = "playing"
		arg_517_1.curTalkId_ = 1101105125
		arg_517_1.duration_ = 5

		SetActive(arg_517_1.tipsGo_, false)

		function arg_517_1.onSingleLineFinish_()
			arg_517_1.onSingleLineUpdate_ = nil
			arg_517_1.onSingleLineFinish_ = nil
			arg_517_1.state_ = "waiting"
		end

		function arg_517_1.playNext_(arg_519_0)
			if arg_519_0 == 1 then
				arg_517_0:Play1101105126(arg_517_1)
			end
		end

		function arg_517_1.onSingleLineUpdate_(arg_520_0)
			local var_520_0 = 0
			local var_520_1 = 0.5

			if var_520_0 < arg_517_1.time_ and arg_517_1.time_ <= var_520_0 + arg_520_0 then
				arg_517_1.talkMaxDuration = 0
				arg_517_1.dialogCg_.alpha = 1

				arg_517_1.dialog_:SetActive(true)
				SetActive(arg_517_1.leftNameGo_, true)

				local var_520_2 = arg_517_1:FormatText(StoryNameCfg[7].name)

				arg_517_1.leftNameTxt_.text = var_520_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_517_1.leftNameTxt_.transform)

				arg_517_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_517_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_517_1:RecordName(arg_517_1.leftNameTxt_.text)
				SetActive(arg_517_1.iconTrs_.gameObject, true)
				arg_517_1.iconController_:SetSelectedState("hero")

				arg_517_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_517_1.callingController_:SetSelectedState("normal")

				arg_517_1.keyicon_.color = Color.New(1, 1, 1)
				arg_517_1.icon_.color = Color.New(1, 1, 1)

				local var_520_3 = arg_517_1:GetWordFromCfg(1101105125)
				local var_520_4 = arg_517_1:FormatText(var_520_3.content)

				arg_517_1.text_.text = var_520_4

				LuaForUtil.ClearLinePrefixSymbol(arg_517_1.text_)

				local var_520_5 = 20
				local var_520_6 = utf8.len(var_520_4)
				local var_520_7 = var_520_5 <= 0 and var_520_1 or var_520_1 * (var_520_6 / var_520_5)

				if var_520_7 > 0 and var_520_1 < var_520_7 then
					arg_517_1.talkMaxDuration = var_520_7

					if var_520_7 + var_520_0 > arg_517_1.duration_ then
						arg_517_1.duration_ = var_520_7 + var_520_0
					end
				end

				arg_517_1.text_.text = var_520_4
				arg_517_1.typewritter.percent = 0

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(false)
				arg_517_1:RecordContent(arg_517_1.text_.text)
			end

			local var_520_8 = math.max(var_520_1, arg_517_1.talkMaxDuration)

			if var_520_0 <= arg_517_1.time_ and arg_517_1.time_ < var_520_0 + var_520_8 then
				arg_517_1.typewritter.percent = (arg_517_1.time_ - var_520_0) / var_520_8

				arg_517_1.typewritter:SetDirty()
			end

			if arg_517_1.time_ >= var_520_0 + var_520_8 and arg_517_1.time_ < var_520_0 + var_520_8 + arg_520_0 then
				arg_517_1.typewritter.percent = 1

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(true)
			end
		end

		arg_517_1.nodeConfigList_ = {}

		arg_517_1:InitPlayNodeList()
	end,
	Play1101105126 = function(arg_521_0, arg_521_1)
		arg_521_1.time_ = 0
		arg_521_1.frameCnt_ = 0
		arg_521_1.state_ = "playing"
		arg_521_1.curTalkId_ = 1101105126
		arg_521_1.duration_ = 16.63

		local var_521_0 = {
			zh = 8.766,
			ja = 16.633
		}
		local var_521_1 = manager.audio:GetLocalizationFlag()

		if var_521_0[var_521_1] ~= nil then
			arg_521_1.duration_ = var_521_0[var_521_1]
		end

		SetActive(arg_521_1.tipsGo_, false)

		function arg_521_1.onSingleLineFinish_()
			arg_521_1.onSingleLineUpdate_ = nil
			arg_521_1.onSingleLineFinish_ = nil
			arg_521_1.state_ = "waiting"
		end

		function arg_521_1.playNext_(arg_523_0)
			if arg_523_0 == 1 then
				arg_521_0:Play1101105127(arg_521_1)
			end
		end

		function arg_521_1.onSingleLineUpdate_(arg_524_0)
			local var_524_0 = arg_521_1.actors_["1011ui_story"].transform
			local var_524_1 = 0

			if var_524_1 < arg_521_1.time_ and arg_521_1.time_ <= var_524_1 + arg_524_0 then
				arg_521_1.var_.moveOldPos1011ui_story = var_524_0.localPosition
			end

			local var_524_2 = 0.001

			if var_524_1 <= arg_521_1.time_ and arg_521_1.time_ < var_524_1 + var_524_2 then
				local var_524_3 = (arg_521_1.time_ - var_524_1) / var_524_2
				local var_524_4 = Vector3.New(0, -0.71, -6)

				var_524_0.localPosition = Vector3.Lerp(arg_521_1.var_.moveOldPos1011ui_story, var_524_4, var_524_3)

				local var_524_5 = manager.ui.mainCamera.transform.position - var_524_0.position

				var_524_0.forward = Vector3.New(var_524_5.x, var_524_5.y, var_524_5.z)

				local var_524_6 = var_524_0.localEulerAngles

				var_524_6.z = 0
				var_524_6.x = 0
				var_524_0.localEulerAngles = var_524_6
			end

			if arg_521_1.time_ >= var_524_1 + var_524_2 and arg_521_1.time_ < var_524_1 + var_524_2 + arg_524_0 then
				var_524_0.localPosition = Vector3.New(0, -0.71, -6)

				local var_524_7 = manager.ui.mainCamera.transform.position - var_524_0.position

				var_524_0.forward = Vector3.New(var_524_7.x, var_524_7.y, var_524_7.z)

				local var_524_8 = var_524_0.localEulerAngles

				var_524_8.z = 0
				var_524_8.x = 0
				var_524_0.localEulerAngles = var_524_8
			end

			local var_524_9 = arg_521_1.actors_["1011ui_story"]
			local var_524_10 = 0

			if var_524_10 < arg_521_1.time_ and arg_521_1.time_ <= var_524_10 + arg_524_0 and not isNil(var_524_9) and arg_521_1.var_.characterEffect1011ui_story == nil then
				arg_521_1.var_.characterEffect1011ui_story = var_524_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_524_11 = 0.200000002980232

			if var_524_10 <= arg_521_1.time_ and arg_521_1.time_ < var_524_10 + var_524_11 and not isNil(var_524_9) then
				local var_524_12 = (arg_521_1.time_ - var_524_10) / var_524_11

				if arg_521_1.var_.characterEffect1011ui_story and not isNil(var_524_9) then
					arg_521_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_521_1.time_ >= var_524_10 + var_524_11 and arg_521_1.time_ < var_524_10 + var_524_11 + arg_524_0 and not isNil(var_524_9) and arg_521_1.var_.characterEffect1011ui_story then
				arg_521_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_524_13 = 0

			if var_524_13 < arg_521_1.time_ and arg_521_1.time_ <= var_524_13 + arg_524_0 then
				arg_521_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action1_1")
			end

			local var_524_14 = 0

			if var_524_14 < arg_521_1.time_ and arg_521_1.time_ <= var_524_14 + arg_524_0 then
				arg_521_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_524_15 = 0
			local var_524_16 = 0.875

			if var_524_15 < arg_521_1.time_ and arg_521_1.time_ <= var_524_15 + arg_524_0 then
				arg_521_1.talkMaxDuration = 0
				arg_521_1.dialogCg_.alpha = 1

				arg_521_1.dialog_:SetActive(true)
				SetActive(arg_521_1.leftNameGo_, true)

				local var_524_17 = arg_521_1:FormatText(StoryNameCfg[37].name)

				arg_521_1.leftNameTxt_.text = var_524_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_521_1.leftNameTxt_.transform)

				arg_521_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_521_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_521_1:RecordName(arg_521_1.leftNameTxt_.text)
				SetActive(arg_521_1.iconTrs_.gameObject, false)
				arg_521_1.callingController_:SetSelectedState("normal")

				local var_524_18 = arg_521_1:GetWordFromCfg(1101105126)
				local var_524_19 = arg_521_1:FormatText(var_524_18.content)

				arg_521_1.text_.text = var_524_19

				LuaForUtil.ClearLinePrefixSymbol(arg_521_1.text_)

				local var_524_20 = 35
				local var_524_21 = utf8.len(var_524_19)
				local var_524_22 = var_524_20 <= 0 and var_524_16 or var_524_16 * (var_524_21 / var_524_20)

				if var_524_22 > 0 and var_524_16 < var_524_22 then
					arg_521_1.talkMaxDuration = var_524_22

					if var_524_22 + var_524_15 > arg_521_1.duration_ then
						arg_521_1.duration_ = var_524_22 + var_524_15
					end
				end

				arg_521_1.text_.text = var_524_19
				arg_521_1.typewritter.percent = 0

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105126", "story_v_side_new_1101105.awb") ~= 0 then
					local var_524_23 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105126", "story_v_side_new_1101105.awb") / 1000

					if var_524_23 + var_524_15 > arg_521_1.duration_ then
						arg_521_1.duration_ = var_524_23 + var_524_15
					end

					if var_524_18.prefab_name ~= "" and arg_521_1.actors_[var_524_18.prefab_name] ~= nil then
						local var_524_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_521_1.actors_[var_524_18.prefab_name].transform, "story_v_side_new_1101105", "1101105126", "story_v_side_new_1101105.awb")

						arg_521_1:RecordAudio("1101105126", var_524_24)
						arg_521_1:RecordAudio("1101105126", var_524_24)
					else
						arg_521_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105126", "story_v_side_new_1101105.awb")
					end

					arg_521_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105126", "story_v_side_new_1101105.awb")
				end

				arg_521_1:RecordContent(arg_521_1.text_.text)
			end

			local var_524_25 = math.max(var_524_16, arg_521_1.talkMaxDuration)

			if var_524_15 <= arg_521_1.time_ and arg_521_1.time_ < var_524_15 + var_524_25 then
				arg_521_1.typewritter.percent = (arg_521_1.time_ - var_524_15) / var_524_25

				arg_521_1.typewritter:SetDirty()
			end

			if arg_521_1.time_ >= var_524_15 + var_524_25 and arg_521_1.time_ < var_524_15 + var_524_25 + arg_524_0 then
				arg_521_1.typewritter.percent = 1

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(true)
			end
		end

		arg_521_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_521_1:InitPlayNodeList()
	end,
	Play1101105127 = function(arg_525_0, arg_525_1)
		arg_525_1.time_ = 0
		arg_525_1.frameCnt_ = 0
		arg_525_1.state_ = "playing"
		arg_525_1.curTalkId_ = 1101105127
		arg_525_1.duration_ = 5

		SetActive(arg_525_1.tipsGo_, false)

		function arg_525_1.onSingleLineFinish_()
			arg_525_1.onSingleLineUpdate_ = nil
			arg_525_1.onSingleLineFinish_ = nil
			arg_525_1.state_ = "waiting"
		end

		function arg_525_1.playNext_(arg_527_0)
			if arg_527_0 == 1 then
				arg_525_0:Play1101105128(arg_525_1)
			end
		end

		function arg_525_1.onSingleLineUpdate_(arg_528_0)
			local var_528_0 = arg_525_1.actors_["1011ui_story"]
			local var_528_1 = 0

			if var_528_1 < arg_525_1.time_ and arg_525_1.time_ <= var_528_1 + arg_528_0 and not isNil(var_528_0) and arg_525_1.var_.characterEffect1011ui_story == nil then
				arg_525_1.var_.characterEffect1011ui_story = var_528_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_528_2 = 0.200000002980232

			if var_528_1 <= arg_525_1.time_ and arg_525_1.time_ < var_528_1 + var_528_2 and not isNil(var_528_0) then
				local var_528_3 = (arg_525_1.time_ - var_528_1) / var_528_2

				if arg_525_1.var_.characterEffect1011ui_story and not isNil(var_528_0) then
					local var_528_4 = Mathf.Lerp(0, 0.5, var_528_3)

					arg_525_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_525_1.var_.characterEffect1011ui_story.fillRatio = var_528_4
				end
			end

			if arg_525_1.time_ >= var_528_1 + var_528_2 and arg_525_1.time_ < var_528_1 + var_528_2 + arg_528_0 and not isNil(var_528_0) and arg_525_1.var_.characterEffect1011ui_story then
				local var_528_5 = 0.5

				arg_525_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_525_1.var_.characterEffect1011ui_story.fillRatio = var_528_5
			end

			local var_528_6 = 0
			local var_528_7 = 0.45

			if var_528_6 < arg_525_1.time_ and arg_525_1.time_ <= var_528_6 + arg_528_0 then
				arg_525_1.talkMaxDuration = 0
				arg_525_1.dialogCg_.alpha = 1

				arg_525_1.dialog_:SetActive(true)
				SetActive(arg_525_1.leftNameGo_, true)

				local var_528_8 = arg_525_1:FormatText(StoryNameCfg[7].name)

				arg_525_1.leftNameTxt_.text = var_528_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_525_1.leftNameTxt_.transform)

				arg_525_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_525_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_525_1:RecordName(arg_525_1.leftNameTxt_.text)
				SetActive(arg_525_1.iconTrs_.gameObject, true)
				arg_525_1.iconController_:SetSelectedState("hero")

				arg_525_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_525_1.callingController_:SetSelectedState("normal")

				arg_525_1.keyicon_.color = Color.New(1, 1, 1)
				arg_525_1.icon_.color = Color.New(1, 1, 1)

				local var_528_9 = arg_525_1:GetWordFromCfg(1101105127)
				local var_528_10 = arg_525_1:FormatText(var_528_9.content)

				arg_525_1.text_.text = var_528_10

				LuaForUtil.ClearLinePrefixSymbol(arg_525_1.text_)

				local var_528_11 = 18
				local var_528_12 = utf8.len(var_528_10)
				local var_528_13 = var_528_11 <= 0 and var_528_7 or var_528_7 * (var_528_12 / var_528_11)

				if var_528_13 > 0 and var_528_7 < var_528_13 then
					arg_525_1.talkMaxDuration = var_528_13

					if var_528_13 + var_528_6 > arg_525_1.duration_ then
						arg_525_1.duration_ = var_528_13 + var_528_6
					end
				end

				arg_525_1.text_.text = var_528_10
				arg_525_1.typewritter.percent = 0

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(false)
				arg_525_1:RecordContent(arg_525_1.text_.text)
			end

			local var_528_14 = math.max(var_528_7, arg_525_1.talkMaxDuration)

			if var_528_6 <= arg_525_1.time_ and arg_525_1.time_ < var_528_6 + var_528_14 then
				arg_525_1.typewritter.percent = (arg_525_1.time_ - var_528_6) / var_528_14

				arg_525_1.typewritter:SetDirty()
			end

			if arg_525_1.time_ >= var_528_6 + var_528_14 and arg_525_1.time_ < var_528_6 + var_528_14 + arg_528_0 then
				arg_525_1.typewritter.percent = 1

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(true)
			end
		end

		arg_525_1.nodeConfigList_ = {}

		arg_525_1:InitPlayNodeList()
	end,
	Play1101105128 = function(arg_529_0, arg_529_1)
		arg_529_1.time_ = 0
		arg_529_1.frameCnt_ = 0
		arg_529_1.state_ = "playing"
		arg_529_1.curTalkId_ = 1101105128
		arg_529_1.duration_ = 13.87

		local var_529_0 = {
			zh = 7.566,
			ja = 13.866
		}
		local var_529_1 = manager.audio:GetLocalizationFlag()

		if var_529_0[var_529_1] ~= nil then
			arg_529_1.duration_ = var_529_0[var_529_1]
		end

		SetActive(arg_529_1.tipsGo_, false)

		function arg_529_1.onSingleLineFinish_()
			arg_529_1.onSingleLineUpdate_ = nil
			arg_529_1.onSingleLineFinish_ = nil
			arg_529_1.state_ = "waiting"
		end

		function arg_529_1.playNext_(arg_531_0)
			if arg_531_0 == 1 then
				arg_529_0:Play1101105129(arg_529_1)
			end
		end

		function arg_529_1.onSingleLineUpdate_(arg_532_0)
			local var_532_0 = arg_529_1.actors_["1011ui_story"].transform
			local var_532_1 = 0

			if var_532_1 < arg_529_1.time_ and arg_529_1.time_ <= var_532_1 + arg_532_0 then
				arg_529_1.var_.moveOldPos1011ui_story = var_532_0.localPosition
			end

			local var_532_2 = 0.001

			if var_532_1 <= arg_529_1.time_ and arg_529_1.time_ < var_532_1 + var_532_2 then
				local var_532_3 = (arg_529_1.time_ - var_532_1) / var_532_2
				local var_532_4 = Vector3.New(0, -0.71, -6)

				var_532_0.localPosition = Vector3.Lerp(arg_529_1.var_.moveOldPos1011ui_story, var_532_4, var_532_3)

				local var_532_5 = manager.ui.mainCamera.transform.position - var_532_0.position

				var_532_0.forward = Vector3.New(var_532_5.x, var_532_5.y, var_532_5.z)

				local var_532_6 = var_532_0.localEulerAngles

				var_532_6.z = 0
				var_532_6.x = 0
				var_532_0.localEulerAngles = var_532_6
			end

			if arg_529_1.time_ >= var_532_1 + var_532_2 and arg_529_1.time_ < var_532_1 + var_532_2 + arg_532_0 then
				var_532_0.localPosition = Vector3.New(0, -0.71, -6)

				local var_532_7 = manager.ui.mainCamera.transform.position - var_532_0.position

				var_532_0.forward = Vector3.New(var_532_7.x, var_532_7.y, var_532_7.z)

				local var_532_8 = var_532_0.localEulerAngles

				var_532_8.z = 0
				var_532_8.x = 0
				var_532_0.localEulerAngles = var_532_8
			end

			local var_532_9 = arg_529_1.actors_["1011ui_story"]
			local var_532_10 = 0

			if var_532_10 < arg_529_1.time_ and arg_529_1.time_ <= var_532_10 + arg_532_0 and not isNil(var_532_9) and arg_529_1.var_.characterEffect1011ui_story == nil then
				arg_529_1.var_.characterEffect1011ui_story = var_532_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_532_11 = 0.200000002980232

			if var_532_10 <= arg_529_1.time_ and arg_529_1.time_ < var_532_10 + var_532_11 and not isNil(var_532_9) then
				local var_532_12 = (arg_529_1.time_ - var_532_10) / var_532_11

				if arg_529_1.var_.characterEffect1011ui_story and not isNil(var_532_9) then
					arg_529_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_529_1.time_ >= var_532_10 + var_532_11 and arg_529_1.time_ < var_532_10 + var_532_11 + arg_532_0 and not isNil(var_532_9) and arg_529_1.var_.characterEffect1011ui_story then
				arg_529_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_532_13 = 0

			if var_532_13 < arg_529_1.time_ and arg_529_1.time_ <= var_532_13 + arg_532_0 then
				arg_529_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action4_1")
			end

			local var_532_14 = 0

			if var_532_14 < arg_529_1.time_ and arg_529_1.time_ <= var_532_14 + arg_532_0 then
				arg_529_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_532_15 = 0
			local var_532_16 = 0.925

			if var_532_15 < arg_529_1.time_ and arg_529_1.time_ <= var_532_15 + arg_532_0 then
				arg_529_1.talkMaxDuration = 0
				arg_529_1.dialogCg_.alpha = 1

				arg_529_1.dialog_:SetActive(true)
				SetActive(arg_529_1.leftNameGo_, true)

				local var_532_17 = arg_529_1:FormatText(StoryNameCfg[37].name)

				arg_529_1.leftNameTxt_.text = var_532_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_529_1.leftNameTxt_.transform)

				arg_529_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_529_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_529_1:RecordName(arg_529_1.leftNameTxt_.text)
				SetActive(arg_529_1.iconTrs_.gameObject, false)
				arg_529_1.callingController_:SetSelectedState("normal")

				local var_532_18 = arg_529_1:GetWordFromCfg(1101105128)
				local var_532_19 = arg_529_1:FormatText(var_532_18.content)

				arg_529_1.text_.text = var_532_19

				LuaForUtil.ClearLinePrefixSymbol(arg_529_1.text_)

				local var_532_20 = 37
				local var_532_21 = utf8.len(var_532_19)
				local var_532_22 = var_532_20 <= 0 and var_532_16 or var_532_16 * (var_532_21 / var_532_20)

				if var_532_22 > 0 and var_532_16 < var_532_22 then
					arg_529_1.talkMaxDuration = var_532_22

					if var_532_22 + var_532_15 > arg_529_1.duration_ then
						arg_529_1.duration_ = var_532_22 + var_532_15
					end
				end

				arg_529_1.text_.text = var_532_19
				arg_529_1.typewritter.percent = 0

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105128", "story_v_side_new_1101105.awb") ~= 0 then
					local var_532_23 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105128", "story_v_side_new_1101105.awb") / 1000

					if var_532_23 + var_532_15 > arg_529_1.duration_ then
						arg_529_1.duration_ = var_532_23 + var_532_15
					end

					if var_532_18.prefab_name ~= "" and arg_529_1.actors_[var_532_18.prefab_name] ~= nil then
						local var_532_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_529_1.actors_[var_532_18.prefab_name].transform, "story_v_side_new_1101105", "1101105128", "story_v_side_new_1101105.awb")

						arg_529_1:RecordAudio("1101105128", var_532_24)
						arg_529_1:RecordAudio("1101105128", var_532_24)
					else
						arg_529_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105128", "story_v_side_new_1101105.awb")
					end

					arg_529_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105128", "story_v_side_new_1101105.awb")
				end

				arg_529_1:RecordContent(arg_529_1.text_.text)
			end

			local var_532_25 = math.max(var_532_16, arg_529_1.talkMaxDuration)

			if var_532_15 <= arg_529_1.time_ and arg_529_1.time_ < var_532_15 + var_532_25 then
				arg_529_1.typewritter.percent = (arg_529_1.time_ - var_532_15) / var_532_25

				arg_529_1.typewritter:SetDirty()
			end

			if arg_529_1.time_ >= var_532_15 + var_532_25 and arg_529_1.time_ < var_532_15 + var_532_25 + arg_532_0 then
				arg_529_1.typewritter.percent = 1

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(true)
			end
		end

		arg_529_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_529_1:InitPlayNodeList()
	end,
	Play1101105129 = function(arg_533_0, arg_533_1)
		arg_533_1.time_ = 0
		arg_533_1.frameCnt_ = 0
		arg_533_1.state_ = "playing"
		arg_533_1.curTalkId_ = 1101105129
		arg_533_1.duration_ = 5

		SetActive(arg_533_1.tipsGo_, false)

		function arg_533_1.onSingleLineFinish_()
			arg_533_1.onSingleLineUpdate_ = nil
			arg_533_1.onSingleLineFinish_ = nil
			arg_533_1.state_ = "waiting"
		end

		function arg_533_1.playNext_(arg_535_0)
			if arg_535_0 == 1 then
				arg_533_0:Play1101105130(arg_533_1)
			end
		end

		function arg_533_1.onSingleLineUpdate_(arg_536_0)
			local var_536_0 = arg_533_1.actors_["1011ui_story"]
			local var_536_1 = 0

			if var_536_1 < arg_533_1.time_ and arg_533_1.time_ <= var_536_1 + arg_536_0 and not isNil(var_536_0) and arg_533_1.var_.characterEffect1011ui_story == nil then
				arg_533_1.var_.characterEffect1011ui_story = var_536_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_536_2 = 0.200000002980232

			if var_536_1 <= arg_533_1.time_ and arg_533_1.time_ < var_536_1 + var_536_2 and not isNil(var_536_0) then
				local var_536_3 = (arg_533_1.time_ - var_536_1) / var_536_2

				if arg_533_1.var_.characterEffect1011ui_story and not isNil(var_536_0) then
					local var_536_4 = Mathf.Lerp(0, 0.5, var_536_3)

					arg_533_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_533_1.var_.characterEffect1011ui_story.fillRatio = var_536_4
				end
			end

			if arg_533_1.time_ >= var_536_1 + var_536_2 and arg_533_1.time_ < var_536_1 + var_536_2 + arg_536_0 and not isNil(var_536_0) and arg_533_1.var_.characterEffect1011ui_story then
				local var_536_5 = 0.5

				arg_533_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_533_1.var_.characterEffect1011ui_story.fillRatio = var_536_5
			end

			local var_536_6 = 0
			local var_536_7 = 0.175

			if var_536_6 < arg_533_1.time_ and arg_533_1.time_ <= var_536_6 + arg_536_0 then
				arg_533_1.talkMaxDuration = 0
				arg_533_1.dialogCg_.alpha = 1

				arg_533_1.dialog_:SetActive(true)
				SetActive(arg_533_1.leftNameGo_, true)

				local var_536_8 = arg_533_1:FormatText(StoryNameCfg[7].name)

				arg_533_1.leftNameTxt_.text = var_536_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_533_1.leftNameTxt_.transform)

				arg_533_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_533_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_533_1:RecordName(arg_533_1.leftNameTxt_.text)
				SetActive(arg_533_1.iconTrs_.gameObject, true)
				arg_533_1.iconController_:SetSelectedState("hero")

				arg_533_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_533_1.callingController_:SetSelectedState("normal")

				arg_533_1.keyicon_.color = Color.New(1, 1, 1)
				arg_533_1.icon_.color = Color.New(1, 1, 1)

				local var_536_9 = arg_533_1:GetWordFromCfg(1101105129)
				local var_536_10 = arg_533_1:FormatText(var_536_9.content)

				arg_533_1.text_.text = var_536_10

				LuaForUtil.ClearLinePrefixSymbol(arg_533_1.text_)

				local var_536_11 = 7
				local var_536_12 = utf8.len(var_536_10)
				local var_536_13 = var_536_11 <= 0 and var_536_7 or var_536_7 * (var_536_12 / var_536_11)

				if var_536_13 > 0 and var_536_7 < var_536_13 then
					arg_533_1.talkMaxDuration = var_536_13

					if var_536_13 + var_536_6 > arg_533_1.duration_ then
						arg_533_1.duration_ = var_536_13 + var_536_6
					end
				end

				arg_533_1.text_.text = var_536_10
				arg_533_1.typewritter.percent = 0

				arg_533_1.typewritter:SetDirty()
				arg_533_1:ShowNextGo(false)
				arg_533_1:RecordContent(arg_533_1.text_.text)
			end

			local var_536_14 = math.max(var_536_7, arg_533_1.talkMaxDuration)

			if var_536_6 <= arg_533_1.time_ and arg_533_1.time_ < var_536_6 + var_536_14 then
				arg_533_1.typewritter.percent = (arg_533_1.time_ - var_536_6) / var_536_14

				arg_533_1.typewritter:SetDirty()
			end

			if arg_533_1.time_ >= var_536_6 + var_536_14 and arg_533_1.time_ < var_536_6 + var_536_14 + arg_536_0 then
				arg_533_1.typewritter.percent = 1

				arg_533_1.typewritter:SetDirty()
				arg_533_1:ShowNextGo(true)
			end
		end

		arg_533_1.nodeConfigList_ = {}

		arg_533_1:InitPlayNodeList()
	end,
	Play1101105130 = function(arg_537_0, arg_537_1)
		arg_537_1.time_ = 0
		arg_537_1.frameCnt_ = 0
		arg_537_1.state_ = "playing"
		arg_537_1.curTalkId_ = 1101105130
		arg_537_1.duration_ = 5

		SetActive(arg_537_1.tipsGo_, false)

		function arg_537_1.onSingleLineFinish_()
			arg_537_1.onSingleLineUpdate_ = nil
			arg_537_1.onSingleLineFinish_ = nil
			arg_537_1.state_ = "waiting"
		end

		function arg_537_1.playNext_(arg_539_0)
			if arg_539_0 == 1 then
				arg_537_0:Play1101105131(arg_537_1)
			end
		end

		function arg_537_1.onSingleLineUpdate_(arg_540_0)
			local var_540_0 = 0
			local var_540_1 = 0.625

			if var_540_0 < arg_537_1.time_ and arg_537_1.time_ <= var_540_0 + arg_540_0 then
				arg_537_1.talkMaxDuration = 0
				arg_537_1.dialogCg_.alpha = 1

				arg_537_1.dialog_:SetActive(true)
				SetActive(arg_537_1.leftNameGo_, true)

				local var_540_2 = arg_537_1:FormatText(StoryNameCfg[7].name)

				arg_537_1.leftNameTxt_.text = var_540_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_537_1.leftNameTxt_.transform)

				arg_537_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_537_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_537_1:RecordName(arg_537_1.leftNameTxt_.text)
				SetActive(arg_537_1.iconTrs_.gameObject, true)
				arg_537_1.iconController_:SetSelectedState("hero")

				arg_537_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_537_1.callingController_:SetSelectedState("normal")

				arg_537_1.keyicon_.color = Color.New(1, 1, 1)
				arg_537_1.icon_.color = Color.New(1, 1, 1)

				local var_540_3 = arg_537_1:GetWordFromCfg(1101105130)
				local var_540_4 = arg_537_1:FormatText(var_540_3.content)

				arg_537_1.text_.text = var_540_4

				LuaForUtil.ClearLinePrefixSymbol(arg_537_1.text_)

				local var_540_5 = 25
				local var_540_6 = utf8.len(var_540_4)
				local var_540_7 = var_540_5 <= 0 and var_540_1 or var_540_1 * (var_540_6 / var_540_5)

				if var_540_7 > 0 and var_540_1 < var_540_7 then
					arg_537_1.talkMaxDuration = var_540_7

					if var_540_7 + var_540_0 > arg_537_1.duration_ then
						arg_537_1.duration_ = var_540_7 + var_540_0
					end
				end

				arg_537_1.text_.text = var_540_4
				arg_537_1.typewritter.percent = 0

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(false)
				arg_537_1:RecordContent(arg_537_1.text_.text)
			end

			local var_540_8 = math.max(var_540_1, arg_537_1.talkMaxDuration)

			if var_540_0 <= arg_537_1.time_ and arg_537_1.time_ < var_540_0 + var_540_8 then
				arg_537_1.typewritter.percent = (arg_537_1.time_ - var_540_0) / var_540_8

				arg_537_1.typewritter:SetDirty()
			end

			if arg_537_1.time_ >= var_540_0 + var_540_8 and arg_537_1.time_ < var_540_0 + var_540_8 + arg_540_0 then
				arg_537_1.typewritter.percent = 1

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(true)
			end
		end

		arg_537_1.nodeConfigList_ = {}

		arg_537_1:InitPlayNodeList()
	end,
	Play1101105131 = function(arg_541_0, arg_541_1)
		arg_541_1.time_ = 0
		arg_541_1.frameCnt_ = 0
		arg_541_1.state_ = "playing"
		arg_541_1.curTalkId_ = 1101105131
		arg_541_1.duration_ = 6.67

		local var_541_0 = {
			zh = 6.666,
			ja = 4.766
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
				arg_541_0:Play1101105132(arg_541_1)
			end
		end

		function arg_541_1.onSingleLineUpdate_(arg_544_0)
			local var_544_0 = arg_541_1.actors_["1011ui_story"].transform
			local var_544_1 = 0

			if var_544_1 < arg_541_1.time_ and arg_541_1.time_ <= var_544_1 + arg_544_0 then
				arg_541_1.var_.moveOldPos1011ui_story = var_544_0.localPosition
			end

			local var_544_2 = 0.001

			if var_544_1 <= arg_541_1.time_ and arg_541_1.time_ < var_544_1 + var_544_2 then
				local var_544_3 = (arg_541_1.time_ - var_544_1) / var_544_2
				local var_544_4 = Vector3.New(0, -0.71, -6)

				var_544_0.localPosition = Vector3.Lerp(arg_541_1.var_.moveOldPos1011ui_story, var_544_4, var_544_3)

				local var_544_5 = manager.ui.mainCamera.transform.position - var_544_0.position

				var_544_0.forward = Vector3.New(var_544_5.x, var_544_5.y, var_544_5.z)

				local var_544_6 = var_544_0.localEulerAngles

				var_544_6.z = 0
				var_544_6.x = 0
				var_544_0.localEulerAngles = var_544_6
			end

			if arg_541_1.time_ >= var_544_1 + var_544_2 and arg_541_1.time_ < var_544_1 + var_544_2 + arg_544_0 then
				var_544_0.localPosition = Vector3.New(0, -0.71, -6)

				local var_544_7 = manager.ui.mainCamera.transform.position - var_544_0.position

				var_544_0.forward = Vector3.New(var_544_7.x, var_544_7.y, var_544_7.z)

				local var_544_8 = var_544_0.localEulerAngles

				var_544_8.z = 0
				var_544_8.x = 0
				var_544_0.localEulerAngles = var_544_8
			end

			local var_544_9 = arg_541_1.actors_["1011ui_story"]
			local var_544_10 = 0

			if var_544_10 < arg_541_1.time_ and arg_541_1.time_ <= var_544_10 + arg_544_0 and not isNil(var_544_9) and arg_541_1.var_.characterEffect1011ui_story == nil then
				arg_541_1.var_.characterEffect1011ui_story = var_544_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_544_11 = 0.200000002980232

			if var_544_10 <= arg_541_1.time_ and arg_541_1.time_ < var_544_10 + var_544_11 and not isNil(var_544_9) then
				local var_544_12 = (arg_541_1.time_ - var_544_10) / var_544_11

				if arg_541_1.var_.characterEffect1011ui_story and not isNil(var_544_9) then
					arg_541_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_541_1.time_ >= var_544_10 + var_544_11 and arg_541_1.time_ < var_544_10 + var_544_11 + arg_544_0 and not isNil(var_544_9) and arg_541_1.var_.characterEffect1011ui_story then
				arg_541_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_544_13 = 0

			if var_544_13 < arg_541_1.time_ and arg_541_1.time_ <= var_544_13 + arg_544_0 then
				arg_541_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011actionlink/1011action447")
			end

			local var_544_14 = 0

			if var_544_14 < arg_541_1.time_ and arg_541_1.time_ <= var_544_14 + arg_544_0 then
				arg_541_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_544_15 = 0
			local var_544_16 = 0.8

			if var_544_15 < arg_541_1.time_ and arg_541_1.time_ <= var_544_15 + arg_544_0 then
				arg_541_1.talkMaxDuration = 0
				arg_541_1.dialogCg_.alpha = 1

				arg_541_1.dialog_:SetActive(true)
				SetActive(arg_541_1.leftNameGo_, true)

				local var_544_17 = arg_541_1:FormatText(StoryNameCfg[37].name)

				arg_541_1.leftNameTxt_.text = var_544_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_541_1.leftNameTxt_.transform)

				arg_541_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_541_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_541_1:RecordName(arg_541_1.leftNameTxt_.text)
				SetActive(arg_541_1.iconTrs_.gameObject, false)
				arg_541_1.callingController_:SetSelectedState("normal")

				local var_544_18 = arg_541_1:GetWordFromCfg(1101105131)
				local var_544_19 = arg_541_1:FormatText(var_544_18.content)

				arg_541_1.text_.text = var_544_19

				LuaForUtil.ClearLinePrefixSymbol(arg_541_1.text_)

				local var_544_20 = 32
				local var_544_21 = utf8.len(var_544_19)
				local var_544_22 = var_544_20 <= 0 and var_544_16 or var_544_16 * (var_544_21 / var_544_20)

				if var_544_22 > 0 and var_544_16 < var_544_22 then
					arg_541_1.talkMaxDuration = var_544_22

					if var_544_22 + var_544_15 > arg_541_1.duration_ then
						arg_541_1.duration_ = var_544_22 + var_544_15
					end
				end

				arg_541_1.text_.text = var_544_19
				arg_541_1.typewritter.percent = 0

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105131", "story_v_side_new_1101105.awb") ~= 0 then
					local var_544_23 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105131", "story_v_side_new_1101105.awb") / 1000

					if var_544_23 + var_544_15 > arg_541_1.duration_ then
						arg_541_1.duration_ = var_544_23 + var_544_15
					end

					if var_544_18.prefab_name ~= "" and arg_541_1.actors_[var_544_18.prefab_name] ~= nil then
						local var_544_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_541_1.actors_[var_544_18.prefab_name].transform, "story_v_side_new_1101105", "1101105131", "story_v_side_new_1101105.awb")

						arg_541_1:RecordAudio("1101105131", var_544_24)
						arg_541_1:RecordAudio("1101105131", var_544_24)
					else
						arg_541_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105131", "story_v_side_new_1101105.awb")
					end

					arg_541_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105131", "story_v_side_new_1101105.awb")
				end

				arg_541_1:RecordContent(arg_541_1.text_.text)
			end

			local var_544_25 = math.max(var_544_16, arg_541_1.talkMaxDuration)

			if var_544_15 <= arg_541_1.time_ and arg_541_1.time_ < var_544_15 + var_544_25 then
				arg_541_1.typewritter.percent = (arg_541_1.time_ - var_544_15) / var_544_25

				arg_541_1.typewritter:SetDirty()
			end

			if arg_541_1.time_ >= var_544_15 + var_544_25 and arg_541_1.time_ < var_544_15 + var_544_25 + arg_544_0 then
				arg_541_1.typewritter.percent = 1

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(true)
			end
		end

		arg_541_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_541_1:InitPlayNodeList()
	end,
	Play1101105132 = function(arg_545_0, arg_545_1)
		arg_545_1.time_ = 0
		arg_545_1.frameCnt_ = 0
		arg_545_1.state_ = "playing"
		arg_545_1.curTalkId_ = 1101105132
		arg_545_1.duration_ = 7.9

		local var_545_0 = {
			zh = 6.5,
			ja = 7.9
		}
		local var_545_1 = manager.audio:GetLocalizationFlag()

		if var_545_0[var_545_1] ~= nil then
			arg_545_1.duration_ = var_545_0[var_545_1]
		end

		SetActive(arg_545_1.tipsGo_, false)

		function arg_545_1.onSingleLineFinish_()
			arg_545_1.onSingleLineUpdate_ = nil
			arg_545_1.onSingleLineFinish_ = nil
			arg_545_1.state_ = "waiting"
		end

		function arg_545_1.playNext_(arg_547_0)
			if arg_547_0 == 1 then
				arg_545_0:Play1101105133(arg_545_1)
			end
		end

		function arg_545_1.onSingleLineUpdate_(arg_548_0)
			local var_548_0 = arg_545_1.actors_["1011ui_story"].transform
			local var_548_1 = 0

			if var_548_1 < arg_545_1.time_ and arg_545_1.time_ <= var_548_1 + arg_548_0 then
				arg_545_1.var_.moveOldPos1011ui_story = var_548_0.localPosition
			end

			local var_548_2 = 0.001

			if var_548_1 <= arg_545_1.time_ and arg_545_1.time_ < var_548_1 + var_548_2 then
				local var_548_3 = (arg_545_1.time_ - var_548_1) / var_548_2
				local var_548_4 = Vector3.New(0, -0.71, -6)

				var_548_0.localPosition = Vector3.Lerp(arg_545_1.var_.moveOldPos1011ui_story, var_548_4, var_548_3)

				local var_548_5 = manager.ui.mainCamera.transform.position - var_548_0.position

				var_548_0.forward = Vector3.New(var_548_5.x, var_548_5.y, var_548_5.z)

				local var_548_6 = var_548_0.localEulerAngles

				var_548_6.z = 0
				var_548_6.x = 0
				var_548_0.localEulerAngles = var_548_6
			end

			if arg_545_1.time_ >= var_548_1 + var_548_2 and arg_545_1.time_ < var_548_1 + var_548_2 + arg_548_0 then
				var_548_0.localPosition = Vector3.New(0, -0.71, -6)

				local var_548_7 = manager.ui.mainCamera.transform.position - var_548_0.position

				var_548_0.forward = Vector3.New(var_548_7.x, var_548_7.y, var_548_7.z)

				local var_548_8 = var_548_0.localEulerAngles

				var_548_8.z = 0
				var_548_8.x = 0
				var_548_0.localEulerAngles = var_548_8
			end

			local var_548_9 = arg_545_1.actors_["1011ui_story"]
			local var_548_10 = 0

			if var_548_10 < arg_545_1.time_ and arg_545_1.time_ <= var_548_10 + arg_548_0 and not isNil(var_548_9) and arg_545_1.var_.characterEffect1011ui_story == nil then
				arg_545_1.var_.characterEffect1011ui_story = var_548_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_548_11 = 0.200000002980232

			if var_548_10 <= arg_545_1.time_ and arg_545_1.time_ < var_548_10 + var_548_11 and not isNil(var_548_9) then
				local var_548_12 = (arg_545_1.time_ - var_548_10) / var_548_11

				if arg_545_1.var_.characterEffect1011ui_story and not isNil(var_548_9) then
					arg_545_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_545_1.time_ >= var_548_10 + var_548_11 and arg_545_1.time_ < var_548_10 + var_548_11 + arg_548_0 and not isNil(var_548_9) and arg_545_1.var_.characterEffect1011ui_story then
				arg_545_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_548_13 = 0

			if var_548_13 < arg_545_1.time_ and arg_545_1.time_ <= var_548_13 + arg_548_0 then
				arg_545_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action7_2")
			end

			local var_548_14 = 0

			if var_548_14 < arg_545_1.time_ and arg_545_1.time_ <= var_548_14 + arg_548_0 then
				arg_545_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_548_15 = 0
			local var_548_16 = 0.725

			if var_548_15 < arg_545_1.time_ and arg_545_1.time_ <= var_548_15 + arg_548_0 then
				arg_545_1.talkMaxDuration = 0
				arg_545_1.dialogCg_.alpha = 1

				arg_545_1.dialog_:SetActive(true)
				SetActive(arg_545_1.leftNameGo_, true)

				local var_548_17 = arg_545_1:FormatText(StoryNameCfg[37].name)

				arg_545_1.leftNameTxt_.text = var_548_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_545_1.leftNameTxt_.transform)

				arg_545_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_545_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_545_1:RecordName(arg_545_1.leftNameTxt_.text)
				SetActive(arg_545_1.iconTrs_.gameObject, false)
				arg_545_1.callingController_:SetSelectedState("normal")

				local var_548_18 = arg_545_1:GetWordFromCfg(1101105132)
				local var_548_19 = arg_545_1:FormatText(var_548_18.content)

				arg_545_1.text_.text = var_548_19

				LuaForUtil.ClearLinePrefixSymbol(arg_545_1.text_)

				local var_548_20 = 27
				local var_548_21 = utf8.len(var_548_19)
				local var_548_22 = var_548_20 <= 0 and var_548_16 or var_548_16 * (var_548_21 / var_548_20)

				if var_548_22 > 0 and var_548_16 < var_548_22 then
					arg_545_1.talkMaxDuration = var_548_22

					if var_548_22 + var_548_15 > arg_545_1.duration_ then
						arg_545_1.duration_ = var_548_22 + var_548_15
					end
				end

				arg_545_1.text_.text = var_548_19
				arg_545_1.typewritter.percent = 0

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105132", "story_v_side_new_1101105.awb") ~= 0 then
					local var_548_23 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105132", "story_v_side_new_1101105.awb") / 1000

					if var_548_23 + var_548_15 > arg_545_1.duration_ then
						arg_545_1.duration_ = var_548_23 + var_548_15
					end

					if var_548_18.prefab_name ~= "" and arg_545_1.actors_[var_548_18.prefab_name] ~= nil then
						local var_548_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_545_1.actors_[var_548_18.prefab_name].transform, "story_v_side_new_1101105", "1101105132", "story_v_side_new_1101105.awb")

						arg_545_1:RecordAudio("1101105132", var_548_24)
						arg_545_1:RecordAudio("1101105132", var_548_24)
					else
						arg_545_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105132", "story_v_side_new_1101105.awb")
					end

					arg_545_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105132", "story_v_side_new_1101105.awb")
				end

				arg_545_1:RecordContent(arg_545_1.text_.text)
			end

			local var_548_25 = math.max(var_548_16, arg_545_1.talkMaxDuration)

			if var_548_15 <= arg_545_1.time_ and arg_545_1.time_ < var_548_15 + var_548_25 then
				arg_545_1.typewritter.percent = (arg_545_1.time_ - var_548_15) / var_548_25

				arg_545_1.typewritter:SetDirty()
			end

			if arg_545_1.time_ >= var_548_15 + var_548_25 and arg_545_1.time_ < var_548_15 + var_548_25 + arg_548_0 then
				arg_545_1.typewritter.percent = 1

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(true)
			end
		end

		arg_545_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_545_1:InitPlayNodeList()
	end,
	Play1101105133 = function(arg_549_0, arg_549_1)
		arg_549_1.time_ = 0
		arg_549_1.frameCnt_ = 0
		arg_549_1.state_ = "playing"
		arg_549_1.curTalkId_ = 1101105133
		arg_549_1.duration_ = 7.23

		local var_549_0 = {
			zh = 3.533,
			ja = 7.233
		}
		local var_549_1 = manager.audio:GetLocalizationFlag()

		if var_549_0[var_549_1] ~= nil then
			arg_549_1.duration_ = var_549_0[var_549_1]
		end

		SetActive(arg_549_1.tipsGo_, false)

		function arg_549_1.onSingleLineFinish_()
			arg_549_1.onSingleLineUpdate_ = nil
			arg_549_1.onSingleLineFinish_ = nil
			arg_549_1.state_ = "waiting"
		end

		function arg_549_1.playNext_(arg_551_0)
			if arg_551_0 == 1 then
				arg_549_0:Play1101105134(arg_549_1)
			end
		end

		function arg_549_1.onSingleLineUpdate_(arg_552_0)
			local var_552_0 = 0
			local var_552_1 = 0.3

			if var_552_0 < arg_549_1.time_ and arg_549_1.time_ <= var_552_0 + arg_552_0 then
				arg_549_1.talkMaxDuration = 0
				arg_549_1.dialogCg_.alpha = 1

				arg_549_1.dialog_:SetActive(true)
				SetActive(arg_549_1.leftNameGo_, true)

				local var_552_2 = arg_549_1:FormatText(StoryNameCfg[37].name)

				arg_549_1.leftNameTxt_.text = var_552_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_549_1.leftNameTxt_.transform)

				arg_549_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_549_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_549_1:RecordName(arg_549_1.leftNameTxt_.text)
				SetActive(arg_549_1.iconTrs_.gameObject, false)
				arg_549_1.callingController_:SetSelectedState("normal")

				local var_552_3 = arg_549_1:GetWordFromCfg(1101105133)
				local var_552_4 = arg_549_1:FormatText(var_552_3.content)

				arg_549_1.text_.text = var_552_4

				LuaForUtil.ClearLinePrefixSymbol(arg_549_1.text_)

				local var_552_5 = 12
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

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105133", "story_v_side_new_1101105.awb") ~= 0 then
					local var_552_8 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105133", "story_v_side_new_1101105.awb") / 1000

					if var_552_8 + var_552_0 > arg_549_1.duration_ then
						arg_549_1.duration_ = var_552_8 + var_552_0
					end

					if var_552_3.prefab_name ~= "" and arg_549_1.actors_[var_552_3.prefab_name] ~= nil then
						local var_552_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_549_1.actors_[var_552_3.prefab_name].transform, "story_v_side_new_1101105", "1101105133", "story_v_side_new_1101105.awb")

						arg_549_1:RecordAudio("1101105133", var_552_9)
						arg_549_1:RecordAudio("1101105133", var_552_9)
					else
						arg_549_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105133", "story_v_side_new_1101105.awb")
					end

					arg_549_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105133", "story_v_side_new_1101105.awb")
				end

				arg_549_1:RecordContent(arg_549_1.text_.text)
			end

			local var_552_10 = math.max(var_552_1, arg_549_1.talkMaxDuration)

			if var_552_0 <= arg_549_1.time_ and arg_549_1.time_ < var_552_0 + var_552_10 then
				arg_549_1.typewritter.percent = (arg_549_1.time_ - var_552_0) / var_552_10

				arg_549_1.typewritter:SetDirty()
			end

			if arg_549_1.time_ >= var_552_0 + var_552_10 and arg_549_1.time_ < var_552_0 + var_552_10 + arg_552_0 then
				arg_549_1.typewritter.percent = 1

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(true)
			end
		end

		arg_549_1.nodeConfigList_ = {}

		arg_549_1:InitPlayNodeList()
	end,
	Play1101105134 = function(arg_553_0, arg_553_1)
		arg_553_1.time_ = 0
		arg_553_1.frameCnt_ = 0
		arg_553_1.state_ = "playing"
		arg_553_1.curTalkId_ = 1101105134
		arg_553_1.duration_ = 5

		SetActive(arg_553_1.tipsGo_, false)

		function arg_553_1.onSingleLineFinish_()
			arg_553_1.onSingleLineUpdate_ = nil
			arg_553_1.onSingleLineFinish_ = nil
			arg_553_1.state_ = "waiting"
		end

		function arg_553_1.playNext_(arg_555_0)
			if arg_555_0 == 1 then
				arg_553_0:Play1101105135(arg_553_1)
			end
		end

		function arg_553_1.onSingleLineUpdate_(arg_556_0)
			local var_556_0 = arg_553_1.actors_["1011ui_story"]
			local var_556_1 = 0

			if var_556_1 < arg_553_1.time_ and arg_553_1.time_ <= var_556_1 + arg_556_0 and not isNil(var_556_0) and arg_553_1.var_.characterEffect1011ui_story == nil then
				arg_553_1.var_.characterEffect1011ui_story = var_556_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_556_2 = 0.200000002980232

			if var_556_1 <= arg_553_1.time_ and arg_553_1.time_ < var_556_1 + var_556_2 and not isNil(var_556_0) then
				local var_556_3 = (arg_553_1.time_ - var_556_1) / var_556_2

				if arg_553_1.var_.characterEffect1011ui_story and not isNil(var_556_0) then
					local var_556_4 = Mathf.Lerp(0, 0.5, var_556_3)

					arg_553_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_553_1.var_.characterEffect1011ui_story.fillRatio = var_556_4
				end
			end

			if arg_553_1.time_ >= var_556_1 + var_556_2 and arg_553_1.time_ < var_556_1 + var_556_2 + arg_556_0 and not isNil(var_556_0) and arg_553_1.var_.characterEffect1011ui_story then
				local var_556_5 = 0.5

				arg_553_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_553_1.var_.characterEffect1011ui_story.fillRatio = var_556_5
			end

			local var_556_6 = 0
			local var_556_7 = 0.725

			if var_556_6 < arg_553_1.time_ and arg_553_1.time_ <= var_556_6 + arg_556_0 then
				arg_553_1.talkMaxDuration = 0
				arg_553_1.dialogCg_.alpha = 1

				arg_553_1.dialog_:SetActive(true)
				SetActive(arg_553_1.leftNameGo_, false)

				arg_553_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_553_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_553_1:RecordName(arg_553_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_553_1.iconTrs_.gameObject, false)
				arg_553_1.callingController_:SetSelectedState("normal")

				local var_556_8 = arg_553_1:GetWordFromCfg(1101105134)
				local var_556_9 = arg_553_1:FormatText(var_556_8.content)

				arg_553_1.text_.text = var_556_9

				LuaForUtil.ClearLinePrefixSymbol(arg_553_1.text_)

				local var_556_10 = 29
				local var_556_11 = utf8.len(var_556_9)
				local var_556_12 = var_556_10 <= 0 and var_556_7 or var_556_7 * (var_556_11 / var_556_10)

				if var_556_12 > 0 and var_556_7 < var_556_12 then
					arg_553_1.talkMaxDuration = var_556_12

					if var_556_12 + var_556_6 > arg_553_1.duration_ then
						arg_553_1.duration_ = var_556_12 + var_556_6
					end
				end

				arg_553_1.text_.text = var_556_9
				arg_553_1.typewritter.percent = 0

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(false)
				arg_553_1:RecordContent(arg_553_1.text_.text)
			end

			local var_556_13 = math.max(var_556_7, arg_553_1.talkMaxDuration)

			if var_556_6 <= arg_553_1.time_ and arg_553_1.time_ < var_556_6 + var_556_13 then
				arg_553_1.typewritter.percent = (arg_553_1.time_ - var_556_6) / var_556_13

				arg_553_1.typewritter:SetDirty()
			end

			if arg_553_1.time_ >= var_556_6 + var_556_13 and arg_553_1.time_ < var_556_6 + var_556_13 + arg_556_0 then
				arg_553_1.typewritter.percent = 1

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(true)
			end
		end

		arg_553_1.nodeConfigList_ = {}

		arg_553_1:InitPlayNodeList()
	end,
	Play1101105135 = function(arg_557_0, arg_557_1)
		arg_557_1.time_ = 0
		arg_557_1.frameCnt_ = 0
		arg_557_1.state_ = "playing"
		arg_557_1.curTalkId_ = 1101105135
		arg_557_1.duration_ = 5

		SetActive(arg_557_1.tipsGo_, false)

		function arg_557_1.onSingleLineFinish_()
			arg_557_1.onSingleLineUpdate_ = nil
			arg_557_1.onSingleLineFinish_ = nil
			arg_557_1.state_ = "waiting"
		end

		function arg_557_1.playNext_(arg_559_0)
			if arg_559_0 == 1 then
				arg_557_0:Play1101105136(arg_557_1)
			end
		end

		function arg_557_1.onSingleLineUpdate_(arg_560_0)
			local var_560_0 = 0
			local var_560_1 = 0.1

			if var_560_0 < arg_557_1.time_ and arg_557_1.time_ <= var_560_0 + arg_560_0 then
				arg_557_1.talkMaxDuration = 0
				arg_557_1.dialogCg_.alpha = 1

				arg_557_1.dialog_:SetActive(true)
				SetActive(arg_557_1.leftNameGo_, true)

				local var_560_2 = arg_557_1:FormatText(StoryNameCfg[7].name)

				arg_557_1.leftNameTxt_.text = var_560_2

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

				local var_560_3 = arg_557_1:GetWordFromCfg(1101105135)
				local var_560_4 = arg_557_1:FormatText(var_560_3.content)

				arg_557_1.text_.text = var_560_4

				LuaForUtil.ClearLinePrefixSymbol(arg_557_1.text_)

				local var_560_5 = 4
				local var_560_6 = utf8.len(var_560_4)
				local var_560_7 = var_560_5 <= 0 and var_560_1 or var_560_1 * (var_560_6 / var_560_5)

				if var_560_7 > 0 and var_560_1 < var_560_7 then
					arg_557_1.talkMaxDuration = var_560_7

					if var_560_7 + var_560_0 > arg_557_1.duration_ then
						arg_557_1.duration_ = var_560_7 + var_560_0
					end
				end

				arg_557_1.text_.text = var_560_4
				arg_557_1.typewritter.percent = 0

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(false)
				arg_557_1:RecordContent(arg_557_1.text_.text)
			end

			local var_560_8 = math.max(var_560_1, arg_557_1.talkMaxDuration)

			if var_560_0 <= arg_557_1.time_ and arg_557_1.time_ < var_560_0 + var_560_8 then
				arg_557_1.typewritter.percent = (arg_557_1.time_ - var_560_0) / var_560_8

				arg_557_1.typewritter:SetDirty()
			end

			if arg_557_1.time_ >= var_560_0 + var_560_8 and arg_557_1.time_ < var_560_0 + var_560_8 + arg_560_0 then
				arg_557_1.typewritter.percent = 1

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(true)
			end
		end

		arg_557_1.nodeConfigList_ = {}

		arg_557_1:InitPlayNodeList()
	end,
	Play1101105136 = function(arg_561_0, arg_561_1)
		arg_561_1.time_ = 0
		arg_561_1.frameCnt_ = 0
		arg_561_1.state_ = "playing"
		arg_561_1.curTalkId_ = 1101105136
		arg_561_1.duration_ = 3.17

		local var_561_0 = {
			zh = 1.866,
			ja = 3.166
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
				arg_561_0:Play1101105137(arg_561_1)
			end
		end

		function arg_561_1.onSingleLineUpdate_(arg_564_0)
			local var_564_0 = arg_561_1.actors_["1011ui_story"].transform
			local var_564_1 = 0

			if var_564_1 < arg_561_1.time_ and arg_561_1.time_ <= var_564_1 + arg_564_0 then
				arg_561_1.var_.moveOldPos1011ui_story = var_564_0.localPosition
			end

			local var_564_2 = 0.001

			if var_564_1 <= arg_561_1.time_ and arg_561_1.time_ < var_564_1 + var_564_2 then
				local var_564_3 = (arg_561_1.time_ - var_564_1) / var_564_2
				local var_564_4 = Vector3.New(0, -0.71, -6)

				var_564_0.localPosition = Vector3.Lerp(arg_561_1.var_.moveOldPos1011ui_story, var_564_4, var_564_3)

				local var_564_5 = manager.ui.mainCamera.transform.position - var_564_0.position

				var_564_0.forward = Vector3.New(var_564_5.x, var_564_5.y, var_564_5.z)

				local var_564_6 = var_564_0.localEulerAngles

				var_564_6.z = 0
				var_564_6.x = 0
				var_564_0.localEulerAngles = var_564_6
			end

			if arg_561_1.time_ >= var_564_1 + var_564_2 and arg_561_1.time_ < var_564_1 + var_564_2 + arg_564_0 then
				var_564_0.localPosition = Vector3.New(0, -0.71, -6)

				local var_564_7 = manager.ui.mainCamera.transform.position - var_564_0.position

				var_564_0.forward = Vector3.New(var_564_7.x, var_564_7.y, var_564_7.z)

				local var_564_8 = var_564_0.localEulerAngles

				var_564_8.z = 0
				var_564_8.x = 0
				var_564_0.localEulerAngles = var_564_8
			end

			local var_564_9 = arg_561_1.actors_["1011ui_story"]
			local var_564_10 = 0

			if var_564_10 < arg_561_1.time_ and arg_561_1.time_ <= var_564_10 + arg_564_0 and not isNil(var_564_9) and arg_561_1.var_.characterEffect1011ui_story == nil then
				arg_561_1.var_.characterEffect1011ui_story = var_564_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_564_11 = 0.200000002980232

			if var_564_10 <= arg_561_1.time_ and arg_561_1.time_ < var_564_10 + var_564_11 and not isNil(var_564_9) then
				local var_564_12 = (arg_561_1.time_ - var_564_10) / var_564_11

				if arg_561_1.var_.characterEffect1011ui_story and not isNil(var_564_9) then
					arg_561_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_561_1.time_ >= var_564_10 + var_564_11 and arg_561_1.time_ < var_564_10 + var_564_11 + arg_564_0 and not isNil(var_564_9) and arg_561_1.var_.characterEffect1011ui_story then
				arg_561_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_564_13 = 0

			if var_564_13 < arg_561_1.time_ and arg_561_1.time_ <= var_564_13 + arg_564_0 then
				arg_561_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action1_1")
			end

			local var_564_14 = 0

			if var_564_14 < arg_561_1.time_ and arg_561_1.time_ <= var_564_14 + arg_564_0 then
				arg_561_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_564_15 = 0
			local var_564_16 = 0.075

			if var_564_15 < arg_561_1.time_ and arg_561_1.time_ <= var_564_15 + arg_564_0 then
				arg_561_1.talkMaxDuration = 0
				arg_561_1.dialogCg_.alpha = 1

				arg_561_1.dialog_:SetActive(true)
				SetActive(arg_561_1.leftNameGo_, true)

				local var_564_17 = arg_561_1:FormatText(StoryNameCfg[37].name)

				arg_561_1.leftNameTxt_.text = var_564_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_561_1.leftNameTxt_.transform)

				arg_561_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_561_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_561_1:RecordName(arg_561_1.leftNameTxt_.text)
				SetActive(arg_561_1.iconTrs_.gameObject, false)
				arg_561_1.callingController_:SetSelectedState("normal")

				local var_564_18 = arg_561_1:GetWordFromCfg(1101105136)
				local var_564_19 = arg_561_1:FormatText(var_564_18.content)

				arg_561_1.text_.text = var_564_19

				LuaForUtil.ClearLinePrefixSymbol(arg_561_1.text_)

				local var_564_20 = 3
				local var_564_21 = utf8.len(var_564_19)
				local var_564_22 = var_564_20 <= 0 and var_564_16 or var_564_16 * (var_564_21 / var_564_20)

				if var_564_22 > 0 and var_564_16 < var_564_22 then
					arg_561_1.talkMaxDuration = var_564_22

					if var_564_22 + var_564_15 > arg_561_1.duration_ then
						arg_561_1.duration_ = var_564_22 + var_564_15
					end
				end

				arg_561_1.text_.text = var_564_19
				arg_561_1.typewritter.percent = 0

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105136", "story_v_side_new_1101105.awb") ~= 0 then
					local var_564_23 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105136", "story_v_side_new_1101105.awb") / 1000

					if var_564_23 + var_564_15 > arg_561_1.duration_ then
						arg_561_1.duration_ = var_564_23 + var_564_15
					end

					if var_564_18.prefab_name ~= "" and arg_561_1.actors_[var_564_18.prefab_name] ~= nil then
						local var_564_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_561_1.actors_[var_564_18.prefab_name].transform, "story_v_side_new_1101105", "1101105136", "story_v_side_new_1101105.awb")

						arg_561_1:RecordAudio("1101105136", var_564_24)
						arg_561_1:RecordAudio("1101105136", var_564_24)
					else
						arg_561_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105136", "story_v_side_new_1101105.awb")
					end

					arg_561_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105136", "story_v_side_new_1101105.awb")
				end

				arg_561_1:RecordContent(arg_561_1.text_.text)
			end

			local var_564_25 = math.max(var_564_16, arg_561_1.talkMaxDuration)

			if var_564_15 <= arg_561_1.time_ and arg_561_1.time_ < var_564_15 + var_564_25 then
				arg_561_1.typewritter.percent = (arg_561_1.time_ - var_564_15) / var_564_25

				arg_561_1.typewritter:SetDirty()
			end

			if arg_561_1.time_ >= var_564_15 + var_564_25 and arg_561_1.time_ < var_564_15 + var_564_25 + arg_564_0 then
				arg_561_1.typewritter.percent = 1

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(true)
			end
		end

		arg_561_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
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
	Play1101105137 = function(arg_565_0, arg_565_1)
		arg_565_1.time_ = 0
		arg_565_1.frameCnt_ = 0
		arg_565_1.state_ = "playing"
		arg_565_1.curTalkId_ = 1101105137
		arg_565_1.duration_ = 5

		SetActive(arg_565_1.tipsGo_, false)

		function arg_565_1.onSingleLineFinish_()
			arg_565_1.onSingleLineUpdate_ = nil
			arg_565_1.onSingleLineFinish_ = nil
			arg_565_1.state_ = "waiting"
		end

		function arg_565_1.playNext_(arg_567_0)
			if arg_567_0 == 1 then
				arg_565_0:Play1101105138(arg_565_1)
			end
		end

		function arg_565_1.onSingleLineUpdate_(arg_568_0)
			local var_568_0 = arg_565_1.actors_["1011ui_story"]
			local var_568_1 = 0

			if var_568_1 < arg_565_1.time_ and arg_565_1.time_ <= var_568_1 + arg_568_0 and not isNil(var_568_0) and arg_565_1.var_.characterEffect1011ui_story == nil then
				arg_565_1.var_.characterEffect1011ui_story = var_568_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_568_2 = 0.200000002980232

			if var_568_1 <= arg_565_1.time_ and arg_565_1.time_ < var_568_1 + var_568_2 and not isNil(var_568_0) then
				local var_568_3 = (arg_565_1.time_ - var_568_1) / var_568_2

				if arg_565_1.var_.characterEffect1011ui_story and not isNil(var_568_0) then
					local var_568_4 = Mathf.Lerp(0, 0.5, var_568_3)

					arg_565_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_565_1.var_.characterEffect1011ui_story.fillRatio = var_568_4
				end
			end

			if arg_565_1.time_ >= var_568_1 + var_568_2 and arg_565_1.time_ < var_568_1 + var_568_2 + arg_568_0 and not isNil(var_568_0) and arg_565_1.var_.characterEffect1011ui_story then
				local var_568_5 = 0.5

				arg_565_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_565_1.var_.characterEffect1011ui_story.fillRatio = var_568_5
			end

			local var_568_6 = arg_565_1.actors_["1011ui_story"].transform
			local var_568_7 = 0

			if var_568_7 < arg_565_1.time_ and arg_565_1.time_ <= var_568_7 + arg_568_0 then
				arg_565_1.var_.moveOldPos1011ui_story = var_568_6.localPosition
			end

			local var_568_8 = 0.001

			if var_568_7 <= arg_565_1.time_ and arg_565_1.time_ < var_568_7 + var_568_8 then
				local var_568_9 = (arg_565_1.time_ - var_568_7) / var_568_8
				local var_568_10 = Vector3.New(0, 100, 0)

				var_568_6.localPosition = Vector3.Lerp(arg_565_1.var_.moveOldPos1011ui_story, var_568_10, var_568_9)

				local var_568_11 = manager.ui.mainCamera.transform.position - var_568_6.position

				var_568_6.forward = Vector3.New(var_568_11.x, var_568_11.y, var_568_11.z)

				local var_568_12 = var_568_6.localEulerAngles

				var_568_12.z = 0
				var_568_12.x = 0
				var_568_6.localEulerAngles = var_568_12
			end

			if arg_565_1.time_ >= var_568_7 + var_568_8 and arg_565_1.time_ < var_568_7 + var_568_8 + arg_568_0 then
				var_568_6.localPosition = Vector3.New(0, 100, 0)

				local var_568_13 = manager.ui.mainCamera.transform.position - var_568_6.position

				var_568_6.forward = Vector3.New(var_568_13.x, var_568_13.y, var_568_13.z)

				local var_568_14 = var_568_6.localEulerAngles

				var_568_14.z = 0
				var_568_14.x = 0
				var_568_6.localEulerAngles = var_568_14
			end

			local var_568_15 = 0
			local var_568_16 = 0.525

			if var_568_15 < arg_565_1.time_ and arg_565_1.time_ <= var_568_15 + arg_568_0 then
				arg_565_1.talkMaxDuration = 0
				arg_565_1.dialogCg_.alpha = 1

				arg_565_1.dialog_:SetActive(true)
				SetActive(arg_565_1.leftNameGo_, false)

				arg_565_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_565_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_565_1:RecordName(arg_565_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_565_1.iconTrs_.gameObject, false)
				arg_565_1.callingController_:SetSelectedState("normal")

				local var_568_17 = arg_565_1:GetWordFromCfg(1101105137)
				local var_568_18 = arg_565_1:FormatText(var_568_17.content)

				arg_565_1.text_.text = var_568_18

				LuaForUtil.ClearLinePrefixSymbol(arg_565_1.text_)

				local var_568_19 = 21
				local var_568_20 = utf8.len(var_568_18)
				local var_568_21 = var_568_19 <= 0 and var_568_16 or var_568_16 * (var_568_20 / var_568_19)

				if var_568_21 > 0 and var_568_16 < var_568_21 then
					arg_565_1.talkMaxDuration = var_568_21

					if var_568_21 + var_568_15 > arg_565_1.duration_ then
						arg_565_1.duration_ = var_568_21 + var_568_15
					end
				end

				arg_565_1.text_.text = var_568_18
				arg_565_1.typewritter.percent = 0

				arg_565_1.typewritter:SetDirty()
				arg_565_1:ShowNextGo(false)
				arg_565_1:RecordContent(arg_565_1.text_.text)
			end

			local var_568_22 = math.max(var_568_16, arg_565_1.talkMaxDuration)

			if var_568_15 <= arg_565_1.time_ and arg_565_1.time_ < var_568_15 + var_568_22 then
				arg_565_1.typewritter.percent = (arg_565_1.time_ - var_568_15) / var_568_22

				arg_565_1.typewritter:SetDirty()
			end

			if arg_565_1.time_ >= var_568_15 + var_568_22 and arg_565_1.time_ < var_568_15 + var_568_22 + arg_568_0 then
				arg_565_1.typewritter.percent = 1

				arg_565_1.typewritter:SetDirty()
				arg_565_1:ShowNextGo(true)
			end
		end

		arg_565_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_565_1:InitPlayNodeList()
	end,
	Play1101105138 = function(arg_569_0, arg_569_1)
		arg_569_1.time_ = 0
		arg_569_1.frameCnt_ = 0
		arg_569_1.state_ = "playing"
		arg_569_1.curTalkId_ = 1101105138
		arg_569_1.duration_ = 5

		SetActive(arg_569_1.tipsGo_, false)

		function arg_569_1.onSingleLineFinish_()
			arg_569_1.onSingleLineUpdate_ = nil
			arg_569_1.onSingleLineFinish_ = nil
			arg_569_1.state_ = "waiting"
		end

		function arg_569_1.playNext_(arg_571_0)
			if arg_571_0 == 1 then
				arg_569_0:Play1101105139(arg_569_1)
			end
		end

		function arg_569_1.onSingleLineUpdate_(arg_572_0)
			local var_572_0 = arg_569_1.actors_["1011ui_story"]
			local var_572_1 = 0

			if var_572_1 < arg_569_1.time_ and arg_569_1.time_ <= var_572_1 + arg_572_0 and not isNil(var_572_0) and arg_569_1.var_.characterEffect1011ui_story == nil then
				arg_569_1.var_.characterEffect1011ui_story = var_572_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_572_2 = 0.200000002980232

			if var_572_1 <= arg_569_1.time_ and arg_569_1.time_ < var_572_1 + var_572_2 and not isNil(var_572_0) then
				local var_572_3 = (arg_569_1.time_ - var_572_1) / var_572_2

				if arg_569_1.var_.characterEffect1011ui_story and not isNil(var_572_0) then
					local var_572_4 = Mathf.Lerp(0, 0.5, var_572_3)

					arg_569_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_569_1.var_.characterEffect1011ui_story.fillRatio = var_572_4
				end
			end

			if arg_569_1.time_ >= var_572_1 + var_572_2 and arg_569_1.time_ < var_572_1 + var_572_2 + arg_572_0 and not isNil(var_572_0) and arg_569_1.var_.characterEffect1011ui_story then
				local var_572_5 = 0.5

				arg_569_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_569_1.var_.characterEffect1011ui_story.fillRatio = var_572_5
			end

			local var_572_6 = arg_569_1.actors_["1011ui_story"].transform
			local var_572_7 = 0

			if var_572_7 < arg_569_1.time_ and arg_569_1.time_ <= var_572_7 + arg_572_0 then
				arg_569_1.var_.moveOldPos1011ui_story = var_572_6.localPosition
			end

			local var_572_8 = 0.001

			if var_572_7 <= arg_569_1.time_ and arg_569_1.time_ < var_572_7 + var_572_8 then
				local var_572_9 = (arg_569_1.time_ - var_572_7) / var_572_8
				local var_572_10 = Vector3.New(0, -0.71, -6)

				var_572_6.localPosition = Vector3.Lerp(arg_569_1.var_.moveOldPos1011ui_story, var_572_10, var_572_9)

				local var_572_11 = manager.ui.mainCamera.transform.position - var_572_6.position

				var_572_6.forward = Vector3.New(var_572_11.x, var_572_11.y, var_572_11.z)

				local var_572_12 = var_572_6.localEulerAngles

				var_572_12.z = 0
				var_572_12.x = 0
				var_572_6.localEulerAngles = var_572_12
			end

			if arg_569_1.time_ >= var_572_7 + var_572_8 and arg_569_1.time_ < var_572_7 + var_572_8 + arg_572_0 then
				var_572_6.localPosition = Vector3.New(0, -0.71, -6)

				local var_572_13 = manager.ui.mainCamera.transform.position - var_572_6.position

				var_572_6.forward = Vector3.New(var_572_13.x, var_572_13.y, var_572_13.z)

				local var_572_14 = var_572_6.localEulerAngles

				var_572_14.z = 0
				var_572_14.x = 0
				var_572_6.localEulerAngles = var_572_14
			end

			local var_572_15 = 0
			local var_572_16 = 0.65

			if var_572_15 < arg_569_1.time_ and arg_569_1.time_ <= var_572_15 + arg_572_0 then
				arg_569_1.talkMaxDuration = 0
				arg_569_1.dialogCg_.alpha = 1

				arg_569_1.dialog_:SetActive(true)
				SetActive(arg_569_1.leftNameGo_, true)

				local var_572_17 = arg_569_1:FormatText(StoryNameCfg[7].name)

				arg_569_1.leftNameTxt_.text = var_572_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_569_1.leftNameTxt_.transform)

				arg_569_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_569_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_569_1:RecordName(arg_569_1.leftNameTxt_.text)
				SetActive(arg_569_1.iconTrs_.gameObject, true)
				arg_569_1.iconController_:SetSelectedState("hero")

				arg_569_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_569_1.callingController_:SetSelectedState("normal")

				arg_569_1.keyicon_.color = Color.New(1, 1, 1)
				arg_569_1.icon_.color = Color.New(1, 1, 1)

				local var_572_18 = arg_569_1:GetWordFromCfg(1101105138)
				local var_572_19 = arg_569_1:FormatText(var_572_18.content)

				arg_569_1.text_.text = var_572_19

				LuaForUtil.ClearLinePrefixSymbol(arg_569_1.text_)

				local var_572_20 = 26
				local var_572_21 = utf8.len(var_572_19)
				local var_572_22 = var_572_20 <= 0 and var_572_16 or var_572_16 * (var_572_21 / var_572_20)

				if var_572_22 > 0 and var_572_16 < var_572_22 then
					arg_569_1.talkMaxDuration = var_572_22

					if var_572_22 + var_572_15 > arg_569_1.duration_ then
						arg_569_1.duration_ = var_572_22 + var_572_15
					end
				end

				arg_569_1.text_.text = var_572_19
				arg_569_1.typewritter.percent = 0

				arg_569_1.typewritter:SetDirty()
				arg_569_1:ShowNextGo(false)
				arg_569_1:RecordContent(arg_569_1.text_.text)
			end

			local var_572_23 = math.max(var_572_16, arg_569_1.talkMaxDuration)

			if var_572_15 <= arg_569_1.time_ and arg_569_1.time_ < var_572_15 + var_572_23 then
				arg_569_1.typewritter.percent = (arg_569_1.time_ - var_572_15) / var_572_23

				arg_569_1.typewritter:SetDirty()
			end

			if arg_569_1.time_ >= var_572_15 + var_572_23 and arg_569_1.time_ < var_572_15 + var_572_23 + arg_572_0 then
				arg_569_1.typewritter.percent = 1

				arg_569_1.typewritter:SetDirty()
				arg_569_1:ShowNextGo(true)
			end
		end

		arg_569_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
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
	Play1101105139 = function(arg_573_0, arg_573_1)
		arg_573_1.time_ = 0
		arg_573_1.frameCnt_ = 0
		arg_573_1.state_ = "playing"
		arg_573_1.curTalkId_ = 1101105139
		arg_573_1.duration_ = 2.57

		local var_573_0 = {
			zh = 1.999999999999,
			ja = 2.566
		}
		local var_573_1 = manager.audio:GetLocalizationFlag()

		if var_573_0[var_573_1] ~= nil then
			arg_573_1.duration_ = var_573_0[var_573_1]
		end

		SetActive(arg_573_1.tipsGo_, false)

		function arg_573_1.onSingleLineFinish_()
			arg_573_1.onSingleLineUpdate_ = nil
			arg_573_1.onSingleLineFinish_ = nil
			arg_573_1.state_ = "waiting"
			arg_573_1.auto_ = false
		end

		function arg_573_1.playNext_(arg_575_0)
			arg_573_1.onStoryFinished_()
		end

		function arg_573_1.onSingleLineUpdate_(arg_576_0)
			local var_576_0 = arg_573_1.actors_["1011ui_story"].transform
			local var_576_1 = 0

			if var_576_1 < arg_573_1.time_ and arg_573_1.time_ <= var_576_1 + arg_576_0 then
				arg_573_1.var_.moveOldPos1011ui_story = var_576_0.localPosition
			end

			local var_576_2 = 0.001

			if var_576_1 <= arg_573_1.time_ and arg_573_1.time_ < var_576_1 + var_576_2 then
				local var_576_3 = (arg_573_1.time_ - var_576_1) / var_576_2
				local var_576_4 = Vector3.New(0, -0.71, -6)

				var_576_0.localPosition = Vector3.Lerp(arg_573_1.var_.moveOldPos1011ui_story, var_576_4, var_576_3)

				local var_576_5 = manager.ui.mainCamera.transform.position - var_576_0.position

				var_576_0.forward = Vector3.New(var_576_5.x, var_576_5.y, var_576_5.z)

				local var_576_6 = var_576_0.localEulerAngles

				var_576_6.z = 0
				var_576_6.x = 0
				var_576_0.localEulerAngles = var_576_6
			end

			if arg_573_1.time_ >= var_576_1 + var_576_2 and arg_573_1.time_ < var_576_1 + var_576_2 + arg_576_0 then
				var_576_0.localPosition = Vector3.New(0, -0.71, -6)

				local var_576_7 = manager.ui.mainCamera.transform.position - var_576_0.position

				var_576_0.forward = Vector3.New(var_576_7.x, var_576_7.y, var_576_7.z)

				local var_576_8 = var_576_0.localEulerAngles

				var_576_8.z = 0
				var_576_8.x = 0
				var_576_0.localEulerAngles = var_576_8
			end

			local var_576_9 = arg_573_1.actors_["1011ui_story"]
			local var_576_10 = 0

			if var_576_10 < arg_573_1.time_ and arg_573_1.time_ <= var_576_10 + arg_576_0 and not isNil(var_576_9) and arg_573_1.var_.characterEffect1011ui_story == nil then
				arg_573_1.var_.characterEffect1011ui_story = var_576_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_576_11 = 0.200000002980232

			if var_576_10 <= arg_573_1.time_ and arg_573_1.time_ < var_576_10 + var_576_11 and not isNil(var_576_9) then
				local var_576_12 = (arg_573_1.time_ - var_576_10) / var_576_11

				if arg_573_1.var_.characterEffect1011ui_story and not isNil(var_576_9) then
					arg_573_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_573_1.time_ >= var_576_10 + var_576_11 and arg_573_1.time_ < var_576_10 + var_576_11 + arg_576_0 and not isNil(var_576_9) and arg_573_1.var_.characterEffect1011ui_story then
				arg_573_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_576_13 = 0

			if var_576_13 < arg_573_1.time_ and arg_573_1.time_ <= var_576_13 + arg_576_0 then
				arg_573_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action1_1")
			end

			local var_576_14 = 0

			if var_576_14 < arg_573_1.time_ and arg_573_1.time_ <= var_576_14 + arg_576_0 then
				arg_573_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_576_15 = 0
			local var_576_16 = 0.05

			if var_576_15 < arg_573_1.time_ and arg_573_1.time_ <= var_576_15 + arg_576_0 then
				arg_573_1.talkMaxDuration = 0
				arg_573_1.dialogCg_.alpha = 1

				arg_573_1.dialog_:SetActive(true)
				SetActive(arg_573_1.leftNameGo_, true)

				local var_576_17 = arg_573_1:FormatText(StoryNameCfg[37].name)

				arg_573_1.leftNameTxt_.text = var_576_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_573_1.leftNameTxt_.transform)

				arg_573_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_573_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_573_1:RecordName(arg_573_1.leftNameTxt_.text)
				SetActive(arg_573_1.iconTrs_.gameObject, false)
				arg_573_1.callingController_:SetSelectedState("normal")

				local var_576_18 = arg_573_1:GetWordFromCfg(1101105139)
				local var_576_19 = arg_573_1:FormatText(var_576_18.content)

				arg_573_1.text_.text = var_576_19

				LuaForUtil.ClearLinePrefixSymbol(arg_573_1.text_)

				local var_576_20 = 2
				local var_576_21 = utf8.len(var_576_19)
				local var_576_22 = var_576_20 <= 0 and var_576_16 or var_576_16 * (var_576_21 / var_576_20)

				if var_576_22 > 0 and var_576_16 < var_576_22 then
					arg_573_1.talkMaxDuration = var_576_22

					if var_576_22 + var_576_15 > arg_573_1.duration_ then
						arg_573_1.duration_ = var_576_22 + var_576_15
					end
				end

				arg_573_1.text_.text = var_576_19
				arg_573_1.typewritter.percent = 0

				arg_573_1.typewritter:SetDirty()
				arg_573_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105139", "story_v_side_new_1101105.awb") ~= 0 then
					local var_576_23 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105139", "story_v_side_new_1101105.awb") / 1000

					if var_576_23 + var_576_15 > arg_573_1.duration_ then
						arg_573_1.duration_ = var_576_23 + var_576_15
					end

					if var_576_18.prefab_name ~= "" and arg_573_1.actors_[var_576_18.prefab_name] ~= nil then
						local var_576_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_573_1.actors_[var_576_18.prefab_name].transform, "story_v_side_new_1101105", "1101105139", "story_v_side_new_1101105.awb")

						arg_573_1:RecordAudio("1101105139", var_576_24)
						arg_573_1:RecordAudio("1101105139", var_576_24)
					else
						arg_573_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105139", "story_v_side_new_1101105.awb")
					end

					arg_573_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105139", "story_v_side_new_1101105.awb")
				end

				arg_573_1:RecordContent(arg_573_1.text_.text)
			end

			local var_576_25 = math.max(var_576_16, arg_573_1.talkMaxDuration)

			if var_576_15 <= arg_573_1.time_ and arg_573_1.time_ < var_576_15 + var_576_25 then
				arg_573_1.typewritter.percent = (arg_573_1.time_ - var_576_15) / var_576_25

				arg_573_1.typewritter:SetDirty()
			end

			if arg_573_1.time_ >= var_576_15 + var_576_25 and arg_573_1.time_ < var_576_15 + var_576_25 + arg_576_0 then
				arg_573_1.typewritter.percent = 1

				arg_573_1.typewritter:SetDirty()
				arg_573_1:ShowNextGo(true)
			end
		end

		arg_573_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
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
	assets = {
		"TextureConfig/Background/D999",
		"TextureConfig/Background/ST01_blur",
		"TextureConfig/Background/ST12",
		"TextureConfig/Background/B13",
		"TextureConfig/Background/ST10",
		"TextureConfig/Background/STblack"
	},
	voices = {
		"story_v_side_new_1101105.awb"
	}
}
