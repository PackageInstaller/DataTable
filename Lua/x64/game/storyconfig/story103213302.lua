return {
	Play321332001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 321332001
		arg_1_1.duration_ = 8

		local var_1_0 = {
			zh = 6.8,
			ja = 8
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
				arg_1_0:Play321332002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "L11f"

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
				local var_4_5 = arg_1_1.bgs_.L11f

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
					if iter_4_0 ~= "L11f" then
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

				arg_1_1:AudioAction(var_4_32, var_4_33, "bgm_activity_4_0_story_shashvat_sewer", "bgm_activity_4_0_story_shashvat_sewer", "bgm_activity_4_0_story_shashvat_sewer.awb")

				local var_4_34 = ""
				local var_4_35 = manager.audio:GetAudioName("bgm_activity_4_0_story_shashvat_sewer", "bgm_activity_4_0_story_shashvat_sewer")

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
			local var_4_37 = 0.45

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

				local var_4_39 = arg_1_1:FormatText(StoryNameCfg[600].name)

				arg_1_1.leftNameTxt_.text = var_4_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4032")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_40 = arg_1_1:GetWordFromCfg(321332001)
				local var_4_41 = arg_1_1:FormatText(var_4_40.content)

				arg_1_1.text_.text = var_4_41

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_42 = 18
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

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332001", "story_v_out_321332.awb") ~= 0 then
					local var_4_45 = manager.audio:GetVoiceLength("story_v_out_321332", "321332001", "story_v_out_321332.awb") / 1000

					if var_4_45 + var_4_36 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_45 + var_4_36
					end

					if var_4_40.prefab_name ~= "" and arg_1_1.actors_[var_4_40.prefab_name] ~= nil then
						local var_4_46 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_40.prefab_name].transform, "story_v_out_321332", "321332001", "story_v_out_321332.awb")

						arg_1_1:RecordAudio("321332001", var_4_46)
						arg_1_1:RecordAudio("321332001", var_4_46)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_321332", "321332001", "story_v_out_321332.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_321332", "321332001", "story_v_out_321332.awb")
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
	Play321332002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 321332002
		arg_9_1.duration_ = 7

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play321332003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = manager.ui.mainCamera.transform
			local var_12_1 = 0

			if var_12_1 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 then
				local var_12_2 = arg_9_1.var_.effectzhendang2
				local var_12_3
				local var_12_4 = var_12_0

				if not var_12_2 then
					var_12_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_ripple"), var_12_4)
					var_12_2.name = "zhendang2"
					arg_9_1.var_.effectzhendang2 = var_12_2
				else
					var_12_2.transform:SetParent(var_12_4)
				end

				var_12_2.transform.localPosition = Vector3.New(-1.1, 0.69, 1.96)
				var_12_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_12_5 = manager.ui.mainCamera.transform
			local var_12_6 = 0.766666666666667

			if var_12_6 < arg_9_1.time_ and arg_9_1.time_ <= var_12_6 + arg_12_0 then
				local var_12_7 = arg_9_1.var_.effectzhendang2

				if var_12_7 then
					Object.Destroy(var_12_7)

					arg_9_1.var_.effectzhendang2 = nil
				end
			end

			local var_12_8 = manager.ui.mainCamera.transform
			local var_12_9 = 1

			if var_12_9 < arg_9_1.time_ and arg_9_1.time_ <= var_12_9 + arg_12_0 then
				local var_12_10 = arg_9_1.var_.effectzhendang3
				local var_12_11
				local var_12_12 = var_12_8

				if not var_12_10 then
					var_12_10 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_ripple"), var_12_12)
					var_12_10.name = "zhendang3"
					arg_9_1.var_.effectzhendang3 = var_12_10
				else
					var_12_10.transform:SetParent(var_12_12)
				end

				var_12_10.transform.localPosition = Vector3.New(0.82, 0.69, 1.96)
				var_12_10.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_12_13 = manager.ui.mainCamera.transform
			local var_12_14 = 1.999999999998

			if var_12_14 < arg_9_1.time_ and arg_9_1.time_ <= var_12_14 + arg_12_0 then
				local var_12_15 = arg_9_1.var_.effectzhendang3

				if var_12_15 then
					Object.Destroy(var_12_15)

					arg_9_1.var_.effectzhendang3 = nil
				end
			end

			local var_12_16 = manager.ui.mainCamera.transform
			local var_12_17 = 0

			if var_12_17 < arg_9_1.time_ and arg_9_1.time_ <= var_12_17 + arg_12_0 then
				arg_9_1.var_.shakeOldPos = var_12_16.localPosition
			end

			local var_12_18 = 0.4

			if var_12_17 <= arg_9_1.time_ and arg_9_1.time_ < var_12_17 + var_12_18 then
				local var_12_19 = (arg_9_1.time_ - var_12_17) / 0.066
				local var_12_20, var_12_21 = math.modf(var_12_19)

				var_12_16.localPosition = Vector3.New(var_12_21 * 0.13, var_12_21 * 0.13, var_12_21 * 0.13) + arg_9_1.var_.shakeOldPos
			end

			if arg_9_1.time_ >= var_12_17 + var_12_18 and arg_9_1.time_ < var_12_17 + var_12_18 + arg_12_0 then
				var_12_16.localPosition = arg_9_1.var_.shakeOldPos
			end

			local var_12_22 = manager.ui.mainCamera.transform
			local var_12_23 = 1

			if var_12_23 < arg_9_1.time_ and arg_9_1.time_ <= var_12_23 + arg_12_0 then
				arg_9_1.var_.shakeOldPos = var_12_22.localPosition
			end

			local var_12_24 = 0.766666666666667

			if var_12_23 <= arg_9_1.time_ and arg_9_1.time_ < var_12_23 + var_12_24 then
				local var_12_25 = (arg_9_1.time_ - var_12_23) / 0.066
				local var_12_26, var_12_27 = math.modf(var_12_25)

				var_12_22.localPosition = Vector3.New(var_12_27 * 0.13, var_12_27 * 0.13, var_12_27 * 0.13) + arg_9_1.var_.shakeOldPos
			end

			if arg_9_1.time_ >= var_12_23 + var_12_24 and arg_9_1.time_ < var_12_23 + var_12_24 + arg_12_0 then
				var_12_22.localPosition = arg_9_1.var_.shakeOldPos
			end

			local var_12_28 = manager.ui.mainCamera.transform
			local var_12_29 = 2

			if var_12_29 < arg_9_1.time_ and arg_9_1.time_ <= var_12_29 + arg_12_0 then
				arg_9_1.var_.shakeOldPos = var_12_28.localPosition
			end

			local var_12_30 = 0.266666666666667

			if var_12_29 <= arg_9_1.time_ and arg_9_1.time_ < var_12_29 + var_12_30 then
				local var_12_31 = (arg_9_1.time_ - var_12_29) / 0.066
				local var_12_32, var_12_33 = math.modf(var_12_31)

				var_12_28.localPosition = Vector3.New(var_12_33 * 0.13, var_12_33 * 0.13, var_12_33 * 0.13) + arg_9_1.var_.shakeOldPos
			end

			if arg_9_1.time_ >= var_12_29 + var_12_30 and arg_9_1.time_ < var_12_29 + var_12_30 + arg_12_0 then
				var_12_28.localPosition = arg_9_1.var_.shakeOldPos
			end

			local var_12_34 = 0

			if var_12_34 < arg_9_1.time_ and arg_9_1.time_ <= var_12_34 + arg_12_0 then
				arg_9_1.allBtn_.enabled = false
			end

			local var_12_35 = 2

			if arg_9_1.time_ >= var_12_34 + var_12_35 and arg_9_1.time_ < var_12_34 + var_12_35 + arg_12_0 then
				arg_9_1.allBtn_.enabled = true
			end

			local var_12_36 = 0
			local var_12_37 = 1

			if var_12_36 < arg_9_1.time_ and arg_9_1.time_ <= var_12_36 + arg_12_0 then
				local var_12_38 = "play"
				local var_12_39 = "effect"

				arg_9_1:AudioAction(var_12_38, var_12_39, "se_story_141", "se_story_141_hit", "")
			end

			if arg_9_1.frameCnt_ <= 1 then
				arg_9_1.dialog_:SetActive(false)
			end

			local var_12_40 = 1.999999999998
			local var_12_41 = 1.6

			if var_12_40 < arg_9_1.time_ and arg_9_1.time_ <= var_12_40 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0

				arg_9_1.dialog_:SetActive(true)

				arg_9_1.dialogCg_.alpha = 0

				local var_12_42 = LeanTween.value(arg_9_1.dialog_, 0, 1, 0.3)

				var_12_42:setOnUpdate(LuaHelper.FloatAction(function(arg_13_0)
					arg_9_1.dialogCg_.alpha = arg_13_0
				end))
				var_12_42:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_9_1.dialog_)
					var_12_42:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_9_1.duration_ = arg_9_1.duration_ + 0.3

				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_43 = arg_9_1:GetWordFromCfg(321332002)
				local var_12_44 = arg_9_1:FormatText(var_12_43.content)

				arg_9_1.text_.text = var_12_44

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_45 = 64
				local var_12_46 = utf8.len(var_12_44)
				local var_12_47 = var_12_45 <= 0 and var_12_41 or var_12_41 * (var_12_46 / var_12_45)

				if var_12_47 > 0 and var_12_41 < var_12_47 then
					arg_9_1.talkMaxDuration = var_12_47
					var_12_40 = var_12_40 + 0.3

					if var_12_47 + var_12_40 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_47 + var_12_40
					end
				end

				arg_9_1.text_.text = var_12_44
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_48 = var_12_40 + 0.3
			local var_12_49 = math.max(var_12_41, arg_9_1.talkMaxDuration)

			if var_12_48 <= arg_9_1.time_ and arg_9_1.time_ < var_12_48 + var_12_49 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_48) / var_12_49

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_48 + var_12_49 and arg_9_1.time_ < var_12_48 + var_12_49 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play321332003 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 321332003
		arg_15_1.duration_ = 5

		SetActive(arg_15_1.tipsGo_, false)

		function arg_15_1.onSingleLineFinish_()
			arg_15_1.onSingleLineUpdate_ = nil
			arg_15_1.onSingleLineFinish_ = nil
			arg_15_1.state_ = "waiting"
		end

		function arg_15_1.playNext_(arg_17_0)
			if arg_17_0 == 1 then
				arg_15_0:Play321332004(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			local var_18_0 = 0
			local var_18_1 = 1.3

			if var_18_0 < arg_15_1.time_ and arg_15_1.time_ <= var_18_0 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, false)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_15_1.iconTrs_.gameObject, false)
				arg_15_1.callingController_:SetSelectedState("normal")

				local var_18_2 = arg_15_1:GetWordFromCfg(321332003)
				local var_18_3 = arg_15_1:FormatText(var_18_2.content)

				arg_15_1.text_.text = var_18_3

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_4 = 52
				local var_18_5 = utf8.len(var_18_3)
				local var_18_6 = var_18_4 <= 0 and var_18_1 or var_18_1 * (var_18_5 / var_18_4)

				if var_18_6 > 0 and var_18_1 < var_18_6 then
					arg_15_1.talkMaxDuration = var_18_6

					if var_18_6 + var_18_0 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_6 + var_18_0
					end
				end

				arg_15_1.text_.text = var_18_3
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)
				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_7 = math.max(var_18_1, arg_15_1.talkMaxDuration)

			if var_18_0 <= arg_15_1.time_ and arg_15_1.time_ < var_18_0 + var_18_7 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - var_18_0) / var_18_7

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= var_18_0 + var_18_7 and arg_15_1.time_ < var_18_0 + var_18_7 + arg_18_0 then
				arg_15_1.typewritter.percent = 1

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(true)
			end
		end

		arg_15_1.nodeConfigList_ = {}

		arg_15_1:InitPlayNodeList()
	end,
	Play321332004 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 321332004
		arg_19_1.duration_ = 5

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play321332005(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			local var_22_0 = 0.233333333333333
			local var_22_1 = 1

			if var_22_0 < arg_19_1.time_ and arg_19_1.time_ <= var_22_0 + arg_22_0 then
				local var_22_2 = "play"
				local var_22_3 = "effect"

				arg_19_1:AudioAction(var_22_2, var_22_3, "se_story_140", "se_story_140_light", "")
			end

			local var_22_4 = 0
			local var_22_5 = 1.375

			if var_22_4 < arg_19_1.time_ and arg_19_1.time_ <= var_22_4 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, false)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_6 = arg_19_1:GetWordFromCfg(321332004)
				local var_22_7 = arg_19_1:FormatText(var_22_6.content)

				arg_19_1.text_.text = var_22_7

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_8 = 55
				local var_22_9 = utf8.len(var_22_7)
				local var_22_10 = var_22_8 <= 0 and var_22_5 or var_22_5 * (var_22_9 / var_22_8)

				if var_22_10 > 0 and var_22_5 < var_22_10 then
					arg_19_1.talkMaxDuration = var_22_10

					if var_22_10 + var_22_4 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_10 + var_22_4
					end
				end

				arg_19_1.text_.text = var_22_7
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)
				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_11 = math.max(var_22_5, arg_19_1.talkMaxDuration)

			if var_22_4 <= arg_19_1.time_ and arg_19_1.time_ < var_22_4 + var_22_11 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_4) / var_22_11

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_4 + var_22_11 and arg_19_1.time_ < var_22_4 + var_22_11 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {}

		arg_19_1:InitPlayNodeList()
	end,
	Play321332005 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 321332005
		arg_23_1.duration_ = 6.03

		local var_23_0 = {
			zh = 4.4,
			ja = 6.033
		}
		local var_23_1 = manager.audio:GetLocalizationFlag()

		if var_23_0[var_23_1] ~= nil then
			arg_23_1.duration_ = var_23_0[var_23_1]
		end

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play321332006(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			local var_26_0 = "404001ui_story"

			if arg_23_1.actors_[var_26_0] == nil then
				local var_26_1 = Asset.Load("Char/" .. "404001ui_story")

				if not isNil(var_26_1) then
					local var_26_2 = Object.Instantiate(Asset.Load("Char/" .. "404001ui_story"), arg_23_1.stage_.transform)

					var_26_2.name = var_26_0
					var_26_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_23_1.actors_[var_26_0] = var_26_2

					local var_26_3 = var_26_2:GetComponentInChildren(typeof(CharacterEffect))

					var_26_3.enabled = true

					local var_26_4 = GameObjectTools.GetOrAddComponent(var_26_2, typeof(DynamicBoneHelper))

					if var_26_4 then
						var_26_4:EnableDynamicBone(false)
					end

					arg_23_1:ShowWeapon(var_26_3.transform, false)

					arg_23_1.var_[var_26_0 .. "Animator"] = var_26_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_23_1.var_[var_26_0 .. "Animator"].applyRootMotion = true
					arg_23_1.var_[var_26_0 .. "LipSync"] = var_26_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_26_5 = arg_23_1.actors_["404001ui_story"].transform
			local var_26_6 = 0

			if var_26_6 < arg_23_1.time_ and arg_23_1.time_ <= var_26_6 + arg_26_0 then
				arg_23_1.var_.moveOldPos404001ui_story = var_26_5.localPosition
			end

			local var_26_7 = 0.001

			if var_26_6 <= arg_23_1.time_ and arg_23_1.time_ < var_26_6 + var_26_7 then
				local var_26_8 = (arg_23_1.time_ - var_26_6) / var_26_7
				local var_26_9 = Vector3.New(-0.8, -1.55, -5.5)

				var_26_5.localPosition = Vector3.Lerp(arg_23_1.var_.moveOldPos404001ui_story, var_26_9, var_26_8)

				local var_26_10 = manager.ui.mainCamera.transform.position - var_26_5.position

				var_26_5.forward = Vector3.New(var_26_10.x, var_26_10.y, var_26_10.z)

				local var_26_11 = var_26_5.localEulerAngles

				var_26_11.z = 0
				var_26_11.x = 0
				var_26_5.localEulerAngles = var_26_11
			end

			if arg_23_1.time_ >= var_26_6 + var_26_7 and arg_23_1.time_ < var_26_6 + var_26_7 + arg_26_0 then
				var_26_5.localPosition = Vector3.New(-0.8, -1.55, -5.5)

				local var_26_12 = manager.ui.mainCamera.transform.position - var_26_5.position

				var_26_5.forward = Vector3.New(var_26_12.x, var_26_12.y, var_26_12.z)

				local var_26_13 = var_26_5.localEulerAngles

				var_26_13.z = 0
				var_26_13.x = 0
				var_26_5.localEulerAngles = var_26_13
			end

			local var_26_14 = arg_23_1.actors_["404001ui_story"]
			local var_26_15 = 0

			if var_26_15 < arg_23_1.time_ and arg_23_1.time_ <= var_26_15 + arg_26_0 and not isNil(var_26_14) and arg_23_1.var_.characterEffect404001ui_story == nil then
				arg_23_1.var_.characterEffect404001ui_story = var_26_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_26_16 = 0.200000002980232

			if var_26_15 <= arg_23_1.time_ and arg_23_1.time_ < var_26_15 + var_26_16 and not isNil(var_26_14) then
				local var_26_17 = (arg_23_1.time_ - var_26_15) / var_26_16

				if arg_23_1.var_.characterEffect404001ui_story and not isNil(var_26_14) then
					arg_23_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_23_1.time_ >= var_26_15 + var_26_16 and arg_23_1.time_ < var_26_15 + var_26_16 + arg_26_0 and not isNil(var_26_14) and arg_23_1.var_.characterEffect404001ui_story then
				arg_23_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_26_18 = 0

			if var_26_18 < arg_23_1.time_ and arg_23_1.time_ <= var_26_18 + arg_26_0 then
				arg_23_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action5_1")
			end

			local var_26_19 = 0

			if var_26_19 < arg_23_1.time_ and arg_23_1.time_ <= var_26_19 + arg_26_0 then
				arg_23_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_26_20 = 0
			local var_26_21 = 0.375

			if var_26_20 < arg_23_1.time_ and arg_23_1.time_ <= var_26_20 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				local var_26_22 = arg_23_1:FormatText(StoryNameCfg[668].name)

				arg_23_1.leftNameTxt_.text = var_26_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_23 = arg_23_1:GetWordFromCfg(321332005)
				local var_26_24 = arg_23_1:FormatText(var_26_23.content)

				arg_23_1.text_.text = var_26_24

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_25 = 15
				local var_26_26 = utf8.len(var_26_24)
				local var_26_27 = var_26_25 <= 0 and var_26_21 or var_26_21 * (var_26_26 / var_26_25)

				if var_26_27 > 0 and var_26_21 < var_26_27 then
					arg_23_1.talkMaxDuration = var_26_27

					if var_26_27 + var_26_20 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_27 + var_26_20
					end
				end

				arg_23_1.text_.text = var_26_24
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332005", "story_v_out_321332.awb") ~= 0 then
					local var_26_28 = manager.audio:GetVoiceLength("story_v_out_321332", "321332005", "story_v_out_321332.awb") / 1000

					if var_26_28 + var_26_20 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_28 + var_26_20
					end

					if var_26_23.prefab_name ~= "" and arg_23_1.actors_[var_26_23.prefab_name] ~= nil then
						local var_26_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_23_1.actors_[var_26_23.prefab_name].transform, "story_v_out_321332", "321332005", "story_v_out_321332.awb")

						arg_23_1:RecordAudio("321332005", var_26_29)
						arg_23_1:RecordAudio("321332005", var_26_29)
					else
						arg_23_1:AudioAction("play", "voice", "story_v_out_321332", "321332005", "story_v_out_321332.awb")
					end

					arg_23_1:RecordHistoryTalkVoice("story_v_out_321332", "321332005", "story_v_out_321332.awb")
				end

				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_30 = math.max(var_26_21, arg_23_1.talkMaxDuration)

			if var_26_20 <= arg_23_1.time_ and arg_23_1.time_ < var_26_20 + var_26_30 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_20) / var_26_30

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_20 + var_26_30 and arg_23_1.time_ < var_26_20 + var_26_30 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {
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

		arg_23_1:InitPlayNodeList()
	end,
	Play321332006 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 321332006
		arg_27_1.duration_ = 4.1

		local var_27_0 = {
			zh = 4.1,
			ja = 3.366
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
				arg_27_0:Play321332007(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			local var_30_0 = "1211ui_story"

			if arg_27_1.actors_[var_30_0] == nil then
				local var_30_1 = Asset.Load("Char/" .. "1211ui_story")

				if not isNil(var_30_1) then
					local var_30_2 = Object.Instantiate(Asset.Load("Char/" .. "1211ui_story"), arg_27_1.stage_.transform)

					var_30_2.name = var_30_0
					var_30_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_27_1.actors_[var_30_0] = var_30_2

					local var_30_3 = var_30_2:GetComponentInChildren(typeof(CharacterEffect))

					var_30_3.enabled = true

					local var_30_4 = GameObjectTools.GetOrAddComponent(var_30_2, typeof(DynamicBoneHelper))

					if var_30_4 then
						var_30_4:EnableDynamicBone(false)
					end

					arg_27_1:ShowWeapon(var_30_3.transform, false)

					arg_27_1.var_[var_30_0 .. "Animator"] = var_30_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_27_1.var_[var_30_0 .. "Animator"].applyRootMotion = true
					arg_27_1.var_[var_30_0 .. "LipSync"] = var_30_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_30_5 = arg_27_1.actors_["1211ui_story"].transform
			local var_30_6 = 0

			if var_30_6 < arg_27_1.time_ and arg_27_1.time_ <= var_30_6 + arg_30_0 then
				arg_27_1.var_.moveOldPos1211ui_story = var_30_5.localPosition
			end

			local var_30_7 = 0.001

			if var_30_6 <= arg_27_1.time_ and arg_27_1.time_ < var_30_6 + var_30_7 then
				local var_30_8 = (arg_27_1.time_ - var_30_6) / var_30_7
				local var_30_9 = Vector3.New(0.7, -0.67, -6.07)

				var_30_5.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos1211ui_story, var_30_9, var_30_8)

				local var_30_10 = manager.ui.mainCamera.transform.position - var_30_5.position

				var_30_5.forward = Vector3.New(var_30_10.x, var_30_10.y, var_30_10.z)

				local var_30_11 = var_30_5.localEulerAngles

				var_30_11.z = 0
				var_30_11.x = 0
				var_30_5.localEulerAngles = var_30_11
			end

			if arg_27_1.time_ >= var_30_6 + var_30_7 and arg_27_1.time_ < var_30_6 + var_30_7 + arg_30_0 then
				var_30_5.localPosition = Vector3.New(0.7, -0.67, -6.07)

				local var_30_12 = manager.ui.mainCamera.transform.position - var_30_5.position

				var_30_5.forward = Vector3.New(var_30_12.x, var_30_12.y, var_30_12.z)

				local var_30_13 = var_30_5.localEulerAngles

				var_30_13.z = 0
				var_30_13.x = 0
				var_30_5.localEulerAngles = var_30_13
			end

			local var_30_14 = arg_27_1.actors_["1211ui_story"]
			local var_30_15 = 0

			if var_30_15 < arg_27_1.time_ and arg_27_1.time_ <= var_30_15 + arg_30_0 and not isNil(var_30_14) and arg_27_1.var_.characterEffect1211ui_story == nil then
				arg_27_1.var_.characterEffect1211ui_story = var_30_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_16 = 0.200000002980232

			if var_30_15 <= arg_27_1.time_ and arg_27_1.time_ < var_30_15 + var_30_16 and not isNil(var_30_14) then
				local var_30_17 = (arg_27_1.time_ - var_30_15) / var_30_16

				if arg_27_1.var_.characterEffect1211ui_story and not isNil(var_30_14) then
					arg_27_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_27_1.time_ >= var_30_15 + var_30_16 and arg_27_1.time_ < var_30_15 + var_30_16 + arg_30_0 and not isNil(var_30_14) and arg_27_1.var_.characterEffect1211ui_story then
				arg_27_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_30_18 = arg_27_1.actors_["404001ui_story"]
			local var_30_19 = 0

			if var_30_19 < arg_27_1.time_ and arg_27_1.time_ <= var_30_19 + arg_30_0 and not isNil(var_30_18) and arg_27_1.var_.characterEffect404001ui_story == nil then
				arg_27_1.var_.characterEffect404001ui_story = var_30_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_20 = 0.200000002980232

			if var_30_19 <= arg_27_1.time_ and arg_27_1.time_ < var_30_19 + var_30_20 and not isNil(var_30_18) then
				local var_30_21 = (arg_27_1.time_ - var_30_19) / var_30_20

				if arg_27_1.var_.characterEffect404001ui_story and not isNil(var_30_18) then
					local var_30_22 = Mathf.Lerp(0, 0.5, var_30_21)

					arg_27_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_27_1.var_.characterEffect404001ui_story.fillRatio = var_30_22
				end
			end

			if arg_27_1.time_ >= var_30_19 + var_30_20 and arg_27_1.time_ < var_30_19 + var_30_20 + arg_30_0 and not isNil(var_30_18) and arg_27_1.var_.characterEffect404001ui_story then
				local var_30_23 = 0.5

				arg_27_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_27_1.var_.characterEffect404001ui_story.fillRatio = var_30_23
			end

			local var_30_24 = 0

			if var_30_24 < arg_27_1.time_ and arg_27_1.time_ <= var_30_24 + arg_30_0 then
				arg_27_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action3_1")
			end

			local var_30_25 = 0

			if var_30_25 < arg_27_1.time_ and arg_27_1.time_ <= var_30_25 + arg_30_0 then
				arg_27_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_30_26 = 0
			local var_30_27 = 0.475

			if var_30_26 < arg_27_1.time_ and arg_27_1.time_ <= var_30_26 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				local var_30_28 = arg_27_1:FormatText(StoryNameCfg[37].name)

				arg_27_1.leftNameTxt_.text = var_30_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_29 = arg_27_1:GetWordFromCfg(321332006)
				local var_30_30 = arg_27_1:FormatText(var_30_29.content)

				arg_27_1.text_.text = var_30_30

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_31 = 19
				local var_30_32 = utf8.len(var_30_30)
				local var_30_33 = var_30_31 <= 0 and var_30_27 or var_30_27 * (var_30_32 / var_30_31)

				if var_30_33 > 0 and var_30_27 < var_30_33 then
					arg_27_1.talkMaxDuration = var_30_33

					if var_30_33 + var_30_26 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_33 + var_30_26
					end
				end

				arg_27_1.text_.text = var_30_30
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332006", "story_v_out_321332.awb") ~= 0 then
					local var_30_34 = manager.audio:GetVoiceLength("story_v_out_321332", "321332006", "story_v_out_321332.awb") / 1000

					if var_30_34 + var_30_26 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_34 + var_30_26
					end

					if var_30_29.prefab_name ~= "" and arg_27_1.actors_[var_30_29.prefab_name] ~= nil then
						local var_30_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_29.prefab_name].transform, "story_v_out_321332", "321332006", "story_v_out_321332.awb")

						arg_27_1:RecordAudio("321332006", var_30_35)
						arg_27_1:RecordAudio("321332006", var_30_35)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_out_321332", "321332006", "story_v_out_321332.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_out_321332", "321332006", "story_v_out_321332.awb")
				end

				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_36 = math.max(var_30_27, arg_27_1.talkMaxDuration)

			if var_30_26 <= arg_27_1.time_ and arg_27_1.time_ < var_30_26 + var_30_36 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_26) / var_30_36

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_26 + var_30_36 and arg_27_1.time_ < var_30_26 + var_30_36 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {
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

		arg_27_1:InitPlayNodeList()
	end,
	Play321332007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 321332007
		arg_31_1.duration_ = 7.73

		local var_31_0 = {
			zh = 5.433,
			ja = 7.733
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
				arg_31_0:Play321332008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = arg_31_1.actors_["1211ui_story"].transform
			local var_34_1 = 0

			if var_34_1 < arg_31_1.time_ and arg_31_1.time_ <= var_34_1 + arg_34_0 then
				arg_31_1.var_.moveOldPos1211ui_story = var_34_0.localPosition
			end

			local var_34_2 = 0.001

			if var_34_1 <= arg_31_1.time_ and arg_31_1.time_ < var_34_1 + var_34_2 then
				local var_34_3 = (arg_31_1.time_ - var_34_1) / var_34_2
				local var_34_4 = Vector3.New(0, 100, 0)

				var_34_0.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos1211ui_story, var_34_4, var_34_3)

				local var_34_5 = manager.ui.mainCamera.transform.position - var_34_0.position

				var_34_0.forward = Vector3.New(var_34_5.x, var_34_5.y, var_34_5.z)

				local var_34_6 = var_34_0.localEulerAngles

				var_34_6.z = 0
				var_34_6.x = 0
				var_34_0.localEulerAngles = var_34_6
			end

			if arg_31_1.time_ >= var_34_1 + var_34_2 and arg_31_1.time_ < var_34_1 + var_34_2 + arg_34_0 then
				var_34_0.localPosition = Vector3.New(0, 100, 0)

				local var_34_7 = manager.ui.mainCamera.transform.position - var_34_0.position

				var_34_0.forward = Vector3.New(var_34_7.x, var_34_7.y, var_34_7.z)

				local var_34_8 = var_34_0.localEulerAngles

				var_34_8.z = 0
				var_34_8.x = 0
				var_34_0.localEulerAngles = var_34_8
			end

			local var_34_9 = arg_31_1.actors_["404001ui_story"].transform
			local var_34_10 = 0

			if var_34_10 < arg_31_1.time_ and arg_31_1.time_ <= var_34_10 + arg_34_0 then
				arg_31_1.var_.moveOldPos404001ui_story = var_34_9.localPosition
			end

			local var_34_11 = 0.001

			if var_34_10 <= arg_31_1.time_ and arg_31_1.time_ < var_34_10 + var_34_11 then
				local var_34_12 = (arg_31_1.time_ - var_34_10) / var_34_11
				local var_34_13 = Vector3.New(0, 100, 0)

				var_34_9.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos404001ui_story, var_34_13, var_34_12)

				local var_34_14 = manager.ui.mainCamera.transform.position - var_34_9.position

				var_34_9.forward = Vector3.New(var_34_14.x, var_34_14.y, var_34_14.z)

				local var_34_15 = var_34_9.localEulerAngles

				var_34_15.z = 0
				var_34_15.x = 0
				var_34_9.localEulerAngles = var_34_15
			end

			if arg_31_1.time_ >= var_34_10 + var_34_11 and arg_31_1.time_ < var_34_10 + var_34_11 + arg_34_0 then
				var_34_9.localPosition = Vector3.New(0, 100, 0)

				local var_34_16 = manager.ui.mainCamera.transform.position - var_34_9.position

				var_34_9.forward = Vector3.New(var_34_16.x, var_34_16.y, var_34_16.z)

				local var_34_17 = var_34_9.localEulerAngles

				var_34_17.z = 0
				var_34_17.x = 0
				var_34_9.localEulerAngles = var_34_17
			end

			local var_34_18 = arg_31_1.actors_["1211ui_story"]
			local var_34_19 = 0

			if var_34_19 < arg_31_1.time_ and arg_31_1.time_ <= var_34_19 + arg_34_0 and not isNil(var_34_18) and arg_31_1.var_.characterEffect1211ui_story == nil then
				arg_31_1.var_.characterEffect1211ui_story = var_34_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_20 = 0.200000002980232

			if var_34_19 <= arg_31_1.time_ and arg_31_1.time_ < var_34_19 + var_34_20 and not isNil(var_34_18) then
				local var_34_21 = (arg_31_1.time_ - var_34_19) / var_34_20

				if arg_31_1.var_.characterEffect1211ui_story and not isNil(var_34_18) then
					local var_34_22 = Mathf.Lerp(0, 0.5, var_34_21)

					arg_31_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_31_1.var_.characterEffect1211ui_story.fillRatio = var_34_22
				end
			end

			if arg_31_1.time_ >= var_34_19 + var_34_20 and arg_31_1.time_ < var_34_19 + var_34_20 + arg_34_0 and not isNil(var_34_18) and arg_31_1.var_.characterEffect1211ui_story then
				local var_34_23 = 0.5

				arg_31_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_31_1.var_.characterEffect1211ui_story.fillRatio = var_34_23
			end

			local var_34_24 = 0
			local var_34_25 = 0.4

			if var_34_24 < arg_31_1.time_ and arg_31_1.time_ <= var_34_24 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				local var_34_26 = arg_31_1:FormatText(StoryNameCfg[600].name)

				arg_31_1.leftNameTxt_.text = var_34_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, true)
				arg_31_1.iconController_:SetSelectedState("hero")

				arg_31_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4032")

				arg_31_1.callingController_:SetSelectedState("normal")

				arg_31_1.keyicon_.color = Color.New(1, 1, 1)
				arg_31_1.icon_.color = Color.New(1, 1, 1)

				local var_34_27 = arg_31_1:GetWordFromCfg(321332007)
				local var_34_28 = arg_31_1:FormatText(var_34_27.content)

				arg_31_1.text_.text = var_34_28

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_29 = 16
				local var_34_30 = utf8.len(var_34_28)
				local var_34_31 = var_34_29 <= 0 and var_34_25 or var_34_25 * (var_34_30 / var_34_29)

				if var_34_31 > 0 and var_34_25 < var_34_31 then
					arg_31_1.talkMaxDuration = var_34_31

					if var_34_31 + var_34_24 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_31 + var_34_24
					end
				end

				arg_31_1.text_.text = var_34_28
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332007", "story_v_out_321332.awb") ~= 0 then
					local var_34_32 = manager.audio:GetVoiceLength("story_v_out_321332", "321332007", "story_v_out_321332.awb") / 1000

					if var_34_32 + var_34_24 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_32 + var_34_24
					end

					if var_34_27.prefab_name ~= "" and arg_31_1.actors_[var_34_27.prefab_name] ~= nil then
						local var_34_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_27.prefab_name].transform, "story_v_out_321332", "321332007", "story_v_out_321332.awb")

						arg_31_1:RecordAudio("321332007", var_34_33)
						arg_31_1:RecordAudio("321332007", var_34_33)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_321332", "321332007", "story_v_out_321332.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_321332", "321332007", "story_v_out_321332.awb")
				end

				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_34 = math.max(var_34_25, arg_31_1.talkMaxDuration)

			if var_34_24 <= arg_31_1.time_ and arg_31_1.time_ < var_34_24 + var_34_34 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_24) / var_34_34

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_24 + var_34_34 and arg_31_1.time_ < var_34_24 + var_34_34 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {
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

		arg_31_1:InitPlayNodeList()
	end,
	Play321332008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 321332008
		arg_35_1.duration_ = 4.47

		local var_35_0 = {
			zh = 3.4,
			ja = 4.466
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
				arg_35_0:Play321332009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = "1061ui_story"

			if arg_35_1.actors_[var_38_0] == nil then
				local var_38_1 = Asset.Load("Char/" .. "1061ui_story")

				if not isNil(var_38_1) then
					local var_38_2 = Object.Instantiate(Asset.Load("Char/" .. "1061ui_story"), arg_35_1.stage_.transform)

					var_38_2.name = var_38_0
					var_38_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_35_1.actors_[var_38_0] = var_38_2

					local var_38_3 = var_38_2:GetComponentInChildren(typeof(CharacterEffect))

					var_38_3.enabled = true

					local var_38_4 = GameObjectTools.GetOrAddComponent(var_38_2, typeof(DynamicBoneHelper))

					if var_38_4 then
						var_38_4:EnableDynamicBone(false)
					end

					arg_35_1:ShowWeapon(var_38_3.transform, false)

					arg_35_1.var_[var_38_0 .. "Animator"] = var_38_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_35_1.var_[var_38_0 .. "Animator"].applyRootMotion = true
					arg_35_1.var_[var_38_0 .. "LipSync"] = var_38_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_38_5 = arg_35_1.actors_["1061ui_story"].transform
			local var_38_6 = 0

			if var_38_6 < arg_35_1.time_ and arg_35_1.time_ <= var_38_6 + arg_38_0 then
				arg_35_1.var_.moveOldPos1061ui_story = var_38_5.localPosition
			end

			local var_38_7 = 0.001

			if var_38_6 <= arg_35_1.time_ and arg_35_1.time_ < var_38_6 + var_38_7 then
				local var_38_8 = (arg_35_1.time_ - var_38_6) / var_38_7
				local var_38_9 = Vector3.New(0, -1.18, -6.15)

				var_38_5.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos1061ui_story, var_38_9, var_38_8)

				local var_38_10 = manager.ui.mainCamera.transform.position - var_38_5.position

				var_38_5.forward = Vector3.New(var_38_10.x, var_38_10.y, var_38_10.z)

				local var_38_11 = var_38_5.localEulerAngles

				var_38_11.z = 0
				var_38_11.x = 0
				var_38_5.localEulerAngles = var_38_11
			end

			if arg_35_1.time_ >= var_38_6 + var_38_7 and arg_35_1.time_ < var_38_6 + var_38_7 + arg_38_0 then
				var_38_5.localPosition = Vector3.New(0, -1.18, -6.15)

				local var_38_12 = manager.ui.mainCamera.transform.position - var_38_5.position

				var_38_5.forward = Vector3.New(var_38_12.x, var_38_12.y, var_38_12.z)

				local var_38_13 = var_38_5.localEulerAngles

				var_38_13.z = 0
				var_38_13.x = 0
				var_38_5.localEulerAngles = var_38_13
			end

			local var_38_14 = arg_35_1.actors_["1061ui_story"]
			local var_38_15 = 0

			if var_38_15 < arg_35_1.time_ and arg_35_1.time_ <= var_38_15 + arg_38_0 and not isNil(var_38_14) and arg_35_1.var_.characterEffect1061ui_story == nil then
				arg_35_1.var_.characterEffect1061ui_story = var_38_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_16 = 0.200000002980232

			if var_38_15 <= arg_35_1.time_ and arg_35_1.time_ < var_38_15 + var_38_16 and not isNil(var_38_14) then
				local var_38_17 = (arg_35_1.time_ - var_38_15) / var_38_16

				if arg_35_1.var_.characterEffect1061ui_story and not isNil(var_38_14) then
					arg_35_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_35_1.time_ >= var_38_15 + var_38_16 and arg_35_1.time_ < var_38_15 + var_38_16 + arg_38_0 and not isNil(var_38_14) and arg_35_1.var_.characterEffect1061ui_story then
				arg_35_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_38_18 = 0

			if var_38_18 < arg_35_1.time_ and arg_35_1.time_ <= var_38_18 + arg_38_0 then
				arg_35_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action2_1")
			end

			local var_38_19 = 0

			if var_38_19 < arg_35_1.time_ and arg_35_1.time_ <= var_38_19 + arg_38_0 then
				arg_35_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_38_20 = 0
			local var_38_21 = 0.25

			if var_38_20 < arg_35_1.time_ and arg_35_1.time_ <= var_38_20 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				local var_38_22 = arg_35_1:FormatText(StoryNameCfg[612].name)

				arg_35_1.leftNameTxt_.text = var_38_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_23 = arg_35_1:GetWordFromCfg(321332008)
				local var_38_24 = arg_35_1:FormatText(var_38_23.content)

				arg_35_1.text_.text = var_38_24

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_25 = 10
				local var_38_26 = utf8.len(var_38_24)
				local var_38_27 = var_38_25 <= 0 and var_38_21 or var_38_21 * (var_38_26 / var_38_25)

				if var_38_27 > 0 and var_38_21 < var_38_27 then
					arg_35_1.talkMaxDuration = var_38_27

					if var_38_27 + var_38_20 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_27 + var_38_20
					end
				end

				arg_35_1.text_.text = var_38_24
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332008", "story_v_out_321332.awb") ~= 0 then
					local var_38_28 = manager.audio:GetVoiceLength("story_v_out_321332", "321332008", "story_v_out_321332.awb") / 1000

					if var_38_28 + var_38_20 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_28 + var_38_20
					end

					if var_38_23.prefab_name ~= "" and arg_35_1.actors_[var_38_23.prefab_name] ~= nil then
						local var_38_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_23.prefab_name].transform, "story_v_out_321332", "321332008", "story_v_out_321332.awb")

						arg_35_1:RecordAudio("321332008", var_38_29)
						arg_35_1:RecordAudio("321332008", var_38_29)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_out_321332", "321332008", "story_v_out_321332.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_out_321332", "321332008", "story_v_out_321332.awb")
				end

				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_30 = math.max(var_38_21, arg_35_1.talkMaxDuration)

			if var_38_20 <= arg_35_1.time_ and arg_35_1.time_ < var_38_20 + var_38_30 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_20) / var_38_30

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_20 + var_38_30 and arg_35_1.time_ < var_38_20 + var_38_30 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_35_1:InitPlayNodeList()
	end,
	Play321332009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 321332009
		arg_39_1.duration_ = 5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play321332010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = arg_39_1.actors_["1061ui_story"].transform
			local var_42_1 = 0

			if var_42_1 < arg_39_1.time_ and arg_39_1.time_ <= var_42_1 + arg_42_0 then
				arg_39_1.var_.moveOldPos1061ui_story = var_42_0.localPosition
			end

			local var_42_2 = 0.001

			if var_42_1 <= arg_39_1.time_ and arg_39_1.time_ < var_42_1 + var_42_2 then
				local var_42_3 = (arg_39_1.time_ - var_42_1) / var_42_2
				local var_42_4 = Vector3.New(0, 100, 0)

				var_42_0.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPos1061ui_story, var_42_4, var_42_3)

				local var_42_5 = manager.ui.mainCamera.transform.position - var_42_0.position

				var_42_0.forward = Vector3.New(var_42_5.x, var_42_5.y, var_42_5.z)

				local var_42_6 = var_42_0.localEulerAngles

				var_42_6.z = 0
				var_42_6.x = 0
				var_42_0.localEulerAngles = var_42_6
			end

			if arg_39_1.time_ >= var_42_1 + var_42_2 and arg_39_1.time_ < var_42_1 + var_42_2 + arg_42_0 then
				var_42_0.localPosition = Vector3.New(0, 100, 0)

				local var_42_7 = manager.ui.mainCamera.transform.position - var_42_0.position

				var_42_0.forward = Vector3.New(var_42_7.x, var_42_7.y, var_42_7.z)

				local var_42_8 = var_42_0.localEulerAngles

				var_42_8.z = 0
				var_42_8.x = 0
				var_42_0.localEulerAngles = var_42_8
			end

			local var_42_9 = arg_39_1.actors_["1061ui_story"]
			local var_42_10 = 0

			if var_42_10 < arg_39_1.time_ and arg_39_1.time_ <= var_42_10 + arg_42_0 and not isNil(var_42_9) and arg_39_1.var_.characterEffect1061ui_story == nil then
				arg_39_1.var_.characterEffect1061ui_story = var_42_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_11 = 0.200000002980232

			if var_42_10 <= arg_39_1.time_ and arg_39_1.time_ < var_42_10 + var_42_11 and not isNil(var_42_9) then
				local var_42_12 = (arg_39_1.time_ - var_42_10) / var_42_11

				if arg_39_1.var_.characterEffect1061ui_story and not isNil(var_42_9) then
					local var_42_13 = Mathf.Lerp(0, 0.5, var_42_12)

					arg_39_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_39_1.var_.characterEffect1061ui_story.fillRatio = var_42_13
				end
			end

			if arg_39_1.time_ >= var_42_10 + var_42_11 and arg_39_1.time_ < var_42_10 + var_42_11 + arg_42_0 and not isNil(var_42_9) and arg_39_1.var_.characterEffect1061ui_story then
				local var_42_14 = 0.5

				arg_39_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_39_1.var_.characterEffect1061ui_story.fillRatio = var_42_14
			end

			local var_42_15 = 0
			local var_42_16 = 1.225

			if var_42_15 < arg_39_1.time_ and arg_39_1.time_ <= var_42_15 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, false)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_17 = arg_39_1:GetWordFromCfg(321332009)
				local var_42_18 = arg_39_1:FormatText(var_42_17.content)

				arg_39_1.text_.text = var_42_18

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_19 = 49
				local var_42_20 = utf8.len(var_42_18)
				local var_42_21 = var_42_19 <= 0 and var_42_16 or var_42_16 * (var_42_20 / var_42_19)

				if var_42_21 > 0 and var_42_16 < var_42_21 then
					arg_39_1.talkMaxDuration = var_42_21

					if var_42_21 + var_42_15 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_21 + var_42_15
					end
				end

				arg_39_1.text_.text = var_42_18
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)
				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_22 = math.max(var_42_16, arg_39_1.talkMaxDuration)

			if var_42_15 <= arg_39_1.time_ and arg_39_1.time_ < var_42_15 + var_42_22 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_15) / var_42_22

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_15 + var_42_22 and arg_39_1.time_ < var_42_15 + var_42_22 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
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
	Play321332010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 321332010
		arg_43_1.duration_ = 5

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play321332011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = 0.1
			local var_46_1 = 1

			if var_46_0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_0 + arg_46_0 then
				local var_46_2 = "play"
				local var_46_3 = "effect"

				arg_43_1:AudioAction(var_46_2, var_46_3, "se_story_140", "se_story_140_activate", "")
			end

			local var_46_4 = 0
			local var_46_5 = 1.1

			if var_46_4 < arg_43_1.time_ and arg_43_1.time_ <= var_46_4 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, false)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_6 = arg_43_1:GetWordFromCfg(321332010)
				local var_46_7 = arg_43_1:FormatText(var_46_6.content)

				arg_43_1.text_.text = var_46_7

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_8 = 44
				local var_46_9 = utf8.len(var_46_7)
				local var_46_10 = var_46_8 <= 0 and var_46_5 or var_46_5 * (var_46_9 / var_46_8)

				if var_46_10 > 0 and var_46_5 < var_46_10 then
					arg_43_1.talkMaxDuration = var_46_10

					if var_46_10 + var_46_4 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_10 + var_46_4
					end
				end

				arg_43_1.text_.text = var_46_7
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)
				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_11 = math.max(var_46_5, arg_43_1.talkMaxDuration)

			if var_46_4 <= arg_43_1.time_ and arg_43_1.time_ < var_46_4 + var_46_11 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_4) / var_46_11

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_4 + var_46_11 and arg_43_1.time_ < var_46_4 + var_46_11 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play321332011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 321332011
		arg_47_1.duration_ = 5

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play321332012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = 0.1
			local var_50_1 = 1

			if var_50_0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_0 + arg_50_0 then
				local var_50_2 = "play"
				local var_50_3 = "effect"

				arg_47_1:AudioAction(var_50_2, var_50_3, "se_story_140", "se_story_140_xuanji", "")
			end

			local var_50_4 = 0
			local var_50_5 = 1.225

			if var_50_4 < arg_47_1.time_ and arg_47_1.time_ <= var_50_4 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, false)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_6 = arg_47_1:GetWordFromCfg(321332011)
				local var_50_7 = arg_47_1:FormatText(var_50_6.content)

				arg_47_1.text_.text = var_50_7

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_8 = 49
				local var_50_9 = utf8.len(var_50_7)
				local var_50_10 = var_50_8 <= 0 and var_50_5 or var_50_5 * (var_50_9 / var_50_8)

				if var_50_10 > 0 and var_50_5 < var_50_10 then
					arg_47_1.talkMaxDuration = var_50_10

					if var_50_10 + var_50_4 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_10 + var_50_4
					end
				end

				arg_47_1.text_.text = var_50_7
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)
				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_11 = math.max(var_50_5, arg_47_1.talkMaxDuration)

			if var_50_4 <= arg_47_1.time_ and arg_47_1.time_ < var_50_4 + var_50_11 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_4) / var_50_11

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_4 + var_50_11 and arg_47_1.time_ < var_50_4 + var_50_11 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play321332012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 321332012
		arg_51_1.duration_ = 5

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play321332013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = 0
			local var_54_1 = 1.2

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

				local var_54_2 = arg_51_1:GetWordFromCfg(321332012)
				local var_54_3 = arg_51_1:FormatText(var_54_2.content)

				arg_51_1.text_.text = var_54_3

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_4 = 48
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
	Play321332013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 321332013
		arg_55_1.duration_ = 9.6

		local var_55_0 = {
			zh = 5.9,
			ja = 9.6
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
				arg_55_0:Play321332014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = 0
			local var_58_1 = 0.625

			if var_58_0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_0 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				local var_58_2 = arg_55_1:FormatText(StoryNameCfg[600].name)

				arg_55_1.leftNameTxt_.text = var_58_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, true)
				arg_55_1.iconController_:SetSelectedState("hero")

				arg_55_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4032")

				arg_55_1.callingController_:SetSelectedState("normal")

				arg_55_1.keyicon_.color = Color.New(1, 1, 1)
				arg_55_1.icon_.color = Color.New(1, 1, 1)

				local var_58_3 = arg_55_1:GetWordFromCfg(321332013)
				local var_58_4 = arg_55_1:FormatText(var_58_3.content)

				arg_55_1.text_.text = var_58_4

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_5 = 25
				local var_58_6 = utf8.len(var_58_4)
				local var_58_7 = var_58_5 <= 0 and var_58_1 or var_58_1 * (var_58_6 / var_58_5)

				if var_58_7 > 0 and var_58_1 < var_58_7 then
					arg_55_1.talkMaxDuration = var_58_7

					if var_58_7 + var_58_0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_7 + var_58_0
					end
				end

				arg_55_1.text_.text = var_58_4
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332013", "story_v_out_321332.awb") ~= 0 then
					local var_58_8 = manager.audio:GetVoiceLength("story_v_out_321332", "321332013", "story_v_out_321332.awb") / 1000

					if var_58_8 + var_58_0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_8 + var_58_0
					end

					if var_58_3.prefab_name ~= "" and arg_55_1.actors_[var_58_3.prefab_name] ~= nil then
						local var_58_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_3.prefab_name].transform, "story_v_out_321332", "321332013", "story_v_out_321332.awb")

						arg_55_1:RecordAudio("321332013", var_58_9)
						arg_55_1:RecordAudio("321332013", var_58_9)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_321332", "321332013", "story_v_out_321332.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_321332", "321332013", "story_v_out_321332.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_10 = math.max(var_58_1, arg_55_1.talkMaxDuration)

			if var_58_0 <= arg_55_1.time_ and arg_55_1.time_ < var_58_0 + var_58_10 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_0) / var_58_10

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_0 + var_58_10 and arg_55_1.time_ < var_58_0 + var_58_10 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play321332014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 321332014
		arg_59_1.duration_ = 5

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play321332015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = 0
			local var_62_1 = 1.2

			if var_62_0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_0 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, false)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_2 = arg_59_1:GetWordFromCfg(321332014)
				local var_62_3 = arg_59_1:FormatText(var_62_2.content)

				arg_59_1.text_.text = var_62_3

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_4 = 48
				local var_62_5 = utf8.len(var_62_3)
				local var_62_6 = var_62_4 <= 0 and var_62_1 or var_62_1 * (var_62_5 / var_62_4)

				if var_62_6 > 0 and var_62_1 < var_62_6 then
					arg_59_1.talkMaxDuration = var_62_6

					if var_62_6 + var_62_0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_6 + var_62_0
					end
				end

				arg_59_1.text_.text = var_62_3
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)
				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_7 = math.max(var_62_1, arg_59_1.talkMaxDuration)

			if var_62_0 <= arg_59_1.time_ and arg_59_1.time_ < var_62_0 + var_62_7 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_0) / var_62_7

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_0 + var_62_7 and arg_59_1.time_ < var_62_0 + var_62_7 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play321332015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 321332015
		arg_63_1.duration_ = 6.8

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play321332016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = manager.ui.mainCamera.transform
			local var_66_1 = 0

			if var_66_1 < arg_63_1.time_ and arg_63_1.time_ <= var_66_1 + arg_66_0 then
				local var_66_2 = arg_63_1.var_.effectbiantui1
				local var_66_3
				local var_66_4 = var_66_0

				if not var_66_2 then
					var_66_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Lightning_in"), var_66_4)
					var_66_2.name = "biantui1"
					arg_63_1.var_.effectbiantui1 = var_66_2
				else
					var_66_2.transform:SetParent(var_66_4)
				end

				var_66_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_66_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_66_5 = manager.ui.mainCamera.transform
			local var_66_6 = 2

			if var_66_6 < arg_63_1.time_ and arg_63_1.time_ <= var_66_6 + arg_66_0 then
				local var_66_7 = arg_63_1.var_.effectbiantui1

				if var_66_7 then
					Object.Destroy(var_66_7)

					arg_63_1.var_.effectbiantui1 = nil
				end
			end

			local var_66_8 = manager.ui.mainCamera.transform
			local var_66_9 = 0.4

			if var_66_9 < arg_63_1.time_ and arg_63_1.time_ <= var_66_9 + arg_66_0 then
				arg_63_1.var_.shakeOldPos = var_66_8.localPosition
			end

			local var_66_10 = 1

			if var_66_9 <= arg_63_1.time_ and arg_63_1.time_ < var_66_9 + var_66_10 then
				local var_66_11 = (arg_63_1.time_ - var_66_9) / 0.066
				local var_66_12, var_66_13 = math.modf(var_66_11)

				var_66_8.localPosition = Vector3.New(var_66_13 * 0.13, var_66_13 * 0.13, var_66_13 * 0.13) + arg_63_1.var_.shakeOldPos
			end

			if arg_63_1.time_ >= var_66_9 + var_66_10 and arg_63_1.time_ < var_66_9 + var_66_10 + arg_66_0 then
				var_66_8.localPosition = arg_63_1.var_.shakeOldPos
			end

			local var_66_14 = 0

			if var_66_14 < arg_63_1.time_ and arg_63_1.time_ <= var_66_14 + arg_66_0 then
				arg_63_1.allBtn_.enabled = false
			end

			local var_66_15 = 1.8

			if arg_63_1.time_ >= var_66_14 + var_66_15 and arg_63_1.time_ < var_66_14 + var_66_15 + arg_66_0 then
				arg_63_1.allBtn_.enabled = true
			end

			local var_66_16 = 0
			local var_66_17 = 1

			if var_66_16 < arg_63_1.time_ and arg_63_1.time_ <= var_66_16 + arg_66_0 then
				local var_66_18 = "play"
				local var_66_19 = "effect"

				arg_63_1:AudioAction(var_66_18, var_66_19, "se_story_141", "se_story_141_fight", "")
			end

			if arg_63_1.frameCnt_ <= 1 then
				arg_63_1.dialog_:SetActive(false)
			end

			local var_66_20 = 1.8
			local var_66_21 = 1.425

			if var_66_20 < arg_63_1.time_ and arg_63_1.time_ <= var_66_20 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0

				arg_63_1.dialog_:SetActive(true)

				arg_63_1.dialogCg_.alpha = 0

				local var_66_22 = LeanTween.value(arg_63_1.dialog_, 0, 1, 0.3)

				var_66_22:setOnUpdate(LuaHelper.FloatAction(function(arg_67_0)
					arg_63_1.dialogCg_.alpha = arg_67_0
				end))
				var_66_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_63_1.dialog_)
					var_66_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_63_1.duration_ = arg_63_1.duration_ + 0.3

				SetActive(arg_63_1.leftNameGo_, false)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_23 = arg_63_1:GetWordFromCfg(321332015)
				local var_66_24 = arg_63_1:FormatText(var_66_23.content)

				arg_63_1.text_.text = var_66_24

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_25 = 57
				local var_66_26 = utf8.len(var_66_24)
				local var_66_27 = var_66_25 <= 0 and var_66_21 or var_66_21 * (var_66_26 / var_66_25)

				if var_66_27 > 0 and var_66_21 < var_66_27 then
					arg_63_1.talkMaxDuration = var_66_27
					var_66_20 = var_66_20 + 0.3

					if var_66_27 + var_66_20 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_27 + var_66_20
					end
				end

				arg_63_1.text_.text = var_66_24
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)
				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_28 = var_66_20 + 0.3
			local var_66_29 = math.max(var_66_21, arg_63_1.talkMaxDuration)

			if var_66_28 <= arg_63_1.time_ and arg_63_1.time_ < var_66_28 + var_66_29 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_28) / var_66_29

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_28 + var_66_29 and arg_63_1.time_ < var_66_28 + var_66_29 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play321332016 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 321332016
		arg_69_1.duration_ = 3.9

		local var_69_0 = {
			zh = 3.9,
			ja = 3.333
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
				arg_69_0:Play321332017(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = "1156ui_story"

			if arg_69_1.actors_[var_72_0] == nil then
				local var_72_1 = Asset.Load("Char/" .. "1156ui_story")

				if not isNil(var_72_1) then
					local var_72_2 = Object.Instantiate(Asset.Load("Char/" .. "1156ui_story"), arg_69_1.stage_.transform)

					var_72_2.name = var_72_0
					var_72_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_69_1.actors_[var_72_0] = var_72_2

					local var_72_3 = var_72_2:GetComponentInChildren(typeof(CharacterEffect))

					var_72_3.enabled = true

					local var_72_4 = GameObjectTools.GetOrAddComponent(var_72_2, typeof(DynamicBoneHelper))

					if var_72_4 then
						var_72_4:EnableDynamicBone(false)
					end

					arg_69_1:ShowWeapon(var_72_3.transform, false)

					arg_69_1.var_[var_72_0 .. "Animator"] = var_72_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_69_1.var_[var_72_0 .. "Animator"].applyRootMotion = true
					arg_69_1.var_[var_72_0 .. "LipSync"] = var_72_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_72_5 = arg_69_1.actors_["1156ui_story"].transform
			local var_72_6 = 0

			if var_72_6 < arg_69_1.time_ and arg_69_1.time_ <= var_72_6 + arg_72_0 then
				arg_69_1.var_.moveOldPos1156ui_story = var_72_5.localPosition
			end

			local var_72_7 = 0.001

			if var_72_6 <= arg_69_1.time_ and arg_69_1.time_ < var_72_6 + var_72_7 then
				local var_72_8 = (arg_69_1.time_ - var_72_6) / var_72_7
				local var_72_9 = Vector3.New(0, -1.1, -6.18)

				var_72_5.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1156ui_story, var_72_9, var_72_8)

				local var_72_10 = manager.ui.mainCamera.transform.position - var_72_5.position

				var_72_5.forward = Vector3.New(var_72_10.x, var_72_10.y, var_72_10.z)

				local var_72_11 = var_72_5.localEulerAngles

				var_72_11.z = 0
				var_72_11.x = 0
				var_72_5.localEulerAngles = var_72_11
			end

			if arg_69_1.time_ >= var_72_6 + var_72_7 and arg_69_1.time_ < var_72_6 + var_72_7 + arg_72_0 then
				var_72_5.localPosition = Vector3.New(0, -1.1, -6.18)

				local var_72_12 = manager.ui.mainCamera.transform.position - var_72_5.position

				var_72_5.forward = Vector3.New(var_72_12.x, var_72_12.y, var_72_12.z)

				local var_72_13 = var_72_5.localEulerAngles

				var_72_13.z = 0
				var_72_13.x = 0
				var_72_5.localEulerAngles = var_72_13
			end

			local var_72_14 = arg_69_1.actors_["1156ui_story"]
			local var_72_15 = 0

			if var_72_15 < arg_69_1.time_ and arg_69_1.time_ <= var_72_15 + arg_72_0 and not isNil(var_72_14) and arg_69_1.var_.characterEffect1156ui_story == nil then
				arg_69_1.var_.characterEffect1156ui_story = var_72_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_16 = 0.200000002980232

			if var_72_15 <= arg_69_1.time_ and arg_69_1.time_ < var_72_15 + var_72_16 and not isNil(var_72_14) then
				local var_72_17 = (arg_69_1.time_ - var_72_15) / var_72_16

				if arg_69_1.var_.characterEffect1156ui_story and not isNil(var_72_14) then
					arg_69_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= var_72_15 + var_72_16 and arg_69_1.time_ < var_72_15 + var_72_16 + arg_72_0 and not isNil(var_72_14) and arg_69_1.var_.characterEffect1156ui_story then
				arg_69_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			local var_72_18 = 0

			if var_72_18 < arg_69_1.time_ and arg_69_1.time_ <= var_72_18 + arg_72_0 then
				arg_69_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action11_1")
			end

			local var_72_19 = 0

			if var_72_19 < arg_69_1.time_ and arg_69_1.time_ <= var_72_19 + arg_72_0 then
				arg_69_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiB", "EmotionTimelineAnimator")
			end

			local var_72_20 = 0
			local var_72_21 = 0.425

			if var_72_20 < arg_69_1.time_ and arg_69_1.time_ <= var_72_20 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_22 = arg_69_1:FormatText(StoryNameCfg[605].name)

				arg_69_1.leftNameTxt_.text = var_72_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_23 = arg_69_1:GetWordFromCfg(321332016)
				local var_72_24 = arg_69_1:FormatText(var_72_23.content)

				arg_69_1.text_.text = var_72_24

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_25 = 17
				local var_72_26 = utf8.len(var_72_24)
				local var_72_27 = var_72_25 <= 0 and var_72_21 or var_72_21 * (var_72_26 / var_72_25)

				if var_72_27 > 0 and var_72_21 < var_72_27 then
					arg_69_1.talkMaxDuration = var_72_27

					if var_72_27 + var_72_20 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_27 + var_72_20
					end
				end

				arg_69_1.text_.text = var_72_24
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332016", "story_v_out_321332.awb") ~= 0 then
					local var_72_28 = manager.audio:GetVoiceLength("story_v_out_321332", "321332016", "story_v_out_321332.awb") / 1000

					if var_72_28 + var_72_20 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_28 + var_72_20
					end

					if var_72_23.prefab_name ~= "" and arg_69_1.actors_[var_72_23.prefab_name] ~= nil then
						local var_72_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_23.prefab_name].transform, "story_v_out_321332", "321332016", "story_v_out_321332.awb")

						arg_69_1:RecordAudio("321332016", var_72_29)
						arg_69_1:RecordAudio("321332016", var_72_29)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_321332", "321332016", "story_v_out_321332.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_321332", "321332016", "story_v_out_321332.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_30 = math.max(var_72_21, arg_69_1.talkMaxDuration)

			if var_72_20 <= arg_69_1.time_ and arg_69_1.time_ < var_72_20 + var_72_30 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_20) / var_72_30

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_20 + var_72_30 and arg_69_1.time_ < var_72_20 + var_72_30 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
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

		arg_69_1:InitPlayNodeList()
	end,
	Play321332017 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 321332017
		arg_73_1.duration_ = 2

		local var_73_0 = {
			zh = 2,
			ja = 1.7
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
				arg_73_0:Play321332018(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["1156ui_story"].transform
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 then
				arg_73_1.var_.moveOldPos1156ui_story = var_76_0.localPosition
			end

			local var_76_2 = 0.001

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_2 then
				local var_76_3 = (arg_73_1.time_ - var_76_1) / var_76_2
				local var_76_4 = Vector3.New(0, 100, 0)

				var_76_0.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos1156ui_story, var_76_4, var_76_3)

				local var_76_5 = manager.ui.mainCamera.transform.position - var_76_0.position

				var_76_0.forward = Vector3.New(var_76_5.x, var_76_5.y, var_76_5.z)

				local var_76_6 = var_76_0.localEulerAngles

				var_76_6.z = 0
				var_76_6.x = 0
				var_76_0.localEulerAngles = var_76_6
			end

			if arg_73_1.time_ >= var_76_1 + var_76_2 and arg_73_1.time_ < var_76_1 + var_76_2 + arg_76_0 then
				var_76_0.localPosition = Vector3.New(0, 100, 0)

				local var_76_7 = manager.ui.mainCamera.transform.position - var_76_0.position

				var_76_0.forward = Vector3.New(var_76_7.x, var_76_7.y, var_76_7.z)

				local var_76_8 = var_76_0.localEulerAngles

				var_76_8.z = 0
				var_76_8.x = 0
				var_76_0.localEulerAngles = var_76_8
			end

			local var_76_9 = arg_73_1.actors_["1156ui_story"]
			local var_76_10 = 0

			if var_76_10 < arg_73_1.time_ and arg_73_1.time_ <= var_76_10 + arg_76_0 and not isNil(var_76_9) and arg_73_1.var_.characterEffect1156ui_story == nil then
				arg_73_1.var_.characterEffect1156ui_story = var_76_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_11 = 0.200000002980232

			if var_76_10 <= arg_73_1.time_ and arg_73_1.time_ < var_76_10 + var_76_11 and not isNil(var_76_9) then
				local var_76_12 = (arg_73_1.time_ - var_76_10) / var_76_11

				if arg_73_1.var_.characterEffect1156ui_story and not isNil(var_76_9) then
					local var_76_13 = Mathf.Lerp(0, 0.5, var_76_12)

					arg_73_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_73_1.var_.characterEffect1156ui_story.fillRatio = var_76_13
				end
			end

			if arg_73_1.time_ >= var_76_10 + var_76_11 and arg_73_1.time_ < var_76_10 + var_76_11 + arg_76_0 and not isNil(var_76_9) and arg_73_1.var_.characterEffect1156ui_story then
				local var_76_14 = 0.5

				arg_73_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_73_1.var_.characterEffect1156ui_story.fillRatio = var_76_14
			end

			local var_76_15 = 0
			local var_76_16 = 0.15

			if var_76_15 < arg_73_1.time_ and arg_73_1.time_ <= var_76_15 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_17 = arg_73_1:FormatText(StoryNameCfg[600].name)

				arg_73_1.leftNameTxt_.text = var_76_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, true)
				arg_73_1.iconController_:SetSelectedState("hero")

				arg_73_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4032")

				arg_73_1.callingController_:SetSelectedState("normal")

				arg_73_1.keyicon_.color = Color.New(1, 1, 1)
				arg_73_1.icon_.color = Color.New(1, 1, 1)

				local var_76_18 = arg_73_1:GetWordFromCfg(321332017)
				local var_76_19 = arg_73_1:FormatText(var_76_18.content)

				arg_73_1.text_.text = var_76_19

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_20 = 6
				local var_76_21 = utf8.len(var_76_19)
				local var_76_22 = var_76_20 <= 0 and var_76_16 or var_76_16 * (var_76_21 / var_76_20)

				if var_76_22 > 0 and var_76_16 < var_76_22 then
					arg_73_1.talkMaxDuration = var_76_22

					if var_76_22 + var_76_15 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_22 + var_76_15
					end
				end

				arg_73_1.text_.text = var_76_19
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332017", "story_v_out_321332.awb") ~= 0 then
					local var_76_23 = manager.audio:GetVoiceLength("story_v_out_321332", "321332017", "story_v_out_321332.awb") / 1000

					if var_76_23 + var_76_15 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_23 + var_76_15
					end

					if var_76_18.prefab_name ~= "" and arg_73_1.actors_[var_76_18.prefab_name] ~= nil then
						local var_76_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_18.prefab_name].transform, "story_v_out_321332", "321332017", "story_v_out_321332.awb")

						arg_73_1:RecordAudio("321332017", var_76_24)
						arg_73_1:RecordAudio("321332017", var_76_24)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_321332", "321332017", "story_v_out_321332.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_321332", "321332017", "story_v_out_321332.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_25 = math.max(var_76_16, arg_73_1.talkMaxDuration)

			if var_76_15 <= arg_73_1.time_ and arg_73_1.time_ < var_76_15 + var_76_25 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_15) / var_76_25

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_15 + var_76_25 and arg_73_1.time_ < var_76_15 + var_76_25 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
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

		arg_73_1:InitPlayNodeList()
	end,
	Play321332018 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 321332018
		arg_77_1.duration_ = 6

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play321332019(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = manager.ui.mainCamera.transform
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 then
				local var_80_2 = arg_77_1.var_.effectduizhuang1
				local var_80_3
				local var_80_4 = var_80_0

				if not var_80_2 then
					var_80_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_dust"), var_80_4)
					var_80_2.name = "duizhuang1"
					arg_77_1.var_.effectduizhuang1 = var_80_2
				else
					var_80_2.transform:SetParent(var_80_4)
				end

				var_80_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_80_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_80_5 = manager.ui.mainCamera.transform
			local var_80_6 = 0

			if var_80_6 < arg_77_1.time_ and arg_77_1.time_ <= var_80_6 + arg_80_0 then
				arg_77_1.var_.shakeOldPos = var_80_5.localPosition
			end

			local var_80_7 = 1

			if var_80_6 <= arg_77_1.time_ and arg_77_1.time_ < var_80_6 + var_80_7 then
				local var_80_8 = (arg_77_1.time_ - var_80_6) / 0.066
				local var_80_9, var_80_10 = math.modf(var_80_8)

				var_80_5.localPosition = Vector3.New(var_80_10 * 0.13, var_80_10 * 0.13, var_80_10 * 0.13) + arg_77_1.var_.shakeOldPos
			end

			if arg_77_1.time_ >= var_80_6 + var_80_7 and arg_77_1.time_ < var_80_6 + var_80_7 + arg_80_0 then
				var_80_5.localPosition = arg_77_1.var_.shakeOldPos
			end

			local var_80_11 = 0

			if var_80_11 < arg_77_1.time_ and arg_77_1.time_ <= var_80_11 + arg_80_0 then
				arg_77_1.allBtn_.enabled = false
			end

			local var_80_12 = 1

			if arg_77_1.time_ >= var_80_11 + var_80_12 and arg_77_1.time_ < var_80_11 + var_80_12 + arg_80_0 then
				arg_77_1.allBtn_.enabled = true
			end

			local var_80_13 = 0.05
			local var_80_14 = 1

			if var_80_13 < arg_77_1.time_ and arg_77_1.time_ <= var_80_13 + arg_80_0 then
				local var_80_15 = "play"
				local var_80_16 = "effect"

				arg_77_1:AudioAction(var_80_15, var_80_16, "se_story_141", "se_story_141_hit02", "")
			end

			if arg_77_1.frameCnt_ <= 1 then
				arg_77_1.dialog_:SetActive(false)
			end

			local var_80_17 = 1
			local var_80_18 = 1.225

			if var_80_17 < arg_77_1.time_ and arg_77_1.time_ <= var_80_17 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0

				arg_77_1.dialog_:SetActive(true)

				arg_77_1.dialogCg_.alpha = 0

				local var_80_19 = LeanTween.value(arg_77_1.dialog_, 0, 1, 0.3)

				var_80_19:setOnUpdate(LuaHelper.FloatAction(function(arg_81_0)
					arg_77_1.dialogCg_.alpha = arg_81_0
				end))
				var_80_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_77_1.dialog_)
					var_80_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_77_1.duration_ = arg_77_1.duration_ + 0.3

				SetActive(arg_77_1.leftNameGo_, false)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_20 = arg_77_1:GetWordFromCfg(321332018)
				local var_80_21 = arg_77_1:FormatText(var_80_20.content)

				arg_77_1.text_.text = var_80_21

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_22 = 49
				local var_80_23 = utf8.len(var_80_21)
				local var_80_24 = var_80_22 <= 0 and var_80_18 or var_80_18 * (var_80_23 / var_80_22)

				if var_80_24 > 0 and var_80_18 < var_80_24 then
					arg_77_1.talkMaxDuration = var_80_24
					var_80_17 = var_80_17 + 0.3

					if var_80_24 + var_80_17 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_24 + var_80_17
					end
				end

				arg_77_1.text_.text = var_80_21
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_25 = var_80_17 + 0.3
			local var_80_26 = math.max(var_80_18, arg_77_1.talkMaxDuration)

			if var_80_25 <= arg_77_1.time_ and arg_77_1.time_ < var_80_25 + var_80_26 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_25) / var_80_26

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_25 + var_80_26 and arg_77_1.time_ < var_80_25 + var_80_26 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play321332019 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 321332019
		arg_83_1.duration_ = 5

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play321332020(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = 0.266666666666667
			local var_86_1 = 1

			if var_86_0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_0 + arg_86_0 then
				local var_86_2 = "play"
				local var_86_3 = "effect"

				arg_83_1:AudioAction(var_86_2, var_86_3, "se_story_141", "se_story_141_ravana_attack07", "")
			end

			local var_86_4 = 0
			local var_86_5 = 1.1

			if var_86_4 < arg_83_1.time_ and arg_83_1.time_ <= var_86_4 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, false)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_6 = arg_83_1:GetWordFromCfg(321332019)
				local var_86_7 = arg_83_1:FormatText(var_86_6.content)

				arg_83_1.text_.text = var_86_7

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_8 = 44
				local var_86_9 = utf8.len(var_86_7)
				local var_86_10 = var_86_8 <= 0 and var_86_5 or var_86_5 * (var_86_9 / var_86_8)

				if var_86_10 > 0 and var_86_5 < var_86_10 then
					arg_83_1.talkMaxDuration = var_86_10

					if var_86_10 + var_86_4 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_10 + var_86_4
					end
				end

				arg_83_1.text_.text = var_86_7
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_11 = math.max(var_86_5, arg_83_1.talkMaxDuration)

			if var_86_4 <= arg_83_1.time_ and arg_83_1.time_ < var_86_4 + var_86_11 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_4) / var_86_11

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_4 + var_86_11 and arg_83_1.time_ < var_86_4 + var_86_11 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play321332020 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 321332020
		arg_87_1.duration_ = 5

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play321332021(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = 0
			local var_90_1 = 1.45

			if var_90_0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_0 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, false)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_2 = arg_87_1:GetWordFromCfg(321332020)
				local var_90_3 = arg_87_1:FormatText(var_90_2.content)

				arg_87_1.text_.text = var_90_3

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_4 = 58
				local var_90_5 = utf8.len(var_90_3)
				local var_90_6 = var_90_4 <= 0 and var_90_1 or var_90_1 * (var_90_5 / var_90_4)

				if var_90_6 > 0 and var_90_1 < var_90_6 then
					arg_87_1.talkMaxDuration = var_90_6

					if var_90_6 + var_90_0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_6 + var_90_0
					end
				end

				arg_87_1.text_.text = var_90_3
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)
				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_7 = math.max(var_90_1, arg_87_1.talkMaxDuration)

			if var_90_0 <= arg_87_1.time_ and arg_87_1.time_ < var_90_0 + var_90_7 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_0) / var_90_7

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_0 + var_90_7 and arg_87_1.time_ < var_90_0 + var_90_7 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play321332021 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 321332021
		arg_91_1.duration_ = 7.53

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play321332022(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = "MS2110"

			if arg_91_1.bgs_[var_94_0] == nil then
				local var_94_1 = Object.Instantiate(arg_91_1.paintGo_)

				var_94_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_94_0)
				var_94_1.name = var_94_0
				var_94_1.transform.parent = arg_91_1.stage_.transform
				var_94_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_91_1.bgs_[var_94_0] = var_94_1
			end

			local var_94_2 = 0

			if var_94_2 < arg_91_1.time_ and arg_91_1.time_ <= var_94_2 + arg_94_0 then
				local var_94_3 = manager.ui.mainCamera.transform.localPosition
				local var_94_4 = Vector3.New(0, 0, 10) + Vector3.New(var_94_3.x, var_94_3.y, 0)
				local var_94_5 = arg_91_1.bgs_.MS2110

				var_94_5.transform.localPosition = var_94_4
				var_94_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_94_6 = var_94_5:GetComponent("SpriteRenderer")

				if var_94_6 and var_94_6.sprite then
					local var_94_7 = (var_94_5.transform.localPosition - var_94_3).z
					local var_94_8 = manager.ui.mainCameraCom_
					local var_94_9 = 2 * var_94_7 * Mathf.Tan(var_94_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_94_10 = var_94_9 * var_94_8.aspect
					local var_94_11 = var_94_6.sprite.bounds.size.x
					local var_94_12 = var_94_6.sprite.bounds.size.y
					local var_94_13 = var_94_10 / var_94_11
					local var_94_14 = var_94_9 / var_94_12
					local var_94_15 = var_94_14 < var_94_13 and var_94_13 or var_94_14

					var_94_5.transform.localScale = Vector3.New(var_94_15, var_94_15, 0)
				end

				for iter_94_0, iter_94_1 in pairs(arg_91_1.bgs_) do
					if iter_94_0 ~= "MS2110" then
						iter_94_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_94_16 = 2

			if var_94_16 < arg_91_1.time_ and arg_91_1.time_ <= var_94_16 + arg_94_0 then
				arg_91_1.allBtn_.enabled = false
			end

			local var_94_17 = 0.3

			if arg_91_1.time_ >= var_94_16 + var_94_17 and arg_91_1.time_ < var_94_16 + var_94_17 + arg_94_0 then
				arg_91_1.allBtn_.enabled = true
			end

			local var_94_18 = 0

			if var_94_18 < arg_91_1.time_ and arg_91_1.time_ <= var_94_18 + arg_94_0 then
				arg_91_1.mask_.enabled = true
				arg_91_1.mask_.raycastTarget = true

				arg_91_1:SetGaussion(false)
			end

			local var_94_19 = 2

			if var_94_18 <= arg_91_1.time_ and arg_91_1.time_ < var_94_18 + var_94_19 then
				local var_94_20 = (arg_91_1.time_ - var_94_18) / var_94_19
				local var_94_21 = Color.New(1, 1, 1)

				var_94_21.a = Mathf.Lerp(1, 0, var_94_20)
				arg_91_1.mask_.color = var_94_21
			end

			if arg_91_1.time_ >= var_94_18 + var_94_19 and arg_91_1.time_ < var_94_18 + var_94_19 + arg_94_0 then
				local var_94_22 = Color.New(1, 1, 1)
				local var_94_23 = 0

				arg_91_1.mask_.enabled = false
				var_94_22.a = var_94_23
				arg_91_1.mask_.color = var_94_22
			end

			local var_94_24 = "MS2110"

			if arg_91_1.bgs_[var_94_24] == nil then
				local var_94_25 = Object.Instantiate(arg_91_1.blurPaintGo_)
				local var_94_26 = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_94_24)

				var_94_25:GetComponent("SpriteRenderer").sprite = var_94_26
				var_94_25.name = var_94_24
				var_94_25.transform.parent = arg_91_1.stage_.transform
				var_94_25.transform.localPosition = Vector3.New(0, 100, 0)
				arg_91_1.bgs_[var_94_24] = var_94_25
			end

			local var_94_27 = 0
			local var_94_28 = arg_91_1.bgs_[var_94_24]

			if var_94_27 < arg_91_1.time_ and arg_91_1.time_ <= var_94_27 + arg_94_0 then
				local var_94_29 = manager.ui.mainCamera.transform.localPosition
				local var_94_30 = Vector3.New(0, 0, 10) + Vector3.New(var_94_29.x, var_94_29.y, 0)

				var_94_28.transform.localPosition = var_94_30
				var_94_28.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_94_31 = var_94_28:GetComponent("SpriteRenderer")

				if var_94_31 and var_94_31.sprite then
					local var_94_32 = (var_94_28.transform.localPosition - var_94_29).z
					local var_94_33 = manager.ui.mainCameraCom_
					local var_94_34 = 2 * var_94_32 * Mathf.Tan(var_94_33.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_94_35 = var_94_34 * var_94_33.aspect
					local var_94_36 = var_94_31.sprite.bounds.size.x
					local var_94_37 = var_94_31.sprite.bounds.size.y
					local var_94_38 = var_94_35 / var_94_36
					local var_94_39 = var_94_34 / var_94_37
					local var_94_40 = var_94_39 < var_94_38 and var_94_38 or var_94_39

					var_94_28.transform.localScale = Vector3.New(var_94_40, var_94_40, 0)
				end
			end

			local var_94_41 = 1.5

			if var_94_27 <= arg_91_1.time_ and arg_91_1.time_ < var_94_27 + var_94_41 then
				local var_94_42 = (arg_91_1.time_ - var_94_27) / var_94_41
				local var_94_43 = Color.New(1, 1, 1)

				var_94_43.a = Mathf.Lerp(1, 0, var_94_42)

				var_94_28:GetComponent("SpriteRenderer").material:SetColor("_Color", var_94_43)
			end

			local var_94_44 = "MS2110"

			if arg_91_1.bgs_[var_94_44] == nil then
				local var_94_45 = Object.Instantiate(arg_91_1.blurPaintGo_)
				local var_94_46 = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_94_44)

				var_94_45:GetComponent("SpriteRenderer").sprite = var_94_46
				var_94_45.name = var_94_44
				var_94_45.transform.parent = arg_91_1.stage_.transform
				var_94_45.transform.localPosition = Vector3.New(0, 100, 0)
				arg_91_1.bgs_[var_94_44] = var_94_45
			end

			local var_94_47 = 1.5
			local var_94_48 = arg_91_1.bgs_[var_94_44]

			if var_94_47 < arg_91_1.time_ and arg_91_1.time_ <= var_94_47 + arg_94_0 then
				local var_94_49 = manager.ui.mainCamera.transform.localPosition
				local var_94_50 = Vector3.New(0, 0, 10) + Vector3.New(var_94_49.x, var_94_49.y, 0)

				var_94_48.transform.localPosition = var_94_50
				var_94_48.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_94_51 = var_94_48:GetComponent("SpriteRenderer")

				if var_94_51 and var_94_51.sprite then
					local var_94_52 = (var_94_48.transform.localPosition - var_94_49).z
					local var_94_53 = manager.ui.mainCameraCom_
					local var_94_54 = 2 * var_94_52 * Mathf.Tan(var_94_53.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_94_55 = var_94_54 * var_94_53.aspect
					local var_94_56 = var_94_51.sprite.bounds.size.x
					local var_94_57 = var_94_51.sprite.bounds.size.y
					local var_94_58 = var_94_55 / var_94_56
					local var_94_59 = var_94_54 / var_94_57
					local var_94_60 = var_94_59 < var_94_58 and var_94_58 or var_94_59

					var_94_48.transform.localScale = Vector3.New(var_94_60, var_94_60, 0)
				end
			end

			local var_94_61 = 0.5

			if var_94_47 <= arg_91_1.time_ and arg_91_1.time_ < var_94_47 + var_94_61 then
				local var_94_62 = (arg_91_1.time_ - var_94_47) / var_94_61
				local var_94_63 = Color.New(1, 1, 1)

				var_94_63.a = Mathf.Lerp(0, 1, var_94_62)

				var_94_48:GetComponent("SpriteRenderer").material:SetColor("_Color", var_94_63)
			end

			local var_94_64 = "MS2110"

			if arg_91_1.bgs_[var_94_64] == nil then
				local var_94_65 = Object.Instantiate(arg_91_1.blurPaintGo_)
				local var_94_66 = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_94_64)

				var_94_65:GetComponent("SpriteRenderer").sprite = var_94_66
				var_94_65.name = var_94_64
				var_94_65.transform.parent = arg_91_1.stage_.transform
				var_94_65.transform.localPosition = Vector3.New(0, 100, 0)
				arg_91_1.bgs_[var_94_64] = var_94_65
			end

			local var_94_67 = 2
			local var_94_68 = arg_91_1.bgs_[var_94_64]

			if var_94_67 < arg_91_1.time_ and arg_91_1.time_ <= var_94_67 + arg_94_0 then
				local var_94_69 = manager.ui.mainCamera.transform.localPosition
				local var_94_70 = Vector3.New(0, 0, 10) + Vector3.New(var_94_69.x, var_94_69.y, 0)

				var_94_68.transform.localPosition = var_94_70
				var_94_68.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_94_71 = var_94_68:GetComponent("SpriteRenderer")

				if var_94_71 and var_94_71.sprite then
					local var_94_72 = (var_94_68.transform.localPosition - var_94_69).z
					local var_94_73 = manager.ui.mainCameraCom_
					local var_94_74 = 2 * var_94_72 * Mathf.Tan(var_94_73.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_94_75 = var_94_74 * var_94_73.aspect
					local var_94_76 = var_94_71.sprite.bounds.size.x
					local var_94_77 = var_94_71.sprite.bounds.size.y
					local var_94_78 = var_94_75 / var_94_76
					local var_94_79 = var_94_74 / var_94_77
					local var_94_80 = var_94_79 < var_94_78 and var_94_78 or var_94_79

					var_94_68.transform.localScale = Vector3.New(var_94_80, var_94_80, 0)
				end
			end

			local var_94_81 = 0.6

			if var_94_67 <= arg_91_1.time_ and arg_91_1.time_ < var_94_67 + var_94_81 then
				local var_94_82 = (arg_91_1.time_ - var_94_67) / var_94_81
				local var_94_83 = Color.New(1, 1, 1)

				var_94_83.a = Mathf.Lerp(1, 0, var_94_82)

				var_94_68:GetComponent("SpriteRenderer").material:SetColor("_Color", var_94_83)
			end

			local var_94_84 = 2

			if var_94_84 < arg_91_1.time_ and arg_91_1.time_ <= var_94_84 + arg_94_0 then
				arg_91_1.allBtn_.enabled = false
			end

			local var_94_85 = 0.533333333333333

			if arg_91_1.time_ >= var_94_84 + var_94_85 and arg_91_1.time_ < var_94_84 + var_94_85 + arg_94_0 then
				arg_91_1.allBtn_.enabled = true
			end

			local var_94_86 = 2.53333333333333
			local var_94_87 = 1

			if var_94_86 < arg_91_1.time_ and arg_91_1.time_ <= var_94_86 + arg_94_0 then
				local var_94_88 = "play"
				local var_94_89 = "effect"

				arg_91_1:AudioAction(var_94_88, var_94_89, "se_story_141", "se_story_141_ravana_footstep01", "")
			end

			local var_94_90 = 0
			local var_94_91 = 1

			if var_94_90 < arg_91_1.time_ and arg_91_1.time_ <= var_94_90 + arg_94_0 then
				local var_94_92 = "play"
				local var_94_93 = "effect"

				arg_91_1:AudioAction(var_94_92, var_94_93, "se_story_141", "se_story_141_explosion02", "")
			end

			if arg_91_1.frameCnt_ <= 1 then
				arg_91_1.dialog_:SetActive(false)
			end

			local var_94_94 = 2.53333333333333
			local var_94_95 = 0.8

			if var_94_94 < arg_91_1.time_ and arg_91_1.time_ <= var_94_94 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0

				arg_91_1.dialog_:SetActive(true)

				arg_91_1.dialogCg_.alpha = 0

				local var_94_96 = LeanTween.value(arg_91_1.dialog_, 0, 1, 0.3)

				var_94_96:setOnUpdate(LuaHelper.FloatAction(function(arg_95_0)
					arg_91_1.dialogCg_.alpha = arg_95_0
				end))
				var_94_96:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_91_1.dialog_)
					var_94_96:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_91_1.duration_ = arg_91_1.duration_ + 0.3

				SetActive(arg_91_1.leftNameGo_, false)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_97 = arg_91_1:GetWordFromCfg(321332021)
				local var_94_98 = arg_91_1:FormatText(var_94_97.content)

				arg_91_1.text_.text = var_94_98

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_99 = 32
				local var_94_100 = utf8.len(var_94_98)
				local var_94_101 = var_94_99 <= 0 and var_94_95 or var_94_95 * (var_94_100 / var_94_99)

				if var_94_101 > 0 and var_94_95 < var_94_101 then
					arg_91_1.talkMaxDuration = var_94_101
					var_94_94 = var_94_94 + 0.3

					if var_94_101 + var_94_94 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_101 + var_94_94
					end
				end

				arg_91_1.text_.text = var_94_98
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)
				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_102 = var_94_94 + 0.3
			local var_94_103 = math.max(var_94_95, arg_91_1.talkMaxDuration)

			if var_94_102 <= arg_91_1.time_ and arg_91_1.time_ < var_94_102 + var_94_103 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_102) / var_94_103

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_102 + var_94_103 and arg_91_1.time_ < var_94_102 + var_94_103 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play321332022 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 321332022
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play321332023(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0
			local var_100_1 = 0.55

			if var_100_0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, false)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_2 = arg_97_1:GetWordFromCfg(321332022)
				local var_100_3 = arg_97_1:FormatText(var_100_2.content)

				arg_97_1.text_.text = var_100_3

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_4 = 22
				local var_100_5 = utf8.len(var_100_3)
				local var_100_6 = var_100_4 <= 0 and var_100_1 or var_100_1 * (var_100_5 / var_100_4)

				if var_100_6 > 0 and var_100_1 < var_100_6 then
					arg_97_1.talkMaxDuration = var_100_6

					if var_100_6 + var_100_0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_6 + var_100_0
					end
				end

				arg_97_1.text_.text = var_100_3
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_7 = math.max(var_100_1, arg_97_1.talkMaxDuration)

			if var_100_0 <= arg_97_1.time_ and arg_97_1.time_ < var_100_0 + var_100_7 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_0) / var_100_7

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_0 + var_100_7 and arg_97_1.time_ < var_100_0 + var_100_7 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play321332023 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 321332023
		arg_101_1.duration_ = 7.63

		local var_101_0 = {
			zh = 4.7,
			ja = 7.633
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
				arg_101_0:Play321332024(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0
			local var_104_1 = 0.45

			if var_104_0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_2 = arg_101_1:FormatText(StoryNameCfg[612].name)

				arg_101_1.leftNameTxt_.text = var_104_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, true)
				arg_101_1.iconController_:SetSelectedState("hero")

				arg_101_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1061_split_3")

				arg_101_1.callingController_:SetSelectedState("normal")

				arg_101_1.keyicon_.color = Color.New(1, 1, 1)
				arg_101_1.icon_.color = Color.New(1, 1, 1)

				local var_104_3 = arg_101_1:GetWordFromCfg(321332023)
				local var_104_4 = arg_101_1:FormatText(var_104_3.content)

				arg_101_1.text_.text = var_104_4

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_5 = 18
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

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332023", "story_v_out_321332.awb") ~= 0 then
					local var_104_8 = manager.audio:GetVoiceLength("story_v_out_321332", "321332023", "story_v_out_321332.awb") / 1000

					if var_104_8 + var_104_0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_8 + var_104_0
					end

					if var_104_3.prefab_name ~= "" and arg_101_1.actors_[var_104_3.prefab_name] ~= nil then
						local var_104_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_3.prefab_name].transform, "story_v_out_321332", "321332023", "story_v_out_321332.awb")

						arg_101_1:RecordAudio("321332023", var_104_9)
						arg_101_1:RecordAudio("321332023", var_104_9)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_321332", "321332023", "story_v_out_321332.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_321332", "321332023", "story_v_out_321332.awb")
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
	Play321332024 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 321332024
		arg_105_1.duration_ = 7.23

		local var_105_0 = {
			zh = 5.333,
			ja = 7.233
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
				arg_105_0:Play321332025(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 0
			local var_108_1 = 0.475

			if var_108_0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_2 = arg_105_1:FormatText(StoryNameCfg[600].name)

				arg_105_1.leftNameTxt_.text = var_108_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_3 = arg_105_1:GetWordFromCfg(321332024)
				local var_108_4 = arg_105_1:FormatText(var_108_3.content)

				arg_105_1.text_.text = var_108_4

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_5 = 19
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

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332024", "story_v_out_321332.awb") ~= 0 then
					local var_108_8 = manager.audio:GetVoiceLength("story_v_out_321332", "321332024", "story_v_out_321332.awb") / 1000

					if var_108_8 + var_108_0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_8 + var_108_0
					end

					if var_108_3.prefab_name ~= "" and arg_105_1.actors_[var_108_3.prefab_name] ~= nil then
						local var_108_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_3.prefab_name].transform, "story_v_out_321332", "321332024", "story_v_out_321332.awb")

						arg_105_1:RecordAudio("321332024", var_108_9)
						arg_105_1:RecordAudio("321332024", var_108_9)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_321332", "321332024", "story_v_out_321332.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_321332", "321332024", "story_v_out_321332.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_10 = math.max(var_108_1, arg_105_1.talkMaxDuration)

			if var_108_0 <= arg_105_1.time_ and arg_105_1.time_ < var_108_0 + var_108_10 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_0) / var_108_10

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_0 + var_108_10 and arg_105_1.time_ < var_108_0 + var_108_10 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play321332025 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 321332025
		arg_109_1.duration_ = 1

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play321332026(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 0
			local var_112_1 = 0.05

			if var_112_0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_0 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_2 = arg_109_1:FormatText(StoryNameCfg[612].name)

				arg_109_1.leftNameTxt_.text = var_112_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_3 = arg_109_1:GetWordFromCfg(321332025)
				local var_112_4 = arg_109_1:FormatText(var_112_3.content)

				arg_109_1.text_.text = var_112_4

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_5 = 2
				local var_112_6 = utf8.len(var_112_4)
				local var_112_7 = var_112_5 <= 0 and var_112_1 or var_112_1 * (var_112_6 / var_112_5)

				if var_112_7 > 0 and var_112_1 < var_112_7 then
					arg_109_1.talkMaxDuration = var_112_7

					if var_112_7 + var_112_0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_7 + var_112_0
					end
				end

				arg_109_1.text_.text = var_112_4
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332025", "story_v_out_321332.awb") ~= 0 then
					local var_112_8 = manager.audio:GetVoiceLength("story_v_out_321332", "321332025", "story_v_out_321332.awb") / 1000

					if var_112_8 + var_112_0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_8 + var_112_0
					end

					if var_112_3.prefab_name ~= "" and arg_109_1.actors_[var_112_3.prefab_name] ~= nil then
						local var_112_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_3.prefab_name].transform, "story_v_out_321332", "321332025", "story_v_out_321332.awb")

						arg_109_1:RecordAudio("321332025", var_112_9)
						arg_109_1:RecordAudio("321332025", var_112_9)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_321332", "321332025", "story_v_out_321332.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_321332", "321332025", "story_v_out_321332.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_10 = math.max(var_112_1, arg_109_1.talkMaxDuration)

			if var_112_0 <= arg_109_1.time_ and arg_109_1.time_ < var_112_0 + var_112_10 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_0) / var_112_10

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_0 + var_112_10 and arg_109_1.time_ < var_112_0 + var_112_10 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play321332026 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 321332026
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play321332027(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = 0
			local var_116_1 = 1

			if var_116_0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_0 + arg_116_0 then
				local var_116_2 = "play"
				local var_116_3 = "effect"

				arg_113_1:AudioAction(var_116_2, var_116_3, "se_story_141", "se_story_141_xuanji03", "")
			end

			local var_116_4 = 0
			local var_116_5 = 0.925

			if var_116_4 < arg_113_1.time_ and arg_113_1.time_ <= var_116_4 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, false)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_6 = arg_113_1:GetWordFromCfg(321332026)
				local var_116_7 = arg_113_1:FormatText(var_116_6.content)

				arg_113_1.text_.text = var_116_7

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_8 = 37
				local var_116_9 = utf8.len(var_116_7)
				local var_116_10 = var_116_8 <= 0 and var_116_5 or var_116_5 * (var_116_9 / var_116_8)

				if var_116_10 > 0 and var_116_5 < var_116_10 then
					arg_113_1.talkMaxDuration = var_116_10

					if var_116_10 + var_116_4 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_10 + var_116_4
					end
				end

				arg_113_1.text_.text = var_116_7
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_11 = math.max(var_116_5, arg_113_1.talkMaxDuration)

			if var_116_4 <= arg_113_1.time_ and arg_113_1.time_ < var_116_4 + var_116_11 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_4) / var_116_11

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_4 + var_116_11 and arg_113_1.time_ < var_116_4 + var_116_11 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play321332027 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 321332027
		arg_117_1.duration_ = 7.1

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play321332028(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 0.1

			if var_120_0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_0 + arg_120_0 then
				local var_120_1 = manager.ui.mainCamera.transform.localPosition
				local var_120_2 = Vector3.New(0, 0, 10) + Vector3.New(var_120_1.x, var_120_1.y, 0)
				local var_120_3 = arg_117_1.bgs_.MS2110

				var_120_3.transform.localPosition = var_120_2
				var_120_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_120_4 = var_120_3:GetComponent("SpriteRenderer")

				if var_120_4 and var_120_4.sprite then
					local var_120_5 = (var_120_3.transform.localPosition - var_120_1).z
					local var_120_6 = manager.ui.mainCameraCom_
					local var_120_7 = 2 * var_120_5 * Mathf.Tan(var_120_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_120_8 = var_120_7 * var_120_6.aspect
					local var_120_9 = var_120_4.sprite.bounds.size.x
					local var_120_10 = var_120_4.sprite.bounds.size.y
					local var_120_11 = var_120_8 / var_120_9
					local var_120_12 = var_120_7 / var_120_10
					local var_120_13 = var_120_12 < var_120_11 and var_120_11 or var_120_12

					var_120_3.transform.localScale = Vector3.New(var_120_13, var_120_13, 0)
				end

				for iter_120_0, iter_120_1 in pairs(arg_117_1.bgs_) do
					if iter_120_0 ~= "MS2110" then
						iter_120_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_120_14 = arg_117_1.bgs_.MS2110.transform
			local var_120_15 = 0.183333333333333

			if var_120_15 < arg_117_1.time_ and arg_117_1.time_ <= var_120_15 + arg_120_0 then
				arg_117_1.var_.moveOldPosMS2110 = var_120_14.localPosition
			end

			local var_120_16 = 0.001

			if var_120_15 <= arg_117_1.time_ and arg_117_1.time_ < var_120_15 + var_120_16 then
				local var_120_17 = (arg_117_1.time_ - var_120_15) / var_120_16
				local var_120_18 = Vector3.New(0.68, 3, 1.04)

				var_120_14.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPosMS2110, var_120_18, var_120_17)
			end

			if arg_117_1.time_ >= var_120_15 + var_120_16 and arg_117_1.time_ < var_120_15 + var_120_16 + arg_120_0 then
				var_120_14.localPosition = Vector3.New(0.68, 3, 1.04)
			end

			local var_120_19 = arg_117_1.bgs_.MS2110.transform
			local var_120_20 = 0.633333333333333

			if var_120_20 < arg_117_1.time_ and arg_117_1.time_ <= var_120_20 + arg_120_0 then
				arg_117_1.var_.moveOldPosMS2110 = var_120_19.localPosition
			end

			local var_120_21 = 1.9

			if var_120_20 <= arg_117_1.time_ and arg_117_1.time_ < var_120_20 + var_120_21 then
				local var_120_22 = (arg_117_1.time_ - var_120_20) / var_120_21
				local var_120_23 = Vector3.New(0.68, 2.5, 1.04)

				var_120_19.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPosMS2110, var_120_23, var_120_22)
			end

			if arg_117_1.time_ >= var_120_20 + var_120_21 and arg_117_1.time_ < var_120_20 + var_120_21 + arg_120_0 then
				var_120_19.localPosition = Vector3.New(0.68, 2.5, 1.04)
			end

			local var_120_24 = manager.ui.mainCamera.transform
			local var_120_25 = 0

			if var_120_25 < arg_117_1.time_ and arg_117_1.time_ <= var_120_25 + arg_120_0 then
				local var_120_26 = arg_117_1.var_.effectluobonaend1
				local var_120_27
				local var_120_28 = var_120_24

				if not var_120_26 then
					var_120_26 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), var_120_28)
					var_120_26.name = "luobonaend1"
					arg_117_1.var_.effectluobonaend1 = var_120_26
				else
					var_120_26.transform:SetParent(var_120_28)
				end

				var_120_26.transform.localPosition = Vector3.New(0, 0, 0)
				var_120_26.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_120_29 = manager.ui.mainCamera.transform
			local var_120_30 = 1

			if var_120_30 < arg_117_1.time_ and arg_117_1.time_ <= var_120_30 + arg_120_0 then
				local var_120_31 = arg_117_1.var_.effectluobonaend1

				if var_120_31 then
					Object.Destroy(var_120_31)

					arg_117_1.var_.effectluobonaend1 = nil
				end
			end

			local var_120_32 = 0

			if var_120_32 < arg_117_1.time_ and arg_117_1.time_ <= var_120_32 + arg_120_0 then
				arg_117_1.mask_.enabled = true
				arg_117_1.mask_.raycastTarget = true

				arg_117_1:SetGaussion(false)
			end

			local var_120_33 = 0.2

			if var_120_32 <= arg_117_1.time_ and arg_117_1.time_ < var_120_32 + var_120_33 then
				local var_120_34 = (arg_117_1.time_ - var_120_32) / var_120_33
				local var_120_35 = Color.New(0, 0, 0)

				var_120_35.a = Mathf.Lerp(0, 1, var_120_34)
				arg_117_1.mask_.color = var_120_35
			end

			if arg_117_1.time_ >= var_120_32 + var_120_33 and arg_117_1.time_ < var_120_32 + var_120_33 + arg_120_0 then
				local var_120_36 = Color.New(0, 0, 0)

				var_120_36.a = 1
				arg_117_1.mask_.color = var_120_36
			end

			local var_120_37 = 0.2

			if var_120_37 < arg_117_1.time_ and arg_117_1.time_ <= var_120_37 + arg_120_0 then
				arg_117_1.mask_.enabled = true
				arg_117_1.mask_.raycastTarget = true

				arg_117_1:SetGaussion(false)
			end

			local var_120_38 = 0.1

			if var_120_37 <= arg_117_1.time_ and arg_117_1.time_ < var_120_37 + var_120_38 then
				local var_120_39 = (arg_117_1.time_ - var_120_37) / var_120_38
				local var_120_40 = Color.New(0, 0, 0)

				var_120_40.a = Mathf.Lerp(1, 0, var_120_39)
				arg_117_1.mask_.color = var_120_40
			end

			if arg_117_1.time_ >= var_120_37 + var_120_38 and arg_117_1.time_ < var_120_37 + var_120_38 + arg_120_0 then
				local var_120_41 = Color.New(0, 0, 0)
				local var_120_42 = 0

				arg_117_1.mask_.enabled = false
				var_120_41.a = var_120_42
				arg_117_1.mask_.color = var_120_41
			end

			local var_120_43 = manager.ui.mainCamera.transform
			local var_120_44 = 0.2

			if var_120_44 < arg_117_1.time_ and arg_117_1.time_ <= var_120_44 + arg_120_0 then
				local var_120_45 = arg_117_1.var_.effectluobonaend2
				local var_120_46
				local var_120_47 = var_120_43

				if not var_120_45 then
					var_120_45 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ripple"), var_120_47)
					var_120_45.name = "luobonaend2"
					arg_117_1.var_.effectluobonaend2 = var_120_45
				else
					var_120_45.transform:SetParent(var_120_47)
				end

				var_120_45.transform.localPosition = Vector3.New(0, 0, 0)
				var_120_45.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_120_48 = 0
			local var_120_49 = 1

			if var_120_48 < arg_117_1.time_ and arg_117_1.time_ <= var_120_48 + arg_120_0 then
				local var_120_50 = "play"
				local var_120_51 = "effect"

				arg_117_1:AudioAction(var_120_50, var_120_51, "se_story_141", "se_story_141_ring", "")
			end

			local var_120_52 = 1.769
			local var_120_53 = 1

			if var_120_52 < arg_117_1.time_ and arg_117_1.time_ <= var_120_52 + arg_120_0 then
				local var_120_54 = "play"
				local var_120_55 = "effect"

				arg_117_1:AudioAction(var_120_54, var_120_55, "se_story_141", "se_story_141_amb_bass", "")
			end

			if arg_117_1.frameCnt_ <= 1 then
				arg_117_1.dialog_:SetActive(false)
			end

			local var_120_56 = 2.1
			local var_120_57 = 1.7

			if var_120_56 < arg_117_1.time_ and arg_117_1.time_ <= var_120_56 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0

				arg_117_1.dialog_:SetActive(true)

				arg_117_1.dialogCg_.alpha = 0

				local var_120_58 = LeanTween.value(arg_117_1.dialog_, 0, 1, 0.3)

				var_120_58:setOnUpdate(LuaHelper.FloatAction(function(arg_121_0)
					arg_117_1.dialogCg_.alpha = arg_121_0
				end))
				var_120_58:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_117_1.dialog_)
					var_120_58:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_117_1.duration_ = arg_117_1.duration_ + 0.3

				SetActive(arg_117_1.leftNameGo_, false)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_59 = arg_117_1:GetWordFromCfg(321332027)
				local var_120_60 = arg_117_1:FormatText(var_120_59.content)

				arg_117_1.text_.text = var_120_60

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_61 = 68
				local var_120_62 = utf8.len(var_120_60)
				local var_120_63 = var_120_61 <= 0 and var_120_57 or var_120_57 * (var_120_62 / var_120_61)

				if var_120_63 > 0 and var_120_57 < var_120_63 then
					arg_117_1.talkMaxDuration = var_120_63
					var_120_56 = var_120_56 + 0.3

					if var_120_63 + var_120_56 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_63 + var_120_56
					end
				end

				arg_117_1.text_.text = var_120_60
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_64 = var_120_56 + 0.3
			local var_120_65 = math.max(var_120_57, arg_117_1.talkMaxDuration)

			if var_120_64 <= arg_117_1.time_ and arg_117_1.time_ < var_120_64 + var_120_65 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_64) / var_120_65

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_64 + var_120_65 and arg_117_1.time_ < var_120_64 + var_120_65 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "MS2110",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0.183333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "MS2110",
				changeDisplayLayer = false,
				needEase = false,
				duration = 1.9,
				className = "StoryMoveNode",
				startTime = 0.633333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_117_1:InitPlayNodeList()
	end,
	Play321332028 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 321332028
		arg_123_1.duration_ = 3.2

		local var_123_0 = {
			zh = 3.2,
			ja = 1.233
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
				arg_123_0:Play321332029(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = 0
			local var_126_1 = 0.075

			if var_126_0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_0 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				local var_126_2 = arg_123_1:FormatText(StoryNameCfg[600].name)

				arg_123_1.leftNameTxt_.text = var_126_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_3 = arg_123_1:GetWordFromCfg(321332028)
				local var_126_4 = arg_123_1:FormatText(var_126_3.content)

				arg_123_1.text_.text = var_126_4

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_5 = 3
				local var_126_6 = utf8.len(var_126_4)
				local var_126_7 = var_126_5 <= 0 and var_126_1 or var_126_1 * (var_126_6 / var_126_5)

				if var_126_7 > 0 and var_126_1 < var_126_7 then
					arg_123_1.talkMaxDuration = var_126_7

					if var_126_7 + var_126_0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_7 + var_126_0
					end
				end

				arg_123_1.text_.text = var_126_4
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332028", "story_v_out_321332.awb") ~= 0 then
					local var_126_8 = manager.audio:GetVoiceLength("story_v_out_321332", "321332028", "story_v_out_321332.awb") / 1000

					if var_126_8 + var_126_0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_8 + var_126_0
					end

					if var_126_3.prefab_name ~= "" and arg_123_1.actors_[var_126_3.prefab_name] ~= nil then
						local var_126_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_3.prefab_name].transform, "story_v_out_321332", "321332028", "story_v_out_321332.awb")

						arg_123_1:RecordAudio("321332028", var_126_9)
						arg_123_1:RecordAudio("321332028", var_126_9)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_321332", "321332028", "story_v_out_321332.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_321332", "321332028", "story_v_out_321332.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_10 = math.max(var_126_1, arg_123_1.talkMaxDuration)

			if var_126_0 <= arg_123_1.time_ and arg_123_1.time_ < var_126_0 + var_126_10 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_0) / var_126_10

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_0 + var_126_10 and arg_123_1.time_ < var_126_0 + var_126_10 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play321332029 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 321332029
		arg_127_1.duration_ = 5

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play321332030(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = 0.05
			local var_130_1 = 1

			if var_130_0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_0 + arg_130_0 then
				local var_130_2 = "play"
				local var_130_3 = "effect"

				arg_127_1:AudioAction(var_130_2, var_130_3, "se_story_141", "se_story_141_energy02", "")
			end

			local var_130_4 = 0
			local var_130_5 = 1.6

			if var_130_4 < arg_127_1.time_ and arg_127_1.time_ <= var_130_4 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, false)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_6 = arg_127_1:GetWordFromCfg(321332029)
				local var_130_7 = arg_127_1:FormatText(var_130_6.content)

				arg_127_1.text_.text = var_130_7

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_8 = 64
				local var_130_9 = utf8.len(var_130_7)
				local var_130_10 = var_130_8 <= 0 and var_130_5 or var_130_5 * (var_130_9 / var_130_8)

				if var_130_10 > 0 and var_130_5 < var_130_10 then
					arg_127_1.talkMaxDuration = var_130_10

					if var_130_10 + var_130_4 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_10 + var_130_4
					end
				end

				arg_127_1.text_.text = var_130_7
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_11 = math.max(var_130_5, arg_127_1.talkMaxDuration)

			if var_130_4 <= arg_127_1.time_ and arg_127_1.time_ < var_130_4 + var_130_11 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_4) / var_130_11

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_4 + var_130_11 and arg_127_1.time_ < var_130_4 + var_130_11 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play321332030 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 321332030
		arg_131_1.duration_ = 5

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play321332031(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = 0
			local var_134_1 = 1.5

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

				local var_134_2 = arg_131_1:GetWordFromCfg(321332030)
				local var_134_3 = arg_131_1:FormatText(var_134_2.content)

				arg_131_1.text_.text = var_134_3

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_4 = 60
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
	Play321332031 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 321332031
		arg_135_1.duration_ = 5.53

		local var_135_0 = {
			zh = 3.133,
			ja = 5.533
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
				arg_135_0:Play321332032(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = manager.ui.mainCamera.transform
			local var_138_1 = 0

			if var_138_1 < arg_135_1.time_ and arg_135_1.time_ <= var_138_1 + arg_138_0 then
				arg_135_1.var_.shakeOldPos = var_138_0.localPosition
			end

			local var_138_2 = 1

			if var_138_1 <= arg_135_1.time_ and arg_135_1.time_ < var_138_1 + var_138_2 then
				local var_138_3 = (arg_135_1.time_ - var_138_1) / 0.066
				local var_138_4, var_138_5 = math.modf(var_138_3)

				var_138_0.localPosition = Vector3.New(var_138_5 * 0.13, var_138_5 * 0.13, var_138_5 * 0.13) + arg_135_1.var_.shakeOldPos
			end

			if arg_135_1.time_ >= var_138_1 + var_138_2 and arg_135_1.time_ < var_138_1 + var_138_2 + arg_138_0 then
				var_138_0.localPosition = arg_135_1.var_.shakeOldPos
			end

			local var_138_6 = 0

			if var_138_6 < arg_135_1.time_ and arg_135_1.time_ <= var_138_6 + arg_138_0 then
				arg_135_1.allBtn_.enabled = false
			end

			local var_138_7 = 1

			if arg_135_1.time_ >= var_138_6 + var_138_7 and arg_135_1.time_ < var_138_6 + var_138_7 + arg_138_0 then
				arg_135_1.allBtn_.enabled = true
			end

			local var_138_8 = 0
			local var_138_9 = 0.275

			if var_138_8 < arg_135_1.time_ and arg_135_1.time_ <= var_138_8 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				local var_138_10 = arg_135_1:FormatText(StoryNameCfg[600].name)

				arg_135_1.leftNameTxt_.text = var_138_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_11 = arg_135_1:GetWordFromCfg(321332031)
				local var_138_12 = arg_135_1:FormatText(var_138_11.content)

				arg_135_1.text_.text = var_138_12

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_13 = 11
				local var_138_14 = utf8.len(var_138_12)
				local var_138_15 = var_138_13 <= 0 and var_138_9 or var_138_9 * (var_138_14 / var_138_13)

				if var_138_15 > 0 and var_138_9 < var_138_15 then
					arg_135_1.talkMaxDuration = var_138_15

					if var_138_15 + var_138_8 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_15 + var_138_8
					end
				end

				arg_135_1.text_.text = var_138_12
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332031", "story_v_out_321332.awb") ~= 0 then
					local var_138_16 = manager.audio:GetVoiceLength("story_v_out_321332", "321332031", "story_v_out_321332.awb") / 1000

					if var_138_16 + var_138_8 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_16 + var_138_8
					end

					if var_138_11.prefab_name ~= "" and arg_135_1.actors_[var_138_11.prefab_name] ~= nil then
						local var_138_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_11.prefab_name].transform, "story_v_out_321332", "321332031", "story_v_out_321332.awb")

						arg_135_1:RecordAudio("321332031", var_138_17)
						arg_135_1:RecordAudio("321332031", var_138_17)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_321332", "321332031", "story_v_out_321332.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_321332", "321332031", "story_v_out_321332.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_18 = math.max(var_138_9, arg_135_1.talkMaxDuration)

			if var_138_8 <= arg_135_1.time_ and arg_135_1.time_ < var_138_8 + var_138_18 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_8) / var_138_18

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_8 + var_138_18 and arg_135_1.time_ < var_138_8 + var_138_18 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play321332032 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 321332032
		arg_139_1.duration_ = 5

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play321332033(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = 0
			local var_142_1 = 1.3

			if var_142_0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_0 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, false)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_2 = arg_139_1:GetWordFromCfg(321332032)
				local var_142_3 = arg_139_1:FormatText(var_142_2.content)

				arg_139_1.text_.text = var_142_3

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_4 = 52
				local var_142_5 = utf8.len(var_142_3)
				local var_142_6 = var_142_4 <= 0 and var_142_1 or var_142_1 * (var_142_5 / var_142_4)

				if var_142_6 > 0 and var_142_1 < var_142_6 then
					arg_139_1.talkMaxDuration = var_142_6

					if var_142_6 + var_142_0 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_6 + var_142_0
					end
				end

				arg_139_1.text_.text = var_142_3
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)
				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_7 = math.max(var_142_1, arg_139_1.talkMaxDuration)

			if var_142_0 <= arg_139_1.time_ and arg_139_1.time_ < var_142_0 + var_142_7 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_0) / var_142_7

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_0 + var_142_7 and arg_139_1.time_ < var_142_0 + var_142_7 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play321332033 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 321332033
		arg_143_1.duration_ = 4.63

		local var_143_0 = {
			zh = 3.633,
			ja = 4.633
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
				arg_143_0:Play321332034(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = 0
			local var_146_1 = 0.3

			if var_146_0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_0 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				local var_146_2 = arg_143_1:FormatText(StoryNameCfg[612].name)

				arg_143_1.leftNameTxt_.text = var_146_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, true)
				arg_143_1.iconController_:SetSelectedState("hero")

				arg_143_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1061_split_1")

				arg_143_1.callingController_:SetSelectedState("normal")

				arg_143_1.keyicon_.color = Color.New(1, 1, 1)
				arg_143_1.icon_.color = Color.New(1, 1, 1)

				local var_146_3 = arg_143_1:GetWordFromCfg(321332033)
				local var_146_4 = arg_143_1:FormatText(var_146_3.content)

				arg_143_1.text_.text = var_146_4

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_5 = 12
				local var_146_6 = utf8.len(var_146_4)
				local var_146_7 = var_146_5 <= 0 and var_146_1 or var_146_1 * (var_146_6 / var_146_5)

				if var_146_7 > 0 and var_146_1 < var_146_7 then
					arg_143_1.talkMaxDuration = var_146_7

					if var_146_7 + var_146_0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_7 + var_146_0
					end
				end

				arg_143_1.text_.text = var_146_4
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332033", "story_v_out_321332.awb") ~= 0 then
					local var_146_8 = manager.audio:GetVoiceLength("story_v_out_321332", "321332033", "story_v_out_321332.awb") / 1000

					if var_146_8 + var_146_0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_8 + var_146_0
					end

					if var_146_3.prefab_name ~= "" and arg_143_1.actors_[var_146_3.prefab_name] ~= nil then
						local var_146_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_3.prefab_name].transform, "story_v_out_321332", "321332033", "story_v_out_321332.awb")

						arg_143_1:RecordAudio("321332033", var_146_9)
						arg_143_1:RecordAudio("321332033", var_146_9)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_321332", "321332033", "story_v_out_321332.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_321332", "321332033", "story_v_out_321332.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_10 = math.max(var_146_1, arg_143_1.talkMaxDuration)

			if var_146_0 <= arg_143_1.time_ and arg_143_1.time_ < var_146_0 + var_146_10 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_0) / var_146_10

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_0 + var_146_10 and arg_143_1.time_ < var_146_0 + var_146_10 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play321332034 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 321332034
		arg_147_1.duration_ = 3.53

		local var_147_0 = {
			zh = 3.533,
			ja = 3.2
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
				arg_147_0:Play321332035(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = arg_147_1.actors_["1061ui_story"]
			local var_150_1 = 0

			if var_150_1 < arg_147_1.time_ and arg_147_1.time_ <= var_150_1 + arg_150_0 and not isNil(var_150_0) and arg_147_1.var_.characterEffect1061ui_story == nil then
				arg_147_1.var_.characterEffect1061ui_story = var_150_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_2 = 0.200000002980232

			if var_150_1 <= arg_147_1.time_ and arg_147_1.time_ < var_150_1 + var_150_2 and not isNil(var_150_0) then
				local var_150_3 = (arg_147_1.time_ - var_150_1) / var_150_2

				if arg_147_1.var_.characterEffect1061ui_story and not isNil(var_150_0) then
					local var_150_4 = Mathf.Lerp(0, 0.5, var_150_3)

					arg_147_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_147_1.var_.characterEffect1061ui_story.fillRatio = var_150_4
				end
			end

			if arg_147_1.time_ >= var_150_1 + var_150_2 and arg_147_1.time_ < var_150_1 + var_150_2 + arg_150_0 and not isNil(var_150_0) and arg_147_1.var_.characterEffect1061ui_story then
				local var_150_5 = 0.5

				arg_147_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_147_1.var_.characterEffect1061ui_story.fillRatio = var_150_5
			end

			local var_150_6 = 0
			local var_150_7 = 0.15

			if var_150_6 < arg_147_1.time_ and arg_147_1.time_ <= var_150_6 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				local var_150_8 = arg_147_1:FormatText(StoryNameCfg[600].name)

				arg_147_1.leftNameTxt_.text = var_150_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_9 = arg_147_1:GetWordFromCfg(321332034)
				local var_150_10 = arg_147_1:FormatText(var_150_9.content)

				arg_147_1.text_.text = var_150_10

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_11 = 6
				local var_150_12 = utf8.len(var_150_10)
				local var_150_13 = var_150_11 <= 0 and var_150_7 or var_150_7 * (var_150_12 / var_150_11)

				if var_150_13 > 0 and var_150_7 < var_150_13 then
					arg_147_1.talkMaxDuration = var_150_13

					if var_150_13 + var_150_6 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_13 + var_150_6
					end
				end

				arg_147_1.text_.text = var_150_10
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332034", "story_v_out_321332.awb") ~= 0 then
					local var_150_14 = manager.audio:GetVoiceLength("story_v_out_321332", "321332034", "story_v_out_321332.awb") / 1000

					if var_150_14 + var_150_6 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_14 + var_150_6
					end

					if var_150_9.prefab_name ~= "" and arg_147_1.actors_[var_150_9.prefab_name] ~= nil then
						local var_150_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_9.prefab_name].transform, "story_v_out_321332", "321332034", "story_v_out_321332.awb")

						arg_147_1:RecordAudio("321332034", var_150_15)
						arg_147_1:RecordAudio("321332034", var_150_15)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_321332", "321332034", "story_v_out_321332.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_321332", "321332034", "story_v_out_321332.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_16 = math.max(var_150_7, arg_147_1.talkMaxDuration)

			if var_150_6 <= arg_147_1.time_ and arg_147_1.time_ < var_150_6 + var_150_16 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_6) / var_150_16

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_6 + var_150_16 and arg_147_1.time_ < var_150_6 + var_150_16 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play321332035 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 321332035
		arg_151_1.duration_ = 6.8

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play321332036(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = arg_151_1.actors_["1061ui_story"].transform
			local var_154_1 = 0

			if var_154_1 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 then
				arg_151_1.var_.moveOldPos1061ui_story = var_154_0.localPosition
			end

			local var_154_2 = 0.001

			if var_154_1 <= arg_151_1.time_ and arg_151_1.time_ < var_154_1 + var_154_2 then
				local var_154_3 = (arg_151_1.time_ - var_154_1) / var_154_2
				local var_154_4 = Vector3.New(0, 100, 0)

				var_154_0.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos1061ui_story, var_154_4, var_154_3)

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

			local var_154_9 = 0

			if var_154_9 < arg_151_1.time_ and arg_151_1.time_ <= var_154_9 + arg_154_0 then
				arg_151_1.mask_.enabled = true
				arg_151_1.mask_.raycastTarget = true

				arg_151_1:SetGaussion(false)
			end

			local var_154_10 = 1

			if var_154_9 <= arg_151_1.time_ and arg_151_1.time_ < var_154_9 + var_154_10 then
				local var_154_11 = (arg_151_1.time_ - var_154_9) / var_154_10
				local var_154_12 = Color.New(1, 1, 1)

				var_154_12.a = Mathf.Lerp(0, 1, var_154_11)
				arg_151_1.mask_.color = var_154_12
			end

			if arg_151_1.time_ >= var_154_9 + var_154_10 and arg_151_1.time_ < var_154_9 + var_154_10 + arg_154_0 then
				local var_154_13 = Color.New(1, 1, 1)

				var_154_13.a = 1
				arg_151_1.mask_.color = var_154_13
			end

			local var_154_14 = 1

			if var_154_14 < arg_151_1.time_ and arg_151_1.time_ <= var_154_14 + arg_154_0 then
				arg_151_1.mask_.enabled = true
				arg_151_1.mask_.raycastTarget = true

				arg_151_1:SetGaussion(false)
			end

			local var_154_15 = 1

			if var_154_14 <= arg_151_1.time_ and arg_151_1.time_ < var_154_14 + var_154_15 then
				local var_154_16 = (arg_151_1.time_ - var_154_14) / var_154_15
				local var_154_17 = Color.New(1, 1, 1)

				var_154_17.a = Mathf.Lerp(1, 0, var_154_16)
				arg_151_1.mask_.color = var_154_17
			end

			if arg_151_1.time_ >= var_154_14 + var_154_15 and arg_151_1.time_ < var_154_14 + var_154_15 + arg_154_0 then
				local var_154_18 = Color.New(1, 1, 1)
				local var_154_19 = 0

				arg_151_1.mask_.enabled = false
				var_154_18.a = var_154_19
				arg_151_1.mask_.color = var_154_18
			end

			local var_154_20 = 1.8
			local var_154_21 = 1.575

			if var_154_20 < arg_151_1.time_ and arg_151_1.time_ <= var_154_20 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, false)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_22 = arg_151_1:GetWordFromCfg(321332035)
				local var_154_23 = arg_151_1:FormatText(var_154_22.content)

				arg_151_1.text_.text = var_154_23

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_24 = 63
				local var_154_25 = utf8.len(var_154_23)
				local var_154_26 = var_154_24 <= 0 and var_154_21 or var_154_21 * (var_154_25 / var_154_24)

				if var_154_26 > 0 and var_154_21 < var_154_26 then
					arg_151_1.talkMaxDuration = var_154_26

					if var_154_26 + var_154_20 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_26 + var_154_20
					end
				end

				arg_151_1.text_.text = var_154_23
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)
				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_27 = math.max(var_154_21, arg_151_1.talkMaxDuration)

			if var_154_20 <= arg_151_1.time_ and arg_151_1.time_ < var_154_20 + var_154_27 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_20) / var_154_27

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_20 + var_154_27 and arg_151_1.time_ < var_154_20 + var_154_27 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
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
	Play321332036 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 321332036
		arg_155_1.duration_ = 5.97

		local var_155_0 = {
			zh = 4.833,
			ja = 5.966
		}
		local var_155_1 = manager.audio:GetLocalizationFlag()

		if var_155_0[var_155_1] ~= nil then
			arg_155_1.duration_ = var_155_0[var_155_1]
		end

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play321332037(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = 0
			local var_158_1 = 0.225

			if var_158_0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_0 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				local var_158_2 = arg_155_1:FormatText(StoryNameCfg[600].name)

				arg_155_1.leftNameTxt_.text = var_158_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_3 = arg_155_1:GetWordFromCfg(321332036)
				local var_158_4 = arg_155_1:FormatText(var_158_3.content)

				arg_155_1.text_.text = var_158_4

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_5 = 9
				local var_158_6 = utf8.len(var_158_4)
				local var_158_7 = var_158_5 <= 0 and var_158_1 or var_158_1 * (var_158_6 / var_158_5)

				if var_158_7 > 0 and var_158_1 < var_158_7 then
					arg_155_1.talkMaxDuration = var_158_7

					if var_158_7 + var_158_0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_7 + var_158_0
					end
				end

				arg_155_1.text_.text = var_158_4
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332036", "story_v_out_321332.awb") ~= 0 then
					local var_158_8 = manager.audio:GetVoiceLength("story_v_out_321332", "321332036", "story_v_out_321332.awb") / 1000

					if var_158_8 + var_158_0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_8 + var_158_0
					end

					if var_158_3.prefab_name ~= "" and arg_155_1.actors_[var_158_3.prefab_name] ~= nil then
						local var_158_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_3.prefab_name].transform, "story_v_out_321332", "321332036", "story_v_out_321332.awb")

						arg_155_1:RecordAudio("321332036", var_158_9)
						arg_155_1:RecordAudio("321332036", var_158_9)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_321332", "321332036", "story_v_out_321332.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_321332", "321332036", "story_v_out_321332.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_10 = math.max(var_158_1, arg_155_1.talkMaxDuration)

			if var_158_0 <= arg_155_1.time_ and arg_155_1.time_ < var_158_0 + var_158_10 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_0) / var_158_10

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_0 + var_158_10 and arg_155_1.time_ < var_158_0 + var_158_10 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play321332037 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 321332037
		arg_159_1.duration_ = 7.43

		local var_159_0 = {
			zh = 7.433,
			ja = 6.766
		}
		local var_159_1 = manager.audio:GetLocalizationFlag()

		if var_159_0[var_159_1] ~= nil then
			arg_159_1.duration_ = var_159_0[var_159_1]
		end

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play321332038(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = 0
			local var_162_1 = 0.2

			if var_162_0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_0 + arg_162_0 then
				local var_162_2 = "play"
				local var_162_3 = "music"

				arg_159_1:AudioAction(var_162_2, var_162_3, "ui_battle", "ui_battle_stopbgm", "")

				local var_162_4 = ""
				local var_162_5 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_162_5 ~= "" then
					if arg_159_1.bgmTxt_.text ~= var_162_5 and arg_159_1.bgmTxt_.text ~= "" then
						if arg_159_1.bgmTxt2_.text ~= "" then
							arg_159_1.bgmTxt_.text = arg_159_1.bgmTxt2_.text
						end

						arg_159_1.bgmTxt2_.text = var_162_5

						arg_159_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_159_1.bgmTxt_.text = var_162_5
						arg_159_1.bgmTxt2_.text = var_162_5
					end

					if arg_159_1.bgmTimer then
						arg_159_1.bgmTimer:Stop()

						arg_159_1.bgmTimer = nil
					end

					if arg_159_1.settingData.show_music_name == 1 then
						arg_159_1.musicController:SetSelectedState("show")
						arg_159_1.musicAnimator_:Play("open", 0, 0)

						if arg_159_1.settingData.music_time ~= 0 then
							arg_159_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_159_1.settingData.music_time), function()
								if arg_159_1 == nil or isNil(arg_159_1.bgmTxt_) then
									return
								end

								arg_159_1.musicController:SetSelectedState("hide")
								arg_159_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_162_6 = 0
			local var_162_7 = 0.375

			if var_162_6 < arg_159_1.time_ and arg_159_1.time_ <= var_162_6 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				local var_162_8 = arg_159_1:FormatText(StoryNameCfg[600].name)

				arg_159_1.leftNameTxt_.text = var_162_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_9 = arg_159_1:GetWordFromCfg(321332037)
				local var_162_10 = arg_159_1:FormatText(var_162_9.content)

				arg_159_1.text_.text = var_162_10

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_11 = 15
				local var_162_12 = utf8.len(var_162_10)
				local var_162_13 = var_162_11 <= 0 and var_162_7 or var_162_7 * (var_162_12 / var_162_11)

				if var_162_13 > 0 and var_162_7 < var_162_13 then
					arg_159_1.talkMaxDuration = var_162_13

					if var_162_13 + var_162_6 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_13 + var_162_6
					end
				end

				arg_159_1.text_.text = var_162_10
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332037", "story_v_out_321332.awb") ~= 0 then
					local var_162_14 = manager.audio:GetVoiceLength("story_v_out_321332", "321332037", "story_v_out_321332.awb") / 1000

					if var_162_14 + var_162_6 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_14 + var_162_6
					end

					if var_162_9.prefab_name ~= "" and arg_159_1.actors_[var_162_9.prefab_name] ~= nil then
						local var_162_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_9.prefab_name].transform, "story_v_out_321332", "321332037", "story_v_out_321332.awb")

						arg_159_1:RecordAudio("321332037", var_162_15)
						arg_159_1:RecordAudio("321332037", var_162_15)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_321332", "321332037", "story_v_out_321332.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_321332", "321332037", "story_v_out_321332.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_16 = math.max(var_162_7, arg_159_1.talkMaxDuration)

			if var_162_6 <= arg_159_1.time_ and arg_159_1.time_ < var_162_6 + var_162_16 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_6) / var_162_16

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_6 + var_162_16 and arg_159_1.time_ < var_162_6 + var_162_16 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play321332038 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 321332038
		arg_164_1.duration_ = 5

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play321332039(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = 0.15
			local var_167_1 = 1

			if var_167_0 < arg_164_1.time_ and arg_164_1.time_ <= var_167_0 + arg_167_0 then
				local var_167_2 = "play"
				local var_167_3 = "effect"

				arg_164_1:AudioAction(var_167_2, var_167_3, "se_story_141", "se_story_141_boxing_whoosh01", "")
			end

			local var_167_4 = 0
			local var_167_5 = 1

			if var_167_4 < arg_164_1.time_ and arg_164_1.time_ <= var_167_4 + arg_167_0 then
				local var_167_6 = "stop"
				local var_167_7 = "effect"

				arg_164_1:AudioAction(var_167_6, var_167_7, "se_story_141", "se_story_141_amb_bass", "")
			end

			local var_167_8 = 0
			local var_167_9 = 1.15

			if var_167_8 < arg_164_1.time_ and arg_164_1.time_ <= var_167_8 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, false)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_10 = arg_164_1:GetWordFromCfg(321332038)
				local var_167_11 = arg_164_1:FormatText(var_167_10.content)

				arg_164_1.text_.text = var_167_11

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_12 = 46
				local var_167_13 = utf8.len(var_167_11)
				local var_167_14 = var_167_12 <= 0 and var_167_9 or var_167_9 * (var_167_13 / var_167_12)

				if var_167_14 > 0 and var_167_9 < var_167_14 then
					arg_164_1.talkMaxDuration = var_167_14

					if var_167_14 + var_167_8 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_14 + var_167_8
					end
				end

				arg_164_1.text_.text = var_167_11
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)
				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_15 = math.max(var_167_9, arg_164_1.talkMaxDuration)

			if var_167_8 <= arg_164_1.time_ and arg_164_1.time_ < var_167_8 + var_167_15 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_8) / var_167_15

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_8 + var_167_15 and arg_164_1.time_ < var_167_8 + var_167_15 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {}

		arg_164_1:InitPlayNodeList()
	end,
	Play321332039 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 321332039
		arg_168_1.duration_ = 11.22

		local var_168_0 = {
			zh = 9.216,
			ja = 11.216
		}
		local var_168_1 = manager.audio:GetLocalizationFlag()

		if var_168_0[var_168_1] ~= nil then
			arg_168_1.duration_ = var_168_0[var_168_1]
		end

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play321332040(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			local var_171_0 = "STwhite"

			if arg_168_1.bgs_[var_171_0] == nil then
				local var_171_1 = Object.Instantiate(arg_168_1.paintGo_)

				var_171_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_171_0)
				var_171_1.name = var_171_0
				var_171_1.transform.parent = arg_168_1.stage_.transform
				var_171_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_168_1.bgs_[var_171_0] = var_171_1
			end

			local var_171_2 = 0.5

			if var_171_2 < arg_168_1.time_ and arg_168_1.time_ <= var_171_2 + arg_171_0 then
				local var_171_3 = manager.ui.mainCamera.transform.localPosition
				local var_171_4 = Vector3.New(0, 0, 10) + Vector3.New(var_171_3.x, var_171_3.y, 0)
				local var_171_5 = arg_168_1.bgs_.STwhite

				var_171_5.transform.localPosition = var_171_4
				var_171_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_171_6 = var_171_5:GetComponent("SpriteRenderer")

				if var_171_6 and var_171_6.sprite then
					local var_171_7 = (var_171_5.transform.localPosition - var_171_3).z
					local var_171_8 = manager.ui.mainCameraCom_
					local var_171_9 = 2 * var_171_7 * Mathf.Tan(var_171_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_171_10 = var_171_9 * var_171_8.aspect
					local var_171_11 = var_171_6.sprite.bounds.size.x
					local var_171_12 = var_171_6.sprite.bounds.size.y
					local var_171_13 = var_171_10 / var_171_11
					local var_171_14 = var_171_9 / var_171_12
					local var_171_15 = var_171_14 < var_171_13 and var_171_13 or var_171_14

					var_171_5.transform.localScale = Vector3.New(var_171_15, var_171_15, 0)
				end

				for iter_171_0, iter_171_1 in pairs(arg_168_1.bgs_) do
					if iter_171_0 ~= "STwhite" then
						iter_171_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_171_16 = 0

			if var_171_16 < arg_168_1.time_ and arg_168_1.time_ <= var_171_16 + arg_171_0 then
				arg_168_1.mask_.enabled = true
				arg_168_1.mask_.raycastTarget = true

				arg_168_1:SetGaussion(false)
			end

			local var_171_17 = 0.5

			if var_171_16 <= arg_168_1.time_ and arg_168_1.time_ < var_171_16 + var_171_17 then
				local var_171_18 = (arg_168_1.time_ - var_171_16) / var_171_17
				local var_171_19 = Color.New(1, 1, 1)

				var_171_19.a = Mathf.Lerp(0, 1, var_171_18)
				arg_168_1.mask_.color = var_171_19
			end

			if arg_168_1.time_ >= var_171_16 + var_171_17 and arg_168_1.time_ < var_171_16 + var_171_17 + arg_171_0 then
				local var_171_20 = Color.New(1, 1, 1)

				var_171_20.a = 1
				arg_168_1.mask_.color = var_171_20
			end

			local var_171_21 = 0.5

			if var_171_21 < arg_168_1.time_ and arg_168_1.time_ <= var_171_21 + arg_171_0 then
				arg_168_1.mask_.enabled = true
				arg_168_1.mask_.raycastTarget = true

				arg_168_1:SetGaussion(false)
			end

			local var_171_22 = 3

			if var_171_21 <= arg_168_1.time_ and arg_168_1.time_ < var_171_21 + var_171_22 then
				local var_171_23 = (arg_168_1.time_ - var_171_21) / var_171_22
				local var_171_24 = Color.New(1, 1, 1)

				var_171_24.a = Mathf.Lerp(1, 0, var_171_23)
				arg_168_1.mask_.color = var_171_24
			end

			if arg_168_1.time_ >= var_171_21 + var_171_22 and arg_168_1.time_ < var_171_21 + var_171_22 + arg_171_0 then
				local var_171_25 = Color.New(1, 1, 1)
				local var_171_26 = 0

				arg_168_1.mask_.enabled = false
				var_171_25.a = var_171_26
				arg_168_1.mask_.color = var_171_25
			end

			local var_171_27 = manager.ui.mainCamera.transform
			local var_171_28 = 0

			if var_171_28 < arg_168_1.time_ and arg_168_1.time_ <= var_171_28 + arg_171_0 then
				local var_171_29 = arg_168_1.var_.effectluobonazhengzha1
				local var_171_30
				local var_171_31 = var_171_27

				if not var_171_29 then
					var_171_29 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), var_171_31)
					var_171_29.name = "luobonazhengzha1"
					arg_168_1.var_.effectluobonazhengzha1 = var_171_29
				else
					var_171_29.transform:SetParent(var_171_31)
				end

				var_171_29.transform.localPosition = Vector3.New(0, 0, 0)
				var_171_29.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_171_32 = manager.ui.mainCamera.transform
			local var_171_33 = 2

			if var_171_33 < arg_168_1.time_ and arg_168_1.time_ <= var_171_33 + arg_171_0 then
				local var_171_34 = arg_168_1.var_.effectluobonazhengzha1

				if var_171_34 then
					Object.Destroy(var_171_34)

					arg_168_1.var_.effectluobonazhengzha1 = nil
				end
			end

			local var_171_35 = manager.ui.mainCamera.transform
			local var_171_36 = 0.5

			if var_171_36 < arg_168_1.time_ and arg_168_1.time_ <= var_171_36 + arg_171_0 then
				local var_171_37 = arg_168_1.var_.effectluobonaend2

				if var_171_37 then
					Object.Destroy(var_171_37)

					arg_168_1.var_.effectluobonaend2 = nil
				end
			end

			local var_171_38 = 0
			local var_171_39 = 1

			if var_171_38 < arg_168_1.time_ and arg_168_1.time_ <= var_171_38 + arg_171_0 then
				local var_171_40 = "play"
				local var_171_41 = "effect"

				arg_168_1:AudioAction(var_171_40, var_171_41, "se_story_141", "se_story_141_amb_boxing_cheer01", "")
			end

			local var_171_42 = 2.517
			local var_171_43 = 1

			if var_171_42 < arg_168_1.time_ and arg_168_1.time_ <= var_171_42 + arg_171_0 then
				local var_171_44 = "play"
				local var_171_45 = "effect"

				arg_168_1:AudioAction(var_171_44, var_171_45, "se_story_141", "se_story_141_boxing_amb_hit01_loop", "")
			end

			if arg_168_1.frameCnt_ <= 1 then
				arg_168_1.dialog_:SetActive(false)
			end

			local var_171_46 = 3.15
			local var_171_47 = 0.35

			if var_171_46 < arg_168_1.time_ and arg_168_1.time_ <= var_171_46 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0

				arg_168_1.dialog_:SetActive(true)

				arg_168_1.dialogCg_.alpha = 0

				local var_171_48 = LeanTween.value(arg_168_1.dialog_, 0, 1, 0.3)

				var_171_48:setOnUpdate(LuaHelper.FloatAction(function(arg_172_0)
					arg_168_1.dialogCg_.alpha = arg_172_0
				end))
				var_171_48:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_168_1.dialog_)
					var_171_48:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_168_1.duration_ = arg_168_1.duration_ + 0.3

				SetActive(arg_168_1.leftNameGo_, true)

				local var_171_49 = arg_168_1:FormatText(StoryNameCfg[600].name)

				arg_168_1.leftNameTxt_.text = var_171_49

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, true)
				arg_168_1.iconController_:SetSelectedState("hero")

				arg_168_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4032")

				arg_168_1.callingController_:SetSelectedState("normal")

				arg_168_1.keyicon_.color = Color.New(1, 1, 1)
				arg_168_1.icon_.color = Color.New(1, 1, 1)

				local var_171_50 = arg_168_1:GetWordFromCfg(321332039)
				local var_171_51 = arg_168_1:FormatText(var_171_50.content)

				arg_168_1.text_.text = var_171_51

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_52 = 14
				local var_171_53 = utf8.len(var_171_51)
				local var_171_54 = var_171_52 <= 0 and var_171_47 or var_171_47 * (var_171_53 / var_171_52)

				if var_171_54 > 0 and var_171_47 < var_171_54 then
					arg_168_1.talkMaxDuration = var_171_54
					var_171_46 = var_171_46 + 0.3

					if var_171_54 + var_171_46 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_54 + var_171_46
					end
				end

				arg_168_1.text_.text = var_171_51
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332039", "story_v_out_321332.awb") ~= 0 then
					local var_171_55 = manager.audio:GetVoiceLength("story_v_out_321332", "321332039", "story_v_out_321332.awb") / 1000

					if var_171_55 + var_171_46 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_55 + var_171_46
					end

					if var_171_50.prefab_name ~= "" and arg_168_1.actors_[var_171_50.prefab_name] ~= nil then
						local var_171_56 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_50.prefab_name].transform, "story_v_out_321332", "321332039", "story_v_out_321332.awb")

						arg_168_1:RecordAudio("321332039", var_171_56)
						arg_168_1:RecordAudio("321332039", var_171_56)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_out_321332", "321332039", "story_v_out_321332.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_out_321332", "321332039", "story_v_out_321332.awb")
				end

				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_57 = var_171_46 + 0.3
			local var_171_58 = math.max(var_171_47, arg_168_1.talkMaxDuration)

			if var_171_57 <= arg_168_1.time_ and arg_168_1.time_ < var_171_57 + var_171_58 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_57) / var_171_58

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_57 + var_171_58 and arg_168_1.time_ < var_171_57 + var_171_58 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {}

		arg_168_1:InitPlayNodeList()
	end,
	Play321332040 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 321332040
		arg_174_1.duration_ = 5

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play321332041(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			local var_177_0 = 0
			local var_177_1 = 1.55

			if var_177_0 < arg_174_1.time_ and arg_174_1.time_ <= var_177_0 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, false)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_2 = arg_174_1:GetWordFromCfg(321332040)
				local var_177_3 = arg_174_1:FormatText(var_177_2.content)

				arg_174_1.text_.text = var_177_3

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_4 = 62
				local var_177_5 = utf8.len(var_177_3)
				local var_177_6 = var_177_4 <= 0 and var_177_1 or var_177_1 * (var_177_5 / var_177_4)

				if var_177_6 > 0 and var_177_1 < var_177_6 then
					arg_174_1.talkMaxDuration = var_177_6

					if var_177_6 + var_177_0 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_6 + var_177_0
					end
				end

				arg_174_1.text_.text = var_177_3
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)
				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_7 = math.max(var_177_1, arg_174_1.talkMaxDuration)

			if var_177_0 <= arg_174_1.time_ and arg_174_1.time_ < var_177_0 + var_177_7 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_0) / var_177_7

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_0 + var_177_7 and arg_174_1.time_ < var_177_0 + var_177_7 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {}

		arg_174_1:InitPlayNodeList()
	end,
	Play321332041 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 321332041
		arg_178_1.duration_ = 9.3

		local var_178_0 = {
			zh = 5.2,
			ja = 9.3
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
				arg_178_0:Play321332042(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			local var_181_0 = 0
			local var_181_1 = 0.375

			if var_181_0 < arg_178_1.time_ and arg_178_1.time_ <= var_181_0 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				local var_181_2 = arg_178_1:FormatText(StoryNameCfg[600].name)

				arg_178_1.leftNameTxt_.text = var_181_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, true)
				arg_178_1.iconController_:SetSelectedState("hero")

				arg_178_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4032")

				arg_178_1.callingController_:SetSelectedState("normal")

				arg_178_1.keyicon_.color = Color.New(1, 1, 1)
				arg_178_1.icon_.color = Color.New(1, 1, 1)

				local var_181_3 = arg_178_1:GetWordFromCfg(321332041)
				local var_181_4 = arg_178_1:FormatText(var_181_3.content)

				arg_178_1.text_.text = var_181_4

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_5 = 15
				local var_181_6 = utf8.len(var_181_4)
				local var_181_7 = var_181_5 <= 0 and var_181_1 or var_181_1 * (var_181_6 / var_181_5)

				if var_181_7 > 0 and var_181_1 < var_181_7 then
					arg_178_1.talkMaxDuration = var_181_7

					if var_181_7 + var_181_0 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_7 + var_181_0
					end
				end

				arg_178_1.text_.text = var_181_4
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332041", "story_v_out_321332.awb") ~= 0 then
					local var_181_8 = manager.audio:GetVoiceLength("story_v_out_321332", "321332041", "story_v_out_321332.awb") / 1000

					if var_181_8 + var_181_0 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_8 + var_181_0
					end

					if var_181_3.prefab_name ~= "" and arg_178_1.actors_[var_181_3.prefab_name] ~= nil then
						local var_181_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_178_1.actors_[var_181_3.prefab_name].transform, "story_v_out_321332", "321332041", "story_v_out_321332.awb")

						arg_178_1:RecordAudio("321332041", var_181_9)
						arg_178_1:RecordAudio("321332041", var_181_9)
					else
						arg_178_1:AudioAction("play", "voice", "story_v_out_321332", "321332041", "story_v_out_321332.awb")
					end

					arg_178_1:RecordHistoryTalkVoice("story_v_out_321332", "321332041", "story_v_out_321332.awb")
				end

				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_10 = math.max(var_181_1, arg_178_1.talkMaxDuration)

			if var_181_0 <= arg_178_1.time_ and arg_178_1.time_ < var_181_0 + var_181_10 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_0) / var_181_10

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_0 + var_181_10 and arg_178_1.time_ < var_181_0 + var_181_10 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {}

		arg_178_1:InitPlayNodeList()
	end,
	Play321332042 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 321332042
		arg_182_1.duration_ = 8.23

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play321332043(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			local var_185_0 = "ST65"

			if arg_182_1.bgs_[var_185_0] == nil then
				local var_185_1 = Object.Instantiate(arg_182_1.paintGo_)

				var_185_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_185_0)
				var_185_1.name = var_185_0
				var_185_1.transform.parent = arg_182_1.stage_.transform
				var_185_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_182_1.bgs_[var_185_0] = var_185_1
			end

			local var_185_2 = 2.33333333333333

			if var_185_2 < arg_182_1.time_ and arg_182_1.time_ <= var_185_2 + arg_185_0 then
				local var_185_3 = manager.ui.mainCamera.transform.localPosition
				local var_185_4 = Vector3.New(0, 0, 10) + Vector3.New(var_185_3.x, var_185_3.y, 0)
				local var_185_5 = arg_182_1.bgs_.ST65

				var_185_5.transform.localPosition = var_185_4
				var_185_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_185_6 = var_185_5:GetComponent("SpriteRenderer")

				if var_185_6 and var_185_6.sprite then
					local var_185_7 = (var_185_5.transform.localPosition - var_185_3).z
					local var_185_8 = manager.ui.mainCameraCom_
					local var_185_9 = 2 * var_185_7 * Mathf.Tan(var_185_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_185_10 = var_185_9 * var_185_8.aspect
					local var_185_11 = var_185_6.sprite.bounds.size.x
					local var_185_12 = var_185_6.sprite.bounds.size.y
					local var_185_13 = var_185_10 / var_185_11
					local var_185_14 = var_185_9 / var_185_12
					local var_185_15 = var_185_14 < var_185_13 and var_185_13 or var_185_14

					var_185_5.transform.localScale = Vector3.New(var_185_15, var_185_15, 0)
				end

				for iter_185_0, iter_185_1 in pairs(arg_182_1.bgs_) do
					if iter_185_0 ~= "ST65" then
						iter_185_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_185_16 = 2.83333333333333

			if var_185_16 < arg_182_1.time_ and arg_182_1.time_ <= var_185_16 + arg_185_0 then
				arg_182_1.allBtn_.enabled = false
			end

			local var_185_17 = 0.3

			if arg_182_1.time_ >= var_185_16 + var_185_17 and arg_182_1.time_ < var_185_16 + var_185_17 + arg_185_0 then
				arg_182_1.allBtn_.enabled = true
			end

			local var_185_18 = manager.ui.mainCamera.transform
			local var_185_19 = 0.833333333333333

			if var_185_19 < arg_182_1.time_ and arg_182_1.time_ <= var_185_19 + arg_185_0 then
				local var_185_20 = arg_182_1.var_.effectluobonazhuanchang1
				local var_185_21
				local var_185_22 = var_185_18

				if not var_185_20 then
					var_185_20 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zxuanguang_in_keep"), var_185_22)
					var_185_20.name = "luobonazhuanchang1"
					arg_182_1.var_.effectluobonazhuanchang1 = var_185_20
				else
					var_185_20.transform:SetParent(var_185_22)
				end

				var_185_20.transform.localPosition = Vector3.New(0, 0, 0)
				var_185_20.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_185_23 = manager.ui.mainCamera.transform
			local var_185_24 = 2.33333333333333

			if var_185_24 < arg_182_1.time_ and arg_182_1.time_ <= var_185_24 + arg_185_0 then
				local var_185_25 = arg_182_1.var_.effectluobonazhuanchang2
				local var_185_26
				local var_185_27 = var_185_23

				if not var_185_25 then
					var_185_25 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zxuanguang_out"), var_185_27)
					var_185_25.name = "luobonazhuanchang2"
					arg_182_1.var_.effectluobonazhuanchang2 = var_185_25
				else
					var_185_25.transform:SetParent(var_185_27)
				end

				var_185_25.transform.localPosition = Vector3.New(0, 0, 0)
				var_185_25.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_185_28 = manager.ui.mainCamera.transform
			local var_185_29 = 2.33333333333333

			if var_185_29 < arg_182_1.time_ and arg_182_1.time_ <= var_185_29 + arg_185_0 then
				local var_185_30 = arg_182_1.var_.effectluobonazhuanchang1

				if var_185_30 then
					Object.Destroy(var_185_30)

					arg_182_1.var_.effectluobonazhuanchang1 = nil
				end
			end

			local var_185_31 = manager.ui.mainCamera.transform
			local var_185_32 = 2.33333333333333

			if var_185_32 < arg_182_1.time_ and arg_182_1.time_ <= var_185_32 + arg_185_0 then
				local var_185_33 = arg_182_1.var_.effectluobonazhuanchang3
				local var_185_34
				local var_185_35 = var_185_31

				if not var_185_33 then
					var_185_33 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_rain_heavymax_ui"), var_185_35)
					var_185_33.name = "luobonazhuanchang3"
					arg_182_1.var_.effectluobonazhuanchang3 = var_185_33
				else
					var_185_33.transform:SetParent(var_185_35)
				end

				var_185_33.transform.localPosition = Vector3.New(0, 0, 0)
				var_185_33.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_185_36 = 0
			local var_185_37 = 1

			if var_185_36 < arg_182_1.time_ and arg_182_1.time_ <= var_185_36 + arg_185_0 then
				local var_185_38 = "play"
				local var_185_39 = "effect"

				arg_182_1:AudioAction(var_185_38, var_185_39, "se_story_141", "se_story_141_boxing_whoosh02", "")
			end

			local var_185_40 = 0
			local var_185_41 = 1

			if var_185_40 < arg_182_1.time_ and arg_182_1.time_ <= var_185_40 + arg_185_0 then
				local var_185_42 = "stop"
				local var_185_43 = "effect"

				arg_182_1:AudioAction(var_185_42, var_185_43, "se_story_141", "se_story_141_boxing_amb_hit01_loop", "")
			end

			local var_185_44 = 1.732
			local var_185_45 = 1

			if var_185_44 < arg_182_1.time_ and arg_182_1.time_ <= var_185_44 + arg_185_0 then
				local var_185_46 = "stop"
				local var_185_47 = "effect"

				arg_182_1:AudioAction(var_185_46, var_185_47, "se_story_141", "se_story_141_amb_boxing_cheer01", "")
			end

			local var_185_48 = 2.168
			local var_185_49 = 1

			if var_185_48 < arg_182_1.time_ and arg_182_1.time_ <= var_185_48 + arg_185_0 then
				local var_185_50 = "play"
				local var_185_51 = "effect"

				arg_182_1:AudioAction(var_185_50, var_185_51, "se_story_141", "se_story_141_amb_boxing_cheer02", "")
			end

			local var_185_52 = 2.954
			local var_185_53 = 1

			if var_185_52 < arg_182_1.time_ and arg_182_1.time_ <= var_185_52 + arg_185_0 then
				local var_185_54 = "play"
				local var_185_55 = "effect"

				arg_182_1:AudioAction(var_185_54, var_185_55, "se_story_141", "se_story_141_boxing_amb_hit02_loop", "")
			end

			if arg_182_1.frameCnt_ <= 1 then
				arg_182_1.dialog_:SetActive(false)
			end

			local var_185_56 = 3.23333333333333
			local var_185_57 = 0.525

			if var_185_56 < arg_182_1.time_ and arg_182_1.time_ <= var_185_56 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0

				arg_182_1.dialog_:SetActive(true)

				arg_182_1.dialogCg_.alpha = 0

				local var_185_58 = LeanTween.value(arg_182_1.dialog_, 0, 1, 0.3)

				var_185_58:setOnUpdate(LuaHelper.FloatAction(function(arg_186_0)
					arg_182_1.dialogCg_.alpha = arg_186_0
				end))
				var_185_58:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_182_1.dialog_)
					var_185_58:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_182_1.duration_ = arg_182_1.duration_ + 0.3

				SetActive(arg_182_1.leftNameGo_, false)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_59 = arg_182_1:GetWordFromCfg(321332042)
				local var_185_60 = arg_182_1:FormatText(var_185_59.content)

				arg_182_1.text_.text = var_185_60

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_61 = 21
				local var_185_62 = utf8.len(var_185_60)
				local var_185_63 = var_185_61 <= 0 and var_185_57 or var_185_57 * (var_185_62 / var_185_61)

				if var_185_63 > 0 and var_185_57 < var_185_63 then
					arg_182_1.talkMaxDuration = var_185_63
					var_185_56 = var_185_56 + 0.3

					if var_185_63 + var_185_56 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_63 + var_185_56
					end
				end

				arg_182_1.text_.text = var_185_60
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)
				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_64 = var_185_56 + 0.3
			local var_185_65 = math.max(var_185_57, arg_182_1.talkMaxDuration)

			if var_185_64 <= arg_182_1.time_ and arg_182_1.time_ < var_185_64 + var_185_65 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_64) / var_185_65

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_64 + var_185_65 and arg_182_1.time_ < var_185_64 + var_185_65 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {}

		arg_182_1:InitPlayNodeList()
	end,
	Play321332043 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 321332043
		arg_188_1.duration_ = 5

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play321332044(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			local var_191_0 = 0
			local var_191_1 = 1.3

			if var_191_0 < arg_188_1.time_ and arg_188_1.time_ <= var_191_0 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, false)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_2 = arg_188_1:GetWordFromCfg(321332043)
				local var_191_3 = arg_188_1:FormatText(var_191_2.content)

				arg_188_1.text_.text = var_191_3

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_4 = 52
				local var_191_5 = utf8.len(var_191_3)
				local var_191_6 = var_191_4 <= 0 and var_191_1 or var_191_1 * (var_191_5 / var_191_4)

				if var_191_6 > 0 and var_191_1 < var_191_6 then
					arg_188_1.talkMaxDuration = var_191_6

					if var_191_6 + var_191_0 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_6 + var_191_0
					end
				end

				arg_188_1.text_.text = var_191_3
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)
				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_7 = math.max(var_191_1, arg_188_1.talkMaxDuration)

			if var_191_0 <= arg_188_1.time_ and arg_188_1.time_ < var_191_0 + var_191_7 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_0) / var_191_7

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_0 + var_191_7 and arg_188_1.time_ < var_191_0 + var_191_7 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {}

		arg_188_1:InitPlayNodeList()
	end,
	Play321332044 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 321332044
		arg_192_1.duration_ = 5

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play321332045(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			local var_195_0 = 0
			local var_195_1 = 1.05

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

				local var_195_2 = arg_192_1:GetWordFromCfg(321332044)
				local var_195_3 = arg_192_1:FormatText(var_195_2.content)

				arg_192_1.text_.text = var_195_3

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_4 = 42
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
	Play321332045 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 321332045
		arg_196_1.duration_ = 6.33

		local var_196_0 = {
			zh = 6.333,
			ja = 6.166
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
				arg_196_0:Play321332046(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			local var_199_0 = 0
			local var_199_1 = 0.35

			if var_199_0 < arg_196_1.time_ and arg_196_1.time_ <= var_199_0 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, true)

				local var_199_2 = arg_196_1:FormatText(StoryNameCfg[600].name)

				arg_196_1.leftNameTxt_.text = var_199_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, true)
				arg_196_1.iconController_:SetSelectedState("hero")

				arg_196_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadow10017")

				arg_196_1.callingController_:SetSelectedState("normal")

				arg_196_1.keyicon_.color = Color.New(1, 1, 1)
				arg_196_1.icon_.color = Color.New(1, 1, 1)

				local var_199_3 = arg_196_1:GetWordFromCfg(321332045)
				local var_199_4 = arg_196_1:FormatText(var_199_3.content)

				arg_196_1.text_.text = var_199_4

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_5 = 14
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

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332045", "story_v_out_321332.awb") ~= 0 then
					local var_199_8 = manager.audio:GetVoiceLength("story_v_out_321332", "321332045", "story_v_out_321332.awb") / 1000

					if var_199_8 + var_199_0 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_8 + var_199_0
					end

					if var_199_3.prefab_name ~= "" and arg_196_1.actors_[var_199_3.prefab_name] ~= nil then
						local var_199_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_196_1.actors_[var_199_3.prefab_name].transform, "story_v_out_321332", "321332045", "story_v_out_321332.awb")

						arg_196_1:RecordAudio("321332045", var_199_9)
						arg_196_1:RecordAudio("321332045", var_199_9)
					else
						arg_196_1:AudioAction("play", "voice", "story_v_out_321332", "321332045", "story_v_out_321332.awb")
					end

					arg_196_1:RecordHistoryTalkVoice("story_v_out_321332", "321332045", "story_v_out_321332.awb")
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
	Play321332046 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 321332046
		arg_200_1.duration_ = 5

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play321332047(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			local var_203_0 = 0
			local var_203_1 = 1.65

			if var_203_0 < arg_200_1.time_ and arg_200_1.time_ <= var_203_0 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, false)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_2 = arg_200_1:GetWordFromCfg(321332046)
				local var_203_3 = arg_200_1:FormatText(var_203_2.content)

				arg_200_1.text_.text = var_203_3

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_4 = 66
				local var_203_5 = utf8.len(var_203_3)
				local var_203_6 = var_203_4 <= 0 and var_203_1 or var_203_1 * (var_203_5 / var_203_4)

				if var_203_6 > 0 and var_203_1 < var_203_6 then
					arg_200_1.talkMaxDuration = var_203_6

					if var_203_6 + var_203_0 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_6 + var_203_0
					end
				end

				arg_200_1.text_.text = var_203_3
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)
				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_7 = math.max(var_203_1, arg_200_1.talkMaxDuration)

			if var_203_0 <= arg_200_1.time_ and arg_200_1.time_ < var_203_0 + var_203_7 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_0) / var_203_7

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_0 + var_203_7 and arg_200_1.time_ < var_203_0 + var_203_7 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {}

		arg_200_1:InitPlayNodeList()
	end,
	Play321332047 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 321332047
		arg_204_1.duration_ = 9.9

		local var_204_0 = {
			zh = 6.5,
			ja = 9.9
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
				arg_204_0:Play321332048(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			local var_207_0 = 0
			local var_207_1 = 0.45

			if var_207_0 < arg_204_1.time_ and arg_204_1.time_ <= var_207_0 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				local var_207_2 = arg_204_1:FormatText(StoryNameCfg[1211].name)

				arg_204_1.leftNameTxt_.text = var_207_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, true)
				arg_204_1.iconController_:SetSelectedState("hero")

				arg_204_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadow10035_split_1")

				arg_204_1.callingController_:SetSelectedState("normal")

				arg_204_1.keyicon_.color = Color.New(1, 1, 1)
				arg_204_1.icon_.color = Color.New(1, 1, 1)

				local var_207_3 = arg_204_1:GetWordFromCfg(321332047)
				local var_207_4 = arg_204_1:FormatText(var_207_3.content)

				arg_204_1.text_.text = var_207_4

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_5 = 18
				local var_207_6 = utf8.len(var_207_4)
				local var_207_7 = var_207_5 <= 0 and var_207_1 or var_207_1 * (var_207_6 / var_207_5)

				if var_207_7 > 0 and var_207_1 < var_207_7 then
					arg_204_1.talkMaxDuration = var_207_7

					if var_207_7 + var_207_0 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_7 + var_207_0
					end
				end

				arg_204_1.text_.text = var_207_4
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332047", "story_v_out_321332.awb") ~= 0 then
					local var_207_8 = manager.audio:GetVoiceLength("story_v_out_321332", "321332047", "story_v_out_321332.awb") / 1000

					if var_207_8 + var_207_0 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_8 + var_207_0
					end

					if var_207_3.prefab_name ~= "" and arg_204_1.actors_[var_207_3.prefab_name] ~= nil then
						local var_207_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_204_1.actors_[var_207_3.prefab_name].transform, "story_v_out_321332", "321332047", "story_v_out_321332.awb")

						arg_204_1:RecordAudio("321332047", var_207_9)
						arg_204_1:RecordAudio("321332047", var_207_9)
					else
						arg_204_1:AudioAction("play", "voice", "story_v_out_321332", "321332047", "story_v_out_321332.awb")
					end

					arg_204_1:RecordHistoryTalkVoice("story_v_out_321332", "321332047", "story_v_out_321332.awb")
				end

				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_10 = math.max(var_207_1, arg_204_1.talkMaxDuration)

			if var_207_0 <= arg_204_1.time_ and arg_204_1.time_ < var_207_0 + var_207_10 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_0) / var_207_10

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_0 + var_207_10 and arg_204_1.time_ < var_207_0 + var_207_10 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {}

		arg_204_1:InitPlayNodeList()
	end,
	Play321332048 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 321332048
		arg_208_1.duration_ = 8.8

		local var_208_0 = {
			zh = 8.4,
			ja = 8.8
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
				arg_208_0:Play321332049(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			local var_211_0 = 5.441
			local var_211_1 = 1

			if var_211_0 < arg_208_1.time_ and arg_208_1.time_ <= var_211_0 + arg_211_0 then
				local var_211_2 = "play"
				local var_211_3 = "effect"

				arg_208_1:AudioAction(var_211_2, var_211_3, "se_story_141", "se_story_141_boxing_fight01", "")
			end

			local var_211_4 = 0.05
			local var_211_5 = 1

			if var_211_4 < arg_208_1.time_ and arg_208_1.time_ <= var_211_4 + arg_211_0 then
				local var_211_6 = "stop"
				local var_211_7 = "effect"

				arg_208_1:AudioAction(var_211_6, var_211_7, "se_story_141", "se_story_141_boxing_amb_hit02_loop", "")
			end

			local var_211_8 = 0
			local var_211_9 = 0.575

			if var_211_8 < arg_208_1.time_ and arg_208_1.time_ <= var_211_8 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, true)

				local var_211_10 = arg_208_1:FormatText(StoryNameCfg[600].name)

				arg_208_1.leftNameTxt_.text = var_211_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_208_1.leftNameTxt_.transform)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1.leftNameTxt_.text)
				SetActive(arg_208_1.iconTrs_.gameObject, true)
				arg_208_1.iconController_:SetSelectedState("hero")

				arg_208_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadow10017")

				arg_208_1.callingController_:SetSelectedState("normal")

				arg_208_1.keyicon_.color = Color.New(1, 1, 1)
				arg_208_1.icon_.color = Color.New(1, 1, 1)

				local var_211_11 = arg_208_1:GetWordFromCfg(321332048)
				local var_211_12 = arg_208_1:FormatText(var_211_11.content)

				arg_208_1.text_.text = var_211_12

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_13 = 23
				local var_211_14 = utf8.len(var_211_12)
				local var_211_15 = var_211_13 <= 0 and var_211_9 or var_211_9 * (var_211_14 / var_211_13)

				if var_211_15 > 0 and var_211_9 < var_211_15 then
					arg_208_1.talkMaxDuration = var_211_15

					if var_211_15 + var_211_8 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_15 + var_211_8
					end
				end

				arg_208_1.text_.text = var_211_12
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332048", "story_v_out_321332.awb") ~= 0 then
					local var_211_16 = manager.audio:GetVoiceLength("story_v_out_321332", "321332048", "story_v_out_321332.awb") / 1000

					if var_211_16 + var_211_8 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_16 + var_211_8
					end

					if var_211_11.prefab_name ~= "" and arg_208_1.actors_[var_211_11.prefab_name] ~= nil then
						local var_211_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_208_1.actors_[var_211_11.prefab_name].transform, "story_v_out_321332", "321332048", "story_v_out_321332.awb")

						arg_208_1:RecordAudio("321332048", var_211_17)
						arg_208_1:RecordAudio("321332048", var_211_17)
					else
						arg_208_1:AudioAction("play", "voice", "story_v_out_321332", "321332048", "story_v_out_321332.awb")
					end

					arg_208_1:RecordHistoryTalkVoice("story_v_out_321332", "321332048", "story_v_out_321332.awb")
				end

				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_18 = math.max(var_211_9, arg_208_1.talkMaxDuration)

			if var_211_8 <= arg_208_1.time_ and arg_208_1.time_ < var_211_8 + var_211_18 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_8) / var_211_18

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_8 + var_211_18 and arg_208_1.time_ < var_211_8 + var_211_18 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {}

		arg_208_1:InitPlayNodeList()
	end,
	Play321332049 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 321332049
		arg_212_1.duration_ = 6.67

		local var_212_0 = {
			zh = 4.833,
			ja = 6.666
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
				arg_212_0:Play321332050(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			local var_215_0 = 0
			local var_215_1 = 0.275

			if var_215_0 < arg_212_1.time_ and arg_212_1.time_ <= var_215_0 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, true)

				local var_215_2 = arg_212_1:FormatText(StoryNameCfg[600].name)

				arg_212_1.leftNameTxt_.text = var_215_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_212_1.leftNameTxt_.transform)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1.leftNameTxt_.text)
				SetActive(arg_212_1.iconTrs_.gameObject, true)
				arg_212_1.iconController_:SetSelectedState("hero")

				arg_212_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadow10017")

				arg_212_1.callingController_:SetSelectedState("normal")

				arg_212_1.keyicon_.color = Color.New(1, 1, 1)
				arg_212_1.icon_.color = Color.New(1, 1, 1)

				local var_215_3 = arg_212_1:GetWordFromCfg(321332049)
				local var_215_4 = arg_212_1:FormatText(var_215_3.content)

				arg_212_1.text_.text = var_215_4

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_5 = 11
				local var_215_6 = utf8.len(var_215_4)
				local var_215_7 = var_215_5 <= 0 and var_215_1 or var_215_1 * (var_215_6 / var_215_5)

				if var_215_7 > 0 and var_215_1 < var_215_7 then
					arg_212_1.talkMaxDuration = var_215_7

					if var_215_7 + var_215_0 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_7 + var_215_0
					end
				end

				arg_212_1.text_.text = var_215_4
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332049", "story_v_out_321332.awb") ~= 0 then
					local var_215_8 = manager.audio:GetVoiceLength("story_v_out_321332", "321332049", "story_v_out_321332.awb") / 1000

					if var_215_8 + var_215_0 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_8 + var_215_0
					end

					if var_215_3.prefab_name ~= "" and arg_212_1.actors_[var_215_3.prefab_name] ~= nil then
						local var_215_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_212_1.actors_[var_215_3.prefab_name].transform, "story_v_out_321332", "321332049", "story_v_out_321332.awb")

						arg_212_1:RecordAudio("321332049", var_215_9)
						arg_212_1:RecordAudio("321332049", var_215_9)
					else
						arg_212_1:AudioAction("play", "voice", "story_v_out_321332", "321332049", "story_v_out_321332.awb")
					end

					arg_212_1:RecordHistoryTalkVoice("story_v_out_321332", "321332049", "story_v_out_321332.awb")
				end

				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_10 = math.max(var_215_1, arg_212_1.talkMaxDuration)

			if var_215_0 <= arg_212_1.time_ and arg_212_1.time_ < var_215_0 + var_215_10 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - var_215_0) / var_215_10

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= var_215_0 + var_215_10 and arg_212_1.time_ < var_215_0 + var_215_10 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {}

		arg_212_1:InitPlayNodeList()
	end,
	Play321332050 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 321332050
		arg_216_1.duration_ = 5

		SetActive(arg_216_1.tipsGo_, false)

		function arg_216_1.onSingleLineFinish_()
			arg_216_1.onSingleLineUpdate_ = nil
			arg_216_1.onSingleLineFinish_ = nil
			arg_216_1.state_ = "waiting"
		end

		function arg_216_1.playNext_(arg_218_0)
			if arg_218_0 == 1 then
				arg_216_0:Play321332051(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			local var_219_0 = 0.05
			local var_219_1 = 1

			if var_219_0 < arg_216_1.time_ and arg_216_1.time_ <= var_219_0 + arg_219_0 then
				local var_219_2 = "play"
				local var_219_3 = "effect"

				arg_216_1:AudioAction(var_219_2, var_219_3, "se_story_141", "se_story_141_boxing_fight02", "")
			end

			local var_219_4 = 0
			local var_219_5 = 0.825

			if var_219_4 < arg_216_1.time_ and arg_216_1.time_ <= var_219_4 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, false)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_216_1.iconTrs_.gameObject, false)
				arg_216_1.callingController_:SetSelectedState("normal")

				local var_219_6 = arg_216_1:GetWordFromCfg(321332050)
				local var_219_7 = arg_216_1:FormatText(var_219_6.content)

				arg_216_1.text_.text = var_219_7

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_8 = 33
				local var_219_9 = utf8.len(var_219_7)
				local var_219_10 = var_219_8 <= 0 and var_219_5 or var_219_5 * (var_219_9 / var_219_8)

				if var_219_10 > 0 and var_219_5 < var_219_10 then
					arg_216_1.talkMaxDuration = var_219_10

					if var_219_10 + var_219_4 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_10 + var_219_4
					end
				end

				arg_216_1.text_.text = var_219_7
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)
				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_11 = math.max(var_219_5, arg_216_1.talkMaxDuration)

			if var_219_4 <= arg_216_1.time_ and arg_216_1.time_ < var_219_4 + var_219_11 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_4) / var_219_11

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_4 + var_219_11 and arg_216_1.time_ < var_219_4 + var_219_11 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {}

		arg_216_1:InitPlayNodeList()
	end,
	Play321332051 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 321332051
		arg_220_1.duration_ = 6

		SetActive(arg_220_1.tipsGo_, false)

		function arg_220_1.onSingleLineFinish_()
			arg_220_1.onSingleLineUpdate_ = nil
			arg_220_1.onSingleLineFinish_ = nil
			arg_220_1.state_ = "waiting"
		end

		function arg_220_1.playNext_(arg_222_0)
			if arg_222_0 == 1 then
				arg_220_0:Play321332052(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			local var_223_0 = manager.ui.mainCamera.transform
			local var_223_1 = 0

			if var_223_1 < arg_220_1.time_ and arg_220_1.time_ <= var_223_1 + arg_223_0 then
				arg_220_1.var_.shakeOldPos = var_223_0.localPosition
			end

			local var_223_2 = 1

			if var_223_1 <= arg_220_1.time_ and arg_220_1.time_ < var_223_1 + var_223_2 then
				local var_223_3 = (arg_220_1.time_ - var_223_1) / 0.066
				local var_223_4, var_223_5 = math.modf(var_223_3)

				var_223_0.localPosition = Vector3.New(var_223_5 * 0.13, var_223_5 * 0.13, var_223_5 * 0.13) + arg_220_1.var_.shakeOldPos
			end

			if arg_220_1.time_ >= var_223_1 + var_223_2 and arg_220_1.time_ < var_223_1 + var_223_2 + arg_223_0 then
				var_223_0.localPosition = arg_220_1.var_.shakeOldPos
			end

			local var_223_6 = 0

			if var_223_6 < arg_220_1.time_ and arg_220_1.time_ <= var_223_6 + arg_223_0 then
				arg_220_1.allBtn_.enabled = false
			end

			local var_223_7 = 1

			if arg_220_1.time_ >= var_223_6 + var_223_7 and arg_220_1.time_ < var_223_6 + var_223_7 + arg_223_0 then
				arg_220_1.allBtn_.enabled = true
			end

			local var_223_8 = 0
			local var_223_9 = 1

			if var_223_8 < arg_220_1.time_ and arg_220_1.time_ <= var_223_8 + arg_223_0 then
				local var_223_10 = "play"
				local var_223_11 = "effect"

				arg_220_1:AudioAction(var_223_10, var_223_11, "se_story_141", "se_story_141_boxing_fight03", "")
			end

			if arg_220_1.frameCnt_ <= 1 then
				arg_220_1.dialog_:SetActive(false)
			end

			local var_223_12 = 1
			local var_223_13 = 0.825

			if var_223_12 < arg_220_1.time_ and arg_220_1.time_ <= var_223_12 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0

				arg_220_1.dialog_:SetActive(true)

				arg_220_1.dialogCg_.alpha = 0

				local var_223_14 = LeanTween.value(arg_220_1.dialog_, 0, 1, 0.3)

				var_223_14:setOnUpdate(LuaHelper.FloatAction(function(arg_224_0)
					arg_220_1.dialogCg_.alpha = arg_224_0
				end))
				var_223_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_220_1.dialog_)
					var_223_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_220_1.duration_ = arg_220_1.duration_ + 0.3

				SetActive(arg_220_1.leftNameGo_, false)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_220_1.iconTrs_.gameObject, false)
				arg_220_1.callingController_:SetSelectedState("normal")

				local var_223_15 = arg_220_1:GetWordFromCfg(321332051)
				local var_223_16 = arg_220_1:FormatText(var_223_15.content)

				arg_220_1.text_.text = var_223_16

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_17 = 33
				local var_223_18 = utf8.len(var_223_16)
				local var_223_19 = var_223_17 <= 0 and var_223_13 or var_223_13 * (var_223_18 / var_223_17)

				if var_223_19 > 0 and var_223_13 < var_223_19 then
					arg_220_1.talkMaxDuration = var_223_19
					var_223_12 = var_223_12 + 0.3

					if var_223_19 + var_223_12 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_19 + var_223_12
					end
				end

				arg_220_1.text_.text = var_223_16
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)
				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_20 = var_223_12 + 0.3
			local var_223_21 = math.max(var_223_13, arg_220_1.talkMaxDuration)

			if var_223_20 <= arg_220_1.time_ and arg_220_1.time_ < var_223_20 + var_223_21 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - var_223_20) / var_223_21

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= var_223_20 + var_223_21 and arg_220_1.time_ < var_223_20 + var_223_21 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {}

		arg_220_1:InitPlayNodeList()
	end,
	Play321332052 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 321332052
		arg_226_1.duration_ = 10.23

		local var_226_0 = {
			zh = 9.933,
			ja = 10.233
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
				arg_226_0:Play321332053(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			local var_229_0 = "L01g"

			if arg_226_1.bgs_[var_229_0] == nil then
				local var_229_1 = Object.Instantiate(arg_226_1.paintGo_)

				var_229_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_229_0)
				var_229_1.name = var_229_0
				var_229_1.transform.parent = arg_226_1.stage_.transform
				var_229_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_226_1.bgs_[var_229_0] = var_229_1
			end

			local var_229_2 = 0.5

			if var_229_2 < arg_226_1.time_ and arg_226_1.time_ <= var_229_2 + arg_229_0 then
				local var_229_3 = manager.ui.mainCamera.transform.localPosition
				local var_229_4 = Vector3.New(0, 0, 10) + Vector3.New(var_229_3.x, var_229_3.y, 0)
				local var_229_5 = arg_226_1.bgs_.L01g

				var_229_5.transform.localPosition = var_229_4
				var_229_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_229_6 = var_229_5:GetComponent("SpriteRenderer")

				if var_229_6 and var_229_6.sprite then
					local var_229_7 = (var_229_5.transform.localPosition - var_229_3).z
					local var_229_8 = manager.ui.mainCameraCom_
					local var_229_9 = 2 * var_229_7 * Mathf.Tan(var_229_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_229_10 = var_229_9 * var_229_8.aspect
					local var_229_11 = var_229_6.sprite.bounds.size.x
					local var_229_12 = var_229_6.sprite.bounds.size.y
					local var_229_13 = var_229_10 / var_229_11
					local var_229_14 = var_229_9 / var_229_12
					local var_229_15 = var_229_14 < var_229_13 and var_229_13 or var_229_14

					var_229_5.transform.localScale = Vector3.New(var_229_15, var_229_15, 0)
				end

				for iter_229_0, iter_229_1 in pairs(arg_226_1.bgs_) do
					if iter_229_0 ~= "L01g" then
						iter_229_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_229_16 = 2

			if var_229_16 < arg_226_1.time_ and arg_226_1.time_ <= var_229_16 + arg_229_0 then
				arg_226_1.allBtn_.enabled = false
			end

			local var_229_17 = 0.3

			if arg_226_1.time_ >= var_229_16 + var_229_17 and arg_226_1.time_ < var_229_16 + var_229_17 + arg_229_0 then
				arg_226_1.allBtn_.enabled = true
			end

			local var_229_18 = 0

			if var_229_18 < arg_226_1.time_ and arg_226_1.time_ <= var_229_18 + arg_229_0 then
				arg_226_1.mask_.enabled = true
				arg_226_1.mask_.raycastTarget = true

				arg_226_1:SetGaussion(false)
			end

			local var_229_19 = 0.5

			if var_229_18 <= arg_226_1.time_ and arg_226_1.time_ < var_229_18 + var_229_19 then
				local var_229_20 = (arg_226_1.time_ - var_229_18) / var_229_19
				local var_229_21 = Color.New(0, 0, 0)

				var_229_21.a = Mathf.Lerp(0, 1, var_229_20)
				arg_226_1.mask_.color = var_229_21
			end

			if arg_226_1.time_ >= var_229_18 + var_229_19 and arg_226_1.time_ < var_229_18 + var_229_19 + arg_229_0 then
				local var_229_22 = Color.New(0, 0, 0)

				var_229_22.a = 1
				arg_226_1.mask_.color = var_229_22
			end

			local var_229_23 = 0.5

			if var_229_23 < arg_226_1.time_ and arg_226_1.time_ <= var_229_23 + arg_229_0 then
				arg_226_1.mask_.enabled = true
				arg_226_1.mask_.raycastTarget = true

				arg_226_1:SetGaussion(false)
			end

			local var_229_24 = 1.5

			if var_229_23 <= arg_226_1.time_ and arg_226_1.time_ < var_229_23 + var_229_24 then
				local var_229_25 = (arg_226_1.time_ - var_229_23) / var_229_24
				local var_229_26 = Color.New(0, 0, 0)

				var_229_26.a = Mathf.Lerp(1, 0, var_229_25)
				arg_226_1.mask_.color = var_229_26
			end

			if arg_226_1.time_ >= var_229_23 + var_229_24 and arg_226_1.time_ < var_229_23 + var_229_24 + arg_229_0 then
				local var_229_27 = Color.New(0, 0, 0)
				local var_229_28 = 0

				arg_226_1.mask_.enabled = false
				var_229_27.a = var_229_28
				arg_226_1.mask_.color = var_229_27
			end

			local var_229_29 = manager.ui.mainCamera.transform
			local var_229_30 = 0

			if var_229_30 < arg_226_1.time_ and arg_226_1.time_ <= var_229_30 + arg_229_0 then
				local var_229_31 = arg_226_1.var_.effectluobona1
				local var_229_32
				local var_229_33 = var_229_29

				if not var_229_31 then
					var_229_31 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), var_229_33)
					var_229_31.name = "luobona1"
					arg_226_1.var_.effectluobona1 = var_229_31
				else
					var_229_31.transform:SetParent(var_229_33)
				end

				var_229_31.transform.localPosition = Vector3.New(0, 0, 0)
				var_229_31.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_229_34 = manager.ui.mainCamera.transform
			local var_229_35 = 1

			if var_229_35 < arg_226_1.time_ and arg_226_1.time_ <= var_229_35 + arg_229_0 then
				local var_229_36 = arg_226_1.var_.effectluobona1

				if var_229_36 then
					Object.Destroy(var_229_36)

					arg_226_1.var_.effectluobona1 = nil
				end
			end

			local var_229_37 = 0
			local var_229_38 = 1

			if var_229_37 < arg_226_1.time_ and arg_226_1.time_ <= var_229_37 + arg_229_0 then
				local var_229_39 = "play"
				local var_229_40 = "effect"

				arg_226_1:AudioAction(var_229_39, var_229_40, "se_story_141", "se_story_141_boxing_whoosh03", "")
			end

			local var_229_41 = 2.5
			local var_229_42 = 1

			if var_229_41 < arg_226_1.time_ and arg_226_1.time_ <= var_229_41 + arg_229_0 then
				local var_229_43 = "play"
				local var_229_44 = "effect"

				arg_226_1:AudioAction(var_229_43, var_229_44, "se_story_141", "se_story_141_boxing_drum01", "")
			end

			local var_229_45 = 0
			local var_229_46 = 1

			if var_229_45 < arg_226_1.time_ and arg_226_1.time_ <= var_229_45 + arg_229_0 then
				local var_229_47 = "stop"
				local var_229_48 = "effect"

				arg_226_1:AudioAction(var_229_47, var_229_48, "se_story_141", "se_story_141_amb_boxing_cheer02", "")
			end

			local var_229_49 = 0.613
			local var_229_50 = 1

			if var_229_49 < arg_226_1.time_ and arg_226_1.time_ <= var_229_49 + arg_229_0 then
				local var_229_51 = "play"
				local var_229_52 = "effect"

				arg_226_1:AudioAction(var_229_51, var_229_52, "se_story_141", "se_story_141_boxing_amb_cheer03_loop", "")
			end

			if arg_226_1.frameCnt_ <= 1 then
				arg_226_1.dialog_:SetActive(false)
			end

			local var_229_53 = 2
			local var_229_54 = 0.55

			if var_229_53 < arg_226_1.time_ and arg_226_1.time_ <= var_229_53 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0

				arg_226_1.dialog_:SetActive(true)

				arg_226_1.dialogCg_.alpha = 0

				local var_229_55 = LeanTween.value(arg_226_1.dialog_, 0, 1, 0.3)

				var_229_55:setOnUpdate(LuaHelper.FloatAction(function(arg_230_0)
					arg_226_1.dialogCg_.alpha = arg_230_0
				end))
				var_229_55:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_226_1.dialog_)
					var_229_55:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_226_1.duration_ = arg_226_1.duration_ + 0.3

				SetActive(arg_226_1.leftNameGo_, true)

				local var_229_56 = arg_226_1:FormatText(StoryNameCfg[1212].name)

				arg_226_1.leftNameTxt_.text = var_229_56

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, true)
				arg_226_1.iconController_:SetSelectedState("hero")

				arg_226_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2104")

				arg_226_1.callingController_:SetSelectedState("normal")

				arg_226_1.keyicon_.color = Color.New(1, 1, 1)
				arg_226_1.icon_.color = Color.New(1, 1, 1)

				local var_229_57 = arg_226_1:GetWordFromCfg(321332052)
				local var_229_58 = arg_226_1:FormatText(var_229_57.content)

				arg_226_1.text_.text = var_229_58

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_59 = 22
				local var_229_60 = utf8.len(var_229_58)
				local var_229_61 = var_229_59 <= 0 and var_229_54 or var_229_54 * (var_229_60 / var_229_59)

				if var_229_61 > 0 and var_229_54 < var_229_61 then
					arg_226_1.talkMaxDuration = var_229_61
					var_229_53 = var_229_53 + 0.3

					if var_229_61 + var_229_53 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_61 + var_229_53
					end
				end

				arg_226_1.text_.text = var_229_58
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332052", "story_v_out_321332.awb") ~= 0 then
					local var_229_62 = manager.audio:GetVoiceLength("story_v_out_321332", "321332052", "story_v_out_321332.awb") / 1000

					if var_229_62 + var_229_53 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_62 + var_229_53
					end

					if var_229_57.prefab_name ~= "" and arg_226_1.actors_[var_229_57.prefab_name] ~= nil then
						local var_229_63 = LuaForUtil.PlayVoiceWithCriLipsync(arg_226_1.actors_[var_229_57.prefab_name].transform, "story_v_out_321332", "321332052", "story_v_out_321332.awb")

						arg_226_1:RecordAudio("321332052", var_229_63)
						arg_226_1:RecordAudio("321332052", var_229_63)
					else
						arg_226_1:AudioAction("play", "voice", "story_v_out_321332", "321332052", "story_v_out_321332.awb")
					end

					arg_226_1:RecordHistoryTalkVoice("story_v_out_321332", "321332052", "story_v_out_321332.awb")
				end

				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_64 = var_229_53 + 0.3
			local var_229_65 = math.max(var_229_54, arg_226_1.talkMaxDuration)

			if var_229_64 <= arg_226_1.time_ and arg_226_1.time_ < var_229_64 + var_229_65 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_64) / var_229_65

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_64 + var_229_65 and arg_226_1.time_ < var_229_64 + var_229_65 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {}

		arg_226_1:InitPlayNodeList()
	end,
	Play321332053 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 321332053
		arg_232_1.duration_ = 5

		SetActive(arg_232_1.tipsGo_, false)

		function arg_232_1.onSingleLineFinish_()
			arg_232_1.onSingleLineUpdate_ = nil
			arg_232_1.onSingleLineFinish_ = nil
			arg_232_1.state_ = "waiting"
		end

		function arg_232_1.playNext_(arg_234_0)
			if arg_234_0 == 1 then
				arg_232_0:Play321332054(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			local var_235_0 = 0.05
			local var_235_1 = 1

			if var_235_0 < arg_232_1.time_ and arg_232_1.time_ <= var_235_0 + arg_235_0 then
				local var_235_2 = "play"
				local var_235_3 = "effect"

				arg_232_1:AudioAction(var_235_2, var_235_3, "se_story_141", "se_story_141_boxing_shadow", "")
			end

			local var_235_4 = 0
			local var_235_5 = 1.275

			if var_235_4 < arg_232_1.time_ and arg_232_1.time_ <= var_235_4 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, false)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_232_1.iconTrs_.gameObject, false)
				arg_232_1.callingController_:SetSelectedState("normal")

				local var_235_6 = arg_232_1:GetWordFromCfg(321332053)
				local var_235_7 = arg_232_1:FormatText(var_235_6.content)

				arg_232_1.text_.text = var_235_7

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_8 = 51
				local var_235_9 = utf8.len(var_235_7)
				local var_235_10 = var_235_8 <= 0 and var_235_5 or var_235_5 * (var_235_9 / var_235_8)

				if var_235_10 > 0 and var_235_5 < var_235_10 then
					arg_232_1.talkMaxDuration = var_235_10

					if var_235_10 + var_235_4 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_10 + var_235_4
					end
				end

				arg_232_1.text_.text = var_235_7
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)
				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_11 = math.max(var_235_5, arg_232_1.talkMaxDuration)

			if var_235_4 <= arg_232_1.time_ and arg_232_1.time_ < var_235_4 + var_235_11 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - var_235_4) / var_235_11

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= var_235_4 + var_235_11 and arg_232_1.time_ < var_235_4 + var_235_11 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {}

		arg_232_1:InitPlayNodeList()
	end,
	Play321332054 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 321332054
		arg_236_1.duration_ = 6.23

		local var_236_0 = {
			zh = 5.3,
			ja = 6.233
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
				arg_236_0:Play321332055(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			local var_239_0 = 0
			local var_239_1 = 0.325

			if var_239_0 < arg_236_1.time_ and arg_236_1.time_ <= var_239_0 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, true)

				local var_239_2 = arg_236_1:FormatText(StoryNameCfg[600].name)

				arg_236_1.leftNameTxt_.text = var_239_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_236_1.leftNameTxt_.transform)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1.leftNameTxt_.text)
				SetActive(arg_236_1.iconTrs_.gameObject, true)
				arg_236_1.iconController_:SetSelectedState("hero")

				arg_236_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadow10017")

				arg_236_1.callingController_:SetSelectedState("normal")

				arg_236_1.keyicon_.color = Color.New(1, 1, 1)
				arg_236_1.icon_.color = Color.New(1, 1, 1)

				local var_239_3 = arg_236_1:GetWordFromCfg(321332054)
				local var_239_4 = arg_236_1:FormatText(var_239_3.content)

				arg_236_1.text_.text = var_239_4

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_5 = 13
				local var_239_6 = utf8.len(var_239_4)
				local var_239_7 = var_239_5 <= 0 and var_239_1 or var_239_1 * (var_239_6 / var_239_5)

				if var_239_7 > 0 and var_239_1 < var_239_7 then
					arg_236_1.talkMaxDuration = var_239_7

					if var_239_7 + var_239_0 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_7 + var_239_0
					end
				end

				arg_236_1.text_.text = var_239_4
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332054", "story_v_out_321332.awb") ~= 0 then
					local var_239_8 = manager.audio:GetVoiceLength("story_v_out_321332", "321332054", "story_v_out_321332.awb") / 1000

					if var_239_8 + var_239_0 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_8 + var_239_0
					end

					if var_239_3.prefab_name ~= "" and arg_236_1.actors_[var_239_3.prefab_name] ~= nil then
						local var_239_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_236_1.actors_[var_239_3.prefab_name].transform, "story_v_out_321332", "321332054", "story_v_out_321332.awb")

						arg_236_1:RecordAudio("321332054", var_239_9)
						arg_236_1:RecordAudio("321332054", var_239_9)
					else
						arg_236_1:AudioAction("play", "voice", "story_v_out_321332", "321332054", "story_v_out_321332.awb")
					end

					arg_236_1:RecordHistoryTalkVoice("story_v_out_321332", "321332054", "story_v_out_321332.awb")
				end

				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_10 = math.max(var_239_1, arg_236_1.talkMaxDuration)

			if var_239_0 <= arg_236_1.time_ and arg_236_1.time_ < var_239_0 + var_239_10 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - var_239_0) / var_239_10

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= var_239_0 + var_239_10 and arg_236_1.time_ < var_239_0 + var_239_10 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {}

		arg_236_1:InitPlayNodeList()
	end,
	Play321332055 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 321332055
		arg_240_1.duration_ = 8.93

		local var_240_0 = {
			zh = 7.666,
			ja = 8.933
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
				arg_240_0:Play321332056(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			local var_243_0 = 0.526
			local var_243_1 = 1

			if var_243_0 < arg_240_1.time_ and arg_240_1.time_ <= var_243_0 + arg_243_0 then
				local var_243_2 = "play"
				local var_243_3 = "effect"

				arg_240_1:AudioAction(var_243_2, var_243_3, "se_story_141", "se_story_141_boxing_drum01", "")
			end

			local var_243_4 = 5.127
			local var_243_5 = 1

			if var_243_4 < arg_240_1.time_ and arg_240_1.time_ <= var_243_4 + arg_243_0 then
				local var_243_6 = "play"
				local var_243_7 = "effect"

				arg_240_1:AudioAction(var_243_6, var_243_7, "se_story_141", "se_story_141_boxing_push", "")
			end

			local var_243_8 = 0
			local var_243_9 = 0.725

			if var_243_8 < arg_240_1.time_ and arg_240_1.time_ <= var_243_8 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, true)

				local var_243_10 = arg_240_1:FormatText(StoryNameCfg[1212].name)

				arg_240_1.leftNameTxt_.text = var_243_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_240_1.leftNameTxt_.transform)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1.leftNameTxt_.text)
				SetActive(arg_240_1.iconTrs_.gameObject, true)
				arg_240_1.iconController_:SetSelectedState("hero")

				arg_240_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2104")

				arg_240_1.callingController_:SetSelectedState("normal")

				arg_240_1.keyicon_.color = Color.New(1, 1, 1)
				arg_240_1.icon_.color = Color.New(1, 1, 1)

				local var_243_11 = arg_240_1:GetWordFromCfg(321332055)
				local var_243_12 = arg_240_1:FormatText(var_243_11.content)

				arg_240_1.text_.text = var_243_12

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_13 = 29
				local var_243_14 = utf8.len(var_243_12)
				local var_243_15 = var_243_13 <= 0 and var_243_9 or var_243_9 * (var_243_14 / var_243_13)

				if var_243_15 > 0 and var_243_9 < var_243_15 then
					arg_240_1.talkMaxDuration = var_243_15

					if var_243_15 + var_243_8 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_15 + var_243_8
					end
				end

				arg_240_1.text_.text = var_243_12
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332055", "story_v_out_321332.awb") ~= 0 then
					local var_243_16 = manager.audio:GetVoiceLength("story_v_out_321332", "321332055", "story_v_out_321332.awb") / 1000

					if var_243_16 + var_243_8 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_16 + var_243_8
					end

					if var_243_11.prefab_name ~= "" and arg_240_1.actors_[var_243_11.prefab_name] ~= nil then
						local var_243_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_240_1.actors_[var_243_11.prefab_name].transform, "story_v_out_321332", "321332055", "story_v_out_321332.awb")

						arg_240_1:RecordAudio("321332055", var_243_17)
						arg_240_1:RecordAudio("321332055", var_243_17)
					else
						arg_240_1:AudioAction("play", "voice", "story_v_out_321332", "321332055", "story_v_out_321332.awb")
					end

					arg_240_1:RecordHistoryTalkVoice("story_v_out_321332", "321332055", "story_v_out_321332.awb")
				end

				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_18 = math.max(var_243_9, arg_240_1.talkMaxDuration)

			if var_243_8 <= arg_240_1.time_ and arg_240_1.time_ < var_243_8 + var_243_18 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - var_243_8) / var_243_18

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= var_243_8 + var_243_18 and arg_240_1.time_ < var_243_8 + var_243_18 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {}

		arg_240_1:InitPlayNodeList()
	end,
	Play321332056 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 321332056
		arg_244_1.duration_ = 1.8

		SetActive(arg_244_1.tipsGo_, false)

		function arg_244_1.onSingleLineFinish_()
			arg_244_1.onSingleLineUpdate_ = nil
			arg_244_1.onSingleLineFinish_ = nil
			arg_244_1.state_ = "waiting"
		end

		function arg_244_1.playNext_(arg_246_0)
			if arg_246_0 == 1 then
				arg_244_0:Play321332057(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			local var_247_0 = 0.8
			local var_247_1 = 1

			if var_247_0 < arg_244_1.time_ and arg_244_1.time_ <= var_247_0 + arg_247_0 then
				local var_247_2 = "play"
				local var_247_3 = "effect"

				arg_244_1:AudioAction(var_247_2, var_247_3, "se_story_141", "se_story_141_ravana_footstep02", "")
			end

			local var_247_4 = 0
			local var_247_5 = 0.925

			if var_247_4 < arg_244_1.time_ and arg_244_1.time_ <= var_247_4 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, false)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_244_1.iconTrs_.gameObject, false)
				arg_244_1.callingController_:SetSelectedState("normal")

				local var_247_6 = arg_244_1:GetWordFromCfg(321332056)
				local var_247_7 = arg_244_1:FormatText(var_247_6.content)

				arg_244_1.text_.text = var_247_7

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_8 = 37
				local var_247_9 = utf8.len(var_247_7)
				local var_247_10 = var_247_8 <= 0 and var_247_5 or var_247_5 * (var_247_9 / var_247_8)

				if var_247_10 > 0 and var_247_5 < var_247_10 then
					arg_244_1.talkMaxDuration = var_247_10

					if var_247_10 + var_247_4 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_10 + var_247_4
					end
				end

				arg_244_1.text_.text = var_247_7
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332056", "story_v_out_321332.awb") ~= 0 then
					local var_247_11 = manager.audio:GetVoiceLength("story_v_out_321332", "321332056", "story_v_out_321332.awb") / 1000

					if var_247_11 + var_247_4 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_11 + var_247_4
					end

					if var_247_6.prefab_name ~= "" and arg_244_1.actors_[var_247_6.prefab_name] ~= nil then
						local var_247_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_244_1.actors_[var_247_6.prefab_name].transform, "story_v_out_321332", "321332056", "story_v_out_321332.awb")

						arg_244_1:RecordAudio("321332056", var_247_12)
						arg_244_1:RecordAudio("321332056", var_247_12)
					else
						arg_244_1:AudioAction("play", "voice", "story_v_out_321332", "321332056", "story_v_out_321332.awb")
					end

					arg_244_1:RecordHistoryTalkVoice("story_v_out_321332", "321332056", "story_v_out_321332.awb")
				end

				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_13 = math.max(var_247_5, arg_244_1.talkMaxDuration)

			if var_247_4 <= arg_244_1.time_ and arg_244_1.time_ < var_247_4 + var_247_13 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_4) / var_247_13

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_4 + var_247_13 and arg_244_1.time_ < var_247_4 + var_247_13 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {}

		arg_244_1:InitPlayNodeList()
	end,
	Play321332057 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 321332057
		arg_248_1.duration_ = 6.7

		local var_248_0 = {
			zh = 6.7,
			ja = 6.433
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
				arg_248_0:Play321332058(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			local var_251_0 = 0
			local var_251_1 = 0.425

			if var_251_0 < arg_248_1.time_ and arg_248_1.time_ <= var_251_0 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, true)

				local var_251_2 = arg_248_1:FormatText(StoryNameCfg[600].name)

				arg_248_1.leftNameTxt_.text = var_251_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_248_1.leftNameTxt_.transform)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1.leftNameTxt_.text)
				SetActive(arg_248_1.iconTrs_.gameObject, true)
				arg_248_1.iconController_:SetSelectedState("hero")

				arg_248_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadow10017")

				arg_248_1.callingController_:SetSelectedState("normal")

				arg_248_1.keyicon_.color = Color.New(1, 1, 1)
				arg_248_1.icon_.color = Color.New(1, 1, 1)

				local var_251_3 = arg_248_1:GetWordFromCfg(321332057)
				local var_251_4 = arg_248_1:FormatText(var_251_3.content)

				arg_248_1.text_.text = var_251_4

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_5 = 17
				local var_251_6 = utf8.len(var_251_4)
				local var_251_7 = var_251_5 <= 0 and var_251_1 or var_251_1 * (var_251_6 / var_251_5)

				if var_251_7 > 0 and var_251_1 < var_251_7 then
					arg_248_1.talkMaxDuration = var_251_7

					if var_251_7 + var_251_0 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_7 + var_251_0
					end
				end

				arg_248_1.text_.text = var_251_4
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332057", "story_v_out_321332.awb") ~= 0 then
					local var_251_8 = manager.audio:GetVoiceLength("story_v_out_321332", "321332057", "story_v_out_321332.awb") / 1000

					if var_251_8 + var_251_0 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_8 + var_251_0
					end

					if var_251_3.prefab_name ~= "" and arg_248_1.actors_[var_251_3.prefab_name] ~= nil then
						local var_251_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_248_1.actors_[var_251_3.prefab_name].transform, "story_v_out_321332", "321332057", "story_v_out_321332.awb")

						arg_248_1:RecordAudio("321332057", var_251_9)
						arg_248_1:RecordAudio("321332057", var_251_9)
					else
						arg_248_1:AudioAction("play", "voice", "story_v_out_321332", "321332057", "story_v_out_321332.awb")
					end

					arg_248_1:RecordHistoryTalkVoice("story_v_out_321332", "321332057", "story_v_out_321332.awb")
				end

				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_10 = math.max(var_251_1, arg_248_1.talkMaxDuration)

			if var_251_0 <= arg_248_1.time_ and arg_248_1.time_ < var_251_0 + var_251_10 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - var_251_0) / var_251_10

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= var_251_0 + var_251_10 and arg_248_1.time_ < var_251_0 + var_251_10 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {}

		arg_248_1:InitPlayNodeList()
	end,
	Play321332058 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 321332058
		arg_252_1.duration_ = 4.7

		local var_252_0 = {
			zh = 3.2,
			ja = 4.7
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
				arg_252_0:Play321332059(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			local var_255_0 = 0
			local var_255_1 = 0.225

			if var_255_0 < arg_252_1.time_ and arg_252_1.time_ <= var_255_0 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, true)

				local var_255_2 = arg_252_1:FormatText(StoryNameCfg[600].name)

				arg_252_1.leftNameTxt_.text = var_255_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_252_1.leftNameTxt_.transform)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1.leftNameTxt_.text)
				SetActive(arg_252_1.iconTrs_.gameObject, true)
				arg_252_1.iconController_:SetSelectedState("hero")

				arg_252_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadow10017")

				arg_252_1.callingController_:SetSelectedState("normal")

				arg_252_1.keyicon_.color = Color.New(1, 1, 1)
				arg_252_1.icon_.color = Color.New(1, 1, 1)

				local var_255_3 = arg_252_1:GetWordFromCfg(321332058)
				local var_255_4 = arg_252_1:FormatText(var_255_3.content)

				arg_252_1.text_.text = var_255_4

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_5 = 9
				local var_255_6 = utf8.len(var_255_4)
				local var_255_7 = var_255_5 <= 0 and var_255_1 or var_255_1 * (var_255_6 / var_255_5)

				if var_255_7 > 0 and var_255_1 < var_255_7 then
					arg_252_1.talkMaxDuration = var_255_7

					if var_255_7 + var_255_0 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_7 + var_255_0
					end
				end

				arg_252_1.text_.text = var_255_4
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332058", "story_v_out_321332.awb") ~= 0 then
					local var_255_8 = manager.audio:GetVoiceLength("story_v_out_321332", "321332058", "story_v_out_321332.awb") / 1000

					if var_255_8 + var_255_0 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_8 + var_255_0
					end

					if var_255_3.prefab_name ~= "" and arg_252_1.actors_[var_255_3.prefab_name] ~= nil then
						local var_255_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_252_1.actors_[var_255_3.prefab_name].transform, "story_v_out_321332", "321332058", "story_v_out_321332.awb")

						arg_252_1:RecordAudio("321332058", var_255_9)
						arg_252_1:RecordAudio("321332058", var_255_9)
					else
						arg_252_1:AudioAction("play", "voice", "story_v_out_321332", "321332058", "story_v_out_321332.awb")
					end

					arg_252_1:RecordHistoryTalkVoice("story_v_out_321332", "321332058", "story_v_out_321332.awb")
				end

				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_10 = math.max(var_255_1, arg_252_1.talkMaxDuration)

			if var_255_0 <= arg_252_1.time_ and arg_252_1.time_ < var_255_0 + var_255_10 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_0) / var_255_10

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_0 + var_255_10 and arg_252_1.time_ < var_255_0 + var_255_10 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {}

		arg_252_1:InitPlayNodeList()
	end,
	Play321332059 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 321332059
		arg_256_1.duration_ = 5

		SetActive(arg_256_1.tipsGo_, false)

		function arg_256_1.onSingleLineFinish_()
			arg_256_1.onSingleLineUpdate_ = nil
			arg_256_1.onSingleLineFinish_ = nil
			arg_256_1.state_ = "waiting"
		end

		function arg_256_1.playNext_(arg_258_0)
			if arg_258_0 == 1 then
				arg_256_0:Play321332060(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			local var_259_0 = 0.3
			local var_259_1 = 1

			if var_259_0 < arg_256_1.time_ and arg_256_1.time_ <= var_259_0 + arg_259_0 then
				local var_259_2 = "play"
				local var_259_3 = "effect"

				arg_256_1:AudioAction(var_259_2, var_259_3, "se_story_141", "se_story_141_boxing_organic", "")
			end

			local var_259_4 = 0
			local var_259_5 = 1.925

			if var_259_4 < arg_256_1.time_ and arg_256_1.time_ <= var_259_4 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, false)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_256_1.iconTrs_.gameObject, false)
				arg_256_1.callingController_:SetSelectedState("normal")

				local var_259_6 = arg_256_1:GetWordFromCfg(321332059)
				local var_259_7 = arg_256_1:FormatText(var_259_6.content)

				arg_256_1.text_.text = var_259_7

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_8 = 77
				local var_259_9 = utf8.len(var_259_7)
				local var_259_10 = var_259_8 <= 0 and var_259_5 or var_259_5 * (var_259_9 / var_259_8)

				if var_259_10 > 0 and var_259_5 < var_259_10 then
					arg_256_1.talkMaxDuration = var_259_10

					if var_259_10 + var_259_4 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_10 + var_259_4
					end
				end

				arg_256_1.text_.text = var_259_7
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)
				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_11 = math.max(var_259_5, arg_256_1.talkMaxDuration)

			if var_259_4 <= arg_256_1.time_ and arg_256_1.time_ < var_259_4 + var_259_11 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - var_259_4) / var_259_11

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= var_259_4 + var_259_11 and arg_256_1.time_ < var_259_4 + var_259_11 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {}

		arg_256_1:InitPlayNodeList()
	end,
	Play321332060 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 321332060
		arg_260_1.duration_ = 4.53

		local var_260_0 = {
			zh = 4.533,
			ja = 3.866
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
				arg_260_0:Play321332061(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			local var_263_0 = manager.ui.mainCamera.transform
			local var_263_1 = 0

			if var_263_1 < arg_260_1.time_ and arg_260_1.time_ <= var_263_1 + arg_263_0 then
				arg_260_1.var_.shakeOldPos = var_263_0.localPosition
			end

			local var_263_2 = 0.6

			if var_263_1 <= arg_260_1.time_ and arg_260_1.time_ < var_263_1 + var_263_2 then
				local var_263_3 = (arg_260_1.time_ - var_263_1) / 0.066
				local var_263_4, var_263_5 = math.modf(var_263_3)

				var_263_0.localPosition = Vector3.New(var_263_5 * 0.13, var_263_5 * 0.13, var_263_5 * 0.13) + arg_260_1.var_.shakeOldPos
			end

			if arg_260_1.time_ >= var_263_1 + var_263_2 and arg_260_1.time_ < var_263_1 + var_263_2 + arg_263_0 then
				var_263_0.localPosition = arg_260_1.var_.shakeOldPos
			end

			local var_263_6 = 0

			if var_263_6 < arg_260_1.time_ and arg_260_1.time_ <= var_263_6 + arg_263_0 then
				arg_260_1.allBtn_.enabled = false
			end

			local var_263_7 = 0.6

			if arg_260_1.time_ >= var_263_6 + var_263_7 and arg_260_1.time_ < var_263_6 + var_263_7 + arg_263_0 then
				arg_260_1.allBtn_.enabled = true
			end

			local var_263_8 = 0
			local var_263_9 = 1
			local var_263_10 = manager.audio:GetVoiceLength("story_v_out_321332", "321332060", "") / 1000

			if var_263_10 > 0 and var_263_9 < var_263_10 and var_263_10 + var_263_8 > arg_260_1.duration_ then
				local var_263_11 = var_263_10

				arg_260_1.duration_ = var_263_10 + var_263_8
			end

			if var_263_8 < arg_260_1.time_ and arg_260_1.time_ <= var_263_8 + arg_263_0 then
				local var_263_12 = "play"
				local var_263_13 = "voice"

				arg_260_1:AudioAction(var_263_12, var_263_13, "story_v_out_321332", "321332060", "")
			end

			local var_263_14 = 0.526
			local var_263_15 = 1

			if var_263_14 < arg_260_1.time_ and arg_260_1.time_ <= var_263_14 + arg_263_0 then
				local var_263_16 = "play"
				local var_263_17 = "effect"

				arg_260_1:AudioAction(var_263_16, var_263_17, "se_story_141", "se_story_141_boxing_drum03", "")
			end

			if arg_260_1.frameCnt_ <= 1 then
				arg_260_1.dialog_:SetActive(false)
			end

			local var_263_18 = 0.6
			local var_263_19 = 0.8

			if var_263_18 < arg_260_1.time_ and arg_260_1.time_ <= var_263_18 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0

				arg_260_1.dialog_:SetActive(true)

				arg_260_1.dialogCg_.alpha = 0

				local var_263_20 = LeanTween.value(arg_260_1.dialog_, 0, 1, 0.3)

				var_263_20:setOnUpdate(LuaHelper.FloatAction(function(arg_264_0)
					arg_260_1.dialogCg_.alpha = arg_264_0
				end))
				var_263_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_260_1.dialog_)
					var_263_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_260_1.duration_ = arg_260_1.duration_ + 0.3

				SetActive(arg_260_1.leftNameGo_, false)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_260_1.iconTrs_.gameObject, false)
				arg_260_1.callingController_:SetSelectedState("normal")

				local var_263_21 = arg_260_1:GetWordFromCfg(321332060)
				local var_263_22 = arg_260_1:FormatText(var_263_21.content)

				arg_260_1.text_.text = var_263_22

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_23 = 32
				local var_263_24 = utf8.len(var_263_22)
				local var_263_25 = var_263_23 <= 0 and var_263_19 or var_263_19 * (var_263_24 / var_263_23)

				if var_263_25 > 0 and var_263_19 < var_263_25 then
					arg_260_1.talkMaxDuration = var_263_25
					var_263_18 = var_263_18 + 0.3

					if var_263_25 + var_263_18 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_25 + var_263_18
					end
				end

				arg_260_1.text_.text = var_263_22
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332060", "story_v_out_321332.awb") ~= 0 then
					local var_263_26 = manager.audio:GetVoiceLength("story_v_out_321332", "321332060", "story_v_out_321332.awb") / 1000

					if var_263_26 + var_263_18 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_26 + var_263_18
					end

					if var_263_21.prefab_name ~= "" and arg_260_1.actors_[var_263_21.prefab_name] ~= nil then
						local var_263_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_260_1.actors_[var_263_21.prefab_name].transform, "story_v_out_321332", "321332060", "story_v_out_321332.awb")

						arg_260_1:RecordAudio("321332060", var_263_27)
						arg_260_1:RecordAudio("321332060", var_263_27)
					else
						arg_260_1:AudioAction("play", "voice", "story_v_out_321332", "321332060", "story_v_out_321332.awb")
					end

					arg_260_1:RecordHistoryTalkVoice("story_v_out_321332", "321332060", "story_v_out_321332.awb")
				end

				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_28 = var_263_18 + 0.3
			local var_263_29 = math.max(var_263_19, arg_260_1.talkMaxDuration)

			if var_263_28 <= arg_260_1.time_ and arg_260_1.time_ < var_263_28 + var_263_29 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - var_263_28) / var_263_29

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= var_263_28 + var_263_29 and arg_260_1.time_ < var_263_28 + var_263_29 + arg_263_0 then
				arg_260_1.typewritter.percent = 1

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(true)
			end
		end

		arg_260_1.nodeConfigList_ = {}

		arg_260_1:InitPlayNodeList()
	end,
	Play321332061 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 321332061
		arg_266_1.duration_ = 5

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play321332062(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			local var_269_0 = 0.199999999999
			local var_269_1 = 1

			if var_269_0 < arg_266_1.time_ and arg_266_1.time_ <= var_269_0 + arg_269_0 then
				local var_269_2 = "play"
				local var_269_3 = "effect"

				arg_266_1:AudioAction(var_269_2, var_269_3, "se_story_141", "se_story_141_boxing_fall", "")
			end

			local var_269_4 = 0
			local var_269_5 = 1.2

			if var_269_4 < arg_266_1.time_ and arg_266_1.time_ <= var_269_4 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, false)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_266_1.iconTrs_.gameObject, false)
				arg_266_1.callingController_:SetSelectedState("normal")

				local var_269_6 = arg_266_1:GetWordFromCfg(321332061)
				local var_269_7 = arg_266_1:FormatText(var_269_6.content)

				arg_266_1.text_.text = var_269_7

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_8 = 48
				local var_269_9 = utf8.len(var_269_7)
				local var_269_10 = var_269_8 <= 0 and var_269_5 or var_269_5 * (var_269_9 / var_269_8)

				if var_269_10 > 0 and var_269_5 < var_269_10 then
					arg_266_1.talkMaxDuration = var_269_10

					if var_269_10 + var_269_4 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_10 + var_269_4
					end
				end

				arg_266_1.text_.text = var_269_7
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)
				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_11 = math.max(var_269_5, arg_266_1.talkMaxDuration)

			if var_269_4 <= arg_266_1.time_ and arg_266_1.time_ < var_269_4 + var_269_11 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_4) / var_269_11

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_4 + var_269_11 and arg_266_1.time_ < var_269_4 + var_269_11 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {}

		arg_266_1:InitPlayNodeList()
	end,
	Play321332062 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 321332062
		arg_270_1.duration_ = 7

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play321332063(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			local var_273_0 = "L09h"

			if arg_270_1.bgs_[var_273_0] == nil then
				local var_273_1 = Object.Instantiate(arg_270_1.paintGo_)

				var_273_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_273_0)
				var_273_1.name = var_273_0
				var_273_1.transform.parent = arg_270_1.stage_.transform
				var_273_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_270_1.bgs_[var_273_0] = var_273_1
			end

			local var_273_2 = 0

			if var_273_2 < arg_270_1.time_ and arg_270_1.time_ <= var_273_2 + arg_273_0 then
				local var_273_3 = manager.ui.mainCamera.transform.localPosition
				local var_273_4 = Vector3.New(0, 0, 10) + Vector3.New(var_273_3.x, var_273_3.y, 0)
				local var_273_5 = arg_270_1.bgs_.L09h

				var_273_5.transform.localPosition = var_273_4
				var_273_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_273_6 = var_273_5:GetComponent("SpriteRenderer")

				if var_273_6 and var_273_6.sprite then
					local var_273_7 = (var_273_5.transform.localPosition - var_273_3).z
					local var_273_8 = manager.ui.mainCameraCom_
					local var_273_9 = 2 * var_273_7 * Mathf.Tan(var_273_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_273_10 = var_273_9 * var_273_8.aspect
					local var_273_11 = var_273_6.sprite.bounds.size.x
					local var_273_12 = var_273_6.sprite.bounds.size.y
					local var_273_13 = var_273_10 / var_273_11
					local var_273_14 = var_273_9 / var_273_12
					local var_273_15 = var_273_14 < var_273_13 and var_273_13 or var_273_14

					var_273_5.transform.localScale = Vector3.New(var_273_15, var_273_15, 0)
				end

				for iter_273_0, iter_273_1 in pairs(arg_270_1.bgs_) do
					if iter_273_0 ~= "L09h" then
						iter_273_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_273_16 = 1.999999999999

			if var_273_16 < arg_270_1.time_ and arg_270_1.time_ <= var_273_16 + arg_273_0 then
				arg_270_1.allBtn_.enabled = false
			end

			local var_273_17 = 0.3

			if arg_270_1.time_ >= var_273_16 + var_273_17 and arg_270_1.time_ < var_273_16 + var_273_17 + arg_273_0 then
				arg_270_1.allBtn_.enabled = true
			end

			local var_273_18 = 0

			if var_273_18 < arg_270_1.time_ and arg_270_1.time_ <= var_273_18 + arg_273_0 then
				arg_270_1.mask_.enabled = true
				arg_270_1.mask_.raycastTarget = true

				arg_270_1:SetGaussion(false)
			end

			local var_273_19 = 2

			if var_273_18 <= arg_270_1.time_ and arg_270_1.time_ < var_273_18 + var_273_19 then
				local var_273_20 = (arg_270_1.time_ - var_273_18) / var_273_19
				local var_273_21 = Color.New(1, 1, 1)

				var_273_21.a = Mathf.Lerp(1, 0, var_273_20)
				arg_270_1.mask_.color = var_273_21
			end

			if arg_270_1.time_ >= var_273_18 + var_273_19 and arg_270_1.time_ < var_273_18 + var_273_19 + arg_273_0 then
				local var_273_22 = Color.New(1, 1, 1)
				local var_273_23 = 0

				arg_270_1.mask_.enabled = false
				var_273_22.a = var_273_23
				arg_270_1.mask_.color = var_273_22
			end

			local var_273_24 = manager.ui.mainCamera.transform
			local var_273_25 = 0

			if var_273_25 < arg_270_1.time_ and arg_270_1.time_ <= var_273_25 + arg_273_0 then
				local var_273_26 = arg_270_1.var_.effectluobonazhuanchang3

				if var_273_26 then
					Object.Destroy(var_273_26)

					arg_270_1.var_.effectluobonazhuanchang3 = nil
				end
			end

			local var_273_27 = 2
			local var_273_28 = 1

			if var_273_27 < arg_270_1.time_ and arg_270_1.time_ <= var_273_27 + arg_273_0 then
				local var_273_29 = "play"
				local var_273_30 = "effect"

				arg_270_1:AudioAction(var_273_29, var_273_30, "se_story_141", "se_story_141_boxing_down", "")
			end

			if arg_270_1.frameCnt_ <= 1 then
				arg_270_1.dialog_:SetActive(false)
			end

			local var_273_31 = 2
			local var_273_32 = 1.6

			if var_273_31 < arg_270_1.time_ and arg_270_1.time_ <= var_273_31 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0

				arg_270_1.dialog_:SetActive(true)

				arg_270_1.dialogCg_.alpha = 0

				local var_273_33 = LeanTween.value(arg_270_1.dialog_, 0, 1, 0.3)

				var_273_33:setOnUpdate(LuaHelper.FloatAction(function(arg_274_0)
					arg_270_1.dialogCg_.alpha = arg_274_0
				end))
				var_273_33:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_270_1.dialog_)
					var_273_33:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_270_1.duration_ = arg_270_1.duration_ + 0.3

				SetActive(arg_270_1.leftNameGo_, false)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_34 = arg_270_1:GetWordFromCfg(321332062)
				local var_273_35 = arg_270_1:FormatText(var_273_34.content)

				arg_270_1.text_.text = var_273_35

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_36 = 64
				local var_273_37 = utf8.len(var_273_35)
				local var_273_38 = var_273_36 <= 0 and var_273_32 or var_273_32 * (var_273_37 / var_273_36)

				if var_273_38 > 0 and var_273_32 < var_273_38 then
					arg_270_1.talkMaxDuration = var_273_38
					var_273_31 = var_273_31 + 0.3

					if var_273_38 + var_273_31 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_38 + var_273_31
					end
				end

				arg_270_1.text_.text = var_273_35
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)
				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_39 = var_273_31 + 0.3
			local var_273_40 = math.max(var_273_32, arg_270_1.talkMaxDuration)

			if var_273_39 <= arg_270_1.time_ and arg_270_1.time_ < var_273_39 + var_273_40 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_39) / var_273_40

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_39 + var_273_40 and arg_270_1.time_ < var_273_39 + var_273_40 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {}

		arg_270_1:InitPlayNodeList()
	end,
	Play321332063 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 321332063
		arg_276_1.duration_ = 13.2

		local var_276_0 = {
			zh = 9.266,
			ja = 13.2
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
				arg_276_0:Play321332064(arg_276_1)
			end
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			local var_279_0 = 0
			local var_279_1 = 0.625

			if var_279_0 < arg_276_1.time_ and arg_276_1.time_ <= var_279_0 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0
				arg_276_1.dialogCg_.alpha = 1

				arg_276_1.dialog_:SetActive(true)
				SetActive(arg_276_1.leftNameGo_, true)

				local var_279_2 = arg_276_1:FormatText(StoryNameCfg[600].name)

				arg_276_1.leftNameTxt_.text = var_279_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_276_1.leftNameTxt_.transform)

				arg_276_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_276_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_276_1:RecordName(arg_276_1.leftNameTxt_.text)
				SetActive(arg_276_1.iconTrs_.gameObject, true)
				arg_276_1.iconController_:SetSelectedState("hero")

				arg_276_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4032")

				arg_276_1.callingController_:SetSelectedState("normal")

				arg_276_1.keyicon_.color = Color.New(1, 1, 1)
				arg_276_1.icon_.color = Color.New(1, 1, 1)

				local var_279_3 = arg_276_1:GetWordFromCfg(321332063)
				local var_279_4 = arg_276_1:FormatText(var_279_3.content)

				arg_276_1.text_.text = var_279_4

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_5 = 25
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

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332063", "story_v_out_321332.awb") ~= 0 then
					local var_279_8 = manager.audio:GetVoiceLength("story_v_out_321332", "321332063", "story_v_out_321332.awb") / 1000

					if var_279_8 + var_279_0 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_8 + var_279_0
					end

					if var_279_3.prefab_name ~= "" and arg_276_1.actors_[var_279_3.prefab_name] ~= nil then
						local var_279_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_276_1.actors_[var_279_3.prefab_name].transform, "story_v_out_321332", "321332063", "story_v_out_321332.awb")

						arg_276_1:RecordAudio("321332063", var_279_9)
						arg_276_1:RecordAudio("321332063", var_279_9)
					else
						arg_276_1:AudioAction("play", "voice", "story_v_out_321332", "321332063", "story_v_out_321332.awb")
					end

					arg_276_1:RecordHistoryTalkVoice("story_v_out_321332", "321332063", "story_v_out_321332.awb")
				end

				arg_276_1:RecordContent(arg_276_1.text_.text)
			end

			local var_279_10 = math.max(var_279_1, arg_276_1.talkMaxDuration)

			if var_279_0 <= arg_276_1.time_ and arg_276_1.time_ < var_279_0 + var_279_10 then
				arg_276_1.typewritter.percent = (arg_276_1.time_ - var_279_0) / var_279_10

				arg_276_1.typewritter:SetDirty()
			end

			if arg_276_1.time_ >= var_279_0 + var_279_10 and arg_276_1.time_ < var_279_0 + var_279_10 + arg_279_0 then
				arg_276_1.typewritter.percent = 1

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(true)
			end
		end

		arg_276_1.nodeConfigList_ = {}

		arg_276_1:InitPlayNodeList()
	end,
	Play321332064 = function(arg_280_0, arg_280_1)
		arg_280_1.time_ = 0
		arg_280_1.frameCnt_ = 0
		arg_280_1.state_ = "playing"
		arg_280_1.curTalkId_ = 321332064
		arg_280_1.duration_ = 15.1

		local var_280_0 = {
			zh = 9.433,
			ja = 15.1
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
				arg_280_0:Play321332065(arg_280_1)
			end
		end

		function arg_280_1.onSingleLineUpdate_(arg_283_0)
			local var_283_0 = 3.078
			local var_283_1 = 1

			if var_283_0 < arg_280_1.time_ and arg_280_1.time_ <= var_283_0 + arg_283_0 then
				local var_283_2 = "play"
				local var_283_3 = "effect"

				arg_280_1:AudioAction(var_283_2, var_283_3, "se_story_141", "se_story_141_boxing_drum03", "")
			end

			local var_283_4 = 0
			local var_283_5 = 0.7

			if var_283_4 < arg_280_1.time_ and arg_280_1.time_ <= var_283_4 + arg_283_0 then
				arg_280_1.talkMaxDuration = 0
				arg_280_1.dialogCg_.alpha = 1

				arg_280_1.dialog_:SetActive(true)
				SetActive(arg_280_1.leftNameGo_, true)

				local var_283_6 = arg_280_1:FormatText(StoryNameCfg[600].name)

				arg_280_1.leftNameTxt_.text = var_283_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_280_1.leftNameTxt_.transform)

				arg_280_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_280_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_280_1:RecordName(arg_280_1.leftNameTxt_.text)
				SetActive(arg_280_1.iconTrs_.gameObject, true)
				arg_280_1.iconController_:SetSelectedState("hero")

				arg_280_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4032")

				arg_280_1.callingController_:SetSelectedState("normal")

				arg_280_1.keyicon_.color = Color.New(1, 1, 1)
				arg_280_1.icon_.color = Color.New(1, 1, 1)

				local var_283_7 = arg_280_1:GetWordFromCfg(321332064)
				local var_283_8 = arg_280_1:FormatText(var_283_7.content)

				arg_280_1.text_.text = var_283_8

				LuaForUtil.ClearLinePrefixSymbol(arg_280_1.text_)

				local var_283_9 = 28
				local var_283_10 = utf8.len(var_283_8)
				local var_283_11 = var_283_9 <= 0 and var_283_5 or var_283_5 * (var_283_10 / var_283_9)

				if var_283_11 > 0 and var_283_5 < var_283_11 then
					arg_280_1.talkMaxDuration = var_283_11

					if var_283_11 + var_283_4 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_11 + var_283_4
					end
				end

				arg_280_1.text_.text = var_283_8
				arg_280_1.typewritter.percent = 0

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332064", "story_v_out_321332.awb") ~= 0 then
					local var_283_12 = manager.audio:GetVoiceLength("story_v_out_321332", "321332064", "story_v_out_321332.awb") / 1000

					if var_283_12 + var_283_4 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_12 + var_283_4
					end

					if var_283_7.prefab_name ~= "" and arg_280_1.actors_[var_283_7.prefab_name] ~= nil then
						local var_283_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_280_1.actors_[var_283_7.prefab_name].transform, "story_v_out_321332", "321332064", "story_v_out_321332.awb")

						arg_280_1:RecordAudio("321332064", var_283_13)
						arg_280_1:RecordAudio("321332064", var_283_13)
					else
						arg_280_1:AudioAction("play", "voice", "story_v_out_321332", "321332064", "story_v_out_321332.awb")
					end

					arg_280_1:RecordHistoryTalkVoice("story_v_out_321332", "321332064", "story_v_out_321332.awb")
				end

				arg_280_1:RecordContent(arg_280_1.text_.text)
			end

			local var_283_14 = math.max(var_283_5, arg_280_1.talkMaxDuration)

			if var_283_4 <= arg_280_1.time_ and arg_280_1.time_ < var_283_4 + var_283_14 then
				arg_280_1.typewritter.percent = (arg_280_1.time_ - var_283_4) / var_283_14

				arg_280_1.typewritter:SetDirty()
			end

			if arg_280_1.time_ >= var_283_4 + var_283_14 and arg_280_1.time_ < var_283_4 + var_283_14 + arg_283_0 then
				arg_280_1.typewritter.percent = 1

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(true)
			end
		end

		arg_280_1.nodeConfigList_ = {}

		arg_280_1:InitPlayNodeList()
	end,
	Play321332065 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 321332065
		arg_284_1.duration_ = 8.9

		local var_284_0 = {
			zh = 8.133,
			ja = 8.9
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
				arg_284_0:Play321332066(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			local var_287_0 = 0
			local var_287_1 = 0.425

			if var_287_0 < arg_284_1.time_ and arg_284_1.time_ <= var_287_0 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0
				arg_284_1.dialogCg_.alpha = 1

				arg_284_1.dialog_:SetActive(true)
				SetActive(arg_284_1.leftNameGo_, true)

				local var_287_2 = arg_284_1:FormatText(StoryNameCfg[600].name)

				arg_284_1.leftNameTxt_.text = var_287_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_284_1.leftNameTxt_.transform)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1.leftNameTxt_.text)
				SetActive(arg_284_1.iconTrs_.gameObject, true)
				arg_284_1.iconController_:SetSelectedState("hero")

				arg_284_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4032")

				arg_284_1.callingController_:SetSelectedState("normal")

				arg_284_1.keyicon_.color = Color.New(1, 1, 1)
				arg_284_1.icon_.color = Color.New(1, 1, 1)

				local var_287_3 = arg_284_1:GetWordFromCfg(321332065)
				local var_287_4 = arg_284_1:FormatText(var_287_3.content)

				arg_284_1.text_.text = var_287_4

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_5 = 17
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

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332065", "story_v_out_321332.awb") ~= 0 then
					local var_287_8 = manager.audio:GetVoiceLength("story_v_out_321332", "321332065", "story_v_out_321332.awb") / 1000

					if var_287_8 + var_287_0 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_8 + var_287_0
					end

					if var_287_3.prefab_name ~= "" and arg_284_1.actors_[var_287_3.prefab_name] ~= nil then
						local var_287_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_284_1.actors_[var_287_3.prefab_name].transform, "story_v_out_321332", "321332065", "story_v_out_321332.awb")

						arg_284_1:RecordAudio("321332065", var_287_9)
						arg_284_1:RecordAudio("321332065", var_287_9)
					else
						arg_284_1:AudioAction("play", "voice", "story_v_out_321332", "321332065", "story_v_out_321332.awb")
					end

					arg_284_1:RecordHistoryTalkVoice("story_v_out_321332", "321332065", "story_v_out_321332.awb")
				end

				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_10 = math.max(var_287_1, arg_284_1.talkMaxDuration)

			if var_287_0 <= arg_284_1.time_ and arg_284_1.time_ < var_287_0 + var_287_10 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - var_287_0) / var_287_10

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= var_287_0 + var_287_10 and arg_284_1.time_ < var_287_0 + var_287_10 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {}

		arg_284_1:InitPlayNodeList()
	end,
	Play321332066 = function(arg_288_0, arg_288_1)
		arg_288_1.time_ = 0
		arg_288_1.frameCnt_ = 0
		arg_288_1.state_ = "playing"
		arg_288_1.curTalkId_ = 321332066
		arg_288_1.duration_ = 7.97

		local var_288_0 = {
			zh = 6.366,
			ja = 7.966
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
				arg_288_0:Play321332067(arg_288_1)
			end
		end

		function arg_288_1.onSingleLineUpdate_(arg_291_0)
			local var_291_0 = 0
			local var_291_1 = 0.325

			if var_291_0 < arg_288_1.time_ and arg_288_1.time_ <= var_291_0 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0
				arg_288_1.dialogCg_.alpha = 1

				arg_288_1.dialog_:SetActive(true)
				SetActive(arg_288_1.leftNameGo_, true)

				local var_291_2 = arg_288_1:FormatText(StoryNameCfg[600].name)

				arg_288_1.leftNameTxt_.text = var_291_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_288_1.leftNameTxt_.transform)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1.leftNameTxt_.text)
				SetActive(arg_288_1.iconTrs_.gameObject, true)
				arg_288_1.iconController_:SetSelectedState("hero")

				arg_288_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4032")

				arg_288_1.callingController_:SetSelectedState("normal")

				arg_288_1.keyicon_.color = Color.New(1, 1, 1)
				arg_288_1.icon_.color = Color.New(1, 1, 1)

				local var_291_3 = arg_288_1:GetWordFromCfg(321332066)
				local var_291_4 = arg_288_1:FormatText(var_291_3.content)

				arg_288_1.text_.text = var_291_4

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_5 = 13
				local var_291_6 = utf8.len(var_291_4)
				local var_291_7 = var_291_5 <= 0 and var_291_1 or var_291_1 * (var_291_6 / var_291_5)

				if var_291_7 > 0 and var_291_1 < var_291_7 then
					arg_288_1.talkMaxDuration = var_291_7

					if var_291_7 + var_291_0 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_7 + var_291_0
					end
				end

				arg_288_1.text_.text = var_291_4
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332066", "story_v_out_321332.awb") ~= 0 then
					local var_291_8 = manager.audio:GetVoiceLength("story_v_out_321332", "321332066", "story_v_out_321332.awb") / 1000

					if var_291_8 + var_291_0 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_8 + var_291_0
					end

					if var_291_3.prefab_name ~= "" and arg_288_1.actors_[var_291_3.prefab_name] ~= nil then
						local var_291_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_288_1.actors_[var_291_3.prefab_name].transform, "story_v_out_321332", "321332066", "story_v_out_321332.awb")

						arg_288_1:RecordAudio("321332066", var_291_9)
						arg_288_1:RecordAudio("321332066", var_291_9)
					else
						arg_288_1:AudioAction("play", "voice", "story_v_out_321332", "321332066", "story_v_out_321332.awb")
					end

					arg_288_1:RecordHistoryTalkVoice("story_v_out_321332", "321332066", "story_v_out_321332.awb")
				end

				arg_288_1:RecordContent(arg_288_1.text_.text)
			end

			local var_291_10 = math.max(var_291_1, arg_288_1.talkMaxDuration)

			if var_291_0 <= arg_288_1.time_ and arg_288_1.time_ < var_291_0 + var_291_10 then
				arg_288_1.typewritter.percent = (arg_288_1.time_ - var_291_0) / var_291_10

				arg_288_1.typewritter:SetDirty()
			end

			if arg_288_1.time_ >= var_291_0 + var_291_10 and arg_288_1.time_ < var_291_0 + var_291_10 + arg_291_0 then
				arg_288_1.typewritter.percent = 1

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(true)
			end
		end

		arg_288_1.nodeConfigList_ = {}

		arg_288_1:InitPlayNodeList()
	end,
	Play321332067 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 321332067
		arg_292_1.duration_ = 5

		SetActive(arg_292_1.tipsGo_, false)

		function arg_292_1.onSingleLineFinish_()
			arg_292_1.onSingleLineUpdate_ = nil
			arg_292_1.onSingleLineFinish_ = nil
			arg_292_1.state_ = "waiting"
		end

		function arg_292_1.playNext_(arg_294_0)
			if arg_294_0 == 1 then
				arg_292_0:Play321332068(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			local var_295_0 = 0
			local var_295_1 = 1.45

			if var_295_0 < arg_292_1.time_ and arg_292_1.time_ <= var_295_0 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0
				arg_292_1.dialogCg_.alpha = 1

				arg_292_1.dialog_:SetActive(true)
				SetActive(arg_292_1.leftNameGo_, false)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_292_1.iconTrs_.gameObject, false)
				arg_292_1.callingController_:SetSelectedState("normal")

				local var_295_2 = arg_292_1:GetWordFromCfg(321332067)
				local var_295_3 = arg_292_1:FormatText(var_295_2.content)

				arg_292_1.text_.text = var_295_3

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_4 = 58
				local var_295_5 = utf8.len(var_295_3)
				local var_295_6 = var_295_4 <= 0 and var_295_1 or var_295_1 * (var_295_5 / var_295_4)

				if var_295_6 > 0 and var_295_1 < var_295_6 then
					arg_292_1.talkMaxDuration = var_295_6

					if var_295_6 + var_295_0 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_6 + var_295_0
					end
				end

				arg_292_1.text_.text = var_295_3
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)
				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_7 = math.max(var_295_1, arg_292_1.talkMaxDuration)

			if var_295_0 <= arg_292_1.time_ and arg_292_1.time_ < var_295_0 + var_295_7 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - var_295_0) / var_295_7

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= var_295_0 + var_295_7 and arg_292_1.time_ < var_295_0 + var_295_7 + arg_295_0 then
				arg_292_1.typewritter.percent = 1

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(true)
			end
		end

		arg_292_1.nodeConfigList_ = {}

		arg_292_1:InitPlayNodeList()
	end,
	Play321332068 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 321332068
		arg_296_1.duration_ = 3.97

		local var_296_0 = {
			zh = 3.966,
			ja = 3.4
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
				arg_296_0:Play321332069(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			local var_299_0 = 0.15
			local var_299_1 = 1
			local var_299_2 = manager.audio:GetVoiceLength("story_v_out_321332", "321332068", "") / 1000

			if var_299_2 > 0 and var_299_1 < var_299_2 and var_299_2 + var_299_0 > arg_296_1.duration_ then
				local var_299_3 = var_299_2

				arg_296_1.duration_ = var_299_2 + var_299_0
			end

			if var_299_0 < arg_296_1.time_ and arg_296_1.time_ <= var_299_0 + arg_299_0 then
				local var_299_4 = "play"
				local var_299_5 = "voice"

				arg_296_1:AudioAction(var_299_4, var_299_5, "story_v_out_321332", "321332068", "")
			end

			local var_299_6 = 0.704
			local var_299_7 = 1

			if var_299_6 < arg_296_1.time_ and arg_296_1.time_ <= var_299_6 + arg_299_0 then
				local var_299_8 = "play"
				local var_299_9 = "effect"

				arg_296_1:AudioAction(var_299_8, var_299_9, "se_story_141", "se_story_141_boxing_drum01", "")
			end

			local var_299_10 = 0
			local var_299_11 = 1.375

			if var_299_10 < arg_296_1.time_ and arg_296_1.time_ <= var_299_10 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0
				arg_296_1.dialogCg_.alpha = 1

				arg_296_1.dialog_:SetActive(true)
				SetActive(arg_296_1.leftNameGo_, false)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_296_1.iconTrs_.gameObject, false)
				arg_296_1.callingController_:SetSelectedState("normal")

				local var_299_12 = arg_296_1:GetWordFromCfg(321332068)
				local var_299_13 = arg_296_1:FormatText(var_299_12.content)

				arg_296_1.text_.text = var_299_13

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_14 = 55
				local var_299_15 = utf8.len(var_299_13)
				local var_299_16 = var_299_14 <= 0 and var_299_11 or var_299_11 * (var_299_15 / var_299_14)

				if var_299_16 > 0 and var_299_11 < var_299_16 then
					arg_296_1.talkMaxDuration = var_299_16

					if var_299_16 + var_299_10 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_16 + var_299_10
					end
				end

				arg_296_1.text_.text = var_299_13
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332068", "story_v_out_321332.awb") ~= 0 then
					local var_299_17 = manager.audio:GetVoiceLength("story_v_out_321332", "321332068", "story_v_out_321332.awb") / 1000

					if var_299_17 + var_299_10 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_17 + var_299_10
					end

					if var_299_12.prefab_name ~= "" and arg_296_1.actors_[var_299_12.prefab_name] ~= nil then
						local var_299_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_296_1.actors_[var_299_12.prefab_name].transform, "story_v_out_321332", "321332068", "story_v_out_321332.awb")

						arg_296_1:RecordAudio("321332068", var_299_18)
						arg_296_1:RecordAudio("321332068", var_299_18)
					else
						arg_296_1:AudioAction("play", "voice", "story_v_out_321332", "321332068", "story_v_out_321332.awb")
					end

					arg_296_1:RecordHistoryTalkVoice("story_v_out_321332", "321332068", "story_v_out_321332.awb")
				end

				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_19 = math.max(var_299_11, arg_296_1.talkMaxDuration)

			if var_299_10 <= arg_296_1.time_ and arg_296_1.time_ < var_299_10 + var_299_19 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - var_299_10) / var_299_19

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= var_299_10 + var_299_19 and arg_296_1.time_ < var_299_10 + var_299_19 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {}

		arg_296_1:InitPlayNodeList()
	end,
	Play321332069 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 321332069
		arg_300_1.duration_ = 5

		SetActive(arg_300_1.tipsGo_, false)

		function arg_300_1.onSingleLineFinish_()
			arg_300_1.onSingleLineUpdate_ = nil
			arg_300_1.onSingleLineFinish_ = nil
			arg_300_1.state_ = "waiting"
		end

		function arg_300_1.playNext_(arg_302_0)
			if arg_302_0 == 1 then
				arg_300_0:Play321332070(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			local var_303_0 = 0
			local var_303_1 = 1.725

			if var_303_0 < arg_300_1.time_ and arg_300_1.time_ <= var_303_0 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0
				arg_300_1.dialogCg_.alpha = 1

				arg_300_1.dialog_:SetActive(true)
				SetActive(arg_300_1.leftNameGo_, false)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_300_1.iconTrs_.gameObject, false)
				arg_300_1.callingController_:SetSelectedState("normal")

				local var_303_2 = arg_300_1:GetWordFromCfg(321332069)
				local var_303_3 = arg_300_1:FormatText(var_303_2.content)

				arg_300_1.text_.text = var_303_3

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_4 = 69
				local var_303_5 = utf8.len(var_303_3)
				local var_303_6 = var_303_4 <= 0 and var_303_1 or var_303_1 * (var_303_5 / var_303_4)

				if var_303_6 > 0 and var_303_1 < var_303_6 then
					arg_300_1.talkMaxDuration = var_303_6

					if var_303_6 + var_303_0 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_6 + var_303_0
					end
				end

				arg_300_1.text_.text = var_303_3
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)
				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_7 = math.max(var_303_1, arg_300_1.talkMaxDuration)

			if var_303_0 <= arg_300_1.time_ and arg_300_1.time_ < var_303_0 + var_303_7 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - var_303_0) / var_303_7

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= var_303_0 + var_303_7 and arg_300_1.time_ < var_303_0 + var_303_7 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {}

		arg_300_1:InitPlayNodeList()
	end,
	Play321332070 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 321332070
		arg_304_1.duration_ = 8.73

		local var_304_0 = {
			zh = 6.4,
			ja = 8.733
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
				arg_304_0:Play321332071(arg_304_1)
			end
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			local var_307_0 = "4037ui_story"

			if arg_304_1.actors_[var_307_0] == nil then
				local var_307_1 = Asset.Load("Char/" .. "4037ui_story")

				if not isNil(var_307_1) then
					local var_307_2 = Object.Instantiate(Asset.Load("Char/" .. "4037ui_story"), arg_304_1.stage_.transform)

					var_307_2.name = var_307_0
					var_307_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_304_1.actors_[var_307_0] = var_307_2

					local var_307_3 = var_307_2:GetComponentInChildren(typeof(CharacterEffect))

					var_307_3.enabled = true

					local var_307_4 = GameObjectTools.GetOrAddComponent(var_307_2, typeof(DynamicBoneHelper))

					if var_307_4 then
						var_307_4:EnableDynamicBone(false)
					end

					arg_304_1:ShowWeapon(var_307_3.transform, false)

					arg_304_1.var_[var_307_0 .. "Animator"] = var_307_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_304_1.var_[var_307_0 .. "Animator"].applyRootMotion = true
					arg_304_1.var_[var_307_0 .. "LipSync"] = var_307_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_307_5 = arg_304_1.actors_["4037ui_story"].transform
			local var_307_6 = 0

			if var_307_6 < arg_304_1.time_ and arg_304_1.time_ <= var_307_6 + arg_307_0 then
				arg_304_1.var_.moveOldPos4037ui_story = var_307_5.localPosition
			end

			local var_307_7 = 0.001

			if var_307_6 <= arg_304_1.time_ and arg_304_1.time_ < var_307_6 + var_307_7 then
				local var_307_8 = (arg_304_1.time_ - var_307_6) / var_307_7
				local var_307_9 = Vector3.New(0, -1.12, -6.2)

				var_307_5.localPosition = Vector3.Lerp(arg_304_1.var_.moveOldPos4037ui_story, var_307_9, var_307_8)

				local var_307_10 = manager.ui.mainCamera.transform.position - var_307_5.position

				var_307_5.forward = Vector3.New(var_307_10.x, var_307_10.y, var_307_10.z)

				local var_307_11 = var_307_5.localEulerAngles

				var_307_11.z = 0
				var_307_11.x = 0
				var_307_5.localEulerAngles = var_307_11
			end

			if arg_304_1.time_ >= var_307_6 + var_307_7 and arg_304_1.time_ < var_307_6 + var_307_7 + arg_307_0 then
				var_307_5.localPosition = Vector3.New(0, -1.12, -6.2)

				local var_307_12 = manager.ui.mainCamera.transform.position - var_307_5.position

				var_307_5.forward = Vector3.New(var_307_12.x, var_307_12.y, var_307_12.z)

				local var_307_13 = var_307_5.localEulerAngles

				var_307_13.z = 0
				var_307_13.x = 0
				var_307_5.localEulerAngles = var_307_13
			end

			local var_307_14 = arg_304_1.actors_["4037ui_story"]
			local var_307_15 = 0

			if var_307_15 < arg_304_1.time_ and arg_304_1.time_ <= var_307_15 + arg_307_0 and not isNil(var_307_14) and arg_304_1.var_.characterEffect4037ui_story == nil then
				arg_304_1.var_.characterEffect4037ui_story = var_307_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_307_16 = 0.200000002980232

			if var_307_15 <= arg_304_1.time_ and arg_304_1.time_ < var_307_15 + var_307_16 and not isNil(var_307_14) then
				local var_307_17 = (arg_304_1.time_ - var_307_15) / var_307_16

				if arg_304_1.var_.characterEffect4037ui_story and not isNil(var_307_14) then
					arg_304_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_304_1.time_ >= var_307_15 + var_307_16 and arg_304_1.time_ < var_307_15 + var_307_16 + arg_307_0 and not isNil(var_307_14) and arg_304_1.var_.characterEffect4037ui_story then
				arg_304_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			local var_307_18 = 0

			if var_307_18 < arg_304_1.time_ and arg_304_1.time_ <= var_307_18 + arg_307_0 then
				arg_304_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action1_1")
			end

			local var_307_19 = 0

			if var_307_19 < arg_304_1.time_ and arg_304_1.time_ <= var_307_19 + arg_307_0 then
				arg_304_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_307_20 = arg_304_1.actors_["4037ui_story"]
			local var_307_21 = 0

			if var_307_21 < arg_304_1.time_ and arg_304_1.time_ <= var_307_21 + arg_307_0 then
				if arg_304_1.var_.characterEffect4037ui_story == nil then
					arg_304_1.var_.characterEffect4037ui_story = var_307_20:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_307_22 = arg_304_1.var_.characterEffect4037ui_story

				var_307_22.imageEffect:turnOff()

				var_307_22.interferenceEffect.enabled = true
				var_307_22.interferenceEffect.noise = 0.001
				var_307_22.interferenceEffect.simTimeScale = 1
				var_307_22.interferenceEffect.geometryOutlineColor = Color.New(0.509434, 0.509434, 0.509434, 1)
			end

			local var_307_23 = arg_304_1.actors_["4037ui_story"]
			local var_307_24 = 0
			local var_307_25 = 0.2

			if var_307_24 < arg_304_1.time_ and arg_304_1.time_ <= var_307_24 + arg_307_0 then
				if arg_304_1.var_.characterEffect4037ui_story == nil then
					arg_304_1.var_.characterEffect4037ui_story = var_307_23:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_304_1.var_.characterEffect4037ui_story.imageEffect:turnOn(false)
			end

			local var_307_26 = 0
			local var_307_27 = 0.5

			if var_307_26 < arg_304_1.time_ and arg_304_1.time_ <= var_307_26 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0
				arg_304_1.dialogCg_.alpha = 1

				arg_304_1.dialog_:SetActive(true)
				SetActive(arg_304_1.leftNameGo_, true)

				local var_307_28 = arg_304_1:FormatText(StoryNameCfg[453].name)

				arg_304_1.leftNameTxt_.text = var_307_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_304_1.leftNameTxt_.transform)

				arg_304_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_304_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_304_1:RecordName(arg_304_1.leftNameTxt_.text)
				SetActive(arg_304_1.iconTrs_.gameObject, false)
				arg_304_1.callingController_:SetSelectedState("normal")

				local var_307_29 = arg_304_1:GetWordFromCfg(321332070)
				local var_307_30 = arg_304_1:FormatText(var_307_29.content)

				arg_304_1.text_.text = var_307_30

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_31 = 20
				local var_307_32 = utf8.len(var_307_30)
				local var_307_33 = var_307_31 <= 0 and var_307_27 or var_307_27 * (var_307_32 / var_307_31)

				if var_307_33 > 0 and var_307_27 < var_307_33 then
					arg_304_1.talkMaxDuration = var_307_33

					if var_307_33 + var_307_26 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_33 + var_307_26
					end
				end

				arg_304_1.text_.text = var_307_30
				arg_304_1.typewritter.percent = 0

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332070", "story_v_out_321332.awb") ~= 0 then
					local var_307_34 = manager.audio:GetVoiceLength("story_v_out_321332", "321332070", "story_v_out_321332.awb") / 1000

					if var_307_34 + var_307_26 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_34 + var_307_26
					end

					if var_307_29.prefab_name ~= "" and arg_304_1.actors_[var_307_29.prefab_name] ~= nil then
						local var_307_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_304_1.actors_[var_307_29.prefab_name].transform, "story_v_out_321332", "321332070", "story_v_out_321332.awb")

						arg_304_1:RecordAudio("321332070", var_307_35)
						arg_304_1:RecordAudio("321332070", var_307_35)
					else
						arg_304_1:AudioAction("play", "voice", "story_v_out_321332", "321332070", "story_v_out_321332.awb")
					end

					arg_304_1:RecordHistoryTalkVoice("story_v_out_321332", "321332070", "story_v_out_321332.awb")
				end

				arg_304_1:RecordContent(arg_304_1.text_.text)
			end

			local var_307_36 = math.max(var_307_27, arg_304_1.talkMaxDuration)

			if var_307_26 <= arg_304_1.time_ and arg_304_1.time_ < var_307_26 + var_307_36 then
				arg_304_1.typewritter.percent = (arg_304_1.time_ - var_307_26) / var_307_36

				arg_304_1.typewritter:SetDirty()
			end

			if arg_304_1.time_ >= var_307_26 + var_307_36 and arg_304_1.time_ < var_307_26 + var_307_36 + arg_307_0 then
				arg_304_1.typewritter.percent = 1

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(true)
			end
		end

		arg_304_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_304_1:InitPlayNodeList()
	end,
	Play321332071 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 321332071
		arg_308_1.duration_ = 8.37

		local var_308_0 = {
			zh = 7.4,
			ja = 8.366
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
				arg_308_0:Play321332072(arg_308_1)
			end
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			local var_311_0 = arg_308_1.actors_["4037ui_story"]
			local var_311_1 = 0

			if var_311_1 < arg_308_1.time_ and arg_308_1.time_ <= var_311_1 + arg_311_0 and not isNil(var_311_0) and arg_308_1.var_.characterEffect4037ui_story == nil then
				arg_308_1.var_.characterEffect4037ui_story = var_311_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_311_2 = 0.200000002980232

			if var_311_1 <= arg_308_1.time_ and arg_308_1.time_ < var_311_1 + var_311_2 and not isNil(var_311_0) then
				local var_311_3 = (arg_308_1.time_ - var_311_1) / var_311_2

				if arg_308_1.var_.characterEffect4037ui_story and not isNil(var_311_0) then
					local var_311_4 = Mathf.Lerp(0, 0.5, var_311_3)

					arg_308_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_308_1.var_.characterEffect4037ui_story.fillRatio = var_311_4
				end
			end

			if arg_308_1.time_ >= var_311_1 + var_311_2 and arg_308_1.time_ < var_311_1 + var_311_2 + arg_311_0 and not isNil(var_311_0) and arg_308_1.var_.characterEffect4037ui_story then
				local var_311_5 = 0.5

				arg_308_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_308_1.var_.characterEffect4037ui_story.fillRatio = var_311_5
			end

			local var_311_6 = 0
			local var_311_7 = 0.55

			if var_311_6 < arg_308_1.time_ and arg_308_1.time_ <= var_311_6 + arg_311_0 then
				arg_308_1.talkMaxDuration = 0
				arg_308_1.dialogCg_.alpha = 1

				arg_308_1.dialog_:SetActive(true)
				SetActive(arg_308_1.leftNameGo_, true)

				local var_311_8 = arg_308_1:FormatText(StoryNameCfg[600].name)

				arg_308_1.leftNameTxt_.text = var_311_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_308_1.leftNameTxt_.transform)

				arg_308_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_308_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_308_1:RecordName(arg_308_1.leftNameTxt_.text)
				SetActive(arg_308_1.iconTrs_.gameObject, true)
				arg_308_1.iconController_:SetSelectedState("hero")

				arg_308_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4032")

				arg_308_1.callingController_:SetSelectedState("normal")

				arg_308_1.keyicon_.color = Color.New(1, 1, 1)
				arg_308_1.icon_.color = Color.New(1, 1, 1)

				local var_311_9 = arg_308_1:GetWordFromCfg(321332071)
				local var_311_10 = arg_308_1:FormatText(var_311_9.content)

				arg_308_1.text_.text = var_311_10

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_11 = 22
				local var_311_12 = utf8.len(var_311_10)
				local var_311_13 = var_311_11 <= 0 and var_311_7 or var_311_7 * (var_311_12 / var_311_11)

				if var_311_13 > 0 and var_311_7 < var_311_13 then
					arg_308_1.talkMaxDuration = var_311_13

					if var_311_13 + var_311_6 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_13 + var_311_6
					end
				end

				arg_308_1.text_.text = var_311_10
				arg_308_1.typewritter.percent = 0

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332071", "story_v_out_321332.awb") ~= 0 then
					local var_311_14 = manager.audio:GetVoiceLength("story_v_out_321332", "321332071", "story_v_out_321332.awb") / 1000

					if var_311_14 + var_311_6 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_14 + var_311_6
					end

					if var_311_9.prefab_name ~= "" and arg_308_1.actors_[var_311_9.prefab_name] ~= nil then
						local var_311_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_308_1.actors_[var_311_9.prefab_name].transform, "story_v_out_321332", "321332071", "story_v_out_321332.awb")

						arg_308_1:RecordAudio("321332071", var_311_15)
						arg_308_1:RecordAudio("321332071", var_311_15)
					else
						arg_308_1:AudioAction("play", "voice", "story_v_out_321332", "321332071", "story_v_out_321332.awb")
					end

					arg_308_1:RecordHistoryTalkVoice("story_v_out_321332", "321332071", "story_v_out_321332.awb")
				end

				arg_308_1:RecordContent(arg_308_1.text_.text)
			end

			local var_311_16 = math.max(var_311_7, arg_308_1.talkMaxDuration)

			if var_311_6 <= arg_308_1.time_ and arg_308_1.time_ < var_311_6 + var_311_16 then
				arg_308_1.typewritter.percent = (arg_308_1.time_ - var_311_6) / var_311_16

				arg_308_1.typewritter:SetDirty()
			end

			if arg_308_1.time_ >= var_311_6 + var_311_16 and arg_308_1.time_ < var_311_6 + var_311_16 + arg_311_0 then
				arg_308_1.typewritter.percent = 1

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(true)
			end
		end

		arg_308_1.nodeConfigList_ = {}

		arg_308_1:InitPlayNodeList()
	end,
	Play321332072 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 321332072
		arg_312_1.duration_ = 12.2

		local var_312_0 = {
			zh = 10.9,
			ja = 12.2
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
				arg_312_0:Play321332073(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			local var_315_0 = 5.352
			local var_315_1 = 1

			if var_315_0 < arg_312_1.time_ and arg_312_1.time_ <= var_315_0 + arg_315_0 then
				local var_315_2 = "play"
				local var_315_3 = "effect"

				arg_312_1:AudioAction(var_315_2, var_315_3, "se_story_141", "se_story_141_boxing_drum02", "")
			end

			local var_315_4 = 0
			local var_315_5 = 0.8

			if var_315_4 < arg_312_1.time_ and arg_312_1.time_ <= var_315_4 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0
				arg_312_1.dialogCg_.alpha = 1

				arg_312_1.dialog_:SetActive(true)
				SetActive(arg_312_1.leftNameGo_, true)

				local var_315_6 = arg_312_1:FormatText(StoryNameCfg[600].name)

				arg_312_1.leftNameTxt_.text = var_315_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_312_1.leftNameTxt_.transform)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1.leftNameTxt_.text)
				SetActive(arg_312_1.iconTrs_.gameObject, true)
				arg_312_1.iconController_:SetSelectedState("hero")

				arg_312_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4032")

				arg_312_1.callingController_:SetSelectedState("normal")

				arg_312_1.keyicon_.color = Color.New(1, 1, 1)
				arg_312_1.icon_.color = Color.New(1, 1, 1)

				local var_315_7 = arg_312_1:GetWordFromCfg(321332072)
				local var_315_8 = arg_312_1:FormatText(var_315_7.content)

				arg_312_1.text_.text = var_315_8

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_9 = 32
				local var_315_10 = utf8.len(var_315_8)
				local var_315_11 = var_315_9 <= 0 and var_315_5 or var_315_5 * (var_315_10 / var_315_9)

				if var_315_11 > 0 and var_315_5 < var_315_11 then
					arg_312_1.talkMaxDuration = var_315_11

					if var_315_11 + var_315_4 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_11 + var_315_4
					end
				end

				arg_312_1.text_.text = var_315_8
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332072", "story_v_out_321332.awb") ~= 0 then
					local var_315_12 = manager.audio:GetVoiceLength("story_v_out_321332", "321332072", "story_v_out_321332.awb") / 1000

					if var_315_12 + var_315_4 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_12 + var_315_4
					end

					if var_315_7.prefab_name ~= "" and arg_312_1.actors_[var_315_7.prefab_name] ~= nil then
						local var_315_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_312_1.actors_[var_315_7.prefab_name].transform, "story_v_out_321332", "321332072", "story_v_out_321332.awb")

						arg_312_1:RecordAudio("321332072", var_315_13)
						arg_312_1:RecordAudio("321332072", var_315_13)
					else
						arg_312_1:AudioAction("play", "voice", "story_v_out_321332", "321332072", "story_v_out_321332.awb")
					end

					arg_312_1:RecordHistoryTalkVoice("story_v_out_321332", "321332072", "story_v_out_321332.awb")
				end

				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_14 = math.max(var_315_5, arg_312_1.talkMaxDuration)

			if var_315_4 <= arg_312_1.time_ and arg_312_1.time_ < var_315_4 + var_315_14 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - var_315_4) / var_315_14

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= var_315_4 + var_315_14 and arg_312_1.time_ < var_315_4 + var_315_14 + arg_315_0 then
				arg_312_1.typewritter.percent = 1

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(true)
			end
		end

		arg_312_1.nodeConfigList_ = {}

		arg_312_1:InitPlayNodeList()
	end,
	Play321332073 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 321332073
		arg_316_1.duration_ = 4.63

		local var_316_0 = {
			zh = 4.633,
			ja = 2.833
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
				arg_316_0:Play321332074(arg_316_1)
			end
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			local var_319_0 = arg_316_1.actors_["4037ui_story"]
			local var_319_1 = 0

			if var_319_1 < arg_316_1.time_ and arg_316_1.time_ <= var_319_1 + arg_319_0 and not isNil(var_319_0) and arg_316_1.var_.characterEffect4037ui_story == nil then
				arg_316_1.var_.characterEffect4037ui_story = var_319_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_319_2 = 0.200000002980232

			if var_319_1 <= arg_316_1.time_ and arg_316_1.time_ < var_319_1 + var_319_2 and not isNil(var_319_0) then
				local var_319_3 = (arg_316_1.time_ - var_319_1) / var_319_2

				if arg_316_1.var_.characterEffect4037ui_story and not isNil(var_319_0) then
					arg_316_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_316_1.time_ >= var_319_1 + var_319_2 and arg_316_1.time_ < var_319_1 + var_319_2 + arg_319_0 and not isNil(var_319_0) and arg_316_1.var_.characterEffect4037ui_story then
				arg_316_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			local var_319_4 = 0

			if var_319_4 < arg_316_1.time_ and arg_316_1.time_ <= var_319_4 + arg_319_0 then
				arg_316_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action2_1")
			end

			local var_319_5 = 0

			if var_319_5 < arg_316_1.time_ and arg_316_1.time_ <= var_319_5 + arg_319_0 then
				arg_316_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_319_6 = 0
			local var_319_7 = 0.125

			if var_319_6 < arg_316_1.time_ and arg_316_1.time_ <= var_319_6 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0
				arg_316_1.dialogCg_.alpha = 1

				arg_316_1.dialog_:SetActive(true)
				SetActive(arg_316_1.leftNameGo_, true)

				local var_319_8 = arg_316_1:FormatText(StoryNameCfg[453].name)

				arg_316_1.leftNameTxt_.text = var_319_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_316_1.leftNameTxt_.transform)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1.leftNameTxt_.text)
				SetActive(arg_316_1.iconTrs_.gameObject, false)
				arg_316_1.callingController_:SetSelectedState("normal")

				local var_319_9 = arg_316_1:GetWordFromCfg(321332073)
				local var_319_10 = arg_316_1:FormatText(var_319_9.content)

				arg_316_1.text_.text = var_319_10

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_11 = 5
				local var_319_12 = utf8.len(var_319_10)
				local var_319_13 = var_319_11 <= 0 and var_319_7 or var_319_7 * (var_319_12 / var_319_11)

				if var_319_13 > 0 and var_319_7 < var_319_13 then
					arg_316_1.talkMaxDuration = var_319_13

					if var_319_13 + var_319_6 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_13 + var_319_6
					end
				end

				arg_316_1.text_.text = var_319_10
				arg_316_1.typewritter.percent = 0

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332073", "story_v_out_321332.awb") ~= 0 then
					local var_319_14 = manager.audio:GetVoiceLength("story_v_out_321332", "321332073", "story_v_out_321332.awb") / 1000

					if var_319_14 + var_319_6 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_14 + var_319_6
					end

					if var_319_9.prefab_name ~= "" and arg_316_1.actors_[var_319_9.prefab_name] ~= nil then
						local var_319_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_316_1.actors_[var_319_9.prefab_name].transform, "story_v_out_321332", "321332073", "story_v_out_321332.awb")

						arg_316_1:RecordAudio("321332073", var_319_15)
						arg_316_1:RecordAudio("321332073", var_319_15)
					else
						arg_316_1:AudioAction("play", "voice", "story_v_out_321332", "321332073", "story_v_out_321332.awb")
					end

					arg_316_1:RecordHistoryTalkVoice("story_v_out_321332", "321332073", "story_v_out_321332.awb")
				end

				arg_316_1:RecordContent(arg_316_1.text_.text)
			end

			local var_319_16 = math.max(var_319_7, arg_316_1.talkMaxDuration)

			if var_319_6 <= arg_316_1.time_ and arg_316_1.time_ < var_319_6 + var_319_16 then
				arg_316_1.typewritter.percent = (arg_316_1.time_ - var_319_6) / var_319_16

				arg_316_1.typewritter:SetDirty()
			end

			if arg_316_1.time_ >= var_319_6 + var_319_16 and arg_316_1.time_ < var_319_6 + var_319_16 + arg_319_0 then
				arg_316_1.typewritter.percent = 1

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(true)
			end
		end

		arg_316_1.nodeConfigList_ = {}

		arg_316_1:InitPlayNodeList()
	end,
	Play321332074 = function(arg_320_0, arg_320_1)
		arg_320_1.time_ = 0
		arg_320_1.frameCnt_ = 0
		arg_320_1.state_ = "playing"
		arg_320_1.curTalkId_ = 321332074
		arg_320_1.duration_ = 6.93

		local var_320_0 = {
			zh = 4.266,
			ja = 6.933
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
				arg_320_0:Play321332075(arg_320_1)
			end
		end

		function arg_320_1.onSingleLineUpdate_(arg_323_0)
			local var_323_0 = arg_320_1.actors_["4037ui_story"]
			local var_323_1 = 0

			if var_323_1 < arg_320_1.time_ and arg_320_1.time_ <= var_323_1 + arg_323_0 and not isNil(var_323_0) and arg_320_1.var_.characterEffect4037ui_story == nil then
				arg_320_1.var_.characterEffect4037ui_story = var_323_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_323_2 = 0.200000002980232

			if var_323_1 <= arg_320_1.time_ and arg_320_1.time_ < var_323_1 + var_323_2 and not isNil(var_323_0) then
				local var_323_3 = (arg_320_1.time_ - var_323_1) / var_323_2

				if arg_320_1.var_.characterEffect4037ui_story and not isNil(var_323_0) then
					local var_323_4 = Mathf.Lerp(0, 0.5, var_323_3)

					arg_320_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_320_1.var_.characterEffect4037ui_story.fillRatio = var_323_4
				end
			end

			if arg_320_1.time_ >= var_323_1 + var_323_2 and arg_320_1.time_ < var_323_1 + var_323_2 + arg_323_0 and not isNil(var_323_0) and arg_320_1.var_.characterEffect4037ui_story then
				local var_323_5 = 0.5

				arg_320_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_320_1.var_.characterEffect4037ui_story.fillRatio = var_323_5
			end

			local var_323_6 = 0
			local var_323_7 = 0.325

			if var_323_6 < arg_320_1.time_ and arg_320_1.time_ <= var_323_6 + arg_323_0 then
				arg_320_1.talkMaxDuration = 0
				arg_320_1.dialogCg_.alpha = 1

				arg_320_1.dialog_:SetActive(true)
				SetActive(arg_320_1.leftNameGo_, true)

				local var_323_8 = arg_320_1:FormatText(StoryNameCfg[600].name)

				arg_320_1.leftNameTxt_.text = var_323_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_320_1.leftNameTxt_.transform)

				arg_320_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_320_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_320_1:RecordName(arg_320_1.leftNameTxt_.text)
				SetActive(arg_320_1.iconTrs_.gameObject, true)
				arg_320_1.iconController_:SetSelectedState("hero")

				arg_320_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4032")

				arg_320_1.callingController_:SetSelectedState("normal")

				arg_320_1.keyicon_.color = Color.New(1, 1, 1)
				arg_320_1.icon_.color = Color.New(1, 1, 1)

				local var_323_9 = arg_320_1:GetWordFromCfg(321332074)
				local var_323_10 = arg_320_1:FormatText(var_323_9.content)

				arg_320_1.text_.text = var_323_10

				LuaForUtil.ClearLinePrefixSymbol(arg_320_1.text_)

				local var_323_11 = 13
				local var_323_12 = utf8.len(var_323_10)
				local var_323_13 = var_323_11 <= 0 and var_323_7 or var_323_7 * (var_323_12 / var_323_11)

				if var_323_13 > 0 and var_323_7 < var_323_13 then
					arg_320_1.talkMaxDuration = var_323_13

					if var_323_13 + var_323_6 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_13 + var_323_6
					end
				end

				arg_320_1.text_.text = var_323_10
				arg_320_1.typewritter.percent = 0

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332074", "story_v_out_321332.awb") ~= 0 then
					local var_323_14 = manager.audio:GetVoiceLength("story_v_out_321332", "321332074", "story_v_out_321332.awb") / 1000

					if var_323_14 + var_323_6 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_14 + var_323_6
					end

					if var_323_9.prefab_name ~= "" and arg_320_1.actors_[var_323_9.prefab_name] ~= nil then
						local var_323_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_320_1.actors_[var_323_9.prefab_name].transform, "story_v_out_321332", "321332074", "story_v_out_321332.awb")

						arg_320_1:RecordAudio("321332074", var_323_15)
						arg_320_1:RecordAudio("321332074", var_323_15)
					else
						arg_320_1:AudioAction("play", "voice", "story_v_out_321332", "321332074", "story_v_out_321332.awb")
					end

					arg_320_1:RecordHistoryTalkVoice("story_v_out_321332", "321332074", "story_v_out_321332.awb")
				end

				arg_320_1:RecordContent(arg_320_1.text_.text)
			end

			local var_323_16 = math.max(var_323_7, arg_320_1.talkMaxDuration)

			if var_323_6 <= arg_320_1.time_ and arg_320_1.time_ < var_323_6 + var_323_16 then
				arg_320_1.typewritter.percent = (arg_320_1.time_ - var_323_6) / var_323_16

				arg_320_1.typewritter:SetDirty()
			end

			if arg_320_1.time_ >= var_323_6 + var_323_16 and arg_320_1.time_ < var_323_6 + var_323_16 + arg_323_0 then
				arg_320_1.typewritter.percent = 1

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(true)
			end
		end

		arg_320_1.nodeConfigList_ = {}

		arg_320_1:InitPlayNodeList()
	end,
	Play321332075 = function(arg_324_0, arg_324_1)
		arg_324_1.time_ = 0
		arg_324_1.frameCnt_ = 0
		arg_324_1.state_ = "playing"
		arg_324_1.curTalkId_ = 321332075
		arg_324_1.duration_ = 13.6

		local var_324_0 = {
			zh = 9.866,
			ja = 13.6
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
				arg_324_0:Play321332076(arg_324_1)
			end
		end

		function arg_324_1.onSingleLineUpdate_(arg_327_0)
			local var_327_0 = 0
			local var_327_1 = 0.775

			if var_327_0 < arg_324_1.time_ and arg_324_1.time_ <= var_327_0 + arg_327_0 then
				arg_324_1.talkMaxDuration = 0
				arg_324_1.dialogCg_.alpha = 1

				arg_324_1.dialog_:SetActive(true)
				SetActive(arg_324_1.leftNameGo_, true)

				local var_327_2 = arg_324_1:FormatText(StoryNameCfg[600].name)

				arg_324_1.leftNameTxt_.text = var_327_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_324_1.leftNameTxt_.transform)

				arg_324_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_324_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_324_1:RecordName(arg_324_1.leftNameTxt_.text)
				SetActive(arg_324_1.iconTrs_.gameObject, true)
				arg_324_1.iconController_:SetSelectedState("hero")

				arg_324_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4032")

				arg_324_1.callingController_:SetSelectedState("normal")

				arg_324_1.keyicon_.color = Color.New(1, 1, 1)
				arg_324_1.icon_.color = Color.New(1, 1, 1)

				local var_327_3 = arg_324_1:GetWordFromCfg(321332075)
				local var_327_4 = arg_324_1:FormatText(var_327_3.content)

				arg_324_1.text_.text = var_327_4

				LuaForUtil.ClearLinePrefixSymbol(arg_324_1.text_)

				local var_327_5 = 31
				local var_327_6 = utf8.len(var_327_4)
				local var_327_7 = var_327_5 <= 0 and var_327_1 or var_327_1 * (var_327_6 / var_327_5)

				if var_327_7 > 0 and var_327_1 < var_327_7 then
					arg_324_1.talkMaxDuration = var_327_7

					if var_327_7 + var_327_0 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_7 + var_327_0
					end
				end

				arg_324_1.text_.text = var_327_4
				arg_324_1.typewritter.percent = 0

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332075", "story_v_out_321332.awb") ~= 0 then
					local var_327_8 = manager.audio:GetVoiceLength("story_v_out_321332", "321332075", "story_v_out_321332.awb") / 1000

					if var_327_8 + var_327_0 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_8 + var_327_0
					end

					if var_327_3.prefab_name ~= "" and arg_324_1.actors_[var_327_3.prefab_name] ~= nil then
						local var_327_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_324_1.actors_[var_327_3.prefab_name].transform, "story_v_out_321332", "321332075", "story_v_out_321332.awb")

						arg_324_1:RecordAudio("321332075", var_327_9)
						arg_324_1:RecordAudio("321332075", var_327_9)
					else
						arg_324_1:AudioAction("play", "voice", "story_v_out_321332", "321332075", "story_v_out_321332.awb")
					end

					arg_324_1:RecordHistoryTalkVoice("story_v_out_321332", "321332075", "story_v_out_321332.awb")
				end

				arg_324_1:RecordContent(arg_324_1.text_.text)
			end

			local var_327_10 = math.max(var_327_1, arg_324_1.talkMaxDuration)

			if var_327_0 <= arg_324_1.time_ and arg_324_1.time_ < var_327_0 + var_327_10 then
				arg_324_1.typewritter.percent = (arg_324_1.time_ - var_327_0) / var_327_10

				arg_324_1.typewritter:SetDirty()
			end

			if arg_324_1.time_ >= var_327_0 + var_327_10 and arg_324_1.time_ < var_327_0 + var_327_10 + arg_327_0 then
				arg_324_1.typewritter.percent = 1

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(true)
			end
		end

		arg_324_1.nodeConfigList_ = {}

		arg_324_1:InitPlayNodeList()
	end,
	Play321332076 = function(arg_328_0, arg_328_1)
		arg_328_1.time_ = 0
		arg_328_1.frameCnt_ = 0
		arg_328_1.state_ = "playing"
		arg_328_1.curTalkId_ = 321332076
		arg_328_1.duration_ = 13.67

		local var_328_0 = {
			zh = 9.1,
			ja = 13.666
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
				arg_328_0:Play321332077(arg_328_1)
			end
		end

		function arg_328_1.onSingleLineUpdate_(arg_331_0)
			local var_331_0 = 5.087
			local var_331_1 = 1

			if var_331_0 < arg_328_1.time_ and arg_328_1.time_ <= var_331_0 + arg_331_0 then
				local var_331_2 = "play"
				local var_331_3 = "effect"

				arg_328_1:AudioAction(var_331_2, var_331_3, "se_story_141", "se_story_141_boxing_drum02", "")
			end

			local var_331_4 = 0
			local var_331_5 = 0.55

			if var_331_4 < arg_328_1.time_ and arg_328_1.time_ <= var_331_4 + arg_331_0 then
				arg_328_1.talkMaxDuration = 0
				arg_328_1.dialogCg_.alpha = 1

				arg_328_1.dialog_:SetActive(true)
				SetActive(arg_328_1.leftNameGo_, true)

				local var_331_6 = arg_328_1:FormatText(StoryNameCfg[600].name)

				arg_328_1.leftNameTxt_.text = var_331_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_328_1.leftNameTxt_.transform)

				arg_328_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_328_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_328_1:RecordName(arg_328_1.leftNameTxt_.text)
				SetActive(arg_328_1.iconTrs_.gameObject, true)
				arg_328_1.iconController_:SetSelectedState("hero")

				arg_328_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4032")

				arg_328_1.callingController_:SetSelectedState("normal")

				arg_328_1.keyicon_.color = Color.New(1, 1, 1)
				arg_328_1.icon_.color = Color.New(1, 1, 1)

				local var_331_7 = arg_328_1:GetWordFromCfg(321332076)
				local var_331_8 = arg_328_1:FormatText(var_331_7.content)

				arg_328_1.text_.text = var_331_8

				LuaForUtil.ClearLinePrefixSymbol(arg_328_1.text_)

				local var_331_9 = 22
				local var_331_10 = utf8.len(var_331_8)
				local var_331_11 = var_331_9 <= 0 and var_331_5 or var_331_5 * (var_331_10 / var_331_9)

				if var_331_11 > 0 and var_331_5 < var_331_11 then
					arg_328_1.talkMaxDuration = var_331_11

					if var_331_11 + var_331_4 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_11 + var_331_4
					end
				end

				arg_328_1.text_.text = var_331_8
				arg_328_1.typewritter.percent = 0

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332076", "story_v_out_321332.awb") ~= 0 then
					local var_331_12 = manager.audio:GetVoiceLength("story_v_out_321332", "321332076", "story_v_out_321332.awb") / 1000

					if var_331_12 + var_331_4 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_12 + var_331_4
					end

					if var_331_7.prefab_name ~= "" and arg_328_1.actors_[var_331_7.prefab_name] ~= nil then
						local var_331_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_328_1.actors_[var_331_7.prefab_name].transform, "story_v_out_321332", "321332076", "story_v_out_321332.awb")

						arg_328_1:RecordAudio("321332076", var_331_13)
						arg_328_1:RecordAudio("321332076", var_331_13)
					else
						arg_328_1:AudioAction("play", "voice", "story_v_out_321332", "321332076", "story_v_out_321332.awb")
					end

					arg_328_1:RecordHistoryTalkVoice("story_v_out_321332", "321332076", "story_v_out_321332.awb")
				end

				arg_328_1:RecordContent(arg_328_1.text_.text)
			end

			local var_331_14 = math.max(var_331_5, arg_328_1.talkMaxDuration)

			if var_331_4 <= arg_328_1.time_ and arg_328_1.time_ < var_331_4 + var_331_14 then
				arg_328_1.typewritter.percent = (arg_328_1.time_ - var_331_4) / var_331_14

				arg_328_1.typewritter:SetDirty()
			end

			if arg_328_1.time_ >= var_331_4 + var_331_14 and arg_328_1.time_ < var_331_4 + var_331_14 + arg_331_0 then
				arg_328_1.typewritter.percent = 1

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(true)
			end
		end

		arg_328_1.nodeConfigList_ = {}

		arg_328_1:InitPlayNodeList()
	end,
	Play321332077 = function(arg_332_0, arg_332_1)
		arg_332_1.time_ = 0
		arg_332_1.frameCnt_ = 0
		arg_332_1.state_ = "playing"
		arg_332_1.curTalkId_ = 321332077
		arg_332_1.duration_ = 5.37

		local var_332_0 = {
			zh = 5.366,
			ja = 2.766
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
				arg_332_0:Play321332078(arg_332_1)
			end
		end

		function arg_332_1.onSingleLineUpdate_(arg_335_0)
			local var_335_0 = arg_332_1.actors_["4037ui_story"]
			local var_335_1 = 0

			if var_335_1 < arg_332_1.time_ and arg_332_1.time_ <= var_335_1 + arg_335_0 and not isNil(var_335_0) and arg_332_1.var_.characterEffect4037ui_story == nil then
				arg_332_1.var_.characterEffect4037ui_story = var_335_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_335_2 = 0.200000002980232

			if var_335_1 <= arg_332_1.time_ and arg_332_1.time_ < var_335_1 + var_335_2 and not isNil(var_335_0) then
				local var_335_3 = (arg_332_1.time_ - var_335_1) / var_335_2

				if arg_332_1.var_.characterEffect4037ui_story and not isNil(var_335_0) then
					arg_332_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_332_1.time_ >= var_335_1 + var_335_2 and arg_332_1.time_ < var_335_1 + var_335_2 + arg_335_0 and not isNil(var_335_0) and arg_332_1.var_.characterEffect4037ui_story then
				arg_332_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			local var_335_4 = 0

			if var_335_4 < arg_332_1.time_ and arg_332_1.time_ <= var_335_4 + arg_335_0 then
				arg_332_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action2_2")
			end

			local var_335_5 = 0

			if var_335_5 < arg_332_1.time_ and arg_332_1.time_ <= var_335_5 + arg_335_0 then
				arg_332_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_335_6 = 0
			local var_335_7 = 0.325

			if var_335_6 < arg_332_1.time_ and arg_332_1.time_ <= var_335_6 + arg_335_0 then
				arg_332_1.talkMaxDuration = 0
				arg_332_1.dialogCg_.alpha = 1

				arg_332_1.dialog_:SetActive(true)
				SetActive(arg_332_1.leftNameGo_, true)

				local var_335_8 = arg_332_1:FormatText(StoryNameCfg[453].name)

				arg_332_1.leftNameTxt_.text = var_335_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_332_1.leftNameTxt_.transform)

				arg_332_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_332_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_332_1:RecordName(arg_332_1.leftNameTxt_.text)
				SetActive(arg_332_1.iconTrs_.gameObject, false)
				arg_332_1.callingController_:SetSelectedState("normal")

				local var_335_9 = arg_332_1:GetWordFromCfg(321332077)
				local var_335_10 = arg_332_1:FormatText(var_335_9.content)

				arg_332_1.text_.text = var_335_10

				LuaForUtil.ClearLinePrefixSymbol(arg_332_1.text_)

				local var_335_11 = 13
				local var_335_12 = utf8.len(var_335_10)
				local var_335_13 = var_335_11 <= 0 and var_335_7 or var_335_7 * (var_335_12 / var_335_11)

				if var_335_13 > 0 and var_335_7 < var_335_13 then
					arg_332_1.talkMaxDuration = var_335_13

					if var_335_13 + var_335_6 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_13 + var_335_6
					end
				end

				arg_332_1.text_.text = var_335_10
				arg_332_1.typewritter.percent = 0

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332077", "story_v_out_321332.awb") ~= 0 then
					local var_335_14 = manager.audio:GetVoiceLength("story_v_out_321332", "321332077", "story_v_out_321332.awb") / 1000

					if var_335_14 + var_335_6 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_14 + var_335_6
					end

					if var_335_9.prefab_name ~= "" and arg_332_1.actors_[var_335_9.prefab_name] ~= nil then
						local var_335_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_332_1.actors_[var_335_9.prefab_name].transform, "story_v_out_321332", "321332077", "story_v_out_321332.awb")

						arg_332_1:RecordAudio("321332077", var_335_15)
						arg_332_1:RecordAudio("321332077", var_335_15)
					else
						arg_332_1:AudioAction("play", "voice", "story_v_out_321332", "321332077", "story_v_out_321332.awb")
					end

					arg_332_1:RecordHistoryTalkVoice("story_v_out_321332", "321332077", "story_v_out_321332.awb")
				end

				arg_332_1:RecordContent(arg_332_1.text_.text)
			end

			local var_335_16 = math.max(var_335_7, arg_332_1.talkMaxDuration)

			if var_335_6 <= arg_332_1.time_ and arg_332_1.time_ < var_335_6 + var_335_16 then
				arg_332_1.typewritter.percent = (arg_332_1.time_ - var_335_6) / var_335_16

				arg_332_1.typewritter:SetDirty()
			end

			if arg_332_1.time_ >= var_335_6 + var_335_16 and arg_332_1.time_ < var_335_6 + var_335_16 + arg_335_0 then
				arg_332_1.typewritter.percent = 1

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(true)
			end
		end

		arg_332_1.nodeConfigList_ = {}

		arg_332_1:InitPlayNodeList()
	end,
	Play321332078 = function(arg_336_0, arg_336_1)
		arg_336_1.time_ = 0
		arg_336_1.frameCnt_ = 0
		arg_336_1.state_ = "playing"
		arg_336_1.curTalkId_ = 321332078
		arg_336_1.duration_ = 5.1

		local var_336_0 = {
			zh = 4.266,
			ja = 5.1
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
				arg_336_0:Play321332079(arg_336_1)
			end
		end

		function arg_336_1.onSingleLineUpdate_(arg_339_0)
			local var_339_0 = arg_336_1.actors_["4037ui_story"]
			local var_339_1 = 0

			if var_339_1 < arg_336_1.time_ and arg_336_1.time_ <= var_339_1 + arg_339_0 and not isNil(var_339_0) and arg_336_1.var_.characterEffect4037ui_story == nil then
				arg_336_1.var_.characterEffect4037ui_story = var_339_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_339_2 = 0.200000002980232

			if var_339_1 <= arg_336_1.time_ and arg_336_1.time_ < var_339_1 + var_339_2 and not isNil(var_339_0) then
				local var_339_3 = (arg_336_1.time_ - var_339_1) / var_339_2

				if arg_336_1.var_.characterEffect4037ui_story and not isNil(var_339_0) then
					local var_339_4 = Mathf.Lerp(0, 0.5, var_339_3)

					arg_336_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_336_1.var_.characterEffect4037ui_story.fillRatio = var_339_4
				end
			end

			if arg_336_1.time_ >= var_339_1 + var_339_2 and arg_336_1.time_ < var_339_1 + var_339_2 + arg_339_0 and not isNil(var_339_0) and arg_336_1.var_.characterEffect4037ui_story then
				local var_339_5 = 0.5

				arg_336_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_336_1.var_.characterEffect4037ui_story.fillRatio = var_339_5
			end

			local var_339_6 = 0
			local var_339_7 = 0.25

			if var_339_6 < arg_336_1.time_ and arg_336_1.time_ <= var_339_6 + arg_339_0 then
				arg_336_1.talkMaxDuration = 0
				arg_336_1.dialogCg_.alpha = 1

				arg_336_1.dialog_:SetActive(true)
				SetActive(arg_336_1.leftNameGo_, true)

				local var_339_8 = arg_336_1:FormatText(StoryNameCfg[600].name)

				arg_336_1.leftNameTxt_.text = var_339_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_336_1.leftNameTxt_.transform)

				arg_336_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_336_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_336_1:RecordName(arg_336_1.leftNameTxt_.text)
				SetActive(arg_336_1.iconTrs_.gameObject, true)
				arg_336_1.iconController_:SetSelectedState("hero")

				arg_336_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4032")

				arg_336_1.callingController_:SetSelectedState("normal")

				arg_336_1.keyicon_.color = Color.New(1, 1, 1)
				arg_336_1.icon_.color = Color.New(1, 1, 1)

				local var_339_9 = arg_336_1:GetWordFromCfg(321332078)
				local var_339_10 = arg_336_1:FormatText(var_339_9.content)

				arg_336_1.text_.text = var_339_10

				LuaForUtil.ClearLinePrefixSymbol(arg_336_1.text_)

				local var_339_11 = 10
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

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332078", "story_v_out_321332.awb") ~= 0 then
					local var_339_14 = manager.audio:GetVoiceLength("story_v_out_321332", "321332078", "story_v_out_321332.awb") / 1000

					if var_339_14 + var_339_6 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_14 + var_339_6
					end

					if var_339_9.prefab_name ~= "" and arg_336_1.actors_[var_339_9.prefab_name] ~= nil then
						local var_339_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_336_1.actors_[var_339_9.prefab_name].transform, "story_v_out_321332", "321332078", "story_v_out_321332.awb")

						arg_336_1:RecordAudio("321332078", var_339_15)
						arg_336_1:RecordAudio("321332078", var_339_15)
					else
						arg_336_1:AudioAction("play", "voice", "story_v_out_321332", "321332078", "story_v_out_321332.awb")
					end

					arg_336_1:RecordHistoryTalkVoice("story_v_out_321332", "321332078", "story_v_out_321332.awb")
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
	Play321332079 = function(arg_340_0, arg_340_1)
		arg_340_1.time_ = 0
		arg_340_1.frameCnt_ = 0
		arg_340_1.state_ = "playing"
		arg_340_1.curTalkId_ = 321332079
		arg_340_1.duration_ = 12.47

		local var_340_0 = {
			zh = 9.533,
			ja = 12.466
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
				arg_340_0:Play321332080(arg_340_1)
			end
		end

		function arg_340_1.onSingleLineUpdate_(arg_343_0)
			local var_343_0 = arg_340_1.actors_["4037ui_story"]
			local var_343_1 = 0

			if var_343_1 < arg_340_1.time_ and arg_340_1.time_ <= var_343_1 + arg_343_0 and not isNil(var_343_0) and arg_340_1.var_.characterEffect4037ui_story == nil then
				arg_340_1.var_.characterEffect4037ui_story = var_343_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_343_2 = 0.200000002980232

			if var_343_1 <= arg_340_1.time_ and arg_340_1.time_ < var_343_1 + var_343_2 and not isNil(var_343_0) then
				local var_343_3 = (arg_340_1.time_ - var_343_1) / var_343_2

				if arg_340_1.var_.characterEffect4037ui_story and not isNil(var_343_0) then
					arg_340_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_340_1.time_ >= var_343_1 + var_343_2 and arg_340_1.time_ < var_343_1 + var_343_2 + arg_343_0 and not isNil(var_343_0) and arg_340_1.var_.characterEffect4037ui_story then
				arg_340_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			local var_343_4 = 0

			if var_343_4 < arg_340_1.time_ and arg_340_1.time_ <= var_343_4 + arg_343_0 then
				arg_340_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action3_1")
			end

			local var_343_5 = 0

			if var_343_5 < arg_340_1.time_ and arg_340_1.time_ <= var_343_5 + arg_343_0 then
				arg_340_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_343_6 = 0
			local var_343_7 = 0.775

			if var_343_6 < arg_340_1.time_ and arg_340_1.time_ <= var_343_6 + arg_343_0 then
				arg_340_1.talkMaxDuration = 0
				arg_340_1.dialogCg_.alpha = 1

				arg_340_1.dialog_:SetActive(true)
				SetActive(arg_340_1.leftNameGo_, true)

				local var_343_8 = arg_340_1:FormatText(StoryNameCfg[453].name)

				arg_340_1.leftNameTxt_.text = var_343_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_340_1.leftNameTxt_.transform)

				arg_340_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_340_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_340_1:RecordName(arg_340_1.leftNameTxt_.text)
				SetActive(arg_340_1.iconTrs_.gameObject, false)
				arg_340_1.callingController_:SetSelectedState("normal")

				local var_343_9 = arg_340_1:GetWordFromCfg(321332079)
				local var_343_10 = arg_340_1:FormatText(var_343_9.content)

				arg_340_1.text_.text = var_343_10

				LuaForUtil.ClearLinePrefixSymbol(arg_340_1.text_)

				local var_343_11 = 31
				local var_343_12 = utf8.len(var_343_10)
				local var_343_13 = var_343_11 <= 0 and var_343_7 or var_343_7 * (var_343_12 / var_343_11)

				if var_343_13 > 0 and var_343_7 < var_343_13 then
					arg_340_1.talkMaxDuration = var_343_13

					if var_343_13 + var_343_6 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_13 + var_343_6
					end
				end

				arg_340_1.text_.text = var_343_10
				arg_340_1.typewritter.percent = 0

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332079", "story_v_out_321332.awb") ~= 0 then
					local var_343_14 = manager.audio:GetVoiceLength("story_v_out_321332", "321332079", "story_v_out_321332.awb") / 1000

					if var_343_14 + var_343_6 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_14 + var_343_6
					end

					if var_343_9.prefab_name ~= "" and arg_340_1.actors_[var_343_9.prefab_name] ~= nil then
						local var_343_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_340_1.actors_[var_343_9.prefab_name].transform, "story_v_out_321332", "321332079", "story_v_out_321332.awb")

						arg_340_1:RecordAudio("321332079", var_343_15)
						arg_340_1:RecordAudio("321332079", var_343_15)
					else
						arg_340_1:AudioAction("play", "voice", "story_v_out_321332", "321332079", "story_v_out_321332.awb")
					end

					arg_340_1:RecordHistoryTalkVoice("story_v_out_321332", "321332079", "story_v_out_321332.awb")
				end

				arg_340_1:RecordContent(arg_340_1.text_.text)
			end

			local var_343_16 = math.max(var_343_7, arg_340_1.talkMaxDuration)

			if var_343_6 <= arg_340_1.time_ and arg_340_1.time_ < var_343_6 + var_343_16 then
				arg_340_1.typewritter.percent = (arg_340_1.time_ - var_343_6) / var_343_16

				arg_340_1.typewritter:SetDirty()
			end

			if arg_340_1.time_ >= var_343_6 + var_343_16 and arg_340_1.time_ < var_343_6 + var_343_16 + arg_343_0 then
				arg_340_1.typewritter.percent = 1

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(true)
			end
		end

		arg_340_1.nodeConfigList_ = {}

		arg_340_1:InitPlayNodeList()
	end,
	Play321332080 = function(arg_344_0, arg_344_1)
		arg_344_1.time_ = 0
		arg_344_1.frameCnt_ = 0
		arg_344_1.state_ = "playing"
		arg_344_1.curTalkId_ = 321332080
		arg_344_1.duration_ = 7.37

		local var_344_0 = {
			zh = 5.433,
			ja = 7.366
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
				arg_344_0:Play321332081(arg_344_1)
			end
		end

		function arg_344_1.onSingleLineUpdate_(arg_347_0)
			local var_347_0 = 3.917
			local var_347_1 = 1

			if var_347_0 < arg_344_1.time_ and arg_344_1.time_ <= var_347_0 + arg_347_0 then
				local var_347_2 = "play"
				local var_347_3 = "effect"

				arg_344_1:AudioAction(var_347_2, var_347_3, "se_story_141", "se_story_141_boxing_drum03", "")
			end

			local var_347_4 = 3.917
			local var_347_5 = 1

			if var_347_4 < arg_344_1.time_ and arg_344_1.time_ <= var_347_4 + arg_347_0 then
				local var_347_6 = "stop"
				local var_347_7 = "effect"

				arg_344_1:AudioAction(var_347_6, var_347_7, "se_story_141", "se_story_141_boxing_amb_cheer03_loop", "")
			end

			local var_347_8 = 0
			local var_347_9 = 0.325

			if var_347_8 < arg_344_1.time_ and arg_344_1.time_ <= var_347_8 + arg_347_0 then
				arg_344_1.talkMaxDuration = 0
				arg_344_1.dialogCg_.alpha = 1

				arg_344_1.dialog_:SetActive(true)
				SetActive(arg_344_1.leftNameGo_, true)

				local var_347_10 = arg_344_1:FormatText(StoryNameCfg[453].name)

				arg_344_1.leftNameTxt_.text = var_347_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_344_1.leftNameTxt_.transform)

				arg_344_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_344_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_344_1:RecordName(arg_344_1.leftNameTxt_.text)
				SetActive(arg_344_1.iconTrs_.gameObject, false)
				arg_344_1.callingController_:SetSelectedState("normal")

				local var_347_11 = arg_344_1:GetWordFromCfg(321332080)
				local var_347_12 = arg_344_1:FormatText(var_347_11.content)

				arg_344_1.text_.text = var_347_12

				LuaForUtil.ClearLinePrefixSymbol(arg_344_1.text_)

				local var_347_13 = 13
				local var_347_14 = utf8.len(var_347_12)
				local var_347_15 = var_347_13 <= 0 and var_347_9 or var_347_9 * (var_347_14 / var_347_13)

				if var_347_15 > 0 and var_347_9 < var_347_15 then
					arg_344_1.talkMaxDuration = var_347_15

					if var_347_15 + var_347_8 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_15 + var_347_8
					end
				end

				arg_344_1.text_.text = var_347_12
				arg_344_1.typewritter.percent = 0

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332080", "story_v_out_321332.awb") ~= 0 then
					local var_347_16 = manager.audio:GetVoiceLength("story_v_out_321332", "321332080", "story_v_out_321332.awb") / 1000

					if var_347_16 + var_347_8 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_16 + var_347_8
					end

					if var_347_11.prefab_name ~= "" and arg_344_1.actors_[var_347_11.prefab_name] ~= nil then
						local var_347_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_344_1.actors_[var_347_11.prefab_name].transform, "story_v_out_321332", "321332080", "story_v_out_321332.awb")

						arg_344_1:RecordAudio("321332080", var_347_17)
						arg_344_1:RecordAudio("321332080", var_347_17)
					else
						arg_344_1:AudioAction("play", "voice", "story_v_out_321332", "321332080", "story_v_out_321332.awb")
					end

					arg_344_1:RecordHistoryTalkVoice("story_v_out_321332", "321332080", "story_v_out_321332.awb")
				end

				arg_344_1:RecordContent(arg_344_1.text_.text)
			end

			local var_347_18 = math.max(var_347_9, arg_344_1.talkMaxDuration)

			if var_347_8 <= arg_344_1.time_ and arg_344_1.time_ < var_347_8 + var_347_18 then
				arg_344_1.typewritter.percent = (arg_344_1.time_ - var_347_8) / var_347_18

				arg_344_1.typewritter:SetDirty()
			end

			if arg_344_1.time_ >= var_347_8 + var_347_18 and arg_344_1.time_ < var_347_8 + var_347_18 + arg_347_0 then
				arg_344_1.typewritter.percent = 1

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(true)
			end
		end

		arg_344_1.nodeConfigList_ = {}

		arg_344_1:InitPlayNodeList()
	end,
	Play321332081 = function(arg_348_0, arg_348_1)
		arg_348_1.time_ = 0
		arg_348_1.frameCnt_ = 0
		arg_348_1.state_ = "playing"
		arg_348_1.curTalkId_ = 321332081
		arg_348_1.duration_ = 6.27

		local var_348_0 = {
			zh = 6.266,
			ja = 5.766
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
				arg_348_0:Play321332082(arg_348_1)
			end
		end

		function arg_348_1.onSingleLineUpdate_(arg_351_0)
			local var_351_0 = "MS2110a"

			if arg_348_1.bgs_[var_351_0] == nil then
				local var_351_1 = Object.Instantiate(arg_348_1.paintGo_)

				var_351_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_351_0)
				var_351_1.name = var_351_0
				var_351_1.transform.parent = arg_348_1.stage_.transform
				var_351_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_348_1.bgs_[var_351_0] = var_351_1
			end

			local var_351_2 = 0

			if var_351_2 < arg_348_1.time_ and arg_348_1.time_ <= var_351_2 + arg_351_0 then
				local var_351_3 = manager.ui.mainCamera.transform.localPosition
				local var_351_4 = Vector3.New(0, 0, 10) + Vector3.New(var_351_3.x, var_351_3.y, 0)
				local var_351_5 = arg_348_1.bgs_.MS2110a

				var_351_5.transform.localPosition = var_351_4
				var_351_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_351_6 = var_351_5:GetComponent("SpriteRenderer")

				if var_351_6 and var_351_6.sprite then
					local var_351_7 = (var_351_5.transform.localPosition - var_351_3).z
					local var_351_8 = manager.ui.mainCameraCom_
					local var_351_9 = 2 * var_351_7 * Mathf.Tan(var_351_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_351_10 = var_351_9 * var_351_8.aspect
					local var_351_11 = var_351_6.sprite.bounds.size.x
					local var_351_12 = var_351_6.sprite.bounds.size.y
					local var_351_13 = var_351_10 / var_351_11
					local var_351_14 = var_351_9 / var_351_12
					local var_351_15 = var_351_14 < var_351_13 and var_351_13 or var_351_14

					var_351_5.transform.localScale = Vector3.New(var_351_15, var_351_15, 0)
				end

				for iter_351_0, iter_351_1 in pairs(arg_348_1.bgs_) do
					if iter_351_0 ~= "MS2110a" then
						iter_351_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_351_16 = 2

			if var_351_16 < arg_348_1.time_ and arg_348_1.time_ <= var_351_16 + arg_351_0 then
				arg_348_1.allBtn_.enabled = false
			end

			local var_351_17 = 0.3

			if arg_348_1.time_ >= var_351_16 + var_351_17 and arg_348_1.time_ < var_351_16 + var_351_17 + arg_351_0 then
				arg_348_1.allBtn_.enabled = true
			end

			local var_351_18 = 0

			if var_351_18 < arg_348_1.time_ and arg_348_1.time_ <= var_351_18 + arg_351_0 then
				arg_348_1.mask_.enabled = true
				arg_348_1.mask_.raycastTarget = true

				arg_348_1:SetGaussion(false)
			end

			local var_351_19 = 4.03400000184774

			if var_351_18 <= arg_348_1.time_ and arg_348_1.time_ < var_351_18 + var_351_19 then
				local var_351_20 = (arg_348_1.time_ - var_351_18) / var_351_19
				local var_351_21 = Color.New(0, 0, 0)

				var_351_21.a = Mathf.Lerp(1, 0, var_351_20)
				arg_348_1.mask_.color = var_351_21
			end

			if arg_348_1.time_ >= var_351_18 + var_351_19 and arg_348_1.time_ < var_351_18 + var_351_19 + arg_351_0 then
				local var_351_22 = Color.New(0, 0, 0)
				local var_351_23 = 0

				arg_348_1.mask_.enabled = false
				var_351_22.a = var_351_23
				arg_348_1.mask_.color = var_351_22
			end

			local var_351_24 = arg_348_1.actors_["4037ui_story"].transform
			local var_351_25 = 0

			if var_351_25 < arg_348_1.time_ and arg_348_1.time_ <= var_351_25 + arg_351_0 then
				arg_348_1.var_.moveOldPos4037ui_story = var_351_24.localPosition
			end

			local var_351_26 = 0.001

			if var_351_25 <= arg_348_1.time_ and arg_348_1.time_ < var_351_25 + var_351_26 then
				local var_351_27 = (arg_348_1.time_ - var_351_25) / var_351_26
				local var_351_28 = Vector3.New(0, 100, 0)

				var_351_24.localPosition = Vector3.Lerp(arg_348_1.var_.moveOldPos4037ui_story, var_351_28, var_351_27)

				local var_351_29 = manager.ui.mainCamera.transform.position - var_351_24.position

				var_351_24.forward = Vector3.New(var_351_29.x, var_351_29.y, var_351_29.z)

				local var_351_30 = var_351_24.localEulerAngles

				var_351_30.z = 0
				var_351_30.x = 0
				var_351_24.localEulerAngles = var_351_30
			end

			if arg_348_1.time_ >= var_351_25 + var_351_26 and arg_348_1.time_ < var_351_25 + var_351_26 + arg_351_0 then
				var_351_24.localPosition = Vector3.New(0, 100, 0)

				local var_351_31 = manager.ui.mainCamera.transform.position - var_351_24.position

				var_351_24.forward = Vector3.New(var_351_31.x, var_351_31.y, var_351_31.z)

				local var_351_32 = var_351_24.localEulerAngles

				var_351_32.z = 0
				var_351_32.x = 0
				var_351_24.localEulerAngles = var_351_32
			end

			local var_351_33 = arg_348_1.actors_["4037ui_story"]
			local var_351_34 = 0

			if var_351_34 < arg_348_1.time_ and arg_348_1.time_ <= var_351_34 + arg_351_0 and not isNil(var_351_33) and arg_348_1.var_.characterEffect4037ui_story == nil then
				arg_348_1.var_.characterEffect4037ui_story = var_351_33:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_351_35 = 0.034000001847744

			if var_351_34 <= arg_348_1.time_ and arg_348_1.time_ < var_351_34 + var_351_35 and not isNil(var_351_33) then
				local var_351_36 = (arg_348_1.time_ - var_351_34) / var_351_35

				if arg_348_1.var_.characterEffect4037ui_story and not isNil(var_351_33) then
					local var_351_37 = Mathf.Lerp(0, 0.5, var_351_36)

					arg_348_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_348_1.var_.characterEffect4037ui_story.fillRatio = var_351_37
				end
			end

			if arg_348_1.time_ >= var_351_34 + var_351_35 and arg_348_1.time_ < var_351_34 + var_351_35 + arg_351_0 and not isNil(var_351_33) and arg_348_1.var_.characterEffect4037ui_story then
				local var_351_38 = 0.5

				arg_348_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_348_1.var_.characterEffect4037ui_story.fillRatio = var_351_38
			end

			local var_351_39 = arg_348_1.actors_["4037ui_story"]
			local var_351_40 = 0

			if var_351_40 < arg_348_1.time_ and arg_348_1.time_ <= var_351_40 + arg_351_0 then
				if arg_348_1.var_.characterEffect4037ui_story == nil then
					arg_348_1.var_.characterEffect4037ui_story = var_351_39:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_351_41 = arg_348_1.var_.characterEffect4037ui_story

				var_351_41.imageEffect:turnOff()

				var_351_41.interferenceEffect.enabled = false
				var_351_41.interferenceEffect.noise = 0.001
				var_351_41.interferenceEffect.simTimeScale = 1
				var_351_41.interferenceEffect.geometryOutlineColor = Color.New(0.509434, 0.509434, 0.509434, 1)
			end

			local var_351_42 = arg_348_1.actors_["4037ui_story"]
			local var_351_43 = 0
			local var_351_44 = 0.2

			if var_351_43 < arg_348_1.time_ and arg_348_1.time_ <= var_351_43 + arg_351_0 then
				if arg_348_1.var_.characterEffect4037ui_story == nil then
					arg_348_1.var_.characterEffect4037ui_story = var_351_42:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_348_1.var_.characterEffect4037ui_story.imageEffect:turnOff()
			end

			local var_351_45 = manager.ui.mainCamera.transform
			local var_351_46 = 0

			if var_351_46 < arg_348_1.time_ and arg_348_1.time_ <= var_351_46 + arg_351_0 then
				local var_351_47 = arg_348_1.var_.effectluobonazhuanchang4
				local var_351_48
				local var_351_49 = var_351_45

				if not var_351_47 then
					var_351_47 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), var_351_49)
					var_351_47.name = "luobonazhuanchang4"
					arg_348_1.var_.effectluobonazhuanchang4 = var_351_47
				else
					var_351_47.transform:SetParent(var_351_49)
				end

				var_351_47.transform.localPosition = Vector3.New(0, 0, 0)
				var_351_47.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_351_50 = arg_348_1.bgs_.MS2110a.transform
			local var_351_51 = 0

			if var_351_51 < arg_348_1.time_ and arg_348_1.time_ <= var_351_51 + arg_351_0 then
				arg_348_1.var_.moveOldPosMS2110a = var_351_50.localPosition
			end

			local var_351_52 = 0.001

			if var_351_51 <= arg_348_1.time_ and arg_348_1.time_ < var_351_51 + var_351_52 then
				local var_351_53 = (arg_348_1.time_ - var_351_51) / var_351_52
				local var_351_54 = Vector3.New(0, 1, 9.5)

				var_351_50.localPosition = Vector3.Lerp(arg_348_1.var_.moveOldPosMS2110a, var_351_54, var_351_53)
			end

			if arg_348_1.time_ >= var_351_51 + var_351_52 and arg_348_1.time_ < var_351_51 + var_351_52 + arg_351_0 then
				var_351_50.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_351_55 = arg_348_1.bgs_.MS2110a.transform
			local var_351_56 = 0.034000001847744

			if var_351_56 < arg_348_1.time_ and arg_348_1.time_ <= var_351_56 + arg_351_0 then
				arg_348_1.var_.moveOldPosMS2110a = var_351_55.localPosition
			end

			local var_351_57 = 4

			if var_351_56 <= arg_348_1.time_ and arg_348_1.time_ < var_351_56 + var_351_57 then
				local var_351_58 = (arg_348_1.time_ - var_351_56) / var_351_57
				local var_351_59 = Vector3.New(0, 1, 10)

				var_351_55.localPosition = Vector3.Lerp(arg_348_1.var_.moveOldPosMS2110a, var_351_59, var_351_58)
			end

			if arg_348_1.time_ >= var_351_56 + var_351_57 and arg_348_1.time_ < var_351_56 + var_351_57 + arg_351_0 then
				var_351_55.localPosition = Vector3.New(0, 1, 10)
			end

			local var_351_60 = 2

			if var_351_60 < arg_348_1.time_ and arg_348_1.time_ <= var_351_60 + arg_351_0 then
				arg_348_1.allBtn_.enabled = false
			end

			local var_351_61 = 2.03400000184774

			if arg_348_1.time_ >= var_351_60 + var_351_61 and arg_348_1.time_ < var_351_60 + var_351_61 + arg_351_0 then
				arg_348_1.allBtn_.enabled = true
			end

			local var_351_62 = 0
			local var_351_63 = 1

			if var_351_62 < arg_348_1.time_ and arg_348_1.time_ <= var_351_62 + arg_351_0 then
				local var_351_64 = "play"
				local var_351_65 = "effect"

				arg_348_1:AudioAction(var_351_64, var_351_65, "se_story_141", "se_story_141_boxing_whoosh04", "")
			end

			local var_351_66 = 2.293
			local var_351_67 = 1
			local var_351_68 = manager.audio:GetVoiceLength("story_v_out_321332", "321332081", "") / 1000

			if var_351_68 > 0 and var_351_67 < var_351_68 and var_351_68 + var_351_66 > arg_348_1.duration_ then
				local var_351_69 = var_351_68

				arg_348_1.duration_ = var_351_68 + var_351_66
			end

			if var_351_66 < arg_348_1.time_ and arg_348_1.time_ <= var_351_66 + arg_351_0 then
				local var_351_70 = "play"
				local var_351_71 = "voice"

				arg_348_1:AudioAction(var_351_70, var_351_71, "story_v_out_321332", "321332081", "")
			end

			local var_351_72 = 4.099
			local var_351_73 = 1

			if var_351_72 < arg_348_1.time_ and arg_348_1.time_ <= var_351_72 + arg_351_0 then
				local var_351_74 = "play"
				local var_351_75 = "effect"

				arg_348_1:AudioAction(var_351_74, var_351_75, "se_story_141", "se_story_141_boxing_amb_cheer04_loop", "")
			end

			if arg_348_1.frameCnt_ <= 1 then
				arg_348_1.dialog_:SetActive(false)
			end

			local var_351_76 = 2
			local var_351_77 = 1.5

			if var_351_76 < arg_348_1.time_ and arg_348_1.time_ <= var_351_76 + arg_351_0 then
				arg_348_1.talkMaxDuration = 0

				arg_348_1.dialog_:SetActive(true)

				arg_348_1.dialogCg_.alpha = 0

				local var_351_78 = LeanTween.value(arg_348_1.dialog_, 0, 1, 0.3)

				var_351_78:setOnUpdate(LuaHelper.FloatAction(function(arg_352_0)
					arg_348_1.dialogCg_.alpha = arg_352_0
				end))
				var_351_78:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_348_1.dialog_)
					var_351_78:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_348_1.duration_ = arg_348_1.duration_ + 0.3

				SetActive(arg_348_1.leftNameGo_, false)

				arg_348_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_348_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_348_1:RecordName(arg_348_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_348_1.iconTrs_.gameObject, false)
				arg_348_1.callingController_:SetSelectedState("normal")

				local var_351_79 = arg_348_1:GetWordFromCfg(321332081)
				local var_351_80 = arg_348_1:FormatText(var_351_79.content)

				arg_348_1.text_.text = var_351_80

				LuaForUtil.ClearLinePrefixSymbol(arg_348_1.text_)

				local var_351_81 = 60
				local var_351_82 = utf8.len(var_351_80)
				local var_351_83 = var_351_81 <= 0 and var_351_77 or var_351_77 * (var_351_82 / var_351_81)

				if var_351_83 > 0 and var_351_77 < var_351_83 then
					arg_348_1.talkMaxDuration = var_351_83
					var_351_76 = var_351_76 + 0.3

					if var_351_83 + var_351_76 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_83 + var_351_76
					end
				end

				arg_348_1.text_.text = var_351_80
				arg_348_1.typewritter.percent = 0

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332081", "story_v_out_321332.awb") ~= 0 then
					local var_351_84 = manager.audio:GetVoiceLength("story_v_out_321332", "321332081", "story_v_out_321332.awb") / 1000

					if var_351_84 + var_351_76 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_84 + var_351_76
					end

					if var_351_79.prefab_name ~= "" and arg_348_1.actors_[var_351_79.prefab_name] ~= nil then
						local var_351_85 = LuaForUtil.PlayVoiceWithCriLipsync(arg_348_1.actors_[var_351_79.prefab_name].transform, "story_v_out_321332", "321332081", "story_v_out_321332.awb")

						arg_348_1:RecordAudio("321332081", var_351_85)
						arg_348_1:RecordAudio("321332081", var_351_85)
					else
						arg_348_1:AudioAction("play", "voice", "story_v_out_321332", "321332081", "story_v_out_321332.awb")
					end

					arg_348_1:RecordHistoryTalkVoice("story_v_out_321332", "321332081", "story_v_out_321332.awb")
				end

				arg_348_1:RecordContent(arg_348_1.text_.text)
			end

			local var_351_86 = var_351_76 + 0.3
			local var_351_87 = math.max(var_351_77, arg_348_1.talkMaxDuration)

			if var_351_86 <= arg_348_1.time_ and arg_348_1.time_ < var_351_86 + var_351_87 then
				arg_348_1.typewritter.percent = (arg_348_1.time_ - var_351_86) / var_351_87

				arg_348_1.typewritter:SetDirty()
			end

			if arg_348_1.time_ >= var_351_86 + var_351_87 and arg_348_1.time_ < var_351_86 + var_351_87 + arg_351_0 then
				arg_348_1.typewritter.percent = 1

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(true)
			end
		end

		arg_348_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "MS2110a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "MS2110a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 4,
				className = "StoryMoveNode",
				startTime = 0.034000001847744,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_348_1:InitPlayNodeList()
	end,
	Play321332082 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 321332082
		arg_354_1.duration_ = 5

		SetActive(arg_354_1.tipsGo_, false)

		function arg_354_1.onSingleLineFinish_()
			arg_354_1.onSingleLineUpdate_ = nil
			arg_354_1.onSingleLineFinish_ = nil
			arg_354_1.state_ = "waiting"
		end

		function arg_354_1.playNext_(arg_356_0)
			if arg_356_0 == 1 then
				arg_354_0:Play321332083(arg_354_1)
			end
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			local var_357_0 = 0.05
			local var_357_1 = 1

			if var_357_0 < arg_354_1.time_ and arg_354_1.time_ <= var_357_0 + arg_357_0 then
				local var_357_2 = "play"
				local var_357_3 = "effect"

				arg_354_1:AudioAction(var_357_2, var_357_3, "se_story_141", "se_story_141_boxing_blood", "")
			end

			local var_357_4 = 0
			local var_357_5 = 1.3

			if var_357_4 < arg_354_1.time_ and arg_354_1.time_ <= var_357_4 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0
				arg_354_1.dialogCg_.alpha = 1

				arg_354_1.dialog_:SetActive(true)
				SetActive(arg_354_1.leftNameGo_, false)

				arg_354_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_354_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_354_1:RecordName(arg_354_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_354_1.iconTrs_.gameObject, false)
				arg_354_1.callingController_:SetSelectedState("normal")

				local var_357_6 = arg_354_1:GetWordFromCfg(321332082)
				local var_357_7 = arg_354_1:FormatText(var_357_6.content)

				arg_354_1.text_.text = var_357_7

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_8 = 52
				local var_357_9 = utf8.len(var_357_7)
				local var_357_10 = var_357_8 <= 0 and var_357_5 or var_357_5 * (var_357_9 / var_357_8)

				if var_357_10 > 0 and var_357_5 < var_357_10 then
					arg_354_1.talkMaxDuration = var_357_10

					if var_357_10 + var_357_4 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_10 + var_357_4
					end
				end

				arg_354_1.text_.text = var_357_7
				arg_354_1.typewritter.percent = 0

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(false)
				arg_354_1:RecordContent(arg_354_1.text_.text)
			end

			local var_357_11 = math.max(var_357_5, arg_354_1.talkMaxDuration)

			if var_357_4 <= arg_354_1.time_ and arg_354_1.time_ < var_357_4 + var_357_11 then
				arg_354_1.typewritter.percent = (arg_354_1.time_ - var_357_4) / var_357_11

				arg_354_1.typewritter:SetDirty()
			end

			if arg_354_1.time_ >= var_357_4 + var_357_11 and arg_354_1.time_ < var_357_4 + var_357_11 + arg_357_0 then
				arg_354_1.typewritter.percent = 1

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(true)
			end
		end

		arg_354_1.nodeConfigList_ = {}

		arg_354_1:InitPlayNodeList()
	end,
	Play321332083 = function(arg_358_0, arg_358_1)
		arg_358_1.time_ = 0
		arg_358_1.frameCnt_ = 0
		arg_358_1.state_ = "playing"
		arg_358_1.curTalkId_ = 321332083
		arg_358_1.duration_ = 3.7

		local var_358_0 = {
			zh = 3.7,
			ja = 3.666
		}
		local var_358_1 = manager.audio:GetLocalizationFlag()

		if var_358_0[var_358_1] ~= nil then
			arg_358_1.duration_ = var_358_0[var_358_1]
		end

		SetActive(arg_358_1.tipsGo_, false)

		function arg_358_1.onSingleLineFinish_()
			arg_358_1.onSingleLineUpdate_ = nil
			arg_358_1.onSingleLineFinish_ = nil
			arg_358_1.state_ = "waiting"
		end

		function arg_358_1.playNext_(arg_360_0)
			if arg_360_0 == 1 then
				arg_358_0:Play321332084(arg_358_1)
			end
		end

		function arg_358_1.onSingleLineUpdate_(arg_361_0)
			local var_361_0 = 0
			local var_361_1 = 0.2

			if var_361_0 < arg_358_1.time_ and arg_358_1.time_ <= var_361_0 + arg_361_0 then
				arg_358_1.talkMaxDuration = 0
				arg_358_1.dialogCg_.alpha = 1

				arg_358_1.dialog_:SetActive(true)
				SetActive(arg_358_1.leftNameGo_, true)

				local var_361_2 = arg_358_1:FormatText(StoryNameCfg[37].name)

				arg_358_1.leftNameTxt_.text = var_361_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_358_1.leftNameTxt_.transform)

				arg_358_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_358_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_358_1:RecordName(arg_358_1.leftNameTxt_.text)
				SetActive(arg_358_1.iconTrs_.gameObject, false)
				arg_358_1.callingController_:SetSelectedState("normal")

				local var_361_3 = arg_358_1:GetWordFromCfg(321332083)
				local var_361_4 = arg_358_1:FormatText(var_361_3.content)

				arg_358_1.text_.text = var_361_4

				LuaForUtil.ClearLinePrefixSymbol(arg_358_1.text_)

				local var_361_5 = 8
				local var_361_6 = utf8.len(var_361_4)
				local var_361_7 = var_361_5 <= 0 and var_361_1 or var_361_1 * (var_361_6 / var_361_5)

				if var_361_7 > 0 and var_361_1 < var_361_7 then
					arg_358_1.talkMaxDuration = var_361_7

					if var_361_7 + var_361_0 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_7 + var_361_0
					end
				end

				arg_358_1.text_.text = var_361_4
				arg_358_1.typewritter.percent = 0

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332083", "story_v_out_321332.awb") ~= 0 then
					local var_361_8 = manager.audio:GetVoiceLength("story_v_out_321332", "321332083", "story_v_out_321332.awb") / 1000

					if var_361_8 + var_361_0 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_8 + var_361_0
					end

					if var_361_3.prefab_name ~= "" and arg_358_1.actors_[var_361_3.prefab_name] ~= nil then
						local var_361_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_358_1.actors_[var_361_3.prefab_name].transform, "story_v_out_321332", "321332083", "story_v_out_321332.awb")

						arg_358_1:RecordAudio("321332083", var_361_9)
						arg_358_1:RecordAudio("321332083", var_361_9)
					else
						arg_358_1:AudioAction("play", "voice", "story_v_out_321332", "321332083", "story_v_out_321332.awb")
					end

					arg_358_1:RecordHistoryTalkVoice("story_v_out_321332", "321332083", "story_v_out_321332.awb")
				end

				arg_358_1:RecordContent(arg_358_1.text_.text)
			end

			local var_361_10 = math.max(var_361_1, arg_358_1.talkMaxDuration)

			if var_361_0 <= arg_358_1.time_ and arg_358_1.time_ < var_361_0 + var_361_10 then
				arg_358_1.typewritter.percent = (arg_358_1.time_ - var_361_0) / var_361_10

				arg_358_1.typewritter:SetDirty()
			end

			if arg_358_1.time_ >= var_361_0 + var_361_10 and arg_358_1.time_ < var_361_0 + var_361_10 + arg_361_0 then
				arg_358_1.typewritter.percent = 1

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(true)
			end
		end

		arg_358_1.nodeConfigList_ = {}

		arg_358_1:InitPlayNodeList()
	end,
	Play321332084 = function(arg_362_0, arg_362_1)
		arg_362_1.time_ = 0
		arg_362_1.frameCnt_ = 0
		arg_362_1.state_ = "playing"
		arg_362_1.curTalkId_ = 321332084
		arg_362_1.duration_ = 7.13

		local var_362_0 = {
			zh = 7.133,
			ja = 6.733
		}
		local var_362_1 = manager.audio:GetLocalizationFlag()

		if var_362_0[var_362_1] ~= nil then
			arg_362_1.duration_ = var_362_0[var_362_1]
		end

		SetActive(arg_362_1.tipsGo_, false)

		function arg_362_1.onSingleLineFinish_()
			arg_362_1.onSingleLineUpdate_ = nil
			arg_362_1.onSingleLineFinish_ = nil
			arg_362_1.state_ = "waiting"
		end

		function arg_362_1.playNext_(arg_364_0)
			if arg_364_0 == 1 then
				arg_362_0:Play321332085(arg_362_1)
			end
		end

		function arg_362_1.onSingleLineUpdate_(arg_365_0)
			local var_365_0 = 0
			local var_365_1 = 0.3

			if var_365_0 < arg_362_1.time_ and arg_362_1.time_ <= var_365_0 + arg_365_0 then
				arg_362_1.talkMaxDuration = 0
				arg_362_1.dialogCg_.alpha = 1

				arg_362_1.dialog_:SetActive(true)
				SetActive(arg_362_1.leftNameGo_, true)

				local var_365_2 = arg_362_1:FormatText(StoryNameCfg[600].name)

				arg_362_1.leftNameTxt_.text = var_365_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_362_1.leftNameTxt_.transform)

				arg_362_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_362_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_362_1:RecordName(arg_362_1.leftNameTxt_.text)
				SetActive(arg_362_1.iconTrs_.gameObject, false)
				arg_362_1.callingController_:SetSelectedState("normal")

				local var_365_3 = arg_362_1:GetWordFromCfg(321332084)
				local var_365_4 = arg_362_1:FormatText(var_365_3.content)

				arg_362_1.text_.text = var_365_4

				LuaForUtil.ClearLinePrefixSymbol(arg_362_1.text_)

				local var_365_5 = 12
				local var_365_6 = utf8.len(var_365_4)
				local var_365_7 = var_365_5 <= 0 and var_365_1 or var_365_1 * (var_365_6 / var_365_5)

				if var_365_7 > 0 and var_365_1 < var_365_7 then
					arg_362_1.talkMaxDuration = var_365_7

					if var_365_7 + var_365_0 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_7 + var_365_0
					end
				end

				arg_362_1.text_.text = var_365_4
				arg_362_1.typewritter.percent = 0

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332084", "story_v_out_321332.awb") ~= 0 then
					local var_365_8 = manager.audio:GetVoiceLength("story_v_out_321332", "321332084", "story_v_out_321332.awb") / 1000

					if var_365_8 + var_365_0 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_8 + var_365_0
					end

					if var_365_3.prefab_name ~= "" and arg_362_1.actors_[var_365_3.prefab_name] ~= nil then
						local var_365_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_362_1.actors_[var_365_3.prefab_name].transform, "story_v_out_321332", "321332084", "story_v_out_321332.awb")

						arg_362_1:RecordAudio("321332084", var_365_9)
						arg_362_1:RecordAudio("321332084", var_365_9)
					else
						arg_362_1:AudioAction("play", "voice", "story_v_out_321332", "321332084", "story_v_out_321332.awb")
					end

					arg_362_1:RecordHistoryTalkVoice("story_v_out_321332", "321332084", "story_v_out_321332.awb")
				end

				arg_362_1:RecordContent(arg_362_1.text_.text)
			end

			local var_365_10 = math.max(var_365_1, arg_362_1.talkMaxDuration)

			if var_365_0 <= arg_362_1.time_ and arg_362_1.time_ < var_365_0 + var_365_10 then
				arg_362_1.typewritter.percent = (arg_362_1.time_ - var_365_0) / var_365_10

				arg_362_1.typewritter:SetDirty()
			end

			if arg_362_1.time_ >= var_365_0 + var_365_10 and arg_362_1.time_ < var_365_0 + var_365_10 + arg_365_0 then
				arg_362_1.typewritter.percent = 1

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(true)
			end
		end

		arg_362_1.nodeConfigList_ = {}

		arg_362_1:InitPlayNodeList()
	end,
	Play321332085 = function(arg_366_0, arg_366_1)
		arg_366_1.time_ = 0
		arg_366_1.frameCnt_ = 0
		arg_366_1.state_ = "playing"
		arg_366_1.curTalkId_ = 321332085
		arg_366_1.duration_ = 7.43

		local var_366_0 = {
			zh = 6.533,
			ja = 7.433
		}
		local var_366_1 = manager.audio:GetLocalizationFlag()

		if var_366_0[var_366_1] ~= nil then
			arg_366_1.duration_ = var_366_0[var_366_1]
		end

		SetActive(arg_366_1.tipsGo_, false)

		function arg_366_1.onSingleLineFinish_()
			arg_366_1.onSingleLineUpdate_ = nil
			arg_366_1.onSingleLineFinish_ = nil
			arg_366_1.state_ = "waiting"
		end

		function arg_366_1.playNext_(arg_368_0)
			if arg_368_0 == 1 then
				arg_366_0:Play321332086(arg_366_1)
			end
		end

		function arg_366_1.onSingleLineUpdate_(arg_369_0)
			local var_369_0 = 0
			local var_369_1 = 0.25

			if var_369_0 < arg_366_1.time_ and arg_366_1.time_ <= var_369_0 + arg_369_0 then
				arg_366_1.talkMaxDuration = 0
				arg_366_1.dialogCg_.alpha = 1

				arg_366_1.dialog_:SetActive(true)
				SetActive(arg_366_1.leftNameGo_, true)

				local var_369_2 = arg_366_1:FormatText(StoryNameCfg[600].name)

				arg_366_1.leftNameTxt_.text = var_369_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_366_1.leftNameTxt_.transform)

				arg_366_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_366_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_366_1:RecordName(arg_366_1.leftNameTxt_.text)
				SetActive(arg_366_1.iconTrs_.gameObject, false)
				arg_366_1.callingController_:SetSelectedState("normal")

				local var_369_3 = arg_366_1:GetWordFromCfg(321332085)
				local var_369_4 = arg_366_1:FormatText(var_369_3.content)

				arg_366_1.text_.text = var_369_4

				LuaForUtil.ClearLinePrefixSymbol(arg_366_1.text_)

				local var_369_5 = 10
				local var_369_6 = utf8.len(var_369_4)
				local var_369_7 = var_369_5 <= 0 and var_369_1 or var_369_1 * (var_369_6 / var_369_5)

				if var_369_7 > 0 and var_369_1 < var_369_7 then
					arg_366_1.talkMaxDuration = var_369_7

					if var_369_7 + var_369_0 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_7 + var_369_0
					end
				end

				arg_366_1.text_.text = var_369_4
				arg_366_1.typewritter.percent = 0

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332085", "story_v_out_321332.awb") ~= 0 then
					local var_369_8 = manager.audio:GetVoiceLength("story_v_out_321332", "321332085", "story_v_out_321332.awb") / 1000

					if var_369_8 + var_369_0 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_8 + var_369_0
					end

					if var_369_3.prefab_name ~= "" and arg_366_1.actors_[var_369_3.prefab_name] ~= nil then
						local var_369_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_366_1.actors_[var_369_3.prefab_name].transform, "story_v_out_321332", "321332085", "story_v_out_321332.awb")

						arg_366_1:RecordAudio("321332085", var_369_9)
						arg_366_1:RecordAudio("321332085", var_369_9)
					else
						arg_366_1:AudioAction("play", "voice", "story_v_out_321332", "321332085", "story_v_out_321332.awb")
					end

					arg_366_1:RecordHistoryTalkVoice("story_v_out_321332", "321332085", "story_v_out_321332.awb")
				end

				arg_366_1:RecordContent(arg_366_1.text_.text)
			end

			local var_369_10 = math.max(var_369_1, arg_366_1.talkMaxDuration)

			if var_369_0 <= arg_366_1.time_ and arg_366_1.time_ < var_369_0 + var_369_10 then
				arg_366_1.typewritter.percent = (arg_366_1.time_ - var_369_0) / var_369_10

				arg_366_1.typewritter:SetDirty()
			end

			if arg_366_1.time_ >= var_369_0 + var_369_10 and arg_366_1.time_ < var_369_0 + var_369_10 + arg_369_0 then
				arg_366_1.typewritter.percent = 1

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(true)
			end
		end

		arg_366_1.nodeConfigList_ = {}

		arg_366_1:InitPlayNodeList()
	end,
	Play321332086 = function(arg_370_0, arg_370_1)
		arg_370_1.time_ = 0
		arg_370_1.frameCnt_ = 0
		arg_370_1.state_ = "playing"
		arg_370_1.curTalkId_ = 321332086
		arg_370_1.duration_ = 4.1

		local var_370_0 = {
			zh = 4.1,
			ja = 3.566
		}
		local var_370_1 = manager.audio:GetLocalizationFlag()

		if var_370_0[var_370_1] ~= nil then
			arg_370_1.duration_ = var_370_0[var_370_1]
		end

		SetActive(arg_370_1.tipsGo_, false)

		function arg_370_1.onSingleLineFinish_()
			arg_370_1.onSingleLineUpdate_ = nil
			arg_370_1.onSingleLineFinish_ = nil
			arg_370_1.state_ = "waiting"
		end

		function arg_370_1.playNext_(arg_372_0)
			if arg_372_0 == 1 then
				arg_370_0:Play321332087(arg_370_1)
			end
		end

		function arg_370_1.onSingleLineUpdate_(arg_373_0)
			local var_373_0 = 0
			local var_373_1 = 1
			local var_373_2 = manager.audio:GetVoiceLength("story_v_out_321332", "321332086", "") / 1000

			if var_373_2 > 0 and var_373_1 < var_373_2 and var_373_2 + var_373_0 > arg_370_1.duration_ then
				local var_373_3 = var_373_2

				arg_370_1.duration_ = var_373_2 + var_373_0
			end

			if var_373_0 < arg_370_1.time_ and arg_370_1.time_ <= var_373_0 + arg_373_0 then
				local var_373_4 = "play"
				local var_373_5 = "voice"

				arg_370_1:AudioAction(var_373_4, var_373_5, "story_v_out_321332", "321332086", "")
			end

			local var_373_6 = 0.668
			local var_373_7 = 1

			if var_373_6 < arg_370_1.time_ and arg_370_1.time_ <= var_373_6 + arg_373_0 then
				local var_373_8 = "play"
				local var_373_9 = "effect"

				arg_370_1:AudioAction(var_373_8, var_373_9, "se_story_141", "se_story_141_boxing_drum02", "")
			end

			local var_373_10 = 0.579
			local var_373_11 = 1

			if var_373_10 < arg_370_1.time_ and arg_370_1.time_ <= var_373_10 + arg_373_0 then
				local var_373_12 = "play"
				local var_373_13 = "effect"

				arg_370_1:AudioAction(var_373_12, var_373_13, "se_story_141", "se_story_141_ravana_footstep03", "")
			end

			local var_373_14 = 0.415
			local var_373_15 = 1

			if var_373_14 < arg_370_1.time_ and arg_370_1.time_ <= var_373_14 + arg_373_0 then
				local var_373_16 = "play"
				local var_373_17 = "effect"

				arg_370_1:AudioAction(var_373_16, var_373_17, "se_story_141", "se_story_141_boxing_amb_cheer05_loop", "")
			end

			local var_373_18 = 0
			local var_373_19 = 1.6

			if var_373_18 < arg_370_1.time_ and arg_370_1.time_ <= var_373_18 + arg_373_0 then
				arg_370_1.talkMaxDuration = 0
				arg_370_1.dialogCg_.alpha = 1

				arg_370_1.dialog_:SetActive(true)
				SetActive(arg_370_1.leftNameGo_, false)

				arg_370_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_370_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_370_1:RecordName(arg_370_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_370_1.iconTrs_.gameObject, false)
				arg_370_1.callingController_:SetSelectedState("normal")

				local var_373_20 = arg_370_1:GetWordFromCfg(321332086)
				local var_373_21 = arg_370_1:FormatText(var_373_20.content)

				arg_370_1.text_.text = var_373_21

				LuaForUtil.ClearLinePrefixSymbol(arg_370_1.text_)

				local var_373_22 = 64
				local var_373_23 = utf8.len(var_373_21)
				local var_373_24 = var_373_22 <= 0 and var_373_19 or var_373_19 * (var_373_23 / var_373_22)

				if var_373_24 > 0 and var_373_19 < var_373_24 then
					arg_370_1.talkMaxDuration = var_373_24

					if var_373_24 + var_373_18 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_24 + var_373_18
					end
				end

				arg_370_1.text_.text = var_373_21
				arg_370_1.typewritter.percent = 0

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332086", "story_v_out_321332.awb") ~= 0 then
					local var_373_25 = manager.audio:GetVoiceLength("story_v_out_321332", "321332086", "story_v_out_321332.awb") / 1000

					if var_373_25 + var_373_18 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_25 + var_373_18
					end

					if var_373_20.prefab_name ~= "" and arg_370_1.actors_[var_373_20.prefab_name] ~= nil then
						local var_373_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_370_1.actors_[var_373_20.prefab_name].transform, "story_v_out_321332", "321332086", "story_v_out_321332.awb")

						arg_370_1:RecordAudio("321332086", var_373_26)
						arg_370_1:RecordAudio("321332086", var_373_26)
					else
						arg_370_1:AudioAction("play", "voice", "story_v_out_321332", "321332086", "story_v_out_321332.awb")
					end

					arg_370_1:RecordHistoryTalkVoice("story_v_out_321332", "321332086", "story_v_out_321332.awb")
				end

				arg_370_1:RecordContent(arg_370_1.text_.text)
			end

			local var_373_27 = math.max(var_373_19, arg_370_1.talkMaxDuration)

			if var_373_18 <= arg_370_1.time_ and arg_370_1.time_ < var_373_18 + var_373_27 then
				arg_370_1.typewritter.percent = (arg_370_1.time_ - var_373_18) / var_373_27

				arg_370_1.typewritter:SetDirty()
			end

			if arg_370_1.time_ >= var_373_18 + var_373_27 and arg_370_1.time_ < var_373_18 + var_373_27 + arg_373_0 then
				arg_370_1.typewritter.percent = 1

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(true)
			end
		end

		arg_370_1.nodeConfigList_ = {}

		arg_370_1:InitPlayNodeList()
	end,
	Play321332087 = function(arg_374_0, arg_374_1)
		arg_374_1.time_ = 0
		arg_374_1.frameCnt_ = 0
		arg_374_1.state_ = "playing"
		arg_374_1.curTalkId_ = 321332087
		arg_374_1.duration_ = 13.63

		local var_374_0 = {
			zh = 9.2,
			ja = 13.633
		}
		local var_374_1 = manager.audio:GetLocalizationFlag()

		if var_374_0[var_374_1] ~= nil then
			arg_374_1.duration_ = var_374_0[var_374_1]
		end

		SetActive(arg_374_1.tipsGo_, false)

		function arg_374_1.onSingleLineFinish_()
			arg_374_1.onSingleLineUpdate_ = nil
			arg_374_1.onSingleLineFinish_ = nil
			arg_374_1.state_ = "waiting"
		end

		function arg_374_1.playNext_(arg_376_0)
			if arg_376_0 == 1 then
				arg_374_0:Play321332088(arg_374_1)
			end
		end

		function arg_374_1.onSingleLineUpdate_(arg_377_0)
			local var_377_0 = 0
			local var_377_1 = 0.575

			if var_377_0 < arg_374_1.time_ and arg_374_1.time_ <= var_377_0 + arg_377_0 then
				arg_374_1.talkMaxDuration = 0
				arg_374_1.dialogCg_.alpha = 1

				arg_374_1.dialog_:SetActive(true)
				SetActive(arg_374_1.leftNameGo_, true)

				local var_377_2 = arg_374_1:FormatText(StoryNameCfg[600].name)

				arg_374_1.leftNameTxt_.text = var_377_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_374_1.leftNameTxt_.transform)

				arg_374_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_374_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_374_1:RecordName(arg_374_1.leftNameTxt_.text)
				SetActive(arg_374_1.iconTrs_.gameObject, false)
				arg_374_1.callingController_:SetSelectedState("normal")

				local var_377_3 = arg_374_1:GetWordFromCfg(321332087)
				local var_377_4 = arg_374_1:FormatText(var_377_3.content)

				arg_374_1.text_.text = var_377_4

				LuaForUtil.ClearLinePrefixSymbol(arg_374_1.text_)

				local var_377_5 = 23
				local var_377_6 = utf8.len(var_377_4)
				local var_377_7 = var_377_5 <= 0 and var_377_1 or var_377_1 * (var_377_6 / var_377_5)

				if var_377_7 > 0 and var_377_1 < var_377_7 then
					arg_374_1.talkMaxDuration = var_377_7

					if var_377_7 + var_377_0 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_7 + var_377_0
					end
				end

				arg_374_1.text_.text = var_377_4
				arg_374_1.typewritter.percent = 0

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332087", "story_v_out_321332.awb") ~= 0 then
					local var_377_8 = manager.audio:GetVoiceLength("story_v_out_321332", "321332087", "story_v_out_321332.awb") / 1000

					if var_377_8 + var_377_0 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_8 + var_377_0
					end

					if var_377_3.prefab_name ~= "" and arg_374_1.actors_[var_377_3.prefab_name] ~= nil then
						local var_377_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_374_1.actors_[var_377_3.prefab_name].transform, "story_v_out_321332", "321332087", "story_v_out_321332.awb")

						arg_374_1:RecordAudio("321332087", var_377_9)
						arg_374_1:RecordAudio("321332087", var_377_9)
					else
						arg_374_1:AudioAction("play", "voice", "story_v_out_321332", "321332087", "story_v_out_321332.awb")
					end

					arg_374_1:RecordHistoryTalkVoice("story_v_out_321332", "321332087", "story_v_out_321332.awb")
				end

				arg_374_1:RecordContent(arg_374_1.text_.text)
			end

			local var_377_10 = math.max(var_377_1, arg_374_1.talkMaxDuration)

			if var_377_0 <= arg_374_1.time_ and arg_374_1.time_ < var_377_0 + var_377_10 then
				arg_374_1.typewritter.percent = (arg_374_1.time_ - var_377_0) / var_377_10

				arg_374_1.typewritter:SetDirty()
			end

			if arg_374_1.time_ >= var_377_0 + var_377_10 and arg_374_1.time_ < var_377_0 + var_377_10 + arg_377_0 then
				arg_374_1.typewritter.percent = 1

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(true)
			end
		end

		arg_374_1.nodeConfigList_ = {}

		arg_374_1:InitPlayNodeList()
	end,
	Play321332088 = function(arg_378_0, arg_378_1)
		arg_378_1.time_ = 0
		arg_378_1.frameCnt_ = 0
		arg_378_1.state_ = "playing"
		arg_378_1.curTalkId_ = 321332088
		arg_378_1.duration_ = 14.97

		local var_378_0 = {
			zh = 8.666,
			ja = 14.966
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
				arg_378_0:Play321332089(arg_378_1)
			end
		end

		function arg_378_1.onSingleLineUpdate_(arg_381_0)
			local var_381_0 = 0
			local var_381_1 = 0.575

			if var_381_0 < arg_378_1.time_ and arg_378_1.time_ <= var_381_0 + arg_381_0 then
				arg_378_1.talkMaxDuration = 0
				arg_378_1.dialogCg_.alpha = 1

				arg_378_1.dialog_:SetActive(true)
				SetActive(arg_378_1.leftNameGo_, true)

				local var_381_2 = arg_378_1:FormatText(StoryNameCfg[600].name)

				arg_378_1.leftNameTxt_.text = var_381_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_378_1.leftNameTxt_.transform)

				arg_378_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_378_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_378_1:RecordName(arg_378_1.leftNameTxt_.text)
				SetActive(arg_378_1.iconTrs_.gameObject, false)
				arg_378_1.callingController_:SetSelectedState("normal")

				local var_381_3 = arg_378_1:GetWordFromCfg(321332088)
				local var_381_4 = arg_378_1:FormatText(var_381_3.content)

				arg_378_1.text_.text = var_381_4

				LuaForUtil.ClearLinePrefixSymbol(arg_378_1.text_)

				local var_381_5 = 23
				local var_381_6 = utf8.len(var_381_4)
				local var_381_7 = var_381_5 <= 0 and var_381_1 or var_381_1 * (var_381_6 / var_381_5)

				if var_381_7 > 0 and var_381_1 < var_381_7 then
					arg_378_1.talkMaxDuration = var_381_7

					if var_381_7 + var_381_0 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_7 + var_381_0
					end
				end

				arg_378_1.text_.text = var_381_4
				arg_378_1.typewritter.percent = 0

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332088", "story_v_out_321332.awb") ~= 0 then
					local var_381_8 = manager.audio:GetVoiceLength("story_v_out_321332", "321332088", "story_v_out_321332.awb") / 1000

					if var_381_8 + var_381_0 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_8 + var_381_0
					end

					if var_381_3.prefab_name ~= "" and arg_378_1.actors_[var_381_3.prefab_name] ~= nil then
						local var_381_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_378_1.actors_[var_381_3.prefab_name].transform, "story_v_out_321332", "321332088", "story_v_out_321332.awb")

						arg_378_1:RecordAudio("321332088", var_381_9)
						arg_378_1:RecordAudio("321332088", var_381_9)
					else
						arg_378_1:AudioAction("play", "voice", "story_v_out_321332", "321332088", "story_v_out_321332.awb")
					end

					arg_378_1:RecordHistoryTalkVoice("story_v_out_321332", "321332088", "story_v_out_321332.awb")
				end

				arg_378_1:RecordContent(arg_378_1.text_.text)
			end

			local var_381_10 = math.max(var_381_1, arg_378_1.talkMaxDuration)

			if var_381_0 <= arg_378_1.time_ and arg_378_1.time_ < var_381_0 + var_381_10 then
				arg_378_1.typewritter.percent = (arg_378_1.time_ - var_381_0) / var_381_10

				arg_378_1.typewritter:SetDirty()
			end

			if arg_378_1.time_ >= var_381_0 + var_381_10 and arg_378_1.time_ < var_381_0 + var_381_10 + arg_381_0 then
				arg_378_1.typewritter.percent = 1

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(true)
			end
		end

		arg_378_1.nodeConfigList_ = {}

		arg_378_1:InitPlayNodeList()
	end,
	Play321332089 = function(arg_382_0, arg_382_1)
		arg_382_1.time_ = 0
		arg_382_1.frameCnt_ = 0
		arg_382_1.state_ = "playing"
		arg_382_1.curTalkId_ = 321332089
		arg_382_1.duration_ = 11.63

		local var_382_0 = {
			zh = 8.966,
			ja = 11.633
		}
		local var_382_1 = manager.audio:GetLocalizationFlag()

		if var_382_0[var_382_1] ~= nil then
			arg_382_1.duration_ = var_382_0[var_382_1]
		end

		SetActive(arg_382_1.tipsGo_, false)

		function arg_382_1.onSingleLineFinish_()
			arg_382_1.onSingleLineUpdate_ = nil
			arg_382_1.onSingleLineFinish_ = nil
			arg_382_1.state_ = "waiting"
		end

		function arg_382_1.playNext_(arg_384_0)
			if arg_384_0 == 1 then
				arg_382_0:Play321332090(arg_382_1)
			end
		end

		function arg_382_1.onSingleLineUpdate_(arg_385_0)
			local var_385_0 = 0
			local var_385_1 = 0.55

			if var_385_0 < arg_382_1.time_ and arg_382_1.time_ <= var_385_0 + arg_385_0 then
				arg_382_1.talkMaxDuration = 0
				arg_382_1.dialogCg_.alpha = 1

				arg_382_1.dialog_:SetActive(true)
				SetActive(arg_382_1.leftNameGo_, true)

				local var_385_2 = arg_382_1:FormatText(StoryNameCfg[600].name)

				arg_382_1.leftNameTxt_.text = var_385_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_382_1.leftNameTxt_.transform)

				arg_382_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_382_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_382_1:RecordName(arg_382_1.leftNameTxt_.text)
				SetActive(arg_382_1.iconTrs_.gameObject, false)
				arg_382_1.callingController_:SetSelectedState("normal")

				local var_385_3 = arg_382_1:GetWordFromCfg(321332089)
				local var_385_4 = arg_382_1:FormatText(var_385_3.content)

				arg_382_1.text_.text = var_385_4

				LuaForUtil.ClearLinePrefixSymbol(arg_382_1.text_)

				local var_385_5 = 22
				local var_385_6 = utf8.len(var_385_4)
				local var_385_7 = var_385_5 <= 0 and var_385_1 or var_385_1 * (var_385_6 / var_385_5)

				if var_385_7 > 0 and var_385_1 < var_385_7 then
					arg_382_1.talkMaxDuration = var_385_7

					if var_385_7 + var_385_0 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_7 + var_385_0
					end
				end

				arg_382_1.text_.text = var_385_4
				arg_382_1.typewritter.percent = 0

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332089", "story_v_out_321332.awb") ~= 0 then
					local var_385_8 = manager.audio:GetVoiceLength("story_v_out_321332", "321332089", "story_v_out_321332.awb") / 1000

					if var_385_8 + var_385_0 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_8 + var_385_0
					end

					if var_385_3.prefab_name ~= "" and arg_382_1.actors_[var_385_3.prefab_name] ~= nil then
						local var_385_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_382_1.actors_[var_385_3.prefab_name].transform, "story_v_out_321332", "321332089", "story_v_out_321332.awb")

						arg_382_1:RecordAudio("321332089", var_385_9)
						arg_382_1:RecordAudio("321332089", var_385_9)
					else
						arg_382_1:AudioAction("play", "voice", "story_v_out_321332", "321332089", "story_v_out_321332.awb")
					end

					arg_382_1:RecordHistoryTalkVoice("story_v_out_321332", "321332089", "story_v_out_321332.awb")
				end

				arg_382_1:RecordContent(arg_382_1.text_.text)
			end

			local var_385_10 = math.max(var_385_1, arg_382_1.talkMaxDuration)

			if var_385_0 <= arg_382_1.time_ and arg_382_1.time_ < var_385_0 + var_385_10 then
				arg_382_1.typewritter.percent = (arg_382_1.time_ - var_385_0) / var_385_10

				arg_382_1.typewritter:SetDirty()
			end

			if arg_382_1.time_ >= var_385_0 + var_385_10 and arg_382_1.time_ < var_385_0 + var_385_10 + arg_385_0 then
				arg_382_1.typewritter.percent = 1

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(true)
			end
		end

		arg_382_1.nodeConfigList_ = {}

		arg_382_1:InitPlayNodeList()
	end,
	Play321332090 = function(arg_386_0, arg_386_1)
		arg_386_1.time_ = 0
		arg_386_1.frameCnt_ = 0
		arg_386_1.state_ = "playing"
		arg_386_1.curTalkId_ = 321332090
		arg_386_1.duration_ = 4

		local var_386_0 = {
			zh = 4,
			ja = 3.5
		}
		local var_386_1 = manager.audio:GetLocalizationFlag()

		if var_386_0[var_386_1] ~= nil then
			arg_386_1.duration_ = var_386_0[var_386_1]
		end

		SetActive(arg_386_1.tipsGo_, false)

		function arg_386_1.onSingleLineFinish_()
			arg_386_1.onSingleLineUpdate_ = nil
			arg_386_1.onSingleLineFinish_ = nil
			arg_386_1.state_ = "waiting"
		end

		function arg_386_1.playNext_(arg_388_0)
			if arg_388_0 == 1 then
				arg_386_0:Play321332091(arg_386_1)
			end
		end

		function arg_386_1.onSingleLineUpdate_(arg_389_0)
			local var_389_0 = 0
			local var_389_1 = 1

			if var_389_0 < arg_386_1.time_ and arg_386_1.time_ <= var_389_0 + arg_389_0 then
				local var_389_2 = "play"
				local var_389_3 = "effect"

				arg_386_1:AudioAction(var_389_2, var_389_3, "story_v_out_321332", "321332090", "")
			end

			local var_389_4 = 0.84
			local var_389_5 = 1

			if var_389_4 < arg_386_1.time_ and arg_386_1.time_ <= var_389_4 + arg_389_0 then
				local var_389_6 = "play"
				local var_389_7 = "effect"

				arg_386_1:AudioAction(var_389_6, var_389_7, "se_story_141", "se_story_141_boxing_drum02", "")
			end

			local var_389_8 = 0.269
			local var_389_9 = 1

			if var_389_8 < arg_386_1.time_ and arg_386_1.time_ <= var_389_8 + arg_389_0 then
				local var_389_10 = "play"
				local var_389_11 = "effect"

				arg_386_1:AudioAction(var_389_10, var_389_11, "se_story_141", "se_story_141_boxing_cheer03_begin", "")
			end

			local var_389_12 = 0
			local var_389_13 = 1.375

			if var_389_12 < arg_386_1.time_ and arg_386_1.time_ <= var_389_12 + arg_389_0 then
				arg_386_1.talkMaxDuration = 0
				arg_386_1.dialogCg_.alpha = 1

				arg_386_1.dialog_:SetActive(true)
				SetActive(arg_386_1.leftNameGo_, false)

				arg_386_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_386_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_386_1:RecordName(arg_386_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_386_1.iconTrs_.gameObject, false)
				arg_386_1.callingController_:SetSelectedState("normal")

				local var_389_14 = arg_386_1:GetWordFromCfg(321332090)
				local var_389_15 = arg_386_1:FormatText(var_389_14.content)

				arg_386_1.text_.text = var_389_15

				LuaForUtil.ClearLinePrefixSymbol(arg_386_1.text_)

				local var_389_16 = 55
				local var_389_17 = utf8.len(var_389_15)
				local var_389_18 = var_389_16 <= 0 and var_389_13 or var_389_13 * (var_389_17 / var_389_16)

				if var_389_18 > 0 and var_389_13 < var_389_18 then
					arg_386_1.talkMaxDuration = var_389_18

					if var_389_18 + var_389_12 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_18 + var_389_12
					end
				end

				arg_386_1.text_.text = var_389_15
				arg_386_1.typewritter.percent = 0

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332090", "story_v_out_321332.awb") ~= 0 then
					local var_389_19 = manager.audio:GetVoiceLength("story_v_out_321332", "321332090", "story_v_out_321332.awb") / 1000

					if var_389_19 + var_389_12 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_19 + var_389_12
					end

					if var_389_14.prefab_name ~= "" and arg_386_1.actors_[var_389_14.prefab_name] ~= nil then
						local var_389_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_386_1.actors_[var_389_14.prefab_name].transform, "story_v_out_321332", "321332090", "story_v_out_321332.awb")

						arg_386_1:RecordAudio("321332090", var_389_20)
						arg_386_1:RecordAudio("321332090", var_389_20)
					else
						arg_386_1:AudioAction("play", "voice", "story_v_out_321332", "321332090", "story_v_out_321332.awb")
					end

					arg_386_1:RecordHistoryTalkVoice("story_v_out_321332", "321332090", "story_v_out_321332.awb")
				end

				arg_386_1:RecordContent(arg_386_1.text_.text)
			end

			local var_389_21 = math.max(var_389_13, arg_386_1.talkMaxDuration)

			if var_389_12 <= arg_386_1.time_ and arg_386_1.time_ < var_389_12 + var_389_21 then
				arg_386_1.typewritter.percent = (arg_386_1.time_ - var_389_12) / var_389_21

				arg_386_1.typewritter:SetDirty()
			end

			if arg_386_1.time_ >= var_389_12 + var_389_21 and arg_386_1.time_ < var_389_12 + var_389_21 + arg_389_0 then
				arg_386_1.typewritter.percent = 1

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(true)
			end
		end

		arg_386_1.nodeConfigList_ = {}

		arg_386_1:InitPlayNodeList()
	end,
	Play321332091 = function(arg_390_0, arg_390_1)
		arg_390_1.time_ = 0
		arg_390_1.frameCnt_ = 0
		arg_390_1.state_ = "playing"
		arg_390_1.curTalkId_ = 321332091
		arg_390_1.duration_ = 5

		SetActive(arg_390_1.tipsGo_, false)

		function arg_390_1.onSingleLineFinish_()
			arg_390_1.onSingleLineUpdate_ = nil
			arg_390_1.onSingleLineFinish_ = nil
			arg_390_1.state_ = "waiting"
		end

		function arg_390_1.playNext_(arg_392_0)
			if arg_392_0 == 1 then
				arg_390_0:Play321332092(arg_390_1)
			end
		end

		function arg_390_1.onSingleLineUpdate_(arg_393_0)
			local var_393_0 = 0.05
			local var_393_1 = 1

			if var_393_0 < arg_390_1.time_ and arg_390_1.time_ <= var_393_0 + arg_393_0 then
				local var_393_2 = "play"
				local var_393_3 = "effect"

				arg_390_1:AudioAction(var_393_2, var_393_3, "se_story_141", "se_story_141_ravana_footstep04", "")
			end

			local var_393_4 = 0
			local var_393_5 = 1.25

			if var_393_4 < arg_390_1.time_ and arg_390_1.time_ <= var_393_4 + arg_393_0 then
				arg_390_1.talkMaxDuration = 0
				arg_390_1.dialogCg_.alpha = 1

				arg_390_1.dialog_:SetActive(true)
				SetActive(arg_390_1.leftNameGo_, false)

				arg_390_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_390_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_390_1:RecordName(arg_390_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_390_1.iconTrs_.gameObject, false)
				arg_390_1.callingController_:SetSelectedState("normal")

				local var_393_6 = arg_390_1:GetWordFromCfg(321332091)
				local var_393_7 = arg_390_1:FormatText(var_393_6.content)

				arg_390_1.text_.text = var_393_7

				LuaForUtil.ClearLinePrefixSymbol(arg_390_1.text_)

				local var_393_8 = 50
				local var_393_9 = utf8.len(var_393_7)
				local var_393_10 = var_393_8 <= 0 and var_393_5 or var_393_5 * (var_393_9 / var_393_8)

				if var_393_10 > 0 and var_393_5 < var_393_10 then
					arg_390_1.talkMaxDuration = var_393_10

					if var_393_10 + var_393_4 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_10 + var_393_4
					end
				end

				arg_390_1.text_.text = var_393_7
				arg_390_1.typewritter.percent = 0

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(false)
				arg_390_1:RecordContent(arg_390_1.text_.text)
			end

			local var_393_11 = math.max(var_393_5, arg_390_1.talkMaxDuration)

			if var_393_4 <= arg_390_1.time_ and arg_390_1.time_ < var_393_4 + var_393_11 then
				arg_390_1.typewritter.percent = (arg_390_1.time_ - var_393_4) / var_393_11

				arg_390_1.typewritter:SetDirty()
			end

			if arg_390_1.time_ >= var_393_4 + var_393_11 and arg_390_1.time_ < var_393_4 + var_393_11 + arg_393_0 then
				arg_390_1.typewritter.percent = 1

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(true)
			end
		end

		arg_390_1.nodeConfigList_ = {}

		arg_390_1:InitPlayNodeList()
	end,
	Play321332092 = function(arg_394_0, arg_394_1)
		arg_394_1.time_ = 0
		arg_394_1.frameCnt_ = 0
		arg_394_1.state_ = "playing"
		arg_394_1.curTalkId_ = 321332092
		arg_394_1.duration_ = 6.5

		SetActive(arg_394_1.tipsGo_, false)

		function arg_394_1.onSingleLineFinish_()
			arg_394_1.onSingleLineUpdate_ = nil
			arg_394_1.onSingleLineFinish_ = nil
			arg_394_1.state_ = "waiting"
		end

		function arg_394_1.playNext_(arg_396_0)
			if arg_396_0 == 1 then
				arg_394_0:Play321332093(arg_394_1)
			end
		end

		function arg_394_1.onSingleLineUpdate_(arg_397_0)
			local var_397_0 = 0

			if var_397_0 < arg_394_1.time_ and arg_394_1.time_ <= var_397_0 + arg_397_0 then
				local var_397_1 = manager.ui.mainCamera.transform.localPosition
				local var_397_2 = Vector3.New(0, 0, 10) + Vector3.New(var_397_1.x, var_397_1.y, 0)
				local var_397_3 = arg_394_1.bgs_.MS2110a

				var_397_3.transform.localPosition = var_397_2
				var_397_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_397_4 = var_397_3:GetComponent("SpriteRenderer")

				if var_397_4 and var_397_4.sprite then
					local var_397_5 = (var_397_3.transform.localPosition - var_397_1).z
					local var_397_6 = manager.ui.mainCameraCom_
					local var_397_7 = 2 * var_397_5 * Mathf.Tan(var_397_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_397_8 = var_397_7 * var_397_6.aspect
					local var_397_9 = var_397_4.sprite.bounds.size.x
					local var_397_10 = var_397_4.sprite.bounds.size.y
					local var_397_11 = var_397_8 / var_397_9
					local var_397_12 = var_397_7 / var_397_10
					local var_397_13 = var_397_12 < var_397_11 and var_397_11 or var_397_12

					var_397_3.transform.localScale = Vector3.New(var_397_13, var_397_13, 0)
				end

				for iter_397_0, iter_397_1 in pairs(arg_394_1.bgs_) do
					if iter_397_0 ~= "MS2110a" then
						iter_397_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_397_14 = manager.ui.mainCamera.transform
			local var_397_15 = 0

			if var_397_15 < arg_394_1.time_ and arg_394_1.time_ <= var_397_15 + arg_397_0 then
				arg_394_1.var_.shakeOldPos = var_397_14.localPosition
			end

			local var_397_16 = 0.6

			if var_397_15 <= arg_394_1.time_ and arg_394_1.time_ < var_397_15 + var_397_16 then
				local var_397_17 = (arg_394_1.time_ - var_397_15) / 0.066
				local var_397_18, var_397_19 = math.modf(var_397_17)

				var_397_14.localPosition = Vector3.New(var_397_19 * 0.13, var_397_19 * 0.13, var_397_19 * 0.13) + arg_394_1.var_.shakeOldPos
			end

			if arg_394_1.time_ >= var_397_15 + var_397_16 and arg_394_1.time_ < var_397_15 + var_397_16 + arg_397_0 then
				var_397_14.localPosition = arg_394_1.var_.shakeOldPos
			end

			local var_397_20 = 0

			if var_397_20 < arg_394_1.time_ and arg_394_1.time_ <= var_397_20 + arg_397_0 then
				arg_394_1.mask_.enabled = true
				arg_394_1.mask_.raycastTarget = true

				arg_394_1:SetGaussion(false)
			end

			local var_397_21 = 0.6

			if var_397_20 <= arg_394_1.time_ and arg_394_1.time_ < var_397_20 + var_397_21 then
				local var_397_22 = (arg_394_1.time_ - var_397_20) / var_397_21
				local var_397_23 = Color.New(1, 1, 1)

				var_397_23.a = Mathf.Lerp(1, 0, var_397_22)
				arg_394_1.mask_.color = var_397_23
			end

			if arg_394_1.time_ >= var_397_20 + var_397_21 and arg_394_1.time_ < var_397_20 + var_397_21 + arg_397_0 then
				local var_397_24 = Color.New(1, 1, 1)
				local var_397_25 = 0

				arg_394_1.mask_.enabled = false
				var_397_24.a = var_397_25
				arg_394_1.mask_.color = var_397_24
			end

			local var_397_26 = arg_394_1.bgs_.MS2110a.transform
			local var_397_27 = 0

			if var_397_27 < arg_394_1.time_ and arg_394_1.time_ <= var_397_27 + arg_397_0 then
				arg_394_1.var_.moveOldPosMS2110a = var_397_26.localPosition
			end

			local var_397_28 = 0.001

			if var_397_27 <= arg_394_1.time_ and arg_394_1.time_ < var_397_27 + var_397_28 then
				local var_397_29 = (arg_394_1.time_ - var_397_27) / var_397_28
				local var_397_30 = Vector3.New(0, 1.8, 6)

				var_397_26.localPosition = Vector3.Lerp(arg_394_1.var_.moveOldPosMS2110a, var_397_30, var_397_29)
			end

			if arg_394_1.time_ >= var_397_27 + var_397_28 and arg_394_1.time_ < var_397_27 + var_397_28 + arg_397_0 then
				var_397_26.localPosition = Vector3.New(0, 1.8, 6)
			end

			local var_397_31 = arg_394_1.bgs_.MS2110a.transform
			local var_397_32 = 0.0166666666666667

			if var_397_32 < arg_394_1.time_ and arg_394_1.time_ <= var_397_32 + arg_397_0 then
				arg_394_1.var_.moveOldPosMS2110a = var_397_31.localPosition
			end

			local var_397_33 = 3.5

			if var_397_32 <= arg_394_1.time_ and arg_394_1.time_ < var_397_32 + var_397_33 then
				local var_397_34 = (arg_394_1.time_ - var_397_32) / var_397_33
				local var_397_35 = Vector3.New(0, 2, 6)

				var_397_31.localPosition = Vector3.Lerp(arg_394_1.var_.moveOldPosMS2110a, var_397_35, var_397_34)
			end

			if arg_394_1.time_ >= var_397_32 + var_397_33 and arg_394_1.time_ < var_397_32 + var_397_33 + arg_397_0 then
				var_397_31.localPosition = Vector3.New(0, 2, 6)
			end

			local var_397_36 = 1

			if var_397_36 < arg_394_1.time_ and arg_394_1.time_ <= var_397_36 + arg_397_0 then
				arg_394_1.allBtn_.enabled = false
			end

			local var_397_37 = 2.51666666666667

			if arg_394_1.time_ >= var_397_36 + var_397_37 and arg_394_1.time_ < var_397_36 + var_397_37 + arg_397_0 then
				arg_394_1.allBtn_.enabled = true
			end

			local var_397_38 = 0
			local var_397_39 = 1

			if var_397_38 < arg_394_1.time_ and arg_394_1.time_ <= var_397_38 + arg_397_0 then
				local var_397_40 = "play"
				local var_397_41 = "effect"

				arg_394_1:AudioAction(var_397_40, var_397_41, "se_story_141", "se_story_141_boxing_whoosh05", "")
			end

			if arg_394_1.frameCnt_ <= 1 then
				arg_394_1.dialog_:SetActive(false)
			end

			local var_397_42 = 1.5
			local var_397_43 = 0.675

			if var_397_42 < arg_394_1.time_ and arg_394_1.time_ <= var_397_42 + arg_397_0 then
				arg_394_1.talkMaxDuration = 0

				arg_394_1.dialog_:SetActive(true)

				arg_394_1.dialogCg_.alpha = 0

				local var_397_44 = LeanTween.value(arg_394_1.dialog_, 0, 1, 0.3)

				var_397_44:setOnUpdate(LuaHelper.FloatAction(function(arg_398_0)
					arg_394_1.dialogCg_.alpha = arg_398_0
				end))
				var_397_44:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_394_1.dialog_)
					var_397_44:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_394_1.duration_ = arg_394_1.duration_ + 0.3

				SetActive(arg_394_1.leftNameGo_, false)

				arg_394_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_394_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_394_1:RecordName(arg_394_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_394_1.iconTrs_.gameObject, false)
				arg_394_1.callingController_:SetSelectedState("normal")

				local var_397_45 = arg_394_1:GetWordFromCfg(321332092)
				local var_397_46 = arg_394_1:FormatText(var_397_45.content)

				arg_394_1.text_.text = var_397_46

				LuaForUtil.ClearLinePrefixSymbol(arg_394_1.text_)

				local var_397_47 = 27
				local var_397_48 = utf8.len(var_397_46)
				local var_397_49 = var_397_47 <= 0 and var_397_43 or var_397_43 * (var_397_48 / var_397_47)

				if var_397_49 > 0 and var_397_43 < var_397_49 then
					arg_394_1.talkMaxDuration = var_397_49
					var_397_42 = var_397_42 + 0.3

					if var_397_49 + var_397_42 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_49 + var_397_42
					end
				end

				arg_394_1.text_.text = var_397_46
				arg_394_1.typewritter.percent = 0

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(false)
				arg_394_1:RecordContent(arg_394_1.text_.text)
			end

			local var_397_50 = var_397_42 + 0.3
			local var_397_51 = math.max(var_397_43, arg_394_1.talkMaxDuration)

			if var_397_50 <= arg_394_1.time_ and arg_394_1.time_ < var_397_50 + var_397_51 then
				arg_394_1.typewritter.percent = (arg_394_1.time_ - var_397_50) / var_397_51

				arg_394_1.typewritter:SetDirty()
			end

			if arg_394_1.time_ >= var_397_50 + var_397_51 and arg_394_1.time_ < var_397_50 + var_397_51 + arg_397_0 then
				arg_394_1.typewritter.percent = 1

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(true)
			end
		end

		arg_394_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "MS2110a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "MS2110a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3.5,
				className = "StoryMoveNode",
				startTime = 0.0166666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_394_1:InitPlayNodeList()
	end,
	Play321332093 = function(arg_400_0, arg_400_1)
		arg_400_1.time_ = 0
		arg_400_1.frameCnt_ = 0
		arg_400_1.state_ = "playing"
		arg_400_1.curTalkId_ = 321332093
		arg_400_1.duration_ = 5

		SetActive(arg_400_1.tipsGo_, false)

		function arg_400_1.onSingleLineFinish_()
			arg_400_1.onSingleLineUpdate_ = nil
			arg_400_1.onSingleLineFinish_ = nil
			arg_400_1.state_ = "waiting"
		end

		function arg_400_1.playNext_(arg_402_0)
			if arg_402_0 == 1 then
				arg_400_0:Play321332094(arg_400_1)
			end
		end

		function arg_400_1.onSingleLineUpdate_(arg_403_0)
			local var_403_0 = 0
			local var_403_1 = 1.475

			if var_403_0 < arg_400_1.time_ and arg_400_1.time_ <= var_403_0 + arg_403_0 then
				arg_400_1.talkMaxDuration = 0
				arg_400_1.dialogCg_.alpha = 1

				arg_400_1.dialog_:SetActive(true)
				SetActive(arg_400_1.leftNameGo_, false)

				arg_400_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_400_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_400_1:RecordName(arg_400_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_400_1.iconTrs_.gameObject, false)
				arg_400_1.callingController_:SetSelectedState("normal")

				local var_403_2 = arg_400_1:GetWordFromCfg(321332093)
				local var_403_3 = arg_400_1:FormatText(var_403_2.content)

				arg_400_1.text_.text = var_403_3

				LuaForUtil.ClearLinePrefixSymbol(arg_400_1.text_)

				local var_403_4 = 59
				local var_403_5 = utf8.len(var_403_3)
				local var_403_6 = var_403_4 <= 0 and var_403_1 or var_403_1 * (var_403_5 / var_403_4)

				if var_403_6 > 0 and var_403_1 < var_403_6 then
					arg_400_1.talkMaxDuration = var_403_6

					if var_403_6 + var_403_0 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_6 + var_403_0
					end
				end

				arg_400_1.text_.text = var_403_3
				arg_400_1.typewritter.percent = 0

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(false)
				arg_400_1:RecordContent(arg_400_1.text_.text)
			end

			local var_403_7 = math.max(var_403_1, arg_400_1.talkMaxDuration)

			if var_403_0 <= arg_400_1.time_ and arg_400_1.time_ < var_403_0 + var_403_7 then
				arg_400_1.typewritter.percent = (arg_400_1.time_ - var_403_0) / var_403_7

				arg_400_1.typewritter:SetDirty()
			end

			if arg_400_1.time_ >= var_403_0 + var_403_7 and arg_400_1.time_ < var_403_0 + var_403_7 + arg_403_0 then
				arg_400_1.typewritter.percent = 1

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(true)
			end
		end

		arg_400_1.nodeConfigList_ = {}

		arg_400_1:InitPlayNodeList()
	end,
	Play321332094 = function(arg_404_0, arg_404_1)
		arg_404_1.time_ = 0
		arg_404_1.frameCnt_ = 0
		arg_404_1.state_ = "playing"
		arg_404_1.curTalkId_ = 321332094
		arg_404_1.duration_ = 7.93

		local var_404_0 = {
			zh = 7.933,
			ja = 6.133
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
				arg_404_0:Play321332095(arg_404_1)
			end
		end

		function arg_404_1.onSingleLineUpdate_(arg_407_0)
			local var_407_0 = 0
			local var_407_1 = 0.25

			if var_407_0 < arg_404_1.time_ and arg_404_1.time_ <= var_407_0 + arg_407_0 then
				arg_404_1.talkMaxDuration = 0
				arg_404_1.dialogCg_.alpha = 1

				arg_404_1.dialog_:SetActive(true)
				SetActive(arg_404_1.leftNameGo_, true)

				local var_407_2 = arg_404_1:FormatText(StoryNameCfg[600].name)

				arg_404_1.leftNameTxt_.text = var_407_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_404_1.leftNameTxt_.transform)

				arg_404_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_404_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_404_1:RecordName(arg_404_1.leftNameTxt_.text)
				SetActive(arg_404_1.iconTrs_.gameObject, false)
				arg_404_1.callingController_:SetSelectedState("normal")

				local var_407_3 = arg_404_1:GetWordFromCfg(321332094)
				local var_407_4 = arg_404_1:FormatText(var_407_3.content)

				arg_404_1.text_.text = var_407_4

				LuaForUtil.ClearLinePrefixSymbol(arg_404_1.text_)

				local var_407_5 = 10
				local var_407_6 = utf8.len(var_407_4)
				local var_407_7 = var_407_5 <= 0 and var_407_1 or var_407_1 * (var_407_6 / var_407_5)

				if var_407_7 > 0 and var_407_1 < var_407_7 then
					arg_404_1.talkMaxDuration = var_407_7

					if var_407_7 + var_407_0 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_7 + var_407_0
					end
				end

				arg_404_1.text_.text = var_407_4
				arg_404_1.typewritter.percent = 0

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332094", "story_v_out_321332.awb") ~= 0 then
					local var_407_8 = manager.audio:GetVoiceLength("story_v_out_321332", "321332094", "story_v_out_321332.awb") / 1000

					if var_407_8 + var_407_0 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_8 + var_407_0
					end

					if var_407_3.prefab_name ~= "" and arg_404_1.actors_[var_407_3.prefab_name] ~= nil then
						local var_407_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_404_1.actors_[var_407_3.prefab_name].transform, "story_v_out_321332", "321332094", "story_v_out_321332.awb")

						arg_404_1:RecordAudio("321332094", var_407_9)
						arg_404_1:RecordAudio("321332094", var_407_9)
					else
						arg_404_1:AudioAction("play", "voice", "story_v_out_321332", "321332094", "story_v_out_321332.awb")
					end

					arg_404_1:RecordHistoryTalkVoice("story_v_out_321332", "321332094", "story_v_out_321332.awb")
				end

				arg_404_1:RecordContent(arg_404_1.text_.text)
			end

			local var_407_10 = math.max(var_407_1, arg_404_1.talkMaxDuration)

			if var_407_0 <= arg_404_1.time_ and arg_404_1.time_ < var_407_0 + var_407_10 then
				arg_404_1.typewritter.percent = (arg_404_1.time_ - var_407_0) / var_407_10

				arg_404_1.typewritter:SetDirty()
			end

			if arg_404_1.time_ >= var_407_0 + var_407_10 and arg_404_1.time_ < var_407_0 + var_407_10 + arg_407_0 then
				arg_404_1.typewritter.percent = 1

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(true)
			end
		end

		arg_404_1.nodeConfigList_ = {}

		arg_404_1:InitPlayNodeList()
	end,
	Play321332095 = function(arg_408_0, arg_408_1)
		arg_408_1.time_ = 0
		arg_408_1.frameCnt_ = 0
		arg_408_1.state_ = "playing"
		arg_408_1.curTalkId_ = 321332095
		arg_408_1.duration_ = 8.23

		local var_408_0 = {
			zh = 8.233,
			ja = 7.2
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
				arg_408_0:Play321332096(arg_408_1)
			end
		end

		function arg_408_1.onSingleLineUpdate_(arg_411_0)
			local var_411_0 = 2

			if var_411_0 < arg_408_1.time_ and arg_408_1.time_ <= var_411_0 + arg_411_0 then
				local var_411_1 = manager.ui.mainCamera.transform.localPosition
				local var_411_2 = Vector3.New(0, 0, 10) + Vector3.New(var_411_1.x, var_411_1.y, 0)
				local var_411_3 = arg_408_1.bgs_.STwhite

				var_411_3.transform.localPosition = var_411_2
				var_411_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_411_4 = var_411_3:GetComponent("SpriteRenderer")

				if var_411_4 and var_411_4.sprite then
					local var_411_5 = (var_411_3.transform.localPosition - var_411_1).z
					local var_411_6 = manager.ui.mainCameraCom_
					local var_411_7 = 2 * var_411_5 * Mathf.Tan(var_411_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_411_8 = var_411_7 * var_411_6.aspect
					local var_411_9 = var_411_4.sprite.bounds.size.x
					local var_411_10 = var_411_4.sprite.bounds.size.y
					local var_411_11 = var_411_8 / var_411_9
					local var_411_12 = var_411_7 / var_411_10
					local var_411_13 = var_411_12 < var_411_11 and var_411_11 or var_411_12

					var_411_3.transform.localScale = Vector3.New(var_411_13, var_411_13, 0)
				end

				for iter_411_0, iter_411_1 in pairs(arg_408_1.bgs_) do
					if iter_411_0 ~= "STwhite" then
						iter_411_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_411_14 = 4

			if var_411_14 < arg_408_1.time_ and arg_408_1.time_ <= var_411_14 + arg_411_0 then
				arg_408_1.allBtn_.enabled = false
			end

			local var_411_15 = 0.3

			if arg_408_1.time_ >= var_411_14 + var_411_15 and arg_408_1.time_ < var_411_14 + var_411_15 + arg_411_0 then
				arg_408_1.allBtn_.enabled = true
			end

			local var_411_16 = 0

			if var_411_16 < arg_408_1.time_ and arg_408_1.time_ <= var_411_16 + arg_411_0 then
				arg_408_1.mask_.enabled = true
				arg_408_1.mask_.raycastTarget = true

				arg_408_1:SetGaussion(false)
			end

			local var_411_17 = 2

			if var_411_16 <= arg_408_1.time_ and arg_408_1.time_ < var_411_16 + var_411_17 then
				local var_411_18 = (arg_408_1.time_ - var_411_16) / var_411_17
				local var_411_19 = Color.New(0, 0, 0)

				var_411_19.a = Mathf.Lerp(0, 1, var_411_18)
				arg_408_1.mask_.color = var_411_19
			end

			if arg_408_1.time_ >= var_411_16 + var_411_17 and arg_408_1.time_ < var_411_16 + var_411_17 + arg_411_0 then
				local var_411_20 = Color.New(0, 0, 0)

				var_411_20.a = 1
				arg_408_1.mask_.color = var_411_20
			end

			local var_411_21 = 2

			if var_411_21 < arg_408_1.time_ and arg_408_1.time_ <= var_411_21 + arg_411_0 then
				arg_408_1.mask_.enabled = true
				arg_408_1.mask_.raycastTarget = true

				arg_408_1:SetGaussion(false)
			end

			local var_411_22 = 2

			if var_411_21 <= arg_408_1.time_ and arg_408_1.time_ < var_411_21 + var_411_22 then
				local var_411_23 = (arg_408_1.time_ - var_411_21) / var_411_22
				local var_411_24 = Color.New(0, 0, 0)

				var_411_24.a = Mathf.Lerp(1, 0, var_411_23)
				arg_408_1.mask_.color = var_411_24
			end

			if arg_408_1.time_ >= var_411_21 + var_411_22 and arg_408_1.time_ < var_411_21 + var_411_22 + arg_411_0 then
				local var_411_25 = Color.New(0, 0, 0)
				local var_411_26 = 0

				arg_408_1.mask_.enabled = false
				var_411_25.a = var_411_26
				arg_408_1.mask_.color = var_411_25
			end

			local var_411_27 = 0
			local var_411_28 = 1
			local var_411_29 = manager.audio:GetVoiceLength("story_v_out_321332", "321332095", "") / 1000

			if var_411_29 > 0 and var_411_28 < var_411_29 and var_411_29 + var_411_27 > arg_408_1.duration_ then
				local var_411_30 = var_411_29

				arg_408_1.duration_ = var_411_29 + var_411_27
			end

			if var_411_27 < arg_408_1.time_ and arg_408_1.time_ <= var_411_27 + arg_411_0 then
				local var_411_31 = "play"
				local var_411_32 = "voice"

				arg_408_1:AudioAction(var_411_31, var_411_32, "story_v_out_321332", "321332095", "")
			end

			local var_411_33 = 0.764
			local var_411_34 = 1

			if var_411_33 < arg_408_1.time_ and arg_408_1.time_ <= var_411_33 + arg_411_0 then
				local var_411_35 = "play"
				local var_411_36 = "effect"

				arg_408_1:AudioAction(var_411_35, var_411_36, "se_story_141", "se_story_141_boxing_bell01", "")
			end

			local var_411_37 = 0.764
			local var_411_38 = 1

			if var_411_37 < arg_408_1.time_ and arg_408_1.time_ <= var_411_37 + arg_411_0 then
				local var_411_39 = "play"
				local var_411_40 = "effect"

				arg_408_1:AudioAction(var_411_39, var_411_40, "se_story_141", "se_story_141_boxing_amb_cheer06_loop", "")
			end

			local var_411_41 = 1.491
			local var_411_42 = 1

			if var_411_41 < arg_408_1.time_ and arg_408_1.time_ <= var_411_41 + arg_411_0 then
				local var_411_43 = "stop"
				local var_411_44 = "effect"

				arg_408_1:AudioAction(var_411_43, var_411_44, "se_story_141", "se_story_141_boxing_amb_cheer05_loop", "")
			end

			local var_411_45 = 1.491
			local var_411_46 = 1

			if var_411_45 < arg_408_1.time_ and arg_408_1.time_ <= var_411_45 + arg_411_0 then
				local var_411_47 = "stop"
				local var_411_48 = "effect"

				arg_408_1:AudioAction(var_411_47, var_411_48, "se_story_141", "se_story_141_boxing_amb_cheer04_loop", "")
			end

			if arg_408_1.frameCnt_ <= 1 then
				arg_408_1.dialog_:SetActive(false)
			end

			local var_411_49 = 4
			local var_411_50 = 1.125

			if var_411_49 < arg_408_1.time_ and arg_408_1.time_ <= var_411_49 + arg_411_0 then
				arg_408_1.talkMaxDuration = 0

				arg_408_1.dialog_:SetActive(true)

				arg_408_1.dialogCg_.alpha = 0

				local var_411_51 = LeanTween.value(arg_408_1.dialog_, 0, 1, 0.3)

				var_411_51:setOnUpdate(LuaHelper.FloatAction(function(arg_412_0)
					arg_408_1.dialogCg_.alpha = arg_412_0
				end))
				var_411_51:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_408_1.dialog_)
					var_411_51:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_408_1.duration_ = arg_408_1.duration_ + 0.3

				SetActive(arg_408_1.leftNameGo_, false)

				arg_408_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_408_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_408_1:RecordName(arg_408_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_408_1.iconTrs_.gameObject, false)
				arg_408_1.callingController_:SetSelectedState("normal")

				local var_411_52 = arg_408_1:GetWordFromCfg(321332095)
				local var_411_53 = arg_408_1:FormatText(var_411_52.content)

				arg_408_1.text_.text = var_411_53

				LuaForUtil.ClearLinePrefixSymbol(arg_408_1.text_)

				local var_411_54 = 45
				local var_411_55 = utf8.len(var_411_53)
				local var_411_56 = var_411_54 <= 0 and var_411_50 or var_411_50 * (var_411_55 / var_411_54)

				if var_411_56 > 0 and var_411_50 < var_411_56 then
					arg_408_1.talkMaxDuration = var_411_56
					var_411_49 = var_411_49 + 0.3

					if var_411_56 + var_411_49 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_56 + var_411_49
					end
				end

				arg_408_1.text_.text = var_411_53
				arg_408_1.typewritter.percent = 0

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332095", "story_v_out_321332.awb") ~= 0 then
					local var_411_57 = manager.audio:GetVoiceLength("story_v_out_321332", "321332095", "story_v_out_321332.awb") / 1000

					if var_411_57 + var_411_49 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_57 + var_411_49
					end

					if var_411_52.prefab_name ~= "" and arg_408_1.actors_[var_411_52.prefab_name] ~= nil then
						local var_411_58 = LuaForUtil.PlayVoiceWithCriLipsync(arg_408_1.actors_[var_411_52.prefab_name].transform, "story_v_out_321332", "321332095", "story_v_out_321332.awb")

						arg_408_1:RecordAudio("321332095", var_411_58)
						arg_408_1:RecordAudio("321332095", var_411_58)
					else
						arg_408_1:AudioAction("play", "voice", "story_v_out_321332", "321332095", "story_v_out_321332.awb")
					end

					arg_408_1:RecordHistoryTalkVoice("story_v_out_321332", "321332095", "story_v_out_321332.awb")
				end

				arg_408_1:RecordContent(arg_408_1.text_.text)
			end

			local var_411_59 = var_411_49 + 0.3
			local var_411_60 = math.max(var_411_50, arg_408_1.talkMaxDuration)

			if var_411_59 <= arg_408_1.time_ and arg_408_1.time_ < var_411_59 + var_411_60 then
				arg_408_1.typewritter.percent = (arg_408_1.time_ - var_411_59) / var_411_60

				arg_408_1.typewritter:SetDirty()
			end

			if arg_408_1.time_ >= var_411_59 + var_411_60 and arg_408_1.time_ < var_411_59 + var_411_60 + arg_411_0 then
				arg_408_1.typewritter.percent = 1

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(true)
			end
		end

		arg_408_1.nodeConfigList_ = {}

		arg_408_1:InitPlayNodeList()
	end,
	Play321332096 = function(arg_414_0, arg_414_1)
		arg_414_1.time_ = 0
		arg_414_1.frameCnt_ = 0
		arg_414_1.state_ = "playing"
		arg_414_1.curTalkId_ = 321332096
		arg_414_1.duration_ = 5

		SetActive(arg_414_1.tipsGo_, false)

		function arg_414_1.onSingleLineFinish_()
			arg_414_1.onSingleLineUpdate_ = nil
			arg_414_1.onSingleLineFinish_ = nil
			arg_414_1.state_ = "waiting"
			arg_414_1.auto_ = false
		end

		function arg_414_1.playNext_(arg_416_0)
			arg_414_1.onStoryFinished_()
		end

		function arg_414_1.onSingleLineUpdate_(arg_417_0)
			local var_417_0 = 0
			local var_417_1 = 1

			if var_417_0 < arg_414_1.time_ and arg_414_1.time_ <= var_417_0 + arg_417_0 then
				local var_417_2 = "play"
				local var_417_3 = "effect"

				arg_414_1:AudioAction(var_417_2, var_417_3, "se_story_141", "se_story_141_boxing_bell02", "")
			end

			local var_417_4 = 0
			local var_417_5 = 1

			if var_417_4 < arg_414_1.time_ and arg_414_1.time_ <= var_417_4 + arg_417_0 then
				local var_417_6 = "stop"
				local var_417_7 = "effect"

				arg_414_1:AudioAction(var_417_6, var_417_7, "se_story_141", "se_story_141_boxing_amb_cheer06_loop", "")
			end

			local var_417_8 = 0
			local var_417_9 = 0.25

			if var_417_8 < arg_414_1.time_ and arg_414_1.time_ <= var_417_8 + arg_417_0 then
				arg_414_1.talkMaxDuration = 0
				arg_414_1.dialogCg_.alpha = 1

				arg_414_1.dialog_:SetActive(true)
				SetActive(arg_414_1.leftNameGo_, false)

				arg_414_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_414_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_414_1:RecordName(arg_414_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_414_1.iconTrs_.gameObject, false)
				arg_414_1.callingController_:SetSelectedState("normal")

				local var_417_10 = arg_414_1:GetWordFromCfg(321332096)
				local var_417_11 = arg_414_1:FormatText(var_417_10.content)

				arg_414_1.text_.text = var_417_11

				LuaForUtil.ClearLinePrefixSymbol(arg_414_1.text_)

				local var_417_12 = 10
				local var_417_13 = utf8.len(var_417_11)
				local var_417_14 = var_417_12 <= 0 and var_417_9 or var_417_9 * (var_417_13 / var_417_12)

				if var_417_14 > 0 and var_417_9 < var_417_14 then
					arg_414_1.talkMaxDuration = var_417_14

					if var_417_14 + var_417_8 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_14 + var_417_8
					end
				end

				arg_414_1.text_.text = var_417_11
				arg_414_1.typewritter.percent = 0

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(false)
				arg_414_1:RecordContent(arg_414_1.text_.text)
			end

			local var_417_15 = math.max(var_417_9, arg_414_1.talkMaxDuration)

			if var_417_8 <= arg_414_1.time_ and arg_414_1.time_ < var_417_8 + var_417_15 then
				arg_414_1.typewritter.percent = (arg_414_1.time_ - var_417_8) / var_417_15

				arg_414_1.typewritter:SetDirty()
			end

			if arg_414_1.time_ >= var_417_8 + var_417_15 and arg_414_1.time_ < var_417_8 + var_417_15 + arg_417_0 then
				arg_414_1.typewritter.percent = 1

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(true)
			end
		end

		arg_414_1.nodeConfigList_ = {}

		arg_414_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/L11f",
		"TextureConfig/Background/MS2110",
		"TextureConfig/Background/STwhite",
		"TextureConfig/Background/ST65",
		"TextureConfig/Background/L01g",
		"TextureConfig/Background/L09h",
		"TextureConfig/Background/MS2110a"
	},
	voices = {
		"story_v_out_321332.awb"
	}
}
