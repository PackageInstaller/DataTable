return {
	Play322242001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 322242001
		arg_1_1.duration_ = 7.63

		local var_1_0 = {
			zh = 6.400000333332,
			ja = 7.62500033333333
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
				arg_1_0:Play322242002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = 4.40000033333333

			if var_4_0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_1 = 0.3

			if arg_1_1.time_ >= var_4_0 + var_4_1 and arg_1_1.time_ < var_4_0 + var_4_1 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_2 = "1029ui_story"

			if arg_1_1.actors_[var_4_2] == nil then
				local var_4_3 = Asset.Load("Char/" .. "1029ui_story")

				if not isNil(var_4_3) then
					local var_4_4 = Object.Instantiate(Asset.Load("Char/" .. "1029ui_story"), arg_1_1.stage_.transform)

					var_4_4.name = var_4_2
					var_4_4.transform.localPosition = Vector3.New(0, 100, 0)
					arg_1_1.actors_[var_4_2] = var_4_4

					local var_4_5 = var_4_4:GetComponentInChildren(typeof(CharacterEffect))

					var_4_5.enabled = true

					local var_4_6 = GameObjectTools.GetOrAddComponent(var_4_4, typeof(DynamicBoneHelper))

					if var_4_6 then
						var_4_6:EnableDynamicBone(false)
					end

					arg_1_1:ShowWeapon(var_4_5.transform, false)

					arg_1_1.var_[var_4_2 .. "Animator"] = var_4_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_1_1.var_[var_4_2 .. "Animator"].applyRootMotion = true
					arg_1_1.var_[var_4_2 .. "LipSync"] = var_4_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_4_7 = arg_1_1.actors_["1029ui_story"].transform
			local var_4_8 = 4.40000033333333

			if var_4_8 < arg_1_1.time_ and arg_1_1.time_ <= var_4_8 + arg_4_0 then
				arg_1_1.var_.moveOldPos1029ui_story = var_4_7.localPosition
			end

			local var_4_9 = 0.001

			if var_4_8 <= arg_1_1.time_ and arg_1_1.time_ < var_4_8 + var_4_9 then
				local var_4_10 = (arg_1_1.time_ - var_4_8) / var_4_9
				local var_4_11 = Vector3.New(0, -1.09, -6.2)

				var_4_7.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1029ui_story, var_4_11, var_4_10)

				local var_4_12 = manager.ui.mainCamera.transform.position - var_4_7.position

				var_4_7.forward = Vector3.New(var_4_12.x, var_4_12.y, var_4_12.z)

				local var_4_13 = var_4_7.localEulerAngles

				var_4_13.z = 0
				var_4_13.x = 0
				var_4_7.localEulerAngles = var_4_13
			end

			if arg_1_1.time_ >= var_4_8 + var_4_9 and arg_1_1.time_ < var_4_8 + var_4_9 + arg_4_0 then
				var_4_7.localPosition = Vector3.New(0, -1.09, -6.2)

				local var_4_14 = manager.ui.mainCamera.transform.position - var_4_7.position

				var_4_7.forward = Vector3.New(var_4_14.x, var_4_14.y, var_4_14.z)

				local var_4_15 = var_4_7.localEulerAngles

				var_4_15.z = 0
				var_4_15.x = 0
				var_4_7.localEulerAngles = var_4_15
			end

			local var_4_16 = arg_1_1.actors_["1029ui_story"]
			local var_4_17 = 4.40000033333333

			if var_4_17 < arg_1_1.time_ and arg_1_1.time_ <= var_4_17 + arg_4_0 and not isNil(var_4_16) and arg_1_1.var_.characterEffect1029ui_story == nil then
				arg_1_1.var_.characterEffect1029ui_story = var_4_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_18 = 0.200000002980232

			if var_4_17 <= arg_1_1.time_ and arg_1_1.time_ < var_4_17 + var_4_18 and not isNil(var_4_16) then
				local var_4_19 = (arg_1_1.time_ - var_4_17) / var_4_18

				if arg_1_1.var_.characterEffect1029ui_story and not isNil(var_4_16) then
					arg_1_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_17 + var_4_18 and arg_1_1.time_ < var_4_17 + var_4_18 + arg_4_0 and not isNil(var_4_16) and arg_1_1.var_.characterEffect1029ui_story then
				arg_1_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_4_20 = 4.40000033333333

			if var_4_20 < arg_1_1.time_ and arg_1_1.time_ <= var_4_20 + arg_4_0 then
				arg_1_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action1_1")
			end

			local var_4_21 = 4.40000033333333

			if var_4_21 < arg_1_1.time_ and arg_1_1.time_ <= var_4_21 + arg_4_0 then
				arg_1_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_4_22 = 0

			arg_1_1.isInRecall_ = false

			if var_4_22 < arg_1_1.time_ and arg_1_1.time_ <= var_4_22 + arg_4_0 then
				arg_1_1.screenFilterGo_:SetActive(true)

				arg_1_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")

				for iter_4_0, iter_4_1 in pairs(arg_1_1.actors_) do
					local var_4_23 = iter_4_1:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_4_2, iter_4_3 in ipairs(var_4_23) do
						if iter_4_3.color.r > 0.51 then
							iter_4_3.color = Color.New(1, 1, 1)
						else
							iter_4_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_4_24 = 0.0166666666666667

			if var_4_22 <= arg_1_1.time_ and arg_1_1.time_ < var_4_22 + var_4_24 then
				local var_4_25 = (arg_1_1.time_ - var_4_22) / var_4_24

				arg_1_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, var_4_25)
			end

			if arg_1_1.time_ >= var_4_22 + var_4_24 and arg_1_1.time_ < var_4_22 + var_4_24 + arg_4_0 then
				arg_1_1.screenFilterEffect_.weight = 1
			end

			local var_4_26 = 0
			local var_4_27 = 0.3

			if var_4_26 < arg_1_1.time_ and arg_1_1.time_ <= var_4_26 + arg_4_0 then
				local var_4_28 = "play"
				local var_4_29 = "music"

				arg_1_1:AudioAction(var_4_28, var_4_29, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_30 = ""
				local var_4_31 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_31 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_31 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_31

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_31
						arg_1_1.bgmTxt2_.text = var_4_31
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

			local var_4_32 = 0.500666666666667
			local var_4_33 = 1

			if var_4_32 < arg_1_1.time_ and arg_1_1.time_ <= var_4_32 + arg_4_0 then
				local var_4_34 = "play"
				local var_4_35 = "music"

				arg_1_1:AudioAction(var_4_34, var_4_35, "bgm_activity_4_5_story_ainsoph_first", "bgm_activity_4_5_story_ainsoph_first", "bgm_activity_4_5_story_ainsoph_first.awb")

				local var_4_36 = ""
				local var_4_37 = manager.audio:GetAudioName("bgm_activity_4_5_story_ainsoph_first", "bgm_activity_4_5_story_ainsoph_first")

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
				local var_4_41 = "effect"

				arg_1_1:AudioAction(var_4_40, var_4_41, "se_story_side_1075", "se_story_side_1075_morningloop", "")
			end

			local var_4_42 = 0
			local var_4_43 = 1.999999999999
			local var_4_44 = "ST0504"

			if var_4_42 < arg_1_1.time_ and arg_1_1.time_ <= var_4_42 + arg_4_0 then
				arg_1_1.timestampController_:SetSelectedState("show")
				arg_1_1.timestampAni_:Play("in")

				arg_1_1.timeTicketbgImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_44)

				arg_1_1.timestampColorController_:SetSelectedState("cold")
				arg_1_1.timeColdImg_:SetAlpha(0.031)

				local var_4_45 = arg_1_1:GetWordFromCfg(501090)
				local var_4_46 = arg_1_1:FormatText(var_4_45.content)

				arg_1_1.text_timeText_.text = var_4_46

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_timeText_)

				local var_4_47 = arg_1_1:GetWordFromCfg(501091)
				local var_4_48 = arg_1_1:FormatText(var_4_47.content)

				arg_1_1.text_siteText_.text = var_4_48

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_siteText_)
			end

			if arg_1_1.time_ >= var_4_42 + var_4_43 and arg_1_1.time_ < var_4_42 + var_4_43 + arg_4_0 then
				AnimatorTools.PlayAnimationWithCallback(arg_1_1.timestampAni_, "out", function()
					arg_1_1.timestampController_:SetSelectedState("hide")
				end)
			end

			local var_4_49 = 2.00000033333333

			if var_4_49 < arg_1_1.time_ and arg_1_1.time_ <= var_4_49 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_50 = 1.2

			if var_4_49 <= arg_1_1.time_ and arg_1_1.time_ < var_4_49 + var_4_50 then
				local var_4_51 = (arg_1_1.time_ - var_4_49) / var_4_50
				local var_4_52 = Color.New(0, 0, 0)

				var_4_52.a = Mathf.Lerp(0, 1, var_4_51)
				arg_1_1.mask_.color = var_4_52
			end

			if arg_1_1.time_ >= var_4_49 + var_4_50 and arg_1_1.time_ < var_4_49 + var_4_50 + arg_4_0 then
				local var_4_53 = Color.New(0, 0, 0)

				var_4_53.a = 1
				arg_1_1.mask_.color = var_4_53
			end

			local var_4_54 = 3.20000033333333

			if var_4_54 < arg_1_1.time_ and arg_1_1.time_ <= var_4_54 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_55 = 1.2

			if var_4_54 <= arg_1_1.time_ and arg_1_1.time_ < var_4_54 + var_4_55 then
				local var_4_56 = (arg_1_1.time_ - var_4_54) / var_4_55
				local var_4_57 = Color.New(0, 0, 0)

				var_4_57.a = Mathf.Lerp(1, 0, var_4_56)
				arg_1_1.mask_.color = var_4_57
			end

			if arg_1_1.time_ >= var_4_54 + var_4_55 and arg_1_1.time_ < var_4_54 + var_4_55 + arg_4_0 then
				local var_4_58 = Color.New(0, 0, 0)
				local var_4_59 = 0

				arg_1_1.mask_.enabled = false
				var_4_58.a = var_4_59
				arg_1_1.mask_.color = var_4_58
			end

			local var_4_60 = "ST0504"

			if arg_1_1.bgs_[var_4_60] == nil then
				local var_4_61 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_61:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_60)
				var_4_61.name = var_4_60
				var_4_61.transform.parent = arg_1_1.stage_.transform
				var_4_61.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_60] = var_4_61
			end

			local var_4_62 = 0

			if var_4_62 < arg_1_1.time_ and arg_1_1.time_ <= var_4_62 + arg_4_0 then
				local var_4_63 = manager.ui.mainCamera.transform.localPosition
				local var_4_64 = Vector3.New(0, 0, 10) + Vector3.New(var_4_63.x, var_4_63.y, 0)
				local var_4_65 = arg_1_1.bgs_.ST0504

				var_4_65.transform.localPosition = var_4_64
				var_4_65.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_66 = var_4_65:GetComponent("SpriteRenderer")

				if var_4_66 and var_4_66.sprite then
					local var_4_67 = (var_4_65.transform.localPosition - var_4_63).z
					local var_4_68 = manager.ui.mainCameraCom_
					local var_4_69 = 2 * var_4_67 * Mathf.Tan(var_4_68.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_4_70 = var_4_69 * var_4_68.aspect
					local var_4_71 = var_4_66.sprite.bounds.size.x
					local var_4_72 = var_4_66.sprite.bounds.size.y
					local var_4_73 = var_4_70 / var_4_71
					local var_4_74 = var_4_69 / var_4_72
					local var_4_75 = var_4_74 < var_4_73 and var_4_73 or var_4_74

					var_4_65.transform.localScale = Vector3.New(var_4_75, var_4_75, 0)
				end

				for iter_4_4, iter_4_5 in pairs(arg_1_1.bgs_) do
					if iter_4_4 ~= "ST0504" then
						iter_4_5.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_76 = 4.42500033333333
			local var_4_77 = 0.275

			if var_4_76 < arg_1_1.time_ and arg_1_1.time_ <= var_4_76 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_78 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_78:setOnUpdate(LuaHelper.FloatAction(function(arg_8_0)
					arg_1_1.dialogCg_.alpha = arg_8_0
				end))
				var_4_78:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_78:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_79 = arg_1_1:FormatText(StoryNameCfg[319].name)

				arg_1_1.leftNameTxt_.text = var_4_79

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_80 = arg_1_1:GetWordFromCfg(322242001)
				local var_4_81 = arg_1_1:FormatText(var_4_80.content)

				arg_1_1.text_.text = var_4_81

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_82 = 11
				local var_4_83 = utf8.len(var_4_81)
				local var_4_84 = var_4_82 <= 0 and var_4_77 or var_4_77 * (var_4_83 / var_4_82)

				if var_4_84 > 0 and var_4_77 < var_4_84 then
					arg_1_1.talkMaxDuration = var_4_84
					var_4_76 = var_4_76 + 0.3

					if var_4_84 + var_4_76 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_84 + var_4_76
					end
				end

				arg_1_1.text_.text = var_4_81
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322242", "322242001", "story_v_out_322242.awb") ~= 0 then
					local var_4_85 = manager.audio:GetVoiceLength("story_v_out_322242", "322242001", "story_v_out_322242.awb") / 1000

					if var_4_85 + var_4_76 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_85 + var_4_76
					end

					if var_4_80.prefab_name ~= "" and arg_1_1.actors_[var_4_80.prefab_name] ~= nil then
						local var_4_86 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_80.prefab_name].transform, "story_v_out_322242", "322242001", "story_v_out_322242.awb")

						arg_1_1:RecordAudio("322242001", var_4_86)
						arg_1_1:RecordAudio("322242001", var_4_86)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_322242", "322242001", "story_v_out_322242.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_322242", "322242001", "story_v_out_322242.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_87 = var_4_76 + 0.3
			local var_4_88 = math.max(var_4_77, arg_1_1.talkMaxDuration)

			if var_4_87 <= arg_1_1.time_ and arg_1_1.time_ < var_4_87 + var_4_88 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_87) / var_4_88

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_87 + var_4_88 and arg_1_1.time_ < var_4_87 + var_4_88 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 4.40000033333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play322242002 = function(arg_10_0, arg_10_1)
		arg_10_1.time_ = 0
		arg_10_1.frameCnt_ = 0
		arg_10_1.state_ = "playing"
		arg_10_1.curTalkId_ = 322242002
		arg_10_1.duration_ = 5

		SetActive(arg_10_1.tipsGo_, false)

		function arg_10_1.onSingleLineFinish_()
			arg_10_1.onSingleLineUpdate_ = nil
			arg_10_1.onSingleLineFinish_ = nil
			arg_10_1.state_ = "waiting"
		end

		function arg_10_1.playNext_(arg_12_0)
			if arg_12_0 == 1 then
				arg_10_0:Play322242003(arg_10_1)
			end
		end

		function arg_10_1.onSingleLineUpdate_(arg_13_0)
			local var_13_0 = arg_10_1.actors_["1029ui_story"].transform
			local var_13_1 = 0

			if var_13_1 < arg_10_1.time_ and arg_10_1.time_ <= var_13_1 + arg_13_0 then
				arg_10_1.var_.moveOldPos1029ui_story = var_13_0.localPosition
			end

			local var_13_2 = 0.001

			if var_13_1 <= arg_10_1.time_ and arg_10_1.time_ < var_13_1 + var_13_2 then
				local var_13_3 = (arg_10_1.time_ - var_13_1) / var_13_2
				local var_13_4 = Vector3.New(0, 100, 0)

				var_13_0.localPosition = Vector3.Lerp(arg_10_1.var_.moveOldPos1029ui_story, var_13_4, var_13_3)

				local var_13_5 = manager.ui.mainCamera.transform.position - var_13_0.position

				var_13_0.forward = Vector3.New(var_13_5.x, var_13_5.y, var_13_5.z)

				local var_13_6 = var_13_0.localEulerAngles

				var_13_6.z = 0
				var_13_6.x = 0
				var_13_0.localEulerAngles = var_13_6
			end

			if arg_10_1.time_ >= var_13_1 + var_13_2 and arg_10_1.time_ < var_13_1 + var_13_2 + arg_13_0 then
				var_13_0.localPosition = Vector3.New(0, 100, 0)

				local var_13_7 = manager.ui.mainCamera.transform.position - var_13_0.position

				var_13_0.forward = Vector3.New(var_13_7.x, var_13_7.y, var_13_7.z)

				local var_13_8 = var_13_0.localEulerAngles

				var_13_8.z = 0
				var_13_8.x = 0
				var_13_0.localEulerAngles = var_13_8
			end

			local var_13_9 = 0
			local var_13_10 = 1.725

			if var_13_9 < arg_10_1.time_ and arg_10_1.time_ <= var_13_9 + arg_13_0 then
				arg_10_1.talkMaxDuration = 0
				arg_10_1.dialogCg_.alpha = 1

				arg_10_1.dialog_:SetActive(true)
				SetActive(arg_10_1.leftNameGo_, false)

				arg_10_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_10_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_10_1:RecordName(arg_10_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_10_1.iconTrs_.gameObject, false)
				arg_10_1.callingController_:SetSelectedState("normal")

				local var_13_11 = arg_10_1:GetWordFromCfg(322242002)
				local var_13_12 = arg_10_1:FormatText(var_13_11.content)

				arg_10_1.text_.text = var_13_12

				LuaForUtil.ClearLinePrefixSymbol(arg_10_1.text_)

				local var_13_13 = 69
				local var_13_14 = utf8.len(var_13_12)
				local var_13_15 = var_13_13 <= 0 and var_13_10 or var_13_10 * (var_13_14 / var_13_13)

				if var_13_15 > 0 and var_13_10 < var_13_15 then
					arg_10_1.talkMaxDuration = var_13_15

					if var_13_15 + var_13_9 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_15 + var_13_9
					end
				end

				arg_10_1.text_.text = var_13_12
				arg_10_1.typewritter.percent = 0

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(false)
				arg_10_1:RecordContent(arg_10_1.text_.text)
			end

			local var_13_16 = math.max(var_13_10, arg_10_1.talkMaxDuration)

			if var_13_9 <= arg_10_1.time_ and arg_10_1.time_ < var_13_9 + var_13_16 then
				arg_10_1.typewritter.percent = (arg_10_1.time_ - var_13_9) / var_13_16

				arg_10_1.typewritter:SetDirty()
			end

			if arg_10_1.time_ >= var_13_9 + var_13_16 and arg_10_1.time_ < var_13_9 + var_13_16 + arg_13_0 then
				arg_10_1.typewritter.percent = 1

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(true)
			end
		end

		arg_10_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_10_1:InitPlayNodeList()
	end,
	Play322242003 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 322242003
		arg_14_1.duration_ = 9.83

		local var_14_0 = {
			zh = 9.233,
			ja = 9.833
		}
		local var_14_1 = manager.audio:GetLocalizationFlag()

		if var_14_0[var_14_1] ~= nil then
			arg_14_1.duration_ = var_14_0[var_14_1]
		end

		SetActive(arg_14_1.tipsGo_, false)

		function arg_14_1.onSingleLineFinish_()
			arg_14_1.onSingleLineUpdate_ = nil
			arg_14_1.onSingleLineFinish_ = nil
			arg_14_1.state_ = "waiting"
		end

		function arg_14_1.playNext_(arg_16_0)
			if arg_16_0 == 1 then
				arg_14_0:Play322242004(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			local var_17_0 = arg_14_1.actors_["1029ui_story"].transform
			local var_17_1 = 0

			if var_17_1 < arg_14_1.time_ and arg_14_1.time_ <= var_17_1 + arg_17_0 then
				arg_14_1.var_.moveOldPos1029ui_story = var_17_0.localPosition
			end

			local var_17_2 = 0.001

			if var_17_1 <= arg_14_1.time_ and arg_14_1.time_ < var_17_1 + var_17_2 then
				local var_17_3 = (arg_14_1.time_ - var_17_1) / var_17_2
				local var_17_4 = Vector3.New(0, -1.09, -6.2)

				var_17_0.localPosition = Vector3.Lerp(arg_14_1.var_.moveOldPos1029ui_story, var_17_4, var_17_3)

				local var_17_5 = manager.ui.mainCamera.transform.position - var_17_0.position

				var_17_0.forward = Vector3.New(var_17_5.x, var_17_5.y, var_17_5.z)

				local var_17_6 = var_17_0.localEulerAngles

				var_17_6.z = 0
				var_17_6.x = 0
				var_17_0.localEulerAngles = var_17_6
			end

			if arg_14_1.time_ >= var_17_1 + var_17_2 and arg_14_1.time_ < var_17_1 + var_17_2 + arg_17_0 then
				var_17_0.localPosition = Vector3.New(0, -1.09, -6.2)

				local var_17_7 = manager.ui.mainCamera.transform.position - var_17_0.position

				var_17_0.forward = Vector3.New(var_17_7.x, var_17_7.y, var_17_7.z)

				local var_17_8 = var_17_0.localEulerAngles

				var_17_8.z = 0
				var_17_8.x = 0
				var_17_0.localEulerAngles = var_17_8
			end

			local var_17_9 = arg_14_1.actors_["1029ui_story"]
			local var_17_10 = 0

			if var_17_10 < arg_14_1.time_ and arg_14_1.time_ <= var_17_10 + arg_17_0 and not isNil(var_17_9) and arg_14_1.var_.characterEffect1029ui_story == nil then
				arg_14_1.var_.characterEffect1029ui_story = var_17_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_17_11 = 0.200000002980232

			if var_17_10 <= arg_14_1.time_ and arg_14_1.time_ < var_17_10 + var_17_11 and not isNil(var_17_9) then
				local var_17_12 = (arg_14_1.time_ - var_17_10) / var_17_11

				if arg_14_1.var_.characterEffect1029ui_story and not isNil(var_17_9) then
					arg_14_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_14_1.time_ >= var_17_10 + var_17_11 and arg_14_1.time_ < var_17_10 + var_17_11 + arg_17_0 and not isNil(var_17_9) and arg_14_1.var_.characterEffect1029ui_story then
				arg_14_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_17_13 = 0

			if var_17_13 < arg_14_1.time_ and arg_14_1.time_ <= var_17_13 + arg_17_0 then
				arg_14_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action2_1")
			end

			local var_17_14 = 0

			if var_17_14 < arg_14_1.time_ and arg_14_1.time_ <= var_17_14 + arg_17_0 then
				arg_14_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_17_15 = 0
			local var_17_16 = 0.975

			if var_17_15 < arg_14_1.time_ and arg_14_1.time_ <= var_17_15 + arg_17_0 then
				arg_14_1.talkMaxDuration = 0
				arg_14_1.dialogCg_.alpha = 1

				arg_14_1.dialog_:SetActive(true)
				SetActive(arg_14_1.leftNameGo_, true)

				local var_17_17 = arg_14_1:FormatText(StoryNameCfg[319].name)

				arg_14_1.leftNameTxt_.text = var_17_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_14_1.leftNameTxt_.transform)

				arg_14_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_14_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_14_1:RecordName(arg_14_1.leftNameTxt_.text)
				SetActive(arg_14_1.iconTrs_.gameObject, false)
				arg_14_1.callingController_:SetSelectedState("normal")

				local var_17_18 = arg_14_1:GetWordFromCfg(322242003)
				local var_17_19 = arg_14_1:FormatText(var_17_18.content)

				arg_14_1.text_.text = var_17_19

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.text_)

				local var_17_20 = 39
				local var_17_21 = utf8.len(var_17_19)
				local var_17_22 = var_17_20 <= 0 and var_17_16 or var_17_16 * (var_17_21 / var_17_20)

				if var_17_22 > 0 and var_17_16 < var_17_22 then
					arg_14_1.talkMaxDuration = var_17_22

					if var_17_22 + var_17_15 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_22 + var_17_15
					end
				end

				arg_14_1.text_.text = var_17_19
				arg_14_1.typewritter.percent = 0

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322242", "322242003", "story_v_out_322242.awb") ~= 0 then
					local var_17_23 = manager.audio:GetVoiceLength("story_v_out_322242", "322242003", "story_v_out_322242.awb") / 1000

					if var_17_23 + var_17_15 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_23 + var_17_15
					end

					if var_17_18.prefab_name ~= "" and arg_14_1.actors_[var_17_18.prefab_name] ~= nil then
						local var_17_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_14_1.actors_[var_17_18.prefab_name].transform, "story_v_out_322242", "322242003", "story_v_out_322242.awb")

						arg_14_1:RecordAudio("322242003", var_17_24)
						arg_14_1:RecordAudio("322242003", var_17_24)
					else
						arg_14_1:AudioAction("play", "voice", "story_v_out_322242", "322242003", "story_v_out_322242.awb")
					end

					arg_14_1:RecordHistoryTalkVoice("story_v_out_322242", "322242003", "story_v_out_322242.awb")
				end

				arg_14_1:RecordContent(arg_14_1.text_.text)
			end

			local var_17_25 = math.max(var_17_16, arg_14_1.talkMaxDuration)

			if var_17_15 <= arg_14_1.time_ and arg_14_1.time_ < var_17_15 + var_17_25 then
				arg_14_1.typewritter.percent = (arg_14_1.time_ - var_17_15) / var_17_25

				arg_14_1.typewritter:SetDirty()
			end

			if arg_14_1.time_ >= var_17_15 + var_17_25 and arg_14_1.time_ < var_17_15 + var_17_25 + arg_17_0 then
				arg_14_1.typewritter.percent = 1

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(true)
			end
		end

		arg_14_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_14_1:InitPlayNodeList()
	end,
	Play322242004 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 322242004
		arg_18_1.duration_ = 5.7

		local var_18_0 = {
			zh = 3.5,
			ja = 5.7
		}
		local var_18_1 = manager.audio:GetLocalizationFlag()

		if var_18_0[var_18_1] ~= nil then
			arg_18_1.duration_ = var_18_0[var_18_1]
		end

		SetActive(arg_18_1.tipsGo_, false)

		function arg_18_1.onSingleLineFinish_()
			arg_18_1.onSingleLineUpdate_ = nil
			arg_18_1.onSingleLineFinish_ = nil
			arg_18_1.state_ = "waiting"
		end

		function arg_18_1.playNext_(arg_20_0)
			if arg_20_0 == 1 then
				arg_18_0:Play322242005(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			local var_21_0 = 0
			local var_21_1 = 0.375

			if var_21_0 < arg_18_1.time_ and arg_18_1.time_ <= var_21_0 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0
				arg_18_1.dialogCg_.alpha = 1

				arg_18_1.dialog_:SetActive(true)
				SetActive(arg_18_1.leftNameGo_, true)

				local var_21_2 = arg_18_1:FormatText(StoryNameCfg[319].name)

				arg_18_1.leftNameTxt_.text = var_21_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_18_1.leftNameTxt_.transform)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1.leftNameTxt_.text)
				SetActive(arg_18_1.iconTrs_.gameObject, false)
				arg_18_1.callingController_:SetSelectedState("normal")

				local var_21_3 = arg_18_1:GetWordFromCfg(322242004)
				local var_21_4 = arg_18_1:FormatText(var_21_3.content)

				arg_18_1.text_.text = var_21_4

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_5 = 15
				local var_21_6 = utf8.len(var_21_4)
				local var_21_7 = var_21_5 <= 0 and var_21_1 or var_21_1 * (var_21_6 / var_21_5)

				if var_21_7 > 0 and var_21_1 < var_21_7 then
					arg_18_1.talkMaxDuration = var_21_7

					if var_21_7 + var_21_0 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_7 + var_21_0
					end
				end

				arg_18_1.text_.text = var_21_4
				arg_18_1.typewritter.percent = 0

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322242", "322242004", "story_v_out_322242.awb") ~= 0 then
					local var_21_8 = manager.audio:GetVoiceLength("story_v_out_322242", "322242004", "story_v_out_322242.awb") / 1000

					if var_21_8 + var_21_0 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_8 + var_21_0
					end

					if var_21_3.prefab_name ~= "" and arg_18_1.actors_[var_21_3.prefab_name] ~= nil then
						local var_21_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_18_1.actors_[var_21_3.prefab_name].transform, "story_v_out_322242", "322242004", "story_v_out_322242.awb")

						arg_18_1:RecordAudio("322242004", var_21_9)
						arg_18_1:RecordAudio("322242004", var_21_9)
					else
						arg_18_1:AudioAction("play", "voice", "story_v_out_322242", "322242004", "story_v_out_322242.awb")
					end

					arg_18_1:RecordHistoryTalkVoice("story_v_out_322242", "322242004", "story_v_out_322242.awb")
				end

				arg_18_1:RecordContent(arg_18_1.text_.text)
			end

			local var_21_10 = math.max(var_21_1, arg_18_1.talkMaxDuration)

			if var_21_0 <= arg_18_1.time_ and arg_18_1.time_ < var_21_0 + var_21_10 then
				arg_18_1.typewritter.percent = (arg_18_1.time_ - var_21_0) / var_21_10

				arg_18_1.typewritter:SetDirty()
			end

			if arg_18_1.time_ >= var_21_0 + var_21_10 and arg_18_1.time_ < var_21_0 + var_21_10 + arg_21_0 then
				arg_18_1.typewritter.percent = 1

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(true)
			end
		end

		arg_18_1.nodeConfigList_ = {}

		arg_18_1:InitPlayNodeList()
	end,
	Play322242005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 322242005
		arg_22_1.duration_ = 5.57

		local var_22_0 = {
			zh = 2.966,
			ja = 5.566
		}
		local var_22_1 = manager.audio:GetLocalizationFlag()

		if var_22_0[var_22_1] ~= nil then
			arg_22_1.duration_ = var_22_0[var_22_1]
		end

		SetActive(arg_22_1.tipsGo_, false)

		function arg_22_1.onSingleLineFinish_()
			arg_22_1.onSingleLineUpdate_ = nil
			arg_22_1.onSingleLineFinish_ = nil
			arg_22_1.state_ = "waiting"
		end

		function arg_22_1.playNext_(arg_24_0)
			if arg_24_0 == 1 then
				arg_22_0:Play322242006(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			local var_25_0 = arg_22_1.actors_["1029ui_story"].transform
			local var_25_1 = 0

			if var_25_1 < arg_22_1.time_ and arg_22_1.time_ <= var_25_1 + arg_25_0 then
				arg_22_1.var_.moveOldPos1029ui_story = var_25_0.localPosition
			end

			local var_25_2 = 0.001

			if var_25_1 <= arg_22_1.time_ and arg_22_1.time_ < var_25_1 + var_25_2 then
				local var_25_3 = (arg_22_1.time_ - var_25_1) / var_25_2
				local var_25_4 = Vector3.New(-0.7, -1.09, -6.2)

				var_25_0.localPosition = Vector3.Lerp(arg_22_1.var_.moveOldPos1029ui_story, var_25_4, var_25_3)

				local var_25_5 = manager.ui.mainCamera.transform.position - var_25_0.position

				var_25_0.forward = Vector3.New(var_25_5.x, var_25_5.y, var_25_5.z)

				local var_25_6 = var_25_0.localEulerAngles

				var_25_6.z = 0
				var_25_6.x = 0
				var_25_0.localEulerAngles = var_25_6
			end

			if arg_22_1.time_ >= var_25_1 + var_25_2 and arg_22_1.time_ < var_25_1 + var_25_2 + arg_25_0 then
				var_25_0.localPosition = Vector3.New(-0.7, -1.09, -6.2)

				local var_25_7 = manager.ui.mainCamera.transform.position - var_25_0.position

				var_25_0.forward = Vector3.New(var_25_7.x, var_25_7.y, var_25_7.z)

				local var_25_8 = var_25_0.localEulerAngles

				var_25_8.z = 0
				var_25_8.x = 0
				var_25_0.localEulerAngles = var_25_8
			end

			local var_25_9 = "1020ui_story"

			if arg_22_1.actors_[var_25_9] == nil then
				local var_25_10 = Asset.Load("Char/" .. "1020ui_story")

				if not isNil(var_25_10) then
					local var_25_11 = Object.Instantiate(Asset.Load("Char/" .. "1020ui_story"), arg_22_1.stage_.transform)

					var_25_11.name = var_25_9
					var_25_11.transform.localPosition = Vector3.New(0, 100, 0)
					arg_22_1.actors_[var_25_9] = var_25_11

					local var_25_12 = var_25_11:GetComponentInChildren(typeof(CharacterEffect))

					var_25_12.enabled = true

					local var_25_13 = GameObjectTools.GetOrAddComponent(var_25_11, typeof(DynamicBoneHelper))

					if var_25_13 then
						var_25_13:EnableDynamicBone(false)
					end

					arg_22_1:ShowWeapon(var_25_12.transform, false)

					arg_22_1.var_[var_25_9 .. "Animator"] = var_25_12.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_22_1.var_[var_25_9 .. "Animator"].applyRootMotion = true
					arg_22_1.var_[var_25_9 .. "LipSync"] = var_25_12.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_25_14 = arg_22_1.actors_["1020ui_story"].transform
			local var_25_15 = 0

			if var_25_15 < arg_22_1.time_ and arg_22_1.time_ <= var_25_15 + arg_25_0 then
				arg_22_1.var_.moveOldPos1020ui_story = var_25_14.localPosition
			end

			local var_25_16 = 0.001

			if var_25_15 <= arg_22_1.time_ and arg_22_1.time_ < var_25_15 + var_25_16 then
				local var_25_17 = (arg_22_1.time_ - var_25_15) / var_25_16
				local var_25_18 = Vector3.New(0.7, -0.85, -6.25)

				var_25_14.localPosition = Vector3.Lerp(arg_22_1.var_.moveOldPos1020ui_story, var_25_18, var_25_17)

				local var_25_19 = manager.ui.mainCamera.transform.position - var_25_14.position

				var_25_14.forward = Vector3.New(var_25_19.x, var_25_19.y, var_25_19.z)

				local var_25_20 = var_25_14.localEulerAngles

				var_25_20.z = 0
				var_25_20.x = 0
				var_25_14.localEulerAngles = var_25_20
			end

			if arg_22_1.time_ >= var_25_15 + var_25_16 and arg_22_1.time_ < var_25_15 + var_25_16 + arg_25_0 then
				var_25_14.localPosition = Vector3.New(0.7, -0.85, -6.25)

				local var_25_21 = manager.ui.mainCamera.transform.position - var_25_14.position

				var_25_14.forward = Vector3.New(var_25_21.x, var_25_21.y, var_25_21.z)

				local var_25_22 = var_25_14.localEulerAngles

				var_25_22.z = 0
				var_25_22.x = 0
				var_25_14.localEulerAngles = var_25_22
			end

			local var_25_23 = arg_22_1.actors_["1020ui_story"]
			local var_25_24 = 0

			if var_25_24 < arg_22_1.time_ and arg_22_1.time_ <= var_25_24 + arg_25_0 and not isNil(var_25_23) and arg_22_1.var_.characterEffect1020ui_story == nil then
				arg_22_1.var_.characterEffect1020ui_story = var_25_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_25_25 = 0.200000002980232

			if var_25_24 <= arg_22_1.time_ and arg_22_1.time_ < var_25_24 + var_25_25 and not isNil(var_25_23) then
				local var_25_26 = (arg_22_1.time_ - var_25_24) / var_25_25

				if arg_22_1.var_.characterEffect1020ui_story and not isNil(var_25_23) then
					arg_22_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_22_1.time_ >= var_25_24 + var_25_25 and arg_22_1.time_ < var_25_24 + var_25_25 + arg_25_0 and not isNil(var_25_23) and arg_22_1.var_.characterEffect1020ui_story then
				arg_22_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_25_27 = arg_22_1.actors_["1029ui_story"]
			local var_25_28 = 0

			if var_25_28 < arg_22_1.time_ and arg_22_1.time_ <= var_25_28 + arg_25_0 and not isNil(var_25_27) and arg_22_1.var_.characterEffect1029ui_story == nil then
				arg_22_1.var_.characterEffect1029ui_story = var_25_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_25_29 = 0.200000002980232

			if var_25_28 <= arg_22_1.time_ and arg_22_1.time_ < var_25_28 + var_25_29 and not isNil(var_25_27) then
				local var_25_30 = (arg_22_1.time_ - var_25_28) / var_25_29

				if arg_22_1.var_.characterEffect1029ui_story and not isNil(var_25_27) then
					local var_25_31 = Mathf.Lerp(0, 0.5, var_25_30)

					arg_22_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_22_1.var_.characterEffect1029ui_story.fillRatio = var_25_31
				end
			end

			if arg_22_1.time_ >= var_25_28 + var_25_29 and arg_22_1.time_ < var_25_28 + var_25_29 + arg_25_0 and not isNil(var_25_27) and arg_22_1.var_.characterEffect1029ui_story then
				local var_25_32 = 0.5

				arg_22_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_22_1.var_.characterEffect1029ui_story.fillRatio = var_25_32
			end

			local var_25_33 = 0

			if var_25_33 < arg_22_1.time_ and arg_22_1.time_ <= var_25_33 + arg_25_0 then
				arg_22_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action1_1")
			end

			local var_25_34 = 0

			if var_25_34 < arg_22_1.time_ and arg_22_1.time_ <= var_25_34 + arg_25_0 then
				arg_22_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_25_35 = 0
			local var_25_36 = 0.4

			if var_25_35 < arg_22_1.time_ and arg_22_1.time_ <= var_25_35 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0
				arg_22_1.dialogCg_.alpha = 1

				arg_22_1.dialog_:SetActive(true)
				SetActive(arg_22_1.leftNameGo_, true)

				local var_25_37 = arg_22_1:FormatText(StoryNameCfg[613].name)

				arg_22_1.leftNameTxt_.text = var_25_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_22_1.leftNameTxt_.transform)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1.leftNameTxt_.text)
				SetActive(arg_22_1.iconTrs_.gameObject, false)
				arg_22_1.callingController_:SetSelectedState("normal")

				local var_25_38 = arg_22_1:GetWordFromCfg(322242005)
				local var_25_39 = arg_22_1:FormatText(var_25_38.content)

				arg_22_1.text_.text = var_25_39

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_40 = 16
				local var_25_41 = utf8.len(var_25_39)
				local var_25_42 = var_25_40 <= 0 and var_25_36 or var_25_36 * (var_25_41 / var_25_40)

				if var_25_42 > 0 and var_25_36 < var_25_42 then
					arg_22_1.talkMaxDuration = var_25_42

					if var_25_42 + var_25_35 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_42 + var_25_35
					end
				end

				arg_22_1.text_.text = var_25_39
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322242", "322242005", "story_v_out_322242.awb") ~= 0 then
					local var_25_43 = manager.audio:GetVoiceLength("story_v_out_322242", "322242005", "story_v_out_322242.awb") / 1000

					if var_25_43 + var_25_35 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_43 + var_25_35
					end

					if var_25_38.prefab_name ~= "" and arg_22_1.actors_[var_25_38.prefab_name] ~= nil then
						local var_25_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_22_1.actors_[var_25_38.prefab_name].transform, "story_v_out_322242", "322242005", "story_v_out_322242.awb")

						arg_22_1:RecordAudio("322242005", var_25_44)
						arg_22_1:RecordAudio("322242005", var_25_44)
					else
						arg_22_1:AudioAction("play", "voice", "story_v_out_322242", "322242005", "story_v_out_322242.awb")
					end

					arg_22_1:RecordHistoryTalkVoice("story_v_out_322242", "322242005", "story_v_out_322242.awb")
				end

				arg_22_1:RecordContent(arg_22_1.text_.text)
			end

			local var_25_45 = math.max(var_25_36, arg_22_1.talkMaxDuration)

			if var_25_35 <= arg_22_1.time_ and arg_22_1.time_ < var_25_35 + var_25_45 then
				arg_22_1.typewritter.percent = (arg_22_1.time_ - var_25_35) / var_25_45

				arg_22_1.typewritter:SetDirty()
			end

			if arg_22_1.time_ >= var_25_35 + var_25_45 and arg_22_1.time_ < var_25_35 + var_25_45 + arg_25_0 then
				arg_22_1.typewritter.percent = 1

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(true)
			end
		end

		arg_22_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
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

		arg_22_1:InitPlayNodeList()
	end,
	Play322242006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 322242006
		arg_26_1.duration_ = 4.8

		local var_26_0 = {
			zh = 2.9,
			ja = 4.8
		}
		local var_26_1 = manager.audio:GetLocalizationFlag()

		if var_26_0[var_26_1] ~= nil then
			arg_26_1.duration_ = var_26_0[var_26_1]
		end

		SetActive(arg_26_1.tipsGo_, false)

		function arg_26_1.onSingleLineFinish_()
			arg_26_1.onSingleLineUpdate_ = nil
			arg_26_1.onSingleLineFinish_ = nil
			arg_26_1.state_ = "waiting"
		end

		function arg_26_1.playNext_(arg_28_0)
			if arg_28_0 == 1 then
				arg_26_0:Play322242007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			local var_29_0 = arg_26_1.actors_["1029ui_story"]
			local var_29_1 = 0

			if var_29_1 < arg_26_1.time_ and arg_26_1.time_ <= var_29_1 + arg_29_0 and not isNil(var_29_0) and arg_26_1.var_.characterEffect1029ui_story == nil then
				arg_26_1.var_.characterEffect1029ui_story = var_29_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_29_2 = 0.200000002980232

			if var_29_1 <= arg_26_1.time_ and arg_26_1.time_ < var_29_1 + var_29_2 and not isNil(var_29_0) then
				local var_29_3 = (arg_26_1.time_ - var_29_1) / var_29_2

				if arg_26_1.var_.characterEffect1029ui_story and not isNil(var_29_0) then
					arg_26_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_26_1.time_ >= var_29_1 + var_29_2 and arg_26_1.time_ < var_29_1 + var_29_2 + arg_29_0 and not isNil(var_29_0) and arg_26_1.var_.characterEffect1029ui_story then
				arg_26_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_29_4 = arg_26_1.actors_["1020ui_story"]
			local var_29_5 = 0

			if var_29_5 < arg_26_1.time_ and arg_26_1.time_ <= var_29_5 + arg_29_0 and not isNil(var_29_4) and arg_26_1.var_.characterEffect1020ui_story == nil then
				arg_26_1.var_.characterEffect1020ui_story = var_29_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_29_6 = 0.200000002980232

			if var_29_5 <= arg_26_1.time_ and arg_26_1.time_ < var_29_5 + var_29_6 and not isNil(var_29_4) then
				local var_29_7 = (arg_26_1.time_ - var_29_5) / var_29_6

				if arg_26_1.var_.characterEffect1020ui_story and not isNil(var_29_4) then
					local var_29_8 = Mathf.Lerp(0, 0.5, var_29_7)

					arg_26_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_26_1.var_.characterEffect1020ui_story.fillRatio = var_29_8
				end
			end

			if arg_26_1.time_ >= var_29_5 + var_29_6 and arg_26_1.time_ < var_29_5 + var_29_6 + arg_29_0 and not isNil(var_29_4) and arg_26_1.var_.characterEffect1020ui_story then
				local var_29_9 = 0.5

				arg_26_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_26_1.var_.characterEffect1020ui_story.fillRatio = var_29_9
			end

			local var_29_10 = 0

			if var_29_10 < arg_26_1.time_ and arg_26_1.time_ <= var_29_10 + arg_29_0 then
				arg_26_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action2_2")
			end

			local var_29_11 = 0
			local var_29_12 = 0.4

			if var_29_11 < arg_26_1.time_ and arg_26_1.time_ <= var_29_11 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, true)

				local var_29_13 = arg_26_1:FormatText(StoryNameCfg[319].name)

				arg_26_1.leftNameTxt_.text = var_29_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_26_1.leftNameTxt_.transform)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1.leftNameTxt_.text)
				SetActive(arg_26_1.iconTrs_.gameObject, false)
				arg_26_1.callingController_:SetSelectedState("normal")

				local var_29_14 = arg_26_1:GetWordFromCfg(322242006)
				local var_29_15 = arg_26_1:FormatText(var_29_14.content)

				arg_26_1.text_.text = var_29_15

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_16 = 16
				local var_29_17 = utf8.len(var_29_15)
				local var_29_18 = var_29_16 <= 0 and var_29_12 or var_29_12 * (var_29_17 / var_29_16)

				if var_29_18 > 0 and var_29_12 < var_29_18 then
					arg_26_1.talkMaxDuration = var_29_18

					if var_29_18 + var_29_11 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_18 + var_29_11
					end
				end

				arg_26_1.text_.text = var_29_15
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322242", "322242006", "story_v_out_322242.awb") ~= 0 then
					local var_29_19 = manager.audio:GetVoiceLength("story_v_out_322242", "322242006", "story_v_out_322242.awb") / 1000

					if var_29_19 + var_29_11 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_19 + var_29_11
					end

					if var_29_14.prefab_name ~= "" and arg_26_1.actors_[var_29_14.prefab_name] ~= nil then
						local var_29_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_26_1.actors_[var_29_14.prefab_name].transform, "story_v_out_322242", "322242006", "story_v_out_322242.awb")

						arg_26_1:RecordAudio("322242006", var_29_20)
						arg_26_1:RecordAudio("322242006", var_29_20)
					else
						arg_26_1:AudioAction("play", "voice", "story_v_out_322242", "322242006", "story_v_out_322242.awb")
					end

					arg_26_1:RecordHistoryTalkVoice("story_v_out_322242", "322242006", "story_v_out_322242.awb")
				end

				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_21 = math.max(var_29_12, arg_26_1.talkMaxDuration)

			if var_29_11 <= arg_26_1.time_ and arg_26_1.time_ < var_29_11 + var_29_21 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - var_29_11) / var_29_21

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= var_29_11 + var_29_21 and arg_26_1.time_ < var_29_11 + var_29_21 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {}

		arg_26_1:InitPlayNodeList()
	end,
	Play322242007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 322242007
		arg_30_1.duration_ = 12.4

		local var_30_0 = {
			zh = 8.6,
			ja = 12.4
		}
		local var_30_1 = manager.audio:GetLocalizationFlag()

		if var_30_0[var_30_1] ~= nil then
			arg_30_1.duration_ = var_30_0[var_30_1]
		end

		SetActive(arg_30_1.tipsGo_, false)

		function arg_30_1.onSingleLineFinish_()
			arg_30_1.onSingleLineUpdate_ = nil
			arg_30_1.onSingleLineFinish_ = nil
			arg_30_1.state_ = "waiting"
		end

		function arg_30_1.playNext_(arg_32_0)
			if arg_32_0 == 1 then
				arg_30_0:Play322242008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			local var_33_0 = 0
			local var_33_1 = 0.9

			if var_33_0 < arg_30_1.time_ and arg_30_1.time_ <= var_33_0 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, true)

				local var_33_2 = arg_30_1:FormatText(StoryNameCfg[319].name)

				arg_30_1.leftNameTxt_.text = var_33_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_30_1.leftNameTxt_.transform)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1.leftNameTxt_.text)
				SetActive(arg_30_1.iconTrs_.gameObject, false)
				arg_30_1.callingController_:SetSelectedState("normal")

				local var_33_3 = arg_30_1:GetWordFromCfg(322242007)
				local var_33_4 = arg_30_1:FormatText(var_33_3.content)

				arg_30_1.text_.text = var_33_4

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_5 = 36
				local var_33_6 = utf8.len(var_33_4)
				local var_33_7 = var_33_5 <= 0 and var_33_1 or var_33_1 * (var_33_6 / var_33_5)

				if var_33_7 > 0 and var_33_1 < var_33_7 then
					arg_30_1.talkMaxDuration = var_33_7

					if var_33_7 + var_33_0 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_7 + var_33_0
					end
				end

				arg_30_1.text_.text = var_33_4
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322242", "322242007", "story_v_out_322242.awb") ~= 0 then
					local var_33_8 = manager.audio:GetVoiceLength("story_v_out_322242", "322242007", "story_v_out_322242.awb") / 1000

					if var_33_8 + var_33_0 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_8 + var_33_0
					end

					if var_33_3.prefab_name ~= "" and arg_30_1.actors_[var_33_3.prefab_name] ~= nil then
						local var_33_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_30_1.actors_[var_33_3.prefab_name].transform, "story_v_out_322242", "322242007", "story_v_out_322242.awb")

						arg_30_1:RecordAudio("322242007", var_33_9)
						arg_30_1:RecordAudio("322242007", var_33_9)
					else
						arg_30_1:AudioAction("play", "voice", "story_v_out_322242", "322242007", "story_v_out_322242.awb")
					end

					arg_30_1:RecordHistoryTalkVoice("story_v_out_322242", "322242007", "story_v_out_322242.awb")
				end

				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_10 = math.max(var_33_1, arg_30_1.talkMaxDuration)

			if var_33_0 <= arg_30_1.time_ and arg_30_1.time_ < var_33_0 + var_33_10 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_0) / var_33_10

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_0 + var_33_10 and arg_30_1.time_ < var_33_0 + var_33_10 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {}

		arg_30_1:InitPlayNodeList()
	end,
	Play322242008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 322242008
		arg_34_1.duration_ = 6.4

		local var_34_0 = {
			zh = 4.466,
			ja = 6.4
		}
		local var_34_1 = manager.audio:GetLocalizationFlag()

		if var_34_0[var_34_1] ~= nil then
			arg_34_1.duration_ = var_34_0[var_34_1]
		end

		SetActive(arg_34_1.tipsGo_, false)

		function arg_34_1.onSingleLineFinish_()
			arg_34_1.onSingleLineUpdate_ = nil
			arg_34_1.onSingleLineFinish_ = nil
			arg_34_1.state_ = "waiting"
		end

		function arg_34_1.playNext_(arg_36_0)
			if arg_36_0 == 1 then
				arg_34_0:Play322242009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			local var_37_0 = arg_34_1.actors_["1020ui_story"]
			local var_37_1 = 0

			if var_37_1 < arg_34_1.time_ and arg_34_1.time_ <= var_37_1 + arg_37_0 and not isNil(var_37_0) and arg_34_1.var_.characterEffect1020ui_story == nil then
				arg_34_1.var_.characterEffect1020ui_story = var_37_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_37_2 = 0.200000002980232

			if var_37_1 <= arg_34_1.time_ and arg_34_1.time_ < var_37_1 + var_37_2 and not isNil(var_37_0) then
				local var_37_3 = (arg_34_1.time_ - var_37_1) / var_37_2

				if arg_34_1.var_.characterEffect1020ui_story and not isNil(var_37_0) then
					arg_34_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_34_1.time_ >= var_37_1 + var_37_2 and arg_34_1.time_ < var_37_1 + var_37_2 + arg_37_0 and not isNil(var_37_0) and arg_34_1.var_.characterEffect1020ui_story then
				arg_34_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_37_4 = arg_34_1.actors_["1029ui_story"]
			local var_37_5 = 0

			if var_37_5 < arg_34_1.time_ and arg_34_1.time_ <= var_37_5 + arg_37_0 and not isNil(var_37_4) and arg_34_1.var_.characterEffect1029ui_story == nil then
				arg_34_1.var_.characterEffect1029ui_story = var_37_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_37_6 = 0.200000002980232

			if var_37_5 <= arg_34_1.time_ and arg_34_1.time_ < var_37_5 + var_37_6 and not isNil(var_37_4) then
				local var_37_7 = (arg_34_1.time_ - var_37_5) / var_37_6

				if arg_34_1.var_.characterEffect1029ui_story and not isNil(var_37_4) then
					local var_37_8 = Mathf.Lerp(0, 0.5, var_37_7)

					arg_34_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_34_1.var_.characterEffect1029ui_story.fillRatio = var_37_8
				end
			end

			if arg_34_1.time_ >= var_37_5 + var_37_6 and arg_34_1.time_ < var_37_5 + var_37_6 + arg_37_0 and not isNil(var_37_4) and arg_34_1.var_.characterEffect1029ui_story then
				local var_37_9 = 0.5

				arg_34_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_34_1.var_.characterEffect1029ui_story.fillRatio = var_37_9
			end

			local var_37_10 = 0

			if var_37_10 < arg_34_1.time_ and arg_34_1.time_ <= var_37_10 + arg_37_0 then
				arg_34_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_37_11 = 0
			local var_37_12 = 0.5

			if var_37_11 < arg_34_1.time_ and arg_34_1.time_ <= var_37_11 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, true)

				local var_37_13 = arg_34_1:FormatText(StoryNameCfg[613].name)

				arg_34_1.leftNameTxt_.text = var_37_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_34_1.leftNameTxt_.transform)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1.leftNameTxt_.text)
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_14 = arg_34_1:GetWordFromCfg(322242008)
				local var_37_15 = arg_34_1:FormatText(var_37_14.content)

				arg_34_1.text_.text = var_37_15

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_16 = 20
				local var_37_17 = utf8.len(var_37_15)
				local var_37_18 = var_37_16 <= 0 and var_37_12 or var_37_12 * (var_37_17 / var_37_16)

				if var_37_18 > 0 and var_37_12 < var_37_18 then
					arg_34_1.talkMaxDuration = var_37_18

					if var_37_18 + var_37_11 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_18 + var_37_11
					end
				end

				arg_34_1.text_.text = var_37_15
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322242", "322242008", "story_v_out_322242.awb") ~= 0 then
					local var_37_19 = manager.audio:GetVoiceLength("story_v_out_322242", "322242008", "story_v_out_322242.awb") / 1000

					if var_37_19 + var_37_11 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_19 + var_37_11
					end

					if var_37_14.prefab_name ~= "" and arg_34_1.actors_[var_37_14.prefab_name] ~= nil then
						local var_37_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_34_1.actors_[var_37_14.prefab_name].transform, "story_v_out_322242", "322242008", "story_v_out_322242.awb")

						arg_34_1:RecordAudio("322242008", var_37_20)
						arg_34_1:RecordAudio("322242008", var_37_20)
					else
						arg_34_1:AudioAction("play", "voice", "story_v_out_322242", "322242008", "story_v_out_322242.awb")
					end

					arg_34_1:RecordHistoryTalkVoice("story_v_out_322242", "322242008", "story_v_out_322242.awb")
				end

				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_21 = math.max(var_37_12, arg_34_1.talkMaxDuration)

			if var_37_11 <= arg_34_1.time_ and arg_34_1.time_ < var_37_11 + var_37_21 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_11) / var_37_21

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_11 + var_37_21 and arg_34_1.time_ < var_37_11 + var_37_21 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {}

		arg_34_1:InitPlayNodeList()
	end,
	Play322242009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 322242009
		arg_38_1.duration_ = 1.63

		local var_38_0 = {
			zh = 1.333,
			ja = 1.633
		}
		local var_38_1 = manager.audio:GetLocalizationFlag()

		if var_38_0[var_38_1] ~= nil then
			arg_38_1.duration_ = var_38_0[var_38_1]
		end

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play322242010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			local var_41_0 = arg_38_1.actors_["1029ui_story"]
			local var_41_1 = 0

			if var_41_1 < arg_38_1.time_ and arg_38_1.time_ <= var_41_1 + arg_41_0 and not isNil(var_41_0) and arg_38_1.var_.characterEffect1029ui_story == nil then
				arg_38_1.var_.characterEffect1029ui_story = var_41_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_41_2 = 0.200000002980232

			if var_41_1 <= arg_38_1.time_ and arg_38_1.time_ < var_41_1 + var_41_2 and not isNil(var_41_0) then
				local var_41_3 = (arg_38_1.time_ - var_41_1) / var_41_2

				if arg_38_1.var_.characterEffect1029ui_story and not isNil(var_41_0) then
					arg_38_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_38_1.time_ >= var_41_1 + var_41_2 and arg_38_1.time_ < var_41_1 + var_41_2 + arg_41_0 and not isNil(var_41_0) and arg_38_1.var_.characterEffect1029ui_story then
				arg_38_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_41_4 = arg_38_1.actors_["1020ui_story"]
			local var_41_5 = 0

			if var_41_5 < arg_38_1.time_ and arg_38_1.time_ <= var_41_5 + arg_41_0 and not isNil(var_41_4) and arg_38_1.var_.characterEffect1020ui_story == nil then
				arg_38_1.var_.characterEffect1020ui_story = var_41_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_41_6 = 0.200000002980232

			if var_41_5 <= arg_38_1.time_ and arg_38_1.time_ < var_41_5 + var_41_6 and not isNil(var_41_4) then
				local var_41_7 = (arg_38_1.time_ - var_41_5) / var_41_6

				if arg_38_1.var_.characterEffect1020ui_story and not isNil(var_41_4) then
					local var_41_8 = Mathf.Lerp(0, 0.5, var_41_7)

					arg_38_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_38_1.var_.characterEffect1020ui_story.fillRatio = var_41_8
				end
			end

			if arg_38_1.time_ >= var_41_5 + var_41_6 and arg_38_1.time_ < var_41_5 + var_41_6 + arg_41_0 and not isNil(var_41_4) and arg_38_1.var_.characterEffect1020ui_story then
				local var_41_9 = 0.5

				arg_38_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_38_1.var_.characterEffect1020ui_story.fillRatio = var_41_9
			end

			local var_41_10 = 0
			local var_41_11 = 0.075

			if var_41_10 < arg_38_1.time_ and arg_38_1.time_ <= var_41_10 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				local var_41_12 = arg_38_1:FormatText(StoryNameCfg[319].name)

				arg_38_1.leftNameTxt_.text = var_41_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_13 = arg_38_1:GetWordFromCfg(322242009)
				local var_41_14 = arg_38_1:FormatText(var_41_13.content)

				arg_38_1.text_.text = var_41_14

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_15 = 3
				local var_41_16 = utf8.len(var_41_14)
				local var_41_17 = var_41_15 <= 0 and var_41_11 or var_41_11 * (var_41_16 / var_41_15)

				if var_41_17 > 0 and var_41_11 < var_41_17 then
					arg_38_1.talkMaxDuration = var_41_17

					if var_41_17 + var_41_10 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_17 + var_41_10
					end
				end

				arg_38_1.text_.text = var_41_14
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322242", "322242009", "story_v_out_322242.awb") ~= 0 then
					local var_41_18 = manager.audio:GetVoiceLength("story_v_out_322242", "322242009", "story_v_out_322242.awb") / 1000

					if var_41_18 + var_41_10 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_18 + var_41_10
					end

					if var_41_13.prefab_name ~= "" and arg_38_1.actors_[var_41_13.prefab_name] ~= nil then
						local var_41_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_38_1.actors_[var_41_13.prefab_name].transform, "story_v_out_322242", "322242009", "story_v_out_322242.awb")

						arg_38_1:RecordAudio("322242009", var_41_19)
						arg_38_1:RecordAudio("322242009", var_41_19)
					else
						arg_38_1:AudioAction("play", "voice", "story_v_out_322242", "322242009", "story_v_out_322242.awb")
					end

					arg_38_1:RecordHistoryTalkVoice("story_v_out_322242", "322242009", "story_v_out_322242.awb")
				end

				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_20 = math.max(var_41_11, arg_38_1.talkMaxDuration)

			if var_41_10 <= arg_38_1.time_ and arg_38_1.time_ < var_41_10 + var_41_20 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_10) / var_41_20

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_10 + var_41_20 and arg_38_1.time_ < var_41_10 + var_41_20 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play322242010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 322242010
		arg_42_1.duration_ = 10.4

		local var_42_0 = {
			zh = 8.933,
			ja = 10.4
		}
		local var_42_1 = manager.audio:GetLocalizationFlag()

		if var_42_0[var_42_1] ~= nil then
			arg_42_1.duration_ = var_42_0[var_42_1]
		end

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play322242011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			local var_45_0 = arg_42_1.actors_["1020ui_story"]
			local var_45_1 = 0

			if var_45_1 < arg_42_1.time_ and arg_42_1.time_ <= var_45_1 + arg_45_0 and not isNil(var_45_0) and arg_42_1.var_.characterEffect1020ui_story == nil then
				arg_42_1.var_.characterEffect1020ui_story = var_45_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_45_2 = 0.200000002980232

			if var_45_1 <= arg_42_1.time_ and arg_42_1.time_ < var_45_1 + var_45_2 and not isNil(var_45_0) then
				local var_45_3 = (arg_42_1.time_ - var_45_1) / var_45_2

				if arg_42_1.var_.characterEffect1020ui_story and not isNil(var_45_0) then
					arg_42_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_42_1.time_ >= var_45_1 + var_45_2 and arg_42_1.time_ < var_45_1 + var_45_2 + arg_45_0 and not isNil(var_45_0) and arg_42_1.var_.characterEffect1020ui_story then
				arg_42_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_45_4 = arg_42_1.actors_["1029ui_story"]
			local var_45_5 = 0

			if var_45_5 < arg_42_1.time_ and arg_42_1.time_ <= var_45_5 + arg_45_0 and not isNil(var_45_4) and arg_42_1.var_.characterEffect1029ui_story == nil then
				arg_42_1.var_.characterEffect1029ui_story = var_45_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_45_6 = 0.200000002980232

			if var_45_5 <= arg_42_1.time_ and arg_42_1.time_ < var_45_5 + var_45_6 and not isNil(var_45_4) then
				local var_45_7 = (arg_42_1.time_ - var_45_5) / var_45_6

				if arg_42_1.var_.characterEffect1029ui_story and not isNil(var_45_4) then
					local var_45_8 = Mathf.Lerp(0, 0.5, var_45_7)

					arg_42_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_42_1.var_.characterEffect1029ui_story.fillRatio = var_45_8
				end
			end

			if arg_42_1.time_ >= var_45_5 + var_45_6 and arg_42_1.time_ < var_45_5 + var_45_6 + arg_45_0 and not isNil(var_45_4) and arg_42_1.var_.characterEffect1029ui_story then
				local var_45_9 = 0.5

				arg_42_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_42_1.var_.characterEffect1029ui_story.fillRatio = var_45_9
			end

			local var_45_10 = 0

			if var_45_10 < arg_42_1.time_ and arg_42_1.time_ <= var_45_10 + arg_45_0 then
				arg_42_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action4_1")
			end

			local var_45_11 = 0
			local var_45_12 = 1.1

			if var_45_11 < arg_42_1.time_ and arg_42_1.time_ <= var_45_11 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				local var_45_13 = arg_42_1:FormatText(StoryNameCfg[613].name)

				arg_42_1.leftNameTxt_.text = var_45_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_14 = arg_42_1:GetWordFromCfg(322242010)
				local var_45_15 = arg_42_1:FormatText(var_45_14.content)

				arg_42_1.text_.text = var_45_15

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_16 = 44
				local var_45_17 = utf8.len(var_45_15)
				local var_45_18 = var_45_16 <= 0 and var_45_12 or var_45_12 * (var_45_17 / var_45_16)

				if var_45_18 > 0 and var_45_12 < var_45_18 then
					arg_42_1.talkMaxDuration = var_45_18

					if var_45_18 + var_45_11 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_18 + var_45_11
					end
				end

				arg_42_1.text_.text = var_45_15
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322242", "322242010", "story_v_out_322242.awb") ~= 0 then
					local var_45_19 = manager.audio:GetVoiceLength("story_v_out_322242", "322242010", "story_v_out_322242.awb") / 1000

					if var_45_19 + var_45_11 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_19 + var_45_11
					end

					if var_45_14.prefab_name ~= "" and arg_42_1.actors_[var_45_14.prefab_name] ~= nil then
						local var_45_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_14.prefab_name].transform, "story_v_out_322242", "322242010", "story_v_out_322242.awb")

						arg_42_1:RecordAudio("322242010", var_45_20)
						arg_42_1:RecordAudio("322242010", var_45_20)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_out_322242", "322242010", "story_v_out_322242.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_out_322242", "322242010", "story_v_out_322242.awb")
				end

				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_21 = math.max(var_45_12, arg_42_1.talkMaxDuration)

			if var_45_11 <= arg_42_1.time_ and arg_42_1.time_ < var_45_11 + var_45_21 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_11) / var_45_21

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_11 + var_45_21 and arg_42_1.time_ < var_45_11 + var_45_21 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {}

		arg_42_1:InitPlayNodeList()
	end,
	Play322242011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 322242011
		arg_46_1.duration_ = 10.43

		local var_46_0 = {
			zh = 6.7,
			ja = 10.433
		}
		local var_46_1 = manager.audio:GetLocalizationFlag()

		if var_46_0[var_46_1] ~= nil then
			arg_46_1.duration_ = var_46_0[var_46_1]
		end

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play322242012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			local var_49_0 = 0
			local var_49_1 = 0.65

			if var_49_0 < arg_46_1.time_ and arg_46_1.time_ <= var_49_0 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, true)

				local var_49_2 = arg_46_1:FormatText(StoryNameCfg[613].name)

				arg_46_1.leftNameTxt_.text = var_49_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_46_1.leftNameTxt_.transform)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1.leftNameTxt_.text)
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_3 = arg_46_1:GetWordFromCfg(322242011)
				local var_49_4 = arg_46_1:FormatText(var_49_3.content)

				arg_46_1.text_.text = var_49_4

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_5 = 26
				local var_49_6 = utf8.len(var_49_4)
				local var_49_7 = var_49_5 <= 0 and var_49_1 or var_49_1 * (var_49_6 / var_49_5)

				if var_49_7 > 0 and var_49_1 < var_49_7 then
					arg_46_1.talkMaxDuration = var_49_7

					if var_49_7 + var_49_0 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_7 + var_49_0
					end
				end

				arg_46_1.text_.text = var_49_4
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322242", "322242011", "story_v_out_322242.awb") ~= 0 then
					local var_49_8 = manager.audio:GetVoiceLength("story_v_out_322242", "322242011", "story_v_out_322242.awb") / 1000

					if var_49_8 + var_49_0 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_8 + var_49_0
					end

					if var_49_3.prefab_name ~= "" and arg_46_1.actors_[var_49_3.prefab_name] ~= nil then
						local var_49_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_46_1.actors_[var_49_3.prefab_name].transform, "story_v_out_322242", "322242011", "story_v_out_322242.awb")

						arg_46_1:RecordAudio("322242011", var_49_9)
						arg_46_1:RecordAudio("322242011", var_49_9)
					else
						arg_46_1:AudioAction("play", "voice", "story_v_out_322242", "322242011", "story_v_out_322242.awb")
					end

					arg_46_1:RecordHistoryTalkVoice("story_v_out_322242", "322242011", "story_v_out_322242.awb")
				end

				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_10 = math.max(var_49_1, arg_46_1.talkMaxDuration)

			if var_49_0 <= arg_46_1.time_ and arg_46_1.time_ < var_49_0 + var_49_10 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_0) / var_49_10

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_0 + var_49_10 and arg_46_1.time_ < var_49_0 + var_49_10 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {}

		arg_46_1:InitPlayNodeList()
	end,
	Play322242012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 322242012
		arg_50_1.duration_ = 6.57

		local var_50_0 = {
			zh = 5.333,
			ja = 6.566
		}
		local var_50_1 = manager.audio:GetLocalizationFlag()

		if var_50_0[var_50_1] ~= nil then
			arg_50_1.duration_ = var_50_0[var_50_1]
		end

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play322242013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_0 = 0

			if var_53_0 < arg_50_1.time_ and arg_50_1.time_ <= var_53_0 + arg_53_0 then
				arg_50_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action4_2")
			end

			local var_53_1 = 0

			if var_53_1 < arg_50_1.time_ and arg_50_1.time_ <= var_53_1 + arg_53_0 then
				arg_50_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_53_2 = 0
			local var_53_3 = 0.625

			if var_53_2 < arg_50_1.time_ and arg_50_1.time_ <= var_53_2 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				local var_53_4 = arg_50_1:FormatText(StoryNameCfg[613].name)

				arg_50_1.leftNameTxt_.text = var_53_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_5 = arg_50_1:GetWordFromCfg(322242012)
				local var_53_6 = arg_50_1:FormatText(var_53_5.content)

				arg_50_1.text_.text = var_53_6

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_7 = 25
				local var_53_8 = utf8.len(var_53_6)
				local var_53_9 = var_53_7 <= 0 and var_53_3 or var_53_3 * (var_53_8 / var_53_7)

				if var_53_9 > 0 and var_53_3 < var_53_9 then
					arg_50_1.talkMaxDuration = var_53_9

					if var_53_9 + var_53_2 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_9 + var_53_2
					end
				end

				arg_50_1.text_.text = var_53_6
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322242", "322242012", "story_v_out_322242.awb") ~= 0 then
					local var_53_10 = manager.audio:GetVoiceLength("story_v_out_322242", "322242012", "story_v_out_322242.awb") / 1000

					if var_53_10 + var_53_2 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_10 + var_53_2
					end

					if var_53_5.prefab_name ~= "" and arg_50_1.actors_[var_53_5.prefab_name] ~= nil then
						local var_53_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_50_1.actors_[var_53_5.prefab_name].transform, "story_v_out_322242", "322242012", "story_v_out_322242.awb")

						arg_50_1:RecordAudio("322242012", var_53_11)
						arg_50_1:RecordAudio("322242012", var_53_11)
					else
						arg_50_1:AudioAction("play", "voice", "story_v_out_322242", "322242012", "story_v_out_322242.awb")
					end

					arg_50_1:RecordHistoryTalkVoice("story_v_out_322242", "322242012", "story_v_out_322242.awb")
				end

				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_12 = math.max(var_53_3, arg_50_1.talkMaxDuration)

			if var_53_2 <= arg_50_1.time_ and arg_50_1.time_ < var_53_2 + var_53_12 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_2) / var_53_12

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_2 + var_53_12 and arg_50_1.time_ < var_53_2 + var_53_12 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {}

		arg_50_1:InitPlayNodeList()
	end,
	Play322242013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 322242013
		arg_54_1.duration_ = 6.03

		local var_54_0 = {
			zh = 3.5,
			ja = 6.033
		}
		local var_54_1 = manager.audio:GetLocalizationFlag()

		if var_54_0[var_54_1] ~= nil then
			arg_54_1.duration_ = var_54_0[var_54_1]
		end

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play322242014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = arg_54_1.actors_["1029ui_story"]
			local var_57_1 = 0

			if var_57_1 < arg_54_1.time_ and arg_54_1.time_ <= var_57_1 + arg_57_0 and not isNil(var_57_0) and arg_54_1.var_.characterEffect1029ui_story == nil then
				arg_54_1.var_.characterEffect1029ui_story = var_57_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_57_2 = 0.200000002980232

			if var_57_1 <= arg_54_1.time_ and arg_54_1.time_ < var_57_1 + var_57_2 and not isNil(var_57_0) then
				local var_57_3 = (arg_54_1.time_ - var_57_1) / var_57_2

				if arg_54_1.var_.characterEffect1029ui_story and not isNil(var_57_0) then
					arg_54_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_54_1.time_ >= var_57_1 + var_57_2 and arg_54_1.time_ < var_57_1 + var_57_2 + arg_57_0 and not isNil(var_57_0) and arg_54_1.var_.characterEffect1029ui_story then
				arg_54_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_57_4 = arg_54_1.actors_["1020ui_story"]
			local var_57_5 = 0

			if var_57_5 < arg_54_1.time_ and arg_54_1.time_ <= var_57_5 + arg_57_0 and not isNil(var_57_4) and arg_54_1.var_.characterEffect1020ui_story == nil then
				arg_54_1.var_.characterEffect1020ui_story = var_57_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_57_6 = 0.200000002980232

			if var_57_5 <= arg_54_1.time_ and arg_54_1.time_ < var_57_5 + var_57_6 and not isNil(var_57_4) then
				local var_57_7 = (arg_54_1.time_ - var_57_5) / var_57_6

				if arg_54_1.var_.characterEffect1020ui_story and not isNil(var_57_4) then
					local var_57_8 = Mathf.Lerp(0, 0.5, var_57_7)

					arg_54_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_54_1.var_.characterEffect1020ui_story.fillRatio = var_57_8
				end
			end

			if arg_54_1.time_ >= var_57_5 + var_57_6 and arg_54_1.time_ < var_57_5 + var_57_6 + arg_57_0 and not isNil(var_57_4) and arg_54_1.var_.characterEffect1020ui_story then
				local var_57_9 = 0.5

				arg_54_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_54_1.var_.characterEffect1020ui_story.fillRatio = var_57_9
			end

			local var_57_10 = 0

			if var_57_10 < arg_54_1.time_ and arg_54_1.time_ <= var_57_10 + arg_57_0 then
				arg_54_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action4_1")
			end

			local var_57_11 = 0
			local var_57_12 = 0.575

			if var_57_11 < arg_54_1.time_ and arg_54_1.time_ <= var_57_11 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				local var_57_13 = arg_54_1:FormatText(StoryNameCfg[319].name)

				arg_54_1.leftNameTxt_.text = var_57_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_14 = arg_54_1:GetWordFromCfg(322242013)
				local var_57_15 = arg_54_1:FormatText(var_57_14.content)

				arg_54_1.text_.text = var_57_15

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_16 = 23
				local var_57_17 = utf8.len(var_57_15)
				local var_57_18 = var_57_16 <= 0 and var_57_12 or var_57_12 * (var_57_17 / var_57_16)

				if var_57_18 > 0 and var_57_12 < var_57_18 then
					arg_54_1.talkMaxDuration = var_57_18

					if var_57_18 + var_57_11 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_18 + var_57_11
					end
				end

				arg_54_1.text_.text = var_57_15
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322242", "322242013", "story_v_out_322242.awb") ~= 0 then
					local var_57_19 = manager.audio:GetVoiceLength("story_v_out_322242", "322242013", "story_v_out_322242.awb") / 1000

					if var_57_19 + var_57_11 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_19 + var_57_11
					end

					if var_57_14.prefab_name ~= "" and arg_54_1.actors_[var_57_14.prefab_name] ~= nil then
						local var_57_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_14.prefab_name].transform, "story_v_out_322242", "322242013", "story_v_out_322242.awb")

						arg_54_1:RecordAudio("322242013", var_57_20)
						arg_54_1:RecordAudio("322242013", var_57_20)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_322242", "322242013", "story_v_out_322242.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_322242", "322242013", "story_v_out_322242.awb")
				end

				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_21 = math.max(var_57_12, arg_54_1.talkMaxDuration)

			if var_57_11 <= arg_54_1.time_ and arg_54_1.time_ < var_57_11 + var_57_21 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_11) / var_57_21

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_11 + var_57_21 and arg_54_1.time_ < var_57_11 + var_57_21 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {}

		arg_54_1:InitPlayNodeList()
	end,
	Play322242014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 322242014
		arg_58_1.duration_ = 5

		local var_58_0 = {
			zh = 1.966,
			ja = 5
		}
		local var_58_1 = manager.audio:GetLocalizationFlag()

		if var_58_0[var_58_1] ~= nil then
			arg_58_1.duration_ = var_58_0[var_58_1]
		end

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play322242015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = arg_58_1.actors_["1020ui_story"]
			local var_61_1 = 0

			if var_61_1 < arg_58_1.time_ and arg_58_1.time_ <= var_61_1 + arg_61_0 and not isNil(var_61_0) and arg_58_1.var_.characterEffect1020ui_story == nil then
				arg_58_1.var_.characterEffect1020ui_story = var_61_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_2 = 0.200000002980232

			if var_61_1 <= arg_58_1.time_ and arg_58_1.time_ < var_61_1 + var_61_2 and not isNil(var_61_0) then
				local var_61_3 = (arg_58_1.time_ - var_61_1) / var_61_2

				if arg_58_1.var_.characterEffect1020ui_story and not isNil(var_61_0) then
					arg_58_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_58_1.time_ >= var_61_1 + var_61_2 and arg_58_1.time_ < var_61_1 + var_61_2 + arg_61_0 and not isNil(var_61_0) and arg_58_1.var_.characterEffect1020ui_story then
				arg_58_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_61_4 = arg_58_1.actors_["1029ui_story"]
			local var_61_5 = 0

			if var_61_5 < arg_58_1.time_ and arg_58_1.time_ <= var_61_5 + arg_61_0 and not isNil(var_61_4) and arg_58_1.var_.characterEffect1029ui_story == nil then
				arg_58_1.var_.characterEffect1029ui_story = var_61_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_6 = 0.200000002980232

			if var_61_5 <= arg_58_1.time_ and arg_58_1.time_ < var_61_5 + var_61_6 and not isNil(var_61_4) then
				local var_61_7 = (arg_58_1.time_ - var_61_5) / var_61_6

				if arg_58_1.var_.characterEffect1029ui_story and not isNil(var_61_4) then
					local var_61_8 = Mathf.Lerp(0, 0.5, var_61_7)

					arg_58_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_58_1.var_.characterEffect1029ui_story.fillRatio = var_61_8
				end
			end

			if arg_58_1.time_ >= var_61_5 + var_61_6 and arg_58_1.time_ < var_61_5 + var_61_6 + arg_61_0 and not isNil(var_61_4) and arg_58_1.var_.characterEffect1029ui_story then
				local var_61_9 = 0.5

				arg_58_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_58_1.var_.characterEffect1029ui_story.fillRatio = var_61_9
			end

			local var_61_10 = 0
			local var_61_11 = 0.3

			if var_61_10 < arg_58_1.time_ and arg_58_1.time_ <= var_61_10 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				local var_61_12 = arg_58_1:FormatText(StoryNameCfg[613].name)

				arg_58_1.leftNameTxt_.text = var_61_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_13 = arg_58_1:GetWordFromCfg(322242014)
				local var_61_14 = arg_58_1:FormatText(var_61_13.content)

				arg_58_1.text_.text = var_61_14

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_15 = 12
				local var_61_16 = utf8.len(var_61_14)
				local var_61_17 = var_61_15 <= 0 and var_61_11 or var_61_11 * (var_61_16 / var_61_15)

				if var_61_17 > 0 and var_61_11 < var_61_17 then
					arg_58_1.talkMaxDuration = var_61_17

					if var_61_17 + var_61_10 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_17 + var_61_10
					end
				end

				arg_58_1.text_.text = var_61_14
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322242", "322242014", "story_v_out_322242.awb") ~= 0 then
					local var_61_18 = manager.audio:GetVoiceLength("story_v_out_322242", "322242014", "story_v_out_322242.awb") / 1000

					if var_61_18 + var_61_10 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_18 + var_61_10
					end

					if var_61_13.prefab_name ~= "" and arg_58_1.actors_[var_61_13.prefab_name] ~= nil then
						local var_61_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_13.prefab_name].transform, "story_v_out_322242", "322242014", "story_v_out_322242.awb")

						arg_58_1:RecordAudio("322242014", var_61_19)
						arg_58_1:RecordAudio("322242014", var_61_19)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_322242", "322242014", "story_v_out_322242.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_322242", "322242014", "story_v_out_322242.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_20 = math.max(var_61_11, arg_58_1.talkMaxDuration)

			if var_61_10 <= arg_58_1.time_ and arg_58_1.time_ < var_61_10 + var_61_20 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_10) / var_61_20

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_10 + var_61_20 and arg_58_1.time_ < var_61_10 + var_61_20 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play322242015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 322242015
		arg_62_1.duration_ = 4.53

		local var_62_0 = {
			zh = 2.3,
			ja = 4.533
		}
		local var_62_1 = manager.audio:GetLocalizationFlag()

		if var_62_0[var_62_1] ~= nil then
			arg_62_1.duration_ = var_62_0[var_62_1]
		end

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play322242016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = arg_62_1.actors_["1029ui_story"]
			local var_65_1 = 0

			if var_65_1 < arg_62_1.time_ and arg_62_1.time_ <= var_65_1 + arg_65_0 and not isNil(var_65_0) and arg_62_1.var_.characterEffect1029ui_story == nil then
				arg_62_1.var_.characterEffect1029ui_story = var_65_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_2 = 0.200000002980232

			if var_65_1 <= arg_62_1.time_ and arg_62_1.time_ < var_65_1 + var_65_2 and not isNil(var_65_0) then
				local var_65_3 = (arg_62_1.time_ - var_65_1) / var_65_2

				if arg_62_1.var_.characterEffect1029ui_story and not isNil(var_65_0) then
					arg_62_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_62_1.time_ >= var_65_1 + var_65_2 and arg_62_1.time_ < var_65_1 + var_65_2 + arg_65_0 and not isNil(var_65_0) and arg_62_1.var_.characterEffect1029ui_story then
				arg_62_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_65_4 = arg_62_1.actors_["1020ui_story"]
			local var_65_5 = 0

			if var_65_5 < arg_62_1.time_ and arg_62_1.time_ <= var_65_5 + arg_65_0 and not isNil(var_65_4) and arg_62_1.var_.characterEffect1020ui_story == nil then
				arg_62_1.var_.characterEffect1020ui_story = var_65_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_6 = 0.200000002980232

			if var_65_5 <= arg_62_1.time_ and arg_62_1.time_ < var_65_5 + var_65_6 and not isNil(var_65_4) then
				local var_65_7 = (arg_62_1.time_ - var_65_5) / var_65_6

				if arg_62_1.var_.characterEffect1020ui_story and not isNil(var_65_4) then
					local var_65_8 = Mathf.Lerp(0, 0.5, var_65_7)

					arg_62_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_62_1.var_.characterEffect1020ui_story.fillRatio = var_65_8
				end
			end

			if arg_62_1.time_ >= var_65_5 + var_65_6 and arg_62_1.time_ < var_65_5 + var_65_6 + arg_65_0 and not isNil(var_65_4) and arg_62_1.var_.characterEffect1020ui_story then
				local var_65_9 = 0.5

				arg_62_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_62_1.var_.characterEffect1020ui_story.fillRatio = var_65_9
			end

			local var_65_10 = 0

			if var_65_10 < arg_62_1.time_ and arg_62_1.time_ <= var_65_10 + arg_65_0 then
				arg_62_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action4_2")
			end

			local var_65_11 = 0
			local var_65_12 = 0.35

			if var_65_11 < arg_62_1.time_ and arg_62_1.time_ <= var_65_11 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				local var_65_13 = arg_62_1:FormatText(StoryNameCfg[319].name)

				arg_62_1.leftNameTxt_.text = var_65_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_14 = arg_62_1:GetWordFromCfg(322242015)
				local var_65_15 = arg_62_1:FormatText(var_65_14.content)

				arg_62_1.text_.text = var_65_15

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_16 = 14
				local var_65_17 = utf8.len(var_65_15)
				local var_65_18 = var_65_16 <= 0 and var_65_12 or var_65_12 * (var_65_17 / var_65_16)

				if var_65_18 > 0 and var_65_12 < var_65_18 then
					arg_62_1.talkMaxDuration = var_65_18

					if var_65_18 + var_65_11 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_18 + var_65_11
					end
				end

				arg_62_1.text_.text = var_65_15
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322242", "322242015", "story_v_out_322242.awb") ~= 0 then
					local var_65_19 = manager.audio:GetVoiceLength("story_v_out_322242", "322242015", "story_v_out_322242.awb") / 1000

					if var_65_19 + var_65_11 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_19 + var_65_11
					end

					if var_65_14.prefab_name ~= "" and arg_62_1.actors_[var_65_14.prefab_name] ~= nil then
						local var_65_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_14.prefab_name].transform, "story_v_out_322242", "322242015", "story_v_out_322242.awb")

						arg_62_1:RecordAudio("322242015", var_65_20)
						arg_62_1:RecordAudio("322242015", var_65_20)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_322242", "322242015", "story_v_out_322242.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_322242", "322242015", "story_v_out_322242.awb")
				end

				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_21 = math.max(var_65_12, arg_62_1.talkMaxDuration)

			if var_65_11 <= arg_62_1.time_ and arg_62_1.time_ < var_65_11 + var_65_21 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_11) / var_65_21

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_11 + var_65_21 and arg_62_1.time_ < var_65_11 + var_65_21 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	Play322242016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 322242016
		arg_66_1.duration_ = 8.33

		local var_66_0 = {
			zh = 4.933,
			ja = 8.333
		}
		local var_66_1 = manager.audio:GetLocalizationFlag()

		if var_66_0[var_66_1] ~= nil then
			arg_66_1.duration_ = var_66_0[var_66_1]
		end

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play322242017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = arg_66_1.actors_["1020ui_story"]
			local var_69_1 = 0

			if var_69_1 < arg_66_1.time_ and arg_66_1.time_ <= var_69_1 + arg_69_0 and not isNil(var_69_0) and arg_66_1.var_.characterEffect1020ui_story == nil then
				arg_66_1.var_.characterEffect1020ui_story = var_69_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_2 = 0.200000002980232

			if var_69_1 <= arg_66_1.time_ and arg_66_1.time_ < var_69_1 + var_69_2 and not isNil(var_69_0) then
				local var_69_3 = (arg_66_1.time_ - var_69_1) / var_69_2

				if arg_66_1.var_.characterEffect1020ui_story and not isNil(var_69_0) then
					arg_66_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_66_1.time_ >= var_69_1 + var_69_2 and arg_66_1.time_ < var_69_1 + var_69_2 + arg_69_0 and not isNil(var_69_0) and arg_66_1.var_.characterEffect1020ui_story then
				arg_66_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_69_4 = arg_66_1.actors_["1029ui_story"]
			local var_69_5 = 0

			if var_69_5 < arg_66_1.time_ and arg_66_1.time_ <= var_69_5 + arg_69_0 and not isNil(var_69_4) and arg_66_1.var_.characterEffect1029ui_story == nil then
				arg_66_1.var_.characterEffect1029ui_story = var_69_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_6 = 0.200000002980232

			if var_69_5 <= arg_66_1.time_ and arg_66_1.time_ < var_69_5 + var_69_6 and not isNil(var_69_4) then
				local var_69_7 = (arg_66_1.time_ - var_69_5) / var_69_6

				if arg_66_1.var_.characterEffect1029ui_story and not isNil(var_69_4) then
					local var_69_8 = Mathf.Lerp(0, 0.5, var_69_7)

					arg_66_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_66_1.var_.characterEffect1029ui_story.fillRatio = var_69_8
				end
			end

			if arg_66_1.time_ >= var_69_5 + var_69_6 and arg_66_1.time_ < var_69_5 + var_69_6 + arg_69_0 and not isNil(var_69_4) and arg_66_1.var_.characterEffect1029ui_story then
				local var_69_9 = 0.5

				arg_66_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_66_1.var_.characterEffect1029ui_story.fillRatio = var_69_9
			end

			local var_69_10 = 0
			local var_69_11 = 0.625

			if var_69_10 < arg_66_1.time_ and arg_66_1.time_ <= var_69_10 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				local var_69_12 = arg_66_1:FormatText(StoryNameCfg[613].name)

				arg_66_1.leftNameTxt_.text = var_69_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_13 = arg_66_1:GetWordFromCfg(322242016)
				local var_69_14 = arg_66_1:FormatText(var_69_13.content)

				arg_66_1.text_.text = var_69_14

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_15 = 25
				local var_69_16 = utf8.len(var_69_14)
				local var_69_17 = var_69_15 <= 0 and var_69_11 or var_69_11 * (var_69_16 / var_69_15)

				if var_69_17 > 0 and var_69_11 < var_69_17 then
					arg_66_1.talkMaxDuration = var_69_17

					if var_69_17 + var_69_10 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_17 + var_69_10
					end
				end

				arg_66_1.text_.text = var_69_14
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322242", "322242016", "story_v_out_322242.awb") ~= 0 then
					local var_69_18 = manager.audio:GetVoiceLength("story_v_out_322242", "322242016", "story_v_out_322242.awb") / 1000

					if var_69_18 + var_69_10 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_18 + var_69_10
					end

					if var_69_13.prefab_name ~= "" and arg_66_1.actors_[var_69_13.prefab_name] ~= nil then
						local var_69_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_13.prefab_name].transform, "story_v_out_322242", "322242016", "story_v_out_322242.awb")

						arg_66_1:RecordAudio("322242016", var_69_19)
						arg_66_1:RecordAudio("322242016", var_69_19)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_322242", "322242016", "story_v_out_322242.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_322242", "322242016", "story_v_out_322242.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_20 = math.max(var_69_11, arg_66_1.talkMaxDuration)

			if var_69_10 <= arg_66_1.time_ and arg_66_1.time_ < var_69_10 + var_69_20 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_10) / var_69_20

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_10 + var_69_20 and arg_66_1.time_ < var_69_10 + var_69_20 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play322242017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 322242017
		arg_70_1.duration_ = 7.27

		local var_70_0 = {
			zh = 6.4,
			ja = 7.266
		}
		local var_70_1 = manager.audio:GetLocalizationFlag()

		if var_70_0[var_70_1] ~= nil then
			arg_70_1.duration_ = var_70_0[var_70_1]
		end

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play322242018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = arg_70_1.actors_["1029ui_story"]
			local var_73_1 = 0

			if var_73_1 < arg_70_1.time_ and arg_70_1.time_ <= var_73_1 + arg_73_0 and not isNil(var_73_0) and arg_70_1.var_.characterEffect1029ui_story == nil then
				arg_70_1.var_.characterEffect1029ui_story = var_73_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_2 = 0.200000002980232

			if var_73_1 <= arg_70_1.time_ and arg_70_1.time_ < var_73_1 + var_73_2 and not isNil(var_73_0) then
				local var_73_3 = (arg_70_1.time_ - var_73_1) / var_73_2

				if arg_70_1.var_.characterEffect1029ui_story and not isNil(var_73_0) then
					arg_70_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_70_1.time_ >= var_73_1 + var_73_2 and arg_70_1.time_ < var_73_1 + var_73_2 + arg_73_0 and not isNil(var_73_0) and arg_70_1.var_.characterEffect1029ui_story then
				arg_70_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_73_4 = arg_70_1.actors_["1020ui_story"]
			local var_73_5 = 0

			if var_73_5 < arg_70_1.time_ and arg_70_1.time_ <= var_73_5 + arg_73_0 and not isNil(var_73_4) and arg_70_1.var_.characterEffect1020ui_story == nil then
				arg_70_1.var_.characterEffect1020ui_story = var_73_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_6 = 0.200000002980232

			if var_73_5 <= arg_70_1.time_ and arg_70_1.time_ < var_73_5 + var_73_6 and not isNil(var_73_4) then
				local var_73_7 = (arg_70_1.time_ - var_73_5) / var_73_6

				if arg_70_1.var_.characterEffect1020ui_story and not isNil(var_73_4) then
					local var_73_8 = Mathf.Lerp(0, 0.5, var_73_7)

					arg_70_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_70_1.var_.characterEffect1020ui_story.fillRatio = var_73_8
				end
			end

			if arg_70_1.time_ >= var_73_5 + var_73_6 and arg_70_1.time_ < var_73_5 + var_73_6 + arg_73_0 and not isNil(var_73_4) and arg_70_1.var_.characterEffect1020ui_story then
				local var_73_9 = 0.5

				arg_70_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_70_1.var_.characterEffect1020ui_story.fillRatio = var_73_9
			end

			local var_73_10 = 0

			if var_73_10 < arg_70_1.time_ and arg_70_1.time_ <= var_73_10 + arg_73_0 then
				arg_70_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_73_11 = 0
			local var_73_12 = 0.675

			if var_73_11 < arg_70_1.time_ and arg_70_1.time_ <= var_73_11 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				local var_73_13 = arg_70_1:FormatText(StoryNameCfg[319].name)

				arg_70_1.leftNameTxt_.text = var_73_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_14 = arg_70_1:GetWordFromCfg(322242017)
				local var_73_15 = arg_70_1:FormatText(var_73_14.content)

				arg_70_1.text_.text = var_73_15

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_16 = 27
				local var_73_17 = utf8.len(var_73_15)
				local var_73_18 = var_73_16 <= 0 and var_73_12 or var_73_12 * (var_73_17 / var_73_16)

				if var_73_18 > 0 and var_73_12 < var_73_18 then
					arg_70_1.talkMaxDuration = var_73_18

					if var_73_18 + var_73_11 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_18 + var_73_11
					end
				end

				arg_70_1.text_.text = var_73_15
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322242", "322242017", "story_v_out_322242.awb") ~= 0 then
					local var_73_19 = manager.audio:GetVoiceLength("story_v_out_322242", "322242017", "story_v_out_322242.awb") / 1000

					if var_73_19 + var_73_11 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_19 + var_73_11
					end

					if var_73_14.prefab_name ~= "" and arg_70_1.actors_[var_73_14.prefab_name] ~= nil then
						local var_73_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_14.prefab_name].transform, "story_v_out_322242", "322242017", "story_v_out_322242.awb")

						arg_70_1:RecordAudio("322242017", var_73_20)
						arg_70_1:RecordAudio("322242017", var_73_20)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_322242", "322242017", "story_v_out_322242.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_322242", "322242017", "story_v_out_322242.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_21 = math.max(var_73_12, arg_70_1.talkMaxDuration)

			if var_73_11 <= arg_70_1.time_ and arg_70_1.time_ < var_73_11 + var_73_21 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_11) / var_73_21

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_11 + var_73_21 and arg_70_1.time_ < var_73_11 + var_73_21 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play322242018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 322242018
		arg_74_1.duration_ = 9.13

		local var_74_0 = {
			zh = 9.133,
			ja = 6.1
		}
		local var_74_1 = manager.audio:GetLocalizationFlag()

		if var_74_0[var_74_1] ~= nil then
			arg_74_1.duration_ = var_74_0[var_74_1]
		end

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play322242019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = 0
			local var_77_1 = 1.025

			if var_77_0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_0 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				local var_77_2 = arg_74_1:FormatText(StoryNameCfg[319].name)

				arg_74_1.leftNameTxt_.text = var_77_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_3 = arg_74_1:GetWordFromCfg(322242018)
				local var_77_4 = arg_74_1:FormatText(var_77_3.content)

				arg_74_1.text_.text = var_77_4

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_5 = 41
				local var_77_6 = utf8.len(var_77_4)
				local var_77_7 = var_77_5 <= 0 and var_77_1 or var_77_1 * (var_77_6 / var_77_5)

				if var_77_7 > 0 and var_77_1 < var_77_7 then
					arg_74_1.talkMaxDuration = var_77_7

					if var_77_7 + var_77_0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_7 + var_77_0
					end
				end

				arg_74_1.text_.text = var_77_4
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322242", "322242018", "story_v_out_322242.awb") ~= 0 then
					local var_77_8 = manager.audio:GetVoiceLength("story_v_out_322242", "322242018", "story_v_out_322242.awb") / 1000

					if var_77_8 + var_77_0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_8 + var_77_0
					end

					if var_77_3.prefab_name ~= "" and arg_74_1.actors_[var_77_3.prefab_name] ~= nil then
						local var_77_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_3.prefab_name].transform, "story_v_out_322242", "322242018", "story_v_out_322242.awb")

						arg_74_1:RecordAudio("322242018", var_77_9)
						arg_74_1:RecordAudio("322242018", var_77_9)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_322242", "322242018", "story_v_out_322242.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_322242", "322242018", "story_v_out_322242.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_10 = math.max(var_77_1, arg_74_1.talkMaxDuration)

			if var_77_0 <= arg_74_1.time_ and arg_74_1.time_ < var_77_0 + var_77_10 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_0) / var_77_10

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_0 + var_77_10 and arg_74_1.time_ < var_77_0 + var_77_10 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play322242019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 322242019
		arg_78_1.duration_ = 6.7

		local var_78_0 = {
			zh = 4.366,
			ja = 6.7
		}
		local var_78_1 = manager.audio:GetLocalizationFlag()

		if var_78_0[var_78_1] ~= nil then
			arg_78_1.duration_ = var_78_0[var_78_1]
		end

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play322242020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = 0

			if var_81_0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_0 + arg_81_0 then
				arg_78_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action7_1")
			end

			local var_81_1 = 0
			local var_81_2 = 0.375

			if var_81_1 < arg_78_1.time_ and arg_78_1.time_ <= var_81_1 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				local var_81_3 = arg_78_1:FormatText(StoryNameCfg[319].name)

				arg_78_1.leftNameTxt_.text = var_81_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_4 = arg_78_1:GetWordFromCfg(322242019)
				local var_81_5 = arg_78_1:FormatText(var_81_4.content)

				arg_78_1.text_.text = var_81_5

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_6 = 15
				local var_81_7 = utf8.len(var_81_5)
				local var_81_8 = var_81_6 <= 0 and var_81_2 or var_81_2 * (var_81_7 / var_81_6)

				if var_81_8 > 0 and var_81_2 < var_81_8 then
					arg_78_1.talkMaxDuration = var_81_8

					if var_81_8 + var_81_1 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_8 + var_81_1
					end
				end

				arg_78_1.text_.text = var_81_5
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322242", "322242019", "story_v_out_322242.awb") ~= 0 then
					local var_81_9 = manager.audio:GetVoiceLength("story_v_out_322242", "322242019", "story_v_out_322242.awb") / 1000

					if var_81_9 + var_81_1 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_9 + var_81_1
					end

					if var_81_4.prefab_name ~= "" and arg_78_1.actors_[var_81_4.prefab_name] ~= nil then
						local var_81_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_4.prefab_name].transform, "story_v_out_322242", "322242019", "story_v_out_322242.awb")

						arg_78_1:RecordAudio("322242019", var_81_10)
						arg_78_1:RecordAudio("322242019", var_81_10)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_322242", "322242019", "story_v_out_322242.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_322242", "322242019", "story_v_out_322242.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_11 = math.max(var_81_2, arg_78_1.talkMaxDuration)

			if var_81_1 <= arg_78_1.time_ and arg_78_1.time_ < var_81_1 + var_81_11 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_1) / var_81_11

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_1 + var_81_11 and arg_78_1.time_ < var_81_1 + var_81_11 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play322242020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 322242020
		arg_82_1.duration_ = 5

		local var_82_0 = {
			zh = 3.8,
			ja = 5
		}
		local var_82_1 = manager.audio:GetLocalizationFlag()

		if var_82_0[var_82_1] ~= nil then
			arg_82_1.duration_ = var_82_0[var_82_1]
		end

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play322242021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = 0
			local var_85_1 = 0.475

			if var_85_0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_0 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				local var_85_2 = arg_82_1:FormatText(StoryNameCfg[319].name)

				arg_82_1.leftNameTxt_.text = var_85_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_3 = arg_82_1:GetWordFromCfg(322242020)
				local var_85_4 = arg_82_1:FormatText(var_85_3.content)

				arg_82_1.text_.text = var_85_4

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_5 = 19
				local var_85_6 = utf8.len(var_85_4)
				local var_85_7 = var_85_5 <= 0 and var_85_1 or var_85_1 * (var_85_6 / var_85_5)

				if var_85_7 > 0 and var_85_1 < var_85_7 then
					arg_82_1.talkMaxDuration = var_85_7

					if var_85_7 + var_85_0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_7 + var_85_0
					end
				end

				arg_82_1.text_.text = var_85_4
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322242", "322242020", "story_v_out_322242.awb") ~= 0 then
					local var_85_8 = manager.audio:GetVoiceLength("story_v_out_322242", "322242020", "story_v_out_322242.awb") / 1000

					if var_85_8 + var_85_0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_8 + var_85_0
					end

					if var_85_3.prefab_name ~= "" and arg_82_1.actors_[var_85_3.prefab_name] ~= nil then
						local var_85_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_3.prefab_name].transform, "story_v_out_322242", "322242020", "story_v_out_322242.awb")

						arg_82_1:RecordAudio("322242020", var_85_9)
						arg_82_1:RecordAudio("322242020", var_85_9)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_322242", "322242020", "story_v_out_322242.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_322242", "322242020", "story_v_out_322242.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_10 = math.max(var_85_1, arg_82_1.talkMaxDuration)

			if var_85_0 <= arg_82_1.time_ and arg_82_1.time_ < var_85_0 + var_85_10 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_0) / var_85_10

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_0 + var_85_10 and arg_82_1.time_ < var_85_0 + var_85_10 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play322242021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 322242021
		arg_86_1.duration_ = 9.33

		local var_86_0 = {
			zh = 7.9,
			ja = 9.333
		}
		local var_86_1 = manager.audio:GetLocalizationFlag()

		if var_86_0[var_86_1] ~= nil then
			arg_86_1.duration_ = var_86_0[var_86_1]
		end

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play322242022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = 4

			if var_89_0 < arg_86_1.time_ and arg_86_1.time_ <= var_89_0 + arg_89_0 then
				arg_86_1.allBtn_.enabled = false
			end

			local var_89_1 = 0.3

			if arg_86_1.time_ >= var_89_0 + var_89_1 and arg_86_1.time_ < var_89_0 + var_89_1 + arg_89_0 then
				arg_86_1.allBtn_.enabled = true
			end

			local var_89_2 = "ST04b"

			if arg_86_1.bgs_[var_89_2] == nil then
				local var_89_3 = Object.Instantiate(arg_86_1.paintGo_)

				var_89_3:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_89_2)
				var_89_3.name = var_89_2
				var_89_3.transform.parent = arg_86_1.stage_.transform
				var_89_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_86_1.bgs_[var_89_2] = var_89_3
			end

			local var_89_4 = 2

			if var_89_4 < arg_86_1.time_ and arg_86_1.time_ <= var_89_4 + arg_89_0 then
				local var_89_5 = manager.ui.mainCamera.transform.localPosition
				local var_89_6 = Vector3.New(0, 0, 10) + Vector3.New(var_89_5.x, var_89_5.y, 0)
				local var_89_7 = arg_86_1.bgs_.ST04b

				var_89_7.transform.localPosition = var_89_6
				var_89_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_89_8 = var_89_7:GetComponent("SpriteRenderer")

				if var_89_8 and var_89_8.sprite then
					local var_89_9 = (var_89_7.transform.localPosition - var_89_5).z
					local var_89_10 = manager.ui.mainCameraCom_
					local var_89_11 = 2 * var_89_9 * Mathf.Tan(var_89_10.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_89_12 = var_89_11 * var_89_10.aspect
					local var_89_13 = var_89_8.sprite.bounds.size.x
					local var_89_14 = var_89_8.sprite.bounds.size.y
					local var_89_15 = var_89_12 / var_89_13
					local var_89_16 = var_89_11 / var_89_14
					local var_89_17 = var_89_16 < var_89_15 and var_89_15 or var_89_16

					var_89_7.transform.localScale = Vector3.New(var_89_17, var_89_17, 0)
				end

				for iter_89_0, iter_89_1 in pairs(arg_86_1.bgs_) do
					if iter_89_0 ~= "ST04b" then
						iter_89_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_89_18 = 0

			if var_89_18 < arg_86_1.time_ and arg_86_1.time_ <= var_89_18 + arg_89_0 then
				arg_86_1.mask_.enabled = true
				arg_86_1.mask_.raycastTarget = true

				arg_86_1:SetGaussion(false)
			end

			local var_89_19 = 2

			if var_89_18 <= arg_86_1.time_ and arg_86_1.time_ < var_89_18 + var_89_19 then
				local var_89_20 = (arg_86_1.time_ - var_89_18) / var_89_19
				local var_89_21 = Color.New(0, 0, 0)

				var_89_21.a = Mathf.Lerp(0, 1, var_89_20)
				arg_86_1.mask_.color = var_89_21
			end

			if arg_86_1.time_ >= var_89_18 + var_89_19 and arg_86_1.time_ < var_89_18 + var_89_19 + arg_89_0 then
				local var_89_22 = Color.New(0, 0, 0)

				var_89_22.a = 1
				arg_86_1.mask_.color = var_89_22
			end

			local var_89_23 = 2

			if var_89_23 < arg_86_1.time_ and arg_86_1.time_ <= var_89_23 + arg_89_0 then
				arg_86_1.mask_.enabled = true
				arg_86_1.mask_.raycastTarget = true

				arg_86_1:SetGaussion(false)
			end

			local var_89_24 = 2

			if var_89_23 <= arg_86_1.time_ and arg_86_1.time_ < var_89_23 + var_89_24 then
				local var_89_25 = (arg_86_1.time_ - var_89_23) / var_89_24
				local var_89_26 = Color.New(0, 0, 0)

				var_89_26.a = Mathf.Lerp(1, 0, var_89_25)
				arg_86_1.mask_.color = var_89_26
			end

			if arg_86_1.time_ >= var_89_23 + var_89_24 and arg_86_1.time_ < var_89_23 + var_89_24 + arg_89_0 then
				local var_89_27 = Color.New(0, 0, 0)
				local var_89_28 = 0

				arg_86_1.mask_.enabled = false
				var_89_27.a = var_89_28
				arg_86_1.mask_.color = var_89_27
			end

			local var_89_29 = arg_86_1.actors_["1029ui_story"].transform
			local var_89_30 = 2

			if var_89_30 < arg_86_1.time_ and arg_86_1.time_ <= var_89_30 + arg_89_0 then
				arg_86_1.var_.moveOldPos1029ui_story = var_89_29.localPosition
			end

			local var_89_31 = 0.001

			if var_89_30 <= arg_86_1.time_ and arg_86_1.time_ < var_89_30 + var_89_31 then
				local var_89_32 = (arg_86_1.time_ - var_89_30) / var_89_31
				local var_89_33 = Vector3.New(0, 100, 0)

				var_89_29.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos1029ui_story, var_89_33, var_89_32)

				local var_89_34 = manager.ui.mainCamera.transform.position - var_89_29.position

				var_89_29.forward = Vector3.New(var_89_34.x, var_89_34.y, var_89_34.z)

				local var_89_35 = var_89_29.localEulerAngles

				var_89_35.z = 0
				var_89_35.x = 0
				var_89_29.localEulerAngles = var_89_35
			end

			if arg_86_1.time_ >= var_89_30 + var_89_31 and arg_86_1.time_ < var_89_30 + var_89_31 + arg_89_0 then
				var_89_29.localPosition = Vector3.New(0, 100, 0)

				local var_89_36 = manager.ui.mainCamera.transform.position - var_89_29.position

				var_89_29.forward = Vector3.New(var_89_36.x, var_89_36.y, var_89_36.z)

				local var_89_37 = var_89_29.localEulerAngles

				var_89_37.z = 0
				var_89_37.x = 0
				var_89_29.localEulerAngles = var_89_37
			end

			local var_89_38 = arg_86_1.actors_["1020ui_story"].transform
			local var_89_39 = 2

			if var_89_39 < arg_86_1.time_ and arg_86_1.time_ <= var_89_39 + arg_89_0 then
				arg_86_1.var_.moveOldPos1020ui_story = var_89_38.localPosition
			end

			local var_89_40 = 0.001

			if var_89_39 <= arg_86_1.time_ and arg_86_1.time_ < var_89_39 + var_89_40 then
				local var_89_41 = (arg_86_1.time_ - var_89_39) / var_89_40
				local var_89_42 = Vector3.New(0, 100, 0)

				var_89_38.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos1020ui_story, var_89_42, var_89_41)

				local var_89_43 = manager.ui.mainCamera.transform.position - var_89_38.position

				var_89_38.forward = Vector3.New(var_89_43.x, var_89_43.y, var_89_43.z)

				local var_89_44 = var_89_38.localEulerAngles

				var_89_44.z = 0
				var_89_44.x = 0
				var_89_38.localEulerAngles = var_89_44
			end

			if arg_86_1.time_ >= var_89_39 + var_89_40 and arg_86_1.time_ < var_89_39 + var_89_40 + arg_89_0 then
				var_89_38.localPosition = Vector3.New(0, 100, 0)

				local var_89_45 = manager.ui.mainCamera.transform.position - var_89_38.position

				var_89_38.forward = Vector3.New(var_89_45.x, var_89_45.y, var_89_45.z)

				local var_89_46 = var_89_38.localEulerAngles

				var_89_46.z = 0
				var_89_46.x = 0
				var_89_38.localEulerAngles = var_89_46
			end

			local var_89_47 = arg_86_1.actors_["1020ui_story"].transform
			local var_89_48 = 4

			if var_89_48 < arg_86_1.time_ and arg_86_1.time_ <= var_89_48 + arg_89_0 then
				arg_86_1.var_.moveOldPos1020ui_story = var_89_47.localPosition
			end

			local var_89_49 = 0.001

			if var_89_48 <= arg_86_1.time_ and arg_86_1.time_ < var_89_48 + var_89_49 then
				local var_89_50 = (arg_86_1.time_ - var_89_48) / var_89_49
				local var_89_51 = Vector3.New(0, -0.85, -6.25)

				var_89_47.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos1020ui_story, var_89_51, var_89_50)

				local var_89_52 = manager.ui.mainCamera.transform.position - var_89_47.position

				var_89_47.forward = Vector3.New(var_89_52.x, var_89_52.y, var_89_52.z)

				local var_89_53 = var_89_47.localEulerAngles

				var_89_53.z = 0
				var_89_53.x = 0
				var_89_47.localEulerAngles = var_89_53
			end

			if arg_86_1.time_ >= var_89_48 + var_89_49 and arg_86_1.time_ < var_89_48 + var_89_49 + arg_89_0 then
				var_89_47.localPosition = Vector3.New(0, -0.85, -6.25)

				local var_89_54 = manager.ui.mainCamera.transform.position - var_89_47.position

				var_89_47.forward = Vector3.New(var_89_54.x, var_89_54.y, var_89_54.z)

				local var_89_55 = var_89_47.localEulerAngles

				var_89_55.z = 0
				var_89_55.x = 0
				var_89_47.localEulerAngles = var_89_55
			end

			local var_89_56 = arg_86_1.actors_["1020ui_story"]
			local var_89_57 = 4

			if var_89_57 < arg_86_1.time_ and arg_86_1.time_ <= var_89_57 + arg_89_0 and not isNil(var_89_56) and arg_86_1.var_.characterEffect1020ui_story == nil then
				arg_86_1.var_.characterEffect1020ui_story = var_89_56:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_58 = 0.200000002980232

			if var_89_57 <= arg_86_1.time_ and arg_86_1.time_ < var_89_57 + var_89_58 and not isNil(var_89_56) then
				local var_89_59 = (arg_86_1.time_ - var_89_57) / var_89_58

				if arg_86_1.var_.characterEffect1020ui_story and not isNil(var_89_56) then
					arg_86_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_86_1.time_ >= var_89_57 + var_89_58 and arg_86_1.time_ < var_89_57 + var_89_58 + arg_89_0 and not isNil(var_89_56) and arg_86_1.var_.characterEffect1020ui_story then
				arg_86_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_89_60 = 4

			if var_89_60 < arg_86_1.time_ and arg_86_1.time_ <= var_89_60 + arg_89_0 then
				arg_86_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action1_1")
			end

			local var_89_61 = 4

			if var_89_61 < arg_86_1.time_ and arg_86_1.time_ <= var_89_61 + arg_89_0 then
				arg_86_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_89_62 = 1.98333333333333

			arg_86_1.isInRecall_ = false

			if var_89_62 < arg_86_1.time_ and arg_86_1.time_ <= var_89_62 + arg_89_0 then
				arg_86_1.screenFilterGo_:SetActive(false)

				for iter_89_2, iter_89_3 in pairs(arg_86_1.actors_) do
					local var_89_63 = iter_89_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_89_4, iter_89_5 in ipairs(var_89_63) do
						if iter_89_5.color.r > 0.51 then
							iter_89_5.color = Color.New(1, 1, 1)
						else
							iter_89_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_89_64 = 0.0166666666666667

			if var_89_62 <= arg_86_1.time_ and arg_86_1.time_ < var_89_62 + var_89_64 then
				local var_89_65 = (arg_86_1.time_ - var_89_62) / var_89_64

				arg_86_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, var_89_65)
			end

			if arg_86_1.time_ >= var_89_62 + var_89_64 and arg_86_1.time_ < var_89_62 + var_89_64 + arg_89_0 then
				arg_86_1.screenFilterEffect_.weight = 0
			end

			local var_89_66 = 0.1
			local var_89_67 = 1

			if var_89_66 < arg_86_1.time_ and arg_86_1.time_ <= var_89_66 + arg_89_0 then
				local var_89_68 = "stop"
				local var_89_69 = "effect"

				arg_86_1:AudioAction(var_89_68, var_89_69, "se_story_side_1075", "se_story_side_1075_morningloop", "")
			end

			local var_89_70 = 1.56666666666667
			local var_89_71 = 1

			if var_89_70 < arg_86_1.time_ and arg_86_1.time_ <= var_89_70 + arg_89_0 then
				local var_89_72 = "play"
				local var_89_73 = "effect"

				arg_86_1:AudioAction(var_89_72, var_89_73, "se_story_142", "se_story_142_amb_city_street", "")
			end

			if arg_86_1.frameCnt_ <= 1 then
				arg_86_1.dialog_:SetActive(false)
			end

			local var_89_74 = 4
			local var_89_75 = 0.4

			if var_89_74 < arg_86_1.time_ and arg_86_1.time_ <= var_89_74 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0

				arg_86_1.dialog_:SetActive(true)

				arg_86_1.dialogCg_.alpha = 0

				local var_89_76 = LeanTween.value(arg_86_1.dialog_, 0, 1, 0.3)

				var_89_76:setOnUpdate(LuaHelper.FloatAction(function(arg_90_0)
					arg_86_1.dialogCg_.alpha = arg_90_0
				end))
				var_89_76:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_86_1.dialog_)
					var_89_76:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_86_1.duration_ = arg_86_1.duration_ + 0.3

				SetActive(arg_86_1.leftNameGo_, true)

				local var_89_77 = arg_86_1:FormatText(StoryNameCfg[613].name)

				arg_86_1.leftNameTxt_.text = var_89_77

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_78 = arg_86_1:GetWordFromCfg(322242021)
				local var_89_79 = arg_86_1:FormatText(var_89_78.content)

				arg_86_1.text_.text = var_89_79

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_80 = 16
				local var_89_81 = utf8.len(var_89_79)
				local var_89_82 = var_89_80 <= 0 and var_89_75 or var_89_75 * (var_89_81 / var_89_80)

				if var_89_82 > 0 and var_89_75 < var_89_82 then
					arg_86_1.talkMaxDuration = var_89_82
					var_89_74 = var_89_74 + 0.3

					if var_89_82 + var_89_74 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_82 + var_89_74
					end
				end

				arg_86_1.text_.text = var_89_79
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322242", "322242021", "story_v_out_322242.awb") ~= 0 then
					local var_89_83 = manager.audio:GetVoiceLength("story_v_out_322242", "322242021", "story_v_out_322242.awb") / 1000

					if var_89_83 + var_89_74 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_83 + var_89_74
					end

					if var_89_78.prefab_name ~= "" and arg_86_1.actors_[var_89_78.prefab_name] ~= nil then
						local var_89_84 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_78.prefab_name].transform, "story_v_out_322242", "322242021", "story_v_out_322242.awb")

						arg_86_1:RecordAudio("322242021", var_89_84)
						arg_86_1:RecordAudio("322242021", var_89_84)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_322242", "322242021", "story_v_out_322242.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_322242", "322242021", "story_v_out_322242.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_85 = var_89_74 + 0.3
			local var_89_86 = math.max(var_89_75, arg_86_1.talkMaxDuration)

			if var_89_85 <= arg_86_1.time_ and arg_86_1.time_ < var_89_85 + var_89_86 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_85) / var_89_86

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_85 + var_89_86 and arg_86_1.time_ < var_89_85 + var_89_86 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_86_1:InitPlayNodeList()
	end,
	Play322242022 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 322242022
		arg_92_1.duration_ = 5

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play322242023(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = arg_92_1.actors_["1020ui_story"].transform
			local var_95_1 = 0

			if var_95_1 < arg_92_1.time_ and arg_92_1.time_ <= var_95_1 + arg_95_0 then
				arg_92_1.var_.moveOldPos1020ui_story = var_95_0.localPosition
			end

			local var_95_2 = 0.001

			if var_95_1 <= arg_92_1.time_ and arg_92_1.time_ < var_95_1 + var_95_2 then
				local var_95_3 = (arg_92_1.time_ - var_95_1) / var_95_2
				local var_95_4 = Vector3.New(0, 100, 0)

				var_95_0.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos1020ui_story, var_95_4, var_95_3)

				local var_95_5 = manager.ui.mainCamera.transform.position - var_95_0.position

				var_95_0.forward = Vector3.New(var_95_5.x, var_95_5.y, var_95_5.z)

				local var_95_6 = var_95_0.localEulerAngles

				var_95_6.z = 0
				var_95_6.x = 0
				var_95_0.localEulerAngles = var_95_6
			end

			if arg_92_1.time_ >= var_95_1 + var_95_2 and arg_92_1.time_ < var_95_1 + var_95_2 + arg_95_0 then
				var_95_0.localPosition = Vector3.New(0, 100, 0)

				local var_95_7 = manager.ui.mainCamera.transform.position - var_95_0.position

				var_95_0.forward = Vector3.New(var_95_7.x, var_95_7.y, var_95_7.z)

				local var_95_8 = var_95_0.localEulerAngles

				var_95_8.z = 0
				var_95_8.x = 0
				var_95_0.localEulerAngles = var_95_8
			end

			local var_95_9 = 0.1
			local var_95_10 = 1

			if var_95_9 < arg_92_1.time_ and arg_92_1.time_ <= var_95_9 + arg_95_0 then
				local var_95_11 = "play"
				local var_95_12 = "effect"

				arg_92_1:AudioAction(var_95_11, var_95_12, "se_story_145", "se_story_145_gear02", "")
			end

			local var_95_13 = 0
			local var_95_14 = 1.075

			if var_95_13 < arg_92_1.time_ and arg_92_1.time_ <= var_95_13 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, false)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_15 = arg_92_1:GetWordFromCfg(322242022)
				local var_95_16 = arg_92_1:FormatText(var_95_15.content)

				arg_92_1.text_.text = var_95_16

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_17 = 43
				local var_95_18 = utf8.len(var_95_16)
				local var_95_19 = var_95_17 <= 0 and var_95_14 or var_95_14 * (var_95_18 / var_95_17)

				if var_95_19 > 0 and var_95_14 < var_95_19 then
					arg_92_1.talkMaxDuration = var_95_19

					if var_95_19 + var_95_13 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_19 + var_95_13
					end
				end

				arg_92_1.text_.text = var_95_16
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)
				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_20 = math.max(var_95_14, arg_92_1.talkMaxDuration)

			if var_95_13 <= arg_92_1.time_ and arg_92_1.time_ < var_95_13 + var_95_20 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_13) / var_95_20

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_13 + var_95_20 and arg_92_1.time_ < var_95_13 + var_95_20 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {
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

		arg_92_1:InitPlayNodeList()
	end,
	Play322242023 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 322242023
		arg_96_1.duration_ = 7.83

		local var_96_0 = {
			zh = 5.8,
			ja = 7.833
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
				arg_96_0:Play322242024(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = arg_96_1.actors_["1020ui_story"].transform
			local var_99_1 = 0

			if var_99_1 < arg_96_1.time_ and arg_96_1.time_ <= var_99_1 + arg_99_0 then
				arg_96_1.var_.moveOldPos1020ui_story = var_99_0.localPosition
			end

			local var_99_2 = 0.001

			if var_99_1 <= arg_96_1.time_ and arg_96_1.time_ < var_99_1 + var_99_2 then
				local var_99_3 = (arg_96_1.time_ - var_99_1) / var_99_2
				local var_99_4 = Vector3.New(0, -0.85, -6.25)

				var_99_0.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos1020ui_story, var_99_4, var_99_3)

				local var_99_5 = manager.ui.mainCamera.transform.position - var_99_0.position

				var_99_0.forward = Vector3.New(var_99_5.x, var_99_5.y, var_99_5.z)

				local var_99_6 = var_99_0.localEulerAngles

				var_99_6.z = 0
				var_99_6.x = 0
				var_99_0.localEulerAngles = var_99_6
			end

			if arg_96_1.time_ >= var_99_1 + var_99_2 and arg_96_1.time_ < var_99_1 + var_99_2 + arg_99_0 then
				var_99_0.localPosition = Vector3.New(0, -0.85, -6.25)

				local var_99_7 = manager.ui.mainCamera.transform.position - var_99_0.position

				var_99_0.forward = Vector3.New(var_99_7.x, var_99_7.y, var_99_7.z)

				local var_99_8 = var_99_0.localEulerAngles

				var_99_8.z = 0
				var_99_8.x = 0
				var_99_0.localEulerAngles = var_99_8
			end

			local var_99_9 = arg_96_1.actors_["1020ui_story"]
			local var_99_10 = 0

			if var_99_10 < arg_96_1.time_ and arg_96_1.time_ <= var_99_10 + arg_99_0 and not isNil(var_99_9) and arg_96_1.var_.characterEffect1020ui_story == nil then
				arg_96_1.var_.characterEffect1020ui_story = var_99_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_11 = 0.200000002980232

			if var_99_10 <= arg_96_1.time_ and arg_96_1.time_ < var_99_10 + var_99_11 and not isNil(var_99_9) then
				local var_99_12 = (arg_96_1.time_ - var_99_10) / var_99_11

				if arg_96_1.var_.characterEffect1020ui_story and not isNil(var_99_9) then
					arg_96_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_96_1.time_ >= var_99_10 + var_99_11 and arg_96_1.time_ < var_99_10 + var_99_11 + arg_99_0 and not isNil(var_99_9) and arg_96_1.var_.characterEffect1020ui_story then
				arg_96_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_99_13 = 0

			if var_99_13 < arg_96_1.time_ and arg_96_1.time_ <= var_99_13 + arg_99_0 then
				arg_96_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action1_1")
			end

			local var_99_14 = 0
			local var_99_15 = 0.675

			if var_99_14 < arg_96_1.time_ and arg_96_1.time_ <= var_99_14 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				local var_99_16 = arg_96_1:FormatText(StoryNameCfg[613].name)

				arg_96_1.leftNameTxt_.text = var_99_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_17 = arg_96_1:GetWordFromCfg(322242023)
				local var_99_18 = arg_96_1:FormatText(var_99_17.content)

				arg_96_1.text_.text = var_99_18

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_19 = 27
				local var_99_20 = utf8.len(var_99_18)
				local var_99_21 = var_99_19 <= 0 and var_99_15 or var_99_15 * (var_99_20 / var_99_19)

				if var_99_21 > 0 and var_99_15 < var_99_21 then
					arg_96_1.talkMaxDuration = var_99_21

					if var_99_21 + var_99_14 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_21 + var_99_14
					end
				end

				arg_96_1.text_.text = var_99_18
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322242", "322242023", "story_v_out_322242.awb") ~= 0 then
					local var_99_22 = manager.audio:GetVoiceLength("story_v_out_322242", "322242023", "story_v_out_322242.awb") / 1000

					if var_99_22 + var_99_14 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_22 + var_99_14
					end

					if var_99_17.prefab_name ~= "" and arg_96_1.actors_[var_99_17.prefab_name] ~= nil then
						local var_99_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_17.prefab_name].transform, "story_v_out_322242", "322242023", "story_v_out_322242.awb")

						arg_96_1:RecordAudio("322242023", var_99_23)
						arg_96_1:RecordAudio("322242023", var_99_23)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_322242", "322242023", "story_v_out_322242.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_322242", "322242023", "story_v_out_322242.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_24 = math.max(var_99_15, arg_96_1.talkMaxDuration)

			if var_99_14 <= arg_96_1.time_ and arg_96_1.time_ < var_99_14 + var_99_24 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_14) / var_99_24

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_14 + var_99_24 and arg_96_1.time_ < var_99_14 + var_99_24 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {
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

		arg_96_1:InitPlayNodeList()
	end,
	Play322242024 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 322242024
		arg_100_1.duration_ = 12.7

		local var_100_0 = {
			zh = 8.2,
			ja = 12.7
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
				arg_100_0:Play322242025(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = 0

			if var_103_0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_0 + arg_103_0 then
				arg_100_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action4_1")
			end

			local var_103_1 = 0

			if var_103_1 < arg_100_1.time_ and arg_100_1.time_ <= var_103_1 + arg_103_0 then
				arg_100_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_103_2 = 0
			local var_103_3 = 0.725

			if var_103_2 < arg_100_1.time_ and arg_100_1.time_ <= var_103_2 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				local var_103_4 = arg_100_1:FormatText(StoryNameCfg[613].name)

				arg_100_1.leftNameTxt_.text = var_103_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_5 = arg_100_1:GetWordFromCfg(322242024)
				local var_103_6 = arg_100_1:FormatText(var_103_5.content)

				arg_100_1.text_.text = var_103_6

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_7 = 29
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

				if manager.audio:GetVoiceLength("story_v_out_322242", "322242024", "story_v_out_322242.awb") ~= 0 then
					local var_103_10 = manager.audio:GetVoiceLength("story_v_out_322242", "322242024", "story_v_out_322242.awb") / 1000

					if var_103_10 + var_103_2 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_10 + var_103_2
					end

					if var_103_5.prefab_name ~= "" and arg_100_1.actors_[var_103_5.prefab_name] ~= nil then
						local var_103_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_5.prefab_name].transform, "story_v_out_322242", "322242024", "story_v_out_322242.awb")

						arg_100_1:RecordAudio("322242024", var_103_11)
						arg_100_1:RecordAudio("322242024", var_103_11)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_322242", "322242024", "story_v_out_322242.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_322242", "322242024", "story_v_out_322242.awb")
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
	Play322242025 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 322242025
		arg_104_1.duration_ = 5

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play322242026(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = arg_104_1.actors_["1020ui_story"]
			local var_107_1 = 0

			if var_107_1 < arg_104_1.time_ and arg_104_1.time_ <= var_107_1 + arg_107_0 and not isNil(var_107_0) and arg_104_1.var_.characterEffect1020ui_story == nil then
				arg_104_1.var_.characterEffect1020ui_story = var_107_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_2 = 0.200000002980232

			if var_107_1 <= arg_104_1.time_ and arg_104_1.time_ < var_107_1 + var_107_2 and not isNil(var_107_0) then
				local var_107_3 = (arg_104_1.time_ - var_107_1) / var_107_2

				if arg_104_1.var_.characterEffect1020ui_story and not isNil(var_107_0) then
					local var_107_4 = Mathf.Lerp(0, 0.5, var_107_3)

					arg_104_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_104_1.var_.characterEffect1020ui_story.fillRatio = var_107_4
				end
			end

			if arg_104_1.time_ >= var_107_1 + var_107_2 and arg_104_1.time_ < var_107_1 + var_107_2 + arg_107_0 and not isNil(var_107_0) and arg_104_1.var_.characterEffect1020ui_story then
				local var_107_5 = 0.5

				arg_104_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_104_1.var_.characterEffect1020ui_story.fillRatio = var_107_5
			end

			local var_107_6 = 0
			local var_107_7 = 0.675

			if var_107_6 < arg_104_1.time_ and arg_104_1.time_ <= var_107_6 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				local var_107_8 = arg_104_1:FormatText(StoryNameCfg[7].name)

				arg_104_1.leftNameTxt_.text = var_107_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, true)
				arg_104_1.iconController_:SetSelectedState("hero")

				arg_104_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_104_1.callingController_:SetSelectedState("normal")

				arg_104_1.keyicon_.color = Color.New(1, 1, 1)
				arg_104_1.icon_.color = Color.New(1, 1, 1)

				local var_107_9 = arg_104_1:GetWordFromCfg(322242025)
				local var_107_10 = arg_104_1:FormatText(var_107_9.content)

				arg_104_1.text_.text = var_107_10

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_11 = 27
				local var_107_12 = utf8.len(var_107_10)
				local var_107_13 = var_107_11 <= 0 and var_107_7 or var_107_7 * (var_107_12 / var_107_11)

				if var_107_13 > 0 and var_107_7 < var_107_13 then
					arg_104_1.talkMaxDuration = var_107_13

					if var_107_13 + var_107_6 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_13 + var_107_6
					end
				end

				arg_104_1.text_.text = var_107_10
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)
				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_14 = math.max(var_107_7, arg_104_1.talkMaxDuration)

			if var_107_6 <= arg_104_1.time_ and arg_104_1.time_ < var_107_6 + var_107_14 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_6) / var_107_14

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_6 + var_107_14 and arg_104_1.time_ < var_107_6 + var_107_14 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play322242026 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 322242026
		arg_108_1.duration_ = 5

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play322242027(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = 0
			local var_111_1 = 1.15

			if var_111_0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_0 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				local var_111_2 = arg_108_1:FormatText(StoryNameCfg[7].name)

				arg_108_1.leftNameTxt_.text = var_111_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, true)
				arg_108_1.iconController_:SetSelectedState("hero")

				arg_108_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_108_1.callingController_:SetSelectedState("normal")

				arg_108_1.keyicon_.color = Color.New(1, 1, 1)
				arg_108_1.icon_.color = Color.New(1, 1, 1)

				local var_111_3 = arg_108_1:GetWordFromCfg(322242026)
				local var_111_4 = arg_108_1:FormatText(var_111_3.content)

				arg_108_1.text_.text = var_111_4

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_5 = 46
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
				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_8 = math.max(var_111_1, arg_108_1.talkMaxDuration)

			if var_111_0 <= arg_108_1.time_ and arg_108_1.time_ < var_111_0 + var_111_8 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_0) / var_111_8

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_0 + var_111_8 and arg_108_1.time_ < var_111_0 + var_111_8 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play322242027 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 322242027
		arg_112_1.duration_ = 2.9

		local var_112_0 = {
			zh = 1.466,
			ja = 2.9
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
				arg_112_0:Play322242028(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = arg_112_1.actors_["1020ui_story"]
			local var_115_1 = 0

			if var_115_1 < arg_112_1.time_ and arg_112_1.time_ <= var_115_1 + arg_115_0 and not isNil(var_115_0) and arg_112_1.var_.characterEffect1020ui_story == nil then
				arg_112_1.var_.characterEffect1020ui_story = var_115_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_2 = 0.200000002980232

			if var_115_1 <= arg_112_1.time_ and arg_112_1.time_ < var_115_1 + var_115_2 and not isNil(var_115_0) then
				local var_115_3 = (arg_112_1.time_ - var_115_1) / var_115_2

				if arg_112_1.var_.characterEffect1020ui_story and not isNil(var_115_0) then
					arg_112_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_112_1.time_ >= var_115_1 + var_115_2 and arg_112_1.time_ < var_115_1 + var_115_2 + arg_115_0 and not isNil(var_115_0) and arg_112_1.var_.characterEffect1020ui_story then
				arg_112_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_115_4 = 0
			local var_115_5 = 0.1

			if var_115_4 < arg_112_1.time_ and arg_112_1.time_ <= var_115_4 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				local var_115_6 = arg_112_1:FormatText(StoryNameCfg[613].name)

				arg_112_1.leftNameTxt_.text = var_115_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_7 = arg_112_1:GetWordFromCfg(322242027)
				local var_115_8 = arg_112_1:FormatText(var_115_7.content)

				arg_112_1.text_.text = var_115_8

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_9 = 4
				local var_115_10 = utf8.len(var_115_8)
				local var_115_11 = var_115_9 <= 0 and var_115_5 or var_115_5 * (var_115_10 / var_115_9)

				if var_115_11 > 0 and var_115_5 < var_115_11 then
					arg_112_1.talkMaxDuration = var_115_11

					if var_115_11 + var_115_4 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_11 + var_115_4
					end
				end

				arg_112_1.text_.text = var_115_8
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322242", "322242027", "story_v_out_322242.awb") ~= 0 then
					local var_115_12 = manager.audio:GetVoiceLength("story_v_out_322242", "322242027", "story_v_out_322242.awb") / 1000

					if var_115_12 + var_115_4 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_12 + var_115_4
					end

					if var_115_7.prefab_name ~= "" and arg_112_1.actors_[var_115_7.prefab_name] ~= nil then
						local var_115_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_7.prefab_name].transform, "story_v_out_322242", "322242027", "story_v_out_322242.awb")

						arg_112_1:RecordAudio("322242027", var_115_13)
						arg_112_1:RecordAudio("322242027", var_115_13)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_322242", "322242027", "story_v_out_322242.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_322242", "322242027", "story_v_out_322242.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_14 = math.max(var_115_5, arg_112_1.talkMaxDuration)

			if var_115_4 <= arg_112_1.time_ and arg_112_1.time_ < var_115_4 + var_115_14 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_4) / var_115_14

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_4 + var_115_14 and arg_112_1.time_ < var_115_4 + var_115_14 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play322242028 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 322242028
		arg_116_1.duration_ = 5

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play322242029(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = arg_116_1.actors_["1020ui_story"].transform
			local var_119_1 = 0

			if var_119_1 < arg_116_1.time_ and arg_116_1.time_ <= var_119_1 + arg_119_0 then
				arg_116_1.var_.moveOldPos1020ui_story = var_119_0.localPosition
			end

			local var_119_2 = 0.001

			if var_119_1 <= arg_116_1.time_ and arg_116_1.time_ < var_119_1 + var_119_2 then
				local var_119_3 = (arg_116_1.time_ - var_119_1) / var_119_2
				local var_119_4 = Vector3.New(0, 100, 0)

				var_119_0.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos1020ui_story, var_119_4, var_119_3)

				local var_119_5 = manager.ui.mainCamera.transform.position - var_119_0.position

				var_119_0.forward = Vector3.New(var_119_5.x, var_119_5.y, var_119_5.z)

				local var_119_6 = var_119_0.localEulerAngles

				var_119_6.z = 0
				var_119_6.x = 0
				var_119_0.localEulerAngles = var_119_6
			end

			if arg_116_1.time_ >= var_119_1 + var_119_2 and arg_116_1.time_ < var_119_1 + var_119_2 + arg_119_0 then
				var_119_0.localPosition = Vector3.New(0, 100, 0)

				local var_119_7 = manager.ui.mainCamera.transform.position - var_119_0.position

				var_119_0.forward = Vector3.New(var_119_7.x, var_119_7.y, var_119_7.z)

				local var_119_8 = var_119_0.localEulerAngles

				var_119_8.z = 0
				var_119_8.x = 0
				var_119_0.localEulerAngles = var_119_8
			end

			local var_119_9 = 0.466666666666667
			local var_119_10 = 1

			if var_119_9 < arg_116_1.time_ and arg_116_1.time_ <= var_119_9 + arg_119_0 then
				local var_119_11 = "play"
				local var_119_12 = "effect"

				arg_116_1:AudioAction(var_119_11, var_119_12, "se_story_141", "se_story_141_holographic", "")
			end

			local var_119_13 = 0
			local var_119_14 = 1.175

			if var_119_13 < arg_116_1.time_ and arg_116_1.time_ <= var_119_13 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, false)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_15 = arg_116_1:GetWordFromCfg(322242028)
				local var_119_16 = arg_116_1:FormatText(var_119_15.content)

				arg_116_1.text_.text = var_119_16

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_17 = 47
				local var_119_18 = utf8.len(var_119_16)
				local var_119_19 = var_119_17 <= 0 and var_119_14 or var_119_14 * (var_119_18 / var_119_17)

				if var_119_19 > 0 and var_119_14 < var_119_19 then
					arg_116_1.talkMaxDuration = var_119_19

					if var_119_19 + var_119_13 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_19 + var_119_13
					end
				end

				arg_116_1.text_.text = var_119_16
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)
				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_20 = math.max(var_119_14, arg_116_1.talkMaxDuration)

			if var_119_13 <= arg_116_1.time_ and arg_116_1.time_ < var_119_13 + var_119_20 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_13) / var_119_20

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_13 + var_119_20 and arg_116_1.time_ < var_119_13 + var_119_20 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {
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

		arg_116_1:InitPlayNodeList()
	end,
	Play322242029 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 322242029
		arg_120_1.duration_ = 5

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play322242030(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = 0.1
			local var_123_1 = 1

			if var_123_0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_0 + arg_123_0 then
				local var_123_2 = "play"
				local var_123_3 = "effect"

				arg_120_1:AudioAction(var_123_2, var_123_3, "se_story_side_1094", "se_story_1094_data", "")
			end

			local var_123_4 = 0
			local var_123_5 = 0.975

			if var_123_4 < arg_120_1.time_ and arg_120_1.time_ <= var_123_4 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, false)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_6 = arg_120_1:GetWordFromCfg(322242029)
				local var_123_7 = arg_120_1:FormatText(var_123_6.content)

				arg_120_1.text_.text = var_123_7

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_8 = 39
				local var_123_9 = utf8.len(var_123_7)
				local var_123_10 = var_123_8 <= 0 and var_123_5 or var_123_5 * (var_123_9 / var_123_8)

				if var_123_10 > 0 and var_123_5 < var_123_10 then
					arg_120_1.talkMaxDuration = var_123_10

					if var_123_10 + var_123_4 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_10 + var_123_4
					end
				end

				arg_120_1.text_.text = var_123_7
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)
				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_11 = math.max(var_123_5, arg_120_1.talkMaxDuration)

			if var_123_4 <= arg_120_1.time_ and arg_120_1.time_ < var_123_4 + var_123_11 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_4) / var_123_11

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_4 + var_123_11 and arg_120_1.time_ < var_123_4 + var_123_11 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play322242030 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 322242030
		arg_124_1.duration_ = 5

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play322242031(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = 0
			local var_127_1 = 0.225

			if var_127_0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_0 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				local var_127_2 = arg_124_1:FormatText(StoryNameCfg[7].name)

				arg_124_1.leftNameTxt_.text = var_127_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, true)
				arg_124_1.iconController_:SetSelectedState("hero")

				arg_124_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_124_1.callingController_:SetSelectedState("normal")

				arg_124_1.keyicon_.color = Color.New(1, 1, 1)
				arg_124_1.icon_.color = Color.New(1, 1, 1)

				local var_127_3 = arg_124_1:GetWordFromCfg(322242030)
				local var_127_4 = arg_124_1:FormatText(var_127_3.content)

				arg_124_1.text_.text = var_127_4

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_5 = 9
				local var_127_6 = utf8.len(var_127_4)
				local var_127_7 = var_127_5 <= 0 and var_127_1 or var_127_1 * (var_127_6 / var_127_5)

				if var_127_7 > 0 and var_127_1 < var_127_7 then
					arg_124_1.talkMaxDuration = var_127_7

					if var_127_7 + var_127_0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_7 + var_127_0
					end
				end

				arg_124_1.text_.text = var_127_4
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)
				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_8 = math.max(var_127_1, arg_124_1.talkMaxDuration)

			if var_127_0 <= arg_124_1.time_ and arg_124_1.time_ < var_127_0 + var_127_8 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_0) / var_127_8

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_0 + var_127_8 and arg_124_1.time_ < var_127_0 + var_127_8 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play322242031 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 322242031
		arg_128_1.duration_ = 11.3

		local var_128_0 = {
			zh = 7.7,
			ja = 11.3
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
				arg_128_0:Play322242032(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = arg_128_1.actors_["1020ui_story"].transform
			local var_131_1 = 0

			if var_131_1 < arg_128_1.time_ and arg_128_1.time_ <= var_131_1 + arg_131_0 then
				arg_128_1.var_.moveOldPos1020ui_story = var_131_0.localPosition
			end

			local var_131_2 = 0.001

			if var_131_1 <= arg_128_1.time_ and arg_128_1.time_ < var_131_1 + var_131_2 then
				local var_131_3 = (arg_128_1.time_ - var_131_1) / var_131_2
				local var_131_4 = Vector3.New(0, -0.85, -6.25)

				var_131_0.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos1020ui_story, var_131_4, var_131_3)

				local var_131_5 = manager.ui.mainCamera.transform.position - var_131_0.position

				var_131_0.forward = Vector3.New(var_131_5.x, var_131_5.y, var_131_5.z)

				local var_131_6 = var_131_0.localEulerAngles

				var_131_6.z = 0
				var_131_6.x = 0
				var_131_0.localEulerAngles = var_131_6
			end

			if arg_128_1.time_ >= var_131_1 + var_131_2 and arg_128_1.time_ < var_131_1 + var_131_2 + arg_131_0 then
				var_131_0.localPosition = Vector3.New(0, -0.85, -6.25)

				local var_131_7 = manager.ui.mainCamera.transform.position - var_131_0.position

				var_131_0.forward = Vector3.New(var_131_7.x, var_131_7.y, var_131_7.z)

				local var_131_8 = var_131_0.localEulerAngles

				var_131_8.z = 0
				var_131_8.x = 0
				var_131_0.localEulerAngles = var_131_8
			end

			local var_131_9 = arg_128_1.actors_["1020ui_story"]
			local var_131_10 = 0

			if var_131_10 < arg_128_1.time_ and arg_128_1.time_ <= var_131_10 + arg_131_0 and not isNil(var_131_9) and arg_128_1.var_.characterEffect1020ui_story == nil then
				arg_128_1.var_.characterEffect1020ui_story = var_131_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_11 = 0.200000002980232

			if var_131_10 <= arg_128_1.time_ and arg_128_1.time_ < var_131_10 + var_131_11 and not isNil(var_131_9) then
				local var_131_12 = (arg_128_1.time_ - var_131_10) / var_131_11

				if arg_128_1.var_.characterEffect1020ui_story and not isNil(var_131_9) then
					arg_128_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_128_1.time_ >= var_131_10 + var_131_11 and arg_128_1.time_ < var_131_10 + var_131_11 + arg_131_0 and not isNil(var_131_9) and arg_128_1.var_.characterEffect1020ui_story then
				arg_128_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_131_13 = 0

			if var_131_13 < arg_128_1.time_ and arg_128_1.time_ <= var_131_13 + arg_131_0 then
				arg_128_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action1_1")
			end

			local var_131_14 = 0

			if var_131_14 < arg_128_1.time_ and arg_128_1.time_ <= var_131_14 + arg_131_0 then
				arg_128_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_131_15 = 0
			local var_131_16 = 0.925

			if var_131_15 < arg_128_1.time_ and arg_128_1.time_ <= var_131_15 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				local var_131_17 = arg_128_1:FormatText(StoryNameCfg[613].name)

				arg_128_1.leftNameTxt_.text = var_131_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_18 = arg_128_1:GetWordFromCfg(322242031)
				local var_131_19 = arg_128_1:FormatText(var_131_18.content)

				arg_128_1.text_.text = var_131_19

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_20 = 37
				local var_131_21 = utf8.len(var_131_19)
				local var_131_22 = var_131_20 <= 0 and var_131_16 or var_131_16 * (var_131_21 / var_131_20)

				if var_131_22 > 0 and var_131_16 < var_131_22 then
					arg_128_1.talkMaxDuration = var_131_22

					if var_131_22 + var_131_15 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_22 + var_131_15
					end
				end

				arg_128_1.text_.text = var_131_19
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322242", "322242031", "story_v_out_322242.awb") ~= 0 then
					local var_131_23 = manager.audio:GetVoiceLength("story_v_out_322242", "322242031", "story_v_out_322242.awb") / 1000

					if var_131_23 + var_131_15 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_23 + var_131_15
					end

					if var_131_18.prefab_name ~= "" and arg_128_1.actors_[var_131_18.prefab_name] ~= nil then
						local var_131_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_18.prefab_name].transform, "story_v_out_322242", "322242031", "story_v_out_322242.awb")

						arg_128_1:RecordAudio("322242031", var_131_24)
						arg_128_1:RecordAudio("322242031", var_131_24)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_322242", "322242031", "story_v_out_322242.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_322242", "322242031", "story_v_out_322242.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_25 = math.max(var_131_16, arg_128_1.talkMaxDuration)

			if var_131_15 <= arg_128_1.time_ and arg_128_1.time_ < var_131_15 + var_131_25 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_15) / var_131_25

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_15 + var_131_25 and arg_128_1.time_ < var_131_15 + var_131_25 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {
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

		arg_128_1:InitPlayNodeList()
	end,
	Play322242032 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 322242032
		arg_132_1.duration_ = 9.6

		local var_132_0 = {
			zh = 5.3,
			ja = 9.6
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
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play322242033(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = 0
			local var_135_1 = 0.7

			if var_135_0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_0 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				local var_135_2 = arg_132_1:FormatText(StoryNameCfg[613].name)

				arg_132_1.leftNameTxt_.text = var_135_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_3 = arg_132_1:GetWordFromCfg(322242032)
				local var_135_4 = arg_132_1:FormatText(var_135_3.content)

				arg_132_1.text_.text = var_135_4

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_5 = 28
				local var_135_6 = utf8.len(var_135_4)
				local var_135_7 = var_135_5 <= 0 and var_135_1 or var_135_1 * (var_135_6 / var_135_5)

				if var_135_7 > 0 and var_135_1 < var_135_7 then
					arg_132_1.talkMaxDuration = var_135_7

					if var_135_7 + var_135_0 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_7 + var_135_0
					end
				end

				arg_132_1.text_.text = var_135_4
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322242", "322242032", "story_v_out_322242.awb") ~= 0 then
					local var_135_8 = manager.audio:GetVoiceLength("story_v_out_322242", "322242032", "story_v_out_322242.awb") / 1000

					if var_135_8 + var_135_0 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_8 + var_135_0
					end

					if var_135_3.prefab_name ~= "" and arg_132_1.actors_[var_135_3.prefab_name] ~= nil then
						local var_135_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_3.prefab_name].transform, "story_v_out_322242", "322242032", "story_v_out_322242.awb")

						arg_132_1:RecordAudio("322242032", var_135_9)
						arg_132_1:RecordAudio("322242032", var_135_9)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_322242", "322242032", "story_v_out_322242.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_322242", "322242032", "story_v_out_322242.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_10 = math.max(var_135_1, arg_132_1.talkMaxDuration)

			if var_135_0 <= arg_132_1.time_ and arg_132_1.time_ < var_135_0 + var_135_10 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_0) / var_135_10

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_0 + var_135_10 and arg_132_1.time_ < var_135_0 + var_135_10 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play322242033 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 322242033
		arg_136_1.duration_ = 5

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play322242034(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = arg_136_1.actors_["1020ui_story"]
			local var_139_1 = 0

			if var_139_1 < arg_136_1.time_ and arg_136_1.time_ <= var_139_1 + arg_139_0 and not isNil(var_139_0) and arg_136_1.var_.characterEffect1020ui_story == nil then
				arg_136_1.var_.characterEffect1020ui_story = var_139_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_2 = 0.200000002980232

			if var_139_1 <= arg_136_1.time_ and arg_136_1.time_ < var_139_1 + var_139_2 and not isNil(var_139_0) then
				local var_139_3 = (arg_136_1.time_ - var_139_1) / var_139_2

				if arg_136_1.var_.characterEffect1020ui_story and not isNil(var_139_0) then
					local var_139_4 = Mathf.Lerp(0, 0.5, var_139_3)

					arg_136_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_136_1.var_.characterEffect1020ui_story.fillRatio = var_139_4
				end
			end

			if arg_136_1.time_ >= var_139_1 + var_139_2 and arg_136_1.time_ < var_139_1 + var_139_2 + arg_139_0 and not isNil(var_139_0) and arg_136_1.var_.characterEffect1020ui_story then
				local var_139_5 = 0.5

				arg_136_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_136_1.var_.characterEffect1020ui_story.fillRatio = var_139_5
			end

			local var_139_6 = 0
			local var_139_7 = 1.275

			if var_139_6 < arg_136_1.time_ and arg_136_1.time_ <= var_139_6 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, false)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_8 = arg_136_1:GetWordFromCfg(322242033)
				local var_139_9 = arg_136_1:FormatText(var_139_8.content)

				arg_136_1.text_.text = var_139_9

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_10 = 51
				local var_139_11 = utf8.len(var_139_9)
				local var_139_12 = var_139_10 <= 0 and var_139_7 or var_139_7 * (var_139_11 / var_139_10)

				if var_139_12 > 0 and var_139_7 < var_139_12 then
					arg_136_1.talkMaxDuration = var_139_12

					if var_139_12 + var_139_6 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_12 + var_139_6
					end
				end

				arg_136_1.text_.text = var_139_9
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)
				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_13 = math.max(var_139_7, arg_136_1.talkMaxDuration)

			if var_139_6 <= arg_136_1.time_ and arg_136_1.time_ < var_139_6 + var_139_13 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_6) / var_139_13

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_6 + var_139_13 and arg_136_1.time_ < var_139_6 + var_139_13 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play322242034 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 322242034
		arg_140_1.duration_ = 5

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play322242035(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = 0
			local var_143_1 = 0.725

			if var_143_0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_0 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				local var_143_2 = arg_140_1:FormatText(StoryNameCfg[7].name)

				arg_140_1.leftNameTxt_.text = var_143_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, true)
				arg_140_1.iconController_:SetSelectedState("hero")

				arg_140_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_140_1.callingController_:SetSelectedState("normal")

				arg_140_1.keyicon_.color = Color.New(1, 1, 1)
				arg_140_1.icon_.color = Color.New(1, 1, 1)

				local var_143_3 = arg_140_1:GetWordFromCfg(322242034)
				local var_143_4 = arg_140_1:FormatText(var_143_3.content)

				arg_140_1.text_.text = var_143_4

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_5 = 29
				local var_143_6 = utf8.len(var_143_4)
				local var_143_7 = var_143_5 <= 0 and var_143_1 or var_143_1 * (var_143_6 / var_143_5)

				if var_143_7 > 0 and var_143_1 < var_143_7 then
					arg_140_1.talkMaxDuration = var_143_7

					if var_143_7 + var_143_0 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_7 + var_143_0
					end
				end

				arg_140_1.text_.text = var_143_4
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)
				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_8 = math.max(var_143_1, arg_140_1.talkMaxDuration)

			if var_143_0 <= arg_140_1.time_ and arg_140_1.time_ < var_143_0 + var_143_8 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_0) / var_143_8

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_0 + var_143_8 and arg_140_1.time_ < var_143_0 + var_143_8 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play322242035 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 322242035
		arg_144_1.duration_ = 2.5

		local var_144_0 = {
			zh = 1.566,
			ja = 2.5
		}
		local var_144_1 = manager.audio:GetLocalizationFlag()

		if var_144_0[var_144_1] ~= nil then
			arg_144_1.duration_ = var_144_0[var_144_1]
		end

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play322242036(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = arg_144_1.actors_["1020ui_story"]
			local var_147_1 = 0

			if var_147_1 < arg_144_1.time_ and arg_144_1.time_ <= var_147_1 + arg_147_0 and not isNil(var_147_0) and arg_144_1.var_.characterEffect1020ui_story == nil then
				arg_144_1.var_.characterEffect1020ui_story = var_147_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_2 = 0.200000002980232

			if var_147_1 <= arg_144_1.time_ and arg_144_1.time_ < var_147_1 + var_147_2 and not isNil(var_147_0) then
				local var_147_3 = (arg_144_1.time_ - var_147_1) / var_147_2

				if arg_144_1.var_.characterEffect1020ui_story and not isNil(var_147_0) then
					arg_144_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_144_1.time_ >= var_147_1 + var_147_2 and arg_144_1.time_ < var_147_1 + var_147_2 + arg_147_0 and not isNil(var_147_0) and arg_144_1.var_.characterEffect1020ui_story then
				arg_144_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_147_4 = 0
			local var_147_5 = 0.15

			if var_147_4 < arg_144_1.time_ and arg_144_1.time_ <= var_147_4 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				local var_147_6 = arg_144_1:FormatText(StoryNameCfg[613].name)

				arg_144_1.leftNameTxt_.text = var_147_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_7 = arg_144_1:GetWordFromCfg(322242035)
				local var_147_8 = arg_144_1:FormatText(var_147_7.content)

				arg_144_1.text_.text = var_147_8

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_9 = 6
				local var_147_10 = utf8.len(var_147_8)
				local var_147_11 = var_147_9 <= 0 and var_147_5 or var_147_5 * (var_147_10 / var_147_9)

				if var_147_11 > 0 and var_147_5 < var_147_11 then
					arg_144_1.talkMaxDuration = var_147_11

					if var_147_11 + var_147_4 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_11 + var_147_4
					end
				end

				arg_144_1.text_.text = var_147_8
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322242", "322242035", "story_v_out_322242.awb") ~= 0 then
					local var_147_12 = manager.audio:GetVoiceLength("story_v_out_322242", "322242035", "story_v_out_322242.awb") / 1000

					if var_147_12 + var_147_4 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_12 + var_147_4
					end

					if var_147_7.prefab_name ~= "" and arg_144_1.actors_[var_147_7.prefab_name] ~= nil then
						local var_147_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_7.prefab_name].transform, "story_v_out_322242", "322242035", "story_v_out_322242.awb")

						arg_144_1:RecordAudio("322242035", var_147_13)
						arg_144_1:RecordAudio("322242035", var_147_13)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_322242", "322242035", "story_v_out_322242.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_322242", "322242035", "story_v_out_322242.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_14 = math.max(var_147_5, arg_144_1.talkMaxDuration)

			if var_147_4 <= arg_144_1.time_ and arg_144_1.time_ < var_147_4 + var_147_14 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_4) / var_147_14

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_4 + var_147_14 and arg_144_1.time_ < var_147_4 + var_147_14 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play322242036 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 322242036
		arg_148_1.duration_ = 5

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play322242037(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = arg_148_1.actors_["1020ui_story"]
			local var_151_1 = 0

			if var_151_1 < arg_148_1.time_ and arg_148_1.time_ <= var_151_1 + arg_151_0 and not isNil(var_151_0) and arg_148_1.var_.characterEffect1020ui_story == nil then
				arg_148_1.var_.characterEffect1020ui_story = var_151_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_2 = 0.200000002980232

			if var_151_1 <= arg_148_1.time_ and arg_148_1.time_ < var_151_1 + var_151_2 and not isNil(var_151_0) then
				local var_151_3 = (arg_148_1.time_ - var_151_1) / var_151_2

				if arg_148_1.var_.characterEffect1020ui_story and not isNil(var_151_0) then
					local var_151_4 = Mathf.Lerp(0, 0.5, var_151_3)

					arg_148_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_148_1.var_.characterEffect1020ui_story.fillRatio = var_151_4
				end
			end

			if arg_148_1.time_ >= var_151_1 + var_151_2 and arg_148_1.time_ < var_151_1 + var_151_2 + arg_151_0 and not isNil(var_151_0) and arg_148_1.var_.characterEffect1020ui_story then
				local var_151_5 = 0.5

				arg_148_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_148_1.var_.characterEffect1020ui_story.fillRatio = var_151_5
			end

			local var_151_6 = 0
			local var_151_7 = 1.3

			if var_151_6 < arg_148_1.time_ and arg_148_1.time_ <= var_151_6 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				local var_151_8 = arg_148_1:FormatText(StoryNameCfg[7].name)

				arg_148_1.leftNameTxt_.text = var_151_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, true)
				arg_148_1.iconController_:SetSelectedState("hero")

				arg_148_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_148_1.callingController_:SetSelectedState("normal")

				arg_148_1.keyicon_.color = Color.New(1, 1, 1)
				arg_148_1.icon_.color = Color.New(1, 1, 1)

				local var_151_9 = arg_148_1:GetWordFromCfg(322242036)
				local var_151_10 = arg_148_1:FormatText(var_151_9.content)

				arg_148_1.text_.text = var_151_10

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_11 = 52
				local var_151_12 = utf8.len(var_151_10)
				local var_151_13 = var_151_11 <= 0 and var_151_7 or var_151_7 * (var_151_12 / var_151_11)

				if var_151_13 > 0 and var_151_7 < var_151_13 then
					arg_148_1.talkMaxDuration = var_151_13

					if var_151_13 + var_151_6 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_13 + var_151_6
					end
				end

				arg_148_1.text_.text = var_151_10
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)
				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_14 = math.max(var_151_7, arg_148_1.talkMaxDuration)

			if var_151_6 <= arg_148_1.time_ and arg_148_1.time_ < var_151_6 + var_151_14 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_6) / var_151_14

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_6 + var_151_14 and arg_148_1.time_ < var_151_6 + var_151_14 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {}

		arg_148_1:InitPlayNodeList()
	end,
	Play322242037 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 322242037
		arg_152_1.duration_ = 5

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play322242038(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = 0
			local var_155_1 = 0.85

			if var_155_0 < arg_152_1.time_ and arg_152_1.time_ <= var_155_0 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				local var_155_2 = arg_152_1:FormatText(StoryNameCfg[7].name)

				arg_152_1.leftNameTxt_.text = var_155_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, true)
				arg_152_1.iconController_:SetSelectedState("hero")

				arg_152_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_152_1.callingController_:SetSelectedState("normal")

				arg_152_1.keyicon_.color = Color.New(1, 1, 1)
				arg_152_1.icon_.color = Color.New(1, 1, 1)

				local var_155_3 = arg_152_1:GetWordFromCfg(322242037)
				local var_155_4 = arg_152_1:FormatText(var_155_3.content)

				arg_152_1.text_.text = var_155_4

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_5 = 34
				local var_155_6 = utf8.len(var_155_4)
				local var_155_7 = var_155_5 <= 0 and var_155_1 or var_155_1 * (var_155_6 / var_155_5)

				if var_155_7 > 0 and var_155_1 < var_155_7 then
					arg_152_1.talkMaxDuration = var_155_7

					if var_155_7 + var_155_0 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_7 + var_155_0
					end
				end

				arg_152_1.text_.text = var_155_4
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)
				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_8 = math.max(var_155_1, arg_152_1.talkMaxDuration)

			if var_155_0 <= arg_152_1.time_ and arg_152_1.time_ < var_155_0 + var_155_8 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_0) / var_155_8

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_0 + var_155_8 and arg_152_1.time_ < var_155_0 + var_155_8 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	Play322242038 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 322242038
		arg_156_1.duration_ = 5.73

		local var_156_0 = {
			zh = 4.466,
			ja = 5.733
		}
		local var_156_1 = manager.audio:GetLocalizationFlag()

		if var_156_0[var_156_1] ~= nil then
			arg_156_1.duration_ = var_156_0[var_156_1]
		end

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play322242039(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = arg_156_1.actors_["1020ui_story"]
			local var_159_1 = 0

			if var_159_1 < arg_156_1.time_ and arg_156_1.time_ <= var_159_1 + arg_159_0 and not isNil(var_159_0) and arg_156_1.var_.characterEffect1020ui_story == nil then
				arg_156_1.var_.characterEffect1020ui_story = var_159_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_2 = 0.200000002980232

			if var_159_1 <= arg_156_1.time_ and arg_156_1.time_ < var_159_1 + var_159_2 and not isNil(var_159_0) then
				local var_159_3 = (arg_156_1.time_ - var_159_1) / var_159_2

				if arg_156_1.var_.characterEffect1020ui_story and not isNil(var_159_0) then
					arg_156_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_156_1.time_ >= var_159_1 + var_159_2 and arg_156_1.time_ < var_159_1 + var_159_2 + arg_159_0 and not isNil(var_159_0) and arg_156_1.var_.characterEffect1020ui_story then
				arg_156_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_159_4 = 0
			local var_159_5 = 0.475

			if var_159_4 < arg_156_1.time_ and arg_156_1.time_ <= var_159_4 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				local var_159_6 = arg_156_1:FormatText(StoryNameCfg[613].name)

				arg_156_1.leftNameTxt_.text = var_159_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_7 = arg_156_1:GetWordFromCfg(322242038)
				local var_159_8 = arg_156_1:FormatText(var_159_7.content)

				arg_156_1.text_.text = var_159_8

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_9 = 19
				local var_159_10 = utf8.len(var_159_8)
				local var_159_11 = var_159_9 <= 0 and var_159_5 or var_159_5 * (var_159_10 / var_159_9)

				if var_159_11 > 0 and var_159_5 < var_159_11 then
					arg_156_1.talkMaxDuration = var_159_11

					if var_159_11 + var_159_4 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_11 + var_159_4
					end
				end

				arg_156_1.text_.text = var_159_8
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322242", "322242038", "story_v_out_322242.awb") ~= 0 then
					local var_159_12 = manager.audio:GetVoiceLength("story_v_out_322242", "322242038", "story_v_out_322242.awb") / 1000

					if var_159_12 + var_159_4 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_12 + var_159_4
					end

					if var_159_7.prefab_name ~= "" and arg_156_1.actors_[var_159_7.prefab_name] ~= nil then
						local var_159_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_7.prefab_name].transform, "story_v_out_322242", "322242038", "story_v_out_322242.awb")

						arg_156_1:RecordAudio("322242038", var_159_13)
						arg_156_1:RecordAudio("322242038", var_159_13)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_322242", "322242038", "story_v_out_322242.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_322242", "322242038", "story_v_out_322242.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_14 = math.max(var_159_5, arg_156_1.talkMaxDuration)

			if var_159_4 <= arg_156_1.time_ and arg_156_1.time_ < var_159_4 + var_159_14 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_4) / var_159_14

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_4 + var_159_14 and arg_156_1.time_ < var_159_4 + var_159_14 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play322242039 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 322242039
		arg_160_1.duration_ = 5

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play322242040(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = arg_160_1.actors_["1020ui_story"]
			local var_163_1 = 0

			if var_163_1 < arg_160_1.time_ and arg_160_1.time_ <= var_163_1 + arg_163_0 and not isNil(var_163_0) and arg_160_1.var_.characterEffect1020ui_story == nil then
				arg_160_1.var_.characterEffect1020ui_story = var_163_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_2 = 0.200000002980232

			if var_163_1 <= arg_160_1.time_ and arg_160_1.time_ < var_163_1 + var_163_2 and not isNil(var_163_0) then
				local var_163_3 = (arg_160_1.time_ - var_163_1) / var_163_2

				if arg_160_1.var_.characterEffect1020ui_story and not isNil(var_163_0) then
					local var_163_4 = Mathf.Lerp(0, 0.5, var_163_3)

					arg_160_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_160_1.var_.characterEffect1020ui_story.fillRatio = var_163_4
				end
			end

			if arg_160_1.time_ >= var_163_1 + var_163_2 and arg_160_1.time_ < var_163_1 + var_163_2 + arg_163_0 and not isNil(var_163_0) and arg_160_1.var_.characterEffect1020ui_story then
				local var_163_5 = 0.5

				arg_160_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_160_1.var_.characterEffect1020ui_story.fillRatio = var_163_5
			end

			local var_163_6 = 0
			local var_163_7 = 0.75

			if var_163_6 < arg_160_1.time_ and arg_160_1.time_ <= var_163_6 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				local var_163_8 = arg_160_1:FormatText(StoryNameCfg[7].name)

				arg_160_1.leftNameTxt_.text = var_163_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, true)
				arg_160_1.iconController_:SetSelectedState("hero")

				arg_160_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_160_1.callingController_:SetSelectedState("normal")

				arg_160_1.keyicon_.color = Color.New(1, 1, 1)
				arg_160_1.icon_.color = Color.New(1, 1, 1)

				local var_163_9 = arg_160_1:GetWordFromCfg(322242039)
				local var_163_10 = arg_160_1:FormatText(var_163_9.content)

				arg_160_1.text_.text = var_163_10

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_11 = 30
				local var_163_12 = utf8.len(var_163_10)
				local var_163_13 = var_163_11 <= 0 and var_163_7 or var_163_7 * (var_163_12 / var_163_11)

				if var_163_13 > 0 and var_163_7 < var_163_13 then
					arg_160_1.talkMaxDuration = var_163_13

					if var_163_13 + var_163_6 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_13 + var_163_6
					end
				end

				arg_160_1.text_.text = var_163_10
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)
				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_14 = math.max(var_163_7, arg_160_1.talkMaxDuration)

			if var_163_6 <= arg_160_1.time_ and arg_160_1.time_ < var_163_6 + var_163_14 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_6) / var_163_14

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_6 + var_163_14 and arg_160_1.time_ < var_163_6 + var_163_14 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play322242040 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 322242040
		arg_164_1.duration_ = 5

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play322242041(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = arg_164_1.actors_["1020ui_story"].transform
			local var_167_1 = 0

			if var_167_1 < arg_164_1.time_ and arg_164_1.time_ <= var_167_1 + arg_167_0 then
				arg_164_1.var_.moveOldPos1020ui_story = var_167_0.localPosition
			end

			local var_167_2 = 0.001

			if var_167_1 <= arg_164_1.time_ and arg_164_1.time_ < var_167_1 + var_167_2 then
				local var_167_3 = (arg_164_1.time_ - var_167_1) / var_167_2
				local var_167_4 = Vector3.New(0, 100, 0)

				var_167_0.localPosition = Vector3.Lerp(arg_164_1.var_.moveOldPos1020ui_story, var_167_4, var_167_3)

				local var_167_5 = manager.ui.mainCamera.transform.position - var_167_0.position

				var_167_0.forward = Vector3.New(var_167_5.x, var_167_5.y, var_167_5.z)

				local var_167_6 = var_167_0.localEulerAngles

				var_167_6.z = 0
				var_167_6.x = 0
				var_167_0.localEulerAngles = var_167_6
			end

			if arg_164_1.time_ >= var_167_1 + var_167_2 and arg_164_1.time_ < var_167_1 + var_167_2 + arg_167_0 then
				var_167_0.localPosition = Vector3.New(0, 100, 0)

				local var_167_7 = manager.ui.mainCamera.transform.position - var_167_0.position

				var_167_0.forward = Vector3.New(var_167_7.x, var_167_7.y, var_167_7.z)

				local var_167_8 = var_167_0.localEulerAngles

				var_167_8.z = 0
				var_167_8.x = 0
				var_167_0.localEulerAngles = var_167_8
			end

			local var_167_9 = 0
			local var_167_10 = 0.625

			if var_167_9 < arg_164_1.time_ and arg_164_1.time_ <= var_167_9 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, false)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_11 = arg_164_1:GetWordFromCfg(322242040)
				local var_167_12 = arg_164_1:FormatText(var_167_11.content)

				arg_164_1.text_.text = var_167_12

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_13 = 25
				local var_167_14 = utf8.len(var_167_12)
				local var_167_15 = var_167_13 <= 0 and var_167_10 or var_167_10 * (var_167_14 / var_167_13)

				if var_167_15 > 0 and var_167_10 < var_167_15 then
					arg_164_1.talkMaxDuration = var_167_15

					if var_167_15 + var_167_9 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_15 + var_167_9
					end
				end

				arg_164_1.text_.text = var_167_12
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)
				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_16 = math.max(var_167_10, arg_164_1.talkMaxDuration)

			if var_167_9 <= arg_164_1.time_ and arg_164_1.time_ < var_167_9 + var_167_16 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_9) / var_167_16

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_9 + var_167_16 and arg_164_1.time_ < var_167_9 + var_167_16 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {
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

		arg_164_1:InitPlayNodeList()
	end,
	Play322242041 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 322242041
		arg_168_1.duration_ = 5

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play322242042(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			local var_171_0 = 0
			local var_171_1 = 1.325

			if var_171_0 < arg_168_1.time_ and arg_168_1.time_ <= var_171_0 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, false)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_2 = arg_168_1:GetWordFromCfg(322242041)
				local var_171_3 = arg_168_1:FormatText(var_171_2.content)

				arg_168_1.text_.text = var_171_3

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_4 = 53
				local var_171_5 = utf8.len(var_171_3)
				local var_171_6 = var_171_4 <= 0 and var_171_1 or var_171_1 * (var_171_5 / var_171_4)

				if var_171_6 > 0 and var_171_1 < var_171_6 then
					arg_168_1.talkMaxDuration = var_171_6

					if var_171_6 + var_171_0 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_6 + var_171_0
					end
				end

				arg_168_1.text_.text = var_171_3
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)
				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_7 = math.max(var_171_1, arg_168_1.talkMaxDuration)

			if var_171_0 <= arg_168_1.time_ and arg_168_1.time_ < var_171_0 + var_171_7 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_0) / var_171_7

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_0 + var_171_7 and arg_168_1.time_ < var_171_0 + var_171_7 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {}

		arg_168_1:InitPlayNodeList()
	end,
	Play322242042 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 322242042
		arg_172_1.duration_ = 4.7

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play322242043(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = "STblack"

			if arg_172_1.bgs_[var_175_0] == nil then
				local var_175_1 = Object.Instantiate(arg_172_1.paintGo_)

				var_175_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_175_0)
				var_175_1.name = var_175_0
				var_175_1.transform.parent = arg_172_1.stage_.transform
				var_175_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_172_1.bgs_[var_175_0] = var_175_1
			end

			local var_175_2 = 1

			if var_175_2 < arg_172_1.time_ and arg_172_1.time_ <= var_175_2 + arg_175_0 then
				local var_175_3 = manager.ui.mainCamera.transform.localPosition
				local var_175_4 = Vector3.New(0, 0, 10) + Vector3.New(var_175_3.x, var_175_3.y, 0)
				local var_175_5 = arg_172_1.bgs_.STblack

				var_175_5.transform.localPosition = var_175_4
				var_175_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_175_6 = var_175_5:GetComponent("SpriteRenderer")

				if var_175_6 and var_175_6.sprite then
					local var_175_7 = (var_175_5.transform.localPosition - var_175_3).z
					local var_175_8 = manager.ui.mainCameraCom_
					local var_175_9 = 2 * var_175_7 * Mathf.Tan(var_175_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_175_10 = var_175_9 * var_175_8.aspect
					local var_175_11 = var_175_6.sprite.bounds.size.x
					local var_175_12 = var_175_6.sprite.bounds.size.y
					local var_175_13 = var_175_10 / var_175_11
					local var_175_14 = var_175_9 / var_175_12
					local var_175_15 = var_175_14 < var_175_13 and var_175_13 or var_175_14

					var_175_5.transform.localScale = Vector3.New(var_175_15, var_175_15, 0)
				end

				for iter_175_0, iter_175_1 in pairs(arg_172_1.bgs_) do
					if iter_175_0 ~= "STblack" then
						iter_175_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_175_16 = 0

			if var_175_16 < arg_172_1.time_ and arg_172_1.time_ <= var_175_16 + arg_175_0 then
				arg_172_1.mask_.enabled = true
				arg_172_1.mask_.raycastTarget = true

				arg_172_1:SetGaussion(false)
			end

			local var_175_17 = 1

			if var_175_16 <= arg_172_1.time_ and arg_172_1.time_ < var_175_16 + var_175_17 then
				local var_175_18 = (arg_172_1.time_ - var_175_16) / var_175_17
				local var_175_19 = Color.New(0, 0, 0)

				var_175_19.a = Mathf.Lerp(0, 1, var_175_18)
				arg_172_1.mask_.color = var_175_19
			end

			if arg_172_1.time_ >= var_175_16 + var_175_17 and arg_172_1.time_ < var_175_16 + var_175_17 + arg_175_0 then
				local var_175_20 = Color.New(0, 0, 0)

				var_175_20.a = 1
				arg_172_1.mask_.color = var_175_20
			end

			local var_175_21 = 1

			if var_175_21 < arg_172_1.time_ and arg_172_1.time_ <= var_175_21 + arg_175_0 then
				arg_172_1.mask_.enabled = true
				arg_172_1.mask_.raycastTarget = true

				arg_172_1:SetGaussion(false)
			end

			local var_175_22 = 2

			if var_175_21 <= arg_172_1.time_ and arg_172_1.time_ < var_175_21 + var_175_22 then
				local var_175_23 = (arg_172_1.time_ - var_175_21) / var_175_22
				local var_175_24 = Color.New(0, 0, 0)

				var_175_24.a = Mathf.Lerp(1, 0, var_175_23)
				arg_172_1.mask_.color = var_175_24
			end

			if arg_172_1.time_ >= var_175_21 + var_175_22 and arg_172_1.time_ < var_175_21 + var_175_22 + arg_175_0 then
				local var_175_25 = Color.New(0, 0, 0)
				local var_175_26 = 0

				arg_172_1.mask_.enabled = false
				var_175_25.a = var_175_26
				arg_172_1.mask_.color = var_175_25
			end
		end

		arg_172_1.nodeConfigList_ = {
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = false,
				contentID = 419165,
				charCount = 1,
				enableLayoutChange = true,
				duration = 2,
				groupID = "2042",
				startTime = 1,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.MiddleCenter
				},
				textComProperty = {
					fontSize = 110,
					fontAssetPath = "Fonts/SourceHanSerifCN-Bold-3.0",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.MiddleCenter
				}
			},
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 322242042,
				charCount = 27,
				enableLayoutChange = true,
				duration = 1.8,
				groupID = "2043",
				startTime = 2.3,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.LowerCenter
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.LowerCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_172_1:InitPlayNodeList()
	end,
	Play322242043 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 322242043
		arg_176_1.duration_ = 5.43

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play322242044(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			local var_179_0 = 0
			local var_179_1 = 5.433
			local var_179_2 = manager.audio:GetVoiceLength("story_v_out_322242", "322242043", "story_v_out_322242.awb") / 1000

			if var_179_2 > 0 and var_179_1 < var_179_2 and var_179_2 + var_179_0 > arg_176_1.duration_ then
				local var_179_3 = var_179_2

				arg_176_1.duration_ = var_179_2 + var_179_0
			end

			if var_179_0 < arg_176_1.time_ and arg_176_1.time_ <= var_179_0 + arg_179_0 then
				local var_179_4 = "play"
				local var_179_5 = "voice"

				arg_176_1:AudioAction(var_179_4, var_179_5, "story_v_out_322242", "322242043", "story_v_out_322242.awb")
			end
		end

		arg_176_1.nodeConfigList_ = {
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 322242043,
				charCount = 32,
				enableLayoutChange = true,
				duration = 2.13333333333333,
				groupID = "20431",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.LowerCenter
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.LowerCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			},
			{
				groupID = "2043",
				duration = 0.0166666666666667,
				className = "StoryTextGroupNode",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			}
		}

		arg_176_1:InitPlayNodeList()
	end,
	Play322242044 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 322242044
		arg_180_1.duration_ = 7.67

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play322242045(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			local var_183_0 = 0
			local var_183_1 = 7.666
			local var_183_2 = manager.audio:GetVoiceLength("story_v_out_322242", "322242044", "story_v_out_322242.awb") / 1000

			if var_183_2 > 0 and var_183_1 < var_183_2 and var_183_2 + var_183_0 > arg_180_1.duration_ then
				local var_183_3 = var_183_2

				arg_180_1.duration_ = var_183_2 + var_183_0
			end

			if var_183_0 < arg_180_1.time_ and arg_180_1.time_ <= var_183_0 + arg_183_0 then
				local var_183_4 = "play"
				local var_183_5 = "voice"

				arg_180_1:AudioAction(var_183_4, var_183_5, "story_v_out_322242", "322242044", "story_v_out_322242.awb")
			end
		end

		arg_180_1.nodeConfigList_ = {
			{
				groupID = "20431",
				duration = 0.0166666666666667,
				className = "StoryTextGroupNode",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			},
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 322242044,
				charCount = 32,
				enableLayoutChange = true,
				duration = 2.13333333333333,
				groupID = "2044",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.LowerCenter
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.LowerCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_180_1:InitPlayNodeList()
	end,
	Play322242045 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 322242045
		arg_184_1.duration_ = 2.2

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play322242046(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			return
		end

		arg_184_1.nodeConfigList_ = {
			{
				groupID = "2044",
				duration = 0.0166666666666667,
				className = "StoryTextGroupNode",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			},
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 322242045,
				charCount = 33,
				enableLayoutChange = true,
				duration = 2.2,
				groupID = "2045",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.LowerCenter
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.LowerCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_184_1:InitPlayNodeList()
	end,
	Play322242046 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 322242046
		arg_188_1.duration_ = 2.93

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play322242047(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			return
		end

		arg_188_1.nodeConfigList_ = {
			{
				groupID = "2045",
				duration = 0.0166666666666667,
				className = "StoryTextGroupNode",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			},
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 322242046,
				charCount = 44,
				enableLayoutChange = true,
				duration = 2.93333333333333,
				groupID = "2046",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.LowerCenter
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.LowerCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_188_1:InitPlayNodeList()
	end,
	Play322242047 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 322242047
		arg_192_1.duration_ = 4.3

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play322242048(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			local var_195_0 = 0
			local var_195_1 = 4.3
			local var_195_2 = manager.audio:GetVoiceLength("story_v_out_322242", "322242047", "story_v_out_322242.awb") / 1000

			if var_195_2 > 0 and var_195_1 < var_195_2 and var_195_2 + var_195_0 > arg_192_1.duration_ then
				local var_195_3 = var_195_2

				arg_192_1.duration_ = var_195_2 + var_195_0
			end

			if var_195_0 < arg_192_1.time_ and arg_192_1.time_ <= var_195_0 + arg_195_0 then
				local var_195_4 = "play"
				local var_195_5 = "voice"

				arg_192_1:AudioAction(var_195_4, var_195_5, "story_v_out_322242", "322242047", "story_v_out_322242.awb")
			end
		end

		arg_192_1.nodeConfigList_ = {
			{
				groupID = "2046",
				duration = 0.0166666666666667,
				className = "StoryTextGroupNode",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			},
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 322242047,
				charCount = 25,
				enableLayoutChange = true,
				duration = 1.66666666666667,
				groupID = "2047",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.LowerCenter
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.LowerCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_192_1:InitPlayNodeList()
	end,
	Play322242048 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 322242048
		arg_196_1.duration_ = 9.47

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play322242049(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			local var_199_0 = 0
			local var_199_1 = 9.466
			local var_199_2 = manager.audio:GetVoiceLength("story_v_out_322242", "322242048", "story_v_out_322242.awb") / 1000

			if var_199_2 > 0 and var_199_1 < var_199_2 and var_199_2 + var_199_0 > arg_196_1.duration_ then
				local var_199_3 = var_199_2

				arg_196_1.duration_ = var_199_2 + var_199_0
			end

			if var_199_0 < arg_196_1.time_ and arg_196_1.time_ <= var_199_0 + arg_199_0 then
				local var_199_4 = "play"
				local var_199_5 = "voice"

				arg_196_1:AudioAction(var_199_4, var_199_5, "story_v_out_322242", "322242048", "story_v_out_322242.awb")
			end
		end

		arg_196_1.nodeConfigList_ = {
			{
				groupID = "2047",
				duration = 0.0166666666666667,
				className = "StoryTextGroupNode",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			},
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 322242048,
				charCount = 48,
				enableLayoutChange = true,
				duration = 3.2,
				groupID = "2048",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.LowerCenter
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.LowerCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_196_1:InitPlayNodeList()
	end,
	Play322242049 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 322242049
		arg_200_1.duration_ = 6.7

		local var_200_0 = {
			zh = 6.7,
			ja = 6.699999999999
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
				arg_200_0:Play322242050(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			local var_203_0 = 0
			local var_203_1 = 6.7
			local var_203_2 = manager.audio:GetVoiceLength("story_v_out_322242", "322242049", "story_v_out_322242.awb") / 1000

			if var_203_2 > 0 and var_203_1 < var_203_2 and var_203_2 + var_203_0 > arg_200_1.duration_ then
				local var_203_3 = var_203_2

				arg_200_1.duration_ = var_203_2 + var_203_0
			end

			if var_203_0 < arg_200_1.time_ and arg_200_1.time_ <= var_203_0 + arg_203_0 then
				local var_203_4 = "play"
				local var_203_5 = "voice"

				arg_200_1:AudioAction(var_203_4, var_203_5, "story_v_out_322242", "322242049", "story_v_out_322242.awb")
			end

			local var_203_6 = 0
			local var_203_7 = 0.6

			if var_203_6 < arg_200_1.time_ and arg_200_1.time_ <= var_203_6 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, true)

				local var_203_8 = arg_200_1:FormatText(StoryNameCfg[613].name)

				arg_200_1.leftNameTxt_.text = var_203_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_200_1.leftNameTxt_.transform)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1.leftNameTxt_.text)
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_9 = arg_200_1:GetWordFromCfg(322242049)
				local var_203_10 = arg_200_1:FormatText(var_203_9.content)

				arg_200_1.text_.text = var_203_10

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_11 = 27
				local var_203_12 = utf8.len(var_203_10)
				local var_203_13 = var_203_11 <= 0 and var_203_7 or var_203_7 * (var_203_12 / var_203_11)

				if var_203_13 > 0 and var_203_7 < var_203_13 then
					arg_200_1.talkMaxDuration = var_203_13

					if var_203_13 + var_203_6 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_13 + var_203_6
					end
				end

				arg_200_1.text_.text = var_203_10
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322242", "322242049", "story_v_out_322242.awb") ~= 0 then
					local var_203_14 = manager.audio:GetVoiceLength("story_v_out_322242", "322242049", "story_v_out_322242.awb") / 1000

					if var_203_14 + var_203_6 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_14 + var_203_6
					end

					if var_203_9.prefab_name ~= "" and arg_200_1.actors_[var_203_9.prefab_name] ~= nil then
						local var_203_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_200_1.actors_[var_203_9.prefab_name].transform, "story_v_out_322242", "322242049", "story_v_out_322242.awb")

						arg_200_1:RecordAudio("322242049", var_203_15)
						arg_200_1:RecordAudio("322242049", var_203_15)
					else
						arg_200_1:AudioAction("play", "voice", "story_v_out_322242", "322242049", "story_v_out_322242.awb")
					end

					arg_200_1:RecordHistoryTalkVoice("story_v_out_322242", "322242049", "story_v_out_322242.awb")
				end

				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_16 = math.max(var_203_7, arg_200_1.talkMaxDuration)

			if var_203_6 <= arg_200_1.time_ and arg_200_1.time_ < var_203_6 + var_203_16 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_6) / var_203_16

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_6 + var_203_16 and arg_200_1.time_ < var_203_6 + var_203_16 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {
			{
				groupID = "2048",
				duration = 0.0166666666666667,
				className = "StoryTextGroupNode",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			},
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 322242049,
				charCount = 27,
				enableLayoutChange = true,
				duration = 1.8,
				groupID = "2049",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.LowerCenter
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.LowerCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_200_1:InitPlayNodeList()
	end,
	Play322242050 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 322242050
		arg_204_1.duration_ = 7

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play322242051(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			local var_207_0 = 1

			if var_207_0 < arg_204_1.time_ and arg_204_1.time_ <= var_207_0 + arg_207_0 then
				local var_207_1 = manager.ui.mainCamera.transform.localPosition
				local var_207_2 = Vector3.New(0, 0, 10) + Vector3.New(var_207_1.x, var_207_1.y, 0)
				local var_207_3 = arg_204_1.bgs_.ST04b

				var_207_3.transform.localPosition = var_207_2
				var_207_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_207_4 = var_207_3:GetComponent("SpriteRenderer")

				if var_207_4 and var_207_4.sprite then
					local var_207_5 = (var_207_3.transform.localPosition - var_207_1).z
					local var_207_6 = manager.ui.mainCameraCom_
					local var_207_7 = 2 * var_207_5 * Mathf.Tan(var_207_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_207_8 = var_207_7 * var_207_6.aspect
					local var_207_9 = var_207_4.sprite.bounds.size.x
					local var_207_10 = var_207_4.sprite.bounds.size.y
					local var_207_11 = var_207_8 / var_207_9
					local var_207_12 = var_207_7 / var_207_10
					local var_207_13 = var_207_12 < var_207_11 and var_207_11 or var_207_12

					var_207_3.transform.localScale = Vector3.New(var_207_13, var_207_13, 0)
				end

				for iter_207_0, iter_207_1 in pairs(arg_204_1.bgs_) do
					if iter_207_0 ~= "ST04b" then
						iter_207_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_207_14 = 0

			if var_207_14 < arg_204_1.time_ and arg_204_1.time_ <= var_207_14 + arg_207_0 then
				arg_204_1.mask_.enabled = true
				arg_204_1.mask_.raycastTarget = true

				arg_204_1:SetGaussion(false)
			end

			local var_207_15 = 1

			if var_207_14 <= arg_204_1.time_ and arg_204_1.time_ < var_207_14 + var_207_15 then
				local var_207_16 = (arg_204_1.time_ - var_207_14) / var_207_15
				local var_207_17 = Color.New(0, 0, 0)

				var_207_17.a = Mathf.Lerp(0, 1, var_207_16)
				arg_204_1.mask_.color = var_207_17
			end

			if arg_204_1.time_ >= var_207_14 + var_207_15 and arg_204_1.time_ < var_207_14 + var_207_15 + arg_207_0 then
				local var_207_18 = Color.New(0, 0, 0)

				var_207_18.a = 1
				arg_204_1.mask_.color = var_207_18
			end

			local var_207_19 = 1

			if var_207_19 < arg_204_1.time_ and arg_204_1.time_ <= var_207_19 + arg_207_0 then
				arg_204_1.mask_.enabled = true
				arg_204_1.mask_.raycastTarget = true

				arg_204_1:SetGaussion(false)
			end

			local var_207_20 = 1

			if var_207_19 <= arg_204_1.time_ and arg_204_1.time_ < var_207_19 + var_207_20 then
				local var_207_21 = (arg_204_1.time_ - var_207_19) / var_207_20
				local var_207_22 = Color.New(0, 0, 0)

				var_207_22.a = Mathf.Lerp(1, 0, var_207_21)
				arg_204_1.mask_.color = var_207_22
			end

			if arg_204_1.time_ >= var_207_19 + var_207_20 and arg_204_1.time_ < var_207_19 + var_207_20 + arg_207_0 then
				local var_207_23 = Color.New(0, 0, 0)
				local var_207_24 = 0

				arg_204_1.mask_.enabled = false
				var_207_23.a = var_207_24
				arg_204_1.mask_.color = var_207_23
			end

			if arg_204_1.frameCnt_ <= 1 then
				arg_204_1.dialog_:SetActive(false)
			end

			local var_207_25 = 2
			local var_207_26 = 1.475

			if var_207_25 < arg_204_1.time_ and arg_204_1.time_ <= var_207_25 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0

				arg_204_1.dialog_:SetActive(true)

				arg_204_1.dialogCg_.alpha = 0

				local var_207_27 = LeanTween.value(arg_204_1.dialog_, 0, 1, 0.3)

				var_207_27:setOnUpdate(LuaHelper.FloatAction(function(arg_208_0)
					arg_204_1.dialogCg_.alpha = arg_208_0
				end))
				var_207_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_204_1.dialog_)
					var_207_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_204_1.duration_ = arg_204_1.duration_ + 0.3

				SetActive(arg_204_1.leftNameGo_, false)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_204_1.iconTrs_.gameObject, false)
				arg_204_1.callingController_:SetSelectedState("normal")

				local var_207_28 = arg_204_1:GetWordFromCfg(322242050)
				local var_207_29 = arg_204_1:FormatText(var_207_28.content)

				arg_204_1.text_.text = var_207_29

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_30 = 59
				local var_207_31 = utf8.len(var_207_29)
				local var_207_32 = var_207_30 <= 0 and var_207_26 or var_207_26 * (var_207_31 / var_207_30)

				if var_207_32 > 0 and var_207_26 < var_207_32 then
					arg_204_1.talkMaxDuration = var_207_32
					var_207_25 = var_207_25 + 0.3

					if var_207_32 + var_207_25 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_32 + var_207_25
					end
				end

				arg_204_1.text_.text = var_207_29
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)
				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_33 = var_207_25 + 0.3
			local var_207_34 = math.max(var_207_26, arg_204_1.talkMaxDuration)

			if var_207_33 <= arg_204_1.time_ and arg_204_1.time_ < var_207_33 + var_207_34 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_33) / var_207_34

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_33 + var_207_34 and arg_204_1.time_ < var_207_33 + var_207_34 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {
			{
				groupID = "2049",
				duration = 0.0166666666666667,
				className = "StoryTextGroupNode",
				startTime = 1,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			},
			{
				groupID = "2042",
				duration = 0.0166666666666667,
				className = "StoryTextGroupNode",
				startTime = 1,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			}
		}

		arg_204_1:InitPlayNodeList()
	end,
	Play322242051 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 322242051
		arg_210_1.duration_ = 5

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play322242052(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			local var_213_0 = 0
			local var_213_1 = 1

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

				local var_213_2 = arg_210_1:GetWordFromCfg(322242051)
				local var_213_3 = arg_210_1:FormatText(var_213_2.content)

				arg_210_1.text_.text = var_213_3

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_4 = 40
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
	Play322242052 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 322242052
		arg_214_1.duration_ = 4.6

		local var_214_0 = {
			zh = 3.4,
			ja = 4.6
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
				arg_214_0:Play322242053(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			local var_217_0 = arg_214_1.actors_["1020ui_story"].transform
			local var_217_1 = 0

			if var_217_1 < arg_214_1.time_ and arg_214_1.time_ <= var_217_1 + arg_217_0 then
				arg_214_1.var_.moveOldPos1020ui_story = var_217_0.localPosition
			end

			local var_217_2 = 0.001

			if var_217_1 <= arg_214_1.time_ and arg_214_1.time_ < var_217_1 + var_217_2 then
				local var_217_3 = (arg_214_1.time_ - var_217_1) / var_217_2
				local var_217_4 = Vector3.New(0, -0.85, -6.25)

				var_217_0.localPosition = Vector3.Lerp(arg_214_1.var_.moveOldPos1020ui_story, var_217_4, var_217_3)

				local var_217_5 = manager.ui.mainCamera.transform.position - var_217_0.position

				var_217_0.forward = Vector3.New(var_217_5.x, var_217_5.y, var_217_5.z)

				local var_217_6 = var_217_0.localEulerAngles

				var_217_6.z = 0
				var_217_6.x = 0
				var_217_0.localEulerAngles = var_217_6
			end

			if arg_214_1.time_ >= var_217_1 + var_217_2 and arg_214_1.time_ < var_217_1 + var_217_2 + arg_217_0 then
				var_217_0.localPosition = Vector3.New(0, -0.85, -6.25)

				local var_217_7 = manager.ui.mainCamera.transform.position - var_217_0.position

				var_217_0.forward = Vector3.New(var_217_7.x, var_217_7.y, var_217_7.z)

				local var_217_8 = var_217_0.localEulerAngles

				var_217_8.z = 0
				var_217_8.x = 0
				var_217_0.localEulerAngles = var_217_8
			end

			local var_217_9 = arg_214_1.actors_["1020ui_story"]
			local var_217_10 = 0

			if var_217_10 < arg_214_1.time_ and arg_214_1.time_ <= var_217_10 + arg_217_0 and not isNil(var_217_9) and arg_214_1.var_.characterEffect1020ui_story == nil then
				arg_214_1.var_.characterEffect1020ui_story = var_217_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_217_11 = 0.200000002980232

			if var_217_10 <= arg_214_1.time_ and arg_214_1.time_ < var_217_10 + var_217_11 and not isNil(var_217_9) then
				local var_217_12 = (arg_214_1.time_ - var_217_10) / var_217_11

				if arg_214_1.var_.characterEffect1020ui_story and not isNil(var_217_9) then
					arg_214_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_214_1.time_ >= var_217_10 + var_217_11 and arg_214_1.time_ < var_217_10 + var_217_11 + arg_217_0 and not isNil(var_217_9) and arg_214_1.var_.characterEffect1020ui_story then
				arg_214_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_217_13 = 0

			if var_217_13 < arg_214_1.time_ and arg_214_1.time_ <= var_217_13 + arg_217_0 then
				arg_214_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action1_1")
			end

			local var_217_14 = 0

			if var_217_14 < arg_214_1.time_ and arg_214_1.time_ <= var_217_14 + arg_217_0 then
				arg_214_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_217_15 = 0
			local var_217_16 = 0.325

			if var_217_15 < arg_214_1.time_ and arg_214_1.time_ <= var_217_15 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				local var_217_17 = arg_214_1:FormatText(StoryNameCfg[613].name)

				arg_214_1.leftNameTxt_.text = var_217_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, false)
				arg_214_1.callingController_:SetSelectedState("normal")

				local var_217_18 = arg_214_1:GetWordFromCfg(322242052)
				local var_217_19 = arg_214_1:FormatText(var_217_18.content)

				arg_214_1.text_.text = var_217_19

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_20 = 13
				local var_217_21 = utf8.len(var_217_19)
				local var_217_22 = var_217_20 <= 0 and var_217_16 or var_217_16 * (var_217_21 / var_217_20)

				if var_217_22 > 0 and var_217_16 < var_217_22 then
					arg_214_1.talkMaxDuration = var_217_22

					if var_217_22 + var_217_15 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_22 + var_217_15
					end
				end

				arg_214_1.text_.text = var_217_19
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322242", "322242052", "story_v_out_322242.awb") ~= 0 then
					local var_217_23 = manager.audio:GetVoiceLength("story_v_out_322242", "322242052", "story_v_out_322242.awb") / 1000

					if var_217_23 + var_217_15 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_23 + var_217_15
					end

					if var_217_18.prefab_name ~= "" and arg_214_1.actors_[var_217_18.prefab_name] ~= nil then
						local var_217_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_214_1.actors_[var_217_18.prefab_name].transform, "story_v_out_322242", "322242052", "story_v_out_322242.awb")

						arg_214_1:RecordAudio("322242052", var_217_24)
						arg_214_1:RecordAudio("322242052", var_217_24)
					else
						arg_214_1:AudioAction("play", "voice", "story_v_out_322242", "322242052", "story_v_out_322242.awb")
					end

					arg_214_1:RecordHistoryTalkVoice("story_v_out_322242", "322242052", "story_v_out_322242.awb")
				end

				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_25 = math.max(var_217_16, arg_214_1.talkMaxDuration)

			if var_217_15 <= arg_214_1.time_ and arg_214_1.time_ < var_217_15 + var_217_25 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_15) / var_217_25

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_15 + var_217_25 and arg_214_1.time_ < var_217_15 + var_217_25 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {
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

		arg_214_1:InitPlayNodeList()
	end,
	Play322242053 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 322242053
		arg_218_1.duration_ = 5

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play322242054(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			local var_221_0 = arg_218_1.actors_["1020ui_story"]
			local var_221_1 = 0

			if var_221_1 < arg_218_1.time_ and arg_218_1.time_ <= var_221_1 + arg_221_0 and not isNil(var_221_0) and arg_218_1.var_.characterEffect1020ui_story == nil then
				arg_218_1.var_.characterEffect1020ui_story = var_221_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_221_2 = 0.200000002980232

			if var_221_1 <= arg_218_1.time_ and arg_218_1.time_ < var_221_1 + var_221_2 and not isNil(var_221_0) then
				local var_221_3 = (arg_218_1.time_ - var_221_1) / var_221_2

				if arg_218_1.var_.characterEffect1020ui_story and not isNil(var_221_0) then
					local var_221_4 = Mathf.Lerp(0, 0.5, var_221_3)

					arg_218_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_218_1.var_.characterEffect1020ui_story.fillRatio = var_221_4
				end
			end

			if arg_218_1.time_ >= var_221_1 + var_221_2 and arg_218_1.time_ < var_221_1 + var_221_2 + arg_221_0 and not isNil(var_221_0) and arg_218_1.var_.characterEffect1020ui_story then
				local var_221_5 = 0.5

				arg_218_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_218_1.var_.characterEffect1020ui_story.fillRatio = var_221_5
			end

			local var_221_6 = 0
			local var_221_7 = 0.325

			if var_221_6 < arg_218_1.time_ and arg_218_1.time_ <= var_221_6 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				local var_221_8 = arg_218_1:FormatText(StoryNameCfg[7].name)

				arg_218_1.leftNameTxt_.text = var_221_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, true)
				arg_218_1.iconController_:SetSelectedState("hero")

				arg_218_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_218_1.callingController_:SetSelectedState("normal")

				arg_218_1.keyicon_.color = Color.New(1, 1, 1)
				arg_218_1.icon_.color = Color.New(1, 1, 1)

				local var_221_9 = arg_218_1:GetWordFromCfg(322242053)
				local var_221_10 = arg_218_1:FormatText(var_221_9.content)

				arg_218_1.text_.text = var_221_10

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_11 = 13
				local var_221_12 = utf8.len(var_221_10)
				local var_221_13 = var_221_11 <= 0 and var_221_7 or var_221_7 * (var_221_12 / var_221_11)

				if var_221_13 > 0 and var_221_7 < var_221_13 then
					arg_218_1.talkMaxDuration = var_221_13

					if var_221_13 + var_221_6 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_13 + var_221_6
					end
				end

				arg_218_1.text_.text = var_221_10
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)
				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_14 = math.max(var_221_7, arg_218_1.talkMaxDuration)

			if var_221_6 <= arg_218_1.time_ and arg_218_1.time_ < var_221_6 + var_221_14 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_6) / var_221_14

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_6 + var_221_14 and arg_218_1.time_ < var_221_6 + var_221_14 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {}

		arg_218_1:InitPlayNodeList()
	end,
	Play322242054 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 322242054
		arg_222_1.duration_ = 2

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play322242055(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			local var_225_0 = arg_222_1.actors_["1020ui_story"]
			local var_225_1 = 0

			if var_225_1 < arg_222_1.time_ and arg_222_1.time_ <= var_225_1 + arg_225_0 and not isNil(var_225_0) and arg_222_1.var_.characterEffect1020ui_story == nil then
				arg_222_1.var_.characterEffect1020ui_story = var_225_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_225_2 = 0.200000002980232

			if var_225_1 <= arg_222_1.time_ and arg_222_1.time_ < var_225_1 + var_225_2 and not isNil(var_225_0) then
				local var_225_3 = (arg_222_1.time_ - var_225_1) / var_225_2

				if arg_222_1.var_.characterEffect1020ui_story and not isNil(var_225_0) then
					arg_222_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_222_1.time_ >= var_225_1 + var_225_2 and arg_222_1.time_ < var_225_1 + var_225_2 + arg_225_0 and not isNil(var_225_0) and arg_222_1.var_.characterEffect1020ui_story then
				arg_222_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_225_4 = 0

			if var_225_4 < arg_222_1.time_ and arg_222_1.time_ <= var_225_4 + arg_225_0 then
				arg_222_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action2_1")
			end

			local var_225_5 = 0
			local var_225_6 = 0.175

			if var_225_5 < arg_222_1.time_ and arg_222_1.time_ <= var_225_5 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				local var_225_7 = arg_222_1:FormatText(StoryNameCfg[613].name)

				arg_222_1.leftNameTxt_.text = var_225_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_8 = arg_222_1:GetWordFromCfg(322242054)
				local var_225_9 = arg_222_1:FormatText(var_225_8.content)

				arg_222_1.text_.text = var_225_9

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_10 = 7
				local var_225_11 = utf8.len(var_225_9)
				local var_225_12 = var_225_10 <= 0 and var_225_6 or var_225_6 * (var_225_11 / var_225_10)

				if var_225_12 > 0 and var_225_6 < var_225_12 then
					arg_222_1.talkMaxDuration = var_225_12

					if var_225_12 + var_225_5 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_12 + var_225_5
					end
				end

				arg_222_1.text_.text = var_225_9
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322242", "322242054", "story_v_out_322242.awb") ~= 0 then
					local var_225_13 = manager.audio:GetVoiceLength("story_v_out_322242", "322242054", "story_v_out_322242.awb") / 1000

					if var_225_13 + var_225_5 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_13 + var_225_5
					end

					if var_225_8.prefab_name ~= "" and arg_222_1.actors_[var_225_8.prefab_name] ~= nil then
						local var_225_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_222_1.actors_[var_225_8.prefab_name].transform, "story_v_out_322242", "322242054", "story_v_out_322242.awb")

						arg_222_1:RecordAudio("322242054", var_225_14)
						arg_222_1:RecordAudio("322242054", var_225_14)
					else
						arg_222_1:AudioAction("play", "voice", "story_v_out_322242", "322242054", "story_v_out_322242.awb")
					end

					arg_222_1:RecordHistoryTalkVoice("story_v_out_322242", "322242054", "story_v_out_322242.awb")
				end

				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_15 = math.max(var_225_6, arg_222_1.talkMaxDuration)

			if var_225_5 <= arg_222_1.time_ and arg_222_1.time_ < var_225_5 + var_225_15 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_5) / var_225_15

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_5 + var_225_15 and arg_222_1.time_ < var_225_5 + var_225_15 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {}

		arg_222_1:InitPlayNodeList()
	end,
	Play322242055 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 322242055
		arg_226_1.duration_ = 5

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play322242056(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			local var_229_0 = arg_226_1.actors_["1020ui_story"]
			local var_229_1 = 0

			if var_229_1 < arg_226_1.time_ and arg_226_1.time_ <= var_229_1 + arg_229_0 and not isNil(var_229_0) and arg_226_1.var_.characterEffect1020ui_story == nil then
				arg_226_1.var_.characterEffect1020ui_story = var_229_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_229_2 = 0.200000002980232

			if var_229_1 <= arg_226_1.time_ and arg_226_1.time_ < var_229_1 + var_229_2 and not isNil(var_229_0) then
				local var_229_3 = (arg_226_1.time_ - var_229_1) / var_229_2

				if arg_226_1.var_.characterEffect1020ui_story and not isNil(var_229_0) then
					local var_229_4 = Mathf.Lerp(0, 0.5, var_229_3)

					arg_226_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_226_1.var_.characterEffect1020ui_story.fillRatio = var_229_4
				end
			end

			if arg_226_1.time_ >= var_229_1 + var_229_2 and arg_226_1.time_ < var_229_1 + var_229_2 + arg_229_0 and not isNil(var_229_0) and arg_226_1.var_.characterEffect1020ui_story then
				local var_229_5 = 0.5

				arg_226_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_226_1.var_.characterEffect1020ui_story.fillRatio = var_229_5
			end

			local var_229_6 = 0
			local var_229_7 = 0.75

			if var_229_6 < arg_226_1.time_ and arg_226_1.time_ <= var_229_6 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				local var_229_8 = arg_226_1:FormatText(StoryNameCfg[7].name)

				arg_226_1.leftNameTxt_.text = var_229_8

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

				local var_229_9 = arg_226_1:GetWordFromCfg(322242055)
				local var_229_10 = arg_226_1:FormatText(var_229_9.content)

				arg_226_1.text_.text = var_229_10

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_11 = 30
				local var_229_12 = utf8.len(var_229_10)
				local var_229_13 = var_229_11 <= 0 and var_229_7 or var_229_7 * (var_229_12 / var_229_11)

				if var_229_13 > 0 and var_229_7 < var_229_13 then
					arg_226_1.talkMaxDuration = var_229_13

					if var_229_13 + var_229_6 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_13 + var_229_6
					end
				end

				arg_226_1.text_.text = var_229_10
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)
				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_14 = math.max(var_229_7, arg_226_1.talkMaxDuration)

			if var_229_6 <= arg_226_1.time_ and arg_226_1.time_ < var_229_6 + var_229_14 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_6) / var_229_14

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_6 + var_229_14 and arg_226_1.time_ < var_229_6 + var_229_14 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {}

		arg_226_1:InitPlayNodeList()
	end,
	Play322242056 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 322242056
		arg_230_1.duration_ = 5

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play322242057(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			local var_233_0 = 0
			local var_233_1 = 0.85

			if var_233_0 < arg_230_1.time_ and arg_230_1.time_ <= var_233_0 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				local var_233_2 = arg_230_1:FormatText(StoryNameCfg[7].name)

				arg_230_1.leftNameTxt_.text = var_233_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, true)
				arg_230_1.iconController_:SetSelectedState("hero")

				arg_230_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_230_1.callingController_:SetSelectedState("normal")

				arg_230_1.keyicon_.color = Color.New(1, 1, 1)
				arg_230_1.icon_.color = Color.New(1, 1, 1)

				local var_233_3 = arg_230_1:GetWordFromCfg(322242056)
				local var_233_4 = arg_230_1:FormatText(var_233_3.content)

				arg_230_1.text_.text = var_233_4

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_5 = 34
				local var_233_6 = utf8.len(var_233_4)
				local var_233_7 = var_233_5 <= 0 and var_233_1 or var_233_1 * (var_233_6 / var_233_5)

				if var_233_7 > 0 and var_233_1 < var_233_7 then
					arg_230_1.talkMaxDuration = var_233_7

					if var_233_7 + var_233_0 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_7 + var_233_0
					end
				end

				arg_230_1.text_.text = var_233_4
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)
				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_8 = math.max(var_233_1, arg_230_1.talkMaxDuration)

			if var_233_0 <= arg_230_1.time_ and arg_230_1.time_ < var_233_0 + var_233_8 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_0) / var_233_8

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_0 + var_233_8 and arg_230_1.time_ < var_233_0 + var_233_8 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {}

		arg_230_1:InitPlayNodeList()
	end,
	Play322242057 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 322242057
		arg_234_1.duration_ = 9.37

		local var_234_0 = {
			zh = 8.1,
			ja = 9.366
		}
		local var_234_1 = manager.audio:GetLocalizationFlag()

		if var_234_0[var_234_1] ~= nil then
			arg_234_1.duration_ = var_234_0[var_234_1]
		end

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play322242058(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			local var_237_0 = arg_234_1.actors_["1020ui_story"]
			local var_237_1 = 0

			if var_237_1 < arg_234_1.time_ and arg_234_1.time_ <= var_237_1 + arg_237_0 and not isNil(var_237_0) and arg_234_1.var_.characterEffect1020ui_story == nil then
				arg_234_1.var_.characterEffect1020ui_story = var_237_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_237_2 = 0.200000002980232

			if var_237_1 <= arg_234_1.time_ and arg_234_1.time_ < var_237_1 + var_237_2 and not isNil(var_237_0) then
				local var_237_3 = (arg_234_1.time_ - var_237_1) / var_237_2

				if arg_234_1.var_.characterEffect1020ui_story and not isNil(var_237_0) then
					arg_234_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_234_1.time_ >= var_237_1 + var_237_2 and arg_234_1.time_ < var_237_1 + var_237_2 + arg_237_0 and not isNil(var_237_0) and arg_234_1.var_.characterEffect1020ui_story then
				arg_234_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_237_4 = 0
			local var_237_5 = 0.825

			if var_237_4 < arg_234_1.time_ and arg_234_1.time_ <= var_237_4 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, true)

				local var_237_6 = arg_234_1:FormatText(StoryNameCfg[613].name)

				arg_234_1.leftNameTxt_.text = var_237_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_7 = arg_234_1:GetWordFromCfg(322242057)
				local var_237_8 = arg_234_1:FormatText(var_237_7.content)

				arg_234_1.text_.text = var_237_8

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_9 = 33
				local var_237_10 = utf8.len(var_237_8)
				local var_237_11 = var_237_9 <= 0 and var_237_5 or var_237_5 * (var_237_10 / var_237_9)

				if var_237_11 > 0 and var_237_5 < var_237_11 then
					arg_234_1.talkMaxDuration = var_237_11

					if var_237_11 + var_237_4 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_11 + var_237_4
					end
				end

				arg_234_1.text_.text = var_237_8
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322242", "322242057", "story_v_out_322242.awb") ~= 0 then
					local var_237_12 = manager.audio:GetVoiceLength("story_v_out_322242", "322242057", "story_v_out_322242.awb") / 1000

					if var_237_12 + var_237_4 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_12 + var_237_4
					end

					if var_237_7.prefab_name ~= "" and arg_234_1.actors_[var_237_7.prefab_name] ~= nil then
						local var_237_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_234_1.actors_[var_237_7.prefab_name].transform, "story_v_out_322242", "322242057", "story_v_out_322242.awb")

						arg_234_1:RecordAudio("322242057", var_237_13)
						arg_234_1:RecordAudio("322242057", var_237_13)
					else
						arg_234_1:AudioAction("play", "voice", "story_v_out_322242", "322242057", "story_v_out_322242.awb")
					end

					arg_234_1:RecordHistoryTalkVoice("story_v_out_322242", "322242057", "story_v_out_322242.awb")
				end

				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_14 = math.max(var_237_5, arg_234_1.talkMaxDuration)

			if var_237_4 <= arg_234_1.time_ and arg_234_1.time_ < var_237_4 + var_237_14 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_4) / var_237_14

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_4 + var_237_14 and arg_234_1.time_ < var_237_4 + var_237_14 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {}

		arg_234_1:InitPlayNodeList()
	end,
	Play322242058 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 322242058
		arg_238_1.duration_ = 5

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play322242059(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			local var_241_0 = arg_238_1.actors_["1020ui_story"]
			local var_241_1 = 0

			if var_241_1 < arg_238_1.time_ and arg_238_1.time_ <= var_241_1 + arg_241_0 and not isNil(var_241_0) and arg_238_1.var_.characterEffect1020ui_story == nil then
				arg_238_1.var_.characterEffect1020ui_story = var_241_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_241_2 = 0.200000002980232

			if var_241_1 <= arg_238_1.time_ and arg_238_1.time_ < var_241_1 + var_241_2 and not isNil(var_241_0) then
				local var_241_3 = (arg_238_1.time_ - var_241_1) / var_241_2

				if arg_238_1.var_.characterEffect1020ui_story and not isNil(var_241_0) then
					local var_241_4 = Mathf.Lerp(0, 0.5, var_241_3)

					arg_238_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_238_1.var_.characterEffect1020ui_story.fillRatio = var_241_4
				end
			end

			if arg_238_1.time_ >= var_241_1 + var_241_2 and arg_238_1.time_ < var_241_1 + var_241_2 + arg_241_0 and not isNil(var_241_0) and arg_238_1.var_.characterEffect1020ui_story then
				local var_241_5 = 0.5

				arg_238_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_238_1.var_.characterEffect1020ui_story.fillRatio = var_241_5
			end

			local var_241_6 = 0
			local var_241_7 = 0.5

			if var_241_6 < arg_238_1.time_ and arg_238_1.time_ <= var_241_6 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, true)

				local var_241_8 = arg_238_1:FormatText(StoryNameCfg[7].name)

				arg_238_1.leftNameTxt_.text = var_241_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_238_1.leftNameTxt_.transform)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1.leftNameTxt_.text)
				SetActive(arg_238_1.iconTrs_.gameObject, true)
				arg_238_1.iconController_:SetSelectedState("hero")

				arg_238_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_238_1.callingController_:SetSelectedState("normal")

				arg_238_1.keyicon_.color = Color.New(1, 1, 1)
				arg_238_1.icon_.color = Color.New(1, 1, 1)

				local var_241_9 = arg_238_1:GetWordFromCfg(322242058)
				local var_241_10 = arg_238_1:FormatText(var_241_9.content)

				arg_238_1.text_.text = var_241_10

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_11 = 20
				local var_241_12 = utf8.len(var_241_10)
				local var_241_13 = var_241_11 <= 0 and var_241_7 or var_241_7 * (var_241_12 / var_241_11)

				if var_241_13 > 0 and var_241_7 < var_241_13 then
					arg_238_1.talkMaxDuration = var_241_13

					if var_241_13 + var_241_6 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_13 + var_241_6
					end
				end

				arg_238_1.text_.text = var_241_10
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)
				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_14 = math.max(var_241_7, arg_238_1.talkMaxDuration)

			if var_241_6 <= arg_238_1.time_ and arg_238_1.time_ < var_241_6 + var_241_14 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_6) / var_241_14

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_6 + var_241_14 and arg_238_1.time_ < var_241_6 + var_241_14 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {}

		arg_238_1:InitPlayNodeList()
	end,
	Play322242059 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 322242059
		arg_242_1.duration_ = 5

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play322242060(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			local var_245_0 = 0
			local var_245_1 = 0.125

			if var_245_0 < arg_242_1.time_ and arg_242_1.time_ <= var_245_0 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, true)

				local var_245_2 = arg_242_1:FormatText(StoryNameCfg[7].name)

				arg_242_1.leftNameTxt_.text = var_245_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_242_1.leftNameTxt_.transform)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1.leftNameTxt_.text)
				SetActive(arg_242_1.iconTrs_.gameObject, true)
				arg_242_1.iconController_:SetSelectedState("hero")

				arg_242_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_242_1.callingController_:SetSelectedState("normal")

				arg_242_1.keyicon_.color = Color.New(1, 1, 1)
				arg_242_1.icon_.color = Color.New(1, 1, 1)

				local var_245_3 = arg_242_1:GetWordFromCfg(322242059)
				local var_245_4 = arg_242_1:FormatText(var_245_3.content)

				arg_242_1.text_.text = var_245_4

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_5 = 5
				local var_245_6 = utf8.len(var_245_4)
				local var_245_7 = var_245_5 <= 0 and var_245_1 or var_245_1 * (var_245_6 / var_245_5)

				if var_245_7 > 0 and var_245_1 < var_245_7 then
					arg_242_1.talkMaxDuration = var_245_7

					if var_245_7 + var_245_0 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_7 + var_245_0
					end
				end

				arg_242_1.text_.text = var_245_4
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)
				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_8 = math.max(var_245_1, arg_242_1.talkMaxDuration)

			if var_245_0 <= arg_242_1.time_ and arg_242_1.time_ < var_245_0 + var_245_8 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - var_245_0) / var_245_8

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= var_245_0 + var_245_8 and arg_242_1.time_ < var_245_0 + var_245_8 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {}

		arg_242_1:InitPlayNodeList()
	end,
	Play322242060 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 322242060
		arg_246_1.duration_ = 2

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play322242061(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			local var_249_0 = arg_246_1.actors_["1020ui_story"]
			local var_249_1 = 0

			if var_249_1 < arg_246_1.time_ and arg_246_1.time_ <= var_249_1 + arg_249_0 and not isNil(var_249_0) and arg_246_1.var_.characterEffect1020ui_story == nil then
				arg_246_1.var_.characterEffect1020ui_story = var_249_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_249_2 = 0.200000002980232

			if var_249_1 <= arg_246_1.time_ and arg_246_1.time_ < var_249_1 + var_249_2 and not isNil(var_249_0) then
				local var_249_3 = (arg_246_1.time_ - var_249_1) / var_249_2

				if arg_246_1.var_.characterEffect1020ui_story and not isNil(var_249_0) then
					arg_246_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_246_1.time_ >= var_249_1 + var_249_2 and arg_246_1.time_ < var_249_1 + var_249_2 + arg_249_0 and not isNil(var_249_0) and arg_246_1.var_.characterEffect1020ui_story then
				arg_246_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_249_4 = 0

			if var_249_4 < arg_246_1.time_ and arg_246_1.time_ <= var_249_4 + arg_249_0 then
				arg_246_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action2_2")
			end

			local var_249_5 = 0

			if var_249_5 < arg_246_1.time_ and arg_246_1.time_ <= var_249_5 + arg_249_0 then
				arg_246_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_249_6 = 0
			local var_249_7 = 0.05

			if var_249_6 < arg_246_1.time_ and arg_246_1.time_ <= var_249_6 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, true)

				local var_249_8 = arg_246_1:FormatText(StoryNameCfg[613].name)

				arg_246_1.leftNameTxt_.text = var_249_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_246_1.leftNameTxt_.transform)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1.leftNameTxt_.text)
				SetActive(arg_246_1.iconTrs_.gameObject, false)
				arg_246_1.callingController_:SetSelectedState("normal")

				local var_249_9 = arg_246_1:GetWordFromCfg(322242060)
				local var_249_10 = arg_246_1:FormatText(var_249_9.content)

				arg_246_1.text_.text = var_249_10

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_11 = 2
				local var_249_12 = utf8.len(var_249_10)
				local var_249_13 = var_249_11 <= 0 and var_249_7 or var_249_7 * (var_249_12 / var_249_11)

				if var_249_13 > 0 and var_249_7 < var_249_13 then
					arg_246_1.talkMaxDuration = var_249_13

					if var_249_13 + var_249_6 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_13 + var_249_6
					end
				end

				arg_246_1.text_.text = var_249_10
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322242", "322242060", "story_v_out_322242.awb") ~= 0 then
					local var_249_14 = manager.audio:GetVoiceLength("story_v_out_322242", "322242060", "story_v_out_322242.awb") / 1000

					if var_249_14 + var_249_6 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_14 + var_249_6
					end

					if var_249_9.prefab_name ~= "" and arg_246_1.actors_[var_249_9.prefab_name] ~= nil then
						local var_249_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_246_1.actors_[var_249_9.prefab_name].transform, "story_v_out_322242", "322242060", "story_v_out_322242.awb")

						arg_246_1:RecordAudio("322242060", var_249_15)
						arg_246_1:RecordAudio("322242060", var_249_15)
					else
						arg_246_1:AudioAction("play", "voice", "story_v_out_322242", "322242060", "story_v_out_322242.awb")
					end

					arg_246_1:RecordHistoryTalkVoice("story_v_out_322242", "322242060", "story_v_out_322242.awb")
				end

				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_16 = math.max(var_249_7, arg_246_1.talkMaxDuration)

			if var_249_6 <= arg_246_1.time_ and arg_246_1.time_ < var_249_6 + var_249_16 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - var_249_6) / var_249_16

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= var_249_6 + var_249_16 and arg_246_1.time_ < var_249_6 + var_249_16 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {}

		arg_246_1:InitPlayNodeList()
	end,
	Play322242061 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 322242061
		arg_250_1.duration_ = 5

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
			arg_250_1.auto_ = false
		end

		function arg_250_1.playNext_(arg_252_0)
			arg_250_1.onStoryFinished_()
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			local var_253_0 = arg_250_1.actors_["1020ui_story"]
			local var_253_1 = 0

			if var_253_1 < arg_250_1.time_ and arg_250_1.time_ <= var_253_1 + arg_253_0 and not isNil(var_253_0) and arg_250_1.var_.characterEffect1020ui_story == nil then
				arg_250_1.var_.characterEffect1020ui_story = var_253_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_253_2 = 0.200000002980232

			if var_253_1 <= arg_250_1.time_ and arg_250_1.time_ < var_253_1 + var_253_2 and not isNil(var_253_0) then
				local var_253_3 = (arg_250_1.time_ - var_253_1) / var_253_2

				if arg_250_1.var_.characterEffect1020ui_story and not isNil(var_253_0) then
					local var_253_4 = Mathf.Lerp(0, 0.5, var_253_3)

					arg_250_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_250_1.var_.characterEffect1020ui_story.fillRatio = var_253_4
				end
			end

			if arg_250_1.time_ >= var_253_1 + var_253_2 and arg_250_1.time_ < var_253_1 + var_253_2 + arg_253_0 and not isNil(var_253_0) and arg_250_1.var_.characterEffect1020ui_story then
				local var_253_5 = 0.5

				arg_250_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_250_1.var_.characterEffect1020ui_story.fillRatio = var_253_5
			end

			local var_253_6 = 0
			local var_253_7 = 0.725

			if var_253_6 < arg_250_1.time_ and arg_250_1.time_ <= var_253_6 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, true)

				local var_253_8 = arg_250_1:FormatText(StoryNameCfg[7].name)

				arg_250_1.leftNameTxt_.text = var_253_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_250_1.leftNameTxt_.transform)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1.leftNameTxt_.text)
				SetActive(arg_250_1.iconTrs_.gameObject, true)
				arg_250_1.iconController_:SetSelectedState("hero")

				arg_250_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_250_1.callingController_:SetSelectedState("normal")

				arg_250_1.keyicon_.color = Color.New(1, 1, 1)
				arg_250_1.icon_.color = Color.New(1, 1, 1)

				local var_253_9 = arg_250_1:GetWordFromCfg(322242061)
				local var_253_10 = arg_250_1:FormatText(var_253_9.content)

				arg_250_1.text_.text = var_253_10

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_11 = 29
				local var_253_12 = utf8.len(var_253_10)
				local var_253_13 = var_253_11 <= 0 and var_253_7 or var_253_7 * (var_253_12 / var_253_11)

				if var_253_13 > 0 and var_253_7 < var_253_13 then
					arg_250_1.talkMaxDuration = var_253_13

					if var_253_13 + var_253_6 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_13 + var_253_6
					end
				end

				arg_250_1.text_.text = var_253_10
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)
				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_14 = math.max(var_253_7, arg_250_1.talkMaxDuration)

			if var_253_6 <= arg_250_1.time_ and arg_250_1.time_ < var_253_6 + var_253_14 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_6) / var_253_14

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_6 + var_253_14 and arg_250_1.time_ < var_253_6 + var_253_14 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {}

		arg_250_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST0504",
		"TextureConfig/Background/ST04b",
		"TextureConfig/Background/STblack"
	},
	voices = {
		"story_v_out_322242.awb"
	}
}
