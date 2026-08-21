return {
	Play304101001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 304101001
		arg_1_1.duration_ = 7.91

		local var_1_0 = {
			zh = 7.708,
			ja = 7.908
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
				arg_1_0:Play304101002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "B10"

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
				local var_4_5 = arg_1_1.bgs_.B10

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
					if iter_4_0 ~= "B10" then
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

			local var_4_24 = "1148ui_story"

			if arg_1_1.actors_[var_4_24] == nil then
				local var_4_25 = Asset.Load("Char/" .. "1148ui_story")

				if not isNil(var_4_25) then
					local var_4_26 = Object.Instantiate(Asset.Load("Char/" .. "1148ui_story"), arg_1_1.stage_.transform)

					var_4_26.name = var_4_24
					var_4_26.transform.localPosition = Vector3.New(0, 100, 0)
					arg_1_1.actors_[var_4_24] = var_4_26

					local var_4_27 = var_4_26:GetComponentInChildren(typeof(CharacterEffect))

					var_4_27.enabled = true

					local var_4_28 = GameObjectTools.GetOrAddComponent(var_4_26, typeof(DynamicBoneHelper))

					if var_4_28 then
						var_4_28:EnableDynamicBone(false)
					end

					arg_1_1:ShowWeapon(var_4_27.transform, false)

					arg_1_1.var_[var_4_24 .. "Animator"] = var_4_27.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_1_1.var_[var_4_24 .. "Animator"].applyRootMotion = true
					arg_1_1.var_[var_4_24 .. "LipSync"] = var_4_27.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_4_29 = arg_1_1.actors_["1148ui_story"]
			local var_4_30 = 0

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 and not isNil(var_4_29) and arg_1_1.var_.characterEffect1148ui_story == nil then
				arg_1_1.var_.characterEffect1148ui_story = var_4_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_31 = 0.200000002980232

			if var_4_30 <= arg_1_1.time_ and arg_1_1.time_ < var_4_30 + var_4_31 and not isNil(var_4_29) then
				local var_4_32 = (arg_1_1.time_ - var_4_30) / var_4_31

				if arg_1_1.var_.characterEffect1148ui_story and not isNil(var_4_29) then
					arg_1_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_30 + var_4_31 and arg_1_1.time_ < var_4_30 + var_4_31 + arg_4_0 and not isNil(var_4_29) and arg_1_1.var_.characterEffect1148ui_story then
				arg_1_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_4_33 = manager.ui.mainCamera.transform
			local var_4_34 = 0

			if var_4_34 < arg_1_1.time_ and arg_1_1.time_ <= var_4_34 + arg_4_0 then
				local var_4_35 = arg_1_1.var_.effect444233
				local var_4_36
				local var_4_37 = var_4_33

				if not var_4_35 then
					var_4_35 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), var_4_37)
					var_4_35.name = "444233"
					arg_1_1.var_.effect444233 = var_4_35
				else
					var_4_35.transform:SetParent(var_4_37)
				end

				var_4_35.transform.localPosition = Vector3.New(-1.41, -0.06, -0.09)
				var_4_35.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_4_38 = manager.ui.mainCamera.transform
			local var_4_39 = 0.2

			if var_4_39 < arg_1_1.time_ and arg_1_1.time_ <= var_4_39 + arg_4_0 then
				local var_4_40 = arg_1_1.var_.effect444234
				local var_4_41
				local var_4_42 = var_4_38

				if not var_4_40 then
					var_4_40 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), var_4_42)
					var_4_40.name = "444234"
					arg_1_1.var_.effect444234 = var_4_40
				else
					var_4_40.transform:SetParent(var_4_42)
				end

				var_4_40.transform.localPosition = Vector3.New(-0.25, -0.28, 0)
				var_4_40.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_4_43 = manager.ui.mainCamera.transform
			local var_4_44 = 0.433333333333334

			if var_4_44 < arg_1_1.time_ and arg_1_1.time_ <= var_4_44 + arg_4_0 then
				local var_4_45 = arg_1_1.var_.effect444235
				local var_4_46
				local var_4_47 = var_4_43

				if not var_4_45 then
					var_4_45 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), var_4_47)
					var_4_45.name = "444235"
					arg_1_1.var_.effect444235 = var_4_45
				else
					var_4_45.transform:SetParent(var_4_47)
				end

				var_4_45.transform.localPosition = Vector3.New(0.63, -0.34, -1.1)
				var_4_45.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_4_48 = manager.ui.mainCamera.transform
			local var_4_49 = 1.36666666666667

			if var_4_49 < arg_1_1.time_ and arg_1_1.time_ <= var_4_49 + arg_4_0 then
				local var_4_50 = arg_1_1.var_.effect444233

				if var_4_50 then
					Object.Destroy(var_4_50)

					arg_1_1.var_.effect444233 = nil
				end
			end

			local var_4_51 = manager.ui.mainCamera.transform
			local var_4_52 = 1.56666666666667

			if var_4_52 < arg_1_1.time_ and arg_1_1.time_ <= var_4_52 + arg_4_0 then
				local var_4_53 = arg_1_1.var_.effect444234

				if var_4_53 then
					Object.Destroy(var_4_53)

					arg_1_1.var_.effect444234 = nil
				end
			end

			local var_4_54 = manager.ui.mainCamera.transform
			local var_4_55 = 1.8

			if var_4_55 < arg_1_1.time_ and arg_1_1.time_ <= var_4_55 + arg_4_0 then
				local var_4_56 = arg_1_1.var_.effect444235

				if var_4_56 then
					Object.Destroy(var_4_56)

					arg_1_1.var_.effect444235 = nil
				end
			end

			local var_4_57 = 0.2
			local var_4_58 = 1

			if var_4_57 < arg_1_1.time_ and arg_1_1.time_ <= var_4_57 + arg_4_0 then
				local var_4_59 = "play"
				local var_4_60 = "effect"

				arg_1_1:AudioAction(var_4_59, var_4_60, "se_story", "se_story_machinegun_b", "")
			end

			local var_4_61 = 0.2
			local var_4_62 = 1

			if var_4_61 < arg_1_1.time_ and arg_1_1.time_ <= var_4_61 + arg_4_0 then
				local var_4_63 = "play"
				local var_4_64 = "effect"

				arg_1_1:AudioAction(var_4_63, var_4_64, "se_story_142", "se_story_142_amb_city_street", "")
			end

			local var_4_65 = 1
			local var_4_66 = 1

			if var_4_65 < arg_1_1.time_ and arg_1_1.time_ <= var_4_65 + arg_4_0 then
				local var_4_67 = "play"
				local var_4_68 = "music"

				arg_1_1:AudioAction(var_4_67, var_4_68, "bgm_activity_5_2_story_nervous", "bgm_activity_5_2_story_nervous", "bgm_activity_5_2_story_nervous.awb")

				local var_4_69 = ""
				local var_4_70 = manager.audio:GetAudioName("bgm_activity_5_2_story_nervous", "bgm_activity_5_2_story_nervous")

				if var_4_70 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_70 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_70

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_70
						arg_1_1.bgmTxt2_.text = var_4_70
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

			local var_4_71 = 0
			local var_4_72 = 1

			if var_4_71 < arg_1_1.time_ and arg_1_1.time_ <= var_4_71 + arg_4_0 then
				local var_4_73 = "play"
				local var_4_74 = "effect"

				arg_1_1:AudioAction(var_4_73, var_4_74, "ui_battle", "ui_battle_stopbgm", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_75 = 1.375
			local var_4_76 = 0.625

			if var_4_75 < arg_1_1.time_ and arg_1_1.time_ <= var_4_75 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_77 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_77:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_77:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_77:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_78 = arg_1_1:FormatText(StoryNameCfg[8].name)

				arg_1_1.leftNameTxt_.text = var_4_78

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1148")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_79 = arg_1_1:GetWordFromCfg(304101001)
				local var_4_80 = arg_1_1:FormatText(var_4_79.content)

				arg_1_1.text_.text = var_4_80

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_81 = 25
				local var_4_82 = utf8.len(var_4_80)
				local var_4_83 = var_4_81 <= 0 and var_4_76 or var_4_76 * (var_4_82 / var_4_81)

				if var_4_83 > 0 and var_4_76 < var_4_83 then
					arg_1_1.talkMaxDuration = var_4_83
					var_4_75 = var_4_75 + 0.3

					if var_4_83 + var_4_75 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_83 + var_4_75
					end
				end

				arg_1_1.text_.text = var_4_80
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304101", "304101001", "story_v_out_304101.awb") ~= 0 then
					local var_4_84 = manager.audio:GetVoiceLength("story_v_out_304101", "304101001", "story_v_out_304101.awb") / 1000

					if var_4_84 + var_4_75 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_84 + var_4_75
					end

					if var_4_79.prefab_name ~= "" and arg_1_1.actors_[var_4_79.prefab_name] ~= nil then
						local var_4_85 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_79.prefab_name].transform, "story_v_out_304101", "304101001", "story_v_out_304101.awb")

						arg_1_1:RecordAudio("304101001", var_4_85)
						arg_1_1:RecordAudio("304101001", var_4_85)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_304101", "304101001", "story_v_out_304101.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_304101", "304101001", "story_v_out_304101.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_86 = var_4_75 + 0.3
			local var_4_87 = math.max(var_4_76, arg_1_1.talkMaxDuration)

			if var_4_86 <= arg_1_1.time_ and arg_1_1.time_ < var_4_86 + var_4_87 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_86) / var_4_87

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_86 + var_4_87 and arg_1_1.time_ < var_4_86 + var_4_87 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play304101002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 304101002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play304101003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = arg_8_1.actors_["1148ui_story"]
			local var_11_1 = 0

			if var_11_1 < arg_8_1.time_ and arg_8_1.time_ <= var_11_1 + arg_11_0 and not isNil(var_11_0) and arg_8_1.var_.characterEffect1148ui_story == nil then
				arg_8_1.var_.characterEffect1148ui_story = var_11_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_2 = 0.200000002980232

			if var_11_1 <= arg_8_1.time_ and arg_8_1.time_ < var_11_1 + var_11_2 and not isNil(var_11_0) then
				local var_11_3 = (arg_8_1.time_ - var_11_1) / var_11_2

				if arg_8_1.var_.characterEffect1148ui_story and not isNil(var_11_0) then
					local var_11_4 = Mathf.Lerp(0, 0.5, var_11_3)

					arg_8_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_8_1.var_.characterEffect1148ui_story.fillRatio = var_11_4
				end
			end

			if arg_8_1.time_ >= var_11_1 + var_11_2 and arg_8_1.time_ < var_11_1 + var_11_2 + arg_11_0 and not isNil(var_11_0) and arg_8_1.var_.characterEffect1148ui_story then
				local var_11_5 = 0.5

				arg_8_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_8_1.var_.characterEffect1148ui_story.fillRatio = var_11_5
			end

			local var_11_6 = 0.2
			local var_11_7 = 1

			if var_11_6 < arg_8_1.time_ and arg_8_1.time_ <= var_11_6 + arg_11_0 then
				local var_11_8 = "play"
				local var_11_9 = "effect"

				arg_8_1:AudioAction(var_11_8, var_11_9, "se_story", "se_story_machinegun_a", "")
			end

			local var_11_10 = 0
			local var_11_11 = 0.825

			if var_11_10 < arg_8_1.time_ and arg_8_1.time_ <= var_11_10 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_12 = arg_8_1:GetWordFromCfg(304101002)
				local var_11_13 = arg_8_1:FormatText(var_11_12.content)

				arg_8_1.text_.text = var_11_13

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_14 = 33
				local var_11_15 = utf8.len(var_11_13)
				local var_11_16 = var_11_14 <= 0 and var_11_11 or var_11_11 * (var_11_15 / var_11_14)

				if var_11_16 > 0 and var_11_11 < var_11_16 then
					arg_8_1.talkMaxDuration = var_11_16

					if var_11_16 + var_11_10 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_16 + var_11_10
					end
				end

				arg_8_1.text_.text = var_11_13
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_17 = math.max(var_11_11, arg_8_1.talkMaxDuration)

			if var_11_10 <= arg_8_1.time_ and arg_8_1.time_ < var_11_10 + var_11_17 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_10) / var_11_17

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_10 + var_11_17 and arg_8_1.time_ < var_11_10 + var_11_17 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play304101003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 304101003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play304101004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0.2
			local var_15_1 = 1

			if var_15_0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_0 + arg_15_0 then
				local var_15_2 = "play"
				local var_15_3 = "effect"

				arg_12_1:AudioAction(var_15_2, var_15_3, "se_story_1211", "se_story_1211_explosionfar", "")
			end

			local var_15_4 = 0.5
			local var_15_5 = 1

			if var_15_4 < arg_12_1.time_ and arg_12_1.time_ <= var_15_4 + arg_15_0 then
				local var_15_6 = "play"
				local var_15_7 = "effect"

				arg_12_1:AudioAction(var_15_6, var_15_7, "se_story_15", "se_story_15_gun07", "")
			end

			local var_15_8 = 0
			local var_15_9 = 1.625

			if var_15_8 < arg_12_1.time_ and arg_12_1.time_ <= var_15_8 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, false)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_10 = arg_12_1:GetWordFromCfg(304101003)
				local var_15_11 = arg_12_1:FormatText(var_15_10.content)

				arg_12_1.text_.text = var_15_11

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_12 = 65
				local var_15_13 = utf8.len(var_15_11)
				local var_15_14 = var_15_12 <= 0 and var_15_9 or var_15_9 * (var_15_13 / var_15_12)

				if var_15_14 > 0 and var_15_9 < var_15_14 then
					arg_12_1.talkMaxDuration = var_15_14

					if var_15_14 + var_15_8 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_14 + var_15_8
					end
				end

				arg_12_1.text_.text = var_15_11
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_15 = math.max(var_15_9, arg_12_1.talkMaxDuration)

			if var_15_8 <= arg_12_1.time_ and arg_12_1.time_ < var_15_8 + var_15_15 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_8) / var_15_15

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_8 + var_15_15 and arg_12_1.time_ < var_15_8 + var_15_15 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play304101004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 304101004
		arg_16_1.duration_ = 13.83

		local var_16_0 = {
			zh = 6.7,
			ja = 13.833
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
				arg_16_0:Play304101005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = "1059ui_story"

			if arg_16_1.actors_[var_19_0] == nil then
				local var_19_1 = Asset.Load("Char/" .. "1059ui_story")

				if not isNil(var_19_1) then
					local var_19_2 = Object.Instantiate(Asset.Load("Char/" .. "1059ui_story"), arg_16_1.stage_.transform)

					var_19_2.name = var_19_0
					var_19_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_16_1.actors_[var_19_0] = var_19_2

					local var_19_3 = var_19_2:GetComponentInChildren(typeof(CharacterEffect))

					var_19_3.enabled = true

					local var_19_4 = GameObjectTools.GetOrAddComponent(var_19_2, typeof(DynamicBoneHelper))

					if var_19_4 then
						var_19_4:EnableDynamicBone(false)
					end

					arg_16_1:ShowWeapon(var_19_3.transform, false)

					arg_16_1.var_[var_19_0 .. "Animator"] = var_19_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_16_1.var_[var_19_0 .. "Animator"].applyRootMotion = true
					arg_16_1.var_[var_19_0 .. "LipSync"] = var_19_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_19_5 = arg_16_1.actors_["1059ui_story"].transform
			local var_19_6 = 0

			if var_19_6 < arg_16_1.time_ and arg_16_1.time_ <= var_19_6 + arg_19_0 then
				arg_16_1.var_.moveOldPos1059ui_story = var_19_5.localPosition
			end

			local var_19_7 = 0.001

			if var_19_6 <= arg_16_1.time_ and arg_16_1.time_ < var_19_6 + var_19_7 then
				local var_19_8 = (arg_16_1.time_ - var_19_6) / var_19_7
				local var_19_9 = Vector3.New(0, -1.05, -6)

				var_19_5.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1059ui_story, var_19_9, var_19_8)

				local var_19_10 = manager.ui.mainCamera.transform.position - var_19_5.position

				var_19_5.forward = Vector3.New(var_19_10.x, var_19_10.y, var_19_10.z)

				local var_19_11 = var_19_5.localEulerAngles

				var_19_11.z = 0
				var_19_11.x = 0
				var_19_5.localEulerAngles = var_19_11
			end

			if arg_16_1.time_ >= var_19_6 + var_19_7 and arg_16_1.time_ < var_19_6 + var_19_7 + arg_19_0 then
				var_19_5.localPosition = Vector3.New(0, -1.05, -6)

				local var_19_12 = manager.ui.mainCamera.transform.position - var_19_5.position

				var_19_5.forward = Vector3.New(var_19_12.x, var_19_12.y, var_19_12.z)

				local var_19_13 = var_19_5.localEulerAngles

				var_19_13.z = 0
				var_19_13.x = 0
				var_19_5.localEulerAngles = var_19_13
			end

			local var_19_14 = arg_16_1.actors_["1059ui_story"]
			local var_19_15 = 0

			if var_19_15 < arg_16_1.time_ and arg_16_1.time_ <= var_19_15 + arg_19_0 and not isNil(var_19_14) and arg_16_1.var_.characterEffect1059ui_story == nil then
				arg_16_1.var_.characterEffect1059ui_story = var_19_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_16 = 0.200000002980232

			if var_19_15 <= arg_16_1.time_ and arg_16_1.time_ < var_19_15 + var_19_16 and not isNil(var_19_14) then
				local var_19_17 = (arg_16_1.time_ - var_19_15) / var_19_16

				if arg_16_1.var_.characterEffect1059ui_story and not isNil(var_19_14) then
					arg_16_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= var_19_15 + var_19_16 and arg_16_1.time_ < var_19_15 + var_19_16 + arg_19_0 and not isNil(var_19_14) and arg_16_1.var_.characterEffect1059ui_story then
				arg_16_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_19_18 = 0

			if var_19_18 < arg_16_1.time_ and arg_16_1.time_ <= var_19_18 + arg_19_0 then
				arg_16_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action4_1")
			end

			local var_19_19 = 0

			if var_19_19 < arg_16_1.time_ and arg_16_1.time_ <= var_19_19 + arg_19_0 then
				arg_16_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_19_20 = 0
			local var_19_21 = 0.925

			if var_19_20 < arg_16_1.time_ and arg_16_1.time_ <= var_19_20 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_22 = arg_16_1:FormatText(StoryNameCfg[28].name)

				arg_16_1.leftNameTxt_.text = var_19_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_23 = arg_16_1:GetWordFromCfg(304101004)
				local var_19_24 = arg_16_1:FormatText(var_19_23.content)

				arg_16_1.text_.text = var_19_24

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_25 = 37
				local var_19_26 = utf8.len(var_19_24)
				local var_19_27 = var_19_25 <= 0 and var_19_21 or var_19_21 * (var_19_26 / var_19_25)

				if var_19_27 > 0 and var_19_21 < var_19_27 then
					arg_16_1.talkMaxDuration = var_19_27

					if var_19_27 + var_19_20 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_27 + var_19_20
					end
				end

				arg_16_1.text_.text = var_19_24
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304101", "304101004", "story_v_out_304101.awb") ~= 0 then
					local var_19_28 = manager.audio:GetVoiceLength("story_v_out_304101", "304101004", "story_v_out_304101.awb") / 1000

					if var_19_28 + var_19_20 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_28 + var_19_20
					end

					if var_19_23.prefab_name ~= "" and arg_16_1.actors_[var_19_23.prefab_name] ~= nil then
						local var_19_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_23.prefab_name].transform, "story_v_out_304101", "304101004", "story_v_out_304101.awb")

						arg_16_1:RecordAudio("304101004", var_19_29)
						arg_16_1:RecordAudio("304101004", var_19_29)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_304101", "304101004", "story_v_out_304101.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_304101", "304101004", "story_v_out_304101.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_30 = math.max(var_19_21, arg_16_1.talkMaxDuration)

			if var_19_20 <= arg_16_1.time_ and arg_16_1.time_ < var_19_20 + var_19_30 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_20) / var_19_30

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_20 + var_19_30 and arg_16_1.time_ < var_19_20 + var_19_30 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_16_1:InitPlayNodeList()
	end,
	Play304101005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 304101005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play304101006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = arg_20_1.actors_["1059ui_story"]
			local var_23_1 = 0

			if var_23_1 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.characterEffect1059ui_story == nil then
				arg_20_1.var_.characterEffect1059ui_story = var_23_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_2 = 0.200000002980232

			if var_23_1 <= arg_20_1.time_ and arg_20_1.time_ < var_23_1 + var_23_2 and not isNil(var_23_0) then
				local var_23_3 = (arg_20_1.time_ - var_23_1) / var_23_2

				if arg_20_1.var_.characterEffect1059ui_story and not isNil(var_23_0) then
					local var_23_4 = Mathf.Lerp(0, 0.5, var_23_3)

					arg_20_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_20_1.var_.characterEffect1059ui_story.fillRatio = var_23_4
				end
			end

			if arg_20_1.time_ >= var_23_1 + var_23_2 and arg_20_1.time_ < var_23_1 + var_23_2 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.characterEffect1059ui_story then
				local var_23_5 = 0.5

				arg_20_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_20_1.var_.characterEffect1059ui_story.fillRatio = var_23_5
			end

			local var_23_6 = 0
			local var_23_7 = 0.475

			if var_23_6 < arg_20_1.time_ and arg_20_1.time_ <= var_23_6 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_8 = arg_20_1:FormatText(StoryNameCfg[7].name)

				arg_20_1.leftNameTxt_.text = var_23_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, true)
				arg_20_1.iconController_:SetSelectedState("hero")

				arg_20_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_20_1.callingController_:SetSelectedState("calling")

				arg_20_1.keyicon_.color = Color.New(1, 1, 1)
				arg_20_1.icon_.color = Color.New(1, 1, 1)

				local var_23_9 = arg_20_1:GetWordFromCfg(304101005)
				local var_23_10 = arg_20_1:FormatText(var_23_9.content)

				arg_20_1.text_.text = var_23_10

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_11 = 19
				local var_23_12 = utf8.len(var_23_10)
				local var_23_13 = var_23_11 <= 0 and var_23_7 or var_23_7 * (var_23_12 / var_23_11)

				if var_23_13 > 0 and var_23_7 < var_23_13 then
					arg_20_1.talkMaxDuration = var_23_13

					if var_23_13 + var_23_6 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_13 + var_23_6
					end
				end

				arg_20_1.text_.text = var_23_10
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_14 = math.max(var_23_7, arg_20_1.talkMaxDuration)

			if var_23_6 <= arg_20_1.time_ and arg_20_1.time_ < var_23_6 + var_23_14 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_6) / var_23_14

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_6 + var_23_14 and arg_20_1.time_ < var_23_6 + var_23_14 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play304101006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 304101006
		arg_24_1.duration_ = 5.87

		local var_24_0 = {
			zh = 5.466,
			ja = 5.866
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
				arg_24_0:Play304101007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = arg_24_1.actors_["1148ui_story"].transform
			local var_27_1 = 0

			if var_27_1 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 then
				arg_24_1.var_.moveOldPos1148ui_story = var_27_0.localPosition
			end

			local var_27_2 = 0.001

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_2 then
				local var_27_3 = (arg_24_1.time_ - var_27_1) / var_27_2
				local var_27_4 = Vector3.New(0, -0.8, -6.2)

				var_27_0.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1148ui_story, var_27_4, var_27_3)

				local var_27_5 = manager.ui.mainCamera.transform.position - var_27_0.position

				var_27_0.forward = Vector3.New(var_27_5.x, var_27_5.y, var_27_5.z)

				local var_27_6 = var_27_0.localEulerAngles

				var_27_6.z = 0
				var_27_6.x = 0
				var_27_0.localEulerAngles = var_27_6
			end

			if arg_24_1.time_ >= var_27_1 + var_27_2 and arg_24_1.time_ < var_27_1 + var_27_2 + arg_27_0 then
				var_27_0.localPosition = Vector3.New(0, -0.8, -6.2)

				local var_27_7 = manager.ui.mainCamera.transform.position - var_27_0.position

				var_27_0.forward = Vector3.New(var_27_7.x, var_27_7.y, var_27_7.z)

				local var_27_8 = var_27_0.localEulerAngles

				var_27_8.z = 0
				var_27_8.x = 0
				var_27_0.localEulerAngles = var_27_8
			end

			local var_27_9 = arg_24_1.actors_["1059ui_story"].transform
			local var_27_10 = 0

			if var_27_10 < arg_24_1.time_ and arg_24_1.time_ <= var_27_10 + arg_27_0 then
				arg_24_1.var_.moveOldPos1059ui_story = var_27_9.localPosition
			end

			local var_27_11 = 0.001

			if var_27_10 <= arg_24_1.time_ and arg_24_1.time_ < var_27_10 + var_27_11 then
				local var_27_12 = (arg_24_1.time_ - var_27_10) / var_27_11
				local var_27_13 = Vector3.New(0, 100, 0)

				var_27_9.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1059ui_story, var_27_13, var_27_12)

				local var_27_14 = manager.ui.mainCamera.transform.position - var_27_9.position

				var_27_9.forward = Vector3.New(var_27_14.x, var_27_14.y, var_27_14.z)

				local var_27_15 = var_27_9.localEulerAngles

				var_27_15.z = 0
				var_27_15.x = 0
				var_27_9.localEulerAngles = var_27_15
			end

			if arg_24_1.time_ >= var_27_10 + var_27_11 and arg_24_1.time_ < var_27_10 + var_27_11 + arg_27_0 then
				var_27_9.localPosition = Vector3.New(0, 100, 0)

				local var_27_16 = manager.ui.mainCamera.transform.position - var_27_9.position

				var_27_9.forward = Vector3.New(var_27_16.x, var_27_16.y, var_27_16.z)

				local var_27_17 = var_27_9.localEulerAngles

				var_27_17.z = 0
				var_27_17.x = 0
				var_27_9.localEulerAngles = var_27_17
			end

			local var_27_18 = arg_24_1.actors_["1148ui_story"]
			local var_27_19 = 0

			if var_27_19 < arg_24_1.time_ and arg_24_1.time_ <= var_27_19 + arg_27_0 and not isNil(var_27_18) and arg_24_1.var_.characterEffect1148ui_story == nil then
				arg_24_1.var_.characterEffect1148ui_story = var_27_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_20 = 0.200000002980232

			if var_27_19 <= arg_24_1.time_ and arg_24_1.time_ < var_27_19 + var_27_20 and not isNil(var_27_18) then
				local var_27_21 = (arg_24_1.time_ - var_27_19) / var_27_20

				if arg_24_1.var_.characterEffect1148ui_story and not isNil(var_27_18) then
					arg_24_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= var_27_19 + var_27_20 and arg_24_1.time_ < var_27_19 + var_27_20 + arg_27_0 and not isNil(var_27_18) and arg_24_1.var_.characterEffect1148ui_story then
				arg_24_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_27_22 = 0

			if var_27_22 < arg_24_1.time_ and arg_24_1.time_ <= var_27_22 + arg_27_0 then
				arg_24_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action3_1")
			end

			local var_27_23 = 0

			if var_27_23 < arg_24_1.time_ and arg_24_1.time_ <= var_27_23 + arg_27_0 then
				arg_24_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_27_24 = 0
			local var_27_25 = 0.6

			if var_27_24 < arg_24_1.time_ and arg_24_1.time_ <= var_27_24 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_26 = arg_24_1:FormatText(StoryNameCfg[8].name)

				arg_24_1.leftNameTxt_.text = var_27_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_27 = arg_24_1:GetWordFromCfg(304101006)
				local var_27_28 = arg_24_1:FormatText(var_27_27.content)

				arg_24_1.text_.text = var_27_28

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_29 = 24
				local var_27_30 = utf8.len(var_27_28)
				local var_27_31 = var_27_29 <= 0 and var_27_25 or var_27_25 * (var_27_30 / var_27_29)

				if var_27_31 > 0 and var_27_25 < var_27_31 then
					arg_24_1.talkMaxDuration = var_27_31

					if var_27_31 + var_27_24 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_31 + var_27_24
					end
				end

				arg_24_1.text_.text = var_27_28
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304101", "304101006", "story_v_out_304101.awb") ~= 0 then
					local var_27_32 = manager.audio:GetVoiceLength("story_v_out_304101", "304101006", "story_v_out_304101.awb") / 1000

					if var_27_32 + var_27_24 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_32 + var_27_24
					end

					if var_27_27.prefab_name ~= "" and arg_24_1.actors_[var_27_27.prefab_name] ~= nil then
						local var_27_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_27.prefab_name].transform, "story_v_out_304101", "304101006", "story_v_out_304101.awb")

						arg_24_1:RecordAudio("304101006", var_27_33)
						arg_24_1:RecordAudio("304101006", var_27_33)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_304101", "304101006", "story_v_out_304101.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_304101", "304101006", "story_v_out_304101.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_34 = math.max(var_27_25, arg_24_1.talkMaxDuration)

			if var_27_24 <= arg_24_1.time_ and arg_24_1.time_ < var_27_24 + var_27_34 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_24) / var_27_34

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_24 + var_27_34 and arg_24_1.time_ < var_27_24 + var_27_34 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_24_1:InitPlayNodeList()
	end,
	Play304101007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 304101007
		arg_28_1.duration_ = 14.13

		local var_28_0 = {
			zh = 8.866,
			ja = 14.133
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
				arg_28_0:Play304101008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = arg_28_1.actors_["1059ui_story"]
			local var_31_1 = 0

			if var_31_1 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect1059ui_story == nil then
				arg_28_1.var_.characterEffect1059ui_story = var_31_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_2 = 0.200000002980232

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_2 and not isNil(var_31_0) then
				local var_31_3 = (arg_28_1.time_ - var_31_1) / var_31_2

				if arg_28_1.var_.characterEffect1059ui_story and not isNil(var_31_0) then
					arg_28_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= var_31_1 + var_31_2 and arg_28_1.time_ < var_31_1 + var_31_2 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect1059ui_story then
				arg_28_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_31_4 = arg_28_1.actors_["1148ui_story"]
			local var_31_5 = 0

			if var_31_5 < arg_28_1.time_ and arg_28_1.time_ <= var_31_5 + arg_31_0 and not isNil(var_31_4) and arg_28_1.var_.characterEffect1148ui_story == nil then
				arg_28_1.var_.characterEffect1148ui_story = var_31_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_6 = 0.200000002980232

			if var_31_5 <= arg_28_1.time_ and arg_28_1.time_ < var_31_5 + var_31_6 and not isNil(var_31_4) then
				local var_31_7 = (arg_28_1.time_ - var_31_5) / var_31_6

				if arg_28_1.var_.characterEffect1148ui_story and not isNil(var_31_4) then
					local var_31_8 = Mathf.Lerp(0, 0.5, var_31_7)

					arg_28_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_28_1.var_.characterEffect1148ui_story.fillRatio = var_31_8
				end
			end

			if arg_28_1.time_ >= var_31_5 + var_31_6 and arg_28_1.time_ < var_31_5 + var_31_6 + arg_31_0 and not isNil(var_31_4) and arg_28_1.var_.characterEffect1148ui_story then
				local var_31_9 = 0.5

				arg_28_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_28_1.var_.characterEffect1148ui_story.fillRatio = var_31_9
			end

			local var_31_10 = arg_28_1.actors_["1148ui_story"].transform
			local var_31_11 = 0

			if var_31_11 < arg_28_1.time_ and arg_28_1.time_ <= var_31_11 + arg_31_0 then
				arg_28_1.var_.moveOldPos1148ui_story = var_31_10.localPosition
			end

			local var_31_12 = 0.001

			if var_31_11 <= arg_28_1.time_ and arg_28_1.time_ < var_31_11 + var_31_12 then
				local var_31_13 = (arg_28_1.time_ - var_31_11) / var_31_12
				local var_31_14 = Vector3.New(-0.7, -0.8, -6.2)

				var_31_10.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos1148ui_story, var_31_14, var_31_13)

				local var_31_15 = manager.ui.mainCamera.transform.position - var_31_10.position

				var_31_10.forward = Vector3.New(var_31_15.x, var_31_15.y, var_31_15.z)

				local var_31_16 = var_31_10.localEulerAngles

				var_31_16.z = 0
				var_31_16.x = 0
				var_31_10.localEulerAngles = var_31_16
			end

			if arg_28_1.time_ >= var_31_11 + var_31_12 and arg_28_1.time_ < var_31_11 + var_31_12 + arg_31_0 then
				var_31_10.localPosition = Vector3.New(-0.7, -0.8, -6.2)

				local var_31_17 = manager.ui.mainCamera.transform.position - var_31_10.position

				var_31_10.forward = Vector3.New(var_31_17.x, var_31_17.y, var_31_17.z)

				local var_31_18 = var_31_10.localEulerAngles

				var_31_18.z = 0
				var_31_18.x = 0
				var_31_10.localEulerAngles = var_31_18
			end

			local var_31_19 = arg_28_1.actors_["1059ui_story"].transform
			local var_31_20 = 0

			if var_31_20 < arg_28_1.time_ and arg_28_1.time_ <= var_31_20 + arg_31_0 then
				arg_28_1.var_.moveOldPos1059ui_story = var_31_19.localPosition
			end

			local var_31_21 = 0.001

			if var_31_20 <= arg_28_1.time_ and arg_28_1.time_ < var_31_20 + var_31_21 then
				local var_31_22 = (arg_28_1.time_ - var_31_20) / var_31_21
				local var_31_23 = Vector3.New(0.7, -1.05, -6)

				var_31_19.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos1059ui_story, var_31_23, var_31_22)

				local var_31_24 = manager.ui.mainCamera.transform.position - var_31_19.position

				var_31_19.forward = Vector3.New(var_31_24.x, var_31_24.y, var_31_24.z)

				local var_31_25 = var_31_19.localEulerAngles

				var_31_25.z = 0
				var_31_25.x = 0
				var_31_19.localEulerAngles = var_31_25
			end

			if arg_28_1.time_ >= var_31_20 + var_31_21 and arg_28_1.time_ < var_31_20 + var_31_21 + arg_31_0 then
				var_31_19.localPosition = Vector3.New(0.7, -1.05, -6)

				local var_31_26 = manager.ui.mainCamera.transform.position - var_31_19.position

				var_31_19.forward = Vector3.New(var_31_26.x, var_31_26.y, var_31_26.z)

				local var_31_27 = var_31_19.localEulerAngles

				var_31_27.z = 0
				var_31_27.x = 0
				var_31_19.localEulerAngles = var_31_27
			end

			local var_31_28 = 0

			if var_31_28 < arg_28_1.time_ and arg_28_1.time_ <= var_31_28 + arg_31_0 then
				arg_28_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059actionlink/1059action447")
			end

			local var_31_29 = 0
			local var_31_30 = 1.125

			if var_31_29 < arg_28_1.time_ and arg_28_1.time_ <= var_31_29 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_31 = arg_28_1:FormatText(StoryNameCfg[28].name)

				arg_28_1.leftNameTxt_.text = var_31_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_32 = arg_28_1:GetWordFromCfg(304101007)
				local var_31_33 = arg_28_1:FormatText(var_31_32.content)

				arg_28_1.text_.text = var_31_33

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_34 = 45
				local var_31_35 = utf8.len(var_31_33)
				local var_31_36 = var_31_34 <= 0 and var_31_30 or var_31_30 * (var_31_35 / var_31_34)

				if var_31_36 > 0 and var_31_30 < var_31_36 then
					arg_28_1.talkMaxDuration = var_31_36

					if var_31_36 + var_31_29 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_36 + var_31_29
					end
				end

				arg_28_1.text_.text = var_31_33
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304101", "304101007", "story_v_out_304101.awb") ~= 0 then
					local var_31_37 = manager.audio:GetVoiceLength("story_v_out_304101", "304101007", "story_v_out_304101.awb") / 1000

					if var_31_37 + var_31_29 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_37 + var_31_29
					end

					if var_31_32.prefab_name ~= "" and arg_28_1.actors_[var_31_32.prefab_name] ~= nil then
						local var_31_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_32.prefab_name].transform, "story_v_out_304101", "304101007", "story_v_out_304101.awb")

						arg_28_1:RecordAudio("304101007", var_31_38)
						arg_28_1:RecordAudio("304101007", var_31_38)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_304101", "304101007", "story_v_out_304101.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_304101", "304101007", "story_v_out_304101.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_39 = math.max(var_31_30, arg_28_1.talkMaxDuration)

			if var_31_29 <= arg_28_1.time_ and arg_28_1.time_ < var_31_29 + var_31_39 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_29) / var_31_39

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_29 + var_31_39 and arg_28_1.time_ < var_31_29 + var_31_39 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_28_1:InitPlayNodeList()
	end,
	Play304101008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 304101008
		arg_32_1.duration_ = 5

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play304101009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = arg_32_1.actors_["1059ui_story"]
			local var_35_1 = 0

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect1059ui_story == nil then
				arg_32_1.var_.characterEffect1059ui_story = var_35_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_2 = 0.200000002980232

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_2 and not isNil(var_35_0) then
				local var_35_3 = (arg_32_1.time_ - var_35_1) / var_35_2

				if arg_32_1.var_.characterEffect1059ui_story and not isNil(var_35_0) then
					local var_35_4 = Mathf.Lerp(0, 0.5, var_35_3)

					arg_32_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_32_1.var_.characterEffect1059ui_story.fillRatio = var_35_4
				end
			end

			if arg_32_1.time_ >= var_35_1 + var_35_2 and arg_32_1.time_ < var_35_1 + var_35_2 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect1059ui_story then
				local var_35_5 = 0.5

				arg_32_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_32_1.var_.characterEffect1059ui_story.fillRatio = var_35_5
			end

			local var_35_6 = 0
			local var_35_7 = 0.85

			if var_35_6 < arg_32_1.time_ and arg_32_1.time_ <= var_35_6 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_8 = arg_32_1:FormatText(StoryNameCfg[7].name)

				arg_32_1.leftNameTxt_.text = var_35_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, true)
				arg_32_1.iconController_:SetSelectedState("hero")

				arg_32_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_32_1.callingController_:SetSelectedState("calling")

				arg_32_1.keyicon_.color = Color.New(1, 1, 1)
				arg_32_1.icon_.color = Color.New(1, 1, 1)

				local var_35_9 = arg_32_1:GetWordFromCfg(304101008)
				local var_35_10 = arg_32_1:FormatText(var_35_9.content)

				arg_32_1.text_.text = var_35_10

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_11 = 34
				local var_35_12 = utf8.len(var_35_10)
				local var_35_13 = var_35_11 <= 0 and var_35_7 or var_35_7 * (var_35_12 / var_35_11)

				if var_35_13 > 0 and var_35_7 < var_35_13 then
					arg_32_1.talkMaxDuration = var_35_13

					if var_35_13 + var_35_6 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_13 + var_35_6
					end
				end

				arg_32_1.text_.text = var_35_10
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)
				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_14 = math.max(var_35_7, arg_32_1.talkMaxDuration)

			if var_35_6 <= arg_32_1.time_ and arg_32_1.time_ < var_35_6 + var_35_14 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_6) / var_35_14

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_6 + var_35_14 and arg_32_1.time_ < var_35_6 + var_35_14 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play304101009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 304101009
		arg_36_1.duration_ = 8.27

		local var_36_0 = {
			zh = 6.033,
			ja = 8.266
		}
		local var_36_1 = manager.audio:GetLocalizationFlag()

		if var_36_0[var_36_1] ~= nil then
			arg_36_1.duration_ = var_36_0[var_36_1]
		end

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play304101010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = arg_36_1.actors_["1148ui_story"]
			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect1148ui_story == nil then
				arg_36_1.var_.characterEffect1148ui_story = var_39_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_2 = 0.200000002980232

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_2 and not isNil(var_39_0) then
				local var_39_3 = (arg_36_1.time_ - var_39_1) / var_39_2

				if arg_36_1.var_.characterEffect1148ui_story and not isNil(var_39_0) then
					arg_36_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= var_39_1 + var_39_2 and arg_36_1.time_ < var_39_1 + var_39_2 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect1148ui_story then
				arg_36_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_39_4 = 0

			if var_39_4 < arg_36_1.time_ and arg_36_1.time_ <= var_39_4 + arg_39_0 then
				arg_36_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action3_2")
			end

			local var_39_5 = 0
			local var_39_6 = 0.625

			if var_39_5 < arg_36_1.time_ and arg_36_1.time_ <= var_39_5 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_7 = arg_36_1:FormatText(StoryNameCfg[8].name)

				arg_36_1.leftNameTxt_.text = var_39_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_8 = arg_36_1:GetWordFromCfg(304101009)
				local var_39_9 = arg_36_1:FormatText(var_39_8.content)

				arg_36_1.text_.text = var_39_9

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_10 = 25
				local var_39_11 = utf8.len(var_39_9)
				local var_39_12 = var_39_10 <= 0 and var_39_6 or var_39_6 * (var_39_11 / var_39_10)

				if var_39_12 > 0 and var_39_6 < var_39_12 then
					arg_36_1.talkMaxDuration = var_39_12

					if var_39_12 + var_39_5 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_12 + var_39_5
					end
				end

				arg_36_1.text_.text = var_39_9
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304101", "304101009", "story_v_out_304101.awb") ~= 0 then
					local var_39_13 = manager.audio:GetVoiceLength("story_v_out_304101", "304101009", "story_v_out_304101.awb") / 1000

					if var_39_13 + var_39_5 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_13 + var_39_5
					end

					if var_39_8.prefab_name ~= "" and arg_36_1.actors_[var_39_8.prefab_name] ~= nil then
						local var_39_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_8.prefab_name].transform, "story_v_out_304101", "304101009", "story_v_out_304101.awb")

						arg_36_1:RecordAudio("304101009", var_39_14)
						arg_36_1:RecordAudio("304101009", var_39_14)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_304101", "304101009", "story_v_out_304101.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_304101", "304101009", "story_v_out_304101.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_15 = math.max(var_39_6, arg_36_1.talkMaxDuration)

			if var_39_5 <= arg_36_1.time_ and arg_36_1.time_ < var_39_5 + var_39_15 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_5) / var_39_15

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_5 + var_39_15 and arg_36_1.time_ < var_39_5 + var_39_15 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play304101010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 304101010
		arg_40_1.duration_ = 7.87

		local var_40_0 = {
			zh = 5.633,
			ja = 7.866
		}
		local var_40_1 = manager.audio:GetLocalizationFlag()

		if var_40_0[var_40_1] ~= nil then
			arg_40_1.duration_ = var_40_0[var_40_1]
		end

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play304101011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = 0
			local var_43_1 = 0.625

			if var_43_0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_0 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_2 = arg_40_1:FormatText(StoryNameCfg[8].name)

				arg_40_1.leftNameTxt_.text = var_43_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_3 = arg_40_1:GetWordFromCfg(304101010)
				local var_43_4 = arg_40_1:FormatText(var_43_3.content)

				arg_40_1.text_.text = var_43_4

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_5 = 25
				local var_43_6 = utf8.len(var_43_4)
				local var_43_7 = var_43_5 <= 0 and var_43_1 or var_43_1 * (var_43_6 / var_43_5)

				if var_43_7 > 0 and var_43_1 < var_43_7 then
					arg_40_1.talkMaxDuration = var_43_7

					if var_43_7 + var_43_0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_7 + var_43_0
					end
				end

				arg_40_1.text_.text = var_43_4
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304101", "304101010", "story_v_out_304101.awb") ~= 0 then
					local var_43_8 = manager.audio:GetVoiceLength("story_v_out_304101", "304101010", "story_v_out_304101.awb") / 1000

					if var_43_8 + var_43_0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_8 + var_43_0
					end

					if var_43_3.prefab_name ~= "" and arg_40_1.actors_[var_43_3.prefab_name] ~= nil then
						local var_43_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_3.prefab_name].transform, "story_v_out_304101", "304101010", "story_v_out_304101.awb")

						arg_40_1:RecordAudio("304101010", var_43_9)
						arg_40_1:RecordAudio("304101010", var_43_9)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_304101", "304101010", "story_v_out_304101.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_304101", "304101010", "story_v_out_304101.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_10 = math.max(var_43_1, arg_40_1.talkMaxDuration)

			if var_43_0 <= arg_40_1.time_ and arg_40_1.time_ < var_43_0 + var_43_10 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_0) / var_43_10

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_0 + var_43_10 and arg_40_1.time_ < var_43_0 + var_43_10 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play304101011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 304101011
		arg_44_1.duration_ = 5

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play304101012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = arg_44_1.actors_["1148ui_story"].transform
			local var_47_1 = 0

			if var_47_1 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 then
				arg_44_1.var_.moveOldPos1148ui_story = var_47_0.localPosition
			end

			local var_47_2 = 0.001

			if var_47_1 <= arg_44_1.time_ and arg_44_1.time_ < var_47_1 + var_47_2 then
				local var_47_3 = (arg_44_1.time_ - var_47_1) / var_47_2
				local var_47_4 = Vector3.New(0, 100, 0)

				var_47_0.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1148ui_story, var_47_4, var_47_3)

				local var_47_5 = manager.ui.mainCamera.transform.position - var_47_0.position

				var_47_0.forward = Vector3.New(var_47_5.x, var_47_5.y, var_47_5.z)

				local var_47_6 = var_47_0.localEulerAngles

				var_47_6.z = 0
				var_47_6.x = 0
				var_47_0.localEulerAngles = var_47_6
			end

			if arg_44_1.time_ >= var_47_1 + var_47_2 and arg_44_1.time_ < var_47_1 + var_47_2 + arg_47_0 then
				var_47_0.localPosition = Vector3.New(0, 100, 0)

				local var_47_7 = manager.ui.mainCamera.transform.position - var_47_0.position

				var_47_0.forward = Vector3.New(var_47_7.x, var_47_7.y, var_47_7.z)

				local var_47_8 = var_47_0.localEulerAngles

				var_47_8.z = 0
				var_47_8.x = 0
				var_47_0.localEulerAngles = var_47_8
			end

			local var_47_9 = arg_44_1.actors_["1059ui_story"].transform
			local var_47_10 = 0

			if var_47_10 < arg_44_1.time_ and arg_44_1.time_ <= var_47_10 + arg_47_0 then
				arg_44_1.var_.moveOldPos1059ui_story = var_47_9.localPosition
			end

			local var_47_11 = 0.001

			if var_47_10 <= arg_44_1.time_ and arg_44_1.time_ < var_47_10 + var_47_11 then
				local var_47_12 = (arg_44_1.time_ - var_47_10) / var_47_11
				local var_47_13 = Vector3.New(0, 100, 0)

				var_47_9.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1059ui_story, var_47_13, var_47_12)

				local var_47_14 = manager.ui.mainCamera.transform.position - var_47_9.position

				var_47_9.forward = Vector3.New(var_47_14.x, var_47_14.y, var_47_14.z)

				local var_47_15 = var_47_9.localEulerAngles

				var_47_15.z = 0
				var_47_15.x = 0
				var_47_9.localEulerAngles = var_47_15
			end

			if arg_44_1.time_ >= var_47_10 + var_47_11 and arg_44_1.time_ < var_47_10 + var_47_11 + arg_47_0 then
				var_47_9.localPosition = Vector3.New(0, 100, 0)

				local var_47_16 = manager.ui.mainCamera.transform.position - var_47_9.position

				var_47_9.forward = Vector3.New(var_47_16.x, var_47_16.y, var_47_16.z)

				local var_47_17 = var_47_9.localEulerAngles

				var_47_17.z = 0
				var_47_17.x = 0
				var_47_9.localEulerAngles = var_47_17
			end

			local var_47_18 = arg_44_1.actors_["1148ui_story"]
			local var_47_19 = 0

			if var_47_19 < arg_44_1.time_ and arg_44_1.time_ <= var_47_19 + arg_47_0 and not isNil(var_47_18) and arg_44_1.var_.characterEffect1148ui_story == nil then
				arg_44_1.var_.characterEffect1148ui_story = var_47_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_20 = 0.200000002980232

			if var_47_19 <= arg_44_1.time_ and arg_44_1.time_ < var_47_19 + var_47_20 and not isNil(var_47_18) then
				local var_47_21 = (arg_44_1.time_ - var_47_19) / var_47_20

				if arg_44_1.var_.characterEffect1148ui_story and not isNil(var_47_18) then
					local var_47_22 = Mathf.Lerp(0, 0.5, var_47_21)

					arg_44_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_44_1.var_.characterEffect1148ui_story.fillRatio = var_47_22
				end
			end

			if arg_44_1.time_ >= var_47_19 + var_47_20 and arg_44_1.time_ < var_47_19 + var_47_20 + arg_47_0 and not isNil(var_47_18) and arg_44_1.var_.characterEffect1148ui_story then
				local var_47_23 = 0.5

				arg_44_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_44_1.var_.characterEffect1148ui_story.fillRatio = var_47_23
			end

			local var_47_24 = 0
			local var_47_25 = 1.575

			if var_47_24 < arg_44_1.time_ and arg_44_1.time_ <= var_47_24 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, false)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_26 = arg_44_1:GetWordFromCfg(304101011)
				local var_47_27 = arg_44_1:FormatText(var_47_26.content)

				arg_44_1.text_.text = var_47_27

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_28 = 61
				local var_47_29 = utf8.len(var_47_27)
				local var_47_30 = var_47_28 <= 0 and var_47_25 or var_47_25 * (var_47_29 / var_47_28)

				if var_47_30 > 0 and var_47_25 < var_47_30 then
					arg_44_1.talkMaxDuration = var_47_30

					if var_47_30 + var_47_24 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_30 + var_47_24
					end
				end

				arg_44_1.text_.text = var_47_27
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)
				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_31 = math.max(var_47_25, arg_44_1.talkMaxDuration)

			if var_47_24 <= arg_44_1.time_ and arg_44_1.time_ < var_47_24 + var_47_31 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_24) / var_47_31

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_24 + var_47_31 and arg_44_1.time_ < var_47_24 + var_47_31 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_44_1:InitPlayNodeList()
	end,
	Play304101012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 304101012
		arg_48_1.duration_ = 5

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play304101013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = 0
			local var_51_1 = 1.025

			if var_51_0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_0 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_2 = arg_48_1:FormatText(StoryNameCfg[7].name)

				arg_48_1.leftNameTxt_.text = var_51_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, true)
				arg_48_1.iconController_:SetSelectedState("hero")

				arg_48_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_48_1.callingController_:SetSelectedState("calling")

				arg_48_1.keyicon_.color = Color.New(1, 1, 1)
				arg_48_1.icon_.color = Color.New(1, 1, 1)

				local var_51_3 = arg_48_1:GetWordFromCfg(304101012)
				local var_51_4 = arg_48_1:FormatText(var_51_3.content)

				arg_48_1.text_.text = var_51_4

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_5 = 41
				local var_51_6 = utf8.len(var_51_4)
				local var_51_7 = var_51_5 <= 0 and var_51_1 or var_51_1 * (var_51_6 / var_51_5)

				if var_51_7 > 0 and var_51_1 < var_51_7 then
					arg_48_1.talkMaxDuration = var_51_7

					if var_51_7 + var_51_0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_7 + var_51_0
					end
				end

				arg_48_1.text_.text = var_51_4
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)
				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_8 = math.max(var_51_1, arg_48_1.talkMaxDuration)

			if var_51_0 <= arg_48_1.time_ and arg_48_1.time_ < var_51_0 + var_51_8 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_0) / var_51_8

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_0 + var_51_8 and arg_48_1.time_ < var_51_0 + var_51_8 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play304101013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 304101013
		arg_52_1.duration_ = 5

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play304101014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = 0
			local var_55_1 = 0.925

			if var_55_0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_0 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_2 = arg_52_1:FormatText(StoryNameCfg[7].name)

				arg_52_1.leftNameTxt_.text = var_55_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, true)
				arg_52_1.iconController_:SetSelectedState("hero")

				arg_52_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_52_1.callingController_:SetSelectedState("calling")

				arg_52_1.keyicon_.color = Color.New(1, 1, 1)
				arg_52_1.icon_.color = Color.New(1, 1, 1)

				local var_55_3 = arg_52_1:GetWordFromCfg(304101013)
				local var_55_4 = arg_52_1:FormatText(var_55_3.content)

				arg_52_1.text_.text = var_55_4

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_5 = 37
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
				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_8 = math.max(var_55_1, arg_52_1.talkMaxDuration)

			if var_55_0 <= arg_52_1.time_ and arg_52_1.time_ < var_55_0 + var_55_8 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_0) / var_55_8

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_0 + var_55_8 and arg_52_1.time_ < var_55_0 + var_55_8 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play304101014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 304101014
		arg_56_1.duration_ = 12.3

		local var_56_0 = {
			zh = 7.533,
			ja = 12.3
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
				arg_56_0:Play304101015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = arg_56_1.actors_["1148ui_story"].transform
			local var_59_1 = 0

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 then
				arg_56_1.var_.moveOldPos1148ui_story = var_59_0.localPosition
			end

			local var_59_2 = 0.001

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_2 then
				local var_59_3 = (arg_56_1.time_ - var_59_1) / var_59_2
				local var_59_4 = Vector3.New(0, -0.8, -6.2)

				var_59_0.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos1148ui_story, var_59_4, var_59_3)

				local var_59_5 = manager.ui.mainCamera.transform.position - var_59_0.position

				var_59_0.forward = Vector3.New(var_59_5.x, var_59_5.y, var_59_5.z)

				local var_59_6 = var_59_0.localEulerAngles

				var_59_6.z = 0
				var_59_6.x = 0
				var_59_0.localEulerAngles = var_59_6
			end

			if arg_56_1.time_ >= var_59_1 + var_59_2 and arg_56_1.time_ < var_59_1 + var_59_2 + arg_59_0 then
				var_59_0.localPosition = Vector3.New(0, -0.8, -6.2)

				local var_59_7 = manager.ui.mainCamera.transform.position - var_59_0.position

				var_59_0.forward = Vector3.New(var_59_7.x, var_59_7.y, var_59_7.z)

				local var_59_8 = var_59_0.localEulerAngles

				var_59_8.z = 0
				var_59_8.x = 0
				var_59_0.localEulerAngles = var_59_8
			end

			local var_59_9 = arg_56_1.actors_["1148ui_story"]
			local var_59_10 = 0

			if var_59_10 < arg_56_1.time_ and arg_56_1.time_ <= var_59_10 + arg_59_0 and not isNil(var_59_9) and arg_56_1.var_.characterEffect1148ui_story == nil then
				arg_56_1.var_.characterEffect1148ui_story = var_59_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_11 = 0.200000002980232

			if var_59_10 <= arg_56_1.time_ and arg_56_1.time_ < var_59_10 + var_59_11 and not isNil(var_59_9) then
				local var_59_12 = (arg_56_1.time_ - var_59_10) / var_59_11

				if arg_56_1.var_.characterEffect1148ui_story and not isNil(var_59_9) then
					arg_56_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_56_1.time_ >= var_59_10 + var_59_11 and arg_56_1.time_ < var_59_10 + var_59_11 + arg_59_0 and not isNil(var_59_9) and arg_56_1.var_.characterEffect1148ui_story then
				arg_56_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_59_13 = 0

			if var_59_13 < arg_56_1.time_ and arg_56_1.time_ <= var_59_13 + arg_59_0 then
				arg_56_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action7_1")
			end

			local var_59_14 = 0

			if var_59_14 < arg_56_1.time_ and arg_56_1.time_ <= var_59_14 + arg_59_0 then
				arg_56_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_59_15 = 0
			local var_59_16 = 0.85

			if var_59_15 < arg_56_1.time_ and arg_56_1.time_ <= var_59_15 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_17 = arg_56_1:FormatText(StoryNameCfg[8].name)

				arg_56_1.leftNameTxt_.text = var_59_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_18 = arg_56_1:GetWordFromCfg(304101014)
				local var_59_19 = arg_56_1:FormatText(var_59_18.content)

				arg_56_1.text_.text = var_59_19

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_20 = 34
				local var_59_21 = utf8.len(var_59_19)
				local var_59_22 = var_59_20 <= 0 and var_59_16 or var_59_16 * (var_59_21 / var_59_20)

				if var_59_22 > 0 and var_59_16 < var_59_22 then
					arg_56_1.talkMaxDuration = var_59_22

					if var_59_22 + var_59_15 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_22 + var_59_15
					end
				end

				arg_56_1.text_.text = var_59_19
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304101", "304101014", "story_v_out_304101.awb") ~= 0 then
					local var_59_23 = manager.audio:GetVoiceLength("story_v_out_304101", "304101014", "story_v_out_304101.awb") / 1000

					if var_59_23 + var_59_15 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_23 + var_59_15
					end

					if var_59_18.prefab_name ~= "" and arg_56_1.actors_[var_59_18.prefab_name] ~= nil then
						local var_59_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_18.prefab_name].transform, "story_v_out_304101", "304101014", "story_v_out_304101.awb")

						arg_56_1:RecordAudio("304101014", var_59_24)
						arg_56_1:RecordAudio("304101014", var_59_24)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_304101", "304101014", "story_v_out_304101.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_304101", "304101014", "story_v_out_304101.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_25 = math.max(var_59_16, arg_56_1.talkMaxDuration)

			if var_59_15 <= arg_56_1.time_ and arg_56_1.time_ < var_59_15 + var_59_25 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_15) / var_59_25

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_15 + var_59_25 and arg_56_1.time_ < var_59_15 + var_59_25 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
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
	Play304101015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 304101015
		arg_60_1.duration_ = 5

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play304101016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = arg_60_1.actors_["1148ui_story"]
			local var_63_1 = 0

			if var_63_1 < arg_60_1.time_ and arg_60_1.time_ <= var_63_1 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.characterEffect1148ui_story == nil then
				arg_60_1.var_.characterEffect1148ui_story = var_63_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_2 = 0.200000002980232

			if var_63_1 <= arg_60_1.time_ and arg_60_1.time_ < var_63_1 + var_63_2 and not isNil(var_63_0) then
				local var_63_3 = (arg_60_1.time_ - var_63_1) / var_63_2

				if arg_60_1.var_.characterEffect1148ui_story and not isNil(var_63_0) then
					local var_63_4 = Mathf.Lerp(0, 0.5, var_63_3)

					arg_60_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_60_1.var_.characterEffect1148ui_story.fillRatio = var_63_4
				end
			end

			if arg_60_1.time_ >= var_63_1 + var_63_2 and arg_60_1.time_ < var_63_1 + var_63_2 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.characterEffect1148ui_story then
				local var_63_5 = 0.5

				arg_60_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_60_1.var_.characterEffect1148ui_story.fillRatio = var_63_5
			end

			local var_63_6 = 0
			local var_63_7 = 0.825

			if var_63_6 < arg_60_1.time_ and arg_60_1.time_ <= var_63_6 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_8 = arg_60_1:FormatText(StoryNameCfg[7].name)

				arg_60_1.leftNameTxt_.text = var_63_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, true)
				arg_60_1.iconController_:SetSelectedState("hero")

				arg_60_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_60_1.callingController_:SetSelectedState("calling")

				arg_60_1.keyicon_.color = Color.New(1, 1, 1)
				arg_60_1.icon_.color = Color.New(1, 1, 1)

				local var_63_9 = arg_60_1:GetWordFromCfg(304101015)
				local var_63_10 = arg_60_1:FormatText(var_63_9.content)

				arg_60_1.text_.text = var_63_10

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_11 = 33
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
				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_14 = math.max(var_63_7, arg_60_1.talkMaxDuration)

			if var_63_6 <= arg_60_1.time_ and arg_60_1.time_ < var_63_6 + var_63_14 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_6) / var_63_14

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_6 + var_63_14 and arg_60_1.time_ < var_63_6 + var_63_14 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play304101016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 304101016
		arg_64_1.duration_ = 5

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play304101017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = 0
			local var_67_1 = 0.5

			if var_67_0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_0 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_2 = arg_64_1:FormatText(StoryNameCfg[7].name)

				arg_64_1.leftNameTxt_.text = var_67_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, true)
				arg_64_1.iconController_:SetSelectedState("hero")

				arg_64_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_64_1.callingController_:SetSelectedState("calling")

				arg_64_1.keyicon_.color = Color.New(1, 1, 1)
				arg_64_1.icon_.color = Color.New(1, 1, 1)

				local var_67_3 = arg_64_1:GetWordFromCfg(304101016)
				local var_67_4 = arg_64_1:FormatText(var_67_3.content)

				arg_64_1.text_.text = var_67_4

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_5 = 20
				local var_67_6 = utf8.len(var_67_4)
				local var_67_7 = var_67_5 <= 0 and var_67_1 or var_67_1 * (var_67_6 / var_67_5)

				if var_67_7 > 0 and var_67_1 < var_67_7 then
					arg_64_1.talkMaxDuration = var_67_7

					if var_67_7 + var_67_0 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_7 + var_67_0
					end
				end

				arg_64_1.text_.text = var_67_4
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)
				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_8 = math.max(var_67_1, arg_64_1.talkMaxDuration)

			if var_67_0 <= arg_64_1.time_ and arg_64_1.time_ < var_67_0 + var_67_8 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_0) / var_67_8

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_0 + var_67_8 and arg_64_1.time_ < var_67_0 + var_67_8 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play304101017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 304101017
		arg_68_1.duration_ = 12.13

		local var_68_0 = {
			zh = 8.233,
			ja = 12.133
		}
		local var_68_1 = manager.audio:GetLocalizationFlag()

		if var_68_0[var_68_1] ~= nil then
			arg_68_1.duration_ = var_68_0[var_68_1]
		end

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play304101018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = arg_68_1.actors_["1148ui_story"]
			local var_71_1 = 0

			if var_71_1 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.characterEffect1148ui_story == nil then
				arg_68_1.var_.characterEffect1148ui_story = var_71_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_2 = 0.200000002980232

			if var_71_1 <= arg_68_1.time_ and arg_68_1.time_ < var_71_1 + var_71_2 and not isNil(var_71_0) then
				local var_71_3 = (arg_68_1.time_ - var_71_1) / var_71_2

				if arg_68_1.var_.characterEffect1148ui_story and not isNil(var_71_0) then
					arg_68_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_68_1.time_ >= var_71_1 + var_71_2 and arg_68_1.time_ < var_71_1 + var_71_2 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.characterEffect1148ui_story then
				arg_68_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_71_4 = 0

			if var_71_4 < arg_68_1.time_ and arg_68_1.time_ <= var_71_4 + arg_71_0 then
				arg_68_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action475")
			end

			local var_71_5 = 0
			local var_71_6 = 0.825

			if var_71_5 < arg_68_1.time_ and arg_68_1.time_ <= var_71_5 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_7 = arg_68_1:FormatText(StoryNameCfg[8].name)

				arg_68_1.leftNameTxt_.text = var_71_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_8 = arg_68_1:GetWordFromCfg(304101017)
				local var_71_9 = arg_68_1:FormatText(var_71_8.content)

				arg_68_1.text_.text = var_71_9

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_10 = 33
				local var_71_11 = utf8.len(var_71_9)
				local var_71_12 = var_71_10 <= 0 and var_71_6 or var_71_6 * (var_71_11 / var_71_10)

				if var_71_12 > 0 and var_71_6 < var_71_12 then
					arg_68_1.talkMaxDuration = var_71_12

					if var_71_12 + var_71_5 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_12 + var_71_5
					end
				end

				arg_68_1.text_.text = var_71_9
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304101", "304101017", "story_v_out_304101.awb") ~= 0 then
					local var_71_13 = manager.audio:GetVoiceLength("story_v_out_304101", "304101017", "story_v_out_304101.awb") / 1000

					if var_71_13 + var_71_5 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_13 + var_71_5
					end

					if var_71_8.prefab_name ~= "" and arg_68_1.actors_[var_71_8.prefab_name] ~= nil then
						local var_71_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_8.prefab_name].transform, "story_v_out_304101", "304101017", "story_v_out_304101.awb")

						arg_68_1:RecordAudio("304101017", var_71_14)
						arg_68_1:RecordAudio("304101017", var_71_14)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_304101", "304101017", "story_v_out_304101.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_304101", "304101017", "story_v_out_304101.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_15 = math.max(var_71_6, arg_68_1.talkMaxDuration)

			if var_71_5 <= arg_68_1.time_ and arg_68_1.time_ < var_71_5 + var_71_15 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_5) / var_71_15

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_5 + var_71_15 and arg_68_1.time_ < var_71_5 + var_71_15 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play304101018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 304101018
		arg_72_1.duration_ = 4.3

		local var_72_0 = {
			zh = 3.8,
			ja = 4.3
		}
		local var_72_1 = manager.audio:GetLocalizationFlag()

		if var_72_0[var_72_1] ~= nil then
			arg_72_1.duration_ = var_72_0[var_72_1]
		end

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play304101019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = 0
			local var_75_1 = 0.3

			if var_75_0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_0 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_2 = arg_72_1:FormatText(StoryNameCfg[8].name)

				arg_72_1.leftNameTxt_.text = var_75_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_3 = arg_72_1:GetWordFromCfg(304101018)
				local var_75_4 = arg_72_1:FormatText(var_75_3.content)

				arg_72_1.text_.text = var_75_4

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_5 = 12
				local var_75_6 = utf8.len(var_75_4)
				local var_75_7 = var_75_5 <= 0 and var_75_1 or var_75_1 * (var_75_6 / var_75_5)

				if var_75_7 > 0 and var_75_1 < var_75_7 then
					arg_72_1.talkMaxDuration = var_75_7

					if var_75_7 + var_75_0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_7 + var_75_0
					end
				end

				arg_72_1.text_.text = var_75_4
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304101", "304101018", "story_v_out_304101.awb") ~= 0 then
					local var_75_8 = manager.audio:GetVoiceLength("story_v_out_304101", "304101018", "story_v_out_304101.awb") / 1000

					if var_75_8 + var_75_0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_8 + var_75_0
					end

					if var_75_3.prefab_name ~= "" and arg_72_1.actors_[var_75_3.prefab_name] ~= nil then
						local var_75_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_3.prefab_name].transform, "story_v_out_304101", "304101018", "story_v_out_304101.awb")

						arg_72_1:RecordAudio("304101018", var_75_9)
						arg_72_1:RecordAudio("304101018", var_75_9)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_304101", "304101018", "story_v_out_304101.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_304101", "304101018", "story_v_out_304101.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_10 = math.max(var_75_1, arg_72_1.talkMaxDuration)

			if var_75_0 <= arg_72_1.time_ and arg_72_1.time_ < var_75_0 + var_75_10 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_0) / var_75_10

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_0 + var_75_10 and arg_72_1.time_ < var_75_0 + var_75_10 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play304101019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 304101019
		arg_76_1.duration_ = 6.73

		local var_76_0 = {
			zh = 3.466,
			ja = 6.733
		}
		local var_76_1 = manager.audio:GetLocalizationFlag()

		if var_76_0[var_76_1] ~= nil then
			arg_76_1.duration_ = var_76_0[var_76_1]
		end

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play304101020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = arg_76_1.actors_["1059ui_story"]
			local var_79_1 = 0

			if var_79_1 < arg_76_1.time_ and arg_76_1.time_ <= var_79_1 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.characterEffect1059ui_story == nil then
				arg_76_1.var_.characterEffect1059ui_story = var_79_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_2 = 0.200000002980232

			if var_79_1 <= arg_76_1.time_ and arg_76_1.time_ < var_79_1 + var_79_2 and not isNil(var_79_0) then
				local var_79_3 = (arg_76_1.time_ - var_79_1) / var_79_2

				if arg_76_1.var_.characterEffect1059ui_story and not isNil(var_79_0) then
					arg_76_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_76_1.time_ >= var_79_1 + var_79_2 and arg_76_1.time_ < var_79_1 + var_79_2 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.characterEffect1059ui_story then
				arg_76_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_79_4 = arg_76_1.actors_["1148ui_story"]
			local var_79_5 = 0

			if var_79_5 < arg_76_1.time_ and arg_76_1.time_ <= var_79_5 + arg_79_0 and not isNil(var_79_4) and arg_76_1.var_.characterEffect1148ui_story == nil then
				arg_76_1.var_.characterEffect1148ui_story = var_79_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_6 = 0.200000002980232

			if var_79_5 <= arg_76_1.time_ and arg_76_1.time_ < var_79_5 + var_79_6 and not isNil(var_79_4) then
				local var_79_7 = (arg_76_1.time_ - var_79_5) / var_79_6

				if arg_76_1.var_.characterEffect1148ui_story and not isNil(var_79_4) then
					local var_79_8 = Mathf.Lerp(0, 0.5, var_79_7)

					arg_76_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_76_1.var_.characterEffect1148ui_story.fillRatio = var_79_8
				end
			end

			if arg_76_1.time_ >= var_79_5 + var_79_6 and arg_76_1.time_ < var_79_5 + var_79_6 + arg_79_0 and not isNil(var_79_4) and arg_76_1.var_.characterEffect1148ui_story then
				local var_79_9 = 0.5

				arg_76_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_76_1.var_.characterEffect1148ui_story.fillRatio = var_79_9
			end

			local var_79_10 = 0
			local var_79_11 = 0.375

			if var_79_10 < arg_76_1.time_ and arg_76_1.time_ <= var_79_10 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				local var_79_12 = arg_76_1:FormatText(StoryNameCfg[28].name)

				arg_76_1.leftNameTxt_.text = var_79_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, true)
				arg_76_1.iconController_:SetSelectedState("hero")

				arg_76_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1059")

				arg_76_1.callingController_:SetSelectedState("normal")

				arg_76_1.keyicon_.color = Color.New(1, 1, 1)
				arg_76_1.icon_.color = Color.New(1, 1, 1)

				local var_79_13 = arg_76_1:GetWordFromCfg(304101019)
				local var_79_14 = arg_76_1:FormatText(var_79_13.content)

				arg_76_1.text_.text = var_79_14

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_15 = 15
				local var_79_16 = utf8.len(var_79_14)
				local var_79_17 = var_79_15 <= 0 and var_79_11 or var_79_11 * (var_79_16 / var_79_15)

				if var_79_17 > 0 and var_79_11 < var_79_17 then
					arg_76_1.talkMaxDuration = var_79_17

					if var_79_17 + var_79_10 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_17 + var_79_10
					end
				end

				arg_76_1.text_.text = var_79_14
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304101", "304101019", "story_v_out_304101.awb") ~= 0 then
					local var_79_18 = manager.audio:GetVoiceLength("story_v_out_304101", "304101019", "story_v_out_304101.awb") / 1000

					if var_79_18 + var_79_10 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_18 + var_79_10
					end

					if var_79_13.prefab_name ~= "" and arg_76_1.actors_[var_79_13.prefab_name] ~= nil then
						local var_79_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_13.prefab_name].transform, "story_v_out_304101", "304101019", "story_v_out_304101.awb")

						arg_76_1:RecordAudio("304101019", var_79_19)
						arg_76_1:RecordAudio("304101019", var_79_19)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_304101", "304101019", "story_v_out_304101.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_304101", "304101019", "story_v_out_304101.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_20 = math.max(var_79_11, arg_76_1.talkMaxDuration)

			if var_79_10 <= arg_76_1.time_ and arg_76_1.time_ < var_79_10 + var_79_20 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_10) / var_79_20

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_10 + var_79_20 and arg_76_1.time_ < var_79_10 + var_79_20 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play304101020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 304101020
		arg_80_1.duration_ = 2

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play304101021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = arg_80_1.actors_["1148ui_story"]
			local var_83_1 = 0

			if var_83_1 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 and not isNil(var_83_0) and arg_80_1.var_.characterEffect1148ui_story == nil then
				arg_80_1.var_.characterEffect1148ui_story = var_83_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_2 = 0.200000002980232

			if var_83_1 <= arg_80_1.time_ and arg_80_1.time_ < var_83_1 + var_83_2 and not isNil(var_83_0) then
				local var_83_3 = (arg_80_1.time_ - var_83_1) / var_83_2

				if arg_80_1.var_.characterEffect1148ui_story and not isNil(var_83_0) then
					arg_80_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_80_1.time_ >= var_83_1 + var_83_2 and arg_80_1.time_ < var_83_1 + var_83_2 + arg_83_0 and not isNil(var_83_0) and arg_80_1.var_.characterEffect1148ui_story then
				arg_80_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_83_4 = arg_80_1.actors_["1059ui_story"]
			local var_83_5 = 0

			if var_83_5 < arg_80_1.time_ and arg_80_1.time_ <= var_83_5 + arg_83_0 and not isNil(var_83_4) and arg_80_1.var_.characterEffect1059ui_story == nil then
				arg_80_1.var_.characterEffect1059ui_story = var_83_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_6 = 0.200000002980232

			if var_83_5 <= arg_80_1.time_ and arg_80_1.time_ < var_83_5 + var_83_6 and not isNil(var_83_4) then
				local var_83_7 = (arg_80_1.time_ - var_83_5) / var_83_6

				if arg_80_1.var_.characterEffect1059ui_story and not isNil(var_83_4) then
					local var_83_8 = Mathf.Lerp(0, 0.5, var_83_7)

					arg_80_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_80_1.var_.characterEffect1059ui_story.fillRatio = var_83_8
				end
			end

			if arg_80_1.time_ >= var_83_5 + var_83_6 and arg_80_1.time_ < var_83_5 + var_83_6 + arg_83_0 and not isNil(var_83_4) and arg_80_1.var_.characterEffect1059ui_story then
				local var_83_9 = 0.5

				arg_80_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_80_1.var_.characterEffect1059ui_story.fillRatio = var_83_9
			end

			local var_83_10 = 0

			if var_83_10 < arg_80_1.time_ and arg_80_1.time_ <= var_83_10 + arg_83_0 then
				arg_80_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action5_2")
			end

			local var_83_11 = 0

			if var_83_11 < arg_80_1.time_ and arg_80_1.time_ <= var_83_11 + arg_83_0 then
				arg_80_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_83_12 = 0
			local var_83_13 = 0.05

			if var_83_12 < arg_80_1.time_ and arg_80_1.time_ <= var_83_12 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				local var_83_14 = arg_80_1:FormatText(StoryNameCfg[8].name)

				arg_80_1.leftNameTxt_.text = var_83_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_15 = arg_80_1:GetWordFromCfg(304101020)
				local var_83_16 = arg_80_1:FormatText(var_83_15.content)

				arg_80_1.text_.text = var_83_16

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_17 = 2
				local var_83_18 = utf8.len(var_83_16)
				local var_83_19 = var_83_17 <= 0 and var_83_13 or var_83_13 * (var_83_18 / var_83_17)

				if var_83_19 > 0 and var_83_13 < var_83_19 then
					arg_80_1.talkMaxDuration = var_83_19

					if var_83_19 + var_83_12 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_19 + var_83_12
					end
				end

				arg_80_1.text_.text = var_83_16
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304101", "304101020", "story_v_out_304101.awb") ~= 0 then
					local var_83_20 = manager.audio:GetVoiceLength("story_v_out_304101", "304101020", "story_v_out_304101.awb") / 1000

					if var_83_20 + var_83_12 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_20 + var_83_12
					end

					if var_83_15.prefab_name ~= "" and arg_80_1.actors_[var_83_15.prefab_name] ~= nil then
						local var_83_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_15.prefab_name].transform, "story_v_out_304101", "304101020", "story_v_out_304101.awb")

						arg_80_1:RecordAudio("304101020", var_83_21)
						arg_80_1:RecordAudio("304101020", var_83_21)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_304101", "304101020", "story_v_out_304101.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_304101", "304101020", "story_v_out_304101.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_22 = math.max(var_83_13, arg_80_1.talkMaxDuration)

			if var_83_12 <= arg_80_1.time_ and arg_80_1.time_ < var_83_12 + var_83_22 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_12) / var_83_22

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_12 + var_83_22 and arg_80_1.time_ < var_83_12 + var_83_22 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play304101021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 304101021
		arg_84_1.duration_ = 6

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play304101022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = arg_84_1.actors_["1148ui_story"].transform
			local var_87_1 = 0

			if var_87_1 < arg_84_1.time_ and arg_84_1.time_ <= var_87_1 + arg_87_0 then
				arg_84_1.var_.moveOldPos1148ui_story = var_87_0.localPosition
			end

			local var_87_2 = 0.001

			if var_87_1 <= arg_84_1.time_ and arg_84_1.time_ < var_87_1 + var_87_2 then
				local var_87_3 = (arg_84_1.time_ - var_87_1) / var_87_2
				local var_87_4 = Vector3.New(0, 100, 0)

				var_87_0.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos1148ui_story, var_87_4, var_87_3)

				local var_87_5 = manager.ui.mainCamera.transform.position - var_87_0.position

				var_87_0.forward = Vector3.New(var_87_5.x, var_87_5.y, var_87_5.z)

				local var_87_6 = var_87_0.localEulerAngles

				var_87_6.z = 0
				var_87_6.x = 0
				var_87_0.localEulerAngles = var_87_6
			end

			if arg_84_1.time_ >= var_87_1 + var_87_2 and arg_84_1.time_ < var_87_1 + var_87_2 + arg_87_0 then
				var_87_0.localPosition = Vector3.New(0, 100, 0)

				local var_87_7 = manager.ui.mainCamera.transform.position - var_87_0.position

				var_87_0.forward = Vector3.New(var_87_7.x, var_87_7.y, var_87_7.z)

				local var_87_8 = var_87_0.localEulerAngles

				var_87_8.z = 0
				var_87_8.x = 0
				var_87_0.localEulerAngles = var_87_8
			end

			local var_87_9 = arg_84_1.actors_["1148ui_story"]
			local var_87_10 = 0

			if var_87_10 < arg_84_1.time_ and arg_84_1.time_ <= var_87_10 + arg_87_0 and not isNil(var_87_9) and arg_84_1.var_.characterEffect1148ui_story == nil then
				arg_84_1.var_.characterEffect1148ui_story = var_87_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_11 = 0.200000002980232

			if var_87_10 <= arg_84_1.time_ and arg_84_1.time_ < var_87_10 + var_87_11 and not isNil(var_87_9) then
				local var_87_12 = (arg_84_1.time_ - var_87_10) / var_87_11

				if arg_84_1.var_.characterEffect1148ui_story and not isNil(var_87_9) then
					local var_87_13 = Mathf.Lerp(0, 0.5, var_87_12)

					arg_84_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_84_1.var_.characterEffect1148ui_story.fillRatio = var_87_13
				end
			end

			if arg_84_1.time_ >= var_87_10 + var_87_11 and arg_84_1.time_ < var_87_10 + var_87_11 + arg_87_0 and not isNil(var_87_9) and arg_84_1.var_.characterEffect1148ui_story then
				local var_87_14 = 0.5

				arg_84_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_84_1.var_.characterEffect1148ui_story.fillRatio = var_87_14
			end

			local var_87_15 = 0.533333333333333

			if var_87_15 < arg_84_1.time_ and arg_84_1.time_ <= var_87_15 + arg_87_0 then
				arg_84_1.mask_.enabled = true
				arg_84_1.mask_.raycastTarget = false

				arg_84_1:SetGaussion(false)
			end

			local var_87_16 = 0.4

			if var_87_15 <= arg_84_1.time_ and arg_84_1.time_ < var_87_15 + var_87_16 then
				local var_87_17 = (arg_84_1.time_ - var_87_15) / var_87_16
				local var_87_18 = Color.New(1, 1, 1)

				var_87_18.a = Mathf.Lerp(1, 0, var_87_17)
				arg_84_1.mask_.color = var_87_18
			end

			if arg_84_1.time_ >= var_87_15 + var_87_16 and arg_84_1.time_ < var_87_15 + var_87_16 + arg_87_0 then
				local var_87_19 = Color.New(1, 1, 1)
				local var_87_20 = 0

				arg_84_1.mask_.enabled = false
				var_87_19.a = var_87_20
				arg_84_1.mask_.color = var_87_19
			end

			local var_87_21 = manager.ui.mainCamera.transform
			local var_87_22 = 0

			if var_87_22 < arg_84_1.time_ and arg_84_1.time_ <= var_87_22 + arg_87_0 then
				local var_87_23 = arg_84_1.var_.effect嗒嘀嗒哒哒
				local var_87_24
				local var_87_25 = var_87_21

				if not var_87_23 then
					var_87_23 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_qiliu2"), var_87_25)
					var_87_23.name = "嗒嘀嗒哒哒"
					arg_84_1.var_.effect嗒嘀嗒哒哒 = var_87_23
				else
					var_87_23.transform:SetParent(var_87_25)
				end

				var_87_23.transform.localPosition = Vector3.New(0, 0, 0)
				var_87_23.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_87_26 = 1.7777777777777777
				local var_87_27 = Screen.width / Screen.height
				local var_87_28 = var_87_27 / var_87_26
				local var_87_29 = Mathf.Max(var_87_26 / var_87_27, 1)

				var_87_23.transform.localScale = Vector3.New(var_87_23.transform.localScale.x * var_87_28, var_87_23.transform.localScale.y * var_87_29, var_87_23.transform.localScale.z)
			end

			local var_87_30 = manager.ui.mainCamera.transform
			local var_87_31 = 0.752989433364322

			if var_87_31 < arg_84_1.time_ and arg_84_1.time_ <= var_87_31 + arg_87_0 then
				local var_87_32 = arg_84_1.var_.effect嗒嘀嗒哒哒

				if var_87_32 then
					Object.Destroy(var_87_32)

					arg_84_1.var_.effect嗒嘀嗒哒哒 = nil
				end
			end

			local var_87_33 = 0

			if var_87_33 < arg_84_1.time_ and arg_84_1.time_ <= var_87_33 + arg_87_0 then
				arg_84_1.allBtn_.enabled = false
			end

			local var_87_34 = 1.43333333333333

			if arg_84_1.time_ >= var_87_33 + var_87_34 and arg_84_1.time_ < var_87_33 + var_87_34 + arg_87_0 then
				arg_84_1.allBtn_.enabled = true
			end

			if arg_84_1.frameCnt_ <= 1 then
				arg_84_1.dialog_:SetActive(false)
			end

			local var_87_35 = 1
			local var_87_36 = 0.925

			if var_87_35 < arg_84_1.time_ and arg_84_1.time_ <= var_87_35 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0

				arg_84_1.dialog_:SetActive(true)

				arg_84_1.dialogCg_.alpha = 0

				local var_87_37 = LeanTween.value(arg_84_1.dialog_, 0, 1, 0.3)

				var_87_37:setOnUpdate(LuaHelper.FloatAction(function(arg_88_0)
					arg_84_1.dialogCg_.alpha = arg_88_0
				end))
				var_87_37:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_84_1.dialog_)
					var_87_37:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_84_1.duration_ = arg_84_1.duration_ + 0.3

				SetActive(arg_84_1.leftNameGo_, false)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_38 = arg_84_1:GetWordFromCfg(304101021)
				local var_87_39 = arg_84_1:FormatText(var_87_38.content)

				arg_84_1.text_.text = var_87_39

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_40 = 37
				local var_87_41 = utf8.len(var_87_39)
				local var_87_42 = var_87_40 <= 0 and var_87_36 or var_87_36 * (var_87_41 / var_87_40)

				if var_87_42 > 0 and var_87_36 < var_87_42 then
					arg_84_1.talkMaxDuration = var_87_42
					var_87_35 = var_87_35 + 0.3

					if var_87_42 + var_87_35 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_42 + var_87_35
					end
				end

				arg_84_1.text_.text = var_87_39
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)
				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_43 = var_87_35 + 0.3
			local var_87_44 = math.max(var_87_36, arg_84_1.talkMaxDuration)

			if var_87_43 <= arg_84_1.time_ and arg_84_1.time_ < var_87_43 + var_87_44 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_43) / var_87_44

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_43 + var_87_44 and arg_84_1.time_ < var_87_43 + var_87_44 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
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
	Play304101022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 304101022
		arg_90_1.duration_ = 6

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play304101023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = manager.ui.mainCamera.transform
			local var_93_1 = 0

			if var_93_1 < arg_90_1.time_ and arg_90_1.time_ <= var_93_1 + arg_93_0 then
				local var_93_2 = arg_90_1.var_.effect热热热
				local var_93_3
				local var_93_4 = var_93_0

				if not var_93_2 then
					var_93_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_xdaoguang"), var_93_4)
					var_93_2.name = "热热热"
					arg_90_1.var_.effect热热热 = var_93_2
				else
					var_93_2.transform:SetParent(var_93_4)
				end

				var_93_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_93_2.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_93_5 = 1.7777777777777777
				local var_93_6 = Screen.width / Screen.height
				local var_93_7 = var_93_6 / var_93_5
				local var_93_8 = Mathf.Max(var_93_5 / var_93_6, 1)

				var_93_2.transform.localScale = Vector3.New(var_93_2.transform.localScale.x * var_93_7, var_93_2.transform.localScale.y * var_93_8, var_93_2.transform.localScale.z)
			end

			local var_93_9 = manager.ui.mainCamera.transform
			local var_93_10 = 1.7

			if var_93_10 < arg_90_1.time_ and arg_90_1.time_ <= var_93_10 + arg_93_0 then
				local var_93_11 = arg_90_1.var_.effect热热热

				if var_93_11 then
					Object.Destroy(var_93_11)

					arg_90_1.var_.effect热热热 = nil
				end
			end

			local var_93_12 = 0

			if var_93_12 < arg_90_1.time_ and arg_90_1.time_ <= var_93_12 + arg_93_0 then
				arg_90_1.allBtn_.enabled = false
			end

			local var_93_13 = 1.1

			if arg_90_1.time_ >= var_93_12 + var_93_13 and arg_90_1.time_ < var_93_12 + var_93_13 + arg_93_0 then
				arg_90_1.allBtn_.enabled = true
			end

			if arg_90_1.frameCnt_ <= 1 then
				arg_90_1.dialog_:SetActive(false)
			end

			local var_93_14 = 1
			local var_93_15 = 1.725

			if var_93_14 < arg_90_1.time_ and arg_90_1.time_ <= var_93_14 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0

				arg_90_1.dialog_:SetActive(true)

				arg_90_1.dialogCg_.alpha = 0

				local var_93_16 = LeanTween.value(arg_90_1.dialog_, 0, 1, 0.3)

				var_93_16:setOnUpdate(LuaHelper.FloatAction(function(arg_94_0)
					arg_90_1.dialogCg_.alpha = arg_94_0
				end))
				var_93_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_90_1.dialog_)
					var_93_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_90_1.duration_ = arg_90_1.duration_ + 0.3

				SetActive(arg_90_1.leftNameGo_, false)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_17 = arg_90_1:GetWordFromCfg(304101022)
				local var_93_18 = arg_90_1:FormatText(var_93_17.content)

				arg_90_1.text_.text = var_93_18

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_19 = 69
				local var_93_20 = utf8.len(var_93_18)
				local var_93_21 = var_93_19 <= 0 and var_93_15 or var_93_15 * (var_93_20 / var_93_19)

				if var_93_21 > 0 and var_93_15 < var_93_21 then
					arg_90_1.talkMaxDuration = var_93_21
					var_93_14 = var_93_14 + 0.3

					if var_93_21 + var_93_14 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_21 + var_93_14
					end
				end

				arg_90_1.text_.text = var_93_18
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)
				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_22 = var_93_14 + 0.3
			local var_93_23 = math.max(var_93_15, arg_90_1.talkMaxDuration)

			if var_93_22 <= arg_90_1.time_ and arg_90_1.time_ < var_93_22 + var_93_23 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_22) / var_93_23

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_22 + var_93_23 and arg_90_1.time_ < var_93_22 + var_93_23 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play304101023 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 304101023
		arg_96_1.duration_ = 4.83

		local var_96_0 = {
			zh = 3.7,
			ja = 4.833
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
				arg_96_0:Play304101024(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = arg_96_1.actors_["1148ui_story"].transform
			local var_99_1 = 0

			if var_99_1 < arg_96_1.time_ and arg_96_1.time_ <= var_99_1 + arg_99_0 then
				arg_96_1.var_.moveOldPos1148ui_story = var_99_0.localPosition
			end

			local var_99_2 = 0.001

			if var_99_1 <= arg_96_1.time_ and arg_96_1.time_ < var_99_1 + var_99_2 then
				local var_99_3 = (arg_96_1.time_ - var_99_1) / var_99_2
				local var_99_4 = Vector3.New(0, -0.8, -6.2)

				var_99_0.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos1148ui_story, var_99_4, var_99_3)

				local var_99_5 = manager.ui.mainCamera.transform.position - var_99_0.position

				var_99_0.forward = Vector3.New(var_99_5.x, var_99_5.y, var_99_5.z)

				local var_99_6 = var_99_0.localEulerAngles

				var_99_6.z = 0
				var_99_6.x = 0
				var_99_0.localEulerAngles = var_99_6
			end

			if arg_96_1.time_ >= var_99_1 + var_99_2 and arg_96_1.time_ < var_99_1 + var_99_2 + arg_99_0 then
				var_99_0.localPosition = Vector3.New(0, -0.8, -6.2)

				local var_99_7 = manager.ui.mainCamera.transform.position - var_99_0.position

				var_99_0.forward = Vector3.New(var_99_7.x, var_99_7.y, var_99_7.z)

				local var_99_8 = var_99_0.localEulerAngles

				var_99_8.z = 0
				var_99_8.x = 0
				var_99_0.localEulerAngles = var_99_8
			end

			local var_99_9 = arg_96_1.actors_["1148ui_story"]
			local var_99_10 = 0

			if var_99_10 < arg_96_1.time_ and arg_96_1.time_ <= var_99_10 + arg_99_0 and not isNil(var_99_9) and arg_96_1.var_.characterEffect1148ui_story == nil then
				arg_96_1.var_.characterEffect1148ui_story = var_99_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_11 = 0.200000002980232

			if var_99_10 <= arg_96_1.time_ and arg_96_1.time_ < var_99_10 + var_99_11 and not isNil(var_99_9) then
				local var_99_12 = (arg_96_1.time_ - var_99_10) / var_99_11

				if arg_96_1.var_.characterEffect1148ui_story and not isNil(var_99_9) then
					arg_96_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_96_1.time_ >= var_99_10 + var_99_11 and arg_96_1.time_ < var_99_10 + var_99_11 + arg_99_0 and not isNil(var_99_9) and arg_96_1.var_.characterEffect1148ui_story then
				arg_96_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_99_13 = 0

			if var_99_13 < arg_96_1.time_ and arg_96_1.time_ <= var_99_13 + arg_99_0 then
				arg_96_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action2_1")
			end

			local var_99_14 = 0

			if var_99_14 < arg_96_1.time_ and arg_96_1.time_ <= var_99_14 + arg_99_0 then
				arg_96_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva", "EmotionTimelineAnimator")
			end

			local var_99_15 = 0
			local var_99_16 = 0.325

			if var_99_15 < arg_96_1.time_ and arg_96_1.time_ <= var_99_15 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				local var_99_17 = arg_96_1:FormatText(StoryNameCfg[8].name)

				arg_96_1.leftNameTxt_.text = var_99_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_18 = arg_96_1:GetWordFromCfg(304101023)
				local var_99_19 = arg_96_1:FormatText(var_99_18.content)

				arg_96_1.text_.text = var_99_19

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_20 = 13
				local var_99_21 = utf8.len(var_99_19)
				local var_99_22 = var_99_20 <= 0 and var_99_16 or var_99_16 * (var_99_21 / var_99_20)

				if var_99_22 > 0 and var_99_16 < var_99_22 then
					arg_96_1.talkMaxDuration = var_99_22

					if var_99_22 + var_99_15 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_22 + var_99_15
					end
				end

				arg_96_1.text_.text = var_99_19
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304101", "304101023", "story_v_out_304101.awb") ~= 0 then
					local var_99_23 = manager.audio:GetVoiceLength("story_v_out_304101", "304101023", "story_v_out_304101.awb") / 1000

					if var_99_23 + var_99_15 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_23 + var_99_15
					end

					if var_99_18.prefab_name ~= "" and arg_96_1.actors_[var_99_18.prefab_name] ~= nil then
						local var_99_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_18.prefab_name].transform, "story_v_out_304101", "304101023", "story_v_out_304101.awb")

						arg_96_1:RecordAudio("304101023", var_99_24)
						arg_96_1:RecordAudio("304101023", var_99_24)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_304101", "304101023", "story_v_out_304101.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_304101", "304101023", "story_v_out_304101.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_25 = math.max(var_99_16, arg_96_1.talkMaxDuration)

			if var_99_15 <= arg_96_1.time_ and arg_96_1.time_ < var_99_15 + var_99_25 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_15) / var_99_25

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_15 + var_99_25 and arg_96_1.time_ < var_99_15 + var_99_25 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_96_1:InitPlayNodeList()
	end,
	Play304101024 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 304101024
		arg_100_1.duration_ = 4.77

		local var_100_0 = {
			zh = 3.733,
			ja = 4.766
		}
		local var_100_1 = manager.audio:GetLocalizationFlag()

		if var_100_0[var_100_1] ~= nil then
			arg_100_1.duration_ = var_100_0[var_100_1]
		end

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play304101025(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = 0

			if var_103_0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_0 + arg_103_0 then
				arg_100_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action425")
			end

			local var_103_1 = 0

			if var_103_1 < arg_100_1.time_ and arg_100_1.time_ <= var_103_1 + arg_103_0 then
				arg_100_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_103_2 = 0
			local var_103_3 = 0.4

			if var_103_2 < arg_100_1.time_ and arg_100_1.time_ <= var_103_2 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				local var_103_4 = arg_100_1:FormatText(StoryNameCfg[8].name)

				arg_100_1.leftNameTxt_.text = var_103_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_5 = arg_100_1:GetWordFromCfg(304101024)
				local var_103_6 = arg_100_1:FormatText(var_103_5.content)

				arg_100_1.text_.text = var_103_6

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_7 = 16
				local var_103_8 = utf8.len(var_103_6)
				local var_103_9 = var_103_7 <= 0 and var_103_3 or var_103_3 * (var_103_8 / var_103_7)

				if var_103_9 > 0 and var_103_3 < var_103_9 then
					arg_100_1.talkMaxDuration = var_103_9

					if var_103_9 + var_103_2 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_9 + var_103_2
					end
				end

				arg_100_1.text_.text = var_103_6
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304101", "304101024", "story_v_out_304101.awb") ~= 0 then
					local var_103_10 = manager.audio:GetVoiceLength("story_v_out_304101", "304101024", "story_v_out_304101.awb") / 1000

					if var_103_10 + var_103_2 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_10 + var_103_2
					end

					if var_103_5.prefab_name ~= "" and arg_100_1.actors_[var_103_5.prefab_name] ~= nil then
						local var_103_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_5.prefab_name].transform, "story_v_out_304101", "304101024", "story_v_out_304101.awb")

						arg_100_1:RecordAudio("304101024", var_103_11)
						arg_100_1:RecordAudio("304101024", var_103_11)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_304101", "304101024", "story_v_out_304101.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_304101", "304101024", "story_v_out_304101.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_12 = math.max(var_103_3, arg_100_1.talkMaxDuration)

			if var_103_2 <= arg_100_1.time_ and arg_100_1.time_ < var_103_2 + var_103_12 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_2) / var_103_12

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_2 + var_103_12 and arg_100_1.time_ < var_103_2 + var_103_12 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play304101025 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 304101025
		arg_104_1.duration_ = 11.2

		local var_104_0 = {
			zh = 6.833,
			ja = 11.2
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
				arg_104_0:Play304101026(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = "1035ui_story"

			if arg_104_1.actors_[var_107_0] == nil then
				local var_107_1 = Asset.Load("Char/" .. "1035ui_story")

				if not isNil(var_107_1) then
					local var_107_2 = Object.Instantiate(Asset.Load("Char/" .. "1035ui_story"), arg_104_1.stage_.transform)

					var_107_2.name = var_107_0
					var_107_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_104_1.actors_[var_107_0] = var_107_2

					local var_107_3 = var_107_2:GetComponentInChildren(typeof(CharacterEffect))

					var_107_3.enabled = true

					local var_107_4 = GameObjectTools.GetOrAddComponent(var_107_2, typeof(DynamicBoneHelper))

					if var_107_4 then
						var_107_4:EnableDynamicBone(false)
					end

					arg_104_1:ShowWeapon(var_107_3.transform, false)

					arg_104_1.var_[var_107_0 .. "Animator"] = var_107_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_104_1.var_[var_107_0 .. "Animator"].applyRootMotion = true
					arg_104_1.var_[var_107_0 .. "LipSync"] = var_107_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_107_5 = arg_104_1.actors_["1035ui_story"].transform
			local var_107_6 = 0

			if var_107_6 < arg_104_1.time_ and arg_104_1.time_ <= var_107_6 + arg_107_0 then
				arg_104_1.var_.moveOldPos1035ui_story = var_107_5.localPosition
			end

			local var_107_7 = 0.001

			if var_107_6 <= arg_104_1.time_ and arg_104_1.time_ < var_107_6 + var_107_7 then
				local var_107_8 = (arg_104_1.time_ - var_107_6) / var_107_7
				local var_107_9 = Vector3.New(0, -1.05, -5.6)

				var_107_5.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos1035ui_story, var_107_9, var_107_8)

				local var_107_10 = manager.ui.mainCamera.transform.position - var_107_5.position

				var_107_5.forward = Vector3.New(var_107_10.x, var_107_10.y, var_107_10.z)

				local var_107_11 = var_107_5.localEulerAngles

				var_107_11.z = 0
				var_107_11.x = 0
				var_107_5.localEulerAngles = var_107_11
			end

			if arg_104_1.time_ >= var_107_6 + var_107_7 and arg_104_1.time_ < var_107_6 + var_107_7 + arg_107_0 then
				var_107_5.localPosition = Vector3.New(0, -1.05, -5.6)

				local var_107_12 = manager.ui.mainCamera.transform.position - var_107_5.position

				var_107_5.forward = Vector3.New(var_107_12.x, var_107_12.y, var_107_12.z)

				local var_107_13 = var_107_5.localEulerAngles

				var_107_13.z = 0
				var_107_13.x = 0
				var_107_5.localEulerAngles = var_107_13
			end

			local var_107_14 = arg_104_1.actors_["1148ui_story"].transform
			local var_107_15 = 0

			if var_107_15 < arg_104_1.time_ and arg_104_1.time_ <= var_107_15 + arg_107_0 then
				arg_104_1.var_.moveOldPos1148ui_story = var_107_14.localPosition
			end

			local var_107_16 = 0.001

			if var_107_15 <= arg_104_1.time_ and arg_104_1.time_ < var_107_15 + var_107_16 then
				local var_107_17 = (arg_104_1.time_ - var_107_15) / var_107_16
				local var_107_18 = Vector3.New(0, 100, 0)

				var_107_14.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos1148ui_story, var_107_18, var_107_17)

				local var_107_19 = manager.ui.mainCamera.transform.position - var_107_14.position

				var_107_14.forward = Vector3.New(var_107_19.x, var_107_19.y, var_107_19.z)

				local var_107_20 = var_107_14.localEulerAngles

				var_107_20.z = 0
				var_107_20.x = 0
				var_107_14.localEulerAngles = var_107_20
			end

			if arg_104_1.time_ >= var_107_15 + var_107_16 and arg_104_1.time_ < var_107_15 + var_107_16 + arg_107_0 then
				var_107_14.localPosition = Vector3.New(0, 100, 0)

				local var_107_21 = manager.ui.mainCamera.transform.position - var_107_14.position

				var_107_14.forward = Vector3.New(var_107_21.x, var_107_21.y, var_107_21.z)

				local var_107_22 = var_107_14.localEulerAngles

				var_107_22.z = 0
				var_107_22.x = 0
				var_107_14.localEulerAngles = var_107_22
			end

			local var_107_23 = arg_104_1.actors_["1035ui_story"]
			local var_107_24 = 0

			if var_107_24 < arg_104_1.time_ and arg_104_1.time_ <= var_107_24 + arg_107_0 and not isNil(var_107_23) and arg_104_1.var_.characterEffect1035ui_story == nil then
				arg_104_1.var_.characterEffect1035ui_story = var_107_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_25 = 0.200000002980232

			if var_107_24 <= arg_104_1.time_ and arg_104_1.time_ < var_107_24 + var_107_25 and not isNil(var_107_23) then
				local var_107_26 = (arg_104_1.time_ - var_107_24) / var_107_25

				if arg_104_1.var_.characterEffect1035ui_story and not isNil(var_107_23) then
					arg_104_1.var_.characterEffect1035ui_story.fillFlat = false
				end
			end

			if arg_104_1.time_ >= var_107_24 + var_107_25 and arg_104_1.time_ < var_107_24 + var_107_25 + arg_107_0 and not isNil(var_107_23) and arg_104_1.var_.characterEffect1035ui_story then
				arg_104_1.var_.characterEffect1035ui_story.fillFlat = false
			end

			local var_107_27 = arg_104_1.actors_["1148ui_story"]
			local var_107_28 = 0

			if var_107_28 < arg_104_1.time_ and arg_104_1.time_ <= var_107_28 + arg_107_0 and not isNil(var_107_27) and arg_104_1.var_.characterEffect1148ui_story == nil then
				arg_104_1.var_.characterEffect1148ui_story = var_107_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_29 = 0.200000002980232

			if var_107_28 <= arg_104_1.time_ and arg_104_1.time_ < var_107_28 + var_107_29 and not isNil(var_107_27) then
				local var_107_30 = (arg_104_1.time_ - var_107_28) / var_107_29

				if arg_104_1.var_.characterEffect1148ui_story and not isNil(var_107_27) then
					local var_107_31 = Mathf.Lerp(0, 0.5, var_107_30)

					arg_104_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_104_1.var_.characterEffect1148ui_story.fillRatio = var_107_31
				end
			end

			if arg_104_1.time_ >= var_107_28 + var_107_29 and arg_104_1.time_ < var_107_28 + var_107_29 + arg_107_0 and not isNil(var_107_27) and arg_104_1.var_.characterEffect1148ui_story then
				local var_107_32 = 0.5

				arg_104_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_104_1.var_.characterEffect1148ui_story.fillRatio = var_107_32
			end

			local var_107_33 = 0

			if var_107_33 < arg_104_1.time_ and arg_104_1.time_ <= var_107_33 + arg_107_0 then
				arg_104_1:PlayTimeline("1035ui_story", "StoryTimeline/CharAction/story1035/story1035action/1035action6_1")
			end

			local var_107_34 = 0

			if var_107_34 < arg_104_1.time_ and arg_104_1.time_ <= var_107_34 + arg_107_0 then
				arg_104_1:PlayTimeline("1035ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_107_35 = 0
			local var_107_36 = 0.9

			if var_107_35 < arg_104_1.time_ and arg_104_1.time_ <= var_107_35 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				local var_107_37 = arg_104_1:FormatText(StoryNameCfg[21].name)

				arg_104_1.leftNameTxt_.text = var_107_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_38 = arg_104_1:GetWordFromCfg(304101025)
				local var_107_39 = arg_104_1:FormatText(var_107_38.content)

				arg_104_1.text_.text = var_107_39

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_40 = 36
				local var_107_41 = utf8.len(var_107_39)
				local var_107_42 = var_107_40 <= 0 and var_107_36 or var_107_36 * (var_107_41 / var_107_40)

				if var_107_42 > 0 and var_107_36 < var_107_42 then
					arg_104_1.talkMaxDuration = var_107_42

					if var_107_42 + var_107_35 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_42 + var_107_35
					end
				end

				arg_104_1.text_.text = var_107_39
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304101", "304101025", "story_v_out_304101.awb") ~= 0 then
					local var_107_43 = manager.audio:GetVoiceLength("story_v_out_304101", "304101025", "story_v_out_304101.awb") / 1000

					if var_107_43 + var_107_35 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_43 + var_107_35
					end

					if var_107_38.prefab_name ~= "" and arg_104_1.actors_[var_107_38.prefab_name] ~= nil then
						local var_107_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_38.prefab_name].transform, "story_v_out_304101", "304101025", "story_v_out_304101.awb")

						arg_104_1:RecordAudio("304101025", var_107_44)
						arg_104_1:RecordAudio("304101025", var_107_44)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_304101", "304101025", "story_v_out_304101.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_304101", "304101025", "story_v_out_304101.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_45 = math.max(var_107_36, arg_104_1.talkMaxDuration)

			if var_107_35 <= arg_104_1.time_ and arg_104_1.time_ < var_107_35 + var_107_45 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_35) / var_107_45

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_35 + var_107_45 and arg_104_1.time_ < var_107_35 + var_107_45 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1035ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1148ui_story",
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
	Play304101026 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 304101026
		arg_108_1.duration_ = 5.7

		local var_108_0 = {
			zh = 5.7,
			ja = 5.233
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
				arg_108_0:Play304101027(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = 0
			local var_111_1 = 0.75

			if var_111_0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_0 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				local var_111_2 = arg_108_1:FormatText(StoryNameCfg[21].name)

				arg_108_1.leftNameTxt_.text = var_111_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_3 = arg_108_1:GetWordFromCfg(304101026)
				local var_111_4 = arg_108_1:FormatText(var_111_3.content)

				arg_108_1.text_.text = var_111_4

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_5 = 30
				local var_111_6 = utf8.len(var_111_4)
				local var_111_7 = var_111_5 <= 0 and var_111_1 or var_111_1 * (var_111_6 / var_111_5)

				if var_111_7 > 0 and var_111_1 < var_111_7 then
					arg_108_1.talkMaxDuration = var_111_7

					if var_111_7 + var_111_0 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_7 + var_111_0
					end
				end

				arg_108_1.text_.text = var_111_4
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304101", "304101026", "story_v_out_304101.awb") ~= 0 then
					local var_111_8 = manager.audio:GetVoiceLength("story_v_out_304101", "304101026", "story_v_out_304101.awb") / 1000

					if var_111_8 + var_111_0 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_8 + var_111_0
					end

					if var_111_3.prefab_name ~= "" and arg_108_1.actors_[var_111_3.prefab_name] ~= nil then
						local var_111_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_3.prefab_name].transform, "story_v_out_304101", "304101026", "story_v_out_304101.awb")

						arg_108_1:RecordAudio("304101026", var_111_9)
						arg_108_1:RecordAudio("304101026", var_111_9)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_304101", "304101026", "story_v_out_304101.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_304101", "304101026", "story_v_out_304101.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_10 = math.max(var_111_1, arg_108_1.talkMaxDuration)

			if var_111_0 <= arg_108_1.time_ and arg_108_1.time_ < var_111_0 + var_111_10 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_0) / var_111_10

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_0 + var_111_10 and arg_108_1.time_ < var_111_0 + var_111_10 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play304101027 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 304101027
		arg_112_1.duration_ = 5.33

		local var_112_0 = {
			zh = 4,
			ja = 5.333
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
				arg_112_0:Play304101028(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = arg_112_1.actors_["1035ui_story"].transform
			local var_115_1 = 0

			if var_115_1 < arg_112_1.time_ and arg_112_1.time_ <= var_115_1 + arg_115_0 then
				arg_112_1.var_.moveOldPos1035ui_story = var_115_0.localPosition
			end

			local var_115_2 = 0.001

			if var_115_1 <= arg_112_1.time_ and arg_112_1.time_ < var_115_1 + var_115_2 then
				local var_115_3 = (arg_112_1.time_ - var_115_1) / var_115_2
				local var_115_4 = Vector3.New(0, 100, 0)

				var_115_0.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos1035ui_story, var_115_4, var_115_3)

				local var_115_5 = manager.ui.mainCamera.transform.position - var_115_0.position

				var_115_0.forward = Vector3.New(var_115_5.x, var_115_5.y, var_115_5.z)

				local var_115_6 = var_115_0.localEulerAngles

				var_115_6.z = 0
				var_115_6.x = 0
				var_115_0.localEulerAngles = var_115_6
			end

			if arg_112_1.time_ >= var_115_1 + var_115_2 and arg_112_1.time_ < var_115_1 + var_115_2 + arg_115_0 then
				var_115_0.localPosition = Vector3.New(0, 100, 0)

				local var_115_7 = manager.ui.mainCamera.transform.position - var_115_0.position

				var_115_0.forward = Vector3.New(var_115_7.x, var_115_7.y, var_115_7.z)

				local var_115_8 = var_115_0.localEulerAngles

				var_115_8.z = 0
				var_115_8.x = 0
				var_115_0.localEulerAngles = var_115_8
			end

			local var_115_9 = arg_112_1.actors_["1148ui_story"].transform
			local var_115_10 = 0

			if var_115_10 < arg_112_1.time_ and arg_112_1.time_ <= var_115_10 + arg_115_0 then
				arg_112_1.var_.moveOldPos1148ui_story = var_115_9.localPosition
			end

			local var_115_11 = 0.001

			if var_115_10 <= arg_112_1.time_ and arg_112_1.time_ < var_115_10 + var_115_11 then
				local var_115_12 = (arg_112_1.time_ - var_115_10) / var_115_11
				local var_115_13 = Vector3.New(-0.7, -0.8, -6.2)

				var_115_9.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos1148ui_story, var_115_13, var_115_12)

				local var_115_14 = manager.ui.mainCamera.transform.position - var_115_9.position

				var_115_9.forward = Vector3.New(var_115_14.x, var_115_14.y, var_115_14.z)

				local var_115_15 = var_115_9.localEulerAngles

				var_115_15.z = 0
				var_115_15.x = 0
				var_115_9.localEulerAngles = var_115_15
			end

			if arg_112_1.time_ >= var_115_10 + var_115_11 and arg_112_1.time_ < var_115_10 + var_115_11 + arg_115_0 then
				var_115_9.localPosition = Vector3.New(-0.7, -0.8, -6.2)

				local var_115_16 = manager.ui.mainCamera.transform.position - var_115_9.position

				var_115_9.forward = Vector3.New(var_115_16.x, var_115_16.y, var_115_16.z)

				local var_115_17 = var_115_9.localEulerAngles

				var_115_17.z = 0
				var_115_17.x = 0
				var_115_9.localEulerAngles = var_115_17
			end

			local var_115_18 = arg_112_1.actors_["1148ui_story"]
			local var_115_19 = 0

			if var_115_19 < arg_112_1.time_ and arg_112_1.time_ <= var_115_19 + arg_115_0 and not isNil(var_115_18) and arg_112_1.var_.characterEffect1148ui_story == nil then
				arg_112_1.var_.characterEffect1148ui_story = var_115_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_20 = 0.200000002980232

			if var_115_19 <= arg_112_1.time_ and arg_112_1.time_ < var_115_19 + var_115_20 and not isNil(var_115_18) then
				local var_115_21 = (arg_112_1.time_ - var_115_19) / var_115_20

				if arg_112_1.var_.characterEffect1148ui_story and not isNil(var_115_18) then
					arg_112_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_112_1.time_ >= var_115_19 + var_115_20 and arg_112_1.time_ < var_115_19 + var_115_20 + arg_115_0 and not isNil(var_115_18) and arg_112_1.var_.characterEffect1148ui_story then
				arg_112_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_115_22 = arg_112_1.actors_["1035ui_story"]
			local var_115_23 = 0

			if var_115_23 < arg_112_1.time_ and arg_112_1.time_ <= var_115_23 + arg_115_0 and not isNil(var_115_22) and arg_112_1.var_.characterEffect1035ui_story == nil then
				arg_112_1.var_.characterEffect1035ui_story = var_115_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_24 = 0.200000002980232

			if var_115_23 <= arg_112_1.time_ and arg_112_1.time_ < var_115_23 + var_115_24 and not isNil(var_115_22) then
				local var_115_25 = (arg_112_1.time_ - var_115_23) / var_115_24

				if arg_112_1.var_.characterEffect1035ui_story and not isNil(var_115_22) then
					local var_115_26 = Mathf.Lerp(0, 0.5, var_115_25)

					arg_112_1.var_.characterEffect1035ui_story.fillFlat = true
					arg_112_1.var_.characterEffect1035ui_story.fillRatio = var_115_26
				end
			end

			if arg_112_1.time_ >= var_115_23 + var_115_24 and arg_112_1.time_ < var_115_23 + var_115_24 + arg_115_0 and not isNil(var_115_22) and arg_112_1.var_.characterEffect1035ui_story then
				local var_115_27 = 0.5

				arg_112_1.var_.characterEffect1035ui_story.fillFlat = true
				arg_112_1.var_.characterEffect1035ui_story.fillRatio = var_115_27
			end

			local var_115_28 = 0

			if var_115_28 < arg_112_1.time_ and arg_112_1.time_ <= var_115_28 + arg_115_0 then
				arg_112_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action5_2")
			end

			local var_115_29 = 0

			if var_115_29 < arg_112_1.time_ and arg_112_1.time_ <= var_115_29 + arg_115_0 then
				arg_112_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_115_30 = 0
			local var_115_31 = 0.3

			if var_115_30 < arg_112_1.time_ and arg_112_1.time_ <= var_115_30 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				local var_115_32 = arg_112_1:FormatText(StoryNameCfg[8].name)

				arg_112_1.leftNameTxt_.text = var_115_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_33 = arg_112_1:GetWordFromCfg(304101027)
				local var_115_34 = arg_112_1:FormatText(var_115_33.content)

				arg_112_1.text_.text = var_115_34

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_35 = 12
				local var_115_36 = utf8.len(var_115_34)
				local var_115_37 = var_115_35 <= 0 and var_115_31 or var_115_31 * (var_115_36 / var_115_35)

				if var_115_37 > 0 and var_115_31 < var_115_37 then
					arg_112_1.talkMaxDuration = var_115_37

					if var_115_37 + var_115_30 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_37 + var_115_30
					end
				end

				arg_112_1.text_.text = var_115_34
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304101", "304101027", "story_v_out_304101.awb") ~= 0 then
					local var_115_38 = manager.audio:GetVoiceLength("story_v_out_304101", "304101027", "story_v_out_304101.awb") / 1000

					if var_115_38 + var_115_30 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_38 + var_115_30
					end

					if var_115_33.prefab_name ~= "" and arg_112_1.actors_[var_115_33.prefab_name] ~= nil then
						local var_115_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_33.prefab_name].transform, "story_v_out_304101", "304101027", "story_v_out_304101.awb")

						arg_112_1:RecordAudio("304101027", var_115_39)
						arg_112_1:RecordAudio("304101027", var_115_39)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_304101", "304101027", "story_v_out_304101.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_304101", "304101027", "story_v_out_304101.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_40 = math.max(var_115_31, arg_112_1.talkMaxDuration)

			if var_115_30 <= arg_112_1.time_ and arg_112_1.time_ < var_115_30 + var_115_40 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_30) / var_115_40

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_30 + var_115_40 and arg_112_1.time_ < var_115_30 + var_115_40 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1035ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_112_1:InitPlayNodeList()
	end,
	Play304101028 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 304101028
		arg_116_1.duration_ = 4.73

		local var_116_0 = {
			zh = 4.733,
			ja = 4.233
		}
		local var_116_1 = manager.audio:GetLocalizationFlag()

		if var_116_0[var_116_1] ~= nil then
			arg_116_1.duration_ = var_116_0[var_116_1]
		end

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play304101029(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = 0
			local var_119_1 = 0.475

			if var_119_0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_0 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				local var_119_2 = arg_116_1:FormatText(StoryNameCfg[8].name)

				arg_116_1.leftNameTxt_.text = var_119_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_3 = arg_116_1:GetWordFromCfg(304101028)
				local var_119_4 = arg_116_1:FormatText(var_119_3.content)

				arg_116_1.text_.text = var_119_4

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_5 = 19
				local var_119_6 = utf8.len(var_119_4)
				local var_119_7 = var_119_5 <= 0 and var_119_1 or var_119_1 * (var_119_6 / var_119_5)

				if var_119_7 > 0 and var_119_1 < var_119_7 then
					arg_116_1.talkMaxDuration = var_119_7

					if var_119_7 + var_119_0 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_7 + var_119_0
					end
				end

				arg_116_1.text_.text = var_119_4
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304101", "304101028", "story_v_out_304101.awb") ~= 0 then
					local var_119_8 = manager.audio:GetVoiceLength("story_v_out_304101", "304101028", "story_v_out_304101.awb") / 1000

					if var_119_8 + var_119_0 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_8 + var_119_0
					end

					if var_119_3.prefab_name ~= "" and arg_116_1.actors_[var_119_3.prefab_name] ~= nil then
						local var_119_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_3.prefab_name].transform, "story_v_out_304101", "304101028", "story_v_out_304101.awb")

						arg_116_1:RecordAudio("304101028", var_119_9)
						arg_116_1:RecordAudio("304101028", var_119_9)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_304101", "304101028", "story_v_out_304101.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_304101", "304101028", "story_v_out_304101.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_10 = math.max(var_119_1, arg_116_1.talkMaxDuration)

			if var_119_0 <= arg_116_1.time_ and arg_116_1.time_ < var_119_0 + var_119_10 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_0) / var_119_10

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_0 + var_119_10 and arg_116_1.time_ < var_119_0 + var_119_10 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play304101029 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 304101029
		arg_120_1.duration_ = 5

		local var_120_0 = {
			zh = 3.466,
			ja = 5
		}
		local var_120_1 = manager.audio:GetLocalizationFlag()

		if var_120_0[var_120_1] ~= nil then
			arg_120_1.duration_ = var_120_0[var_120_1]
		end

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play304101030(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = arg_120_1.actors_["1035ui_story"].transform
			local var_123_1 = 0

			if var_123_1 < arg_120_1.time_ and arg_120_1.time_ <= var_123_1 + arg_123_0 then
				arg_120_1.var_.moveOldPos1035ui_story = var_123_0.localPosition
			end

			local var_123_2 = 0.001

			if var_123_1 <= arg_120_1.time_ and arg_120_1.time_ < var_123_1 + var_123_2 then
				local var_123_3 = (arg_120_1.time_ - var_123_1) / var_123_2
				local var_123_4 = Vector3.New(0, 100, 0)

				var_123_0.localPosition = Vector3.Lerp(arg_120_1.var_.moveOldPos1035ui_story, var_123_4, var_123_3)

				local var_123_5 = manager.ui.mainCamera.transform.position - var_123_0.position

				var_123_0.forward = Vector3.New(var_123_5.x, var_123_5.y, var_123_5.z)

				local var_123_6 = var_123_0.localEulerAngles

				var_123_6.z = 0
				var_123_6.x = 0
				var_123_0.localEulerAngles = var_123_6
			end

			if arg_120_1.time_ >= var_123_1 + var_123_2 and arg_120_1.time_ < var_123_1 + var_123_2 + arg_123_0 then
				var_123_0.localPosition = Vector3.New(0, 100, 0)

				local var_123_7 = manager.ui.mainCamera.transform.position - var_123_0.position

				var_123_0.forward = Vector3.New(var_123_7.x, var_123_7.y, var_123_7.z)

				local var_123_8 = var_123_0.localEulerAngles

				var_123_8.z = 0
				var_123_8.x = 0
				var_123_0.localEulerAngles = var_123_8
			end

			local var_123_9 = arg_120_1.actors_["1059ui_story"].transform
			local var_123_10 = 0

			if var_123_10 < arg_120_1.time_ and arg_120_1.time_ <= var_123_10 + arg_123_0 then
				arg_120_1.var_.moveOldPos1059ui_story = var_123_9.localPosition
			end

			local var_123_11 = 0.001

			if var_123_10 <= arg_120_1.time_ and arg_120_1.time_ < var_123_10 + var_123_11 then
				local var_123_12 = (arg_120_1.time_ - var_123_10) / var_123_11
				local var_123_13 = Vector3.New(0.7, -1.05, -6)

				var_123_9.localPosition = Vector3.Lerp(arg_120_1.var_.moveOldPos1059ui_story, var_123_13, var_123_12)

				local var_123_14 = manager.ui.mainCamera.transform.position - var_123_9.position

				var_123_9.forward = Vector3.New(var_123_14.x, var_123_14.y, var_123_14.z)

				local var_123_15 = var_123_9.localEulerAngles

				var_123_15.z = 0
				var_123_15.x = 0
				var_123_9.localEulerAngles = var_123_15
			end

			if arg_120_1.time_ >= var_123_10 + var_123_11 and arg_120_1.time_ < var_123_10 + var_123_11 + arg_123_0 then
				var_123_9.localPosition = Vector3.New(0.7, -1.05, -6)

				local var_123_16 = manager.ui.mainCamera.transform.position - var_123_9.position

				var_123_9.forward = Vector3.New(var_123_16.x, var_123_16.y, var_123_16.z)

				local var_123_17 = var_123_9.localEulerAngles

				var_123_17.z = 0
				var_123_17.x = 0
				var_123_9.localEulerAngles = var_123_17
			end

			local var_123_18 = arg_120_1.actors_["1059ui_story"]
			local var_123_19 = 0

			if var_123_19 < arg_120_1.time_ and arg_120_1.time_ <= var_123_19 + arg_123_0 and not isNil(var_123_18) and arg_120_1.var_.characterEffect1059ui_story == nil then
				arg_120_1.var_.characterEffect1059ui_story = var_123_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_20 = 0.200000002980232

			if var_123_19 <= arg_120_1.time_ and arg_120_1.time_ < var_123_19 + var_123_20 and not isNil(var_123_18) then
				local var_123_21 = (arg_120_1.time_ - var_123_19) / var_123_20

				if arg_120_1.var_.characterEffect1059ui_story and not isNil(var_123_18) then
					arg_120_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_120_1.time_ >= var_123_19 + var_123_20 and arg_120_1.time_ < var_123_19 + var_123_20 + arg_123_0 and not isNil(var_123_18) and arg_120_1.var_.characterEffect1059ui_story then
				arg_120_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_123_22 = arg_120_1.actors_["1148ui_story"]
			local var_123_23 = 0

			if var_123_23 < arg_120_1.time_ and arg_120_1.time_ <= var_123_23 + arg_123_0 and not isNil(var_123_22) and arg_120_1.var_.characterEffect1148ui_story == nil then
				arg_120_1.var_.characterEffect1148ui_story = var_123_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_24 = 0.200000002980232

			if var_123_23 <= arg_120_1.time_ and arg_120_1.time_ < var_123_23 + var_123_24 and not isNil(var_123_22) then
				local var_123_25 = (arg_120_1.time_ - var_123_23) / var_123_24

				if arg_120_1.var_.characterEffect1148ui_story and not isNil(var_123_22) then
					local var_123_26 = Mathf.Lerp(0, 0.5, var_123_25)

					arg_120_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_120_1.var_.characterEffect1148ui_story.fillRatio = var_123_26
				end
			end

			if arg_120_1.time_ >= var_123_23 + var_123_24 and arg_120_1.time_ < var_123_23 + var_123_24 + arg_123_0 and not isNil(var_123_22) and arg_120_1.var_.characterEffect1148ui_story then
				local var_123_27 = 0.5

				arg_120_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_120_1.var_.characterEffect1148ui_story.fillRatio = var_123_27
			end

			local var_123_28 = 0

			if var_123_28 < arg_120_1.time_ and arg_120_1.time_ <= var_123_28 + arg_123_0 then
				arg_120_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action7_2")
			end

			local var_123_29 = 0

			if var_123_29 < arg_120_1.time_ and arg_120_1.time_ <= var_123_29 + arg_123_0 then
				arg_120_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_123_30 = 0
			local var_123_31 = 0.375

			if var_123_30 < arg_120_1.time_ and arg_120_1.time_ <= var_123_30 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				local var_123_32 = arg_120_1:FormatText(StoryNameCfg[28].name)

				arg_120_1.leftNameTxt_.text = var_123_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_33 = arg_120_1:GetWordFromCfg(304101029)
				local var_123_34 = arg_120_1:FormatText(var_123_33.content)

				arg_120_1.text_.text = var_123_34

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_35 = 15
				local var_123_36 = utf8.len(var_123_34)
				local var_123_37 = var_123_35 <= 0 and var_123_31 or var_123_31 * (var_123_36 / var_123_35)

				if var_123_37 > 0 and var_123_31 < var_123_37 then
					arg_120_1.talkMaxDuration = var_123_37

					if var_123_37 + var_123_30 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_37 + var_123_30
					end
				end

				arg_120_1.text_.text = var_123_34
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304101", "304101029", "story_v_out_304101.awb") ~= 0 then
					local var_123_38 = manager.audio:GetVoiceLength("story_v_out_304101", "304101029", "story_v_out_304101.awb") / 1000

					if var_123_38 + var_123_30 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_38 + var_123_30
					end

					if var_123_33.prefab_name ~= "" and arg_120_1.actors_[var_123_33.prefab_name] ~= nil then
						local var_123_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_33.prefab_name].transform, "story_v_out_304101", "304101029", "story_v_out_304101.awb")

						arg_120_1:RecordAudio("304101029", var_123_39)
						arg_120_1:RecordAudio("304101029", var_123_39)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_304101", "304101029", "story_v_out_304101.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_304101", "304101029", "story_v_out_304101.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_40 = math.max(var_123_31, arg_120_1.talkMaxDuration)

			if var_123_30 <= arg_120_1.time_ and arg_120_1.time_ < var_123_30 + var_123_40 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_30) / var_123_40

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_30 + var_123_40 and arg_120_1.time_ < var_123_30 + var_123_40 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1035ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_120_1:InitPlayNodeList()
	end,
	Play304101030 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 304101030
		arg_124_1.duration_ = 4.03

		local var_124_0 = {
			zh = 3.266,
			ja = 4.033
		}
		local var_124_1 = manager.audio:GetLocalizationFlag()

		if var_124_0[var_124_1] ~= nil then
			arg_124_1.duration_ = var_124_0[var_124_1]
		end

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play304101031(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = arg_124_1.actors_["1148ui_story"]
			local var_127_1 = 0

			if var_127_1 < arg_124_1.time_ and arg_124_1.time_ <= var_127_1 + arg_127_0 and not isNil(var_127_0) and arg_124_1.var_.characterEffect1148ui_story == nil then
				arg_124_1.var_.characterEffect1148ui_story = var_127_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_2 = 0.200000002980232

			if var_127_1 <= arg_124_1.time_ and arg_124_1.time_ < var_127_1 + var_127_2 and not isNil(var_127_0) then
				local var_127_3 = (arg_124_1.time_ - var_127_1) / var_127_2

				if arg_124_1.var_.characterEffect1148ui_story and not isNil(var_127_0) then
					arg_124_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_124_1.time_ >= var_127_1 + var_127_2 and arg_124_1.time_ < var_127_1 + var_127_2 + arg_127_0 and not isNil(var_127_0) and arg_124_1.var_.characterEffect1148ui_story then
				arg_124_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_127_4 = arg_124_1.actors_["1059ui_story"]
			local var_127_5 = 0

			if var_127_5 < arg_124_1.time_ and arg_124_1.time_ <= var_127_5 + arg_127_0 and not isNil(var_127_4) and arg_124_1.var_.characterEffect1059ui_story == nil then
				arg_124_1.var_.characterEffect1059ui_story = var_127_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_6 = 0.200000002980232

			if var_127_5 <= arg_124_1.time_ and arg_124_1.time_ < var_127_5 + var_127_6 and not isNil(var_127_4) then
				local var_127_7 = (arg_124_1.time_ - var_127_5) / var_127_6

				if arg_124_1.var_.characterEffect1059ui_story and not isNil(var_127_4) then
					local var_127_8 = Mathf.Lerp(0, 0.5, var_127_7)

					arg_124_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_124_1.var_.characterEffect1059ui_story.fillRatio = var_127_8
				end
			end

			if arg_124_1.time_ >= var_127_5 + var_127_6 and arg_124_1.time_ < var_127_5 + var_127_6 + arg_127_0 and not isNil(var_127_4) and arg_124_1.var_.characterEffect1059ui_story then
				local var_127_9 = 0.5

				arg_124_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_124_1.var_.characterEffect1059ui_story.fillRatio = var_127_9
			end

			local var_127_10 = 0

			if var_127_10 < arg_124_1.time_ and arg_124_1.time_ <= var_127_10 + arg_127_0 then
				arg_124_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action4_1")
			end

			local var_127_11 = 0

			if var_127_11 < arg_124_1.time_ and arg_124_1.time_ <= var_127_11 + arg_127_0 then
				arg_124_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_127_12 = 0
			local var_127_13 = 0.4

			if var_127_12 < arg_124_1.time_ and arg_124_1.time_ <= var_127_12 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				local var_127_14 = arg_124_1:FormatText(StoryNameCfg[8].name)

				arg_124_1.leftNameTxt_.text = var_127_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_15 = arg_124_1:GetWordFromCfg(304101030)
				local var_127_16 = arg_124_1:FormatText(var_127_15.content)

				arg_124_1.text_.text = var_127_16

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_17 = 16
				local var_127_18 = utf8.len(var_127_16)
				local var_127_19 = var_127_17 <= 0 and var_127_13 or var_127_13 * (var_127_18 / var_127_17)

				if var_127_19 > 0 and var_127_13 < var_127_19 then
					arg_124_1.talkMaxDuration = var_127_19

					if var_127_19 + var_127_12 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_19 + var_127_12
					end
				end

				arg_124_1.text_.text = var_127_16
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304101", "304101030", "story_v_out_304101.awb") ~= 0 then
					local var_127_20 = manager.audio:GetVoiceLength("story_v_out_304101", "304101030", "story_v_out_304101.awb") / 1000

					if var_127_20 + var_127_12 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_20 + var_127_12
					end

					if var_127_15.prefab_name ~= "" and arg_124_1.actors_[var_127_15.prefab_name] ~= nil then
						local var_127_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_15.prefab_name].transform, "story_v_out_304101", "304101030", "story_v_out_304101.awb")

						arg_124_1:RecordAudio("304101030", var_127_21)
						arg_124_1:RecordAudio("304101030", var_127_21)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_304101", "304101030", "story_v_out_304101.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_304101", "304101030", "story_v_out_304101.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_22 = math.max(var_127_13, arg_124_1.talkMaxDuration)

			if var_127_12 <= arg_124_1.time_ and arg_124_1.time_ < var_127_12 + var_127_22 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_12) / var_127_22

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_12 + var_127_22 and arg_124_1.time_ < var_127_12 + var_127_22 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play304101031 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 304101031
		arg_128_1.duration_ = 6.23

		local var_128_0 = {
			zh = 4.033,
			ja = 6.233
		}
		local var_128_1 = manager.audio:GetLocalizationFlag()

		if var_128_0[var_128_1] ~= nil then
			arg_128_1.duration_ = var_128_0[var_128_1]
		end

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play304101032(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = arg_128_1.actors_["1059ui_story"]
			local var_131_1 = 0

			if var_131_1 < arg_128_1.time_ and arg_128_1.time_ <= var_131_1 + arg_131_0 and not isNil(var_131_0) and arg_128_1.var_.characterEffect1059ui_story == nil then
				arg_128_1.var_.characterEffect1059ui_story = var_131_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_2 = 0.200000002980232

			if var_131_1 <= arg_128_1.time_ and arg_128_1.time_ < var_131_1 + var_131_2 and not isNil(var_131_0) then
				local var_131_3 = (arg_128_1.time_ - var_131_1) / var_131_2

				if arg_128_1.var_.characterEffect1059ui_story and not isNil(var_131_0) then
					arg_128_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_128_1.time_ >= var_131_1 + var_131_2 and arg_128_1.time_ < var_131_1 + var_131_2 + arg_131_0 and not isNil(var_131_0) and arg_128_1.var_.characterEffect1059ui_story then
				arg_128_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_131_4 = arg_128_1.actors_["1148ui_story"]
			local var_131_5 = 0

			if var_131_5 < arg_128_1.time_ and arg_128_1.time_ <= var_131_5 + arg_131_0 and not isNil(var_131_4) and arg_128_1.var_.characterEffect1148ui_story == nil then
				arg_128_1.var_.characterEffect1148ui_story = var_131_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_6 = 0.200000002980232

			if var_131_5 <= arg_128_1.time_ and arg_128_1.time_ < var_131_5 + var_131_6 and not isNil(var_131_4) then
				local var_131_7 = (arg_128_1.time_ - var_131_5) / var_131_6

				if arg_128_1.var_.characterEffect1148ui_story and not isNil(var_131_4) then
					local var_131_8 = Mathf.Lerp(0, 0.5, var_131_7)

					arg_128_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_128_1.var_.characterEffect1148ui_story.fillRatio = var_131_8
				end
			end

			if arg_128_1.time_ >= var_131_5 + var_131_6 and arg_128_1.time_ < var_131_5 + var_131_6 + arg_131_0 and not isNil(var_131_4) and arg_128_1.var_.characterEffect1148ui_story then
				local var_131_9 = 0.5

				arg_128_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_128_1.var_.characterEffect1148ui_story.fillRatio = var_131_9
			end

			local var_131_10 = 0
			local var_131_11 = 0.5

			if var_131_10 < arg_128_1.time_ and arg_128_1.time_ <= var_131_10 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				local var_131_12 = arg_128_1:FormatText(StoryNameCfg[28].name)

				arg_128_1.leftNameTxt_.text = var_131_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_13 = arg_128_1:GetWordFromCfg(304101031)
				local var_131_14 = arg_128_1:FormatText(var_131_13.content)

				arg_128_1.text_.text = var_131_14

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_15 = 20
				local var_131_16 = utf8.len(var_131_14)
				local var_131_17 = var_131_15 <= 0 and var_131_11 or var_131_11 * (var_131_16 / var_131_15)

				if var_131_17 > 0 and var_131_11 < var_131_17 then
					arg_128_1.talkMaxDuration = var_131_17

					if var_131_17 + var_131_10 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_17 + var_131_10
					end
				end

				arg_128_1.text_.text = var_131_14
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304101", "304101031", "story_v_out_304101.awb") ~= 0 then
					local var_131_18 = manager.audio:GetVoiceLength("story_v_out_304101", "304101031", "story_v_out_304101.awb") / 1000

					if var_131_18 + var_131_10 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_18 + var_131_10
					end

					if var_131_13.prefab_name ~= "" and arg_128_1.actors_[var_131_13.prefab_name] ~= nil then
						local var_131_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_13.prefab_name].transform, "story_v_out_304101", "304101031", "story_v_out_304101.awb")

						arg_128_1:RecordAudio("304101031", var_131_19)
						arg_128_1:RecordAudio("304101031", var_131_19)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_304101", "304101031", "story_v_out_304101.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_304101", "304101031", "story_v_out_304101.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_20 = math.max(var_131_11, arg_128_1.talkMaxDuration)

			if var_131_10 <= arg_128_1.time_ and arg_128_1.time_ < var_131_10 + var_131_20 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_10) / var_131_20

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_10 + var_131_20 and arg_128_1.time_ < var_131_10 + var_131_20 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play304101032 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 304101032
		arg_132_1.duration_ = 6.5

		local var_132_0 = {
			zh = 4.266,
			ja = 6.5
		}
		local var_132_1 = manager.audio:GetLocalizationFlag()

		if var_132_0[var_132_1] ~= nil then
			arg_132_1.duration_ = var_132_0[var_132_1]
		end

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
			arg_132_1.auto_ = false
		end

		function arg_132_1.playNext_(arg_134_0)
			arg_132_1.onStoryFinished_()
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = 0

			if var_135_0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_0 + arg_135_0 then
				arg_132_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action2_1")
			end

			local var_135_1 = 0

			if var_135_1 < arg_132_1.time_ and arg_132_1.time_ <= var_135_1 + arg_135_0 then
				arg_132_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_135_2 = 0
			local var_135_3 = 0.55

			if var_135_2 < arg_132_1.time_ and arg_132_1.time_ <= var_135_2 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				local var_135_4 = arg_132_1:FormatText(StoryNameCfg[28].name)

				arg_132_1.leftNameTxt_.text = var_135_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_5 = arg_132_1:GetWordFromCfg(304101032)
				local var_135_6 = arg_132_1:FormatText(var_135_5.content)

				arg_132_1.text_.text = var_135_6

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_7 = 22
				local var_135_8 = utf8.len(var_135_6)
				local var_135_9 = var_135_7 <= 0 and var_135_3 or var_135_3 * (var_135_8 / var_135_7)

				if var_135_9 > 0 and var_135_3 < var_135_9 then
					arg_132_1.talkMaxDuration = var_135_9

					if var_135_9 + var_135_2 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_9 + var_135_2
					end
				end

				arg_132_1.text_.text = var_135_6
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304101", "304101032", "story_v_out_304101.awb") ~= 0 then
					local var_135_10 = manager.audio:GetVoiceLength("story_v_out_304101", "304101032", "story_v_out_304101.awb") / 1000

					if var_135_10 + var_135_2 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_10 + var_135_2
					end

					if var_135_5.prefab_name ~= "" and arg_132_1.actors_[var_135_5.prefab_name] ~= nil then
						local var_135_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_5.prefab_name].transform, "story_v_out_304101", "304101032", "story_v_out_304101.awb")

						arg_132_1:RecordAudio("304101032", var_135_11)
						arg_132_1:RecordAudio("304101032", var_135_11)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_304101", "304101032", "story_v_out_304101.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_304101", "304101032", "story_v_out_304101.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_12 = math.max(var_135_3, arg_132_1.talkMaxDuration)

			if var_135_2 <= arg_132_1.time_ and arg_132_1.time_ < var_135_2 + var_135_12 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_2) / var_135_12

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_2 + var_135_12 and arg_132_1.time_ < var_135_2 + var_135_12 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B10"
	},
	voices = {
		"story_v_out_304101.awb"
	}
}
