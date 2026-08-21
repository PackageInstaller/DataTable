return {
	Play304051001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 304051001
		arg_1_1.duration_ = 4.73

		local var_1_0 = {
			zh = 3.666,
			ja = 4.733
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
				arg_1_0:Play304051002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "B04b"

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
				local var_4_5 = arg_1_1.bgs_.B04b

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
					if iter_4_0 ~= "B04b" then
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

			local var_4_19 = 1.425

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

			local var_4_57 = manager.ui.mainCamera.transform
			local var_4_58 = 0.3

			if var_4_58 < arg_1_1.time_ and arg_1_1.time_ <= var_4_58 + arg_4_0 then
				local var_4_59 = arg_1_1.var_.effect4442331
				local var_4_60
				local var_4_61 = var_4_57

				if not var_4_59 then
					var_4_59 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), var_4_61)
					var_4_59.name = "4442331"
					arg_1_1.var_.effect4442331 = var_4_59
				else
					var_4_59.transform:SetParent(var_4_61)
				end

				var_4_59.transform.localPosition = Vector3.New(-1.79, -0.98, -0.09)
				var_4_59.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_4_62 = manager.ui.mainCamera.transform
			local var_4_63 = 0.5

			if var_4_63 < arg_1_1.time_ and arg_1_1.time_ <= var_4_63 + arg_4_0 then
				local var_4_64 = arg_1_1.var_.effect4442342
				local var_4_65
				local var_4_66 = var_4_62

				if not var_4_64 then
					var_4_64 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), var_4_66)
					var_4_64.name = "4442342"
					arg_1_1.var_.effect4442342 = var_4_64
				else
					var_4_64.transform:SetParent(var_4_66)
				end

				var_4_64.transform.localPosition = Vector3.New(0.95, -1.1, 2.37)
				var_4_64.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_4_67 = manager.ui.mainCamera.transform
			local var_4_68 = 0.733333333333334

			if var_4_68 < arg_1_1.time_ and arg_1_1.time_ <= var_4_68 + arg_4_0 then
				local var_4_69 = arg_1_1.var_.effect332323
				local var_4_70
				local var_4_71 = var_4_67

				if not var_4_69 then
					var_4_69 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), var_4_71)
					var_4_69.name = "332323"
					arg_1_1.var_.effect332323 = var_4_69
				else
					var_4_69.transform:SetParent(var_4_71)
				end

				var_4_69.transform.localPosition = Vector3.New(1.27, 0.13, -1.1)
				var_4_69.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_4_72 = manager.ui.mainCamera.transform
			local var_4_73 = 1.8

			if var_4_73 < arg_1_1.time_ and arg_1_1.time_ <= var_4_73 + arg_4_0 then
				local var_4_74 = arg_1_1.var_.effect4442331

				if var_4_74 then
					Object.Destroy(var_4_74)

					arg_1_1.var_.effect4442331 = nil
				end
			end

			local var_4_75 = manager.ui.mainCamera.transform
			local var_4_76 = 2

			if var_4_76 < arg_1_1.time_ and arg_1_1.time_ <= var_4_76 + arg_4_0 then
				local var_4_77 = arg_1_1.var_.effect4442342

				if var_4_77 then
					Object.Destroy(var_4_77)

					arg_1_1.var_.effect4442342 = nil
				end
			end

			local var_4_78 = manager.ui.mainCamera.transform
			local var_4_79 = 2.23333333333333

			if var_4_79 < arg_1_1.time_ and arg_1_1.time_ <= var_4_79 + arg_4_0 then
				local var_4_80 = arg_1_1.var_.effect332323

				if var_4_80 then
					Object.Destroy(var_4_80)

					arg_1_1.var_.effect332323 = nil
				end
			end

			local var_4_81 = 0.2
			local var_4_82 = 1

			if var_4_81 < arg_1_1.time_ and arg_1_1.time_ <= var_4_81 + arg_4_0 then
				local var_4_83 = "play"
				local var_4_84 = "effect"

				arg_1_1:AudioAction(var_4_83, var_4_84, "se_story_144", "se_story_144_gun_battle02", "")
			end

			local var_4_85 = 0.2
			local var_4_86 = 1

			if var_4_85 < arg_1_1.time_ and arg_1_1.time_ <= var_4_85 + arg_4_0 then
				local var_4_87 = "play"
				local var_4_88 = "effect"

				arg_1_1:AudioAction(var_4_87, var_4_88, "se_story_148", "se_story_148_amb_drone02", "")
			end

			local var_4_89 = 1
			local var_4_90 = 1

			if var_4_89 < arg_1_1.time_ and arg_1_1.time_ <= var_4_89 + arg_4_0 then
				local var_4_91 = "play"
				local var_4_92 = "music"

				arg_1_1:AudioAction(var_4_91, var_4_92, "bgm_story_v0_battleground", "bgm_story_v0_battleground", "bgm_story_v0_battleground.awb")

				local var_4_93 = ""
				local var_4_94 = manager.audio:GetAudioName("bgm_story_v0_battleground", "bgm_story_v0_battleground")

				if var_4_94 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_94 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_94

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_94
						arg_1_1.bgmTxt2_.text = var_4_94
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

			local var_4_95 = 0
			local var_4_96 = 1

			if var_4_95 < arg_1_1.time_ and arg_1_1.time_ <= var_4_95 + arg_4_0 then
				local var_4_97 = "play"
				local var_4_98 = "effect"

				arg_1_1:AudioAction(var_4_97, var_4_98, "ui_battle", "ui_battle_stopbgm", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_99 = 1.2
			local var_4_100 = 0.225

			if var_4_99 < arg_1_1.time_ and arg_1_1.time_ <= var_4_99 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_101 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_101:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_101:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_101:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_102 = arg_1_1:FormatText(StoryNameCfg[8].name)

				arg_1_1.leftNameTxt_.text = var_4_102

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

				local var_4_103 = arg_1_1:GetWordFromCfg(304051001)
				local var_4_104 = arg_1_1:FormatText(var_4_103.content)

				arg_1_1.text_.text = var_4_104

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_105 = 9
				local var_4_106 = utf8.len(var_4_104)
				local var_4_107 = var_4_105 <= 0 and var_4_100 or var_4_100 * (var_4_106 / var_4_105)

				if var_4_107 > 0 and var_4_100 < var_4_107 then
					arg_1_1.talkMaxDuration = var_4_107
					var_4_99 = var_4_99 + 0.3

					if var_4_107 + var_4_99 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_107 + var_4_99
					end
				end

				arg_1_1.text_.text = var_4_104
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304051", "304051001", "story_v_out_304051.awb") ~= 0 then
					local var_4_108 = manager.audio:GetVoiceLength("story_v_out_304051", "304051001", "story_v_out_304051.awb") / 1000

					if var_4_108 + var_4_99 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_108 + var_4_99
					end

					if var_4_103.prefab_name ~= "" and arg_1_1.actors_[var_4_103.prefab_name] ~= nil then
						local var_4_109 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_103.prefab_name].transform, "story_v_out_304051", "304051001", "story_v_out_304051.awb")

						arg_1_1:RecordAudio("304051001", var_4_109)
						arg_1_1:RecordAudio("304051001", var_4_109)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_304051", "304051001", "story_v_out_304051.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_304051", "304051001", "story_v_out_304051.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_110 = var_4_99 + 0.3
			local var_4_111 = math.max(var_4_100, arg_1_1.talkMaxDuration)

			if var_4_110 <= arg_1_1.time_ and arg_1_1.time_ < var_4_110 + var_4_111 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_110) / var_4_111

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_110 + var_4_111 and arg_1_1.time_ < var_4_110 + var_4_111 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play304051002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 304051002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play304051003(arg_8_1)
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

			local var_11_6 = 0
			local var_11_7 = 1

			if var_11_6 < arg_8_1.time_ and arg_8_1.time_ <= var_11_6 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_8 = arg_8_1:GetWordFromCfg(304051002)
				local var_11_9 = arg_8_1:FormatText(var_11_8.content)

				arg_8_1.text_.text = var_11_9

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_10 = 40
				local var_11_11 = utf8.len(var_11_9)
				local var_11_12 = var_11_10 <= 0 and var_11_7 or var_11_7 * (var_11_11 / var_11_10)

				if var_11_12 > 0 and var_11_7 < var_11_12 then
					arg_8_1.talkMaxDuration = var_11_12

					if var_11_12 + var_11_6 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_12 + var_11_6
					end
				end

				arg_8_1.text_.text = var_11_9
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_13 = math.max(var_11_7, arg_8_1.talkMaxDuration)

			if var_11_6 <= arg_8_1.time_ and arg_8_1.time_ < var_11_6 + var_11_13 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_6) / var_11_13

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_6 + var_11_13 and arg_8_1.time_ < var_11_6 + var_11_13 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play304051003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 304051003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play304051004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0
			local var_15_1 = 1.8

			if var_15_0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, false)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_2 = arg_12_1:GetWordFromCfg(304051003)
				local var_15_3 = arg_12_1:FormatText(var_15_2.content)

				arg_12_1.text_.text = var_15_3

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_4 = 72
				local var_15_5 = utf8.len(var_15_3)
				local var_15_6 = var_15_4 <= 0 and var_15_1 or var_15_1 * (var_15_5 / var_15_4)

				if var_15_6 > 0 and var_15_1 < var_15_6 then
					arg_12_1.talkMaxDuration = var_15_6

					if var_15_6 + var_15_0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_6 + var_15_0
					end
				end

				arg_12_1.text_.text = var_15_3
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_7 = math.max(var_15_1, arg_12_1.talkMaxDuration)

			if var_15_0 <= arg_12_1.time_ and arg_12_1.time_ < var_15_0 + var_15_7 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_0) / var_15_7

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_0 + var_15_7 and arg_12_1.time_ < var_15_0 + var_15_7 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play304051004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 304051004
		arg_16_1.duration_ = 9.37

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play304051005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = arg_16_1.actors_["2018ui_story"]
			local var_19_1 = 0

			if var_19_1 < arg_16_1.time_ and arg_16_1.time_ <= var_19_1 + arg_19_0 and not isNil(var_19_0) and arg_16_1.var_.characterEffect2018ui_story == nil then
				arg_16_1.var_.characterEffect2018ui_story = var_19_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_2 = 0.200000002980232

			if var_19_1 <= arg_16_1.time_ and arg_16_1.time_ < var_19_1 + var_19_2 and not isNil(var_19_0) then
				local var_19_3 = (arg_16_1.time_ - var_19_1) / var_19_2

				if arg_16_1.var_.characterEffect2018ui_story and not isNil(var_19_0) then
					arg_16_1.var_.characterEffect2018ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= var_19_1 + var_19_2 and arg_16_1.time_ < var_19_1 + var_19_2 + arg_19_0 and not isNil(var_19_0) and arg_16_1.var_.characterEffect2018ui_story then
				arg_16_1.var_.characterEffect2018ui_story.fillFlat = false
			end

			local var_19_4 = 0
			local var_19_5 = 0.45

			if var_19_4 < arg_16_1.time_ and arg_16_1.time_ <= var_19_4 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_6 = arg_16_1:FormatText(StoryNameCfg[29].name)

				arg_16_1.leftNameTxt_.text = var_19_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, true)
				arg_16_1.iconController_:SetSelectedState("hero")

				arg_16_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2018")

				arg_16_1.callingController_:SetSelectedState("normal")

				arg_16_1.keyicon_.color = Color.New(1, 1, 1)
				arg_16_1.icon_.color = Color.New(1, 1, 1)

				local var_19_7 = arg_16_1:GetWordFromCfg(304051004)
				local var_19_8 = arg_16_1:FormatText(var_19_7.content)

				arg_16_1.text_.text = var_19_8

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_9 = 18
				local var_19_10 = utf8.len(var_19_8)
				local var_19_11 = var_19_9 <= 0 and var_19_5 or var_19_5 * (var_19_10 / var_19_9)

				if var_19_11 > 0 and var_19_5 < var_19_11 then
					arg_16_1.talkMaxDuration = var_19_11

					if var_19_11 + var_19_4 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_11 + var_19_4
					end
				end

				arg_16_1.text_.text = var_19_8
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304051", "304051004", "story_v_out_304051.awb") ~= 0 then
					local var_19_12 = manager.audio:GetVoiceLength("story_v_out_304051", "304051004", "story_v_out_304051.awb") / 1000

					if var_19_12 + var_19_4 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_12 + var_19_4
					end

					if var_19_7.prefab_name ~= "" and arg_16_1.actors_[var_19_7.prefab_name] ~= nil then
						local var_19_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_7.prefab_name].transform, "story_v_out_304051", "304051004", "story_v_out_304051.awb")

						arg_16_1:RecordAudio("304051004", var_19_13)
						arg_16_1:RecordAudio("304051004", var_19_13)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_304051", "304051004", "story_v_out_304051.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_304051", "304051004", "story_v_out_304051.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_14 = math.max(var_19_5, arg_16_1.talkMaxDuration)

			if var_19_4 <= arg_16_1.time_ and arg_16_1.time_ < var_19_4 + var_19_14 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_4) / var_19_14

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_4 + var_19_14 and arg_16_1.time_ < var_19_4 + var_19_14 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play304051005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 304051005
		arg_20_1.duration_ = 11.57

		local var_20_0 = {
			zh = 7.2,
			ja = 11.566
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
				arg_20_0:Play304051006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = arg_20_1.actors_["1148ui_story"].transform
			local var_23_1 = 0

			if var_23_1 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 then
				arg_20_1.var_.moveOldPos1148ui_story = var_23_0.localPosition
			end

			local var_23_2 = 0.001

			if var_23_1 <= arg_20_1.time_ and arg_20_1.time_ < var_23_1 + var_23_2 then
				local var_23_3 = (arg_20_1.time_ - var_23_1) / var_23_2
				local var_23_4 = Vector3.New(0, -0.8, -6.2)

				var_23_0.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1148ui_story, var_23_4, var_23_3)

				local var_23_5 = manager.ui.mainCamera.transform.position - var_23_0.position

				var_23_0.forward = Vector3.New(var_23_5.x, var_23_5.y, var_23_5.z)

				local var_23_6 = var_23_0.localEulerAngles

				var_23_6.z = 0
				var_23_6.x = 0
				var_23_0.localEulerAngles = var_23_6
			end

			if arg_20_1.time_ >= var_23_1 + var_23_2 and arg_20_1.time_ < var_23_1 + var_23_2 + arg_23_0 then
				var_23_0.localPosition = Vector3.New(0, -0.8, -6.2)

				local var_23_7 = manager.ui.mainCamera.transform.position - var_23_0.position

				var_23_0.forward = Vector3.New(var_23_7.x, var_23_7.y, var_23_7.z)

				local var_23_8 = var_23_0.localEulerAngles

				var_23_8.z = 0
				var_23_8.x = 0
				var_23_0.localEulerAngles = var_23_8
			end

			local var_23_9 = arg_20_1.actors_["1148ui_story"]
			local var_23_10 = 0

			if var_23_10 < arg_20_1.time_ and arg_20_1.time_ <= var_23_10 + arg_23_0 and not isNil(var_23_9) and arg_20_1.var_.characterEffect1148ui_story == nil then
				arg_20_1.var_.characterEffect1148ui_story = var_23_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_11 = 0.200000002980232

			if var_23_10 <= arg_20_1.time_ and arg_20_1.time_ < var_23_10 + var_23_11 and not isNil(var_23_9) then
				local var_23_12 = (arg_20_1.time_ - var_23_10) / var_23_11

				if arg_20_1.var_.characterEffect1148ui_story and not isNil(var_23_9) then
					arg_20_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= var_23_10 + var_23_11 and arg_20_1.time_ < var_23_10 + var_23_11 + arg_23_0 and not isNil(var_23_9) and arg_20_1.var_.characterEffect1148ui_story then
				arg_20_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_23_13 = arg_20_1.actors_["2018ui_story"]
			local var_23_14 = 0

			if var_23_14 < arg_20_1.time_ and arg_20_1.time_ <= var_23_14 + arg_23_0 and not isNil(var_23_13) and arg_20_1.var_.characterEffect2018ui_story == nil then
				arg_20_1.var_.characterEffect2018ui_story = var_23_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_15 = 0.200000002980232

			if var_23_14 <= arg_20_1.time_ and arg_20_1.time_ < var_23_14 + var_23_15 and not isNil(var_23_13) then
				local var_23_16 = (arg_20_1.time_ - var_23_14) / var_23_15

				if arg_20_1.var_.characterEffect2018ui_story and not isNil(var_23_13) then
					local var_23_17 = Mathf.Lerp(0, 0.5, var_23_16)

					arg_20_1.var_.characterEffect2018ui_story.fillFlat = true
					arg_20_1.var_.characterEffect2018ui_story.fillRatio = var_23_17
				end
			end

			if arg_20_1.time_ >= var_23_14 + var_23_15 and arg_20_1.time_ < var_23_14 + var_23_15 + arg_23_0 and not isNil(var_23_13) and arg_20_1.var_.characterEffect2018ui_story then
				local var_23_18 = 0.5

				arg_20_1.var_.characterEffect2018ui_story.fillFlat = true
				arg_20_1.var_.characterEffect2018ui_story.fillRatio = var_23_18
			end

			local var_23_19 = 0

			if var_23_19 < arg_20_1.time_ and arg_20_1.time_ <= var_23_19 + arg_23_0 then
				arg_20_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action3_1")
			end

			local var_23_20 = 0

			if var_23_20 < arg_20_1.time_ and arg_20_1.time_ <= var_23_20 + arg_23_0 then
				arg_20_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_23_21 = 0
			local var_23_22 = 0.9

			if var_23_21 < arg_20_1.time_ and arg_20_1.time_ <= var_23_21 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_23 = arg_20_1:FormatText(StoryNameCfg[8].name)

				arg_20_1.leftNameTxt_.text = var_23_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_24 = arg_20_1:GetWordFromCfg(304051005)
				local var_23_25 = arg_20_1:FormatText(var_23_24.content)

				arg_20_1.text_.text = var_23_25

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_26 = 36
				local var_23_27 = utf8.len(var_23_25)
				local var_23_28 = var_23_26 <= 0 and var_23_22 or var_23_22 * (var_23_27 / var_23_26)

				if var_23_28 > 0 and var_23_22 < var_23_28 then
					arg_20_1.talkMaxDuration = var_23_28

					if var_23_28 + var_23_21 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_28 + var_23_21
					end
				end

				arg_20_1.text_.text = var_23_25
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304051", "304051005", "story_v_out_304051.awb") ~= 0 then
					local var_23_29 = manager.audio:GetVoiceLength("story_v_out_304051", "304051005", "story_v_out_304051.awb") / 1000

					if var_23_29 + var_23_21 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_29 + var_23_21
					end

					if var_23_24.prefab_name ~= "" and arg_20_1.actors_[var_23_24.prefab_name] ~= nil then
						local var_23_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_24.prefab_name].transform, "story_v_out_304051", "304051005", "story_v_out_304051.awb")

						arg_20_1:RecordAudio("304051005", var_23_30)
						arg_20_1:RecordAudio("304051005", var_23_30)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_304051", "304051005", "story_v_out_304051.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_304051", "304051005", "story_v_out_304051.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_31 = math.max(var_23_22, arg_20_1.talkMaxDuration)

			if var_23_21 <= arg_20_1.time_ and arg_20_1.time_ < var_23_21 + var_23_31 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_21) / var_23_31

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_21 + var_23_31 and arg_20_1.time_ < var_23_21 + var_23_31 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
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

		arg_20_1:InitPlayNodeList()
	end,
	Play304051006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 304051006
		arg_24_1.duration_ = 10.6

		local var_24_0 = {
			zh = 4.066,
			ja = 10.6
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
				arg_24_0:Play304051007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = "1059ui_story"

			if arg_24_1.actors_[var_27_0] == nil then
				local var_27_1 = Asset.Load("Char/" .. "1059ui_story")

				if not isNil(var_27_1) then
					local var_27_2 = Object.Instantiate(Asset.Load("Char/" .. "1059ui_story"), arg_24_1.stage_.transform)

					var_27_2.name = var_27_0
					var_27_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_24_1.actors_[var_27_0] = var_27_2

					local var_27_3 = var_27_2:GetComponentInChildren(typeof(CharacterEffect))

					var_27_3.enabled = true

					local var_27_4 = GameObjectTools.GetOrAddComponent(var_27_2, typeof(DynamicBoneHelper))

					if var_27_4 then
						var_27_4:EnableDynamicBone(false)
					end

					arg_24_1:ShowWeapon(var_27_3.transform, false)

					arg_24_1.var_[var_27_0 .. "Animator"] = var_27_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_24_1.var_[var_27_0 .. "Animator"].applyRootMotion = true
					arg_24_1.var_[var_27_0 .. "LipSync"] = var_27_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_27_5 = arg_24_1.actors_["1059ui_story"].transform
			local var_27_6 = 0

			if var_27_6 < arg_24_1.time_ and arg_24_1.time_ <= var_27_6 + arg_27_0 then
				arg_24_1.var_.moveOldPos1059ui_story = var_27_5.localPosition
			end

			local var_27_7 = 0.001

			if var_27_6 <= arg_24_1.time_ and arg_24_1.time_ < var_27_6 + var_27_7 then
				local var_27_8 = (arg_24_1.time_ - var_27_6) / var_27_7
				local var_27_9 = Vector3.New(-0.7, -1.05, -6)

				var_27_5.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1059ui_story, var_27_9, var_27_8)

				local var_27_10 = manager.ui.mainCamera.transform.position - var_27_5.position

				var_27_5.forward = Vector3.New(var_27_10.x, var_27_10.y, var_27_10.z)

				local var_27_11 = var_27_5.localEulerAngles

				var_27_11.z = 0
				var_27_11.x = 0
				var_27_5.localEulerAngles = var_27_11
			end

			if arg_24_1.time_ >= var_27_6 + var_27_7 and arg_24_1.time_ < var_27_6 + var_27_7 + arg_27_0 then
				var_27_5.localPosition = Vector3.New(-0.7, -1.05, -6)

				local var_27_12 = manager.ui.mainCamera.transform.position - var_27_5.position

				var_27_5.forward = Vector3.New(var_27_12.x, var_27_12.y, var_27_12.z)

				local var_27_13 = var_27_5.localEulerAngles

				var_27_13.z = 0
				var_27_13.x = 0
				var_27_5.localEulerAngles = var_27_13
			end

			local var_27_14 = arg_24_1.actors_["1148ui_story"].transform
			local var_27_15 = 0

			if var_27_15 < arg_24_1.time_ and arg_24_1.time_ <= var_27_15 + arg_27_0 then
				arg_24_1.var_.moveOldPos1148ui_story = var_27_14.localPosition
			end

			local var_27_16 = 0.001

			if var_27_15 <= arg_24_1.time_ and arg_24_1.time_ < var_27_15 + var_27_16 then
				local var_27_17 = (arg_24_1.time_ - var_27_15) / var_27_16
				local var_27_18 = Vector3.New(0.7, -0.8, -6.2)

				var_27_14.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1148ui_story, var_27_18, var_27_17)

				local var_27_19 = manager.ui.mainCamera.transform.position - var_27_14.position

				var_27_14.forward = Vector3.New(var_27_19.x, var_27_19.y, var_27_19.z)

				local var_27_20 = var_27_14.localEulerAngles

				var_27_20.z = 0
				var_27_20.x = 0
				var_27_14.localEulerAngles = var_27_20
			end

			if arg_24_1.time_ >= var_27_15 + var_27_16 and arg_24_1.time_ < var_27_15 + var_27_16 + arg_27_0 then
				var_27_14.localPosition = Vector3.New(0.7, -0.8, -6.2)

				local var_27_21 = manager.ui.mainCamera.transform.position - var_27_14.position

				var_27_14.forward = Vector3.New(var_27_21.x, var_27_21.y, var_27_21.z)

				local var_27_22 = var_27_14.localEulerAngles

				var_27_22.z = 0
				var_27_22.x = 0
				var_27_14.localEulerAngles = var_27_22
			end

			local var_27_23 = arg_24_1.actors_["1059ui_story"]
			local var_27_24 = 0

			if var_27_24 < arg_24_1.time_ and arg_24_1.time_ <= var_27_24 + arg_27_0 and not isNil(var_27_23) and arg_24_1.var_.characterEffect1059ui_story == nil then
				arg_24_1.var_.characterEffect1059ui_story = var_27_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_25 = 0.200000002980232

			if var_27_24 <= arg_24_1.time_ and arg_24_1.time_ < var_27_24 + var_27_25 and not isNil(var_27_23) then
				local var_27_26 = (arg_24_1.time_ - var_27_24) / var_27_25

				if arg_24_1.var_.characterEffect1059ui_story and not isNil(var_27_23) then
					arg_24_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= var_27_24 + var_27_25 and arg_24_1.time_ < var_27_24 + var_27_25 + arg_27_0 and not isNil(var_27_23) and arg_24_1.var_.characterEffect1059ui_story then
				arg_24_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_27_27 = arg_24_1.actors_["1148ui_story"]
			local var_27_28 = 0

			if var_27_28 < arg_24_1.time_ and arg_24_1.time_ <= var_27_28 + arg_27_0 and not isNil(var_27_27) and arg_24_1.var_.characterEffect1148ui_story == nil then
				arg_24_1.var_.characterEffect1148ui_story = var_27_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_29 = 0.200000002980232

			if var_27_28 <= arg_24_1.time_ and arg_24_1.time_ < var_27_28 + var_27_29 and not isNil(var_27_27) then
				local var_27_30 = (arg_24_1.time_ - var_27_28) / var_27_29

				if arg_24_1.var_.characterEffect1148ui_story and not isNil(var_27_27) then
					local var_27_31 = Mathf.Lerp(0, 0.5, var_27_30)

					arg_24_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_24_1.var_.characterEffect1148ui_story.fillRatio = var_27_31
				end
			end

			if arg_24_1.time_ >= var_27_28 + var_27_29 and arg_24_1.time_ < var_27_28 + var_27_29 + arg_27_0 and not isNil(var_27_27) and arg_24_1.var_.characterEffect1148ui_story then
				local var_27_32 = 0.5

				arg_24_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_24_1.var_.characterEffect1148ui_story.fillRatio = var_27_32
			end

			local var_27_33 = 0

			if var_27_33 < arg_24_1.time_ and arg_24_1.time_ <= var_27_33 + arg_27_0 then
				arg_24_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action3_1")
			end

			local var_27_34 = 0

			if var_27_34 < arg_24_1.time_ and arg_24_1.time_ <= var_27_34 + arg_27_0 then
				arg_24_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_27_35 = 0
			local var_27_36 = 0.55

			if var_27_35 < arg_24_1.time_ and arg_24_1.time_ <= var_27_35 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_37 = arg_24_1:FormatText(StoryNameCfg[28].name)

				arg_24_1.leftNameTxt_.text = var_27_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_38 = arg_24_1:GetWordFromCfg(304051006)
				local var_27_39 = arg_24_1:FormatText(var_27_38.content)

				arg_24_1.text_.text = var_27_39

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_40 = 22
				local var_27_41 = utf8.len(var_27_39)
				local var_27_42 = var_27_40 <= 0 and var_27_36 or var_27_36 * (var_27_41 / var_27_40)

				if var_27_42 > 0 and var_27_36 < var_27_42 then
					arg_24_1.talkMaxDuration = var_27_42

					if var_27_42 + var_27_35 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_42 + var_27_35
					end
				end

				arg_24_1.text_.text = var_27_39
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304051", "304051006", "story_v_out_304051.awb") ~= 0 then
					local var_27_43 = manager.audio:GetVoiceLength("story_v_out_304051", "304051006", "story_v_out_304051.awb") / 1000

					if var_27_43 + var_27_35 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_43 + var_27_35
					end

					if var_27_38.prefab_name ~= "" and arg_24_1.actors_[var_27_38.prefab_name] ~= nil then
						local var_27_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_38.prefab_name].transform, "story_v_out_304051", "304051006", "story_v_out_304051.awb")

						arg_24_1:RecordAudio("304051006", var_27_44)
						arg_24_1:RecordAudio("304051006", var_27_44)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_304051", "304051006", "story_v_out_304051.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_304051", "304051006", "story_v_out_304051.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_45 = math.max(var_27_36, arg_24_1.talkMaxDuration)

			if var_27_35 <= arg_24_1.time_ and arg_24_1.time_ < var_27_35 + var_27_45 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_35) / var_27_45

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_35 + var_27_45 and arg_24_1.time_ < var_27_35 + var_27_45 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1059ui_story",
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

		arg_24_1:InitPlayNodeList()
	end,
	Play304051007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 304051007
		arg_28_1.duration_ = 4.53

		local var_28_0 = {
			zh = 4.033,
			ja = 4.533
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
				arg_28_0:Play304051008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = arg_28_1.actors_["1148ui_story"]
			local var_31_1 = 0

			if var_31_1 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect1148ui_story == nil then
				arg_28_1.var_.characterEffect1148ui_story = var_31_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_2 = 0.200000002980232

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_2 and not isNil(var_31_0) then
				local var_31_3 = (arg_28_1.time_ - var_31_1) / var_31_2

				if arg_28_1.var_.characterEffect1148ui_story and not isNil(var_31_0) then
					arg_28_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= var_31_1 + var_31_2 and arg_28_1.time_ < var_31_1 + var_31_2 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect1148ui_story then
				arg_28_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_31_4 = arg_28_1.actors_["1059ui_story"]
			local var_31_5 = 0

			if var_31_5 < arg_28_1.time_ and arg_28_1.time_ <= var_31_5 + arg_31_0 and not isNil(var_31_4) and arg_28_1.var_.characterEffect1059ui_story == nil then
				arg_28_1.var_.characterEffect1059ui_story = var_31_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_6 = 0.200000002980232

			if var_31_5 <= arg_28_1.time_ and arg_28_1.time_ < var_31_5 + var_31_6 and not isNil(var_31_4) then
				local var_31_7 = (arg_28_1.time_ - var_31_5) / var_31_6

				if arg_28_1.var_.characterEffect1059ui_story and not isNil(var_31_4) then
					local var_31_8 = Mathf.Lerp(0, 0.5, var_31_7)

					arg_28_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_28_1.var_.characterEffect1059ui_story.fillRatio = var_31_8
				end
			end

			if arg_28_1.time_ >= var_31_5 + var_31_6 and arg_28_1.time_ < var_31_5 + var_31_6 + arg_31_0 and not isNil(var_31_4) and arg_28_1.var_.characterEffect1059ui_story then
				local var_31_9 = 0.5

				arg_28_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_28_1.var_.characterEffect1059ui_story.fillRatio = var_31_9
			end

			local var_31_10 = 0

			if var_31_10 < arg_28_1.time_ and arg_28_1.time_ <= var_31_10 + arg_31_0 then
				arg_28_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_31_11 = 0

			if var_31_11 < arg_28_1.time_ and arg_28_1.time_ <= var_31_11 + arg_31_0 then
				arg_28_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action439")
			end

			local var_31_12 = 0
			local var_31_13 = 0.475

			if var_31_12 < arg_28_1.time_ and arg_28_1.time_ <= var_31_12 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_14 = arg_28_1:FormatText(StoryNameCfg[8].name)

				arg_28_1.leftNameTxt_.text = var_31_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_15 = arg_28_1:GetWordFromCfg(304051007)
				local var_31_16 = arg_28_1:FormatText(var_31_15.content)

				arg_28_1.text_.text = var_31_16

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_17 = 19
				local var_31_18 = utf8.len(var_31_16)
				local var_31_19 = var_31_17 <= 0 and var_31_13 or var_31_13 * (var_31_18 / var_31_17)

				if var_31_19 > 0 and var_31_13 < var_31_19 then
					arg_28_1.talkMaxDuration = var_31_19

					if var_31_19 + var_31_12 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_19 + var_31_12
					end
				end

				arg_28_1.text_.text = var_31_16
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304051", "304051007", "story_v_out_304051.awb") ~= 0 then
					local var_31_20 = manager.audio:GetVoiceLength("story_v_out_304051", "304051007", "story_v_out_304051.awb") / 1000

					if var_31_20 + var_31_12 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_20 + var_31_12
					end

					if var_31_15.prefab_name ~= "" and arg_28_1.actors_[var_31_15.prefab_name] ~= nil then
						local var_31_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_15.prefab_name].transform, "story_v_out_304051", "304051007", "story_v_out_304051.awb")

						arg_28_1:RecordAudio("304051007", var_31_21)
						arg_28_1:RecordAudio("304051007", var_31_21)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_304051", "304051007", "story_v_out_304051.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_304051", "304051007", "story_v_out_304051.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_22 = math.max(var_31_13, arg_28_1.talkMaxDuration)

			if var_31_12 <= arg_28_1.time_ and arg_28_1.time_ < var_31_12 + var_31_22 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_12) / var_31_22

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_12 + var_31_22 and arg_28_1.time_ < var_31_12 + var_31_22 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play304051008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 304051008
		arg_32_1.duration_ = 5.17

		local var_32_0 = {
			zh = 3.6,
			ja = 5.166
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
				arg_32_0:Play304051009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = 0
			local var_35_1 = 0.425

			if var_35_0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_0 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_2 = arg_32_1:FormatText(StoryNameCfg[8].name)

				arg_32_1.leftNameTxt_.text = var_35_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_3 = arg_32_1:GetWordFromCfg(304051008)
				local var_35_4 = arg_32_1:FormatText(var_35_3.content)

				arg_32_1.text_.text = var_35_4

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_5 = 17
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

				if manager.audio:GetVoiceLength("story_v_out_304051", "304051008", "story_v_out_304051.awb") ~= 0 then
					local var_35_8 = manager.audio:GetVoiceLength("story_v_out_304051", "304051008", "story_v_out_304051.awb") / 1000

					if var_35_8 + var_35_0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_8 + var_35_0
					end

					if var_35_3.prefab_name ~= "" and arg_32_1.actors_[var_35_3.prefab_name] ~= nil then
						local var_35_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_3.prefab_name].transform, "story_v_out_304051", "304051008", "story_v_out_304051.awb")

						arg_32_1:RecordAudio("304051008", var_35_9)
						arg_32_1:RecordAudio("304051008", var_35_9)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_304051", "304051008", "story_v_out_304051.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_304051", "304051008", "story_v_out_304051.awb")
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
	Play304051009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 304051009
		arg_36_1.duration_ = 6.7

		local var_36_0 = {
			zh = 5.433,
			ja = 6.7
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
				arg_36_0:Play304051010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = arg_36_1.actors_["1059ui_story"]
			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect1059ui_story == nil then
				arg_36_1.var_.characterEffect1059ui_story = var_39_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_2 = 0.200000002980232

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_2 and not isNil(var_39_0) then
				local var_39_3 = (arg_36_1.time_ - var_39_1) / var_39_2

				if arg_36_1.var_.characterEffect1059ui_story and not isNil(var_39_0) then
					arg_36_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= var_39_1 + var_39_2 and arg_36_1.time_ < var_39_1 + var_39_2 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect1059ui_story then
				arg_36_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_39_4 = arg_36_1.actors_["1148ui_story"]
			local var_39_5 = 0

			if var_39_5 < arg_36_1.time_ and arg_36_1.time_ <= var_39_5 + arg_39_0 and not isNil(var_39_4) and arg_36_1.var_.characterEffect1148ui_story == nil then
				arg_36_1.var_.characterEffect1148ui_story = var_39_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_6 = 0.200000002980232

			if var_39_5 <= arg_36_1.time_ and arg_36_1.time_ < var_39_5 + var_39_6 and not isNil(var_39_4) then
				local var_39_7 = (arg_36_1.time_ - var_39_5) / var_39_6

				if arg_36_1.var_.characterEffect1148ui_story and not isNil(var_39_4) then
					local var_39_8 = Mathf.Lerp(0, 0.5, var_39_7)

					arg_36_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_36_1.var_.characterEffect1148ui_story.fillRatio = var_39_8
				end
			end

			if arg_36_1.time_ >= var_39_5 + var_39_6 and arg_36_1.time_ < var_39_5 + var_39_6 + arg_39_0 and not isNil(var_39_4) and arg_36_1.var_.characterEffect1148ui_story then
				local var_39_9 = 0.5

				arg_36_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_36_1.var_.characterEffect1148ui_story.fillRatio = var_39_9
			end

			local var_39_10 = 0

			if var_39_10 < arg_36_1.time_ and arg_36_1.time_ <= var_39_10 + arg_39_0 then
				arg_36_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059actionlink/1059action432")
			end

			local var_39_11 = 0
			local var_39_12 = 0.6

			if var_39_11 < arg_36_1.time_ and arg_36_1.time_ <= var_39_11 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_13 = arg_36_1:FormatText(StoryNameCfg[28].name)

				arg_36_1.leftNameTxt_.text = var_39_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_14 = arg_36_1:GetWordFromCfg(304051009)
				local var_39_15 = arg_36_1:FormatText(var_39_14.content)

				arg_36_1.text_.text = var_39_15

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_16 = 24
				local var_39_17 = utf8.len(var_39_15)
				local var_39_18 = var_39_16 <= 0 and var_39_12 or var_39_12 * (var_39_17 / var_39_16)

				if var_39_18 > 0 and var_39_12 < var_39_18 then
					arg_36_1.talkMaxDuration = var_39_18

					if var_39_18 + var_39_11 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_18 + var_39_11
					end
				end

				arg_36_1.text_.text = var_39_15
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304051", "304051009", "story_v_out_304051.awb") ~= 0 then
					local var_39_19 = manager.audio:GetVoiceLength("story_v_out_304051", "304051009", "story_v_out_304051.awb") / 1000

					if var_39_19 + var_39_11 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_19 + var_39_11
					end

					if var_39_14.prefab_name ~= "" and arg_36_1.actors_[var_39_14.prefab_name] ~= nil then
						local var_39_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_14.prefab_name].transform, "story_v_out_304051", "304051009", "story_v_out_304051.awb")

						arg_36_1:RecordAudio("304051009", var_39_20)
						arg_36_1:RecordAudio("304051009", var_39_20)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_304051", "304051009", "story_v_out_304051.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_304051", "304051009", "story_v_out_304051.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_21 = math.max(var_39_12, arg_36_1.talkMaxDuration)

			if var_39_11 <= arg_36_1.time_ and arg_36_1.time_ < var_39_11 + var_39_21 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_11) / var_39_21

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_11 + var_39_21 and arg_36_1.time_ < var_39_11 + var_39_21 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play304051010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 304051010
		arg_40_1.duration_ = 9.1

		local var_40_0 = {
			zh = 3.966,
			ja = 9.1
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
				arg_40_0:Play304051011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = 0
			local var_43_1 = 0.5

			if var_43_0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_0 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_2 = arg_40_1:FormatText(StoryNameCfg[28].name)

				arg_40_1.leftNameTxt_.text = var_43_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_3 = arg_40_1:GetWordFromCfg(304051010)
				local var_43_4 = arg_40_1:FormatText(var_43_3.content)

				arg_40_1.text_.text = var_43_4

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_5 = 20
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

				if manager.audio:GetVoiceLength("story_v_out_304051", "304051010", "story_v_out_304051.awb") ~= 0 then
					local var_43_8 = manager.audio:GetVoiceLength("story_v_out_304051", "304051010", "story_v_out_304051.awb") / 1000

					if var_43_8 + var_43_0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_8 + var_43_0
					end

					if var_43_3.prefab_name ~= "" and arg_40_1.actors_[var_43_3.prefab_name] ~= nil then
						local var_43_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_3.prefab_name].transform, "story_v_out_304051", "304051010", "story_v_out_304051.awb")

						arg_40_1:RecordAudio("304051010", var_43_9)
						arg_40_1:RecordAudio("304051010", var_43_9)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_304051", "304051010", "story_v_out_304051.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_304051", "304051010", "story_v_out_304051.awb")
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
	Play304051011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 304051011
		arg_44_1.duration_ = 5

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play304051012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = arg_44_1.actors_["1059ui_story"].transform
			local var_47_1 = 0

			if var_47_1 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 then
				arg_44_1.var_.moveOldPos1059ui_story = var_47_0.localPosition
			end

			local var_47_2 = 0.001

			if var_47_1 <= arg_44_1.time_ and arg_44_1.time_ < var_47_1 + var_47_2 then
				local var_47_3 = (arg_44_1.time_ - var_47_1) / var_47_2
				local var_47_4 = Vector3.New(0, 100, 0)

				var_47_0.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1059ui_story, var_47_4, var_47_3)

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

			local var_47_9 = arg_44_1.actors_["1148ui_story"].transform
			local var_47_10 = 0

			if var_47_10 < arg_44_1.time_ and arg_44_1.time_ <= var_47_10 + arg_47_0 then
				arg_44_1.var_.moveOldPos1148ui_story = var_47_9.localPosition
			end

			local var_47_11 = 0.001

			if var_47_10 <= arg_44_1.time_ and arg_44_1.time_ < var_47_10 + var_47_11 then
				local var_47_12 = (arg_44_1.time_ - var_47_10) / var_47_11
				local var_47_13 = Vector3.New(0, 100, 0)

				var_47_9.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1148ui_story, var_47_13, var_47_12)

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

			local var_47_18 = arg_44_1.actors_["1059ui_story"]
			local var_47_19 = 0

			if var_47_19 < arg_44_1.time_ and arg_44_1.time_ <= var_47_19 + arg_47_0 and not isNil(var_47_18) and arg_44_1.var_.characterEffect1059ui_story == nil then
				arg_44_1.var_.characterEffect1059ui_story = var_47_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_20 = 0.200000002980232

			if var_47_19 <= arg_44_1.time_ and arg_44_1.time_ < var_47_19 + var_47_20 and not isNil(var_47_18) then
				local var_47_21 = (arg_44_1.time_ - var_47_19) / var_47_20

				if arg_44_1.var_.characterEffect1059ui_story and not isNil(var_47_18) then
					local var_47_22 = Mathf.Lerp(0, 0.5, var_47_21)

					arg_44_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_44_1.var_.characterEffect1059ui_story.fillRatio = var_47_22
				end
			end

			if arg_44_1.time_ >= var_47_19 + var_47_20 and arg_44_1.time_ < var_47_19 + var_47_20 + arg_47_0 and not isNil(var_47_18) and arg_44_1.var_.characterEffect1059ui_story then
				local var_47_23 = 0.5

				arg_44_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_44_1.var_.characterEffect1059ui_story.fillRatio = var_47_23
			end

			local var_47_24 = 0
			local var_47_25 = 1.45

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

				local var_47_26 = arg_44_1:GetWordFromCfg(304051011)
				local var_47_27 = arg_44_1:FormatText(var_47_26.content)

				arg_44_1.text_.text = var_47_27

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_28 = 58
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
				actorName = "1059ui_story",
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

		arg_44_1:InitPlayNodeList()
	end,
	Play304051012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 304051012
		arg_48_1.duration_ = 8.4

		local var_48_0 = {
			zh = 6.266,
			ja = 8.4
		}
		local var_48_1 = manager.audio:GetLocalizationFlag()

		if var_48_0[var_48_1] ~= nil then
			arg_48_1.duration_ = var_48_0[var_48_1]
		end

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play304051013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = arg_48_1.actors_["1059ui_story"].transform
			local var_51_1 = 0

			if var_51_1 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 then
				arg_48_1.var_.moveOldPos1059ui_story = var_51_0.localPosition
			end

			local var_51_2 = 0.001

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_2 then
				local var_51_3 = (arg_48_1.time_ - var_51_1) / var_51_2
				local var_51_4 = Vector3.New(-0.7, -1.05, -6)

				var_51_0.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos1059ui_story, var_51_4, var_51_3)

				local var_51_5 = manager.ui.mainCamera.transform.position - var_51_0.position

				var_51_0.forward = Vector3.New(var_51_5.x, var_51_5.y, var_51_5.z)

				local var_51_6 = var_51_0.localEulerAngles

				var_51_6.z = 0
				var_51_6.x = 0
				var_51_0.localEulerAngles = var_51_6
			end

			if arg_48_1.time_ >= var_51_1 + var_51_2 and arg_48_1.time_ < var_51_1 + var_51_2 + arg_51_0 then
				var_51_0.localPosition = Vector3.New(-0.7, -1.05, -6)

				local var_51_7 = manager.ui.mainCamera.transform.position - var_51_0.position

				var_51_0.forward = Vector3.New(var_51_7.x, var_51_7.y, var_51_7.z)

				local var_51_8 = var_51_0.localEulerAngles

				var_51_8.z = 0
				var_51_8.x = 0
				var_51_0.localEulerAngles = var_51_8
			end

			local var_51_9 = arg_48_1.actors_["1059ui_story"]
			local var_51_10 = 0

			if var_51_10 < arg_48_1.time_ and arg_48_1.time_ <= var_51_10 + arg_51_0 and not isNil(var_51_9) and arg_48_1.var_.characterEffect1059ui_story == nil then
				arg_48_1.var_.characterEffect1059ui_story = var_51_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_11 = 0.200000002980232

			if var_51_10 <= arg_48_1.time_ and arg_48_1.time_ < var_51_10 + var_51_11 and not isNil(var_51_9) then
				local var_51_12 = (arg_48_1.time_ - var_51_10) / var_51_11

				if arg_48_1.var_.characterEffect1059ui_story and not isNil(var_51_9) then
					arg_48_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= var_51_10 + var_51_11 and arg_48_1.time_ < var_51_10 + var_51_11 + arg_51_0 and not isNil(var_51_9) and arg_48_1.var_.characterEffect1059ui_story then
				arg_48_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_51_13 = 0

			if var_51_13 < arg_48_1.time_ and arg_48_1.time_ <= var_51_13 + arg_51_0 then
				arg_48_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action2_2")
			end

			local var_51_14 = 0

			if var_51_14 < arg_48_1.time_ and arg_48_1.time_ <= var_51_14 + arg_51_0 then
				arg_48_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_51_15 = 0
			local var_51_16 = 0.85

			if var_51_15 < arg_48_1.time_ and arg_48_1.time_ <= var_51_15 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_17 = arg_48_1:FormatText(StoryNameCfg[28].name)

				arg_48_1.leftNameTxt_.text = var_51_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_18 = arg_48_1:GetWordFromCfg(304051012)
				local var_51_19 = arg_48_1:FormatText(var_51_18.content)

				arg_48_1.text_.text = var_51_19

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_20 = 34
				local var_51_21 = utf8.len(var_51_19)
				local var_51_22 = var_51_20 <= 0 and var_51_16 or var_51_16 * (var_51_21 / var_51_20)

				if var_51_22 > 0 and var_51_16 < var_51_22 then
					arg_48_1.talkMaxDuration = var_51_22

					if var_51_22 + var_51_15 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_22 + var_51_15
					end
				end

				arg_48_1.text_.text = var_51_19
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304051", "304051012", "story_v_out_304051.awb") ~= 0 then
					local var_51_23 = manager.audio:GetVoiceLength("story_v_out_304051", "304051012", "story_v_out_304051.awb") / 1000

					if var_51_23 + var_51_15 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_23 + var_51_15
					end

					if var_51_18.prefab_name ~= "" and arg_48_1.actors_[var_51_18.prefab_name] ~= nil then
						local var_51_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_18.prefab_name].transform, "story_v_out_304051", "304051012", "story_v_out_304051.awb")

						arg_48_1:RecordAudio("304051012", var_51_24)
						arg_48_1:RecordAudio("304051012", var_51_24)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_304051", "304051012", "story_v_out_304051.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_304051", "304051012", "story_v_out_304051.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_25 = math.max(var_51_16, arg_48_1.talkMaxDuration)

			if var_51_15 <= arg_48_1.time_ and arg_48_1.time_ < var_51_15 + var_51_25 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_15) / var_51_25

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_15 + var_51_25 and arg_48_1.time_ < var_51_15 + var_51_25 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {
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

		arg_48_1:InitPlayNodeList()
	end,
	Play304051013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 304051013
		arg_52_1.duration_ = 4.77

		local var_52_0 = {
			zh = 3.9,
			ja = 4.766
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
				arg_52_0:Play304051014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = arg_52_1.actors_["1148ui_story"].transform
			local var_55_1 = 0

			if var_55_1 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 then
				arg_52_1.var_.moveOldPos1148ui_story = var_55_0.localPosition
			end

			local var_55_2 = 0.001

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_2 then
				local var_55_3 = (arg_52_1.time_ - var_55_1) / var_55_2
				local var_55_4 = Vector3.New(0.7, -0.8, -6.2)

				var_55_0.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos1148ui_story, var_55_4, var_55_3)

				local var_55_5 = manager.ui.mainCamera.transform.position - var_55_0.position

				var_55_0.forward = Vector3.New(var_55_5.x, var_55_5.y, var_55_5.z)

				local var_55_6 = var_55_0.localEulerAngles

				var_55_6.z = 0
				var_55_6.x = 0
				var_55_0.localEulerAngles = var_55_6
			end

			if arg_52_1.time_ >= var_55_1 + var_55_2 and arg_52_1.time_ < var_55_1 + var_55_2 + arg_55_0 then
				var_55_0.localPosition = Vector3.New(0.7, -0.8, -6.2)

				local var_55_7 = manager.ui.mainCamera.transform.position - var_55_0.position

				var_55_0.forward = Vector3.New(var_55_7.x, var_55_7.y, var_55_7.z)

				local var_55_8 = var_55_0.localEulerAngles

				var_55_8.z = 0
				var_55_8.x = 0
				var_55_0.localEulerAngles = var_55_8
			end

			local var_55_9 = arg_52_1.actors_["1148ui_story"]
			local var_55_10 = 0

			if var_55_10 < arg_52_1.time_ and arg_52_1.time_ <= var_55_10 + arg_55_0 and not isNil(var_55_9) and arg_52_1.var_.characterEffect1148ui_story == nil then
				arg_52_1.var_.characterEffect1148ui_story = var_55_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_11 = 0.200000002980232

			if var_55_10 <= arg_52_1.time_ and arg_52_1.time_ < var_55_10 + var_55_11 and not isNil(var_55_9) then
				local var_55_12 = (arg_52_1.time_ - var_55_10) / var_55_11

				if arg_52_1.var_.characterEffect1148ui_story and not isNil(var_55_9) then
					arg_52_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_52_1.time_ >= var_55_10 + var_55_11 and arg_52_1.time_ < var_55_10 + var_55_11 + arg_55_0 and not isNil(var_55_9) and arg_52_1.var_.characterEffect1148ui_story then
				arg_52_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_55_13 = arg_52_1.actors_["1059ui_story"]
			local var_55_14 = 0

			if var_55_14 < arg_52_1.time_ and arg_52_1.time_ <= var_55_14 + arg_55_0 and not isNil(var_55_13) and arg_52_1.var_.characterEffect1059ui_story == nil then
				arg_52_1.var_.characterEffect1059ui_story = var_55_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_15 = 0.200000002980232

			if var_55_14 <= arg_52_1.time_ and arg_52_1.time_ < var_55_14 + var_55_15 and not isNil(var_55_13) then
				local var_55_16 = (arg_52_1.time_ - var_55_14) / var_55_15

				if arg_52_1.var_.characterEffect1059ui_story and not isNil(var_55_13) then
					local var_55_17 = Mathf.Lerp(0, 0.5, var_55_16)

					arg_52_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_52_1.var_.characterEffect1059ui_story.fillRatio = var_55_17
				end
			end

			if arg_52_1.time_ >= var_55_14 + var_55_15 and arg_52_1.time_ < var_55_14 + var_55_15 + arg_55_0 and not isNil(var_55_13) and arg_52_1.var_.characterEffect1059ui_story then
				local var_55_18 = 0.5

				arg_52_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_52_1.var_.characterEffect1059ui_story.fillRatio = var_55_18
			end

			local var_55_19 = 0

			if var_55_19 < arg_52_1.time_ and arg_52_1.time_ <= var_55_19 + arg_55_0 then
				arg_52_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action494")
			end

			local var_55_20 = 0

			if var_55_20 < arg_52_1.time_ and arg_52_1.time_ <= var_55_20 + arg_55_0 then
				arg_52_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_55_21 = 0
			local var_55_22 = 0.45

			if var_55_21 < arg_52_1.time_ and arg_52_1.time_ <= var_55_21 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_23 = arg_52_1:FormatText(StoryNameCfg[8].name)

				arg_52_1.leftNameTxt_.text = var_55_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_24 = arg_52_1:GetWordFromCfg(304051013)
				local var_55_25 = arg_52_1:FormatText(var_55_24.content)

				arg_52_1.text_.text = var_55_25

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_26 = 18
				local var_55_27 = utf8.len(var_55_25)
				local var_55_28 = var_55_26 <= 0 and var_55_22 or var_55_22 * (var_55_27 / var_55_26)

				if var_55_28 > 0 and var_55_22 < var_55_28 then
					arg_52_1.talkMaxDuration = var_55_28

					if var_55_28 + var_55_21 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_28 + var_55_21
					end
				end

				arg_52_1.text_.text = var_55_25
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304051", "304051013", "story_v_out_304051.awb") ~= 0 then
					local var_55_29 = manager.audio:GetVoiceLength("story_v_out_304051", "304051013", "story_v_out_304051.awb") / 1000

					if var_55_29 + var_55_21 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_29 + var_55_21
					end

					if var_55_24.prefab_name ~= "" and arg_52_1.actors_[var_55_24.prefab_name] ~= nil then
						local var_55_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_24.prefab_name].transform, "story_v_out_304051", "304051013", "story_v_out_304051.awb")

						arg_52_1:RecordAudio("304051013", var_55_30)
						arg_52_1:RecordAudio("304051013", var_55_30)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_304051", "304051013", "story_v_out_304051.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_304051", "304051013", "story_v_out_304051.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_31 = math.max(var_55_22, arg_52_1.talkMaxDuration)

			if var_55_21 <= arg_52_1.time_ and arg_52_1.time_ < var_55_21 + var_55_31 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_21) / var_55_31

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_21 + var_55_31 and arg_52_1.time_ < var_55_21 + var_55_31 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {
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

		arg_52_1:InitPlayNodeList()
	end,
	Play304051014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 304051014
		arg_56_1.duration_ = 2.7

		local var_56_0 = {
			zh = 2.666,
			ja = 2.7
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
				arg_56_0:Play304051015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = arg_56_1.actors_["1059ui_story"]
			local var_59_1 = 0

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.characterEffect1059ui_story == nil then
				arg_56_1.var_.characterEffect1059ui_story = var_59_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_2 = 0.200000002980232

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_2 and not isNil(var_59_0) then
				local var_59_3 = (arg_56_1.time_ - var_59_1) / var_59_2

				if arg_56_1.var_.characterEffect1059ui_story and not isNil(var_59_0) then
					arg_56_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_56_1.time_ >= var_59_1 + var_59_2 and arg_56_1.time_ < var_59_1 + var_59_2 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.characterEffect1059ui_story then
				arg_56_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_59_4 = arg_56_1.actors_["1148ui_story"]
			local var_59_5 = 0

			if var_59_5 < arg_56_1.time_ and arg_56_1.time_ <= var_59_5 + arg_59_0 and not isNil(var_59_4) and arg_56_1.var_.characterEffect1148ui_story == nil then
				arg_56_1.var_.characterEffect1148ui_story = var_59_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_6 = 0.200000002980232

			if var_59_5 <= arg_56_1.time_ and arg_56_1.time_ < var_59_5 + var_59_6 and not isNil(var_59_4) then
				local var_59_7 = (arg_56_1.time_ - var_59_5) / var_59_6

				if arg_56_1.var_.characterEffect1148ui_story and not isNil(var_59_4) then
					local var_59_8 = Mathf.Lerp(0, 0.5, var_59_7)

					arg_56_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_56_1.var_.characterEffect1148ui_story.fillRatio = var_59_8
				end
			end

			if arg_56_1.time_ >= var_59_5 + var_59_6 and arg_56_1.time_ < var_59_5 + var_59_6 + arg_59_0 and not isNil(var_59_4) and arg_56_1.var_.characterEffect1148ui_story then
				local var_59_9 = 0.5

				arg_56_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_56_1.var_.characterEffect1148ui_story.fillRatio = var_59_9
			end

			local var_59_10 = 0

			if var_59_10 < arg_56_1.time_ and arg_56_1.time_ <= var_59_10 + arg_59_0 then
				arg_56_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action1_1")
			end

			local var_59_11 = 0

			if var_59_11 < arg_56_1.time_ and arg_56_1.time_ <= var_59_11 + arg_59_0 then
				arg_56_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_59_12 = 0
			local var_59_13 = 0.325

			if var_59_12 < arg_56_1.time_ and arg_56_1.time_ <= var_59_12 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_14 = arg_56_1:FormatText(StoryNameCfg[28].name)

				arg_56_1.leftNameTxt_.text = var_59_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_15 = arg_56_1:GetWordFromCfg(304051014)
				local var_59_16 = arg_56_1:FormatText(var_59_15.content)

				arg_56_1.text_.text = var_59_16

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_17 = 13
				local var_59_18 = utf8.len(var_59_16)
				local var_59_19 = var_59_17 <= 0 and var_59_13 or var_59_13 * (var_59_18 / var_59_17)

				if var_59_19 > 0 and var_59_13 < var_59_19 then
					arg_56_1.talkMaxDuration = var_59_19

					if var_59_19 + var_59_12 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_19 + var_59_12
					end
				end

				arg_56_1.text_.text = var_59_16
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304051", "304051014", "story_v_out_304051.awb") ~= 0 then
					local var_59_20 = manager.audio:GetVoiceLength("story_v_out_304051", "304051014", "story_v_out_304051.awb") / 1000

					if var_59_20 + var_59_12 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_20 + var_59_12
					end

					if var_59_15.prefab_name ~= "" and arg_56_1.actors_[var_59_15.prefab_name] ~= nil then
						local var_59_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_15.prefab_name].transform, "story_v_out_304051", "304051014", "story_v_out_304051.awb")

						arg_56_1:RecordAudio("304051014", var_59_21)
						arg_56_1:RecordAudio("304051014", var_59_21)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_304051", "304051014", "story_v_out_304051.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_304051", "304051014", "story_v_out_304051.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_22 = math.max(var_59_13, arg_56_1.talkMaxDuration)

			if var_59_12 <= arg_56_1.time_ and arg_56_1.time_ < var_59_12 + var_59_22 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_12) / var_59_22

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_12 + var_59_22 and arg_56_1.time_ < var_59_12 + var_59_22 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play304051015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 304051015
		arg_60_1.duration_ = 7.47

		local var_60_0 = {
			zh = 5.1,
			ja = 7.466
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
				arg_60_0:Play304051016(arg_60_1)
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
					arg_60_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= var_63_1 + var_63_2 and arg_60_1.time_ < var_63_1 + var_63_2 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.characterEffect1148ui_story then
				arg_60_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_63_4 = arg_60_1.actors_["1059ui_story"]
			local var_63_5 = 0

			if var_63_5 < arg_60_1.time_ and arg_60_1.time_ <= var_63_5 + arg_63_0 and not isNil(var_63_4) and arg_60_1.var_.characterEffect1059ui_story == nil then
				arg_60_1.var_.characterEffect1059ui_story = var_63_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_6 = 0.200000002980232

			if var_63_5 <= arg_60_1.time_ and arg_60_1.time_ < var_63_5 + var_63_6 and not isNil(var_63_4) then
				local var_63_7 = (arg_60_1.time_ - var_63_5) / var_63_6

				if arg_60_1.var_.characterEffect1059ui_story and not isNil(var_63_4) then
					local var_63_8 = Mathf.Lerp(0, 0.5, var_63_7)

					arg_60_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_60_1.var_.characterEffect1059ui_story.fillRatio = var_63_8
				end
			end

			if arg_60_1.time_ >= var_63_5 + var_63_6 and arg_60_1.time_ < var_63_5 + var_63_6 + arg_63_0 and not isNil(var_63_4) and arg_60_1.var_.characterEffect1059ui_story then
				local var_63_9 = 0.5

				arg_60_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_60_1.var_.characterEffect1059ui_story.fillRatio = var_63_9
			end

			local var_63_10 = 0

			if var_63_10 < arg_60_1.time_ and arg_60_1.time_ <= var_63_10 + arg_63_0 then
				arg_60_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action445")
			end

			local var_63_11 = 0

			if var_63_11 < arg_60_1.time_ and arg_60_1.time_ <= var_63_11 + arg_63_0 then
				arg_60_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_63_12 = 0
			local var_63_13 = 0.55

			if var_63_12 < arg_60_1.time_ and arg_60_1.time_ <= var_63_12 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_14 = arg_60_1:FormatText(StoryNameCfg[8].name)

				arg_60_1.leftNameTxt_.text = var_63_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_15 = arg_60_1:GetWordFromCfg(304051015)
				local var_63_16 = arg_60_1:FormatText(var_63_15.content)

				arg_60_1.text_.text = var_63_16

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_17 = 22
				local var_63_18 = utf8.len(var_63_16)
				local var_63_19 = var_63_17 <= 0 and var_63_13 or var_63_13 * (var_63_18 / var_63_17)

				if var_63_19 > 0 and var_63_13 < var_63_19 then
					arg_60_1.talkMaxDuration = var_63_19

					if var_63_19 + var_63_12 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_19 + var_63_12
					end
				end

				arg_60_1.text_.text = var_63_16
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304051", "304051015", "story_v_out_304051.awb") ~= 0 then
					local var_63_20 = manager.audio:GetVoiceLength("story_v_out_304051", "304051015", "story_v_out_304051.awb") / 1000

					if var_63_20 + var_63_12 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_20 + var_63_12
					end

					if var_63_15.prefab_name ~= "" and arg_60_1.actors_[var_63_15.prefab_name] ~= nil then
						local var_63_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_15.prefab_name].transform, "story_v_out_304051", "304051015", "story_v_out_304051.awb")

						arg_60_1:RecordAudio("304051015", var_63_21)
						arg_60_1:RecordAudio("304051015", var_63_21)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_304051", "304051015", "story_v_out_304051.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_304051", "304051015", "story_v_out_304051.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_22 = math.max(var_63_13, arg_60_1.talkMaxDuration)

			if var_63_12 <= arg_60_1.time_ and arg_60_1.time_ < var_63_12 + var_63_22 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_12) / var_63_22

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_12 + var_63_22 and arg_60_1.time_ < var_63_12 + var_63_22 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play304051016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 304051016
		arg_64_1.duration_ = 11.17

		local var_64_0 = {
			zh = 7.066,
			ja = 11.166
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
				arg_64_0:Play304051017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = arg_64_1.actors_["1059ui_story"]
			local var_67_1 = 0

			if var_67_1 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.characterEffect1059ui_story == nil then
				arg_64_1.var_.characterEffect1059ui_story = var_67_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_2 = 0.200000002980232

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_2 and not isNil(var_67_0) then
				local var_67_3 = (arg_64_1.time_ - var_67_1) / var_67_2

				if arg_64_1.var_.characterEffect1059ui_story and not isNil(var_67_0) then
					arg_64_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_64_1.time_ >= var_67_1 + var_67_2 and arg_64_1.time_ < var_67_1 + var_67_2 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.characterEffect1059ui_story then
				arg_64_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_67_4 = arg_64_1.actors_["1148ui_story"]
			local var_67_5 = 0

			if var_67_5 < arg_64_1.time_ and arg_64_1.time_ <= var_67_5 + arg_67_0 and not isNil(var_67_4) and arg_64_1.var_.characterEffect1148ui_story == nil then
				arg_64_1.var_.characterEffect1148ui_story = var_67_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_6 = 0.200000002980232

			if var_67_5 <= arg_64_1.time_ and arg_64_1.time_ < var_67_5 + var_67_6 and not isNil(var_67_4) then
				local var_67_7 = (arg_64_1.time_ - var_67_5) / var_67_6

				if arg_64_1.var_.characterEffect1148ui_story and not isNil(var_67_4) then
					local var_67_8 = Mathf.Lerp(0, 0.5, var_67_7)

					arg_64_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_64_1.var_.characterEffect1148ui_story.fillRatio = var_67_8
				end
			end

			if arg_64_1.time_ >= var_67_5 + var_67_6 and arg_64_1.time_ < var_67_5 + var_67_6 + arg_67_0 and not isNil(var_67_4) and arg_64_1.var_.characterEffect1148ui_story then
				local var_67_9 = 0.5

				arg_64_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_64_1.var_.characterEffect1148ui_story.fillRatio = var_67_9
			end

			local var_67_10 = 0

			if var_67_10 < arg_64_1.time_ and arg_64_1.time_ <= var_67_10 + arg_67_0 then
				arg_64_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action4_1")
			end

			local var_67_11 = 0
			local var_67_12 = 0.875

			if var_67_11 < arg_64_1.time_ and arg_64_1.time_ <= var_67_11 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_13 = arg_64_1:FormatText(StoryNameCfg[28].name)

				arg_64_1.leftNameTxt_.text = var_67_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_14 = arg_64_1:GetWordFromCfg(304051016)
				local var_67_15 = arg_64_1:FormatText(var_67_14.content)

				arg_64_1.text_.text = var_67_15

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_16 = 35
				local var_67_17 = utf8.len(var_67_15)
				local var_67_18 = var_67_16 <= 0 and var_67_12 or var_67_12 * (var_67_17 / var_67_16)

				if var_67_18 > 0 and var_67_12 < var_67_18 then
					arg_64_1.talkMaxDuration = var_67_18

					if var_67_18 + var_67_11 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_18 + var_67_11
					end
				end

				arg_64_1.text_.text = var_67_15
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304051", "304051016", "story_v_out_304051.awb") ~= 0 then
					local var_67_19 = manager.audio:GetVoiceLength("story_v_out_304051", "304051016", "story_v_out_304051.awb") / 1000

					if var_67_19 + var_67_11 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_19 + var_67_11
					end

					if var_67_14.prefab_name ~= "" and arg_64_1.actors_[var_67_14.prefab_name] ~= nil then
						local var_67_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_14.prefab_name].transform, "story_v_out_304051", "304051016", "story_v_out_304051.awb")

						arg_64_1:RecordAudio("304051016", var_67_20)
						arg_64_1:RecordAudio("304051016", var_67_20)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_304051", "304051016", "story_v_out_304051.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_304051", "304051016", "story_v_out_304051.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_21 = math.max(var_67_12, arg_64_1.talkMaxDuration)

			if var_67_11 <= arg_64_1.time_ and arg_64_1.time_ < var_67_11 + var_67_21 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_11) / var_67_21

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_11 + var_67_21 and arg_64_1.time_ < var_67_11 + var_67_21 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play304051017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 304051017
		arg_68_1.duration_ = 10.9

		local var_68_0 = {
			zh = 6.866,
			ja = 10.9
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
				arg_68_0:Play304051018(arg_68_1)
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

			local var_71_4 = arg_68_1.actors_["1059ui_story"]
			local var_71_5 = 0

			if var_71_5 < arg_68_1.time_ and arg_68_1.time_ <= var_71_5 + arg_71_0 and not isNil(var_71_4) and arg_68_1.var_.characterEffect1059ui_story == nil then
				arg_68_1.var_.characterEffect1059ui_story = var_71_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_6 = 0.200000002980232

			if var_71_5 <= arg_68_1.time_ and arg_68_1.time_ < var_71_5 + var_71_6 and not isNil(var_71_4) then
				local var_71_7 = (arg_68_1.time_ - var_71_5) / var_71_6

				if arg_68_1.var_.characterEffect1059ui_story and not isNil(var_71_4) then
					local var_71_8 = Mathf.Lerp(0, 0.5, var_71_7)

					arg_68_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_68_1.var_.characterEffect1059ui_story.fillRatio = var_71_8
				end
			end

			if arg_68_1.time_ >= var_71_5 + var_71_6 and arg_68_1.time_ < var_71_5 + var_71_6 + arg_71_0 and not isNil(var_71_4) and arg_68_1.var_.characterEffect1059ui_story then
				local var_71_9 = 0.5

				arg_68_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_68_1.var_.characterEffect1059ui_story.fillRatio = var_71_9
			end

			local var_71_10 = 0
			local var_71_11 = 0.775

			if var_71_10 < arg_68_1.time_ and arg_68_1.time_ <= var_71_10 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_12 = arg_68_1:FormatText(StoryNameCfg[8].name)

				arg_68_1.leftNameTxt_.text = var_71_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_13 = arg_68_1:GetWordFromCfg(304051017)
				local var_71_14 = arg_68_1:FormatText(var_71_13.content)

				arg_68_1.text_.text = var_71_14

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_15 = 31
				local var_71_16 = utf8.len(var_71_14)
				local var_71_17 = var_71_15 <= 0 and var_71_11 or var_71_11 * (var_71_16 / var_71_15)

				if var_71_17 > 0 and var_71_11 < var_71_17 then
					arg_68_1.talkMaxDuration = var_71_17

					if var_71_17 + var_71_10 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_17 + var_71_10
					end
				end

				arg_68_1.text_.text = var_71_14
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304051", "304051017", "story_v_out_304051.awb") ~= 0 then
					local var_71_18 = manager.audio:GetVoiceLength("story_v_out_304051", "304051017", "story_v_out_304051.awb") / 1000

					if var_71_18 + var_71_10 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_18 + var_71_10
					end

					if var_71_13.prefab_name ~= "" and arg_68_1.actors_[var_71_13.prefab_name] ~= nil then
						local var_71_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_13.prefab_name].transform, "story_v_out_304051", "304051017", "story_v_out_304051.awb")

						arg_68_1:RecordAudio("304051017", var_71_19)
						arg_68_1:RecordAudio("304051017", var_71_19)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_304051", "304051017", "story_v_out_304051.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_304051", "304051017", "story_v_out_304051.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_20 = math.max(var_71_11, arg_68_1.talkMaxDuration)

			if var_71_10 <= arg_68_1.time_ and arg_68_1.time_ < var_71_10 + var_71_20 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_10) / var_71_20

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_10 + var_71_20 and arg_68_1.time_ < var_71_10 + var_71_20 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play304051018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 304051018
		arg_72_1.duration_ = 6.2

		local var_72_0 = {
			zh = 5.5,
			ja = 6.2
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
				arg_72_0:Play304051019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = arg_72_1.actors_["1059ui_story"]
			local var_75_1 = 0

			if var_75_1 < arg_72_1.time_ and arg_72_1.time_ <= var_75_1 + arg_75_0 and not isNil(var_75_0) and arg_72_1.var_.characterEffect1059ui_story == nil then
				arg_72_1.var_.characterEffect1059ui_story = var_75_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_2 = 0.200000002980232

			if var_75_1 <= arg_72_1.time_ and arg_72_1.time_ < var_75_1 + var_75_2 and not isNil(var_75_0) then
				local var_75_3 = (arg_72_1.time_ - var_75_1) / var_75_2

				if arg_72_1.var_.characterEffect1059ui_story and not isNil(var_75_0) then
					arg_72_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_72_1.time_ >= var_75_1 + var_75_2 and arg_72_1.time_ < var_75_1 + var_75_2 + arg_75_0 and not isNil(var_75_0) and arg_72_1.var_.characterEffect1059ui_story then
				arg_72_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_75_4 = arg_72_1.actors_["1148ui_story"]
			local var_75_5 = 0

			if var_75_5 < arg_72_1.time_ and arg_72_1.time_ <= var_75_5 + arg_75_0 and not isNil(var_75_4) and arg_72_1.var_.characterEffect1148ui_story == nil then
				arg_72_1.var_.characterEffect1148ui_story = var_75_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_6 = 0.200000002980232

			if var_75_5 <= arg_72_1.time_ and arg_72_1.time_ < var_75_5 + var_75_6 and not isNil(var_75_4) then
				local var_75_7 = (arg_72_1.time_ - var_75_5) / var_75_6

				if arg_72_1.var_.characterEffect1148ui_story and not isNil(var_75_4) then
					local var_75_8 = Mathf.Lerp(0, 0.5, var_75_7)

					arg_72_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_72_1.var_.characterEffect1148ui_story.fillRatio = var_75_8
				end
			end

			if arg_72_1.time_ >= var_75_5 + var_75_6 and arg_72_1.time_ < var_75_5 + var_75_6 + arg_75_0 and not isNil(var_75_4) and arg_72_1.var_.characterEffect1148ui_story then
				local var_75_9 = 0.5

				arg_72_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_72_1.var_.characterEffect1148ui_story.fillRatio = var_75_9
			end

			local var_75_10 = 0

			if var_75_10 < arg_72_1.time_ and arg_72_1.time_ <= var_75_10 + arg_75_0 then
				arg_72_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action4_2")
			end

			local var_75_11 = 0

			if var_75_11 < arg_72_1.time_ and arg_72_1.time_ <= var_75_11 + arg_75_0 then
				arg_72_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_75_12 = 0
			local var_75_13 = 0.775

			if var_75_12 < arg_72_1.time_ and arg_72_1.time_ <= var_75_12 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_14 = arg_72_1:FormatText(StoryNameCfg[28].name)

				arg_72_1.leftNameTxt_.text = var_75_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_15 = arg_72_1:GetWordFromCfg(304051018)
				local var_75_16 = arg_72_1:FormatText(var_75_15.content)

				arg_72_1.text_.text = var_75_16

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_17 = 31
				local var_75_18 = utf8.len(var_75_16)
				local var_75_19 = var_75_17 <= 0 and var_75_13 or var_75_13 * (var_75_18 / var_75_17)

				if var_75_19 > 0 and var_75_13 < var_75_19 then
					arg_72_1.talkMaxDuration = var_75_19

					if var_75_19 + var_75_12 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_19 + var_75_12
					end
				end

				arg_72_1.text_.text = var_75_16
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304051", "304051018", "story_v_out_304051.awb") ~= 0 then
					local var_75_20 = manager.audio:GetVoiceLength("story_v_out_304051", "304051018", "story_v_out_304051.awb") / 1000

					if var_75_20 + var_75_12 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_20 + var_75_12
					end

					if var_75_15.prefab_name ~= "" and arg_72_1.actors_[var_75_15.prefab_name] ~= nil then
						local var_75_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_15.prefab_name].transform, "story_v_out_304051", "304051018", "story_v_out_304051.awb")

						arg_72_1:RecordAudio("304051018", var_75_21)
						arg_72_1:RecordAudio("304051018", var_75_21)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_304051", "304051018", "story_v_out_304051.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_304051", "304051018", "story_v_out_304051.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_22 = math.max(var_75_13, arg_72_1.talkMaxDuration)

			if var_75_12 <= arg_72_1.time_ and arg_72_1.time_ < var_75_12 + var_75_22 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_12) / var_75_22

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_12 + var_75_22 and arg_72_1.time_ < var_75_12 + var_75_22 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play304051019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 304051019
		arg_76_1.duration_ = 4.77

		local var_76_0 = {
			zh = 2.6,
			ja = 4.766
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
				arg_76_0:Play304051020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = arg_76_1.actors_["1148ui_story"]
			local var_79_1 = 0

			if var_79_1 < arg_76_1.time_ and arg_76_1.time_ <= var_79_1 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.characterEffect1148ui_story == nil then
				arg_76_1.var_.characterEffect1148ui_story = var_79_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_2 = 0.200000002980232

			if var_79_1 <= arg_76_1.time_ and arg_76_1.time_ < var_79_1 + var_79_2 and not isNil(var_79_0) then
				local var_79_3 = (arg_76_1.time_ - var_79_1) / var_79_2

				if arg_76_1.var_.characterEffect1148ui_story and not isNil(var_79_0) then
					arg_76_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_76_1.time_ >= var_79_1 + var_79_2 and arg_76_1.time_ < var_79_1 + var_79_2 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.characterEffect1148ui_story then
				arg_76_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_79_4 = arg_76_1.actors_["1059ui_story"]
			local var_79_5 = 0

			if var_79_5 < arg_76_1.time_ and arg_76_1.time_ <= var_79_5 + arg_79_0 and not isNil(var_79_4) and arg_76_1.var_.characterEffect1059ui_story == nil then
				arg_76_1.var_.characterEffect1059ui_story = var_79_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_6 = 0.200000002980232

			if var_79_5 <= arg_76_1.time_ and arg_76_1.time_ < var_79_5 + var_79_6 and not isNil(var_79_4) then
				local var_79_7 = (arg_76_1.time_ - var_79_5) / var_79_6

				if arg_76_1.var_.characterEffect1059ui_story and not isNil(var_79_4) then
					local var_79_8 = Mathf.Lerp(0, 0.5, var_79_7)

					arg_76_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_76_1.var_.characterEffect1059ui_story.fillRatio = var_79_8
				end
			end

			if arg_76_1.time_ >= var_79_5 + var_79_6 and arg_76_1.time_ < var_79_5 + var_79_6 + arg_79_0 and not isNil(var_79_4) and arg_76_1.var_.characterEffect1059ui_story then
				local var_79_9 = 0.5

				arg_76_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_76_1.var_.characterEffect1059ui_story.fillRatio = var_79_9
			end

			local var_79_10 = 0

			if var_79_10 < arg_76_1.time_ and arg_76_1.time_ <= var_79_10 + arg_79_0 then
				arg_76_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action456")
			end

			local var_79_11 = 0
			local var_79_12 = 0.2

			if var_79_11 < arg_76_1.time_ and arg_76_1.time_ <= var_79_11 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				local var_79_13 = arg_76_1:FormatText(StoryNameCfg[8].name)

				arg_76_1.leftNameTxt_.text = var_79_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_14 = arg_76_1:GetWordFromCfg(304051019)
				local var_79_15 = arg_76_1:FormatText(var_79_14.content)

				arg_76_1.text_.text = var_79_15

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_16 = 8
				local var_79_17 = utf8.len(var_79_15)
				local var_79_18 = var_79_16 <= 0 and var_79_12 or var_79_12 * (var_79_17 / var_79_16)

				if var_79_18 > 0 and var_79_12 < var_79_18 then
					arg_76_1.talkMaxDuration = var_79_18

					if var_79_18 + var_79_11 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_18 + var_79_11
					end
				end

				arg_76_1.text_.text = var_79_15
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304051", "304051019", "story_v_out_304051.awb") ~= 0 then
					local var_79_19 = manager.audio:GetVoiceLength("story_v_out_304051", "304051019", "story_v_out_304051.awb") / 1000

					if var_79_19 + var_79_11 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_19 + var_79_11
					end

					if var_79_14.prefab_name ~= "" and arg_76_1.actors_[var_79_14.prefab_name] ~= nil then
						local var_79_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_14.prefab_name].transform, "story_v_out_304051", "304051019", "story_v_out_304051.awb")

						arg_76_1:RecordAudio("304051019", var_79_20)
						arg_76_1:RecordAudio("304051019", var_79_20)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_304051", "304051019", "story_v_out_304051.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_304051", "304051019", "story_v_out_304051.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_21 = math.max(var_79_12, arg_76_1.talkMaxDuration)

			if var_79_11 <= arg_76_1.time_ and arg_76_1.time_ < var_79_11 + var_79_21 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_11) / var_79_21

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_11 + var_79_21 and arg_76_1.time_ < var_79_11 + var_79_21 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play304051020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 304051020
		arg_80_1.duration_ = 3.6

		local var_80_0 = {
			zh = 3.6,
			ja = 2.633
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
				arg_80_0:Play304051021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = 0
			local var_83_1 = 0.475

			if var_83_0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_0 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				local var_83_2 = arg_80_1:FormatText(StoryNameCfg[8].name)

				arg_80_1.leftNameTxt_.text = var_83_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_3 = arg_80_1:GetWordFromCfg(304051020)
				local var_83_4 = arg_80_1:FormatText(var_83_3.content)

				arg_80_1.text_.text = var_83_4

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_5 = 19
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

				if manager.audio:GetVoiceLength("story_v_out_304051", "304051020", "story_v_out_304051.awb") ~= 0 then
					local var_83_8 = manager.audio:GetVoiceLength("story_v_out_304051", "304051020", "story_v_out_304051.awb") / 1000

					if var_83_8 + var_83_0 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_8 + var_83_0
					end

					if var_83_3.prefab_name ~= "" and arg_80_1.actors_[var_83_3.prefab_name] ~= nil then
						local var_83_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_3.prefab_name].transform, "story_v_out_304051", "304051020", "story_v_out_304051.awb")

						arg_80_1:RecordAudio("304051020", var_83_9)
						arg_80_1:RecordAudio("304051020", var_83_9)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_304051", "304051020", "story_v_out_304051.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_304051", "304051020", "story_v_out_304051.awb")
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
	Play304051021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 304051021
		arg_84_1.duration_ = 5

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play304051022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = arg_84_1.actors_["1059ui_story"].transform
			local var_87_1 = 0

			if var_87_1 < arg_84_1.time_ and arg_84_1.time_ <= var_87_1 + arg_87_0 then
				arg_84_1.var_.moveOldPos1059ui_story = var_87_0.localPosition
			end

			local var_87_2 = 0.001

			if var_87_1 <= arg_84_1.time_ and arg_84_1.time_ < var_87_1 + var_87_2 then
				local var_87_3 = (arg_84_1.time_ - var_87_1) / var_87_2
				local var_87_4 = Vector3.New(0, 100, 0)

				var_87_0.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos1059ui_story, var_87_4, var_87_3)

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

			local var_87_9 = arg_84_1.actors_["1148ui_story"].transform
			local var_87_10 = 0

			if var_87_10 < arg_84_1.time_ and arg_84_1.time_ <= var_87_10 + arg_87_0 then
				arg_84_1.var_.moveOldPos1148ui_story = var_87_9.localPosition
			end

			local var_87_11 = 0.001

			if var_87_10 <= arg_84_1.time_ and arg_84_1.time_ < var_87_10 + var_87_11 then
				local var_87_12 = (arg_84_1.time_ - var_87_10) / var_87_11
				local var_87_13 = Vector3.New(0, 100, 0)

				var_87_9.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos1148ui_story, var_87_13, var_87_12)

				local var_87_14 = manager.ui.mainCamera.transform.position - var_87_9.position

				var_87_9.forward = Vector3.New(var_87_14.x, var_87_14.y, var_87_14.z)

				local var_87_15 = var_87_9.localEulerAngles

				var_87_15.z = 0
				var_87_15.x = 0
				var_87_9.localEulerAngles = var_87_15
			end

			if arg_84_1.time_ >= var_87_10 + var_87_11 and arg_84_1.time_ < var_87_10 + var_87_11 + arg_87_0 then
				var_87_9.localPosition = Vector3.New(0, 100, 0)

				local var_87_16 = manager.ui.mainCamera.transform.position - var_87_9.position

				var_87_9.forward = Vector3.New(var_87_16.x, var_87_16.y, var_87_16.z)

				local var_87_17 = var_87_9.localEulerAngles

				var_87_17.z = 0
				var_87_17.x = 0
				var_87_9.localEulerAngles = var_87_17
			end

			local var_87_18 = arg_84_1.actors_["1148ui_story"]
			local var_87_19 = 0

			if var_87_19 < arg_84_1.time_ and arg_84_1.time_ <= var_87_19 + arg_87_0 and not isNil(var_87_18) and arg_84_1.var_.characterEffect1148ui_story == nil then
				arg_84_1.var_.characterEffect1148ui_story = var_87_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_20 = 0.200000002980232

			if var_87_19 <= arg_84_1.time_ and arg_84_1.time_ < var_87_19 + var_87_20 and not isNil(var_87_18) then
				local var_87_21 = (arg_84_1.time_ - var_87_19) / var_87_20

				if arg_84_1.var_.characterEffect1148ui_story and not isNil(var_87_18) then
					local var_87_22 = Mathf.Lerp(0, 0.5, var_87_21)

					arg_84_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_84_1.var_.characterEffect1148ui_story.fillRatio = var_87_22
				end
			end

			if arg_84_1.time_ >= var_87_19 + var_87_20 and arg_84_1.time_ < var_87_19 + var_87_20 + arg_87_0 and not isNil(var_87_18) and arg_84_1.var_.characterEffect1148ui_story then
				local var_87_23 = 0.5

				arg_84_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_84_1.var_.characterEffect1148ui_story.fillRatio = var_87_23
			end

			local var_87_24 = 0
			local var_87_25 = 1.45

			if var_87_24 < arg_84_1.time_ and arg_84_1.time_ <= var_87_24 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, false)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_26 = arg_84_1:GetWordFromCfg(304051021)
				local var_87_27 = arg_84_1:FormatText(var_87_26.content)

				arg_84_1.text_.text = var_87_27

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_28 = 58
				local var_87_29 = utf8.len(var_87_27)
				local var_87_30 = var_87_28 <= 0 and var_87_25 or var_87_25 * (var_87_29 / var_87_28)

				if var_87_30 > 0 and var_87_25 < var_87_30 then
					arg_84_1.talkMaxDuration = var_87_30

					if var_87_30 + var_87_24 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_30 + var_87_24
					end
				end

				arg_84_1.text_.text = var_87_27
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)
				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_31 = math.max(var_87_25, arg_84_1.talkMaxDuration)

			if var_87_24 <= arg_84_1.time_ and arg_84_1.time_ < var_87_24 + var_87_31 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_24) / var_87_31

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_24 + var_87_31 and arg_84_1.time_ < var_87_24 + var_87_31 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1059ui_story",
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

		arg_84_1:InitPlayNodeList()
	end,
	Play304051022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 304051022
		arg_88_1.duration_ = 5.7

		local var_88_0 = {
			zh = 5.333,
			ja = 5.7
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
			arg_88_1.auto_ = false
		end

		function arg_88_1.playNext_(arg_90_0)
			arg_88_1.onStoryFinished_()
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = arg_88_1.actors_["1059ui_story"].transform
			local var_91_1 = 0

			if var_91_1 < arg_88_1.time_ and arg_88_1.time_ <= var_91_1 + arg_91_0 then
				arg_88_1.var_.moveOldPos1059ui_story = var_91_0.localPosition
			end

			local var_91_2 = 0.001

			if var_91_1 <= arg_88_1.time_ and arg_88_1.time_ < var_91_1 + var_91_2 then
				local var_91_3 = (arg_88_1.time_ - var_91_1) / var_91_2
				local var_91_4 = Vector3.New(0, -1.05, -6)

				var_91_0.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos1059ui_story, var_91_4, var_91_3)

				local var_91_5 = manager.ui.mainCamera.transform.position - var_91_0.position

				var_91_0.forward = Vector3.New(var_91_5.x, var_91_5.y, var_91_5.z)

				local var_91_6 = var_91_0.localEulerAngles

				var_91_6.z = 0
				var_91_6.x = 0
				var_91_0.localEulerAngles = var_91_6
			end

			if arg_88_1.time_ >= var_91_1 + var_91_2 and arg_88_1.time_ < var_91_1 + var_91_2 + arg_91_0 then
				var_91_0.localPosition = Vector3.New(0, -1.05, -6)

				local var_91_7 = manager.ui.mainCamera.transform.position - var_91_0.position

				var_91_0.forward = Vector3.New(var_91_7.x, var_91_7.y, var_91_7.z)

				local var_91_8 = var_91_0.localEulerAngles

				var_91_8.z = 0
				var_91_8.x = 0
				var_91_0.localEulerAngles = var_91_8
			end

			local var_91_9 = arg_88_1.actors_["1059ui_story"]
			local var_91_10 = 0

			if var_91_10 < arg_88_1.time_ and arg_88_1.time_ <= var_91_10 + arg_91_0 and not isNil(var_91_9) and arg_88_1.var_.characterEffect1059ui_story == nil then
				arg_88_1.var_.characterEffect1059ui_story = var_91_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_11 = 0.200000002980232

			if var_91_10 <= arg_88_1.time_ and arg_88_1.time_ < var_91_10 + var_91_11 and not isNil(var_91_9) then
				local var_91_12 = (arg_88_1.time_ - var_91_10) / var_91_11

				if arg_88_1.var_.characterEffect1059ui_story and not isNil(var_91_9) then
					arg_88_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_88_1.time_ >= var_91_10 + var_91_11 and arg_88_1.time_ < var_91_10 + var_91_11 + arg_91_0 and not isNil(var_91_9) and arg_88_1.var_.characterEffect1059ui_story then
				arg_88_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_91_13 = 0

			if var_91_13 < arg_88_1.time_ and arg_88_1.time_ <= var_91_13 + arg_91_0 then
				arg_88_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action7_1")
			end

			local var_91_14 = 0

			if var_91_14 < arg_88_1.time_ and arg_88_1.time_ <= var_91_14 + arg_91_0 then
				arg_88_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_91_15 = 0
			local var_91_16 = 0.725

			if var_91_15 < arg_88_1.time_ and arg_88_1.time_ <= var_91_15 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				local var_91_17 = arg_88_1:FormatText(StoryNameCfg[28].name)

				arg_88_1.leftNameTxt_.text = var_91_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_18 = arg_88_1:GetWordFromCfg(304051022)
				local var_91_19 = arg_88_1:FormatText(var_91_18.content)

				arg_88_1.text_.text = var_91_19

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_20 = 29
				local var_91_21 = utf8.len(var_91_19)
				local var_91_22 = var_91_20 <= 0 and var_91_16 or var_91_16 * (var_91_21 / var_91_20)

				if var_91_22 > 0 and var_91_16 < var_91_22 then
					arg_88_1.talkMaxDuration = var_91_22

					if var_91_22 + var_91_15 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_22 + var_91_15
					end
				end

				arg_88_1.text_.text = var_91_19
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304051", "304051022", "story_v_out_304051.awb") ~= 0 then
					local var_91_23 = manager.audio:GetVoiceLength("story_v_out_304051", "304051022", "story_v_out_304051.awb") / 1000

					if var_91_23 + var_91_15 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_23 + var_91_15
					end

					if var_91_18.prefab_name ~= "" and arg_88_1.actors_[var_91_18.prefab_name] ~= nil then
						local var_91_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_18.prefab_name].transform, "story_v_out_304051", "304051022", "story_v_out_304051.awb")

						arg_88_1:RecordAudio("304051022", var_91_24)
						arg_88_1:RecordAudio("304051022", var_91_24)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_304051", "304051022", "story_v_out_304051.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_304051", "304051022", "story_v_out_304051.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_25 = math.max(var_91_16, arg_88_1.talkMaxDuration)

			if var_91_15 <= arg_88_1.time_ and arg_88_1.time_ < var_91_15 + var_91_25 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_15) / var_91_25

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_15 + var_91_25 and arg_88_1.time_ < var_91_15 + var_91_25 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {
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

		arg_88_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B04b"
	},
	voices = {
		"story_v_out_304051.awb"
	}
}
