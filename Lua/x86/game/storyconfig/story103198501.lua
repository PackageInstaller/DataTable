return {
	Play319851001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 319851001
		arg_1_1.duration_ = 3.53

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play319851002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = 0
			local var_4_1 = 0.2

			if var_4_0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				local var_4_2 = "play"
				local var_4_3 = "music"

				arg_1_1:AudioAction(var_4_2, var_4_3, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_4 = ""
				local var_4_5 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_5 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_5 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_5

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_5
						arg_1_1.bgmTxt2_.text = var_4_5
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

			local var_4_6 = 0.233333333333333
			local var_4_7 = 1

			if var_4_6 < arg_1_1.time_ and arg_1_1.time_ <= var_4_6 + arg_4_0 then
				local var_4_8 = "play"
				local var_4_9 = "music"

				arg_1_1:AudioAction(var_4_8, var_4_9, "bgm_activity_3_0_story_intense_piano", "bgm_activity_3_0_story_intense_piano", "bgm_activity_3_0_story_intense_piano.awb")

				local var_4_10 = ""
				local var_4_11 = manager.audio:GetAudioName("bgm_activity_3_0_story_intense_piano", "bgm_activity_3_0_story_intense_piano")

				if var_4_11 ~= "" then
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

			local var_4_12 = 0

			if var_4_12 < arg_1_1.time_ and arg_1_1.time_ <= var_4_12 + arg_4_0 then
				local var_4_13 = arg_1_1.fswbg_.transform:Find("textbox/adapt/content") or arg_1_1.fswbg_.transform:Find("textbox/content")
				local var_4_14 = arg_1_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_4_15 = var_4_13:GetComponent("Text")
				local var_4_16 = var_4_13:GetComponent("RectTransform")

				var_4_15.alignment = UnityEngine.TextAnchor.LowerCenter
				var_4_16.offsetMin = Vector2.New(0, 0)
				var_4_16.offsetMax = Vector2.New(0, 0)
			end

			local var_4_17 = 0

			if var_4_17 < arg_1_1.time_ and arg_1_1.time_ <= var_4_17 + arg_4_0 then
				arg_1_1.fswbg_:SetActive(true)
				arg_1_1.dialog_:SetActive(false)

				arg_1_1.fswtw_.percent = 0

				local var_4_18 = arg_1_1:GetWordFromCfg(319851001)
				local var_4_19 = arg_1_1:FormatText(var_4_18.content)

				arg_1_1.fswt_.text = var_4_19

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.fswt_)

				arg_1_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_1_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_1_1.fswtw_:SetDirty()

				arg_1_1.typewritterCharCountI18N = 0

				SetActive(arg_1_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_1_1:ShowNextGo(false)
			end

			local var_4_20 = 0.566666666666667

			if var_4_20 < arg_1_1.time_ and arg_1_1.time_ <= var_4_20 + arg_4_0 then
				arg_1_1.var_.oldValueTypewriter = arg_1_1.fswtw_.percent

				SetActive(arg_1_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_1_1:ShowNextGo(false)
			end

			local var_4_21 = 8
			local var_4_22 = 0.533333333333333
			local var_4_23 = arg_1_1:GetWordFromCfg(319851001)
			local var_4_24 = arg_1_1:FormatText(var_4_23.content)
			local var_4_25, var_4_26 = arg_1_1:GetPercentByPara(var_4_24, 1)

			if var_4_20 < arg_1_1.time_ and arg_1_1.time_ <= var_4_20 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				local var_4_27 = var_4_21 <= 0 and var_4_22 or var_4_22 * ((var_4_26 - arg_1_1.typewritterCharCountI18N) / var_4_21)

				if var_4_27 > 0 and var_4_22 < var_4_27 then
					arg_1_1.talkMaxDuration = var_4_27

					if var_4_27 + var_4_20 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_27 + var_4_20
					end
				end
			end

			local var_4_28 = 0.533333333333333
			local var_4_29 = math.max(var_4_28, arg_1_1.talkMaxDuration)

			if var_4_20 <= arg_1_1.time_ and arg_1_1.time_ < var_4_20 + var_4_29 then
				local var_4_30 = (arg_1_1.time_ - var_4_20) / var_4_29

				arg_1_1.fswtw_.percent = Mathf.Lerp(arg_1_1.var_.oldValueTypewriter, var_4_25, var_4_30)
				arg_1_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_1_1.fswtw_:SetDirty()
			end

			if arg_1_1.time_ >= var_4_20 + var_4_29 and arg_1_1.time_ < var_4_20 + var_4_29 + arg_4_0 then
				arg_1_1.fswtw_.percent = var_4_25

				arg_1_1.fswtw_:SetDirty()
				arg_1_1:ShowNextGo(true)

				arg_1_1.typewritterCharCountI18N = var_4_26
			end

			local var_4_31 = "STblack"

			if arg_1_1.bgs_[var_4_31] == nil then
				local var_4_32 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_32:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_31)
				var_4_32.name = var_4_31
				var_4_32.transform.parent = arg_1_1.stage_.transform
				var_4_32.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_31] = var_4_32
			end

			local var_4_33 = 0

			if var_4_33 < arg_1_1.time_ and arg_1_1.time_ <= var_4_33 + arg_4_0 then
				local var_4_34 = manager.ui.mainCamera.transform.localPosition
				local var_4_35 = Vector3.New(0, 0, 10) + Vector3.New(var_4_34.x, var_4_34.y, 0)
				local var_4_36 = arg_1_1.bgs_.STblack

				var_4_36.transform.localPosition = var_4_35
				var_4_36.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_37 = var_4_36:GetComponent("SpriteRenderer")

				if var_4_37 and var_4_37.sprite then
					local var_4_38 = (var_4_36.transform.localPosition - var_4_34).z
					local var_4_39 = manager.ui.mainCameraCom_
					local var_4_40 = 2 * var_4_38 * Mathf.Tan(var_4_39.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_4_41 = var_4_40 * var_4_39.aspect
					local var_4_42 = var_4_37.sprite.bounds.size.x
					local var_4_43 = var_4_37.sprite.bounds.size.y
					local var_4_44 = var_4_41 / var_4_42
					local var_4_45 = var_4_40 / var_4_43
					local var_4_46 = var_4_45 < var_4_44 and var_4_44 or var_4_45

					var_4_36.transform.localScale = Vector3.New(var_4_46, var_4_46, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "STblack" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_47 = 0.566666666666667
			local var_4_48 = 2.966
			local var_4_49 = manager.audio:GetVoiceLength("story_v_out_319851", "319851001", "story_v_out_319851.awb") / 1000

			if var_4_49 > 0 and var_4_48 < var_4_49 and var_4_49 + var_4_47 > arg_1_1.duration_ then
				local var_4_50 = var_4_49

				arg_1_1.duration_ = var_4_49 + var_4_47
			end

			if var_4_47 < arg_1_1.time_ and arg_1_1.time_ <= var_4_47 + arg_4_0 then
				local var_4_51 = "play"
				local var_4_52 = "voice"

				arg_1_1:AudioAction(var_4_51, var_4_52, "story_v_out_319851", "319851001", "story_v_out_319851.awb")
			end

			local var_4_53 = 0

			if var_4_53 < arg_1_1.time_ and arg_1_1.time_ <= var_4_53 + arg_4_0 then
				arg_1_1.cswbg_:SetActive(true)

				local var_4_54 = arg_1_1.cswt_:GetComponent("RectTransform")

				arg_1_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_4_54.offsetMin = Vector2.New(410, 330)
				var_4_54.offsetMax = Vector2.New(-400, -175)

				local var_4_55 = arg_1_1:GetWordFromCfg(419057)
				local var_4_56 = arg_1_1:FormatText(var_4_55.content)

				arg_1_1.cswt_.text = var_4_56

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.cswt_)

				arg_1_1.cswt_.fontSize = 180
				arg_1_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_1_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_1_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play319851002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 319851002
		arg_7_1.duration_ = 5.57

		local var_7_0 = {
			zh = 3.86666666666667,
			ja = 5.56666666666667
		}
		local var_7_1 = manager.audio:GetLocalizationFlag()

		if var_7_0[var_7_1] ~= nil then
			arg_7_1.duration_ = var_7_0[var_7_1]
		end

		SetActive(arg_7_1.tipsGo_, false)

		function arg_7_1.onSingleLineFinish_()
			arg_7_1.onSingleLineUpdate_ = nil
			arg_7_1.onSingleLineFinish_ = nil
			arg_7_1.state_ = "waiting"
		end

		function arg_7_1.playNext_(arg_9_0)
			if arg_9_0 == 1 then
				arg_7_0:Play319851003(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			local var_10_0 = "I11o"

			if arg_7_1.bgs_[var_10_0] == nil then
				local var_10_1 = Object.Instantiate(arg_7_1.paintGo_)

				var_10_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_10_0)
				var_10_1.name = var_10_0
				var_10_1.transform.parent = arg_7_1.stage_.transform
				var_10_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_7_1.bgs_[var_10_0] = var_10_1
			end

			local var_10_2 = 0

			if var_10_2 < arg_7_1.time_ and arg_7_1.time_ <= var_10_2 + arg_10_0 then
				local var_10_3 = manager.ui.mainCamera.transform.localPosition
				local var_10_4 = Vector3.New(0, 0, 10) + Vector3.New(var_10_3.x, var_10_3.y, 0)
				local var_10_5 = arg_7_1.bgs_.I11o

				var_10_5.transform.localPosition = var_10_4
				var_10_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_10_6 = var_10_5:GetComponent("SpriteRenderer")

				if var_10_6 and var_10_6.sprite then
					local var_10_7 = (var_10_5.transform.localPosition - var_10_3).z
					local var_10_8 = manager.ui.mainCameraCom_
					local var_10_9 = 2 * var_10_7 * Mathf.Tan(var_10_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_10_10 = var_10_9 * var_10_8.aspect
					local var_10_11 = var_10_6.sprite.bounds.size.x
					local var_10_12 = var_10_6.sprite.bounds.size.y
					local var_10_13 = var_10_10 / var_10_11
					local var_10_14 = var_10_9 / var_10_12
					local var_10_15 = var_10_14 < var_10_13 and var_10_13 or var_10_14

					var_10_5.transform.localScale = Vector3.New(var_10_15, var_10_15, 0)
				end

				for iter_10_0, iter_10_1 in pairs(arg_7_1.bgs_) do
					if iter_10_0 ~= "I11o" then
						iter_10_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_10_16 = 0

			if var_10_16 < arg_7_1.time_ and arg_7_1.time_ <= var_10_16 + arg_10_0 then
				arg_7_1.mask_.enabled = true
				arg_7_1.mask_.raycastTarget = true

				arg_7_1:SetGaussion(false)
			end

			local var_10_17 = 2

			if var_10_16 <= arg_7_1.time_ and arg_7_1.time_ < var_10_16 + var_10_17 then
				local var_10_18 = (arg_7_1.time_ - var_10_16) / var_10_17
				local var_10_19 = Color.New(0, 0, 0)

				var_10_19.a = Mathf.Lerp(1, 0, var_10_18)
				arg_7_1.mask_.color = var_10_19
			end

			if arg_7_1.time_ >= var_10_16 + var_10_17 and arg_7_1.time_ < var_10_16 + var_10_17 + arg_10_0 then
				local var_10_20 = Color.New(0, 0, 0)
				local var_10_21 = 0

				arg_7_1.mask_.enabled = false
				var_10_20.a = var_10_21
				arg_7_1.mask_.color = var_10_20
			end

			local var_10_22 = 0

			if var_10_22 < arg_7_1.time_ and arg_7_1.time_ <= var_10_22 + arg_10_0 then
				arg_7_1.fswbg_:SetActive(false)
				arg_7_1.dialog_:SetActive(false)
				SetActive(arg_7_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_7_1:ShowNextGo(false)
			end

			local var_10_23 = 0.1

			if var_10_23 < arg_7_1.time_ and arg_7_1.time_ <= var_10_23 + arg_10_0 then
				arg_7_1.fswbg_:SetActive(false)
				arg_7_1.dialog_:SetActive(false)
				SetActive(arg_7_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_7_1:ShowNextGo(false)
			end

			local var_10_24 = 0

			if var_10_24 < arg_7_1.time_ and arg_7_1.time_ <= var_10_24 + arg_10_0 then
				arg_7_1.cswbg_:SetActive(false)
			end

			if arg_7_1.frameCnt_ <= 1 then
				arg_7_1.dialog_:SetActive(false)
			end

			local var_10_25 = 1.86666666666667
			local var_10_26 = 0.25

			if var_10_25 < arg_7_1.time_ and arg_7_1.time_ <= var_10_25 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0

				arg_7_1.dialog_:SetActive(true)

				arg_7_1.dialogCg_.alpha = 0

				local var_10_27 = LeanTween.value(arg_7_1.dialog_, 0, 1, 0.3)

				var_10_27:setOnUpdate(LuaHelper.FloatAction(function(arg_11_0)
					arg_7_1.dialogCg_.alpha = arg_11_0
				end))
				var_10_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_7_1.dialog_)
					var_10_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_7_1.duration_ = arg_7_1.duration_ + 0.3

				SetActive(arg_7_1.leftNameGo_, true)

				local var_10_28 = arg_7_1:FormatText(StoryNameCfg[141].name)

				arg_7_1.leftNameTxt_.text = var_10_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_7_1.leftNameTxt_.transform)

				arg_7_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_7_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_7_1:RecordName(arg_7_1.leftNameTxt_.text)
				SetActive(arg_7_1.iconTrs_.gameObject, true)
				arg_7_1.iconController_:SetSelectedState("hero")

				arg_7_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officeladya")

				arg_7_1.callingController_:SetSelectedState("normal")

				arg_7_1.keyicon_.color = Color.New(1, 1, 1)
				arg_7_1.icon_.color = Color.New(1, 1, 1)

				local var_10_29 = arg_7_1:GetWordFromCfg(319851002)
				local var_10_30 = arg_7_1:FormatText(var_10_29.content)

				arg_7_1.text_.text = var_10_30

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_31 = 10
				local var_10_32 = utf8.len(var_10_30)
				local var_10_33 = var_10_31 <= 0 and var_10_26 or var_10_26 * (var_10_32 / var_10_31)

				if var_10_33 > 0 and var_10_26 < var_10_33 then
					arg_7_1.talkMaxDuration = var_10_33
					var_10_25 = var_10_25 + 0.3

					if var_10_33 + var_10_25 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_33 + var_10_25
					end
				end

				arg_7_1.text_.text = var_10_30
				arg_7_1.typewritter.percent = 0

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319851", "319851002", "story_v_out_319851.awb") ~= 0 then
					local var_10_34 = manager.audio:GetVoiceLength("story_v_out_319851", "319851002", "story_v_out_319851.awb") / 1000

					if var_10_34 + var_10_25 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_34 + var_10_25
					end

					if var_10_29.prefab_name ~= "" and arg_7_1.actors_[var_10_29.prefab_name] ~= nil then
						local var_10_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_7_1.actors_[var_10_29.prefab_name].transform, "story_v_out_319851", "319851002", "story_v_out_319851.awb")

						arg_7_1:RecordAudio("319851002", var_10_35)
						arg_7_1:RecordAudio("319851002", var_10_35)
					else
						arg_7_1:AudioAction("play", "voice", "story_v_out_319851", "319851002", "story_v_out_319851.awb")
					end

					arg_7_1:RecordHistoryTalkVoice("story_v_out_319851", "319851002", "story_v_out_319851.awb")
				end

				arg_7_1:RecordContent(arg_7_1.text_.text)
			end

			local var_10_36 = var_10_25 + 0.3
			local var_10_37 = math.max(var_10_26, arg_7_1.talkMaxDuration)

			if var_10_36 <= arg_7_1.time_ and arg_7_1.time_ < var_10_36 + var_10_37 then
				arg_7_1.typewritter.percent = (arg_7_1.time_ - var_10_36) / var_10_37

				arg_7_1.typewritter:SetDirty()
			end

			if arg_7_1.time_ >= var_10_36 + var_10_37 and arg_7_1.time_ < var_10_36 + var_10_37 + arg_10_0 then
				arg_7_1.typewritter.percent = 1

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(true)
			end
		end

		arg_7_1.nodeConfigList_ = {}

		arg_7_1:InitPlayNodeList()
	end,
	Play319851003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 319851003
		arg_13_1.duration_ = 4.23

		local var_13_0 = {
			zh = 3.1,
			ja = 4.233
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
				arg_13_0:Play319851004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0
			local var_16_1 = 0.275

			if var_16_0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_2 = arg_13_1:FormatText(StoryNameCfg[140].name)

				arg_13_1.leftNameTxt_.text = var_16_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_studentwa")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_3 = arg_13_1:GetWordFromCfg(319851003)
				local var_16_4 = arg_13_1:FormatText(var_16_3.content)

				arg_13_1.text_.text = var_16_4

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_5 = 11
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

				if manager.audio:GetVoiceLength("story_v_out_319851", "319851003", "story_v_out_319851.awb") ~= 0 then
					local var_16_8 = manager.audio:GetVoiceLength("story_v_out_319851", "319851003", "story_v_out_319851.awb") / 1000

					if var_16_8 + var_16_0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_8 + var_16_0
					end

					if var_16_3.prefab_name ~= "" and arg_13_1.actors_[var_16_3.prefab_name] ~= nil then
						local var_16_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_3.prefab_name].transform, "story_v_out_319851", "319851003", "story_v_out_319851.awb")

						arg_13_1:RecordAudio("319851003", var_16_9)
						arg_13_1:RecordAudio("319851003", var_16_9)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_319851", "319851003", "story_v_out_319851.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_319851", "319851003", "story_v_out_319851.awb")
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
	Play319851004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 319851004
		arg_17_1.duration_ = 4.27

		local var_17_0 = {
			zh = 2.9,
			ja = 4.266
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
				arg_17_0:Play319851005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0
			local var_20_1 = 0.375

			if var_20_0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_2 = arg_17_1:FormatText(StoryNameCfg[141].name)

				arg_17_1.leftNameTxt_.text = var_20_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officeladya")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_3 = arg_17_1:GetWordFromCfg(319851004)
				local var_20_4 = arg_17_1:FormatText(var_20_3.content)

				arg_17_1.text_.text = var_20_4

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_5 = 15
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

				if manager.audio:GetVoiceLength("story_v_out_319851", "319851004", "story_v_out_319851.awb") ~= 0 then
					local var_20_8 = manager.audio:GetVoiceLength("story_v_out_319851", "319851004", "story_v_out_319851.awb") / 1000

					if var_20_8 + var_20_0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_8 + var_20_0
					end

					if var_20_3.prefab_name ~= "" and arg_17_1.actors_[var_20_3.prefab_name] ~= nil then
						local var_20_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_3.prefab_name].transform, "story_v_out_319851", "319851004", "story_v_out_319851.awb")

						arg_17_1:RecordAudio("319851004", var_20_9)
						arg_17_1:RecordAudio("319851004", var_20_9)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_319851", "319851004", "story_v_out_319851.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_319851", "319851004", "story_v_out_319851.awb")
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
	Play319851005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 319851005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play319851006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0
			local var_24_1 = 1.575

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

				local var_24_2 = arg_21_1:GetWordFromCfg(319851005)
				local var_24_3 = arg_21_1:FormatText(var_24_2.content)

				arg_21_1.text_.text = var_24_3

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_4 = 63
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
	Play319851006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 319851006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play319851007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0
			local var_28_1 = 0.525

			if var_28_0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_2 = arg_25_1:GetWordFromCfg(319851006)
				local var_28_3 = arg_25_1:FormatText(var_28_2.content)

				arg_25_1.text_.text = var_28_3

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_4 = 21
				local var_28_5 = utf8.len(var_28_3)
				local var_28_6 = var_28_4 <= 0 and var_28_1 or var_28_1 * (var_28_5 / var_28_4)

				if var_28_6 > 0 and var_28_1 < var_28_6 then
					arg_25_1.talkMaxDuration = var_28_6

					if var_28_6 + var_28_0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_6 + var_28_0
					end
				end

				arg_25_1.text_.text = var_28_3
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_7 = math.max(var_28_1, arg_25_1.talkMaxDuration)

			if var_28_0 <= arg_25_1.time_ and arg_25_1.time_ < var_28_0 + var_28_7 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_0) / var_28_7

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_0 + var_28_7 and arg_25_1.time_ < var_28_0 + var_28_7 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play319851007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 319851007
		arg_29_1.duration_ = 7.53

		local var_29_0 = {
			zh = 5.93266666666667,
			ja = 7.53266666666667
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
				arg_29_0:Play319851008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = "ML0205"

			if arg_29_1.bgs_[var_32_0] == nil then
				local var_32_1 = Object.Instantiate(arg_29_1.paintGo_)

				var_32_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_32_0)
				var_32_1.name = var_32_0
				var_32_1.transform.parent = arg_29_1.stage_.transform
				var_32_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_29_1.bgs_[var_32_0] = var_32_1
			end

			local var_32_2 = 1.36666666666667

			if var_32_2 < arg_29_1.time_ and arg_29_1.time_ <= var_32_2 + arg_32_0 then
				local var_32_3 = manager.ui.mainCamera.transform.localPosition
				local var_32_4 = Vector3.New(0, 0, 10) + Vector3.New(var_32_3.x, var_32_3.y, 0)
				local var_32_5 = arg_29_1.bgs_.ML0205

				var_32_5.transform.localPosition = var_32_4
				var_32_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_32_6 = var_32_5:GetComponent("SpriteRenderer")

				if var_32_6 and var_32_6.sprite then
					local var_32_7 = (var_32_5.transform.localPosition - var_32_3).z
					local var_32_8 = manager.ui.mainCameraCom_
					local var_32_9 = 2 * var_32_7 * Mathf.Tan(var_32_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_32_10 = var_32_9 * var_32_8.aspect
					local var_32_11 = var_32_6.sprite.bounds.size.x
					local var_32_12 = var_32_6.sprite.bounds.size.y
					local var_32_13 = var_32_10 / var_32_11
					local var_32_14 = var_32_9 / var_32_12
					local var_32_15 = var_32_14 < var_32_13 and var_32_13 or var_32_14

					var_32_5.transform.localScale = Vector3.New(var_32_15, var_32_15, 0)
				end

				for iter_32_0, iter_32_1 in pairs(arg_29_1.bgs_) do
					if iter_32_0 ~= "ML0205" then
						iter_32_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_32_16 = 0

			if var_32_16 < arg_29_1.time_ and arg_29_1.time_ <= var_32_16 + arg_32_0 then
				arg_29_1.allBtn_.enabled = false
			end

			local var_32_17 = 0.3

			if arg_29_1.time_ >= var_32_16 + var_32_17 and arg_29_1.time_ < var_32_16 + var_32_17 + arg_32_0 then
				arg_29_1.allBtn_.enabled = true
			end

			local var_32_18 = 0

			if var_32_18 < arg_29_1.time_ and arg_29_1.time_ <= var_32_18 + arg_32_0 then
				arg_29_1.mask_.enabled = true
				arg_29_1.mask_.raycastTarget = true

				arg_29_1:SetGaussion(false)
			end

			local var_32_19 = 1.36666666666667

			if var_32_18 <= arg_29_1.time_ and arg_29_1.time_ < var_32_18 + var_32_19 then
				local var_32_20 = (arg_29_1.time_ - var_32_18) / var_32_19
				local var_32_21 = Color.New(0, 0, 0)

				var_32_21.a = Mathf.Lerp(0, 1, var_32_20)
				arg_29_1.mask_.color = var_32_21
			end

			if arg_29_1.time_ >= var_32_18 + var_32_19 and arg_29_1.time_ < var_32_18 + var_32_19 + arg_32_0 then
				local var_32_22 = Color.New(0, 0, 0)

				var_32_22.a = 1
				arg_29_1.mask_.color = var_32_22
			end

			local var_32_23 = 1.36666666666667

			if var_32_23 < arg_29_1.time_ and arg_29_1.time_ <= var_32_23 + arg_32_0 then
				arg_29_1.mask_.enabled = true
				arg_29_1.mask_.raycastTarget = true

				arg_29_1:SetGaussion(false)
			end

			local var_32_24 = 2

			if var_32_23 <= arg_29_1.time_ and arg_29_1.time_ < var_32_23 + var_32_24 then
				local var_32_25 = (arg_29_1.time_ - var_32_23) / var_32_24
				local var_32_26 = Color.New(0, 0, 0)

				var_32_26.a = Mathf.Lerp(1, 0, var_32_25)
				arg_29_1.mask_.color = var_32_26
			end

			if arg_29_1.time_ >= var_32_23 + var_32_24 and arg_29_1.time_ < var_32_23 + var_32_24 + arg_32_0 then
				local var_32_27 = Color.New(0, 0, 0)
				local var_32_28 = 0

				arg_29_1.mask_.enabled = false
				var_32_27.a = var_32_28
				arg_29_1.mask_.color = var_32_27
			end

			if arg_29_1.frameCnt_ <= 1 then
				arg_29_1.dialog_:SetActive(false)
			end

			local var_32_29 = 3.26666666666667
			local var_32_30 = 0.35

			if var_32_29 < arg_29_1.time_ and arg_29_1.time_ <= var_32_29 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0

				arg_29_1.dialog_:SetActive(true)

				arg_29_1.dialogCg_.alpha = 0

				local var_32_31 = LeanTween.value(arg_29_1.dialog_, 0, 1, 0.3)

				var_32_31:setOnUpdate(LuaHelper.FloatAction(function(arg_33_0)
					arg_29_1.dialogCg_.alpha = arg_33_0
				end))
				var_32_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_29_1.dialog_)
					var_32_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_29_1.duration_ = arg_29_1.duration_ + 0.3

				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_32 = arg_29_1:FormatText(StoryNameCfg[6].name)

				arg_29_1.leftNameTxt_.text = var_32_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_33 = arg_29_1:GetWordFromCfg(319851007)
				local var_32_34 = arg_29_1:FormatText(var_32_33.content)

				arg_29_1.text_.text = var_32_34

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_35 = 14
				local var_32_36 = utf8.len(var_32_34)
				local var_32_37 = var_32_35 <= 0 and var_32_30 or var_32_30 * (var_32_36 / var_32_35)

				if var_32_37 > 0 and var_32_30 < var_32_37 then
					arg_29_1.talkMaxDuration = var_32_37
					var_32_29 = var_32_29 + 0.3

					if var_32_37 + var_32_29 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_37 + var_32_29
					end
				end

				arg_29_1.text_.text = var_32_34
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319851", "319851007", "story_v_out_319851.awb") ~= 0 then
					local var_32_38 = manager.audio:GetVoiceLength("story_v_out_319851", "319851007", "story_v_out_319851.awb") / 1000

					if var_32_38 + var_32_29 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_38 + var_32_29
					end

					if var_32_33.prefab_name ~= "" and arg_29_1.actors_[var_32_33.prefab_name] ~= nil then
						local var_32_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_33.prefab_name].transform, "story_v_out_319851", "319851007", "story_v_out_319851.awb")

						arg_29_1:RecordAudio("319851007", var_32_39)
						arg_29_1:RecordAudio("319851007", var_32_39)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_319851", "319851007", "story_v_out_319851.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_319851", "319851007", "story_v_out_319851.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_40 = var_32_29 + 0.3
			local var_32_41 = math.max(var_32_30, arg_29_1.talkMaxDuration)

			if var_32_40 <= arg_29_1.time_ and arg_29_1.time_ < var_32_40 + var_32_41 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_40) / var_32_41

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_40 + var_32_41 and arg_29_1.time_ < var_32_40 + var_32_41 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play319851008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 319851008
		arg_35_1.duration_ = 4.43

		local var_35_0 = {
			zh = 2.3,
			ja = 4.433
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
				arg_35_0:Play319851009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = 0
			local var_38_1 = 0.325

			if var_38_0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_0 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				local var_38_2 = arg_35_1:FormatText(StoryNameCfg[6].name)

				arg_35_1.leftNameTxt_.text = var_38_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, true)
				arg_35_1.iconController_:SetSelectedState("hero")

				arg_35_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_35_1.callingController_:SetSelectedState("normal")

				arg_35_1.keyicon_.color = Color.New(1, 1, 1)
				arg_35_1.icon_.color = Color.New(1, 1, 1)

				local var_38_3 = arg_35_1:GetWordFromCfg(319851008)
				local var_38_4 = arg_35_1:FormatText(var_38_3.content)

				arg_35_1.text_.text = var_38_4

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_5 = 13
				local var_38_6 = utf8.len(var_38_4)
				local var_38_7 = var_38_5 <= 0 and var_38_1 or var_38_1 * (var_38_6 / var_38_5)

				if var_38_7 > 0 and var_38_1 < var_38_7 then
					arg_35_1.talkMaxDuration = var_38_7

					if var_38_7 + var_38_0 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_7 + var_38_0
					end
				end

				arg_35_1.text_.text = var_38_4
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319851", "319851008", "story_v_out_319851.awb") ~= 0 then
					local var_38_8 = manager.audio:GetVoiceLength("story_v_out_319851", "319851008", "story_v_out_319851.awb") / 1000

					if var_38_8 + var_38_0 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_8 + var_38_0
					end

					if var_38_3.prefab_name ~= "" and arg_35_1.actors_[var_38_3.prefab_name] ~= nil then
						local var_38_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_3.prefab_name].transform, "story_v_out_319851", "319851008", "story_v_out_319851.awb")

						arg_35_1:RecordAudio("319851008", var_38_9)
						arg_35_1:RecordAudio("319851008", var_38_9)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_out_319851", "319851008", "story_v_out_319851.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_out_319851", "319851008", "story_v_out_319851.awb")
				end

				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_10 = math.max(var_38_1, arg_35_1.talkMaxDuration)

			if var_38_0 <= arg_35_1.time_ and arg_35_1.time_ < var_38_0 + var_38_10 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_0) / var_38_10

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_0 + var_38_10 and arg_35_1.time_ < var_38_0 + var_38_10 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {}

		arg_35_1:InitPlayNodeList()
	end,
	Play319851009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 319851009
		arg_39_1.duration_ = 11.53

		local var_39_0 = {
			zh = 8.4,
			ja = 11.533
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
				arg_39_0:Play319851010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = 0
			local var_42_1 = 1.1

			if var_42_0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_0 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				local var_42_2 = arg_39_1:FormatText(StoryNameCfg[471].name)

				arg_39_1.leftNameTxt_.text = var_42_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, true)
				arg_39_1.iconController_:SetSelectedState("hero")

				arg_39_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10058")

				arg_39_1.callingController_:SetSelectedState("normal")

				arg_39_1.keyicon_.color = Color.New(1, 1, 1)
				arg_39_1.icon_.color = Color.New(1, 1, 1)

				local var_42_3 = arg_39_1:GetWordFromCfg(319851009)
				local var_42_4 = arg_39_1:FormatText(var_42_3.content)

				arg_39_1.text_.text = var_42_4

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_5 = 44
				local var_42_6 = utf8.len(var_42_4)
				local var_42_7 = var_42_5 <= 0 and var_42_1 or var_42_1 * (var_42_6 / var_42_5)

				if var_42_7 > 0 and var_42_1 < var_42_7 then
					arg_39_1.talkMaxDuration = var_42_7

					if var_42_7 + var_42_0 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_7 + var_42_0
					end
				end

				arg_39_1.text_.text = var_42_4
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319851", "319851009", "story_v_out_319851.awb") ~= 0 then
					local var_42_8 = manager.audio:GetVoiceLength("story_v_out_319851", "319851009", "story_v_out_319851.awb") / 1000

					if var_42_8 + var_42_0 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_8 + var_42_0
					end

					if var_42_3.prefab_name ~= "" and arg_39_1.actors_[var_42_3.prefab_name] ~= nil then
						local var_42_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_3.prefab_name].transform, "story_v_out_319851", "319851009", "story_v_out_319851.awb")

						arg_39_1:RecordAudio("319851009", var_42_9)
						arg_39_1:RecordAudio("319851009", var_42_9)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_out_319851", "319851009", "story_v_out_319851.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_out_319851", "319851009", "story_v_out_319851.awb")
				end

				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_10 = math.max(var_42_1, arg_39_1.talkMaxDuration)

			if var_42_0 <= arg_39_1.time_ and arg_39_1.time_ < var_42_0 + var_42_10 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_0) / var_42_10

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_0 + var_42_10 and arg_39_1.time_ < var_42_0 + var_42_10 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play319851010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 319851010
		arg_43_1.duration_ = 8.7

		local var_43_0 = {
			zh = 4.133,
			ja = 8.7
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
				arg_43_0:Play319851011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = 0
			local var_46_1 = 0.625

			if var_46_0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_0 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				local var_46_2 = arg_43_1:FormatText(StoryNameCfg[471].name)

				arg_43_1.leftNameTxt_.text = var_46_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, true)
				arg_43_1.iconController_:SetSelectedState("hero")

				arg_43_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10058")

				arg_43_1.callingController_:SetSelectedState("normal")

				arg_43_1.keyicon_.color = Color.New(1, 1, 1)
				arg_43_1.icon_.color = Color.New(1, 1, 1)

				local var_46_3 = arg_43_1:GetWordFromCfg(319851010)
				local var_46_4 = arg_43_1:FormatText(var_46_3.content)

				arg_43_1.text_.text = var_46_4

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_5 = 25
				local var_46_6 = utf8.len(var_46_4)
				local var_46_7 = var_46_5 <= 0 and var_46_1 or var_46_1 * (var_46_6 / var_46_5)

				if var_46_7 > 0 and var_46_1 < var_46_7 then
					arg_43_1.talkMaxDuration = var_46_7

					if var_46_7 + var_46_0 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_7 + var_46_0
					end
				end

				arg_43_1.text_.text = var_46_4
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319851", "319851010", "story_v_out_319851.awb") ~= 0 then
					local var_46_8 = manager.audio:GetVoiceLength("story_v_out_319851", "319851010", "story_v_out_319851.awb") / 1000

					if var_46_8 + var_46_0 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_8 + var_46_0
					end

					if var_46_3.prefab_name ~= "" and arg_43_1.actors_[var_46_3.prefab_name] ~= nil then
						local var_46_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_3.prefab_name].transform, "story_v_out_319851", "319851010", "story_v_out_319851.awb")

						arg_43_1:RecordAudio("319851010", var_46_9)
						arg_43_1:RecordAudio("319851010", var_46_9)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_319851", "319851010", "story_v_out_319851.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_319851", "319851010", "story_v_out_319851.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_10 = math.max(var_46_1, arg_43_1.talkMaxDuration)

			if var_46_0 <= arg_43_1.time_ and arg_43_1.time_ < var_46_0 + var_46_10 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_0) / var_46_10

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_0 + var_46_10 and arg_43_1.time_ < var_46_0 + var_46_10 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play319851011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 319851011
		arg_47_1.duration_ = 7.5

		local var_47_0 = {
			zh = 2.833,
			ja = 7.5
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
				arg_47_0:Play319851012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = 0
			local var_50_1 = 0.325

			if var_50_0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_0 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				local var_50_2 = arg_47_1:FormatText(StoryNameCfg[6].name)

				arg_47_1.leftNameTxt_.text = var_50_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, true)
				arg_47_1.iconController_:SetSelectedState("hero")

				arg_47_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_47_1.callingController_:SetSelectedState("normal")

				arg_47_1.keyicon_.color = Color.New(1, 1, 1)
				arg_47_1.icon_.color = Color.New(1, 1, 1)

				local var_50_3 = arg_47_1:GetWordFromCfg(319851011)
				local var_50_4 = arg_47_1:FormatText(var_50_3.content)

				arg_47_1.text_.text = var_50_4

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_5 = 13
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

				if manager.audio:GetVoiceLength("story_v_out_319851", "319851011", "story_v_out_319851.awb") ~= 0 then
					local var_50_8 = manager.audio:GetVoiceLength("story_v_out_319851", "319851011", "story_v_out_319851.awb") / 1000

					if var_50_8 + var_50_0 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_8 + var_50_0
					end

					if var_50_3.prefab_name ~= "" and arg_47_1.actors_[var_50_3.prefab_name] ~= nil then
						local var_50_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_3.prefab_name].transform, "story_v_out_319851", "319851011", "story_v_out_319851.awb")

						arg_47_1:RecordAudio("319851011", var_50_9)
						arg_47_1:RecordAudio("319851011", var_50_9)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_319851", "319851011", "story_v_out_319851.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_319851", "319851011", "story_v_out_319851.awb")
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
	Play319851012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 319851012
		arg_51_1.duration_ = 7.93

		local var_51_0 = {
			zh = 7.933,
			ja = 7.5
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
				arg_51_0:Play319851013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = 0
			local var_54_1 = 1

			if var_54_0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_0 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				local var_54_2 = arg_51_1:FormatText(StoryNameCfg[471].name)

				arg_51_1.leftNameTxt_.text = var_54_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, true)
				arg_51_1.iconController_:SetSelectedState("hero")

				arg_51_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10058")

				arg_51_1.callingController_:SetSelectedState("normal")

				arg_51_1.keyicon_.color = Color.New(1, 1, 1)
				arg_51_1.icon_.color = Color.New(1, 1, 1)

				local var_54_3 = arg_51_1:GetWordFromCfg(319851012)
				local var_54_4 = arg_51_1:FormatText(var_54_3.content)

				arg_51_1.text_.text = var_54_4

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_5 = 40
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

				if manager.audio:GetVoiceLength("story_v_out_319851", "319851012", "story_v_out_319851.awb") ~= 0 then
					local var_54_8 = manager.audio:GetVoiceLength("story_v_out_319851", "319851012", "story_v_out_319851.awb") / 1000

					if var_54_8 + var_54_0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_8 + var_54_0
					end

					if var_54_3.prefab_name ~= "" and arg_51_1.actors_[var_54_3.prefab_name] ~= nil then
						local var_54_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_3.prefab_name].transform, "story_v_out_319851", "319851012", "story_v_out_319851.awb")

						arg_51_1:RecordAudio("319851012", var_54_9)
						arg_51_1:RecordAudio("319851012", var_54_9)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_319851", "319851012", "story_v_out_319851.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_319851", "319851012", "story_v_out_319851.awb")
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
	Play319851013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 319851013
		arg_55_1.duration_ = 5.8

		local var_55_0 = {
			zh = 3.733,
			ja = 5.8
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
				arg_55_0:Play319851014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = 0
			local var_58_1 = 0.425

			if var_58_0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_0 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				local var_58_2 = arg_55_1:FormatText(StoryNameCfg[471].name)

				arg_55_1.leftNameTxt_.text = var_58_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, true)
				arg_55_1.iconController_:SetSelectedState("hero")

				arg_55_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10058")

				arg_55_1.callingController_:SetSelectedState("normal")

				arg_55_1.keyicon_.color = Color.New(1, 1, 1)
				arg_55_1.icon_.color = Color.New(1, 1, 1)

				local var_58_3 = arg_55_1:GetWordFromCfg(319851013)
				local var_58_4 = arg_55_1:FormatText(var_58_3.content)

				arg_55_1.text_.text = var_58_4

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_5 = 17
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

				if manager.audio:GetVoiceLength("story_v_out_319851", "319851013", "story_v_out_319851.awb") ~= 0 then
					local var_58_8 = manager.audio:GetVoiceLength("story_v_out_319851", "319851013", "story_v_out_319851.awb") / 1000

					if var_58_8 + var_58_0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_8 + var_58_0
					end

					if var_58_3.prefab_name ~= "" and arg_55_1.actors_[var_58_3.prefab_name] ~= nil then
						local var_58_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_3.prefab_name].transform, "story_v_out_319851", "319851013", "story_v_out_319851.awb")

						arg_55_1:RecordAudio("319851013", var_58_9)
						arg_55_1:RecordAudio("319851013", var_58_9)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_319851", "319851013", "story_v_out_319851.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_319851", "319851013", "story_v_out_319851.awb")
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
	Play319851014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 319851014
		arg_59_1.duration_ = 9.9

		local var_59_0 = {
			zh = 7.6,
			ja = 9.9
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
				arg_59_0:Play319851015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = 0
			local var_62_1 = 0.875

			if var_62_0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_0 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				local var_62_2 = arg_59_1:FormatText(StoryNameCfg[6].name)

				arg_59_1.leftNameTxt_.text = var_62_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, true)
				arg_59_1.iconController_:SetSelectedState("hero")

				arg_59_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_59_1.callingController_:SetSelectedState("normal")

				arg_59_1.keyicon_.color = Color.New(1, 1, 1)
				arg_59_1.icon_.color = Color.New(1, 1, 1)

				local var_62_3 = arg_59_1:GetWordFromCfg(319851014)
				local var_62_4 = arg_59_1:FormatText(var_62_3.content)

				arg_59_1.text_.text = var_62_4

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_5 = 35
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

				if manager.audio:GetVoiceLength("story_v_out_319851", "319851014", "story_v_out_319851.awb") ~= 0 then
					local var_62_8 = manager.audio:GetVoiceLength("story_v_out_319851", "319851014", "story_v_out_319851.awb") / 1000

					if var_62_8 + var_62_0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_8 + var_62_0
					end

					if var_62_3.prefab_name ~= "" and arg_59_1.actors_[var_62_3.prefab_name] ~= nil then
						local var_62_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_3.prefab_name].transform, "story_v_out_319851", "319851014", "story_v_out_319851.awb")

						arg_59_1:RecordAudio("319851014", var_62_9)
						arg_59_1:RecordAudio("319851014", var_62_9)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_319851", "319851014", "story_v_out_319851.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_319851", "319851014", "story_v_out_319851.awb")
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
	Play319851015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 319851015
		arg_63_1.duration_ = 2.57

		local var_63_0 = {
			zh = 1.966,
			ja = 2.566
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
				arg_63_0:Play319851016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = 0
			local var_66_1 = 0.25

			if var_66_0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_0 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				local var_66_2 = arg_63_1:FormatText(StoryNameCfg[471].name)

				arg_63_1.leftNameTxt_.text = var_66_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, true)
				arg_63_1.iconController_:SetSelectedState("hero")

				arg_63_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10058")

				arg_63_1.callingController_:SetSelectedState("normal")

				arg_63_1.keyicon_.color = Color.New(1, 1, 1)
				arg_63_1.icon_.color = Color.New(1, 1, 1)

				local var_66_3 = arg_63_1:GetWordFromCfg(319851015)
				local var_66_4 = arg_63_1:FormatText(var_66_3.content)

				arg_63_1.text_.text = var_66_4

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_5 = 10
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

				if manager.audio:GetVoiceLength("story_v_out_319851", "319851015", "story_v_out_319851.awb") ~= 0 then
					local var_66_8 = manager.audio:GetVoiceLength("story_v_out_319851", "319851015", "story_v_out_319851.awb") / 1000

					if var_66_8 + var_66_0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_8 + var_66_0
					end

					if var_66_3.prefab_name ~= "" and arg_63_1.actors_[var_66_3.prefab_name] ~= nil then
						local var_66_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_3.prefab_name].transform, "story_v_out_319851", "319851015", "story_v_out_319851.awb")

						arg_63_1:RecordAudio("319851015", var_66_9)
						arg_63_1:RecordAudio("319851015", var_66_9)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_319851", "319851015", "story_v_out_319851.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_319851", "319851015", "story_v_out_319851.awb")
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
	Play319851016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 319851016
		arg_67_1.duration_ = 8.23

		local var_67_0 = {
			zh = 4.833,
			ja = 8.233
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
				arg_67_0:Play319851017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 0
			local var_70_1 = 0.625

			if var_70_0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_0 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				local var_70_2 = arg_67_1:FormatText(StoryNameCfg[471].name)

				arg_67_1.leftNameTxt_.text = var_70_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, true)
				arg_67_1.iconController_:SetSelectedState("hero")

				arg_67_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10058")

				arg_67_1.callingController_:SetSelectedState("normal")

				arg_67_1.keyicon_.color = Color.New(1, 1, 1)
				arg_67_1.icon_.color = Color.New(1, 1, 1)

				local var_70_3 = arg_67_1:GetWordFromCfg(319851016)
				local var_70_4 = arg_67_1:FormatText(var_70_3.content)

				arg_67_1.text_.text = var_70_4

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_5 = 25
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

				if manager.audio:GetVoiceLength("story_v_out_319851", "319851016", "story_v_out_319851.awb") ~= 0 then
					local var_70_8 = manager.audio:GetVoiceLength("story_v_out_319851", "319851016", "story_v_out_319851.awb") / 1000

					if var_70_8 + var_70_0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_8 + var_70_0
					end

					if var_70_3.prefab_name ~= "" and arg_67_1.actors_[var_70_3.prefab_name] ~= nil then
						local var_70_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_3.prefab_name].transform, "story_v_out_319851", "319851016", "story_v_out_319851.awb")

						arg_67_1:RecordAudio("319851016", var_70_9)
						arg_67_1:RecordAudio("319851016", var_70_9)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_319851", "319851016", "story_v_out_319851.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_319851", "319851016", "story_v_out_319851.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_10 = math.max(var_70_1, arg_67_1.talkMaxDuration)

			if var_70_0 <= arg_67_1.time_ and arg_67_1.time_ < var_70_0 + var_70_10 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_0) / var_70_10

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_0 + var_70_10 and arg_67_1.time_ < var_70_0 + var_70_10 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play319851017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 319851017
		arg_71_1.duration_ = 8.23

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play319851018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = 2

			if var_74_0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_0 + arg_74_0 then
				local var_74_1 = manager.ui.mainCamera.transform.localPosition
				local var_74_2 = Vector3.New(0, 0, 10) + Vector3.New(var_74_1.x, var_74_1.y, 0)
				local var_74_3 = arg_71_1.bgs_.I11o

				var_74_3.transform.localPosition = var_74_2
				var_74_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_74_4 = var_74_3:GetComponent("SpriteRenderer")

				if var_74_4 and var_74_4.sprite then
					local var_74_5 = (var_74_3.transform.localPosition - var_74_1).z
					local var_74_6 = manager.ui.mainCameraCom_
					local var_74_7 = 2 * var_74_5 * Mathf.Tan(var_74_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_74_8 = var_74_7 * var_74_6.aspect
					local var_74_9 = var_74_4.sprite.bounds.size.x
					local var_74_10 = var_74_4.sprite.bounds.size.y
					local var_74_11 = var_74_8 / var_74_9
					local var_74_12 = var_74_7 / var_74_10
					local var_74_13 = var_74_12 < var_74_11 and var_74_11 or var_74_12

					var_74_3.transform.localScale = Vector3.New(var_74_13, var_74_13, 0)
				end

				for iter_74_0, iter_74_1 in pairs(arg_71_1.bgs_) do
					if iter_74_0 ~= "I11o" then
						iter_74_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_74_14 = 0

			if var_74_14 < arg_71_1.time_ and arg_71_1.time_ <= var_74_14 + arg_74_0 then
				arg_71_1.allBtn_.enabled = false
			end

			local var_74_15 = 0.3

			if arg_71_1.time_ >= var_74_14 + var_74_15 and arg_71_1.time_ < var_74_14 + var_74_15 + arg_74_0 then
				arg_71_1.allBtn_.enabled = true
			end

			local var_74_16 = 0

			if var_74_16 < arg_71_1.time_ and arg_71_1.time_ <= var_74_16 + arg_74_0 then
				arg_71_1.mask_.enabled = true
				arg_71_1.mask_.raycastTarget = true

				arg_71_1:SetGaussion(false)
			end

			local var_74_17 = 2

			if var_74_16 <= arg_71_1.time_ and arg_71_1.time_ < var_74_16 + var_74_17 then
				local var_74_18 = (arg_71_1.time_ - var_74_16) / var_74_17
				local var_74_19 = Color.New(0, 0, 0)

				var_74_19.a = Mathf.Lerp(0, 1, var_74_18)
				arg_71_1.mask_.color = var_74_19
			end

			if arg_71_1.time_ >= var_74_16 + var_74_17 and arg_71_1.time_ < var_74_16 + var_74_17 + arg_74_0 then
				local var_74_20 = Color.New(0, 0, 0)

				var_74_20.a = 1
				arg_71_1.mask_.color = var_74_20
			end

			local var_74_21 = 2

			if var_74_21 < arg_71_1.time_ and arg_71_1.time_ <= var_74_21 + arg_74_0 then
				arg_71_1.mask_.enabled = true
				arg_71_1.mask_.raycastTarget = true

				arg_71_1:SetGaussion(false)
			end

			local var_74_22 = 1.33333333333333

			if var_74_21 <= arg_71_1.time_ and arg_71_1.time_ < var_74_21 + var_74_22 then
				local var_74_23 = (arg_71_1.time_ - var_74_21) / var_74_22
				local var_74_24 = Color.New(0, 0, 0)

				var_74_24.a = Mathf.Lerp(1, 0, var_74_23)
				arg_71_1.mask_.color = var_74_24
			end

			if arg_71_1.time_ >= var_74_21 + var_74_22 and arg_71_1.time_ < var_74_21 + var_74_22 + arg_74_0 then
				local var_74_25 = Color.New(0, 0, 0)
				local var_74_26 = 0

				arg_71_1.mask_.enabled = false
				var_74_25.a = var_74_26
				arg_71_1.mask_.color = var_74_25
			end

			if arg_71_1.frameCnt_ <= 1 then
				arg_71_1.dialog_:SetActive(false)
			end

			local var_74_27 = 3.23333333333333
			local var_74_28 = 0.65

			if var_74_27 < arg_71_1.time_ and arg_71_1.time_ <= var_74_27 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0

				arg_71_1.dialog_:SetActive(true)

				arg_71_1.dialogCg_.alpha = 0

				local var_74_29 = LeanTween.value(arg_71_1.dialog_, 0, 1, 0.3)

				var_74_29:setOnUpdate(LuaHelper.FloatAction(function(arg_75_0)
					arg_71_1.dialogCg_.alpha = arg_75_0
				end))
				var_74_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_71_1.dialog_)
					var_74_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_71_1.duration_ = arg_71_1.duration_ + 0.3

				SetActive(arg_71_1.leftNameGo_, false)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_30 = arg_71_1:GetWordFromCfg(319851017)
				local var_74_31 = arg_71_1:FormatText(var_74_30.content)

				arg_71_1.text_.text = var_74_31

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_32 = 26
				local var_74_33 = utf8.len(var_74_31)
				local var_74_34 = var_74_32 <= 0 and var_74_28 or var_74_28 * (var_74_33 / var_74_32)

				if var_74_34 > 0 and var_74_28 < var_74_34 then
					arg_71_1.talkMaxDuration = var_74_34
					var_74_27 = var_74_27 + 0.3

					if var_74_34 + var_74_27 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_34 + var_74_27
					end
				end

				arg_71_1.text_.text = var_74_31
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)
				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_35 = var_74_27 + 0.3
			local var_74_36 = math.max(var_74_28, arg_71_1.talkMaxDuration)

			if var_74_35 <= arg_71_1.time_ and arg_71_1.time_ < var_74_35 + var_74_36 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_35) / var_74_36

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_35 + var_74_36 and arg_71_1.time_ < var_74_35 + var_74_36 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play319851018 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 319851018
		arg_77_1.duration_ = 6.3

		local var_77_0 = {
			zh = 5.3,
			ja = 6.3
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
				arg_77_0:Play319851019(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = "1084ui_story"

			if arg_77_1.actors_[var_80_0] == nil then
				local var_80_1 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_80_1) then
					local var_80_2 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_77_1.stage_.transform)

					var_80_2.name = var_80_0
					var_80_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_77_1.actors_[var_80_0] = var_80_2

					local var_80_3 = var_80_2:GetComponentInChildren(typeof(CharacterEffect))

					var_80_3.enabled = true

					local var_80_4 = GameObjectTools.GetOrAddComponent(var_80_2, typeof(DynamicBoneHelper))

					if var_80_4 then
						var_80_4:EnableDynamicBone(false)
					end

					arg_77_1:ShowWeapon(var_80_3.transform, false)

					arg_77_1.var_[var_80_0 .. "Animator"] = var_80_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_77_1.var_[var_80_0 .. "Animator"].applyRootMotion = true
					arg_77_1.var_[var_80_0 .. "LipSync"] = var_80_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_80_5 = arg_77_1.actors_["1084ui_story"].transform
			local var_80_6 = 0

			if var_80_6 < arg_77_1.time_ and arg_77_1.time_ <= var_80_6 + arg_80_0 then
				arg_77_1.var_.moveOldPos1084ui_story = var_80_5.localPosition

				local var_80_7 = "1084ui_story"

				arg_77_1:ShowWeapon(arg_77_1.var_[var_80_7 .. "Animator"].transform, false)
			end

			local var_80_8 = 0.001

			if var_80_6 <= arg_77_1.time_ and arg_77_1.time_ < var_80_6 + var_80_8 then
				local var_80_9 = (arg_77_1.time_ - var_80_6) / var_80_8
				local var_80_10 = Vector3.New(0, -0.97, -6)

				var_80_5.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1084ui_story, var_80_10, var_80_9)

				local var_80_11 = manager.ui.mainCamera.transform.position - var_80_5.position

				var_80_5.forward = Vector3.New(var_80_11.x, var_80_11.y, var_80_11.z)

				local var_80_12 = var_80_5.localEulerAngles

				var_80_12.z = 0
				var_80_12.x = 0
				var_80_5.localEulerAngles = var_80_12
			end

			if arg_77_1.time_ >= var_80_6 + var_80_8 and arg_77_1.time_ < var_80_6 + var_80_8 + arg_80_0 then
				var_80_5.localPosition = Vector3.New(0, -0.97, -6)

				local var_80_13 = manager.ui.mainCamera.transform.position - var_80_5.position

				var_80_5.forward = Vector3.New(var_80_13.x, var_80_13.y, var_80_13.z)

				local var_80_14 = var_80_5.localEulerAngles

				var_80_14.z = 0
				var_80_14.x = 0
				var_80_5.localEulerAngles = var_80_14
			end

			local var_80_15 = arg_77_1.actors_["1084ui_story"]
			local var_80_16 = 0

			if var_80_16 < arg_77_1.time_ and arg_77_1.time_ <= var_80_16 + arg_80_0 and not isNil(var_80_15) and arg_77_1.var_.characterEffect1084ui_story == nil then
				arg_77_1.var_.characterEffect1084ui_story = var_80_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_17 = 0.200000002980232

			if var_80_16 <= arg_77_1.time_ and arg_77_1.time_ < var_80_16 + var_80_17 and not isNil(var_80_15) then
				local var_80_18 = (arg_77_1.time_ - var_80_16) / var_80_17

				if arg_77_1.var_.characterEffect1084ui_story and not isNil(var_80_15) then
					arg_77_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= var_80_16 + var_80_17 and arg_77_1.time_ < var_80_16 + var_80_17 + arg_80_0 and not isNil(var_80_15) and arg_77_1.var_.characterEffect1084ui_story then
				arg_77_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_80_19 = 0

			if var_80_19 < arg_77_1.time_ and arg_77_1.time_ <= var_80_19 + arg_80_0 then
				arg_77_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_80_20 = 0

			if var_80_20 < arg_77_1.time_ and arg_77_1.time_ <= var_80_20 + arg_80_0 then
				arg_77_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_80_21 = 0
			local var_80_22 = 0.65

			if var_80_21 < arg_77_1.time_ and arg_77_1.time_ <= var_80_21 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_23 = arg_77_1:FormatText(StoryNameCfg[6].name)

				arg_77_1.leftNameTxt_.text = var_80_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_24 = arg_77_1:GetWordFromCfg(319851018)
				local var_80_25 = arg_77_1:FormatText(var_80_24.content)

				arg_77_1.text_.text = var_80_25

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_26 = 26
				local var_80_27 = utf8.len(var_80_25)
				local var_80_28 = var_80_26 <= 0 and var_80_22 or var_80_22 * (var_80_27 / var_80_26)

				if var_80_28 > 0 and var_80_22 < var_80_28 then
					arg_77_1.talkMaxDuration = var_80_28

					if var_80_28 + var_80_21 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_28 + var_80_21
					end
				end

				arg_77_1.text_.text = var_80_25
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319851", "319851018", "story_v_out_319851.awb") ~= 0 then
					local var_80_29 = manager.audio:GetVoiceLength("story_v_out_319851", "319851018", "story_v_out_319851.awb") / 1000

					if var_80_29 + var_80_21 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_29 + var_80_21
					end

					if var_80_24.prefab_name ~= "" and arg_77_1.actors_[var_80_24.prefab_name] ~= nil then
						local var_80_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_24.prefab_name].transform, "story_v_out_319851", "319851018", "story_v_out_319851.awb")

						arg_77_1:RecordAudio("319851018", var_80_30)
						arg_77_1:RecordAudio("319851018", var_80_30)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_319851", "319851018", "story_v_out_319851.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_319851", "319851018", "story_v_out_319851.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_31 = math.max(var_80_22, arg_77_1.talkMaxDuration)

			if var_80_21 <= arg_77_1.time_ and arg_77_1.time_ < var_80_21 + var_80_31 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_21) / var_80_31

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_21 + var_80_31 and arg_77_1.time_ < var_80_21 + var_80_31 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
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

		arg_77_1:InitPlayNodeList()
	end,
	Play319851019 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 319851019
		arg_81_1.duration_ = 6.7

		local var_81_0 = {
			zh = 4,
			ja = 6.7
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
				arg_81_0:Play319851020(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = "10058ui_story"

			if arg_81_1.actors_[var_84_0] == nil then
				local var_84_1 = Asset.Load("Char/" .. "10058ui_story")

				if not isNil(var_84_1) then
					local var_84_2 = Object.Instantiate(Asset.Load("Char/" .. "10058ui_story"), arg_81_1.stage_.transform)

					var_84_2.name = var_84_0
					var_84_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_81_1.actors_[var_84_0] = var_84_2

					local var_84_3 = var_84_2:GetComponentInChildren(typeof(CharacterEffect))

					var_84_3.enabled = true

					local var_84_4 = GameObjectTools.GetOrAddComponent(var_84_2, typeof(DynamicBoneHelper))

					if var_84_4 then
						var_84_4:EnableDynamicBone(false)
					end

					arg_81_1:ShowWeapon(var_84_3.transform, false)

					arg_81_1.var_[var_84_0 .. "Animator"] = var_84_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_81_1.var_[var_84_0 .. "Animator"].applyRootMotion = true
					arg_81_1.var_[var_84_0 .. "LipSync"] = var_84_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_84_5 = arg_81_1.actors_["10058ui_story"].transform
			local var_84_6 = 0

			if var_84_6 < arg_81_1.time_ and arg_81_1.time_ <= var_84_6 + arg_84_0 then
				arg_81_1.var_.moveOldPos10058ui_story = var_84_5.localPosition
			end

			local var_84_7 = 0.001

			if var_84_6 <= arg_81_1.time_ and arg_81_1.time_ < var_84_6 + var_84_7 then
				local var_84_8 = (arg_81_1.time_ - var_84_6) / var_84_7
				local var_84_9 = Vector3.New(0.7, -0.98, -6.1)

				var_84_5.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos10058ui_story, var_84_9, var_84_8)

				local var_84_10 = manager.ui.mainCamera.transform.position - var_84_5.position

				var_84_5.forward = Vector3.New(var_84_10.x, var_84_10.y, var_84_10.z)

				local var_84_11 = var_84_5.localEulerAngles

				var_84_11.z = 0
				var_84_11.x = 0
				var_84_5.localEulerAngles = var_84_11
			end

			if arg_81_1.time_ >= var_84_6 + var_84_7 and arg_81_1.time_ < var_84_6 + var_84_7 + arg_84_0 then
				var_84_5.localPosition = Vector3.New(0.7, -0.98, -6.1)

				local var_84_12 = manager.ui.mainCamera.transform.position - var_84_5.position

				var_84_5.forward = Vector3.New(var_84_12.x, var_84_12.y, var_84_12.z)

				local var_84_13 = var_84_5.localEulerAngles

				var_84_13.z = 0
				var_84_13.x = 0
				var_84_5.localEulerAngles = var_84_13
			end

			local var_84_14 = arg_81_1.actors_["10058ui_story"]
			local var_84_15 = 0

			if var_84_15 < arg_81_1.time_ and arg_81_1.time_ <= var_84_15 + arg_84_0 and not isNil(var_84_14) and arg_81_1.var_.characterEffect10058ui_story == nil then
				arg_81_1.var_.characterEffect10058ui_story = var_84_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_16 = 0.200000002980232

			if var_84_15 <= arg_81_1.time_ and arg_81_1.time_ < var_84_15 + var_84_16 and not isNil(var_84_14) then
				local var_84_17 = (arg_81_1.time_ - var_84_15) / var_84_16

				if arg_81_1.var_.characterEffect10058ui_story and not isNil(var_84_14) then
					arg_81_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= var_84_15 + var_84_16 and arg_81_1.time_ < var_84_15 + var_84_16 + arg_84_0 and not isNil(var_84_14) and arg_81_1.var_.characterEffect10058ui_story then
				arg_81_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_84_18 = 0

			if var_84_18 < arg_81_1.time_ and arg_81_1.time_ <= var_84_18 + arg_84_0 then
				arg_81_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action3_1")
			end

			local var_84_19 = 0

			if var_84_19 < arg_81_1.time_ and arg_81_1.time_ <= var_84_19 + arg_84_0 then
				arg_81_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_84_20 = arg_81_1.actors_["1084ui_story"].transform
			local var_84_21 = 0

			if var_84_21 < arg_81_1.time_ and arg_81_1.time_ <= var_84_21 + arg_84_0 then
				arg_81_1.var_.moveOldPos1084ui_story = var_84_20.localPosition
			end

			local var_84_22 = 0.001

			if var_84_21 <= arg_81_1.time_ and arg_81_1.time_ < var_84_21 + var_84_22 then
				local var_84_23 = (arg_81_1.time_ - var_84_21) / var_84_22
				local var_84_24 = Vector3.New(-0.7, -0.97, -6)

				var_84_20.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1084ui_story, var_84_24, var_84_23)

				local var_84_25 = manager.ui.mainCamera.transform.position - var_84_20.position

				var_84_20.forward = Vector3.New(var_84_25.x, var_84_25.y, var_84_25.z)

				local var_84_26 = var_84_20.localEulerAngles

				var_84_26.z = 0
				var_84_26.x = 0
				var_84_20.localEulerAngles = var_84_26
			end

			if arg_81_1.time_ >= var_84_21 + var_84_22 and arg_81_1.time_ < var_84_21 + var_84_22 + arg_84_0 then
				var_84_20.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_84_27 = manager.ui.mainCamera.transform.position - var_84_20.position

				var_84_20.forward = Vector3.New(var_84_27.x, var_84_27.y, var_84_27.z)

				local var_84_28 = var_84_20.localEulerAngles

				var_84_28.z = 0
				var_84_28.x = 0
				var_84_20.localEulerAngles = var_84_28
			end

			local var_84_29 = arg_81_1.actors_["1084ui_story"]
			local var_84_30 = 0

			if var_84_30 < arg_81_1.time_ and arg_81_1.time_ <= var_84_30 + arg_84_0 and not isNil(var_84_29) and arg_81_1.var_.characterEffect1084ui_story == nil then
				arg_81_1.var_.characterEffect1084ui_story = var_84_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_31 = 0.200000002980232

			if var_84_30 <= arg_81_1.time_ and arg_81_1.time_ < var_84_30 + var_84_31 and not isNil(var_84_29) then
				local var_84_32 = (arg_81_1.time_ - var_84_30) / var_84_31

				if arg_81_1.var_.characterEffect1084ui_story and not isNil(var_84_29) then
					local var_84_33 = Mathf.Lerp(0, 0.5, var_84_32)

					arg_81_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_81_1.var_.characterEffect1084ui_story.fillRatio = var_84_33
				end
			end

			if arg_81_1.time_ >= var_84_30 + var_84_31 and arg_81_1.time_ < var_84_30 + var_84_31 + arg_84_0 and not isNil(var_84_29) and arg_81_1.var_.characterEffect1084ui_story then
				local var_84_34 = 0.5

				arg_81_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_81_1.var_.characterEffect1084ui_story.fillRatio = var_84_34
			end

			local var_84_35 = 0
			local var_84_36 = 0.6

			if var_84_35 < arg_81_1.time_ and arg_81_1.time_ <= var_84_35 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_37 = arg_81_1:FormatText(StoryNameCfg[471].name)

				arg_81_1.leftNameTxt_.text = var_84_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_38 = arg_81_1:GetWordFromCfg(319851019)
				local var_84_39 = arg_81_1:FormatText(var_84_38.content)

				arg_81_1.text_.text = var_84_39

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_40 = 24
				local var_84_41 = utf8.len(var_84_39)
				local var_84_42 = var_84_40 <= 0 and var_84_36 or var_84_36 * (var_84_41 / var_84_40)

				if var_84_42 > 0 and var_84_36 < var_84_42 then
					arg_81_1.talkMaxDuration = var_84_42

					if var_84_42 + var_84_35 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_42 + var_84_35
					end
				end

				arg_81_1.text_.text = var_84_39
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319851", "319851019", "story_v_out_319851.awb") ~= 0 then
					local var_84_43 = manager.audio:GetVoiceLength("story_v_out_319851", "319851019", "story_v_out_319851.awb") / 1000

					if var_84_43 + var_84_35 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_43 + var_84_35
					end

					if var_84_38.prefab_name ~= "" and arg_81_1.actors_[var_84_38.prefab_name] ~= nil then
						local var_84_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_38.prefab_name].transform, "story_v_out_319851", "319851019", "story_v_out_319851.awb")

						arg_81_1:RecordAudio("319851019", var_84_44)
						arg_81_1:RecordAudio("319851019", var_84_44)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_319851", "319851019", "story_v_out_319851.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_319851", "319851019", "story_v_out_319851.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_45 = math.max(var_84_36, arg_81_1.talkMaxDuration)

			if var_84_35 <= arg_81_1.time_ and arg_81_1.time_ < var_84_35 + var_84_45 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_35) / var_84_45

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_35 + var_84_45 and arg_81_1.time_ < var_84_35 + var_84_45 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
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

		arg_81_1:InitPlayNodeList()
	end,
	Play319851020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 319851020
		arg_85_1.duration_ = 8.5

		local var_85_0 = {
			zh = 8.5,
			ja = 8.366
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
				arg_85_0:Play319851021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["10058ui_story"]
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.characterEffect10058ui_story == nil then
				arg_85_1.var_.characterEffect10058ui_story = var_88_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_2 = 0.200000002980232

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_2 and not isNil(var_88_0) then
				local var_88_3 = (arg_85_1.time_ - var_88_1) / var_88_2

				if arg_85_1.var_.characterEffect10058ui_story and not isNil(var_88_0) then
					local var_88_4 = Mathf.Lerp(0, 0.5, var_88_3)

					arg_85_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_85_1.var_.characterEffect10058ui_story.fillRatio = var_88_4
				end
			end

			if arg_85_1.time_ >= var_88_1 + var_88_2 and arg_85_1.time_ < var_88_1 + var_88_2 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.characterEffect10058ui_story then
				local var_88_5 = 0.5

				arg_85_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_85_1.var_.characterEffect10058ui_story.fillRatio = var_88_5
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
			local var_88_11 = 1.075

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

				local var_88_13 = arg_85_1:GetWordFromCfg(319851020)
				local var_88_14 = arg_85_1:FormatText(var_88_13.content)

				arg_85_1.text_.text = var_88_14

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_15 = 43
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

				if manager.audio:GetVoiceLength("story_v_out_319851", "319851020", "story_v_out_319851.awb") ~= 0 then
					local var_88_18 = manager.audio:GetVoiceLength("story_v_out_319851", "319851020", "story_v_out_319851.awb") / 1000

					if var_88_18 + var_88_10 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_18 + var_88_10
					end

					if var_88_13.prefab_name ~= "" and arg_85_1.actors_[var_88_13.prefab_name] ~= nil then
						local var_88_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_13.prefab_name].transform, "story_v_out_319851", "319851020", "story_v_out_319851.awb")

						arg_85_1:RecordAudio("319851020", var_88_19)
						arg_85_1:RecordAudio("319851020", var_88_19)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_319851", "319851020", "story_v_out_319851.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_319851", "319851020", "story_v_out_319851.awb")
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
	Play319851021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 319851021
		arg_89_1.duration_ = 4.03

		local var_89_0 = {
			zh = 2.466,
			ja = 4.033
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
				arg_89_0:Play319851022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0

			if var_92_0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_0 + arg_92_0 then
				arg_89_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_1")
			end

			local var_92_1 = 0

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 then
				arg_89_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_92_2 = 0
			local var_92_3 = 0.35

			if var_92_2 < arg_89_1.time_ and arg_89_1.time_ <= var_92_2 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_4 = arg_89_1:FormatText(StoryNameCfg[6].name)

				arg_89_1.leftNameTxt_.text = var_92_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_5 = arg_89_1:GetWordFromCfg(319851021)
				local var_92_6 = arg_89_1:FormatText(var_92_5.content)

				arg_89_1.text_.text = var_92_6

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_7 = 14
				local var_92_8 = utf8.len(var_92_6)
				local var_92_9 = var_92_7 <= 0 and var_92_3 or var_92_3 * (var_92_8 / var_92_7)

				if var_92_9 > 0 and var_92_3 < var_92_9 then
					arg_89_1.talkMaxDuration = var_92_9

					if var_92_9 + var_92_2 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_9 + var_92_2
					end
				end

				arg_89_1.text_.text = var_92_6
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319851", "319851021", "story_v_out_319851.awb") ~= 0 then
					local var_92_10 = manager.audio:GetVoiceLength("story_v_out_319851", "319851021", "story_v_out_319851.awb") / 1000

					if var_92_10 + var_92_2 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_10 + var_92_2
					end

					if var_92_5.prefab_name ~= "" and arg_89_1.actors_[var_92_5.prefab_name] ~= nil then
						local var_92_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_5.prefab_name].transform, "story_v_out_319851", "319851021", "story_v_out_319851.awb")

						arg_89_1:RecordAudio("319851021", var_92_11)
						arg_89_1:RecordAudio("319851021", var_92_11)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_319851", "319851021", "story_v_out_319851.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_319851", "319851021", "story_v_out_319851.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_12 = math.max(var_92_3, arg_89_1.talkMaxDuration)

			if var_92_2 <= arg_89_1.time_ and arg_89_1.time_ < var_92_2 + var_92_12 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_2) / var_92_12

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_2 + var_92_12 and arg_89_1.time_ < var_92_2 + var_92_12 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play319851022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 319851022
		arg_93_1.duration_ = 3.7

		local var_93_0 = {
			zh = 2.066,
			ja = 3.7
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
				arg_93_0:Play319851023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = arg_93_1.actors_["10058ui_story"]
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.characterEffect10058ui_story == nil then
				arg_93_1.var_.characterEffect10058ui_story = var_96_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_2 = 0.200000002980232

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_2 and not isNil(var_96_0) then
				local var_96_3 = (arg_93_1.time_ - var_96_1) / var_96_2

				if arg_93_1.var_.characterEffect10058ui_story and not isNil(var_96_0) then
					arg_93_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= var_96_1 + var_96_2 and arg_93_1.time_ < var_96_1 + var_96_2 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.characterEffect10058ui_story then
				arg_93_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_96_4 = arg_93_1.actors_["1084ui_story"]
			local var_96_5 = 0

			if var_96_5 < arg_93_1.time_ and arg_93_1.time_ <= var_96_5 + arg_96_0 and not isNil(var_96_4) and arg_93_1.var_.characterEffect1084ui_story == nil then
				arg_93_1.var_.characterEffect1084ui_story = var_96_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_6 = 0.200000002980232

			if var_96_5 <= arg_93_1.time_ and arg_93_1.time_ < var_96_5 + var_96_6 and not isNil(var_96_4) then
				local var_96_7 = (arg_93_1.time_ - var_96_5) / var_96_6

				if arg_93_1.var_.characterEffect1084ui_story and not isNil(var_96_4) then
					local var_96_8 = Mathf.Lerp(0, 0.5, var_96_7)

					arg_93_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_93_1.var_.characterEffect1084ui_story.fillRatio = var_96_8
				end
			end

			if arg_93_1.time_ >= var_96_5 + var_96_6 and arg_93_1.time_ < var_96_5 + var_96_6 + arg_96_0 and not isNil(var_96_4) and arg_93_1.var_.characterEffect1084ui_story then
				local var_96_9 = 0.5

				arg_93_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_93_1.var_.characterEffect1084ui_story.fillRatio = var_96_9
			end

			local var_96_10 = 0
			local var_96_11 = 0.25

			if var_96_10 < arg_93_1.time_ and arg_93_1.time_ <= var_96_10 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_12 = arg_93_1:FormatText(StoryNameCfg[471].name)

				arg_93_1.leftNameTxt_.text = var_96_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_13 = arg_93_1:GetWordFromCfg(319851022)
				local var_96_14 = arg_93_1:FormatText(var_96_13.content)

				arg_93_1.text_.text = var_96_14

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_15 = 10
				local var_96_16 = utf8.len(var_96_14)
				local var_96_17 = var_96_15 <= 0 and var_96_11 or var_96_11 * (var_96_16 / var_96_15)

				if var_96_17 > 0 and var_96_11 < var_96_17 then
					arg_93_1.talkMaxDuration = var_96_17

					if var_96_17 + var_96_10 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_17 + var_96_10
					end
				end

				arg_93_1.text_.text = var_96_14
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319851", "319851022", "story_v_out_319851.awb") ~= 0 then
					local var_96_18 = manager.audio:GetVoiceLength("story_v_out_319851", "319851022", "story_v_out_319851.awb") / 1000

					if var_96_18 + var_96_10 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_18 + var_96_10
					end

					if var_96_13.prefab_name ~= "" and arg_93_1.actors_[var_96_13.prefab_name] ~= nil then
						local var_96_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_13.prefab_name].transform, "story_v_out_319851", "319851022", "story_v_out_319851.awb")

						arg_93_1:RecordAudio("319851022", var_96_19)
						arg_93_1:RecordAudio("319851022", var_96_19)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_319851", "319851022", "story_v_out_319851.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_319851", "319851022", "story_v_out_319851.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_20 = math.max(var_96_11, arg_93_1.talkMaxDuration)

			if var_96_10 <= arg_93_1.time_ and arg_93_1.time_ < var_96_10 + var_96_20 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_10) / var_96_20

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_10 + var_96_20 and arg_93_1.time_ < var_96_10 + var_96_20 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play319851023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 319851023
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play319851024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = arg_97_1.actors_["10058ui_story"]
			local var_100_1 = 0

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.characterEffect10058ui_story == nil then
				arg_97_1.var_.characterEffect10058ui_story = var_100_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_2 = 0.200000002980232

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_2 and not isNil(var_100_0) then
				local var_100_3 = (arg_97_1.time_ - var_100_1) / var_100_2

				if arg_97_1.var_.characterEffect10058ui_story and not isNil(var_100_0) then
					local var_100_4 = Mathf.Lerp(0, 0.5, var_100_3)

					arg_97_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_97_1.var_.characterEffect10058ui_story.fillRatio = var_100_4
				end
			end

			if arg_97_1.time_ >= var_100_1 + var_100_2 and arg_97_1.time_ < var_100_1 + var_100_2 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.characterEffect10058ui_story then
				local var_100_5 = 0.5

				arg_97_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_97_1.var_.characterEffect10058ui_story.fillRatio = var_100_5
			end

			local var_100_6 = 0

			if var_100_6 < arg_97_1.time_ and arg_97_1.time_ <= var_100_6 + arg_100_0 then
				arg_97_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_2")
			end

			local var_100_7 = 0
			local var_100_8 = 1.075

			if var_100_7 < arg_97_1.time_ and arg_97_1.time_ <= var_100_7 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, false)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_9 = arg_97_1:GetWordFromCfg(319851023)
				local var_100_10 = arg_97_1:FormatText(var_100_9.content)

				arg_97_1.text_.text = var_100_10

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_11 = 43
				local var_100_12 = utf8.len(var_100_10)
				local var_100_13 = var_100_11 <= 0 and var_100_8 or var_100_8 * (var_100_12 / var_100_11)

				if var_100_13 > 0 and var_100_8 < var_100_13 then
					arg_97_1.talkMaxDuration = var_100_13

					if var_100_13 + var_100_7 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_13 + var_100_7
					end
				end

				arg_97_1.text_.text = var_100_10
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_14 = math.max(var_100_8, arg_97_1.talkMaxDuration)

			if var_100_7 <= arg_97_1.time_ and arg_97_1.time_ < var_100_7 + var_100_14 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_7) / var_100_14

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_7 + var_100_14 and arg_97_1.time_ < var_100_7 + var_100_14 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play319851024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 319851024
		arg_101_1.duration_ = 16.5

		local var_101_0 = {
			zh = 8.066,
			ja = 16.5
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
				arg_101_0:Play319851025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = arg_101_1.actors_["10058ui_story"].transform
			local var_104_1 = 0

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 then
				arg_101_1.var_.moveOldPos10058ui_story = var_104_0.localPosition
			end

			local var_104_2 = 0.001

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_2 then
				local var_104_3 = (arg_101_1.time_ - var_104_1) / var_104_2
				local var_104_4 = Vector3.New(0.7, -0.98, -6.1)

				var_104_0.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos10058ui_story, var_104_4, var_104_3)

				local var_104_5 = manager.ui.mainCamera.transform.position - var_104_0.position

				var_104_0.forward = Vector3.New(var_104_5.x, var_104_5.y, var_104_5.z)

				local var_104_6 = var_104_0.localEulerAngles

				var_104_6.z = 0
				var_104_6.x = 0
				var_104_0.localEulerAngles = var_104_6
			end

			if arg_101_1.time_ >= var_104_1 + var_104_2 and arg_101_1.time_ < var_104_1 + var_104_2 + arg_104_0 then
				var_104_0.localPosition = Vector3.New(0.7, -0.98, -6.1)

				local var_104_7 = manager.ui.mainCamera.transform.position - var_104_0.position

				var_104_0.forward = Vector3.New(var_104_7.x, var_104_7.y, var_104_7.z)

				local var_104_8 = var_104_0.localEulerAngles

				var_104_8.z = 0
				var_104_8.x = 0
				var_104_0.localEulerAngles = var_104_8
			end

			local var_104_9 = arg_101_1.actors_["10058ui_story"]
			local var_104_10 = 0

			if var_104_10 < arg_101_1.time_ and arg_101_1.time_ <= var_104_10 + arg_104_0 and not isNil(var_104_9) and arg_101_1.var_.characterEffect10058ui_story == nil then
				arg_101_1.var_.characterEffect10058ui_story = var_104_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_11 = 0.200000002980232

			if var_104_10 <= arg_101_1.time_ and arg_101_1.time_ < var_104_10 + var_104_11 and not isNil(var_104_9) then
				local var_104_12 = (arg_101_1.time_ - var_104_10) / var_104_11

				if arg_101_1.var_.characterEffect10058ui_story and not isNil(var_104_9) then
					arg_101_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= var_104_10 + var_104_11 and arg_101_1.time_ < var_104_10 + var_104_11 + arg_104_0 and not isNil(var_104_9) and arg_101_1.var_.characterEffect10058ui_story then
				arg_101_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_104_13 = 0

			if var_104_13 < arg_101_1.time_ and arg_101_1.time_ <= var_104_13 + arg_104_0 then
				arg_101_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_104_14 = 0
			local var_104_15 = 0.775

			if var_104_14 < arg_101_1.time_ and arg_101_1.time_ <= var_104_14 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_16 = arg_101_1:FormatText(StoryNameCfg[471].name)

				arg_101_1.leftNameTxt_.text = var_104_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_17 = arg_101_1:GetWordFromCfg(319851024)
				local var_104_18 = arg_101_1:FormatText(var_104_17.content)

				arg_101_1.text_.text = var_104_18

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_19 = 31
				local var_104_20 = utf8.len(var_104_18)
				local var_104_21 = var_104_19 <= 0 and var_104_15 or var_104_15 * (var_104_20 / var_104_19)

				if var_104_21 > 0 and var_104_15 < var_104_21 then
					arg_101_1.talkMaxDuration = var_104_21

					if var_104_21 + var_104_14 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_21 + var_104_14
					end
				end

				arg_101_1.text_.text = var_104_18
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319851", "319851024", "story_v_out_319851.awb") ~= 0 then
					local var_104_22 = manager.audio:GetVoiceLength("story_v_out_319851", "319851024", "story_v_out_319851.awb") / 1000

					if var_104_22 + var_104_14 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_22 + var_104_14
					end

					if var_104_17.prefab_name ~= "" and arg_101_1.actors_[var_104_17.prefab_name] ~= nil then
						local var_104_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_17.prefab_name].transform, "story_v_out_319851", "319851024", "story_v_out_319851.awb")

						arg_101_1:RecordAudio("319851024", var_104_23)
						arg_101_1:RecordAudio("319851024", var_104_23)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_319851", "319851024", "story_v_out_319851.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_319851", "319851024", "story_v_out_319851.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_24 = math.max(var_104_15, arg_101_1.talkMaxDuration)

			if var_104_14 <= arg_101_1.time_ and arg_101_1.time_ < var_104_14 + var_104_24 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_14) / var_104_24

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_14 + var_104_24 and arg_101_1.time_ < var_104_14 + var_104_24 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
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

		arg_101_1:InitPlayNodeList()
	end,
	Play319851025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 319851025
		arg_105_1.duration_ = 8.4

		local var_105_0 = {
			zh = 8.4,
			ja = 5.433
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
				arg_105_0:Play319851026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 0

			if var_108_0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_0 + arg_108_0 then
				arg_105_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action3_2")
			end

			local var_108_1 = 0
			local var_108_2 = 1.075

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_3 = arg_105_1:FormatText(StoryNameCfg[471].name)

				arg_105_1.leftNameTxt_.text = var_108_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_4 = arg_105_1:GetWordFromCfg(319851025)
				local var_108_5 = arg_105_1:FormatText(var_108_4.content)

				arg_105_1.text_.text = var_108_5

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_6 = 43
				local var_108_7 = utf8.len(var_108_5)
				local var_108_8 = var_108_6 <= 0 and var_108_2 or var_108_2 * (var_108_7 / var_108_6)

				if var_108_8 > 0 and var_108_2 < var_108_8 then
					arg_105_1.talkMaxDuration = var_108_8

					if var_108_8 + var_108_1 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_8 + var_108_1
					end
				end

				arg_105_1.text_.text = var_108_5
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319851", "319851025", "story_v_out_319851.awb") ~= 0 then
					local var_108_9 = manager.audio:GetVoiceLength("story_v_out_319851", "319851025", "story_v_out_319851.awb") / 1000

					if var_108_9 + var_108_1 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_9 + var_108_1
					end

					if var_108_4.prefab_name ~= "" and arg_105_1.actors_[var_108_4.prefab_name] ~= nil then
						local var_108_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_4.prefab_name].transform, "story_v_out_319851", "319851025", "story_v_out_319851.awb")

						arg_105_1:RecordAudio("319851025", var_108_10)
						arg_105_1:RecordAudio("319851025", var_108_10)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_319851", "319851025", "story_v_out_319851.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_319851", "319851025", "story_v_out_319851.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_11 = math.max(var_108_2, arg_105_1.talkMaxDuration)

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_11 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_1) / var_108_11

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_1 + var_108_11 and arg_105_1.time_ < var_108_1 + var_108_11 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play319851026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 319851026
		arg_109_1.duration_ = 13.93

		local var_109_0 = {
			zh = 10.033,
			ja = 13.933
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
				arg_109_0:Play319851027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 0
			local var_112_1 = 1.2

			if var_112_0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_0 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_2 = arg_109_1:FormatText(StoryNameCfg[471].name)

				arg_109_1.leftNameTxt_.text = var_112_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_3 = arg_109_1:GetWordFromCfg(319851026)
				local var_112_4 = arg_109_1:FormatText(var_112_3.content)

				arg_109_1.text_.text = var_112_4

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_5 = 48
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

				if manager.audio:GetVoiceLength("story_v_out_319851", "319851026", "story_v_out_319851.awb") ~= 0 then
					local var_112_8 = manager.audio:GetVoiceLength("story_v_out_319851", "319851026", "story_v_out_319851.awb") / 1000

					if var_112_8 + var_112_0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_8 + var_112_0
					end

					if var_112_3.prefab_name ~= "" and arg_109_1.actors_[var_112_3.prefab_name] ~= nil then
						local var_112_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_3.prefab_name].transform, "story_v_out_319851", "319851026", "story_v_out_319851.awb")

						arg_109_1:RecordAudio("319851026", var_112_9)
						arg_109_1:RecordAudio("319851026", var_112_9)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_319851", "319851026", "story_v_out_319851.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_319851", "319851026", "story_v_out_319851.awb")
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
	Play319851027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 319851027
		arg_113_1.duration_ = 9.33

		local var_113_0 = {
			zh = 9.333,
			ja = 6.533
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
				arg_113_0:Play319851028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = 0
			local var_116_1 = 1.125

			if var_116_0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_0 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_2 = arg_113_1:FormatText(StoryNameCfg[471].name)

				arg_113_1.leftNameTxt_.text = var_116_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_3 = arg_113_1:GetWordFromCfg(319851027)
				local var_116_4 = arg_113_1:FormatText(var_116_3.content)

				arg_113_1.text_.text = var_116_4

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_5 = 45
				local var_116_6 = utf8.len(var_116_4)
				local var_116_7 = var_116_5 <= 0 and var_116_1 or var_116_1 * (var_116_6 / var_116_5)

				if var_116_7 > 0 and var_116_1 < var_116_7 then
					arg_113_1.talkMaxDuration = var_116_7

					if var_116_7 + var_116_0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_7 + var_116_0
					end
				end

				arg_113_1.text_.text = var_116_4
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319851", "319851027", "story_v_out_319851.awb") ~= 0 then
					local var_116_8 = manager.audio:GetVoiceLength("story_v_out_319851", "319851027", "story_v_out_319851.awb") / 1000

					if var_116_8 + var_116_0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_8 + var_116_0
					end

					if var_116_3.prefab_name ~= "" and arg_113_1.actors_[var_116_3.prefab_name] ~= nil then
						local var_116_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_3.prefab_name].transform, "story_v_out_319851", "319851027", "story_v_out_319851.awb")

						arg_113_1:RecordAudio("319851027", var_116_9)
						arg_113_1:RecordAudio("319851027", var_116_9)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_319851", "319851027", "story_v_out_319851.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_319851", "319851027", "story_v_out_319851.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_10 = math.max(var_116_1, arg_113_1.talkMaxDuration)

			if var_116_0 <= arg_113_1.time_ and arg_113_1.time_ < var_116_0 + var_116_10 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_0) / var_116_10

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_0 + var_116_10 and arg_113_1.time_ < var_116_0 + var_116_10 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play319851028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 319851028
		arg_117_1.duration_ = 8.5

		local var_117_0 = {
			zh = 8.133,
			ja = 8.5
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
				arg_117_0:Play319851029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = arg_117_1.actors_["10058ui_story"].transform
			local var_120_1 = 0

			if var_120_1 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 then
				arg_117_1.var_.moveOldPos10058ui_story = var_120_0.localPosition
			end

			local var_120_2 = 0.001

			if var_120_1 <= arg_117_1.time_ and arg_117_1.time_ < var_120_1 + var_120_2 then
				local var_120_3 = (arg_117_1.time_ - var_120_1) / var_120_2
				local var_120_4 = Vector3.New(0.7, -0.98, -6.1)

				var_120_0.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos10058ui_story, var_120_4, var_120_3)

				local var_120_5 = manager.ui.mainCamera.transform.position - var_120_0.position

				var_120_0.forward = Vector3.New(var_120_5.x, var_120_5.y, var_120_5.z)

				local var_120_6 = var_120_0.localEulerAngles

				var_120_6.z = 0
				var_120_6.x = 0
				var_120_0.localEulerAngles = var_120_6
			end

			if arg_117_1.time_ >= var_120_1 + var_120_2 and arg_117_1.time_ < var_120_1 + var_120_2 + arg_120_0 then
				var_120_0.localPosition = Vector3.New(0.7, -0.98, -6.1)

				local var_120_7 = manager.ui.mainCamera.transform.position - var_120_0.position

				var_120_0.forward = Vector3.New(var_120_7.x, var_120_7.y, var_120_7.z)

				local var_120_8 = var_120_0.localEulerAngles

				var_120_8.z = 0
				var_120_8.x = 0
				var_120_0.localEulerAngles = var_120_8
			end

			local var_120_9 = arg_117_1.actors_["10058ui_story"]
			local var_120_10 = 0

			if var_120_10 < arg_117_1.time_ and arg_117_1.time_ <= var_120_10 + arg_120_0 and not isNil(var_120_9) and arg_117_1.var_.characterEffect10058ui_story == nil then
				arg_117_1.var_.characterEffect10058ui_story = var_120_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_11 = 0.200000002980232

			if var_120_10 <= arg_117_1.time_ and arg_117_1.time_ < var_120_10 + var_120_11 and not isNil(var_120_9) then
				local var_120_12 = (arg_117_1.time_ - var_120_10) / var_120_11

				if arg_117_1.var_.characterEffect10058ui_story and not isNil(var_120_9) then
					arg_117_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_117_1.time_ >= var_120_10 + var_120_11 and arg_117_1.time_ < var_120_10 + var_120_11 + arg_120_0 and not isNil(var_120_9) and arg_117_1.var_.characterEffect10058ui_story then
				arg_117_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_120_13 = 0

			if var_120_13 < arg_117_1.time_ and arg_117_1.time_ <= var_120_13 + arg_120_0 then
				arg_117_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_1")
			end

			local var_120_14 = 0

			if var_120_14 < arg_117_1.time_ and arg_117_1.time_ <= var_120_14 + arg_120_0 then
				arg_117_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_120_15 = 0
			local var_120_16 = 1.175

			if var_120_15 < arg_117_1.time_ and arg_117_1.time_ <= var_120_15 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_17 = arg_117_1:FormatText(StoryNameCfg[471].name)

				arg_117_1.leftNameTxt_.text = var_120_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_18 = arg_117_1:GetWordFromCfg(319851028)
				local var_120_19 = arg_117_1:FormatText(var_120_18.content)

				arg_117_1.text_.text = var_120_19

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_20 = 47
				local var_120_21 = utf8.len(var_120_19)
				local var_120_22 = var_120_20 <= 0 and var_120_16 or var_120_16 * (var_120_21 / var_120_20)

				if var_120_22 > 0 and var_120_16 < var_120_22 then
					arg_117_1.talkMaxDuration = var_120_22

					if var_120_22 + var_120_15 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_22 + var_120_15
					end
				end

				arg_117_1.text_.text = var_120_19
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319851", "319851028", "story_v_out_319851.awb") ~= 0 then
					local var_120_23 = manager.audio:GetVoiceLength("story_v_out_319851", "319851028", "story_v_out_319851.awb") / 1000

					if var_120_23 + var_120_15 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_23 + var_120_15
					end

					if var_120_18.prefab_name ~= "" and arg_117_1.actors_[var_120_18.prefab_name] ~= nil then
						local var_120_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_18.prefab_name].transform, "story_v_out_319851", "319851028", "story_v_out_319851.awb")

						arg_117_1:RecordAudio("319851028", var_120_24)
						arg_117_1:RecordAudio("319851028", var_120_24)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_319851", "319851028", "story_v_out_319851.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_319851", "319851028", "story_v_out_319851.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_25 = math.max(var_120_16, arg_117_1.talkMaxDuration)

			if var_120_15 <= arg_117_1.time_ and arg_117_1.time_ < var_120_15 + var_120_25 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_15) / var_120_25

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_15 + var_120_25 and arg_117_1.time_ < var_120_15 + var_120_25 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
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

		arg_117_1:InitPlayNodeList()
	end,
	Play319851029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 319851029
		arg_121_1.duration_ = 7.2

		local var_121_0 = {
			zh = 3.2,
			ja = 7.2
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
				arg_121_0:Play319851030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = arg_121_1.actors_["1084ui_story"].transform
			local var_124_1 = 0

			if var_124_1 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 then
				arg_121_1.var_.moveOldPos1084ui_story = var_124_0.localPosition
			end

			local var_124_2 = 0.001

			if var_124_1 <= arg_121_1.time_ and arg_121_1.time_ < var_124_1 + var_124_2 then
				local var_124_3 = (arg_121_1.time_ - var_124_1) / var_124_2
				local var_124_4 = Vector3.New(-0.7, -0.97, -6)

				var_124_0.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos1084ui_story, var_124_4, var_124_3)

				local var_124_5 = manager.ui.mainCamera.transform.position - var_124_0.position

				var_124_0.forward = Vector3.New(var_124_5.x, var_124_5.y, var_124_5.z)

				local var_124_6 = var_124_0.localEulerAngles

				var_124_6.z = 0
				var_124_6.x = 0
				var_124_0.localEulerAngles = var_124_6
			end

			if arg_121_1.time_ >= var_124_1 + var_124_2 and arg_121_1.time_ < var_124_1 + var_124_2 + arg_124_0 then
				var_124_0.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_124_7 = manager.ui.mainCamera.transform.position - var_124_0.position

				var_124_0.forward = Vector3.New(var_124_7.x, var_124_7.y, var_124_7.z)

				local var_124_8 = var_124_0.localEulerAngles

				var_124_8.z = 0
				var_124_8.x = 0
				var_124_0.localEulerAngles = var_124_8
			end

			local var_124_9 = arg_121_1.actors_["1084ui_story"]
			local var_124_10 = 0

			if var_124_10 < arg_121_1.time_ and arg_121_1.time_ <= var_124_10 + arg_124_0 and not isNil(var_124_9) and arg_121_1.var_.characterEffect1084ui_story == nil then
				arg_121_1.var_.characterEffect1084ui_story = var_124_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_11 = 0.200000002980232

			if var_124_10 <= arg_121_1.time_ and arg_121_1.time_ < var_124_10 + var_124_11 and not isNil(var_124_9) then
				local var_124_12 = (arg_121_1.time_ - var_124_10) / var_124_11

				if arg_121_1.var_.characterEffect1084ui_story and not isNil(var_124_9) then
					arg_121_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= var_124_10 + var_124_11 and arg_121_1.time_ < var_124_10 + var_124_11 + arg_124_0 and not isNil(var_124_9) and arg_121_1.var_.characterEffect1084ui_story then
				arg_121_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_124_13 = 0

			if var_124_13 < arg_121_1.time_ and arg_121_1.time_ <= var_124_13 + arg_124_0 then
				arg_121_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_2")
			end

			local var_124_14 = 0

			if var_124_14 < arg_121_1.time_ and arg_121_1.time_ <= var_124_14 + arg_124_0 then
				arg_121_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2201cva")
			end

			local var_124_15 = arg_121_1.actors_["10058ui_story"]
			local var_124_16 = 0

			if var_124_16 < arg_121_1.time_ and arg_121_1.time_ <= var_124_16 + arg_124_0 and not isNil(var_124_15) and arg_121_1.var_.characterEffect10058ui_story == nil then
				arg_121_1.var_.characterEffect10058ui_story = var_124_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_17 = 0.200000002980232

			if var_124_16 <= arg_121_1.time_ and arg_121_1.time_ < var_124_16 + var_124_17 and not isNil(var_124_15) then
				local var_124_18 = (arg_121_1.time_ - var_124_16) / var_124_17

				if arg_121_1.var_.characterEffect10058ui_story and not isNil(var_124_15) then
					local var_124_19 = Mathf.Lerp(0, 0.5, var_124_18)

					arg_121_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_121_1.var_.characterEffect10058ui_story.fillRatio = var_124_19
				end
			end

			if arg_121_1.time_ >= var_124_16 + var_124_17 and arg_121_1.time_ < var_124_16 + var_124_17 + arg_124_0 and not isNil(var_124_15) and arg_121_1.var_.characterEffect10058ui_story then
				local var_124_20 = 0.5

				arg_121_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_121_1.var_.characterEffect10058ui_story.fillRatio = var_124_20
			end

			local var_124_21 = 0
			local var_124_22 = 0.425

			if var_124_21 < arg_121_1.time_ and arg_121_1.time_ <= var_124_21 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_23 = arg_121_1:FormatText(StoryNameCfg[6].name)

				arg_121_1.leftNameTxt_.text = var_124_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_24 = arg_121_1:GetWordFromCfg(319851029)
				local var_124_25 = arg_121_1:FormatText(var_124_24.content)

				arg_121_1.text_.text = var_124_25

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_26 = 17
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

				if manager.audio:GetVoiceLength("story_v_out_319851", "319851029", "story_v_out_319851.awb") ~= 0 then
					local var_124_29 = manager.audio:GetVoiceLength("story_v_out_319851", "319851029", "story_v_out_319851.awb") / 1000

					if var_124_29 + var_124_21 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_29 + var_124_21
					end

					if var_124_24.prefab_name ~= "" and arg_121_1.actors_[var_124_24.prefab_name] ~= nil then
						local var_124_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_24.prefab_name].transform, "story_v_out_319851", "319851029", "story_v_out_319851.awb")

						arg_121_1:RecordAudio("319851029", var_124_30)
						arg_121_1:RecordAudio("319851029", var_124_30)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_319851", "319851029", "story_v_out_319851.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_319851", "319851029", "story_v_out_319851.awb")
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
				actorName = "1084ui_story",
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
	Play319851030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 319851030
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play319851031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = arg_125_1.actors_["1084ui_story"]
			local var_128_1 = 0

			if var_128_1 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 and not isNil(var_128_0) and arg_125_1.var_.characterEffect1084ui_story == nil then
				arg_125_1.var_.characterEffect1084ui_story = var_128_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_2 = 0.200000002980232

			if var_128_1 <= arg_125_1.time_ and arg_125_1.time_ < var_128_1 + var_128_2 and not isNil(var_128_0) then
				local var_128_3 = (arg_125_1.time_ - var_128_1) / var_128_2

				if arg_125_1.var_.characterEffect1084ui_story and not isNil(var_128_0) then
					local var_128_4 = Mathf.Lerp(0, 0.5, var_128_3)

					arg_125_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_125_1.var_.characterEffect1084ui_story.fillRatio = var_128_4
				end
			end

			if arg_125_1.time_ >= var_128_1 + var_128_2 and arg_125_1.time_ < var_128_1 + var_128_2 + arg_128_0 and not isNil(var_128_0) and arg_125_1.var_.characterEffect1084ui_story then
				local var_128_5 = 0.5

				arg_125_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_125_1.var_.characterEffect1084ui_story.fillRatio = var_128_5
			end

			local var_128_6 = arg_125_1.actors_["10058ui_story"].transform
			local var_128_7 = 0

			if var_128_7 < arg_125_1.time_ and arg_125_1.time_ <= var_128_7 + arg_128_0 then
				arg_125_1.var_.moveOldPos10058ui_story = var_128_6.localPosition
			end

			local var_128_8 = 0.001

			if var_128_7 <= arg_125_1.time_ and arg_125_1.time_ < var_128_7 + var_128_8 then
				local var_128_9 = (arg_125_1.time_ - var_128_7) / var_128_8
				local var_128_10 = Vector3.New(0, 100, 0)

				var_128_6.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos10058ui_story, var_128_10, var_128_9)

				local var_128_11 = manager.ui.mainCamera.transform.position - var_128_6.position

				var_128_6.forward = Vector3.New(var_128_11.x, var_128_11.y, var_128_11.z)

				local var_128_12 = var_128_6.localEulerAngles

				var_128_12.z = 0
				var_128_12.x = 0
				var_128_6.localEulerAngles = var_128_12
			end

			if arg_125_1.time_ >= var_128_7 + var_128_8 and arg_125_1.time_ < var_128_7 + var_128_8 + arg_128_0 then
				var_128_6.localPosition = Vector3.New(0, 100, 0)

				local var_128_13 = manager.ui.mainCamera.transform.position - var_128_6.position

				var_128_6.forward = Vector3.New(var_128_13.x, var_128_13.y, var_128_13.z)

				local var_128_14 = var_128_6.localEulerAngles

				var_128_14.z = 0
				var_128_14.x = 0
				var_128_6.localEulerAngles = var_128_14
			end

			local var_128_15 = arg_125_1.actors_["1084ui_story"].transform
			local var_128_16 = 0

			if var_128_16 < arg_125_1.time_ and arg_125_1.time_ <= var_128_16 + arg_128_0 then
				arg_125_1.var_.moveOldPos1084ui_story = var_128_15.localPosition
			end

			local var_128_17 = 0.001

			if var_128_16 <= arg_125_1.time_ and arg_125_1.time_ < var_128_16 + var_128_17 then
				local var_128_18 = (arg_125_1.time_ - var_128_16) / var_128_17
				local var_128_19 = Vector3.New(0, 100, 0)

				var_128_15.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1084ui_story, var_128_19, var_128_18)

				local var_128_20 = manager.ui.mainCamera.transform.position - var_128_15.position

				var_128_15.forward = Vector3.New(var_128_20.x, var_128_20.y, var_128_20.z)

				local var_128_21 = var_128_15.localEulerAngles

				var_128_21.z = 0
				var_128_21.x = 0
				var_128_15.localEulerAngles = var_128_21
			end

			if arg_125_1.time_ >= var_128_16 + var_128_17 and arg_125_1.time_ < var_128_16 + var_128_17 + arg_128_0 then
				var_128_15.localPosition = Vector3.New(0, 100, 0)

				local var_128_22 = manager.ui.mainCamera.transform.position - var_128_15.position

				var_128_15.forward = Vector3.New(var_128_22.x, var_128_22.y, var_128_22.z)

				local var_128_23 = var_128_15.localEulerAngles

				var_128_23.z = 0
				var_128_23.x = 0
				var_128_15.localEulerAngles = var_128_23
			end

			local var_128_24 = 0
			local var_128_25 = 0.825

			if var_128_24 < arg_125_1.time_ and arg_125_1.time_ <= var_128_24 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, false)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_26 = arg_125_1:GetWordFromCfg(319851030)
				local var_128_27 = arg_125_1:FormatText(var_128_26.content)

				arg_125_1.text_.text = var_128_27

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_28 = 33
				local var_128_29 = utf8.len(var_128_27)
				local var_128_30 = var_128_28 <= 0 and var_128_25 or var_128_25 * (var_128_29 / var_128_28)

				if var_128_30 > 0 and var_128_25 < var_128_30 then
					arg_125_1.talkMaxDuration = var_128_30

					if var_128_30 + var_128_24 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_30 + var_128_24
					end
				end

				arg_125_1.text_.text = var_128_27
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_31 = math.max(var_128_25, arg_125_1.talkMaxDuration)

			if var_128_24 <= arg_125_1.time_ and arg_125_1.time_ < var_128_24 + var_128_31 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_24) / var_128_31

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_24 + var_128_31 and arg_125_1.time_ < var_128_24 + var_128_31 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
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

		arg_125_1:InitPlayNodeList()
	end,
	Play319851031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 319851031
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play319851032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 0
			local var_132_1 = 0.85

			if var_132_0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_0 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, false)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_2 = arg_129_1:GetWordFromCfg(319851031)
				local var_132_3 = arg_129_1:FormatText(var_132_2.content)

				arg_129_1.text_.text = var_132_3

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_4 = 34
				local var_132_5 = utf8.len(var_132_3)
				local var_132_6 = var_132_4 <= 0 and var_132_1 or var_132_1 * (var_132_5 / var_132_4)

				if var_132_6 > 0 and var_132_1 < var_132_6 then
					arg_129_1.talkMaxDuration = var_132_6

					if var_132_6 + var_132_0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_6 + var_132_0
					end
				end

				arg_129_1.text_.text = var_132_3
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)
				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_7 = math.max(var_132_1, arg_129_1.talkMaxDuration)

			if var_132_0 <= arg_129_1.time_ and arg_129_1.time_ < var_132_0 + var_132_7 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_0) / var_132_7

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_0 + var_132_7 and arg_129_1.time_ < var_132_0 + var_132_7 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play319851032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 319851032
		arg_133_1.duration_ = 15.13

		local var_133_0 = {
			zh = 11.266,
			ja = 15.133
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
				arg_133_0:Play319851033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = arg_133_1.actors_["10058ui_story"].transform
			local var_136_1 = 0

			if var_136_1 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 then
				arg_133_1.var_.moveOldPos10058ui_story = var_136_0.localPosition
			end

			local var_136_2 = 0.001

			if var_136_1 <= arg_133_1.time_ and arg_133_1.time_ < var_136_1 + var_136_2 then
				local var_136_3 = (arg_133_1.time_ - var_136_1) / var_136_2
				local var_136_4 = Vector3.New(0.7, -0.98, -6.1)

				var_136_0.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos10058ui_story, var_136_4, var_136_3)

				local var_136_5 = manager.ui.mainCamera.transform.position - var_136_0.position

				var_136_0.forward = Vector3.New(var_136_5.x, var_136_5.y, var_136_5.z)

				local var_136_6 = var_136_0.localEulerAngles

				var_136_6.z = 0
				var_136_6.x = 0
				var_136_0.localEulerAngles = var_136_6
			end

			if arg_133_1.time_ >= var_136_1 + var_136_2 and arg_133_1.time_ < var_136_1 + var_136_2 + arg_136_0 then
				var_136_0.localPosition = Vector3.New(0.7, -0.98, -6.1)

				local var_136_7 = manager.ui.mainCamera.transform.position - var_136_0.position

				var_136_0.forward = Vector3.New(var_136_7.x, var_136_7.y, var_136_7.z)

				local var_136_8 = var_136_0.localEulerAngles

				var_136_8.z = 0
				var_136_8.x = 0
				var_136_0.localEulerAngles = var_136_8
			end

			local var_136_9 = arg_133_1.actors_["1084ui_story"].transform
			local var_136_10 = 0

			if var_136_10 < arg_133_1.time_ and arg_133_1.time_ <= var_136_10 + arg_136_0 then
				arg_133_1.var_.moveOldPos1084ui_story = var_136_9.localPosition
			end

			local var_136_11 = 0.001

			if var_136_10 <= arg_133_1.time_ and arg_133_1.time_ < var_136_10 + var_136_11 then
				local var_136_12 = (arg_133_1.time_ - var_136_10) / var_136_11
				local var_136_13 = Vector3.New(0, 100, 0)

				var_136_9.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos1084ui_story, var_136_13, var_136_12)

				local var_136_14 = manager.ui.mainCamera.transform.position - var_136_9.position

				var_136_9.forward = Vector3.New(var_136_14.x, var_136_14.y, var_136_14.z)

				local var_136_15 = var_136_9.localEulerAngles

				var_136_15.z = 0
				var_136_15.x = 0
				var_136_9.localEulerAngles = var_136_15
			end

			if arg_133_1.time_ >= var_136_10 + var_136_11 and arg_133_1.time_ < var_136_10 + var_136_11 + arg_136_0 then
				var_136_9.localPosition = Vector3.New(0, 100, 0)

				local var_136_16 = manager.ui.mainCamera.transform.position - var_136_9.position

				var_136_9.forward = Vector3.New(var_136_16.x, var_136_16.y, var_136_16.z)

				local var_136_17 = var_136_9.localEulerAngles

				var_136_17.z = 0
				var_136_17.x = 0
				var_136_9.localEulerAngles = var_136_17
			end

			local var_136_18 = 0

			if var_136_18 < arg_133_1.time_ and arg_133_1.time_ <= var_136_18 + arg_136_0 then
				arg_133_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_2")
			end

			local var_136_19 = 0

			if var_136_19 < arg_133_1.time_ and arg_133_1.time_ <= var_136_19 + arg_136_0 then
				arg_133_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_136_20 = arg_133_1.actors_["10058ui_story"]
			local var_136_21 = 0

			if var_136_21 < arg_133_1.time_ and arg_133_1.time_ <= var_136_21 + arg_136_0 and not isNil(var_136_20) and arg_133_1.var_.characterEffect10058ui_story == nil then
				arg_133_1.var_.characterEffect10058ui_story = var_136_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_22 = 0.200000002980232

			if var_136_21 <= arg_133_1.time_ and arg_133_1.time_ < var_136_21 + var_136_22 and not isNil(var_136_20) then
				local var_136_23 = (arg_133_1.time_ - var_136_21) / var_136_22

				if arg_133_1.var_.characterEffect10058ui_story and not isNil(var_136_20) then
					arg_133_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= var_136_21 + var_136_22 and arg_133_1.time_ < var_136_21 + var_136_22 + arg_136_0 and not isNil(var_136_20) and arg_133_1.var_.characterEffect10058ui_story then
				arg_133_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_136_24 = 0
			local var_136_25 = 1.125

			if var_136_24 < arg_133_1.time_ and arg_133_1.time_ <= var_136_24 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_26 = arg_133_1:FormatText(StoryNameCfg[471].name)

				arg_133_1.leftNameTxt_.text = var_136_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_27 = arg_133_1:GetWordFromCfg(319851032)
				local var_136_28 = arg_133_1:FormatText(var_136_27.content)

				arg_133_1.text_.text = var_136_28

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_29 = 45
				local var_136_30 = utf8.len(var_136_28)
				local var_136_31 = var_136_29 <= 0 and var_136_25 or var_136_25 * (var_136_30 / var_136_29)

				if var_136_31 > 0 and var_136_25 < var_136_31 then
					arg_133_1.talkMaxDuration = var_136_31

					if var_136_31 + var_136_24 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_31 + var_136_24
					end
				end

				arg_133_1.text_.text = var_136_28
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319851", "319851032", "story_v_out_319851.awb") ~= 0 then
					local var_136_32 = manager.audio:GetVoiceLength("story_v_out_319851", "319851032", "story_v_out_319851.awb") / 1000

					if var_136_32 + var_136_24 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_32 + var_136_24
					end

					if var_136_27.prefab_name ~= "" and arg_133_1.actors_[var_136_27.prefab_name] ~= nil then
						local var_136_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_27.prefab_name].transform, "story_v_out_319851", "319851032", "story_v_out_319851.awb")

						arg_133_1:RecordAudio("319851032", var_136_33)
						arg_133_1:RecordAudio("319851032", var_136_33)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_319851", "319851032", "story_v_out_319851.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_319851", "319851032", "story_v_out_319851.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_34 = math.max(var_136_25, arg_133_1.talkMaxDuration)

			if var_136_24 <= arg_133_1.time_ and arg_133_1.time_ < var_136_24 + var_136_34 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_24) / var_136_34

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_24 + var_136_34 and arg_133_1.time_ < var_136_24 + var_136_34 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {
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

		arg_133_1:InitPlayNodeList()
	end,
	Play319851033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 319851033
		arg_137_1.duration_ = 13.8

		local var_137_0 = {
			zh = 6.166,
			ja = 13.8
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
				arg_137_0:Play319851034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = arg_137_1.actors_["10058ui_story"].transform
			local var_140_1 = 0

			if var_140_1 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 then
				arg_137_1.var_.moveOldPos10058ui_story = var_140_0.localPosition
			end

			local var_140_2 = 0.001

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_2 then
				local var_140_3 = (arg_137_1.time_ - var_140_1) / var_140_2
				local var_140_4 = Vector3.New(0.7, -0.98, -6.1)

				var_140_0.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos10058ui_story, var_140_4, var_140_3)

				local var_140_5 = manager.ui.mainCamera.transform.position - var_140_0.position

				var_140_0.forward = Vector3.New(var_140_5.x, var_140_5.y, var_140_5.z)

				local var_140_6 = var_140_0.localEulerAngles

				var_140_6.z = 0
				var_140_6.x = 0
				var_140_0.localEulerAngles = var_140_6
			end

			if arg_137_1.time_ >= var_140_1 + var_140_2 and arg_137_1.time_ < var_140_1 + var_140_2 + arg_140_0 then
				var_140_0.localPosition = Vector3.New(0.7, -0.98, -6.1)

				local var_140_7 = manager.ui.mainCamera.transform.position - var_140_0.position

				var_140_0.forward = Vector3.New(var_140_7.x, var_140_7.y, var_140_7.z)

				local var_140_8 = var_140_0.localEulerAngles

				var_140_8.z = 0
				var_140_8.x = 0
				var_140_0.localEulerAngles = var_140_8
			end

			local var_140_9 = arg_137_1.actors_["10058ui_story"]
			local var_140_10 = 0

			if var_140_10 < arg_137_1.time_ and arg_137_1.time_ <= var_140_10 + arg_140_0 and not isNil(var_140_9) and arg_137_1.var_.characterEffect10058ui_story == nil then
				arg_137_1.var_.characterEffect10058ui_story = var_140_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_11 = 0.200000002980232

			if var_140_10 <= arg_137_1.time_ and arg_137_1.time_ < var_140_10 + var_140_11 and not isNil(var_140_9) then
				local var_140_12 = (arg_137_1.time_ - var_140_10) / var_140_11

				if arg_137_1.var_.characterEffect10058ui_story and not isNil(var_140_9) then
					arg_137_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_137_1.time_ >= var_140_10 + var_140_11 and arg_137_1.time_ < var_140_10 + var_140_11 + arg_140_0 and not isNil(var_140_9) and arg_137_1.var_.characterEffect10058ui_story then
				arg_137_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_140_13 = 0

			if var_140_13 < arg_137_1.time_ and arg_137_1.time_ <= var_140_13 + arg_140_0 then
				arg_137_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action4_1")
			end

			local var_140_14 = 0
			local var_140_15 = 0.825

			if var_140_14 < arg_137_1.time_ and arg_137_1.time_ <= var_140_14 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_16 = arg_137_1:FormatText(StoryNameCfg[471].name)

				arg_137_1.leftNameTxt_.text = var_140_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_17 = arg_137_1:GetWordFromCfg(319851033)
				local var_140_18 = arg_137_1:FormatText(var_140_17.content)

				arg_137_1.text_.text = var_140_18

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_19 = 33
				local var_140_20 = utf8.len(var_140_18)
				local var_140_21 = var_140_19 <= 0 and var_140_15 or var_140_15 * (var_140_20 / var_140_19)

				if var_140_21 > 0 and var_140_15 < var_140_21 then
					arg_137_1.talkMaxDuration = var_140_21

					if var_140_21 + var_140_14 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_21 + var_140_14
					end
				end

				arg_137_1.text_.text = var_140_18
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319851", "319851033", "story_v_out_319851.awb") ~= 0 then
					local var_140_22 = manager.audio:GetVoiceLength("story_v_out_319851", "319851033", "story_v_out_319851.awb") / 1000

					if var_140_22 + var_140_14 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_22 + var_140_14
					end

					if var_140_17.prefab_name ~= "" and arg_137_1.actors_[var_140_17.prefab_name] ~= nil then
						local var_140_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_17.prefab_name].transform, "story_v_out_319851", "319851033", "story_v_out_319851.awb")

						arg_137_1:RecordAudio("319851033", var_140_23)
						arg_137_1:RecordAudio("319851033", var_140_23)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_319851", "319851033", "story_v_out_319851.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_319851", "319851033", "story_v_out_319851.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_24 = math.max(var_140_15, arg_137_1.talkMaxDuration)

			if var_140_14 <= arg_137_1.time_ and arg_137_1.time_ < var_140_14 + var_140_24 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_14) / var_140_24

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_14 + var_140_24 and arg_137_1.time_ < var_140_14 + var_140_24 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {
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

		arg_137_1:InitPlayNodeList()
	end,
	Play319851034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 319851034
		arg_141_1.duration_ = 4.4

		local var_141_0 = {
			zh = 3.433,
			ja = 4.4
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
				arg_141_0:Play319851035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = arg_141_1.actors_["1084ui_story"].transform
			local var_144_1 = 0

			if var_144_1 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 then
				arg_141_1.var_.moveOldPos1084ui_story = var_144_0.localPosition
			end

			local var_144_2 = 0.001

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_2 then
				local var_144_3 = (arg_141_1.time_ - var_144_1) / var_144_2
				local var_144_4 = Vector3.New(-0.7, -0.97, -6)

				var_144_0.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos1084ui_story, var_144_4, var_144_3)

				local var_144_5 = manager.ui.mainCamera.transform.position - var_144_0.position

				var_144_0.forward = Vector3.New(var_144_5.x, var_144_5.y, var_144_5.z)

				local var_144_6 = var_144_0.localEulerAngles

				var_144_6.z = 0
				var_144_6.x = 0
				var_144_0.localEulerAngles = var_144_6
			end

			if arg_141_1.time_ >= var_144_1 + var_144_2 and arg_141_1.time_ < var_144_1 + var_144_2 + arg_144_0 then
				var_144_0.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_144_7 = manager.ui.mainCamera.transform.position - var_144_0.position

				var_144_0.forward = Vector3.New(var_144_7.x, var_144_7.y, var_144_7.z)

				local var_144_8 = var_144_0.localEulerAngles

				var_144_8.z = 0
				var_144_8.x = 0
				var_144_0.localEulerAngles = var_144_8
			end

			local var_144_9 = arg_141_1.actors_["1084ui_story"]
			local var_144_10 = 0

			if var_144_10 < arg_141_1.time_ and arg_141_1.time_ <= var_144_10 + arg_144_0 and not isNil(var_144_9) and arg_141_1.var_.characterEffect1084ui_story == nil then
				arg_141_1.var_.characterEffect1084ui_story = var_144_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_11 = 0.200000002980232

			if var_144_10 <= arg_141_1.time_ and arg_141_1.time_ < var_144_10 + var_144_11 and not isNil(var_144_9) then
				local var_144_12 = (arg_141_1.time_ - var_144_10) / var_144_11

				if arg_141_1.var_.characterEffect1084ui_story and not isNil(var_144_9) then
					arg_141_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= var_144_10 + var_144_11 and arg_141_1.time_ < var_144_10 + var_144_11 + arg_144_0 and not isNil(var_144_9) and arg_141_1.var_.characterEffect1084ui_story then
				arg_141_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_144_13 = 0

			if var_144_13 < arg_141_1.time_ and arg_141_1.time_ <= var_144_13 + arg_144_0 then
				arg_141_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			local var_144_14 = 0

			if var_144_14 < arg_141_1.time_ and arg_141_1.time_ <= var_144_14 + arg_144_0 then
				arg_141_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_144_15 = arg_141_1.actors_["10058ui_story"]
			local var_144_16 = 0

			if var_144_16 < arg_141_1.time_ and arg_141_1.time_ <= var_144_16 + arg_144_0 and not isNil(var_144_15) and arg_141_1.var_.characterEffect10058ui_story == nil then
				arg_141_1.var_.characterEffect10058ui_story = var_144_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_17 = 0.200000002980232

			if var_144_16 <= arg_141_1.time_ and arg_141_1.time_ < var_144_16 + var_144_17 and not isNil(var_144_15) then
				local var_144_18 = (arg_141_1.time_ - var_144_16) / var_144_17

				if arg_141_1.var_.characterEffect10058ui_story and not isNil(var_144_15) then
					local var_144_19 = Mathf.Lerp(0, 0.5, var_144_18)

					arg_141_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_141_1.var_.characterEffect10058ui_story.fillRatio = var_144_19
				end
			end

			if arg_141_1.time_ >= var_144_16 + var_144_17 and arg_141_1.time_ < var_144_16 + var_144_17 + arg_144_0 and not isNil(var_144_15) and arg_141_1.var_.characterEffect10058ui_story then
				local var_144_20 = 0.5

				arg_141_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_141_1.var_.characterEffect10058ui_story.fillRatio = var_144_20
			end

			local var_144_21 = 0
			local var_144_22 = 0.4

			if var_144_21 < arg_141_1.time_ and arg_141_1.time_ <= var_144_21 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_23 = arg_141_1:FormatText(StoryNameCfg[6].name)

				arg_141_1.leftNameTxt_.text = var_144_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_24 = arg_141_1:GetWordFromCfg(319851034)
				local var_144_25 = arg_141_1:FormatText(var_144_24.content)

				arg_141_1.text_.text = var_144_25

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_26 = 16
				local var_144_27 = utf8.len(var_144_25)
				local var_144_28 = var_144_26 <= 0 and var_144_22 or var_144_22 * (var_144_27 / var_144_26)

				if var_144_28 > 0 and var_144_22 < var_144_28 then
					arg_141_1.talkMaxDuration = var_144_28

					if var_144_28 + var_144_21 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_28 + var_144_21
					end
				end

				arg_141_1.text_.text = var_144_25
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319851", "319851034", "story_v_out_319851.awb") ~= 0 then
					local var_144_29 = manager.audio:GetVoiceLength("story_v_out_319851", "319851034", "story_v_out_319851.awb") / 1000

					if var_144_29 + var_144_21 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_29 + var_144_21
					end

					if var_144_24.prefab_name ~= "" and arg_141_1.actors_[var_144_24.prefab_name] ~= nil then
						local var_144_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_24.prefab_name].transform, "story_v_out_319851", "319851034", "story_v_out_319851.awb")

						arg_141_1:RecordAudio("319851034", var_144_30)
						arg_141_1:RecordAudio("319851034", var_144_30)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_319851", "319851034", "story_v_out_319851.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_319851", "319851034", "story_v_out_319851.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_31 = math.max(var_144_22, arg_141_1.talkMaxDuration)

			if var_144_21 <= arg_141_1.time_ and arg_141_1.time_ < var_144_21 + var_144_31 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_21) / var_144_31

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_21 + var_144_31 and arg_141_1.time_ < var_144_21 + var_144_31 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
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

		arg_141_1:InitPlayNodeList()
	end,
	Play319851035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 319851035
		arg_145_1.duration_ = 14.87

		local var_145_0 = {
			zh = 10.1,
			ja = 14.866
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
				arg_145_0:Play319851036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = arg_145_1.actors_["1084ui_story"]
			local var_148_1 = 0

			if var_148_1 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 and not isNil(var_148_0) and arg_145_1.var_.characterEffect1084ui_story == nil then
				arg_145_1.var_.characterEffect1084ui_story = var_148_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_2 = 0.200000002980232

			if var_148_1 <= arg_145_1.time_ and arg_145_1.time_ < var_148_1 + var_148_2 and not isNil(var_148_0) then
				local var_148_3 = (arg_145_1.time_ - var_148_1) / var_148_2

				if arg_145_1.var_.characterEffect1084ui_story and not isNil(var_148_0) then
					local var_148_4 = Mathf.Lerp(0, 0.5, var_148_3)

					arg_145_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_145_1.var_.characterEffect1084ui_story.fillRatio = var_148_4
				end
			end

			if arg_145_1.time_ >= var_148_1 + var_148_2 and arg_145_1.time_ < var_148_1 + var_148_2 + arg_148_0 and not isNil(var_148_0) and arg_145_1.var_.characterEffect1084ui_story then
				local var_148_5 = 0.5

				arg_145_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_145_1.var_.characterEffect1084ui_story.fillRatio = var_148_5
			end

			local var_148_6 = arg_145_1.actors_["10058ui_story"]
			local var_148_7 = 0

			if var_148_7 < arg_145_1.time_ and arg_145_1.time_ <= var_148_7 + arg_148_0 and not isNil(var_148_6) and arg_145_1.var_.characterEffect10058ui_story == nil then
				arg_145_1.var_.characterEffect10058ui_story = var_148_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_8 = 0.200000002980232

			if var_148_7 <= arg_145_1.time_ and arg_145_1.time_ < var_148_7 + var_148_8 and not isNil(var_148_6) then
				local var_148_9 = (arg_145_1.time_ - var_148_7) / var_148_8

				if arg_145_1.var_.characterEffect10058ui_story and not isNil(var_148_6) then
					arg_145_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_145_1.time_ >= var_148_7 + var_148_8 and arg_145_1.time_ < var_148_7 + var_148_8 + arg_148_0 and not isNil(var_148_6) and arg_145_1.var_.characterEffect10058ui_story then
				arg_145_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_148_10 = 0
			local var_148_11 = 1

			if var_148_10 < arg_145_1.time_ and arg_145_1.time_ <= var_148_10 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				local var_148_12 = arg_145_1:FormatText(StoryNameCfg[471].name)

				arg_145_1.leftNameTxt_.text = var_148_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_13 = arg_145_1:GetWordFromCfg(319851035)
				local var_148_14 = arg_145_1:FormatText(var_148_13.content)

				arg_145_1.text_.text = var_148_14

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_15 = 40
				local var_148_16 = utf8.len(var_148_14)
				local var_148_17 = var_148_15 <= 0 and var_148_11 or var_148_11 * (var_148_16 / var_148_15)

				if var_148_17 > 0 and var_148_11 < var_148_17 then
					arg_145_1.talkMaxDuration = var_148_17

					if var_148_17 + var_148_10 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_17 + var_148_10
					end
				end

				arg_145_1.text_.text = var_148_14
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319851", "319851035", "story_v_out_319851.awb") ~= 0 then
					local var_148_18 = manager.audio:GetVoiceLength("story_v_out_319851", "319851035", "story_v_out_319851.awb") / 1000

					if var_148_18 + var_148_10 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_18 + var_148_10
					end

					if var_148_13.prefab_name ~= "" and arg_145_1.actors_[var_148_13.prefab_name] ~= nil then
						local var_148_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_13.prefab_name].transform, "story_v_out_319851", "319851035", "story_v_out_319851.awb")

						arg_145_1:RecordAudio("319851035", var_148_19)
						arg_145_1:RecordAudio("319851035", var_148_19)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_319851", "319851035", "story_v_out_319851.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_319851", "319851035", "story_v_out_319851.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_20 = math.max(var_148_11, arg_145_1.talkMaxDuration)

			if var_148_10 <= arg_145_1.time_ and arg_145_1.time_ < var_148_10 + var_148_20 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_10) / var_148_20

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_10 + var_148_20 and arg_145_1.time_ < var_148_10 + var_148_20 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play319851036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 319851036
		arg_149_1.duration_ = 14.1

		local var_149_0 = {
			zh = 10,
			ja = 14.1
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
			arg_149_1.auto_ = false
		end

		function arg_149_1.playNext_(arg_151_0)
			arg_149_1.onStoryFinished_()
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = 0
			local var_152_1 = 0.975

			if var_152_0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_0 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				local var_152_2 = arg_149_1:FormatText(StoryNameCfg[471].name)

				arg_149_1.leftNameTxt_.text = var_152_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_3 = arg_149_1:GetWordFromCfg(319851036)
				local var_152_4 = arg_149_1:FormatText(var_152_3.content)

				arg_149_1.text_.text = var_152_4

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_5 = 39
				local var_152_6 = utf8.len(var_152_4)
				local var_152_7 = var_152_5 <= 0 and var_152_1 or var_152_1 * (var_152_6 / var_152_5)

				if var_152_7 > 0 and var_152_1 < var_152_7 then
					arg_149_1.talkMaxDuration = var_152_7

					if var_152_7 + var_152_0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_7 + var_152_0
					end
				end

				arg_149_1.text_.text = var_152_4
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319851", "319851036", "story_v_out_319851.awb") ~= 0 then
					local var_152_8 = manager.audio:GetVoiceLength("story_v_out_319851", "319851036", "story_v_out_319851.awb") / 1000

					if var_152_8 + var_152_0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_8 + var_152_0
					end

					if var_152_3.prefab_name ~= "" and arg_149_1.actors_[var_152_3.prefab_name] ~= nil then
						local var_152_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_3.prefab_name].transform, "story_v_out_319851", "319851036", "story_v_out_319851.awb")

						arg_149_1:RecordAudio("319851036", var_152_9)
						arg_149_1:RecordAudio("319851036", var_152_9)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_319851", "319851036", "story_v_out_319851.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_319851", "319851036", "story_v_out_319851.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_10 = math.max(var_152_1, arg_149_1.talkMaxDuration)

			if var_152_0 <= arg_149_1.time_ and arg_149_1.time_ < var_152_0 + var_152_10 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_0) / var_152_10

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_0 + var_152_10 and arg_149_1.time_ < var_152_0 + var_152_10 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/I11o",
		"TextureConfig/Background/ML0205"
	},
	voices = {
		"story_v_out_319851.awb"
	}
}
