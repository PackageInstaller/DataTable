return {
	Play322062001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 322062001
		arg_1_1.duration_ = 4.57

		local var_1_0 = {
			zh = 3.533,
			ja = 4.566
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
				arg_1_0:Play322062002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "L10j"

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
				local var_4_5 = arg_1_1.bgs_.L10j

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
					if iter_4_0 ~= "L10j" then
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
			local var_4_25 = 0.200000002980232

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

			local var_4_30 = 0.3
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

			local var_4_36 = 0.1
			local var_4_37 = 1

			if var_4_36 < arg_1_1.time_ and arg_1_1.time_ <= var_4_36 + arg_4_0 then
				local var_4_38 = "play"
				local var_4_39 = "effect"

				arg_1_1:AudioAction(var_4_38, var_4_39, "se_story_145", "se_story_145_fire", "")
			end

			local var_4_40 = manager.ui.mainCamera.transform
			local var_4_41 = 0

			if var_4_41 < arg_1_1.time_ and arg_1_1.time_ <= var_4_41 + arg_4_0 then
				local var_4_42 = arg_1_1.var_.effect2001
				local var_4_43
				local var_4_44 = var_4_40

				if not var_4_42 then
					var_4_42 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_wasteland_in_keep"), var_4_44)
					var_4_42.name = "2001"
					arg_1_1.var_.effect2001 = var_4_42
				else
					var_4_42.transform:SetParent(var_4_44)
				end

				var_4_42.transform.localPosition = Vector3.New(0, 0, -0.1)
				var_4_42.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_4_45 = manager.ui.mainCameraCom_
				local var_4_46 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_4_45.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_4_47 = var_4_42.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_4_48 = 15
				local var_4_49 = 2 * var_4_48 * Mathf.Tan(var_4_45.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_4_45.aspect
				local var_4_50 = 1
				local var_4_51 = 1.7777777777777777

				if var_4_51 < var_4_45.aspect then
					var_4_50 = var_4_49 / (2 * var_4_48 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_4_51)
				end

				for iter_4_2, iter_4_3 in ipairs(var_4_47) do
					local var_4_52 = iter_4_3.transform.localScale

					iter_4_3.transform.localScale = Vector3.New(var_4_52.x / var_4_46 * var_4_50, var_4_52.y / var_4_46, var_4_52.z)
				end
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_53 = 2
			local var_4_54 = 0.275

			if var_4_53 < arg_1_1.time_ and arg_1_1.time_ <= var_4_53 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_55 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_55:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_55:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_55:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_56 = arg_1_1:GetWordFromCfg(322062001)
				local var_4_57 = arg_1_1:FormatText(var_4_56.content)

				arg_1_1.text_.text = var_4_57

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_58 = 11
				local var_4_59 = utf8.len(var_4_57)
				local var_4_60 = var_4_58 <= 0 and var_4_54 or var_4_54 * (var_4_59 / var_4_58)

				if var_4_60 > 0 and var_4_54 < var_4_60 then
					arg_1_1.talkMaxDuration = var_4_60
					var_4_53 = var_4_53 + 0.3

					if var_4_60 + var_4_53 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_60 + var_4_53
					end
				end

				arg_1_1.text_.text = var_4_57
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062001", "story_v_out_322062.awb") ~= 0 then
					local var_4_61 = manager.audio:GetVoiceLength("story_v_out_322062", "322062001", "story_v_out_322062.awb") / 1000

					if var_4_61 + var_4_53 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_61 + var_4_53
					end

					if var_4_56.prefab_name ~= "" and arg_1_1.actors_[var_4_56.prefab_name] ~= nil then
						local var_4_62 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_56.prefab_name].transform, "story_v_out_322062", "322062001", "story_v_out_322062.awb")

						arg_1_1:RecordAudio("322062001", var_4_62)
						arg_1_1:RecordAudio("322062001", var_4_62)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_322062", "322062001", "story_v_out_322062.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_322062", "322062001", "story_v_out_322062.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_63 = var_4_53 + 0.3
			local var_4_64 = math.max(var_4_54, arg_1_1.talkMaxDuration)

			if var_4_63 <= arg_1_1.time_ and arg_1_1.time_ < var_4_63 + var_4_64 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_63) / var_4_64

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_63 + var_4_64 and arg_1_1.time_ < var_4_63 + var_4_64 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play322062002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 322062002
		arg_9_1.duration_ = 1.43

		local var_9_0 = {
			zh = 0.999999999999,
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
				arg_9_0:Play322062003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 0.175

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

				local var_12_2 = arg_9_1:GetWordFromCfg(322062002)
				local var_12_3 = arg_9_1:FormatText(var_12_2.content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 7
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

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062002", "story_v_out_322062.awb") ~= 0 then
					local var_12_7 = manager.audio:GetVoiceLength("story_v_out_322062", "322062002", "story_v_out_322062.awb") / 1000

					if var_12_7 + var_12_0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_7 + var_12_0
					end

					if var_12_2.prefab_name ~= "" and arg_9_1.actors_[var_12_2.prefab_name] ~= nil then
						local var_12_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_2.prefab_name].transform, "story_v_out_322062", "322062002", "story_v_out_322062.awb")

						arg_9_1:RecordAudio("322062002", var_12_8)
						arg_9_1:RecordAudio("322062002", var_12_8)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_322062", "322062002", "story_v_out_322062.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_322062", "322062002", "story_v_out_322062.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_9 = math.max(var_12_1, arg_9_1.talkMaxDuration)

			if var_12_0 <= arg_9_1.time_ and arg_9_1.time_ < var_12_0 + var_12_9 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_0) / var_12_9

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_0 + var_12_9 and arg_9_1.time_ < var_12_0 + var_12_9 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play322062003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 322062003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play322062004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0
			local var_16_1 = 1.8

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

				local var_16_2 = arg_13_1:GetWordFromCfg(322062003)
				local var_16_3 = arg_13_1:FormatText(var_16_2.content)

				arg_13_1.text_.text = var_16_3

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 72
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
	Play322062004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 322062004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play322062005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0
			local var_20_1 = 1.2

			if var_20_0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_2 = arg_17_1:GetWordFromCfg(322062004)
				local var_20_3 = arg_17_1:FormatText(var_20_2.content)

				arg_17_1.text_.text = var_20_3

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_4 = 48
				local var_20_5 = utf8.len(var_20_3)
				local var_20_6 = var_20_4 <= 0 and var_20_1 or var_20_1 * (var_20_5 / var_20_4)

				if var_20_6 > 0 and var_20_1 < var_20_6 then
					arg_17_1.talkMaxDuration = var_20_6

					if var_20_6 + var_20_0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_6 + var_20_0
					end
				end

				arg_17_1.text_.text = var_20_3
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_7 = math.max(var_20_1, arg_17_1.talkMaxDuration)

			if var_20_0 <= arg_17_1.time_ and arg_17_1.time_ < var_20_0 + var_20_7 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_0) / var_20_7

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_0 + var_20_7 and arg_17_1.time_ < var_20_0 + var_20_7 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play322062005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 322062005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play322062006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0
			local var_24_1 = 1.325

			if var_24_0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_2 = arg_21_1:GetWordFromCfg(322062005)
				local var_24_3 = arg_21_1:FormatText(var_24_2.content)

				arg_21_1.text_.text = var_24_3

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_4 = 53
				local var_24_5 = utf8.len(var_24_3)
				local var_24_6 = var_24_4 <= 0 and var_24_1 or var_24_1 * (var_24_5 / var_24_4)

				if var_24_6 > 0 and var_24_1 < var_24_6 then
					arg_21_1.talkMaxDuration = var_24_6

					if var_24_6 + var_24_0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_6 + var_24_0
					end
				end

				arg_21_1.text_.text = var_24_3
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_7 = math.max(var_24_1, arg_21_1.talkMaxDuration)

			if var_24_0 <= arg_21_1.time_ and arg_21_1.time_ < var_24_0 + var_24_7 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_0) / var_24_7

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_0 + var_24_7 and arg_21_1.time_ < var_24_0 + var_24_7 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play322062006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 322062006
		arg_25_1.duration_ = 8.5

		local var_25_0 = {
			zh = 8.499999999999,
			ja = 8.332999999999
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
				arg_25_0:Play322062007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 1

			if var_28_0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_0 + arg_28_0 then
				local var_28_1 = manager.ui.mainCamera.transform.localPosition
				local var_28_2 = Vector3.New(0, 0, 10) + Vector3.New(var_28_1.x, var_28_1.y, 0)
				local var_28_3 = arg_25_1.bgs_.L10j

				var_28_3.transform.localPosition = var_28_2
				var_28_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_28_4 = var_28_3:GetComponent("SpriteRenderer")

				if var_28_4 and var_28_4.sprite then
					local var_28_5 = (var_28_3.transform.localPosition - var_28_1).z
					local var_28_6 = manager.ui.mainCameraCom_
					local var_28_7 = 2 * var_28_5 * Mathf.Tan(var_28_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_28_8 = var_28_7 * var_28_6.aspect
					local var_28_9 = var_28_4.sprite.bounds.size.x
					local var_28_10 = var_28_4.sprite.bounds.size.y
					local var_28_11 = var_28_8 / var_28_9
					local var_28_12 = var_28_7 / var_28_10
					local var_28_13 = var_28_12 < var_28_11 and var_28_11 or var_28_12

					var_28_3.transform.localScale = Vector3.New(var_28_13, var_28_13, 0)
				end

				for iter_28_0, iter_28_1 in pairs(arg_25_1.bgs_) do
					if iter_28_0 ~= "L10j" then
						iter_28_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_28_14 = 0

			if var_28_14 < arg_25_1.time_ and arg_25_1.time_ <= var_28_14 + arg_28_0 then
				arg_25_1.mask_.enabled = true
				arg_25_1.mask_.raycastTarget = true

				arg_25_1:SetGaussion(false)
			end

			local var_28_15 = 1

			if var_28_14 <= arg_25_1.time_ and arg_25_1.time_ < var_28_14 + var_28_15 then
				local var_28_16 = (arg_25_1.time_ - var_28_14) / var_28_15
				local var_28_17 = Color.New(0, 0, 0)

				var_28_17.a = Mathf.Lerp(0, 1, var_28_16)
				arg_25_1.mask_.color = var_28_17
			end

			if arg_25_1.time_ >= var_28_14 + var_28_15 and arg_25_1.time_ < var_28_14 + var_28_15 + arg_28_0 then
				local var_28_18 = Color.New(0, 0, 0)

				var_28_18.a = 1
				arg_25_1.mask_.color = var_28_18
			end

			local var_28_19 = 0.999999999999

			if var_28_19 < arg_25_1.time_ and arg_25_1.time_ <= var_28_19 + arg_28_0 then
				arg_25_1.mask_.enabled = true
				arg_25_1.mask_.raycastTarget = true

				arg_25_1:SetGaussion(false)
			end

			local var_28_20 = 1

			if var_28_19 <= arg_25_1.time_ and arg_25_1.time_ < var_28_19 + var_28_20 then
				local var_28_21 = (arg_25_1.time_ - var_28_19) / var_28_20
				local var_28_22 = Color.New(0, 0, 0)

				var_28_22.a = Mathf.Lerp(1, 0, var_28_21)
				arg_25_1.mask_.color = var_28_22
			end

			if arg_25_1.time_ >= var_28_19 + var_28_20 and arg_25_1.time_ < var_28_19 + var_28_20 + arg_28_0 then
				local var_28_23 = Color.New(0, 0, 0)
				local var_28_24 = 0

				arg_25_1.mask_.enabled = false
				var_28_23.a = var_28_24
				arg_25_1.mask_.color = var_28_23
			end

			local var_28_25 = "1211ui_story"

			if arg_25_1.actors_[var_28_25] == nil then
				local var_28_26 = Asset.Load("Char/" .. "1211ui_story")

				if not isNil(var_28_26) then
					local var_28_27 = Object.Instantiate(Asset.Load("Char/" .. "1211ui_story"), arg_25_1.stage_.transform)

					var_28_27.name = var_28_25
					var_28_27.transform.localPosition = Vector3.New(0, 100, 0)
					arg_25_1.actors_[var_28_25] = var_28_27

					local var_28_28 = var_28_27:GetComponentInChildren(typeof(CharacterEffect))

					var_28_28.enabled = true

					local var_28_29 = GameObjectTools.GetOrAddComponent(var_28_27, typeof(DynamicBoneHelper))

					if var_28_29 then
						var_28_29:EnableDynamicBone(false)
					end

					arg_25_1:ShowWeapon(var_28_28.transform, false)

					arg_25_1.var_[var_28_25 .. "Animator"] = var_28_28.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_25_1.var_[var_28_25 .. "Animator"].applyRootMotion = true
					arg_25_1.var_[var_28_25 .. "LipSync"] = var_28_28.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_28_30 = arg_25_1.actors_["1211ui_story"].transform
			local var_28_31 = 1.999999999999

			if var_28_31 < arg_25_1.time_ and arg_25_1.time_ <= var_28_31 + arg_28_0 then
				arg_25_1.var_.moveOldPos1211ui_story = var_28_30.localPosition

				local var_28_32 = "1211ui_story"

				arg_25_1:ShowWeapon(arg_25_1.var_[var_28_32 .. "Animator"].transform, false)
			end

			local var_28_33 = 0.001

			if var_28_31 <= arg_25_1.time_ and arg_25_1.time_ < var_28_31 + var_28_33 then
				local var_28_34 = (arg_25_1.time_ - var_28_31) / var_28_33
				local var_28_35 = Vector3.New(-0.7, -0.67, -6.07)

				var_28_30.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1211ui_story, var_28_35, var_28_34)

				local var_28_36 = manager.ui.mainCamera.transform.position - var_28_30.position

				var_28_30.forward = Vector3.New(var_28_36.x, var_28_36.y, var_28_36.z)

				local var_28_37 = var_28_30.localEulerAngles

				var_28_37.z = 0
				var_28_37.x = 0
				var_28_30.localEulerAngles = var_28_37
			end

			if arg_25_1.time_ >= var_28_31 + var_28_33 and arg_25_1.time_ < var_28_31 + var_28_33 + arg_28_0 then
				var_28_30.localPosition = Vector3.New(-0.7, -0.67, -6.07)

				local var_28_38 = manager.ui.mainCamera.transform.position - var_28_30.position

				var_28_30.forward = Vector3.New(var_28_38.x, var_28_38.y, var_28_38.z)

				local var_28_39 = var_28_30.localEulerAngles

				var_28_39.z = 0
				var_28_39.x = 0
				var_28_30.localEulerAngles = var_28_39
			end

			local var_28_40 = arg_25_1.actors_["1211ui_story"]
			local var_28_41 = 1.999999999999

			if var_28_41 < arg_25_1.time_ and arg_25_1.time_ <= var_28_41 + arg_28_0 and not isNil(var_28_40) and arg_25_1.var_.characterEffect1211ui_story == nil then
				arg_25_1.var_.characterEffect1211ui_story = var_28_40:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_42 = 0.200000002980232

			if var_28_41 <= arg_25_1.time_ and arg_25_1.time_ < var_28_41 + var_28_42 and not isNil(var_28_40) then
				local var_28_43 = (arg_25_1.time_ - var_28_41) / var_28_42

				if arg_25_1.var_.characterEffect1211ui_story and not isNil(var_28_40) then
					arg_25_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= var_28_41 + var_28_42 and arg_25_1.time_ < var_28_41 + var_28_42 + arg_28_0 and not isNil(var_28_40) and arg_25_1.var_.characterEffect1211ui_story then
				arg_25_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_28_44 = 1.999999999999

			if var_28_44 < arg_25_1.time_ and arg_25_1.time_ <= var_28_44 + arg_28_0 then
				arg_25_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action2_1")
			end

			local var_28_45 = 1.999999999999

			if var_28_45 < arg_25_1.time_ and arg_25_1.time_ <= var_28_45 + arg_28_0 then
				arg_25_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_28_46 = manager.ui.mainCamera.transform
			local var_28_47 = 0.999999999999001

			if var_28_47 < arg_25_1.time_ and arg_25_1.time_ <= var_28_47 + arg_28_0 then
				local var_28_48 = arg_25_1.var_.effect2001

				if var_28_48 then
					Object.Destroy(var_28_48)

					arg_25_1.var_.effect2001 = nil
				end
			end

			if arg_25_1.frameCnt_ <= 1 then
				arg_25_1.dialog_:SetActive(false)
			end

			local var_28_49 = 1.999999999999
			local var_28_50 = 0.475

			if var_28_49 < arg_25_1.time_ and arg_25_1.time_ <= var_28_49 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0

				arg_25_1.dialog_:SetActive(true)

				arg_25_1.dialogCg_.alpha = 0

				local var_28_51 = LeanTween.value(arg_25_1.dialog_, 0, 1, 0.3)

				var_28_51:setOnUpdate(LuaHelper.FloatAction(function(arg_29_0)
					arg_25_1.dialogCg_.alpha = arg_29_0
				end))
				var_28_51:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_25_1.dialog_)
					var_28_51:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_25_1.duration_ = arg_25_1.duration_ + 0.3

				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_52 = arg_25_1:FormatText(StoryNameCfg[37].name)

				arg_25_1.leftNameTxt_.text = var_28_52

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_53 = arg_25_1:GetWordFromCfg(322062006)
				local var_28_54 = arg_25_1:FormatText(var_28_53.content)

				arg_25_1.text_.text = var_28_54

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_55 = 20
				local var_28_56 = utf8.len(var_28_54)
				local var_28_57 = var_28_55 <= 0 and var_28_50 or var_28_50 * (var_28_56 / var_28_55)

				if var_28_57 > 0 and var_28_50 < var_28_57 then
					arg_25_1.talkMaxDuration = var_28_57
					var_28_49 = var_28_49 + 0.3

					if var_28_57 + var_28_49 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_57 + var_28_49
					end
				end

				arg_25_1.text_.text = var_28_54
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062006", "story_v_out_322062.awb") ~= 0 then
					local var_28_58 = manager.audio:GetVoiceLength("story_v_out_322062", "322062006", "story_v_out_322062.awb") / 1000

					if var_28_58 + var_28_49 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_58 + var_28_49
					end

					if var_28_53.prefab_name ~= "" and arg_25_1.actors_[var_28_53.prefab_name] ~= nil then
						local var_28_59 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_53.prefab_name].transform, "story_v_out_322062", "322062006", "story_v_out_322062.awb")

						arg_25_1:RecordAudio("322062006", var_28_59)
						arg_25_1:RecordAudio("322062006", var_28_59)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_322062", "322062006", "story_v_out_322062.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_322062", "322062006", "story_v_out_322062.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_60 = var_28_49 + 0.3
			local var_28_61 = math.max(var_28_50, arg_25_1.talkMaxDuration)

			if var_28_60 <= arg_25_1.time_ and arg_25_1.time_ < var_28_60 + var_28_61 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_60) / var_28_61

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_60 + var_28_61 and arg_25_1.time_ < var_28_60 + var_28_61 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.999999999999,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_25_1:InitPlayNodeList()
	end,
	Play322062007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 322062007
		arg_31_1.duration_ = 4.7

		local var_31_0 = {
			zh = 3.733,
			ja = 4.7
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
				arg_31_0:Play322062008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = "1284ui_story"

			if arg_31_1.actors_[var_34_0] == nil then
				local var_34_1 = Asset.Load("Char/" .. "1284ui_story")

				if not isNil(var_34_1) then
					local var_34_2 = Object.Instantiate(Asset.Load("Char/" .. "1284ui_story"), arg_31_1.stage_.transform)

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

			local var_34_5 = arg_31_1.actors_["1284ui_story"].transform
			local var_34_6 = 0

			if var_34_6 < arg_31_1.time_ and arg_31_1.time_ <= var_34_6 + arg_34_0 then
				arg_31_1.var_.moveOldPos1284ui_story = var_34_5.localPosition

				local var_34_7 = "1284ui_story"

				arg_31_1:ShowWeapon(arg_31_1.var_[var_34_7 .. "Animator"].transform, false)
			end

			local var_34_8 = 0.001

			if var_34_6 <= arg_31_1.time_ and arg_31_1.time_ < var_34_6 + var_34_8 then
				local var_34_9 = (arg_31_1.time_ - var_34_6) / var_34_8
				local var_34_10 = Vector3.New(0.7, -0.985, -6.22)

				var_34_5.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos1284ui_story, var_34_10, var_34_9)

				local var_34_11 = manager.ui.mainCamera.transform.position - var_34_5.position

				var_34_5.forward = Vector3.New(var_34_11.x, var_34_11.y, var_34_11.z)

				local var_34_12 = var_34_5.localEulerAngles

				var_34_12.z = 0
				var_34_12.x = 0
				var_34_5.localEulerAngles = var_34_12
			end

			if arg_31_1.time_ >= var_34_6 + var_34_8 and arg_31_1.time_ < var_34_6 + var_34_8 + arg_34_0 then
				var_34_5.localPosition = Vector3.New(0.7, -0.985, -6.22)

				local var_34_13 = manager.ui.mainCamera.transform.position - var_34_5.position

				var_34_5.forward = Vector3.New(var_34_13.x, var_34_13.y, var_34_13.z)

				local var_34_14 = var_34_5.localEulerAngles

				var_34_14.z = 0
				var_34_14.x = 0
				var_34_5.localEulerAngles = var_34_14
			end

			local var_34_15 = arg_31_1.actors_["1284ui_story"]
			local var_34_16 = 0

			if var_34_16 < arg_31_1.time_ and arg_31_1.time_ <= var_34_16 + arg_34_0 and not isNil(var_34_15) and arg_31_1.var_.characterEffect1284ui_story == nil then
				arg_31_1.var_.characterEffect1284ui_story = var_34_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_17 = 0.200000002980232

			if var_34_16 <= arg_31_1.time_ and arg_31_1.time_ < var_34_16 + var_34_17 and not isNil(var_34_15) then
				local var_34_18 = (arg_31_1.time_ - var_34_16) / var_34_17

				if arg_31_1.var_.characterEffect1284ui_story and not isNil(var_34_15) then
					arg_31_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_31_1.time_ >= var_34_16 + var_34_17 and arg_31_1.time_ < var_34_16 + var_34_17 + arg_34_0 and not isNil(var_34_15) and arg_31_1.var_.characterEffect1284ui_story then
				arg_31_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_34_19 = arg_31_1.actors_["1211ui_story"]
			local var_34_20 = 0

			if var_34_20 < arg_31_1.time_ and arg_31_1.time_ <= var_34_20 + arg_34_0 and not isNil(var_34_19) and arg_31_1.var_.characterEffect1211ui_story == nil then
				arg_31_1.var_.characterEffect1211ui_story = var_34_19:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_21 = 0.200000002980232

			if var_34_20 <= arg_31_1.time_ and arg_31_1.time_ < var_34_20 + var_34_21 and not isNil(var_34_19) then
				local var_34_22 = (arg_31_1.time_ - var_34_20) / var_34_21

				if arg_31_1.var_.characterEffect1211ui_story and not isNil(var_34_19) then
					local var_34_23 = Mathf.Lerp(0, 0.5, var_34_22)

					arg_31_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_31_1.var_.characterEffect1211ui_story.fillRatio = var_34_23
				end
			end

			if arg_31_1.time_ >= var_34_20 + var_34_21 and arg_31_1.time_ < var_34_20 + var_34_21 + arg_34_0 and not isNil(var_34_19) and arg_31_1.var_.characterEffect1211ui_story then
				local var_34_24 = 0.5

				arg_31_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_31_1.var_.characterEffect1211ui_story.fillRatio = var_34_24
			end

			local var_34_25 = 0

			if var_34_25 < arg_31_1.time_ and arg_31_1.time_ <= var_34_25 + arg_34_0 then
				arg_31_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action3_1")
			end

			local var_34_26 = 0

			if var_34_26 < arg_31_1.time_ and arg_31_1.time_ <= var_34_26 + arg_34_0 then
				arg_31_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_34_27 = 0
			local var_34_28 = 0.375

			if var_34_27 < arg_31_1.time_ and arg_31_1.time_ <= var_34_27 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				local var_34_29 = arg_31_1:FormatText(StoryNameCfg[6].name)

				arg_31_1.leftNameTxt_.text = var_34_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_30 = arg_31_1:GetWordFromCfg(322062007)
				local var_34_31 = arg_31_1:FormatText(var_34_30.content)

				arg_31_1.text_.text = var_34_31

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_32 = 15
				local var_34_33 = utf8.len(var_34_31)
				local var_34_34 = var_34_32 <= 0 and var_34_28 or var_34_28 * (var_34_33 / var_34_32)

				if var_34_34 > 0 and var_34_28 < var_34_34 then
					arg_31_1.talkMaxDuration = var_34_34

					if var_34_34 + var_34_27 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_34 + var_34_27
					end
				end

				arg_31_1.text_.text = var_34_31
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062007", "story_v_out_322062.awb") ~= 0 then
					local var_34_35 = manager.audio:GetVoiceLength("story_v_out_322062", "322062007", "story_v_out_322062.awb") / 1000

					if var_34_35 + var_34_27 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_35 + var_34_27
					end

					if var_34_30.prefab_name ~= "" and arg_31_1.actors_[var_34_30.prefab_name] ~= nil then
						local var_34_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_30.prefab_name].transform, "story_v_out_322062", "322062007", "story_v_out_322062.awb")

						arg_31_1:RecordAudio("322062007", var_34_36)
						arg_31_1:RecordAudio("322062007", var_34_36)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_322062", "322062007", "story_v_out_322062.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_322062", "322062007", "story_v_out_322062.awb")
				end

				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_37 = math.max(var_34_28, arg_31_1.talkMaxDuration)

			if var_34_27 <= arg_31_1.time_ and arg_31_1.time_ < var_34_27 + var_34_37 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_27) / var_34_37

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_27 + var_34_37 and arg_31_1.time_ < var_34_27 + var_34_37 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
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
	Play322062008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 322062008
		arg_35_1.duration_ = 7.93

		local var_35_0 = {
			zh = 7.933,
			ja = 7.333
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
				arg_35_0:Play322062009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = arg_35_1.actors_["1211ui_story"]
			local var_38_1 = 0

			if var_38_1 < arg_35_1.time_ and arg_35_1.time_ <= var_38_1 + arg_38_0 and not isNil(var_38_0) and arg_35_1.var_.characterEffect1211ui_story == nil then
				arg_35_1.var_.characterEffect1211ui_story = var_38_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_2 = 0.200000002980232

			if var_38_1 <= arg_35_1.time_ and arg_35_1.time_ < var_38_1 + var_38_2 and not isNil(var_38_0) then
				local var_38_3 = (arg_35_1.time_ - var_38_1) / var_38_2

				if arg_35_1.var_.characterEffect1211ui_story and not isNil(var_38_0) then
					arg_35_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_35_1.time_ >= var_38_1 + var_38_2 and arg_35_1.time_ < var_38_1 + var_38_2 + arg_38_0 and not isNil(var_38_0) and arg_35_1.var_.characterEffect1211ui_story then
				arg_35_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_38_4 = arg_35_1.actors_["1284ui_story"]
			local var_38_5 = 0

			if var_38_5 < arg_35_1.time_ and arg_35_1.time_ <= var_38_5 + arg_38_0 and not isNil(var_38_4) and arg_35_1.var_.characterEffect1284ui_story == nil then
				arg_35_1.var_.characterEffect1284ui_story = var_38_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_6 = 0.200000002980232

			if var_38_5 <= arg_35_1.time_ and arg_35_1.time_ < var_38_5 + var_38_6 and not isNil(var_38_4) then
				local var_38_7 = (arg_35_1.time_ - var_38_5) / var_38_6

				if arg_35_1.var_.characterEffect1284ui_story and not isNil(var_38_4) then
					local var_38_8 = Mathf.Lerp(0, 0.5, var_38_7)

					arg_35_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_35_1.var_.characterEffect1284ui_story.fillRatio = var_38_8
				end
			end

			if arg_35_1.time_ >= var_38_5 + var_38_6 and arg_35_1.time_ < var_38_5 + var_38_6 + arg_38_0 and not isNil(var_38_4) and arg_35_1.var_.characterEffect1284ui_story then
				local var_38_9 = 0.5

				arg_35_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_35_1.var_.characterEffect1284ui_story.fillRatio = var_38_9
			end

			local var_38_10 = 0

			if var_38_10 < arg_35_1.time_ and arg_35_1.time_ <= var_38_10 + arg_38_0 then
				arg_35_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action2_2")
			end

			local var_38_11 = 0
			local var_38_12 = 0.6

			if var_38_11 < arg_35_1.time_ and arg_35_1.time_ <= var_38_11 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				local var_38_13 = arg_35_1:FormatText(StoryNameCfg[37].name)

				arg_35_1.leftNameTxt_.text = var_38_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_14 = arg_35_1:GetWordFromCfg(322062008)
				local var_38_15 = arg_35_1:FormatText(var_38_14.content)

				arg_35_1.text_.text = var_38_15

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_16 = 24
				local var_38_17 = utf8.len(var_38_15)
				local var_38_18 = var_38_16 <= 0 and var_38_12 or var_38_12 * (var_38_17 / var_38_16)

				if var_38_18 > 0 and var_38_12 < var_38_18 then
					arg_35_1.talkMaxDuration = var_38_18

					if var_38_18 + var_38_11 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_18 + var_38_11
					end
				end

				arg_35_1.text_.text = var_38_15
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062008", "story_v_out_322062.awb") ~= 0 then
					local var_38_19 = manager.audio:GetVoiceLength("story_v_out_322062", "322062008", "story_v_out_322062.awb") / 1000

					if var_38_19 + var_38_11 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_19 + var_38_11
					end

					if var_38_14.prefab_name ~= "" and arg_35_1.actors_[var_38_14.prefab_name] ~= nil then
						local var_38_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_14.prefab_name].transform, "story_v_out_322062", "322062008", "story_v_out_322062.awb")

						arg_35_1:RecordAudio("322062008", var_38_20)
						arg_35_1:RecordAudio("322062008", var_38_20)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_out_322062", "322062008", "story_v_out_322062.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_out_322062", "322062008", "story_v_out_322062.awb")
				end

				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_21 = math.max(var_38_12, arg_35_1.talkMaxDuration)

			if var_38_11 <= arg_35_1.time_ and arg_35_1.time_ < var_38_11 + var_38_21 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_11) / var_38_21

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_11 + var_38_21 and arg_35_1.time_ < var_38_11 + var_38_21 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {}

		arg_35_1:InitPlayNodeList()
	end,
	Play322062009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 322062009
		arg_39_1.duration_ = 2

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play322062010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = arg_39_1.actors_["1284ui_story"]
			local var_42_1 = 0

			if var_42_1 < arg_39_1.time_ and arg_39_1.time_ <= var_42_1 + arg_42_0 and not isNil(var_42_0) and arg_39_1.var_.characterEffect1284ui_story == nil then
				arg_39_1.var_.characterEffect1284ui_story = var_42_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_2 = 0.200000002980232

			if var_42_1 <= arg_39_1.time_ and arg_39_1.time_ < var_42_1 + var_42_2 and not isNil(var_42_0) then
				local var_42_3 = (arg_39_1.time_ - var_42_1) / var_42_2

				if arg_39_1.var_.characterEffect1284ui_story and not isNil(var_42_0) then
					arg_39_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_39_1.time_ >= var_42_1 + var_42_2 and arg_39_1.time_ < var_42_1 + var_42_2 + arg_42_0 and not isNil(var_42_0) and arg_39_1.var_.characterEffect1284ui_story then
				arg_39_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_42_4 = arg_39_1.actors_["1211ui_story"]
			local var_42_5 = 0

			if var_42_5 < arg_39_1.time_ and arg_39_1.time_ <= var_42_5 + arg_42_0 and not isNil(var_42_4) and arg_39_1.var_.characterEffect1211ui_story == nil then
				arg_39_1.var_.characterEffect1211ui_story = var_42_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_6 = 0.200000002980232

			if var_42_5 <= arg_39_1.time_ and arg_39_1.time_ < var_42_5 + var_42_6 and not isNil(var_42_4) then
				local var_42_7 = (arg_39_1.time_ - var_42_5) / var_42_6

				if arg_39_1.var_.characterEffect1211ui_story and not isNil(var_42_4) then
					local var_42_8 = Mathf.Lerp(0, 0.5, var_42_7)

					arg_39_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_39_1.var_.characterEffect1211ui_story.fillRatio = var_42_8
				end
			end

			if arg_39_1.time_ >= var_42_5 + var_42_6 and arg_39_1.time_ < var_42_5 + var_42_6 + arg_42_0 and not isNil(var_42_4) and arg_39_1.var_.characterEffect1211ui_story then
				local var_42_9 = 0.5

				arg_39_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_39_1.var_.characterEffect1211ui_story.fillRatio = var_42_9
			end

			local var_42_10 = 0

			if var_42_10 < arg_39_1.time_ and arg_39_1.time_ <= var_42_10 + arg_42_0 then
				arg_39_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action3_2")
			end

			local var_42_11 = 0

			if var_42_11 < arg_39_1.time_ and arg_39_1.time_ <= var_42_11 + arg_42_0 then
				arg_39_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_42_12 = 0
			local var_42_13 = 0.15

			if var_42_12 < arg_39_1.time_ and arg_39_1.time_ <= var_42_12 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				local var_42_14 = arg_39_1:FormatText(StoryNameCfg[6].name)

				arg_39_1.leftNameTxt_.text = var_42_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_15 = arg_39_1:GetWordFromCfg(322062009)
				local var_42_16 = arg_39_1:FormatText(var_42_15.content)

				arg_39_1.text_.text = var_42_16

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_17 = 6
				local var_42_18 = utf8.len(var_42_16)
				local var_42_19 = var_42_17 <= 0 and var_42_13 or var_42_13 * (var_42_18 / var_42_17)

				if var_42_19 > 0 and var_42_13 < var_42_19 then
					arg_39_1.talkMaxDuration = var_42_19

					if var_42_19 + var_42_12 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_19 + var_42_12
					end
				end

				arg_39_1.text_.text = var_42_16
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062009", "story_v_out_322062.awb") ~= 0 then
					local var_42_20 = manager.audio:GetVoiceLength("story_v_out_322062", "322062009", "story_v_out_322062.awb") / 1000

					if var_42_20 + var_42_12 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_20 + var_42_12
					end

					if var_42_15.prefab_name ~= "" and arg_39_1.actors_[var_42_15.prefab_name] ~= nil then
						local var_42_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_15.prefab_name].transform, "story_v_out_322062", "322062009", "story_v_out_322062.awb")

						arg_39_1:RecordAudio("322062009", var_42_21)
						arg_39_1:RecordAudio("322062009", var_42_21)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_out_322062", "322062009", "story_v_out_322062.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_out_322062", "322062009", "story_v_out_322062.awb")
				end

				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_22 = math.max(var_42_13, arg_39_1.talkMaxDuration)

			if var_42_12 <= arg_39_1.time_ and arg_39_1.time_ < var_42_12 + var_42_22 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_12) / var_42_22

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_12 + var_42_22 and arg_39_1.time_ < var_42_12 + var_42_22 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play322062010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 322062010
		arg_43_1.duration_ = 4.33

		local var_43_0 = {
			zh = 3.8,
			ja = 4.333
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
				arg_43_0:Play322062011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = arg_43_1.actors_["1284ui_story"].transform
			local var_46_1 = 0

			if var_46_1 < arg_43_1.time_ and arg_43_1.time_ <= var_46_1 + arg_46_0 then
				arg_43_1.var_.moveOldPos1284ui_story = var_46_0.localPosition
			end

			local var_46_2 = 0.001

			if var_46_1 <= arg_43_1.time_ and arg_43_1.time_ < var_46_1 + var_46_2 then
				local var_46_3 = (arg_43_1.time_ - var_46_1) / var_46_2
				local var_46_4 = Vector3.New(0, 100, 0)

				var_46_0.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos1284ui_story, var_46_4, var_46_3)

				local var_46_5 = manager.ui.mainCamera.transform.position - var_46_0.position

				var_46_0.forward = Vector3.New(var_46_5.x, var_46_5.y, var_46_5.z)

				local var_46_6 = var_46_0.localEulerAngles

				var_46_6.z = 0
				var_46_6.x = 0
				var_46_0.localEulerAngles = var_46_6
			end

			if arg_43_1.time_ >= var_46_1 + var_46_2 and arg_43_1.time_ < var_46_1 + var_46_2 + arg_46_0 then
				var_46_0.localPosition = Vector3.New(0, 100, 0)

				local var_46_7 = manager.ui.mainCamera.transform.position - var_46_0.position

				var_46_0.forward = Vector3.New(var_46_7.x, var_46_7.y, var_46_7.z)

				local var_46_8 = var_46_0.localEulerAngles

				var_46_8.z = 0
				var_46_8.x = 0
				var_46_0.localEulerAngles = var_46_8
			end

			local var_46_9 = arg_43_1.actors_["1211ui_story"].transform
			local var_46_10 = 0

			if var_46_10 < arg_43_1.time_ and arg_43_1.time_ <= var_46_10 + arg_46_0 then
				arg_43_1.var_.moveOldPos1211ui_story = var_46_9.localPosition
			end

			local var_46_11 = 0.001

			if var_46_10 <= arg_43_1.time_ and arg_43_1.time_ < var_46_10 + var_46_11 then
				local var_46_12 = (arg_43_1.time_ - var_46_10) / var_46_11
				local var_46_13 = Vector3.New(0, 100, 0)

				var_46_9.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos1211ui_story, var_46_13, var_46_12)

				local var_46_14 = manager.ui.mainCamera.transform.position - var_46_9.position

				var_46_9.forward = Vector3.New(var_46_14.x, var_46_14.y, var_46_14.z)

				local var_46_15 = var_46_9.localEulerAngles

				var_46_15.z = 0
				var_46_15.x = 0
				var_46_9.localEulerAngles = var_46_15
			end

			if arg_43_1.time_ >= var_46_10 + var_46_11 and arg_43_1.time_ < var_46_10 + var_46_11 + arg_46_0 then
				var_46_9.localPosition = Vector3.New(0, 100, 0)

				local var_46_16 = manager.ui.mainCamera.transform.position - var_46_9.position

				var_46_9.forward = Vector3.New(var_46_16.x, var_46_16.y, var_46_16.z)

				local var_46_17 = var_46_9.localEulerAngles

				var_46_17.z = 0
				var_46_17.x = 0
				var_46_9.localEulerAngles = var_46_17
			end

			local var_46_18 = 0
			local var_46_19 = 0.325

			if var_46_18 < arg_43_1.time_ and arg_43_1.time_ <= var_46_18 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				local var_46_20 = arg_43_1:FormatText(StoryNameCfg[668].name)

				arg_43_1.leftNameTxt_.text = var_46_20

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, true)
				arg_43_1.iconController_:SetSelectedState("hero")

				arg_43_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4040")

				arg_43_1.callingController_:SetSelectedState("normal")

				arg_43_1.keyicon_.color = Color.New(1, 1, 1)
				arg_43_1.icon_.color = Color.New(1, 1, 1)

				local var_46_21 = arg_43_1:GetWordFromCfg(322062010)
				local var_46_22 = arg_43_1:FormatText(var_46_21.content)

				arg_43_1.text_.text = var_46_22

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_23 = 13
				local var_46_24 = utf8.len(var_46_22)
				local var_46_25 = var_46_23 <= 0 and var_46_19 or var_46_19 * (var_46_24 / var_46_23)

				if var_46_25 > 0 and var_46_19 < var_46_25 then
					arg_43_1.talkMaxDuration = var_46_25

					if var_46_25 + var_46_18 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_25 + var_46_18
					end
				end

				arg_43_1.text_.text = var_46_22
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062010", "story_v_out_322062.awb") ~= 0 then
					local var_46_26 = manager.audio:GetVoiceLength("story_v_out_322062", "322062010", "story_v_out_322062.awb") / 1000

					if var_46_26 + var_46_18 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_26 + var_46_18
					end

					if var_46_21.prefab_name ~= "" and arg_43_1.actors_[var_46_21.prefab_name] ~= nil then
						local var_46_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_21.prefab_name].transform, "story_v_out_322062", "322062010", "story_v_out_322062.awb")

						arg_43_1:RecordAudio("322062010", var_46_27)
						arg_43_1:RecordAudio("322062010", var_46_27)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_322062", "322062010", "story_v_out_322062.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_322062", "322062010", "story_v_out_322062.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_28 = math.max(var_46_19, arg_43_1.talkMaxDuration)

			if var_46_18 <= arg_43_1.time_ and arg_43_1.time_ < var_46_18 + var_46_28 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_18) / var_46_28

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_18 + var_46_28 and arg_43_1.time_ < var_46_18 + var_46_28 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_43_1:InitPlayNodeList()
	end,
	Play322062011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 322062011
		arg_47_1.duration_ = 2.03

		local var_47_0 = {
			zh = 2.033,
			ja = 2
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
				arg_47_0:Play322062012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = 0
			local var_50_1 = 0.075

			if var_50_0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_0 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				local var_50_2 = arg_47_1:FormatText(StoryNameCfg[605].name)

				arg_47_1.leftNameTxt_.text = var_50_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, true)
				arg_47_1.iconController_:SetSelectedState("hero")

				arg_47_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1156")

				arg_47_1.callingController_:SetSelectedState("normal")

				arg_47_1.keyicon_.color = Color.New(1, 1, 1)
				arg_47_1.icon_.color = Color.New(1, 1, 1)

				local var_50_3 = arg_47_1:GetWordFromCfg(322062011)
				local var_50_4 = arg_47_1:FormatText(var_50_3.content)

				arg_47_1.text_.text = var_50_4

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_5 = 3
				local var_50_6 = utf8.len(var_50_4)
				local var_50_7 = var_50_5 <= 0 and var_50_1 or var_50_1 * (var_50_6 / var_50_5)

				if var_50_7 > 0 and var_50_1 < var_50_7 then
					arg_47_1.talkMaxDuration = var_50_7

					if var_50_7 + var_50_0 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_7 + var_50_0
					end
				end

				arg_47_1.text_.text = var_50_4
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062011", "story_v_out_322062.awb") ~= 0 then
					local var_50_8 = manager.audio:GetVoiceLength("story_v_out_322062", "322062011", "story_v_out_322062.awb") / 1000

					if var_50_8 + var_50_0 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_8 + var_50_0
					end

					if var_50_3.prefab_name ~= "" and arg_47_1.actors_[var_50_3.prefab_name] ~= nil then
						local var_50_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_3.prefab_name].transform, "story_v_out_322062", "322062011", "story_v_out_322062.awb")

						arg_47_1:RecordAudio("322062011", var_50_9)
						arg_47_1:RecordAudio("322062011", var_50_9)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_322062", "322062011", "story_v_out_322062.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_322062", "322062011", "story_v_out_322062.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_10 = math.max(var_50_1, arg_47_1.talkMaxDuration)

			if var_50_0 <= arg_47_1.time_ and arg_47_1.time_ < var_50_0 + var_50_10 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_0) / var_50_10

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_0 + var_50_10 and arg_47_1.time_ < var_50_0 + var_50_10 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play322062012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 322062012
		arg_51_1.duration_ = 5

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play322062013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = "1156ui_story"

			if arg_51_1.actors_[var_54_0] == nil then
				local var_54_1 = Asset.Load("Char/" .. "1156ui_story")

				if not isNil(var_54_1) then
					local var_54_2 = Object.Instantiate(Asset.Load("Char/" .. "1156ui_story"), arg_51_1.stage_.transform)

					var_54_2.name = var_54_0
					var_54_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_51_1.actors_[var_54_0] = var_54_2

					local var_54_3 = var_54_2:GetComponentInChildren(typeof(CharacterEffect))

					var_54_3.enabled = true

					local var_54_4 = GameObjectTools.GetOrAddComponent(var_54_2, typeof(DynamicBoneHelper))

					if var_54_4 then
						var_54_4:EnableDynamicBone(false)
					end

					arg_51_1:ShowWeapon(var_54_3.transform, false)

					arg_51_1.var_[var_54_0 .. "Animator"] = var_54_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_51_1.var_[var_54_0 .. "Animator"].applyRootMotion = true
					arg_51_1.var_[var_54_0 .. "LipSync"] = var_54_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_54_5 = arg_51_1.actors_["1156ui_story"].transform
			local var_54_6 = 0

			if var_54_6 < arg_51_1.time_ and arg_51_1.time_ <= var_54_6 + arg_54_0 then
				arg_51_1.var_.moveOldPos1156ui_story = var_54_5.localPosition
			end

			local var_54_7 = 0.001

			if var_54_6 <= arg_51_1.time_ and arg_51_1.time_ < var_54_6 + var_54_7 then
				local var_54_8 = (arg_51_1.time_ - var_54_6) / var_54_7
				local var_54_9 = Vector3.New(0, 100, 0)

				var_54_5.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos1156ui_story, var_54_9, var_54_8)

				local var_54_10 = manager.ui.mainCamera.transform.position - var_54_5.position

				var_54_5.forward = Vector3.New(var_54_10.x, var_54_10.y, var_54_10.z)

				local var_54_11 = var_54_5.localEulerAngles

				var_54_11.z = 0
				var_54_11.x = 0
				var_54_5.localEulerAngles = var_54_11
			end

			if arg_51_1.time_ >= var_54_6 + var_54_7 and arg_51_1.time_ < var_54_6 + var_54_7 + arg_54_0 then
				var_54_5.localPosition = Vector3.New(0, 100, 0)

				local var_54_12 = manager.ui.mainCamera.transform.position - var_54_5.position

				var_54_5.forward = Vector3.New(var_54_12.x, var_54_12.y, var_54_12.z)

				local var_54_13 = var_54_5.localEulerAngles

				var_54_13.z = 0
				var_54_13.x = 0
				var_54_5.localEulerAngles = var_54_13
			end

			local var_54_14 = "404001ui_story"

			if arg_51_1.actors_[var_54_14] == nil then
				local var_54_15 = Asset.Load("Char/" .. "404001ui_story")

				if not isNil(var_54_15) then
					local var_54_16 = Object.Instantiate(Asset.Load("Char/" .. "404001ui_story"), arg_51_1.stage_.transform)

					var_54_16.name = var_54_14
					var_54_16.transform.localPosition = Vector3.New(0, 100, 0)
					arg_51_1.actors_[var_54_14] = var_54_16

					local var_54_17 = var_54_16:GetComponentInChildren(typeof(CharacterEffect))

					var_54_17.enabled = true

					local var_54_18 = GameObjectTools.GetOrAddComponent(var_54_16, typeof(DynamicBoneHelper))

					if var_54_18 then
						var_54_18:EnableDynamicBone(false)
					end

					arg_51_1:ShowWeapon(var_54_17.transform, false)

					arg_51_1.var_[var_54_14 .. "Animator"] = var_54_17.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_51_1.var_[var_54_14 .. "Animator"].applyRootMotion = true
					arg_51_1.var_[var_54_14 .. "LipSync"] = var_54_17.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_54_19 = arg_51_1.actors_["404001ui_story"].transform
			local var_54_20 = 0

			if var_54_20 < arg_51_1.time_ and arg_51_1.time_ <= var_54_20 + arg_54_0 then
				arg_51_1.var_.moveOldPos404001ui_story = var_54_19.localPosition
			end

			local var_54_21 = 0.001

			if var_54_20 <= arg_51_1.time_ and arg_51_1.time_ < var_54_20 + var_54_21 then
				local var_54_22 = (arg_51_1.time_ - var_54_20) / var_54_21
				local var_54_23 = Vector3.New(0, 100, 0)

				var_54_19.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos404001ui_story, var_54_23, var_54_22)

				local var_54_24 = manager.ui.mainCamera.transform.position - var_54_19.position

				var_54_19.forward = Vector3.New(var_54_24.x, var_54_24.y, var_54_24.z)

				local var_54_25 = var_54_19.localEulerAngles

				var_54_25.z = 0
				var_54_25.x = 0
				var_54_19.localEulerAngles = var_54_25
			end

			if arg_51_1.time_ >= var_54_20 + var_54_21 and arg_51_1.time_ < var_54_20 + var_54_21 + arg_54_0 then
				var_54_19.localPosition = Vector3.New(0, 100, 0)

				local var_54_26 = manager.ui.mainCamera.transform.position - var_54_19.position

				var_54_19.forward = Vector3.New(var_54_26.x, var_54_26.y, var_54_26.z)

				local var_54_27 = var_54_19.localEulerAngles

				var_54_27.z = 0
				var_54_27.x = 0
				var_54_19.localEulerAngles = var_54_27
			end

			local var_54_28 = 0
			local var_54_29 = 1.2

			if var_54_28 < arg_51_1.time_ and arg_51_1.time_ <= var_54_28 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, false)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_30 = arg_51_1:GetWordFromCfg(322062012)
				local var_54_31 = arg_51_1:FormatText(var_54_30.content)

				arg_51_1.text_.text = var_54_31

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_32 = 48
				local var_54_33 = utf8.len(var_54_31)
				local var_54_34 = var_54_32 <= 0 and var_54_29 or var_54_29 * (var_54_33 / var_54_32)

				if var_54_34 > 0 and var_54_29 < var_54_34 then
					arg_51_1.talkMaxDuration = var_54_34

					if var_54_34 + var_54_28 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_34 + var_54_28
					end
				end

				arg_51_1.text_.text = var_54_31
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)
				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_35 = math.max(var_54_29, arg_51_1.talkMaxDuration)

			if var_54_28 <= arg_51_1.time_ and arg_51_1.time_ < var_54_28 + var_54_35 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_28) / var_54_35

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_28 + var_54_35 and arg_51_1.time_ < var_54_28 + var_54_35 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1156ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_51_1:InitPlayNodeList()
	end,
	Play322062013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 322062013
		arg_55_1.duration_ = 5

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play322062014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = 0
			local var_58_1 = 1.725

			if var_58_0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_0 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, false)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_2 = arg_55_1:GetWordFromCfg(322062013)
				local var_58_3 = arg_55_1:FormatText(var_58_2.content)

				arg_55_1.text_.text = var_58_3

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_4 = 69
				local var_58_5 = utf8.len(var_58_3)
				local var_58_6 = var_58_4 <= 0 and var_58_1 or var_58_1 * (var_58_5 / var_58_4)

				if var_58_6 > 0 and var_58_1 < var_58_6 then
					arg_55_1.talkMaxDuration = var_58_6

					if var_58_6 + var_58_0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_6 + var_58_0
					end
				end

				arg_55_1.text_.text = var_58_3
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)
				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_7 = math.max(var_58_1, arg_55_1.talkMaxDuration)

			if var_58_0 <= arg_55_1.time_ and arg_55_1.time_ < var_58_0 + var_58_7 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_0) / var_58_7

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_0 + var_58_7 and arg_55_1.time_ < var_58_0 + var_58_7 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play322062014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 322062014
		arg_59_1.duration_ = 4.17

		local var_59_0 = {
			zh = 2.8,
			ja = 4.166
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
				arg_59_0:Play322062015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = arg_59_1.actors_["404001ui_story"].transform
			local var_62_1 = 0

			if var_62_1 < arg_59_1.time_ and arg_59_1.time_ <= var_62_1 + arg_62_0 then
				arg_59_1.var_.moveOldPos404001ui_story = var_62_0.localPosition
			end

			local var_62_2 = 0.001

			if var_62_1 <= arg_59_1.time_ and arg_59_1.time_ < var_62_1 + var_62_2 then
				local var_62_3 = (arg_59_1.time_ - var_62_1) / var_62_2
				local var_62_4 = Vector3.New(0, -1.55, -5.5)

				var_62_0.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos404001ui_story, var_62_4, var_62_3)

				local var_62_5 = manager.ui.mainCamera.transform.position - var_62_0.position

				var_62_0.forward = Vector3.New(var_62_5.x, var_62_5.y, var_62_5.z)

				local var_62_6 = var_62_0.localEulerAngles

				var_62_6.z = 0
				var_62_6.x = 0
				var_62_0.localEulerAngles = var_62_6
			end

			if arg_59_1.time_ >= var_62_1 + var_62_2 and arg_59_1.time_ < var_62_1 + var_62_2 + arg_62_0 then
				var_62_0.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_62_7 = manager.ui.mainCamera.transform.position - var_62_0.position

				var_62_0.forward = Vector3.New(var_62_7.x, var_62_7.y, var_62_7.z)

				local var_62_8 = var_62_0.localEulerAngles

				var_62_8.z = 0
				var_62_8.x = 0
				var_62_0.localEulerAngles = var_62_8
			end

			local var_62_9 = arg_59_1.actors_["404001ui_story"]
			local var_62_10 = 0

			if var_62_10 < arg_59_1.time_ and arg_59_1.time_ <= var_62_10 + arg_62_0 and not isNil(var_62_9) and arg_59_1.var_.characterEffect404001ui_story == nil then
				arg_59_1.var_.characterEffect404001ui_story = var_62_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_11 = 0.200000002980232

			if var_62_10 <= arg_59_1.time_ and arg_59_1.time_ < var_62_10 + var_62_11 and not isNil(var_62_9) then
				local var_62_12 = (arg_59_1.time_ - var_62_10) / var_62_11

				if arg_59_1.var_.characterEffect404001ui_story and not isNil(var_62_9) then
					arg_59_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_59_1.time_ >= var_62_10 + var_62_11 and arg_59_1.time_ < var_62_10 + var_62_11 + arg_62_0 and not isNil(var_62_9) and arg_59_1.var_.characterEffect404001ui_story then
				arg_59_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_62_13 = 0

			if var_62_13 < arg_59_1.time_ and arg_59_1.time_ <= var_62_13 + arg_62_0 then
				arg_59_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_62_14 = 0

			if var_62_14 < arg_59_1.time_ and arg_59_1.time_ <= var_62_14 + arg_62_0 then
				arg_59_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva", "EmotionTimelineAnimator")
			end

			local var_62_15 = 0
			local var_62_16 = 0.275

			if var_62_15 < arg_59_1.time_ and arg_59_1.time_ <= var_62_15 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				local var_62_17 = arg_59_1:FormatText(StoryNameCfg[668].name)

				arg_59_1.leftNameTxt_.text = var_62_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_18 = arg_59_1:GetWordFromCfg(322062014)
				local var_62_19 = arg_59_1:FormatText(var_62_18.content)

				arg_59_1.text_.text = var_62_19

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_20 = 11
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

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062014", "story_v_out_322062.awb") ~= 0 then
					local var_62_23 = manager.audio:GetVoiceLength("story_v_out_322062", "322062014", "story_v_out_322062.awb") / 1000

					if var_62_23 + var_62_15 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_23 + var_62_15
					end

					if var_62_18.prefab_name ~= "" and arg_59_1.actors_[var_62_18.prefab_name] ~= nil then
						local var_62_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_18.prefab_name].transform, "story_v_out_322062", "322062014", "story_v_out_322062.awb")

						arg_59_1:RecordAudio("322062014", var_62_24)
						arg_59_1:RecordAudio("322062014", var_62_24)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_322062", "322062014", "story_v_out_322062.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_322062", "322062014", "story_v_out_322062.awb")
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
				actorName = "404001ui_story",
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
	Play322062015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 322062015
		arg_63_1.duration_ = 4.97

		local var_63_0 = {
			zh = 4.1,
			ja = 4.966
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
				arg_63_0:Play322062016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = arg_63_1.actors_["1284ui_story"].transform
			local var_66_1 = 0

			if var_66_1 < arg_63_1.time_ and arg_63_1.time_ <= var_66_1 + arg_66_0 then
				arg_63_1.var_.moveOldPos1284ui_story = var_66_0.localPosition
			end

			local var_66_2 = 0.001

			if var_66_1 <= arg_63_1.time_ and arg_63_1.time_ < var_66_1 + var_66_2 then
				local var_66_3 = (arg_63_1.time_ - var_66_1) / var_66_2
				local var_66_4 = Vector3.New(-0.7, -0.985, -6.22)

				var_66_0.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPos1284ui_story, var_66_4, var_66_3)

				local var_66_5 = manager.ui.mainCamera.transform.position - var_66_0.position

				var_66_0.forward = Vector3.New(var_66_5.x, var_66_5.y, var_66_5.z)

				local var_66_6 = var_66_0.localEulerAngles

				var_66_6.z = 0
				var_66_6.x = 0
				var_66_0.localEulerAngles = var_66_6
			end

			if arg_63_1.time_ >= var_66_1 + var_66_2 and arg_63_1.time_ < var_66_1 + var_66_2 + arg_66_0 then
				var_66_0.localPosition = Vector3.New(-0.7, -0.985, -6.22)

				local var_66_7 = manager.ui.mainCamera.transform.position - var_66_0.position

				var_66_0.forward = Vector3.New(var_66_7.x, var_66_7.y, var_66_7.z)

				local var_66_8 = var_66_0.localEulerAngles

				var_66_8.z = 0
				var_66_8.x = 0
				var_66_0.localEulerAngles = var_66_8
			end

			local var_66_9 = arg_63_1.actors_["404001ui_story"].transform
			local var_66_10 = 0

			if var_66_10 < arg_63_1.time_ and arg_63_1.time_ <= var_66_10 + arg_66_0 then
				arg_63_1.var_.moveOldPos404001ui_story = var_66_9.localPosition
			end

			local var_66_11 = 0.001

			if var_66_10 <= arg_63_1.time_ and arg_63_1.time_ < var_66_10 + var_66_11 then
				local var_66_12 = (arg_63_1.time_ - var_66_10) / var_66_11
				local var_66_13 = Vector3.New(0, 100, 0)

				var_66_9.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPos404001ui_story, var_66_13, var_66_12)

				local var_66_14 = manager.ui.mainCamera.transform.position - var_66_9.position

				var_66_9.forward = Vector3.New(var_66_14.x, var_66_14.y, var_66_14.z)

				local var_66_15 = var_66_9.localEulerAngles

				var_66_15.z = 0
				var_66_15.x = 0
				var_66_9.localEulerAngles = var_66_15
			end

			if arg_63_1.time_ >= var_66_10 + var_66_11 and arg_63_1.time_ < var_66_10 + var_66_11 + arg_66_0 then
				var_66_9.localPosition = Vector3.New(0, 100, 0)

				local var_66_16 = manager.ui.mainCamera.transform.position - var_66_9.position

				var_66_9.forward = Vector3.New(var_66_16.x, var_66_16.y, var_66_16.z)

				local var_66_17 = var_66_9.localEulerAngles

				var_66_17.z = 0
				var_66_17.x = 0
				var_66_9.localEulerAngles = var_66_17
			end

			local var_66_18 = arg_63_1.actors_["1284ui_story"]
			local var_66_19 = 0

			if var_66_19 < arg_63_1.time_ and arg_63_1.time_ <= var_66_19 + arg_66_0 and not isNil(var_66_18) and arg_63_1.var_.characterEffect1284ui_story == nil then
				arg_63_1.var_.characterEffect1284ui_story = var_66_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_20 = 0.200000002980232

			if var_66_19 <= arg_63_1.time_ and arg_63_1.time_ < var_66_19 + var_66_20 and not isNil(var_66_18) then
				local var_66_21 = (arg_63_1.time_ - var_66_19) / var_66_20

				if arg_63_1.var_.characterEffect1284ui_story and not isNil(var_66_18) then
					arg_63_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_63_1.time_ >= var_66_19 + var_66_20 and arg_63_1.time_ < var_66_19 + var_66_20 + arg_66_0 and not isNil(var_66_18) and arg_63_1.var_.characterEffect1284ui_story then
				arg_63_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_66_22 = arg_63_1.actors_["404001ui_story"]
			local var_66_23 = 0

			if var_66_23 < arg_63_1.time_ and arg_63_1.time_ <= var_66_23 + arg_66_0 and not isNil(var_66_22) and arg_63_1.var_.characterEffect404001ui_story == nil then
				arg_63_1.var_.characterEffect404001ui_story = var_66_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_24 = 0.200000002980232

			if var_66_23 <= arg_63_1.time_ and arg_63_1.time_ < var_66_23 + var_66_24 and not isNil(var_66_22) then
				local var_66_25 = (arg_63_1.time_ - var_66_23) / var_66_24

				if arg_63_1.var_.characterEffect404001ui_story and not isNil(var_66_22) then
					local var_66_26 = Mathf.Lerp(0, 0.5, var_66_25)

					arg_63_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_63_1.var_.characterEffect404001ui_story.fillRatio = var_66_26
				end
			end

			if arg_63_1.time_ >= var_66_23 + var_66_24 and arg_63_1.time_ < var_66_23 + var_66_24 + arg_66_0 and not isNil(var_66_22) and arg_63_1.var_.characterEffect404001ui_story then
				local var_66_27 = 0.5

				arg_63_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_63_1.var_.characterEffect404001ui_story.fillRatio = var_66_27
			end

			local var_66_28 = 0

			if var_66_28 < arg_63_1.time_ and arg_63_1.time_ <= var_66_28 + arg_66_0 then
				arg_63_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action1_1")
			end

			local var_66_29 = 0

			if var_66_29 < arg_63_1.time_ and arg_63_1.time_ <= var_66_29 + arg_66_0 then
				arg_63_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_66_30 = 0
			local var_66_31 = 0.475

			if var_66_30 < arg_63_1.time_ and arg_63_1.time_ <= var_66_30 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				local var_66_32 = arg_63_1:FormatText(StoryNameCfg[6].name)

				arg_63_1.leftNameTxt_.text = var_66_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_33 = arg_63_1:GetWordFromCfg(322062015)
				local var_66_34 = arg_63_1:FormatText(var_66_33.content)

				arg_63_1.text_.text = var_66_34

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_35 = 19
				local var_66_36 = utf8.len(var_66_34)
				local var_66_37 = var_66_35 <= 0 and var_66_31 or var_66_31 * (var_66_36 / var_66_35)

				if var_66_37 > 0 and var_66_31 < var_66_37 then
					arg_63_1.talkMaxDuration = var_66_37

					if var_66_37 + var_66_30 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_37 + var_66_30
					end
				end

				arg_63_1.text_.text = var_66_34
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062015", "story_v_out_322062.awb") ~= 0 then
					local var_66_38 = manager.audio:GetVoiceLength("story_v_out_322062", "322062015", "story_v_out_322062.awb") / 1000

					if var_66_38 + var_66_30 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_38 + var_66_30
					end

					if var_66_33.prefab_name ~= "" and arg_63_1.actors_[var_66_33.prefab_name] ~= nil then
						local var_66_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_33.prefab_name].transform, "story_v_out_322062", "322062015", "story_v_out_322062.awb")

						arg_63_1:RecordAudio("322062015", var_66_39)
						arg_63_1:RecordAudio("322062015", var_66_39)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_322062", "322062015", "story_v_out_322062.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_322062", "322062015", "story_v_out_322062.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_40 = math.max(var_66_31, arg_63_1.talkMaxDuration)

			if var_66_30 <= arg_63_1.time_ and arg_63_1.time_ < var_66_30 + var_66_40 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_30) / var_66_40

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_30 + var_66_40 and arg_63_1.time_ < var_66_30 + var_66_40 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_63_1:InitPlayNodeList()
	end,
	Play322062016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 322062016
		arg_67_1.duration_ = 8.33

		local var_67_0 = {
			zh = 5.833,
			ja = 8.333
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
				arg_67_0:Play322062017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = arg_67_1.actors_["1156ui_story"].transform
			local var_70_1 = 0

			if var_70_1 < arg_67_1.time_ and arg_67_1.time_ <= var_70_1 + arg_70_0 then
				arg_67_1.var_.moveOldPos1156ui_story = var_70_0.localPosition
			end

			local var_70_2 = 0.001

			if var_70_1 <= arg_67_1.time_ and arg_67_1.time_ < var_70_1 + var_70_2 then
				local var_70_3 = (arg_67_1.time_ - var_70_1) / var_70_2
				local var_70_4 = Vector3.New(0.9, -1.1, -6.18)

				var_70_0.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos1156ui_story, var_70_4, var_70_3)

				local var_70_5 = manager.ui.mainCamera.transform.position - var_70_0.position

				var_70_0.forward = Vector3.New(var_70_5.x, var_70_5.y, var_70_5.z)

				local var_70_6 = var_70_0.localEulerAngles

				var_70_6.z = 0
				var_70_6.x = 0
				var_70_0.localEulerAngles = var_70_6
			end

			if arg_67_1.time_ >= var_70_1 + var_70_2 and arg_67_1.time_ < var_70_1 + var_70_2 + arg_70_0 then
				var_70_0.localPosition = Vector3.New(0.9, -1.1, -6.18)

				local var_70_7 = manager.ui.mainCamera.transform.position - var_70_0.position

				var_70_0.forward = Vector3.New(var_70_7.x, var_70_7.y, var_70_7.z)

				local var_70_8 = var_70_0.localEulerAngles

				var_70_8.z = 0
				var_70_8.x = 0
				var_70_0.localEulerAngles = var_70_8
			end

			local var_70_9 = arg_67_1.actors_["1156ui_story"]
			local var_70_10 = 0

			if var_70_10 < arg_67_1.time_ and arg_67_1.time_ <= var_70_10 + arg_70_0 and not isNil(var_70_9) and arg_67_1.var_.characterEffect1156ui_story == nil then
				arg_67_1.var_.characterEffect1156ui_story = var_70_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_11 = 0.200000002980232

			if var_70_10 <= arg_67_1.time_ and arg_67_1.time_ < var_70_10 + var_70_11 and not isNil(var_70_9) then
				local var_70_12 = (arg_67_1.time_ - var_70_10) / var_70_11

				if arg_67_1.var_.characterEffect1156ui_story and not isNil(var_70_9) then
					arg_67_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_67_1.time_ >= var_70_10 + var_70_11 and arg_67_1.time_ < var_70_10 + var_70_11 + arg_70_0 and not isNil(var_70_9) and arg_67_1.var_.characterEffect1156ui_story then
				arg_67_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			local var_70_13 = arg_67_1.actors_["1284ui_story"]
			local var_70_14 = 0

			if var_70_14 < arg_67_1.time_ and arg_67_1.time_ <= var_70_14 + arg_70_0 and not isNil(var_70_13) and arg_67_1.var_.characterEffect1284ui_story == nil then
				arg_67_1.var_.characterEffect1284ui_story = var_70_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_15 = 0.200000002980232

			if var_70_14 <= arg_67_1.time_ and arg_67_1.time_ < var_70_14 + var_70_15 and not isNil(var_70_13) then
				local var_70_16 = (arg_67_1.time_ - var_70_14) / var_70_15

				if arg_67_1.var_.characterEffect1284ui_story and not isNil(var_70_13) then
					local var_70_17 = Mathf.Lerp(0, 0.5, var_70_16)

					arg_67_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_67_1.var_.characterEffect1284ui_story.fillRatio = var_70_17
				end
			end

			if arg_67_1.time_ >= var_70_14 + var_70_15 and arg_67_1.time_ < var_70_14 + var_70_15 + arg_70_0 and not isNil(var_70_13) and arg_67_1.var_.characterEffect1284ui_story then
				local var_70_18 = 0.5

				arg_67_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_67_1.var_.characterEffect1284ui_story.fillRatio = var_70_18
			end

			local var_70_19 = 0

			if var_70_19 < arg_67_1.time_ and arg_67_1.time_ <= var_70_19 + arg_70_0 then
				arg_67_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action1_1")
			end

			local var_70_20 = 0

			if var_70_20 < arg_67_1.time_ and arg_67_1.time_ <= var_70_20 + arg_70_0 then
				arg_67_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_70_21 = 0
			local var_70_22 = 0.6

			if var_70_21 < arg_67_1.time_ and arg_67_1.time_ <= var_70_21 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				local var_70_23 = arg_67_1:FormatText(StoryNameCfg[605].name)

				arg_67_1.leftNameTxt_.text = var_70_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_24 = arg_67_1:GetWordFromCfg(322062016)
				local var_70_25 = arg_67_1:FormatText(var_70_24.content)

				arg_67_1.text_.text = var_70_25

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_26 = 24
				local var_70_27 = utf8.len(var_70_25)
				local var_70_28 = var_70_26 <= 0 and var_70_22 or var_70_22 * (var_70_27 / var_70_26)

				if var_70_28 > 0 and var_70_22 < var_70_28 then
					arg_67_1.talkMaxDuration = var_70_28

					if var_70_28 + var_70_21 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_28 + var_70_21
					end
				end

				arg_67_1.text_.text = var_70_25
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062016", "story_v_out_322062.awb") ~= 0 then
					local var_70_29 = manager.audio:GetVoiceLength("story_v_out_322062", "322062016", "story_v_out_322062.awb") / 1000

					if var_70_29 + var_70_21 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_29 + var_70_21
					end

					if var_70_24.prefab_name ~= "" and arg_67_1.actors_[var_70_24.prefab_name] ~= nil then
						local var_70_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_24.prefab_name].transform, "story_v_out_322062", "322062016", "story_v_out_322062.awb")

						arg_67_1:RecordAudio("322062016", var_70_30)
						arg_67_1:RecordAudio("322062016", var_70_30)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_322062", "322062016", "story_v_out_322062.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_322062", "322062016", "story_v_out_322062.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_31 = math.max(var_70_22, arg_67_1.talkMaxDuration)

			if var_70_21 <= arg_67_1.time_ and arg_67_1.time_ < var_70_21 + var_70_31 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_21) / var_70_31

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_21 + var_70_31 and arg_67_1.time_ < var_70_21 + var_70_31 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1156ui_story",
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
	Play322062017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 322062017
		arg_71_1.duration_ = 5.43

		local var_71_0 = {
			zh = 5.433,
			ja = 5.133
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
				arg_71_0:Play322062018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = arg_71_1.actors_["404001ui_story"].transform
			local var_74_1 = 0

			if var_74_1 < arg_71_1.time_ and arg_71_1.time_ <= var_74_1 + arg_74_0 then
				arg_71_1.var_.moveOldPos404001ui_story = var_74_0.localPosition
			end

			local var_74_2 = 0.001

			if var_74_1 <= arg_71_1.time_ and arg_71_1.time_ < var_74_1 + var_74_2 then
				local var_74_3 = (arg_71_1.time_ - var_74_1) / var_74_2
				local var_74_4 = Vector3.New(0, -1.55, -5.5)

				var_74_0.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos404001ui_story, var_74_4, var_74_3)

				local var_74_5 = manager.ui.mainCamera.transform.position - var_74_0.position

				var_74_0.forward = Vector3.New(var_74_5.x, var_74_5.y, var_74_5.z)

				local var_74_6 = var_74_0.localEulerAngles

				var_74_6.z = 0
				var_74_6.x = 0
				var_74_0.localEulerAngles = var_74_6
			end

			if arg_71_1.time_ >= var_74_1 + var_74_2 and arg_71_1.time_ < var_74_1 + var_74_2 + arg_74_0 then
				var_74_0.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_74_7 = manager.ui.mainCamera.transform.position - var_74_0.position

				var_74_0.forward = Vector3.New(var_74_7.x, var_74_7.y, var_74_7.z)

				local var_74_8 = var_74_0.localEulerAngles

				var_74_8.z = 0
				var_74_8.x = 0
				var_74_0.localEulerAngles = var_74_8
			end

			local var_74_9 = arg_71_1.actors_["1156ui_story"].transform
			local var_74_10 = 0

			if var_74_10 < arg_71_1.time_ and arg_71_1.time_ <= var_74_10 + arg_74_0 then
				arg_71_1.var_.moveOldPos1156ui_story = var_74_9.localPosition
			end

			local var_74_11 = 0.001

			if var_74_10 <= arg_71_1.time_ and arg_71_1.time_ < var_74_10 + var_74_11 then
				local var_74_12 = (arg_71_1.time_ - var_74_10) / var_74_11
				local var_74_13 = Vector3.New(0, 100, 0)

				var_74_9.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos1156ui_story, var_74_13, var_74_12)

				local var_74_14 = manager.ui.mainCamera.transform.position - var_74_9.position

				var_74_9.forward = Vector3.New(var_74_14.x, var_74_14.y, var_74_14.z)

				local var_74_15 = var_74_9.localEulerAngles

				var_74_15.z = 0
				var_74_15.x = 0
				var_74_9.localEulerAngles = var_74_15
			end

			if arg_71_1.time_ >= var_74_10 + var_74_11 and arg_71_1.time_ < var_74_10 + var_74_11 + arg_74_0 then
				var_74_9.localPosition = Vector3.New(0, 100, 0)

				local var_74_16 = manager.ui.mainCamera.transform.position - var_74_9.position

				var_74_9.forward = Vector3.New(var_74_16.x, var_74_16.y, var_74_16.z)

				local var_74_17 = var_74_9.localEulerAngles

				var_74_17.z = 0
				var_74_17.x = 0
				var_74_9.localEulerAngles = var_74_17
			end

			local var_74_18 = arg_71_1.actors_["1284ui_story"].transform
			local var_74_19 = 0

			if var_74_19 < arg_71_1.time_ and arg_71_1.time_ <= var_74_19 + arg_74_0 then
				arg_71_1.var_.moveOldPos1284ui_story = var_74_18.localPosition
			end

			local var_74_20 = 0.001

			if var_74_19 <= arg_71_1.time_ and arg_71_1.time_ < var_74_19 + var_74_20 then
				local var_74_21 = (arg_71_1.time_ - var_74_19) / var_74_20
				local var_74_22 = Vector3.New(0, 100, 0)

				var_74_18.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos1284ui_story, var_74_22, var_74_21)

				local var_74_23 = manager.ui.mainCamera.transform.position - var_74_18.position

				var_74_18.forward = Vector3.New(var_74_23.x, var_74_23.y, var_74_23.z)

				local var_74_24 = var_74_18.localEulerAngles

				var_74_24.z = 0
				var_74_24.x = 0
				var_74_18.localEulerAngles = var_74_24
			end

			if arg_71_1.time_ >= var_74_19 + var_74_20 and arg_71_1.time_ < var_74_19 + var_74_20 + arg_74_0 then
				var_74_18.localPosition = Vector3.New(0, 100, 0)

				local var_74_25 = manager.ui.mainCamera.transform.position - var_74_18.position

				var_74_18.forward = Vector3.New(var_74_25.x, var_74_25.y, var_74_25.z)

				local var_74_26 = var_74_18.localEulerAngles

				var_74_26.z = 0
				var_74_26.x = 0
				var_74_18.localEulerAngles = var_74_26
			end

			local var_74_27 = arg_71_1.actors_["404001ui_story"]
			local var_74_28 = 0

			if var_74_28 < arg_71_1.time_ and arg_71_1.time_ <= var_74_28 + arg_74_0 and not isNil(var_74_27) and arg_71_1.var_.characterEffect404001ui_story == nil then
				arg_71_1.var_.characterEffect404001ui_story = var_74_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_29 = 0.200000002980232

			if var_74_28 <= arg_71_1.time_ and arg_71_1.time_ < var_74_28 + var_74_29 and not isNil(var_74_27) then
				local var_74_30 = (arg_71_1.time_ - var_74_28) / var_74_29

				if arg_71_1.var_.characterEffect404001ui_story and not isNil(var_74_27) then
					arg_71_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_71_1.time_ >= var_74_28 + var_74_29 and arg_71_1.time_ < var_74_28 + var_74_29 + arg_74_0 and not isNil(var_74_27) and arg_71_1.var_.characterEffect404001ui_story then
				arg_71_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_74_31 = arg_71_1.actors_["1156ui_story"]
			local var_74_32 = 0

			if var_74_32 < arg_71_1.time_ and arg_71_1.time_ <= var_74_32 + arg_74_0 and not isNil(var_74_31) and arg_71_1.var_.characterEffect1156ui_story == nil then
				arg_71_1.var_.characterEffect1156ui_story = var_74_31:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_33 = 0.200000002980232

			if var_74_32 <= arg_71_1.time_ and arg_71_1.time_ < var_74_32 + var_74_33 and not isNil(var_74_31) then
				local var_74_34 = (arg_71_1.time_ - var_74_32) / var_74_33

				if arg_71_1.var_.characterEffect1156ui_story and not isNil(var_74_31) then
					local var_74_35 = Mathf.Lerp(0, 0.5, var_74_34)

					arg_71_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_71_1.var_.characterEffect1156ui_story.fillRatio = var_74_35
				end
			end

			if arg_71_1.time_ >= var_74_32 + var_74_33 and arg_71_1.time_ < var_74_32 + var_74_33 + arg_74_0 and not isNil(var_74_31) and arg_71_1.var_.characterEffect1156ui_story then
				local var_74_36 = 0.5

				arg_71_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_71_1.var_.characterEffect1156ui_story.fillRatio = var_74_36
			end

			local var_74_37 = 0

			if var_74_37 < arg_71_1.time_ and arg_71_1.time_ <= var_74_37 + arg_74_0 then
				arg_71_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action2_1")
			end

			local var_74_38 = 0

			if var_74_38 < arg_71_1.time_ and arg_71_1.time_ <= var_74_38 + arg_74_0 then
				arg_71_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_74_39 = 0
			local var_74_40 = 0.425

			if var_74_39 < arg_71_1.time_ and arg_71_1.time_ <= var_74_39 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				local var_74_41 = arg_71_1:FormatText(StoryNameCfg[668].name)

				arg_71_1.leftNameTxt_.text = var_74_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_42 = arg_71_1:GetWordFromCfg(322062017)
				local var_74_43 = arg_71_1:FormatText(var_74_42.content)

				arg_71_1.text_.text = var_74_43

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_44 = 17
				local var_74_45 = utf8.len(var_74_43)
				local var_74_46 = var_74_44 <= 0 and var_74_40 or var_74_40 * (var_74_45 / var_74_44)

				if var_74_46 > 0 and var_74_40 < var_74_46 then
					arg_71_1.talkMaxDuration = var_74_46

					if var_74_46 + var_74_39 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_46 + var_74_39
					end
				end

				arg_71_1.text_.text = var_74_43
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062017", "story_v_out_322062.awb") ~= 0 then
					local var_74_47 = manager.audio:GetVoiceLength("story_v_out_322062", "322062017", "story_v_out_322062.awb") / 1000

					if var_74_47 + var_74_39 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_47 + var_74_39
					end

					if var_74_42.prefab_name ~= "" and arg_71_1.actors_[var_74_42.prefab_name] ~= nil then
						local var_74_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_42.prefab_name].transform, "story_v_out_322062", "322062017", "story_v_out_322062.awb")

						arg_71_1:RecordAudio("322062017", var_74_48)
						arg_71_1:RecordAudio("322062017", var_74_48)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_322062", "322062017", "story_v_out_322062.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_322062", "322062017", "story_v_out_322062.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_49 = math.max(var_74_40, arg_71_1.talkMaxDuration)

			if var_74_39 <= arg_71_1.time_ and arg_71_1.time_ < var_74_39 + var_74_49 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_39) / var_74_49

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_39 + var_74_49 and arg_71_1.time_ < var_74_39 + var_74_49 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1156ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1284ui_story",
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
	Play322062018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 322062018
		arg_75_1.duration_ = 5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play322062019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = "10104ui_story"

			if arg_75_1.actors_[var_78_0] == nil then
				local var_78_1 = Asset.Load("Char/" .. "10104ui_story")

				if not isNil(var_78_1) then
					local var_78_2 = Object.Instantiate(Asset.Load("Char/" .. "10104ui_story"), arg_75_1.stage_.transform)

					var_78_2.name = var_78_0
					var_78_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_75_1.actors_[var_78_0] = var_78_2

					local var_78_3 = var_78_2:GetComponentInChildren(typeof(CharacterEffect))

					var_78_3.enabled = true

					local var_78_4 = GameObjectTools.GetOrAddComponent(var_78_2, typeof(DynamicBoneHelper))

					if var_78_4 then
						var_78_4:EnableDynamicBone(false)
					end

					arg_75_1:ShowWeapon(var_78_3.transform, false)

					arg_75_1.var_[var_78_0 .. "Animator"] = var_78_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_75_1.var_[var_78_0 .. "Animator"].applyRootMotion = true
					arg_75_1.var_[var_78_0 .. "LipSync"] = var_78_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_78_5 = arg_75_1.actors_["10104ui_story"].transform
			local var_78_6 = 0

			if var_78_6 < arg_75_1.time_ and arg_75_1.time_ <= var_78_6 + arg_78_0 then
				arg_75_1.var_.moveOldPos10104ui_story = var_78_5.localPosition
			end

			local var_78_7 = 0.001

			if var_78_6 <= arg_75_1.time_ and arg_75_1.time_ < var_78_6 + var_78_7 then
				local var_78_8 = (arg_75_1.time_ - var_78_6) / var_78_7
				local var_78_9 = Vector3.New(0.99, -1.12, -5.99)

				var_78_5.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos10104ui_story, var_78_9, var_78_8)

				local var_78_10 = manager.ui.mainCamera.transform.position - var_78_5.position

				var_78_5.forward = Vector3.New(var_78_10.x, var_78_10.y, var_78_10.z)

				local var_78_11 = var_78_5.localEulerAngles

				var_78_11.z = 0
				var_78_11.x = 0
				var_78_5.localEulerAngles = var_78_11
			end

			if arg_75_1.time_ >= var_78_6 + var_78_7 and arg_75_1.time_ < var_78_6 + var_78_7 + arg_78_0 then
				var_78_5.localPosition = Vector3.New(0.99, -1.12, -5.99)

				local var_78_12 = manager.ui.mainCamera.transform.position - var_78_5.position

				var_78_5.forward = Vector3.New(var_78_12.x, var_78_12.y, var_78_12.z)

				local var_78_13 = var_78_5.localEulerAngles

				var_78_13.z = 0
				var_78_13.x = 0
				var_78_5.localEulerAngles = var_78_13
			end

			local var_78_14 = arg_75_1.actors_["404001ui_story"].transform
			local var_78_15 = 0

			if var_78_15 < arg_75_1.time_ and arg_75_1.time_ <= var_78_15 + arg_78_0 then
				arg_75_1.var_.moveOldPos404001ui_story = var_78_14.localPosition
			end

			local var_78_16 = 0.001

			if var_78_15 <= arg_75_1.time_ and arg_75_1.time_ < var_78_15 + var_78_16 then
				local var_78_17 = (arg_75_1.time_ - var_78_15) / var_78_16
				local var_78_18 = Vector3.New(-0.8, -1.55, -5.5)

				var_78_14.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos404001ui_story, var_78_18, var_78_17)

				local var_78_19 = manager.ui.mainCamera.transform.position - var_78_14.position

				var_78_14.forward = Vector3.New(var_78_19.x, var_78_19.y, var_78_19.z)

				local var_78_20 = var_78_14.localEulerAngles

				var_78_20.z = 0
				var_78_20.x = 0
				var_78_14.localEulerAngles = var_78_20
			end

			if arg_75_1.time_ >= var_78_15 + var_78_16 and arg_75_1.time_ < var_78_15 + var_78_16 + arg_78_0 then
				var_78_14.localPosition = Vector3.New(-0.8, -1.55, -5.5)

				local var_78_21 = manager.ui.mainCamera.transform.position - var_78_14.position

				var_78_14.forward = Vector3.New(var_78_21.x, var_78_21.y, var_78_21.z)

				local var_78_22 = var_78_14.localEulerAngles

				var_78_22.z = 0
				var_78_22.x = 0
				var_78_14.localEulerAngles = var_78_22
			end

			local var_78_23 = arg_75_1.actors_["10104ui_story"]
			local var_78_24 = 0

			if var_78_24 < arg_75_1.time_ and arg_75_1.time_ <= var_78_24 + arg_78_0 and not isNil(var_78_23) and arg_75_1.var_.characterEffect10104ui_story == nil then
				arg_75_1.var_.characterEffect10104ui_story = var_78_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_25 = 0.200000002980232

			if var_78_24 <= arg_75_1.time_ and arg_75_1.time_ < var_78_24 + var_78_25 and not isNil(var_78_23) then
				local var_78_26 = (arg_75_1.time_ - var_78_24) / var_78_25

				if arg_75_1.var_.characterEffect10104ui_story and not isNil(var_78_23) then
					arg_75_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_75_1.time_ >= var_78_24 + var_78_25 and arg_75_1.time_ < var_78_24 + var_78_25 + arg_78_0 and not isNil(var_78_23) and arg_75_1.var_.characterEffect10104ui_story then
				arg_75_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_78_27 = arg_75_1.actors_["404001ui_story"]
			local var_78_28 = 0

			if var_78_28 < arg_75_1.time_ and arg_75_1.time_ <= var_78_28 + arg_78_0 and not isNil(var_78_27) and arg_75_1.var_.characterEffect404001ui_story == nil then
				arg_75_1.var_.characterEffect404001ui_story = var_78_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_29 = 0.200000002980232

			if var_78_28 <= arg_75_1.time_ and arg_75_1.time_ < var_78_28 + var_78_29 and not isNil(var_78_27) then
				local var_78_30 = (arg_75_1.time_ - var_78_28) / var_78_29

				if arg_75_1.var_.characterEffect404001ui_story and not isNil(var_78_27) then
					local var_78_31 = Mathf.Lerp(0, 0.5, var_78_30)

					arg_75_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_75_1.var_.characterEffect404001ui_story.fillRatio = var_78_31
				end
			end

			if arg_75_1.time_ >= var_78_28 + var_78_29 and arg_75_1.time_ < var_78_28 + var_78_29 + arg_78_0 and not isNil(var_78_27) and arg_75_1.var_.characterEffect404001ui_story then
				local var_78_32 = 0.5

				arg_75_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_75_1.var_.characterEffect404001ui_story.fillRatio = var_78_32
			end

			local var_78_33 = 0

			if var_78_33 < arg_75_1.time_ and arg_75_1.time_ <= var_78_33 + arg_78_0 then
				arg_75_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action3_1")
			end

			local var_78_34 = 0

			if var_78_34 < arg_75_1.time_ and arg_75_1.time_ <= var_78_34 + arg_78_0 then
				arg_75_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_78_35 = arg_75_1.actors_["10104ui_story"]
			local var_78_36 = 0

			if var_78_36 < arg_75_1.time_ and arg_75_1.time_ <= var_78_36 + arg_78_0 then
				if arg_75_1.var_.characterEffect10104ui_story == nil then
					arg_75_1.var_.characterEffect10104ui_story = var_78_35:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_78_37 = arg_75_1.var_.characterEffect10104ui_story

				var_78_37.imageEffect:turnOff()

				var_78_37.interferenceEffect.enabled = true
				var_78_37.interferenceEffect.noise = 0.001
				var_78_37.interferenceEffect.simTimeScale = 1
				var_78_37.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_78_38 = arg_75_1.actors_["10104ui_story"]
			local var_78_39 = 0
			local var_78_40 = 5

			if var_78_39 < arg_75_1.time_ and arg_75_1.time_ <= var_78_39 + arg_78_0 then
				if arg_75_1.var_.characterEffect10104ui_story == nil then
					arg_75_1.var_.characterEffect10104ui_story = var_78_38:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_75_1.var_.characterEffect10104ui_story.imageEffect:turnOn(false)
			end

			local var_78_41 = 0
			local var_78_42 = 0.175

			if var_78_41 < arg_75_1.time_ and arg_75_1.time_ <= var_78_41 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				local var_78_43 = arg_75_1:FormatText(StoryNameCfg[1030].name)

				arg_75_1.leftNameTxt_.text = var_78_43

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_44 = arg_75_1:GetWordFromCfg(322062018)
				local var_78_45 = arg_75_1:FormatText(var_78_44.content)

				arg_75_1.text_.text = var_78_45

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_46 = 7
				local var_78_47 = utf8.len(var_78_45)
				local var_78_48 = var_78_46 <= 0 and var_78_42 or var_78_42 * (var_78_47 / var_78_46)

				if var_78_48 > 0 and var_78_42 < var_78_48 then
					arg_75_1.talkMaxDuration = var_78_48

					if var_78_48 + var_78_41 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_48 + var_78_41
					end
				end

				arg_75_1.text_.text = var_78_45
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062018", "story_v_out_322062.awb") ~= 0 then
					local var_78_49 = manager.audio:GetVoiceLength("story_v_out_322062", "322062018", "story_v_out_322062.awb") / 1000

					if var_78_49 + var_78_41 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_49 + var_78_41
					end

					if var_78_44.prefab_name ~= "" and arg_75_1.actors_[var_78_44.prefab_name] ~= nil then
						local var_78_50 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_44.prefab_name].transform, "story_v_out_322062", "322062018", "story_v_out_322062.awb")

						arg_75_1:RecordAudio("322062018", var_78_50)
						arg_75_1:RecordAudio("322062018", var_78_50)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_322062", "322062018", "story_v_out_322062.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_322062", "322062018", "story_v_out_322062.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_51 = math.max(var_78_42, arg_75_1.talkMaxDuration)

			if var_78_41 <= arg_75_1.time_ and arg_75_1.time_ < var_78_41 + var_78_51 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_41) / var_78_51

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_41 + var_78_51 and arg_75_1.time_ < var_78_41 + var_78_51 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "404001ui_story",
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
	Play322062019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 322062019
		arg_79_1.duration_ = 11.03

		local var_79_0 = {
			zh = 8.633,
			ja = 11.033
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
				arg_79_0:Play322062020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = arg_79_1.actors_["404001ui_story"]
			local var_82_1 = 0

			if var_82_1 < arg_79_1.time_ and arg_79_1.time_ <= var_82_1 + arg_82_0 and not isNil(var_82_0) and arg_79_1.var_.characterEffect404001ui_story == nil then
				arg_79_1.var_.characterEffect404001ui_story = var_82_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_2 = 0.200000002980232

			if var_82_1 <= arg_79_1.time_ and arg_79_1.time_ < var_82_1 + var_82_2 and not isNil(var_82_0) then
				local var_82_3 = (arg_79_1.time_ - var_82_1) / var_82_2

				if arg_79_1.var_.characterEffect404001ui_story and not isNil(var_82_0) then
					arg_79_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_79_1.time_ >= var_82_1 + var_82_2 and arg_79_1.time_ < var_82_1 + var_82_2 + arg_82_0 and not isNil(var_82_0) and arg_79_1.var_.characterEffect404001ui_story then
				arg_79_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_82_4 = arg_79_1.actors_["10104ui_story"]
			local var_82_5 = 0

			if var_82_5 < arg_79_1.time_ and arg_79_1.time_ <= var_82_5 + arg_82_0 and not isNil(var_82_4) and arg_79_1.var_.characterEffect10104ui_story == nil then
				arg_79_1.var_.characterEffect10104ui_story = var_82_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_6 = 0.200000002980232

			if var_82_5 <= arg_79_1.time_ and arg_79_1.time_ < var_82_5 + var_82_6 and not isNil(var_82_4) then
				local var_82_7 = (arg_79_1.time_ - var_82_5) / var_82_6

				if arg_79_1.var_.characterEffect10104ui_story and not isNil(var_82_4) then
					local var_82_8 = Mathf.Lerp(0, 0.5, var_82_7)

					arg_79_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_79_1.var_.characterEffect10104ui_story.fillRatio = var_82_8
				end
			end

			if arg_79_1.time_ >= var_82_5 + var_82_6 and arg_79_1.time_ < var_82_5 + var_82_6 + arg_82_0 and not isNil(var_82_4) and arg_79_1.var_.characterEffect10104ui_story then
				local var_82_9 = 0.5

				arg_79_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_79_1.var_.characterEffect10104ui_story.fillRatio = var_82_9
			end

			local var_82_10 = 0

			if var_82_10 < arg_79_1.time_ and arg_79_1.time_ <= var_82_10 + arg_82_0 then
				arg_79_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action2_2")
			end

			local var_82_11 = 0

			if var_82_11 < arg_79_1.time_ and arg_79_1.time_ <= var_82_11 + arg_82_0 then
				arg_79_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_82_12 = 0
			local var_82_13 = 1.05

			if var_82_12 < arg_79_1.time_ and arg_79_1.time_ <= var_82_12 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				local var_82_14 = arg_79_1:FormatText(StoryNameCfg[668].name)

				arg_79_1.leftNameTxt_.text = var_82_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_15 = arg_79_1:GetWordFromCfg(322062019)
				local var_82_16 = arg_79_1:FormatText(var_82_15.content)

				arg_79_1.text_.text = var_82_16

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_17 = 42
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

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062019", "story_v_out_322062.awb") ~= 0 then
					local var_82_20 = manager.audio:GetVoiceLength("story_v_out_322062", "322062019", "story_v_out_322062.awb") / 1000

					if var_82_20 + var_82_12 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_20 + var_82_12
					end

					if var_82_15.prefab_name ~= "" and arg_79_1.actors_[var_82_15.prefab_name] ~= nil then
						local var_82_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_15.prefab_name].transform, "story_v_out_322062", "322062019", "story_v_out_322062.awb")

						arg_79_1:RecordAudio("322062019", var_82_21)
						arg_79_1:RecordAudio("322062019", var_82_21)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_322062", "322062019", "story_v_out_322062.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_322062", "322062019", "story_v_out_322062.awb")
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
	Play322062020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 322062020
		arg_83_1.duration_ = 16

		local var_83_0 = {
			zh = 5.8,
			ja = 16
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
				arg_83_0:Play322062021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = arg_83_1.actors_["10104ui_story"]
			local var_86_1 = 0

			if var_86_1 < arg_83_1.time_ and arg_83_1.time_ <= var_86_1 + arg_86_0 and not isNil(var_86_0) and arg_83_1.var_.characterEffect10104ui_story == nil then
				arg_83_1.var_.characterEffect10104ui_story = var_86_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_2 = 0.200000002980232

			if var_86_1 <= arg_83_1.time_ and arg_83_1.time_ < var_86_1 + var_86_2 and not isNil(var_86_0) then
				local var_86_3 = (arg_83_1.time_ - var_86_1) / var_86_2

				if arg_83_1.var_.characterEffect10104ui_story and not isNil(var_86_0) then
					arg_83_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_83_1.time_ >= var_86_1 + var_86_2 and arg_83_1.time_ < var_86_1 + var_86_2 + arg_86_0 and not isNil(var_86_0) and arg_83_1.var_.characterEffect10104ui_story then
				arg_83_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_86_4 = arg_83_1.actors_["404001ui_story"]
			local var_86_5 = 0

			if var_86_5 < arg_83_1.time_ and arg_83_1.time_ <= var_86_5 + arg_86_0 and not isNil(var_86_4) and arg_83_1.var_.characterEffect404001ui_story == nil then
				arg_83_1.var_.characterEffect404001ui_story = var_86_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_6 = 0.200000002980232

			if var_86_5 <= arg_83_1.time_ and arg_83_1.time_ < var_86_5 + var_86_6 and not isNil(var_86_4) then
				local var_86_7 = (arg_83_1.time_ - var_86_5) / var_86_6

				if arg_83_1.var_.characterEffect404001ui_story and not isNil(var_86_4) then
					local var_86_8 = Mathf.Lerp(0, 0.5, var_86_7)

					arg_83_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_83_1.var_.characterEffect404001ui_story.fillRatio = var_86_8
				end
			end

			if arg_83_1.time_ >= var_86_5 + var_86_6 and arg_83_1.time_ < var_86_5 + var_86_6 + arg_86_0 and not isNil(var_86_4) and arg_83_1.var_.characterEffect404001ui_story then
				local var_86_9 = 0.5

				arg_83_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_83_1.var_.characterEffect404001ui_story.fillRatio = var_86_9
			end

			local var_86_10 = 0

			if var_86_10 < arg_83_1.time_ and arg_83_1.time_ <= var_86_10 + arg_86_0 then
				arg_83_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action3_2")
			end

			local var_86_11 = arg_83_1.actors_["10104ui_story"]
			local var_86_12 = 0

			if var_86_12 < arg_83_1.time_ and arg_83_1.time_ <= var_86_12 + arg_86_0 then
				if arg_83_1.var_.characterEffect10104ui_story == nil then
					arg_83_1.var_.characterEffect10104ui_story = var_86_11:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_86_13 = arg_83_1.var_.characterEffect10104ui_story

				var_86_13.imageEffect:turnOff()

				var_86_13.interferenceEffect.enabled = true
				var_86_13.interferenceEffect.noise = 0.001
				var_86_13.interferenceEffect.simTimeScale = 1
				var_86_13.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_86_14 = arg_83_1.actors_["10104ui_story"]
			local var_86_15 = 0
			local var_86_16 = 5

			if var_86_15 < arg_83_1.time_ and arg_83_1.time_ <= var_86_15 + arg_86_0 then
				if arg_83_1.var_.characterEffect10104ui_story == nil then
					arg_83_1.var_.characterEffect10104ui_story = var_86_14:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_83_1.var_.characterEffect10104ui_story.imageEffect:turnOn(false)
			end

			local var_86_17 = 0
			local var_86_18 = 0.725

			if var_86_17 < arg_83_1.time_ and arg_83_1.time_ <= var_86_17 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				local var_86_19 = arg_83_1:FormatText(StoryNameCfg[1030].name)

				arg_83_1.leftNameTxt_.text = var_86_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_20 = arg_83_1:GetWordFromCfg(322062020)
				local var_86_21 = arg_83_1:FormatText(var_86_20.content)

				arg_83_1.text_.text = var_86_21

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_22 = 29
				local var_86_23 = utf8.len(var_86_21)
				local var_86_24 = var_86_22 <= 0 and var_86_18 or var_86_18 * (var_86_23 / var_86_22)

				if var_86_24 > 0 and var_86_18 < var_86_24 then
					arg_83_1.talkMaxDuration = var_86_24

					if var_86_24 + var_86_17 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_24 + var_86_17
					end
				end

				arg_83_1.text_.text = var_86_21
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062020", "story_v_out_322062.awb") ~= 0 then
					local var_86_25 = manager.audio:GetVoiceLength("story_v_out_322062", "322062020", "story_v_out_322062.awb") / 1000

					if var_86_25 + var_86_17 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_25 + var_86_17
					end

					if var_86_20.prefab_name ~= "" and arg_83_1.actors_[var_86_20.prefab_name] ~= nil then
						local var_86_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_20.prefab_name].transform, "story_v_out_322062", "322062020", "story_v_out_322062.awb")

						arg_83_1:RecordAudio("322062020", var_86_26)
						arg_83_1:RecordAudio("322062020", var_86_26)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_322062", "322062020", "story_v_out_322062.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_322062", "322062020", "story_v_out_322062.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_27 = math.max(var_86_18, arg_83_1.talkMaxDuration)

			if var_86_17 <= arg_83_1.time_ and arg_83_1.time_ < var_86_17 + var_86_27 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_17) / var_86_27

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_17 + var_86_27 and arg_83_1.time_ < var_86_17 + var_86_27 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play322062021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 322062021
		arg_87_1.duration_ = 5.47

		local var_87_0 = {
			zh = 4.233,
			ja = 5.466
		}
		local var_87_1 = manager.audio:GetLocalizationFlag()

		if var_87_0[var_87_1] ~= nil then
			arg_87_1.duration_ = var_87_0[var_87_1]
		end

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play322062022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = arg_87_1.actors_["404001ui_story"]
			local var_90_1 = 0

			if var_90_1 < arg_87_1.time_ and arg_87_1.time_ <= var_90_1 + arg_90_0 and not isNil(var_90_0) and arg_87_1.var_.characterEffect404001ui_story == nil then
				arg_87_1.var_.characterEffect404001ui_story = var_90_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_2 = 0.200000002980232

			if var_90_1 <= arg_87_1.time_ and arg_87_1.time_ < var_90_1 + var_90_2 and not isNil(var_90_0) then
				local var_90_3 = (arg_87_1.time_ - var_90_1) / var_90_2

				if arg_87_1.var_.characterEffect404001ui_story and not isNil(var_90_0) then
					arg_87_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_87_1.time_ >= var_90_1 + var_90_2 and arg_87_1.time_ < var_90_1 + var_90_2 + arg_90_0 and not isNil(var_90_0) and arg_87_1.var_.characterEffect404001ui_story then
				arg_87_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_90_4 = arg_87_1.actors_["10104ui_story"]
			local var_90_5 = 0

			if var_90_5 < arg_87_1.time_ and arg_87_1.time_ <= var_90_5 + arg_90_0 and not isNil(var_90_4) and arg_87_1.var_.characterEffect10104ui_story == nil then
				arg_87_1.var_.characterEffect10104ui_story = var_90_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_6 = 0.200000002980232

			if var_90_5 <= arg_87_1.time_ and arg_87_1.time_ < var_90_5 + var_90_6 and not isNil(var_90_4) then
				local var_90_7 = (arg_87_1.time_ - var_90_5) / var_90_6

				if arg_87_1.var_.characterEffect10104ui_story and not isNil(var_90_4) then
					local var_90_8 = Mathf.Lerp(0, 0.5, var_90_7)

					arg_87_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_87_1.var_.characterEffect10104ui_story.fillRatio = var_90_8
				end
			end

			if arg_87_1.time_ >= var_90_5 + var_90_6 and arg_87_1.time_ < var_90_5 + var_90_6 + arg_90_0 and not isNil(var_90_4) and arg_87_1.var_.characterEffect10104ui_story then
				local var_90_9 = 0.5

				arg_87_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_87_1.var_.characterEffect10104ui_story.fillRatio = var_90_9
			end

			local var_90_10 = 0
			local var_90_11 = 0.425

			if var_90_10 < arg_87_1.time_ and arg_87_1.time_ <= var_90_10 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				local var_90_12 = arg_87_1:FormatText(StoryNameCfg[668].name)

				arg_87_1.leftNameTxt_.text = var_90_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_13 = arg_87_1:GetWordFromCfg(322062021)
				local var_90_14 = arg_87_1:FormatText(var_90_13.content)

				arg_87_1.text_.text = var_90_14

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_15 = 17
				local var_90_16 = utf8.len(var_90_14)
				local var_90_17 = var_90_15 <= 0 and var_90_11 or var_90_11 * (var_90_16 / var_90_15)

				if var_90_17 > 0 and var_90_11 < var_90_17 then
					arg_87_1.talkMaxDuration = var_90_17

					if var_90_17 + var_90_10 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_17 + var_90_10
					end
				end

				arg_87_1.text_.text = var_90_14
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062021", "story_v_out_322062.awb") ~= 0 then
					local var_90_18 = manager.audio:GetVoiceLength("story_v_out_322062", "322062021", "story_v_out_322062.awb") / 1000

					if var_90_18 + var_90_10 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_18 + var_90_10
					end

					if var_90_13.prefab_name ~= "" and arg_87_1.actors_[var_90_13.prefab_name] ~= nil then
						local var_90_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_13.prefab_name].transform, "story_v_out_322062", "322062021", "story_v_out_322062.awb")

						arg_87_1:RecordAudio("322062021", var_90_19)
						arg_87_1:RecordAudio("322062021", var_90_19)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_322062", "322062021", "story_v_out_322062.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_322062", "322062021", "story_v_out_322062.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_20 = math.max(var_90_11, arg_87_1.talkMaxDuration)

			if var_90_10 <= arg_87_1.time_ and arg_87_1.time_ < var_90_10 + var_90_20 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_10) / var_90_20

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_10 + var_90_20 and arg_87_1.time_ < var_90_10 + var_90_20 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play322062022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 322062022
		arg_91_1.duration_ = 5

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play322062023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = arg_91_1.actors_["10104ui_story"]
			local var_94_1 = 0

			if var_94_1 < arg_91_1.time_ and arg_91_1.time_ <= var_94_1 + arg_94_0 and not isNil(var_94_0) and arg_91_1.var_.characterEffect10104ui_story == nil then
				arg_91_1.var_.characterEffect10104ui_story = var_94_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_2 = 0.200000002980232

			if var_94_1 <= arg_91_1.time_ and arg_91_1.time_ < var_94_1 + var_94_2 and not isNil(var_94_0) then
				local var_94_3 = (arg_91_1.time_ - var_94_1) / var_94_2

				if arg_91_1.var_.characterEffect10104ui_story and not isNil(var_94_0) then
					arg_91_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_91_1.time_ >= var_94_1 + var_94_2 and arg_91_1.time_ < var_94_1 + var_94_2 + arg_94_0 and not isNil(var_94_0) and arg_91_1.var_.characterEffect10104ui_story then
				arg_91_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_94_4 = arg_91_1.actors_["404001ui_story"]
			local var_94_5 = 0

			if var_94_5 < arg_91_1.time_ and arg_91_1.time_ <= var_94_5 + arg_94_0 and not isNil(var_94_4) and arg_91_1.var_.characterEffect404001ui_story == nil then
				arg_91_1.var_.characterEffect404001ui_story = var_94_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_6 = 0.200000002980232

			if var_94_5 <= arg_91_1.time_ and arg_91_1.time_ < var_94_5 + var_94_6 and not isNil(var_94_4) then
				local var_94_7 = (arg_91_1.time_ - var_94_5) / var_94_6

				if arg_91_1.var_.characterEffect404001ui_story and not isNil(var_94_4) then
					local var_94_8 = Mathf.Lerp(0, 0.5, var_94_7)

					arg_91_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_91_1.var_.characterEffect404001ui_story.fillRatio = var_94_8
				end
			end

			if arg_91_1.time_ >= var_94_5 + var_94_6 and arg_91_1.time_ < var_94_5 + var_94_6 + arg_94_0 and not isNil(var_94_4) and arg_91_1.var_.characterEffect404001ui_story then
				local var_94_9 = 0.5

				arg_91_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_91_1.var_.characterEffect404001ui_story.fillRatio = var_94_9
			end

			local var_94_10 = 0

			if var_94_10 < arg_91_1.time_ and arg_91_1.time_ <= var_94_10 + arg_94_0 then
				arg_91_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action1_1")
			end

			local var_94_11 = 0

			if var_94_11 < arg_91_1.time_ and arg_91_1.time_ <= var_94_11 + arg_94_0 then
				arg_91_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_94_12 = arg_91_1.actors_["10104ui_story"]
			local var_94_13 = 0

			if var_94_13 < arg_91_1.time_ and arg_91_1.time_ <= var_94_13 + arg_94_0 then
				if arg_91_1.var_.characterEffect10104ui_story == nil then
					arg_91_1.var_.characterEffect10104ui_story = var_94_12:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_94_14 = arg_91_1.var_.characterEffect10104ui_story

				var_94_14.imageEffect:turnOff()

				var_94_14.interferenceEffect.enabled = true
				var_94_14.interferenceEffect.noise = 0.001
				var_94_14.interferenceEffect.simTimeScale = 1
				var_94_14.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_94_15 = arg_91_1.actors_["10104ui_story"]
			local var_94_16 = 0
			local var_94_17 = 5

			if var_94_16 < arg_91_1.time_ and arg_91_1.time_ <= var_94_16 + arg_94_0 then
				if arg_91_1.var_.characterEffect10104ui_story == nil then
					arg_91_1.var_.characterEffect10104ui_story = var_94_15:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_91_1.var_.characterEffect10104ui_story.imageEffect:turnOn(false)
			end

			local var_94_18 = 0
			local var_94_19 = 0.2

			if var_94_18 < arg_91_1.time_ and arg_91_1.time_ <= var_94_18 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				local var_94_20 = arg_91_1:FormatText(StoryNameCfg[1030].name)

				arg_91_1.leftNameTxt_.text = var_94_20

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_21 = arg_91_1:GetWordFromCfg(322062022)
				local var_94_22 = arg_91_1:FormatText(var_94_21.content)

				arg_91_1.text_.text = var_94_22

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_23 = 8
				local var_94_24 = utf8.len(var_94_22)
				local var_94_25 = var_94_23 <= 0 and var_94_19 or var_94_19 * (var_94_24 / var_94_23)

				if var_94_25 > 0 and var_94_19 < var_94_25 then
					arg_91_1.talkMaxDuration = var_94_25

					if var_94_25 + var_94_18 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_25 + var_94_18
					end
				end

				arg_91_1.text_.text = var_94_22
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062022", "story_v_out_322062.awb") ~= 0 then
					local var_94_26 = manager.audio:GetVoiceLength("story_v_out_322062", "322062022", "story_v_out_322062.awb") / 1000

					if var_94_26 + var_94_18 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_26 + var_94_18
					end

					if var_94_21.prefab_name ~= "" and arg_91_1.actors_[var_94_21.prefab_name] ~= nil then
						local var_94_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_21.prefab_name].transform, "story_v_out_322062", "322062022", "story_v_out_322062.awb")

						arg_91_1:RecordAudio("322062022", var_94_27)
						arg_91_1:RecordAudio("322062022", var_94_27)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_322062", "322062022", "story_v_out_322062.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_322062", "322062022", "story_v_out_322062.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_28 = math.max(var_94_19, arg_91_1.talkMaxDuration)

			if var_94_18 <= arg_91_1.time_ and arg_91_1.time_ < var_94_18 + var_94_28 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_18) / var_94_28

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_18 + var_94_28 and arg_91_1.time_ < var_94_18 + var_94_28 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play322062023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 322062023
		arg_95_1.duration_ = 13.07

		local var_95_0 = {
			zh = 9.766,
			ja = 13.066
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
				arg_95_0:Play322062024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = 0

			if var_98_0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_0 + arg_98_0 then
				arg_95_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action1_1")
			end

			local var_98_1 = 0

			if var_98_1 < arg_95_1.time_ and arg_95_1.time_ <= var_98_1 + arg_98_0 then
				arg_95_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_98_2 = arg_95_1.actors_["10104ui_story"]
			local var_98_3 = 0

			if var_98_3 < arg_95_1.time_ and arg_95_1.time_ <= var_98_3 + arg_98_0 then
				if arg_95_1.var_.characterEffect10104ui_story == nil then
					arg_95_1.var_.characterEffect10104ui_story = var_98_2:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_98_4 = arg_95_1.var_.characterEffect10104ui_story

				var_98_4.imageEffect:turnOff()

				var_98_4.interferenceEffect.enabled = true
				var_98_4.interferenceEffect.noise = 0.001
				var_98_4.interferenceEffect.simTimeScale = 1
				var_98_4.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_98_5 = arg_95_1.actors_["10104ui_story"]
			local var_98_6 = 0
			local var_98_7 = 5

			if var_98_6 < arg_95_1.time_ and arg_95_1.time_ <= var_98_6 + arg_98_0 then
				if arg_95_1.var_.characterEffect10104ui_story == nil then
					arg_95_1.var_.characterEffect10104ui_story = var_98_5:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_95_1.var_.characterEffect10104ui_story.imageEffect:turnOn(false)
			end

			local var_98_8 = 0
			local var_98_9 = 1.1

			if var_98_8 < arg_95_1.time_ and arg_95_1.time_ <= var_98_8 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				local var_98_10 = arg_95_1:FormatText(StoryNameCfg[1030].name)

				arg_95_1.leftNameTxt_.text = var_98_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_11 = arg_95_1:GetWordFromCfg(322062023)
				local var_98_12 = arg_95_1:FormatText(var_98_11.content)

				arg_95_1.text_.text = var_98_12

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_13 = 44
				local var_98_14 = utf8.len(var_98_12)
				local var_98_15 = var_98_13 <= 0 and var_98_9 or var_98_9 * (var_98_14 / var_98_13)

				if var_98_15 > 0 and var_98_9 < var_98_15 then
					arg_95_1.talkMaxDuration = var_98_15

					if var_98_15 + var_98_8 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_15 + var_98_8
					end
				end

				arg_95_1.text_.text = var_98_12
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062023", "story_v_out_322062.awb") ~= 0 then
					local var_98_16 = manager.audio:GetVoiceLength("story_v_out_322062", "322062023", "story_v_out_322062.awb") / 1000

					if var_98_16 + var_98_8 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_16 + var_98_8
					end

					if var_98_11.prefab_name ~= "" and arg_95_1.actors_[var_98_11.prefab_name] ~= nil then
						local var_98_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_11.prefab_name].transform, "story_v_out_322062", "322062023", "story_v_out_322062.awb")

						arg_95_1:RecordAudio("322062023", var_98_17)
						arg_95_1:RecordAudio("322062023", var_98_17)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_322062", "322062023", "story_v_out_322062.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_322062", "322062023", "story_v_out_322062.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_18 = math.max(var_98_9, arg_95_1.talkMaxDuration)

			if var_98_8 <= arg_95_1.time_ and arg_95_1.time_ < var_98_8 + var_98_18 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_8) / var_98_18

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_8 + var_98_18 and arg_95_1.time_ < var_98_8 + var_98_18 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play322062024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 322062024
		arg_99_1.duration_ = 5

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play322062025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = arg_99_1.actors_["10104ui_story"].transform
			local var_102_1 = 0

			if var_102_1 < arg_99_1.time_ and arg_99_1.time_ <= var_102_1 + arg_102_0 then
				arg_99_1.var_.moveOldPos10104ui_story = var_102_0.localPosition
			end

			local var_102_2 = 0.001

			if var_102_1 <= arg_99_1.time_ and arg_99_1.time_ < var_102_1 + var_102_2 then
				local var_102_3 = (arg_99_1.time_ - var_102_1) / var_102_2
				local var_102_4 = Vector3.New(0, 100, 0)

				var_102_0.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos10104ui_story, var_102_4, var_102_3)

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

			local var_102_9 = arg_99_1.actors_["404001ui_story"].transform
			local var_102_10 = 0

			if var_102_10 < arg_99_1.time_ and arg_99_1.time_ <= var_102_10 + arg_102_0 then
				arg_99_1.var_.moveOldPos404001ui_story = var_102_9.localPosition
			end

			local var_102_11 = 0.001

			if var_102_10 <= arg_99_1.time_ and arg_99_1.time_ < var_102_10 + var_102_11 then
				local var_102_12 = (arg_99_1.time_ - var_102_10) / var_102_11
				local var_102_13 = Vector3.New(0, 100, 0)

				var_102_9.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos404001ui_story, var_102_13, var_102_12)

				local var_102_14 = manager.ui.mainCamera.transform.position - var_102_9.position

				var_102_9.forward = Vector3.New(var_102_14.x, var_102_14.y, var_102_14.z)

				local var_102_15 = var_102_9.localEulerAngles

				var_102_15.z = 0
				var_102_15.x = 0
				var_102_9.localEulerAngles = var_102_15
			end

			if arg_99_1.time_ >= var_102_10 + var_102_11 and arg_99_1.time_ < var_102_10 + var_102_11 + arg_102_0 then
				var_102_9.localPosition = Vector3.New(0, 100, 0)

				local var_102_16 = manager.ui.mainCamera.transform.position - var_102_9.position

				var_102_9.forward = Vector3.New(var_102_16.x, var_102_16.y, var_102_16.z)

				local var_102_17 = var_102_9.localEulerAngles

				var_102_17.z = 0
				var_102_17.x = 0
				var_102_9.localEulerAngles = var_102_17
			end

			local var_102_18 = 0.3
			local var_102_19 = 1

			if var_102_18 < arg_99_1.time_ and arg_99_1.time_ <= var_102_18 + arg_102_0 then
				local var_102_20 = "play"
				local var_102_21 = "effect"

				arg_99_1:AudioAction(var_102_20, var_102_21, "se_story_145", "se_story_145_monster_scream01", "")
			end

			local var_102_22 = 0
			local var_102_23 = 1.5

			if var_102_22 < arg_99_1.time_ and arg_99_1.time_ <= var_102_22 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, false)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_24 = arg_99_1:GetWordFromCfg(322062024)
				local var_102_25 = arg_99_1:FormatText(var_102_24.content)

				arg_99_1.text_.text = var_102_25

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_26 = 60
				local var_102_27 = utf8.len(var_102_25)
				local var_102_28 = var_102_26 <= 0 and var_102_23 or var_102_23 * (var_102_27 / var_102_26)

				if var_102_28 > 0 and var_102_23 < var_102_28 then
					arg_99_1.talkMaxDuration = var_102_28

					if var_102_28 + var_102_22 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_28 + var_102_22
					end
				end

				arg_99_1.text_.text = var_102_25
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)
				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_29 = math.max(var_102_23, arg_99_1.talkMaxDuration)

			if var_102_22 <= arg_99_1.time_ and arg_99_1.time_ < var_102_22 + var_102_29 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_22) / var_102_29

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_22 + var_102_29 and arg_99_1.time_ < var_102_22 + var_102_29 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "404001ui_story",
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
	Play322062025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 322062025
		arg_103_1.duration_ = 5

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play322062026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = 0
			local var_106_1 = 1.15

			if var_106_0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_0 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, false)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_2 = arg_103_1:GetWordFromCfg(322062025)
				local var_106_3 = arg_103_1:FormatText(var_106_2.content)

				arg_103_1.text_.text = var_106_3

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_4 = 46
				local var_106_5 = utf8.len(var_106_3)
				local var_106_6 = var_106_4 <= 0 and var_106_1 or var_106_1 * (var_106_5 / var_106_4)

				if var_106_6 > 0 and var_106_1 < var_106_6 then
					arg_103_1.talkMaxDuration = var_106_6

					if var_106_6 + var_106_0 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_6 + var_106_0
					end
				end

				arg_103_1.text_.text = var_106_3
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)
				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_7 = math.max(var_106_1, arg_103_1.talkMaxDuration)

			if var_106_0 <= arg_103_1.time_ and arg_103_1.time_ < var_106_0 + var_106_7 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_0) / var_106_7

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_0 + var_106_7 and arg_103_1.time_ < var_106_0 + var_106_7 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play322062026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 322062026
		arg_107_1.duration_ = 4.77

		local var_107_0 = {
			zh = 4.766,
			ja = 2.466
		}
		local var_107_1 = manager.audio:GetLocalizationFlag()

		if var_107_0[var_107_1] ~= nil then
			arg_107_1.duration_ = var_107_0[var_107_1]
		end

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play322062027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = arg_107_1.actors_["404001ui_story"].transform
			local var_110_1 = 0

			if var_110_1 < arg_107_1.time_ and arg_107_1.time_ <= var_110_1 + arg_110_0 then
				arg_107_1.var_.moveOldPos404001ui_story = var_110_0.localPosition
			end

			local var_110_2 = 0.001

			if var_110_1 <= arg_107_1.time_ and arg_107_1.time_ < var_110_1 + var_110_2 then
				local var_110_3 = (arg_107_1.time_ - var_110_1) / var_110_2
				local var_110_4 = Vector3.New(-0.8, -1.55, -5.5)

				var_110_0.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos404001ui_story, var_110_4, var_110_3)

				local var_110_5 = manager.ui.mainCamera.transform.position - var_110_0.position

				var_110_0.forward = Vector3.New(var_110_5.x, var_110_5.y, var_110_5.z)

				local var_110_6 = var_110_0.localEulerAngles

				var_110_6.z = 0
				var_110_6.x = 0
				var_110_0.localEulerAngles = var_110_6
			end

			if arg_107_1.time_ >= var_110_1 + var_110_2 and arg_107_1.time_ < var_110_1 + var_110_2 + arg_110_0 then
				var_110_0.localPosition = Vector3.New(-0.8, -1.55, -5.5)

				local var_110_7 = manager.ui.mainCamera.transform.position - var_110_0.position

				var_110_0.forward = Vector3.New(var_110_7.x, var_110_7.y, var_110_7.z)

				local var_110_8 = var_110_0.localEulerAngles

				var_110_8.z = 0
				var_110_8.x = 0
				var_110_0.localEulerAngles = var_110_8
			end

			local var_110_9 = arg_107_1.actors_["404001ui_story"]
			local var_110_10 = 0

			if var_110_10 < arg_107_1.time_ and arg_107_1.time_ <= var_110_10 + arg_110_0 and not isNil(var_110_9) and arg_107_1.var_.characterEffect404001ui_story == nil then
				arg_107_1.var_.characterEffect404001ui_story = var_110_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_11 = 0.200000002980232

			if var_110_10 <= arg_107_1.time_ and arg_107_1.time_ < var_110_10 + var_110_11 and not isNil(var_110_9) then
				local var_110_12 = (arg_107_1.time_ - var_110_10) / var_110_11

				if arg_107_1.var_.characterEffect404001ui_story and not isNil(var_110_9) then
					arg_107_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_107_1.time_ >= var_110_10 + var_110_11 and arg_107_1.time_ < var_110_10 + var_110_11 + arg_110_0 and not isNil(var_110_9) and arg_107_1.var_.characterEffect404001ui_story then
				arg_107_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_110_13 = 0

			if var_110_13 < arg_107_1.time_ and arg_107_1.time_ <= var_110_13 + arg_110_0 then
				arg_107_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action5_1")
			end

			local var_110_14 = 0

			if var_110_14 < arg_107_1.time_ and arg_107_1.time_ <= var_110_14 + arg_110_0 then
				arg_107_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_110_15 = 0
			local var_110_16 = 0.55

			if var_110_15 < arg_107_1.time_ and arg_107_1.time_ <= var_110_15 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				local var_110_17 = arg_107_1:FormatText(StoryNameCfg[668].name)

				arg_107_1.leftNameTxt_.text = var_110_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_18 = arg_107_1:GetWordFromCfg(322062026)
				local var_110_19 = arg_107_1:FormatText(var_110_18.content)

				arg_107_1.text_.text = var_110_19

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_20 = 22
				local var_110_21 = utf8.len(var_110_19)
				local var_110_22 = var_110_20 <= 0 and var_110_16 or var_110_16 * (var_110_21 / var_110_20)

				if var_110_22 > 0 and var_110_16 < var_110_22 then
					arg_107_1.talkMaxDuration = var_110_22

					if var_110_22 + var_110_15 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_22 + var_110_15
					end
				end

				arg_107_1.text_.text = var_110_19
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062026", "story_v_out_322062.awb") ~= 0 then
					local var_110_23 = manager.audio:GetVoiceLength("story_v_out_322062", "322062026", "story_v_out_322062.awb") / 1000

					if var_110_23 + var_110_15 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_23 + var_110_15
					end

					if var_110_18.prefab_name ~= "" and arg_107_1.actors_[var_110_18.prefab_name] ~= nil then
						local var_110_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_18.prefab_name].transform, "story_v_out_322062", "322062026", "story_v_out_322062.awb")

						arg_107_1:RecordAudio("322062026", var_110_24)
						arg_107_1:RecordAudio("322062026", var_110_24)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_322062", "322062026", "story_v_out_322062.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_322062", "322062026", "story_v_out_322062.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_25 = math.max(var_110_16, arg_107_1.talkMaxDuration)

			if var_110_15 <= arg_107_1.time_ and arg_107_1.time_ < var_110_15 + var_110_25 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_15) / var_110_25

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_15 + var_110_25 and arg_107_1.time_ < var_110_15 + var_110_25 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_107_1:InitPlayNodeList()
	end,
	Play322062027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 322062027
		arg_111_1.duration_ = 11.33

		local var_111_0 = {
			zh = 6.166,
			ja = 11.333
		}
		local var_111_1 = manager.audio:GetLocalizationFlag()

		if var_111_0[var_111_1] ~= nil then
			arg_111_1.duration_ = var_111_0[var_111_1]
		end

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play322062028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = arg_111_1.actors_["10104ui_story"].transform
			local var_114_1 = 0

			if var_114_1 < arg_111_1.time_ and arg_111_1.time_ <= var_114_1 + arg_114_0 then
				arg_111_1.var_.moveOldPos10104ui_story = var_114_0.localPosition
			end

			local var_114_2 = 0.001

			if var_114_1 <= arg_111_1.time_ and arg_111_1.time_ < var_114_1 + var_114_2 then
				local var_114_3 = (arg_111_1.time_ - var_114_1) / var_114_2
				local var_114_4 = Vector3.New(0.99, -1.12, -5.99)

				var_114_0.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos10104ui_story, var_114_4, var_114_3)

				local var_114_5 = manager.ui.mainCamera.transform.position - var_114_0.position

				var_114_0.forward = Vector3.New(var_114_5.x, var_114_5.y, var_114_5.z)

				local var_114_6 = var_114_0.localEulerAngles

				var_114_6.z = 0
				var_114_6.x = 0
				var_114_0.localEulerAngles = var_114_6
			end

			if arg_111_1.time_ >= var_114_1 + var_114_2 and arg_111_1.time_ < var_114_1 + var_114_2 + arg_114_0 then
				var_114_0.localPosition = Vector3.New(0.99, -1.12, -5.99)

				local var_114_7 = manager.ui.mainCamera.transform.position - var_114_0.position

				var_114_0.forward = Vector3.New(var_114_7.x, var_114_7.y, var_114_7.z)

				local var_114_8 = var_114_0.localEulerAngles

				var_114_8.z = 0
				var_114_8.x = 0
				var_114_0.localEulerAngles = var_114_8
			end

			local var_114_9 = arg_111_1.actors_["10104ui_story"]
			local var_114_10 = 0

			if var_114_10 < arg_111_1.time_ and arg_111_1.time_ <= var_114_10 + arg_114_0 and not isNil(var_114_9) and arg_111_1.var_.characterEffect10104ui_story == nil then
				arg_111_1.var_.characterEffect10104ui_story = var_114_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_11 = 0.200000002980232

			if var_114_10 <= arg_111_1.time_ and arg_111_1.time_ < var_114_10 + var_114_11 and not isNil(var_114_9) then
				local var_114_12 = (arg_111_1.time_ - var_114_10) / var_114_11

				if arg_111_1.var_.characterEffect10104ui_story and not isNil(var_114_9) then
					arg_111_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_111_1.time_ >= var_114_10 + var_114_11 and arg_111_1.time_ < var_114_10 + var_114_11 + arg_114_0 and not isNil(var_114_9) and arg_111_1.var_.characterEffect10104ui_story then
				arg_111_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_114_13 = arg_111_1.actors_["404001ui_story"]
			local var_114_14 = 0

			if var_114_14 < arg_111_1.time_ and arg_111_1.time_ <= var_114_14 + arg_114_0 and not isNil(var_114_13) and arg_111_1.var_.characterEffect404001ui_story == nil then
				arg_111_1.var_.characterEffect404001ui_story = var_114_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_15 = 0.200000002980232

			if var_114_14 <= arg_111_1.time_ and arg_111_1.time_ < var_114_14 + var_114_15 and not isNil(var_114_13) then
				local var_114_16 = (arg_111_1.time_ - var_114_14) / var_114_15

				if arg_111_1.var_.characterEffect404001ui_story and not isNil(var_114_13) then
					local var_114_17 = Mathf.Lerp(0, 0.5, var_114_16)

					arg_111_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_111_1.var_.characterEffect404001ui_story.fillRatio = var_114_17
				end
			end

			if arg_111_1.time_ >= var_114_14 + var_114_15 and arg_111_1.time_ < var_114_14 + var_114_15 + arg_114_0 and not isNil(var_114_13) and arg_111_1.var_.characterEffect404001ui_story then
				local var_114_18 = 0.5

				arg_111_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_111_1.var_.characterEffect404001ui_story.fillRatio = var_114_18
			end

			local var_114_19 = 0

			if var_114_19 < arg_111_1.time_ and arg_111_1.time_ <= var_114_19 + arg_114_0 then
				arg_111_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action1_1")
			end

			local var_114_20 = 0

			if var_114_20 < arg_111_1.time_ and arg_111_1.time_ <= var_114_20 + arg_114_0 then
				arg_111_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_114_21 = arg_111_1.actors_["10104ui_story"]
			local var_114_22 = 0

			if var_114_22 < arg_111_1.time_ and arg_111_1.time_ <= var_114_22 + arg_114_0 then
				if arg_111_1.var_.characterEffect10104ui_story == nil then
					arg_111_1.var_.characterEffect10104ui_story = var_114_21:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_114_23 = arg_111_1.var_.characterEffect10104ui_story

				var_114_23.imageEffect:turnOff()

				var_114_23.interferenceEffect.enabled = true
				var_114_23.interferenceEffect.noise = 0.001
				var_114_23.interferenceEffect.simTimeScale = 1
				var_114_23.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_114_24 = arg_111_1.actors_["10104ui_story"]
			local var_114_25 = 0
			local var_114_26 = 5

			if var_114_25 < arg_111_1.time_ and arg_111_1.time_ <= var_114_25 + arg_114_0 then
				if arg_111_1.var_.characterEffect10104ui_story == nil then
					arg_111_1.var_.characterEffect10104ui_story = var_114_24:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_111_1.var_.characterEffect10104ui_story.imageEffect:turnOn(false)
			end

			local var_114_27 = 0
			local var_114_28 = 0.9

			if var_114_27 < arg_111_1.time_ and arg_111_1.time_ <= var_114_27 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				local var_114_29 = arg_111_1:FormatText(StoryNameCfg[1030].name)

				arg_111_1.leftNameTxt_.text = var_114_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_30 = arg_111_1:GetWordFromCfg(322062027)
				local var_114_31 = arg_111_1:FormatText(var_114_30.content)

				arg_111_1.text_.text = var_114_31

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_32 = 36
				local var_114_33 = utf8.len(var_114_31)
				local var_114_34 = var_114_32 <= 0 and var_114_28 or var_114_28 * (var_114_33 / var_114_32)

				if var_114_34 > 0 and var_114_28 < var_114_34 then
					arg_111_1.talkMaxDuration = var_114_34

					if var_114_34 + var_114_27 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_34 + var_114_27
					end
				end

				arg_111_1.text_.text = var_114_31
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062027", "story_v_out_322062.awb") ~= 0 then
					local var_114_35 = manager.audio:GetVoiceLength("story_v_out_322062", "322062027", "story_v_out_322062.awb") / 1000

					if var_114_35 + var_114_27 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_35 + var_114_27
					end

					if var_114_30.prefab_name ~= "" and arg_111_1.actors_[var_114_30.prefab_name] ~= nil then
						local var_114_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_30.prefab_name].transform, "story_v_out_322062", "322062027", "story_v_out_322062.awb")

						arg_111_1:RecordAudio("322062027", var_114_36)
						arg_111_1:RecordAudio("322062027", var_114_36)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_322062", "322062027", "story_v_out_322062.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_322062", "322062027", "story_v_out_322062.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_37 = math.max(var_114_28, arg_111_1.talkMaxDuration)

			if var_114_27 <= arg_111_1.time_ and arg_111_1.time_ < var_114_27 + var_114_37 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_27) / var_114_37

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_27 + var_114_37 and arg_111_1.time_ < var_114_27 + var_114_37 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_111_1:InitPlayNodeList()
	end,
	Play322062028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 322062028
		arg_115_1.duration_ = 15.7

		local var_115_0 = {
			zh = 7.333,
			ja = 15.7
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
				arg_115_0:Play322062029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = arg_115_1.actors_["10104ui_story"].transform
			local var_118_1 = 0

			if var_118_1 < arg_115_1.time_ and arg_115_1.time_ <= var_118_1 + arg_118_0 then
				arg_115_1.var_.moveOldPos10104ui_story = var_118_0.localPosition
			end

			local var_118_2 = 0.001

			if var_118_1 <= arg_115_1.time_ and arg_115_1.time_ < var_118_1 + var_118_2 then
				local var_118_3 = (arg_115_1.time_ - var_118_1) / var_118_2
				local var_118_4 = Vector3.New(0.99, -1.12, -5.99)

				var_118_0.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos10104ui_story, var_118_4, var_118_3)

				local var_118_5 = manager.ui.mainCamera.transform.position - var_118_0.position

				var_118_0.forward = Vector3.New(var_118_5.x, var_118_5.y, var_118_5.z)

				local var_118_6 = var_118_0.localEulerAngles

				var_118_6.z = 0
				var_118_6.x = 0
				var_118_0.localEulerAngles = var_118_6
			end

			if arg_115_1.time_ >= var_118_1 + var_118_2 and arg_115_1.time_ < var_118_1 + var_118_2 + arg_118_0 then
				var_118_0.localPosition = Vector3.New(0.99, -1.12, -5.99)

				local var_118_7 = manager.ui.mainCamera.transform.position - var_118_0.position

				var_118_0.forward = Vector3.New(var_118_7.x, var_118_7.y, var_118_7.z)

				local var_118_8 = var_118_0.localEulerAngles

				var_118_8.z = 0
				var_118_8.x = 0
				var_118_0.localEulerAngles = var_118_8
			end

			local var_118_9 = 0

			if var_118_9 < arg_115_1.time_ and arg_115_1.time_ <= var_118_9 + arg_118_0 then
				arg_115_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action1_1")
			end

			local var_118_10 = 0

			if var_118_10 < arg_115_1.time_ and arg_115_1.time_ <= var_118_10 + arg_118_0 then
				arg_115_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_118_11 = arg_115_1.actors_["10104ui_story"]
			local var_118_12 = 0

			if var_118_12 < arg_115_1.time_ and arg_115_1.time_ <= var_118_12 + arg_118_0 then
				if arg_115_1.var_.characterEffect10104ui_story == nil then
					arg_115_1.var_.characterEffect10104ui_story = var_118_11:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_118_13 = arg_115_1.var_.characterEffect10104ui_story

				var_118_13.imageEffect:turnOff()

				var_118_13.interferenceEffect.enabled = true
				var_118_13.interferenceEffect.noise = 0.001
				var_118_13.interferenceEffect.simTimeScale = 1
				var_118_13.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_118_14 = arg_115_1.actors_["10104ui_story"]
			local var_118_15 = 0
			local var_118_16 = 5

			if var_118_15 < arg_115_1.time_ and arg_115_1.time_ <= var_118_15 + arg_118_0 then
				if arg_115_1.var_.characterEffect10104ui_story == nil then
					arg_115_1.var_.characterEffect10104ui_story = var_118_14:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_115_1.var_.characterEffect10104ui_story.imageEffect:turnOn(false)
			end

			local var_118_17 = 0
			local var_118_18 = 0.975

			if var_118_17 < arg_115_1.time_ and arg_115_1.time_ <= var_118_17 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				local var_118_19 = arg_115_1:FormatText(StoryNameCfg[1030].name)

				arg_115_1.leftNameTxt_.text = var_118_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_20 = arg_115_1:GetWordFromCfg(322062028)
				local var_118_21 = arg_115_1:FormatText(var_118_20.content)

				arg_115_1.text_.text = var_118_21

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_22 = 39
				local var_118_23 = utf8.len(var_118_21)
				local var_118_24 = var_118_22 <= 0 and var_118_18 or var_118_18 * (var_118_23 / var_118_22)

				if var_118_24 > 0 and var_118_18 < var_118_24 then
					arg_115_1.talkMaxDuration = var_118_24

					if var_118_24 + var_118_17 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_24 + var_118_17
					end
				end

				arg_115_1.text_.text = var_118_21
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062028", "story_v_out_322062.awb") ~= 0 then
					local var_118_25 = manager.audio:GetVoiceLength("story_v_out_322062", "322062028", "story_v_out_322062.awb") / 1000

					if var_118_25 + var_118_17 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_25 + var_118_17
					end

					if var_118_20.prefab_name ~= "" and arg_115_1.actors_[var_118_20.prefab_name] ~= nil then
						local var_118_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_20.prefab_name].transform, "story_v_out_322062", "322062028", "story_v_out_322062.awb")

						arg_115_1:RecordAudio("322062028", var_118_26)
						arg_115_1:RecordAudio("322062028", var_118_26)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_322062", "322062028", "story_v_out_322062.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_322062", "322062028", "story_v_out_322062.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_27 = math.max(var_118_18, arg_115_1.talkMaxDuration)

			if var_118_17 <= arg_115_1.time_ and arg_115_1.time_ < var_118_17 + var_118_27 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_17) / var_118_27

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_17 + var_118_27 and arg_115_1.time_ < var_118_17 + var_118_27 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
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
	Play322062029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 322062029
		arg_119_1.duration_ = 5

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play322062030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = arg_119_1.actors_["10104ui_story"].transform
			local var_122_1 = 0

			if var_122_1 < arg_119_1.time_ and arg_119_1.time_ <= var_122_1 + arg_122_0 then
				arg_119_1.var_.moveOldPos10104ui_story = var_122_0.localPosition
			end

			local var_122_2 = 0.001

			if var_122_1 <= arg_119_1.time_ and arg_119_1.time_ < var_122_1 + var_122_2 then
				local var_122_3 = (arg_119_1.time_ - var_122_1) / var_122_2
				local var_122_4 = Vector3.New(0, 100, 0)

				var_122_0.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos10104ui_story, var_122_4, var_122_3)

				local var_122_5 = manager.ui.mainCamera.transform.position - var_122_0.position

				var_122_0.forward = Vector3.New(var_122_5.x, var_122_5.y, var_122_5.z)

				local var_122_6 = var_122_0.localEulerAngles

				var_122_6.z = 0
				var_122_6.x = 0
				var_122_0.localEulerAngles = var_122_6
			end

			if arg_119_1.time_ >= var_122_1 + var_122_2 and arg_119_1.time_ < var_122_1 + var_122_2 + arg_122_0 then
				var_122_0.localPosition = Vector3.New(0, 100, 0)

				local var_122_7 = manager.ui.mainCamera.transform.position - var_122_0.position

				var_122_0.forward = Vector3.New(var_122_7.x, var_122_7.y, var_122_7.z)

				local var_122_8 = var_122_0.localEulerAngles

				var_122_8.z = 0
				var_122_8.x = 0
				var_122_0.localEulerAngles = var_122_8
			end

			local var_122_9 = arg_119_1.actors_["404001ui_story"].transform
			local var_122_10 = 0

			if var_122_10 < arg_119_1.time_ and arg_119_1.time_ <= var_122_10 + arg_122_0 then
				arg_119_1.var_.moveOldPos404001ui_story = var_122_9.localPosition
			end

			local var_122_11 = 0.001

			if var_122_10 <= arg_119_1.time_ and arg_119_1.time_ < var_122_10 + var_122_11 then
				local var_122_12 = (arg_119_1.time_ - var_122_10) / var_122_11
				local var_122_13 = Vector3.New(0, 100, 0)

				var_122_9.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos404001ui_story, var_122_13, var_122_12)

				local var_122_14 = manager.ui.mainCamera.transform.position - var_122_9.position

				var_122_9.forward = Vector3.New(var_122_14.x, var_122_14.y, var_122_14.z)

				local var_122_15 = var_122_9.localEulerAngles

				var_122_15.z = 0
				var_122_15.x = 0
				var_122_9.localEulerAngles = var_122_15
			end

			if arg_119_1.time_ >= var_122_10 + var_122_11 and arg_119_1.time_ < var_122_10 + var_122_11 + arg_122_0 then
				var_122_9.localPosition = Vector3.New(0, 100, 0)

				local var_122_16 = manager.ui.mainCamera.transform.position - var_122_9.position

				var_122_9.forward = Vector3.New(var_122_16.x, var_122_16.y, var_122_16.z)

				local var_122_17 = var_122_9.localEulerAngles

				var_122_17.z = 0
				var_122_17.x = 0
				var_122_9.localEulerAngles = var_122_17
			end

			local var_122_18 = 1.16666666666667
			local var_122_19 = 1

			if var_122_18 < arg_119_1.time_ and arg_119_1.time_ <= var_122_18 + arg_122_0 then
				local var_122_20 = "play"
				local var_122_21 = "effect"

				arg_119_1:AudioAction(var_122_20, var_122_21, "se_story_145", "se_story_145_plane01", "")
			end

			local var_122_22 = 0.166666666666667
			local var_122_23 = 1

			if var_122_22 < arg_119_1.time_ and arg_119_1.time_ <= var_122_22 + arg_122_0 then
				local var_122_24 = "play"
				local var_122_25 = "effect"

				arg_119_1:AudioAction(var_122_24, var_122_25, "se_story_140", "se_story_140_explosion05", "")
			end

			local var_122_26 = manager.ui.mainCamera.transform
			local var_122_27 = 0.166666666666667

			if var_122_27 < arg_119_1.time_ and arg_119_1.time_ <= var_122_27 + arg_122_0 then
				local var_122_28 = arg_119_1.var_.effect20209
				local var_122_29
				local var_122_30 = var_122_26

				if not var_122_28 then
					var_122_28 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), var_122_30)
					var_122_28.name = "20209"
					arg_119_1.var_.effect20209 = var_122_28
				else
					var_122_28.transform:SetParent(var_122_30)
				end

				var_122_28.transform.localPosition = Vector3.New(0, 0, 0)
				var_122_28.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_122_31 = manager.ui.mainCamera.transform
			local var_122_32 = 2.15

			if var_122_32 < arg_119_1.time_ and arg_119_1.time_ <= var_122_32 + arg_122_0 then
				local var_122_33 = arg_119_1.var_.effect20209

				if var_122_33 then
					Object.Destroy(var_122_33)

					arg_119_1.var_.effect20209 = nil
				end
			end

			local var_122_34 = manager.ui.mainCamera.transform
			local var_122_35 = 0.166666666666667

			if var_122_35 < arg_119_1.time_ and arg_119_1.time_ <= var_122_35 + arg_122_0 then
				arg_119_1.var_.shakeOldPos = var_122_34.localPosition
			end

			local var_122_36 = 0.233333333333333

			if var_122_35 <= arg_119_1.time_ and arg_119_1.time_ < var_122_35 + var_122_36 then
				local var_122_37 = (arg_119_1.time_ - var_122_35) / 0.066
				local var_122_38, var_122_39 = math.modf(var_122_37)

				var_122_34.localPosition = Vector3.New(var_122_39 * 0.13, var_122_39 * 0.13, var_122_39 * 0.13) + arg_119_1.var_.shakeOldPos
			end

			if arg_119_1.time_ >= var_122_35 + var_122_36 and arg_119_1.time_ < var_122_35 + var_122_36 + arg_122_0 then
				var_122_34.localPosition = arg_119_1.var_.shakeOldPos
			end

			local var_122_40 = 0
			local var_122_41 = 1.4

			if var_122_40 < arg_119_1.time_ and arg_119_1.time_ <= var_122_40 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, false)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_42 = arg_119_1:GetWordFromCfg(322062029)
				local var_122_43 = arg_119_1:FormatText(var_122_42.content)

				arg_119_1.text_.text = var_122_43

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_44 = 56
				local var_122_45 = utf8.len(var_122_43)
				local var_122_46 = var_122_44 <= 0 and var_122_41 or var_122_41 * (var_122_45 / var_122_44)

				if var_122_46 > 0 and var_122_41 < var_122_46 then
					arg_119_1.talkMaxDuration = var_122_46

					if var_122_46 + var_122_40 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_46 + var_122_40
					end
				end

				arg_119_1.text_.text = var_122_43
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)
				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_47 = math.max(var_122_41, arg_119_1.talkMaxDuration)

			if var_122_40 <= arg_119_1.time_ and arg_119_1.time_ < var_122_40 + var_122_47 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_40) / var_122_47

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_40 + var_122_47 and arg_119_1.time_ < var_122_40 + var_122_47 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_119_1:InitPlayNodeList()
	end,
	Play322062030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 322062030
		arg_123_1.duration_ = 5

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play322062031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = 0
			local var_126_1 = 1.475

			if var_126_0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_0 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, false)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_2 = arg_123_1:GetWordFromCfg(322062030)
				local var_126_3 = arg_123_1:FormatText(var_126_2.content)

				arg_123_1.text_.text = var_126_3

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_4 = 59
				local var_126_5 = utf8.len(var_126_3)
				local var_126_6 = var_126_4 <= 0 and var_126_1 or var_126_1 * (var_126_5 / var_126_4)

				if var_126_6 > 0 and var_126_1 < var_126_6 then
					arg_123_1.talkMaxDuration = var_126_6

					if var_126_6 + var_126_0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_6 + var_126_0
					end
				end

				arg_123_1.text_.text = var_126_3
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)
				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_7 = math.max(var_126_1, arg_123_1.talkMaxDuration)

			if var_126_0 <= arg_123_1.time_ and arg_123_1.time_ < var_126_0 + var_126_7 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_0) / var_126_7

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_0 + var_126_7 and arg_123_1.time_ < var_126_0 + var_126_7 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play322062031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 322062031
		arg_127_1.duration_ = 2

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play322062032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = arg_127_1.actors_["1211ui_story"].transform
			local var_130_1 = 0

			if var_130_1 < arg_127_1.time_ and arg_127_1.time_ <= var_130_1 + arg_130_0 then
				arg_127_1.var_.moveOldPos1211ui_story = var_130_0.localPosition
			end

			local var_130_2 = 0.001

			if var_130_1 <= arg_127_1.time_ and arg_127_1.time_ < var_130_1 + var_130_2 then
				local var_130_3 = (arg_127_1.time_ - var_130_1) / var_130_2
				local var_130_4 = Vector3.New(-0.7, -0.67, -6.07)

				var_130_0.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos1211ui_story, var_130_4, var_130_3)

				local var_130_5 = manager.ui.mainCamera.transform.position - var_130_0.position

				var_130_0.forward = Vector3.New(var_130_5.x, var_130_5.y, var_130_5.z)

				local var_130_6 = var_130_0.localEulerAngles

				var_130_6.z = 0
				var_130_6.x = 0
				var_130_0.localEulerAngles = var_130_6
			end

			if arg_127_1.time_ >= var_130_1 + var_130_2 and arg_127_1.time_ < var_130_1 + var_130_2 + arg_130_0 then
				var_130_0.localPosition = Vector3.New(-0.7, -0.67, -6.07)

				local var_130_7 = manager.ui.mainCamera.transform.position - var_130_0.position

				var_130_0.forward = Vector3.New(var_130_7.x, var_130_7.y, var_130_7.z)

				local var_130_8 = var_130_0.localEulerAngles

				var_130_8.z = 0
				var_130_8.x = 0
				var_130_0.localEulerAngles = var_130_8
			end

			local var_130_9 = arg_127_1.actors_["1211ui_story"]
			local var_130_10 = 0

			if var_130_10 < arg_127_1.time_ and arg_127_1.time_ <= var_130_10 + arg_130_0 and not isNil(var_130_9) and arg_127_1.var_.characterEffect1211ui_story == nil then
				arg_127_1.var_.characterEffect1211ui_story = var_130_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_11 = 0.200000002980232

			if var_130_10 <= arg_127_1.time_ and arg_127_1.time_ < var_130_10 + var_130_11 and not isNil(var_130_9) then
				local var_130_12 = (arg_127_1.time_ - var_130_10) / var_130_11

				if arg_127_1.var_.characterEffect1211ui_story and not isNil(var_130_9) then
					arg_127_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_127_1.time_ >= var_130_10 + var_130_11 and arg_127_1.time_ < var_130_10 + var_130_11 + arg_130_0 and not isNil(var_130_9) and arg_127_1.var_.characterEffect1211ui_story then
				arg_127_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_130_13 = 0

			if var_130_13 < arg_127_1.time_ and arg_127_1.time_ <= var_130_13 + arg_130_0 then
				arg_127_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action9_1")
			end

			local var_130_14 = 0

			if var_130_14 < arg_127_1.time_ and arg_127_1.time_ <= var_130_14 + arg_130_0 then
				arg_127_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_130_15 = 0
			local var_130_16 = 0.125

			if var_130_15 < arg_127_1.time_ and arg_127_1.time_ <= var_130_15 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				local var_130_17 = arg_127_1:FormatText(StoryNameCfg[37].name)

				arg_127_1.leftNameTxt_.text = var_130_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_18 = arg_127_1:GetWordFromCfg(322062031)
				local var_130_19 = arg_127_1:FormatText(var_130_18.content)

				arg_127_1.text_.text = var_130_19

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_20 = 5
				local var_130_21 = utf8.len(var_130_19)
				local var_130_22 = var_130_20 <= 0 and var_130_16 or var_130_16 * (var_130_21 / var_130_20)

				if var_130_22 > 0 and var_130_16 < var_130_22 then
					arg_127_1.talkMaxDuration = var_130_22

					if var_130_22 + var_130_15 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_22 + var_130_15
					end
				end

				arg_127_1.text_.text = var_130_19
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062031", "story_v_out_322062.awb") ~= 0 then
					local var_130_23 = manager.audio:GetVoiceLength("story_v_out_322062", "322062031", "story_v_out_322062.awb") / 1000

					if var_130_23 + var_130_15 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_23 + var_130_15
					end

					if var_130_18.prefab_name ~= "" and arg_127_1.actors_[var_130_18.prefab_name] ~= nil then
						local var_130_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_18.prefab_name].transform, "story_v_out_322062", "322062031", "story_v_out_322062.awb")

						arg_127_1:RecordAudio("322062031", var_130_24)
						arg_127_1:RecordAudio("322062031", var_130_24)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_322062", "322062031", "story_v_out_322062.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_322062", "322062031", "story_v_out_322062.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_25 = math.max(var_130_16, arg_127_1.talkMaxDuration)

			if var_130_15 <= arg_127_1.time_ and arg_127_1.time_ < var_130_15 + var_130_25 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_15) / var_130_25

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_15 + var_130_25 and arg_127_1.time_ < var_130_15 + var_130_25 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_127_1:InitPlayNodeList()
	end,
	Play322062032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 322062032
		arg_131_1.duration_ = 2.53

		local var_131_0 = {
			zh = 1.766,
			ja = 2.533
		}
		local var_131_1 = manager.audio:GetLocalizationFlag()

		if var_131_0[var_131_1] ~= nil then
			arg_131_1.duration_ = var_131_0[var_131_1]
		end

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play322062033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = arg_131_1.actors_["404001ui_story"].transform
			local var_134_1 = 0

			if var_134_1 < arg_131_1.time_ and arg_131_1.time_ <= var_134_1 + arg_134_0 then
				arg_131_1.var_.moveOldPos404001ui_story = var_134_0.localPosition
			end

			local var_134_2 = 0.001

			if var_134_1 <= arg_131_1.time_ and arg_131_1.time_ < var_134_1 + var_134_2 then
				local var_134_3 = (arg_131_1.time_ - var_134_1) / var_134_2
				local var_134_4 = Vector3.New(0.8, -1.55, -5.5)

				var_134_0.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos404001ui_story, var_134_4, var_134_3)

				local var_134_5 = manager.ui.mainCamera.transform.position - var_134_0.position

				var_134_0.forward = Vector3.New(var_134_5.x, var_134_5.y, var_134_5.z)

				local var_134_6 = var_134_0.localEulerAngles

				var_134_6.z = 0
				var_134_6.x = 0
				var_134_0.localEulerAngles = var_134_6
			end

			if arg_131_1.time_ >= var_134_1 + var_134_2 and arg_131_1.time_ < var_134_1 + var_134_2 + arg_134_0 then
				var_134_0.localPosition = Vector3.New(0.8, -1.55, -5.5)

				local var_134_7 = manager.ui.mainCamera.transform.position - var_134_0.position

				var_134_0.forward = Vector3.New(var_134_7.x, var_134_7.y, var_134_7.z)

				local var_134_8 = var_134_0.localEulerAngles

				var_134_8.z = 0
				var_134_8.x = 0
				var_134_0.localEulerAngles = var_134_8
			end

			local var_134_9 = arg_131_1.actors_["404001ui_story"]
			local var_134_10 = 0

			if var_134_10 < arg_131_1.time_ and arg_131_1.time_ <= var_134_10 + arg_134_0 and not isNil(var_134_9) and arg_131_1.var_.characterEffect404001ui_story == nil then
				arg_131_1.var_.characterEffect404001ui_story = var_134_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_11 = 0.200000002980232

			if var_134_10 <= arg_131_1.time_ and arg_131_1.time_ < var_134_10 + var_134_11 and not isNil(var_134_9) then
				local var_134_12 = (arg_131_1.time_ - var_134_10) / var_134_11

				if arg_131_1.var_.characterEffect404001ui_story and not isNil(var_134_9) then
					arg_131_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_131_1.time_ >= var_134_10 + var_134_11 and arg_131_1.time_ < var_134_10 + var_134_11 + arg_134_0 and not isNil(var_134_9) and arg_131_1.var_.characterEffect404001ui_story then
				arg_131_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_134_13 = arg_131_1.actors_["1211ui_story"]
			local var_134_14 = 0

			if var_134_14 < arg_131_1.time_ and arg_131_1.time_ <= var_134_14 + arg_134_0 and not isNil(var_134_13) and arg_131_1.var_.characterEffect1211ui_story == nil then
				arg_131_1.var_.characterEffect1211ui_story = var_134_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_15 = 0.200000002980232

			if var_134_14 <= arg_131_1.time_ and arg_131_1.time_ < var_134_14 + var_134_15 and not isNil(var_134_13) then
				local var_134_16 = (arg_131_1.time_ - var_134_14) / var_134_15

				if arg_131_1.var_.characterEffect1211ui_story and not isNil(var_134_13) then
					local var_134_17 = Mathf.Lerp(0, 0.5, var_134_16)

					arg_131_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_131_1.var_.characterEffect1211ui_story.fillRatio = var_134_17
				end
			end

			if arg_131_1.time_ >= var_134_14 + var_134_15 and arg_131_1.time_ < var_134_14 + var_134_15 + arg_134_0 and not isNil(var_134_13) and arg_131_1.var_.characterEffect1211ui_story then
				local var_134_18 = 0.5

				arg_131_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_131_1.var_.characterEffect1211ui_story.fillRatio = var_134_18
			end

			local var_134_19 = 0

			if var_134_19 < arg_131_1.time_ and arg_131_1.time_ <= var_134_19 + arg_134_0 then
				arg_131_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_134_20 = 0

			if var_134_20 < arg_131_1.time_ and arg_131_1.time_ <= var_134_20 + arg_134_0 then
				arg_131_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_134_21 = 0
			local var_134_22 = 0.2

			if var_134_21 < arg_131_1.time_ and arg_131_1.time_ <= var_134_21 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				local var_134_23 = arg_131_1:FormatText(StoryNameCfg[668].name)

				arg_131_1.leftNameTxt_.text = var_134_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_24 = arg_131_1:GetWordFromCfg(322062032)
				local var_134_25 = arg_131_1:FormatText(var_134_24.content)

				arg_131_1.text_.text = var_134_25

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_26 = 8
				local var_134_27 = utf8.len(var_134_25)
				local var_134_28 = var_134_26 <= 0 and var_134_22 or var_134_22 * (var_134_27 / var_134_26)

				if var_134_28 > 0 and var_134_22 < var_134_28 then
					arg_131_1.talkMaxDuration = var_134_28

					if var_134_28 + var_134_21 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_28 + var_134_21
					end
				end

				arg_131_1.text_.text = var_134_25
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062032", "story_v_out_322062.awb") ~= 0 then
					local var_134_29 = manager.audio:GetVoiceLength("story_v_out_322062", "322062032", "story_v_out_322062.awb") / 1000

					if var_134_29 + var_134_21 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_29 + var_134_21
					end

					if var_134_24.prefab_name ~= "" and arg_131_1.actors_[var_134_24.prefab_name] ~= nil then
						local var_134_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_24.prefab_name].transform, "story_v_out_322062", "322062032", "story_v_out_322062.awb")

						arg_131_1:RecordAudio("322062032", var_134_30)
						arg_131_1:RecordAudio("322062032", var_134_30)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_322062", "322062032", "story_v_out_322062.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_322062", "322062032", "story_v_out_322062.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_31 = math.max(var_134_22, arg_131_1.talkMaxDuration)

			if var_134_21 <= arg_131_1.time_ and arg_131_1.time_ < var_134_21 + var_134_31 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_21) / var_134_31

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_21 + var_134_31 and arg_131_1.time_ < var_134_21 + var_134_31 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_131_1:InitPlayNodeList()
	end,
	Play322062033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 322062033
		arg_135_1.duration_ = 5

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play322062034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = arg_135_1.actors_["1211ui_story"].transform
			local var_138_1 = 0

			if var_138_1 < arg_135_1.time_ and arg_135_1.time_ <= var_138_1 + arg_138_0 then
				arg_135_1.var_.moveOldPos1211ui_story = var_138_0.localPosition
			end

			local var_138_2 = 0.001

			if var_138_1 <= arg_135_1.time_ and arg_135_1.time_ < var_138_1 + var_138_2 then
				local var_138_3 = (arg_135_1.time_ - var_138_1) / var_138_2
				local var_138_4 = Vector3.New(0, 100, 0)

				var_138_0.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos1211ui_story, var_138_4, var_138_3)

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

			local var_138_9 = arg_135_1.actors_["404001ui_story"].transform
			local var_138_10 = 0

			if var_138_10 < arg_135_1.time_ and arg_135_1.time_ <= var_138_10 + arg_138_0 then
				arg_135_1.var_.moveOldPos404001ui_story = var_138_9.localPosition
			end

			local var_138_11 = 0.001

			if var_138_10 <= arg_135_1.time_ and arg_135_1.time_ < var_138_10 + var_138_11 then
				local var_138_12 = (arg_135_1.time_ - var_138_10) / var_138_11
				local var_138_13 = Vector3.New(0, 100, 0)

				var_138_9.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos404001ui_story, var_138_13, var_138_12)

				local var_138_14 = manager.ui.mainCamera.transform.position - var_138_9.position

				var_138_9.forward = Vector3.New(var_138_14.x, var_138_14.y, var_138_14.z)

				local var_138_15 = var_138_9.localEulerAngles

				var_138_15.z = 0
				var_138_15.x = 0
				var_138_9.localEulerAngles = var_138_15
			end

			if arg_135_1.time_ >= var_138_10 + var_138_11 and arg_135_1.time_ < var_138_10 + var_138_11 + arg_138_0 then
				var_138_9.localPosition = Vector3.New(0, 100, 0)

				local var_138_16 = manager.ui.mainCamera.transform.position - var_138_9.position

				var_138_9.forward = Vector3.New(var_138_16.x, var_138_16.y, var_138_16.z)

				local var_138_17 = var_138_9.localEulerAngles

				var_138_17.z = 0
				var_138_17.x = 0
				var_138_9.localEulerAngles = var_138_17
			end

			local var_138_18 = 0
			local var_138_19 = 1.5

			if var_138_18 < arg_135_1.time_ and arg_135_1.time_ <= var_138_18 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, false)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_20 = arg_135_1:GetWordFromCfg(322062033)
				local var_138_21 = arg_135_1:FormatText(var_138_20.content)

				arg_135_1.text_.text = var_138_21

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_22 = 60
				local var_138_23 = utf8.len(var_138_21)
				local var_138_24 = var_138_22 <= 0 and var_138_19 or var_138_19 * (var_138_23 / var_138_22)

				if var_138_24 > 0 and var_138_19 < var_138_24 then
					arg_135_1.talkMaxDuration = var_138_24

					if var_138_24 + var_138_18 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_24 + var_138_18
					end
				end

				arg_135_1.text_.text = var_138_21
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)
				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_25 = math.max(var_138_19, arg_135_1.talkMaxDuration)

			if var_138_18 <= arg_135_1.time_ and arg_135_1.time_ < var_138_18 + var_138_25 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_18) / var_138_25

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_18 + var_138_25 and arg_135_1.time_ < var_138_18 + var_138_25 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "404001ui_story",
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
	Play322062034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 322062034
		arg_139_1.duration_ = 5

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play322062035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = 0.1
			local var_142_1 = 1

			if var_142_0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_0 + arg_142_0 then
				local var_142_2 = "play"
				local var_142_3 = "effect"

				arg_139_1:AudioAction(var_142_2, var_142_3, "se_story_145", "se_story_145_star_movement_wobble02", "")
			end

			local var_142_4 = 0
			local var_142_5 = 1.25

			if var_142_4 < arg_139_1.time_ and arg_139_1.time_ <= var_142_4 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, false)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_6 = arg_139_1:GetWordFromCfg(322062034)
				local var_142_7 = arg_139_1:FormatText(var_142_6.content)

				arg_139_1.text_.text = var_142_7

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_8 = 50
				local var_142_9 = utf8.len(var_142_7)
				local var_142_10 = var_142_8 <= 0 and var_142_5 or var_142_5 * (var_142_9 / var_142_8)

				if var_142_10 > 0 and var_142_5 < var_142_10 then
					arg_139_1.talkMaxDuration = var_142_10

					if var_142_10 + var_142_4 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_10 + var_142_4
					end
				end

				arg_139_1.text_.text = var_142_7
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)
				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_11 = math.max(var_142_5, arg_139_1.talkMaxDuration)

			if var_142_4 <= arg_139_1.time_ and arg_139_1.time_ < var_142_4 + var_142_11 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_4) / var_142_11

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_4 + var_142_11 and arg_139_1.time_ < var_142_4 + var_142_11 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play322062035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 322062035
		arg_143_1.duration_ = 2.3

		local var_143_0 = {
			zh = 1.999999999999,
			ja = 2.3
		}
		local var_143_1 = manager.audio:GetLocalizationFlag()

		if var_143_0[var_143_1] ~= nil then
			arg_143_1.duration_ = var_143_0[var_143_1]
		end

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play322062036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = arg_143_1.actors_["404001ui_story"].transform
			local var_146_1 = 0

			if var_146_1 < arg_143_1.time_ and arg_143_1.time_ <= var_146_1 + arg_146_0 then
				arg_143_1.var_.moveOldPos404001ui_story = var_146_0.localPosition
			end

			local var_146_2 = 0.001

			if var_146_1 <= arg_143_1.time_ and arg_143_1.time_ < var_146_1 + var_146_2 then
				local var_146_3 = (arg_143_1.time_ - var_146_1) / var_146_2
				local var_146_4 = Vector3.New(-0.8, -1.55, -5.5)

				var_146_0.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos404001ui_story, var_146_4, var_146_3)

				local var_146_5 = manager.ui.mainCamera.transform.position - var_146_0.position

				var_146_0.forward = Vector3.New(var_146_5.x, var_146_5.y, var_146_5.z)

				local var_146_6 = var_146_0.localEulerAngles

				var_146_6.z = 0
				var_146_6.x = 0
				var_146_0.localEulerAngles = var_146_6
			end

			if arg_143_1.time_ >= var_146_1 + var_146_2 and arg_143_1.time_ < var_146_1 + var_146_2 + arg_146_0 then
				var_146_0.localPosition = Vector3.New(-0.8, -1.55, -5.5)

				local var_146_7 = manager.ui.mainCamera.transform.position - var_146_0.position

				var_146_0.forward = Vector3.New(var_146_7.x, var_146_7.y, var_146_7.z)

				local var_146_8 = var_146_0.localEulerAngles

				var_146_8.z = 0
				var_146_8.x = 0
				var_146_0.localEulerAngles = var_146_8
			end

			local var_146_9 = arg_143_1.actors_["404001ui_story"]
			local var_146_10 = 0

			if var_146_10 < arg_143_1.time_ and arg_143_1.time_ <= var_146_10 + arg_146_0 and not isNil(var_146_9) and arg_143_1.var_.characterEffect404001ui_story == nil then
				arg_143_1.var_.characterEffect404001ui_story = var_146_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_11 = 0.200000002980232

			if var_146_10 <= arg_143_1.time_ and arg_143_1.time_ < var_146_10 + var_146_11 and not isNil(var_146_9) then
				local var_146_12 = (arg_143_1.time_ - var_146_10) / var_146_11

				if arg_143_1.var_.characterEffect404001ui_story and not isNil(var_146_9) then
					arg_143_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_143_1.time_ >= var_146_10 + var_146_11 and arg_143_1.time_ < var_146_10 + var_146_11 + arg_146_0 and not isNil(var_146_9) and arg_143_1.var_.characterEffect404001ui_story then
				arg_143_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_146_13 = 0

			if var_146_13 < arg_143_1.time_ and arg_143_1.time_ <= var_146_13 + arg_146_0 then
				arg_143_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_146_14 = 0

			if var_146_14 < arg_143_1.time_ and arg_143_1.time_ <= var_146_14 + arg_146_0 then
				arg_143_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva", "EmotionTimelineAnimator")
			end

			local var_146_15 = 0
			local var_146_16 = 0.175

			if var_146_15 < arg_143_1.time_ and arg_143_1.time_ <= var_146_15 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				local var_146_17 = arg_143_1:FormatText(StoryNameCfg[668].name)

				arg_143_1.leftNameTxt_.text = var_146_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_18 = arg_143_1:GetWordFromCfg(322062035)
				local var_146_19 = arg_143_1:FormatText(var_146_18.content)

				arg_143_1.text_.text = var_146_19

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_20 = 7
				local var_146_21 = utf8.len(var_146_19)
				local var_146_22 = var_146_20 <= 0 and var_146_16 or var_146_16 * (var_146_21 / var_146_20)

				if var_146_22 > 0 and var_146_16 < var_146_22 then
					arg_143_1.talkMaxDuration = var_146_22

					if var_146_22 + var_146_15 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_22 + var_146_15
					end
				end

				arg_143_1.text_.text = var_146_19
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062035", "story_v_out_322062.awb") ~= 0 then
					local var_146_23 = manager.audio:GetVoiceLength("story_v_out_322062", "322062035", "story_v_out_322062.awb") / 1000

					if var_146_23 + var_146_15 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_23 + var_146_15
					end

					if var_146_18.prefab_name ~= "" and arg_143_1.actors_[var_146_18.prefab_name] ~= nil then
						local var_146_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_18.prefab_name].transform, "story_v_out_322062", "322062035", "story_v_out_322062.awb")

						arg_143_1:RecordAudio("322062035", var_146_24)
						arg_143_1:RecordAudio("322062035", var_146_24)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_322062", "322062035", "story_v_out_322062.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_322062", "322062035", "story_v_out_322062.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_25 = math.max(var_146_16, arg_143_1.talkMaxDuration)

			if var_146_15 <= arg_143_1.time_ and arg_143_1.time_ < var_146_15 + var_146_25 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_15) / var_146_25

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_15 + var_146_25 and arg_143_1.time_ < var_146_15 + var_146_25 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
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
	Play322062036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 322062036
		arg_147_1.duration_ = 3.6

		local var_147_0 = {
			zh = 2.266,
			ja = 3.6
		}
		local var_147_1 = manager.audio:GetLocalizationFlag()

		if var_147_0[var_147_1] ~= nil then
			arg_147_1.duration_ = var_147_0[var_147_1]
		end

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play322062037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = arg_147_1.actors_["1284ui_story"].transform
			local var_150_1 = 0

			if var_150_1 < arg_147_1.time_ and arg_147_1.time_ <= var_150_1 + arg_150_0 then
				arg_147_1.var_.moveOldPos1284ui_story = var_150_0.localPosition

				local var_150_2 = "1284ui_story"

				arg_147_1:ShowWeapon(arg_147_1.var_[var_150_2 .. "Animator"].transform, false)
			end

			local var_150_3 = 0.001

			if var_150_1 <= arg_147_1.time_ and arg_147_1.time_ < var_150_1 + var_150_3 then
				local var_150_4 = (arg_147_1.time_ - var_150_1) / var_150_3
				local var_150_5 = Vector3.New(0.7, -0.985, -6.22)

				var_150_0.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos1284ui_story, var_150_5, var_150_4)

				local var_150_6 = manager.ui.mainCamera.transform.position - var_150_0.position

				var_150_0.forward = Vector3.New(var_150_6.x, var_150_6.y, var_150_6.z)

				local var_150_7 = var_150_0.localEulerAngles

				var_150_7.z = 0
				var_150_7.x = 0
				var_150_0.localEulerAngles = var_150_7
			end

			if arg_147_1.time_ >= var_150_1 + var_150_3 and arg_147_1.time_ < var_150_1 + var_150_3 + arg_150_0 then
				var_150_0.localPosition = Vector3.New(0.7, -0.985, -6.22)

				local var_150_8 = manager.ui.mainCamera.transform.position - var_150_0.position

				var_150_0.forward = Vector3.New(var_150_8.x, var_150_8.y, var_150_8.z)

				local var_150_9 = var_150_0.localEulerAngles

				var_150_9.z = 0
				var_150_9.x = 0
				var_150_0.localEulerAngles = var_150_9
			end

			local var_150_10 = arg_147_1.actors_["1284ui_story"]
			local var_150_11 = 0

			if var_150_11 < arg_147_1.time_ and arg_147_1.time_ <= var_150_11 + arg_150_0 and not isNil(var_150_10) and arg_147_1.var_.characterEffect1284ui_story == nil then
				arg_147_1.var_.characterEffect1284ui_story = var_150_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_12 = 0.200000002980232

			if var_150_11 <= arg_147_1.time_ and arg_147_1.time_ < var_150_11 + var_150_12 and not isNil(var_150_10) then
				local var_150_13 = (arg_147_1.time_ - var_150_11) / var_150_12

				if arg_147_1.var_.characterEffect1284ui_story and not isNil(var_150_10) then
					arg_147_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_147_1.time_ >= var_150_11 + var_150_12 and arg_147_1.time_ < var_150_11 + var_150_12 + arg_150_0 and not isNil(var_150_10) and arg_147_1.var_.characterEffect1284ui_story then
				arg_147_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_150_14 = arg_147_1.actors_["404001ui_story"]
			local var_150_15 = 0

			if var_150_15 < arg_147_1.time_ and arg_147_1.time_ <= var_150_15 + arg_150_0 and not isNil(var_150_14) and arg_147_1.var_.characterEffect404001ui_story == nil then
				arg_147_1.var_.characterEffect404001ui_story = var_150_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_16 = 0.200000002980232

			if var_150_15 <= arg_147_1.time_ and arg_147_1.time_ < var_150_15 + var_150_16 and not isNil(var_150_14) then
				local var_150_17 = (arg_147_1.time_ - var_150_15) / var_150_16

				if arg_147_1.var_.characterEffect404001ui_story and not isNil(var_150_14) then
					local var_150_18 = Mathf.Lerp(0, 0.5, var_150_17)

					arg_147_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_147_1.var_.characterEffect404001ui_story.fillRatio = var_150_18
				end
			end

			if arg_147_1.time_ >= var_150_15 + var_150_16 and arg_147_1.time_ < var_150_15 + var_150_16 + arg_150_0 and not isNil(var_150_14) and arg_147_1.var_.characterEffect404001ui_story then
				local var_150_19 = 0.5

				arg_147_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_147_1.var_.characterEffect404001ui_story.fillRatio = var_150_19
			end

			local var_150_20 = 0

			if var_150_20 < arg_147_1.time_ and arg_147_1.time_ <= var_150_20 + arg_150_0 then
				arg_147_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action1_1")
			end

			local var_150_21 = 0

			if var_150_21 < arg_147_1.time_ and arg_147_1.time_ <= var_150_21 + arg_150_0 then
				arg_147_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_150_22 = 0
			local var_150_23 = 0.25

			if var_150_22 < arg_147_1.time_ and arg_147_1.time_ <= var_150_22 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				local var_150_24 = arg_147_1:FormatText(StoryNameCfg[6].name)

				arg_147_1.leftNameTxt_.text = var_150_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_25 = arg_147_1:GetWordFromCfg(322062036)
				local var_150_26 = arg_147_1:FormatText(var_150_25.content)

				arg_147_1.text_.text = var_150_26

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_27 = 10
				local var_150_28 = utf8.len(var_150_26)
				local var_150_29 = var_150_27 <= 0 and var_150_23 or var_150_23 * (var_150_28 / var_150_27)

				if var_150_29 > 0 and var_150_23 < var_150_29 then
					arg_147_1.talkMaxDuration = var_150_29

					if var_150_29 + var_150_22 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_29 + var_150_22
					end
				end

				arg_147_1.text_.text = var_150_26
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062036", "story_v_out_322062.awb") ~= 0 then
					local var_150_30 = manager.audio:GetVoiceLength("story_v_out_322062", "322062036", "story_v_out_322062.awb") / 1000

					if var_150_30 + var_150_22 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_30 + var_150_22
					end

					if var_150_25.prefab_name ~= "" and arg_147_1.actors_[var_150_25.prefab_name] ~= nil then
						local var_150_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_25.prefab_name].transform, "story_v_out_322062", "322062036", "story_v_out_322062.awb")

						arg_147_1:RecordAudio("322062036", var_150_31)
						arg_147_1:RecordAudio("322062036", var_150_31)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_322062", "322062036", "story_v_out_322062.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_322062", "322062036", "story_v_out_322062.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_32 = math.max(var_150_23, arg_147_1.talkMaxDuration)

			if var_150_22 <= arg_147_1.time_ and arg_147_1.time_ < var_150_22 + var_150_32 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_22) / var_150_32

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_22 + var_150_32 and arg_147_1.time_ < var_150_22 + var_150_32 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_147_1:InitPlayNodeList()
	end,
	Play322062037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 322062037
		arg_151_1.duration_ = 5

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play322062038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = arg_151_1.actors_["404001ui_story"].transform
			local var_154_1 = 0

			if var_154_1 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 then
				arg_151_1.var_.moveOldPos404001ui_story = var_154_0.localPosition
			end

			local var_154_2 = 0.001

			if var_154_1 <= arg_151_1.time_ and arg_151_1.time_ < var_154_1 + var_154_2 then
				local var_154_3 = (arg_151_1.time_ - var_154_1) / var_154_2
				local var_154_4 = Vector3.New(0, 100, 0)

				var_154_0.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos404001ui_story, var_154_4, var_154_3)

				local var_154_5 = manager.ui.mainCamera.transform.position - var_154_0.position

				var_154_0.forward = Vector3.New(var_154_5.x, var_154_5.y, var_154_5.z)

				local var_154_6 = var_154_0.localEulerAngles

				var_154_6.z = 0
				var_154_6.x = 0
				var_154_0.localEulerAngles = var_154_6
			end

			if arg_151_1.time_ >= var_154_1 + var_154_2 and arg_151_1.time_ < var_154_1 + var_154_2 + arg_154_0 then
				var_154_0.localPosition = Vector3.New(0, 100, 0)

				local var_154_7 = manager.ui.mainCamera.transform.position - var_154_0.position

				var_154_0.forward = Vector3.New(var_154_7.x, var_154_7.y, var_154_7.z)

				local var_154_8 = var_154_0.localEulerAngles

				var_154_8.z = 0
				var_154_8.x = 0
				var_154_0.localEulerAngles = var_154_8
			end

			local var_154_9 = arg_151_1.actors_["1284ui_story"].transform
			local var_154_10 = 0

			if var_154_10 < arg_151_1.time_ and arg_151_1.time_ <= var_154_10 + arg_154_0 then
				arg_151_1.var_.moveOldPos1284ui_story = var_154_9.localPosition
			end

			local var_154_11 = 0.001

			if var_154_10 <= arg_151_1.time_ and arg_151_1.time_ < var_154_10 + var_154_11 then
				local var_154_12 = (arg_151_1.time_ - var_154_10) / var_154_11
				local var_154_13 = Vector3.New(0, 100, 0)

				var_154_9.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos1284ui_story, var_154_13, var_154_12)

				local var_154_14 = manager.ui.mainCamera.transform.position - var_154_9.position

				var_154_9.forward = Vector3.New(var_154_14.x, var_154_14.y, var_154_14.z)

				local var_154_15 = var_154_9.localEulerAngles

				var_154_15.z = 0
				var_154_15.x = 0
				var_154_9.localEulerAngles = var_154_15
			end

			if arg_151_1.time_ >= var_154_10 + var_154_11 and arg_151_1.time_ < var_154_10 + var_154_11 + arg_154_0 then
				var_154_9.localPosition = Vector3.New(0, 100, 0)

				local var_154_16 = manager.ui.mainCamera.transform.position - var_154_9.position

				var_154_9.forward = Vector3.New(var_154_16.x, var_154_16.y, var_154_16.z)

				local var_154_17 = var_154_9.localEulerAngles

				var_154_17.z = 0
				var_154_17.x = 0
				var_154_9.localEulerAngles = var_154_17
			end

			local var_154_18 = arg_151_1.actors_["1284ui_story"]
			local var_154_19 = 0

			if var_154_19 < arg_151_1.time_ and arg_151_1.time_ <= var_154_19 + arg_154_0 and not isNil(var_154_18) and arg_151_1.var_.characterEffect1284ui_story == nil then
				arg_151_1.var_.characterEffect1284ui_story = var_154_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_20 = 0.200000002980232

			if var_154_19 <= arg_151_1.time_ and arg_151_1.time_ < var_154_19 + var_154_20 and not isNil(var_154_18) then
				local var_154_21 = (arg_151_1.time_ - var_154_19) / var_154_20

				if arg_151_1.var_.characterEffect1284ui_story and not isNil(var_154_18) then
					local var_154_22 = Mathf.Lerp(0, 0.5, var_154_21)

					arg_151_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_151_1.var_.characterEffect1284ui_story.fillRatio = var_154_22
				end
			end

			if arg_151_1.time_ >= var_154_19 + var_154_20 and arg_151_1.time_ < var_154_19 + var_154_20 + arg_154_0 and not isNil(var_154_18) and arg_151_1.var_.characterEffect1284ui_story then
				local var_154_23 = 0.5

				arg_151_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_151_1.var_.characterEffect1284ui_story.fillRatio = var_154_23
			end

			local var_154_24 = 0.034000001847744
			local var_154_25 = 1

			if var_154_24 < arg_151_1.time_ and arg_151_1.time_ <= var_154_24 + arg_154_0 then
				local var_154_26 = "play"
				local var_154_27 = "effect"

				arg_151_1:AudioAction(var_154_26, var_154_27, "se_story_145", "se_story_145_star_movement_wobble01", "")
			end

			local var_154_28 = 0
			local var_154_29 = 0.975

			if var_154_28 < arg_151_1.time_ and arg_151_1.time_ <= var_154_28 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, false)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_30 = arg_151_1:GetWordFromCfg(322062037)
				local var_154_31 = arg_151_1:FormatText(var_154_30.content)

				arg_151_1.text_.text = var_154_31

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_32 = 39
				local var_154_33 = utf8.len(var_154_31)
				local var_154_34 = var_154_32 <= 0 and var_154_29 or var_154_29 * (var_154_33 / var_154_32)

				if var_154_34 > 0 and var_154_29 < var_154_34 then
					arg_151_1.talkMaxDuration = var_154_34

					if var_154_34 + var_154_28 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_34 + var_154_28
					end
				end

				arg_151_1.text_.text = var_154_31
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)
				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_35 = math.max(var_154_29, arg_151_1.talkMaxDuration)

			if var_154_28 <= arg_151_1.time_ and arg_151_1.time_ < var_154_28 + var_154_35 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_28) / var_154_35

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_28 + var_154_35 and arg_151_1.time_ < var_154_28 + var_154_35 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1284ui_story",
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
	Play322062038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 322062038
		arg_155_1.duration_ = 5

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play322062039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = 0
			local var_158_1 = 1

			if var_158_0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_0 + arg_158_0 then
				local var_158_2 = "play"
				local var_158_3 = "effect"

				arg_155_1:AudioAction(var_158_2, var_158_3, "se_story_145", "se_story_145_laser", "")
			end

			local var_158_4 = 0
			local var_158_5 = 1.625

			if var_158_4 < arg_155_1.time_ and arg_155_1.time_ <= var_158_4 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, false)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_6 = arg_155_1:GetWordFromCfg(322062038)
				local var_158_7 = arg_155_1:FormatText(var_158_6.content)

				arg_155_1.text_.text = var_158_7

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_8 = 65
				local var_158_9 = utf8.len(var_158_7)
				local var_158_10 = var_158_8 <= 0 and var_158_5 or var_158_5 * (var_158_9 / var_158_8)

				if var_158_10 > 0 and var_158_5 < var_158_10 then
					arg_155_1.talkMaxDuration = var_158_10

					if var_158_10 + var_158_4 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_10 + var_158_4
					end
				end

				arg_155_1.text_.text = var_158_7
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)
				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_11 = math.max(var_158_5, arg_155_1.talkMaxDuration)

			if var_158_4 <= arg_155_1.time_ and arg_155_1.time_ < var_158_4 + var_158_11 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_4) / var_158_11

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_4 + var_158_11 and arg_155_1.time_ < var_158_4 + var_158_11 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play322062039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 322062039
		arg_159_1.duration_ = 5

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play322062040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = 0.1
			local var_162_1 = 1

			if var_162_0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_0 + arg_162_0 then
				local var_162_2 = "play"
				local var_162_3 = "effect"

				arg_159_1:AudioAction(var_162_2, var_162_3, "se_story_1211", "se_story_1211_energy03", "")
			end

			local var_162_4 = 0
			local var_162_5 = 1.475

			if var_162_4 < arg_159_1.time_ and arg_159_1.time_ <= var_162_4 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, false)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_6 = arg_159_1:GetWordFromCfg(322062039)
				local var_162_7 = arg_159_1:FormatText(var_162_6.content)

				arg_159_1.text_.text = var_162_7

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_8 = 59
				local var_162_9 = utf8.len(var_162_7)
				local var_162_10 = var_162_8 <= 0 and var_162_5 or var_162_5 * (var_162_9 / var_162_8)

				if var_162_10 > 0 and var_162_5 < var_162_10 then
					arg_159_1.talkMaxDuration = var_162_10

					if var_162_10 + var_162_4 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_10 + var_162_4
					end
				end

				arg_159_1.text_.text = var_162_7
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)
				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_11 = math.max(var_162_5, arg_159_1.talkMaxDuration)

			if var_162_4 <= arg_159_1.time_ and arg_159_1.time_ < var_162_4 + var_162_11 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_4) / var_162_11

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_4 + var_162_11 and arg_159_1.time_ < var_162_4 + var_162_11 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play322062040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 322062040
		arg_163_1.duration_ = 5

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play322062041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = 0.3
			local var_166_1 = 1

			if var_166_0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_0 + arg_166_0 then
				local var_166_2 = "play"
				local var_166_3 = "effect"

				arg_163_1:AudioAction(var_166_2, var_166_3, "se_story_129", "se_story_129_alarm", "")
			end

			local var_166_4 = manager.ui.mainCamera.transform
			local var_166_5 = 0.3

			if var_166_5 < arg_163_1.time_ and arg_163_1.time_ <= var_166_5 + arg_166_0 then
				local var_166_6 = arg_163_1.var_.effect2040
				local var_166_7
				local var_166_8 = var_166_4

				if not var_166_6 then
					var_166_6 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_redlight_keep"), var_166_8)
					var_166_6.name = "2040"
					arg_163_1.var_.effect2040 = var_166_6
				else
					var_166_6.transform:SetParent(var_166_8)
				end

				var_166_6.transform.localPosition = Vector3.New(0, 0, -2)
				var_166_6.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_166_9 = 1.7777777777777777
				local var_166_10 = Screen.width / Screen.height
				local var_166_11 = var_166_10 / var_166_9
				local var_166_12 = Mathf.Max(var_166_9 / var_166_10, 1)

				var_166_6.transform.localScale = Vector3.New(var_166_6.transform.localScale.x * var_166_11, var_166_6.transform.localScale.y * var_166_12, var_166_6.transform.localScale.z)
			end

			local var_166_13 = 0
			local var_166_14 = 1.525

			if var_166_13 < arg_163_1.time_ and arg_163_1.time_ <= var_166_13 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, false)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_15 = arg_163_1:GetWordFromCfg(322062040)
				local var_166_16 = arg_163_1:FormatText(var_166_15.content)

				arg_163_1.text_.text = var_166_16

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_17 = 61
				local var_166_18 = utf8.len(var_166_16)
				local var_166_19 = var_166_17 <= 0 and var_166_14 or var_166_14 * (var_166_18 / var_166_17)

				if var_166_19 > 0 and var_166_14 < var_166_19 then
					arg_163_1.talkMaxDuration = var_166_19

					if var_166_19 + var_166_13 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_19 + var_166_13
					end
				end

				arg_163_1.text_.text = var_166_16
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)
				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_20 = math.max(var_166_14, arg_163_1.talkMaxDuration)

			if var_166_13 <= arg_163_1.time_ and arg_163_1.time_ < var_166_13 + var_166_20 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_13) / var_166_20

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_13 + var_166_20 and arg_163_1.time_ < var_166_13 + var_166_20 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play322062041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 322062041
		arg_167_1.duration_ = 4.2

		local var_167_0 = {
			zh = 3.5,
			ja = 4.2
		}
		local var_167_1 = manager.audio:GetLocalizationFlag()

		if var_167_0[var_167_1] ~= nil then
			arg_167_1.duration_ = var_167_0[var_167_1]
		end

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play322062042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = arg_167_1.actors_["1211ui_story"].transform
			local var_170_1 = 0

			if var_170_1 < arg_167_1.time_ and arg_167_1.time_ <= var_170_1 + arg_170_0 then
				arg_167_1.var_.moveOldPos1211ui_story = var_170_0.localPosition
			end

			local var_170_2 = 0.001

			if var_170_1 <= arg_167_1.time_ and arg_167_1.time_ < var_170_1 + var_170_2 then
				local var_170_3 = (arg_167_1.time_ - var_170_1) / var_170_2
				local var_170_4 = Vector3.New(-0.7, -0.67, -6.07)

				var_170_0.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos1211ui_story, var_170_4, var_170_3)

				local var_170_5 = manager.ui.mainCamera.transform.position - var_170_0.position

				var_170_0.forward = Vector3.New(var_170_5.x, var_170_5.y, var_170_5.z)

				local var_170_6 = var_170_0.localEulerAngles

				var_170_6.z = 0
				var_170_6.x = 0
				var_170_0.localEulerAngles = var_170_6
			end

			if arg_167_1.time_ >= var_170_1 + var_170_2 and arg_167_1.time_ < var_170_1 + var_170_2 + arg_170_0 then
				var_170_0.localPosition = Vector3.New(-0.7, -0.67, -6.07)

				local var_170_7 = manager.ui.mainCamera.transform.position - var_170_0.position

				var_170_0.forward = Vector3.New(var_170_7.x, var_170_7.y, var_170_7.z)

				local var_170_8 = var_170_0.localEulerAngles

				var_170_8.z = 0
				var_170_8.x = 0
				var_170_0.localEulerAngles = var_170_8
			end

			local var_170_9 = arg_167_1.actors_["1211ui_story"]
			local var_170_10 = 0

			if var_170_10 < arg_167_1.time_ and arg_167_1.time_ <= var_170_10 + arg_170_0 and not isNil(var_170_9) and arg_167_1.var_.characterEffect1211ui_story == nil then
				arg_167_1.var_.characterEffect1211ui_story = var_170_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_11 = 0.200000002980232

			if var_170_10 <= arg_167_1.time_ and arg_167_1.time_ < var_170_10 + var_170_11 and not isNil(var_170_9) then
				local var_170_12 = (arg_167_1.time_ - var_170_10) / var_170_11

				if arg_167_1.var_.characterEffect1211ui_story and not isNil(var_170_9) then
					arg_167_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_167_1.time_ >= var_170_10 + var_170_11 and arg_167_1.time_ < var_170_10 + var_170_11 + arg_170_0 and not isNil(var_170_9) and arg_167_1.var_.characterEffect1211ui_story then
				arg_167_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_170_13 = 0

			if var_170_13 < arg_167_1.time_ and arg_167_1.time_ <= var_170_13 + arg_170_0 then
				arg_167_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action5_1")
			end

			local var_170_14 = 0

			if var_170_14 < arg_167_1.time_ and arg_167_1.time_ <= var_170_14 + arg_170_0 then
				arg_167_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_170_15 = manager.ui.mainCamera.transform
			local var_170_16 = 0

			if var_170_16 < arg_167_1.time_ and arg_167_1.time_ <= var_170_16 + arg_170_0 then
				local var_170_17 = arg_167_1.var_.effect2040

				if var_170_17 then
					Object.Destroy(var_170_17)

					arg_167_1.var_.effect2040 = nil
				end
			end

			local var_170_18 = 0
			local var_170_19 = 0.35

			if var_170_18 < arg_167_1.time_ and arg_167_1.time_ <= var_170_18 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				local var_170_20 = arg_167_1:FormatText(StoryNameCfg[37].name)

				arg_167_1.leftNameTxt_.text = var_170_20

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_21 = arg_167_1:GetWordFromCfg(322062041)
				local var_170_22 = arg_167_1:FormatText(var_170_21.content)

				arg_167_1.text_.text = var_170_22

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_23 = 14
				local var_170_24 = utf8.len(var_170_22)
				local var_170_25 = var_170_23 <= 0 and var_170_19 or var_170_19 * (var_170_24 / var_170_23)

				if var_170_25 > 0 and var_170_19 < var_170_25 then
					arg_167_1.talkMaxDuration = var_170_25

					if var_170_25 + var_170_18 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_25 + var_170_18
					end
				end

				arg_167_1.text_.text = var_170_22
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062041", "story_v_out_322062.awb") ~= 0 then
					local var_170_26 = manager.audio:GetVoiceLength("story_v_out_322062", "322062041", "story_v_out_322062.awb") / 1000

					if var_170_26 + var_170_18 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_26 + var_170_18
					end

					if var_170_21.prefab_name ~= "" and arg_167_1.actors_[var_170_21.prefab_name] ~= nil then
						local var_170_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_21.prefab_name].transform, "story_v_out_322062", "322062041", "story_v_out_322062.awb")

						arg_167_1:RecordAudio("322062041", var_170_27)
						arg_167_1:RecordAudio("322062041", var_170_27)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_322062", "322062041", "story_v_out_322062.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_322062", "322062041", "story_v_out_322062.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_28 = math.max(var_170_19, arg_167_1.talkMaxDuration)

			if var_170_18 <= arg_167_1.time_ and arg_167_1.time_ < var_170_18 + var_170_28 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_18) / var_170_28

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_18 + var_170_28 and arg_167_1.time_ < var_170_18 + var_170_28 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_167_1:InitPlayNodeList()
	end,
	Play322062042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 322062042
		arg_171_1.duration_ = 10.47

		local var_171_0 = {
			zh = 4.999999999999,
			ja = 10.466
		}
		local var_171_1 = manager.audio:GetLocalizationFlag()

		if var_171_0[var_171_1] ~= nil then
			arg_171_1.duration_ = var_171_0[var_171_1]
		end

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play322062043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = arg_171_1.actors_["10104ui_story"].transform
			local var_174_1 = 0

			if var_174_1 < arg_171_1.time_ and arg_171_1.time_ <= var_174_1 + arg_174_0 then
				arg_171_1.var_.moveOldPos10104ui_story = var_174_0.localPosition
			end

			local var_174_2 = 0.001

			if var_174_1 <= arg_171_1.time_ and arg_171_1.time_ < var_174_1 + var_174_2 then
				local var_174_3 = (arg_171_1.time_ - var_174_1) / var_174_2
				local var_174_4 = Vector3.New(0.99, -1.12, -5.99)

				var_174_0.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos10104ui_story, var_174_4, var_174_3)

				local var_174_5 = manager.ui.mainCamera.transform.position - var_174_0.position

				var_174_0.forward = Vector3.New(var_174_5.x, var_174_5.y, var_174_5.z)

				local var_174_6 = var_174_0.localEulerAngles

				var_174_6.z = 0
				var_174_6.x = 0
				var_174_0.localEulerAngles = var_174_6
			end

			if arg_171_1.time_ >= var_174_1 + var_174_2 and arg_171_1.time_ < var_174_1 + var_174_2 + arg_174_0 then
				var_174_0.localPosition = Vector3.New(0.99, -1.12, -5.99)

				local var_174_7 = manager.ui.mainCamera.transform.position - var_174_0.position

				var_174_0.forward = Vector3.New(var_174_7.x, var_174_7.y, var_174_7.z)

				local var_174_8 = var_174_0.localEulerAngles

				var_174_8.z = 0
				var_174_8.x = 0
				var_174_0.localEulerAngles = var_174_8
			end

			local var_174_9 = arg_171_1.actors_["10104ui_story"]
			local var_174_10 = 0

			if var_174_10 < arg_171_1.time_ and arg_171_1.time_ <= var_174_10 + arg_174_0 and not isNil(var_174_9) and arg_171_1.var_.characterEffect10104ui_story == nil then
				arg_171_1.var_.characterEffect10104ui_story = var_174_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_11 = 0.200000002980232

			if var_174_10 <= arg_171_1.time_ and arg_171_1.time_ < var_174_10 + var_174_11 and not isNil(var_174_9) then
				local var_174_12 = (arg_171_1.time_ - var_174_10) / var_174_11

				if arg_171_1.var_.characterEffect10104ui_story and not isNil(var_174_9) then
					arg_171_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_171_1.time_ >= var_174_10 + var_174_11 and arg_171_1.time_ < var_174_10 + var_174_11 + arg_174_0 and not isNil(var_174_9) and arg_171_1.var_.characterEffect10104ui_story then
				arg_171_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_174_13 = arg_171_1.actors_["1211ui_story"]
			local var_174_14 = 0

			if var_174_14 < arg_171_1.time_ and arg_171_1.time_ <= var_174_14 + arg_174_0 and not isNil(var_174_13) and arg_171_1.var_.characterEffect1211ui_story == nil then
				arg_171_1.var_.characterEffect1211ui_story = var_174_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_15 = 0.200000002980232

			if var_174_14 <= arg_171_1.time_ and arg_171_1.time_ < var_174_14 + var_174_15 and not isNil(var_174_13) then
				local var_174_16 = (arg_171_1.time_ - var_174_14) / var_174_15

				if arg_171_1.var_.characterEffect1211ui_story and not isNil(var_174_13) then
					local var_174_17 = Mathf.Lerp(0, 0.5, var_174_16)

					arg_171_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_171_1.var_.characterEffect1211ui_story.fillRatio = var_174_17
				end
			end

			if arg_171_1.time_ >= var_174_14 + var_174_15 and arg_171_1.time_ < var_174_14 + var_174_15 + arg_174_0 and not isNil(var_174_13) and arg_171_1.var_.characterEffect1211ui_story then
				local var_174_18 = 0.5

				arg_171_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_171_1.var_.characterEffect1211ui_story.fillRatio = var_174_18
			end

			local var_174_19 = 0

			if var_174_19 < arg_171_1.time_ and arg_171_1.time_ <= var_174_19 + arg_174_0 then
				arg_171_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action1_1")
			end

			local var_174_20 = 0

			if var_174_20 < arg_171_1.time_ and arg_171_1.time_ <= var_174_20 + arg_174_0 then
				arg_171_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_174_21 = arg_171_1.actors_["10104ui_story"]
			local var_174_22 = 0

			if var_174_22 < arg_171_1.time_ and arg_171_1.time_ <= var_174_22 + arg_174_0 then
				if arg_171_1.var_.characterEffect10104ui_story == nil then
					arg_171_1.var_.characterEffect10104ui_story = var_174_21:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_174_23 = arg_171_1.var_.characterEffect10104ui_story

				var_174_23.imageEffect:turnOff()

				var_174_23.interferenceEffect.enabled = true
				var_174_23.interferenceEffect.noise = 0.001
				var_174_23.interferenceEffect.simTimeScale = 1
				var_174_23.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_174_24 = arg_171_1.actors_["10104ui_story"]
			local var_174_25 = 0
			local var_174_26 = 5

			if var_174_25 < arg_171_1.time_ and arg_171_1.time_ <= var_174_25 + arg_174_0 then
				if arg_171_1.var_.characterEffect10104ui_story == nil then
					arg_171_1.var_.characterEffect10104ui_story = var_174_24:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_171_1.var_.characterEffect10104ui_story.imageEffect:turnOn(false)
			end

			local var_174_27 = 0
			local var_174_28 = 0.55

			if var_174_27 < arg_171_1.time_ and arg_171_1.time_ <= var_174_27 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				local var_174_29 = arg_171_1:FormatText(StoryNameCfg[1030].name)

				arg_171_1.leftNameTxt_.text = var_174_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_30 = arg_171_1:GetWordFromCfg(322062042)
				local var_174_31 = arg_171_1:FormatText(var_174_30.content)

				arg_171_1.text_.text = var_174_31

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_32 = 22
				local var_174_33 = utf8.len(var_174_31)
				local var_174_34 = var_174_32 <= 0 and var_174_28 or var_174_28 * (var_174_33 / var_174_32)

				if var_174_34 > 0 and var_174_28 < var_174_34 then
					arg_171_1.talkMaxDuration = var_174_34

					if var_174_34 + var_174_27 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_34 + var_174_27
					end
				end

				arg_171_1.text_.text = var_174_31
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062042", "story_v_out_322062.awb") ~= 0 then
					local var_174_35 = manager.audio:GetVoiceLength("story_v_out_322062", "322062042", "story_v_out_322062.awb") / 1000

					if var_174_35 + var_174_27 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_35 + var_174_27
					end

					if var_174_30.prefab_name ~= "" and arg_171_1.actors_[var_174_30.prefab_name] ~= nil then
						local var_174_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_30.prefab_name].transform, "story_v_out_322062", "322062042", "story_v_out_322062.awb")

						arg_171_1:RecordAudio("322062042", var_174_36)
						arg_171_1:RecordAudio("322062042", var_174_36)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_322062", "322062042", "story_v_out_322062.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_322062", "322062042", "story_v_out_322062.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_37 = math.max(var_174_28, arg_171_1.talkMaxDuration)

			if var_174_27 <= arg_171_1.time_ and arg_171_1.time_ < var_174_27 + var_174_37 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_27) / var_174_37

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_27 + var_174_37 and arg_171_1.time_ < var_174_27 + var_174_37 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_171_1:InitPlayNodeList()
	end,
	Play322062043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 322062043
		arg_175_1.duration_ = 5.6

		local var_175_0 = {
			zh = 4.166,
			ja = 5.6
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
				arg_175_0:Play322062044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = arg_175_1.actors_["404001ui_story"].transform
			local var_178_1 = 0

			if var_178_1 < arg_175_1.time_ and arg_175_1.time_ <= var_178_1 + arg_178_0 then
				arg_175_1.var_.moveOldPos404001ui_story = var_178_0.localPosition
			end

			local var_178_2 = 0.001

			if var_178_1 <= arg_175_1.time_ and arg_175_1.time_ < var_178_1 + var_178_2 then
				local var_178_3 = (arg_175_1.time_ - var_178_1) / var_178_2
				local var_178_4 = Vector3.New(-0.8, -1.55, -5.5)

				var_178_0.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos404001ui_story, var_178_4, var_178_3)

				local var_178_5 = manager.ui.mainCamera.transform.position - var_178_0.position

				var_178_0.forward = Vector3.New(var_178_5.x, var_178_5.y, var_178_5.z)

				local var_178_6 = var_178_0.localEulerAngles

				var_178_6.z = 0
				var_178_6.x = 0
				var_178_0.localEulerAngles = var_178_6
			end

			if arg_175_1.time_ >= var_178_1 + var_178_2 and arg_175_1.time_ < var_178_1 + var_178_2 + arg_178_0 then
				var_178_0.localPosition = Vector3.New(-0.8, -1.55, -5.5)

				local var_178_7 = manager.ui.mainCamera.transform.position - var_178_0.position

				var_178_0.forward = Vector3.New(var_178_7.x, var_178_7.y, var_178_7.z)

				local var_178_8 = var_178_0.localEulerAngles

				var_178_8.z = 0
				var_178_8.x = 0
				var_178_0.localEulerAngles = var_178_8
			end

			local var_178_9 = arg_175_1.actors_["1211ui_story"].transform
			local var_178_10 = 0

			if var_178_10 < arg_175_1.time_ and arg_175_1.time_ <= var_178_10 + arg_178_0 then
				arg_175_1.var_.moveOldPos1211ui_story = var_178_9.localPosition
			end

			local var_178_11 = 0.001

			if var_178_10 <= arg_175_1.time_ and arg_175_1.time_ < var_178_10 + var_178_11 then
				local var_178_12 = (arg_175_1.time_ - var_178_10) / var_178_11
				local var_178_13 = Vector3.New(0, 100, 0)

				var_178_9.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos1211ui_story, var_178_13, var_178_12)

				local var_178_14 = manager.ui.mainCamera.transform.position - var_178_9.position

				var_178_9.forward = Vector3.New(var_178_14.x, var_178_14.y, var_178_14.z)

				local var_178_15 = var_178_9.localEulerAngles

				var_178_15.z = 0
				var_178_15.x = 0
				var_178_9.localEulerAngles = var_178_15
			end

			if arg_175_1.time_ >= var_178_10 + var_178_11 and arg_175_1.time_ < var_178_10 + var_178_11 + arg_178_0 then
				var_178_9.localPosition = Vector3.New(0, 100, 0)

				local var_178_16 = manager.ui.mainCamera.transform.position - var_178_9.position

				var_178_9.forward = Vector3.New(var_178_16.x, var_178_16.y, var_178_16.z)

				local var_178_17 = var_178_9.localEulerAngles

				var_178_17.z = 0
				var_178_17.x = 0
				var_178_9.localEulerAngles = var_178_17
			end

			local var_178_18 = arg_175_1.actors_["404001ui_story"]
			local var_178_19 = 0

			if var_178_19 < arg_175_1.time_ and arg_175_1.time_ <= var_178_19 + arg_178_0 and not isNil(var_178_18) and arg_175_1.var_.characterEffect404001ui_story == nil then
				arg_175_1.var_.characterEffect404001ui_story = var_178_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_20 = 0.200000002980232

			if var_178_19 <= arg_175_1.time_ and arg_175_1.time_ < var_178_19 + var_178_20 and not isNil(var_178_18) then
				local var_178_21 = (arg_175_1.time_ - var_178_19) / var_178_20

				if arg_175_1.var_.characterEffect404001ui_story and not isNil(var_178_18) then
					arg_175_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_175_1.time_ >= var_178_19 + var_178_20 and arg_175_1.time_ < var_178_19 + var_178_20 + arg_178_0 and not isNil(var_178_18) and arg_175_1.var_.characterEffect404001ui_story then
				arg_175_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_178_22 = arg_175_1.actors_["10104ui_story"]
			local var_178_23 = 0

			if var_178_23 < arg_175_1.time_ and arg_175_1.time_ <= var_178_23 + arg_178_0 and not isNil(var_178_22) and arg_175_1.var_.characterEffect10104ui_story == nil then
				arg_175_1.var_.characterEffect10104ui_story = var_178_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_24 = 0.200000002980232

			if var_178_23 <= arg_175_1.time_ and arg_175_1.time_ < var_178_23 + var_178_24 and not isNil(var_178_22) then
				local var_178_25 = (arg_175_1.time_ - var_178_23) / var_178_24

				if arg_175_1.var_.characterEffect10104ui_story and not isNil(var_178_22) then
					local var_178_26 = Mathf.Lerp(0, 0.5, var_178_25)

					arg_175_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_175_1.var_.characterEffect10104ui_story.fillRatio = var_178_26
				end
			end

			if arg_175_1.time_ >= var_178_23 + var_178_24 and arg_175_1.time_ < var_178_23 + var_178_24 + arg_178_0 and not isNil(var_178_22) and arg_175_1.var_.characterEffect10104ui_story then
				local var_178_27 = 0.5

				arg_175_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_175_1.var_.characterEffect10104ui_story.fillRatio = var_178_27
			end

			local var_178_28 = 0

			if var_178_28 < arg_175_1.time_ and arg_175_1.time_ <= var_178_28 + arg_178_0 then
				arg_175_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_178_29 = 0

			if var_178_29 < arg_175_1.time_ and arg_175_1.time_ <= var_178_29 + arg_178_0 then
				arg_175_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_178_30 = 0
			local var_178_31 = 0.475

			if var_178_30 < arg_175_1.time_ and arg_175_1.time_ <= var_178_30 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				local var_178_32 = arg_175_1:FormatText(StoryNameCfg[668].name)

				arg_175_1.leftNameTxt_.text = var_178_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_33 = arg_175_1:GetWordFromCfg(322062043)
				local var_178_34 = arg_175_1:FormatText(var_178_33.content)

				arg_175_1.text_.text = var_178_34

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_35 = 19
				local var_178_36 = utf8.len(var_178_34)
				local var_178_37 = var_178_35 <= 0 and var_178_31 or var_178_31 * (var_178_36 / var_178_35)

				if var_178_37 > 0 and var_178_31 < var_178_37 then
					arg_175_1.talkMaxDuration = var_178_37

					if var_178_37 + var_178_30 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_37 + var_178_30
					end
				end

				arg_175_1.text_.text = var_178_34
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062043", "story_v_out_322062.awb") ~= 0 then
					local var_178_38 = manager.audio:GetVoiceLength("story_v_out_322062", "322062043", "story_v_out_322062.awb") / 1000

					if var_178_38 + var_178_30 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_38 + var_178_30
					end

					if var_178_33.prefab_name ~= "" and arg_175_1.actors_[var_178_33.prefab_name] ~= nil then
						local var_178_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_33.prefab_name].transform, "story_v_out_322062", "322062043", "story_v_out_322062.awb")

						arg_175_1:RecordAudio("322062043", var_178_39)
						arg_175_1:RecordAudio("322062043", var_178_39)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_322062", "322062043", "story_v_out_322062.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_322062", "322062043", "story_v_out_322062.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_40 = math.max(var_178_31, arg_175_1.talkMaxDuration)

			if var_178_30 <= arg_175_1.time_ and arg_175_1.time_ < var_178_30 + var_178_40 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_30) / var_178_40

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_30 + var_178_40 and arg_175_1.time_ < var_178_30 + var_178_40 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_175_1:InitPlayNodeList()
	end,
	Play322062044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 322062044
		arg_179_1.duration_ = 9.7

		local var_179_0 = {
			zh = 4.999999999999,
			ja = 9.7
		}
		local var_179_1 = manager.audio:GetLocalizationFlag()

		if var_179_0[var_179_1] ~= nil then
			arg_179_1.duration_ = var_179_0[var_179_1]
		end

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play322062045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = arg_179_1.actors_["10104ui_story"].transform
			local var_182_1 = 0

			if var_182_1 < arg_179_1.time_ and arg_179_1.time_ <= var_182_1 + arg_182_0 then
				arg_179_1.var_.moveOldPos10104ui_story = var_182_0.localPosition
			end

			local var_182_2 = 0.001

			if var_182_1 <= arg_179_1.time_ and arg_179_1.time_ < var_182_1 + var_182_2 then
				local var_182_3 = (arg_179_1.time_ - var_182_1) / var_182_2
				local var_182_4 = Vector3.New(0.99, -1.12, -5.99)

				var_182_0.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos10104ui_story, var_182_4, var_182_3)

				local var_182_5 = manager.ui.mainCamera.transform.position - var_182_0.position

				var_182_0.forward = Vector3.New(var_182_5.x, var_182_5.y, var_182_5.z)

				local var_182_6 = var_182_0.localEulerAngles

				var_182_6.z = 0
				var_182_6.x = 0
				var_182_0.localEulerAngles = var_182_6
			end

			if arg_179_1.time_ >= var_182_1 + var_182_2 and arg_179_1.time_ < var_182_1 + var_182_2 + arg_182_0 then
				var_182_0.localPosition = Vector3.New(0.99, -1.12, -5.99)

				local var_182_7 = manager.ui.mainCamera.transform.position - var_182_0.position

				var_182_0.forward = Vector3.New(var_182_7.x, var_182_7.y, var_182_7.z)

				local var_182_8 = var_182_0.localEulerAngles

				var_182_8.z = 0
				var_182_8.x = 0
				var_182_0.localEulerAngles = var_182_8
			end

			local var_182_9 = arg_179_1.actors_["10104ui_story"]
			local var_182_10 = 0

			if var_182_10 < arg_179_1.time_ and arg_179_1.time_ <= var_182_10 + arg_182_0 and not isNil(var_182_9) and arg_179_1.var_.characterEffect10104ui_story == nil then
				arg_179_1.var_.characterEffect10104ui_story = var_182_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_11 = 0.200000002980232

			if var_182_10 <= arg_179_1.time_ and arg_179_1.time_ < var_182_10 + var_182_11 and not isNil(var_182_9) then
				local var_182_12 = (arg_179_1.time_ - var_182_10) / var_182_11

				if arg_179_1.var_.characterEffect10104ui_story and not isNil(var_182_9) then
					arg_179_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_179_1.time_ >= var_182_10 + var_182_11 and arg_179_1.time_ < var_182_10 + var_182_11 + arg_182_0 and not isNil(var_182_9) and arg_179_1.var_.characterEffect10104ui_story then
				arg_179_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_182_13 = arg_179_1.actors_["404001ui_story"]
			local var_182_14 = 0

			if var_182_14 < arg_179_1.time_ and arg_179_1.time_ <= var_182_14 + arg_182_0 and not isNil(var_182_13) and arg_179_1.var_.characterEffect404001ui_story == nil then
				arg_179_1.var_.characterEffect404001ui_story = var_182_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_15 = 0.200000002980232

			if var_182_14 <= arg_179_1.time_ and arg_179_1.time_ < var_182_14 + var_182_15 and not isNil(var_182_13) then
				local var_182_16 = (arg_179_1.time_ - var_182_14) / var_182_15

				if arg_179_1.var_.characterEffect404001ui_story and not isNil(var_182_13) then
					local var_182_17 = Mathf.Lerp(0, 0.5, var_182_16)

					arg_179_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_179_1.var_.characterEffect404001ui_story.fillRatio = var_182_17
				end
			end

			if arg_179_1.time_ >= var_182_14 + var_182_15 and arg_179_1.time_ < var_182_14 + var_182_15 + arg_182_0 and not isNil(var_182_13) and arg_179_1.var_.characterEffect404001ui_story then
				local var_182_18 = 0.5

				arg_179_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_179_1.var_.characterEffect404001ui_story.fillRatio = var_182_18
			end

			local var_182_19 = 0

			if var_182_19 < arg_179_1.time_ and arg_179_1.time_ <= var_182_19 + arg_182_0 then
				arg_179_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action1_1")
			end

			local var_182_20 = 0

			if var_182_20 < arg_179_1.time_ and arg_179_1.time_ <= var_182_20 + arg_182_0 then
				arg_179_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_182_21 = arg_179_1.actors_["10104ui_story"]
			local var_182_22 = 0

			if var_182_22 < arg_179_1.time_ and arg_179_1.time_ <= var_182_22 + arg_182_0 then
				if arg_179_1.var_.characterEffect10104ui_story == nil then
					arg_179_1.var_.characterEffect10104ui_story = var_182_21:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_182_23 = arg_179_1.var_.characterEffect10104ui_story

				var_182_23.imageEffect:turnOff()

				var_182_23.interferenceEffect.enabled = true
				var_182_23.interferenceEffect.noise = 0.001
				var_182_23.interferenceEffect.simTimeScale = 1
				var_182_23.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_182_24 = arg_179_1.actors_["10104ui_story"]
			local var_182_25 = 0
			local var_182_26 = 5

			if var_182_25 < arg_179_1.time_ and arg_179_1.time_ <= var_182_25 + arg_182_0 then
				if arg_179_1.var_.characterEffect10104ui_story == nil then
					arg_179_1.var_.characterEffect10104ui_story = var_182_24:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_179_1.var_.characterEffect10104ui_story.imageEffect:turnOn(false)
			end

			local var_182_27 = 0
			local var_182_28 = 0.6

			if var_182_27 < arg_179_1.time_ and arg_179_1.time_ <= var_182_27 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				local var_182_29 = arg_179_1:FormatText(StoryNameCfg[1030].name)

				arg_179_1.leftNameTxt_.text = var_182_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_30 = arg_179_1:GetWordFromCfg(322062044)
				local var_182_31 = arg_179_1:FormatText(var_182_30.content)

				arg_179_1.text_.text = var_182_31

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_32 = 24
				local var_182_33 = utf8.len(var_182_31)
				local var_182_34 = var_182_32 <= 0 and var_182_28 or var_182_28 * (var_182_33 / var_182_32)

				if var_182_34 > 0 and var_182_28 < var_182_34 then
					arg_179_1.talkMaxDuration = var_182_34

					if var_182_34 + var_182_27 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_34 + var_182_27
					end
				end

				arg_179_1.text_.text = var_182_31
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062044", "story_v_out_322062.awb") ~= 0 then
					local var_182_35 = manager.audio:GetVoiceLength("story_v_out_322062", "322062044", "story_v_out_322062.awb") / 1000

					if var_182_35 + var_182_27 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_35 + var_182_27
					end

					if var_182_30.prefab_name ~= "" and arg_179_1.actors_[var_182_30.prefab_name] ~= nil then
						local var_182_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_30.prefab_name].transform, "story_v_out_322062", "322062044", "story_v_out_322062.awb")

						arg_179_1:RecordAudio("322062044", var_182_36)
						arg_179_1:RecordAudio("322062044", var_182_36)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_322062", "322062044", "story_v_out_322062.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_322062", "322062044", "story_v_out_322062.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_37 = math.max(var_182_28, arg_179_1.talkMaxDuration)

			if var_182_27 <= arg_179_1.time_ and arg_179_1.time_ < var_182_27 + var_182_37 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_27) / var_182_37

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_27 + var_182_37 and arg_179_1.time_ < var_182_27 + var_182_37 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_179_1:InitPlayNodeList()
	end,
	Play322062045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 322062045
		arg_183_1.duration_ = 14.33

		local var_183_0 = {
			zh = 8.133,
			ja = 14.333
		}
		local var_183_1 = manager.audio:GetLocalizationFlag()

		if var_183_0[var_183_1] ~= nil then
			arg_183_1.duration_ = var_183_0[var_183_1]
		end

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play322062046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = arg_183_1.actors_["10104ui_story"].transform
			local var_186_1 = 0

			if var_186_1 < arg_183_1.time_ and arg_183_1.time_ <= var_186_1 + arg_186_0 then
				arg_183_1.var_.moveOldPos10104ui_story = var_186_0.localPosition
			end

			local var_186_2 = 0.001

			if var_186_1 <= arg_183_1.time_ and arg_183_1.time_ < var_186_1 + var_186_2 then
				local var_186_3 = (arg_183_1.time_ - var_186_1) / var_186_2
				local var_186_4 = Vector3.New(0.99, -1.12, -5.99)

				var_186_0.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos10104ui_story, var_186_4, var_186_3)

				local var_186_5 = manager.ui.mainCamera.transform.position - var_186_0.position

				var_186_0.forward = Vector3.New(var_186_5.x, var_186_5.y, var_186_5.z)

				local var_186_6 = var_186_0.localEulerAngles

				var_186_6.z = 0
				var_186_6.x = 0
				var_186_0.localEulerAngles = var_186_6
			end

			if arg_183_1.time_ >= var_186_1 + var_186_2 and arg_183_1.time_ < var_186_1 + var_186_2 + arg_186_0 then
				var_186_0.localPosition = Vector3.New(0.99, -1.12, -5.99)

				local var_186_7 = manager.ui.mainCamera.transform.position - var_186_0.position

				var_186_0.forward = Vector3.New(var_186_7.x, var_186_7.y, var_186_7.z)

				local var_186_8 = var_186_0.localEulerAngles

				var_186_8.z = 0
				var_186_8.x = 0
				var_186_0.localEulerAngles = var_186_8
			end

			local var_186_9 = 0

			if var_186_9 < arg_183_1.time_ and arg_183_1.time_ <= var_186_9 + arg_186_0 then
				arg_183_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action1_1")
			end

			local var_186_10 = 0

			if var_186_10 < arg_183_1.time_ and arg_183_1.time_ <= var_186_10 + arg_186_0 then
				arg_183_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_186_11 = arg_183_1.actors_["10104ui_story"]
			local var_186_12 = 0

			if var_186_12 < arg_183_1.time_ and arg_183_1.time_ <= var_186_12 + arg_186_0 then
				if arg_183_1.var_.characterEffect10104ui_story == nil then
					arg_183_1.var_.characterEffect10104ui_story = var_186_11:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_186_13 = arg_183_1.var_.characterEffect10104ui_story

				var_186_13.imageEffect:turnOff()

				var_186_13.interferenceEffect.enabled = true
				var_186_13.interferenceEffect.noise = 0.001
				var_186_13.interferenceEffect.simTimeScale = 1
				var_186_13.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_186_14 = arg_183_1.actors_["10104ui_story"]
			local var_186_15 = 0
			local var_186_16 = 5

			if var_186_15 < arg_183_1.time_ and arg_183_1.time_ <= var_186_15 + arg_186_0 then
				if arg_183_1.var_.characterEffect10104ui_story == nil then
					arg_183_1.var_.characterEffect10104ui_story = var_186_14:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_183_1.var_.characterEffect10104ui_story.imageEffect:turnOn(false)
			end

			local var_186_17 = 0
			local var_186_18 = 0.95

			if var_186_17 < arg_183_1.time_ and arg_183_1.time_ <= var_186_17 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				local var_186_19 = arg_183_1:FormatText(StoryNameCfg[1030].name)

				arg_183_1.leftNameTxt_.text = var_186_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_20 = arg_183_1:GetWordFromCfg(322062045)
				local var_186_21 = arg_183_1:FormatText(var_186_20.content)

				arg_183_1.text_.text = var_186_21

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_22 = 38
				local var_186_23 = utf8.len(var_186_21)
				local var_186_24 = var_186_22 <= 0 and var_186_18 or var_186_18 * (var_186_23 / var_186_22)

				if var_186_24 > 0 and var_186_18 < var_186_24 then
					arg_183_1.talkMaxDuration = var_186_24

					if var_186_24 + var_186_17 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_24 + var_186_17
					end
				end

				arg_183_1.text_.text = var_186_21
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062045", "story_v_out_322062.awb") ~= 0 then
					local var_186_25 = manager.audio:GetVoiceLength("story_v_out_322062", "322062045", "story_v_out_322062.awb") / 1000

					if var_186_25 + var_186_17 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_25 + var_186_17
					end

					if var_186_20.prefab_name ~= "" and arg_183_1.actors_[var_186_20.prefab_name] ~= nil then
						local var_186_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_20.prefab_name].transform, "story_v_out_322062", "322062045", "story_v_out_322062.awb")

						arg_183_1:RecordAudio("322062045", var_186_26)
						arg_183_1:RecordAudio("322062045", var_186_26)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_322062", "322062045", "story_v_out_322062.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_322062", "322062045", "story_v_out_322062.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_27 = math.max(var_186_18, arg_183_1.talkMaxDuration)

			if var_186_17 <= arg_183_1.time_ and arg_183_1.time_ < var_186_17 + var_186_27 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_17) / var_186_27

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_17 + var_186_27 and arg_183_1.time_ < var_186_17 + var_186_27 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_183_1:InitPlayNodeList()
	end,
	Play322062046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 322062046
		arg_187_1.duration_ = 3.8

		local var_187_0 = {
			zh = 2.666,
			ja = 3.8
		}
		local var_187_1 = manager.audio:GetLocalizationFlag()

		if var_187_0[var_187_1] ~= nil then
			arg_187_1.duration_ = var_187_0[var_187_1]
		end

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play322062047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = arg_187_1.actors_["404001ui_story"].transform
			local var_190_1 = 0

			if var_190_1 < arg_187_1.time_ and arg_187_1.time_ <= var_190_1 + arg_190_0 then
				arg_187_1.var_.moveOldPos404001ui_story = var_190_0.localPosition
			end

			local var_190_2 = 0.001

			if var_190_1 <= arg_187_1.time_ and arg_187_1.time_ < var_190_1 + var_190_2 then
				local var_190_3 = (arg_187_1.time_ - var_190_1) / var_190_2
				local var_190_4 = Vector3.New(-0.8, -1.55, -5.5)

				var_190_0.localPosition = Vector3.Lerp(arg_187_1.var_.moveOldPos404001ui_story, var_190_4, var_190_3)

				local var_190_5 = manager.ui.mainCamera.transform.position - var_190_0.position

				var_190_0.forward = Vector3.New(var_190_5.x, var_190_5.y, var_190_5.z)

				local var_190_6 = var_190_0.localEulerAngles

				var_190_6.z = 0
				var_190_6.x = 0
				var_190_0.localEulerAngles = var_190_6
			end

			if arg_187_1.time_ >= var_190_1 + var_190_2 and arg_187_1.time_ < var_190_1 + var_190_2 + arg_190_0 then
				var_190_0.localPosition = Vector3.New(-0.8, -1.55, -5.5)

				local var_190_7 = manager.ui.mainCamera.transform.position - var_190_0.position

				var_190_0.forward = Vector3.New(var_190_7.x, var_190_7.y, var_190_7.z)

				local var_190_8 = var_190_0.localEulerAngles

				var_190_8.z = 0
				var_190_8.x = 0
				var_190_0.localEulerAngles = var_190_8
			end

			local var_190_9 = arg_187_1.actors_["404001ui_story"]
			local var_190_10 = 0

			if var_190_10 < arg_187_1.time_ and arg_187_1.time_ <= var_190_10 + arg_190_0 and not isNil(var_190_9) and arg_187_1.var_.characterEffect404001ui_story == nil then
				arg_187_1.var_.characterEffect404001ui_story = var_190_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_11 = 0.200000002980232

			if var_190_10 <= arg_187_1.time_ and arg_187_1.time_ < var_190_10 + var_190_11 and not isNil(var_190_9) then
				local var_190_12 = (arg_187_1.time_ - var_190_10) / var_190_11

				if arg_187_1.var_.characterEffect404001ui_story and not isNil(var_190_9) then
					arg_187_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_187_1.time_ >= var_190_10 + var_190_11 and arg_187_1.time_ < var_190_10 + var_190_11 + arg_190_0 and not isNil(var_190_9) and arg_187_1.var_.characterEffect404001ui_story then
				arg_187_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_190_13 = arg_187_1.actors_["10104ui_story"]
			local var_190_14 = 0

			if var_190_14 < arg_187_1.time_ and arg_187_1.time_ <= var_190_14 + arg_190_0 and not isNil(var_190_13) and arg_187_1.var_.characterEffect10104ui_story == nil then
				arg_187_1.var_.characterEffect10104ui_story = var_190_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_15 = 0.200000002980232

			if var_190_14 <= arg_187_1.time_ and arg_187_1.time_ < var_190_14 + var_190_15 and not isNil(var_190_13) then
				local var_190_16 = (arg_187_1.time_ - var_190_14) / var_190_15

				if arg_187_1.var_.characterEffect10104ui_story and not isNil(var_190_13) then
					local var_190_17 = Mathf.Lerp(0, 0.5, var_190_16)

					arg_187_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_187_1.var_.characterEffect10104ui_story.fillRatio = var_190_17
				end
			end

			if arg_187_1.time_ >= var_190_14 + var_190_15 and arg_187_1.time_ < var_190_14 + var_190_15 + arg_190_0 and not isNil(var_190_13) and arg_187_1.var_.characterEffect10104ui_story then
				local var_190_18 = 0.5

				arg_187_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_187_1.var_.characterEffect10104ui_story.fillRatio = var_190_18
			end

			local var_190_19 = 0

			if var_190_19 < arg_187_1.time_ and arg_187_1.time_ <= var_190_19 + arg_190_0 then
				arg_187_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action5_1")
			end

			local var_190_20 = 0

			if var_190_20 < arg_187_1.time_ and arg_187_1.time_ <= var_190_20 + arg_190_0 then
				arg_187_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_190_21 = 0
			local var_190_22 = 0.35

			if var_190_21 < arg_187_1.time_ and arg_187_1.time_ <= var_190_21 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				local var_190_23 = arg_187_1:FormatText(StoryNameCfg[668].name)

				arg_187_1.leftNameTxt_.text = var_190_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_24 = arg_187_1:GetWordFromCfg(322062046)
				local var_190_25 = arg_187_1:FormatText(var_190_24.content)

				arg_187_1.text_.text = var_190_25

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_26 = 14
				local var_190_27 = utf8.len(var_190_25)
				local var_190_28 = var_190_26 <= 0 and var_190_22 or var_190_22 * (var_190_27 / var_190_26)

				if var_190_28 > 0 and var_190_22 < var_190_28 then
					arg_187_1.talkMaxDuration = var_190_28

					if var_190_28 + var_190_21 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_28 + var_190_21
					end
				end

				arg_187_1.text_.text = var_190_25
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062046", "story_v_out_322062.awb") ~= 0 then
					local var_190_29 = manager.audio:GetVoiceLength("story_v_out_322062", "322062046", "story_v_out_322062.awb") / 1000

					if var_190_29 + var_190_21 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_29 + var_190_21
					end

					if var_190_24.prefab_name ~= "" and arg_187_1.actors_[var_190_24.prefab_name] ~= nil then
						local var_190_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_24.prefab_name].transform, "story_v_out_322062", "322062046", "story_v_out_322062.awb")

						arg_187_1:RecordAudio("322062046", var_190_30)
						arg_187_1:RecordAudio("322062046", var_190_30)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_322062", "322062046", "story_v_out_322062.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_322062", "322062046", "story_v_out_322062.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_31 = math.max(var_190_22, arg_187_1.talkMaxDuration)

			if var_190_21 <= arg_187_1.time_ and arg_187_1.time_ < var_190_21 + var_190_31 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_21) / var_190_31

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_21 + var_190_31 and arg_187_1.time_ < var_190_21 + var_190_31 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_187_1:InitPlayNodeList()
	end,
	Play322062047 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 322062047
		arg_191_1.duration_ = 5

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play322062048(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = arg_191_1.actors_["404001ui_story"].transform
			local var_194_1 = 0

			if var_194_1 < arg_191_1.time_ and arg_191_1.time_ <= var_194_1 + arg_194_0 then
				arg_191_1.var_.moveOldPos404001ui_story = var_194_0.localPosition
			end

			local var_194_2 = 0.001

			if var_194_1 <= arg_191_1.time_ and arg_191_1.time_ < var_194_1 + var_194_2 then
				local var_194_3 = (arg_191_1.time_ - var_194_1) / var_194_2
				local var_194_4 = Vector3.New(0, 100, 0)

				var_194_0.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos404001ui_story, var_194_4, var_194_3)

				local var_194_5 = manager.ui.mainCamera.transform.position - var_194_0.position

				var_194_0.forward = Vector3.New(var_194_5.x, var_194_5.y, var_194_5.z)

				local var_194_6 = var_194_0.localEulerAngles

				var_194_6.z = 0
				var_194_6.x = 0
				var_194_0.localEulerAngles = var_194_6
			end

			if arg_191_1.time_ >= var_194_1 + var_194_2 and arg_191_1.time_ < var_194_1 + var_194_2 + arg_194_0 then
				var_194_0.localPosition = Vector3.New(0, 100, 0)

				local var_194_7 = manager.ui.mainCamera.transform.position - var_194_0.position

				var_194_0.forward = Vector3.New(var_194_7.x, var_194_7.y, var_194_7.z)

				local var_194_8 = var_194_0.localEulerAngles

				var_194_8.z = 0
				var_194_8.x = 0
				var_194_0.localEulerAngles = var_194_8
			end

			local var_194_9 = arg_191_1.actors_["10104ui_story"].transform
			local var_194_10 = 0

			if var_194_10 < arg_191_1.time_ and arg_191_1.time_ <= var_194_10 + arg_194_0 then
				arg_191_1.var_.moveOldPos10104ui_story = var_194_9.localPosition
			end

			local var_194_11 = 0.001

			if var_194_10 <= arg_191_1.time_ and arg_191_1.time_ < var_194_10 + var_194_11 then
				local var_194_12 = (arg_191_1.time_ - var_194_10) / var_194_11
				local var_194_13 = Vector3.New(0, 100, 0)

				var_194_9.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos10104ui_story, var_194_13, var_194_12)

				local var_194_14 = manager.ui.mainCamera.transform.position - var_194_9.position

				var_194_9.forward = Vector3.New(var_194_14.x, var_194_14.y, var_194_14.z)

				local var_194_15 = var_194_9.localEulerAngles

				var_194_15.z = 0
				var_194_15.x = 0
				var_194_9.localEulerAngles = var_194_15
			end

			if arg_191_1.time_ >= var_194_10 + var_194_11 and arg_191_1.time_ < var_194_10 + var_194_11 + arg_194_0 then
				var_194_9.localPosition = Vector3.New(0, 100, 0)

				local var_194_16 = manager.ui.mainCamera.transform.position - var_194_9.position

				var_194_9.forward = Vector3.New(var_194_16.x, var_194_16.y, var_194_16.z)

				local var_194_17 = var_194_9.localEulerAngles

				var_194_17.z = 0
				var_194_17.x = 0
				var_194_9.localEulerAngles = var_194_17
			end

			local var_194_18 = arg_191_1.actors_["404001ui_story"]
			local var_194_19 = 0

			if var_194_19 < arg_191_1.time_ and arg_191_1.time_ <= var_194_19 + arg_194_0 and not isNil(var_194_18) and arg_191_1.var_.characterEffect404001ui_story == nil then
				arg_191_1.var_.characterEffect404001ui_story = var_194_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_20 = 0.200000002980232

			if var_194_19 <= arg_191_1.time_ and arg_191_1.time_ < var_194_19 + var_194_20 and not isNil(var_194_18) then
				local var_194_21 = (arg_191_1.time_ - var_194_19) / var_194_20

				if arg_191_1.var_.characterEffect404001ui_story and not isNil(var_194_18) then
					local var_194_22 = Mathf.Lerp(0, 0.5, var_194_21)

					arg_191_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_191_1.var_.characterEffect404001ui_story.fillRatio = var_194_22
				end
			end

			if arg_191_1.time_ >= var_194_19 + var_194_20 and arg_191_1.time_ < var_194_19 + var_194_20 + arg_194_0 and not isNil(var_194_18) and arg_191_1.var_.characterEffect404001ui_story then
				local var_194_23 = 0.5

				arg_191_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_191_1.var_.characterEffect404001ui_story.fillRatio = var_194_23
			end

			local var_194_24 = 0
			local var_194_25 = 1

			if var_194_24 < arg_191_1.time_ and arg_191_1.time_ <= var_194_24 + arg_194_0 then
				local var_194_26 = "play"
				local var_194_27 = "effect"

				arg_191_1:AudioAction(var_194_26, var_194_27, "se_story_145", "se_story_145_star_movement_wobble01", "")
			end

			local var_194_28 = 2.1
			local var_194_29 = 1

			if var_194_28 < arg_191_1.time_ and arg_191_1.time_ <= var_194_28 + arg_194_0 then
				local var_194_30 = "play"
				local var_194_31 = "effect"

				arg_191_1:AudioAction(var_194_30, var_194_31, "se_story_145", "se_story_145_star_light", "")
			end

			local var_194_32 = 0
			local var_194_33 = 1.5

			if var_194_32 < arg_191_1.time_ and arg_191_1.time_ <= var_194_32 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, false)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_34 = arg_191_1:GetWordFromCfg(322062047)
				local var_194_35 = arg_191_1:FormatText(var_194_34.content)

				arg_191_1.text_.text = var_194_35

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_36 = 60
				local var_194_37 = utf8.len(var_194_35)
				local var_194_38 = var_194_36 <= 0 and var_194_33 or var_194_33 * (var_194_37 / var_194_36)

				if var_194_38 > 0 and var_194_33 < var_194_38 then
					arg_191_1.talkMaxDuration = var_194_38

					if var_194_38 + var_194_32 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_38 + var_194_32
					end
				end

				arg_191_1.text_.text = var_194_35
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)
				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_39 = math.max(var_194_33, arg_191_1.talkMaxDuration)

			if var_194_32 <= arg_191_1.time_ and arg_191_1.time_ < var_194_32 + var_194_39 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_32) / var_194_39

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_32 + var_194_39 and arg_191_1.time_ < var_194_32 + var_194_39 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_191_1:InitPlayNodeList()
	end,
	Play322062048 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 322062048
		arg_195_1.duration_ = 2.8

		local var_195_0 = {
			zh = 2.8,
			ja = 1.999999999999
		}
		local var_195_1 = manager.audio:GetLocalizationFlag()

		if var_195_0[var_195_1] ~= nil then
			arg_195_1.duration_ = var_195_0[var_195_1]
		end

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play322062049(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = arg_195_1.actors_["1284ui_story"].transform
			local var_198_1 = 0

			if var_198_1 < arg_195_1.time_ and arg_195_1.time_ <= var_198_1 + arg_198_0 then
				arg_195_1.var_.moveOldPos1284ui_story = var_198_0.localPosition
			end

			local var_198_2 = 0.001

			if var_198_1 <= arg_195_1.time_ and arg_195_1.time_ < var_198_1 + var_198_2 then
				local var_198_3 = (arg_195_1.time_ - var_198_1) / var_198_2
				local var_198_4 = Vector3.New(-0.7, -0.985, -6.22)

				var_198_0.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos1284ui_story, var_198_4, var_198_3)

				local var_198_5 = manager.ui.mainCamera.transform.position - var_198_0.position

				var_198_0.forward = Vector3.New(var_198_5.x, var_198_5.y, var_198_5.z)

				local var_198_6 = var_198_0.localEulerAngles

				var_198_6.z = 0
				var_198_6.x = 0
				var_198_0.localEulerAngles = var_198_6
			end

			if arg_195_1.time_ >= var_198_1 + var_198_2 and arg_195_1.time_ < var_198_1 + var_198_2 + arg_198_0 then
				var_198_0.localPosition = Vector3.New(-0.7, -0.985, -6.22)

				local var_198_7 = manager.ui.mainCamera.transform.position - var_198_0.position

				var_198_0.forward = Vector3.New(var_198_7.x, var_198_7.y, var_198_7.z)

				local var_198_8 = var_198_0.localEulerAngles

				var_198_8.z = 0
				var_198_8.x = 0
				var_198_0.localEulerAngles = var_198_8
			end

			local var_198_9 = arg_195_1.actors_["1284ui_story"]
			local var_198_10 = 0

			if var_198_10 < arg_195_1.time_ and arg_195_1.time_ <= var_198_10 + arg_198_0 and not isNil(var_198_9) and arg_195_1.var_.characterEffect1284ui_story == nil then
				arg_195_1.var_.characterEffect1284ui_story = var_198_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_11 = 0.200000002980232

			if var_198_10 <= arg_195_1.time_ and arg_195_1.time_ < var_198_10 + var_198_11 and not isNil(var_198_9) then
				local var_198_12 = (arg_195_1.time_ - var_198_10) / var_198_11

				if arg_195_1.var_.characterEffect1284ui_story and not isNil(var_198_9) then
					arg_195_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_195_1.time_ >= var_198_10 + var_198_11 and arg_195_1.time_ < var_198_10 + var_198_11 + arg_198_0 and not isNil(var_198_9) and arg_195_1.var_.characterEffect1284ui_story then
				arg_195_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_198_13 = 0

			if var_198_13 < arg_195_1.time_ and arg_195_1.time_ <= var_198_13 + arg_198_0 then
				arg_195_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action3_1")
			end

			local var_198_14 = 0

			if var_198_14 < arg_195_1.time_ and arg_195_1.time_ <= var_198_14 + arg_198_0 then
				arg_195_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_198_15 = 0
			local var_198_16 = 0.175

			if var_198_15 < arg_195_1.time_ and arg_195_1.time_ <= var_198_15 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				local var_198_17 = arg_195_1:FormatText(StoryNameCfg[6].name)

				arg_195_1.leftNameTxt_.text = var_198_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_18 = arg_195_1:GetWordFromCfg(322062048)
				local var_198_19 = arg_195_1:FormatText(var_198_18.content)

				arg_195_1.text_.text = var_198_19

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_20 = 7
				local var_198_21 = utf8.len(var_198_19)
				local var_198_22 = var_198_20 <= 0 and var_198_16 or var_198_16 * (var_198_21 / var_198_20)

				if var_198_22 > 0 and var_198_16 < var_198_22 then
					arg_195_1.talkMaxDuration = var_198_22

					if var_198_22 + var_198_15 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_22 + var_198_15
					end
				end

				arg_195_1.text_.text = var_198_19
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062048", "story_v_out_322062.awb") ~= 0 then
					local var_198_23 = manager.audio:GetVoiceLength("story_v_out_322062", "322062048", "story_v_out_322062.awb") / 1000

					if var_198_23 + var_198_15 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_23 + var_198_15
					end

					if var_198_18.prefab_name ~= "" and arg_195_1.actors_[var_198_18.prefab_name] ~= nil then
						local var_198_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_18.prefab_name].transform, "story_v_out_322062", "322062048", "story_v_out_322062.awb")

						arg_195_1:RecordAudio("322062048", var_198_24)
						arg_195_1:RecordAudio("322062048", var_198_24)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_322062", "322062048", "story_v_out_322062.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_322062", "322062048", "story_v_out_322062.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_25 = math.max(var_198_16, arg_195_1.talkMaxDuration)

			if var_198_15 <= arg_195_1.time_ and arg_195_1.time_ < var_198_15 + var_198_25 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_15) / var_198_25

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_15 + var_198_25 and arg_195_1.time_ < var_198_15 + var_198_25 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_195_1:InitPlayNodeList()
	end,
	Play322062049 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 322062049
		arg_199_1.duration_ = 3.37

		local var_199_0 = {
			zh = 3.3,
			ja = 3.366
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
				arg_199_0:Play322062050(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = arg_199_1.actors_["404001ui_story"].transform
			local var_202_1 = 0

			if var_202_1 < arg_199_1.time_ and arg_199_1.time_ <= var_202_1 + arg_202_0 then
				arg_199_1.var_.moveOldPos404001ui_story = var_202_0.localPosition
			end

			local var_202_2 = 0.001

			if var_202_1 <= arg_199_1.time_ and arg_199_1.time_ < var_202_1 + var_202_2 then
				local var_202_3 = (arg_199_1.time_ - var_202_1) / var_202_2
				local var_202_4 = Vector3.New(0.8, -1.55, -5.5)

				var_202_0.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos404001ui_story, var_202_4, var_202_3)

				local var_202_5 = manager.ui.mainCamera.transform.position - var_202_0.position

				var_202_0.forward = Vector3.New(var_202_5.x, var_202_5.y, var_202_5.z)

				local var_202_6 = var_202_0.localEulerAngles

				var_202_6.z = 0
				var_202_6.x = 0
				var_202_0.localEulerAngles = var_202_6
			end

			if arg_199_1.time_ >= var_202_1 + var_202_2 and arg_199_1.time_ < var_202_1 + var_202_2 + arg_202_0 then
				var_202_0.localPosition = Vector3.New(0.8, -1.55, -5.5)

				local var_202_7 = manager.ui.mainCamera.transform.position - var_202_0.position

				var_202_0.forward = Vector3.New(var_202_7.x, var_202_7.y, var_202_7.z)

				local var_202_8 = var_202_0.localEulerAngles

				var_202_8.z = 0
				var_202_8.x = 0
				var_202_0.localEulerAngles = var_202_8
			end

			local var_202_9 = arg_199_1.actors_["404001ui_story"]
			local var_202_10 = 0

			if var_202_10 < arg_199_1.time_ and arg_199_1.time_ <= var_202_10 + arg_202_0 and not isNil(var_202_9) and arg_199_1.var_.characterEffect404001ui_story == nil then
				arg_199_1.var_.characterEffect404001ui_story = var_202_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_11 = 0.200000002980232

			if var_202_10 <= arg_199_1.time_ and arg_199_1.time_ < var_202_10 + var_202_11 and not isNil(var_202_9) then
				local var_202_12 = (arg_199_1.time_ - var_202_10) / var_202_11

				if arg_199_1.var_.characterEffect404001ui_story and not isNil(var_202_9) then
					arg_199_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_199_1.time_ >= var_202_10 + var_202_11 and arg_199_1.time_ < var_202_10 + var_202_11 + arg_202_0 and not isNil(var_202_9) and arg_199_1.var_.characterEffect404001ui_story then
				arg_199_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_202_13 = arg_199_1.actors_["1284ui_story"]
			local var_202_14 = 0

			if var_202_14 < arg_199_1.time_ and arg_199_1.time_ <= var_202_14 + arg_202_0 and not isNil(var_202_13) and arg_199_1.var_.characterEffect1284ui_story == nil then
				arg_199_1.var_.characterEffect1284ui_story = var_202_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_15 = 0.200000002980232

			if var_202_14 <= arg_199_1.time_ and arg_199_1.time_ < var_202_14 + var_202_15 and not isNil(var_202_13) then
				local var_202_16 = (arg_199_1.time_ - var_202_14) / var_202_15

				if arg_199_1.var_.characterEffect1284ui_story and not isNil(var_202_13) then
					local var_202_17 = Mathf.Lerp(0, 0.5, var_202_16)

					arg_199_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_199_1.var_.characterEffect1284ui_story.fillRatio = var_202_17
				end
			end

			if arg_199_1.time_ >= var_202_14 + var_202_15 and arg_199_1.time_ < var_202_14 + var_202_15 + arg_202_0 and not isNil(var_202_13) and arg_199_1.var_.characterEffect1284ui_story then
				local var_202_18 = 0.5

				arg_199_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_199_1.var_.characterEffect1284ui_story.fillRatio = var_202_18
			end

			local var_202_19 = 0

			if var_202_19 < arg_199_1.time_ and arg_199_1.time_ <= var_202_19 + arg_202_0 then
				arg_199_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_202_20 = 0

			if var_202_20 < arg_199_1.time_ and arg_199_1.time_ <= var_202_20 + arg_202_0 then
				arg_199_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_202_21 = 0
			local var_202_22 = 0.3

			if var_202_21 < arg_199_1.time_ and arg_199_1.time_ <= var_202_21 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				local var_202_23 = arg_199_1:FormatText(StoryNameCfg[668].name)

				arg_199_1.leftNameTxt_.text = var_202_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_24 = arg_199_1:GetWordFromCfg(322062049)
				local var_202_25 = arg_199_1:FormatText(var_202_24.content)

				arg_199_1.text_.text = var_202_25

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_26 = 12
				local var_202_27 = utf8.len(var_202_25)
				local var_202_28 = var_202_26 <= 0 and var_202_22 or var_202_22 * (var_202_27 / var_202_26)

				if var_202_28 > 0 and var_202_22 < var_202_28 then
					arg_199_1.talkMaxDuration = var_202_28

					if var_202_28 + var_202_21 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_28 + var_202_21
					end
				end

				arg_199_1.text_.text = var_202_25
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062049", "story_v_out_322062.awb") ~= 0 then
					local var_202_29 = manager.audio:GetVoiceLength("story_v_out_322062", "322062049", "story_v_out_322062.awb") / 1000

					if var_202_29 + var_202_21 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_29 + var_202_21
					end

					if var_202_24.prefab_name ~= "" and arg_199_1.actors_[var_202_24.prefab_name] ~= nil then
						local var_202_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_24.prefab_name].transform, "story_v_out_322062", "322062049", "story_v_out_322062.awb")

						arg_199_1:RecordAudio("322062049", var_202_30)
						arg_199_1:RecordAudio("322062049", var_202_30)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_322062", "322062049", "story_v_out_322062.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_322062", "322062049", "story_v_out_322062.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_31 = math.max(var_202_22, arg_199_1.talkMaxDuration)

			if var_202_21 <= arg_199_1.time_ and arg_199_1.time_ < var_202_21 + var_202_31 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_21) / var_202_31

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_21 + var_202_31 and arg_199_1.time_ < var_202_21 + var_202_31 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_199_1:InitPlayNodeList()
	end,
	Play322062050 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 322062050
		arg_203_1.duration_ = 5

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play322062051(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = arg_203_1.actors_["404001ui_story"].transform
			local var_206_1 = 0

			if var_206_1 < arg_203_1.time_ and arg_203_1.time_ <= var_206_1 + arg_206_0 then
				arg_203_1.var_.moveOldPos404001ui_story = var_206_0.localPosition
			end

			local var_206_2 = 0.001

			if var_206_1 <= arg_203_1.time_ and arg_203_1.time_ < var_206_1 + var_206_2 then
				local var_206_3 = (arg_203_1.time_ - var_206_1) / var_206_2
				local var_206_4 = Vector3.New(0, 100, 0)

				var_206_0.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos404001ui_story, var_206_4, var_206_3)

				local var_206_5 = manager.ui.mainCamera.transform.position - var_206_0.position

				var_206_0.forward = Vector3.New(var_206_5.x, var_206_5.y, var_206_5.z)

				local var_206_6 = var_206_0.localEulerAngles

				var_206_6.z = 0
				var_206_6.x = 0
				var_206_0.localEulerAngles = var_206_6
			end

			if arg_203_1.time_ >= var_206_1 + var_206_2 and arg_203_1.time_ < var_206_1 + var_206_2 + arg_206_0 then
				var_206_0.localPosition = Vector3.New(0, 100, 0)

				local var_206_7 = manager.ui.mainCamera.transform.position - var_206_0.position

				var_206_0.forward = Vector3.New(var_206_7.x, var_206_7.y, var_206_7.z)

				local var_206_8 = var_206_0.localEulerAngles

				var_206_8.z = 0
				var_206_8.x = 0
				var_206_0.localEulerAngles = var_206_8
			end

			local var_206_9 = arg_203_1.actors_["1284ui_story"].transform
			local var_206_10 = 0

			if var_206_10 < arg_203_1.time_ and arg_203_1.time_ <= var_206_10 + arg_206_0 then
				arg_203_1.var_.moveOldPos1284ui_story = var_206_9.localPosition
			end

			local var_206_11 = 0.001

			if var_206_10 <= arg_203_1.time_ and arg_203_1.time_ < var_206_10 + var_206_11 then
				local var_206_12 = (arg_203_1.time_ - var_206_10) / var_206_11
				local var_206_13 = Vector3.New(0, 100, 0)

				var_206_9.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos1284ui_story, var_206_13, var_206_12)

				local var_206_14 = manager.ui.mainCamera.transform.position - var_206_9.position

				var_206_9.forward = Vector3.New(var_206_14.x, var_206_14.y, var_206_14.z)

				local var_206_15 = var_206_9.localEulerAngles

				var_206_15.z = 0
				var_206_15.x = 0
				var_206_9.localEulerAngles = var_206_15
			end

			if arg_203_1.time_ >= var_206_10 + var_206_11 and arg_203_1.time_ < var_206_10 + var_206_11 + arg_206_0 then
				var_206_9.localPosition = Vector3.New(0, 100, 0)

				local var_206_16 = manager.ui.mainCamera.transform.position - var_206_9.position

				var_206_9.forward = Vector3.New(var_206_16.x, var_206_16.y, var_206_16.z)

				local var_206_17 = var_206_9.localEulerAngles

				var_206_17.z = 0
				var_206_17.x = 0
				var_206_9.localEulerAngles = var_206_17
			end

			local var_206_18 = 0
			local var_206_19 = 0.6

			if var_206_18 < arg_203_1.time_ and arg_203_1.time_ <= var_206_18 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, false)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_20 = arg_203_1:GetWordFromCfg(322062050)
				local var_206_21 = arg_203_1:FormatText(var_206_20.content)

				arg_203_1.text_.text = var_206_21

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_22 = 24
				local var_206_23 = utf8.len(var_206_21)
				local var_206_24 = var_206_22 <= 0 and var_206_19 or var_206_19 * (var_206_23 / var_206_22)

				if var_206_24 > 0 and var_206_19 < var_206_24 then
					arg_203_1.talkMaxDuration = var_206_24

					if var_206_24 + var_206_18 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_24 + var_206_18
					end
				end

				arg_203_1.text_.text = var_206_21
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)
				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_25 = math.max(var_206_19, arg_203_1.talkMaxDuration)

			if var_206_18 <= arg_203_1.time_ and arg_203_1.time_ < var_206_18 + var_206_25 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_18) / var_206_25

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_18 + var_206_25 and arg_203_1.time_ < var_206_18 + var_206_25 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_203_1:InitPlayNodeList()
	end,
	Play322062051 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 322062051
		arg_207_1.duration_ = 5

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play322062052(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = 0
			local var_210_1 = 1

			if var_210_0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_0 + arg_210_0 then
				local var_210_2 = "play"
				local var_210_3 = "effect"

				arg_207_1:AudioAction(var_210_2, var_210_3, "se_story_145", "se_story_145_light", "")
			end

			local var_210_4 = 0
			local var_210_5 = 1.85

			if var_210_4 < arg_207_1.time_ and arg_207_1.time_ <= var_210_4 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, false)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_6 = arg_207_1:GetWordFromCfg(322062051)
				local var_210_7 = arg_207_1:FormatText(var_210_6.content)

				arg_207_1.text_.text = var_210_7

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_8 = 74
				local var_210_9 = utf8.len(var_210_7)
				local var_210_10 = var_210_8 <= 0 and var_210_5 or var_210_5 * (var_210_9 / var_210_8)

				if var_210_10 > 0 and var_210_5 < var_210_10 then
					arg_207_1.talkMaxDuration = var_210_10

					if var_210_10 + var_210_4 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_10 + var_210_4
					end
				end

				arg_207_1.text_.text = var_210_7
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)
				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_11 = math.max(var_210_5, arg_207_1.talkMaxDuration)

			if var_210_4 <= arg_207_1.time_ and arg_207_1.time_ < var_210_4 + var_210_11 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_4) / var_210_11

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_4 + var_210_11 and arg_207_1.time_ < var_210_4 + var_210_11 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play322062052 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 322062052
		arg_211_1.duration_ = 5

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play322062053(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = 0
			local var_214_1 = 1.375

			if var_214_0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_0 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, false)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_2 = arg_211_1:GetWordFromCfg(322062052)
				local var_214_3 = arg_211_1:FormatText(var_214_2.content)

				arg_211_1.text_.text = var_214_3

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_4 = 55
				local var_214_5 = utf8.len(var_214_3)
				local var_214_6 = var_214_4 <= 0 and var_214_1 or var_214_1 * (var_214_5 / var_214_4)

				if var_214_6 > 0 and var_214_1 < var_214_6 then
					arg_211_1.talkMaxDuration = var_214_6

					if var_214_6 + var_214_0 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_6 + var_214_0
					end
				end

				arg_211_1.text_.text = var_214_3
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)
				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_7 = math.max(var_214_1, arg_211_1.talkMaxDuration)

			if var_214_0 <= arg_211_1.time_ and arg_211_1.time_ < var_214_0 + var_214_7 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_0) / var_214_7

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_0 + var_214_7 and arg_211_1.time_ < var_214_0 + var_214_7 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play322062053 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 322062053
		arg_215_1.duration_ = 3.73

		local var_215_0 = {
			zh = 3.733,
			ja = 2.666
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
				arg_215_0:Play322062054(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = 0
			local var_218_1 = 0.35

			if var_218_0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_0 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				local var_218_2 = arg_215_1:FormatText(StoryNameCfg[6].name)

				arg_215_1.leftNameTxt_.text = var_218_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, true)
				arg_215_1.iconController_:SetSelectedState("hero")

				arg_215_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1284")

				arg_215_1.callingController_:SetSelectedState("normal")

				arg_215_1.keyicon_.color = Color.New(1, 1, 1)
				arg_215_1.icon_.color = Color.New(1, 1, 1)

				local var_218_3 = arg_215_1:GetWordFromCfg(322062053)
				local var_218_4 = arg_215_1:FormatText(var_218_3.content)

				arg_215_1.text_.text = var_218_4

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_5 = 14
				local var_218_6 = utf8.len(var_218_4)
				local var_218_7 = var_218_5 <= 0 and var_218_1 or var_218_1 * (var_218_6 / var_218_5)

				if var_218_7 > 0 and var_218_1 < var_218_7 then
					arg_215_1.talkMaxDuration = var_218_7

					if var_218_7 + var_218_0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_7 + var_218_0
					end
				end

				arg_215_1.text_.text = var_218_4
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062053", "story_v_out_322062.awb") ~= 0 then
					local var_218_8 = manager.audio:GetVoiceLength("story_v_out_322062", "322062053", "story_v_out_322062.awb") / 1000

					if var_218_8 + var_218_0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_8 + var_218_0
					end

					if var_218_3.prefab_name ~= "" and arg_215_1.actors_[var_218_3.prefab_name] ~= nil then
						local var_218_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_3.prefab_name].transform, "story_v_out_322062", "322062053", "story_v_out_322062.awb")

						arg_215_1:RecordAudio("322062053", var_218_9)
						arg_215_1:RecordAudio("322062053", var_218_9)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_322062", "322062053", "story_v_out_322062.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_322062", "322062053", "story_v_out_322062.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_10 = math.max(var_218_1, arg_215_1.talkMaxDuration)

			if var_218_0 <= arg_215_1.time_ and arg_215_1.time_ < var_218_0 + var_218_10 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_0) / var_218_10

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_0 + var_218_10 and arg_215_1.time_ < var_218_0 + var_218_10 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play322062054 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 322062054
		arg_219_1.duration_ = 2

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play322062055(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = arg_219_1.actors_["404001ui_story"].transform
			local var_222_1 = 0

			if var_222_1 < arg_219_1.time_ and arg_219_1.time_ <= var_222_1 + arg_222_0 then
				arg_219_1.var_.moveOldPos404001ui_story = var_222_0.localPosition
			end

			local var_222_2 = 0.001

			if var_222_1 <= arg_219_1.time_ and arg_219_1.time_ < var_222_1 + var_222_2 then
				local var_222_3 = (arg_219_1.time_ - var_222_1) / var_222_2
				local var_222_4 = Vector3.New(0, -1.55, -5.5)

				var_222_0.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos404001ui_story, var_222_4, var_222_3)

				local var_222_5 = manager.ui.mainCamera.transform.position - var_222_0.position

				var_222_0.forward = Vector3.New(var_222_5.x, var_222_5.y, var_222_5.z)

				local var_222_6 = var_222_0.localEulerAngles

				var_222_6.z = 0
				var_222_6.x = 0
				var_222_0.localEulerAngles = var_222_6
			end

			if arg_219_1.time_ >= var_222_1 + var_222_2 and arg_219_1.time_ < var_222_1 + var_222_2 + arg_222_0 then
				var_222_0.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_222_7 = manager.ui.mainCamera.transform.position - var_222_0.position

				var_222_0.forward = Vector3.New(var_222_7.x, var_222_7.y, var_222_7.z)

				local var_222_8 = var_222_0.localEulerAngles

				var_222_8.z = 0
				var_222_8.x = 0
				var_222_0.localEulerAngles = var_222_8
			end

			local var_222_9 = arg_219_1.actors_["404001ui_story"]
			local var_222_10 = 0

			if var_222_10 < arg_219_1.time_ and arg_219_1.time_ <= var_222_10 + arg_222_0 and not isNil(var_222_9) and arg_219_1.var_.characterEffect404001ui_story == nil then
				arg_219_1.var_.characterEffect404001ui_story = var_222_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_11 = 0.200000002980232

			if var_222_10 <= arg_219_1.time_ and arg_219_1.time_ < var_222_10 + var_222_11 and not isNil(var_222_9) then
				local var_222_12 = (arg_219_1.time_ - var_222_10) / var_222_11

				if arg_219_1.var_.characterEffect404001ui_story and not isNil(var_222_9) then
					arg_219_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_219_1.time_ >= var_222_10 + var_222_11 and arg_219_1.time_ < var_222_10 + var_222_11 + arg_222_0 and not isNil(var_222_9) and arg_219_1.var_.characterEffect404001ui_story then
				arg_219_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_222_13 = arg_219_1.actors_["1284ui_story"]
			local var_222_14 = 0

			if var_222_14 < arg_219_1.time_ and arg_219_1.time_ <= var_222_14 + arg_222_0 and not isNil(var_222_13) and arg_219_1.var_.characterEffect1284ui_story == nil then
				arg_219_1.var_.characterEffect1284ui_story = var_222_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_15 = 0.200000002980232

			if var_222_14 <= arg_219_1.time_ and arg_219_1.time_ < var_222_14 + var_222_15 and not isNil(var_222_13) then
				local var_222_16 = (arg_219_1.time_ - var_222_14) / var_222_15

				if arg_219_1.var_.characterEffect1284ui_story and not isNil(var_222_13) then
					local var_222_17 = Mathf.Lerp(0, 0.5, var_222_16)

					arg_219_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_219_1.var_.characterEffect1284ui_story.fillRatio = var_222_17
				end
			end

			if arg_219_1.time_ >= var_222_14 + var_222_15 and arg_219_1.time_ < var_222_14 + var_222_15 + arg_222_0 and not isNil(var_222_13) and arg_219_1.var_.characterEffect1284ui_story then
				local var_222_18 = 0.5

				arg_219_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_219_1.var_.characterEffect1284ui_story.fillRatio = var_222_18
			end

			local var_222_19 = 0

			if var_222_19 < arg_219_1.time_ and arg_219_1.time_ <= var_222_19 + arg_222_0 then
				arg_219_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_222_20 = 0

			if var_222_20 < arg_219_1.time_ and arg_219_1.time_ <= var_222_20 + arg_222_0 then
				arg_219_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_222_21 = 0
			local var_222_22 = 0.15

			if var_222_21 < arg_219_1.time_ and arg_219_1.time_ <= var_222_21 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				local var_222_23 = arg_219_1:FormatText(StoryNameCfg[668].name)

				arg_219_1.leftNameTxt_.text = var_222_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_24 = arg_219_1:GetWordFromCfg(322062054)
				local var_222_25 = arg_219_1:FormatText(var_222_24.content)

				arg_219_1.text_.text = var_222_25

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_26 = 6
				local var_222_27 = utf8.len(var_222_25)
				local var_222_28 = var_222_26 <= 0 and var_222_22 or var_222_22 * (var_222_27 / var_222_26)

				if var_222_28 > 0 and var_222_22 < var_222_28 then
					arg_219_1.talkMaxDuration = var_222_28

					if var_222_28 + var_222_21 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_28 + var_222_21
					end
				end

				arg_219_1.text_.text = var_222_25
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062054", "story_v_out_322062.awb") ~= 0 then
					local var_222_29 = manager.audio:GetVoiceLength("story_v_out_322062", "322062054", "story_v_out_322062.awb") / 1000

					if var_222_29 + var_222_21 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_29 + var_222_21
					end

					if var_222_24.prefab_name ~= "" and arg_219_1.actors_[var_222_24.prefab_name] ~= nil then
						local var_222_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_24.prefab_name].transform, "story_v_out_322062", "322062054", "story_v_out_322062.awb")

						arg_219_1:RecordAudio("322062054", var_222_30)
						arg_219_1:RecordAudio("322062054", var_222_30)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_322062", "322062054", "story_v_out_322062.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_322062", "322062054", "story_v_out_322062.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_31 = math.max(var_222_22, arg_219_1.talkMaxDuration)

			if var_222_21 <= arg_219_1.time_ and arg_219_1.time_ < var_222_21 + var_222_31 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_21) / var_222_31

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_21 + var_222_31 and arg_219_1.time_ < var_222_21 + var_222_31 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_219_1:InitPlayNodeList()
	end,
	Play322062055 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 322062055
		arg_223_1.duration_ = 5.07

		local var_223_0 = {
			zh = 5.066,
			ja = 4
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
				arg_223_0:Play322062056(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = arg_223_1.actors_["404001ui_story"]
			local var_226_1 = 0

			if var_226_1 < arg_223_1.time_ and arg_223_1.time_ <= var_226_1 + arg_226_0 and not isNil(var_226_0) and arg_223_1.var_.characterEffect404001ui_story == nil then
				arg_223_1.var_.characterEffect404001ui_story = var_226_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_2 = 0.200000002980232

			if var_226_1 <= arg_223_1.time_ and arg_223_1.time_ < var_226_1 + var_226_2 and not isNil(var_226_0) then
				local var_226_3 = (arg_223_1.time_ - var_226_1) / var_226_2

				if arg_223_1.var_.characterEffect404001ui_story and not isNil(var_226_0) then
					local var_226_4 = Mathf.Lerp(0, 0.5, var_226_3)

					arg_223_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_223_1.var_.characterEffect404001ui_story.fillRatio = var_226_4
				end
			end

			if arg_223_1.time_ >= var_226_1 + var_226_2 and arg_223_1.time_ < var_226_1 + var_226_2 + arg_226_0 and not isNil(var_226_0) and arg_223_1.var_.characterEffect404001ui_story then
				local var_226_5 = 0.5

				arg_223_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_223_1.var_.characterEffect404001ui_story.fillRatio = var_226_5
			end

			local var_226_6 = 0
			local var_226_7 = 0.375

			if var_226_6 < arg_223_1.time_ and arg_223_1.time_ <= var_226_6 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				local var_226_8 = arg_223_1:FormatText(StoryNameCfg[6].name)

				arg_223_1.leftNameTxt_.text = var_226_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, true)
				arg_223_1.iconController_:SetSelectedState("hero")

				arg_223_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1284")

				arg_223_1.callingController_:SetSelectedState("normal")

				arg_223_1.keyicon_.color = Color.New(1, 1, 1)
				arg_223_1.icon_.color = Color.New(1, 1, 1)

				local var_226_9 = arg_223_1:GetWordFromCfg(322062055)
				local var_226_10 = arg_223_1:FormatText(var_226_9.content)

				arg_223_1.text_.text = var_226_10

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_11 = 15
				local var_226_12 = utf8.len(var_226_10)
				local var_226_13 = var_226_11 <= 0 and var_226_7 or var_226_7 * (var_226_12 / var_226_11)

				if var_226_13 > 0 and var_226_7 < var_226_13 then
					arg_223_1.talkMaxDuration = var_226_13

					if var_226_13 + var_226_6 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_13 + var_226_6
					end
				end

				arg_223_1.text_.text = var_226_10
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062055", "story_v_out_322062.awb") ~= 0 then
					local var_226_14 = manager.audio:GetVoiceLength("story_v_out_322062", "322062055", "story_v_out_322062.awb") / 1000

					if var_226_14 + var_226_6 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_14 + var_226_6
					end

					if var_226_9.prefab_name ~= "" and arg_223_1.actors_[var_226_9.prefab_name] ~= nil then
						local var_226_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_9.prefab_name].transform, "story_v_out_322062", "322062055", "story_v_out_322062.awb")

						arg_223_1:RecordAudio("322062055", var_226_15)
						arg_223_1:RecordAudio("322062055", var_226_15)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_322062", "322062055", "story_v_out_322062.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_322062", "322062055", "story_v_out_322062.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_16 = math.max(var_226_7, arg_223_1.talkMaxDuration)

			if var_226_6 <= arg_223_1.time_ and arg_223_1.time_ < var_226_6 + var_226_16 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_6) / var_226_16

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_6 + var_226_16 and arg_223_1.time_ < var_226_6 + var_226_16 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play322062056 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 322062056
		arg_227_1.duration_ = 5

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play322062057(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = arg_227_1.actors_["404001ui_story"].transform
			local var_230_1 = 0

			if var_230_1 < arg_227_1.time_ and arg_227_1.time_ <= var_230_1 + arg_230_0 then
				arg_227_1.var_.moveOldPos404001ui_story = var_230_0.localPosition
			end

			local var_230_2 = 0.001

			if var_230_1 <= arg_227_1.time_ and arg_227_1.time_ < var_230_1 + var_230_2 then
				local var_230_3 = (arg_227_1.time_ - var_230_1) / var_230_2
				local var_230_4 = Vector3.New(0, 100, 0)

				var_230_0.localPosition = Vector3.Lerp(arg_227_1.var_.moveOldPos404001ui_story, var_230_4, var_230_3)

				local var_230_5 = manager.ui.mainCamera.transform.position - var_230_0.position

				var_230_0.forward = Vector3.New(var_230_5.x, var_230_5.y, var_230_5.z)

				local var_230_6 = var_230_0.localEulerAngles

				var_230_6.z = 0
				var_230_6.x = 0
				var_230_0.localEulerAngles = var_230_6
			end

			if arg_227_1.time_ >= var_230_1 + var_230_2 and arg_227_1.time_ < var_230_1 + var_230_2 + arg_230_0 then
				var_230_0.localPosition = Vector3.New(0, 100, 0)

				local var_230_7 = manager.ui.mainCamera.transform.position - var_230_0.position

				var_230_0.forward = Vector3.New(var_230_7.x, var_230_7.y, var_230_7.z)

				local var_230_8 = var_230_0.localEulerAngles

				var_230_8.z = 0
				var_230_8.x = 0
				var_230_0.localEulerAngles = var_230_8
			end

			local var_230_9 = 0
			local var_230_10 = 1.425

			if var_230_9 < arg_227_1.time_ and arg_227_1.time_ <= var_230_9 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, false)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_11 = arg_227_1:GetWordFromCfg(322062056)
				local var_230_12 = arg_227_1:FormatText(var_230_11.content)

				arg_227_1.text_.text = var_230_12

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_13 = 57
				local var_230_14 = utf8.len(var_230_12)
				local var_230_15 = var_230_13 <= 0 and var_230_10 or var_230_10 * (var_230_14 / var_230_13)

				if var_230_15 > 0 and var_230_10 < var_230_15 then
					arg_227_1.talkMaxDuration = var_230_15

					if var_230_15 + var_230_9 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_15 + var_230_9
					end
				end

				arg_227_1.text_.text = var_230_12
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)
				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_16 = math.max(var_230_10, arg_227_1.talkMaxDuration)

			if var_230_9 <= arg_227_1.time_ and arg_227_1.time_ < var_230_9 + var_230_16 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_9) / var_230_16

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_9 + var_230_16 and arg_227_1.time_ < var_230_9 + var_230_16 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
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
	Play322062057 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 322062057
		arg_231_1.duration_ = 5.83

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play322062058(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = 0
			local var_234_1 = 1

			if var_234_0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_0 + arg_234_0 then
				local var_234_2 = "play"
				local var_234_3 = "effect"

				arg_231_1:AudioAction(var_234_2, var_234_3, "se_story_6", "se_story_6_giant_sword", "")
			end

			local var_234_4 = manager.ui.mainCamera.transform
			local var_234_5 = 0

			if var_234_5 < arg_231_1.time_ and arg_231_1.time_ <= var_234_5 + arg_234_0 then
				local var_234_6 = arg_231_1.var_.effect2056
				local var_234_7
				local var_234_8 = var_234_4

				if not var_234_6 then
					var_234_6 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_daoguang01"), var_234_8)
					var_234_6.name = "2056"
					arg_231_1.var_.effect2056 = var_234_6
				else
					var_234_6.transform:SetParent(var_234_8)
				end

				var_234_6.transform.localPosition = Vector3.New(0, 0, 0)
				var_234_6.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_234_9 = manager.ui.mainCamera.transform
			local var_234_10 = 0

			if var_234_10 < arg_231_1.time_ and arg_231_1.time_ <= var_234_10 + arg_234_0 then
				arg_231_1.var_.shakeOldPos = var_234_9.localPosition
			end

			local var_234_11 = 0.4

			if var_234_10 <= arg_231_1.time_ and arg_231_1.time_ < var_234_10 + var_234_11 then
				local var_234_12 = (arg_231_1.time_ - var_234_10) / 0.066
				local var_234_13, var_234_14 = math.modf(var_234_12)

				var_234_9.localPosition = Vector3.New(var_234_14 * 0.13, var_234_14 * 0.13, var_234_14 * 0.13) + arg_231_1.var_.shakeOldPos
			end

			if arg_231_1.time_ >= var_234_10 + var_234_11 and arg_231_1.time_ < var_234_10 + var_234_11 + arg_234_0 then
				var_234_9.localPosition = arg_231_1.var_.shakeOldPos
			end

			if arg_231_1.frameCnt_ <= 1 then
				arg_231_1.dialog_:SetActive(false)
			end

			local var_234_15 = 0.833333333333333
			local var_234_16 = 1.4

			if var_234_15 < arg_231_1.time_ and arg_231_1.time_ <= var_234_15 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0

				arg_231_1.dialog_:SetActive(true)

				arg_231_1.dialogCg_.alpha = 0

				local var_234_17 = LeanTween.value(arg_231_1.dialog_, 0, 1, 0.3)

				var_234_17:setOnUpdate(LuaHelper.FloatAction(function(arg_235_0)
					arg_231_1.dialogCg_.alpha = arg_235_0
				end))
				var_234_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_231_1.dialog_)
					var_234_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_231_1.duration_ = arg_231_1.duration_ + 0.3

				SetActive(arg_231_1.leftNameGo_, false)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_18 = arg_231_1:GetWordFromCfg(322062057)
				local var_234_19 = arg_231_1:FormatText(var_234_18.content)

				arg_231_1.text_.text = var_234_19

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_20 = 56
				local var_234_21 = utf8.len(var_234_19)
				local var_234_22 = var_234_20 <= 0 and var_234_16 or var_234_16 * (var_234_21 / var_234_20)

				if var_234_22 > 0 and var_234_16 < var_234_22 then
					arg_231_1.talkMaxDuration = var_234_22
					var_234_15 = var_234_15 + 0.3

					if var_234_22 + var_234_15 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_22 + var_234_15
					end
				end

				arg_231_1.text_.text = var_234_19
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)
				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_23 = var_234_15 + 0.3
			local var_234_24 = math.max(var_234_16, arg_231_1.talkMaxDuration)

			if var_234_23 <= arg_231_1.time_ and arg_231_1.time_ < var_234_23 + var_234_24 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_23) / var_234_24

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_23 + var_234_24 and arg_231_1.time_ < var_234_23 + var_234_24 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play322062058 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 322062058
		arg_237_1.duration_ = 5

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play322062059(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = 0.397879499010742
			local var_240_1 = 1

			if var_240_0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_0 + arg_240_0 then
				local var_240_2 = "play"
				local var_240_3 = "effect"

				arg_237_1:AudioAction(var_240_2, var_240_3, "se_story_1311", "se_story_1311_sword02", "")
			end

			local var_240_4 = manager.ui.mainCamera.transform
			local var_240_5 = 0.397879499010742

			if var_240_5 < arg_237_1.time_ and arg_237_1.time_ <= var_240_5 + arg_240_0 then
				local var_240_6 = arg_237_1.var_.effect2058
				local var_240_7
				local var_240_8 = var_240_4

				if not var_240_6 then
					var_240_6 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_daoguang02"), var_240_8)
					var_240_6.name = "2058"
					arg_237_1.var_.effect2058 = var_240_6
				else
					var_240_6.transform:SetParent(var_240_8)
				end

				var_240_6.transform.localPosition = Vector3.New(0, 0, 0)
				var_240_6.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_240_9 = manager.ui.mainCamera.transform
			local var_240_10 = 2.33333333333333

			if var_240_10 < arg_237_1.time_ and arg_237_1.time_ <= var_240_10 + arg_240_0 then
				local var_240_11 = arg_237_1.var_.effect2058

				if var_240_11 then
					Object.Destroy(var_240_11)

					arg_237_1.var_.effect2058 = nil
				end
			end

			local var_240_12 = manager.ui.mainCamera.transform
			local var_240_13 = 0.397879499010742

			if var_240_13 < arg_237_1.time_ and arg_237_1.time_ <= var_240_13 + arg_240_0 then
				arg_237_1.var_.shakeOldPos = var_240_12.localPosition
			end

			local var_240_14 = 0.735453834322592

			if var_240_13 <= arg_237_1.time_ and arg_237_1.time_ < var_240_13 + var_240_14 then
				local var_240_15 = (arg_237_1.time_ - var_240_13) / 0.066
				local var_240_16, var_240_17 = math.modf(var_240_15)

				var_240_12.localPosition = Vector3.New(var_240_17 * 0.13, var_240_17 * 0.13, var_240_17 * 0.13) + arg_237_1.var_.shakeOldPos
			end

			if arg_237_1.time_ >= var_240_13 + var_240_14 and arg_237_1.time_ < var_240_13 + var_240_14 + arg_240_0 then
				var_240_12.localPosition = arg_237_1.var_.shakeOldPos
			end

			local var_240_18 = 0
			local var_240_19 = 1.775

			if var_240_18 < arg_237_1.time_ and arg_237_1.time_ <= var_240_18 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, false)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_20 = arg_237_1:GetWordFromCfg(322062058)
				local var_240_21 = arg_237_1:FormatText(var_240_20.content)

				arg_237_1.text_.text = var_240_21

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_22 = 71
				local var_240_23 = utf8.len(var_240_21)
				local var_240_24 = var_240_22 <= 0 and var_240_19 or var_240_19 * (var_240_23 / var_240_22)

				if var_240_24 > 0 and var_240_19 < var_240_24 then
					arg_237_1.talkMaxDuration = var_240_24

					if var_240_24 + var_240_18 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_24 + var_240_18
					end
				end

				arg_237_1.text_.text = var_240_21
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)
				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_25 = math.max(var_240_19, arg_237_1.talkMaxDuration)

			if var_240_18 <= arg_237_1.time_ and arg_237_1.time_ < var_240_18 + var_240_25 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_18) / var_240_25

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_18 + var_240_25 and arg_237_1.time_ < var_240_18 + var_240_25 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play322062059 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 322062059
		arg_241_1.duration_ = 5

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play322062060(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = 0
			local var_244_1 = 1.2

			if var_244_0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_0 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, false)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_2 = arg_241_1:GetWordFromCfg(322062059)
				local var_244_3 = arg_241_1:FormatText(var_244_2.content)

				arg_241_1.text_.text = var_244_3

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_4 = 48
				local var_244_5 = utf8.len(var_244_3)
				local var_244_6 = var_244_4 <= 0 and var_244_1 or var_244_1 * (var_244_5 / var_244_4)

				if var_244_6 > 0 and var_244_1 < var_244_6 then
					arg_241_1.talkMaxDuration = var_244_6

					if var_244_6 + var_244_0 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_6 + var_244_0
					end
				end

				arg_241_1.text_.text = var_244_3
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)
				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_7 = math.max(var_244_1, arg_241_1.talkMaxDuration)

			if var_244_0 <= arg_241_1.time_ and arg_241_1.time_ < var_244_0 + var_244_7 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_0) / var_244_7

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_0 + var_244_7 and arg_241_1.time_ < var_244_0 + var_244_7 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play322062060 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 322062060
		arg_245_1.duration_ = 5

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play322062061(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = 0.575
			local var_248_1 = 1

			if var_248_0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_0 + arg_248_0 then
				local var_248_2 = "play"
				local var_248_3 = "effect"

				arg_245_1:AudioAction(var_248_2, var_248_3, "se_story_141", "se_story_141_snake04", "")
			end

			local var_248_4 = manager.ui.mainCamera.transform
			local var_248_5 = 0.575

			if var_248_5 < arg_245_1.time_ and arg_245_1.time_ <= var_248_5 + arg_248_0 then
				local var_248_6 = arg_245_1.var_.effect2060
				local var_248_7
				local var_248_8 = var_248_4

				if not var_248_6 then
					var_248_6 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_blood_in"), var_248_8)
					var_248_6.name = "2060"
					arg_245_1.var_.effect2060 = var_248_6
				else
					var_248_6.transform:SetParent(var_248_8)
				end

				var_248_6.transform.localPosition = Vector3.New(0, 0, 0)
				var_248_6.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_248_9 = manager.ui.mainCamera.transform
			local var_248_10 = 2.66666666666667

			if var_248_10 < arg_245_1.time_ and arg_245_1.time_ <= var_248_10 + arg_248_0 then
				local var_248_11 = arg_245_1.var_.effect2060

				if var_248_11 then
					Object.Destroy(var_248_11)

					arg_245_1.var_.effect2060 = nil
				end
			end

			local var_248_12 = manager.ui.mainCamera.transform
			local var_248_13 = 0.575

			if var_248_13 < arg_245_1.time_ and arg_245_1.time_ <= var_248_13 + arg_248_0 then
				arg_245_1.var_.shakeOldPos = var_248_12.localPosition
			end

			local var_248_14 = 0.158333333333333

			if var_248_13 <= arg_245_1.time_ and arg_245_1.time_ < var_248_13 + var_248_14 then
				local var_248_15 = (arg_245_1.time_ - var_248_13) / 0.066
				local var_248_16, var_248_17 = math.modf(var_248_15)

				var_248_12.localPosition = Vector3.New(var_248_17 * 0.13, var_248_17 * 0.13, var_248_17 * 0.13) + arg_245_1.var_.shakeOldPos
			end

			if arg_245_1.time_ >= var_248_13 + var_248_14 and arg_245_1.time_ < var_248_13 + var_248_14 + arg_248_0 then
				var_248_12.localPosition = arg_245_1.var_.shakeOldPos
			end

			local var_248_18 = 0
			local var_248_19 = 1.575

			if var_248_18 < arg_245_1.time_ and arg_245_1.time_ <= var_248_18 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, false)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_20 = arg_245_1:GetWordFromCfg(322062060)
				local var_248_21 = arg_245_1:FormatText(var_248_20.content)

				arg_245_1.text_.text = var_248_21

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_22 = 63
				local var_248_23 = utf8.len(var_248_21)
				local var_248_24 = var_248_22 <= 0 and var_248_19 or var_248_19 * (var_248_23 / var_248_22)

				if var_248_24 > 0 and var_248_19 < var_248_24 then
					arg_245_1.talkMaxDuration = var_248_24

					if var_248_24 + var_248_18 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_24 + var_248_18
					end
				end

				arg_245_1.text_.text = var_248_21
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)
				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_25 = math.max(var_248_19, arg_245_1.talkMaxDuration)

			if var_248_18 <= arg_245_1.time_ and arg_245_1.time_ < var_248_18 + var_248_25 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_18) / var_248_25

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_18 + var_248_25 and arg_245_1.time_ < var_248_18 + var_248_25 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play322062061 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 322062061
		arg_249_1.duration_ = 3.5

		local var_249_0 = {
			zh = 3.1,
			ja = 3.5
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
				arg_249_0:Play322062062(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = arg_249_1.actors_["404001ui_story"].transform
			local var_252_1 = 0

			if var_252_1 < arg_249_1.time_ and arg_249_1.time_ <= var_252_1 + arg_252_0 then
				arg_249_1.var_.moveOldPos404001ui_story = var_252_0.localPosition
			end

			local var_252_2 = 0.001

			if var_252_1 <= arg_249_1.time_ and arg_249_1.time_ < var_252_1 + var_252_2 then
				local var_252_3 = (arg_249_1.time_ - var_252_1) / var_252_2
				local var_252_4 = Vector3.New(-0.8, -1.55, -5.5)

				var_252_0.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos404001ui_story, var_252_4, var_252_3)

				local var_252_5 = manager.ui.mainCamera.transform.position - var_252_0.position

				var_252_0.forward = Vector3.New(var_252_5.x, var_252_5.y, var_252_5.z)

				local var_252_6 = var_252_0.localEulerAngles

				var_252_6.z = 0
				var_252_6.x = 0
				var_252_0.localEulerAngles = var_252_6
			end

			if arg_249_1.time_ >= var_252_1 + var_252_2 and arg_249_1.time_ < var_252_1 + var_252_2 + arg_252_0 then
				var_252_0.localPosition = Vector3.New(-0.8, -1.55, -5.5)

				local var_252_7 = manager.ui.mainCamera.transform.position - var_252_0.position

				var_252_0.forward = Vector3.New(var_252_7.x, var_252_7.y, var_252_7.z)

				local var_252_8 = var_252_0.localEulerAngles

				var_252_8.z = 0
				var_252_8.x = 0
				var_252_0.localEulerAngles = var_252_8
			end

			local var_252_9 = arg_249_1.actors_["404001ui_story"]
			local var_252_10 = 0

			if var_252_10 < arg_249_1.time_ and arg_249_1.time_ <= var_252_10 + arg_252_0 and not isNil(var_252_9) and arg_249_1.var_.characterEffect404001ui_story == nil then
				arg_249_1.var_.characterEffect404001ui_story = var_252_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_11 = 0.200000002980232

			if var_252_10 <= arg_249_1.time_ and arg_249_1.time_ < var_252_10 + var_252_11 and not isNil(var_252_9) then
				local var_252_12 = (arg_249_1.time_ - var_252_10) / var_252_11

				if arg_249_1.var_.characterEffect404001ui_story and not isNil(var_252_9) then
					arg_249_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_249_1.time_ >= var_252_10 + var_252_11 and arg_249_1.time_ < var_252_10 + var_252_11 + arg_252_0 and not isNil(var_252_9) and arg_249_1.var_.characterEffect404001ui_story then
				arg_249_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_252_13 = 0

			if var_252_13 < arg_249_1.time_ and arg_249_1.time_ <= var_252_13 + arg_252_0 then
				arg_249_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_252_14 = 0

			if var_252_14 < arg_249_1.time_ and arg_249_1.time_ <= var_252_14 + arg_252_0 then
				arg_249_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_252_15 = manager.ui.mainCamera.transform
			local var_252_16 = 0

			if var_252_16 < arg_249_1.time_ and arg_249_1.time_ <= var_252_16 + arg_252_0 then
				local var_252_17 = arg_249_1.var_.effect2060

				if var_252_17 then
					Object.Destroy(var_252_17)

					arg_249_1.var_.effect2060 = nil
				end
			end

			local var_252_18 = 0
			local var_252_19 = 0.325

			if var_252_18 < arg_249_1.time_ and arg_249_1.time_ <= var_252_18 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				local var_252_20 = arg_249_1:FormatText(StoryNameCfg[668].name)

				arg_249_1.leftNameTxt_.text = var_252_20

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_21 = arg_249_1:GetWordFromCfg(322062061)
				local var_252_22 = arg_249_1:FormatText(var_252_21.content)

				arg_249_1.text_.text = var_252_22

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_23 = 13
				local var_252_24 = utf8.len(var_252_22)
				local var_252_25 = var_252_23 <= 0 and var_252_19 or var_252_19 * (var_252_24 / var_252_23)

				if var_252_25 > 0 and var_252_19 < var_252_25 then
					arg_249_1.talkMaxDuration = var_252_25

					if var_252_25 + var_252_18 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_25 + var_252_18
					end
				end

				arg_249_1.text_.text = var_252_22
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062061", "story_v_out_322062.awb") ~= 0 then
					local var_252_26 = manager.audio:GetVoiceLength("story_v_out_322062", "322062061", "story_v_out_322062.awb") / 1000

					if var_252_26 + var_252_18 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_26 + var_252_18
					end

					if var_252_21.prefab_name ~= "" and arg_249_1.actors_[var_252_21.prefab_name] ~= nil then
						local var_252_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_21.prefab_name].transform, "story_v_out_322062", "322062061", "story_v_out_322062.awb")

						arg_249_1:RecordAudio("322062061", var_252_27)
						arg_249_1:RecordAudio("322062061", var_252_27)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_322062", "322062061", "story_v_out_322062.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_322062", "322062061", "story_v_out_322062.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_28 = math.max(var_252_19, arg_249_1.talkMaxDuration)

			if var_252_18 <= arg_249_1.time_ and arg_249_1.time_ < var_252_18 + var_252_28 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_18) / var_252_28

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_18 + var_252_28 and arg_249_1.time_ < var_252_18 + var_252_28 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_249_1:InitPlayNodeList()
	end,
	Play322062062 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 322062062
		arg_253_1.duration_ = 7.1

		local var_253_0 = {
			zh = 3.7,
			ja = 7.1
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
				arg_253_0:Play322062063(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = arg_253_1.actors_["10104ui_story"].transform
			local var_256_1 = 0

			if var_256_1 < arg_253_1.time_ and arg_253_1.time_ <= var_256_1 + arg_256_0 then
				arg_253_1.var_.moveOldPos10104ui_story = var_256_0.localPosition
			end

			local var_256_2 = 0.001

			if var_256_1 <= arg_253_1.time_ and arg_253_1.time_ < var_256_1 + var_256_2 then
				local var_256_3 = (arg_253_1.time_ - var_256_1) / var_256_2
				local var_256_4 = Vector3.New(0.99, -1.12, -5.99)

				var_256_0.localPosition = Vector3.Lerp(arg_253_1.var_.moveOldPos10104ui_story, var_256_4, var_256_3)

				local var_256_5 = manager.ui.mainCamera.transform.position - var_256_0.position

				var_256_0.forward = Vector3.New(var_256_5.x, var_256_5.y, var_256_5.z)

				local var_256_6 = var_256_0.localEulerAngles

				var_256_6.z = 0
				var_256_6.x = 0
				var_256_0.localEulerAngles = var_256_6
			end

			if arg_253_1.time_ >= var_256_1 + var_256_2 and arg_253_1.time_ < var_256_1 + var_256_2 + arg_256_0 then
				var_256_0.localPosition = Vector3.New(0.99, -1.12, -5.99)

				local var_256_7 = manager.ui.mainCamera.transform.position - var_256_0.position

				var_256_0.forward = Vector3.New(var_256_7.x, var_256_7.y, var_256_7.z)

				local var_256_8 = var_256_0.localEulerAngles

				var_256_8.z = 0
				var_256_8.x = 0
				var_256_0.localEulerAngles = var_256_8
			end

			local var_256_9 = arg_253_1.actors_["10104ui_story"]
			local var_256_10 = 0

			if var_256_10 < arg_253_1.time_ and arg_253_1.time_ <= var_256_10 + arg_256_0 and not isNil(var_256_9) and arg_253_1.var_.characterEffect10104ui_story == nil then
				arg_253_1.var_.characterEffect10104ui_story = var_256_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_11 = 0.200000002980232

			if var_256_10 <= arg_253_1.time_ and arg_253_1.time_ < var_256_10 + var_256_11 and not isNil(var_256_9) then
				local var_256_12 = (arg_253_1.time_ - var_256_10) / var_256_11

				if arg_253_1.var_.characterEffect10104ui_story and not isNil(var_256_9) then
					arg_253_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_253_1.time_ >= var_256_10 + var_256_11 and arg_253_1.time_ < var_256_10 + var_256_11 + arg_256_0 and not isNil(var_256_9) and arg_253_1.var_.characterEffect10104ui_story then
				arg_253_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_256_13 = arg_253_1.actors_["404001ui_story"]
			local var_256_14 = 0

			if var_256_14 < arg_253_1.time_ and arg_253_1.time_ <= var_256_14 + arg_256_0 and not isNil(var_256_13) and arg_253_1.var_.characterEffect404001ui_story == nil then
				arg_253_1.var_.characterEffect404001ui_story = var_256_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_15 = 0.200000002980232

			if var_256_14 <= arg_253_1.time_ and arg_253_1.time_ < var_256_14 + var_256_15 and not isNil(var_256_13) then
				local var_256_16 = (arg_253_1.time_ - var_256_14) / var_256_15

				if arg_253_1.var_.characterEffect404001ui_story and not isNil(var_256_13) then
					local var_256_17 = Mathf.Lerp(0, 0.5, var_256_16)

					arg_253_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_253_1.var_.characterEffect404001ui_story.fillRatio = var_256_17
				end
			end

			if arg_253_1.time_ >= var_256_14 + var_256_15 and arg_253_1.time_ < var_256_14 + var_256_15 + arg_256_0 and not isNil(var_256_13) and arg_253_1.var_.characterEffect404001ui_story then
				local var_256_18 = 0.5

				arg_253_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_253_1.var_.characterEffect404001ui_story.fillRatio = var_256_18
			end

			local var_256_19 = 0

			if var_256_19 < arg_253_1.time_ and arg_253_1.time_ <= var_256_19 + arg_256_0 then
				arg_253_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action4_1")
			end

			local var_256_20 = 0

			if var_256_20 < arg_253_1.time_ and arg_253_1.time_ <= var_256_20 + arg_256_0 then
				arg_253_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_256_21 = 0
			local var_256_22 = 0.475

			if var_256_21 < arg_253_1.time_ and arg_253_1.time_ <= var_256_21 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				local var_256_23 = arg_253_1:FormatText(StoryNameCfg[1030].name)

				arg_253_1.leftNameTxt_.text = var_256_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_24 = arg_253_1:GetWordFromCfg(322062062)
				local var_256_25 = arg_253_1:FormatText(var_256_24.content)

				arg_253_1.text_.text = var_256_25

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_26 = 19
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

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062062", "story_v_out_322062.awb") ~= 0 then
					local var_256_29 = manager.audio:GetVoiceLength("story_v_out_322062", "322062062", "story_v_out_322062.awb") / 1000

					if var_256_29 + var_256_21 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_29 + var_256_21
					end

					if var_256_24.prefab_name ~= "" and arg_253_1.actors_[var_256_24.prefab_name] ~= nil then
						local var_256_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_24.prefab_name].transform, "story_v_out_322062", "322062062", "story_v_out_322062.awb")

						arg_253_1:RecordAudio("322062062", var_256_30)
						arg_253_1:RecordAudio("322062062", var_256_30)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_322062", "322062062", "story_v_out_322062.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_322062", "322062062", "story_v_out_322062.awb")
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
				actorName = "10104ui_story",
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
	Play322062063 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 322062063
		arg_257_1.duration_ = 6.2

		local var_257_0 = {
			zh = 3.333,
			ja = 6.2
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
				arg_257_0:Play322062064(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = arg_257_1.actors_["1211ui_story"].transform
			local var_260_1 = 0

			if var_260_1 < arg_257_1.time_ and arg_257_1.time_ <= var_260_1 + arg_260_0 then
				arg_257_1.var_.moveOldPos1211ui_story = var_260_0.localPosition

				local var_260_2 = "1211ui_story"

				arg_257_1:ShowWeapon(arg_257_1.var_[var_260_2 .. "Animator"].transform, false)
			end

			local var_260_3 = 0.001

			if var_260_1 <= arg_257_1.time_ and arg_257_1.time_ < var_260_1 + var_260_3 then
				local var_260_4 = (arg_257_1.time_ - var_260_1) / var_260_3
				local var_260_5 = Vector3.New(0, -0.67, -6.07)

				var_260_0.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos1211ui_story, var_260_5, var_260_4)

				local var_260_6 = manager.ui.mainCamera.transform.position - var_260_0.position

				var_260_0.forward = Vector3.New(var_260_6.x, var_260_6.y, var_260_6.z)

				local var_260_7 = var_260_0.localEulerAngles

				var_260_7.z = 0
				var_260_7.x = 0
				var_260_0.localEulerAngles = var_260_7
			end

			if arg_257_1.time_ >= var_260_1 + var_260_3 and arg_257_1.time_ < var_260_1 + var_260_3 + arg_260_0 then
				var_260_0.localPosition = Vector3.New(0, -0.67, -6.07)

				local var_260_8 = manager.ui.mainCamera.transform.position - var_260_0.position

				var_260_0.forward = Vector3.New(var_260_8.x, var_260_8.y, var_260_8.z)

				local var_260_9 = var_260_0.localEulerAngles

				var_260_9.z = 0
				var_260_9.x = 0
				var_260_0.localEulerAngles = var_260_9
			end

			local var_260_10 = arg_257_1.actors_["404001ui_story"].transform
			local var_260_11 = 0

			if var_260_11 < arg_257_1.time_ and arg_257_1.time_ <= var_260_11 + arg_260_0 then
				arg_257_1.var_.moveOldPos404001ui_story = var_260_10.localPosition
			end

			local var_260_12 = 0.001

			if var_260_11 <= arg_257_1.time_ and arg_257_1.time_ < var_260_11 + var_260_12 then
				local var_260_13 = (arg_257_1.time_ - var_260_11) / var_260_12
				local var_260_14 = Vector3.New(0, 100, 0)

				var_260_10.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos404001ui_story, var_260_14, var_260_13)

				local var_260_15 = manager.ui.mainCamera.transform.position - var_260_10.position

				var_260_10.forward = Vector3.New(var_260_15.x, var_260_15.y, var_260_15.z)

				local var_260_16 = var_260_10.localEulerAngles

				var_260_16.z = 0
				var_260_16.x = 0
				var_260_10.localEulerAngles = var_260_16
			end

			if arg_257_1.time_ >= var_260_11 + var_260_12 and arg_257_1.time_ < var_260_11 + var_260_12 + arg_260_0 then
				var_260_10.localPosition = Vector3.New(0, 100, 0)

				local var_260_17 = manager.ui.mainCamera.transform.position - var_260_10.position

				var_260_10.forward = Vector3.New(var_260_17.x, var_260_17.y, var_260_17.z)

				local var_260_18 = var_260_10.localEulerAngles

				var_260_18.z = 0
				var_260_18.x = 0
				var_260_10.localEulerAngles = var_260_18
			end

			local var_260_19 = arg_257_1.actors_["10104ui_story"].transform
			local var_260_20 = 0

			if var_260_20 < arg_257_1.time_ and arg_257_1.time_ <= var_260_20 + arg_260_0 then
				arg_257_1.var_.moveOldPos10104ui_story = var_260_19.localPosition
			end

			local var_260_21 = 0.001

			if var_260_20 <= arg_257_1.time_ and arg_257_1.time_ < var_260_20 + var_260_21 then
				local var_260_22 = (arg_257_1.time_ - var_260_20) / var_260_21
				local var_260_23 = Vector3.New(0, 100, 0)

				var_260_19.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos10104ui_story, var_260_23, var_260_22)

				local var_260_24 = manager.ui.mainCamera.transform.position - var_260_19.position

				var_260_19.forward = Vector3.New(var_260_24.x, var_260_24.y, var_260_24.z)

				local var_260_25 = var_260_19.localEulerAngles

				var_260_25.z = 0
				var_260_25.x = 0
				var_260_19.localEulerAngles = var_260_25
			end

			if arg_257_1.time_ >= var_260_20 + var_260_21 and arg_257_1.time_ < var_260_20 + var_260_21 + arg_260_0 then
				var_260_19.localPosition = Vector3.New(0, 100, 0)

				local var_260_26 = manager.ui.mainCamera.transform.position - var_260_19.position

				var_260_19.forward = Vector3.New(var_260_26.x, var_260_26.y, var_260_26.z)

				local var_260_27 = var_260_19.localEulerAngles

				var_260_27.z = 0
				var_260_27.x = 0
				var_260_19.localEulerAngles = var_260_27
			end

			local var_260_28 = arg_257_1.actors_["1211ui_story"]
			local var_260_29 = 0

			if var_260_29 < arg_257_1.time_ and arg_257_1.time_ <= var_260_29 + arg_260_0 and not isNil(var_260_28) and arg_257_1.var_.characterEffect1211ui_story == nil then
				arg_257_1.var_.characterEffect1211ui_story = var_260_28:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_260_30 = 0.200000002980232

			if var_260_29 <= arg_257_1.time_ and arg_257_1.time_ < var_260_29 + var_260_30 and not isNil(var_260_28) then
				local var_260_31 = (arg_257_1.time_ - var_260_29) / var_260_30

				if arg_257_1.var_.characterEffect1211ui_story and not isNil(var_260_28) then
					arg_257_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_257_1.time_ >= var_260_29 + var_260_30 and arg_257_1.time_ < var_260_29 + var_260_30 + arg_260_0 and not isNil(var_260_28) and arg_257_1.var_.characterEffect1211ui_story then
				arg_257_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_260_32 = arg_257_1.actors_["10104ui_story"]
			local var_260_33 = 0

			if var_260_33 < arg_257_1.time_ and arg_257_1.time_ <= var_260_33 + arg_260_0 and not isNil(var_260_32) and arg_257_1.var_.characterEffect10104ui_story == nil then
				arg_257_1.var_.characterEffect10104ui_story = var_260_32:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_260_34 = 0.200000002980232

			if var_260_33 <= arg_257_1.time_ and arg_257_1.time_ < var_260_33 + var_260_34 and not isNil(var_260_32) then
				local var_260_35 = (arg_257_1.time_ - var_260_33) / var_260_34

				if arg_257_1.var_.characterEffect10104ui_story and not isNil(var_260_32) then
					local var_260_36 = Mathf.Lerp(0, 0.5, var_260_35)

					arg_257_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_257_1.var_.characterEffect10104ui_story.fillRatio = var_260_36
				end
			end

			if arg_257_1.time_ >= var_260_33 + var_260_34 and arg_257_1.time_ < var_260_33 + var_260_34 + arg_260_0 and not isNil(var_260_32) and arg_257_1.var_.characterEffect10104ui_story then
				local var_260_37 = 0.5

				arg_257_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_257_1.var_.characterEffect10104ui_story.fillRatio = var_260_37
			end

			local var_260_38 = 0

			if var_260_38 < arg_257_1.time_ and arg_257_1.time_ <= var_260_38 + arg_260_0 then
				arg_257_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action5_1")
			end

			local var_260_39 = 0

			if var_260_39 < arg_257_1.time_ and arg_257_1.time_ <= var_260_39 + arg_260_0 then
				arg_257_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_260_40 = 0
			local var_260_41 = 0.35

			if var_260_40 < arg_257_1.time_ and arg_257_1.time_ <= var_260_40 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				local var_260_42 = arg_257_1:FormatText(StoryNameCfg[37].name)

				arg_257_1.leftNameTxt_.text = var_260_42

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_43 = arg_257_1:GetWordFromCfg(322062063)
				local var_260_44 = arg_257_1:FormatText(var_260_43.content)

				arg_257_1.text_.text = var_260_44

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_45 = 14
				local var_260_46 = utf8.len(var_260_44)
				local var_260_47 = var_260_45 <= 0 and var_260_41 or var_260_41 * (var_260_46 / var_260_45)

				if var_260_47 > 0 and var_260_41 < var_260_47 then
					arg_257_1.talkMaxDuration = var_260_47

					if var_260_47 + var_260_40 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_47 + var_260_40
					end
				end

				arg_257_1.text_.text = var_260_44
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062063", "story_v_out_322062.awb") ~= 0 then
					local var_260_48 = manager.audio:GetVoiceLength("story_v_out_322062", "322062063", "story_v_out_322062.awb") / 1000

					if var_260_48 + var_260_40 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_48 + var_260_40
					end

					if var_260_43.prefab_name ~= "" and arg_257_1.actors_[var_260_43.prefab_name] ~= nil then
						local var_260_49 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_43.prefab_name].transform, "story_v_out_322062", "322062063", "story_v_out_322062.awb")

						arg_257_1:RecordAudio("322062063", var_260_49)
						arg_257_1:RecordAudio("322062063", var_260_49)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_322062", "322062063", "story_v_out_322062.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_322062", "322062063", "story_v_out_322062.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_50 = math.max(var_260_41, arg_257_1.talkMaxDuration)

			if var_260_40 <= arg_257_1.time_ and arg_257_1.time_ < var_260_40 + var_260_50 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_40) / var_260_50

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_40 + var_260_50 and arg_257_1.time_ < var_260_40 + var_260_50 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_257_1:InitPlayNodeList()
	end,
	Play322062064 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 322062064
		arg_261_1.duration_ = 8.63

		local var_261_0 = {
			zh = 7.566,
			ja = 8.633
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
				arg_261_0:Play322062065(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = arg_261_1.actors_["1284ui_story"].transform
			local var_264_1 = 0

			if var_264_1 < arg_261_1.time_ and arg_261_1.time_ <= var_264_1 + arg_264_0 then
				arg_261_1.var_.moveOldPos1284ui_story = var_264_0.localPosition

				local var_264_2 = "1284ui_story"

				arg_261_1:ShowWeapon(arg_261_1.var_[var_264_2 .. "Animator"].transform, false)
			end

			local var_264_3 = 0.001

			if var_264_1 <= arg_261_1.time_ and arg_261_1.time_ < var_264_1 + var_264_3 then
				local var_264_4 = (arg_261_1.time_ - var_264_1) / var_264_3
				local var_264_5 = Vector3.New(0.7, -0.985, -6.22)

				var_264_0.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos1284ui_story, var_264_5, var_264_4)

				local var_264_6 = manager.ui.mainCamera.transform.position - var_264_0.position

				var_264_0.forward = Vector3.New(var_264_6.x, var_264_6.y, var_264_6.z)

				local var_264_7 = var_264_0.localEulerAngles

				var_264_7.z = 0
				var_264_7.x = 0
				var_264_0.localEulerAngles = var_264_7
			end

			if arg_261_1.time_ >= var_264_1 + var_264_3 and arg_261_1.time_ < var_264_1 + var_264_3 + arg_264_0 then
				var_264_0.localPosition = Vector3.New(0.7, -0.985, -6.22)

				local var_264_8 = manager.ui.mainCamera.transform.position - var_264_0.position

				var_264_0.forward = Vector3.New(var_264_8.x, var_264_8.y, var_264_8.z)

				local var_264_9 = var_264_0.localEulerAngles

				var_264_9.z = 0
				var_264_9.x = 0
				var_264_0.localEulerAngles = var_264_9
			end

			local var_264_10 = arg_261_1.actors_["1211ui_story"].transform
			local var_264_11 = 0

			if var_264_11 < arg_261_1.time_ and arg_261_1.time_ <= var_264_11 + arg_264_0 then
				arg_261_1.var_.moveOldPos1211ui_story = var_264_10.localPosition
			end

			local var_264_12 = 0.001

			if var_264_11 <= arg_261_1.time_ and arg_261_1.time_ < var_264_11 + var_264_12 then
				local var_264_13 = (arg_261_1.time_ - var_264_11) / var_264_12
				local var_264_14 = Vector3.New(-0.7, -0.67, -6.07)

				var_264_10.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos1211ui_story, var_264_14, var_264_13)

				local var_264_15 = manager.ui.mainCamera.transform.position - var_264_10.position

				var_264_10.forward = Vector3.New(var_264_15.x, var_264_15.y, var_264_15.z)

				local var_264_16 = var_264_10.localEulerAngles

				var_264_16.z = 0
				var_264_16.x = 0
				var_264_10.localEulerAngles = var_264_16
			end

			if arg_261_1.time_ >= var_264_11 + var_264_12 and arg_261_1.time_ < var_264_11 + var_264_12 + arg_264_0 then
				var_264_10.localPosition = Vector3.New(-0.7, -0.67, -6.07)

				local var_264_17 = manager.ui.mainCamera.transform.position - var_264_10.position

				var_264_10.forward = Vector3.New(var_264_17.x, var_264_17.y, var_264_17.z)

				local var_264_18 = var_264_10.localEulerAngles

				var_264_18.z = 0
				var_264_18.x = 0
				var_264_10.localEulerAngles = var_264_18
			end

			local var_264_19 = arg_261_1.actors_["1284ui_story"]
			local var_264_20 = 0

			if var_264_20 < arg_261_1.time_ and arg_261_1.time_ <= var_264_20 + arg_264_0 and not isNil(var_264_19) and arg_261_1.var_.characterEffect1284ui_story == nil then
				arg_261_1.var_.characterEffect1284ui_story = var_264_19:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_21 = 0.200000002980232

			if var_264_20 <= arg_261_1.time_ and arg_261_1.time_ < var_264_20 + var_264_21 and not isNil(var_264_19) then
				local var_264_22 = (arg_261_1.time_ - var_264_20) / var_264_21

				if arg_261_1.var_.characterEffect1284ui_story and not isNil(var_264_19) then
					arg_261_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_261_1.time_ >= var_264_20 + var_264_21 and arg_261_1.time_ < var_264_20 + var_264_21 + arg_264_0 and not isNil(var_264_19) and arg_261_1.var_.characterEffect1284ui_story then
				arg_261_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_264_23 = arg_261_1.actors_["1211ui_story"]
			local var_264_24 = 0

			if var_264_24 < arg_261_1.time_ and arg_261_1.time_ <= var_264_24 + arg_264_0 and not isNil(var_264_23) and arg_261_1.var_.characterEffect1211ui_story == nil then
				arg_261_1.var_.characterEffect1211ui_story = var_264_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_25 = 0.200000002980232

			if var_264_24 <= arg_261_1.time_ and arg_261_1.time_ < var_264_24 + var_264_25 and not isNil(var_264_23) then
				local var_264_26 = (arg_261_1.time_ - var_264_24) / var_264_25

				if arg_261_1.var_.characterEffect1211ui_story and not isNil(var_264_23) then
					local var_264_27 = Mathf.Lerp(0, 0.5, var_264_26)

					arg_261_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_261_1.var_.characterEffect1211ui_story.fillRatio = var_264_27
				end
			end

			if arg_261_1.time_ >= var_264_24 + var_264_25 and arg_261_1.time_ < var_264_24 + var_264_25 + arg_264_0 and not isNil(var_264_23) and arg_261_1.var_.characterEffect1211ui_story then
				local var_264_28 = 0.5

				arg_261_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_261_1.var_.characterEffect1211ui_story.fillRatio = var_264_28
			end

			local var_264_29 = 0

			if var_264_29 < arg_261_1.time_ and arg_261_1.time_ <= var_264_29 + arg_264_0 then
				arg_261_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action1_1")
			end

			local var_264_30 = 0

			if var_264_30 < arg_261_1.time_ and arg_261_1.time_ <= var_264_30 + arg_264_0 then
				arg_261_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_264_31 = 0
			local var_264_32 = 0.725

			if var_264_31 < arg_261_1.time_ and arg_261_1.time_ <= var_264_31 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				local var_264_33 = arg_261_1:FormatText(StoryNameCfg[6].name)

				arg_261_1.leftNameTxt_.text = var_264_33

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_34 = arg_261_1:GetWordFromCfg(322062064)
				local var_264_35 = arg_261_1:FormatText(var_264_34.content)

				arg_261_1.text_.text = var_264_35

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_36 = 29
				local var_264_37 = utf8.len(var_264_35)
				local var_264_38 = var_264_36 <= 0 and var_264_32 or var_264_32 * (var_264_37 / var_264_36)

				if var_264_38 > 0 and var_264_32 < var_264_38 then
					arg_261_1.talkMaxDuration = var_264_38

					if var_264_38 + var_264_31 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_38 + var_264_31
					end
				end

				arg_261_1.text_.text = var_264_35
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062064", "story_v_out_322062.awb") ~= 0 then
					local var_264_39 = manager.audio:GetVoiceLength("story_v_out_322062", "322062064", "story_v_out_322062.awb") / 1000

					if var_264_39 + var_264_31 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_39 + var_264_31
					end

					if var_264_34.prefab_name ~= "" and arg_261_1.actors_[var_264_34.prefab_name] ~= nil then
						local var_264_40 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_34.prefab_name].transform, "story_v_out_322062", "322062064", "story_v_out_322062.awb")

						arg_261_1:RecordAudio("322062064", var_264_40)
						arg_261_1:RecordAudio("322062064", var_264_40)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_322062", "322062064", "story_v_out_322062.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_322062", "322062064", "story_v_out_322062.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_41 = math.max(var_264_32, arg_261_1.talkMaxDuration)

			if var_264_31 <= arg_261_1.time_ and arg_261_1.time_ < var_264_31 + var_264_41 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_31) / var_264_41

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_31 + var_264_41 and arg_261_1.time_ < var_264_31 + var_264_41 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_261_1:InitPlayNodeList()
	end,
	Play322062065 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 322062065
		arg_265_1.duration_ = 5.73

		local var_265_0 = {
			zh = 4.366,
			ja = 5.733
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
				arg_265_0:Play322062066(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = arg_265_1.actors_["404001ui_story"].transform
			local var_268_1 = 0

			if var_268_1 < arg_265_1.time_ and arg_265_1.time_ <= var_268_1 + arg_268_0 then
				arg_265_1.var_.moveOldPos404001ui_story = var_268_0.localPosition
			end

			local var_268_2 = 0.001

			if var_268_1 <= arg_265_1.time_ and arg_265_1.time_ < var_268_1 + var_268_2 then
				local var_268_3 = (arg_265_1.time_ - var_268_1) / var_268_2
				local var_268_4 = Vector3.New(-0.8, -1.55, -5.5)

				var_268_0.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos404001ui_story, var_268_4, var_268_3)

				local var_268_5 = manager.ui.mainCamera.transform.position - var_268_0.position

				var_268_0.forward = Vector3.New(var_268_5.x, var_268_5.y, var_268_5.z)

				local var_268_6 = var_268_0.localEulerAngles

				var_268_6.z = 0
				var_268_6.x = 0
				var_268_0.localEulerAngles = var_268_6
			end

			if arg_265_1.time_ >= var_268_1 + var_268_2 and arg_265_1.time_ < var_268_1 + var_268_2 + arg_268_0 then
				var_268_0.localPosition = Vector3.New(-0.8, -1.55, -5.5)

				local var_268_7 = manager.ui.mainCamera.transform.position - var_268_0.position

				var_268_0.forward = Vector3.New(var_268_7.x, var_268_7.y, var_268_7.z)

				local var_268_8 = var_268_0.localEulerAngles

				var_268_8.z = 0
				var_268_8.x = 0
				var_268_0.localEulerAngles = var_268_8
			end

			local var_268_9 = arg_265_1.actors_["1211ui_story"].transform
			local var_268_10 = 0

			if var_268_10 < arg_265_1.time_ and arg_265_1.time_ <= var_268_10 + arg_268_0 then
				arg_265_1.var_.moveOldPos1211ui_story = var_268_9.localPosition
			end

			local var_268_11 = 0.001

			if var_268_10 <= arg_265_1.time_ and arg_265_1.time_ < var_268_10 + var_268_11 then
				local var_268_12 = (arg_265_1.time_ - var_268_10) / var_268_11
				local var_268_13 = Vector3.New(0, 100, 0)

				var_268_9.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos1211ui_story, var_268_13, var_268_12)

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

			local var_268_18 = arg_265_1.actors_["404001ui_story"]
			local var_268_19 = 0

			if var_268_19 < arg_265_1.time_ and arg_265_1.time_ <= var_268_19 + arg_268_0 and not isNil(var_268_18) and arg_265_1.var_.characterEffect404001ui_story == nil then
				arg_265_1.var_.characterEffect404001ui_story = var_268_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_20 = 0.200000002980232

			if var_268_19 <= arg_265_1.time_ and arg_265_1.time_ < var_268_19 + var_268_20 and not isNil(var_268_18) then
				local var_268_21 = (arg_265_1.time_ - var_268_19) / var_268_20

				if arg_265_1.var_.characterEffect404001ui_story and not isNil(var_268_18) then
					arg_265_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_265_1.time_ >= var_268_19 + var_268_20 and arg_265_1.time_ < var_268_19 + var_268_20 + arg_268_0 and not isNil(var_268_18) and arg_265_1.var_.characterEffect404001ui_story then
				arg_265_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_268_22 = arg_265_1.actors_["1284ui_story"]
			local var_268_23 = 0

			if var_268_23 < arg_265_1.time_ and arg_265_1.time_ <= var_268_23 + arg_268_0 and not isNil(var_268_22) and arg_265_1.var_.characterEffect1284ui_story == nil then
				arg_265_1.var_.characterEffect1284ui_story = var_268_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_24 = 0.200000002980232

			if var_268_23 <= arg_265_1.time_ and arg_265_1.time_ < var_268_23 + var_268_24 and not isNil(var_268_22) then
				local var_268_25 = (arg_265_1.time_ - var_268_23) / var_268_24

				if arg_265_1.var_.characterEffect1284ui_story and not isNil(var_268_22) then
					local var_268_26 = Mathf.Lerp(0, 0.5, var_268_25)

					arg_265_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_265_1.var_.characterEffect1284ui_story.fillRatio = var_268_26
				end
			end

			if arg_265_1.time_ >= var_268_23 + var_268_24 and arg_265_1.time_ < var_268_23 + var_268_24 + arg_268_0 and not isNil(var_268_22) and arg_265_1.var_.characterEffect1284ui_story then
				local var_268_27 = 0.5

				arg_265_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_265_1.var_.characterEffect1284ui_story.fillRatio = var_268_27
			end

			local var_268_28 = 0

			if var_268_28 < arg_265_1.time_ and arg_265_1.time_ <= var_268_28 + arg_268_0 then
				arg_265_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_268_29 = 0

			if var_268_29 < arg_265_1.time_ and arg_265_1.time_ <= var_268_29 + arg_268_0 then
				arg_265_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_268_30 = 0
			local var_268_31 = 0.475

			if var_268_30 < arg_265_1.time_ and arg_265_1.time_ <= var_268_30 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				local var_268_32 = arg_265_1:FormatText(StoryNameCfg[668].name)

				arg_265_1.leftNameTxt_.text = var_268_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_33 = arg_265_1:GetWordFromCfg(322062065)
				local var_268_34 = arg_265_1:FormatText(var_268_33.content)

				arg_265_1.text_.text = var_268_34

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_35 = 19
				local var_268_36 = utf8.len(var_268_34)
				local var_268_37 = var_268_35 <= 0 and var_268_31 or var_268_31 * (var_268_36 / var_268_35)

				if var_268_37 > 0 and var_268_31 < var_268_37 then
					arg_265_1.talkMaxDuration = var_268_37

					if var_268_37 + var_268_30 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_37 + var_268_30
					end
				end

				arg_265_1.text_.text = var_268_34
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062065", "story_v_out_322062.awb") ~= 0 then
					local var_268_38 = manager.audio:GetVoiceLength("story_v_out_322062", "322062065", "story_v_out_322062.awb") / 1000

					if var_268_38 + var_268_30 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_38 + var_268_30
					end

					if var_268_33.prefab_name ~= "" and arg_265_1.actors_[var_268_33.prefab_name] ~= nil then
						local var_268_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_33.prefab_name].transform, "story_v_out_322062", "322062065", "story_v_out_322062.awb")

						arg_265_1:RecordAudio("322062065", var_268_39)
						arg_265_1:RecordAudio("322062065", var_268_39)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_322062", "322062065", "story_v_out_322062.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_322062", "322062065", "story_v_out_322062.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_40 = math.max(var_268_31, arg_265_1.talkMaxDuration)

			if var_268_30 <= arg_265_1.time_ and arg_265_1.time_ < var_268_30 + var_268_40 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_30) / var_268_40

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_30 + var_268_40 and arg_265_1.time_ < var_268_30 + var_268_40 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1211ui_story",
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
	Play322062066 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 322062066
		arg_269_1.duration_ = 7.53

		local var_269_0 = {
			zh = 5.4,
			ja = 7.533
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
				arg_269_0:Play322062067(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = arg_269_1.actors_["1284ui_story"].transform
			local var_272_1 = 0

			if var_272_1 < arg_269_1.time_ and arg_269_1.time_ <= var_272_1 + arg_272_0 then
				arg_269_1.var_.moveOldPos1284ui_story = var_272_0.localPosition
			end

			local var_272_2 = 0.001

			if var_272_1 <= arg_269_1.time_ and arg_269_1.time_ < var_272_1 + var_272_2 then
				local var_272_3 = (arg_269_1.time_ - var_272_1) / var_272_2
				local var_272_4 = Vector3.New(0.7, -0.985, -6.22)

				var_272_0.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos1284ui_story, var_272_4, var_272_3)

				local var_272_5 = manager.ui.mainCamera.transform.position - var_272_0.position

				var_272_0.forward = Vector3.New(var_272_5.x, var_272_5.y, var_272_5.z)

				local var_272_6 = var_272_0.localEulerAngles

				var_272_6.z = 0
				var_272_6.x = 0
				var_272_0.localEulerAngles = var_272_6
			end

			if arg_269_1.time_ >= var_272_1 + var_272_2 and arg_269_1.time_ < var_272_1 + var_272_2 + arg_272_0 then
				var_272_0.localPosition = Vector3.New(0.7, -0.985, -6.22)

				local var_272_7 = manager.ui.mainCamera.transform.position - var_272_0.position

				var_272_0.forward = Vector3.New(var_272_7.x, var_272_7.y, var_272_7.z)

				local var_272_8 = var_272_0.localEulerAngles

				var_272_8.z = 0
				var_272_8.x = 0
				var_272_0.localEulerAngles = var_272_8
			end

			local var_272_9 = arg_269_1.actors_["1284ui_story"]
			local var_272_10 = 0

			if var_272_10 < arg_269_1.time_ and arg_269_1.time_ <= var_272_10 + arg_272_0 and not isNil(var_272_9) and arg_269_1.var_.characterEffect1284ui_story == nil then
				arg_269_1.var_.characterEffect1284ui_story = var_272_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_11 = 0.200000002980232

			if var_272_10 <= arg_269_1.time_ and arg_269_1.time_ < var_272_10 + var_272_11 and not isNil(var_272_9) then
				local var_272_12 = (arg_269_1.time_ - var_272_10) / var_272_11

				if arg_269_1.var_.characterEffect1284ui_story and not isNil(var_272_9) then
					arg_269_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_269_1.time_ >= var_272_10 + var_272_11 and arg_269_1.time_ < var_272_10 + var_272_11 + arg_272_0 and not isNil(var_272_9) and arg_269_1.var_.characterEffect1284ui_story then
				arg_269_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_272_13 = arg_269_1.actors_["404001ui_story"]
			local var_272_14 = 0

			if var_272_14 < arg_269_1.time_ and arg_269_1.time_ <= var_272_14 + arg_272_0 and not isNil(var_272_13) and arg_269_1.var_.characterEffect404001ui_story == nil then
				arg_269_1.var_.characterEffect404001ui_story = var_272_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_15 = 0.200000002980232

			if var_272_14 <= arg_269_1.time_ and arg_269_1.time_ < var_272_14 + var_272_15 and not isNil(var_272_13) then
				local var_272_16 = (arg_269_1.time_ - var_272_14) / var_272_15

				if arg_269_1.var_.characterEffect404001ui_story and not isNil(var_272_13) then
					local var_272_17 = Mathf.Lerp(0, 0.5, var_272_16)

					arg_269_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_269_1.var_.characterEffect404001ui_story.fillRatio = var_272_17
				end
			end

			if arg_269_1.time_ >= var_272_14 + var_272_15 and arg_269_1.time_ < var_272_14 + var_272_15 + arg_272_0 and not isNil(var_272_13) and arg_269_1.var_.characterEffect404001ui_story then
				local var_272_18 = 0.5

				arg_269_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_269_1.var_.characterEffect404001ui_story.fillRatio = var_272_18
			end

			local var_272_19 = 0

			if var_272_19 < arg_269_1.time_ and arg_269_1.time_ <= var_272_19 + arg_272_0 then
				arg_269_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action4_1")
			end

			local var_272_20 = 0

			if var_272_20 < arg_269_1.time_ and arg_269_1.time_ <= var_272_20 + arg_272_0 then
				arg_269_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_272_21 = 0
			local var_272_22 = 0.65

			if var_272_21 < arg_269_1.time_ and arg_269_1.time_ <= var_272_21 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				local var_272_23 = arg_269_1:FormatText(StoryNameCfg[6].name)

				arg_269_1.leftNameTxt_.text = var_272_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_24 = arg_269_1:GetWordFromCfg(322062066)
				local var_272_25 = arg_269_1:FormatText(var_272_24.content)

				arg_269_1.text_.text = var_272_25

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_26 = 26
				local var_272_27 = utf8.len(var_272_25)
				local var_272_28 = var_272_26 <= 0 and var_272_22 or var_272_22 * (var_272_27 / var_272_26)

				if var_272_28 > 0 and var_272_22 < var_272_28 then
					arg_269_1.talkMaxDuration = var_272_28

					if var_272_28 + var_272_21 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_28 + var_272_21
					end
				end

				arg_269_1.text_.text = var_272_25
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062066", "story_v_out_322062.awb") ~= 0 then
					local var_272_29 = manager.audio:GetVoiceLength("story_v_out_322062", "322062066", "story_v_out_322062.awb") / 1000

					if var_272_29 + var_272_21 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_29 + var_272_21
					end

					if var_272_24.prefab_name ~= "" and arg_269_1.actors_[var_272_24.prefab_name] ~= nil then
						local var_272_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_24.prefab_name].transform, "story_v_out_322062", "322062066", "story_v_out_322062.awb")

						arg_269_1:RecordAudio("322062066", var_272_30)
						arg_269_1:RecordAudio("322062066", var_272_30)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_322062", "322062066", "story_v_out_322062.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_322062", "322062066", "story_v_out_322062.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_31 = math.max(var_272_22, arg_269_1.talkMaxDuration)

			if var_272_21 <= arg_269_1.time_ and arg_269_1.time_ < var_272_21 + var_272_31 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_21) / var_272_31

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_21 + var_272_31 and arg_269_1.time_ < var_272_21 + var_272_31 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
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
	Play322062067 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 322062067
		arg_273_1.duration_ = 4.9

		local var_273_0 = {
			zh = 4.5,
			ja = 4.9
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
				arg_273_0:Play322062068(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = arg_273_1.actors_["1156ui_story"].transform
			local var_276_1 = 0

			if var_276_1 < arg_273_1.time_ and arg_273_1.time_ <= var_276_1 + arg_276_0 then
				arg_273_1.var_.moveOldPos1156ui_story = var_276_0.localPosition
			end

			local var_276_2 = 0.001

			if var_276_1 <= arg_273_1.time_ and arg_273_1.time_ < var_276_1 + var_276_2 then
				local var_276_3 = (arg_273_1.time_ - var_276_1) / var_276_2
				local var_276_4 = Vector3.New(0.9, -1.1, -6.18)

				var_276_0.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos1156ui_story, var_276_4, var_276_3)

				local var_276_5 = manager.ui.mainCamera.transform.position - var_276_0.position

				var_276_0.forward = Vector3.New(var_276_5.x, var_276_5.y, var_276_5.z)

				local var_276_6 = var_276_0.localEulerAngles

				var_276_6.z = 0
				var_276_6.x = 0
				var_276_0.localEulerAngles = var_276_6
			end

			if arg_273_1.time_ >= var_276_1 + var_276_2 and arg_273_1.time_ < var_276_1 + var_276_2 + arg_276_0 then
				var_276_0.localPosition = Vector3.New(0.9, -1.1, -6.18)

				local var_276_7 = manager.ui.mainCamera.transform.position - var_276_0.position

				var_276_0.forward = Vector3.New(var_276_7.x, var_276_7.y, var_276_7.z)

				local var_276_8 = var_276_0.localEulerAngles

				var_276_8.z = 0
				var_276_8.x = 0
				var_276_0.localEulerAngles = var_276_8
			end

			local var_276_9 = arg_273_1.actors_["1284ui_story"].transform
			local var_276_10 = 0

			if var_276_10 < arg_273_1.time_ and arg_273_1.time_ <= var_276_10 + arg_276_0 then
				arg_273_1.var_.moveOldPos1284ui_story = var_276_9.localPosition
			end

			local var_276_11 = 0.001

			if var_276_10 <= arg_273_1.time_ and arg_273_1.time_ < var_276_10 + var_276_11 then
				local var_276_12 = (arg_273_1.time_ - var_276_10) / var_276_11
				local var_276_13 = Vector3.New(0, 100, 0)

				var_276_9.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos1284ui_story, var_276_13, var_276_12)

				local var_276_14 = manager.ui.mainCamera.transform.position - var_276_9.position

				var_276_9.forward = Vector3.New(var_276_14.x, var_276_14.y, var_276_14.z)

				local var_276_15 = var_276_9.localEulerAngles

				var_276_15.z = 0
				var_276_15.x = 0
				var_276_9.localEulerAngles = var_276_15
			end

			if arg_273_1.time_ >= var_276_10 + var_276_11 and arg_273_1.time_ < var_276_10 + var_276_11 + arg_276_0 then
				var_276_9.localPosition = Vector3.New(0, 100, 0)

				local var_276_16 = manager.ui.mainCamera.transform.position - var_276_9.position

				var_276_9.forward = Vector3.New(var_276_16.x, var_276_16.y, var_276_16.z)

				local var_276_17 = var_276_9.localEulerAngles

				var_276_17.z = 0
				var_276_17.x = 0
				var_276_9.localEulerAngles = var_276_17
			end

			local var_276_18 = arg_273_1.actors_["1156ui_story"]
			local var_276_19 = 0

			if var_276_19 < arg_273_1.time_ and arg_273_1.time_ <= var_276_19 + arg_276_0 and not isNil(var_276_18) and arg_273_1.var_.characterEffect1156ui_story == nil then
				arg_273_1.var_.characterEffect1156ui_story = var_276_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_20 = 0.200000002980232

			if var_276_19 <= arg_273_1.time_ and arg_273_1.time_ < var_276_19 + var_276_20 and not isNil(var_276_18) then
				local var_276_21 = (arg_273_1.time_ - var_276_19) / var_276_20

				if arg_273_1.var_.characterEffect1156ui_story and not isNil(var_276_18) then
					arg_273_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_273_1.time_ >= var_276_19 + var_276_20 and arg_273_1.time_ < var_276_19 + var_276_20 + arg_276_0 and not isNil(var_276_18) and arg_273_1.var_.characterEffect1156ui_story then
				arg_273_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			local var_276_22 = arg_273_1.actors_["1284ui_story"]
			local var_276_23 = 0

			if var_276_23 < arg_273_1.time_ and arg_273_1.time_ <= var_276_23 + arg_276_0 and not isNil(var_276_22) and arg_273_1.var_.characterEffect1284ui_story == nil then
				arg_273_1.var_.characterEffect1284ui_story = var_276_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_24 = 0.200000002980232

			if var_276_23 <= arg_273_1.time_ and arg_273_1.time_ < var_276_23 + var_276_24 and not isNil(var_276_22) then
				local var_276_25 = (arg_273_1.time_ - var_276_23) / var_276_24

				if arg_273_1.var_.characterEffect1284ui_story and not isNil(var_276_22) then
					local var_276_26 = Mathf.Lerp(0, 0.5, var_276_25)

					arg_273_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_273_1.var_.characterEffect1284ui_story.fillRatio = var_276_26
				end
			end

			if arg_273_1.time_ >= var_276_23 + var_276_24 and arg_273_1.time_ < var_276_23 + var_276_24 + arg_276_0 and not isNil(var_276_22) and arg_273_1.var_.characterEffect1284ui_story then
				local var_276_27 = 0.5

				arg_273_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_273_1.var_.characterEffect1284ui_story.fillRatio = var_276_27
			end

			local var_276_28 = 0

			if var_276_28 < arg_273_1.time_ and arg_273_1.time_ <= var_276_28 + arg_276_0 then
				arg_273_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action6_1")
			end

			local var_276_29 = 0

			if var_276_29 < arg_273_1.time_ and arg_273_1.time_ <= var_276_29 + arg_276_0 then
				arg_273_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_276_30 = 0
			local var_276_31 = 0.5

			if var_276_30 < arg_273_1.time_ and arg_273_1.time_ <= var_276_30 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				local var_276_32 = arg_273_1:FormatText(StoryNameCfg[605].name)

				arg_273_1.leftNameTxt_.text = var_276_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_33 = arg_273_1:GetWordFromCfg(322062067)
				local var_276_34 = arg_273_1:FormatText(var_276_33.content)

				arg_273_1.text_.text = var_276_34

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_35 = 20
				local var_276_36 = utf8.len(var_276_34)
				local var_276_37 = var_276_35 <= 0 and var_276_31 or var_276_31 * (var_276_36 / var_276_35)

				if var_276_37 > 0 and var_276_31 < var_276_37 then
					arg_273_1.talkMaxDuration = var_276_37

					if var_276_37 + var_276_30 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_37 + var_276_30
					end
				end

				arg_273_1.text_.text = var_276_34
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062067", "story_v_out_322062.awb") ~= 0 then
					local var_276_38 = manager.audio:GetVoiceLength("story_v_out_322062", "322062067", "story_v_out_322062.awb") / 1000

					if var_276_38 + var_276_30 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_38 + var_276_30
					end

					if var_276_33.prefab_name ~= "" and arg_273_1.actors_[var_276_33.prefab_name] ~= nil then
						local var_276_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_33.prefab_name].transform, "story_v_out_322062", "322062067", "story_v_out_322062.awb")

						arg_273_1:RecordAudio("322062067", var_276_39)
						arg_273_1:RecordAudio("322062067", var_276_39)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_322062", "322062067", "story_v_out_322062.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_322062", "322062067", "story_v_out_322062.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_40 = math.max(var_276_31, arg_273_1.talkMaxDuration)

			if var_276_30 <= arg_273_1.time_ and arg_273_1.time_ < var_276_30 + var_276_40 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_30) / var_276_40

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_30 + var_276_40 and arg_273_1.time_ < var_276_30 + var_276_40 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1156ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1284ui_story",
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
	Play322062068 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 322062068
		arg_277_1.duration_ = 10.33

		local var_277_0 = {
			zh = 5.6,
			ja = 10.333
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
				arg_277_0:Play322062069(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = arg_277_1.actors_["404001ui_story"].transform
			local var_280_1 = 0

			if var_280_1 < arg_277_1.time_ and arg_277_1.time_ <= var_280_1 + arg_280_0 then
				arg_277_1.var_.moveOldPos404001ui_story = var_280_0.localPosition
			end

			local var_280_2 = 0.001

			if var_280_1 <= arg_277_1.time_ and arg_277_1.time_ < var_280_1 + var_280_2 then
				local var_280_3 = (arg_277_1.time_ - var_280_1) / var_280_2
				local var_280_4 = Vector3.New(-0.8, -1.55, -5.5)

				var_280_0.localPosition = Vector3.Lerp(arg_277_1.var_.moveOldPos404001ui_story, var_280_4, var_280_3)

				local var_280_5 = manager.ui.mainCamera.transform.position - var_280_0.position

				var_280_0.forward = Vector3.New(var_280_5.x, var_280_5.y, var_280_5.z)

				local var_280_6 = var_280_0.localEulerAngles

				var_280_6.z = 0
				var_280_6.x = 0
				var_280_0.localEulerAngles = var_280_6
			end

			if arg_277_1.time_ >= var_280_1 + var_280_2 and arg_277_1.time_ < var_280_1 + var_280_2 + arg_280_0 then
				var_280_0.localPosition = Vector3.New(-0.8, -1.55, -5.5)

				local var_280_7 = manager.ui.mainCamera.transform.position - var_280_0.position

				var_280_0.forward = Vector3.New(var_280_7.x, var_280_7.y, var_280_7.z)

				local var_280_8 = var_280_0.localEulerAngles

				var_280_8.z = 0
				var_280_8.x = 0
				var_280_0.localEulerAngles = var_280_8
			end

			local var_280_9 = arg_277_1.actors_["404001ui_story"]
			local var_280_10 = 0

			if var_280_10 < arg_277_1.time_ and arg_277_1.time_ <= var_280_10 + arg_280_0 and not isNil(var_280_9) and arg_277_1.var_.characterEffect404001ui_story == nil then
				arg_277_1.var_.characterEffect404001ui_story = var_280_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_11 = 0.200000002980232

			if var_280_10 <= arg_277_1.time_ and arg_277_1.time_ < var_280_10 + var_280_11 and not isNil(var_280_9) then
				local var_280_12 = (arg_277_1.time_ - var_280_10) / var_280_11

				if arg_277_1.var_.characterEffect404001ui_story and not isNil(var_280_9) then
					arg_277_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_277_1.time_ >= var_280_10 + var_280_11 and arg_277_1.time_ < var_280_10 + var_280_11 + arg_280_0 and not isNil(var_280_9) and arg_277_1.var_.characterEffect404001ui_story then
				arg_277_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_280_13 = arg_277_1.actors_["1156ui_story"]
			local var_280_14 = 0

			if var_280_14 < arg_277_1.time_ and arg_277_1.time_ <= var_280_14 + arg_280_0 and not isNil(var_280_13) and arg_277_1.var_.characterEffect1156ui_story == nil then
				arg_277_1.var_.characterEffect1156ui_story = var_280_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_15 = 0.200000002980232

			if var_280_14 <= arg_277_1.time_ and arg_277_1.time_ < var_280_14 + var_280_15 and not isNil(var_280_13) then
				local var_280_16 = (arg_277_1.time_ - var_280_14) / var_280_15

				if arg_277_1.var_.characterEffect1156ui_story and not isNil(var_280_13) then
					local var_280_17 = Mathf.Lerp(0, 0.5, var_280_16)

					arg_277_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_277_1.var_.characterEffect1156ui_story.fillRatio = var_280_17
				end
			end

			if arg_277_1.time_ >= var_280_14 + var_280_15 and arg_277_1.time_ < var_280_14 + var_280_15 + arg_280_0 and not isNil(var_280_13) and arg_277_1.var_.characterEffect1156ui_story then
				local var_280_18 = 0.5

				arg_277_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_277_1.var_.characterEffect1156ui_story.fillRatio = var_280_18
			end

			local var_280_19 = 0

			if var_280_19 < arg_277_1.time_ and arg_277_1.time_ <= var_280_19 + arg_280_0 then
				arg_277_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action2_1")
			end

			local var_280_20 = 0

			if var_280_20 < arg_277_1.time_ and arg_277_1.time_ <= var_280_20 + arg_280_0 then
				arg_277_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_280_21 = 0
			local var_280_22 = 0.675

			if var_280_21 < arg_277_1.time_ and arg_277_1.time_ <= var_280_21 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				local var_280_23 = arg_277_1:FormatText(StoryNameCfg[668].name)

				arg_277_1.leftNameTxt_.text = var_280_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_24 = arg_277_1:GetWordFromCfg(322062068)
				local var_280_25 = arg_277_1:FormatText(var_280_24.content)

				arg_277_1.text_.text = var_280_25

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_26 = 27
				local var_280_27 = utf8.len(var_280_25)
				local var_280_28 = var_280_26 <= 0 and var_280_22 or var_280_22 * (var_280_27 / var_280_26)

				if var_280_28 > 0 and var_280_22 < var_280_28 then
					arg_277_1.talkMaxDuration = var_280_28

					if var_280_28 + var_280_21 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_28 + var_280_21
					end
				end

				arg_277_1.text_.text = var_280_25
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062068", "story_v_out_322062.awb") ~= 0 then
					local var_280_29 = manager.audio:GetVoiceLength("story_v_out_322062", "322062068", "story_v_out_322062.awb") / 1000

					if var_280_29 + var_280_21 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_29 + var_280_21
					end

					if var_280_24.prefab_name ~= "" and arg_277_1.actors_[var_280_24.prefab_name] ~= nil then
						local var_280_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_24.prefab_name].transform, "story_v_out_322062", "322062068", "story_v_out_322062.awb")

						arg_277_1:RecordAudio("322062068", var_280_30)
						arg_277_1:RecordAudio("322062068", var_280_30)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_322062", "322062068", "story_v_out_322062.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_322062", "322062068", "story_v_out_322062.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_31 = math.max(var_280_22, arg_277_1.talkMaxDuration)

			if var_280_21 <= arg_277_1.time_ and arg_277_1.time_ < var_280_21 + var_280_31 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_21) / var_280_31

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_21 + var_280_31 and arg_277_1.time_ < var_280_21 + var_280_31 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
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
	Play322062069 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 322062069
		arg_281_1.duration_ = 7.23

		local var_281_0 = {
			zh = 7.233,
			ja = 5.8
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
				arg_281_0:Play322062070(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = 0

			if var_284_0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_0 + arg_284_0 then
				arg_281_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action2_2")
			end

			local var_284_1 = 0

			if var_284_1 < arg_281_1.time_ and arg_281_1.time_ <= var_284_1 + arg_284_0 then
				arg_281_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_284_2 = 0
			local var_284_3 = 0.825

			if var_284_2 < arg_281_1.time_ and arg_281_1.time_ <= var_284_2 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				local var_284_4 = arg_281_1:FormatText(StoryNameCfg[668].name)

				arg_281_1.leftNameTxt_.text = var_284_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_5 = arg_281_1:GetWordFromCfg(322062069)
				local var_284_6 = arg_281_1:FormatText(var_284_5.content)

				arg_281_1.text_.text = var_284_6

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_7 = 33
				local var_284_8 = utf8.len(var_284_6)
				local var_284_9 = var_284_7 <= 0 and var_284_3 or var_284_3 * (var_284_8 / var_284_7)

				if var_284_9 > 0 and var_284_3 < var_284_9 then
					arg_281_1.talkMaxDuration = var_284_9

					if var_284_9 + var_284_2 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_9 + var_284_2
					end
				end

				arg_281_1.text_.text = var_284_6
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062069", "story_v_out_322062.awb") ~= 0 then
					local var_284_10 = manager.audio:GetVoiceLength("story_v_out_322062", "322062069", "story_v_out_322062.awb") / 1000

					if var_284_10 + var_284_2 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_10 + var_284_2
					end

					if var_284_5.prefab_name ~= "" and arg_281_1.actors_[var_284_5.prefab_name] ~= nil then
						local var_284_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_5.prefab_name].transform, "story_v_out_322062", "322062069", "story_v_out_322062.awb")

						arg_281_1:RecordAudio("322062069", var_284_11)
						arg_281_1:RecordAudio("322062069", var_284_11)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_322062", "322062069", "story_v_out_322062.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_322062", "322062069", "story_v_out_322062.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_12 = math.max(var_284_3, arg_281_1.talkMaxDuration)

			if var_284_2 <= arg_281_1.time_ and arg_281_1.time_ < var_284_2 + var_284_12 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_2) / var_284_12

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_2 + var_284_12 and arg_281_1.time_ < var_284_2 + var_284_12 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play322062070 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 322062070
		arg_285_1.duration_ = 5

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play322062071(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = arg_285_1.actors_["404001ui_story"].transform
			local var_288_1 = 0

			if var_288_1 < arg_285_1.time_ and arg_285_1.time_ <= var_288_1 + arg_288_0 then
				arg_285_1.var_.moveOldPos404001ui_story = var_288_0.localPosition
			end

			local var_288_2 = 0.001

			if var_288_1 <= arg_285_1.time_ and arg_285_1.time_ < var_288_1 + var_288_2 then
				local var_288_3 = (arg_285_1.time_ - var_288_1) / var_288_2
				local var_288_4 = Vector3.New(0, 100, 0)

				var_288_0.localPosition = Vector3.Lerp(arg_285_1.var_.moveOldPos404001ui_story, var_288_4, var_288_3)

				local var_288_5 = manager.ui.mainCamera.transform.position - var_288_0.position

				var_288_0.forward = Vector3.New(var_288_5.x, var_288_5.y, var_288_5.z)

				local var_288_6 = var_288_0.localEulerAngles

				var_288_6.z = 0
				var_288_6.x = 0
				var_288_0.localEulerAngles = var_288_6
			end

			if arg_285_1.time_ >= var_288_1 + var_288_2 and arg_285_1.time_ < var_288_1 + var_288_2 + arg_288_0 then
				var_288_0.localPosition = Vector3.New(0, 100, 0)

				local var_288_7 = manager.ui.mainCamera.transform.position - var_288_0.position

				var_288_0.forward = Vector3.New(var_288_7.x, var_288_7.y, var_288_7.z)

				local var_288_8 = var_288_0.localEulerAngles

				var_288_8.z = 0
				var_288_8.x = 0
				var_288_0.localEulerAngles = var_288_8
			end

			local var_288_9 = arg_285_1.actors_["1156ui_story"].transform
			local var_288_10 = 0

			if var_288_10 < arg_285_1.time_ and arg_285_1.time_ <= var_288_10 + arg_288_0 then
				arg_285_1.var_.moveOldPos1156ui_story = var_288_9.localPosition
			end

			local var_288_11 = 0.001

			if var_288_10 <= arg_285_1.time_ and arg_285_1.time_ < var_288_10 + var_288_11 then
				local var_288_12 = (arg_285_1.time_ - var_288_10) / var_288_11
				local var_288_13 = Vector3.New(0, 100, 0)

				var_288_9.localPosition = Vector3.Lerp(arg_285_1.var_.moveOldPos1156ui_story, var_288_13, var_288_12)

				local var_288_14 = manager.ui.mainCamera.transform.position - var_288_9.position

				var_288_9.forward = Vector3.New(var_288_14.x, var_288_14.y, var_288_14.z)

				local var_288_15 = var_288_9.localEulerAngles

				var_288_15.z = 0
				var_288_15.x = 0
				var_288_9.localEulerAngles = var_288_15
			end

			if arg_285_1.time_ >= var_288_10 + var_288_11 and arg_285_1.time_ < var_288_10 + var_288_11 + arg_288_0 then
				var_288_9.localPosition = Vector3.New(0, 100, 0)

				local var_288_16 = manager.ui.mainCamera.transform.position - var_288_9.position

				var_288_9.forward = Vector3.New(var_288_16.x, var_288_16.y, var_288_16.z)

				local var_288_17 = var_288_9.localEulerAngles

				var_288_17.z = 0
				var_288_17.x = 0
				var_288_9.localEulerAngles = var_288_17
			end

			local var_288_18 = 0
			local var_288_19 = 1.5

			if var_288_18 < arg_285_1.time_ and arg_285_1.time_ <= var_288_18 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, false)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_20 = arg_285_1:GetWordFromCfg(322062070)
				local var_288_21 = arg_285_1:FormatText(var_288_20.content)

				arg_285_1.text_.text = var_288_21

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_22 = 60
				local var_288_23 = utf8.len(var_288_21)
				local var_288_24 = var_288_22 <= 0 and var_288_19 or var_288_19 * (var_288_23 / var_288_22)

				if var_288_24 > 0 and var_288_19 < var_288_24 then
					arg_285_1.talkMaxDuration = var_288_24

					if var_288_24 + var_288_18 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_24 + var_288_18
					end
				end

				arg_285_1.text_.text = var_288_21
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)
				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_25 = math.max(var_288_19, arg_285_1.talkMaxDuration)

			if var_288_18 <= arg_285_1.time_ and arg_285_1.time_ < var_288_18 + var_288_25 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_18) / var_288_25

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_18 + var_288_25 and arg_285_1.time_ < var_288_18 + var_288_25 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1156ui_story",
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
	Play322062071 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 322062071
		arg_289_1.duration_ = 5

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play322062072(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = 0
			local var_292_1 = 1.3

			if var_292_0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_0 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, false)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_2 = arg_289_1:GetWordFromCfg(322062071)
				local var_292_3 = arg_289_1:FormatText(var_292_2.content)

				arg_289_1.text_.text = var_292_3

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_4 = 52
				local var_292_5 = utf8.len(var_292_3)
				local var_292_6 = var_292_4 <= 0 and var_292_1 or var_292_1 * (var_292_5 / var_292_4)

				if var_292_6 > 0 and var_292_1 < var_292_6 then
					arg_289_1.talkMaxDuration = var_292_6

					if var_292_6 + var_292_0 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_6 + var_292_0
					end
				end

				arg_289_1.text_.text = var_292_3
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)
				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_7 = math.max(var_292_1, arg_289_1.talkMaxDuration)

			if var_292_0 <= arg_289_1.time_ and arg_289_1.time_ < var_292_0 + var_292_7 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_0) / var_292_7

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_0 + var_292_7 and arg_289_1.time_ < var_292_0 + var_292_7 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play322062072 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 322062072
		arg_293_1.duration_ = 4.03

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play322062073(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = arg_293_1.actors_["1156ui_story"].transform
			local var_296_1 = 0

			if var_296_1 < arg_293_1.time_ and arg_293_1.time_ <= var_296_1 + arg_296_0 then
				arg_293_1.var_.moveOldPos1156ui_story = var_296_0.localPosition
			end

			local var_296_2 = 0.001

			if var_296_1 <= arg_293_1.time_ and arg_293_1.time_ < var_296_1 + var_296_2 then
				local var_296_3 = (arg_293_1.time_ - var_296_1) / var_296_2
				local var_296_4 = Vector3.New(0, -1.1, -6.18)

				var_296_0.localPosition = Vector3.Lerp(arg_293_1.var_.moveOldPos1156ui_story, var_296_4, var_296_3)

				local var_296_5 = manager.ui.mainCamera.transform.position - var_296_0.position

				var_296_0.forward = Vector3.New(var_296_5.x, var_296_5.y, var_296_5.z)

				local var_296_6 = var_296_0.localEulerAngles

				var_296_6.z = 0
				var_296_6.x = 0
				var_296_0.localEulerAngles = var_296_6
			end

			if arg_293_1.time_ >= var_296_1 + var_296_2 and arg_293_1.time_ < var_296_1 + var_296_2 + arg_296_0 then
				var_296_0.localPosition = Vector3.New(0, -1.1, -6.18)

				local var_296_7 = manager.ui.mainCamera.transform.position - var_296_0.position

				var_296_0.forward = Vector3.New(var_296_7.x, var_296_7.y, var_296_7.z)

				local var_296_8 = var_296_0.localEulerAngles

				var_296_8.z = 0
				var_296_8.x = 0
				var_296_0.localEulerAngles = var_296_8
			end

			local var_296_9 = arg_293_1.actors_["1156ui_story"]
			local var_296_10 = 0

			if var_296_10 < arg_293_1.time_ and arg_293_1.time_ <= var_296_10 + arg_296_0 and not isNil(var_296_9) and arg_293_1.var_.characterEffect1156ui_story == nil then
				arg_293_1.var_.characterEffect1156ui_story = var_296_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_11 = 0.200000002980232

			if var_296_10 <= arg_293_1.time_ and arg_293_1.time_ < var_296_10 + var_296_11 and not isNil(var_296_9) then
				local var_296_12 = (arg_293_1.time_ - var_296_10) / var_296_11

				if arg_293_1.var_.characterEffect1156ui_story and not isNil(var_296_9) then
					arg_293_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_293_1.time_ >= var_296_10 + var_296_11 and arg_293_1.time_ < var_296_10 + var_296_11 + arg_296_0 and not isNil(var_296_9) and arg_293_1.var_.characterEffect1156ui_story then
				arg_293_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			local var_296_13 = 0

			if var_296_13 < arg_293_1.time_ and arg_293_1.time_ <= var_296_13 + arg_296_0 then
				arg_293_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action1_1")
			end

			local var_296_14 = 0

			if var_296_14 < arg_293_1.time_ and arg_293_1.time_ <= var_296_14 + arg_296_0 then
				arg_293_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_296_15 = 0
			local var_296_16 = 0.4

			if var_296_15 < arg_293_1.time_ and arg_293_1.time_ <= var_296_15 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				local var_296_17 = arg_293_1:FormatText(StoryNameCfg[605].name)

				arg_293_1.leftNameTxt_.text = var_296_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_18 = arg_293_1:GetWordFromCfg(322062072)
				local var_296_19 = arg_293_1:FormatText(var_296_18.content)

				arg_293_1.text_.text = var_296_19

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_20 = 16
				local var_296_21 = utf8.len(var_296_19)
				local var_296_22 = var_296_20 <= 0 and var_296_16 or var_296_16 * (var_296_21 / var_296_20)

				if var_296_22 > 0 and var_296_16 < var_296_22 then
					arg_293_1.talkMaxDuration = var_296_22

					if var_296_22 + var_296_15 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_22 + var_296_15
					end
				end

				arg_293_1.text_.text = var_296_19
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062072", "story_v_out_322062.awb") ~= 0 then
					local var_296_23 = manager.audio:GetVoiceLength("story_v_out_322062", "322062072", "story_v_out_322062.awb") / 1000

					if var_296_23 + var_296_15 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_23 + var_296_15
					end

					if var_296_18.prefab_name ~= "" and arg_293_1.actors_[var_296_18.prefab_name] ~= nil then
						local var_296_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_18.prefab_name].transform, "story_v_out_322062", "322062072", "story_v_out_322062.awb")

						arg_293_1:RecordAudio("322062072", var_296_24)
						arg_293_1:RecordAudio("322062072", var_296_24)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_out_322062", "322062072", "story_v_out_322062.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_out_322062", "322062072", "story_v_out_322062.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_25 = math.max(var_296_16, arg_293_1.talkMaxDuration)

			if var_296_15 <= arg_293_1.time_ and arg_293_1.time_ < var_296_15 + var_296_25 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_15) / var_296_25

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_15 + var_296_25 and arg_293_1.time_ < var_296_15 + var_296_25 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1156ui_story",
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
	Play322062073 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 322062073
		arg_297_1.duration_ = 14.5

		local var_297_0 = {
			zh = 13,
			ja = 14.5
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
				arg_297_0:Play322062074(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = "ST61a"

			if arg_297_1.bgs_[var_300_0] == nil then
				local var_300_1 = Object.Instantiate(arg_297_1.paintGo_)

				var_300_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_300_0)
				var_300_1.name = var_300_0
				var_300_1.transform.parent = arg_297_1.stage_.transform
				var_300_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_297_1.bgs_[var_300_0] = var_300_1
			end

			local var_300_2 = 2

			if var_300_2 < arg_297_1.time_ and arg_297_1.time_ <= var_300_2 + arg_300_0 then
				local var_300_3 = manager.ui.mainCamera.transform.localPosition
				local var_300_4 = Vector3.New(0, 0, 10) + Vector3.New(var_300_3.x, var_300_3.y, 0)
				local var_300_5 = arg_297_1.bgs_.ST61a

				var_300_5.transform.localPosition = var_300_4
				var_300_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_300_6 = var_300_5:GetComponent("SpriteRenderer")

				if var_300_6 and var_300_6.sprite then
					local var_300_7 = (var_300_5.transform.localPosition - var_300_3).z
					local var_300_8 = manager.ui.mainCameraCom_
					local var_300_9 = 2 * var_300_7 * Mathf.Tan(var_300_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_300_10 = var_300_9 * var_300_8.aspect
					local var_300_11 = var_300_6.sprite.bounds.size.x
					local var_300_12 = var_300_6.sprite.bounds.size.y
					local var_300_13 = var_300_10 / var_300_11
					local var_300_14 = var_300_9 / var_300_12
					local var_300_15 = var_300_14 < var_300_13 and var_300_13 or var_300_14

					var_300_5.transform.localScale = Vector3.New(var_300_15, var_300_15, 0)
				end

				for iter_300_0, iter_300_1 in pairs(arg_297_1.bgs_) do
					if iter_300_0 ~= "ST61a" then
						iter_300_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_300_16 = 4

			if var_300_16 < arg_297_1.time_ and arg_297_1.time_ <= var_300_16 + arg_300_0 then
				arg_297_1.allBtn_.enabled = false
			end

			local var_300_17 = 0.3

			if arg_297_1.time_ >= var_300_16 + var_300_17 and arg_297_1.time_ < var_300_16 + var_300_17 + arg_300_0 then
				arg_297_1.allBtn_.enabled = true
			end

			local var_300_18 = 0

			if var_300_18 < arg_297_1.time_ and arg_297_1.time_ <= var_300_18 + arg_300_0 then
				arg_297_1.mask_.enabled = true
				arg_297_1.mask_.raycastTarget = true

				arg_297_1:SetGaussion(false)
			end

			local var_300_19 = 2

			if var_300_18 <= arg_297_1.time_ and arg_297_1.time_ < var_300_18 + var_300_19 then
				local var_300_20 = (arg_297_1.time_ - var_300_18) / var_300_19
				local var_300_21 = Color.New(0, 0, 0)

				var_300_21.a = Mathf.Lerp(0, 1, var_300_20)
				arg_297_1.mask_.color = var_300_21
			end

			if arg_297_1.time_ >= var_300_18 + var_300_19 and arg_297_1.time_ < var_300_18 + var_300_19 + arg_300_0 then
				local var_300_22 = Color.New(0, 0, 0)

				var_300_22.a = 1
				arg_297_1.mask_.color = var_300_22
			end

			local var_300_23 = 2

			if var_300_23 < arg_297_1.time_ and arg_297_1.time_ <= var_300_23 + arg_300_0 then
				arg_297_1.mask_.enabled = true
				arg_297_1.mask_.raycastTarget = true

				arg_297_1:SetGaussion(false)
			end

			local var_300_24 = 2

			if var_300_23 <= arg_297_1.time_ and arg_297_1.time_ < var_300_23 + var_300_24 then
				local var_300_25 = (arg_297_1.time_ - var_300_23) / var_300_24
				local var_300_26 = Color.New(0, 0, 0)

				var_300_26.a = Mathf.Lerp(1, 0, var_300_25)
				arg_297_1.mask_.color = var_300_26
			end

			if arg_297_1.time_ >= var_300_23 + var_300_24 and arg_297_1.time_ < var_300_23 + var_300_24 + arg_300_0 then
				local var_300_27 = Color.New(0, 0, 0)
				local var_300_28 = 0

				arg_297_1.mask_.enabled = false
				var_300_27.a = var_300_28
				arg_297_1.mask_.color = var_300_27
			end

			local var_300_29 = arg_297_1.actors_["1156ui_story"].transform
			local var_300_30 = 1.96599999815226

			if var_300_30 < arg_297_1.time_ and arg_297_1.time_ <= var_300_30 + arg_300_0 then
				arg_297_1.var_.moveOldPos1156ui_story = var_300_29.localPosition
			end

			local var_300_31 = 0.001

			if var_300_30 <= arg_297_1.time_ and arg_297_1.time_ < var_300_30 + var_300_31 then
				local var_300_32 = (arg_297_1.time_ - var_300_30) / var_300_31
				local var_300_33 = Vector3.New(0, 100, 0)

				var_300_29.localPosition = Vector3.Lerp(arg_297_1.var_.moveOldPos1156ui_story, var_300_33, var_300_32)

				local var_300_34 = manager.ui.mainCamera.transform.position - var_300_29.position

				var_300_29.forward = Vector3.New(var_300_34.x, var_300_34.y, var_300_34.z)

				local var_300_35 = var_300_29.localEulerAngles

				var_300_35.z = 0
				var_300_35.x = 0
				var_300_29.localEulerAngles = var_300_35
			end

			if arg_297_1.time_ >= var_300_30 + var_300_31 and arg_297_1.time_ < var_300_30 + var_300_31 + arg_300_0 then
				var_300_29.localPosition = Vector3.New(0, 100, 0)

				local var_300_36 = manager.ui.mainCamera.transform.position - var_300_29.position

				var_300_29.forward = Vector3.New(var_300_36.x, var_300_36.y, var_300_36.z)

				local var_300_37 = var_300_29.localEulerAngles

				var_300_37.z = 0
				var_300_37.x = 0
				var_300_29.localEulerAngles = var_300_37
			end

			local var_300_38 = arg_297_1.actors_["1156ui_story"]
			local var_300_39 = 1.96599999815226

			if var_300_39 < arg_297_1.time_ and arg_297_1.time_ <= var_300_39 + arg_300_0 and not isNil(var_300_38) and arg_297_1.var_.characterEffect1156ui_story == nil then
				arg_297_1.var_.characterEffect1156ui_story = var_300_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_300_40 = 0.034000001847744

			if var_300_39 <= arg_297_1.time_ and arg_297_1.time_ < var_300_39 + var_300_40 and not isNil(var_300_38) then
				local var_300_41 = (arg_297_1.time_ - var_300_39) / var_300_40

				if arg_297_1.var_.characterEffect1156ui_story and not isNil(var_300_38) then
					local var_300_42 = Mathf.Lerp(0, 0.5, var_300_41)

					arg_297_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_297_1.var_.characterEffect1156ui_story.fillRatio = var_300_42
				end
			end

			if arg_297_1.time_ >= var_300_39 + var_300_40 and arg_297_1.time_ < var_300_39 + var_300_40 + arg_300_0 and not isNil(var_300_38) and arg_297_1.var_.characterEffect1156ui_story then
				local var_300_43 = 0.5

				arg_297_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_297_1.var_.characterEffect1156ui_story.fillRatio = var_300_43
			end

			local var_300_44 = 0.1
			local var_300_45 = 1

			if var_300_44 < arg_297_1.time_ and arg_297_1.time_ <= var_300_44 + arg_300_0 then
				local var_300_46 = "stop"
				local var_300_47 = "effect"

				arg_297_1:AudioAction(var_300_46, var_300_47, "se_story_145", "se_story_145_fire", "")
			end

			local var_300_48 = 1.53333333333333
			local var_300_49 = 1

			if var_300_48 < arg_297_1.time_ and arg_297_1.time_ <= var_300_48 + arg_300_0 then
				local var_300_50 = "play"
				local var_300_51 = "effect"

				arg_297_1:AudioAction(var_300_50, var_300_51, "se_story_141", "se_story_141_amb_street_night02", "")
			end

			local var_300_52 = 0
			local var_300_53 = 0.200000002980232

			if var_300_52 < arg_297_1.time_ and arg_297_1.time_ <= var_300_52 + arg_300_0 then
				local var_300_54 = "play"
				local var_300_55 = "music"

				arg_297_1:AudioAction(var_300_54, var_300_55, "ui_battle", "ui_battle_stopbgm", "")

				local var_300_56 = ""
				local var_300_57 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_300_57 ~= "" then
					if arg_297_1.bgmTxt_.text ~= var_300_57 and arg_297_1.bgmTxt_.text ~= "" then
						if arg_297_1.bgmTxt2_.text ~= "" then
							arg_297_1.bgmTxt_.text = arg_297_1.bgmTxt2_.text
						end

						arg_297_1.bgmTxt2_.text = var_300_57

						arg_297_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_297_1.bgmTxt_.text = var_300_57
						arg_297_1.bgmTxt2_.text = var_300_57
					end

					if arg_297_1.bgmTimer then
						arg_297_1.bgmTimer:Stop()

						arg_297_1.bgmTimer = nil
					end

					if arg_297_1.settingData.show_music_name == 1 then
						arg_297_1.musicController:SetSelectedState("show")
						arg_297_1.musicAnimator_:Play("open", 0, 0)

						if arg_297_1.settingData.music_time ~= 0 then
							arg_297_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_297_1.settingData.music_time), function()
								if arg_297_1 == nil or isNil(arg_297_1.bgmTxt_) then
									return
								end

								arg_297_1.musicController:SetSelectedState("hide")
								arg_297_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_300_58 = 0.433333333333333
			local var_300_59 = 1

			if var_300_58 < arg_297_1.time_ and arg_297_1.time_ <= var_300_58 + arg_300_0 then
				local var_300_60 = "play"
				local var_300_61 = "music"

				arg_297_1:AudioAction(var_300_60, var_300_61, "bgm_activity_4_5_story_serious", "bgm_activity_4_5_story_serious", "bgm_activity_4_5_story_serious.awb")

				local var_300_62 = ""
				local var_300_63 = manager.audio:GetAudioName("bgm_activity_4_5_story_serious", "bgm_activity_4_5_story_serious")

				if var_300_63 ~= "" then
					if arg_297_1.bgmTxt_.text ~= var_300_63 and arg_297_1.bgmTxt_.text ~= "" then
						if arg_297_1.bgmTxt2_.text ~= "" then
							arg_297_1.bgmTxt_.text = arg_297_1.bgmTxt2_.text
						end

						arg_297_1.bgmTxt2_.text = var_300_63

						arg_297_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_297_1.bgmTxt_.text = var_300_63
						arg_297_1.bgmTxt2_.text = var_300_63
					end

					if arg_297_1.bgmTimer then
						arg_297_1.bgmTimer:Stop()

						arg_297_1.bgmTimer = nil
					end

					if arg_297_1.settingData.show_music_name == 1 then
						arg_297_1.musicController:SetSelectedState("show")
						arg_297_1.musicAnimator_:Play("open", 0, 0)

						if arg_297_1.settingData.music_time ~= 0 then
							arg_297_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_297_1.settingData.music_time), function()
								if arg_297_1 == nil or isNil(arg_297_1.bgmTxt_) then
									return
								end

								arg_297_1.musicController:SetSelectedState("hide")
								arg_297_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_300_64 = 0.44
			local var_300_65 = 1

			if var_300_64 < arg_297_1.time_ and arg_297_1.time_ <= var_300_64 + arg_300_0 then
				local var_300_66 = "play"
				local var_300_67 = "music"

				arg_297_1:AudioAction(var_300_66, var_300_67, "bgm_activity_4_5_story_serious", "init_story", "bgm_activity_4_5_story_serious.awb")

				local var_300_68 = ""
				local var_300_69 = manager.audio:GetAudioName("bgm_activity_4_5_story_serious", "init_story")

				if var_300_69 ~= "" then
					if arg_297_1.bgmTxt_.text ~= var_300_69 and arg_297_1.bgmTxt_.text ~= "" then
						if arg_297_1.bgmTxt2_.text ~= "" then
							arg_297_1.bgmTxt_.text = arg_297_1.bgmTxt2_.text
						end

						arg_297_1.bgmTxt2_.text = var_300_69

						arg_297_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_297_1.bgmTxt_.text = var_300_69
						arg_297_1.bgmTxt2_.text = var_300_69
					end

					if arg_297_1.bgmTimer then
						arg_297_1.bgmTimer:Stop()

						arg_297_1.bgmTimer = nil
					end

					if arg_297_1.settingData.show_music_name == 1 then
						arg_297_1.musicController:SetSelectedState("show")
						arg_297_1.musicAnimator_:Play("open", 0, 0)

						if arg_297_1.settingData.music_time ~= 0 then
							arg_297_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_297_1.settingData.music_time), function()
								if arg_297_1 == nil or isNil(arg_297_1.bgmTxt_) then
									return
								end

								arg_297_1.musicController:SetSelectedState("hide")
								arg_297_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_297_1.frameCnt_ <= 1 then
				arg_297_1.dialog_:SetActive(false)
			end

			local var_300_70 = 4
			local var_300_71 = 0.975

			if var_300_70 < arg_297_1.time_ and arg_297_1.time_ <= var_300_70 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0

				arg_297_1.dialog_:SetActive(true)

				arg_297_1.dialogCg_.alpha = 0

				local var_300_72 = LeanTween.value(arg_297_1.dialog_, 0, 1, 0.3)

				var_300_72:setOnUpdate(LuaHelper.FloatAction(function(arg_304_0)
					arg_297_1.dialogCg_.alpha = arg_304_0
				end))
				var_300_72:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_297_1.dialog_)
					var_300_72:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_297_1.duration_ = arg_297_1.duration_ + 0.3

				SetActive(arg_297_1.leftNameGo_, true)

				local var_300_73 = arg_297_1:FormatText(StoryNameCfg[36].name)

				arg_297_1.leftNameTxt_.text = var_300_73

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, true)
				arg_297_1.iconController_:SetSelectedState("hero")

				arg_297_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_297_1.callingController_:SetSelectedState("normal")

				arg_297_1.keyicon_.color = Color.New(1, 1, 1)
				arg_297_1.icon_.color = Color.New(1, 1, 1)

				local var_300_74 = arg_297_1:GetWordFromCfg(322062073)
				local var_300_75 = arg_297_1:FormatText(var_300_74.content)

				arg_297_1.text_.text = var_300_75

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_76 = 39
				local var_300_77 = utf8.len(var_300_75)
				local var_300_78 = var_300_76 <= 0 and var_300_71 or var_300_71 * (var_300_77 / var_300_76)

				if var_300_78 > 0 and var_300_71 < var_300_78 then
					arg_297_1.talkMaxDuration = var_300_78
					var_300_70 = var_300_70 + 0.3

					if var_300_78 + var_300_70 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_78 + var_300_70
					end
				end

				arg_297_1.text_.text = var_300_75
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062073", "story_v_out_322062.awb") ~= 0 then
					local var_300_79 = manager.audio:GetVoiceLength("story_v_out_322062", "322062073", "story_v_out_322062.awb") / 1000

					if var_300_79 + var_300_70 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_79 + var_300_70
					end

					if var_300_74.prefab_name ~= "" and arg_297_1.actors_[var_300_74.prefab_name] ~= nil then
						local var_300_80 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_74.prefab_name].transform, "story_v_out_322062", "322062073", "story_v_out_322062.awb")

						arg_297_1:RecordAudio("322062073", var_300_80)
						arg_297_1:RecordAudio("322062073", var_300_80)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_out_322062", "322062073", "story_v_out_322062.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_out_322062", "322062073", "story_v_out_322062.awb")
				end

				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_81 = var_300_70 + 0.3
			local var_300_82 = math.max(var_300_71, arg_297_1.talkMaxDuration)

			if var_300_81 <= arg_297_1.time_ and arg_297_1.time_ < var_300_81 + var_300_82 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_81) / var_300_82

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_81 + var_300_82 and arg_297_1.time_ < var_300_81 + var_300_82 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1156ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_297_1:InitPlayNodeList()
	end,
	Play322062074 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 322062074
		arg_306_1.duration_ = 9.07

		local var_306_0 = {
			zh = 6.6,
			ja = 9.066
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
				arg_306_0:Play322062075(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			local var_309_0 = "1089ui_story"

			if arg_306_1.actors_[var_309_0] == nil then
				local var_309_1 = Asset.Load("Char/" .. "1089ui_story")

				if not isNil(var_309_1) then
					local var_309_2 = Object.Instantiate(Asset.Load("Char/" .. "1089ui_story"), arg_306_1.stage_.transform)

					var_309_2.name = var_309_0
					var_309_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_306_1.actors_[var_309_0] = var_309_2

					local var_309_3 = var_309_2:GetComponentInChildren(typeof(CharacterEffect))

					var_309_3.enabled = true

					local var_309_4 = GameObjectTools.GetOrAddComponent(var_309_2, typeof(DynamicBoneHelper))

					if var_309_4 then
						var_309_4:EnableDynamicBone(false)
					end

					arg_306_1:ShowWeapon(var_309_3.transform, false)

					arg_306_1.var_[var_309_0 .. "Animator"] = var_309_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_306_1.var_[var_309_0 .. "Animator"].applyRootMotion = true
					arg_306_1.var_[var_309_0 .. "LipSync"] = var_309_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_309_5 = arg_306_1.actors_["1089ui_story"].transform
			local var_309_6 = 0

			if var_309_6 < arg_306_1.time_ and arg_306_1.time_ <= var_309_6 + arg_309_0 then
				arg_306_1.var_.moveOldPos1089ui_story = var_309_5.localPosition
			end

			local var_309_7 = 0.001

			if var_309_6 <= arg_306_1.time_ and arg_306_1.time_ < var_309_6 + var_309_7 then
				local var_309_8 = (arg_306_1.time_ - var_309_6) / var_309_7
				local var_309_9 = Vector3.New(0, -1.1, -6.17)

				var_309_5.localPosition = Vector3.Lerp(arg_306_1.var_.moveOldPos1089ui_story, var_309_9, var_309_8)

				local var_309_10 = manager.ui.mainCamera.transform.position - var_309_5.position

				var_309_5.forward = Vector3.New(var_309_10.x, var_309_10.y, var_309_10.z)

				local var_309_11 = var_309_5.localEulerAngles

				var_309_11.z = 0
				var_309_11.x = 0
				var_309_5.localEulerAngles = var_309_11
			end

			if arg_306_1.time_ >= var_309_6 + var_309_7 and arg_306_1.time_ < var_309_6 + var_309_7 + arg_309_0 then
				var_309_5.localPosition = Vector3.New(0, -1.1, -6.17)

				local var_309_12 = manager.ui.mainCamera.transform.position - var_309_5.position

				var_309_5.forward = Vector3.New(var_309_12.x, var_309_12.y, var_309_12.z)

				local var_309_13 = var_309_5.localEulerAngles

				var_309_13.z = 0
				var_309_13.x = 0
				var_309_5.localEulerAngles = var_309_13
			end

			local var_309_14 = arg_306_1.actors_["1089ui_story"]
			local var_309_15 = 0

			if var_309_15 < arg_306_1.time_ and arg_306_1.time_ <= var_309_15 + arg_309_0 and not isNil(var_309_14) and arg_306_1.var_.characterEffect1089ui_story == nil then
				arg_306_1.var_.characterEffect1089ui_story = var_309_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_309_16 = 0.200000002980232

			if var_309_15 <= arg_306_1.time_ and arg_306_1.time_ < var_309_15 + var_309_16 and not isNil(var_309_14) then
				local var_309_17 = (arg_306_1.time_ - var_309_15) / var_309_16

				if arg_306_1.var_.characterEffect1089ui_story and not isNil(var_309_14) then
					arg_306_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_306_1.time_ >= var_309_15 + var_309_16 and arg_306_1.time_ < var_309_15 + var_309_16 + arg_309_0 and not isNil(var_309_14) and arg_306_1.var_.characterEffect1089ui_story then
				arg_306_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_309_18 = 0

			if var_309_18 < arg_306_1.time_ and arg_306_1.time_ <= var_309_18 + arg_309_0 then
				arg_306_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action7_1")
			end

			local var_309_19 = 0

			if var_309_19 < arg_306_1.time_ and arg_306_1.time_ <= var_309_19 + arg_309_0 then
				arg_306_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_309_20 = 0
			local var_309_21 = 0.575

			if var_309_20 < arg_306_1.time_ and arg_306_1.time_ <= var_309_20 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, true)

				local var_309_22 = arg_306_1:FormatText(StoryNameCfg[1031].name)

				arg_306_1.leftNameTxt_.text = var_309_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_306_1.leftNameTxt_.transform)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1.leftNameTxt_.text)
				SetActive(arg_306_1.iconTrs_.gameObject, false)
				arg_306_1.callingController_:SetSelectedState("normal")

				local var_309_23 = arg_306_1:GetWordFromCfg(322062074)
				local var_309_24 = arg_306_1:FormatText(var_309_23.content)

				arg_306_1.text_.text = var_309_24

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_25 = 23
				local var_309_26 = utf8.len(var_309_24)
				local var_309_27 = var_309_25 <= 0 and var_309_21 or var_309_21 * (var_309_26 / var_309_25)

				if var_309_27 > 0 and var_309_21 < var_309_27 then
					arg_306_1.talkMaxDuration = var_309_27

					if var_309_27 + var_309_20 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_27 + var_309_20
					end
				end

				arg_306_1.text_.text = var_309_24
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062074", "story_v_out_322062.awb") ~= 0 then
					local var_309_28 = manager.audio:GetVoiceLength("story_v_out_322062", "322062074", "story_v_out_322062.awb") / 1000

					if var_309_28 + var_309_20 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_28 + var_309_20
					end

					if var_309_23.prefab_name ~= "" and arg_306_1.actors_[var_309_23.prefab_name] ~= nil then
						local var_309_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_306_1.actors_[var_309_23.prefab_name].transform, "story_v_out_322062", "322062074", "story_v_out_322062.awb")

						arg_306_1:RecordAudio("322062074", var_309_29)
						arg_306_1:RecordAudio("322062074", var_309_29)
					else
						arg_306_1:AudioAction("play", "voice", "story_v_out_322062", "322062074", "story_v_out_322062.awb")
					end

					arg_306_1:RecordHistoryTalkVoice("story_v_out_322062", "322062074", "story_v_out_322062.awb")
				end

				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_30 = math.max(var_309_21, arg_306_1.talkMaxDuration)

			if var_309_20 <= arg_306_1.time_ and arg_306_1.time_ < var_309_20 + var_309_30 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - var_309_20) / var_309_30

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= var_309_20 + var_309_30 and arg_306_1.time_ < var_309_20 + var_309_30 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
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
	Play322062075 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 322062075
		arg_310_1.duration_ = 8.93

		local var_310_0 = {
			zh = 6.9,
			ja = 8.933
		}
		local var_310_1 = manager.audio:GetLocalizationFlag()

		if var_310_0[var_310_1] ~= nil then
			arg_310_1.duration_ = var_310_0[var_310_1]
		end

		SetActive(arg_310_1.tipsGo_, false)

		function arg_310_1.onSingleLineFinish_()
			arg_310_1.onSingleLineUpdate_ = nil
			arg_310_1.onSingleLineFinish_ = nil
			arg_310_1.state_ = "waiting"
		end

		function arg_310_1.playNext_(arg_312_0)
			if arg_312_0 == 1 then
				arg_310_0:Play322062076(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			local var_313_0 = arg_310_1.actors_["1089ui_story"]
			local var_313_1 = 0

			if var_313_1 < arg_310_1.time_ and arg_310_1.time_ <= var_313_1 + arg_313_0 and not isNil(var_313_0) and arg_310_1.var_.characterEffect1089ui_story == nil then
				arg_310_1.var_.characterEffect1089ui_story = var_313_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_313_2 = 0.200000002980232

			if var_313_1 <= arg_310_1.time_ and arg_310_1.time_ < var_313_1 + var_313_2 and not isNil(var_313_0) then
				local var_313_3 = (arg_310_1.time_ - var_313_1) / var_313_2

				if arg_310_1.var_.characterEffect1089ui_story and not isNil(var_313_0) then
					local var_313_4 = Mathf.Lerp(0, 0.5, var_313_3)

					arg_310_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_310_1.var_.characterEffect1089ui_story.fillRatio = var_313_4
				end
			end

			if arg_310_1.time_ >= var_313_1 + var_313_2 and arg_310_1.time_ < var_313_1 + var_313_2 + arg_313_0 and not isNil(var_313_0) and arg_310_1.var_.characterEffect1089ui_story then
				local var_313_5 = 0.5

				arg_310_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_310_1.var_.characterEffect1089ui_story.fillRatio = var_313_5
			end

			local var_313_6 = 0
			local var_313_7 = 0.75

			if var_313_6 < arg_310_1.time_ and arg_310_1.time_ <= var_313_6 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0
				arg_310_1.dialogCg_.alpha = 1

				arg_310_1.dialog_:SetActive(true)
				SetActive(arg_310_1.leftNameGo_, true)

				local var_313_8 = arg_310_1:FormatText(StoryNameCfg[36].name)

				arg_310_1.leftNameTxt_.text = var_313_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_310_1.leftNameTxt_.transform)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1.leftNameTxt_.text)
				SetActive(arg_310_1.iconTrs_.gameObject, true)
				arg_310_1.iconController_:SetSelectedState("hero")

				arg_310_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_310_1.callingController_:SetSelectedState("normal")

				arg_310_1.keyicon_.color = Color.New(1, 1, 1)
				arg_310_1.icon_.color = Color.New(1, 1, 1)

				local var_313_9 = arg_310_1:GetWordFromCfg(322062075)
				local var_313_10 = arg_310_1:FormatText(var_313_9.content)

				arg_310_1.text_.text = var_313_10

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_11 = 30
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

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062075", "story_v_out_322062.awb") ~= 0 then
					local var_313_14 = manager.audio:GetVoiceLength("story_v_out_322062", "322062075", "story_v_out_322062.awb") / 1000

					if var_313_14 + var_313_6 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_14 + var_313_6
					end

					if var_313_9.prefab_name ~= "" and arg_310_1.actors_[var_313_9.prefab_name] ~= nil then
						local var_313_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_310_1.actors_[var_313_9.prefab_name].transform, "story_v_out_322062", "322062075", "story_v_out_322062.awb")

						arg_310_1:RecordAudio("322062075", var_313_15)
						arg_310_1:RecordAudio("322062075", var_313_15)
					else
						arg_310_1:AudioAction("play", "voice", "story_v_out_322062", "322062075", "story_v_out_322062.awb")
					end

					arg_310_1:RecordHistoryTalkVoice("story_v_out_322062", "322062075", "story_v_out_322062.awb")
				end

				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_16 = math.max(var_313_7, arg_310_1.talkMaxDuration)

			if var_313_6 <= arg_310_1.time_ and arg_310_1.time_ < var_313_6 + var_313_16 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - var_313_6) / var_313_16

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= var_313_6 + var_313_16 and arg_310_1.time_ < var_313_6 + var_313_16 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {}

		arg_310_1:InitPlayNodeList()
	end,
	Play322062076 = function(arg_314_0, arg_314_1)
		arg_314_1.time_ = 0
		arg_314_1.frameCnt_ = 0
		arg_314_1.state_ = "playing"
		arg_314_1.curTalkId_ = 322062076
		arg_314_1.duration_ = 6.9

		local var_314_0 = {
			zh = 5.933,
			ja = 6.9
		}
		local var_314_1 = manager.audio:GetLocalizationFlag()

		if var_314_0[var_314_1] ~= nil then
			arg_314_1.duration_ = var_314_0[var_314_1]
		end

		SetActive(arg_314_1.tipsGo_, false)

		function arg_314_1.onSingleLineFinish_()
			arg_314_1.onSingleLineUpdate_ = nil
			arg_314_1.onSingleLineFinish_ = nil
			arg_314_1.state_ = "waiting"
		end

		function arg_314_1.playNext_(arg_316_0)
			if arg_316_0 == 1 then
				arg_314_0:Play322062077(arg_314_1)
			end
		end

		function arg_314_1.onSingleLineUpdate_(arg_317_0)
			local var_317_0 = arg_314_1.actors_["1089ui_story"]
			local var_317_1 = 0

			if var_317_1 < arg_314_1.time_ and arg_314_1.time_ <= var_317_1 + arg_317_0 and not isNil(var_317_0) and arg_314_1.var_.characterEffect1089ui_story == nil then
				arg_314_1.var_.characterEffect1089ui_story = var_317_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_317_2 = 0.200000002980232

			if var_317_1 <= arg_314_1.time_ and arg_314_1.time_ < var_317_1 + var_317_2 and not isNil(var_317_0) then
				local var_317_3 = (arg_314_1.time_ - var_317_1) / var_317_2

				if arg_314_1.var_.characterEffect1089ui_story and not isNil(var_317_0) then
					arg_314_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_314_1.time_ >= var_317_1 + var_317_2 and arg_314_1.time_ < var_317_1 + var_317_2 + arg_317_0 and not isNil(var_317_0) and arg_314_1.var_.characterEffect1089ui_story then
				arg_314_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_317_4 = 0

			if var_317_4 < arg_314_1.time_ and arg_314_1.time_ <= var_317_4 + arg_317_0 then
				arg_314_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action7_2")
			end

			local var_317_5 = 0
			local var_317_6 = 0.625

			if var_317_5 < arg_314_1.time_ and arg_314_1.time_ <= var_317_5 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0
				arg_314_1.dialogCg_.alpha = 1

				arg_314_1.dialog_:SetActive(true)
				SetActive(arg_314_1.leftNameGo_, true)

				local var_317_7 = arg_314_1:FormatText(StoryNameCfg[1031].name)

				arg_314_1.leftNameTxt_.text = var_317_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_314_1.leftNameTxt_.transform)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1.leftNameTxt_.text)
				SetActive(arg_314_1.iconTrs_.gameObject, false)
				arg_314_1.callingController_:SetSelectedState("normal")

				local var_317_8 = arg_314_1:GetWordFromCfg(322062076)
				local var_317_9 = arg_314_1:FormatText(var_317_8.content)

				arg_314_1.text_.text = var_317_9

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_10 = 25
				local var_317_11 = utf8.len(var_317_9)
				local var_317_12 = var_317_10 <= 0 and var_317_6 or var_317_6 * (var_317_11 / var_317_10)

				if var_317_12 > 0 and var_317_6 < var_317_12 then
					arg_314_1.talkMaxDuration = var_317_12

					if var_317_12 + var_317_5 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_12 + var_317_5
					end
				end

				arg_314_1.text_.text = var_317_9
				arg_314_1.typewritter.percent = 0

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062076", "story_v_out_322062.awb") ~= 0 then
					local var_317_13 = manager.audio:GetVoiceLength("story_v_out_322062", "322062076", "story_v_out_322062.awb") / 1000

					if var_317_13 + var_317_5 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_13 + var_317_5
					end

					if var_317_8.prefab_name ~= "" and arg_314_1.actors_[var_317_8.prefab_name] ~= nil then
						local var_317_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_314_1.actors_[var_317_8.prefab_name].transform, "story_v_out_322062", "322062076", "story_v_out_322062.awb")

						arg_314_1:RecordAudio("322062076", var_317_14)
						arg_314_1:RecordAudio("322062076", var_317_14)
					else
						arg_314_1:AudioAction("play", "voice", "story_v_out_322062", "322062076", "story_v_out_322062.awb")
					end

					arg_314_1:RecordHistoryTalkVoice("story_v_out_322062", "322062076", "story_v_out_322062.awb")
				end

				arg_314_1:RecordContent(arg_314_1.text_.text)
			end

			local var_317_15 = math.max(var_317_6, arg_314_1.talkMaxDuration)

			if var_317_5 <= arg_314_1.time_ and arg_314_1.time_ < var_317_5 + var_317_15 then
				arg_314_1.typewritter.percent = (arg_314_1.time_ - var_317_5) / var_317_15

				arg_314_1.typewritter:SetDirty()
			end

			if arg_314_1.time_ >= var_317_5 + var_317_15 and arg_314_1.time_ < var_317_5 + var_317_15 + arg_317_0 then
				arg_314_1.typewritter.percent = 1

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(true)
			end
		end

		arg_314_1.nodeConfigList_ = {}

		arg_314_1:InitPlayNodeList()
	end,
	Play322062077 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 322062077
		arg_318_1.duration_ = 5

		SetActive(arg_318_1.tipsGo_, false)

		function arg_318_1.onSingleLineFinish_()
			arg_318_1.onSingleLineUpdate_ = nil
			arg_318_1.onSingleLineFinish_ = nil
			arg_318_1.state_ = "waiting"
		end

		function arg_318_1.playNext_(arg_320_0)
			if arg_320_0 == 1 then
				arg_318_0:Play322062078(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			local var_321_0 = arg_318_1.actors_["1089ui_story"].transform
			local var_321_1 = 0

			if var_321_1 < arg_318_1.time_ and arg_318_1.time_ <= var_321_1 + arg_321_0 then
				arg_318_1.var_.moveOldPos1089ui_story = var_321_0.localPosition
			end

			local var_321_2 = 0.001

			if var_321_1 <= arg_318_1.time_ and arg_318_1.time_ < var_321_1 + var_321_2 then
				local var_321_3 = (arg_318_1.time_ - var_321_1) / var_321_2
				local var_321_4 = Vector3.New(0, 100, 0)

				var_321_0.localPosition = Vector3.Lerp(arg_318_1.var_.moveOldPos1089ui_story, var_321_4, var_321_3)

				local var_321_5 = manager.ui.mainCamera.transform.position - var_321_0.position

				var_321_0.forward = Vector3.New(var_321_5.x, var_321_5.y, var_321_5.z)

				local var_321_6 = var_321_0.localEulerAngles

				var_321_6.z = 0
				var_321_6.x = 0
				var_321_0.localEulerAngles = var_321_6
			end

			if arg_318_1.time_ >= var_321_1 + var_321_2 and arg_318_1.time_ < var_321_1 + var_321_2 + arg_321_0 then
				var_321_0.localPosition = Vector3.New(0, 100, 0)

				local var_321_7 = manager.ui.mainCamera.transform.position - var_321_0.position

				var_321_0.forward = Vector3.New(var_321_7.x, var_321_7.y, var_321_7.z)

				local var_321_8 = var_321_0.localEulerAngles

				var_321_8.z = 0
				var_321_8.x = 0
				var_321_0.localEulerAngles = var_321_8
			end

			local var_321_9 = 0
			local var_321_10 = 1.425

			if var_321_9 < arg_318_1.time_ and arg_318_1.time_ <= var_321_9 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, false)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_318_1.iconTrs_.gameObject, false)
				arg_318_1.callingController_:SetSelectedState("normal")

				local var_321_11 = arg_318_1:GetWordFromCfg(322062077)
				local var_321_12 = arg_318_1:FormatText(var_321_11.content)

				arg_318_1.text_.text = var_321_12

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_13 = 57
				local var_321_14 = utf8.len(var_321_12)
				local var_321_15 = var_321_13 <= 0 and var_321_10 or var_321_10 * (var_321_14 / var_321_13)

				if var_321_15 > 0 and var_321_10 < var_321_15 then
					arg_318_1.talkMaxDuration = var_321_15

					if var_321_15 + var_321_9 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_15 + var_321_9
					end
				end

				arg_318_1.text_.text = var_321_12
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)
				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_16 = math.max(var_321_10, arg_318_1.talkMaxDuration)

			if var_321_9 <= arg_318_1.time_ and arg_318_1.time_ < var_321_9 + var_321_16 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - var_321_9) / var_321_16

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= var_321_9 + var_321_16 and arg_318_1.time_ < var_321_9 + var_321_16 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_318_1:InitPlayNodeList()
	end,
	Play322062078 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 322062078
		arg_322_1.duration_ = 14.47

		local var_322_0 = {
			zh = 8.333,
			ja = 14.466
		}
		local var_322_1 = manager.audio:GetLocalizationFlag()

		if var_322_0[var_322_1] ~= nil then
			arg_322_1.duration_ = var_322_0[var_322_1]
		end

		SetActive(arg_322_1.tipsGo_, false)

		function arg_322_1.onSingleLineFinish_()
			arg_322_1.onSingleLineUpdate_ = nil
			arg_322_1.onSingleLineFinish_ = nil
			arg_322_1.state_ = "waiting"
		end

		function arg_322_1.playNext_(arg_324_0)
			if arg_324_0 == 1 then
				arg_322_0:Play322062079(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			local var_325_0 = "10103ui_story"

			if arg_322_1.actors_[var_325_0] == nil then
				local var_325_1 = Asset.Load("Char/" .. "10103ui_story")

				if not isNil(var_325_1) then
					local var_325_2 = Object.Instantiate(Asset.Load("Char/" .. "10103ui_story"), arg_322_1.stage_.transform)

					var_325_2.name = var_325_0
					var_325_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_322_1.actors_[var_325_0] = var_325_2

					local var_325_3 = var_325_2:GetComponentInChildren(typeof(CharacterEffect))

					var_325_3.enabled = true

					local var_325_4 = GameObjectTools.GetOrAddComponent(var_325_2, typeof(DynamicBoneHelper))

					if var_325_4 then
						var_325_4:EnableDynamicBone(false)
					end

					arg_322_1:ShowWeapon(var_325_3.transform, false)

					arg_322_1.var_[var_325_0 .. "Animator"] = var_325_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_322_1.var_[var_325_0 .. "Animator"].applyRootMotion = true
					arg_322_1.var_[var_325_0 .. "LipSync"] = var_325_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_325_5 = arg_322_1.actors_["10103ui_story"].transform
			local var_325_6 = 1.01666666666667

			if var_325_6 < arg_322_1.time_ and arg_322_1.time_ <= var_325_6 + arg_325_0 then
				arg_322_1.var_.moveOldPos10103ui_story = var_325_5.localPosition

				local var_325_7 = GameObjectTools.GetOrAddComponent(var_325_5.gameObject, typeof(DynamicBoneHelper))

				if var_325_7 then
					var_325_7:EnableDynamicBone(false)
				end
			end

			local var_325_8 = 0.001

			if var_325_6 <= arg_322_1.time_ and arg_322_1.time_ < var_325_6 + var_325_8 then
				local var_325_9 = (arg_322_1.time_ - var_325_6) / var_325_8
				local var_325_10 = Vector3.New(0, -0.95, -6.2)

				var_325_5.localPosition = Vector3.Lerp(arg_322_1.var_.moveOldPos10103ui_story, var_325_10, var_325_9)

				local var_325_11 = manager.ui.mainCamera.transform.position - var_325_5.position

				var_325_5.forward = Vector3.New(var_325_11.x, var_325_11.y, var_325_11.z)

				local var_325_12 = var_325_5.localEulerAngles

				var_325_12.z = 0
				var_325_12.x = 0
				var_325_5.localEulerAngles = var_325_12
			end

			if arg_322_1.time_ >= var_325_6 + var_325_8 and arg_322_1.time_ < var_325_6 + var_325_8 + arg_325_0 then
				var_325_5.localPosition = Vector3.New(0, -0.95, -6.2)

				local var_325_13 = manager.ui.mainCamera.transform.position - var_325_5.position

				var_325_5.forward = Vector3.New(var_325_13.x, var_325_13.y, var_325_13.z)

				local var_325_14 = var_325_5.localEulerAngles

				var_325_14.z = 0
				var_325_14.x = 0
				var_325_5.localEulerAngles = var_325_14

				local var_325_15 = GameObjectTools.GetOrAddComponent(var_325_5.gameObject, typeof(DynamicBoneHelper))

				if var_325_15 then
					var_325_15:EnableDynamicBone(true)
				end
			end

			local var_325_16 = arg_322_1.actors_["10103ui_story"]
			local var_325_17 = 1.01666666666667

			if var_325_17 < arg_322_1.time_ and arg_322_1.time_ <= var_325_17 + arg_325_0 and not isNil(var_325_16) and arg_322_1.var_.characterEffect10103ui_story == nil then
				arg_322_1.var_.characterEffect10103ui_story = var_325_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_325_18 = 0.200000002980232

			if var_325_17 <= arg_322_1.time_ and arg_322_1.time_ < var_325_17 + var_325_18 and not isNil(var_325_16) then
				local var_325_19 = (arg_322_1.time_ - var_325_17) / var_325_18

				if arg_322_1.var_.characterEffect10103ui_story and not isNil(var_325_16) then
					arg_322_1.var_.characterEffect10103ui_story.fillFlat = false
				end
			end

			if arg_322_1.time_ >= var_325_17 + var_325_18 and arg_322_1.time_ < var_325_17 + var_325_18 + arg_325_0 and not isNil(var_325_16) and arg_322_1.var_.characterEffect10103ui_story then
				arg_322_1.var_.characterEffect10103ui_story.fillFlat = false
			end

			local var_325_20 = 1.01666666666667

			if var_325_20 < arg_322_1.time_ and arg_322_1.time_ <= var_325_20 + arg_325_0 then
				arg_322_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/story10103/story10103action/10103action1_1")
			end

			local var_325_21 = 1.01666666666667

			if var_325_21 < arg_322_1.time_ and arg_322_1.time_ <= var_325_21 + arg_325_0 then
				arg_322_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_325_22 = manager.ui.mainCamera.transform
			local var_325_23 = 1.01666666666667

			if var_325_23 < arg_322_1.time_ and arg_322_1.time_ <= var_325_23 + arg_325_0 then
				local var_325_24 = arg_322_1.var_.effect078
				local var_325_25
				local var_325_26 = var_325_22

				if not var_325_24 then
					var_325_24 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_monitor"), var_325_26)
					var_325_24.name = "078"
					arg_322_1.var_.effect078 = var_325_24
				else
					var_325_24.transform:SetParent(var_325_26)
				end

				var_325_24.transform.localPosition = Vector3.New(0, 0, -3)
				var_325_24.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_325_27 = manager.ui.mainCameraCom_
				local var_325_28 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_325_27.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_325_29 = var_325_24.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_325_30 = 15
				local var_325_31 = 2 * var_325_30 * Mathf.Tan(var_325_27.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_325_27.aspect
				local var_325_32 = 1
				local var_325_33 = 1.7777777777777777

				if var_325_33 < var_325_27.aspect then
					var_325_32 = var_325_31 / (2 * var_325_30 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_325_33)
				end

				for iter_325_0, iter_325_1 in ipairs(var_325_29) do
					local var_325_34 = iter_325_1.transform.localScale

					iter_325_1.transform.localScale = Vector3.New(var_325_34.x / var_325_28 * var_325_32, var_325_34.y / var_325_28, var_325_34.z)
				end
			end

			local var_325_35 = manager.ui.mainCamera.transform
			local var_325_36 = 1

			if var_325_36 < arg_322_1.time_ and arg_322_1.time_ <= var_325_36 + arg_325_0 then
				local var_325_37 = arg_322_1.var_.effect0781
				local var_325_38
				local var_325_39 = var_325_35

				if not var_325_37 then
					var_325_37 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_vignetting"), var_325_39)
					var_325_37.name = "0781"
					arg_322_1.var_.effect0781 = var_325_37
				else
					var_325_37.transform:SetParent(var_325_39)
				end

				var_325_37.transform.localPosition = Vector3.New(0, 0, -1)
				var_325_37.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_325_40 = manager.ui.mainCameraCom_
				local var_325_41 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_325_40.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_325_42 = var_325_37.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_325_43 = 15
				local var_325_44 = 2 * var_325_43 * Mathf.Tan(var_325_40.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_325_40.aspect
				local var_325_45 = 1
				local var_325_46 = 1.7777777777777777

				if var_325_46 < var_325_40.aspect then
					var_325_45 = var_325_44 / (2 * var_325_43 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_325_46)
				end

				for iter_325_2, iter_325_3 in ipairs(var_325_42) do
					local var_325_47 = iter_325_3.transform.localScale

					iter_325_3.transform.localScale = Vector3.New(var_325_47.x / var_325_41 * var_325_45, var_325_47.y / var_325_41, var_325_47.z)
				end
			end

			local var_325_48 = 1.01666666666667

			if var_325_48 < arg_322_1.time_ and arg_322_1.time_ <= var_325_48 + arg_325_0 then
				local var_325_49 = arg_322_1.actors_["10103ui_story"]

				if not isNil(var_325_49) then
					local var_325_50 = GameObjectTools.GetOrAddComponent(var_325_49, typeof(DynamicBoneHelper))

					if var_325_50 then
						var_325_50:EnableDynamicBone(true)
					end
				end
			end

			local var_325_51 = 1

			arg_322_1.isInRecall_ = false

			if var_325_51 < arg_322_1.time_ and arg_322_1.time_ <= var_325_51 + arg_325_0 then
				arg_322_1.screenFilterGo_:SetActive(true)

				arg_322_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_blue.asset")

				for iter_325_4, iter_325_5 in pairs(arg_322_1.actors_) do
					local var_325_52 = iter_325_5:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_325_6, iter_325_7 in ipairs(var_325_52) do
						if iter_325_7.color.r > 0.51 then
							iter_325_7.color = Color.New(1, 1, 1)
						else
							iter_325_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_325_53 = 0.0166666666666667

			if var_325_51 <= arg_322_1.time_ and arg_322_1.time_ < var_325_51 + var_325_53 then
				local var_325_54 = (arg_322_1.time_ - var_325_51) / var_325_53

				arg_322_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, var_325_54)
			end

			if arg_322_1.time_ >= var_325_51 + var_325_53 and arg_322_1.time_ < var_325_51 + var_325_53 + arg_325_0 then
				arg_322_1.screenFilterEffect_.weight = 1
			end

			local var_325_55 = 0

			if var_325_55 < arg_322_1.time_ and arg_322_1.time_ <= var_325_55 + arg_325_0 then
				arg_322_1.mask_.enabled = true
				arg_322_1.mask_.raycastTarget = true

				arg_322_1:SetGaussion(false)
			end

			local var_325_56 = 1

			if var_325_55 <= arg_322_1.time_ and arg_322_1.time_ < var_325_55 + var_325_56 then
				local var_325_57 = (arg_322_1.time_ - var_325_55) / var_325_56
				local var_325_58 = Color.New(0, 0, 0)

				var_325_58.a = Mathf.Lerp(0, 1, var_325_57)
				arg_322_1.mask_.color = var_325_58
			end

			if arg_322_1.time_ >= var_325_55 + var_325_56 and arg_322_1.time_ < var_325_55 + var_325_56 + arg_325_0 then
				local var_325_59 = Color.New(0, 0, 0)

				var_325_59.a = 1
				arg_322_1.mask_.color = var_325_59
			end

			local var_325_60 = 1

			if var_325_60 < arg_322_1.time_ and arg_322_1.time_ <= var_325_60 + arg_325_0 then
				arg_322_1.mask_.enabled = true
				arg_322_1.mask_.raycastTarget = true

				arg_322_1:SetGaussion(false)
			end

			local var_325_61 = 1

			if var_325_60 <= arg_322_1.time_ and arg_322_1.time_ < var_325_60 + var_325_61 then
				local var_325_62 = (arg_322_1.time_ - var_325_60) / var_325_61
				local var_325_63 = Color.New(0, 0, 0)

				var_325_63.a = Mathf.Lerp(1, 0, var_325_62)
				arg_322_1.mask_.color = var_325_63
			end

			if arg_322_1.time_ >= var_325_60 + var_325_61 and arg_322_1.time_ < var_325_60 + var_325_61 + arg_325_0 then
				local var_325_64 = Color.New(0, 0, 0)
				local var_325_65 = 0

				arg_322_1.mask_.enabled = false
				var_325_64.a = var_325_65
				arg_322_1.mask_.color = var_325_64
			end

			local var_325_66 = "L01h"

			if arg_322_1.bgs_[var_325_66] == nil then
				local var_325_67 = Object.Instantiate(arg_322_1.paintGo_)

				var_325_67:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_325_66)
				var_325_67.name = var_325_66
				var_325_67.transform.parent = arg_322_1.stage_.transform
				var_325_67.transform.localPosition = Vector3.New(0, 100, 0)
				arg_322_1.bgs_[var_325_66] = var_325_67
			end

			local var_325_68 = 1

			if var_325_68 < arg_322_1.time_ and arg_322_1.time_ <= var_325_68 + arg_325_0 then
				local var_325_69 = manager.ui.mainCamera.transform.localPosition
				local var_325_70 = Vector3.New(0, 0, 10) + Vector3.New(var_325_69.x, var_325_69.y, 0)
				local var_325_71 = arg_322_1.bgs_.L01h

				var_325_71.transform.localPosition = var_325_70
				var_325_71.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_325_72 = var_325_71:GetComponent("SpriteRenderer")

				if var_325_72 and var_325_72.sprite then
					local var_325_73 = (var_325_71.transform.localPosition - var_325_69).z
					local var_325_74 = manager.ui.mainCameraCom_
					local var_325_75 = 2 * var_325_73 * Mathf.Tan(var_325_74.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_325_76 = var_325_75 * var_325_74.aspect
					local var_325_77 = var_325_72.sprite.bounds.size.x
					local var_325_78 = var_325_72.sprite.bounds.size.y
					local var_325_79 = var_325_76 / var_325_77
					local var_325_80 = var_325_75 / var_325_78
					local var_325_81 = var_325_80 < var_325_79 and var_325_79 or var_325_80

					var_325_71.transform.localScale = Vector3.New(var_325_81, var_325_81, 0)
				end

				for iter_325_8, iter_325_9 in pairs(arg_322_1.bgs_) do
					if iter_325_8 ~= "L01h" then
						iter_325_9.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if arg_322_1.frameCnt_ <= 1 then
				arg_322_1.dialog_:SetActive(false)
			end

			local var_325_82 = 1.6
			local var_325_83 = 0.725

			if var_325_82 < arg_322_1.time_ and arg_322_1.time_ <= var_325_82 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0

				arg_322_1.dialog_:SetActive(true)

				arg_322_1.dialogCg_.alpha = 0

				local var_325_84 = LeanTween.value(arg_322_1.dialog_, 0, 1, 0.3)

				var_325_84:setOnUpdate(LuaHelper.FloatAction(function(arg_326_0)
					arg_322_1.dialogCg_.alpha = arg_326_0
				end))
				var_325_84:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_322_1.dialog_)
					var_325_84:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_322_1.duration_ = arg_322_1.duration_ + 0.3

				SetActive(arg_322_1.leftNameGo_, true)

				local var_325_85 = arg_322_1:FormatText(StoryNameCfg[1214].name)

				arg_322_1.leftNameTxt_.text = var_325_85

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_322_1.leftNameTxt_.transform)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1.leftNameTxt_.text)
				SetActive(arg_322_1.iconTrs_.gameObject, false)
				arg_322_1.callingController_:SetSelectedState("normal")

				local var_325_86 = arg_322_1:GetWordFromCfg(322062078)
				local var_325_87 = arg_322_1:FormatText(var_325_86.content)

				arg_322_1.text_.text = var_325_87

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_88 = 29
				local var_325_89 = utf8.len(var_325_87)
				local var_325_90 = var_325_88 <= 0 and var_325_83 or var_325_83 * (var_325_89 / var_325_88)

				if var_325_90 > 0 and var_325_83 < var_325_90 then
					arg_322_1.talkMaxDuration = var_325_90
					var_325_82 = var_325_82 + 0.3

					if var_325_90 + var_325_82 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_90 + var_325_82
					end
				end

				arg_322_1.text_.text = var_325_87
				arg_322_1.typewritter.percent = 0

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062078", "story_v_out_322062.awb") ~= 0 then
					local var_325_91 = manager.audio:GetVoiceLength("story_v_out_322062", "322062078", "story_v_out_322062.awb") / 1000

					if var_325_91 + var_325_82 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_91 + var_325_82
					end

					if var_325_86.prefab_name ~= "" and arg_322_1.actors_[var_325_86.prefab_name] ~= nil then
						local var_325_92 = LuaForUtil.PlayVoiceWithCriLipsync(arg_322_1.actors_[var_325_86.prefab_name].transform, "story_v_out_322062", "322062078", "story_v_out_322062.awb")

						arg_322_1:RecordAudio("322062078", var_325_92)
						arg_322_1:RecordAudio("322062078", var_325_92)
					else
						arg_322_1:AudioAction("play", "voice", "story_v_out_322062", "322062078", "story_v_out_322062.awb")
					end

					arg_322_1:RecordHistoryTalkVoice("story_v_out_322062", "322062078", "story_v_out_322062.awb")
				end

				arg_322_1:RecordContent(arg_322_1.text_.text)
			end

			local var_325_93 = var_325_82 + 0.3
			local var_325_94 = math.max(var_325_83, arg_322_1.talkMaxDuration)

			if var_325_93 <= arg_322_1.time_ and arg_322_1.time_ < var_325_93 + var_325_94 then
				arg_322_1.typewritter.percent = (arg_322_1.time_ - var_325_93) / var_325_94

				arg_322_1.typewritter:SetDirty()
			end

			if arg_322_1.time_ >= var_325_93 + var_325_94 and arg_322_1.time_ < var_325_93 + var_325_94 + arg_325_0 then
				arg_322_1.typewritter.percent = 1

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(true)
			end
		end

		arg_322_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.01666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_322_1:InitPlayNodeList()
	end,
	Play322062079 = function(arg_328_0, arg_328_1)
		arg_328_1.time_ = 0
		arg_328_1.frameCnt_ = 0
		arg_328_1.state_ = "playing"
		arg_328_1.curTalkId_ = 322062079
		arg_328_1.duration_ = 24.17

		local var_328_0 = {
			zh = 13.366,
			ja = 24.166
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
		end

		function arg_328_1.playNext_(arg_330_0)
			if arg_330_0 == 1 then
				arg_328_0:Play322062080(arg_328_1)
			end
		end

		function arg_328_1.onSingleLineUpdate_(arg_331_0)
			local var_331_0 = 0
			local var_331_1 = 1.525

			if var_331_0 < arg_328_1.time_ and arg_328_1.time_ <= var_331_0 + arg_331_0 then
				arg_328_1.talkMaxDuration = 0
				arg_328_1.dialogCg_.alpha = 1

				arg_328_1.dialog_:SetActive(true)
				SetActive(arg_328_1.leftNameGo_, true)

				local var_331_2 = arg_328_1:FormatText(StoryNameCfg[1214].name)

				arg_328_1.leftNameTxt_.text = var_331_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_328_1.leftNameTxt_.transform)

				arg_328_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_328_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_328_1:RecordName(arg_328_1.leftNameTxt_.text)
				SetActive(arg_328_1.iconTrs_.gameObject, false)
				arg_328_1.callingController_:SetSelectedState("normal")

				local var_331_3 = arg_328_1:GetWordFromCfg(322062079)
				local var_331_4 = arg_328_1:FormatText(var_331_3.content)

				arg_328_1.text_.text = var_331_4

				LuaForUtil.ClearLinePrefixSymbol(arg_328_1.text_)

				local var_331_5 = 61
				local var_331_6 = utf8.len(var_331_4)
				local var_331_7 = var_331_5 <= 0 and var_331_1 or var_331_1 * (var_331_6 / var_331_5)

				if var_331_7 > 0 and var_331_1 < var_331_7 then
					arg_328_1.talkMaxDuration = var_331_7

					if var_331_7 + var_331_0 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_7 + var_331_0
					end
				end

				arg_328_1.text_.text = var_331_4
				arg_328_1.typewritter.percent = 0

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062079", "story_v_out_322062.awb") ~= 0 then
					local var_331_8 = manager.audio:GetVoiceLength("story_v_out_322062", "322062079", "story_v_out_322062.awb") / 1000

					if var_331_8 + var_331_0 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_8 + var_331_0
					end

					if var_331_3.prefab_name ~= "" and arg_328_1.actors_[var_331_3.prefab_name] ~= nil then
						local var_331_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_328_1.actors_[var_331_3.prefab_name].transform, "story_v_out_322062", "322062079", "story_v_out_322062.awb")

						arg_328_1:RecordAudio("322062079", var_331_9)
						arg_328_1:RecordAudio("322062079", var_331_9)
					else
						arg_328_1:AudioAction("play", "voice", "story_v_out_322062", "322062079", "story_v_out_322062.awb")
					end

					arg_328_1:RecordHistoryTalkVoice("story_v_out_322062", "322062079", "story_v_out_322062.awb")
				end

				arg_328_1:RecordContent(arg_328_1.text_.text)
			end

			local var_331_10 = math.max(var_331_1, arg_328_1.talkMaxDuration)

			if var_331_0 <= arg_328_1.time_ and arg_328_1.time_ < var_331_0 + var_331_10 then
				arg_328_1.typewritter.percent = (arg_328_1.time_ - var_331_0) / var_331_10

				arg_328_1.typewritter:SetDirty()
			end

			if arg_328_1.time_ >= var_331_0 + var_331_10 and arg_328_1.time_ < var_331_0 + var_331_10 + arg_331_0 then
				arg_328_1.typewritter.percent = 1

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(true)
			end
		end

		arg_328_1.nodeConfigList_ = {}

		arg_328_1:InitPlayNodeList()
	end,
	Play322062080 = function(arg_332_0, arg_332_1)
		arg_332_1.time_ = 0
		arg_332_1.frameCnt_ = 0
		arg_332_1.state_ = "playing"
		arg_332_1.curTalkId_ = 322062080
		arg_332_1.duration_ = 24.6

		local var_332_0 = {
			zh = 11,
			ja = 24.6
		}
		local var_332_1 = manager.audio:GetLocalizationFlag()

		if var_332_0[var_332_1] ~= nil then
			arg_332_1.duration_ = var_332_0[var_332_1]
		end

		SetActive(arg_332_1.tipsGo_, false)

		function arg_332_1.onSingleLineFinish_()
			arg_332_1.onSingleLineUpdate_ = nil
			arg_332_1.onSingleLineFinish_ = nil
			arg_332_1.state_ = "waiting"
		end

		function arg_332_1.playNext_(arg_334_0)
			if arg_334_0 == 1 then
				arg_332_0:Play322062081(arg_332_1)
			end
		end

		function arg_332_1.onSingleLineUpdate_(arg_335_0)
			local var_335_0 = 0

			if var_335_0 < arg_332_1.time_ and arg_332_1.time_ <= var_335_0 + arg_335_0 then
				arg_332_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/story10103/story10103action/10103action8_1")
			end

			local var_335_1 = 0

			if var_335_1 < arg_332_1.time_ and arg_332_1.time_ <= var_335_1 + arg_335_0 then
				arg_332_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_335_2 = 0

			if var_335_2 < arg_332_1.time_ and arg_332_1.time_ <= var_335_2 + arg_335_0 then
				local var_335_3 = arg_332_1.actors_["10103ui_story"]

				if not isNil(var_335_3) then
					local var_335_4 = GameObjectTools.GetOrAddComponent(var_335_3, typeof(DynamicBoneHelper))

					if var_335_4 then
						var_335_4:EnableDynamicBone(true)
					end
				end
			end

			local var_335_5 = 0
			local var_335_6 = 1.2

			if var_335_5 < arg_332_1.time_ and arg_332_1.time_ <= var_335_5 + arg_335_0 then
				arg_332_1.talkMaxDuration = 0
				arg_332_1.dialogCg_.alpha = 1

				arg_332_1.dialog_:SetActive(true)
				SetActive(arg_332_1.leftNameGo_, true)

				local var_335_7 = arg_332_1:FormatText(StoryNameCfg[1214].name)

				arg_332_1.leftNameTxt_.text = var_335_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_332_1.leftNameTxt_.transform)

				arg_332_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_332_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_332_1:RecordName(arg_332_1.leftNameTxt_.text)
				SetActive(arg_332_1.iconTrs_.gameObject, false)
				arg_332_1.callingController_:SetSelectedState("normal")

				local var_335_8 = arg_332_1:GetWordFromCfg(322062080)
				local var_335_9 = arg_332_1:FormatText(var_335_8.content)

				arg_332_1.text_.text = var_335_9

				LuaForUtil.ClearLinePrefixSymbol(arg_332_1.text_)

				local var_335_10 = 48
				local var_335_11 = utf8.len(var_335_9)
				local var_335_12 = var_335_10 <= 0 and var_335_6 or var_335_6 * (var_335_11 / var_335_10)

				if var_335_12 > 0 and var_335_6 < var_335_12 then
					arg_332_1.talkMaxDuration = var_335_12

					if var_335_12 + var_335_5 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_12 + var_335_5
					end
				end

				arg_332_1.text_.text = var_335_9
				arg_332_1.typewritter.percent = 0

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062080", "story_v_out_322062.awb") ~= 0 then
					local var_335_13 = manager.audio:GetVoiceLength("story_v_out_322062", "322062080", "story_v_out_322062.awb") / 1000

					if var_335_13 + var_335_5 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_13 + var_335_5
					end

					if var_335_8.prefab_name ~= "" and arg_332_1.actors_[var_335_8.prefab_name] ~= nil then
						local var_335_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_332_1.actors_[var_335_8.prefab_name].transform, "story_v_out_322062", "322062080", "story_v_out_322062.awb")

						arg_332_1:RecordAudio("322062080", var_335_14)
						arg_332_1:RecordAudio("322062080", var_335_14)
					else
						arg_332_1:AudioAction("play", "voice", "story_v_out_322062", "322062080", "story_v_out_322062.awb")
					end

					arg_332_1:RecordHistoryTalkVoice("story_v_out_322062", "322062080", "story_v_out_322062.awb")
				end

				arg_332_1:RecordContent(arg_332_1.text_.text)
			end

			local var_335_15 = math.max(var_335_6, arg_332_1.talkMaxDuration)

			if var_335_5 <= arg_332_1.time_ and arg_332_1.time_ < var_335_5 + var_335_15 then
				arg_332_1.typewritter.percent = (arg_332_1.time_ - var_335_5) / var_335_15

				arg_332_1.typewritter:SetDirty()
			end

			if arg_332_1.time_ >= var_335_5 + var_335_15 and arg_332_1.time_ < var_335_5 + var_335_15 + arg_335_0 then
				arg_332_1.typewritter.percent = 1

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(true)
			end
		end

		arg_332_1.nodeConfigList_ = {}

		arg_332_1:InitPlayNodeList()
	end,
	Play322062081 = function(arg_336_0, arg_336_1)
		arg_336_1.time_ = 0
		arg_336_1.frameCnt_ = 0
		arg_336_1.state_ = "playing"
		arg_336_1.curTalkId_ = 322062081
		arg_336_1.duration_ = 5.93

		local var_336_0 = {
			zh = 4.666,
			ja = 5.933
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
				arg_336_0:Play322062082(arg_336_1)
			end
		end

		function arg_336_1.onSingleLineUpdate_(arg_339_0)
			local var_339_0 = arg_336_1.actors_["10103ui_story"]
			local var_339_1 = 0

			if var_339_1 < arg_336_1.time_ and arg_336_1.time_ <= var_339_1 + arg_339_0 and not isNil(var_339_0) and arg_336_1.var_.characterEffect10103ui_story == nil then
				arg_336_1.var_.characterEffect10103ui_story = var_339_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_339_2 = 0.200000002980232

			if var_339_1 <= arg_336_1.time_ and arg_336_1.time_ < var_339_1 + var_339_2 and not isNil(var_339_0) then
				local var_339_3 = (arg_336_1.time_ - var_339_1) / var_339_2

				if arg_336_1.var_.characterEffect10103ui_story and not isNil(var_339_0) then
					local var_339_4 = Mathf.Lerp(0, 0.5, var_339_3)

					arg_336_1.var_.characterEffect10103ui_story.fillFlat = true
					arg_336_1.var_.characterEffect10103ui_story.fillRatio = var_339_4
				end
			end

			if arg_336_1.time_ >= var_339_1 + var_339_2 and arg_336_1.time_ < var_339_1 + var_339_2 + arg_339_0 and not isNil(var_339_0) and arg_336_1.var_.characterEffect10103ui_story then
				local var_339_5 = 0.5

				arg_336_1.var_.characterEffect10103ui_story.fillFlat = true
				arg_336_1.var_.characterEffect10103ui_story.fillRatio = var_339_5
			end

			local var_339_6 = 0
			local var_339_7 = 0.525

			if var_339_6 < arg_336_1.time_ and arg_336_1.time_ <= var_339_6 + arg_339_0 then
				arg_336_1.talkMaxDuration = 0
				arg_336_1.dialogCg_.alpha = 1

				arg_336_1.dialog_:SetActive(true)
				SetActive(arg_336_1.leftNameGo_, true)

				local var_339_8 = arg_336_1:FormatText(StoryNameCfg[1031].name)

				arg_336_1.leftNameTxt_.text = var_339_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_336_1.leftNameTxt_.transform)

				arg_336_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_336_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_336_1:RecordName(arg_336_1.leftNameTxt_.text)
				SetActive(arg_336_1.iconTrs_.gameObject, true)
				arg_336_1.iconController_:SetSelectedState("hero")

				arg_336_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1089")

				arg_336_1.callingController_:SetSelectedState("normal")

				arg_336_1.keyicon_.color = Color.New(1, 1, 1)
				arg_336_1.icon_.color = Color.New(1, 1, 1)

				local var_339_9 = arg_336_1:GetWordFromCfg(322062081)
				local var_339_10 = arg_336_1:FormatText(var_339_9.content)

				arg_336_1.text_.text = var_339_10

				LuaForUtil.ClearLinePrefixSymbol(arg_336_1.text_)

				local var_339_11 = 21
				local var_339_12 = utf8.len(var_339_10)
				local var_339_13 = var_339_11 <= 0 and var_339_7 or var_339_7 * (var_339_12 / var_339_11)

				if var_339_13 > 0 and var_339_7 < var_339_13 then
					arg_336_1.talkMaxDuration = var_339_13

					if var_339_13 + var_339_6 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_13 + var_339_6
					end
				end

				arg_336_1.text_.text = var_339_10
				arg_336_1.typewritter.percent = 0

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062081", "story_v_out_322062.awb") ~= 0 then
					local var_339_14 = manager.audio:GetVoiceLength("story_v_out_322062", "322062081", "story_v_out_322062.awb") / 1000

					if var_339_14 + var_339_6 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_14 + var_339_6
					end

					if var_339_9.prefab_name ~= "" and arg_336_1.actors_[var_339_9.prefab_name] ~= nil then
						local var_339_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_336_1.actors_[var_339_9.prefab_name].transform, "story_v_out_322062", "322062081", "story_v_out_322062.awb")

						arg_336_1:RecordAudio("322062081", var_339_15)
						arg_336_1:RecordAudio("322062081", var_339_15)
					else
						arg_336_1:AudioAction("play", "voice", "story_v_out_322062", "322062081", "story_v_out_322062.awb")
					end

					arg_336_1:RecordHistoryTalkVoice("story_v_out_322062", "322062081", "story_v_out_322062.awb")
				end

				arg_336_1:RecordContent(arg_336_1.text_.text)
			end

			local var_339_16 = math.max(var_339_7, arg_336_1.talkMaxDuration)

			if var_339_6 <= arg_336_1.time_ and arg_336_1.time_ < var_339_6 + var_339_16 then
				arg_336_1.typewritter.percent = (arg_336_1.time_ - var_339_6) / var_339_16

				arg_336_1.typewritter:SetDirty()
			end

			if arg_336_1.time_ >= var_339_6 + var_339_16 and arg_336_1.time_ < var_339_6 + var_339_16 + arg_339_0 then
				arg_336_1.typewritter.percent = 1

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(true)
			end
		end

		arg_336_1.nodeConfigList_ = {}

		arg_336_1:InitPlayNodeList()
	end,
	Play322062082 = function(arg_340_0, arg_340_1)
		arg_340_1.time_ = 0
		arg_340_1.frameCnt_ = 0
		arg_340_1.state_ = "playing"
		arg_340_1.curTalkId_ = 322062082
		arg_340_1.duration_ = 12.03

		local var_340_0 = {
			zh = 10.2,
			ja = 12.033
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
				arg_340_0:Play322062083(arg_340_1)
			end
		end

		function arg_340_1.onSingleLineUpdate_(arg_343_0)
			local var_343_0 = arg_340_1.actors_["10103ui_story"]
			local var_343_1 = 0

			if var_343_1 < arg_340_1.time_ and arg_340_1.time_ <= var_343_1 + arg_343_0 and not isNil(var_343_0) and arg_340_1.var_.characterEffect10103ui_story == nil then
				arg_340_1.var_.characterEffect10103ui_story = var_343_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_343_2 = 0.200000002980232

			if var_343_1 <= arg_340_1.time_ and arg_340_1.time_ < var_343_1 + var_343_2 and not isNil(var_343_0) then
				local var_343_3 = (arg_340_1.time_ - var_343_1) / var_343_2

				if arg_340_1.var_.characterEffect10103ui_story and not isNil(var_343_0) then
					arg_340_1.var_.characterEffect10103ui_story.fillFlat = false
				end
			end

			if arg_340_1.time_ >= var_343_1 + var_343_2 and arg_340_1.time_ < var_343_1 + var_343_2 + arg_343_0 and not isNil(var_343_0) and arg_340_1.var_.characterEffect10103ui_story then
				arg_340_1.var_.characterEffect10103ui_story.fillFlat = false
			end

			local var_343_4 = 0

			if var_343_4 < arg_340_1.time_ and arg_340_1.time_ <= var_343_4 + arg_343_0 then
				arg_340_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/story10103/story10103action/10103action8_2")
			end

			local var_343_5 = 0

			if var_343_5 < arg_340_1.time_ and arg_340_1.time_ <= var_343_5 + arg_343_0 then
				local var_343_6 = arg_340_1.actors_["10103ui_story"]

				if not isNil(var_343_6) then
					local var_343_7 = GameObjectTools.GetOrAddComponent(var_343_6, typeof(DynamicBoneHelper))

					if var_343_7 then
						var_343_7:EnableDynamicBone(true)
					end
				end
			end

			local var_343_8 = 0
			local var_343_9 = 1.05

			if var_343_8 < arg_340_1.time_ and arg_340_1.time_ <= var_343_8 + arg_343_0 then
				arg_340_1.talkMaxDuration = 0
				arg_340_1.dialogCg_.alpha = 1

				arg_340_1.dialog_:SetActive(true)
				SetActive(arg_340_1.leftNameGo_, true)

				local var_343_10 = arg_340_1:FormatText(StoryNameCfg[1214].name)

				arg_340_1.leftNameTxt_.text = var_343_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_340_1.leftNameTxt_.transform)

				arg_340_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_340_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_340_1:RecordName(arg_340_1.leftNameTxt_.text)
				SetActive(arg_340_1.iconTrs_.gameObject, false)
				arg_340_1.callingController_:SetSelectedState("normal")

				local var_343_11 = arg_340_1:GetWordFromCfg(322062082)
				local var_343_12 = arg_340_1:FormatText(var_343_11.content)

				arg_340_1.text_.text = var_343_12

				LuaForUtil.ClearLinePrefixSymbol(arg_340_1.text_)

				local var_343_13 = 42
				local var_343_14 = utf8.len(var_343_12)
				local var_343_15 = var_343_13 <= 0 and var_343_9 or var_343_9 * (var_343_14 / var_343_13)

				if var_343_15 > 0 and var_343_9 < var_343_15 then
					arg_340_1.talkMaxDuration = var_343_15

					if var_343_15 + var_343_8 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_15 + var_343_8
					end
				end

				arg_340_1.text_.text = var_343_12
				arg_340_1.typewritter.percent = 0

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062082", "story_v_out_322062.awb") ~= 0 then
					local var_343_16 = manager.audio:GetVoiceLength("story_v_out_322062", "322062082", "story_v_out_322062.awb") / 1000

					if var_343_16 + var_343_8 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_16 + var_343_8
					end

					if var_343_11.prefab_name ~= "" and arg_340_1.actors_[var_343_11.prefab_name] ~= nil then
						local var_343_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_340_1.actors_[var_343_11.prefab_name].transform, "story_v_out_322062", "322062082", "story_v_out_322062.awb")

						arg_340_1:RecordAudio("322062082", var_343_17)
						arg_340_1:RecordAudio("322062082", var_343_17)
					else
						arg_340_1:AudioAction("play", "voice", "story_v_out_322062", "322062082", "story_v_out_322062.awb")
					end

					arg_340_1:RecordHistoryTalkVoice("story_v_out_322062", "322062082", "story_v_out_322062.awb")
				end

				arg_340_1:RecordContent(arg_340_1.text_.text)
			end

			local var_343_18 = math.max(var_343_9, arg_340_1.talkMaxDuration)

			if var_343_8 <= arg_340_1.time_ and arg_340_1.time_ < var_343_8 + var_343_18 then
				arg_340_1.typewritter.percent = (arg_340_1.time_ - var_343_8) / var_343_18

				arg_340_1.typewritter:SetDirty()
			end

			if arg_340_1.time_ >= var_343_8 + var_343_18 and arg_340_1.time_ < var_343_8 + var_343_18 + arg_343_0 then
				arg_340_1.typewritter.percent = 1

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(true)
			end
		end

		arg_340_1.nodeConfigList_ = {}

		arg_340_1:InitPlayNodeList()
	end,
	Play322062083 = function(arg_344_0, arg_344_1)
		arg_344_1.time_ = 0
		arg_344_1.frameCnt_ = 0
		arg_344_1.state_ = "playing"
		arg_344_1.curTalkId_ = 322062083
		arg_344_1.duration_ = 5

		SetActive(arg_344_1.tipsGo_, false)

		function arg_344_1.onSingleLineFinish_()
			arg_344_1.onSingleLineUpdate_ = nil
			arg_344_1.onSingleLineFinish_ = nil
			arg_344_1.state_ = "waiting"
		end

		function arg_344_1.playNext_(arg_346_0)
			if arg_346_0 == 1 then
				arg_344_0:Play322062084(arg_344_1)
			end
		end

		function arg_344_1.onSingleLineUpdate_(arg_347_0)
			local var_347_0 = arg_344_1.actors_["10103ui_story"].transform
			local var_347_1 = 0

			if var_347_1 < arg_344_1.time_ and arg_344_1.time_ <= var_347_1 + arg_347_0 then
				arg_344_1.var_.moveOldPos10103ui_story = var_347_0.localPosition

				local var_347_2 = GameObjectTools.GetOrAddComponent(var_347_0.gameObject, typeof(DynamicBoneHelper))

				if var_347_2 then
					var_347_2:EnableDynamicBone(false)
				end
			end

			local var_347_3 = 0.001

			if var_347_1 <= arg_344_1.time_ and arg_344_1.time_ < var_347_1 + var_347_3 then
				local var_347_4 = (arg_344_1.time_ - var_347_1) / var_347_3
				local var_347_5 = Vector3.New(0, 100, 0)

				var_347_0.localPosition = Vector3.Lerp(arg_344_1.var_.moveOldPos10103ui_story, var_347_5, var_347_4)

				local var_347_6 = manager.ui.mainCamera.transform.position - var_347_0.position

				var_347_0.forward = Vector3.New(var_347_6.x, var_347_6.y, var_347_6.z)

				local var_347_7 = var_347_0.localEulerAngles

				var_347_7.z = 0
				var_347_7.x = 0
				var_347_0.localEulerAngles = var_347_7
			end

			if arg_344_1.time_ >= var_347_1 + var_347_3 and arg_344_1.time_ < var_347_1 + var_347_3 + arg_347_0 then
				var_347_0.localPosition = Vector3.New(0, 100, 0)

				local var_347_8 = manager.ui.mainCamera.transform.position - var_347_0.position

				var_347_0.forward = Vector3.New(var_347_8.x, var_347_8.y, var_347_8.z)

				local var_347_9 = var_347_0.localEulerAngles

				var_347_9.z = 0
				var_347_9.x = 0
				var_347_0.localEulerAngles = var_347_9

				local var_347_10 = GameObjectTools.GetOrAddComponent(var_347_0.gameObject, typeof(DynamicBoneHelper))

				if var_347_10 then
					var_347_10:EnableDynamicBone(true)
				end
			end

			local var_347_11 = 0
			local var_347_12 = 1.4

			if var_347_11 < arg_344_1.time_ and arg_344_1.time_ <= var_347_11 + arg_347_0 then
				arg_344_1.talkMaxDuration = 0
				arg_344_1.dialogCg_.alpha = 1

				arg_344_1.dialog_:SetActive(true)
				SetActive(arg_344_1.leftNameGo_, false)

				arg_344_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_344_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_344_1:RecordName(arg_344_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_344_1.iconTrs_.gameObject, false)
				arg_344_1.callingController_:SetSelectedState("normal")

				local var_347_13 = arg_344_1:GetWordFromCfg(322062083)
				local var_347_14 = arg_344_1:FormatText(var_347_13.content)

				arg_344_1.text_.text = var_347_14

				LuaForUtil.ClearLinePrefixSymbol(arg_344_1.text_)

				local var_347_15 = 56
				local var_347_16 = utf8.len(var_347_14)
				local var_347_17 = var_347_15 <= 0 and var_347_12 or var_347_12 * (var_347_16 / var_347_15)

				if var_347_17 > 0 and var_347_12 < var_347_17 then
					arg_344_1.talkMaxDuration = var_347_17

					if var_347_17 + var_347_11 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_17 + var_347_11
					end
				end

				arg_344_1.text_.text = var_347_14
				arg_344_1.typewritter.percent = 0

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(false)
				arg_344_1:RecordContent(arg_344_1.text_.text)
			end

			local var_347_18 = math.max(var_347_12, arg_344_1.talkMaxDuration)

			if var_347_11 <= arg_344_1.time_ and arg_344_1.time_ < var_347_11 + var_347_18 then
				arg_344_1.typewritter.percent = (arg_344_1.time_ - var_347_11) / var_347_18

				arg_344_1.typewritter:SetDirty()
			end

			if arg_344_1.time_ >= var_347_11 + var_347_18 and arg_344_1.time_ < var_347_11 + var_347_18 + arg_347_0 then
				arg_344_1.typewritter.percent = 1

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(true)
			end
		end

		arg_344_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_344_1:InitPlayNodeList()
	end,
	Play322062084 = function(arg_348_0, arg_348_1)
		arg_348_1.time_ = 0
		arg_348_1.frameCnt_ = 0
		arg_348_1.state_ = "playing"
		arg_348_1.curTalkId_ = 322062084
		arg_348_1.duration_ = 2.77

		local var_348_0 = {
			zh = 2.1,
			ja = 2.766
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
				arg_348_0:Play322062085(arg_348_1)
			end
		end

		function arg_348_1.onSingleLineUpdate_(arg_351_0)
			local var_351_0 = 0
			local var_351_1 = 0.25

			if var_351_0 < arg_348_1.time_ and arg_348_1.time_ <= var_351_0 + arg_351_0 then
				arg_348_1.talkMaxDuration = 0
				arg_348_1.dialogCg_.alpha = 1

				arg_348_1.dialog_:SetActive(true)
				SetActive(arg_348_1.leftNameGo_, true)

				local var_351_2 = arg_348_1:FormatText(StoryNameCfg[1031].name)

				arg_348_1.leftNameTxt_.text = var_351_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_348_1.leftNameTxt_.transform)

				arg_348_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_348_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_348_1:RecordName(arg_348_1.leftNameTxt_.text)
				SetActive(arg_348_1.iconTrs_.gameObject, true)
				arg_348_1.iconController_:SetSelectedState("hero")

				arg_348_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1089")

				arg_348_1.callingController_:SetSelectedState("normal")

				arg_348_1.keyicon_.color = Color.New(1, 1, 1)
				arg_348_1.icon_.color = Color.New(1, 1, 1)

				local var_351_3 = arg_348_1:GetWordFromCfg(322062084)
				local var_351_4 = arg_348_1:FormatText(var_351_3.content)

				arg_348_1.text_.text = var_351_4

				LuaForUtil.ClearLinePrefixSymbol(arg_348_1.text_)

				local var_351_5 = 10
				local var_351_6 = utf8.len(var_351_4)
				local var_351_7 = var_351_5 <= 0 and var_351_1 or var_351_1 * (var_351_6 / var_351_5)

				if var_351_7 > 0 and var_351_1 < var_351_7 then
					arg_348_1.talkMaxDuration = var_351_7

					if var_351_7 + var_351_0 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_7 + var_351_0
					end
				end

				arg_348_1.text_.text = var_351_4
				arg_348_1.typewritter.percent = 0

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062084", "story_v_out_322062.awb") ~= 0 then
					local var_351_8 = manager.audio:GetVoiceLength("story_v_out_322062", "322062084", "story_v_out_322062.awb") / 1000

					if var_351_8 + var_351_0 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_8 + var_351_0
					end

					if var_351_3.prefab_name ~= "" and arg_348_1.actors_[var_351_3.prefab_name] ~= nil then
						local var_351_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_348_1.actors_[var_351_3.prefab_name].transform, "story_v_out_322062", "322062084", "story_v_out_322062.awb")

						arg_348_1:RecordAudio("322062084", var_351_9)
						arg_348_1:RecordAudio("322062084", var_351_9)
					else
						arg_348_1:AudioAction("play", "voice", "story_v_out_322062", "322062084", "story_v_out_322062.awb")
					end

					arg_348_1:RecordHistoryTalkVoice("story_v_out_322062", "322062084", "story_v_out_322062.awb")
				end

				arg_348_1:RecordContent(arg_348_1.text_.text)
			end

			local var_351_10 = math.max(var_351_1, arg_348_1.talkMaxDuration)

			if var_351_0 <= arg_348_1.time_ and arg_348_1.time_ < var_351_0 + var_351_10 then
				arg_348_1.typewritter.percent = (arg_348_1.time_ - var_351_0) / var_351_10

				arg_348_1.typewritter:SetDirty()
			end

			if arg_348_1.time_ >= var_351_0 + var_351_10 and arg_348_1.time_ < var_351_0 + var_351_10 + arg_351_0 then
				arg_348_1.typewritter.percent = 1

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(true)
			end
		end

		arg_348_1.nodeConfigList_ = {}

		arg_348_1:InitPlayNodeList()
	end,
	Play322062085 = function(arg_352_0, arg_352_1)
		arg_352_1.time_ = 0
		arg_352_1.frameCnt_ = 0
		arg_352_1.state_ = "playing"
		arg_352_1.curTalkId_ = 322062085
		arg_352_1.duration_ = 10.1

		local var_352_0 = {
			zh = 3.7,
			ja = 10.1
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
				arg_352_0:Play322062086(arg_352_1)
			end
		end

		function arg_352_1.onSingleLineUpdate_(arg_355_0)
			local var_355_0 = arg_352_1.actors_["10103ui_story"].transform
			local var_355_1 = 0

			if var_355_1 < arg_352_1.time_ and arg_352_1.time_ <= var_355_1 + arg_355_0 then
				arg_352_1.var_.moveOldPos10103ui_story = var_355_0.localPosition

				local var_355_2 = GameObjectTools.GetOrAddComponent(var_355_0.gameObject, typeof(DynamicBoneHelper))

				if var_355_2 then
					var_355_2:EnableDynamicBone(false)
				end
			end

			local var_355_3 = 0.001

			if var_355_1 <= arg_352_1.time_ and arg_352_1.time_ < var_355_1 + var_355_3 then
				local var_355_4 = (arg_352_1.time_ - var_355_1) / var_355_3
				local var_355_5 = Vector3.New(0, -0.95, -6.2)

				var_355_0.localPosition = Vector3.Lerp(arg_352_1.var_.moveOldPos10103ui_story, var_355_5, var_355_4)

				local var_355_6 = manager.ui.mainCamera.transform.position - var_355_0.position

				var_355_0.forward = Vector3.New(var_355_6.x, var_355_6.y, var_355_6.z)

				local var_355_7 = var_355_0.localEulerAngles

				var_355_7.z = 0
				var_355_7.x = 0
				var_355_0.localEulerAngles = var_355_7
			end

			if arg_352_1.time_ >= var_355_1 + var_355_3 and arg_352_1.time_ < var_355_1 + var_355_3 + arg_355_0 then
				var_355_0.localPosition = Vector3.New(0, -0.95, -6.2)

				local var_355_8 = manager.ui.mainCamera.transform.position - var_355_0.position

				var_355_0.forward = Vector3.New(var_355_8.x, var_355_8.y, var_355_8.z)

				local var_355_9 = var_355_0.localEulerAngles

				var_355_9.z = 0
				var_355_9.x = 0
				var_355_0.localEulerAngles = var_355_9

				local var_355_10 = GameObjectTools.GetOrAddComponent(var_355_0.gameObject, typeof(DynamicBoneHelper))

				if var_355_10 then
					var_355_10:EnableDynamicBone(true)
				end
			end

			local var_355_11 = arg_352_1.actors_["10103ui_story"]
			local var_355_12 = 0

			if var_355_12 < arg_352_1.time_ and arg_352_1.time_ <= var_355_12 + arg_355_0 and not isNil(var_355_11) and arg_352_1.var_.characterEffect10103ui_story == nil then
				arg_352_1.var_.characterEffect10103ui_story = var_355_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_355_13 = 0.200000002980232

			if var_355_12 <= arg_352_1.time_ and arg_352_1.time_ < var_355_12 + var_355_13 and not isNil(var_355_11) then
				local var_355_14 = (arg_352_1.time_ - var_355_12) / var_355_13

				if arg_352_1.var_.characterEffect10103ui_story and not isNil(var_355_11) then
					arg_352_1.var_.characterEffect10103ui_story.fillFlat = false
				end
			end

			if arg_352_1.time_ >= var_355_12 + var_355_13 and arg_352_1.time_ < var_355_12 + var_355_13 + arg_355_0 and not isNil(var_355_11) and arg_352_1.var_.characterEffect10103ui_story then
				arg_352_1.var_.characterEffect10103ui_story.fillFlat = false
			end

			local var_355_15 = 0

			if var_355_15 < arg_352_1.time_ and arg_352_1.time_ <= var_355_15 + arg_355_0 then
				arg_352_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/story10103/story10103action/10103action1_1")
			end

			local var_355_16 = 0

			if var_355_16 < arg_352_1.time_ and arg_352_1.time_ <= var_355_16 + arg_355_0 then
				arg_352_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_355_17 = 0

			if var_355_17 < arg_352_1.time_ and arg_352_1.time_ <= var_355_17 + arg_355_0 then
				local var_355_18 = arg_352_1.actors_["10103ui_story"]

				if not isNil(var_355_18) then
					local var_355_19 = GameObjectTools.GetOrAddComponent(var_355_18, typeof(DynamicBoneHelper))

					if var_355_19 then
						var_355_19:EnableDynamicBone(true)
					end
				end
			end

			local var_355_20 = 0
			local var_355_21 = 0.4

			if var_355_20 < arg_352_1.time_ and arg_352_1.time_ <= var_355_20 + arg_355_0 then
				arg_352_1.talkMaxDuration = 0
				arg_352_1.dialogCg_.alpha = 1

				arg_352_1.dialog_:SetActive(true)
				SetActive(arg_352_1.leftNameGo_, true)

				local var_355_22 = arg_352_1:FormatText(StoryNameCfg[1214].name)

				arg_352_1.leftNameTxt_.text = var_355_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_352_1.leftNameTxt_.transform)

				arg_352_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_352_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_352_1:RecordName(arg_352_1.leftNameTxt_.text)
				SetActive(arg_352_1.iconTrs_.gameObject, false)
				arg_352_1.callingController_:SetSelectedState("normal")

				local var_355_23 = arg_352_1:GetWordFromCfg(322062085)
				local var_355_24 = arg_352_1:FormatText(var_355_23.content)

				arg_352_1.text_.text = var_355_24

				LuaForUtil.ClearLinePrefixSymbol(arg_352_1.text_)

				local var_355_25 = 16
				local var_355_26 = utf8.len(var_355_24)
				local var_355_27 = var_355_25 <= 0 and var_355_21 or var_355_21 * (var_355_26 / var_355_25)

				if var_355_27 > 0 and var_355_21 < var_355_27 then
					arg_352_1.talkMaxDuration = var_355_27

					if var_355_27 + var_355_20 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_27 + var_355_20
					end
				end

				arg_352_1.text_.text = var_355_24
				arg_352_1.typewritter.percent = 0

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062085", "story_v_out_322062.awb") ~= 0 then
					local var_355_28 = manager.audio:GetVoiceLength("story_v_out_322062", "322062085", "story_v_out_322062.awb") / 1000

					if var_355_28 + var_355_20 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_28 + var_355_20
					end

					if var_355_23.prefab_name ~= "" and arg_352_1.actors_[var_355_23.prefab_name] ~= nil then
						local var_355_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_352_1.actors_[var_355_23.prefab_name].transform, "story_v_out_322062", "322062085", "story_v_out_322062.awb")

						arg_352_1:RecordAudio("322062085", var_355_29)
						arg_352_1:RecordAudio("322062085", var_355_29)
					else
						arg_352_1:AudioAction("play", "voice", "story_v_out_322062", "322062085", "story_v_out_322062.awb")
					end

					arg_352_1:RecordHistoryTalkVoice("story_v_out_322062", "322062085", "story_v_out_322062.awb")
				end

				arg_352_1:RecordContent(arg_352_1.text_.text)
			end

			local var_355_30 = math.max(var_355_21, arg_352_1.talkMaxDuration)

			if var_355_20 <= arg_352_1.time_ and arg_352_1.time_ < var_355_20 + var_355_30 then
				arg_352_1.typewritter.percent = (arg_352_1.time_ - var_355_20) / var_355_30

				arg_352_1.typewritter:SetDirty()
			end

			if arg_352_1.time_ >= var_355_20 + var_355_30 and arg_352_1.time_ < var_355_20 + var_355_30 + arg_355_0 then
				arg_352_1.typewritter.percent = 1

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(true)
			end
		end

		arg_352_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_352_1:InitPlayNodeList()
	end,
	Play322062086 = function(arg_356_0, arg_356_1)
		arg_356_1.time_ = 0
		arg_356_1.frameCnt_ = 0
		arg_356_1.state_ = "playing"
		arg_356_1.curTalkId_ = 322062086
		arg_356_1.duration_ = 6.27

		local var_356_0 = {
			zh = 3.433,
			ja = 6.266
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
				arg_356_0:Play322062087(arg_356_1)
			end
		end

		function arg_356_1.onSingleLineUpdate_(arg_359_0)
			local var_359_0 = arg_356_1.actors_["10103ui_story"]
			local var_359_1 = 0

			if var_359_1 < arg_356_1.time_ and arg_356_1.time_ <= var_359_1 + arg_359_0 and not isNil(var_359_0) and arg_356_1.var_.characterEffect10103ui_story == nil then
				arg_356_1.var_.characterEffect10103ui_story = var_359_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_359_2 = 0.200000002980232

			if var_359_1 <= arg_356_1.time_ and arg_356_1.time_ < var_359_1 + var_359_2 and not isNil(var_359_0) then
				local var_359_3 = (arg_356_1.time_ - var_359_1) / var_359_2

				if arg_356_1.var_.characterEffect10103ui_story and not isNil(var_359_0) then
					local var_359_4 = Mathf.Lerp(0, 0.5, var_359_3)

					arg_356_1.var_.characterEffect10103ui_story.fillFlat = true
					arg_356_1.var_.characterEffect10103ui_story.fillRatio = var_359_4
				end
			end

			if arg_356_1.time_ >= var_359_1 + var_359_2 and arg_356_1.time_ < var_359_1 + var_359_2 + arg_359_0 and not isNil(var_359_0) and arg_356_1.var_.characterEffect10103ui_story then
				local var_359_5 = 0.5

				arg_356_1.var_.characterEffect10103ui_story.fillFlat = true
				arg_356_1.var_.characterEffect10103ui_story.fillRatio = var_359_5
			end

			local var_359_6 = 0
			local var_359_7 = 0.375

			if var_359_6 < arg_356_1.time_ and arg_356_1.time_ <= var_359_6 + arg_359_0 then
				arg_356_1.talkMaxDuration = 0
				arg_356_1.dialogCg_.alpha = 1

				arg_356_1.dialog_:SetActive(true)
				SetActive(arg_356_1.leftNameGo_, true)

				local var_359_8 = arg_356_1:FormatText(StoryNameCfg[1031].name)

				arg_356_1.leftNameTxt_.text = var_359_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_356_1.leftNameTxt_.transform)

				arg_356_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_356_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_356_1:RecordName(arg_356_1.leftNameTxt_.text)
				SetActive(arg_356_1.iconTrs_.gameObject, true)
				arg_356_1.iconController_:SetSelectedState("hero")

				arg_356_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1089")

				arg_356_1.callingController_:SetSelectedState("normal")

				arg_356_1.keyicon_.color = Color.New(1, 1, 1)
				arg_356_1.icon_.color = Color.New(1, 1, 1)

				local var_359_9 = arg_356_1:GetWordFromCfg(322062086)
				local var_359_10 = arg_356_1:FormatText(var_359_9.content)

				arg_356_1.text_.text = var_359_10

				LuaForUtil.ClearLinePrefixSymbol(arg_356_1.text_)

				local var_359_11 = 15
				local var_359_12 = utf8.len(var_359_10)
				local var_359_13 = var_359_11 <= 0 and var_359_7 or var_359_7 * (var_359_12 / var_359_11)

				if var_359_13 > 0 and var_359_7 < var_359_13 then
					arg_356_1.talkMaxDuration = var_359_13

					if var_359_13 + var_359_6 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_13 + var_359_6
					end
				end

				arg_356_1.text_.text = var_359_10
				arg_356_1.typewritter.percent = 0

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062086", "story_v_out_322062.awb") ~= 0 then
					local var_359_14 = manager.audio:GetVoiceLength("story_v_out_322062", "322062086", "story_v_out_322062.awb") / 1000

					if var_359_14 + var_359_6 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_14 + var_359_6
					end

					if var_359_9.prefab_name ~= "" and arg_356_1.actors_[var_359_9.prefab_name] ~= nil then
						local var_359_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_356_1.actors_[var_359_9.prefab_name].transform, "story_v_out_322062", "322062086", "story_v_out_322062.awb")

						arg_356_1:RecordAudio("322062086", var_359_15)
						arg_356_1:RecordAudio("322062086", var_359_15)
					else
						arg_356_1:AudioAction("play", "voice", "story_v_out_322062", "322062086", "story_v_out_322062.awb")
					end

					arg_356_1:RecordHistoryTalkVoice("story_v_out_322062", "322062086", "story_v_out_322062.awb")
				end

				arg_356_1:RecordContent(arg_356_1.text_.text)
			end

			local var_359_16 = math.max(var_359_7, arg_356_1.talkMaxDuration)

			if var_359_6 <= arg_356_1.time_ and arg_356_1.time_ < var_359_6 + var_359_16 then
				arg_356_1.typewritter.percent = (arg_356_1.time_ - var_359_6) / var_359_16

				arg_356_1.typewritter:SetDirty()
			end

			if arg_356_1.time_ >= var_359_6 + var_359_16 and arg_356_1.time_ < var_359_6 + var_359_16 + arg_359_0 then
				arg_356_1.typewritter.percent = 1

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(true)
			end
		end

		arg_356_1.nodeConfigList_ = {}

		arg_356_1:InitPlayNodeList()
	end,
	Play322062087 = function(arg_360_0, arg_360_1)
		arg_360_1.time_ = 0
		arg_360_1.frameCnt_ = 0
		arg_360_1.state_ = "playing"
		arg_360_1.curTalkId_ = 322062087
		arg_360_1.duration_ = 2.97

		local var_360_0 = {
			zh = 2.966,
			ja = 2.833
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
				arg_360_0:Play322062088(arg_360_1)
			end
		end

		function arg_360_1.onSingleLineUpdate_(arg_363_0)
			local var_363_0 = arg_360_1.actors_["10103ui_story"]
			local var_363_1 = 0

			if var_363_1 < arg_360_1.time_ and arg_360_1.time_ <= var_363_1 + arg_363_0 and not isNil(var_363_0) and arg_360_1.var_.characterEffect10103ui_story == nil then
				arg_360_1.var_.characterEffect10103ui_story = var_363_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_363_2 = 0.200000002980232

			if var_363_1 <= arg_360_1.time_ and arg_360_1.time_ < var_363_1 + var_363_2 and not isNil(var_363_0) then
				local var_363_3 = (arg_360_1.time_ - var_363_1) / var_363_2

				if arg_360_1.var_.characterEffect10103ui_story and not isNil(var_363_0) then
					arg_360_1.var_.characterEffect10103ui_story.fillFlat = false
				end
			end

			if arg_360_1.time_ >= var_363_1 + var_363_2 and arg_360_1.time_ < var_363_1 + var_363_2 + arg_363_0 and not isNil(var_363_0) and arg_360_1.var_.characterEffect10103ui_story then
				arg_360_1.var_.characterEffect10103ui_story.fillFlat = false
			end

			local var_363_4 = 0

			if var_363_4 < arg_360_1.time_ and arg_360_1.time_ <= var_363_4 + arg_363_0 then
				arg_360_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/story10103/story10103action/10103action4_1")
			end

			local var_363_5 = 0

			if var_363_5 < arg_360_1.time_ and arg_360_1.time_ <= var_363_5 + arg_363_0 then
				arg_360_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_363_6 = 0

			if var_363_6 < arg_360_1.time_ and arg_360_1.time_ <= var_363_6 + arg_363_0 then
				local var_363_7 = arg_360_1.actors_["10103ui_story"]

				if not isNil(var_363_7) then
					local var_363_8 = GameObjectTools.GetOrAddComponent(var_363_7, typeof(DynamicBoneHelper))

					if var_363_8 then
						var_363_8:EnableDynamicBone(true)
					end
				end
			end

			local var_363_9 = 0
			local var_363_10 = 0.275

			if var_363_9 < arg_360_1.time_ and arg_360_1.time_ <= var_363_9 + arg_363_0 then
				arg_360_1.talkMaxDuration = 0
				arg_360_1.dialogCg_.alpha = 1

				arg_360_1.dialog_:SetActive(true)
				SetActive(arg_360_1.leftNameGo_, true)

				local var_363_11 = arg_360_1:FormatText(StoryNameCfg[1214].name)

				arg_360_1.leftNameTxt_.text = var_363_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_360_1.leftNameTxt_.transform)

				arg_360_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_360_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_360_1:RecordName(arg_360_1.leftNameTxt_.text)
				SetActive(arg_360_1.iconTrs_.gameObject, false)
				arg_360_1.callingController_:SetSelectedState("normal")

				local var_363_12 = arg_360_1:GetWordFromCfg(322062087)
				local var_363_13 = arg_360_1:FormatText(var_363_12.content)

				arg_360_1.text_.text = var_363_13

				LuaForUtil.ClearLinePrefixSymbol(arg_360_1.text_)

				local var_363_14 = 11
				local var_363_15 = utf8.len(var_363_13)
				local var_363_16 = var_363_14 <= 0 and var_363_10 or var_363_10 * (var_363_15 / var_363_14)

				if var_363_16 > 0 and var_363_10 < var_363_16 then
					arg_360_1.talkMaxDuration = var_363_16

					if var_363_16 + var_363_9 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_16 + var_363_9
					end
				end

				arg_360_1.text_.text = var_363_13
				arg_360_1.typewritter.percent = 0

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062087", "story_v_out_322062.awb") ~= 0 then
					local var_363_17 = manager.audio:GetVoiceLength("story_v_out_322062", "322062087", "story_v_out_322062.awb") / 1000

					if var_363_17 + var_363_9 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_17 + var_363_9
					end

					if var_363_12.prefab_name ~= "" and arg_360_1.actors_[var_363_12.prefab_name] ~= nil then
						local var_363_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_360_1.actors_[var_363_12.prefab_name].transform, "story_v_out_322062", "322062087", "story_v_out_322062.awb")

						arg_360_1:RecordAudio("322062087", var_363_18)
						arg_360_1:RecordAudio("322062087", var_363_18)
					else
						arg_360_1:AudioAction("play", "voice", "story_v_out_322062", "322062087", "story_v_out_322062.awb")
					end

					arg_360_1:RecordHistoryTalkVoice("story_v_out_322062", "322062087", "story_v_out_322062.awb")
				end

				arg_360_1:RecordContent(arg_360_1.text_.text)
			end

			local var_363_19 = math.max(var_363_10, arg_360_1.talkMaxDuration)

			if var_363_9 <= arg_360_1.time_ and arg_360_1.time_ < var_363_9 + var_363_19 then
				arg_360_1.typewritter.percent = (arg_360_1.time_ - var_363_9) / var_363_19

				arg_360_1.typewritter:SetDirty()
			end

			if arg_360_1.time_ >= var_363_9 + var_363_19 and arg_360_1.time_ < var_363_9 + var_363_19 + arg_363_0 then
				arg_360_1.typewritter.percent = 1

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(true)
			end
		end

		arg_360_1.nodeConfigList_ = {}

		arg_360_1:InitPlayNodeList()
	end,
	Play322062088 = function(arg_364_0, arg_364_1)
		arg_364_1.time_ = 0
		arg_364_1.frameCnt_ = 0
		arg_364_1.state_ = "playing"
		arg_364_1.curTalkId_ = 322062088
		arg_364_1.duration_ = 6.5

		local var_364_0 = {
			zh = 3.766,
			ja = 6.5
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
				arg_364_0:Play322062089(arg_364_1)
			end
		end

		function arg_364_1.onSingleLineUpdate_(arg_367_0)
			local var_367_0 = arg_364_1.actors_["10103ui_story"]
			local var_367_1 = 0

			if var_367_1 < arg_364_1.time_ and arg_364_1.time_ <= var_367_1 + arg_367_0 and not isNil(var_367_0) and arg_364_1.var_.characterEffect10103ui_story == nil then
				arg_364_1.var_.characterEffect10103ui_story = var_367_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_367_2 = 0.200000002980232

			if var_367_1 <= arg_364_1.time_ and arg_364_1.time_ < var_367_1 + var_367_2 and not isNil(var_367_0) then
				local var_367_3 = (arg_364_1.time_ - var_367_1) / var_367_2

				if arg_364_1.var_.characterEffect10103ui_story and not isNil(var_367_0) then
					local var_367_4 = Mathf.Lerp(0, 0.5, var_367_3)

					arg_364_1.var_.characterEffect10103ui_story.fillFlat = true
					arg_364_1.var_.characterEffect10103ui_story.fillRatio = var_367_4
				end
			end

			if arg_364_1.time_ >= var_367_1 + var_367_2 and arg_364_1.time_ < var_367_1 + var_367_2 + arg_367_0 and not isNil(var_367_0) and arg_364_1.var_.characterEffect10103ui_story then
				local var_367_5 = 0.5

				arg_364_1.var_.characterEffect10103ui_story.fillFlat = true
				arg_364_1.var_.characterEffect10103ui_story.fillRatio = var_367_5
			end

			local var_367_6 = 0
			local var_367_7 = 0.4

			if var_367_6 < arg_364_1.time_ and arg_364_1.time_ <= var_367_6 + arg_367_0 then
				arg_364_1.talkMaxDuration = 0
				arg_364_1.dialogCg_.alpha = 1

				arg_364_1.dialog_:SetActive(true)
				SetActive(arg_364_1.leftNameGo_, true)

				local var_367_8 = arg_364_1:FormatText(StoryNameCfg[1031].name)

				arg_364_1.leftNameTxt_.text = var_367_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_364_1.leftNameTxt_.transform)

				arg_364_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_364_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_364_1:RecordName(arg_364_1.leftNameTxt_.text)
				SetActive(arg_364_1.iconTrs_.gameObject, true)
				arg_364_1.iconController_:SetSelectedState("hero")

				arg_364_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1089")

				arg_364_1.callingController_:SetSelectedState("normal")

				arg_364_1.keyicon_.color = Color.New(1, 1, 1)
				arg_364_1.icon_.color = Color.New(1, 1, 1)

				local var_367_9 = arg_364_1:GetWordFromCfg(322062088)
				local var_367_10 = arg_364_1:FormatText(var_367_9.content)

				arg_364_1.text_.text = var_367_10

				LuaForUtil.ClearLinePrefixSymbol(arg_364_1.text_)

				local var_367_11 = 16
				local var_367_12 = utf8.len(var_367_10)
				local var_367_13 = var_367_11 <= 0 and var_367_7 or var_367_7 * (var_367_12 / var_367_11)

				if var_367_13 > 0 and var_367_7 < var_367_13 then
					arg_364_1.talkMaxDuration = var_367_13

					if var_367_13 + var_367_6 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_13 + var_367_6
					end
				end

				arg_364_1.text_.text = var_367_10
				arg_364_1.typewritter.percent = 0

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062088", "story_v_out_322062.awb") ~= 0 then
					local var_367_14 = manager.audio:GetVoiceLength("story_v_out_322062", "322062088", "story_v_out_322062.awb") / 1000

					if var_367_14 + var_367_6 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_14 + var_367_6
					end

					if var_367_9.prefab_name ~= "" and arg_364_1.actors_[var_367_9.prefab_name] ~= nil then
						local var_367_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_364_1.actors_[var_367_9.prefab_name].transform, "story_v_out_322062", "322062088", "story_v_out_322062.awb")

						arg_364_1:RecordAudio("322062088", var_367_15)
						arg_364_1:RecordAudio("322062088", var_367_15)
					else
						arg_364_1:AudioAction("play", "voice", "story_v_out_322062", "322062088", "story_v_out_322062.awb")
					end

					arg_364_1:RecordHistoryTalkVoice("story_v_out_322062", "322062088", "story_v_out_322062.awb")
				end

				arg_364_1:RecordContent(arg_364_1.text_.text)
			end

			local var_367_16 = math.max(var_367_7, arg_364_1.talkMaxDuration)

			if var_367_6 <= arg_364_1.time_ and arg_364_1.time_ < var_367_6 + var_367_16 then
				arg_364_1.typewritter.percent = (arg_364_1.time_ - var_367_6) / var_367_16

				arg_364_1.typewritter:SetDirty()
			end

			if arg_364_1.time_ >= var_367_6 + var_367_16 and arg_364_1.time_ < var_367_6 + var_367_16 + arg_367_0 then
				arg_364_1.typewritter.percent = 1

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(true)
			end
		end

		arg_364_1.nodeConfigList_ = {}

		arg_364_1:InitPlayNodeList()
	end,
	Play322062089 = function(arg_368_0, arg_368_1)
		arg_368_1.time_ = 0
		arg_368_1.frameCnt_ = 0
		arg_368_1.state_ = "playing"
		arg_368_1.curTalkId_ = 322062089
		arg_368_1.duration_ = 2.2

		local var_368_0 = {
			zh = 1.999999999999,
			ja = 2.2
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
				arg_368_0:Play322062090(arg_368_1)
			end
		end

		function arg_368_1.onSingleLineUpdate_(arg_371_0)
			local var_371_0 = arg_368_1.actors_["10103ui_story"]
			local var_371_1 = 0

			if var_371_1 < arg_368_1.time_ and arg_368_1.time_ <= var_371_1 + arg_371_0 and not isNil(var_371_0) and arg_368_1.var_.characterEffect10103ui_story == nil then
				arg_368_1.var_.characterEffect10103ui_story = var_371_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_371_2 = 0.200000002980232

			if var_371_1 <= arg_368_1.time_ and arg_368_1.time_ < var_371_1 + var_371_2 and not isNil(var_371_0) then
				local var_371_3 = (arg_368_1.time_ - var_371_1) / var_371_2

				if arg_368_1.var_.characterEffect10103ui_story and not isNil(var_371_0) then
					arg_368_1.var_.characterEffect10103ui_story.fillFlat = false
				end
			end

			if arg_368_1.time_ >= var_371_1 + var_371_2 and arg_368_1.time_ < var_371_1 + var_371_2 + arg_371_0 and not isNil(var_371_0) and arg_368_1.var_.characterEffect10103ui_story then
				arg_368_1.var_.characterEffect10103ui_story.fillFlat = false
			end

			local var_371_4 = 0

			if var_371_4 < arg_368_1.time_ and arg_368_1.time_ <= var_371_4 + arg_371_0 then
				arg_368_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/story10103/story10103actionlink/10103action448")
			end

			local var_371_5 = 0

			if var_371_5 < arg_368_1.time_ and arg_368_1.time_ <= var_371_5 + arg_371_0 then
				arg_368_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaC", "EmotionTimelineAnimator")
			end

			local var_371_6 = 0

			if var_371_6 < arg_368_1.time_ and arg_368_1.time_ <= var_371_6 + arg_371_0 then
				local var_371_7 = arg_368_1.actors_["10103ui_story"]

				if not isNil(var_371_7) then
					local var_371_8 = GameObjectTools.GetOrAddComponent(var_371_7, typeof(DynamicBoneHelper))

					if var_371_8 then
						var_371_8:EnableDynamicBone(true)
					end
				end
			end

			local var_371_9 = 0
			local var_371_10 = 0.05

			if var_371_9 < arg_368_1.time_ and arg_368_1.time_ <= var_371_9 + arg_371_0 then
				arg_368_1.talkMaxDuration = 0
				arg_368_1.dialogCg_.alpha = 1

				arg_368_1.dialog_:SetActive(true)
				SetActive(arg_368_1.leftNameGo_, true)

				local var_371_11 = arg_368_1:FormatText(StoryNameCfg[1214].name)

				arg_368_1.leftNameTxt_.text = var_371_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_368_1.leftNameTxt_.transform)

				arg_368_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_368_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_368_1:RecordName(arg_368_1.leftNameTxt_.text)
				SetActive(arg_368_1.iconTrs_.gameObject, false)
				arg_368_1.callingController_:SetSelectedState("normal")

				local var_371_12 = arg_368_1:GetWordFromCfg(322062089)
				local var_371_13 = arg_368_1:FormatText(var_371_12.content)

				arg_368_1.text_.text = var_371_13

				LuaForUtil.ClearLinePrefixSymbol(arg_368_1.text_)

				local var_371_14 = 2
				local var_371_15 = utf8.len(var_371_13)
				local var_371_16 = var_371_14 <= 0 and var_371_10 or var_371_10 * (var_371_15 / var_371_14)

				if var_371_16 > 0 and var_371_10 < var_371_16 then
					arg_368_1.talkMaxDuration = var_371_16

					if var_371_16 + var_371_9 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_16 + var_371_9
					end
				end

				arg_368_1.text_.text = var_371_13
				arg_368_1.typewritter.percent = 0

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062089", "story_v_out_322062.awb") ~= 0 then
					local var_371_17 = manager.audio:GetVoiceLength("story_v_out_322062", "322062089", "story_v_out_322062.awb") / 1000

					if var_371_17 + var_371_9 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_17 + var_371_9
					end

					if var_371_12.prefab_name ~= "" and arg_368_1.actors_[var_371_12.prefab_name] ~= nil then
						local var_371_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_368_1.actors_[var_371_12.prefab_name].transform, "story_v_out_322062", "322062089", "story_v_out_322062.awb")

						arg_368_1:RecordAudio("322062089", var_371_18)
						arg_368_1:RecordAudio("322062089", var_371_18)
					else
						arg_368_1:AudioAction("play", "voice", "story_v_out_322062", "322062089", "story_v_out_322062.awb")
					end

					arg_368_1:RecordHistoryTalkVoice("story_v_out_322062", "322062089", "story_v_out_322062.awb")
				end

				arg_368_1:RecordContent(arg_368_1.text_.text)
			end

			local var_371_19 = math.max(var_371_10, arg_368_1.talkMaxDuration)

			if var_371_9 <= arg_368_1.time_ and arg_368_1.time_ < var_371_9 + var_371_19 then
				arg_368_1.typewritter.percent = (arg_368_1.time_ - var_371_9) / var_371_19

				arg_368_1.typewritter:SetDirty()
			end

			if arg_368_1.time_ >= var_371_9 + var_371_19 and arg_368_1.time_ < var_371_9 + var_371_19 + arg_371_0 then
				arg_368_1.typewritter.percent = 1

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(true)
			end
		end

		arg_368_1.nodeConfigList_ = {}

		arg_368_1:InitPlayNodeList()
	end,
	Play322062090 = function(arg_372_0, arg_372_1)
		arg_372_1.time_ = 0
		arg_372_1.frameCnt_ = 0
		arg_372_1.state_ = "playing"
		arg_372_1.curTalkId_ = 322062090
		arg_372_1.duration_ = 6.5

		local var_372_0 = {
			zh = 3.733,
			ja = 6.5
		}
		local var_372_1 = manager.audio:GetLocalizationFlag()

		if var_372_0[var_372_1] ~= nil then
			arg_372_1.duration_ = var_372_0[var_372_1]
		end

		SetActive(arg_372_1.tipsGo_, false)

		function arg_372_1.onSingleLineFinish_()
			arg_372_1.onSingleLineUpdate_ = nil
			arg_372_1.onSingleLineFinish_ = nil
			arg_372_1.state_ = "waiting"
		end

		function arg_372_1.playNext_(arg_374_0)
			if arg_374_0 == 1 then
				arg_372_0:Play322062091(arg_372_1)
			end
		end

		function arg_372_1.onSingleLineUpdate_(arg_375_0)
			local var_375_0 = arg_372_1.actors_["10103ui_story"]
			local var_375_1 = 0

			if var_375_1 < arg_372_1.time_ and arg_372_1.time_ <= var_375_1 + arg_375_0 and not isNil(var_375_0) and arg_372_1.var_.characterEffect10103ui_story == nil then
				arg_372_1.var_.characterEffect10103ui_story = var_375_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_375_2 = 0.200000002980232

			if var_375_1 <= arg_372_1.time_ and arg_372_1.time_ < var_375_1 + var_375_2 and not isNil(var_375_0) then
				local var_375_3 = (arg_372_1.time_ - var_375_1) / var_375_2

				if arg_372_1.var_.characterEffect10103ui_story and not isNil(var_375_0) then
					local var_375_4 = Mathf.Lerp(0, 0.5, var_375_3)

					arg_372_1.var_.characterEffect10103ui_story.fillFlat = true
					arg_372_1.var_.characterEffect10103ui_story.fillRatio = var_375_4
				end
			end

			if arg_372_1.time_ >= var_375_1 + var_375_2 and arg_372_1.time_ < var_375_1 + var_375_2 + arg_375_0 and not isNil(var_375_0) and arg_372_1.var_.characterEffect10103ui_story then
				local var_375_5 = 0.5

				arg_372_1.var_.characterEffect10103ui_story.fillFlat = true
				arg_372_1.var_.characterEffect10103ui_story.fillRatio = var_375_5
			end

			local var_375_6 = 0
			local var_375_7 = 0.325

			if var_375_6 < arg_372_1.time_ and arg_372_1.time_ <= var_375_6 + arg_375_0 then
				arg_372_1.talkMaxDuration = 0
				arg_372_1.dialogCg_.alpha = 1

				arg_372_1.dialog_:SetActive(true)
				SetActive(arg_372_1.leftNameGo_, true)

				local var_375_8 = arg_372_1:FormatText(StoryNameCfg[1031].name)

				arg_372_1.leftNameTxt_.text = var_375_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_372_1.leftNameTxt_.transform)

				arg_372_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_372_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_372_1:RecordName(arg_372_1.leftNameTxt_.text)
				SetActive(arg_372_1.iconTrs_.gameObject, true)
				arg_372_1.iconController_:SetSelectedState("hero")

				arg_372_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1089")

				arg_372_1.callingController_:SetSelectedState("normal")

				arg_372_1.keyicon_.color = Color.New(1, 1, 1)
				arg_372_1.icon_.color = Color.New(1, 1, 1)

				local var_375_9 = arg_372_1:GetWordFromCfg(322062090)
				local var_375_10 = arg_372_1:FormatText(var_375_9.content)

				arg_372_1.text_.text = var_375_10

				LuaForUtil.ClearLinePrefixSymbol(arg_372_1.text_)

				local var_375_11 = 13
				local var_375_12 = utf8.len(var_375_10)
				local var_375_13 = var_375_11 <= 0 and var_375_7 or var_375_7 * (var_375_12 / var_375_11)

				if var_375_13 > 0 and var_375_7 < var_375_13 then
					arg_372_1.talkMaxDuration = var_375_13

					if var_375_13 + var_375_6 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_13 + var_375_6
					end
				end

				arg_372_1.text_.text = var_375_10
				arg_372_1.typewritter.percent = 0

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062090", "story_v_out_322062.awb") ~= 0 then
					local var_375_14 = manager.audio:GetVoiceLength("story_v_out_322062", "322062090", "story_v_out_322062.awb") / 1000

					if var_375_14 + var_375_6 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_14 + var_375_6
					end

					if var_375_9.prefab_name ~= "" and arg_372_1.actors_[var_375_9.prefab_name] ~= nil then
						local var_375_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_372_1.actors_[var_375_9.prefab_name].transform, "story_v_out_322062", "322062090", "story_v_out_322062.awb")

						arg_372_1:RecordAudio("322062090", var_375_15)
						arg_372_1:RecordAudio("322062090", var_375_15)
					else
						arg_372_1:AudioAction("play", "voice", "story_v_out_322062", "322062090", "story_v_out_322062.awb")
					end

					arg_372_1:RecordHistoryTalkVoice("story_v_out_322062", "322062090", "story_v_out_322062.awb")
				end

				arg_372_1:RecordContent(arg_372_1.text_.text)
			end

			local var_375_16 = math.max(var_375_7, arg_372_1.talkMaxDuration)

			if var_375_6 <= arg_372_1.time_ and arg_372_1.time_ < var_375_6 + var_375_16 then
				arg_372_1.typewritter.percent = (arg_372_1.time_ - var_375_6) / var_375_16

				arg_372_1.typewritter:SetDirty()
			end

			if arg_372_1.time_ >= var_375_6 + var_375_16 and arg_372_1.time_ < var_375_6 + var_375_16 + arg_375_0 then
				arg_372_1.typewritter.percent = 1

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(true)
			end
		end

		arg_372_1.nodeConfigList_ = {}

		arg_372_1:InitPlayNodeList()
	end,
	Play322062091 = function(arg_376_0, arg_376_1)
		arg_376_1.time_ = 0
		arg_376_1.frameCnt_ = 0
		arg_376_1.state_ = "playing"
		arg_376_1.curTalkId_ = 322062091
		arg_376_1.duration_ = 5.3

		local var_376_0 = {
			zh = 2.833,
			ja = 5.3
		}
		local var_376_1 = manager.audio:GetLocalizationFlag()

		if var_376_0[var_376_1] ~= nil then
			arg_376_1.duration_ = var_376_0[var_376_1]
		end

		SetActive(arg_376_1.tipsGo_, false)

		function arg_376_1.onSingleLineFinish_()
			arg_376_1.onSingleLineUpdate_ = nil
			arg_376_1.onSingleLineFinish_ = nil
			arg_376_1.state_ = "waiting"
		end

		function arg_376_1.playNext_(arg_378_0)
			if arg_378_0 == 1 then
				arg_376_0:Play322062092(arg_376_1)
			end
		end

		function arg_376_1.onSingleLineUpdate_(arg_379_0)
			local var_379_0 = arg_376_1.actors_["10103ui_story"]
			local var_379_1 = 0

			if var_379_1 < arg_376_1.time_ and arg_376_1.time_ <= var_379_1 + arg_379_0 and not isNil(var_379_0) and arg_376_1.var_.characterEffect10103ui_story == nil then
				arg_376_1.var_.characterEffect10103ui_story = var_379_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_379_2 = 0.200000002980232

			if var_379_1 <= arg_376_1.time_ and arg_376_1.time_ < var_379_1 + var_379_2 and not isNil(var_379_0) then
				local var_379_3 = (arg_376_1.time_ - var_379_1) / var_379_2

				if arg_376_1.var_.characterEffect10103ui_story and not isNil(var_379_0) then
					arg_376_1.var_.characterEffect10103ui_story.fillFlat = false
				end
			end

			if arg_376_1.time_ >= var_379_1 + var_379_2 and arg_376_1.time_ < var_379_1 + var_379_2 + arg_379_0 and not isNil(var_379_0) and arg_376_1.var_.characterEffect10103ui_story then
				arg_376_1.var_.characterEffect10103ui_story.fillFlat = false
			end

			local var_379_4 = 0

			if var_379_4 < arg_376_1.time_ and arg_376_1.time_ <= var_379_4 + arg_379_0 then
				arg_376_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/story10103/story10103action/10103action8_2")
			end

			local var_379_5 = 0

			if var_379_5 < arg_376_1.time_ and arg_376_1.time_ <= var_379_5 + arg_379_0 then
				arg_376_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_379_6 = 0

			if var_379_6 < arg_376_1.time_ and arg_376_1.time_ <= var_379_6 + arg_379_0 then
				local var_379_7 = arg_376_1.actors_["10103ui_story"]

				if not isNil(var_379_7) then
					local var_379_8 = GameObjectTools.GetOrAddComponent(var_379_7, typeof(DynamicBoneHelper))

					if var_379_8 then
						var_379_8:EnableDynamicBone(true)
					end
				end
			end

			local var_379_9 = 0
			local var_379_10 = 0.25

			if var_379_9 < arg_376_1.time_ and arg_376_1.time_ <= var_379_9 + arg_379_0 then
				arg_376_1.talkMaxDuration = 0
				arg_376_1.dialogCg_.alpha = 1

				arg_376_1.dialog_:SetActive(true)
				SetActive(arg_376_1.leftNameGo_, true)

				local var_379_11 = arg_376_1:FormatText(StoryNameCfg[1214].name)

				arg_376_1.leftNameTxt_.text = var_379_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_376_1.leftNameTxt_.transform)

				arg_376_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_376_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_376_1:RecordName(arg_376_1.leftNameTxt_.text)
				SetActive(arg_376_1.iconTrs_.gameObject, false)
				arg_376_1.callingController_:SetSelectedState("normal")

				local var_379_12 = arg_376_1:GetWordFromCfg(322062091)
				local var_379_13 = arg_376_1:FormatText(var_379_12.content)

				arg_376_1.text_.text = var_379_13

				LuaForUtil.ClearLinePrefixSymbol(arg_376_1.text_)

				local var_379_14 = 10
				local var_379_15 = utf8.len(var_379_13)
				local var_379_16 = var_379_14 <= 0 and var_379_10 or var_379_10 * (var_379_15 / var_379_14)

				if var_379_16 > 0 and var_379_10 < var_379_16 then
					arg_376_1.talkMaxDuration = var_379_16

					if var_379_16 + var_379_9 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_16 + var_379_9
					end
				end

				arg_376_1.text_.text = var_379_13
				arg_376_1.typewritter.percent = 0

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062091", "story_v_out_322062.awb") ~= 0 then
					local var_379_17 = manager.audio:GetVoiceLength("story_v_out_322062", "322062091", "story_v_out_322062.awb") / 1000

					if var_379_17 + var_379_9 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_17 + var_379_9
					end

					if var_379_12.prefab_name ~= "" and arg_376_1.actors_[var_379_12.prefab_name] ~= nil then
						local var_379_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_376_1.actors_[var_379_12.prefab_name].transform, "story_v_out_322062", "322062091", "story_v_out_322062.awb")

						arg_376_1:RecordAudio("322062091", var_379_18)
						arg_376_1:RecordAudio("322062091", var_379_18)
					else
						arg_376_1:AudioAction("play", "voice", "story_v_out_322062", "322062091", "story_v_out_322062.awb")
					end

					arg_376_1:RecordHistoryTalkVoice("story_v_out_322062", "322062091", "story_v_out_322062.awb")
				end

				arg_376_1:RecordContent(arg_376_1.text_.text)
			end

			local var_379_19 = math.max(var_379_10, arg_376_1.talkMaxDuration)

			if var_379_9 <= arg_376_1.time_ and arg_376_1.time_ < var_379_9 + var_379_19 then
				arg_376_1.typewritter.percent = (arg_376_1.time_ - var_379_9) / var_379_19

				arg_376_1.typewritter:SetDirty()
			end

			if arg_376_1.time_ >= var_379_9 + var_379_19 and arg_376_1.time_ < var_379_9 + var_379_19 + arg_379_0 then
				arg_376_1.typewritter.percent = 1

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(true)
			end
		end

		arg_376_1.nodeConfigList_ = {}

		arg_376_1:InitPlayNodeList()
	end,
	Play322062092 = function(arg_380_0, arg_380_1)
		arg_380_1.time_ = 0
		arg_380_1.frameCnt_ = 0
		arg_380_1.state_ = "playing"
		arg_380_1.curTalkId_ = 322062092
		arg_380_1.duration_ = 1.6

		local var_380_0 = {
			zh = 1.533,
			ja = 1.6
		}
		local var_380_1 = manager.audio:GetLocalizationFlag()

		if var_380_0[var_380_1] ~= nil then
			arg_380_1.duration_ = var_380_0[var_380_1]
		end

		SetActive(arg_380_1.tipsGo_, false)

		function arg_380_1.onSingleLineFinish_()
			arg_380_1.onSingleLineUpdate_ = nil
			arg_380_1.onSingleLineFinish_ = nil
			arg_380_1.state_ = "waiting"
		end

		function arg_380_1.playNext_(arg_382_0)
			if arg_382_0 == 1 then
				arg_380_0:Play322062093(arg_380_1)
			end
		end

		function arg_380_1.onSingleLineUpdate_(arg_383_0)
			local var_383_0 = arg_380_1.actors_["10103ui_story"]
			local var_383_1 = 0

			if var_383_1 < arg_380_1.time_ and arg_380_1.time_ <= var_383_1 + arg_383_0 and not isNil(var_383_0) and arg_380_1.var_.characterEffect10103ui_story == nil then
				arg_380_1.var_.characterEffect10103ui_story = var_383_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_383_2 = 0.200000002980232

			if var_383_1 <= arg_380_1.time_ and arg_380_1.time_ < var_383_1 + var_383_2 and not isNil(var_383_0) then
				local var_383_3 = (arg_380_1.time_ - var_383_1) / var_383_2

				if arg_380_1.var_.characterEffect10103ui_story and not isNil(var_383_0) then
					local var_383_4 = Mathf.Lerp(0, 0.5, var_383_3)

					arg_380_1.var_.characterEffect10103ui_story.fillFlat = true
					arg_380_1.var_.characterEffect10103ui_story.fillRatio = var_383_4
				end
			end

			if arg_380_1.time_ >= var_383_1 + var_383_2 and arg_380_1.time_ < var_383_1 + var_383_2 + arg_383_0 and not isNil(var_383_0) and arg_380_1.var_.characterEffect10103ui_story then
				local var_383_5 = 0.5

				arg_380_1.var_.characterEffect10103ui_story.fillFlat = true
				arg_380_1.var_.characterEffect10103ui_story.fillRatio = var_383_5
			end

			local var_383_6 = 0
			local var_383_7 = 0.175

			if var_383_6 < arg_380_1.time_ and arg_380_1.time_ <= var_383_6 + arg_383_0 then
				arg_380_1.talkMaxDuration = 0
				arg_380_1.dialogCg_.alpha = 1

				arg_380_1.dialog_:SetActive(true)
				SetActive(arg_380_1.leftNameGo_, true)

				local var_383_8 = arg_380_1:FormatText(StoryNameCfg[1031].name)

				arg_380_1.leftNameTxt_.text = var_383_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_380_1.leftNameTxt_.transform)

				arg_380_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_380_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_380_1:RecordName(arg_380_1.leftNameTxt_.text)
				SetActive(arg_380_1.iconTrs_.gameObject, true)
				arg_380_1.iconController_:SetSelectedState("hero")

				arg_380_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1089")

				arg_380_1.callingController_:SetSelectedState("normal")

				arg_380_1.keyicon_.color = Color.New(1, 1, 1)
				arg_380_1.icon_.color = Color.New(1, 1, 1)

				local var_383_9 = arg_380_1:GetWordFromCfg(322062092)
				local var_383_10 = arg_380_1:FormatText(var_383_9.content)

				arg_380_1.text_.text = var_383_10

				LuaForUtil.ClearLinePrefixSymbol(arg_380_1.text_)

				local var_383_11 = 7
				local var_383_12 = utf8.len(var_383_10)
				local var_383_13 = var_383_11 <= 0 and var_383_7 or var_383_7 * (var_383_12 / var_383_11)

				if var_383_13 > 0 and var_383_7 < var_383_13 then
					arg_380_1.talkMaxDuration = var_383_13

					if var_383_13 + var_383_6 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_13 + var_383_6
					end
				end

				arg_380_1.text_.text = var_383_10
				arg_380_1.typewritter.percent = 0

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062092", "story_v_out_322062.awb") ~= 0 then
					local var_383_14 = manager.audio:GetVoiceLength("story_v_out_322062", "322062092", "story_v_out_322062.awb") / 1000

					if var_383_14 + var_383_6 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_14 + var_383_6
					end

					if var_383_9.prefab_name ~= "" and arg_380_1.actors_[var_383_9.prefab_name] ~= nil then
						local var_383_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_380_1.actors_[var_383_9.prefab_name].transform, "story_v_out_322062", "322062092", "story_v_out_322062.awb")

						arg_380_1:RecordAudio("322062092", var_383_15)
						arg_380_1:RecordAudio("322062092", var_383_15)
					else
						arg_380_1:AudioAction("play", "voice", "story_v_out_322062", "322062092", "story_v_out_322062.awb")
					end

					arg_380_1:RecordHistoryTalkVoice("story_v_out_322062", "322062092", "story_v_out_322062.awb")
				end

				arg_380_1:RecordContent(arg_380_1.text_.text)
			end

			local var_383_16 = math.max(var_383_7, arg_380_1.talkMaxDuration)

			if var_383_6 <= arg_380_1.time_ and arg_380_1.time_ < var_383_6 + var_383_16 then
				arg_380_1.typewritter.percent = (arg_380_1.time_ - var_383_6) / var_383_16

				arg_380_1.typewritter:SetDirty()
			end

			if arg_380_1.time_ >= var_383_6 + var_383_16 and arg_380_1.time_ < var_383_6 + var_383_16 + arg_383_0 then
				arg_380_1.typewritter.percent = 1

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(true)
			end
		end

		arg_380_1.nodeConfigList_ = {}

		arg_380_1:InitPlayNodeList()
	end,
	Play322062093 = function(arg_384_0, arg_384_1)
		arg_384_1.time_ = 0
		arg_384_1.frameCnt_ = 0
		arg_384_1.state_ = "playing"
		arg_384_1.curTalkId_ = 322062093
		arg_384_1.duration_ = 2.37

		local var_384_0 = {
			zh = 1.666,
			ja = 2.366
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
				arg_384_0:Play322062094(arg_384_1)
			end
		end

		function arg_384_1.onSingleLineUpdate_(arg_387_0)
			local var_387_0 = arg_384_1.actors_["10103ui_story"]
			local var_387_1 = 0

			if var_387_1 < arg_384_1.time_ and arg_384_1.time_ <= var_387_1 + arg_387_0 and not isNil(var_387_0) and arg_384_1.var_.characterEffect10103ui_story == nil then
				arg_384_1.var_.characterEffect10103ui_story = var_387_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_387_2 = 0.200000002980232

			if var_387_1 <= arg_384_1.time_ and arg_384_1.time_ < var_387_1 + var_387_2 and not isNil(var_387_0) then
				local var_387_3 = (arg_384_1.time_ - var_387_1) / var_387_2

				if arg_384_1.var_.characterEffect10103ui_story and not isNil(var_387_0) then
					arg_384_1.var_.characterEffect10103ui_story.fillFlat = false
				end
			end

			if arg_384_1.time_ >= var_387_1 + var_387_2 and arg_384_1.time_ < var_387_1 + var_387_2 + arg_387_0 and not isNil(var_387_0) and arg_384_1.var_.characterEffect10103ui_story then
				arg_384_1.var_.characterEffect10103ui_story.fillFlat = false
			end

			local var_387_4 = 0
			local var_387_5 = 0.15

			if var_387_4 < arg_384_1.time_ and arg_384_1.time_ <= var_387_4 + arg_387_0 then
				arg_384_1.talkMaxDuration = 0
				arg_384_1.dialogCg_.alpha = 1

				arg_384_1.dialog_:SetActive(true)
				SetActive(arg_384_1.leftNameGo_, true)

				local var_387_6 = arg_384_1:FormatText(StoryNameCfg[1214].name)

				arg_384_1.leftNameTxt_.text = var_387_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_384_1.leftNameTxt_.transform)

				arg_384_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_384_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_384_1:RecordName(arg_384_1.leftNameTxt_.text)
				SetActive(arg_384_1.iconTrs_.gameObject, false)
				arg_384_1.callingController_:SetSelectedState("normal")

				local var_387_7 = arg_384_1:GetWordFromCfg(322062093)
				local var_387_8 = arg_384_1:FormatText(var_387_7.content)

				arg_384_1.text_.text = var_387_8

				LuaForUtil.ClearLinePrefixSymbol(arg_384_1.text_)

				local var_387_9 = 6
				local var_387_10 = utf8.len(var_387_8)
				local var_387_11 = var_387_9 <= 0 and var_387_5 or var_387_5 * (var_387_10 / var_387_9)

				if var_387_11 > 0 and var_387_5 < var_387_11 then
					arg_384_1.talkMaxDuration = var_387_11

					if var_387_11 + var_387_4 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_11 + var_387_4
					end
				end

				arg_384_1.text_.text = var_387_8
				arg_384_1.typewritter.percent = 0

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062093", "story_v_out_322062.awb") ~= 0 then
					local var_387_12 = manager.audio:GetVoiceLength("story_v_out_322062", "322062093", "story_v_out_322062.awb") / 1000

					if var_387_12 + var_387_4 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_12 + var_387_4
					end

					if var_387_7.prefab_name ~= "" and arg_384_1.actors_[var_387_7.prefab_name] ~= nil then
						local var_387_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_384_1.actors_[var_387_7.prefab_name].transform, "story_v_out_322062", "322062093", "story_v_out_322062.awb")

						arg_384_1:RecordAudio("322062093", var_387_13)
						arg_384_1:RecordAudio("322062093", var_387_13)
					else
						arg_384_1:AudioAction("play", "voice", "story_v_out_322062", "322062093", "story_v_out_322062.awb")
					end

					arg_384_1:RecordHistoryTalkVoice("story_v_out_322062", "322062093", "story_v_out_322062.awb")
				end

				arg_384_1:RecordContent(arg_384_1.text_.text)
			end

			local var_387_14 = math.max(var_387_5, arg_384_1.talkMaxDuration)

			if var_387_4 <= arg_384_1.time_ and arg_384_1.time_ < var_387_4 + var_387_14 then
				arg_384_1.typewritter.percent = (arg_384_1.time_ - var_387_4) / var_387_14

				arg_384_1.typewritter:SetDirty()
			end

			if arg_384_1.time_ >= var_387_4 + var_387_14 and arg_384_1.time_ < var_387_4 + var_387_14 + arg_387_0 then
				arg_384_1.typewritter.percent = 1

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(true)
			end
		end

		arg_384_1.nodeConfigList_ = {}

		arg_384_1:InitPlayNodeList()
	end,
	Play322062094 = function(arg_388_0, arg_388_1)
		arg_388_1.time_ = 0
		arg_388_1.frameCnt_ = 0
		arg_388_1.state_ = "playing"
		arg_388_1.curTalkId_ = 322062094
		arg_388_1.duration_ = 5

		SetActive(arg_388_1.tipsGo_, false)

		function arg_388_1.onSingleLineFinish_()
			arg_388_1.onSingleLineUpdate_ = nil
			arg_388_1.onSingleLineFinish_ = nil
			arg_388_1.state_ = "waiting"
		end

		function arg_388_1.playNext_(arg_390_0)
			if arg_390_0 == 1 then
				arg_388_0:Play322062095(arg_388_1)
			end
		end

		function arg_388_1.onSingleLineUpdate_(arg_391_0)
			local var_391_0 = arg_388_1.actors_["10103ui_story"].transform
			local var_391_1 = 0

			if var_391_1 < arg_388_1.time_ and arg_388_1.time_ <= var_391_1 + arg_391_0 then
				arg_388_1.var_.moveOldPos10103ui_story = var_391_0.localPosition

				local var_391_2 = GameObjectTools.GetOrAddComponent(var_391_0.gameObject, typeof(DynamicBoneHelper))

				if var_391_2 then
					var_391_2:EnableDynamicBone(false)
				end
			end

			local var_391_3 = 0.001

			if var_391_1 <= arg_388_1.time_ and arg_388_1.time_ < var_391_1 + var_391_3 then
				local var_391_4 = (arg_388_1.time_ - var_391_1) / var_391_3
				local var_391_5 = Vector3.New(0, 100, 0)

				var_391_0.localPosition = Vector3.Lerp(arg_388_1.var_.moveOldPos10103ui_story, var_391_5, var_391_4)

				local var_391_6 = manager.ui.mainCamera.transform.position - var_391_0.position

				var_391_0.forward = Vector3.New(var_391_6.x, var_391_6.y, var_391_6.z)

				local var_391_7 = var_391_0.localEulerAngles

				var_391_7.z = 0
				var_391_7.x = 0
				var_391_0.localEulerAngles = var_391_7
			end

			if arg_388_1.time_ >= var_391_1 + var_391_3 and arg_388_1.time_ < var_391_1 + var_391_3 + arg_391_0 then
				var_391_0.localPosition = Vector3.New(0, 100, 0)

				local var_391_8 = manager.ui.mainCamera.transform.position - var_391_0.position

				var_391_0.forward = Vector3.New(var_391_8.x, var_391_8.y, var_391_8.z)

				local var_391_9 = var_391_0.localEulerAngles

				var_391_9.z = 0
				var_391_9.x = 0
				var_391_0.localEulerAngles = var_391_9

				local var_391_10 = GameObjectTools.GetOrAddComponent(var_391_0.gameObject, typeof(DynamicBoneHelper))

				if var_391_10 then
					var_391_10:EnableDynamicBone(true)
				end
			end

			local var_391_11 = arg_388_1.actors_["1089ui_story"].transform
			local var_391_12 = 0

			if var_391_12 < arg_388_1.time_ and arg_388_1.time_ <= var_391_12 + arg_391_0 then
				arg_388_1.var_.moveOldPos1089ui_story = var_391_11.localPosition
			end

			local var_391_13 = 0.001

			if var_391_12 <= arg_388_1.time_ and arg_388_1.time_ < var_391_12 + var_391_13 then
				local var_391_14 = (arg_388_1.time_ - var_391_12) / var_391_13
				local var_391_15 = Vector3.New(0, 100, 0)

				var_391_11.localPosition = Vector3.Lerp(arg_388_1.var_.moveOldPos1089ui_story, var_391_15, var_391_14)

				local var_391_16 = manager.ui.mainCamera.transform.position - var_391_11.position

				var_391_11.forward = Vector3.New(var_391_16.x, var_391_16.y, var_391_16.z)

				local var_391_17 = var_391_11.localEulerAngles

				var_391_17.z = 0
				var_391_17.x = 0
				var_391_11.localEulerAngles = var_391_17
			end

			if arg_388_1.time_ >= var_391_12 + var_391_13 and arg_388_1.time_ < var_391_12 + var_391_13 + arg_391_0 then
				var_391_11.localPosition = Vector3.New(0, 100, 0)

				local var_391_18 = manager.ui.mainCamera.transform.position - var_391_11.position

				var_391_11.forward = Vector3.New(var_391_18.x, var_391_18.y, var_391_18.z)

				local var_391_19 = var_391_11.localEulerAngles

				var_391_19.z = 0
				var_391_19.x = 0
				var_391_11.localEulerAngles = var_391_19
			end

			local var_391_20 = 0.9
			local var_391_21 = 1

			if var_391_20 < arg_388_1.time_ and arg_388_1.time_ <= var_391_20 + arg_391_0 then
				local var_391_22 = "play"
				local var_391_23 = "effect"

				arg_388_1:AudioAction(var_391_22, var_391_23, "se_story_145", "se_story_145_cup_paper", "")
			end

			local var_391_24 = 0
			local var_391_25 = 1.15

			if var_391_24 < arg_388_1.time_ and arg_388_1.time_ <= var_391_24 + arg_391_0 then
				arg_388_1.talkMaxDuration = 0
				arg_388_1.dialogCg_.alpha = 1

				arg_388_1.dialog_:SetActive(true)
				SetActive(arg_388_1.leftNameGo_, false)

				arg_388_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_388_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_388_1:RecordName(arg_388_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_388_1.iconTrs_.gameObject, false)
				arg_388_1.callingController_:SetSelectedState("normal")

				local var_391_26 = arg_388_1:GetWordFromCfg(322062094)
				local var_391_27 = arg_388_1:FormatText(var_391_26.content)

				arg_388_1.text_.text = var_391_27

				LuaForUtil.ClearLinePrefixSymbol(arg_388_1.text_)

				local var_391_28 = 46
				local var_391_29 = utf8.len(var_391_27)
				local var_391_30 = var_391_28 <= 0 and var_391_25 or var_391_25 * (var_391_29 / var_391_28)

				if var_391_30 > 0 and var_391_25 < var_391_30 then
					arg_388_1.talkMaxDuration = var_391_30

					if var_391_30 + var_391_24 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_30 + var_391_24
					end
				end

				arg_388_1.text_.text = var_391_27
				arg_388_1.typewritter.percent = 0

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(false)
				arg_388_1:RecordContent(arg_388_1.text_.text)
			end

			local var_391_31 = math.max(var_391_25, arg_388_1.talkMaxDuration)

			if var_391_24 <= arg_388_1.time_ and arg_388_1.time_ < var_391_24 + var_391_31 then
				arg_388_1.typewritter.percent = (arg_388_1.time_ - var_391_24) / var_391_31

				arg_388_1.typewritter:SetDirty()
			end

			if arg_388_1.time_ >= var_391_24 + var_391_31 and arg_388_1.time_ < var_391_24 + var_391_31 + arg_391_0 then
				arg_388_1.typewritter.percent = 1

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(true)
			end
		end

		arg_388_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_388_1:InitPlayNodeList()
	end,
	Play322062095 = function(arg_392_0, arg_392_1)
		arg_392_1.time_ = 0
		arg_392_1.frameCnt_ = 0
		arg_392_1.state_ = "playing"
		arg_392_1.curTalkId_ = 322062095
		arg_392_1.duration_ = 4.27

		local var_392_0 = {
			zh = 2.1,
			ja = 4.266
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
				arg_392_0:Play322062096(arg_392_1)
			end
		end

		function arg_392_1.onSingleLineUpdate_(arg_395_0)
			local var_395_0 = arg_392_1.actors_["10103ui_story"].transform
			local var_395_1 = 0

			if var_395_1 < arg_392_1.time_ and arg_392_1.time_ <= var_395_1 + arg_395_0 then
				arg_392_1.var_.moveOldPos10103ui_story = var_395_0.localPosition

				local var_395_2 = GameObjectTools.GetOrAddComponent(var_395_0.gameObject, typeof(DynamicBoneHelper))

				if var_395_2 then
					var_395_2:EnableDynamicBone(false)
				end
			end

			local var_395_3 = 0.001

			if var_395_1 <= arg_392_1.time_ and arg_392_1.time_ < var_395_1 + var_395_3 then
				local var_395_4 = (arg_392_1.time_ - var_395_1) / var_395_3
				local var_395_5 = Vector3.New(0, -0.95, -6.2)

				var_395_0.localPosition = Vector3.Lerp(arg_392_1.var_.moveOldPos10103ui_story, var_395_5, var_395_4)

				local var_395_6 = manager.ui.mainCamera.transform.position - var_395_0.position

				var_395_0.forward = Vector3.New(var_395_6.x, var_395_6.y, var_395_6.z)

				local var_395_7 = var_395_0.localEulerAngles

				var_395_7.z = 0
				var_395_7.x = 0
				var_395_0.localEulerAngles = var_395_7
			end

			if arg_392_1.time_ >= var_395_1 + var_395_3 and arg_392_1.time_ < var_395_1 + var_395_3 + arg_395_0 then
				var_395_0.localPosition = Vector3.New(0, -0.95, -6.2)

				local var_395_8 = manager.ui.mainCamera.transform.position - var_395_0.position

				var_395_0.forward = Vector3.New(var_395_8.x, var_395_8.y, var_395_8.z)

				local var_395_9 = var_395_0.localEulerAngles

				var_395_9.z = 0
				var_395_9.x = 0
				var_395_0.localEulerAngles = var_395_9

				local var_395_10 = GameObjectTools.GetOrAddComponent(var_395_0.gameObject, typeof(DynamicBoneHelper))

				if var_395_10 then
					var_395_10:EnableDynamicBone(true)
				end
			end

			local var_395_11 = arg_392_1.actors_["10103ui_story"]
			local var_395_12 = 0

			if var_395_12 < arg_392_1.time_ and arg_392_1.time_ <= var_395_12 + arg_395_0 and not isNil(var_395_11) and arg_392_1.var_.characterEffect10103ui_story == nil then
				arg_392_1.var_.characterEffect10103ui_story = var_395_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_395_13 = 0.200000002980232

			if var_395_12 <= arg_392_1.time_ and arg_392_1.time_ < var_395_12 + var_395_13 and not isNil(var_395_11) then
				local var_395_14 = (arg_392_1.time_ - var_395_12) / var_395_13

				if arg_392_1.var_.characterEffect10103ui_story and not isNil(var_395_11) then
					arg_392_1.var_.characterEffect10103ui_story.fillFlat = false
				end
			end

			if arg_392_1.time_ >= var_395_12 + var_395_13 and arg_392_1.time_ < var_395_12 + var_395_13 + arg_395_0 and not isNil(var_395_11) and arg_392_1.var_.characterEffect10103ui_story then
				arg_392_1.var_.characterEffect10103ui_story.fillFlat = false
			end

			local var_395_15 = 0

			if var_395_15 < arg_392_1.time_ and arg_392_1.time_ <= var_395_15 + arg_395_0 then
				arg_392_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/story10103/story10103action/10103action1_1")
			end

			local var_395_16 = 0

			if var_395_16 < arg_392_1.time_ and arg_392_1.time_ <= var_395_16 + arg_395_0 then
				arg_392_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_395_17 = 0

			if var_395_17 < arg_392_1.time_ and arg_392_1.time_ <= var_395_17 + arg_395_0 then
				local var_395_18 = arg_392_1.actors_["10103ui_story"]

				if not isNil(var_395_18) then
					local var_395_19 = GameObjectTools.GetOrAddComponent(var_395_18, typeof(DynamicBoneHelper))

					if var_395_19 then
						var_395_19:EnableDynamicBone(true)
					end
				end
			end

			local var_395_20 = 0
			local var_395_21 = 0.25

			if var_395_20 < arg_392_1.time_ and arg_392_1.time_ <= var_395_20 + arg_395_0 then
				arg_392_1.talkMaxDuration = 0
				arg_392_1.dialogCg_.alpha = 1

				arg_392_1.dialog_:SetActive(true)
				SetActive(arg_392_1.leftNameGo_, true)

				local var_395_22 = arg_392_1:FormatText(StoryNameCfg[1214].name)

				arg_392_1.leftNameTxt_.text = var_395_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_392_1.leftNameTxt_.transform)

				arg_392_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_392_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_392_1:RecordName(arg_392_1.leftNameTxt_.text)
				SetActive(arg_392_1.iconTrs_.gameObject, false)
				arg_392_1.callingController_:SetSelectedState("normal")

				local var_395_23 = arg_392_1:GetWordFromCfg(322062095)
				local var_395_24 = arg_392_1:FormatText(var_395_23.content)

				arg_392_1.text_.text = var_395_24

				LuaForUtil.ClearLinePrefixSymbol(arg_392_1.text_)

				local var_395_25 = 10
				local var_395_26 = utf8.len(var_395_24)
				local var_395_27 = var_395_25 <= 0 and var_395_21 or var_395_21 * (var_395_26 / var_395_25)

				if var_395_27 > 0 and var_395_21 < var_395_27 then
					arg_392_1.talkMaxDuration = var_395_27

					if var_395_27 + var_395_20 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_27 + var_395_20
					end
				end

				arg_392_1.text_.text = var_395_24
				arg_392_1.typewritter.percent = 0

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062095", "story_v_out_322062.awb") ~= 0 then
					local var_395_28 = manager.audio:GetVoiceLength("story_v_out_322062", "322062095", "story_v_out_322062.awb") / 1000

					if var_395_28 + var_395_20 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_28 + var_395_20
					end

					if var_395_23.prefab_name ~= "" and arg_392_1.actors_[var_395_23.prefab_name] ~= nil then
						local var_395_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_392_1.actors_[var_395_23.prefab_name].transform, "story_v_out_322062", "322062095", "story_v_out_322062.awb")

						arg_392_1:RecordAudio("322062095", var_395_29)
						arg_392_1:RecordAudio("322062095", var_395_29)
					else
						arg_392_1:AudioAction("play", "voice", "story_v_out_322062", "322062095", "story_v_out_322062.awb")
					end

					arg_392_1:RecordHistoryTalkVoice("story_v_out_322062", "322062095", "story_v_out_322062.awb")
				end

				arg_392_1:RecordContent(arg_392_1.text_.text)
			end

			local var_395_30 = math.max(var_395_21, arg_392_1.talkMaxDuration)

			if var_395_20 <= arg_392_1.time_ and arg_392_1.time_ < var_395_20 + var_395_30 then
				arg_392_1.typewritter.percent = (arg_392_1.time_ - var_395_20) / var_395_30

				arg_392_1.typewritter:SetDirty()
			end

			if arg_392_1.time_ >= var_395_20 + var_395_30 and arg_392_1.time_ < var_395_20 + var_395_30 + arg_395_0 then
				arg_392_1.typewritter.percent = 1

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(true)
			end
		end

		arg_392_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_392_1:InitPlayNodeList()
	end,
	Play322062096 = function(arg_396_0, arg_396_1)
		arg_396_1.time_ = 0
		arg_396_1.frameCnt_ = 0
		arg_396_1.state_ = "playing"
		arg_396_1.curTalkId_ = 322062096
		arg_396_1.duration_ = 13.03

		local var_396_0 = {
			zh = 9.1,
			ja = 13.033
		}
		local var_396_1 = manager.audio:GetLocalizationFlag()

		if var_396_0[var_396_1] ~= nil then
			arg_396_1.duration_ = var_396_0[var_396_1]
		end

		SetActive(arg_396_1.tipsGo_, false)

		function arg_396_1.onSingleLineFinish_()
			arg_396_1.onSingleLineUpdate_ = nil
			arg_396_1.onSingleLineFinish_ = nil
			arg_396_1.state_ = "waiting"
		end

		function arg_396_1.playNext_(arg_398_0)
			if arg_398_0 == 1 then
				arg_396_0:Play322062097(arg_396_1)
			end
		end

		function arg_396_1.onSingleLineUpdate_(arg_399_0)
			local var_399_0 = arg_396_1.actors_["10103ui_story"]
			local var_399_1 = 0

			if var_399_1 < arg_396_1.time_ and arg_396_1.time_ <= var_399_1 + arg_399_0 and not isNil(var_399_0) and arg_396_1.var_.characterEffect10103ui_story == nil then
				arg_396_1.var_.characterEffect10103ui_story = var_399_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_399_2 = 0.200000002980232

			if var_399_1 <= arg_396_1.time_ and arg_396_1.time_ < var_399_1 + var_399_2 and not isNil(var_399_0) then
				local var_399_3 = (arg_396_1.time_ - var_399_1) / var_399_2

				if arg_396_1.var_.characterEffect10103ui_story and not isNil(var_399_0) then
					local var_399_4 = Mathf.Lerp(0, 0.5, var_399_3)

					arg_396_1.var_.characterEffect10103ui_story.fillFlat = true
					arg_396_1.var_.characterEffect10103ui_story.fillRatio = var_399_4
				end
			end

			if arg_396_1.time_ >= var_399_1 + var_399_2 and arg_396_1.time_ < var_399_1 + var_399_2 + arg_399_0 and not isNil(var_399_0) and arg_396_1.var_.characterEffect10103ui_story then
				local var_399_5 = 0.5

				arg_396_1.var_.characterEffect10103ui_story.fillFlat = true
				arg_396_1.var_.characterEffect10103ui_story.fillRatio = var_399_5
			end

			local var_399_6 = 0
			local var_399_7 = 0.95

			if var_399_6 < arg_396_1.time_ and arg_396_1.time_ <= var_399_6 + arg_399_0 then
				arg_396_1.talkMaxDuration = 0
				arg_396_1.dialogCg_.alpha = 1

				arg_396_1.dialog_:SetActive(true)
				SetActive(arg_396_1.leftNameGo_, true)

				local var_399_8 = arg_396_1:FormatText(StoryNameCfg[1031].name)

				arg_396_1.leftNameTxt_.text = var_399_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_396_1.leftNameTxt_.transform)

				arg_396_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_396_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_396_1:RecordName(arg_396_1.leftNameTxt_.text)
				SetActive(arg_396_1.iconTrs_.gameObject, true)
				arg_396_1.iconController_:SetSelectedState("hero")

				arg_396_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1089")

				arg_396_1.callingController_:SetSelectedState("normal")

				arg_396_1.keyicon_.color = Color.New(1, 1, 1)
				arg_396_1.icon_.color = Color.New(1, 1, 1)

				local var_399_9 = arg_396_1:GetWordFromCfg(322062096)
				local var_399_10 = arg_396_1:FormatText(var_399_9.content)

				arg_396_1.text_.text = var_399_10

				LuaForUtil.ClearLinePrefixSymbol(arg_396_1.text_)

				local var_399_11 = 37
				local var_399_12 = utf8.len(var_399_10)
				local var_399_13 = var_399_11 <= 0 and var_399_7 or var_399_7 * (var_399_12 / var_399_11)

				if var_399_13 > 0 and var_399_7 < var_399_13 then
					arg_396_1.talkMaxDuration = var_399_13

					if var_399_13 + var_399_6 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_13 + var_399_6
					end
				end

				arg_396_1.text_.text = var_399_10
				arg_396_1.typewritter.percent = 0

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062096", "story_v_out_322062.awb") ~= 0 then
					local var_399_14 = manager.audio:GetVoiceLength("story_v_out_322062", "322062096", "story_v_out_322062.awb") / 1000

					if var_399_14 + var_399_6 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_14 + var_399_6
					end

					if var_399_9.prefab_name ~= "" and arg_396_1.actors_[var_399_9.prefab_name] ~= nil then
						local var_399_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_396_1.actors_[var_399_9.prefab_name].transform, "story_v_out_322062", "322062096", "story_v_out_322062.awb")

						arg_396_1:RecordAudio("322062096", var_399_15)
						arg_396_1:RecordAudio("322062096", var_399_15)
					else
						arg_396_1:AudioAction("play", "voice", "story_v_out_322062", "322062096", "story_v_out_322062.awb")
					end

					arg_396_1:RecordHistoryTalkVoice("story_v_out_322062", "322062096", "story_v_out_322062.awb")
				end

				arg_396_1:RecordContent(arg_396_1.text_.text)
			end

			local var_399_16 = math.max(var_399_7, arg_396_1.talkMaxDuration)

			if var_399_6 <= arg_396_1.time_ and arg_396_1.time_ < var_399_6 + var_399_16 then
				arg_396_1.typewritter.percent = (arg_396_1.time_ - var_399_6) / var_399_16

				arg_396_1.typewritter:SetDirty()
			end

			if arg_396_1.time_ >= var_399_6 + var_399_16 and arg_396_1.time_ < var_399_6 + var_399_16 + arg_399_0 then
				arg_396_1.typewritter.percent = 1

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(true)
			end
		end

		arg_396_1.nodeConfigList_ = {}

		arg_396_1:InitPlayNodeList()
	end,
	Play322062097 = function(arg_400_0, arg_400_1)
		arg_400_1.time_ = 0
		arg_400_1.frameCnt_ = 0
		arg_400_1.state_ = "playing"
		arg_400_1.curTalkId_ = 322062097
		arg_400_1.duration_ = 7.47

		local var_400_0 = {
			zh = 7.466,
			ja = 6.266
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
				arg_400_0:Play322062098(arg_400_1)
			end
		end

		function arg_400_1.onSingleLineUpdate_(arg_403_0)
			local var_403_0 = 0
			local var_403_1 = 0.8

			if var_403_0 < arg_400_1.time_ and arg_400_1.time_ <= var_403_0 + arg_403_0 then
				arg_400_1.talkMaxDuration = 0
				arg_400_1.dialogCg_.alpha = 1

				arg_400_1.dialog_:SetActive(true)
				SetActive(arg_400_1.leftNameGo_, true)

				local var_403_2 = arg_400_1:FormatText(StoryNameCfg[1031].name)

				arg_400_1.leftNameTxt_.text = var_403_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_400_1.leftNameTxt_.transform)

				arg_400_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_400_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_400_1:RecordName(arg_400_1.leftNameTxt_.text)
				SetActive(arg_400_1.iconTrs_.gameObject, true)
				arg_400_1.iconController_:SetSelectedState("hero")

				arg_400_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1089")

				arg_400_1.callingController_:SetSelectedState("normal")

				arg_400_1.keyicon_.color = Color.New(1, 1, 1)
				arg_400_1.icon_.color = Color.New(1, 1, 1)

				local var_403_3 = arg_400_1:GetWordFromCfg(322062097)
				local var_403_4 = arg_400_1:FormatText(var_403_3.content)

				arg_400_1.text_.text = var_403_4

				LuaForUtil.ClearLinePrefixSymbol(arg_400_1.text_)

				local var_403_5 = 32
				local var_403_6 = utf8.len(var_403_4)
				local var_403_7 = var_403_5 <= 0 and var_403_1 or var_403_1 * (var_403_6 / var_403_5)

				if var_403_7 > 0 and var_403_1 < var_403_7 then
					arg_400_1.talkMaxDuration = var_403_7

					if var_403_7 + var_403_0 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_7 + var_403_0
					end
				end

				arg_400_1.text_.text = var_403_4
				arg_400_1.typewritter.percent = 0

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062097", "story_v_out_322062.awb") ~= 0 then
					local var_403_8 = manager.audio:GetVoiceLength("story_v_out_322062", "322062097", "story_v_out_322062.awb") / 1000

					if var_403_8 + var_403_0 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_8 + var_403_0
					end

					if var_403_3.prefab_name ~= "" and arg_400_1.actors_[var_403_3.prefab_name] ~= nil then
						local var_403_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_400_1.actors_[var_403_3.prefab_name].transform, "story_v_out_322062", "322062097", "story_v_out_322062.awb")

						arg_400_1:RecordAudio("322062097", var_403_9)
						arg_400_1:RecordAudio("322062097", var_403_9)
					else
						arg_400_1:AudioAction("play", "voice", "story_v_out_322062", "322062097", "story_v_out_322062.awb")
					end

					arg_400_1:RecordHistoryTalkVoice("story_v_out_322062", "322062097", "story_v_out_322062.awb")
				end

				arg_400_1:RecordContent(arg_400_1.text_.text)
			end

			local var_403_10 = math.max(var_403_1, arg_400_1.talkMaxDuration)

			if var_403_0 <= arg_400_1.time_ and arg_400_1.time_ < var_403_0 + var_403_10 then
				arg_400_1.typewritter.percent = (arg_400_1.time_ - var_403_0) / var_403_10

				arg_400_1.typewritter:SetDirty()
			end

			if arg_400_1.time_ >= var_403_0 + var_403_10 and arg_400_1.time_ < var_403_0 + var_403_10 + arg_403_0 then
				arg_400_1.typewritter.percent = 1

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(true)
			end
		end

		arg_400_1.nodeConfigList_ = {}

		arg_400_1:InitPlayNodeList()
	end,
	Play322062098 = function(arg_404_0, arg_404_1)
		arg_404_1.time_ = 0
		arg_404_1.frameCnt_ = 0
		arg_404_1.state_ = "playing"
		arg_404_1.curTalkId_ = 322062098
		arg_404_1.duration_ = 7.87

		local var_404_0 = {
			zh = 5.6,
			ja = 7.866
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
				arg_404_0:Play322062099(arg_404_1)
			end
		end

		function arg_404_1.onSingleLineUpdate_(arg_407_0)
			local var_407_0 = arg_404_1.actors_["10103ui_story"]
			local var_407_1 = 0

			if var_407_1 < arg_404_1.time_ and arg_404_1.time_ <= var_407_1 + arg_407_0 and not isNil(var_407_0) and arg_404_1.var_.characterEffect10103ui_story == nil then
				arg_404_1.var_.characterEffect10103ui_story = var_407_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_407_2 = 0.200000002980232

			if var_407_1 <= arg_404_1.time_ and arg_404_1.time_ < var_407_1 + var_407_2 and not isNil(var_407_0) then
				local var_407_3 = (arg_404_1.time_ - var_407_1) / var_407_2

				if arg_404_1.var_.characterEffect10103ui_story and not isNil(var_407_0) then
					arg_404_1.var_.characterEffect10103ui_story.fillFlat = false
				end
			end

			if arg_404_1.time_ >= var_407_1 + var_407_2 and arg_404_1.time_ < var_407_1 + var_407_2 + arg_407_0 and not isNil(var_407_0) and arg_404_1.var_.characterEffect10103ui_story then
				arg_404_1.var_.characterEffect10103ui_story.fillFlat = false
			end

			local var_407_4 = 0
			local var_407_5 = 0.75

			if var_407_4 < arg_404_1.time_ and arg_404_1.time_ <= var_407_4 + arg_407_0 then
				arg_404_1.talkMaxDuration = 0
				arg_404_1.dialogCg_.alpha = 1

				arg_404_1.dialog_:SetActive(true)
				SetActive(arg_404_1.leftNameGo_, true)

				local var_407_6 = arg_404_1:FormatText(StoryNameCfg[1214].name)

				arg_404_1.leftNameTxt_.text = var_407_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_404_1.leftNameTxt_.transform)

				arg_404_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_404_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_404_1:RecordName(arg_404_1.leftNameTxt_.text)
				SetActive(arg_404_1.iconTrs_.gameObject, false)
				arg_404_1.callingController_:SetSelectedState("normal")

				local var_407_7 = arg_404_1:GetWordFromCfg(322062098)
				local var_407_8 = arg_404_1:FormatText(var_407_7.content)

				arg_404_1.text_.text = var_407_8

				LuaForUtil.ClearLinePrefixSymbol(arg_404_1.text_)

				local var_407_9 = 30
				local var_407_10 = utf8.len(var_407_8)
				local var_407_11 = var_407_9 <= 0 and var_407_5 or var_407_5 * (var_407_10 / var_407_9)

				if var_407_11 > 0 and var_407_5 < var_407_11 then
					arg_404_1.talkMaxDuration = var_407_11

					if var_407_11 + var_407_4 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_11 + var_407_4
					end
				end

				arg_404_1.text_.text = var_407_8
				arg_404_1.typewritter.percent = 0

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062098", "story_v_out_322062.awb") ~= 0 then
					local var_407_12 = manager.audio:GetVoiceLength("story_v_out_322062", "322062098", "story_v_out_322062.awb") / 1000

					if var_407_12 + var_407_4 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_12 + var_407_4
					end

					if var_407_7.prefab_name ~= "" and arg_404_1.actors_[var_407_7.prefab_name] ~= nil then
						local var_407_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_404_1.actors_[var_407_7.prefab_name].transform, "story_v_out_322062", "322062098", "story_v_out_322062.awb")

						arg_404_1:RecordAudio("322062098", var_407_13)
						arg_404_1:RecordAudio("322062098", var_407_13)
					else
						arg_404_1:AudioAction("play", "voice", "story_v_out_322062", "322062098", "story_v_out_322062.awb")
					end

					arg_404_1:RecordHistoryTalkVoice("story_v_out_322062", "322062098", "story_v_out_322062.awb")
				end

				arg_404_1:RecordContent(arg_404_1.text_.text)
			end

			local var_407_14 = math.max(var_407_5, arg_404_1.talkMaxDuration)

			if var_407_4 <= arg_404_1.time_ and arg_404_1.time_ < var_407_4 + var_407_14 then
				arg_404_1.typewritter.percent = (arg_404_1.time_ - var_407_4) / var_407_14

				arg_404_1.typewritter:SetDirty()
			end

			if arg_404_1.time_ >= var_407_4 + var_407_14 and arg_404_1.time_ < var_407_4 + var_407_14 + arg_407_0 then
				arg_404_1.typewritter.percent = 1

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(true)
			end
		end

		arg_404_1.nodeConfigList_ = {}

		arg_404_1:InitPlayNodeList()
	end,
	Play322062099 = function(arg_408_0, arg_408_1)
		arg_408_1.time_ = 0
		arg_408_1.frameCnt_ = 0
		arg_408_1.state_ = "playing"
		arg_408_1.curTalkId_ = 322062099
		arg_408_1.duration_ = 4.7

		local var_408_0 = {
			zh = 3.9,
			ja = 4.7
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
				arg_408_0:Play322062100(arg_408_1)
			end
		end

		function arg_408_1.onSingleLineUpdate_(arg_411_0)
			local var_411_0 = 0

			if var_411_0 < arg_408_1.time_ and arg_408_1.time_ <= var_411_0 + arg_411_0 then
				arg_408_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/story10103/story10103action/10103action6_1")
			end

			local var_411_1 = 0

			if var_411_1 < arg_408_1.time_ and arg_408_1.time_ <= var_411_1 + arg_411_0 then
				local var_411_2 = arg_408_1.actors_["10103ui_story"]

				if not isNil(var_411_2) then
					local var_411_3 = GameObjectTools.GetOrAddComponent(var_411_2, typeof(DynamicBoneHelper))

					if var_411_3 then
						var_411_3:EnableDynamicBone(true)
					end
				end
			end

			local var_411_4 = 0
			local var_411_5 = 0.325

			if var_411_4 < arg_408_1.time_ and arg_408_1.time_ <= var_411_4 + arg_411_0 then
				arg_408_1.talkMaxDuration = 0
				arg_408_1.dialogCg_.alpha = 1

				arg_408_1.dialog_:SetActive(true)
				SetActive(arg_408_1.leftNameGo_, true)

				local var_411_6 = arg_408_1:FormatText(StoryNameCfg[1214].name)

				arg_408_1.leftNameTxt_.text = var_411_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_408_1.leftNameTxt_.transform)

				arg_408_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_408_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_408_1:RecordName(arg_408_1.leftNameTxt_.text)
				SetActive(arg_408_1.iconTrs_.gameObject, false)
				arg_408_1.callingController_:SetSelectedState("normal")

				local var_411_7 = arg_408_1:GetWordFromCfg(322062099)
				local var_411_8 = arg_408_1:FormatText(var_411_7.content)

				arg_408_1.text_.text = var_411_8

				LuaForUtil.ClearLinePrefixSymbol(arg_408_1.text_)

				local var_411_9 = 13
				local var_411_10 = utf8.len(var_411_8)
				local var_411_11 = var_411_9 <= 0 and var_411_5 or var_411_5 * (var_411_10 / var_411_9)

				if var_411_11 > 0 and var_411_5 < var_411_11 then
					arg_408_1.talkMaxDuration = var_411_11

					if var_411_11 + var_411_4 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_11 + var_411_4
					end
				end

				arg_408_1.text_.text = var_411_8
				arg_408_1.typewritter.percent = 0

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062099", "story_v_out_322062.awb") ~= 0 then
					local var_411_12 = manager.audio:GetVoiceLength("story_v_out_322062", "322062099", "story_v_out_322062.awb") / 1000

					if var_411_12 + var_411_4 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_12 + var_411_4
					end

					if var_411_7.prefab_name ~= "" and arg_408_1.actors_[var_411_7.prefab_name] ~= nil then
						local var_411_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_408_1.actors_[var_411_7.prefab_name].transform, "story_v_out_322062", "322062099", "story_v_out_322062.awb")

						arg_408_1:RecordAudio("322062099", var_411_13)
						arg_408_1:RecordAudio("322062099", var_411_13)
					else
						arg_408_1:AudioAction("play", "voice", "story_v_out_322062", "322062099", "story_v_out_322062.awb")
					end

					arg_408_1:RecordHistoryTalkVoice("story_v_out_322062", "322062099", "story_v_out_322062.awb")
				end

				arg_408_1:RecordContent(arg_408_1.text_.text)
			end

			local var_411_14 = math.max(var_411_5, arg_408_1.talkMaxDuration)

			if var_411_4 <= arg_408_1.time_ and arg_408_1.time_ < var_411_4 + var_411_14 then
				arg_408_1.typewritter.percent = (arg_408_1.time_ - var_411_4) / var_411_14

				arg_408_1.typewritter:SetDirty()
			end

			if arg_408_1.time_ >= var_411_4 + var_411_14 and arg_408_1.time_ < var_411_4 + var_411_14 + arg_411_0 then
				arg_408_1.typewritter.percent = 1

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(true)
			end
		end

		arg_408_1.nodeConfigList_ = {}

		arg_408_1:InitPlayNodeList()
	end,
	Play322062100 = function(arg_412_0, arg_412_1)
		arg_412_1.time_ = 0
		arg_412_1.frameCnt_ = 0
		arg_412_1.state_ = "playing"
		arg_412_1.curTalkId_ = 322062100
		arg_412_1.duration_ = 7.8

		local var_412_0 = {
			zh = 2.866,
			ja = 7.8
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
				arg_412_0:Play322062101(arg_412_1)
			end
		end

		function arg_412_1.onSingleLineUpdate_(arg_415_0)
			local var_415_0 = arg_412_1.actors_["10103ui_story"]
			local var_415_1 = 0

			if var_415_1 < arg_412_1.time_ and arg_412_1.time_ <= var_415_1 + arg_415_0 and not isNil(var_415_0) and arg_412_1.var_.characterEffect10103ui_story == nil then
				arg_412_1.var_.characterEffect10103ui_story = var_415_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_415_2 = 0.200000002980232

			if var_415_1 <= arg_412_1.time_ and arg_412_1.time_ < var_415_1 + var_415_2 and not isNil(var_415_0) then
				local var_415_3 = (arg_412_1.time_ - var_415_1) / var_415_2

				if arg_412_1.var_.characterEffect10103ui_story and not isNil(var_415_0) then
					local var_415_4 = Mathf.Lerp(0, 0.5, var_415_3)

					arg_412_1.var_.characterEffect10103ui_story.fillFlat = true
					arg_412_1.var_.characterEffect10103ui_story.fillRatio = var_415_4
				end
			end

			if arg_412_1.time_ >= var_415_1 + var_415_2 and arg_412_1.time_ < var_415_1 + var_415_2 + arg_415_0 and not isNil(var_415_0) and arg_412_1.var_.characterEffect10103ui_story then
				local var_415_5 = 0.5

				arg_412_1.var_.characterEffect10103ui_story.fillFlat = true
				arg_412_1.var_.characterEffect10103ui_story.fillRatio = var_415_5
			end

			local var_415_6 = 0
			local var_415_7 = 0.375

			if var_415_6 < arg_412_1.time_ and arg_412_1.time_ <= var_415_6 + arg_415_0 then
				arg_412_1.talkMaxDuration = 0
				arg_412_1.dialogCg_.alpha = 1

				arg_412_1.dialog_:SetActive(true)
				SetActive(arg_412_1.leftNameGo_, true)

				local var_415_8 = arg_412_1:FormatText(StoryNameCfg[1031].name)

				arg_412_1.leftNameTxt_.text = var_415_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_412_1.leftNameTxt_.transform)

				arg_412_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_412_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_412_1:RecordName(arg_412_1.leftNameTxt_.text)
				SetActive(arg_412_1.iconTrs_.gameObject, true)
				arg_412_1.iconController_:SetSelectedState("hero")

				arg_412_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1089")

				arg_412_1.callingController_:SetSelectedState("normal")

				arg_412_1.keyicon_.color = Color.New(1, 1, 1)
				arg_412_1.icon_.color = Color.New(1, 1, 1)

				local var_415_9 = arg_412_1:GetWordFromCfg(322062100)
				local var_415_10 = arg_412_1:FormatText(var_415_9.content)

				arg_412_1.text_.text = var_415_10

				LuaForUtil.ClearLinePrefixSymbol(arg_412_1.text_)

				local var_415_11 = 15
				local var_415_12 = utf8.len(var_415_10)
				local var_415_13 = var_415_11 <= 0 and var_415_7 or var_415_7 * (var_415_12 / var_415_11)

				if var_415_13 > 0 and var_415_7 < var_415_13 then
					arg_412_1.talkMaxDuration = var_415_13

					if var_415_13 + var_415_6 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_13 + var_415_6
					end
				end

				arg_412_1.text_.text = var_415_10
				arg_412_1.typewritter.percent = 0

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062100", "story_v_out_322062.awb") ~= 0 then
					local var_415_14 = manager.audio:GetVoiceLength("story_v_out_322062", "322062100", "story_v_out_322062.awb") / 1000

					if var_415_14 + var_415_6 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_14 + var_415_6
					end

					if var_415_9.prefab_name ~= "" and arg_412_1.actors_[var_415_9.prefab_name] ~= nil then
						local var_415_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_412_1.actors_[var_415_9.prefab_name].transform, "story_v_out_322062", "322062100", "story_v_out_322062.awb")

						arg_412_1:RecordAudio("322062100", var_415_15)
						arg_412_1:RecordAudio("322062100", var_415_15)
					else
						arg_412_1:AudioAction("play", "voice", "story_v_out_322062", "322062100", "story_v_out_322062.awb")
					end

					arg_412_1:RecordHistoryTalkVoice("story_v_out_322062", "322062100", "story_v_out_322062.awb")
				end

				arg_412_1:RecordContent(arg_412_1.text_.text)
			end

			local var_415_16 = math.max(var_415_7, arg_412_1.talkMaxDuration)

			if var_415_6 <= arg_412_1.time_ and arg_412_1.time_ < var_415_6 + var_415_16 then
				arg_412_1.typewritter.percent = (arg_412_1.time_ - var_415_6) / var_415_16

				arg_412_1.typewritter:SetDirty()
			end

			if arg_412_1.time_ >= var_415_6 + var_415_16 and arg_412_1.time_ < var_415_6 + var_415_16 + arg_415_0 then
				arg_412_1.typewritter.percent = 1

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(true)
			end
		end

		arg_412_1.nodeConfigList_ = {}

		arg_412_1:InitPlayNodeList()
	end,
	Play322062101 = function(arg_416_0, arg_416_1)
		arg_416_1.time_ = 0
		arg_416_1.frameCnt_ = 0
		arg_416_1.state_ = "playing"
		arg_416_1.curTalkId_ = 322062101
		arg_416_1.duration_ = 6.2

		local var_416_0 = {
			zh = 5.766,
			ja = 6.2
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
				arg_416_0:Play322062102(arg_416_1)
			end
		end

		function arg_416_1.onSingleLineUpdate_(arg_419_0)
			local var_419_0 = 0
			local var_419_1 = 0.625

			if var_419_0 < arg_416_1.time_ and arg_416_1.time_ <= var_419_0 + arg_419_0 then
				arg_416_1.talkMaxDuration = 0
				arg_416_1.dialogCg_.alpha = 1

				arg_416_1.dialog_:SetActive(true)
				SetActive(arg_416_1.leftNameGo_, true)

				local var_419_2 = arg_416_1:FormatText(StoryNameCfg[1031].name)

				arg_416_1.leftNameTxt_.text = var_419_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_416_1.leftNameTxt_.transform)

				arg_416_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_416_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_416_1:RecordName(arg_416_1.leftNameTxt_.text)
				SetActive(arg_416_1.iconTrs_.gameObject, true)
				arg_416_1.iconController_:SetSelectedState("hero")

				arg_416_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1089")

				arg_416_1.callingController_:SetSelectedState("normal")

				arg_416_1.keyicon_.color = Color.New(1, 1, 1)
				arg_416_1.icon_.color = Color.New(1, 1, 1)

				local var_419_3 = arg_416_1:GetWordFromCfg(322062101)
				local var_419_4 = arg_416_1:FormatText(var_419_3.content)

				arg_416_1.text_.text = var_419_4

				LuaForUtil.ClearLinePrefixSymbol(arg_416_1.text_)

				local var_419_5 = 25
				local var_419_6 = utf8.len(var_419_4)
				local var_419_7 = var_419_5 <= 0 and var_419_1 or var_419_1 * (var_419_6 / var_419_5)

				if var_419_7 > 0 and var_419_1 < var_419_7 then
					arg_416_1.talkMaxDuration = var_419_7

					if var_419_7 + var_419_0 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_7 + var_419_0
					end
				end

				arg_416_1.text_.text = var_419_4
				arg_416_1.typewritter.percent = 0

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062101", "story_v_out_322062.awb") ~= 0 then
					local var_419_8 = manager.audio:GetVoiceLength("story_v_out_322062", "322062101", "story_v_out_322062.awb") / 1000

					if var_419_8 + var_419_0 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_8 + var_419_0
					end

					if var_419_3.prefab_name ~= "" and arg_416_1.actors_[var_419_3.prefab_name] ~= nil then
						local var_419_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_416_1.actors_[var_419_3.prefab_name].transform, "story_v_out_322062", "322062101", "story_v_out_322062.awb")

						arg_416_1:RecordAudio("322062101", var_419_9)
						arg_416_1:RecordAudio("322062101", var_419_9)
					else
						arg_416_1:AudioAction("play", "voice", "story_v_out_322062", "322062101", "story_v_out_322062.awb")
					end

					arg_416_1:RecordHistoryTalkVoice("story_v_out_322062", "322062101", "story_v_out_322062.awb")
				end

				arg_416_1:RecordContent(arg_416_1.text_.text)
			end

			local var_419_10 = math.max(var_419_1, arg_416_1.talkMaxDuration)

			if var_419_0 <= arg_416_1.time_ and arg_416_1.time_ < var_419_0 + var_419_10 then
				arg_416_1.typewritter.percent = (arg_416_1.time_ - var_419_0) / var_419_10

				arg_416_1.typewritter:SetDirty()
			end

			if arg_416_1.time_ >= var_419_0 + var_419_10 and arg_416_1.time_ < var_419_0 + var_419_10 + arg_419_0 then
				arg_416_1.typewritter.percent = 1

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(true)
			end
		end

		arg_416_1.nodeConfigList_ = {}

		arg_416_1:InitPlayNodeList()
	end,
	Play322062102 = function(arg_420_0, arg_420_1)
		arg_420_1.time_ = 0
		arg_420_1.frameCnt_ = 0
		arg_420_1.state_ = "playing"
		arg_420_1.curTalkId_ = 322062102
		arg_420_1.duration_ = 13.5

		local var_420_0 = {
			zh = 7.933,
			ja = 13.5
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
				arg_420_0:Play322062103(arg_420_1)
			end
		end

		function arg_420_1.onSingleLineUpdate_(arg_423_0)
			local var_423_0 = arg_420_1.actors_["10103ui_story"]
			local var_423_1 = 0

			if var_423_1 < arg_420_1.time_ and arg_420_1.time_ <= var_423_1 + arg_423_0 and not isNil(var_423_0) and arg_420_1.var_.characterEffect10103ui_story == nil then
				arg_420_1.var_.characterEffect10103ui_story = var_423_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_423_2 = 0.200000002980232

			if var_423_1 <= arg_420_1.time_ and arg_420_1.time_ < var_423_1 + var_423_2 and not isNil(var_423_0) then
				local var_423_3 = (arg_420_1.time_ - var_423_1) / var_423_2

				if arg_420_1.var_.characterEffect10103ui_story and not isNil(var_423_0) then
					arg_420_1.var_.characterEffect10103ui_story.fillFlat = false
				end
			end

			if arg_420_1.time_ >= var_423_1 + var_423_2 and arg_420_1.time_ < var_423_1 + var_423_2 + arg_423_0 and not isNil(var_423_0) and arg_420_1.var_.characterEffect10103ui_story then
				arg_420_1.var_.characterEffect10103ui_story.fillFlat = false
			end

			local var_423_4 = 0

			if var_423_4 < arg_420_1.time_ and arg_420_1.time_ <= var_423_4 + arg_423_0 then
				arg_420_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/story10103/story10103action/10103action6_2")
			end

			local var_423_5 = 0

			if var_423_5 < arg_420_1.time_ and arg_420_1.time_ <= var_423_5 + arg_423_0 then
				local var_423_6 = arg_420_1.actors_["10103ui_story"]

				if not isNil(var_423_6) then
					local var_423_7 = GameObjectTools.GetOrAddComponent(var_423_6, typeof(DynamicBoneHelper))

					if var_423_7 then
						var_423_7:EnableDynamicBone(true)
					end
				end
			end

			local var_423_8 = 0
			local var_423_9 = 0.85

			if var_423_8 < arg_420_1.time_ and arg_420_1.time_ <= var_423_8 + arg_423_0 then
				arg_420_1.talkMaxDuration = 0
				arg_420_1.dialogCg_.alpha = 1

				arg_420_1.dialog_:SetActive(true)
				SetActive(arg_420_1.leftNameGo_, true)

				local var_423_10 = arg_420_1:FormatText(StoryNameCfg[1214].name)

				arg_420_1.leftNameTxt_.text = var_423_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_420_1.leftNameTxt_.transform)

				arg_420_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_420_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_420_1:RecordName(arg_420_1.leftNameTxt_.text)
				SetActive(arg_420_1.iconTrs_.gameObject, false)
				arg_420_1.callingController_:SetSelectedState("normal")

				local var_423_11 = arg_420_1:GetWordFromCfg(322062102)
				local var_423_12 = arg_420_1:FormatText(var_423_11.content)

				arg_420_1.text_.text = var_423_12

				LuaForUtil.ClearLinePrefixSymbol(arg_420_1.text_)

				local var_423_13 = 34
				local var_423_14 = utf8.len(var_423_12)
				local var_423_15 = var_423_13 <= 0 and var_423_9 or var_423_9 * (var_423_14 / var_423_13)

				if var_423_15 > 0 and var_423_9 < var_423_15 then
					arg_420_1.talkMaxDuration = var_423_15

					if var_423_15 + var_423_8 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_15 + var_423_8
					end
				end

				arg_420_1.text_.text = var_423_12
				arg_420_1.typewritter.percent = 0

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062102", "story_v_out_322062.awb") ~= 0 then
					local var_423_16 = manager.audio:GetVoiceLength("story_v_out_322062", "322062102", "story_v_out_322062.awb") / 1000

					if var_423_16 + var_423_8 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_16 + var_423_8
					end

					if var_423_11.prefab_name ~= "" and arg_420_1.actors_[var_423_11.prefab_name] ~= nil then
						local var_423_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_420_1.actors_[var_423_11.prefab_name].transform, "story_v_out_322062", "322062102", "story_v_out_322062.awb")

						arg_420_1:RecordAudio("322062102", var_423_17)
						arg_420_1:RecordAudio("322062102", var_423_17)
					else
						arg_420_1:AudioAction("play", "voice", "story_v_out_322062", "322062102", "story_v_out_322062.awb")
					end

					arg_420_1:RecordHistoryTalkVoice("story_v_out_322062", "322062102", "story_v_out_322062.awb")
				end

				arg_420_1:RecordContent(arg_420_1.text_.text)
			end

			local var_423_18 = math.max(var_423_9, arg_420_1.talkMaxDuration)

			if var_423_8 <= arg_420_1.time_ and arg_420_1.time_ < var_423_8 + var_423_18 then
				arg_420_1.typewritter.percent = (arg_420_1.time_ - var_423_8) / var_423_18

				arg_420_1.typewritter:SetDirty()
			end

			if arg_420_1.time_ >= var_423_8 + var_423_18 and arg_420_1.time_ < var_423_8 + var_423_18 + arg_423_0 then
				arg_420_1.typewritter.percent = 1

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(true)
			end
		end

		arg_420_1.nodeConfigList_ = {}

		arg_420_1:InitPlayNodeList()
	end,
	Play322062103 = function(arg_424_0, arg_424_1)
		arg_424_1.time_ = 0
		arg_424_1.frameCnt_ = 0
		arg_424_1.state_ = "playing"
		arg_424_1.curTalkId_ = 322062103
		arg_424_1.duration_ = 5.43

		SetActive(arg_424_1.tipsGo_, false)

		function arg_424_1.onSingleLineFinish_()
			arg_424_1.onSingleLineUpdate_ = nil
			arg_424_1.onSingleLineFinish_ = nil
			arg_424_1.state_ = "waiting"
		end

		function arg_424_1.playNext_(arg_426_0)
			if arg_426_0 == 1 then
				arg_424_0:Play322062104(arg_424_1)
			end
		end

		function arg_424_1.onSingleLineUpdate_(arg_427_0)
			local var_427_0 = arg_424_1.actors_["10103ui_story"].transform
			local var_427_1 = 0

			if var_427_1 < arg_424_1.time_ and arg_424_1.time_ <= var_427_1 + arg_427_0 then
				arg_424_1.var_.moveOldPos10103ui_story = var_427_0.localPosition

				local var_427_2 = GameObjectTools.GetOrAddComponent(var_427_0.gameObject, typeof(DynamicBoneHelper))

				if var_427_2 then
					var_427_2:EnableDynamicBone(false)
				end
			end

			local var_427_3 = 0.001

			if var_427_1 <= arg_424_1.time_ and arg_424_1.time_ < var_427_1 + var_427_3 then
				local var_427_4 = (arg_424_1.time_ - var_427_1) / var_427_3
				local var_427_5 = Vector3.New(0, 100, 0)

				var_427_0.localPosition = Vector3.Lerp(arg_424_1.var_.moveOldPos10103ui_story, var_427_5, var_427_4)

				local var_427_6 = manager.ui.mainCamera.transform.position - var_427_0.position

				var_427_0.forward = Vector3.New(var_427_6.x, var_427_6.y, var_427_6.z)

				local var_427_7 = var_427_0.localEulerAngles

				var_427_7.z = 0
				var_427_7.x = 0
				var_427_0.localEulerAngles = var_427_7
			end

			if arg_424_1.time_ >= var_427_1 + var_427_3 and arg_424_1.time_ < var_427_1 + var_427_3 + arg_427_0 then
				var_427_0.localPosition = Vector3.New(0, 100, 0)

				local var_427_8 = manager.ui.mainCamera.transform.position - var_427_0.position

				var_427_0.forward = Vector3.New(var_427_8.x, var_427_8.y, var_427_8.z)

				local var_427_9 = var_427_0.localEulerAngles

				var_427_9.z = 0
				var_427_9.x = 0
				var_427_0.localEulerAngles = var_427_9

				local var_427_10 = GameObjectTools.GetOrAddComponent(var_427_0.gameObject, typeof(DynamicBoneHelper))

				if var_427_10 then
					var_427_10:EnableDynamicBone(true)
				end
			end

			local var_427_11 = arg_424_1.actors_["1089ui_story"].transform
			local var_427_12 = 0

			if var_427_12 < arg_424_1.time_ and arg_424_1.time_ <= var_427_12 + arg_427_0 then
				arg_424_1.var_.moveOldPos1089ui_story = var_427_11.localPosition
			end

			local var_427_13 = 0.001

			if var_427_12 <= arg_424_1.time_ and arg_424_1.time_ < var_427_12 + var_427_13 then
				local var_427_14 = (arg_424_1.time_ - var_427_12) / var_427_13
				local var_427_15 = Vector3.New(0, 100, 0)

				var_427_11.localPosition = Vector3.Lerp(arg_424_1.var_.moveOldPos1089ui_story, var_427_15, var_427_14)

				local var_427_16 = manager.ui.mainCamera.transform.position - var_427_11.position

				var_427_11.forward = Vector3.New(var_427_16.x, var_427_16.y, var_427_16.z)

				local var_427_17 = var_427_11.localEulerAngles

				var_427_17.z = 0
				var_427_17.x = 0
				var_427_11.localEulerAngles = var_427_17
			end

			if arg_424_1.time_ >= var_427_12 + var_427_13 and arg_424_1.time_ < var_427_12 + var_427_13 + arg_427_0 then
				var_427_11.localPosition = Vector3.New(0, 100, 0)

				local var_427_18 = manager.ui.mainCamera.transform.position - var_427_11.position

				var_427_11.forward = Vector3.New(var_427_18.x, var_427_18.y, var_427_18.z)

				local var_427_19 = var_427_11.localEulerAngles

				var_427_19.z = 0
				var_427_19.x = 0
				var_427_11.localEulerAngles = var_427_19
			end

			local var_427_20 = 0.433333333333333
			local var_427_21 = 1

			if var_427_20 < arg_424_1.time_ and arg_424_1.time_ <= var_427_20 + arg_427_0 then
				local var_427_22 = "play"
				local var_427_23 = "effect"

				arg_424_1:AudioAction(var_427_22, var_427_23, "se_story_1311", "se_story_1311_gun01", "")
			end

			local var_427_24 = manager.ui.mainCamera.transform
			local var_427_25 = 2.98023250522306e-09

			if var_427_25 < arg_424_1.time_ and arg_424_1.time_ <= var_427_25 + arg_427_0 then
				local var_427_26 = arg_424_1.var_.effect078

				if var_427_26 then
					Object.Destroy(var_427_26)

					arg_424_1.var_.effect078 = nil
				end
			end

			local var_427_27 = manager.ui.mainCamera.transform
			local var_427_28 = 2.98023250522306e-09

			if var_427_28 < arg_424_1.time_ and arg_424_1.time_ <= var_427_28 + arg_427_0 then
				local var_427_29 = arg_424_1.var_.effect0781

				if var_427_29 then
					Object.Destroy(var_427_29)

					arg_424_1.var_.effect0781 = nil
				end
			end

			local var_427_30 = 0

			arg_424_1.isInRecall_ = false

			if var_427_30 < arg_424_1.time_ and arg_424_1.time_ <= var_427_30 + arg_427_0 then
				arg_424_1.screenFilterGo_:SetActive(false)

				for iter_427_0, iter_427_1 in pairs(arg_424_1.actors_) do
					local var_427_31 = iter_427_1:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_427_2, iter_427_3 in ipairs(var_427_31) do
						if iter_427_3.color.r > 0.51 then
							iter_427_3.color = Color.New(1, 1, 1)
						else
							iter_427_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_427_32 = 0.0166666666666667

			if var_427_30 <= arg_424_1.time_ and arg_424_1.time_ < var_427_30 + var_427_32 then
				local var_427_33 = (arg_424_1.time_ - var_427_30) / var_427_32

				arg_424_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, var_427_33)
			end

			if arg_424_1.time_ >= var_427_30 + var_427_32 and arg_424_1.time_ < var_427_30 + var_427_32 + arg_427_0 then
				arg_424_1.screenFilterEffect_.weight = 0
			end

			local var_427_34 = 0

			if var_427_34 < arg_424_1.time_ and arg_424_1.time_ <= var_427_34 + arg_427_0 then
				local var_427_35 = manager.ui.mainCamera.transform.localPosition
				local var_427_36 = Vector3.New(0, 0, 10) + Vector3.New(var_427_35.x, var_427_35.y, 0)
				local var_427_37 = arg_424_1.bgs_.ST61a

				var_427_37.transform.localPosition = var_427_36
				var_427_37.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_427_38 = var_427_37:GetComponent("SpriteRenderer")

				if var_427_38 and var_427_38.sprite then
					local var_427_39 = (var_427_37.transform.localPosition - var_427_35).z
					local var_427_40 = manager.ui.mainCameraCom_
					local var_427_41 = 2 * var_427_39 * Mathf.Tan(var_427_40.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_427_42 = var_427_41 * var_427_40.aspect
					local var_427_43 = var_427_38.sprite.bounds.size.x
					local var_427_44 = var_427_38.sprite.bounds.size.y
					local var_427_45 = var_427_42 / var_427_43
					local var_427_46 = var_427_41 / var_427_44
					local var_427_47 = var_427_46 < var_427_45 and var_427_45 or var_427_46

					var_427_37.transform.localScale = Vector3.New(var_427_47, var_427_47, 0)
				end

				for iter_427_4, iter_427_5 in pairs(arg_424_1.bgs_) do
					if iter_427_4 ~= "ST61a" then
						iter_427_5.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_427_48 = 0

			if var_427_48 < arg_424_1.time_ and arg_424_1.time_ <= var_427_48 + arg_427_0 then
				arg_424_1.mask_.enabled = true
				arg_424_1.mask_.raycastTarget = false

				arg_424_1:SetGaussion(false)
			end

			local var_427_49 = 0.5

			if var_427_48 <= arg_424_1.time_ and arg_424_1.time_ < var_427_48 + var_427_49 then
				local var_427_50 = (arg_424_1.time_ - var_427_48) / var_427_49
				local var_427_51 = Color.New(1, 1, 1)

				var_427_51.a = Mathf.Lerp(1, 0, var_427_50)
				arg_424_1.mask_.color = var_427_51
			end

			if arg_424_1.time_ >= var_427_48 + var_427_49 and arg_424_1.time_ < var_427_48 + var_427_49 + arg_427_0 then
				local var_427_52 = Color.New(1, 1, 1)
				local var_427_53 = 0

				arg_424_1.mask_.enabled = false
				var_427_52.a = var_427_53
				arg_424_1.mask_.color = var_427_52
			end

			if arg_424_1.frameCnt_ <= 1 then
				arg_424_1.dialog_:SetActive(false)
			end

			local var_427_54 = 0.433333333333333
			local var_427_55 = 1.2

			if var_427_54 < arg_424_1.time_ and arg_424_1.time_ <= var_427_54 + arg_427_0 then
				arg_424_1.talkMaxDuration = 0

				arg_424_1.dialog_:SetActive(true)

				arg_424_1.dialogCg_.alpha = 0

				local var_427_56 = LeanTween.value(arg_424_1.dialog_, 0, 1, 0.3)

				var_427_56:setOnUpdate(LuaHelper.FloatAction(function(arg_428_0)
					arg_424_1.dialogCg_.alpha = arg_428_0
				end))
				var_427_56:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_424_1.dialog_)
					var_427_56:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_424_1.duration_ = arg_424_1.duration_ + 0.3

				SetActive(arg_424_1.leftNameGo_, false)

				arg_424_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_424_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_424_1:RecordName(arg_424_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_424_1.iconTrs_.gameObject, false)
				arg_424_1.callingController_:SetSelectedState("normal")

				local var_427_57 = arg_424_1:GetWordFromCfg(322062103)
				local var_427_58 = arg_424_1:FormatText(var_427_57.content)

				arg_424_1.text_.text = var_427_58

				LuaForUtil.ClearLinePrefixSymbol(arg_424_1.text_)

				local var_427_59 = 48
				local var_427_60 = utf8.len(var_427_58)
				local var_427_61 = var_427_59 <= 0 and var_427_55 or var_427_55 * (var_427_60 / var_427_59)

				if var_427_61 > 0 and var_427_55 < var_427_61 then
					arg_424_1.talkMaxDuration = var_427_61
					var_427_54 = var_427_54 + 0.3

					if var_427_61 + var_427_54 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_61 + var_427_54
					end
				end

				arg_424_1.text_.text = var_427_58
				arg_424_1.typewritter.percent = 0

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(false)
				arg_424_1:RecordContent(arg_424_1.text_.text)
			end

			local var_427_62 = var_427_54 + 0.3
			local var_427_63 = math.max(var_427_55, arg_424_1.talkMaxDuration)

			if var_427_62 <= arg_424_1.time_ and arg_424_1.time_ < var_427_62 + var_427_63 then
				arg_424_1.typewritter.percent = (arg_424_1.time_ - var_427_62) / var_427_63

				arg_424_1.typewritter:SetDirty()
			end

			if arg_424_1.time_ >= var_427_62 + var_427_63 and arg_424_1.time_ < var_427_62 + var_427_63 + arg_427_0 then
				arg_424_1.typewritter.percent = 1

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(true)
			end
		end

		arg_424_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_424_1:InitPlayNodeList()
	end,
	Play322062104 = function(arg_430_0, arg_430_1)
		arg_430_1.time_ = 0
		arg_430_1.frameCnt_ = 0
		arg_430_1.state_ = "playing"
		arg_430_1.curTalkId_ = 322062104
		arg_430_1.duration_ = 5

		SetActive(arg_430_1.tipsGo_, false)

		function arg_430_1.onSingleLineFinish_()
			arg_430_1.onSingleLineUpdate_ = nil
			arg_430_1.onSingleLineFinish_ = nil
			arg_430_1.state_ = "waiting"
		end

		function arg_430_1.playNext_(arg_432_0)
			if arg_432_0 == 1 then
				arg_430_0:Play322062105(arg_430_1)
			end
		end

		function arg_430_1.onSingleLineUpdate_(arg_433_0)
			local var_433_0 = 0
			local var_433_1 = 1.7

			if var_433_0 < arg_430_1.time_ and arg_430_1.time_ <= var_433_0 + arg_433_0 then
				arg_430_1.talkMaxDuration = 0
				arg_430_1.dialogCg_.alpha = 1

				arg_430_1.dialog_:SetActive(true)
				SetActive(arg_430_1.leftNameGo_, false)

				arg_430_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_430_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_430_1:RecordName(arg_430_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_430_1.iconTrs_.gameObject, false)
				arg_430_1.callingController_:SetSelectedState("normal")

				local var_433_2 = arg_430_1:GetWordFromCfg(322062104)
				local var_433_3 = arg_430_1:FormatText(var_433_2.content)

				arg_430_1.text_.text = var_433_3

				LuaForUtil.ClearLinePrefixSymbol(arg_430_1.text_)

				local var_433_4 = 68
				local var_433_5 = utf8.len(var_433_3)
				local var_433_6 = var_433_4 <= 0 and var_433_1 or var_433_1 * (var_433_5 / var_433_4)

				if var_433_6 > 0 and var_433_1 < var_433_6 then
					arg_430_1.talkMaxDuration = var_433_6

					if var_433_6 + var_433_0 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_6 + var_433_0
					end
				end

				arg_430_1.text_.text = var_433_3
				arg_430_1.typewritter.percent = 0

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(false)
				arg_430_1:RecordContent(arg_430_1.text_.text)
			end

			local var_433_7 = math.max(var_433_1, arg_430_1.talkMaxDuration)

			if var_433_0 <= arg_430_1.time_ and arg_430_1.time_ < var_433_0 + var_433_7 then
				arg_430_1.typewritter.percent = (arg_430_1.time_ - var_433_0) / var_433_7

				arg_430_1.typewritter:SetDirty()
			end

			if arg_430_1.time_ >= var_433_0 + var_433_7 and arg_430_1.time_ < var_433_0 + var_433_7 + arg_433_0 then
				arg_430_1.typewritter.percent = 1

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(true)
			end
		end

		arg_430_1.nodeConfigList_ = {}

		arg_430_1:InitPlayNodeList()
	end,
	Play322062105 = function(arg_434_0, arg_434_1)
		arg_434_1.time_ = 0
		arg_434_1.frameCnt_ = 0
		arg_434_1.state_ = "playing"
		arg_434_1.curTalkId_ = 322062105
		arg_434_1.duration_ = 7.93

		local var_434_0 = {
			zh = 5.3,
			ja = 7.933
		}
		local var_434_1 = manager.audio:GetLocalizationFlag()

		if var_434_0[var_434_1] ~= nil then
			arg_434_1.duration_ = var_434_0[var_434_1]
		end

		SetActive(arg_434_1.tipsGo_, false)

		function arg_434_1.onSingleLineFinish_()
			arg_434_1.onSingleLineUpdate_ = nil
			arg_434_1.onSingleLineFinish_ = nil
			arg_434_1.state_ = "waiting"
		end

		function arg_434_1.playNext_(arg_436_0)
			if arg_436_0 == 1 then
				arg_434_0:Play322062106(arg_434_1)
			end
		end

		function arg_434_1.onSingleLineUpdate_(arg_437_0)
			local var_437_0 = 0
			local var_437_1 = 0.575

			if var_437_0 < arg_434_1.time_ and arg_434_1.time_ <= var_437_0 + arg_437_0 then
				arg_434_1.talkMaxDuration = 0
				arg_434_1.dialogCg_.alpha = 1

				arg_434_1.dialog_:SetActive(true)
				SetActive(arg_434_1.leftNameGo_, true)

				local var_437_2 = arg_434_1:FormatText(StoryNameCfg[1214].name)

				arg_434_1.leftNameTxt_.text = var_437_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_434_1.leftNameTxt_.transform)

				arg_434_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_434_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_434_1:RecordName(arg_434_1.leftNameTxt_.text)
				SetActive(arg_434_1.iconTrs_.gameObject, true)
				arg_434_1.iconController_:SetSelectedState("hero")

				arg_434_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10103")

				arg_434_1.callingController_:SetSelectedState("calling")

				arg_434_1.keyicon_.color = Color.New(1, 1, 1)
				arg_434_1.icon_.color = Color.New(1, 1, 1)

				local var_437_3 = arg_434_1:GetWordFromCfg(322062105)
				local var_437_4 = arg_434_1:FormatText(var_437_3.content)

				arg_434_1.text_.text = var_437_4

				LuaForUtil.ClearLinePrefixSymbol(arg_434_1.text_)

				local var_437_5 = 23
				local var_437_6 = utf8.len(var_437_4)
				local var_437_7 = var_437_5 <= 0 and var_437_1 or var_437_1 * (var_437_6 / var_437_5)

				if var_437_7 > 0 and var_437_1 < var_437_7 then
					arg_434_1.talkMaxDuration = var_437_7

					if var_437_7 + var_437_0 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_7 + var_437_0
					end
				end

				arg_434_1.text_.text = var_437_4
				arg_434_1.typewritter.percent = 0

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062105", "story_v_out_322062.awb") ~= 0 then
					local var_437_8 = manager.audio:GetVoiceLength("story_v_out_322062", "322062105", "story_v_out_322062.awb") / 1000

					if var_437_8 + var_437_0 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_8 + var_437_0
					end

					if var_437_3.prefab_name ~= "" and arg_434_1.actors_[var_437_3.prefab_name] ~= nil then
						local var_437_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_434_1.actors_[var_437_3.prefab_name].transform, "story_v_out_322062", "322062105", "story_v_out_322062.awb")

						arg_434_1:RecordAudio("322062105", var_437_9)
						arg_434_1:RecordAudio("322062105", var_437_9)
					else
						arg_434_1:AudioAction("play", "voice", "story_v_out_322062", "322062105", "story_v_out_322062.awb")
					end

					arg_434_1:RecordHistoryTalkVoice("story_v_out_322062", "322062105", "story_v_out_322062.awb")
				end

				arg_434_1:RecordContent(arg_434_1.text_.text)
			end

			local var_437_10 = math.max(var_437_1, arg_434_1.talkMaxDuration)

			if var_437_0 <= arg_434_1.time_ and arg_434_1.time_ < var_437_0 + var_437_10 then
				arg_434_1.typewritter.percent = (arg_434_1.time_ - var_437_0) / var_437_10

				arg_434_1.typewritter:SetDirty()
			end

			if arg_434_1.time_ >= var_437_0 + var_437_10 and arg_434_1.time_ < var_437_0 + var_437_10 + arg_437_0 then
				arg_434_1.typewritter.percent = 1

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(true)
			end
		end

		arg_434_1.nodeConfigList_ = {}

		arg_434_1:InitPlayNodeList()
	end,
	Play322062106 = function(arg_438_0, arg_438_1)
		arg_438_1.time_ = 0
		arg_438_1.frameCnt_ = 0
		arg_438_1.state_ = "playing"
		arg_438_1.curTalkId_ = 322062106
		arg_438_1.duration_ = 6.6

		local var_438_0 = {
			zh = 6.566,
			ja = 6.6
		}
		local var_438_1 = manager.audio:GetLocalizationFlag()

		if var_438_0[var_438_1] ~= nil then
			arg_438_1.duration_ = var_438_0[var_438_1]
		end

		SetActive(arg_438_1.tipsGo_, false)

		function arg_438_1.onSingleLineFinish_()
			arg_438_1.onSingleLineUpdate_ = nil
			arg_438_1.onSingleLineFinish_ = nil
			arg_438_1.state_ = "waiting"
		end

		function arg_438_1.playNext_(arg_440_0)
			if arg_440_0 == 1 then
				arg_438_0:Play322062107(arg_438_1)
			end
		end

		function arg_438_1.onSingleLineUpdate_(arg_441_0)
			local var_441_0 = "MS2202"

			if arg_438_1.bgs_[var_441_0] == nil then
				local var_441_1 = Object.Instantiate(arg_438_1.paintGo_)

				var_441_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_441_0)
				var_441_1.name = var_441_0
				var_441_1.transform.parent = arg_438_1.stage_.transform
				var_441_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_438_1.bgs_[var_441_0] = var_441_1
			end

			local var_441_2 = 2

			if var_441_2 < arg_438_1.time_ and arg_438_1.time_ <= var_441_2 + arg_441_0 then
				local var_441_3 = manager.ui.mainCamera.transform.localPosition
				local var_441_4 = Vector3.New(0, 0, 10) + Vector3.New(var_441_3.x, var_441_3.y, 0)
				local var_441_5 = arg_438_1.bgs_.MS2202

				var_441_5.transform.localPosition = var_441_4
				var_441_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_441_6 = var_441_5:GetComponent("SpriteRenderer")

				if var_441_6 and var_441_6.sprite then
					local var_441_7 = (var_441_5.transform.localPosition - var_441_3).z
					local var_441_8 = manager.ui.mainCameraCom_
					local var_441_9 = 2 * var_441_7 * Mathf.Tan(var_441_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_441_10 = var_441_9 * var_441_8.aspect
					local var_441_11 = var_441_6.sprite.bounds.size.x
					local var_441_12 = var_441_6.sprite.bounds.size.y
					local var_441_13 = var_441_10 / var_441_11
					local var_441_14 = var_441_9 / var_441_12
					local var_441_15 = var_441_14 < var_441_13 and var_441_13 or var_441_14

					var_441_5.transform.localScale = Vector3.New(var_441_15, var_441_15, 0)
				end

				for iter_441_0, iter_441_1 in pairs(arg_438_1.bgs_) do
					if iter_441_0 ~= "MS2202" then
						iter_441_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_441_16 = 4

			if var_441_16 < arg_438_1.time_ and arg_438_1.time_ <= var_441_16 + arg_441_0 then
				arg_438_1.allBtn_.enabled = false
			end

			local var_441_17 = 0.3

			if arg_438_1.time_ >= var_441_16 + var_441_17 and arg_438_1.time_ < var_441_16 + var_441_17 + arg_441_0 then
				arg_438_1.allBtn_.enabled = true
			end

			local var_441_18 = 0

			if var_441_18 < arg_438_1.time_ and arg_438_1.time_ <= var_441_18 + arg_441_0 then
				arg_438_1.mask_.enabled = true
				arg_438_1.mask_.raycastTarget = true

				arg_438_1:SetGaussion(false)
			end

			local var_441_19 = 2

			if var_441_18 <= arg_438_1.time_ and arg_438_1.time_ < var_441_18 + var_441_19 then
				local var_441_20 = (arg_438_1.time_ - var_441_18) / var_441_19
				local var_441_21 = Color.New(0, 0, 0)

				var_441_21.a = Mathf.Lerp(0, 1, var_441_20)
				arg_438_1.mask_.color = var_441_21
			end

			if arg_438_1.time_ >= var_441_18 + var_441_19 and arg_438_1.time_ < var_441_18 + var_441_19 + arg_441_0 then
				local var_441_22 = Color.New(0, 0, 0)

				var_441_22.a = 1
				arg_438_1.mask_.color = var_441_22
			end

			local var_441_23 = 2

			if var_441_23 < arg_438_1.time_ and arg_438_1.time_ <= var_441_23 + arg_441_0 then
				arg_438_1.mask_.enabled = true
				arg_438_1.mask_.raycastTarget = true

				arg_438_1:SetGaussion(false)
			end

			local var_441_24 = 2

			if var_441_23 <= arg_438_1.time_ and arg_438_1.time_ < var_441_23 + var_441_24 then
				local var_441_25 = (arg_438_1.time_ - var_441_23) / var_441_24
				local var_441_26 = Color.New(0, 0, 0)

				var_441_26.a = Mathf.Lerp(1, 0, var_441_25)
				arg_438_1.mask_.color = var_441_26
			end

			if arg_438_1.time_ >= var_441_23 + var_441_24 and arg_438_1.time_ < var_441_23 + var_441_24 + arg_441_0 then
				local var_441_27 = Color.New(0, 0, 0)
				local var_441_28 = 0

				arg_438_1.mask_.enabled = false
				var_441_27.a = var_441_28
				arg_438_1.mask_.color = var_441_27
			end

			local var_441_29 = 0.266666666666667
			local var_441_30 = 1

			if var_441_29 < arg_438_1.time_ and arg_438_1.time_ <= var_441_29 + arg_441_0 then
				local var_441_31 = "stop"
				local var_441_32 = "effect"

				arg_438_1:AudioAction(var_441_31, var_441_32, "se_story_141", "se_story_141_amb_street_night02", "")
			end

			local var_441_33 = 1.56666666666667
			local var_441_34 = 1

			if var_441_33 < arg_438_1.time_ and arg_438_1.time_ <= var_441_33 + arg_441_0 then
				local var_441_35 = "play"
				local var_441_36 = "effect"

				arg_438_1:AudioAction(var_441_35, var_441_36, "se_story_145", "se_story_145_amb_MS2202", "")
			end

			local var_441_37 = arg_438_1.bgs_.MS2202.transform
			local var_441_38 = 2

			if var_441_38 < arg_438_1.time_ and arg_438_1.time_ <= var_441_38 + arg_441_0 then
				arg_438_1.var_.moveOldPosMS2202 = var_441_37.localPosition
			end

			local var_441_39 = 0.001

			if var_441_38 <= arg_438_1.time_ and arg_438_1.time_ < var_441_38 + var_441_39 then
				local var_441_40 = (arg_438_1.time_ - var_441_38) / var_441_39
				local var_441_41 = Vector3.New(0, 0.5, 8)

				var_441_37.localPosition = Vector3.Lerp(arg_438_1.var_.moveOldPosMS2202, var_441_41, var_441_40)
			end

			if arg_438_1.time_ >= var_441_38 + var_441_39 and arg_438_1.time_ < var_441_38 + var_441_39 + arg_441_0 then
				var_441_37.localPosition = Vector3.New(0, 0.5, 8)
			end

			local var_441_42 = arg_438_1.bgs_.MS2202.transform
			local var_441_43 = 2.01666666666667

			if var_441_43 < arg_438_1.time_ and arg_438_1.time_ <= var_441_43 + arg_441_0 then
				arg_438_1.var_.moveOldPosMS2202 = var_441_42.localPosition
			end

			local var_441_44 = 1.98333333333333

			if var_441_43 <= arg_438_1.time_ and arg_438_1.time_ < var_441_43 + var_441_44 then
				local var_441_45 = (arg_438_1.time_ - var_441_43) / var_441_44
				local var_441_46 = Vector3.New(0, 1, 9)

				var_441_42.localPosition = Vector3.Lerp(arg_438_1.var_.moveOldPosMS2202, var_441_46, var_441_45)
			end

			if arg_438_1.time_ >= var_441_43 + var_441_44 and arg_438_1.time_ < var_441_43 + var_441_44 + arg_441_0 then
				var_441_42.localPosition = Vector3.New(0, 1, 9)
			end

			local var_441_47 = 1.56666666666667
			local var_441_48 = 1

			if var_441_47 < arg_438_1.time_ and arg_438_1.time_ <= var_441_47 + arg_441_0 then
				local var_441_49 = "play"
				local var_441_50 = "music"

				arg_438_1:AudioAction(var_441_49, var_441_50, "bgm_activity_4_5_story_serious", "battle", "bgm_activity_4_5_story_serious.awb")

				local var_441_51 = ""
				local var_441_52 = manager.audio:GetAudioName("bgm_activity_4_5_story_serious", "battle")

				if var_441_52 ~= "" then
					if arg_438_1.bgmTxt_.text ~= var_441_52 and arg_438_1.bgmTxt_.text ~= "" then
						if arg_438_1.bgmTxt2_.text ~= "" then
							arg_438_1.bgmTxt_.text = arg_438_1.bgmTxt2_.text
						end

						arg_438_1.bgmTxt2_.text = var_441_52

						arg_438_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_438_1.bgmTxt_.text = var_441_52
						arg_438_1.bgmTxt2_.text = var_441_52
					end

					if arg_438_1.bgmTimer then
						arg_438_1.bgmTimer:Stop()

						arg_438_1.bgmTimer = nil
					end

					if arg_438_1.settingData.show_music_name == 1 then
						arg_438_1.musicController:SetSelectedState("show")
						arg_438_1.musicAnimator_:Play("open", 0, 0)

						if arg_438_1.settingData.music_time ~= 0 then
							arg_438_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_438_1.settingData.music_time), function()
								if arg_438_1 == nil or isNil(arg_438_1.bgmTxt_) then
									return
								end

								arg_438_1.musicController:SetSelectedState("hide")
								arg_438_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_441_53 = arg_438_1.actors_["10103ui_story"]
			local var_441_54 = 1.96666666666667

			if var_441_54 < arg_438_1.time_ and arg_438_1.time_ <= var_441_54 + arg_441_0 then
				if arg_438_1.var_.characterEffect10103ui_story == nil then
					arg_438_1.var_.characterEffect10103ui_story = var_441_53:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_441_55 = arg_438_1.var_.characterEffect10103ui_story

				var_441_55.imageEffect:turnOff()

				var_441_55.interferenceEffect.enabled = false
				var_441_55.interferenceEffect.noise = 0.001
				var_441_55.interferenceEffect.simTimeScale = 1
				var_441_55.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_441_56 = arg_438_1.actors_["10103ui_story"]
			local var_441_57 = 1.96666666666667
			local var_441_58 = 0.0166666666666667

			if var_441_57 < arg_438_1.time_ and arg_438_1.time_ <= var_441_57 + arg_441_0 then
				if arg_438_1.var_.characterEffect10103ui_story == nil then
					arg_438_1.var_.characterEffect10103ui_story = var_441_56:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_438_1.var_.characterEffect10103ui_story.imageEffect:turnOff()
			end

			if arg_438_1.frameCnt_ <= 1 then
				arg_438_1.dialog_:SetActive(false)
			end

			local var_441_59 = 4
			local var_441_60 = 0.3

			if var_441_59 < arg_438_1.time_ and arg_438_1.time_ <= var_441_59 + arg_441_0 then
				arg_438_1.talkMaxDuration = 0

				arg_438_1.dialog_:SetActive(true)

				arg_438_1.dialogCg_.alpha = 0

				local var_441_61 = LeanTween.value(arg_438_1.dialog_, 0, 1, 0.3)

				var_441_61:setOnUpdate(LuaHelper.FloatAction(function(arg_443_0)
					arg_438_1.dialogCg_.alpha = arg_443_0
				end))
				var_441_61:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_438_1.dialog_)
					var_441_61:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_438_1.duration_ = arg_438_1.duration_ + 0.3

				SetActive(arg_438_1.leftNameGo_, true)

				local var_441_62 = arg_438_1:FormatText(StoryNameCfg[668].name)

				arg_438_1.leftNameTxt_.text = var_441_62

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_438_1.leftNameTxt_.transform)

				arg_438_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_438_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_438_1:RecordName(arg_438_1.leftNameTxt_.text)
				SetActive(arg_438_1.iconTrs_.gameObject, true)
				arg_438_1.iconController_:SetSelectedState("hero")

				arg_438_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4040")

				arg_438_1.callingController_:SetSelectedState("normal")

				arg_438_1.keyicon_.color = Color.New(1, 1, 1)
				arg_438_1.icon_.color = Color.New(1, 1, 1)

				local var_441_63 = arg_438_1:GetWordFromCfg(322062106)
				local var_441_64 = arg_438_1:FormatText(var_441_63.content)

				arg_438_1.text_.text = var_441_64

				LuaForUtil.ClearLinePrefixSymbol(arg_438_1.text_)

				local var_441_65 = 12
				local var_441_66 = utf8.len(var_441_64)
				local var_441_67 = var_441_65 <= 0 and var_441_60 or var_441_60 * (var_441_66 / var_441_65)

				if var_441_67 > 0 and var_441_60 < var_441_67 then
					arg_438_1.talkMaxDuration = var_441_67
					var_441_59 = var_441_59 + 0.3

					if var_441_67 + var_441_59 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_67 + var_441_59
					end
				end

				arg_438_1.text_.text = var_441_64
				arg_438_1.typewritter.percent = 0

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062106", "story_v_out_322062.awb") ~= 0 then
					local var_441_68 = manager.audio:GetVoiceLength("story_v_out_322062", "322062106", "story_v_out_322062.awb") / 1000

					if var_441_68 + var_441_59 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_68 + var_441_59
					end

					if var_441_63.prefab_name ~= "" and arg_438_1.actors_[var_441_63.prefab_name] ~= nil then
						local var_441_69 = LuaForUtil.PlayVoiceWithCriLipsync(arg_438_1.actors_[var_441_63.prefab_name].transform, "story_v_out_322062", "322062106", "story_v_out_322062.awb")

						arg_438_1:RecordAudio("322062106", var_441_69)
						arg_438_1:RecordAudio("322062106", var_441_69)
					else
						arg_438_1:AudioAction("play", "voice", "story_v_out_322062", "322062106", "story_v_out_322062.awb")
					end

					arg_438_1:RecordHistoryTalkVoice("story_v_out_322062", "322062106", "story_v_out_322062.awb")
				end

				arg_438_1:RecordContent(arg_438_1.text_.text)
			end

			local var_441_70 = var_441_59 + 0.3
			local var_441_71 = math.max(var_441_60, arg_438_1.talkMaxDuration)

			if var_441_70 <= arg_438_1.time_ and arg_438_1.time_ < var_441_70 + var_441_71 then
				arg_438_1.typewritter.percent = (arg_438_1.time_ - var_441_70) / var_441_71

				arg_438_1.typewritter:SetDirty()
			end

			if arg_438_1.time_ >= var_441_70 + var_441_71 and arg_438_1.time_ < var_441_70 + var_441_71 + arg_441_0 then
				arg_438_1.typewritter.percent = 1

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(true)
			end
		end

		arg_438_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "MS2202",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "MS2202",
				changeDisplayLayer = false,
				needEase = false,
				duration = 1.98333333333333,
				className = "StoryMoveNode",
				startTime = 2.01666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_438_1:InitPlayNodeList()
	end,
	Play322062107 = function(arg_445_0, arg_445_1)
		arg_445_1.time_ = 0
		arg_445_1.frameCnt_ = 0
		arg_445_1.state_ = "playing"
		arg_445_1.curTalkId_ = 322062107
		arg_445_1.duration_ = 5

		SetActive(arg_445_1.tipsGo_, false)

		function arg_445_1.onSingleLineFinish_()
			arg_445_1.onSingleLineUpdate_ = nil
			arg_445_1.onSingleLineFinish_ = nil
			arg_445_1.state_ = "waiting"
		end

		function arg_445_1.playNext_(arg_447_0)
			if arg_447_0 == 1 then
				arg_445_0:Play322062108(arg_445_1)
			end
		end

		function arg_445_1.onSingleLineUpdate_(arg_448_0)
			local var_448_0 = 0
			local var_448_1 = 0.6

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

				local var_448_2 = arg_445_1:GetWordFromCfg(322062107)
				local var_448_3 = arg_445_1:FormatText(var_448_2.content)

				arg_445_1.text_.text = var_448_3

				LuaForUtil.ClearLinePrefixSymbol(arg_445_1.text_)

				local var_448_4 = 24
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
	Play322062108 = function(arg_449_0, arg_449_1)
		arg_449_1.time_ = 0
		arg_449_1.frameCnt_ = 0
		arg_449_1.state_ = "playing"
		arg_449_1.curTalkId_ = 322062108
		arg_449_1.duration_ = 7

		SetActive(arg_449_1.tipsGo_, false)

		function arg_449_1.onSingleLineFinish_()
			arg_449_1.onSingleLineUpdate_ = nil
			arg_449_1.onSingleLineFinish_ = nil
			arg_449_1.state_ = "waiting"
		end

		function arg_449_1.playNext_(arg_451_0)
			if arg_451_0 == 1 then
				arg_449_0:Play322062109(arg_449_1)
			end
		end

		function arg_449_1.onSingleLineUpdate_(arg_452_0)
			local var_452_0 = arg_449_1.bgs_.MS2202.transform
			local var_452_1 = 0

			if var_452_1 < arg_449_1.time_ and arg_449_1.time_ <= var_452_1 + arg_452_0 then
				arg_449_1.var_.moveOldPosMS2202 = var_452_0.localPosition
			end

			local var_452_2 = 2

			if var_452_1 <= arg_449_1.time_ and arg_449_1.time_ < var_452_1 + var_452_2 then
				local var_452_3 = (arg_449_1.time_ - var_452_1) / var_452_2
				local var_452_4 = Vector3.New(0, 1, 10)

				var_452_0.localPosition = Vector3.Lerp(arg_449_1.var_.moveOldPosMS2202, var_452_4, var_452_3)
			end

			if arg_449_1.time_ >= var_452_1 + var_452_2 and arg_449_1.time_ < var_452_1 + var_452_2 + arg_452_0 then
				var_452_0.localPosition = Vector3.New(0, 1, 10)
			end

			local var_452_5 = 0

			if var_452_5 < arg_449_1.time_ and arg_449_1.time_ <= var_452_5 + arg_452_0 then
				arg_449_1.allBtn_.enabled = false
			end

			local var_452_6 = 2

			if arg_449_1.time_ >= var_452_5 + var_452_6 and arg_449_1.time_ < var_452_5 + var_452_6 + arg_452_0 then
				arg_449_1.allBtn_.enabled = true
			end

			if arg_449_1.frameCnt_ <= 1 then
				arg_449_1.dialog_:SetActive(false)
			end

			local var_452_7 = 2
			local var_452_8 = 1.275

			if var_452_7 < arg_449_1.time_ and arg_449_1.time_ <= var_452_7 + arg_452_0 then
				arg_449_1.talkMaxDuration = 0

				arg_449_1.dialog_:SetActive(true)

				arg_449_1.dialogCg_.alpha = 0

				local var_452_9 = LeanTween.value(arg_449_1.dialog_, 0, 1, 0.3)

				var_452_9:setOnUpdate(LuaHelper.FloatAction(function(arg_453_0)
					arg_449_1.dialogCg_.alpha = arg_453_0
				end))
				var_452_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_449_1.dialog_)
					var_452_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_449_1.duration_ = arg_449_1.duration_ + 0.3

				SetActive(arg_449_1.leftNameGo_, false)

				arg_449_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_449_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_449_1:RecordName(arg_449_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_449_1.iconTrs_.gameObject, false)
				arg_449_1.callingController_:SetSelectedState("normal")

				local var_452_10 = arg_449_1:GetWordFromCfg(322062108)
				local var_452_11 = arg_449_1:FormatText(var_452_10.content)

				arg_449_1.text_.text = var_452_11

				LuaForUtil.ClearLinePrefixSymbol(arg_449_1.text_)

				local var_452_12 = 51
				local var_452_13 = utf8.len(var_452_11)
				local var_452_14 = var_452_12 <= 0 and var_452_8 or var_452_8 * (var_452_13 / var_452_12)

				if var_452_14 > 0 and var_452_8 < var_452_14 then
					arg_449_1.talkMaxDuration = var_452_14
					var_452_7 = var_452_7 + 0.3

					if var_452_14 + var_452_7 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_14 + var_452_7
					end
				end

				arg_449_1.text_.text = var_452_11
				arg_449_1.typewritter.percent = 0

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(false)
				arg_449_1:RecordContent(arg_449_1.text_.text)
			end

			local var_452_15 = var_452_7 + 0.3
			local var_452_16 = math.max(var_452_8, arg_449_1.talkMaxDuration)

			if var_452_15 <= arg_449_1.time_ and arg_449_1.time_ < var_452_15 + var_452_16 then
				arg_449_1.typewritter.percent = (arg_449_1.time_ - var_452_15) / var_452_16

				arg_449_1.typewritter:SetDirty()
			end

			if arg_449_1.time_ >= var_452_15 + var_452_16 and arg_449_1.time_ < var_452_15 + var_452_16 + arg_452_0 then
				arg_449_1.typewritter.percent = 1

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(true)
			end
		end

		arg_449_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "MS2202",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 9),
					endPos = Vector3.New(0, 1, 10),
					easeType = LeanTweenType.easeInOutCubic
				}
			}
		}

		arg_449_1:InitPlayNodeList()
	end,
	Play322062109 = function(arg_455_0, arg_455_1)
		arg_455_1.time_ = 0
		arg_455_1.frameCnt_ = 0
		arg_455_1.state_ = "playing"
		arg_455_1.curTalkId_ = 322062109
		arg_455_1.duration_ = 7.33

		SetActive(arg_455_1.tipsGo_, false)

		function arg_455_1.onSingleLineFinish_()
			arg_455_1.onSingleLineUpdate_ = nil
			arg_455_1.onSingleLineFinish_ = nil
			arg_455_1.state_ = "waiting"
		end

		function arg_455_1.playNext_(arg_457_0)
			if arg_457_0 == 1 then
				arg_455_0:Play322062110(arg_455_1)
			end
		end

		function arg_455_1.onSingleLineUpdate_(arg_458_0)
			local var_458_0 = 0.333333333333333

			if var_458_0 < arg_455_1.time_ and arg_455_1.time_ <= var_458_0 + arg_458_0 then
				local var_458_1 = manager.ui.mainCamera.transform.localPosition
				local var_458_2 = Vector3.New(0, 0, 10) + Vector3.New(var_458_1.x, var_458_1.y, 0)
				local var_458_3 = arg_455_1.bgs_.MS2202

				var_458_3.transform.localPosition = var_458_2
				var_458_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_458_4 = var_458_3:GetComponent("SpriteRenderer")

				if var_458_4 and var_458_4.sprite then
					local var_458_5 = (var_458_3.transform.localPosition - var_458_1).z
					local var_458_6 = manager.ui.mainCameraCom_
					local var_458_7 = 2 * var_458_5 * Mathf.Tan(var_458_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_458_8 = var_458_7 * var_458_6.aspect
					local var_458_9 = var_458_4.sprite.bounds.size.x
					local var_458_10 = var_458_4.sprite.bounds.size.y
					local var_458_11 = var_458_8 / var_458_9
					local var_458_12 = var_458_7 / var_458_10
					local var_458_13 = var_458_12 < var_458_11 and var_458_11 or var_458_12

					var_458_3.transform.localScale = Vector3.New(var_458_13, var_458_13, 0)
				end

				for iter_458_0, iter_458_1 in pairs(arg_455_1.bgs_) do
					if iter_458_0 ~= "MS2202" then
						iter_458_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_458_14 = 0

			if var_458_14 < arg_455_1.time_ and arg_455_1.time_ <= var_458_14 + arg_458_0 then
				arg_455_1.mask_.enabled = true
				arg_455_1.mask_.raycastTarget = true

				arg_455_1:SetGaussion(false)
			end

			local var_458_15 = 0.333333333333333

			if var_458_14 <= arg_455_1.time_ and arg_455_1.time_ < var_458_14 + var_458_15 then
				local var_458_16 = (arg_455_1.time_ - var_458_14) / var_458_15
				local var_458_17 = Color.New(0, 0, 0)

				var_458_17.a = Mathf.Lerp(0, 1, var_458_16)
				arg_455_1.mask_.color = var_458_17
			end

			if arg_455_1.time_ >= var_458_14 + var_458_15 and arg_455_1.time_ < var_458_14 + var_458_15 + arg_458_0 then
				local var_458_18 = Color.New(0, 0, 0)

				var_458_18.a = 1
				arg_455_1.mask_.color = var_458_18
			end

			local var_458_19 = 0.333333333333333

			if var_458_19 < arg_455_1.time_ and arg_455_1.time_ <= var_458_19 + arg_458_0 then
				arg_455_1.mask_.enabled = true
				arg_455_1.mask_.raycastTarget = true

				arg_455_1:SetGaussion(false)
			end

			local var_458_20 = 0.333333333333333

			if var_458_19 <= arg_455_1.time_ and arg_455_1.time_ < var_458_19 + var_458_20 then
				local var_458_21 = (arg_455_1.time_ - var_458_19) / var_458_20
				local var_458_22 = Color.New(0, 0, 0)

				var_458_22.a = Mathf.Lerp(1, 0, var_458_21)
				arg_455_1.mask_.color = var_458_22
			end

			if arg_455_1.time_ >= var_458_19 + var_458_20 and arg_455_1.time_ < var_458_19 + var_458_20 + arg_458_0 then
				local var_458_23 = Color.New(0, 0, 0)
				local var_458_24 = 0

				arg_455_1.mask_.enabled = false
				var_458_23.a = var_458_24
				arg_455_1.mask_.color = var_458_23
			end

			local var_458_25 = arg_455_1.bgs_.MS2202.transform
			local var_458_26 = 0.333333333333333

			if var_458_26 < arg_455_1.time_ and arg_455_1.time_ <= var_458_26 + arg_458_0 then
				arg_455_1.var_.moveOldPosMS2202 = var_458_25.localPosition
			end

			local var_458_27 = 0.001

			if var_458_26 <= arg_455_1.time_ and arg_455_1.time_ < var_458_26 + var_458_27 then
				local var_458_28 = (arg_455_1.time_ - var_458_26) / var_458_27
				local var_458_29 = Vector3.New(0, 1, 9.5)

				var_458_25.localPosition = Vector3.Lerp(arg_455_1.var_.moveOldPosMS2202, var_458_29, var_458_28)
			end

			if arg_455_1.time_ >= var_458_26 + var_458_27 and arg_455_1.time_ < var_458_26 + var_458_27 + arg_458_0 then
				var_458_25.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_458_30 = arg_455_1.bgs_.MS2202.transform
			local var_458_31 = 0.35

			if var_458_31 < arg_455_1.time_ and arg_455_1.time_ <= var_458_31 + arg_458_0 then
				arg_455_1.var_.moveOldPosMS2202 = var_458_30.localPosition
			end

			local var_458_32 = 1.26666666666667

			if var_458_31 <= arg_455_1.time_ and arg_455_1.time_ < var_458_31 + var_458_32 then
				local var_458_33 = (arg_455_1.time_ - var_458_31) / var_458_32
				local var_458_34 = Vector3.New(0, 1, 10)

				var_458_30.localPosition = Vector3.Lerp(arg_455_1.var_.moveOldPosMS2202, var_458_34, var_458_33)
			end

			if arg_455_1.time_ >= var_458_31 + var_458_32 and arg_455_1.time_ < var_458_31 + var_458_32 + arg_458_0 then
				var_458_30.localPosition = Vector3.New(0, 1, 10)
			end

			if arg_455_1.frameCnt_ <= 1 then
				arg_455_1.dialog_:SetActive(false)
			end

			local var_458_35 = 2.33333333333333
			local var_458_36 = 1.825

			if var_458_35 < arg_455_1.time_ and arg_455_1.time_ <= var_458_35 + arg_458_0 then
				arg_455_1.talkMaxDuration = 0

				arg_455_1.dialog_:SetActive(true)

				arg_455_1.dialogCg_.alpha = 0

				local var_458_37 = LeanTween.value(arg_455_1.dialog_, 0, 1, 0.3)

				var_458_37:setOnUpdate(LuaHelper.FloatAction(function(arg_459_0)
					arg_455_1.dialogCg_.alpha = arg_459_0
				end))
				var_458_37:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_455_1.dialog_)
					var_458_37:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_455_1.duration_ = arg_455_1.duration_ + 0.3

				SetActive(arg_455_1.leftNameGo_, false)

				arg_455_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_455_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_455_1:RecordName(arg_455_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_455_1.iconTrs_.gameObject, false)
				arg_455_1.callingController_:SetSelectedState("normal")

				local var_458_38 = arg_455_1:GetWordFromCfg(322062109)
				local var_458_39 = arg_455_1:FormatText(var_458_38.content)

				arg_455_1.text_.text = var_458_39

				LuaForUtil.ClearLinePrefixSymbol(arg_455_1.text_)

				local var_458_40 = 73
				local var_458_41 = utf8.len(var_458_39)
				local var_458_42 = var_458_40 <= 0 and var_458_36 or var_458_36 * (var_458_41 / var_458_40)

				if var_458_42 > 0 and var_458_36 < var_458_42 then
					arg_455_1.talkMaxDuration = var_458_42
					var_458_35 = var_458_35 + 0.3

					if var_458_42 + var_458_35 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_42 + var_458_35
					end
				end

				arg_455_1.text_.text = var_458_39
				arg_455_1.typewritter.percent = 0

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(false)
				arg_455_1:RecordContent(arg_455_1.text_.text)
			end

			local var_458_43 = var_458_35 + 0.3
			local var_458_44 = math.max(var_458_36, arg_455_1.talkMaxDuration)

			if var_458_43 <= arg_455_1.time_ and arg_455_1.time_ < var_458_43 + var_458_44 then
				arg_455_1.typewritter.percent = (arg_455_1.time_ - var_458_43) / var_458_44

				arg_455_1.typewritter:SetDirty()
			end

			if arg_455_1.time_ >= var_458_43 + var_458_44 and arg_455_1.time_ < var_458_43 + var_458_44 + arg_458_0 then
				arg_455_1.typewritter.percent = 1

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(true)
			end
		end

		arg_455_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "MS2202",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0.333333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "MS2202",
				changeDisplayLayer = false,
				needEase = false,
				duration = 1.26666666666667,
				className = "StoryMoveNode",
				startTime = 0.35,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_455_1:InitPlayNodeList()
	end,
	Play322062110 = function(arg_461_0, arg_461_1)
		arg_461_1.time_ = 0
		arg_461_1.frameCnt_ = 0
		arg_461_1.state_ = "playing"
		arg_461_1.curTalkId_ = 322062110
		arg_461_1.duration_ = 6.8

		local var_461_0 = {
			zh = 4.7,
			ja = 6.8
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
				arg_461_0:Play322062111(arg_461_1)
			end
		end

		function arg_461_1.onSingleLineUpdate_(arg_464_0)
			local var_464_0 = 0
			local var_464_1 = 0.575

			if var_464_0 < arg_461_1.time_ and arg_461_1.time_ <= var_464_0 + arg_464_0 then
				arg_461_1.talkMaxDuration = 0
				arg_461_1.dialogCg_.alpha = 1

				arg_461_1.dialog_:SetActive(true)
				SetActive(arg_461_1.leftNameGo_, true)

				local var_464_2 = arg_461_1:FormatText(StoryNameCfg[668].name)

				arg_461_1.leftNameTxt_.text = var_464_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_461_1.leftNameTxt_.transform)

				arg_461_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_461_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_461_1:RecordName(arg_461_1.leftNameTxt_.text)
				SetActive(arg_461_1.iconTrs_.gameObject, true)
				arg_461_1.iconController_:SetSelectedState("hero")

				arg_461_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4040")

				arg_461_1.callingController_:SetSelectedState("normal")

				arg_461_1.keyicon_.color = Color.New(1, 1, 1)
				arg_461_1.icon_.color = Color.New(1, 1, 1)

				local var_464_3 = arg_461_1:GetWordFromCfg(322062110)
				local var_464_4 = arg_461_1:FormatText(var_464_3.content)

				arg_461_1.text_.text = var_464_4

				LuaForUtil.ClearLinePrefixSymbol(arg_461_1.text_)

				local var_464_5 = 23
				local var_464_6 = utf8.len(var_464_4)
				local var_464_7 = var_464_5 <= 0 and var_464_1 or var_464_1 * (var_464_6 / var_464_5)

				if var_464_7 > 0 and var_464_1 < var_464_7 then
					arg_461_1.talkMaxDuration = var_464_7

					if var_464_7 + var_464_0 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_7 + var_464_0
					end
				end

				arg_461_1.text_.text = var_464_4
				arg_461_1.typewritter.percent = 0

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062110", "story_v_out_322062.awb") ~= 0 then
					local var_464_8 = manager.audio:GetVoiceLength("story_v_out_322062", "322062110", "story_v_out_322062.awb") / 1000

					if var_464_8 + var_464_0 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_8 + var_464_0
					end

					if var_464_3.prefab_name ~= "" and arg_461_1.actors_[var_464_3.prefab_name] ~= nil then
						local var_464_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_461_1.actors_[var_464_3.prefab_name].transform, "story_v_out_322062", "322062110", "story_v_out_322062.awb")

						arg_461_1:RecordAudio("322062110", var_464_9)
						arg_461_1:RecordAudio("322062110", var_464_9)
					else
						arg_461_1:AudioAction("play", "voice", "story_v_out_322062", "322062110", "story_v_out_322062.awb")
					end

					arg_461_1:RecordHistoryTalkVoice("story_v_out_322062", "322062110", "story_v_out_322062.awb")
				end

				arg_461_1:RecordContent(arg_461_1.text_.text)
			end

			local var_464_10 = math.max(var_464_1, arg_461_1.talkMaxDuration)

			if var_464_0 <= arg_461_1.time_ and arg_461_1.time_ < var_464_0 + var_464_10 then
				arg_461_1.typewritter.percent = (arg_461_1.time_ - var_464_0) / var_464_10

				arg_461_1.typewritter:SetDirty()
			end

			if arg_461_1.time_ >= var_464_0 + var_464_10 and arg_461_1.time_ < var_464_0 + var_464_10 + arg_464_0 then
				arg_461_1.typewritter.percent = 1

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(true)
			end
		end

		arg_461_1.nodeConfigList_ = {}

		arg_461_1:InitPlayNodeList()
	end,
	Play322062111 = function(arg_465_0, arg_465_1)
		arg_465_1.time_ = 0
		arg_465_1.frameCnt_ = 0
		arg_465_1.state_ = "playing"
		arg_465_1.curTalkId_ = 322062111
		arg_465_1.duration_ = 1.8

		local var_465_0 = {
			zh = 1.4,
			ja = 1.8
		}
		local var_465_1 = manager.audio:GetLocalizationFlag()

		if var_465_0[var_465_1] ~= nil then
			arg_465_1.duration_ = var_465_0[var_465_1]
		end

		SetActive(arg_465_1.tipsGo_, false)

		function arg_465_1.onSingleLineFinish_()
			arg_465_1.onSingleLineUpdate_ = nil
			arg_465_1.onSingleLineFinish_ = nil
			arg_465_1.state_ = "waiting"
		end

		function arg_465_1.playNext_(arg_467_0)
			if arg_467_0 == 1 then
				arg_465_0:Play322062112(arg_465_1)
			end
		end

		function arg_465_1.onSingleLineUpdate_(arg_468_0)
			local var_468_0 = 0
			local var_468_1 = 0.125

			if var_468_0 < arg_465_1.time_ and arg_465_1.time_ <= var_468_0 + arg_468_0 then
				arg_465_1.talkMaxDuration = 0
				arg_465_1.dialogCg_.alpha = 1

				arg_465_1.dialog_:SetActive(true)
				SetActive(arg_465_1.leftNameGo_, true)

				local var_468_2 = arg_465_1:FormatText(StoryNameCfg[605].name)

				arg_465_1.leftNameTxt_.text = var_468_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_465_1.leftNameTxt_.transform)

				arg_465_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_465_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_465_1:RecordName(arg_465_1.leftNameTxt_.text)
				SetActive(arg_465_1.iconTrs_.gameObject, true)
				arg_465_1.iconController_:SetSelectedState("hero")

				arg_465_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1156")

				arg_465_1.callingController_:SetSelectedState("normal")

				arg_465_1.keyicon_.color = Color.New(1, 1, 1)
				arg_465_1.icon_.color = Color.New(1, 1, 1)

				local var_468_3 = arg_465_1:GetWordFromCfg(322062111)
				local var_468_4 = arg_465_1:FormatText(var_468_3.content)

				arg_465_1.text_.text = var_468_4

				LuaForUtil.ClearLinePrefixSymbol(arg_465_1.text_)

				local var_468_5 = 5
				local var_468_6 = utf8.len(var_468_4)
				local var_468_7 = var_468_5 <= 0 and var_468_1 or var_468_1 * (var_468_6 / var_468_5)

				if var_468_7 > 0 and var_468_1 < var_468_7 then
					arg_465_1.talkMaxDuration = var_468_7

					if var_468_7 + var_468_0 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_7 + var_468_0
					end
				end

				arg_465_1.text_.text = var_468_4
				arg_465_1.typewritter.percent = 0

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062111", "story_v_out_322062.awb") ~= 0 then
					local var_468_8 = manager.audio:GetVoiceLength("story_v_out_322062", "322062111", "story_v_out_322062.awb") / 1000

					if var_468_8 + var_468_0 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_8 + var_468_0
					end

					if var_468_3.prefab_name ~= "" and arg_465_1.actors_[var_468_3.prefab_name] ~= nil then
						local var_468_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_465_1.actors_[var_468_3.prefab_name].transform, "story_v_out_322062", "322062111", "story_v_out_322062.awb")

						arg_465_1:RecordAudio("322062111", var_468_9)
						arg_465_1:RecordAudio("322062111", var_468_9)
					else
						arg_465_1:AudioAction("play", "voice", "story_v_out_322062", "322062111", "story_v_out_322062.awb")
					end

					arg_465_1:RecordHistoryTalkVoice("story_v_out_322062", "322062111", "story_v_out_322062.awb")
				end

				arg_465_1:RecordContent(arg_465_1.text_.text)
			end

			local var_468_10 = math.max(var_468_1, arg_465_1.talkMaxDuration)

			if var_468_0 <= arg_465_1.time_ and arg_465_1.time_ < var_468_0 + var_468_10 then
				arg_465_1.typewritter.percent = (arg_465_1.time_ - var_468_0) / var_468_10

				arg_465_1.typewritter:SetDirty()
			end

			if arg_465_1.time_ >= var_468_0 + var_468_10 and arg_465_1.time_ < var_468_0 + var_468_10 + arg_468_0 then
				arg_465_1.typewritter.percent = 1

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(true)
			end
		end

		arg_465_1.nodeConfigList_ = {}

		arg_465_1:InitPlayNodeList()
	end,
	Play322062112 = function(arg_469_0, arg_469_1)
		arg_469_1.time_ = 0
		arg_469_1.frameCnt_ = 0
		arg_469_1.state_ = "playing"
		arg_469_1.curTalkId_ = 322062112
		arg_469_1.duration_ = 2.07

		local var_469_0 = {
			zh = 1.266,
			ja = 2.066
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
				arg_469_0:Play322062113(arg_469_1)
			end
		end

		function arg_469_1.onSingleLineUpdate_(arg_472_0)
			local var_472_0 = 0
			local var_472_1 = 0.125

			if var_472_0 < arg_469_1.time_ and arg_469_1.time_ <= var_472_0 + arg_472_0 then
				arg_469_1.talkMaxDuration = 0
				arg_469_1.dialogCg_.alpha = 1

				arg_469_1.dialog_:SetActive(true)
				SetActive(arg_469_1.leftNameGo_, true)

				local var_472_2 = arg_469_1:FormatText(StoryNameCfg[1030].name)

				arg_469_1.leftNameTxt_.text = var_472_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_469_1.leftNameTxt_.transform)

				arg_469_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_469_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_469_1:RecordName(arg_469_1.leftNameTxt_.text)
				SetActive(arg_469_1.iconTrs_.gameObject, true)
				arg_469_1.iconController_:SetSelectedState("hero")

				arg_469_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_469_1.callingController_:SetSelectedState("calling")

				arg_469_1.keyicon_.color = Color.New(1, 1, 1)
				arg_469_1.icon_.color = Color.New(1, 1, 1)

				local var_472_3 = arg_469_1:GetWordFromCfg(322062112)
				local var_472_4 = arg_469_1:FormatText(var_472_3.content)

				arg_469_1.text_.text = var_472_4

				LuaForUtil.ClearLinePrefixSymbol(arg_469_1.text_)

				local var_472_5 = 5
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

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062112", "story_v_out_322062.awb") ~= 0 then
					local var_472_8 = manager.audio:GetVoiceLength("story_v_out_322062", "322062112", "story_v_out_322062.awb") / 1000

					if var_472_8 + var_472_0 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_8 + var_472_0
					end

					if var_472_3.prefab_name ~= "" and arg_469_1.actors_[var_472_3.prefab_name] ~= nil then
						local var_472_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_469_1.actors_[var_472_3.prefab_name].transform, "story_v_out_322062", "322062112", "story_v_out_322062.awb")

						arg_469_1:RecordAudio("322062112", var_472_9)
						arg_469_1:RecordAudio("322062112", var_472_9)
					else
						arg_469_1:AudioAction("play", "voice", "story_v_out_322062", "322062112", "story_v_out_322062.awb")
					end

					arg_469_1:RecordHistoryTalkVoice("story_v_out_322062", "322062112", "story_v_out_322062.awb")
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
	Play322062113 = function(arg_473_0, arg_473_1)
		arg_473_1.time_ = 0
		arg_473_1.frameCnt_ = 0
		arg_473_1.state_ = "playing"
		arg_473_1.curTalkId_ = 322062113
		arg_473_1.duration_ = 2.83

		local var_473_0 = {
			zh = 1.233,
			ja = 2.833
		}
		local var_473_1 = manager.audio:GetLocalizationFlag()

		if var_473_0[var_473_1] ~= nil then
			arg_473_1.duration_ = var_473_0[var_473_1]
		end

		SetActive(arg_473_1.tipsGo_, false)

		function arg_473_1.onSingleLineFinish_()
			arg_473_1.onSingleLineUpdate_ = nil
			arg_473_1.onSingleLineFinish_ = nil
			arg_473_1.state_ = "waiting"
		end

		function arg_473_1.playNext_(arg_475_0)
			if arg_475_0 == 1 then
				arg_473_0:Play322062114(arg_473_1)
			end
		end

		function arg_473_1.onSingleLineUpdate_(arg_476_0)
			local var_476_0 = 0
			local var_476_1 = 0.125

			if var_476_0 < arg_473_1.time_ and arg_473_1.time_ <= var_476_0 + arg_476_0 then
				arg_473_1.talkMaxDuration = 0
				arg_473_1.dialogCg_.alpha = 1

				arg_473_1.dialog_:SetActive(true)
				SetActive(arg_473_1.leftNameGo_, true)

				local var_476_2 = arg_473_1:FormatText(StoryNameCfg[6].name)

				arg_473_1.leftNameTxt_.text = var_476_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_473_1.leftNameTxt_.transform)

				arg_473_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_473_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_473_1:RecordName(arg_473_1.leftNameTxt_.text)
				SetActive(arg_473_1.iconTrs_.gameObject, true)
				arg_473_1.iconController_:SetSelectedState("hero")

				arg_473_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1284")

				arg_473_1.callingController_:SetSelectedState("normal")

				arg_473_1.keyicon_.color = Color.New(1, 1, 1)
				arg_473_1.icon_.color = Color.New(1, 1, 1)

				local var_476_3 = arg_473_1:GetWordFromCfg(322062113)
				local var_476_4 = arg_473_1:FormatText(var_476_3.content)

				arg_473_1.text_.text = var_476_4

				LuaForUtil.ClearLinePrefixSymbol(arg_473_1.text_)

				local var_476_5 = 5
				local var_476_6 = utf8.len(var_476_4)
				local var_476_7 = var_476_5 <= 0 and var_476_1 or var_476_1 * (var_476_6 / var_476_5)

				if var_476_7 > 0 and var_476_1 < var_476_7 then
					arg_473_1.talkMaxDuration = var_476_7

					if var_476_7 + var_476_0 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_7 + var_476_0
					end
				end

				arg_473_1.text_.text = var_476_4
				arg_473_1.typewritter.percent = 0

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062113", "story_v_out_322062.awb") ~= 0 then
					local var_476_8 = manager.audio:GetVoiceLength("story_v_out_322062", "322062113", "story_v_out_322062.awb") / 1000

					if var_476_8 + var_476_0 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_8 + var_476_0
					end

					if var_476_3.prefab_name ~= "" and arg_473_1.actors_[var_476_3.prefab_name] ~= nil then
						local var_476_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_473_1.actors_[var_476_3.prefab_name].transform, "story_v_out_322062", "322062113", "story_v_out_322062.awb")

						arg_473_1:RecordAudio("322062113", var_476_9)
						arg_473_1:RecordAudio("322062113", var_476_9)
					else
						arg_473_1:AudioAction("play", "voice", "story_v_out_322062", "322062113", "story_v_out_322062.awb")
					end

					arg_473_1:RecordHistoryTalkVoice("story_v_out_322062", "322062113", "story_v_out_322062.awb")
				end

				arg_473_1:RecordContent(arg_473_1.text_.text)
			end

			local var_476_10 = math.max(var_476_1, arg_473_1.talkMaxDuration)

			if var_476_0 <= arg_473_1.time_ and arg_473_1.time_ < var_476_0 + var_476_10 then
				arg_473_1.typewritter.percent = (arg_473_1.time_ - var_476_0) / var_476_10

				arg_473_1.typewritter:SetDirty()
			end

			if arg_473_1.time_ >= var_476_0 + var_476_10 and arg_473_1.time_ < var_476_0 + var_476_10 + arg_476_0 then
				arg_473_1.typewritter.percent = 1

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(true)
			end
		end

		arg_473_1.nodeConfigList_ = {}

		arg_473_1:InitPlayNodeList()
	end,
	Play322062114 = function(arg_477_0, arg_477_1)
		arg_477_1.time_ = 0
		arg_477_1.frameCnt_ = 0
		arg_477_1.state_ = "playing"
		arg_477_1.curTalkId_ = 322062114
		arg_477_1.duration_ = 9.77

		local var_477_0 = {
			zh = 7,
			ja = 9.766
		}
		local var_477_1 = manager.audio:GetLocalizationFlag()

		if var_477_0[var_477_1] ~= nil then
			arg_477_1.duration_ = var_477_0[var_477_1]
		end

		SetActive(arg_477_1.tipsGo_, false)

		function arg_477_1.onSingleLineFinish_()
			arg_477_1.onSingleLineUpdate_ = nil
			arg_477_1.onSingleLineFinish_ = nil
			arg_477_1.state_ = "waiting"
		end

		function arg_477_1.playNext_(arg_479_0)
			if arg_479_0 == 1 then
				arg_477_0:Play322062115(arg_477_1)
			end
		end

		function arg_477_1.onSingleLineUpdate_(arg_480_0)
			local var_480_0 = 0
			local var_480_1 = 0.725

			if var_480_0 < arg_477_1.time_ and arg_477_1.time_ <= var_480_0 + arg_480_0 then
				arg_477_1.talkMaxDuration = 0
				arg_477_1.dialogCg_.alpha = 1

				arg_477_1.dialog_:SetActive(true)
				SetActive(arg_477_1.leftNameGo_, true)

				local var_480_2 = arg_477_1:FormatText(StoryNameCfg[1030].name)

				arg_477_1.leftNameTxt_.text = var_480_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_477_1.leftNameTxt_.transform)

				arg_477_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_477_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_477_1:RecordName(arg_477_1.leftNameTxt_.text)
				SetActive(arg_477_1.iconTrs_.gameObject, true)
				arg_477_1.iconController_:SetSelectedState("hero")

				arg_477_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_477_1.callingController_:SetSelectedState("calling")

				arg_477_1.keyicon_.color = Color.New(1, 1, 1)
				arg_477_1.icon_.color = Color.New(1, 1, 1)

				local var_480_3 = arg_477_1:GetWordFromCfg(322062114)
				local var_480_4 = arg_477_1:FormatText(var_480_3.content)

				arg_477_1.text_.text = var_480_4

				LuaForUtil.ClearLinePrefixSymbol(arg_477_1.text_)

				local var_480_5 = 29
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

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062114", "story_v_out_322062.awb") ~= 0 then
					local var_480_8 = manager.audio:GetVoiceLength("story_v_out_322062", "322062114", "story_v_out_322062.awb") / 1000

					if var_480_8 + var_480_0 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_8 + var_480_0
					end

					if var_480_3.prefab_name ~= "" and arg_477_1.actors_[var_480_3.prefab_name] ~= nil then
						local var_480_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_477_1.actors_[var_480_3.prefab_name].transform, "story_v_out_322062", "322062114", "story_v_out_322062.awb")

						arg_477_1:RecordAudio("322062114", var_480_9)
						arg_477_1:RecordAudio("322062114", var_480_9)
					else
						arg_477_1:AudioAction("play", "voice", "story_v_out_322062", "322062114", "story_v_out_322062.awb")
					end

					arg_477_1:RecordHistoryTalkVoice("story_v_out_322062", "322062114", "story_v_out_322062.awb")
				end

				arg_477_1:RecordContent(arg_477_1.text_.text)
			end

			local var_480_10 = math.max(var_480_1, arg_477_1.talkMaxDuration)

			if var_480_0 <= arg_477_1.time_ and arg_477_1.time_ < var_480_0 + var_480_10 then
				arg_477_1.typewritter.percent = (arg_477_1.time_ - var_480_0) / var_480_10

				arg_477_1.typewritter:SetDirty()
			end

			if arg_477_1.time_ >= var_480_0 + var_480_10 and arg_477_1.time_ < var_480_0 + var_480_10 + arg_480_0 then
				arg_477_1.typewritter.percent = 1

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(true)
			end
		end

		arg_477_1.nodeConfigList_ = {}

		arg_477_1:InitPlayNodeList()
	end,
	Play322062115 = function(arg_481_0, arg_481_1)
		arg_481_1.time_ = 0
		arg_481_1.frameCnt_ = 0
		arg_481_1.state_ = "playing"
		arg_481_1.curTalkId_ = 322062115
		arg_481_1.duration_ = 14.17

		local var_481_0 = {
			zh = 8.266,
			ja = 14.166
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
				arg_481_0:Play322062116(arg_481_1)
			end
		end

		function arg_481_1.onSingleLineUpdate_(arg_484_0)
			local var_484_0 = 0
			local var_484_1 = 0.925

			if var_484_0 < arg_481_1.time_ and arg_481_1.time_ <= var_484_0 + arg_484_0 then
				arg_481_1.talkMaxDuration = 0
				arg_481_1.dialogCg_.alpha = 1

				arg_481_1.dialog_:SetActive(true)
				SetActive(arg_481_1.leftNameGo_, true)

				local var_484_2 = arg_481_1:FormatText(StoryNameCfg[1030].name)

				arg_481_1.leftNameTxt_.text = var_484_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_481_1.leftNameTxt_.transform)

				arg_481_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_481_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_481_1:RecordName(arg_481_1.leftNameTxt_.text)
				SetActive(arg_481_1.iconTrs_.gameObject, true)
				arg_481_1.iconController_:SetSelectedState("hero")

				arg_481_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_481_1.callingController_:SetSelectedState("calling")

				arg_481_1.keyicon_.color = Color.New(1, 1, 1)
				arg_481_1.icon_.color = Color.New(1, 1, 1)

				local var_484_3 = arg_481_1:GetWordFromCfg(322062115)
				local var_484_4 = arg_481_1:FormatText(var_484_3.content)

				arg_481_1.text_.text = var_484_4

				LuaForUtil.ClearLinePrefixSymbol(arg_481_1.text_)

				local var_484_5 = 37
				local var_484_6 = utf8.len(var_484_4)
				local var_484_7 = var_484_5 <= 0 and var_484_1 or var_484_1 * (var_484_6 / var_484_5)

				if var_484_7 > 0 and var_484_1 < var_484_7 then
					arg_481_1.talkMaxDuration = var_484_7

					if var_484_7 + var_484_0 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_7 + var_484_0
					end
				end

				arg_481_1.text_.text = var_484_4
				arg_481_1.typewritter.percent = 0

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062115", "story_v_out_322062.awb") ~= 0 then
					local var_484_8 = manager.audio:GetVoiceLength("story_v_out_322062", "322062115", "story_v_out_322062.awb") / 1000

					if var_484_8 + var_484_0 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_8 + var_484_0
					end

					if var_484_3.prefab_name ~= "" and arg_481_1.actors_[var_484_3.prefab_name] ~= nil then
						local var_484_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_481_1.actors_[var_484_3.prefab_name].transform, "story_v_out_322062", "322062115", "story_v_out_322062.awb")

						arg_481_1:RecordAudio("322062115", var_484_9)
						arg_481_1:RecordAudio("322062115", var_484_9)
					else
						arg_481_1:AudioAction("play", "voice", "story_v_out_322062", "322062115", "story_v_out_322062.awb")
					end

					arg_481_1:RecordHistoryTalkVoice("story_v_out_322062", "322062115", "story_v_out_322062.awb")
				end

				arg_481_1:RecordContent(arg_481_1.text_.text)
			end

			local var_484_10 = math.max(var_484_1, arg_481_1.talkMaxDuration)

			if var_484_0 <= arg_481_1.time_ and arg_481_1.time_ < var_484_0 + var_484_10 then
				arg_481_1.typewritter.percent = (arg_481_1.time_ - var_484_0) / var_484_10

				arg_481_1.typewritter:SetDirty()
			end

			if arg_481_1.time_ >= var_484_0 + var_484_10 and arg_481_1.time_ < var_484_0 + var_484_10 + arg_484_0 then
				arg_481_1.typewritter.percent = 1

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(true)
			end
		end

		arg_481_1.nodeConfigList_ = {}

		arg_481_1:InitPlayNodeList()
	end,
	Play322062116 = function(arg_485_0, arg_485_1)
		arg_485_1.time_ = 0
		arg_485_1.frameCnt_ = 0
		arg_485_1.state_ = "playing"
		arg_485_1.curTalkId_ = 322062116
		arg_485_1.duration_ = 9.8

		local var_485_0 = {
			zh = 4.466,
			ja = 9.8
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
				arg_485_0:Play322062117(arg_485_1)
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

				local var_488_2 = arg_485_1:FormatText(StoryNameCfg[1030].name)

				arg_485_1.leftNameTxt_.text = var_488_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_485_1.leftNameTxt_.transform)

				arg_485_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_485_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_485_1:RecordName(arg_485_1.leftNameTxt_.text)
				SetActive(arg_485_1.iconTrs_.gameObject, true)
				arg_485_1.iconController_:SetSelectedState("hero")

				arg_485_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_485_1.callingController_:SetSelectedState("calling")

				arg_485_1.keyicon_.color = Color.New(1, 1, 1)
				arg_485_1.icon_.color = Color.New(1, 1, 1)

				local var_488_3 = arg_485_1:GetWordFromCfg(322062116)
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

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062116", "story_v_out_322062.awb") ~= 0 then
					local var_488_8 = manager.audio:GetVoiceLength("story_v_out_322062", "322062116", "story_v_out_322062.awb") / 1000

					if var_488_8 + var_488_0 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_8 + var_488_0
					end

					if var_488_3.prefab_name ~= "" and arg_485_1.actors_[var_488_3.prefab_name] ~= nil then
						local var_488_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_485_1.actors_[var_488_3.prefab_name].transform, "story_v_out_322062", "322062116", "story_v_out_322062.awb")

						arg_485_1:RecordAudio("322062116", var_488_9)
						arg_485_1:RecordAudio("322062116", var_488_9)
					else
						arg_485_1:AudioAction("play", "voice", "story_v_out_322062", "322062116", "story_v_out_322062.awb")
					end

					arg_485_1:RecordHistoryTalkVoice("story_v_out_322062", "322062116", "story_v_out_322062.awb")
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
	Play322062117 = function(arg_489_0, arg_489_1)
		arg_489_1.time_ = 0
		arg_489_1.frameCnt_ = 0
		arg_489_1.state_ = "playing"
		arg_489_1.curTalkId_ = 322062117
		arg_489_1.duration_ = 3.17

		local var_489_0 = {
			zh = 3.166,
			ja = 3.133
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
			arg_489_1.auto_ = false
		end

		function arg_489_1.playNext_(arg_491_0)
			arg_489_1.onStoryFinished_()
		end

		function arg_489_1.onSingleLineUpdate_(arg_492_0)
			local var_492_0 = 0
			local var_492_1 = 0.275

			if var_492_0 < arg_489_1.time_ and arg_489_1.time_ <= var_492_0 + arg_492_0 then
				arg_489_1.talkMaxDuration = 0
				arg_489_1.dialogCg_.alpha = 1

				arg_489_1.dialog_:SetActive(true)
				SetActive(arg_489_1.leftNameGo_, true)

				local var_492_2 = arg_489_1:FormatText(StoryNameCfg[1030].name)

				arg_489_1.leftNameTxt_.text = var_492_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_489_1.leftNameTxt_.transform)

				arg_489_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_489_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_489_1:RecordName(arg_489_1.leftNameTxt_.text)
				SetActive(arg_489_1.iconTrs_.gameObject, true)
				arg_489_1.iconController_:SetSelectedState("hero")

				arg_489_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_489_1.callingController_:SetSelectedState("calling")

				arg_489_1.keyicon_.color = Color.New(1, 1, 1)
				arg_489_1.icon_.color = Color.New(1, 1, 1)

				local var_492_3 = arg_489_1:GetWordFromCfg(322062117)
				local var_492_4 = arg_489_1:FormatText(var_492_3.content)

				arg_489_1.text_.text = var_492_4

				LuaForUtil.ClearLinePrefixSymbol(arg_489_1.text_)

				local var_492_5 = 11
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

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062117", "story_v_out_322062.awb") ~= 0 then
					local var_492_8 = manager.audio:GetVoiceLength("story_v_out_322062", "322062117", "story_v_out_322062.awb") / 1000

					if var_492_8 + var_492_0 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_8 + var_492_0
					end

					if var_492_3.prefab_name ~= "" and arg_489_1.actors_[var_492_3.prefab_name] ~= nil then
						local var_492_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_489_1.actors_[var_492_3.prefab_name].transform, "story_v_out_322062", "322062117", "story_v_out_322062.awb")

						arg_489_1:RecordAudio("322062117", var_492_9)
						arg_489_1:RecordAudio("322062117", var_492_9)
					else
						arg_489_1:AudioAction("play", "voice", "story_v_out_322062", "322062117", "story_v_out_322062.awb")
					end

					arg_489_1:RecordHistoryTalkVoice("story_v_out_322062", "322062117", "story_v_out_322062.awb")
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
	assets = {
		"TextureConfig/Background/L10j",
		"TextureConfig/Background/ST61a",
		"TextureConfig/Background/L01h",
		"TextureConfig/Background/MS2202"
	},
	voices = {
		"story_v_out_322062.awb"
	}
}
