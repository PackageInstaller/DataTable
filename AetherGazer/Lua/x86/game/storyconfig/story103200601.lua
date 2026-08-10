return {
	Play320061001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 320061001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play320061002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST61"

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
				local var_4_5 = arg_1_1.bgs_.ST61

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
					if iter_4_0 ~= "ST61" then
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

			local var_4_30 = 0.466666666666667
			local var_4_31 = 1

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				local var_4_32 = "play"
				local var_4_33 = "music"

				arg_1_1:AudioAction(var_4_32, var_4_33, "bgm_activity_2_8_story_meruism", "bgm_activity_2_8_story_meruism", "bgm_activity_2_8_story_meruism.awb")

				local var_4_34 = ""
				local var_4_35 = manager.audio:GetAudioName("bgm_activity_2_8_story_meruism", "bgm_activity_2_8_story_meruism")

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
			local var_4_37 = 1.25

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

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_39 = arg_1_1:GetWordFromCfg(320061001)
				local var_4_40 = arg_1_1:FormatText(var_4_39.content)

				arg_1_1.text_.text = var_4_40

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_41 = 50
				local var_4_42 = utf8.len(var_4_40)
				local var_4_43 = var_4_41 <= 0 and var_4_37 or var_4_37 * (var_4_42 / var_4_41)

				if var_4_43 > 0 and var_4_37 < var_4_43 then
					arg_1_1.talkMaxDuration = var_4_43
					var_4_36 = var_4_36 + 0.3

					if var_4_43 + var_4_36 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_43 + var_4_36
					end
				end

				arg_1_1.text_.text = var_4_40
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_44 = var_4_36 + 0.3
			local var_4_45 = math.max(var_4_37, arg_1_1.talkMaxDuration)

			if var_4_44 <= arg_1_1.time_ and arg_1_1.time_ < var_4_44 + var_4_45 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_44) / var_4_45

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_44 + var_4_45 and arg_1_1.time_ < var_4_44 + var_4_45 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play320061002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 320061002
		arg_9_1.duration_ = 1.37

		local var_9_0 = {
			zh = 1.1,
			ja = 1.366
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
				arg_9_0:Play320061003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 0.075

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
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_3 = arg_9_1:GetWordFromCfg(320061002)
				local var_12_4 = arg_9_1:FormatText(var_12_3.content)

				arg_9_1.text_.text = var_12_4

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_5 = 3
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

				if manager.audio:GetVoiceLength("story_v_out_320061", "320061002", "story_v_out_320061.awb") ~= 0 then
					local var_12_8 = manager.audio:GetVoiceLength("story_v_out_320061", "320061002", "story_v_out_320061.awb") / 1000

					if var_12_8 + var_12_0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_8 + var_12_0
					end

					if var_12_3.prefab_name ~= "" and arg_9_1.actors_[var_12_3.prefab_name] ~= nil then
						local var_12_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_3.prefab_name].transform, "story_v_out_320061", "320061002", "story_v_out_320061.awb")

						arg_9_1:RecordAudio("320061002", var_12_9)
						arg_9_1:RecordAudio("320061002", var_12_9)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_320061", "320061002", "story_v_out_320061.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_320061", "320061002", "story_v_out_320061.awb")
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
	Play320061003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 320061003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play320061004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0
			local var_16_1 = 1.45

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

				local var_16_2 = arg_13_1:GetWordFromCfg(320061003)
				local var_16_3 = arg_13_1:FormatText(var_16_2.content)

				arg_13_1.text_.text = var_16_3

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 58
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
	Play320061004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 320061004
		arg_17_1.duration_ = 13.6

		local var_17_0 = {
			zh = 10.033,
			ja = 13.6
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
				arg_17_0:Play320061005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = "1061ui_story"

			if arg_17_1.actors_[var_20_0] == nil then
				local var_20_1 = Asset.Load("Char/" .. "1061ui_story")

				if not isNil(var_20_1) then
					local var_20_2 = Object.Instantiate(Asset.Load("Char/" .. "1061ui_story"), arg_17_1.stage_.transform)

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

			local var_20_5 = arg_17_1.actors_["1061ui_story"].transform
			local var_20_6 = 0

			if var_20_6 < arg_17_1.time_ and arg_17_1.time_ <= var_20_6 + arg_20_0 then
				arg_17_1.var_.moveOldPos1061ui_story = var_20_5.localPosition
			end

			local var_20_7 = 0.001

			if var_20_6 <= arg_17_1.time_ and arg_17_1.time_ < var_20_6 + var_20_7 then
				local var_20_8 = (arg_17_1.time_ - var_20_6) / var_20_7
				local var_20_9 = Vector3.New(0, -1.18, -6.15)

				var_20_5.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1061ui_story, var_20_9, var_20_8)

				local var_20_10 = manager.ui.mainCamera.transform.position - var_20_5.position

				var_20_5.forward = Vector3.New(var_20_10.x, var_20_10.y, var_20_10.z)

				local var_20_11 = var_20_5.localEulerAngles

				var_20_11.z = 0
				var_20_11.x = 0
				var_20_5.localEulerAngles = var_20_11
			end

			if arg_17_1.time_ >= var_20_6 + var_20_7 and arg_17_1.time_ < var_20_6 + var_20_7 + arg_20_0 then
				var_20_5.localPosition = Vector3.New(0, -1.18, -6.15)

				local var_20_12 = manager.ui.mainCamera.transform.position - var_20_5.position

				var_20_5.forward = Vector3.New(var_20_12.x, var_20_12.y, var_20_12.z)

				local var_20_13 = var_20_5.localEulerAngles

				var_20_13.z = 0
				var_20_13.x = 0
				var_20_5.localEulerAngles = var_20_13
			end

			local var_20_14 = arg_17_1.actors_["1061ui_story"]
			local var_20_15 = 0

			if var_20_15 < arg_17_1.time_ and arg_17_1.time_ <= var_20_15 + arg_20_0 and not isNil(var_20_14) and arg_17_1.var_.characterEffect1061ui_story == nil then
				arg_17_1.var_.characterEffect1061ui_story = var_20_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_16 = 0.200000002980232

			if var_20_15 <= arg_17_1.time_ and arg_17_1.time_ < var_20_15 + var_20_16 and not isNil(var_20_14) then
				local var_20_17 = (arg_17_1.time_ - var_20_15) / var_20_16

				if arg_17_1.var_.characterEffect1061ui_story and not isNil(var_20_14) then
					arg_17_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= var_20_15 + var_20_16 and arg_17_1.time_ < var_20_15 + var_20_16 + arg_20_0 and not isNil(var_20_14) and arg_17_1.var_.characterEffect1061ui_story then
				arg_17_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_20_18 = 0

			if var_20_18 < arg_17_1.time_ and arg_17_1.time_ <= var_20_18 + arg_20_0 then
				arg_17_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action1_1")
			end

			local var_20_19 = 0

			if var_20_19 < arg_17_1.time_ and arg_17_1.time_ <= var_20_19 + arg_20_0 then
				arg_17_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_20_20 = 0
			local var_20_21 = 1.05

			if var_20_20 < arg_17_1.time_ and arg_17_1.time_ <= var_20_20 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_22 = arg_17_1:FormatText(StoryNameCfg[612].name)

				arg_17_1.leftNameTxt_.text = var_20_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_23 = arg_17_1:GetWordFromCfg(320061004)
				local var_20_24 = arg_17_1:FormatText(var_20_23.content)

				arg_17_1.text_.text = var_20_24

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_25 = 42
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

				if manager.audio:GetVoiceLength("story_v_out_320061", "320061004", "story_v_out_320061.awb") ~= 0 then
					local var_20_28 = manager.audio:GetVoiceLength("story_v_out_320061", "320061004", "story_v_out_320061.awb") / 1000

					if var_20_28 + var_20_20 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_28 + var_20_20
					end

					if var_20_23.prefab_name ~= "" and arg_17_1.actors_[var_20_23.prefab_name] ~= nil then
						local var_20_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_23.prefab_name].transform, "story_v_out_320061", "320061004", "story_v_out_320061.awb")

						arg_17_1:RecordAudio("320061004", var_20_29)
						arg_17_1:RecordAudio("320061004", var_20_29)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_320061", "320061004", "story_v_out_320061.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_320061", "320061004", "story_v_out_320061.awb")
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
				actorName = "1061ui_story",
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
	Play320061005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 320061005
		arg_21_1.duration_ = 8.6

		local var_21_0 = {
			zh = 5.766,
			ja = 8.6
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
				arg_21_0:Play320061006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0

			if var_24_0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_0 + arg_24_0 then
				arg_21_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action2_1")
			end

			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_24_2 = 0
			local var_24_3 = 0.8

			if var_24_2 < arg_21_1.time_ and arg_21_1.time_ <= var_24_2 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_4 = arg_21_1:FormatText(StoryNameCfg[612].name)

				arg_21_1.leftNameTxt_.text = var_24_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_5 = arg_21_1:GetWordFromCfg(320061005)
				local var_24_6 = arg_21_1:FormatText(var_24_5.content)

				arg_21_1.text_.text = var_24_6

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_7 = 32
				local var_24_8 = utf8.len(var_24_6)
				local var_24_9 = var_24_7 <= 0 and var_24_3 or var_24_3 * (var_24_8 / var_24_7)

				if var_24_9 > 0 and var_24_3 < var_24_9 then
					arg_21_1.talkMaxDuration = var_24_9

					if var_24_9 + var_24_2 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_9 + var_24_2
					end
				end

				arg_21_1.text_.text = var_24_6
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320061", "320061005", "story_v_out_320061.awb") ~= 0 then
					local var_24_10 = manager.audio:GetVoiceLength("story_v_out_320061", "320061005", "story_v_out_320061.awb") / 1000

					if var_24_10 + var_24_2 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_10 + var_24_2
					end

					if var_24_5.prefab_name ~= "" and arg_21_1.actors_[var_24_5.prefab_name] ~= nil then
						local var_24_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_5.prefab_name].transform, "story_v_out_320061", "320061005", "story_v_out_320061.awb")

						arg_21_1:RecordAudio("320061005", var_24_11)
						arg_21_1:RecordAudio("320061005", var_24_11)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_320061", "320061005", "story_v_out_320061.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_320061", "320061005", "story_v_out_320061.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_12 = math.max(var_24_3, arg_21_1.talkMaxDuration)

			if var_24_2 <= arg_21_1.time_ and arg_21_1.time_ < var_24_2 + var_24_12 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_2) / var_24_12

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_2 + var_24_12 and arg_21_1.time_ < var_24_2 + var_24_12 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play320061006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 320061006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play320061007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["1061ui_story"]
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect1061ui_story == nil then
				arg_25_1.var_.characterEffect1061ui_story = var_28_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_2 = 0.200000002980232

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 and not isNil(var_28_0) then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2

				if arg_25_1.var_.characterEffect1061ui_story and not isNil(var_28_0) then
					local var_28_4 = Mathf.Lerp(0, 0.5, var_28_3)

					arg_25_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_25_1.var_.characterEffect1061ui_story.fillRatio = var_28_4
				end
			end

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect1061ui_story then
				local var_28_5 = 0.5

				arg_25_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_25_1.var_.characterEffect1061ui_story.fillRatio = var_28_5
			end

			local var_28_6 = 0
			local var_28_7 = 0.4

			if var_28_6 < arg_25_1.time_ and arg_25_1.time_ <= var_28_6 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_8 = arg_25_1:FormatText(StoryNameCfg[7].name)

				arg_25_1.leftNameTxt_.text = var_28_8

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

				local var_28_9 = arg_25_1:GetWordFromCfg(320061006)
				local var_28_10 = arg_25_1:FormatText(var_28_9.content)

				arg_25_1.text_.text = var_28_10

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_11 = 16
				local var_28_12 = utf8.len(var_28_10)
				local var_28_13 = var_28_11 <= 0 and var_28_7 or var_28_7 * (var_28_12 / var_28_11)

				if var_28_13 > 0 and var_28_7 < var_28_13 then
					arg_25_1.talkMaxDuration = var_28_13

					if var_28_13 + var_28_6 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_13 + var_28_6
					end
				end

				arg_25_1.text_.text = var_28_10
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_14 = math.max(var_28_7, arg_25_1.talkMaxDuration)

			if var_28_6 <= arg_25_1.time_ and arg_25_1.time_ < var_28_6 + var_28_14 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_6) / var_28_14

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_6 + var_28_14 and arg_25_1.time_ < var_28_6 + var_28_14 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play320061007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 320061007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play320061008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0
			local var_32_1 = 0.975

			if var_32_0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, false)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_2 = arg_29_1:GetWordFromCfg(320061007)
				local var_32_3 = arg_29_1:FormatText(var_32_2.content)

				arg_29_1.text_.text = var_32_3

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_4 = 39
				local var_32_5 = utf8.len(var_32_3)
				local var_32_6 = var_32_4 <= 0 and var_32_1 or var_32_1 * (var_32_5 / var_32_4)

				if var_32_6 > 0 and var_32_1 < var_32_6 then
					arg_29_1.talkMaxDuration = var_32_6

					if var_32_6 + var_32_0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_6 + var_32_0
					end
				end

				arg_29_1.text_.text = var_32_3
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_7 = math.max(var_32_1, arg_29_1.talkMaxDuration)

			if var_32_0 <= arg_29_1.time_ and arg_29_1.time_ < var_32_0 + var_32_7 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_0) / var_32_7

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_0 + var_32_7 and arg_29_1.time_ < var_32_0 + var_32_7 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play320061008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 320061008
		arg_33_1.duration_ = 9.3

		local var_33_0 = {
			zh = 6.066,
			ja = 9.3
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
				arg_33_0:Play320061009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["1061ui_story"]
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect1061ui_story == nil then
				arg_33_1.var_.characterEffect1061ui_story = var_36_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_2 = 0.200000002980232

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 and not isNil(var_36_0) then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2

				if arg_33_1.var_.characterEffect1061ui_story and not isNil(var_36_0) then
					arg_33_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect1061ui_story then
				arg_33_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_36_4 = 0

			if var_36_4 < arg_33_1.time_ and arg_33_1.time_ <= var_36_4 + arg_36_0 then
				arg_33_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action2_2")
			end

			local var_36_5 = 0

			if var_36_5 < arg_33_1.time_ and arg_33_1.time_ <= var_36_5 + arg_36_0 then
				arg_33_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_36_6 = 0
			local var_36_7 = 0.85

			if var_36_6 < arg_33_1.time_ and arg_33_1.time_ <= var_36_6 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_8 = arg_33_1:FormatText(StoryNameCfg[612].name)

				arg_33_1.leftNameTxt_.text = var_36_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_9 = arg_33_1:GetWordFromCfg(320061008)
				local var_36_10 = arg_33_1:FormatText(var_36_9.content)

				arg_33_1.text_.text = var_36_10

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_11 = 34
				local var_36_12 = utf8.len(var_36_10)
				local var_36_13 = var_36_11 <= 0 and var_36_7 or var_36_7 * (var_36_12 / var_36_11)

				if var_36_13 > 0 and var_36_7 < var_36_13 then
					arg_33_1.talkMaxDuration = var_36_13

					if var_36_13 + var_36_6 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_13 + var_36_6
					end
				end

				arg_33_1.text_.text = var_36_10
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320061", "320061008", "story_v_out_320061.awb") ~= 0 then
					local var_36_14 = manager.audio:GetVoiceLength("story_v_out_320061", "320061008", "story_v_out_320061.awb") / 1000

					if var_36_14 + var_36_6 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_14 + var_36_6
					end

					if var_36_9.prefab_name ~= "" and arg_33_1.actors_[var_36_9.prefab_name] ~= nil then
						local var_36_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_9.prefab_name].transform, "story_v_out_320061", "320061008", "story_v_out_320061.awb")

						arg_33_1:RecordAudio("320061008", var_36_15)
						arg_33_1:RecordAudio("320061008", var_36_15)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_320061", "320061008", "story_v_out_320061.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_320061", "320061008", "story_v_out_320061.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_16 = math.max(var_36_7, arg_33_1.talkMaxDuration)

			if var_36_6 <= arg_33_1.time_ and arg_33_1.time_ < var_36_6 + var_36_16 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_6) / var_36_16

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_6 + var_36_16 and arg_33_1.time_ < var_36_6 + var_36_16 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play320061009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 320061009
		arg_37_1.duration_ = 14.73

		local var_37_0 = {
			zh = 9.566,
			ja = 14.733
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
				arg_37_0:Play320061010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0

			if var_40_0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_0 + arg_40_0 then
				arg_37_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_40_1 = 0
			local var_40_2 = 1.175

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_3 = arg_37_1:FormatText(StoryNameCfg[612].name)

				arg_37_1.leftNameTxt_.text = var_40_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_4 = arg_37_1:GetWordFromCfg(320061009)
				local var_40_5 = arg_37_1:FormatText(var_40_4.content)

				arg_37_1.text_.text = var_40_5

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_6 = 47
				local var_40_7 = utf8.len(var_40_5)
				local var_40_8 = var_40_6 <= 0 and var_40_2 or var_40_2 * (var_40_7 / var_40_6)

				if var_40_8 > 0 and var_40_2 < var_40_8 then
					arg_37_1.talkMaxDuration = var_40_8

					if var_40_8 + var_40_1 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_8 + var_40_1
					end
				end

				arg_37_1.text_.text = var_40_5
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320061", "320061009", "story_v_out_320061.awb") ~= 0 then
					local var_40_9 = manager.audio:GetVoiceLength("story_v_out_320061", "320061009", "story_v_out_320061.awb") / 1000

					if var_40_9 + var_40_1 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_9 + var_40_1
					end

					if var_40_4.prefab_name ~= "" and arg_37_1.actors_[var_40_4.prefab_name] ~= nil then
						local var_40_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_4.prefab_name].transform, "story_v_out_320061", "320061009", "story_v_out_320061.awb")

						arg_37_1:RecordAudio("320061009", var_40_10)
						arg_37_1:RecordAudio("320061009", var_40_10)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_320061", "320061009", "story_v_out_320061.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_320061", "320061009", "story_v_out_320061.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_11 = math.max(var_40_2, arg_37_1.talkMaxDuration)

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_11 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_1) / var_40_11

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_1 + var_40_11 and arg_37_1.time_ < var_40_1 + var_40_11 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play320061010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 320061010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play320061011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["1061ui_story"]
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1061ui_story == nil then
				arg_41_1.var_.characterEffect1061ui_story = var_44_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.200000002980232

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 and not isNil(var_44_0) then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2

				if arg_41_1.var_.characterEffect1061ui_story and not isNil(var_44_0) then
					local var_44_4 = Mathf.Lerp(0, 0.5, var_44_3)

					arg_41_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_41_1.var_.characterEffect1061ui_story.fillRatio = var_44_4
				end
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1061ui_story then
				local var_44_5 = 0.5

				arg_41_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_41_1.var_.characterEffect1061ui_story.fillRatio = var_44_5
			end

			local var_44_6 = 0
			local var_44_7 = 0.975

			if var_44_6 < arg_41_1.time_ and arg_41_1.time_ <= var_44_6 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_8 = arg_41_1:FormatText(StoryNameCfg[7].name)

				arg_41_1.leftNameTxt_.text = var_44_8

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

				local var_44_9 = arg_41_1:GetWordFromCfg(320061010)
				local var_44_10 = arg_41_1:FormatText(var_44_9.content)

				arg_41_1.text_.text = var_44_10

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_11 = 39
				local var_44_12 = utf8.len(var_44_10)
				local var_44_13 = var_44_11 <= 0 and var_44_7 or var_44_7 * (var_44_12 / var_44_11)

				if var_44_13 > 0 and var_44_7 < var_44_13 then
					arg_41_1.talkMaxDuration = var_44_13

					if var_44_13 + var_44_6 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_13 + var_44_6
					end
				end

				arg_41_1.text_.text = var_44_10
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_14 = math.max(var_44_7, arg_41_1.talkMaxDuration)

			if var_44_6 <= arg_41_1.time_ and arg_41_1.time_ < var_44_6 + var_44_14 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_6) / var_44_14

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_6 + var_44_14 and arg_41_1.time_ < var_44_6 + var_44_14 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play320061011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 320061011
		arg_45_1.duration_ = 11.6

		local var_45_0 = {
			zh = 8.566,
			ja = 11.6
		}
		local var_45_1 = manager.audio:GetLocalizationFlag()

		if var_45_0[var_45_1] ~= nil then
			arg_45_1.duration_ = var_45_0[var_45_1]
		end

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play320061012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["1061ui_story"]
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect1061ui_story == nil then
				arg_45_1.var_.characterEffect1061ui_story = var_48_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_2 = 0.200000002980232

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 and not isNil(var_48_0) then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2

				if arg_45_1.var_.characterEffect1061ui_story and not isNil(var_48_0) then
					arg_45_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect1061ui_story then
				arg_45_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_48_4 = 0

			if var_48_4 < arg_45_1.time_ and arg_45_1.time_ <= var_48_4 + arg_48_0 then
				arg_45_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action5_1")
			end

			local var_48_5 = 0

			if var_48_5 < arg_45_1.time_ and arg_45_1.time_ <= var_48_5 + arg_48_0 then
				arg_45_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_48_6 = 0
			local var_48_7 = 0.825

			if var_48_6 < arg_45_1.time_ and arg_45_1.time_ <= var_48_6 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_8 = arg_45_1:FormatText(StoryNameCfg[612].name)

				arg_45_1.leftNameTxt_.text = var_48_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_9 = arg_45_1:GetWordFromCfg(320061011)
				local var_48_10 = arg_45_1:FormatText(var_48_9.content)

				arg_45_1.text_.text = var_48_10

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_11 = 33
				local var_48_12 = utf8.len(var_48_10)
				local var_48_13 = var_48_11 <= 0 and var_48_7 or var_48_7 * (var_48_12 / var_48_11)

				if var_48_13 > 0 and var_48_7 < var_48_13 then
					arg_45_1.talkMaxDuration = var_48_13

					if var_48_13 + var_48_6 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_13 + var_48_6
					end
				end

				arg_45_1.text_.text = var_48_10
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320061", "320061011", "story_v_out_320061.awb") ~= 0 then
					local var_48_14 = manager.audio:GetVoiceLength("story_v_out_320061", "320061011", "story_v_out_320061.awb") / 1000

					if var_48_14 + var_48_6 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_14 + var_48_6
					end

					if var_48_9.prefab_name ~= "" and arg_45_1.actors_[var_48_9.prefab_name] ~= nil then
						local var_48_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_9.prefab_name].transform, "story_v_out_320061", "320061011", "story_v_out_320061.awb")

						arg_45_1:RecordAudio("320061011", var_48_15)
						arg_45_1:RecordAudio("320061011", var_48_15)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_320061", "320061011", "story_v_out_320061.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_320061", "320061011", "story_v_out_320061.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_16 = math.max(var_48_7, arg_45_1.talkMaxDuration)

			if var_48_6 <= arg_45_1.time_ and arg_45_1.time_ < var_48_6 + var_48_16 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_6) / var_48_16

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_6 + var_48_16 and arg_45_1.time_ < var_48_6 + var_48_16 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play320061012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 320061012
		arg_49_1.duration_ = 10.2

		local var_49_0 = {
			zh = 9.1,
			ja = 10.2
		}
		local var_49_1 = manager.audio:GetLocalizationFlag()

		if var_49_0[var_49_1] ~= nil then
			arg_49_1.duration_ = var_49_0[var_49_1]
		end

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play320061013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0

			if var_52_0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_0 + arg_52_0 then
				arg_49_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action5_2")
			end

			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 then
				arg_49_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_52_2 = 0
			local var_52_3 = 0.975

			if var_52_2 < arg_49_1.time_ and arg_49_1.time_ <= var_52_2 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_4 = arg_49_1:FormatText(StoryNameCfg[612].name)

				arg_49_1.leftNameTxt_.text = var_52_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_5 = arg_49_1:GetWordFromCfg(320061012)
				local var_52_6 = arg_49_1:FormatText(var_52_5.content)

				arg_49_1.text_.text = var_52_6

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_7 = 39
				local var_52_8 = utf8.len(var_52_6)
				local var_52_9 = var_52_7 <= 0 and var_52_3 or var_52_3 * (var_52_8 / var_52_7)

				if var_52_9 > 0 and var_52_3 < var_52_9 then
					arg_49_1.talkMaxDuration = var_52_9

					if var_52_9 + var_52_2 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_9 + var_52_2
					end
				end

				arg_49_1.text_.text = var_52_6
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320061", "320061012", "story_v_out_320061.awb") ~= 0 then
					local var_52_10 = manager.audio:GetVoiceLength("story_v_out_320061", "320061012", "story_v_out_320061.awb") / 1000

					if var_52_10 + var_52_2 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_10 + var_52_2
					end

					if var_52_5.prefab_name ~= "" and arg_49_1.actors_[var_52_5.prefab_name] ~= nil then
						local var_52_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_5.prefab_name].transform, "story_v_out_320061", "320061012", "story_v_out_320061.awb")

						arg_49_1:RecordAudio("320061012", var_52_11)
						arg_49_1:RecordAudio("320061012", var_52_11)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_320061", "320061012", "story_v_out_320061.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_320061", "320061012", "story_v_out_320061.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_12 = math.max(var_52_3, arg_49_1.talkMaxDuration)

			if var_52_2 <= arg_49_1.time_ and arg_49_1.time_ < var_52_2 + var_52_12 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_2) / var_52_12

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_2 + var_52_12 and arg_49_1.time_ < var_52_2 + var_52_12 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play320061013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 320061013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play320061014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["1061ui_story"]
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.characterEffect1061ui_story == nil then
				arg_53_1.var_.characterEffect1061ui_story = var_56_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_2 = 0.2

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_2 and not isNil(var_56_0) then
				local var_56_3 = (arg_53_1.time_ - var_56_1) / var_56_2

				if arg_53_1.var_.characterEffect1061ui_story and not isNil(var_56_0) then
					local var_56_4 = Mathf.Lerp(0, 0.5, var_56_3)

					arg_53_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_53_1.var_.characterEffect1061ui_story.fillRatio = var_56_4
				end
			end

			if arg_53_1.time_ >= var_56_1 + var_56_2 and arg_53_1.time_ < var_56_1 + var_56_2 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.characterEffect1061ui_story then
				local var_56_5 = 0.5

				arg_53_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_53_1.var_.characterEffect1061ui_story.fillRatio = var_56_5
			end

			local var_56_6 = 0
			local var_56_7 = 0.275

			if var_56_6 < arg_53_1.time_ and arg_53_1.time_ <= var_56_6 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_8 = arg_53_1:FormatText(StoryNameCfg[7].name)

				arg_53_1.leftNameTxt_.text = var_56_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, true)
				arg_53_1.iconController_:SetSelectedState("hero")

				arg_53_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_53_1.callingController_:SetSelectedState("normal")

				arg_53_1.keyicon_.color = Color.New(1, 1, 1)
				arg_53_1.icon_.color = Color.New(1, 1, 1)

				local var_56_9 = arg_53_1:GetWordFromCfg(320061013)
				local var_56_10 = arg_53_1:FormatText(var_56_9.content)

				arg_53_1.text_.text = var_56_10

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_11 = 11
				local var_56_12 = utf8.len(var_56_10)
				local var_56_13 = var_56_11 <= 0 and var_56_7 or var_56_7 * (var_56_12 / var_56_11)

				if var_56_13 > 0 and var_56_7 < var_56_13 then
					arg_53_1.talkMaxDuration = var_56_13

					if var_56_13 + var_56_6 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_13 + var_56_6
					end
				end

				arg_53_1.text_.text = var_56_10
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_14 = math.max(var_56_7, arg_53_1.talkMaxDuration)

			if var_56_6 <= arg_53_1.time_ and arg_53_1.time_ < var_56_6 + var_56_14 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_6) / var_56_14

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_6 + var_56_14 and arg_53_1.time_ < var_56_6 + var_56_14 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play320061014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 320061014
		arg_57_1.duration_ = 10.53

		local var_57_0 = {
			zh = 8.6,
			ja = 10.533
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
				arg_57_0:Play320061015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["1061ui_story"]
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.characterEffect1061ui_story == nil then
				arg_57_1.var_.characterEffect1061ui_story = var_60_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_2 = 0.200000002980232

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_2 and not isNil(var_60_0) then
				local var_60_3 = (arg_57_1.time_ - var_60_1) / var_60_2

				if arg_57_1.var_.characterEffect1061ui_story and not isNil(var_60_0) then
					arg_57_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= var_60_1 + var_60_2 and arg_57_1.time_ < var_60_1 + var_60_2 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.characterEffect1061ui_story then
				arg_57_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_60_4 = 0

			if var_60_4 < arg_57_1.time_ and arg_57_1.time_ <= var_60_4 + arg_60_0 then
				arg_57_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action3_1")
			end

			local var_60_5 = 0

			if var_60_5 < arg_57_1.time_ and arg_57_1.time_ <= var_60_5 + arg_60_0 then
				arg_57_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_60_6 = 0
			local var_60_7 = 1.025

			if var_60_6 < arg_57_1.time_ and arg_57_1.time_ <= var_60_6 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_8 = arg_57_1:FormatText(StoryNameCfg[612].name)

				arg_57_1.leftNameTxt_.text = var_60_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_9 = arg_57_1:GetWordFromCfg(320061014)
				local var_60_10 = arg_57_1:FormatText(var_60_9.content)

				arg_57_1.text_.text = var_60_10

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_11 = 41
				local var_60_12 = utf8.len(var_60_10)
				local var_60_13 = var_60_11 <= 0 and var_60_7 or var_60_7 * (var_60_12 / var_60_11)

				if var_60_13 > 0 and var_60_7 < var_60_13 then
					arg_57_1.talkMaxDuration = var_60_13

					if var_60_13 + var_60_6 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_13 + var_60_6
					end
				end

				arg_57_1.text_.text = var_60_10
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320061", "320061014", "story_v_out_320061.awb") ~= 0 then
					local var_60_14 = manager.audio:GetVoiceLength("story_v_out_320061", "320061014", "story_v_out_320061.awb") / 1000

					if var_60_14 + var_60_6 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_14 + var_60_6
					end

					if var_60_9.prefab_name ~= "" and arg_57_1.actors_[var_60_9.prefab_name] ~= nil then
						local var_60_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_9.prefab_name].transform, "story_v_out_320061", "320061014", "story_v_out_320061.awb")

						arg_57_1:RecordAudio("320061014", var_60_15)
						arg_57_1:RecordAudio("320061014", var_60_15)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_320061", "320061014", "story_v_out_320061.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_320061", "320061014", "story_v_out_320061.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_16 = math.max(var_60_7, arg_57_1.talkMaxDuration)

			if var_60_6 <= arg_57_1.time_ and arg_57_1.time_ < var_60_6 + var_60_16 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_6) / var_60_16

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_6 + var_60_16 and arg_57_1.time_ < var_60_6 + var_60_16 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play320061015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 320061015
		arg_61_1.duration_ = 11.27

		local var_61_0 = {
			zh = 9,
			ja = 11.266
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
				arg_61_0:Play320061016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0

			if var_64_0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_0 + arg_64_0 then
				arg_61_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_64_1 = 0
			local var_64_2 = 0.825

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_3 = arg_61_1:FormatText(StoryNameCfg[612].name)

				arg_61_1.leftNameTxt_.text = var_64_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_4 = arg_61_1:GetWordFromCfg(320061015)
				local var_64_5 = arg_61_1:FormatText(var_64_4.content)

				arg_61_1.text_.text = var_64_5

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_6 = 33
				local var_64_7 = utf8.len(var_64_5)
				local var_64_8 = var_64_6 <= 0 and var_64_2 or var_64_2 * (var_64_7 / var_64_6)

				if var_64_8 > 0 and var_64_2 < var_64_8 then
					arg_61_1.talkMaxDuration = var_64_8

					if var_64_8 + var_64_1 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_8 + var_64_1
					end
				end

				arg_61_1.text_.text = var_64_5
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320061", "320061015", "story_v_out_320061.awb") ~= 0 then
					local var_64_9 = manager.audio:GetVoiceLength("story_v_out_320061", "320061015", "story_v_out_320061.awb") / 1000

					if var_64_9 + var_64_1 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_9 + var_64_1
					end

					if var_64_4.prefab_name ~= "" and arg_61_1.actors_[var_64_4.prefab_name] ~= nil then
						local var_64_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_4.prefab_name].transform, "story_v_out_320061", "320061015", "story_v_out_320061.awb")

						arg_61_1:RecordAudio("320061015", var_64_10)
						arg_61_1:RecordAudio("320061015", var_64_10)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_320061", "320061015", "story_v_out_320061.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_320061", "320061015", "story_v_out_320061.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_11 = math.max(var_64_2, arg_61_1.talkMaxDuration)

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_11 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_1) / var_64_11

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_1 + var_64_11 and arg_61_1.time_ < var_64_1 + var_64_11 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play320061016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 320061016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play320061017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["1061ui_story"]
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect1061ui_story == nil then
				arg_65_1.var_.characterEffect1061ui_story = var_68_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_2 = 0.200000002980232

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 and not isNil(var_68_0) then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2

				if arg_65_1.var_.characterEffect1061ui_story and not isNil(var_68_0) then
					local var_68_4 = Mathf.Lerp(0, 0.5, var_68_3)

					arg_65_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_65_1.var_.characterEffect1061ui_story.fillRatio = var_68_4
				end
			end

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect1061ui_story then
				local var_68_5 = 0.5

				arg_65_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_65_1.var_.characterEffect1061ui_story.fillRatio = var_68_5
			end

			local var_68_6 = 0
			local var_68_7 = 1.6

			if var_68_6 < arg_65_1.time_ and arg_65_1.time_ <= var_68_6 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_8 = arg_65_1:FormatText(StoryNameCfg[7].name)

				arg_65_1.leftNameTxt_.text = var_68_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, true)
				arg_65_1.iconController_:SetSelectedState("hero")

				arg_65_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_65_1.callingController_:SetSelectedState("normal")

				arg_65_1.keyicon_.color = Color.New(1, 1, 1)
				arg_65_1.icon_.color = Color.New(1, 1, 1)

				local var_68_9 = arg_65_1:GetWordFromCfg(320061016)
				local var_68_10 = arg_65_1:FormatText(var_68_9.content)

				arg_65_1.text_.text = var_68_10

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_11 = 64
				local var_68_12 = utf8.len(var_68_10)
				local var_68_13 = var_68_11 <= 0 and var_68_7 or var_68_7 * (var_68_12 / var_68_11)

				if var_68_13 > 0 and var_68_7 < var_68_13 then
					arg_65_1.talkMaxDuration = var_68_13

					if var_68_13 + var_68_6 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_13 + var_68_6
					end
				end

				arg_65_1.text_.text = var_68_10
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_14 = math.max(var_68_7, arg_65_1.talkMaxDuration)

			if var_68_6 <= arg_65_1.time_ and arg_65_1.time_ < var_68_6 + var_68_14 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_6) / var_68_14

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_6 + var_68_14 and arg_65_1.time_ < var_68_6 + var_68_14 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play320061017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 320061017
		arg_69_1.duration_ = 3.8

		local var_69_0 = {
			zh = 3.8,
			ja = 3.133
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
				arg_69_0:Play320061018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["1061ui_story"]
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.characterEffect1061ui_story == nil then
				arg_69_1.var_.characterEffect1061ui_story = var_72_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_2 = 0.200000002980232

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_2 and not isNil(var_72_0) then
				local var_72_3 = (arg_69_1.time_ - var_72_1) / var_72_2

				if arg_69_1.var_.characterEffect1061ui_story and not isNil(var_72_0) then
					arg_69_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= var_72_1 + var_72_2 and arg_69_1.time_ < var_72_1 + var_72_2 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.characterEffect1061ui_story then
				arg_69_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_72_4 = 0
			local var_72_5 = 0.425

			if var_72_4 < arg_69_1.time_ and arg_69_1.time_ <= var_72_4 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_6 = arg_69_1:FormatText(StoryNameCfg[612].name)

				arg_69_1.leftNameTxt_.text = var_72_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_7 = arg_69_1:GetWordFromCfg(320061017)
				local var_72_8 = arg_69_1:FormatText(var_72_7.content)

				arg_69_1.text_.text = var_72_8

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_9 = 17
				local var_72_10 = utf8.len(var_72_8)
				local var_72_11 = var_72_9 <= 0 and var_72_5 or var_72_5 * (var_72_10 / var_72_9)

				if var_72_11 > 0 and var_72_5 < var_72_11 then
					arg_69_1.talkMaxDuration = var_72_11

					if var_72_11 + var_72_4 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_11 + var_72_4
					end
				end

				arg_69_1.text_.text = var_72_8
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320061", "320061017", "story_v_out_320061.awb") ~= 0 then
					local var_72_12 = manager.audio:GetVoiceLength("story_v_out_320061", "320061017", "story_v_out_320061.awb") / 1000

					if var_72_12 + var_72_4 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_12 + var_72_4
					end

					if var_72_7.prefab_name ~= "" and arg_69_1.actors_[var_72_7.prefab_name] ~= nil then
						local var_72_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_7.prefab_name].transform, "story_v_out_320061", "320061017", "story_v_out_320061.awb")

						arg_69_1:RecordAudio("320061017", var_72_13)
						arg_69_1:RecordAudio("320061017", var_72_13)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_320061", "320061017", "story_v_out_320061.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_320061", "320061017", "story_v_out_320061.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_14 = math.max(var_72_5, arg_69_1.talkMaxDuration)

			if var_72_4 <= arg_69_1.time_ and arg_69_1.time_ < var_72_4 + var_72_14 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_4) / var_72_14

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_4 + var_72_14 and arg_69_1.time_ < var_72_4 + var_72_14 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play320061018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 320061018
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play320061019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["1061ui_story"]
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.characterEffect1061ui_story == nil then
				arg_73_1.var_.characterEffect1061ui_story = var_76_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_2 = 0.200000002980232

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_2 and not isNil(var_76_0) then
				local var_76_3 = (arg_73_1.time_ - var_76_1) / var_76_2

				if arg_73_1.var_.characterEffect1061ui_story and not isNil(var_76_0) then
					local var_76_4 = Mathf.Lerp(0, 0.5, var_76_3)

					arg_73_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_73_1.var_.characterEffect1061ui_story.fillRatio = var_76_4
				end
			end

			if arg_73_1.time_ >= var_76_1 + var_76_2 and arg_73_1.time_ < var_76_1 + var_76_2 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.characterEffect1061ui_story then
				local var_76_5 = 0.5

				arg_73_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_73_1.var_.characterEffect1061ui_story.fillRatio = var_76_5
			end

			local var_76_6 = 0
			local var_76_7 = 0.2

			if var_76_6 < arg_73_1.time_ and arg_73_1.time_ <= var_76_6 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_8 = arg_73_1:FormatText(StoryNameCfg[7].name)

				arg_73_1.leftNameTxt_.text = var_76_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, true)
				arg_73_1.iconController_:SetSelectedState("hero")

				arg_73_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_73_1.callingController_:SetSelectedState("normal")

				arg_73_1.keyicon_.color = Color.New(1, 1, 1)
				arg_73_1.icon_.color = Color.New(1, 1, 1)

				local var_76_9 = arg_73_1:GetWordFromCfg(320061018)
				local var_76_10 = arg_73_1:FormatText(var_76_9.content)

				arg_73_1.text_.text = var_76_10

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_11 = 8
				local var_76_12 = utf8.len(var_76_10)
				local var_76_13 = var_76_11 <= 0 and var_76_7 or var_76_7 * (var_76_12 / var_76_11)

				if var_76_13 > 0 and var_76_7 < var_76_13 then
					arg_73_1.talkMaxDuration = var_76_13

					if var_76_13 + var_76_6 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_13 + var_76_6
					end
				end

				arg_73_1.text_.text = var_76_10
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_14 = math.max(var_76_7, arg_73_1.talkMaxDuration)

			if var_76_6 <= arg_73_1.time_ and arg_73_1.time_ < var_76_6 + var_76_14 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_6) / var_76_14

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_6 + var_76_14 and arg_73_1.time_ < var_76_6 + var_76_14 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play320061019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 320061019
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play320061020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = arg_77_1.actors_["1061ui_story"].transform
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 then
				arg_77_1.var_.moveOldPos1061ui_story = var_80_0.localPosition
			end

			local var_80_2 = 0.001

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_2 then
				local var_80_3 = (arg_77_1.time_ - var_80_1) / var_80_2
				local var_80_4 = Vector3.New(0, 100, 0)

				var_80_0.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1061ui_story, var_80_4, var_80_3)

				local var_80_5 = manager.ui.mainCamera.transform.position - var_80_0.position

				var_80_0.forward = Vector3.New(var_80_5.x, var_80_5.y, var_80_5.z)

				local var_80_6 = var_80_0.localEulerAngles

				var_80_6.z = 0
				var_80_6.x = 0
				var_80_0.localEulerAngles = var_80_6
			end

			if arg_77_1.time_ >= var_80_1 + var_80_2 and arg_77_1.time_ < var_80_1 + var_80_2 + arg_80_0 then
				var_80_0.localPosition = Vector3.New(0, 100, 0)

				local var_80_7 = manager.ui.mainCamera.transform.position - var_80_0.position

				var_80_0.forward = Vector3.New(var_80_7.x, var_80_7.y, var_80_7.z)

				local var_80_8 = var_80_0.localEulerAngles

				var_80_8.z = 0
				var_80_8.x = 0
				var_80_0.localEulerAngles = var_80_8
			end

			local var_80_9 = arg_77_1.actors_["1061ui_story"]
			local var_80_10 = 0

			if var_80_10 < arg_77_1.time_ and arg_77_1.time_ <= var_80_10 + arg_80_0 and not isNil(var_80_9) and arg_77_1.var_.characterEffect1061ui_story == nil then
				arg_77_1.var_.characterEffect1061ui_story = var_80_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_11 = 0.200000002980232

			if var_80_10 <= arg_77_1.time_ and arg_77_1.time_ < var_80_10 + var_80_11 and not isNil(var_80_9) then
				local var_80_12 = (arg_77_1.time_ - var_80_10) / var_80_11

				if arg_77_1.var_.characterEffect1061ui_story and not isNil(var_80_9) then
					local var_80_13 = Mathf.Lerp(0, 0.5, var_80_12)

					arg_77_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_77_1.var_.characterEffect1061ui_story.fillRatio = var_80_13
				end
			end

			if arg_77_1.time_ >= var_80_10 + var_80_11 and arg_77_1.time_ < var_80_10 + var_80_11 + arg_80_0 and not isNil(var_80_9) and arg_77_1.var_.characterEffect1061ui_story then
				local var_80_14 = 0.5

				arg_77_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_77_1.var_.characterEffect1061ui_story.fillRatio = var_80_14
			end

			local var_80_15 = 0
			local var_80_16 = 1.075

			if var_80_15 < arg_77_1.time_ and arg_77_1.time_ <= var_80_15 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, false)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_17 = arg_77_1:GetWordFromCfg(320061019)
				local var_80_18 = arg_77_1:FormatText(var_80_17.content)

				arg_77_1.text_.text = var_80_18

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_19 = 43
				local var_80_20 = utf8.len(var_80_18)
				local var_80_21 = var_80_19 <= 0 and var_80_16 or var_80_16 * (var_80_20 / var_80_19)

				if var_80_21 > 0 and var_80_16 < var_80_21 then
					arg_77_1.talkMaxDuration = var_80_21

					if var_80_21 + var_80_15 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_21 + var_80_15
					end
				end

				arg_77_1.text_.text = var_80_18
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_22 = math.max(var_80_16, arg_77_1.talkMaxDuration)

			if var_80_15 <= arg_77_1.time_ and arg_77_1.time_ < var_80_15 + var_80_22 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_15) / var_80_22

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_15 + var_80_22 and arg_77_1.time_ < var_80_15 + var_80_22 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
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

		arg_77_1:InitPlayNodeList()
	end,
	Play320061020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 320061020
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play320061021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 0
			local var_84_1 = 0.2

			if var_84_0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_2 = arg_81_1:FormatText(StoryNameCfg[7].name)

				arg_81_1.leftNameTxt_.text = var_84_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, true)
				arg_81_1.iconController_:SetSelectedState("hero")

				arg_81_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_81_1.callingController_:SetSelectedState("normal")

				arg_81_1.keyicon_.color = Color.New(1, 1, 1)
				arg_81_1.icon_.color = Color.New(1, 1, 1)

				local var_84_3 = arg_81_1:GetWordFromCfg(320061020)
				local var_84_4 = arg_81_1:FormatText(var_84_3.content)

				arg_81_1.text_.text = var_84_4

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_5 = 8
				local var_84_6 = utf8.len(var_84_4)
				local var_84_7 = var_84_5 <= 0 and var_84_1 or var_84_1 * (var_84_6 / var_84_5)

				if var_84_7 > 0 and var_84_1 < var_84_7 then
					arg_81_1.talkMaxDuration = var_84_7

					if var_84_7 + var_84_0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_7 + var_84_0
					end
				end

				arg_81_1.text_.text = var_84_4
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_8 = math.max(var_84_1, arg_81_1.talkMaxDuration)

			if var_84_0 <= arg_81_1.time_ and arg_81_1.time_ < var_84_0 + var_84_8 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_0) / var_84_8

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_0 + var_84_8 and arg_81_1.time_ < var_84_0 + var_84_8 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play320061021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 320061021
		arg_85_1.duration_ = 2

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play320061022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["1061ui_story"].transform
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 then
				arg_85_1.var_.moveOldPos1061ui_story = var_88_0.localPosition
			end

			local var_88_2 = 0.001

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_2 then
				local var_88_3 = (arg_85_1.time_ - var_88_1) / var_88_2
				local var_88_4 = Vector3.New(0, -1.18, -6.15)

				var_88_0.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos1061ui_story, var_88_4, var_88_3)

				local var_88_5 = manager.ui.mainCamera.transform.position - var_88_0.position

				var_88_0.forward = Vector3.New(var_88_5.x, var_88_5.y, var_88_5.z)

				local var_88_6 = var_88_0.localEulerAngles

				var_88_6.z = 0
				var_88_6.x = 0
				var_88_0.localEulerAngles = var_88_6
			end

			if arg_85_1.time_ >= var_88_1 + var_88_2 and arg_85_1.time_ < var_88_1 + var_88_2 + arg_88_0 then
				var_88_0.localPosition = Vector3.New(0, -1.18, -6.15)

				local var_88_7 = manager.ui.mainCamera.transform.position - var_88_0.position

				var_88_0.forward = Vector3.New(var_88_7.x, var_88_7.y, var_88_7.z)

				local var_88_8 = var_88_0.localEulerAngles

				var_88_8.z = 0
				var_88_8.x = 0
				var_88_0.localEulerAngles = var_88_8
			end

			local var_88_9 = arg_85_1.actors_["1061ui_story"]
			local var_88_10 = 0

			if var_88_10 < arg_85_1.time_ and arg_85_1.time_ <= var_88_10 + arg_88_0 and not isNil(var_88_9) and arg_85_1.var_.characterEffect1061ui_story == nil then
				arg_85_1.var_.characterEffect1061ui_story = var_88_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_11 = 0.200000002980232

			if var_88_10 <= arg_85_1.time_ and arg_85_1.time_ < var_88_10 + var_88_11 and not isNil(var_88_9) then
				local var_88_12 = (arg_85_1.time_ - var_88_10) / var_88_11

				if arg_85_1.var_.characterEffect1061ui_story and not isNil(var_88_9) then
					arg_85_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_85_1.time_ >= var_88_10 + var_88_11 and arg_85_1.time_ < var_88_10 + var_88_11 + arg_88_0 and not isNil(var_88_9) and arg_85_1.var_.characterEffect1061ui_story then
				arg_85_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_88_13 = 0

			if var_88_13 < arg_85_1.time_ and arg_85_1.time_ <= var_88_13 + arg_88_0 then
				arg_85_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action3_2")
			end

			local var_88_14 = 0

			if var_88_14 < arg_85_1.time_ and arg_85_1.time_ <= var_88_14 + arg_88_0 then
				arg_85_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_88_15 = 0
			local var_88_16 = 0.05

			if var_88_15 < arg_85_1.time_ and arg_85_1.time_ <= var_88_15 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_17 = arg_85_1:FormatText(StoryNameCfg[612].name)

				arg_85_1.leftNameTxt_.text = var_88_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_18 = arg_85_1:GetWordFromCfg(320061021)
				local var_88_19 = arg_85_1:FormatText(var_88_18.content)

				arg_85_1.text_.text = var_88_19

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_20 = 2
				local var_88_21 = utf8.len(var_88_19)
				local var_88_22 = var_88_20 <= 0 and var_88_16 or var_88_16 * (var_88_21 / var_88_20)

				if var_88_22 > 0 and var_88_16 < var_88_22 then
					arg_85_1.talkMaxDuration = var_88_22

					if var_88_22 + var_88_15 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_22 + var_88_15
					end
				end

				arg_85_1.text_.text = var_88_19
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320061", "320061021", "story_v_out_320061.awb") ~= 0 then
					local var_88_23 = manager.audio:GetVoiceLength("story_v_out_320061", "320061021", "story_v_out_320061.awb") / 1000

					if var_88_23 + var_88_15 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_23 + var_88_15
					end

					if var_88_18.prefab_name ~= "" and arg_85_1.actors_[var_88_18.prefab_name] ~= nil then
						local var_88_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_18.prefab_name].transform, "story_v_out_320061", "320061021", "story_v_out_320061.awb")

						arg_85_1:RecordAudio("320061021", var_88_24)
						arg_85_1:RecordAudio("320061021", var_88_24)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_320061", "320061021", "story_v_out_320061.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_320061", "320061021", "story_v_out_320061.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_25 = math.max(var_88_16, arg_85_1.talkMaxDuration)

			if var_88_15 <= arg_85_1.time_ and arg_85_1.time_ < var_88_15 + var_88_25 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_15) / var_88_25

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_15 + var_88_25 and arg_85_1.time_ < var_88_15 + var_88_25 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
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

		arg_85_1:InitPlayNodeList()
	end,
	Play320061022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 320061022
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play320061023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = arg_89_1.actors_["1061ui_story"].transform
			local var_92_1 = 0

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 then
				arg_89_1.var_.moveOldPos1061ui_story = var_92_0.localPosition
			end

			local var_92_2 = 0.001

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_2 then
				local var_92_3 = (arg_89_1.time_ - var_92_1) / var_92_2
				local var_92_4 = Vector3.New(0, 100, 0)

				var_92_0.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1061ui_story, var_92_4, var_92_3)

				local var_92_5 = manager.ui.mainCamera.transform.position - var_92_0.position

				var_92_0.forward = Vector3.New(var_92_5.x, var_92_5.y, var_92_5.z)

				local var_92_6 = var_92_0.localEulerAngles

				var_92_6.z = 0
				var_92_6.x = 0
				var_92_0.localEulerAngles = var_92_6
			end

			if arg_89_1.time_ >= var_92_1 + var_92_2 and arg_89_1.time_ < var_92_1 + var_92_2 + arg_92_0 then
				var_92_0.localPosition = Vector3.New(0, 100, 0)

				local var_92_7 = manager.ui.mainCamera.transform.position - var_92_0.position

				var_92_0.forward = Vector3.New(var_92_7.x, var_92_7.y, var_92_7.z)

				local var_92_8 = var_92_0.localEulerAngles

				var_92_8.z = 0
				var_92_8.x = 0
				var_92_0.localEulerAngles = var_92_8
			end

			local var_92_9 = arg_89_1.actors_["1061ui_story"]
			local var_92_10 = 0

			if var_92_10 < arg_89_1.time_ and arg_89_1.time_ <= var_92_10 + arg_92_0 and not isNil(var_92_9) and arg_89_1.var_.characterEffect1061ui_story == nil then
				arg_89_1.var_.characterEffect1061ui_story = var_92_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_11 = 0.200000002980232

			if var_92_10 <= arg_89_1.time_ and arg_89_1.time_ < var_92_10 + var_92_11 and not isNil(var_92_9) then
				local var_92_12 = (arg_89_1.time_ - var_92_10) / var_92_11

				if arg_89_1.var_.characterEffect1061ui_story and not isNil(var_92_9) then
					local var_92_13 = Mathf.Lerp(0, 0.5, var_92_12)

					arg_89_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_89_1.var_.characterEffect1061ui_story.fillRatio = var_92_13
				end
			end

			if arg_89_1.time_ >= var_92_10 + var_92_11 and arg_89_1.time_ < var_92_10 + var_92_11 + arg_92_0 and not isNil(var_92_9) and arg_89_1.var_.characterEffect1061ui_story then
				local var_92_14 = 0.5

				arg_89_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_89_1.var_.characterEffect1061ui_story.fillRatio = var_92_14
			end

			local var_92_15 = 0
			local var_92_16 = 1.6

			if var_92_15 < arg_89_1.time_ and arg_89_1.time_ <= var_92_15 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, false)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_17 = arg_89_1:GetWordFromCfg(320061022)
				local var_92_18 = arg_89_1:FormatText(var_92_17.content)

				arg_89_1.text_.text = var_92_18

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_19 = 64
				local var_92_20 = utf8.len(var_92_18)
				local var_92_21 = var_92_19 <= 0 and var_92_16 or var_92_16 * (var_92_20 / var_92_19)

				if var_92_21 > 0 and var_92_16 < var_92_21 then
					arg_89_1.talkMaxDuration = var_92_21

					if var_92_21 + var_92_15 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_21 + var_92_15
					end
				end

				arg_89_1.text_.text = var_92_18
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_22 = math.max(var_92_16, arg_89_1.talkMaxDuration)

			if var_92_15 <= arg_89_1.time_ and arg_89_1.time_ < var_92_15 + var_92_22 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_15) / var_92_22

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_15 + var_92_22 and arg_89_1.time_ < var_92_15 + var_92_22 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
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

		arg_89_1:InitPlayNodeList()
	end,
	Play320061023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 320061023
		arg_93_1.duration_ = 6.8

		local var_93_0 = {
			zh = 4.066,
			ja = 6.8
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
				arg_93_0:Play320061024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = arg_93_1.actors_["1061ui_story"].transform
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 then
				arg_93_1.var_.moveOldPos1061ui_story = var_96_0.localPosition
			end

			local var_96_2 = 0.001

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_2 then
				local var_96_3 = (arg_93_1.time_ - var_96_1) / var_96_2
				local var_96_4 = Vector3.New(0, -1.18, -6.15)

				var_96_0.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1061ui_story, var_96_4, var_96_3)

				local var_96_5 = manager.ui.mainCamera.transform.position - var_96_0.position

				var_96_0.forward = Vector3.New(var_96_5.x, var_96_5.y, var_96_5.z)

				local var_96_6 = var_96_0.localEulerAngles

				var_96_6.z = 0
				var_96_6.x = 0
				var_96_0.localEulerAngles = var_96_6
			end

			if arg_93_1.time_ >= var_96_1 + var_96_2 and arg_93_1.time_ < var_96_1 + var_96_2 + arg_96_0 then
				var_96_0.localPosition = Vector3.New(0, -1.18, -6.15)

				local var_96_7 = manager.ui.mainCamera.transform.position - var_96_0.position

				var_96_0.forward = Vector3.New(var_96_7.x, var_96_7.y, var_96_7.z)

				local var_96_8 = var_96_0.localEulerAngles

				var_96_8.z = 0
				var_96_8.x = 0
				var_96_0.localEulerAngles = var_96_8
			end

			local var_96_9 = arg_93_1.actors_["1061ui_story"]
			local var_96_10 = 0

			if var_96_10 < arg_93_1.time_ and arg_93_1.time_ <= var_96_10 + arg_96_0 and not isNil(var_96_9) and arg_93_1.var_.characterEffect1061ui_story == nil then
				arg_93_1.var_.characterEffect1061ui_story = var_96_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_11 = 0.200000002980232

			if var_96_10 <= arg_93_1.time_ and arg_93_1.time_ < var_96_10 + var_96_11 and not isNil(var_96_9) then
				local var_96_12 = (arg_93_1.time_ - var_96_10) / var_96_11

				if arg_93_1.var_.characterEffect1061ui_story and not isNil(var_96_9) then
					arg_93_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= var_96_10 + var_96_11 and arg_93_1.time_ < var_96_10 + var_96_11 + arg_96_0 and not isNil(var_96_9) and arg_93_1.var_.characterEffect1061ui_story then
				arg_93_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_96_13 = 0

			if var_96_13 < arg_93_1.time_ and arg_93_1.time_ <= var_96_13 + arg_96_0 then
				arg_93_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action4_1")
			end

			local var_96_14 = 0

			if var_96_14 < arg_93_1.time_ and arg_93_1.time_ <= var_96_14 + arg_96_0 then
				arg_93_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_96_15 = 0
			local var_96_16 = 0.45

			if var_96_15 < arg_93_1.time_ and arg_93_1.time_ <= var_96_15 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_17 = arg_93_1:FormatText(StoryNameCfg[612].name)

				arg_93_1.leftNameTxt_.text = var_96_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_18 = arg_93_1:GetWordFromCfg(320061023)
				local var_96_19 = arg_93_1:FormatText(var_96_18.content)

				arg_93_1.text_.text = var_96_19

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_20 = 18
				local var_96_21 = utf8.len(var_96_19)
				local var_96_22 = var_96_20 <= 0 and var_96_16 or var_96_16 * (var_96_21 / var_96_20)

				if var_96_22 > 0 and var_96_16 < var_96_22 then
					arg_93_1.talkMaxDuration = var_96_22

					if var_96_22 + var_96_15 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_22 + var_96_15
					end
				end

				arg_93_1.text_.text = var_96_19
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320061", "320061023", "story_v_out_320061.awb") ~= 0 then
					local var_96_23 = manager.audio:GetVoiceLength("story_v_out_320061", "320061023", "story_v_out_320061.awb") / 1000

					if var_96_23 + var_96_15 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_23 + var_96_15
					end

					if var_96_18.prefab_name ~= "" and arg_93_1.actors_[var_96_18.prefab_name] ~= nil then
						local var_96_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_18.prefab_name].transform, "story_v_out_320061", "320061023", "story_v_out_320061.awb")

						arg_93_1:RecordAudio("320061023", var_96_24)
						arg_93_1:RecordAudio("320061023", var_96_24)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_320061", "320061023", "story_v_out_320061.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_320061", "320061023", "story_v_out_320061.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_25 = math.max(var_96_16, arg_93_1.talkMaxDuration)

			if var_96_15 <= arg_93_1.time_ and arg_93_1.time_ < var_96_15 + var_96_25 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_15) / var_96_25

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_15 + var_96_25 and arg_93_1.time_ < var_96_15 + var_96_25 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
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

		arg_93_1:InitPlayNodeList()
	end,
	Play320061024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 320061024
		arg_97_1.duration_ = 7.6

		local var_97_0 = {
			zh = 6.133,
			ja = 7.6
		}
		local var_97_1 = manager.audio:GetLocalizationFlag()

		if var_97_0[var_97_1] ~= nil then
			arg_97_1.duration_ = var_97_0[var_97_1]
		end

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play320061025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = arg_97_1.actors_["1061ui_story"].transform
			local var_100_1 = 0

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 then
				arg_97_1.var_.moveOldPos1061ui_story = var_100_0.localPosition
			end

			local var_100_2 = 0.001

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_2 then
				local var_100_3 = (arg_97_1.time_ - var_100_1) / var_100_2
				local var_100_4 = Vector3.New(0, -1.18, -6.15)

				var_100_0.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos1061ui_story, var_100_4, var_100_3)

				local var_100_5 = manager.ui.mainCamera.transform.position - var_100_0.position

				var_100_0.forward = Vector3.New(var_100_5.x, var_100_5.y, var_100_5.z)

				local var_100_6 = var_100_0.localEulerAngles

				var_100_6.z = 0
				var_100_6.x = 0
				var_100_0.localEulerAngles = var_100_6
			end

			if arg_97_1.time_ >= var_100_1 + var_100_2 and arg_97_1.time_ < var_100_1 + var_100_2 + arg_100_0 then
				var_100_0.localPosition = Vector3.New(0, -1.18, -6.15)

				local var_100_7 = manager.ui.mainCamera.transform.position - var_100_0.position

				var_100_0.forward = Vector3.New(var_100_7.x, var_100_7.y, var_100_7.z)

				local var_100_8 = var_100_0.localEulerAngles

				var_100_8.z = 0
				var_100_8.x = 0
				var_100_0.localEulerAngles = var_100_8
			end

			local var_100_9 = arg_97_1.actors_["1061ui_story"]
			local var_100_10 = 0

			if var_100_10 < arg_97_1.time_ and arg_97_1.time_ <= var_100_10 + arg_100_0 and not isNil(var_100_9) and arg_97_1.var_.characterEffect1061ui_story == nil then
				arg_97_1.var_.characterEffect1061ui_story = var_100_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_11 = 0.200000002980232

			if var_100_10 <= arg_97_1.time_ and arg_97_1.time_ < var_100_10 + var_100_11 and not isNil(var_100_9) then
				local var_100_12 = (arg_97_1.time_ - var_100_10) / var_100_11

				if arg_97_1.var_.characterEffect1061ui_story and not isNil(var_100_9) then
					arg_97_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= var_100_10 + var_100_11 and arg_97_1.time_ < var_100_10 + var_100_11 + arg_100_0 and not isNil(var_100_9) and arg_97_1.var_.characterEffect1061ui_story then
				arg_97_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_100_13 = 0

			if var_100_13 < arg_97_1.time_ and arg_97_1.time_ <= var_100_13 + arg_100_0 then
				arg_97_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action4_2")
			end

			local var_100_14 = 0

			if var_100_14 < arg_97_1.time_ and arg_97_1.time_ <= var_100_14 + arg_100_0 then
				arg_97_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_100_15 = 0
			local var_100_16 = 0.55

			if var_100_15 < arg_97_1.time_ and arg_97_1.time_ <= var_100_15 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_17 = arg_97_1:FormatText(StoryNameCfg[612].name)

				arg_97_1.leftNameTxt_.text = var_100_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_18 = arg_97_1:GetWordFromCfg(320061024)
				local var_100_19 = arg_97_1:FormatText(var_100_18.content)

				arg_97_1.text_.text = var_100_19

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_20 = 22
				local var_100_21 = utf8.len(var_100_19)
				local var_100_22 = var_100_20 <= 0 and var_100_16 or var_100_16 * (var_100_21 / var_100_20)

				if var_100_22 > 0 and var_100_16 < var_100_22 then
					arg_97_1.talkMaxDuration = var_100_22

					if var_100_22 + var_100_15 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_22 + var_100_15
					end
				end

				arg_97_1.text_.text = var_100_19
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320061", "320061024", "story_v_out_320061.awb") ~= 0 then
					local var_100_23 = manager.audio:GetVoiceLength("story_v_out_320061", "320061024", "story_v_out_320061.awb") / 1000

					if var_100_23 + var_100_15 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_23 + var_100_15
					end

					if var_100_18.prefab_name ~= "" and arg_97_1.actors_[var_100_18.prefab_name] ~= nil then
						local var_100_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_18.prefab_name].transform, "story_v_out_320061", "320061024", "story_v_out_320061.awb")

						arg_97_1:RecordAudio("320061024", var_100_24)
						arg_97_1:RecordAudio("320061024", var_100_24)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_320061", "320061024", "story_v_out_320061.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_320061", "320061024", "story_v_out_320061.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_25 = math.max(var_100_16, arg_97_1.talkMaxDuration)

			if var_100_15 <= arg_97_1.time_ and arg_97_1.time_ < var_100_15 + var_100_25 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_15) / var_100_25

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_15 + var_100_25 and arg_97_1.time_ < var_100_15 + var_100_25 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
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

		arg_97_1:InitPlayNodeList()
	end,
	Play320061025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 320061025
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play320061026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = arg_101_1.actors_["1061ui_story"]
			local var_104_1 = 0

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 and not isNil(var_104_0) and arg_101_1.var_.characterEffect1061ui_story == nil then
				arg_101_1.var_.characterEffect1061ui_story = var_104_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_2 = 0.200000002980232

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_2 and not isNil(var_104_0) then
				local var_104_3 = (arg_101_1.time_ - var_104_1) / var_104_2

				if arg_101_1.var_.characterEffect1061ui_story and not isNil(var_104_0) then
					local var_104_4 = Mathf.Lerp(0, 0.5, var_104_3)

					arg_101_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_101_1.var_.characterEffect1061ui_story.fillRatio = var_104_4
				end
			end

			if arg_101_1.time_ >= var_104_1 + var_104_2 and arg_101_1.time_ < var_104_1 + var_104_2 + arg_104_0 and not isNil(var_104_0) and arg_101_1.var_.characterEffect1061ui_story then
				local var_104_5 = 0.5

				arg_101_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_101_1.var_.characterEffect1061ui_story.fillRatio = var_104_5
			end

			local var_104_6 = 0
			local var_104_7 = 0.75

			if var_104_6 < arg_101_1.time_ and arg_101_1.time_ <= var_104_6 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, false)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_8 = arg_101_1:GetWordFromCfg(320061025)
				local var_104_9 = arg_101_1:FormatText(var_104_8.content)

				arg_101_1.text_.text = var_104_9

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_10 = 30
				local var_104_11 = utf8.len(var_104_9)
				local var_104_12 = var_104_10 <= 0 and var_104_7 or var_104_7 * (var_104_11 / var_104_10)

				if var_104_12 > 0 and var_104_7 < var_104_12 then
					arg_101_1.talkMaxDuration = var_104_12

					if var_104_12 + var_104_6 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_12 + var_104_6
					end
				end

				arg_101_1.text_.text = var_104_9
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_13 = math.max(var_104_7, arg_101_1.talkMaxDuration)

			if var_104_6 <= arg_101_1.time_ and arg_101_1.time_ < var_104_6 + var_104_13 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_6) / var_104_13

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_6 + var_104_13 and arg_101_1.time_ < var_104_6 + var_104_13 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play320061026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 320061026
		arg_105_1.duration_ = 1

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"

			SetActive(arg_105_1.choicesGo_, true)

			for iter_106_0, iter_106_1 in ipairs(arg_105_1.choices_) do
				local var_106_0 = iter_106_0 <= 2

				SetActive(iter_106_1.go, var_106_0)
			end

			arg_105_1.choices_[1].txt.text = arg_105_1:FormatText(StoryChoiceCfg[1108].name)
			arg_105_1.choices_[2].txt.text = arg_105_1:FormatText(StoryChoiceCfg[1109].name)
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play320061027(arg_105_1)
			end

			if arg_107_0 == 2 then
				arg_105_0:Play320061027(arg_105_1)
			end

			arg_105_1:RecordChoiceLog(320061026, 1108, 1109)
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 0

			if var_108_0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_0 + arg_108_0 then
				arg_105_1.allBtn_.enabled = false
			end

			local var_108_1 = 1

			if arg_105_1.time_ >= var_108_0 + var_108_1 and arg_105_1.time_ < var_108_0 + var_108_1 + arg_108_0 then
				arg_105_1.allBtn_.enabled = true
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play320061027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 320061027
		arg_109_1.duration_ = 8.17

		local var_109_0 = {
			zh = 5.799999999999,
			ja = 8.165999999999
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
				arg_109_0:Play320061028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 1.999999999999

			if var_112_0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_0 + arg_112_0 then
				local var_112_1 = manager.ui.mainCamera.transform.localPosition
				local var_112_2 = Vector3.New(0, 0, 10) + Vector3.New(var_112_1.x, var_112_1.y, 0)
				local var_112_3 = arg_109_1.bgs_.ST61

				var_112_3.transform.localPosition = var_112_2
				var_112_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_112_4 = var_112_3:GetComponent("SpriteRenderer")

				if var_112_4 and var_112_4.sprite then
					local var_112_5 = (var_112_3.transform.localPosition - var_112_1).z
					local var_112_6 = manager.ui.mainCameraCom_
					local var_112_7 = 2 * var_112_5 * Mathf.Tan(var_112_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_112_8 = var_112_7 * var_112_6.aspect
					local var_112_9 = var_112_4.sprite.bounds.size.x
					local var_112_10 = var_112_4.sprite.bounds.size.y
					local var_112_11 = var_112_8 / var_112_9
					local var_112_12 = var_112_7 / var_112_10
					local var_112_13 = var_112_12 < var_112_11 and var_112_11 or var_112_12

					var_112_3.transform.localScale = Vector3.New(var_112_13, var_112_13, 0)
				end

				for iter_112_0, iter_112_1 in pairs(arg_109_1.bgs_) do
					if iter_112_0 ~= "ST61" then
						iter_112_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_112_14 = 3.999999999999

			if var_112_14 < arg_109_1.time_ and arg_109_1.time_ <= var_112_14 + arg_112_0 then
				arg_109_1.allBtn_.enabled = false
			end

			local var_112_15 = 0.3

			if arg_109_1.time_ >= var_112_14 + var_112_15 and arg_109_1.time_ < var_112_14 + var_112_15 + arg_112_0 then
				arg_109_1.allBtn_.enabled = true
			end

			local var_112_16 = 0

			if var_112_16 < arg_109_1.time_ and arg_109_1.time_ <= var_112_16 + arg_112_0 then
				arg_109_1.mask_.enabled = true
				arg_109_1.mask_.raycastTarget = true

				arg_109_1:SetGaussion(false)
			end

			local var_112_17 = 2

			if var_112_16 <= arg_109_1.time_ and arg_109_1.time_ < var_112_16 + var_112_17 then
				local var_112_18 = (arg_109_1.time_ - var_112_16) / var_112_17
				local var_112_19 = Color.New(0, 0, 0)

				var_112_19.a = Mathf.Lerp(0, 1, var_112_18)
				arg_109_1.mask_.color = var_112_19
			end

			if arg_109_1.time_ >= var_112_16 + var_112_17 and arg_109_1.time_ < var_112_16 + var_112_17 + arg_112_0 then
				local var_112_20 = Color.New(0, 0, 0)

				var_112_20.a = 1
				arg_109_1.mask_.color = var_112_20
			end

			local var_112_21 = 2

			if var_112_21 < arg_109_1.time_ and arg_109_1.time_ <= var_112_21 + arg_112_0 then
				arg_109_1.mask_.enabled = true
				arg_109_1.mask_.raycastTarget = true

				arg_109_1:SetGaussion(false)
			end

			local var_112_22 = 2

			if var_112_21 <= arg_109_1.time_ and arg_109_1.time_ < var_112_21 + var_112_22 then
				local var_112_23 = (arg_109_1.time_ - var_112_21) / var_112_22
				local var_112_24 = Color.New(0, 0, 0)

				var_112_24.a = Mathf.Lerp(1, 0, var_112_23)
				arg_109_1.mask_.color = var_112_24
			end

			if arg_109_1.time_ >= var_112_21 + var_112_22 and arg_109_1.time_ < var_112_21 + var_112_22 + arg_112_0 then
				local var_112_25 = Color.New(0, 0, 0)
				local var_112_26 = 0

				arg_109_1.mask_.enabled = false
				var_112_25.a = var_112_26
				arg_109_1.mask_.color = var_112_25
			end

			local var_112_27 = arg_109_1.actors_["1061ui_story"].transform
			local var_112_28 = 1.96599999815226

			if var_112_28 < arg_109_1.time_ and arg_109_1.time_ <= var_112_28 + arg_112_0 then
				arg_109_1.var_.moveOldPos1061ui_story = var_112_27.localPosition
			end

			local var_112_29 = 0.001

			if var_112_28 <= arg_109_1.time_ and arg_109_1.time_ < var_112_28 + var_112_29 then
				local var_112_30 = (arg_109_1.time_ - var_112_28) / var_112_29
				local var_112_31 = Vector3.New(0, 100, 0)

				var_112_27.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1061ui_story, var_112_31, var_112_30)

				local var_112_32 = manager.ui.mainCamera.transform.position - var_112_27.position

				var_112_27.forward = Vector3.New(var_112_32.x, var_112_32.y, var_112_32.z)

				local var_112_33 = var_112_27.localEulerAngles

				var_112_33.z = 0
				var_112_33.x = 0
				var_112_27.localEulerAngles = var_112_33
			end

			if arg_109_1.time_ >= var_112_28 + var_112_29 and arg_109_1.time_ < var_112_28 + var_112_29 + arg_112_0 then
				var_112_27.localPosition = Vector3.New(0, 100, 0)

				local var_112_34 = manager.ui.mainCamera.transform.position - var_112_27.position

				var_112_27.forward = Vector3.New(var_112_34.x, var_112_34.y, var_112_34.z)

				local var_112_35 = var_112_27.localEulerAngles

				var_112_35.z = 0
				var_112_35.x = 0
				var_112_27.localEulerAngles = var_112_35
			end

			local var_112_36 = arg_109_1.actors_["1061ui_story"]
			local var_112_37 = 1.96599999815226

			if var_112_37 < arg_109_1.time_ and arg_109_1.time_ <= var_112_37 + arg_112_0 and not isNil(var_112_36) and arg_109_1.var_.characterEffect1061ui_story == nil then
				arg_109_1.var_.characterEffect1061ui_story = var_112_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_38 = 0.034000001847744

			if var_112_37 <= arg_109_1.time_ and arg_109_1.time_ < var_112_37 + var_112_38 and not isNil(var_112_36) then
				local var_112_39 = (arg_109_1.time_ - var_112_37) / var_112_38

				if arg_109_1.var_.characterEffect1061ui_story and not isNil(var_112_36) then
					local var_112_40 = Mathf.Lerp(0, 0.5, var_112_39)

					arg_109_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_109_1.var_.characterEffect1061ui_story.fillRatio = var_112_40
				end
			end

			if arg_109_1.time_ >= var_112_37 + var_112_38 and arg_109_1.time_ < var_112_37 + var_112_38 + arg_112_0 and not isNil(var_112_36) and arg_109_1.var_.characterEffect1061ui_story then
				local var_112_41 = 0.5

				arg_109_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_109_1.var_.characterEffect1061ui_story.fillRatio = var_112_41
			end

			local var_112_42 = "1020ui_story"

			if arg_109_1.actors_[var_112_42] == nil then
				local var_112_43 = Asset.Load("Char/" .. "1020ui_story")

				if not isNil(var_112_43) then
					local var_112_44 = Object.Instantiate(Asset.Load("Char/" .. "1020ui_story"), arg_109_1.stage_.transform)

					var_112_44.name = var_112_42
					var_112_44.transform.localPosition = Vector3.New(0, 100, 0)
					arg_109_1.actors_[var_112_42] = var_112_44

					local var_112_45 = var_112_44:GetComponentInChildren(typeof(CharacterEffect))

					var_112_45.enabled = true

					local var_112_46 = GameObjectTools.GetOrAddComponent(var_112_44, typeof(DynamicBoneHelper))

					if var_112_46 then
						var_112_46:EnableDynamicBone(false)
					end

					arg_109_1:ShowWeapon(var_112_45.transform, false)

					arg_109_1.var_[var_112_42 .. "Animator"] = var_112_45.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_109_1.var_[var_112_42 .. "Animator"].applyRootMotion = true
					arg_109_1.var_[var_112_42 .. "LipSync"] = var_112_45.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_112_47 = arg_109_1.actors_["1020ui_story"].transform
			local var_112_48 = 3.8

			if var_112_48 < arg_109_1.time_ and arg_109_1.time_ <= var_112_48 + arg_112_0 then
				arg_109_1.var_.moveOldPos1020ui_story = var_112_47.localPosition
			end

			local var_112_49 = 0.001

			if var_112_48 <= arg_109_1.time_ and arg_109_1.time_ < var_112_48 + var_112_49 then
				local var_112_50 = (arg_109_1.time_ - var_112_48) / var_112_49
				local var_112_51 = Vector3.New(0, -0.85, -6.25)

				var_112_47.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1020ui_story, var_112_51, var_112_50)

				local var_112_52 = manager.ui.mainCamera.transform.position - var_112_47.position

				var_112_47.forward = Vector3.New(var_112_52.x, var_112_52.y, var_112_52.z)

				local var_112_53 = var_112_47.localEulerAngles

				var_112_53.z = 0
				var_112_53.x = 0
				var_112_47.localEulerAngles = var_112_53
			end

			if arg_109_1.time_ >= var_112_48 + var_112_49 and arg_109_1.time_ < var_112_48 + var_112_49 + arg_112_0 then
				var_112_47.localPosition = Vector3.New(0, -0.85, -6.25)

				local var_112_54 = manager.ui.mainCamera.transform.position - var_112_47.position

				var_112_47.forward = Vector3.New(var_112_54.x, var_112_54.y, var_112_54.z)

				local var_112_55 = var_112_47.localEulerAngles

				var_112_55.z = 0
				var_112_55.x = 0
				var_112_47.localEulerAngles = var_112_55
			end

			local var_112_56 = arg_109_1.actors_["1020ui_story"]
			local var_112_57 = 3.8

			if var_112_57 < arg_109_1.time_ and arg_109_1.time_ <= var_112_57 + arg_112_0 and not isNil(var_112_56) and arg_109_1.var_.characterEffect1020ui_story == nil then
				arg_109_1.var_.characterEffect1020ui_story = var_112_56:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_58 = 0.200000002980232

			if var_112_57 <= arg_109_1.time_ and arg_109_1.time_ < var_112_57 + var_112_58 and not isNil(var_112_56) then
				local var_112_59 = (arg_109_1.time_ - var_112_57) / var_112_58

				if arg_109_1.var_.characterEffect1020ui_story and not isNil(var_112_56) then
					arg_109_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= var_112_57 + var_112_58 and arg_109_1.time_ < var_112_57 + var_112_58 + arg_112_0 and not isNil(var_112_56) and arg_109_1.var_.characterEffect1020ui_story then
				arg_109_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_112_60 = "1020ui_story"

			if arg_109_1.actors_[var_112_60] == nil then
				local var_112_61 = Asset.Load("Char/" .. "1020ui_story")

				if not isNil(var_112_61) then
					local var_112_62 = Object.Instantiate(Asset.Load("Char/" .. "1020ui_story"), arg_109_1.stage_.transform)

					var_112_62.name = var_112_60
					var_112_62.transform.localPosition = Vector3.New(0, 100, 0)
					arg_109_1.actors_[var_112_60] = var_112_62

					local var_112_63 = var_112_62:GetComponentInChildren(typeof(CharacterEffect))

					var_112_63.enabled = true

					local var_112_64 = GameObjectTools.GetOrAddComponent(var_112_62, typeof(DynamicBoneHelper))

					if var_112_64 then
						var_112_64:EnableDynamicBone(false)
					end

					arg_109_1:ShowWeapon(var_112_63.transform, false)

					arg_109_1.var_[var_112_60 .. "Animator"] = var_112_63.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_109_1.var_[var_112_60 .. "Animator"].applyRootMotion = true
					arg_109_1.var_[var_112_60 .. "LipSync"] = var_112_63.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_112_65 = 3.8

			if var_112_65 < arg_109_1.time_ and arg_109_1.time_ <= var_112_65 + arg_112_0 then
				arg_109_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action1_1")
			end

			local var_112_66 = "1020ui_story"

			if arg_109_1.actors_[var_112_66] == nil then
				local var_112_67 = Asset.Load("Char/" .. "1020ui_story")

				if not isNil(var_112_67) then
					local var_112_68 = Object.Instantiate(Asset.Load("Char/" .. "1020ui_story"), arg_109_1.stage_.transform)

					var_112_68.name = var_112_66
					var_112_68.transform.localPosition = Vector3.New(0, 100, 0)
					arg_109_1.actors_[var_112_66] = var_112_68

					local var_112_69 = var_112_68:GetComponentInChildren(typeof(CharacterEffect))

					var_112_69.enabled = true

					local var_112_70 = GameObjectTools.GetOrAddComponent(var_112_68, typeof(DynamicBoneHelper))

					if var_112_70 then
						var_112_70:EnableDynamicBone(false)
					end

					arg_109_1:ShowWeapon(var_112_69.transform, false)

					arg_109_1.var_[var_112_66 .. "Animator"] = var_112_69.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_109_1.var_[var_112_66 .. "Animator"].applyRootMotion = true
					arg_109_1.var_[var_112_66 .. "LipSync"] = var_112_69.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_112_71 = 3.8

			if var_112_71 < arg_109_1.time_ and arg_109_1.time_ <= var_112_71 + arg_112_0 then
				arg_109_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if arg_109_1.frameCnt_ <= 1 then
				arg_109_1.dialog_:SetActive(false)
			end

			local var_112_72 = 3.999999999999
			local var_112_73 = 0.125

			if var_112_72 < arg_109_1.time_ and arg_109_1.time_ <= var_112_72 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0

				arg_109_1.dialog_:SetActive(true)

				arg_109_1.dialogCg_.alpha = 0

				local var_112_74 = LeanTween.value(arg_109_1.dialog_, 0, 1, 0.3)

				var_112_74:setOnUpdate(LuaHelper.FloatAction(function(arg_113_0)
					arg_109_1.dialogCg_.alpha = arg_113_0
				end))
				var_112_74:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_109_1.dialog_)
					var_112_74:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_109_1.duration_ = arg_109_1.duration_ + 0.3

				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_75 = arg_109_1:FormatText(StoryNameCfg[613].name)

				arg_109_1.leftNameTxt_.text = var_112_75

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_76 = arg_109_1:GetWordFromCfg(320061027)
				local var_112_77 = arg_109_1:FormatText(var_112_76.content)

				arg_109_1.text_.text = var_112_77

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_78 = 5
				local var_112_79 = utf8.len(var_112_77)
				local var_112_80 = var_112_78 <= 0 and var_112_73 or var_112_73 * (var_112_79 / var_112_78)

				if var_112_80 > 0 and var_112_73 < var_112_80 then
					arg_109_1.talkMaxDuration = var_112_80
					var_112_72 = var_112_72 + 0.3

					if var_112_80 + var_112_72 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_80 + var_112_72
					end
				end

				arg_109_1.text_.text = var_112_77
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320061", "320061027", "story_v_out_320061.awb") ~= 0 then
					local var_112_81 = manager.audio:GetVoiceLength("story_v_out_320061", "320061027", "story_v_out_320061.awb") / 1000

					if var_112_81 + var_112_72 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_81 + var_112_72
					end

					if var_112_76.prefab_name ~= "" and arg_109_1.actors_[var_112_76.prefab_name] ~= nil then
						local var_112_82 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_76.prefab_name].transform, "story_v_out_320061", "320061027", "story_v_out_320061.awb")

						arg_109_1:RecordAudio("320061027", var_112_82)
						arg_109_1:RecordAudio("320061027", var_112_82)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_320061", "320061027", "story_v_out_320061.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_320061", "320061027", "story_v_out_320061.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_83 = var_112_72 + 0.3
			local var_112_84 = math.max(var_112_73, arg_109_1.talkMaxDuration)

			if var_112_83 <= arg_109_1.time_ and arg_109_1.time_ < var_112_83 + var_112_84 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_83) / var_112_84

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_83 + var_112_84 and arg_109_1.time_ < var_112_83 + var_112_84 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_109_1:InitPlayNodeList()
	end,
	Play320061028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 320061028
		arg_115_1.duration_ = 7.7

		local var_115_0 = {
			zh = 4.533,
			ja = 7.7
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
				arg_115_0:Play320061029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = arg_115_1.actors_["1020ui_story"].transform
			local var_118_1 = 0

			if var_118_1 < arg_115_1.time_ and arg_115_1.time_ <= var_118_1 + arg_118_0 then
				arg_115_1.var_.moveOldPos1020ui_story = var_118_0.localPosition
			end

			local var_118_2 = 0.001

			if var_118_1 <= arg_115_1.time_ and arg_115_1.time_ < var_118_1 + var_118_2 then
				local var_118_3 = (arg_115_1.time_ - var_118_1) / var_118_2
				local var_118_4 = Vector3.New(-0.7, -0.85, -6.25)

				var_118_0.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos1020ui_story, var_118_4, var_118_3)

				local var_118_5 = manager.ui.mainCamera.transform.position - var_118_0.position

				var_118_0.forward = Vector3.New(var_118_5.x, var_118_5.y, var_118_5.z)

				local var_118_6 = var_118_0.localEulerAngles

				var_118_6.z = 0
				var_118_6.x = 0
				var_118_0.localEulerAngles = var_118_6
			end

			if arg_115_1.time_ >= var_118_1 + var_118_2 and arg_115_1.time_ < var_118_1 + var_118_2 + arg_118_0 then
				var_118_0.localPosition = Vector3.New(-0.7, -0.85, -6.25)

				local var_118_7 = manager.ui.mainCamera.transform.position - var_118_0.position

				var_118_0.forward = Vector3.New(var_118_7.x, var_118_7.y, var_118_7.z)

				local var_118_8 = var_118_0.localEulerAngles

				var_118_8.z = 0
				var_118_8.x = 0
				var_118_0.localEulerAngles = var_118_8
			end

			local var_118_9 = arg_115_1.actors_["1020ui_story"]
			local var_118_10 = 0

			if var_118_10 < arg_115_1.time_ and arg_115_1.time_ <= var_118_10 + arg_118_0 and not isNil(var_118_9) and arg_115_1.var_.characterEffect1020ui_story == nil then
				arg_115_1.var_.characterEffect1020ui_story = var_118_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_11 = 0.200000002980232

			if var_118_10 <= arg_115_1.time_ and arg_115_1.time_ < var_118_10 + var_118_11 and not isNil(var_118_9) then
				local var_118_12 = (arg_115_1.time_ - var_118_10) / var_118_11

				if arg_115_1.var_.characterEffect1020ui_story and not isNil(var_118_9) then
					local var_118_13 = Mathf.Lerp(0, 0.5, var_118_12)

					arg_115_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_115_1.var_.characterEffect1020ui_story.fillRatio = var_118_13
				end
			end

			if arg_115_1.time_ >= var_118_10 + var_118_11 and arg_115_1.time_ < var_118_10 + var_118_11 + arg_118_0 and not isNil(var_118_9) and arg_115_1.var_.characterEffect1020ui_story then
				local var_118_14 = 0.5

				arg_115_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_115_1.var_.characterEffect1020ui_story.fillRatio = var_118_14
			end

			local var_118_15 = "10100ui_story"

			if arg_115_1.actors_[var_118_15] == nil then
				local var_118_16 = Asset.Load("Char/" .. "10100ui_story")

				if not isNil(var_118_16) then
					local var_118_17 = Object.Instantiate(Asset.Load("Char/" .. "10100ui_story"), arg_115_1.stage_.transform)

					var_118_17.name = var_118_15
					var_118_17.transform.localPosition = Vector3.New(0, 100, 0)
					arg_115_1.actors_[var_118_15] = var_118_17

					local var_118_18 = var_118_17:GetComponentInChildren(typeof(CharacterEffect))

					var_118_18.enabled = true

					local var_118_19 = GameObjectTools.GetOrAddComponent(var_118_17, typeof(DynamicBoneHelper))

					if var_118_19 then
						var_118_19:EnableDynamicBone(false)
					end

					arg_115_1:ShowWeapon(var_118_18.transform, false)

					arg_115_1.var_[var_118_15 .. "Animator"] = var_118_18.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_115_1.var_[var_118_15 .. "Animator"].applyRootMotion = true
					arg_115_1.var_[var_118_15 .. "LipSync"] = var_118_18.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_118_20 = arg_115_1.actors_["10100ui_story"].transform
			local var_118_21 = 0

			if var_118_21 < arg_115_1.time_ and arg_115_1.time_ <= var_118_21 + arg_118_0 then
				arg_115_1.var_.moveOldPos10100ui_story = var_118_20.localPosition
			end

			local var_118_22 = 0.001

			if var_118_21 <= arg_115_1.time_ and arg_115_1.time_ < var_118_21 + var_118_22 then
				local var_118_23 = (arg_115_1.time_ - var_118_21) / var_118_22
				local var_118_24 = Vector3.New(0.7, -1.16, -6.25)

				var_118_20.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos10100ui_story, var_118_24, var_118_23)

				local var_118_25 = manager.ui.mainCamera.transform.position - var_118_20.position

				var_118_20.forward = Vector3.New(var_118_25.x, var_118_25.y, var_118_25.z)

				local var_118_26 = var_118_20.localEulerAngles

				var_118_26.z = 0
				var_118_26.x = 0
				var_118_20.localEulerAngles = var_118_26
			end

			if arg_115_1.time_ >= var_118_21 + var_118_22 and arg_115_1.time_ < var_118_21 + var_118_22 + arg_118_0 then
				var_118_20.localPosition = Vector3.New(0.7, -1.16, -6.25)

				local var_118_27 = manager.ui.mainCamera.transform.position - var_118_20.position

				var_118_20.forward = Vector3.New(var_118_27.x, var_118_27.y, var_118_27.z)

				local var_118_28 = var_118_20.localEulerAngles

				var_118_28.z = 0
				var_118_28.x = 0
				var_118_20.localEulerAngles = var_118_28
			end

			local var_118_29 = arg_115_1.actors_["10100ui_story"]
			local var_118_30 = 0

			if var_118_30 < arg_115_1.time_ and arg_115_1.time_ <= var_118_30 + arg_118_0 and not isNil(var_118_29) and arg_115_1.var_.characterEffect10100ui_story == nil then
				arg_115_1.var_.characterEffect10100ui_story = var_118_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_31 = 0.200000002980232

			if var_118_30 <= arg_115_1.time_ and arg_115_1.time_ < var_118_30 + var_118_31 and not isNil(var_118_29) then
				local var_118_32 = (arg_115_1.time_ - var_118_30) / var_118_31

				if arg_115_1.var_.characterEffect10100ui_story and not isNil(var_118_29) then
					arg_115_1.var_.characterEffect10100ui_story.fillFlat = false
				end
			end

			if arg_115_1.time_ >= var_118_30 + var_118_31 and arg_115_1.time_ < var_118_30 + var_118_31 + arg_118_0 and not isNil(var_118_29) and arg_115_1.var_.characterEffect10100ui_story then
				arg_115_1.var_.characterEffect10100ui_story.fillFlat = false
			end

			local var_118_33 = 0

			if var_118_33 < arg_115_1.time_ and arg_115_1.time_ <= var_118_33 + arg_118_0 then
				arg_115_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action24_1")
			end

			local var_118_34 = 0

			if var_118_34 < arg_115_1.time_ and arg_115_1.time_ <= var_118_34 + arg_118_0 then
				arg_115_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_118_35 = 0
			local var_118_36 = 0.375

			if var_118_35 < arg_115_1.time_ and arg_115_1.time_ <= var_118_35 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				local var_118_37 = arg_115_1:FormatText(StoryNameCfg[1021].name)

				arg_115_1.leftNameTxt_.text = var_118_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_38 = arg_115_1:GetWordFromCfg(320061028)
				local var_118_39 = arg_115_1:FormatText(var_118_38.content)

				arg_115_1.text_.text = var_118_39

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_40 = 15
				local var_118_41 = utf8.len(var_118_39)
				local var_118_42 = var_118_40 <= 0 and var_118_36 or var_118_36 * (var_118_41 / var_118_40)

				if var_118_42 > 0 and var_118_36 < var_118_42 then
					arg_115_1.talkMaxDuration = var_118_42

					if var_118_42 + var_118_35 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_42 + var_118_35
					end
				end

				arg_115_1.text_.text = var_118_39
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320061", "320061028", "story_v_out_320061.awb") ~= 0 then
					local var_118_43 = manager.audio:GetVoiceLength("story_v_out_320061", "320061028", "story_v_out_320061.awb") / 1000

					if var_118_43 + var_118_35 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_43 + var_118_35
					end

					if var_118_38.prefab_name ~= "" and arg_115_1.actors_[var_118_38.prefab_name] ~= nil then
						local var_118_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_38.prefab_name].transform, "story_v_out_320061", "320061028", "story_v_out_320061.awb")

						arg_115_1:RecordAudio("320061028", var_118_44)
						arg_115_1:RecordAudio("320061028", var_118_44)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_320061", "320061028", "story_v_out_320061.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_320061", "320061028", "story_v_out_320061.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_45 = math.max(var_118_36, arg_115_1.talkMaxDuration)

			if var_118_35 <= arg_115_1.time_ and arg_115_1.time_ < var_118_35 + var_118_45 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_35) / var_118_45

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_35 + var_118_45 and arg_115_1.time_ < var_118_35 + var_118_45 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10100ui_story",
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
	Play320061029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 320061029
		arg_119_1.duration_ = 6.27

		local var_119_0 = {
			zh = 4.066,
			ja = 6.266
		}
		local var_119_1 = manager.audio:GetLocalizationFlag()

		if var_119_0[var_119_1] ~= nil then
			arg_119_1.duration_ = var_119_0[var_119_1]
		end

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play320061030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = arg_119_1.actors_["1020ui_story"].transform
			local var_122_1 = 0

			if var_122_1 < arg_119_1.time_ and arg_119_1.time_ <= var_122_1 + arg_122_0 then
				arg_119_1.var_.moveOldPos1020ui_story = var_122_0.localPosition
			end

			local var_122_2 = 0.001

			if var_122_1 <= arg_119_1.time_ and arg_119_1.time_ < var_122_1 + var_122_2 then
				local var_122_3 = (arg_119_1.time_ - var_122_1) / var_122_2
				local var_122_4 = Vector3.New(-0.7, -0.85, -6.25)

				var_122_0.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos1020ui_story, var_122_4, var_122_3)

				local var_122_5 = manager.ui.mainCamera.transform.position - var_122_0.position

				var_122_0.forward = Vector3.New(var_122_5.x, var_122_5.y, var_122_5.z)

				local var_122_6 = var_122_0.localEulerAngles

				var_122_6.z = 0
				var_122_6.x = 0
				var_122_0.localEulerAngles = var_122_6
			end

			if arg_119_1.time_ >= var_122_1 + var_122_2 and arg_119_1.time_ < var_122_1 + var_122_2 + arg_122_0 then
				var_122_0.localPosition = Vector3.New(-0.7, -0.85, -6.25)

				local var_122_7 = manager.ui.mainCamera.transform.position - var_122_0.position

				var_122_0.forward = Vector3.New(var_122_7.x, var_122_7.y, var_122_7.z)

				local var_122_8 = var_122_0.localEulerAngles

				var_122_8.z = 0
				var_122_8.x = 0
				var_122_0.localEulerAngles = var_122_8
			end

			local var_122_9 = arg_119_1.actors_["1020ui_story"]
			local var_122_10 = 0

			if var_122_10 < arg_119_1.time_ and arg_119_1.time_ <= var_122_10 + arg_122_0 and not isNil(var_122_9) and arg_119_1.var_.characterEffect1020ui_story == nil then
				arg_119_1.var_.characterEffect1020ui_story = var_122_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_11 = 0.200000002980232

			if var_122_10 <= arg_119_1.time_ and arg_119_1.time_ < var_122_10 + var_122_11 and not isNil(var_122_9) then
				local var_122_12 = (arg_119_1.time_ - var_122_10) / var_122_11

				if arg_119_1.var_.characterEffect1020ui_story and not isNil(var_122_9) then
					arg_119_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_119_1.time_ >= var_122_10 + var_122_11 and arg_119_1.time_ < var_122_10 + var_122_11 + arg_122_0 and not isNil(var_122_9) and arg_119_1.var_.characterEffect1020ui_story then
				arg_119_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_122_13 = 0

			if var_122_13 < arg_119_1.time_ and arg_119_1.time_ <= var_122_13 + arg_122_0 then
				arg_119_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_122_14 = arg_119_1.actors_["10100ui_story"]
			local var_122_15 = 0

			if var_122_15 < arg_119_1.time_ and arg_119_1.time_ <= var_122_15 + arg_122_0 and not isNil(var_122_14) and arg_119_1.var_.characterEffect10100ui_story == nil then
				arg_119_1.var_.characterEffect10100ui_story = var_122_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_16 = 0.200000002980232

			if var_122_15 <= arg_119_1.time_ and arg_119_1.time_ < var_122_15 + var_122_16 and not isNil(var_122_14) then
				local var_122_17 = (arg_119_1.time_ - var_122_15) / var_122_16

				if arg_119_1.var_.characterEffect10100ui_story and not isNil(var_122_14) then
					local var_122_18 = Mathf.Lerp(0, 0.5, var_122_17)

					arg_119_1.var_.characterEffect10100ui_story.fillFlat = true
					arg_119_1.var_.characterEffect10100ui_story.fillRatio = var_122_18
				end
			end

			if arg_119_1.time_ >= var_122_15 + var_122_16 and arg_119_1.time_ < var_122_15 + var_122_16 + arg_122_0 and not isNil(var_122_14) and arg_119_1.var_.characterEffect10100ui_story then
				local var_122_19 = 0.5

				arg_119_1.var_.characterEffect10100ui_story.fillFlat = true
				arg_119_1.var_.characterEffect10100ui_story.fillRatio = var_122_19
			end

			local var_122_20 = 0
			local var_122_21 = 0.45

			if var_122_20 < arg_119_1.time_ and arg_119_1.time_ <= var_122_20 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				local var_122_22 = arg_119_1:FormatText(StoryNameCfg[613].name)

				arg_119_1.leftNameTxt_.text = var_122_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_23 = arg_119_1:GetWordFromCfg(320061029)
				local var_122_24 = arg_119_1:FormatText(var_122_23.content)

				arg_119_1.text_.text = var_122_24

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_25 = 18
				local var_122_26 = utf8.len(var_122_24)
				local var_122_27 = var_122_25 <= 0 and var_122_21 or var_122_21 * (var_122_26 / var_122_25)

				if var_122_27 > 0 and var_122_21 < var_122_27 then
					arg_119_1.talkMaxDuration = var_122_27

					if var_122_27 + var_122_20 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_27 + var_122_20
					end
				end

				arg_119_1.text_.text = var_122_24
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320061", "320061029", "story_v_out_320061.awb") ~= 0 then
					local var_122_28 = manager.audio:GetVoiceLength("story_v_out_320061", "320061029", "story_v_out_320061.awb") / 1000

					if var_122_28 + var_122_20 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_28 + var_122_20
					end

					if var_122_23.prefab_name ~= "" and arg_119_1.actors_[var_122_23.prefab_name] ~= nil then
						local var_122_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_23.prefab_name].transform, "story_v_out_320061", "320061029", "story_v_out_320061.awb")

						arg_119_1:RecordAudio("320061029", var_122_29)
						arg_119_1:RecordAudio("320061029", var_122_29)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_320061", "320061029", "story_v_out_320061.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_320061", "320061029", "story_v_out_320061.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_30 = math.max(var_122_21, arg_119_1.talkMaxDuration)

			if var_122_20 <= arg_119_1.time_ and arg_119_1.time_ < var_122_20 + var_122_30 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_20) / var_122_30

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_20 + var_122_30 and arg_119_1.time_ < var_122_20 + var_122_30 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
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
	Play320061030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 320061030
		arg_123_1.duration_ = 5

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play320061031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = arg_123_1.actors_["1020ui_story"].transform
			local var_126_1 = 0

			if var_126_1 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 then
				arg_123_1.var_.moveOldPos1020ui_story = var_126_0.localPosition
			end

			local var_126_2 = 0.001

			if var_126_1 <= arg_123_1.time_ and arg_123_1.time_ < var_126_1 + var_126_2 then
				local var_126_3 = (arg_123_1.time_ - var_126_1) / var_126_2
				local var_126_4 = Vector3.New(0, 100, 0)

				var_126_0.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos1020ui_story, var_126_4, var_126_3)

				local var_126_5 = manager.ui.mainCamera.transform.position - var_126_0.position

				var_126_0.forward = Vector3.New(var_126_5.x, var_126_5.y, var_126_5.z)

				local var_126_6 = var_126_0.localEulerAngles

				var_126_6.z = 0
				var_126_6.x = 0
				var_126_0.localEulerAngles = var_126_6
			end

			if arg_123_1.time_ >= var_126_1 + var_126_2 and arg_123_1.time_ < var_126_1 + var_126_2 + arg_126_0 then
				var_126_0.localPosition = Vector3.New(0, 100, 0)

				local var_126_7 = manager.ui.mainCamera.transform.position - var_126_0.position

				var_126_0.forward = Vector3.New(var_126_7.x, var_126_7.y, var_126_7.z)

				local var_126_8 = var_126_0.localEulerAngles

				var_126_8.z = 0
				var_126_8.x = 0
				var_126_0.localEulerAngles = var_126_8
			end

			local var_126_9 = arg_123_1.actors_["1020ui_story"]
			local var_126_10 = 0

			if var_126_10 < arg_123_1.time_ and arg_123_1.time_ <= var_126_10 + arg_126_0 and not isNil(var_126_9) and arg_123_1.var_.characterEffect1020ui_story == nil then
				arg_123_1.var_.characterEffect1020ui_story = var_126_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_11 = 0.200000002980232

			if var_126_10 <= arg_123_1.time_ and arg_123_1.time_ < var_126_10 + var_126_11 and not isNil(var_126_9) then
				local var_126_12 = (arg_123_1.time_ - var_126_10) / var_126_11

				if arg_123_1.var_.characterEffect1020ui_story and not isNil(var_126_9) then
					local var_126_13 = Mathf.Lerp(0, 0.5, var_126_12)

					arg_123_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_123_1.var_.characterEffect1020ui_story.fillRatio = var_126_13
				end
			end

			if arg_123_1.time_ >= var_126_10 + var_126_11 and arg_123_1.time_ < var_126_10 + var_126_11 + arg_126_0 and not isNil(var_126_9) and arg_123_1.var_.characterEffect1020ui_story then
				local var_126_14 = 0.5

				arg_123_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_123_1.var_.characterEffect1020ui_story.fillRatio = var_126_14
			end

			local var_126_15 = arg_123_1.actors_["10100ui_story"].transform
			local var_126_16 = 0

			if var_126_16 < arg_123_1.time_ and arg_123_1.time_ <= var_126_16 + arg_126_0 then
				arg_123_1.var_.moveOldPos10100ui_story = var_126_15.localPosition
			end

			local var_126_17 = 0.001

			if var_126_16 <= arg_123_1.time_ and arg_123_1.time_ < var_126_16 + var_126_17 then
				local var_126_18 = (arg_123_1.time_ - var_126_16) / var_126_17
				local var_126_19 = Vector3.New(0, 100, 0)

				var_126_15.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos10100ui_story, var_126_19, var_126_18)

				local var_126_20 = manager.ui.mainCamera.transform.position - var_126_15.position

				var_126_15.forward = Vector3.New(var_126_20.x, var_126_20.y, var_126_20.z)

				local var_126_21 = var_126_15.localEulerAngles

				var_126_21.z = 0
				var_126_21.x = 0
				var_126_15.localEulerAngles = var_126_21
			end

			if arg_123_1.time_ >= var_126_16 + var_126_17 and arg_123_1.time_ < var_126_16 + var_126_17 + arg_126_0 then
				var_126_15.localPosition = Vector3.New(0, 100, 0)

				local var_126_22 = manager.ui.mainCamera.transform.position - var_126_15.position

				var_126_15.forward = Vector3.New(var_126_22.x, var_126_22.y, var_126_22.z)

				local var_126_23 = var_126_15.localEulerAngles

				var_126_23.z = 0
				var_126_23.x = 0
				var_126_15.localEulerAngles = var_126_23
			end

			local var_126_24 = arg_123_1.actors_["10100ui_story"]
			local var_126_25 = 0

			if var_126_25 < arg_123_1.time_ and arg_123_1.time_ <= var_126_25 + arg_126_0 and not isNil(var_126_24) and arg_123_1.var_.characterEffect10100ui_story == nil then
				arg_123_1.var_.characterEffect10100ui_story = var_126_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_26 = 0.200000002980232

			if var_126_25 <= arg_123_1.time_ and arg_123_1.time_ < var_126_25 + var_126_26 and not isNil(var_126_24) then
				local var_126_27 = (arg_123_1.time_ - var_126_25) / var_126_26

				if arg_123_1.var_.characterEffect10100ui_story and not isNil(var_126_24) then
					local var_126_28 = Mathf.Lerp(0, 0.5, var_126_27)

					arg_123_1.var_.characterEffect10100ui_story.fillFlat = true
					arg_123_1.var_.characterEffect10100ui_story.fillRatio = var_126_28
				end
			end

			if arg_123_1.time_ >= var_126_25 + var_126_26 and arg_123_1.time_ < var_126_25 + var_126_26 + arg_126_0 and not isNil(var_126_24) and arg_123_1.var_.characterEffect10100ui_story then
				local var_126_29 = 0.5

				arg_123_1.var_.characterEffect10100ui_story.fillFlat = true
				arg_123_1.var_.characterEffect10100ui_story.fillRatio = var_126_29
			end

			local var_126_30 = 0
			local var_126_31 = 1.1

			if var_126_30 < arg_123_1.time_ and arg_123_1.time_ <= var_126_30 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, false)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_32 = arg_123_1:GetWordFromCfg(320061030)
				local var_126_33 = arg_123_1:FormatText(var_126_32.content)

				arg_123_1.text_.text = var_126_33

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_34 = 44
				local var_126_35 = utf8.len(var_126_33)
				local var_126_36 = var_126_34 <= 0 and var_126_31 or var_126_31 * (var_126_35 / var_126_34)

				if var_126_36 > 0 and var_126_31 < var_126_36 then
					arg_123_1.talkMaxDuration = var_126_36

					if var_126_36 + var_126_30 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_36 + var_126_30
					end
				end

				arg_123_1.text_.text = var_126_33
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)
				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_37 = math.max(var_126_31, arg_123_1.talkMaxDuration)

			if var_126_30 <= arg_123_1.time_ and arg_123_1.time_ < var_126_30 + var_126_37 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_30) / var_126_37

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_30 + var_126_37 and arg_123_1.time_ < var_126_30 + var_126_37 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10100ui_story",
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
	Play320061031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 320061031
		arg_127_1.duration_ = 5

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play320061032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = 0
			local var_130_1 = 0.5

			if var_130_0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_0 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				local var_130_2 = arg_127_1:FormatText(StoryNameCfg[7].name)

				arg_127_1.leftNameTxt_.text = var_130_2

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

				local var_130_3 = arg_127_1:GetWordFromCfg(320061031)
				local var_130_4 = arg_127_1:FormatText(var_130_3.content)

				arg_127_1.text_.text = var_130_4

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_5 = 20
				local var_130_6 = utf8.len(var_130_4)
				local var_130_7 = var_130_5 <= 0 and var_130_1 or var_130_1 * (var_130_6 / var_130_5)

				if var_130_7 > 0 and var_130_1 < var_130_7 then
					arg_127_1.talkMaxDuration = var_130_7

					if var_130_7 + var_130_0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_7 + var_130_0
					end
				end

				arg_127_1.text_.text = var_130_4
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_8 = math.max(var_130_1, arg_127_1.talkMaxDuration)

			if var_130_0 <= arg_127_1.time_ and arg_127_1.time_ < var_130_0 + var_130_8 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_0) / var_130_8

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_0 + var_130_8 and arg_127_1.time_ < var_130_0 + var_130_8 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play320061032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 320061032
		arg_131_1.duration_ = 3.97

		local var_131_0 = {
			zh = 1.999999999999,
			ja = 3.966
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
				arg_131_0:Play320061033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = arg_131_1.actors_["1020ui_story"].transform
			local var_134_1 = 0

			if var_134_1 < arg_131_1.time_ and arg_131_1.time_ <= var_134_1 + arg_134_0 then
				arg_131_1.var_.moveOldPos1020ui_story = var_134_0.localPosition
			end

			local var_134_2 = 0.001

			if var_134_1 <= arg_131_1.time_ and arg_131_1.time_ < var_134_1 + var_134_2 then
				local var_134_3 = (arg_131_1.time_ - var_134_1) / var_134_2
				local var_134_4 = Vector3.New(0, -0.85, -6.25)

				var_134_0.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos1020ui_story, var_134_4, var_134_3)

				local var_134_5 = manager.ui.mainCamera.transform.position - var_134_0.position

				var_134_0.forward = Vector3.New(var_134_5.x, var_134_5.y, var_134_5.z)

				local var_134_6 = var_134_0.localEulerAngles

				var_134_6.z = 0
				var_134_6.x = 0
				var_134_0.localEulerAngles = var_134_6
			end

			if arg_131_1.time_ >= var_134_1 + var_134_2 and arg_131_1.time_ < var_134_1 + var_134_2 + arg_134_0 then
				var_134_0.localPosition = Vector3.New(0, -0.85, -6.25)

				local var_134_7 = manager.ui.mainCamera.transform.position - var_134_0.position

				var_134_0.forward = Vector3.New(var_134_7.x, var_134_7.y, var_134_7.z)

				local var_134_8 = var_134_0.localEulerAngles

				var_134_8.z = 0
				var_134_8.x = 0
				var_134_0.localEulerAngles = var_134_8
			end

			local var_134_9 = arg_131_1.actors_["1020ui_story"]
			local var_134_10 = 0

			if var_134_10 < arg_131_1.time_ and arg_131_1.time_ <= var_134_10 + arg_134_0 and not isNil(var_134_9) and arg_131_1.var_.characterEffect1020ui_story == nil then
				arg_131_1.var_.characterEffect1020ui_story = var_134_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_11 = 0.200000002980232

			if var_134_10 <= arg_131_1.time_ and arg_131_1.time_ < var_134_10 + var_134_11 and not isNil(var_134_9) then
				local var_134_12 = (arg_131_1.time_ - var_134_10) / var_134_11

				if arg_131_1.var_.characterEffect1020ui_story and not isNil(var_134_9) then
					arg_131_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_131_1.time_ >= var_134_10 + var_134_11 and arg_131_1.time_ < var_134_10 + var_134_11 + arg_134_0 and not isNil(var_134_9) and arg_131_1.var_.characterEffect1020ui_story then
				arg_131_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_134_13 = 0

			if var_134_13 < arg_131_1.time_ and arg_131_1.time_ <= var_134_13 + arg_134_0 then
				arg_131_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action12_1")
			end

			local var_134_14 = 0

			if var_134_14 < arg_131_1.time_ and arg_131_1.time_ <= var_134_14 + arg_134_0 then
				arg_131_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_134_15 = 0
			local var_134_16 = 0.1

			if var_134_15 < arg_131_1.time_ and arg_131_1.time_ <= var_134_15 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				local var_134_17 = arg_131_1:FormatText(StoryNameCfg[613].name)

				arg_131_1.leftNameTxt_.text = var_134_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_18 = arg_131_1:GetWordFromCfg(320061032)
				local var_134_19 = arg_131_1:FormatText(var_134_18.content)

				arg_131_1.text_.text = var_134_19

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_20 = 4
				local var_134_21 = utf8.len(var_134_19)
				local var_134_22 = var_134_20 <= 0 and var_134_16 or var_134_16 * (var_134_21 / var_134_20)

				if var_134_22 > 0 and var_134_16 < var_134_22 then
					arg_131_1.talkMaxDuration = var_134_22

					if var_134_22 + var_134_15 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_22 + var_134_15
					end
				end

				arg_131_1.text_.text = var_134_19
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320061", "320061032", "story_v_out_320061.awb") ~= 0 then
					local var_134_23 = manager.audio:GetVoiceLength("story_v_out_320061", "320061032", "story_v_out_320061.awb") / 1000

					if var_134_23 + var_134_15 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_23 + var_134_15
					end

					if var_134_18.prefab_name ~= "" and arg_131_1.actors_[var_134_18.prefab_name] ~= nil then
						local var_134_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_18.prefab_name].transform, "story_v_out_320061", "320061032", "story_v_out_320061.awb")

						arg_131_1:RecordAudio("320061032", var_134_24)
						arg_131_1:RecordAudio("320061032", var_134_24)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_320061", "320061032", "story_v_out_320061.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_320061", "320061032", "story_v_out_320061.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_25 = math.max(var_134_16, arg_131_1.talkMaxDuration)

			if var_134_15 <= arg_131_1.time_ and arg_131_1.time_ < var_134_15 + var_134_25 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_15) / var_134_25

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_15 + var_134_25 and arg_131_1.time_ < var_134_15 + var_134_25 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
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
	Play320061033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 320061033
		arg_135_1.duration_ = 5

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play320061034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = arg_135_1.actors_["1020ui_story"].transform
			local var_138_1 = 0

			if var_138_1 < arg_135_1.time_ and arg_135_1.time_ <= var_138_1 + arg_138_0 then
				arg_135_1.var_.moveOldPos1020ui_story = var_138_0.localPosition
			end

			local var_138_2 = 0.001

			if var_138_1 <= arg_135_1.time_ and arg_135_1.time_ < var_138_1 + var_138_2 then
				local var_138_3 = (arg_135_1.time_ - var_138_1) / var_138_2
				local var_138_4 = Vector3.New(0, 100, 0)

				var_138_0.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos1020ui_story, var_138_4, var_138_3)

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

			local var_138_9 = arg_135_1.actors_["1020ui_story"]
			local var_138_10 = 0

			if var_138_10 < arg_135_1.time_ and arg_135_1.time_ <= var_138_10 + arg_138_0 and not isNil(var_138_9) and arg_135_1.var_.characterEffect1020ui_story == nil then
				arg_135_1.var_.characterEffect1020ui_story = var_138_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_11 = 0.200000002980232

			if var_138_10 <= arg_135_1.time_ and arg_135_1.time_ < var_138_10 + var_138_11 and not isNil(var_138_9) then
				local var_138_12 = (arg_135_1.time_ - var_138_10) / var_138_11

				if arg_135_1.var_.characterEffect1020ui_story and not isNil(var_138_9) then
					local var_138_13 = Mathf.Lerp(0, 0.5, var_138_12)

					arg_135_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_135_1.var_.characterEffect1020ui_story.fillRatio = var_138_13
				end
			end

			if arg_135_1.time_ >= var_138_10 + var_138_11 and arg_135_1.time_ < var_138_10 + var_138_11 + arg_138_0 and not isNil(var_138_9) and arg_135_1.var_.characterEffect1020ui_story then
				local var_138_14 = 0.5

				arg_135_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_135_1.var_.characterEffect1020ui_story.fillRatio = var_138_14
			end

			local var_138_15 = 0
			local var_138_16 = 1.175

			if var_138_15 < arg_135_1.time_ and arg_135_1.time_ <= var_138_15 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, false)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_17 = arg_135_1:GetWordFromCfg(320061033)
				local var_138_18 = arg_135_1:FormatText(var_138_17.content)

				arg_135_1.text_.text = var_138_18

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_19 = 47
				local var_138_20 = utf8.len(var_138_18)
				local var_138_21 = var_138_19 <= 0 and var_138_16 or var_138_16 * (var_138_20 / var_138_19)

				if var_138_21 > 0 and var_138_16 < var_138_21 then
					arg_135_1.talkMaxDuration = var_138_21

					if var_138_21 + var_138_15 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_21 + var_138_15
					end
				end

				arg_135_1.text_.text = var_138_18
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)
				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_22 = math.max(var_138_16, arg_135_1.talkMaxDuration)

			if var_138_15 <= arg_135_1.time_ and arg_135_1.time_ < var_138_15 + var_138_22 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_15) / var_138_22

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_15 + var_138_22 and arg_135_1.time_ < var_138_15 + var_138_22 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
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
	Play320061034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 320061034
		arg_139_1.duration_ = 5

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play320061035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = 0
			local var_142_1 = 1.325

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

				local var_142_2 = arg_139_1:GetWordFromCfg(320061034)
				local var_142_3 = arg_139_1:FormatText(var_142_2.content)

				arg_139_1.text_.text = var_142_3

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_4 = 53
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
	Play320061035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 320061035
		arg_143_1.duration_ = 5.87

		local var_143_0 = {
			zh = 5.866,
			ja = 3.1
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
				arg_143_0:Play320061036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = manager.ui.mainCamera.transform
			local var_146_1 = 0

			if var_146_1 < arg_143_1.time_ and arg_143_1.time_ <= var_146_1 + arg_146_0 then
				arg_143_1.var_.shakeOldPos = var_146_0.localPosition
			end

			local var_146_2 = 0.6

			if var_146_1 <= arg_143_1.time_ and arg_143_1.time_ < var_146_1 + var_146_2 then
				local var_146_3 = (arg_143_1.time_ - var_146_1) / 0.066
				local var_146_4, var_146_5 = math.modf(var_146_3)

				var_146_0.localPosition = Vector3.New(var_146_5 * 0.13, var_146_5 * 0.13, var_146_5 * 0.13) + arg_143_1.var_.shakeOldPos
			end

			if arg_143_1.time_ >= var_146_1 + var_146_2 and arg_143_1.time_ < var_146_1 + var_146_2 + arg_146_0 then
				var_146_0.localPosition = arg_143_1.var_.shakeOldPos
			end

			local var_146_6 = 0

			if var_146_6 < arg_143_1.time_ and arg_143_1.time_ <= var_146_6 + arg_146_0 then
				arg_143_1.allBtn_.enabled = false
			end

			local var_146_7 = 0.6

			if arg_143_1.time_ >= var_146_6 + var_146_7 and arg_143_1.time_ < var_146_6 + var_146_7 + arg_146_0 then
				arg_143_1.allBtn_.enabled = true
			end

			local var_146_8 = 0
			local var_146_9 = 0.15

			if var_146_8 < arg_143_1.time_ and arg_143_1.time_ <= var_146_8 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				local var_146_10 = arg_143_1:FormatText(StoryNameCfg[1021].name)

				arg_143_1.leftNameTxt_.text = var_146_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, true)
				arg_143_1.iconController_:SetSelectedState("hero")

				arg_143_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10100")

				arg_143_1.callingController_:SetSelectedState("normal")

				arg_143_1.keyicon_.color = Color.New(1, 1, 1)
				arg_143_1.icon_.color = Color.New(1, 1, 1)

				local var_146_11 = arg_143_1:GetWordFromCfg(320061035)
				local var_146_12 = arg_143_1:FormatText(var_146_11.content)

				arg_143_1.text_.text = var_146_12

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_13 = 6
				local var_146_14 = utf8.len(var_146_12)
				local var_146_15 = var_146_13 <= 0 and var_146_9 or var_146_9 * (var_146_14 / var_146_13)

				if var_146_15 > 0 and var_146_9 < var_146_15 then
					arg_143_1.talkMaxDuration = var_146_15

					if var_146_15 + var_146_8 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_15 + var_146_8
					end
				end

				arg_143_1.text_.text = var_146_12
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320061", "320061035", "story_v_out_320061.awb") ~= 0 then
					local var_146_16 = manager.audio:GetVoiceLength("story_v_out_320061", "320061035", "story_v_out_320061.awb") / 1000

					if var_146_16 + var_146_8 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_16 + var_146_8
					end

					if var_146_11.prefab_name ~= "" and arg_143_1.actors_[var_146_11.prefab_name] ~= nil then
						local var_146_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_11.prefab_name].transform, "story_v_out_320061", "320061035", "story_v_out_320061.awb")

						arg_143_1:RecordAudio("320061035", var_146_17)
						arg_143_1:RecordAudio("320061035", var_146_17)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_320061", "320061035", "story_v_out_320061.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_320061", "320061035", "story_v_out_320061.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_18 = math.max(var_146_9, arg_143_1.talkMaxDuration)

			if var_146_8 <= arg_143_1.time_ and arg_143_1.time_ < var_146_8 + var_146_18 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_8) / var_146_18

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_8 + var_146_18 and arg_143_1.time_ < var_146_8 + var_146_18 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play320061036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 320061036
		arg_147_1.duration_ = 5

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play320061037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = 0
			local var_150_1 = 1.275

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

				local var_150_2 = arg_147_1:GetWordFromCfg(320061036)
				local var_150_3 = arg_147_1:FormatText(var_150_2.content)

				arg_147_1.text_.text = var_150_3

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_4 = 51
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
	Play320061037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 320061037
		arg_151_1.duration_ = 1

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"

			SetActive(arg_151_1.choicesGo_, true)

			for iter_152_0, iter_152_1 in ipairs(arg_151_1.choices_) do
				local var_152_0 = iter_152_0 <= 2

				SetActive(iter_152_1.go, var_152_0)
			end

			arg_151_1.choices_[1].txt.text = arg_151_1:FormatText(StoryChoiceCfg[1110].name)
			arg_151_1.choices_[2].txt.text = arg_151_1:FormatText(StoryChoiceCfg[1111].name)
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play320061038(arg_151_1)
			end

			if arg_153_0 == 2 then
				arg_151_0:Play320061038(arg_151_1)
			end

			arg_151_1:RecordChoiceLog(320061037, 1110, 1111)
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = 0

			if var_154_0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_0 + arg_154_0 then
				arg_151_1.allBtn_.enabled = false
			end

			local var_154_1 = 0.5

			if arg_151_1.time_ >= var_154_0 + var_154_1 and arg_151_1.time_ < var_154_0 + var_154_1 + arg_154_0 then
				arg_151_1.allBtn_.enabled = true
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play320061038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 320061038
		arg_155_1.duration_ = 8.53

		local var_155_0 = {
			zh = 5.166,
			ja = 8.533
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
				arg_155_0:Play320061039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = arg_155_1.actors_["1020ui_story"].transform
			local var_158_1 = 0

			if var_158_1 < arg_155_1.time_ and arg_155_1.time_ <= var_158_1 + arg_158_0 then
				arg_155_1.var_.moveOldPos1020ui_story = var_158_0.localPosition
			end

			local var_158_2 = 0.001

			if var_158_1 <= arg_155_1.time_ and arg_155_1.time_ < var_158_1 + var_158_2 then
				local var_158_3 = (arg_155_1.time_ - var_158_1) / var_158_2
				local var_158_4 = Vector3.New(0, -0.85, -6.25)

				var_158_0.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos1020ui_story, var_158_4, var_158_3)

				local var_158_5 = manager.ui.mainCamera.transform.position - var_158_0.position

				var_158_0.forward = Vector3.New(var_158_5.x, var_158_5.y, var_158_5.z)

				local var_158_6 = var_158_0.localEulerAngles

				var_158_6.z = 0
				var_158_6.x = 0
				var_158_0.localEulerAngles = var_158_6
			end

			if arg_155_1.time_ >= var_158_1 + var_158_2 and arg_155_1.time_ < var_158_1 + var_158_2 + arg_158_0 then
				var_158_0.localPosition = Vector3.New(0, -0.85, -6.25)

				local var_158_7 = manager.ui.mainCamera.transform.position - var_158_0.position

				var_158_0.forward = Vector3.New(var_158_7.x, var_158_7.y, var_158_7.z)

				local var_158_8 = var_158_0.localEulerAngles

				var_158_8.z = 0
				var_158_8.x = 0
				var_158_0.localEulerAngles = var_158_8
			end

			local var_158_9 = arg_155_1.actors_["1020ui_story"]
			local var_158_10 = 0

			if var_158_10 < arg_155_1.time_ and arg_155_1.time_ <= var_158_10 + arg_158_0 and not isNil(var_158_9) and arg_155_1.var_.characterEffect1020ui_story == nil then
				arg_155_1.var_.characterEffect1020ui_story = var_158_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_11 = 0.200000002980232

			if var_158_10 <= arg_155_1.time_ and arg_155_1.time_ < var_158_10 + var_158_11 and not isNil(var_158_9) then
				local var_158_12 = (arg_155_1.time_ - var_158_10) / var_158_11

				if arg_155_1.var_.characterEffect1020ui_story and not isNil(var_158_9) then
					arg_155_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_155_1.time_ >= var_158_10 + var_158_11 and arg_155_1.time_ < var_158_10 + var_158_11 + arg_158_0 and not isNil(var_158_9) and arg_155_1.var_.characterEffect1020ui_story then
				arg_155_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_158_13 = "1020ui_story"

			if arg_155_1.actors_[var_158_13] == nil then
				local var_158_14 = Asset.Load("Char/" .. "1020ui_story")

				if not isNil(var_158_14) then
					local var_158_15 = Object.Instantiate(Asset.Load("Char/" .. "1020ui_story"), arg_155_1.stage_.transform)

					var_158_15.name = var_158_13
					var_158_15.transform.localPosition = Vector3.New(0, 100, 0)
					arg_155_1.actors_[var_158_13] = var_158_15

					local var_158_16 = var_158_15:GetComponentInChildren(typeof(CharacterEffect))

					var_158_16.enabled = true

					local var_158_17 = GameObjectTools.GetOrAddComponent(var_158_15, typeof(DynamicBoneHelper))

					if var_158_17 then
						var_158_17:EnableDynamicBone(false)
					end

					arg_155_1:ShowWeapon(var_158_16.transform, false)

					arg_155_1.var_[var_158_13 .. "Animator"] = var_158_16.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_155_1.var_[var_158_13 .. "Animator"].applyRootMotion = true
					arg_155_1.var_[var_158_13 .. "LipSync"] = var_158_16.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_158_18 = 0

			if var_158_18 < arg_155_1.time_ and arg_155_1.time_ <= var_158_18 + arg_158_0 then
				arg_155_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action6_1")
			end

			local var_158_19 = "1020ui_story"

			if arg_155_1.actors_[var_158_19] == nil then
				local var_158_20 = Asset.Load("Char/" .. "1020ui_story")

				if not isNil(var_158_20) then
					local var_158_21 = Object.Instantiate(Asset.Load("Char/" .. "1020ui_story"), arg_155_1.stage_.transform)

					var_158_21.name = var_158_19
					var_158_21.transform.localPosition = Vector3.New(0, 100, 0)
					arg_155_1.actors_[var_158_19] = var_158_21

					local var_158_22 = var_158_21:GetComponentInChildren(typeof(CharacterEffect))

					var_158_22.enabled = true

					local var_158_23 = GameObjectTools.GetOrAddComponent(var_158_21, typeof(DynamicBoneHelper))

					if var_158_23 then
						var_158_23:EnableDynamicBone(false)
					end

					arg_155_1:ShowWeapon(var_158_22.transform, false)

					arg_155_1.var_[var_158_19 .. "Animator"] = var_158_22.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_155_1.var_[var_158_19 .. "Animator"].applyRootMotion = true
					arg_155_1.var_[var_158_19 .. "LipSync"] = var_158_22.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_158_24 = 0

			if var_158_24 < arg_155_1.time_ and arg_155_1.time_ <= var_158_24 + arg_158_0 then
				arg_155_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_158_25 = 0
			local var_158_26 = 0.65

			if var_158_25 < arg_155_1.time_ and arg_155_1.time_ <= var_158_25 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				local var_158_27 = arg_155_1:FormatText(StoryNameCfg[613].name)

				arg_155_1.leftNameTxt_.text = var_158_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_28 = arg_155_1:GetWordFromCfg(320061038)
				local var_158_29 = arg_155_1:FormatText(var_158_28.content)

				arg_155_1.text_.text = var_158_29

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_30 = 26
				local var_158_31 = utf8.len(var_158_29)
				local var_158_32 = var_158_30 <= 0 and var_158_26 or var_158_26 * (var_158_31 / var_158_30)

				if var_158_32 > 0 and var_158_26 < var_158_32 then
					arg_155_1.talkMaxDuration = var_158_32

					if var_158_32 + var_158_25 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_32 + var_158_25
					end
				end

				arg_155_1.text_.text = var_158_29
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320061", "320061038", "story_v_out_320061.awb") ~= 0 then
					local var_158_33 = manager.audio:GetVoiceLength("story_v_out_320061", "320061038", "story_v_out_320061.awb") / 1000

					if var_158_33 + var_158_25 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_33 + var_158_25
					end

					if var_158_28.prefab_name ~= "" and arg_155_1.actors_[var_158_28.prefab_name] ~= nil then
						local var_158_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_28.prefab_name].transform, "story_v_out_320061", "320061038", "story_v_out_320061.awb")

						arg_155_1:RecordAudio("320061038", var_158_34)
						arg_155_1:RecordAudio("320061038", var_158_34)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_320061", "320061038", "story_v_out_320061.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_320061", "320061038", "story_v_out_320061.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_35 = math.max(var_158_26, arg_155_1.talkMaxDuration)

			if var_158_25 <= arg_155_1.time_ and arg_155_1.time_ < var_158_25 + var_158_35 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_25) / var_158_35

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_25 + var_158_35 and arg_155_1.time_ < var_158_25 + var_158_35 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_155_1:InitPlayNodeList()
	end,
	Play320061039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 320061039
		arg_159_1.duration_ = 5

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play320061040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = arg_159_1.actors_["1020ui_story"]
			local var_162_1 = 0

			if var_162_1 < arg_159_1.time_ and arg_159_1.time_ <= var_162_1 + arg_162_0 and not isNil(var_162_0) and arg_159_1.var_.characterEffect1020ui_story == nil then
				arg_159_1.var_.characterEffect1020ui_story = var_162_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_2 = 0.200000002980232

			if var_162_1 <= arg_159_1.time_ and arg_159_1.time_ < var_162_1 + var_162_2 and not isNil(var_162_0) then
				local var_162_3 = (arg_159_1.time_ - var_162_1) / var_162_2

				if arg_159_1.var_.characterEffect1020ui_story and not isNil(var_162_0) then
					local var_162_4 = Mathf.Lerp(0, 0.5, var_162_3)

					arg_159_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_159_1.var_.characterEffect1020ui_story.fillRatio = var_162_4
				end
			end

			if arg_159_1.time_ >= var_162_1 + var_162_2 and arg_159_1.time_ < var_162_1 + var_162_2 + arg_162_0 and not isNil(var_162_0) and arg_159_1.var_.characterEffect1020ui_story then
				local var_162_5 = 0.5

				arg_159_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_159_1.var_.characterEffect1020ui_story.fillRatio = var_162_5
			end

			local var_162_6 = 0
			local var_162_7 = 0.675

			if var_162_6 < arg_159_1.time_ and arg_159_1.time_ <= var_162_6 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				local var_162_8 = arg_159_1:FormatText(StoryNameCfg[7].name)

				arg_159_1.leftNameTxt_.text = var_162_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, true)
				arg_159_1.iconController_:SetSelectedState("hero")

				arg_159_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_159_1.callingController_:SetSelectedState("normal")

				arg_159_1.keyicon_.color = Color.New(1, 1, 1)
				arg_159_1.icon_.color = Color.New(1, 1, 1)

				local var_162_9 = arg_159_1:GetWordFromCfg(320061039)
				local var_162_10 = arg_159_1:FormatText(var_162_9.content)

				arg_159_1.text_.text = var_162_10

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_11 = 27
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
				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_14 = math.max(var_162_7, arg_159_1.talkMaxDuration)

			if var_162_6 <= arg_159_1.time_ and arg_159_1.time_ < var_162_6 + var_162_14 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_6) / var_162_14

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_6 + var_162_14 and arg_159_1.time_ < var_162_6 + var_162_14 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play320061040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 320061040
		arg_163_1.duration_ = 9

		local var_163_0 = {
			zh = 8,
			ja = 9
		}
		local var_163_1 = manager.audio:GetLocalizationFlag()

		if var_163_0[var_163_1] ~= nil then
			arg_163_1.duration_ = var_163_0[var_163_1]
		end

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play320061041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = arg_163_1.actors_["1020ui_story"].transform
			local var_166_1 = 0

			if var_166_1 < arg_163_1.time_ and arg_163_1.time_ <= var_166_1 + arg_166_0 then
				arg_163_1.var_.moveOldPos1020ui_story = var_166_0.localPosition
			end

			local var_166_2 = 0.001

			if var_166_1 <= arg_163_1.time_ and arg_163_1.time_ < var_166_1 + var_166_2 then
				local var_166_3 = (arg_163_1.time_ - var_166_1) / var_166_2
				local var_166_4 = Vector3.New(0, -0.85, -6.25)

				var_166_0.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos1020ui_story, var_166_4, var_166_3)

				local var_166_5 = manager.ui.mainCamera.transform.position - var_166_0.position

				var_166_0.forward = Vector3.New(var_166_5.x, var_166_5.y, var_166_5.z)

				local var_166_6 = var_166_0.localEulerAngles

				var_166_6.z = 0
				var_166_6.x = 0
				var_166_0.localEulerAngles = var_166_6
			end

			if arg_163_1.time_ >= var_166_1 + var_166_2 and arg_163_1.time_ < var_166_1 + var_166_2 + arg_166_0 then
				var_166_0.localPosition = Vector3.New(0, -0.85, -6.25)

				local var_166_7 = manager.ui.mainCamera.transform.position - var_166_0.position

				var_166_0.forward = Vector3.New(var_166_7.x, var_166_7.y, var_166_7.z)

				local var_166_8 = var_166_0.localEulerAngles

				var_166_8.z = 0
				var_166_8.x = 0
				var_166_0.localEulerAngles = var_166_8
			end

			local var_166_9 = arg_163_1.actors_["1020ui_story"]
			local var_166_10 = 0

			if var_166_10 < arg_163_1.time_ and arg_163_1.time_ <= var_166_10 + arg_166_0 and not isNil(var_166_9) and arg_163_1.var_.characterEffect1020ui_story == nil then
				arg_163_1.var_.characterEffect1020ui_story = var_166_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_11 = 0.200000002980232

			if var_166_10 <= arg_163_1.time_ and arg_163_1.time_ < var_166_10 + var_166_11 and not isNil(var_166_9) then
				local var_166_12 = (arg_163_1.time_ - var_166_10) / var_166_11

				if arg_163_1.var_.characterEffect1020ui_story and not isNil(var_166_9) then
					arg_163_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_163_1.time_ >= var_166_10 + var_166_11 and arg_163_1.time_ < var_166_10 + var_166_11 + arg_166_0 and not isNil(var_166_9) and arg_163_1.var_.characterEffect1020ui_story then
				arg_163_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_166_13 = 0

			if var_166_13 < arg_163_1.time_ and arg_163_1.time_ <= var_166_13 + arg_166_0 then
				arg_163_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020actionlink/1020action468")
			end

			local var_166_14 = 0

			if var_166_14 < arg_163_1.time_ and arg_163_1.time_ <= var_166_14 + arg_166_0 then
				arg_163_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_166_15 = 0
			local var_166_16 = 0.775

			if var_166_15 < arg_163_1.time_ and arg_163_1.time_ <= var_166_15 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				local var_166_17 = arg_163_1:FormatText(StoryNameCfg[613].name)

				arg_163_1.leftNameTxt_.text = var_166_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_18 = arg_163_1:GetWordFromCfg(320061040)
				local var_166_19 = arg_163_1:FormatText(var_166_18.content)

				arg_163_1.text_.text = var_166_19

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_20 = 31
				local var_166_21 = utf8.len(var_166_19)
				local var_166_22 = var_166_20 <= 0 and var_166_16 or var_166_16 * (var_166_21 / var_166_20)

				if var_166_22 > 0 and var_166_16 < var_166_22 then
					arg_163_1.talkMaxDuration = var_166_22

					if var_166_22 + var_166_15 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_22 + var_166_15
					end
				end

				arg_163_1.text_.text = var_166_19
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320061", "320061040", "story_v_out_320061.awb") ~= 0 then
					local var_166_23 = manager.audio:GetVoiceLength("story_v_out_320061", "320061040", "story_v_out_320061.awb") / 1000

					if var_166_23 + var_166_15 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_23 + var_166_15
					end

					if var_166_18.prefab_name ~= "" and arg_163_1.actors_[var_166_18.prefab_name] ~= nil then
						local var_166_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_18.prefab_name].transform, "story_v_out_320061", "320061040", "story_v_out_320061.awb")

						arg_163_1:RecordAudio("320061040", var_166_24)
						arg_163_1:RecordAudio("320061040", var_166_24)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_320061", "320061040", "story_v_out_320061.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_320061", "320061040", "story_v_out_320061.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_25 = math.max(var_166_16, arg_163_1.talkMaxDuration)

			if var_166_15 <= arg_163_1.time_ and arg_163_1.time_ < var_166_15 + var_166_25 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_15) / var_166_25

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_15 + var_166_25 and arg_163_1.time_ < var_166_15 + var_166_25 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_163_1:InitPlayNodeList()
	end,
	Play320061041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 320061041
		arg_167_1.duration_ = 5.8

		local var_167_0 = {
			zh = 4,
			ja = 5.8
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
				arg_167_0:Play320061042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = arg_167_1.actors_["1020ui_story"].transform
			local var_170_1 = 0

			if var_170_1 < arg_167_1.time_ and arg_167_1.time_ <= var_170_1 + arg_170_0 then
				arg_167_1.var_.moveOldPos1020ui_story = var_170_0.localPosition
			end

			local var_170_2 = 0.001

			if var_170_1 <= arg_167_1.time_ and arg_167_1.time_ < var_170_1 + var_170_2 then
				local var_170_3 = (arg_167_1.time_ - var_170_1) / var_170_2
				local var_170_4 = Vector3.New(0, -0.85, -6.25)

				var_170_0.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos1020ui_story, var_170_4, var_170_3)

				local var_170_5 = manager.ui.mainCamera.transform.position - var_170_0.position

				var_170_0.forward = Vector3.New(var_170_5.x, var_170_5.y, var_170_5.z)

				local var_170_6 = var_170_0.localEulerAngles

				var_170_6.z = 0
				var_170_6.x = 0
				var_170_0.localEulerAngles = var_170_6
			end

			if arg_167_1.time_ >= var_170_1 + var_170_2 and arg_167_1.time_ < var_170_1 + var_170_2 + arg_170_0 then
				var_170_0.localPosition = Vector3.New(0, -0.85, -6.25)

				local var_170_7 = manager.ui.mainCamera.transform.position - var_170_0.position

				var_170_0.forward = Vector3.New(var_170_7.x, var_170_7.y, var_170_7.z)

				local var_170_8 = var_170_0.localEulerAngles

				var_170_8.z = 0
				var_170_8.x = 0
				var_170_0.localEulerAngles = var_170_8
			end

			local var_170_9 = arg_167_1.actors_["1020ui_story"]
			local var_170_10 = 0

			if var_170_10 < arg_167_1.time_ and arg_167_1.time_ <= var_170_10 + arg_170_0 and not isNil(var_170_9) and arg_167_1.var_.characterEffect1020ui_story == nil then
				arg_167_1.var_.characterEffect1020ui_story = var_170_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_11 = 0.200000002980232

			if var_170_10 <= arg_167_1.time_ and arg_167_1.time_ < var_170_10 + var_170_11 and not isNil(var_170_9) then
				local var_170_12 = (arg_167_1.time_ - var_170_10) / var_170_11

				if arg_167_1.var_.characterEffect1020ui_story and not isNil(var_170_9) then
					arg_167_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_167_1.time_ >= var_170_10 + var_170_11 and arg_167_1.time_ < var_170_10 + var_170_11 + arg_170_0 and not isNil(var_170_9) and arg_167_1.var_.characterEffect1020ui_story then
				arg_167_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_170_13 = 0

			if var_170_13 < arg_167_1.time_ and arg_167_1.time_ <= var_170_13 + arg_170_0 then
				arg_167_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action8_2")
			end

			local var_170_14 = 0

			if var_170_14 < arg_167_1.time_ and arg_167_1.time_ <= var_170_14 + arg_170_0 then
				arg_167_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_170_15 = 0
			local var_170_16 = 0.525

			if var_170_15 < arg_167_1.time_ and arg_167_1.time_ <= var_170_15 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				local var_170_17 = arg_167_1:FormatText(StoryNameCfg[613].name)

				arg_167_1.leftNameTxt_.text = var_170_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_18 = arg_167_1:GetWordFromCfg(320061041)
				local var_170_19 = arg_167_1:FormatText(var_170_18.content)

				arg_167_1.text_.text = var_170_19

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_20 = 21
				local var_170_21 = utf8.len(var_170_19)
				local var_170_22 = var_170_20 <= 0 and var_170_16 or var_170_16 * (var_170_21 / var_170_20)

				if var_170_22 > 0 and var_170_16 < var_170_22 then
					arg_167_1.talkMaxDuration = var_170_22

					if var_170_22 + var_170_15 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_22 + var_170_15
					end
				end

				arg_167_1.text_.text = var_170_19
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320061", "320061041", "story_v_out_320061.awb") ~= 0 then
					local var_170_23 = manager.audio:GetVoiceLength("story_v_out_320061", "320061041", "story_v_out_320061.awb") / 1000

					if var_170_23 + var_170_15 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_23 + var_170_15
					end

					if var_170_18.prefab_name ~= "" and arg_167_1.actors_[var_170_18.prefab_name] ~= nil then
						local var_170_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_18.prefab_name].transform, "story_v_out_320061", "320061041", "story_v_out_320061.awb")

						arg_167_1:RecordAudio("320061041", var_170_24)
						arg_167_1:RecordAudio("320061041", var_170_24)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_320061", "320061041", "story_v_out_320061.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_320061", "320061041", "story_v_out_320061.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_25 = math.max(var_170_16, arg_167_1.talkMaxDuration)

			if var_170_15 <= arg_167_1.time_ and arg_167_1.time_ < var_170_15 + var_170_25 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_15) / var_170_25

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_15 + var_170_25 and arg_167_1.time_ < var_170_15 + var_170_25 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
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
	Play320061042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 320061042
		arg_171_1.duration_ = 9.27

		local var_171_0 = {
			zh = 9,
			ja = 9.266
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
				arg_171_0:Play320061043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = arg_171_1.actors_["1020ui_story"].transform
			local var_174_1 = 0

			if var_174_1 < arg_171_1.time_ and arg_171_1.time_ <= var_174_1 + arg_174_0 then
				arg_171_1.var_.moveOldPos1020ui_story = var_174_0.localPosition
			end

			local var_174_2 = 0.001

			if var_174_1 <= arg_171_1.time_ and arg_171_1.time_ < var_174_1 + var_174_2 then
				local var_174_3 = (arg_171_1.time_ - var_174_1) / var_174_2
				local var_174_4 = Vector3.New(-0.7, -0.85, -6.25)

				var_174_0.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos1020ui_story, var_174_4, var_174_3)

				local var_174_5 = manager.ui.mainCamera.transform.position - var_174_0.position

				var_174_0.forward = Vector3.New(var_174_5.x, var_174_5.y, var_174_5.z)

				local var_174_6 = var_174_0.localEulerAngles

				var_174_6.z = 0
				var_174_6.x = 0
				var_174_0.localEulerAngles = var_174_6
			end

			if arg_171_1.time_ >= var_174_1 + var_174_2 and arg_171_1.time_ < var_174_1 + var_174_2 + arg_174_0 then
				var_174_0.localPosition = Vector3.New(-0.7, -0.85, -6.25)

				local var_174_7 = manager.ui.mainCamera.transform.position - var_174_0.position

				var_174_0.forward = Vector3.New(var_174_7.x, var_174_7.y, var_174_7.z)

				local var_174_8 = var_174_0.localEulerAngles

				var_174_8.z = 0
				var_174_8.x = 0
				var_174_0.localEulerAngles = var_174_8
			end

			local var_174_9 = arg_171_1.actors_["1020ui_story"]
			local var_174_10 = 0

			if var_174_10 < arg_171_1.time_ and arg_171_1.time_ <= var_174_10 + arg_174_0 and not isNil(var_174_9) and arg_171_1.var_.characterEffect1020ui_story == nil then
				arg_171_1.var_.characterEffect1020ui_story = var_174_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_11 = 0.200000002980232

			if var_174_10 <= arg_171_1.time_ and arg_171_1.time_ < var_174_10 + var_174_11 and not isNil(var_174_9) then
				local var_174_12 = (arg_171_1.time_ - var_174_10) / var_174_11

				if arg_171_1.var_.characterEffect1020ui_story and not isNil(var_174_9) then
					local var_174_13 = Mathf.Lerp(0, 0.5, var_174_12)

					arg_171_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_171_1.var_.characterEffect1020ui_story.fillRatio = var_174_13
				end
			end

			if arg_171_1.time_ >= var_174_10 + var_174_11 and arg_171_1.time_ < var_174_10 + var_174_11 + arg_174_0 and not isNil(var_174_9) and arg_171_1.var_.characterEffect1020ui_story then
				local var_174_14 = 0.5

				arg_171_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_171_1.var_.characterEffect1020ui_story.fillRatio = var_174_14
			end

			local var_174_15 = arg_171_1.actors_["10100ui_story"].transform
			local var_174_16 = 0

			if var_174_16 < arg_171_1.time_ and arg_171_1.time_ <= var_174_16 + arg_174_0 then
				arg_171_1.var_.moveOldPos10100ui_story = var_174_15.localPosition
			end

			local var_174_17 = 0.001

			if var_174_16 <= arg_171_1.time_ and arg_171_1.time_ < var_174_16 + var_174_17 then
				local var_174_18 = (arg_171_1.time_ - var_174_16) / var_174_17
				local var_174_19 = Vector3.New(0.7, -1.16, -6.25)

				var_174_15.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos10100ui_story, var_174_19, var_174_18)

				local var_174_20 = manager.ui.mainCamera.transform.position - var_174_15.position

				var_174_15.forward = Vector3.New(var_174_20.x, var_174_20.y, var_174_20.z)

				local var_174_21 = var_174_15.localEulerAngles

				var_174_21.z = 0
				var_174_21.x = 0
				var_174_15.localEulerAngles = var_174_21
			end

			if arg_171_1.time_ >= var_174_16 + var_174_17 and arg_171_1.time_ < var_174_16 + var_174_17 + arg_174_0 then
				var_174_15.localPosition = Vector3.New(0.7, -1.16, -6.25)

				local var_174_22 = manager.ui.mainCamera.transform.position - var_174_15.position

				var_174_15.forward = Vector3.New(var_174_22.x, var_174_22.y, var_174_22.z)

				local var_174_23 = var_174_15.localEulerAngles

				var_174_23.z = 0
				var_174_23.x = 0
				var_174_15.localEulerAngles = var_174_23
			end

			local var_174_24 = arg_171_1.actors_["10100ui_story"]
			local var_174_25 = 0

			if var_174_25 < arg_171_1.time_ and arg_171_1.time_ <= var_174_25 + arg_174_0 and not isNil(var_174_24) and arg_171_1.var_.characterEffect10100ui_story == nil then
				arg_171_1.var_.characterEffect10100ui_story = var_174_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_26 = 0.200000002980232

			if var_174_25 <= arg_171_1.time_ and arg_171_1.time_ < var_174_25 + var_174_26 and not isNil(var_174_24) then
				local var_174_27 = (arg_171_1.time_ - var_174_25) / var_174_26

				if arg_171_1.var_.characterEffect10100ui_story and not isNil(var_174_24) then
					arg_171_1.var_.characterEffect10100ui_story.fillFlat = false
				end
			end

			if arg_171_1.time_ >= var_174_25 + var_174_26 and arg_171_1.time_ < var_174_25 + var_174_26 + arg_174_0 and not isNil(var_174_24) and arg_171_1.var_.characterEffect10100ui_story then
				arg_171_1.var_.characterEffect10100ui_story.fillFlat = false
			end

			local var_174_28 = 0

			if var_174_28 < arg_171_1.time_ and arg_171_1.time_ <= var_174_28 + arg_174_0 then
				arg_171_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action24_1")
			end

			local var_174_29 = 0

			if var_174_29 < arg_171_1.time_ and arg_171_1.time_ <= var_174_29 + arg_174_0 then
				arg_171_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_174_30 = 0
			local var_174_31 = 0.75

			if var_174_30 < arg_171_1.time_ and arg_171_1.time_ <= var_174_30 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				local var_174_32 = arg_171_1:FormatText(StoryNameCfg[1021].name)

				arg_171_1.leftNameTxt_.text = var_174_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_33 = arg_171_1:GetWordFromCfg(320061042)
				local var_174_34 = arg_171_1:FormatText(var_174_33.content)

				arg_171_1.text_.text = var_174_34

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_35 = 30
				local var_174_36 = utf8.len(var_174_34)
				local var_174_37 = var_174_35 <= 0 and var_174_31 or var_174_31 * (var_174_36 / var_174_35)

				if var_174_37 > 0 and var_174_31 < var_174_37 then
					arg_171_1.talkMaxDuration = var_174_37

					if var_174_37 + var_174_30 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_37 + var_174_30
					end
				end

				arg_171_1.text_.text = var_174_34
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320061", "320061042", "story_v_out_320061.awb") ~= 0 then
					local var_174_38 = manager.audio:GetVoiceLength("story_v_out_320061", "320061042", "story_v_out_320061.awb") / 1000

					if var_174_38 + var_174_30 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_38 + var_174_30
					end

					if var_174_33.prefab_name ~= "" and arg_171_1.actors_[var_174_33.prefab_name] ~= nil then
						local var_174_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_33.prefab_name].transform, "story_v_out_320061", "320061042", "story_v_out_320061.awb")

						arg_171_1:RecordAudio("320061042", var_174_39)
						arg_171_1:RecordAudio("320061042", var_174_39)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_320061", "320061042", "story_v_out_320061.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_320061", "320061042", "story_v_out_320061.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_40 = math.max(var_174_31, arg_171_1.talkMaxDuration)

			if var_174_30 <= arg_171_1.time_ and arg_171_1.time_ < var_174_30 + var_174_40 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_30) / var_174_40

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_30 + var_174_40 and arg_171_1.time_ < var_174_30 + var_174_40 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10100ui_story",
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
	Play320061043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 320061043
		arg_175_1.duration_ = 5

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play320061044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = arg_175_1.actors_["1020ui_story"].transform
			local var_178_1 = 0

			if var_178_1 < arg_175_1.time_ and arg_175_1.time_ <= var_178_1 + arg_178_0 then
				arg_175_1.var_.moveOldPos1020ui_story = var_178_0.localPosition
			end

			local var_178_2 = 0.001

			if var_178_1 <= arg_175_1.time_ and arg_175_1.time_ < var_178_1 + var_178_2 then
				local var_178_3 = (arg_175_1.time_ - var_178_1) / var_178_2
				local var_178_4 = Vector3.New(0, 100, 0)

				var_178_0.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos1020ui_story, var_178_4, var_178_3)

				local var_178_5 = manager.ui.mainCamera.transform.position - var_178_0.position

				var_178_0.forward = Vector3.New(var_178_5.x, var_178_5.y, var_178_5.z)

				local var_178_6 = var_178_0.localEulerAngles

				var_178_6.z = 0
				var_178_6.x = 0
				var_178_0.localEulerAngles = var_178_6
			end

			if arg_175_1.time_ >= var_178_1 + var_178_2 and arg_175_1.time_ < var_178_1 + var_178_2 + arg_178_0 then
				var_178_0.localPosition = Vector3.New(0, 100, 0)

				local var_178_7 = manager.ui.mainCamera.transform.position - var_178_0.position

				var_178_0.forward = Vector3.New(var_178_7.x, var_178_7.y, var_178_7.z)

				local var_178_8 = var_178_0.localEulerAngles

				var_178_8.z = 0
				var_178_8.x = 0
				var_178_0.localEulerAngles = var_178_8
			end

			local var_178_9 = arg_175_1.actors_["1020ui_story"]
			local var_178_10 = 0

			if var_178_10 < arg_175_1.time_ and arg_175_1.time_ <= var_178_10 + arg_178_0 and not isNil(var_178_9) and arg_175_1.var_.characterEffect1020ui_story == nil then
				arg_175_1.var_.characterEffect1020ui_story = var_178_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_11 = 0.200000002980232

			if var_178_10 <= arg_175_1.time_ and arg_175_1.time_ < var_178_10 + var_178_11 and not isNil(var_178_9) then
				local var_178_12 = (arg_175_1.time_ - var_178_10) / var_178_11

				if arg_175_1.var_.characterEffect1020ui_story and not isNil(var_178_9) then
					local var_178_13 = Mathf.Lerp(0, 0.5, var_178_12)

					arg_175_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_175_1.var_.characterEffect1020ui_story.fillRatio = var_178_13
				end
			end

			if arg_175_1.time_ >= var_178_10 + var_178_11 and arg_175_1.time_ < var_178_10 + var_178_11 + arg_178_0 and not isNil(var_178_9) and arg_175_1.var_.characterEffect1020ui_story then
				local var_178_14 = 0.5

				arg_175_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_175_1.var_.characterEffect1020ui_story.fillRatio = var_178_14
			end

			local var_178_15 = arg_175_1.actors_["10100ui_story"].transform
			local var_178_16 = 0

			if var_178_16 < arg_175_1.time_ and arg_175_1.time_ <= var_178_16 + arg_178_0 then
				arg_175_1.var_.moveOldPos10100ui_story = var_178_15.localPosition
			end

			local var_178_17 = 0.001

			if var_178_16 <= arg_175_1.time_ and arg_175_1.time_ < var_178_16 + var_178_17 then
				local var_178_18 = (arg_175_1.time_ - var_178_16) / var_178_17
				local var_178_19 = Vector3.New(0, 100, 0)

				var_178_15.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos10100ui_story, var_178_19, var_178_18)

				local var_178_20 = manager.ui.mainCamera.transform.position - var_178_15.position

				var_178_15.forward = Vector3.New(var_178_20.x, var_178_20.y, var_178_20.z)

				local var_178_21 = var_178_15.localEulerAngles

				var_178_21.z = 0
				var_178_21.x = 0
				var_178_15.localEulerAngles = var_178_21
			end

			if arg_175_1.time_ >= var_178_16 + var_178_17 and arg_175_1.time_ < var_178_16 + var_178_17 + arg_178_0 then
				var_178_15.localPosition = Vector3.New(0, 100, 0)

				local var_178_22 = manager.ui.mainCamera.transform.position - var_178_15.position

				var_178_15.forward = Vector3.New(var_178_22.x, var_178_22.y, var_178_22.z)

				local var_178_23 = var_178_15.localEulerAngles

				var_178_23.z = 0
				var_178_23.x = 0
				var_178_15.localEulerAngles = var_178_23
			end

			local var_178_24 = arg_175_1.actors_["10100ui_story"]
			local var_178_25 = 0

			if var_178_25 < arg_175_1.time_ and arg_175_1.time_ <= var_178_25 + arg_178_0 and not isNil(var_178_24) and arg_175_1.var_.characterEffect10100ui_story == nil then
				arg_175_1.var_.characterEffect10100ui_story = var_178_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_26 = 0.200000002980232

			if var_178_25 <= arg_175_1.time_ and arg_175_1.time_ < var_178_25 + var_178_26 and not isNil(var_178_24) then
				local var_178_27 = (arg_175_1.time_ - var_178_25) / var_178_26

				if arg_175_1.var_.characterEffect10100ui_story and not isNil(var_178_24) then
					local var_178_28 = Mathf.Lerp(0, 0.5, var_178_27)

					arg_175_1.var_.characterEffect10100ui_story.fillFlat = true
					arg_175_1.var_.characterEffect10100ui_story.fillRatio = var_178_28
				end
			end

			if arg_175_1.time_ >= var_178_25 + var_178_26 and arg_175_1.time_ < var_178_25 + var_178_26 + arg_178_0 and not isNil(var_178_24) and arg_175_1.var_.characterEffect10100ui_story then
				local var_178_29 = 0.5

				arg_175_1.var_.characterEffect10100ui_story.fillFlat = true
				arg_175_1.var_.characterEffect10100ui_story.fillRatio = var_178_29
			end

			local var_178_30 = 0
			local var_178_31 = 1.325

			if var_178_30 < arg_175_1.time_ and arg_175_1.time_ <= var_178_30 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, false)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_32 = arg_175_1:GetWordFromCfg(320061043)
				local var_178_33 = arg_175_1:FormatText(var_178_32.content)

				arg_175_1.text_.text = var_178_33

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_34 = 53
				local var_178_35 = utf8.len(var_178_33)
				local var_178_36 = var_178_34 <= 0 and var_178_31 or var_178_31 * (var_178_35 / var_178_34)

				if var_178_36 > 0 and var_178_31 < var_178_36 then
					arg_175_1.talkMaxDuration = var_178_36

					if var_178_36 + var_178_30 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_36 + var_178_30
					end
				end

				arg_175_1.text_.text = var_178_33
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)
				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_37 = math.max(var_178_31, arg_175_1.talkMaxDuration)

			if var_178_30 <= arg_175_1.time_ and arg_175_1.time_ < var_178_30 + var_178_37 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_30) / var_178_37

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_30 + var_178_37 and arg_175_1.time_ < var_178_30 + var_178_37 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10100ui_story",
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
	Play320061044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 320061044
		arg_179_1.duration_ = 5

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play320061045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = 0
			local var_182_1 = 0.875

			if var_182_0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_0 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, false)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_2 = arg_179_1:GetWordFromCfg(320061044)
				local var_182_3 = arg_179_1:FormatText(var_182_2.content)

				arg_179_1.text_.text = var_182_3

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_4 = 35
				local var_182_5 = utf8.len(var_182_3)
				local var_182_6 = var_182_4 <= 0 and var_182_1 or var_182_1 * (var_182_5 / var_182_4)

				if var_182_6 > 0 and var_182_1 < var_182_6 then
					arg_179_1.talkMaxDuration = var_182_6

					if var_182_6 + var_182_0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_6 + var_182_0
					end
				end

				arg_179_1.text_.text = var_182_3
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)
				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_7 = math.max(var_182_1, arg_179_1.talkMaxDuration)

			if var_182_0 <= arg_179_1.time_ and arg_179_1.time_ < var_182_0 + var_182_7 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_0) / var_182_7

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_0 + var_182_7 and arg_179_1.time_ < var_182_0 + var_182_7 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play320061045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 320061045
		arg_183_1.duration_ = 3.17

		local var_183_0 = {
			zh = 1.9,
			ja = 3.166
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
				arg_183_0:Play320061046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = arg_183_1.actors_["1020ui_story"].transform
			local var_186_1 = 0

			if var_186_1 < arg_183_1.time_ and arg_183_1.time_ <= var_186_1 + arg_186_0 then
				arg_183_1.var_.moveOldPos1020ui_story = var_186_0.localPosition
			end

			local var_186_2 = 0.001

			if var_186_1 <= arg_183_1.time_ and arg_183_1.time_ < var_186_1 + var_186_2 then
				local var_186_3 = (arg_183_1.time_ - var_186_1) / var_186_2
				local var_186_4 = Vector3.New(0, -0.85, -6.25)

				var_186_0.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos1020ui_story, var_186_4, var_186_3)

				local var_186_5 = manager.ui.mainCamera.transform.position - var_186_0.position

				var_186_0.forward = Vector3.New(var_186_5.x, var_186_5.y, var_186_5.z)

				local var_186_6 = var_186_0.localEulerAngles

				var_186_6.z = 0
				var_186_6.x = 0
				var_186_0.localEulerAngles = var_186_6
			end

			if arg_183_1.time_ >= var_186_1 + var_186_2 and arg_183_1.time_ < var_186_1 + var_186_2 + arg_186_0 then
				var_186_0.localPosition = Vector3.New(0, -0.85, -6.25)

				local var_186_7 = manager.ui.mainCamera.transform.position - var_186_0.position

				var_186_0.forward = Vector3.New(var_186_7.x, var_186_7.y, var_186_7.z)

				local var_186_8 = var_186_0.localEulerAngles

				var_186_8.z = 0
				var_186_8.x = 0
				var_186_0.localEulerAngles = var_186_8
			end

			local var_186_9 = arg_183_1.actors_["1020ui_story"]
			local var_186_10 = 0

			if var_186_10 < arg_183_1.time_ and arg_183_1.time_ <= var_186_10 + arg_186_0 and not isNil(var_186_9) and arg_183_1.var_.characterEffect1020ui_story == nil then
				arg_183_1.var_.characterEffect1020ui_story = var_186_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_11 = 0.200000002980232

			if var_186_10 <= arg_183_1.time_ and arg_183_1.time_ < var_186_10 + var_186_11 and not isNil(var_186_9) then
				local var_186_12 = (arg_183_1.time_ - var_186_10) / var_186_11

				if arg_183_1.var_.characterEffect1020ui_story and not isNil(var_186_9) then
					arg_183_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_183_1.time_ >= var_186_10 + var_186_11 and arg_183_1.time_ < var_186_10 + var_186_11 + arg_186_0 and not isNil(var_186_9) and arg_183_1.var_.characterEffect1020ui_story then
				arg_183_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_186_13 = 0

			if var_186_13 < arg_183_1.time_ and arg_183_1.time_ <= var_186_13 + arg_186_0 then
				arg_183_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action1_1")
			end

			local var_186_14 = 0

			if var_186_14 < arg_183_1.time_ and arg_183_1.time_ <= var_186_14 + arg_186_0 then
				arg_183_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_186_15 = 0
			local var_186_16 = 0.2

			if var_186_15 < arg_183_1.time_ and arg_183_1.time_ <= var_186_15 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				local var_186_17 = arg_183_1:FormatText(StoryNameCfg[613].name)

				arg_183_1.leftNameTxt_.text = var_186_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_18 = arg_183_1:GetWordFromCfg(320061045)
				local var_186_19 = arg_183_1:FormatText(var_186_18.content)

				arg_183_1.text_.text = var_186_19

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_20 = 8
				local var_186_21 = utf8.len(var_186_19)
				local var_186_22 = var_186_20 <= 0 and var_186_16 or var_186_16 * (var_186_21 / var_186_20)

				if var_186_22 > 0 and var_186_16 < var_186_22 then
					arg_183_1.talkMaxDuration = var_186_22

					if var_186_22 + var_186_15 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_22 + var_186_15
					end
				end

				arg_183_1.text_.text = var_186_19
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320061", "320061045", "story_v_out_320061.awb") ~= 0 then
					local var_186_23 = manager.audio:GetVoiceLength("story_v_out_320061", "320061045", "story_v_out_320061.awb") / 1000

					if var_186_23 + var_186_15 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_23 + var_186_15
					end

					if var_186_18.prefab_name ~= "" and arg_183_1.actors_[var_186_18.prefab_name] ~= nil then
						local var_186_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_18.prefab_name].transform, "story_v_out_320061", "320061045", "story_v_out_320061.awb")

						arg_183_1:RecordAudio("320061045", var_186_24)
						arg_183_1:RecordAudio("320061045", var_186_24)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_320061", "320061045", "story_v_out_320061.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_320061", "320061045", "story_v_out_320061.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_25 = math.max(var_186_16, arg_183_1.talkMaxDuration)

			if var_186_15 <= arg_183_1.time_ and arg_183_1.time_ < var_186_15 + var_186_25 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_15) / var_186_25

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_15 + var_186_25 and arg_183_1.time_ < var_186_15 + var_186_25 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
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
	Play320061046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 320061046
		arg_187_1.duration_ = 5

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play320061047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = arg_187_1.actors_["1020ui_story"]
			local var_190_1 = 0

			if var_190_1 < arg_187_1.time_ and arg_187_1.time_ <= var_190_1 + arg_190_0 and not isNil(var_190_0) and arg_187_1.var_.characterEffect1020ui_story == nil then
				arg_187_1.var_.characterEffect1020ui_story = var_190_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_2 = 0.200000002980232

			if var_190_1 <= arg_187_1.time_ and arg_187_1.time_ < var_190_1 + var_190_2 and not isNil(var_190_0) then
				local var_190_3 = (arg_187_1.time_ - var_190_1) / var_190_2

				if arg_187_1.var_.characterEffect1020ui_story and not isNil(var_190_0) then
					local var_190_4 = Mathf.Lerp(0, 0.5, var_190_3)

					arg_187_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_187_1.var_.characterEffect1020ui_story.fillRatio = var_190_4
				end
			end

			if arg_187_1.time_ >= var_190_1 + var_190_2 and arg_187_1.time_ < var_190_1 + var_190_2 + arg_190_0 and not isNil(var_190_0) and arg_187_1.var_.characterEffect1020ui_story then
				local var_190_5 = 0.5

				arg_187_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_187_1.var_.characterEffect1020ui_story.fillRatio = var_190_5
			end

			local var_190_6 = 0
			local var_190_7 = 0.7

			if var_190_6 < arg_187_1.time_ and arg_187_1.time_ <= var_190_6 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				local var_190_8 = arg_187_1:FormatText(StoryNameCfg[7].name)

				arg_187_1.leftNameTxt_.text = var_190_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, true)
				arg_187_1.iconController_:SetSelectedState("hero")

				arg_187_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_187_1.callingController_:SetSelectedState("normal")

				arg_187_1.keyicon_.color = Color.New(1, 1, 1)
				arg_187_1.icon_.color = Color.New(1, 1, 1)

				local var_190_9 = arg_187_1:GetWordFromCfg(320061046)
				local var_190_10 = arg_187_1:FormatText(var_190_9.content)

				arg_187_1.text_.text = var_190_10

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_11 = 28
				local var_190_12 = utf8.len(var_190_10)
				local var_190_13 = var_190_11 <= 0 and var_190_7 or var_190_7 * (var_190_12 / var_190_11)

				if var_190_13 > 0 and var_190_7 < var_190_13 then
					arg_187_1.talkMaxDuration = var_190_13

					if var_190_13 + var_190_6 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_13 + var_190_6
					end
				end

				arg_187_1.text_.text = var_190_10
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)
				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_14 = math.max(var_190_7, arg_187_1.talkMaxDuration)

			if var_190_6 <= arg_187_1.time_ and arg_187_1.time_ < var_190_6 + var_190_14 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_6) / var_190_14

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_6 + var_190_14 and arg_187_1.time_ < var_190_6 + var_190_14 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play320061047 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 320061047
		arg_191_1.duration_ = 11.23

		local var_191_0 = {
			zh = 5.9,
			ja = 11.233
		}
		local var_191_1 = manager.audio:GetLocalizationFlag()

		if var_191_0[var_191_1] ~= nil then
			arg_191_1.duration_ = var_191_0[var_191_1]
		end

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play320061048(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = arg_191_1.actors_["1020ui_story"]
			local var_194_1 = 0

			if var_194_1 < arg_191_1.time_ and arg_191_1.time_ <= var_194_1 + arg_194_0 and not isNil(var_194_0) and arg_191_1.var_.characterEffect1020ui_story == nil then
				arg_191_1.var_.characterEffect1020ui_story = var_194_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_2 = 0.200000002980232

			if var_194_1 <= arg_191_1.time_ and arg_191_1.time_ < var_194_1 + var_194_2 and not isNil(var_194_0) then
				local var_194_3 = (arg_191_1.time_ - var_194_1) / var_194_2

				if arg_191_1.var_.characterEffect1020ui_story and not isNil(var_194_0) then
					arg_191_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_191_1.time_ >= var_194_1 + var_194_2 and arg_191_1.time_ < var_194_1 + var_194_2 + arg_194_0 and not isNil(var_194_0) and arg_191_1.var_.characterEffect1020ui_story then
				arg_191_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_194_4 = 0

			if var_194_4 < arg_191_1.time_ and arg_191_1.time_ <= var_194_4 + arg_194_0 then
				arg_191_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_194_5 = 0
			local var_194_6 = 0.8

			if var_194_5 < arg_191_1.time_ and arg_191_1.time_ <= var_194_5 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				local var_194_7 = arg_191_1:FormatText(StoryNameCfg[613].name)

				arg_191_1.leftNameTxt_.text = var_194_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_8 = arg_191_1:GetWordFromCfg(320061047)
				local var_194_9 = arg_191_1:FormatText(var_194_8.content)

				arg_191_1.text_.text = var_194_9

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_10 = 32
				local var_194_11 = utf8.len(var_194_9)
				local var_194_12 = var_194_10 <= 0 and var_194_6 or var_194_6 * (var_194_11 / var_194_10)

				if var_194_12 > 0 and var_194_6 < var_194_12 then
					arg_191_1.talkMaxDuration = var_194_12

					if var_194_12 + var_194_5 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_12 + var_194_5
					end
				end

				arg_191_1.text_.text = var_194_9
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320061", "320061047", "story_v_out_320061.awb") ~= 0 then
					local var_194_13 = manager.audio:GetVoiceLength("story_v_out_320061", "320061047", "story_v_out_320061.awb") / 1000

					if var_194_13 + var_194_5 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_13 + var_194_5
					end

					if var_194_8.prefab_name ~= "" and arg_191_1.actors_[var_194_8.prefab_name] ~= nil then
						local var_194_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_8.prefab_name].transform, "story_v_out_320061", "320061047", "story_v_out_320061.awb")

						arg_191_1:RecordAudio("320061047", var_194_14)
						arg_191_1:RecordAudio("320061047", var_194_14)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_320061", "320061047", "story_v_out_320061.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_320061", "320061047", "story_v_out_320061.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_15 = math.max(var_194_6, arg_191_1.talkMaxDuration)

			if var_194_5 <= arg_191_1.time_ and arg_191_1.time_ < var_194_5 + var_194_15 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_5) / var_194_15

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_5 + var_194_15 and arg_191_1.time_ < var_194_5 + var_194_15 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play320061048 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 320061048
		arg_195_1.duration_ = 5

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play320061049(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = arg_195_1.actors_["1020ui_story"]
			local var_198_1 = 0

			if var_198_1 < arg_195_1.time_ and arg_195_1.time_ <= var_198_1 + arg_198_0 and not isNil(var_198_0) and arg_195_1.var_.characterEffect1020ui_story == nil then
				arg_195_1.var_.characterEffect1020ui_story = var_198_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_2 = 0.200000002980232

			if var_198_1 <= arg_195_1.time_ and arg_195_1.time_ < var_198_1 + var_198_2 and not isNil(var_198_0) then
				local var_198_3 = (arg_195_1.time_ - var_198_1) / var_198_2

				if arg_195_1.var_.characterEffect1020ui_story and not isNil(var_198_0) then
					local var_198_4 = Mathf.Lerp(0, 0.5, var_198_3)

					arg_195_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_195_1.var_.characterEffect1020ui_story.fillRatio = var_198_4
				end
			end

			if arg_195_1.time_ >= var_198_1 + var_198_2 and arg_195_1.time_ < var_198_1 + var_198_2 + arg_198_0 and not isNil(var_198_0) and arg_195_1.var_.characterEffect1020ui_story then
				local var_198_5 = 0.5

				arg_195_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_195_1.var_.characterEffect1020ui_story.fillRatio = var_198_5
			end

			local var_198_6 = 0
			local var_198_7 = 0.375

			if var_198_6 < arg_195_1.time_ and arg_195_1.time_ <= var_198_6 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				local var_198_8 = arg_195_1:FormatText(StoryNameCfg[7].name)

				arg_195_1.leftNameTxt_.text = var_198_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, true)
				arg_195_1.iconController_:SetSelectedState("hero")

				arg_195_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_195_1.callingController_:SetSelectedState("normal")

				arg_195_1.keyicon_.color = Color.New(1, 1, 1)
				arg_195_1.icon_.color = Color.New(1, 1, 1)

				local var_198_9 = arg_195_1:GetWordFromCfg(320061048)
				local var_198_10 = arg_195_1:FormatText(var_198_9.content)

				arg_195_1.text_.text = var_198_10

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_11 = 15
				local var_198_12 = utf8.len(var_198_10)
				local var_198_13 = var_198_11 <= 0 and var_198_7 or var_198_7 * (var_198_12 / var_198_11)

				if var_198_13 > 0 and var_198_7 < var_198_13 then
					arg_195_1.talkMaxDuration = var_198_13

					if var_198_13 + var_198_6 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_13 + var_198_6
					end
				end

				arg_195_1.text_.text = var_198_10
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)
				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_14 = math.max(var_198_7, arg_195_1.talkMaxDuration)

			if var_198_6 <= arg_195_1.time_ and arg_195_1.time_ < var_198_6 + var_198_14 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_6) / var_198_14

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_6 + var_198_14 and arg_195_1.time_ < var_198_6 + var_198_14 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play320061049 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 320061049
		arg_199_1.duration_ = 15.57

		local var_199_0 = {
			zh = 5.433,
			ja = 15.566
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
				arg_199_0:Play320061050(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = arg_199_1.actors_["1020ui_story"]
			local var_202_1 = 0

			if var_202_1 < arg_199_1.time_ and arg_199_1.time_ <= var_202_1 + arg_202_0 and not isNil(var_202_0) and arg_199_1.var_.characterEffect1020ui_story == nil then
				arg_199_1.var_.characterEffect1020ui_story = var_202_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_2 = 0.200000002980232

			if var_202_1 <= arg_199_1.time_ and arg_199_1.time_ < var_202_1 + var_202_2 and not isNil(var_202_0) then
				local var_202_3 = (arg_199_1.time_ - var_202_1) / var_202_2

				if arg_199_1.var_.characterEffect1020ui_story and not isNil(var_202_0) then
					arg_199_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_199_1.time_ >= var_202_1 + var_202_2 and arg_199_1.time_ < var_202_1 + var_202_2 + arg_202_0 and not isNil(var_202_0) and arg_199_1.var_.characterEffect1020ui_story then
				arg_199_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_202_4 = 0

			if var_202_4 < arg_199_1.time_ and arg_199_1.time_ <= var_202_4 + arg_202_0 then
				arg_199_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action3_1")
			end

			local var_202_5 = 0

			if var_202_5 < arg_199_1.time_ and arg_199_1.time_ <= var_202_5 + arg_202_0 then
				arg_199_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_deyiA", "EmotionTimelineAnimator")
			end

			local var_202_6 = 0
			local var_202_7 = 0.55

			if var_202_6 < arg_199_1.time_ and arg_199_1.time_ <= var_202_6 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				local var_202_8 = arg_199_1:FormatText(StoryNameCfg[613].name)

				arg_199_1.leftNameTxt_.text = var_202_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_9 = arg_199_1:GetWordFromCfg(320061049)
				local var_202_10 = arg_199_1:FormatText(var_202_9.content)

				arg_199_1.text_.text = var_202_10

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_11 = 22
				local var_202_12 = utf8.len(var_202_10)
				local var_202_13 = var_202_11 <= 0 and var_202_7 or var_202_7 * (var_202_12 / var_202_11)

				if var_202_13 > 0 and var_202_7 < var_202_13 then
					arg_199_1.talkMaxDuration = var_202_13

					if var_202_13 + var_202_6 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_13 + var_202_6
					end
				end

				arg_199_1.text_.text = var_202_10
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320061", "320061049", "story_v_out_320061.awb") ~= 0 then
					local var_202_14 = manager.audio:GetVoiceLength("story_v_out_320061", "320061049", "story_v_out_320061.awb") / 1000

					if var_202_14 + var_202_6 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_14 + var_202_6
					end

					if var_202_9.prefab_name ~= "" and arg_199_1.actors_[var_202_9.prefab_name] ~= nil then
						local var_202_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_9.prefab_name].transform, "story_v_out_320061", "320061049", "story_v_out_320061.awb")

						arg_199_1:RecordAudio("320061049", var_202_15)
						arg_199_1:RecordAudio("320061049", var_202_15)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_320061", "320061049", "story_v_out_320061.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_320061", "320061049", "story_v_out_320061.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_16 = math.max(var_202_7, arg_199_1.talkMaxDuration)

			if var_202_6 <= arg_199_1.time_ and arg_199_1.time_ < var_202_6 + var_202_16 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_6) / var_202_16

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_6 + var_202_16 and arg_199_1.time_ < var_202_6 + var_202_16 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play320061050 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 320061050
		arg_203_1.duration_ = 5

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play320061051(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = arg_203_1.actors_["1020ui_story"]
			local var_206_1 = 0

			if var_206_1 < arg_203_1.time_ and arg_203_1.time_ <= var_206_1 + arg_206_0 and not isNil(var_206_0) and arg_203_1.var_.characterEffect1020ui_story == nil then
				arg_203_1.var_.characterEffect1020ui_story = var_206_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_2 = 0.200000002980232

			if var_206_1 <= arg_203_1.time_ and arg_203_1.time_ < var_206_1 + var_206_2 and not isNil(var_206_0) then
				local var_206_3 = (arg_203_1.time_ - var_206_1) / var_206_2

				if arg_203_1.var_.characterEffect1020ui_story and not isNil(var_206_0) then
					local var_206_4 = Mathf.Lerp(0, 0.5, var_206_3)

					arg_203_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_203_1.var_.characterEffect1020ui_story.fillRatio = var_206_4
				end
			end

			if arg_203_1.time_ >= var_206_1 + var_206_2 and arg_203_1.time_ < var_206_1 + var_206_2 + arg_206_0 and not isNil(var_206_0) and arg_203_1.var_.characterEffect1020ui_story then
				local var_206_5 = 0.5

				arg_203_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_203_1.var_.characterEffect1020ui_story.fillRatio = var_206_5
			end

			local var_206_6 = 0
			local var_206_7 = 0.125

			if var_206_6 < arg_203_1.time_ and arg_203_1.time_ <= var_206_6 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				local var_206_8 = arg_203_1:FormatText(StoryNameCfg[7].name)

				arg_203_1.leftNameTxt_.text = var_206_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, true)
				arg_203_1.iconController_:SetSelectedState("hero")

				arg_203_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_203_1.callingController_:SetSelectedState("normal")

				arg_203_1.keyicon_.color = Color.New(1, 1, 1)
				arg_203_1.icon_.color = Color.New(1, 1, 1)

				local var_206_9 = arg_203_1:GetWordFromCfg(320061050)
				local var_206_10 = arg_203_1:FormatText(var_206_9.content)

				arg_203_1.text_.text = var_206_10

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_11 = 5
				local var_206_12 = utf8.len(var_206_10)
				local var_206_13 = var_206_11 <= 0 and var_206_7 or var_206_7 * (var_206_12 / var_206_11)

				if var_206_13 > 0 and var_206_7 < var_206_13 then
					arg_203_1.talkMaxDuration = var_206_13

					if var_206_13 + var_206_6 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_13 + var_206_6
					end
				end

				arg_203_1.text_.text = var_206_10
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)
				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_14 = math.max(var_206_7, arg_203_1.talkMaxDuration)

			if var_206_6 <= arg_203_1.time_ and arg_203_1.time_ < var_206_6 + var_206_14 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_6) / var_206_14

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_6 + var_206_14 and arg_203_1.time_ < var_206_6 + var_206_14 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play320061051 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 320061051
		arg_207_1.duration_ = 8.07

		local var_207_0 = {
			zh = 4.366,
			ja = 8.066
		}
		local var_207_1 = manager.audio:GetLocalizationFlag()

		if var_207_0[var_207_1] ~= nil then
			arg_207_1.duration_ = var_207_0[var_207_1]
		end

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play320061052(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = arg_207_1.actors_["1020ui_story"]
			local var_210_1 = 0

			if var_210_1 < arg_207_1.time_ and arg_207_1.time_ <= var_210_1 + arg_210_0 and not isNil(var_210_0) and arg_207_1.var_.characterEffect1020ui_story == nil then
				arg_207_1.var_.characterEffect1020ui_story = var_210_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_2 = 0.200000002980232

			if var_210_1 <= arg_207_1.time_ and arg_207_1.time_ < var_210_1 + var_210_2 and not isNil(var_210_0) then
				local var_210_3 = (arg_207_1.time_ - var_210_1) / var_210_2

				if arg_207_1.var_.characterEffect1020ui_story and not isNil(var_210_0) then
					arg_207_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_207_1.time_ >= var_210_1 + var_210_2 and arg_207_1.time_ < var_210_1 + var_210_2 + arg_210_0 and not isNil(var_210_0) and arg_207_1.var_.characterEffect1020ui_story then
				arg_207_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_210_4 = 0

			if var_210_4 < arg_207_1.time_ and arg_207_1.time_ <= var_210_4 + arg_210_0 then
				arg_207_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020actionlink/1020action436")
			end

			local var_210_5 = 0

			if var_210_5 < arg_207_1.time_ and arg_207_1.time_ <= var_210_5 + arg_210_0 then
				arg_207_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileF_biyan", "EmotionTimelineAnimator")
			end

			local var_210_6 = 0
			local var_210_7 = 0.475

			if var_210_6 < arg_207_1.time_ and arg_207_1.time_ <= var_210_6 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				local var_210_8 = arg_207_1:FormatText(StoryNameCfg[613].name)

				arg_207_1.leftNameTxt_.text = var_210_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_9 = arg_207_1:GetWordFromCfg(320061051)
				local var_210_10 = arg_207_1:FormatText(var_210_9.content)

				arg_207_1.text_.text = var_210_10

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_11 = 19
				local var_210_12 = utf8.len(var_210_10)
				local var_210_13 = var_210_11 <= 0 and var_210_7 or var_210_7 * (var_210_12 / var_210_11)

				if var_210_13 > 0 and var_210_7 < var_210_13 then
					arg_207_1.talkMaxDuration = var_210_13

					if var_210_13 + var_210_6 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_13 + var_210_6
					end
				end

				arg_207_1.text_.text = var_210_10
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320061", "320061051", "story_v_out_320061.awb") ~= 0 then
					local var_210_14 = manager.audio:GetVoiceLength("story_v_out_320061", "320061051", "story_v_out_320061.awb") / 1000

					if var_210_14 + var_210_6 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_14 + var_210_6
					end

					if var_210_9.prefab_name ~= "" and arg_207_1.actors_[var_210_9.prefab_name] ~= nil then
						local var_210_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_9.prefab_name].transform, "story_v_out_320061", "320061051", "story_v_out_320061.awb")

						arg_207_1:RecordAudio("320061051", var_210_15)
						arg_207_1:RecordAudio("320061051", var_210_15)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_320061", "320061051", "story_v_out_320061.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_320061", "320061051", "story_v_out_320061.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_16 = math.max(var_210_7, arg_207_1.talkMaxDuration)

			if var_210_6 <= arg_207_1.time_ and arg_207_1.time_ < var_210_6 + var_210_16 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_6) / var_210_16

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_6 + var_210_16 and arg_207_1.time_ < var_210_6 + var_210_16 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play320061052 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 320061052
		arg_211_1.duration_ = 8.4

		local var_211_0 = {
			zh = 5.933,
			ja = 8.4
		}
		local var_211_1 = manager.audio:GetLocalizationFlag()

		if var_211_0[var_211_1] ~= nil then
			arg_211_1.duration_ = var_211_0[var_211_1]
		end

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play320061053(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = 0

			if var_214_0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_0 + arg_214_0 then
				arg_211_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action6_2")
			end

			local var_214_1 = 0

			if var_214_1 < arg_211_1.time_ and arg_211_1.time_ <= var_214_1 + arg_214_0 then
				arg_211_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_214_2 = 0
			local var_214_3 = 0.8

			if var_214_2 < arg_211_1.time_ and arg_211_1.time_ <= var_214_2 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				local var_214_4 = arg_211_1:FormatText(StoryNameCfg[613].name)

				arg_211_1.leftNameTxt_.text = var_214_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_5 = arg_211_1:GetWordFromCfg(320061052)
				local var_214_6 = arg_211_1:FormatText(var_214_5.content)

				arg_211_1.text_.text = var_214_6

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_7 = 33
				local var_214_8 = utf8.len(var_214_6)
				local var_214_9 = var_214_7 <= 0 and var_214_3 or var_214_3 * (var_214_8 / var_214_7)

				if var_214_9 > 0 and var_214_3 < var_214_9 then
					arg_211_1.talkMaxDuration = var_214_9

					if var_214_9 + var_214_2 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_9 + var_214_2
					end
				end

				arg_211_1.text_.text = var_214_6
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320061", "320061052", "story_v_out_320061.awb") ~= 0 then
					local var_214_10 = manager.audio:GetVoiceLength("story_v_out_320061", "320061052", "story_v_out_320061.awb") / 1000

					if var_214_10 + var_214_2 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_10 + var_214_2
					end

					if var_214_5.prefab_name ~= "" and arg_211_1.actors_[var_214_5.prefab_name] ~= nil then
						local var_214_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_5.prefab_name].transform, "story_v_out_320061", "320061052", "story_v_out_320061.awb")

						arg_211_1:RecordAudio("320061052", var_214_11)
						arg_211_1:RecordAudio("320061052", var_214_11)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_320061", "320061052", "story_v_out_320061.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_320061", "320061052", "story_v_out_320061.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_12 = math.max(var_214_3, arg_211_1.talkMaxDuration)

			if var_214_2 <= arg_211_1.time_ and arg_211_1.time_ < var_214_2 + var_214_12 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_2) / var_214_12

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_2 + var_214_12 and arg_211_1.time_ < var_214_2 + var_214_12 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play320061053 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 320061053
		arg_215_1.duration_ = 5

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play320061054(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = arg_215_1.actors_["1020ui_story"]
			local var_218_1 = 0

			if var_218_1 < arg_215_1.time_ and arg_215_1.time_ <= var_218_1 + arg_218_0 and not isNil(var_218_0) and arg_215_1.var_.characterEffect1020ui_story == nil then
				arg_215_1.var_.characterEffect1020ui_story = var_218_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_2 = 0.200000002980232

			if var_218_1 <= arg_215_1.time_ and arg_215_1.time_ < var_218_1 + var_218_2 and not isNil(var_218_0) then
				local var_218_3 = (arg_215_1.time_ - var_218_1) / var_218_2

				if arg_215_1.var_.characterEffect1020ui_story and not isNil(var_218_0) then
					local var_218_4 = Mathf.Lerp(0, 0.5, var_218_3)

					arg_215_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_215_1.var_.characterEffect1020ui_story.fillRatio = var_218_4
				end
			end

			if arg_215_1.time_ >= var_218_1 + var_218_2 and arg_215_1.time_ < var_218_1 + var_218_2 + arg_218_0 and not isNil(var_218_0) and arg_215_1.var_.characterEffect1020ui_story then
				local var_218_5 = 0.5

				arg_215_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_215_1.var_.characterEffect1020ui_story.fillRatio = var_218_5
			end

			local var_218_6 = 0
			local var_218_7 = 1.7

			if var_218_6 < arg_215_1.time_ and arg_215_1.time_ <= var_218_6 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				local var_218_8 = arg_215_1:FormatText(StoryNameCfg[7].name)

				arg_215_1.leftNameTxt_.text = var_218_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, true)
				arg_215_1.iconController_:SetSelectedState("hero")

				arg_215_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_215_1.callingController_:SetSelectedState("normal")

				arg_215_1.keyicon_.color = Color.New(1, 1, 1)
				arg_215_1.icon_.color = Color.New(1, 1, 1)

				local var_218_9 = arg_215_1:GetWordFromCfg(320061053)
				local var_218_10 = arg_215_1:FormatText(var_218_9.content)

				arg_215_1.text_.text = var_218_10

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_11 = 68
				local var_218_12 = utf8.len(var_218_10)
				local var_218_13 = var_218_11 <= 0 and var_218_7 or var_218_7 * (var_218_12 / var_218_11)

				if var_218_13 > 0 and var_218_7 < var_218_13 then
					arg_215_1.talkMaxDuration = var_218_13

					if var_218_13 + var_218_6 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_13 + var_218_6
					end
				end

				arg_215_1.text_.text = var_218_10
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)
				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_14 = math.max(var_218_7, arg_215_1.talkMaxDuration)

			if var_218_6 <= arg_215_1.time_ and arg_215_1.time_ < var_218_6 + var_218_14 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_6) / var_218_14

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_6 + var_218_14 and arg_215_1.time_ < var_218_6 + var_218_14 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play320061054 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 320061054
		arg_219_1.duration_ = 14.23

		local var_219_0 = {
			zh = 7,
			ja = 14.233
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
				arg_219_0:Play320061055(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = arg_219_1.actors_["1020ui_story"]
			local var_222_1 = 0

			if var_222_1 < arg_219_1.time_ and arg_219_1.time_ <= var_222_1 + arg_222_0 and not isNil(var_222_0) and arg_219_1.var_.characterEffect1020ui_story == nil then
				arg_219_1.var_.characterEffect1020ui_story = var_222_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_2 = 0.200000002980232

			if var_222_1 <= arg_219_1.time_ and arg_219_1.time_ < var_222_1 + var_222_2 and not isNil(var_222_0) then
				local var_222_3 = (arg_219_1.time_ - var_222_1) / var_222_2

				if arg_219_1.var_.characterEffect1020ui_story and not isNil(var_222_0) then
					arg_219_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_219_1.time_ >= var_222_1 + var_222_2 and arg_219_1.time_ < var_222_1 + var_222_2 + arg_222_0 and not isNil(var_222_0) and arg_219_1.var_.characterEffect1020ui_story then
				arg_219_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_222_4 = 0

			if var_222_4 < arg_219_1.time_ and arg_219_1.time_ <= var_222_4 + arg_222_0 then
				arg_219_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_222_5 = 0
			local var_222_6 = 0.625

			if var_222_5 < arg_219_1.time_ and arg_219_1.time_ <= var_222_5 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				local var_222_7 = arg_219_1:FormatText(StoryNameCfg[613].name)

				arg_219_1.leftNameTxt_.text = var_222_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_8 = arg_219_1:GetWordFromCfg(320061054)
				local var_222_9 = arg_219_1:FormatText(var_222_8.content)

				arg_219_1.text_.text = var_222_9

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_10 = 25
				local var_222_11 = utf8.len(var_222_9)
				local var_222_12 = var_222_10 <= 0 and var_222_6 or var_222_6 * (var_222_11 / var_222_10)

				if var_222_12 > 0 and var_222_6 < var_222_12 then
					arg_219_1.talkMaxDuration = var_222_12

					if var_222_12 + var_222_5 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_12 + var_222_5
					end
				end

				arg_219_1.text_.text = var_222_9
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320061", "320061054", "story_v_out_320061.awb") ~= 0 then
					local var_222_13 = manager.audio:GetVoiceLength("story_v_out_320061", "320061054", "story_v_out_320061.awb") / 1000

					if var_222_13 + var_222_5 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_13 + var_222_5
					end

					if var_222_8.prefab_name ~= "" and arg_219_1.actors_[var_222_8.prefab_name] ~= nil then
						local var_222_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_8.prefab_name].transform, "story_v_out_320061", "320061054", "story_v_out_320061.awb")

						arg_219_1:RecordAudio("320061054", var_222_14)
						arg_219_1:RecordAudio("320061054", var_222_14)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_320061", "320061054", "story_v_out_320061.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_320061", "320061054", "story_v_out_320061.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_15 = math.max(var_222_6, arg_219_1.talkMaxDuration)

			if var_222_5 <= arg_219_1.time_ and arg_219_1.time_ < var_222_5 + var_222_15 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_5) / var_222_15

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_5 + var_222_15 and arg_219_1.time_ < var_222_5 + var_222_15 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play320061055 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 320061055
		arg_223_1.duration_ = 5

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play320061056(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = arg_223_1.actors_["1020ui_story"]
			local var_226_1 = 0

			if var_226_1 < arg_223_1.time_ and arg_223_1.time_ <= var_226_1 + arg_226_0 and not isNil(var_226_0) and arg_223_1.var_.characterEffect1020ui_story == nil then
				arg_223_1.var_.characterEffect1020ui_story = var_226_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_2 = 0.200000002980232

			if var_226_1 <= arg_223_1.time_ and arg_223_1.time_ < var_226_1 + var_226_2 and not isNil(var_226_0) then
				local var_226_3 = (arg_223_1.time_ - var_226_1) / var_226_2

				if arg_223_1.var_.characterEffect1020ui_story and not isNil(var_226_0) then
					local var_226_4 = Mathf.Lerp(0, 0.5, var_226_3)

					arg_223_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_223_1.var_.characterEffect1020ui_story.fillRatio = var_226_4
				end
			end

			if arg_223_1.time_ >= var_226_1 + var_226_2 and arg_223_1.time_ < var_226_1 + var_226_2 + arg_226_0 and not isNil(var_226_0) and arg_223_1.var_.characterEffect1020ui_story then
				local var_226_5 = 0.5

				arg_223_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_223_1.var_.characterEffect1020ui_story.fillRatio = var_226_5
			end

			local var_226_6 = 0
			local var_226_7 = 1.025

			if var_226_6 < arg_223_1.time_ and arg_223_1.time_ <= var_226_6 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				local var_226_8 = arg_223_1:FormatText(StoryNameCfg[7].name)

				arg_223_1.leftNameTxt_.text = var_226_8

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

				local var_226_9 = arg_223_1:GetWordFromCfg(320061055)
				local var_226_10 = arg_223_1:FormatText(var_226_9.content)

				arg_223_1.text_.text = var_226_10

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_11 = 41
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
				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_14 = math.max(var_226_7, arg_223_1.talkMaxDuration)

			if var_226_6 <= arg_223_1.time_ and arg_223_1.time_ < var_226_6 + var_226_14 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_6) / var_226_14

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_6 + var_226_14 and arg_223_1.time_ < var_226_6 + var_226_14 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play320061056 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 320061056
		arg_227_1.duration_ = 4.8

		local var_227_0 = {
			zh = 3.2,
			ja = 4.8
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
				arg_227_0:Play320061057(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = arg_227_1.actors_["1020ui_story"]
			local var_230_1 = 0

			if var_230_1 < arg_227_1.time_ and arg_227_1.time_ <= var_230_1 + arg_230_0 and not isNil(var_230_0) and arg_227_1.var_.characterEffect1020ui_story == nil then
				arg_227_1.var_.characterEffect1020ui_story = var_230_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_2 = 0.200000002980232

			if var_230_1 <= arg_227_1.time_ and arg_227_1.time_ < var_230_1 + var_230_2 and not isNil(var_230_0) then
				local var_230_3 = (arg_227_1.time_ - var_230_1) / var_230_2

				if arg_227_1.var_.characterEffect1020ui_story and not isNil(var_230_0) then
					arg_227_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_227_1.time_ >= var_230_1 + var_230_2 and arg_227_1.time_ < var_230_1 + var_230_2 + arg_230_0 and not isNil(var_230_0) and arg_227_1.var_.characterEffect1020ui_story then
				arg_227_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_230_4 = 0

			if var_230_4 < arg_227_1.time_ and arg_227_1.time_ <= var_230_4 + arg_230_0 then
				arg_227_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action2_1")
			end

			local var_230_5 = 0

			if var_230_5 < arg_227_1.time_ and arg_227_1.time_ <= var_230_5 + arg_230_0 then
				arg_227_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_230_6 = 0
			local var_230_7 = 0.375

			if var_230_6 < arg_227_1.time_ and arg_227_1.time_ <= var_230_6 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				local var_230_8 = arg_227_1:FormatText(StoryNameCfg[613].name)

				arg_227_1.leftNameTxt_.text = var_230_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_9 = arg_227_1:GetWordFromCfg(320061056)
				local var_230_10 = arg_227_1:FormatText(var_230_9.content)

				arg_227_1.text_.text = var_230_10

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_11 = 15
				local var_230_12 = utf8.len(var_230_10)
				local var_230_13 = var_230_11 <= 0 and var_230_7 or var_230_7 * (var_230_12 / var_230_11)

				if var_230_13 > 0 and var_230_7 < var_230_13 then
					arg_227_1.talkMaxDuration = var_230_13

					if var_230_13 + var_230_6 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_13 + var_230_6
					end
				end

				arg_227_1.text_.text = var_230_10
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320061", "320061056", "story_v_out_320061.awb") ~= 0 then
					local var_230_14 = manager.audio:GetVoiceLength("story_v_out_320061", "320061056", "story_v_out_320061.awb") / 1000

					if var_230_14 + var_230_6 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_14 + var_230_6
					end

					if var_230_9.prefab_name ~= "" and arg_227_1.actors_[var_230_9.prefab_name] ~= nil then
						local var_230_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_9.prefab_name].transform, "story_v_out_320061", "320061056", "story_v_out_320061.awb")

						arg_227_1:RecordAudio("320061056", var_230_15)
						arg_227_1:RecordAudio("320061056", var_230_15)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_320061", "320061056", "story_v_out_320061.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_320061", "320061056", "story_v_out_320061.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_16 = math.max(var_230_7, arg_227_1.talkMaxDuration)

			if var_230_6 <= arg_227_1.time_ and arg_227_1.time_ < var_230_6 + var_230_16 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_6) / var_230_16

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_6 + var_230_16 and arg_227_1.time_ < var_230_6 + var_230_16 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play320061057 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 320061057
		arg_231_1.duration_ = 5

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play320061058(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = arg_231_1.actors_["1020ui_story"]
			local var_234_1 = 0

			if var_234_1 < arg_231_1.time_ and arg_231_1.time_ <= var_234_1 + arg_234_0 and not isNil(var_234_0) and arg_231_1.var_.characterEffect1020ui_story == nil then
				arg_231_1.var_.characterEffect1020ui_story = var_234_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_2 = 0.200000002980232

			if var_234_1 <= arg_231_1.time_ and arg_231_1.time_ < var_234_1 + var_234_2 and not isNil(var_234_0) then
				local var_234_3 = (arg_231_1.time_ - var_234_1) / var_234_2

				if arg_231_1.var_.characterEffect1020ui_story and not isNil(var_234_0) then
					local var_234_4 = Mathf.Lerp(0, 0.5, var_234_3)

					arg_231_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_231_1.var_.characterEffect1020ui_story.fillRatio = var_234_4
				end
			end

			if arg_231_1.time_ >= var_234_1 + var_234_2 and arg_231_1.time_ < var_234_1 + var_234_2 + arg_234_0 and not isNil(var_234_0) and arg_231_1.var_.characterEffect1020ui_story then
				local var_234_5 = 0.5

				arg_231_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_231_1.var_.characterEffect1020ui_story.fillRatio = var_234_5
			end

			local var_234_6 = 0
			local var_234_7 = 0.85

			if var_234_6 < arg_231_1.time_ and arg_231_1.time_ <= var_234_6 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				local var_234_8 = arg_231_1:FormatText(StoryNameCfg[7].name)

				arg_231_1.leftNameTxt_.text = var_234_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, true)
				arg_231_1.iconController_:SetSelectedState("hero")

				arg_231_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_231_1.callingController_:SetSelectedState("normal")

				arg_231_1.keyicon_.color = Color.New(1, 1, 1)
				arg_231_1.icon_.color = Color.New(1, 1, 1)

				local var_234_9 = arg_231_1:GetWordFromCfg(320061057)
				local var_234_10 = arg_231_1:FormatText(var_234_9.content)

				arg_231_1.text_.text = var_234_10

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_11 = 34
				local var_234_12 = utf8.len(var_234_10)
				local var_234_13 = var_234_11 <= 0 and var_234_7 or var_234_7 * (var_234_12 / var_234_11)

				if var_234_13 > 0 and var_234_7 < var_234_13 then
					arg_231_1.talkMaxDuration = var_234_13

					if var_234_13 + var_234_6 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_13 + var_234_6
					end
				end

				arg_231_1.text_.text = var_234_10
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)
				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_14 = math.max(var_234_7, arg_231_1.talkMaxDuration)

			if var_234_6 <= arg_231_1.time_ and arg_231_1.time_ < var_234_6 + var_234_14 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_6) / var_234_14

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_6 + var_234_14 and arg_231_1.time_ < var_234_6 + var_234_14 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play320061058 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 320061058
		arg_235_1.duration_ = 12.87

		local var_235_0 = {
			zh = 9.166,
			ja = 12.866
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
				arg_235_0:Play320061059(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = arg_235_1.actors_["1020ui_story"]
			local var_238_1 = 0

			if var_238_1 < arg_235_1.time_ and arg_235_1.time_ <= var_238_1 + arg_238_0 and not isNil(var_238_0) and arg_235_1.var_.characterEffect1020ui_story == nil then
				arg_235_1.var_.characterEffect1020ui_story = var_238_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_2 = 0.200000002980232

			if var_238_1 <= arg_235_1.time_ and arg_235_1.time_ < var_238_1 + var_238_2 and not isNil(var_238_0) then
				local var_238_3 = (arg_235_1.time_ - var_238_1) / var_238_2

				if arg_235_1.var_.characterEffect1020ui_story and not isNil(var_238_0) then
					arg_235_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_235_1.time_ >= var_238_1 + var_238_2 and arg_235_1.time_ < var_238_1 + var_238_2 + arg_238_0 and not isNil(var_238_0) and arg_235_1.var_.characterEffect1020ui_story then
				arg_235_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_238_4 = 0

			if var_238_4 < arg_235_1.time_ and arg_235_1.time_ <= var_238_4 + arg_238_0 then
				arg_235_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action2_2")
			end

			local var_238_5 = 0

			if var_238_5 < arg_235_1.time_ and arg_235_1.time_ <= var_238_5 + arg_238_0 then
				arg_235_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_238_6 = 0
			local var_238_7 = 1.2

			if var_238_6 < arg_235_1.time_ and arg_235_1.time_ <= var_238_6 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				local var_238_8 = arg_235_1:FormatText(StoryNameCfg[613].name)

				arg_235_1.leftNameTxt_.text = var_238_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_9 = arg_235_1:GetWordFromCfg(320061058)
				local var_238_10 = arg_235_1:FormatText(var_238_9.content)

				arg_235_1.text_.text = var_238_10

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_11 = 48
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

				if manager.audio:GetVoiceLength("story_v_out_320061", "320061058", "story_v_out_320061.awb") ~= 0 then
					local var_238_14 = manager.audio:GetVoiceLength("story_v_out_320061", "320061058", "story_v_out_320061.awb") / 1000

					if var_238_14 + var_238_6 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_14 + var_238_6
					end

					if var_238_9.prefab_name ~= "" and arg_235_1.actors_[var_238_9.prefab_name] ~= nil then
						local var_238_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_9.prefab_name].transform, "story_v_out_320061", "320061058", "story_v_out_320061.awb")

						arg_235_1:RecordAudio("320061058", var_238_15)
						arg_235_1:RecordAudio("320061058", var_238_15)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_320061", "320061058", "story_v_out_320061.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_320061", "320061058", "story_v_out_320061.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_16 = math.max(var_238_7, arg_235_1.talkMaxDuration)

			if var_238_6 <= arg_235_1.time_ and arg_235_1.time_ < var_238_6 + var_238_16 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_6) / var_238_16

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_6 + var_238_16 and arg_235_1.time_ < var_238_6 + var_238_16 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play320061059 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 320061059
		arg_239_1.duration_ = 16.33

		local var_239_0 = {
			zh = 10.7,
			ja = 16.333
		}
		local var_239_1 = manager.audio:GetLocalizationFlag()

		if var_239_0[var_239_1] ~= nil then
			arg_239_1.duration_ = var_239_0[var_239_1]
		end

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play320061060(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = 0
			local var_242_1 = 1.35

			if var_242_0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_0 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				local var_242_2 = arg_239_1:FormatText(StoryNameCfg[613].name)

				arg_239_1.leftNameTxt_.text = var_242_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_3 = arg_239_1:GetWordFromCfg(320061059)
				local var_242_4 = arg_239_1:FormatText(var_242_3.content)

				arg_239_1.text_.text = var_242_4

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_5 = 54
				local var_242_6 = utf8.len(var_242_4)
				local var_242_7 = var_242_5 <= 0 and var_242_1 or var_242_1 * (var_242_6 / var_242_5)

				if var_242_7 > 0 and var_242_1 < var_242_7 then
					arg_239_1.talkMaxDuration = var_242_7

					if var_242_7 + var_242_0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_7 + var_242_0
					end
				end

				arg_239_1.text_.text = var_242_4
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320061", "320061059", "story_v_out_320061.awb") ~= 0 then
					local var_242_8 = manager.audio:GetVoiceLength("story_v_out_320061", "320061059", "story_v_out_320061.awb") / 1000

					if var_242_8 + var_242_0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_8 + var_242_0
					end

					if var_242_3.prefab_name ~= "" and arg_239_1.actors_[var_242_3.prefab_name] ~= nil then
						local var_242_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_3.prefab_name].transform, "story_v_out_320061", "320061059", "story_v_out_320061.awb")

						arg_239_1:RecordAudio("320061059", var_242_9)
						arg_239_1:RecordAudio("320061059", var_242_9)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_320061", "320061059", "story_v_out_320061.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_320061", "320061059", "story_v_out_320061.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_10 = math.max(var_242_1, arg_239_1.talkMaxDuration)

			if var_242_0 <= arg_239_1.time_ and arg_239_1.time_ < var_242_0 + var_242_10 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_0) / var_242_10

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_0 + var_242_10 and arg_239_1.time_ < var_242_0 + var_242_10 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play320061060 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 320061060
		arg_243_1.duration_ = 5.83

		local var_243_0 = {
			zh = 5.799999999999,
			ja = 5.833
		}
		local var_243_1 = manager.audio:GetLocalizationFlag()

		if var_243_0[var_243_1] ~= nil then
			arg_243_1.duration_ = var_243_0[var_243_1]
		end

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play320061061(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = 2

			if var_246_0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_0 + arg_246_0 then
				local var_246_1 = manager.ui.mainCamera.transform.localPosition
				local var_246_2 = Vector3.New(0, 0, 10) + Vector3.New(var_246_1.x, var_246_1.y, 0)
				local var_246_3 = arg_243_1.bgs_.ST61

				var_246_3.transform.localPosition = var_246_2
				var_246_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_246_4 = var_246_3:GetComponent("SpriteRenderer")

				if var_246_4 and var_246_4.sprite then
					local var_246_5 = (var_246_3.transform.localPosition - var_246_1).z
					local var_246_6 = manager.ui.mainCameraCom_
					local var_246_7 = 2 * var_246_5 * Mathf.Tan(var_246_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_246_8 = var_246_7 * var_246_6.aspect
					local var_246_9 = var_246_4.sprite.bounds.size.x
					local var_246_10 = var_246_4.sprite.bounds.size.y
					local var_246_11 = var_246_8 / var_246_9
					local var_246_12 = var_246_7 / var_246_10
					local var_246_13 = var_246_12 < var_246_11 and var_246_11 or var_246_12

					var_246_3.transform.localScale = Vector3.New(var_246_13, var_246_13, 0)
				end

				for iter_246_0, iter_246_1 in pairs(arg_243_1.bgs_) do
					if iter_246_0 ~= "ST61" then
						iter_246_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_246_14 = 4

			if var_246_14 < arg_243_1.time_ and arg_243_1.time_ <= var_246_14 + arg_246_0 then
				arg_243_1.allBtn_.enabled = false
			end

			local var_246_15 = 0.3

			if arg_243_1.time_ >= var_246_14 + var_246_15 and arg_243_1.time_ < var_246_14 + var_246_15 + arg_246_0 then
				arg_243_1.allBtn_.enabled = true
			end

			local var_246_16 = 0

			if var_246_16 < arg_243_1.time_ and arg_243_1.time_ <= var_246_16 + arg_246_0 then
				arg_243_1.mask_.enabled = true
				arg_243_1.mask_.raycastTarget = true

				arg_243_1:SetGaussion(false)
			end

			local var_246_17 = 2

			if var_246_16 <= arg_243_1.time_ and arg_243_1.time_ < var_246_16 + var_246_17 then
				local var_246_18 = (arg_243_1.time_ - var_246_16) / var_246_17
				local var_246_19 = Color.New(0, 0, 0)

				var_246_19.a = Mathf.Lerp(0, 1, var_246_18)
				arg_243_1.mask_.color = var_246_19
			end

			if arg_243_1.time_ >= var_246_16 + var_246_17 and arg_243_1.time_ < var_246_16 + var_246_17 + arg_246_0 then
				local var_246_20 = Color.New(0, 0, 0)

				var_246_20.a = 1
				arg_243_1.mask_.color = var_246_20
			end

			local var_246_21 = 2

			if var_246_21 < arg_243_1.time_ and arg_243_1.time_ <= var_246_21 + arg_246_0 then
				arg_243_1.mask_.enabled = true
				arg_243_1.mask_.raycastTarget = true

				arg_243_1:SetGaussion(false)
			end

			local var_246_22 = 2

			if var_246_21 <= arg_243_1.time_ and arg_243_1.time_ < var_246_21 + var_246_22 then
				local var_246_23 = (arg_243_1.time_ - var_246_21) / var_246_22
				local var_246_24 = Color.New(0, 0, 0)

				var_246_24.a = Mathf.Lerp(1, 0, var_246_23)
				arg_243_1.mask_.color = var_246_24
			end

			if arg_243_1.time_ >= var_246_21 + var_246_22 and arg_243_1.time_ < var_246_21 + var_246_22 + arg_246_0 then
				local var_246_25 = Color.New(0, 0, 0)
				local var_246_26 = 0

				arg_243_1.mask_.enabled = false
				var_246_25.a = var_246_26
				arg_243_1.mask_.color = var_246_25
			end

			local var_246_27 = arg_243_1.actors_["1020ui_story"].transform
			local var_246_28 = 1.96599999815226

			if var_246_28 < arg_243_1.time_ and arg_243_1.time_ <= var_246_28 + arg_246_0 then
				arg_243_1.var_.moveOldPos1020ui_story = var_246_27.localPosition
			end

			local var_246_29 = 0.001

			if var_246_28 <= arg_243_1.time_ and arg_243_1.time_ < var_246_28 + var_246_29 then
				local var_246_30 = (arg_243_1.time_ - var_246_28) / var_246_29
				local var_246_31 = Vector3.New(0, 100, 0)

				var_246_27.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos1020ui_story, var_246_31, var_246_30)

				local var_246_32 = manager.ui.mainCamera.transform.position - var_246_27.position

				var_246_27.forward = Vector3.New(var_246_32.x, var_246_32.y, var_246_32.z)

				local var_246_33 = var_246_27.localEulerAngles

				var_246_33.z = 0
				var_246_33.x = 0
				var_246_27.localEulerAngles = var_246_33
			end

			if arg_243_1.time_ >= var_246_28 + var_246_29 and arg_243_1.time_ < var_246_28 + var_246_29 + arg_246_0 then
				var_246_27.localPosition = Vector3.New(0, 100, 0)

				local var_246_34 = manager.ui.mainCamera.transform.position - var_246_27.position

				var_246_27.forward = Vector3.New(var_246_34.x, var_246_34.y, var_246_34.z)

				local var_246_35 = var_246_27.localEulerAngles

				var_246_35.z = 0
				var_246_35.x = 0
				var_246_27.localEulerAngles = var_246_35
			end

			local var_246_36 = arg_243_1.actors_["1020ui_story"]
			local var_246_37 = 1.96599999815226

			if var_246_37 < arg_243_1.time_ and arg_243_1.time_ <= var_246_37 + arg_246_0 and not isNil(var_246_36) and arg_243_1.var_.characterEffect1020ui_story == nil then
				arg_243_1.var_.characterEffect1020ui_story = var_246_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_38 = 0.034000001847744

			if var_246_37 <= arg_243_1.time_ and arg_243_1.time_ < var_246_37 + var_246_38 and not isNil(var_246_36) then
				local var_246_39 = (arg_243_1.time_ - var_246_37) / var_246_38

				if arg_243_1.var_.characterEffect1020ui_story and not isNil(var_246_36) then
					local var_246_40 = Mathf.Lerp(0, 0.5, var_246_39)

					arg_243_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_243_1.var_.characterEffect1020ui_story.fillRatio = var_246_40
				end
			end

			if arg_243_1.time_ >= var_246_37 + var_246_38 and arg_243_1.time_ < var_246_37 + var_246_38 + arg_246_0 and not isNil(var_246_36) and arg_243_1.var_.characterEffect1020ui_story then
				local var_246_41 = 0.5

				arg_243_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_243_1.var_.characterEffect1020ui_story.fillRatio = var_246_41
			end

			local var_246_42 = "10102ui_story"

			if arg_243_1.actors_[var_246_42] == nil then
				local var_246_43 = Asset.Load("Char/" .. "10102ui_story")

				if not isNil(var_246_43) then
					local var_246_44 = Object.Instantiate(Asset.Load("Char/" .. "10102ui_story"), arg_243_1.stage_.transform)

					var_246_44.name = var_246_42
					var_246_44.transform.localPosition = Vector3.New(0, 100, 0)
					arg_243_1.actors_[var_246_42] = var_246_44

					local var_246_45 = var_246_44:GetComponentInChildren(typeof(CharacterEffect))

					var_246_45.enabled = true

					local var_246_46 = GameObjectTools.GetOrAddComponent(var_246_44, typeof(DynamicBoneHelper))

					if var_246_46 then
						var_246_46:EnableDynamicBone(false)
					end

					arg_243_1:ShowWeapon(var_246_45.transform, false)

					arg_243_1.var_[var_246_42 .. "Animator"] = var_246_45.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_243_1.var_[var_246_42 .. "Animator"].applyRootMotion = true
					arg_243_1.var_[var_246_42 .. "LipSync"] = var_246_45.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_246_47 = arg_243_1.actors_["10102ui_story"].transform
			local var_246_48 = 3.8

			if var_246_48 < arg_243_1.time_ and arg_243_1.time_ <= var_246_48 + arg_246_0 then
				arg_243_1.var_.moveOldPos10102ui_story = var_246_47.localPosition
			end

			local var_246_49 = 0.001

			if var_246_48 <= arg_243_1.time_ and arg_243_1.time_ < var_246_48 + var_246_49 then
				local var_246_50 = (arg_243_1.time_ - var_246_48) / var_246_49
				local var_246_51 = Vector3.New(-0.7, -0.985, -6.275)

				var_246_47.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos10102ui_story, var_246_51, var_246_50)

				local var_246_52 = manager.ui.mainCamera.transform.position - var_246_47.position

				var_246_47.forward = Vector3.New(var_246_52.x, var_246_52.y, var_246_52.z)

				local var_246_53 = var_246_47.localEulerAngles

				var_246_53.z = 0
				var_246_53.x = 0
				var_246_47.localEulerAngles = var_246_53
			end

			if arg_243_1.time_ >= var_246_48 + var_246_49 and arg_243_1.time_ < var_246_48 + var_246_49 + arg_246_0 then
				var_246_47.localPosition = Vector3.New(-0.7, -0.985, -6.275)

				local var_246_54 = manager.ui.mainCamera.transform.position - var_246_47.position

				var_246_47.forward = Vector3.New(var_246_54.x, var_246_54.y, var_246_54.z)

				local var_246_55 = var_246_47.localEulerAngles

				var_246_55.z = 0
				var_246_55.x = 0
				var_246_47.localEulerAngles = var_246_55
			end

			local var_246_56 = arg_243_1.actors_["10102ui_story"]
			local var_246_57 = 3.8

			if var_246_57 < arg_243_1.time_ and arg_243_1.time_ <= var_246_57 + arg_246_0 and not isNil(var_246_56) and arg_243_1.var_.characterEffect10102ui_story == nil then
				arg_243_1.var_.characterEffect10102ui_story = var_246_56:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_58 = 0.200000002980232

			if var_246_57 <= arg_243_1.time_ and arg_243_1.time_ < var_246_57 + var_246_58 and not isNil(var_246_56) then
				local var_246_59 = (arg_243_1.time_ - var_246_57) / var_246_58

				if arg_243_1.var_.characterEffect10102ui_story and not isNil(var_246_56) then
					arg_243_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_243_1.time_ >= var_246_57 + var_246_58 and arg_243_1.time_ < var_246_57 + var_246_58 + arg_246_0 and not isNil(var_246_56) and arg_243_1.var_.characterEffect10102ui_story then
				arg_243_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_246_60 = 3.8

			if var_246_60 < arg_243_1.time_ and arg_243_1.time_ <= var_246_60 + arg_246_0 then
				arg_243_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action1_1")
			end

			local var_246_61 = 3.8

			if var_246_61 < arg_243_1.time_ and arg_243_1.time_ <= var_246_61 + arg_246_0 then
				arg_243_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			if arg_243_1.frameCnt_ <= 1 then
				arg_243_1.dialog_:SetActive(false)
			end

			local var_246_62 = 4
			local var_246_63 = 0.125

			if var_246_62 < arg_243_1.time_ and arg_243_1.time_ <= var_246_62 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0

				arg_243_1.dialog_:SetActive(true)

				arg_243_1.dialogCg_.alpha = 0

				local var_246_64 = LeanTween.value(arg_243_1.dialog_, 0, 1, 0.3)

				var_246_64:setOnUpdate(LuaHelper.FloatAction(function(arg_247_0)
					arg_243_1.dialogCg_.alpha = arg_247_0
				end))
				var_246_64:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_243_1.dialog_)
					var_246_64:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_243_1.duration_ = arg_243_1.duration_ + 0.3

				SetActive(arg_243_1.leftNameGo_, true)

				local var_246_65 = arg_243_1:FormatText(StoryNameCfg[6].name)

				arg_243_1.leftNameTxt_.text = var_246_65

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_66 = arg_243_1:GetWordFromCfg(320061060)
				local var_246_67 = arg_243_1:FormatText(var_246_66.content)

				arg_243_1.text_.text = var_246_67

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_68 = 5
				local var_246_69 = utf8.len(var_246_67)
				local var_246_70 = var_246_68 <= 0 and var_246_63 or var_246_63 * (var_246_69 / var_246_68)

				if var_246_70 > 0 and var_246_63 < var_246_70 then
					arg_243_1.talkMaxDuration = var_246_70
					var_246_62 = var_246_62 + 0.3

					if var_246_70 + var_246_62 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_70 + var_246_62
					end
				end

				arg_243_1.text_.text = var_246_67
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320061", "320061060", "story_v_out_320061.awb") ~= 0 then
					local var_246_71 = manager.audio:GetVoiceLength("story_v_out_320061", "320061060", "story_v_out_320061.awb") / 1000

					if var_246_71 + var_246_62 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_71 + var_246_62
					end

					if var_246_66.prefab_name ~= "" and arg_243_1.actors_[var_246_66.prefab_name] ~= nil then
						local var_246_72 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_66.prefab_name].transform, "story_v_out_320061", "320061060", "story_v_out_320061.awb")

						arg_243_1:RecordAudio("320061060", var_246_72)
						arg_243_1:RecordAudio("320061060", var_246_72)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_320061", "320061060", "story_v_out_320061.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_320061", "320061060", "story_v_out_320061.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_73 = var_246_62 + 0.3
			local var_246_74 = math.max(var_246_63, arg_243_1.talkMaxDuration)

			if var_246_73 <= arg_243_1.time_ and arg_243_1.time_ < var_246_73 + var_246_74 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_73) / var_246_74

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_73 + var_246_74 and arg_243_1.time_ < var_246_73 + var_246_74 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_243_1:InitPlayNodeList()
	end,
	Play320061061 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 320061061
		arg_249_1.duration_ = 6.7

		local var_249_0 = {
			zh = 4.1,
			ja = 6.7
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
				arg_249_0:Play320061062(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = "1056ui_story"

			if arg_249_1.actors_[var_252_0] == nil then
				local var_252_1 = Asset.Load("Char/" .. "1056ui_story")

				if not isNil(var_252_1) then
					local var_252_2 = Object.Instantiate(Asset.Load("Char/" .. "1056ui_story"), arg_249_1.stage_.transform)

					var_252_2.name = var_252_0
					var_252_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_249_1.actors_[var_252_0] = var_252_2

					local var_252_3 = var_252_2:GetComponentInChildren(typeof(CharacterEffect))

					var_252_3.enabled = true

					local var_252_4 = GameObjectTools.GetOrAddComponent(var_252_2, typeof(DynamicBoneHelper))

					if var_252_4 then
						var_252_4:EnableDynamicBone(false)
					end

					arg_249_1:ShowWeapon(var_252_3.transform, false)

					arg_249_1.var_[var_252_0 .. "Animator"] = var_252_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_249_1.var_[var_252_0 .. "Animator"].applyRootMotion = true
					arg_249_1.var_[var_252_0 .. "LipSync"] = var_252_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_252_5 = arg_249_1.actors_["1056ui_story"].transform
			local var_252_6 = 0

			if var_252_6 < arg_249_1.time_ and arg_249_1.time_ <= var_252_6 + arg_252_0 then
				arg_249_1.var_.moveOldPos1056ui_story = var_252_5.localPosition
			end

			local var_252_7 = 0.001

			if var_252_6 <= arg_249_1.time_ and arg_249_1.time_ < var_252_6 + var_252_7 then
				local var_252_8 = (arg_249_1.time_ - var_252_6) / var_252_7
				local var_252_9 = Vector3.New(0.7, -1, -5.75)

				var_252_5.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos1056ui_story, var_252_9, var_252_8)

				local var_252_10 = manager.ui.mainCamera.transform.position - var_252_5.position

				var_252_5.forward = Vector3.New(var_252_10.x, var_252_10.y, var_252_10.z)

				local var_252_11 = var_252_5.localEulerAngles

				var_252_11.z = 0
				var_252_11.x = 0
				var_252_5.localEulerAngles = var_252_11
			end

			if arg_249_1.time_ >= var_252_6 + var_252_7 and arg_249_1.time_ < var_252_6 + var_252_7 + arg_252_0 then
				var_252_5.localPosition = Vector3.New(0.7, -1, -5.75)

				local var_252_12 = manager.ui.mainCamera.transform.position - var_252_5.position

				var_252_5.forward = Vector3.New(var_252_12.x, var_252_12.y, var_252_12.z)

				local var_252_13 = var_252_5.localEulerAngles

				var_252_13.z = 0
				var_252_13.x = 0
				var_252_5.localEulerAngles = var_252_13
			end

			local var_252_14 = arg_249_1.actors_["1056ui_story"]
			local var_252_15 = 0

			if var_252_15 < arg_249_1.time_ and arg_249_1.time_ <= var_252_15 + arg_252_0 and not isNil(var_252_14) and arg_249_1.var_.characterEffect1056ui_story == nil then
				arg_249_1.var_.characterEffect1056ui_story = var_252_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_16 = 0.200000002980232

			if var_252_15 <= arg_249_1.time_ and arg_249_1.time_ < var_252_15 + var_252_16 and not isNil(var_252_14) then
				local var_252_17 = (arg_249_1.time_ - var_252_15) / var_252_16

				if arg_249_1.var_.characterEffect1056ui_story and not isNil(var_252_14) then
					arg_249_1.var_.characterEffect1056ui_story.fillFlat = false
				end
			end

			if arg_249_1.time_ >= var_252_15 + var_252_16 and arg_249_1.time_ < var_252_15 + var_252_16 + arg_252_0 and not isNil(var_252_14) and arg_249_1.var_.characterEffect1056ui_story then
				arg_249_1.var_.characterEffect1056ui_story.fillFlat = false
			end

			local var_252_18 = 0

			if var_252_18 < arg_249_1.time_ and arg_249_1.time_ <= var_252_18 + arg_252_0 then
				arg_249_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/story1056/story1056action/1056action1_1")
			end

			local var_252_19 = 0

			if var_252_19 < arg_249_1.time_ and arg_249_1.time_ <= var_252_19 + arg_252_0 then
				arg_249_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_252_20 = arg_249_1.actors_["10102ui_story"]
			local var_252_21 = 0

			if var_252_21 < arg_249_1.time_ and arg_249_1.time_ <= var_252_21 + arg_252_0 and not isNil(var_252_20) and arg_249_1.var_.characterEffect10102ui_story == nil then
				arg_249_1.var_.characterEffect10102ui_story = var_252_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_22 = 0.200000002980232

			if var_252_21 <= arg_249_1.time_ and arg_249_1.time_ < var_252_21 + var_252_22 and not isNil(var_252_20) then
				local var_252_23 = (arg_249_1.time_ - var_252_21) / var_252_22

				if arg_249_1.var_.characterEffect10102ui_story and not isNil(var_252_20) then
					local var_252_24 = Mathf.Lerp(0, 0.5, var_252_23)

					arg_249_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_249_1.var_.characterEffect10102ui_story.fillRatio = var_252_24
				end
			end

			if arg_249_1.time_ >= var_252_21 + var_252_22 and arg_249_1.time_ < var_252_21 + var_252_22 + arg_252_0 and not isNil(var_252_20) and arg_249_1.var_.characterEffect10102ui_story then
				local var_252_25 = 0.5

				arg_249_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_249_1.var_.characterEffect10102ui_story.fillRatio = var_252_25
			end

			local var_252_26 = 0
			local var_252_27 = 0.55

			if var_252_26 < arg_249_1.time_ and arg_249_1.time_ <= var_252_26 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				local var_252_28 = arg_249_1:FormatText(StoryNameCfg[605].name)

				arg_249_1.leftNameTxt_.text = var_252_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_29 = arg_249_1:GetWordFromCfg(320061061)
				local var_252_30 = arg_249_1:FormatText(var_252_29.content)

				arg_249_1.text_.text = var_252_30

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_31 = 22
				local var_252_32 = utf8.len(var_252_30)
				local var_252_33 = var_252_31 <= 0 and var_252_27 or var_252_27 * (var_252_32 / var_252_31)

				if var_252_33 > 0 and var_252_27 < var_252_33 then
					arg_249_1.talkMaxDuration = var_252_33

					if var_252_33 + var_252_26 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_33 + var_252_26
					end
				end

				arg_249_1.text_.text = var_252_30
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320061", "320061061", "story_v_out_320061.awb") ~= 0 then
					local var_252_34 = manager.audio:GetVoiceLength("story_v_out_320061", "320061061", "story_v_out_320061.awb") / 1000

					if var_252_34 + var_252_26 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_34 + var_252_26
					end

					if var_252_29.prefab_name ~= "" and arg_249_1.actors_[var_252_29.prefab_name] ~= nil then
						local var_252_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_29.prefab_name].transform, "story_v_out_320061", "320061061", "story_v_out_320061.awb")

						arg_249_1:RecordAudio("320061061", var_252_35)
						arg_249_1:RecordAudio("320061061", var_252_35)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_320061", "320061061", "story_v_out_320061.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_320061", "320061061", "story_v_out_320061.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_36 = math.max(var_252_27, arg_249_1.talkMaxDuration)

			if var_252_26 <= arg_249_1.time_ and arg_249_1.time_ < var_252_26 + var_252_36 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_26) / var_252_36

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_26 + var_252_36 and arg_249_1.time_ < var_252_26 + var_252_36 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056ui_story",
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
	Play320061062 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 320061062
		arg_253_1.duration_ = 7.23

		local var_253_0 = {
			zh = 7.233,
			ja = 7.2
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
				arg_253_0:Play320061063(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = 0
			local var_256_1 = 1.025

			if var_256_0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_0 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				local var_256_2 = arg_253_1:FormatText(StoryNameCfg[605].name)

				arg_253_1.leftNameTxt_.text = var_256_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_3 = arg_253_1:GetWordFromCfg(320061062)
				local var_256_4 = arg_253_1:FormatText(var_256_3.content)

				arg_253_1.text_.text = var_256_4

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_5 = 41
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

				if manager.audio:GetVoiceLength("story_v_out_320061", "320061062", "story_v_out_320061.awb") ~= 0 then
					local var_256_8 = manager.audio:GetVoiceLength("story_v_out_320061", "320061062", "story_v_out_320061.awb") / 1000

					if var_256_8 + var_256_0 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_8 + var_256_0
					end

					if var_256_3.prefab_name ~= "" and arg_253_1.actors_[var_256_3.prefab_name] ~= nil then
						local var_256_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_3.prefab_name].transform, "story_v_out_320061", "320061062", "story_v_out_320061.awb")

						arg_253_1:RecordAudio("320061062", var_256_9)
						arg_253_1:RecordAudio("320061062", var_256_9)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_320061", "320061062", "story_v_out_320061.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_320061", "320061062", "story_v_out_320061.awb")
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
	Play320061063 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 320061063
		arg_257_1.duration_ = 10.5

		local var_257_0 = {
			zh = 6.6,
			ja = 10.5
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
				arg_257_0:Play320061064(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = 0
			local var_260_1 = 0.95

			if var_260_0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_0 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				local var_260_2 = arg_257_1:FormatText(StoryNameCfg[605].name)

				arg_257_1.leftNameTxt_.text = var_260_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_3 = arg_257_1:GetWordFromCfg(320061063)
				local var_260_4 = arg_257_1:FormatText(var_260_3.content)

				arg_257_1.text_.text = var_260_4

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_5 = 38
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

				if manager.audio:GetVoiceLength("story_v_out_320061", "320061063", "story_v_out_320061.awb") ~= 0 then
					local var_260_8 = manager.audio:GetVoiceLength("story_v_out_320061", "320061063", "story_v_out_320061.awb") / 1000

					if var_260_8 + var_260_0 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_8 + var_260_0
					end

					if var_260_3.prefab_name ~= "" and arg_257_1.actors_[var_260_3.prefab_name] ~= nil then
						local var_260_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_3.prefab_name].transform, "story_v_out_320061", "320061063", "story_v_out_320061.awb")

						arg_257_1:RecordAudio("320061063", var_260_9)
						arg_257_1:RecordAudio("320061063", var_260_9)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_320061", "320061063", "story_v_out_320061.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_320061", "320061063", "story_v_out_320061.awb")
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
	Play320061064 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 320061064
		arg_261_1.duration_ = 9

		local var_261_0 = {
			zh = 7,
			ja = 9
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
				arg_261_0:Play320061065(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = arg_261_1.actors_["10102ui_story"]
			local var_264_1 = 0

			if var_264_1 < arg_261_1.time_ and arg_261_1.time_ <= var_264_1 + arg_264_0 and not isNil(var_264_0) and arg_261_1.var_.characterEffect10102ui_story == nil then
				arg_261_1.var_.characterEffect10102ui_story = var_264_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_2 = 0.200000002980232

			if var_264_1 <= arg_261_1.time_ and arg_261_1.time_ < var_264_1 + var_264_2 and not isNil(var_264_0) then
				local var_264_3 = (arg_261_1.time_ - var_264_1) / var_264_2

				if arg_261_1.var_.characterEffect10102ui_story and not isNil(var_264_0) then
					arg_261_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_261_1.time_ >= var_264_1 + var_264_2 and arg_261_1.time_ < var_264_1 + var_264_2 + arg_264_0 and not isNil(var_264_0) and arg_261_1.var_.characterEffect10102ui_story then
				arg_261_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_264_4 = 0

			if var_264_4 < arg_261_1.time_ and arg_261_1.time_ <= var_264_4 + arg_264_0 then
				arg_261_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action5_1")
			end

			local var_264_5 = 0

			if var_264_5 < arg_261_1.time_ and arg_261_1.time_ <= var_264_5 + arg_264_0 then
				arg_261_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_264_6 = arg_261_1.actors_["1056ui_story"]
			local var_264_7 = 0

			if var_264_7 < arg_261_1.time_ and arg_261_1.time_ <= var_264_7 + arg_264_0 and not isNil(var_264_6) and arg_261_1.var_.characterEffect1056ui_story == nil then
				arg_261_1.var_.characterEffect1056ui_story = var_264_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_8 = 0.200000002980232

			if var_264_7 <= arg_261_1.time_ and arg_261_1.time_ < var_264_7 + var_264_8 and not isNil(var_264_6) then
				local var_264_9 = (arg_261_1.time_ - var_264_7) / var_264_8

				if arg_261_1.var_.characterEffect1056ui_story and not isNil(var_264_6) then
					local var_264_10 = Mathf.Lerp(0, 0.5, var_264_9)

					arg_261_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_261_1.var_.characterEffect1056ui_story.fillRatio = var_264_10
				end
			end

			if arg_261_1.time_ >= var_264_7 + var_264_8 and arg_261_1.time_ < var_264_7 + var_264_8 + arg_264_0 and not isNil(var_264_6) and arg_261_1.var_.characterEffect1056ui_story then
				local var_264_11 = 0.5

				arg_261_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_261_1.var_.characterEffect1056ui_story.fillRatio = var_264_11
			end

			local var_264_12 = 0
			local var_264_13 = 0.9

			if var_264_12 < arg_261_1.time_ and arg_261_1.time_ <= var_264_12 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				local var_264_14 = arg_261_1:FormatText(StoryNameCfg[6].name)

				arg_261_1.leftNameTxt_.text = var_264_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_15 = arg_261_1:GetWordFromCfg(320061064)
				local var_264_16 = arg_261_1:FormatText(var_264_15.content)

				arg_261_1.text_.text = var_264_16

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_17 = 36
				local var_264_18 = utf8.len(var_264_16)
				local var_264_19 = var_264_17 <= 0 and var_264_13 or var_264_13 * (var_264_18 / var_264_17)

				if var_264_19 > 0 and var_264_13 < var_264_19 then
					arg_261_1.talkMaxDuration = var_264_19

					if var_264_19 + var_264_12 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_19 + var_264_12
					end
				end

				arg_261_1.text_.text = var_264_16
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320061", "320061064", "story_v_out_320061.awb") ~= 0 then
					local var_264_20 = manager.audio:GetVoiceLength("story_v_out_320061", "320061064", "story_v_out_320061.awb") / 1000

					if var_264_20 + var_264_12 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_20 + var_264_12
					end

					if var_264_15.prefab_name ~= "" and arg_261_1.actors_[var_264_15.prefab_name] ~= nil then
						local var_264_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_15.prefab_name].transform, "story_v_out_320061", "320061064", "story_v_out_320061.awb")

						arg_261_1:RecordAudio("320061064", var_264_21)
						arg_261_1:RecordAudio("320061064", var_264_21)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_320061", "320061064", "story_v_out_320061.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_320061", "320061064", "story_v_out_320061.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_22 = math.max(var_264_13, arg_261_1.talkMaxDuration)

			if var_264_12 <= arg_261_1.time_ and arg_261_1.time_ < var_264_12 + var_264_22 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_12) / var_264_22

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_12 + var_264_22 and arg_261_1.time_ < var_264_12 + var_264_22 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play320061065 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 320061065
		arg_265_1.duration_ = 6.4

		local var_265_0 = {
			zh = 6.4,
			ja = 5.6
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
				arg_265_0:Play320061066(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = arg_265_1.actors_["1056ui_story"]
			local var_268_1 = 0

			if var_268_1 < arg_265_1.time_ and arg_265_1.time_ <= var_268_1 + arg_268_0 and not isNil(var_268_0) and arg_265_1.var_.characterEffect1056ui_story == nil then
				arg_265_1.var_.characterEffect1056ui_story = var_268_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_2 = 0.200000002980232

			if var_268_1 <= arg_265_1.time_ and arg_265_1.time_ < var_268_1 + var_268_2 and not isNil(var_268_0) then
				local var_268_3 = (arg_265_1.time_ - var_268_1) / var_268_2

				if arg_265_1.var_.characterEffect1056ui_story and not isNil(var_268_0) then
					arg_265_1.var_.characterEffect1056ui_story.fillFlat = false
				end
			end

			if arg_265_1.time_ >= var_268_1 + var_268_2 and arg_265_1.time_ < var_268_1 + var_268_2 + arg_268_0 and not isNil(var_268_0) and arg_265_1.var_.characterEffect1056ui_story then
				arg_265_1.var_.characterEffect1056ui_story.fillFlat = false
			end

			local var_268_4 = arg_265_1.actors_["10102ui_story"]
			local var_268_5 = 0

			if var_268_5 < arg_265_1.time_ and arg_265_1.time_ <= var_268_5 + arg_268_0 and not isNil(var_268_4) and arg_265_1.var_.characterEffect10102ui_story == nil then
				arg_265_1.var_.characterEffect10102ui_story = var_268_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_6 = 0.200000002980232

			if var_268_5 <= arg_265_1.time_ and arg_265_1.time_ < var_268_5 + var_268_6 and not isNil(var_268_4) then
				local var_268_7 = (arg_265_1.time_ - var_268_5) / var_268_6

				if arg_265_1.var_.characterEffect10102ui_story and not isNil(var_268_4) then
					local var_268_8 = Mathf.Lerp(0, 0.5, var_268_7)

					arg_265_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_265_1.var_.characterEffect10102ui_story.fillRatio = var_268_8
				end
			end

			if arg_265_1.time_ >= var_268_5 + var_268_6 and arg_265_1.time_ < var_268_5 + var_268_6 + arg_268_0 and not isNil(var_268_4) and arg_265_1.var_.characterEffect10102ui_story then
				local var_268_9 = 0.5

				arg_265_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_265_1.var_.characterEffect10102ui_story.fillRatio = var_268_9
			end

			local var_268_10 = 0
			local var_268_11 = 0.525

			if var_268_10 < arg_265_1.time_ and arg_265_1.time_ <= var_268_10 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				local var_268_12 = arg_265_1:FormatText(StoryNameCfg[605].name)

				arg_265_1.leftNameTxt_.text = var_268_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_13 = arg_265_1:GetWordFromCfg(320061065)
				local var_268_14 = arg_265_1:FormatText(var_268_13.content)

				arg_265_1.text_.text = var_268_14

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_15 = 21
				local var_268_16 = utf8.len(var_268_14)
				local var_268_17 = var_268_15 <= 0 and var_268_11 or var_268_11 * (var_268_16 / var_268_15)

				if var_268_17 > 0 and var_268_11 < var_268_17 then
					arg_265_1.talkMaxDuration = var_268_17

					if var_268_17 + var_268_10 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_17 + var_268_10
					end
				end

				arg_265_1.text_.text = var_268_14
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320061", "320061065", "story_v_out_320061.awb") ~= 0 then
					local var_268_18 = manager.audio:GetVoiceLength("story_v_out_320061", "320061065", "story_v_out_320061.awb") / 1000

					if var_268_18 + var_268_10 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_18 + var_268_10
					end

					if var_268_13.prefab_name ~= "" and arg_265_1.actors_[var_268_13.prefab_name] ~= nil then
						local var_268_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_13.prefab_name].transform, "story_v_out_320061", "320061065", "story_v_out_320061.awb")

						arg_265_1:RecordAudio("320061065", var_268_19)
						arg_265_1:RecordAudio("320061065", var_268_19)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_320061", "320061065", "story_v_out_320061.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_320061", "320061065", "story_v_out_320061.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_20 = math.max(var_268_11, arg_265_1.talkMaxDuration)

			if var_268_10 <= arg_265_1.time_ and arg_265_1.time_ < var_268_10 + var_268_20 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_10) / var_268_20

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_10 + var_268_20 and arg_265_1.time_ < var_268_10 + var_268_20 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play320061066 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 320061066
		arg_269_1.duration_ = 2.52

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play320061067(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = arg_269_1.actors_["1056ui_story"].transform
			local var_272_1 = 1.48333333333333

			if var_272_1 < arg_269_1.time_ and arg_269_1.time_ <= var_272_1 + arg_272_0 then
				arg_269_1.var_.moveOldPos1056ui_story = var_272_0.localPosition
			end

			local var_272_2 = 0.001

			if var_272_1 <= arg_269_1.time_ and arg_269_1.time_ < var_272_1 + var_272_2 then
				local var_272_3 = (arg_269_1.time_ - var_272_1) / var_272_2
				local var_272_4 = Vector3.New(0, 100, 0)

				var_272_0.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos1056ui_story, var_272_4, var_272_3)

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

			local var_272_9 = arg_269_1.actors_["1056ui_story"]
			local var_272_10 = 1.48333333333333

			if var_272_10 < arg_269_1.time_ and arg_269_1.time_ <= var_272_10 + arg_272_0 and not isNil(var_272_9) and arg_269_1.var_.characterEffect1056ui_story == nil then
				arg_269_1.var_.characterEffect1056ui_story = var_272_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_11 = 0.0166666666666666

			if var_272_10 <= arg_269_1.time_ and arg_269_1.time_ < var_272_10 + var_272_11 and not isNil(var_272_9) then
				local var_272_12 = (arg_269_1.time_ - var_272_10) / var_272_11

				if arg_269_1.var_.characterEffect1056ui_story and not isNil(var_272_9) then
					local var_272_13 = Mathf.Lerp(0, 0.5, var_272_12)

					arg_269_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_269_1.var_.characterEffect1056ui_story.fillRatio = var_272_13
				end
			end

			if arg_269_1.time_ >= var_272_10 + var_272_11 and arg_269_1.time_ < var_272_10 + var_272_11 + arg_272_0 and not isNil(var_272_9) and arg_269_1.var_.characterEffect1056ui_story then
				local var_272_14 = 0.5

				arg_269_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_269_1.var_.characterEffect1056ui_story.fillRatio = var_272_14
			end

			local var_272_15 = arg_269_1.actors_["10102ui_story"].transform
			local var_272_16 = 1.48333333333333

			if var_272_16 < arg_269_1.time_ and arg_269_1.time_ <= var_272_16 + arg_272_0 then
				arg_269_1.var_.moveOldPos10102ui_story = var_272_15.localPosition
			end

			local var_272_17 = 0.001

			if var_272_16 <= arg_269_1.time_ and arg_269_1.time_ < var_272_16 + var_272_17 then
				local var_272_18 = (arg_269_1.time_ - var_272_16) / var_272_17
				local var_272_19 = Vector3.New(0, 100, 0)

				var_272_15.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos10102ui_story, var_272_19, var_272_18)

				local var_272_20 = manager.ui.mainCamera.transform.position - var_272_15.position

				var_272_15.forward = Vector3.New(var_272_20.x, var_272_20.y, var_272_20.z)

				local var_272_21 = var_272_15.localEulerAngles

				var_272_21.z = 0
				var_272_21.x = 0
				var_272_15.localEulerAngles = var_272_21
			end

			if arg_269_1.time_ >= var_272_16 + var_272_17 and arg_269_1.time_ < var_272_16 + var_272_17 + arg_272_0 then
				var_272_15.localPosition = Vector3.New(0, 100, 0)

				local var_272_22 = manager.ui.mainCamera.transform.position - var_272_15.position

				var_272_15.forward = Vector3.New(var_272_22.x, var_272_22.y, var_272_22.z)

				local var_272_23 = var_272_15.localEulerAngles

				var_272_23.z = 0
				var_272_23.x = 0
				var_272_15.localEulerAngles = var_272_23
			end

			local var_272_24 = arg_269_1.actors_["10102ui_story"]
			local var_272_25 = 1.48333333333333

			if var_272_25 < arg_269_1.time_ and arg_269_1.time_ <= var_272_25 + arg_272_0 and not isNil(var_272_24) and arg_269_1.var_.characterEffect10102ui_story == nil then
				arg_269_1.var_.characterEffect10102ui_story = var_272_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_26 = 0.0166666666666666

			if var_272_25 <= arg_269_1.time_ and arg_269_1.time_ < var_272_25 + var_272_26 and not isNil(var_272_24) then
				local var_272_27 = (arg_269_1.time_ - var_272_25) / var_272_26

				if arg_269_1.var_.characterEffect10102ui_story and not isNil(var_272_24) then
					local var_272_28 = Mathf.Lerp(0, 0.5, var_272_27)

					arg_269_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_269_1.var_.characterEffect10102ui_story.fillRatio = var_272_28
				end
			end

			if arg_269_1.time_ >= var_272_25 + var_272_26 and arg_269_1.time_ < var_272_25 + var_272_26 + arg_272_0 and not isNil(var_272_24) and arg_269_1.var_.characterEffect10102ui_story then
				local var_272_29 = 0.5

				arg_269_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_269_1.var_.characterEffect10102ui_story.fillRatio = var_272_29
			end

			local var_272_30 = 0

			if var_272_30 < arg_269_1.time_ and arg_269_1.time_ <= var_272_30 + arg_272_0 then
				arg_269_1.mask_.enabled = true
				arg_269_1.mask_.raycastTarget = true

				arg_269_1:SetGaussion(false)
			end

			local var_272_31 = 1.5

			if var_272_30 <= arg_269_1.time_ and arg_269_1.time_ < var_272_30 + var_272_31 then
				local var_272_32 = (arg_269_1.time_ - var_272_30) / var_272_31
				local var_272_33 = Color.New(0, 0, 0)

				var_272_33.a = Mathf.Lerp(0, 1, var_272_32)
				arg_269_1.mask_.color = var_272_33
			end

			if arg_269_1.time_ >= var_272_30 + var_272_31 and arg_269_1.time_ < var_272_30 + var_272_31 + arg_272_0 then
				local var_272_34 = Color.New(0, 0, 0)

				var_272_34.a = 1
				arg_269_1.mask_.color = var_272_34
			end

			local var_272_35 = 1.5

			if var_272_35 < arg_269_1.time_ and arg_269_1.time_ <= var_272_35 + arg_272_0 then
				arg_269_1.mask_.enabled = true
				arg_269_1.mask_.raycastTarget = true

				arg_269_1:SetGaussion(false)
			end

			local var_272_36 = 1

			if var_272_35 <= arg_269_1.time_ and arg_269_1.time_ < var_272_35 + var_272_36 then
				local var_272_37 = (arg_269_1.time_ - var_272_35) / var_272_36
				local var_272_38 = Color.New(0, 0, 0)

				var_272_38.a = Mathf.Lerp(1, 0, var_272_37)
				arg_269_1.mask_.color = var_272_38
			end

			if arg_269_1.time_ >= var_272_35 + var_272_36 and arg_269_1.time_ < var_272_35 + var_272_36 + arg_272_0 then
				local var_272_39 = Color.New(0, 0, 0)
				local var_272_40 = 0

				arg_269_1.mask_.enabled = false
				var_272_39.a = var_272_40
				arg_269_1.mask_.color = var_272_39
			end

			local var_272_41 = 1.5

			if var_272_41 < arg_269_1.time_ and arg_269_1.time_ <= var_272_41 + arg_272_0 then
				arg_269_1.fswbg_:SetActive(true)
				arg_269_1.dialog_:SetActive(false)

				arg_269_1.fswtw_.percent = 0

				local var_272_42 = arg_269_1:GetWordFromCfg(320061066)
				local var_272_43 = arg_269_1:FormatText(var_272_42.content)

				arg_269_1.fswt_.text = var_272_43

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.fswt_)

				arg_269_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_269_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_269_1.fswtw_:SetDirty()

				arg_269_1.typewritterCharCountI18N = 0

				SetActive(arg_269_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_269_1:ShowNextGo(false)
			end

			local var_272_44 = 1.51666666666667

			if var_272_44 < arg_269_1.time_ and arg_269_1.time_ <= var_272_44 + arg_272_0 then
				arg_269_1.var_.oldValueTypewriter = arg_269_1.fswtw_.percent

				SetActive(arg_269_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_269_1:ShowNextGo(false)
			end

			local var_272_45 = 6
			local var_272_46 = 0.4
			local var_272_47 = arg_269_1:GetWordFromCfg(320061066)
			local var_272_48 = arg_269_1:FormatText(var_272_47.content)
			local var_272_49, var_272_50 = arg_269_1:GetPercentByPara(var_272_48, 1)

			if var_272_44 < arg_269_1.time_ and arg_269_1.time_ <= var_272_44 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0

				local var_272_51 = var_272_45 <= 0 and var_272_46 or var_272_46 * ((var_272_50 - arg_269_1.typewritterCharCountI18N) / var_272_45)

				if var_272_51 > 0 and var_272_46 < var_272_51 then
					arg_269_1.talkMaxDuration = var_272_51

					if var_272_51 + var_272_44 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_51 + var_272_44
					end
				end
			end

			local var_272_52 = 0.4
			local var_272_53 = math.max(var_272_52, arg_269_1.talkMaxDuration)

			if var_272_44 <= arg_269_1.time_ and arg_269_1.time_ < var_272_44 + var_272_53 then
				local var_272_54 = (arg_269_1.time_ - var_272_44) / var_272_53

				arg_269_1.fswtw_.percent = Mathf.Lerp(arg_269_1.var_.oldValueTypewriter, var_272_49, var_272_54)
				arg_269_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_269_1.fswtw_:SetDirty()
			end

			if arg_269_1.time_ >= var_272_44 + var_272_53 and arg_269_1.time_ < var_272_44 + var_272_53 + arg_272_0 then
				arg_269_1.fswtw_.percent = var_272_49

				arg_269_1.fswtw_:SetDirty()
				arg_269_1:ShowNextGo(true)

				arg_269_1.typewritterCharCountI18N = var_272_50
			end

			local var_272_55 = 1.51666666666667

			if var_272_55 < arg_269_1.time_ and arg_269_1.time_ <= var_272_55 + arg_272_0 then
				local var_272_56 = arg_269_1.fswbg_.transform:Find("textbox/adapt/content") or arg_269_1.fswbg_.transform:Find("textbox/content")
				local var_272_57 = arg_269_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_272_58 = var_272_56:GetComponent("Text")
				local var_272_59 = var_272_56:GetComponent("RectTransform")

				var_272_58.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_272_59.offsetMin = Vector2.New(0, 0)
				var_272_59.offsetMax = Vector2.New(0, 0)
			end

			local var_272_60 = "STblack"

			if arg_269_1.bgs_[var_272_60] == nil then
				local var_272_61 = Object.Instantiate(arg_269_1.paintGo_)

				var_272_61:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_272_60)
				var_272_61.name = var_272_60
				var_272_61.transform.parent = arg_269_1.stage_.transform
				var_272_61.transform.localPosition = Vector3.New(0, 100, 0)
				arg_269_1.bgs_[var_272_60] = var_272_61
			end

			local var_272_62 = 1.51666666666667

			if var_272_62 < arg_269_1.time_ and arg_269_1.time_ <= var_272_62 + arg_272_0 then
				local var_272_63 = manager.ui.mainCamera.transform.localPosition
				local var_272_64 = Vector3.New(0, 0, 10) + Vector3.New(var_272_63.x, var_272_63.y, 0)
				local var_272_65 = arg_269_1.bgs_.STblack

				var_272_65.transform.localPosition = var_272_64
				var_272_65.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_272_66 = var_272_65:GetComponent("SpriteRenderer")

				if var_272_66 and var_272_66.sprite then
					local var_272_67 = (var_272_65.transform.localPosition - var_272_63).z
					local var_272_68 = manager.ui.mainCameraCom_
					local var_272_69 = 2 * var_272_67 * Mathf.Tan(var_272_68.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_272_70 = var_272_69 * var_272_68.aspect
					local var_272_71 = var_272_66.sprite.bounds.size.x
					local var_272_72 = var_272_66.sprite.bounds.size.y
					local var_272_73 = var_272_70 / var_272_71
					local var_272_74 = var_272_69 / var_272_72
					local var_272_75 = var_272_74 < var_272_73 and var_272_73 or var_272_74

					var_272_65.transform.localScale = Vector3.New(var_272_75, var_272_75, 0)
				end

				for iter_272_0, iter_272_1 in pairs(arg_269_1.bgs_) do
					if iter_272_0 ~= "STblack" then
						iter_272_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end
		end

		arg_269_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666666,
				className = "StoryMoveNode",
				startTime = 1.48333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666666,
				className = "StoryMoveNode",
				startTime = 1.48333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_269_1:InitPlayNodeList()
	end,
	Play320061067 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 320061067
		arg_273_1.duration_ = 3

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play320061068(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = arg_273_1.actors_["10102ui_story"].transform
			local var_276_1 = 1

			if var_276_1 < arg_273_1.time_ and arg_273_1.time_ <= var_276_1 + arg_276_0 then
				arg_273_1.var_.moveOldPos10102ui_story = var_276_0.localPosition
			end

			local var_276_2 = 0.001

			if var_276_1 <= arg_273_1.time_ and arg_273_1.time_ < var_276_1 + var_276_2 then
				local var_276_3 = (arg_273_1.time_ - var_276_1) / var_276_2
				local var_276_4 = Vector3.New(0, -0.985, -6.275)

				var_276_0.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos10102ui_story, var_276_4, var_276_3)

				local var_276_5 = manager.ui.mainCamera.transform.position - var_276_0.position

				var_276_0.forward = Vector3.New(var_276_5.x, var_276_5.y, var_276_5.z)

				local var_276_6 = var_276_0.localEulerAngles

				var_276_6.z = 0
				var_276_6.x = 0
				var_276_0.localEulerAngles = var_276_6
			end

			if arg_273_1.time_ >= var_276_1 + var_276_2 and arg_273_1.time_ < var_276_1 + var_276_2 + arg_276_0 then
				var_276_0.localPosition = Vector3.New(0, -0.985, -6.275)

				local var_276_7 = manager.ui.mainCamera.transform.position - var_276_0.position

				var_276_0.forward = Vector3.New(var_276_7.x, var_276_7.y, var_276_7.z)

				local var_276_8 = var_276_0.localEulerAngles

				var_276_8.z = 0
				var_276_8.x = 0
				var_276_0.localEulerAngles = var_276_8
			end

			local var_276_9 = arg_273_1.actors_["10102ui_story"]
			local var_276_10 = 1

			if var_276_10 < arg_273_1.time_ and arg_273_1.time_ <= var_276_10 + arg_276_0 and not isNil(var_276_9) and arg_273_1.var_.characterEffect10102ui_story == nil then
				arg_273_1.var_.characterEffect10102ui_story = var_276_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_11 = 0.200000002980232

			if var_276_10 <= arg_273_1.time_ and arg_273_1.time_ < var_276_10 + var_276_11 and not isNil(var_276_9) then
				local var_276_12 = (arg_273_1.time_ - var_276_10) / var_276_11

				if arg_273_1.var_.characterEffect10102ui_story and not isNil(var_276_9) then
					arg_273_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_273_1.time_ >= var_276_10 + var_276_11 and arg_273_1.time_ < var_276_10 + var_276_11 + arg_276_0 and not isNil(var_276_9) and arg_273_1.var_.characterEffect10102ui_story then
				arg_273_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_276_13 = 1

			if var_276_13 < arg_273_1.time_ and arg_273_1.time_ <= var_276_13 + arg_276_0 then
				arg_273_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action5_2")
			end

			local var_276_14 = 1

			if var_276_14 < arg_273_1.time_ and arg_273_1.time_ <= var_276_14 + arg_276_0 then
				arg_273_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_276_15 = 0

			if var_276_15 < arg_273_1.time_ and arg_273_1.time_ <= var_276_15 + arg_276_0 then
				arg_273_1.fswbg_:SetActive(false)
				arg_273_1.dialog_:SetActive(false)
				SetActive(arg_273_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_273_1:ShowNextGo(false)
			end

			local var_276_16 = 0

			if var_276_16 < arg_273_1.time_ and arg_273_1.time_ <= var_276_16 + arg_276_0 then
				arg_273_1.mask_.enabled = true
				arg_273_1.mask_.raycastTarget = true

				arg_273_1:SetGaussion(false)
			end

			local var_276_17 = 1

			if var_276_16 <= arg_273_1.time_ and arg_273_1.time_ < var_276_16 + var_276_17 then
				local var_276_18 = (arg_273_1.time_ - var_276_16) / var_276_17
				local var_276_19 = Color.New(0, 0, 0)

				var_276_19.a = Mathf.Lerp(1, 0, var_276_18)
				arg_273_1.mask_.color = var_276_19
			end

			if arg_273_1.time_ >= var_276_16 + var_276_17 and arg_273_1.time_ < var_276_16 + var_276_17 + arg_276_0 then
				local var_276_20 = Color.New(0, 0, 0)
				local var_276_21 = 0

				arg_273_1.mask_.enabled = false
				var_276_20.a = var_276_21
				arg_273_1.mask_.color = var_276_20
			end

			local var_276_22 = 0

			if var_276_22 < arg_273_1.time_ and arg_273_1.time_ <= var_276_22 + arg_276_0 then
				local var_276_23 = manager.ui.mainCamera.transform.localPosition
				local var_276_24 = Vector3.New(0, 0, 10) + Vector3.New(var_276_23.x, var_276_23.y, 0)
				local var_276_25 = arg_273_1.bgs_.ST61

				var_276_25.transform.localPosition = var_276_24
				var_276_25.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_276_26 = var_276_25:GetComponent("SpriteRenderer")

				if var_276_26 and var_276_26.sprite then
					local var_276_27 = (var_276_25.transform.localPosition - var_276_23).z
					local var_276_28 = manager.ui.mainCameraCom_
					local var_276_29 = 2 * var_276_27 * Mathf.Tan(var_276_28.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_276_30 = var_276_29 * var_276_28.aspect
					local var_276_31 = var_276_26.sprite.bounds.size.x
					local var_276_32 = var_276_26.sprite.bounds.size.y
					local var_276_33 = var_276_30 / var_276_31
					local var_276_34 = var_276_29 / var_276_32
					local var_276_35 = var_276_34 < var_276_33 and var_276_33 or var_276_34

					var_276_25.transform.localScale = Vector3.New(var_276_35, var_276_35, 0)
				end

				for iter_276_0, iter_276_1 in pairs(arg_273_1.bgs_) do
					if iter_276_0 ~= "ST61" then
						iter_276_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if arg_273_1.frameCnt_ <= 1 then
				arg_273_1.dialog_:SetActive(false)
			end

			local var_276_36 = 1
			local var_276_37 = 0.125

			if var_276_36 < arg_273_1.time_ and arg_273_1.time_ <= var_276_36 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0

				arg_273_1.dialog_:SetActive(true)

				arg_273_1.dialogCg_.alpha = 0

				local var_276_38 = LeanTween.value(arg_273_1.dialog_, 0, 1, 0.3)

				var_276_38:setOnUpdate(LuaHelper.FloatAction(function(arg_277_0)
					arg_273_1.dialogCg_.alpha = arg_277_0
				end))
				var_276_38:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_273_1.dialog_)
					var_276_38:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_273_1.duration_ = arg_273_1.duration_ + 0.3

				SetActive(arg_273_1.leftNameGo_, true)

				local var_276_39 = arg_273_1:FormatText(StoryNameCfg[6].name)

				arg_273_1.leftNameTxt_.text = var_276_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_40 = arg_273_1:GetWordFromCfg(320061067)
				local var_276_41 = arg_273_1:FormatText(var_276_40.content)

				arg_273_1.text_.text = var_276_41

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_42 = 5
				local var_276_43 = utf8.len(var_276_41)
				local var_276_44 = var_276_42 <= 0 and var_276_37 or var_276_37 * (var_276_43 / var_276_42)

				if var_276_44 > 0 and var_276_37 < var_276_44 then
					arg_273_1.talkMaxDuration = var_276_44
					var_276_36 = var_276_36 + 0.3

					if var_276_44 + var_276_36 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_44 + var_276_36
					end
				end

				arg_273_1.text_.text = var_276_41
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320061", "320061067", "story_v_out_320061.awb") ~= 0 then
					local var_276_45 = manager.audio:GetVoiceLength("story_v_out_320061", "320061067", "story_v_out_320061.awb") / 1000

					if var_276_45 + var_276_36 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_45 + var_276_36
					end

					if var_276_40.prefab_name ~= "" and arg_273_1.actors_[var_276_40.prefab_name] ~= nil then
						local var_276_46 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_40.prefab_name].transform, "story_v_out_320061", "320061067", "story_v_out_320061.awb")

						arg_273_1:RecordAudio("320061067", var_276_46)
						arg_273_1:RecordAudio("320061067", var_276_46)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_320061", "320061067", "story_v_out_320061.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_320061", "320061067", "story_v_out_320061.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_47 = var_276_36 + 0.3
			local var_276_48 = math.max(var_276_37, arg_273_1.talkMaxDuration)

			if var_276_47 <= arg_273_1.time_ and arg_273_1.time_ < var_276_47 + var_276_48 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_47) / var_276_48

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_47 + var_276_48 and arg_273_1.time_ < var_276_47 + var_276_48 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_273_1:InitPlayNodeList()
	end,
	Play320061068 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 320061068
		arg_279_1.duration_ = 5

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play320061069(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			local var_282_0 = arg_279_1.actors_["10102ui_story"].transform
			local var_282_1 = 0

			if var_282_1 < arg_279_1.time_ and arg_279_1.time_ <= var_282_1 + arg_282_0 then
				arg_279_1.var_.moveOldPos10102ui_story = var_282_0.localPosition
			end

			local var_282_2 = 0.001

			if var_282_1 <= arg_279_1.time_ and arg_279_1.time_ < var_282_1 + var_282_2 then
				local var_282_3 = (arg_279_1.time_ - var_282_1) / var_282_2
				local var_282_4 = Vector3.New(0, 100, 0)

				var_282_0.localPosition = Vector3.Lerp(arg_279_1.var_.moveOldPos10102ui_story, var_282_4, var_282_3)

				local var_282_5 = manager.ui.mainCamera.transform.position - var_282_0.position

				var_282_0.forward = Vector3.New(var_282_5.x, var_282_5.y, var_282_5.z)

				local var_282_6 = var_282_0.localEulerAngles

				var_282_6.z = 0
				var_282_6.x = 0
				var_282_0.localEulerAngles = var_282_6
			end

			if arg_279_1.time_ >= var_282_1 + var_282_2 and arg_279_1.time_ < var_282_1 + var_282_2 + arg_282_0 then
				var_282_0.localPosition = Vector3.New(0, 100, 0)

				local var_282_7 = manager.ui.mainCamera.transform.position - var_282_0.position

				var_282_0.forward = Vector3.New(var_282_7.x, var_282_7.y, var_282_7.z)

				local var_282_8 = var_282_0.localEulerAngles

				var_282_8.z = 0
				var_282_8.x = 0
				var_282_0.localEulerAngles = var_282_8
			end

			local var_282_9 = arg_279_1.actors_["10102ui_story"]
			local var_282_10 = 0

			if var_282_10 < arg_279_1.time_ and arg_279_1.time_ <= var_282_10 + arg_282_0 and not isNil(var_282_9) and arg_279_1.var_.characterEffect10102ui_story == nil then
				arg_279_1.var_.characterEffect10102ui_story = var_282_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_11 = 0.200000002980232

			if var_282_10 <= arg_279_1.time_ and arg_279_1.time_ < var_282_10 + var_282_11 and not isNil(var_282_9) then
				local var_282_12 = (arg_279_1.time_ - var_282_10) / var_282_11

				if arg_279_1.var_.characterEffect10102ui_story and not isNil(var_282_9) then
					local var_282_13 = Mathf.Lerp(0, 0.5, var_282_12)

					arg_279_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_279_1.var_.characterEffect10102ui_story.fillRatio = var_282_13
				end
			end

			if arg_279_1.time_ >= var_282_10 + var_282_11 and arg_279_1.time_ < var_282_10 + var_282_11 + arg_282_0 and not isNil(var_282_9) and arg_279_1.var_.characterEffect10102ui_story then
				local var_282_14 = 0.5

				arg_279_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_279_1.var_.characterEffect10102ui_story.fillRatio = var_282_14
			end

			local var_282_15 = 0
			local var_282_16 = 1.05

			if var_282_15 < arg_279_1.time_ and arg_279_1.time_ <= var_282_15 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, false)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_17 = arg_279_1:GetWordFromCfg(320061068)
				local var_282_18 = arg_279_1:FormatText(var_282_17.content)

				arg_279_1.text_.text = var_282_18

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_19 = 42
				local var_282_20 = utf8.len(var_282_18)
				local var_282_21 = var_282_19 <= 0 and var_282_16 or var_282_16 * (var_282_20 / var_282_19)

				if var_282_21 > 0 and var_282_16 < var_282_21 then
					arg_279_1.talkMaxDuration = var_282_21

					if var_282_21 + var_282_15 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_21 + var_282_15
					end
				end

				arg_279_1.text_.text = var_282_18
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)
				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_22 = math.max(var_282_16, arg_279_1.talkMaxDuration)

			if var_282_15 <= arg_279_1.time_ and arg_279_1.time_ < var_282_15 + var_282_22 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_15) / var_282_22

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_15 + var_282_22 and arg_279_1.time_ < var_282_15 + var_282_22 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_279_1:InitPlayNodeList()
	end,
	Play320061069 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 320061069
		arg_283_1.duration_ = 5

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play320061070(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			local var_286_0 = 0
			local var_286_1 = 0.575

			if var_286_0 < arg_283_1.time_ and arg_283_1.time_ <= var_286_0 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, false)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_2 = arg_283_1:GetWordFromCfg(320061069)
				local var_286_3 = arg_283_1:FormatText(var_286_2.content)

				arg_283_1.text_.text = var_286_3

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_4 = 23
				local var_286_5 = utf8.len(var_286_3)
				local var_286_6 = var_286_4 <= 0 and var_286_1 or var_286_1 * (var_286_5 / var_286_4)

				if var_286_6 > 0 and var_286_1 < var_286_6 then
					arg_283_1.talkMaxDuration = var_286_6

					if var_286_6 + var_286_0 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_6 + var_286_0
					end
				end

				arg_283_1.text_.text = var_286_3
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)
				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_7 = math.max(var_286_1, arg_283_1.talkMaxDuration)

			if var_286_0 <= arg_283_1.time_ and arg_283_1.time_ < var_286_0 + var_286_7 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_0) / var_286_7

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_0 + var_286_7 and arg_283_1.time_ < var_286_0 + var_286_7 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {}

		arg_283_1:InitPlayNodeList()
	end,
	Play320061070 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 320061070
		arg_287_1.duration_ = 8.2

		local var_287_0 = {
			zh = 7.433,
			ja = 8.2
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
				arg_287_0:Play320061071(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			local var_290_0 = arg_287_1.actors_["1056ui_story"].transform
			local var_290_1 = 0

			if var_290_1 < arg_287_1.time_ and arg_287_1.time_ <= var_290_1 + arg_290_0 then
				arg_287_1.var_.moveOldPos1056ui_story = var_290_0.localPosition
			end

			local var_290_2 = 0.001

			if var_290_1 <= arg_287_1.time_ and arg_287_1.time_ < var_290_1 + var_290_2 then
				local var_290_3 = (arg_287_1.time_ - var_290_1) / var_290_2
				local var_290_4 = Vector3.New(0, -1, -5.75)

				var_290_0.localPosition = Vector3.Lerp(arg_287_1.var_.moveOldPos1056ui_story, var_290_4, var_290_3)

				local var_290_5 = manager.ui.mainCamera.transform.position - var_290_0.position

				var_290_0.forward = Vector3.New(var_290_5.x, var_290_5.y, var_290_5.z)

				local var_290_6 = var_290_0.localEulerAngles

				var_290_6.z = 0
				var_290_6.x = 0
				var_290_0.localEulerAngles = var_290_6
			end

			if arg_287_1.time_ >= var_290_1 + var_290_2 and arg_287_1.time_ < var_290_1 + var_290_2 + arg_290_0 then
				var_290_0.localPosition = Vector3.New(0, -1, -5.75)

				local var_290_7 = manager.ui.mainCamera.transform.position - var_290_0.position

				var_290_0.forward = Vector3.New(var_290_7.x, var_290_7.y, var_290_7.z)

				local var_290_8 = var_290_0.localEulerAngles

				var_290_8.z = 0
				var_290_8.x = 0
				var_290_0.localEulerAngles = var_290_8
			end

			local var_290_9 = arg_287_1.actors_["1056ui_story"]
			local var_290_10 = 0

			if var_290_10 < arg_287_1.time_ and arg_287_1.time_ <= var_290_10 + arg_290_0 and not isNil(var_290_9) and arg_287_1.var_.characterEffect1056ui_story == nil then
				arg_287_1.var_.characterEffect1056ui_story = var_290_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_290_11 = 0.200000002980232

			if var_290_10 <= arg_287_1.time_ and arg_287_1.time_ < var_290_10 + var_290_11 and not isNil(var_290_9) then
				local var_290_12 = (arg_287_1.time_ - var_290_10) / var_290_11

				if arg_287_1.var_.characterEffect1056ui_story and not isNil(var_290_9) then
					arg_287_1.var_.characterEffect1056ui_story.fillFlat = false
				end
			end

			if arg_287_1.time_ >= var_290_10 + var_290_11 and arg_287_1.time_ < var_290_10 + var_290_11 + arg_290_0 and not isNil(var_290_9) and arg_287_1.var_.characterEffect1056ui_story then
				arg_287_1.var_.characterEffect1056ui_story.fillFlat = false
			end

			local var_290_13 = 0

			if var_290_13 < arg_287_1.time_ and arg_287_1.time_ <= var_290_13 + arg_290_0 then
				arg_287_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/story1056/story1056action/1056action6_1")
			end

			local var_290_14 = 0

			if var_290_14 < arg_287_1.time_ and arg_287_1.time_ <= var_290_14 + arg_290_0 then
				arg_287_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_290_15 = 0
			local var_290_16 = 0.825

			if var_290_15 < arg_287_1.time_ and arg_287_1.time_ <= var_290_15 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				local var_290_17 = arg_287_1:FormatText(StoryNameCfg[605].name)

				arg_287_1.leftNameTxt_.text = var_290_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_18 = arg_287_1:GetWordFromCfg(320061070)
				local var_290_19 = arg_287_1:FormatText(var_290_18.content)

				arg_287_1.text_.text = var_290_19

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_20 = 33
				local var_290_21 = utf8.len(var_290_19)
				local var_290_22 = var_290_20 <= 0 and var_290_16 or var_290_16 * (var_290_21 / var_290_20)

				if var_290_22 > 0 and var_290_16 < var_290_22 then
					arg_287_1.talkMaxDuration = var_290_22

					if var_290_22 + var_290_15 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_22 + var_290_15
					end
				end

				arg_287_1.text_.text = var_290_19
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320061", "320061070", "story_v_out_320061.awb") ~= 0 then
					local var_290_23 = manager.audio:GetVoiceLength("story_v_out_320061", "320061070", "story_v_out_320061.awb") / 1000

					if var_290_23 + var_290_15 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_23 + var_290_15
					end

					if var_290_18.prefab_name ~= "" and arg_287_1.actors_[var_290_18.prefab_name] ~= nil then
						local var_290_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_18.prefab_name].transform, "story_v_out_320061", "320061070", "story_v_out_320061.awb")

						arg_287_1:RecordAudio("320061070", var_290_24)
						arg_287_1:RecordAudio("320061070", var_290_24)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_out_320061", "320061070", "story_v_out_320061.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_out_320061", "320061070", "story_v_out_320061.awb")
				end

				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_25 = math.max(var_290_16, arg_287_1.talkMaxDuration)

			if var_290_15 <= arg_287_1.time_ and arg_287_1.time_ < var_290_15 + var_290_25 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_15) / var_290_25

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_15 + var_290_25 and arg_287_1.time_ < var_290_15 + var_290_25 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_287_1:InitPlayNodeList()
	end,
	Play320061071 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 320061071
		arg_291_1.duration_ = 13.17

		local var_291_0 = {
			zh = 13.166,
			ja = 11.833
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
				arg_291_0:Play320061072(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			local var_294_0 = "XS0102"

			if arg_291_1.bgs_[var_294_0] == nil then
				local var_294_1 = Object.Instantiate(arg_291_1.paintGo_)

				var_294_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_294_0)
				var_294_1.name = var_294_0
				var_294_1.transform.parent = arg_291_1.stage_.transform
				var_294_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_291_1.bgs_[var_294_0] = var_294_1
			end

			local var_294_2 = 1.98333333333333

			if var_294_2 < arg_291_1.time_ and arg_291_1.time_ <= var_294_2 + arg_294_0 then
				local var_294_3 = manager.ui.mainCamera.transform.localPosition
				local var_294_4 = Vector3.New(0, 0, 10) + Vector3.New(var_294_3.x, var_294_3.y, 0)
				local var_294_5 = arg_291_1.bgs_.XS0102

				var_294_5.transform.localPosition = var_294_4
				var_294_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_294_6 = var_294_5:GetComponent("SpriteRenderer")

				if var_294_6 and var_294_6.sprite then
					local var_294_7 = (var_294_5.transform.localPosition - var_294_3).z
					local var_294_8 = manager.ui.mainCameraCom_
					local var_294_9 = 2 * var_294_7 * Mathf.Tan(var_294_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_294_10 = var_294_9 * var_294_8.aspect
					local var_294_11 = var_294_6.sprite.bounds.size.x
					local var_294_12 = var_294_6.sprite.bounds.size.y
					local var_294_13 = var_294_10 / var_294_11
					local var_294_14 = var_294_9 / var_294_12
					local var_294_15 = var_294_14 < var_294_13 and var_294_13 or var_294_14

					var_294_5.transform.localScale = Vector3.New(var_294_15, var_294_15, 0)
				end

				for iter_294_0, iter_294_1 in pairs(arg_291_1.bgs_) do
					if iter_294_0 ~= "XS0102" then
						iter_294_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_294_16 = 4

			if var_294_16 < arg_291_1.time_ and arg_291_1.time_ <= var_294_16 + arg_294_0 then
				arg_291_1.allBtn_.enabled = false
			end

			local var_294_17 = 0.3

			if arg_291_1.time_ >= var_294_16 + var_294_17 and arg_291_1.time_ < var_294_16 + var_294_17 + arg_294_0 then
				arg_291_1.allBtn_.enabled = true
			end

			local var_294_18 = 0

			if var_294_18 < arg_291_1.time_ and arg_291_1.time_ <= var_294_18 + arg_294_0 then
				arg_291_1.mask_.enabled = true
				arg_291_1.mask_.raycastTarget = true

				arg_291_1:SetGaussion(false)
			end

			local var_294_19 = 2

			if var_294_18 <= arg_291_1.time_ and arg_291_1.time_ < var_294_18 + var_294_19 then
				local var_294_20 = (arg_291_1.time_ - var_294_18) / var_294_19
				local var_294_21 = Color.New(0, 0, 0)

				var_294_21.a = Mathf.Lerp(0, 1, var_294_20)
				arg_291_1.mask_.color = var_294_21
			end

			if arg_291_1.time_ >= var_294_18 + var_294_19 and arg_291_1.time_ < var_294_18 + var_294_19 + arg_294_0 then
				local var_294_22 = Color.New(0, 0, 0)

				var_294_22.a = 1
				arg_291_1.mask_.color = var_294_22
			end

			local var_294_23 = 2

			if var_294_23 < arg_291_1.time_ and arg_291_1.time_ <= var_294_23 + arg_294_0 then
				arg_291_1.mask_.enabled = true
				arg_291_1.mask_.raycastTarget = true

				arg_291_1:SetGaussion(false)
			end

			local var_294_24 = 2

			if var_294_23 <= arg_291_1.time_ and arg_291_1.time_ < var_294_23 + var_294_24 then
				local var_294_25 = (arg_291_1.time_ - var_294_23) / var_294_24
				local var_294_26 = Color.New(0, 0, 0)

				var_294_26.a = Mathf.Lerp(1, 0, var_294_25)
				arg_291_1.mask_.color = var_294_26
			end

			if arg_291_1.time_ >= var_294_23 + var_294_24 and arg_291_1.time_ < var_294_23 + var_294_24 + arg_294_0 then
				local var_294_27 = Color.New(0, 0, 0)
				local var_294_28 = 0

				arg_291_1.mask_.enabled = false
				var_294_27.a = var_294_28
				arg_291_1.mask_.color = var_294_27
			end

			local var_294_29 = arg_291_1.actors_["1056ui_story"].transform
			local var_294_30 = 1.96599999815226

			if var_294_30 < arg_291_1.time_ and arg_291_1.time_ <= var_294_30 + arg_294_0 then
				arg_291_1.var_.moveOldPos1056ui_story = var_294_29.localPosition
			end

			local var_294_31 = 0.001

			if var_294_30 <= arg_291_1.time_ and arg_291_1.time_ < var_294_30 + var_294_31 then
				local var_294_32 = (arg_291_1.time_ - var_294_30) / var_294_31
				local var_294_33 = Vector3.New(0, 100, 0)

				var_294_29.localPosition = Vector3.Lerp(arg_291_1.var_.moveOldPos1056ui_story, var_294_33, var_294_32)

				local var_294_34 = manager.ui.mainCamera.transform.position - var_294_29.position

				var_294_29.forward = Vector3.New(var_294_34.x, var_294_34.y, var_294_34.z)

				local var_294_35 = var_294_29.localEulerAngles

				var_294_35.z = 0
				var_294_35.x = 0
				var_294_29.localEulerAngles = var_294_35
			end

			if arg_291_1.time_ >= var_294_30 + var_294_31 and arg_291_1.time_ < var_294_30 + var_294_31 + arg_294_0 then
				var_294_29.localPosition = Vector3.New(0, 100, 0)

				local var_294_36 = manager.ui.mainCamera.transform.position - var_294_29.position

				var_294_29.forward = Vector3.New(var_294_36.x, var_294_36.y, var_294_36.z)

				local var_294_37 = var_294_29.localEulerAngles

				var_294_37.z = 0
				var_294_37.x = 0
				var_294_29.localEulerAngles = var_294_37
			end

			local var_294_38 = arg_291_1.actors_["1056ui_story"]
			local var_294_39 = 1.96599999815226

			if var_294_39 < arg_291_1.time_ and arg_291_1.time_ <= var_294_39 + arg_294_0 and not isNil(var_294_38) and arg_291_1.var_.characterEffect1056ui_story == nil then
				arg_291_1.var_.characterEffect1056ui_story = var_294_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_294_40 = 0.034000001847744

			if var_294_39 <= arg_291_1.time_ and arg_291_1.time_ < var_294_39 + var_294_40 and not isNil(var_294_38) then
				local var_294_41 = (arg_291_1.time_ - var_294_39) / var_294_40

				if arg_291_1.var_.characterEffect1056ui_story and not isNil(var_294_38) then
					local var_294_42 = Mathf.Lerp(0, 0.5, var_294_41)

					arg_291_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_291_1.var_.characterEffect1056ui_story.fillRatio = var_294_42
				end
			end

			if arg_291_1.time_ >= var_294_39 + var_294_40 and arg_291_1.time_ < var_294_39 + var_294_40 + arg_294_0 and not isNil(var_294_38) and arg_291_1.var_.characterEffect1056ui_story then
				local var_294_43 = 0.5

				arg_291_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_291_1.var_.characterEffect1056ui_story.fillRatio = var_294_43
			end

			local var_294_44 = arg_291_1.bgs_.XS0102.transform
			local var_294_45 = 2

			if var_294_45 < arg_291_1.time_ and arg_291_1.time_ <= var_294_45 + arg_294_0 then
				arg_291_1.var_.moveOldPosXS0102 = var_294_44.localPosition
			end

			local var_294_46 = 0.001

			if var_294_45 <= arg_291_1.time_ and arg_291_1.time_ < var_294_45 + var_294_46 then
				local var_294_47 = (arg_291_1.time_ - var_294_45) / var_294_46
				local var_294_48 = Vector3.New(3, 0.5, 4)

				var_294_44.localPosition = Vector3.Lerp(arg_291_1.var_.moveOldPosXS0102, var_294_48, var_294_47)
			end

			if arg_291_1.time_ >= var_294_45 + var_294_46 and arg_291_1.time_ < var_294_45 + var_294_46 + arg_294_0 then
				var_294_44.localPosition = Vector3.New(3, 0.5, 4)
			end

			local var_294_49 = arg_291_1.bgs_.XS0102.transform
			local var_294_50 = 2.03400000184774

			if var_294_50 < arg_291_1.time_ and arg_291_1.time_ <= var_294_50 + arg_294_0 then
				arg_291_1.var_.moveOldPosXS0102 = var_294_49.localPosition
			end

			local var_294_51 = 5.8

			if var_294_50 <= arg_291_1.time_ and arg_291_1.time_ < var_294_50 + var_294_51 then
				local var_294_52 = (arg_291_1.time_ - var_294_50) / var_294_51
				local var_294_53 = Vector3.New(3, 0, 4)

				var_294_49.localPosition = Vector3.Lerp(arg_291_1.var_.moveOldPosXS0102, var_294_53, var_294_52)
			end

			if arg_291_1.time_ >= var_294_50 + var_294_51 and arg_291_1.time_ < var_294_50 + var_294_51 + arg_294_0 then
				var_294_49.localPosition = Vector3.New(3, 0, 4)
			end

			local var_294_54 = 4

			if var_294_54 < arg_291_1.time_ and arg_291_1.time_ <= var_294_54 + arg_294_0 then
				arg_291_1.allBtn_.enabled = false
			end

			local var_294_55 = 3.8

			if arg_291_1.time_ >= var_294_54 + var_294_55 and arg_291_1.time_ < var_294_54 + var_294_55 + arg_294_0 then
				arg_291_1.allBtn_.enabled = true
			end

			if arg_291_1.frameCnt_ <= 1 then
				arg_291_1.dialog_:SetActive(false)
			end

			local var_294_56 = 4
			local var_294_57 = 0.875

			if var_294_56 < arg_291_1.time_ and arg_291_1.time_ <= var_294_56 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0

				arg_291_1.dialog_:SetActive(true)

				arg_291_1.dialogCg_.alpha = 0

				local var_294_58 = LeanTween.value(arg_291_1.dialog_, 0, 1, 0.3)

				var_294_58:setOnUpdate(LuaHelper.FloatAction(function(arg_295_0)
					arg_291_1.dialogCg_.alpha = arg_295_0
				end))
				var_294_58:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_291_1.dialog_)
					var_294_58:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_291_1.duration_ = arg_291_1.duration_ + 0.3

				SetActive(arg_291_1.leftNameGo_, true)

				local var_294_59 = arg_291_1:FormatText(StoryNameCfg[37].name)

				arg_291_1.leftNameTxt_.text = var_294_59

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_60 = arg_291_1:GetWordFromCfg(320061071)
				local var_294_61 = arg_291_1:FormatText(var_294_60.content)

				arg_291_1.text_.text = var_294_61

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_62 = 35
				local var_294_63 = utf8.len(var_294_61)
				local var_294_64 = var_294_62 <= 0 and var_294_57 or var_294_57 * (var_294_63 / var_294_62)

				if var_294_64 > 0 and var_294_57 < var_294_64 then
					arg_291_1.talkMaxDuration = var_294_64
					var_294_56 = var_294_56 + 0.3

					if var_294_64 + var_294_56 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_64 + var_294_56
					end
				end

				arg_291_1.text_.text = var_294_61
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320061", "320061071", "story_v_out_320061.awb") ~= 0 then
					local var_294_65 = manager.audio:GetVoiceLength("story_v_out_320061", "320061071", "story_v_out_320061.awb") / 1000

					if var_294_65 + var_294_56 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_65 + var_294_56
					end

					if var_294_60.prefab_name ~= "" and arg_291_1.actors_[var_294_60.prefab_name] ~= nil then
						local var_294_66 = LuaForUtil.PlayVoiceWithCriLipsync(arg_291_1.actors_[var_294_60.prefab_name].transform, "story_v_out_320061", "320061071", "story_v_out_320061.awb")

						arg_291_1:RecordAudio("320061071", var_294_66)
						arg_291_1:RecordAudio("320061071", var_294_66)
					else
						arg_291_1:AudioAction("play", "voice", "story_v_out_320061", "320061071", "story_v_out_320061.awb")
					end

					arg_291_1:RecordHistoryTalkVoice("story_v_out_320061", "320061071", "story_v_out_320061.awb")
				end

				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_67 = var_294_56 + 0.3
			local var_294_68 = math.max(var_294_57, arg_291_1.talkMaxDuration)

			if var_294_67 <= arg_291_1.time_ and arg_291_1.time_ < var_294_67 + var_294_68 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_67) / var_294_68

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_67 + var_294_68 and arg_291_1.time_ < var_294_67 + var_294_68 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "XS0102",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "XS0102",
				changeDisplayLayer = false,
				needEase = false,
				duration = 5.8,
				className = "StoryMoveNode",
				startTime = 2.03400000184774,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_291_1:InitPlayNodeList()
	end,
	Play320061072 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 320061072
		arg_297_1.duration_ = 6.67

		local var_297_0 = {
			zh = 6.133,
			ja = 6.666
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
				arg_297_0:Play320061073(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = 0
			local var_300_1 = 0.6

			if var_300_0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_0 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				local var_300_2 = arg_297_1:FormatText(StoryNameCfg[37].name)

				arg_297_1.leftNameTxt_.text = var_300_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_3 = arg_297_1:GetWordFromCfg(320061072)
				local var_300_4 = arg_297_1:FormatText(var_300_3.content)

				arg_297_1.text_.text = var_300_4

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_5 = 24
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

				if manager.audio:GetVoiceLength("story_v_out_320061", "320061072", "story_v_out_320061.awb") ~= 0 then
					local var_300_8 = manager.audio:GetVoiceLength("story_v_out_320061", "320061072", "story_v_out_320061.awb") / 1000

					if var_300_8 + var_300_0 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_8 + var_300_0
					end

					if var_300_3.prefab_name ~= "" and arg_297_1.actors_[var_300_3.prefab_name] ~= nil then
						local var_300_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_3.prefab_name].transform, "story_v_out_320061", "320061072", "story_v_out_320061.awb")

						arg_297_1:RecordAudio("320061072", var_300_9)
						arg_297_1:RecordAudio("320061072", var_300_9)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_out_320061", "320061072", "story_v_out_320061.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_out_320061", "320061072", "story_v_out_320061.awb")
				end

				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_10 = math.max(var_300_1, arg_297_1.talkMaxDuration)

			if var_300_0 <= arg_297_1.time_ and arg_297_1.time_ < var_300_0 + var_300_10 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_0) / var_300_10

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_0 + var_300_10 and arg_297_1.time_ < var_300_0 + var_300_10 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play320061073 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 320061073
		arg_301_1.duration_ = 11

		local var_301_0 = {
			zh = 11,
			ja = 10.333
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
				arg_301_0:Play320061074(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = 0
			local var_304_1 = 1.05

			if var_304_0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_0 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				local var_304_2 = arg_301_1:FormatText(StoryNameCfg[37].name)

				arg_301_1.leftNameTxt_.text = var_304_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_3 = arg_301_1:GetWordFromCfg(320061073)
				local var_304_4 = arg_301_1:FormatText(var_304_3.content)

				arg_301_1.text_.text = var_304_4

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_5 = 42
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

				if manager.audio:GetVoiceLength("story_v_out_320061", "320061073", "story_v_out_320061.awb") ~= 0 then
					local var_304_8 = manager.audio:GetVoiceLength("story_v_out_320061", "320061073", "story_v_out_320061.awb") / 1000

					if var_304_8 + var_304_0 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_8 + var_304_0
					end

					if var_304_3.prefab_name ~= "" and arg_301_1.actors_[var_304_3.prefab_name] ~= nil then
						local var_304_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_3.prefab_name].transform, "story_v_out_320061", "320061073", "story_v_out_320061.awb")

						arg_301_1:RecordAudio("320061073", var_304_9)
						arg_301_1:RecordAudio("320061073", var_304_9)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_out_320061", "320061073", "story_v_out_320061.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_out_320061", "320061073", "story_v_out_320061.awb")
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
	Play320061074 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 320061074
		arg_305_1.duration_ = 9.8

		local var_305_0 = {
			zh = 9.8,
			ja = 9.466
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
				arg_305_0:Play320061075(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = 0
			local var_308_1 = 0.675

			if var_308_0 < arg_305_1.time_ and arg_305_1.time_ <= var_308_0 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				local var_308_2 = arg_305_1:FormatText(StoryNameCfg[37].name)

				arg_305_1.leftNameTxt_.text = var_308_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_3 = arg_305_1:GetWordFromCfg(320061074)
				local var_308_4 = arg_305_1:FormatText(var_308_3.content)

				arg_305_1.text_.text = var_308_4

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_5 = 27
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

				if manager.audio:GetVoiceLength("story_v_out_320061", "320061074", "story_v_out_320061.awb") ~= 0 then
					local var_308_8 = manager.audio:GetVoiceLength("story_v_out_320061", "320061074", "story_v_out_320061.awb") / 1000

					if var_308_8 + var_308_0 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_8 + var_308_0
					end

					if var_308_3.prefab_name ~= "" and arg_305_1.actors_[var_308_3.prefab_name] ~= nil then
						local var_308_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_305_1.actors_[var_308_3.prefab_name].transform, "story_v_out_320061", "320061074", "story_v_out_320061.awb")

						arg_305_1:RecordAudio("320061074", var_308_9)
						arg_305_1:RecordAudio("320061074", var_308_9)
					else
						arg_305_1:AudioAction("play", "voice", "story_v_out_320061", "320061074", "story_v_out_320061.awb")
					end

					arg_305_1:RecordHistoryTalkVoice("story_v_out_320061", "320061074", "story_v_out_320061.awb")
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
	Play320061075 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 320061075
		arg_309_1.duration_ = 9.53

		local var_309_0 = {
			zh = 5.933,
			ja = 9.533
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
				arg_309_0:Play320061076(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = 0
			local var_312_1 = 0.35

			if var_312_0 < arg_309_1.time_ and arg_309_1.time_ <= var_312_0 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				local var_312_2 = arg_309_1:FormatText(StoryNameCfg[37].name)

				arg_309_1.leftNameTxt_.text = var_312_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_3 = arg_309_1:GetWordFromCfg(320061075)
				local var_312_4 = arg_309_1:FormatText(var_312_3.content)

				arg_309_1.text_.text = var_312_4

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_5 = 14
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

				if manager.audio:GetVoiceLength("story_v_out_320061", "320061075", "story_v_out_320061.awb") ~= 0 then
					local var_312_8 = manager.audio:GetVoiceLength("story_v_out_320061", "320061075", "story_v_out_320061.awb") / 1000

					if var_312_8 + var_312_0 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_8 + var_312_0
					end

					if var_312_3.prefab_name ~= "" and arg_309_1.actors_[var_312_3.prefab_name] ~= nil then
						local var_312_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_309_1.actors_[var_312_3.prefab_name].transform, "story_v_out_320061", "320061075", "story_v_out_320061.awb")

						arg_309_1:RecordAudio("320061075", var_312_9)
						arg_309_1:RecordAudio("320061075", var_312_9)
					else
						arg_309_1:AudioAction("play", "voice", "story_v_out_320061", "320061075", "story_v_out_320061.awb")
					end

					arg_309_1:RecordHistoryTalkVoice("story_v_out_320061", "320061075", "story_v_out_320061.awb")
				end

				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_10 = math.max(var_312_1, arg_309_1.talkMaxDuration)

			if var_312_0 <= arg_309_1.time_ and arg_309_1.time_ < var_312_0 + var_312_10 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_0) / var_312_10

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_0 + var_312_10 and arg_309_1.time_ < var_312_0 + var_312_10 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play320061076 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 320061076
		arg_313_1.duration_ = 5.2

		local var_313_0 = {
			zh = 3,
			ja = 5.2
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
				arg_313_0:Play320061077(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			local var_316_0 = 0
			local var_316_1 = 0.275

			if var_316_0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_0 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				local var_316_2 = arg_313_1:FormatText(StoryNameCfg[606].name)

				arg_313_1.leftNameTxt_.text = var_316_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_3 = arg_313_1:GetWordFromCfg(320061076)
				local var_316_4 = arg_313_1:FormatText(var_316_3.content)

				arg_313_1.text_.text = var_316_4

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_5 = 11
				local var_316_6 = utf8.len(var_316_4)
				local var_316_7 = var_316_5 <= 0 and var_316_1 or var_316_1 * (var_316_6 / var_316_5)

				if var_316_7 > 0 and var_316_1 < var_316_7 then
					arg_313_1.talkMaxDuration = var_316_7

					if var_316_7 + var_316_0 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_7 + var_316_0
					end
				end

				arg_313_1.text_.text = var_316_4
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320061", "320061076", "story_v_out_320061.awb") ~= 0 then
					local var_316_8 = manager.audio:GetVoiceLength("story_v_out_320061", "320061076", "story_v_out_320061.awb") / 1000

					if var_316_8 + var_316_0 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_8 + var_316_0
					end

					if var_316_3.prefab_name ~= "" and arg_313_1.actors_[var_316_3.prefab_name] ~= nil then
						local var_316_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_3.prefab_name].transform, "story_v_out_320061", "320061076", "story_v_out_320061.awb")

						arg_313_1:RecordAudio("320061076", var_316_9)
						arg_313_1:RecordAudio("320061076", var_316_9)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_out_320061", "320061076", "story_v_out_320061.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_out_320061", "320061076", "story_v_out_320061.awb")
				end

				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_10 = math.max(var_316_1, arg_313_1.talkMaxDuration)

			if var_316_0 <= arg_313_1.time_ and arg_313_1.time_ < var_316_0 + var_316_10 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_0) / var_316_10

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_0 + var_316_10 and arg_313_1.time_ < var_316_0 + var_316_10 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play320061077 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 320061077
		arg_317_1.duration_ = 13.47

		local var_317_0 = {
			zh = 9.7,
			ja = 13.466
		}
		local var_317_1 = manager.audio:GetLocalizationFlag()

		if var_317_0[var_317_1] ~= nil then
			arg_317_1.duration_ = var_317_0[var_317_1]
		end

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play320061078(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = 0
			local var_320_1 = 0.725

			if var_320_0 < arg_317_1.time_ and arg_317_1.time_ <= var_320_0 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				local var_320_2 = arg_317_1:FormatText(StoryNameCfg[37].name)

				arg_317_1.leftNameTxt_.text = var_320_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_3 = arg_317_1:GetWordFromCfg(320061077)
				local var_320_4 = arg_317_1:FormatText(var_320_3.content)

				arg_317_1.text_.text = var_320_4

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_5 = 29
				local var_320_6 = utf8.len(var_320_4)
				local var_320_7 = var_320_5 <= 0 and var_320_1 or var_320_1 * (var_320_6 / var_320_5)

				if var_320_7 > 0 and var_320_1 < var_320_7 then
					arg_317_1.talkMaxDuration = var_320_7

					if var_320_7 + var_320_0 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_7 + var_320_0
					end
				end

				arg_317_1.text_.text = var_320_4
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320061", "320061077", "story_v_out_320061.awb") ~= 0 then
					local var_320_8 = manager.audio:GetVoiceLength("story_v_out_320061", "320061077", "story_v_out_320061.awb") / 1000

					if var_320_8 + var_320_0 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_8 + var_320_0
					end

					if var_320_3.prefab_name ~= "" and arg_317_1.actors_[var_320_3.prefab_name] ~= nil then
						local var_320_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_317_1.actors_[var_320_3.prefab_name].transform, "story_v_out_320061", "320061077", "story_v_out_320061.awb")

						arg_317_1:RecordAudio("320061077", var_320_9)
						arg_317_1:RecordAudio("320061077", var_320_9)
					else
						arg_317_1:AudioAction("play", "voice", "story_v_out_320061", "320061077", "story_v_out_320061.awb")
					end

					arg_317_1:RecordHistoryTalkVoice("story_v_out_320061", "320061077", "story_v_out_320061.awb")
				end

				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_10 = math.max(var_320_1, arg_317_1.talkMaxDuration)

			if var_320_0 <= arg_317_1.time_ and arg_317_1.time_ < var_320_0 + var_320_10 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_0) / var_320_10

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_0 + var_320_10 and arg_317_1.time_ < var_320_0 + var_320_10 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {}

		arg_317_1:InitPlayNodeList()
	end,
	Play320061078 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 320061078
		arg_321_1.duration_ = 5.03

		local var_321_0 = {
			zh = 5.033,
			ja = 3.2
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
				arg_321_0:Play320061079(arg_321_1)
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

				local var_324_2 = arg_321_1:FormatText(StoryNameCfg[606].name)

				arg_321_1.leftNameTxt_.text = var_324_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_3 = arg_321_1:GetWordFromCfg(320061078)
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

				if manager.audio:GetVoiceLength("story_v_out_320061", "320061078", "story_v_out_320061.awb") ~= 0 then
					local var_324_8 = manager.audio:GetVoiceLength("story_v_out_320061", "320061078", "story_v_out_320061.awb") / 1000

					if var_324_8 + var_324_0 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_8 + var_324_0
					end

					if var_324_3.prefab_name ~= "" and arg_321_1.actors_[var_324_3.prefab_name] ~= nil then
						local var_324_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_3.prefab_name].transform, "story_v_out_320061", "320061078", "story_v_out_320061.awb")

						arg_321_1:RecordAudio("320061078", var_324_9)
						arg_321_1:RecordAudio("320061078", var_324_9)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_out_320061", "320061078", "story_v_out_320061.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_out_320061", "320061078", "story_v_out_320061.awb")
				end

				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_10 = math.max(var_324_1, arg_321_1.talkMaxDuration)

			if var_324_0 <= arg_321_1.time_ and arg_321_1.time_ < var_324_0 + var_324_10 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_0) / var_324_10

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_0 + var_324_10 and arg_321_1.time_ < var_324_0 + var_324_10 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play320061079 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 320061079
		arg_325_1.duration_ = 8.02

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play320061080(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			local var_328_0 = 1.98333333333333

			if var_328_0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_0 + arg_328_0 then
				local var_328_1 = manager.ui.mainCamera.transform.localPosition
				local var_328_2 = Vector3.New(0, 0, 10) + Vector3.New(var_328_1.x, var_328_1.y, 0)
				local var_328_3 = arg_325_1.bgs_.XS0102

				var_328_3.transform.localPosition = var_328_2
				var_328_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_328_4 = var_328_3:GetComponent("SpriteRenderer")

				if var_328_4 and var_328_4.sprite then
					local var_328_5 = (var_328_3.transform.localPosition - var_328_1).z
					local var_328_6 = manager.ui.mainCameraCom_
					local var_328_7 = 2 * var_328_5 * Mathf.Tan(var_328_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_328_8 = var_328_7 * var_328_6.aspect
					local var_328_9 = var_328_4.sprite.bounds.size.x
					local var_328_10 = var_328_4.sprite.bounds.size.y
					local var_328_11 = var_328_8 / var_328_9
					local var_328_12 = var_328_7 / var_328_10
					local var_328_13 = var_328_12 < var_328_11 and var_328_11 or var_328_12

					var_328_3.transform.localScale = Vector3.New(var_328_13, var_328_13, 0)
				end

				for iter_328_0, iter_328_1 in pairs(arg_325_1.bgs_) do
					if iter_328_0 ~= "XS0102" then
						iter_328_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_328_14 = 4

			if var_328_14 < arg_325_1.time_ and arg_325_1.time_ <= var_328_14 + arg_328_0 then
				arg_325_1.allBtn_.enabled = false
			end

			local var_328_15 = 0.3

			if arg_325_1.time_ >= var_328_14 + var_328_15 and arg_325_1.time_ < var_328_14 + var_328_15 + arg_328_0 then
				arg_325_1.allBtn_.enabled = true
			end

			local var_328_16 = 0

			if var_328_16 < arg_325_1.time_ and arg_325_1.time_ <= var_328_16 + arg_328_0 then
				arg_325_1.mask_.enabled = true
				arg_325_1.mask_.raycastTarget = true

				arg_325_1:SetGaussion(false)
			end

			local var_328_17 = 2

			if var_328_16 <= arg_325_1.time_ and arg_325_1.time_ < var_328_16 + var_328_17 then
				local var_328_18 = (arg_325_1.time_ - var_328_16) / var_328_17
				local var_328_19 = Color.New(0, 0, 0)

				var_328_19.a = Mathf.Lerp(0, 1, var_328_18)
				arg_325_1.mask_.color = var_328_19
			end

			if arg_325_1.time_ >= var_328_16 + var_328_17 and arg_325_1.time_ < var_328_16 + var_328_17 + arg_328_0 then
				local var_328_20 = Color.New(0, 0, 0)

				var_328_20.a = 1
				arg_325_1.mask_.color = var_328_20
			end

			local var_328_21 = 2

			if var_328_21 < arg_325_1.time_ and arg_325_1.time_ <= var_328_21 + arg_328_0 then
				arg_325_1.mask_.enabled = true
				arg_325_1.mask_.raycastTarget = true

				arg_325_1:SetGaussion(false)
			end

			local var_328_22 = 2

			if var_328_21 <= arg_325_1.time_ and arg_325_1.time_ < var_328_21 + var_328_22 then
				local var_328_23 = (arg_325_1.time_ - var_328_21) / var_328_22
				local var_328_24 = Color.New(0, 0, 0)

				var_328_24.a = Mathf.Lerp(1, 0, var_328_23)
				arg_325_1.mask_.color = var_328_24
			end

			if arg_325_1.time_ >= var_328_21 + var_328_22 and arg_325_1.time_ < var_328_21 + var_328_22 + arg_328_0 then
				local var_328_25 = Color.New(0, 0, 0)
				local var_328_26 = 0

				arg_325_1.mask_.enabled = false
				var_328_25.a = var_328_26
				arg_325_1.mask_.color = var_328_25
			end

			local var_328_27 = arg_325_1.bgs_.XS0102.transform
			local var_328_28 = 2

			if var_328_28 < arg_325_1.time_ and arg_325_1.time_ <= var_328_28 + arg_328_0 then
				arg_325_1.var_.moveOldPosXS0102 = var_328_27.localPosition
			end

			local var_328_29 = 0.001

			if var_328_28 <= arg_325_1.time_ and arg_325_1.time_ < var_328_28 + var_328_29 then
				local var_328_30 = (arg_325_1.time_ - var_328_28) / var_328_29
				local var_328_31 = Vector3.New(-1, 0.5, 7)

				var_328_27.localPosition = Vector3.Lerp(arg_325_1.var_.moveOldPosXS0102, var_328_31, var_328_30)
			end

			if arg_325_1.time_ >= var_328_28 + var_328_29 and arg_325_1.time_ < var_328_28 + var_328_29 + arg_328_0 then
				var_328_27.localPosition = Vector3.New(-1, 0.5, 7)
			end

			local var_328_32 = arg_325_1.bgs_.XS0102.transform
			local var_328_33 = 2.01666666666667

			if var_328_33 < arg_325_1.time_ and arg_325_1.time_ <= var_328_33 + arg_328_0 then
				arg_325_1.var_.moveOldPosXS0102 = var_328_32.localPosition
			end

			local var_328_34 = 6

			if var_328_33 <= arg_325_1.time_ and arg_325_1.time_ < var_328_33 + var_328_34 then
				local var_328_35 = (arg_325_1.time_ - var_328_33) / var_328_34
				local var_328_36 = Vector3.New(-1.4, 0.5, 7)

				var_328_32.localPosition = Vector3.Lerp(arg_325_1.var_.moveOldPosXS0102, var_328_36, var_328_35)
			end

			if arg_325_1.time_ >= var_328_33 + var_328_34 and arg_325_1.time_ < var_328_33 + var_328_34 + arg_328_0 then
				var_328_32.localPosition = Vector3.New(-1.4, 0.5, 7)
			end

			local var_328_37 = 4.26666666666667

			if var_328_37 < arg_325_1.time_ and arg_325_1.time_ <= var_328_37 + arg_328_0 then
				arg_325_1.allBtn_.enabled = false
			end

			local var_328_38 = 3.75

			if arg_325_1.time_ >= var_328_37 + var_328_38 and arg_325_1.time_ < var_328_37 + var_328_38 + arg_328_0 then
				arg_325_1.allBtn_.enabled = true
			end

			if arg_325_1.frameCnt_ <= 1 then
				arg_325_1.dialog_:SetActive(false)
			end

			local var_328_39 = 4
			local var_328_40 = 0.325

			if var_328_39 < arg_325_1.time_ and arg_325_1.time_ <= var_328_39 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0

				arg_325_1.dialog_:SetActive(true)

				arg_325_1.dialogCg_.alpha = 0

				local var_328_41 = LeanTween.value(arg_325_1.dialog_, 0, 1, 0.3)

				var_328_41:setOnUpdate(LuaHelper.FloatAction(function(arg_329_0)
					arg_325_1.dialogCg_.alpha = arg_329_0
				end))
				var_328_41:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_325_1.dialog_)
					var_328_41:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_325_1.duration_ = arg_325_1.duration_ + 0.3

				SetActive(arg_325_1.leftNameGo_, true)

				local var_328_42 = arg_325_1:FormatText(StoryNameCfg[6].name)

				arg_325_1.leftNameTxt_.text = var_328_42

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_43 = arg_325_1:GetWordFromCfg(320061079)
				local var_328_44 = arg_325_1:FormatText(var_328_43.content)

				arg_325_1.text_.text = var_328_44

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_45 = 13
				local var_328_46 = utf8.len(var_328_44)
				local var_328_47 = var_328_45 <= 0 and var_328_40 or var_328_40 * (var_328_46 / var_328_45)

				if var_328_47 > 0 and var_328_40 < var_328_47 then
					arg_325_1.talkMaxDuration = var_328_47
					var_328_39 = var_328_39 + 0.3

					if var_328_47 + var_328_39 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_47 + var_328_39
					end
				end

				arg_325_1.text_.text = var_328_44
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320061", "320061079", "story_v_out_320061.awb") ~= 0 then
					local var_328_48 = manager.audio:GetVoiceLength("story_v_out_320061", "320061079", "story_v_out_320061.awb") / 1000

					if var_328_48 + var_328_39 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_48 + var_328_39
					end

					if var_328_43.prefab_name ~= "" and arg_325_1.actors_[var_328_43.prefab_name] ~= nil then
						local var_328_49 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_43.prefab_name].transform, "story_v_out_320061", "320061079", "story_v_out_320061.awb")

						arg_325_1:RecordAudio("320061079", var_328_49)
						arg_325_1:RecordAudio("320061079", var_328_49)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_out_320061", "320061079", "story_v_out_320061.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_out_320061", "320061079", "story_v_out_320061.awb")
				end

				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_50 = var_328_39 + 0.3
			local var_328_51 = math.max(var_328_40, arg_325_1.talkMaxDuration)

			if var_328_50 <= arg_325_1.time_ and arg_325_1.time_ < var_328_50 + var_328_51 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_50) / var_328_51

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_50 + var_328_51 and arg_325_1.time_ < var_328_50 + var_328_51 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "XS0102",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "XS0102",
				changeDisplayLayer = false,
				needEase = false,
				duration = 6,
				className = "StoryMoveNode",
				startTime = 2.01666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_325_1:InitPlayNodeList()
	end,
	Play320061080 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 320061080
		arg_331_1.duration_ = 5

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play320061081(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			local var_334_0 = 0
			local var_334_1 = 1.5

			if var_334_0 < arg_331_1.time_ and arg_331_1.time_ <= var_334_0 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, false)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_2 = arg_331_1:GetWordFromCfg(320061080)
				local var_334_3 = arg_331_1:FormatText(var_334_2.content)

				arg_331_1.text_.text = var_334_3

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_4 = 60
				local var_334_5 = utf8.len(var_334_3)
				local var_334_6 = var_334_4 <= 0 and var_334_1 or var_334_1 * (var_334_5 / var_334_4)

				if var_334_6 > 0 and var_334_1 < var_334_6 then
					arg_331_1.talkMaxDuration = var_334_6

					if var_334_6 + var_334_0 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_6 + var_334_0
					end
				end

				arg_331_1.text_.text = var_334_3
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)
				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_7 = math.max(var_334_1, arg_331_1.talkMaxDuration)

			if var_334_0 <= arg_331_1.time_ and arg_331_1.time_ < var_334_0 + var_334_7 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_0) / var_334_7

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_0 + var_334_7 and arg_331_1.time_ < var_334_0 + var_334_7 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {}

		arg_331_1:InitPlayNodeList()
	end,
	Play320061081 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 320061081
		arg_335_1.duration_ = 3.97

		local var_335_0 = {
			zh = 3.8,
			ja = 3.966
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
				arg_335_0:Play320061082(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			local var_338_0 = 0
			local var_338_1 = 0.375

			if var_338_0 < arg_335_1.time_ and arg_335_1.time_ <= var_338_0 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				local var_338_2 = arg_335_1:FormatText(StoryNameCfg[605].name)

				arg_335_1.leftNameTxt_.text = var_338_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, false)
				arg_335_1.callingController_:SetSelectedState("normal")

				local var_338_3 = arg_335_1:GetWordFromCfg(320061081)
				local var_338_4 = arg_335_1:FormatText(var_338_3.content)

				arg_335_1.text_.text = var_338_4

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_5 = 15
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

				if manager.audio:GetVoiceLength("story_v_out_320061", "320061081", "story_v_out_320061.awb") ~= 0 then
					local var_338_8 = manager.audio:GetVoiceLength("story_v_out_320061", "320061081", "story_v_out_320061.awb") / 1000

					if var_338_8 + var_338_0 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_8 + var_338_0
					end

					if var_338_3.prefab_name ~= "" and arg_335_1.actors_[var_338_3.prefab_name] ~= nil then
						local var_338_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_335_1.actors_[var_338_3.prefab_name].transform, "story_v_out_320061", "320061081", "story_v_out_320061.awb")

						arg_335_1:RecordAudio("320061081", var_338_9)
						arg_335_1:RecordAudio("320061081", var_338_9)
					else
						arg_335_1:AudioAction("play", "voice", "story_v_out_320061", "320061081", "story_v_out_320061.awb")
					end

					arg_335_1:RecordHistoryTalkVoice("story_v_out_320061", "320061081", "story_v_out_320061.awb")
				end

				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_10 = math.max(var_338_1, arg_335_1.talkMaxDuration)

			if var_338_0 <= arg_335_1.time_ and arg_335_1.time_ < var_338_0 + var_338_10 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - var_338_0) / var_338_10

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= var_338_0 + var_338_10 and arg_335_1.time_ < var_338_0 + var_338_10 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {}

		arg_335_1:InitPlayNodeList()
	end,
	Play320061082 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 320061082
		arg_339_1.duration_ = 6.2

		local var_339_0 = {
			zh = 5.666,
			ja = 6.2
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
				arg_339_0:Play320061083(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			local var_342_0 = 0
			local var_342_1 = 0.7

			if var_342_0 < arg_339_1.time_ and arg_339_1.time_ <= var_342_0 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				local var_342_2 = arg_339_1:FormatText(StoryNameCfg[6].name)

				arg_339_1.leftNameTxt_.text = var_342_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, false)
				arg_339_1.callingController_:SetSelectedState("normal")

				local var_342_3 = arg_339_1:GetWordFromCfg(320061082)
				local var_342_4 = arg_339_1:FormatText(var_342_3.content)

				arg_339_1.text_.text = var_342_4

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_5 = 28
				local var_342_6 = utf8.len(var_342_4)
				local var_342_7 = var_342_5 <= 0 and var_342_1 or var_342_1 * (var_342_6 / var_342_5)

				if var_342_7 > 0 and var_342_1 < var_342_7 then
					arg_339_1.talkMaxDuration = var_342_7

					if var_342_7 + var_342_0 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_7 + var_342_0
					end
				end

				arg_339_1.text_.text = var_342_4
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320061", "320061082", "story_v_out_320061.awb") ~= 0 then
					local var_342_8 = manager.audio:GetVoiceLength("story_v_out_320061", "320061082", "story_v_out_320061.awb") / 1000

					if var_342_8 + var_342_0 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_8 + var_342_0
					end

					if var_342_3.prefab_name ~= "" and arg_339_1.actors_[var_342_3.prefab_name] ~= nil then
						local var_342_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_339_1.actors_[var_342_3.prefab_name].transform, "story_v_out_320061", "320061082", "story_v_out_320061.awb")

						arg_339_1:RecordAudio("320061082", var_342_9)
						arg_339_1:RecordAudio("320061082", var_342_9)
					else
						arg_339_1:AudioAction("play", "voice", "story_v_out_320061", "320061082", "story_v_out_320061.awb")
					end

					arg_339_1:RecordHistoryTalkVoice("story_v_out_320061", "320061082", "story_v_out_320061.awb")
				end

				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_10 = math.max(var_342_1, arg_339_1.talkMaxDuration)

			if var_342_0 <= arg_339_1.time_ and arg_339_1.time_ < var_342_0 + var_342_10 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_0) / var_342_10

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_0 + var_342_10 and arg_339_1.time_ < var_342_0 + var_342_10 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {}

		arg_339_1:InitPlayNodeList()
	end,
	Play320061083 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 320061083
		arg_343_1.duration_ = 7.5

		local var_343_0 = {
			zh = 6.066,
			ja = 7.5
		}
		local var_343_1 = manager.audio:GetLocalizationFlag()

		if var_343_0[var_343_1] ~= nil then
			arg_343_1.duration_ = var_343_0[var_343_1]
		end

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play320061084(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			local var_346_0 = 0
			local var_346_1 = 0.675

			if var_346_0 < arg_343_1.time_ and arg_343_1.time_ <= var_346_0 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, true)

				local var_346_2 = arg_343_1:FormatText(StoryNameCfg[37].name)

				arg_343_1.leftNameTxt_.text = var_346_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_343_1.leftNameTxt_.transform)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1.leftNameTxt_.text)
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_3 = arg_343_1:GetWordFromCfg(320061083)
				local var_346_4 = arg_343_1:FormatText(var_346_3.content)

				arg_343_1.text_.text = var_346_4

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_5 = 27
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

				if manager.audio:GetVoiceLength("story_v_out_320061", "320061083", "story_v_out_320061.awb") ~= 0 then
					local var_346_8 = manager.audio:GetVoiceLength("story_v_out_320061", "320061083", "story_v_out_320061.awb") / 1000

					if var_346_8 + var_346_0 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_8 + var_346_0
					end

					if var_346_3.prefab_name ~= "" and arg_343_1.actors_[var_346_3.prefab_name] ~= nil then
						local var_346_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_343_1.actors_[var_346_3.prefab_name].transform, "story_v_out_320061", "320061083", "story_v_out_320061.awb")

						arg_343_1:RecordAudio("320061083", var_346_9)
						arg_343_1:RecordAudio("320061083", var_346_9)
					else
						arg_343_1:AudioAction("play", "voice", "story_v_out_320061", "320061083", "story_v_out_320061.awb")
					end

					arg_343_1:RecordHistoryTalkVoice("story_v_out_320061", "320061083", "story_v_out_320061.awb")
				end

				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_10 = math.max(var_346_1, arg_343_1.talkMaxDuration)

			if var_346_0 <= arg_343_1.time_ and arg_343_1.time_ < var_346_0 + var_346_10 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_0) / var_346_10

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_0 + var_346_10 and arg_343_1.time_ < var_346_0 + var_346_10 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {}

		arg_343_1:InitPlayNodeList()
	end,
	Play320061084 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 320061084
		arg_347_1.duration_ = 7.07

		local var_347_0 = {
			zh = 7.066,
			ja = 5.566
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
				arg_347_0:Play320061085(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			local var_350_0 = 0
			local var_350_1 = 0.8

			if var_350_0 < arg_347_1.time_ and arg_347_1.time_ <= var_350_0 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, true)

				local var_350_2 = arg_347_1:FormatText(StoryNameCfg[605].name)

				arg_347_1.leftNameTxt_.text = var_350_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_347_1.leftNameTxt_.transform)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1.leftNameTxt_.text)
				SetActive(arg_347_1.iconTrs_.gameObject, false)
				arg_347_1.callingController_:SetSelectedState("normal")

				local var_350_3 = arg_347_1:GetWordFromCfg(320061084)
				local var_350_4 = arg_347_1:FormatText(var_350_3.content)

				arg_347_1.text_.text = var_350_4

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_5 = 32
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

				if manager.audio:GetVoiceLength("story_v_out_320061", "320061084", "story_v_out_320061.awb") ~= 0 then
					local var_350_8 = manager.audio:GetVoiceLength("story_v_out_320061", "320061084", "story_v_out_320061.awb") / 1000

					if var_350_8 + var_350_0 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_8 + var_350_0
					end

					if var_350_3.prefab_name ~= "" and arg_347_1.actors_[var_350_3.prefab_name] ~= nil then
						local var_350_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_347_1.actors_[var_350_3.prefab_name].transform, "story_v_out_320061", "320061084", "story_v_out_320061.awb")

						arg_347_1:RecordAudio("320061084", var_350_9)
						arg_347_1:RecordAudio("320061084", var_350_9)
					else
						arg_347_1:AudioAction("play", "voice", "story_v_out_320061", "320061084", "story_v_out_320061.awb")
					end

					arg_347_1:RecordHistoryTalkVoice("story_v_out_320061", "320061084", "story_v_out_320061.awb")
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
	Play320061085 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 320061085
		arg_351_1.duration_ = 5.6

		local var_351_0 = {
			zh = 2.4,
			ja = 5.6
		}
		local var_351_1 = manager.audio:GetLocalizationFlag()

		if var_351_0[var_351_1] ~= nil then
			arg_351_1.duration_ = var_351_0[var_351_1]
		end

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play320061086(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			local var_354_0 = 0
			local var_354_1 = 0.35

			if var_354_0 < arg_351_1.time_ and arg_351_1.time_ <= var_354_0 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, true)

				local var_354_2 = arg_351_1:FormatText(StoryNameCfg[6].name)

				arg_351_1.leftNameTxt_.text = var_354_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_3 = arg_351_1:GetWordFromCfg(320061085)
				local var_354_4 = arg_351_1:FormatText(var_354_3.content)

				arg_351_1.text_.text = var_354_4

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_5 = 13
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

				if manager.audio:GetVoiceLength("story_v_out_320061", "320061085", "story_v_out_320061.awb") ~= 0 then
					local var_354_8 = manager.audio:GetVoiceLength("story_v_out_320061", "320061085", "story_v_out_320061.awb") / 1000

					if var_354_8 + var_354_0 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_8 + var_354_0
					end

					if var_354_3.prefab_name ~= "" and arg_351_1.actors_[var_354_3.prefab_name] ~= nil then
						local var_354_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_351_1.actors_[var_354_3.prefab_name].transform, "story_v_out_320061", "320061085", "story_v_out_320061.awb")

						arg_351_1:RecordAudio("320061085", var_354_9)
						arg_351_1:RecordAudio("320061085", var_354_9)
					else
						arg_351_1:AudioAction("play", "voice", "story_v_out_320061", "320061085", "story_v_out_320061.awb")
					end

					arg_351_1:RecordHistoryTalkVoice("story_v_out_320061", "320061085", "story_v_out_320061.awb")
				end

				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_10 = math.max(var_354_1, arg_351_1.talkMaxDuration)

			if var_354_0 <= arg_351_1.time_ and arg_351_1.time_ < var_354_0 + var_354_10 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_0) / var_354_10

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_0 + var_354_10 and arg_351_1.time_ < var_354_0 + var_354_10 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {}

		arg_351_1:InitPlayNodeList()
	end,
	Play320061086 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 320061086
		arg_355_1.duration_ = 5

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play320061087(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			local var_358_0 = 0
			local var_358_1 = 0.175

			if var_358_0 < arg_355_1.time_ and arg_355_1.time_ <= var_358_0 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, true)

				local var_358_2 = arg_355_1:FormatText(StoryNameCfg[1033].name)

				arg_355_1.leftNameTxt_.text = var_358_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_355_1.leftNameTxt_.transform)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1.leftNameTxt_.text)
				SetActive(arg_355_1.iconTrs_.gameObject, false)
				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_3 = arg_355_1:GetWordFromCfg(320061086)
				local var_358_4 = arg_355_1:FormatText(var_358_3.content)

				arg_355_1.text_.text = var_358_4

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_5 = 6
				local var_358_6 = utf8.len(var_358_4)
				local var_358_7 = var_358_5 <= 0 and var_358_1 or var_358_1 * (var_358_6 / var_358_5)

				if var_358_7 > 0 and var_358_1 < var_358_7 then
					arg_355_1.talkMaxDuration = var_358_7

					if var_358_7 + var_358_0 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_7 + var_358_0
					end
				end

				arg_355_1.text_.text = var_358_4
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)
				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_8 = math.max(var_358_1, arg_355_1.talkMaxDuration)

			if var_358_0 <= arg_355_1.time_ and arg_355_1.time_ < var_358_0 + var_358_8 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_0) / var_358_8

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_0 + var_358_8 and arg_355_1.time_ < var_358_0 + var_358_8 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {}

		arg_355_1:InitPlayNodeList()
	end,
	Play320061087 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 320061087
		arg_359_1.duration_ = 14.17

		local var_359_0 = {
			zh = 10.9660000029802,
			ja = 14.1660000029802
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
				arg_359_0:Play320061088(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			local var_362_0 = 2

			if var_362_0 < arg_359_1.time_ and arg_359_1.time_ <= var_362_0 + arg_362_0 then
				local var_362_1 = manager.ui.mainCamera.transform.localPosition
				local var_362_2 = Vector3.New(0, 0, 10) + Vector3.New(var_362_1.x, var_362_1.y, 0)
				local var_362_3 = arg_359_1.bgs_.ST61

				var_362_3.transform.localPosition = var_362_2
				var_362_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_362_4 = var_362_3:GetComponent("SpriteRenderer")

				if var_362_4 and var_362_4.sprite then
					local var_362_5 = (var_362_3.transform.localPosition - var_362_1).z
					local var_362_6 = manager.ui.mainCameraCom_
					local var_362_7 = 2 * var_362_5 * Mathf.Tan(var_362_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_362_8 = var_362_7 * var_362_6.aspect
					local var_362_9 = var_362_4.sprite.bounds.size.x
					local var_362_10 = var_362_4.sprite.bounds.size.y
					local var_362_11 = var_362_8 / var_362_9
					local var_362_12 = var_362_7 / var_362_10
					local var_362_13 = var_362_12 < var_362_11 and var_362_11 or var_362_12

					var_362_3.transform.localScale = Vector3.New(var_362_13, var_362_13, 0)
				end

				for iter_362_0, iter_362_1 in pairs(arg_359_1.bgs_) do
					if iter_362_0 ~= "ST61" then
						iter_362_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_362_14 = 4.00000000298023

			if var_362_14 < arg_359_1.time_ and arg_359_1.time_ <= var_362_14 + arg_362_0 then
				arg_359_1.allBtn_.enabled = false
			end

			local var_362_15 = 0.3

			if arg_359_1.time_ >= var_362_14 + var_362_15 and arg_359_1.time_ < var_362_14 + var_362_15 + arg_362_0 then
				arg_359_1.allBtn_.enabled = true
			end

			local var_362_16 = 0

			if var_362_16 < arg_359_1.time_ and arg_359_1.time_ <= var_362_16 + arg_362_0 then
				arg_359_1.mask_.enabled = true
				arg_359_1.mask_.raycastTarget = true

				arg_359_1:SetGaussion(false)
			end

			local var_362_17 = 2

			if var_362_16 <= arg_359_1.time_ and arg_359_1.time_ < var_362_16 + var_362_17 then
				local var_362_18 = (arg_359_1.time_ - var_362_16) / var_362_17
				local var_362_19 = Color.New(0, 0, 0)

				var_362_19.a = Mathf.Lerp(0, 1, var_362_18)
				arg_359_1.mask_.color = var_362_19
			end

			if arg_359_1.time_ >= var_362_16 + var_362_17 and arg_359_1.time_ < var_362_16 + var_362_17 + arg_362_0 then
				local var_362_20 = Color.New(0, 0, 0)

				var_362_20.a = 1
				arg_359_1.mask_.color = var_362_20
			end

			local var_362_21 = 2.00000000298023

			if var_362_21 < arg_359_1.time_ and arg_359_1.time_ <= var_362_21 + arg_362_0 then
				arg_359_1.mask_.enabled = true
				arg_359_1.mask_.raycastTarget = true

				arg_359_1:SetGaussion(false)
			end

			local var_362_22 = 2

			if var_362_21 <= arg_359_1.time_ and arg_359_1.time_ < var_362_21 + var_362_22 then
				local var_362_23 = (arg_359_1.time_ - var_362_21) / var_362_22
				local var_362_24 = Color.New(0, 0, 0)

				var_362_24.a = Mathf.Lerp(1, 0, var_362_23)
				arg_359_1.mask_.color = var_362_24
			end

			if arg_359_1.time_ >= var_362_21 + var_362_22 and arg_359_1.time_ < var_362_21 + var_362_22 + arg_362_0 then
				local var_362_25 = Color.New(0, 0, 0)
				local var_362_26 = 0

				arg_359_1.mask_.enabled = false
				var_362_25.a = var_362_26
				arg_359_1.mask_.color = var_362_25
			end

			local var_362_27 = arg_359_1.actors_["1020ui_story"].transform
			local var_362_28 = 3.8

			if var_362_28 < arg_359_1.time_ and arg_359_1.time_ <= var_362_28 + arg_362_0 then
				arg_359_1.var_.moveOldPos1020ui_story = var_362_27.localPosition
			end

			local var_362_29 = 0.001

			if var_362_28 <= arg_359_1.time_ and arg_359_1.time_ < var_362_28 + var_362_29 then
				local var_362_30 = (arg_359_1.time_ - var_362_28) / var_362_29
				local var_362_31 = Vector3.New(0, -0.85, -6.25)

				var_362_27.localPosition = Vector3.Lerp(arg_359_1.var_.moveOldPos1020ui_story, var_362_31, var_362_30)

				local var_362_32 = manager.ui.mainCamera.transform.position - var_362_27.position

				var_362_27.forward = Vector3.New(var_362_32.x, var_362_32.y, var_362_32.z)

				local var_362_33 = var_362_27.localEulerAngles

				var_362_33.z = 0
				var_362_33.x = 0
				var_362_27.localEulerAngles = var_362_33
			end

			if arg_359_1.time_ >= var_362_28 + var_362_29 and arg_359_1.time_ < var_362_28 + var_362_29 + arg_362_0 then
				var_362_27.localPosition = Vector3.New(0, -0.85, -6.25)

				local var_362_34 = manager.ui.mainCamera.transform.position - var_362_27.position

				var_362_27.forward = Vector3.New(var_362_34.x, var_362_34.y, var_362_34.z)

				local var_362_35 = var_362_27.localEulerAngles

				var_362_35.z = 0
				var_362_35.x = 0
				var_362_27.localEulerAngles = var_362_35
			end

			local var_362_36 = arg_359_1.actors_["1020ui_story"]
			local var_362_37 = 3.8

			if var_362_37 < arg_359_1.time_ and arg_359_1.time_ <= var_362_37 + arg_362_0 and not isNil(var_362_36) and arg_359_1.var_.characterEffect1020ui_story == nil then
				arg_359_1.var_.characterEffect1020ui_story = var_362_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_362_38 = 0.200000002980232

			if var_362_37 <= arg_359_1.time_ and arg_359_1.time_ < var_362_37 + var_362_38 and not isNil(var_362_36) then
				local var_362_39 = (arg_359_1.time_ - var_362_37) / var_362_38

				if arg_359_1.var_.characterEffect1020ui_story and not isNil(var_362_36) then
					arg_359_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_359_1.time_ >= var_362_37 + var_362_38 and arg_359_1.time_ < var_362_37 + var_362_38 + arg_362_0 and not isNil(var_362_36) and arg_359_1.var_.characterEffect1020ui_story then
				arg_359_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_362_40 = 3.8

			if var_362_40 < arg_359_1.time_ and arg_359_1.time_ <= var_362_40 + arg_362_0 then
				arg_359_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action6_1")
			end

			local var_362_41 = 3.8

			if var_362_41 < arg_359_1.time_ and arg_359_1.time_ <= var_362_41 + arg_362_0 then
				arg_359_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			if arg_359_1.frameCnt_ <= 1 then
				arg_359_1.dialog_:SetActive(false)
			end

			local var_362_42 = 4.00000000298023
			local var_362_43 = 0.85

			if var_362_42 < arg_359_1.time_ and arg_359_1.time_ <= var_362_42 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0

				arg_359_1.dialog_:SetActive(true)

				arg_359_1.dialogCg_.alpha = 0

				local var_362_44 = LeanTween.value(arg_359_1.dialog_, 0, 1, 0.3)

				var_362_44:setOnUpdate(LuaHelper.FloatAction(function(arg_363_0)
					arg_359_1.dialogCg_.alpha = arg_363_0
				end))
				var_362_44:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_359_1.dialog_)
					var_362_44:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_359_1.duration_ = arg_359_1.duration_ + 0.3

				SetActive(arg_359_1.leftNameGo_, true)

				local var_362_45 = arg_359_1:FormatText(StoryNameCfg[613].name)

				arg_359_1.leftNameTxt_.text = var_362_45

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_359_1.leftNameTxt_.transform)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1.leftNameTxt_.text)
				SetActive(arg_359_1.iconTrs_.gameObject, false)
				arg_359_1.callingController_:SetSelectedState("normal")

				local var_362_46 = arg_359_1:GetWordFromCfg(320061087)
				local var_362_47 = arg_359_1:FormatText(var_362_46.content)

				arg_359_1.text_.text = var_362_47

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_48 = 34
				local var_362_49 = utf8.len(var_362_47)
				local var_362_50 = var_362_48 <= 0 and var_362_43 or var_362_43 * (var_362_49 / var_362_48)

				if var_362_50 > 0 and var_362_43 < var_362_50 then
					arg_359_1.talkMaxDuration = var_362_50
					var_362_42 = var_362_42 + 0.3

					if var_362_50 + var_362_42 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_50 + var_362_42
					end
				end

				arg_359_1.text_.text = var_362_47
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320061", "320061087", "story_v_out_320061.awb") ~= 0 then
					local var_362_51 = manager.audio:GetVoiceLength("story_v_out_320061", "320061087", "story_v_out_320061.awb") / 1000

					if var_362_51 + var_362_42 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_51 + var_362_42
					end

					if var_362_46.prefab_name ~= "" and arg_359_1.actors_[var_362_46.prefab_name] ~= nil then
						local var_362_52 = LuaForUtil.PlayVoiceWithCriLipsync(arg_359_1.actors_[var_362_46.prefab_name].transform, "story_v_out_320061", "320061087", "story_v_out_320061.awb")

						arg_359_1:RecordAudio("320061087", var_362_52)
						arg_359_1:RecordAudio("320061087", var_362_52)
					else
						arg_359_1:AudioAction("play", "voice", "story_v_out_320061", "320061087", "story_v_out_320061.awb")
					end

					arg_359_1:RecordHistoryTalkVoice("story_v_out_320061", "320061087", "story_v_out_320061.awb")
				end

				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_53 = var_362_42 + 0.3
			local var_362_54 = math.max(var_362_43, arg_359_1.talkMaxDuration)

			if var_362_53 <= arg_359_1.time_ and arg_359_1.time_ < var_362_53 + var_362_54 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - var_362_53) / var_362_54

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= var_362_53 + var_362_54 and arg_359_1.time_ < var_362_53 + var_362_54 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_359_1:InitPlayNodeList()
	end,
	Play320061088 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 320061088
		arg_365_1.duration_ = 13.83

		local var_365_0 = {
			zh = 7.266,
			ja = 13.833
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
				arg_365_0:Play320061089(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			local var_368_0 = 0
			local var_368_1 = 0.875

			if var_368_0 < arg_365_1.time_ and arg_365_1.time_ <= var_368_0 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, true)

				local var_368_2 = arg_365_1:FormatText(StoryNameCfg[613].name)

				arg_365_1.leftNameTxt_.text = var_368_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_365_1.leftNameTxt_.transform)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1.leftNameTxt_.text)
				SetActive(arg_365_1.iconTrs_.gameObject, false)
				arg_365_1.callingController_:SetSelectedState("normal")

				local var_368_3 = arg_365_1:GetWordFromCfg(320061088)
				local var_368_4 = arg_365_1:FormatText(var_368_3.content)

				arg_365_1.text_.text = var_368_4

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_5 = 35
				local var_368_6 = utf8.len(var_368_4)
				local var_368_7 = var_368_5 <= 0 and var_368_1 or var_368_1 * (var_368_6 / var_368_5)

				if var_368_7 > 0 and var_368_1 < var_368_7 then
					arg_365_1.talkMaxDuration = var_368_7

					if var_368_7 + var_368_0 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_7 + var_368_0
					end
				end

				arg_365_1.text_.text = var_368_4
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320061", "320061088", "story_v_out_320061.awb") ~= 0 then
					local var_368_8 = manager.audio:GetVoiceLength("story_v_out_320061", "320061088", "story_v_out_320061.awb") / 1000

					if var_368_8 + var_368_0 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_8 + var_368_0
					end

					if var_368_3.prefab_name ~= "" and arg_365_1.actors_[var_368_3.prefab_name] ~= nil then
						local var_368_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_365_1.actors_[var_368_3.prefab_name].transform, "story_v_out_320061", "320061088", "story_v_out_320061.awb")

						arg_365_1:RecordAudio("320061088", var_368_9)
						arg_365_1:RecordAudio("320061088", var_368_9)
					else
						arg_365_1:AudioAction("play", "voice", "story_v_out_320061", "320061088", "story_v_out_320061.awb")
					end

					arg_365_1:RecordHistoryTalkVoice("story_v_out_320061", "320061088", "story_v_out_320061.awb")
				end

				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_10 = math.max(var_368_1, arg_365_1.talkMaxDuration)

			if var_368_0 <= arg_365_1.time_ and arg_365_1.time_ < var_368_0 + var_368_10 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - var_368_0) / var_368_10

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= var_368_0 + var_368_10 and arg_365_1.time_ < var_368_0 + var_368_10 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {}

		arg_365_1:InitPlayNodeList()
	end,
	Play320061089 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 320061089
		arg_369_1.duration_ = 8.97

		local var_369_0 = {
			zh = 8.966,
			ja = 5.366
		}
		local var_369_1 = manager.audio:GetLocalizationFlag()

		if var_369_0[var_369_1] ~= nil then
			arg_369_1.duration_ = var_369_0[var_369_1]
		end

		SetActive(arg_369_1.tipsGo_, false)

		function arg_369_1.onSingleLineFinish_()
			arg_369_1.onSingleLineUpdate_ = nil
			arg_369_1.onSingleLineFinish_ = nil
			arg_369_1.state_ = "waiting"
		end

		function arg_369_1.playNext_(arg_371_0)
			if arg_371_0 == 1 then
				arg_369_0:Play320061090(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			local var_372_0 = 0

			if var_372_0 < arg_369_1.time_ and arg_369_1.time_ <= var_372_0 + arg_372_0 then
				arg_369_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020actionlink/1020action468")
			end

			local var_372_1 = 0

			if var_372_1 < arg_369_1.time_ and arg_369_1.time_ <= var_372_1 + arg_372_0 then
				arg_369_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_deyiA", "EmotionTimelineAnimator")
			end

			local var_372_2 = 0
			local var_372_3 = 1.275

			if var_372_2 < arg_369_1.time_ and arg_369_1.time_ <= var_372_2 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, true)

				local var_372_4 = arg_369_1:FormatText(StoryNameCfg[613].name)

				arg_369_1.leftNameTxt_.text = var_372_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_369_1.leftNameTxt_.transform)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1.leftNameTxt_.text)
				SetActive(arg_369_1.iconTrs_.gameObject, false)
				arg_369_1.callingController_:SetSelectedState("normal")

				local var_372_5 = arg_369_1:GetWordFromCfg(320061089)
				local var_372_6 = arg_369_1:FormatText(var_372_5.content)

				arg_369_1.text_.text = var_372_6

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_7 = 51
				local var_372_8 = utf8.len(var_372_6)
				local var_372_9 = var_372_7 <= 0 and var_372_3 or var_372_3 * (var_372_8 / var_372_7)

				if var_372_9 > 0 and var_372_3 < var_372_9 then
					arg_369_1.talkMaxDuration = var_372_9

					if var_372_9 + var_372_2 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_9 + var_372_2
					end
				end

				arg_369_1.text_.text = var_372_6
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320061", "320061089", "story_v_out_320061.awb") ~= 0 then
					local var_372_10 = manager.audio:GetVoiceLength("story_v_out_320061", "320061089", "story_v_out_320061.awb") / 1000

					if var_372_10 + var_372_2 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_10 + var_372_2
					end

					if var_372_5.prefab_name ~= "" and arg_369_1.actors_[var_372_5.prefab_name] ~= nil then
						local var_372_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_369_1.actors_[var_372_5.prefab_name].transform, "story_v_out_320061", "320061089", "story_v_out_320061.awb")

						arg_369_1:RecordAudio("320061089", var_372_11)
						arg_369_1:RecordAudio("320061089", var_372_11)
					else
						arg_369_1:AudioAction("play", "voice", "story_v_out_320061", "320061089", "story_v_out_320061.awb")
					end

					arg_369_1:RecordHistoryTalkVoice("story_v_out_320061", "320061089", "story_v_out_320061.awb")
				end

				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_12 = math.max(var_372_3, arg_369_1.talkMaxDuration)

			if var_372_2 <= arg_369_1.time_ and arg_369_1.time_ < var_372_2 + var_372_12 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - var_372_2) / var_372_12

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= var_372_2 + var_372_12 and arg_369_1.time_ < var_372_2 + var_372_12 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {}

		arg_369_1:InitPlayNodeList()
	end,
	Play320061090 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 320061090
		arg_373_1.duration_ = 5

		SetActive(arg_373_1.tipsGo_, false)

		function arg_373_1.onSingleLineFinish_()
			arg_373_1.onSingleLineUpdate_ = nil
			arg_373_1.onSingleLineFinish_ = nil
			arg_373_1.state_ = "waiting"
		end

		function arg_373_1.playNext_(arg_375_0)
			if arg_375_0 == 1 then
				arg_373_0:Play320061091(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			local var_376_0 = arg_373_1.actors_["1020ui_story"]
			local var_376_1 = 0

			if var_376_1 < arg_373_1.time_ and arg_373_1.time_ <= var_376_1 + arg_376_0 and not isNil(var_376_0) and arg_373_1.var_.characterEffect1020ui_story == nil then
				arg_373_1.var_.characterEffect1020ui_story = var_376_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_376_2 = 0.200000002980232

			if var_376_1 <= arg_373_1.time_ and arg_373_1.time_ < var_376_1 + var_376_2 and not isNil(var_376_0) then
				local var_376_3 = (arg_373_1.time_ - var_376_1) / var_376_2

				if arg_373_1.var_.characterEffect1020ui_story and not isNil(var_376_0) then
					local var_376_4 = Mathf.Lerp(0, 0.5, var_376_3)

					arg_373_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_373_1.var_.characterEffect1020ui_story.fillRatio = var_376_4
				end
			end

			if arg_373_1.time_ >= var_376_1 + var_376_2 and arg_373_1.time_ < var_376_1 + var_376_2 + arg_376_0 and not isNil(var_376_0) and arg_373_1.var_.characterEffect1020ui_story then
				local var_376_5 = 0.5

				arg_373_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_373_1.var_.characterEffect1020ui_story.fillRatio = var_376_5
			end

			local var_376_6 = 0
			local var_376_7 = 0.075

			if var_376_6 < arg_373_1.time_ and arg_373_1.time_ <= var_376_6 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, true)

				local var_376_8 = arg_373_1:FormatText(StoryNameCfg[7].name)

				arg_373_1.leftNameTxt_.text = var_376_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_373_1.leftNameTxt_.transform)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1.leftNameTxt_.text)
				SetActive(arg_373_1.iconTrs_.gameObject, true)
				arg_373_1.iconController_:SetSelectedState("hero")

				arg_373_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_373_1.callingController_:SetSelectedState("normal")

				arg_373_1.keyicon_.color = Color.New(1, 1, 1)
				arg_373_1.icon_.color = Color.New(1, 1, 1)

				local var_376_9 = arg_373_1:GetWordFromCfg(320061090)
				local var_376_10 = arg_373_1:FormatText(var_376_9.content)

				arg_373_1.text_.text = var_376_10

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_11 = 3
				local var_376_12 = utf8.len(var_376_10)
				local var_376_13 = var_376_11 <= 0 and var_376_7 or var_376_7 * (var_376_12 / var_376_11)

				if var_376_13 > 0 and var_376_7 < var_376_13 then
					arg_373_1.talkMaxDuration = var_376_13

					if var_376_13 + var_376_6 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_13 + var_376_6
					end
				end

				arg_373_1.text_.text = var_376_10
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)
				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_14 = math.max(var_376_7, arg_373_1.talkMaxDuration)

			if var_376_6 <= arg_373_1.time_ and arg_373_1.time_ < var_376_6 + var_376_14 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - var_376_6) / var_376_14

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= var_376_6 + var_376_14 and arg_373_1.time_ < var_376_6 + var_376_14 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {}

		arg_373_1:InitPlayNodeList()
	end,
	Play320061091 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 320061091
		arg_377_1.duration_ = 10.43

		local var_377_0 = {
			zh = 7.366,
			ja = 10.433
		}
		local var_377_1 = manager.audio:GetLocalizationFlag()

		if var_377_0[var_377_1] ~= nil then
			arg_377_1.duration_ = var_377_0[var_377_1]
		end

		SetActive(arg_377_1.tipsGo_, false)

		function arg_377_1.onSingleLineFinish_()
			arg_377_1.onSingleLineUpdate_ = nil
			arg_377_1.onSingleLineFinish_ = nil
			arg_377_1.state_ = "waiting"
		end

		function arg_377_1.playNext_(arg_379_0)
			if arg_379_0 == 1 then
				arg_377_0:Play320061092(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			local var_380_0 = arg_377_1.actors_["1020ui_story"].transform
			local var_380_1 = 0

			if var_380_1 < arg_377_1.time_ and arg_377_1.time_ <= var_380_1 + arg_380_0 then
				arg_377_1.var_.moveOldPos1020ui_story = var_380_0.localPosition
			end

			local var_380_2 = 0.001

			if var_380_1 <= arg_377_1.time_ and arg_377_1.time_ < var_380_1 + var_380_2 then
				local var_380_3 = (arg_377_1.time_ - var_380_1) / var_380_2
				local var_380_4 = Vector3.New(0, 100, 0)

				var_380_0.localPosition = Vector3.Lerp(arg_377_1.var_.moveOldPos1020ui_story, var_380_4, var_380_3)

				local var_380_5 = manager.ui.mainCamera.transform.position - var_380_0.position

				var_380_0.forward = Vector3.New(var_380_5.x, var_380_5.y, var_380_5.z)

				local var_380_6 = var_380_0.localEulerAngles

				var_380_6.z = 0
				var_380_6.x = 0
				var_380_0.localEulerAngles = var_380_6
			end

			if arg_377_1.time_ >= var_380_1 + var_380_2 and arg_377_1.time_ < var_380_1 + var_380_2 + arg_380_0 then
				var_380_0.localPosition = Vector3.New(0, 100, 0)

				local var_380_7 = manager.ui.mainCamera.transform.position - var_380_0.position

				var_380_0.forward = Vector3.New(var_380_7.x, var_380_7.y, var_380_7.z)

				local var_380_8 = var_380_0.localEulerAngles

				var_380_8.z = 0
				var_380_8.x = 0
				var_380_0.localEulerAngles = var_380_8
			end

			local var_380_9 = "1089ui_story"

			if arg_377_1.actors_[var_380_9] == nil then
				local var_380_10 = Asset.Load("Char/" .. "1089ui_story")

				if not isNil(var_380_10) then
					local var_380_11 = Object.Instantiate(Asset.Load("Char/" .. "1089ui_story"), arg_377_1.stage_.transform)

					var_380_11.name = var_380_9
					var_380_11.transform.localPosition = Vector3.New(0, 100, 0)
					arg_377_1.actors_[var_380_9] = var_380_11

					local var_380_12 = var_380_11:GetComponentInChildren(typeof(CharacterEffect))

					var_380_12.enabled = true

					local var_380_13 = GameObjectTools.GetOrAddComponent(var_380_11, typeof(DynamicBoneHelper))

					if var_380_13 then
						var_380_13:EnableDynamicBone(false)
					end

					arg_377_1:ShowWeapon(var_380_12.transform, false)

					arg_377_1.var_[var_380_9 .. "Animator"] = var_380_12.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_377_1.var_[var_380_9 .. "Animator"].applyRootMotion = true
					arg_377_1.var_[var_380_9 .. "LipSync"] = var_380_12.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_380_14 = arg_377_1.actors_["1089ui_story"]
			local var_380_15 = 0

			if var_380_15 < arg_377_1.time_ and arg_377_1.time_ <= var_380_15 + arg_380_0 and not isNil(var_380_14) and arg_377_1.var_.characterEffect1089ui_story == nil then
				arg_377_1.var_.characterEffect1089ui_story = var_380_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_380_16 = 0.200000002980232

			if var_380_15 <= arg_377_1.time_ and arg_377_1.time_ < var_380_15 + var_380_16 and not isNil(var_380_14) then
				local var_380_17 = (arg_377_1.time_ - var_380_15) / var_380_16

				if arg_377_1.var_.characterEffect1089ui_story and not isNil(var_380_14) then
					arg_377_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_377_1.time_ >= var_380_15 + var_380_16 and arg_377_1.time_ < var_380_15 + var_380_16 + arg_380_0 and not isNil(var_380_14) and arg_377_1.var_.characterEffect1089ui_story then
				arg_377_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_380_18 = 0

			if var_380_18 < arg_377_1.time_ and arg_377_1.time_ <= var_380_18 + arg_380_0 then
				arg_377_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action1_1")
			end

			local var_380_19 = 0

			if var_380_19 < arg_377_1.time_ and arg_377_1.time_ <= var_380_19 + arg_380_0 then
				arg_377_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_380_20 = arg_377_1.actors_["1089ui_story"].transform
			local var_380_21 = 0

			if var_380_21 < arg_377_1.time_ and arg_377_1.time_ <= var_380_21 + arg_380_0 then
				arg_377_1.var_.moveOldPos1089ui_story = var_380_20.localPosition
			end

			local var_380_22 = 0.001

			if var_380_21 <= arg_377_1.time_ and arg_377_1.time_ < var_380_21 + var_380_22 then
				local var_380_23 = (arg_377_1.time_ - var_380_21) / var_380_22
				local var_380_24 = Vector3.New(0, -1.1, -6.17)

				var_380_20.localPosition = Vector3.Lerp(arg_377_1.var_.moveOldPos1089ui_story, var_380_24, var_380_23)

				local var_380_25 = manager.ui.mainCamera.transform.position - var_380_20.position

				var_380_20.forward = Vector3.New(var_380_25.x, var_380_25.y, var_380_25.z)

				local var_380_26 = var_380_20.localEulerAngles

				var_380_26.z = 0
				var_380_26.x = 0
				var_380_20.localEulerAngles = var_380_26
			end

			if arg_377_1.time_ >= var_380_21 + var_380_22 and arg_377_1.time_ < var_380_21 + var_380_22 + arg_380_0 then
				var_380_20.localPosition = Vector3.New(0, -1.1, -6.17)

				local var_380_27 = manager.ui.mainCamera.transform.position - var_380_20.position

				var_380_20.forward = Vector3.New(var_380_27.x, var_380_27.y, var_380_27.z)

				local var_380_28 = var_380_20.localEulerAngles

				var_380_28.z = 0
				var_380_28.x = 0
				var_380_20.localEulerAngles = var_380_28
			end

			local var_380_29 = 0
			local var_380_30 = 0.775

			if var_380_29 < arg_377_1.time_ and arg_377_1.time_ <= var_380_29 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, true)

				local var_380_31 = arg_377_1:FormatText(StoryNameCfg[1031].name)

				arg_377_1.leftNameTxt_.text = var_380_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_377_1.leftNameTxt_.transform)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1.leftNameTxt_.text)
				SetActive(arg_377_1.iconTrs_.gameObject, false)
				arg_377_1.callingController_:SetSelectedState("normal")

				local var_380_32 = arg_377_1:GetWordFromCfg(320061091)
				local var_380_33 = arg_377_1:FormatText(var_380_32.content)

				arg_377_1.text_.text = var_380_33

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_34 = 31
				local var_380_35 = utf8.len(var_380_33)
				local var_380_36 = var_380_34 <= 0 and var_380_30 or var_380_30 * (var_380_35 / var_380_34)

				if var_380_36 > 0 and var_380_30 < var_380_36 then
					arg_377_1.talkMaxDuration = var_380_36

					if var_380_36 + var_380_29 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_36 + var_380_29
					end
				end

				arg_377_1.text_.text = var_380_33
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320061", "320061091", "story_v_out_320061.awb") ~= 0 then
					local var_380_37 = manager.audio:GetVoiceLength("story_v_out_320061", "320061091", "story_v_out_320061.awb") / 1000

					if var_380_37 + var_380_29 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_37 + var_380_29
					end

					if var_380_32.prefab_name ~= "" and arg_377_1.actors_[var_380_32.prefab_name] ~= nil then
						local var_380_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_377_1.actors_[var_380_32.prefab_name].transform, "story_v_out_320061", "320061091", "story_v_out_320061.awb")

						arg_377_1:RecordAudio("320061091", var_380_38)
						arg_377_1:RecordAudio("320061091", var_380_38)
					else
						arg_377_1:AudioAction("play", "voice", "story_v_out_320061", "320061091", "story_v_out_320061.awb")
					end

					arg_377_1:RecordHistoryTalkVoice("story_v_out_320061", "320061091", "story_v_out_320061.awb")
				end

				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_39 = math.max(var_380_30, arg_377_1.talkMaxDuration)

			if var_380_29 <= arg_377_1.time_ and arg_377_1.time_ < var_380_29 + var_380_39 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - var_380_29) / var_380_39

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= var_380_29 + var_380_39 and arg_377_1.time_ < var_380_29 + var_380_39 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
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

		arg_377_1:InitPlayNodeList()
	end,
	Play320061092 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 320061092
		arg_381_1.duration_ = 7.4

		local var_381_0 = {
			zh = 3.5,
			ja = 7.4
		}
		local var_381_1 = manager.audio:GetLocalizationFlag()

		if var_381_0[var_381_1] ~= nil then
			arg_381_1.duration_ = var_381_0[var_381_1]
		end

		SetActive(arg_381_1.tipsGo_, false)

		function arg_381_1.onSingleLineFinish_()
			arg_381_1.onSingleLineUpdate_ = nil
			arg_381_1.onSingleLineFinish_ = nil
			arg_381_1.state_ = "waiting"
		end

		function arg_381_1.playNext_(arg_383_0)
			if arg_383_0 == 1 then
				arg_381_0:Play320061093(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			local var_384_0 = 0

			if var_384_0 < arg_381_1.time_ and arg_381_1.time_ <= var_384_0 + arg_384_0 then
				arg_381_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_384_1 = 0
			local var_384_2 = 0.4

			if var_384_1 < arg_381_1.time_ and arg_381_1.time_ <= var_384_1 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, true)

				local var_384_3 = arg_381_1:FormatText(StoryNameCfg[1031].name)

				arg_381_1.leftNameTxt_.text = var_384_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_381_1.leftNameTxt_.transform)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1.leftNameTxt_.text)
				SetActive(arg_381_1.iconTrs_.gameObject, false)
				arg_381_1.callingController_:SetSelectedState("normal")

				local var_384_4 = arg_381_1:GetWordFromCfg(320061092)
				local var_384_5 = arg_381_1:FormatText(var_384_4.content)

				arg_381_1.text_.text = var_384_5

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_6 = 16
				local var_384_7 = utf8.len(var_384_5)
				local var_384_8 = var_384_6 <= 0 and var_384_2 or var_384_2 * (var_384_7 / var_384_6)

				if var_384_8 > 0 and var_384_2 < var_384_8 then
					arg_381_1.talkMaxDuration = var_384_8

					if var_384_8 + var_384_1 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_8 + var_384_1
					end
				end

				arg_381_1.text_.text = var_384_5
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320061", "320061092", "story_v_out_320061.awb") ~= 0 then
					local var_384_9 = manager.audio:GetVoiceLength("story_v_out_320061", "320061092", "story_v_out_320061.awb") / 1000

					if var_384_9 + var_384_1 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_9 + var_384_1
					end

					if var_384_4.prefab_name ~= "" and arg_381_1.actors_[var_384_4.prefab_name] ~= nil then
						local var_384_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_381_1.actors_[var_384_4.prefab_name].transform, "story_v_out_320061", "320061092", "story_v_out_320061.awb")

						arg_381_1:RecordAudio("320061092", var_384_10)
						arg_381_1:RecordAudio("320061092", var_384_10)
					else
						arg_381_1:AudioAction("play", "voice", "story_v_out_320061", "320061092", "story_v_out_320061.awb")
					end

					arg_381_1:RecordHistoryTalkVoice("story_v_out_320061", "320061092", "story_v_out_320061.awb")
				end

				arg_381_1:RecordContent(arg_381_1.text_.text)
			end

			local var_384_11 = math.max(var_384_2, arg_381_1.talkMaxDuration)

			if var_384_1 <= arg_381_1.time_ and arg_381_1.time_ < var_384_1 + var_384_11 then
				arg_381_1.typewritter.percent = (arg_381_1.time_ - var_384_1) / var_384_11

				arg_381_1.typewritter:SetDirty()
			end

			if arg_381_1.time_ >= var_384_1 + var_384_11 and arg_381_1.time_ < var_384_1 + var_384_11 + arg_384_0 then
				arg_381_1.typewritter.percent = 1

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(true)
			end
		end

		arg_381_1.nodeConfigList_ = {}

		arg_381_1:InitPlayNodeList()
	end,
	Play320061093 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 320061093
		arg_385_1.duration_ = 5

		SetActive(arg_385_1.tipsGo_, false)

		function arg_385_1.onSingleLineFinish_()
			arg_385_1.onSingleLineUpdate_ = nil
			arg_385_1.onSingleLineFinish_ = nil
			arg_385_1.state_ = "waiting"
		end

		function arg_385_1.playNext_(arg_387_0)
			if arg_387_0 == 1 then
				arg_385_0:Play320061094(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			local var_388_0 = arg_385_1.actors_["1089ui_story"].transform
			local var_388_1 = 0

			if var_388_1 < arg_385_1.time_ and arg_385_1.time_ <= var_388_1 + arg_388_0 then
				arg_385_1.var_.moveOldPos1089ui_story = var_388_0.localPosition
			end

			local var_388_2 = 0.001

			if var_388_1 <= arg_385_1.time_ and arg_385_1.time_ < var_388_1 + var_388_2 then
				local var_388_3 = (arg_385_1.time_ - var_388_1) / var_388_2
				local var_388_4 = Vector3.New(0, 100, 0)

				var_388_0.localPosition = Vector3.Lerp(arg_385_1.var_.moveOldPos1089ui_story, var_388_4, var_388_3)

				local var_388_5 = manager.ui.mainCamera.transform.position - var_388_0.position

				var_388_0.forward = Vector3.New(var_388_5.x, var_388_5.y, var_388_5.z)

				local var_388_6 = var_388_0.localEulerAngles

				var_388_6.z = 0
				var_388_6.x = 0
				var_388_0.localEulerAngles = var_388_6
			end

			if arg_385_1.time_ >= var_388_1 + var_388_2 and arg_385_1.time_ < var_388_1 + var_388_2 + arg_388_0 then
				var_388_0.localPosition = Vector3.New(0, 100, 0)

				local var_388_7 = manager.ui.mainCamera.transform.position - var_388_0.position

				var_388_0.forward = Vector3.New(var_388_7.x, var_388_7.y, var_388_7.z)

				local var_388_8 = var_388_0.localEulerAngles

				var_388_8.z = 0
				var_388_8.x = 0
				var_388_0.localEulerAngles = var_388_8
			end

			local var_388_9 = arg_385_1.actors_["1089ui_story"]
			local var_388_10 = 0

			if var_388_10 < arg_385_1.time_ and arg_385_1.time_ <= var_388_10 + arg_388_0 and not isNil(var_388_9) and arg_385_1.var_.characterEffect1089ui_story == nil then
				arg_385_1.var_.characterEffect1089ui_story = var_388_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_388_11 = 0.200000002980232

			if var_388_10 <= arg_385_1.time_ and arg_385_1.time_ < var_388_10 + var_388_11 and not isNil(var_388_9) then
				local var_388_12 = (arg_385_1.time_ - var_388_10) / var_388_11

				if arg_385_1.var_.characterEffect1089ui_story and not isNil(var_388_9) then
					local var_388_13 = Mathf.Lerp(0, 0.5, var_388_12)

					arg_385_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_385_1.var_.characterEffect1089ui_story.fillRatio = var_388_13
				end
			end

			if arg_385_1.time_ >= var_388_10 + var_388_11 and arg_385_1.time_ < var_388_10 + var_388_11 + arg_388_0 and not isNil(var_388_9) and arg_385_1.var_.characterEffect1089ui_story then
				local var_388_14 = 0.5

				arg_385_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_385_1.var_.characterEffect1089ui_story.fillRatio = var_388_14
			end

			local var_388_15 = 0
			local var_388_16 = 1.45

			if var_388_15 < arg_385_1.time_ and arg_385_1.time_ <= var_388_15 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, false)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_385_1.iconTrs_.gameObject, false)
				arg_385_1.callingController_:SetSelectedState("normal")

				local var_388_17 = arg_385_1:GetWordFromCfg(320061093)
				local var_388_18 = arg_385_1:FormatText(var_388_17.content)

				arg_385_1.text_.text = var_388_18

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_19 = 58
				local var_388_20 = utf8.len(var_388_18)
				local var_388_21 = var_388_19 <= 0 and var_388_16 or var_388_16 * (var_388_20 / var_388_19)

				if var_388_21 > 0 and var_388_16 < var_388_21 then
					arg_385_1.talkMaxDuration = var_388_21

					if var_388_21 + var_388_15 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_21 + var_388_15
					end
				end

				arg_385_1.text_.text = var_388_18
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)
				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_22 = math.max(var_388_16, arg_385_1.talkMaxDuration)

			if var_388_15 <= arg_385_1.time_ and arg_385_1.time_ < var_388_15 + var_388_22 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - var_388_15) / var_388_22

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= var_388_15 + var_388_22 and arg_385_1.time_ < var_388_15 + var_388_22 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {
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

		arg_385_1:InitPlayNodeList()
	end,
	Play320061094 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 320061094
		arg_389_1.duration_ = 5

		SetActive(arg_389_1.tipsGo_, false)

		function arg_389_1.onSingleLineFinish_()
			arg_389_1.onSingleLineUpdate_ = nil
			arg_389_1.onSingleLineFinish_ = nil
			arg_389_1.state_ = "waiting"
		end

		function arg_389_1.playNext_(arg_391_0)
			if arg_391_0 == 1 then
				arg_389_0:Play320061095(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			local var_392_0 = 0
			local var_392_1 = 0.5

			if var_392_0 < arg_389_1.time_ and arg_389_1.time_ <= var_392_0 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, false)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_389_1.iconTrs_.gameObject, false)
				arg_389_1.callingController_:SetSelectedState("normal")

				local var_392_2 = arg_389_1:GetWordFromCfg(320061094)
				local var_392_3 = arg_389_1:FormatText(var_392_2.content)

				arg_389_1.text_.text = var_392_3

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_4 = 20
				local var_392_5 = utf8.len(var_392_3)
				local var_392_6 = var_392_4 <= 0 and var_392_1 or var_392_1 * (var_392_5 / var_392_4)

				if var_392_6 > 0 and var_392_1 < var_392_6 then
					arg_389_1.talkMaxDuration = var_392_6

					if var_392_6 + var_392_0 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_6 + var_392_0
					end
				end

				arg_389_1.text_.text = var_392_3
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)
				arg_389_1:RecordContent(arg_389_1.text_.text)
			end

			local var_392_7 = math.max(var_392_1, arg_389_1.talkMaxDuration)

			if var_392_0 <= arg_389_1.time_ and arg_389_1.time_ < var_392_0 + var_392_7 then
				arg_389_1.typewritter.percent = (arg_389_1.time_ - var_392_0) / var_392_7

				arg_389_1.typewritter:SetDirty()
			end

			if arg_389_1.time_ >= var_392_0 + var_392_7 and arg_389_1.time_ < var_392_0 + var_392_7 + arg_392_0 then
				arg_389_1.typewritter.percent = 1

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(true)
			end
		end

		arg_389_1.nodeConfigList_ = {}

		arg_389_1:InitPlayNodeList()
	end,
	Play320061095 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 320061095
		arg_393_1.duration_ = 6.87

		local var_393_0 = {
			zh = 5.033,
			ja = 6.866
		}
		local var_393_1 = manager.audio:GetLocalizationFlag()

		if var_393_0[var_393_1] ~= nil then
			arg_393_1.duration_ = var_393_0[var_393_1]
		end

		SetActive(arg_393_1.tipsGo_, false)

		function arg_393_1.onSingleLineFinish_()
			arg_393_1.onSingleLineUpdate_ = nil
			arg_393_1.onSingleLineFinish_ = nil
			arg_393_1.state_ = "waiting"
		end

		function arg_393_1.playNext_(arg_395_0)
			if arg_395_0 == 1 then
				arg_393_0:Play320061096(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			local var_396_0 = arg_393_1.actors_["1089ui_story"].transform
			local var_396_1 = 0

			if var_396_1 < arg_393_1.time_ and arg_393_1.time_ <= var_396_1 + arg_396_0 then
				arg_393_1.var_.moveOldPos1089ui_story = var_396_0.localPosition
			end

			local var_396_2 = 0.001

			if var_396_1 <= arg_393_1.time_ and arg_393_1.time_ < var_396_1 + var_396_2 then
				local var_396_3 = (arg_393_1.time_ - var_396_1) / var_396_2
				local var_396_4 = Vector3.New(0, -1.1, -6.17)

				var_396_0.localPosition = Vector3.Lerp(arg_393_1.var_.moveOldPos1089ui_story, var_396_4, var_396_3)

				local var_396_5 = manager.ui.mainCamera.transform.position - var_396_0.position

				var_396_0.forward = Vector3.New(var_396_5.x, var_396_5.y, var_396_5.z)

				local var_396_6 = var_396_0.localEulerAngles

				var_396_6.z = 0
				var_396_6.x = 0
				var_396_0.localEulerAngles = var_396_6
			end

			if arg_393_1.time_ >= var_396_1 + var_396_2 and arg_393_1.time_ < var_396_1 + var_396_2 + arg_396_0 then
				var_396_0.localPosition = Vector3.New(0, -1.1, -6.17)

				local var_396_7 = manager.ui.mainCamera.transform.position - var_396_0.position

				var_396_0.forward = Vector3.New(var_396_7.x, var_396_7.y, var_396_7.z)

				local var_396_8 = var_396_0.localEulerAngles

				var_396_8.z = 0
				var_396_8.x = 0
				var_396_0.localEulerAngles = var_396_8
			end

			local var_396_9 = arg_393_1.actors_["1089ui_story"]
			local var_396_10 = 0

			if var_396_10 < arg_393_1.time_ and arg_393_1.time_ <= var_396_10 + arg_396_0 and not isNil(var_396_9) and arg_393_1.var_.characterEffect1089ui_story == nil then
				arg_393_1.var_.characterEffect1089ui_story = var_396_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_396_11 = 0.200000002980232

			if var_396_10 <= arg_393_1.time_ and arg_393_1.time_ < var_396_10 + var_396_11 and not isNil(var_396_9) then
				local var_396_12 = (arg_393_1.time_ - var_396_10) / var_396_11

				if arg_393_1.var_.characterEffect1089ui_story and not isNil(var_396_9) then
					arg_393_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_393_1.time_ >= var_396_10 + var_396_11 and arg_393_1.time_ < var_396_10 + var_396_11 + arg_396_0 and not isNil(var_396_9) and arg_393_1.var_.characterEffect1089ui_story then
				arg_393_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_396_13 = 0

			if var_396_13 < arg_393_1.time_ and arg_393_1.time_ <= var_396_13 + arg_396_0 then
				arg_393_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action1_1")
			end

			local var_396_14 = 0

			if var_396_14 < arg_393_1.time_ and arg_393_1.time_ <= var_396_14 + arg_396_0 then
				arg_393_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_396_15 = 0
			local var_396_16 = 0.55

			if var_396_15 < arg_393_1.time_ and arg_393_1.time_ <= var_396_15 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0
				arg_393_1.dialogCg_.alpha = 1

				arg_393_1.dialog_:SetActive(true)
				SetActive(arg_393_1.leftNameGo_, true)

				local var_396_17 = arg_393_1:FormatText(StoryNameCfg[1031].name)

				arg_393_1.leftNameTxt_.text = var_396_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_393_1.leftNameTxt_.transform)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1.leftNameTxt_.text)
				SetActive(arg_393_1.iconTrs_.gameObject, false)
				arg_393_1.callingController_:SetSelectedState("normal")

				local var_396_18 = arg_393_1:GetWordFromCfg(320061095)
				local var_396_19 = arg_393_1:FormatText(var_396_18.content)

				arg_393_1.text_.text = var_396_19

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_20 = 22
				local var_396_21 = utf8.len(var_396_19)
				local var_396_22 = var_396_20 <= 0 and var_396_16 or var_396_16 * (var_396_21 / var_396_20)

				if var_396_22 > 0 and var_396_16 < var_396_22 then
					arg_393_1.talkMaxDuration = var_396_22

					if var_396_22 + var_396_15 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_22 + var_396_15
					end
				end

				arg_393_1.text_.text = var_396_19
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320061", "320061095", "story_v_out_320061.awb") ~= 0 then
					local var_396_23 = manager.audio:GetVoiceLength("story_v_out_320061", "320061095", "story_v_out_320061.awb") / 1000

					if var_396_23 + var_396_15 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_23 + var_396_15
					end

					if var_396_18.prefab_name ~= "" and arg_393_1.actors_[var_396_18.prefab_name] ~= nil then
						local var_396_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_393_1.actors_[var_396_18.prefab_name].transform, "story_v_out_320061", "320061095", "story_v_out_320061.awb")

						arg_393_1:RecordAudio("320061095", var_396_24)
						arg_393_1:RecordAudio("320061095", var_396_24)
					else
						arg_393_1:AudioAction("play", "voice", "story_v_out_320061", "320061095", "story_v_out_320061.awb")
					end

					arg_393_1:RecordHistoryTalkVoice("story_v_out_320061", "320061095", "story_v_out_320061.awb")
				end

				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_25 = math.max(var_396_16, arg_393_1.talkMaxDuration)

			if var_396_15 <= arg_393_1.time_ and arg_393_1.time_ < var_396_15 + var_396_25 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - var_396_15) / var_396_25

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= var_396_15 + var_396_25 and arg_393_1.time_ < var_396_15 + var_396_25 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end

		arg_393_1.nodeConfigList_ = {
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

		arg_393_1:InitPlayNodeList()
	end,
	Play320061096 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 320061096
		arg_397_1.duration_ = 11.8

		local var_397_0 = {
			zh = 11.8,
			ja = 9.2
		}
		local var_397_1 = manager.audio:GetLocalizationFlag()

		if var_397_0[var_397_1] ~= nil then
			arg_397_1.duration_ = var_397_0[var_397_1]
		end

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play320061097(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			local var_400_0 = 0

			if var_400_0 < arg_397_1.time_ and arg_397_1.time_ <= var_400_0 + arg_400_0 then
				arg_397_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_400_1 = 0
			local var_400_2 = 1.1

			if var_400_1 < arg_397_1.time_ and arg_397_1.time_ <= var_400_1 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, true)

				local var_400_3 = arg_397_1:FormatText(StoryNameCfg[1031].name)

				arg_397_1.leftNameTxt_.text = var_400_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_397_1.leftNameTxt_.transform)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1.leftNameTxt_.text)
				SetActive(arg_397_1.iconTrs_.gameObject, false)
				arg_397_1.callingController_:SetSelectedState("normal")

				local var_400_4 = arg_397_1:GetWordFromCfg(320061096)
				local var_400_5 = arg_397_1:FormatText(var_400_4.content)

				arg_397_1.text_.text = var_400_5

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_6 = 44
				local var_400_7 = utf8.len(var_400_5)
				local var_400_8 = var_400_6 <= 0 and var_400_2 or var_400_2 * (var_400_7 / var_400_6)

				if var_400_8 > 0 and var_400_2 < var_400_8 then
					arg_397_1.talkMaxDuration = var_400_8

					if var_400_8 + var_400_1 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_8 + var_400_1
					end
				end

				arg_397_1.text_.text = var_400_5
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320061", "320061096", "story_v_out_320061.awb") ~= 0 then
					local var_400_9 = manager.audio:GetVoiceLength("story_v_out_320061", "320061096", "story_v_out_320061.awb") / 1000

					if var_400_9 + var_400_1 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_9 + var_400_1
					end

					if var_400_4.prefab_name ~= "" and arg_397_1.actors_[var_400_4.prefab_name] ~= nil then
						local var_400_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_397_1.actors_[var_400_4.prefab_name].transform, "story_v_out_320061", "320061096", "story_v_out_320061.awb")

						arg_397_1:RecordAudio("320061096", var_400_10)
						arg_397_1:RecordAudio("320061096", var_400_10)
					else
						arg_397_1:AudioAction("play", "voice", "story_v_out_320061", "320061096", "story_v_out_320061.awb")
					end

					arg_397_1:RecordHistoryTalkVoice("story_v_out_320061", "320061096", "story_v_out_320061.awb")
				end

				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_11 = math.max(var_400_2, arg_397_1.talkMaxDuration)

			if var_400_1 <= arg_397_1.time_ and arg_397_1.time_ < var_400_1 + var_400_11 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - var_400_1) / var_400_11

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= var_400_1 + var_400_11 and arg_397_1.time_ < var_400_1 + var_400_11 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {}

		arg_397_1:InitPlayNodeList()
	end,
	Play320061097 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 320061097
		arg_401_1.duration_ = 4

		local var_401_0 = {
			zh = 4,
			ja = 3.933
		}
		local var_401_1 = manager.audio:GetLocalizationFlag()

		if var_401_0[var_401_1] ~= nil then
			arg_401_1.duration_ = var_401_0[var_401_1]
		end

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play320061098(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			local var_404_0 = arg_401_1.actors_["1089ui_story"].transform
			local var_404_1 = 0

			if var_404_1 < arg_401_1.time_ and arg_401_1.time_ <= var_404_1 + arg_404_0 then
				arg_401_1.var_.moveOldPos1089ui_story = var_404_0.localPosition
			end

			local var_404_2 = 0.001

			if var_404_1 <= arg_401_1.time_ and arg_401_1.time_ < var_404_1 + var_404_2 then
				local var_404_3 = (arg_401_1.time_ - var_404_1) / var_404_2
				local var_404_4 = Vector3.New(-0.7, -1.1, -6.17)

				var_404_0.localPosition = Vector3.Lerp(arg_401_1.var_.moveOldPos1089ui_story, var_404_4, var_404_3)

				local var_404_5 = manager.ui.mainCamera.transform.position - var_404_0.position

				var_404_0.forward = Vector3.New(var_404_5.x, var_404_5.y, var_404_5.z)

				local var_404_6 = var_404_0.localEulerAngles

				var_404_6.z = 0
				var_404_6.x = 0
				var_404_0.localEulerAngles = var_404_6
			end

			if arg_401_1.time_ >= var_404_1 + var_404_2 and arg_401_1.time_ < var_404_1 + var_404_2 + arg_404_0 then
				var_404_0.localPosition = Vector3.New(-0.7, -1.1, -6.17)

				local var_404_7 = manager.ui.mainCamera.transform.position - var_404_0.position

				var_404_0.forward = Vector3.New(var_404_7.x, var_404_7.y, var_404_7.z)

				local var_404_8 = var_404_0.localEulerAngles

				var_404_8.z = 0
				var_404_8.x = 0
				var_404_0.localEulerAngles = var_404_8
			end

			local var_404_9 = arg_401_1.actors_["1089ui_story"]
			local var_404_10 = 0

			if var_404_10 < arg_401_1.time_ and arg_401_1.time_ <= var_404_10 + arg_404_0 and not isNil(var_404_9) and arg_401_1.var_.characterEffect1089ui_story == nil then
				arg_401_1.var_.characterEffect1089ui_story = var_404_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_404_11 = 0.200000002980232

			if var_404_10 <= arg_401_1.time_ and arg_401_1.time_ < var_404_10 + var_404_11 and not isNil(var_404_9) then
				local var_404_12 = (arg_401_1.time_ - var_404_10) / var_404_11

				if arg_401_1.var_.characterEffect1089ui_story and not isNil(var_404_9) then
					local var_404_13 = Mathf.Lerp(0, 0.5, var_404_12)

					arg_401_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_401_1.var_.characterEffect1089ui_story.fillRatio = var_404_13
				end
			end

			if arg_401_1.time_ >= var_404_10 + var_404_11 and arg_401_1.time_ < var_404_10 + var_404_11 + arg_404_0 and not isNil(var_404_9) and arg_401_1.var_.characterEffect1089ui_story then
				local var_404_14 = 0.5

				arg_401_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_401_1.var_.characterEffect1089ui_story.fillRatio = var_404_14
			end

			local var_404_15 = arg_401_1.actors_["1020ui_story"].transform
			local var_404_16 = 0

			if var_404_16 < arg_401_1.time_ and arg_401_1.time_ <= var_404_16 + arg_404_0 then
				arg_401_1.var_.moveOldPos1020ui_story = var_404_15.localPosition
			end

			local var_404_17 = 0.001

			if var_404_16 <= arg_401_1.time_ and arg_401_1.time_ < var_404_16 + var_404_17 then
				local var_404_18 = (arg_401_1.time_ - var_404_16) / var_404_17
				local var_404_19 = Vector3.New(0.7, -0.85, -6.25)

				var_404_15.localPosition = Vector3.Lerp(arg_401_1.var_.moveOldPos1020ui_story, var_404_19, var_404_18)

				local var_404_20 = manager.ui.mainCamera.transform.position - var_404_15.position

				var_404_15.forward = Vector3.New(var_404_20.x, var_404_20.y, var_404_20.z)

				local var_404_21 = var_404_15.localEulerAngles

				var_404_21.z = 0
				var_404_21.x = 0
				var_404_15.localEulerAngles = var_404_21
			end

			if arg_401_1.time_ >= var_404_16 + var_404_17 and arg_401_1.time_ < var_404_16 + var_404_17 + arg_404_0 then
				var_404_15.localPosition = Vector3.New(0.7, -0.85, -6.25)

				local var_404_22 = manager.ui.mainCamera.transform.position - var_404_15.position

				var_404_15.forward = Vector3.New(var_404_22.x, var_404_22.y, var_404_22.z)

				local var_404_23 = var_404_15.localEulerAngles

				var_404_23.z = 0
				var_404_23.x = 0
				var_404_15.localEulerAngles = var_404_23
			end

			local var_404_24 = arg_401_1.actors_["1020ui_story"]
			local var_404_25 = 0

			if var_404_25 < arg_401_1.time_ and arg_401_1.time_ <= var_404_25 + arg_404_0 and not isNil(var_404_24) and arg_401_1.var_.characterEffect1020ui_story == nil then
				arg_401_1.var_.characterEffect1020ui_story = var_404_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_404_26 = 0.200000002980232

			if var_404_25 <= arg_401_1.time_ and arg_401_1.time_ < var_404_25 + var_404_26 and not isNil(var_404_24) then
				local var_404_27 = (arg_401_1.time_ - var_404_25) / var_404_26

				if arg_401_1.var_.characterEffect1020ui_story and not isNil(var_404_24) then
					arg_401_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_401_1.time_ >= var_404_25 + var_404_26 and arg_401_1.time_ < var_404_25 + var_404_26 + arg_404_0 and not isNil(var_404_24) and arg_401_1.var_.characterEffect1020ui_story then
				arg_401_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_404_28 = 0

			if var_404_28 < arg_401_1.time_ and arg_401_1.time_ <= var_404_28 + arg_404_0 then
				arg_401_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action4_1")
			end

			local var_404_29 = 0

			if var_404_29 < arg_401_1.time_ and arg_401_1.time_ <= var_404_29 + arg_404_0 then
				arg_401_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_deyiA", "EmotionTimelineAnimator")
			end

			local var_404_30 = 0
			local var_404_31 = 0.45

			if var_404_30 < arg_401_1.time_ and arg_401_1.time_ <= var_404_30 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, true)

				local var_404_32 = arg_401_1:FormatText(StoryNameCfg[613].name)

				arg_401_1.leftNameTxt_.text = var_404_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_401_1.leftNameTxt_.transform)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1.leftNameTxt_.text)
				SetActive(arg_401_1.iconTrs_.gameObject, false)
				arg_401_1.callingController_:SetSelectedState("normal")

				local var_404_33 = arg_401_1:GetWordFromCfg(320061097)
				local var_404_34 = arg_401_1:FormatText(var_404_33.content)

				arg_401_1.text_.text = var_404_34

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_35 = 18
				local var_404_36 = utf8.len(var_404_34)
				local var_404_37 = var_404_35 <= 0 and var_404_31 or var_404_31 * (var_404_36 / var_404_35)

				if var_404_37 > 0 and var_404_31 < var_404_37 then
					arg_401_1.talkMaxDuration = var_404_37

					if var_404_37 + var_404_30 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_37 + var_404_30
					end
				end

				arg_401_1.text_.text = var_404_34
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320061", "320061097", "story_v_out_320061.awb") ~= 0 then
					local var_404_38 = manager.audio:GetVoiceLength("story_v_out_320061", "320061097", "story_v_out_320061.awb") / 1000

					if var_404_38 + var_404_30 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_38 + var_404_30
					end

					if var_404_33.prefab_name ~= "" and arg_401_1.actors_[var_404_33.prefab_name] ~= nil then
						local var_404_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_401_1.actors_[var_404_33.prefab_name].transform, "story_v_out_320061", "320061097", "story_v_out_320061.awb")

						arg_401_1:RecordAudio("320061097", var_404_39)
						arg_401_1:RecordAudio("320061097", var_404_39)
					else
						arg_401_1:AudioAction("play", "voice", "story_v_out_320061", "320061097", "story_v_out_320061.awb")
					end

					arg_401_1:RecordHistoryTalkVoice("story_v_out_320061", "320061097", "story_v_out_320061.awb")
				end

				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_40 = math.max(var_404_31, arg_401_1.talkMaxDuration)

			if var_404_30 <= arg_401_1.time_ and arg_401_1.time_ < var_404_30 + var_404_40 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - var_404_30) / var_404_40

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= var_404_30 + var_404_40 and arg_401_1.time_ < var_404_30 + var_404_40 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_401_1:InitPlayNodeList()
	end,
	Play320061098 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 320061098
		arg_405_1.duration_ = 10.03

		local var_405_0 = {
			zh = 7.4,
			ja = 10.033
		}
		local var_405_1 = manager.audio:GetLocalizationFlag()

		if var_405_0[var_405_1] ~= nil then
			arg_405_1.duration_ = var_405_0[var_405_1]
		end

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play320061099(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			local var_408_0 = 0

			if var_408_0 < arg_405_1.time_ and arg_405_1.time_ <= var_408_0 + arg_408_0 then
				arg_405_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action4_2")
			end

			local var_408_1 = 0

			if var_408_1 < arg_405_1.time_ and arg_405_1.time_ <= var_408_1 + arg_408_0 then
				arg_405_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_408_2 = 0
			local var_408_3 = 1.025

			if var_408_2 < arg_405_1.time_ and arg_405_1.time_ <= var_408_2 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, true)

				local var_408_4 = arg_405_1:FormatText(StoryNameCfg[613].name)

				arg_405_1.leftNameTxt_.text = var_408_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_405_1.leftNameTxt_.transform)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1.leftNameTxt_.text)
				SetActive(arg_405_1.iconTrs_.gameObject, false)
				arg_405_1.callingController_:SetSelectedState("normal")

				local var_408_5 = arg_405_1:GetWordFromCfg(320061098)
				local var_408_6 = arg_405_1:FormatText(var_408_5.content)

				arg_405_1.text_.text = var_408_6

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_7 = 41
				local var_408_8 = utf8.len(var_408_6)
				local var_408_9 = var_408_7 <= 0 and var_408_3 or var_408_3 * (var_408_8 / var_408_7)

				if var_408_9 > 0 and var_408_3 < var_408_9 then
					arg_405_1.talkMaxDuration = var_408_9

					if var_408_9 + var_408_2 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_9 + var_408_2
					end
				end

				arg_405_1.text_.text = var_408_6
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320061", "320061098", "story_v_out_320061.awb") ~= 0 then
					local var_408_10 = manager.audio:GetVoiceLength("story_v_out_320061", "320061098", "story_v_out_320061.awb") / 1000

					if var_408_10 + var_408_2 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_10 + var_408_2
					end

					if var_408_5.prefab_name ~= "" and arg_405_1.actors_[var_408_5.prefab_name] ~= nil then
						local var_408_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_405_1.actors_[var_408_5.prefab_name].transform, "story_v_out_320061", "320061098", "story_v_out_320061.awb")

						arg_405_1:RecordAudio("320061098", var_408_11)
						arg_405_1:RecordAudio("320061098", var_408_11)
					else
						arg_405_1:AudioAction("play", "voice", "story_v_out_320061", "320061098", "story_v_out_320061.awb")
					end

					arg_405_1:RecordHistoryTalkVoice("story_v_out_320061", "320061098", "story_v_out_320061.awb")
				end

				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_12 = math.max(var_408_3, arg_405_1.talkMaxDuration)

			if var_408_2 <= arg_405_1.time_ and arg_405_1.time_ < var_408_2 + var_408_12 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - var_408_2) / var_408_12

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= var_408_2 + var_408_12 and arg_405_1.time_ < var_408_2 + var_408_12 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {}

		arg_405_1:InitPlayNodeList()
	end,
	Play320061099 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 320061099
		arg_409_1.duration_ = 5

		SetActive(arg_409_1.tipsGo_, false)

		function arg_409_1.onSingleLineFinish_()
			arg_409_1.onSingleLineUpdate_ = nil
			arg_409_1.onSingleLineFinish_ = nil
			arg_409_1.state_ = "waiting"
		end

		function arg_409_1.playNext_(arg_411_0)
			if arg_411_0 == 1 then
				arg_409_0:Play320061100(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			local var_412_0 = arg_409_1.actors_["1020ui_story"].transform
			local var_412_1 = 0

			if var_412_1 < arg_409_1.time_ and arg_409_1.time_ <= var_412_1 + arg_412_0 then
				arg_409_1.var_.moveOldPos1020ui_story = var_412_0.localPosition
			end

			local var_412_2 = 0.001

			if var_412_1 <= arg_409_1.time_ and arg_409_1.time_ < var_412_1 + var_412_2 then
				local var_412_3 = (arg_409_1.time_ - var_412_1) / var_412_2
				local var_412_4 = Vector3.New(0, 100, 0)

				var_412_0.localPosition = Vector3.Lerp(arg_409_1.var_.moveOldPos1020ui_story, var_412_4, var_412_3)

				local var_412_5 = manager.ui.mainCamera.transform.position - var_412_0.position

				var_412_0.forward = Vector3.New(var_412_5.x, var_412_5.y, var_412_5.z)

				local var_412_6 = var_412_0.localEulerAngles

				var_412_6.z = 0
				var_412_6.x = 0
				var_412_0.localEulerAngles = var_412_6
			end

			if arg_409_1.time_ >= var_412_1 + var_412_2 and arg_409_1.time_ < var_412_1 + var_412_2 + arg_412_0 then
				var_412_0.localPosition = Vector3.New(0, 100, 0)

				local var_412_7 = manager.ui.mainCamera.transform.position - var_412_0.position

				var_412_0.forward = Vector3.New(var_412_7.x, var_412_7.y, var_412_7.z)

				local var_412_8 = var_412_0.localEulerAngles

				var_412_8.z = 0
				var_412_8.x = 0
				var_412_0.localEulerAngles = var_412_8
			end

			local var_412_9 = arg_409_1.actors_["1020ui_story"]
			local var_412_10 = 0

			if var_412_10 < arg_409_1.time_ and arg_409_1.time_ <= var_412_10 + arg_412_0 and not isNil(var_412_9) and arg_409_1.var_.characterEffect1020ui_story == nil then
				arg_409_1.var_.characterEffect1020ui_story = var_412_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_412_11 = 0.200000002980232

			if var_412_10 <= arg_409_1.time_ and arg_409_1.time_ < var_412_10 + var_412_11 and not isNil(var_412_9) then
				local var_412_12 = (arg_409_1.time_ - var_412_10) / var_412_11

				if arg_409_1.var_.characterEffect1020ui_story and not isNil(var_412_9) then
					local var_412_13 = Mathf.Lerp(0, 0.5, var_412_12)

					arg_409_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_409_1.var_.characterEffect1020ui_story.fillRatio = var_412_13
				end
			end

			if arg_409_1.time_ >= var_412_10 + var_412_11 and arg_409_1.time_ < var_412_10 + var_412_11 + arg_412_0 and not isNil(var_412_9) and arg_409_1.var_.characterEffect1020ui_story then
				local var_412_14 = 0.5

				arg_409_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_409_1.var_.characterEffect1020ui_story.fillRatio = var_412_14
			end

			local var_412_15 = arg_409_1.actors_["1089ui_story"].transform
			local var_412_16 = 0

			if var_412_16 < arg_409_1.time_ and arg_409_1.time_ <= var_412_16 + arg_412_0 then
				arg_409_1.var_.moveOldPos1089ui_story = var_412_15.localPosition
			end

			local var_412_17 = 0.001

			if var_412_16 <= arg_409_1.time_ and arg_409_1.time_ < var_412_16 + var_412_17 then
				local var_412_18 = (arg_409_1.time_ - var_412_16) / var_412_17
				local var_412_19 = Vector3.New(0, 100, 0)

				var_412_15.localPosition = Vector3.Lerp(arg_409_1.var_.moveOldPos1089ui_story, var_412_19, var_412_18)

				local var_412_20 = manager.ui.mainCamera.transform.position - var_412_15.position

				var_412_15.forward = Vector3.New(var_412_20.x, var_412_20.y, var_412_20.z)

				local var_412_21 = var_412_15.localEulerAngles

				var_412_21.z = 0
				var_412_21.x = 0
				var_412_15.localEulerAngles = var_412_21
			end

			if arg_409_1.time_ >= var_412_16 + var_412_17 and arg_409_1.time_ < var_412_16 + var_412_17 + arg_412_0 then
				var_412_15.localPosition = Vector3.New(0, 100, 0)

				local var_412_22 = manager.ui.mainCamera.transform.position - var_412_15.position

				var_412_15.forward = Vector3.New(var_412_22.x, var_412_22.y, var_412_22.z)

				local var_412_23 = var_412_15.localEulerAngles

				var_412_23.z = 0
				var_412_23.x = 0
				var_412_15.localEulerAngles = var_412_23
			end

			local var_412_24 = arg_409_1.actors_["1020ui_story"]
			local var_412_25 = 0

			if var_412_25 < arg_409_1.time_ and arg_409_1.time_ <= var_412_25 + arg_412_0 and not isNil(var_412_24) and arg_409_1.var_.characterEffect1020ui_story == nil then
				arg_409_1.var_.characterEffect1020ui_story = var_412_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_412_26 = 0.200000002980232

			if var_412_25 <= arg_409_1.time_ and arg_409_1.time_ < var_412_25 + var_412_26 and not isNil(var_412_24) then
				local var_412_27 = (arg_409_1.time_ - var_412_25) / var_412_26

				if arg_409_1.var_.characterEffect1020ui_story and not isNil(var_412_24) then
					local var_412_28 = Mathf.Lerp(0, 0.5, var_412_27)

					arg_409_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_409_1.var_.characterEffect1020ui_story.fillRatio = var_412_28
				end
			end

			if arg_409_1.time_ >= var_412_25 + var_412_26 and arg_409_1.time_ < var_412_25 + var_412_26 + arg_412_0 and not isNil(var_412_24) and arg_409_1.var_.characterEffect1020ui_story then
				local var_412_29 = 0.5

				arg_409_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_409_1.var_.characterEffect1020ui_story.fillRatio = var_412_29
			end

			local var_412_30 = 0
			local var_412_31 = 1.025

			if var_412_30 < arg_409_1.time_ and arg_409_1.time_ <= var_412_30 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0
				arg_409_1.dialogCg_.alpha = 1

				arg_409_1.dialog_:SetActive(true)
				SetActive(arg_409_1.leftNameGo_, false)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_409_1.iconTrs_.gameObject, false)
				arg_409_1.callingController_:SetSelectedState("normal")

				local var_412_32 = arg_409_1:GetWordFromCfg(320061099)
				local var_412_33 = arg_409_1:FormatText(var_412_32.content)

				arg_409_1.text_.text = var_412_33

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_34 = 41
				local var_412_35 = utf8.len(var_412_33)
				local var_412_36 = var_412_34 <= 0 and var_412_31 or var_412_31 * (var_412_35 / var_412_34)

				if var_412_36 > 0 and var_412_31 < var_412_36 then
					arg_409_1.talkMaxDuration = var_412_36

					if var_412_36 + var_412_30 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_36 + var_412_30
					end
				end

				arg_409_1.text_.text = var_412_33
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)
				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_37 = math.max(var_412_31, arg_409_1.talkMaxDuration)

			if var_412_30 <= arg_409_1.time_ and arg_409_1.time_ < var_412_30 + var_412_37 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - var_412_30) / var_412_37

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= var_412_30 + var_412_37 and arg_409_1.time_ < var_412_30 + var_412_37 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
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

		arg_409_1:InitPlayNodeList()
	end,
	Play320061100 = function(arg_413_0, arg_413_1)
		arg_413_1.time_ = 0
		arg_413_1.frameCnt_ = 0
		arg_413_1.state_ = "playing"
		arg_413_1.curTalkId_ = 320061100
		arg_413_1.duration_ = 15.37

		local var_413_0 = {
			zh = 10.266,
			ja = 15.366
		}
		local var_413_1 = manager.audio:GetLocalizationFlag()

		if var_413_0[var_413_1] ~= nil then
			arg_413_1.duration_ = var_413_0[var_413_1]
		end

		SetActive(arg_413_1.tipsGo_, false)

		function arg_413_1.onSingleLineFinish_()
			arg_413_1.onSingleLineUpdate_ = nil
			arg_413_1.onSingleLineFinish_ = nil
			arg_413_1.state_ = "waiting"
		end

		function arg_413_1.playNext_(arg_415_0)
			if arg_415_0 == 1 then
				arg_413_0:Play320061101(arg_413_1)
			end
		end

		function arg_413_1.onSingleLineUpdate_(arg_416_0)
			local var_416_0 = arg_413_1.actors_["1089ui_story"].transform
			local var_416_1 = 0

			if var_416_1 < arg_413_1.time_ and arg_413_1.time_ <= var_416_1 + arg_416_0 then
				arg_413_1.var_.moveOldPos1089ui_story = var_416_0.localPosition
			end

			local var_416_2 = 0.001

			if var_416_1 <= arg_413_1.time_ and arg_413_1.time_ < var_416_1 + var_416_2 then
				local var_416_3 = (arg_413_1.time_ - var_416_1) / var_416_2
				local var_416_4 = Vector3.New(0, -1.1, -6.17)

				var_416_0.localPosition = Vector3.Lerp(arg_413_1.var_.moveOldPos1089ui_story, var_416_4, var_416_3)

				local var_416_5 = manager.ui.mainCamera.transform.position - var_416_0.position

				var_416_0.forward = Vector3.New(var_416_5.x, var_416_5.y, var_416_5.z)

				local var_416_6 = var_416_0.localEulerAngles

				var_416_6.z = 0
				var_416_6.x = 0
				var_416_0.localEulerAngles = var_416_6
			end

			if arg_413_1.time_ >= var_416_1 + var_416_2 and arg_413_1.time_ < var_416_1 + var_416_2 + arg_416_0 then
				var_416_0.localPosition = Vector3.New(0, -1.1, -6.17)

				local var_416_7 = manager.ui.mainCamera.transform.position - var_416_0.position

				var_416_0.forward = Vector3.New(var_416_7.x, var_416_7.y, var_416_7.z)

				local var_416_8 = var_416_0.localEulerAngles

				var_416_8.z = 0
				var_416_8.x = 0
				var_416_0.localEulerAngles = var_416_8
			end

			local var_416_9 = arg_413_1.actors_["1089ui_story"]
			local var_416_10 = 0

			if var_416_10 < arg_413_1.time_ and arg_413_1.time_ <= var_416_10 + arg_416_0 and not isNil(var_416_9) and arg_413_1.var_.characterEffect1089ui_story == nil then
				arg_413_1.var_.characterEffect1089ui_story = var_416_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_416_11 = 0.200000002980232

			if var_416_10 <= arg_413_1.time_ and arg_413_1.time_ < var_416_10 + var_416_11 and not isNil(var_416_9) then
				local var_416_12 = (arg_413_1.time_ - var_416_10) / var_416_11

				if arg_413_1.var_.characterEffect1089ui_story and not isNil(var_416_9) then
					arg_413_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_413_1.time_ >= var_416_10 + var_416_11 and arg_413_1.time_ < var_416_10 + var_416_11 + arg_416_0 and not isNil(var_416_9) and arg_413_1.var_.characterEffect1089ui_story then
				arg_413_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_416_13 = 0

			if var_416_13 < arg_413_1.time_ and arg_413_1.time_ <= var_416_13 + arg_416_0 then
				arg_413_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action2_1")
			end

			local var_416_14 = 0

			if var_416_14 < arg_413_1.time_ and arg_413_1.time_ <= var_416_14 + arg_416_0 then
				arg_413_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_416_15 = 0
			local var_416_16 = 1.1

			if var_416_15 < arg_413_1.time_ and arg_413_1.time_ <= var_416_15 + arg_416_0 then
				arg_413_1.talkMaxDuration = 0
				arg_413_1.dialogCg_.alpha = 1

				arg_413_1.dialog_:SetActive(true)
				SetActive(arg_413_1.leftNameGo_, true)

				local var_416_17 = arg_413_1:FormatText(StoryNameCfg[1031].name)

				arg_413_1.leftNameTxt_.text = var_416_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_413_1.leftNameTxt_.transform)

				arg_413_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_413_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_413_1:RecordName(arg_413_1.leftNameTxt_.text)
				SetActive(arg_413_1.iconTrs_.gameObject, false)
				arg_413_1.callingController_:SetSelectedState("normal")

				local var_416_18 = arg_413_1:GetWordFromCfg(320061100)
				local var_416_19 = arg_413_1:FormatText(var_416_18.content)

				arg_413_1.text_.text = var_416_19

				LuaForUtil.ClearLinePrefixSymbol(arg_413_1.text_)

				local var_416_20 = 44
				local var_416_21 = utf8.len(var_416_19)
				local var_416_22 = var_416_20 <= 0 and var_416_16 or var_416_16 * (var_416_21 / var_416_20)

				if var_416_22 > 0 and var_416_16 < var_416_22 then
					arg_413_1.talkMaxDuration = var_416_22

					if var_416_22 + var_416_15 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_22 + var_416_15
					end
				end

				arg_413_1.text_.text = var_416_19
				arg_413_1.typewritter.percent = 0

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320061", "320061100", "story_v_out_320061.awb") ~= 0 then
					local var_416_23 = manager.audio:GetVoiceLength("story_v_out_320061", "320061100", "story_v_out_320061.awb") / 1000

					if var_416_23 + var_416_15 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_23 + var_416_15
					end

					if var_416_18.prefab_name ~= "" and arg_413_1.actors_[var_416_18.prefab_name] ~= nil then
						local var_416_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_413_1.actors_[var_416_18.prefab_name].transform, "story_v_out_320061", "320061100", "story_v_out_320061.awb")

						arg_413_1:RecordAudio("320061100", var_416_24)
						arg_413_1:RecordAudio("320061100", var_416_24)
					else
						arg_413_1:AudioAction("play", "voice", "story_v_out_320061", "320061100", "story_v_out_320061.awb")
					end

					arg_413_1:RecordHistoryTalkVoice("story_v_out_320061", "320061100", "story_v_out_320061.awb")
				end

				arg_413_1:RecordContent(arg_413_1.text_.text)
			end

			local var_416_25 = math.max(var_416_16, arg_413_1.talkMaxDuration)

			if var_416_15 <= arg_413_1.time_ and arg_413_1.time_ < var_416_15 + var_416_25 then
				arg_413_1.typewritter.percent = (arg_413_1.time_ - var_416_15) / var_416_25

				arg_413_1.typewritter:SetDirty()
			end

			if arg_413_1.time_ >= var_416_15 + var_416_25 and arg_413_1.time_ < var_416_15 + var_416_25 + arg_416_0 then
				arg_413_1.typewritter.percent = 1

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(true)
			end
		end

		arg_413_1.nodeConfigList_ = {
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

		arg_413_1:InitPlayNodeList()
	end,
	Play320061101 = function(arg_417_0, arg_417_1)
		arg_417_1.time_ = 0
		arg_417_1.frameCnt_ = 0
		arg_417_1.state_ = "playing"
		arg_417_1.curTalkId_ = 320061101
		arg_417_1.duration_ = 5

		SetActive(arg_417_1.tipsGo_, false)

		function arg_417_1.onSingleLineFinish_()
			arg_417_1.onSingleLineUpdate_ = nil
			arg_417_1.onSingleLineFinish_ = nil
			arg_417_1.state_ = "waiting"
		end

		function arg_417_1.playNext_(arg_419_0)
			if arg_419_0 == 1 then
				arg_417_0:Play320061102(arg_417_1)
			end
		end

		function arg_417_1.onSingleLineUpdate_(arg_420_0)
			local var_420_0 = arg_417_1.actors_["1089ui_story"]
			local var_420_1 = 0

			if var_420_1 < arg_417_1.time_ and arg_417_1.time_ <= var_420_1 + arg_420_0 and not isNil(var_420_0) and arg_417_1.var_.characterEffect1089ui_story == nil then
				arg_417_1.var_.characterEffect1089ui_story = var_420_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_420_2 = 0.200000002980232

			if var_420_1 <= arg_417_1.time_ and arg_417_1.time_ < var_420_1 + var_420_2 and not isNil(var_420_0) then
				local var_420_3 = (arg_417_1.time_ - var_420_1) / var_420_2

				if arg_417_1.var_.characterEffect1089ui_story and not isNil(var_420_0) then
					local var_420_4 = Mathf.Lerp(0, 0.5, var_420_3)

					arg_417_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_417_1.var_.characterEffect1089ui_story.fillRatio = var_420_4
				end
			end

			if arg_417_1.time_ >= var_420_1 + var_420_2 and arg_417_1.time_ < var_420_1 + var_420_2 + arg_420_0 and not isNil(var_420_0) and arg_417_1.var_.characterEffect1089ui_story then
				local var_420_5 = 0.5

				arg_417_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_417_1.var_.characterEffect1089ui_story.fillRatio = var_420_5
			end

			local var_420_6 = 0
			local var_420_7 = 0.25

			if var_420_6 < arg_417_1.time_ and arg_417_1.time_ <= var_420_6 + arg_420_0 then
				arg_417_1.talkMaxDuration = 0
				arg_417_1.dialogCg_.alpha = 1

				arg_417_1.dialog_:SetActive(true)
				SetActive(arg_417_1.leftNameGo_, true)

				local var_420_8 = arg_417_1:FormatText(StoryNameCfg[7].name)

				arg_417_1.leftNameTxt_.text = var_420_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_417_1.leftNameTxt_.transform)

				arg_417_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_417_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_417_1:RecordName(arg_417_1.leftNameTxt_.text)
				SetActive(arg_417_1.iconTrs_.gameObject, true)
				arg_417_1.iconController_:SetSelectedState("hero")

				arg_417_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_417_1.callingController_:SetSelectedState("normal")

				arg_417_1.keyicon_.color = Color.New(1, 1, 1)
				arg_417_1.icon_.color = Color.New(1, 1, 1)

				local var_420_9 = arg_417_1:GetWordFromCfg(320061101)
				local var_420_10 = arg_417_1:FormatText(var_420_9.content)

				arg_417_1.text_.text = var_420_10

				LuaForUtil.ClearLinePrefixSymbol(arg_417_1.text_)

				local var_420_11 = 10
				local var_420_12 = utf8.len(var_420_10)
				local var_420_13 = var_420_11 <= 0 and var_420_7 or var_420_7 * (var_420_12 / var_420_11)

				if var_420_13 > 0 and var_420_7 < var_420_13 then
					arg_417_1.talkMaxDuration = var_420_13

					if var_420_13 + var_420_6 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_13 + var_420_6
					end
				end

				arg_417_1.text_.text = var_420_10
				arg_417_1.typewritter.percent = 0

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(false)
				arg_417_1:RecordContent(arg_417_1.text_.text)
			end

			local var_420_14 = math.max(var_420_7, arg_417_1.talkMaxDuration)

			if var_420_6 <= arg_417_1.time_ and arg_417_1.time_ < var_420_6 + var_420_14 then
				arg_417_1.typewritter.percent = (arg_417_1.time_ - var_420_6) / var_420_14

				arg_417_1.typewritter:SetDirty()
			end

			if arg_417_1.time_ >= var_420_6 + var_420_14 and arg_417_1.time_ < var_420_6 + var_420_14 + arg_420_0 then
				arg_417_1.typewritter.percent = 1

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(true)
			end
		end

		arg_417_1.nodeConfigList_ = {}

		arg_417_1:InitPlayNodeList()
	end,
	Play320061102 = function(arg_421_0, arg_421_1)
		arg_421_1.time_ = 0
		arg_421_1.frameCnt_ = 0
		arg_421_1.state_ = "playing"
		arg_421_1.curTalkId_ = 320061102
		arg_421_1.duration_ = 9

		SetActive(arg_421_1.tipsGo_, false)

		function arg_421_1.onSingleLineFinish_()
			arg_421_1.onSingleLineUpdate_ = nil
			arg_421_1.onSingleLineFinish_ = nil
			arg_421_1.state_ = "waiting"
		end

		function arg_421_1.playNext_(arg_423_0)
			if arg_423_0 == 1 then
				arg_421_0:Play320061103(arg_421_1)
			end
		end

		function arg_421_1.onSingleLineUpdate_(arg_424_0)
			local var_424_0 = "ST12"

			if arg_421_1.bgs_[var_424_0] == nil then
				local var_424_1 = Object.Instantiate(arg_421_1.paintGo_)

				var_424_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_424_0)
				var_424_1.name = var_424_0
				var_424_1.transform.parent = arg_421_1.stage_.transform
				var_424_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_421_1.bgs_[var_424_0] = var_424_1
			end

			local var_424_2 = 2

			if var_424_2 < arg_421_1.time_ and arg_421_1.time_ <= var_424_2 + arg_424_0 then
				local var_424_3 = manager.ui.mainCamera.transform.localPosition
				local var_424_4 = Vector3.New(0, 0, 10) + Vector3.New(var_424_3.x, var_424_3.y, 0)
				local var_424_5 = arg_421_1.bgs_.ST12

				var_424_5.transform.localPosition = var_424_4
				var_424_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_424_6 = var_424_5:GetComponent("SpriteRenderer")

				if var_424_6 and var_424_6.sprite then
					local var_424_7 = (var_424_5.transform.localPosition - var_424_3).z
					local var_424_8 = manager.ui.mainCameraCom_
					local var_424_9 = 2 * var_424_7 * Mathf.Tan(var_424_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_424_10 = var_424_9 * var_424_8.aspect
					local var_424_11 = var_424_6.sprite.bounds.size.x
					local var_424_12 = var_424_6.sprite.bounds.size.y
					local var_424_13 = var_424_10 / var_424_11
					local var_424_14 = var_424_9 / var_424_12
					local var_424_15 = var_424_14 < var_424_13 and var_424_13 or var_424_14

					var_424_5.transform.localScale = Vector3.New(var_424_15, var_424_15, 0)
				end

				for iter_424_0, iter_424_1 in pairs(arg_421_1.bgs_) do
					if iter_424_0 ~= "ST12" then
						iter_424_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_424_16 = 4

			if var_424_16 < arg_421_1.time_ and arg_421_1.time_ <= var_424_16 + arg_424_0 then
				arg_421_1.allBtn_.enabled = false
			end

			local var_424_17 = 0.3

			if arg_421_1.time_ >= var_424_16 + var_424_17 and arg_421_1.time_ < var_424_16 + var_424_17 + arg_424_0 then
				arg_421_1.allBtn_.enabled = true
			end

			local var_424_18 = 0

			if var_424_18 < arg_421_1.time_ and arg_421_1.time_ <= var_424_18 + arg_424_0 then
				arg_421_1.mask_.enabled = true
				arg_421_1.mask_.raycastTarget = true

				arg_421_1:SetGaussion(false)
			end

			local var_424_19 = 2

			if var_424_18 <= arg_421_1.time_ and arg_421_1.time_ < var_424_18 + var_424_19 then
				local var_424_20 = (arg_421_1.time_ - var_424_18) / var_424_19
				local var_424_21 = Color.New(0, 0, 0)

				var_424_21.a = Mathf.Lerp(0, 1, var_424_20)
				arg_421_1.mask_.color = var_424_21
			end

			if arg_421_1.time_ >= var_424_18 + var_424_19 and arg_421_1.time_ < var_424_18 + var_424_19 + arg_424_0 then
				local var_424_22 = Color.New(0, 0, 0)

				var_424_22.a = 1
				arg_421_1.mask_.color = var_424_22
			end

			local var_424_23 = 2

			if var_424_23 < arg_421_1.time_ and arg_421_1.time_ <= var_424_23 + arg_424_0 then
				arg_421_1.mask_.enabled = true
				arg_421_1.mask_.raycastTarget = true

				arg_421_1:SetGaussion(false)
			end

			local var_424_24 = 2

			if var_424_23 <= arg_421_1.time_ and arg_421_1.time_ < var_424_23 + var_424_24 then
				local var_424_25 = (arg_421_1.time_ - var_424_23) / var_424_24
				local var_424_26 = Color.New(0, 0, 0)

				var_424_26.a = Mathf.Lerp(1, 0, var_424_25)
				arg_421_1.mask_.color = var_424_26
			end

			if arg_421_1.time_ >= var_424_23 + var_424_24 and arg_421_1.time_ < var_424_23 + var_424_24 + arg_424_0 then
				local var_424_27 = Color.New(0, 0, 0)
				local var_424_28 = 0

				arg_421_1.mask_.enabled = false
				var_424_27.a = var_424_28
				arg_421_1.mask_.color = var_424_27
			end

			local var_424_29 = arg_421_1.actors_["1089ui_story"].transform
			local var_424_30 = 1.96599999815226

			if var_424_30 < arg_421_1.time_ and arg_421_1.time_ <= var_424_30 + arg_424_0 then
				arg_421_1.var_.moveOldPos1089ui_story = var_424_29.localPosition
			end

			local var_424_31 = 0.001

			if var_424_30 <= arg_421_1.time_ and arg_421_1.time_ < var_424_30 + var_424_31 then
				local var_424_32 = (arg_421_1.time_ - var_424_30) / var_424_31
				local var_424_33 = Vector3.New(0, 100, 0)

				var_424_29.localPosition = Vector3.Lerp(arg_421_1.var_.moveOldPos1089ui_story, var_424_33, var_424_32)

				local var_424_34 = manager.ui.mainCamera.transform.position - var_424_29.position

				var_424_29.forward = Vector3.New(var_424_34.x, var_424_34.y, var_424_34.z)

				local var_424_35 = var_424_29.localEulerAngles

				var_424_35.z = 0
				var_424_35.x = 0
				var_424_29.localEulerAngles = var_424_35
			end

			if arg_421_1.time_ >= var_424_30 + var_424_31 and arg_421_1.time_ < var_424_30 + var_424_31 + arg_424_0 then
				var_424_29.localPosition = Vector3.New(0, 100, 0)

				local var_424_36 = manager.ui.mainCamera.transform.position - var_424_29.position

				var_424_29.forward = Vector3.New(var_424_36.x, var_424_36.y, var_424_36.z)

				local var_424_37 = var_424_29.localEulerAngles

				var_424_37.z = 0
				var_424_37.x = 0
				var_424_29.localEulerAngles = var_424_37
			end

			local var_424_38 = arg_421_1.actors_["1089ui_story"]
			local var_424_39 = 1.96599999815226

			if var_424_39 < arg_421_1.time_ and arg_421_1.time_ <= var_424_39 + arg_424_0 and not isNil(var_424_38) and arg_421_1.var_.characterEffect1089ui_story == nil then
				arg_421_1.var_.characterEffect1089ui_story = var_424_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_424_40 = 0.034000001847744

			if var_424_39 <= arg_421_1.time_ and arg_421_1.time_ < var_424_39 + var_424_40 and not isNil(var_424_38) then
				local var_424_41 = (arg_421_1.time_ - var_424_39) / var_424_40

				if arg_421_1.var_.characterEffect1089ui_story and not isNil(var_424_38) then
					local var_424_42 = Mathf.Lerp(0, 0.5, var_424_41)

					arg_421_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_421_1.var_.characterEffect1089ui_story.fillRatio = var_424_42
				end
			end

			if arg_421_1.time_ >= var_424_39 + var_424_40 and arg_421_1.time_ < var_424_39 + var_424_40 + arg_424_0 and not isNil(var_424_38) and arg_421_1.var_.characterEffect1089ui_story then
				local var_424_43 = 0.5

				arg_421_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_421_1.var_.characterEffect1089ui_story.fillRatio = var_424_43
			end

			local var_424_44 = 2

			arg_421_1.isInRecall_ = false

			if var_424_44 < arg_421_1.time_ and arg_421_1.time_ <= var_424_44 + arg_424_0 then
				arg_421_1.screenFilterGo_:SetActive(true)

				arg_421_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")

				for iter_424_2, iter_424_3 in pairs(arg_421_1.actors_) do
					local var_424_45 = iter_424_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_424_4, iter_424_5 in ipairs(var_424_45) do
						if iter_424_5.color.r > 0.51 then
							iter_424_5.color = Color.New(1, 1, 1)
						else
							iter_424_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_424_46 = 0.2

			if var_424_44 <= arg_421_1.time_ and arg_421_1.time_ < var_424_44 + var_424_46 then
				local var_424_47 = (arg_421_1.time_ - var_424_44) / var_424_46

				arg_421_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, var_424_47)
			end

			if arg_421_1.time_ >= var_424_44 + var_424_46 and arg_421_1.time_ < var_424_44 + var_424_46 + arg_424_0 then
				arg_421_1.screenFilterEffect_.weight = 1
			end

			if arg_421_1.frameCnt_ <= 1 then
				arg_421_1.dialog_:SetActive(false)
			end

			local var_424_48 = 4
			local var_424_49 = 0.625

			if var_424_48 < arg_421_1.time_ and arg_421_1.time_ <= var_424_48 + arg_424_0 then
				arg_421_1.talkMaxDuration = 0

				arg_421_1.dialog_:SetActive(true)

				arg_421_1.dialogCg_.alpha = 0

				local var_424_50 = LeanTween.value(arg_421_1.dialog_, 0, 1, 0.3)

				var_424_50:setOnUpdate(LuaHelper.FloatAction(function(arg_425_0)
					arg_421_1.dialogCg_.alpha = arg_425_0
				end))
				var_424_50:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_421_1.dialog_)
					var_424_50:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_421_1.duration_ = arg_421_1.duration_ + 0.3

				SetActive(arg_421_1.leftNameGo_, true)

				local var_424_51 = arg_421_1:FormatText(StoryNameCfg[7].name)

				arg_421_1.leftNameTxt_.text = var_424_51

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_421_1.leftNameTxt_.transform)

				arg_421_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_421_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_421_1:RecordName(arg_421_1.leftNameTxt_.text)
				SetActive(arg_421_1.iconTrs_.gameObject, true)
				arg_421_1.iconController_:SetSelectedState("hero")

				arg_421_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_421_1.callingController_:SetSelectedState("normal")

				arg_421_1.keyicon_.color = Color.New(1, 1, 1)
				arg_421_1.icon_.color = Color.New(1, 1, 1)

				local var_424_52 = arg_421_1:GetWordFromCfg(320061102)
				local var_424_53 = arg_421_1:FormatText(var_424_52.content)

				arg_421_1.text_.text = var_424_53

				LuaForUtil.ClearLinePrefixSymbol(arg_421_1.text_)

				local var_424_54 = 25
				local var_424_55 = utf8.len(var_424_53)
				local var_424_56 = var_424_54 <= 0 and var_424_49 or var_424_49 * (var_424_55 / var_424_54)

				if var_424_56 > 0 and var_424_49 < var_424_56 then
					arg_421_1.talkMaxDuration = var_424_56
					var_424_48 = var_424_48 + 0.3

					if var_424_56 + var_424_48 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_56 + var_424_48
					end
				end

				arg_421_1.text_.text = var_424_53
				arg_421_1.typewritter.percent = 0

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(false)
				arg_421_1:RecordContent(arg_421_1.text_.text)
			end

			local var_424_57 = var_424_48 + 0.3
			local var_424_58 = math.max(var_424_49, arg_421_1.talkMaxDuration)

			if var_424_57 <= arg_421_1.time_ and arg_421_1.time_ < var_424_57 + var_424_58 then
				arg_421_1.typewritter.percent = (arg_421_1.time_ - var_424_57) / var_424_58

				arg_421_1.typewritter:SetDirty()
			end

			if arg_421_1.time_ >= var_424_57 + var_424_58 and arg_421_1.time_ < var_424_57 + var_424_58 + arg_424_0 then
				arg_421_1.typewritter.percent = 1

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(true)
			end
		end

		arg_421_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_421_1:InitPlayNodeList()
	end,
	Play320061103 = function(arg_427_0, arg_427_1)
		arg_427_1.time_ = 0
		arg_427_1.frameCnt_ = 0
		arg_427_1.state_ = "playing"
		arg_427_1.curTalkId_ = 320061103
		arg_427_1.duration_ = 12.73

		local var_427_0 = {
			zh = 9,
			ja = 12.733
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
				arg_427_0:Play320061104(arg_427_1)
			end
		end

		function arg_427_1.onSingleLineUpdate_(arg_430_0)
			local var_430_0 = "1019ui_story"

			if arg_427_1.actors_[var_430_0] == nil then
				local var_430_1 = Asset.Load("Char/" .. "1019ui_story")

				if not isNil(var_430_1) then
					local var_430_2 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_427_1.stage_.transform)

					var_430_2.name = var_430_0
					var_430_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_427_1.actors_[var_430_0] = var_430_2

					local var_430_3 = var_430_2:GetComponentInChildren(typeof(CharacterEffect))

					var_430_3.enabled = true

					local var_430_4 = GameObjectTools.GetOrAddComponent(var_430_2, typeof(DynamicBoneHelper))

					if var_430_4 then
						var_430_4:EnableDynamicBone(false)
					end

					arg_427_1:ShowWeapon(var_430_3.transform, false)

					arg_427_1.var_[var_430_0 .. "Animator"] = var_430_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_427_1.var_[var_430_0 .. "Animator"].applyRootMotion = true
					arg_427_1.var_[var_430_0 .. "LipSync"] = var_430_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_430_5 = arg_427_1.actors_["1019ui_story"].transform
			local var_430_6 = 0

			if var_430_6 < arg_427_1.time_ and arg_427_1.time_ <= var_430_6 + arg_430_0 then
				arg_427_1.var_.moveOldPos1019ui_story = var_430_5.localPosition
			end

			local var_430_7 = 0.001

			if var_430_6 <= arg_427_1.time_ and arg_427_1.time_ < var_430_6 + var_430_7 then
				local var_430_8 = (arg_427_1.time_ - var_430_6) / var_430_7
				local var_430_9 = Vector3.New(-0.2, -1.08, -5.9)

				var_430_5.localPosition = Vector3.Lerp(arg_427_1.var_.moveOldPos1019ui_story, var_430_9, var_430_8)

				local var_430_10 = manager.ui.mainCamera.transform.position - var_430_5.position

				var_430_5.forward = Vector3.New(var_430_10.x, var_430_10.y, var_430_10.z)

				local var_430_11 = var_430_5.localEulerAngles

				var_430_11.z = 0
				var_430_11.x = 0
				var_430_5.localEulerAngles = var_430_11
			end

			if arg_427_1.time_ >= var_430_6 + var_430_7 and arg_427_1.time_ < var_430_6 + var_430_7 + arg_430_0 then
				var_430_5.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_430_12 = manager.ui.mainCamera.transform.position - var_430_5.position

				var_430_5.forward = Vector3.New(var_430_12.x, var_430_12.y, var_430_12.z)

				local var_430_13 = var_430_5.localEulerAngles

				var_430_13.z = 0
				var_430_13.x = 0
				var_430_5.localEulerAngles = var_430_13
			end

			local var_430_14 = arg_427_1.actors_["1019ui_story"]
			local var_430_15 = 0

			if var_430_15 < arg_427_1.time_ and arg_427_1.time_ <= var_430_15 + arg_430_0 and not isNil(var_430_14) and arg_427_1.var_.characterEffect1019ui_story == nil then
				arg_427_1.var_.characterEffect1019ui_story = var_430_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_430_16 = 0.200000002980232

			if var_430_15 <= arg_427_1.time_ and arg_427_1.time_ < var_430_15 + var_430_16 and not isNil(var_430_14) then
				local var_430_17 = (arg_427_1.time_ - var_430_15) / var_430_16

				if arg_427_1.var_.characterEffect1019ui_story and not isNil(var_430_14) then
					arg_427_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_427_1.time_ >= var_430_15 + var_430_16 and arg_427_1.time_ < var_430_15 + var_430_16 + arg_430_0 and not isNil(var_430_14) and arg_427_1.var_.characterEffect1019ui_story then
				arg_427_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_430_18 = 0

			if var_430_18 < arg_427_1.time_ and arg_427_1.time_ <= var_430_18 + arg_430_0 then
				arg_427_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			local var_430_19 = 0

			if var_430_19 < arg_427_1.time_ and arg_427_1.time_ <= var_430_19 + arg_430_0 then
				arg_427_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_430_20 = 0
			local var_430_21 = 1.225

			if var_430_20 < arg_427_1.time_ and arg_427_1.time_ <= var_430_20 + arg_430_0 then
				arg_427_1.talkMaxDuration = 0
				arg_427_1.dialogCg_.alpha = 1

				arg_427_1.dialog_:SetActive(true)
				SetActive(arg_427_1.leftNameGo_, true)

				local var_430_22 = arg_427_1:FormatText(StoryNameCfg[13].name)

				arg_427_1.leftNameTxt_.text = var_430_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_427_1.leftNameTxt_.transform)

				arg_427_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_427_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_427_1:RecordName(arg_427_1.leftNameTxt_.text)
				SetActive(arg_427_1.iconTrs_.gameObject, false)
				arg_427_1.callingController_:SetSelectedState("normal")

				local var_430_23 = arg_427_1:GetWordFromCfg(320061103)
				local var_430_24 = arg_427_1:FormatText(var_430_23.content)

				arg_427_1.text_.text = var_430_24

				LuaForUtil.ClearLinePrefixSymbol(arg_427_1.text_)

				local var_430_25 = 49
				local var_430_26 = utf8.len(var_430_24)
				local var_430_27 = var_430_25 <= 0 and var_430_21 or var_430_21 * (var_430_26 / var_430_25)

				if var_430_27 > 0 and var_430_21 < var_430_27 then
					arg_427_1.talkMaxDuration = var_430_27

					if var_430_27 + var_430_20 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_27 + var_430_20
					end
				end

				arg_427_1.text_.text = var_430_24
				arg_427_1.typewritter.percent = 0

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320061", "320061103", "story_v_out_320061.awb") ~= 0 then
					local var_430_28 = manager.audio:GetVoiceLength("story_v_out_320061", "320061103", "story_v_out_320061.awb") / 1000

					if var_430_28 + var_430_20 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_28 + var_430_20
					end

					if var_430_23.prefab_name ~= "" and arg_427_1.actors_[var_430_23.prefab_name] ~= nil then
						local var_430_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_427_1.actors_[var_430_23.prefab_name].transform, "story_v_out_320061", "320061103", "story_v_out_320061.awb")

						arg_427_1:RecordAudio("320061103", var_430_29)
						arg_427_1:RecordAudio("320061103", var_430_29)
					else
						arg_427_1:AudioAction("play", "voice", "story_v_out_320061", "320061103", "story_v_out_320061.awb")
					end

					arg_427_1:RecordHistoryTalkVoice("story_v_out_320061", "320061103", "story_v_out_320061.awb")
				end

				arg_427_1:RecordContent(arg_427_1.text_.text)
			end

			local var_430_30 = math.max(var_430_21, arg_427_1.talkMaxDuration)

			if var_430_20 <= arg_427_1.time_ and arg_427_1.time_ < var_430_20 + var_430_30 then
				arg_427_1.typewritter.percent = (arg_427_1.time_ - var_430_20) / var_430_30

				arg_427_1.typewritter:SetDirty()
			end

			if arg_427_1.time_ >= var_430_20 + var_430_30 and arg_427_1.time_ < var_430_20 + var_430_30 + arg_430_0 then
				arg_427_1.typewritter.percent = 1

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(true)
			end
		end

		arg_427_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_427_1:InitPlayNodeList()
	end,
	Play320061104 = function(arg_431_0, arg_431_1)
		arg_431_1.time_ = 0
		arg_431_1.frameCnt_ = 0
		arg_431_1.state_ = "playing"
		arg_431_1.curTalkId_ = 320061104
		arg_431_1.duration_ = 5

		SetActive(arg_431_1.tipsGo_, false)

		function arg_431_1.onSingleLineFinish_()
			arg_431_1.onSingleLineUpdate_ = nil
			arg_431_1.onSingleLineFinish_ = nil
			arg_431_1.state_ = "waiting"
		end

		function arg_431_1.playNext_(arg_433_0)
			if arg_433_0 == 1 then
				arg_431_0:Play320061105(arg_431_1)
			end
		end

		function arg_431_1.onSingleLineUpdate_(arg_434_0)
			local var_434_0 = arg_431_1.actors_["1019ui_story"]
			local var_434_1 = 0

			if var_434_1 < arg_431_1.time_ and arg_431_1.time_ <= var_434_1 + arg_434_0 and not isNil(var_434_0) and arg_431_1.var_.characterEffect1019ui_story == nil then
				arg_431_1.var_.characterEffect1019ui_story = var_434_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_434_2 = 0.200000002980232

			if var_434_1 <= arg_431_1.time_ and arg_431_1.time_ < var_434_1 + var_434_2 and not isNil(var_434_0) then
				local var_434_3 = (arg_431_1.time_ - var_434_1) / var_434_2

				if arg_431_1.var_.characterEffect1019ui_story and not isNil(var_434_0) then
					local var_434_4 = Mathf.Lerp(0, 0.5, var_434_3)

					arg_431_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_431_1.var_.characterEffect1019ui_story.fillRatio = var_434_4
				end
			end

			if arg_431_1.time_ >= var_434_1 + var_434_2 and arg_431_1.time_ < var_434_1 + var_434_2 + arg_434_0 and not isNil(var_434_0) and arg_431_1.var_.characterEffect1019ui_story then
				local var_434_5 = 0.5

				arg_431_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_431_1.var_.characterEffect1019ui_story.fillRatio = var_434_5
			end

			local var_434_6 = 0
			local var_434_7 = 1.175

			if var_434_6 < arg_431_1.time_ and arg_431_1.time_ <= var_434_6 + arg_434_0 then
				arg_431_1.talkMaxDuration = 0
				arg_431_1.dialogCg_.alpha = 1

				arg_431_1.dialog_:SetActive(true)
				SetActive(arg_431_1.leftNameGo_, true)

				local var_434_8 = arg_431_1:FormatText(StoryNameCfg[7].name)

				arg_431_1.leftNameTxt_.text = var_434_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_431_1.leftNameTxt_.transform)

				arg_431_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_431_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_431_1:RecordName(arg_431_1.leftNameTxt_.text)
				SetActive(arg_431_1.iconTrs_.gameObject, true)
				arg_431_1.iconController_:SetSelectedState("hero")

				arg_431_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_431_1.callingController_:SetSelectedState("normal")

				arg_431_1.keyicon_.color = Color.New(1, 1, 1)
				arg_431_1.icon_.color = Color.New(1, 1, 1)

				local var_434_9 = arg_431_1:GetWordFromCfg(320061104)
				local var_434_10 = arg_431_1:FormatText(var_434_9.content)

				arg_431_1.text_.text = var_434_10

				LuaForUtil.ClearLinePrefixSymbol(arg_431_1.text_)

				local var_434_11 = 47
				local var_434_12 = utf8.len(var_434_10)
				local var_434_13 = var_434_11 <= 0 and var_434_7 or var_434_7 * (var_434_12 / var_434_11)

				if var_434_13 > 0 and var_434_7 < var_434_13 then
					arg_431_1.talkMaxDuration = var_434_13

					if var_434_13 + var_434_6 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_13 + var_434_6
					end
				end

				arg_431_1.text_.text = var_434_10
				arg_431_1.typewritter.percent = 0

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(false)
				arg_431_1:RecordContent(arg_431_1.text_.text)
			end

			local var_434_14 = math.max(var_434_7, arg_431_1.talkMaxDuration)

			if var_434_6 <= arg_431_1.time_ and arg_431_1.time_ < var_434_6 + var_434_14 then
				arg_431_1.typewritter.percent = (arg_431_1.time_ - var_434_6) / var_434_14

				arg_431_1.typewritter:SetDirty()
			end

			if arg_431_1.time_ >= var_434_6 + var_434_14 and arg_431_1.time_ < var_434_6 + var_434_14 + arg_434_0 then
				arg_431_1.typewritter.percent = 1

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(true)
			end
		end

		arg_431_1.nodeConfigList_ = {}

		arg_431_1:InitPlayNodeList()
	end,
	Play320061105 = function(arg_435_0, arg_435_1)
		arg_435_1.time_ = 0
		arg_435_1.frameCnt_ = 0
		arg_435_1.state_ = "playing"
		arg_435_1.curTalkId_ = 320061105
		arg_435_1.duration_ = 11.27

		local var_435_0 = {
			zh = 9.5,
			ja = 11.266
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
				arg_435_0:Play320061106(arg_435_1)
			end
		end

		function arg_435_1.onSingleLineUpdate_(arg_438_0)
			local var_438_0 = arg_435_1.actors_["1019ui_story"].transform
			local var_438_1 = 0

			if var_438_1 < arg_435_1.time_ and arg_435_1.time_ <= var_438_1 + arg_438_0 then
				arg_435_1.var_.moveOldPos1019ui_story = var_438_0.localPosition
			end

			local var_438_2 = 0.001

			if var_438_1 <= arg_435_1.time_ and arg_435_1.time_ < var_438_1 + var_438_2 then
				local var_438_3 = (arg_435_1.time_ - var_438_1) / var_438_2
				local var_438_4 = Vector3.New(-0.2, -1.08, -5.9)

				var_438_0.localPosition = Vector3.Lerp(arg_435_1.var_.moveOldPos1019ui_story, var_438_4, var_438_3)

				local var_438_5 = manager.ui.mainCamera.transform.position - var_438_0.position

				var_438_0.forward = Vector3.New(var_438_5.x, var_438_5.y, var_438_5.z)

				local var_438_6 = var_438_0.localEulerAngles

				var_438_6.z = 0
				var_438_6.x = 0
				var_438_0.localEulerAngles = var_438_6
			end

			if arg_435_1.time_ >= var_438_1 + var_438_2 and arg_435_1.time_ < var_438_1 + var_438_2 + arg_438_0 then
				var_438_0.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_438_7 = manager.ui.mainCamera.transform.position - var_438_0.position

				var_438_0.forward = Vector3.New(var_438_7.x, var_438_7.y, var_438_7.z)

				local var_438_8 = var_438_0.localEulerAngles

				var_438_8.z = 0
				var_438_8.x = 0
				var_438_0.localEulerAngles = var_438_8
			end

			local var_438_9 = arg_435_1.actors_["1019ui_story"]
			local var_438_10 = 0

			if var_438_10 < arg_435_1.time_ and arg_435_1.time_ <= var_438_10 + arg_438_0 and not isNil(var_438_9) and arg_435_1.var_.characterEffect1019ui_story == nil then
				arg_435_1.var_.characterEffect1019ui_story = var_438_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_438_11 = 0.200000002980232

			if var_438_10 <= arg_435_1.time_ and arg_435_1.time_ < var_438_10 + var_438_11 and not isNil(var_438_9) then
				local var_438_12 = (arg_435_1.time_ - var_438_10) / var_438_11

				if arg_435_1.var_.characterEffect1019ui_story and not isNil(var_438_9) then
					arg_435_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_435_1.time_ >= var_438_10 + var_438_11 and arg_435_1.time_ < var_438_10 + var_438_11 + arg_438_0 and not isNil(var_438_9) and arg_435_1.var_.characterEffect1019ui_story then
				arg_435_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_438_13 = 0

			if var_438_13 < arg_435_1.time_ and arg_435_1.time_ <= var_438_13 + arg_438_0 then
				arg_435_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_2")
			end

			local var_438_14 = 0

			if var_438_14 < arg_435_1.time_ and arg_435_1.time_ <= var_438_14 + arg_438_0 then
				arg_435_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_438_15 = 0
			local var_438_16 = 1.025

			if var_438_15 < arg_435_1.time_ and arg_435_1.time_ <= var_438_15 + arg_438_0 then
				arg_435_1.talkMaxDuration = 0
				arg_435_1.dialogCg_.alpha = 1

				arg_435_1.dialog_:SetActive(true)
				SetActive(arg_435_1.leftNameGo_, true)

				local var_438_17 = arg_435_1:FormatText(StoryNameCfg[13].name)

				arg_435_1.leftNameTxt_.text = var_438_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_435_1.leftNameTxt_.transform)

				arg_435_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_435_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_435_1:RecordName(arg_435_1.leftNameTxt_.text)
				SetActive(arg_435_1.iconTrs_.gameObject, false)
				arg_435_1.callingController_:SetSelectedState("normal")

				local var_438_18 = arg_435_1:GetWordFromCfg(320061105)
				local var_438_19 = arg_435_1:FormatText(var_438_18.content)

				arg_435_1.text_.text = var_438_19

				LuaForUtil.ClearLinePrefixSymbol(arg_435_1.text_)

				local var_438_20 = 41
				local var_438_21 = utf8.len(var_438_19)
				local var_438_22 = var_438_20 <= 0 and var_438_16 or var_438_16 * (var_438_21 / var_438_20)

				if var_438_22 > 0 and var_438_16 < var_438_22 then
					arg_435_1.talkMaxDuration = var_438_22

					if var_438_22 + var_438_15 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_22 + var_438_15
					end
				end

				arg_435_1.text_.text = var_438_19
				arg_435_1.typewritter.percent = 0

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320061", "320061105", "story_v_out_320061.awb") ~= 0 then
					local var_438_23 = manager.audio:GetVoiceLength("story_v_out_320061", "320061105", "story_v_out_320061.awb") / 1000

					if var_438_23 + var_438_15 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_23 + var_438_15
					end

					if var_438_18.prefab_name ~= "" and arg_435_1.actors_[var_438_18.prefab_name] ~= nil then
						local var_438_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_435_1.actors_[var_438_18.prefab_name].transform, "story_v_out_320061", "320061105", "story_v_out_320061.awb")

						arg_435_1:RecordAudio("320061105", var_438_24)
						arg_435_1:RecordAudio("320061105", var_438_24)
					else
						arg_435_1:AudioAction("play", "voice", "story_v_out_320061", "320061105", "story_v_out_320061.awb")
					end

					arg_435_1:RecordHistoryTalkVoice("story_v_out_320061", "320061105", "story_v_out_320061.awb")
				end

				arg_435_1:RecordContent(arg_435_1.text_.text)
			end

			local var_438_25 = math.max(var_438_16, arg_435_1.talkMaxDuration)

			if var_438_15 <= arg_435_1.time_ and arg_435_1.time_ < var_438_15 + var_438_25 then
				arg_435_1.typewritter.percent = (arg_435_1.time_ - var_438_15) / var_438_25

				arg_435_1.typewritter:SetDirty()
			end

			if arg_435_1.time_ >= var_438_15 + var_438_25 and arg_435_1.time_ < var_438_15 + var_438_25 + arg_438_0 then
				arg_435_1.typewritter.percent = 1

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(true)
			end
		end

		arg_435_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_435_1:InitPlayNodeList()
	end,
	Play320061106 = function(arg_439_0, arg_439_1)
		arg_439_1.time_ = 0
		arg_439_1.frameCnt_ = 0
		arg_439_1.state_ = "playing"
		arg_439_1.curTalkId_ = 320061106
		arg_439_1.duration_ = 5

		SetActive(arg_439_1.tipsGo_, false)

		function arg_439_1.onSingleLineFinish_()
			arg_439_1.onSingleLineUpdate_ = nil
			arg_439_1.onSingleLineFinish_ = nil
			arg_439_1.state_ = "waiting"
		end

		function arg_439_1.playNext_(arg_441_0)
			if arg_441_0 == 1 then
				arg_439_0:Play320061107(arg_439_1)
			end
		end

		function arg_439_1.onSingleLineUpdate_(arg_442_0)
			local var_442_0 = arg_439_1.actors_["1019ui_story"]
			local var_442_1 = 0

			if var_442_1 < arg_439_1.time_ and arg_439_1.time_ <= var_442_1 + arg_442_0 and not isNil(var_442_0) and arg_439_1.var_.characterEffect1019ui_story == nil then
				arg_439_1.var_.characterEffect1019ui_story = var_442_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_442_2 = 0.200000002980232

			if var_442_1 <= arg_439_1.time_ and arg_439_1.time_ < var_442_1 + var_442_2 and not isNil(var_442_0) then
				local var_442_3 = (arg_439_1.time_ - var_442_1) / var_442_2

				if arg_439_1.var_.characterEffect1019ui_story and not isNil(var_442_0) then
					local var_442_4 = Mathf.Lerp(0, 0.5, var_442_3)

					arg_439_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_439_1.var_.characterEffect1019ui_story.fillRatio = var_442_4
				end
			end

			if arg_439_1.time_ >= var_442_1 + var_442_2 and arg_439_1.time_ < var_442_1 + var_442_2 + arg_442_0 and not isNil(var_442_0) and arg_439_1.var_.characterEffect1019ui_story then
				local var_442_5 = 0.5

				arg_439_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_439_1.var_.characterEffect1019ui_story.fillRatio = var_442_5
			end

			local var_442_6 = 0
			local var_442_7 = 0.4

			if var_442_6 < arg_439_1.time_ and arg_439_1.time_ <= var_442_6 + arg_442_0 then
				arg_439_1.talkMaxDuration = 0
				arg_439_1.dialogCg_.alpha = 1

				arg_439_1.dialog_:SetActive(true)
				SetActive(arg_439_1.leftNameGo_, true)

				local var_442_8 = arg_439_1:FormatText(StoryNameCfg[7].name)

				arg_439_1.leftNameTxt_.text = var_442_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_439_1.leftNameTxt_.transform)

				arg_439_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_439_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_439_1:RecordName(arg_439_1.leftNameTxt_.text)
				SetActive(arg_439_1.iconTrs_.gameObject, true)
				arg_439_1.iconController_:SetSelectedState("hero")

				arg_439_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_439_1.callingController_:SetSelectedState("normal")

				arg_439_1.keyicon_.color = Color.New(1, 1, 1)
				arg_439_1.icon_.color = Color.New(1, 1, 1)

				local var_442_9 = arg_439_1:GetWordFromCfg(320061106)
				local var_442_10 = arg_439_1:FormatText(var_442_9.content)

				arg_439_1.text_.text = var_442_10

				LuaForUtil.ClearLinePrefixSymbol(arg_439_1.text_)

				local var_442_11 = 16
				local var_442_12 = utf8.len(var_442_10)
				local var_442_13 = var_442_11 <= 0 and var_442_7 or var_442_7 * (var_442_12 / var_442_11)

				if var_442_13 > 0 and var_442_7 < var_442_13 then
					arg_439_1.talkMaxDuration = var_442_13

					if var_442_13 + var_442_6 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_13 + var_442_6
					end
				end

				arg_439_1.text_.text = var_442_10
				arg_439_1.typewritter.percent = 0

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(false)
				arg_439_1:RecordContent(arg_439_1.text_.text)
			end

			local var_442_14 = math.max(var_442_7, arg_439_1.talkMaxDuration)

			if var_442_6 <= arg_439_1.time_ and arg_439_1.time_ < var_442_6 + var_442_14 then
				arg_439_1.typewritter.percent = (arg_439_1.time_ - var_442_6) / var_442_14

				arg_439_1.typewritter:SetDirty()
			end

			if arg_439_1.time_ >= var_442_6 + var_442_14 and arg_439_1.time_ < var_442_6 + var_442_14 + arg_442_0 then
				arg_439_1.typewritter.percent = 1

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(true)
			end
		end

		arg_439_1.nodeConfigList_ = {}

		arg_439_1:InitPlayNodeList()
	end,
	Play320061107 = function(arg_443_0, arg_443_1)
		arg_443_1.time_ = 0
		arg_443_1.frameCnt_ = 0
		arg_443_1.state_ = "playing"
		arg_443_1.curTalkId_ = 320061107
		arg_443_1.duration_ = 5

		SetActive(arg_443_1.tipsGo_, false)

		function arg_443_1.onSingleLineFinish_()
			arg_443_1.onSingleLineUpdate_ = nil
			arg_443_1.onSingleLineFinish_ = nil
			arg_443_1.state_ = "waiting"
		end

		function arg_443_1.playNext_(arg_445_0)
			if arg_445_0 == 1 then
				arg_443_0:Play320061108(arg_443_1)
			end
		end

		function arg_443_1.onSingleLineUpdate_(arg_446_0)
			local var_446_0 = 0
			local var_446_1 = 0.9

			if var_446_0 < arg_443_1.time_ and arg_443_1.time_ <= var_446_0 + arg_446_0 then
				arg_443_1.talkMaxDuration = 0
				arg_443_1.dialogCg_.alpha = 1

				arg_443_1.dialog_:SetActive(true)
				SetActive(arg_443_1.leftNameGo_, true)

				local var_446_2 = arg_443_1:FormatText(StoryNameCfg[7].name)

				arg_443_1.leftNameTxt_.text = var_446_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_443_1.leftNameTxt_.transform)

				arg_443_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_443_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_443_1:RecordName(arg_443_1.leftNameTxt_.text)
				SetActive(arg_443_1.iconTrs_.gameObject, true)
				arg_443_1.iconController_:SetSelectedState("hero")

				arg_443_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_443_1.callingController_:SetSelectedState("normal")

				arg_443_1.keyicon_.color = Color.New(1, 1, 1)
				arg_443_1.icon_.color = Color.New(1, 1, 1)

				local var_446_3 = arg_443_1:GetWordFromCfg(320061107)
				local var_446_4 = arg_443_1:FormatText(var_446_3.content)

				arg_443_1.text_.text = var_446_4

				LuaForUtil.ClearLinePrefixSymbol(arg_443_1.text_)

				local var_446_5 = 36
				local var_446_6 = utf8.len(var_446_4)
				local var_446_7 = var_446_5 <= 0 and var_446_1 or var_446_1 * (var_446_6 / var_446_5)

				if var_446_7 > 0 and var_446_1 < var_446_7 then
					arg_443_1.talkMaxDuration = var_446_7

					if var_446_7 + var_446_0 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_7 + var_446_0
					end
				end

				arg_443_1.text_.text = var_446_4
				arg_443_1.typewritter.percent = 0

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(false)
				arg_443_1:RecordContent(arg_443_1.text_.text)
			end

			local var_446_8 = math.max(var_446_1, arg_443_1.talkMaxDuration)

			if var_446_0 <= arg_443_1.time_ and arg_443_1.time_ < var_446_0 + var_446_8 then
				arg_443_1.typewritter.percent = (arg_443_1.time_ - var_446_0) / var_446_8

				arg_443_1.typewritter:SetDirty()
			end

			if arg_443_1.time_ >= var_446_0 + var_446_8 and arg_443_1.time_ < var_446_0 + var_446_8 + arg_446_0 then
				arg_443_1.typewritter.percent = 1

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(true)
			end
		end

		arg_443_1.nodeConfigList_ = {}

		arg_443_1:InitPlayNodeList()
	end,
	Play320061108 = function(arg_447_0, arg_447_1)
		arg_447_1.time_ = 0
		arg_447_1.frameCnt_ = 0
		arg_447_1.state_ = "playing"
		arg_447_1.curTalkId_ = 320061108
		arg_447_1.duration_ = 8.43

		local var_447_0 = {
			zh = 4.966,
			ja = 8.433
		}
		local var_447_1 = manager.audio:GetLocalizationFlag()

		if var_447_0[var_447_1] ~= nil then
			arg_447_1.duration_ = var_447_0[var_447_1]
		end

		SetActive(arg_447_1.tipsGo_, false)

		function arg_447_1.onSingleLineFinish_()
			arg_447_1.onSingleLineUpdate_ = nil
			arg_447_1.onSingleLineFinish_ = nil
			arg_447_1.state_ = "waiting"
		end

		function arg_447_1.playNext_(arg_449_0)
			if arg_449_0 == 1 then
				arg_447_0:Play320061109(arg_447_1)
			end
		end

		function arg_447_1.onSingleLineUpdate_(arg_450_0)
			local var_450_0 = arg_447_1.actors_["1019ui_story"]
			local var_450_1 = 0

			if var_450_1 < arg_447_1.time_ and arg_447_1.time_ <= var_450_1 + arg_450_0 and not isNil(var_450_0) and arg_447_1.var_.characterEffect1019ui_story == nil then
				arg_447_1.var_.characterEffect1019ui_story = var_450_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_450_2 = 0.200000002980232

			if var_450_1 <= arg_447_1.time_ and arg_447_1.time_ < var_450_1 + var_450_2 and not isNil(var_450_0) then
				local var_450_3 = (arg_447_1.time_ - var_450_1) / var_450_2

				if arg_447_1.var_.characterEffect1019ui_story and not isNil(var_450_0) then
					arg_447_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_447_1.time_ >= var_450_1 + var_450_2 and arg_447_1.time_ < var_450_1 + var_450_2 + arg_450_0 and not isNil(var_450_0) and arg_447_1.var_.characterEffect1019ui_story then
				arg_447_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_450_4 = 0

			if var_450_4 < arg_447_1.time_ and arg_447_1.time_ <= var_450_4 + arg_450_0 then
				arg_447_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			local var_450_5 = 0

			if var_450_5 < arg_447_1.time_ and arg_447_1.time_ <= var_450_5 + arg_450_0 then
				arg_447_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_450_6 = 0
			local var_450_7 = 0.825

			if var_450_6 < arg_447_1.time_ and arg_447_1.time_ <= var_450_6 + arg_450_0 then
				arg_447_1.talkMaxDuration = 0
				arg_447_1.dialogCg_.alpha = 1

				arg_447_1.dialog_:SetActive(true)
				SetActive(arg_447_1.leftNameGo_, true)

				local var_450_8 = arg_447_1:FormatText(StoryNameCfg[13].name)

				arg_447_1.leftNameTxt_.text = var_450_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_447_1.leftNameTxt_.transform)

				arg_447_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_447_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_447_1:RecordName(arg_447_1.leftNameTxt_.text)
				SetActive(arg_447_1.iconTrs_.gameObject, false)
				arg_447_1.callingController_:SetSelectedState("normal")

				local var_450_9 = arg_447_1:GetWordFromCfg(320061108)
				local var_450_10 = arg_447_1:FormatText(var_450_9.content)

				arg_447_1.text_.text = var_450_10

				LuaForUtil.ClearLinePrefixSymbol(arg_447_1.text_)

				local var_450_11 = 33
				local var_450_12 = utf8.len(var_450_10)
				local var_450_13 = var_450_11 <= 0 and var_450_7 or var_450_7 * (var_450_12 / var_450_11)

				if var_450_13 > 0 and var_450_7 < var_450_13 then
					arg_447_1.talkMaxDuration = var_450_13

					if var_450_13 + var_450_6 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_13 + var_450_6
					end
				end

				arg_447_1.text_.text = var_450_10
				arg_447_1.typewritter.percent = 0

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320061", "320061108", "story_v_out_320061.awb") ~= 0 then
					local var_450_14 = manager.audio:GetVoiceLength("story_v_out_320061", "320061108", "story_v_out_320061.awb") / 1000

					if var_450_14 + var_450_6 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_14 + var_450_6
					end

					if var_450_9.prefab_name ~= "" and arg_447_1.actors_[var_450_9.prefab_name] ~= nil then
						local var_450_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_447_1.actors_[var_450_9.prefab_name].transform, "story_v_out_320061", "320061108", "story_v_out_320061.awb")

						arg_447_1:RecordAudio("320061108", var_450_15)
						arg_447_1:RecordAudio("320061108", var_450_15)
					else
						arg_447_1:AudioAction("play", "voice", "story_v_out_320061", "320061108", "story_v_out_320061.awb")
					end

					arg_447_1:RecordHistoryTalkVoice("story_v_out_320061", "320061108", "story_v_out_320061.awb")
				end

				arg_447_1:RecordContent(arg_447_1.text_.text)
			end

			local var_450_16 = math.max(var_450_7, arg_447_1.talkMaxDuration)

			if var_450_6 <= arg_447_1.time_ and arg_447_1.time_ < var_450_6 + var_450_16 then
				arg_447_1.typewritter.percent = (arg_447_1.time_ - var_450_6) / var_450_16

				arg_447_1.typewritter:SetDirty()
			end

			if arg_447_1.time_ >= var_450_6 + var_450_16 and arg_447_1.time_ < var_450_6 + var_450_16 + arg_450_0 then
				arg_447_1.typewritter.percent = 1

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(true)
			end
		end

		arg_447_1.nodeConfigList_ = {}

		arg_447_1:InitPlayNodeList()
	end,
	Play320061109 = function(arg_451_0, arg_451_1)
		arg_451_1.time_ = 0
		arg_451_1.frameCnt_ = 0
		arg_451_1.state_ = "playing"
		arg_451_1.curTalkId_ = 320061109
		arg_451_1.duration_ = 8.73

		local var_451_0 = {
			zh = 6.133,
			ja = 8.733
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
				arg_451_0:Play320061110(arg_451_1)
			end
		end

		function arg_451_1.onSingleLineUpdate_(arg_454_0)
			local var_454_0 = 0

			if var_454_0 < arg_451_1.time_ and arg_451_1.time_ <= var_454_0 + arg_454_0 then
				arg_451_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_454_1 = 0
			local var_454_2 = 0.775

			if var_454_1 < arg_451_1.time_ and arg_451_1.time_ <= var_454_1 + arg_454_0 then
				arg_451_1.talkMaxDuration = 0
				arg_451_1.dialogCg_.alpha = 1

				arg_451_1.dialog_:SetActive(true)
				SetActive(arg_451_1.leftNameGo_, true)

				local var_454_3 = arg_451_1:FormatText(StoryNameCfg[13].name)

				arg_451_1.leftNameTxt_.text = var_454_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_451_1.leftNameTxt_.transform)

				arg_451_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_451_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_451_1:RecordName(arg_451_1.leftNameTxt_.text)
				SetActive(arg_451_1.iconTrs_.gameObject, false)
				arg_451_1.callingController_:SetSelectedState("normal")

				local var_454_4 = arg_451_1:GetWordFromCfg(320061109)
				local var_454_5 = arg_451_1:FormatText(var_454_4.content)

				arg_451_1.text_.text = var_454_5

				LuaForUtil.ClearLinePrefixSymbol(arg_451_1.text_)

				local var_454_6 = 31
				local var_454_7 = utf8.len(var_454_5)
				local var_454_8 = var_454_6 <= 0 and var_454_2 or var_454_2 * (var_454_7 / var_454_6)

				if var_454_8 > 0 and var_454_2 < var_454_8 then
					arg_451_1.talkMaxDuration = var_454_8

					if var_454_8 + var_454_1 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_8 + var_454_1
					end
				end

				arg_451_1.text_.text = var_454_5
				arg_451_1.typewritter.percent = 0

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320061", "320061109", "story_v_out_320061.awb") ~= 0 then
					local var_454_9 = manager.audio:GetVoiceLength("story_v_out_320061", "320061109", "story_v_out_320061.awb") / 1000

					if var_454_9 + var_454_1 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_9 + var_454_1
					end

					if var_454_4.prefab_name ~= "" and arg_451_1.actors_[var_454_4.prefab_name] ~= nil then
						local var_454_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_451_1.actors_[var_454_4.prefab_name].transform, "story_v_out_320061", "320061109", "story_v_out_320061.awb")

						arg_451_1:RecordAudio("320061109", var_454_10)
						arg_451_1:RecordAudio("320061109", var_454_10)
					else
						arg_451_1:AudioAction("play", "voice", "story_v_out_320061", "320061109", "story_v_out_320061.awb")
					end

					arg_451_1:RecordHistoryTalkVoice("story_v_out_320061", "320061109", "story_v_out_320061.awb")
				end

				arg_451_1:RecordContent(arg_451_1.text_.text)
			end

			local var_454_11 = math.max(var_454_2, arg_451_1.talkMaxDuration)

			if var_454_1 <= arg_451_1.time_ and arg_451_1.time_ < var_454_1 + var_454_11 then
				arg_451_1.typewritter.percent = (arg_451_1.time_ - var_454_1) / var_454_11

				arg_451_1.typewritter:SetDirty()
			end

			if arg_451_1.time_ >= var_454_1 + var_454_11 and arg_451_1.time_ < var_454_1 + var_454_11 + arg_454_0 then
				arg_451_1.typewritter.percent = 1

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(true)
			end
		end

		arg_451_1.nodeConfigList_ = {}

		arg_451_1:InitPlayNodeList()
	end,
	Play320061110 = function(arg_455_0, arg_455_1)
		arg_455_1.time_ = 0
		arg_455_1.frameCnt_ = 0
		arg_455_1.state_ = "playing"
		arg_455_1.curTalkId_ = 320061110
		arg_455_1.duration_ = 5

		SetActive(arg_455_1.tipsGo_, false)

		function arg_455_1.onSingleLineFinish_()
			arg_455_1.onSingleLineUpdate_ = nil
			arg_455_1.onSingleLineFinish_ = nil
			arg_455_1.state_ = "waiting"
		end

		function arg_455_1.playNext_(arg_457_0)
			if arg_457_0 == 1 then
				arg_455_0:Play320061111(arg_455_1)
			end
		end

		function arg_455_1.onSingleLineUpdate_(arg_458_0)
			local var_458_0 = arg_455_1.actors_["1019ui_story"]
			local var_458_1 = 0

			if var_458_1 < arg_455_1.time_ and arg_455_1.time_ <= var_458_1 + arg_458_0 and not isNil(var_458_0) and arg_455_1.var_.characterEffect1019ui_story == nil then
				arg_455_1.var_.characterEffect1019ui_story = var_458_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_458_2 = 0.200000002980232

			if var_458_1 <= arg_455_1.time_ and arg_455_1.time_ < var_458_1 + var_458_2 and not isNil(var_458_0) then
				local var_458_3 = (arg_455_1.time_ - var_458_1) / var_458_2

				if arg_455_1.var_.characterEffect1019ui_story and not isNil(var_458_0) then
					local var_458_4 = Mathf.Lerp(0, 0.5, var_458_3)

					arg_455_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_455_1.var_.characterEffect1019ui_story.fillRatio = var_458_4
				end
			end

			if arg_455_1.time_ >= var_458_1 + var_458_2 and arg_455_1.time_ < var_458_1 + var_458_2 + arg_458_0 and not isNil(var_458_0) and arg_455_1.var_.characterEffect1019ui_story then
				local var_458_5 = 0.5

				arg_455_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_455_1.var_.characterEffect1019ui_story.fillRatio = var_458_5
			end

			local var_458_6 = 0
			local var_458_7 = 0.15

			if var_458_6 < arg_455_1.time_ and arg_455_1.time_ <= var_458_6 + arg_458_0 then
				arg_455_1.talkMaxDuration = 0
				arg_455_1.dialogCg_.alpha = 1

				arg_455_1.dialog_:SetActive(true)
				SetActive(arg_455_1.leftNameGo_, true)

				local var_458_8 = arg_455_1:FormatText(StoryNameCfg[7].name)

				arg_455_1.leftNameTxt_.text = var_458_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_455_1.leftNameTxt_.transform)

				arg_455_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_455_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_455_1:RecordName(arg_455_1.leftNameTxt_.text)
				SetActive(arg_455_1.iconTrs_.gameObject, true)
				arg_455_1.iconController_:SetSelectedState("hero")

				arg_455_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_455_1.callingController_:SetSelectedState("normal")

				arg_455_1.keyicon_.color = Color.New(1, 1, 1)
				arg_455_1.icon_.color = Color.New(1, 1, 1)

				local var_458_9 = arg_455_1:GetWordFromCfg(320061110)
				local var_458_10 = arg_455_1:FormatText(var_458_9.content)

				arg_455_1.text_.text = var_458_10

				LuaForUtil.ClearLinePrefixSymbol(arg_455_1.text_)

				local var_458_11 = 6
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
				arg_455_1:RecordContent(arg_455_1.text_.text)
			end

			local var_458_14 = math.max(var_458_7, arg_455_1.talkMaxDuration)

			if var_458_6 <= arg_455_1.time_ and arg_455_1.time_ < var_458_6 + var_458_14 then
				arg_455_1.typewritter.percent = (arg_455_1.time_ - var_458_6) / var_458_14

				arg_455_1.typewritter:SetDirty()
			end

			if arg_455_1.time_ >= var_458_6 + var_458_14 and arg_455_1.time_ < var_458_6 + var_458_14 + arg_458_0 then
				arg_455_1.typewritter.percent = 1

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(true)
			end
		end

		arg_455_1.nodeConfigList_ = {}

		arg_455_1:InitPlayNodeList()
	end,
	Play320061111 = function(arg_459_0, arg_459_1)
		arg_459_1.time_ = 0
		arg_459_1.frameCnt_ = 0
		arg_459_1.state_ = "playing"
		arg_459_1.curTalkId_ = 320061111
		arg_459_1.duration_ = 14.97

		local var_459_0 = {
			zh = 8.333,
			ja = 14.966
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
				arg_459_0:Play320061112(arg_459_1)
			end
		end

		function arg_459_1.onSingleLineUpdate_(arg_462_0)
			local var_462_0 = arg_459_1.actors_["1019ui_story"]
			local var_462_1 = 0

			if var_462_1 < arg_459_1.time_ and arg_459_1.time_ <= var_462_1 + arg_462_0 and not isNil(var_462_0) and arg_459_1.var_.characterEffect1019ui_story == nil then
				arg_459_1.var_.characterEffect1019ui_story = var_462_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_462_2 = 0.200000002980232

			if var_462_1 <= arg_459_1.time_ and arg_459_1.time_ < var_462_1 + var_462_2 and not isNil(var_462_0) then
				local var_462_3 = (arg_459_1.time_ - var_462_1) / var_462_2

				if arg_459_1.var_.characterEffect1019ui_story and not isNil(var_462_0) then
					arg_459_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_459_1.time_ >= var_462_1 + var_462_2 and arg_459_1.time_ < var_462_1 + var_462_2 + arg_462_0 and not isNil(var_462_0) and arg_459_1.var_.characterEffect1019ui_story then
				arg_459_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_462_4 = 0

			if var_462_4 < arg_459_1.time_ and arg_459_1.time_ <= var_462_4 + arg_462_0 then
				arg_459_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			local var_462_5 = 0

			if var_462_5 < arg_459_1.time_ and arg_459_1.time_ <= var_462_5 + arg_462_0 then
				arg_459_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_462_6 = 0
			local var_462_7 = 1.1

			if var_462_6 < arg_459_1.time_ and arg_459_1.time_ <= var_462_6 + arg_462_0 then
				arg_459_1.talkMaxDuration = 0
				arg_459_1.dialogCg_.alpha = 1

				arg_459_1.dialog_:SetActive(true)
				SetActive(arg_459_1.leftNameGo_, true)

				local var_462_8 = arg_459_1:FormatText(StoryNameCfg[13].name)

				arg_459_1.leftNameTxt_.text = var_462_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_459_1.leftNameTxt_.transform)

				arg_459_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_459_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_459_1:RecordName(arg_459_1.leftNameTxt_.text)
				SetActive(arg_459_1.iconTrs_.gameObject, false)
				arg_459_1.callingController_:SetSelectedState("normal")

				local var_462_9 = arg_459_1:GetWordFromCfg(320061111)
				local var_462_10 = arg_459_1:FormatText(var_462_9.content)

				arg_459_1.text_.text = var_462_10

				LuaForUtil.ClearLinePrefixSymbol(arg_459_1.text_)

				local var_462_11 = 43
				local var_462_12 = utf8.len(var_462_10)
				local var_462_13 = var_462_11 <= 0 and var_462_7 or var_462_7 * (var_462_12 / var_462_11)

				if var_462_13 > 0 and var_462_7 < var_462_13 then
					arg_459_1.talkMaxDuration = var_462_13

					if var_462_13 + var_462_6 > arg_459_1.duration_ then
						arg_459_1.duration_ = var_462_13 + var_462_6
					end
				end

				arg_459_1.text_.text = var_462_10
				arg_459_1.typewritter.percent = 0

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320061", "320061111", "story_v_out_320061.awb") ~= 0 then
					local var_462_14 = manager.audio:GetVoiceLength("story_v_out_320061", "320061111", "story_v_out_320061.awb") / 1000

					if var_462_14 + var_462_6 > arg_459_1.duration_ then
						arg_459_1.duration_ = var_462_14 + var_462_6
					end

					if var_462_9.prefab_name ~= "" and arg_459_1.actors_[var_462_9.prefab_name] ~= nil then
						local var_462_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_459_1.actors_[var_462_9.prefab_name].transform, "story_v_out_320061", "320061111", "story_v_out_320061.awb")

						arg_459_1:RecordAudio("320061111", var_462_15)
						arg_459_1:RecordAudio("320061111", var_462_15)
					else
						arg_459_1:AudioAction("play", "voice", "story_v_out_320061", "320061111", "story_v_out_320061.awb")
					end

					arg_459_1:RecordHistoryTalkVoice("story_v_out_320061", "320061111", "story_v_out_320061.awb")
				end

				arg_459_1:RecordContent(arg_459_1.text_.text)
			end

			local var_462_16 = math.max(var_462_7, arg_459_1.talkMaxDuration)

			if var_462_6 <= arg_459_1.time_ and arg_459_1.time_ < var_462_6 + var_462_16 then
				arg_459_1.typewritter.percent = (arg_459_1.time_ - var_462_6) / var_462_16

				arg_459_1.typewritter:SetDirty()
			end

			if arg_459_1.time_ >= var_462_6 + var_462_16 and arg_459_1.time_ < var_462_6 + var_462_16 + arg_462_0 then
				arg_459_1.typewritter.percent = 1

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(true)
			end
		end

		arg_459_1.nodeConfigList_ = {}

		arg_459_1:InitPlayNodeList()
	end,
	Play320061112 = function(arg_463_0, arg_463_1)
		arg_463_1.time_ = 0
		arg_463_1.frameCnt_ = 0
		arg_463_1.state_ = "playing"
		arg_463_1.curTalkId_ = 320061112
		arg_463_1.duration_ = 5.7

		local var_463_0 = {
			zh = 3.2,
			ja = 5.7
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
				arg_463_0:Play320061113(arg_463_1)
			end
		end

		function arg_463_1.onSingleLineUpdate_(arg_466_0)
			local var_466_0 = 0
			local var_466_1 = 0.4

			if var_466_0 < arg_463_1.time_ and arg_463_1.time_ <= var_466_0 + arg_466_0 then
				arg_463_1.talkMaxDuration = 0
				arg_463_1.dialogCg_.alpha = 1

				arg_463_1.dialog_:SetActive(true)
				SetActive(arg_463_1.leftNameGo_, true)

				local var_466_2 = arg_463_1:FormatText(StoryNameCfg[13].name)

				arg_463_1.leftNameTxt_.text = var_466_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_463_1.leftNameTxt_.transform)

				arg_463_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_463_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_463_1:RecordName(arg_463_1.leftNameTxt_.text)
				SetActive(arg_463_1.iconTrs_.gameObject, false)
				arg_463_1.callingController_:SetSelectedState("normal")

				local var_466_3 = arg_463_1:GetWordFromCfg(320061112)
				local var_466_4 = arg_463_1:FormatText(var_466_3.content)

				arg_463_1.text_.text = var_466_4

				LuaForUtil.ClearLinePrefixSymbol(arg_463_1.text_)

				local var_466_5 = 16
				local var_466_6 = utf8.len(var_466_4)
				local var_466_7 = var_466_5 <= 0 and var_466_1 or var_466_1 * (var_466_6 / var_466_5)

				if var_466_7 > 0 and var_466_1 < var_466_7 then
					arg_463_1.talkMaxDuration = var_466_7

					if var_466_7 + var_466_0 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_7 + var_466_0
					end
				end

				arg_463_1.text_.text = var_466_4
				arg_463_1.typewritter.percent = 0

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320061", "320061112", "story_v_out_320061.awb") ~= 0 then
					local var_466_8 = manager.audio:GetVoiceLength("story_v_out_320061", "320061112", "story_v_out_320061.awb") / 1000

					if var_466_8 + var_466_0 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_8 + var_466_0
					end

					if var_466_3.prefab_name ~= "" and arg_463_1.actors_[var_466_3.prefab_name] ~= nil then
						local var_466_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_463_1.actors_[var_466_3.prefab_name].transform, "story_v_out_320061", "320061112", "story_v_out_320061.awb")

						arg_463_1:RecordAudio("320061112", var_466_9)
						arg_463_1:RecordAudio("320061112", var_466_9)
					else
						arg_463_1:AudioAction("play", "voice", "story_v_out_320061", "320061112", "story_v_out_320061.awb")
					end

					arg_463_1:RecordHistoryTalkVoice("story_v_out_320061", "320061112", "story_v_out_320061.awb")
				end

				arg_463_1:RecordContent(arg_463_1.text_.text)
			end

			local var_466_10 = math.max(var_466_1, arg_463_1.talkMaxDuration)

			if var_466_0 <= arg_463_1.time_ and arg_463_1.time_ < var_466_0 + var_466_10 then
				arg_463_1.typewritter.percent = (arg_463_1.time_ - var_466_0) / var_466_10

				arg_463_1.typewritter:SetDirty()
			end

			if arg_463_1.time_ >= var_466_0 + var_466_10 and arg_463_1.time_ < var_466_0 + var_466_10 + arg_466_0 then
				arg_463_1.typewritter.percent = 1

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(true)
			end
		end

		arg_463_1.nodeConfigList_ = {}

		arg_463_1:InitPlayNodeList()
	end,
	Play320061113 = function(arg_467_0, arg_467_1)
		arg_467_1.time_ = 0
		arg_467_1.frameCnt_ = 0
		arg_467_1.state_ = "playing"
		arg_467_1.curTalkId_ = 320061113
		arg_467_1.duration_ = 9

		SetActive(arg_467_1.tipsGo_, false)

		function arg_467_1.onSingleLineFinish_()
			arg_467_1.onSingleLineUpdate_ = nil
			arg_467_1.onSingleLineFinish_ = nil
			arg_467_1.state_ = "waiting"
		end

		function arg_467_1.playNext_(arg_469_0)
			if arg_469_0 == 1 then
				arg_467_0:Play320061114(arg_467_1)
			end
		end

		function arg_467_1.onSingleLineUpdate_(arg_470_0)
			local var_470_0 = "ST0503"

			if arg_467_1.bgs_[var_470_0] == nil then
				local var_470_1 = Object.Instantiate(arg_467_1.paintGo_)

				var_470_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_470_0)
				var_470_1.name = var_470_0
				var_470_1.transform.parent = arg_467_1.stage_.transform
				var_470_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_467_1.bgs_[var_470_0] = var_470_1
			end

			local var_470_2 = 2

			if var_470_2 < arg_467_1.time_ and arg_467_1.time_ <= var_470_2 + arg_470_0 then
				local var_470_3 = manager.ui.mainCamera.transform.localPosition
				local var_470_4 = Vector3.New(0, 0, 10) + Vector3.New(var_470_3.x, var_470_3.y, 0)
				local var_470_5 = arg_467_1.bgs_.ST0503

				var_470_5.transform.localPosition = var_470_4
				var_470_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_470_6 = var_470_5:GetComponent("SpriteRenderer")

				if var_470_6 and var_470_6.sprite then
					local var_470_7 = (var_470_5.transform.localPosition - var_470_3).z
					local var_470_8 = manager.ui.mainCameraCom_
					local var_470_9 = 2 * var_470_7 * Mathf.Tan(var_470_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_470_10 = var_470_9 * var_470_8.aspect
					local var_470_11 = var_470_6.sprite.bounds.size.x
					local var_470_12 = var_470_6.sprite.bounds.size.y
					local var_470_13 = var_470_10 / var_470_11
					local var_470_14 = var_470_9 / var_470_12
					local var_470_15 = var_470_14 < var_470_13 and var_470_13 or var_470_14

					var_470_5.transform.localScale = Vector3.New(var_470_15, var_470_15, 0)
				end

				for iter_470_0, iter_470_1 in pairs(arg_467_1.bgs_) do
					if iter_470_0 ~= "ST0503" then
						iter_470_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_470_16 = 4

			if var_470_16 < arg_467_1.time_ and arg_467_1.time_ <= var_470_16 + arg_470_0 then
				arg_467_1.allBtn_.enabled = false
			end

			local var_470_17 = 0.3

			if arg_467_1.time_ >= var_470_16 + var_470_17 and arg_467_1.time_ < var_470_16 + var_470_17 + arg_470_0 then
				arg_467_1.allBtn_.enabled = true
			end

			local var_470_18 = 0

			if var_470_18 < arg_467_1.time_ and arg_467_1.time_ <= var_470_18 + arg_470_0 then
				arg_467_1.mask_.enabled = true
				arg_467_1.mask_.raycastTarget = true

				arg_467_1:SetGaussion(false)
			end

			local var_470_19 = 2

			if var_470_18 <= arg_467_1.time_ and arg_467_1.time_ < var_470_18 + var_470_19 then
				local var_470_20 = (arg_467_1.time_ - var_470_18) / var_470_19
				local var_470_21 = Color.New(0, 0, 0)

				var_470_21.a = Mathf.Lerp(0, 1, var_470_20)
				arg_467_1.mask_.color = var_470_21
			end

			if arg_467_1.time_ >= var_470_18 + var_470_19 and arg_467_1.time_ < var_470_18 + var_470_19 + arg_470_0 then
				local var_470_22 = Color.New(0, 0, 0)

				var_470_22.a = 1
				arg_467_1.mask_.color = var_470_22
			end

			local var_470_23 = 2

			if var_470_23 < arg_467_1.time_ and arg_467_1.time_ <= var_470_23 + arg_470_0 then
				arg_467_1.mask_.enabled = true
				arg_467_1.mask_.raycastTarget = true

				arg_467_1:SetGaussion(false)
			end

			local var_470_24 = 2

			if var_470_23 <= arg_467_1.time_ and arg_467_1.time_ < var_470_23 + var_470_24 then
				local var_470_25 = (arg_467_1.time_ - var_470_23) / var_470_24
				local var_470_26 = Color.New(0, 0, 0)

				var_470_26.a = Mathf.Lerp(1, 0, var_470_25)
				arg_467_1.mask_.color = var_470_26
			end

			if arg_467_1.time_ >= var_470_23 + var_470_24 and arg_467_1.time_ < var_470_23 + var_470_24 + arg_470_0 then
				local var_470_27 = Color.New(0, 0, 0)
				local var_470_28 = 0

				arg_467_1.mask_.enabled = false
				var_470_27.a = var_470_28
				arg_467_1.mask_.color = var_470_27
			end

			local var_470_29 = arg_467_1.actors_["1019ui_story"].transform
			local var_470_30 = 1.96599999815226

			if var_470_30 < arg_467_1.time_ and arg_467_1.time_ <= var_470_30 + arg_470_0 then
				arg_467_1.var_.moveOldPos1019ui_story = var_470_29.localPosition
			end

			local var_470_31 = 0.001

			if var_470_30 <= arg_467_1.time_ and arg_467_1.time_ < var_470_30 + var_470_31 then
				local var_470_32 = (arg_467_1.time_ - var_470_30) / var_470_31
				local var_470_33 = Vector3.New(0, 100, 0)

				var_470_29.localPosition = Vector3.Lerp(arg_467_1.var_.moveOldPos1019ui_story, var_470_33, var_470_32)

				local var_470_34 = manager.ui.mainCamera.transform.position - var_470_29.position

				var_470_29.forward = Vector3.New(var_470_34.x, var_470_34.y, var_470_34.z)

				local var_470_35 = var_470_29.localEulerAngles

				var_470_35.z = 0
				var_470_35.x = 0
				var_470_29.localEulerAngles = var_470_35
			end

			if arg_467_1.time_ >= var_470_30 + var_470_31 and arg_467_1.time_ < var_470_30 + var_470_31 + arg_470_0 then
				var_470_29.localPosition = Vector3.New(0, 100, 0)

				local var_470_36 = manager.ui.mainCamera.transform.position - var_470_29.position

				var_470_29.forward = Vector3.New(var_470_36.x, var_470_36.y, var_470_36.z)

				local var_470_37 = var_470_29.localEulerAngles

				var_470_37.z = 0
				var_470_37.x = 0
				var_470_29.localEulerAngles = var_470_37
			end

			local var_470_38 = arg_467_1.actors_["1019ui_story"]
			local var_470_39 = 1.96599999815226

			if var_470_39 < arg_467_1.time_ and arg_467_1.time_ <= var_470_39 + arg_470_0 and not isNil(var_470_38) and arg_467_1.var_.characterEffect1019ui_story == nil then
				arg_467_1.var_.characterEffect1019ui_story = var_470_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_470_40 = 0.034000001847744

			if var_470_39 <= arg_467_1.time_ and arg_467_1.time_ < var_470_39 + var_470_40 and not isNil(var_470_38) then
				local var_470_41 = (arg_467_1.time_ - var_470_39) / var_470_40

				if arg_467_1.var_.characterEffect1019ui_story and not isNil(var_470_38) then
					local var_470_42 = Mathf.Lerp(0, 0.5, var_470_41)

					arg_467_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_467_1.var_.characterEffect1019ui_story.fillRatio = var_470_42
				end
			end

			if arg_467_1.time_ >= var_470_39 + var_470_40 and arg_467_1.time_ < var_470_39 + var_470_40 + arg_470_0 and not isNil(var_470_38) and arg_467_1.var_.characterEffect1019ui_story then
				local var_470_43 = 0.5

				arg_467_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_467_1.var_.characterEffect1019ui_story.fillRatio = var_470_43
			end

			local var_470_44 = 2

			arg_467_1.isInRecall_ = false

			if var_470_44 < arg_467_1.time_ and arg_467_1.time_ <= var_470_44 + arg_470_0 then
				arg_467_1.screenFilterGo_:SetActive(false)

				for iter_470_2, iter_470_3 in pairs(arg_467_1.actors_) do
					local var_470_45 = iter_470_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_470_4, iter_470_5 in ipairs(var_470_45) do
						if iter_470_5.color.r > 0.51 then
							iter_470_5.color = Color.New(1, 1, 1)
						else
							iter_470_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_470_46 = 0.2

			if var_470_44 <= arg_467_1.time_ and arg_467_1.time_ < var_470_44 + var_470_46 then
				local var_470_47 = (arg_467_1.time_ - var_470_44) / var_470_46

				arg_467_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, var_470_47)
			end

			if arg_467_1.time_ >= var_470_44 + var_470_46 and arg_467_1.time_ < var_470_44 + var_470_46 + arg_470_0 then
				arg_467_1.screenFilterEffect_.weight = 0
			end

			if arg_467_1.frameCnt_ <= 1 then
				arg_467_1.dialog_:SetActive(false)
			end

			local var_470_48 = 4
			local var_470_49 = 1.175

			if var_470_48 < arg_467_1.time_ and arg_467_1.time_ <= var_470_48 + arg_470_0 then
				arg_467_1.talkMaxDuration = 0

				arg_467_1.dialog_:SetActive(true)

				arg_467_1.dialogCg_.alpha = 0

				local var_470_50 = LeanTween.value(arg_467_1.dialog_, 0, 1, 0.3)

				var_470_50:setOnUpdate(LuaHelper.FloatAction(function(arg_471_0)
					arg_467_1.dialogCg_.alpha = arg_471_0
				end))
				var_470_50:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_467_1.dialog_)
					var_470_50:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_467_1.duration_ = arg_467_1.duration_ + 0.3

				SetActive(arg_467_1.leftNameGo_, false)

				arg_467_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_467_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_467_1:RecordName(arg_467_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_467_1.iconTrs_.gameObject, false)
				arg_467_1.callingController_:SetSelectedState("normal")

				local var_470_51 = arg_467_1:GetWordFromCfg(320061113)
				local var_470_52 = arg_467_1:FormatText(var_470_51.content)

				arg_467_1.text_.text = var_470_52

				LuaForUtil.ClearLinePrefixSymbol(arg_467_1.text_)

				local var_470_53 = 47
				local var_470_54 = utf8.len(var_470_52)
				local var_470_55 = var_470_53 <= 0 and var_470_49 or var_470_49 * (var_470_54 / var_470_53)

				if var_470_55 > 0 and var_470_49 < var_470_55 then
					arg_467_1.talkMaxDuration = var_470_55
					var_470_48 = var_470_48 + 0.3

					if var_470_55 + var_470_48 > arg_467_1.duration_ then
						arg_467_1.duration_ = var_470_55 + var_470_48
					end
				end

				arg_467_1.text_.text = var_470_52
				arg_467_1.typewritter.percent = 0

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(false)
				arg_467_1:RecordContent(arg_467_1.text_.text)
			end

			local var_470_56 = var_470_48 + 0.3
			local var_470_57 = math.max(var_470_49, arg_467_1.talkMaxDuration)

			if var_470_56 <= arg_467_1.time_ and arg_467_1.time_ < var_470_56 + var_470_57 then
				arg_467_1.typewritter.percent = (arg_467_1.time_ - var_470_56) / var_470_57

				arg_467_1.typewritter:SetDirty()
			end

			if arg_467_1.time_ >= var_470_56 + var_470_57 and arg_467_1.time_ < var_470_56 + var_470_57 + arg_470_0 then
				arg_467_1.typewritter.percent = 1

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(true)
			end
		end

		arg_467_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_467_1:InitPlayNodeList()
	end,
	Play320061114 = function(arg_473_0, arg_473_1)
		arg_473_1.time_ = 0
		arg_473_1.frameCnt_ = 0
		arg_473_1.state_ = "playing"
		arg_473_1.curTalkId_ = 320061114
		arg_473_1.duration_ = 4.67

		local var_473_0 = {
			zh = 1.8,
			ja = 4.666
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
				arg_473_0:Play320061115(arg_473_1)
			end
		end

		function arg_473_1.onSingleLineUpdate_(arg_476_0)
			local var_476_0 = arg_473_1.actors_["10100ui_story"].transform
			local var_476_1 = 0

			if var_476_1 < arg_473_1.time_ and arg_473_1.time_ <= var_476_1 + arg_476_0 then
				arg_473_1.var_.moveOldPos10100ui_story = var_476_0.localPosition
			end

			local var_476_2 = 0.001

			if var_476_1 <= arg_473_1.time_ and arg_473_1.time_ < var_476_1 + var_476_2 then
				local var_476_3 = (arg_473_1.time_ - var_476_1) / var_476_2
				local var_476_4 = Vector3.New(0, -1.16, -6.25)

				var_476_0.localPosition = Vector3.Lerp(arg_473_1.var_.moveOldPos10100ui_story, var_476_4, var_476_3)

				local var_476_5 = manager.ui.mainCamera.transform.position - var_476_0.position

				var_476_0.forward = Vector3.New(var_476_5.x, var_476_5.y, var_476_5.z)

				local var_476_6 = var_476_0.localEulerAngles

				var_476_6.z = 0
				var_476_6.x = 0
				var_476_0.localEulerAngles = var_476_6
			end

			if arg_473_1.time_ >= var_476_1 + var_476_2 and arg_473_1.time_ < var_476_1 + var_476_2 + arg_476_0 then
				var_476_0.localPosition = Vector3.New(0, -1.16, -6.25)

				local var_476_7 = manager.ui.mainCamera.transform.position - var_476_0.position

				var_476_0.forward = Vector3.New(var_476_7.x, var_476_7.y, var_476_7.z)

				local var_476_8 = var_476_0.localEulerAngles

				var_476_8.z = 0
				var_476_8.x = 0
				var_476_0.localEulerAngles = var_476_8
			end

			local var_476_9 = arg_473_1.actors_["10100ui_story"]
			local var_476_10 = 0

			if var_476_10 < arg_473_1.time_ and arg_473_1.time_ <= var_476_10 + arg_476_0 and not isNil(var_476_9) and arg_473_1.var_.characterEffect10100ui_story == nil then
				arg_473_1.var_.characterEffect10100ui_story = var_476_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_476_11 = 0.200000002980232

			if var_476_10 <= arg_473_1.time_ and arg_473_1.time_ < var_476_10 + var_476_11 and not isNil(var_476_9) then
				local var_476_12 = (arg_473_1.time_ - var_476_10) / var_476_11

				if arg_473_1.var_.characterEffect10100ui_story and not isNil(var_476_9) then
					arg_473_1.var_.characterEffect10100ui_story.fillFlat = false
				end
			end

			if arg_473_1.time_ >= var_476_10 + var_476_11 and arg_473_1.time_ < var_476_10 + var_476_11 + arg_476_0 and not isNil(var_476_9) and arg_473_1.var_.characterEffect10100ui_story then
				arg_473_1.var_.characterEffect10100ui_story.fillFlat = false
			end

			local var_476_13 = 0

			if var_476_13 < arg_473_1.time_ and arg_473_1.time_ <= var_476_13 + arg_476_0 then
				arg_473_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action1_1")
			end

			local var_476_14 = 0

			if var_476_14 < arg_473_1.time_ and arg_473_1.time_ <= var_476_14 + arg_476_0 then
				arg_473_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_476_15 = 0
			local var_476_16 = 0.25

			if var_476_15 < arg_473_1.time_ and arg_473_1.time_ <= var_476_15 + arg_476_0 then
				arg_473_1.talkMaxDuration = 0
				arg_473_1.dialogCg_.alpha = 1

				arg_473_1.dialog_:SetActive(true)
				SetActive(arg_473_1.leftNameGo_, true)

				local var_476_17 = arg_473_1:FormatText(StoryNameCfg[1021].name)

				arg_473_1.leftNameTxt_.text = var_476_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_473_1.leftNameTxt_.transform)

				arg_473_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_473_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_473_1:RecordName(arg_473_1.leftNameTxt_.text)
				SetActive(arg_473_1.iconTrs_.gameObject, false)
				arg_473_1.callingController_:SetSelectedState("normal")

				local var_476_18 = arg_473_1:GetWordFromCfg(320061114)
				local var_476_19 = arg_473_1:FormatText(var_476_18.content)

				arg_473_1.text_.text = var_476_19

				LuaForUtil.ClearLinePrefixSymbol(arg_473_1.text_)

				local var_476_20 = 10
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

				if manager.audio:GetVoiceLength("story_v_out_320061", "320061114", "story_v_out_320061.awb") ~= 0 then
					local var_476_23 = manager.audio:GetVoiceLength("story_v_out_320061", "320061114", "story_v_out_320061.awb") / 1000

					if var_476_23 + var_476_15 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_23 + var_476_15
					end

					if var_476_18.prefab_name ~= "" and arg_473_1.actors_[var_476_18.prefab_name] ~= nil then
						local var_476_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_473_1.actors_[var_476_18.prefab_name].transform, "story_v_out_320061", "320061114", "story_v_out_320061.awb")

						arg_473_1:RecordAudio("320061114", var_476_24)
						arg_473_1:RecordAudio("320061114", var_476_24)
					else
						arg_473_1:AudioAction("play", "voice", "story_v_out_320061", "320061114", "story_v_out_320061.awb")
					end

					arg_473_1:RecordHistoryTalkVoice("story_v_out_320061", "320061114", "story_v_out_320061.awb")
				end

				arg_473_1:RecordContent(arg_473_1.text_.text)
			end

			local var_476_25 = math.max(var_476_16, arg_473_1.talkMaxDuration)

			if var_476_15 <= arg_473_1.time_ and arg_473_1.time_ < var_476_15 + var_476_25 then
				arg_473_1.typewritter.percent = (arg_473_1.time_ - var_476_15) / var_476_25

				arg_473_1.typewritter:SetDirty()
			end

			if arg_473_1.time_ >= var_476_15 + var_476_25 and arg_473_1.time_ < var_476_15 + var_476_25 + arg_476_0 then
				arg_473_1.typewritter.percent = 1

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(true)
			end
		end

		arg_473_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10100ui_story",
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
	Play320061115 = function(arg_477_0, arg_477_1)
		arg_477_1.time_ = 0
		arg_477_1.frameCnt_ = 0
		arg_477_1.state_ = "playing"
		arg_477_1.curTalkId_ = 320061115
		arg_477_1.duration_ = 5

		SetActive(arg_477_1.tipsGo_, false)

		function arg_477_1.onSingleLineFinish_()
			arg_477_1.onSingleLineUpdate_ = nil
			arg_477_1.onSingleLineFinish_ = nil
			arg_477_1.state_ = "waiting"
		end

		function arg_477_1.playNext_(arg_479_0)
			if arg_479_0 == 1 then
				arg_477_0:Play320061116(arg_477_1)
			end
		end

		function arg_477_1.onSingleLineUpdate_(arg_480_0)
			local var_480_0 = arg_477_1.actors_["10100ui_story"]
			local var_480_1 = 0

			if var_480_1 < arg_477_1.time_ and arg_477_1.time_ <= var_480_1 + arg_480_0 and not isNil(var_480_0) and arg_477_1.var_.characterEffect10100ui_story == nil then
				arg_477_1.var_.characterEffect10100ui_story = var_480_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_480_2 = 0.200000002980232

			if var_480_1 <= arg_477_1.time_ and arg_477_1.time_ < var_480_1 + var_480_2 and not isNil(var_480_0) then
				local var_480_3 = (arg_477_1.time_ - var_480_1) / var_480_2

				if arg_477_1.var_.characterEffect10100ui_story and not isNil(var_480_0) then
					local var_480_4 = Mathf.Lerp(0, 0.5, var_480_3)

					arg_477_1.var_.characterEffect10100ui_story.fillFlat = true
					arg_477_1.var_.characterEffect10100ui_story.fillRatio = var_480_4
				end
			end

			if arg_477_1.time_ >= var_480_1 + var_480_2 and arg_477_1.time_ < var_480_1 + var_480_2 + arg_480_0 and not isNil(var_480_0) and arg_477_1.var_.characterEffect10100ui_story then
				local var_480_5 = 0.5

				arg_477_1.var_.characterEffect10100ui_story.fillFlat = true
				arg_477_1.var_.characterEffect10100ui_story.fillRatio = var_480_5
			end

			local var_480_6 = 0
			local var_480_7 = 1.25

			if var_480_6 < arg_477_1.time_ and arg_477_1.time_ <= var_480_6 + arg_480_0 then
				arg_477_1.talkMaxDuration = 0
				arg_477_1.dialogCg_.alpha = 1

				arg_477_1.dialog_:SetActive(true)
				SetActive(arg_477_1.leftNameGo_, false)

				arg_477_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_477_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_477_1:RecordName(arg_477_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_477_1.iconTrs_.gameObject, false)
				arg_477_1.callingController_:SetSelectedState("normal")

				local var_480_8 = arg_477_1:GetWordFromCfg(320061115)
				local var_480_9 = arg_477_1:FormatText(var_480_8.content)

				arg_477_1.text_.text = var_480_9

				LuaForUtil.ClearLinePrefixSymbol(arg_477_1.text_)

				local var_480_10 = 50
				local var_480_11 = utf8.len(var_480_9)
				local var_480_12 = var_480_10 <= 0 and var_480_7 or var_480_7 * (var_480_11 / var_480_10)

				if var_480_12 > 0 and var_480_7 < var_480_12 then
					arg_477_1.talkMaxDuration = var_480_12

					if var_480_12 + var_480_6 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_12 + var_480_6
					end
				end

				arg_477_1.text_.text = var_480_9
				arg_477_1.typewritter.percent = 0

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(false)
				arg_477_1:RecordContent(arg_477_1.text_.text)
			end

			local var_480_13 = math.max(var_480_7, arg_477_1.talkMaxDuration)

			if var_480_6 <= arg_477_1.time_ and arg_477_1.time_ < var_480_6 + var_480_13 then
				arg_477_1.typewritter.percent = (arg_477_1.time_ - var_480_6) / var_480_13

				arg_477_1.typewritter:SetDirty()
			end

			if arg_477_1.time_ >= var_480_6 + var_480_13 and arg_477_1.time_ < var_480_6 + var_480_13 + arg_480_0 then
				arg_477_1.typewritter.percent = 1

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(true)
			end
		end

		arg_477_1.nodeConfigList_ = {}

		arg_477_1:InitPlayNodeList()
	end,
	Play320061116 = function(arg_481_0, arg_481_1)
		arg_481_1.time_ = 0
		arg_481_1.frameCnt_ = 0
		arg_481_1.state_ = "playing"
		arg_481_1.curTalkId_ = 320061116
		arg_481_1.duration_ = 5

		SetActive(arg_481_1.tipsGo_, false)

		function arg_481_1.onSingleLineFinish_()
			arg_481_1.onSingleLineUpdate_ = nil
			arg_481_1.onSingleLineFinish_ = nil
			arg_481_1.state_ = "waiting"
		end

		function arg_481_1.playNext_(arg_483_0)
			if arg_483_0 == 1 then
				arg_481_0:Play320061117(arg_481_1)
			end
		end

		function arg_481_1.onSingleLineUpdate_(arg_484_0)
			local var_484_0 = 0
			local var_484_1 = 0.65

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

				local var_484_2 = arg_481_1:GetWordFromCfg(320061116)
				local var_484_3 = arg_481_1:FormatText(var_484_2.content)

				arg_481_1.text_.text = var_484_3

				LuaForUtil.ClearLinePrefixSymbol(arg_481_1.text_)

				local var_484_4 = 26
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
	Play320061117 = function(arg_485_0, arg_485_1)
		arg_485_1.time_ = 0
		arg_485_1.frameCnt_ = 0
		arg_485_1.state_ = "playing"
		arg_485_1.curTalkId_ = 320061117
		arg_485_1.duration_ = 11.63

		local var_485_0 = {
			zh = 6.133,
			ja = 11.633
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
				arg_485_0:Play320061118(arg_485_1)
			end
		end

		function arg_485_1.onSingleLineUpdate_(arg_488_0)
			local var_488_0 = arg_485_1.actors_["10100ui_story"]
			local var_488_1 = 0

			if var_488_1 < arg_485_1.time_ and arg_485_1.time_ <= var_488_1 + arg_488_0 and not isNil(var_488_0) and arg_485_1.var_.characterEffect10100ui_story == nil then
				arg_485_1.var_.characterEffect10100ui_story = var_488_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_488_2 = 0.200000002980232

			if var_488_1 <= arg_485_1.time_ and arg_485_1.time_ < var_488_1 + var_488_2 and not isNil(var_488_0) then
				local var_488_3 = (arg_485_1.time_ - var_488_1) / var_488_2

				if arg_485_1.var_.characterEffect10100ui_story and not isNil(var_488_0) then
					arg_485_1.var_.characterEffect10100ui_story.fillFlat = false
				end
			end

			if arg_485_1.time_ >= var_488_1 + var_488_2 and arg_485_1.time_ < var_488_1 + var_488_2 + arg_488_0 and not isNil(var_488_0) and arg_485_1.var_.characterEffect10100ui_story then
				arg_485_1.var_.characterEffect10100ui_story.fillFlat = false
			end

			local var_488_4 = 0

			if var_488_4 < arg_485_1.time_ and arg_485_1.time_ <= var_488_4 + arg_488_0 then
				arg_485_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action3_1")
			end

			local var_488_5 = 0

			if var_488_5 < arg_485_1.time_ and arg_485_1.time_ <= var_488_5 + arg_488_0 then
				arg_485_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_488_6 = 0
			local var_488_7 = 0.875

			if var_488_6 < arg_485_1.time_ and arg_485_1.time_ <= var_488_6 + arg_488_0 then
				arg_485_1.talkMaxDuration = 0
				arg_485_1.dialogCg_.alpha = 1

				arg_485_1.dialog_:SetActive(true)
				SetActive(arg_485_1.leftNameGo_, true)

				local var_488_8 = arg_485_1:FormatText(StoryNameCfg[1021].name)

				arg_485_1.leftNameTxt_.text = var_488_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_485_1.leftNameTxt_.transform)

				arg_485_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_485_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_485_1:RecordName(arg_485_1.leftNameTxt_.text)
				SetActive(arg_485_1.iconTrs_.gameObject, false)
				arg_485_1.callingController_:SetSelectedState("normal")

				local var_488_9 = arg_485_1:GetWordFromCfg(320061117)
				local var_488_10 = arg_485_1:FormatText(var_488_9.content)

				arg_485_1.text_.text = var_488_10

				LuaForUtil.ClearLinePrefixSymbol(arg_485_1.text_)

				local var_488_11 = 35
				local var_488_12 = utf8.len(var_488_10)
				local var_488_13 = var_488_11 <= 0 and var_488_7 or var_488_7 * (var_488_12 / var_488_11)

				if var_488_13 > 0 and var_488_7 < var_488_13 then
					arg_485_1.talkMaxDuration = var_488_13

					if var_488_13 + var_488_6 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_13 + var_488_6
					end
				end

				arg_485_1.text_.text = var_488_10
				arg_485_1.typewritter.percent = 0

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320061", "320061117", "story_v_out_320061.awb") ~= 0 then
					local var_488_14 = manager.audio:GetVoiceLength("story_v_out_320061", "320061117", "story_v_out_320061.awb") / 1000

					if var_488_14 + var_488_6 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_14 + var_488_6
					end

					if var_488_9.prefab_name ~= "" and arg_485_1.actors_[var_488_9.prefab_name] ~= nil then
						local var_488_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_485_1.actors_[var_488_9.prefab_name].transform, "story_v_out_320061", "320061117", "story_v_out_320061.awb")

						arg_485_1:RecordAudio("320061117", var_488_15)
						arg_485_1:RecordAudio("320061117", var_488_15)
					else
						arg_485_1:AudioAction("play", "voice", "story_v_out_320061", "320061117", "story_v_out_320061.awb")
					end

					arg_485_1:RecordHistoryTalkVoice("story_v_out_320061", "320061117", "story_v_out_320061.awb")
				end

				arg_485_1:RecordContent(arg_485_1.text_.text)
			end

			local var_488_16 = math.max(var_488_7, arg_485_1.talkMaxDuration)

			if var_488_6 <= arg_485_1.time_ and arg_485_1.time_ < var_488_6 + var_488_16 then
				arg_485_1.typewritter.percent = (arg_485_1.time_ - var_488_6) / var_488_16

				arg_485_1.typewritter:SetDirty()
			end

			if arg_485_1.time_ >= var_488_6 + var_488_16 and arg_485_1.time_ < var_488_6 + var_488_16 + arg_488_0 then
				arg_485_1.typewritter.percent = 1

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(true)
			end
		end

		arg_485_1.nodeConfigList_ = {}

		arg_485_1:InitPlayNodeList()
	end,
	Play320061118 = function(arg_489_0, arg_489_1)
		arg_489_1.time_ = 0
		arg_489_1.frameCnt_ = 0
		arg_489_1.state_ = "playing"
		arg_489_1.curTalkId_ = 320061118
		arg_489_1.duration_ = 5.2

		local var_489_0 = {
			zh = 4.466,
			ja = 5.2
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
				arg_489_0:Play320061119(arg_489_1)
			end
		end

		function arg_489_1.onSingleLineUpdate_(arg_492_0)
			local var_492_0 = "1011ui_story"

			if arg_489_1.actors_[var_492_0] == nil then
				local var_492_1 = Asset.Load("Char/" .. "1011ui_story")

				if not isNil(var_492_1) then
					local var_492_2 = Object.Instantiate(Asset.Load("Char/" .. "1011ui_story"), arg_489_1.stage_.transform)

					var_492_2.name = var_492_0
					var_492_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_489_1.actors_[var_492_0] = var_492_2

					local var_492_3 = var_492_2:GetComponentInChildren(typeof(CharacterEffect))

					var_492_3.enabled = true

					local var_492_4 = GameObjectTools.GetOrAddComponent(var_492_2, typeof(DynamicBoneHelper))

					if var_492_4 then
						var_492_4:EnableDynamicBone(false)
					end

					arg_489_1:ShowWeapon(var_492_3.transform, false)

					arg_489_1.var_[var_492_0 .. "Animator"] = var_492_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_489_1.var_[var_492_0 .. "Animator"].applyRootMotion = true
					arg_489_1.var_[var_492_0 .. "LipSync"] = var_492_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_492_5 = arg_489_1.actors_["1011ui_story"].transform
			local var_492_6 = 0

			if var_492_6 < arg_489_1.time_ and arg_489_1.time_ <= var_492_6 + arg_492_0 then
				arg_489_1.var_.moveOldPos1011ui_story = var_492_5.localPosition
			end

			local var_492_7 = 0.001

			if var_492_6 <= arg_489_1.time_ and arg_489_1.time_ < var_492_6 + var_492_7 then
				local var_492_8 = (arg_489_1.time_ - var_492_6) / var_492_7
				local var_492_9 = Vector3.New(0, -0.71, -6)

				var_492_5.localPosition = Vector3.Lerp(arg_489_1.var_.moveOldPos1011ui_story, var_492_9, var_492_8)

				local var_492_10 = manager.ui.mainCamera.transform.position - var_492_5.position

				var_492_5.forward = Vector3.New(var_492_10.x, var_492_10.y, var_492_10.z)

				local var_492_11 = var_492_5.localEulerAngles

				var_492_11.z = 0
				var_492_11.x = 0
				var_492_5.localEulerAngles = var_492_11
			end

			if arg_489_1.time_ >= var_492_6 + var_492_7 and arg_489_1.time_ < var_492_6 + var_492_7 + arg_492_0 then
				var_492_5.localPosition = Vector3.New(0, -0.71, -6)

				local var_492_12 = manager.ui.mainCamera.transform.position - var_492_5.position

				var_492_5.forward = Vector3.New(var_492_12.x, var_492_12.y, var_492_12.z)

				local var_492_13 = var_492_5.localEulerAngles

				var_492_13.z = 0
				var_492_13.x = 0
				var_492_5.localEulerAngles = var_492_13
			end

			local var_492_14 = arg_489_1.actors_["1011ui_story"]
			local var_492_15 = 0

			if var_492_15 < arg_489_1.time_ and arg_489_1.time_ <= var_492_15 + arg_492_0 and not isNil(var_492_14) and arg_489_1.var_.characterEffect1011ui_story == nil then
				arg_489_1.var_.characterEffect1011ui_story = var_492_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_492_16 = 0.200000002980232

			if var_492_15 <= arg_489_1.time_ and arg_489_1.time_ < var_492_15 + var_492_16 and not isNil(var_492_14) then
				local var_492_17 = (arg_489_1.time_ - var_492_15) / var_492_16

				if arg_489_1.var_.characterEffect1011ui_story and not isNil(var_492_14) then
					arg_489_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_489_1.time_ >= var_492_15 + var_492_16 and arg_489_1.time_ < var_492_15 + var_492_16 + arg_492_0 and not isNil(var_492_14) and arg_489_1.var_.characterEffect1011ui_story then
				arg_489_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_492_18 = 0

			if var_492_18 < arg_489_1.time_ and arg_489_1.time_ <= var_492_18 + arg_492_0 then
				arg_489_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action3_1")
			end

			local var_492_19 = 0

			if var_492_19 < arg_489_1.time_ and arg_489_1.time_ <= var_492_19 + arg_492_0 then
				arg_489_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_492_20 = arg_489_1.actors_["10100ui_story"].transform
			local var_492_21 = 0

			if var_492_21 < arg_489_1.time_ and arg_489_1.time_ <= var_492_21 + arg_492_0 then
				arg_489_1.var_.moveOldPos10100ui_story = var_492_20.localPosition
			end

			local var_492_22 = 0.001

			if var_492_21 <= arg_489_1.time_ and arg_489_1.time_ < var_492_21 + var_492_22 then
				local var_492_23 = (arg_489_1.time_ - var_492_21) / var_492_22
				local var_492_24 = Vector3.New(0, 100, 0)

				var_492_20.localPosition = Vector3.Lerp(arg_489_1.var_.moveOldPos10100ui_story, var_492_24, var_492_23)

				local var_492_25 = manager.ui.mainCamera.transform.position - var_492_20.position

				var_492_20.forward = Vector3.New(var_492_25.x, var_492_25.y, var_492_25.z)

				local var_492_26 = var_492_20.localEulerAngles

				var_492_26.z = 0
				var_492_26.x = 0
				var_492_20.localEulerAngles = var_492_26
			end

			if arg_489_1.time_ >= var_492_21 + var_492_22 and arg_489_1.time_ < var_492_21 + var_492_22 + arg_492_0 then
				var_492_20.localPosition = Vector3.New(0, 100, 0)

				local var_492_27 = manager.ui.mainCamera.transform.position - var_492_20.position

				var_492_20.forward = Vector3.New(var_492_27.x, var_492_27.y, var_492_27.z)

				local var_492_28 = var_492_20.localEulerAngles

				var_492_28.z = 0
				var_492_28.x = 0
				var_492_20.localEulerAngles = var_492_28
			end

			local var_492_29 = arg_489_1.actors_["10100ui_story"]
			local var_492_30 = 0

			if var_492_30 < arg_489_1.time_ and arg_489_1.time_ <= var_492_30 + arg_492_0 and not isNil(var_492_29) and arg_489_1.var_.characterEffect10100ui_story == nil then
				arg_489_1.var_.characterEffect10100ui_story = var_492_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_492_31 = 0.200000002980232

			if var_492_30 <= arg_489_1.time_ and arg_489_1.time_ < var_492_30 + var_492_31 and not isNil(var_492_29) then
				local var_492_32 = (arg_489_1.time_ - var_492_30) / var_492_31

				if arg_489_1.var_.characterEffect10100ui_story and not isNil(var_492_29) then
					local var_492_33 = Mathf.Lerp(0, 0.5, var_492_32)

					arg_489_1.var_.characterEffect10100ui_story.fillFlat = true
					arg_489_1.var_.characterEffect10100ui_story.fillRatio = var_492_33
				end
			end

			if arg_489_1.time_ >= var_492_30 + var_492_31 and arg_489_1.time_ < var_492_30 + var_492_31 + arg_492_0 and not isNil(var_492_29) and arg_489_1.var_.characterEffect10100ui_story then
				local var_492_34 = 0.5

				arg_489_1.var_.characterEffect10100ui_story.fillFlat = true
				arg_489_1.var_.characterEffect10100ui_story.fillRatio = var_492_34
			end

			local var_492_35 = 0
			local var_492_36 = 0.325

			if var_492_35 < arg_489_1.time_ and arg_489_1.time_ <= var_492_35 + arg_492_0 then
				arg_489_1.talkMaxDuration = 0
				arg_489_1.dialogCg_.alpha = 1

				arg_489_1.dialog_:SetActive(true)
				SetActive(arg_489_1.leftNameGo_, true)

				local var_492_37 = arg_489_1:FormatText(StoryNameCfg[37].name)

				arg_489_1.leftNameTxt_.text = var_492_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_489_1.leftNameTxt_.transform)

				arg_489_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_489_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_489_1:RecordName(arg_489_1.leftNameTxt_.text)
				SetActive(arg_489_1.iconTrs_.gameObject, false)
				arg_489_1.callingController_:SetSelectedState("normal")

				local var_492_38 = arg_489_1:GetWordFromCfg(320061118)
				local var_492_39 = arg_489_1:FormatText(var_492_38.content)

				arg_489_1.text_.text = var_492_39

				LuaForUtil.ClearLinePrefixSymbol(arg_489_1.text_)

				local var_492_40 = 13
				local var_492_41 = utf8.len(var_492_39)
				local var_492_42 = var_492_40 <= 0 and var_492_36 or var_492_36 * (var_492_41 / var_492_40)

				if var_492_42 > 0 and var_492_36 < var_492_42 then
					arg_489_1.talkMaxDuration = var_492_42

					if var_492_42 + var_492_35 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_42 + var_492_35
					end
				end

				arg_489_1.text_.text = var_492_39
				arg_489_1.typewritter.percent = 0

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320061", "320061118", "story_v_out_320061.awb") ~= 0 then
					local var_492_43 = manager.audio:GetVoiceLength("story_v_out_320061", "320061118", "story_v_out_320061.awb") / 1000

					if var_492_43 + var_492_35 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_43 + var_492_35
					end

					if var_492_38.prefab_name ~= "" and arg_489_1.actors_[var_492_38.prefab_name] ~= nil then
						local var_492_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_489_1.actors_[var_492_38.prefab_name].transform, "story_v_out_320061", "320061118", "story_v_out_320061.awb")

						arg_489_1:RecordAudio("320061118", var_492_44)
						arg_489_1:RecordAudio("320061118", var_492_44)
					else
						arg_489_1:AudioAction("play", "voice", "story_v_out_320061", "320061118", "story_v_out_320061.awb")
					end

					arg_489_1:RecordHistoryTalkVoice("story_v_out_320061", "320061118", "story_v_out_320061.awb")
				end

				arg_489_1:RecordContent(arg_489_1.text_.text)
			end

			local var_492_45 = math.max(var_492_36, arg_489_1.talkMaxDuration)

			if var_492_35 <= arg_489_1.time_ and arg_489_1.time_ < var_492_35 + var_492_45 then
				arg_489_1.typewritter.percent = (arg_489_1.time_ - var_492_35) / var_492_45

				arg_489_1.typewritter:SetDirty()
			end

			if arg_489_1.time_ >= var_492_35 + var_492_45 and arg_489_1.time_ < var_492_35 + var_492_45 + arg_492_0 then
				arg_489_1.typewritter.percent = 1

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(true)
			end
		end

		arg_489_1.nodeConfigList_ = {
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
				actorName = "10100ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_489_1:InitPlayNodeList()
	end,
	Play320061119 = function(arg_493_0, arg_493_1)
		arg_493_1.time_ = 0
		arg_493_1.frameCnt_ = 0
		arg_493_1.state_ = "playing"
		arg_493_1.curTalkId_ = 320061119
		arg_493_1.duration_ = 5

		SetActive(arg_493_1.tipsGo_, false)

		function arg_493_1.onSingleLineFinish_()
			arg_493_1.onSingleLineUpdate_ = nil
			arg_493_1.onSingleLineFinish_ = nil
			arg_493_1.state_ = "waiting"
		end

		function arg_493_1.playNext_(arg_495_0)
			if arg_495_0 == 1 then
				arg_493_0:Play320061120(arg_493_1)
			end
		end

		function arg_493_1.onSingleLineUpdate_(arg_496_0)
			local var_496_0 = arg_493_1.actors_["1011ui_story"]
			local var_496_1 = 0

			if var_496_1 < arg_493_1.time_ and arg_493_1.time_ <= var_496_1 + arg_496_0 and not isNil(var_496_0) and arg_493_1.var_.characterEffect1011ui_story == nil then
				arg_493_1.var_.characterEffect1011ui_story = var_496_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_496_2 = 0.200000002980232

			if var_496_1 <= arg_493_1.time_ and arg_493_1.time_ < var_496_1 + var_496_2 and not isNil(var_496_0) then
				local var_496_3 = (arg_493_1.time_ - var_496_1) / var_496_2

				if arg_493_1.var_.characterEffect1011ui_story and not isNil(var_496_0) then
					local var_496_4 = Mathf.Lerp(0, 0.5, var_496_3)

					arg_493_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_493_1.var_.characterEffect1011ui_story.fillRatio = var_496_4
				end
			end

			if arg_493_1.time_ >= var_496_1 + var_496_2 and arg_493_1.time_ < var_496_1 + var_496_2 + arg_496_0 and not isNil(var_496_0) and arg_493_1.var_.characterEffect1011ui_story then
				local var_496_5 = 0.5

				arg_493_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_493_1.var_.characterEffect1011ui_story.fillRatio = var_496_5
			end

			local var_496_6 = 0
			local var_496_7 = 0.825

			if var_496_6 < arg_493_1.time_ and arg_493_1.time_ <= var_496_6 + arg_496_0 then
				arg_493_1.talkMaxDuration = 0
				arg_493_1.dialogCg_.alpha = 1

				arg_493_1.dialog_:SetActive(true)
				SetActive(arg_493_1.leftNameGo_, false)

				arg_493_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_493_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_493_1:RecordName(arg_493_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_493_1.iconTrs_.gameObject, false)
				arg_493_1.callingController_:SetSelectedState("normal")

				local var_496_8 = arg_493_1:GetWordFromCfg(320061119)
				local var_496_9 = arg_493_1:FormatText(var_496_8.content)

				arg_493_1.text_.text = var_496_9

				LuaForUtil.ClearLinePrefixSymbol(arg_493_1.text_)

				local var_496_10 = 33
				local var_496_11 = utf8.len(var_496_9)
				local var_496_12 = var_496_10 <= 0 and var_496_7 or var_496_7 * (var_496_11 / var_496_10)

				if var_496_12 > 0 and var_496_7 < var_496_12 then
					arg_493_1.talkMaxDuration = var_496_12

					if var_496_12 + var_496_6 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_12 + var_496_6
					end
				end

				arg_493_1.text_.text = var_496_9
				arg_493_1.typewritter.percent = 0

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(false)
				arg_493_1:RecordContent(arg_493_1.text_.text)
			end

			local var_496_13 = math.max(var_496_7, arg_493_1.talkMaxDuration)

			if var_496_6 <= arg_493_1.time_ and arg_493_1.time_ < var_496_6 + var_496_13 then
				arg_493_1.typewritter.percent = (arg_493_1.time_ - var_496_6) / var_496_13

				arg_493_1.typewritter:SetDirty()
			end

			if arg_493_1.time_ >= var_496_6 + var_496_13 and arg_493_1.time_ < var_496_6 + var_496_13 + arg_496_0 then
				arg_493_1.typewritter.percent = 1

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(true)
			end
		end

		arg_493_1.nodeConfigList_ = {}

		arg_493_1:InitPlayNodeList()
	end,
	Play320061120 = function(arg_497_0, arg_497_1)
		arg_497_1.time_ = 0
		arg_497_1.frameCnt_ = 0
		arg_497_1.state_ = "playing"
		arg_497_1.curTalkId_ = 320061120
		arg_497_1.duration_ = 5

		SetActive(arg_497_1.tipsGo_, false)

		function arg_497_1.onSingleLineFinish_()
			arg_497_1.onSingleLineUpdate_ = nil
			arg_497_1.onSingleLineFinish_ = nil
			arg_497_1.state_ = "waiting"
		end

		function arg_497_1.playNext_(arg_499_0)
			if arg_499_0 == 1 then
				arg_497_0:Play320061121(arg_497_1)
			end
		end

		function arg_497_1.onSingleLineUpdate_(arg_500_0)
			local var_500_0 = 0
			local var_500_1 = 0.9

			if var_500_0 < arg_497_1.time_ and arg_497_1.time_ <= var_500_0 + arg_500_0 then
				arg_497_1.talkMaxDuration = 0
				arg_497_1.dialogCg_.alpha = 1

				arg_497_1.dialog_:SetActive(true)
				SetActive(arg_497_1.leftNameGo_, false)

				arg_497_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_497_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_497_1:RecordName(arg_497_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_497_1.iconTrs_.gameObject, false)
				arg_497_1.callingController_:SetSelectedState("normal")

				local var_500_2 = arg_497_1:GetWordFromCfg(320061120)
				local var_500_3 = arg_497_1:FormatText(var_500_2.content)

				arg_497_1.text_.text = var_500_3

				LuaForUtil.ClearLinePrefixSymbol(arg_497_1.text_)

				local var_500_4 = 36
				local var_500_5 = utf8.len(var_500_3)
				local var_500_6 = var_500_4 <= 0 and var_500_1 or var_500_1 * (var_500_5 / var_500_4)

				if var_500_6 > 0 and var_500_1 < var_500_6 then
					arg_497_1.talkMaxDuration = var_500_6

					if var_500_6 + var_500_0 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_6 + var_500_0
					end
				end

				arg_497_1.text_.text = var_500_3
				arg_497_1.typewritter.percent = 0

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(false)
				arg_497_1:RecordContent(arg_497_1.text_.text)
			end

			local var_500_7 = math.max(var_500_1, arg_497_1.talkMaxDuration)

			if var_500_0 <= arg_497_1.time_ and arg_497_1.time_ < var_500_0 + var_500_7 then
				arg_497_1.typewritter.percent = (arg_497_1.time_ - var_500_0) / var_500_7

				arg_497_1.typewritter:SetDirty()
			end

			if arg_497_1.time_ >= var_500_0 + var_500_7 and arg_497_1.time_ < var_500_0 + var_500_7 + arg_500_0 then
				arg_497_1.typewritter.percent = 1

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(true)
			end
		end

		arg_497_1.nodeConfigList_ = {}

		arg_497_1:InitPlayNodeList()
	end,
	Play320061121 = function(arg_501_0, arg_501_1)
		arg_501_1.time_ = 0
		arg_501_1.frameCnt_ = 0
		arg_501_1.state_ = "playing"
		arg_501_1.curTalkId_ = 320061121
		arg_501_1.duration_ = 5

		SetActive(arg_501_1.tipsGo_, false)

		function arg_501_1.onSingleLineFinish_()
			arg_501_1.onSingleLineUpdate_ = nil
			arg_501_1.onSingleLineFinish_ = nil
			arg_501_1.state_ = "waiting"
		end

		function arg_501_1.playNext_(arg_503_0)
			if arg_503_0 == 1 then
				arg_501_0:Play320061122(arg_501_1)
			end
		end

		function arg_501_1.onSingleLineUpdate_(arg_504_0)
			local var_504_0 = 0
			local var_504_1 = 0.8

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

				local var_504_3 = arg_501_1:GetWordFromCfg(320061121)
				local var_504_4 = arg_501_1:FormatText(var_504_3.content)

				arg_501_1.text_.text = var_504_4

				LuaForUtil.ClearLinePrefixSymbol(arg_501_1.text_)

				local var_504_5 = 32
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
	Play320061122 = function(arg_505_0, arg_505_1)
		arg_505_1.time_ = 0
		arg_505_1.frameCnt_ = 0
		arg_505_1.state_ = "playing"
		arg_505_1.curTalkId_ = 320061122
		arg_505_1.duration_ = 4.93

		local var_505_0 = {
			zh = 4.933,
			ja = 3.9
		}
		local var_505_1 = manager.audio:GetLocalizationFlag()

		if var_505_0[var_505_1] ~= nil then
			arg_505_1.duration_ = var_505_0[var_505_1]
		end

		SetActive(arg_505_1.tipsGo_, false)

		function arg_505_1.onSingleLineFinish_()
			arg_505_1.onSingleLineUpdate_ = nil
			arg_505_1.onSingleLineFinish_ = nil
			arg_505_1.state_ = "waiting"
		end

		function arg_505_1.playNext_(arg_507_0)
			if arg_507_0 == 1 then
				arg_505_0:Play320061123(arg_505_1)
			end
		end

		function arg_505_1.onSingleLineUpdate_(arg_508_0)
			local var_508_0 = arg_505_1.actors_["1011ui_story"].transform
			local var_508_1 = 0

			if var_508_1 < arg_505_1.time_ and arg_505_1.time_ <= var_508_1 + arg_508_0 then
				arg_505_1.var_.moveOldPos1011ui_story = var_508_0.localPosition
			end

			local var_508_2 = 0.001

			if var_508_1 <= arg_505_1.time_ and arg_505_1.time_ < var_508_1 + var_508_2 then
				local var_508_3 = (arg_505_1.time_ - var_508_1) / var_508_2
				local var_508_4 = Vector3.New(0, -0.71, -6)

				var_508_0.localPosition = Vector3.Lerp(arg_505_1.var_.moveOldPos1011ui_story, var_508_4, var_508_3)

				local var_508_5 = manager.ui.mainCamera.transform.position - var_508_0.position

				var_508_0.forward = Vector3.New(var_508_5.x, var_508_5.y, var_508_5.z)

				local var_508_6 = var_508_0.localEulerAngles

				var_508_6.z = 0
				var_508_6.x = 0
				var_508_0.localEulerAngles = var_508_6
			end

			if arg_505_1.time_ >= var_508_1 + var_508_2 and arg_505_1.time_ < var_508_1 + var_508_2 + arg_508_0 then
				var_508_0.localPosition = Vector3.New(0, -0.71, -6)

				local var_508_7 = manager.ui.mainCamera.transform.position - var_508_0.position

				var_508_0.forward = Vector3.New(var_508_7.x, var_508_7.y, var_508_7.z)

				local var_508_8 = var_508_0.localEulerAngles

				var_508_8.z = 0
				var_508_8.x = 0
				var_508_0.localEulerAngles = var_508_8
			end

			local var_508_9 = arg_505_1.actors_["1011ui_story"]
			local var_508_10 = 0

			if var_508_10 < arg_505_1.time_ and arg_505_1.time_ <= var_508_10 + arg_508_0 and not isNil(var_508_9) and arg_505_1.var_.characterEffect1011ui_story == nil then
				arg_505_1.var_.characterEffect1011ui_story = var_508_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_508_11 = 0.200000002980232

			if var_508_10 <= arg_505_1.time_ and arg_505_1.time_ < var_508_10 + var_508_11 and not isNil(var_508_9) then
				local var_508_12 = (arg_505_1.time_ - var_508_10) / var_508_11

				if arg_505_1.var_.characterEffect1011ui_story and not isNil(var_508_9) then
					arg_505_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_505_1.time_ >= var_508_10 + var_508_11 and arg_505_1.time_ < var_508_10 + var_508_11 + arg_508_0 and not isNil(var_508_9) and arg_505_1.var_.characterEffect1011ui_story then
				arg_505_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_508_13 = 0

			if var_508_13 < arg_505_1.time_ and arg_505_1.time_ <= var_508_13 + arg_508_0 then
				arg_505_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action3_2")
			end

			local var_508_14 = 0

			if var_508_14 < arg_505_1.time_ and arg_505_1.time_ <= var_508_14 + arg_508_0 then
				arg_505_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_508_15 = 0
			local var_508_16 = 0.4

			if var_508_15 < arg_505_1.time_ and arg_505_1.time_ <= var_508_15 + arg_508_0 then
				arg_505_1.talkMaxDuration = 0
				arg_505_1.dialogCg_.alpha = 1

				arg_505_1.dialog_:SetActive(true)
				SetActive(arg_505_1.leftNameGo_, true)

				local var_508_17 = arg_505_1:FormatText(StoryNameCfg[37].name)

				arg_505_1.leftNameTxt_.text = var_508_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_505_1.leftNameTxt_.transform)

				arg_505_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_505_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_505_1:RecordName(arg_505_1.leftNameTxt_.text)
				SetActive(arg_505_1.iconTrs_.gameObject, false)
				arg_505_1.callingController_:SetSelectedState("normal")

				local var_508_18 = arg_505_1:GetWordFromCfg(320061122)
				local var_508_19 = arg_505_1:FormatText(var_508_18.content)

				arg_505_1.text_.text = var_508_19

				LuaForUtil.ClearLinePrefixSymbol(arg_505_1.text_)

				local var_508_20 = 16
				local var_508_21 = utf8.len(var_508_19)
				local var_508_22 = var_508_20 <= 0 and var_508_16 or var_508_16 * (var_508_21 / var_508_20)

				if var_508_22 > 0 and var_508_16 < var_508_22 then
					arg_505_1.talkMaxDuration = var_508_22

					if var_508_22 + var_508_15 > arg_505_1.duration_ then
						arg_505_1.duration_ = var_508_22 + var_508_15
					end
				end

				arg_505_1.text_.text = var_508_19
				arg_505_1.typewritter.percent = 0

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320061", "320061122", "story_v_out_320061.awb") ~= 0 then
					local var_508_23 = manager.audio:GetVoiceLength("story_v_out_320061", "320061122", "story_v_out_320061.awb") / 1000

					if var_508_23 + var_508_15 > arg_505_1.duration_ then
						arg_505_1.duration_ = var_508_23 + var_508_15
					end

					if var_508_18.prefab_name ~= "" and arg_505_1.actors_[var_508_18.prefab_name] ~= nil then
						local var_508_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_505_1.actors_[var_508_18.prefab_name].transform, "story_v_out_320061", "320061122", "story_v_out_320061.awb")

						arg_505_1:RecordAudio("320061122", var_508_24)
						arg_505_1:RecordAudio("320061122", var_508_24)
					else
						arg_505_1:AudioAction("play", "voice", "story_v_out_320061", "320061122", "story_v_out_320061.awb")
					end

					arg_505_1:RecordHistoryTalkVoice("story_v_out_320061", "320061122", "story_v_out_320061.awb")
				end

				arg_505_1:RecordContent(arg_505_1.text_.text)
			end

			local var_508_25 = math.max(var_508_16, arg_505_1.talkMaxDuration)

			if var_508_15 <= arg_505_1.time_ and arg_505_1.time_ < var_508_15 + var_508_25 then
				arg_505_1.typewritter.percent = (arg_505_1.time_ - var_508_15) / var_508_25

				arg_505_1.typewritter:SetDirty()
			end

			if arg_505_1.time_ >= var_508_15 + var_508_25 and arg_505_1.time_ < var_508_15 + var_508_25 + arg_508_0 then
				arg_505_1.typewritter.percent = 1

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(true)
			end
		end

		arg_505_1.nodeConfigList_ = {
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

		arg_505_1:InitPlayNodeList()
	end,
	Play320061123 = function(arg_509_0, arg_509_1)
		arg_509_1.time_ = 0
		arg_509_1.frameCnt_ = 0
		arg_509_1.state_ = "playing"
		arg_509_1.curTalkId_ = 320061123
		arg_509_1.duration_ = 5.8

		local var_509_0 = {
			zh = 3.9,
			ja = 5.8
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
				arg_509_0:Play320061124(arg_509_1)
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
				local var_512_4 = Vector3.New(0, 100, 0)

				var_512_0.localPosition = Vector3.Lerp(arg_509_1.var_.moveOldPos1011ui_story, var_512_4, var_512_3)

				local var_512_5 = manager.ui.mainCamera.transform.position - var_512_0.position

				var_512_0.forward = Vector3.New(var_512_5.x, var_512_5.y, var_512_5.z)

				local var_512_6 = var_512_0.localEulerAngles

				var_512_6.z = 0
				var_512_6.x = 0
				var_512_0.localEulerAngles = var_512_6
			end

			if arg_509_1.time_ >= var_512_1 + var_512_2 and arg_509_1.time_ < var_512_1 + var_512_2 + arg_512_0 then
				var_512_0.localPosition = Vector3.New(0, 100, 0)

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
					local var_512_13 = Mathf.Lerp(0, 0.5, var_512_12)

					arg_509_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_509_1.var_.characterEffect1011ui_story.fillRatio = var_512_13
				end
			end

			if arg_509_1.time_ >= var_512_10 + var_512_11 and arg_509_1.time_ < var_512_10 + var_512_11 + arg_512_0 and not isNil(var_512_9) and arg_509_1.var_.characterEffect1011ui_story then
				local var_512_14 = 0.5

				arg_509_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_509_1.var_.characterEffect1011ui_story.fillRatio = var_512_14
			end

			local var_512_15 = arg_509_1.actors_["10100ui_story"].transform
			local var_512_16 = 0

			if var_512_16 < arg_509_1.time_ and arg_509_1.time_ <= var_512_16 + arg_512_0 then
				arg_509_1.var_.moveOldPos10100ui_story = var_512_15.localPosition
			end

			local var_512_17 = 0.001

			if var_512_16 <= arg_509_1.time_ and arg_509_1.time_ < var_512_16 + var_512_17 then
				local var_512_18 = (arg_509_1.time_ - var_512_16) / var_512_17
				local var_512_19 = Vector3.New(0, -1.16, -6.25)

				var_512_15.localPosition = Vector3.Lerp(arg_509_1.var_.moveOldPos10100ui_story, var_512_19, var_512_18)

				local var_512_20 = manager.ui.mainCamera.transform.position - var_512_15.position

				var_512_15.forward = Vector3.New(var_512_20.x, var_512_20.y, var_512_20.z)

				local var_512_21 = var_512_15.localEulerAngles

				var_512_21.z = 0
				var_512_21.x = 0
				var_512_15.localEulerAngles = var_512_21
			end

			if arg_509_1.time_ >= var_512_16 + var_512_17 and arg_509_1.time_ < var_512_16 + var_512_17 + arg_512_0 then
				var_512_15.localPosition = Vector3.New(0, -1.16, -6.25)

				local var_512_22 = manager.ui.mainCamera.transform.position - var_512_15.position

				var_512_15.forward = Vector3.New(var_512_22.x, var_512_22.y, var_512_22.z)

				local var_512_23 = var_512_15.localEulerAngles

				var_512_23.z = 0
				var_512_23.x = 0
				var_512_15.localEulerAngles = var_512_23
			end

			local var_512_24 = arg_509_1.actors_["10100ui_story"]
			local var_512_25 = 0

			if var_512_25 < arg_509_1.time_ and arg_509_1.time_ <= var_512_25 + arg_512_0 and not isNil(var_512_24) and arg_509_1.var_.characterEffect10100ui_story == nil then
				arg_509_1.var_.characterEffect10100ui_story = var_512_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_512_26 = 0.200000002980232

			if var_512_25 <= arg_509_1.time_ and arg_509_1.time_ < var_512_25 + var_512_26 and not isNil(var_512_24) then
				local var_512_27 = (arg_509_1.time_ - var_512_25) / var_512_26

				if arg_509_1.var_.characterEffect10100ui_story and not isNil(var_512_24) then
					arg_509_1.var_.characterEffect10100ui_story.fillFlat = false
				end
			end

			if arg_509_1.time_ >= var_512_25 + var_512_26 and arg_509_1.time_ < var_512_25 + var_512_26 + arg_512_0 and not isNil(var_512_24) and arg_509_1.var_.characterEffect10100ui_story then
				arg_509_1.var_.characterEffect10100ui_story.fillFlat = false
			end

			local var_512_28 = 0

			if var_512_28 < arg_509_1.time_ and arg_509_1.time_ <= var_512_28 + arg_512_0 then
				arg_509_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action1_1")
			end

			local var_512_29 = 0

			if var_512_29 < arg_509_1.time_ and arg_509_1.time_ <= var_512_29 + arg_512_0 then
				arg_509_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_512_30 = 0
			local var_512_31 = 0.55

			if var_512_30 < arg_509_1.time_ and arg_509_1.time_ <= var_512_30 + arg_512_0 then
				arg_509_1.talkMaxDuration = 0
				arg_509_1.dialogCg_.alpha = 1

				arg_509_1.dialog_:SetActive(true)
				SetActive(arg_509_1.leftNameGo_, true)

				local var_512_32 = arg_509_1:FormatText(StoryNameCfg[1021].name)

				arg_509_1.leftNameTxt_.text = var_512_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_509_1.leftNameTxt_.transform)

				arg_509_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_509_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_509_1:RecordName(arg_509_1.leftNameTxt_.text)
				SetActive(arg_509_1.iconTrs_.gameObject, false)
				arg_509_1.callingController_:SetSelectedState("normal")

				local var_512_33 = arg_509_1:GetWordFromCfg(320061123)
				local var_512_34 = arg_509_1:FormatText(var_512_33.content)

				arg_509_1.text_.text = var_512_34

				LuaForUtil.ClearLinePrefixSymbol(arg_509_1.text_)

				local var_512_35 = 22
				local var_512_36 = utf8.len(var_512_34)
				local var_512_37 = var_512_35 <= 0 and var_512_31 or var_512_31 * (var_512_36 / var_512_35)

				if var_512_37 > 0 and var_512_31 < var_512_37 then
					arg_509_1.talkMaxDuration = var_512_37

					if var_512_37 + var_512_30 > arg_509_1.duration_ then
						arg_509_1.duration_ = var_512_37 + var_512_30
					end
				end

				arg_509_1.text_.text = var_512_34
				arg_509_1.typewritter.percent = 0

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320061", "320061123", "story_v_out_320061.awb") ~= 0 then
					local var_512_38 = manager.audio:GetVoiceLength("story_v_out_320061", "320061123", "story_v_out_320061.awb") / 1000

					if var_512_38 + var_512_30 > arg_509_1.duration_ then
						arg_509_1.duration_ = var_512_38 + var_512_30
					end

					if var_512_33.prefab_name ~= "" and arg_509_1.actors_[var_512_33.prefab_name] ~= nil then
						local var_512_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_509_1.actors_[var_512_33.prefab_name].transform, "story_v_out_320061", "320061123", "story_v_out_320061.awb")

						arg_509_1:RecordAudio("320061123", var_512_39)
						arg_509_1:RecordAudio("320061123", var_512_39)
					else
						arg_509_1:AudioAction("play", "voice", "story_v_out_320061", "320061123", "story_v_out_320061.awb")
					end

					arg_509_1:RecordHistoryTalkVoice("story_v_out_320061", "320061123", "story_v_out_320061.awb")
				end

				arg_509_1:RecordContent(arg_509_1.text_.text)
			end

			local var_512_40 = math.max(var_512_31, arg_509_1.talkMaxDuration)

			if var_512_30 <= arg_509_1.time_ and arg_509_1.time_ < var_512_30 + var_512_40 then
				arg_509_1.typewritter.percent = (arg_509_1.time_ - var_512_30) / var_512_40

				arg_509_1.typewritter:SetDirty()
			end

			if arg_509_1.time_ >= var_512_30 + var_512_40 and arg_509_1.time_ < var_512_30 + var_512_40 + arg_512_0 then
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
			},
			{
				assetPath = "",
				actorName = "10100ui_story",
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
	Play320061124 = function(arg_513_0, arg_513_1)
		arg_513_1.time_ = 0
		arg_513_1.frameCnt_ = 0
		arg_513_1.state_ = "playing"
		arg_513_1.curTalkId_ = 320061124
		arg_513_1.duration_ = 4.53

		local var_513_0 = {
			zh = 3.733,
			ja = 4.533
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
				arg_513_0:Play320061125(arg_513_1)
			end
		end

		function arg_513_1.onSingleLineUpdate_(arg_516_0)
			local var_516_0 = 0
			local var_516_1 = 0.425

			if var_516_0 < arg_513_1.time_ and arg_513_1.time_ <= var_516_0 + arg_516_0 then
				arg_513_1.talkMaxDuration = 0
				arg_513_1.dialogCg_.alpha = 1

				arg_513_1.dialog_:SetActive(true)
				SetActive(arg_513_1.leftNameGo_, true)

				local var_516_2 = arg_513_1:FormatText(StoryNameCfg[1021].name)

				arg_513_1.leftNameTxt_.text = var_516_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_513_1.leftNameTxt_.transform)

				arg_513_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_513_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_513_1:RecordName(arg_513_1.leftNameTxt_.text)
				SetActive(arg_513_1.iconTrs_.gameObject, false)
				arg_513_1.callingController_:SetSelectedState("normal")

				local var_516_3 = arg_513_1:GetWordFromCfg(320061124)
				local var_516_4 = arg_513_1:FormatText(var_516_3.content)

				arg_513_1.text_.text = var_516_4

				LuaForUtil.ClearLinePrefixSymbol(arg_513_1.text_)

				local var_516_5 = 17
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

				if manager.audio:GetVoiceLength("story_v_out_320061", "320061124", "story_v_out_320061.awb") ~= 0 then
					local var_516_8 = manager.audio:GetVoiceLength("story_v_out_320061", "320061124", "story_v_out_320061.awb") / 1000

					if var_516_8 + var_516_0 > arg_513_1.duration_ then
						arg_513_1.duration_ = var_516_8 + var_516_0
					end

					if var_516_3.prefab_name ~= "" and arg_513_1.actors_[var_516_3.prefab_name] ~= nil then
						local var_516_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_513_1.actors_[var_516_3.prefab_name].transform, "story_v_out_320061", "320061124", "story_v_out_320061.awb")

						arg_513_1:RecordAudio("320061124", var_516_9)
						arg_513_1:RecordAudio("320061124", var_516_9)
					else
						arg_513_1:AudioAction("play", "voice", "story_v_out_320061", "320061124", "story_v_out_320061.awb")
					end

					arg_513_1:RecordHistoryTalkVoice("story_v_out_320061", "320061124", "story_v_out_320061.awb")
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
	Play320061125 = function(arg_517_0, arg_517_1)
		arg_517_1.time_ = 0
		arg_517_1.frameCnt_ = 0
		arg_517_1.state_ = "playing"
		arg_517_1.curTalkId_ = 320061125
		arg_517_1.duration_ = 4.57

		local var_517_0 = {
			zh = 4.433,
			ja = 4.566
		}
		local var_517_1 = manager.audio:GetLocalizationFlag()

		if var_517_0[var_517_1] ~= nil then
			arg_517_1.duration_ = var_517_0[var_517_1]
		end

		SetActive(arg_517_1.tipsGo_, false)

		function arg_517_1.onSingleLineFinish_()
			arg_517_1.onSingleLineUpdate_ = nil
			arg_517_1.onSingleLineFinish_ = nil
			arg_517_1.state_ = "waiting"
		end

		function arg_517_1.playNext_(arg_519_0)
			if arg_519_0 == 1 then
				arg_517_0:Play320061126(arg_517_1)
			end
		end

		function arg_517_1.onSingleLineUpdate_(arg_520_0)
			local var_520_0 = 0

			if var_520_0 < arg_517_1.time_ and arg_517_1.time_ <= var_520_0 + arg_520_0 then
				arg_517_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action4_1")
			end

			local var_520_1 = 0

			if var_520_1 < arg_517_1.time_ and arg_517_1.time_ <= var_520_1 + arg_520_0 then
				arg_517_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_520_2 = 0
			local var_520_3 = 0.4

			if var_520_2 < arg_517_1.time_ and arg_517_1.time_ <= var_520_2 + arg_520_0 then
				arg_517_1.talkMaxDuration = 0
				arg_517_1.dialogCg_.alpha = 1

				arg_517_1.dialog_:SetActive(true)
				SetActive(arg_517_1.leftNameGo_, true)

				local var_520_4 = arg_517_1:FormatText(StoryNameCfg[1021].name)

				arg_517_1.leftNameTxt_.text = var_520_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_517_1.leftNameTxt_.transform)

				arg_517_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_517_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_517_1:RecordName(arg_517_1.leftNameTxt_.text)
				SetActive(arg_517_1.iconTrs_.gameObject, false)
				arg_517_1.callingController_:SetSelectedState("normal")

				local var_520_5 = arg_517_1:GetWordFromCfg(320061125)
				local var_520_6 = arg_517_1:FormatText(var_520_5.content)

				arg_517_1.text_.text = var_520_6

				LuaForUtil.ClearLinePrefixSymbol(arg_517_1.text_)

				local var_520_7 = 16
				local var_520_8 = utf8.len(var_520_6)
				local var_520_9 = var_520_7 <= 0 and var_520_3 or var_520_3 * (var_520_8 / var_520_7)

				if var_520_9 > 0 and var_520_3 < var_520_9 then
					arg_517_1.talkMaxDuration = var_520_9

					if var_520_9 + var_520_2 > arg_517_1.duration_ then
						arg_517_1.duration_ = var_520_9 + var_520_2
					end
				end

				arg_517_1.text_.text = var_520_6
				arg_517_1.typewritter.percent = 0

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320061", "320061125", "story_v_out_320061.awb") ~= 0 then
					local var_520_10 = manager.audio:GetVoiceLength("story_v_out_320061", "320061125", "story_v_out_320061.awb") / 1000

					if var_520_10 + var_520_2 > arg_517_1.duration_ then
						arg_517_1.duration_ = var_520_10 + var_520_2
					end

					if var_520_5.prefab_name ~= "" and arg_517_1.actors_[var_520_5.prefab_name] ~= nil then
						local var_520_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_517_1.actors_[var_520_5.prefab_name].transform, "story_v_out_320061", "320061125", "story_v_out_320061.awb")

						arg_517_1:RecordAudio("320061125", var_520_11)
						arg_517_1:RecordAudio("320061125", var_520_11)
					else
						arg_517_1:AudioAction("play", "voice", "story_v_out_320061", "320061125", "story_v_out_320061.awb")
					end

					arg_517_1:RecordHistoryTalkVoice("story_v_out_320061", "320061125", "story_v_out_320061.awb")
				end

				arg_517_1:RecordContent(arg_517_1.text_.text)
			end

			local var_520_12 = math.max(var_520_3, arg_517_1.talkMaxDuration)

			if var_520_2 <= arg_517_1.time_ and arg_517_1.time_ < var_520_2 + var_520_12 then
				arg_517_1.typewritter.percent = (arg_517_1.time_ - var_520_2) / var_520_12

				arg_517_1.typewritter:SetDirty()
			end

			if arg_517_1.time_ >= var_520_2 + var_520_12 and arg_517_1.time_ < var_520_2 + var_520_12 + arg_520_0 then
				arg_517_1.typewritter.percent = 1

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(true)
			end
		end

		arg_517_1.nodeConfigList_ = {}

		arg_517_1:InitPlayNodeList()
	end,
	Play320061126 = function(arg_521_0, arg_521_1)
		arg_521_1.time_ = 0
		arg_521_1.frameCnt_ = 0
		arg_521_1.state_ = "playing"
		arg_521_1.curTalkId_ = 320061126
		arg_521_1.duration_ = 5

		SetActive(arg_521_1.tipsGo_, false)

		function arg_521_1.onSingleLineFinish_()
			arg_521_1.onSingleLineUpdate_ = nil
			arg_521_1.onSingleLineFinish_ = nil
			arg_521_1.state_ = "waiting"
		end

		function arg_521_1.playNext_(arg_523_0)
			if arg_523_0 == 1 then
				arg_521_0:Play320061127(arg_521_1)
			end
		end

		function arg_521_1.onSingleLineUpdate_(arg_524_0)
			local var_524_0 = arg_521_1.actors_["10100ui_story"].transform
			local var_524_1 = 0

			if var_524_1 < arg_521_1.time_ and arg_521_1.time_ <= var_524_1 + arg_524_0 then
				arg_521_1.var_.moveOldPos10100ui_story = var_524_0.localPosition
			end

			local var_524_2 = 0.001

			if var_524_1 <= arg_521_1.time_ and arg_521_1.time_ < var_524_1 + var_524_2 then
				local var_524_3 = (arg_521_1.time_ - var_524_1) / var_524_2
				local var_524_4 = Vector3.New(0, 100, 0)

				var_524_0.localPosition = Vector3.Lerp(arg_521_1.var_.moveOldPos10100ui_story, var_524_4, var_524_3)

				local var_524_5 = manager.ui.mainCamera.transform.position - var_524_0.position

				var_524_0.forward = Vector3.New(var_524_5.x, var_524_5.y, var_524_5.z)

				local var_524_6 = var_524_0.localEulerAngles

				var_524_6.z = 0
				var_524_6.x = 0
				var_524_0.localEulerAngles = var_524_6
			end

			if arg_521_1.time_ >= var_524_1 + var_524_2 and arg_521_1.time_ < var_524_1 + var_524_2 + arg_524_0 then
				var_524_0.localPosition = Vector3.New(0, 100, 0)

				local var_524_7 = manager.ui.mainCamera.transform.position - var_524_0.position

				var_524_0.forward = Vector3.New(var_524_7.x, var_524_7.y, var_524_7.z)

				local var_524_8 = var_524_0.localEulerAngles

				var_524_8.z = 0
				var_524_8.x = 0
				var_524_0.localEulerAngles = var_524_8
			end

			local var_524_9 = arg_521_1.actors_["10100ui_story"]
			local var_524_10 = 0

			if var_524_10 < arg_521_1.time_ and arg_521_1.time_ <= var_524_10 + arg_524_0 and not isNil(var_524_9) and arg_521_1.var_.characterEffect10100ui_story == nil then
				arg_521_1.var_.characterEffect10100ui_story = var_524_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_524_11 = 0.200000002980232

			if var_524_10 <= arg_521_1.time_ and arg_521_1.time_ < var_524_10 + var_524_11 and not isNil(var_524_9) then
				local var_524_12 = (arg_521_1.time_ - var_524_10) / var_524_11

				if arg_521_1.var_.characterEffect10100ui_story and not isNil(var_524_9) then
					local var_524_13 = Mathf.Lerp(0, 0.5, var_524_12)

					arg_521_1.var_.characterEffect10100ui_story.fillFlat = true
					arg_521_1.var_.characterEffect10100ui_story.fillRatio = var_524_13
				end
			end

			if arg_521_1.time_ >= var_524_10 + var_524_11 and arg_521_1.time_ < var_524_10 + var_524_11 + arg_524_0 and not isNil(var_524_9) and arg_521_1.var_.characterEffect10100ui_story then
				local var_524_14 = 0.5

				arg_521_1.var_.characterEffect10100ui_story.fillFlat = true
				arg_521_1.var_.characterEffect10100ui_story.fillRatio = var_524_14
			end

			local var_524_15 = 0
			local var_524_16 = 1.025

			if var_524_15 < arg_521_1.time_ and arg_521_1.time_ <= var_524_15 + arg_524_0 then
				arg_521_1.talkMaxDuration = 0
				arg_521_1.dialogCg_.alpha = 1

				arg_521_1.dialog_:SetActive(true)
				SetActive(arg_521_1.leftNameGo_, false)

				arg_521_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_521_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_521_1:RecordName(arg_521_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_521_1.iconTrs_.gameObject, false)
				arg_521_1.callingController_:SetSelectedState("normal")

				local var_524_17 = arg_521_1:GetWordFromCfg(320061126)
				local var_524_18 = arg_521_1:FormatText(var_524_17.content)

				arg_521_1.text_.text = var_524_18

				LuaForUtil.ClearLinePrefixSymbol(arg_521_1.text_)

				local var_524_19 = 41
				local var_524_20 = utf8.len(var_524_18)
				local var_524_21 = var_524_19 <= 0 and var_524_16 or var_524_16 * (var_524_20 / var_524_19)

				if var_524_21 > 0 and var_524_16 < var_524_21 then
					arg_521_1.talkMaxDuration = var_524_21

					if var_524_21 + var_524_15 > arg_521_1.duration_ then
						arg_521_1.duration_ = var_524_21 + var_524_15
					end
				end

				arg_521_1.text_.text = var_524_18
				arg_521_1.typewritter.percent = 0

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(false)
				arg_521_1:RecordContent(arg_521_1.text_.text)
			end

			local var_524_22 = math.max(var_524_16, arg_521_1.talkMaxDuration)

			if var_524_15 <= arg_521_1.time_ and arg_521_1.time_ < var_524_15 + var_524_22 then
				arg_521_1.typewritter.percent = (arg_521_1.time_ - var_524_15) / var_524_22

				arg_521_1.typewritter:SetDirty()
			end

			if arg_521_1.time_ >= var_524_15 + var_524_22 and arg_521_1.time_ < var_524_15 + var_524_22 + arg_524_0 then
				arg_521_1.typewritter.percent = 1

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(true)
			end
		end

		arg_521_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10100ui_story",
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
	Play320061127 = function(arg_525_0, arg_525_1)
		arg_525_1.time_ = 0
		arg_525_1.frameCnt_ = 0
		arg_525_1.state_ = "playing"
		arg_525_1.curTalkId_ = 320061127
		arg_525_1.duration_ = 5

		SetActive(arg_525_1.tipsGo_, false)

		function arg_525_1.onSingleLineFinish_()
			arg_525_1.onSingleLineUpdate_ = nil
			arg_525_1.onSingleLineFinish_ = nil
			arg_525_1.state_ = "waiting"
		end

		function arg_525_1.playNext_(arg_527_0)
			if arg_527_0 == 1 then
				arg_525_0:Play320061128(arg_525_1)
			end
		end

		function arg_525_1.onSingleLineUpdate_(arg_528_0)
			local var_528_0 = 0
			local var_528_1 = 1

			if var_528_0 < arg_525_1.time_ and arg_525_1.time_ <= var_528_0 + arg_528_0 then
				local var_528_2 = "play"
				local var_528_3 = "effect"

				arg_525_1:AudioAction(var_528_2, var_528_3, "se_story_side_1148", "se_story_1148_explosion", "")
			end

			local var_528_4 = 0
			local var_528_5 = 1

			if var_528_4 < arg_525_1.time_ and arg_525_1.time_ <= var_528_4 + arg_528_0 then
				arg_525_1.talkMaxDuration = 0
				arg_525_1.dialogCg_.alpha = 1

				arg_525_1.dialog_:SetActive(true)
				SetActive(arg_525_1.leftNameGo_, false)

				arg_525_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_525_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_525_1:RecordName(arg_525_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_525_1.iconTrs_.gameObject, false)
				arg_525_1.callingController_:SetSelectedState("normal")

				local var_528_6 = arg_525_1:GetWordFromCfg(320061127)
				local var_528_7 = arg_525_1:FormatText(var_528_6.content)

				arg_525_1.text_.text = var_528_7

				LuaForUtil.ClearLinePrefixSymbol(arg_525_1.text_)

				local var_528_8 = 40
				local var_528_9 = utf8.len(var_528_7)
				local var_528_10 = var_528_8 <= 0 and var_528_5 or var_528_5 * (var_528_9 / var_528_8)

				if var_528_10 > 0 and var_528_5 < var_528_10 then
					arg_525_1.talkMaxDuration = var_528_10

					if var_528_10 + var_528_4 > arg_525_1.duration_ then
						arg_525_1.duration_ = var_528_10 + var_528_4
					end
				end

				arg_525_1.text_.text = var_528_7
				arg_525_1.typewritter.percent = 0

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(false)
				arg_525_1:RecordContent(arg_525_1.text_.text)
			end

			local var_528_11 = math.max(var_528_5, arg_525_1.talkMaxDuration)

			if var_528_4 <= arg_525_1.time_ and arg_525_1.time_ < var_528_4 + var_528_11 then
				arg_525_1.typewritter.percent = (arg_525_1.time_ - var_528_4) / var_528_11

				arg_525_1.typewritter:SetDirty()
			end

			if arg_525_1.time_ >= var_528_4 + var_528_11 and arg_525_1.time_ < var_528_4 + var_528_11 + arg_528_0 then
				arg_525_1.typewritter.percent = 1

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(true)
			end
		end

		arg_525_1.nodeConfigList_ = {}

		arg_525_1:InitPlayNodeList()
	end,
	Play320061128 = function(arg_529_0, arg_529_1)
		arg_529_1.time_ = 0
		arg_529_1.frameCnt_ = 0
		arg_529_1.state_ = "playing"
		arg_529_1.curTalkId_ = 320061128
		arg_529_1.duration_ = 7.07

		local var_529_0 = {
			zh = 5.433,
			ja = 7.066
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
				arg_529_0:Play320061129(arg_529_1)
			end
		end

		function arg_529_1.onSingleLineUpdate_(arg_532_0)
			local var_532_0 = arg_529_1.actors_["10100ui_story"].transform
			local var_532_1 = 0

			if var_532_1 < arg_529_1.time_ and arg_529_1.time_ <= var_532_1 + arg_532_0 then
				arg_529_1.var_.moveOldPos10100ui_story = var_532_0.localPosition
			end

			local var_532_2 = 0.001

			if var_532_1 <= arg_529_1.time_ and arg_529_1.time_ < var_532_1 + var_532_2 then
				local var_532_3 = (arg_529_1.time_ - var_532_1) / var_532_2
				local var_532_4 = Vector3.New(0, -1.16, -6.25)

				var_532_0.localPosition = Vector3.Lerp(arg_529_1.var_.moveOldPos10100ui_story, var_532_4, var_532_3)

				local var_532_5 = manager.ui.mainCamera.transform.position - var_532_0.position

				var_532_0.forward = Vector3.New(var_532_5.x, var_532_5.y, var_532_5.z)

				local var_532_6 = var_532_0.localEulerAngles

				var_532_6.z = 0
				var_532_6.x = 0
				var_532_0.localEulerAngles = var_532_6
			end

			if arg_529_1.time_ >= var_532_1 + var_532_2 and arg_529_1.time_ < var_532_1 + var_532_2 + arg_532_0 then
				var_532_0.localPosition = Vector3.New(0, -1.16, -6.25)

				local var_532_7 = manager.ui.mainCamera.transform.position - var_532_0.position

				var_532_0.forward = Vector3.New(var_532_7.x, var_532_7.y, var_532_7.z)

				local var_532_8 = var_532_0.localEulerAngles

				var_532_8.z = 0
				var_532_8.x = 0
				var_532_0.localEulerAngles = var_532_8
			end

			local var_532_9 = arg_529_1.actors_["10100ui_story"]
			local var_532_10 = 0

			if var_532_10 < arg_529_1.time_ and arg_529_1.time_ <= var_532_10 + arg_532_0 and not isNil(var_532_9) and arg_529_1.var_.characterEffect10100ui_story == nil then
				arg_529_1.var_.characterEffect10100ui_story = var_532_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_532_11 = 0.200000002980232

			if var_532_10 <= arg_529_1.time_ and arg_529_1.time_ < var_532_10 + var_532_11 and not isNil(var_532_9) then
				local var_532_12 = (arg_529_1.time_ - var_532_10) / var_532_11

				if arg_529_1.var_.characterEffect10100ui_story and not isNil(var_532_9) then
					arg_529_1.var_.characterEffect10100ui_story.fillFlat = false
				end
			end

			if arg_529_1.time_ >= var_532_10 + var_532_11 and arg_529_1.time_ < var_532_10 + var_532_11 + arg_532_0 and not isNil(var_532_9) and arg_529_1.var_.characterEffect10100ui_story then
				arg_529_1.var_.characterEffect10100ui_story.fillFlat = false
			end

			local var_532_13 = 0

			if var_532_13 < arg_529_1.time_ and arg_529_1.time_ <= var_532_13 + arg_532_0 then
				arg_529_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/story10053/story10053actionlink/10053action4418")
			end

			local var_532_14 = 0

			if var_532_14 < arg_529_1.time_ and arg_529_1.time_ <= var_532_14 + arg_532_0 then
				arg_529_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_532_15 = 0
			local var_532_16 = 0.625

			if var_532_15 < arg_529_1.time_ and arg_529_1.time_ <= var_532_15 + arg_532_0 then
				arg_529_1.talkMaxDuration = 0
				arg_529_1.dialogCg_.alpha = 1

				arg_529_1.dialog_:SetActive(true)
				SetActive(arg_529_1.leftNameGo_, true)

				local var_532_17 = arg_529_1:FormatText(StoryNameCfg[1021].name)

				arg_529_1.leftNameTxt_.text = var_532_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_529_1.leftNameTxt_.transform)

				arg_529_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_529_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_529_1:RecordName(arg_529_1.leftNameTxt_.text)
				SetActive(arg_529_1.iconTrs_.gameObject, false)
				arg_529_1.callingController_:SetSelectedState("normal")

				local var_532_18 = arg_529_1:GetWordFromCfg(320061128)
				local var_532_19 = arg_529_1:FormatText(var_532_18.content)

				arg_529_1.text_.text = var_532_19

				LuaForUtil.ClearLinePrefixSymbol(arg_529_1.text_)

				local var_532_20 = 25
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

				if manager.audio:GetVoiceLength("story_v_out_320061", "320061128", "story_v_out_320061.awb") ~= 0 then
					local var_532_23 = manager.audio:GetVoiceLength("story_v_out_320061", "320061128", "story_v_out_320061.awb") / 1000

					if var_532_23 + var_532_15 > arg_529_1.duration_ then
						arg_529_1.duration_ = var_532_23 + var_532_15
					end

					if var_532_18.prefab_name ~= "" and arg_529_1.actors_[var_532_18.prefab_name] ~= nil then
						local var_532_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_529_1.actors_[var_532_18.prefab_name].transform, "story_v_out_320061", "320061128", "story_v_out_320061.awb")

						arg_529_1:RecordAudio("320061128", var_532_24)
						arg_529_1:RecordAudio("320061128", var_532_24)
					else
						arg_529_1:AudioAction("play", "voice", "story_v_out_320061", "320061128", "story_v_out_320061.awb")
					end

					arg_529_1:RecordHistoryTalkVoice("story_v_out_320061", "320061128", "story_v_out_320061.awb")
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
				actorName = "10100ui_story",
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
	Play320061129 = function(arg_533_0, arg_533_1)
		arg_533_1.time_ = 0
		arg_533_1.frameCnt_ = 0
		arg_533_1.state_ = "playing"
		arg_533_1.curTalkId_ = 320061129
		arg_533_1.duration_ = 9

		SetActive(arg_533_1.tipsGo_, false)

		function arg_533_1.onSingleLineFinish_()
			arg_533_1.onSingleLineUpdate_ = nil
			arg_533_1.onSingleLineFinish_ = nil
			arg_533_1.state_ = "waiting"
		end

		function arg_533_1.playNext_(arg_535_0)
			if arg_535_0 == 1 then
				arg_533_0:Play320061130(arg_533_1)
			end
		end

		function arg_533_1.onSingleLineUpdate_(arg_536_0)
			local var_536_0 = 2

			if var_536_0 < arg_533_1.time_ and arg_533_1.time_ <= var_536_0 + arg_536_0 then
				local var_536_1 = manager.ui.mainCamera.transform.localPosition
				local var_536_2 = Vector3.New(0, 0, 10) + Vector3.New(var_536_1.x, var_536_1.y, 0)
				local var_536_3 = arg_533_1.bgs_.ST0503

				var_536_3.transform.localPosition = var_536_2
				var_536_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_536_4 = var_536_3:GetComponent("SpriteRenderer")

				if var_536_4 and var_536_4.sprite then
					local var_536_5 = (var_536_3.transform.localPosition - var_536_1).z
					local var_536_6 = manager.ui.mainCameraCom_
					local var_536_7 = 2 * var_536_5 * Mathf.Tan(var_536_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_536_8 = var_536_7 * var_536_6.aspect
					local var_536_9 = var_536_4.sprite.bounds.size.x
					local var_536_10 = var_536_4.sprite.bounds.size.y
					local var_536_11 = var_536_8 / var_536_9
					local var_536_12 = var_536_7 / var_536_10
					local var_536_13 = var_536_12 < var_536_11 and var_536_11 or var_536_12

					var_536_3.transform.localScale = Vector3.New(var_536_13, var_536_13, 0)
				end

				for iter_536_0, iter_536_1 in pairs(arg_533_1.bgs_) do
					if iter_536_0 ~= "ST0503" then
						iter_536_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_536_14 = 4

			if var_536_14 < arg_533_1.time_ and arg_533_1.time_ <= var_536_14 + arg_536_0 then
				arg_533_1.allBtn_.enabled = false
			end

			local var_536_15 = 0.3

			if arg_533_1.time_ >= var_536_14 + var_536_15 and arg_533_1.time_ < var_536_14 + var_536_15 + arg_536_0 then
				arg_533_1.allBtn_.enabled = true
			end

			local var_536_16 = 0

			if var_536_16 < arg_533_1.time_ and arg_533_1.time_ <= var_536_16 + arg_536_0 then
				arg_533_1.mask_.enabled = true
				arg_533_1.mask_.raycastTarget = true

				arg_533_1:SetGaussion(false)
			end

			local var_536_17 = 2

			if var_536_16 <= arg_533_1.time_ and arg_533_1.time_ < var_536_16 + var_536_17 then
				local var_536_18 = (arg_533_1.time_ - var_536_16) / var_536_17
				local var_536_19 = Color.New(0, 0, 0)

				var_536_19.a = Mathf.Lerp(0, 1, var_536_18)
				arg_533_1.mask_.color = var_536_19
			end

			if arg_533_1.time_ >= var_536_16 + var_536_17 and arg_533_1.time_ < var_536_16 + var_536_17 + arg_536_0 then
				local var_536_20 = Color.New(0, 0, 0)

				var_536_20.a = 1
				arg_533_1.mask_.color = var_536_20
			end

			local var_536_21 = 2

			if var_536_21 < arg_533_1.time_ and arg_533_1.time_ <= var_536_21 + arg_536_0 then
				arg_533_1.mask_.enabled = true
				arg_533_1.mask_.raycastTarget = true

				arg_533_1:SetGaussion(false)
			end

			local var_536_22 = 2

			if var_536_21 <= arg_533_1.time_ and arg_533_1.time_ < var_536_21 + var_536_22 then
				local var_536_23 = (arg_533_1.time_ - var_536_21) / var_536_22
				local var_536_24 = Color.New(0, 0, 0)

				var_536_24.a = Mathf.Lerp(1, 0, var_536_23)
				arg_533_1.mask_.color = var_536_24
			end

			if arg_533_1.time_ >= var_536_21 + var_536_22 and arg_533_1.time_ < var_536_21 + var_536_22 + arg_536_0 then
				local var_536_25 = Color.New(0, 0, 0)
				local var_536_26 = 0

				arg_533_1.mask_.enabled = false
				var_536_25.a = var_536_26
				arg_533_1.mask_.color = var_536_25
			end

			local var_536_27 = arg_533_1.actors_["10100ui_story"].transform
			local var_536_28 = 1.96599999815226

			if var_536_28 < arg_533_1.time_ and arg_533_1.time_ <= var_536_28 + arg_536_0 then
				arg_533_1.var_.moveOldPos10100ui_story = var_536_27.localPosition
			end

			local var_536_29 = 0.001

			if var_536_28 <= arg_533_1.time_ and arg_533_1.time_ < var_536_28 + var_536_29 then
				local var_536_30 = (arg_533_1.time_ - var_536_28) / var_536_29
				local var_536_31 = Vector3.New(0, 100, 0)

				var_536_27.localPosition = Vector3.Lerp(arg_533_1.var_.moveOldPos10100ui_story, var_536_31, var_536_30)

				local var_536_32 = manager.ui.mainCamera.transform.position - var_536_27.position

				var_536_27.forward = Vector3.New(var_536_32.x, var_536_32.y, var_536_32.z)

				local var_536_33 = var_536_27.localEulerAngles

				var_536_33.z = 0
				var_536_33.x = 0
				var_536_27.localEulerAngles = var_536_33
			end

			if arg_533_1.time_ >= var_536_28 + var_536_29 and arg_533_1.time_ < var_536_28 + var_536_29 + arg_536_0 then
				var_536_27.localPosition = Vector3.New(0, 100, 0)

				local var_536_34 = manager.ui.mainCamera.transform.position - var_536_27.position

				var_536_27.forward = Vector3.New(var_536_34.x, var_536_34.y, var_536_34.z)

				local var_536_35 = var_536_27.localEulerAngles

				var_536_35.z = 0
				var_536_35.x = 0
				var_536_27.localEulerAngles = var_536_35
			end

			local var_536_36 = arg_533_1.actors_["10100ui_story"]
			local var_536_37 = 1.96599999815226

			if var_536_37 < arg_533_1.time_ and arg_533_1.time_ <= var_536_37 + arg_536_0 and not isNil(var_536_36) and arg_533_1.var_.characterEffect10100ui_story == nil then
				arg_533_1.var_.characterEffect10100ui_story = var_536_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_536_38 = 0.034000001847744

			if var_536_37 <= arg_533_1.time_ and arg_533_1.time_ < var_536_37 + var_536_38 and not isNil(var_536_36) then
				local var_536_39 = (arg_533_1.time_ - var_536_37) / var_536_38

				if arg_533_1.var_.characterEffect10100ui_story and not isNil(var_536_36) then
					local var_536_40 = Mathf.Lerp(0, 0.5, var_536_39)

					arg_533_1.var_.characterEffect10100ui_story.fillFlat = true
					arg_533_1.var_.characterEffect10100ui_story.fillRatio = var_536_40
				end
			end

			if arg_533_1.time_ >= var_536_37 + var_536_38 and arg_533_1.time_ < var_536_37 + var_536_38 + arg_536_0 and not isNil(var_536_36) and arg_533_1.var_.characterEffect10100ui_story then
				local var_536_41 = 0.5

				arg_533_1.var_.characterEffect10100ui_story.fillFlat = true
				arg_533_1.var_.characterEffect10100ui_story.fillRatio = var_536_41
			end

			if arg_533_1.frameCnt_ <= 1 then
				arg_533_1.dialog_:SetActive(false)
			end

			local var_536_42 = 4
			local var_536_43 = 1.675

			if var_536_42 < arg_533_1.time_ and arg_533_1.time_ <= var_536_42 + arg_536_0 then
				arg_533_1.talkMaxDuration = 0

				arg_533_1.dialog_:SetActive(true)

				arg_533_1.dialogCg_.alpha = 0

				local var_536_44 = LeanTween.value(arg_533_1.dialog_, 0, 1, 0.3)

				var_536_44:setOnUpdate(LuaHelper.FloatAction(function(arg_537_0)
					arg_533_1.dialogCg_.alpha = arg_537_0
				end))
				var_536_44:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_533_1.dialog_)
					var_536_44:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_533_1.duration_ = arg_533_1.duration_ + 0.3

				SetActive(arg_533_1.leftNameGo_, false)

				arg_533_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_533_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_533_1:RecordName(arg_533_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_533_1.iconTrs_.gameObject, false)
				arg_533_1.callingController_:SetSelectedState("normal")

				local var_536_45 = arg_533_1:GetWordFromCfg(320061129)
				local var_536_46 = arg_533_1:FormatText(var_536_45.content)

				arg_533_1.text_.text = var_536_46

				LuaForUtil.ClearLinePrefixSymbol(arg_533_1.text_)

				local var_536_47 = 67
				local var_536_48 = utf8.len(var_536_46)
				local var_536_49 = var_536_47 <= 0 and var_536_43 or var_536_43 * (var_536_48 / var_536_47)

				if var_536_49 > 0 and var_536_43 < var_536_49 then
					arg_533_1.talkMaxDuration = var_536_49
					var_536_42 = var_536_42 + 0.3

					if var_536_49 + var_536_42 > arg_533_1.duration_ then
						arg_533_1.duration_ = var_536_49 + var_536_42
					end
				end

				arg_533_1.text_.text = var_536_46
				arg_533_1.typewritter.percent = 0

				arg_533_1.typewritter:SetDirty()
				arg_533_1:ShowNextGo(false)
				arg_533_1:RecordContent(arg_533_1.text_.text)
			end

			local var_536_50 = var_536_42 + 0.3
			local var_536_51 = math.max(var_536_43, arg_533_1.talkMaxDuration)

			if var_536_50 <= arg_533_1.time_ and arg_533_1.time_ < var_536_50 + var_536_51 then
				arg_533_1.typewritter.percent = (arg_533_1.time_ - var_536_50) / var_536_51

				arg_533_1.typewritter:SetDirty()
			end

			if arg_533_1.time_ >= var_536_50 + var_536_51 and arg_533_1.time_ < var_536_50 + var_536_51 + arg_536_0 then
				arg_533_1.typewritter.percent = 1

				arg_533_1.typewritter:SetDirty()
				arg_533_1:ShowNextGo(true)
			end
		end

		arg_533_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10100ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_533_1:InitPlayNodeList()
	end,
	Play320061130 = function(arg_539_0, arg_539_1)
		arg_539_1.time_ = 0
		arg_539_1.frameCnt_ = 0
		arg_539_1.state_ = "playing"
		arg_539_1.curTalkId_ = 320061130
		arg_539_1.duration_ = 5

		SetActive(arg_539_1.tipsGo_, false)

		function arg_539_1.onSingleLineFinish_()
			arg_539_1.onSingleLineUpdate_ = nil
			arg_539_1.onSingleLineFinish_ = nil
			arg_539_1.state_ = "waiting"
		end

		function arg_539_1.playNext_(arg_541_0)
			if arg_541_0 == 1 then
				arg_539_0:Play320061131(arg_539_1)
			end
		end

		function arg_539_1.onSingleLineUpdate_(arg_542_0)
			local var_542_0 = 0
			local var_542_1 = 0.3

			if var_542_0 < arg_539_1.time_ and arg_539_1.time_ <= var_542_0 + arg_542_0 then
				arg_539_1.talkMaxDuration = 0
				arg_539_1.dialogCg_.alpha = 1

				arg_539_1.dialog_:SetActive(true)
				SetActive(arg_539_1.leftNameGo_, true)

				local var_542_2 = arg_539_1:FormatText(StoryNameCfg[7].name)

				arg_539_1.leftNameTxt_.text = var_542_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_539_1.leftNameTxt_.transform)

				arg_539_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_539_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_539_1:RecordName(arg_539_1.leftNameTxt_.text)
				SetActive(arg_539_1.iconTrs_.gameObject, true)
				arg_539_1.iconController_:SetSelectedState("hero")

				arg_539_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_539_1.callingController_:SetSelectedState("normal")

				arg_539_1.keyicon_.color = Color.New(1, 1, 1)
				arg_539_1.icon_.color = Color.New(1, 1, 1)

				local var_542_3 = arg_539_1:GetWordFromCfg(320061130)
				local var_542_4 = arg_539_1:FormatText(var_542_3.content)

				arg_539_1.text_.text = var_542_4

				LuaForUtil.ClearLinePrefixSymbol(arg_539_1.text_)

				local var_542_5 = 12
				local var_542_6 = utf8.len(var_542_4)
				local var_542_7 = var_542_5 <= 0 and var_542_1 or var_542_1 * (var_542_6 / var_542_5)

				if var_542_7 > 0 and var_542_1 < var_542_7 then
					arg_539_1.talkMaxDuration = var_542_7

					if var_542_7 + var_542_0 > arg_539_1.duration_ then
						arg_539_1.duration_ = var_542_7 + var_542_0
					end
				end

				arg_539_1.text_.text = var_542_4
				arg_539_1.typewritter.percent = 0

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(false)
				arg_539_1:RecordContent(arg_539_1.text_.text)
			end

			local var_542_8 = math.max(var_542_1, arg_539_1.talkMaxDuration)

			if var_542_0 <= arg_539_1.time_ and arg_539_1.time_ < var_542_0 + var_542_8 then
				arg_539_1.typewritter.percent = (arg_539_1.time_ - var_542_0) / var_542_8

				arg_539_1.typewritter:SetDirty()
			end

			if arg_539_1.time_ >= var_542_0 + var_542_8 and arg_539_1.time_ < var_542_0 + var_542_8 + arg_542_0 then
				arg_539_1.typewritter.percent = 1

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(true)
			end
		end

		arg_539_1.nodeConfigList_ = {}

		arg_539_1:InitPlayNodeList()
	end,
	Play320061131 = function(arg_543_0, arg_543_1)
		arg_543_1.time_ = 0
		arg_543_1.frameCnt_ = 0
		arg_543_1.state_ = "playing"
		arg_543_1.curTalkId_ = 320061131
		arg_543_1.duration_ = 10.83

		local var_543_0 = {
			zh = 7.333,
			ja = 10.833
		}
		local var_543_1 = manager.audio:GetLocalizationFlag()

		if var_543_0[var_543_1] ~= nil then
			arg_543_1.duration_ = var_543_0[var_543_1]
		end

		SetActive(arg_543_1.tipsGo_, false)

		function arg_543_1.onSingleLineFinish_()
			arg_543_1.onSingleLineUpdate_ = nil
			arg_543_1.onSingleLineFinish_ = nil
			arg_543_1.state_ = "waiting"
		end

		function arg_543_1.playNext_(arg_545_0)
			if arg_545_0 == 1 then
				arg_543_0:Play320061132(arg_543_1)
			end
		end

		function arg_543_1.onSingleLineUpdate_(arg_546_0)
			local var_546_0 = arg_543_1.actors_["10100ui_story"].transform
			local var_546_1 = 0

			if var_546_1 < arg_543_1.time_ and arg_543_1.time_ <= var_546_1 + arg_546_0 then
				arg_543_1.var_.moveOldPos10100ui_story = var_546_0.localPosition
			end

			local var_546_2 = 0.001

			if var_546_1 <= arg_543_1.time_ and arg_543_1.time_ < var_546_1 + var_546_2 then
				local var_546_3 = (arg_543_1.time_ - var_546_1) / var_546_2
				local var_546_4 = Vector3.New(0, -1.16, -6.25)

				var_546_0.localPosition = Vector3.Lerp(arg_543_1.var_.moveOldPos10100ui_story, var_546_4, var_546_3)

				local var_546_5 = manager.ui.mainCamera.transform.position - var_546_0.position

				var_546_0.forward = Vector3.New(var_546_5.x, var_546_5.y, var_546_5.z)

				local var_546_6 = var_546_0.localEulerAngles

				var_546_6.z = 0
				var_546_6.x = 0
				var_546_0.localEulerAngles = var_546_6
			end

			if arg_543_1.time_ >= var_546_1 + var_546_2 and arg_543_1.time_ < var_546_1 + var_546_2 + arg_546_0 then
				var_546_0.localPosition = Vector3.New(0, -1.16, -6.25)

				local var_546_7 = manager.ui.mainCamera.transform.position - var_546_0.position

				var_546_0.forward = Vector3.New(var_546_7.x, var_546_7.y, var_546_7.z)

				local var_546_8 = var_546_0.localEulerAngles

				var_546_8.z = 0
				var_546_8.x = 0
				var_546_0.localEulerAngles = var_546_8
			end

			local var_546_9 = arg_543_1.actors_["10100ui_story"]
			local var_546_10 = 0

			if var_546_10 < arg_543_1.time_ and arg_543_1.time_ <= var_546_10 + arg_546_0 and not isNil(var_546_9) and arg_543_1.var_.characterEffect10100ui_story == nil then
				arg_543_1.var_.characterEffect10100ui_story = var_546_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_546_11 = 0.200000002980232

			if var_546_10 <= arg_543_1.time_ and arg_543_1.time_ < var_546_10 + var_546_11 and not isNil(var_546_9) then
				local var_546_12 = (arg_543_1.time_ - var_546_10) / var_546_11

				if arg_543_1.var_.characterEffect10100ui_story and not isNil(var_546_9) then
					arg_543_1.var_.characterEffect10100ui_story.fillFlat = false
				end
			end

			if arg_543_1.time_ >= var_546_10 + var_546_11 and arg_543_1.time_ < var_546_10 + var_546_11 + arg_546_0 and not isNil(var_546_9) and arg_543_1.var_.characterEffect10100ui_story then
				arg_543_1.var_.characterEffect10100ui_story.fillFlat = false
			end

			local var_546_13 = 0

			if var_546_13 < arg_543_1.time_ and arg_543_1.time_ <= var_546_13 + arg_546_0 then
				arg_543_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action1_1")
			end

			local var_546_14 = 0

			if var_546_14 < arg_543_1.time_ and arg_543_1.time_ <= var_546_14 + arg_546_0 then
				arg_543_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_546_15 = 0
			local var_546_16 = 0.925

			if var_546_15 < arg_543_1.time_ and arg_543_1.time_ <= var_546_15 + arg_546_0 then
				arg_543_1.talkMaxDuration = 0
				arg_543_1.dialogCg_.alpha = 1

				arg_543_1.dialog_:SetActive(true)
				SetActive(arg_543_1.leftNameGo_, true)

				local var_546_17 = arg_543_1:FormatText(StoryNameCfg[1021].name)

				arg_543_1.leftNameTxt_.text = var_546_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_543_1.leftNameTxt_.transform)

				arg_543_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_543_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_543_1:RecordName(arg_543_1.leftNameTxt_.text)
				SetActive(arg_543_1.iconTrs_.gameObject, false)
				arg_543_1.callingController_:SetSelectedState("normal")

				local var_546_18 = arg_543_1:GetWordFromCfg(320061131)
				local var_546_19 = arg_543_1:FormatText(var_546_18.content)

				arg_543_1.text_.text = var_546_19

				LuaForUtil.ClearLinePrefixSymbol(arg_543_1.text_)

				local var_546_20 = 37
				local var_546_21 = utf8.len(var_546_19)
				local var_546_22 = var_546_20 <= 0 and var_546_16 or var_546_16 * (var_546_21 / var_546_20)

				if var_546_22 > 0 and var_546_16 < var_546_22 then
					arg_543_1.talkMaxDuration = var_546_22

					if var_546_22 + var_546_15 > arg_543_1.duration_ then
						arg_543_1.duration_ = var_546_22 + var_546_15
					end
				end

				arg_543_1.text_.text = var_546_19
				arg_543_1.typewritter.percent = 0

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320061", "320061131", "story_v_out_320061.awb") ~= 0 then
					local var_546_23 = manager.audio:GetVoiceLength("story_v_out_320061", "320061131", "story_v_out_320061.awb") / 1000

					if var_546_23 + var_546_15 > arg_543_1.duration_ then
						arg_543_1.duration_ = var_546_23 + var_546_15
					end

					if var_546_18.prefab_name ~= "" and arg_543_1.actors_[var_546_18.prefab_name] ~= nil then
						local var_546_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_543_1.actors_[var_546_18.prefab_name].transform, "story_v_out_320061", "320061131", "story_v_out_320061.awb")

						arg_543_1:RecordAudio("320061131", var_546_24)
						arg_543_1:RecordAudio("320061131", var_546_24)
					else
						arg_543_1:AudioAction("play", "voice", "story_v_out_320061", "320061131", "story_v_out_320061.awb")
					end

					arg_543_1:RecordHistoryTalkVoice("story_v_out_320061", "320061131", "story_v_out_320061.awb")
				end

				arg_543_1:RecordContent(arg_543_1.text_.text)
			end

			local var_546_25 = math.max(var_546_16, arg_543_1.talkMaxDuration)

			if var_546_15 <= arg_543_1.time_ and arg_543_1.time_ < var_546_15 + var_546_25 then
				arg_543_1.typewritter.percent = (arg_543_1.time_ - var_546_15) / var_546_25

				arg_543_1.typewritter:SetDirty()
			end

			if arg_543_1.time_ >= var_546_15 + var_546_25 and arg_543_1.time_ < var_546_15 + var_546_25 + arg_546_0 then
				arg_543_1.typewritter.percent = 1

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(true)
			end
		end

		arg_543_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10100ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_543_1:InitPlayNodeList()
	end,
	Play320061132 = function(arg_547_0, arg_547_1)
		arg_547_1.time_ = 0
		arg_547_1.frameCnt_ = 0
		arg_547_1.state_ = "playing"
		arg_547_1.curTalkId_ = 320061132
		arg_547_1.duration_ = 3.93

		local var_547_0 = {
			zh = 2.566,
			ja = 3.933
		}
		local var_547_1 = manager.audio:GetLocalizationFlag()

		if var_547_0[var_547_1] ~= nil then
			arg_547_1.duration_ = var_547_0[var_547_1]
		end

		SetActive(arg_547_1.tipsGo_, false)

		function arg_547_1.onSingleLineFinish_()
			arg_547_1.onSingleLineUpdate_ = nil
			arg_547_1.onSingleLineFinish_ = nil
			arg_547_1.state_ = "waiting"
		end

		function arg_547_1.playNext_(arg_549_0)
			if arg_549_0 == 1 then
				arg_547_0:Play320061133(arg_547_1)
			end
		end

		function arg_547_1.onSingleLineUpdate_(arg_550_0)
			local var_550_0 = arg_547_1.actors_["10100ui_story"].transform
			local var_550_1 = 0

			if var_550_1 < arg_547_1.time_ and arg_547_1.time_ <= var_550_1 + arg_550_0 then
				arg_547_1.var_.moveOldPos10100ui_story = var_550_0.localPosition
			end

			local var_550_2 = 0.001

			if var_550_1 <= arg_547_1.time_ and arg_547_1.time_ < var_550_1 + var_550_2 then
				local var_550_3 = (arg_547_1.time_ - var_550_1) / var_550_2
				local var_550_4 = Vector3.New(-0.7, -1.16, -6.25)

				var_550_0.localPosition = Vector3.Lerp(arg_547_1.var_.moveOldPos10100ui_story, var_550_4, var_550_3)

				local var_550_5 = manager.ui.mainCamera.transform.position - var_550_0.position

				var_550_0.forward = Vector3.New(var_550_5.x, var_550_5.y, var_550_5.z)

				local var_550_6 = var_550_0.localEulerAngles

				var_550_6.z = 0
				var_550_6.x = 0
				var_550_0.localEulerAngles = var_550_6
			end

			if arg_547_1.time_ >= var_550_1 + var_550_2 and arg_547_1.time_ < var_550_1 + var_550_2 + arg_550_0 then
				var_550_0.localPosition = Vector3.New(-0.7, -1.16, -6.25)

				local var_550_7 = manager.ui.mainCamera.transform.position - var_550_0.position

				var_550_0.forward = Vector3.New(var_550_7.x, var_550_7.y, var_550_7.z)

				local var_550_8 = var_550_0.localEulerAngles

				var_550_8.z = 0
				var_550_8.x = 0
				var_550_0.localEulerAngles = var_550_8
			end

			local var_550_9 = arg_547_1.actors_["10100ui_story"]
			local var_550_10 = 0

			if var_550_10 < arg_547_1.time_ and arg_547_1.time_ <= var_550_10 + arg_550_0 and not isNil(var_550_9) and arg_547_1.var_.characterEffect10100ui_story == nil then
				arg_547_1.var_.characterEffect10100ui_story = var_550_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_550_11 = 0.200000002980232

			if var_550_10 <= arg_547_1.time_ and arg_547_1.time_ < var_550_10 + var_550_11 and not isNil(var_550_9) then
				local var_550_12 = (arg_547_1.time_ - var_550_10) / var_550_11

				if arg_547_1.var_.characterEffect10100ui_story and not isNil(var_550_9) then
					local var_550_13 = Mathf.Lerp(0, 0.5, var_550_12)

					arg_547_1.var_.characterEffect10100ui_story.fillFlat = true
					arg_547_1.var_.characterEffect10100ui_story.fillRatio = var_550_13
				end
			end

			if arg_547_1.time_ >= var_550_10 + var_550_11 and arg_547_1.time_ < var_550_10 + var_550_11 + arg_550_0 and not isNil(var_550_9) and arg_547_1.var_.characterEffect10100ui_story then
				local var_550_14 = 0.5

				arg_547_1.var_.characterEffect10100ui_story.fillFlat = true
				arg_547_1.var_.characterEffect10100ui_story.fillRatio = var_550_14
			end

			local var_550_15 = arg_547_1.actors_["1011ui_story"].transform
			local var_550_16 = 0

			if var_550_16 < arg_547_1.time_ and arg_547_1.time_ <= var_550_16 + arg_550_0 then
				arg_547_1.var_.moveOldPos1011ui_story = var_550_15.localPosition
			end

			local var_550_17 = 0.001

			if var_550_16 <= arg_547_1.time_ and arg_547_1.time_ < var_550_16 + var_550_17 then
				local var_550_18 = (arg_547_1.time_ - var_550_16) / var_550_17
				local var_550_19 = Vector3.New(0.7, -0.71, -6)

				var_550_15.localPosition = Vector3.Lerp(arg_547_1.var_.moveOldPos1011ui_story, var_550_19, var_550_18)

				local var_550_20 = manager.ui.mainCamera.transform.position - var_550_15.position

				var_550_15.forward = Vector3.New(var_550_20.x, var_550_20.y, var_550_20.z)

				local var_550_21 = var_550_15.localEulerAngles

				var_550_21.z = 0
				var_550_21.x = 0
				var_550_15.localEulerAngles = var_550_21
			end

			if arg_547_1.time_ >= var_550_16 + var_550_17 and arg_547_1.time_ < var_550_16 + var_550_17 + arg_550_0 then
				var_550_15.localPosition = Vector3.New(0.7, -0.71, -6)

				local var_550_22 = manager.ui.mainCamera.transform.position - var_550_15.position

				var_550_15.forward = Vector3.New(var_550_22.x, var_550_22.y, var_550_22.z)

				local var_550_23 = var_550_15.localEulerAngles

				var_550_23.z = 0
				var_550_23.x = 0
				var_550_15.localEulerAngles = var_550_23
			end

			local var_550_24 = arg_547_1.actors_["1011ui_story"]
			local var_550_25 = 0

			if var_550_25 < arg_547_1.time_ and arg_547_1.time_ <= var_550_25 + arg_550_0 and not isNil(var_550_24) and arg_547_1.var_.characterEffect1011ui_story == nil then
				arg_547_1.var_.characterEffect1011ui_story = var_550_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_550_26 = 0.200000002980232

			if var_550_25 <= arg_547_1.time_ and arg_547_1.time_ < var_550_25 + var_550_26 and not isNil(var_550_24) then
				local var_550_27 = (arg_547_1.time_ - var_550_25) / var_550_26

				if arg_547_1.var_.characterEffect1011ui_story and not isNil(var_550_24) then
					arg_547_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_547_1.time_ >= var_550_25 + var_550_26 and arg_547_1.time_ < var_550_25 + var_550_26 + arg_550_0 and not isNil(var_550_24) and arg_547_1.var_.characterEffect1011ui_story then
				arg_547_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_550_28 = 0

			if var_550_28 < arg_547_1.time_ and arg_547_1.time_ <= var_550_28 + arg_550_0 then
				arg_547_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action2_1")
			end

			local var_550_29 = 0

			if var_550_29 < arg_547_1.time_ and arg_547_1.time_ <= var_550_29 + arg_550_0 then
				arg_547_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_550_30 = 0
			local var_550_31 = 0.2

			if var_550_30 < arg_547_1.time_ and arg_547_1.time_ <= var_550_30 + arg_550_0 then
				arg_547_1.talkMaxDuration = 0
				arg_547_1.dialogCg_.alpha = 1

				arg_547_1.dialog_:SetActive(true)
				SetActive(arg_547_1.leftNameGo_, true)

				local var_550_32 = arg_547_1:FormatText(StoryNameCfg[37].name)

				arg_547_1.leftNameTxt_.text = var_550_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_547_1.leftNameTxt_.transform)

				arg_547_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_547_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_547_1:RecordName(arg_547_1.leftNameTxt_.text)
				SetActive(arg_547_1.iconTrs_.gameObject, false)
				arg_547_1.callingController_:SetSelectedState("normal")

				local var_550_33 = arg_547_1:GetWordFromCfg(320061132)
				local var_550_34 = arg_547_1:FormatText(var_550_33.content)

				arg_547_1.text_.text = var_550_34

				LuaForUtil.ClearLinePrefixSymbol(arg_547_1.text_)

				local var_550_35 = 8
				local var_550_36 = utf8.len(var_550_34)
				local var_550_37 = var_550_35 <= 0 and var_550_31 or var_550_31 * (var_550_36 / var_550_35)

				if var_550_37 > 0 and var_550_31 < var_550_37 then
					arg_547_1.talkMaxDuration = var_550_37

					if var_550_37 + var_550_30 > arg_547_1.duration_ then
						arg_547_1.duration_ = var_550_37 + var_550_30
					end
				end

				arg_547_1.text_.text = var_550_34
				arg_547_1.typewritter.percent = 0

				arg_547_1.typewritter:SetDirty()
				arg_547_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320061", "320061132", "story_v_out_320061.awb") ~= 0 then
					local var_550_38 = manager.audio:GetVoiceLength("story_v_out_320061", "320061132", "story_v_out_320061.awb") / 1000

					if var_550_38 + var_550_30 > arg_547_1.duration_ then
						arg_547_1.duration_ = var_550_38 + var_550_30
					end

					if var_550_33.prefab_name ~= "" and arg_547_1.actors_[var_550_33.prefab_name] ~= nil then
						local var_550_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_547_1.actors_[var_550_33.prefab_name].transform, "story_v_out_320061", "320061132", "story_v_out_320061.awb")

						arg_547_1:RecordAudio("320061132", var_550_39)
						arg_547_1:RecordAudio("320061132", var_550_39)
					else
						arg_547_1:AudioAction("play", "voice", "story_v_out_320061", "320061132", "story_v_out_320061.awb")
					end

					arg_547_1:RecordHistoryTalkVoice("story_v_out_320061", "320061132", "story_v_out_320061.awb")
				end

				arg_547_1:RecordContent(arg_547_1.text_.text)
			end

			local var_550_40 = math.max(var_550_31, arg_547_1.talkMaxDuration)

			if var_550_30 <= arg_547_1.time_ and arg_547_1.time_ < var_550_30 + var_550_40 then
				arg_547_1.typewritter.percent = (arg_547_1.time_ - var_550_30) / var_550_40

				arg_547_1.typewritter:SetDirty()
			end

			if arg_547_1.time_ >= var_550_30 + var_550_40 and arg_547_1.time_ < var_550_30 + var_550_40 + arg_550_0 then
				arg_547_1.typewritter.percent = 1

				arg_547_1.typewritter:SetDirty()
				arg_547_1:ShowNextGo(true)
			end
		end

		arg_547_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10100ui_story",
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

		arg_547_1:InitPlayNodeList()
	end,
	Play320061133 = function(arg_551_0, arg_551_1)
		arg_551_1.time_ = 0
		arg_551_1.frameCnt_ = 0
		arg_551_1.state_ = "playing"
		arg_551_1.curTalkId_ = 320061133
		arg_551_1.duration_ = 8

		local var_551_0 = {
			zh = 4.866,
			ja = 8
		}
		local var_551_1 = manager.audio:GetLocalizationFlag()

		if var_551_0[var_551_1] ~= nil then
			arg_551_1.duration_ = var_551_0[var_551_1]
		end

		SetActive(arg_551_1.tipsGo_, false)

		function arg_551_1.onSingleLineFinish_()
			arg_551_1.onSingleLineUpdate_ = nil
			arg_551_1.onSingleLineFinish_ = nil
			arg_551_1.state_ = "waiting"
		end

		function arg_551_1.playNext_(arg_553_0)
			if arg_553_0 == 1 then
				arg_551_0:Play320061134(arg_551_1)
			end
		end

		function arg_551_1.onSingleLineUpdate_(arg_554_0)
			local var_554_0 = arg_551_1.actors_["10100ui_story"]
			local var_554_1 = 0

			if var_554_1 < arg_551_1.time_ and arg_551_1.time_ <= var_554_1 + arg_554_0 and not isNil(var_554_0) and arg_551_1.var_.characterEffect10100ui_story == nil then
				arg_551_1.var_.characterEffect10100ui_story = var_554_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_554_2 = 0.200000002980232

			if var_554_1 <= arg_551_1.time_ and arg_551_1.time_ < var_554_1 + var_554_2 and not isNil(var_554_0) then
				local var_554_3 = (arg_551_1.time_ - var_554_1) / var_554_2

				if arg_551_1.var_.characterEffect10100ui_story and not isNil(var_554_0) then
					arg_551_1.var_.characterEffect10100ui_story.fillFlat = false
				end
			end

			if arg_551_1.time_ >= var_554_1 + var_554_2 and arg_551_1.time_ < var_554_1 + var_554_2 + arg_554_0 and not isNil(var_554_0) and arg_551_1.var_.characterEffect10100ui_story then
				arg_551_1.var_.characterEffect10100ui_story.fillFlat = false
			end

			local var_554_4 = 0

			if var_554_4 < arg_551_1.time_ and arg_551_1.time_ <= var_554_4 + arg_554_0 then
				arg_551_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action1_1")
			end

			local var_554_5 = 0

			if var_554_5 < arg_551_1.time_ and arg_551_1.time_ <= var_554_5 + arg_554_0 then
				arg_551_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_554_6 = arg_551_1.actors_["1011ui_story"]
			local var_554_7 = 0

			if var_554_7 < arg_551_1.time_ and arg_551_1.time_ <= var_554_7 + arg_554_0 and not isNil(var_554_6) and arg_551_1.var_.characterEffect1011ui_story == nil then
				arg_551_1.var_.characterEffect1011ui_story = var_554_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_554_8 = 0.200000002980232

			if var_554_7 <= arg_551_1.time_ and arg_551_1.time_ < var_554_7 + var_554_8 and not isNil(var_554_6) then
				local var_554_9 = (arg_551_1.time_ - var_554_7) / var_554_8

				if arg_551_1.var_.characterEffect1011ui_story and not isNil(var_554_6) then
					local var_554_10 = Mathf.Lerp(0, 0.5, var_554_9)

					arg_551_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_551_1.var_.characterEffect1011ui_story.fillRatio = var_554_10
				end
			end

			if arg_551_1.time_ >= var_554_7 + var_554_8 and arg_551_1.time_ < var_554_7 + var_554_8 + arg_554_0 and not isNil(var_554_6) and arg_551_1.var_.characterEffect1011ui_story then
				local var_554_11 = 0.5

				arg_551_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_551_1.var_.characterEffect1011ui_story.fillRatio = var_554_11
			end

			local var_554_12 = 0
			local var_554_13 = 0.6

			if var_554_12 < arg_551_1.time_ and arg_551_1.time_ <= var_554_12 + arg_554_0 then
				arg_551_1.talkMaxDuration = 0
				arg_551_1.dialogCg_.alpha = 1

				arg_551_1.dialog_:SetActive(true)
				SetActive(arg_551_1.leftNameGo_, true)

				local var_554_14 = arg_551_1:FormatText(StoryNameCfg[1021].name)

				arg_551_1.leftNameTxt_.text = var_554_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_551_1.leftNameTxt_.transform)

				arg_551_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_551_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_551_1:RecordName(arg_551_1.leftNameTxt_.text)
				SetActive(arg_551_1.iconTrs_.gameObject, false)
				arg_551_1.callingController_:SetSelectedState("normal")

				local var_554_15 = arg_551_1:GetWordFromCfg(320061133)
				local var_554_16 = arg_551_1:FormatText(var_554_15.content)

				arg_551_1.text_.text = var_554_16

				LuaForUtil.ClearLinePrefixSymbol(arg_551_1.text_)

				local var_554_17 = 24
				local var_554_18 = utf8.len(var_554_16)
				local var_554_19 = var_554_17 <= 0 and var_554_13 or var_554_13 * (var_554_18 / var_554_17)

				if var_554_19 > 0 and var_554_13 < var_554_19 then
					arg_551_1.talkMaxDuration = var_554_19

					if var_554_19 + var_554_12 > arg_551_1.duration_ then
						arg_551_1.duration_ = var_554_19 + var_554_12
					end
				end

				arg_551_1.text_.text = var_554_16
				arg_551_1.typewritter.percent = 0

				arg_551_1.typewritter:SetDirty()
				arg_551_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320061", "320061133", "story_v_out_320061.awb") ~= 0 then
					local var_554_20 = manager.audio:GetVoiceLength("story_v_out_320061", "320061133", "story_v_out_320061.awb") / 1000

					if var_554_20 + var_554_12 > arg_551_1.duration_ then
						arg_551_1.duration_ = var_554_20 + var_554_12
					end

					if var_554_15.prefab_name ~= "" and arg_551_1.actors_[var_554_15.prefab_name] ~= nil then
						local var_554_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_551_1.actors_[var_554_15.prefab_name].transform, "story_v_out_320061", "320061133", "story_v_out_320061.awb")

						arg_551_1:RecordAudio("320061133", var_554_21)
						arg_551_1:RecordAudio("320061133", var_554_21)
					else
						arg_551_1:AudioAction("play", "voice", "story_v_out_320061", "320061133", "story_v_out_320061.awb")
					end

					arg_551_1:RecordHistoryTalkVoice("story_v_out_320061", "320061133", "story_v_out_320061.awb")
				end

				arg_551_1:RecordContent(arg_551_1.text_.text)
			end

			local var_554_22 = math.max(var_554_13, arg_551_1.talkMaxDuration)

			if var_554_12 <= arg_551_1.time_ and arg_551_1.time_ < var_554_12 + var_554_22 then
				arg_551_1.typewritter.percent = (arg_551_1.time_ - var_554_12) / var_554_22

				arg_551_1.typewritter:SetDirty()
			end

			if arg_551_1.time_ >= var_554_12 + var_554_22 and arg_551_1.time_ < var_554_12 + var_554_22 + arg_554_0 then
				arg_551_1.typewritter.percent = 1

				arg_551_1.typewritter:SetDirty()
				arg_551_1:ShowNextGo(true)
			end
		end

		arg_551_1.nodeConfigList_ = {}

		arg_551_1:InitPlayNodeList()
	end,
	Play320061134 = function(arg_555_0, arg_555_1)
		arg_555_1.time_ = 0
		arg_555_1.frameCnt_ = 0
		arg_555_1.state_ = "playing"
		arg_555_1.curTalkId_ = 320061134
		arg_555_1.duration_ = 5

		SetActive(arg_555_1.tipsGo_, false)

		function arg_555_1.onSingleLineFinish_()
			arg_555_1.onSingleLineUpdate_ = nil
			arg_555_1.onSingleLineFinish_ = nil
			arg_555_1.state_ = "waiting"
		end

		function arg_555_1.playNext_(arg_557_0)
			if arg_557_0 == 1 then
				arg_555_0:Play320061135(arg_555_1)
			end
		end

		function arg_555_1.onSingleLineUpdate_(arg_558_0)
			local var_558_0 = arg_555_1.actors_["10100ui_story"]
			local var_558_1 = 0

			if var_558_1 < arg_555_1.time_ and arg_555_1.time_ <= var_558_1 + arg_558_0 and not isNil(var_558_0) and arg_555_1.var_.characterEffect10100ui_story == nil then
				arg_555_1.var_.characterEffect10100ui_story = var_558_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_558_2 = 0.200000002980232

			if var_558_1 <= arg_555_1.time_ and arg_555_1.time_ < var_558_1 + var_558_2 and not isNil(var_558_0) then
				local var_558_3 = (arg_555_1.time_ - var_558_1) / var_558_2

				if arg_555_1.var_.characterEffect10100ui_story and not isNil(var_558_0) then
					local var_558_4 = Mathf.Lerp(0, 0.5, var_558_3)

					arg_555_1.var_.characterEffect10100ui_story.fillFlat = true
					arg_555_1.var_.characterEffect10100ui_story.fillRatio = var_558_4
				end
			end

			if arg_555_1.time_ >= var_558_1 + var_558_2 and arg_555_1.time_ < var_558_1 + var_558_2 + arg_558_0 and not isNil(var_558_0) and arg_555_1.var_.characterEffect10100ui_story then
				local var_558_5 = 0.5

				arg_555_1.var_.characterEffect10100ui_story.fillFlat = true
				arg_555_1.var_.characterEffect10100ui_story.fillRatio = var_558_5
			end

			local var_558_6 = arg_555_1.actors_["1011ui_story"].transform
			local var_558_7 = 0

			if var_558_7 < arg_555_1.time_ and arg_555_1.time_ <= var_558_7 + arg_558_0 then
				arg_555_1.var_.moveOldPos1011ui_story = var_558_6.localPosition
			end

			local var_558_8 = 0.001

			if var_558_7 <= arg_555_1.time_ and arg_555_1.time_ < var_558_7 + var_558_8 then
				local var_558_9 = (arg_555_1.time_ - var_558_7) / var_558_8
				local var_558_10 = Vector3.New(0, 100, 0)

				var_558_6.localPosition = Vector3.Lerp(arg_555_1.var_.moveOldPos1011ui_story, var_558_10, var_558_9)

				local var_558_11 = manager.ui.mainCamera.transform.position - var_558_6.position

				var_558_6.forward = Vector3.New(var_558_11.x, var_558_11.y, var_558_11.z)

				local var_558_12 = var_558_6.localEulerAngles

				var_558_12.z = 0
				var_558_12.x = 0
				var_558_6.localEulerAngles = var_558_12
			end

			if arg_555_1.time_ >= var_558_7 + var_558_8 and arg_555_1.time_ < var_558_7 + var_558_8 + arg_558_0 then
				var_558_6.localPosition = Vector3.New(0, 100, 0)

				local var_558_13 = manager.ui.mainCamera.transform.position - var_558_6.position

				var_558_6.forward = Vector3.New(var_558_13.x, var_558_13.y, var_558_13.z)

				local var_558_14 = var_558_6.localEulerAngles

				var_558_14.z = 0
				var_558_14.x = 0
				var_558_6.localEulerAngles = var_558_14
			end

			local var_558_15 = arg_555_1.actors_["10100ui_story"].transform
			local var_558_16 = 0

			if var_558_16 < arg_555_1.time_ and arg_555_1.time_ <= var_558_16 + arg_558_0 then
				arg_555_1.var_.moveOldPos10100ui_story = var_558_15.localPosition
			end

			local var_558_17 = 0.001

			if var_558_16 <= arg_555_1.time_ and arg_555_1.time_ < var_558_16 + var_558_17 then
				local var_558_18 = (arg_555_1.time_ - var_558_16) / var_558_17
				local var_558_19 = Vector3.New(0, 100, 0)

				var_558_15.localPosition = Vector3.Lerp(arg_555_1.var_.moveOldPos10100ui_story, var_558_19, var_558_18)

				local var_558_20 = manager.ui.mainCamera.transform.position - var_558_15.position

				var_558_15.forward = Vector3.New(var_558_20.x, var_558_20.y, var_558_20.z)

				local var_558_21 = var_558_15.localEulerAngles

				var_558_21.z = 0
				var_558_21.x = 0
				var_558_15.localEulerAngles = var_558_21
			end

			if arg_555_1.time_ >= var_558_16 + var_558_17 and arg_555_1.time_ < var_558_16 + var_558_17 + arg_558_0 then
				var_558_15.localPosition = Vector3.New(0, 100, 0)

				local var_558_22 = manager.ui.mainCamera.transform.position - var_558_15.position

				var_558_15.forward = Vector3.New(var_558_22.x, var_558_22.y, var_558_22.z)

				local var_558_23 = var_558_15.localEulerAngles

				var_558_23.z = 0
				var_558_23.x = 0
				var_558_15.localEulerAngles = var_558_23
			end

			local var_558_24 = 0
			local var_558_25 = 1.2

			if var_558_24 < arg_555_1.time_ and arg_555_1.time_ <= var_558_24 + arg_558_0 then
				arg_555_1.talkMaxDuration = 0
				arg_555_1.dialogCg_.alpha = 1

				arg_555_1.dialog_:SetActive(true)
				SetActive(arg_555_1.leftNameGo_, false)

				arg_555_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_555_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_555_1:RecordName(arg_555_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_555_1.iconTrs_.gameObject, false)
				arg_555_1.callingController_:SetSelectedState("normal")

				local var_558_26 = arg_555_1:GetWordFromCfg(320061134)
				local var_558_27 = arg_555_1:FormatText(var_558_26.content)

				arg_555_1.text_.text = var_558_27

				LuaForUtil.ClearLinePrefixSymbol(arg_555_1.text_)

				local var_558_28 = 48
				local var_558_29 = utf8.len(var_558_27)
				local var_558_30 = var_558_28 <= 0 and var_558_25 or var_558_25 * (var_558_29 / var_558_28)

				if var_558_30 > 0 and var_558_25 < var_558_30 then
					arg_555_1.talkMaxDuration = var_558_30

					if var_558_30 + var_558_24 > arg_555_1.duration_ then
						arg_555_1.duration_ = var_558_30 + var_558_24
					end
				end

				arg_555_1.text_.text = var_558_27
				arg_555_1.typewritter.percent = 0

				arg_555_1.typewritter:SetDirty()
				arg_555_1:ShowNextGo(false)
				arg_555_1:RecordContent(arg_555_1.text_.text)
			end

			local var_558_31 = math.max(var_558_25, arg_555_1.talkMaxDuration)

			if var_558_24 <= arg_555_1.time_ and arg_555_1.time_ < var_558_24 + var_558_31 then
				arg_555_1.typewritter.percent = (arg_555_1.time_ - var_558_24) / var_558_31

				arg_555_1.typewritter:SetDirty()
			end

			if arg_555_1.time_ >= var_558_24 + var_558_31 and arg_555_1.time_ < var_558_24 + var_558_31 + arg_558_0 then
				arg_555_1.typewritter.percent = 1

				arg_555_1.typewritter:SetDirty()
				arg_555_1:ShowNextGo(true)
			end
		end

		arg_555_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10100ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_555_1:InitPlayNodeList()
	end,
	Play320061135 = function(arg_559_0, arg_559_1)
		arg_559_1.time_ = 0
		arg_559_1.frameCnt_ = 0
		arg_559_1.state_ = "playing"
		arg_559_1.curTalkId_ = 320061135
		arg_559_1.duration_ = 9.6

		local var_559_0 = {
			zh = 9.6,
			ja = 7.933
		}
		local var_559_1 = manager.audio:GetLocalizationFlag()

		if var_559_0[var_559_1] ~= nil then
			arg_559_1.duration_ = var_559_0[var_559_1]
		end

		SetActive(arg_559_1.tipsGo_, false)

		function arg_559_1.onSingleLineFinish_()
			arg_559_1.onSingleLineUpdate_ = nil
			arg_559_1.onSingleLineFinish_ = nil
			arg_559_1.state_ = "waiting"
		end

		function arg_559_1.playNext_(arg_561_0)
			if arg_561_0 == 1 then
				arg_559_0:Play320061136(arg_559_1)
			end
		end

		function arg_559_1.onSingleLineUpdate_(arg_562_0)
			local var_562_0 = arg_559_1.actors_["10100ui_story"].transform
			local var_562_1 = 0

			if var_562_1 < arg_559_1.time_ and arg_559_1.time_ <= var_562_1 + arg_562_0 then
				arg_559_1.var_.moveOldPos10100ui_story = var_562_0.localPosition
			end

			local var_562_2 = 0.001

			if var_562_1 <= arg_559_1.time_ and arg_559_1.time_ < var_562_1 + var_562_2 then
				local var_562_3 = (arg_559_1.time_ - var_562_1) / var_562_2
				local var_562_4 = Vector3.New(0, -1.16, -6.25)

				var_562_0.localPosition = Vector3.Lerp(arg_559_1.var_.moveOldPos10100ui_story, var_562_4, var_562_3)

				local var_562_5 = manager.ui.mainCamera.transform.position - var_562_0.position

				var_562_0.forward = Vector3.New(var_562_5.x, var_562_5.y, var_562_5.z)

				local var_562_6 = var_562_0.localEulerAngles

				var_562_6.z = 0
				var_562_6.x = 0
				var_562_0.localEulerAngles = var_562_6
			end

			if arg_559_1.time_ >= var_562_1 + var_562_2 and arg_559_1.time_ < var_562_1 + var_562_2 + arg_562_0 then
				var_562_0.localPosition = Vector3.New(0, -1.16, -6.25)

				local var_562_7 = manager.ui.mainCamera.transform.position - var_562_0.position

				var_562_0.forward = Vector3.New(var_562_7.x, var_562_7.y, var_562_7.z)

				local var_562_8 = var_562_0.localEulerAngles

				var_562_8.z = 0
				var_562_8.x = 0
				var_562_0.localEulerAngles = var_562_8
			end

			local var_562_9 = arg_559_1.actors_["10100ui_story"]
			local var_562_10 = 0

			if var_562_10 < arg_559_1.time_ and arg_559_1.time_ <= var_562_10 + arg_562_0 and not isNil(var_562_9) and arg_559_1.var_.characterEffect10100ui_story == nil then
				arg_559_1.var_.characterEffect10100ui_story = var_562_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_562_11 = 0.200000002980232

			if var_562_10 <= arg_559_1.time_ and arg_559_1.time_ < var_562_10 + var_562_11 and not isNil(var_562_9) then
				local var_562_12 = (arg_559_1.time_ - var_562_10) / var_562_11

				if arg_559_1.var_.characterEffect10100ui_story and not isNil(var_562_9) then
					arg_559_1.var_.characterEffect10100ui_story.fillFlat = false
				end
			end

			if arg_559_1.time_ >= var_562_10 + var_562_11 and arg_559_1.time_ < var_562_10 + var_562_11 + arg_562_0 and not isNil(var_562_9) and arg_559_1.var_.characterEffect10100ui_story then
				arg_559_1.var_.characterEffect10100ui_story.fillFlat = false
			end

			local var_562_13 = 0

			if var_562_13 < arg_559_1.time_ and arg_559_1.time_ <= var_562_13 + arg_562_0 then
				arg_559_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action1_1")
			end

			local var_562_14 = 0

			if var_562_14 < arg_559_1.time_ and arg_559_1.time_ <= var_562_14 + arg_562_0 then
				arg_559_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_562_15 = 0
			local var_562_16 = 1.6

			if var_562_15 < arg_559_1.time_ and arg_559_1.time_ <= var_562_15 + arg_562_0 then
				arg_559_1.talkMaxDuration = 0
				arg_559_1.dialogCg_.alpha = 1

				arg_559_1.dialog_:SetActive(true)
				SetActive(arg_559_1.leftNameGo_, true)

				local var_562_17 = arg_559_1:FormatText(StoryNameCfg[1021].name)

				arg_559_1.leftNameTxt_.text = var_562_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_559_1.leftNameTxt_.transform)

				arg_559_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_559_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_559_1:RecordName(arg_559_1.leftNameTxt_.text)
				SetActive(arg_559_1.iconTrs_.gameObject, false)
				arg_559_1.callingController_:SetSelectedState("normal")

				local var_562_18 = arg_559_1:GetWordFromCfg(320061135)
				local var_562_19 = arg_559_1:FormatText(var_562_18.content)

				arg_559_1.text_.text = var_562_19

				LuaForUtil.ClearLinePrefixSymbol(arg_559_1.text_)

				local var_562_20 = 64
				local var_562_21 = utf8.len(var_562_19)
				local var_562_22 = var_562_20 <= 0 and var_562_16 or var_562_16 * (var_562_21 / var_562_20)

				if var_562_22 > 0 and var_562_16 < var_562_22 then
					arg_559_1.talkMaxDuration = var_562_22

					if var_562_22 + var_562_15 > arg_559_1.duration_ then
						arg_559_1.duration_ = var_562_22 + var_562_15
					end
				end

				arg_559_1.text_.text = var_562_19
				arg_559_1.typewritter.percent = 0

				arg_559_1.typewritter:SetDirty()
				arg_559_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320061", "320061135", "story_v_out_320061.awb") ~= 0 then
					local var_562_23 = manager.audio:GetVoiceLength("story_v_out_320061", "320061135", "story_v_out_320061.awb") / 1000

					if var_562_23 + var_562_15 > arg_559_1.duration_ then
						arg_559_1.duration_ = var_562_23 + var_562_15
					end

					if var_562_18.prefab_name ~= "" and arg_559_1.actors_[var_562_18.prefab_name] ~= nil then
						local var_562_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_559_1.actors_[var_562_18.prefab_name].transform, "story_v_out_320061", "320061135", "story_v_out_320061.awb")

						arg_559_1:RecordAudio("320061135", var_562_24)
						arg_559_1:RecordAudio("320061135", var_562_24)
					else
						arg_559_1:AudioAction("play", "voice", "story_v_out_320061", "320061135", "story_v_out_320061.awb")
					end

					arg_559_1:RecordHistoryTalkVoice("story_v_out_320061", "320061135", "story_v_out_320061.awb")
				end

				arg_559_1:RecordContent(arg_559_1.text_.text)
			end

			local var_562_25 = math.max(var_562_16, arg_559_1.talkMaxDuration)

			if var_562_15 <= arg_559_1.time_ and arg_559_1.time_ < var_562_15 + var_562_25 then
				arg_559_1.typewritter.percent = (arg_559_1.time_ - var_562_15) / var_562_25

				arg_559_1.typewritter:SetDirty()
			end

			if arg_559_1.time_ >= var_562_15 + var_562_25 and arg_559_1.time_ < var_562_15 + var_562_25 + arg_562_0 then
				arg_559_1.typewritter.percent = 1

				arg_559_1.typewritter:SetDirty()
				arg_559_1:ShowNextGo(true)
			end
		end

		arg_559_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10100ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_559_1:InitPlayNodeList()
	end,
	Play320061136 = function(arg_563_0, arg_563_1)
		arg_563_1.time_ = 0
		arg_563_1.frameCnt_ = 0
		arg_563_1.state_ = "playing"
		arg_563_1.curTalkId_ = 320061136
		arg_563_1.duration_ = 5

		SetActive(arg_563_1.tipsGo_, false)

		function arg_563_1.onSingleLineFinish_()
			arg_563_1.onSingleLineUpdate_ = nil
			arg_563_1.onSingleLineFinish_ = nil
			arg_563_1.state_ = "waiting"
		end

		function arg_563_1.playNext_(arg_565_0)
			if arg_565_0 == 1 then
				arg_563_0:Play320061137(arg_563_1)
			end
		end

		function arg_563_1.onSingleLineUpdate_(arg_566_0)
			local var_566_0 = arg_563_1.actors_["10100ui_story"]
			local var_566_1 = 0

			if var_566_1 < arg_563_1.time_ and arg_563_1.time_ <= var_566_1 + arg_566_0 and not isNil(var_566_0) and arg_563_1.var_.characterEffect10100ui_story == nil then
				arg_563_1.var_.characterEffect10100ui_story = var_566_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_566_2 = 0.200000002980232

			if var_566_1 <= arg_563_1.time_ and arg_563_1.time_ < var_566_1 + var_566_2 and not isNil(var_566_0) then
				local var_566_3 = (arg_563_1.time_ - var_566_1) / var_566_2

				if arg_563_1.var_.characterEffect10100ui_story and not isNil(var_566_0) then
					local var_566_4 = Mathf.Lerp(0, 0.5, var_566_3)

					arg_563_1.var_.characterEffect10100ui_story.fillFlat = true
					arg_563_1.var_.characterEffect10100ui_story.fillRatio = var_566_4
				end
			end

			if arg_563_1.time_ >= var_566_1 + var_566_2 and arg_563_1.time_ < var_566_1 + var_566_2 + arg_566_0 and not isNil(var_566_0) and arg_563_1.var_.characterEffect10100ui_story then
				local var_566_5 = 0.5

				arg_563_1.var_.characterEffect10100ui_story.fillFlat = true
				arg_563_1.var_.characterEffect10100ui_story.fillRatio = var_566_5
			end

			local var_566_6 = 0
			local var_566_7 = 1.075

			if var_566_6 < arg_563_1.time_ and arg_563_1.time_ <= var_566_6 + arg_566_0 then
				arg_563_1.talkMaxDuration = 0
				arg_563_1.dialogCg_.alpha = 1

				arg_563_1.dialog_:SetActive(true)
				SetActive(arg_563_1.leftNameGo_, true)

				local var_566_8 = arg_563_1:FormatText(StoryNameCfg[7].name)

				arg_563_1.leftNameTxt_.text = var_566_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_563_1.leftNameTxt_.transform)

				arg_563_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_563_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_563_1:RecordName(arg_563_1.leftNameTxt_.text)
				SetActive(arg_563_1.iconTrs_.gameObject, true)
				arg_563_1.iconController_:SetSelectedState("hero")

				arg_563_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_563_1.callingController_:SetSelectedState("normal")

				arg_563_1.keyicon_.color = Color.New(1, 1, 1)
				arg_563_1.icon_.color = Color.New(1, 1, 1)

				local var_566_9 = arg_563_1:GetWordFromCfg(320061136)
				local var_566_10 = arg_563_1:FormatText(var_566_9.content)

				arg_563_1.text_.text = var_566_10

				LuaForUtil.ClearLinePrefixSymbol(arg_563_1.text_)

				local var_566_11 = 43
				local var_566_12 = utf8.len(var_566_10)
				local var_566_13 = var_566_11 <= 0 and var_566_7 or var_566_7 * (var_566_12 / var_566_11)

				if var_566_13 > 0 and var_566_7 < var_566_13 then
					arg_563_1.talkMaxDuration = var_566_13

					if var_566_13 + var_566_6 > arg_563_1.duration_ then
						arg_563_1.duration_ = var_566_13 + var_566_6
					end
				end

				arg_563_1.text_.text = var_566_10
				arg_563_1.typewritter.percent = 0

				arg_563_1.typewritter:SetDirty()
				arg_563_1:ShowNextGo(false)
				arg_563_1:RecordContent(arg_563_1.text_.text)
			end

			local var_566_14 = math.max(var_566_7, arg_563_1.talkMaxDuration)

			if var_566_6 <= arg_563_1.time_ and arg_563_1.time_ < var_566_6 + var_566_14 then
				arg_563_1.typewritter.percent = (arg_563_1.time_ - var_566_6) / var_566_14

				arg_563_1.typewritter:SetDirty()
			end

			if arg_563_1.time_ >= var_566_6 + var_566_14 and arg_563_1.time_ < var_566_6 + var_566_14 + arg_566_0 then
				arg_563_1.typewritter.percent = 1

				arg_563_1.typewritter:SetDirty()
				arg_563_1:ShowNextGo(true)
			end
		end

		arg_563_1.nodeConfigList_ = {}

		arg_563_1:InitPlayNodeList()
	end,
	Play320061137 = function(arg_567_0, arg_567_1)
		arg_567_1.time_ = 0
		arg_567_1.frameCnt_ = 0
		arg_567_1.state_ = "playing"
		arg_567_1.curTalkId_ = 320061137
		arg_567_1.duration_ = 5

		SetActive(arg_567_1.tipsGo_, false)

		function arg_567_1.onSingleLineFinish_()
			arg_567_1.onSingleLineUpdate_ = nil
			arg_567_1.onSingleLineFinish_ = nil
			arg_567_1.state_ = "waiting"
		end

		function arg_567_1.playNext_(arg_569_0)
			if arg_569_0 == 1 then
				arg_567_0:Play320061138(arg_567_1)
			end
		end

		function arg_567_1.onSingleLineUpdate_(arg_570_0)
			local var_570_0 = 0
			local var_570_1 = 0.675

			if var_570_0 < arg_567_1.time_ and arg_567_1.time_ <= var_570_0 + arg_570_0 then
				arg_567_1.talkMaxDuration = 0
				arg_567_1.dialogCg_.alpha = 1

				arg_567_1.dialog_:SetActive(true)
				SetActive(arg_567_1.leftNameGo_, true)

				local var_570_2 = arg_567_1:FormatText(StoryNameCfg[7].name)

				arg_567_1.leftNameTxt_.text = var_570_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_567_1.leftNameTxt_.transform)

				arg_567_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_567_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_567_1:RecordName(arg_567_1.leftNameTxt_.text)
				SetActive(arg_567_1.iconTrs_.gameObject, true)
				arg_567_1.iconController_:SetSelectedState("hero")

				arg_567_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_567_1.callingController_:SetSelectedState("normal")

				arg_567_1.keyicon_.color = Color.New(1, 1, 1)
				arg_567_1.icon_.color = Color.New(1, 1, 1)

				local var_570_3 = arg_567_1:GetWordFromCfg(320061137)
				local var_570_4 = arg_567_1:FormatText(var_570_3.content)

				arg_567_1.text_.text = var_570_4

				LuaForUtil.ClearLinePrefixSymbol(arg_567_1.text_)

				local var_570_5 = 27
				local var_570_6 = utf8.len(var_570_4)
				local var_570_7 = var_570_5 <= 0 and var_570_1 or var_570_1 * (var_570_6 / var_570_5)

				if var_570_7 > 0 and var_570_1 < var_570_7 then
					arg_567_1.talkMaxDuration = var_570_7

					if var_570_7 + var_570_0 > arg_567_1.duration_ then
						arg_567_1.duration_ = var_570_7 + var_570_0
					end
				end

				arg_567_1.text_.text = var_570_4
				arg_567_1.typewritter.percent = 0

				arg_567_1.typewritter:SetDirty()
				arg_567_1:ShowNextGo(false)
				arg_567_1:RecordContent(arg_567_1.text_.text)
			end

			local var_570_8 = math.max(var_570_1, arg_567_1.talkMaxDuration)

			if var_570_0 <= arg_567_1.time_ and arg_567_1.time_ < var_570_0 + var_570_8 then
				arg_567_1.typewritter.percent = (arg_567_1.time_ - var_570_0) / var_570_8

				arg_567_1.typewritter:SetDirty()
			end

			if arg_567_1.time_ >= var_570_0 + var_570_8 and arg_567_1.time_ < var_570_0 + var_570_8 + arg_570_0 then
				arg_567_1.typewritter.percent = 1

				arg_567_1.typewritter:SetDirty()
				arg_567_1:ShowNextGo(true)
			end
		end

		arg_567_1.nodeConfigList_ = {}

		arg_567_1:InitPlayNodeList()
	end,
	Play320061138 = function(arg_571_0, arg_571_1)
		arg_571_1.time_ = 0
		arg_571_1.frameCnt_ = 0
		arg_571_1.state_ = "playing"
		arg_571_1.curTalkId_ = 320061138
		arg_571_1.duration_ = 11.33

		local var_571_0 = {
			zh = 6.333,
			ja = 11.333
		}
		local var_571_1 = manager.audio:GetLocalizationFlag()

		if var_571_0[var_571_1] ~= nil then
			arg_571_1.duration_ = var_571_0[var_571_1]
		end

		SetActive(arg_571_1.tipsGo_, false)

		function arg_571_1.onSingleLineFinish_()
			arg_571_1.onSingleLineUpdate_ = nil
			arg_571_1.onSingleLineFinish_ = nil
			arg_571_1.state_ = "waiting"
		end

		function arg_571_1.playNext_(arg_573_0)
			if arg_573_0 == 1 then
				arg_571_0:Play320061139(arg_571_1)
			end
		end

		function arg_571_1.onSingleLineUpdate_(arg_574_0)
			local var_574_0 = arg_571_1.actors_["10100ui_story"]
			local var_574_1 = 0

			if var_574_1 < arg_571_1.time_ and arg_571_1.time_ <= var_574_1 + arg_574_0 and not isNil(var_574_0) and arg_571_1.var_.characterEffect10100ui_story == nil then
				arg_571_1.var_.characterEffect10100ui_story = var_574_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_574_2 = 0.200000002980232

			if var_574_1 <= arg_571_1.time_ and arg_571_1.time_ < var_574_1 + var_574_2 and not isNil(var_574_0) then
				local var_574_3 = (arg_571_1.time_ - var_574_1) / var_574_2

				if arg_571_1.var_.characterEffect10100ui_story and not isNil(var_574_0) then
					arg_571_1.var_.characterEffect10100ui_story.fillFlat = false
				end
			end

			if arg_571_1.time_ >= var_574_1 + var_574_2 and arg_571_1.time_ < var_574_1 + var_574_2 + arg_574_0 and not isNil(var_574_0) and arg_571_1.var_.characterEffect10100ui_story then
				arg_571_1.var_.characterEffect10100ui_story.fillFlat = false
			end

			local var_574_4 = 0

			if var_574_4 < arg_571_1.time_ and arg_571_1.time_ <= var_574_4 + arg_574_0 then
				arg_571_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action1_1")
			end

			local var_574_5 = 0

			if var_574_5 < arg_571_1.time_ and arg_571_1.time_ <= var_574_5 + arg_574_0 then
				arg_571_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_574_6 = 0
			local var_574_7 = 0.85

			if var_574_6 < arg_571_1.time_ and arg_571_1.time_ <= var_574_6 + arg_574_0 then
				arg_571_1.talkMaxDuration = 0
				arg_571_1.dialogCg_.alpha = 1

				arg_571_1.dialog_:SetActive(true)
				SetActive(arg_571_1.leftNameGo_, true)

				local var_574_8 = arg_571_1:FormatText(StoryNameCfg[1021].name)

				arg_571_1.leftNameTxt_.text = var_574_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_571_1.leftNameTxt_.transform)

				arg_571_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_571_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_571_1:RecordName(arg_571_1.leftNameTxt_.text)
				SetActive(arg_571_1.iconTrs_.gameObject, false)
				arg_571_1.callingController_:SetSelectedState("normal")

				local var_574_9 = arg_571_1:GetWordFromCfg(320061138)
				local var_574_10 = arg_571_1:FormatText(var_574_9.content)

				arg_571_1.text_.text = var_574_10

				LuaForUtil.ClearLinePrefixSymbol(arg_571_1.text_)

				local var_574_11 = 34
				local var_574_12 = utf8.len(var_574_10)
				local var_574_13 = var_574_11 <= 0 and var_574_7 or var_574_7 * (var_574_12 / var_574_11)

				if var_574_13 > 0 and var_574_7 < var_574_13 then
					arg_571_1.talkMaxDuration = var_574_13

					if var_574_13 + var_574_6 > arg_571_1.duration_ then
						arg_571_1.duration_ = var_574_13 + var_574_6
					end
				end

				arg_571_1.text_.text = var_574_10
				arg_571_1.typewritter.percent = 0

				arg_571_1.typewritter:SetDirty()
				arg_571_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320061", "320061138", "story_v_out_320061.awb") ~= 0 then
					local var_574_14 = manager.audio:GetVoiceLength("story_v_out_320061", "320061138", "story_v_out_320061.awb") / 1000

					if var_574_14 + var_574_6 > arg_571_1.duration_ then
						arg_571_1.duration_ = var_574_14 + var_574_6
					end

					if var_574_9.prefab_name ~= "" and arg_571_1.actors_[var_574_9.prefab_name] ~= nil then
						local var_574_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_571_1.actors_[var_574_9.prefab_name].transform, "story_v_out_320061", "320061138", "story_v_out_320061.awb")

						arg_571_1:RecordAudio("320061138", var_574_15)
						arg_571_1:RecordAudio("320061138", var_574_15)
					else
						arg_571_1:AudioAction("play", "voice", "story_v_out_320061", "320061138", "story_v_out_320061.awb")
					end

					arg_571_1:RecordHistoryTalkVoice("story_v_out_320061", "320061138", "story_v_out_320061.awb")
				end

				arg_571_1:RecordContent(arg_571_1.text_.text)
			end

			local var_574_16 = math.max(var_574_7, arg_571_1.talkMaxDuration)

			if var_574_6 <= arg_571_1.time_ and arg_571_1.time_ < var_574_6 + var_574_16 then
				arg_571_1.typewritter.percent = (arg_571_1.time_ - var_574_6) / var_574_16

				arg_571_1.typewritter:SetDirty()
			end

			if arg_571_1.time_ >= var_574_6 + var_574_16 and arg_571_1.time_ < var_574_6 + var_574_16 + arg_574_0 then
				arg_571_1.typewritter.percent = 1

				arg_571_1.typewritter:SetDirty()
				arg_571_1:ShowNextGo(true)
			end
		end

		arg_571_1.nodeConfigList_ = {}

		arg_571_1:InitPlayNodeList()
	end,
	Play320061139 = function(arg_575_0, arg_575_1)
		arg_575_1.time_ = 0
		arg_575_1.frameCnt_ = 0
		arg_575_1.state_ = "playing"
		arg_575_1.curTalkId_ = 320061139
		arg_575_1.duration_ = 5.2

		local var_575_0 = {
			zh = 5.2,
			ja = 3.833
		}
		local var_575_1 = manager.audio:GetLocalizationFlag()

		if var_575_0[var_575_1] ~= nil then
			arg_575_1.duration_ = var_575_0[var_575_1]
		end

		SetActive(arg_575_1.tipsGo_, false)

		function arg_575_1.onSingleLineFinish_()
			arg_575_1.onSingleLineUpdate_ = nil
			arg_575_1.onSingleLineFinish_ = nil
			arg_575_1.state_ = "waiting"
		end

		function arg_575_1.playNext_(arg_577_0)
			if arg_577_0 == 1 then
				arg_575_0:Play320061140(arg_575_1)
			end
		end

		function arg_575_1.onSingleLineUpdate_(arg_578_0)
			local var_578_0 = arg_575_1.actors_["1011ui_story"].transform
			local var_578_1 = 0

			if var_578_1 < arg_575_1.time_ and arg_575_1.time_ <= var_578_1 + arg_578_0 then
				arg_575_1.var_.moveOldPos1011ui_story = var_578_0.localPosition
			end

			local var_578_2 = 0.001

			if var_578_1 <= arg_575_1.time_ and arg_575_1.time_ < var_578_1 + var_578_2 then
				local var_578_3 = (arg_575_1.time_ - var_578_1) / var_578_2
				local var_578_4 = Vector3.New(0.7, -0.71, -6)

				var_578_0.localPosition = Vector3.Lerp(arg_575_1.var_.moveOldPos1011ui_story, var_578_4, var_578_3)

				local var_578_5 = manager.ui.mainCamera.transform.position - var_578_0.position

				var_578_0.forward = Vector3.New(var_578_5.x, var_578_5.y, var_578_5.z)

				local var_578_6 = var_578_0.localEulerAngles

				var_578_6.z = 0
				var_578_6.x = 0
				var_578_0.localEulerAngles = var_578_6
			end

			if arg_575_1.time_ >= var_578_1 + var_578_2 and arg_575_1.time_ < var_578_1 + var_578_2 + arg_578_0 then
				var_578_0.localPosition = Vector3.New(0.7, -0.71, -6)

				local var_578_7 = manager.ui.mainCamera.transform.position - var_578_0.position

				var_578_0.forward = Vector3.New(var_578_7.x, var_578_7.y, var_578_7.z)

				local var_578_8 = var_578_0.localEulerAngles

				var_578_8.z = 0
				var_578_8.x = 0
				var_578_0.localEulerAngles = var_578_8
			end

			local var_578_9 = arg_575_1.actors_["1011ui_story"]
			local var_578_10 = 0

			if var_578_10 < arg_575_1.time_ and arg_575_1.time_ <= var_578_10 + arg_578_0 and not isNil(var_578_9) and arg_575_1.var_.characterEffect1011ui_story == nil then
				arg_575_1.var_.characterEffect1011ui_story = var_578_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_578_11 = 0.200000002980232

			if var_578_10 <= arg_575_1.time_ and arg_575_1.time_ < var_578_10 + var_578_11 and not isNil(var_578_9) then
				local var_578_12 = (arg_575_1.time_ - var_578_10) / var_578_11

				if arg_575_1.var_.characterEffect1011ui_story and not isNil(var_578_9) then
					arg_575_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_575_1.time_ >= var_578_10 + var_578_11 and arg_575_1.time_ < var_578_10 + var_578_11 + arg_578_0 and not isNil(var_578_9) and arg_575_1.var_.characterEffect1011ui_story then
				arg_575_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_578_13 = 0

			if var_578_13 < arg_575_1.time_ and arg_575_1.time_ <= var_578_13 + arg_578_0 then
				arg_575_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action6_1")
			end

			local var_578_14 = 0

			if var_578_14 < arg_575_1.time_ and arg_575_1.time_ <= var_578_14 + arg_578_0 then
				arg_575_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_578_15 = arg_575_1.actors_["10100ui_story"]
			local var_578_16 = 0

			if var_578_16 < arg_575_1.time_ and arg_575_1.time_ <= var_578_16 + arg_578_0 and not isNil(var_578_15) and arg_575_1.var_.characterEffect10100ui_story == nil then
				arg_575_1.var_.characterEffect10100ui_story = var_578_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_578_17 = 0.200000002980232

			if var_578_16 <= arg_575_1.time_ and arg_575_1.time_ < var_578_16 + var_578_17 and not isNil(var_578_15) then
				local var_578_18 = (arg_575_1.time_ - var_578_16) / var_578_17

				if arg_575_1.var_.characterEffect10100ui_story and not isNil(var_578_15) then
					local var_578_19 = Mathf.Lerp(0, 0.5, var_578_18)

					arg_575_1.var_.characterEffect10100ui_story.fillFlat = true
					arg_575_1.var_.characterEffect10100ui_story.fillRatio = var_578_19
				end
			end

			if arg_575_1.time_ >= var_578_16 + var_578_17 and arg_575_1.time_ < var_578_16 + var_578_17 + arg_578_0 and not isNil(var_578_15) and arg_575_1.var_.characterEffect10100ui_story then
				local var_578_20 = 0.5

				arg_575_1.var_.characterEffect10100ui_story.fillFlat = true
				arg_575_1.var_.characterEffect10100ui_story.fillRatio = var_578_20
			end

			local var_578_21 = arg_575_1.actors_["10100ui_story"].transform
			local var_578_22 = 0

			if var_578_22 < arg_575_1.time_ and arg_575_1.time_ <= var_578_22 + arg_578_0 then
				arg_575_1.var_.moveOldPos10100ui_story = var_578_21.localPosition
			end

			local var_578_23 = 0.001

			if var_578_22 <= arg_575_1.time_ and arg_575_1.time_ < var_578_22 + var_578_23 then
				local var_578_24 = (arg_575_1.time_ - var_578_22) / var_578_23
				local var_578_25 = Vector3.New(-0.7, -1.16, -6.25)

				var_578_21.localPosition = Vector3.Lerp(arg_575_1.var_.moveOldPos10100ui_story, var_578_25, var_578_24)

				local var_578_26 = manager.ui.mainCamera.transform.position - var_578_21.position

				var_578_21.forward = Vector3.New(var_578_26.x, var_578_26.y, var_578_26.z)

				local var_578_27 = var_578_21.localEulerAngles

				var_578_27.z = 0
				var_578_27.x = 0
				var_578_21.localEulerAngles = var_578_27
			end

			if arg_575_1.time_ >= var_578_22 + var_578_23 and arg_575_1.time_ < var_578_22 + var_578_23 + arg_578_0 then
				var_578_21.localPosition = Vector3.New(-0.7, -1.16, -6.25)

				local var_578_28 = manager.ui.mainCamera.transform.position - var_578_21.position

				var_578_21.forward = Vector3.New(var_578_28.x, var_578_28.y, var_578_28.z)

				local var_578_29 = var_578_21.localEulerAngles

				var_578_29.z = 0
				var_578_29.x = 0
				var_578_21.localEulerAngles = var_578_29
			end

			local var_578_30 = 1.06666666666667
			local var_578_31 = 0.2

			if var_578_30 < arg_575_1.time_ and arg_575_1.time_ <= var_578_30 + arg_578_0 then
				local var_578_32 = "play"
				local var_578_33 = "music"

				arg_575_1:AudioAction(var_578_32, var_578_33, "ui_battle", "ui_battle_stopbgm", "")

				local var_578_34 = ""
				local var_578_35 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_578_35 ~= "" then
					if arg_575_1.bgmTxt_.text ~= var_578_35 and arg_575_1.bgmTxt_.text ~= "" then
						if arg_575_1.bgmTxt2_.text ~= "" then
							arg_575_1.bgmTxt_.text = arg_575_1.bgmTxt2_.text
						end

						arg_575_1.bgmTxt2_.text = var_578_35

						arg_575_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_575_1.bgmTxt_.text = var_578_35
						arg_575_1.bgmTxt2_.text = var_578_35
					end

					if arg_575_1.bgmTimer then
						arg_575_1.bgmTimer:Stop()

						arg_575_1.bgmTimer = nil
					end

					if arg_575_1.settingData.show_music_name == 1 then
						arg_575_1.musicController:SetSelectedState("show")
						arg_575_1.musicAnimator_:Play("open", 0, 0)

						if arg_575_1.settingData.music_time ~= 0 then
							arg_575_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_575_1.settingData.music_time), function()
								if arg_575_1 == nil or isNil(arg_575_1.bgmTxt_) then
									return
								end

								arg_575_1.musicController:SetSelectedState("hide")
								arg_575_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_578_36 = 0
			local var_578_37 = 0.275

			if var_578_36 < arg_575_1.time_ and arg_575_1.time_ <= var_578_36 + arg_578_0 then
				arg_575_1.talkMaxDuration = 0
				arg_575_1.dialogCg_.alpha = 1

				arg_575_1.dialog_:SetActive(true)
				SetActive(arg_575_1.leftNameGo_, true)

				local var_578_38 = arg_575_1:FormatText(StoryNameCfg[37].name)

				arg_575_1.leftNameTxt_.text = var_578_38

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_575_1.leftNameTxt_.transform)

				arg_575_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_575_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_575_1:RecordName(arg_575_1.leftNameTxt_.text)
				SetActive(arg_575_1.iconTrs_.gameObject, false)
				arg_575_1.callingController_:SetSelectedState("normal")

				local var_578_39 = arg_575_1:GetWordFromCfg(320061139)
				local var_578_40 = arg_575_1:FormatText(var_578_39.content)

				arg_575_1.text_.text = var_578_40

				LuaForUtil.ClearLinePrefixSymbol(arg_575_1.text_)

				local var_578_41 = 11
				local var_578_42 = utf8.len(var_578_40)
				local var_578_43 = var_578_41 <= 0 and var_578_37 or var_578_37 * (var_578_42 / var_578_41)

				if var_578_43 > 0 and var_578_37 < var_578_43 then
					arg_575_1.talkMaxDuration = var_578_43

					if var_578_43 + var_578_36 > arg_575_1.duration_ then
						arg_575_1.duration_ = var_578_43 + var_578_36
					end
				end

				arg_575_1.text_.text = var_578_40
				arg_575_1.typewritter.percent = 0

				arg_575_1.typewritter:SetDirty()
				arg_575_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320061", "320061139", "story_v_out_320061.awb") ~= 0 then
					local var_578_44 = manager.audio:GetVoiceLength("story_v_out_320061", "320061139", "story_v_out_320061.awb") / 1000

					if var_578_44 + var_578_36 > arg_575_1.duration_ then
						arg_575_1.duration_ = var_578_44 + var_578_36
					end

					if var_578_39.prefab_name ~= "" and arg_575_1.actors_[var_578_39.prefab_name] ~= nil then
						local var_578_45 = LuaForUtil.PlayVoiceWithCriLipsync(arg_575_1.actors_[var_578_39.prefab_name].transform, "story_v_out_320061", "320061139", "story_v_out_320061.awb")

						arg_575_1:RecordAudio("320061139", var_578_45)
						arg_575_1:RecordAudio("320061139", var_578_45)
					else
						arg_575_1:AudioAction("play", "voice", "story_v_out_320061", "320061139", "story_v_out_320061.awb")
					end

					arg_575_1:RecordHistoryTalkVoice("story_v_out_320061", "320061139", "story_v_out_320061.awb")
				end

				arg_575_1:RecordContent(arg_575_1.text_.text)
			end

			local var_578_46 = math.max(var_578_37, arg_575_1.talkMaxDuration)

			if var_578_36 <= arg_575_1.time_ and arg_575_1.time_ < var_578_36 + var_578_46 then
				arg_575_1.typewritter.percent = (arg_575_1.time_ - var_578_36) / var_578_46

				arg_575_1.typewritter:SetDirty()
			end

			if arg_575_1.time_ >= var_578_36 + var_578_46 and arg_575_1.time_ < var_578_36 + var_578_46 + arg_578_0 then
				arg_575_1.typewritter.percent = 1

				arg_575_1.typewritter:SetDirty()
				arg_575_1:ShowNextGo(true)
			end
		end

		arg_575_1.nodeConfigList_ = {
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
				actorName = "10100ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_575_1:InitPlayNodeList()
	end,
	Play320061140 = function(arg_580_0, arg_580_1)
		arg_580_1.time_ = 0
		arg_580_1.frameCnt_ = 0
		arg_580_1.state_ = "playing"
		arg_580_1.curTalkId_ = 320061140
		arg_580_1.duration_ = 5

		SetActive(arg_580_1.tipsGo_, false)

		function arg_580_1.onSingleLineFinish_()
			arg_580_1.onSingleLineUpdate_ = nil
			arg_580_1.onSingleLineFinish_ = nil
			arg_580_1.state_ = "waiting"
		end

		function arg_580_1.playNext_(arg_582_0)
			if arg_582_0 == 1 then
				arg_580_0:Play320061141(arg_580_1)
			end
		end

		function arg_580_1.onSingleLineUpdate_(arg_583_0)
			local var_583_0 = arg_580_1.actors_["1011ui_story"].transform
			local var_583_1 = 0

			if var_583_1 < arg_580_1.time_ and arg_580_1.time_ <= var_583_1 + arg_583_0 then
				arg_580_1.var_.moveOldPos1011ui_story = var_583_0.localPosition
			end

			local var_583_2 = 0.001

			if var_583_1 <= arg_580_1.time_ and arg_580_1.time_ < var_583_1 + var_583_2 then
				local var_583_3 = (arg_580_1.time_ - var_583_1) / var_583_2
				local var_583_4 = Vector3.New(0, 100, 0)

				var_583_0.localPosition = Vector3.Lerp(arg_580_1.var_.moveOldPos1011ui_story, var_583_4, var_583_3)

				local var_583_5 = manager.ui.mainCamera.transform.position - var_583_0.position

				var_583_0.forward = Vector3.New(var_583_5.x, var_583_5.y, var_583_5.z)

				local var_583_6 = var_583_0.localEulerAngles

				var_583_6.z = 0
				var_583_6.x = 0
				var_583_0.localEulerAngles = var_583_6
			end

			if arg_580_1.time_ >= var_583_1 + var_583_2 and arg_580_1.time_ < var_583_1 + var_583_2 + arg_583_0 then
				var_583_0.localPosition = Vector3.New(0, 100, 0)

				local var_583_7 = manager.ui.mainCamera.transform.position - var_583_0.position

				var_583_0.forward = Vector3.New(var_583_7.x, var_583_7.y, var_583_7.z)

				local var_583_8 = var_583_0.localEulerAngles

				var_583_8.z = 0
				var_583_8.x = 0
				var_583_0.localEulerAngles = var_583_8
			end

			local var_583_9 = arg_580_1.actors_["1011ui_story"]
			local var_583_10 = 0

			if var_583_10 < arg_580_1.time_ and arg_580_1.time_ <= var_583_10 + arg_583_0 and not isNil(var_583_9) and arg_580_1.var_.characterEffect1011ui_story == nil then
				arg_580_1.var_.characterEffect1011ui_story = var_583_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_583_11 = 0.200000002980232

			if var_583_10 <= arg_580_1.time_ and arg_580_1.time_ < var_583_10 + var_583_11 and not isNil(var_583_9) then
				local var_583_12 = (arg_580_1.time_ - var_583_10) / var_583_11

				if arg_580_1.var_.characterEffect1011ui_story and not isNil(var_583_9) then
					local var_583_13 = Mathf.Lerp(0, 0.5, var_583_12)

					arg_580_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_580_1.var_.characterEffect1011ui_story.fillRatio = var_583_13
				end
			end

			if arg_580_1.time_ >= var_583_10 + var_583_11 and arg_580_1.time_ < var_583_10 + var_583_11 + arg_583_0 and not isNil(var_583_9) and arg_580_1.var_.characterEffect1011ui_story then
				local var_583_14 = 0.5

				arg_580_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_580_1.var_.characterEffect1011ui_story.fillRatio = var_583_14
			end

			local var_583_15 = arg_580_1.actors_["10100ui_story"].transform
			local var_583_16 = 0

			if var_583_16 < arg_580_1.time_ and arg_580_1.time_ <= var_583_16 + arg_583_0 then
				arg_580_1.var_.moveOldPos10100ui_story = var_583_15.localPosition
			end

			local var_583_17 = 0.001

			if var_583_16 <= arg_580_1.time_ and arg_580_1.time_ < var_583_16 + var_583_17 then
				local var_583_18 = (arg_580_1.time_ - var_583_16) / var_583_17
				local var_583_19 = Vector3.New(0, 100, 0)

				var_583_15.localPosition = Vector3.Lerp(arg_580_1.var_.moveOldPos10100ui_story, var_583_19, var_583_18)

				local var_583_20 = manager.ui.mainCamera.transform.position - var_583_15.position

				var_583_15.forward = Vector3.New(var_583_20.x, var_583_20.y, var_583_20.z)

				local var_583_21 = var_583_15.localEulerAngles

				var_583_21.z = 0
				var_583_21.x = 0
				var_583_15.localEulerAngles = var_583_21
			end

			if arg_580_1.time_ >= var_583_16 + var_583_17 and arg_580_1.time_ < var_583_16 + var_583_17 + arg_583_0 then
				var_583_15.localPosition = Vector3.New(0, 100, 0)

				local var_583_22 = manager.ui.mainCamera.transform.position - var_583_15.position

				var_583_15.forward = Vector3.New(var_583_22.x, var_583_22.y, var_583_22.z)

				local var_583_23 = var_583_15.localEulerAngles

				var_583_23.z = 0
				var_583_23.x = 0
				var_583_15.localEulerAngles = var_583_23
			end

			local var_583_24 = arg_580_1.actors_["10100ui_story"]
			local var_583_25 = 0

			if var_583_25 < arg_580_1.time_ and arg_580_1.time_ <= var_583_25 + arg_583_0 and not isNil(var_583_24) and arg_580_1.var_.characterEffect10100ui_story == nil then
				arg_580_1.var_.characterEffect10100ui_story = var_583_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_583_26 = 0.200000002980232

			if var_583_25 <= arg_580_1.time_ and arg_580_1.time_ < var_583_25 + var_583_26 and not isNil(var_583_24) then
				local var_583_27 = (arg_580_1.time_ - var_583_25) / var_583_26

				if arg_580_1.var_.characterEffect10100ui_story and not isNil(var_583_24) then
					local var_583_28 = Mathf.Lerp(0, 0.5, var_583_27)

					arg_580_1.var_.characterEffect10100ui_story.fillFlat = true
					arg_580_1.var_.characterEffect10100ui_story.fillRatio = var_583_28
				end
			end

			if arg_580_1.time_ >= var_583_25 + var_583_26 and arg_580_1.time_ < var_583_25 + var_583_26 + arg_583_0 and not isNil(var_583_24) and arg_580_1.var_.characterEffect10100ui_story then
				local var_583_29 = 0.5

				arg_580_1.var_.characterEffect10100ui_story.fillFlat = true
				arg_580_1.var_.characterEffect10100ui_story.fillRatio = var_583_29
			end

			local var_583_30 = 0
			local var_583_31 = 0.825

			if var_583_30 < arg_580_1.time_ and arg_580_1.time_ <= var_583_30 + arg_583_0 then
				arg_580_1.talkMaxDuration = 0
				arg_580_1.dialogCg_.alpha = 1

				arg_580_1.dialog_:SetActive(true)
				SetActive(arg_580_1.leftNameGo_, false)

				arg_580_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_580_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_580_1:RecordName(arg_580_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_580_1.iconTrs_.gameObject, false)
				arg_580_1.callingController_:SetSelectedState("normal")

				local var_583_32 = arg_580_1:GetWordFromCfg(320061140)
				local var_583_33 = arg_580_1:FormatText(var_583_32.content)

				arg_580_1.text_.text = var_583_33

				LuaForUtil.ClearLinePrefixSymbol(arg_580_1.text_)

				local var_583_34 = 33
				local var_583_35 = utf8.len(var_583_33)
				local var_583_36 = var_583_34 <= 0 and var_583_31 or var_583_31 * (var_583_35 / var_583_34)

				if var_583_36 > 0 and var_583_31 < var_583_36 then
					arg_580_1.talkMaxDuration = var_583_36

					if var_583_36 + var_583_30 > arg_580_1.duration_ then
						arg_580_1.duration_ = var_583_36 + var_583_30
					end
				end

				arg_580_1.text_.text = var_583_33
				arg_580_1.typewritter.percent = 0

				arg_580_1.typewritter:SetDirty()
				arg_580_1:ShowNextGo(false)
				arg_580_1:RecordContent(arg_580_1.text_.text)
			end

			local var_583_37 = math.max(var_583_31, arg_580_1.talkMaxDuration)

			if var_583_30 <= arg_580_1.time_ and arg_580_1.time_ < var_583_30 + var_583_37 then
				arg_580_1.typewritter.percent = (arg_580_1.time_ - var_583_30) / var_583_37

				arg_580_1.typewritter:SetDirty()
			end

			if arg_580_1.time_ >= var_583_30 + var_583_37 and arg_580_1.time_ < var_583_30 + var_583_37 + arg_583_0 then
				arg_580_1.typewritter.percent = 1

				arg_580_1.typewritter:SetDirty()
				arg_580_1:ShowNextGo(true)
			end
		end

		arg_580_1.nodeConfigList_ = {
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
				actorName = "10100ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_580_1:InitPlayNodeList()
	end,
	Play320061141 = function(arg_584_0, arg_584_1)
		arg_584_1.time_ = 0
		arg_584_1.frameCnt_ = 0
		arg_584_1.state_ = "playing"
		arg_584_1.curTalkId_ = 320061141
		arg_584_1.duration_ = 5

		SetActive(arg_584_1.tipsGo_, false)

		function arg_584_1.onSingleLineFinish_()
			arg_584_1.onSingleLineUpdate_ = nil
			arg_584_1.onSingleLineFinish_ = nil
			arg_584_1.state_ = "waiting"
		end

		function arg_584_1.playNext_(arg_586_0)
			if arg_586_0 == 1 then
				arg_584_0:Play320061142(arg_584_1)
			end
		end

		function arg_584_1.onSingleLineUpdate_(arg_587_0)
			local var_587_0 = 0
			local var_587_1 = 1.2

			if var_587_0 < arg_584_1.time_ and arg_584_1.time_ <= var_587_0 + arg_587_0 then
				arg_584_1.talkMaxDuration = 0
				arg_584_1.dialogCg_.alpha = 1

				arg_584_1.dialog_:SetActive(true)
				SetActive(arg_584_1.leftNameGo_, false)

				arg_584_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_584_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_584_1:RecordName(arg_584_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_584_1.iconTrs_.gameObject, false)
				arg_584_1.callingController_:SetSelectedState("normal")

				local var_587_2 = arg_584_1:GetWordFromCfg(320061141)
				local var_587_3 = arg_584_1:FormatText(var_587_2.content)

				arg_584_1.text_.text = var_587_3

				LuaForUtil.ClearLinePrefixSymbol(arg_584_1.text_)

				local var_587_4 = 48
				local var_587_5 = utf8.len(var_587_3)
				local var_587_6 = var_587_4 <= 0 and var_587_1 or var_587_1 * (var_587_5 / var_587_4)

				if var_587_6 > 0 and var_587_1 < var_587_6 then
					arg_584_1.talkMaxDuration = var_587_6

					if var_587_6 + var_587_0 > arg_584_1.duration_ then
						arg_584_1.duration_ = var_587_6 + var_587_0
					end
				end

				arg_584_1.text_.text = var_587_3
				arg_584_1.typewritter.percent = 0

				arg_584_1.typewritter:SetDirty()
				arg_584_1:ShowNextGo(false)
				arg_584_1:RecordContent(arg_584_1.text_.text)
			end

			local var_587_7 = math.max(var_587_1, arg_584_1.talkMaxDuration)

			if var_587_0 <= arg_584_1.time_ and arg_584_1.time_ < var_587_0 + var_587_7 then
				arg_584_1.typewritter.percent = (arg_584_1.time_ - var_587_0) / var_587_7

				arg_584_1.typewritter:SetDirty()
			end

			if arg_584_1.time_ >= var_587_0 + var_587_7 and arg_584_1.time_ < var_587_0 + var_587_7 + arg_587_0 then
				arg_584_1.typewritter.percent = 1

				arg_584_1.typewritter:SetDirty()
				arg_584_1:ShowNextGo(true)
			end
		end

		arg_584_1.nodeConfigList_ = {}

		arg_584_1:InitPlayNodeList()
	end,
	Play320061142 = function(arg_588_0, arg_588_1)
		arg_588_1.time_ = 0
		arg_588_1.frameCnt_ = 0
		arg_588_1.state_ = "playing"
		arg_588_1.curTalkId_ = 320061142
		arg_588_1.duration_ = 5

		SetActive(arg_588_1.tipsGo_, false)

		function arg_588_1.onSingleLineFinish_()
			arg_588_1.onSingleLineUpdate_ = nil
			arg_588_1.onSingleLineFinish_ = nil
			arg_588_1.state_ = "waiting"
		end

		function arg_588_1.playNext_(arg_590_0)
			if arg_590_0 == 1 then
				arg_588_0:Play320061143(arg_588_1)
			end
		end

		function arg_588_1.onSingleLineUpdate_(arg_591_0)
			local var_591_0 = 0
			local var_591_1 = 0.875

			if var_591_0 < arg_588_1.time_ and arg_588_1.time_ <= var_591_0 + arg_591_0 then
				arg_588_1.talkMaxDuration = 0
				arg_588_1.dialogCg_.alpha = 1

				arg_588_1.dialog_:SetActive(true)
				SetActive(arg_588_1.leftNameGo_, true)

				local var_591_2 = arg_588_1:FormatText(StoryNameCfg[7].name)

				arg_588_1.leftNameTxt_.text = var_591_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_588_1.leftNameTxt_.transform)

				arg_588_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_588_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_588_1:RecordName(arg_588_1.leftNameTxt_.text)
				SetActive(arg_588_1.iconTrs_.gameObject, true)
				arg_588_1.iconController_:SetSelectedState("hero")

				arg_588_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_588_1.callingController_:SetSelectedState("normal")

				arg_588_1.keyicon_.color = Color.New(1, 1, 1)
				arg_588_1.icon_.color = Color.New(1, 1, 1)

				local var_591_3 = arg_588_1:GetWordFromCfg(320061142)
				local var_591_4 = arg_588_1:FormatText(var_591_3.content)

				arg_588_1.text_.text = var_591_4

				LuaForUtil.ClearLinePrefixSymbol(arg_588_1.text_)

				local var_591_5 = 35
				local var_591_6 = utf8.len(var_591_4)
				local var_591_7 = var_591_5 <= 0 and var_591_1 or var_591_1 * (var_591_6 / var_591_5)

				if var_591_7 > 0 and var_591_1 < var_591_7 then
					arg_588_1.talkMaxDuration = var_591_7

					if var_591_7 + var_591_0 > arg_588_1.duration_ then
						arg_588_1.duration_ = var_591_7 + var_591_0
					end
				end

				arg_588_1.text_.text = var_591_4
				arg_588_1.typewritter.percent = 0

				arg_588_1.typewritter:SetDirty()
				arg_588_1:ShowNextGo(false)
				arg_588_1:RecordContent(arg_588_1.text_.text)
			end

			local var_591_8 = math.max(var_591_1, arg_588_1.talkMaxDuration)

			if var_591_0 <= arg_588_1.time_ and arg_588_1.time_ < var_591_0 + var_591_8 then
				arg_588_1.typewritter.percent = (arg_588_1.time_ - var_591_0) / var_591_8

				arg_588_1.typewritter:SetDirty()
			end

			if arg_588_1.time_ >= var_591_0 + var_591_8 and arg_588_1.time_ < var_591_0 + var_591_8 + arg_591_0 then
				arg_588_1.typewritter.percent = 1

				arg_588_1.typewritter:SetDirty()
				arg_588_1:ShowNextGo(true)
			end
		end

		arg_588_1.nodeConfigList_ = {}

		arg_588_1:InitPlayNodeList()
	end,
	Play320061143 = function(arg_592_0, arg_592_1)
		arg_592_1.time_ = 0
		arg_592_1.frameCnt_ = 0
		arg_592_1.state_ = "playing"
		arg_592_1.curTalkId_ = 320061143
		arg_592_1.duration_ = 5

		SetActive(arg_592_1.tipsGo_, false)

		function arg_592_1.onSingleLineFinish_()
			arg_592_1.onSingleLineUpdate_ = nil
			arg_592_1.onSingleLineFinish_ = nil
			arg_592_1.state_ = "waiting"
		end

		function arg_592_1.playNext_(arg_594_0)
			if arg_594_0 == 1 then
				arg_592_0:Play320061144(arg_592_1)
			end
		end

		function arg_592_1.onSingleLineUpdate_(arg_595_0)
			local var_595_0 = 0
			local var_595_1 = 0.675

			if var_595_0 < arg_592_1.time_ and arg_592_1.time_ <= var_595_0 + arg_595_0 then
				arg_592_1.talkMaxDuration = 0
				arg_592_1.dialogCg_.alpha = 1

				arg_592_1.dialog_:SetActive(true)
				SetActive(arg_592_1.leftNameGo_, false)

				arg_592_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_592_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_592_1:RecordName(arg_592_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_592_1.iconTrs_.gameObject, false)
				arg_592_1.callingController_:SetSelectedState("normal")

				local var_595_2 = arg_592_1:GetWordFromCfg(320061143)
				local var_595_3 = arg_592_1:FormatText(var_595_2.content)

				arg_592_1.text_.text = var_595_3

				LuaForUtil.ClearLinePrefixSymbol(arg_592_1.text_)

				local var_595_4 = 27
				local var_595_5 = utf8.len(var_595_3)
				local var_595_6 = var_595_4 <= 0 and var_595_1 or var_595_1 * (var_595_5 / var_595_4)

				if var_595_6 > 0 and var_595_1 < var_595_6 then
					arg_592_1.talkMaxDuration = var_595_6

					if var_595_6 + var_595_0 > arg_592_1.duration_ then
						arg_592_1.duration_ = var_595_6 + var_595_0
					end
				end

				arg_592_1.text_.text = var_595_3
				arg_592_1.typewritter.percent = 0

				arg_592_1.typewritter:SetDirty()
				arg_592_1:ShowNextGo(false)
				arg_592_1:RecordContent(arg_592_1.text_.text)
			end

			local var_595_7 = math.max(var_595_1, arg_592_1.talkMaxDuration)

			if var_595_0 <= arg_592_1.time_ and arg_592_1.time_ < var_595_0 + var_595_7 then
				arg_592_1.typewritter.percent = (arg_592_1.time_ - var_595_0) / var_595_7

				arg_592_1.typewritter:SetDirty()
			end

			if arg_592_1.time_ >= var_595_0 + var_595_7 and arg_592_1.time_ < var_595_0 + var_595_7 + arg_595_0 then
				arg_592_1.typewritter.percent = 1

				arg_592_1.typewritter:SetDirty()
				arg_592_1:ShowNextGo(true)
			end
		end

		arg_592_1.nodeConfigList_ = {}

		arg_592_1:InitPlayNodeList()
	end,
	Play320061144 = function(arg_596_0, arg_596_1)
		arg_596_1.time_ = 0
		arg_596_1.frameCnt_ = 0
		arg_596_1.state_ = "playing"
		arg_596_1.curTalkId_ = 320061144
		arg_596_1.duration_ = 5

		SetActive(arg_596_1.tipsGo_, false)

		function arg_596_1.onSingleLineFinish_()
			arg_596_1.onSingleLineUpdate_ = nil
			arg_596_1.onSingleLineFinish_ = nil
			arg_596_1.state_ = "waiting"
		end

		function arg_596_1.playNext_(arg_598_0)
			if arg_598_0 == 1 then
				arg_596_0:Play320061145(arg_596_1)
			end
		end

		function arg_596_1.onSingleLineUpdate_(arg_599_0)
			local var_599_0 = 0
			local var_599_1 = 1

			if var_599_0 < arg_596_1.time_ and arg_596_1.time_ <= var_599_0 + arg_599_0 then
				local var_599_2 = "play"
				local var_599_3 = "music"

				arg_596_1:AudioAction(var_599_2, var_599_3, "bgm_activity_1_6_story_intense", "bgm_activity_1_6_story_intense", "bgm_activity_1_6_story_intense.awb")

				local var_599_4 = ""
				local var_599_5 = manager.audio:GetAudioName("bgm_activity_1_6_story_intense", "bgm_activity_1_6_story_intense")

				if var_599_5 ~= "" then
					if arg_596_1.bgmTxt_.text ~= var_599_5 and arg_596_1.bgmTxt_.text ~= "" then
						if arg_596_1.bgmTxt2_.text ~= "" then
							arg_596_1.bgmTxt_.text = arg_596_1.bgmTxt2_.text
						end

						arg_596_1.bgmTxt2_.text = var_599_5

						arg_596_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_596_1.bgmTxt_.text = var_599_5
						arg_596_1.bgmTxt2_.text = var_599_5
					end

					if arg_596_1.bgmTimer then
						arg_596_1.bgmTimer:Stop()

						arg_596_1.bgmTimer = nil
					end

					if arg_596_1.settingData.show_music_name == 1 then
						arg_596_1.musicController:SetSelectedState("show")
						arg_596_1.musicAnimator_:Play("open", 0, 0)

						if arg_596_1.settingData.music_time ~= 0 then
							arg_596_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_596_1.settingData.music_time), function()
								if arg_596_1 == nil or isNil(arg_596_1.bgmTxt_) then
									return
								end

								arg_596_1.musicController:SetSelectedState("hide")
								arg_596_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_599_6 = 0
			local var_599_7 = 0.8

			if var_599_6 < arg_596_1.time_ and arg_596_1.time_ <= var_599_6 + arg_599_0 then
				arg_596_1.talkMaxDuration = 0
				arg_596_1.dialogCg_.alpha = 1

				arg_596_1.dialog_:SetActive(true)
				SetActive(arg_596_1.leftNameGo_, false)

				arg_596_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_596_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_596_1:RecordName(arg_596_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_596_1.iconTrs_.gameObject, false)
				arg_596_1.callingController_:SetSelectedState("normal")

				local var_599_8 = arg_596_1:GetWordFromCfg(320061144)
				local var_599_9 = arg_596_1:FormatText(var_599_8.content)

				arg_596_1.text_.text = var_599_9

				LuaForUtil.ClearLinePrefixSymbol(arg_596_1.text_)

				local var_599_10 = 32
				local var_599_11 = utf8.len(var_599_9)
				local var_599_12 = var_599_10 <= 0 and var_599_7 or var_599_7 * (var_599_11 / var_599_10)

				if var_599_12 > 0 and var_599_7 < var_599_12 then
					arg_596_1.talkMaxDuration = var_599_12

					if var_599_12 + var_599_6 > arg_596_1.duration_ then
						arg_596_1.duration_ = var_599_12 + var_599_6
					end
				end

				arg_596_1.text_.text = var_599_9
				arg_596_1.typewritter.percent = 0

				arg_596_1.typewritter:SetDirty()
				arg_596_1:ShowNextGo(false)
				arg_596_1:RecordContent(arg_596_1.text_.text)
			end

			local var_599_13 = math.max(var_599_7, arg_596_1.talkMaxDuration)

			if var_599_6 <= arg_596_1.time_ and arg_596_1.time_ < var_599_6 + var_599_13 then
				arg_596_1.typewritter.percent = (arg_596_1.time_ - var_599_6) / var_599_13

				arg_596_1.typewritter:SetDirty()
			end

			if arg_596_1.time_ >= var_599_6 + var_599_13 and arg_596_1.time_ < var_599_6 + var_599_13 + arg_599_0 then
				arg_596_1.typewritter.percent = 1

				arg_596_1.typewritter:SetDirty()
				arg_596_1:ShowNextGo(true)
			end
		end

		arg_596_1.nodeConfigList_ = {}

		arg_596_1:InitPlayNodeList()
	end,
	Play320061145 = function(arg_601_0, arg_601_1)
		arg_601_1.time_ = 0
		arg_601_1.frameCnt_ = 0
		arg_601_1.state_ = "playing"
		arg_601_1.curTalkId_ = 320061145
		arg_601_1.duration_ = 5

		SetActive(arg_601_1.tipsGo_, false)

		function arg_601_1.onSingleLineFinish_()
			arg_601_1.onSingleLineUpdate_ = nil
			arg_601_1.onSingleLineFinish_ = nil
			arg_601_1.state_ = "waiting"
		end

		function arg_601_1.playNext_(arg_603_0)
			if arg_603_0 == 1 then
				arg_601_0:Play320061146(arg_601_1)
			end
		end

		function arg_601_1.onSingleLineUpdate_(arg_604_0)
			local var_604_0 = manager.ui.mainCamera.transform
			local var_604_1 = 0

			if var_604_1 < arg_601_1.time_ and arg_601_1.time_ <= var_604_1 + arg_604_0 then
				arg_601_1.var_.shakeOldPos = var_604_0.localPosition
			end

			local var_604_2 = 0.6

			if var_604_1 <= arg_601_1.time_ and arg_601_1.time_ < var_604_1 + var_604_2 then
				local var_604_3 = (arg_601_1.time_ - var_604_1) / 0.066
				local var_604_4, var_604_5 = math.modf(var_604_3)

				var_604_0.localPosition = Vector3.New(var_604_5 * 0.13, var_604_5 * 0.13, var_604_5 * 0.13) + arg_601_1.var_.shakeOldPos
			end

			if arg_601_1.time_ >= var_604_1 + var_604_2 and arg_601_1.time_ < var_604_1 + var_604_2 + arg_604_0 then
				var_604_0.localPosition = arg_601_1.var_.shakeOldPos
			end

			local var_604_6 = 0

			if var_604_6 < arg_601_1.time_ and arg_601_1.time_ <= var_604_6 + arg_604_0 then
				arg_601_1.allBtn_.enabled = false
			end

			local var_604_7 = 0.6

			if arg_601_1.time_ >= var_604_6 + var_604_7 and arg_601_1.time_ < var_604_6 + var_604_7 + arg_604_0 then
				arg_601_1.allBtn_.enabled = true
			end

			local var_604_8 = 0
			local var_604_9 = 0.275

			if var_604_8 < arg_601_1.time_ and arg_601_1.time_ <= var_604_8 + arg_604_0 then
				arg_601_1.talkMaxDuration = 0
				arg_601_1.dialogCg_.alpha = 1

				arg_601_1.dialog_:SetActive(true)
				SetActive(arg_601_1.leftNameGo_, true)

				local var_604_10 = arg_601_1:FormatText(StoryNameCfg[7].name)

				arg_601_1.leftNameTxt_.text = var_604_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_601_1.leftNameTxt_.transform)

				arg_601_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_601_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_601_1:RecordName(arg_601_1.leftNameTxt_.text)
				SetActive(arg_601_1.iconTrs_.gameObject, true)
				arg_601_1.iconController_:SetSelectedState("hero")

				arg_601_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_601_1.callingController_:SetSelectedState("normal")

				arg_601_1.keyicon_.color = Color.New(1, 1, 1)
				arg_601_1.icon_.color = Color.New(1, 1, 1)

				local var_604_11 = arg_601_1:GetWordFromCfg(320061145)
				local var_604_12 = arg_601_1:FormatText(var_604_11.content)

				arg_601_1.text_.text = var_604_12

				LuaForUtil.ClearLinePrefixSymbol(arg_601_1.text_)

				local var_604_13 = 11
				local var_604_14 = utf8.len(var_604_12)
				local var_604_15 = var_604_13 <= 0 and var_604_9 or var_604_9 * (var_604_14 / var_604_13)

				if var_604_15 > 0 and var_604_9 < var_604_15 then
					arg_601_1.talkMaxDuration = var_604_15

					if var_604_15 + var_604_8 > arg_601_1.duration_ then
						arg_601_1.duration_ = var_604_15 + var_604_8
					end
				end

				arg_601_1.text_.text = var_604_12
				arg_601_1.typewritter.percent = 0

				arg_601_1.typewritter:SetDirty()
				arg_601_1:ShowNextGo(false)
				arg_601_1:RecordContent(arg_601_1.text_.text)
			end

			local var_604_16 = math.max(var_604_9, arg_601_1.talkMaxDuration)

			if var_604_8 <= arg_601_1.time_ and arg_601_1.time_ < var_604_8 + var_604_16 then
				arg_601_1.typewritter.percent = (arg_601_1.time_ - var_604_8) / var_604_16

				arg_601_1.typewritter:SetDirty()
			end

			if arg_601_1.time_ >= var_604_8 + var_604_16 and arg_601_1.time_ < var_604_8 + var_604_16 + arg_604_0 then
				arg_601_1.typewritter.percent = 1

				arg_601_1.typewritter:SetDirty()
				arg_601_1:ShowNextGo(true)
			end
		end

		arg_601_1.nodeConfigList_ = {}

		arg_601_1:InitPlayNodeList()
	end,
	Play320061146 = function(arg_605_0, arg_605_1)
		arg_605_1.time_ = 0
		arg_605_1.frameCnt_ = 0
		arg_605_1.state_ = "playing"
		arg_605_1.curTalkId_ = 320061146
		arg_605_1.duration_ = 5

		SetActive(arg_605_1.tipsGo_, false)

		function arg_605_1.onSingleLineFinish_()
			arg_605_1.onSingleLineUpdate_ = nil
			arg_605_1.onSingleLineFinish_ = nil
			arg_605_1.state_ = "waiting"
		end

		function arg_605_1.playNext_(arg_607_0)
			if arg_607_0 == 1 then
				arg_605_0:Play320061147(arg_605_1)
			end
		end

		function arg_605_1.onSingleLineUpdate_(arg_608_0)
			local var_608_0 = 0
			local var_608_1 = 1.075

			if var_608_0 < arg_605_1.time_ and arg_605_1.time_ <= var_608_0 + arg_608_0 then
				arg_605_1.talkMaxDuration = 0
				arg_605_1.dialogCg_.alpha = 1

				arg_605_1.dialog_:SetActive(true)
				SetActive(arg_605_1.leftNameGo_, false)

				arg_605_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_605_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_605_1:RecordName(arg_605_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_605_1.iconTrs_.gameObject, false)
				arg_605_1.callingController_:SetSelectedState("normal")

				local var_608_2 = arg_605_1:GetWordFromCfg(320061146)
				local var_608_3 = arg_605_1:FormatText(var_608_2.content)

				arg_605_1.text_.text = var_608_3

				LuaForUtil.ClearLinePrefixSymbol(arg_605_1.text_)

				local var_608_4 = 43
				local var_608_5 = utf8.len(var_608_3)
				local var_608_6 = var_608_4 <= 0 and var_608_1 or var_608_1 * (var_608_5 / var_608_4)

				if var_608_6 > 0 and var_608_1 < var_608_6 then
					arg_605_1.talkMaxDuration = var_608_6

					if var_608_6 + var_608_0 > arg_605_1.duration_ then
						arg_605_1.duration_ = var_608_6 + var_608_0
					end
				end

				arg_605_1.text_.text = var_608_3
				arg_605_1.typewritter.percent = 0

				arg_605_1.typewritter:SetDirty()
				arg_605_1:ShowNextGo(false)
				arg_605_1:RecordContent(arg_605_1.text_.text)
			end

			local var_608_7 = math.max(var_608_1, arg_605_1.talkMaxDuration)

			if var_608_0 <= arg_605_1.time_ and arg_605_1.time_ < var_608_0 + var_608_7 then
				arg_605_1.typewritter.percent = (arg_605_1.time_ - var_608_0) / var_608_7

				arg_605_1.typewritter:SetDirty()
			end

			if arg_605_1.time_ >= var_608_0 + var_608_7 and arg_605_1.time_ < var_608_0 + var_608_7 + arg_608_0 then
				arg_605_1.typewritter.percent = 1

				arg_605_1.typewritter:SetDirty()
				arg_605_1:ShowNextGo(true)
			end
		end

		arg_605_1.nodeConfigList_ = {}

		arg_605_1:InitPlayNodeList()
	end,
	Play320061147 = function(arg_609_0, arg_609_1)
		arg_609_1.time_ = 0
		arg_609_1.frameCnt_ = 0
		arg_609_1.state_ = "playing"
		arg_609_1.curTalkId_ = 320061147
		arg_609_1.duration_ = 2.77

		local var_609_0 = {
			zh = 2.6,
			ja = 2.766
		}
		local var_609_1 = manager.audio:GetLocalizationFlag()

		if var_609_0[var_609_1] ~= nil then
			arg_609_1.duration_ = var_609_0[var_609_1]
		end

		SetActive(arg_609_1.tipsGo_, false)

		function arg_609_1.onSingleLineFinish_()
			arg_609_1.onSingleLineUpdate_ = nil
			arg_609_1.onSingleLineFinish_ = nil
			arg_609_1.state_ = "waiting"
		end

		function arg_609_1.playNext_(arg_611_0)
			if arg_611_0 == 1 then
				arg_609_0:Play320061148(arg_609_1)
			end
		end

		function arg_609_1.onSingleLineUpdate_(arg_612_0)
			local var_612_0 = 0
			local var_612_1 = 0.175

			if var_612_0 < arg_609_1.time_ and arg_609_1.time_ <= var_612_0 + arg_612_0 then
				arg_609_1.talkMaxDuration = 0
				arg_609_1.dialogCg_.alpha = 1

				arg_609_1.dialog_:SetActive(true)
				SetActive(arg_609_1.leftNameGo_, true)

				local var_612_2 = arg_609_1:FormatText(StoryNameCfg[36].name)

				arg_609_1.leftNameTxt_.text = var_612_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_609_1.leftNameTxt_.transform)

				arg_609_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_609_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_609_1:RecordName(arg_609_1.leftNameTxt_.text)
				SetActive(arg_609_1.iconTrs_.gameObject, true)
				arg_609_1.iconController_:SetSelectedState("hero")

				arg_609_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1111_1")

				arg_609_1.callingController_:SetSelectedState("normal")

				arg_609_1.keyicon_.color = Color.New(1, 1, 1)
				arg_609_1.icon_.color = Color.New(1, 1, 1)

				local var_612_3 = arg_609_1:GetWordFromCfg(320061147)
				local var_612_4 = arg_609_1:FormatText(var_612_3.content)

				arg_609_1.text_.text = var_612_4

				LuaForUtil.ClearLinePrefixSymbol(arg_609_1.text_)

				local var_612_5 = 7
				local var_612_6 = utf8.len(var_612_4)
				local var_612_7 = var_612_5 <= 0 and var_612_1 or var_612_1 * (var_612_6 / var_612_5)

				if var_612_7 > 0 and var_612_1 < var_612_7 then
					arg_609_1.talkMaxDuration = var_612_7

					if var_612_7 + var_612_0 > arg_609_1.duration_ then
						arg_609_1.duration_ = var_612_7 + var_612_0
					end
				end

				arg_609_1.text_.text = var_612_4
				arg_609_1.typewritter.percent = 0

				arg_609_1.typewritter:SetDirty()
				arg_609_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320061", "320061147", "story_v_out_320061.awb") ~= 0 then
					local var_612_8 = manager.audio:GetVoiceLength("story_v_out_320061", "320061147", "story_v_out_320061.awb") / 1000

					if var_612_8 + var_612_0 > arg_609_1.duration_ then
						arg_609_1.duration_ = var_612_8 + var_612_0
					end

					if var_612_3.prefab_name ~= "" and arg_609_1.actors_[var_612_3.prefab_name] ~= nil then
						local var_612_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_609_1.actors_[var_612_3.prefab_name].transform, "story_v_out_320061", "320061147", "story_v_out_320061.awb")

						arg_609_1:RecordAudio("320061147", var_612_9)
						arg_609_1:RecordAudio("320061147", var_612_9)
					else
						arg_609_1:AudioAction("play", "voice", "story_v_out_320061", "320061147", "story_v_out_320061.awb")
					end

					arg_609_1:RecordHistoryTalkVoice("story_v_out_320061", "320061147", "story_v_out_320061.awb")
				end

				arg_609_1:RecordContent(arg_609_1.text_.text)
			end

			local var_612_10 = math.max(var_612_1, arg_609_1.talkMaxDuration)

			if var_612_0 <= arg_609_1.time_ and arg_609_1.time_ < var_612_0 + var_612_10 then
				arg_609_1.typewritter.percent = (arg_609_1.time_ - var_612_0) / var_612_10

				arg_609_1.typewritter:SetDirty()
			end

			if arg_609_1.time_ >= var_612_0 + var_612_10 and arg_609_1.time_ < var_612_0 + var_612_10 + arg_612_0 then
				arg_609_1.typewritter.percent = 1

				arg_609_1.typewritter:SetDirty()
				arg_609_1:ShowNextGo(true)
			end
		end

		arg_609_1.nodeConfigList_ = {}

		arg_609_1:InitPlayNodeList()
	end,
	Play320061148 = function(arg_613_0, arg_613_1)
		arg_613_1.time_ = 0
		arg_613_1.frameCnt_ = 0
		arg_613_1.state_ = "playing"
		arg_613_1.curTalkId_ = 320061148
		arg_613_1.duration_ = 5

		SetActive(arg_613_1.tipsGo_, false)

		function arg_613_1.onSingleLineFinish_()
			arg_613_1.onSingleLineUpdate_ = nil
			arg_613_1.onSingleLineFinish_ = nil
			arg_613_1.state_ = "waiting"
		end

		function arg_613_1.playNext_(arg_615_0)
			if arg_615_0 == 1 then
				arg_613_0:Play320061149(arg_613_1)
			end
		end

		function arg_613_1.onSingleLineUpdate_(arg_616_0)
			local var_616_0 = 0
			local var_616_1 = 0.125

			if var_616_0 < arg_613_1.time_ and arg_613_1.time_ <= var_616_0 + arg_616_0 then
				arg_613_1.talkMaxDuration = 0
				arg_613_1.dialogCg_.alpha = 1

				arg_613_1.dialog_:SetActive(true)
				SetActive(arg_613_1.leftNameGo_, true)

				local var_616_2 = arg_613_1:FormatText(StoryNameCfg[7].name)

				arg_613_1.leftNameTxt_.text = var_616_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_613_1.leftNameTxt_.transform)

				arg_613_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_613_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_613_1:RecordName(arg_613_1.leftNameTxt_.text)
				SetActive(arg_613_1.iconTrs_.gameObject, true)
				arg_613_1.iconController_:SetSelectedState("hero")

				arg_613_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_613_1.callingController_:SetSelectedState("normal")

				arg_613_1.keyicon_.color = Color.New(1, 1, 1)
				arg_613_1.icon_.color = Color.New(1, 1, 1)

				local var_616_3 = arg_613_1:GetWordFromCfg(320061148)
				local var_616_4 = arg_613_1:FormatText(var_616_3.content)

				arg_613_1.text_.text = var_616_4

				LuaForUtil.ClearLinePrefixSymbol(arg_613_1.text_)

				local var_616_5 = 5
				local var_616_6 = utf8.len(var_616_4)
				local var_616_7 = var_616_5 <= 0 and var_616_1 or var_616_1 * (var_616_6 / var_616_5)

				if var_616_7 > 0 and var_616_1 < var_616_7 then
					arg_613_1.talkMaxDuration = var_616_7

					if var_616_7 + var_616_0 > arg_613_1.duration_ then
						arg_613_1.duration_ = var_616_7 + var_616_0
					end
				end

				arg_613_1.text_.text = var_616_4
				arg_613_1.typewritter.percent = 0

				arg_613_1.typewritter:SetDirty()
				arg_613_1:ShowNextGo(false)
				arg_613_1:RecordContent(arg_613_1.text_.text)
			end

			local var_616_8 = math.max(var_616_1, arg_613_1.talkMaxDuration)

			if var_616_0 <= arg_613_1.time_ and arg_613_1.time_ < var_616_0 + var_616_8 then
				arg_613_1.typewritter.percent = (arg_613_1.time_ - var_616_0) / var_616_8

				arg_613_1.typewritter:SetDirty()
			end

			if arg_613_1.time_ >= var_616_0 + var_616_8 and arg_613_1.time_ < var_616_0 + var_616_8 + arg_616_0 then
				arg_613_1.typewritter.percent = 1

				arg_613_1.typewritter:SetDirty()
				arg_613_1:ShowNextGo(true)
			end
		end

		arg_613_1.nodeConfigList_ = {}

		arg_613_1:InitPlayNodeList()
	end,
	Play320061149 = function(arg_617_0, arg_617_1)
		arg_617_1.time_ = 0
		arg_617_1.frameCnt_ = 0
		arg_617_1.state_ = "playing"
		arg_617_1.curTalkId_ = 320061149
		arg_617_1.duration_ = 5

		SetActive(arg_617_1.tipsGo_, false)

		function arg_617_1.onSingleLineFinish_()
			arg_617_1.onSingleLineUpdate_ = nil
			arg_617_1.onSingleLineFinish_ = nil
			arg_617_1.state_ = "waiting"
		end

		function arg_617_1.playNext_(arg_619_0)
			if arg_619_0 == 1 then
				arg_617_0:Play320061150(arg_617_1)
			end
		end

		function arg_617_1.onSingleLineUpdate_(arg_620_0)
			local var_620_0 = 0
			local var_620_1 = 1.2

			if var_620_0 < arg_617_1.time_ and arg_617_1.time_ <= var_620_0 + arg_620_0 then
				arg_617_1.talkMaxDuration = 0
				arg_617_1.dialogCg_.alpha = 1

				arg_617_1.dialog_:SetActive(true)
				SetActive(arg_617_1.leftNameGo_, false)

				arg_617_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_617_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_617_1:RecordName(arg_617_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_617_1.iconTrs_.gameObject, false)
				arg_617_1.callingController_:SetSelectedState("normal")

				local var_620_2 = arg_617_1:GetWordFromCfg(320061149)
				local var_620_3 = arg_617_1:FormatText(var_620_2.content)

				arg_617_1.text_.text = var_620_3

				LuaForUtil.ClearLinePrefixSymbol(arg_617_1.text_)

				local var_620_4 = 48
				local var_620_5 = utf8.len(var_620_3)
				local var_620_6 = var_620_4 <= 0 and var_620_1 or var_620_1 * (var_620_5 / var_620_4)

				if var_620_6 > 0 and var_620_1 < var_620_6 then
					arg_617_1.talkMaxDuration = var_620_6

					if var_620_6 + var_620_0 > arg_617_1.duration_ then
						arg_617_1.duration_ = var_620_6 + var_620_0
					end
				end

				arg_617_1.text_.text = var_620_3
				arg_617_1.typewritter.percent = 0

				arg_617_1.typewritter:SetDirty()
				arg_617_1:ShowNextGo(false)
				arg_617_1:RecordContent(arg_617_1.text_.text)
			end

			local var_620_7 = math.max(var_620_1, arg_617_1.talkMaxDuration)

			if var_620_0 <= arg_617_1.time_ and arg_617_1.time_ < var_620_0 + var_620_7 then
				arg_617_1.typewritter.percent = (arg_617_1.time_ - var_620_0) / var_620_7

				arg_617_1.typewritter:SetDirty()
			end

			if arg_617_1.time_ >= var_620_0 + var_620_7 and arg_617_1.time_ < var_620_0 + var_620_7 + arg_620_0 then
				arg_617_1.typewritter.percent = 1

				arg_617_1.typewritter:SetDirty()
				arg_617_1:ShowNextGo(true)
			end
		end

		arg_617_1.nodeConfigList_ = {}

		arg_617_1:InitPlayNodeList()
	end,
	Play320061150 = function(arg_621_0, arg_621_1)
		arg_621_1.time_ = 0
		arg_621_1.frameCnt_ = 0
		arg_621_1.state_ = "playing"
		arg_621_1.curTalkId_ = 320061150
		arg_621_1.duration_ = 9.27

		local var_621_0 = {
			zh = 4.933,
			ja = 9.266
		}
		local var_621_1 = manager.audio:GetLocalizationFlag()

		if var_621_0[var_621_1] ~= nil then
			arg_621_1.duration_ = var_621_0[var_621_1]
		end

		SetActive(arg_621_1.tipsGo_, false)

		function arg_621_1.onSingleLineFinish_()
			arg_621_1.onSingleLineUpdate_ = nil
			arg_621_1.onSingleLineFinish_ = nil
			arg_621_1.state_ = "waiting"
		end

		function arg_621_1.playNext_(arg_623_0)
			if arg_623_0 == 1 then
				arg_621_0:Play320061151(arg_621_1)
			end
		end

		function arg_621_1.onSingleLineUpdate_(arg_624_0)
			local var_624_0 = arg_621_1.actors_["10100ui_story"].transform
			local var_624_1 = 0

			if var_624_1 < arg_621_1.time_ and arg_621_1.time_ <= var_624_1 + arg_624_0 then
				arg_621_1.var_.moveOldPos10100ui_story = var_624_0.localPosition
			end

			local var_624_2 = 0.001

			if var_624_1 <= arg_621_1.time_ and arg_621_1.time_ < var_624_1 + var_624_2 then
				local var_624_3 = (arg_621_1.time_ - var_624_1) / var_624_2
				local var_624_4 = Vector3.New(0, -1.16, -6.25)

				var_624_0.localPosition = Vector3.Lerp(arg_621_1.var_.moveOldPos10100ui_story, var_624_4, var_624_3)

				local var_624_5 = manager.ui.mainCamera.transform.position - var_624_0.position

				var_624_0.forward = Vector3.New(var_624_5.x, var_624_5.y, var_624_5.z)

				local var_624_6 = var_624_0.localEulerAngles

				var_624_6.z = 0
				var_624_6.x = 0
				var_624_0.localEulerAngles = var_624_6
			end

			if arg_621_1.time_ >= var_624_1 + var_624_2 and arg_621_1.time_ < var_624_1 + var_624_2 + arg_624_0 then
				var_624_0.localPosition = Vector3.New(0, -1.16, -6.25)

				local var_624_7 = manager.ui.mainCamera.transform.position - var_624_0.position

				var_624_0.forward = Vector3.New(var_624_7.x, var_624_7.y, var_624_7.z)

				local var_624_8 = var_624_0.localEulerAngles

				var_624_8.z = 0
				var_624_8.x = 0
				var_624_0.localEulerAngles = var_624_8
			end

			local var_624_9 = arg_621_1.actors_["10100ui_story"]
			local var_624_10 = 0

			if var_624_10 < arg_621_1.time_ and arg_621_1.time_ <= var_624_10 + arg_624_0 and not isNil(var_624_9) and arg_621_1.var_.characterEffect10100ui_story == nil then
				arg_621_1.var_.characterEffect10100ui_story = var_624_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_624_11 = 0.200000002980232

			if var_624_10 <= arg_621_1.time_ and arg_621_1.time_ < var_624_10 + var_624_11 and not isNil(var_624_9) then
				local var_624_12 = (arg_621_1.time_ - var_624_10) / var_624_11

				if arg_621_1.var_.characterEffect10100ui_story and not isNil(var_624_9) then
					arg_621_1.var_.characterEffect10100ui_story.fillFlat = false
				end
			end

			if arg_621_1.time_ >= var_624_10 + var_624_11 and arg_621_1.time_ < var_624_10 + var_624_11 + arg_624_0 and not isNil(var_624_9) and arg_621_1.var_.characterEffect10100ui_story then
				arg_621_1.var_.characterEffect10100ui_story.fillFlat = false
			end

			local var_624_13 = 0

			if var_624_13 < arg_621_1.time_ and arg_621_1.time_ <= var_624_13 + arg_624_0 then
				arg_621_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action1_1")
			end

			local var_624_14 = 0

			if var_624_14 < arg_621_1.time_ and arg_621_1.time_ <= var_624_14 + arg_624_0 then
				arg_621_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_624_15 = 0
			local var_624_16 = 0.6

			if var_624_15 < arg_621_1.time_ and arg_621_1.time_ <= var_624_15 + arg_624_0 then
				arg_621_1.talkMaxDuration = 0
				arg_621_1.dialogCg_.alpha = 1

				arg_621_1.dialog_:SetActive(true)
				SetActive(arg_621_1.leftNameGo_, true)

				local var_624_17 = arg_621_1:FormatText(StoryNameCfg[1021].name)

				arg_621_1.leftNameTxt_.text = var_624_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_621_1.leftNameTxt_.transform)

				arg_621_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_621_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_621_1:RecordName(arg_621_1.leftNameTxt_.text)
				SetActive(arg_621_1.iconTrs_.gameObject, false)
				arg_621_1.callingController_:SetSelectedState("normal")

				local var_624_18 = arg_621_1:GetWordFromCfg(320061150)
				local var_624_19 = arg_621_1:FormatText(var_624_18.content)

				arg_621_1.text_.text = var_624_19

				LuaForUtil.ClearLinePrefixSymbol(arg_621_1.text_)

				local var_624_20 = 24
				local var_624_21 = utf8.len(var_624_19)
				local var_624_22 = var_624_20 <= 0 and var_624_16 or var_624_16 * (var_624_21 / var_624_20)

				if var_624_22 > 0 and var_624_16 < var_624_22 then
					arg_621_1.talkMaxDuration = var_624_22

					if var_624_22 + var_624_15 > arg_621_1.duration_ then
						arg_621_1.duration_ = var_624_22 + var_624_15
					end
				end

				arg_621_1.text_.text = var_624_19
				arg_621_1.typewritter.percent = 0

				arg_621_1.typewritter:SetDirty()
				arg_621_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320061", "320061150", "story_v_out_320061.awb") ~= 0 then
					local var_624_23 = manager.audio:GetVoiceLength("story_v_out_320061", "320061150", "story_v_out_320061.awb") / 1000

					if var_624_23 + var_624_15 > arg_621_1.duration_ then
						arg_621_1.duration_ = var_624_23 + var_624_15
					end

					if var_624_18.prefab_name ~= "" and arg_621_1.actors_[var_624_18.prefab_name] ~= nil then
						local var_624_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_621_1.actors_[var_624_18.prefab_name].transform, "story_v_out_320061", "320061150", "story_v_out_320061.awb")

						arg_621_1:RecordAudio("320061150", var_624_24)
						arg_621_1:RecordAudio("320061150", var_624_24)
					else
						arg_621_1:AudioAction("play", "voice", "story_v_out_320061", "320061150", "story_v_out_320061.awb")
					end

					arg_621_1:RecordHistoryTalkVoice("story_v_out_320061", "320061150", "story_v_out_320061.awb")
				end

				arg_621_1:RecordContent(arg_621_1.text_.text)
			end

			local var_624_25 = math.max(var_624_16, arg_621_1.talkMaxDuration)

			if var_624_15 <= arg_621_1.time_ and arg_621_1.time_ < var_624_15 + var_624_25 then
				arg_621_1.typewritter.percent = (arg_621_1.time_ - var_624_15) / var_624_25

				arg_621_1.typewritter:SetDirty()
			end

			if arg_621_1.time_ >= var_624_15 + var_624_25 and arg_621_1.time_ < var_624_15 + var_624_25 + arg_624_0 then
				arg_621_1.typewritter.percent = 1

				arg_621_1.typewritter:SetDirty()
				arg_621_1:ShowNextGo(true)
			end
		end

		arg_621_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10100ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_621_1:InitPlayNodeList()
	end,
	Play320061151 = function(arg_625_0, arg_625_1)
		arg_625_1.time_ = 0
		arg_625_1.frameCnt_ = 0
		arg_625_1.state_ = "playing"
		arg_625_1.curTalkId_ = 320061151
		arg_625_1.duration_ = 5.23

		local var_625_0 = {
			zh = 5.233,
			ja = 4.766
		}
		local var_625_1 = manager.audio:GetLocalizationFlag()

		if var_625_0[var_625_1] ~= nil then
			arg_625_1.duration_ = var_625_0[var_625_1]
		end

		SetActive(arg_625_1.tipsGo_, false)

		function arg_625_1.onSingleLineFinish_()
			arg_625_1.onSingleLineUpdate_ = nil
			arg_625_1.onSingleLineFinish_ = nil
			arg_625_1.state_ = "waiting"
		end

		function arg_625_1.playNext_(arg_627_0)
			if arg_627_0 == 1 then
				arg_625_0:Play320061152(arg_625_1)
			end
		end

		function arg_625_1.onSingleLineUpdate_(arg_628_0)
			local var_628_0 = "1111ui_story"

			if arg_625_1.actors_[var_628_0] == nil then
				local var_628_1 = Asset.Load("Char/" .. "1111ui_story")

				if not isNil(var_628_1) then
					local var_628_2 = Object.Instantiate(Asset.Load("Char/" .. "1111ui_story"), arg_625_1.stage_.transform)

					var_628_2.name = var_628_0
					var_628_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_625_1.actors_[var_628_0] = var_628_2

					local var_628_3 = var_628_2:GetComponentInChildren(typeof(CharacterEffect))

					var_628_3.enabled = true

					local var_628_4 = GameObjectTools.GetOrAddComponent(var_628_2, typeof(DynamicBoneHelper))

					if var_628_4 then
						var_628_4:EnableDynamicBone(false)
					end

					arg_625_1:ShowWeapon(var_628_3.transform, false)

					arg_625_1.var_[var_628_0 .. "Animator"] = var_628_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_625_1.var_[var_628_0 .. "Animator"].applyRootMotion = true
					arg_625_1.var_[var_628_0 .. "LipSync"] = var_628_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_628_5 = arg_625_1.actors_["1111ui_story"].transform
			local var_628_6 = 0

			if var_628_6 < arg_625_1.time_ and arg_625_1.time_ <= var_628_6 + arg_628_0 then
				arg_625_1.var_.moveOldPos1111ui_story = var_628_5.localPosition
			end

			local var_628_7 = 0.001

			if var_628_6 <= arg_625_1.time_ and arg_625_1.time_ < var_628_6 + var_628_7 then
				local var_628_8 = (arg_625_1.time_ - var_628_6) / var_628_7
				local var_628_9 = Vector3.New(0, -0.87, -5.7)

				var_628_5.localPosition = Vector3.Lerp(arg_625_1.var_.moveOldPos1111ui_story, var_628_9, var_628_8)

				local var_628_10 = manager.ui.mainCamera.transform.position - var_628_5.position

				var_628_5.forward = Vector3.New(var_628_10.x, var_628_10.y, var_628_10.z)

				local var_628_11 = var_628_5.localEulerAngles

				var_628_11.z = 0
				var_628_11.x = 0
				var_628_5.localEulerAngles = var_628_11
			end

			if arg_625_1.time_ >= var_628_6 + var_628_7 and arg_625_1.time_ < var_628_6 + var_628_7 + arg_628_0 then
				var_628_5.localPosition = Vector3.New(0, -0.87, -5.7)

				local var_628_12 = manager.ui.mainCamera.transform.position - var_628_5.position

				var_628_5.forward = Vector3.New(var_628_12.x, var_628_12.y, var_628_12.z)

				local var_628_13 = var_628_5.localEulerAngles

				var_628_13.z = 0
				var_628_13.x = 0
				var_628_5.localEulerAngles = var_628_13
			end

			local var_628_14 = arg_625_1.actors_["1111ui_story"]
			local var_628_15 = 0

			if var_628_15 < arg_625_1.time_ and arg_625_1.time_ <= var_628_15 + arg_628_0 and not isNil(var_628_14) and arg_625_1.var_.characterEffect1111ui_story == nil then
				arg_625_1.var_.characterEffect1111ui_story = var_628_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_628_16 = 0.200000002980232

			if var_628_15 <= arg_625_1.time_ and arg_625_1.time_ < var_628_15 + var_628_16 and not isNil(var_628_14) then
				local var_628_17 = (arg_625_1.time_ - var_628_15) / var_628_16

				if arg_625_1.var_.characterEffect1111ui_story and not isNil(var_628_14) then
					arg_625_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_625_1.time_ >= var_628_15 + var_628_16 and arg_625_1.time_ < var_628_15 + var_628_16 + arg_628_0 and not isNil(var_628_14) and arg_625_1.var_.characterEffect1111ui_story then
				arg_625_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_628_18 = 0

			if var_628_18 < arg_625_1.time_ and arg_625_1.time_ <= var_628_18 + arg_628_0 then
				arg_625_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action6_1")
			end

			local var_628_19 = 0

			if var_628_19 < arg_625_1.time_ and arg_625_1.time_ <= var_628_19 + arg_628_0 then
				arg_625_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_628_20 = arg_625_1.actors_["10100ui_story"].transform
			local var_628_21 = 0

			if var_628_21 < arg_625_1.time_ and arg_625_1.time_ <= var_628_21 + arg_628_0 then
				arg_625_1.var_.moveOldPos10100ui_story = var_628_20.localPosition
			end

			local var_628_22 = 0.001

			if var_628_21 <= arg_625_1.time_ and arg_625_1.time_ < var_628_21 + var_628_22 then
				local var_628_23 = (arg_625_1.time_ - var_628_21) / var_628_22
				local var_628_24 = Vector3.New(0, 100, 0)

				var_628_20.localPosition = Vector3.Lerp(arg_625_1.var_.moveOldPos10100ui_story, var_628_24, var_628_23)

				local var_628_25 = manager.ui.mainCamera.transform.position - var_628_20.position

				var_628_20.forward = Vector3.New(var_628_25.x, var_628_25.y, var_628_25.z)

				local var_628_26 = var_628_20.localEulerAngles

				var_628_26.z = 0
				var_628_26.x = 0
				var_628_20.localEulerAngles = var_628_26
			end

			if arg_625_1.time_ >= var_628_21 + var_628_22 and arg_625_1.time_ < var_628_21 + var_628_22 + arg_628_0 then
				var_628_20.localPosition = Vector3.New(0, 100, 0)

				local var_628_27 = manager.ui.mainCamera.transform.position - var_628_20.position

				var_628_20.forward = Vector3.New(var_628_27.x, var_628_27.y, var_628_27.z)

				local var_628_28 = var_628_20.localEulerAngles

				var_628_28.z = 0
				var_628_28.x = 0
				var_628_20.localEulerAngles = var_628_28
			end

			local var_628_29 = arg_625_1.actors_["10100ui_story"]
			local var_628_30 = 0

			if var_628_30 < arg_625_1.time_ and arg_625_1.time_ <= var_628_30 + arg_628_0 and not isNil(var_628_29) and arg_625_1.var_.characterEffect10100ui_story == nil then
				arg_625_1.var_.characterEffect10100ui_story = var_628_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_628_31 = 0.200000002980232

			if var_628_30 <= arg_625_1.time_ and arg_625_1.time_ < var_628_30 + var_628_31 and not isNil(var_628_29) then
				local var_628_32 = (arg_625_1.time_ - var_628_30) / var_628_31

				if arg_625_1.var_.characterEffect10100ui_story and not isNil(var_628_29) then
					local var_628_33 = Mathf.Lerp(0, 0.5, var_628_32)

					arg_625_1.var_.characterEffect10100ui_story.fillFlat = true
					arg_625_1.var_.characterEffect10100ui_story.fillRatio = var_628_33
				end
			end

			if arg_625_1.time_ >= var_628_30 + var_628_31 and arg_625_1.time_ < var_628_30 + var_628_31 + arg_628_0 and not isNil(var_628_29) and arg_625_1.var_.characterEffect10100ui_story then
				local var_628_34 = 0.5

				arg_625_1.var_.characterEffect10100ui_story.fillFlat = true
				arg_625_1.var_.characterEffect10100ui_story.fillRatio = var_628_34
			end

			local var_628_35 = 0
			local var_628_36 = 0.325

			if var_628_35 < arg_625_1.time_ and arg_625_1.time_ <= var_628_35 + arg_628_0 then
				arg_625_1.talkMaxDuration = 0
				arg_625_1.dialogCg_.alpha = 1

				arg_625_1.dialog_:SetActive(true)
				SetActive(arg_625_1.leftNameGo_, true)

				local var_628_37 = arg_625_1:FormatText(StoryNameCfg[67].name)

				arg_625_1.leftNameTxt_.text = var_628_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_625_1.leftNameTxt_.transform)

				arg_625_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_625_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_625_1:RecordName(arg_625_1.leftNameTxt_.text)
				SetActive(arg_625_1.iconTrs_.gameObject, false)
				arg_625_1.callingController_:SetSelectedState("normal")

				local var_628_38 = arg_625_1:GetWordFromCfg(320061151)
				local var_628_39 = arg_625_1:FormatText(var_628_38.content)

				arg_625_1.text_.text = var_628_39

				LuaForUtil.ClearLinePrefixSymbol(arg_625_1.text_)

				local var_628_40 = 13
				local var_628_41 = utf8.len(var_628_39)
				local var_628_42 = var_628_40 <= 0 and var_628_36 or var_628_36 * (var_628_41 / var_628_40)

				if var_628_42 > 0 and var_628_36 < var_628_42 then
					arg_625_1.talkMaxDuration = var_628_42

					if var_628_42 + var_628_35 > arg_625_1.duration_ then
						arg_625_1.duration_ = var_628_42 + var_628_35
					end
				end

				arg_625_1.text_.text = var_628_39
				arg_625_1.typewritter.percent = 0

				arg_625_1.typewritter:SetDirty()
				arg_625_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320061", "320061151", "story_v_out_320061.awb") ~= 0 then
					local var_628_43 = manager.audio:GetVoiceLength("story_v_out_320061", "320061151", "story_v_out_320061.awb") / 1000

					if var_628_43 + var_628_35 > arg_625_1.duration_ then
						arg_625_1.duration_ = var_628_43 + var_628_35
					end

					if var_628_38.prefab_name ~= "" and arg_625_1.actors_[var_628_38.prefab_name] ~= nil then
						local var_628_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_625_1.actors_[var_628_38.prefab_name].transform, "story_v_out_320061", "320061151", "story_v_out_320061.awb")

						arg_625_1:RecordAudio("320061151", var_628_44)
						arg_625_1:RecordAudio("320061151", var_628_44)
					else
						arg_625_1:AudioAction("play", "voice", "story_v_out_320061", "320061151", "story_v_out_320061.awb")
					end

					arg_625_1:RecordHistoryTalkVoice("story_v_out_320061", "320061151", "story_v_out_320061.awb")
				end

				arg_625_1:RecordContent(arg_625_1.text_.text)
			end

			local var_628_45 = math.max(var_628_36, arg_625_1.talkMaxDuration)

			if var_628_35 <= arg_625_1.time_ and arg_625_1.time_ < var_628_35 + var_628_45 then
				arg_625_1.typewritter.percent = (arg_625_1.time_ - var_628_35) / var_628_45

				arg_625_1.typewritter:SetDirty()
			end

			if arg_625_1.time_ >= var_628_35 + var_628_45 and arg_625_1.time_ < var_628_35 + var_628_45 + arg_628_0 then
				arg_625_1.typewritter.percent = 1

				arg_625_1.typewritter:SetDirty()
				arg_625_1:ShowNextGo(true)
			end
		end

		arg_625_1.nodeConfigList_ = {
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
				actorName = "10100ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_625_1:InitPlayNodeList()
	end,
	Play320061152 = function(arg_629_0, arg_629_1)
		arg_629_1.time_ = 0
		arg_629_1.frameCnt_ = 0
		arg_629_1.state_ = "playing"
		arg_629_1.curTalkId_ = 320061152
		arg_629_1.duration_ = 5

		SetActive(arg_629_1.tipsGo_, false)

		function arg_629_1.onSingleLineFinish_()
			arg_629_1.onSingleLineUpdate_ = nil
			arg_629_1.onSingleLineFinish_ = nil
			arg_629_1.state_ = "waiting"
		end

		function arg_629_1.playNext_(arg_631_0)
			if arg_631_0 == 1 then
				arg_629_0:Play320061153(arg_629_1)
			end
		end

		function arg_629_1.onSingleLineUpdate_(arg_632_0)
			local var_632_0 = arg_629_1.actors_["1111ui_story"]
			local var_632_1 = 0

			if var_632_1 < arg_629_1.time_ and arg_629_1.time_ <= var_632_1 + arg_632_0 and not isNil(var_632_0) and arg_629_1.var_.characterEffect1111ui_story == nil then
				arg_629_1.var_.characterEffect1111ui_story = var_632_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_632_2 = 0.200000002980232

			if var_632_1 <= arg_629_1.time_ and arg_629_1.time_ < var_632_1 + var_632_2 and not isNil(var_632_0) then
				local var_632_3 = (arg_629_1.time_ - var_632_1) / var_632_2

				if arg_629_1.var_.characterEffect1111ui_story and not isNil(var_632_0) then
					local var_632_4 = Mathf.Lerp(0, 0.5, var_632_3)

					arg_629_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_629_1.var_.characterEffect1111ui_story.fillRatio = var_632_4
				end
			end

			if arg_629_1.time_ >= var_632_1 + var_632_2 and arg_629_1.time_ < var_632_1 + var_632_2 + arg_632_0 and not isNil(var_632_0) and arg_629_1.var_.characterEffect1111ui_story then
				local var_632_5 = 0.5

				arg_629_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_629_1.var_.characterEffect1111ui_story.fillRatio = var_632_5
			end

			local var_632_6 = 0
			local var_632_7 = 0.25

			if var_632_6 < arg_629_1.time_ and arg_629_1.time_ <= var_632_6 + arg_632_0 then
				arg_629_1.talkMaxDuration = 0
				arg_629_1.dialogCg_.alpha = 1

				arg_629_1.dialog_:SetActive(true)
				SetActive(arg_629_1.leftNameGo_, true)

				local var_632_8 = arg_629_1:FormatText(StoryNameCfg[7].name)

				arg_629_1.leftNameTxt_.text = var_632_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_629_1.leftNameTxt_.transform)

				arg_629_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_629_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_629_1:RecordName(arg_629_1.leftNameTxt_.text)
				SetActive(arg_629_1.iconTrs_.gameObject, true)
				arg_629_1.iconController_:SetSelectedState("hero")

				arg_629_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_629_1.callingController_:SetSelectedState("normal")

				arg_629_1.keyicon_.color = Color.New(1, 1, 1)
				arg_629_1.icon_.color = Color.New(1, 1, 1)

				local var_632_9 = arg_629_1:GetWordFromCfg(320061152)
				local var_632_10 = arg_629_1:FormatText(var_632_9.content)

				arg_629_1.text_.text = var_632_10

				LuaForUtil.ClearLinePrefixSymbol(arg_629_1.text_)

				local var_632_11 = 10
				local var_632_12 = utf8.len(var_632_10)
				local var_632_13 = var_632_11 <= 0 and var_632_7 or var_632_7 * (var_632_12 / var_632_11)

				if var_632_13 > 0 and var_632_7 < var_632_13 then
					arg_629_1.talkMaxDuration = var_632_13

					if var_632_13 + var_632_6 > arg_629_1.duration_ then
						arg_629_1.duration_ = var_632_13 + var_632_6
					end
				end

				arg_629_1.text_.text = var_632_10
				arg_629_1.typewritter.percent = 0

				arg_629_1.typewritter:SetDirty()
				arg_629_1:ShowNextGo(false)
				arg_629_1:RecordContent(arg_629_1.text_.text)
			end

			local var_632_14 = math.max(var_632_7, arg_629_1.talkMaxDuration)

			if var_632_6 <= arg_629_1.time_ and arg_629_1.time_ < var_632_6 + var_632_14 then
				arg_629_1.typewritter.percent = (arg_629_1.time_ - var_632_6) / var_632_14

				arg_629_1.typewritter:SetDirty()
			end

			if arg_629_1.time_ >= var_632_6 + var_632_14 and arg_629_1.time_ < var_632_6 + var_632_14 + arg_632_0 then
				arg_629_1.typewritter.percent = 1

				arg_629_1.typewritter:SetDirty()
				arg_629_1:ShowNextGo(true)
			end
		end

		arg_629_1.nodeConfigList_ = {}

		arg_629_1:InitPlayNodeList()
	end,
	Play320061153 = function(arg_633_0, arg_633_1)
		arg_633_1.time_ = 0
		arg_633_1.frameCnt_ = 0
		arg_633_1.state_ = "playing"
		arg_633_1.curTalkId_ = 320061153
		arg_633_1.duration_ = 4.77

		local var_633_0 = {
			zh = 4.033,
			ja = 4.766
		}
		local var_633_1 = manager.audio:GetLocalizationFlag()

		if var_633_0[var_633_1] ~= nil then
			arg_633_1.duration_ = var_633_0[var_633_1]
		end

		SetActive(arg_633_1.tipsGo_, false)

		function arg_633_1.onSingleLineFinish_()
			arg_633_1.onSingleLineUpdate_ = nil
			arg_633_1.onSingleLineFinish_ = nil
			arg_633_1.state_ = "waiting"
		end

		function arg_633_1.playNext_(arg_635_0)
			if arg_635_0 == 1 then
				arg_633_0:Play320061154(arg_633_1)
			end
		end

		function arg_633_1.onSingleLineUpdate_(arg_636_0)
			local var_636_0 = arg_633_1.actors_["1111ui_story"].transform
			local var_636_1 = 0

			if var_636_1 < arg_633_1.time_ and arg_633_1.time_ <= var_636_1 + arg_636_0 then
				arg_633_1.var_.moveOldPos1111ui_story = var_636_0.localPosition
			end

			local var_636_2 = 0.001

			if var_636_1 <= arg_633_1.time_ and arg_633_1.time_ < var_636_1 + var_636_2 then
				local var_636_3 = (arg_633_1.time_ - var_636_1) / var_636_2
				local var_636_4 = Vector3.New(0, -0.87, -5.7)

				var_636_0.localPosition = Vector3.Lerp(arg_633_1.var_.moveOldPos1111ui_story, var_636_4, var_636_3)

				local var_636_5 = manager.ui.mainCamera.transform.position - var_636_0.position

				var_636_0.forward = Vector3.New(var_636_5.x, var_636_5.y, var_636_5.z)

				local var_636_6 = var_636_0.localEulerAngles

				var_636_6.z = 0
				var_636_6.x = 0
				var_636_0.localEulerAngles = var_636_6
			end

			if arg_633_1.time_ >= var_636_1 + var_636_2 and arg_633_1.time_ < var_636_1 + var_636_2 + arg_636_0 then
				var_636_0.localPosition = Vector3.New(0, -0.87, -5.7)

				local var_636_7 = manager.ui.mainCamera.transform.position - var_636_0.position

				var_636_0.forward = Vector3.New(var_636_7.x, var_636_7.y, var_636_7.z)

				local var_636_8 = var_636_0.localEulerAngles

				var_636_8.z = 0
				var_636_8.x = 0
				var_636_0.localEulerAngles = var_636_8
			end

			local var_636_9 = arg_633_1.actors_["1111ui_story"]
			local var_636_10 = 0

			if var_636_10 < arg_633_1.time_ and arg_633_1.time_ <= var_636_10 + arg_636_0 and not isNil(var_636_9) and arg_633_1.var_.characterEffect1111ui_story == nil then
				arg_633_1.var_.characterEffect1111ui_story = var_636_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_636_11 = 0.200000002980232

			if var_636_10 <= arg_633_1.time_ and arg_633_1.time_ < var_636_10 + var_636_11 and not isNil(var_636_9) then
				local var_636_12 = (arg_633_1.time_ - var_636_10) / var_636_11

				if arg_633_1.var_.characterEffect1111ui_story and not isNil(var_636_9) then
					arg_633_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_633_1.time_ >= var_636_10 + var_636_11 and arg_633_1.time_ < var_636_10 + var_636_11 + arg_636_0 and not isNil(var_636_9) and arg_633_1.var_.characterEffect1111ui_story then
				arg_633_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_636_13 = 0

			if var_636_13 < arg_633_1.time_ and arg_633_1.time_ <= var_636_13 + arg_636_0 then
				arg_633_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action6_2")
			end

			local var_636_14 = 0

			if var_636_14 < arg_633_1.time_ and arg_633_1.time_ <= var_636_14 + arg_636_0 then
				arg_633_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_636_15 = 0
			local var_636_16 = 0.425

			if var_636_15 < arg_633_1.time_ and arg_633_1.time_ <= var_636_15 + arg_636_0 then
				arg_633_1.talkMaxDuration = 0
				arg_633_1.dialogCg_.alpha = 1

				arg_633_1.dialog_:SetActive(true)
				SetActive(arg_633_1.leftNameGo_, true)

				local var_636_17 = arg_633_1:FormatText(StoryNameCfg[67].name)

				arg_633_1.leftNameTxt_.text = var_636_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_633_1.leftNameTxt_.transform)

				arg_633_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_633_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_633_1:RecordName(arg_633_1.leftNameTxt_.text)
				SetActive(arg_633_1.iconTrs_.gameObject, false)
				arg_633_1.callingController_:SetSelectedState("normal")

				local var_636_18 = arg_633_1:GetWordFromCfg(320061153)
				local var_636_19 = arg_633_1:FormatText(var_636_18.content)

				arg_633_1.text_.text = var_636_19

				LuaForUtil.ClearLinePrefixSymbol(arg_633_1.text_)

				local var_636_20 = 17
				local var_636_21 = utf8.len(var_636_19)
				local var_636_22 = var_636_20 <= 0 and var_636_16 or var_636_16 * (var_636_21 / var_636_20)

				if var_636_22 > 0 and var_636_16 < var_636_22 then
					arg_633_1.talkMaxDuration = var_636_22

					if var_636_22 + var_636_15 > arg_633_1.duration_ then
						arg_633_1.duration_ = var_636_22 + var_636_15
					end
				end

				arg_633_1.text_.text = var_636_19
				arg_633_1.typewritter.percent = 0

				arg_633_1.typewritter:SetDirty()
				arg_633_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320061", "320061153", "story_v_out_320061.awb") ~= 0 then
					local var_636_23 = manager.audio:GetVoiceLength("story_v_out_320061", "320061153", "story_v_out_320061.awb") / 1000

					if var_636_23 + var_636_15 > arg_633_1.duration_ then
						arg_633_1.duration_ = var_636_23 + var_636_15
					end

					if var_636_18.prefab_name ~= "" and arg_633_1.actors_[var_636_18.prefab_name] ~= nil then
						local var_636_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_633_1.actors_[var_636_18.prefab_name].transform, "story_v_out_320061", "320061153", "story_v_out_320061.awb")

						arg_633_1:RecordAudio("320061153", var_636_24)
						arg_633_1:RecordAudio("320061153", var_636_24)
					else
						arg_633_1:AudioAction("play", "voice", "story_v_out_320061", "320061153", "story_v_out_320061.awb")
					end

					arg_633_1:RecordHistoryTalkVoice("story_v_out_320061", "320061153", "story_v_out_320061.awb")
				end

				arg_633_1:RecordContent(arg_633_1.text_.text)
			end

			local var_636_25 = math.max(var_636_16, arg_633_1.talkMaxDuration)

			if var_636_15 <= arg_633_1.time_ and arg_633_1.time_ < var_636_15 + var_636_25 then
				arg_633_1.typewritter.percent = (arg_633_1.time_ - var_636_15) / var_636_25

				arg_633_1.typewritter:SetDirty()
			end

			if arg_633_1.time_ >= var_636_15 + var_636_25 and arg_633_1.time_ < var_636_15 + var_636_25 + arg_636_0 then
				arg_633_1.typewritter.percent = 1

				arg_633_1.typewritter:SetDirty()
				arg_633_1:ShowNextGo(true)
			end
		end

		arg_633_1.nodeConfigList_ = {
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

		arg_633_1:InitPlayNodeList()
	end,
	Play320061154 = function(arg_637_0, arg_637_1)
		arg_637_1.time_ = 0
		arg_637_1.frameCnt_ = 0
		arg_637_1.state_ = "playing"
		arg_637_1.curTalkId_ = 320061154
		arg_637_1.duration_ = 5.9

		SetActive(arg_637_1.tipsGo_, false)

		function arg_637_1.onSingleLineFinish_()
			arg_637_1.onSingleLineUpdate_ = nil
			arg_637_1.onSingleLineFinish_ = nil
			arg_637_1.state_ = "waiting"
		end

		function arg_637_1.playNext_(arg_639_0)
			if arg_639_0 == 1 then
				arg_637_0:Play320061155(arg_637_1)
			end
		end

		function arg_637_1.onSingleLineUpdate_(arg_640_0)
			local var_640_0 = arg_637_1.actors_["1111ui_story"].transform
			local var_640_1 = 0

			if var_640_1 < arg_637_1.time_ and arg_637_1.time_ <= var_640_1 + arg_640_0 then
				arg_637_1.var_.moveOldPos1111ui_story = var_640_0.localPosition
			end

			local var_640_2 = 0.001

			if var_640_1 <= arg_637_1.time_ and arg_637_1.time_ < var_640_1 + var_640_2 then
				local var_640_3 = (arg_637_1.time_ - var_640_1) / var_640_2
				local var_640_4 = Vector3.New(0, 100, 0)

				var_640_0.localPosition = Vector3.Lerp(arg_637_1.var_.moveOldPos1111ui_story, var_640_4, var_640_3)

				local var_640_5 = manager.ui.mainCamera.transform.position - var_640_0.position

				var_640_0.forward = Vector3.New(var_640_5.x, var_640_5.y, var_640_5.z)

				local var_640_6 = var_640_0.localEulerAngles

				var_640_6.z = 0
				var_640_6.x = 0
				var_640_0.localEulerAngles = var_640_6
			end

			if arg_637_1.time_ >= var_640_1 + var_640_2 and arg_637_1.time_ < var_640_1 + var_640_2 + arg_640_0 then
				var_640_0.localPosition = Vector3.New(0, 100, 0)

				local var_640_7 = manager.ui.mainCamera.transform.position - var_640_0.position

				var_640_0.forward = Vector3.New(var_640_7.x, var_640_7.y, var_640_7.z)

				local var_640_8 = var_640_0.localEulerAngles

				var_640_8.z = 0
				var_640_8.x = 0
				var_640_0.localEulerAngles = var_640_8
			end

			local var_640_9 = arg_637_1.actors_["1111ui_story"]
			local var_640_10 = 0

			if var_640_10 < arg_637_1.time_ and arg_637_1.time_ <= var_640_10 + arg_640_0 and not isNil(var_640_9) and arg_637_1.var_.characterEffect1111ui_story == nil then
				arg_637_1.var_.characterEffect1111ui_story = var_640_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_640_11 = 0.200000002980232

			if var_640_10 <= arg_637_1.time_ and arg_637_1.time_ < var_640_10 + var_640_11 and not isNil(var_640_9) then
				local var_640_12 = (arg_637_1.time_ - var_640_10) / var_640_11

				if arg_637_1.var_.characterEffect1111ui_story and not isNil(var_640_9) then
					local var_640_13 = Mathf.Lerp(0, 0.5, var_640_12)

					arg_637_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_637_1.var_.characterEffect1111ui_story.fillRatio = var_640_13
				end
			end

			if arg_637_1.time_ >= var_640_10 + var_640_11 and arg_637_1.time_ < var_640_10 + var_640_11 + arg_640_0 and not isNil(var_640_9) and arg_637_1.var_.characterEffect1111ui_story then
				local var_640_14 = 0.5

				arg_637_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_637_1.var_.characterEffect1111ui_story.fillRatio = var_640_14
			end

			local var_640_15 = manager.ui.mainCamera.transform
			local var_640_16 = 0

			if var_640_16 < arg_637_1.time_ and arg_637_1.time_ <= var_640_16 + arg_640_0 then
				local var_640_17 = arg_637_1.var_.effectyiyang1
				local var_640_18
				local var_640_19 = var_640_15

				if not var_640_17 then
					var_640_17 = Object.Instantiate(Asset.Load("Effect/Scene/fx_scence_pingmu_niuqu"), var_640_19)
					var_640_17.name = "yiyang1"
					arg_637_1.var_.effectyiyang1 = var_640_17
				else
					var_640_17.transform:SetParent(var_640_19)
				end

				var_640_17.transform.localPosition = Vector3.New(0, 0, 0)
				var_640_17.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_640_20 = manager.ui.mainCamera.transform
			local var_640_21 = 0.6

			if var_640_21 < arg_637_1.time_ and arg_637_1.time_ <= var_640_21 + arg_640_0 then
				local var_640_22 = arg_637_1.var_.effectyiyang1

				if var_640_22 then
					Object.Destroy(var_640_22)

					arg_637_1.var_.effectyiyang1 = nil
				end
			end

			local var_640_23 = 0

			if var_640_23 < arg_637_1.time_ and arg_637_1.time_ <= var_640_23 + arg_640_0 then
				arg_637_1.allBtn_.enabled = false
			end

			local var_640_24 = 0.9

			if arg_637_1.time_ >= var_640_23 + var_640_24 and arg_637_1.time_ < var_640_23 + var_640_24 + arg_640_0 then
				arg_637_1.allBtn_.enabled = true
			end

			if arg_637_1.frameCnt_ <= 1 then
				arg_637_1.dialog_:SetActive(false)
			end

			local var_640_25 = 0.9
			local var_640_26 = 1.025

			if var_640_25 < arg_637_1.time_ and arg_637_1.time_ <= var_640_25 + arg_640_0 then
				arg_637_1.talkMaxDuration = 0

				arg_637_1.dialog_:SetActive(true)

				arg_637_1.dialogCg_.alpha = 0

				local var_640_27 = LeanTween.value(arg_637_1.dialog_, 0, 1, 0.3)

				var_640_27:setOnUpdate(LuaHelper.FloatAction(function(arg_641_0)
					arg_637_1.dialogCg_.alpha = arg_641_0
				end))
				var_640_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_637_1.dialog_)
					var_640_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_637_1.duration_ = arg_637_1.duration_ + 0.3

				SetActive(arg_637_1.leftNameGo_, false)

				arg_637_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_637_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_637_1:RecordName(arg_637_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_637_1.iconTrs_.gameObject, false)
				arg_637_1.callingController_:SetSelectedState("normal")

				local var_640_28 = arg_637_1:GetWordFromCfg(320061154)
				local var_640_29 = arg_637_1:FormatText(var_640_28.content)

				arg_637_1.text_.text = var_640_29

				LuaForUtil.ClearLinePrefixSymbol(arg_637_1.text_)

				local var_640_30 = 41
				local var_640_31 = utf8.len(var_640_29)
				local var_640_32 = var_640_30 <= 0 and var_640_26 or var_640_26 * (var_640_31 / var_640_30)

				if var_640_32 > 0 and var_640_26 < var_640_32 then
					arg_637_1.talkMaxDuration = var_640_32
					var_640_25 = var_640_25 + 0.3

					if var_640_32 + var_640_25 > arg_637_1.duration_ then
						arg_637_1.duration_ = var_640_32 + var_640_25
					end
				end

				arg_637_1.text_.text = var_640_29
				arg_637_1.typewritter.percent = 0

				arg_637_1.typewritter:SetDirty()
				arg_637_1:ShowNextGo(false)
				arg_637_1:RecordContent(arg_637_1.text_.text)
			end

			local var_640_33 = var_640_25 + 0.3
			local var_640_34 = math.max(var_640_26, arg_637_1.talkMaxDuration)

			if var_640_33 <= arg_637_1.time_ and arg_637_1.time_ < var_640_33 + var_640_34 then
				arg_637_1.typewritter.percent = (arg_637_1.time_ - var_640_33) / var_640_34

				arg_637_1.typewritter:SetDirty()
			end

			if arg_637_1.time_ >= var_640_33 + var_640_34 and arg_637_1.time_ < var_640_33 + var_640_34 + arg_640_0 then
				arg_637_1.typewritter.percent = 1

				arg_637_1.typewritter:SetDirty()
				arg_637_1:ShowNextGo(true)
			end
		end

		arg_637_1.nodeConfigList_ = {
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

		arg_637_1:InitPlayNodeList()
	end,
	Play320061155 = function(arg_643_0, arg_643_1)
		arg_643_1.time_ = 0
		arg_643_1.frameCnt_ = 0
		arg_643_1.state_ = "playing"
		arg_643_1.curTalkId_ = 320061155
		arg_643_1.duration_ = 5

		SetActive(arg_643_1.tipsGo_, false)

		function arg_643_1.onSingleLineFinish_()
			arg_643_1.onSingleLineUpdate_ = nil
			arg_643_1.onSingleLineFinish_ = nil
			arg_643_1.state_ = "waiting"
		end

		function arg_643_1.playNext_(arg_645_0)
			if arg_645_0 == 1 then
				arg_643_0:Play320061156(arg_643_1)
			end
		end

		function arg_643_1.onSingleLineUpdate_(arg_646_0)
			local var_646_0 = 0
			local var_646_1 = 0.225

			if var_646_0 < arg_643_1.time_ and arg_643_1.time_ <= var_646_0 + arg_646_0 then
				arg_643_1.talkMaxDuration = 0
				arg_643_1.dialogCg_.alpha = 1

				arg_643_1.dialog_:SetActive(true)
				SetActive(arg_643_1.leftNameGo_, true)

				local var_646_2 = arg_643_1:FormatText(StoryNameCfg[7].name)

				arg_643_1.leftNameTxt_.text = var_646_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_643_1.leftNameTxt_.transform)

				arg_643_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_643_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_643_1:RecordName(arg_643_1.leftNameTxt_.text)
				SetActive(arg_643_1.iconTrs_.gameObject, true)
				arg_643_1.iconController_:SetSelectedState("hero")

				arg_643_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_643_1.callingController_:SetSelectedState("normal")

				arg_643_1.keyicon_.color = Color.New(1, 1, 1)
				arg_643_1.icon_.color = Color.New(1, 1, 1)

				local var_646_3 = arg_643_1:GetWordFromCfg(320061155)
				local var_646_4 = arg_643_1:FormatText(var_646_3.content)

				arg_643_1.text_.text = var_646_4

				LuaForUtil.ClearLinePrefixSymbol(arg_643_1.text_)

				local var_646_5 = 9
				local var_646_6 = utf8.len(var_646_4)
				local var_646_7 = var_646_5 <= 0 and var_646_1 or var_646_1 * (var_646_6 / var_646_5)

				if var_646_7 > 0 and var_646_1 < var_646_7 then
					arg_643_1.talkMaxDuration = var_646_7

					if var_646_7 + var_646_0 > arg_643_1.duration_ then
						arg_643_1.duration_ = var_646_7 + var_646_0
					end
				end

				arg_643_1.text_.text = var_646_4
				arg_643_1.typewritter.percent = 0

				arg_643_1.typewritter:SetDirty()
				arg_643_1:ShowNextGo(false)
				arg_643_1:RecordContent(arg_643_1.text_.text)
			end

			local var_646_8 = math.max(var_646_1, arg_643_1.talkMaxDuration)

			if var_646_0 <= arg_643_1.time_ and arg_643_1.time_ < var_646_0 + var_646_8 then
				arg_643_1.typewritter.percent = (arg_643_1.time_ - var_646_0) / var_646_8

				arg_643_1.typewritter:SetDirty()
			end

			if arg_643_1.time_ >= var_646_0 + var_646_8 and arg_643_1.time_ < var_646_0 + var_646_8 + arg_646_0 then
				arg_643_1.typewritter.percent = 1

				arg_643_1.typewritter:SetDirty()
				arg_643_1:ShowNextGo(true)
			end
		end

		arg_643_1.nodeConfigList_ = {}

		arg_643_1:InitPlayNodeList()
	end,
	Play320061156 = function(arg_647_0, arg_647_1)
		arg_647_1.time_ = 0
		arg_647_1.frameCnt_ = 0
		arg_647_1.state_ = "playing"
		arg_647_1.curTalkId_ = 320061156
		arg_647_1.duration_ = 5

		SetActive(arg_647_1.tipsGo_, false)

		function arg_647_1.onSingleLineFinish_()
			arg_647_1.onSingleLineUpdate_ = nil
			arg_647_1.onSingleLineFinish_ = nil
			arg_647_1.state_ = "waiting"
		end

		function arg_647_1.playNext_(arg_649_0)
			if arg_649_0 == 1 then
				arg_647_0:Play320061157(arg_647_1)
			end
		end

		function arg_647_1.onSingleLineUpdate_(arg_650_0)
			local var_650_0 = 0
			local var_650_1 = 1.575

			if var_650_0 < arg_647_1.time_ and arg_647_1.time_ <= var_650_0 + arg_650_0 then
				arg_647_1.talkMaxDuration = 0
				arg_647_1.dialogCg_.alpha = 1

				arg_647_1.dialog_:SetActive(true)
				SetActive(arg_647_1.leftNameGo_, false)

				arg_647_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_647_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_647_1:RecordName(arg_647_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_647_1.iconTrs_.gameObject, false)
				arg_647_1.callingController_:SetSelectedState("normal")

				local var_650_2 = arg_647_1:GetWordFromCfg(320061156)
				local var_650_3 = arg_647_1:FormatText(var_650_2.content)

				arg_647_1.text_.text = var_650_3

				LuaForUtil.ClearLinePrefixSymbol(arg_647_1.text_)

				local var_650_4 = 63
				local var_650_5 = utf8.len(var_650_3)
				local var_650_6 = var_650_4 <= 0 and var_650_1 or var_650_1 * (var_650_5 / var_650_4)

				if var_650_6 > 0 and var_650_1 < var_650_6 then
					arg_647_1.talkMaxDuration = var_650_6

					if var_650_6 + var_650_0 > arg_647_1.duration_ then
						arg_647_1.duration_ = var_650_6 + var_650_0
					end
				end

				arg_647_1.text_.text = var_650_3
				arg_647_1.typewritter.percent = 0

				arg_647_1.typewritter:SetDirty()
				arg_647_1:ShowNextGo(false)
				arg_647_1:RecordContent(arg_647_1.text_.text)
			end

			local var_650_7 = math.max(var_650_1, arg_647_1.talkMaxDuration)

			if var_650_0 <= arg_647_1.time_ and arg_647_1.time_ < var_650_0 + var_650_7 then
				arg_647_1.typewritter.percent = (arg_647_1.time_ - var_650_0) / var_650_7

				arg_647_1.typewritter:SetDirty()
			end

			if arg_647_1.time_ >= var_650_0 + var_650_7 and arg_647_1.time_ < var_650_0 + var_650_7 + arg_650_0 then
				arg_647_1.typewritter.percent = 1

				arg_647_1.typewritter:SetDirty()
				arg_647_1:ShowNextGo(true)
			end
		end

		arg_647_1.nodeConfigList_ = {}

		arg_647_1:InitPlayNodeList()
	end,
	Play320061157 = function(arg_651_0, arg_651_1)
		arg_651_1.time_ = 0
		arg_651_1.frameCnt_ = 0
		arg_651_1.state_ = "playing"
		arg_651_1.curTalkId_ = 320061157
		arg_651_1.duration_ = 5

		SetActive(arg_651_1.tipsGo_, false)

		function arg_651_1.onSingleLineFinish_()
			arg_651_1.onSingleLineUpdate_ = nil
			arg_651_1.onSingleLineFinish_ = nil
			arg_651_1.state_ = "waiting"
		end

		function arg_651_1.playNext_(arg_653_0)
			if arg_653_0 == 1 then
				arg_651_0:Play320061158(arg_651_1)
			end
		end

		function arg_651_1.onSingleLineUpdate_(arg_654_0)
			local var_654_0 = 0
			local var_654_1 = 0.1

			if var_654_0 < arg_651_1.time_ and arg_651_1.time_ <= var_654_0 + arg_654_0 then
				arg_651_1.talkMaxDuration = 0
				arg_651_1.dialogCg_.alpha = 1

				arg_651_1.dialog_:SetActive(true)
				SetActive(arg_651_1.leftNameGo_, true)

				local var_654_2 = arg_651_1:FormatText(StoryNameCfg[7].name)

				arg_651_1.leftNameTxt_.text = var_654_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_651_1.leftNameTxt_.transform)

				arg_651_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_651_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_651_1:RecordName(arg_651_1.leftNameTxt_.text)
				SetActive(arg_651_1.iconTrs_.gameObject, true)
				arg_651_1.iconController_:SetSelectedState("hero")

				arg_651_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_651_1.callingController_:SetSelectedState("normal")

				arg_651_1.keyicon_.color = Color.New(1, 1, 1)
				arg_651_1.icon_.color = Color.New(1, 1, 1)

				local var_654_3 = arg_651_1:GetWordFromCfg(320061157)
				local var_654_4 = arg_651_1:FormatText(var_654_3.content)

				arg_651_1.text_.text = var_654_4

				LuaForUtil.ClearLinePrefixSymbol(arg_651_1.text_)

				local var_654_5 = 4
				local var_654_6 = utf8.len(var_654_4)
				local var_654_7 = var_654_5 <= 0 and var_654_1 or var_654_1 * (var_654_6 / var_654_5)

				if var_654_7 > 0 and var_654_1 < var_654_7 then
					arg_651_1.talkMaxDuration = var_654_7

					if var_654_7 + var_654_0 > arg_651_1.duration_ then
						arg_651_1.duration_ = var_654_7 + var_654_0
					end
				end

				arg_651_1.text_.text = var_654_4
				arg_651_1.typewritter.percent = 0

				arg_651_1.typewritter:SetDirty()
				arg_651_1:ShowNextGo(false)
				arg_651_1:RecordContent(arg_651_1.text_.text)
			end

			local var_654_8 = math.max(var_654_1, arg_651_1.talkMaxDuration)

			if var_654_0 <= arg_651_1.time_ and arg_651_1.time_ < var_654_0 + var_654_8 then
				arg_651_1.typewritter.percent = (arg_651_1.time_ - var_654_0) / var_654_8

				arg_651_1.typewritter:SetDirty()
			end

			if arg_651_1.time_ >= var_654_0 + var_654_8 and arg_651_1.time_ < var_654_0 + var_654_8 + arg_654_0 then
				arg_651_1.typewritter.percent = 1

				arg_651_1.typewritter:SetDirty()
				arg_651_1:ShowNextGo(true)
			end
		end

		arg_651_1.nodeConfigList_ = {}

		arg_651_1:InitPlayNodeList()
	end,
	Play320061158 = function(arg_655_0, arg_655_1)
		arg_655_1.time_ = 0
		arg_655_1.frameCnt_ = 0
		arg_655_1.state_ = "playing"
		arg_655_1.curTalkId_ = 320061158
		arg_655_1.duration_ = 2.7

		local var_655_0 = {
			zh = 2.7,
			ja = 1.4
		}
		local var_655_1 = manager.audio:GetLocalizationFlag()

		if var_655_0[var_655_1] ~= nil then
			arg_655_1.duration_ = var_655_0[var_655_1]
		end

		SetActive(arg_655_1.tipsGo_, false)

		function arg_655_1.onSingleLineFinish_()
			arg_655_1.onSingleLineUpdate_ = nil
			arg_655_1.onSingleLineFinish_ = nil
			arg_655_1.state_ = "waiting"
		end

		function arg_655_1.playNext_(arg_657_0)
			if arg_657_0 == 1 then
				arg_655_0:Play320061159(arg_655_1)
			end
		end

		function arg_655_1.onSingleLineUpdate_(arg_658_0)
			local var_658_0 = 0
			local var_658_1 = 0.15

			if var_658_0 < arg_655_1.time_ and arg_655_1.time_ <= var_658_0 + arg_658_0 then
				arg_655_1.talkMaxDuration = 0
				arg_655_1.dialogCg_.alpha = 1

				arg_655_1.dialog_:SetActive(true)
				SetActive(arg_655_1.leftNameGo_, true)

				local var_658_2 = arg_655_1:FormatText(StoryNameCfg[36].name)

				arg_655_1.leftNameTxt_.text = var_658_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_655_1.leftNameTxt_.transform)

				arg_655_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_655_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_655_1:RecordName(arg_655_1.leftNameTxt_.text)
				SetActive(arg_655_1.iconTrs_.gameObject, true)
				arg_655_1.iconController_:SetSelectedState("hero")

				arg_655_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1111_1")

				arg_655_1.callingController_:SetSelectedState("normal")

				arg_655_1.keyicon_.color = Color.New(1, 1, 1)
				arg_655_1.icon_.color = Color.New(1, 1, 1)

				local var_658_3 = arg_655_1:GetWordFromCfg(320061158)
				local var_658_4 = arg_655_1:FormatText(var_658_3.content)

				arg_655_1.text_.text = var_658_4

				LuaForUtil.ClearLinePrefixSymbol(arg_655_1.text_)

				local var_658_5 = 6
				local var_658_6 = utf8.len(var_658_4)
				local var_658_7 = var_658_5 <= 0 and var_658_1 or var_658_1 * (var_658_6 / var_658_5)

				if var_658_7 > 0 and var_658_1 < var_658_7 then
					arg_655_1.talkMaxDuration = var_658_7

					if var_658_7 + var_658_0 > arg_655_1.duration_ then
						arg_655_1.duration_ = var_658_7 + var_658_0
					end
				end

				arg_655_1.text_.text = var_658_4
				arg_655_1.typewritter.percent = 0

				arg_655_1.typewritter:SetDirty()
				arg_655_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320061", "320061158", "story_v_out_320061.awb") ~= 0 then
					local var_658_8 = manager.audio:GetVoiceLength("story_v_out_320061", "320061158", "story_v_out_320061.awb") / 1000

					if var_658_8 + var_658_0 > arg_655_1.duration_ then
						arg_655_1.duration_ = var_658_8 + var_658_0
					end

					if var_658_3.prefab_name ~= "" and arg_655_1.actors_[var_658_3.prefab_name] ~= nil then
						local var_658_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_655_1.actors_[var_658_3.prefab_name].transform, "story_v_out_320061", "320061158", "story_v_out_320061.awb")

						arg_655_1:RecordAudio("320061158", var_658_9)
						arg_655_1:RecordAudio("320061158", var_658_9)
					else
						arg_655_1:AudioAction("play", "voice", "story_v_out_320061", "320061158", "story_v_out_320061.awb")
					end

					arg_655_1:RecordHistoryTalkVoice("story_v_out_320061", "320061158", "story_v_out_320061.awb")
				end

				arg_655_1:RecordContent(arg_655_1.text_.text)
			end

			local var_658_10 = math.max(var_658_1, arg_655_1.talkMaxDuration)

			if var_658_0 <= arg_655_1.time_ and arg_655_1.time_ < var_658_0 + var_658_10 then
				arg_655_1.typewritter.percent = (arg_655_1.time_ - var_658_0) / var_658_10

				arg_655_1.typewritter:SetDirty()
			end

			if arg_655_1.time_ >= var_658_0 + var_658_10 and arg_655_1.time_ < var_658_0 + var_658_10 + arg_658_0 then
				arg_655_1.typewritter.percent = 1

				arg_655_1.typewritter:SetDirty()
				arg_655_1:ShowNextGo(true)
			end
		end

		arg_655_1.nodeConfigList_ = {}

		arg_655_1:InitPlayNodeList()
	end,
	Play320061159 = function(arg_659_0, arg_659_1)
		arg_659_1.time_ = 0
		arg_659_1.frameCnt_ = 0
		arg_659_1.state_ = "playing"
		arg_659_1.curTalkId_ = 320061159
		arg_659_1.duration_ = 6

		SetActive(arg_659_1.tipsGo_, false)

		function arg_659_1.onSingleLineFinish_()
			arg_659_1.onSingleLineUpdate_ = nil
			arg_659_1.onSingleLineFinish_ = nil
			arg_659_1.state_ = "waiting"
		end

		function arg_659_1.playNext_(arg_661_0)
			if arg_661_0 == 1 then
				arg_659_0:Play320061160(arg_659_1)
			end
		end

		function arg_659_1.onSingleLineUpdate_(arg_662_0)
			local var_662_0 = manager.ui.mainCamera.transform
			local var_662_1 = 0

			if var_662_1 < arg_659_1.time_ and arg_659_1.time_ <= var_662_1 + arg_662_0 then
				local var_662_2 = arg_659_1.var_.effectfeiqu1
				local var_662_3
				local var_662_4 = var_662_0

				if not var_662_2 then
					var_662_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ui_slash_01"), var_662_4)
					var_662_2.name = "feiqu1"
					arg_659_1.var_.effectfeiqu1 = var_662_2
				else
					var_662_2.transform:SetParent(var_662_4)
				end

				var_662_2.transform.localPosition = Vector3.New(0, 0, 0.44)
				var_662_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_662_5 = 0

			if var_662_5 < arg_659_1.time_ and arg_659_1.time_ <= var_662_5 + arg_662_0 then
				arg_659_1.allBtn_.enabled = false
			end

			local var_662_6 = 1

			if arg_659_1.time_ >= var_662_5 + var_662_6 and arg_659_1.time_ < var_662_5 + var_662_6 + arg_662_0 then
				arg_659_1.allBtn_.enabled = true
			end

			local var_662_7 = manager.ui.mainCamera.transform
			local var_662_8 = 0

			if var_662_8 < arg_659_1.time_ and arg_659_1.time_ <= var_662_8 + arg_662_0 then
				arg_659_1.var_.shakeOldPos = var_662_7.localPosition
			end

			local var_662_9 = 1

			if var_662_8 <= arg_659_1.time_ and arg_659_1.time_ < var_662_8 + var_662_9 then
				local var_662_10 = (arg_659_1.time_ - var_662_8) / 0.066
				local var_662_11, var_662_12 = math.modf(var_662_10)

				var_662_7.localPosition = Vector3.New(var_662_12 * 0.13, var_662_12 * 0.13, var_662_12 * 0.13) + arg_659_1.var_.shakeOldPos
			end

			if arg_659_1.time_ >= var_662_8 + var_662_9 and arg_659_1.time_ < var_662_8 + var_662_9 + arg_662_0 then
				var_662_7.localPosition = arg_659_1.var_.shakeOldPos
			end

			if arg_659_1.frameCnt_ <= 1 then
				arg_659_1.dialog_:SetActive(false)
			end

			local var_662_13 = 1
			local var_662_14 = 0.9

			if var_662_13 < arg_659_1.time_ and arg_659_1.time_ <= var_662_13 + arg_662_0 then
				arg_659_1.talkMaxDuration = 0

				arg_659_1.dialog_:SetActive(true)

				arg_659_1.dialogCg_.alpha = 0

				local var_662_15 = LeanTween.value(arg_659_1.dialog_, 0, 1, 0.3)

				var_662_15:setOnUpdate(LuaHelper.FloatAction(function(arg_663_0)
					arg_659_1.dialogCg_.alpha = arg_663_0
				end))
				var_662_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_659_1.dialog_)
					var_662_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_659_1.duration_ = arg_659_1.duration_ + 0.3

				SetActive(arg_659_1.leftNameGo_, false)

				arg_659_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_659_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_659_1:RecordName(arg_659_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_659_1.iconTrs_.gameObject, false)
				arg_659_1.callingController_:SetSelectedState("normal")

				local var_662_16 = arg_659_1:GetWordFromCfg(320061159)
				local var_662_17 = arg_659_1:FormatText(var_662_16.content)

				arg_659_1.text_.text = var_662_17

				LuaForUtil.ClearLinePrefixSymbol(arg_659_1.text_)

				local var_662_18 = 36
				local var_662_19 = utf8.len(var_662_17)
				local var_662_20 = var_662_18 <= 0 and var_662_14 or var_662_14 * (var_662_19 / var_662_18)

				if var_662_20 > 0 and var_662_14 < var_662_20 then
					arg_659_1.talkMaxDuration = var_662_20
					var_662_13 = var_662_13 + 0.3

					if var_662_20 + var_662_13 > arg_659_1.duration_ then
						arg_659_1.duration_ = var_662_20 + var_662_13
					end
				end

				arg_659_1.text_.text = var_662_17
				arg_659_1.typewritter.percent = 0

				arg_659_1.typewritter:SetDirty()
				arg_659_1:ShowNextGo(false)
				arg_659_1:RecordContent(arg_659_1.text_.text)
			end

			local var_662_21 = var_662_13 + 0.3
			local var_662_22 = math.max(var_662_14, arg_659_1.talkMaxDuration)

			if var_662_21 <= arg_659_1.time_ and arg_659_1.time_ < var_662_21 + var_662_22 then
				arg_659_1.typewritter.percent = (arg_659_1.time_ - var_662_21) / var_662_22

				arg_659_1.typewritter:SetDirty()
			end

			if arg_659_1.time_ >= var_662_21 + var_662_22 and arg_659_1.time_ < var_662_21 + var_662_22 + arg_662_0 then
				arg_659_1.typewritter.percent = 1

				arg_659_1.typewritter:SetDirty()
				arg_659_1:ShowNextGo(true)
			end
		end

		arg_659_1.nodeConfigList_ = {}

		arg_659_1:InitPlayNodeList()
	end,
	Play320061160 = function(arg_665_0, arg_665_1)
		arg_665_1.time_ = 0
		arg_665_1.frameCnt_ = 0
		arg_665_1.state_ = "playing"
		arg_665_1.curTalkId_ = 320061160
		arg_665_1.duration_ = 2.17

		local var_665_0 = {
			zh = 2.166,
			ja = 1.966
		}
		local var_665_1 = manager.audio:GetLocalizationFlag()

		if var_665_0[var_665_1] ~= nil then
			arg_665_1.duration_ = var_665_0[var_665_1]
		end

		SetActive(arg_665_1.tipsGo_, false)

		function arg_665_1.onSingleLineFinish_()
			arg_665_1.onSingleLineUpdate_ = nil
			arg_665_1.onSingleLineFinish_ = nil
			arg_665_1.state_ = "waiting"
		end

		function arg_665_1.playNext_(arg_667_0)
			if arg_667_0 == 1 then
				arg_665_0:Play320061161(arg_665_1)
			end
		end

		function arg_665_1.onSingleLineUpdate_(arg_668_0)
			local var_668_0 = 0
			local var_668_1 = 0.225

			if var_668_0 < arg_665_1.time_ and arg_665_1.time_ <= var_668_0 + arg_668_0 then
				arg_665_1.talkMaxDuration = 0
				arg_665_1.dialogCg_.alpha = 1

				arg_665_1.dialog_:SetActive(true)
				SetActive(arg_665_1.leftNameGo_, true)

				local var_668_2 = arg_665_1:FormatText(StoryNameCfg[1021].name)

				arg_665_1.leftNameTxt_.text = var_668_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_665_1.leftNameTxt_.transform)

				arg_665_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_665_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_665_1:RecordName(arg_665_1.leftNameTxt_.text)
				SetActive(arg_665_1.iconTrs_.gameObject, true)
				arg_665_1.iconController_:SetSelectedState("hero")

				arg_665_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10100")

				arg_665_1.callingController_:SetSelectedState("normal")

				arg_665_1.keyicon_.color = Color.New(1, 1, 1)
				arg_665_1.icon_.color = Color.New(1, 1, 1)

				local var_668_3 = arg_665_1:GetWordFromCfg(320061160)
				local var_668_4 = arg_665_1:FormatText(var_668_3.content)

				arg_665_1.text_.text = var_668_4

				LuaForUtil.ClearLinePrefixSymbol(arg_665_1.text_)

				local var_668_5 = 9
				local var_668_6 = utf8.len(var_668_4)
				local var_668_7 = var_668_5 <= 0 and var_668_1 or var_668_1 * (var_668_6 / var_668_5)

				if var_668_7 > 0 and var_668_1 < var_668_7 then
					arg_665_1.talkMaxDuration = var_668_7

					if var_668_7 + var_668_0 > arg_665_1.duration_ then
						arg_665_1.duration_ = var_668_7 + var_668_0
					end
				end

				arg_665_1.text_.text = var_668_4
				arg_665_1.typewritter.percent = 0

				arg_665_1.typewritter:SetDirty()
				arg_665_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320061", "320061160", "story_v_out_320061.awb") ~= 0 then
					local var_668_8 = manager.audio:GetVoiceLength("story_v_out_320061", "320061160", "story_v_out_320061.awb") / 1000

					if var_668_8 + var_668_0 > arg_665_1.duration_ then
						arg_665_1.duration_ = var_668_8 + var_668_0
					end

					if var_668_3.prefab_name ~= "" and arg_665_1.actors_[var_668_3.prefab_name] ~= nil then
						local var_668_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_665_1.actors_[var_668_3.prefab_name].transform, "story_v_out_320061", "320061160", "story_v_out_320061.awb")

						arg_665_1:RecordAudio("320061160", var_668_9)
						arg_665_1:RecordAudio("320061160", var_668_9)
					else
						arg_665_1:AudioAction("play", "voice", "story_v_out_320061", "320061160", "story_v_out_320061.awb")
					end

					arg_665_1:RecordHistoryTalkVoice("story_v_out_320061", "320061160", "story_v_out_320061.awb")
				end

				arg_665_1:RecordContent(arg_665_1.text_.text)
			end

			local var_668_10 = math.max(var_668_1, arg_665_1.talkMaxDuration)

			if var_668_0 <= arg_665_1.time_ and arg_665_1.time_ < var_668_0 + var_668_10 then
				arg_665_1.typewritter.percent = (arg_665_1.time_ - var_668_0) / var_668_10

				arg_665_1.typewritter:SetDirty()
			end

			if arg_665_1.time_ >= var_668_0 + var_668_10 and arg_665_1.time_ < var_668_0 + var_668_10 + arg_668_0 then
				arg_665_1.typewritter.percent = 1

				arg_665_1.typewritter:SetDirty()
				arg_665_1:ShowNextGo(true)
			end
		end

		arg_665_1.nodeConfigList_ = {}

		arg_665_1:InitPlayNodeList()
	end,
	Play320061161 = function(arg_669_0, arg_669_1)
		arg_669_1.time_ = 0
		arg_669_1.frameCnt_ = 0
		arg_669_1.state_ = "playing"
		arg_669_1.curTalkId_ = 320061161
		arg_669_1.duration_ = 5

		SetActive(arg_669_1.tipsGo_, false)

		function arg_669_1.onSingleLineFinish_()
			arg_669_1.onSingleLineUpdate_ = nil
			arg_669_1.onSingleLineFinish_ = nil
			arg_669_1.state_ = "waiting"
		end

		function arg_669_1.playNext_(arg_671_0)
			if arg_671_0 == 1 then
				arg_669_0:Play320061162(arg_669_1)
			end
		end

		function arg_669_1.onSingleLineUpdate_(arg_672_0)
			local var_672_0
			local var_672_1 = 0

			if var_672_1 < arg_669_1.time_ and arg_669_1.time_ <= var_672_1 + arg_672_0 then
				local var_672_2 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_672_2 then
					var_672_2.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_672_2.radialBlurScale = 0
					var_672_2.radialBlurGradient = 1
					var_672_2.radialBlurIntensity = 1

					if var_672_0 then
						var_672_2.radialBlurTarget = var_672_0.transform
					end
				end
			end

			local var_672_3 = 0.2

			if var_672_1 <= arg_669_1.time_ and arg_669_1.time_ < var_672_1 + var_672_3 then
				local var_672_4 = (arg_669_1.time_ - var_672_1) / var_672_3
				local var_672_5 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_672_5 then
					var_672_5.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_672_5.radialBlurScale = Mathf.Lerp(0, 0.822, var_672_4)
					var_672_5.radialBlurGradient = Mathf.Lerp(1, 1, var_672_4)
					var_672_5.radialBlurIntensity = Mathf.Lerp(1, 1, var_672_4)
				end
			end

			if arg_669_1.time_ >= var_672_1 + var_672_3 and arg_669_1.time_ < var_672_1 + var_672_3 + arg_672_0 then
				local var_672_6 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_672_6 then
					var_672_6.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_672_6.radialBlurScale = 0.822
					var_672_6.radialBlurGradient = 1
					var_672_6.radialBlurIntensity = 1
				end
			end

			local var_672_7 = manager.ui.mainCamera.transform
			local var_672_8 = 0

			if var_672_8 < arg_669_1.time_ and arg_669_1.time_ <= var_672_8 + arg_672_0 then
				local var_672_9 = arg_669_1.var_.effectxueji1
				local var_672_10
				local var_672_11 = var_672_7

				if not var_672_9 then
					var_672_9 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_blood_in"), var_672_11)
					var_672_9.name = "xueji1"
					arg_669_1.var_.effectxueji1 = var_672_9
				else
					var_672_9.transform:SetParent(var_672_11)
				end

				var_672_9.transform.localPosition = Vector3.New(0, 0, 0)
				var_672_9.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_672_12 = 0
			local var_672_13 = 0.05

			if var_672_12 < arg_669_1.time_ and arg_669_1.time_ <= var_672_12 + arg_672_0 then
				arg_669_1.talkMaxDuration = 0
				arg_669_1.dialogCg_.alpha = 1

				arg_669_1.dialog_:SetActive(true)
				SetActive(arg_669_1.leftNameGo_, true)

				local var_672_14 = arg_669_1:FormatText(StoryNameCfg[7].name)

				arg_669_1.leftNameTxt_.text = var_672_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_669_1.leftNameTxt_.transform)

				arg_669_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_669_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_669_1:RecordName(arg_669_1.leftNameTxt_.text)
				SetActive(arg_669_1.iconTrs_.gameObject, true)
				arg_669_1.iconController_:SetSelectedState("hero")

				arg_669_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_669_1.callingController_:SetSelectedState("normal")

				arg_669_1.keyicon_.color = Color.New(1, 1, 1)
				arg_669_1.icon_.color = Color.New(1, 1, 1)

				local var_672_15 = arg_669_1:GetWordFromCfg(320061161)
				local var_672_16 = arg_669_1:FormatText(var_672_15.content)

				arg_669_1.text_.text = var_672_16

				LuaForUtil.ClearLinePrefixSymbol(arg_669_1.text_)

				local var_672_17 = 2
				local var_672_18 = utf8.len(var_672_16)
				local var_672_19 = var_672_17 <= 0 and var_672_13 or var_672_13 * (var_672_18 / var_672_17)

				if var_672_19 > 0 and var_672_13 < var_672_19 then
					arg_669_1.talkMaxDuration = var_672_19

					if var_672_19 + var_672_12 > arg_669_1.duration_ then
						arg_669_1.duration_ = var_672_19 + var_672_12
					end
				end

				arg_669_1.text_.text = var_672_16
				arg_669_1.typewritter.percent = 0

				arg_669_1.typewritter:SetDirty()
				arg_669_1:ShowNextGo(false)
				arg_669_1:RecordContent(arg_669_1.text_.text)
			end

			local var_672_20 = math.max(var_672_13, arg_669_1.talkMaxDuration)

			if var_672_12 <= arg_669_1.time_ and arg_669_1.time_ < var_672_12 + var_672_20 then
				arg_669_1.typewritter.percent = (arg_669_1.time_ - var_672_12) / var_672_20

				arg_669_1.typewritter:SetDirty()
			end

			if arg_669_1.time_ >= var_672_12 + var_672_20 and arg_669_1.time_ < var_672_12 + var_672_20 + arg_672_0 then
				arg_669_1.typewritter.percent = 1

				arg_669_1.typewritter:SetDirty()
				arg_669_1:ShowNextGo(true)
			end
		end

		arg_669_1.nodeConfigList_ = {}

		arg_669_1:InitPlayNodeList()
	end,
	Play320061162 = function(arg_673_0, arg_673_1)
		arg_673_1.time_ = 0
		arg_673_1.frameCnt_ = 0
		arg_673_1.state_ = "playing"
		arg_673_1.curTalkId_ = 320061162
		arg_673_1.duration_ = 5

		SetActive(arg_673_1.tipsGo_, false)

		function arg_673_1.onSingleLineFinish_()
			arg_673_1.onSingleLineUpdate_ = nil
			arg_673_1.onSingleLineFinish_ = nil
			arg_673_1.state_ = "waiting"
		end

		function arg_673_1.playNext_(arg_675_0)
			if arg_675_0 == 1 then
				arg_673_0:Play320061163(arg_673_1)
			end
		end

		function arg_673_1.onSingleLineUpdate_(arg_676_0)
			local var_676_0 = 0
			local var_676_1 = 1

			if var_676_0 < arg_673_1.time_ and arg_673_1.time_ <= var_676_0 + arg_676_0 then
				local var_676_2 = "play"
				local var_676_3 = "effect"

				arg_673_1:AudioAction(var_676_2, var_676_3, "se_story_122_03", "se_story_122_03_swordhit", "")
			end

			local var_676_4 = 0
			local var_676_5 = 0.875

			if var_676_4 < arg_673_1.time_ and arg_673_1.time_ <= var_676_4 + arg_676_0 then
				arg_673_1.talkMaxDuration = 0
				arg_673_1.dialogCg_.alpha = 1

				arg_673_1.dialog_:SetActive(true)
				SetActive(arg_673_1.leftNameGo_, false)

				arg_673_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_673_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_673_1:RecordName(arg_673_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_673_1.iconTrs_.gameObject, false)
				arg_673_1.callingController_:SetSelectedState("normal")

				local var_676_6 = arg_673_1:GetWordFromCfg(320061162)
				local var_676_7 = arg_673_1:FormatText(var_676_6.content)

				arg_673_1.text_.text = var_676_7

				LuaForUtil.ClearLinePrefixSymbol(arg_673_1.text_)

				local var_676_8 = 35
				local var_676_9 = utf8.len(var_676_7)
				local var_676_10 = var_676_8 <= 0 and var_676_5 or var_676_5 * (var_676_9 / var_676_8)

				if var_676_10 > 0 and var_676_5 < var_676_10 then
					arg_673_1.talkMaxDuration = var_676_10

					if var_676_10 + var_676_4 > arg_673_1.duration_ then
						arg_673_1.duration_ = var_676_10 + var_676_4
					end
				end

				arg_673_1.text_.text = var_676_7
				arg_673_1.typewritter.percent = 0

				arg_673_1.typewritter:SetDirty()
				arg_673_1:ShowNextGo(false)
				arg_673_1:RecordContent(arg_673_1.text_.text)
			end

			local var_676_11 = math.max(var_676_5, arg_673_1.talkMaxDuration)

			if var_676_4 <= arg_673_1.time_ and arg_673_1.time_ < var_676_4 + var_676_11 then
				arg_673_1.typewritter.percent = (arg_673_1.time_ - var_676_4) / var_676_11

				arg_673_1.typewritter:SetDirty()
			end

			if arg_673_1.time_ >= var_676_4 + var_676_11 and arg_673_1.time_ < var_676_4 + var_676_11 + arg_676_0 then
				arg_673_1.typewritter.percent = 1

				arg_673_1.typewritter:SetDirty()
				arg_673_1:ShowNextGo(true)
			end
		end

		arg_673_1.nodeConfigList_ = {}

		arg_673_1:InitPlayNodeList()
	end,
	Play320061163 = function(arg_677_0, arg_677_1)
		arg_677_1.time_ = 0
		arg_677_1.frameCnt_ = 0
		arg_677_1.state_ = "playing"
		arg_677_1.curTalkId_ = 320061163
		arg_677_1.duration_ = 5

		SetActive(arg_677_1.tipsGo_, false)

		function arg_677_1.onSingleLineFinish_()
			arg_677_1.onSingleLineUpdate_ = nil
			arg_677_1.onSingleLineFinish_ = nil
			arg_677_1.state_ = "waiting"
		end

		function arg_677_1.playNext_(arg_679_0)
			if arg_679_0 == 1 then
				arg_677_0:Play320061164(arg_677_1)
			end
		end

		function arg_677_1.onSingleLineUpdate_(arg_680_0)
			local var_680_0 = manager.ui.mainCamera.transform
			local var_680_1 = 0

			if var_680_1 < arg_677_1.time_ and arg_677_1.time_ <= var_680_1 + arg_680_0 then
				local var_680_2 = arg_677_1.var_.effectxueji2
				local var_680_3
				local var_680_4 = var_680_0

				if not var_680_2 then
					var_680_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_blood_in_ui"), var_680_4)
					var_680_2.name = "xueji2"
					arg_677_1.var_.effectxueji2 = var_680_2
				else
					var_680_2.transform:SetParent(var_680_4)
				end

				var_680_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_680_2.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_680_5 = manager.ui.mainCameraCom_
				local var_680_6 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_680_5.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_680_7 = var_680_2.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_680_8 = 15
				local var_680_9 = 2 * var_680_8 * Mathf.Tan(var_680_5.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_680_5.aspect
				local var_680_10 = 1
				local var_680_11 = 1.7777777777777777

				if var_680_11 < var_680_5.aspect then
					var_680_10 = var_680_9 / (2 * var_680_8 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_680_11)
				end

				for iter_680_0, iter_680_1 in ipairs(var_680_7) do
					local var_680_12 = iter_680_1.transform.localScale

					iter_680_1.transform.localScale = Vector3.New(var_680_12.x / var_680_6 * var_680_10, var_680_12.y / var_680_6, var_680_12.z)
				end
			end

			local var_680_13 = 0
			local var_680_14 = 0.95

			if var_680_13 < arg_677_1.time_ and arg_677_1.time_ <= var_680_13 + arg_680_0 then
				arg_677_1.talkMaxDuration = 0
				arg_677_1.dialogCg_.alpha = 1

				arg_677_1.dialog_:SetActive(true)
				SetActive(arg_677_1.leftNameGo_, false)

				arg_677_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_677_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_677_1:RecordName(arg_677_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_677_1.iconTrs_.gameObject, false)
				arg_677_1.callingController_:SetSelectedState("normal")

				local var_680_15 = arg_677_1:GetWordFromCfg(320061163)
				local var_680_16 = arg_677_1:FormatText(var_680_15.content)

				arg_677_1.text_.text = var_680_16

				LuaForUtil.ClearLinePrefixSymbol(arg_677_1.text_)

				local var_680_17 = 38
				local var_680_18 = utf8.len(var_680_16)
				local var_680_19 = var_680_17 <= 0 and var_680_14 or var_680_14 * (var_680_18 / var_680_17)

				if var_680_19 > 0 and var_680_14 < var_680_19 then
					arg_677_1.talkMaxDuration = var_680_19

					if var_680_19 + var_680_13 > arg_677_1.duration_ then
						arg_677_1.duration_ = var_680_19 + var_680_13
					end
				end

				arg_677_1.text_.text = var_680_16
				arg_677_1.typewritter.percent = 0

				arg_677_1.typewritter:SetDirty()
				arg_677_1:ShowNextGo(false)
				arg_677_1:RecordContent(arg_677_1.text_.text)
			end

			local var_680_20 = math.max(var_680_14, arg_677_1.talkMaxDuration)

			if var_680_13 <= arg_677_1.time_ and arg_677_1.time_ < var_680_13 + var_680_20 then
				arg_677_1.typewritter.percent = (arg_677_1.time_ - var_680_13) / var_680_20

				arg_677_1.typewritter:SetDirty()
			end

			if arg_677_1.time_ >= var_680_13 + var_680_20 and arg_677_1.time_ < var_680_13 + var_680_20 + arg_680_0 then
				arg_677_1.typewritter.percent = 1

				arg_677_1.typewritter:SetDirty()
				arg_677_1:ShowNextGo(true)
			end
		end

		arg_677_1.nodeConfigList_ = {}

		arg_677_1:InitPlayNodeList()
	end,
	Play320061164 = function(arg_681_0, arg_681_1)
		arg_681_1.time_ = 0
		arg_681_1.frameCnt_ = 0
		arg_681_1.state_ = "playing"
		arg_681_1.curTalkId_ = 320061164
		arg_681_1.duration_ = 5

		SetActive(arg_681_1.tipsGo_, false)

		function arg_681_1.onSingleLineFinish_()
			arg_681_1.onSingleLineUpdate_ = nil
			arg_681_1.onSingleLineFinish_ = nil
			arg_681_1.state_ = "waiting"
		end

		function arg_681_1.playNext_(arg_683_0)
			if arg_683_0 == 1 then
				arg_681_0:Play320061165(arg_681_1)
			end
		end

		function arg_681_1.onSingleLineUpdate_(arg_684_0)
			local var_684_0 = 0
			local var_684_1 = 1.475

			if var_684_0 < arg_681_1.time_ and arg_681_1.time_ <= var_684_0 + arg_684_0 then
				arg_681_1.talkMaxDuration = 0
				arg_681_1.dialogCg_.alpha = 1

				arg_681_1.dialog_:SetActive(true)
				SetActive(arg_681_1.leftNameGo_, false)

				arg_681_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_681_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_681_1:RecordName(arg_681_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_681_1.iconTrs_.gameObject, false)
				arg_681_1.callingController_:SetSelectedState("normal")

				local var_684_2 = arg_681_1:GetWordFromCfg(320061164)
				local var_684_3 = arg_681_1:FormatText(var_684_2.content)

				arg_681_1.text_.text = var_684_3

				LuaForUtil.ClearLinePrefixSymbol(arg_681_1.text_)

				local var_684_4 = 59
				local var_684_5 = utf8.len(var_684_3)
				local var_684_6 = var_684_4 <= 0 and var_684_1 or var_684_1 * (var_684_5 / var_684_4)

				if var_684_6 > 0 and var_684_1 < var_684_6 then
					arg_681_1.talkMaxDuration = var_684_6

					if var_684_6 + var_684_0 > arg_681_1.duration_ then
						arg_681_1.duration_ = var_684_6 + var_684_0
					end
				end

				arg_681_1.text_.text = var_684_3
				arg_681_1.typewritter.percent = 0

				arg_681_1.typewritter:SetDirty()
				arg_681_1:ShowNextGo(false)
				arg_681_1:RecordContent(arg_681_1.text_.text)
			end

			local var_684_7 = math.max(var_684_1, arg_681_1.talkMaxDuration)

			if var_684_0 <= arg_681_1.time_ and arg_681_1.time_ < var_684_0 + var_684_7 then
				arg_681_1.typewritter.percent = (arg_681_1.time_ - var_684_0) / var_684_7

				arg_681_1.typewritter:SetDirty()
			end

			if arg_681_1.time_ >= var_684_0 + var_684_7 and arg_681_1.time_ < var_684_0 + var_684_7 + arg_684_0 then
				arg_681_1.typewritter.percent = 1

				arg_681_1.typewritter:SetDirty()
				arg_681_1:ShowNextGo(true)
			end
		end

		arg_681_1.nodeConfigList_ = {}

		arg_681_1:InitPlayNodeList()
	end,
	Play320061165 = function(arg_685_0, arg_685_1)
		arg_685_1.time_ = 0
		arg_685_1.frameCnt_ = 0
		arg_685_1.state_ = "playing"
		arg_685_1.curTalkId_ = 320061165
		arg_685_1.duration_ = 5

		SetActive(arg_685_1.tipsGo_, false)

		function arg_685_1.onSingleLineFinish_()
			arg_685_1.onSingleLineUpdate_ = nil
			arg_685_1.onSingleLineFinish_ = nil
			arg_685_1.state_ = "waiting"
		end

		function arg_685_1.playNext_(arg_687_0)
			if arg_687_0 == 1 then
				arg_685_0:Play320061166(arg_685_1)
			end
		end

		function arg_685_1.onSingleLineUpdate_(arg_688_0)
			local var_688_0 = 0
			local var_688_1 = 0.35

			if var_688_0 < arg_685_1.time_ and arg_685_1.time_ <= var_688_0 + arg_688_0 then
				arg_685_1.talkMaxDuration = 0
				arg_685_1.dialogCg_.alpha = 1

				arg_685_1.dialog_:SetActive(true)
				SetActive(arg_685_1.leftNameGo_, true)

				local var_688_2 = arg_685_1:FormatText(StoryNameCfg[7].name)

				arg_685_1.leftNameTxt_.text = var_688_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_685_1.leftNameTxt_.transform)

				arg_685_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_685_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_685_1:RecordName(arg_685_1.leftNameTxt_.text)
				SetActive(arg_685_1.iconTrs_.gameObject, true)
				arg_685_1.iconController_:SetSelectedState("hero")

				arg_685_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_685_1.callingController_:SetSelectedState("normal")

				arg_685_1.keyicon_.color = Color.New(1, 1, 1)
				arg_685_1.icon_.color = Color.New(1, 1, 1)

				local var_688_3 = arg_685_1:GetWordFromCfg(320061165)
				local var_688_4 = arg_685_1:FormatText(var_688_3.content)

				arg_685_1.text_.text = var_688_4

				LuaForUtil.ClearLinePrefixSymbol(arg_685_1.text_)

				local var_688_5 = 14
				local var_688_6 = utf8.len(var_688_4)
				local var_688_7 = var_688_5 <= 0 and var_688_1 or var_688_1 * (var_688_6 / var_688_5)

				if var_688_7 > 0 and var_688_1 < var_688_7 then
					arg_685_1.talkMaxDuration = var_688_7

					if var_688_7 + var_688_0 > arg_685_1.duration_ then
						arg_685_1.duration_ = var_688_7 + var_688_0
					end
				end

				arg_685_1.text_.text = var_688_4
				arg_685_1.typewritter.percent = 0

				arg_685_1.typewritter:SetDirty()
				arg_685_1:ShowNextGo(false)
				arg_685_1:RecordContent(arg_685_1.text_.text)
			end

			local var_688_8 = math.max(var_688_1, arg_685_1.talkMaxDuration)

			if var_688_0 <= arg_685_1.time_ and arg_685_1.time_ < var_688_0 + var_688_8 then
				arg_685_1.typewritter.percent = (arg_685_1.time_ - var_688_0) / var_688_8

				arg_685_1.typewritter:SetDirty()
			end

			if arg_685_1.time_ >= var_688_0 + var_688_8 and arg_685_1.time_ < var_688_0 + var_688_8 + arg_688_0 then
				arg_685_1.typewritter.percent = 1

				arg_685_1.typewritter:SetDirty()
				arg_685_1:ShowNextGo(true)
			end
		end

		arg_685_1.nodeConfigList_ = {}

		arg_685_1:InitPlayNodeList()
	end,
	Play320061166 = function(arg_689_0, arg_689_1)
		arg_689_1.time_ = 0
		arg_689_1.frameCnt_ = 0
		arg_689_1.state_ = "playing"
		arg_689_1.curTalkId_ = 320061166
		arg_689_1.duration_ = 3.77

		local var_689_0 = {
			zh = 3.766,
			ja = 3.5
		}
		local var_689_1 = manager.audio:GetLocalizationFlag()

		if var_689_0[var_689_1] ~= nil then
			arg_689_1.duration_ = var_689_0[var_689_1]
		end

		SetActive(arg_689_1.tipsGo_, false)

		function arg_689_1.onSingleLineFinish_()
			arg_689_1.onSingleLineUpdate_ = nil
			arg_689_1.onSingleLineFinish_ = nil
			arg_689_1.state_ = "waiting"
		end

		function arg_689_1.playNext_(arg_691_0)
			if arg_691_0 == 1 then
				arg_689_0:Play320061167(arg_689_1)
			end
		end

		function arg_689_1.onSingleLineUpdate_(arg_692_0)
			local var_692_0 = 0
			local var_692_1 = 0.175

			if var_692_0 < arg_689_1.time_ and arg_689_1.time_ <= var_692_0 + arg_692_0 then
				arg_689_1.talkMaxDuration = 0
				arg_689_1.dialogCg_.alpha = 1

				arg_689_1.dialog_:SetActive(true)
				SetActive(arg_689_1.leftNameGo_, true)

				local var_692_2 = arg_689_1:FormatText(StoryNameCfg[36].name)

				arg_689_1.leftNameTxt_.text = var_692_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_689_1.leftNameTxt_.transform)

				arg_689_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_689_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_689_1:RecordName(arg_689_1.leftNameTxt_.text)
				SetActive(arg_689_1.iconTrs_.gameObject, true)
				arg_689_1.iconController_:SetSelectedState("hero")

				arg_689_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1111_1")

				arg_689_1.callingController_:SetSelectedState("normal")

				arg_689_1.keyicon_.color = Color.New(1, 1, 1)
				arg_689_1.icon_.color = Color.New(1, 1, 1)

				local var_692_3 = arg_689_1:GetWordFromCfg(320061166)
				local var_692_4 = arg_689_1:FormatText(var_692_3.content)

				arg_689_1.text_.text = var_692_4

				LuaForUtil.ClearLinePrefixSymbol(arg_689_1.text_)

				local var_692_5 = 7
				local var_692_6 = utf8.len(var_692_4)
				local var_692_7 = var_692_5 <= 0 and var_692_1 or var_692_1 * (var_692_6 / var_692_5)

				if var_692_7 > 0 and var_692_1 < var_692_7 then
					arg_689_1.talkMaxDuration = var_692_7

					if var_692_7 + var_692_0 > arg_689_1.duration_ then
						arg_689_1.duration_ = var_692_7 + var_692_0
					end
				end

				arg_689_1.text_.text = var_692_4
				arg_689_1.typewritter.percent = 0

				arg_689_1.typewritter:SetDirty()
				arg_689_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320061", "320061166", "story_v_out_320061.awb") ~= 0 then
					local var_692_8 = manager.audio:GetVoiceLength("story_v_out_320061", "320061166", "story_v_out_320061.awb") / 1000

					if var_692_8 + var_692_0 > arg_689_1.duration_ then
						arg_689_1.duration_ = var_692_8 + var_692_0
					end

					if var_692_3.prefab_name ~= "" and arg_689_1.actors_[var_692_3.prefab_name] ~= nil then
						local var_692_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_689_1.actors_[var_692_3.prefab_name].transform, "story_v_out_320061", "320061166", "story_v_out_320061.awb")

						arg_689_1:RecordAudio("320061166", var_692_9)
						arg_689_1:RecordAudio("320061166", var_692_9)
					else
						arg_689_1:AudioAction("play", "voice", "story_v_out_320061", "320061166", "story_v_out_320061.awb")
					end

					arg_689_1:RecordHistoryTalkVoice("story_v_out_320061", "320061166", "story_v_out_320061.awb")
				end

				arg_689_1:RecordContent(arg_689_1.text_.text)
			end

			local var_692_10 = math.max(var_692_1, arg_689_1.talkMaxDuration)

			if var_692_0 <= arg_689_1.time_ and arg_689_1.time_ < var_692_0 + var_692_10 then
				arg_689_1.typewritter.percent = (arg_689_1.time_ - var_692_0) / var_692_10

				arg_689_1.typewritter:SetDirty()
			end

			if arg_689_1.time_ >= var_692_0 + var_692_10 and arg_689_1.time_ < var_692_0 + var_692_10 + arg_692_0 then
				arg_689_1.typewritter.percent = 1

				arg_689_1.typewritter:SetDirty()
				arg_689_1:ShowNextGo(true)
			end
		end

		arg_689_1.nodeConfigList_ = {}

		arg_689_1:InitPlayNodeList()
	end,
	Play320061167 = function(arg_693_0, arg_693_1)
		arg_693_1.time_ = 0
		arg_693_1.frameCnt_ = 0
		arg_693_1.state_ = "playing"
		arg_693_1.curTalkId_ = 320061167
		arg_693_1.duration_ = 4.5

		local var_693_0 = {
			zh = 4.5,
			ja = 1.933
		}
		local var_693_1 = manager.audio:GetLocalizationFlag()

		if var_693_0[var_693_1] ~= nil then
			arg_693_1.duration_ = var_693_0[var_693_1]
		end

		SetActive(arg_693_1.tipsGo_, false)

		function arg_693_1.onSingleLineFinish_()
			arg_693_1.onSingleLineUpdate_ = nil
			arg_693_1.onSingleLineFinish_ = nil
			arg_693_1.state_ = "waiting"
		end

		function arg_693_1.playNext_(arg_695_0)
			if arg_695_0 == 1 then
				arg_693_0:Play320061168(arg_693_1)
			end
		end

		function arg_693_1.onSingleLineUpdate_(arg_696_0)
			local var_696_0 = 0
			local var_696_1 = 0.2

			if var_696_0 < arg_693_1.time_ and arg_693_1.time_ <= var_696_0 + arg_696_0 then
				arg_693_1.talkMaxDuration = 0
				arg_693_1.dialogCg_.alpha = 1

				arg_693_1.dialog_:SetActive(true)
				SetActive(arg_693_1.leftNameGo_, true)

				local var_696_2 = arg_693_1:FormatText(StoryNameCfg[36].name)

				arg_693_1.leftNameTxt_.text = var_696_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_693_1.leftNameTxt_.transform)

				arg_693_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_693_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_693_1:RecordName(arg_693_1.leftNameTxt_.text)
				SetActive(arg_693_1.iconTrs_.gameObject, true)
				arg_693_1.iconController_:SetSelectedState("hero")

				arg_693_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_693_1.callingController_:SetSelectedState("normal")

				arg_693_1.keyicon_.color = Color.New(1, 1, 1)
				arg_693_1.icon_.color = Color.New(1, 1, 1)

				local var_696_3 = arg_693_1:GetWordFromCfg(320061167)
				local var_696_4 = arg_693_1:FormatText(var_696_3.content)

				arg_693_1.text_.text = var_696_4

				LuaForUtil.ClearLinePrefixSymbol(arg_693_1.text_)

				local var_696_5 = 8
				local var_696_6 = utf8.len(var_696_4)
				local var_696_7 = var_696_5 <= 0 and var_696_1 or var_696_1 * (var_696_6 / var_696_5)

				if var_696_7 > 0 and var_696_1 < var_696_7 then
					arg_693_1.talkMaxDuration = var_696_7

					if var_696_7 + var_696_0 > arg_693_1.duration_ then
						arg_693_1.duration_ = var_696_7 + var_696_0
					end
				end

				arg_693_1.text_.text = var_696_4
				arg_693_1.typewritter.percent = 0

				arg_693_1.typewritter:SetDirty()
				arg_693_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320061", "320061167", "story_v_out_320061.awb") ~= 0 then
					local var_696_8 = manager.audio:GetVoiceLength("story_v_out_320061", "320061167", "story_v_out_320061.awb") / 1000

					if var_696_8 + var_696_0 > arg_693_1.duration_ then
						arg_693_1.duration_ = var_696_8 + var_696_0
					end

					if var_696_3.prefab_name ~= "" and arg_693_1.actors_[var_696_3.prefab_name] ~= nil then
						local var_696_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_693_1.actors_[var_696_3.prefab_name].transform, "story_v_out_320061", "320061167", "story_v_out_320061.awb")

						arg_693_1:RecordAudio("320061167", var_696_9)
						arg_693_1:RecordAudio("320061167", var_696_9)
					else
						arg_693_1:AudioAction("play", "voice", "story_v_out_320061", "320061167", "story_v_out_320061.awb")
					end

					arg_693_1:RecordHistoryTalkVoice("story_v_out_320061", "320061167", "story_v_out_320061.awb")
				end

				arg_693_1:RecordContent(arg_693_1.text_.text)
			end

			local var_696_10 = math.max(var_696_1, arg_693_1.talkMaxDuration)

			if var_696_0 <= arg_693_1.time_ and arg_693_1.time_ < var_696_0 + var_696_10 then
				arg_693_1.typewritter.percent = (arg_693_1.time_ - var_696_0) / var_696_10

				arg_693_1.typewritter:SetDirty()
			end

			if arg_693_1.time_ >= var_696_0 + var_696_10 and arg_693_1.time_ < var_696_0 + var_696_10 + arg_696_0 then
				arg_693_1.typewritter.percent = 1

				arg_693_1.typewritter:SetDirty()
				arg_693_1:ShowNextGo(true)
			end
		end

		arg_693_1.nodeConfigList_ = {}

		arg_693_1:InitPlayNodeList()
	end,
	Play320061168 = function(arg_697_0, arg_697_1)
		arg_697_1.time_ = 0
		arg_697_1.frameCnt_ = 0
		arg_697_1.state_ = "playing"
		arg_697_1.curTalkId_ = 320061168
		arg_697_1.duration_ = 5

		SetActive(arg_697_1.tipsGo_, false)

		function arg_697_1.onSingleLineFinish_()
			arg_697_1.onSingleLineUpdate_ = nil
			arg_697_1.onSingleLineFinish_ = nil
			arg_697_1.state_ = "waiting"
		end

		function arg_697_1.playNext_(arg_699_0)
			if arg_699_0 == 1 then
				arg_697_0:Play320061169(arg_697_1)
			end
		end

		function arg_697_1.onSingleLineUpdate_(arg_700_0)
			local var_700_0 = manager.ui.mainCamera.transform
			local var_700_1 = 0

			if var_700_1 < arg_697_1.time_ and arg_697_1.time_ <= var_700_1 + arg_700_0 then
				local var_700_2 = arg_697_1.var_.effectxuanyun1
				local var_700_3
				local var_700_4 = var_700_0

				if not var_700_2 then
					var_700_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ripple"), var_700_4)
					var_700_2.name = "xuanyun1"
					arg_697_1.var_.effectxuanyun1 = var_700_2
				else
					var_700_2.transform:SetParent(var_700_4)
				end

				var_700_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_700_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_700_5 = 0
			local var_700_6 = 1.825

			if var_700_5 < arg_697_1.time_ and arg_697_1.time_ <= var_700_5 + arg_700_0 then
				arg_697_1.talkMaxDuration = 0
				arg_697_1.dialogCg_.alpha = 1

				arg_697_1.dialog_:SetActive(true)
				SetActive(arg_697_1.leftNameGo_, false)

				arg_697_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_697_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_697_1:RecordName(arg_697_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_697_1.iconTrs_.gameObject, false)
				arg_697_1.callingController_:SetSelectedState("normal")

				local var_700_7 = arg_697_1:GetWordFromCfg(320061168)
				local var_700_8 = arg_697_1:FormatText(var_700_7.content)

				arg_697_1.text_.text = var_700_8

				LuaForUtil.ClearLinePrefixSymbol(arg_697_1.text_)

				local var_700_9 = 73
				local var_700_10 = utf8.len(var_700_8)
				local var_700_11 = var_700_9 <= 0 and var_700_6 or var_700_6 * (var_700_10 / var_700_9)

				if var_700_11 > 0 and var_700_6 < var_700_11 then
					arg_697_1.talkMaxDuration = var_700_11

					if var_700_11 + var_700_5 > arg_697_1.duration_ then
						arg_697_1.duration_ = var_700_11 + var_700_5
					end
				end

				arg_697_1.text_.text = var_700_8
				arg_697_1.typewritter.percent = 0

				arg_697_1.typewritter:SetDirty()
				arg_697_1:ShowNextGo(false)
				arg_697_1:RecordContent(arg_697_1.text_.text)
			end

			local var_700_12 = math.max(var_700_6, arg_697_1.talkMaxDuration)

			if var_700_5 <= arg_697_1.time_ and arg_697_1.time_ < var_700_5 + var_700_12 then
				arg_697_1.typewritter.percent = (arg_697_1.time_ - var_700_5) / var_700_12

				arg_697_1.typewritter:SetDirty()
			end

			if arg_697_1.time_ >= var_700_5 + var_700_12 and arg_697_1.time_ < var_700_5 + var_700_12 + arg_700_0 then
				arg_697_1.typewritter.percent = 1

				arg_697_1.typewritter:SetDirty()
				arg_697_1:ShowNextGo(true)
			end
		end

		arg_697_1.nodeConfigList_ = {}

		arg_697_1:InitPlayNodeList()
	end,
	Play320061169 = function(arg_701_0, arg_701_1)
		arg_701_1.time_ = 0
		arg_701_1.frameCnt_ = 0
		arg_701_1.state_ = "playing"
		arg_701_1.curTalkId_ = 320061169
		arg_701_1.duration_ = 5

		SetActive(arg_701_1.tipsGo_, false)

		function arg_701_1.onSingleLineFinish_()
			arg_701_1.onSingleLineUpdate_ = nil
			arg_701_1.onSingleLineFinish_ = nil
			arg_701_1.state_ = "waiting"
		end

		function arg_701_1.playNext_(arg_703_0)
			if arg_703_0 == 1 then
				arg_701_0:Play320061170(arg_701_1)
			end
		end

		function arg_701_1.onSingleLineUpdate_(arg_704_0)
			local var_704_0 = 0
			local var_704_1 = 1.125

			if var_704_0 < arg_701_1.time_ and arg_701_1.time_ <= var_704_0 + arg_704_0 then
				arg_701_1.talkMaxDuration = 0
				arg_701_1.dialogCg_.alpha = 1

				arg_701_1.dialog_:SetActive(true)
				SetActive(arg_701_1.leftNameGo_, false)

				arg_701_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_701_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_701_1:RecordName(arg_701_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_701_1.iconTrs_.gameObject, false)
				arg_701_1.callingController_:SetSelectedState("normal")

				local var_704_2 = arg_701_1:GetWordFromCfg(320061169)
				local var_704_3 = arg_701_1:FormatText(var_704_2.content)

				arg_701_1.text_.text = var_704_3

				LuaForUtil.ClearLinePrefixSymbol(arg_701_1.text_)

				local var_704_4 = 45
				local var_704_5 = utf8.len(var_704_3)
				local var_704_6 = var_704_4 <= 0 and var_704_1 or var_704_1 * (var_704_5 / var_704_4)

				if var_704_6 > 0 and var_704_1 < var_704_6 then
					arg_701_1.talkMaxDuration = var_704_6

					if var_704_6 + var_704_0 > arg_701_1.duration_ then
						arg_701_1.duration_ = var_704_6 + var_704_0
					end
				end

				arg_701_1.text_.text = var_704_3
				arg_701_1.typewritter.percent = 0

				arg_701_1.typewritter:SetDirty()
				arg_701_1:ShowNextGo(false)
				arg_701_1:RecordContent(arg_701_1.text_.text)
			end

			local var_704_7 = math.max(var_704_1, arg_701_1.talkMaxDuration)

			if var_704_0 <= arg_701_1.time_ and arg_701_1.time_ < var_704_0 + var_704_7 then
				arg_701_1.typewritter.percent = (arg_701_1.time_ - var_704_0) / var_704_7

				arg_701_1.typewritter:SetDirty()
			end

			if arg_701_1.time_ >= var_704_0 + var_704_7 and arg_701_1.time_ < var_704_0 + var_704_7 + arg_704_0 then
				arg_701_1.typewritter.percent = 1

				arg_701_1.typewritter:SetDirty()
				arg_701_1:ShowNextGo(true)
			end
		end

		arg_701_1.nodeConfigList_ = {}

		arg_701_1:InitPlayNodeList()
	end,
	Play320061170 = function(arg_705_0, arg_705_1)
		arg_705_1.time_ = 0
		arg_705_1.frameCnt_ = 0
		arg_705_1.state_ = "playing"
		arg_705_1.curTalkId_ = 320061170
		arg_705_1.duration_ = 6.63

		SetActive(arg_705_1.tipsGo_, false)

		function arg_705_1.onSingleLineFinish_()
			arg_705_1.onSingleLineUpdate_ = nil
			arg_705_1.onSingleLineFinish_ = nil
			arg_705_1.state_ = "waiting"
			arg_705_1.auto_ = false
		end

		function arg_705_1.playNext_(arg_707_0)
			arg_705_1.onStoryFinished_()
		end

		function arg_705_1.onSingleLineUpdate_(arg_708_0)
			local var_708_0 = 1

			if var_708_0 < arg_705_1.time_ and arg_705_1.time_ <= var_708_0 + arg_708_0 then
				local var_708_1 = manager.ui.mainCamera.transform.localPosition
				local var_708_2 = Vector3.New(0, 0, 10) + Vector3.New(var_708_1.x, var_708_1.y, 0)
				local var_708_3 = arg_705_1.bgs_.STblack

				var_708_3.transform.localPosition = var_708_2
				var_708_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_708_4 = var_708_3:GetComponent("SpriteRenderer")

				if var_708_4 and var_708_4.sprite then
					local var_708_5 = (var_708_3.transform.localPosition - var_708_1).z
					local var_708_6 = manager.ui.mainCameraCom_
					local var_708_7 = 2 * var_708_5 * Mathf.Tan(var_708_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_708_8 = var_708_7 * var_708_6.aspect
					local var_708_9 = var_708_4.sprite.bounds.size.x
					local var_708_10 = var_708_4.sprite.bounds.size.y
					local var_708_11 = var_708_8 / var_708_9
					local var_708_12 = var_708_7 / var_708_10
					local var_708_13 = var_708_12 < var_708_11 and var_708_11 or var_708_12

					var_708_3.transform.localScale = Vector3.New(var_708_13, var_708_13, 0)
				end

				for iter_708_0, iter_708_1 in pairs(arg_705_1.bgs_) do
					if iter_708_0 ~= "STblack" then
						iter_708_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_708_14 = 0

			if var_708_14 < arg_705_1.time_ and arg_705_1.time_ <= var_708_14 + arg_708_0 then
				arg_705_1.mask_.enabled = true
				arg_705_1.mask_.raycastTarget = true

				arg_705_1:SetGaussion(false)
			end

			local var_708_15 = 1

			if var_708_14 <= arg_705_1.time_ and arg_705_1.time_ < var_708_14 + var_708_15 then
				local var_708_16 = (arg_705_1.time_ - var_708_14) / var_708_15
				local var_708_17 = Color.New(0, 0, 0)

				var_708_17.a = Mathf.Lerp(0, 1, var_708_16)
				arg_705_1.mask_.color = var_708_17
			end

			if arg_705_1.time_ >= var_708_14 + var_708_15 and arg_705_1.time_ < var_708_14 + var_708_15 + arg_708_0 then
				local var_708_18 = Color.New(0, 0, 0)

				var_708_18.a = 1
				arg_705_1.mask_.color = var_708_18
			end

			local var_708_19 = 1

			if var_708_19 < arg_705_1.time_ and arg_705_1.time_ <= var_708_19 + arg_708_0 then
				arg_705_1.mask_.enabled = true
				arg_705_1.mask_.raycastTarget = true

				arg_705_1:SetGaussion(false)
			end

			local var_708_20 = 1

			if var_708_19 <= arg_705_1.time_ and arg_705_1.time_ < var_708_19 + var_708_20 then
				local var_708_21 = (arg_705_1.time_ - var_708_19) / var_708_20
				local var_708_22 = Color.New(0, 0, 0)

				var_708_22.a = Mathf.Lerp(1, 0, var_708_21)
				arg_705_1.mask_.color = var_708_22
			end

			if arg_705_1.time_ >= var_708_19 + var_708_20 and arg_705_1.time_ < var_708_19 + var_708_20 + arg_708_0 then
				local var_708_23 = Color.New(0, 0, 0)
				local var_708_24 = 0

				arg_705_1.mask_.enabled = false
				var_708_23.a = var_708_24
				arg_705_1.mask_.color = var_708_23
			end

			local var_708_25
			local var_708_26 = 1

			if var_708_26 < arg_705_1.time_ and arg_705_1.time_ <= var_708_26 + arg_708_0 then
				local var_708_27 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_708_27 then
					var_708_27.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_708_27.radialBlurScale = 0
					var_708_27.radialBlurGradient = 1
					var_708_27.radialBlurIntensity = 1

					if var_708_25 then
						var_708_27.radialBlurTarget = var_708_25.transform
					end
				end
			end

			local var_708_28 = 1

			if var_708_26 <= arg_705_1.time_ and arg_705_1.time_ < var_708_26 + var_708_28 then
				local var_708_29 = (arg_705_1.time_ - var_708_26) / var_708_28
				local var_708_30 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_708_30 then
					var_708_30.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_708_30.radialBlurScale = Mathf.Lerp(0, 0, var_708_29)
					var_708_30.radialBlurGradient = Mathf.Lerp(1, 1, var_708_29)
					var_708_30.radialBlurIntensity = Mathf.Lerp(1, 1, var_708_29)
				end
			end

			if arg_705_1.time_ >= var_708_26 + var_708_28 and arg_705_1.time_ < var_708_26 + var_708_28 + arg_708_0 then
				local var_708_31 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_708_31 then
					var_708_31.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_708_31.radialBlurScale = 0
					var_708_31.radialBlurGradient = 1
					var_708_31.radialBlurIntensity = 1
				end
			end

			local var_708_32 = 0.3
			local var_708_33 = 1

			if var_708_32 < arg_705_1.time_ and arg_705_1.time_ <= var_708_32 + arg_708_0 then
				local var_708_34 = "play"
				local var_708_35 = "effect"

				arg_705_1:AudioAction(var_708_34, var_708_35, "se_story_side_1094", "se_story_1094_gun", "")
			end

			if arg_705_1.frameCnt_ <= 1 then
				arg_705_1.dialog_:SetActive(false)
			end

			local var_708_36 = 1.63333333333333
			local var_708_37 = 1.575

			if var_708_36 < arg_705_1.time_ and arg_705_1.time_ <= var_708_36 + arg_708_0 then
				arg_705_1.talkMaxDuration = 0

				arg_705_1.dialog_:SetActive(true)

				arg_705_1.dialogCg_.alpha = 0

				local var_708_38 = LeanTween.value(arg_705_1.dialog_, 0, 1, 0.3)

				var_708_38:setOnUpdate(LuaHelper.FloatAction(function(arg_709_0)
					arg_705_1.dialogCg_.alpha = arg_709_0
				end))
				var_708_38:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_705_1.dialog_)
					var_708_38:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_705_1.duration_ = arg_705_1.duration_ + 0.3

				SetActive(arg_705_1.leftNameGo_, false)

				arg_705_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_705_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_705_1:RecordName(arg_705_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_705_1.iconTrs_.gameObject, false)
				arg_705_1.callingController_:SetSelectedState("normal")

				local var_708_39 = arg_705_1:GetWordFromCfg(320061170)
				local var_708_40 = arg_705_1:FormatText(var_708_39.content)

				arg_705_1.text_.text = var_708_40

				LuaForUtil.ClearLinePrefixSymbol(arg_705_1.text_)

				local var_708_41 = 63
				local var_708_42 = utf8.len(var_708_40)
				local var_708_43 = var_708_41 <= 0 and var_708_37 or var_708_37 * (var_708_42 / var_708_41)

				if var_708_43 > 0 and var_708_37 < var_708_43 then
					arg_705_1.talkMaxDuration = var_708_43
					var_708_36 = var_708_36 + 0.3

					if var_708_43 + var_708_36 > arg_705_1.duration_ then
						arg_705_1.duration_ = var_708_43 + var_708_36
					end
				end

				arg_705_1.text_.text = var_708_40
				arg_705_1.typewritter.percent = 0

				arg_705_1.typewritter:SetDirty()
				arg_705_1:ShowNextGo(false)
				arg_705_1:RecordContent(arg_705_1.text_.text)
			end

			local var_708_44 = var_708_36 + 0.3
			local var_708_45 = math.max(var_708_37, arg_705_1.talkMaxDuration)

			if var_708_44 <= arg_705_1.time_ and arg_705_1.time_ < var_708_44 + var_708_45 then
				arg_705_1.typewritter.percent = (arg_705_1.time_ - var_708_44) / var_708_45

				arg_705_1.typewritter:SetDirty()
			end

			if arg_705_1.time_ >= var_708_44 + var_708_45 and arg_705_1.time_ < var_708_44 + var_708_45 + arg_708_0 then
				arg_705_1.typewritter.percent = 1

				arg_705_1.typewritter:SetDirty()
				arg_705_1:ShowNextGo(true)
			end
		end

		arg_705_1.nodeConfigList_ = {}

		arg_705_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST61",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/XS0102",
		"TextureConfig/Background/ST12",
		"TextureConfig/Background/ST0503"
	},
	voices = {
		"story_v_out_320061.awb"
	}
}
