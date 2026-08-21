return {
	Play321091001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 321091001
		arg_1_1.duration_ = 5.4

		local var_1_0 = {
			zh = 3.9,
			ja = 5.4
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
				arg_1_0:Play321091002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST73"

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
				local var_4_5 = arg_1_1.bgs_.ST73

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
					if iter_4_0 ~= "ST73" then
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

			local var_4_24 = arg_1_1.actors_.ui_story
			local var_4_25 = 0

			if var_4_25 < arg_1_1.time_ and arg_1_1.time_ <= var_4_25 + arg_4_0 and not isNil(var_4_24) and arg_1_1.var_.characterEffectui_story == nil then
				arg_1_1.var_.characterEffectui_story = var_4_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_26 = 0.200000002980232

			if var_4_25 <= arg_1_1.time_ and arg_1_1.time_ < var_4_25 + var_4_26 and not isNil(var_4_24) then
				local var_4_27 = (arg_1_1.time_ - var_4_25) / var_4_26

				if arg_1_1.var_.characterEffectui_story and not isNil(var_4_24) then
					arg_1_1.var_.characterEffectui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_25 + var_4_26 and arg_1_1.time_ < var_4_25 + var_4_26 + arg_4_0 and not isNil(var_4_24) and arg_1_1.var_.characterEffectui_story then
				arg_1_1.var_.characterEffectui_story.fillFlat = false
			end

			local var_4_28 = 0

			arg_1_1.isInRecall_ = false

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				arg_1_1.screenFilterGo_:SetActive(true)

				arg_1_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")

				for iter_4_2, iter_4_3 in pairs(arg_1_1.actors_) do
					local var_4_29 = iter_4_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_4_4, iter_4_5 in ipairs(var_4_29) do
						if iter_4_5.color.r > 0.51 then
							iter_4_5.color = Color.New(1, 1, 1)
						else
							iter_4_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_4_30 = 0.0666666666666667

			if var_4_28 <= arg_1_1.time_ and arg_1_1.time_ < var_4_28 + var_4_30 then
				local var_4_31 = (arg_1_1.time_ - var_4_28) / var_4_30

				arg_1_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, var_4_31)
			end

			if arg_1_1.time_ >= var_4_28 + var_4_30 and arg_1_1.time_ < var_4_28 + var_4_30 + arg_4_0 then
				arg_1_1.screenFilterEffect_.weight = 1
			end

			local var_4_32 = 0
			local var_4_33 = 0.2

			if var_4_32 < arg_1_1.time_ and arg_1_1.time_ <= var_4_32 + arg_4_0 then
				local var_4_34 = "play"
				local var_4_35 = "music"

				arg_1_1:AudioAction(var_4_34, var_4_35, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_36 = ""
				local var_4_37 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

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

			local var_4_38 = 0.3
			local var_4_39 = 1

			if var_4_38 < arg_1_1.time_ and arg_1_1.time_ <= var_4_38 + arg_4_0 then
				local var_4_40 = "play"
				local var_4_41 = "music"

				arg_1_1:AudioAction(var_4_40, var_4_41, "bgm_activity_4_0_story_quake_unsettled", "bgm_activity_4_0_story_quake_unsettled", "bgm_activity_4_0_story_quake_unsettled.awb")

				local var_4_42 = ""
				local var_4_43 = manager.audio:GetAudioName("bgm_activity_4_0_story_quake_unsettled", "bgm_activity_4_0_story_quake_unsettled")

				if var_4_43 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_43 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_43

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_43
						arg_1_1.bgmTxt2_.text = var_4_43
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

			local var_4_44 = 2
			local var_4_45 = 0.2

			if var_4_44 < arg_1_1.time_ and arg_1_1.time_ <= var_4_44 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_46 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_46:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_46:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_46:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_47 = arg_1_1:FormatText(StoryNameCfg[546].name)

				arg_1_1.leftNameTxt_.text = var_4_47

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10010")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_1_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_4_48 = arg_1_1:GetWordFromCfg(321091001)
				local var_4_49 = arg_1_1:FormatText(var_4_48.content)

				arg_1_1.text_.text = var_4_49

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_50 = 8
				local var_4_51 = utf8.len(var_4_49)
				local var_4_52 = var_4_50 <= 0 and var_4_45 or var_4_45 * (var_4_51 / var_4_50)

				if var_4_52 > 0 and var_4_45 < var_4_52 then
					arg_1_1.talkMaxDuration = var_4_52
					var_4_44 = var_4_44 + 0.3

					if var_4_52 + var_4_44 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_52 + var_4_44
					end
				end

				arg_1_1.text_.text = var_4_49
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091001", "story_v_out_321091.awb") ~= 0 then
					local var_4_53 = manager.audio:GetVoiceLength("story_v_out_321091", "321091001", "story_v_out_321091.awb") / 1000

					if var_4_53 + var_4_44 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_53 + var_4_44
					end

					if var_4_48.prefab_name ~= "" and arg_1_1.actors_[var_4_48.prefab_name] ~= nil then
						local var_4_54 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_48.prefab_name].transform, "story_v_out_321091", "321091001", "story_v_out_321091.awb")

						arg_1_1:RecordAudio("321091001", var_4_54)
						arg_1_1:RecordAudio("321091001", var_4_54)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_321091", "321091001", "story_v_out_321091.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_321091", "321091001", "story_v_out_321091.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_55 = var_4_44 + 0.3
			local var_4_56 = math.max(var_4_45, arg_1_1.talkMaxDuration)

			if var_4_55 <= arg_1_1.time_ and arg_1_1.time_ < var_4_55 + var_4_56 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_55) / var_4_56

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_55 + var_4_56 and arg_1_1.time_ < var_4_55 + var_4_56 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play321091002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 321091002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play321091003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 0.975

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

				local var_12_2 = arg_9_1:GetWordFromCfg(321091002)
				local var_12_3 = arg_9_1:FormatText(var_12_2.content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 39
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
	Play321091003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 321091003
		arg_13_1.duration_ = 5.33

		local var_13_0 = {
			zh = 3.6,
			ja = 5.333
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
				arg_13_0:Play321091004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = "10104ui_story"

			if arg_13_1.actors_[var_16_0] == nil then
				local var_16_1 = Asset.Load("Char/" .. "10104ui_story")

				if not isNil(var_16_1) then
					local var_16_2 = Object.Instantiate(Asset.Load("Char/" .. "10104ui_story"), arg_13_1.stage_.transform)

					var_16_2.name = var_16_0
					var_16_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_13_1.actors_[var_16_0] = var_16_2

					local var_16_3 = var_16_2:GetComponentInChildren(typeof(CharacterEffect))

					var_16_3.enabled = true

					local var_16_4 = GameObjectTools.GetOrAddComponent(var_16_2, typeof(DynamicBoneHelper))

					if var_16_4 then
						var_16_4:EnableDynamicBone(false)
					end

					arg_13_1:ShowWeapon(var_16_3.transform, false)

					arg_13_1.var_[var_16_0 .. "Animator"] = var_16_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_13_1.var_[var_16_0 .. "Animator"].applyRootMotion = true
					arg_13_1.var_[var_16_0 .. "LipSync"] = var_16_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_16_5 = arg_13_1.actors_["10104ui_story"].transform
			local var_16_6 = 0

			if var_16_6 < arg_13_1.time_ and arg_13_1.time_ <= var_16_6 + arg_16_0 then
				arg_13_1.var_.moveOldPos10104ui_story = var_16_5.localPosition
			end

			local var_16_7 = 0.001

			if var_16_6 <= arg_13_1.time_ and arg_13_1.time_ < var_16_6 + var_16_7 then
				local var_16_8 = (arg_13_1.time_ - var_16_6) / var_16_7
				local var_16_9 = Vector3.New(0.02, -1.12, -5.99)

				var_16_5.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos10104ui_story, var_16_9, var_16_8)

				local var_16_10 = manager.ui.mainCamera.transform.position - var_16_5.position

				var_16_5.forward = Vector3.New(var_16_10.x, var_16_10.y, var_16_10.z)

				local var_16_11 = var_16_5.localEulerAngles

				var_16_11.z = 0
				var_16_11.x = 0
				var_16_5.localEulerAngles = var_16_11
			end

			if arg_13_1.time_ >= var_16_6 + var_16_7 and arg_13_1.time_ < var_16_6 + var_16_7 + arg_16_0 then
				var_16_5.localPosition = Vector3.New(0.02, -1.12, -5.99)

				local var_16_12 = manager.ui.mainCamera.transform.position - var_16_5.position

				var_16_5.forward = Vector3.New(var_16_12.x, var_16_12.y, var_16_12.z)

				local var_16_13 = var_16_5.localEulerAngles

				var_16_13.z = 0
				var_16_13.x = 0
				var_16_5.localEulerAngles = var_16_13
			end

			local var_16_14 = arg_13_1.actors_["10104ui_story"]
			local var_16_15 = 0

			if var_16_15 < arg_13_1.time_ and arg_13_1.time_ <= var_16_15 + arg_16_0 and not isNil(var_16_14) and arg_13_1.var_.characterEffect10104ui_story == nil then
				arg_13_1.var_.characterEffect10104ui_story = var_16_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_16 = 0.200000002980232

			if var_16_15 <= arg_13_1.time_ and arg_13_1.time_ < var_16_15 + var_16_16 and not isNil(var_16_14) then
				local var_16_17 = (arg_13_1.time_ - var_16_15) / var_16_16

				if arg_13_1.var_.characterEffect10104ui_story and not isNil(var_16_14) then
					arg_13_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= var_16_15 + var_16_16 and arg_13_1.time_ < var_16_15 + var_16_16 + arg_16_0 and not isNil(var_16_14) and arg_13_1.var_.characterEffect10104ui_story then
				arg_13_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_16_18 = 0

			if var_16_18 < arg_13_1.time_ and arg_13_1.time_ <= var_16_18 + arg_16_0 then
				arg_13_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action1_1")
			end

			local var_16_19 = 0

			if var_16_19 < arg_13_1.time_ and arg_13_1.time_ <= var_16_19 + arg_16_0 then
				arg_13_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_16_20 = 0
			local var_16_21 = 0.5

			if var_16_20 < arg_13_1.time_ and arg_13_1.time_ <= var_16_20 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_22 = arg_13_1:FormatText(StoryNameCfg[1030].name)

				arg_13_1.leftNameTxt_.text = var_16_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_23 = arg_13_1:GetWordFromCfg(321091003)
				local var_16_24 = arg_13_1:FormatText(var_16_23.content)

				arg_13_1.text_.text = var_16_24

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_25 = 20
				local var_16_26 = utf8.len(var_16_24)
				local var_16_27 = var_16_25 <= 0 and var_16_21 or var_16_21 * (var_16_26 / var_16_25)

				if var_16_27 > 0 and var_16_21 < var_16_27 then
					arg_13_1.talkMaxDuration = var_16_27

					if var_16_27 + var_16_20 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_27 + var_16_20
					end
				end

				arg_13_1.text_.text = var_16_24
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091003", "story_v_out_321091.awb") ~= 0 then
					local var_16_28 = manager.audio:GetVoiceLength("story_v_out_321091", "321091003", "story_v_out_321091.awb") / 1000

					if var_16_28 + var_16_20 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_28 + var_16_20
					end

					if var_16_23.prefab_name ~= "" and arg_13_1.actors_[var_16_23.prefab_name] ~= nil then
						local var_16_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_23.prefab_name].transform, "story_v_out_321091", "321091003", "story_v_out_321091.awb")

						arg_13_1:RecordAudio("321091003", var_16_29)
						arg_13_1:RecordAudio("321091003", var_16_29)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_321091", "321091003", "story_v_out_321091.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_321091", "321091003", "story_v_out_321091.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_30 = math.max(var_16_21, arg_13_1.talkMaxDuration)

			if var_16_20 <= arg_13_1.time_ and arg_13_1.time_ < var_16_20 + var_16_30 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_20) / var_16_30

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_20 + var_16_30 and arg_13_1.time_ < var_16_20 + var_16_30 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
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

		arg_13_1:InitPlayNodeList()
	end,
	Play321091004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 321091004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play321091005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["10104ui_story"]
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.characterEffect10104ui_story == nil then
				arg_17_1.var_.characterEffect10104ui_story = var_20_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_2 = 0.200000002980232

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 and not isNil(var_20_0) then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2

				if arg_17_1.var_.characterEffect10104ui_story and not isNil(var_20_0) then
					local var_20_4 = Mathf.Lerp(0, 0.5, var_20_3)

					arg_17_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_17_1.var_.characterEffect10104ui_story.fillRatio = var_20_4
				end
			end

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.characterEffect10104ui_story then
				local var_20_5 = 0.5

				arg_17_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_17_1.var_.characterEffect10104ui_story.fillRatio = var_20_5
			end

			local var_20_6 = 0
			local var_20_7 = 1.25

			if var_20_6 < arg_17_1.time_ and arg_17_1.time_ <= var_20_6 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_8 = arg_17_1:GetWordFromCfg(321091004)
				local var_20_9 = arg_17_1:FormatText(var_20_8.content)

				arg_17_1.text_.text = var_20_9

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_10 = 50
				local var_20_11 = utf8.len(var_20_9)
				local var_20_12 = var_20_10 <= 0 and var_20_7 or var_20_7 * (var_20_11 / var_20_10)

				if var_20_12 > 0 and var_20_7 < var_20_12 then
					arg_17_1.talkMaxDuration = var_20_12

					if var_20_12 + var_20_6 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_12 + var_20_6
					end
				end

				arg_17_1.text_.text = var_20_9
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_13 = math.max(var_20_7, arg_17_1.talkMaxDuration)

			if var_20_6 <= arg_17_1.time_ and arg_17_1.time_ < var_20_6 + var_20_13 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_6) / var_20_13

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_6 + var_20_13 and arg_17_1.time_ < var_20_6 + var_20_13 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play321091005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 321091005
		arg_21_1.duration_ = 6.07

		local var_21_0 = {
			zh = 4.466,
			ja = 6.066
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
				arg_21_0:Play321091006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["10104ui_story"]
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect10104ui_story == nil then
				arg_21_1.var_.characterEffect10104ui_story = var_24_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_2 = 0.200000002980232

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 and not isNil(var_24_0) then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2

				if arg_21_1.var_.characterEffect10104ui_story and not isNil(var_24_0) then
					arg_21_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect10104ui_story then
				arg_21_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_24_4 = 0
			local var_24_5 = 0.5

			if var_24_4 < arg_21_1.time_ and arg_21_1.time_ <= var_24_4 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_6 = arg_21_1:FormatText(StoryNameCfg[1030].name)

				arg_21_1.leftNameTxt_.text = var_24_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_7 = arg_21_1:GetWordFromCfg(321091005)
				local var_24_8 = arg_21_1:FormatText(var_24_7.content)

				arg_21_1.text_.text = var_24_8

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_9 = 20
				local var_24_10 = utf8.len(var_24_8)
				local var_24_11 = var_24_9 <= 0 and var_24_5 or var_24_5 * (var_24_10 / var_24_9)

				if var_24_11 > 0 and var_24_5 < var_24_11 then
					arg_21_1.talkMaxDuration = var_24_11

					if var_24_11 + var_24_4 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_11 + var_24_4
					end
				end

				arg_21_1.text_.text = var_24_8
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091005", "story_v_out_321091.awb") ~= 0 then
					local var_24_12 = manager.audio:GetVoiceLength("story_v_out_321091", "321091005", "story_v_out_321091.awb") / 1000

					if var_24_12 + var_24_4 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_12 + var_24_4
					end

					if var_24_7.prefab_name ~= "" and arg_21_1.actors_[var_24_7.prefab_name] ~= nil then
						local var_24_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_7.prefab_name].transform, "story_v_out_321091", "321091005", "story_v_out_321091.awb")

						arg_21_1:RecordAudio("321091005", var_24_13)
						arg_21_1:RecordAudio("321091005", var_24_13)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_321091", "321091005", "story_v_out_321091.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_321091", "321091005", "story_v_out_321091.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_14 = math.max(var_24_5, arg_21_1.talkMaxDuration)

			if var_24_4 <= arg_21_1.time_ and arg_21_1.time_ < var_24_4 + var_24_14 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_4) / var_24_14

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_4 + var_24_14 and arg_21_1.time_ < var_24_4 + var_24_14 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play321091006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 321091006
		arg_25_1.duration_ = 14.77

		local var_25_0 = {
			zh = 11.033,
			ja = 14.766
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
				arg_25_0:Play321091007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["10104ui_story"].transform
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.var_.moveOldPos10104ui_story = var_28_0.localPosition
			end

			local var_28_2 = 0.001

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2
				local var_28_4 = Vector3.New(0.02, -1.12, -5.99)

				var_28_0.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos10104ui_story, var_28_4, var_28_3)

				local var_28_5 = manager.ui.mainCamera.transform.position - var_28_0.position

				var_28_0.forward = Vector3.New(var_28_5.x, var_28_5.y, var_28_5.z)

				local var_28_6 = var_28_0.localEulerAngles

				var_28_6.z = 0
				var_28_6.x = 0
				var_28_0.localEulerAngles = var_28_6
			end

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 then
				var_28_0.localPosition = Vector3.New(0.02, -1.12, -5.99)

				local var_28_7 = manager.ui.mainCamera.transform.position - var_28_0.position

				var_28_0.forward = Vector3.New(var_28_7.x, var_28_7.y, var_28_7.z)

				local var_28_8 = var_28_0.localEulerAngles

				var_28_8.z = 0
				var_28_8.x = 0
				var_28_0.localEulerAngles = var_28_8
			end

			local var_28_9 = 0

			if var_28_9 < arg_25_1.time_ and arg_25_1.time_ <= var_28_9 + arg_28_0 then
				arg_25_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action2_1")
			end

			local var_28_10 = 0

			if var_28_10 < arg_25_1.time_ and arg_25_1.time_ <= var_28_10 + arg_28_0 then
				arg_25_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_28_11 = 0
			local var_28_12 = 1.375

			if var_28_11 < arg_25_1.time_ and arg_25_1.time_ <= var_28_11 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_13 = arg_25_1:FormatText(StoryNameCfg[1030].name)

				arg_25_1.leftNameTxt_.text = var_28_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_14 = arg_25_1:GetWordFromCfg(321091006)
				local var_28_15 = arg_25_1:FormatText(var_28_14.content)

				arg_25_1.text_.text = var_28_15

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_16 = 55
				local var_28_17 = utf8.len(var_28_15)
				local var_28_18 = var_28_16 <= 0 and var_28_12 or var_28_12 * (var_28_17 / var_28_16)

				if var_28_18 > 0 and var_28_12 < var_28_18 then
					arg_25_1.talkMaxDuration = var_28_18

					if var_28_18 + var_28_11 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_18 + var_28_11
					end
				end

				arg_25_1.text_.text = var_28_15
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091006", "story_v_out_321091.awb") ~= 0 then
					local var_28_19 = manager.audio:GetVoiceLength("story_v_out_321091", "321091006", "story_v_out_321091.awb") / 1000

					if var_28_19 + var_28_11 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_19 + var_28_11
					end

					if var_28_14.prefab_name ~= "" and arg_25_1.actors_[var_28_14.prefab_name] ~= nil then
						local var_28_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_14.prefab_name].transform, "story_v_out_321091", "321091006", "story_v_out_321091.awb")

						arg_25_1:RecordAudio("321091006", var_28_20)
						arg_25_1:RecordAudio("321091006", var_28_20)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_321091", "321091006", "story_v_out_321091.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_321091", "321091006", "story_v_out_321091.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_21 = math.max(var_28_12, arg_25_1.talkMaxDuration)

			if var_28_11 <= arg_25_1.time_ and arg_25_1.time_ < var_28_11 + var_28_21 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_11) / var_28_21

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_11 + var_28_21 and arg_25_1.time_ < var_28_11 + var_28_21 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
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

		arg_25_1:InitPlayNodeList()
	end,
	Play321091007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 321091007
		arg_29_1.duration_ = 10.7

		local var_29_0 = {
			zh = 7.833,
			ja = 10.7
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
				arg_29_0:Play321091008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0
			local var_32_1 = 0.875

			if var_32_0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_2 = arg_29_1:FormatText(StoryNameCfg[1030].name)

				arg_29_1.leftNameTxt_.text = var_32_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_3 = arg_29_1:GetWordFromCfg(321091007)
				local var_32_4 = arg_29_1:FormatText(var_32_3.content)

				arg_29_1.text_.text = var_32_4

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_5 = 35
				local var_32_6 = utf8.len(var_32_4)
				local var_32_7 = var_32_5 <= 0 and var_32_1 or var_32_1 * (var_32_6 / var_32_5)

				if var_32_7 > 0 and var_32_1 < var_32_7 then
					arg_29_1.talkMaxDuration = var_32_7

					if var_32_7 + var_32_0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_7 + var_32_0
					end
				end

				arg_29_1.text_.text = var_32_4
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091007", "story_v_out_321091.awb") ~= 0 then
					local var_32_8 = manager.audio:GetVoiceLength("story_v_out_321091", "321091007", "story_v_out_321091.awb") / 1000

					if var_32_8 + var_32_0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_8 + var_32_0
					end

					if var_32_3.prefab_name ~= "" and arg_29_1.actors_[var_32_3.prefab_name] ~= nil then
						local var_32_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_3.prefab_name].transform, "story_v_out_321091", "321091007", "story_v_out_321091.awb")

						arg_29_1:RecordAudio("321091007", var_32_9)
						arg_29_1:RecordAudio("321091007", var_32_9)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_321091", "321091007", "story_v_out_321091.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_321091", "321091007", "story_v_out_321091.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_10 = math.max(var_32_1, arg_29_1.talkMaxDuration)

			if var_32_0 <= arg_29_1.time_ and arg_29_1.time_ < var_32_0 + var_32_10 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_0) / var_32_10

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_0 + var_32_10 and arg_29_1.time_ < var_32_0 + var_32_10 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play321091008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 321091008
		arg_33_1.duration_ = 6.67

		local var_33_0 = {
			zh = 5.1,
			ja = 6.666
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
				arg_33_0:Play321091009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["10104ui_story"]
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect10104ui_story == nil then
				arg_33_1.var_.characterEffect10104ui_story = var_36_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_2 = 0.200000002980232

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 and not isNil(var_36_0) then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2

				if arg_33_1.var_.characterEffect10104ui_story and not isNil(var_36_0) then
					local var_36_4 = Mathf.Lerp(0, 0.5, var_36_3)

					arg_33_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_33_1.var_.characterEffect10104ui_story.fillRatio = var_36_4
				end
			end

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect10104ui_story then
				local var_36_5 = 0.5

				arg_33_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_33_1.var_.characterEffect10104ui_story.fillRatio = var_36_5
			end

			local var_36_6 = 0
			local var_36_7 = 0.625

			if var_36_6 < arg_33_1.time_ and arg_33_1.time_ <= var_36_6 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_8 = arg_33_1:FormatText(StoryNameCfg[546].name)

				arg_33_1.leftNameTxt_.text = var_36_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10010")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_33_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_36_9 = arg_33_1:GetWordFromCfg(321091008)
				local var_36_10 = arg_33_1:FormatText(var_36_9.content)

				arg_33_1.text_.text = var_36_10

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_11 = 25
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

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091008", "story_v_out_321091.awb") ~= 0 then
					local var_36_14 = manager.audio:GetVoiceLength("story_v_out_321091", "321091008", "story_v_out_321091.awb") / 1000

					if var_36_14 + var_36_6 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_14 + var_36_6
					end

					if var_36_9.prefab_name ~= "" and arg_33_1.actors_[var_36_9.prefab_name] ~= nil then
						local var_36_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_9.prefab_name].transform, "story_v_out_321091", "321091008", "story_v_out_321091.awb")

						arg_33_1:RecordAudio("321091008", var_36_15)
						arg_33_1:RecordAudio("321091008", var_36_15)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_321091", "321091008", "story_v_out_321091.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_321091", "321091008", "story_v_out_321091.awb")
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
	Play321091009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 321091009
		arg_37_1.duration_ = 4.83

		local var_37_0 = {
			zh = 3.233,
			ja = 4.833
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
				arg_37_0:Play321091010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["10104ui_story"]
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect10104ui_story == nil then
				arg_37_1.var_.characterEffect10104ui_story = var_40_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_2 = 0.200000002980232

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 and not isNil(var_40_0) then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2

				if arg_37_1.var_.characterEffect10104ui_story and not isNil(var_40_0) then
					arg_37_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect10104ui_story then
				arg_37_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_40_4 = 0
			local var_40_5 = 0.375

			if var_40_4 < arg_37_1.time_ and arg_37_1.time_ <= var_40_4 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_6 = arg_37_1:FormatText(StoryNameCfg[1030].name)

				arg_37_1.leftNameTxt_.text = var_40_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_7 = arg_37_1:GetWordFromCfg(321091009)
				local var_40_8 = arg_37_1:FormatText(var_40_7.content)

				arg_37_1.text_.text = var_40_8

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_9 = 15
				local var_40_10 = utf8.len(var_40_8)
				local var_40_11 = var_40_9 <= 0 and var_40_5 or var_40_5 * (var_40_10 / var_40_9)

				if var_40_11 > 0 and var_40_5 < var_40_11 then
					arg_37_1.talkMaxDuration = var_40_11

					if var_40_11 + var_40_4 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_11 + var_40_4
					end
				end

				arg_37_1.text_.text = var_40_8
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091009", "story_v_out_321091.awb") ~= 0 then
					local var_40_12 = manager.audio:GetVoiceLength("story_v_out_321091", "321091009", "story_v_out_321091.awb") / 1000

					if var_40_12 + var_40_4 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_12 + var_40_4
					end

					if var_40_7.prefab_name ~= "" and arg_37_1.actors_[var_40_7.prefab_name] ~= nil then
						local var_40_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_7.prefab_name].transform, "story_v_out_321091", "321091009", "story_v_out_321091.awb")

						arg_37_1:RecordAudio("321091009", var_40_13)
						arg_37_1:RecordAudio("321091009", var_40_13)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_321091", "321091009", "story_v_out_321091.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_321091", "321091009", "story_v_out_321091.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_14 = math.max(var_40_5, arg_37_1.talkMaxDuration)

			if var_40_4 <= arg_37_1.time_ and arg_37_1.time_ < var_40_4 + var_40_14 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_4) / var_40_14

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_4 + var_40_14 and arg_37_1.time_ < var_40_4 + var_40_14 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play321091010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 321091010
		arg_41_1.duration_ = 17.93

		local var_41_0 = {
			zh = 10.833,
			ja = 17.933
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
				arg_41_0:Play321091011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["10104ui_story"].transform
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 then
				arg_41_1.var_.moveOldPos10104ui_story = var_44_0.localPosition
			end

			local var_44_2 = 0.001

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2
				local var_44_4 = Vector3.New(0.02, -1.12, -5.99)

				var_44_0.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos10104ui_story, var_44_4, var_44_3)

				local var_44_5 = manager.ui.mainCamera.transform.position - var_44_0.position

				var_44_0.forward = Vector3.New(var_44_5.x, var_44_5.y, var_44_5.z)

				local var_44_6 = var_44_0.localEulerAngles

				var_44_6.z = 0
				var_44_6.x = 0
				var_44_0.localEulerAngles = var_44_6
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 then
				var_44_0.localPosition = Vector3.New(0.02, -1.12, -5.99)

				local var_44_7 = manager.ui.mainCamera.transform.position - var_44_0.position

				var_44_0.forward = Vector3.New(var_44_7.x, var_44_7.y, var_44_7.z)

				local var_44_8 = var_44_0.localEulerAngles

				var_44_8.z = 0
				var_44_8.x = 0
				var_44_0.localEulerAngles = var_44_8
			end

			local var_44_9 = 0

			if var_44_9 < arg_41_1.time_ and arg_41_1.time_ <= var_44_9 + arg_44_0 then
				arg_41_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action2_2")
			end

			local var_44_10 = 0

			if var_44_10 < arg_41_1.time_ and arg_41_1.time_ <= var_44_10 + arg_44_0 then
				arg_41_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_44_11 = 0
			local var_44_12 = 1.225

			if var_44_11 < arg_41_1.time_ and arg_41_1.time_ <= var_44_11 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_13 = arg_41_1:FormatText(StoryNameCfg[1030].name)

				arg_41_1.leftNameTxt_.text = var_44_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_14 = arg_41_1:GetWordFromCfg(321091010)
				local var_44_15 = arg_41_1:FormatText(var_44_14.content)

				arg_41_1.text_.text = var_44_15

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_16 = 49
				local var_44_17 = utf8.len(var_44_15)
				local var_44_18 = var_44_16 <= 0 and var_44_12 or var_44_12 * (var_44_17 / var_44_16)

				if var_44_18 > 0 and var_44_12 < var_44_18 then
					arg_41_1.talkMaxDuration = var_44_18

					if var_44_18 + var_44_11 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_18 + var_44_11
					end
				end

				arg_41_1.text_.text = var_44_15
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091010", "story_v_out_321091.awb") ~= 0 then
					local var_44_19 = manager.audio:GetVoiceLength("story_v_out_321091", "321091010", "story_v_out_321091.awb") / 1000

					if var_44_19 + var_44_11 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_19 + var_44_11
					end

					if var_44_14.prefab_name ~= "" and arg_41_1.actors_[var_44_14.prefab_name] ~= nil then
						local var_44_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_14.prefab_name].transform, "story_v_out_321091", "321091010", "story_v_out_321091.awb")

						arg_41_1:RecordAudio("321091010", var_44_20)
						arg_41_1:RecordAudio("321091010", var_44_20)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_321091", "321091010", "story_v_out_321091.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_321091", "321091010", "story_v_out_321091.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_21 = math.max(var_44_12, arg_41_1.talkMaxDuration)

			if var_44_11 <= arg_41_1.time_ and arg_41_1.time_ < var_44_11 + var_44_21 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_11) / var_44_21

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_11 + var_44_21 and arg_41_1.time_ < var_44_11 + var_44_21 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
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

		arg_41_1:InitPlayNodeList()
	end,
	Play321091011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 321091011
		arg_45_1.duration_ = 2.87

		local var_45_0 = {
			zh = 2.866,
			ja = 2.766
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
				arg_45_0:Play321091012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["10104ui_story"]
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect10104ui_story == nil then
				arg_45_1.var_.characterEffect10104ui_story = var_48_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_2 = 0.200000002980232

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 and not isNil(var_48_0) then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2

				if arg_45_1.var_.characterEffect10104ui_story and not isNil(var_48_0) then
					local var_48_4 = Mathf.Lerp(0, 0.5, var_48_3)

					arg_45_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_45_1.var_.characterEffect10104ui_story.fillRatio = var_48_4
				end
			end

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect10104ui_story then
				local var_48_5 = 0.5

				arg_45_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_45_1.var_.characterEffect10104ui_story.fillRatio = var_48_5
			end

			local var_48_6 = 0
			local var_48_7 = 0.225

			if var_48_6 < arg_45_1.time_ and arg_45_1.time_ <= var_48_6 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_8 = arg_45_1:FormatText(StoryNameCfg[546].name)

				arg_45_1.leftNameTxt_.text = var_48_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, true)
				arg_45_1.iconController_:SetSelectedState("hero")

				arg_45_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10010")

				arg_45_1.callingController_:SetSelectedState("normal")

				arg_45_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_45_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_48_9 = arg_45_1:GetWordFromCfg(321091011)
				local var_48_10 = arg_45_1:FormatText(var_48_9.content)

				arg_45_1.text_.text = var_48_10

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_11 = 9
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

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091011", "story_v_out_321091.awb") ~= 0 then
					local var_48_14 = manager.audio:GetVoiceLength("story_v_out_321091", "321091011", "story_v_out_321091.awb") / 1000

					if var_48_14 + var_48_6 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_14 + var_48_6
					end

					if var_48_9.prefab_name ~= "" and arg_45_1.actors_[var_48_9.prefab_name] ~= nil then
						local var_48_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_9.prefab_name].transform, "story_v_out_321091", "321091011", "story_v_out_321091.awb")

						arg_45_1:RecordAudio("321091011", var_48_15)
						arg_45_1:RecordAudio("321091011", var_48_15)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_321091", "321091011", "story_v_out_321091.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_321091", "321091011", "story_v_out_321091.awb")
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
	Play321091012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 321091012
		arg_49_1.duration_ = 7.7

		local var_49_0 = {
			zh = 6.5,
			ja = 7.7
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
				arg_49_0:Play321091013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["10104ui_story"].transform
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 then
				arg_49_1.var_.moveOldPos10104ui_story = var_52_0.localPosition
			end

			local var_52_2 = 0.001

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 then
				local var_52_3 = (arg_49_1.time_ - var_52_1) / var_52_2
				local var_52_4 = Vector3.New(0.02, -1.12, -5.99)

				var_52_0.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos10104ui_story, var_52_4, var_52_3)

				local var_52_5 = manager.ui.mainCamera.transform.position - var_52_0.position

				var_52_0.forward = Vector3.New(var_52_5.x, var_52_5.y, var_52_5.z)

				local var_52_6 = var_52_0.localEulerAngles

				var_52_6.z = 0
				var_52_6.x = 0
				var_52_0.localEulerAngles = var_52_6
			end

			if arg_49_1.time_ >= var_52_1 + var_52_2 and arg_49_1.time_ < var_52_1 + var_52_2 + arg_52_0 then
				var_52_0.localPosition = Vector3.New(0.02, -1.12, -5.99)

				local var_52_7 = manager.ui.mainCamera.transform.position - var_52_0.position

				var_52_0.forward = Vector3.New(var_52_7.x, var_52_7.y, var_52_7.z)

				local var_52_8 = var_52_0.localEulerAngles

				var_52_8.z = 0
				var_52_8.x = 0
				var_52_0.localEulerAngles = var_52_8
			end

			local var_52_9 = arg_49_1.actors_["10104ui_story"]
			local var_52_10 = 0

			if var_52_10 < arg_49_1.time_ and arg_49_1.time_ <= var_52_10 + arg_52_0 and not isNil(var_52_9) and arg_49_1.var_.characterEffect10104ui_story == nil then
				arg_49_1.var_.characterEffect10104ui_story = var_52_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_11 = 0.200000002980232

			if var_52_10 <= arg_49_1.time_ and arg_49_1.time_ < var_52_10 + var_52_11 and not isNil(var_52_9) then
				local var_52_12 = (arg_49_1.time_ - var_52_10) / var_52_11

				if arg_49_1.var_.characterEffect10104ui_story and not isNil(var_52_9) then
					arg_49_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= var_52_10 + var_52_11 and arg_49_1.time_ < var_52_10 + var_52_11 + arg_52_0 and not isNil(var_52_9) and arg_49_1.var_.characterEffect10104ui_story then
				arg_49_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_52_13 = 0

			if var_52_13 < arg_49_1.time_ and arg_49_1.time_ <= var_52_13 + arg_52_0 then
				arg_49_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_52_14 = 0
			local var_52_15 = 0.875

			if var_52_14 < arg_49_1.time_ and arg_49_1.time_ <= var_52_14 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_16 = arg_49_1:FormatText(StoryNameCfg[1030].name)

				arg_49_1.leftNameTxt_.text = var_52_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_17 = arg_49_1:GetWordFromCfg(321091012)
				local var_52_18 = arg_49_1:FormatText(var_52_17.content)

				arg_49_1.text_.text = var_52_18

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_19 = 35
				local var_52_20 = utf8.len(var_52_18)
				local var_52_21 = var_52_19 <= 0 and var_52_15 or var_52_15 * (var_52_20 / var_52_19)

				if var_52_21 > 0 and var_52_15 < var_52_21 then
					arg_49_1.talkMaxDuration = var_52_21

					if var_52_21 + var_52_14 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_21 + var_52_14
					end
				end

				arg_49_1.text_.text = var_52_18
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091012", "story_v_out_321091.awb") ~= 0 then
					local var_52_22 = manager.audio:GetVoiceLength("story_v_out_321091", "321091012", "story_v_out_321091.awb") / 1000

					if var_52_22 + var_52_14 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_22 + var_52_14
					end

					if var_52_17.prefab_name ~= "" and arg_49_1.actors_[var_52_17.prefab_name] ~= nil then
						local var_52_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_17.prefab_name].transform, "story_v_out_321091", "321091012", "story_v_out_321091.awb")

						arg_49_1:RecordAudio("321091012", var_52_23)
						arg_49_1:RecordAudio("321091012", var_52_23)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_321091", "321091012", "story_v_out_321091.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_321091", "321091012", "story_v_out_321091.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_24 = math.max(var_52_15, arg_49_1.talkMaxDuration)

			if var_52_14 <= arg_49_1.time_ and arg_49_1.time_ < var_52_14 + var_52_24 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_14) / var_52_24

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_14 + var_52_24 and arg_49_1.time_ < var_52_14 + var_52_24 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
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

		arg_49_1:InitPlayNodeList()
	end,
	Play321091013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 321091013
		arg_53_1.duration_ = 17.7

		local var_53_0 = {
			zh = 10.5,
			ja = 17.7
		}
		local var_53_1 = manager.audio:GetLocalizationFlag()

		if var_53_0[var_53_1] ~= nil then
			arg_53_1.duration_ = var_53_0[var_53_1]
		end

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play321091014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0

			if var_56_0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_0 + arg_56_0 then
				arg_53_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action6_1")
			end

			local var_56_1 = 0
			local var_56_2 = 1.2

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_3 = arg_53_1:FormatText(StoryNameCfg[1030].name)

				arg_53_1.leftNameTxt_.text = var_56_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_4 = arg_53_1:GetWordFromCfg(321091013)
				local var_56_5 = arg_53_1:FormatText(var_56_4.content)

				arg_53_1.text_.text = var_56_5

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_6 = 48
				local var_56_7 = utf8.len(var_56_5)
				local var_56_8 = var_56_6 <= 0 and var_56_2 or var_56_2 * (var_56_7 / var_56_6)

				if var_56_8 > 0 and var_56_2 < var_56_8 then
					arg_53_1.talkMaxDuration = var_56_8

					if var_56_8 + var_56_1 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_8 + var_56_1
					end
				end

				arg_53_1.text_.text = var_56_5
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091013", "story_v_out_321091.awb") ~= 0 then
					local var_56_9 = manager.audio:GetVoiceLength("story_v_out_321091", "321091013", "story_v_out_321091.awb") / 1000

					if var_56_9 + var_56_1 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_9 + var_56_1
					end

					if var_56_4.prefab_name ~= "" and arg_53_1.actors_[var_56_4.prefab_name] ~= nil then
						local var_56_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_4.prefab_name].transform, "story_v_out_321091", "321091013", "story_v_out_321091.awb")

						arg_53_1:RecordAudio("321091013", var_56_10)
						arg_53_1:RecordAudio("321091013", var_56_10)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_321091", "321091013", "story_v_out_321091.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_321091", "321091013", "story_v_out_321091.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_11 = math.max(var_56_2, arg_53_1.talkMaxDuration)

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_11 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_1) / var_56_11

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_1 + var_56_11 and arg_53_1.time_ < var_56_1 + var_56_11 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play321091014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 321091014
		arg_57_1.duration_ = 20.07

		local var_57_0 = {
			zh = 11.533,
			ja = 20.066
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
				arg_57_0:Play321091015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0
			local var_60_1 = 1.375

			if var_60_0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_2 = arg_57_1:FormatText(StoryNameCfg[1030].name)

				arg_57_1.leftNameTxt_.text = var_60_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_3 = arg_57_1:GetWordFromCfg(321091014)
				local var_60_4 = arg_57_1:FormatText(var_60_3.content)

				arg_57_1.text_.text = var_60_4

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_5 = 55
				local var_60_6 = utf8.len(var_60_4)
				local var_60_7 = var_60_5 <= 0 and var_60_1 or var_60_1 * (var_60_6 / var_60_5)

				if var_60_7 > 0 and var_60_1 < var_60_7 then
					arg_57_1.talkMaxDuration = var_60_7

					if var_60_7 + var_60_0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_7 + var_60_0
					end
				end

				arg_57_1.text_.text = var_60_4
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091014", "story_v_out_321091.awb") ~= 0 then
					local var_60_8 = manager.audio:GetVoiceLength("story_v_out_321091", "321091014", "story_v_out_321091.awb") / 1000

					if var_60_8 + var_60_0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_8 + var_60_0
					end

					if var_60_3.prefab_name ~= "" and arg_57_1.actors_[var_60_3.prefab_name] ~= nil then
						local var_60_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_3.prefab_name].transform, "story_v_out_321091", "321091014", "story_v_out_321091.awb")

						arg_57_1:RecordAudio("321091014", var_60_9)
						arg_57_1:RecordAudio("321091014", var_60_9)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_321091", "321091014", "story_v_out_321091.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_321091", "321091014", "story_v_out_321091.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_10 = math.max(var_60_1, arg_57_1.talkMaxDuration)

			if var_60_0 <= arg_57_1.time_ and arg_57_1.time_ < var_60_0 + var_60_10 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_0) / var_60_10

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_0 + var_60_10 and arg_57_1.time_ < var_60_0 + var_60_10 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play321091015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 321091015
		arg_61_1.duration_ = 12.63

		local var_61_0 = {
			zh = 7.5,
			ja = 12.633
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
				arg_61_0:Play321091016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["10104ui_story"].transform
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 then
				arg_61_1.var_.moveOldPos10104ui_story = var_64_0.localPosition
			end

			local var_64_2 = 0.001

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_2 then
				local var_64_3 = (arg_61_1.time_ - var_64_1) / var_64_2
				local var_64_4 = Vector3.New(0.02, -1.12, -5.99)

				var_64_0.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos10104ui_story, var_64_4, var_64_3)

				local var_64_5 = manager.ui.mainCamera.transform.position - var_64_0.position

				var_64_0.forward = Vector3.New(var_64_5.x, var_64_5.y, var_64_5.z)

				local var_64_6 = var_64_0.localEulerAngles

				var_64_6.z = 0
				var_64_6.x = 0
				var_64_0.localEulerAngles = var_64_6
			end

			if arg_61_1.time_ >= var_64_1 + var_64_2 and arg_61_1.time_ < var_64_1 + var_64_2 + arg_64_0 then
				var_64_0.localPosition = Vector3.New(0.02, -1.12, -5.99)

				local var_64_7 = manager.ui.mainCamera.transform.position - var_64_0.position

				var_64_0.forward = Vector3.New(var_64_7.x, var_64_7.y, var_64_7.z)

				local var_64_8 = var_64_0.localEulerAngles

				var_64_8.z = 0
				var_64_8.x = 0
				var_64_0.localEulerAngles = var_64_8
			end

			local var_64_9 = 0
			local var_64_10 = 1

			if var_64_9 < arg_61_1.time_ and arg_61_1.time_ <= var_64_9 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_11 = arg_61_1:FormatText(StoryNameCfg[1030].name)

				arg_61_1.leftNameTxt_.text = var_64_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_12 = arg_61_1:GetWordFromCfg(321091015)
				local var_64_13 = arg_61_1:FormatText(var_64_12.content)

				arg_61_1.text_.text = var_64_13

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_14 = 40
				local var_64_15 = utf8.len(var_64_13)
				local var_64_16 = var_64_14 <= 0 and var_64_10 or var_64_10 * (var_64_15 / var_64_14)

				if var_64_16 > 0 and var_64_10 < var_64_16 then
					arg_61_1.talkMaxDuration = var_64_16

					if var_64_16 + var_64_9 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_16 + var_64_9
					end
				end

				arg_61_1.text_.text = var_64_13
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091015", "story_v_out_321091.awb") ~= 0 then
					local var_64_17 = manager.audio:GetVoiceLength("story_v_out_321091", "321091015", "story_v_out_321091.awb") / 1000

					if var_64_17 + var_64_9 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_17 + var_64_9
					end

					if var_64_12.prefab_name ~= "" and arg_61_1.actors_[var_64_12.prefab_name] ~= nil then
						local var_64_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_12.prefab_name].transform, "story_v_out_321091", "321091015", "story_v_out_321091.awb")

						arg_61_1:RecordAudio("321091015", var_64_18)
						arg_61_1:RecordAudio("321091015", var_64_18)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_321091", "321091015", "story_v_out_321091.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_321091", "321091015", "story_v_out_321091.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_19 = math.max(var_64_10, arg_61_1.talkMaxDuration)

			if var_64_9 <= arg_61_1.time_ and arg_61_1.time_ < var_64_9 + var_64_19 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_9) / var_64_19

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_9 + var_64_19 and arg_61_1.time_ < var_64_9 + var_64_19 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
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

		arg_61_1:InitPlayNodeList()
	end,
	Play321091016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 321091016
		arg_65_1.duration_ = 10.83

		local var_65_0 = {
			zh = 7.133,
			ja = 10.833
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
				arg_65_0:Play321091017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0
			local var_68_1 = 0.875

			if var_68_0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_2 = arg_65_1:FormatText(StoryNameCfg[1030].name)

				arg_65_1.leftNameTxt_.text = var_68_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_3 = arg_65_1:GetWordFromCfg(321091016)
				local var_68_4 = arg_65_1:FormatText(var_68_3.content)

				arg_65_1.text_.text = var_68_4

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_5 = 35
				local var_68_6 = utf8.len(var_68_4)
				local var_68_7 = var_68_5 <= 0 and var_68_1 or var_68_1 * (var_68_6 / var_68_5)

				if var_68_7 > 0 and var_68_1 < var_68_7 then
					arg_65_1.talkMaxDuration = var_68_7

					if var_68_7 + var_68_0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_7 + var_68_0
					end
				end

				arg_65_1.text_.text = var_68_4
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091016", "story_v_out_321091.awb") ~= 0 then
					local var_68_8 = manager.audio:GetVoiceLength("story_v_out_321091", "321091016", "story_v_out_321091.awb") / 1000

					if var_68_8 + var_68_0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_8 + var_68_0
					end

					if var_68_3.prefab_name ~= "" and arg_65_1.actors_[var_68_3.prefab_name] ~= nil then
						local var_68_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_3.prefab_name].transform, "story_v_out_321091", "321091016", "story_v_out_321091.awb")

						arg_65_1:RecordAudio("321091016", var_68_9)
						arg_65_1:RecordAudio("321091016", var_68_9)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_321091", "321091016", "story_v_out_321091.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_321091", "321091016", "story_v_out_321091.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_10 = math.max(var_68_1, arg_65_1.talkMaxDuration)

			if var_68_0 <= arg_65_1.time_ and arg_65_1.time_ < var_68_0 + var_68_10 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_0) / var_68_10

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_0 + var_68_10 and arg_65_1.time_ < var_68_0 + var_68_10 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play321091017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 321091017
		arg_69_1.duration_ = 15.9

		local var_69_0 = {
			zh = 9.8,
			ja = 15.9
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
				arg_69_0:Play321091018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["10104ui_story"].transform
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 then
				arg_69_1.var_.moveOldPos10104ui_story = var_72_0.localPosition
			end

			local var_72_2 = 0.001

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_2 then
				local var_72_3 = (arg_69_1.time_ - var_72_1) / var_72_2
				local var_72_4 = Vector3.New(0.02, -1.12, -5.99)

				var_72_0.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos10104ui_story, var_72_4, var_72_3)

				local var_72_5 = manager.ui.mainCamera.transform.position - var_72_0.position

				var_72_0.forward = Vector3.New(var_72_5.x, var_72_5.y, var_72_5.z)

				local var_72_6 = var_72_0.localEulerAngles

				var_72_6.z = 0
				var_72_6.x = 0
				var_72_0.localEulerAngles = var_72_6
			end

			if arg_69_1.time_ >= var_72_1 + var_72_2 and arg_69_1.time_ < var_72_1 + var_72_2 + arg_72_0 then
				var_72_0.localPosition = Vector3.New(0.02, -1.12, -5.99)

				local var_72_7 = manager.ui.mainCamera.transform.position - var_72_0.position

				var_72_0.forward = Vector3.New(var_72_7.x, var_72_7.y, var_72_7.z)

				local var_72_8 = var_72_0.localEulerAngles

				var_72_8.z = 0
				var_72_8.x = 0
				var_72_0.localEulerAngles = var_72_8
			end

			local var_72_9 = 0

			if var_72_9 < arg_69_1.time_ and arg_69_1.time_ <= var_72_9 + arg_72_0 then
				arg_69_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action6_2")
			end

			local var_72_10 = 0

			if var_72_10 < arg_69_1.time_ and arg_69_1.time_ <= var_72_10 + arg_72_0 then
				arg_69_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_72_11 = 0
			local var_72_12 = 1

			if var_72_11 < arg_69_1.time_ and arg_69_1.time_ <= var_72_11 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_13 = arg_69_1:FormatText(StoryNameCfg[1030].name)

				arg_69_1.leftNameTxt_.text = var_72_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_14 = arg_69_1:GetWordFromCfg(321091017)
				local var_72_15 = arg_69_1:FormatText(var_72_14.content)

				arg_69_1.text_.text = var_72_15

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_16 = 40
				local var_72_17 = utf8.len(var_72_15)
				local var_72_18 = var_72_16 <= 0 and var_72_12 or var_72_12 * (var_72_17 / var_72_16)

				if var_72_18 > 0 and var_72_12 < var_72_18 then
					arg_69_1.talkMaxDuration = var_72_18

					if var_72_18 + var_72_11 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_18 + var_72_11
					end
				end

				arg_69_1.text_.text = var_72_15
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091017", "story_v_out_321091.awb") ~= 0 then
					local var_72_19 = manager.audio:GetVoiceLength("story_v_out_321091", "321091017", "story_v_out_321091.awb") / 1000

					if var_72_19 + var_72_11 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_19 + var_72_11
					end

					if var_72_14.prefab_name ~= "" and arg_69_1.actors_[var_72_14.prefab_name] ~= nil then
						local var_72_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_14.prefab_name].transform, "story_v_out_321091", "321091017", "story_v_out_321091.awb")

						arg_69_1:RecordAudio("321091017", var_72_20)
						arg_69_1:RecordAudio("321091017", var_72_20)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_321091", "321091017", "story_v_out_321091.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_321091", "321091017", "story_v_out_321091.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_21 = math.max(var_72_12, arg_69_1.talkMaxDuration)

			if var_72_11 <= arg_69_1.time_ and arg_69_1.time_ < var_72_11 + var_72_21 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_11) / var_72_21

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_11 + var_72_21 and arg_69_1.time_ < var_72_11 + var_72_21 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
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

		arg_69_1:InitPlayNodeList()
	end,
	Play321091018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 321091018
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play321091019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["10104ui_story"]
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.characterEffect10104ui_story == nil then
				arg_73_1.var_.characterEffect10104ui_story = var_76_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_2 = 0.200000002980232

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_2 and not isNil(var_76_0) then
				local var_76_3 = (arg_73_1.time_ - var_76_1) / var_76_2

				if arg_73_1.var_.characterEffect10104ui_story and not isNil(var_76_0) then
					local var_76_4 = Mathf.Lerp(0, 0.5, var_76_3)

					arg_73_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_73_1.var_.characterEffect10104ui_story.fillRatio = var_76_4
				end
			end

			if arg_73_1.time_ >= var_76_1 + var_76_2 and arg_73_1.time_ < var_76_1 + var_76_2 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.characterEffect10104ui_story then
				local var_76_5 = 0.5

				arg_73_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_73_1.var_.characterEffect10104ui_story.fillRatio = var_76_5
			end

			local var_76_6 = arg_73_1.actors_["10104ui_story"].transform
			local var_76_7 = 0

			if var_76_7 < arg_73_1.time_ and arg_73_1.time_ <= var_76_7 + arg_76_0 then
				arg_73_1.var_.moveOldPos10104ui_story = var_76_6.localPosition
			end

			local var_76_8 = 0.001

			if var_76_7 <= arg_73_1.time_ and arg_73_1.time_ < var_76_7 + var_76_8 then
				local var_76_9 = (arg_73_1.time_ - var_76_7) / var_76_8
				local var_76_10 = Vector3.New(0, 100, 0)

				var_76_6.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos10104ui_story, var_76_10, var_76_9)

				local var_76_11 = manager.ui.mainCamera.transform.position - var_76_6.position

				var_76_6.forward = Vector3.New(var_76_11.x, var_76_11.y, var_76_11.z)

				local var_76_12 = var_76_6.localEulerAngles

				var_76_12.z = 0
				var_76_12.x = 0
				var_76_6.localEulerAngles = var_76_12
			end

			if arg_73_1.time_ >= var_76_7 + var_76_8 and arg_73_1.time_ < var_76_7 + var_76_8 + arg_76_0 then
				var_76_6.localPosition = Vector3.New(0, 100, 0)

				local var_76_13 = manager.ui.mainCamera.transform.position - var_76_6.position

				var_76_6.forward = Vector3.New(var_76_13.x, var_76_13.y, var_76_13.z)

				local var_76_14 = var_76_6.localEulerAngles

				var_76_14.z = 0
				var_76_14.x = 0
				var_76_6.localEulerAngles = var_76_14
			end

			local var_76_15 = 0
			local var_76_16 = 1.1

			if var_76_15 < arg_73_1.time_ and arg_73_1.time_ <= var_76_15 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, false)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_17 = arg_73_1:GetWordFromCfg(321091018)
				local var_76_18 = arg_73_1:FormatText(var_76_17.content)

				arg_73_1.text_.text = var_76_18

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_19 = 44
				local var_76_20 = utf8.len(var_76_18)
				local var_76_21 = var_76_19 <= 0 and var_76_16 or var_76_16 * (var_76_20 / var_76_19)

				if var_76_21 > 0 and var_76_16 < var_76_21 then
					arg_73_1.talkMaxDuration = var_76_21

					if var_76_21 + var_76_15 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_21 + var_76_15
					end
				end

				arg_73_1.text_.text = var_76_18
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_22 = math.max(var_76_16, arg_73_1.talkMaxDuration)

			if var_76_15 <= arg_73_1.time_ and arg_73_1.time_ < var_76_15 + var_76_22 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_15) / var_76_22

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_15 + var_76_22 and arg_73_1.time_ < var_76_15 + var_76_22 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
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

		arg_73_1:InitPlayNodeList()
	end,
	Play321091019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 321091019
		arg_77_1.duration_ = 13.23

		local var_77_0 = {
			zh = 7.833,
			ja = 13.233
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
				arg_77_0:Play321091020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0
			local var_80_1 = 1.15

			if var_80_0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_2 = arg_77_1:FormatText(StoryNameCfg[546].name)

				arg_77_1.leftNameTxt_.text = var_80_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, true)
				arg_77_1.iconController_:SetSelectedState("hero")

				arg_77_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10010")

				arg_77_1.callingController_:SetSelectedState("normal")

				arg_77_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_77_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_80_3 = arg_77_1:GetWordFromCfg(321091019)
				local var_80_4 = arg_77_1:FormatText(var_80_3.content)

				arg_77_1.text_.text = var_80_4

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_5 = 46
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

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091019", "story_v_out_321091.awb") ~= 0 then
					local var_80_8 = manager.audio:GetVoiceLength("story_v_out_321091", "321091019", "story_v_out_321091.awb") / 1000

					if var_80_8 + var_80_0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_8 + var_80_0
					end

					if var_80_3.prefab_name ~= "" and arg_77_1.actors_[var_80_3.prefab_name] ~= nil then
						local var_80_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_3.prefab_name].transform, "story_v_out_321091", "321091019", "story_v_out_321091.awb")

						arg_77_1:RecordAudio("321091019", var_80_9)
						arg_77_1:RecordAudio("321091019", var_80_9)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_321091", "321091019", "story_v_out_321091.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_321091", "321091019", "story_v_out_321091.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_10 = math.max(var_80_1, arg_77_1.talkMaxDuration)

			if var_80_0 <= arg_77_1.time_ and arg_77_1.time_ < var_80_0 + var_80_10 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_0) / var_80_10

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_0 + var_80_10 and arg_77_1.time_ < var_80_0 + var_80_10 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play321091020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 321091020
		arg_81_1.duration_ = 8.03

		local var_81_0 = {
			zh = 8.033,
			ja = 7.333
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
				arg_81_0:Play321091021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 0
			local var_84_1 = 0.825

			if var_84_0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_2 = arg_81_1:FormatText(StoryNameCfg[546].name)

				arg_81_1.leftNameTxt_.text = var_84_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, true)
				arg_81_1.iconController_:SetSelectedState("hero")

				arg_81_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10010")

				arg_81_1.callingController_:SetSelectedState("normal")

				arg_81_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_81_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_84_3 = arg_81_1:GetWordFromCfg(321091020)
				local var_84_4 = arg_81_1:FormatText(var_84_3.content)

				arg_81_1.text_.text = var_84_4

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_5 = 33
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

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091020", "story_v_out_321091.awb") ~= 0 then
					local var_84_8 = manager.audio:GetVoiceLength("story_v_out_321091", "321091020", "story_v_out_321091.awb") / 1000

					if var_84_8 + var_84_0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_8 + var_84_0
					end

					if var_84_3.prefab_name ~= "" and arg_81_1.actors_[var_84_3.prefab_name] ~= nil then
						local var_84_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_3.prefab_name].transform, "story_v_out_321091", "321091020", "story_v_out_321091.awb")

						arg_81_1:RecordAudio("321091020", var_84_9)
						arg_81_1:RecordAudio("321091020", var_84_9)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_321091", "321091020", "story_v_out_321091.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_321091", "321091020", "story_v_out_321091.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_10 = math.max(var_84_1, arg_81_1.talkMaxDuration)

			if var_84_0 <= arg_81_1.time_ and arg_81_1.time_ < var_84_0 + var_84_10 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_0) / var_84_10

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_0 + var_84_10 and arg_81_1.time_ < var_84_0 + var_84_10 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play321091021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 321091021
		arg_85_1.duration_ = 4.77

		local var_85_0 = {
			zh = 3.266,
			ja = 4.766
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
				arg_85_0:Play321091022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["10104ui_story"].transform
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 then
				arg_85_1.var_.moveOldPos10104ui_story = var_88_0.localPosition
			end

			local var_88_2 = 0.001

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_2 then
				local var_88_3 = (arg_85_1.time_ - var_88_1) / var_88_2
				local var_88_4 = Vector3.New(0, 100, 0)

				var_88_0.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos10104ui_story, var_88_4, var_88_3)

				local var_88_5 = manager.ui.mainCamera.transform.position - var_88_0.position

				var_88_0.forward = Vector3.New(var_88_5.x, var_88_5.y, var_88_5.z)

				local var_88_6 = var_88_0.localEulerAngles

				var_88_6.z = 0
				var_88_6.x = 0
				var_88_0.localEulerAngles = var_88_6
			end

			if arg_85_1.time_ >= var_88_1 + var_88_2 and arg_85_1.time_ < var_88_1 + var_88_2 + arg_88_0 then
				var_88_0.localPosition = Vector3.New(0, 100, 0)

				local var_88_7 = manager.ui.mainCamera.transform.position - var_88_0.position

				var_88_0.forward = Vector3.New(var_88_7.x, var_88_7.y, var_88_7.z)

				local var_88_8 = var_88_0.localEulerAngles

				var_88_8.z = 0
				var_88_8.x = 0
				var_88_0.localEulerAngles = var_88_8
			end

			local var_88_9 = 0
			local var_88_10 = 0.3

			if var_88_9 < arg_85_1.time_ and arg_85_1.time_ <= var_88_9 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_11 = arg_85_1:FormatText(StoryNameCfg[546].name)

				arg_85_1.leftNameTxt_.text = var_88_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, true)
				arg_85_1.iconController_:SetSelectedState("hero")

				arg_85_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10010")

				arg_85_1.callingController_:SetSelectedState("normal")

				arg_85_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_85_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_88_12 = arg_85_1:GetWordFromCfg(321091021)
				local var_88_13 = arg_85_1:FormatText(var_88_12.content)

				arg_85_1.text_.text = var_88_13

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_14 = 12
				local var_88_15 = utf8.len(var_88_13)
				local var_88_16 = var_88_14 <= 0 and var_88_10 or var_88_10 * (var_88_15 / var_88_14)

				if var_88_16 > 0 and var_88_10 < var_88_16 then
					arg_85_1.talkMaxDuration = var_88_16

					if var_88_16 + var_88_9 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_16 + var_88_9
					end
				end

				arg_85_1.text_.text = var_88_13
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091021", "story_v_out_321091.awb") ~= 0 then
					local var_88_17 = manager.audio:GetVoiceLength("story_v_out_321091", "321091021", "story_v_out_321091.awb") / 1000

					if var_88_17 + var_88_9 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_17 + var_88_9
					end

					if var_88_12.prefab_name ~= "" and arg_85_1.actors_[var_88_12.prefab_name] ~= nil then
						local var_88_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_12.prefab_name].transform, "story_v_out_321091", "321091021", "story_v_out_321091.awb")

						arg_85_1:RecordAudio("321091021", var_88_18)
						arg_85_1:RecordAudio("321091021", var_88_18)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_321091", "321091021", "story_v_out_321091.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_321091", "321091021", "story_v_out_321091.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_19 = math.max(var_88_10, arg_85_1.talkMaxDuration)

			if var_88_9 <= arg_85_1.time_ and arg_85_1.time_ < var_88_9 + var_88_19 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_9) / var_88_19

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_9 + var_88_19 and arg_85_1.time_ < var_88_9 + var_88_19 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
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

		arg_85_1:InitPlayNodeList()
	end,
	Play321091022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 321091022
		arg_89_1.duration_ = 4.97

		local var_89_0 = {
			zh = 4.86666666666667,
			ja = 4.96666666666667
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
				arg_89_0:Play321091023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = "MS2103a"

			if arg_89_1.bgs_[var_92_0] == nil then
				local var_92_1 = Object.Instantiate(arg_89_1.paintGo_)

				var_92_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_92_0)
				var_92_1.name = var_92_0
				var_92_1.transform.parent = arg_89_1.stage_.transform
				var_92_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_89_1.bgs_[var_92_0] = var_92_1
			end

			local var_92_2 = 2

			if var_92_2 < arg_89_1.time_ and arg_89_1.time_ <= var_92_2 + arg_92_0 then
				local var_92_3 = manager.ui.mainCamera.transform.localPosition
				local var_92_4 = Vector3.New(0, 0, 10) + Vector3.New(var_92_3.x, var_92_3.y, 0)
				local var_92_5 = arg_89_1.bgs_.MS2103a

				var_92_5.transform.localPosition = var_92_4
				var_92_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_92_6 = var_92_5:GetComponent("SpriteRenderer")

				if var_92_6 and var_92_6.sprite then
					local var_92_7 = (var_92_5.transform.localPosition - var_92_3).z
					local var_92_8 = manager.ui.mainCameraCom_
					local var_92_9 = 2 * var_92_7 * Mathf.Tan(var_92_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_92_10 = var_92_9 * var_92_8.aspect
					local var_92_11 = var_92_6.sprite.bounds.size.x
					local var_92_12 = var_92_6.sprite.bounds.size.y
					local var_92_13 = var_92_10 / var_92_11
					local var_92_14 = var_92_9 / var_92_12
					local var_92_15 = var_92_14 < var_92_13 and var_92_13 or var_92_14

					var_92_5.transform.localScale = Vector3.New(var_92_15, var_92_15, 0)
				end

				for iter_92_0, iter_92_1 in pairs(arg_89_1.bgs_) do
					if iter_92_0 ~= "MS2103a" then
						iter_92_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_92_16 = 0

			if var_92_16 < arg_89_1.time_ and arg_89_1.time_ <= var_92_16 + arg_92_0 then
				arg_89_1.allBtn_.enabled = false
			end

			local var_92_17 = 0.3

			if arg_89_1.time_ >= var_92_16 + var_92_17 and arg_89_1.time_ < var_92_16 + var_92_17 + arg_92_0 then
				arg_89_1.allBtn_.enabled = true
			end

			local var_92_18 = 0

			if var_92_18 < arg_89_1.time_ and arg_89_1.time_ <= var_92_18 + arg_92_0 then
				arg_89_1.mask_.enabled = true
				arg_89_1.mask_.raycastTarget = true

				arg_89_1:SetGaussion(false)
			end

			local var_92_19 = 2

			if var_92_18 <= arg_89_1.time_ and arg_89_1.time_ < var_92_18 + var_92_19 then
				local var_92_20 = (arg_89_1.time_ - var_92_18) / var_92_19
				local var_92_21 = Color.New(0, 0, 0)

				var_92_21.a = Mathf.Lerp(0, 1, var_92_20)
				arg_89_1.mask_.color = var_92_21
			end

			if arg_89_1.time_ >= var_92_18 + var_92_19 and arg_89_1.time_ < var_92_18 + var_92_19 + arg_92_0 then
				local var_92_22 = Color.New(0, 0, 0)

				var_92_22.a = 1
				arg_89_1.mask_.color = var_92_22
			end

			local var_92_23 = 2

			if var_92_23 < arg_89_1.time_ and arg_89_1.time_ <= var_92_23 + arg_92_0 then
				arg_89_1.mask_.enabled = true
				arg_89_1.mask_.raycastTarget = true

				arg_89_1:SetGaussion(false)
			end

			local var_92_24 = 2

			if var_92_23 <= arg_89_1.time_ and arg_89_1.time_ < var_92_23 + var_92_24 then
				local var_92_25 = (arg_89_1.time_ - var_92_23) / var_92_24
				local var_92_26 = Color.New(0, 0, 0)

				var_92_26.a = Mathf.Lerp(1, 0, var_92_25)
				arg_89_1.mask_.color = var_92_26
			end

			if arg_89_1.time_ >= var_92_23 + var_92_24 and arg_89_1.time_ < var_92_23 + var_92_24 + arg_92_0 then
				local var_92_27 = Color.New(0, 0, 0)
				local var_92_28 = 0

				arg_89_1.mask_.enabled = false
				var_92_27.a = var_92_28
				arg_89_1.mask_.color = var_92_27
			end

			local var_92_29 = arg_89_1.actors_["10104ui_story"]
			local var_92_30 = 0

			if var_92_30 < arg_89_1.time_ and arg_89_1.time_ <= var_92_30 + arg_92_0 and not isNil(var_92_29) and arg_89_1.var_.characterEffect10104ui_story == nil then
				arg_89_1.var_.characterEffect10104ui_story = var_92_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_31 = 0.200000002980232

			if var_92_30 <= arg_89_1.time_ and arg_89_1.time_ < var_92_30 + var_92_31 and not isNil(var_92_29) then
				local var_92_32 = (arg_89_1.time_ - var_92_30) / var_92_31

				if arg_89_1.var_.characterEffect10104ui_story and not isNil(var_92_29) then
					arg_89_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= var_92_30 + var_92_31 and arg_89_1.time_ < var_92_30 + var_92_31 + arg_92_0 and not isNil(var_92_29) and arg_89_1.var_.characterEffect10104ui_story then
				arg_89_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_92_33 = 2

			arg_89_1.isInRecall_ = false

			if var_92_33 < arg_89_1.time_ and arg_89_1.time_ <= var_92_33 + arg_92_0 then
				arg_89_1.screenFilterGo_:SetActive(false)

				for iter_92_2, iter_92_3 in pairs(arg_89_1.actors_) do
					local var_92_34 = iter_92_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_92_4, iter_92_5 in ipairs(var_92_34) do
						if iter_92_5.color.r > 0.51 then
							iter_92_5.color = Color.New(1, 1, 1)
						else
							iter_92_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_92_35 = 0.0333333333333332

			if var_92_33 <= arg_89_1.time_ and arg_89_1.time_ < var_92_33 + var_92_35 then
				local var_92_36 = (arg_89_1.time_ - var_92_33) / var_92_35

				arg_89_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, var_92_36)
			end

			if arg_89_1.time_ >= var_92_33 + var_92_35 and arg_89_1.time_ < var_92_33 + var_92_35 + arg_92_0 then
				arg_89_1.screenFilterEffect_.weight = 0
			end

			if arg_89_1.frameCnt_ <= 1 then
				arg_89_1.dialog_:SetActive(false)
			end

			local var_92_37 = 3.86666666666667
			local var_92_38 = 0.133333333333333

			if var_92_37 < arg_89_1.time_ and arg_89_1.time_ <= var_92_37 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0

				arg_89_1.dialog_:SetActive(true)

				arg_89_1.dialogCg_.alpha = 0

				local var_92_39 = LeanTween.value(arg_89_1.dialog_, 0, 1, 0.3)

				var_92_39:setOnUpdate(LuaHelper.FloatAction(function(arg_93_0)
					arg_89_1.dialogCg_.alpha = arg_93_0
				end))
				var_92_39:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_89_1.dialog_)
					var_92_39:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_89_1.duration_ = arg_89_1.duration_ + 0.3

				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_40 = arg_89_1:FormatText(StoryNameCfg[1030].name)

				arg_89_1.leftNameTxt_.text = var_92_40

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, true)
				arg_89_1.iconController_:SetSelectedState("hero")

				arg_89_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_89_1.callingController_:SetSelectedState("normal")

				arg_89_1.keyicon_.color = Color.New(1, 1, 1)
				arg_89_1.icon_.color = Color.New(1, 1, 1)

				local var_92_41 = arg_89_1:GetWordFromCfg(321091022)
				local var_92_42 = arg_89_1:FormatText(var_92_41.content)

				arg_89_1.text_.text = var_92_42

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_43 = 2
				local var_92_44 = utf8.len(var_92_42)
				local var_92_45 = var_92_43 <= 0 and var_92_38 or var_92_38 * (var_92_44 / var_92_43)

				if var_92_45 > 0 and var_92_38 < var_92_45 then
					arg_89_1.talkMaxDuration = var_92_45
					var_92_37 = var_92_37 + 0.3

					if var_92_45 + var_92_37 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_45 + var_92_37
					end
				end

				arg_89_1.text_.text = var_92_42
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091022", "story_v_out_321091.awb") ~= 0 then
					local var_92_46 = manager.audio:GetVoiceLength("story_v_out_321091", "321091022", "story_v_out_321091.awb") / 1000

					if var_92_46 + var_92_37 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_46 + var_92_37
					end

					if var_92_41.prefab_name ~= "" and arg_89_1.actors_[var_92_41.prefab_name] ~= nil then
						local var_92_47 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_41.prefab_name].transform, "story_v_out_321091", "321091022", "story_v_out_321091.awb")

						arg_89_1:RecordAudio("321091022", var_92_47)
						arg_89_1:RecordAudio("321091022", var_92_47)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_321091", "321091022", "story_v_out_321091.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_321091", "321091022", "story_v_out_321091.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_48 = var_92_37 + 0.3
			local var_92_49 = math.max(var_92_38, arg_89_1.talkMaxDuration)

			if var_92_48 <= arg_89_1.time_ and arg_89_1.time_ < var_92_48 + var_92_49 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_48) / var_92_49

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_48 + var_92_49 and arg_89_1.time_ < var_92_48 + var_92_49 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play321091023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 321091023
		arg_95_1.duration_ = 5

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play321091024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = arg_95_1.actors_["10104ui_story"]
			local var_98_1 = 0

			if var_98_1 < arg_95_1.time_ and arg_95_1.time_ <= var_98_1 + arg_98_0 and not isNil(var_98_0) and arg_95_1.var_.characterEffect10104ui_story == nil then
				arg_95_1.var_.characterEffect10104ui_story = var_98_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_2 = 0.200000002980232

			if var_98_1 <= arg_95_1.time_ and arg_95_1.time_ < var_98_1 + var_98_2 and not isNil(var_98_0) then
				local var_98_3 = (arg_95_1.time_ - var_98_1) / var_98_2

				if arg_95_1.var_.characterEffect10104ui_story and not isNil(var_98_0) then
					local var_98_4 = Mathf.Lerp(0, 0.5, var_98_3)

					arg_95_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_95_1.var_.characterEffect10104ui_story.fillRatio = var_98_4
				end
			end

			if arg_95_1.time_ >= var_98_1 + var_98_2 and arg_95_1.time_ < var_98_1 + var_98_2 + arg_98_0 and not isNil(var_98_0) and arg_95_1.var_.characterEffect10104ui_story then
				local var_98_5 = 0.5

				arg_95_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_95_1.var_.characterEffect10104ui_story.fillRatio = var_98_5
			end

			local var_98_6 = 0.05
			local var_98_7 = 1

			if var_98_6 < arg_95_1.time_ and arg_95_1.time_ <= var_98_6 + arg_98_0 then
				local var_98_8 = "play"
				local var_98_9 = "effect"

				arg_95_1:AudioAction(var_98_8, var_98_9, "se_story_16", "se_story_16_chain", "")
			end

			local var_98_10 = 0
			local var_98_11 = 1.475

			if var_98_10 < arg_95_1.time_ and arg_95_1.time_ <= var_98_10 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, false)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_12 = arg_95_1:GetWordFromCfg(321091023)
				local var_98_13 = arg_95_1:FormatText(var_98_12.content)

				arg_95_1.text_.text = var_98_13

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_14 = 59
				local var_98_15 = utf8.len(var_98_13)
				local var_98_16 = var_98_14 <= 0 and var_98_11 or var_98_11 * (var_98_15 / var_98_14)

				if var_98_16 > 0 and var_98_11 < var_98_16 then
					arg_95_1.talkMaxDuration = var_98_16

					if var_98_16 + var_98_10 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_16 + var_98_10
					end
				end

				arg_95_1.text_.text = var_98_13
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)
				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_17 = math.max(var_98_11, arg_95_1.talkMaxDuration)

			if var_98_10 <= arg_95_1.time_ and arg_95_1.time_ < var_98_10 + var_98_17 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_10) / var_98_17

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_10 + var_98_17 and arg_95_1.time_ < var_98_10 + var_98_17 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play321091024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 321091024
		arg_99_1.duration_ = 11.73

		local var_99_0 = {
			zh = 6.9,
			ja = 11.733
		}
		local var_99_1 = manager.audio:GetLocalizationFlag()

		if var_99_0[var_99_1] ~= nil then
			arg_99_1.duration_ = var_99_0[var_99_1]
		end

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play321091025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = 0
			local var_102_1 = 0.6

			if var_102_0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_0 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				local var_102_2 = arg_99_1:FormatText(StoryNameCfg[1049].name)

				arg_99_1.leftNameTxt_.text = var_102_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_3 = arg_99_1:GetWordFromCfg(321091024)
				local var_102_4 = arg_99_1:FormatText(var_102_3.content)

				arg_99_1.text_.text = var_102_4

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_5 = 24
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

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091024", "story_v_out_321091.awb") ~= 0 then
					local var_102_8 = manager.audio:GetVoiceLength("story_v_out_321091", "321091024", "story_v_out_321091.awb") / 1000

					if var_102_8 + var_102_0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_8 + var_102_0
					end

					if var_102_3.prefab_name ~= "" and arg_99_1.actors_[var_102_3.prefab_name] ~= nil then
						local var_102_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_3.prefab_name].transform, "story_v_out_321091", "321091024", "story_v_out_321091.awb")

						arg_99_1:RecordAudio("321091024", var_102_9)
						arg_99_1:RecordAudio("321091024", var_102_9)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_321091", "321091024", "story_v_out_321091.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_321091", "321091024", "story_v_out_321091.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_10 = math.max(var_102_1, arg_99_1.talkMaxDuration)

			if var_102_0 <= arg_99_1.time_ and arg_99_1.time_ < var_102_0 + var_102_10 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_0) / var_102_10

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_0 + var_102_10 and arg_99_1.time_ < var_102_0 + var_102_10 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play321091025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 321091025
		arg_103_1.duration_ = 5.73

		local var_103_0 = {
			zh = 4.366,
			ja = 5.733
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
				arg_103_0:Play321091026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = arg_103_1.actors_["10104ui_story"]
			local var_106_1 = 0

			if var_106_1 < arg_103_1.time_ and arg_103_1.time_ <= var_106_1 + arg_106_0 and not isNil(var_106_0) and arg_103_1.var_.characterEffect10104ui_story == nil then
				arg_103_1.var_.characterEffect10104ui_story = var_106_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_2 = 0.200000002980232

			if var_106_1 <= arg_103_1.time_ and arg_103_1.time_ < var_106_1 + var_106_2 and not isNil(var_106_0) then
				local var_106_3 = (arg_103_1.time_ - var_106_1) / var_106_2

				if arg_103_1.var_.characterEffect10104ui_story and not isNil(var_106_0) then
					arg_103_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_103_1.time_ >= var_106_1 + var_106_2 and arg_103_1.time_ < var_106_1 + var_106_2 + arg_106_0 and not isNil(var_106_0) and arg_103_1.var_.characterEffect10104ui_story then
				arg_103_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_106_4 = 0
			local var_106_5 = 0.5

			if var_106_4 < arg_103_1.time_ and arg_103_1.time_ <= var_106_4 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				local var_106_6 = arg_103_1:FormatText(StoryNameCfg[1030].name)

				arg_103_1.leftNameTxt_.text = var_106_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, true)
				arg_103_1.iconController_:SetSelectedState("hero")

				arg_103_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_103_1.callingController_:SetSelectedState("normal")

				arg_103_1.keyicon_.color = Color.New(1, 1, 1)
				arg_103_1.icon_.color = Color.New(1, 1, 1)

				local var_106_7 = arg_103_1:GetWordFromCfg(321091025)
				local var_106_8 = arg_103_1:FormatText(var_106_7.content)

				arg_103_1.text_.text = var_106_8

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_9 = 20
				local var_106_10 = utf8.len(var_106_8)
				local var_106_11 = var_106_9 <= 0 and var_106_5 or var_106_5 * (var_106_10 / var_106_9)

				if var_106_11 > 0 and var_106_5 < var_106_11 then
					arg_103_1.talkMaxDuration = var_106_11

					if var_106_11 + var_106_4 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_11 + var_106_4
					end
				end

				arg_103_1.text_.text = var_106_8
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091025", "story_v_out_321091.awb") ~= 0 then
					local var_106_12 = manager.audio:GetVoiceLength("story_v_out_321091", "321091025", "story_v_out_321091.awb") / 1000

					if var_106_12 + var_106_4 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_12 + var_106_4
					end

					if var_106_7.prefab_name ~= "" and arg_103_1.actors_[var_106_7.prefab_name] ~= nil then
						local var_106_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_7.prefab_name].transform, "story_v_out_321091", "321091025", "story_v_out_321091.awb")

						arg_103_1:RecordAudio("321091025", var_106_13)
						arg_103_1:RecordAudio("321091025", var_106_13)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_321091", "321091025", "story_v_out_321091.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_321091", "321091025", "story_v_out_321091.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_14 = math.max(var_106_5, arg_103_1.talkMaxDuration)

			if var_106_4 <= arg_103_1.time_ and arg_103_1.time_ < var_106_4 + var_106_14 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_4) / var_106_14

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_4 + var_106_14 and arg_103_1.time_ < var_106_4 + var_106_14 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play321091026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 321091026
		arg_107_1.duration_ = 12.97

		local var_107_0 = {
			zh = 8.7,
			ja = 12.966
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
				arg_107_0:Play321091027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = 0
			local var_110_1 = 1.05

			if var_110_0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_0 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				local var_110_2 = arg_107_1:FormatText(StoryNameCfg[1030].name)

				arg_107_1.leftNameTxt_.text = var_110_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, true)
				arg_107_1.iconController_:SetSelectedState("hero")

				arg_107_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_107_1.callingController_:SetSelectedState("normal")

				arg_107_1.keyicon_.color = Color.New(1, 1, 1)
				arg_107_1.icon_.color = Color.New(1, 1, 1)

				local var_110_3 = arg_107_1:GetWordFromCfg(321091026)
				local var_110_4 = arg_107_1:FormatText(var_110_3.content)

				arg_107_1.text_.text = var_110_4

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_5 = 42
				local var_110_6 = utf8.len(var_110_4)
				local var_110_7 = var_110_5 <= 0 and var_110_1 or var_110_1 * (var_110_6 / var_110_5)

				if var_110_7 > 0 and var_110_1 < var_110_7 then
					arg_107_1.talkMaxDuration = var_110_7

					if var_110_7 + var_110_0 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_7 + var_110_0
					end
				end

				arg_107_1.text_.text = var_110_4
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091026", "story_v_out_321091.awb") ~= 0 then
					local var_110_8 = manager.audio:GetVoiceLength("story_v_out_321091", "321091026", "story_v_out_321091.awb") / 1000

					if var_110_8 + var_110_0 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_8 + var_110_0
					end

					if var_110_3.prefab_name ~= "" and arg_107_1.actors_[var_110_3.prefab_name] ~= nil then
						local var_110_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_3.prefab_name].transform, "story_v_out_321091", "321091026", "story_v_out_321091.awb")

						arg_107_1:RecordAudio("321091026", var_110_9)
						arg_107_1:RecordAudio("321091026", var_110_9)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_321091", "321091026", "story_v_out_321091.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_321091", "321091026", "story_v_out_321091.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_10 = math.max(var_110_1, arg_107_1.talkMaxDuration)

			if var_110_0 <= arg_107_1.time_ and arg_107_1.time_ < var_110_0 + var_110_10 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_0) / var_110_10

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_0 + var_110_10 and arg_107_1.time_ < var_110_0 + var_110_10 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play321091027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 321091027
		arg_111_1.duration_ = 1

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"

			SetActive(arg_111_1.choicesGo_, true)

			for iter_112_0, iter_112_1 in ipairs(arg_111_1.choices_) do
				local var_112_0 = iter_112_0 <= 1

				SetActive(iter_112_1.go, var_112_0)
			end

			arg_111_1.choices_[1].txt.text = arg_111_1:FormatText(StoryChoiceCfg[1265].name)
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play321091028(arg_111_1)
			end

			arg_111_1:RecordChoiceLog(321091027, 1265)
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = arg_111_1.actors_["10104ui_story"]
			local var_114_1 = 0

			if var_114_1 < arg_111_1.time_ and arg_111_1.time_ <= var_114_1 + arg_114_0 and not isNil(var_114_0) and arg_111_1.var_.characterEffect10104ui_story == nil then
				arg_111_1.var_.characterEffect10104ui_story = var_114_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_2 = 0.200000002980232

			if var_114_1 <= arg_111_1.time_ and arg_111_1.time_ < var_114_1 + var_114_2 and not isNil(var_114_0) then
				local var_114_3 = (arg_111_1.time_ - var_114_1) / var_114_2

				if arg_111_1.var_.characterEffect10104ui_story and not isNil(var_114_0) then
					local var_114_4 = Mathf.Lerp(0, 0.5, var_114_3)

					arg_111_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_111_1.var_.characterEffect10104ui_story.fillRatio = var_114_4
				end
			end

			if arg_111_1.time_ >= var_114_1 + var_114_2 and arg_111_1.time_ < var_114_1 + var_114_2 + arg_114_0 and not isNil(var_114_0) and arg_111_1.var_.characterEffect10104ui_story then
				local var_114_5 = 0.5

				arg_111_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_111_1.var_.characterEffect10104ui_story.fillRatio = var_114_5
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play321091028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 321091028
		arg_115_1.duration_ = 6.57

		local var_115_0 = {
			zh = 4,
			ja = 6.566
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
				arg_115_0:Play321091029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = 0
			local var_118_1 = 0.275

			if var_118_0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_0 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				local var_118_2 = arg_115_1:FormatText(StoryNameCfg[1049].name)

				arg_115_1.leftNameTxt_.text = var_118_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_3 = arg_115_1:GetWordFromCfg(321091028)
				local var_118_4 = arg_115_1:FormatText(var_118_3.content)

				arg_115_1.text_.text = var_118_4

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_5 = 11
				local var_118_6 = utf8.len(var_118_4)
				local var_118_7 = var_118_5 <= 0 and var_118_1 or var_118_1 * (var_118_6 / var_118_5)

				if var_118_7 > 0 and var_118_1 < var_118_7 then
					arg_115_1.talkMaxDuration = var_118_7

					if var_118_7 + var_118_0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_7 + var_118_0
					end
				end

				arg_115_1.text_.text = var_118_4
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091028", "story_v_out_321091.awb") ~= 0 then
					local var_118_8 = manager.audio:GetVoiceLength("story_v_out_321091", "321091028", "story_v_out_321091.awb") / 1000

					if var_118_8 + var_118_0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_8 + var_118_0
					end

					if var_118_3.prefab_name ~= "" and arg_115_1.actors_[var_118_3.prefab_name] ~= nil then
						local var_118_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_3.prefab_name].transform, "story_v_out_321091", "321091028", "story_v_out_321091.awb")

						arg_115_1:RecordAudio("321091028", var_118_9)
						arg_115_1:RecordAudio("321091028", var_118_9)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_321091", "321091028", "story_v_out_321091.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_321091", "321091028", "story_v_out_321091.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_10 = math.max(var_118_1, arg_115_1.talkMaxDuration)

			if var_118_0 <= arg_115_1.time_ and arg_115_1.time_ < var_118_0 + var_118_10 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_0) / var_118_10

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_0 + var_118_10 and arg_115_1.time_ < var_118_0 + var_118_10 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play321091029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 321091029
		arg_119_1.duration_ = 5

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play321091030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = 0
			local var_122_1 = 0.925

			if var_122_0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_0 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, false)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_2 = arg_119_1:GetWordFromCfg(321091029)
				local var_122_3 = arg_119_1:FormatText(var_122_2.content)

				arg_119_1.text_.text = var_122_3

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_4 = 37
				local var_122_5 = utf8.len(var_122_3)
				local var_122_6 = var_122_4 <= 0 and var_122_1 or var_122_1 * (var_122_5 / var_122_4)

				if var_122_6 > 0 and var_122_1 < var_122_6 then
					arg_119_1.talkMaxDuration = var_122_6

					if var_122_6 + var_122_0 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_6 + var_122_0
					end
				end

				arg_119_1.text_.text = var_122_3
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)
				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_7 = math.max(var_122_1, arg_119_1.talkMaxDuration)

			if var_122_0 <= arg_119_1.time_ and arg_119_1.time_ < var_122_0 + var_122_7 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_0) / var_122_7

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_0 + var_122_7 and arg_119_1.time_ < var_122_0 + var_122_7 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play321091030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 321091030
		arg_123_1.duration_ = 5

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play321091031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = 0
			local var_126_1 = 1.4

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

				local var_126_2 = arg_123_1:GetWordFromCfg(321091030)
				local var_126_3 = arg_123_1:FormatText(var_126_2.content)

				arg_123_1.text_.text = var_126_3

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_4 = 56
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
	Play321091031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 321091031
		arg_127_1.duration_ = 18.47

		local var_127_0 = {
			zh = 10.3,
			ja = 18.466
		}
		local var_127_1 = manager.audio:GetLocalizationFlag()

		if var_127_0[var_127_1] ~= nil then
			arg_127_1.duration_ = var_127_0[var_127_1]
		end

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play321091032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = 0
			local var_130_1 = 0.725

			if var_130_0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_0 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				local var_130_2 = arg_127_1:FormatText(StoryNameCfg[1049].name)

				arg_127_1.leftNameTxt_.text = var_130_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_3 = arg_127_1:GetWordFromCfg(321091031)
				local var_130_4 = arg_127_1:FormatText(var_130_3.content)

				arg_127_1.text_.text = var_130_4

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_5 = 29
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

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091031", "story_v_out_321091.awb") ~= 0 then
					local var_130_8 = manager.audio:GetVoiceLength("story_v_out_321091", "321091031", "story_v_out_321091.awb") / 1000

					if var_130_8 + var_130_0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_8 + var_130_0
					end

					if var_130_3.prefab_name ~= "" and arg_127_1.actors_[var_130_3.prefab_name] ~= nil then
						local var_130_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_3.prefab_name].transform, "story_v_out_321091", "321091031", "story_v_out_321091.awb")

						arg_127_1:RecordAudio("321091031", var_130_9)
						arg_127_1:RecordAudio("321091031", var_130_9)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_321091", "321091031", "story_v_out_321091.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_321091", "321091031", "story_v_out_321091.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_10 = math.max(var_130_1, arg_127_1.talkMaxDuration)

			if var_130_0 <= arg_127_1.time_ and arg_127_1.time_ < var_130_0 + var_130_10 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_0) / var_130_10

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_0 + var_130_10 and arg_127_1.time_ < var_130_0 + var_130_10 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play321091032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 321091032
		arg_131_1.duration_ = 6.73

		local var_131_0 = {
			zh = 3.8,
			ja = 6.733
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
				arg_131_0:Play321091033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = "10102ui_story"

			if arg_131_1.actors_[var_134_0] == nil then
				local var_134_1 = Asset.Load("Char/" .. "10102ui_story")

				if not isNil(var_134_1) then
					local var_134_2 = Object.Instantiate(Asset.Load("Char/" .. "10102ui_story"), arg_131_1.stage_.transform)

					var_134_2.name = var_134_0
					var_134_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_131_1.actors_[var_134_0] = var_134_2

					local var_134_3 = var_134_2:GetComponentInChildren(typeof(CharacterEffect))

					var_134_3.enabled = true

					local var_134_4 = GameObjectTools.GetOrAddComponent(var_134_2, typeof(DynamicBoneHelper))

					if var_134_4 then
						var_134_4:EnableDynamicBone(false)
					end

					arg_131_1:ShowWeapon(var_134_3.transform, false)

					arg_131_1.var_[var_134_0 .. "Animator"] = var_134_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_131_1.var_[var_134_0 .. "Animator"].applyRootMotion = true
					arg_131_1.var_[var_134_0 .. "LipSync"] = var_134_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_134_5 = arg_131_1.actors_["10102ui_story"]
			local var_134_6 = 0

			if var_134_6 < arg_131_1.time_ and arg_131_1.time_ <= var_134_6 + arg_134_0 and not isNil(var_134_5) and arg_131_1.var_.characterEffect10102ui_story == nil then
				arg_131_1.var_.characterEffect10102ui_story = var_134_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_7 = 0.200000002980232

			if var_134_6 <= arg_131_1.time_ and arg_131_1.time_ < var_134_6 + var_134_7 and not isNil(var_134_5) then
				local var_134_8 = (arg_131_1.time_ - var_134_6) / var_134_7

				if arg_131_1.var_.characterEffect10102ui_story and not isNil(var_134_5) then
					arg_131_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_131_1.time_ >= var_134_6 + var_134_7 and arg_131_1.time_ < var_134_6 + var_134_7 + arg_134_0 and not isNil(var_134_5) and arg_131_1.var_.characterEffect10102ui_story then
				arg_131_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_134_9 = 0
			local var_134_10 = 0.575

			if var_134_9 < arg_131_1.time_ and arg_131_1.time_ <= var_134_9 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				local var_134_11 = arg_131_1:FormatText(StoryNameCfg[6].name)

				arg_131_1.leftNameTxt_.text = var_134_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, true)
				arg_131_1.iconController_:SetSelectedState("hero")

				arg_131_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1284")

				arg_131_1.callingController_:SetSelectedState("normal")

				arg_131_1.keyicon_.color = Color.New(1, 1, 1)
				arg_131_1.icon_.color = Color.New(1, 1, 1)

				local var_134_12 = arg_131_1:GetWordFromCfg(321091032)
				local var_134_13 = arg_131_1:FormatText(var_134_12.content)

				arg_131_1.text_.text = var_134_13

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_14 = 23
				local var_134_15 = utf8.len(var_134_13)
				local var_134_16 = var_134_14 <= 0 and var_134_10 or var_134_10 * (var_134_15 / var_134_14)

				if var_134_16 > 0 and var_134_10 < var_134_16 then
					arg_131_1.talkMaxDuration = var_134_16

					if var_134_16 + var_134_9 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_16 + var_134_9
					end
				end

				arg_131_1.text_.text = var_134_13
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091032", "story_v_out_321091.awb") ~= 0 then
					local var_134_17 = manager.audio:GetVoiceLength("story_v_out_321091", "321091032", "story_v_out_321091.awb") / 1000

					if var_134_17 + var_134_9 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_17 + var_134_9
					end

					if var_134_12.prefab_name ~= "" and arg_131_1.actors_[var_134_12.prefab_name] ~= nil then
						local var_134_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_12.prefab_name].transform, "story_v_out_321091", "321091032", "story_v_out_321091.awb")

						arg_131_1:RecordAudio("321091032", var_134_18)
						arg_131_1:RecordAudio("321091032", var_134_18)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_321091", "321091032", "story_v_out_321091.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_321091", "321091032", "story_v_out_321091.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_19 = math.max(var_134_10, arg_131_1.talkMaxDuration)

			if var_134_9 <= arg_131_1.time_ and arg_131_1.time_ < var_134_9 + var_134_19 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_9) / var_134_19

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_9 + var_134_19 and arg_131_1.time_ < var_134_9 + var_134_19 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play321091033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 321091033
		arg_135_1.duration_ = 15.43

		local var_135_0 = {
			zh = 5.7,
			ja = 15.433
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
				arg_135_0:Play321091034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = arg_135_1.actors_["10102ui_story"]
			local var_138_1 = 0

			if var_138_1 < arg_135_1.time_ and arg_135_1.time_ <= var_138_1 + arg_138_0 and not isNil(var_138_0) and arg_135_1.var_.characterEffect10102ui_story == nil then
				arg_135_1.var_.characterEffect10102ui_story = var_138_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_2 = 0.200000002980232

			if var_138_1 <= arg_135_1.time_ and arg_135_1.time_ < var_138_1 + var_138_2 and not isNil(var_138_0) then
				local var_138_3 = (arg_135_1.time_ - var_138_1) / var_138_2

				if arg_135_1.var_.characterEffect10102ui_story and not isNil(var_138_0) then
					local var_138_4 = Mathf.Lerp(0, 0.5, var_138_3)

					arg_135_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_135_1.var_.characterEffect10102ui_story.fillRatio = var_138_4
				end
			end

			if arg_135_1.time_ >= var_138_1 + var_138_2 and arg_135_1.time_ < var_138_1 + var_138_2 + arg_138_0 and not isNil(var_138_0) and arg_135_1.var_.characterEffect10102ui_story then
				local var_138_5 = 0.5

				arg_135_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_135_1.var_.characterEffect10102ui_story.fillRatio = var_138_5
			end

			local var_138_6 = 0
			local var_138_7 = 0.4

			if var_138_6 < arg_135_1.time_ and arg_135_1.time_ <= var_138_6 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				local var_138_8 = arg_135_1:FormatText(StoryNameCfg[1049].name)

				arg_135_1.leftNameTxt_.text = var_138_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_9 = arg_135_1:GetWordFromCfg(321091033)
				local var_138_10 = arg_135_1:FormatText(var_138_9.content)

				arg_135_1.text_.text = var_138_10

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_11 = 16
				local var_138_12 = utf8.len(var_138_10)
				local var_138_13 = var_138_11 <= 0 and var_138_7 or var_138_7 * (var_138_12 / var_138_11)

				if var_138_13 > 0 and var_138_7 < var_138_13 then
					arg_135_1.talkMaxDuration = var_138_13

					if var_138_13 + var_138_6 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_13 + var_138_6
					end
				end

				arg_135_1.text_.text = var_138_10
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091033", "story_v_out_321091.awb") ~= 0 then
					local var_138_14 = manager.audio:GetVoiceLength("story_v_out_321091", "321091033", "story_v_out_321091.awb") / 1000

					if var_138_14 + var_138_6 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_14 + var_138_6
					end

					if var_138_9.prefab_name ~= "" and arg_135_1.actors_[var_138_9.prefab_name] ~= nil then
						local var_138_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_9.prefab_name].transform, "story_v_out_321091", "321091033", "story_v_out_321091.awb")

						arg_135_1:RecordAudio("321091033", var_138_15)
						arg_135_1:RecordAudio("321091033", var_138_15)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_321091", "321091033", "story_v_out_321091.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_321091", "321091033", "story_v_out_321091.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_16 = math.max(var_138_7, arg_135_1.talkMaxDuration)

			if var_138_6 <= arg_135_1.time_ and arg_135_1.time_ < var_138_6 + var_138_16 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_6) / var_138_16

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_6 + var_138_16 and arg_135_1.time_ < var_138_6 + var_138_16 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play321091034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 321091034
		arg_139_1.duration_ = 16.07

		local var_139_0 = {
			zh = 7.1,
			ja = 16.066
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
				arg_139_0:Play321091035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = manager.ui.mainCamera.transform
			local var_142_1 = 1.4

			if var_142_1 < arg_139_1.time_ and arg_139_1.time_ <= var_142_1 + arg_142_0 then
				local var_142_2 = arg_139_1.var_.effect777
				local var_142_3
				local var_142_4 = var_142_0

				if not var_142_2 then
					var_142_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), var_142_4)
					var_142_2.name = "777"
					arg_139_1.var_.effect777 = var_142_2
				else
					var_142_2.transform:SetParent(var_142_4)
				end

				var_142_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_142_2.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_142_5 = manager.ui.mainCameraCom_
				local var_142_6 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_142_5.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_142_7 = var_142_2.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_142_8 = 15
				local var_142_9 = 2 * var_142_8 * Mathf.Tan(var_142_5.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_142_5.aspect
				local var_142_10 = 1
				local var_142_11 = 1.7777777777777777

				if var_142_11 < var_142_5.aspect then
					var_142_10 = var_142_9 / (2 * var_142_8 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_142_11)
				end

				for iter_142_0, iter_142_1 in ipairs(var_142_7) do
					local var_142_12 = iter_142_1.transform.localScale

					iter_142_1.transform.localScale = Vector3.New(var_142_12.x / var_142_6 * var_142_10, var_142_12.y / var_142_6, var_142_12.z)
				end
			end

			local var_142_13 = manager.ui.mainCamera.transform
			local var_142_14 = 2.08333333333333

			if var_142_14 < arg_139_1.time_ and arg_139_1.time_ <= var_142_14 + arg_142_0 then
				local var_142_15 = arg_139_1.var_.effect777

				if var_142_15 then
					Object.Destroy(var_142_15)

					arg_139_1.var_.effect777 = nil
				end
			end

			local var_142_16 = 0

			if var_142_16 < arg_139_1.time_ and arg_139_1.time_ <= var_142_16 + arg_142_0 then
				arg_139_1.allBtn_.enabled = false
			end

			local var_142_17 = 1.88333333333333

			if arg_139_1.time_ >= var_142_16 + var_142_17 and arg_139_1.time_ < var_142_16 + var_142_17 + arg_142_0 then
				arg_139_1.allBtn_.enabled = true
			end

			local var_142_18 = 1.3
			local var_142_19 = 1

			if var_142_18 < arg_139_1.time_ and arg_139_1.time_ <= var_142_18 + arg_142_0 then
				local var_142_20 = "play"
				local var_142_21 = "effect"

				arg_139_1:AudioAction(var_142_20, var_142_21, "se_story_140", "se_story_140_tear", "")
			end

			local var_142_22 = 0
			local var_142_23 = 0.5

			if var_142_22 < arg_139_1.time_ and arg_139_1.time_ <= var_142_22 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				local var_142_24 = arg_139_1:FormatText(StoryNameCfg[1049].name)

				arg_139_1.leftNameTxt_.text = var_142_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_25 = arg_139_1:GetWordFromCfg(321091034)
				local var_142_26 = arg_139_1:FormatText(var_142_25.content)

				arg_139_1.text_.text = var_142_26

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_27 = 20
				local var_142_28 = utf8.len(var_142_26)
				local var_142_29 = var_142_27 <= 0 and var_142_23 or var_142_23 * (var_142_28 / var_142_27)

				if var_142_29 > 0 and var_142_23 < var_142_29 then
					arg_139_1.talkMaxDuration = var_142_29

					if var_142_29 + var_142_22 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_29 + var_142_22
					end
				end

				arg_139_1.text_.text = var_142_26
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091034", "story_v_out_321091.awb") ~= 0 then
					local var_142_30 = manager.audio:GetVoiceLength("story_v_out_321091", "321091034", "story_v_out_321091.awb") / 1000

					if var_142_30 + var_142_22 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_30 + var_142_22
					end

					if var_142_25.prefab_name ~= "" and arg_139_1.actors_[var_142_25.prefab_name] ~= nil then
						local var_142_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_25.prefab_name].transform, "story_v_out_321091", "321091034", "story_v_out_321091.awb")

						arg_139_1:RecordAudio("321091034", var_142_31)
						arg_139_1:RecordAudio("321091034", var_142_31)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_321091", "321091034", "story_v_out_321091.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_321091", "321091034", "story_v_out_321091.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_32 = math.max(var_142_23, arg_139_1.talkMaxDuration)

			if var_142_22 <= arg_139_1.time_ and arg_139_1.time_ < var_142_22 + var_142_32 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_22) / var_142_32

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_22 + var_142_32 and arg_139_1.time_ < var_142_22 + var_142_32 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play321091035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 321091035
		arg_143_1.duration_ = 5

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play321091036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = 0
			local var_146_1 = 1.375

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

				local var_146_2 = arg_143_1:GetWordFromCfg(321091035)
				local var_146_3 = arg_143_1:FormatText(var_146_2.content)

				arg_143_1.text_.text = var_146_3

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_4 = 55
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
	Play321091036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 321091036
		arg_147_1.duration_ = 5.57

		local var_147_0 = {
			zh = 3.566,
			ja = 5.566
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
				arg_147_0:Play321091037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = arg_147_1.actors_["10104ui_story"]
			local var_150_1 = 0

			if var_150_1 < arg_147_1.time_ and arg_147_1.time_ <= var_150_1 + arg_150_0 and not isNil(var_150_0) and arg_147_1.var_.characterEffect10104ui_story == nil then
				arg_147_1.var_.characterEffect10104ui_story = var_150_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_2 = 0.200000002980232

			if var_150_1 <= arg_147_1.time_ and arg_147_1.time_ < var_150_1 + var_150_2 and not isNil(var_150_0) then
				local var_150_3 = (arg_147_1.time_ - var_150_1) / var_150_2

				if arg_147_1.var_.characterEffect10104ui_story and not isNil(var_150_0) then
					arg_147_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_147_1.time_ >= var_150_1 + var_150_2 and arg_147_1.time_ < var_150_1 + var_150_2 + arg_150_0 and not isNil(var_150_0) and arg_147_1.var_.characterEffect10104ui_story then
				arg_147_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_150_4 = 0
			local var_150_5 = 0.425

			if var_150_4 < arg_147_1.time_ and arg_147_1.time_ <= var_150_4 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				local var_150_6 = arg_147_1:FormatText(StoryNameCfg[1030].name)

				arg_147_1.leftNameTxt_.text = var_150_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, true)
				arg_147_1.iconController_:SetSelectedState("hero")

				arg_147_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_147_1.callingController_:SetSelectedState("normal")

				arg_147_1.keyicon_.color = Color.New(1, 1, 1)
				arg_147_1.icon_.color = Color.New(1, 1, 1)

				local var_150_7 = arg_147_1:GetWordFromCfg(321091036)
				local var_150_8 = arg_147_1:FormatText(var_150_7.content)

				arg_147_1.text_.text = var_150_8

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_9 = 17
				local var_150_10 = utf8.len(var_150_8)
				local var_150_11 = var_150_9 <= 0 and var_150_5 or var_150_5 * (var_150_10 / var_150_9)

				if var_150_11 > 0 and var_150_5 < var_150_11 then
					arg_147_1.talkMaxDuration = var_150_11

					if var_150_11 + var_150_4 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_11 + var_150_4
					end
				end

				arg_147_1.text_.text = var_150_8
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091036", "story_v_out_321091.awb") ~= 0 then
					local var_150_12 = manager.audio:GetVoiceLength("story_v_out_321091", "321091036", "story_v_out_321091.awb") / 1000

					if var_150_12 + var_150_4 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_12 + var_150_4
					end

					if var_150_7.prefab_name ~= "" and arg_147_1.actors_[var_150_7.prefab_name] ~= nil then
						local var_150_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_7.prefab_name].transform, "story_v_out_321091", "321091036", "story_v_out_321091.awb")

						arg_147_1:RecordAudio("321091036", var_150_13)
						arg_147_1:RecordAudio("321091036", var_150_13)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_321091", "321091036", "story_v_out_321091.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_321091", "321091036", "story_v_out_321091.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_14 = math.max(var_150_5, arg_147_1.talkMaxDuration)

			if var_150_4 <= arg_147_1.time_ and arg_147_1.time_ < var_150_4 + var_150_14 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_4) / var_150_14

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_4 + var_150_14 and arg_147_1.time_ < var_150_4 + var_150_14 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play321091037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 321091037
		arg_151_1.duration_ = 6.26

		local var_151_0 = {
			zh = 5.724999999999,
			ja = 6.257999999999
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
				arg_151_0:Play321091038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = "ST0507"

			if arg_151_1.bgs_[var_154_0] == nil then
				local var_154_1 = Object.Instantiate(arg_151_1.paintGo_)

				var_154_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_154_0)
				var_154_1.name = var_154_0
				var_154_1.transform.parent = arg_151_1.stage_.transform
				var_154_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_151_1.bgs_[var_154_0] = var_154_1
			end

			local var_154_2 = 1.43333333333333

			if var_154_2 < arg_151_1.time_ and arg_151_1.time_ <= var_154_2 + arg_154_0 then
				local var_154_3 = manager.ui.mainCamera.transform.localPosition
				local var_154_4 = Vector3.New(0, 0, 10) + Vector3.New(var_154_3.x, var_154_3.y, 0)
				local var_154_5 = arg_151_1.bgs_.ST0507

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
					if iter_154_0 ~= "ST0507" then
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

			local var_154_19 = 1.43333333333333

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

			local var_154_23 = 1.43333333333333

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

			local var_154_29 = arg_151_1.actors_["10104ui_story"]
			local var_154_30 = 0

			if var_154_30 < arg_151_1.time_ and arg_151_1.time_ <= var_154_30 + arg_154_0 and not isNil(var_154_29) and arg_151_1.var_.characterEffect10104ui_story == nil then
				arg_151_1.var_.characterEffect10104ui_story = var_154_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_31 = 0.200000002980232

			if var_154_30 <= arg_151_1.time_ and arg_151_1.time_ < var_154_30 + var_154_31 and not isNil(var_154_29) then
				local var_154_32 = (arg_151_1.time_ - var_154_30) / var_154_31

				if arg_151_1.var_.characterEffect10104ui_story and not isNil(var_154_29) then
					local var_154_33 = Mathf.Lerp(0, 0.5, var_154_32)

					arg_151_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_151_1.var_.characterEffect10104ui_story.fillRatio = var_154_33
				end
			end

			if arg_151_1.time_ >= var_154_30 + var_154_31 and arg_151_1.time_ < var_154_30 + var_154_31 + arg_154_0 and not isNil(var_154_29) and arg_151_1.var_.characterEffect10104ui_story then
				local var_154_34 = 0.5

				arg_151_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_151_1.var_.characterEffect10104ui_story.fillRatio = var_154_34
			end

			local var_154_35 = 1.43333333333333
			local var_154_36 = 1

			if var_154_35 < arg_151_1.time_ and arg_151_1.time_ <= var_154_35 + arg_154_0 then
				local var_154_37 = "play"
				local var_154_38 = "effect"

				arg_151_1:AudioAction(var_154_37, var_154_38, "se_story_140", "se_story_140_amb_lfe", "")
			end

			local var_154_39 = 1.43333333333333
			local var_154_40 = 1

			if var_154_39 < arg_151_1.time_ and arg_151_1.time_ <= var_154_39 + arg_154_0 then
				local var_154_41 = "play"
				local var_154_42 = "effect"

				arg_151_1:AudioAction(var_154_41, var_154_42, "se_story_140", "se_story_140_music_quake_down", "")
			end

			if arg_151_1.frameCnt_ <= 1 then
				arg_151_1.dialog_:SetActive(false)
			end

			local var_154_43 = 3.924999999999
			local var_154_44 = 0.075

			if var_154_43 < arg_151_1.time_ and arg_151_1.time_ <= var_154_43 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0

				arg_151_1.dialog_:SetActive(true)

				arg_151_1.dialogCg_.alpha = 0

				local var_154_45 = LeanTween.value(arg_151_1.dialog_, 0, 1, 0.3)

				var_154_45:setOnUpdate(LuaHelper.FloatAction(function(arg_155_0)
					arg_151_1.dialogCg_.alpha = arg_155_0
				end))
				var_154_45:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_151_1.dialog_)
					var_154_45:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_151_1.duration_ = arg_151_1.duration_ + 0.3

				SetActive(arg_151_1.leftNameGo_, true)

				local var_154_46 = arg_151_1:FormatText(StoryNameCfg[600].name)

				arg_151_1.leftNameTxt_.text = var_154_46

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, true)
				arg_151_1.iconController_:SetSelectedState("hero")

				arg_151_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10062")

				arg_151_1.callingController_:SetSelectedState("normal")

				arg_151_1.keyicon_.color = Color.New(1, 1, 1)
				arg_151_1.icon_.color = Color.New(1, 1, 1)

				local var_154_47 = arg_151_1:GetWordFromCfg(321091037)
				local var_154_48 = arg_151_1:FormatText(var_154_47.content)

				arg_151_1.text_.text = var_154_48

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_49 = 3
				local var_154_50 = utf8.len(var_154_48)
				local var_154_51 = var_154_49 <= 0 and var_154_44 or var_154_44 * (var_154_50 / var_154_49)

				if var_154_51 > 0 and var_154_44 < var_154_51 then
					arg_151_1.talkMaxDuration = var_154_51
					var_154_43 = var_154_43 + 0.3

					if var_154_51 + var_154_43 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_51 + var_154_43
					end
				end

				arg_151_1.text_.text = var_154_48
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091037", "story_v_out_321091.awb") ~= 0 then
					local var_154_52 = manager.audio:GetVoiceLength("story_v_out_321091", "321091037", "story_v_out_321091.awb") / 1000

					if var_154_52 + var_154_43 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_52 + var_154_43
					end

					if var_154_47.prefab_name ~= "" and arg_151_1.actors_[var_154_47.prefab_name] ~= nil then
						local var_154_53 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_47.prefab_name].transform, "story_v_out_321091", "321091037", "story_v_out_321091.awb")

						arg_151_1:RecordAudio("321091037", var_154_53)
						arg_151_1:RecordAudio("321091037", var_154_53)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_321091", "321091037", "story_v_out_321091.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_321091", "321091037", "story_v_out_321091.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_54 = var_154_43 + 0.3
			local var_154_55 = math.max(var_154_44, arg_151_1.talkMaxDuration)

			if var_154_54 <= arg_151_1.time_ and arg_151_1.time_ < var_154_54 + var_154_55 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_54) / var_154_55

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_54 + var_154_55 and arg_151_1.time_ < var_154_54 + var_154_55 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play321091038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 321091038
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play321091039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = 0.05
			local var_160_1 = 1

			if var_160_0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_0 + arg_160_0 then
				local var_160_2 = "play"
				local var_160_3 = "effect"

				arg_157_1:AudioAction(var_160_2, var_160_3, "se_story_140", "se_story_140_hit03", "")
			end

			local var_160_4 = 0
			local var_160_5 = 1.1

			if var_160_4 < arg_157_1.time_ and arg_157_1.time_ <= var_160_4 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, false)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_6 = arg_157_1:GetWordFromCfg(321091038)
				local var_160_7 = arg_157_1:FormatText(var_160_6.content)

				arg_157_1.text_.text = var_160_7

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_8 = 44
				local var_160_9 = utf8.len(var_160_7)
				local var_160_10 = var_160_8 <= 0 and var_160_5 or var_160_5 * (var_160_9 / var_160_8)

				if var_160_10 > 0 and var_160_5 < var_160_10 then
					arg_157_1.talkMaxDuration = var_160_10

					if var_160_10 + var_160_4 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_10 + var_160_4
					end
				end

				arg_157_1.text_.text = var_160_7
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_11 = math.max(var_160_5, arg_157_1.talkMaxDuration)

			if var_160_4 <= arg_157_1.time_ and arg_157_1.time_ < var_160_4 + var_160_11 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_4) / var_160_11

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_4 + var_160_11 and arg_157_1.time_ < var_160_4 + var_160_11 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play321091039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 321091039
		arg_161_1.duration_ = 6.87

		local var_161_0 = {
			zh = 3.833,
			ja = 6.866
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
				arg_161_0:Play321091040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 0
			local var_164_1 = 0.4

			if var_164_0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				local var_164_2 = arg_161_1:FormatText(StoryNameCfg[600].name)

				arg_161_1.leftNameTxt_.text = var_164_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, true)
				arg_161_1.iconController_:SetSelectedState("hero")

				arg_161_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10062")

				arg_161_1.callingController_:SetSelectedState("normal")

				arg_161_1.keyicon_.color = Color.New(1, 1, 1)
				arg_161_1.icon_.color = Color.New(1, 1, 1)

				local var_164_3 = arg_161_1:GetWordFromCfg(321091039)
				local var_164_4 = arg_161_1:FormatText(var_164_3.content)

				arg_161_1.text_.text = var_164_4

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_5 = 16
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

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091039", "story_v_out_321091.awb") ~= 0 then
					local var_164_8 = manager.audio:GetVoiceLength("story_v_out_321091", "321091039", "story_v_out_321091.awb") / 1000

					if var_164_8 + var_164_0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_8 + var_164_0
					end

					if var_164_3.prefab_name ~= "" and arg_161_1.actors_[var_164_3.prefab_name] ~= nil then
						local var_164_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_3.prefab_name].transform, "story_v_out_321091", "321091039", "story_v_out_321091.awb")

						arg_161_1:RecordAudio("321091039", var_164_9)
						arg_161_1:RecordAudio("321091039", var_164_9)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_321091", "321091039", "story_v_out_321091.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_321091", "321091039", "story_v_out_321091.awb")
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
	Play321091040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 321091040
		arg_165_1.duration_ = 11.5

		local var_165_0 = {
			zh = 9.166,
			ja = 11.5
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
				arg_165_0:Play321091041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = 0
			local var_168_1 = 0.85

			if var_168_0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_0 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				local var_168_2 = arg_165_1:FormatText(StoryNameCfg[600].name)

				arg_165_1.leftNameTxt_.text = var_168_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, true)
				arg_165_1.iconController_:SetSelectedState("hero")

				arg_165_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10062")

				arg_165_1.callingController_:SetSelectedState("normal")

				arg_165_1.keyicon_.color = Color.New(1, 1, 1)
				arg_165_1.icon_.color = Color.New(1, 1, 1)

				local var_168_3 = arg_165_1:GetWordFromCfg(321091040)
				local var_168_4 = arg_165_1:FormatText(var_168_3.content)

				arg_165_1.text_.text = var_168_4

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_5 = 34
				local var_168_6 = utf8.len(var_168_4)
				local var_168_7 = var_168_5 <= 0 and var_168_1 or var_168_1 * (var_168_6 / var_168_5)

				if var_168_7 > 0 and var_168_1 < var_168_7 then
					arg_165_1.talkMaxDuration = var_168_7

					if var_168_7 + var_168_0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_7 + var_168_0
					end
				end

				arg_165_1.text_.text = var_168_4
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091040", "story_v_out_321091.awb") ~= 0 then
					local var_168_8 = manager.audio:GetVoiceLength("story_v_out_321091", "321091040", "story_v_out_321091.awb") / 1000

					if var_168_8 + var_168_0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_8 + var_168_0
					end

					if var_168_3.prefab_name ~= "" and arg_165_1.actors_[var_168_3.prefab_name] ~= nil then
						local var_168_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_3.prefab_name].transform, "story_v_out_321091", "321091040", "story_v_out_321091.awb")

						arg_165_1:RecordAudio("321091040", var_168_9)
						arg_165_1:RecordAudio("321091040", var_168_9)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_321091", "321091040", "story_v_out_321091.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_321091", "321091040", "story_v_out_321091.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_10 = math.max(var_168_1, arg_165_1.talkMaxDuration)

			if var_168_0 <= arg_165_1.time_ and arg_165_1.time_ < var_168_0 + var_168_10 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_0) / var_168_10

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_0 + var_168_10 and arg_165_1.time_ < var_168_0 + var_168_10 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play321091041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 321091041
		arg_169_1.duration_ = 8.1

		local var_169_0 = {
			zh = 6.033,
			ja = 8.1
		}
		local var_169_1 = manager.audio:GetLocalizationFlag()

		if var_169_0[var_169_1] ~= nil then
			arg_169_1.duration_ = var_169_0[var_169_1]
		end

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play321091042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = 0
			local var_172_1 = 0.7

			if var_172_0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_0 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				local var_172_2 = arg_169_1:FormatText(StoryNameCfg[224].name)

				arg_169_1.leftNameTxt_.text = var_172_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, true)
				arg_169_1.iconController_:SetSelectedState("hero")

				arg_169_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenma")

				arg_169_1.callingController_:SetSelectedState("normal")

				arg_169_1.keyicon_.color = Color.New(1, 1, 1)
				arg_169_1.icon_.color = Color.New(1, 1, 1)

				local var_172_3 = arg_169_1:GetWordFromCfg(321091041)
				local var_172_4 = arg_169_1:FormatText(var_172_3.content)

				arg_169_1.text_.text = var_172_4

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_5 = 28
				local var_172_6 = utf8.len(var_172_4)
				local var_172_7 = var_172_5 <= 0 and var_172_1 or var_172_1 * (var_172_6 / var_172_5)

				if var_172_7 > 0 and var_172_1 < var_172_7 then
					arg_169_1.talkMaxDuration = var_172_7

					if var_172_7 + var_172_0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_7 + var_172_0
					end
				end

				arg_169_1.text_.text = var_172_4
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091041", "story_v_out_321091.awb") ~= 0 then
					local var_172_8 = manager.audio:GetVoiceLength("story_v_out_321091", "321091041", "story_v_out_321091.awb") / 1000

					if var_172_8 + var_172_0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_8 + var_172_0
					end

					if var_172_3.prefab_name ~= "" and arg_169_1.actors_[var_172_3.prefab_name] ~= nil then
						local var_172_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_3.prefab_name].transform, "story_v_out_321091", "321091041", "story_v_out_321091.awb")

						arg_169_1:RecordAudio("321091041", var_172_9)
						arg_169_1:RecordAudio("321091041", var_172_9)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_321091", "321091041", "story_v_out_321091.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_321091", "321091041", "story_v_out_321091.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_10 = math.max(var_172_1, arg_169_1.talkMaxDuration)

			if var_172_0 <= arg_169_1.time_ and arg_169_1.time_ < var_172_0 + var_172_10 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_0) / var_172_10

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_0 + var_172_10 and arg_169_1.time_ < var_172_0 + var_172_10 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play321091042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 321091042
		arg_173_1.duration_ = 5.83

		local var_173_0 = {
			zh = 3.433,
			ja = 5.833
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
				arg_173_0:Play321091043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = 0
			local var_176_1 = 0.25

			if var_176_0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_0 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				local var_176_2 = arg_173_1:FormatText(StoryNameCfg[600].name)

				arg_173_1.leftNameTxt_.text = var_176_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, true)
				arg_173_1.iconController_:SetSelectedState("hero")

				arg_173_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10062")

				arg_173_1.callingController_:SetSelectedState("normal")

				arg_173_1.keyicon_.color = Color.New(1, 1, 1)
				arg_173_1.icon_.color = Color.New(1, 1, 1)

				local var_176_3 = arg_173_1:GetWordFromCfg(321091042)
				local var_176_4 = arg_173_1:FormatText(var_176_3.content)

				arg_173_1.text_.text = var_176_4

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_5 = 10
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

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091042", "story_v_out_321091.awb") ~= 0 then
					local var_176_8 = manager.audio:GetVoiceLength("story_v_out_321091", "321091042", "story_v_out_321091.awb") / 1000

					if var_176_8 + var_176_0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_8 + var_176_0
					end

					if var_176_3.prefab_name ~= "" and arg_173_1.actors_[var_176_3.prefab_name] ~= nil then
						local var_176_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_3.prefab_name].transform, "story_v_out_321091", "321091042", "story_v_out_321091.awb")

						arg_173_1:RecordAudio("321091042", var_176_9)
						arg_173_1:RecordAudio("321091042", var_176_9)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_321091", "321091042", "story_v_out_321091.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_321091", "321091042", "story_v_out_321091.awb")
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
	Play321091043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 321091043
		arg_177_1.duration_ = 5

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play321091044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = 0.9
			local var_180_1 = 1

			if var_180_0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_0 + arg_180_0 then
				local var_180_2 = "play"
				local var_180_3 = "effect"

				arg_177_1:AudioAction(var_180_2, var_180_3, "se_story_128", "se_story_128_fall", "")
			end

			local var_180_4 = 0
			local var_180_5 = 0.9

			if var_180_4 < arg_177_1.time_ and arg_177_1.time_ <= var_180_4 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, false)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_6 = arg_177_1:GetWordFromCfg(321091043)
				local var_180_7 = arg_177_1:FormatText(var_180_6.content)

				arg_177_1.text_.text = var_180_7

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_8 = 36
				local var_180_9 = utf8.len(var_180_7)
				local var_180_10 = var_180_8 <= 0 and var_180_5 or var_180_5 * (var_180_9 / var_180_8)

				if var_180_10 > 0 and var_180_5 < var_180_10 then
					arg_177_1.talkMaxDuration = var_180_10

					if var_180_10 + var_180_4 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_10 + var_180_4
					end
				end

				arg_177_1.text_.text = var_180_7
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)
				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_11 = math.max(var_180_5, arg_177_1.talkMaxDuration)

			if var_180_4 <= arg_177_1.time_ and arg_177_1.time_ < var_180_4 + var_180_11 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_4) / var_180_11

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_4 + var_180_11 and arg_177_1.time_ < var_180_4 + var_180_11 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play321091044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 321091044
		arg_181_1.duration_ = 8.9

		local var_181_0 = {
			zh = 6.233,
			ja = 8.9
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
				arg_181_0:Play321091045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = 0
			local var_184_1 = 0.5

			if var_184_0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_0 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				local var_184_2 = arg_181_1:FormatText(StoryNameCfg[600].name)

				arg_181_1.leftNameTxt_.text = var_184_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, true)
				arg_181_1.iconController_:SetSelectedState("hero")

				arg_181_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10062")

				arg_181_1.callingController_:SetSelectedState("normal")

				arg_181_1.keyicon_.color = Color.New(1, 1, 1)
				arg_181_1.icon_.color = Color.New(1, 1, 1)

				local var_184_3 = arg_181_1:GetWordFromCfg(321091044)
				local var_184_4 = arg_181_1:FormatText(var_184_3.content)

				arg_181_1.text_.text = var_184_4

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_5 = 20
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

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091044", "story_v_out_321091.awb") ~= 0 then
					local var_184_8 = manager.audio:GetVoiceLength("story_v_out_321091", "321091044", "story_v_out_321091.awb") / 1000

					if var_184_8 + var_184_0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_8 + var_184_0
					end

					if var_184_3.prefab_name ~= "" and arg_181_1.actors_[var_184_3.prefab_name] ~= nil then
						local var_184_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_3.prefab_name].transform, "story_v_out_321091", "321091044", "story_v_out_321091.awb")

						arg_181_1:RecordAudio("321091044", var_184_9)
						arg_181_1:RecordAudio("321091044", var_184_9)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_321091", "321091044", "story_v_out_321091.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_321091", "321091044", "story_v_out_321091.awb")
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
	Play321091045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 321091045
		arg_185_1.duration_ = 11.7

		local var_185_0 = {
			zh = 11.4,
			ja = 11.7
		}
		local var_185_1 = manager.audio:GetLocalizationFlag()

		if var_185_0[var_185_1] ~= nil then
			arg_185_1.duration_ = var_185_0[var_185_1]
		end

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play321091046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 0
			local var_188_1 = 1.025

			if var_188_0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_0 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				local var_188_2 = arg_185_1:FormatText(StoryNameCfg[600].name)

				arg_185_1.leftNameTxt_.text = var_188_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, true)
				arg_185_1.iconController_:SetSelectedState("hero")

				arg_185_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10062")

				arg_185_1.callingController_:SetSelectedState("normal")

				arg_185_1.keyicon_.color = Color.New(1, 1, 1)
				arg_185_1.icon_.color = Color.New(1, 1, 1)

				local var_188_3 = arg_185_1:GetWordFromCfg(321091045)
				local var_188_4 = arg_185_1:FormatText(var_188_3.content)

				arg_185_1.text_.text = var_188_4

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_5 = 41
				local var_188_6 = utf8.len(var_188_4)
				local var_188_7 = var_188_5 <= 0 and var_188_1 or var_188_1 * (var_188_6 / var_188_5)

				if var_188_7 > 0 and var_188_1 < var_188_7 then
					arg_185_1.talkMaxDuration = var_188_7

					if var_188_7 + var_188_0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_7 + var_188_0
					end
				end

				arg_185_1.text_.text = var_188_4
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091045", "story_v_out_321091.awb") ~= 0 then
					local var_188_8 = manager.audio:GetVoiceLength("story_v_out_321091", "321091045", "story_v_out_321091.awb") / 1000

					if var_188_8 + var_188_0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_8 + var_188_0
					end

					if var_188_3.prefab_name ~= "" and arg_185_1.actors_[var_188_3.prefab_name] ~= nil then
						local var_188_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_3.prefab_name].transform, "story_v_out_321091", "321091045", "story_v_out_321091.awb")

						arg_185_1:RecordAudio("321091045", var_188_9)
						arg_185_1:RecordAudio("321091045", var_188_9)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_321091", "321091045", "story_v_out_321091.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_321091", "321091045", "story_v_out_321091.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_10 = math.max(var_188_1, arg_185_1.talkMaxDuration)

			if var_188_0 <= arg_185_1.time_ and arg_185_1.time_ < var_188_0 + var_188_10 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_0) / var_188_10

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_0 + var_188_10 and arg_185_1.time_ < var_188_0 + var_188_10 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play321091046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 321091046
		arg_189_1.duration_ = 5.43

		local var_189_0 = {
			zh = 3.466,
			ja = 5.433
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
				arg_189_0:Play321091047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = 0
			local var_192_1 = 0.3

			if var_192_0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_0 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				local var_192_2 = arg_189_1:FormatText(StoryNameCfg[600].name)

				arg_189_1.leftNameTxt_.text = var_192_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, true)
				arg_189_1.iconController_:SetSelectedState("hero")

				arg_189_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10062")

				arg_189_1.callingController_:SetSelectedState("normal")

				arg_189_1.keyicon_.color = Color.New(1, 1, 1)
				arg_189_1.icon_.color = Color.New(1, 1, 1)

				local var_192_3 = arg_189_1:GetWordFromCfg(321091046)
				local var_192_4 = arg_189_1:FormatText(var_192_3.content)

				arg_189_1.text_.text = var_192_4

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_5 = 12
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

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091046", "story_v_out_321091.awb") ~= 0 then
					local var_192_8 = manager.audio:GetVoiceLength("story_v_out_321091", "321091046", "story_v_out_321091.awb") / 1000

					if var_192_8 + var_192_0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_8 + var_192_0
					end

					if var_192_3.prefab_name ~= "" and arg_189_1.actors_[var_192_3.prefab_name] ~= nil then
						local var_192_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_3.prefab_name].transform, "story_v_out_321091", "321091046", "story_v_out_321091.awb")

						arg_189_1:RecordAudio("321091046", var_192_9)
						arg_189_1:RecordAudio("321091046", var_192_9)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_321091", "321091046", "story_v_out_321091.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_321091", "321091046", "story_v_out_321091.awb")
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
	Play321091047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 321091047
		arg_193_1.duration_ = 5

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play321091048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = 0
			local var_196_1 = 1.025

			if var_196_0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_0 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, false)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_2 = arg_193_1:GetWordFromCfg(321091047)
				local var_196_3 = arg_193_1:FormatText(var_196_2.content)

				arg_193_1.text_.text = var_196_3

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_4 = 41
				local var_196_5 = utf8.len(var_196_3)
				local var_196_6 = var_196_4 <= 0 and var_196_1 or var_196_1 * (var_196_5 / var_196_4)

				if var_196_6 > 0 and var_196_1 < var_196_6 then
					arg_193_1.talkMaxDuration = var_196_6

					if var_196_6 + var_196_0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_6 + var_196_0
					end
				end

				arg_193_1.text_.text = var_196_3
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_7 = math.max(var_196_1, arg_193_1.talkMaxDuration)

			if var_196_0 <= arg_193_1.time_ and arg_193_1.time_ < var_196_0 + var_196_7 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_0) / var_196_7

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_0 + var_196_7 and arg_193_1.time_ < var_196_0 + var_196_7 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play321091048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 321091048
		arg_197_1.duration_ = 15.47

		local var_197_0 = {
			zh = 6.933,
			ja = 15.466
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
				arg_197_0:Play321091049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = 0
			local var_200_1 = 0.725

			if var_200_0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_0 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				local var_200_2 = arg_197_1:FormatText(StoryNameCfg[600].name)

				arg_197_1.leftNameTxt_.text = var_200_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, true)
				arg_197_1.iconController_:SetSelectedState("hero")

				arg_197_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10062")

				arg_197_1.callingController_:SetSelectedState("normal")

				arg_197_1.keyicon_.color = Color.New(1, 1, 1)
				arg_197_1.icon_.color = Color.New(1, 1, 1)

				local var_200_3 = arg_197_1:GetWordFromCfg(321091048)
				local var_200_4 = arg_197_1:FormatText(var_200_3.content)

				arg_197_1.text_.text = var_200_4

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_5 = 29
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

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091048", "story_v_out_321091.awb") ~= 0 then
					local var_200_8 = manager.audio:GetVoiceLength("story_v_out_321091", "321091048", "story_v_out_321091.awb") / 1000

					if var_200_8 + var_200_0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_8 + var_200_0
					end

					if var_200_3.prefab_name ~= "" and arg_197_1.actors_[var_200_3.prefab_name] ~= nil then
						local var_200_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_3.prefab_name].transform, "story_v_out_321091", "321091048", "story_v_out_321091.awb")

						arg_197_1:RecordAudio("321091048", var_200_9)
						arg_197_1:RecordAudio("321091048", var_200_9)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_321091", "321091048", "story_v_out_321091.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_321091", "321091048", "story_v_out_321091.awb")
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
	Play321091049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 321091049
		arg_201_1.duration_ = 17.37

		local var_201_0 = {
			zh = 9.633,
			ja = 17.366
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
				arg_201_0:Play321091050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = 0
			local var_204_1 = 1.075

			if var_204_0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_0 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				local var_204_2 = arg_201_1:FormatText(StoryNameCfg[672].name)

				arg_201_1.leftNameTxt_.text = var_204_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, true)
				arg_201_1.iconController_:SetSelectedState("hero")

				arg_201_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_201_1.callingController_:SetSelectedState("normal")

				arg_201_1.keyicon_.color = Color.New(1, 1, 1)
				arg_201_1.icon_.color = Color.New(1, 1, 1)

				local var_204_3 = arg_201_1:GetWordFromCfg(321091049)
				local var_204_4 = arg_201_1:FormatText(var_204_3.content)

				arg_201_1.text_.text = var_204_4

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_5 = 43
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

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091049", "story_v_out_321091.awb") ~= 0 then
					local var_204_8 = manager.audio:GetVoiceLength("story_v_out_321091", "321091049", "story_v_out_321091.awb") / 1000

					if var_204_8 + var_204_0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_8 + var_204_0
					end

					if var_204_3.prefab_name ~= "" and arg_201_1.actors_[var_204_3.prefab_name] ~= nil then
						local var_204_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_3.prefab_name].transform, "story_v_out_321091", "321091049", "story_v_out_321091.awb")

						arg_201_1:RecordAudio("321091049", var_204_9)
						arg_201_1:RecordAudio("321091049", var_204_9)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_321091", "321091049", "story_v_out_321091.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_321091", "321091049", "story_v_out_321091.awb")
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
	Play321091050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 321091050
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play321091051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = 0
			local var_208_1 = 1.3

			if var_208_0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_0 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, false)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_2 = arg_205_1:GetWordFromCfg(321091050)
				local var_208_3 = arg_205_1:FormatText(var_208_2.content)

				arg_205_1.text_.text = var_208_3

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_4 = 52
				local var_208_5 = utf8.len(var_208_3)
				local var_208_6 = var_208_4 <= 0 and var_208_1 or var_208_1 * (var_208_5 / var_208_4)

				if var_208_6 > 0 and var_208_1 < var_208_6 then
					arg_205_1.talkMaxDuration = var_208_6

					if var_208_6 + var_208_0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_6 + var_208_0
					end
				end

				arg_205_1.text_.text = var_208_3
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)
				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_7 = math.max(var_208_1, arg_205_1.talkMaxDuration)

			if var_208_0 <= arg_205_1.time_ and arg_205_1.time_ < var_208_0 + var_208_7 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_0) / var_208_7

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_0 + var_208_7 and arg_205_1.time_ < var_208_0 + var_208_7 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play321091051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 321091051
		arg_209_1.duration_ = 5

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play321091052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = 0
			local var_212_1 = 1.325

			if var_212_0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_0 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, false)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_2 = arg_209_1:GetWordFromCfg(321091051)
				local var_212_3 = arg_209_1:FormatText(var_212_2.content)

				arg_209_1.text_.text = var_212_3

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_4 = 53
				local var_212_5 = utf8.len(var_212_3)
				local var_212_6 = var_212_4 <= 0 and var_212_1 or var_212_1 * (var_212_5 / var_212_4)

				if var_212_6 > 0 and var_212_1 < var_212_6 then
					arg_209_1.talkMaxDuration = var_212_6

					if var_212_6 + var_212_0 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_6 + var_212_0
					end
				end

				arg_209_1.text_.text = var_212_3
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)
				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_7 = math.max(var_212_1, arg_209_1.talkMaxDuration)

			if var_212_0 <= arg_209_1.time_ and arg_209_1.time_ < var_212_0 + var_212_7 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_0) / var_212_7

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_0 + var_212_7 and arg_209_1.time_ < var_212_0 + var_212_7 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play321091052 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 321091052
		arg_213_1.duration_ = 9.2

		local var_213_0 = {
			zh = 6.4,
			ja = 9.2
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
				arg_213_0:Play321091053(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = 0
			local var_216_1 = 0.575

			if var_216_0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_0 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				local var_216_2 = arg_213_1:FormatText(StoryNameCfg[600].name)

				arg_213_1.leftNameTxt_.text = var_216_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, true)
				arg_213_1.iconController_:SetSelectedState("hero")

				arg_213_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10062")

				arg_213_1.callingController_:SetSelectedState("normal")

				arg_213_1.keyicon_.color = Color.New(1, 1, 1)
				arg_213_1.icon_.color = Color.New(1, 1, 1)

				local var_216_3 = arg_213_1:GetWordFromCfg(321091052)
				local var_216_4 = arg_213_1:FormatText(var_216_3.content)

				arg_213_1.text_.text = var_216_4

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_5 = 23
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

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091052", "story_v_out_321091.awb") ~= 0 then
					local var_216_8 = manager.audio:GetVoiceLength("story_v_out_321091", "321091052", "story_v_out_321091.awb") / 1000

					if var_216_8 + var_216_0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_8 + var_216_0
					end

					if var_216_3.prefab_name ~= "" and arg_213_1.actors_[var_216_3.prefab_name] ~= nil then
						local var_216_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_3.prefab_name].transform, "story_v_out_321091", "321091052", "story_v_out_321091.awb")

						arg_213_1:RecordAudio("321091052", var_216_9)
						arg_213_1:RecordAudio("321091052", var_216_9)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_321091", "321091052", "story_v_out_321091.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_321091", "321091052", "story_v_out_321091.awb")
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
	Play321091053 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 321091053
		arg_217_1.duration_ = 17.83

		local var_217_0 = {
			zh = 12.6,
			ja = 17.833
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
				arg_217_0:Play321091054(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = 0
			local var_220_1 = 1.25

			if var_220_0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_0 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				local var_220_2 = arg_217_1:FormatText(StoryNameCfg[600].name)

				arg_217_1.leftNameTxt_.text = var_220_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, true)
				arg_217_1.iconController_:SetSelectedState("hero")

				arg_217_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10062")

				arg_217_1.callingController_:SetSelectedState("normal")

				arg_217_1.keyicon_.color = Color.New(1, 1, 1)
				arg_217_1.icon_.color = Color.New(1, 1, 1)

				local var_220_3 = arg_217_1:GetWordFromCfg(321091053)
				local var_220_4 = arg_217_1:FormatText(var_220_3.content)

				arg_217_1.text_.text = var_220_4

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_5 = 50
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

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091053", "story_v_out_321091.awb") ~= 0 then
					local var_220_8 = manager.audio:GetVoiceLength("story_v_out_321091", "321091053", "story_v_out_321091.awb") / 1000

					if var_220_8 + var_220_0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_8 + var_220_0
					end

					if var_220_3.prefab_name ~= "" and arg_217_1.actors_[var_220_3.prefab_name] ~= nil then
						local var_220_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_3.prefab_name].transform, "story_v_out_321091", "321091053", "story_v_out_321091.awb")

						arg_217_1:RecordAudio("321091053", var_220_9)
						arg_217_1:RecordAudio("321091053", var_220_9)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_321091", "321091053", "story_v_out_321091.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_321091", "321091053", "story_v_out_321091.awb")
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
	Play321091054 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 321091054
		arg_221_1.duration_ = 23.6

		local var_221_0 = {
			zh = 10.066,
			ja = 23.6
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
				arg_221_0:Play321091055(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = 0
			local var_224_1 = 1

			if var_224_0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_0 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				local var_224_2 = arg_221_1:FormatText(StoryNameCfg[600].name)

				arg_221_1.leftNameTxt_.text = var_224_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, true)
				arg_221_1.iconController_:SetSelectedState("hero")

				arg_221_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10062")

				arg_221_1.callingController_:SetSelectedState("normal")

				arg_221_1.keyicon_.color = Color.New(1, 1, 1)
				arg_221_1.icon_.color = Color.New(1, 1, 1)

				local var_224_3 = arg_221_1:GetWordFromCfg(321091054)
				local var_224_4 = arg_221_1:FormatText(var_224_3.content)

				arg_221_1.text_.text = var_224_4

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_5 = 40
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

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091054", "story_v_out_321091.awb") ~= 0 then
					local var_224_8 = manager.audio:GetVoiceLength("story_v_out_321091", "321091054", "story_v_out_321091.awb") / 1000

					if var_224_8 + var_224_0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_8 + var_224_0
					end

					if var_224_3.prefab_name ~= "" and arg_221_1.actors_[var_224_3.prefab_name] ~= nil then
						local var_224_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_3.prefab_name].transform, "story_v_out_321091", "321091054", "story_v_out_321091.awb")

						arg_221_1:RecordAudio("321091054", var_224_9)
						arg_221_1:RecordAudio("321091054", var_224_9)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_321091", "321091054", "story_v_out_321091.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_321091", "321091054", "story_v_out_321091.awb")
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
	Play321091055 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 321091055
		arg_225_1.duration_ = 11.53

		local var_225_0 = {
			zh = 7.866,
			ja = 11.533
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
				arg_225_0:Play321091056(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = 0
			local var_228_1 = 0.75

			if var_228_0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_0 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				local var_228_2 = arg_225_1:FormatText(StoryNameCfg[600].name)

				arg_225_1.leftNameTxt_.text = var_228_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, true)
				arg_225_1.iconController_:SetSelectedState("hero")

				arg_225_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10062")

				arg_225_1.callingController_:SetSelectedState("normal")

				arg_225_1.keyicon_.color = Color.New(1, 1, 1)
				arg_225_1.icon_.color = Color.New(1, 1, 1)

				local var_228_3 = arg_225_1:GetWordFromCfg(321091055)
				local var_228_4 = arg_225_1:FormatText(var_228_3.content)

				arg_225_1.text_.text = var_228_4

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_5 = 30
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

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091055", "story_v_out_321091.awb") ~= 0 then
					local var_228_8 = manager.audio:GetVoiceLength("story_v_out_321091", "321091055", "story_v_out_321091.awb") / 1000

					if var_228_8 + var_228_0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_8 + var_228_0
					end

					if var_228_3.prefab_name ~= "" and arg_225_1.actors_[var_228_3.prefab_name] ~= nil then
						local var_228_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_3.prefab_name].transform, "story_v_out_321091", "321091055", "story_v_out_321091.awb")

						arg_225_1:RecordAudio("321091055", var_228_9)
						arg_225_1:RecordAudio("321091055", var_228_9)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_321091", "321091055", "story_v_out_321091.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_321091", "321091055", "story_v_out_321091.awb")
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
	Play321091056 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 321091056
		arg_229_1.duration_ = 12.1

		local var_229_0 = {
			zh = 5.033,
			ja = 12.1
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
				arg_229_0:Play321091057(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = 0
			local var_232_1 = 0.375

			if var_232_0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_0 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				local var_232_2 = arg_229_1:FormatText(StoryNameCfg[600].name)

				arg_229_1.leftNameTxt_.text = var_232_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, true)
				arg_229_1.iconController_:SetSelectedState("hero")

				arg_229_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10062")

				arg_229_1.callingController_:SetSelectedState("normal")

				arg_229_1.keyicon_.color = Color.New(1, 1, 1)
				arg_229_1.icon_.color = Color.New(1, 1, 1)

				local var_232_3 = arg_229_1:GetWordFromCfg(321091056)
				local var_232_4 = arg_229_1:FormatText(var_232_3.content)

				arg_229_1.text_.text = var_232_4

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_5 = 15
				local var_232_6 = utf8.len(var_232_4)
				local var_232_7 = var_232_5 <= 0 and var_232_1 or var_232_1 * (var_232_6 / var_232_5)

				if var_232_7 > 0 and var_232_1 < var_232_7 then
					arg_229_1.talkMaxDuration = var_232_7

					if var_232_7 + var_232_0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_7 + var_232_0
					end
				end

				arg_229_1.text_.text = var_232_4
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091056", "story_v_out_321091.awb") ~= 0 then
					local var_232_8 = manager.audio:GetVoiceLength("story_v_out_321091", "321091056", "story_v_out_321091.awb") / 1000

					if var_232_8 + var_232_0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_8 + var_232_0
					end

					if var_232_3.prefab_name ~= "" and arg_229_1.actors_[var_232_3.prefab_name] ~= nil then
						local var_232_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_3.prefab_name].transform, "story_v_out_321091", "321091056", "story_v_out_321091.awb")

						arg_229_1:RecordAudio("321091056", var_232_9)
						arg_229_1:RecordAudio("321091056", var_232_9)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_321091", "321091056", "story_v_out_321091.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_321091", "321091056", "story_v_out_321091.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_10 = math.max(var_232_1, arg_229_1.talkMaxDuration)

			if var_232_0 <= arg_229_1.time_ and arg_229_1.time_ < var_232_0 + var_232_10 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_0) / var_232_10

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_0 + var_232_10 and arg_229_1.time_ < var_232_0 + var_232_10 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play321091057 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 321091057
		arg_233_1.duration_ = 5

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play321091058(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = 0.7
			local var_236_1 = 1

			if var_236_0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_0 + arg_236_0 then
				local var_236_2 = "play"
				local var_236_3 = "effect"

				arg_233_1:AudioAction(var_236_2, var_236_3, "se_story_11", "se_story_11_microphone", "")
			end

			local var_236_4 = 0
			local var_236_5 = 1.1

			if var_236_4 < arg_233_1.time_ and arg_233_1.time_ <= var_236_4 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, false)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_6 = arg_233_1:GetWordFromCfg(321091057)
				local var_236_7 = arg_233_1:FormatText(var_236_6.content)

				arg_233_1.text_.text = var_236_7

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_8 = 44
				local var_236_9 = utf8.len(var_236_7)
				local var_236_10 = var_236_8 <= 0 and var_236_5 or var_236_5 * (var_236_9 / var_236_8)

				if var_236_10 > 0 and var_236_5 < var_236_10 then
					arg_233_1.talkMaxDuration = var_236_10

					if var_236_10 + var_236_4 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_10 + var_236_4
					end
				end

				arg_233_1.text_.text = var_236_7
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)
				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_11 = math.max(var_236_5, arg_233_1.talkMaxDuration)

			if var_236_4 <= arg_233_1.time_ and arg_233_1.time_ < var_236_4 + var_236_11 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_4) / var_236_11

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_4 + var_236_11 and arg_233_1.time_ < var_236_4 + var_236_11 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play321091058 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 321091058
		arg_237_1.duration_ = 3.4

		local var_237_0 = {
			zh = 2.2,
			ja = 3.4
		}
		local var_237_1 = manager.audio:GetLocalizationFlag()

		if var_237_0[var_237_1] ~= nil then
			arg_237_1.duration_ = var_237_0[var_237_1]
		end

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play321091059(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = "1011ui_story"

			if arg_237_1.actors_[var_240_0] == nil then
				local var_240_1 = Asset.Load("Char/" .. "1011ui_story")

				if not isNil(var_240_1) then
					local var_240_2 = Object.Instantiate(Asset.Load("Char/" .. "1011ui_story"), arg_237_1.stage_.transform)

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

			local var_240_5 = arg_237_1.actors_["1011ui_story"]
			local var_240_6 = 0

			if var_240_6 < arg_237_1.time_ and arg_237_1.time_ <= var_240_6 + arg_240_0 and not isNil(var_240_5) and arg_237_1.var_.characterEffect1011ui_story == nil then
				arg_237_1.var_.characterEffect1011ui_story = var_240_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_7 = 0.200000002980232

			if var_240_6 <= arg_237_1.time_ and arg_237_1.time_ < var_240_6 + var_240_7 and not isNil(var_240_5) then
				local var_240_8 = (arg_237_1.time_ - var_240_6) / var_240_7

				if arg_237_1.var_.characterEffect1011ui_story and not isNil(var_240_5) then
					arg_237_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_237_1.time_ >= var_240_6 + var_240_7 and arg_237_1.time_ < var_240_6 + var_240_7 + arg_240_0 and not isNil(var_240_5) and arg_237_1.var_.characterEffect1011ui_story then
				arg_237_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_240_9 = 0

			if var_240_9 < arg_237_1.time_ and arg_237_1.time_ <= var_240_9 + arg_240_0 then
				arg_237_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action6_1")
			end

			local var_240_10 = 0

			if var_240_10 < arg_237_1.time_ and arg_237_1.time_ <= var_240_10 + arg_240_0 then
				arg_237_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_240_11 = arg_237_1.actors_["1011ui_story"].transform
			local var_240_12 = 0

			if var_240_12 < arg_237_1.time_ and arg_237_1.time_ <= var_240_12 + arg_240_0 then
				arg_237_1.var_.moveOldPos1011ui_story = var_240_11.localPosition
			end

			local var_240_13 = 0.001

			if var_240_12 <= arg_237_1.time_ and arg_237_1.time_ < var_240_12 + var_240_13 then
				local var_240_14 = (arg_237_1.time_ - var_240_12) / var_240_13
				local var_240_15 = Vector3.New(0, -0.71, -6)

				var_240_11.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPos1011ui_story, var_240_15, var_240_14)

				local var_240_16 = manager.ui.mainCamera.transform.position - var_240_11.position

				var_240_11.forward = Vector3.New(var_240_16.x, var_240_16.y, var_240_16.z)

				local var_240_17 = var_240_11.localEulerAngles

				var_240_17.z = 0
				var_240_17.x = 0
				var_240_11.localEulerAngles = var_240_17
			end

			if arg_237_1.time_ >= var_240_12 + var_240_13 and arg_237_1.time_ < var_240_12 + var_240_13 + arg_240_0 then
				var_240_11.localPosition = Vector3.New(0, -0.71, -6)

				local var_240_18 = manager.ui.mainCamera.transform.position - var_240_11.position

				var_240_11.forward = Vector3.New(var_240_18.x, var_240_18.y, var_240_18.z)

				local var_240_19 = var_240_11.localEulerAngles

				var_240_19.z = 0
				var_240_19.x = 0
				var_240_11.localEulerAngles = var_240_19
			end

			local var_240_20 = 0
			local var_240_21 = 0.275

			if var_240_20 < arg_237_1.time_ and arg_237_1.time_ <= var_240_20 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				local var_240_22 = arg_237_1:FormatText(StoryNameCfg[37].name)

				arg_237_1.leftNameTxt_.text = var_240_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_23 = arg_237_1:GetWordFromCfg(321091058)
				local var_240_24 = arg_237_1:FormatText(var_240_23.content)

				arg_237_1.text_.text = var_240_24

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_25 = 11
				local var_240_26 = utf8.len(var_240_24)
				local var_240_27 = var_240_25 <= 0 and var_240_21 or var_240_21 * (var_240_26 / var_240_25)

				if var_240_27 > 0 and var_240_21 < var_240_27 then
					arg_237_1.talkMaxDuration = var_240_27

					if var_240_27 + var_240_20 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_27 + var_240_20
					end
				end

				arg_237_1.text_.text = var_240_24
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091058", "story_v_out_321091.awb") ~= 0 then
					local var_240_28 = manager.audio:GetVoiceLength("story_v_out_321091", "321091058", "story_v_out_321091.awb") / 1000

					if var_240_28 + var_240_20 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_28 + var_240_20
					end

					if var_240_23.prefab_name ~= "" and arg_237_1.actors_[var_240_23.prefab_name] ~= nil then
						local var_240_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_23.prefab_name].transform, "story_v_out_321091", "321091058", "story_v_out_321091.awb")

						arg_237_1:RecordAudio("321091058", var_240_29)
						arg_237_1:RecordAudio("321091058", var_240_29)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_out_321091", "321091058", "story_v_out_321091.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_out_321091", "321091058", "story_v_out_321091.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_30 = math.max(var_240_21, arg_237_1.talkMaxDuration)

			if var_240_20 <= arg_237_1.time_ and arg_237_1.time_ < var_240_20 + var_240_30 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_20) / var_240_30

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_20 + var_240_30 and arg_237_1.time_ < var_240_20 + var_240_30 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {
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

		arg_237_1:InitPlayNodeList()
	end,
	Play321091059 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 321091059
		arg_241_1.duration_ = 9.67

		local var_241_0 = {
			zh = 6.533,
			ja = 9.666
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
				arg_241_0:Play321091060(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = "1056ui_story"

			if arg_241_1.actors_[var_244_0] == nil then
				local var_244_1 = Asset.Load("Char/" .. "1056ui_story")

				if not isNil(var_244_1) then
					local var_244_2 = Object.Instantiate(Asset.Load("Char/" .. "1056ui_story"), arg_241_1.stage_.transform)

					var_244_2.name = var_244_0
					var_244_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_241_1.actors_[var_244_0] = var_244_2

					local var_244_3 = var_244_2:GetComponentInChildren(typeof(CharacterEffect))

					var_244_3.enabled = true

					local var_244_4 = GameObjectTools.GetOrAddComponent(var_244_2, typeof(DynamicBoneHelper))

					if var_244_4 then
						var_244_4:EnableDynamicBone(false)
					end

					arg_241_1:ShowWeapon(var_244_3.transform, false)

					arg_241_1.var_[var_244_0 .. "Animator"] = var_244_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_241_1.var_[var_244_0 .. "Animator"].applyRootMotion = true
					arg_241_1.var_[var_244_0 .. "LipSync"] = var_244_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_244_5 = arg_241_1.actors_["1056ui_story"]
			local var_244_6 = 0

			if var_244_6 < arg_241_1.time_ and arg_241_1.time_ <= var_244_6 + arg_244_0 and not isNil(var_244_5) and arg_241_1.var_.characterEffect1056ui_story == nil then
				arg_241_1.var_.characterEffect1056ui_story = var_244_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_7 = 0.200000002980232

			if var_244_6 <= arg_241_1.time_ and arg_241_1.time_ < var_244_6 + var_244_7 and not isNil(var_244_5) then
				local var_244_8 = (arg_241_1.time_ - var_244_6) / var_244_7

				if arg_241_1.var_.characterEffect1056ui_story and not isNil(var_244_5) then
					arg_241_1.var_.characterEffect1056ui_story.fillFlat = false
				end
			end

			if arg_241_1.time_ >= var_244_6 + var_244_7 and arg_241_1.time_ < var_244_6 + var_244_7 + arg_244_0 and not isNil(var_244_5) and arg_241_1.var_.characterEffect1056ui_story then
				arg_241_1.var_.characterEffect1056ui_story.fillFlat = false
			end

			local var_244_9 = arg_241_1.actors_["1011ui_story"]
			local var_244_10 = 0

			if var_244_10 < arg_241_1.time_ and arg_241_1.time_ <= var_244_10 + arg_244_0 and not isNil(var_244_9) and arg_241_1.var_.characterEffect1011ui_story == nil then
				arg_241_1.var_.characterEffect1011ui_story = var_244_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_11 = 0.200000002980232

			if var_244_10 <= arg_241_1.time_ and arg_241_1.time_ < var_244_10 + var_244_11 and not isNil(var_244_9) then
				local var_244_12 = (arg_241_1.time_ - var_244_10) / var_244_11

				if arg_241_1.var_.characterEffect1011ui_story and not isNil(var_244_9) then
					local var_244_13 = Mathf.Lerp(0, 0.5, var_244_12)

					arg_241_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_241_1.var_.characterEffect1011ui_story.fillRatio = var_244_13
				end
			end

			if arg_241_1.time_ >= var_244_10 + var_244_11 and arg_241_1.time_ < var_244_10 + var_244_11 + arg_244_0 and not isNil(var_244_9) and arg_241_1.var_.characterEffect1011ui_story then
				local var_244_14 = 0.5

				arg_241_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_241_1.var_.characterEffect1011ui_story.fillRatio = var_244_14
			end

			local var_244_15 = 0
			local var_244_16 = 0.975

			if var_244_15 < arg_241_1.time_ and arg_241_1.time_ <= var_244_15 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				local var_244_17 = arg_241_1:FormatText(StoryNameCfg[605].name)

				arg_241_1.leftNameTxt_.text = var_244_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, true)
				arg_241_1.iconController_:SetSelectedState("hero")

				arg_241_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1056")

				arg_241_1.callingController_:SetSelectedState("calling")

				arg_241_1.keyicon_.color = Color.New(1, 1, 1)
				arg_241_1.icon_.color = Color.New(1, 1, 1)

				local var_244_18 = arg_241_1:GetWordFromCfg(321091059)
				local var_244_19 = arg_241_1:FormatText(var_244_18.content)

				arg_241_1.text_.text = var_244_19

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_20 = 39
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

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091059", "story_v_out_321091.awb") ~= 0 then
					local var_244_23 = manager.audio:GetVoiceLength("story_v_out_321091", "321091059", "story_v_out_321091.awb") / 1000

					if var_244_23 + var_244_15 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_23 + var_244_15
					end

					if var_244_18.prefab_name ~= "" and arg_241_1.actors_[var_244_18.prefab_name] ~= nil then
						local var_244_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_18.prefab_name].transform, "story_v_out_321091", "321091059", "story_v_out_321091.awb")

						arg_241_1:RecordAudio("321091059", var_244_24)
						arg_241_1:RecordAudio("321091059", var_244_24)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_321091", "321091059", "story_v_out_321091.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_321091", "321091059", "story_v_out_321091.awb")
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

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play321091060 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 321091060
		arg_245_1.duration_ = 4.53

		local var_245_0 = {
			zh = 4.166,
			ja = 4.533
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
				arg_245_0:Play321091061(arg_245_1)
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

				local var_248_2 = arg_245_1:FormatText(StoryNameCfg[605].name)

				arg_245_1.leftNameTxt_.text = var_248_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, true)
				arg_245_1.iconController_:SetSelectedState("hero")

				arg_245_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1056")

				arg_245_1.callingController_:SetSelectedState("calling")

				arg_245_1.keyicon_.color = Color.New(1, 1, 1)
				arg_245_1.icon_.color = Color.New(1, 1, 1)

				local var_248_3 = arg_245_1:GetWordFromCfg(321091060)
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

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091060", "story_v_out_321091.awb") ~= 0 then
					local var_248_8 = manager.audio:GetVoiceLength("story_v_out_321091", "321091060", "story_v_out_321091.awb") / 1000

					if var_248_8 + var_248_0 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_8 + var_248_0
					end

					if var_248_3.prefab_name ~= "" and arg_245_1.actors_[var_248_3.prefab_name] ~= nil then
						local var_248_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_3.prefab_name].transform, "story_v_out_321091", "321091060", "story_v_out_321091.awb")

						arg_245_1:RecordAudio("321091060", var_248_9)
						arg_245_1:RecordAudio("321091060", var_248_9)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_321091", "321091060", "story_v_out_321091.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_321091", "321091060", "story_v_out_321091.awb")
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
	Play321091061 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 321091061
		arg_249_1.duration_ = 2.77

		local var_249_0 = {
			zh = 2.4,
			ja = 2.766
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
				arg_249_0:Play321091062(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = arg_249_1.actors_["1011ui_story"]
			local var_252_1 = 0

			if var_252_1 < arg_249_1.time_ and arg_249_1.time_ <= var_252_1 + arg_252_0 and not isNil(var_252_0) and arg_249_1.var_.characterEffect1011ui_story == nil then
				arg_249_1.var_.characterEffect1011ui_story = var_252_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_2 = 0.200000002980232

			if var_252_1 <= arg_249_1.time_ and arg_249_1.time_ < var_252_1 + var_252_2 and not isNil(var_252_0) then
				local var_252_3 = (arg_249_1.time_ - var_252_1) / var_252_2

				if arg_249_1.var_.characterEffect1011ui_story and not isNil(var_252_0) then
					arg_249_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_249_1.time_ >= var_252_1 + var_252_2 and arg_249_1.time_ < var_252_1 + var_252_2 + arg_252_0 and not isNil(var_252_0) and arg_249_1.var_.characterEffect1011ui_story then
				arg_249_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_252_4 = arg_249_1.actors_["1056ui_story"]
			local var_252_5 = 0

			if var_252_5 < arg_249_1.time_ and arg_249_1.time_ <= var_252_5 + arg_252_0 and not isNil(var_252_4) and arg_249_1.var_.characterEffect1056ui_story == nil then
				arg_249_1.var_.characterEffect1056ui_story = var_252_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_6 = 0.200000002980232

			if var_252_5 <= arg_249_1.time_ and arg_249_1.time_ < var_252_5 + var_252_6 and not isNil(var_252_4) then
				local var_252_7 = (arg_249_1.time_ - var_252_5) / var_252_6

				if arg_249_1.var_.characterEffect1056ui_story and not isNil(var_252_4) then
					local var_252_8 = Mathf.Lerp(0, 0.5, var_252_7)

					arg_249_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_249_1.var_.characterEffect1056ui_story.fillRatio = var_252_8
				end
			end

			if arg_249_1.time_ >= var_252_5 + var_252_6 and arg_249_1.time_ < var_252_5 + var_252_6 + arg_252_0 and not isNil(var_252_4) and arg_249_1.var_.characterEffect1056ui_story then
				local var_252_9 = 0.5

				arg_249_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_249_1.var_.characterEffect1056ui_story.fillRatio = var_252_9
			end

			local var_252_10 = 0

			if var_252_10 < arg_249_1.time_ and arg_249_1.time_ <= var_252_10 + arg_252_0 then
				arg_249_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action6_2")
			end

			local var_252_11 = 0

			if var_252_11 < arg_249_1.time_ and arg_249_1.time_ <= var_252_11 + arg_252_0 then
				arg_249_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_252_12 = 0.1
			local var_252_13 = 1

			if var_252_12 < arg_249_1.time_ and arg_249_1.time_ <= var_252_12 + arg_252_0 then
				local var_252_14 = "play"
				local var_252_15 = "effect"

				arg_249_1:AudioAction(var_252_14, var_252_15, "se_story_140", "se_story_140_sand", "")
			end

			local var_252_16 = 0
			local var_252_17 = 0.25

			if var_252_16 < arg_249_1.time_ and arg_249_1.time_ <= var_252_16 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				local var_252_18 = arg_249_1:FormatText(StoryNameCfg[37].name)

				arg_249_1.leftNameTxt_.text = var_252_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_19 = arg_249_1:GetWordFromCfg(321091061)
				local var_252_20 = arg_249_1:FormatText(var_252_19.content)

				arg_249_1.text_.text = var_252_20

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_21 = 10
				local var_252_22 = utf8.len(var_252_20)
				local var_252_23 = var_252_21 <= 0 and var_252_17 or var_252_17 * (var_252_22 / var_252_21)

				if var_252_23 > 0 and var_252_17 < var_252_23 then
					arg_249_1.talkMaxDuration = var_252_23

					if var_252_23 + var_252_16 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_23 + var_252_16
					end
				end

				arg_249_1.text_.text = var_252_20
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091061", "story_v_out_321091.awb") ~= 0 then
					local var_252_24 = manager.audio:GetVoiceLength("story_v_out_321091", "321091061", "story_v_out_321091.awb") / 1000

					if var_252_24 + var_252_16 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_24 + var_252_16
					end

					if var_252_19.prefab_name ~= "" and arg_249_1.actors_[var_252_19.prefab_name] ~= nil then
						local var_252_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_19.prefab_name].transform, "story_v_out_321091", "321091061", "story_v_out_321091.awb")

						arg_249_1:RecordAudio("321091061", var_252_25)
						arg_249_1:RecordAudio("321091061", var_252_25)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_321091", "321091061", "story_v_out_321091.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_321091", "321091061", "story_v_out_321091.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_26 = math.max(var_252_17, arg_249_1.talkMaxDuration)

			if var_252_16 <= arg_249_1.time_ and arg_249_1.time_ < var_252_16 + var_252_26 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_16) / var_252_26

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_16 + var_252_26 and arg_249_1.time_ < var_252_16 + var_252_26 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play321091062 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 321091062
		arg_253_1.duration_ = 5

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play321091063(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = arg_253_1.actors_["1011ui_story"]
			local var_256_1 = 0

			if var_256_1 < arg_253_1.time_ and arg_253_1.time_ <= var_256_1 + arg_256_0 and not isNil(var_256_0) and arg_253_1.var_.characterEffect1011ui_story == nil then
				arg_253_1.var_.characterEffect1011ui_story = var_256_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_2 = 0.200000002980232

			if var_256_1 <= arg_253_1.time_ and arg_253_1.time_ < var_256_1 + var_256_2 and not isNil(var_256_0) then
				local var_256_3 = (arg_253_1.time_ - var_256_1) / var_256_2

				if arg_253_1.var_.characterEffect1011ui_story and not isNil(var_256_0) then
					local var_256_4 = Mathf.Lerp(0, 0.5, var_256_3)

					arg_253_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_253_1.var_.characterEffect1011ui_story.fillRatio = var_256_4
				end
			end

			if arg_253_1.time_ >= var_256_1 + var_256_2 and arg_253_1.time_ < var_256_1 + var_256_2 + arg_256_0 and not isNil(var_256_0) and arg_253_1.var_.characterEffect1011ui_story then
				local var_256_5 = 0.5

				arg_253_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_253_1.var_.characterEffect1011ui_story.fillRatio = var_256_5
			end

			local var_256_6 = arg_253_1.actors_["1011ui_story"].transform
			local var_256_7 = 0

			if var_256_7 < arg_253_1.time_ and arg_253_1.time_ <= var_256_7 + arg_256_0 then
				arg_253_1.var_.moveOldPos1011ui_story = var_256_6.localPosition
			end

			local var_256_8 = 0.001

			if var_256_7 <= arg_253_1.time_ and arg_253_1.time_ < var_256_7 + var_256_8 then
				local var_256_9 = (arg_253_1.time_ - var_256_7) / var_256_8
				local var_256_10 = Vector3.New(0, 100, 0)

				var_256_6.localPosition = Vector3.Lerp(arg_253_1.var_.moveOldPos1011ui_story, var_256_10, var_256_9)

				local var_256_11 = manager.ui.mainCamera.transform.position - var_256_6.position

				var_256_6.forward = Vector3.New(var_256_11.x, var_256_11.y, var_256_11.z)

				local var_256_12 = var_256_6.localEulerAngles

				var_256_12.z = 0
				var_256_12.x = 0
				var_256_6.localEulerAngles = var_256_12
			end

			if arg_253_1.time_ >= var_256_7 + var_256_8 and arg_253_1.time_ < var_256_7 + var_256_8 + arg_256_0 then
				var_256_6.localPosition = Vector3.New(0, 100, 0)

				local var_256_13 = manager.ui.mainCamera.transform.position - var_256_6.position

				var_256_6.forward = Vector3.New(var_256_13.x, var_256_13.y, var_256_13.z)

				local var_256_14 = var_256_6.localEulerAngles

				var_256_14.z = 0
				var_256_14.x = 0
				var_256_6.localEulerAngles = var_256_14
			end

			local var_256_15 = 0.05
			local var_256_16 = 1

			if var_256_15 < arg_253_1.time_ and arg_253_1.time_ <= var_256_15 + arg_256_0 then
				local var_256_17 = "play"
				local var_256_18 = "effect"

				arg_253_1:AudioAction(var_256_17, var_256_18, "se_story_1311", "se_story_1311_ui", "")
			end

			local var_256_19 = 0
			local var_256_20 = 0.8

			if var_256_19 < arg_253_1.time_ and arg_253_1.time_ <= var_256_19 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, false)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_21 = arg_253_1:GetWordFromCfg(321091062)
				local var_256_22 = arg_253_1:FormatText(var_256_21.content)

				arg_253_1.text_.text = var_256_22

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_23 = 32
				local var_256_24 = utf8.len(var_256_22)
				local var_256_25 = var_256_23 <= 0 and var_256_20 or var_256_20 * (var_256_24 / var_256_23)

				if var_256_25 > 0 and var_256_20 < var_256_25 then
					arg_253_1.talkMaxDuration = var_256_25

					if var_256_25 + var_256_19 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_25 + var_256_19
					end
				end

				arg_253_1.text_.text = var_256_22
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)
				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_26 = math.max(var_256_20, arg_253_1.talkMaxDuration)

			if var_256_19 <= arg_253_1.time_ and arg_253_1.time_ < var_256_19 + var_256_26 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_19) / var_256_26

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_19 + var_256_26 and arg_253_1.time_ < var_256_19 + var_256_26 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {
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

		arg_253_1:InitPlayNodeList()
	end,
	Play321091063 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 321091063
		arg_257_1.duration_ = 5

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play321091064(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = 0
			local var_260_1 = 1.5

			if var_260_0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_0 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, false)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_2 = arg_257_1:GetWordFromCfg(321091063)
				local var_260_3 = arg_257_1:FormatText(var_260_2.content)

				arg_257_1.text_.text = var_260_3

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_4 = 60
				local var_260_5 = utf8.len(var_260_3)
				local var_260_6 = var_260_4 <= 0 and var_260_1 or var_260_1 * (var_260_5 / var_260_4)

				if var_260_6 > 0 and var_260_1 < var_260_6 then
					arg_257_1.talkMaxDuration = var_260_6

					if var_260_6 + var_260_0 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_6 + var_260_0
					end
				end

				arg_257_1.text_.text = var_260_3
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)
				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_7 = math.max(var_260_1, arg_257_1.talkMaxDuration)

			if var_260_0 <= arg_257_1.time_ and arg_257_1.time_ < var_260_0 + var_260_7 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_0) / var_260_7

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_0 + var_260_7 and arg_257_1.time_ < var_260_0 + var_260_7 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play321091064 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 321091064
		arg_261_1.duration_ = 6.8

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play321091065(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = manager.ui.mainCamera.transform
			local var_264_1 = 0.157419800758362

			if var_264_1 < arg_261_1.time_ and arg_261_1.time_ <= var_264_1 + arg_264_0 then
				arg_261_1.var_.shakeOldPos = var_264_0.localPosition
			end

			local var_264_2 = 0.642580199241638

			if var_264_1 <= arg_261_1.time_ and arg_261_1.time_ < var_264_1 + var_264_2 then
				local var_264_3 = (arg_261_1.time_ - var_264_1) / 0.066
				local var_264_4, var_264_5 = math.modf(var_264_3)

				var_264_0.localPosition = Vector3.New(var_264_5 * 0.13, var_264_5 * 0.13, var_264_5 * 0.13) + arg_261_1.var_.shakeOldPos
			end

			if arg_261_1.time_ >= var_264_1 + var_264_2 and arg_261_1.time_ < var_264_1 + var_264_2 + arg_264_0 then
				var_264_0.localPosition = arg_261_1.var_.shakeOldPos
			end

			local var_264_6 = manager.ui.mainCamera.transform
			local var_264_7 = 0

			if var_264_7 < arg_261_1.time_ and arg_261_1.time_ <= var_264_7 + arg_264_0 then
				local var_264_8 = arg_261_1.var_.effect811
				local var_264_9
				local var_264_10 = var_264_6

				if not var_264_8 then
					var_264_8 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_redlight_keep"), var_264_10)
					var_264_8.name = "811"
					arg_261_1.var_.effect811 = var_264_8
				else
					var_264_8.transform:SetParent(var_264_10)
				end

				var_264_8.transform.localPosition = Vector3.New(0, 0, -2)
				var_264_8.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_264_11 = 1.7777777777777777
				local var_264_12 = Screen.width / Screen.height
				local var_264_13 = var_264_12 / var_264_11
				local var_264_14 = Mathf.Max(var_264_11 / var_264_12, 1)

				var_264_8.transform.localScale = Vector3.New(var_264_8.transform.localScale.x * var_264_13, var_264_8.transform.localScale.y * var_264_14, var_264_8.transform.localScale.z)
			end

			local var_264_15 = 0

			if var_264_15 < arg_261_1.time_ and arg_261_1.time_ <= var_264_15 + arg_264_0 then
				arg_261_1.allBtn_.enabled = false
			end

			local var_264_16 = 2.13333333333333

			if arg_261_1.time_ >= var_264_15 + var_264_16 and arg_261_1.time_ < var_264_15 + var_264_16 + arg_264_0 then
				arg_261_1.allBtn_.enabled = true
			end

			local var_264_17 = 0

			if var_264_17 < arg_261_1.time_ and arg_261_1.time_ <= var_264_17 + arg_264_0 then
				arg_261_1.mask_.enabled = true
				arg_261_1.mask_.raycastTarget = true

				arg_261_1:SetGaussion(false)
			end

			local var_264_18 = 0.433333333333333

			if var_264_17 <= arg_261_1.time_ and arg_261_1.time_ < var_264_17 + var_264_18 then
				local var_264_19 = (arg_261_1.time_ - var_264_17) / var_264_18
				local var_264_20 = Color.New(1, 1, 1)

				var_264_20.a = Mathf.Lerp(1, 0, var_264_19)
				arg_261_1.mask_.color = var_264_20
			end

			if arg_261_1.time_ >= var_264_17 + var_264_18 and arg_261_1.time_ < var_264_17 + var_264_18 + arg_264_0 then
				local var_264_21 = Color.New(1, 1, 1)
				local var_264_22 = 0

				arg_261_1.mask_.enabled = false
				var_264_21.a = var_264_22
				arg_261_1.mask_.color = var_264_21
			end

			local var_264_23 = 1
			local var_264_24 = 1

			if var_264_23 < arg_261_1.time_ and arg_261_1.time_ <= var_264_23 + arg_264_0 then
				local var_264_25 = "play"
				local var_264_26 = "effect"

				arg_261_1:AudioAction(var_264_25, var_264_26, "ui_skip", "ui_reset", "")
			end

			local var_264_27 = 0
			local var_264_28 = 1

			if var_264_27 < arg_261_1.time_ and arg_261_1.time_ <= var_264_27 + arg_264_0 then
				local var_264_29 = "stop"
				local var_264_30 = "effect"

				arg_261_1:AudioAction(var_264_29, var_264_30, "se_story_140", "se_story_140_amb_lfe", "")
			end

			local var_264_31 = 0
			local var_264_32 = 0.2

			if var_264_31 < arg_261_1.time_ and arg_261_1.time_ <= var_264_31 + arg_264_0 then
				local var_264_33 = "play"
				local var_264_34 = "music"

				arg_261_1:AudioAction(var_264_33, var_264_34, "ui_battle", "ui_battle_stopbgm", "")

				local var_264_35 = ""
				local var_264_36 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_264_36 ~= "" then
					if arg_261_1.bgmTxt_.text ~= var_264_36 and arg_261_1.bgmTxt_.text ~= "" then
						if arg_261_1.bgmTxt2_.text ~= "" then
							arg_261_1.bgmTxt_.text = arg_261_1.bgmTxt2_.text
						end

						arg_261_1.bgmTxt2_.text = var_264_36

						arg_261_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_261_1.bgmTxt_.text = var_264_36
						arg_261_1.bgmTxt2_.text = var_264_36
					end

					if arg_261_1.bgmTimer then
						arg_261_1.bgmTimer:Stop()

						arg_261_1.bgmTimer = nil
					end

					if arg_261_1.settingData.show_music_name == 1 then
						arg_261_1.musicController:SetSelectedState("show")
						arg_261_1.musicAnimator_:Play("open", 0, 0)

						if arg_261_1.settingData.music_time ~= 0 then
							arg_261_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_261_1.settingData.music_time), function()
								if arg_261_1 == nil or isNil(arg_261_1.bgmTxt_) then
									return
								end

								arg_261_1.musicController:SetSelectedState("hide")
								arg_261_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_264_37 = 0.1
			local var_264_38 = 1

			if var_264_37 < arg_261_1.time_ and arg_261_1.time_ <= var_264_37 + arg_264_0 then
				local var_264_39 = "play"
				local var_264_40 = "effect"

				arg_261_1:AudioAction(var_264_39, var_264_40, "se_story_122_01", "se_story_122_01_dizzy_loop", "")
			end

			if arg_261_1.frameCnt_ <= 1 then
				arg_261_1.dialog_:SetActive(false)
			end

			local var_264_41 = 1.8
			local var_264_42 = 1.225

			if var_264_41 < arg_261_1.time_ and arg_261_1.time_ <= var_264_41 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0

				arg_261_1.dialog_:SetActive(true)

				arg_261_1.dialogCg_.alpha = 0

				local var_264_43 = LeanTween.value(arg_261_1.dialog_, 0, 1, 0.3)

				var_264_43:setOnUpdate(LuaHelper.FloatAction(function(arg_266_0)
					arg_261_1.dialogCg_.alpha = arg_266_0
				end))
				var_264_43:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_261_1.dialog_)
					var_264_43:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_261_1.duration_ = arg_261_1.duration_ + 0.3

				SetActive(arg_261_1.leftNameGo_, false)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_44 = arg_261_1:GetWordFromCfg(321091064)
				local var_264_45 = arg_261_1:FormatText(var_264_44.content)

				arg_261_1.text_.text = var_264_45

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_46 = 49
				local var_264_47 = utf8.len(var_264_45)
				local var_264_48 = var_264_46 <= 0 and var_264_42 or var_264_42 * (var_264_47 / var_264_46)

				if var_264_48 > 0 and var_264_42 < var_264_48 then
					arg_261_1.talkMaxDuration = var_264_48
					var_264_41 = var_264_41 + 0.3

					if var_264_48 + var_264_41 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_48 + var_264_41
					end
				end

				arg_261_1.text_.text = var_264_45
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)
				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_49 = var_264_41 + 0.3
			local var_264_50 = math.max(var_264_42, arg_261_1.talkMaxDuration)

			if var_264_49 <= arg_261_1.time_ and arg_261_1.time_ < var_264_49 + var_264_50 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_49) / var_264_50

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_49 + var_264_50 and arg_261_1.time_ < var_264_49 + var_264_50 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play321091065 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 321091065
		arg_268_1.duration_ = 6.06

		SetActive(arg_268_1.tipsGo_, false)

		function arg_268_1.onSingleLineFinish_()
			arg_268_1.onSingleLineUpdate_ = nil
			arg_268_1.onSingleLineFinish_ = nil
			arg_268_1.state_ = "waiting"
		end

		function arg_268_1.playNext_(arg_270_0)
			if arg_270_0 == 1 then
				arg_268_0:Play321091066(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			local var_271_0
			local var_271_1 = 0

			if var_271_1 < arg_268_1.time_ and arg_268_1.time_ <= var_271_1 + arg_271_0 then
				local var_271_2 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_271_2 then
					var_271_2.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_271_2.radialBlurScale = 0.854
					var_271_2.radialBlurGradient = 1
					var_271_2.radialBlurIntensity = 1

					if var_271_0 then
						var_271_2.radialBlurTarget = var_271_0.transform
					end
				end
			end

			local var_271_3 = 1.33333333333333

			if var_271_1 <= arg_268_1.time_ and arg_268_1.time_ < var_271_1 + var_271_3 then
				local var_271_4 = (arg_268_1.time_ - var_271_1) / var_271_3
				local var_271_5 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_271_5 then
					var_271_5.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_271_5.radialBlurScale = Mathf.Lerp(0.854, 0.97, var_271_4)
					var_271_5.radialBlurGradient = Mathf.Lerp(1, 1, var_271_4)
					var_271_5.radialBlurIntensity = Mathf.Lerp(1, 1, var_271_4)
				end
			end

			if arg_268_1.time_ >= var_271_1 + var_271_3 and arg_268_1.time_ < var_271_1 + var_271_3 + arg_271_0 then
				local var_271_6 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_271_6 then
					var_271_6.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_271_6.radialBlurScale = 0.97
					var_271_6.radialBlurGradient = 1
					var_271_6.radialBlurIntensity = 1
				end
			end

			local var_271_7 = 0

			if var_271_7 < arg_268_1.time_ and arg_268_1.time_ <= var_271_7 + arg_271_0 then
				arg_268_1.allBtn_.enabled = false
			end

			local var_271_8 = 1.56666666666667

			if arg_268_1.time_ >= var_271_7 + var_271_8 and arg_268_1.time_ < var_271_7 + var_271_8 + arg_271_0 then
				arg_268_1.allBtn_.enabled = true
			end

			if arg_268_1.frameCnt_ <= 1 then
				arg_268_1.dialog_:SetActive(false)
			end

			local var_271_9 = 1.05833333333333
			local var_271_10 = 1.075

			if var_271_9 < arg_268_1.time_ and arg_268_1.time_ <= var_271_9 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0

				arg_268_1.dialog_:SetActive(true)

				arg_268_1.dialogCg_.alpha = 0

				local var_271_11 = LeanTween.value(arg_268_1.dialog_, 0, 1, 0.3)

				var_271_11:setOnUpdate(LuaHelper.FloatAction(function(arg_272_0)
					arg_268_1.dialogCg_.alpha = arg_272_0
				end))
				var_271_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_268_1.dialog_)
					var_271_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_268_1.duration_ = arg_268_1.duration_ + 0.3

				SetActive(arg_268_1.leftNameGo_, false)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_268_1.iconTrs_.gameObject, false)
				arg_268_1.callingController_:SetSelectedState("normal")

				local var_271_12 = arg_268_1:GetWordFromCfg(321091065)
				local var_271_13 = arg_268_1:FormatText(var_271_12.content)

				arg_268_1.text_.text = var_271_13

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_14 = 43
				local var_271_15 = utf8.len(var_271_13)
				local var_271_16 = var_271_14 <= 0 and var_271_10 or var_271_10 * (var_271_15 / var_271_14)

				if var_271_16 > 0 and var_271_10 < var_271_16 then
					arg_268_1.talkMaxDuration = var_271_16
					var_271_9 = var_271_9 + 0.3

					if var_271_16 + var_271_9 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_16 + var_271_9
					end
				end

				arg_268_1.text_.text = var_271_13
				arg_268_1.typewritter.percent = 0

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(false)
				arg_268_1:RecordContent(arg_268_1.text_.text)
			end

			local var_271_17 = var_271_9 + 0.3
			local var_271_18 = math.max(var_271_10, arg_268_1.talkMaxDuration)

			if var_271_17 <= arg_268_1.time_ and arg_268_1.time_ < var_271_17 + var_271_18 then
				arg_268_1.typewritter.percent = (arg_268_1.time_ - var_271_17) / var_271_18

				arg_268_1.typewritter:SetDirty()
			end

			if arg_268_1.time_ >= var_271_17 + var_271_18 and arg_268_1.time_ < var_271_17 + var_271_18 + arg_271_0 then
				arg_268_1.typewritter.percent = 1

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(true)
			end
		end

		arg_268_1.nodeConfigList_ = {}

		arg_268_1:InitPlayNodeList()
	end,
	Play321091066 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 321091066
		arg_274_1.duration_ = 2.5

		local var_274_0 = {
			zh = 2.5,
			ja = 1.333
		}
		local var_274_1 = manager.audio:GetLocalizationFlag()

		if var_274_0[var_274_1] ~= nil then
			arg_274_1.duration_ = var_274_0[var_274_1]
		end

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play321091067(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			local var_277_0 = arg_274_1.actors_["1011ui_story"]
			local var_277_1 = 0

			if var_277_1 < arg_274_1.time_ and arg_274_1.time_ <= var_277_1 + arg_277_0 and not isNil(var_277_0) and arg_274_1.var_.characterEffect1011ui_story == nil then
				arg_274_1.var_.characterEffect1011ui_story = var_277_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_277_2 = 0.200000002980232

			if var_277_1 <= arg_274_1.time_ and arg_274_1.time_ < var_277_1 + var_277_2 and not isNil(var_277_0) then
				local var_277_3 = (arg_274_1.time_ - var_277_1) / var_277_2

				if arg_274_1.var_.characterEffect1011ui_story and not isNil(var_277_0) then
					arg_274_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_274_1.time_ >= var_277_1 + var_277_2 and arg_274_1.time_ < var_277_1 + var_277_2 + arg_277_0 and not isNil(var_277_0) and arg_274_1.var_.characterEffect1011ui_story then
				arg_274_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_277_4 = 0
			local var_277_5 = 0.15

			if var_277_4 < arg_274_1.time_ and arg_274_1.time_ <= var_277_4 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, true)

				local var_277_6 = arg_274_1:FormatText(StoryNameCfg[37].name)

				arg_274_1.leftNameTxt_.text = var_277_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_274_1.leftNameTxt_.transform)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1.leftNameTxt_.text)
				SetActive(arg_274_1.iconTrs_.gameObject, false)
				arg_274_1.callingController_:SetSelectedState("normal")

				local var_277_7 = arg_274_1:GetWordFromCfg(321091066)
				local var_277_8 = arg_274_1:FormatText(var_277_7.content)

				arg_274_1.text_.text = var_277_8

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_9 = 6
				local var_277_10 = utf8.len(var_277_8)
				local var_277_11 = var_277_9 <= 0 and var_277_5 or var_277_5 * (var_277_10 / var_277_9)

				if var_277_11 > 0 and var_277_5 < var_277_11 then
					arg_274_1.talkMaxDuration = var_277_11

					if var_277_11 + var_277_4 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_11 + var_277_4
					end
				end

				arg_274_1.text_.text = var_277_8
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091066", "story_v_out_321091.awb") ~= 0 then
					local var_277_12 = manager.audio:GetVoiceLength("story_v_out_321091", "321091066", "story_v_out_321091.awb") / 1000

					if var_277_12 + var_277_4 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_12 + var_277_4
					end

					if var_277_7.prefab_name ~= "" and arg_274_1.actors_[var_277_7.prefab_name] ~= nil then
						local var_277_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_274_1.actors_[var_277_7.prefab_name].transform, "story_v_out_321091", "321091066", "story_v_out_321091.awb")

						arg_274_1:RecordAudio("321091066", var_277_13)
						arg_274_1:RecordAudio("321091066", var_277_13)
					else
						arg_274_1:AudioAction("play", "voice", "story_v_out_321091", "321091066", "story_v_out_321091.awb")
					end

					arg_274_1:RecordHistoryTalkVoice("story_v_out_321091", "321091066", "story_v_out_321091.awb")
				end

				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_14 = math.max(var_277_5, arg_274_1.talkMaxDuration)

			if var_277_4 <= arg_274_1.time_ and arg_274_1.time_ < var_277_4 + var_277_14 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_4) / var_277_14

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_4 + var_277_14 and arg_274_1.time_ < var_277_4 + var_277_14 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {}

		arg_274_1:InitPlayNodeList()
	end,
	Play321091067 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 321091067
		arg_278_1.duration_ = 8.8

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play321091068(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			local var_281_0 = "ST0507a"

			if arg_278_1.bgs_[var_281_0] == nil then
				local var_281_1 = Object.Instantiate(arg_278_1.paintGo_)

				var_281_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_281_0)
				var_281_1.name = var_281_0
				var_281_1.transform.parent = arg_278_1.stage_.transform
				var_281_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_278_1.bgs_[var_281_0] = var_281_1
			end

			local var_281_2 = 2

			if var_281_2 < arg_278_1.time_ and arg_278_1.time_ <= var_281_2 + arg_281_0 then
				local var_281_3 = manager.ui.mainCamera.transform.localPosition
				local var_281_4 = Vector3.New(0, 0, 10) + Vector3.New(var_281_3.x, var_281_3.y, 0)
				local var_281_5 = arg_278_1.bgs_.ST0507a

				var_281_5.transform.localPosition = var_281_4
				var_281_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_281_6 = var_281_5:GetComponent("SpriteRenderer")

				if var_281_6 and var_281_6.sprite then
					local var_281_7 = (var_281_5.transform.localPosition - var_281_3).z
					local var_281_8 = manager.ui.mainCameraCom_
					local var_281_9 = 2 * var_281_7 * Mathf.Tan(var_281_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_281_10 = var_281_9 * var_281_8.aspect
					local var_281_11 = var_281_6.sprite.bounds.size.x
					local var_281_12 = var_281_6.sprite.bounds.size.y
					local var_281_13 = var_281_10 / var_281_11
					local var_281_14 = var_281_9 / var_281_12
					local var_281_15 = var_281_14 < var_281_13 and var_281_13 or var_281_14

					var_281_5.transform.localScale = Vector3.New(var_281_15, var_281_15, 0)
				end

				for iter_281_0, iter_281_1 in pairs(arg_278_1.bgs_) do
					if iter_281_0 ~= "ST0507a" then
						iter_281_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_281_16 = 0

			if var_281_16 < arg_278_1.time_ and arg_278_1.time_ <= var_281_16 + arg_281_0 then
				arg_278_1.allBtn_.enabled = false
			end

			local var_281_17 = 0.3

			if arg_278_1.time_ >= var_281_16 + var_281_17 and arg_278_1.time_ < var_281_16 + var_281_17 + arg_281_0 then
				arg_278_1.allBtn_.enabled = true
			end

			local var_281_18 = 0

			if var_281_18 < arg_278_1.time_ and arg_278_1.time_ <= var_281_18 + arg_281_0 then
				arg_278_1.mask_.enabled = true
				arg_278_1.mask_.raycastTarget = true

				arg_278_1:SetGaussion(false)
			end

			local var_281_19 = 2

			if var_281_18 <= arg_278_1.time_ and arg_278_1.time_ < var_281_18 + var_281_19 then
				local var_281_20 = (arg_278_1.time_ - var_281_18) / var_281_19
				local var_281_21 = Color.New(0, 0, 0)

				var_281_21.a = Mathf.Lerp(0, 1, var_281_20)
				arg_278_1.mask_.color = var_281_21
			end

			if arg_278_1.time_ >= var_281_18 + var_281_19 and arg_278_1.time_ < var_281_18 + var_281_19 + arg_281_0 then
				local var_281_22 = Color.New(0, 0, 0)

				var_281_22.a = 1
				arg_278_1.mask_.color = var_281_22
			end

			local var_281_23 = 2

			if var_281_23 < arg_278_1.time_ and arg_278_1.time_ <= var_281_23 + arg_281_0 then
				arg_278_1.mask_.enabled = true
				arg_278_1.mask_.raycastTarget = true

				arg_278_1:SetGaussion(false)
			end

			local var_281_24 = 2

			if var_281_23 <= arg_278_1.time_ and arg_278_1.time_ < var_281_23 + var_281_24 then
				local var_281_25 = (arg_278_1.time_ - var_281_23) / var_281_24
				local var_281_26 = Color.New(0, 0, 0)

				var_281_26.a = Mathf.Lerp(1, 0, var_281_25)
				arg_278_1.mask_.color = var_281_26
			end

			if arg_278_1.time_ >= var_281_23 + var_281_24 and arg_278_1.time_ < var_281_23 + var_281_24 + arg_281_0 then
				local var_281_27 = Color.New(0, 0, 0)
				local var_281_28 = 0

				arg_278_1.mask_.enabled = false
				var_281_27.a = var_281_28
				arg_278_1.mask_.color = var_281_27
			end

			local var_281_29 = arg_278_1.actors_["1011ui_story"]
			local var_281_30 = 0

			if var_281_30 < arg_278_1.time_ and arg_278_1.time_ <= var_281_30 + arg_281_0 and not isNil(var_281_29) and arg_278_1.var_.characterEffect1011ui_story == nil then
				arg_278_1.var_.characterEffect1011ui_story = var_281_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_281_31 = 0.200000002980232

			if var_281_30 <= arg_278_1.time_ and arg_278_1.time_ < var_281_30 + var_281_31 and not isNil(var_281_29) then
				local var_281_32 = (arg_278_1.time_ - var_281_30) / var_281_31

				if arg_278_1.var_.characterEffect1011ui_story and not isNil(var_281_29) then
					local var_281_33 = Mathf.Lerp(0, 0.5, var_281_32)

					arg_278_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_278_1.var_.characterEffect1011ui_story.fillRatio = var_281_33
				end
			end

			if arg_278_1.time_ >= var_281_30 + var_281_31 and arg_278_1.time_ < var_281_30 + var_281_31 + arg_281_0 and not isNil(var_281_29) and arg_278_1.var_.characterEffect1011ui_story then
				local var_281_34 = 0.5

				arg_278_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_278_1.var_.characterEffect1011ui_story.fillRatio = var_281_34
			end

			local var_281_35 = manager.ui.mainCamera.transform
			local var_281_36 = 2

			if var_281_36 < arg_278_1.time_ and arg_278_1.time_ <= var_281_36 + arg_281_0 then
				local var_281_37 = arg_278_1.var_.effect811

				if var_281_37 then
					Object.Destroy(var_281_37)

					arg_278_1.var_.effect811 = nil
				end
			end

			local var_281_38 = 0.4
			local var_281_39 = 1

			if var_281_38 < arg_278_1.time_ and arg_278_1.time_ <= var_281_38 + arg_281_0 then
				local var_281_40 = "stop"
				local var_281_41 = "effect"

				arg_278_1:AudioAction(var_281_40, var_281_41, "se_story_122_01", "se_story_122_01_dizzy_loop", "")
			end

			if arg_278_1.frameCnt_ <= 1 then
				arg_278_1.dialog_:SetActive(false)
			end

			local var_281_42 = 3.8
			local var_281_43 = 1.025

			if var_281_42 < arg_278_1.time_ and arg_278_1.time_ <= var_281_42 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0

				arg_278_1.dialog_:SetActive(true)

				arg_278_1.dialogCg_.alpha = 0

				local var_281_44 = LeanTween.value(arg_278_1.dialog_, 0, 1, 0.3)

				var_281_44:setOnUpdate(LuaHelper.FloatAction(function(arg_282_0)
					arg_278_1.dialogCg_.alpha = arg_282_0
				end))
				var_281_44:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_278_1.dialog_)
					var_281_44:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_278_1.duration_ = arg_278_1.duration_ + 0.3

				SetActive(arg_278_1.leftNameGo_, false)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_278_1.iconTrs_.gameObject, false)
				arg_278_1.callingController_:SetSelectedState("normal")

				local var_281_45 = arg_278_1:GetWordFromCfg(321091067)
				local var_281_46 = arg_278_1:FormatText(var_281_45.content)

				arg_278_1.text_.text = var_281_46

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_47 = 41
				local var_281_48 = utf8.len(var_281_46)
				local var_281_49 = var_281_47 <= 0 and var_281_43 or var_281_43 * (var_281_48 / var_281_47)

				if var_281_49 > 0 and var_281_43 < var_281_49 then
					arg_278_1.talkMaxDuration = var_281_49
					var_281_42 = var_281_42 + 0.3

					if var_281_49 + var_281_42 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_49 + var_281_42
					end
				end

				arg_278_1.text_.text = var_281_46
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)
				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_50 = var_281_42 + 0.3
			local var_281_51 = math.max(var_281_43, arg_278_1.talkMaxDuration)

			if var_281_50 <= arg_278_1.time_ and arg_278_1.time_ < var_281_50 + var_281_51 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - var_281_50) / var_281_51

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= var_281_50 + var_281_51 and arg_278_1.time_ < var_281_50 + var_281_51 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {}

		arg_278_1:InitPlayNodeList()
	end,
	Play321091068 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 321091068
		arg_284_1.duration_ = 5.43

		SetActive(arg_284_1.tipsGo_, false)

		function arg_284_1.onSingleLineFinish_()
			arg_284_1.onSingleLineUpdate_ = nil
			arg_284_1.onSingleLineFinish_ = nil
			arg_284_1.state_ = "waiting"
		end

		function arg_284_1.playNext_(arg_286_0)
			if arg_286_0 == 1 then
				arg_284_0:Play321091069(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			local var_287_0
			local var_287_1 = 0

			if var_287_1 < arg_284_1.time_ and arg_284_1.time_ <= var_287_1 + arg_287_0 then
				local var_287_2 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_287_2 then
					var_287_2.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_287_2.radialBlurScale = 0
					var_287_2.radialBlurGradient = 1
					var_287_2.radialBlurIntensity = 1

					if var_287_0 then
						var_287_2.radialBlurTarget = var_287_0.transform
					end
				end
			end

			local var_287_3 = 1.33333333333333

			if var_287_1 <= arg_284_1.time_ and arg_284_1.time_ < var_287_1 + var_287_3 then
				local var_287_4 = (arg_284_1.time_ - var_287_1) / var_287_3
				local var_287_5 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_287_5 then
					var_287_5.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_287_5.radialBlurScale = Mathf.Lerp(0, 0, var_287_4)
					var_287_5.radialBlurGradient = Mathf.Lerp(1, 1, var_287_4)
					var_287_5.radialBlurIntensity = Mathf.Lerp(1, 1, var_287_4)
				end
			end

			if arg_284_1.time_ >= var_287_1 + var_287_3 and arg_284_1.time_ < var_287_1 + var_287_3 + arg_287_0 then
				local var_287_6 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_287_6 then
					var_287_6.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_287_6.radialBlurScale = 0
					var_287_6.radialBlurGradient = 1
					var_287_6.radialBlurIntensity = 1
				end
			end

			local var_287_7 = 0

			if var_287_7 < arg_284_1.time_ and arg_284_1.time_ <= var_287_7 + arg_287_0 then
				arg_284_1.mask_.enabled = true
				arg_284_1.mask_.raycastTarget = true

				arg_284_1:SetGaussion(false)
			end

			local var_287_8 = 0.3

			if var_287_7 <= arg_284_1.time_ and arg_284_1.time_ < var_287_7 + var_287_8 then
				local var_287_9 = (arg_284_1.time_ - var_287_7) / var_287_8
				local var_287_10 = Color.New(0, 0, 0)

				var_287_10.a = Mathf.Lerp(1, 0, var_287_9)
				arg_284_1.mask_.color = var_287_10
			end

			if arg_284_1.time_ >= var_287_7 + var_287_8 and arg_284_1.time_ < var_287_7 + var_287_8 + arg_287_0 then
				local var_287_11 = Color.New(0, 0, 0)
				local var_287_12 = 0

				arg_284_1.mask_.enabled = false
				var_287_11.a = var_287_12
				arg_284_1.mask_.color = var_287_11
			end

			local var_287_13 = 0.3
			local var_287_14 = 1

			if var_287_13 < arg_284_1.time_ and arg_284_1.time_ <= var_287_13 + arg_287_0 then
				local var_287_15 = "play"
				local var_287_16 = "effect"

				arg_284_1:AudioAction(var_287_15, var_287_16, "se_story_140", "se_story_140_explosion01", "")
			end

			local var_287_17 = 2.3
			local var_287_18 = 1

			if var_287_17 < arg_284_1.time_ and arg_284_1.time_ <= var_287_17 + arg_287_0 then
				local var_287_19 = "play"
				local var_287_20 = "effect"

				arg_284_1:AudioAction(var_287_19, var_287_20, "se_story_140", "se_story_140_amb_drone04", "")
			end

			local var_287_21 = manager.ui.mainCamera.transform
			local var_287_22 = 0.1

			if var_287_22 < arg_284_1.time_ and arg_284_1.time_ <= var_287_22 + arg_287_0 then
				arg_284_1.var_.shakeOldPos = var_287_21.localPosition
			end

			local var_287_23 = 0.633333333333333

			if var_287_22 <= arg_284_1.time_ and arg_284_1.time_ < var_287_22 + var_287_23 then
				local var_287_24 = (arg_284_1.time_ - var_287_22) / 0.066
				local var_287_25, var_287_26 = math.modf(var_287_24)

				var_287_21.localPosition = Vector3.New(var_287_26 * 0.13, var_287_26 * 0.13, var_287_26 * 0.13) + arg_284_1.var_.shakeOldPos
			end

			if arg_284_1.time_ >= var_287_22 + var_287_23 and arg_284_1.time_ < var_287_22 + var_287_23 + arg_287_0 then
				var_287_21.localPosition = arg_284_1.var_.shakeOldPos
			end

			local var_287_27 = 0

			if var_287_27 < arg_284_1.time_ and arg_284_1.time_ <= var_287_27 + arg_287_0 then
				arg_284_1.allBtn_.enabled = false
			end

			local var_287_28 = 1.3

			if arg_284_1.time_ >= var_287_27 + var_287_28 and arg_284_1.time_ < var_287_27 + var_287_28 + arg_287_0 then
				arg_284_1.allBtn_.enabled = true
			end

			if arg_284_1.frameCnt_ <= 1 then
				arg_284_1.dialog_:SetActive(false)
			end

			local var_287_29 = 0.433333333333333
			local var_287_30 = 1.6

			if var_287_29 < arg_284_1.time_ and arg_284_1.time_ <= var_287_29 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0

				arg_284_1.dialog_:SetActive(true)

				arg_284_1.dialogCg_.alpha = 0

				local var_287_31 = LeanTween.value(arg_284_1.dialog_, 0, 1, 0.3)

				var_287_31:setOnUpdate(LuaHelper.FloatAction(function(arg_288_0)
					arg_284_1.dialogCg_.alpha = arg_288_0
				end))
				var_287_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_284_1.dialog_)
					var_287_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_284_1.duration_ = arg_284_1.duration_ + 0.3

				SetActive(arg_284_1.leftNameGo_, false)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_284_1.iconTrs_.gameObject, false)
				arg_284_1.callingController_:SetSelectedState("normal")

				local var_287_32 = arg_284_1:GetWordFromCfg(321091068)
				local var_287_33 = arg_284_1:FormatText(var_287_32.content)

				arg_284_1.text_.text = var_287_33

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_34 = 64
				local var_287_35 = utf8.len(var_287_33)
				local var_287_36 = var_287_34 <= 0 and var_287_30 or var_287_30 * (var_287_35 / var_287_34)

				if var_287_36 > 0 and var_287_30 < var_287_36 then
					arg_284_1.talkMaxDuration = var_287_36
					var_287_29 = var_287_29 + 0.3

					if var_287_36 + var_287_29 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_36 + var_287_29
					end
				end

				arg_284_1.text_.text = var_287_33
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)
				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_37 = var_287_29 + 0.3
			local var_287_38 = math.max(var_287_30, arg_284_1.talkMaxDuration)

			if var_287_37 <= arg_284_1.time_ and arg_284_1.time_ < var_287_37 + var_287_38 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - var_287_37) / var_287_38

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= var_287_37 + var_287_38 and arg_284_1.time_ < var_287_37 + var_287_38 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {}

		arg_284_1:InitPlayNodeList()
	end,
	Play321091069 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 321091069
		arg_290_1.duration_ = 5

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play321091070(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			local var_293_0 = 0
			local var_293_1 = 1.125

			if var_293_0 < arg_290_1.time_ and arg_290_1.time_ <= var_293_0 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, false)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_290_1.iconTrs_.gameObject, false)
				arg_290_1.callingController_:SetSelectedState("normal")

				local var_293_2 = arg_290_1:GetWordFromCfg(321091069)
				local var_293_3 = arg_290_1:FormatText(var_293_2.content)

				arg_290_1.text_.text = var_293_3

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_4 = 45
				local var_293_5 = utf8.len(var_293_3)
				local var_293_6 = var_293_4 <= 0 and var_293_1 or var_293_1 * (var_293_5 / var_293_4)

				if var_293_6 > 0 and var_293_1 < var_293_6 then
					arg_290_1.talkMaxDuration = var_293_6

					if var_293_6 + var_293_0 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_6 + var_293_0
					end
				end

				arg_290_1.text_.text = var_293_3
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)
				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_7 = math.max(var_293_1, arg_290_1.talkMaxDuration)

			if var_293_0 <= arg_290_1.time_ and arg_290_1.time_ < var_293_0 + var_293_7 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - var_293_0) / var_293_7

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= var_293_0 + var_293_7 and arg_290_1.time_ < var_293_0 + var_293_7 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {}

		arg_290_1:InitPlayNodeList()
	end,
	Play321091070 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 321091070
		arg_294_1.duration_ = 8.57

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play321091071(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			local var_297_0 = "L08g"

			if arg_294_1.bgs_[var_297_0] == nil then
				local var_297_1 = Object.Instantiate(arg_294_1.paintGo_)

				var_297_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_297_0)
				var_297_1.name = var_297_0
				var_297_1.transform.parent = arg_294_1.stage_.transform
				var_297_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_294_1.bgs_[var_297_0] = var_297_1
			end

			local var_297_2 = 1.999999999999

			if var_297_2 < arg_294_1.time_ and arg_294_1.time_ <= var_297_2 + arg_297_0 then
				local var_297_3 = manager.ui.mainCamera.transform.localPosition
				local var_297_4 = Vector3.New(0, 0, 10) + Vector3.New(var_297_3.x, var_297_3.y, 0)
				local var_297_5 = arg_294_1.bgs_.L08g

				var_297_5.transform.localPosition = var_297_4
				var_297_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_297_6 = var_297_5:GetComponent("SpriteRenderer")

				if var_297_6 and var_297_6.sprite then
					local var_297_7 = (var_297_5.transform.localPosition - var_297_3).z
					local var_297_8 = manager.ui.mainCameraCom_
					local var_297_9 = 2 * var_297_7 * Mathf.Tan(var_297_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_297_10 = var_297_9 * var_297_8.aspect
					local var_297_11 = var_297_6.sprite.bounds.size.x
					local var_297_12 = var_297_6.sprite.bounds.size.y
					local var_297_13 = var_297_10 / var_297_11
					local var_297_14 = var_297_9 / var_297_12
					local var_297_15 = var_297_14 < var_297_13 and var_297_13 or var_297_14

					var_297_5.transform.localScale = Vector3.New(var_297_15, var_297_15, 0)
				end

				for iter_297_0, iter_297_1 in pairs(arg_294_1.bgs_) do
					if iter_297_0 ~= "L08g" then
						iter_297_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_297_16 = 0

			if var_297_16 < arg_294_1.time_ and arg_294_1.time_ <= var_297_16 + arg_297_0 then
				arg_294_1.allBtn_.enabled = false
			end

			local var_297_17 = 0.3

			if arg_294_1.time_ >= var_297_16 + var_297_17 and arg_294_1.time_ < var_297_16 + var_297_17 + arg_297_0 then
				arg_294_1.allBtn_.enabled = true
			end

			local var_297_18 = 0

			if var_297_18 < arg_294_1.time_ and arg_294_1.time_ <= var_297_18 + arg_297_0 then
				arg_294_1.mask_.enabled = true
				arg_294_1.mask_.raycastTarget = true

				arg_294_1:SetGaussion(false)
			end

			local var_297_19 = 2

			if var_297_18 <= arg_294_1.time_ and arg_294_1.time_ < var_297_18 + var_297_19 then
				local var_297_20 = (arg_294_1.time_ - var_297_18) / var_297_19
				local var_297_21 = Color.New(0, 0, 0)

				var_297_21.a = Mathf.Lerp(0, 1, var_297_20)
				arg_294_1.mask_.color = var_297_21
			end

			if arg_294_1.time_ >= var_297_18 + var_297_19 and arg_294_1.time_ < var_297_18 + var_297_19 + arg_297_0 then
				local var_297_22 = Color.New(0, 0, 0)

				var_297_22.a = 1
				arg_294_1.mask_.color = var_297_22
			end

			local var_297_23 = 2

			if var_297_23 < arg_294_1.time_ and arg_294_1.time_ <= var_297_23 + arg_297_0 then
				arg_294_1.mask_.enabled = true
				arg_294_1.mask_.raycastTarget = true

				arg_294_1:SetGaussion(false)
			end

			local var_297_24 = 2

			if var_297_23 <= arg_294_1.time_ and arg_294_1.time_ < var_297_23 + var_297_24 then
				local var_297_25 = (arg_294_1.time_ - var_297_23) / var_297_24
				local var_297_26 = Color.New(0, 0, 0)

				var_297_26.a = Mathf.Lerp(1, 0, var_297_25)
				arg_294_1.mask_.color = var_297_26
			end

			if arg_294_1.time_ >= var_297_23 + var_297_24 and arg_294_1.time_ < var_297_23 + var_297_24 + arg_297_0 then
				local var_297_27 = Color.New(0, 0, 0)
				local var_297_28 = 0

				arg_294_1.mask_.enabled = false
				var_297_27.a = var_297_28
				arg_294_1.mask_.color = var_297_27
			end

			local var_297_29 = manager.ui.mainCamera.transform
			local var_297_30 = 2

			if var_297_30 < arg_294_1.time_ and arg_294_1.time_ <= var_297_30 + arg_297_0 then
				arg_294_1.var_.shakeOldPos = var_297_29.localPosition
			end

			local var_297_31 = 2.1

			if var_297_30 <= arg_294_1.time_ and arg_294_1.time_ < var_297_30 + var_297_31 then
				local var_297_32 = (arg_294_1.time_ - var_297_30) / 0.066
				local var_297_33, var_297_34 = math.modf(var_297_32)

				var_297_29.localPosition = Vector3.New(var_297_34 * 0.13, var_297_34 * 0.13, var_297_34 * 0.13) + arg_294_1.var_.shakeOldPos
			end

			if arg_294_1.time_ >= var_297_30 + var_297_31 and arg_294_1.time_ < var_297_30 + var_297_31 + arg_297_0 then
				var_297_29.localPosition = arg_294_1.var_.shakeOldPos
			end

			if arg_294_1.frameCnt_ <= 1 then
				arg_294_1.dialog_:SetActive(false)
			end

			local var_297_35 = 3.56666666666667
			local var_297_36 = 0.25

			if var_297_35 < arg_294_1.time_ and arg_294_1.time_ <= var_297_35 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0

				arg_294_1.dialog_:SetActive(true)

				arg_294_1.dialogCg_.alpha = 0

				local var_297_37 = LeanTween.value(arg_294_1.dialog_, 0, 1, 0.3)

				var_297_37:setOnUpdate(LuaHelper.FloatAction(function(arg_298_0)
					arg_294_1.dialogCg_.alpha = arg_298_0
				end))
				var_297_37:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_294_1.dialog_)
					var_297_37:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_294_1.duration_ = arg_294_1.duration_ + 0.3

				SetActive(arg_294_1.leftNameGo_, true)

				local var_297_38 = arg_294_1:FormatText(StoryNameCfg[7].name)

				arg_294_1.leftNameTxt_.text = var_297_38

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_294_1.leftNameTxt_.transform)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1.leftNameTxt_.text)
				SetActive(arg_294_1.iconTrs_.gameObject, true)
				arg_294_1.iconController_:SetSelectedState("hero")

				arg_294_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_294_1.callingController_:SetSelectedState("normal")

				arg_294_1.keyicon_.color = Color.New(1, 1, 1)
				arg_294_1.icon_.color = Color.New(1, 1, 1)

				local var_297_39 = arg_294_1:GetWordFromCfg(321091070)
				local var_297_40 = arg_294_1:FormatText(var_297_39.content)

				arg_294_1.text_.text = var_297_40

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_41 = 10
				local var_297_42 = utf8.len(var_297_40)
				local var_297_43 = var_297_41 <= 0 and var_297_36 or var_297_36 * (var_297_42 / var_297_41)

				if var_297_43 > 0 and var_297_36 < var_297_43 then
					arg_294_1.talkMaxDuration = var_297_43
					var_297_35 = var_297_35 + 0.3

					if var_297_43 + var_297_35 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_43 + var_297_35
					end
				end

				arg_294_1.text_.text = var_297_40
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)
				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_44 = var_297_35 + 0.3
			local var_297_45 = math.max(var_297_36, arg_294_1.talkMaxDuration)

			if var_297_44 <= arg_294_1.time_ and arg_294_1.time_ < var_297_44 + var_297_45 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - var_297_44) / var_297_45

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= var_297_44 + var_297_45 and arg_294_1.time_ < var_297_44 + var_297_45 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {}

		arg_294_1:InitPlayNodeList()
	end,
	Play321091071 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 321091071
		arg_300_1.duration_ = 5

		SetActive(arg_300_1.tipsGo_, false)

		function arg_300_1.onSingleLineFinish_()
			arg_300_1.onSingleLineUpdate_ = nil
			arg_300_1.onSingleLineFinish_ = nil
			arg_300_1.state_ = "waiting"
		end

		function arg_300_1.playNext_(arg_302_0)
			if arg_302_0 == 1 then
				arg_300_0:Play321091072(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			local var_303_0 = 0
			local var_303_1 = 1.225

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

				local var_303_2 = arg_300_1:GetWordFromCfg(321091071)
				local var_303_3 = arg_300_1:FormatText(var_303_2.content)

				arg_300_1.text_.text = var_303_3

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_4 = 49
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
	Play321091072 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 321091072
		arg_304_1.duration_ = 3.87

		local var_304_0 = {
			zh = 3.533,
			ja = 3.866
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
				arg_304_0:Play321091073(arg_304_1)
			end
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			local var_307_0 = arg_304_1.actors_["10104ui_story"]
			local var_307_1 = 0

			if var_307_1 < arg_304_1.time_ and arg_304_1.time_ <= var_307_1 + arg_307_0 and not isNil(var_307_0) and arg_304_1.var_.characterEffect10104ui_story == nil then
				arg_304_1.var_.characterEffect10104ui_story = var_307_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_307_2 = 0.200000002980232

			if var_307_1 <= arg_304_1.time_ and arg_304_1.time_ < var_307_1 + var_307_2 and not isNil(var_307_0) then
				local var_307_3 = (arg_304_1.time_ - var_307_1) / var_307_2

				if arg_304_1.var_.characterEffect10104ui_story and not isNil(var_307_0) then
					arg_304_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_304_1.time_ >= var_307_1 + var_307_2 and arg_304_1.time_ < var_307_1 + var_307_2 + arg_307_0 and not isNil(var_307_0) and arg_304_1.var_.characterEffect10104ui_story then
				arg_304_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_307_4 = 0

			if var_307_4 < arg_304_1.time_ and arg_304_1.time_ <= var_307_4 + arg_307_0 then
				arg_304_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action7_1")
			end

			local var_307_5 = 0

			if var_307_5 < arg_304_1.time_ and arg_304_1.time_ <= var_307_5 + arg_307_0 then
				arg_304_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_307_6 = arg_304_1.actors_["10104ui_story"].transform
			local var_307_7 = 0

			if var_307_7 < arg_304_1.time_ and arg_304_1.time_ <= var_307_7 + arg_307_0 then
				arg_304_1.var_.moveOldPos10104ui_story = var_307_6.localPosition
			end

			local var_307_8 = 0.001

			if var_307_7 <= arg_304_1.time_ and arg_304_1.time_ < var_307_7 + var_307_8 then
				local var_307_9 = (arg_304_1.time_ - var_307_7) / var_307_8
				local var_307_10 = Vector3.New(0.02, -1.12, -5.99)

				var_307_6.localPosition = Vector3.Lerp(arg_304_1.var_.moveOldPos10104ui_story, var_307_10, var_307_9)

				local var_307_11 = manager.ui.mainCamera.transform.position - var_307_6.position

				var_307_6.forward = Vector3.New(var_307_11.x, var_307_11.y, var_307_11.z)

				local var_307_12 = var_307_6.localEulerAngles

				var_307_12.z = 0
				var_307_12.x = 0
				var_307_6.localEulerAngles = var_307_12
			end

			if arg_304_1.time_ >= var_307_7 + var_307_8 and arg_304_1.time_ < var_307_7 + var_307_8 + arg_307_0 then
				var_307_6.localPosition = Vector3.New(0.02, -1.12, -5.99)

				local var_307_13 = manager.ui.mainCamera.transform.position - var_307_6.position

				var_307_6.forward = Vector3.New(var_307_13.x, var_307_13.y, var_307_13.z)

				local var_307_14 = var_307_6.localEulerAngles

				var_307_14.z = 0
				var_307_14.x = 0
				var_307_6.localEulerAngles = var_307_14
			end

			local var_307_15 = 0
			local var_307_16 = 0.3

			if var_307_15 < arg_304_1.time_ and arg_304_1.time_ <= var_307_15 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0
				arg_304_1.dialogCg_.alpha = 1

				arg_304_1.dialog_:SetActive(true)
				SetActive(arg_304_1.leftNameGo_, true)

				local var_307_17 = arg_304_1:FormatText(StoryNameCfg[1030].name)

				arg_304_1.leftNameTxt_.text = var_307_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_304_1.leftNameTxt_.transform)

				arg_304_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_304_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_304_1:RecordName(arg_304_1.leftNameTxt_.text)
				SetActive(arg_304_1.iconTrs_.gameObject, false)
				arg_304_1.callingController_:SetSelectedState("normal")

				local var_307_18 = arg_304_1:GetWordFromCfg(321091072)
				local var_307_19 = arg_304_1:FormatText(var_307_18.content)

				arg_304_1.text_.text = var_307_19

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_20 = 12
				local var_307_21 = utf8.len(var_307_19)
				local var_307_22 = var_307_20 <= 0 and var_307_16 or var_307_16 * (var_307_21 / var_307_20)

				if var_307_22 > 0 and var_307_16 < var_307_22 then
					arg_304_1.talkMaxDuration = var_307_22

					if var_307_22 + var_307_15 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_22 + var_307_15
					end
				end

				arg_304_1.text_.text = var_307_19
				arg_304_1.typewritter.percent = 0

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091072", "story_v_out_321091.awb") ~= 0 then
					local var_307_23 = manager.audio:GetVoiceLength("story_v_out_321091", "321091072", "story_v_out_321091.awb") / 1000

					if var_307_23 + var_307_15 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_23 + var_307_15
					end

					if var_307_18.prefab_name ~= "" and arg_304_1.actors_[var_307_18.prefab_name] ~= nil then
						local var_307_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_304_1.actors_[var_307_18.prefab_name].transform, "story_v_out_321091", "321091072", "story_v_out_321091.awb")

						arg_304_1:RecordAudio("321091072", var_307_24)
						arg_304_1:RecordAudio("321091072", var_307_24)
					else
						arg_304_1:AudioAction("play", "voice", "story_v_out_321091", "321091072", "story_v_out_321091.awb")
					end

					arg_304_1:RecordHistoryTalkVoice("story_v_out_321091", "321091072", "story_v_out_321091.awb")
				end

				arg_304_1:RecordContent(arg_304_1.text_.text)
			end

			local var_307_25 = math.max(var_307_16, arg_304_1.talkMaxDuration)

			if var_307_15 <= arg_304_1.time_ and arg_304_1.time_ < var_307_15 + var_307_25 then
				arg_304_1.typewritter.percent = (arg_304_1.time_ - var_307_15) / var_307_25

				arg_304_1.typewritter:SetDirty()
			end

			if arg_304_1.time_ >= var_307_15 + var_307_25 and arg_304_1.time_ < var_307_15 + var_307_25 + arg_307_0 then
				arg_304_1.typewritter.percent = 1

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(true)
			end
		end

		arg_304_1.nodeConfigList_ = {
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

		arg_304_1:InitPlayNodeList()
	end,
	Play321091073 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 321091073
		arg_308_1.duration_ = 2

		SetActive(arg_308_1.tipsGo_, false)

		function arg_308_1.onSingleLineFinish_()
			arg_308_1.onSingleLineUpdate_ = nil
			arg_308_1.onSingleLineFinish_ = nil
			arg_308_1.state_ = "waiting"
		end

		function arg_308_1.playNext_(arg_310_0)
			if arg_310_0 == 1 then
				arg_308_0:Play321091074(arg_308_1)
			end
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			local var_311_0 = "1284ui_story"

			if arg_308_1.actors_[var_311_0] == nil then
				local var_311_1 = Asset.Load("Char/" .. "1284ui_story")

				if not isNil(var_311_1) then
					local var_311_2 = Object.Instantiate(Asset.Load("Char/" .. "1284ui_story"), arg_308_1.stage_.transform)

					var_311_2.name = var_311_0
					var_311_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_308_1.actors_[var_311_0] = var_311_2

					local var_311_3 = var_311_2:GetComponentInChildren(typeof(CharacterEffect))

					var_311_3.enabled = true

					local var_311_4 = GameObjectTools.GetOrAddComponent(var_311_2, typeof(DynamicBoneHelper))

					if var_311_4 then
						var_311_4:EnableDynamicBone(false)
					end

					arg_308_1:ShowWeapon(var_311_3.transform, false)

					arg_308_1.var_[var_311_0 .. "Animator"] = var_311_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_308_1.var_[var_311_0 .. "Animator"].applyRootMotion = true
					arg_308_1.var_[var_311_0 .. "LipSync"] = var_311_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_311_5 = arg_308_1.actors_["1284ui_story"].transform
			local var_311_6 = 0

			if var_311_6 < arg_308_1.time_ and arg_308_1.time_ <= var_311_6 + arg_311_0 then
				arg_308_1.var_.moveOldPos1284ui_story = var_311_5.localPosition

				local var_311_7 = "1284ui_story"

				arg_308_1:ShowWeapon(arg_308_1.var_[var_311_7 .. "Animator"].transform, false)
			end

			local var_311_8 = 0.001

			if var_311_6 <= arg_308_1.time_ and arg_308_1.time_ < var_311_6 + var_311_8 then
				local var_311_9 = (arg_308_1.time_ - var_311_6) / var_311_8
				local var_311_10 = Vector3.New(0, -0.985, -6.22)

				var_311_5.localPosition = Vector3.Lerp(arg_308_1.var_.moveOldPos1284ui_story, var_311_10, var_311_9)

				local var_311_11 = manager.ui.mainCamera.transform.position - var_311_5.position

				var_311_5.forward = Vector3.New(var_311_11.x, var_311_11.y, var_311_11.z)

				local var_311_12 = var_311_5.localEulerAngles

				var_311_12.z = 0
				var_311_12.x = 0
				var_311_5.localEulerAngles = var_311_12
			end

			if arg_308_1.time_ >= var_311_6 + var_311_8 and arg_308_1.time_ < var_311_6 + var_311_8 + arg_311_0 then
				var_311_5.localPosition = Vector3.New(0, -0.985, -6.22)

				local var_311_13 = manager.ui.mainCamera.transform.position - var_311_5.position

				var_311_5.forward = Vector3.New(var_311_13.x, var_311_13.y, var_311_13.z)

				local var_311_14 = var_311_5.localEulerAngles

				var_311_14.z = 0
				var_311_14.x = 0
				var_311_5.localEulerAngles = var_311_14
			end

			local var_311_15 = arg_308_1.actors_["1284ui_story"]
			local var_311_16 = 0

			if var_311_16 < arg_308_1.time_ and arg_308_1.time_ <= var_311_16 + arg_311_0 and not isNil(var_311_15) and arg_308_1.var_.characterEffect1284ui_story == nil then
				arg_308_1.var_.characterEffect1284ui_story = var_311_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_311_17 = 0.200000002980232

			if var_311_16 <= arg_308_1.time_ and arg_308_1.time_ < var_311_16 + var_311_17 and not isNil(var_311_15) then
				local var_311_18 = (arg_308_1.time_ - var_311_16) / var_311_17

				if arg_308_1.var_.characterEffect1284ui_story and not isNil(var_311_15) then
					arg_308_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_308_1.time_ >= var_311_16 + var_311_17 and arg_308_1.time_ < var_311_16 + var_311_17 + arg_311_0 and not isNil(var_311_15) and arg_308_1.var_.characterEffect1284ui_story then
				arg_308_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_311_19 = arg_308_1.actors_["10104ui_story"]
			local var_311_20 = 0

			if var_311_20 < arg_308_1.time_ and arg_308_1.time_ <= var_311_20 + arg_311_0 and not isNil(var_311_19) and arg_308_1.var_.characterEffect10104ui_story == nil then
				arg_308_1.var_.characterEffect10104ui_story = var_311_19:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_311_21 = 0.200000002980232

			if var_311_20 <= arg_308_1.time_ and arg_308_1.time_ < var_311_20 + var_311_21 and not isNil(var_311_19) then
				local var_311_22 = (arg_308_1.time_ - var_311_20) / var_311_21

				if arg_308_1.var_.characterEffect10104ui_story and not isNil(var_311_19) then
					local var_311_23 = Mathf.Lerp(0, 0.5, var_311_22)

					arg_308_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_308_1.var_.characterEffect10104ui_story.fillRatio = var_311_23
				end
			end

			if arg_308_1.time_ >= var_311_20 + var_311_21 and arg_308_1.time_ < var_311_20 + var_311_21 + arg_311_0 and not isNil(var_311_19) and arg_308_1.var_.characterEffect10104ui_story then
				local var_311_24 = 0.5

				arg_308_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_308_1.var_.characterEffect10104ui_story.fillRatio = var_311_24
			end

			local var_311_25 = 0

			if var_311_25 < arg_308_1.time_ and arg_308_1.time_ <= var_311_25 + arg_311_0 then
				arg_308_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action1_1")
			end

			local var_311_26 = 0

			if var_311_26 < arg_308_1.time_ and arg_308_1.time_ <= var_311_26 + arg_311_0 then
				arg_308_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_311_27 = arg_308_1.actors_["10104ui_story"].transform
			local var_311_28 = 0

			if var_311_28 < arg_308_1.time_ and arg_308_1.time_ <= var_311_28 + arg_311_0 then
				arg_308_1.var_.moveOldPos10104ui_story = var_311_27.localPosition
			end

			local var_311_29 = 0.001

			if var_311_28 <= arg_308_1.time_ and arg_308_1.time_ < var_311_28 + var_311_29 then
				local var_311_30 = (arg_308_1.time_ - var_311_28) / var_311_29
				local var_311_31 = Vector3.New(0, 100, 0)

				var_311_27.localPosition = Vector3.Lerp(arg_308_1.var_.moveOldPos10104ui_story, var_311_31, var_311_30)

				local var_311_32 = manager.ui.mainCamera.transform.position - var_311_27.position

				var_311_27.forward = Vector3.New(var_311_32.x, var_311_32.y, var_311_32.z)

				local var_311_33 = var_311_27.localEulerAngles

				var_311_33.z = 0
				var_311_33.x = 0
				var_311_27.localEulerAngles = var_311_33
			end

			if arg_308_1.time_ >= var_311_28 + var_311_29 and arg_308_1.time_ < var_311_28 + var_311_29 + arg_311_0 then
				var_311_27.localPosition = Vector3.New(0, 100, 0)

				local var_311_34 = manager.ui.mainCamera.transform.position - var_311_27.position

				var_311_27.forward = Vector3.New(var_311_34.x, var_311_34.y, var_311_34.z)

				local var_311_35 = var_311_27.localEulerAngles

				var_311_35.z = 0
				var_311_35.x = 0
				var_311_27.localEulerAngles = var_311_35
			end

			local var_311_36 = 0
			local var_311_37 = 0.125

			if var_311_36 < arg_308_1.time_ and arg_308_1.time_ <= var_311_36 + arg_311_0 then
				arg_308_1.talkMaxDuration = 0
				arg_308_1.dialogCg_.alpha = 1

				arg_308_1.dialog_:SetActive(true)
				SetActive(arg_308_1.leftNameGo_, true)

				local var_311_38 = arg_308_1:FormatText(StoryNameCfg[6].name)

				arg_308_1.leftNameTxt_.text = var_311_38

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_308_1.leftNameTxt_.transform)

				arg_308_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_308_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_308_1:RecordName(arg_308_1.leftNameTxt_.text)
				SetActive(arg_308_1.iconTrs_.gameObject, false)
				arg_308_1.callingController_:SetSelectedState("normal")

				local var_311_39 = arg_308_1:GetWordFromCfg(321091073)
				local var_311_40 = arg_308_1:FormatText(var_311_39.content)

				arg_308_1.text_.text = var_311_40

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_41 = 5
				local var_311_42 = utf8.len(var_311_40)
				local var_311_43 = var_311_41 <= 0 and var_311_37 or var_311_37 * (var_311_42 / var_311_41)

				if var_311_43 > 0 and var_311_37 < var_311_43 then
					arg_308_1.talkMaxDuration = var_311_43

					if var_311_43 + var_311_36 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_43 + var_311_36
					end
				end

				arg_308_1.text_.text = var_311_40
				arg_308_1.typewritter.percent = 0

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091073", "story_v_out_321091.awb") ~= 0 then
					local var_311_44 = manager.audio:GetVoiceLength("story_v_out_321091", "321091073", "story_v_out_321091.awb") / 1000

					if var_311_44 + var_311_36 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_44 + var_311_36
					end

					if var_311_39.prefab_name ~= "" and arg_308_1.actors_[var_311_39.prefab_name] ~= nil then
						local var_311_45 = LuaForUtil.PlayVoiceWithCriLipsync(arg_308_1.actors_[var_311_39.prefab_name].transform, "story_v_out_321091", "321091073", "story_v_out_321091.awb")

						arg_308_1:RecordAudio("321091073", var_311_45)
						arg_308_1:RecordAudio("321091073", var_311_45)
					else
						arg_308_1:AudioAction("play", "voice", "story_v_out_321091", "321091073", "story_v_out_321091.awb")
					end

					arg_308_1:RecordHistoryTalkVoice("story_v_out_321091", "321091073", "story_v_out_321091.awb")
				end

				arg_308_1:RecordContent(arg_308_1.text_.text)
			end

			local var_311_46 = math.max(var_311_37, arg_308_1.talkMaxDuration)

			if var_311_36 <= arg_308_1.time_ and arg_308_1.time_ < var_311_36 + var_311_46 then
				arg_308_1.typewritter.percent = (arg_308_1.time_ - var_311_36) / var_311_46

				arg_308_1.typewritter:SetDirty()
			end

			if arg_308_1.time_ >= var_311_36 + var_311_46 and arg_308_1.time_ < var_311_36 + var_311_46 + arg_311_0 then
				arg_308_1.typewritter.percent = 1

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(true)
			end
		end

		arg_308_1.nodeConfigList_ = {
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
				actorName = "10104ui_story",
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
	Play321091074 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 321091074
		arg_312_1.duration_ = 6.2

		SetActive(arg_312_1.tipsGo_, false)

		function arg_312_1.onSingleLineFinish_()
			arg_312_1.onSingleLineUpdate_ = nil
			arg_312_1.onSingleLineFinish_ = nil
			arg_312_1.state_ = "waiting"
		end

		function arg_312_1.playNext_(arg_314_0)
			if arg_314_0 == 1 then
				arg_312_0:Play321091075(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			local var_315_0 = arg_312_1.actors_["1284ui_story"]
			local var_315_1 = 0

			if var_315_1 < arg_312_1.time_ and arg_312_1.time_ <= var_315_1 + arg_315_0 and not isNil(var_315_0) and arg_312_1.var_.characterEffect1284ui_story == nil then
				arg_312_1.var_.characterEffect1284ui_story = var_315_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_315_2 = 0.200000002980232

			if var_315_1 <= arg_312_1.time_ and arg_312_1.time_ < var_315_1 + var_315_2 and not isNil(var_315_0) then
				local var_315_3 = (arg_312_1.time_ - var_315_1) / var_315_2

				if arg_312_1.var_.characterEffect1284ui_story and not isNil(var_315_0) then
					local var_315_4 = Mathf.Lerp(0, 0.5, var_315_3)

					arg_312_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_312_1.var_.characterEffect1284ui_story.fillRatio = var_315_4
				end
			end

			if arg_312_1.time_ >= var_315_1 + var_315_2 and arg_312_1.time_ < var_315_1 + var_315_2 + arg_315_0 and not isNil(var_315_0) and arg_312_1.var_.characterEffect1284ui_story then
				local var_315_5 = 0.5

				arg_312_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_312_1.var_.characterEffect1284ui_story.fillRatio = var_315_5
			end

			local var_315_6 = arg_312_1.actors_["1284ui_story"].transform
			local var_315_7 = 0

			if var_315_7 < arg_312_1.time_ and arg_312_1.time_ <= var_315_7 + arg_315_0 then
				arg_312_1.var_.moveOldPos1284ui_story = var_315_6.localPosition

				local var_315_8 = "1284ui_story"

				arg_312_1:ShowWeapon(arg_312_1.var_[var_315_8 .. "Animator"].transform, false)
			end

			local var_315_9 = 0.001

			if var_315_7 <= arg_312_1.time_ and arg_312_1.time_ < var_315_7 + var_315_9 then
				local var_315_10 = (arg_312_1.time_ - var_315_7) / var_315_9
				local var_315_11 = Vector3.New(0, 100, 0)

				var_315_6.localPosition = Vector3.Lerp(arg_312_1.var_.moveOldPos1284ui_story, var_315_11, var_315_10)

				local var_315_12 = manager.ui.mainCamera.transform.position - var_315_6.position

				var_315_6.forward = Vector3.New(var_315_12.x, var_315_12.y, var_315_12.z)

				local var_315_13 = var_315_6.localEulerAngles

				var_315_13.z = 0
				var_315_13.x = 0
				var_315_6.localEulerAngles = var_315_13
			end

			if arg_312_1.time_ >= var_315_7 + var_315_9 and arg_312_1.time_ < var_315_7 + var_315_9 + arg_315_0 then
				var_315_6.localPosition = Vector3.New(0, 100, 0)

				local var_315_14 = manager.ui.mainCamera.transform.position - var_315_6.position

				var_315_6.forward = Vector3.New(var_315_14.x, var_315_14.y, var_315_14.z)

				local var_315_15 = var_315_6.localEulerAngles

				var_315_15.z = 0
				var_315_15.x = 0
				var_315_6.localEulerAngles = var_315_15
			end

			local var_315_16 = 0.034000001847744
			local var_315_17 = 1

			if var_315_16 < arg_312_1.time_ and arg_312_1.time_ <= var_315_16 + arg_315_0 then
				local var_315_18 = "stop"
				local var_315_19 = "effect"

				arg_312_1:AudioAction(var_315_18, var_315_19, "se_story_140", "se_story_140_rock1", "")
			end

			local var_315_20 = manager.ui.mainCamera.transform
			local var_315_21 = 0.3

			if var_315_21 < arg_312_1.time_ and arg_312_1.time_ <= var_315_21 + arg_315_0 then
				local var_315_22 = arg_312_1.var_.effect987
				local var_315_23
				local var_315_24 = var_315_20

				if not var_315_22 then
					var_315_22 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_dust"), var_315_24)
					var_315_22.name = "987"
					arg_312_1.var_.effect987 = var_315_22
				else
					var_315_22.transform:SetParent(var_315_24)
				end

				var_315_22.transform.localPosition = Vector3.New(0, 0, 0)
				var_315_22.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_315_25 = manager.ui.mainCameraCom_
				local var_315_26 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_315_25.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_315_27 = var_315_22.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_315_28 = 15
				local var_315_29 = 2 * var_315_28 * Mathf.Tan(var_315_25.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_315_25.aspect
				local var_315_30 = 1
				local var_315_31 = 1.7777777777777777

				if var_315_31 < var_315_25.aspect then
					var_315_30 = var_315_29 / (2 * var_315_28 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_315_31)
				end

				for iter_315_0, iter_315_1 in ipairs(var_315_27) do
					local var_315_32 = iter_315_1.transform.localScale

					iter_315_1.transform.localScale = Vector3.New(var_315_32.x / var_315_26 * var_315_30, var_315_32.y / var_315_26, var_315_32.z)
				end
			end

			local var_315_33 = manager.ui.mainCamera.transform
			local var_315_34 = 0

			if var_315_34 < arg_312_1.time_ and arg_312_1.time_ <= var_315_34 + arg_315_0 then
				arg_312_1.var_.shakeOldPos = var_315_33.localPosition
			end

			local var_315_35 = 0.8

			if var_315_34 <= arg_312_1.time_ and arg_312_1.time_ < var_315_34 + var_315_35 then
				local var_315_36 = (arg_312_1.time_ - var_315_34) / 0.066
				local var_315_37, var_315_38 = math.modf(var_315_36)

				var_315_33.localPosition = Vector3.New(var_315_38 * 0.13, var_315_38 * 0.13, var_315_38 * 0.13) + arg_312_1.var_.shakeOldPos
			end

			if arg_312_1.time_ >= var_315_34 + var_315_35 and arg_312_1.time_ < var_315_34 + var_315_35 + arg_315_0 then
				var_315_33.localPosition = arg_312_1.var_.shakeOldPos
			end

			local var_315_39 = 0

			if var_315_39 < arg_312_1.time_ and arg_312_1.time_ <= var_315_39 + arg_315_0 then
				arg_312_1.allBtn_.enabled = false
			end

			local var_315_40 = 1.56666666666667

			if arg_312_1.time_ >= var_315_39 + var_315_40 and arg_312_1.time_ < var_315_39 + var_315_40 + arg_315_0 then
				arg_312_1.allBtn_.enabled = true
			end

			local var_315_41 = 0.1
			local var_315_42 = 1

			if var_315_41 < arg_312_1.time_ and arg_312_1.time_ <= var_315_41 + arg_315_0 then
				local var_315_43 = "play"
				local var_315_44 = "effect"

				arg_312_1:AudioAction(var_315_43, var_315_44, "se_story_140", "se_story_140_rock1", "")
			end

			if arg_312_1.frameCnt_ <= 1 then
				arg_312_1.dialog_:SetActive(false)
			end

			local var_315_45 = 1.20000000298023
			local var_315_46 = 1.425

			if var_315_45 < arg_312_1.time_ and arg_312_1.time_ <= var_315_45 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0

				arg_312_1.dialog_:SetActive(true)

				arg_312_1.dialogCg_.alpha = 0

				local var_315_47 = LeanTween.value(arg_312_1.dialog_, 0, 1, 0.3)

				var_315_47:setOnUpdate(LuaHelper.FloatAction(function(arg_316_0)
					arg_312_1.dialogCg_.alpha = arg_316_0
				end))
				var_315_47:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_312_1.dialog_)
					var_315_47:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_312_1.duration_ = arg_312_1.duration_ + 0.3

				SetActive(arg_312_1.leftNameGo_, false)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_312_1.iconTrs_.gameObject, false)
				arg_312_1.callingController_:SetSelectedState("normal")

				local var_315_48 = arg_312_1:GetWordFromCfg(321091074)
				local var_315_49 = arg_312_1:FormatText(var_315_48.content)

				arg_312_1.text_.text = var_315_49

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_50 = 57
				local var_315_51 = utf8.len(var_315_49)
				local var_315_52 = var_315_50 <= 0 and var_315_46 or var_315_46 * (var_315_51 / var_315_50)

				if var_315_52 > 0 and var_315_46 < var_315_52 then
					arg_312_1.talkMaxDuration = var_315_52
					var_315_45 = var_315_45 + 0.3

					if var_315_52 + var_315_45 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_52 + var_315_45
					end
				end

				arg_312_1.text_.text = var_315_49
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)
				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_53 = var_315_45 + 0.3
			local var_315_54 = math.max(var_315_46, arg_312_1.talkMaxDuration)

			if var_315_53 <= arg_312_1.time_ and arg_312_1.time_ < var_315_53 + var_315_54 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - var_315_53) / var_315_54

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= var_315_53 + var_315_54 and arg_312_1.time_ < var_315_53 + var_315_54 + arg_315_0 then
				arg_312_1.typewritter.percent = 1

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(true)
			end
		end

		arg_312_1.nodeConfigList_ = {
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

		arg_312_1:InitPlayNodeList()
	end,
	Play321091075 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 321091075
		arg_318_1.duration_ = 5

		SetActive(arg_318_1.tipsGo_, false)

		function arg_318_1.onSingleLineFinish_()
			arg_318_1.onSingleLineUpdate_ = nil
			arg_318_1.onSingleLineFinish_ = nil
			arg_318_1.state_ = "waiting"
		end

		function arg_318_1.playNext_(arg_320_0)
			if arg_320_0 == 1 then
				arg_318_0:Play321091076(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			local var_321_0 = manager.ui.mainCamera.transform
			local var_321_1 = 0

			if var_321_1 < arg_318_1.time_ and arg_318_1.time_ <= var_321_1 + arg_321_0 then
				local var_321_2 = arg_318_1.var_.effect987

				if var_321_2 then
					Object.Destroy(var_321_2)

					arg_318_1.var_.effect987 = nil
				end
			end

			local var_321_3 = 0
			local var_321_4 = 1.4

			if var_321_3 < arg_318_1.time_ and arg_318_1.time_ <= var_321_3 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, false)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_318_1.iconTrs_.gameObject, false)
				arg_318_1.callingController_:SetSelectedState("normal")

				local var_321_5 = arg_318_1:GetWordFromCfg(321091075)
				local var_321_6 = arg_318_1:FormatText(var_321_5.content)

				arg_318_1.text_.text = var_321_6

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_7 = 56
				local var_321_8 = utf8.len(var_321_6)
				local var_321_9 = var_321_7 <= 0 and var_321_4 or var_321_4 * (var_321_8 / var_321_7)

				if var_321_9 > 0 and var_321_4 < var_321_9 then
					arg_318_1.talkMaxDuration = var_321_9

					if var_321_9 + var_321_3 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_9 + var_321_3
					end
				end

				arg_318_1.text_.text = var_321_6
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)
				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_10 = math.max(var_321_4, arg_318_1.talkMaxDuration)

			if var_321_3 <= arg_318_1.time_ and arg_318_1.time_ < var_321_3 + var_321_10 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - var_321_3) / var_321_10

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= var_321_3 + var_321_10 and arg_318_1.time_ < var_321_3 + var_321_10 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {}

		arg_318_1:InitPlayNodeList()
	end,
	Play321091076 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 321091076
		arg_322_1.duration_ = 5

		SetActive(arg_322_1.tipsGo_, false)

		function arg_322_1.onSingleLineFinish_()
			arg_322_1.onSingleLineUpdate_ = nil
			arg_322_1.onSingleLineFinish_ = nil
			arg_322_1.state_ = "waiting"
		end

		function arg_322_1.playNext_(arg_324_0)
			if arg_324_0 == 1 then
				arg_322_0:Play321091077(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			local var_325_0 = 0.05
			local var_325_1 = 1

			if var_325_0 < arg_322_1.time_ and arg_322_1.time_ <= var_325_0 + arg_325_0 then
				local var_325_2 = "play"
				local var_325_3 = "effect"

				arg_322_1:AudioAction(var_325_2, var_325_3, "se_story_140", "se_story_140_baqin_summon", "")
			end

			local var_325_4 = 0
			local var_325_5 = 0.825

			if var_325_4 < arg_322_1.time_ and arg_322_1.time_ <= var_325_4 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0
				arg_322_1.dialogCg_.alpha = 1

				arg_322_1.dialog_:SetActive(true)
				SetActive(arg_322_1.leftNameGo_, false)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_322_1.iconTrs_.gameObject, false)
				arg_322_1.callingController_:SetSelectedState("normal")

				local var_325_6 = arg_322_1:GetWordFromCfg(321091076)
				local var_325_7 = arg_322_1:FormatText(var_325_6.content)

				arg_322_1.text_.text = var_325_7

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_8 = 33
				local var_325_9 = utf8.len(var_325_7)
				local var_325_10 = var_325_8 <= 0 and var_325_5 or var_325_5 * (var_325_9 / var_325_8)

				if var_325_10 > 0 and var_325_5 < var_325_10 then
					arg_322_1.talkMaxDuration = var_325_10

					if var_325_10 + var_325_4 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_10 + var_325_4
					end
				end

				arg_322_1.text_.text = var_325_7
				arg_322_1.typewritter.percent = 0

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(false)
				arg_322_1:RecordContent(arg_322_1.text_.text)
			end

			local var_325_11 = math.max(var_325_5, arg_322_1.talkMaxDuration)

			if var_325_4 <= arg_322_1.time_ and arg_322_1.time_ < var_325_4 + var_325_11 then
				arg_322_1.typewritter.percent = (arg_322_1.time_ - var_325_4) / var_325_11

				arg_322_1.typewritter:SetDirty()
			end

			if arg_322_1.time_ >= var_325_4 + var_325_11 and arg_322_1.time_ < var_325_4 + var_325_11 + arg_325_0 then
				arg_322_1.typewritter.percent = 1

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(true)
			end
		end

		arg_322_1.nodeConfigList_ = {}

		arg_322_1:InitPlayNodeList()
	end,
	Play321091077 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 321091077
		arg_326_1.duration_ = 10.83

		local var_326_0 = {
			zh = 5.566,
			ja = 10.833
		}
		local var_326_1 = manager.audio:GetLocalizationFlag()

		if var_326_0[var_326_1] ~= nil then
			arg_326_1.duration_ = var_326_0[var_326_1]
		end

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play321091078(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			local var_329_0 = "10130ui_story"

			if arg_326_1.actors_[var_329_0] == nil then
				local var_329_1 = Asset.Load("Char/" .. "10130ui_story")

				if not isNil(var_329_1) then
					local var_329_2 = Object.Instantiate(Asset.Load("Char/" .. "10130ui_story"), arg_326_1.stage_.transform)

					var_329_2.name = var_329_0
					var_329_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_326_1.actors_[var_329_0] = var_329_2

					local var_329_3 = var_329_2:GetComponentInChildren(typeof(CharacterEffect))

					var_329_3.enabled = true

					local var_329_4 = GameObjectTools.GetOrAddComponent(var_329_2, typeof(DynamicBoneHelper))

					if var_329_4 then
						var_329_4:EnableDynamicBone(false)
					end

					arg_326_1:ShowWeapon(var_329_3.transform, false)

					arg_326_1.var_[var_329_0 .. "Animator"] = var_329_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_326_1.var_[var_329_0 .. "Animator"].applyRootMotion = true
					arg_326_1.var_[var_329_0 .. "LipSync"] = var_329_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_329_5 = arg_326_1.actors_["10130ui_story"]
			local var_329_6 = 0

			if var_329_6 < arg_326_1.time_ and arg_326_1.time_ <= var_329_6 + arg_329_0 and not isNil(var_329_5) and arg_326_1.var_.characterEffect10130ui_story == nil then
				arg_326_1.var_.characterEffect10130ui_story = var_329_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_329_7 = 0.200000002980232

			if var_329_6 <= arg_326_1.time_ and arg_326_1.time_ < var_329_6 + var_329_7 and not isNil(var_329_5) then
				local var_329_8 = (arg_326_1.time_ - var_329_6) / var_329_7

				if arg_326_1.var_.characterEffect10130ui_story and not isNil(var_329_5) then
					arg_326_1.var_.characterEffect10130ui_story.fillFlat = false
				end
			end

			if arg_326_1.time_ >= var_329_6 + var_329_7 and arg_326_1.time_ < var_329_6 + var_329_7 + arg_329_0 and not isNil(var_329_5) and arg_326_1.var_.characterEffect10130ui_story then
				arg_326_1.var_.characterEffect10130ui_story.fillFlat = false
			end

			local var_329_9 = arg_326_1.actors_["10130ui_story"].transform
			local var_329_10 = 0

			if var_329_10 < arg_326_1.time_ and arg_326_1.time_ <= var_329_10 + arg_329_0 then
				arg_326_1.var_.moveOldPos10130ui_story = var_329_9.localPosition
			end

			local var_329_11 = 0.001

			if var_329_10 <= arg_326_1.time_ and arg_326_1.time_ < var_329_10 + var_329_11 then
				local var_329_12 = (arg_326_1.time_ - var_329_10) / var_329_11
				local var_329_13 = Vector3.New(-0.03, -1.02, -5.81)

				var_329_9.localPosition = Vector3.Lerp(arg_326_1.var_.moveOldPos10130ui_story, var_329_13, var_329_12)

				local var_329_14 = manager.ui.mainCamera.transform.position - var_329_9.position

				var_329_9.forward = Vector3.New(var_329_14.x, var_329_14.y, var_329_14.z)

				local var_329_15 = var_329_9.localEulerAngles

				var_329_15.z = 0
				var_329_15.x = 0
				var_329_9.localEulerAngles = var_329_15
			end

			if arg_326_1.time_ >= var_329_10 + var_329_11 and arg_326_1.time_ < var_329_10 + var_329_11 + arg_329_0 then
				var_329_9.localPosition = Vector3.New(-0.03, -1.02, -5.81)

				local var_329_16 = manager.ui.mainCamera.transform.position - var_329_9.position

				var_329_9.forward = Vector3.New(var_329_16.x, var_329_16.y, var_329_16.z)

				local var_329_17 = var_329_9.localEulerAngles

				var_329_17.z = 0
				var_329_17.x = 0
				var_329_9.localEulerAngles = var_329_17
			end

			local var_329_18 = 0

			if var_329_18 < arg_326_1.time_ and arg_326_1.time_ <= var_329_18 + arg_329_0 then
				arg_326_1:PlayTimeline("10130ui_story", "StoryTimeline/CharAction/story10130/story10130action/10130action1_1")
			end

			local var_329_19 = 0
			local var_329_20 = 0.425

			if var_329_19 < arg_326_1.time_ and arg_326_1.time_ <= var_329_19 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0
				arg_326_1.dialogCg_.alpha = 1

				arg_326_1.dialog_:SetActive(true)
				SetActive(arg_326_1.leftNameGo_, true)

				local var_329_21 = arg_326_1:FormatText(StoryNameCfg[1049].name)

				arg_326_1.leftNameTxt_.text = var_329_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_326_1.leftNameTxt_.transform)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1.leftNameTxt_.text)
				SetActive(arg_326_1.iconTrs_.gameObject, false)
				arg_326_1.callingController_:SetSelectedState("normal")

				local var_329_22 = arg_326_1:GetWordFromCfg(321091077)
				local var_329_23 = arg_326_1:FormatText(var_329_22.content)

				arg_326_1.text_.text = var_329_23

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_24 = 17
				local var_329_25 = utf8.len(var_329_23)
				local var_329_26 = var_329_24 <= 0 and var_329_20 or var_329_20 * (var_329_25 / var_329_24)

				if var_329_26 > 0 and var_329_20 < var_329_26 then
					arg_326_1.talkMaxDuration = var_329_26

					if var_329_26 + var_329_19 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_26 + var_329_19
					end
				end

				arg_326_1.text_.text = var_329_23
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091077", "story_v_out_321091.awb") ~= 0 then
					local var_329_27 = manager.audio:GetVoiceLength("story_v_out_321091", "321091077", "story_v_out_321091.awb") / 1000

					if var_329_27 + var_329_19 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_27 + var_329_19
					end

					if var_329_22.prefab_name ~= "" and arg_326_1.actors_[var_329_22.prefab_name] ~= nil then
						local var_329_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_326_1.actors_[var_329_22.prefab_name].transform, "story_v_out_321091", "321091077", "story_v_out_321091.awb")

						arg_326_1:RecordAudio("321091077", var_329_28)
						arg_326_1:RecordAudio("321091077", var_329_28)
					else
						arg_326_1:AudioAction("play", "voice", "story_v_out_321091", "321091077", "story_v_out_321091.awb")
					end

					arg_326_1:RecordHistoryTalkVoice("story_v_out_321091", "321091077", "story_v_out_321091.awb")
				end

				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_29 = math.max(var_329_20, arg_326_1.talkMaxDuration)

			if var_329_19 <= arg_326_1.time_ and arg_326_1.time_ < var_329_19 + var_329_29 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - var_329_19) / var_329_29

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= var_329_19 + var_329_29 and arg_326_1.time_ < var_329_19 + var_329_29 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10130ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_326_1:InitPlayNodeList()
	end,
	Play321091078 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 321091078
		arg_330_1.duration_ = 6.07

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play321091079(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			local var_333_0 = arg_330_1.actors_["10130ui_story"]
			local var_333_1 = 0

			if var_333_1 < arg_330_1.time_ and arg_330_1.time_ <= var_333_1 + arg_333_0 and not isNil(var_333_0) and arg_330_1.var_.characterEffect10130ui_story == nil then
				arg_330_1.var_.characterEffect10130ui_story = var_333_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_333_2 = 0.200000002980232

			if var_333_1 <= arg_330_1.time_ and arg_330_1.time_ < var_333_1 + var_333_2 and not isNil(var_333_0) then
				local var_333_3 = (arg_330_1.time_ - var_333_1) / var_333_2

				if arg_330_1.var_.characterEffect10130ui_story and not isNil(var_333_0) then
					local var_333_4 = Mathf.Lerp(0, 0.5, var_333_3)

					arg_330_1.var_.characterEffect10130ui_story.fillFlat = true
					arg_330_1.var_.characterEffect10130ui_story.fillRatio = var_333_4
				end
			end

			if arg_330_1.time_ >= var_333_1 + var_333_2 and arg_330_1.time_ < var_333_1 + var_333_2 + arg_333_0 and not isNil(var_333_0) and arg_330_1.var_.characterEffect10130ui_story then
				local var_333_5 = 0.5

				arg_330_1.var_.characterEffect10130ui_story.fillFlat = true
				arg_330_1.var_.characterEffect10130ui_story.fillRatio = var_333_5
			end

			local var_333_6 = manager.ui.mainCamera.transform
			local var_333_7 = 0

			if var_333_7 < arg_330_1.time_ and arg_330_1.time_ <= var_333_7 + arg_333_0 then
				arg_330_1.var_.shakeOldPos = var_333_6.localPosition
			end

			local var_333_8 = 0.833333333333333

			if var_333_7 <= arg_330_1.time_ and arg_330_1.time_ < var_333_7 + var_333_8 then
				local var_333_9 = (arg_330_1.time_ - var_333_7) / 0.066
				local var_333_10, var_333_11 = math.modf(var_333_9)

				var_333_6.localPosition = Vector3.New(var_333_11 * 0.13, var_333_11 * 0.13, var_333_11 * 0.13) + arg_330_1.var_.shakeOldPos
			end

			if arg_330_1.time_ >= var_333_7 + var_333_8 and arg_330_1.time_ < var_333_7 + var_333_8 + arg_333_0 then
				var_333_6.localPosition = arg_330_1.var_.shakeOldPos
			end

			local var_333_12 = manager.ui.mainCamera.transform
			local var_333_13 = 0

			if var_333_13 < arg_330_1.time_ and arg_330_1.time_ <= var_333_13 + arg_333_0 then
				local var_333_14 = arg_330_1.var_.effect112
				local var_333_15
				local var_333_16 = var_333_12

				if not var_333_14 then
					var_333_14 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_ripple"), var_333_16)
					var_333_14.name = "112"
					arg_330_1.var_.effect112 = var_333_14
				else
					var_333_14.transform:SetParent(var_333_16)
				end

				var_333_14.transform.localPosition = Vector3.New(-0.76, -0.06, -0.86)
				var_333_14.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_333_17 = manager.ui.mainCameraCom_
				local var_333_18 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_333_17.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_333_19 = var_333_14.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_333_20 = 15
				local var_333_21 = 2 * var_333_20 * Mathf.Tan(var_333_17.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_333_17.aspect
				local var_333_22 = 1
				local var_333_23 = 1.7777777777777777

				if var_333_23 < var_333_17.aspect then
					var_333_22 = var_333_21 / (2 * var_333_20 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_333_23)
				end

				for iter_333_0, iter_333_1 in ipairs(var_333_19) do
					local var_333_24 = iter_333_1.transform.localScale

					iter_333_1.transform.localScale = Vector3.New(var_333_24.x / var_333_18 * var_333_22, var_333_24.y / var_333_18, var_333_24.z)
				end
			end

			local var_333_25 = manager.ui.mainCamera.transform
			local var_333_26 = 0.133333333333333

			if var_333_26 < arg_330_1.time_ and arg_330_1.time_ <= var_333_26 + arg_333_0 then
				local var_333_27 = arg_330_1.var_.effect115
				local var_333_28
				local var_333_29 = var_333_25

				if not var_333_27 then
					var_333_27 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_ripple"), var_333_29)
					var_333_27.name = "115"
					arg_330_1.var_.effect115 = var_333_27
				else
					var_333_27.transform:SetParent(var_333_29)
				end

				var_333_27.transform.localPosition = Vector3.New(0.06, 0, -0.86)
				var_333_27.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_333_30 = manager.ui.mainCameraCom_
				local var_333_31 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_333_30.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_333_32 = var_333_27.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_333_33 = 15
				local var_333_34 = 2 * var_333_33 * Mathf.Tan(var_333_30.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_333_30.aspect
				local var_333_35 = 1
				local var_333_36 = 1.7777777777777777

				if var_333_36 < var_333_30.aspect then
					var_333_35 = var_333_34 / (2 * var_333_33 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_333_36)
				end

				for iter_333_2, iter_333_3 in ipairs(var_333_32) do
					local var_333_37 = iter_333_3.transform.localScale

					iter_333_3.transform.localScale = Vector3.New(var_333_37.x / var_333_31 * var_333_35, var_333_37.y / var_333_31, var_333_37.z)
				end
			end

			local var_333_38 = manager.ui.mainCamera.transform
			local var_333_39 = 0.333333333333333

			if var_333_39 < arg_330_1.time_ and arg_330_1.time_ <= var_333_39 + arg_333_0 then
				local var_333_40 = arg_330_1.var_.effect117
				local var_333_41
				local var_333_42 = var_333_38

				if not var_333_40 then
					var_333_40 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_ripple"), var_333_42)
					var_333_40.name = "117"
					arg_330_1.var_.effect117 = var_333_40
				else
					var_333_40.transform:SetParent(var_333_42)
				end

				var_333_40.transform.localPosition = Vector3.New(1.21, 0, -0.86)
				var_333_40.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_333_43 = manager.ui.mainCameraCom_
				local var_333_44 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_333_43.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_333_45 = var_333_40.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_333_46 = 15
				local var_333_47 = 2 * var_333_46 * Mathf.Tan(var_333_43.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_333_43.aspect
				local var_333_48 = 1
				local var_333_49 = 1.7777777777777777

				if var_333_49 < var_333_43.aspect then
					var_333_48 = var_333_47 / (2 * var_333_46 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_333_49)
				end

				for iter_333_4, iter_333_5 in ipairs(var_333_45) do
					local var_333_50 = iter_333_5.transform.localScale

					iter_333_5.transform.localScale = Vector3.New(var_333_50.x / var_333_44 * var_333_48, var_333_50.y / var_333_44, var_333_50.z)
				end
			end

			local var_333_51 = 0

			if var_333_51 < arg_330_1.time_ and arg_330_1.time_ <= var_333_51 + arg_333_0 then
				arg_330_1.allBtn_.enabled = false
			end

			local var_333_52 = 1.63333333333333

			if arg_330_1.time_ >= var_333_51 + var_333_52 and arg_330_1.time_ < var_333_51 + var_333_52 + arg_333_0 then
				arg_330_1.allBtn_.enabled = true
			end

			local var_333_53 = 0.05
			local var_333_54 = 1

			if var_333_53 < arg_330_1.time_ and arg_330_1.time_ <= var_333_53 + arg_333_0 then
				local var_333_55 = "play"
				local var_333_56 = "effect"

				arg_330_1:AudioAction(var_333_55, var_333_56, "se_story_140", "se_story_140_baqin_skill02", "")
			end

			local var_333_57 = arg_330_1.actors_["10130ui_story"].transform
			local var_333_58 = 0

			if var_333_58 < arg_330_1.time_ and arg_330_1.time_ <= var_333_58 + arg_333_0 then
				arg_330_1.var_.moveOldPos10130ui_story = var_333_57.localPosition
			end

			local var_333_59 = 0.001

			if var_333_58 <= arg_330_1.time_ and arg_330_1.time_ < var_333_58 + var_333_59 then
				local var_333_60 = (arg_330_1.time_ - var_333_58) / var_333_59
				local var_333_61 = Vector3.New(0, 100, 0)

				var_333_57.localPosition = Vector3.Lerp(arg_330_1.var_.moveOldPos10130ui_story, var_333_61, var_333_60)

				local var_333_62 = manager.ui.mainCamera.transform.position - var_333_57.position

				var_333_57.forward = Vector3.New(var_333_62.x, var_333_62.y, var_333_62.z)

				local var_333_63 = var_333_57.localEulerAngles

				var_333_63.z = 0
				var_333_63.x = 0
				var_333_57.localEulerAngles = var_333_63
			end

			if arg_330_1.time_ >= var_333_58 + var_333_59 and arg_330_1.time_ < var_333_58 + var_333_59 + arg_333_0 then
				var_333_57.localPosition = Vector3.New(0, 100, 0)

				local var_333_64 = manager.ui.mainCamera.transform.position - var_333_57.position

				var_333_57.forward = Vector3.New(var_333_64.x, var_333_64.y, var_333_64.z)

				local var_333_65 = var_333_57.localEulerAngles

				var_333_65.z = 0
				var_333_65.x = 0
				var_333_57.localEulerAngles = var_333_65
			end

			if arg_330_1.frameCnt_ <= 1 then
				arg_330_1.dialog_:SetActive(false)
			end

			local var_333_66 = 1.06666666666667
			local var_333_67 = 1.225

			if var_333_66 < arg_330_1.time_ and arg_330_1.time_ <= var_333_66 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0

				arg_330_1.dialog_:SetActive(true)

				arg_330_1.dialogCg_.alpha = 0

				local var_333_68 = LeanTween.value(arg_330_1.dialog_, 0, 1, 0.3)

				var_333_68:setOnUpdate(LuaHelper.FloatAction(function(arg_334_0)
					arg_330_1.dialogCg_.alpha = arg_334_0
				end))
				var_333_68:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_330_1.dialog_)
					var_333_68:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_330_1.duration_ = arg_330_1.duration_ + 0.3

				SetActive(arg_330_1.leftNameGo_, false)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_330_1.iconTrs_.gameObject, false)
				arg_330_1.callingController_:SetSelectedState("normal")

				local var_333_69 = arg_330_1:GetWordFromCfg(321091078)
				local var_333_70 = arg_330_1:FormatText(var_333_69.content)

				arg_330_1.text_.text = var_333_70

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_71 = 49
				local var_333_72 = utf8.len(var_333_70)
				local var_333_73 = var_333_71 <= 0 and var_333_67 or var_333_67 * (var_333_72 / var_333_71)

				if var_333_73 > 0 and var_333_67 < var_333_73 then
					arg_330_1.talkMaxDuration = var_333_73
					var_333_66 = var_333_66 + 0.3

					if var_333_73 + var_333_66 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_73 + var_333_66
					end
				end

				arg_330_1.text_.text = var_333_70
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)
				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_74 = var_333_66 + 0.3
			local var_333_75 = math.max(var_333_67, arg_330_1.talkMaxDuration)

			if var_333_74 <= arg_330_1.time_ and arg_330_1.time_ < var_333_74 + var_333_75 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - var_333_74) / var_333_75

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= var_333_74 + var_333_75 and arg_330_1.time_ < var_333_74 + var_333_75 + arg_333_0 then
				arg_330_1.typewritter.percent = 1

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(true)
			end
		end

		arg_330_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10130ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_330_1:InitPlayNodeList()
	end,
	Play321091079 = function(arg_336_0, arg_336_1)
		arg_336_1.time_ = 0
		arg_336_1.frameCnt_ = 0
		arg_336_1.state_ = "playing"
		arg_336_1.curTalkId_ = 321091079
		arg_336_1.duration_ = 5.33

		SetActive(arg_336_1.tipsGo_, false)

		function arg_336_1.onSingleLineFinish_()
			arg_336_1.onSingleLineUpdate_ = nil
			arg_336_1.onSingleLineFinish_ = nil
			arg_336_1.state_ = "waiting"
		end

		function arg_336_1.playNext_(arg_338_0)
			if arg_338_0 == 1 then
				arg_336_0:Play321091080(arg_336_1)
			end
		end

		function arg_336_1.onSingleLineUpdate_(arg_339_0)
			local var_339_0 = manager.ui.mainCamera.transform
			local var_339_1 = 0

			if var_339_1 < arg_336_1.time_ and arg_336_1.time_ <= var_339_1 + arg_339_0 then
				local var_339_2 = arg_336_1.var_.effect112

				if var_339_2 then
					Object.Destroy(var_339_2)

					arg_336_1.var_.effect112 = nil
				end
			end

			local var_339_3 = manager.ui.mainCamera.transform
			local var_339_4 = 0

			if var_339_4 < arg_336_1.time_ and arg_336_1.time_ <= var_339_4 + arg_339_0 then
				local var_339_5 = arg_336_1.var_.effect115

				if var_339_5 then
					Object.Destroy(var_339_5)

					arg_336_1.var_.effect115 = nil
				end
			end

			local var_339_6 = manager.ui.mainCamera.transform
			local var_339_7 = 0.333333333333333

			if var_339_7 < arg_336_1.time_ and arg_336_1.time_ <= var_339_7 + arg_339_0 then
				local var_339_8 = arg_336_1.var_.effect117

				if var_339_8 then
					Object.Destroy(var_339_8)

					arg_336_1.var_.effect117 = nil
				end
			end

			local var_339_9 = manager.ui.mainCamera.transform
			local var_339_10 = 0.133333333333333

			if var_339_10 < arg_336_1.time_ and arg_336_1.time_ <= var_339_10 + arg_339_0 then
				local var_339_11 = arg_336_1.var_.effect744
				local var_339_12
				local var_339_13 = var_339_9

				if not var_339_11 then
					var_339_11 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), var_339_13)
					var_339_11.name = "744"
					arg_336_1.var_.effect744 = var_339_11
				else
					var_339_11.transform:SetParent(var_339_13)
				end

				var_339_11.transform.localPosition = Vector3.New(0, -0.28, 0)
				var_339_11.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_339_14 = manager.ui.mainCameraCom_
				local var_339_15 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_339_14.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_339_16 = var_339_11.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_339_17 = 15
				local var_339_18 = 2 * var_339_17 * Mathf.Tan(var_339_14.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_339_14.aspect
				local var_339_19 = 1
				local var_339_20 = 1.7777777777777777

				if var_339_20 < var_339_14.aspect then
					var_339_19 = var_339_18 / (2 * var_339_17 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_339_20)
				end

				for iter_339_0, iter_339_1 in ipairs(var_339_16) do
					local var_339_21 = iter_339_1.transform.localScale

					iter_339_1.transform.localScale = Vector3.New(var_339_21.x / var_339_15 * var_339_19, var_339_21.y / var_339_15, var_339_21.z)
				end
			end

			local var_339_22 = 0

			if var_339_22 < arg_336_1.time_ and arg_336_1.time_ <= var_339_22 + arg_339_0 then
				arg_336_1.allBtn_.enabled = false
			end

			local var_339_23 = 0.433333333333333

			if arg_336_1.time_ >= var_339_22 + var_339_23 and arg_336_1.time_ < var_339_22 + var_339_23 + arg_339_0 then
				arg_336_1.allBtn_.enabled = true
			end

			local var_339_24 = 0.133333333333333
			local var_339_25 = 1

			if var_339_24 < arg_336_1.time_ and arg_336_1.time_ <= var_339_24 + arg_339_0 then
				local var_339_26 = "play"
				local var_339_27 = "effect"

				arg_336_1:AudioAction(var_339_26, var_339_27, "se_story_1310", "se_story_1310_gun02", "")
			end

			if arg_336_1.frameCnt_ <= 1 then
				arg_336_1.dialog_:SetActive(false)
			end

			local var_339_28 = 0.333333333333333
			local var_339_29 = 1.55

			if var_339_28 < arg_336_1.time_ and arg_336_1.time_ <= var_339_28 + arg_339_0 then
				arg_336_1.talkMaxDuration = 0

				arg_336_1.dialog_:SetActive(true)

				arg_336_1.dialogCg_.alpha = 0

				local var_339_30 = LeanTween.value(arg_336_1.dialog_, 0, 1, 0.3)

				var_339_30:setOnUpdate(LuaHelper.FloatAction(function(arg_340_0)
					arg_336_1.dialogCg_.alpha = arg_340_0
				end))
				var_339_30:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_336_1.dialog_)
					var_339_30:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_336_1.duration_ = arg_336_1.duration_ + 0.3

				SetActive(arg_336_1.leftNameGo_, false)

				arg_336_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_336_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_336_1:RecordName(arg_336_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_336_1.iconTrs_.gameObject, false)
				arg_336_1.callingController_:SetSelectedState("normal")

				local var_339_31 = arg_336_1:GetWordFromCfg(321091079)
				local var_339_32 = arg_336_1:FormatText(var_339_31.content)

				arg_336_1.text_.text = var_339_32

				LuaForUtil.ClearLinePrefixSymbol(arg_336_1.text_)

				local var_339_33 = 62
				local var_339_34 = utf8.len(var_339_32)
				local var_339_35 = var_339_33 <= 0 and var_339_29 or var_339_29 * (var_339_34 / var_339_33)

				if var_339_35 > 0 and var_339_29 < var_339_35 then
					arg_336_1.talkMaxDuration = var_339_35
					var_339_28 = var_339_28 + 0.3

					if var_339_35 + var_339_28 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_35 + var_339_28
					end
				end

				arg_336_1.text_.text = var_339_32
				arg_336_1.typewritter.percent = 0

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(false)
				arg_336_1:RecordContent(arg_336_1.text_.text)
			end

			local var_339_36 = var_339_28 + 0.3
			local var_339_37 = math.max(var_339_29, arg_336_1.talkMaxDuration)

			if var_339_36 <= arg_336_1.time_ and arg_336_1.time_ < var_339_36 + var_339_37 then
				arg_336_1.typewritter.percent = (arg_336_1.time_ - var_339_36) / var_339_37

				arg_336_1.typewritter:SetDirty()
			end

			if arg_336_1.time_ >= var_339_36 + var_339_37 and arg_336_1.time_ < var_339_36 + var_339_37 + arg_339_0 then
				arg_336_1.typewritter.percent = 1

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(true)
			end
		end

		arg_336_1.nodeConfigList_ = {}

		arg_336_1:InitPlayNodeList()
	end,
	Play321091080 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 321091080
		arg_342_1.duration_ = 2.3

		local var_342_0 = {
			zh = 1.033,
			ja = 2.3
		}
		local var_342_1 = manager.audio:GetLocalizationFlag()

		if var_342_0[var_342_1] ~= nil then
			arg_342_1.duration_ = var_342_0[var_342_1]
		end

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"
		end

		function arg_342_1.playNext_(arg_344_0)
			if arg_344_0 == 1 then
				arg_342_0:Play321091081(arg_342_1)
			end
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			local var_345_0 = arg_342_1.actors_["10130ui_story"]
			local var_345_1 = 0

			if var_345_1 < arg_342_1.time_ and arg_342_1.time_ <= var_345_1 + arg_345_0 and not isNil(var_345_0) and arg_342_1.var_.characterEffect10130ui_story == nil then
				arg_342_1.var_.characterEffect10130ui_story = var_345_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_345_2 = 0.200000002980232

			if var_345_1 <= arg_342_1.time_ and arg_342_1.time_ < var_345_1 + var_345_2 and not isNil(var_345_0) then
				local var_345_3 = (arg_342_1.time_ - var_345_1) / var_345_2

				if arg_342_1.var_.characterEffect10130ui_story and not isNil(var_345_0) then
					arg_342_1.var_.characterEffect10130ui_story.fillFlat = false
				end
			end

			if arg_342_1.time_ >= var_345_1 + var_345_2 and arg_342_1.time_ < var_345_1 + var_345_2 + arg_345_0 and not isNil(var_345_0) and arg_342_1.var_.characterEffect10130ui_story then
				arg_342_1.var_.characterEffect10130ui_story.fillFlat = false
			end

			local var_345_4 = manager.ui.mainCamera.transform
			local var_345_5 = 0

			if var_345_5 < arg_342_1.time_ and arg_342_1.time_ <= var_345_5 + arg_345_0 then
				local var_345_6 = arg_342_1.var_.effect744

				if var_345_6 then
					Object.Destroy(var_345_6)

					arg_342_1.var_.effect744 = nil
				end
			end

			local var_345_7 = 0
			local var_345_8 = 0.05

			if var_345_7 < arg_342_1.time_ and arg_342_1.time_ <= var_345_7 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0
				arg_342_1.dialogCg_.alpha = 1

				arg_342_1.dialog_:SetActive(true)
				SetActive(arg_342_1.leftNameGo_, true)

				local var_345_9 = arg_342_1:FormatText(StoryNameCfg[1049].name)

				arg_342_1.leftNameTxt_.text = var_345_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_342_1.leftNameTxt_.transform)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1.leftNameTxt_.text)
				SetActive(arg_342_1.iconTrs_.gameObject, true)
				arg_342_1.iconController_:SetSelectedState("hero")

				arg_342_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10130")

				arg_342_1.callingController_:SetSelectedState("normal")

				arg_342_1.keyicon_.color = Color.New(1, 1, 1)
				arg_342_1.icon_.color = Color.New(1, 1, 1)

				local var_345_10 = arg_342_1:GetWordFromCfg(321091080)
				local var_345_11 = arg_342_1:FormatText(var_345_10.content)

				arg_342_1.text_.text = var_345_11

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_12 = 2
				local var_345_13 = utf8.len(var_345_11)
				local var_345_14 = var_345_12 <= 0 and var_345_8 or var_345_8 * (var_345_13 / var_345_12)

				if var_345_14 > 0 and var_345_8 < var_345_14 then
					arg_342_1.talkMaxDuration = var_345_14

					if var_345_14 + var_345_7 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_14 + var_345_7
					end
				end

				arg_342_1.text_.text = var_345_11
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091080", "story_v_out_321091.awb") ~= 0 then
					local var_345_15 = manager.audio:GetVoiceLength("story_v_out_321091", "321091080", "story_v_out_321091.awb") / 1000

					if var_345_15 + var_345_7 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_15 + var_345_7
					end

					if var_345_10.prefab_name ~= "" and arg_342_1.actors_[var_345_10.prefab_name] ~= nil then
						local var_345_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_342_1.actors_[var_345_10.prefab_name].transform, "story_v_out_321091", "321091080", "story_v_out_321091.awb")

						arg_342_1:RecordAudio("321091080", var_345_16)
						arg_342_1:RecordAudio("321091080", var_345_16)
					else
						arg_342_1:AudioAction("play", "voice", "story_v_out_321091", "321091080", "story_v_out_321091.awb")
					end

					arg_342_1:RecordHistoryTalkVoice("story_v_out_321091", "321091080", "story_v_out_321091.awb")
				end

				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_17 = math.max(var_345_8, arg_342_1.talkMaxDuration)

			if var_345_7 <= arg_342_1.time_ and arg_342_1.time_ < var_345_7 + var_345_17 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - var_345_7) / var_345_17

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= var_345_7 + var_345_17 and arg_342_1.time_ < var_345_7 + var_345_17 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {}

		arg_342_1:InitPlayNodeList()
	end,
	Play321091081 = function(arg_346_0, arg_346_1)
		arg_346_1.time_ = 0
		arg_346_1.frameCnt_ = 0
		arg_346_1.state_ = "playing"
		arg_346_1.curTalkId_ = 321091081
		arg_346_1.duration_ = 5

		SetActive(arg_346_1.tipsGo_, false)

		function arg_346_1.onSingleLineFinish_()
			arg_346_1.onSingleLineUpdate_ = nil
			arg_346_1.onSingleLineFinish_ = nil
			arg_346_1.state_ = "waiting"
		end

		function arg_346_1.playNext_(arg_348_0)
			if arg_348_0 == 1 then
				arg_346_0:Play321091082(arg_346_1)
			end
		end

		function arg_346_1.onSingleLineUpdate_(arg_349_0)
			local var_349_0 = arg_346_1.actors_["10130ui_story"]
			local var_349_1 = 0

			if var_349_1 < arg_346_1.time_ and arg_346_1.time_ <= var_349_1 + arg_349_0 and not isNil(var_349_0) and arg_346_1.var_.characterEffect10130ui_story == nil then
				arg_346_1.var_.characterEffect10130ui_story = var_349_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_349_2 = 0.200000002980232

			if var_349_1 <= arg_346_1.time_ and arg_346_1.time_ < var_349_1 + var_349_2 and not isNil(var_349_0) then
				local var_349_3 = (arg_346_1.time_ - var_349_1) / var_349_2

				if arg_346_1.var_.characterEffect10130ui_story and not isNil(var_349_0) then
					local var_349_4 = Mathf.Lerp(0, 0.5, var_349_3)

					arg_346_1.var_.characterEffect10130ui_story.fillFlat = true
					arg_346_1.var_.characterEffect10130ui_story.fillRatio = var_349_4
				end
			end

			if arg_346_1.time_ >= var_349_1 + var_349_2 and arg_346_1.time_ < var_349_1 + var_349_2 + arg_349_0 and not isNil(var_349_0) and arg_346_1.var_.characterEffect10130ui_story then
				local var_349_5 = 0.5

				arg_346_1.var_.characterEffect10130ui_story.fillFlat = true
				arg_346_1.var_.characterEffect10130ui_story.fillRatio = var_349_5
			end

			local var_349_6 = 0
			local var_349_7 = 1.225

			if var_349_6 < arg_346_1.time_ and arg_346_1.time_ <= var_349_6 + arg_349_0 then
				arg_346_1.talkMaxDuration = 0
				arg_346_1.dialogCg_.alpha = 1

				arg_346_1.dialog_:SetActive(true)
				SetActive(arg_346_1.leftNameGo_, false)

				arg_346_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_346_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_346_1:RecordName(arg_346_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_346_1.iconTrs_.gameObject, false)
				arg_346_1.callingController_:SetSelectedState("normal")

				local var_349_8 = arg_346_1:GetWordFromCfg(321091081)
				local var_349_9 = arg_346_1:FormatText(var_349_8.content)

				arg_346_1.text_.text = var_349_9

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_10 = 49
				local var_349_11 = utf8.len(var_349_9)
				local var_349_12 = var_349_10 <= 0 and var_349_7 or var_349_7 * (var_349_11 / var_349_10)

				if var_349_12 > 0 and var_349_7 < var_349_12 then
					arg_346_1.talkMaxDuration = var_349_12

					if var_349_12 + var_349_6 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_12 + var_349_6
					end
				end

				arg_346_1.text_.text = var_349_9
				arg_346_1.typewritter.percent = 0

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(false)
				arg_346_1:RecordContent(arg_346_1.text_.text)
			end

			local var_349_13 = math.max(var_349_7, arg_346_1.talkMaxDuration)

			if var_349_6 <= arg_346_1.time_ and arg_346_1.time_ < var_349_6 + var_349_13 then
				arg_346_1.typewritter.percent = (arg_346_1.time_ - var_349_6) / var_349_13

				arg_346_1.typewritter:SetDirty()
			end

			if arg_346_1.time_ >= var_349_6 + var_349_13 and arg_346_1.time_ < var_349_6 + var_349_13 + arg_349_0 then
				arg_346_1.typewritter.percent = 1

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(true)
			end
		end

		arg_346_1.nodeConfigList_ = {}

		arg_346_1:InitPlayNodeList()
	end,
	Play321091082 = function(arg_350_0, arg_350_1)
		arg_350_1.time_ = 0
		arg_350_1.frameCnt_ = 0
		arg_350_1.state_ = "playing"
		arg_350_1.curTalkId_ = 321091082
		arg_350_1.duration_ = 5

		SetActive(arg_350_1.tipsGo_, false)

		function arg_350_1.onSingleLineFinish_()
			arg_350_1.onSingleLineUpdate_ = nil
			arg_350_1.onSingleLineFinish_ = nil
			arg_350_1.state_ = "waiting"
		end

		function arg_350_1.playNext_(arg_352_0)
			if arg_352_0 == 1 then
				arg_350_0:Play321091083(arg_350_1)
			end
		end

		function arg_350_1.onSingleLineUpdate_(arg_353_0)
			local var_353_0 = 0.05
			local var_353_1 = 1

			if var_353_0 < arg_350_1.time_ and arg_350_1.time_ <= var_353_0 + arg_353_0 then
				local var_353_2 = "play"
				local var_353_3 = "effect"

				arg_350_1:AudioAction(var_353_2, var_353_3, "se_story_side_1049", "se_story_side_1049_hug", "")
			end

			local var_353_4 = 0
			local var_353_5 = 1.025

			if var_353_4 < arg_350_1.time_ and arg_350_1.time_ <= var_353_4 + arg_353_0 then
				arg_350_1.talkMaxDuration = 0
				arg_350_1.dialogCg_.alpha = 1

				arg_350_1.dialog_:SetActive(true)
				SetActive(arg_350_1.leftNameGo_, false)

				arg_350_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_350_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_350_1:RecordName(arg_350_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_350_1.iconTrs_.gameObject, false)
				arg_350_1.callingController_:SetSelectedState("normal")

				local var_353_6 = arg_350_1:GetWordFromCfg(321091082)
				local var_353_7 = arg_350_1:FormatText(var_353_6.content)

				arg_350_1.text_.text = var_353_7

				LuaForUtil.ClearLinePrefixSymbol(arg_350_1.text_)

				local var_353_8 = 41
				local var_353_9 = utf8.len(var_353_7)
				local var_353_10 = var_353_8 <= 0 and var_353_5 or var_353_5 * (var_353_9 / var_353_8)

				if var_353_10 > 0 and var_353_5 < var_353_10 then
					arg_350_1.talkMaxDuration = var_353_10

					if var_353_10 + var_353_4 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_10 + var_353_4
					end
				end

				arg_350_1.text_.text = var_353_7
				arg_350_1.typewritter.percent = 0

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(false)
				arg_350_1:RecordContent(arg_350_1.text_.text)
			end

			local var_353_11 = math.max(var_353_5, arg_350_1.talkMaxDuration)

			if var_353_4 <= arg_350_1.time_ and arg_350_1.time_ < var_353_4 + var_353_11 then
				arg_350_1.typewritter.percent = (arg_350_1.time_ - var_353_4) / var_353_11

				arg_350_1.typewritter:SetDirty()
			end

			if arg_350_1.time_ >= var_353_4 + var_353_11 and arg_350_1.time_ < var_353_4 + var_353_11 + arg_353_0 then
				arg_350_1.typewritter.percent = 1

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(true)
			end
		end

		arg_350_1.nodeConfigList_ = {}

		arg_350_1:InitPlayNodeList()
	end,
	Play321091083 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 321091083
		arg_354_1.duration_ = 4.9

		local var_354_0 = {
			zh = 3.733,
			ja = 4.9
		}
		local var_354_1 = manager.audio:GetLocalizationFlag()

		if var_354_0[var_354_1] ~= nil then
			arg_354_1.duration_ = var_354_0[var_354_1]
		end

		SetActive(arg_354_1.tipsGo_, false)

		function arg_354_1.onSingleLineFinish_()
			arg_354_1.onSingleLineUpdate_ = nil
			arg_354_1.onSingleLineFinish_ = nil
			arg_354_1.state_ = "waiting"
			arg_354_1.auto_ = false
		end

		function arg_354_1.playNext_(arg_356_0)
			arg_354_1.onStoryFinished_()
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			local var_357_0 = arg_354_1.actors_["10104ui_story"]
			local var_357_1 = 0

			if var_357_1 < arg_354_1.time_ and arg_354_1.time_ <= var_357_1 + arg_357_0 and not isNil(var_357_0) and arg_354_1.var_.characterEffect10104ui_story == nil then
				arg_354_1.var_.characterEffect10104ui_story = var_357_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_357_2 = 0.200000002980232

			if var_357_1 <= arg_354_1.time_ and arg_354_1.time_ < var_357_1 + var_357_2 and not isNil(var_357_0) then
				local var_357_3 = (arg_354_1.time_ - var_357_1) / var_357_2

				if arg_354_1.var_.characterEffect10104ui_story and not isNil(var_357_0) then
					arg_354_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_354_1.time_ >= var_357_1 + var_357_2 and arg_354_1.time_ < var_357_1 + var_357_2 + arg_357_0 and not isNil(var_357_0) and arg_354_1.var_.characterEffect10104ui_story then
				arg_354_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_357_4 = arg_354_1.actors_["10104ui_story"]
			local var_357_5 = 0

			if var_357_5 < arg_354_1.time_ and arg_354_1.time_ <= var_357_5 + arg_357_0 and not isNil(var_357_4) and arg_354_1.var_.characterEffect10104ui_story == nil then
				arg_354_1.var_.characterEffect10104ui_story = var_357_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_357_6 = 0.200000002980232

			if var_357_5 <= arg_354_1.time_ and arg_354_1.time_ < var_357_5 + var_357_6 and not isNil(var_357_4) then
				local var_357_7 = (arg_354_1.time_ - var_357_5) / var_357_6

				if arg_354_1.var_.characterEffect10104ui_story and not isNil(var_357_4) then
					arg_354_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_354_1.time_ >= var_357_5 + var_357_6 and arg_354_1.time_ < var_357_5 + var_357_6 + arg_357_0 and not isNil(var_357_4) and arg_354_1.var_.characterEffect10104ui_story then
				arg_354_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_357_8 = 0

			if var_357_8 < arg_354_1.time_ and arg_354_1.time_ <= var_357_8 + arg_357_0 then
				arg_354_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action1_1")
			end

			local var_357_9 = 0

			if var_357_9 < arg_354_1.time_ and arg_354_1.time_ <= var_357_9 + arg_357_0 then
				arg_354_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_357_10 = arg_354_1.actors_["10104ui_story"].transform
			local var_357_11 = 0

			if var_357_11 < arg_354_1.time_ and arg_354_1.time_ <= var_357_11 + arg_357_0 then
				arg_354_1.var_.moveOldPos10104ui_story = var_357_10.localPosition
			end

			local var_357_12 = 0.001

			if var_357_11 <= arg_354_1.time_ and arg_354_1.time_ < var_357_11 + var_357_12 then
				local var_357_13 = (arg_354_1.time_ - var_357_11) / var_357_12
				local var_357_14 = Vector3.New(0.02, -1.12, -5.99)

				var_357_10.localPosition = Vector3.Lerp(arg_354_1.var_.moveOldPos10104ui_story, var_357_14, var_357_13)

				local var_357_15 = manager.ui.mainCamera.transform.position - var_357_10.position

				var_357_10.forward = Vector3.New(var_357_15.x, var_357_15.y, var_357_15.z)

				local var_357_16 = var_357_10.localEulerAngles

				var_357_16.z = 0
				var_357_16.x = 0
				var_357_10.localEulerAngles = var_357_16
			end

			if arg_354_1.time_ >= var_357_11 + var_357_12 and arg_354_1.time_ < var_357_11 + var_357_12 + arg_357_0 then
				var_357_10.localPosition = Vector3.New(0.02, -1.12, -5.99)

				local var_357_17 = manager.ui.mainCamera.transform.position - var_357_10.position

				var_357_10.forward = Vector3.New(var_357_17.x, var_357_17.y, var_357_17.z)

				local var_357_18 = var_357_10.localEulerAngles

				var_357_18.z = 0
				var_357_18.x = 0
				var_357_10.localEulerAngles = var_357_18
			end

			local var_357_19 = 0
			local var_357_20 = 0.35

			if var_357_19 < arg_354_1.time_ and arg_354_1.time_ <= var_357_19 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0
				arg_354_1.dialogCg_.alpha = 1

				arg_354_1.dialog_:SetActive(true)
				SetActive(arg_354_1.leftNameGo_, true)

				local var_357_21 = arg_354_1:FormatText(StoryNameCfg[1030].name)

				arg_354_1.leftNameTxt_.text = var_357_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_354_1.leftNameTxt_.transform)

				arg_354_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_354_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_354_1:RecordName(arg_354_1.leftNameTxt_.text)
				SetActive(arg_354_1.iconTrs_.gameObject, false)
				arg_354_1.callingController_:SetSelectedState("normal")

				local var_357_22 = arg_354_1:GetWordFromCfg(321091083)
				local var_357_23 = arg_354_1:FormatText(var_357_22.content)

				arg_354_1.text_.text = var_357_23

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_24 = 14
				local var_357_25 = utf8.len(var_357_23)
				local var_357_26 = var_357_24 <= 0 and var_357_20 or var_357_20 * (var_357_25 / var_357_24)

				if var_357_26 > 0 and var_357_20 < var_357_26 then
					arg_354_1.talkMaxDuration = var_357_26

					if var_357_26 + var_357_19 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_26 + var_357_19
					end
				end

				arg_354_1.text_.text = var_357_23
				arg_354_1.typewritter.percent = 0

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091083", "story_v_out_321091.awb") ~= 0 then
					local var_357_27 = manager.audio:GetVoiceLength("story_v_out_321091", "321091083", "story_v_out_321091.awb") / 1000

					if var_357_27 + var_357_19 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_27 + var_357_19
					end

					if var_357_22.prefab_name ~= "" and arg_354_1.actors_[var_357_22.prefab_name] ~= nil then
						local var_357_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_354_1.actors_[var_357_22.prefab_name].transform, "story_v_out_321091", "321091083", "story_v_out_321091.awb")

						arg_354_1:RecordAudio("321091083", var_357_28)
						arg_354_1:RecordAudio("321091083", var_357_28)
					else
						arg_354_1:AudioAction("play", "voice", "story_v_out_321091", "321091083", "story_v_out_321091.awb")
					end

					arg_354_1:RecordHistoryTalkVoice("story_v_out_321091", "321091083", "story_v_out_321091.awb")
				end

				arg_354_1:RecordContent(arg_354_1.text_.text)
			end

			local var_357_29 = math.max(var_357_20, arg_354_1.talkMaxDuration)

			if var_357_19 <= arg_354_1.time_ and arg_354_1.time_ < var_357_19 + var_357_29 then
				arg_354_1.typewritter.percent = (arg_354_1.time_ - var_357_19) / var_357_29

				arg_354_1.typewritter:SetDirty()
			end

			if arg_354_1.time_ >= var_357_19 + var_357_29 and arg_354_1.time_ < var_357_19 + var_357_29 + arg_357_0 then
				arg_354_1.typewritter.percent = 1

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(true)
			end
		end

		arg_354_1.nodeConfigList_ = {
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

		arg_354_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST73",
		"TextureConfig/Background/MS2103a",
		"TextureConfig/Background/ST0507",
		"TextureConfig/Background/ST0507a",
		"TextureConfig/Background/L08g"
	},
	voices = {
		"story_v_out_321091.awb"
	}
}
